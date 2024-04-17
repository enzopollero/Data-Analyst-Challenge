
with BUSINESS_PRODUCT as (

select * from  {{source('snowflake','BUSINESS_PRODUCT')}}

)

select * from BUSINESS_PRODUCT

