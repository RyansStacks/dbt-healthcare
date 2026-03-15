with base as (

    select *
    from {{ ref('stg_payors') }}

),

final as (

    select
        payor_sk,
        payor_id,
        encounter_id,
        patient_id,
        payor_name,
        plan_name,
        coverage_type,
        member_id,
        group_number,
        effective_date,
        termination_date,
        created_at,
        updated_at
    from base

)

select * from final;
