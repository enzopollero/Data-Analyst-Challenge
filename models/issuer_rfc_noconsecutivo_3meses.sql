WITH emisiones AS (
    SELECT
        ISSUER_RFC,
        TO_DATE(ISSUED_AT) AS fecha_emision,
        ROW_NUMBER() OVER(PARTITION BY ISSUER_RFC ORDER BY TO_DATE(ISSUED_AT)) AS rn
    FROM
         {{ ref('invoices')}}
    WHERE
        TYPE = 'I'
        AND ISSUED_AT >= DATEADD(MONTH, -24, CURRENT_DATE()) -- Últimos 24 meses
)
SELECT DISTINCT
    ISSUER_RFC,
    fecha_inicio_consecutiva,
    DATEADD(MONTH, 2, fecha_inicio_consecutiva) AS fecha_fin_consecutiva
FROM (
    SELECT
        ISSUER_RFC,
        fecha_inicio_consecutiva,
        ROW_NUMBER() OVER(PARTITION BY ISSUER_RFC, fecha_inicio_consecutiva ORDER BY fecha_emision) AS rn
    FROM (
        SELECT
            ISSUER_RFC,
            fecha_emision,
            DATEADD(MONTH, -ROW_NUMBER() OVER(PARTITION BY ISSUER_RFC ORDER BY fecha_emision), fecha_emision) AS fecha_inicio_consecutiva
        FROM
            emisiones
        WHERE
            rn <= 24
    )
)
GROUP BY
    ISSUER_RFC,
    fecha_inicio_consecutiva
HAVING
    COUNT(*) >= 3