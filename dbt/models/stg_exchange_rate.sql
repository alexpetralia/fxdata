{{
  config(
    materialized='incremental'
  )
}}

SELECT date, (H).key AS ccy, (H).value::float AS rate
FROM (
  SELECT date::date, EACH(hstore(tbl) - 'date'::text) AS H
  FROM exchange_rate AS tbl
) AS tmp
WHERE (H).key NOT LIKE '_sdc%'

{% if is_incremental() %}
  AND date::date > (SELECT MAX(date::date) FROM {{ this }})
{% endif %}
