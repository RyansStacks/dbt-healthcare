with base as (

    select *
    from {{ ref('stg_coveragesbridge') }}

),

final as (

    select
        coverage_bridge_sk,
        coverage_bridge_id,
        patient_id,
        payor_id,
        coverage_start_date,
        coverage_end_date,
        coverage_status,
        created_at,
        updated_at
    from base

)

select * from final;
