-- Metric views for domain: field | Business: Ngo | Version: 1 | Generated on: 2026-05-07 03:19:07

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`field_emergency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for active humanitarian emergencies — tracks funding coverage, population reach, and response scale to inform resource allocation and escalation decisions."
  source: "`ngo_ecm`.`field`.`emergency`"
  dimensions:
    - name: "emergency_type"
      expr: emergency_type
      comment: "Type of emergency (e.g. flood, conflict, disease outbreak) for cross-emergency-type performance comparison."
    - name: "emergency_status"
      expr: emergency_status
      comment: "Current lifecycle status of the emergency (active, closed, escalated) for operational filtering."
    - name: "severity_level"
      expr: severity_level
      comment: "Declared severity level of the emergency, used to prioritise resource deployment."
    - name: "disaster_category"
      expr: disaster_category
      comment: "Broad disaster category (natural, man-made, complex) for portfolio-level analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic footprint of the emergency (national, regional, local) for scale assessment."
    - name: "response_modality"
      expr: response_modality
      comment: "Primary response modality (cash, in-kind, service delivery) to track modality mix."
    - name: "declaration_year"
      expr: YEAR(declaration_date)
      comment: "Year the emergency was declared, enabling year-over-year trend analysis."
    - name: "declaration_month"
      expr: DATE_TRUNC('MONTH', declaration_date)
      comment: "Month of emergency declaration for temporal distribution analysis."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the emergency is currently active."
    - name: "flash_appeal_issued"
      expr: flash_appeal_issued
      comment: "Whether a flash appeal was issued, indicating scale and international visibility."
    - name: "hrp_issued"
      expr: hrp_issued
      comment: "Whether a Humanitarian Response Plan was issued for this emergency."
  measures:
    - name: "total_active_emergencies"
      expr: COUNT(CASE WHEN is_active = TRUE THEN emergency_id END)
      comment: "Count of currently active emergencies. Executives use this to gauge the breadth of simultaneous response obligations."
    - name: "total_affected_population"
      expr: SUM(CAST(affected_population_count AS DOUBLE))
      comment: "Total number of people affected across all emergencies. Core humanitarian scale indicator for resource planning."
    - name: "total_displaced_population"
      expr: SUM(CAST(displaced_population_count AS DOUBLE))
      comment: "Total displaced persons across emergencies. Drives shelter, NFI, and protection programming decisions."
    - name: "total_targeted_beneficiaries"
      expr: SUM(CAST(targeted_beneficiaries_count AS DOUBLE))
      comment: "Total beneficiaries targeted for assistance. Compared against reached counts to assess coverage gaps."
    - name: "total_funding_received_usd"
      expr: SUM(CAST(funding_received_usd AS DOUBLE))
      comment: "Total funding mobilised across emergencies in USD. Primary financial health indicator for emergency response."
    - name: "total_funding_requirement_usd"
      expr: SUM(CAST(funding_requirement_usd AS DOUBLE))
      comment: "Total funding required across emergencies in USD. Used alongside funding received to compute coverage ratio."
    - name: "avg_funding_received_per_emergency_usd"
      expr: AVG(CAST(funding_received_usd AS DOUBLE))
      comment: "Average funding received per emergency. Highlights underfunded emergencies relative to portfolio average."
    - name: "funding_coverage_ratio"
      expr: ROUND(100.0 * SUM(CAST(funding_received_usd AS DOUBLE)) / NULLIF(SUM(CAST(funding_requirement_usd AS DOUBLE)), 0), 2)
      comment: "Percentage of total funding requirement covered by received funding. Critical indicator of resource adequacy for emergency response."
    - name: "avg_affected_population_per_emergency"
      expr: AVG(CAST(affected_population_count AS DOUBLE))
      comment: "Average affected population per emergency. Informs standard response capacity planning."
    - name: "emergencies_with_flash_appeal"
      expr: COUNT(CASE WHEN flash_appeal_issued = TRUE THEN emergency_id END)
      comment: "Number of emergencies where a flash appeal was issued. Indicates scale of internationally-recognised crises."
    - name: "emergencies_with_hrp"
      expr: COUNT(CASE WHEN hrp_issued = TRUE THEN emergency_id END)
      comment: "Number of emergencies with an active Humanitarian Response Plan. Reflects strategic planning coverage."
    - name: "rapid_assessment_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rapid_assessment_completed = TRUE THEN emergency_id END) / NULLIF(COUNT(emergency_id), 0), 2)
      comment: "Percentage of emergencies where a rapid assessment was completed. Measures operational readiness and evidence-based response initiation."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`field_distribution_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for humanitarian distribution events — tracks delivery performance, budget utilisation, and beneficiary reach to steer field operations."
  source: "`ngo_ecm`.`field`.`distribution_event`"
  dimensions:
    - name: "distribution_status"
      expr: distribution_status
      comment: "Current status of the distribution event (planned, in-progress, completed, cancelled)."
    - name: "distribution_type"
      expr: distribution_type
      comment: "Type of distribution (food, NFI, cash, voucher) for sector-level performance analysis."
    - name: "distribution_modality"
      expr: distribution_modality
      comment: "Delivery modality (direct, partner-led, market-based) to evaluate modality effectiveness."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Category of commodity distributed for supply chain and programme planning."
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "First administrative level (e.g. province/state) for geographic performance breakdown."
    - name: "admin_level_2"
      expr: admin_level_2
      comment: "Second administrative level (e.g. district) for granular geographic analysis."
    - name: "distribution_location_name"
      expr: distribution_location_name
      comment: "Name of the distribution point for site-level performance tracking."
    - name: "scheduled_year"
      expr: YEAR(scheduled_date)
      comment: "Year the distribution was scheduled, enabling annual trend analysis."
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month the distribution was scheduled for temporal pipeline analysis."
    - name: "incident_reported_flag"
      expr: incident_reported_flag
      comment: "Whether an incident was reported during this distribution event."
    - name: "pdm_scheduled_flag"
      expr: pdm_scheduled_flag
      comment: "Whether a post-distribution monitoring exercise was scheduled."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify beneficiary identity and entitlement."
  measures:
    - name: "total_distribution_events"
      expr: COUNT(distribution_event_id)
      comment: "Total number of distribution events. Baseline throughput indicator for field operations."
    - name: "total_actual_expenditure_usd"
      expr: SUM(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Total actual expenditure across all distribution events in the reporting currency. Core financial accountability metric."
    - name: "total_budget_allocated_usd"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated to distribution events. Used to compute budget utilisation rate."
    - name: "budget_utilisation_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_expenditure_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_allocated_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated budget actually spent on distributions. Measures financial execution efficiency and flags under/over-spend."
    - name: "avg_expenditure_per_event_usd"
      expr: AVG(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Average actual expenditure per distribution event. Benchmarks cost efficiency across locations and modalities."
    - name: "completed_events_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN distribution_status = 'completed' THEN distribution_event_id END) / NULLIF(COUNT(distribution_event_id), 0), 2)
      comment: "Percentage of distribution events that reached completed status. Measures operational delivery success rate."
    - name: "incident_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN incident_reported_flag = TRUE THEN distribution_event_id END) / NULLIF(COUNT(distribution_event_id), 0), 2)
      comment: "Percentage of distribution events with a reported incident. Safety and risk management KPI for field leadership."
    - name: "pdm_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pdm_scheduled_flag = TRUE THEN distribution_event_id END) / NULLIF(COUNT(distribution_event_id), 0), 2)
      comment: "Percentage of distribution events with post-distribution monitoring scheduled. Accountability and quality assurance indicator."
    - name: "avg_budget_per_event_usd"
      expr: AVG(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Average budget allocated per distribution event. Used for cost-per-event benchmarking and future planning."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`field_distribution_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item-level distribution KPIs tracking quantity delivery performance, variance, and unit economics to support supply chain and programme quality decisions."
  source: "`ngo_ecm`.`field`.`distribution_line`"
  dimensions:
    - name: "item_category"
      expr: item_category
      comment: "Category of the distributed item (food, NFI, medicine) for sector-level analysis."
    - name: "item_code"
      expr: item_code
      comment: "Standardised item code for SKU-level performance tracking."
    - name: "cluster_sector"
      expr: cluster_sector
      comment: "Humanitarian cluster or sector the item belongs to (WASH, Shelter, Food Security)."
    - name: "distribution_method"
      expr: distribution_method
      comment: "Method of distribution (direct handout, voucher, e-transfer) for modality comparison."
    - name: "distribution_status"
      expr: distribution_status
      comment: "Status of the distribution line (planned, distributed, cancelled)."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the distributed item (kg, litre, kit, piece)."
    - name: "quality_check_status"
      expr: quality_check_status
      comment: "Quality check outcome for the distributed batch. Flags quality failures for corrective action."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG goal alignment of the distributed item for donor reporting and impact attribution."
    - name: "pipeline_source"
      expr: pipeline_source
      comment: "Source of the supply pipeline (procurement, donation, inter-agency transfer)."
    - name: "variance_reason"
      expr: variance_reason
      comment: "Reason for quantity variance between planned and actual distribution."
  measures:
    - name: "total_quantity_distributed"
      expr: SUM(CAST(actual_quantity_distributed AS DOUBLE))
      comment: "Total quantity of items actually distributed. Primary throughput measure for supply chain and programme delivery."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity for distribution. Used to compute delivery rate against plan."
    - name: "quantity_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_quantity_distributed AS DOUBLE)) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of planned quantity actually distributed. Core supply chain performance indicator — below 90% triggers investigation."
    - name: "total_distribution_value_usd"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total monetary value of items distributed. Financial accountability metric for donor reporting."
    - name: "avg_unit_value_usd"
      expr: AVG(CAST(unit_value AS DOUBLE))
      comment: "Average unit value of distributed items. Used for cost benchmarking and procurement efficiency analysis."
    - name: "total_quantity_variance"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total variance between planned and actual quantities distributed. Negative variance signals supply shortfalls or access constraints."
    - name: "avg_quantity_variance_per_line"
      expr: AVG(CAST(variance_quantity AS DOUBLE))
      comment: "Average quantity variance per distribution line. Identifies systematic over- or under-distribution patterns."
    - name: "quality_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_check_status = 'passed' THEN distribution_line_id END) / NULLIF(COUNT(CASE WHEN quality_check_status IS NOT NULL THEN distribution_line_id END), 0), 2)
      comment: "Percentage of quality-checked distribution lines that passed. Measures commodity quality assurance effectiveness."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`field_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and coverage KPIs for field assessments — measures data quality, beneficiary satisfaction, and assessment utilisation to guide evidence-based programming decisions."
  source: "`ngo_ecm`.`field`.`assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of assessment (needs assessment, PDM, baseline, endline) for methodology comparison."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (planned, in-progress, completed, validated)."
    - name: "methodology"
      expr: methodology
      comment: "Data collection methodology (KII, FGD, survey, observation) for quality benchmarking."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the assessment (national, sub-national, site-level)."
    - name: "target_population"
      expr: target_population
      comment: "Target population group assessed (IDPs, refugees, host community) for disaggregated analysis."
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year the assessment was conducted for trend analysis."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment for temporal coverage analysis."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Whether the assessment is visible to donors. Relevant for accountability and reporting obligations."
    - name: "protection_concerns_noted"
      expr: protection_concerns_noted
      comment: "Whether protection concerns were identified during the assessment."
    - name: "mel_indicator_linked"
      expr: mel_indicator_linked
      comment: "Whether the assessment is linked to a MEL indicator for results framework tracking."
    - name: "data_collection_tool"
      expr: data_collection_tool
      comment: "Tool used for data collection (KoBoToolbox, ODK, paper) for digital transformation tracking."
  measures:
    - name: "total_assessments"
      expr: COUNT(assessment_id)
      comment: "Total number of assessments conducted. Baseline evidence generation throughput metric."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across assessments. Measures reliability of evidence base for programming decisions."
    - name: "avg_beneficiary_satisfaction_score"
      expr: AVG(CAST(beneficiary_satisfaction_score AS DOUBLE))
      comment: "Average beneficiary satisfaction score. Core accountability-to-affected-populations (AAP) metric used in donor and board reporting."
    - name: "avg_adequacy_score"
      expr: AVG(CAST(adequacy_score AS DOUBLE))
      comment: "Average programme adequacy score from assessments. Measures whether assistance meets beneficiary needs."
    - name: "validated_assessment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN assessment_status = 'validated' THEN assessment_id END) / NULLIF(COUNT(assessment_id), 0), 2)
      comment: "Percentage of assessments that have been validated. Measures data governance and quality assurance compliance."
    - name: "protection_concern_detection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN protection_concerns_noted = TRUE THEN assessment_id END) / NULLIF(COUNT(assessment_id), 0), 2)
      comment: "Percentage of assessments identifying protection concerns. Informs protection mainstreaming and referral pathway activation."
    - name: "mel_linked_assessment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN mel_indicator_linked = TRUE THEN assessment_id END) / NULLIF(COUNT(assessment_id), 0), 2)
      comment: "Percentage of assessments linked to MEL indicators. Measures results framework integration and evidence-based programme management."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`field_security_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Security risk and incident KPIs for field operations — tracks incident frequency, severity, financial impact, and reporting compliance to inform duty-of-care and access decisions."
  source: "`ngo_ecm`.`field`.`security_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of security incident (armed robbery, harassment, vehicle hijacking) for threat pattern analysis."
    - name: "incident_severity"
      expr: incident_severity
      comment: "Severity level of the incident (low, medium, high, critical) for risk prioritisation."
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident (open, under investigation, closed)."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the investigation into the incident."
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "First administrative level where the incident occurred for geographic risk mapping."
    - name: "admin_level_2"
      expr: admin_level_2
      comment: "Second administrative level for granular geographic risk analysis."
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year of incident for annual trend and year-over-year comparison."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of incident for temporal pattern analysis."
    - name: "reported_to_undss"
      expr: reported_to_undss
      comment: "Whether the incident was reported to UNDSS — compliance with inter-agency security reporting obligations."
    - name: "reported_to_inso"
      expr: reported_to_inso
      comment: "Whether the incident was reported to INSO — compliance with NGO security network reporting."
    - name: "sitrep_included"
      expr: sitrep_included
      comment: "Whether the incident was included in a situation report for donor and HQ visibility."
  measures:
    - name: "total_security_incidents"
      expr: COUNT(security_incident_id)
      comment: "Total number of security incidents recorded. Primary safety risk indicator for field operations leadership."
    - name: "total_estimated_asset_loss_usd"
      expr: SUM(CAST(estimated_asset_loss_usd AS DOUBLE))
      comment: "Total estimated financial loss from security incidents in USD. Informs insurance, risk provisioning, and asset protection decisions."
    - name: "avg_asset_loss_per_incident_usd"
      expr: AVG(CAST(estimated_asset_loss_usd AS DOUBLE))
      comment: "Average financial loss per security incident. Benchmarks incident cost and informs risk mitigation investment decisions."
    - name: "critical_incident_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN incident_severity = 'critical' THEN security_incident_id END) / NULLIF(COUNT(security_incident_id), 0), 2)
      comment: "Percentage of incidents classified as critical severity. Triggers immediate leadership review and potential programme suspension."
    - name: "undss_reporting_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reported_to_undss = TRUE THEN security_incident_id END) / NULLIF(COUNT(security_incident_id), 0), 2)
      comment: "Percentage of incidents reported to UNDSS. Measures compliance with inter-agency security reporting obligations."
    - name: "inso_reporting_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reported_to_inso = TRUE THEN security_incident_id END) / NULLIF(COUNT(security_incident_id), 0), 2)
      comment: "Percentage of incidents reported to INSO. Measures NGO security network reporting compliance."
    - name: "open_investigation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN investigation_status = 'open' THEN security_incident_id END) / NULLIF(COUNT(security_incident_id), 0), 2)
      comment: "Percentage of incidents with open investigations. High rates indicate unresolved security risks requiring management attention."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`field_access_constraint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Humanitarian access KPIs tracking constraint frequency, severity, and mitigation to inform programme continuity, advocacy, and donor notification decisions."
  source: "`ngo_ecm`.`field`.`access_constraint`"
  dimensions:
    - name: "constraint_type"
      expr: constraint_type
      comment: "Type of access constraint (bureaucratic, physical, security, weather) for root cause analysis."
    - name: "constraint_status"
      expr: constraint_status
      comment: "Current status of the constraint (active, resolved, escalated) for operational monitoring."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the access constraint for prioritisation of mitigation efforts."
    - name: "escalation_status"
      expr: escalation_status
      comment: "Whether the constraint has been escalated and to what level."
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "First administrative level affected by the constraint for geographic access mapping."
    - name: "admin_level_2"
      expr: admin_level_2
      comment: "Second administrative level for granular access analysis."
    - name: "constraint_start_year"
      expr: YEAR(constraint_start_date)
      comment: "Year the constraint began for trend analysis."
    - name: "constraint_start_month"
      expr: DATE_TRUNC('MONTH', constraint_start_date)
      comment: "Month the constraint began for temporal pattern analysis."
    - name: "alternative_route_available"
      expr: alternative_route_available
      comment: "Whether an alternative route exists — determines whether programme delivery can continue."
    - name: "negotiation_required"
      expr: negotiation_required
      comment: "Whether negotiation with armed actors or authorities is required to resolve the constraint."
    - name: "donor_notification_required"
      expr: donor_notification_required
      comment: "Whether the constraint triggers a donor notification obligation."
    - name: "security_incident_linked"
      expr: security_incident_linked
      comment: "Whether the constraint is linked to a security incident."
  measures:
    - name: "total_access_constraints"
      expr: COUNT(access_constraint_id)
      comment: "Total number of access constraints recorded. Baseline indicator of operational access environment."
    - name: "active_constraints_count"
      expr: COUNT(CASE WHEN constraint_status = 'active' THEN access_constraint_id END)
      comment: "Number of currently active access constraints. Real-time operational risk indicator for field management."
    - name: "severe_constraint_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN severity_level IN ('high', 'critical') THEN access_constraint_id END) / NULLIF(COUNT(access_constraint_id), 0), 2)
      comment: "Percentage of constraints classified as high or critical severity. Triggers escalation and advocacy actions."
    - name: "negotiation_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN negotiation_required = TRUE THEN access_constraint_id END) / NULLIF(COUNT(access_constraint_id), 0), 2)
      comment: "Percentage of constraints requiring negotiation. Measures complexity of access environment and humanitarian negotiation workload."
    - name: "donor_notification_pending_count"
      expr: COUNT(CASE WHEN donor_notification_required = TRUE AND constraint_status = 'active' THEN access_constraint_id END)
      comment: "Number of active constraints requiring donor notification. Compliance risk indicator for grant management."
    - name: "alternative_route_availability_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN alternative_route_available = TRUE THEN access_constraint_id END) / NULLIF(COUNT(access_constraint_id), 0), 2)
      comment: "Percentage of constraints where an alternative route is available. Measures programme continuity resilience."
    - name: "security_linked_constraint_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN security_incident_linked = TRUE THEN access_constraint_id END) / NULLIF(COUNT(access_constraint_id), 0), 2)
      comment: "Percentage of access constraints linked to security incidents. Quantifies security-driven access deterioration."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`field_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field deployment KPIs tracking staff deployment efficiency, cost, and operational coverage to inform workforce planning and emergency response capacity decisions."
  source: "`ngo_ecm`.`field`.`field_deployment`"
  dimensions:
    - name: "deployment_type"
      expr: deployment_type
      comment: "Type of deployment (emergency response, programme support, assessment) for capacity planning."
    - name: "deployment_status"
      expr: deployment_status
      comment: "Current status of the deployment (planned, active, completed, cancelled)."
    - name: "response_type"
      expr: response_type
      comment: "Response type (rapid onset, protracted crisis, development) for portfolio analysis."
    - name: "transportation_mode"
      expr: transportation_mode
      comment: "Mode of transportation used for deployment (air, road, boat) for logistics cost analysis."
    - name: "accommodation_type"
      expr: accommodation_type
      comment: "Type of accommodation during deployment for duty-of-care and cost benchmarking."
    - name: "security_clearance_level"
      expr: security_clearance_level
      comment: "Security clearance level required for the deployment location."
    - name: "cluster_affiliation"
      expr: cluster_affiliation
      comment: "Humanitarian cluster the deployment supports for inter-agency coordination tracking."
    - name: "deployment_start_year"
      expr: YEAR(start_date)
      comment: "Year the deployment started for annual capacity trend analysis."
    - name: "deployment_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the deployment started for temporal surge capacity analysis."
    - name: "medical_clearance_required"
      expr: medical_clearance_required
      comment: "Whether medical clearance was required for the deployment."
    - name: "gis_track_enabled"
      expr: gis_track_enabled
      comment: "Whether GIS tracking was enabled for the deployment — duty-of-care compliance indicator."
  measures:
    - name: "total_deployments"
      expr: COUNT(field_deployment_id)
      comment: "Total number of field deployments. Baseline operational capacity throughput metric."
    - name: "active_deployments_count"
      expr: COUNT(CASE WHEN deployment_status = 'active' THEN field_deployment_id END)
      comment: "Number of currently active deployments. Real-time field capacity indicator for operations management."
    - name: "total_deployment_cost_usd"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of all deployments. Core financial planning metric for emergency response budgeting."
    - name: "avg_deployment_cost_usd"
      expr: AVG(CAST(cost_estimate AS DOUBLE))
      comment: "Average cost per deployment. Benchmarks deployment efficiency and informs cost-per-deployment targets."
    - name: "gis_tracking_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gis_track_enabled = TRUE THEN field_deployment_id END) / NULLIF(COUNT(field_deployment_id), 0), 2)
      comment: "Percentage of deployments with GIS tracking enabled. Measures duty-of-care compliance for staff safety."
    - name: "deployment_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN deployment_status = 'completed' THEN field_deployment_id END) / NULLIF(COUNT(field_deployment_id), 0), 2)
      comment: "Percentage of deployments successfully completed. Measures operational delivery reliability."
    - name: "high_security_deployment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN security_clearance_level IN ('high', 'critical') THEN field_deployment_id END) / NULLIF(COUNT(field_deployment_id), 0), 2)
      comment: "Percentage of deployments to high or critical security locations. Informs risk management, insurance, and duty-of-care policies."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`field_project_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project site infrastructure and operational KPIs tracking site coverage, accessibility, and service readiness to guide site selection and investment decisions."
  source: "`ngo_ecm`.`field`.`project_site`"
  dimensions:
    - name: "site_type"
      expr: site_type
      comment: "Type of project site (health post, distribution point, school, office) for sector analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the site (active, suspended, closed) for portfolio management."
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "First administrative level for geographic coverage analysis."
    - name: "admin_level_2"
      expr: admin_level_2
      comment: "Second administrative level for granular geographic distribution."
    - name: "security_level"
      expr: security_level
      comment: "Security level of the site location for risk-adjusted operational planning."
    - name: "accessibility_rating"
      expr: accessibility_rating
      comment: "Accessibility rating of the site for logistics and supply chain planning."
    - name: "cluster_affiliation"
      expr: cluster_affiliation
      comment: "Humanitarian cluster the site supports for inter-agency coordination."
    - name: "facility_ownership"
      expr: facility_ownership
      comment: "Ownership of the facility (owned, rented, government-provided) for asset management."
    - name: "establishment_year"
      expr: YEAR(establishment_date)
      comment: "Year the site was established for portfolio age analysis."
    - name: "electricity_available"
      expr: electricity_available
      comment: "Whether electricity is available at the site — infrastructure readiness indicator."
    - name: "water_source_available"
      expr: water_source_available
      comment: "Whether a water source is available at the site — WASH infrastructure indicator."
    - name: "kobo_collection_enabled"
      expr: kobo_collection_enabled
      comment: "Whether KoBoToolbox data collection is enabled at the site — digital data quality indicator."
  measures:
    - name: "total_project_sites"
      expr: COUNT(project_site_id)
      comment: "Total number of project sites in the portfolio. Baseline geographic coverage metric."
    - name: "active_sites_count"
      expr: COUNT(CASE WHEN operational_status = 'active' THEN project_site_id END)
      comment: "Number of currently active project sites. Real-time operational footprint indicator."
    - name: "active_site_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN operational_status = 'active' THEN project_site_id END) / NULLIF(COUNT(project_site_id), 0), 2)
      comment: "Percentage of project sites that are currently active. Measures portfolio utilisation and identifies dormant assets."
    - name: "total_site_area_sqm"
      expr: SUM(CAST(site_area_sqm AS DOUBLE))
      comment: "Total physical area of all project sites in square metres. Asset management and capacity planning metric."
    - name: "avg_site_area_sqm"
      expr: AVG(CAST(site_area_sqm AS DOUBLE))
      comment: "Average site area in square metres. Benchmarks site capacity for service delivery planning."
    - name: "electricity_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN electricity_available = TRUE THEN project_site_id END) / NULLIF(COUNT(project_site_id), 0), 2)
      comment: "Percentage of sites with electricity access. Infrastructure readiness indicator for cold chain, digital tools, and medical services."
    - name: "water_access_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN water_source_available = TRUE THEN project_site_id END) / NULLIF(COUNT(project_site_id), 0), 2)
      comment: "Percentage of sites with water source access. WASH infrastructure compliance and service delivery readiness metric."
    - name: "digital_data_collection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN kobo_collection_enabled = TRUE THEN project_site_id END) / NULLIF(COUNT(project_site_id), 0), 2)
      comment: "Percentage of sites with KoBoToolbox data collection enabled. Measures digital transformation progress and data quality infrastructure."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`field_sitrep`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Situation report KPIs tracking reporting compliance, funding gaps, and humanitarian response progress to support donor accountability and operational oversight."
  source: "`ngo_ecm`.`field`.`sitrep`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Status of the sitrep (draft, submitted, approved, published) for reporting pipeline management."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of reporting (weekly, bi-weekly, monthly) for compliance monitoring."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope covered by the sitrep for coverage analysis."
    - name: "admin_level_1_name"
      expr: admin_level_1_name
      comment: "First administrative level covered in the sitrep."
    - name: "cluster_lead_agency"
      expr: cluster_lead_agency
      comment: "Lead agency for the cluster covered in the sitrep for inter-agency accountability."
    - name: "publication_year"
      expr: YEAR(publication_date)
      comment: "Year of sitrep publication for annual reporting trend analysis."
    - name: "publication_month"
      expr: DATE_TRUNC('MONTH', publication_date)
      comment: "Month of sitrep publication for temporal reporting cadence analysis."
    - name: "donor_submission_required"
      expr: donor_submission_required
      comment: "Whether the sitrep must be submitted to a donor — compliance obligation flag."
    - name: "ocha_submission_required"
      expr: ocha_submission_required
      comment: "Whether the sitrep must be submitted to OCHA — inter-agency reporting obligation flag."
    - name: "cerf_application_status"
      expr: cerf_application_status
      comment: "Status of any CERF application referenced in the sitrep."
  measures:
    - name: "total_sitreps"
      expr: COUNT(sitrep_id)
      comment: "Total number of situation reports produced. Baseline reporting output metric."
    - name: "total_funding_gap_usd"
      expr: SUM(CAST(funding_gap_usd AS DOUBLE))
      comment: "Total funding gap reported across all sitreps in USD. Critical resource mobilisation indicator for donor engagement."
    - name: "avg_funding_gap_usd"
      expr: AVG(CAST(funding_gap_usd AS DOUBLE))
      comment: "Average funding gap per sitrep. Benchmarks resource shortfall severity across reporting periods."
    - name: "avg_hrp_progress_percentage"
      expr: AVG(CAST(hrp_progress_percentage AS DOUBLE))
      comment: "Average Humanitarian Response Plan progress percentage across sitreps. Measures collective response achievement against plan."
    - name: "published_sitrep_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN report_status = 'published' THEN sitrep_id END) / NULLIF(COUNT(sitrep_id), 0), 2)
      comment: "Percentage of sitreps that reached published status. Measures reporting pipeline efficiency and accountability compliance."
    - name: "donor_submission_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN donor_submission_required = TRUE AND report_status = 'published' THEN sitrep_id END) / NULLIF(COUNT(CASE WHEN donor_submission_required = TRUE THEN sitrep_id END), 0), 2)
      comment: "Percentage of donor-required sitreps that were published. Measures grant compliance and donor relationship management."
    - name: "ocha_submission_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ocha_submission_required = TRUE AND report_status = 'published' THEN sitrep_id END) / NULLIF(COUNT(CASE WHEN ocha_submission_required = TRUE THEN sitrep_id END), 0), 2)
      comment: "Percentage of OCHA-required sitreps that were published. Measures inter-agency reporting compliance."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`field_assessment_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level assessment response KPIs tracking vulnerability profiles, food security, and protection concerns to guide targeting and programme design decisions."
  source: "`ngo_ecm`.`field`.`assessment_response`"
  dimensions:
    - name: "displacement_status"
      expr: displacement_status
      comment: "Displacement status of the assessed household (IDP, refugee, returnee, host community)."
    - name: "primary_need_category"
      expr: primary_need_category
      comment: "Primary need category identified (food, shelter, WASH, health, protection) for programme targeting."
    - name: "shelter_type"
      expr: shelter_type
      comment: "Type of shelter the household occupies for shelter programme planning."
    - name: "shelter_condition"
      expr: shelter_condition
      comment: "Condition of the household shelter for vulnerability assessment."
    - name: "livelihood_status"
      expr: livelihood_status
      comment: "Livelihood status of the household for economic vulnerability analysis."
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Method used to collect the response (face-to-face, phone, digital) for data quality analysis."
    - name: "response_status"
      expr: response_status
      comment: "Status of the assessment response (complete, partial, refused) for data completeness tracking."
    - name: "interview_language"
      expr: interview_language
      comment: "Language used during the interview for language access and inclusion analysis."
    - name: "submission_year"
      expr: YEAR(submission_timestamp)
      comment: "Year of response submission for temporal trend analysis."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of response submission for data collection pipeline monitoring."
    - name: "protection_concern_flag"
      expr: protection_concern_flag
      comment: "Whether a protection concern was identified for this household."
    - name: "referral_required_flag"
      expr: referral_required_flag
      comment: "Whether a referral to another service was required."
    - name: "disability_present_flag"
      expr: disability_present_flag
      comment: "Whether a household member has a disability — inclusion and targeting indicator."
  measures:
    - name: "total_households_assessed"
      expr: COUNT(DISTINCT household_id)
      comment: "Total unique households assessed. Primary coverage metric for needs assessment reach."
    - name: "total_responses"
      expr: COUNT(assessment_response_id)
      comment: "Total assessment responses collected. Data collection throughput metric."
    - name: "avg_food_security_score"
      expr: AVG(CAST(food_security_score AS DOUBLE))
      comment: "Average food security score across assessed households. Core humanitarian needs indicator driving food assistance targeting."
    - name: "avg_monthly_income_usd"
      expr: AVG(CAST(monthly_income_usd AS DOUBLE))
      comment: "Average monthly household income in USD. Economic vulnerability indicator for cash and livelihood programme design."
    - name: "protection_concern_prevalence_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN protection_concern_flag = TRUE THEN assessment_response_id END) / NULLIF(COUNT(assessment_response_id), 0), 2)
      comment: "Percentage of assessed households with identified protection concerns. Drives protection programme scale and referral pathway activation."
    - name: "referral_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN referral_required_flag = TRUE THEN assessment_response_id END) / NULLIF(COUNT(assessment_response_id), 0), 2)
      comment: "Percentage of households requiring referral to another service. Measures inter-sector coordination demand and case management workload."
    - name: "disability_inclusion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN disability_present_flag = TRUE THEN assessment_response_id END) / NULLIF(COUNT(assessment_response_id), 0), 2)
      comment: "Percentage of assessed households with a person with disability. Measures inclusion of most vulnerable populations in assessment coverage."
    - name: "avg_gps_accuracy_meters"
      expr: AVG(CAST(gps_accuracy_meters AS DOUBLE))
      comment: "Average GPS accuracy of response submissions in metres. Data quality indicator for geographic precision of field data collection."
$$;