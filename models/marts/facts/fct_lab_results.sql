with base as (

    select
        lr.lab_result_sk,
        lr.lab_result_id,
        lr.patient_id,
        lr.encounter_id,
        lr.loinc_code,
        lr.test_name,
        lr.result_value,
        lr.result_unit,
        lr.reference_range_low,
        lr.reference_range_high,
        lr.abnormal_flag,
        lr.collected_datetime,
        lr.resulted_datetime
    from {{ ref('int_lab_results') }} lr

),

normalized as (

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

        case
            when result_value is not null
                 and reference_range_low is not null
                 and reference_range_high is not null
            then
                (result_value - reference_range_low)
                / nullif(reference_range_high - reference_range_low, 0)
        end as result_normalized,

        case
            when abnormal_flag = 'Y' then 1
            else 0
        end as is_abnormal

    from base

),

final as (

    select
        *
    from normalized

)

select * from final;
