with base as (

    select
        ppb.patient_payor_bridge_sk,
        ppb.patient_id,
        ppb.payor_id,
        ppb.coverage_start_date,
        ppb.coverage_end_date
    from {{ ref('int_patient_payor_bridge') }} ppb

),

payor as (

    select
        payor_sk,
        payor_id,
        payor_name,
        plan_name,
        coverage_type
    from {{ ref('int_payors') }}

),

final as (

    select
        {{ dbt_utils.surrogate_key([
            'b.patient_payor_bridge_sk'
        ]) }} as patient_payor_coverage_sk,

        b.patient_payor_bridge_sk,
        b.patient_id,
        p.payor_sk,
        b.payor_id,
        p.payor_name,
        p.plan_name,
        p.coverage_type,
        b.coverage_start_date,
        b.coverage_end_date,

        case
            when b.coverage_end_date is null
                 or b.coverage_end_date >= current_date
            then 1
            else 0
        end as is_currently_covered

    from base b
    left join payor p
        on b.payor_id = p.payor_id

)

select * from final;
