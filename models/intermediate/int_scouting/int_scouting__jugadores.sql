-- int_scouting__jugadores.sql
--=============================
with stg_jugador as (
    select * from {{ ref('stg_scouting__jugadores') }}
),

stg_list as (
    select * from {{ ref('stg_scouting__listado_jugadores') }}
)

select
    j.id_jugador,
    j.nombre_jugador,
    j.fecha_nacimiento,
    j.altura_cm,
    j.peso_kg,
    l.posicion_id,
    l.valor_mercado,
    l.salario_semanal,
    l.id_equipo,
    l.id_liga,
    l.id_pais,
    l.pierna_habil,
    l.pierna_mala,
    l.filigranas,

from stg_jugador as j
inner join stg_list as l
    on j.id_jugador = l.id_jugador