with base as (

    select
        diagnosis_sk,
        encounter_id,
        patient_id,
        icd_code
    from {{ ref('int_diagnoses') }}

),

final as (

    select
        {{ dbt_utils.surrogate_key(['diagnosis_sk', 'encounter_id']) }} as encounter_diagnosis_bridge_sk,
        diagnosis_sk,
        encounter_id,
        patient_id,
        icd_code
    from base

)

select * from final;
