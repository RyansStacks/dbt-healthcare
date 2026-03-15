with base as (

    select
        coverage_bridge_sk,
        patient_id,
        payor_id,
        coverage_start_date,
        coverage_end_date
    from {{ ref('int_coveragesbridge') }}

),

final as (

    select
        {{ dbt_utils.surrogate_key(['patient_id', 'payor_id', 'coverage_start_date']) }} as patient_payor_bridge_sk,
        patient_id,
        payor_id,
        coverage_start_date,
        coverage_end_date
    from base

)

select * from final;
