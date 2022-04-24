--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.24
-- Dumped by pg_dump version 9.5.24

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.venda DROP CONSTRAINT venda_id_medicamento_fkey;
ALTER TABLE ONLY public.venda DROP CONSTRAINT venda_cpf_funcionario_responsavel_fkey;
ALTER TABLE ONLY public.venda DROP CONSTRAINT venda_cpf_cliente_fkey;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT fk_funcionario_farmacia;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT fk_farmacia_gerente;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT farmacia_cpf_gerente_fkey;
ALTER TABLE ONLY public.entrega DROP CONSTRAINT entrega_cpf_cliente_fkey;
ALTER TABLE ONLY public.cliente_endereco DROP CONSTRAINT cliente_endereco_cpf_cliente_fkey;
DROP TRIGGER teste ON public.venda;
DROP TRIGGER teste ON public.medicamento;
DROP TRIGGER teste ON public.funcionario;
DROP TRIGGER teste ON public.farmacia;
DROP TRIGGER teste ON public.entrega;
DROP TRIGGER teste ON public.cliente_endereco;
DROP TRIGGER teste ON public.cliente;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT sede_unica;
ALTER TABLE ONLY public.medicamento DROP CONSTRAINT medicamento_pkey;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_pkey;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_cpf_funcao_key;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT farmacia_pkey;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT farmacia_bairro_key;
ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_pkey;
ALTER TABLE ONLY public.cliente_endereco DROP CONSTRAINT cliente_endereco_pkey;
ALTER TABLE public.medicamento ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.farmacia ALTER COLUMN id DROP DEFAULT;
DROP TABLE public.venda;
DROP SEQUENCE public.medicamento_id_seq;
DROP TABLE public.medicamento;
DROP TABLE public.funcionario;
DROP SEQUENCE public.farmacia_id_seq;
DROP TABLE public.farmacia;
DROP TABLE public.entrega;
DROP TABLE public.cliente_endereco;
DROP TABLE public.cliente;
SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cliente; Type: TABLE; Schema: public; Owner: viniciussa
--

CREATE TABLE public.cliente (
    cpf character(11) NOT NULL,
    data_nascimento timestamp without time zone,
    CONSTRAINT cliente_data_nascimento_check CHECK ((age(data_nascimento) > '18 years'::interval))
);


ALTER TABLE public.cliente OWNER TO viniciussa;

--
-- Name: cliente_endereco; Type: TABLE; Schema: public; Owner: viniciussa
--

CREATE TABLE public.cliente_endereco (
    cpf_cliente character(11) NOT NULL,
    tipo character varying(20) NOT NULL,
    cidade character varying(150) NOT NULL,
    bairro character varying(150) NOT NULL,
    rua character varying(150) NOT NULL,
    numero integer NOT NULL,
    CONSTRAINT cliente_endereco_tipo_check CHECK ((((tipo)::text = 'RESIDENCIA'::text) OR ((tipo)::text = 'TRABALHO'::text) OR ((tipo)::text = 'OUTRO'::text)))
);


ALTER TABLE public.cliente_endereco OWNER TO viniciussa;

--
-- Name: entrega; Type: TABLE; Schema: public; Owner: viniciussa
--

CREATE TABLE public.entrega (
    cpf_cliente character(11) NOT NULL,
    tipo_endereco character varying(20),
    cidade character varying(150) NOT NULL,
    bairro character varying(150) NOT NULL,
    rua character varying(150) NOT NULL,
    numero integer NOT NULL
);


ALTER TABLE public.entrega OWNER TO viniciussa;

--
-- Name: farmacia; Type: TABLE; Schema: public; Owner: viniciussa
--

CREATE TABLE public.farmacia (
    id integer NOT NULL,
    tipo_unidade character varying(6) NOT NULL,
    bairro character varying(150),
    cidade character varying(150),
    estado public.estados_possiveis,
    cpf_gerente character(11),
    funcao_gerente character varying(15),
    CONSTRAINT farmacia_funcao_gerente_check CHECK ((((funcao_gerente)::text = 'ADMINISTRADOR'::text) OR ((funcao_gerente)::text = 'FARMACEUTICO'::text))),
    CONSTRAINT farmacia_tipo_unidade_check CHECK ((((tipo_unidade)::text = 'FILIAL'::text) OR ((tipo_unidade)::text = 'SEDE'::text)))
);


ALTER TABLE public.farmacia OWNER TO viniciussa;

--
-- Name: farmacia_id_seq; Type: SEQUENCE; Schema: public; Owner: viniciussa
--

CREATE SEQUENCE public.farmacia_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.farmacia_id_seq OWNER TO viniciussa;

--
-- Name: farmacia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: viniciussa
--

ALTER SEQUENCE public.farmacia_id_seq OWNED BY public.farmacia.id;


