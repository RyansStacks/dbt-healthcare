with base as (

    select *
    from {{ ref('stg_encounters') }}

),

final as (

    select
        encounter_sk,
        encounter_id,
        patient_id,
        encounter_type,
        admit_datetime,
        discharge_datetime,
        attending_provider_id,
        location,
        department,
        created_at,
        updated_at
    from base

)

select * from final;
