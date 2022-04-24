CREATE TABLE EQUIPE (
    id serial  NOT NULL,
    nome_treinador varchar(255)  NOT NULL,
    nome varchar(255)  NOT NULL,
    cpf_treinador char(11)  NOT NULL,
    CONSTRAINT EQUIPE_pk PRIMARY KEY (id)
);

CREATE TABLE JOGADOR (
    cpf char(11)  NOT NULL,
    nome varchar(255)  NOT NULL,
    posicao_padrao varchar(50)  NOT NULL,
    CONSTRAINT JOGADOR_pk PRIMARY KEY (cpf)
);

CREATE TABLE JOGO (
    id serial  NOT NULL,
    time1_id int  NOT NULL,
    time2_id int  NOT NULL,
    data date  NOT NULL,
    CONSTRAINT JOGO_pk PRIMARY KEY (id)
);

CREATE TABLE MEMBRO_DA (
    cpf_jogador char(11)  NOT NULL,
    time_id int  NOT NULL,
    data_inicio date  NOT NULL,
    data_fim date  NOT NULL,
    CONSTRAINT MEMBRO_DA_pk PRIMARY KEY (cpf_jogador)
);

CREATE TABLE PARTICIPA_DO (
    cpf_jogador char(11)  NOT NULL,
    jogo_id int  NOT NULL,
    posicao varchar(50)  NOT NULL,
    entrou_em_quadra boolean  NOT NULL,
    foi_substituido boolean  NOT NULL,
    cestas_1_ponto int  NOT NULL,
    cestas_2_pontos int  NOT NULL,
    cestas_3_pontos int  NOT NULL
);

ALTER TABLE PARTICIPA_DO ADD CONSTRAINT JOGOU_EM_JOGADOR
    FOREIGN KEY (cpf_jogador)
    REFERENCES JOGADOR (cpf)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

