CREATE TYPE estados_possiveis AS ENUM ('PIAUI', 'MARANHAO', 'ALAGOAS', 'SERGIPE', 'BAHIA', 'PERNAMBUCO', 'PARAIBA', 'RIO GRANDE DO NORTE', 'CEARA');

CREATE TABLE funcionario (
    cpf char(11) PRIMARY KEY,
    funcao varchar(15) NOT NULL,
    id_farmacia integer,
    UNIQUE (cpf, funcao)
);

ALTER TABLE funcionario ADD CONSTRAINT funcao_valida CHECK (funcao = 'FARMACEUTICO' OR funcao = 'VENDEDOR' OR funcao = 'ENTREGADOR' OR funcao = 'CAIXA' OR funcao = 'ADMINISTRADOR' OR funcao = 'GERENTE');

CREATE TABLE farmacia (
    id serial PRIMARY KEY,
    tipo_unidade varchar(6) NOT NULL,
    bairro varchar(150) UNIQUE,
    cidade varchar(150),
    estado estados_possiveis,
    cpf_gerente char(11),
    funcao_gerente varchar(15),
    FOREIGN KEY (cpf_gerente, funcao_gerente) REFERENCES funcionario (cpf, funcao),
    CHECK (funcao_gerente = 'ADMINISTRADOR' OR funcao_gerente = 'FARMACEUTICO'),
    CHECK (tipo_unidade = 'FILIAL' OR tipo_unidade = 'SEDE')
);

ALTER TABLE funcionario ADD CONSTRAINT fk_funcionario_farmacia FOREIGN KEY (id_farmacia) REFERENCES farmacia (id);

ALTER TABLE farmacia ADD CONSTRAINT fk_farmacia_gerente FOREIGN KEY (cpf_gerente) REFERENCES funcionario (cpf);

ALTER TABLE farmacia ADD CONSTRAINT sede_unica EXCLUDE USING gist (tipo_unidade WITH =) WHERE (tipo_unidade = 'SEDE');

CREATE TABLE cliente (
    cpf char(11) PRIMARY KEY,
    data_nascimento timestamp,
    CHECK (AGE(data_nascimento) > '18 years')
);

CREATE TABLE medicamento (
    id serial PRIMARY KEY,
    is_venda_exclusiva boolean
);

CREATE TABLE venda (
    cpf_funcionario_responsavel char(11) REFERENCES funcionario (cpf),
    cpf_cliente char(11) REFERENCES cliente (cpf),
    funcao_funcionario varchar(15),
    id_medicamento integer REFERENCES medicamento (id),
    is_medicamento_exclusivo boolean,
    CHECK (funcao_funcionario = 'VENDEDOR'),
    CHECK (NOT is_medicamento_exclusivo OR (is_medicamento_exclusivo AND (cpf_cliente IS NOT NULL)))
);

CREATE TABLE cliente_endereco (
    cpf_cliente char(11) REFERENCES cliente (cpf),
    tipo varchar(20) NOT NULL CHECK (tipo = 'RESIDENCIA' OR tipo = 'TRABALHO' OR tipo = 'OUTRO'),
    cidade varchar(150),
    bairro varchar(150),
    rua varchar(150),
    numero integer,
    PRIMARY KEY (cpf_cliente, tipo, cidade, bairro, rua, numero)
);

CREATE TABLE entrega (
    cpf_cliente char(11) NOT NULL,
    tipo_endereco varchar(20),
    cidade varchar(150) NOT NULL,
    bairro varchar(150) NOT NULL,
    rua varchar(150) NOT NULL,
    numero integer NOT NULL,
    FOREIGN KEY (cpf_cliente, tipo_endereco, cidade, bairro, rua, numero) REFERENCES cliente_endereco (cpf_cliente, tipo, cidade, bairro, rua, numero)
);

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