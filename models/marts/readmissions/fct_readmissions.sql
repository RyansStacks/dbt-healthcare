with enc as (

    select
        encounter_id,
        patient_id,
        admit_datetime,
        discharge_datetime,
        length_of_stay_days
    from {{ ref('fct_encounters') }}

),

ordered as (

    select
        patient_id,
        encounter_id,
        admit_datetime,
        discharge_datetime,
        length_of_stay_days,
        lead(encounter_id) over (
            partition by patient_id
            order by admit_datetime
        ) as next_encounter_id,
        lead(admit_datetime) over (
            partition by patient_id
            order by admit_datetime
        ) as next_admit_datetime
    from enc

),

windows as (

    select
        patient_id,
        encounter_id as index_encounter_id,
        admit_datetime as index_admit_datetime,
        discharge_datetime as index_discharge_datetime,
        length_of_stay_days as index_length_of_stay_days,
        next_encounter_id as readmission_encounter_id,
        next_admit_datetime as readmission_admit_datetime,

        case
            when next_admit_datetime is not null
                 and next_admit_datetime <= discharge_datetime + interval '30 days'
            then 1
            else 0
        end as is_30_day_readmission
    from ordered

),

final as (

    select
        {{ dbt_utils.surrogate_key([
            'patient_id',
            'index_encounter_id'
        ]) }} as readmission_sk,
        *
    from windows

)

select * from final;
