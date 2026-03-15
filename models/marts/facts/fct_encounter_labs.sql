with bridge as (

    select
        elb.encounter_lab_bridge_sk,
        elb.encounter_lab_test_sk,
        elb.lab_result_sk,
        elb.encounter_id,
        elb.patient_id,
        elb.lab_test_id,
        elb.loinc_code
    from {{ ref('int_encounter_lab_bridge') }} elb

),

tests as (

    select
        encounter_lab_test_sk,
        encounter_lab_test_id,
        encounter_id,
        patient_id,
        lab_test_id,
        order_datetime,
        result_datetime,
        status,
        ordering_provider_id
    from {{ ref('int_encounter_lab_tests') }}

),

results as (

    select
        lab_result_sk,
        lab_result_id,
        encounter_id,
        patient_id,
        loinc_code,
        test_name,
        result_value,
        result_unit,
        reference_range_low,
        reference_range_high,
        abnormal_flag,
        collected_datetime,
        resulted_datetime
    from {{ ref('int_lab_results') }}

),

joined as (

    select
        b.encounter_lab_bridge_sk,
        b.encounter_id,
        b.patient_id,
        b.lab_test_id,
        b.loinc_code,

        t.encounter_lab_test_sk,
        t.encounter_lab_test_id,
        t.order_datetime,
        t.result_datetime as order_result_datetime,
        t.status as order_status,
        t.ordering_provider_id,

        r.lab_result_sk,
        r.lab_result_id,
        r.test_name,
        r.result_value,
        r.result_unit,
        r.reference_range_low,
        r.reference_range_high,
        r.abnormal_flag,
        r.collected_datetime,
        r.resulted_datetime,

        case
            when r.result_value is not null
                 and r.reference_range_low is not null
                 and r.reference_range_high is not null
            then
                (r.result_value - r.reference_range_low)
                / nullif(r.reference_range_high - r.reference_range_low, 0)
        end as result_normalized,

        case
            when r.abnormal_flag = 'Y' then 1
            else 0
        end as is_abnormal

    from bridge b
    left join tests t
        on b.encounter_lab_test_sk = t.encounter_lab_test_sk
    left join results r
        on b.lab_result_sk = r.lab_result_sk

),

final as (

    select
        *
    from joined

)

select * from final;
