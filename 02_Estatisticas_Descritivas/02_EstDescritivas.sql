-- Identificando a mediana da coluna qtdPontos

WITH tb_subset_mediana AS (
    SELECT qtdPontos
    FROM points
    ORDER BY qtdPontos
    LIMIT 1 + (SELECT COUNT(*) % 2 == 0 FROM points)
    OFFSET (SELECT COUNT(*) / 2 FROM points)
),

tb_mediana AS (
    SELECT AVG(qtdPontos) AS Mediana
    FROM tb_subset_mediana
),

tb_subset_1_quartil AS (
    SELECT qtdPontos
    FROM points
    ORDER BY qtdPontos
    LIMIT 1 + (SELECT COUNT(*) % 2 == 0 FROM points)
    OFFSET (SELECT COUNT(*) / 4 FROM points)
),

tb_1_quartil AS (
    SELECT AVG(qtdPontos) AS Quartil_1
    FROM tb_subset_1_quartil
),

tb_subset_3_quartil AS (
    SELECT qtdPontos
    FROM points
    ORDER BY qtdPontos
    LIMIT 1 + (SELECT COUNT(*) % 2 == 0 FROM points)
    OFFSET (SELECT 3 * COUNT(*) / 4 FROM points)
),

tb_3_quartil AS (
    SELECT AVG(qtdPontos)
    FROM tb_subset_3_quartil
),

tb_stats AS(
    SELECT MIN(qtdPontos) AS Mínimo,
           AVG(qtdPontos) AS Média,
           MAX(qtdPontos) AS Máximo
    FROM points
)

SELECT *
FROM tb_stats, tb_1_quartil, tb_mediana, tb_3_quartil