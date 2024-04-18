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
    {{ ref('business_product')}} bp
LEFT JOIN
    {{ ref('invoice_advance')}} ia
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