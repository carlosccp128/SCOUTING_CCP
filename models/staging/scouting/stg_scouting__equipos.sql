-- stg_scouting__equipos.sql
--=======================

with src_team as (
    select * from {{ source('scouting', 'team') }}
),

no_nulos as (
    select *
    from src_team
    where team_fifa_api_id is not null
),

sin_duplicados as (
    {{dbt_utils.deduplicate(
        relation='no_nulos',
        partition_by='team_fifa_api_id',
        order_by='id desc'
    )}}
),
renamed as (

    select
        team_fifa_api_id as id_equipo,
        trim(team_long_name) as nombre_equipo,
        cast(team_short_name as char(3)) as acronimo_equipo

    from sin_duplicados
)

select * from renamed