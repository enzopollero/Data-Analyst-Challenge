
with BUSINESS as (

select * from  {{source('snowflake','BUSINESS')}}

)

select * from BUSINESS
