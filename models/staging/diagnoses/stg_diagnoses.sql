-- stg_diagnosis
with source as (

    select
        *
    from {{ source('ehr_raw', 'diagnoses') }}

),

renamed as (

    select
        diagnosis_id,
        encounter_id,
        patient_id,
        icd10_code,
        diagnosis_description,
        diagnosis_type,
        diagnosis_rank,
        recorded_datetime,
        created_at,
        updated_at
    from source

),

final as (

    select
        {{ dbt_utils.surrogate_key(['diagnosis_id']) }} as diagnosis_sk,
        diagnosis_id,
        encounter_id,
        patient_id,
        icd10_code,
        diagnosis_description,
        diagnosis_type,
        diagnosis_rank,
        recorded_datetime,
        created_at,
        updated_at
    from renamed

)

select * from final;
