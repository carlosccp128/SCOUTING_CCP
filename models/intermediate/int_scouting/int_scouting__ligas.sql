-- int_scouting__ligas.sql
--=========================
with stg_paises as (
    select * from {{ ref('stg_scouting__ligas') }}
),
