-- Metric views for domain: compliance | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 08:25:38

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`compliance_audit_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key audit event KPIs for compliance monitoring"
  source: "`manufacturing_ecm`.`compliance`.`audit_event`"
  dimensions:
    - name: "audit_event_status"
      expr: audit_event_status
      comment: "Current status of the audit event"
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of assessment performed"
    - name: "department"
      expr: department
      comment: "Department responsible for the audit"
    - name: "location"
      expr: location
      comment: "Physical location of the audit event"
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of the audit event"
  measures:
    - name: "total_audit_events"
      expr: COUNT(1)
      comment: "Total number of audit events recorded"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across audit events"
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required THEN 1 END)
      comment: "Count of audit events where corrective action is required"
    - name: "high_severity_event_count"
      expr: COUNT(CASE WHEN severity_rating = 'High' THEN 1 END)
      comment: "Number of audit events flagged with high severity"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`compliance_audit_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic view of audit planning performance"
  source: "`manufacturing_ecm`.`compliance`.`audit_plan`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., internal, external)"
    - name: "audit_plan_status"
      expr: audit_plan_status
      comment: "Current status of the audit plan"
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('month', scheduled_start_date)
      comment: "Month when the audit plan is scheduled to start"
  measures:
    - name: "total_audit_plans"
      expr: COUNT(1)
      comment: "Total number of audit plans created"
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score across all plans"
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across all plans"
    - name: "overdue_plans_count"
      expr: COUNT(CASE WHEN scheduled_end_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of audit plans whose scheduled end date is past due"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core compliance audit finding metrics"
  source: "`manufacturing_ecm`.`compliance`.`compliance_audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Classification of the finding"
    - name: "severity"
      expr: severity
      comment: "Severity rating of the finding"
    - name: "audit_finding_status"
      expr: compliance_audit_finding_status
      comment: "Current status of the audit finding"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of compliance audit findings"
    - name: "repeat_findings_count"
      expr: COUNT(CASE WHEN is_repeat_finding THEN 1 END)
      comment: "Count of findings that are repeats of prior findings"
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required THEN 1 END)
      comment: "Number of findings that require corrective action"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`compliance_emissions_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental emissions performance metrics"
  source: "`manufacturing_ecm`.`compliance`.`emissions_record`"
  dimensions:
    - name: "facility_name"
      expr: facility_name
      comment: "Name of the facility reporting emissions"
    - name: "pollutant_type"
      expr: pollutant_type
      comment: "Type of pollutant measured"
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year as provided"
    - name: "reporting_month"
      expr: DATE_TRUNC('month', reporting_period_start)
      comment: "Month of the reporting period"
  measures:
    - name: "total_ghg_emissions"
      expr: SUM(CAST(greenhouse_gas_equivalent AS DOUBLE))
      comment: "Total greenhouse gas emissions reported"
    - name: "avg_carbon_intensity"
      expr: AVG(CAST(carbon_intensity AS DOUBLE))
      comment: "Average carbon intensity across records"
    - name: "exceedance_count"
      expr: COUNT(CASE WHEN exceedance_flag THEN 1 END)
      comment: "Number of records where emissions exceeded thresholds"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`compliance_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility-level environmental and operational KPIs"
  source: "`manufacturing_ecm`.`compliance`.`facility`"
  dimensions:
    - name: "country_code"
      expr: country_code
      comment: "Country where the facility is located"
    - name: "state_province"
      expr: state_province
      comment: "State or province of the facility"
    - name: "facility_type"
      expr: facility_type
      comment: "Classification of facility (e.g., plant, warehouse)"
    - name: "compliance_iso_14001_certified"
      expr: compliance_iso_14001_certified
      comment: "ISO 14001 certification status"
  measures:
    - name: "facility_count"
      expr: COUNT(1)
      comment: "Total number of facilities in scope"
    - name: "avg_emissions_co2_tons"
      expr: AVG(CAST(emissions_co2_tons AS DOUBLE))
      comment: "Average CO2 emissions per facility"
    - name: "avg_energy_consumption_mwh"
      expr: AVG(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Average energy consumption per facility"
    - name: "total_waste_generated_tons"
      expr: SUM(CAST(waste_generated_tons AS DOUBLE))
      comment: "Total waste generated across all facilities"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`compliance_hazardous_substance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazardous substance risk and inventory metrics"
  source: "`manufacturing_ecm`.`compliance`.`hazardous_substance`"
  dimensions:
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "Regulatory hazard classification"
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flag indicating if the substance is hazardous"
    - name: "storage_location"
      expr: storage_location
      comment: "Physical storage location of the substance"
  measures:
    - name: "total_substances"
      expr: COUNT(1)
      comment: "Total number of hazardous substances tracked"
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Aggregate quantity on hand for all hazardous substances"
    - name: "high_risk_substance_count"
      expr: COUNT(CASE WHEN risk_score > 7.5 THEN 1 END)
      comment: "Count of substances with risk score above 7.5"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`compliance_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety incident occurrence and severity metrics"
  source: "`manufacturing_ecm`.`compliance`.`safety_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Category of safety incident"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the incident"
    - name: "incident_month"
      expr: DATE_TRUNC('month', incident_timestamp)
      comment: "Month when the incident occurred"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total safety incidents recorded"
    - name: "lost_time_incidents"
      expr: COUNT(CASE WHEN lost_time_flag THEN 1 END)
      comment: "Incidents resulting in lost work time"
    - name: "high_severity_incidents"
      expr: COUNT(CASE WHEN severity_level = 'High' THEN 1 END)
      comment: "Incidents classified as high severity"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`compliance_safety_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety inspection effectiveness and compliance metrics"
  source: "`manufacturing_ecm`.`compliance`.`safety_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of safety inspection"
    - name: "inspection_status"
      expr: safety_inspection_status
      comment: "Current status of the inspection"
    - name: "inspection_month"
      expr: DATE_TRUNC('month', inspection_timestamp)
      comment: "Month of the inspection"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of safety inspections performed"
    - name: "avg_safety_score"
      expr: AVG(CAST(safety_score AS DOUBLE))
      comment: "Average safety score across inspections"
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required THEN 1 END)
      comment: "Inspections that identified required corrective actions"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`compliance_waste_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waste management and environmental impact metrics"
  source: "`manufacturing_ecm`.`compliance`.`waste_record`"
  dimensions:
    - name: "waste_type"
      expr: waste_type
      comment: "Classification of waste (e.g., hazardous, non-hazardous)"
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method used to dispose of the waste"
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flag indicating if the waste is hazardous"
  measures:
    - name: "total_waste_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of waste recorded"
    - name: "total_transport_emission_kg_co2"
      expr: SUM(CAST(transport_emission_kg_co2 AS DOUBLE))
      comment: "Total CO2 emissions from waste transport"
    - name: "hazardous_waste_count"
      expr: COUNT(CASE WHEN is_hazardous THEN 1 END)
      comment: "Count of waste records flagged as hazardous"
$$;