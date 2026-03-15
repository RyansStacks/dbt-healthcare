-- quality_checks
{% macro assert_not_null(model, column_name) %}
    select *
    from {{ model }}
    where {{ column_name }} is null
{% endmacro %}

{% macro assert_positive(model, column_name) %}
    select *
    from {{ model }}
    where {{ column_name }} < 0
{% endmacro %}
