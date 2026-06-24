-- Metric views for domain: field | Business: Ngo | Version: 2 | Generated on: 2026-06-23 01:23:48

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_distribution_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for humanitarian distribution events. Tracks budget utilisation, beneficiary reach, and operational efficiency across distribution modalities. Sourced from field operations systems (KoboToolbox, ODK, DHIS2) and reconciled against award/fund records (SAP VISION, eTools). Supports IPSAS-aligned expenditure reporting and donor accountability. PII note: distribution_location_name and GPS coordinates are field-level data; apply pii_de_identified masking policy where beneficiary linkage exists."
  source: "`vibe_ngo_v1`.`field`.`distribution_event`"
  dimensions:
    - name: "distribution_status"
      expr: distribution_status
      comment: "Current status of the distribution event (e.g. Planned, In Progress, Completed, Cancelled). Primary filter for operational dashboards."
    - name: "distribution_type"
      expr: distribution_type
      comment: "Type of distribution (e.g. In-Kind, Cash, Voucher). Drives modality analysis and donor reporting."
    - name: "distribution_modality"
      expr: distribution_modality
      comment: "Delivery modality (e.g. Direct, Partner-Led, Mobile). Used for efficiency benchmarking across modalities."
    - name: "cva_transfer_modality"
      expr: cva_transfer_modality
      comment: "Cash and Voucher Assistance transfer modality (e.g. Mobile Money, Bank Transfer, Voucher). Critical for CVA programme steering."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Category of commodity distributed (e.g. Food, NFI, WASH). Enables sector-level analysis."
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "First administrative level (e.g. province/state) of the distribution location. Supports geographic disaggregation."
    - name: "admin_level_2"
      expr: admin_level_2
      comment: "Second administrative level (e.g. district) of the distribution location."
    - name: "scheduled_date_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month of scheduled distribution date. Enables trend analysis and pipeline planning."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify beneficiary eligibility (e.g. Biometric, Token, List). Affects data quality and fraud risk."
    - name: "pdm_scheduled_flag"
      expr: pdm_scheduled_flag
      comment: "Whether a Post-Distribution Monitoring survey is scheduled. Indicates accountability and learning commitment."
    - name: "incident_reported_flag"
      expr: incident_reported_flag
      comment: "Whether a security or operational incident was reported during this distribution event."
  measures:
    - name: "total_distribution_events"
      expr: COUNT(1)
      comment: "Total number of distribution events. Baseline volume metric for operational throughput reporting."
    - name: "total_actual_expenditure_usd"
      expr: SUM(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Total actual expenditure across all distribution events in USD. Core financial KPI for budget burn and donor accountability under IPSAS/ASC 958."
    - name: "total_budget_allocated_usd"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated to distribution events. Used as denominator for budget utilisation rate."
    - name: "budget_utilisation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_expenditure_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_allocated_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated budget actually spent. Key efficiency KPI for programme managers and donors. Values significantly below 100% indicate underspend risk; above 100% indicate overrun."
    - name: "avg_expenditure_per_event_usd"
      expr: ROUND(AVG(CAST(actual_expenditure_amount AS DOUBLE)), 2)
      comment: "Average expenditure per distribution event. Benchmarks cost efficiency across sites, modalities, and partners."
    - name: "events_with_incident_count"
      expr: COUNT(CASE WHEN incident_reported_flag = TRUE THEN 1 END)
      comment: "Number of distribution events where a security or operational incident was reported. Safety and risk KPI for field leadership."
    - name: "incident_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN incident_reported_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of distribution events with a reported incident. Tracks field safety trends and informs risk mitigation decisions."
    - name: "events_with_pdm_scheduled_count"
      expr: COUNT(CASE WHEN pdm_scheduled_flag = TRUE THEN 1 END)
      comment: "Number of distribution events with a Post-Distribution Monitoring survey scheduled. Accountability and CHS compliance indicator."
    - name: "pdm_scheduling_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pdm_scheduled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of distribution events with PDM scheduled. Core CHS/SPHERE accountability metric; donors require minimum PDM coverage thresholds."
    - name: "events_with_sitrep_included_count"
      expr: COUNT(CASE WHEN sitrep_included_flag = TRUE THEN 1 END)
      comment: "Number of distribution events included in situation reports. Measures reporting coverage for OCHA and donor visibility."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for field assessments including needs assessments, PDM, and baseline surveys. Tracks data quality, coverage, and protection mainstreaming. Sourced from KoboToolbox, ODK Collect, and DHIS2. Supports MEL frameworks (IPSAS-aligned programme reporting). PII note: GPS coordinates and key_findings_summary may contain beneficiary-identifiable information; apply pii_de_identified masking policy."
  source: "`vibe_ngo_v1`.`field`.`assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of assessment (e.g. Needs Assessment, PDM, Baseline, Endline, Rapid). Primary classification for portfolio analysis."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (e.g. Planned, In Progress, Completed, Validated). Operational pipeline filter."
    - name: "methodology"
      expr: methodology
      comment: "Data collection methodology (e.g. KII, FGD, Survey, Observation). Affects data quality interpretation."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the assessment (e.g. National, Regional, District). Supports coverage gap analysis."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment date. Enables trend analysis of assessment pipeline."
    - name: "protection_concerns_noted"
      expr: protection_concerns_noted
      comment: "Whether protection concerns were identified during the assessment. Critical safeguarding and programme design flag."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Whether the assessment is visible to donors. Affects reporting obligations and transparency."
    - name: "mel_indicator_linked"
      expr: mel_indicator_linked
      comment: "Whether the assessment is linked to a MEL indicator. Measures integration between field data and results frameworks."
    - name: "data_collection_tool"
      expr: data_collection_tool
      comment: "Tool used for data collection (e.g. KoboToolbox, ODK, Paper). Affects data quality and processing efficiency."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of assessments conducted. Baseline volume metric for MEL and programme coverage reporting."
    - name: "avg_data_quality_score"
      expr: ROUND(AVG(CAST(data_quality_score AS DOUBLE)), 2)
      comment: "Average data quality score across assessments. Tracks data reliability trends; low scores trigger data quality improvement interventions."
    - name: "avg_beneficiary_satisfaction_score"
      expr: ROUND(AVG(CAST(beneficiary_satisfaction_score AS DOUBLE)), 2)
      comment: "Average beneficiary satisfaction score. Core accountability-to-affected-populations (AAP) KPI required by CHS and major donors."
    - name: "avg_adequacy_score"
      expr: ROUND(AVG(CAST(adequacy_score AS DOUBLE)), 2)
      comment: "Average adequacy score measuring whether programme response meets identified needs. Informs programme design adjustments."
    - name: "assessments_with_protection_concerns_count"
      expr: COUNT(CASE WHEN protection_concerns_noted = TRUE THEN 1 END)
      comment: "Number of assessments where protection concerns were identified. Drives protection mainstreaming and referral decisions."
    - name: "protection_concern_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN protection_concerns_noted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments identifying protection concerns. Strategic risk indicator for programme leadership and safeguarding teams."
    - name: "assessments_linked_to_mel_indicator_count"
      expr: COUNT(CASE WHEN mel_indicator_linked = TRUE THEN 1 END)
      comment: "Number of assessments linked to a MEL indicator. Measures results-framework integration and evidence-based programming quality."
    - name: "mel_linkage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mel_indicator_linked = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments linked to MEL indicators. Donor and IATI reporting quality metric; low rates indicate evidence gaps."
    - name: "validated_assessments_count"
      expr: COUNT(CASE WHEN validation_date IS NOT NULL THEN 1 END)
      comment: "Number of assessments that have been formally validated. Data governance and quality assurance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_pdm_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Post-Distribution Monitoring (PDM) survey KPIs measuring beneficiary satisfaction, programme adequacy, and accountability to affected populations. PDM is a mandatory accountability mechanism under CHS, SPHERE, and most institutional donor frameworks (USAID, ECHO, FCDO). Sourced from KoboToolbox and field data systems. Supports IPSAS programme reporting and donor audit requirements. PII note: household-level survey data carries pii_beneficiary_protected classification."
  source: "`vibe_ngo_v1`.`field`.`pdm_survey`"
  dimensions:
    - name: "survey_status"
      expr: survey_status
      comment: "Current status of the PDM survey (e.g. Planned, In Progress, Completed, Approved). Pipeline management dimension."
    - name: "survey_methodology"
      expr: survey_methodology
      comment: "Methodology used for the PDM survey (e.g. Phone, Face-to-Face, Remote). Affects response rates and data quality."
    - name: "cluster_sector"
      expr: cluster_sector
      comment: "Humanitarian cluster/sector the PDM covers (e.g. Food Security, WASH, Shelter). Enables sector-level accountability analysis."
    - name: "chs_compliance_rating"
      expr: chs_compliance_rating
      comment: "Core Humanitarian Standard compliance rating from the PDM. Directly informs CHS self-assessment and donor reporting."
    - name: "protection_concerns_noted"
      expr: protection_concerns_noted
      comment: "Whether protection concerns were identified in the PDM. Triggers follow-up case management and programme adjustments."
    - name: "corrective_actions_required"
      expr: corrective_actions_required
      comment: "Whether corrective actions are required based on PDM findings. Operational accountability flag."
    - name: "survey_date_month"
      expr: DATE_TRUNC('MONTH', survey_date)
      comment: "Month of PDM survey date. Enables trend analysis of accountability cycle compliance."
    - name: "gender_disaggregation_available"
      expr: gender_disaggregation_available
      comment: "Whether gender-disaggregated data is available in the PDM. IASC and donor requirement for gender-responsive programming."
    - name: "age_disaggregation_available"
      expr: age_disaggregation_available
      comment: "Whether age-disaggregated data is available. Required for child protection and elderly vulnerability reporting."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment tag for the PDM. Supports SDG progress reporting to UN agencies and institutional donors."
  measures:
    - name: "total_pdm_surveys"
      expr: COUNT(1)
      comment: "Total number of PDM surveys conducted. Baseline accountability coverage metric."
    - name: "avg_satisfaction_score"
      expr: ROUND(AVG(CAST(satisfaction_score AS DOUBLE)), 2)
      comment: "Average beneficiary satisfaction score across PDM surveys. Primary AAP KPI; below-threshold scores trigger programme review."
    - name: "avg_adequacy_score"
      expr: ROUND(AVG(CAST(adequacy_score AS DOUBLE)), 2)
      comment: "Average adequacy score measuring whether distributed items met beneficiary needs. Informs commodity selection and quantity planning."
    - name: "avg_aap_score"
      expr: ROUND(AVG(CAST(aap_score AS DOUBLE)), 2)
      comment: "Average Accountability to Affected Populations (AAP) score. Composite CHS compliance indicator used in donor reports and board dashboards."
    - name: "avg_response_rate_pct"
      expr: ROUND(AVG(CAST(response_rate_percent AS DOUBLE)), 2)
      comment: "Average survey response rate. Low response rates indicate sampling bias risk and reduce data reliability for donor reporting."
    - name: "surveys_with_protection_concerns_count"
      expr: COUNT(CASE WHEN protection_concerns_noted = TRUE THEN 1 END)
      comment: "Number of PDM surveys identifying protection concerns. Drives protection referral and programme safeguarding response."
    - name: "protection_concern_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN protection_concerns_noted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PDM surveys with protection concerns identified. Strategic risk KPI for programme and safeguarding leadership."
    - name: "surveys_requiring_corrective_action_count"
      expr: COUNT(CASE WHEN corrective_actions_required = TRUE THEN 1 END)
      comment: "Number of PDM surveys requiring corrective actions. Operational quality KPI; high counts indicate systemic programme delivery issues."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_actions_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PDM surveys requiring corrective actions. Donor audit and CHS compliance metric; thresholds typically set at <20%."
    - name: "surveys_with_gender_disaggregation_count"
      expr: COUNT(CASE WHEN gender_disaggregation_available = TRUE THEN 1 END)
      comment: "Number of PDM surveys with gender-disaggregated data. IASC and ECHO/USAID reporting requirement for gender-responsive programming."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_security_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Security incident KPIs for field operations risk management. Tracks incident frequency, severity, staff impact, and reporting compliance. Sourced from UNDSS, INSO, and internal security management systems. Critical for duty-of-care obligations, donor reporting, and operational continuity decisions. PII note: staff casualty data carries pii_staff classification; apply appropriate masking for non-security-cleared users."
  source: "`vibe_ngo_v1`.`field`.`security_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of security incident (e.g. Armed Robbery, Carjacking, Threat, Harassment). Primary classification for risk pattern analysis."
    - name: "incident_severity"
      expr: incident_severity
      comment: "Severity level of the incident (e.g. Critical, High, Medium, Low). Drives escalation and response protocols."
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident (e.g. Open, Under Investigation, Closed). Operational case management dimension."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the investigation into the incident. Accountability and compliance dimension."
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "First administrative level where the incident occurred. Geographic risk mapping dimension."
    - name: "admin_level_2"
      expr: admin_level_2
      comment: "Second administrative level where the incident occurred. Granular geographic risk analysis."
    - name: "incident_date_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of incident date. Enables trend analysis and seasonal risk pattern identification."
    - name: "reported_to_undss"
      expr: reported_to_undss
      comment: "Whether the incident was reported to UNDSS. UN inter-agency reporting compliance dimension."
    - name: "reported_to_inso"
      expr: reported_to_inso
      comment: "Whether the incident was reported to INSO. NGO security network reporting compliance dimension."
    - name: "sitrep_included"
      expr: sitrep_included
      comment: "Whether the incident was included in a situation report. Donor and OCHA visibility dimension."
  measures:
    - name: "total_security_incidents"
      expr: COUNT(1)
      comment: "Total number of security incidents. Baseline risk volume metric for security dashboards and board reporting."
    - name: "total_estimated_asset_loss_usd"
      expr: SUM(CAST(estimated_asset_loss_usd AS DOUBLE))
      comment: "Total estimated financial loss from security incidents. Financial risk KPI for insurance, donor reporting, and asset management."
    - name: "avg_estimated_asset_loss_usd"
      expr: ROUND(AVG(CAST(estimated_asset_loss_usd AS DOUBLE)), 2)
      comment: "Average financial loss per security incident. Benchmarks incident cost for risk budgeting and insurance premium decisions."
    - name: "critical_high_incidents_count"
      expr: COUNT(CASE WHEN incident_severity IN ('Critical', 'High') THEN 1 END)
      comment: "Number of critical or high severity incidents. Primary duty-of-care KPI; triggers immediate leadership escalation and operational review."
    - name: "critical_high_incident_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN incident_severity IN ('Critical', 'High') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents classified as critical or high severity. Trend indicator for deteriorating security environments."
    - name: "undss_reporting_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reported_to_undss = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents reported to UNDSS. UN inter-agency reporting compliance KPI; non-compliance risks loss of UN security support."
    - name: "inso_reporting_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reported_to_inso = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents reported to INSO. NGO security network compliance KPI; required for INSO membership and collective security intelligence."
    - name: "open_incidents_count"
      expr: COUNT(CASE WHEN incident_status = 'Open' THEN 1 END)
      comment: "Number of currently open security incidents. Operational backlog KPI for security management teams."
    - name: "incidents_in_sitrep_count"
      expr: COUNT(CASE WHEN sitrep_included = TRUE THEN 1 END)
      comment: "Number of incidents included in situation reports. Donor and OCHA transparency compliance metric."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_emergency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Emergency response KPIs tracking humanitarian crisis scale, funding coverage, and response activation. Supports HRP (Humanitarian Response Plan) monitoring, CERF allocation tracking, and cluster coordination oversight. Aligned with OCHA reporting standards and IPSAS-compliant fund tracking. Sourced from eTools, ReliefWeb, and internal programme management systems (SAP VISION for financial data)."
  source: "`vibe_ngo_v1`.`field`.`emergency`"
  dimensions:
    - name: "emergency_type"
      expr: emergency_type
      comment: "Type of emergency (e.g. Conflict, Natural Disaster, Disease Outbreak, Displacement). Primary classification for response portfolio analysis."
    - name: "disaster_category"
      expr: disaster_category
      comment: "Disaster category (e.g. Flood, Drought, Earthquake, Armed Conflict). Enables sector-specific response benchmarking."
    - name: "emergency_status"
      expr: emergency_status
      comment: "Current status of the emergency (e.g. Active, Monitoring, Closed). Operational pipeline dimension."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the emergency. Drives resource allocation and escalation decisions."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the emergency (e.g. National, Sub-National, Regional). Scale dimension for resource planning."
    - name: "declaration_date_month"
      expr: DATE_TRUNC('MONTH', declaration_date)
      comment: "Month of emergency declaration. Enables trend analysis of emergency onset patterns."
    - name: "hrp_issued"
      expr: hrp_issued
      comment: "Whether a Humanitarian Response Plan has been issued. Indicates formal inter-agency coordination activation."
    - name: "flash_appeal_issued"
      expr: flash_appeal_issued
      comment: "Whether a Flash Appeal has been issued. Indicates rapid funding mobilisation activation."
    - name: "cerf_allocation_received"
      expr: cerf_allocation_received
      comment: "Whether CERF (Central Emergency Response Fund) allocation was received. Tracks UN emergency funding activation."
    - name: "is_active"
      expr: is_active
      comment: "Whether the emergency is currently active. Primary operational filter for live response dashboards."
  measures:
    - name: "total_emergencies"
      expr: COUNT(1)
      comment: "Total number of emergencies in the portfolio. Baseline volume metric for response capacity planning."
    - name: "total_affected_population"
      expr: SUM(CAST(affected_population_count AS DOUBLE))
      comment: "Total affected population across all emergencies. Primary scale metric for resource allocation and donor appeals."
    - name: "total_displaced_population"
      expr: SUM(CAST(displaced_population_count AS DOUBLE))
      comment: "Total displaced population across emergencies. Critical protection and shelter planning KPI."
    - name: "total_targeted_beneficiaries"
      expr: SUM(CAST(targeted_beneficiaries_count AS DOUBLE))
      comment: "Total targeted beneficiaries across emergency responses. Measures response ambition against affected population scale."
    - name: "total_funding_received_usd"
      expr: SUM(CAST(funding_received_usd AS DOUBLE))
      comment: "Total funding received across emergencies in USD. Core financial KPI for response capacity and donor accountability."
    - name: "total_funding_requirement_usd"
      expr: SUM(CAST(funding_requirement_usd AS DOUBLE))
      comment: "Total funding requirement across emergencies. Used as denominator for funding coverage rate calculation."
    - name: "funding_coverage_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(funding_received_usd AS DOUBLE)) / NULLIF(SUM(CAST(funding_requirement_usd AS DOUBLE)), 0), 2)
      comment: "Percentage of funding requirements covered by received funding. Critical HRP and Flash Appeal KPI; below 50% indicates severe response capacity gap."
    - name: "avg_funding_gap_usd"
      expr: ROUND(AVG(CAST(funding_requirement_usd AS DOUBLE) - CAST(funding_received_usd AS DOUBLE)), 2)
      comment: "Average funding gap per emergency (requirement minus received). Prioritisation metric for resource mobilisation efforts."
    - name: "active_emergencies_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active emergencies. Operational capacity planning KPI for leadership and resource allocation."
    - name: "emergencies_with_hrp_count"
      expr: COUNT(CASE WHEN hrp_issued = TRUE THEN 1 END)
      comment: "Number of emergencies with an HRP issued. Measures formal inter-agency coordination activation rate."
    - name: "emergencies_with_cerf_count"
      expr: COUNT(CASE WHEN cerf_allocation_received = TRUE THEN 1 END)
      comment: "Number of emergencies receiving CERF allocations. Tracks UN emergency funding mobilisation success rate."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_wash_intervention`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "WASH (Water, Sanitation, and Hygiene) intervention KPIs tracking coverage, expenditure efficiency, and SPHERE standard compliance. WASH is a core humanitarian sector with mandatory SPHERE standards (20L/person/day water, latrine ratios). Sourced from field data systems (KoboToolbox, DHIS2) and financial systems (SAP VISION, eTools). Supports OCHA WASH cluster reporting and donor accountability under IPSAS/ASC 958."
  source: "`vibe_ngo_v1`.`field`.`wash_intervention`"
  dimensions:
    - name: "intervention_type"
      expr: intervention_type
      comment: "Type of WASH intervention (e.g. Water Supply, Sanitation, Hygiene Promotion, Latrine Construction). Primary sector classification."
    - name: "intervention_status"
      expr: intervention_status
      comment: "Current status of the WASH intervention (e.g. Planned, Active, Completed, Suspended). Operational pipeline dimension."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month of intervention start date. Enables trend analysis of WASH programme pipeline."
    - name: "hygiene_promotion_conducted"
      expr: hygiene_promotion_conducted
      comment: "Whether hygiene promotion activities were conducted alongside the WASH intervention. Best-practice integration indicator."
    - name: "ocha_wash_cluster_code"
      expr: ocha_wash_cluster_code
      comment: "OCHA WASH cluster code for inter-agency coordination and 3W (Who Does What Where) reporting."
  measures:
    - name: "total_wash_interventions"
      expr: COUNT(1)
      comment: "Total number of WASH interventions. Baseline portfolio volume metric."
    - name: "total_actual_expenditure_usd"
      expr: SUM(CAST(actual_expenditure_usd AS DOUBLE))
      comment: "Total actual expenditure on WASH interventions in USD. Core financial KPI for budget burn and donor accountability."
    - name: "total_budget_allocated_usd"
      expr: SUM(CAST(budget_allocated_usd AS DOUBLE))
      comment: "Total budget allocated to WASH interventions. Denominator for budget utilisation rate."
    - name: "budget_utilisation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_expenditure_usd AS DOUBLE)) / NULLIF(SUM(CAST(budget_allocated_usd AS DOUBLE)), 0), 2)
      comment: "Percentage of WASH budget actually spent. Efficiency KPI for programme managers and WASH cluster leads."
    - name: "avg_sphere_water_quantity_lpd"
      expr: ROUND(AVG(CAST(sphere_water_quantity_lpd AS DOUBLE)), 2)
      comment: "Average water quantity provided per person per day (litres). SPHERE standard requires minimum 20L/person/day; below threshold triggers immediate corrective action."
    - name: "avg_sphere_latrine_coverage_ratio"
      expr: ROUND(AVG(CAST(sphere_latrine_coverage_ratio AS DOUBLE)), 4)
      comment: "Average latrine coverage ratio (persons per latrine). SPHERE standard requires maximum 20 persons per latrine; above threshold indicates sanitation gap."
    - name: "interventions_with_hygiene_promotion_count"
      expr: COUNT(CASE WHEN hygiene_promotion_conducted = TRUE THEN 1 END)
      comment: "Number of WASH interventions that included hygiene promotion. Best-practice integration rate; hygiene promotion multiplies health impact of WASH infrastructure."
    - name: "hygiene_promotion_integration_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hygiene_promotion_conducted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of WASH interventions with hygiene promotion. Programme quality KPI aligned with WASH cluster best practices."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field deployment KPIs tracking staff deployment efficiency, cost, and operational readiness. Supports workforce planning, duty-of-care compliance, and programme delivery capacity. Sourced from HR systems (SAP HCM, Workday) and field operations platforms (eTools). PII note: staff deployment data carries pii_staff classification; apply role-based access control for non-HR users."
  source: "`vibe_ngo_v1`.`field`.`field_deployment`"
  dimensions:
    - name: "deployment_type"
      expr: deployment_type
      comment: "Type of deployment (e.g. Emergency Response, Programme Support, Assessment, Training). Enables portfolio analysis by deployment purpose."
    - name: "deployment_status"
      expr: deployment_status
      comment: "Current status of the deployment (e.g. Planned, Active, Completed, Cancelled). Operational pipeline dimension."
    - name: "response_type"
      expr: response_type
      comment: "Response type (e.g. Emergency, Development, Transition). Aligns deployments with programme phase."
    - name: "security_clearance_level"
      expr: security_clearance_level
      comment: "Security clearance level required for the deployment. Risk management and duty-of-care dimension."
    - name: "transportation_mode"
      expr: transportation_mode
      comment: "Mode of transportation for the deployment (e.g. Air, Road, Boat). Cost driver and logistics planning dimension."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month of deployment start date. Enables trend analysis of deployment pipeline and seasonal patterns."
    - name: "medical_clearance_required"
      expr: medical_clearance_required
      comment: "Whether medical clearance is required for the deployment. Duty-of-care compliance dimension."
    - name: "gis_track_enabled"
      expr: gis_track_enabled
      comment: "Whether GIS tracking is enabled for the deployment. Safety monitoring capability dimension."
  measures:
    - name: "total_deployments"
      expr: COUNT(1)
      comment: "Total number of field deployments. Baseline operational capacity metric."
    - name: "total_deployment_cost_estimate_usd"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of field deployments in USD. Financial planning KPI for workforce and operations budgets."
    - name: "avg_deployment_cost_estimate_usd"
      expr: ROUND(AVG(CAST(cost_estimate AS DOUBLE)), 2)
      comment: "Average estimated cost per deployment. Benchmarks deployment efficiency and informs budget planning."
    - name: "active_deployments_count"
      expr: COUNT(CASE WHEN deployment_status = 'Active' THEN 1 END)
      comment: "Number of currently active field deployments. Real-time operational capacity KPI for field leadership."
    - name: "deployments_with_gis_tracking_count"
      expr: COUNT(CASE WHEN gis_track_enabled = TRUE THEN 1 END)
      comment: "Number of deployments with GIS tracking enabled. Safety monitoring coverage KPI; low rates indicate duty-of-care gaps."
    - name: "gis_tracking_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gis_track_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deployments with GIS tracking enabled. Duty-of-care compliance KPI; donors and insurers increasingly require minimum tracking coverage."
    - name: "deployments_requiring_medical_clearance_count"
      expr: COUNT(CASE WHEN medical_clearance_required = TRUE THEN 1 END)
      comment: "Number of deployments requiring medical clearance. Duty-of-care compliance volume metric for HR and security teams."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_sitrep`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Situation Report (SitRep) KPIs tracking reporting compliance, humanitarian response progress, and funding gaps. SitReps are mandatory reporting instruments for OCHA, donors (USAID, ECHO, FCDO), and cluster coordination. Supports HRP progress monitoring and IATI publication requirements. Sourced from field reporting systems and eTools. Aligned with IPSAS programme reporting standards."
  source: "`vibe_ngo_v1`.`field`.`sitrep`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Current status of the SitRep (e.g. Draft, Submitted, Approved, Published). Reporting pipeline dimension."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of SitRep reporting (e.g. Weekly, Bi-Weekly, Monthly). Compliance monitoring dimension."
    - name: "reporting_period_start_month"
      expr: DATE_TRUNC('MONTH', reporting_period_start_date)
      comment: "Month of reporting period start. Enables trend analysis of reporting cadence and coverage."
    - name: "donor_submission_required"
      expr: donor_submission_required
      comment: "Whether the SitRep must be submitted to donors. Donor accountability compliance dimension."
    - name: "ocha_submission_required"
      expr: ocha_submission_required
      comment: "Whether the SitRep must be submitted to OCHA. UN inter-agency reporting compliance dimension."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the SitRep (e.g. National, Sub-National). Coverage analysis dimension."
    - name: "admin_level_1_name"
      expr: admin_level_1_name
      comment: "First administrative level covered by the SitRep. Geographic disaggregation for response coverage analysis."
  measures:
    - name: "total_sitreps"
      expr: COUNT(1)
      comment: "Total number of SitReps produced. Baseline reporting volume metric."
    - name: "total_funding_gap_usd"
      expr: SUM(CAST(funding_gap_usd AS DOUBLE))
      comment: "Total funding gap reported across SitReps in USD. Critical resource mobilisation KPI for leadership and donor engagement."
    - name: "avg_funding_gap_usd"
      expr: ROUND(AVG(CAST(funding_gap_usd AS DOUBLE)), 2)
      comment: "Average funding gap per SitRep. Benchmarks resource shortfall severity across response contexts."
    - name: "avg_hrp_progress_pct"
      expr: ROUND(AVG(CAST(hrp_progress_percentage AS DOUBLE)), 2)
      comment: "Average HRP (Humanitarian Response Plan) progress percentage. Primary inter-agency accountability KPI for OCHA and cluster leads."
    - name: "submitted_sitreps_count"
      expr: COUNT(CASE WHEN report_status = 'Submitted' OR report_status = 'Approved' OR report_status = 'Published' THEN 1 END)
      comment: "Number of SitReps that have been submitted, approved, or published. Reporting compliance volume metric."
    - name: "donor_submission_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN donor_submission_required = TRUE AND report_status IN ('Submitted', 'Approved', 'Published') THEN 1 END) / NULLIF(COUNT(CASE WHEN donor_submission_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of donor-required SitReps that have been submitted. Donor compliance KPI; non-submission risks grant suspension."
    - name: "ocha_submission_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ocha_submission_required = TRUE AND report_status IN ('Submitted', 'Approved', 'Published') THEN 1 END) / NULLIF(COUNT(CASE WHEN ocha_submission_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of OCHA-required SitReps that have been submitted. UN inter-agency reporting compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_access_constraint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Humanitarian access constraint KPIs tracking operational impediments, negotiation requirements, and beneficiary reach impact. Access constraints are a primary driver of programme delivery failure in conflict and fragile contexts. Sourced from field security systems, INSO, and OCHA access monitoring platforms. Critical for donor reporting on operational context and programme adaptation decisions."
  source: "`vibe_ngo_v1`.`field`.`access_constraint`"
  dimensions:
    - name: "constraint_type"
      expr: constraint_type
      comment: "Type of access constraint (e.g. Armed Actor, Administrative, Physical, Weather). Primary classification for root cause analysis."
    - name: "constraint_status"
      expr: constraint_status
      comment: "Current status of the constraint (e.g. Active, Resolved, Escalated). Operational pipeline dimension."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the access constraint. Drives escalation and programme adaptation decisions."
    - name: "escalation_status"
      expr: escalation_status
      comment: "Escalation status of the constraint. Tracks whether constraints have been escalated to senior management or inter-agency forums."
    - name: "negotiation_required"
      expr: negotiation_required
      comment: "Whether access negotiation is required. Indicates complexity and resource requirements for constraint resolution."
    - name: "alternative_route_available"
      expr: alternative_route_available
      comment: "Whether an alternative route or access modality is available. Operational resilience dimension."
    - name: "constraint_start_month"
      expr: DATE_TRUNC('MONTH', constraint_start_date)
      comment: "Month of constraint start date. Enables trend analysis of access deterioration patterns."
    - name: "donor_notification_required"
      expr: donor_notification_required
      comment: "Whether donor notification is required for this constraint. Compliance and transparency dimension."
    - name: "sitrep_included"
      expr: sitrep_included
      comment: "Whether the constraint is included in a SitRep. Reporting coverage dimension."
  measures:
    - name: "total_access_constraints"
      expr: COUNT(1)
      comment: "Total number of active and historical access constraints. Baseline operational risk volume metric."
    - name: "active_constraints_count"
      expr: COUNT(CASE WHEN constraint_status = 'Active' THEN 1 END)
      comment: "Number of currently active access constraints. Real-time operational risk KPI for field leadership and programme planning."
    - name: "constraints_requiring_negotiation_count"
      expr: COUNT(CASE WHEN negotiation_required = TRUE THEN 1 END)
      comment: "Number of constraints requiring access negotiation. Resource planning KPI for humanitarian access teams."
    - name: "negotiation_requirement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN negotiation_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of access constraints requiring negotiation. Complexity indicator for access environment assessment."
    - name: "constraints_with_alternative_route_count"
      expr: COUNT(CASE WHEN alternative_route_available = TRUE THEN 1 END)
      comment: "Number of constraints where an alternative route is available. Operational resilience KPI."
    - name: "alternative_route_availability_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN alternative_route_available = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of access constraints with an available alternative route. Measures operational adaptability in constrained environments."
    - name: "escalated_constraints_count"
      expr: COUNT(CASE WHEN escalation_status IS NOT NULL AND escalation_status != '' THEN 1 END)
      comment: "Number of constraints that have been escalated. Severity and management attention KPI."
    - name: "donor_notification_required_count"
      expr: COUNT(CASE WHEN donor_notification_required = TRUE THEN 1 END)
      comment: "Number of constraints requiring donor notification. Compliance obligation volume metric for grants management teams."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_mobile_health_outreach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mobile health outreach KPIs tracking service coverage, beneficiary reach by demographic, and health service integration. Mobile health is a primary delivery modality in hard-to-reach areas. Sourced from DHIS2, KoboToolbox, and health cluster reporting systems. Supports health cluster 3W reporting, OCHA SitRep contributions, and donor accountability. PII note: registrant_id linkage and GPS coordinates carry pii_beneficiary_protected classification."
  source: "`vibe_ngo_v1`.`field`.`mobile_health_outreach`"
  dimensions:
    - name: "session_status"
      expr: session_status
      comment: "Status of the mobile health outreach session (e.g. Planned, Completed, Cancelled). Operational pipeline dimension."
    - name: "session_date_month"
      expr: DATE_TRUNC('MONTH', session_date)
      comment: "Month of outreach session date. Enables trend analysis of health service delivery pipeline."
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "First administrative level of the outreach session. Geographic coverage analysis dimension."
    - name: "admin_level_2"
      expr: admin_level_2
      comment: "Second administrative level of the outreach session. Granular geographic coverage analysis."
    - name: "service_immunization_provided"
      expr: service_immunization_provided
      comment: "Whether immunization services were provided. Health cluster reporting dimension."
    - name: "service_muac_screening_provided"
      expr: service_muac_screening_provided
      comment: "Whether MUAC (Mid-Upper Arm Circumference) malnutrition screening was provided. Nutrition cluster reporting dimension."
    - name: "service_anc_provided"
      expr: service_anc_provided
      comment: "Whether Antenatal Care (ANC) services were provided. Maternal health coverage dimension."
    - name: "service_gbv_referral_provided"
      expr: service_gbv_referral_provided
      comment: "Whether GBV (Gender-Based Violence) referral services were provided. Protection mainstreaming dimension."
    - name: "service_pss_provided"
      expr: service_pss_provided
      comment: "Whether Psychosocial Support (PSS) services were provided. Mental health and protection dimension."
    - name: "sphere_compliant"
      expr: sphere_compliant
      comment: "Whether the outreach session met SPHERE humanitarian standards. Quality compliance dimension."
    - name: "health_cluster_reported"
      expr: health_cluster_reported
      comment: "Whether the session was reported to the health cluster. Inter-agency coordination compliance dimension."
  measures:
    - name: "total_outreach_sessions"
      expr: COUNT(1)
      comment: "Total number of mobile health outreach sessions. Baseline service delivery volume metric."
    - name: "sessions_with_immunization_count"
      expr: COUNT(CASE WHEN service_immunization_provided = TRUE THEN 1 END)
      comment: "Number of sessions providing immunization services. Health cluster KPI for vaccine coverage tracking."
    - name: "sessions_with_muac_screening_count"
      expr: COUNT(CASE WHEN service_muac_screening_provided = TRUE THEN 1 END)
      comment: "Number of sessions providing MUAC malnutrition screening. Nutrition cluster KPI for acute malnutrition surveillance."
    - name: "sessions_with_gbv_referral_count"
      expr: COUNT(CASE WHEN service_gbv_referral_provided = TRUE THEN 1 END)
      comment: "Number of sessions providing GBV referral services. Protection mainstreaming KPI; low rates indicate integration gaps."
    - name: "gbv_referral_integration_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN service_gbv_referral_provided = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outreach sessions with GBV referral services. Protection mainstreaming quality KPI for health and protection cluster coordination."
    - name: "sphere_compliant_sessions_count"
      expr: COUNT(CASE WHEN sphere_compliant = TRUE THEN 1 END)
      comment: "Number of outreach sessions meeting SPHERE standards. Quality compliance KPI for health cluster and donor reporting."
    - name: "sphere_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sphere_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outreach sessions meeting SPHERE standards. Primary quality KPI; below threshold triggers programme quality review."
    - name: "health_cluster_reporting_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN health_cluster_reported = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outreach sessions reported to the health cluster. Inter-agency coordination compliance KPI for 3W reporting."
    - name: "multi_service_sessions_count"
      expr: COUNT(CASE WHEN (CASE WHEN service_immunization_provided = TRUE THEN 1 ELSE 0 END + CASE WHEN service_muac_screening_provided = TRUE THEN 1 ELSE 0 END + CASE WHEN service_anc_provided = TRUE THEN 1 ELSE 0 END + CASE WHEN service_gbv_referral_provided = TRUE THEN 1 ELSE 0 END + CASE WHEN service_pss_provided = TRUE THEN 1 ELSE 0 END) >= 2 THEN 1 END)
      comment: "Number of outreach sessions providing 2 or more integrated health services. Integration quality KPI; multi-service sessions maximise cost-effectiveness and beneficiary impact."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_cluster_coordination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Humanitarian cluster coordination KPIs tracking NGO participation, 3W reporting compliance, and inter-agency coordination commitments. Cluster coordination is the primary inter-agency coordination mechanism under the IASC Cluster Approach. Sourced from OCHA coordination platforms and internal coordination tracking systems. Supports HPC (Humanitarian Programme Cycle) reporting and donor visibility requirements."
  source: "`vibe_ngo_v1`.`field`.`cluster_coordination`"
  dimensions:
    - name: "cluster_name"
      expr: cluster_name
      comment: "Name of the humanitarian cluster (e.g. Food Security, WASH, Health, Protection). Primary sector classification."
    - name: "cluster_activation_status"
      expr: cluster_activation_status
      comment: "Activation status of the cluster (e.g. Active, Standby, Deactivated). Operational engagement dimension."
    - name: "ngo_participation_status"
      expr: ngo_participation_status
      comment: "NGO participation status in the cluster (e.g. Active Member, Observer, Co-Lead). Engagement level dimension."
    - name: "three_w_reporting_obligation_flag"
      expr: three_w_reporting_obligation_flag
      comment: "Whether the NGO has a 3W (Who Does What Where) reporting obligation for this cluster. Compliance dimension."
    - name: "three_w_submission_compliance_status"
      expr: three_w_submission_compliance_status
      comment: "Compliance status of 3W submissions (e.g. Compliant, Overdue, Partial). Reporting accountability dimension."
    - name: "sitrep_contribution_flag"
      expr: sitrep_contribution_flag
      comment: "Whether the NGO contributes to cluster SitReps. Reporting engagement dimension."
    - name: "information_sharing_agreement_signed_flag"
      expr: information_sharing_agreement_signed_flag
      comment: "Whether an information sharing agreement is signed with the cluster. Data governance compliance dimension."
    - name: "cluster_activation_date_month"
      expr: DATE_TRUNC('MONTH', cluster_activation_date)
      comment: "Month of cluster activation. Enables trend analysis of cluster engagement timeline."
  measures:
    - name: "total_cluster_engagements"
      expr: COUNT(1)
      comment: "Total number of cluster coordination engagements. Baseline inter-agency coordination portfolio metric."
    - name: "total_hpc_commitment_amount"
      expr: SUM(CAST(hpc_commitment_amount AS DOUBLE))
      comment: "Total HPC (Humanitarian Programme Cycle) financial commitment amount. Core inter-agency accountability KPI for cluster leads and OCHA."
    - name: "avg_hpc_commitment_amount"
      expr: ROUND(AVG(CAST(hpc_commitment_amount AS DOUBLE)), 2)
      comment: "Average HPC commitment amount per cluster engagement. Benchmarks financial commitment level across clusters."
    - name: "active_cluster_participations_count"
      expr: COUNT(CASE WHEN ngo_participation_status = 'Active Member' OR ngo_participation_status = 'Co-Lead' THEN 1 END)
      comment: "Number of clusters where the NGO is an active member or co-lead. Coordination engagement breadth KPI."
    - name: "three_w_compliant_clusters_count"
      expr: COUNT(CASE WHEN three_w_submission_compliance_status = 'Compliant' THEN 1 END)
      comment: "Number of clusters with compliant 3W submissions. Inter-agency reporting compliance KPI; non-compliance risks cluster exclusion."
    - name: "three_w_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN three_w_submission_compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(CASE WHEN three_w_reporting_obligation_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of obligated clusters with compliant 3W submissions. OCHA coordination compliance KPI; below 80% triggers coordination review."
    - name: "clusters_with_sitrep_contribution_count"
      expr: COUNT(CASE WHEN sitrep_contribution_flag = TRUE THEN 1 END)
      comment: "Number of clusters where the NGO contributes to SitReps. Reporting engagement and visibility KPI."
    - name: "information_sharing_agreement_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN information_sharing_agreement_signed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cluster engagements with a signed information sharing agreement. Data governance compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_distribution_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field distribution line KPIs tracking commodity delivery accuracy, variance, and financial value. Distribution lines are the atomic unit of humanitarian commodity delivery, linking supply chain to beneficiary outcomes. Sourced from supply chain management systems (ICON, Helios) and field data collection (KoboToolbox). Supports IPSAS-aligned in-kind contribution reporting and donor commodity accountability."
  source: "`vibe_ngo_v1`.`field`.`field_distribution_line`"
  dimensions:
    - name: "distribution_status"
      expr: distribution_status
      comment: "Status of the distribution line (e.g. Planned, Distributed, Partially Distributed, Cancelled). Delivery pipeline dimension."
    - name: "item_category"
      expr: item_category
      comment: "Category of item distributed (e.g. Food, NFI, Medicine, WASH). Sector-level analysis dimension."
    - name: "distribution_method"
      expr: distribution_method
      comment: "Method of distribution (e.g. Direct, Partner, Mobile). Efficiency benchmarking dimension."
    - name: "cluster_sector"
      expr: cluster_sector
      comment: "Humanitarian cluster/sector for the distribution line. Inter-agency reporting dimension."
    - name: "quality_check_status"
      expr: quality_check_status
      comment: "Status of quality check for the distributed items (e.g. Passed, Failed, Pending). Quality assurance dimension."
    - name: "iati_transaction_type"
      expr: iati_transaction_type
      comment: "IATI transaction type for the distribution line. IATI publication and donor transparency dimension."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment tag for the distribution line. Supports SDG progress reporting."
    - name: "quality_check_date_month"
      expr: DATE_TRUNC('MONTH', quality_check_date)
      comment: "Month of quality check date. Enables trend analysis of quality assurance pipeline."
  measures:
    - name: "total_distribution_lines"
      expr: COUNT(1)
      comment: "Total number of distribution lines. Baseline delivery volume metric."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity across all distribution lines. Supply planning baseline metric."
    - name: "total_actual_quantity_distributed"
      expr: SUM(CAST(actual_quantity_distributed AS DOUBLE))
      comment: "Total actual quantity distributed. Core delivery performance metric for supply chain and programme teams."
    - name: "total_distribution_value_usd"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total financial value of distributions in USD. Core financial accountability KPI for donor reporting and IPSAS in-kind contribution recognition."
    - name: "delivery_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_quantity_distributed AS DOUBLE)) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of planned quantity actually distributed. Primary supply chain performance KPI; below 80% triggers supply chain review."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total variance between planned and actual distribution quantities. Supply chain accuracy KPI; large variances indicate pipeline or logistics failures."
    - name: "avg_unit_value_usd"
      expr: ROUND(AVG(CAST(unit_value AS DOUBLE)), 2)
      comment: "Average unit value of distributed items in USD. Cost benchmarking KPI for procurement and supply chain efficiency."
    - name: "lines_with_quality_check_passed_count"
      expr: COUNT(CASE WHEN quality_check_status = 'Passed' THEN 1 END)
      comment: "Number of distribution lines passing quality checks. Quality assurance compliance KPI."
    - name: "quality_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_check_status = 'Passed' THEN 1 END) / NULLIF(COUNT(CASE WHEN quality_check_status IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of quality-checked distribution lines passing. Commodity quality KPI; below threshold triggers supplier review and beneficiary safety assessment."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`field_project_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project site metrics tracking operational infrastructure, accessibility, and site readiness for program delivery"
  source: "`vibe_ngo_v1`.`field`.`project_site`"
  dimensions:
    - name: "site_type"
      expr: site_type
      comment: "Type of project site (office, warehouse, health facility, distribution point, camp)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of site (active, inactive, under construction, decommissioned)"
    - name: "security_level"
      expr: security_level
      comment: "Security risk level at site location (low, medium, high, critical)"
    - name: "accessibility_rating"
      expr: accessibility_rating
      comment: "Accessibility rating for site (easy, moderate, difficult, very difficult)"
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "First-level administrative division of site"
    - name: "admin_level_2"
      expr: admin_level_2
      comment: "Second-level administrative division of site"
    - name: "cluster_affiliation"
      expr: cluster_affiliation
      comment: "Humanitarian cluster affiliation of site"
    - name: "electricity_available"
      expr: electricity_available
      comment: "Whether electricity is available at site"
    - name: "water_source_available"
      expr: water_source_available
      comment: "Whether water source is available at site"
    - name: "internet_connectivity"
      expr: internet_connectivity
      comment: "Type of internet connectivity at site (none, mobile, satellite, fiber)"
    - name: "facility_ownership"
      expr: facility_ownership
      comment: "Ownership type of facility (owned, rented, government-provided, partner)"
    - name: "establishment_year"
      expr: YEAR(establishment_date)
      comment: "Year site was established"
  measures:
    - name: "total_project_sites"
      expr: COUNT(1)
      comment: "Total number of project sites"
    - name: "active_sites"
      expr: SUM(CASE WHEN operational_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of currently active project sites"
    - name: "site_activation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN operational_status = 'active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sites that are operationally active (infrastructure utilization)"
    - name: "total_site_area"
      expr: SUM(CAST(site_area_sqm AS DOUBLE))
      comment: "Total site area in square meters across all sites"
    - name: "avg_site_area"
      expr: AVG(CAST(site_area_sqm AS DOUBLE))
      comment: "Average site area in square meters"
    - name: "sites_with_electricity"
      expr: SUM(CASE WHEN electricity_available = TRUE THEN 1 ELSE 0 END)
      comment: "Number of sites with electricity available"
    - name: "electricity_coverage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN electricity_available = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sites with electricity (infrastructure readiness indicator)"
    - name: "sites_with_water"
      expr: SUM(CASE WHEN water_source_available = TRUE THEN 1 ELSE 0 END)
      comment: "Number of sites with water source available"
    - name: "water_coverage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN water_source_available = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sites with water source (infrastructure readiness indicator)"
    - name: "sites_with_internet"
      expr: SUM(CASE WHEN internet_connectivity IS NOT NULL AND internet_connectivity != 'none' THEN 1 ELSE 0 END)
      comment: "Number of sites with internet connectivity"
    - name: "internet_coverage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN internet_connectivity IS NOT NULL AND internet_connectivity != 'none' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sites with internet connectivity (digital readiness indicator)"
    - name: "high_security_risk_sites"
      expr: SUM(CASE WHEN security_level IN ('high', 'critical') THEN 1 ELSE 0 END)
      comment: "Number of sites in high or critical security risk areas"
    - name: "high_security_risk_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN security_level IN ('high', 'critical') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sites in high-risk security areas (operational risk exposure)"
    - name: "avg_population_catchment"
      expr: AVG(CAST(population_catchment AS BIGINT))
      comment: "Average population catchment area served by sites (coverage reach indicator)"
    - name: "unique_admin_level_1_coverage"
      expr: COUNT(DISTINCT admin_level_1)
      comment: "Number of unique first-level administrative divisions covered (geographic reach)"
    - name: "unique_admin_level_2_coverage"
      expr: COUNT(DISTINCT admin_level_2)
      comment: "Number of unique second-level administrative divisions covered (geographic reach)"
$$;