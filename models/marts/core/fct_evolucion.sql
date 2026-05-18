-- fct_evolucion.sql
--==================

with int_atributos as (
    select * from {{ ref('int_scouting__atributos_jugadores') }}
),

int_jugadores as (
    select * from {{ ref('int_scouting__jugadores') }}
)

select
    a.id_jugador,
    j.posicion_id,
    j.id_equipo,
    j.id_liga,
    j.id_pais,
    a.fecha_actualizacion,
    a.valoracion_general,
    a.potencial,
from int_atributos as a
inner join int_jugadores as j
    on a.id_jugador = j.id_jugador

--ampliar con resumen de atributos
