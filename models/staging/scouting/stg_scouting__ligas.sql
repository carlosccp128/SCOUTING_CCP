-- stg_scouting__ligas.sql
--========================

with src_league as (
    select * from {{ source('scouting', 'league') }}
),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['trim(name)']) }} as id_liga,
        country_id as id_pais_liga,
        trim(name) as nombre_liga

    from src_league
)
select * from renamed