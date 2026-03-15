with base as (

    select *
    from {{ ref('stg_diagnoses') }}

),

final as (

    select
        diagnosis_sk,
        diagnosis_id,
        encounter_id,
        patient_id,
        icd_code,
        diagnosis_description,
        diagnosis_type,
        created_at,
        updated_at
    from base

)

select * from final;
