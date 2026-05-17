-- stg_scouting__ligas.sql
--========================

with src_league as (
    select * from {{ source('scouting', 'league') }}
),

renamed as (

    select
        country_id as id_pais_liga,
        trim(name) as nombre_liga

    from src_league

)
select * from renamed