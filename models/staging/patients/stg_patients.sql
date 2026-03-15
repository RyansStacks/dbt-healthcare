with source as (

    select
        *
    from {{ source('ehr_raw', 'patients') }}

),

renamed as (

    select
        patient_id,
        mrn as medical_record_number,
        first_name,
        last_name,
        date_of_birth,
        sex,
        address,
        city,
        state,
        zip_code,
        phone_number,
        email,
        created_at,
        updated_at
    from source

),

final as (

    select
        {{ dbt_utils.surrogate_key(['patient_id']) }} as patient_sk,
        patient_id,
        medical_record_number,
        first_name,
        last_name,
        date_of_birth,
        sex,
        address,
        city,
        state,
        zip_code,
        phone_number,
        email,
        created_at,
        updated_at
    from renamed

)

select * from final;
-- stg_patients
