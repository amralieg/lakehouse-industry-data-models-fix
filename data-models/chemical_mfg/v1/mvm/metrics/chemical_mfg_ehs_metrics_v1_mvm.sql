-- Metric views for domain: ehs | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 14:33:25

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`ehs_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core safety performance metrics tracking incident frequency, severity, regulatory compliance, and lost-time impact for operational risk management and regulatory reporting"
  source: "`chemical_mfg_ecm`.`ehs`.`safety_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Classification of safety incident (e.g., chemical exposure, slip/fall, equipment failure)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the incident (e.g., minor, moderate, severe, critical)"
    - name: "incident_year"
      expr: YEAR(occurrence_timestamp)
      comment: "Year when the safety incident occurred"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', occurrence_timestamp)
      comment: "Month when the safety incident occurred"
    - name: "department"
      expr: department
      comment: "Department where the incident occurred"
    - name: "osha_recordable_flag"
      expr: osha_recordable_flag
      comment: "Whether the incident is OSHA recordable"
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Whether the incident must be reported to regulatory authorities"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the incident"
    - name: "injury_type"
      expr: injury_type
      comment: "Type of injury sustained in the incident"
    - name: "psm_incident_flag"
      expr: psm_incident_flag
      comment: "Whether the incident is a Process Safety Management incident"
  measures:
    - name: "total_safety_incidents"
      expr: COUNT(1)
      comment: "Total number of safety incidents reported"
    - name: "osha_recordable_incidents"
      expr: SUM(CASE WHEN osha_recordable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of OSHA recordable incidents for regulatory compliance tracking"
    - name: "regulatory_reportable_incidents"
      expr: SUM(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents requiring regulatory reporting"
    - name: "psm_incidents"
      expr: SUM(CASE WHEN psm_incident_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of Process Safety Management incidents indicating major process hazards"
    - name: "total_lost_time_hours"
      expr: SUM(CAST(lost_time_hours AS DOUBLE))
      comment: "Total hours of work time lost due to safety incidents"
    - name: "total_property_damage"
      expr: SUM(CAST(property_damage_amount AS DOUBLE))
      comment: "Total property damage cost from safety incidents"
    - name: "avg_property_damage_per_incident"
      expr: AVG(CAST(property_damage_amount AS DOUBLE))
      comment: "Average property damage cost per incident"
    - name: "incidents_with_medical_treatment"
      expr: SUM(CASE WHEN medical_treatment_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents requiring medical treatment"
    - name: "unique_affected_persons"
      expr: COUNT(DISTINCT number_of_affected)
      comment: "Distinct count of affected person groups"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`ehs_emission_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental emissions tracking metrics for air quality compliance, regulatory reporting, and environmental impact management"
  source: "`chemical_mfg_ecm`.`ehs`.`emission_event`"
  dimensions:
    - name: "emission_category"
      expr: emission_category
      comment: "Category of emission (e.g., VOC, HAP, GHG, particulate matter)"
    - name: "emission_type"
      expr: event_type
      comment: "Type of emission event (e.g., routine, upset, emergency)"
    - name: "release_media"
      expr: release_media
      comment: "Media into which emission was released (air, water, land)"
    - name: "reportable_flag"
      expr: reportable_flag
      comment: "Whether the emission event is reportable to regulatory authorities"
    - name: "emission_year"
      expr: YEAR(event_timestamp)
      comment: "Year when the emission event occurred"
    - name: "emission_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month when the emission event occurred"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region where emission occurred"
    - name: "source_type"
      expr: source_type
      comment: "Type of emission source (e.g., stack, fugitive, process)"
    - name: "containment_success_flag"
      expr: containment_success_flag
      comment: "Whether containment measures were successful"
    - name: "cleanup_status"
      expr: cleanup_status
      comment: "Status of cleanup activities"
  measures:
    - name: "total_emission_events"
      expr: COUNT(1)
      comment: "Total number of emission events recorded"
    - name: "reportable_emission_events"
      expr: SUM(CASE WHEN reportable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of emission events requiring regulatory reporting"
    - name: "total_emission_quantity"
      expr: SUM(CAST(emission_quantity AS DOUBLE))
      comment: "Total quantity of emissions released across all events"
    - name: "avg_emission_quantity_per_event"
      expr: AVG(CAST(emission_quantity AS DOUBLE))
      comment: "Average emission quantity per event"
    - name: "successful_containments"
      expr: SUM(CASE WHEN containment_success_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of events where containment was successful"
    - name: "unique_emission_sources"
      expr: COUNT(DISTINCT source_reference)
      comment: "Distinct count of emission sources involved in events"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`ehs_waste_disposal_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waste management and disposal metrics tracking hazardous waste volumes, disposal costs, regulatory compliance, and waste stream efficiency"
  source: "`chemical_mfg_ecm`.`ehs`.`waste_disposal_record`"
  dimensions:
    - name: "waste_disposal_type"
      expr: waste_disposal_type
      comment: "Type of waste disposal method used"
    - name: "disposal_method"
      expr: disposal_method
      comment: "Specific disposal method (e.g., incineration, landfill, recycling, treatment)"
    - name: "hazardous_waste_classification"
      expr: hazardous_waste_classification
      comment: "Hazardous waste classification code"
    - name: "rcra_hazardous_flag"
      expr: rcra_hazardous_flag
      comment: "Whether waste is RCRA hazardous"
    - name: "disposal_year"
      expr: YEAR(disposal_timestamp)
      comment: "Year when waste was disposed"
    - name: "disposal_month"
      expr: DATE_TRUNC('MONTH', disposal_timestamp)
      comment: "Month when waste was disposed"
    - name: "epa_waste_code"
      expr: epa_waste_code
      comment: "EPA waste code classification"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation used for waste disposal"
    - name: "ldr_compliance"
      expr: land_disposal_restrictions_compliance
      comment: "Whether disposal complies with land disposal restrictions"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for disposal costs"
  measures:
    - name: "total_waste_disposal_records"
      expr: COUNT(1)
      comment: "Total number of waste disposal transactions"
    - name: "total_waste_quantity_disposed"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of waste disposed across all records"
    - name: "total_disposal_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of waste disposal operations"
    - name: "avg_disposal_cost_per_unit"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average disposal cost per waste disposal transaction"
    - name: "rcra_hazardous_waste_count"
      expr: SUM(CASE WHEN rcra_hazardous_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of RCRA hazardous waste disposal records"
    - name: "ldr_compliant_disposals"
      expr: SUM(CASE WHEN land_disposal_restrictions_compliance = TRUE THEN 1 ELSE 0 END)
      comment: "Count of disposals compliant with land disposal restrictions"
    - name: "unique_disposal_facilities"
      expr: COUNT(DISTINCT disposal_facility_name)
      comment: "Distinct count of disposal facilities used"
    - name: "unique_manifest_numbers"
      expr: COUNT(DISTINCT manifest_number)
      comment: "Distinct count of waste manifests processed"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`ehs_operating_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operating permit compliance metrics tracking permit status, expiration management, violation rates, and regulatory compliance performance"
  source: "`chemical_mfg_ecm`.`ehs`.`operating_permit`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of operating permit (e.g., air, water, waste, hazardous materials)"
    - name: "permit_status"
      expr: operating_permit_status
      comment: "Current status of the operating permit"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the permit"
    - name: "renewal_status"
      expr: renewal_status
      comment: "Status of permit renewal process"
    - name: "issuing_agency"
      expr: issuing_agency
      comment: "Regulatory agency that issued the permit"
    - name: "air_emission_type"
      expr: air_emission_type
      comment: "Type of air emissions covered by permit"
    - name: "water_discharge_type"
      expr: water_discharge_type
      comment: "Type of water discharge covered by permit"
    - name: "hazardous_waste_type"
      expr: hazardous_waste_type
      comment: "Type of hazardous waste covered by permit"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year when permit expires"
    - name: "expiration_notice_sent"
      expr: permit_expiration_notice_sent
      comment: "Whether expiration notice has been sent"
  measures:
    - name: "total_operating_permits"
      expr: COUNT(1)
      comment: "Total number of operating permits managed"
    - name: "total_permit_violations"
      expr: SUM(CAST(violation_count AS DOUBLE))
      comment: "Total count of permit violations across all permits"
    - name: "total_fines_amount"
      expr: SUM(CAST(total_fines_amount AS DOUBLE))
      comment: "Total monetary fines assessed for permit violations"
    - name: "avg_fines_per_permit"
      expr: AVG(CAST(total_fines_amount AS DOUBLE))
      comment: "Average fine amount per permit"
    - name: "permits_with_violations"
      expr: SUM(CASE WHEN CAST(violation_count AS DOUBLE) > 0 THEN 1 ELSE 0 END)
      comment: "Count of permits with at least one violation"
    - name: "unique_issuing_agencies"
      expr: COUNT(DISTINCT issuing_agency)
      comment: "Distinct count of regulatory agencies issuing permits"
    - name: "unique_permit_holders"
      expr: COUNT(DISTINCT permit_holder_name)
      comment: "Distinct count of permit holders"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`ehs_regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory submission and reporting metrics tracking submission timeliness, compliance rates, and reporting volumes for environmental and safety regulations"
  source: "`chemical_mfg_ecm`.`ehs`.`regulatory_submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission (e.g., TRI, EPCRA, RCRA, air quality report)"
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the regulatory submission"
    - name: "agency_recipient"
      expr: agency_recipient
      comment: "Regulatory agency receiving the submission"
    - name: "reporting_year"
      expr: reporting_year
      comment: "Year for which the submission reports data"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year when the submission was made"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month when the submission was made"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether submission is compliant with regulatory requirements"
    - name: "acknowledgment_received"
      expr: acknowledgment_received
      comment: "Whether acknowledgment was received from agency"
    - name: "is_confidential"
      expr: is_confidential
      comment: "Whether submission contains confidential business information"
    - name: "waste_management_hierarchy"
      expr: waste_management_hierarchy
      comment: "Waste management hierarchy classification"
  measures:
    - name: "total_regulatory_submissions"
      expr: COUNT(1)
      comment: "Total number of regulatory submissions filed"
    - name: "compliant_submissions"
      expr: SUM(CASE WHEN compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of submissions meeting compliance requirements"
    - name: "acknowledged_submissions"
      expr: SUM(CASE WHEN acknowledgment_received = TRUE THEN 1 ELSE 0 END)
      comment: "Count of submissions acknowledged by regulatory agencies"
    - name: "total_air_releases"
      expr: SUM(CAST(release_quantity_air AS DOUBLE))
      comment: "Total quantity of releases to air reported across submissions"
    - name: "total_water_releases"
      expr: SUM(CAST(release_quantity_water AS DOUBLE))
      comment: "Total quantity of releases to water reported across submissions"
    - name: "total_land_releases"
      expr: SUM(CAST(release_quantity_land AS DOUBLE))
      comment: "Total quantity of releases to land reported across submissions"
    - name: "total_offsite_transfers"
      expr: SUM(CAST(release_quantity_offsite_transfer AS DOUBLE))
      comment: "Total quantity of offsite waste transfers reported"
    - name: "total_annual_throughput"
      expr: SUM(CAST(annual_throughput_quantity AS DOUBLE))
      comment: "Total annual throughput quantity reported across submissions"
    - name: "unique_agencies"
      expr: COUNT(DISTINCT agency_recipient)
      comment: "Distinct count of regulatory agencies receiving submissions"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`ehs_incident_investigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incident investigation effectiveness metrics tracking investigation completion, root cause analysis, corrective action implementation, and financial impact"
  source: "`chemical_mfg_ecm`.`ehs`.`incident_investigation`"
  dimensions:
    - name: "investigation_type"
      expr: investigation_type
      comment: "Type of incident investigation (e.g., safety, environmental, quality)"
    - name: "investigation_status"
      expr: incident_investigation_status
      comment: "Current status of the investigation"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the investigated incident"
    - name: "priority"
      expr: priority
      comment: "Priority level of the investigation"
    - name: "root_cause"
      expr: root_cause
      comment: "Identified root cause of the incident"
    - name: "methodology"
      expr: methodology
      comment: "Investigation methodology used (e.g., 5-Why, Fishbone, RCA)"
    - name: "impact_area"
      expr: impact_area
      comment: "Area impacted by the incident"
    - name: "is_closed"
      expr: is_closed
      comment: "Whether the investigation is closed"
    - name: "start_year"
      expr: YEAR(start_timestamp)
      comment: "Year when investigation started"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month when investigation started"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for financial impact"
  measures:
    - name: "total_investigations"
      expr: COUNT(1)
      comment: "Total number of incident investigations conducted"
    - name: "closed_investigations"
      expr: SUM(CASE WHEN is_closed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of completed and closed investigations"
    - name: "total_estimated_loss"
      expr: SUM(CAST(estimated_loss_amount AS DOUBLE))
      comment: "Total estimated financial loss from investigated incidents"
    - name: "avg_estimated_loss_per_investigation"
      expr: AVG(CAST(estimated_loss_amount AS DOUBLE))
      comment: "Average estimated loss per investigation"
    - name: "unique_root_causes"
      expr: COUNT(DISTINCT root_cause)
      comment: "Distinct count of root causes identified"
    - name: "unique_impact_areas"
      expr: COUNT(DISTINCT impact_area)
      comment: "Distinct count of areas impacted by incidents"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`ehs_capa_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and Preventive Action (CAPA) effectiveness metrics tracking action completion rates, cost performance, and effectiveness ratings for continuous improvement"
  source: "`chemical_mfg_ecm`.`ehs`.`capa_record`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of action (corrective or preventive)"
    - name: "capa_status"
      expr: capa_record_status
      comment: "Current status of the CAPA record"
    - name: "priority"
      expr: priority
      comment: "Priority level of the CAPA"
    - name: "severity"
      expr: severity
      comment: "Severity level of the issue being addressed"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the CAPA"
    - name: "effectiveness_rating"
      expr: effectiveness_rating
      comment: "Rating of CAPA effectiveness after implementation"
    - name: "department"
      expr: department
      comment: "Department responsible for the CAPA"
    - name: "is_external"
      expr: is_external
      comment: "Whether CAPA is related to external audit or customer complaint"
    - name: "initiated_year"
      expr: YEAR(initiated_timestamp)
      comment: "Year when CAPA was initiated"
    - name: "initiated_month"
      expr: DATE_TRUNC('MONTH', initiated_timestamp)
      comment: "Month when CAPA was initiated"
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year when CAPA was completed"
  measures:
    - name: "total_capa_records"
      expr: COUNT(1)
      comment: "Total number of CAPA records"
    - name: "total_capa_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost for all CAPAs"
    - name: "total_capa_cost_actual"
      expr: SUM(CAST(cost_actual AS DOUBLE))
      comment: "Total actual cost incurred for all CAPAs"
    - name: "avg_capa_cost_estimate"
      expr: AVG(CAST(cost_estimate AS DOUBLE))
      comment: "Average estimated cost per CAPA"
    - name: "avg_capa_cost_actual"
      expr: AVG(CAST(cost_actual AS DOUBLE))
      comment: "Average actual cost per CAPA"
    - name: "external_capas"
      expr: SUM(CASE WHEN is_external = TRUE THEN 1 ELSE 0 END)
      comment: "Count of CAPAs triggered by external sources"
    - name: "unique_departments"
      expr: COUNT(DISTINCT department)
      comment: "Distinct count of departments with CAPA records"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`ehs_inspection_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection and audit performance metrics tracking finding severity distribution, closure rates, and compliance audit effectiveness"
  source: "`chemical_mfg_ecm`.`ehs`.`inspection_audit`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection or audit conducted"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection"
    - name: "closure_status"
      expr: closure_status
      comment: "Status of inspection closure and corrective action completion"
    - name: "affected_area"
      expr: affected_area
      comment: "Area or process affected by inspection findings"
    - name: "regulatory_standard"
      expr: regulatory_standard_referenced
      comment: "Regulatory standard referenced in the inspection"
    - name: "inspection_year"
      expr: YEAR(inspection_timestamp)
      comment: "Year when inspection was conducted"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_timestamp)
      comment: "Month when inspection was conducted"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspections and audits conducted"
    - name: "total_findings"
      expr: SUM(CAST(total_findings AS DOUBLE))
      comment: "Total count of all findings across inspections"
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings AS DOUBLE))
      comment: "Total count of critical severity findings"
    - name: "total_high_findings"
      expr: SUM(CAST(high_findings AS DOUBLE))
      comment: "Total count of high severity findings"
    - name: "total_medium_findings"
      expr: SUM(CAST(medium_findings AS DOUBLE))
      comment: "Total count of medium severity findings"
    - name: "total_low_findings"
      expr: SUM(CAST(low_findings AS DOUBLE))
      comment: "Total count of low severity findings"
    - name: "avg_findings_per_inspection"
      expr: AVG(CAST(total_findings AS DOUBLE))
      comment: "Average number of findings per inspection"
    - name: "unique_affected_areas"
      expr: COUNT(DISTINCT affected_area)
      comment: "Distinct count of areas affected by inspection findings"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`ehs_hazop_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HAZOP study and process safety analysis metrics tracking risk assessment completion, action closure rates, and overall risk rankings for process safety management"
  source: "`chemical_mfg_ecm`.`ehs`.`hazop_study`"
  dimensions:
    - name: "study_type"
      expr: study_type
      comment: "Type of HAZOP or process safety study"
    - name: "hazop_status"
      expr: hazop_study_status
      comment: "Current status of the HAZOP study"
    - name: "overall_risk_rank"
      expr: overall_risk_rank
      comment: "Overall risk ranking from the study"
    - name: "risk_likelihood"
      expr: risk_likelihood
      comment: "Likelihood rating of identified risks"
    - name: "risk_severity"
      expr: risk_severity
      comment: "Severity rating of identified risks"
    - name: "action_status"
      expr: action_status
      comment: "Status of recommended actions from the study"
    - name: "methodology"
      expr: methodology
      comment: "Methodology used for the study (e.g., HAZOP, LOPA, What-If)"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework driving the study"
    - name: "physical_state"
      expr: physical_state
      comment: "Physical state of materials studied"
    - name: "study_start_year"
      expr: YEAR(study_start_date)
      comment: "Year when study started"
  measures:
    - name: "total_hazop_studies"
      expr: COUNT(1)
      comment: "Total number of HAZOP and process safety studies conducted"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across all studies"
    - name: "total_max_inventory"
      expr: SUM(CAST(max_intended_inventory AS DOUBLE))
      comment: "Total maximum intended inventory across all studied processes"
    - name: "avg_exposure_limit"
      expr: AVG(CAST(exposure_limit_ppm AS DOUBLE))
      comment: "Average exposure limit in ppm for materials studied"
    - name: "unique_process_units"
      expr: COUNT(DISTINCT process_unit_code)
      comment: "Distinct count of process units studied"
    - name: "unique_methodologies"
      expr: COUNT(DISTINCT methodology)
      comment: "Distinct count of study methodologies used"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`ehs_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility-level environmental and safety performance metrics tracking emissions, energy consumption, water usage, and compliance status for sustainability and operational reporting"
  source: "`chemical_mfg_ecm`.`ehs`.`facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (e.g., manufacturing plant, warehouse, R&D center)"
    - name: "facility_status"
      expr: facility_status
      comment: "Current operational status of the facility"
    - name: "country"
      expr: country
      comment: "Country where facility is located"
    - name: "region"
      expr: region
      comment: "Geographic region of the facility"
    - name: "state"
      expr: state
      comment: "State or province where facility is located"
    - name: "compliance_reporting_status"
      expr: compliance_reporting_status
      comment: "Compliance reporting status of the facility"
    - name: "ehs_certification_type"
      expr: ehs_certification_type
      comment: "Type of EHS certification held (e.g., ISO 14001, ISO 45001)"
    - name: "ehs_certification_status"
      expr: ehs_certification_status
      comment: "Status of EHS certification"
    - name: "fire_suppression_available"
      expr: fire_suppression_system
      comment: "Whether fire suppression system is available"
    - name: "emergency_shutoff_available"
      expr: emergency_shutoff_available
      comment: "Whether emergency shutoff system is available"
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of facilities managed"
    - name: "total_co2_emissions"
      expr: SUM(CAST(emissions_co2_tons_year AS DOUBLE))
      comment: "Total CO2 emissions in tons per year across all facilities"
    - name: "total_hap_emissions"
      expr: SUM(CAST(emissions_hap_tons_year AS DOUBLE))
      comment: "Total hazardous air pollutant emissions in tons per year"
    - name: "total_energy_consumption"
      expr: SUM(CAST(energy_consumption_mwh_year AS DOUBLE))
      comment: "Total energy consumption in MWh per year across all facilities"
    - name: "total_water_usage"
      expr: SUM(CAST(water_usage_cubic_meters_year AS DOUBLE))
      comment: "Total water usage in cubic meters per year across all facilities"
    - name: "avg_co2_emissions_per_facility"
      expr: AVG(CAST(emissions_co2_tons_year AS DOUBLE))
      comment: "Average CO2 emissions per facility"
    - name: "avg_energy_consumption_per_facility"
      expr: AVG(CAST(energy_consumption_mwh_year AS DOUBLE))
      comment: "Average energy consumption per facility"
    - name: "total_facility_capacity"
      expr: SUM(CAST(capacity_tons_per_year AS DOUBLE))
      comment: "Total production capacity in tons per year across all facilities"
    - name: "facilities_with_fire_suppression"
      expr: SUM(CASE WHEN fire_suppression_system = TRUE THEN 1 ELSE 0 END)
      comment: "Count of facilities with fire suppression systems"
    - name: "facilities_with_emergency_shutoff"
      expr: SUM(CASE WHEN emergency_shutoff_available = TRUE THEN 1 ELSE 0 END)
      comment: "Count of facilities with emergency shutoff systems"
$$;