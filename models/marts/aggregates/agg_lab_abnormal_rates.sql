with base as (

    select
        encounter_id,
        patient_id,
        loinc_code,
        test_name,
        collected_datetime::date as collected_date,
        is_abnormal
    from {{ ref('fct_lab_results') }}

),

agg as (

    select
        collected_date,
        loinc_code,
        test_name,
        count(*) as total_results,
        sum(is_abnormal) as abnormal_results,
        case
            when count(*) = 0 then null
            else sum(is_abnormal)::float / count(*)
        end as abnormal_rate
    from base
    group by collected_date, loinc_code, test_name

),

final as (

    select
        *
    from agg

)

select * from final;
