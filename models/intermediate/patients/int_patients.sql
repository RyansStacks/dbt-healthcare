with base as (

    select *
    from {{ ref('stg_patients') }}

),

final as (

    select
        patient_sk,
        patient_id,
        first_name,
        last_name,
        date_of_birth,
        gender,
        race,
        ethnicity,
        address,
        city,
        state,
        zip_code,
        phone_number,
        email,
        created_at,
        updated_at
    from base

)

select * from final;
