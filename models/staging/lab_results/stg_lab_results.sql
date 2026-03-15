with source as (

    select
        *
    from {{ source('ehr_raw', 'lab_results') }}

),

renamed as (

    select
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
    from source

),

final as (

    select
        {{ dbt_utils.surrogate_key(['lab_result_id']) }} as lab_result_sk,
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
    from renamed

)

select * from final;
