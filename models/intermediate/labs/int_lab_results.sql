with base as (

    select *
    from {{ ref('stg_lab_results') }}

),

final as (

    select
        lab_result_sk,
        lab_result_id,
        patient_id,
        encounter_id,
        loinc_code,
        test_name,
        result_value,
        result_unit,
        reference_range_low,
        reference_range_high,
        abnormal_flag,
        collected_datetime,
        resulted_datetime,
        created_at,
        updated_at
    from base

)

select * from final;
