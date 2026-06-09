-- Metric views for domain: data | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 12:58:41

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`data_dataset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for datasets covering volume, quality, and accessibility."
  source: "`genomics_biotech_ecm`.`data`.`dataset`"
  dimensions:
    - name: "dataset_type"
      expr: dataset_type
      comment: "Type of dataset (e.g., raw, processed)"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region associated with the dataset"
    - name: "sensitivity_classification"
      expr: sensitivity_classification
      comment: "Data sensitivity classification"
    - name: "is_public"
      expr: is_public
      comment: "Flag indicating if dataset is public"
    - name: "is_deprecated"
      expr: is_deprecated
      comment: "Flag indicating if dataset is deprecated"
    - name: "data_source"
      expr: data_source
      comment: "Source system of the dataset"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the dataset record was created"
  measures:
    - name: "total_datasets"
      expr: COUNT(1)
      comment: "Total number of dataset records"
    - name: "public_datasets"
      expr: COUNT(CASE WHEN is_public THEN 1 END)
      comment: "Number of datasets marked as public"
    - name: "deprecated_datasets"
      expr: COUNT(CASE WHEN is_deprecated THEN 1 END)
      comment: "Number of deprecated datasets"
    - name: "total_records"
      expr: SUM(CAST(record_count AS DOUBLE))
      comment: "Sum of record counts across all datasets"
    - name: "total_size_gb"
      expr: SUM(CAST(size_bytes AS DOUBLE))/1073741824
      comment: "Total size of datasets in gigabytes"
    - name: "avg_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across datasets"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`data_access_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Access request activity metrics to monitor demand, approval rates and commercial usage."
  source: "`genomics_biotech_ecm`.`data`.`access_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Current status of the access request"
    - name: "request_type"
      expr: request_type
      comment: "Type/category of the request"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the request"
    - name: "data_sensitivity_level"
      expr: data_sensitivity_level
      comment: "Sensitivity level of the requested data"
    - name: "commercial_use_flag"
      expr: commercial_use_flag
      comment: "Indicates if commercial use is requested"
    - name: "submission_date"
      expr: DATE_TRUNC('day', submission_timestamp)
      comment: "Date the request was submitted"
  measures:
    - name: "total_requests"
      expr: COUNT(1)
      comment: "Total number of access requests"
    - name: "approved_requests"
      expr: COUNT(CASE WHEN request_status = 'Approved' THEN 1 END)
      comment: "Number of requests with status Approved"
    - name: "commercial_requests"
      expr: COUNT(CASE WHEN commercial_use_flag THEN 1 END)
      comment: "Number of requests that include commercial use"
    - name: "high_priority_requests"
      expr: COUNT(CASE WHEN priority_level = 'High' THEN 1 END)
      comment: "Number of high‑priority requests"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`data_fair_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "FAIR compliance assessment metrics for data assets."
  source: "`genomics_biotech_ecm`.`data`.`fair_assessment`"
  dimensions:
    - name: "overall_fair_maturity_level"
      expr: overall_fair_maturity_level
      comment: "FAIR maturity level of the assessment"
    - name: "assessment_date"
      expr: assessment_date
      comment: "Date the FAIR assessment was performed"
    - name: "target_asset_type"
      expr: target_asset_type
      comment: "Type of the asset being assessed"
    - name: "elixir_fair_compliant"
      expr: elixir_fair_compliant
      comment: "Flag indicating ELIXIR FAIR compliance"
  measures:
    - name: "total_fair_assessments"
      expr: COUNT(1)
      comment: "Total number of FAIR assessments"
    - name: "avg_fair_score"
      expr: AVG(CAST(overall_fair_score AS DOUBLE))
      comment: "Average overall FAIR score"
    - name: "elixir_compliant_count"
      expr: COUNT(CASE WHEN elixir_fair_compliant THEN 1 END)
      comment: "Number of assessments compliant with ELIXIR FAIR"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`data_quality_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data quality assessment metrics to track overall data health and remediation needs."
  source: "`genomics_biotech_ecm`.`data`.`quality_assessment`"
  dimensions:
    - name: "data_domain"
      expr: data_domain
      comment: "Domain of the data asset"
    - name: "remediation_required_flag"
      expr: remediation_required_flag
      comment: "Flag indicating remediation is required"
    - name: "assessment_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the quality assessment was created"
  measures:
    - name: "total_quality_assessments"
      expr: COUNT(1)
      comment: "Total number of quality assessments performed"
    - name: "avg_overall_dq_score"
      expr: AVG(CAST(overall_dq_score AS DOUBLE))
      comment: "Average overall data quality score"
    - name: "avg_accuracy_score"
      expr: AVG(CAST(accuracy_score AS DOUBLE))
      comment: "Average accuracy score"
    - name: "avg_completeness_score"
      expr: AVG(CAST(completeness_score AS DOUBLE))
      comment: "Average completeness score"
    - name: "avg_timeliness_score"
      expr: AVG(CAST(timeliness_score AS DOUBLE))
      comment: "Average timeliness score"
    - name: "remediation_required_count"
      expr: COUNT(CASE WHEN remediation_required_flag THEN 1 END)
      comment: "Number of assessments that flagged remediation"
$$;