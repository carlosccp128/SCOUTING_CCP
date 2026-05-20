-- dim_paises.sql
--=================

with int_paises as (
    select * from {{ ref('int_scouting__paises') }}
)

select * from int_paises