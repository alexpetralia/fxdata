WITH rates AS (
  SELECT * FROM {{ ref('stg_exchange_rate') }}
)

-- 5 day trailing average
SELECT date, ccy,
AVG(rate::float) OVER (
  PARTITION BY ccy ORDER BY date ASC ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
) AS trailing_avg_5d
FROM rates
