with encounters as (

    select *
    from {{ ref('int_encounters') }}

),

final as (

    select
        encounter_sk,
        encounter_id,
        patient_id,
        admit_datetime,
        discharge_datetime,
        datediff('hour', admit_datetime, discharge_datetime) as length_of_stay_hours,
        datediff('day', admit_datetime, discharge_datetime) as length_of_stay_days
    from encounters

)

select * from final;
