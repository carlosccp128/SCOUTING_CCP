-- stg_scouting__listado_jugadores.sql
--====================================

with src_player_annual as (
    select * from {{ source('scouting', 'player_f15_annual') }}
),
seed_paises as (
    select * from {{ref('seed_paises')}}
),
seed_posiciones  as (
    select * from {{ref('seed_posiciones')}}
),

pais_position as (

    select
        sofifa_id,
        short_name,
        long_name,
        strtok(player_positions,',', 1) as main_position,
        overall,
        potential,
        value_eur,
        wage_eur,
        dob,
        height_cm,
        weight_kg,
        club_team_id,
        club_name,
        league_name,
        league_level,
        nationality_id,
        trim(p.pais_esp) as nombre_pais, -- cambia esto
        preferred_foot,
        weak_foot,
        skill_moves,
        work_rate,
        pace,
        shooting,
        passing,
        dribbling,
        defending,
        physic

    from src_player_annual as j
    left join seed_paises as p
        on trim(lower(j.nationality_name)) = trim(lower(p.pais_eng))
),

position_esp as (

    select
        sofifa_id,
        short_name,
        long_name,
        p.posicion_id as posicion_id,
        p.posicion_esp as posicion_nombre,
        p.acronimo_esp as posicion,
        overall,
        potential,
        value_eur,
        wage_eur,
        dob,
        height_cm,
        weight_kg,
        club_team_id,
        club_name,
        league_name,
        league_level,
        nationality_id,
        nombre_pais,
        preferred_foot,
        weak_foot,
        skill_moves,
        work_rate,
        pace,
        shooting,
        passing,
        dribbling,
        defending,
        physic

    from pais_position as a
    left join seed_posiciones as p
        on trim(a.main_position) = trim(p.acronimo_eng)
),


renamed as (
    select
        sofifa_id as id_jugador,
        short_name as nombre_jugador_corto,
        long_name as nombre_jugador_largo,
        coalesce(posicion_id, 0)
        coalesce(posicion_nombre, 'Desconocida')
        coalesce(posicion, 'N/A')
        overall as valoracion_general,
        potential as potencial,
        coalesce(value_eur, 0) as valor_mercado,
        coalesce(wage_eur,0) as salario_semanal,
        dob as fecha_nacimiento,
        height_cm as altura_cm,
        weight_kg as peso_kg,
        coalesce(club_team_id,0) as id_equipo,
        coalesce(club_name, 'Agentes libres') as nombre_equipo,
        {{ dbt_utils.generate_surrogate_key(["trim(coalesce(league_name,'Mercado de Fichajes'))"]) }} as id_liga,
        coalesce(league_name, 'Mercado de Fichajes') as nombre_liga,
        coalesce(league_level,0) as division_liga,
        nationality_id as id_pais,
        nombre_pais,
        case
            when lower(trim(preferred_foot)) = 'left' then 'Izquierda'
            when lower(trim(preferred_foot)) = 'right' then 'Derecha'
            else 'Desconocida'
        end as pierna_habil,
        weak_foot as pierna_mala,
        skill_moves as filigranas,
        case
            when lower(strtok(work_rate,'/', 2)) = 'low' then 'Bajo'
            when lower(strtok(work_rate,'/', 2)) = 'medium' then 'Medio'
            when lower(strtok(work_rate,'/', 2)) = 'high' then 'Alto'
            else 'Desconocido'
        end as trabajo_defensivo,
        case
            when lower(strtok(work_rate,'/', 1)) = 'low' then 'Bajo'
            when lower(strtok(work_rate,'/', 1)) = 'medium' then 'Medio'
            when lower(strtok(work_rate,'/', 1)) = 'high' then 'Alto'
            else 'Desconocido'
        end as trabajo_ofensivo,
        coalesce(pace,1) as ritmo,
        coalesce(shooting,1) as tiro,
        coalesce(passing,1) as pase,
        coalesce(dribbling,1) as regates,
        coalesce(defending,1) as defensa,
        coalesce(physic,1) as fisico

    from position_esp

)

select * from renamed