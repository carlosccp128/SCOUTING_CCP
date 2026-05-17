-- int_scouting__equipos.sql
--=========================
with stg_paises as (
    select * from {{ ref('stg_scouting__equipos') }}
),
