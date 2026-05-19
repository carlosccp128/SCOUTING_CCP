-- int_scouting__equipos.sql
--=========================
with stg_equipos as (
    select * from {{ ref('stg_scouting__equipos') }}
),

stg_list as (
    select * from {{ ref('stg_scouting__listado_jugadores') }}
),
eq_lig as (
    select distinct
        id_equipo,
        id_liga
    from stg_list
)

select
    e.id_equipo,
    e.nombre_equipo,
    e.acronimo_equipo,
    l.id_liga

from stg_equipos as e
left join eq_lig as l
    on e.id_equipo = l.id_equipo