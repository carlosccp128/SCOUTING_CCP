-- stg_scouting__pais.sql
--========================

with src_country as (
    select * from {{ source('scouting', 'country') }}
),

seed_paises as (
    select * from {{ref('seed_paises')}}
),

renamed as (

    select
        c.id as id_pais_liga,
        trim(p.pais_esp) as nombre_pais

    from src_country as c
    left join seed_paises as p
        on trim(c.name) = trim(p.pais_eng)
)

select * from renamed