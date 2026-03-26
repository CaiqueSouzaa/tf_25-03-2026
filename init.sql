-- Criação da tabela de autores
CREATE TABLE IF NOT EXISTS public.tb_autores
(
    id bigserial NOT NULL,
    nome character varying(250) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT tb_autores_pkey PRIMARY KEY (id)
);

-- Criação da tabela de livros
CREATE TABLE public.livros
(
    id bigserial NOT NULL,
    titulo character varying(250) NOT NULL,
    isbn character varying(250) NOT NULL,
    ano_publicacao timestamp without time zone NOT NULL,
    id_author bigserial NOT NULL,
    CONSTRAINT pk_id PRIMARY KEY (id),
    CONSTRAINT fk_author FOREIGN KEY (id_author)
        REFERENCES public.tb_autores (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

-- Inserção de autores author
INSERT INTO public.tb_autores (nome) VALUES
('Machado de Assis'),
('Clarice Lispector'),
('Jorge Amado'),
('Monteiro Lobato'),
('Graciliano Ramos'),
('José de Alencar'),
('Carlos Drummond de Andrade'),
('Érico Veríssimo'),
('Guimarães Rosa'),
('Lygia Fagundes Telles');

-- Esperado que ocorra erro - Tentando inserir um livro com o ID de um author que não existe
/*
    ERROR:  insert or update on table "livros" violates foreign key constraint "fk_author"
    Key (id_author)=(11) is not present in table "tb_autores". 

    SQL state: 23503
    Detail: Key (id_author)=(11) is not present in table "tb_autores".
*/
-- Explicação do erro: O erro ocorre pois o ID de usuário "11" realmente não existe, impossibilitando assim sua correta inserção.
DO $$
BEGIN
    INSERT INTO public.livros (titulo, isbn, ano_publicacao, id_author)
    VALUES ('Antes do Baile Verde', '978-85-359-0307-9', '1970-01-01', 11);
EXCEPTION
    WHEN foreign_key_violation THEN
        RAISE NOTICE 'Erro esperado ignorado: FK inválida';
END
$$;

-- Inserção de livros
INSERT INTO public.livros (titulo, isbn, ano_publicacao, id_author) VALUES
('Dom Casmurro', '978-85-359-0277-5', '1899-01-01', 1),
('Memórias Póstumas de Brás Cubas', '978-85-359-0276-8', '1881-01-01', 1),
('A Hora da Estrela', '978-85-359-0280-5', '1977-01-01', 2),
('Laços de Família', '978-85-359-0281-2', '1960-01-01', 2),
('Gabriela, Cravo e Canela', '978-85-359-0282-9', '1958-01-01', 3),
('Capitães da Areia', '978-85-359-0283-6', '1937-01-01', 3),
('Reinações de Narizinho', '978-85-359-0284-3', '1931-01-01', 4),
('Sítio do Picapau Amarelo', '978-85-359-0285-0', '1920-01-01', 4),
('Vidas Secas', '978-85-359-0286-7', '1938-01-01', 5),
('São Bernardo', '978-85-359-0287-4', '1934-01-01', 5),
('Iracema', '978-85-359-0288-1', '1865-01-01', 6),
('O Guarani', '978-85-359-0289-8', '1857-01-01', 6),
('Sentimento do Mundo', '978-85-359-0290-4', '1940-01-01', 7),
('A Rosa do Povo', '978-85-359-0291-1', '1945-01-01', 7),
('O Tempo e o Vento', '978-85-359-0292-8', '1949-01-01', 8),
('Incidente em Antares', '978-85-359-0293-5', '1971-01-01', 8),
('Grande Sertão: Veredas', '978-85-359-0294-2', '1956-01-01', 9),
('Sagarana', '978-85-359-0295-9', '1946-01-01', 9),
('As Meninas', '978-85-359-0296-6', '1973-01-01', 10),
('Ciranda de Pedra', '978-85-359-0297-3', '1954-01-01', 10),
('Helena', '978-85-359-0298-0', '1876-01-01', 1),
('A Paixão Segundo G.H.', '978-85-359-0299-7', '1964-01-01', 2),
('Dona Flor e Seus Dois Maridos', '978-85-359-0300-0', '1966-01-01', 3),
('O Picapau Amarelo', '978-85-359-0301-7', '1939-01-01', 4),
('Angústia', '978-85-359-0302-4', '1936-01-01', 5),
('Senhora', '978-85-359-0303-1', '1875-01-01', 6),
('Claro Enigma', '978-85-359-0304-8', '1951-01-01', 7),
('Música ao Longe', '978-85-359-0305-5', '1935-01-01', 8),
('Primeiras Estórias', '978-85-359-0306-2', '1962-01-01', 9),
('Antes do Baile Verde', '978-85-359-0307-9', '1970-01-01', 10),
('Antes do Baile Verde', '978-85-359-0307-9', '2025-01-01', 10);

-- Buscando somente pelo título dos livros
SELECT titulo FROM public.livros;

-- Buscando pelos livros cuja a data de publicação é maior que 2020
SELECT * FROM public.livros WHERE ano_publicacao > '2020-01-01';