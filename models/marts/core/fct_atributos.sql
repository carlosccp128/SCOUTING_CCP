-- fct_atributos.sql
--==================

with int_jugadores as (
    select * from {{ ref('int_scouting__jugadores') }}
),

reci_atrib as (
    {{ dbt_utils.deduplicate(
    relation= ref('int_scouting__atributos_jugadores'),
    partition_by='id_jugador',
    order_by='fecha_actualizacion desc'
) }}
)

select
    j.posicion_id,
    j.id_equipo,
    j.id_liga,
    j.id_pais,
    a.*
from reci_atrib as a
inner join int_jugadores as j
    on a.id_jugador = j.id_jugador
