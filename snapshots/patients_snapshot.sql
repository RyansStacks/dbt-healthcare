-- patients_snapshot
{% snapshot patients_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='patient_id',
        strategy='timestamp',
        updated_at='updated_at'
    )
}}

select *
from {{ ref('stg_patients') }}

{% endsnapshot %}
