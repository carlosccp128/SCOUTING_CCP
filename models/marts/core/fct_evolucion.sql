-- fct_evolucion.sql
--==================

with stg_atrib as(
    select * from {{ ref('stg_scouting__atributos_jugadores') }}
),

stg_list as (
    select * from {{ ref('stg_scouting__listado_jugadores') }}
)

select
    s.id_jugador,
    s.fecha_actualizacion,
    s.valoracion_general,
    s.potencial,
    l.posicion_id,
    l.id_equipo,
    l.id_liga,
    l.id_pais
from stg_atrib as s
left join stg_list as l
    on s.id_jugador = l.id_jugador

--ampliar con resumen de atributos