-- snp_evolucion.sql
--==================

{% snapshot snp_evolucion %}

{{ config(
    unique_key = 'id_jugador',
    strategy = 'timestamp',
    updated_at = 'fecha_actualizacion'
) }}

with src_atributos as (
    select * from {{ source('scouting','player_attributes') }}
)

select distinct
    player_fifa_api_id as id_jugador,
    date as fecha_actualizacion,
    overall_rating as valoracion_general,
    potential as potencial
from src_atributos
where overall_rating is not null

--ampliar con resumen de atributos

{% endsnapshot %}