-- dim_equipos.sql
--=================

with int_equipos as (
    select * from {{ ref('int_scouting__equipos') }}
)

select * from int_equipos