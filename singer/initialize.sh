# Swap hardcoded placeholder with computed date
sed "s/\[PLACEHOLDER\]/$(date -d "-1 month" +%F)/g" fx_config.json > fx.json

# Execute command
tap-exchangeratesapi -c fx.json | target-postgres -c pg_config.json
