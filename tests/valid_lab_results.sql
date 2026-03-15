-- valid_lab_results
select *
from {{ ref('fct_lab_results') }}
where result_value is null
   or result_value < 0
   or result_unit is null