ALTER TABLE PARTICIPA_DO ADD CONSTRAINT JOGOU_EM_JOGO
    FOREIGN KEY (jogo_id)
    REFERENCES JOGO (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

ALTER TABLE MEMBRO_DA ADD CONSTRAINT MEMBRO_DA_EQUIPE
    FOREIGN KEY (time_id)
    REFERENCES EQUIPE (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

ALTER TABLE MEMBRO_DA ADD CONSTRAINT MEMBRO_DA_JOGADOR
    FOREIGN KEY (cpf_jogador)
    REFERENCES JOGADOR (cpf)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

INSERT INTO EQUIPE (nome, nome_treinador, cpf_treinador) VALUES ('Flamengo', 'Link Mineiro', '06408847412');
INSERT INTO JOGADOR (cpf, nome, posicao_padrao) VALUES ('12345678901', 'Vinicius Azevedo', 'PIVO');
INSERT INTO JOGADOR (cpf, nome, posicao_padrao) VALUES ('12345678902', 'Kilian Melcher', 'ARMADOR');
INSERT INTO JOGADOR (cpf, nome, posicao_padrao) VALUES ('12345678903', 'Alef Adonis', 'ALA ARMADOR');
INSERT INTO JOGADOR (cpf, nome, posicao_padrao) VALUES ('12345678904', 'Pedro Adrian', 'ALA');
INSERT INTO JOGADOR (cpf, nome, posicao_padrao) VALUES ('12345678905', 'Filipe Ramalho', 'ALA PIVO');
INSERT INTO JOGADOR (cpf, nome, posicao_padrao) VALUES ('12345678906', 'Deborah Maria', 'PIVO');
INSERT INTO JOGADOR (cpf, nome, posicao_padrao) VALUES ('12345678907', 'Ulisses Guimaraes', 'ARMADOR');
INSERT INTO JOGADOR (cpf, nome, posicao_padrao) VALUES ('12345678908', 'Michael Jackson', 'ALA ARMADOR');
INSERT INTO JOGADOR (cpf, nome, posicao_padrao) VALUES ('12345678909', 'Maria das Graças', 'ALA');
INSERT INTO JOGADOR (cpf, nome, posicao_padrao) VALUES ('12345678900', 'Joao Gomes', 'ALA PIVO');
INSERT INTO JOGADOR (cpf, nome, posicao_padrao) VALUES ('12345678911', 'Marilia Mendonca', 'PIVO');
INSERT INTO JOGADOR (cpf, nome, posicao_padrao) VALUES ('12345678912', 'Estevao Figueiredo', 'ALA PIVO');

INSERT INTO MEMBRO_DA (cpf_jogador, time_id, data_inicio, data_fim) VALUES ('12345678901', 1, '03-09-2022', '03-09-2024');
INSERT INTO MEMBRO_DA (cpf_jogador, time_id, data_inicio, data_fim) VALUES ('12345678902', 1, '03-09-2022', '03-09-2024');
INSERT INTO MEMBRO_DA (cpf_jogador, time_id, data_inicio, data_fim) VALUES ('12345678903', 1, '03-09-2022', '03-09-2024');
INSERT INTO MEMBRO_DA (cpf_jogador, time_id, data_inicio, data_fim) VALUES ('12345678904', 1, '03-09-2022', '03-09-2024');
INSERT INTO MEMBRO_DA (cpf_jogador, time_id, data_inicio, data_fim) VALUES ('12345678905', 1, '03-09-2022', '03-09-2024');
INSERT INTO MEMBRO_DA (cpf_jogador, time_id, data_inicio, data_fim) VALUES ('12345678906', 1, '03-09-2022', '03-09-2024');
INSERT INTO MEMBRO_DA (cpf_jogador, time_id, data_inicio, data_fim) VALUES ('12345678907', 1, '03-09-2022', '03-09-2024');
INSERT INTO MEMBRO_DA (cpf_jogador, time_id, data_inicio, data_fim) VALUES ('12345678908', 1, '03-09-2022', '03-09-2024');
INSERT INTO MEMBRO_DA (cpf_jogador, time_id, data_inicio, data_fim) VALUES ('12345678909', 1, '03-09-2022', '03-09-2024');
INSERT INTO MEMBRO_DA (cpf_jogador, time_id, data_inicio, data_fim) VALUES ('12345678900', 1, '03-09-2022', '03-09-2024');
INSERT INTO MEMBRO_DA (cpf_jogador, time_id, data_inicio, data_fim) VALUES ('12345678911', 1, '03-09-2022', '03-09-2024');
INSERT INTO MEMBRO_DA (cpf_jogador, time_id, data_inicio, data_fim) VALUES ('12345678912', 1, '03-09-2022', '03-09-2024');


INSERT INTO EQUIPE (nome, nome_treinador, cpf_treinador) VALUES ('Fluminense', 'Zelda Carioca', '06544598055');
INSERT INTO JOGADOR (cpf, nome, posicao_padrao) VALUES ('12345678913', 'Neto Batista', 'PIVO');
INSERT INTO JOGADOR (cpf, nome, posicao_padrao) VALUES ('12345678914', 'Ivoneide dos Santos', 'ALA PIVO');
INSERT INTO JOGADOR (cpf, nome, posicao_padrao) VALUES ('12345678915', 'Isabelle Azevedo', 'ALA');
INSERT INTO JOGADOR (cpf, nome, posicao_padrao) VALUES ('12345678916', 'Anabelle Azevedo', 'ARMADOR');
INSERT INTO JOGADOR (cpf, nome, posicao_padrao) VALUES ('12345678917', 'Peter Parker', 'ALA ARMADOR');
INSERT INTO JOGADOR (cpf, nome, posicao_padrao) VALUES ('12345678918', 'Neymar Junior', 'PIVO');
INSERT INTO JOGADOR (cpf, nome, posicao_padrao) VALUES ('12345678919', 'Kobe Bryan', 'ALA PIVO');
INSERT INTO JOGADOR (cpf, nome, posicao_padrao) VALUES ('12345678920', 'Bruce Banner', 'ALA');
INSERT INTO JOGADOR (cpf, nome, posicao_padrao) VALUES ('12345678921', 'Natasha Romanoff', 'ARMADOR');
INSERT INTO JOGADOR (cpf, nome, posicao_padrao) VALUES ('12345678922', 'Iemen Bepti', 'ALA ARMADOR');
INSERT INTO JOGADOR (cpf, nome, posicao_padrao) VALUES ('12345678923', 'Valderci Carvalho', 'PIVO');
INSERT INTO JOGADOR (cpf, nome, posicao_padrao) VALUES ('12345678924', 'Mateus Navarro', 'ALA');

INSERT INTO MEMBRO_DA (cpf_jogador, time_id, data_inicio, data_fim) VALUES ('12345678913', 2, '03-09-2022', '03-09-2024');
INSERT INTO MEMBRO_DA (cpf_jogador, time_id, data_inicio, data_fim) VALUES ('12345678914', 2, '03-09-2022', '03-09-2024');
INSERT INTO MEMBRO_DA (cpf_jogador, time_id, data_inicio, data_fim) VALUES ('12345678915', 2, '03-09-2022', '03-09-2024');
INSERT INTO MEMBRO_DA (cpf_jogador, time_id, data_inicio, data_fim) VALUES ('12345678916', 2, '03-09-2022', '03-09-2024');
INSERT INTO MEMBRO_DA (cpf_jogador, time_id, data_inicio, data_fim) VALUES ('12345678917', 2, '03-09-2022', '03-09-2024');
INSERT INTO MEMBRO_DA (cpf_jogador, time_id, data_inicio, data_fim) VALUES ('12345678918', 2, '03-09-2022', '03-09-2024');
INSERT INTO MEMBRO_DA (cpf_jogador, time_id, data_inicio, data_fim) VALUES ('12345678919', 2, '03-09-2022', '03-09-2024');
INSERT INTO MEMBRO_DA (cpf_jogador, time_id, data_inicio, data_fim) VALUES ('12345678920', 2, '03-09-2022', '03-09-2024');
INSERT INTO MEMBRO_DA (cpf_jogador, time_id, data_inicio, data_fim) VALUES ('12345678921', 2, '03-09-2022', '03-09-2024');
INSERT INTO MEMBRO_DA (cpf_jogador, time_id, data_inicio, data_fim) VALUES ('12345678922', 2, '03-09-2022', '03-09-2024');
INSERT INTO MEMBRO_DA (cpf_jogador, time_id, data_inicio, data_fim) VALUES ('12345678923', 2, '03-09-2022', '03-09-2024');
INSERT INTO MEMBRO_DA (cpf_jogador, time_id, data_inicio, data_fim) VALUES ('12345678924', 2, '03-09-2022', '03-09-2024');

INSERT INTO JOGO (time1_id, time2_id, data) VALUES (1, 2, '03-09-2022');

INSERT INTO PARTICIPA_DO (cpf_jogador, jogo_id, posicao, entrou_em_quadra, foi_substituido, cestas_1_ponto, cestas_2_pontos, cestas_3_pontos) 
VALUES ('12345678901', 1, 'PIVO', TRUE, TRUE, 3, 8, 4);

INSERT INTO PARTICIPA_DO (cpf_jogador, jogo_id, posicao, entrou_em_quadra, foi_substituido, cestas_1_ponto, cestas_2_pontos, cestas_3_pontos) 
VALUES ('12345678902', 1, 'ARMADOR', TRUE, FALSE, 4, 7, 0);

INSERT INTO PARTICIPA_DO (cpf_jogador, jogo_id, posicao, entrou_em_quadra, foi_substituido, cestas_1_ponto, cestas_2_pontos, cestas_3_pontos) 
VALUES ('12345678903', 1, 'ALA ARMADOR', TRUE, FALSE, 1, 6, 2);

INSERT INTO PARTICIPA_DO (cpf_jogador, jogo_id, posicao, entrou_em_quadra, foi_substituido, cestas_1_ponto, cestas_2_pontos, cestas_3_pontos) 
VALUES ('12345678904', 1, 'ALA', TRUE, FALSE, 3, 5, 0);

INSERT INTO PARTICIPA_DO (cpf_jogador, jogo_id, posicao, entrou_em_quadra, foi_substituido, cestas_1_ponto, cestas_2_pontos, cestas_3_pontos) 
VALUES ('12345678905', 1, 'ALA PIVO', TRUE, TRUE, 0, 4, 1);

INSERT INTO PARTICIPA_DO (cpf_jogador, jogo_id, posicao, entrou_em_quadra, foi_substituido, cestas_1_ponto, cestas_2_pontos, cestas_3_pontos) 
VALUES ('12345678906', 1, 'PIVO', FALSE, FALSE, 0, 0, 0);

INSERT INTO PARTICIPA_DO (cpf_jogador, jogo_id, posicao, entrou_em_quadra, foi_substituido, cestas_1_ponto, cestas_2_pontos, cestas_3_pontos) 
VALUES ('12345678907', 1, 'ARMADOR', TRUE, FALSE, 0, 0, 0);

INSERT INTO PARTICIPA_DO (cpf_jogador, jogo_id, posicao, entrou_em_quadra, foi_substituido, cestas_1_ponto, cestas_2_pontos, cestas_3_pontos) 
VALUES ('12345678908', 1, 'ALA ARMADOR', FALSE, FALSE, 0, 0, 0);

INSERT INTO PARTICIPA_DO (cpf_jogador, jogo_id, posicao, entrou_em_quadra, foi_substituido, cestas_1_ponto, cestas_2_pontos, cestas_3_pontos) 
VALUES ('12345678909', 1, 'ALA', FALSE, FALSE, 0, 0, 0);

INSERT INTO PARTICIPA_DO (cpf_jogador, jogo_id, posicao, entrou_em_quadra, foi_substituido, cestas_1_ponto, cestas_2_pontos, cestas_3_pontos) 
VALUES ('12345678900', 1, 'ALA PIVO', TRUE, FALSE, 0, 0, 0);

INSERT INTO PARTICIPA_DO (cpf_jogador, jogo_id, posicao, entrou_em_quadra, foi_substituido, cestas_1_ponto, cestas_2_pontos, cestas_3_pontos) 
VALUES ('12345678911', 1, 'PIVO', FALSE, FALSE, 0, 0, 1);

INSERT INTO PARTICIPA_DO (cpf_jogador, jogo_id, posicao, entrou_em_quadra, foi_substituido, cestas_1_ponto, cestas_2_pontos, cestas_3_pontos) 
VALUES ('12345678912', 1, 'ALA PIVO', FALSE, FALSE, 0, 2, 0);

INSERT INTO PARTICIPA_DO (cpf_jogador, jogo_id, posicao, entrou_em_quadra, foi_substituido, cestas_1_ponto, cestas_2_pontos, cestas_3_pontos) 
VALUES ('12345678913', 1, 'PIVO', TRUE, FALSE, 1, 1, 2);

INSERT INTO PARTICIPA_DO (cpf_jogador, jogo_id, posicao, entrou_em_quadra, foi_substituido, cestas_1_ponto, cestas_2_pontos, cestas_3_pontos) 
VALUES ('12345678914', 1, 'ALA', TRUE, FALSE, 0, 2, 2);

INSERT INTO PARTICIPA_DO (cpf_jogador, jogo_id, posicao, entrou_em_quadra, foi_substituido, cestas_1_ponto, cestas_2_pontos, cestas_3_pontos) 
VALUES ('12345678915', 1, 'ALA PIVO', TRUE, TRUE, 1, 5, 1);

INSERT INTO PARTICIPA_DO (cpf_jogador, jogo_id, posicao, entrou_em_quadra, foi_substituido, cestas_1_ponto, cestas_2_pontos, cestas_3_pontos) 
VALUES ('12345678916', 1, 'ARMADOR', TRUE, TRUE, 0, 5, 0);

INSERT INTO PARTICIPA_DO (cpf_jogador, jogo_id, posicao, entrou_em_quadra, foi_substituido, cestas_1_ponto, cestas_2_pontos, cestas_3_pontos) 
VALUES ('12345678917', 1, 'ALA ARMADOR', TRUE, TRUE, 3, 0, 0);

INSERT INTO PARTICIPA_DO (cpf_jogador, jogo_id, posicao, entrou_em_quadra, foi_substituido, cestas_1_ponto, cestas_2_pontos, cestas_3_pontos) 
VALUES ('12345678918', 1, 'PIVO', FALSE, FALSE, 0, 0, 0);

INSERT INTO PARTICIPA_DO (cpf_jogador, jogo_id, posicao, entrou_em_quadra, foi_substituido, cestas_1_ponto, cestas_2_pontos, cestas_3_pontos) 
VALUES ('12345678919', 1, 'ALA PIVO', TRUE, FALSE, 2, 1, 3);

INSERT INTO PARTICIPA_DO (cpf_jogador, jogo_id, posicao, entrou_em_quadra, foi_substituido, cestas_1_ponto, cestas_2_pontos, cestas_3_pontos) 
VALUES ('12345678920', 1, 'ALA', FALSE, FALSE, 0, 0, 0);

INSERT INTO PARTICIPA_DO (cpf_jogador, jogo_id, posicao, entrou_em_quadra, foi_substituido, cestas_1_ponto, cestas_2_pontos, cestas_3_pontos) 
VALUES ('12345678921', 1, 'ARMADOR', TRUE, FALSE, 2, 3, 1);

INSERT INTO PARTICIPA_DO (cpf_jogador, jogo_id, posicao, entrou_em_quadra, foi_substituido, cestas_1_ponto, cestas_2_pontos, cestas_3_pontos) 
VALUES ('12345678922', 1, 'ALA ARMADOR', TRUE, FALSE, 5, 0, 4);
