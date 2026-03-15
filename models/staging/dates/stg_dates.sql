-- stg_dates
with source as (

    select
        *
    from {{ source('ehr_raw', 'dates') }}

),

renamed as (

    select
        date_day,
        year,
        quarter,
        month,
        day,
        day_of_week,
        week_of_year,
        is_weekend,
        is_holiday,
        holiday_name,
        created_at,
        updated_at
    from source

),

final as (

    select
        {{ dbt_utils.surrogate_key(['date_day']) }} as date_sk,
        date_day,
        year,
        quarter,
        month,
        day,
        day_of_week,
        week_of_year,
        is_weekend,
        is_holiday,
        holiday_name,
        created_at,
        updated_at
    from renamed

)

select * from final;
