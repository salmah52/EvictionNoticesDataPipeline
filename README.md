# EvictionNoticesDataPipeline

## DAG Documentation: Load-Eviction-Data-From-Web-To-GCS-To-BQ

## Introduction:

This Airflow DAG is designed to automate the process of fetching data from the San Francisco Open Data API's EVICTION dataset, storing it in a Google Cloud Storage (GCS) bucket, and subsequently loading the data into a BigQuery table. The DAG is scheduled to run at 6:00 AM every month.

## Data Architecture:
A robust data architecture is crucial for ensuring data quality, integrity, and accessibility. Here's the architecture for your Eviction Notices Data Pipeline:

<img width="584" alt="image" src="https://github.com/salmah52/EvictionNoticesDataPipeline/assets/44398948/a5c105bb-435b-446b-a932-a83996278acf">


1. Data Source:
San Francisco Open Data API (EVICTION dataset)

2. ETL (Extract, Transform, Load) Pipeline:
-Apache Airflow for orchestration and automation
- Custom operators for extracting data from the API and loading it into Google Cloud Storage (GCS)
- Google Cloud Storage (GCS) for intermediate storage of raw data

3. Data Warehouse:
- Google BigQuery for data warehousing
- Create a dedicated dataset in BigQuery (e.g., Main_eviction009)
- Use tables in BigQuery to store raw and transformed data
  
4. Data Transformation:
- dbt (Data Build Tool) for data modeling, transformation, and analytics
- Data Reporting and Visualization:

5. Business Intelligence (BI) tools such as Tableau, Looker, or Google Data Studio


## Dataset Description:
- Name: Eviction Notices
- Category: Housing and Buildings
- Data Source: San Francisco Rent Board
- Description: This dataset contains eviction notices filed with the San Francisco Rent Board as per San Francisco Administrative Code 37.9(c). It's important to note that an eviction notice does not necessarily indicate that a tenant was eventually evicted; therefore, the notices may differ from actual evictions

## Columns in the Dataset- Data Dictionary

- Eviction ID: The internal case record ID used for administrative purposes.
- Address: The address where the eviction notice was issued (block level).
- City: The city where the eviction notice was issued (always San Francisco).
- State: The state where the eviction notice was issued (always CA).
- Eviction Notice Source Zipcode: The zip code where the eviction notice was issued.
- File Date: The date on which the eviction notice was filed with the Rent Board of Arbitration.
- Non Payment: Indicates non-payment of rent as a grounds for eviction.
- Breach: Indicates breach of lease as a grounds for eviction.
- Nuisance: Indicates nuisance as a grounds for eviction.
- Illegal Use: Indicates an illegal use of the rental unit as a grounds for eviction.
- Failure to Sign Renewal: Indicates failure to sign lease renewal as a grounds for eviction.
- Access Denial: Indicates unlawful denial of access to unit as a grounds for eviction.
- Unapproved Subtenant: Indicates the tenant had an unapproved subtenant as a grounds for eviction.
- Owner Move In: Indicates an owner move-in as a grounds for eviction.
- Demolition: Indicates demolition of property as a grounds for eviction.
- Capital Improvement: Indicates a capital improvement as a grounds for eviction.
- Substantial Rehab: Indicates substantial rehabilitation as a grounds for eviction.
- Ellis Act Withdrawal: Indicates an Ellis Act withdrawal (going out of business) as a grounds for eviction.
- Condo Conversion: Indicates a condo conversion as a grounds for eviction.
- Roommate Same Unit: Indicates eviction of a roommate in the same unit as a grounds for eviction.
- Other Cause: Indicates some other cause not covered by the admin code (record keeping).
- Late Payments: Indicates habitual late payment of rent as a grounds for eviction.
- Lead Remediation: Indicates lead remediation as a grounds for eviction.
- Development: Indicates a development agreement as a grounds for eviction.
- Good Samaritan Ends: Indicates the end of the period of good samaritan laws as a grounds for eviction.
- Constraints Date: In cases of certain just cause evictions like Ellis and Owner Move-In, this date represents when relevant constraints apply.
- Supervisor District: District number based on geocoding.
- Neighborhoods - Analysis Boundaries: Analysis neighborhoods corresponding to census boundaries.
- Location: Latitude and longitude of the record's mid-block level.
- Shape: Location of the record as a Point type (latitude and longitude).

## Data Pipeline:

The Eviction Notices Data Pipeline uses Apache Airflow to automate the process. Here's an overview:

1. Start: The DAG begins with a dummy operator.

2. Download to GCS: This task fetches data from the San Francisco Open Data API's EVICTION dataset, specifying the API endpoint, headers, and parameters. The data is stored in a Google Cloud Storage bucket.

Explanation of Code:

The code for this task is defined in the WebToGCSHKOperator class within the WebToGCSHKOperator module. The class takes care of connecting to the API endpoint, retrieving the data, and saving it to a specified GCS bucket. It is scheduled to run at 6:00 AM every month, and the API token and parameters are defined in the task configuration.

3. Upload to BigQuery: Data from GCS is transferred to a BigQuery table. You can specify schema fields, file format, and other details for the data transfer.

Explanation of Code:

The code for this task is defined in the GCSToBigQueryOperator class provided by the Google Cloud provider. This task reads data from the GCS bucket and loads it into a BigQuery table, specifying the destination table, schema fields, and other relevant configurations.

4. End: The DAG concludes with another dummy operator.


## Execution Frequency:

The pipeline is scheduled to run at 6:00 AM every month.

## Logs and Monitoring:

You can monitor task progress and success in the Airflow logs. Check for "INFO" level log entries for detailed task execution information.

## Access to Data:

The data is accessible in BigQuery under the Main_eviction009 dataset, in a table named eviction_data_table. You can run SQL queries for analysis.

## API Query:

You can retrieve data from the EVICTION dataset using the following SoQL query: https://data.sfgov.org/resource/5cei-gny5.json

## Conclusion:

The Eviction Notices Data Pipeline automates data extraction, storage, and analysis from the San Francisco Open Data API. It ensures data integrity and accessibility in Google Cloud Storage and BigQuery for further analysis and reporting.



*Happy data engineering!*

