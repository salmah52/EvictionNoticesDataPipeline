# EvictionNoticesDataPipeline

## DAG Documentation: Load-Eviction-Data-From-Web-To-GCS-To-BQ

## Introduction:

This Airflow DAG is designed to automate the process of fetching data from the San Francisco Open Data API's EVICTION dataset, storing it in a Google Cloud Storage (GCS) bucket, and subsequently loading the data into a BigQuery table. The DAG is scheduled to run at 6:00 AM every month.

## Data Architecture:
A robust data architecture is crucial for ensuring data quality, integrity, and accessibility. Here's the architecture for your Eviction Notices Data Pipeline:

![Data Architecture](https://github.com/salmah52/EvictionNoticesDataPipeline/assets/44398948/a5c105bb-435b-446b-a932-a83996278acf)

1. Data Source:
   - San Francisco Open Data API (EVICTION dataset)

2. ETL (Extract, Transform, Load) Pipeline:
   - Apache Airflow for orchestration and automation
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
- **Name:** Eviction Notices
- **Category:** Housing and Buildings
- **Data Source:** San Francisco Rent Board
- **Description:** This dataset contains eviction notices filed with the San Francisco Rent Board as per San Francisco Administrative Code 37.9(c).


## Columns in the Dataset- Data Dictionary

## Rows - 421k   
## Columns - 30


- **Eviction ID (Text):** The internal case record ID used for administrative purposes.
- **Address (Text):** The address where the eviction notice was issued (block level).
- **City (Text):** The city where the eviction notice was issued (always San Francisco).
- **State (Text):** The state where the eviction notice was issued (always CA).
- **Eviction Notice Source Zipcode (Text):** The zip code where the eviction notice was issued.
- **File Date (Date & Time):** The date on which the eviction notice was filed with the Rent Board of Arbitration.
- **Non Payment (Boolean):** Indicates non-payment of rent as grounds for eviction.
- **Breach (Boolean):** Indicates a breach of the lease as grounds for eviction.
- **Nuisance (Boolean):** Indicates nuisance as grounds for eviction.
- **Illegal Use (Boolean):** Indicates an illegal use of the rental unit as grounds for eviction.
- **Failure to Sign Renewal (Boolean):** Indicates failure to sign a lease renewal as grounds for eviction.
- **Access Denial (Boolean):** Indicates unlawful denial of access to the unit as grounds for eviction.
- **Unapproved Subtenant (Boolean):** Indicates that the tenant had an unapproved subtenant as grounds for eviction.
- **Owner Move In (Boolean):** Indicates an owner move-in as grounds for eviction.
- **Demolition (Boolean):** Indicates demolition of the property as grounds for eviction.
- **Capital Improvement (Boolean):** Indicates a capital improvement as grounds for eviction.
- **Substantial Rehab (Boolean):** Indicates substantial rehabilitation as grounds for eviction.
- **Ellis Act Withdrawal (Boolean):** Indicates an Ellis Act withdrawal (going out of business) as grounds for eviction.
- **Condo Conversion (Boolean):** Indicates a condo conversion as grounds for eviction.
- **Roommate Same Unit (Boolean):** Indicates eviction of a roommate in the same unit as grounds for eviction.
- **Other Cause (Boolean):** Indicates some other cause not covered by the admin code (record keeping).
- **Late Payments (Boolean):** Indicates habitual late payment of rent as grounds for eviction.
- **Lead Remediation (Boolean):** Indicates lead remediation as grounds for eviction.
- **Development (Boolean):** Indicates a development agreement as grounds for eviction.
- **Good Samaritan Ends (Boolean):** Indicates the end of the period of good Samaritan laws as grounds for eviction.
- **Constraints Date (Date & Time):** In cases of certain just cause evictions like Ellis and Owner Move-In, this date represents when relevant constraints apply.
- **Supervisor District (Number):** District number based on geocoding.
- **Neighborhoods - Analysis Boundaries (Text):** Analysis neighborhoods corresponding to census boundaries.
- **Location (Location):** Latitude and longitude of the record's mid-block level.
- **Shape (Point):** Location of the record as a Point type (latitude and longitude).

## Data Pipeline:

The Eviction Notices Data Pipeline uses Apache Airflow to automate the process. Here's an overview:

1. **Start:** The DAG begins with a dummy operator.

2. **Download to GCS:** This task fetches data from the San Francisco Open Data API's EVICTION dataset, specifying the API endpoint, headers, and parameters. The data is stored in a Google Cloud Storage bucket.

   **Explanation of Code:**
   The code for this task is defined in the `WebToGCSHKOperator` class within the `WebToGCSHKOperator` module. The class takes care of connecting to the API endpoint, retrieving the data, and saving it to a specified GCS bucket. It is scheduled to run at 6:00 AM every month, and the API token and parameters are defined in the task configuration.

3. **Upload to BigQuery:** Data from GCS is transferred to a BigQuery table. You can specify schema fields, file format, and other details for the data transfer.

   **Explanation of Code:**
   The code for this task is defined in the `GCSToBigQueryOperator` class provided by the Google Cloud provider. This task reads data from the GCS bucket and loads it into a BigQuery table, specifying the destination table, schema fields, and other relevant configurations.

4. **End:** The DAG concludes with another dummy operator.

## Execution Frequency:

The pipeline is scheduled to run at 6:00 AM every month.

## Logs and Monitoring:

You can monitor task progress and success in the Airflow logs. Check for "INFO" level log entries for detailed task execution information.

## Error Handling:

In case of errors or failures, the pipeline is designed to handle them gracefully. For example, when the API is unavailable, the pipeline logs the error and retries the API call after a specified delay. If there are schema mismatches during the BigQuery upload, the pipeline can be configured to skip or handle them according to your defined rules.

## Data Validation:

Data validation checks are performed before data is loaded into BigQuery to ensure data completeness, consistency, and accuracy. Any data that does not conform to validation rules is flagged and logged for review.

## Authentication and Authorization:

Access to the pipeline and its components is secured using authentication and authorization mechanisms. Permissions are granted based on the principle of least privilege to restrict access to sensitive data and operations.

## Monitoring and Alerting:

Monitoring and alerting tools such as Stackdriver or Prometheus can be used to keep an eye on the pipeline's health.

## Scalability and Performance:

The pipeline is designed to handle large volumes of data efficiently. It can be scaled horizontally or vertically based on the changing data requirements. The performance of the pipeline is optimized to ensure data processing within defined SLAs.

## Data Retention:

Data retention policies are in place. For example, data is stored in GCS for a defined period, and there's a process for data archiving and purging as needed.

## DBT Integration:

To further enhance data transformation and modeling, dbt (Data Build Tool) is integrated into the pipeline. dbt models are structured to perform transformations and analytics on the data before it's made available for reporting and visualization.

## Pipeline Version Control:

Pipeline versions are managed to ensure proper documentation of changes and updates. Version control systems such as Git can be used to track pipeline code and configuration changes.

## Access to Data:

The data is accessible in BigQuery under the Main_eviction009 dataset, in a table named eviction_data_table. You can run SQL queries for analysis.

## API Query:

You can retrieve data from the EVICTION dataset using the following SoQL query: [https://data.sfgov.org/resource/5cei-gny5.json](https://data.sfgov.org/resource/5cei-gny5.json)

## Conclusion:

The Eviction Notices Data Pipeline automates data extraction, storage, and analysis from the San Francisco Open Data API. It ensures data integrity and accessibility in Google Cloud Storage and BigQuery for further analysis and reporting.

*Happy data engineering!*
