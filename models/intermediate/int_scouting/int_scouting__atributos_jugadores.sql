-- int_scouting__atributos_jugadores.sql
--=======================================

with stg_atributos_jug as (
    select * from {{ ref('stg_scouting__atributos_jugadores') }}
),

int_jug as (
    select * from {{ ref('int_scouting__jugadores') }}
)


select 
    a.*
from stg_atributos_jug as a
inner join int_jug as j
    on a.id_jugador = j.id_jugador