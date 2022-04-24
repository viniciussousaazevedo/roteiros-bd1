-- Placar final entre Flamengo e Fluminense no Jogo 1
SELECT nome AS equipe, sum(cestas_1_ponto) + sum(cestas_2_pontos) + sum(cestas_3_pontos) AS pontuacao FROM (
    SELECT e.nome, pd.cpf_jogador,
        cestas_1_ponto*1 AS cestas_1_ponto,
        cestas_2_pontos*2 AS cestas_2_pontos,
        cestas_3_pontos*3 AS cestas_3_pontos
        FROM PARTICIPA_DO pd, MEMBRO_DA md, EQUIPE e
        WHERE jogo_id = 1 AND md.cpf_jogador = pd.cpf_jogador AND md.time_id = e.id
) AS cestas
GROUP BY nome;

-- Jogador que mais pontuou no Jogo 1
SELECT nome, pontuacao FROM (
    SELECT j.nome, (cestas_1_ponto*1 + cestas_2_pontos*2 + cestas_3_pontos*3) AS pontuacao
        FROM JOGADOR j, PARTICIPA_DO pd
        WHERE jogo_id = 1 AND j.cpf = pd.cpf_jogador
) AS cestas
WHERE pontuacao = (
    SELECT max(pontuacao) FROM (
        SELECT (cestas_1_ponto*1 + cestas_2_pontos*2 + cestas_3_pontos*3) AS pontuacao
        FROM JOGADOR j, PARTICIPA_DO pd
        WHERE jogo_id = 1 AND j.cpf = pd.cpf_jogador
    ) as cesta_maxima
);

-- Media de pontuação dos jogadores do Fluminense no Jogo 1
SELECT avg(pontuacao) FROM (
    SELECT (cestas_1_ponto*1 + cestas_2_pontos*2 + cestas_3_pontos*3) AS pontuacao
            FROM JOGADOR j, PARTICIPA_DO pd, MEMBRO_DA md
            WHERE jogo_id = 1 AND 
            j.cpf = pd.cpf_jogador AND 
            md.cpf_jogador = j.cpf AND
            md.time_id = 2
) AS pontuacao_time;