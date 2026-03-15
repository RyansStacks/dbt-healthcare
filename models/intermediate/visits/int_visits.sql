with base as (

    select *
    from {{ ref('stg_visits') }}

),

final as (

    select
        visit_sk,
        visit_id,
        encounter_id,
        patient_id,
        visit_type,
        visit_start_datetime,
        visit_end_datetime,
        provider_id,
        location,
        department,
        created_at,
        updated_at
    from base

)

select * from final;
