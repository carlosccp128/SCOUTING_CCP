-- int_scouting__jugadores.sql
--=============================
with stg_jugador as (
    select * from {{ ref('stg_scouting__jugadores') }}
),

stg_list as (
    select * from {{ ref('stg_scouting__listado_jugadores') }}
),
stg_ligas as (
    select * from {{ ref('stg_scouting__ligas') }}
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
inner join stg_ligas as s
    on l.id_liga = s.id_liga

/*
El inner join (sólo comunes) para descartar por un lado todos los que se retiran,
(que tenemos registro en jugadores de haberlos analizado alguna vez, pero no estan en la tabla de este año), 
por otro a los que aunque jueguen se salen de "nuestro radar" y unos ultimos que juegan y estaban controlados
pero se han ido a una liga que ya no se analiza
*/