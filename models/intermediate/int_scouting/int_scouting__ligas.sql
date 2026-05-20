-- int_scouting__ligas.sql
--=========================
with stg_ligas as (
    select * from {{ ref('stg_scouting__ligas') }}
),

stg_paises as (
    select * from {{ ref('stg_scouting__paises') }}
),

stg_list as (
    select * from {{ ref('stg_scouting__listado_jugadores') }}
),
list_liga as (
    select distinct
        id_liga,
        nombre_liga,
        division_liga
    from stg_list
),
list_pais as (
    select distinct
        id_pais,
        nombre_pais
    from stg_list
),

pais_ident as (
    select 
        a.*,
        b.id_pais
    from stg_paises as a
    left join list_pais as b
        on a.nombre_pais = b.nombre_pais
)



select
    l.id_liga,
    l.nombre_liga,
    j.division_liga,
    coalesce(p.id_pais, '31') as id_pais

from stg_ligas as l
left join list_liga as j
    on l.id_liga = j.id_liga
left join pais_ident as p
    on l.id_pais_liga = p.id_pais_liga

--Hacemos coalesce para controlar que Mercado de Fichajes no tiene liga.
--Le asignamos 31-Luxemburgo por ser un país sin una liga profesional y
-- con sedes europeas, por lo que engloba un poco nuestro mercado.
