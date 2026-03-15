with enc as (

    select
        encounter_id,
        patient_id,
        admit_datetime::date as admit_date,
        discharge_datetime::date as discharge_date,
        length_of_stay_days
    from {{ ref('fct_encounters') }}

),

by_admit as (

    select
        admit_date as metric_date,
        count(*) as encounters_started,
        avg(length_of_stay_days) as avg_los_for_admits
    from enc
    group by admit_date

),

by_discharge as (

    select
        discharge_date as metric_date,
        count(*) as encounters_discharged
    from enc
    group by discharge_date

),

final as (

    select
        coalesce(a.metric_date, d.metric_date) as metric_date,
        a.encounters_started,
        a.avg_los_for_admits,
        d.encounters_discharged
    from by_admit a
    full outer join by_discharge d
        on a.metric_date = d.metric_date

)

select * from final;
