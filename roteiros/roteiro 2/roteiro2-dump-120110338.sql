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

ALTER TABLE ONLY public.tarefas DROP CONSTRAINT fk_tarefas_funcionario;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT fk_funcionario_superior;
DROP TRIGGER teste ON public.tarefas;
DROP TRIGGER teste ON public.funcionario;
ALTER TABLE ONLY public.tarefas DROP CONSTRAINT tarefas_pkey;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_pkey;
DROP TABLE public.tarefas;
DROP TABLE public.funcionario;
SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: funcionario; Type: TABLE; Schema: public; Owner: viniciussa
--

CREATE TABLE public.funcionario (
    cpf character(11) NOT NULL,
    data_nasc date NOT NULL,
    nome character varying(150) NOT NULL,
    funcao character varying(150) NOT NULL,
    nivel character(1) NOT NULL,
    superior_cpf character(11),
    CONSTRAINT funcao_valida CHECK ((((funcao)::text = 'LIMPEZA'::text) OR ((funcao)::text = 'SUP_LIMPEZA'::text))),
    CONSTRAINT nivel_valido CHECK (((nivel = 'J'::bpchar) OR (nivel = 'P'::bpchar) OR (nivel = 'S'::bpchar))),
    CONSTRAINT superior_limpeza_valido CHECK ((((funcao)::text <> 'LIMPEZA'::text) OR ((superior_cpf IS NOT NULL) AND ((funcao)::text = 'LIMPEZA'::text))))
);


ALTER TABLE public.funcionario OWNER TO viniciussa;

--
-- Name: tarefas; Type: TABLE; Schema: public; Owner: viniciussa
--

CREATE TABLE public.tarefas (
    id bigint NOT NULL,
    descricao character varying(300) NOT NULL,
    func_resp_cpf character(11),
    prioridade smallint NOT NULL,
    status character(1) NOT NULL,
    CONSTRAINT planejamento_sem_cpf CHECK ((((status = 'C'::bpchar) AND (func_resp_cpf IS NOT NULL)) OR ((status = 'E'::bpchar) AND (func_resp_cpf IS NOT NULL)) OR (status = 'P'::bpchar))),
    CONSTRAINT prioridade_valida CHECK (((prioridade >= 0) AND (prioridade <= 5)))
);


ALTER TABLE public.tarefas OWNER TO viniciussa;

--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: viniciussa
--

INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678913', '1980-05-05', 'Vinicius Azevedo', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678920', '1980-12-01', 'Vandeilton Santos', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678914', '1983-10-08', 'Mayra Carmeli', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678916', '1980-04-12', 'Anabelle Sousa', 'LIMPEZA', 'P', '12345678914');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678917', '1980-12-09', 'Ivoneide dos Santos', 'LIMPEZA', 'P', '12345678914');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678922', '1980-02-12', 'Alef Adonis', 'SUP_LIMPEZA', 'P', '12345678920');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678919', '1980-01-10', 'Joaci Herculano', 'LIMPEZA', 'P', '12345678914');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678915', '1987-06-06', 'Deborah Maria', 'LIMPEZA', 'J', '12345678914');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678921', '1980-11-10', 'Kilian Melcher', 'LIMPEZA', 'J', '12345678920');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678918', '1980-04-04', 'José Batista', 'LIMPEZA', 'J', '12345678914');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678912', '1980-03-08', 'Jose da Silva', 'LIMPEZA', 'P', '12345678914');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('32323232911', '1994-07-13', 'Pepper Potts', 'LIMPEZA', 'P', '12345678914');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432111', '1995-07-13', 'Bruce Banner', 'LIMPEZA', 'P', '12345678914');


--
-- Data for Name: tarefas; Type: TABLE DATA; Schema: public; Owner: viniciussa
--

INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483653, 'limpar portas do 1o andar', '32323232911', 2, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483646, 'limpar chão do corredor central', '98765432111', 0, 'C');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483651, 'limpar portas do 1o andar', '32323232911', 5, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483652, 'limpar portas do 2o andar', '32323232911', 5, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483647, 'limpar janelas da sala 203', '12345678916', 1, 'E');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483648, 'limpar portas do térreo', NULL, 4, 'P');


--
-- Name: funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: viniciussa
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (cpf);


--
-- Name: tarefas_pkey; Type: CONSTRAINT; Schema: public; Owner: viniciussa
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT tarefas_pkey PRIMARY KEY (id);


--
-- Name: teste; Type: TRIGGER; Schema: public; Owner: viniciussa
--

CREATE TRIGGER teste AFTER INSERT OR DELETE OR UPDATE ON public.funcionario FOR EACH ROW EXECUTE PROCEDURE public.funcionario();


--
-- Name: teste; Type: TRIGGER; Schema: public; Owner: viniciussa
--

CREATE TRIGGER teste AFTER INSERT OR DELETE OR UPDATE ON public.tarefas FOR EACH ROW EXECUTE PROCEDURE public.tarefas();


--
-- Name: fk_funcionario_superior; Type: FK CONSTRAINT; Schema: public; Owner: viniciussa
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT fk_funcionario_superior FOREIGN KEY (superior_cpf) REFERENCES public.funcionario(cpf);


--
-- Name: fk_tarefas_funcionario; Type: FK CONSTRAINT; Schema: public; Owner: viniciussa
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT fk_tarefas_funcionario FOREIGN KEY (func_resp_cpf) REFERENCES public.funcionario(cpf) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

