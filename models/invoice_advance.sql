

with INVOICE_ADVANCE as (

select * from  {{source('snowflake','INVOICE_ADVANCE')}}

)

select * from INVOICE_ADVANCE