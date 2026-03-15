-- stg_visits
with source as (

    select
        *
    from {{ source('ehr_raw', 'visits') }}

),

renamed as (

    select
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
    from source

),

final as (

    select
        {{ dbt_utils.surrogate_key(['visit_id']) }} as visit_sk,
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
    from renamed

)

select * from final;
