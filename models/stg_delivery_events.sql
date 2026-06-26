{{ config(materialized='view') }}

with raw_source as (
    select * from {{ source('s3_bronze', 'alo_data') }}
)

select
    (raw_payload:order_id)::varchar as order_id,
    (raw_payload:carrier)::varchar as carrier,
    (raw_payload:status)::varchar as status,
    (raw_payload:delay_hours)::integer as delay_hours,
    ingested_at
from raw_source
