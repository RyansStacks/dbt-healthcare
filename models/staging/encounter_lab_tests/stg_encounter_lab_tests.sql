-- stg_encounter_lab_tests
with source as (

    select
        *
    from {{ source('ehr_raw', 'encounter_lab_tests') }}

),

renamed as (

    select
        encounter_lab_test_id,
        encounter_id,
        patient_id,
        lab_test_id,
        order_datetime,
        result_datetime,
        status,
        ordering_provider_id,
        created_at,
        updated_at
    from source

),

final as (

    select
        {{ dbt_utils.surrogate_key(['encounter_lab_test_id']) }} as encounter_lab_test_sk,
        encounter_lab_test_id,
        encounter_id,
        patient_id,
        lab_test_id,
        order_datetime,
        result_datetime,
        status,
        ordering_provider_id,
        created_at,
        updated_at
    from renamed

)

select * from final;
