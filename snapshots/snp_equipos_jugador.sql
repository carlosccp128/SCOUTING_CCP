--snapshots/snp_equipos_jugador.sql
--==================================


{% snapshot snp_equipos_jugador %}
{{ config(
    unique_key    = 'sofifa_id',
    strategy      = 'timestamp',
    updated_at    = 'desde',
    hard_deletes  = 'invalidate'
) }}

SELECT 
    sofifa_id,
    nombre_jugador,
    equipo,
    desde

FROM {{ source('scouting','cambios_equipos_jug' ) }}


{% endsnapshot %}

