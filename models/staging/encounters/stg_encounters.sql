-- stg_encounters
with source as (

    select
        *
    from {{ source('ehr_raw', 'encounters') }}

),

renamed as (

    select
        encounter_id,
        patient_id,
        encounter_type,
        admit_datetime,
        discharge_datetime,
        attending_provider_id,
        location,
        department,
        visit_reason,
        created_at,
        updated_at
    from source

),

final as (

    select
        {{ dbt_utils.surrogate_key(['encounter_id']) }} as encounter_sk,
        encounter_id,
        patient_id,
        encounter_type,
        admit_datetime,
        discharge_datetime,
        attending_provider_id,
        location,
        department,
        visit_reason,
        created_at,
        updated_at
    from renamed

)

select * from final;
