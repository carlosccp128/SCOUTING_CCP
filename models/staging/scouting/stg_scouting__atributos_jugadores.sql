-- stg_scouting__atributos_jugadores.sql
--======================================

with src_player_attributes as (
    select * from {{ source('scouting', 'player_attributes') }}
),

jugadores as (
    select * from {{ source('scouting', 'player') }}
),

renamed as (
    select
        att.player_fifa_api_id as id_jugador,
        date as fecha_actualizacion,
        overall_rating as valoracion_general,
        potential as potencial,
        case
            when lower(trim(preferred_foot)) = 'left' then 'Izquierda'
            when lower(trim(preferred_foot)) = 'right' then 'Derecha'
            else 'Desconocida'
        end as pierna_habil,
        case
            when lower(trim(defensive_work_rate)) = 'low' then 'Bajo'
            when lower(trim(defensive_work_rate)) = 'medium' then 'Medio'
            when lower(trim(defensive_work_rate)) = 'high' then 'Alto'
            else 'Desconocido'
        end as trabajo_defensivo,
        case
            when lower(trim(attacking_work_rate)) = 'low' then 'Bajo'
            when lower(trim(attacking_work_rate)) = 'medium' then 'Medio'
            when lower(trim(attacking_work_rate)) = 'high' then 'Alto'
            else 'Desconocido'
        end as trabajo_ofensivo,
        crossing as centros,
        finishing as definicion,
        heading_accuracy as precision_cabeza,
        short_passing as pases_cortos,
        volleys as voleas,
        dribbling as regates,
        curve as efecto,
        free_kick_accuracy as precision_faltas,
        long_passing as pases_largos,
        ball_control as control_balon,
        acceleration as aceleracion,
        sprint_speed as velocidad,
        agility as agilidad,
        reactions as reflejos,
        balance as equilibrio,
        shot_power as potencia_tiro,
        jumping as salto,
        stamina as resistencia,
        strength as fuerza,
        long_shots as tiros_lejanos,
        aggression as agresividad,
        interceptions as intercepciones,
        positioning as posicion_ataque,
        vision as vision,
        penalties as penaltis,
        marking as marcaje,
        standing_tackle as robos,
        sliding_tackle as entrada_agresiva,
        gk_diving as estirada,
        gk_handling as paradas,
        gk_kicking as saques,
        gk_positioning as colocacion,
        gk_reflexes as reflejos_portero

    from src_player_attributes as att
    inner join jugadores as j
    on att.player_fifa_api_id = j.player_fifa_api_id
    where overall_rating is not null
        and fecha_actualizacion > '2010-08-12'


    --eliminamos los registros 'malos', que no tienen jugador
    -- en la tabla jugadores (los jugadores a observar).
    -- Y los que son nulos, que son registros que no sirven con el overall,
    --Además filtramos por fecha porque se recogian menos estadísticas
)

select * from renamed