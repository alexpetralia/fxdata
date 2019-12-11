FROM python:3.6

RUN apt-get update
RUN apt-get install -y python3-dev
RUN pip install pip --upgrade
RUN pip install tap-exchangeratesapi singer-target-postgres

# Root privileges required for copying files
USER root

# Copy configs
COPY . .

# Pass in environment variable from host shell
ARG AWS_PG_PASSWORD

# Swap hardcoded placeholder with environment variable
RUN sed -i "s/\[PLACEHOLDER\]/$AWS_PG_PASSWORD/g" pg_config.json

ENTRYPOINT ["sh", "./initialize.sh"]
CMD ["/bin/sh", "-c"]