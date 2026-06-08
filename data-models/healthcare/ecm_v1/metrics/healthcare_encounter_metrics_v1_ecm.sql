-- Metric views for domain: encounter | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 16:32:35

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`encounter_drg_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key DRG and LOS performance metrics for hospital finance and capacity planning"
  source: "`healthcare_ecm`.`encounter`.`drg_assignment`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Identifier of the care site where the DRG was assigned"
  measures:
    - name: "total_actual_los_days"
      expr: SUM(CAST(actual_los AS DOUBLE))
      comment: "Total actual length of stay days across all DRG assignments"
    - name: "average_actual_los_days"
      expr: AVG(CAST(actual_los AS DOUBLE))
      comment: "Average actual length of stay per DRG assignment"
    - name: "total_drg_weight"
      expr: SUM(CAST(drg_weight AS DOUBLE))
      comment: "Sum of DRG relative weight values, reflecting resource intensity"
    - name: "average_drg_weight"
      expr: AVG(CAST(drg_weight AS DOUBLE))
      comment: "Average DRG weight, useful for case-mix and reimbursement analysis"
    - name: "drg_assignment_count"
      expr: COUNT(1)
      comment: "Number of DRG assignments (encounter events)"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`encounter_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Visit-level operational KPIs for throughput, readmission, and telehealth adoption"
  source: "`healthcare_ecm`.`encounter`.`visit`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where the visit occurred"
    - name: "visit_type"
      expr: visit_type
      comment: "Type of visit (inpatient, outpatient, emergency, etc.)"
    - name: "admission_source"
      expr: admission_source
      comment: "Source of admission for the visit"
    - name: "discharge_disposition"
      expr: discharge_disposition
      comment: "Disposition at discharge"
  measures:
    - name: "total_visits"
      expr: COUNT(1)
      comment: "Total number of patient visits"
    - name: "readmission_count"
      expr: SUM(CASE WHEN readmission_flag THEN 1 ELSE 0 END)
      comment: "Count of visits that resulted in a readmission"
    - name: "average_expected_los_days"
      expr: AVG(CAST(expected_los_days AS DOUBLE))
      comment: "Average expected length of stay for visits"
    - name: "average_observation_hours"
      expr: AVG(CAST(observation_hours AS DOUBLE))
      comment: "Average observation hours per visit"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`encounter_bed_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bed utilization and assignment efficiency metrics for capacity management"
  source: "`healthcare_ecm`.`encounter`.`bed_assignment`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where the bed assignment took place"
    - name: "unit_code"
      expr: unit_code
      comment: "Unit code of the assigned bed"
    - name: "bed_type"
      expr: bed_type
      comment: "Classification of the bed (e.g., ICU, med-surg)"
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the bed assignment"
  measures:
    - name: "total_bed_assignments"
      expr: COUNT(1)
      comment: "Total number of bed assignments recorded"
    - name: "isolation_bed_count"
      expr: SUM(CASE WHEN is_isolation_bed THEN 1 ELSE 0 END)
      comment: "Number of assignments to isolation-designated beds"
    - name: "private_room_count"
      expr: SUM(CASE WHEN is_private_room THEN 1 ELSE 0 END)
      comment: "Number of assignments to private rooms"
    - name: "average_los_days"
      expr: AVG(CAST(los_days AS DOUBLE))
      comment: "Average length of stay (in days) per bed assignment"
    - name: "average_assignment_wait_minutes"
      expr: AVG((UNIX_TIMESTAMP(assignment_start_timestamp) - UNIX_TIMESTAMP(request_timestamp)) / 60)
      comment: "Average minutes from bed request to assignment start"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`encounter_discharge_summary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and efficiency metrics for discharge documentation"
  source: "`healthcare_ecm`.`encounter`.`discharge_summary`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site associated with the discharge summary"
    - name: "discharge_disposition_code"
      expr: discharge_disposition_code
      comment: "Disposition code at discharge"
  measures:
    - name: "total_discharge_summaries"
      expr: COUNT(1)
      comment: "Total number of discharge summaries created"
    - name: "discharge_instructions_issued_count"
      expr: SUM(CASE WHEN discharge_instructions_issued THEN 1 ELSE 0 END)
      comment: "Count of summaries where discharge instructions were issued"
    - name: "medication_reconciliation_completed_count"
      expr: SUM(CASE WHEN medication_reconciliation_completed THEN 1 ELSE 0 END)
      comment: "Count of summaries with medication reconciliation completed"
    - name: "average_completion_hours"
      expr: AVG((UNIX_TIMESTAMP(summary_finalized_timestamp) - UNIX_TIMESTAMP(created_timestamp)) / 3600)
      comment: "Average time (in hours) from summary creation to finalization"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`encounter_transfer_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transfer request processing efficiency and approval metrics"
  source: "`healthcare_ecm`.`encounter`.`transfer_request`"
  dimensions:
    - name: "primary_transfer_care_site_id"
      expr: primary_transfer_care_site_id
      comment: "Care site initiating the transfer"
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of transfer (e.g., intra-facility, inter-facility)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used for the transfer"
  measures:
    - name: "total_transfer_requests"
      expr: COUNT(1)
      comment: "Total number of transfer requests submitted"
    - name: "approved_transfer_count"
      expr: SUM(CASE WHEN approval_required AND approval_timestamp IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of transfer requests that received approval"
    - name: "denied_transfer_count"
      expr: SUM(CASE WHEN approval_required AND approval_timestamp IS NULL THEN 1 ELSE 0 END)
      comment: "Count of transfer requests that were not approved"
    - name: "average_time_to_approval_minutes"
      expr: AVG((UNIX_TIMESTAMP(approval_timestamp) - UNIX_TIMESTAMP(created_timestamp)) / 60)
      comment: "Average minutes from request creation to approval"
    - name: "average_actual_transfer_minutes"
      expr: AVG((UNIX_TIMESTAMP(actual_transfer_timestamp) - UNIX_TIMESTAMP(request_timestamp)) / 60)
      comment: "Average minutes from request to actual transfer execution"
$$;