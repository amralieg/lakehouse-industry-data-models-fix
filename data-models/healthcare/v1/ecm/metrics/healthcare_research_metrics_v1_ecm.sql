-- Metric views for domain: research | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 16:32:35

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`research_adverse_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key safety KPIs for adverse events, used by clinical safety leadership to monitor event volume and seriousness trends"
  source: "`healthcare_ecm`.`research`.`adverse_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Category of adverse event (e.g., AE, SAE)"
  measures:
    - name: "total_adverse_events"
      expr: COUNT(1)
      comment: "Total number of adverse events recorded"
    - name: "serious_adverse_events"
      expr: SUM(CASE WHEN seriousness_flag THEN 1 ELSE 0 END)
      comment: "Count of adverse events marked as serious"
    - name: "expedited_reports"
      expr: SUM(CASE WHEN expedited_reporting_flag THEN 1 ELSE 0 END)
      comment: "Count of adverse events that were reported via expedited process"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`research_billing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and compliance metrics for research‑related billing activities"
  source: "`healthcare_ecm`.`research`.`billing_event`"
  dimensions:
    - name: "billing_status"
      expr: billing_status
      comment: "Current status of the billing event (e.g., Submitted, Approved)"
  measures:
    - name: "billing_event_count"
      expr: COUNT(1)
      comment: "Total number of billing events captured"
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Aggregate charge amount across all billing events"
    - name: "average_charge_amount"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge amount per billing event"
    - name: "compliant_billing_events"
      expr: SUM(CASE WHEN compliance_flag THEN 1 ELSE 0 END)
      comment: "Number of billing events flagged as compliance‑checked"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`research_deidentified_dataset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data governance metrics for de‑identified research datasets"
  source: "`healthcare_ecm`.`research`.`deidentified_dataset`"
  dimensions:
    - name: "dataset_type"
      expr: dataset_type
      comment: "Logical classification of the dataset (e.g., Clinical, Genomic)"
  measures:
    - name: "dataset_count"
      expr: COUNT(1)
      comment: "Total number of de‑identified datasets created"
    - name: "total_dataset_size_mb"
      expr: SUM(CAST(dataset_size_mb AS DOUBLE))
      comment: "Cumulative size of all datasets in megabytes"
    - name: "average_dataset_size_mb"
      expr: AVG(CAST(dataset_size_mb AS DOUBLE))
      comment: "Average size per dataset"
    - name: "cfr_part_11_compliant_datasets"
      expr: SUM(CASE WHEN cfr_part_11_compliant_flag THEN 1 ELSE 0 END)
      comment: "Count of datasets that are CFR Part 11 compliant"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`research_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Portfolio‑level overview of research studies for executive steering"
  source: "`healthcare_ecm`.`research`.`research_study`"
  dimensions:
    - name: "phase"
      expr: phase
      comment: "Clinical trial phase (e.g., Phase I, II, III)"
  measures:
    - name: "study_count"
      expr: COUNT(1)
      comment: "Total number of research studies in the portfolio"
    - name: "active_studies"
      expr: SUM(CASE WHEN study_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of studies currently active"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`research_subject_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational metrics on subject enrollment health and safety"
  source: "`healthcare_ecm`.`research`.`subject_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the enrollment (e.g., Enrolled, Withdrawn)"
  measures:
    - name: "enrollment_count"
      expr: COUNT(1)
      comment: "Total subject enrollments recorded"
    - name: "enrollments_with_adverse_event"
      expr: SUM(CASE WHEN adverse_event_flag THEN 1 ELSE 0 END)
      comment: "Enrollments where an adverse event was flagged"
    - name: "enrollments_with_protocol_deviation"
      expr: SUM(CASE WHEN protocol_deviation_flag THEN 1 ELSE 0 END)
      comment: "Enrollments where a protocol deviation was recorded"
$$;