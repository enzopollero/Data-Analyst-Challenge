{{ 
config(
    materialized='view'
)
}}

SELECT
    b.ID AS business_id,
    bp.PRODUCT_NAME,
    bp.STATUS,
    COUNT(CASE WHEN bp.YEAR = 2021 THEN 1 END) AS count_2021,
    COUNT(CASE WHEN bp.YEAR = 2022 THEN 1 END) AS count_2022
FROM  
     {{ ref('business')}} b
LEFT JOIN (
    SELECT
        BUSINESS_ID,
        PRODUCT_NAME,
        STATUS,
        EXTRACT(YEAR FROM CREATED_AT) AS YEAR
    FROM  
      {{ ref('business_product')}}
    WHERE
        PRODUCT_NAME = 'Invoice advance'
        AND STATUS = 'active'
        AND EXTRACT(YEAR FROM CREATED_AT) IN (2021, 2022)
) bp ON b.ID = bp.BUSINESS_ID
GROUP BY
    b.ID,
    bp.PRODUCT_NAME,
    bp.STATUS
HAVING
    COUNT(CASE WHEN bp.YEAR = 2021 THEN 1 END) > 0
    AND COUNT(CASE WHEN bp.YEAR = 2022 THEN 1 END) > 0