--
-- Name: funcionario; Type: TABLE; Schema: public; Owner: viniciussa
--

CREATE TABLE public.funcionario (
    cpf character(11) NOT NULL,
    funcao character varying(15) NOT NULL,
    id_farmacia integer,
    CONSTRAINT funcao_valida CHECK ((((funcao)::text = 'FARMACEUTICO'::text) OR ((funcao)::text = 'VENDEDOR'::text) OR ((funcao)::text = 'ENTREGADOR'::text) OR ((funcao)::text = 'CAIXA'::text) OR ((funcao)::text = 'ADMINISTRADOR'::text) OR ((funcao)::text = 'GERENTE'::text)))
);


ALTER TABLE public.funcionario OWNER TO viniciussa;

--
-- Name: medicamento; Type: TABLE; Schema: public; Owner: viniciussa
--

CREATE TABLE public.medicamento (
    id integer NOT NULL,
    is_venda_exclusiva boolean
);


ALTER TABLE public.medicamento OWNER TO viniciussa;

--
-- Name: medicamento_id_seq; Type: SEQUENCE; Schema: public; Owner: viniciussa
--

CREATE SEQUENCE public.medicamento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.medicamento_id_seq OWNER TO viniciussa;

--
-- Name: medicamento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: viniciussa
--

ALTER SEQUENCE public.medicamento_id_seq OWNED BY public.medicamento.id;


--
-- Name: venda; Type: TABLE; Schema: public; Owner: viniciussa
--

CREATE TABLE public.venda (
    cpf_funcionario_responsavel character(11),
    cpf_cliente character(11),
    funcao_funcionario character varying(15),
    id_medicamento integer,
    is_medicamento_exclusivo boolean,
    CONSTRAINT venda_check CHECK (((NOT is_medicamento_exclusivo) OR (is_medicamento_exclusivo AND (cpf_cliente IS NOT NULL)))),
    CONSTRAINT venda_funcao_funcionario_check CHECK (((funcao_funcionario)::text = 'VENDEDOR'::text))
);


ALTER TABLE public.venda OWNER TO viniciussa;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: viniciussa
--

