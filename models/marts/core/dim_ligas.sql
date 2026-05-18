-- dim_ligas.sql
--=================

with int_ligas as (
    select * from {{ ref('int_scouting__ligas') }}
)

select * from int_ligas