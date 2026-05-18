-- fct_atributos.sql
--=================

with int_atributos as (
    select * from {{ ref('int_scouting__atributos_jugadores') }}
),

int_jugadores as (
    select * from {{ ref('int_scouting__jugadores') }}
)

select
    j.posicion_id,
    j.id_equipo,
    j.id_liga,
    j.id_pais,
    a.*
from int_atributos as a
left join int_jugadores as j
    on a.id_jugador = j.id_jugador
