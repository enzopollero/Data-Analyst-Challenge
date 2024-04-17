

with CUSTOMER as (

select * from  {{source('snowflake','CUSTOMER')}}

)

select * from CUSTOMER
