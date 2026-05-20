-- int_scouting__posiciones.sql
--=========================
with stg_list as (
    select * from {{ ref('stg_scouting__listado_jugadores') }}
)

select distinct
    posicion_id,
    posicion,
    posicion_nombre

from stg_list