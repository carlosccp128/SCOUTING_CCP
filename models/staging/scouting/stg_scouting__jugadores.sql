-- stg_scouting__jugadores.sql
--=======================

with 
src_player as (
    select * from {{ source('scouting', 'player') }}
),

renamed as (

    select
        player_name as nombre_jugador,
        player_fifa_api_id as id_jugador,
        birthday as fecha_nacimiento,
        height as altura_cm,
        round(weight * 0.45359237,1) as peso_kg

    from src_player

)

select * from renamed