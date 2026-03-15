with enc as (

    select
        e.encounter_sk,
        e.encounter_id,
        e.patient_id,
        e.encounter_type,
        e.admit_datetime,
        e.discharge_datetime,
        e.attending_provider_id,
        e.location,
        e.department
    from {{ ref('int_encounters') }} e

),

timelines as (

    select
        encounter_id,
        length_of_stay_hours,
        length_of_stay_days
    from {{ ref('int_encounter_timelines') }}

),

visit_rollups as (

    select
        encounter_id,
        visit_count,
        first_visit_start,
        last_visit_end
    from {{ ref('int_visit_rollups') }}

),

diag_flags as (

    select
        encounter_id,
        max(case when diagnosis_type = 'PRIMARY' then 1 else 0 end) as has_primary_diagnosis,
        count(*) as diagnosis_count
    from {{ ref('int_diagnoses') }}
    group by encounter_id

),

lab_flags as (

    select
        encounter_id,
        count(*) as lab_result_count,
        max(case when abnormal_flag = 'Y' then 1 else 0 end) as has_abnormal_lab
    from {{ ref('int_lab_results') }}
    group by encounter_id

),

final as (

    select
        enc.encounter_sk,
        enc.encounter_id,
        enc.patient_id,

        -- core encounter attributes
        enc.encounter_type,
        enc.admit_datetime,
        enc.discharge_datetime,
        enc.attending_provider_id,
        enc.location,
        enc.department,

        -- timelines
        t.length_of_stay_hours,
        t.length_of_stay_days,

        -- visit rollups
        vr.visit_count,
        vr.first_visit_start,
        vr.last_visit_end,

        -- diagnosis flags
        df.has_primary_diagnosis,
        df.diagnosis_count,

        -- lab flags
        lf.lab_result_count,
        lf.has_abnormal_lab

    from enc
    left join timelines t
        on enc.encounter_id = t.encounter_id
    left join visit_rollups vr
        on enc.encounter_id = vr.encounter_id
    left join diag_flags df
        on enc.encounter_id = df.encounter_id
    left join lab_flags lf
        on enc.encounter_id = lf.encounter_id

)

select * from final;
