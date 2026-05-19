-- fct_evolucion.sql
--==================

with snp_evol as(
    select * from {{ ref('snp_evolucion') }}
),

int_jugadores as (
    select * from {{ ref('int_scouting__jugadores') }}
)

select
    s.id_jugador,
    s.fecha_actualizacion,
    s.valoracion_general,
    s.potencial,
    j.posicion_id,
    j.id_equipo,
    j.id_liga,
    j.id_pais
from snp_evol as s
left join int_jugadores as j
    on s.id_jugador = j.id_jugador

--ampliar con resumen de atributos