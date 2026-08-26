WITH tb_freq_abs as (

    SELECT descCategoriaProduto,
        COUNT(idTransacao) as Frequência_Absoluta
    FROM points
    GROUP BY descCategoriaProduto
),

tb_freq_abs_cum as (

    SELECT *,
        sum(Frequência_Absoluta) OVER (ORDER BY descCategoriaProduto) as Freq_Abs_Acumulada,

        1.0 * Frequência_Absoluta / (SELECT sum(Frequência_Absoluta) FROM tb_freq_abs) as Frequência_Relativa
    FROM tb_freq_abs
)

SELECT *,
       sum(Frequência_Relativa) OVER (ORDER BY descCategoriaProduto) as Freq_Rel_Acumulada
FROM tb_freq_abs_cum