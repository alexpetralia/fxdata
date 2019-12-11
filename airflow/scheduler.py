from datetime import datetime, timedelta

from airflow import DAG
from airflow.operators.bash_operator import BashOperator

default_args = {
    "owner": "default",
    "email": ["default@default.com"],
    "retry_interval": timedelta(minutes=15),
    "email_on_failure": False,
    "email_on_retry": False,
    "provide_context": True,
}

schedule = "0 0 * * *"

with DAG(
        "fx",
        schedule_interval=schedule,
        default_args=default_args) as dag:

    singer_dag = BashOperator(
        task_id="singer_dag",
        bash_command="docker-compose run singer",
    )

    dbt_dag = BashOperator(
        task_id="dbt_dag",
        bash_command="docker-compose run dbt",
    )

    dag << singer_dag << dbt_dag
