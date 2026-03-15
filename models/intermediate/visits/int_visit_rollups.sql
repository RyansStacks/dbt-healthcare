with visits as (

    select *
    from {{ ref('int_visits') }}

),

final as (

    select
        encounter_id,
        patient_id,
        count(*) as visit_count,
        min(visit_start_datetime) as first_visit_start,
        max(visit_end_datetime) as last_visit_end
    from visits
    group by 1, 2

)

select * from final;
