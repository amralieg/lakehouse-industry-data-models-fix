-- Metric views for domain: safety | Business: Construction | Version: 1 | Generated on: 2026-05-07 07:27:43

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core incident performance metrics for executive safety oversight"
  source: "`construction_ecm`.`safety`.`incident`"
  dimensions:
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident (e.g., Open, Closed)"
    - name: "incident_type"
      expr: incident_type
      comment: "Classification of incident (e.g., Slip, Fall, Equipment)"
    - name: "incident_severity"
      expr: severity
      comment: "Severity level of the incident"
    - name: "incident_date"
      expr: DATE_TRUNC('day', occurred_at)
      comment: "Date of incident occurrence"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of safety incidents recorded"
    - name: "lti_incidents"
      expr: COUNT(CASE WHEN is_lti THEN 1 END)
      comment: "Count of Lost Time Injuries (LTI) incidents"
    - name: "total_property_damage"
      expr: SUM(CAST(property_damage_amount AS DOUBLE))
      comment: "Sum of monetary property damage associated with incidents"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`safety_hazard_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key hazard register metrics to monitor risk exposure"
  source: "`construction_ecm`.`safety`.`hazard_register`"
  dimensions:
    - name: "hazard_category"
      expr: hazard_category
      comment: "Broad category of the hazard"
    - name: "hazard_status"
      expr: hazard_status
      comment: "Current status of the hazard (e.g., Active, Closed)"
    - name: "site_id"
      expr: site_id
      comment: "Site where the hazard is located"
    - name: "identified_month"
      expr: DATE_TRUNC('month', identified_date)
      comment: "Month the hazard was identified"
  measures:
    - name: "total_hazards"
      expr: COUNT(1)
      comment: "Total number of hazards logged"
    - name: "high_risk_hazards"
      expr: COUNT(CASE WHEN residual_risk_level = 'High' THEN 1 END)
      comment: "Count of hazards with residual risk level marked as High"
    - name: "permit_required_hazards"
      expr: COUNT(CASE WHEN permit_to_work_required THEN 1 END)
      comment: "Count of hazards that require a permit to work"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`safety_hse_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection effectiveness and compliance metrics"
  source: "`construction_ecm`.`safety`.`hse_inspection`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Status of the inspection (e.g., Completed, Pending)"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of HSE inspection"
    - name: "inspection_month"
      expr: DATE_TRUNC('month', inspection_date)
      comment: "Month of the inspection"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of HSE inspections performed"
    - name: "avg_ppe_compliance_rate"
      expr: AVG(CAST(ppe_compliance_rate AS DOUBLE))
      comment: "Average PPE compliance rate across inspections"
    - name: "inspections_with_stop_work"
      expr: COUNT(CASE WHEN stop_work_issued THEN 1 END)
      comment: "Count of inspections that resulted in a stop‑work order"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`safety_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic audit performance indicators for safety governance"
  source: "`construction_ecm`.`safety`.`safety_audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit"
    - name: "audit_type"
      expr: audit_type
      comment: "Type/category of the safety audit"
    - name: "site_id"
      expr: site_id
      comment: "Site where audit was performed"
    - name: "audit_month"
      expr: DATE_TRUNC('month', audit_date)
      comment: "Month of the audit"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total safety audits conducted"
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across audits"
    - name: "audits_with_major_nc"
      expr: COUNT(CASE WHEN CAST(major_nc_count AS DOUBLE) > 0 THEN 1 END)
      comment: "Count of audits that identified at least one major non‑conformance"
    - name: "audits_with_stop_work"
      expr: COUNT(CASE WHEN stop_work_issued THEN 1 END)
      comment: "Count of audits that resulted in a stop‑work issuance"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`safety_environmental_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental monitoring KPIs to track compliance and exposure"
  source: "`construction_ecm`.`safety`.`environmental_monitoring`"
  dimensions:
    - name: "site_id"
      expr: site_id
      comment: "Site where monitoring took place"
    - name: "monitoring_parameter"
      expr: monitoring_parameter
      comment: "Environmental parameter being monitored (e.g., PM2.5, Noise)"
    - name: "measurement_date"
      expr: DATE_TRUNC('day', measurement_timestamp)
      comment: "Date of the measurement"
  measures:
    - name: "total_measurements"
      expr: COUNT(1)
      comment: "Total environmental monitoring records captured"
    - name: "exceedances"
      expr: COUNT(CASE WHEN exceedance_flag THEN 1 END)
      comment: "Count of records where measured value exceeded regulatory limits"
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measured value for the selected parameter"
$$;