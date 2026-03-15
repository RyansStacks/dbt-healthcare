with base as (

    select *
    from {{ ref('stg_encounter_lab_tests') }}

),

final as (

    select
        encounter_lab_test_sk,
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
    from base

)

select * from final;
