-- Metric views for domain: safety | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 03:36:32

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`safety_ohs_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Occupational Health & Safety incident metrics tracking injury severity, lost time, and incident trends for workforce safety management and regulatory compliance"
  source: "`shipping_ports_ecm`.`safety`.`ohs_incident`"
  dimensions:
    - name: "incident_severity"
      expr: incident_severity
      comment: "Severity classification of the OHS incident (e.g., minor, major, critical, fatal)"
    - name: "incident_type"
      expr: incident_type
      comment: "Type of OHS incident (e.g., slip/trip/fall, struck by object, chemical exposure, ergonomic)"
    - name: "location_type"
      expr: location_type
      comment: "Type of location where incident occurred (e.g., berth, warehouse, terminal zone, vessel)"
    - name: "injury_nature"
      expr: injury_nature
      comment: "Nature of injury sustained (e.g., laceration, fracture, burn, strain)"
    - name: "body_part_affected"
      expr: body_part_affected
      comment: "Body part affected by the injury"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of incident investigation and closure"
    - name: "medical_treatment_required"
      expr: medical_treatment_required
      comment: "Whether medical treatment was required for the incident"
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Whether regulatory notification was required for this incident"
    - name: "incident_year"
      expr: YEAR(incident_datetime)
      comment: "Year when the incident occurred"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_datetime)
      comment: "Month when the incident occurred"
    - name: "shift"
      expr: shift
      comment: "Work shift during which incident occurred"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of OHS incidents reported"
    - name: "total_lost_days"
      expr: SUM(CAST(days_lost AS DOUBLE))
      comment: "Total days lost due to OHS incidents (key safety performance indicator)"
    - name: "total_restricted_days"
      expr: SUM(CAST(days_restricted AS DOUBLE))
      comment: "Total days with restricted work due to OHS incidents"
    - name: "total_incident_cost"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of OHS incidents including medical, compensation, and operational impact"
    - name: "avg_incident_cost"
      expr: AVG(CAST(cost_estimate AS DOUBLE))
      comment: "Average cost per OHS incident"
    - name: "medical_treatment_incidents"
      expr: COUNT(CASE WHEN medical_treatment_required = TRUE THEN 1 END)
      comment: "Number of incidents requiring medical treatment (OSHA recordable threshold)"
    - name: "lost_time_incidents"
      expr: COUNT(CASE WHEN CAST(days_lost AS DOUBLE) > 0 THEN 1 END)
      comment: "Number of lost time injury incidents (LTI) - critical safety KPI"
    - name: "regulatory_reportable_incidents"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END)
      comment: "Number of incidents requiring regulatory notification (serious incidents)"
    - name: "avg_days_lost_per_incident"
      expr: AVG(CAST(days_lost AS DOUBLE))
      comment: "Average days lost per incident (severity indicator)"
    - name: "unique_injured_workers"
      expr: COUNT(DISTINCT primary_ohs_injured_party_employee_id)
      comment: "Number of unique workers injured in OHS incidents"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`safety_contractor_safety`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contractor safety performance metrics tracking safety ratings, incident rates, accreditation status, and compliance for third-party workforce risk management"
  source: "`shipping_ports_ecm`.`safety`.`contractor_safety`"
  dimensions:
    - name: "safety_performance_rating"
      expr: safety_performance_rating
      comment: "Overall safety performance rating assigned to contractor"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status of contractor for port operations"
    - name: "competency_verification_status"
      expr: competency_verification_status
      comment: "Status of contractor competency verification"
    - name: "suspension_flag"
      expr: suspension_flag
      comment: "Whether contractor is currently suspended from operations"
    - name: "induction_required_flag"
      expr: induction_required_flag
      comment: "Whether safety induction is required for this contractor"
    - name: "contractor_company_name"
      expr: contractor_company_name
      comment: "Name of contractor company"
    - name: "safety_accreditation_type"
      expr: safety_accreditation_type
      comment: "Type of safety accreditation held by contractor"
    - name: "insurance_currency_code"
      expr: insurance_currency_code
      comment: "Currency code for insurance coverage"
  measures:
    - name: "total_contractors"
      expr: COUNT(1)
      comment: "Total number of contractor safety records"
    - name: "avg_safety_performance_score"
      expr: AVG(CAST(safety_performance_score AS DOUBLE))
      comment: "Average safety performance score across contractors (key contractor management KPI)"
    - name: "avg_ltifr"
      expr: AVG(CAST(ltifr AS DOUBLE))
      comment: "Average Lost Time Injury Frequency Rate across contractors (industry standard safety metric)"
    - name: "avg_trir"
      expr: AVG(CAST(trir AS DOUBLE))
      comment: "Average Total Recordable Incident Rate across contractors (OSHA standard metric)"
    - name: "avg_emr_rate"
      expr: AVG(CAST(emr_rate AS DOUBLE))
      comment: "Average Experience Modification Rate across contractors (insurance risk indicator)"
    - name: "total_insurance_coverage"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage amount across all contractors"
    - name: "suspended_contractors"
      expr: COUNT(CASE WHEN suspension_flag = TRUE THEN 1 END)
      comment: "Number of contractors currently suspended due to safety concerns"
    - name: "qualified_contractors"
      expr: COUNT(CASE WHEN qualification_status = 'Qualified' THEN 1 END)
      comment: "Number of contractors with qualified status"
    - name: "contractors_with_incidents"
      expr: COUNT(CASE WHEN CAST(incident_count_12_months AS DOUBLE) > 0 THEN 1 END)
      comment: "Number of contractors with incidents in the last 12 months"
    - name: "unique_contractor_companies"
      expr: COUNT(DISTINCT contractor_company_name)
      comment: "Number of unique contractor companies with safety records"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`safety_ghg_emission_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Greenhouse gas emission metrics tracking CO2 equivalent emissions by scope, source, and activity for environmental compliance and sustainability reporting"
  source: "`shipping_ports_ecm`.`safety`.`ghg_emission_record`"
  dimensions:
    - name: "emission_scope"
      expr: emission_scope
      comment: "GHG Protocol emission scope (Scope 1, 2, or 3)"
    - name: "emission_source_category"
      expr: emission_source_category
      comment: "Category of emission source (e.g., vessel operations, cargo handling, ground transport)"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Type of fuel consumed generating emissions"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework for emission reporting (e.g., EU ETS, IMO DCS, MRV)"
    - name: "verification_status"
      expr: verification_status
      comment: "Third-party verification status of emission record"
    - name: "data_quality_rating"
      expr: data_quality_rating
      comment: "Quality rating of emission data (e.g., measured, calculated, estimated)"
    - name: "compliance_year"
      expr: compliance_year
      comment: "Compliance year for regulatory reporting"
    - name: "offset_applied_flag"
      expr: offset_applied_flag
      comment: "Whether carbon offsets have been applied to this emission record"
    - name: "reporting_period_month"
      expr: DATE_TRUNC('MONTH', reporting_period_start_date)
      comment: "Month of reporting period start"
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required
      comment: "Whether regulatory reporting is required for this emission record"
  measures:
    - name: "total_emission_records"
      expr: COUNT(1)
      comment: "Total number of GHG emission records"
    - name: "total_co2_equivalent_tonnes"
      expr: SUM(CAST(co2_equivalent_tonnes AS DOUBLE))
      comment: "Total CO2 equivalent emissions in tonnes (primary climate impact metric)"
    - name: "total_co2_tonnes"
      expr: SUM(CAST(co2_tonnes AS DOUBLE))
      comment: "Total direct CO2 emissions in tonnes"
    - name: "total_ch4_tonnes"
      expr: SUM(CAST(ch4_tonnes AS DOUBLE))
      comment: "Total methane emissions in tonnes"
    - name: "total_n2o_tonnes"
      expr: SUM(CAST(n2o_tonnes AS DOUBLE))
      comment: "Total nitrous oxide emissions in tonnes"
    - name: "avg_co2_equivalent_per_record"
      expr: AVG(CAST(co2_equivalent_tonnes AS DOUBLE))
      comment: "Average CO2 equivalent emissions per record"
    - name: "total_activity_data_value"
      expr: SUM(CAST(activity_data_value AS DOUBLE))
      comment: "Total activity data value (e.g., fuel consumed, electricity used)"
    - name: "verified_emission_records"
      expr: COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END)
      comment: "Number of third-party verified emission records"
    - name: "offset_applied_records"
      expr: COUNT(CASE WHEN offset_applied_flag = TRUE THEN 1 END)
      comment: "Number of emission records with carbon offsets applied"
    - name: "avg_uncertainty_percentage"
      expr: AVG(CAST(uncertainty_percentage AS DOUBLE))
      comment: "Average uncertainty percentage in emission calculations (data quality indicator)"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`safety_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety and compliance inspection metrics tracking findings, compliance scores, and inspection outcomes for regulatory adherence and operational risk management"
  source: "`shipping_ports_ecm`.`safety`.`inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection conducted (e.g., safety, environmental, security, ISPS, PSC)"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of inspection (e.g., scheduled, in progress, completed, closed)"
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall rating assigned to inspection outcome"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority conducting or requiring the inspection"
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Whether follow-up action is required based on inspection findings"
    - name: "psc_detention_flag"
      expr: psc_detention_flag
      comment: "Whether Port State Control inspection resulted in vessel detention (critical safety/compliance failure)"
    - name: "inspection_year"
      expr: YEAR(inspection_date)
      comment: "Year when inspection was conducted"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month when inspection was conducted"
    - name: "isps_security_level"
      expr: isps_security_level
      comment: "ISPS security level at time of inspection"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspections conducted"
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across inspections (key compliance performance indicator)"
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS DOUBLE))
      comment: "Total number of critical findings across all inspections (highest risk issues)"
    - name: "total_major_findings"
      expr: SUM(CAST(major_findings_count AS DOUBLE))
      comment: "Total number of major findings across all inspections"
    - name: "total_minor_findings"
      expr: SUM(CAST(minor_findings_count AS DOUBLE))
      comment: "Total number of minor findings across all inspections"
    - name: "total_findings"
      expr: SUM(CAST(total_findings_count AS DOUBLE))
      comment: "Total number of all findings across inspections"
    - name: "inspections_requiring_followup"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END)
      comment: "Number of inspections requiring follow-up action"
    - name: "psc_detentions"
      expr: COUNT(CASE WHEN psc_detention_flag = TRUE THEN 1 END)
      comment: "Number of Port State Control detentions (critical safety/compliance metric)"
    - name: "completed_inspections"
      expr: COUNT(CASE WHEN inspection_status = 'Completed' THEN 1 END)
      comment: "Number of completed inspections"
    - name: "avg_findings_per_inspection"
      expr: AVG(CAST(total_findings_count AS DOUBLE))
      comment: "Average number of findings per inspection (inspection effectiveness indicator)"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`safety_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk assessment metrics tracking inherent and residual risk levels, control effectiveness, and risk mitigation for operational safety and hazard management"
  source: "`shipping_ports_ecm`.`safety`.`risk_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment (e.g., job safety analysis, HAZOP, HAZID, task risk assessment)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of risk assessment"
    - name: "inherent_risk_level"
      expr: inherent_risk_level
      comment: "Inherent risk level before controls applied (e.g., low, medium, high, extreme)"
    - name: "residual_risk_level"
      expr: residual_risk_level
      comment: "Residual risk level after controls applied (key risk management outcome)"
    - name: "target_risk_level"
      expr: target_risk_level
      comment: "Target risk level to be achieved through additional controls"
    - name: "likelihood_rating"
      expr: likelihood_rating
      comment: "Likelihood rating of risk occurrence"
    - name: "consequence_rating"
      expr: consequence_rating
      comment: "Consequence severity rating if risk materializes"
    - name: "control_effectiveness"
      expr: control_effectiveness
      comment: "Effectiveness rating of existing risk controls"
    - name: "operational_area"
      expr: operational_area
      comment: "Operational area covered by risk assessment"
    - name: "confined_space_flag"
      expr: confined_space_flag
      comment: "Whether assessment covers confined space work (high-risk activity)"
    - name: "hot_work_flag"
      expr: hot_work_flag
      comment: "Whether assessment covers hot work activities (high-risk activity)"
    - name: "permit_required_flag"
      expr: permit_required_flag
      comment: "Whether permit to work is required based on risk assessment"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year when risk assessment was conducted"
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(1)
      comment: "Total number of risk assessments conducted"
    - name: "high_inherent_risk_assessments"
      expr: COUNT(CASE WHEN inherent_risk_level IN ('High', 'Extreme') THEN 1 END)
      comment: "Number of assessments with high or extreme inherent risk (pre-control)"
    - name: "high_residual_risk_assessments"
      expr: COUNT(CASE WHEN residual_risk_level IN ('High', 'Extreme') THEN 1 END)
      comment: "Number of assessments with high or extreme residual risk (post-control) - requires management attention"
    - name: "approved_risk_assessments"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of approved risk assessments"
    - name: "confined_space_assessments"
      expr: COUNT(CASE WHEN confined_space_flag = TRUE THEN 1 END)
      comment: "Number of risk assessments for confined space work"
    - name: "hot_work_assessments"
      expr: COUNT(CASE WHEN hot_work_flag = TRUE THEN 1 END)
      comment: "Number of risk assessments for hot work activities"
    - name: "permit_required_assessments"
      expr: COUNT(CASE WHEN permit_required_flag = TRUE THEN 1 END)
      comment: "Number of assessments requiring permit to work"
    - name: "avg_inherent_risk_score"
      expr: AVG(CAST(inherent_risk_score AS DOUBLE))
      comment: "Average inherent risk score before controls"
    - name: "avg_residual_risk_score"
      expr: AVG(CAST(residual_risk_score AS DOUBLE))
      comment: "Average residual risk score after controls (key risk management effectiveness metric)"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`safety_permit_to_work`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Permit to work metrics tracking high-risk work authorization, safety precautions, and permit compliance for hazardous operations control"
  source: "`shipping_ports_ecm`.`safety`.`permit_to_work`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of permit to work (e.g., hot work, confined space, working at height, electrical isolation)"
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of permit (e.g., issued, active, closed, suspended, cancelled)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of work covered by permit"
    - name: "fire_watch_required_flag"
      expr: fire_watch_required_flag
      comment: "Whether fire watch is required for this work"
    - name: "gas_test_required_flag"
      expr: gas_test_required_flag
      comment: "Whether gas testing is required before work commences"
    - name: "isolation_required_flag"
      expr: isolation_required_flag
      comment: "Whether equipment isolation is required"
    - name: "toolbox_talk_conducted_flag"
      expr: toolbox_talk_conducted_flag
      comment: "Whether toolbox talk was conducted before work"
    - name: "incident_occurred_flag"
      expr: incident_occurred_flag
      comment: "Whether an incident occurred during permitted work (critical safety indicator)"
    - name: "competency_verification_flag"
      expr: competency_verification_flag
      comment: "Whether worker competency was verified before permit issuance"
    - name: "regulatory_notification_required_flag"
      expr: regulatory_notification_required_flag
      comment: "Whether regulatory notification is required for this work"
    - name: "work_area_code"
      expr: work_area_code
      comment: "Code identifying work area where permit applies"
    - name: "issued_year"
      expr: YEAR(issued_timestamp)
      comment: "Year when permit was issued"
    - name: "issued_month"
      expr: DATE_TRUNC('MONTH', issued_timestamp)
      comment: "Month when permit was issued"
  measures:
    - name: "total_permits"
      expr: COUNT(1)
      comment: "Total number of permits to work issued"
    - name: "active_permits"
      expr: COUNT(CASE WHEN permit_status = 'Active' THEN 1 END)
      comment: "Number of currently active permits"
    - name: "closed_permits"
      expr: COUNT(CASE WHEN permit_status = 'Closed' THEN 1 END)
      comment: "Number of closed permits"
    - name: "permits_with_incidents"
      expr: COUNT(CASE WHEN incident_occurred_flag = TRUE THEN 1 END)
      comment: "Number of permits where incidents occurred during work (critical safety failure metric)"
    - name: "high_risk_permits"
      expr: COUNT(CASE WHEN risk_level IN ('High', 'Extreme') THEN 1 END)
      comment: "Number of high or extreme risk permits issued"
    - name: "fire_watch_permits"
      expr: COUNT(CASE WHEN fire_watch_required_flag = TRUE THEN 1 END)
      comment: "Number of permits requiring fire watch"
    - name: "confined_space_permits"
      expr: COUNT(CASE WHEN gas_test_required_flag = TRUE THEN 1 END)
      comment: "Number of permits requiring gas testing (typically confined space work)"
    - name: "isolation_permits"
      expr: COUNT(CASE WHEN isolation_required_flag = TRUE THEN 1 END)
      comment: "Number of permits requiring equipment isolation"
    - name: "toolbox_talks_conducted"
      expr: COUNT(CASE WHEN toolbox_talk_conducted_flag = TRUE THEN 1 END)
      comment: "Number of permits with toolbox talks conducted (safety communication compliance)"
    - name: "avg_permit_extensions"
      expr: AVG(CAST(permit_extension_count AS DOUBLE))
      comment: "Average number of extensions per permit (work planning effectiveness indicator)"
    - name: "avg_fire_watch_duration_minutes"
      expr: AVG(CAST(fire_watch_duration_minutes AS DOUBLE))
      comment: "Average fire watch duration in minutes"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`safety_sustainability_initiative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sustainability initiative metrics tracking environmental project performance, GHG reduction, energy savings, and progress toward decarbonization and ESG goals"
  source: "`shipping_ports_ecm`.`safety`.`sustainability_initiative`"
  dimensions:
    - name: "initiative_category"
      expr: initiative_category
      comment: "Category of sustainability initiative (e.g., energy efficiency, renewable energy, waste reduction, emissions reduction)"
    - name: "initiative_status"
      expr: initiative_status
      comment: "Current status of initiative (e.g., planned, in progress, completed, on hold)"
    - name: "initiative_priority"
      expr: initiative_priority
      comment: "Priority level of initiative"
    - name: "certification_status"
      expr: certification_status
      comment: "Status of environmental certification (e.g., ISO 14001, Green Marine, EcoPorts)"
    - name: "certification_target"
      expr: certification_target
      comment: "Target certification being pursued"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether initiative is driven by regulatory compliance requirement"
    - name: "wpsp_goal_alignment"
      expr: wpsp_goal_alignment
      comment: "Alignment with World Ports Sustainability Program goals"
    - name: "budget_currency_code"
      expr: budget_currency_code
      comment: "Currency code for initiative budget"
    - name: "external_funding_source"
      expr: external_funding_source
      comment: "Source of external funding (e.g., government grant, EU fund, green bond)"
    - name: "initiative_year"
      expr: YEAR(actual_start_date)
      comment: "Year when initiative started"
  measures:
    - name: "total_initiatives"
      expr: COUNT(1)
      comment: "Total number of sustainability initiatives"
    - name: "total_ghg_reduction_tonnes"
      expr: SUM(CAST(ghg_reduction_tonnes_co2e AS DOUBLE))
      comment: "Total GHG reduction achieved in tonnes CO2 equivalent (primary decarbonization KPI)"
    - name: "total_energy_savings_mwh"
      expr: SUM(CAST(energy_savings_mwh AS DOUBLE))
      comment: "Total energy savings achieved in megawatt-hours (energy efficiency KPI)"
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated to sustainability initiatives"
    - name: "total_budget_spent"
      expr: SUM(CAST(budget_spent_amount AS DOUBLE))
      comment: "Total budget spent on sustainability initiatives"
    - name: "total_external_funding"
      expr: SUM(CAST(external_funding_amount AS DOUBLE))
      comment: "Total external funding secured for sustainability initiatives"
    - name: "avg_progress_percentage"
      expr: AVG(CAST(progress_percentage AS DOUBLE))
      comment: "Average progress percentage across all initiatives"
    - name: "completed_initiatives"
      expr: COUNT(CASE WHEN initiative_status = 'Completed' THEN 1 END)
      comment: "Number of completed sustainability initiatives"
    - name: "in_progress_initiatives"
      expr: COUNT(CASE WHEN initiative_status = 'In Progress' THEN 1 END)
      comment: "Number of initiatives currently in progress"
    - name: "avg_ghg_reduction_per_initiative"
      expr: AVG(CAST(ghg_reduction_tonnes_co2e AS DOUBLE))
      comment: "Average GHG reduction per initiative (initiative effectiveness indicator)"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`safety_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety corrective action metrics tracking closure rates, overdue actions, and effectiveness of remediation for continuous safety improvement"
  source: "`shipping_ports_ecm`.`safety`.`safety_corrective_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action (e.g., immediate, corrective, preventive, improvement)"
    - name: "safety_corrective_action_status"
      expr: safety_corrective_action_status
      comment: "Current status of corrective action"
    - name: "priority"
      expr: priority
      comment: "Priority level of corrective action (e.g., critical, high, medium, low)"
    - name: "source_type"
      expr: source_type
      comment: "Source that triggered corrective action (e.g., incident, audit, inspection, near miss)"
    - name: "is_overdue"
      expr: is_overdue
      comment: "Whether corrective action is overdue (critical management indicator)"
    - name: "training_required"
      expr: training_required
      comment: "Whether training is required as part of corrective action"
    - name: "escalation_status"
      expr: escalation_status
      comment: "Escalation status of corrective action"
    - name: "effectiveness_outcome"
      expr: effectiveness_outcome
      comment: "Outcome of effectiveness verification (e.g., effective, partially effective, ineffective)"
    - name: "assigned_department"
      expr: assigned_department
      comment: "Department assigned to complete corrective action"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for corrective action costs"
    - name: "assigned_year"
      expr: YEAR(assigned_date)
      comment: "Year when corrective action was assigned"
    - name: "assigned_month"
      expr: DATE_TRUNC('MONTH', assigned_date)
      comment: "Month when corrective action was assigned"
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total number of safety corrective actions"
    - name: "overdue_actions"
      expr: COUNT(CASE WHEN is_overdue = TRUE THEN 1 END)
      comment: "Number of overdue corrective actions (critical management KPI)"
    - name: "closed_actions"
      expr: COUNT(CASE WHEN safety_corrective_action_status = 'Closed' THEN 1 END)
      comment: "Number of closed corrective actions"
    - name: "critical_priority_actions"
      expr: COUNT(CASE WHEN priority = 'Critical' THEN 1 END)
      comment: "Number of critical priority corrective actions"
    - name: "total_estimated_cost"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of corrective actions"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of corrective actions"
    - name: "avg_days_overdue"
      expr: AVG(CAST(days_overdue AS DOUBLE))
      comment: "Average days overdue for overdue actions (action management effectiveness)"
    - name: "actions_requiring_training"
      expr: COUNT(CASE WHEN training_required = TRUE THEN 1 END)
      comment: "Number of corrective actions requiring training"
    - name: "effective_actions"
      expr: COUNT(CASE WHEN effectiveness_outcome = 'Effective' THEN 1 END)
      comment: "Number of corrective actions verified as effective (quality of remediation KPI)"
    - name: "escalated_actions"
      expr: COUNT(CASE WHEN escalation_status = 'Escalated' THEN 1 END)
      comment: "Number of escalated corrective actions"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`safety_env_monitoring_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental monitoring reading metrics tracking air quality, emissions, and environmental parameter exceedances for regulatory compliance and environmental impact management"
  source: "`shipping_ports_ecm`.`safety`.`env_monitoring_reading`"
  dimensions:
    - name: "parameter_type"
      expr: parameter_type
      comment: "Type of environmental parameter monitored (e.g., PM10, PM2.5, NOx, SO2, noise, water quality)"
    - name: "exceedance_flag"
      expr: exceedance_flag
      comment: "Whether reading exceeded regulatory threshold (critical environmental compliance indicator)"
    - name: "exceedance_severity"
      expr: exceedance_severity
      comment: "Severity of threshold exceedance"
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Whether regulatory notification is required for this reading"
    - name: "regulatory_notification_status"
      expr: regulatory_notification_status
      comment: "Status of regulatory notification"
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality flag for reading"
    - name: "compliance_standard"
      expr: compliance_standard
      comment: "Compliance standard applied (e.g., WHO, EPA, EU Directive)"
    - name: "operational_activity_type"
      expr: operational_activity_type
      comment: "Type of operational activity during reading (e.g., vessel berthing, cargo handling, bunkering)"
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition during reading"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for reading"
    - name: "reading_year"
      expr: YEAR(reading_timestamp)
      comment: "Year when reading was taken"
    - name: "reading_month"
      expr: DATE_TRUNC('MONTH', reading_timestamp)
      comment: "Month when reading was taken"
  measures:
    - name: "total_readings"
      expr: COUNT(1)
      comment: "Total number of environmental monitoring readings"
    - name: "exceedance_readings"
      expr: COUNT(CASE WHEN exceedance_flag = TRUE THEN 1 END)
      comment: "Number of readings exceeding regulatory thresholds (environmental compliance KPI)"
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across readings"
    - name: "max_measured_value"
      expr: MAX(CAST(measured_value AS DOUBLE))
      comment: "Maximum measured value (peak exposure/emission indicator)"
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average regulatory threshold value"
    - name: "total_ghg_co2_equivalent_kg"
      expr: SUM(CAST(ghg_co2_equivalent_kg AS DOUBLE))
      comment: "Total GHG CO2 equivalent in kilograms from monitored activities"
    - name: "avg_temperature_celsius"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average temperature during readings"
    - name: "avg_wind_speed_mps"
      expr: AVG(CAST(wind_speed_mps AS DOUBLE))
      comment: "Average wind speed in meters per second"
    - name: "regulatory_notifications_required"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END)
      comment: "Number of readings requiring regulatory notification"
    - name: "avg_exceedance_duration_minutes"
      expr: AVG(CAST(exceedance_duration_minutes AS DOUBLE))
      comment: "Average duration of threshold exceedances in minutes"
$$;