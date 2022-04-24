-- questão 1

-- AUTOMOVEL: placa, cpf segurado, marca, modelo
-- SEGURADO: cpf, nome, telefone
-- PERITO: cpf, nome, telefone
-- OFICINA: cidade, bairro, rua, número
-- SEGURO: placa do automóvel, cpf do segurado, data de contratação, data de vencimento, cobre danos?, cobre roubo?, cpf do comprador do seguro, valor do prêmio
-- SINISTRO: id, placa do automovel, foi roubo?, foi dano?, hora do ocorrido, cidade, bairro, rua
-- PERICIA: id, cpf do perito, será possível consertar o veículo?, foi perda total?
-- REPARO: id, endereço da oficina, preço, prazo

-- questão 2

CREATE TABLE automovel (
    placa char(7),
    cpf_segurado char(11),
    marca varchar(100),
    modelo varchar(100)
);

CREATE TABLE segurado (
    cpf char(11),
    nome varchar(150),
    telefone char(11)
);

CREATE TABLE perito (
    cpf char(11),
    nome varchar(150),
    telefone char(11)
);

CREATE TABLE oficina (
    cidade varchar(150),
    bairro varchar(150),
    rua varchar(150),
    numero integer
);

CREATE TABLE seguro (
    placa_automovel char(7),
    cpf_segurado char(11),
    data_contratação date,
    data_vencimento date,
    cobre_danos boolean,
    cobre_roubo boolean,
    cpf_comprador char(11),
    valor_premio_total numeric
);

CREATE TABLE sinistro (
    id serial,
    placa_automovel char(7),
    is_roubo boolean,
    is_dano boolean,
    hora timestamp,
    cidade varchar(150),
    bairro varchar(150),
    rua varchar(150)
);

CREATE TABLE pericia (
    id serial,
    cpf_perito char(11),
    is_conserto_possivel boolean,
    is_perda_total boolean
);

CREATE TABLE reparo (
    id serial,
    cidade_oficina varchar(150),
    bairro_oficina varchar(150),
    rua_oficina varchar(150),
    numero_oficina integer,
    preco numeric,
    prazo date
);

-- questão 3

ALTER TABLE automovel ADD PRIMARY KEY (placa);
ALTER TABLE segurado ADD PRIMARY KEY (cpf);
ALTER TABLE perito ADD PRIMARY KEY (cpf);
ALTER TABLE oficina ADD PRIMARY KEY (cidade, bairro, rua, numero);
ALTER TABLE seguro ADD PRIMARY KEY (placa_automovel);
ALTER TABLE sinistro ADD PRIMARY KEY (id);
ALTER TABLE pericia ADD PRIMARY KEY (id);
ALTER TABLE reparo ADD PRIMARY KEY (id);

-- questão 4

ALTER TABLE automovel ADD CONSTRAINT fk_automovel_segurado FOREIGN KEY (cpf_segurado) REFERENCES segurado (cpf);
ALTER TABLE seguro ADD CONSTRAINT fk_seguro_automovel FOREIGN KEY (placa_automovel) REFERENCES automovel (placa);
ALTER TABLE pericia ADD CONSTRAINT fk_pericia_perito FOREIGN KEY (cpf_perito) REFERENCES perito (cpf);
ALTER TABLE reparo ADD CONSTRAINT fk_reparo_oficina FOREIGN KEY (cidade_oficina, bairro_oficina, rua_oficina, numero_oficina) REFERENCES oficina (cidade, bairro, rua, numero);
ALTER TABLE sinistro ADD CONSTRAINT fk_sinistro_automovel FOREIGN KEY (placa_automovel) REFERENCES automovel (placa);


-- questão 5

-- Atributos adicionais: 
-- SEGURADO: email, endereço
-- PERITO: email
-- OFICINA: telefone, responsável pela oficina, email
-- SEGURO: valor da franquia, possui cobertura contra terceiros?
-- SINISTRO: descrição da ocorrencia, segurado foi responsável pela ocorrência?
-- PERICIA: valor de mercado atual do veículo
-- REPARO: forma de pagamento

-- Atributos não nulos (com exceção das chaves, que já estão como não nulas):
-- AUTOMOVEL: cpf segurado (já que o automóvel só faz sentido com base em um segurado nesse sistema de seguros), marca, modelo
-- SEGURADO: nome, telefone, endereço
-- PERITO: nome, telefone
-- OFICINA: telefone, responsável
-- SEGURO: cpf do segurado, data de contratação, data de vencimento, cobre danos?, cobre roubo?, cpf do comprador, valor do prêmio, valor da franquia, possui cobertura contra terceiros?
-- SINISTRO: placa, foi roubo?, foi dano?, endereço do ocorrido, segurado foi responsável?
-- PERICIA: cpf do perito, será possível concertar?, foi perda total?
-- REPARO: endereço da oficina, preço, prazo

-- questão 6

DROP TABLE sinistro, pericia, perito, reparo, oficina, seguro, automovel, segurado;

-- questão 7

CREATE TABLE automovel (
    placa char(7) PRIMARY KEY,
    cpf_segurado char(11) REFERENCES segurado (cpf) NOT NULL,
    marca varchar(100) NOT NULL,
    modelo varchar(100) NOT NULL
);

