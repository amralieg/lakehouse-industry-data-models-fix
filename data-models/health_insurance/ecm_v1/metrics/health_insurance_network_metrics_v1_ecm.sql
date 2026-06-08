-- Metric views for domain: network | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 18:36:19

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`network_provider_network`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core network-level KPIs measuring network composition, adequacy status, accreditation health, and value-based care participation across provider networks."
  source: "`health_insurance_ecm`.`network`.`provider_network`"
  dimensions:
    - name: "network_name"
      expr: network_name
      comment: "Name of the provider network for grouping and identification."
    - name: "network_type"
      expr: network_type
      comment: "Type of network (e.g., HMO, PPO, EPO) for segmentation."
    - name: "network_status"
      expr: network_status
      comment: "Current operational status of the network (active, terminated, etc.)."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business the network serves (Commercial, Medicare Advantage, Medicaid, etc.)."
    - name: "network_adequacy_status"
      expr: network_adequacy_status
      comment: "Current adequacy compliance status of the network."
    - name: "ncqa_accreditation_status"
      expr: ncqa_accreditation_status
      comment: "NCQA accreditation status for quality benchmarking."
    - name: "tier_classification"
      expr: tier_classification
      comment: "Tier classification of the network for cost-sharing differentiation."
    - name: "service_area_type"
      expr: service_area_type
      comment: "Geographic service area type (state, regional, national)."
    - name: "aco_participation_flag"
      expr: aco_participation_flag
      comment: "Whether the network participates in ACO/value-based arrangements."
    - name: "vbc_arrangement_flag"
      expr: vbc_arrangement_flag
      comment: "Whether the network has value-based care arrangements."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the network became effective for trend analysis."
  measures:
    - name: "total_networks"
      expr: COUNT(1)
      comment: "Total count of provider networks for portfolio sizing."
    - name: "average_star_rating"
      expr: AVG(CAST(star_rating AS DOUBLE))
      comment: "Average CMS star rating across networks, a key quality and regulatory performance indicator."
    - name: "networks_with_vbc"
      expr: COUNT(CASE WHEN vbc_arrangement_flag = true THEN 1 END)
      comment: "Count of networks with value-based care arrangements, tracking strategic shift toward VBC."
    - name: "networks_adequacy_compliant"
      expr: COUNT(CASE WHEN network_adequacy_status = 'Compliant' THEN 1 END)
      comment: "Count of networks meeting adequacy standards, critical for regulatory compliance."
    - name: "networks_ncqa_accredited"
      expr: COUNT(CASE WHEN ncqa_accreditation_status = 'Accredited' THEN 1 END)
      comment: "Count of NCQA-accredited networks, a quality differentiator for plan marketing."
    - name: "networks_with_aco_participation"
      expr: COUNT(CASE WHEN aco_participation_flag = true THEN 1 END)
      comment: "Count of networks participating in ACO models, measuring value-based care adoption."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`network_provider`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider participation and panel management KPIs measuring network composition, credentialing health, access availability, and provider readiness."
  source: "`health_insurance_ecm`.`network`.`network_provider`"
  dimensions:
    - name: "participation_status"
      expr: participation_status
      comment: "Current participation status of the provider in the network."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status for compliance and quality tracking."
    - name: "network_participation_type"
      expr: network_participation_type
      comment: "Type of network participation (contracted, employed, etc.)."
    - name: "network_adequacy_category"
      expr: network_adequacy_category
      comment: "Adequacy category assignment for regulatory reporting."
    - name: "panel_status"
      expr: panel_status
      comment: "Panel open/closed status affecting member access."
    - name: "quality_tier_designation"
      expr: quality_tier_designation
      comment: "Quality tier for tiered network benefit design."
    - name: "tier_assignment"
      expr: tier_assignment
      comment: "Cost tier assignment for member cost-sharing differentiation."
    - name: "accepting_new_patients_flag"
      expr: accepting_new_patients_flag
      comment: "Whether the provider is accepting new patients — key access metric."
    - name: "pcp_flag"
      expr: pcp_flag
      comment: "Whether the provider is a primary care physician."
    - name: "specialist_flag"
      expr: specialist_flag
      comment: "Whether the provider is a specialist."
    - name: "telehealth_available_flag"
      expr: telehealth_available_flag
      comment: "Whether the provider offers telehealth services."
    - name: "in_network_flag"
      expr: in_network_flag
      comment: "Whether the provider is currently in-network."
    - name: "vbc_participant_flag"
      expr: vbc_participant_flag
      comment: "Whether the provider participates in value-based care arrangements."
    - name: "geographic_service_area"
      expr: geographic_service_area
      comment: "Geographic service area for regional analysis."
    - name: "source_system"
      expr: source_system
      comment: "Source system of record for data lineage."
  measures:
    - name: "total_network_providers"
      expr: COUNT(1)
      comment: "Total count of provider-network participation records."
    - name: "providers_accepting_new_patients"
      expr: COUNT(CASE WHEN accepting_new_patients_flag = true THEN 1 END)
      comment: "Count of providers accepting new patients — critical member access indicator."
    - name: "pcp_count"
      expr: COUNT(CASE WHEN pcp_flag = true THEN 1 END)
      comment: "Count of primary care physicians, essential for adequacy and member assignment."
    - name: "specialist_count"
      expr: COUNT(CASE WHEN specialist_flag = true THEN 1 END)
      comment: "Count of specialists in the network for adequacy assessment."
    - name: "telehealth_enabled_providers"
      expr: COUNT(CASE WHEN telehealth_available_flag = true THEN 1 END)
      comment: "Count of providers offering telehealth, measuring digital access expansion."
    - name: "vbc_participating_providers"
      expr: COUNT(CASE WHEN vbc_participant_flag = true THEN 1 END)
      comment: "Count of providers in value-based care arrangements, tracking VBC adoption."
    - name: "aco_participating_providers"
      expr: COUNT(CASE WHEN aco_participant_flag = true THEN 1 END)
      comment: "Count of providers participating in ACO models."
    - name: "providers_in_network"
      expr: COUNT(CASE WHEN in_network_flag = true THEN 1 END)
      comment: "Count of currently in-network providers for network size monitoring."
    - name: "providers_ada_compliant"
      expr: COUNT(CASE WHEN accessibility_ada_compliant_flag = true THEN 1 END)
      comment: "Count of ADA-compliant provider locations for accessibility compliance."
    - name: "providers_with_after_hours"
      expr: COUNT(CASE WHEN after_hours_availability_flag = true THEN 1 END)
      comment: "Count of providers with after-hours availability, measuring access beyond business hours."
    - name: "distinct_provider_count"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct provider count to deduplicate providers across multiple network assignments."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`network_adequacy_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network adequacy assessment KPIs measuring compliance rates, gap identification, time-distance standards, and provider-to-member ratios for regulatory reporting."
  source: "`health_insurance_ecm`.`network`.`adequacy_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of adequacy assessment (initial, annual, triggered, etc.)."
    - name: "compliance_outcome"
      expr: compliance_outcome
      comment: "Compliance outcome of the assessment (pass, fail, conditional)."
    - name: "specialty_type"
      expr: specialty_type
      comment: "Provider specialty type being assessed for adequacy."
    - name: "facility_type"
      expr: facility_type
      comment: "Facility type being assessed (hospital, clinic, etc.)."
    - name: "gap_severity"
      expr: gap_severity
      comment: "Severity of identified adequacy gaps."
    - name: "submission_status"
      expr: submission_status
      comment: "Regulatory submission status of the assessment."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation actions for identified gaps."
    - name: "survey_method"
      expr: survey_method
      comment: "Method used for the adequacy survey."
    - name: "gap_identified_flag"
      expr: gap_identified_flag
      comment: "Whether a gap was identified in this assessment."
    - name: "telehealth_offered_flag"
      expr: telehealth_offered_flag
      comment: "Whether telehealth was offered as an adequacy alternative."
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of assessment for trend analysis."
    - name: "regulatory_submission_type"
      expr: regulatory_submission_type
      comment: "Type of regulatory submission (CMS, state DOI, etc.)."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total count of adequacy assessments conducted."
    - name: "assessments_with_gaps"
      expr: COUNT(CASE WHEN gap_identified_flag = true THEN 1 END)
      comment: "Count of assessments where adequacy gaps were identified — key risk indicator."
    - name: "assessments_compliant"
      expr: COUNT(CASE WHEN compliance_outcome = 'Compliant' THEN 1 END)
      comment: "Count of assessments with compliant outcomes for regulatory reporting."
    - name: "avg_time_distance_compliance_pct"
      expr: AVG(CAST(time_distance_compliance_percentage AS DOUBLE))
      comment: "Average time-distance compliance percentage across assessments — core CMS adequacy metric."
    - name: "avg_member_to_provider_ratio"
      expr: AVG(CAST(member_to_provider_ratio AS DOUBLE))
      comment: "Average member-to-provider ratio, measuring network capacity and access."
    - name: "avg_time_distance_standard_miles"
      expr: AVG(CAST(time_distance_standard_miles AS DOUBLE))
      comment: "Average distance standard in miles for geographic access measurement."
    - name: "assessments_with_telehealth"
      expr: COUNT(CASE WHEN telehealth_offered_flag = true THEN 1 END)
      comment: "Count of assessments where telehealth was offered as an access alternative."
    - name: "assessments_pending_remediation"
      expr: COUNT(CASE WHEN remediation_status = 'Pending' THEN 1 END)
      comment: "Count of assessments with pending remediation actions requiring follow-up."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`network_adequacy_gap`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adequacy gap tracking KPIs measuring gap severity, resolution timelines, exception management, and member impact for network adequacy compliance."
  source: "`health_insurance_ecm`.`network`.`adequacy_gap`"
  dimensions:
    - name: "gap_type"
      expr: gap_type
      comment: "Type of adequacy gap (time, distance, provider count, etc.)."
    - name: "gap_severity"
      expr: gap_severity
      comment: "Severity classification of the gap (critical, major, minor)."
    - name: "gap_status"
      expr: gap_status
      comment: "Current status of the gap (open, closed, in remediation)."
    - name: "standard_type"
      expr: standard_type
      comment: "Adequacy standard type that was not met."
    - name: "specialty_name"
      expr: specialty_name
      comment: "Specialty where the gap exists."
    - name: "geographic_area_type"
      expr: geographic_area_type
      comment: "Type of geographic area affected (county, MSA, zip)."
    - name: "geographic_area_name"
      expr: geographic_area_name
      comment: "Name of the geographic area affected by the gap."
    - name: "lob"
      expr: lob
      comment: "Line of business affected by the gap."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for the gap assessment."
    - name: "exception_granted_flag"
      expr: exception_granted_flag
      comment: "Whether a regulatory exception was granted for this gap."
    - name: "regulatory_filing_required_flag"
      expr: regulatory_filing_required_flag
      comment: "Whether regulatory filing is required for this gap."
    - name: "remediation_action"
      expr: remediation_action
      comment: "Remediation action being taken to close the gap."
  measures:
    - name: "total_gaps"
      expr: COUNT(1)
      comment: "Total count of identified adequacy gaps across the network."
    - name: "open_gaps"
      expr: COUNT(CASE WHEN gap_status = 'Open' THEN 1 END)
      comment: "Count of currently open adequacy gaps requiring attention."
    - name: "critical_gaps"
      expr: COUNT(CASE WHEN gap_severity = 'Critical' THEN 1 END)
      comment: "Count of critical-severity gaps requiring immediate remediation."
    - name: "gaps_with_exceptions"
      expr: COUNT(CASE WHEN exception_granted_flag = true THEN 1 END)
      comment: "Count of gaps where regulatory exceptions were granted."
    - name: "gaps_requiring_filing"
      expr: COUNT(CASE WHEN regulatory_filing_required_flag = true THEN 1 END)
      comment: "Count of gaps requiring regulatory filing — compliance workload indicator."
    - name: "exception_requested_count"
      expr: COUNT(CASE WHEN exception_requested_flag = true THEN 1 END)
      comment: "Count of gaps where exceptions were requested from regulators."
    - name: "distinct_specialties_with_gaps"
      expr: COUNT(DISTINCT specialty_code)
      comment: "Number of distinct specialties with adequacy gaps — breadth of gap exposure."
    - name: "distinct_geographic_areas_with_gaps"
      expr: COUNT(DISTINCT geographic_area_code)
      comment: "Number of distinct geographic areas with gaps — geographic spread of access issues."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`network_access_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider access survey KPIs measuring appointment availability, access standard compliance, language services, and telehealth access for member experience and regulatory reporting."
  source: "`health_insurance_ecm`.`network`.`access_survey`"
  dimensions:
    - name: "survey_status"
      expr: survey_status
      comment: "Status of the access survey (completed, pending, etc.)."
    - name: "survey_method"
      expr: survey_method
      comment: "Method used for the survey (phone, online, in-person)."
    - name: "survey_cycle"
      expr: survey_cycle
      comment: "Survey cycle identifier for periodic tracking."
    - name: "compliance_outcome"
      expr: compliance_outcome
      comment: "Compliance outcome of the access survey."
    - name: "call_outcome"
      expr: call_outcome
      comment: "Outcome of the survey call attempt."
    - name: "appointment_type_requested"
      expr: appointment_type_requested
      comment: "Type of appointment requested (routine, urgent, preventive)."
    - name: "specialty_name"
      expr: specialty_name
      comment: "Provider specialty surveyed."
    - name: "data_source"
      expr: data_source
      comment: "Source of the survey data."
    - name: "accepting_new_patients_flag"
      expr: accepting_new_patients_flag
      comment: "Whether the provider reported accepting new patients."
    - name: "telehealth_offered_flag"
      expr: telehealth_offered_flag
      comment: "Whether telehealth was offered as an appointment option."
    - name: "survey_year"
      expr: YEAR(survey_date)
      comment: "Year of the survey for trend analysis."
  measures:
    - name: "total_surveys"
      expr: COUNT(1)
      comment: "Total count of access surveys conducted."
    - name: "surveys_standard_met"
      expr: COUNT(CASE WHEN access_standard_met_flag = true THEN 1 END)
      comment: "Count of surveys where access standards were met — core compliance metric."
    - name: "surveys_appointment_scheduled"
      expr: COUNT(CASE WHEN appointment_scheduled_flag = true THEN 1 END)
      comment: "Count of surveys where an appointment was successfully scheduled — access success rate."
    - name: "surveys_accepting_new_patients"
      expr: COUNT(CASE WHEN accepting_new_patients_flag = true THEN 1 END)
      comment: "Count of surveys confirming providers accept new patients."
    - name: "surveys_telehealth_offered"
      expr: COUNT(CASE WHEN telehealth_offered_flag = true THEN 1 END)
      comment: "Count of surveys where telehealth was offered as an option."
    - name: "surveys_language_services_available"
      expr: COUNT(CASE WHEN language_services_available_flag = true THEN 1 END)
      comment: "Count of surveys confirming language services availability — health equity indicator."
    - name: "surveys_after_hours_available"
      expr: COUNT(CASE WHEN after_hours_access_available_flag = true THEN 1 END)
      comment: "Count of surveys confirming after-hours access availability."
    - name: "surveys_accessibility_available"
      expr: COUNT(CASE WHEN accessibility_accommodation_available_flag = true THEN 1 END)
      comment: "Count of surveys confirming accessibility accommodations — ADA compliance indicator."
    - name: "surveys_cms_star_applicable"
      expr: COUNT(CASE WHEN cms_star_rating_applicable_flag = true THEN 1 END)
      comment: "Count of surveys applicable to CMS star rating calculations."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`network_termination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider termination KPIs measuring termination volume, types, member impact, continuity of care, and regulatory reporting requirements."
  source: "`health_insurance_ecm`.`network`.`termination`"
  dimensions:
    - name: "termination_type"
      expr: termination_type
      comment: "Type of termination (voluntary, involuntary, mutual)."
    - name: "termination_status"
      expr: termination_status
      comment: "Current status of the termination process."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the termination."
    - name: "for_cause_flag"
      expr: for_cause_flag
      comment: "Whether the termination was for cause (quality, fraud, etc.)."
    - name: "credentialing_related_flag"
      expr: credentialing_related_flag
      comment: "Whether the termination was related to credentialing issues."
    - name: "network_adequacy_impact_flag"
      expr: network_adequacy_impact_flag
      comment: "Whether the termination impacts network adequacy."
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Whether regulatory reporting is required for this termination."
    - name: "member_notification_required_flag"
      expr: member_notification_required_flag
      comment: "Whether member notification is required."
    - name: "appeals_filed_flag"
      expr: appeals_filed_flag
      comment: "Whether the provider filed an appeal against termination."
    - name: "replacement_provider_required_flag"
      expr: replacement_provider_required_flag
      comment: "Whether a replacement provider must be identified."
    - name: "termination_year"
      expr: YEAR(effective_date)
      comment: "Year of termination effective date for trend analysis."
  measures:
    - name: "total_terminations"
      expr: COUNT(1)
      comment: "Total count of provider terminations."
    - name: "for_cause_terminations"
      expr: COUNT(CASE WHEN for_cause_flag = true THEN 1 END)
      comment: "Count of for-cause terminations — quality and compliance risk indicator."
    - name: "terminations_impacting_adequacy"
      expr: COUNT(CASE WHEN network_adequacy_impact_flag = true THEN 1 END)
      comment: "Count of terminations impacting network adequacy — regulatory risk metric."
    - name: "terminations_requiring_regulatory_report"
      expr: COUNT(CASE WHEN regulatory_reporting_required_flag = true THEN 1 END)
      comment: "Count of terminations requiring regulatory reporting."
    - name: "terminations_with_appeals"
      expr: COUNT(CASE WHEN appeals_filed_flag = true THEN 1 END)
      comment: "Count of terminations where providers filed appeals."
    - name: "terminations_requiring_replacement"
      expr: COUNT(CASE WHEN replacement_provider_required_flag = true THEN 1 END)
      comment: "Count of terminations requiring replacement provider recruitment."
    - name: "credentialing_related_terminations"
      expr: COUNT(CASE WHEN credentialing_related_flag = true THEN 1 END)
      comment: "Count of terminations related to credentialing issues."
    - name: "distinct_terminated_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct count of terminated providers for network attrition analysis."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`network_vbc_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Value-based care arrangement KPIs measuring financial benchmarks, risk-sharing parameters, quality thresholds, and participation scale for VBC program management."
  source: "`health_insurance_ecm`.`network`.`vbc_arrangement`"
  dimensions:
    - name: "arrangement_type"
      expr: arrangement_type
      comment: "Type of VBC arrangement (shared savings, shared risk, capitation, bundled payment)."
    - name: "arrangement_status"
      expr: arrangement_status
      comment: "Current status of the VBC arrangement."
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year for the arrangement."
    - name: "risk_model"
      expr: risk_model
      comment: "Risk adjustment model used (HCC, ACG, etc.)."
    - name: "reconciliation_frequency"
      expr: reconciliation_frequency
      comment: "Frequency of financial reconciliation."
    - name: "quality_measure_set"
      expr: quality_measure_set
      comment: "Quality measure set used for performance evaluation."
    - name: "benchmark_methodology"
      expr: benchmark_methodology
      comment: "Methodology used to set financial benchmarks."
    - name: "attribution_methodology"
      expr: attribution_methodology
      comment: "Member attribution methodology."
    - name: "record_type"
      expr: record_type
      comment: "Record type classification."
    - name: "cms_reporting_required_flag"
      expr: cms_reporting_required_flag
      comment: "Whether CMS reporting is required for this arrangement."
  measures:
    - name: "total_vbc_arrangements"
      expr: COUNT(1)
      comment: "Total count of value-based care arrangements."
    - name: "total_benchmark_amount"
      expr: SUM(CAST(benchmark_amount AS DOUBLE))
      comment: "Total benchmark amount across VBC arrangements — financial exposure indicator."
    - name: "avg_benchmark_amount"
      expr: AVG(CAST(benchmark_amount AS DOUBLE))
      comment: "Average benchmark amount per arrangement for financial planning."
    - name: "avg_shared_savings_rate"
      expr: AVG(CAST(shared_savings_rate AS DOUBLE))
      comment: "Average shared savings rate across arrangements — incentive structure indicator."
    - name: "avg_shared_loss_rate"
      expr: AVG(CAST(shared_loss_rate AS DOUBLE))
      comment: "Average shared loss rate — downside risk exposure metric."
    - name: "avg_quality_performance_threshold"
      expr: AVG(CAST(quality_performance_threshold AS DOUBLE))
      comment: "Average quality performance threshold required for shared savings eligibility."
    - name: "total_performance_guarantee"
      expr: SUM(CAST(performance_guarantee_amount AS DOUBLE))
      comment: "Total performance guarantee amount — financial commitment at risk."
    - name: "total_stop_loss_limit"
      expr: SUM(CAST(stop_loss_limit AS DOUBLE))
      comment: "Total stop-loss limit across arrangements — maximum downside risk exposure."
    - name: "avg_minimum_savings_rate"
      expr: AVG(CAST(minimum_savings_rate AS DOUBLE))
      comment: "Average minimum savings rate threshold before shared savings are triggered."
    - name: "arrangements_requiring_cms_reporting"
      expr: COUNT(CASE WHEN cms_reporting_required_flag = true THEN 1 END)
      comment: "Count of arrangements requiring CMS reporting."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`network_aco_provider`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ACO provider participation KPIs measuring quality scores, cost efficiency, risk-sharing, and care coordination tiers for accountable care organization management."
  source: "`health_insurance_ecm`.`network`.`aco_provider`"
  dimensions:
    - name: "participation_status"
      expr: participation_status
      comment: "Current participation status in the ACO."
    - name: "participation_type"
      expr: participation_type
      comment: "Type of ACO participation."
    - name: "participation_role"
      expr: participation_role
      comment: "Role of the provider in the ACO (lead, participating, etc.)."
    - name: "care_coordination_tier"
      expr: care_coordination_tier
      comment: "Care coordination tier assignment."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status of the ACO provider."
    - name: "vbc_track"
      expr: vbc_track
      comment: "VBC track (e.g., MSSP Basic, Enhanced, REACH)."
    - name: "specialty_code"
      expr: specialty_code
      comment: "Provider specialty code."
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year for ACO measurement."
    - name: "primary_care_flag"
      expr: primary_care_flag
      comment: "Whether the provider is a primary care provider in the ACO."
    - name: "shared_savings_eligible_flag"
      expr: shared_savings_eligible_flag
      comment: "Whether the provider is eligible for shared savings."
    - name: "quality_reporting_flag"
      expr: quality_reporting_flag
      comment: "Whether the provider participates in quality reporting."
  measures:
    - name: "total_aco_providers"
      expr: COUNT(1)
      comment: "Total count of ACO provider participation records."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across ACO providers — key performance indicator for shared savings eligibility."
    - name: "avg_cost_efficiency_score"
      expr: AVG(CAST(cost_efficiency_score AS DOUBLE))
      comment: "Average cost efficiency score — measures provider cost management effectiveness."
    - name: "avg_risk_sharing_percentage"
      expr: AVG(CAST(risk_sharing_percentage AS DOUBLE))
      comment: "Average risk-sharing percentage across ACO providers."
    - name: "shared_savings_eligible_providers"
      expr: COUNT(CASE WHEN shared_savings_eligible_flag = true THEN 1 END)
      comment: "Count of providers eligible for shared savings distributions."
    - name: "primary_care_aco_providers"
      expr: COUNT(CASE WHEN primary_care_flag = true THEN 1 END)
      comment: "Count of primary care providers in ACO — foundation of attribution model."
    - name: "quality_reporting_providers"
      expr: COUNT(CASE WHEN quality_reporting_flag = true THEN 1 END)
      comment: "Count of providers participating in quality reporting."
    - name: "ehr_integrated_providers"
      expr: COUNT(CASE WHEN ehr_integration_flag = true THEN 1 END)
      comment: "Count of providers with EHR integration — data interoperability indicator."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`network_change_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network change event KPIs measuring provider roster changes, member impact, regulatory filing requirements, and continuity of care obligations."
  source: "`health_insurance_ecm`.`network`.`change_event`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of network change (addition, termination, tier change, etc.)."
    - name: "change_status"
      expr: change_status
      comment: "Current status of the change event."
    - name: "change_reason_code"
      expr: change_reason_code
      comment: "Reason code for the network change."
    - name: "specialty_type"
      expr: specialty_type
      comment: "Specialty type affected by the change."
    - name: "facility_type"
      expr: facility_type
      comment: "Facility type affected by the change."
    - name: "lob_applicability"
      expr: lob_applicability
      comment: "Line of business applicability of the change."
    - name: "termination_type"
      expr: termination_type
      comment: "Type of termination if applicable."
    - name: "network_adequacy_impact_flag"
      expr: network_adequacy_impact_flag
      comment: "Whether the change impacts network adequacy."
    - name: "member_notification_required_flag"
      expr: member_notification_required_flag
      comment: "Whether member notification is required."
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Whether regulatory reporting is required."
    - name: "vbc_arrangement_flag"
      expr: vbc_arrangement_flag
      comment: "Whether the change involves a VBC arrangement."
    - name: "change_effective_year"
      expr: YEAR(change_effective_date)
      comment: "Year of change effective date for trend analysis."
  measures:
    - name: "total_change_events"
      expr: COUNT(1)
      comment: "Total count of network change events."
    - name: "changes_impacting_adequacy"
      expr: COUNT(CASE WHEN network_adequacy_impact_flag = true THEN 1 END)
      comment: "Count of changes impacting network adequacy — regulatory risk indicator."
    - name: "changes_requiring_member_notification"
      expr: COUNT(CASE WHEN member_notification_required_flag = true THEN 1 END)
      comment: "Count of changes requiring member notification — operational workload indicator."
    - name: "changes_requiring_regulatory_reporting"
      expr: COUNT(CASE WHEN regulatory_reporting_required_flag = true THEN 1 END)
      comment: "Count of changes requiring regulatory reporting."
    - name: "changes_requiring_transition_plan"
      expr: COUNT(CASE WHEN member_transition_plan_required_flag = true THEN 1 END)
      comment: "Count of changes requiring member transition plans — continuity of care indicator."
    - name: "vbc_related_changes"
      expr: COUNT(CASE WHEN vbc_arrangement_flag = true THEN 1 END)
      comment: "Count of changes related to value-based care arrangements."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`network_directory_verification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider directory verification KPIs measuring data accuracy, verification completion rates, and CMS compliance for No Surprises Act and directory accuracy requirements."
  source: "`health_insurance_ecm`.`network`.`network_directory_verification`"
  dimensions:
    - name: "verification_status"
      expr: verification_status
      comment: "Status of the directory verification."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used for verification (phone, fax, portal, etc.)."
    - name: "verification_channel"
      expr: verification_channel
      comment: "Channel used for verification outreach."
    - name: "compliance_quarter"
      expr: compliance_quarter
      comment: "Compliance quarter for periodic reporting."
    - name: "compliance_year"
      expr: compliance_year
      comment: "Compliance year for annual reporting."
    - name: "cms_reportable"
      expr: cms_reportable
      comment: "Whether the verification is CMS-reportable."
    - name: "changes_identified"
      expr: changes_identified
      comment: "Whether changes were identified during verification."
    - name: "directory_updated"
      expr: directory_updated
      comment: "Whether the directory was updated after verification."
    - name: "accepting_new_patients_status"
      expr: accepting_new_patients_status
      comment: "Verified accepting new patients status."
  measures:
    - name: "total_verifications"
      expr: COUNT(1)
      comment: "Total count of directory verification records."
    - name: "avg_accuracy_score"
      expr: AVG(CAST(accuracy_score AS DOUBLE))
      comment: "Average directory accuracy score — key CMS compliance metric for No Surprises Act."
    - name: "verifications_with_changes"
      expr: COUNT(CASE WHEN changes_identified = true THEN 1 END)
      comment: "Count of verifications where data changes were identified — data quality indicator."
    - name: "verifications_directory_updated"
      expr: COUNT(CASE WHEN directory_updated = true THEN 1 END)
      comment: "Count of verifications resulting in directory updates."
    - name: "cms_reportable_verifications"
      expr: COUNT(CASE WHEN cms_reportable = true THEN 1 END)
      comment: "Count of CMS-reportable verifications for regulatory compliance tracking."
    - name: "address_verified_count"
      expr: COUNT(CASE WHEN address_verified = true THEN 1 END)
      comment: "Count of verifications where address was confirmed accurate."
    - name: "phone_verified_count"
      expr: COUNT(CASE WHEN phone_verified = true THEN 1 END)
      comment: "Count of verifications where phone number was confirmed accurate."
    - name: "npi_verified_count"
      expr: COUNT(CASE WHEN npi_verified = true THEN 1 END)
      comment: "Count of verifications where NPI was confirmed accurate."
    - name: "specialty_verified_count"
      expr: COUNT(CASE WHEN specialty_verified = true THEN 1 END)
      comment: "Count of verifications where specialty was confirmed accurate."
    - name: "avg_provider_response_time_hours"
      expr: AVG(CAST(provider_response_time_hours AS DOUBLE))
      comment: "Average provider response time in hours for verification outreach."
    - name: "distinct_providers_verified"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct count of providers verified for coverage analysis."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`network_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network adequacy filing KPIs measuring regulatory submission compliance, approval rates, deficiency tracking, and exception management for state and federal filings."
  source: "`health_insurance_ecm`.`network`.`filing`"
  dimensions:
    - name: "filing_type"
      expr: filing_type
      comment: "Type of regulatory filing (initial, renewal, amendment)."
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the filing."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body the filing is submitted to (CMS, state DOI, etc.)."
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Jurisdiction for the filing."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for the filing."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for the filing."
    - name: "adequacy_standard_met_flag"
      expr: adequacy_standard_met_flag
      comment: "Whether adequacy standards were met in the filing."
    - name: "deficiency_issued_flag"
      expr: deficiency_issued_flag
      comment: "Whether a deficiency was issued by the regulator."
    - name: "exception_approved_flag"
      expr: exception_approved_flag
      comment: "Whether an exception was approved."
    - name: "attestation_flag"
      expr: attestation_flag
      comment: "Whether attestation was provided with the filing."
  measures:
    - name: "total_filings"
      expr: COUNT(1)
      comment: "Total count of regulatory filings."
    - name: "filings_adequacy_met"
      expr: COUNT(CASE WHEN adequacy_standard_met_flag = true THEN 1 END)
      comment: "Count of filings where adequacy standards were met — compliance success rate."
    - name: "filings_with_deficiencies"
      expr: COUNT(CASE WHEN deficiency_issued_flag = true THEN 1 END)
      comment: "Count of filings with deficiencies issued — regulatory risk indicator."
    - name: "filings_with_exceptions_approved"
      expr: COUNT(CASE WHEN exception_approved_flag = true THEN 1 END)
      comment: "Count of filings with approved exceptions."
    - name: "filings_with_attestation"
      expr: COUNT(CASE WHEN attestation_flag = true THEN 1 END)
      comment: "Count of filings with attestation provided."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`network_recruitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider recruitment KPIs measuring recruitment pipeline, disposition outcomes, adequacy gap closure, and recruitment efficiency for network growth."
  source: "`health_insurance_ecm`.`network`.`network_recruitment`"
  dimensions:
    - name: "recruitment_status"
      expr: recruitment_status
      comment: "Current status of the recruitment effort."
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the recruitment (contracted, declined, pending)."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the recruitment effort."
    - name: "target_specialty"
      expr: target_specialty
      comment: "Target specialty for recruitment."
    - name: "adequacy_gap_type"
      expr: adequacy_gap_type
      comment: "Type of adequacy gap driving the recruitment."
    - name: "lob"
      expr: lob
      comment: "Line of business for the recruitment."
    - name: "outreach_method"
      expr: outreach_method
      comment: "Method of outreach to the target provider."
    - name: "provider_response"
      expr: provider_response
      comment: "Provider response to recruitment outreach."
    - name: "target_geographic_area"
      expr: target_geographic_area
      comment: "Target geographic area for recruitment."
    - name: "regulatory_filing_required_flag"
      expr: regulatory_filing_required_flag
      comment: "Whether regulatory filing is required for this recruitment."
  measures:
    - name: "total_recruitment_efforts"
      expr: COUNT(1)
      comment: "Total count of provider recruitment efforts."
    - name: "successful_recruitments"
      expr: COUNT(CASE WHEN disposition = 'Contracted' THEN 1 END)
      comment: "Count of successful recruitments resulting in contracts — recruitment effectiveness."
    - name: "declined_recruitments"
      expr: COUNT(CASE WHEN disposition = 'Declined' THEN 1 END)
      comment: "Count of declined recruitment efforts — market competitiveness indicator."
    - name: "total_estimated_claims_volume"
      expr: SUM(CAST(estimated_annual_claims_volume AS DOUBLE))
      comment: "Total estimated annual claims volume from recruitment targets — financial impact of recruitment."
    - name: "avg_estimated_claims_volume"
      expr: AVG(CAST(estimated_annual_claims_volume AS DOUBLE))
      comment: "Average estimated annual claims volume per recruitment target."
    - name: "high_priority_recruitments"
      expr: COUNT(CASE WHEN priority_level = 'High' THEN 1 END)
      comment: "Count of high-priority recruitment efforts for resource allocation."
    - name: "distinct_target_specialties"
      expr: COUNT(DISTINCT target_specialty)
      comment: "Number of distinct specialties being recruited — breadth of recruitment needs."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`network_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network adequacy exception KPIs measuring exception volume, approval rates, appeal outcomes, and regulatory compliance for adequacy standard waivers."
  source: "`health_insurance_ecm`.`network`.`exception`"
  dimensions:
    - name: "exception_type"
      expr: exception_type
      comment: "Type of adequacy exception requested."
    - name: "exception_status"
      expr: exception_status
      comment: "Current status of the exception."
    - name: "lob"
      expr: lob
      comment: "Line of business for the exception."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body granting the exception."
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Jurisdiction for the exception."
    - name: "specialty_name"
      expr: specialty_name
      comment: "Specialty for which the exception is requested."
    - name: "appeal_decision"
      expr: appeal_decision
      comment: "Decision on any appeal filed."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Whether an appeal was filed."
    - name: "member_notification_flag"
      expr: member_notification_flag
      comment: "Whether members were notified of the exception."
  measures:
    - name: "total_exceptions"
      expr: COUNT(1)
      comment: "Total count of network adequacy exceptions."
    - name: "approved_exceptions"
      expr: COUNT(CASE WHEN exception_status = 'Approved' THEN 1 END)
      comment: "Count of approved exceptions — regulatory flexibility indicator."
    - name: "denied_exceptions"
      expr: COUNT(CASE WHEN exception_status = 'Denied' THEN 1 END)
      comment: "Count of denied exceptions — areas requiring network investment."
    - name: "exceptions_with_appeals"
      expr: COUNT(CASE WHEN appeal_filed_flag = true THEN 1 END)
      comment: "Count of exceptions where appeals were filed."
    - name: "distinct_specialties_with_exceptions"
      expr: COUNT(DISTINCT specialty_code)
      comment: "Number of distinct specialties with exceptions — breadth of adequacy challenges."
$$;