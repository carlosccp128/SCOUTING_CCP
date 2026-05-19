-- dim_jugadores.sql
--=================

with int_jugadores as (
    select * from {{ ref('int_scouting__jugadores') }}
)

select 
    id_jugador,
    nombre_jugador,
    fecha_nacimiento,
    altura_cm,
    peso_kg,
    valor_mercado,
    salario_semanal,
    pierna_habil,
    pierna_mala,
    filigranas,

from int_jugadores