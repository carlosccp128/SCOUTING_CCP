-- dim_posiciones.sql
--=================

with int_posiciones as (
    select * from {{ ref('int_scouting__posiciones') }}
)

select * from int_posiciones