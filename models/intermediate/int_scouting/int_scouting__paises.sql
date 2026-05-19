-- int_scouting__paises.sql
--=========================

with stg_list_jug as (
    select * from {{ ref('stg_scouting__listado_jugadores')}}
),

seed_paises as (
    select * from {{ ref('seed_paises') }}
),

stg_list_pais as (
    select distinct
    id_pais,
    nombre_pais
    from stg_list_jug
)

select
    p.id_pais,
    p.nombre_pais,
    s.iso_3 as iso_pais

from stg_list_pais as p
inner join seed_paises as s
    on p.id_pais = s.pais_id