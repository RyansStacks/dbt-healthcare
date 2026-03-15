-- unique_encounter_id
select
    encounter_id,
    count(*) as record_count
from {{ ref('fct_encounters') }}
group by encounter_id
having count(*) > 1
