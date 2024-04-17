

with INVOICES as (

select * from  {{source('snowflake','INVOICES')}}

)

select * from INVOICES