ALTER TABLE ONLY public.farmacia ALTER COLUMN id SET DEFAULT nextval('public.farmacia_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: viniciussa
--

ALTER TABLE ONLY public.medicamento ALTER COLUMN id SET DEFAULT nextval('public.medicamento_id_seq'::regclass);


--
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: viniciussa
--



--
-- Data for Name: cliente_endereco; Type: TABLE DATA; Schema: public; Owner: viniciussa
--



--
-- Data for Name: entrega; Type: TABLE DATA; Schema: public; Owner: viniciussa
--



--
-- Data for Name: farmacia; Type: TABLE DATA; Schema: public; Owner: viniciussa
--



--
-- Name: farmacia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: viniciussa
--

SELECT pg_catalog.setval('public.farmacia_id_seq', 1, false);


--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: viniciussa
--



--
-- Data for Name: medicamento; Type: TABLE DATA; Schema: public; Owner: viniciussa
--



--
-- Name: medicamento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: viniciussa
--

SELECT pg_catalog.setval('public.medicamento_id_seq', 1, false);


--
-- Data for Name: venda; Type: TABLE DATA; Schema: public; Owner: viniciussa
--



--
-- Name: cliente_endereco_pkey; Type: CONSTRAINT; Schema: public; Owner: viniciussa
--

ALTER TABLE ONLY public.cliente_endereco
    ADD CONSTRAINT cliente_endereco_pkey PRIMARY KEY (cpf_cliente, tipo, cidade, bairro, rua, numero);


--
-- Name: cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: viniciussa
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (cpf);


--
-- Name: farmacia_bairro_key; Type: CONSTRAINT; Schema: public; Owner: viniciussa
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT farmacia_bairro_key UNIQUE (bairro);


--
-- Name: farmacia_pkey; Type: CONSTRAINT; Schema: public; Owner: viniciussa
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT farmacia_pkey PRIMARY KEY (id);


--
-- Name: funcionario_cpf_funcao_key; Type: CONSTRAINT; Schema: public; Owner: viniciussa
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_cpf_funcao_key UNIQUE (cpf, funcao);


--
-- Name: funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: viniciussa
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (cpf);


--
-- Name: medicamento_pkey; Type: CONSTRAINT; Schema: public; Owner: viniciussa
--

ALTER TABLE ONLY public.medicamento
    ADD CONSTRAINT medicamento_pkey PRIMARY KEY (id);


--
-- Name: sede_unica; Type: CONSTRAINT; Schema: public; Owner: viniciussa
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT sede_unica EXCLUDE USING gist (tipo_unidade WITH =) WHERE (((tipo_unidade)::text = 'SEDE'::text));


--
-- Name: teste; Type: TRIGGER; Schema: public; Owner: viniciussa
--

CREATE TRIGGER teste AFTER INSERT OR DELETE OR UPDATE ON public.cliente FOR EACH ROW EXECUTE PROCEDURE public.cliente();


--
-- Name: teste; Type: TRIGGER; Schema: public; Owner: viniciussa
--

CREATE TRIGGER teste AFTER INSERT OR DELETE OR UPDATE ON public.cliente_endereco FOR EACH ROW EXECUTE PROCEDURE public.cliente_endereco();


--
-- Name: teste; Type: TRIGGER; Schema: public; Owner: viniciussa
--

CREATE TRIGGER teste AFTER INSERT OR DELETE OR UPDATE ON public.entrega FOR EACH ROW EXECUTE PROCEDURE public.entrega();


--
-- Name: teste; Type: TRIGGER; Schema: public; Owner: viniciussa
--

CREATE TRIGGER teste AFTER INSERT OR DELETE OR UPDATE ON public.farmacia FOR EACH ROW EXECUTE PROCEDURE public.farmacia();


--
-- Name: teste; Type: TRIGGER; Schema: public; Owner: viniciussa
--

CREATE TRIGGER teste AFTER INSERT OR DELETE OR UPDATE ON public.funcionario FOR EACH ROW EXECUTE PROCEDURE public.funcionario();


--
-- Name: teste; Type: TRIGGER; Schema: public; Owner: viniciussa
--

CREATE TRIGGER teste AFTER INSERT OR DELETE OR UPDATE ON public.medicamento FOR EACH ROW EXECUTE PROCEDURE public.medicamento();


--
-- Name: teste; Type: TRIGGER; Schema: public; Owner: viniciussa
--

CREATE TRIGGER teste AFTER INSERT OR DELETE OR UPDATE ON public.venda FOR EACH ROW EXECUTE PROCEDURE public.venda();


--
-- Name: cliente_endereco_cpf_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: viniciussa
--

ALTER TABLE ONLY public.cliente_endereco
    ADD CONSTRAINT cliente_endereco_cpf_cliente_fkey FOREIGN KEY (cpf_cliente) REFERENCES public.cliente(cpf);


--
-- Name: entrega_cpf_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: viniciussa
--

ALTER TABLE ONLY public.entrega
    ADD CONSTRAINT entrega_cpf_cliente_fkey FOREIGN KEY (cpf_cliente, tipo_endereco, cidade, bairro, rua, numero) REFERENCES public.cliente_endereco(cpf_cliente, tipo, cidade, bairro, rua, numero);


--
-- Name: farmacia_cpf_gerente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: viniciussa
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT farmacia_cpf_gerente_fkey FOREIGN KEY (cpf_gerente, funcao_gerente) REFERENCES public.funcionario(cpf, funcao);


--
-- Name: fk_farmacia_gerente; Type: FK CONSTRAINT; Schema: public; Owner: viniciussa
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT fk_farmacia_gerente FOREIGN KEY (cpf_gerente) REFERENCES public.funcionario(cpf);


--
-- Name: fk_funcionario_farmacia; Type: FK CONSTRAINT; Schema: public; Owner: viniciussa
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT fk_funcionario_farmacia FOREIGN KEY (id_farmacia) REFERENCES public.farmacia(id);


--
-- Name: venda_cpf_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: viniciussa
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT venda_cpf_cliente_fkey FOREIGN KEY (cpf_cliente) REFERENCES public.cliente(cpf);


--
-- Name: venda_cpf_funcionario_responsavel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: viniciussa
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT venda_cpf_funcionario_responsavel_fkey FOREIGN KEY (cpf_funcionario_responsavel) REFERENCES public.funcionario(cpf);


--
-- Name: venda_id_medicamento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: viniciussa
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT venda_id_medicamento_fkey FOREIGN KEY (id_medicamento) REFERENCES public.medicamento(id);


--
-- PostgreSQL database dump complete
--



----------------------------------------------------------------------------
----------------------------------------------------------------------------

-- --------- DEVEM FUNCIONAR ---------
-- INSERT INTO funcionario VALUES (
--     '06408847412',
--     'FARMACEUTICO',
--     NULL
-- );

-- INSERT INTO funcionario VALUES (
--     '12345678910',
--     'ADMINISTRADOR',
--     NULL
-- );

-- INSERT INTO funcionario VALUES (
--     '12345678911',
--     'FARMACEUTICO',
--     NULL
-- );

-- INSERT INTO funcionario VALUES (
--     '12345678912',
--     'CAIXA',
--     NULL
-- );

-- INSERT INTO funcionario VALUES (
--     '12345678913',
--     'VENDEDOR',
--     NULL
-- );

-- INSERT INTO cliente VALUES (
--     '12345611110',
--     '2002-05-21'
-- );

-- INSERT INTO cliente_endereco VALUES (
--     '12345611110',
--     'RESIDENCIA',
--     'joao pessoa',
--     'expedicionarios',
--     'silvio almeida',
--     522
-- );

-- INSERT INTO cliente_endereco VALUES (
--     '12345611110',
--     'OUTRO',
--     'joao pessoa',
--     'emandacaru',
--     'retao de manaira',
--     557
-- );

-- INSERT INTO farmacia VALUES (
--     1,
--     'SEDE',
--     'expedicionarios',
--     'joao pessoa',
--     'PARAIBA',
--     '06408847412',
--     'FARMACEUTICO'
-- );

-- INSERT INTO farmacia VALUES (
--     2,
--     'FILIAL',
--     'bancarios',
--     'joao pessoa',
--     'PARAIBA',
--     '12345678910',
--     'ADMINISTRADOR'
-- );

-- INSERT INTO farmacia VALUES (
--     3,
--     'FILIAL',
--     'manaira',
--     'joao pessoa',
--     'PARAIBA',
--     '12345678911',
--     'FARMACEUTICO'
-- );

-- UPDATE funcionario SET id_farmacia = 1 WHERE cpf = '06408847412' OR cpf = '12345678912';
-- UPDATE funcionario SET id_farmacia = 2 WHERE cpf = '12345678910' OR cpf = '12345678913';
-- UPDATE funcionario SET id_farmacia = 3 WHERE cpf = '12345678911';

-- INSERT INTO medicamento VALUES (
--     1,
--     'TRUE'
-- );

-- INSERT INTO medicamento VALUES (
--     2,
--     'FALSE'
-- );

-- INSERT INTO entrega VALUES (
--     '12345611110',
--     'RESIDENCIA',
--     'joao pessoa',
--     'expedicionarios',
--     'silvio almeida',
--     522
-- );

-- INSERT into venda VALUES (
--     '12345678913',
--     '12345611110',
--     'VENDEDOR',
--     1,
--     'TRUE'
-- );

-- INSERT into venda VALUES (
--     '12345678913',
--     NULL,
--     'VENDEDOR',
--     2,
--     'FALSE'
-- );

-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------

-- --------- NÃO DEVEM FUNCIONAR ---------

-- -- Pois Não deve haver sedes repetidas

-- INSERT INTO farmacia VALUES (
--     4,
--     'SEDE',
--     'Bairro dos ipês',
--     'joao pessoa',
--     'PARAIBA',
--     '12345678910',
--     'ADMINISTRADOR'
-- );

-- -- Pois 'MOTOBOY' não é uma função válida

-- INSERT INTO funcionario VALUES (
--     '12345678919',
--     'MOTOBOY',
--     3
-- );

-- -- Pois entregas são realizadas apenas para clientes cadastrados

-- INSERT INTO entrega VALUES (
--     NULL,
--     'RESIDENCIA',
--     'joao pessoa',
--     'expedicionarios',
--     'silvio almeida',
--     522
-- );

-- -- Pois não deve ser possível excluir um funcionario vinculado a uma venda

-- DELETE FROM funcionario WHERE cpf = '12345678913';

-- -- Pois não deve ser possível excluir um medicamento vinculado a uma venda

-- DELETE FROM medicamento WHERE id = 1;

-- -- Pois não deve ser permitido cadastro de clientes menores de idade

-- INSERT INTO cliente VALUES (
--     '12345611119',
--     '2012-05-21'
-- );

-- -- Pois só deve haver uma farmácia por bairro

-- INSERT INTO farmacia VALUES (
--     5,
--     'FILIAL',
--     'manaira',
--     'joao pessoa',
--     'PARAIBA',
--     '12345678911',
--     'FARMACEUTICO'
-- );

-- -- Pois gerentes podem ser apenas administradores ou farmaceuticos

-- INSERT INTO farmacia VALUES (
--     5,
--     'FILIAL',
--     'bodocongó',
--     'campina grande',
--     'PARAIBA',
--     '12345678912',
--     'CAIXA'
-- );

-- -- Pois medicamentos com venda exclusiva só devem ser vendidos a clientes cadastrados

-- INSERT into venda VALUES (
--     '12345678912',
--     NULL,
--     'VENDEDOR',
--     1,
--     'TRUE'
-- );

-- -- pois uma venda só pode ser feita por um funcionario vendedor

-- INSERT into venda VALUES (
--     '12345678912',
--     NULL,
--     'CAIXA',
--     2,
--     'FALSE'
-- );

-- -- pois a farmacia deve estar dentro de um dos 9 estados nordestinos

-- INSERT INTO farmacia VALUES (
--     4,
--     'FILIAL',
--     'Leblon',
--     'Rio de Janeiro',
--     'RIO DE JANEIRO',
--     '12345678912',
--     'CAIXA'
-- );
