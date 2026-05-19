-- int_scouting__atributos_jugadores.sql
--=======================================

with stg_atributos_jug as (
    select * from {{ ref('stg_scouting__atributos_jugadores') }}
)

select * from stg_atributos_jug