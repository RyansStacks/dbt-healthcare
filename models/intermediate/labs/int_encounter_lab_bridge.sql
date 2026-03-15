with tests as (

    select
        encounter_lab_test_sk,
        encounter_id,
        patient_id,
        lab_test_id
    from {{ ref('int_encounter_lab_tests') }}

),

results as (

    select
        lab_result_sk,
        encounter_id,
        patient_id,
        loinc_code
    from {{ ref('int_lab_results') }}

),

final as (

    select
        {{ dbt_utils.surrogate_key([
            'tests.encounter_lab_test_sk',
            'results.lab_result_sk'
        ]) }} as encounter_lab_bridge_sk,
        
        tests.encounter_lab_test_sk,
        results.lab_result_sk,
        tests.encounter_id,
        tests.patient_id,
        tests.lab_test_id,
        results.loinc_code

    from tests
    left join results
        on tests.encounter_id = results.encounter_id
        and tests.patient_id = results.patient_id

)

select * from final;
