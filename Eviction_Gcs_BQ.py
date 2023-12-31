# Import necessary modules
# DAG File: The DAG file responsible for orchestrating the data pipeline and executing the SoQL query.
from airflow import DAG
import os
from datetime import datetime, timedelta
from web.operators.Eviction_operator import WebToGCSHKOperator
from airflow.providers.google.cloud.transfers.gcs_to_bigquery import GCSToBigQueryOperator
from airflow.operators.dummy import DummyOperator

# Define your default arguments for the DAG
default_args = {
    'owner': 'airflow',
    'start_date': datetime(2023, 1, 1),  # Set the initial execution date
    "email_on_failure": True,  # Send email on task failure
    "email_on_retry": False,  # Do not send email on task retries
    "retries": 2,  # Number of retries for each task
    "retry_delay": timedelta(minutes=1),  # Delay between retries
}

# Retrieve environment variables
PROJECT_ID = os.environ.get("GCP_PROJECT_ID")
BUCKET = os.environ.get("GCP_GCS_BUCKET")
DATASET = "Main_eviction009"
OBJECT = "eviction_data"

# Create your DAG with a unique identifier ('data_fetch_dag')
with DAG(dag_id="Load-Eviction-Data-From-Web-To-GCS-To-BQ",
     default_args=default_args,  # Use the default arguments defined above
     schedule_interval="0 6 2 * *",  # Schedule the DAG to run at a specific time 6:00am every month
     ) as dag:

    # Create a starting dummy operator
    start = DummyOperator(task_id='start')

    # Fetch and store data from an API into Google Cloud Storage
    download_to_gcs = WebToGCSHKOperator(
        task_id='download_to_gcs',
        gcs_bucket_name='eviction_data009',  # Specify the Google Cloud Storage bucket name
        gcs_object_name='eviction_data.csv',  # Specify the GCS object name
        api_endpoint='https://data.sfgov.org/resource/5cei-gny5.json',  # API endpoint URL
        api_headers={
            "X-App-Token": '1dx1fuPevH4rCPF5ENqzUiZjA',  # API token header
            "X-App-Secret": '2Enk5UhGiuhH7hnsOH2bxEPv-z1eYffDG80q',  # API secret header
        },
        api_params={
            "$limit": 2000,  # API parameters
        },
    )

    # Push data from Google Cloud Storage to BigQuery
    upload_to_bigquery = GCSToBigQueryOperator(
        task_id='upload_to_bigquery',
        source_objects=['eviction_data.csv'],  # Source object(s) in GCS
        destination_project_dataset_table=f"{DATASET}.{OBJECT}_table",  # Destination BigQuery table
        schema_fields=[],  # Define schema fields if needed
        skip_leading_rows=1,  # Skip leading rows in CSV
        source_format='CSV',  # Source file format
        field_delimiter=',',  # Delimiter used in CSV
        create_disposition='CREATE_IF_NEEDED',  # Create the table if it doesn't exist
        write_disposition='WRITE_TRUNCATE',  # Overwrite existing data in the table
        autodetect=True,  # Automatically detect schema
        bucket="eviction_data009",  # Specify the GCS bucket
    )

    # Create an ending dummy operator
    end = DummyOperator(task_id='end')

    # Define task dependencies
    start >> download_to_gcs >> upload_to_bigquery >> end

# Log messages to track task progress
download_to_gcs.doc = """
## Download to GCS Task
This task is responsible for fetching data from the San Francisco Open Data API's EVICTION dataset and storing it in a Google Cloud Storage (GCS) bucket. The task connects to the API endpoint with the specified API token and parameters and saves the data as a CSV file in the GCS bucket. The CSV file is used as the source for the subsequent task.
"""

upload_to_bigquery.doc = """
## Upload to BigQuery Task
In this task, data from the Google Cloud Storage (GCS) bucket is transferred to a BigQuery table. The task specifies the destination table in BigQuery and handles schema fields, source file format, and other relevant configurations. Data is loaded into BigQuery with options to create the table if it doesn't exist and to write/truncate existing data if needed. This task ensures that the data is available in BigQuery for further analysis.
"""

# Rest of the DAG and tasks remain the same
