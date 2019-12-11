FROM python:3.6

RUN apt-get update
RUN apt-get install -y python3-dev
RUN pip install pip --upgrade
RUN pip install dbt

# Root privileges required for copying files
USER root

# Copy configs
COPY dbt dbt

# Pass in environment variable from host shell
ARG AWS_PG_PASSWORD

# Swap hardcoded placeholder with environment variable
RUN sed -i "s/\[PLACEHOLDER\]/$AWS_PG_PASSWORD/g" /dbt/profiles.yml

# Move profile
RUN mkdir -p ~/.dbt
RUN mv /dbt/profiles.yml ~/.dbt/profiles.yml

WORKDIR "/dbt"

CMD ["/bin/sh", "-c", "dbt compile; dbt run"]