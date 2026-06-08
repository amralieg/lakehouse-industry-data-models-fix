-- Metric views for domain: ehs | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 13:07:02

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`ehs_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key safety incident KPIs for EHS leadership to monitor incident frequency, severity, recordable incidents, and property damage"
  source: "`chemical_mfg_ecm`.`ehs`.`safety_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type/category of safety incident"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the incident"
    - name: "incident_date"
      expr: DATE_TRUNC('day', occurrence_timestamp)
      comment: "Date of the incident"
    - name: "department"
      expr: department
      comment: "Department where incident occurred"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of safety incidents"
    - name: "recordable_incidents"
      expr: SUM(CAST(osha_recordable_flag AS INT))
      comment: "Count of OSHA recordable incidents"
    - name: "total_property_damage"
      expr: SUM(CAST(property_damage_amount AS DOUBLE))
      comment: "Sum of property damage amounts across incidents"
    - name: "average_exposure_concentration"
      expr: AVG(CAST(exposure_concentration AS DOUBLE))
      comment: "Average exposure concentration for incidents"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`ehs_emission_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Emission event KPIs to track volume, reporting compliance and factor trends"
  source: "`chemical_mfg_ecm`.`ehs`.`emission_event`"
  dimensions:
    - name: "emission_category"
      expr: emission_category
      comment: "Category of emission (e.g., air, water)"
    - name: "event_status"
      expr: emission_event_status
      comment: "Current status of the emission event"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Region where emission occurred"
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of the emission event"
  measures:
    - name: "total_emission_events"
      expr: COUNT(1)
      comment: "Total number of emission events"
    - name: "total_emission_quantity"
      expr: SUM(CAST(emission_quantity AS DOUBLE))
      comment: "Sum of emitted quantity across events"
    - name: "reportable_emission_events"
      expr: SUM(CAST(reportable_flag AS INT))
      comment: "Count of reportable emission events"
    - name: "average_emission_factor"
      expr: AVG(CAST(emission_factor AS DOUBLE))
      comment: "Average emission factor for events"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`ehs_incident_investigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Investigation KPIs to assess financial impact and closure performance"
  source: "`chemical_mfg_ecm`.`ehs`.`incident_investigation`"
  dimensions:
    - name: "investigation_type"
      expr: investigation_type
      comment: "Type of investigation (e.g., root cause, compliance)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level assigned to the investigation"
    - name: "investigation_start_date"
      expr: DATE_TRUNC('day', start_timestamp)
      comment: "Date the investigation started"
  measures:
    - name: "total_investigations"
      expr: COUNT(1)
      comment: "Total number of incident investigations"
    - name: "total_estimated_loss"
      expr: SUM(CAST(estimated_loss_amount AS DOUBLE))
      comment: "Sum of estimated financial loss from investigations"
    - name: "average_estimated_loss"
      expr: AVG(CAST(estimated_loss_amount AS DOUBLE))
      comment: "Average estimated loss per investigation"
    - name: "closed_investigations"
      expr: SUM(CAST(is_closed AS INT))
      comment: "Count of investigations that have been closed"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`ehs_contractor_safety_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contractor safety performance metrics to monitor compliance and risk"
  source: "`chemical_mfg_ecm`.`ehs`.`contractor_safety_record`"
  dimensions:
    - name: "contractor_type"
      expr: contractor_type
      comment: "Classification of contractor (e.g., vendor, service)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the contractor"
    - name: "record_created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the contractor safety record was created"
  measures:
    - name: "total_contractors"
      expr: COUNT(1)
      comment: "Total number of contractor safety records"
    - name: "average_near_miss_frequency"
      expr: AVG(CAST(near_miss_frequency AS DOUBLE))
      comment: "Average near‑miss frequency for contractors"
    - name: "average_audit_score"
      expr: AVG(CAST(last_safety_audit_score AS DOUBLE))
      comment: "Average safety audit score across contractors"
    - name: "average_recordable_incident_rate"
      expr: AVG(CAST(recordable_incident_rate AS DOUBLE))
      comment: "Average recordable incident rate for contractors"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`ehs_environmental_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental monitoring KPIs to track sample volume, results, and exceedances"
  source: "`chemical_mfg_ecm`.`ehs`.`environmental_monitoring`"
  dimensions:
    - name: "parameter"
      expr: parameter
      comment: "Monitored parameter (e.g., pH, VOC)"
    - name: "media_type"
      expr: media_type
      comment: "Media type of the sample (e.g., air, water)"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the result value"
    - name: "monitoring_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the sample was recorded"
  measures:
    - name: "total_samples"
      expr: COUNT(1)
      comment: "Total number of environmental monitoring samples"
    - name: "average_result_value"
      expr: AVG(CAST(result_value AS DOUBLE))
      comment: "Average measured value across samples"
    - name: "exceedance_count"
      expr: SUM(CAST(exceedance_flag AS INT))
      comment: "Count of samples that exceeded regulatory limits"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`ehs_waste_disposal_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waste disposal KPIs to monitor volume, cost, and hazardous handling"
  source: "`chemical_mfg_ecm`.`ehs`.`waste_disposal_record`"
  dimensions:
    - name: "waste_disposal_type"
      expr: waste_disposal_type
      comment: "Type of waste disposal (e.g., landfill, incineration)"
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method used for disposal"
    - name: "disposal_date"
      expr: DATE_TRUNC('day', disposal_timestamp)
      comment: "Date the waste was disposed"
  measures:
    - name: "total_waste_records"
      expr: COUNT(1)
      comment: "Total number of waste disposal records"
    - name: "total_waste_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Sum of waste quantity disposed"
    - name: "total_disposal_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost associated with waste disposal"
    - name: "hazardous_disposal_count"
      expr: SUM(CAST(rcra_hazardous_flag AS INT))
      comment: "Count of hazardous waste disposals (RCRA flagged)"
$$;