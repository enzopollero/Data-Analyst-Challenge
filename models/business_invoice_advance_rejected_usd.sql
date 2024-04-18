{{
    config(
        materialized='view'
    )

}}

SELECT
    bp.id AS business_product_id,
    bp.product_name,
    ia.currency,
    ia.state
FROM
   {{source('snowflake','BUSINESS_PRODUCT')}} bp
LEFT JOIN
    {{source('snowflake','INVOICE_ADVANCE')}} ia
ON
    bp.id = ia.business_product_id
    AND ia.currency = 'USD'
    AND ia.state = 'rejected'
WHERE
    bp.product_name = 'Invoice Advance'
GROUP BY
    bp.id,
    bp.product_name,
        ia.currency,
            ia.state