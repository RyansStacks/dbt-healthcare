-- stg_payors
with source as (

    select
        *
    from {{ source('ehr_raw', 'payors') }}

),

renamed as (

    select
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
    from source

),

final as (

    select
        {{ dbt_utils.surrogate_key(['payor_id']) }} as payor_sk,
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
    from renamed

)

select * from final;
