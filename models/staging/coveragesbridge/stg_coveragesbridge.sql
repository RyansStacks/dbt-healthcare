-- stg_coveragesbridge
with source as (

    select
        *
    from {{ source('ehr_raw', 'coveragesbridge') }}

),

renamed as (

    select
        coverage_bridge_id,
        patient_id,
        payor_id,
        coverage_start_date,
        coverage_end_date,
        coverage_status,
        created_at,
        updated_at
    from source

),

final as (

    select
        {{ dbt_utils.surrogate_key(['coverage_bridge_id']) }} as coverage_bridge_sk,
        coverage_bridge_id,
        patient_id,
        payor_id,
        coverage_start_date,
        coverage_end_date,
        coverage_status,
        created_at,
        updated_at
    from renamed

)

select * from final;
