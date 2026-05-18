-- fct_atributos.sql
--==================

{{
    config(
        materialized='incremental',
        unique_key='id_jugador',
        incremental_strategy='merge'
    )
}}

with nuevos_reg as (
    select *
    from {{ ref('int_scouting__atributos_jugadores') }}

    {% if is_incremental() %}
        where fecha_actualizacion > (select max(fecha_actualizacion) from {{ this }})
    {% endif %}
),

reg_limpios as (
select
    *,
from nuevos_reg
qualify row_number() over (
        partition by id_jugador
        order by fecha_actualizacion desc
    ) = 1
),

int_jugadores as (
    select * from {{ ref('int_scouting__jugadores') }}
)

select
    j.posicion_id,
    j.id_equipo,
    j.id_liga,
    j.id_pais,
    a.*
from reg_limpios as a
inner join int_jugadores as j
    on a.id_jugador = j.id_jugador
