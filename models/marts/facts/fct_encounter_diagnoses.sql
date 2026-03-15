with base as (

    select
        edb.encounter_diagnosis_bridge_sk,
        edb.diagnosis_sk,
        edb.encounter_id,
        edb.patient_id,
        edb.icd_code,
        d.diagnosis_type,
        d.diagnosis_description
    from {{ ref('int_encounter_diagnosis_bridge') }} edb
    left join {{ ref('int_diagnoses') }} d
        on edb.diagnosis_sk = d.diagnosis_sk

),

flags as (

    select
        encounter_diagnosis_bridge_sk,
        diagnosis_sk,
        encounter_id,
        patient_id,
        icd_code,
        diagnosis_type,
        diagnosis_description,

        case when diagnosis_type = 'PRIMARY' then 1 else 0 end as is_primary_diagnosis,
        case when diagnosis_type = 'SECONDARY' then 1 else 0 end as is_secondary_diagnosis
    from base

),

final as (

    select
        *
    from flags

)

select * from final;