CREATE TABLE segurado (
    cpf char(11) PRIMARY KEY,
    nome varchar(150) NOT NULL,
    telefone char(11) NOT NULL
);

CREATE TABLE perito (
    cpf char(11) PRIMARY KEY,
    nome varchar(150) NOT NULL,
    telefone char(11) NOT NULL
);

CREATE TABLE oficina (
    cidade varchar(150),
    bairro varchar(150),
    rua varchar(150),
    numero integer,
    CONSTRAINT endereco_oficina PRIMARY KEY (cidade, bairro, rua, numero)
);

CREATE TABLE seguro (
    placa_automovel char(7) PRIMARY KEY REFERENCES automovel (placa),
    cpf_segurado char(11) NOT NULL,
    data_contratação date NOT NULL,
    data_vencimento date NOT NULL,
    cobre_danos boolean NOT NULL,
    cobre_roubo boolean NOT NULL,
    cpf_comprador char(11) NOT NULL,
    valor_premio_total numeric NOT NULL
);

CREATE TABLE sinistro (
    id serial PRIMARY KEY,
    placa_automovel char(7) REFERENCES automovel (placa) NOT NULL,
    is_roubo boolean NOT NULL,
    is_dano boolean NOT NULL,
    hora timestamp,
    cidade varchar(150) NOT NULL,
    bairro varchar(150) NOT NULL,
    rua varchar(150) NOT NULL
);

CREATE TABLE pericia (
    id serial PRIMARY KEY,
    cpf_perito char(11) REFERENCES perito (cpf) NOT NULL,
    is_conserto_possivel boolean NOT NULL,
    is_perda_total boolean NOT NULL
);

CREATE TABLE reparo (
    id serial PRIMARY KEY,
    cidade_oficina varchar(150) NOT NULL,
    bairro_oficina varchar(150) NOT NULL,
    rua_oficina varchar(150) NOT NULL,
    numero_oficina integer NOT NULL,
    preco numeric NOT NULL,
    prazo date NOT NULL,
    FOREIGN KEY (cidade_oficina, bairro_oficina, rua_oficina, numero_oficina) REFERENCES oficina (cidade, bairro, rua, numero)
);

-- Questão 8

CREATE TABLE segurado (
    cpf char(11) PRIMARY KEY,
    nome varchar(150) NOT NULL,
    telefone char(11) NOT NULL
);

CREATE TABLE automovel (
    placa char(7) PRIMARY KEY,
    cpf_segurado char(11) REFERENCES segurado (cpf) NOT NULL,
    marca varchar(100) NOT NULL,
    modelo varchar(100) NOT NULL
);

CREATE TABLE perito (
    cpf char(11) PRIMARY KEY,
    nome varchar(150) NOT NULL,
    telefone char(11) NOT NULL
);

CREATE TABLE oficina (
    cidade varchar(150),
    bairro varchar(150),
    rua varchar(150),
    numero integer,
    CONSTRAINT endereco_oficina PRIMARY KEY (cidade, bairro, rua, numero)
);

CREATE TABLE seguro (
    placa_automovel char(7) PRIMARY KEY REFERENCES automovel (placa),
    cpf_segurado char(11) NOT NULL,
    data_contratação date NOT NULL,
    data_vencimento date NOT NULL,
    cobre_danos boolean NOT NULL,
    cobre_roubo boolean NOT NULL,
    cpf_comprador char(11) NOT NULL,
    valor_premio_total numeric NOT NULL
);

CREATE TABLE sinistro (
    id serial PRIMARY KEY,
    placa_automovel char(7) REFERENCES automovel (placa) NOT NULL,
    is_roubo boolean NOT NULL,
    is_dano boolean NOT NULL,
    hora timestamp,
    cidade varchar(150) NOT NULL,
    bairro varchar(150) NOT NULL,
    rua varchar(150) NOT NULL
);

CREATE TABLE pericia (
    id serial PRIMARY KEY,
    cpf_perito char(11) REFERENCES perito (cpf) NOT NULL,
    is_conserto_possivel boolean NOT NULL,
    is_perda_total boolean NOT NULL
);

CREATE TABLE reparo (
    id serial PRIMARY KEY,
    cidade_oficina varchar(150) NOT NULL,
    bairro_oficina varchar(150) NOT NULL,
    rua_oficina varchar(150) NOT NULL,
    numero_oficina integer NOT NULL,
    preco numeric NOT NULL,
    prazo date NOT NULL,
    FOREIGN KEY (cidade_oficina, bairro_oficina, rua_oficina, numero_oficina) REFERENCES oficina (cidade, bairro, rua, numero)
);

-- Questão 9

DROP TABLE sinistro, pericia, perito, reparo, oficina, seguro, automovel, segurado;

-- Questão 10

-- Acredito que definiria uma tabela para guardar as informações do comprador do seguro

CREATE TABLE comprador (
    cpf char(11) PRIMARY KEY,
    nome varchar(150),
    telefone char(11)
);
-- Com isso, o seguro iria passar a possuir uma chave estrangeira que aponte para o cpf do comprador nesta tabela