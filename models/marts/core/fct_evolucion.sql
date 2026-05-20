-- fct_evolucion.sql
--==================

{{ config(
        materialized='incremental',
        incremental_strategy='append'
) }}


with nuevos_reg as(
    select
        id_jugador,
        fecha_actualizacion,
        valoracion_general,
        potencial
    from {{ ref('stg_scouting__atributos_jugadores') }}

    {% if is_incremental() %}
    WHERE fecha_actualizacion > (SELECT MAX(fecha_actualizacion) FROM {{ this }})
    {% endif %}
),

stg_list as (
    select * from {{ ref('stg_scouting__listado_jugadores') }}
)

select
    s.id_jugador,
    s.fecha_actualizacion,
    s.valoracion_general,
    s.potencial,
    l.posicion_id,
    l.id_equipo,
    l.id_liga,
    l.id_pais
from nuevos_reg as s
left join stg_list as l
    on s.id_jugador = l.id_jugador

--ampliar con resumen de atributos