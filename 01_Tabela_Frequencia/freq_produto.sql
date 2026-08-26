WITH tb_freq_abs as (

    SELECT descProduto,
        COUNT(idTransacao) as Frequência_Absoluta
    FROM points
    GROUP BY descProduto
),

tb_freq_abs_cum as (

    SELECT *,
        sum(Frequência_Absoluta) OVER (ORDER BY descProduto) as Freq_Abs_Acumulada,

        1.0 * Frequência_Absoluta / (SELECT sum(Frequência_Absoluta) FROM tb_freq_abs) as Frequência_Relativa
    FROM tb_freq_abs
)

SELECT *,
       sum(Frequência_Relativa) OVER (ORDER BY descProduto) as Freq_Rel_Acumulada
FROM tb_freq_abs_cum