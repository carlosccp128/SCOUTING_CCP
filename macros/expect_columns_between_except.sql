-- tests/generic/expect_columns_between_except.sql
==================================================
{% test expect_columns_between_except(model, min_value, max_value, except=[]) %}

{% set all_columns = adapter.get_columns_in_relation(model) %}

select *
from {{ model }}
where 1=0
{% for col in all_columns %}
  {% if col.name | lower not in except | map('lower') | list %}
    or {{ col.name }} not between {{ min_value }} and {{ max_value }}
  {% endif %}
{% endfor %}

{% endtest %}