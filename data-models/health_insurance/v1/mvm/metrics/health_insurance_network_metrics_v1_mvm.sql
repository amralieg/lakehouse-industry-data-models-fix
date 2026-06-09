-- Metric views for domain: network | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 21:18:32

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`network_adequacy_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network adequacy assessment KPIs tracking compliance with access standards, time/distance requirements, and provider availability across service areas and specialties"
  source: "`health_insurance_ecm`.`network`.`adequacy_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of adequacy assessment performed (initial, annual, corrective action, etc.)"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year the adequacy assessment was conducted"
    - name: "assessment_quarter"
      expr: CONCAT('Q', QUARTER(assessment_date))
      comment: "Quarter the adequacy assessment was conducted"
    - name: "compliance_outcome"
      expr: compliance_outcome
      comment: "Overall compliance outcome (compliant, non-compliant, conditional, etc.)"
    - name: "specialty_type"
      expr: specialty_type
      comment: "Provider specialty being assessed (PCP, cardiology, behavioral health, etc.)"
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility assessed (hospital, clinic, urgent care, etc.)"
    - name: "appointment_type_requested"
      expr: appointment_type_requested
      comment: "Type of appointment assessed (routine, urgent, preventive, specialist)"
    - name: "gap_identified_flag"
      expr: gap_identified_flag
      comment: "Whether a network adequacy gap was identified in this assessment"
    - name: "gap_severity"
      expr: gap_severity
      comment: "Severity level of identified gap (critical, high, medium, low)"
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation efforts (not started, in progress, completed, overdue)"
    - name: "submission_status"
      expr: submission_status
      comment: "Regulatory submission status (draft, submitted, approved, rejected)"
    - name: "survey_method"
      expr: survey_method
      comment: "Method used to conduct assessment (secret shopper, provider survey, claims analysis)"
    - name: "telehealth_offered_flag"
      expr: telehealth_offered_flag
      comment: "Whether telehealth services are offered as part of network access"
    - name: "accepting_new_patients_flag"
      expr: accepting_new_patients_flag
      comment: "Whether providers in assessment are accepting new patients"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of network adequacy assessments conducted"
    - name: "avg_time_distance_compliance_pct"
      expr: AVG(CAST(time_distance_compliance_percentage AS DOUBLE))
      comment: "Average percentage of members meeting time/distance access standards"
    - name: "avg_member_to_provider_ratio"
      expr: AVG(CAST(member_to_provider_ratio AS DOUBLE))
      comment: "Average ratio of members to available providers in assessed networks"
    - name: "compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_outcome = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments resulting in compliant outcome - key regulatory metric"
    - name: "gap_identification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gap_identified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments identifying network adequacy gaps requiring remediation"
    - name: "critical_gap_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gap_severity = 'Critical' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments identifying critical severity gaps - executive escalation trigger"
    - name: "remediation_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN remediation_status = 'Completed' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN gap_identified_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of identified gaps with completed remediation - operational effectiveness metric"
    - name: "telehealth_availability_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN telehealth_offered_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments where telehealth access is available - strategic access expansion metric"
    - name: "new_patient_acceptance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN accepting_new_patients_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessed providers accepting new patients - member access quality indicator"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`network_adequacy_gap`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network adequacy gap tracking and remediation KPIs measuring identified deficiencies, affected members, and resolution effectiveness"
  source: "`health_insurance_ecm`.`network`.`adequacy_gap`"
  dimensions:
    - name: "gap_type"
      expr: gap_type
      comment: "Type of adequacy gap (provider shortage, time/distance, specialty access, etc.)"
    - name: "gap_severity"
      expr: gap_severity
      comment: "Severity classification of the gap (critical, high, medium, low)"
    - name: "gap_status"
      expr: gap_status
      comment: "Current status of the gap (open, in remediation, resolved, exception granted)"
    - name: "identified_year"
      expr: YEAR(identified_date)
      comment: "Year the gap was identified"
    - name: "identified_quarter"
      expr: CONCAT('Q', QUARTER(identified_date))
      comment: "Quarter the gap was identified"
    - name: "specialty_name"
      expr: specialty_name
      comment: "Provider specialty where gap exists"
    - name: "geographic_area_type"
      expr: geographic_area_type
      comment: "Type of geographic area affected (urban, suburban, rural, frontier)"
    - name: "lob"
      expr: lob
      comment: "Line of business affected by the gap (Medicare, Medicaid, Commercial, etc.)"
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year in which the gap exists"
    - name: "exception_granted_flag"
      expr: exception_granted_flag
      comment: "Whether a regulatory exception was granted for this gap"
    - name: "exception_requested_flag"
      expr: exception_requested_flag
      comment: "Whether a regulatory exception has been requested"
    - name: "regulatory_filing_required_flag"
      expr: regulatory_filing_required_flag
      comment: "Whether this gap requires regulatory filing or disclosure"
    - name: "remediation_owner"
      expr: remediation_owner
      comment: "Team or individual responsible for gap remediation"
    - name: "standard_type"
      expr: standard_type
      comment: "Type of adequacy standard violated (time/distance, provider ratio, appointment wait time)"
  measures:
    - name: "total_gaps"
      expr: COUNT(1)
      comment: "Total number of network adequacy gaps identified"
    - name: "total_affected_members"
      expr: SUM(CAST(affected_member_count AS BIGINT))
      comment: "Total number of members affected by network adequacy gaps - key impact metric"
    - name: "avg_affected_members_per_gap"
      expr: AVG(CAST(affected_member_count AS BIGINT))
      comment: "Average number of members affected per gap - severity indicator"
    - name: "critical_gap_count"
      expr: SUM(CASE WHEN gap_severity = 'Critical' THEN 1 ELSE 0 END)
      comment: "Count of critical severity gaps requiring immediate executive attention"
    - name: "open_gap_count"
      expr: SUM(CASE WHEN gap_status = 'Open' THEN 1 ELSE 0 END)
      comment: "Count of gaps currently open and requiring remediation"
    - name: "resolved_gap_count"
      expr: SUM(CASE WHEN gap_status = 'Resolved' THEN 1 ELSE 0 END)
      comment: "Count of gaps successfully resolved"
    - name: "gap_resolution_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gap_status = 'Resolved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of identified gaps that have been resolved - operational effectiveness KPI"
    - name: "exception_request_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN exception_requested_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of gaps for which regulatory exceptions were requested"
    - name: "exception_approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN exception_granted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN exception_requested_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of exception requests that were approved - regulatory relationship indicator"
    - name: "regulatory_filing_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_filing_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of gaps requiring regulatory disclosure - compliance risk metric"
    - name: "avg_days_to_resolution"
      expr: AVG(DATEDIFF(actual_resolution_date, identified_date))
      comment: "Average number of days from gap identification to resolution - remediation efficiency metric"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`network_provider`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider network participation and capacity KPIs tracking panel status, patient acceptance, quality tiers, and value-based care engagement"
  source: "`health_insurance_ecm`.`network`.`network_provider`"
  dimensions:
    - name: "participation_status"
      expr: participation_status
      comment: "Current network participation status (active, inactive, suspended, terminated)"
    - name: "network_participation_type"
      expr: network_participation_type
      comment: "Type of network participation (exclusive, non-exclusive, preferred, etc.)"
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Provider credentialing status (credentialed, pending, expired, denied)"
    - name: "panel_status"
      expr: panel_status
      comment: "Provider panel status (open, closed, limited)"
    - name: "accepting_new_patients_flag"
      expr: accepting_new_patients_flag
      comment: "Whether provider is accepting new patients"
    - name: "pcp_flag"
      expr: pcp_flag
      comment: "Whether provider serves as primary care physician"
    - name: "specialist_flag"
      expr: specialist_flag
      comment: "Whether provider is a specialist"
    - name: "quality_tier_designation"
      expr: quality_tier_designation
      comment: "Quality tier assignment (tier 1, tier 2, tier 3, untiered)"
    - name: "telehealth_available_flag"
      expr: telehealth_available_flag
      comment: "Whether provider offers telehealth services"
    - name: "vbc_participant_flag"
      expr: vbc_participant_flag
      comment: "Whether provider participates in value-based care arrangements"
    - name: "aco_participant_flag"
      expr: aco_participant_flag
      comment: "Whether provider participates in accountable care organization"
    - name: "risk_sharing_arrangement_flag"
      expr: risk_sharing_arrangement_flag
      comment: "Whether provider has risk-sharing financial arrangement"
    - name: "directory_listing_flag"
      expr: directory_listing_flag
      comment: "Whether provider is listed in member directory"
    - name: "accessibility_ada_compliant_flag"
      expr: accessibility_ada_compliant_flag
      comment: "Whether provider location is ADA compliant"
    - name: "after_hours_availability_flag"
      expr: after_hours_availability_flag
      comment: "Whether provider offers after-hours availability"
    - name: "weekend_availability_flag"
      expr: weekend_availability_flag
      comment: "Whether provider offers weekend availability"
    - name: "termination_reason_code"
      expr: termination_reason_code
      comment: "Reason code for provider termination if applicable"
    - name: "network_adequacy_category"
      expr: network_adequacy_category
      comment: "Provider category for network adequacy calculations"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year provider became effective in network"
  measures:
    - name: "total_network_providers"
      expr: COUNT(1)
      comment: "Total number of providers in network - fundamental network size metric"
    - name: "active_provider_count"
      expr: SUM(CASE WHEN participation_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of active participating providers - operational capacity indicator"
    - name: "pcp_count"
      expr: SUM(CASE WHEN pcp_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of primary care physicians - critical access metric for regulatory compliance"
    - name: "specialist_count"
      expr: SUM(CASE WHEN specialist_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of specialist providers - specialty access adequacy metric"
    - name: "accepting_new_patients_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN accepting_new_patients_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers accepting new patients - member access quality KPI"
    - name: "open_panel_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN panel_status = 'Open' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers with open panels - network capacity utilization metric"
    - name: "telehealth_availability_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN telehealth_available_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers offering telehealth - strategic digital access metric"
    - name: "vbc_participation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN vbc_participant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers in value-based care arrangements - strategic transformation KPI"
    - name: "aco_participation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN aco_participant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers in ACO arrangements - care coordination capability metric"
    - name: "risk_sharing_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN risk_sharing_arrangement_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers with risk-sharing contracts - financial alignment metric"
    - name: "quality_tier_1_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN quality_tier_designation = 'Tier 1' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers in highest quality tier - network quality indicator"
    - name: "ada_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN accessibility_ada_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ADA compliant provider locations - accessibility compliance metric"
    - name: "after_hours_availability_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN after_hours_availability_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers offering after-hours access - extended access capability metric"
    - name: "credentialing_current_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN credentialing_status = 'Credentialed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers with current credentialing - compliance and quality assurance metric"
    - name: "avg_panel_size"
      expr: AVG(CAST(current_panel_size AS BIGINT))
      comment: "Average current panel size across providers - capacity utilization indicator"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`network_provider_network`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider network portfolio KPIs tracking network size, adequacy status, member enrollment, and strategic network characteristics"
  source: "`health_insurance_ecm`.`network`.`provider_network`"
  dimensions:
    - name: "network_status"
      expr: network_status
      comment: "Current operational status of the network (active, inactive, pending, terminated)"
    - name: "network_type"
      expr: network_type
      comment: "Type of provider network (HMO, PPO, EPO, POS, etc.)"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business served by network (Medicare, Medicaid, Commercial, Exchange)"
    - name: "service_area_type"
      expr: service_area_type
      comment: "Geographic service area classification (statewide, regional, county, multi-state)"
    - name: "network_adequacy_status"
      expr: network_adequacy_status
      comment: "Current network adequacy compliance status (compliant, deficient, conditional, under review)"
    - name: "tier_classification"
      expr: tier_classification
      comment: "Network tier classification (single tier, multi-tier, narrow, broad)"
    - name: "pcp_required_flag"
      expr: pcp_required_flag
      comment: "Whether PCP selection is required for this network"
    - name: "referral_required_flag"
      expr: referral_required_flag
      comment: "Whether referrals are required for specialist access"
    - name: "out_of_network_coverage_flag"
      expr: out_of_network_coverage_flag
      comment: "Whether out-of-network coverage is available"
    - name: "aco_participation_flag"
      expr: aco_participation_flag
      comment: "Whether network includes ACO participation"
    - name: "vbc_arrangement_flag"
      expr: vbc_arrangement_flag
      comment: "Whether network includes value-based care arrangements"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the network became effective"
    - name: "adequacy_review_year"
      expr: YEAR(last_adequacy_review_date)
      comment: "Year of most recent adequacy review"
  measures:
    - name: "total_networks"
      expr: COUNT(1)
      comment: "Total number of provider networks in portfolio"
    - name: "active_network_count"
      expr: SUM(CASE WHEN network_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of active operational networks - portfolio size metric"
    - name: "total_member_enrollment"
      expr: SUM(CAST(member_enrollment_count AS BIGINT))
      comment: "Total members enrolled across all networks - market reach KPI"
    - name: "avg_member_enrollment_per_network"
      expr: AVG(CAST(member_enrollment_count AS BIGINT))
      comment: "Average member enrollment per network - network scale indicator"
    - name: "total_provider_count"
      expr: SUM(CAST(provider_count AS BIGINT))
      comment: "Total providers across all networks - aggregate network capacity"
    - name: "avg_provider_count_per_network"
      expr: AVG(CAST(provider_count AS BIGINT))
      comment: "Average provider count per network - network breadth metric"
    - name: "total_pcp_count"
      expr: SUM(CAST(pcp_count AS BIGINT))
      comment: "Total primary care physicians across networks - primary care capacity metric"
    - name: "total_specialist_count"
      expr: SUM(CAST(specialist_count AS BIGINT))
      comment: "Total specialist physicians across networks - specialty care capacity metric"
    - name: "total_facility_count"
      expr: SUM(CAST(facility_count AS BIGINT))
      comment: "Total facilities across all networks - facility access capacity"
    - name: "adequacy_compliant_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN network_adequacy_status = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of networks meeting adequacy standards - regulatory compliance KPI"
    - name: "vbc_network_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN vbc_arrangement_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of networks with value-based care arrangements - strategic transformation metric"
    - name: "aco_network_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN aco_participation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of networks with ACO participation - care coordination strategy metric"
    - name: "avg_star_rating"
      expr: AVG(CAST(star_rating AS DOUBLE))
      comment: "Average star rating across networks - quality performance indicator for Medicare Advantage"
    - name: "pcp_to_member_ratio"
      expr: ROUND(CAST(SUM(CAST(pcp_count AS BIGINT)) AS DOUBLE) / NULLIF(CAST(SUM(CAST(member_enrollment_count AS BIGINT)) AS DOUBLE), 0), 4)
      comment: "Ratio of PCPs to enrolled members - primary care access adequacy metric"
    - name: "specialist_to_member_ratio"
      expr: ROUND(CAST(SUM(CAST(specialist_count AS BIGINT)) AS DOUBLE) / NULLIF(CAST(SUM(CAST(member_enrollment_count AS BIGINT)) AS DOUBLE), 0), 4)
      comment: "Ratio of specialists to enrolled members - specialty care access adequacy metric"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`network_vbc_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Value-based care arrangement performance KPIs tracking attributed members, shared savings/loss rates, quality thresholds, and financial outcomes"
  source: "`health_insurance_ecm`.`network`.`vbc_arrangement`"
  dimensions:
    - name: "arrangement_status"
      expr: arrangement_status
      comment: "Current status of VBC arrangement (active, pending, terminated, suspended)"
    - name: "arrangement_type"
      expr: arrangement_type
      comment: "Type of value-based care arrangement (shared savings, shared risk, capitation, bundled payment)"
    - name: "risk_model"
      expr: risk_model
      comment: "Risk model used for arrangement (upside only, two-sided risk, full capitation)"
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year for VBC arrangement"
    - name: "reconciliation_frequency"
      expr: reconciliation_frequency
      comment: "Frequency of financial reconciliation (monthly, quarterly, annual)"
    - name: "quality_measure_set"
      expr: quality_measure_set
      comment: "Quality measure set used for performance evaluation (HEDIS, CMS Stars, custom)"
    - name: "cms_reporting_required_flag"
      expr: cms_reporting_required_flag
      comment: "Whether CMS reporting is required for this arrangement"
    - name: "care_coordination_required_flag"
      expr: care_coordination_required_flag
      comment: "Whether care coordination is required component"
    - name: "data_sharing_agreement_flag"
      expr: data_sharing_agreement_flag
      comment: "Whether data sharing agreement is in place"
    - name: "health_it_certification_required_flag"
      expr: health_it_certification_required_flag
      comment: "Whether health IT certification is required"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the VBC arrangement became effective"
  measures:
    - name: "total_vbc_arrangements"
      expr: COUNT(1)
      comment: "Total number of value-based care arrangements - VBC portfolio size"
    - name: "active_arrangement_count"
      expr: SUM(CASE WHEN arrangement_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of active VBC arrangements - operational VBC scale"
    - name: "total_attributed_members"
      expr: SUM(CAST(attributed_member_count AS BIGINT))
      comment: "Total members attributed to VBC arrangements - VBC member coverage metric"
    - name: "avg_attributed_members_per_arrangement"
      expr: AVG(CAST(attributed_member_count AS BIGINT))
      comment: "Average attributed members per arrangement - arrangement scale indicator"
    - name: "total_participating_providers"
      expr: SUM(CAST(participating_provider_count AS BIGINT))
      comment: "Total providers participating in VBC arrangements - VBC provider engagement"
    - name: "total_pcp_in_vbc"
      expr: SUM(CAST(primary_care_physician_count AS BIGINT))
      comment: "Total PCPs in VBC arrangements - primary care VBC penetration"
    - name: "total_specialists_in_vbc"
      expr: SUM(CAST(specialist_physician_count AS BIGINT))
      comment: "Total specialists in VBC arrangements - specialty care VBC penetration"
    - name: "avg_shared_savings_rate"
      expr: AVG(CAST(shared_savings_rate AS DOUBLE))
      comment: "Average shared savings rate across arrangements - upside incentive strength"
    - name: "avg_shared_loss_rate"
      expr: AVG(CAST(shared_loss_rate AS DOUBLE))
      comment: "Average shared loss rate across arrangements - downside risk exposure"
    - name: "avg_minimum_savings_rate"
      expr: AVG(CAST(minimum_savings_rate AS DOUBLE))
      comment: "Average minimum savings rate threshold - performance hurdle metric"
    - name: "avg_quality_performance_threshold"
      expr: AVG(CAST(quality_performance_threshold AS DOUBLE))
      comment: "Average quality performance threshold - quality gate metric"
    - name: "avg_benchmark_amount"
      expr: AVG(CAST(benchmark_amount AS DOUBLE))
      comment: "Average benchmark amount per arrangement - financial baseline metric"
    - name: "total_benchmark_amount"
      expr: SUM(CAST(benchmark_amount AS DOUBLE))
      comment: "Total benchmark amount across all arrangements - aggregate VBC financial exposure"
    - name: "avg_performance_guarantee"
      expr: AVG(CAST(performance_guarantee_amount AS DOUBLE))
      comment: "Average performance guarantee amount - provider financial commitment metric"
    - name: "avg_stop_loss_limit"
      expr: AVG(CAST(stop_loss_limit AS DOUBLE))
      comment: "Average stop loss limit - risk protection threshold"
    - name: "two_sided_risk_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN risk_model = 'Two-Sided Risk' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of arrangements with two-sided risk - risk maturity indicator"
    - name: "cms_reporting_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cms_reporting_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of arrangements requiring CMS reporting - regulatory oversight metric"
    - name: "data_sharing_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN data_sharing_agreement_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of arrangements with data sharing agreements - collaboration maturity metric"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`network_service_area`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network service area coverage and adequacy KPIs tracking geographic footprint, population served, regulatory approvals, and adequacy compliance by region"
  source: "`health_insurance_ecm`.`network`.`network_service_area`"
  dimensions:
    - name: "network_service_area_status"
      expr: network_service_area_status
      comment: "Current status of service area (active, pending approval, inactive, terminated)"
    - name: "service_area_type"
      expr: service_area_type
      comment: "Type of service area (county, ZIP, MSA, custom boundary)"
    - name: "state_code"
      expr: state_code
      comment: "State code for service area"
    - name: "county_name"
      expr: county_name
      comment: "County name for service area"
    - name: "msa_name"
      expr: msa_name
      comment: "Metropolitan Statistical Area name"
    - name: "urban_rural_designation"
      expr: urban_rural_designation
      comment: "Urban/rural classification (urban, suburban, rural, frontier)"
    - name: "network_adequacy_status"
      expr: network_adequacy_status
      comment: "Network adequacy compliance status for this service area"
    - name: "medicare_advantage_approved_flag"
      expr: medicare_advantage_approved_flag
      comment: "Whether service area is approved for Medicare Advantage"
    - name: "medicaid_approved_flag"
      expr: medicaid_approved_flag
      comment: "Whether service area is approved for Medicaid"
    - name: "commercial_approved_flag"
      expr: commercial_approved_flag
      comment: "Whether service area is approved for commercial products"
    - name: "qhp_approved_flag"
      expr: qhp_approved_flag
      comment: "Whether service area is approved for Qualified Health Plans (Exchange)"
    - name: "out_of_area_coverage_allowed_flag"
      expr: out_of_area_coverage_allowed_flag
      comment: "Whether out-of-area coverage is permitted"
    - name: "member_residency_required_flag"
      expr: member_residency_required_flag
      comment: "Whether member residency in service area is required"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the service area became effective"
  measures:
    - name: "total_service_areas"
      expr: COUNT(1)
      comment: "Total number of network service areas - geographic footprint size"
    - name: "active_service_area_count"
      expr: SUM(CASE WHEN network_service_area_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of active service areas - operational geographic coverage"
    - name: "total_population_served"
      expr: SUM(CAST(population_count AS BIGINT))
      comment: "Total population in all service areas - market addressability metric"
    - name: "avg_population_per_service_area"
      expr: AVG(CAST(population_count AS BIGINT))
      comment: "Average population per service area - service area scale indicator"
    - name: "adequacy_compliant_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN network_adequacy_status = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service areas meeting adequacy standards - geographic compliance KPI"
    - name: "medicare_advantage_coverage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN medicare_advantage_approved_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service areas approved for Medicare Advantage - MA market penetration"
    - name: "medicaid_coverage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN medicaid_approved_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service areas approved for Medicaid - Medicaid market penetration"
    - name: "commercial_coverage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN commercial_approved_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service areas approved for commercial products - commercial market penetration"
    - name: "qhp_coverage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN qhp_approved_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service areas approved for Exchange QHPs - Exchange market penetration"
    - name: "rural_service_area_count"
      expr: SUM(CASE WHEN urban_rural_designation IN ('Rural', 'Frontier') THEN 1 ELSE 0 END)
      comment: "Count of rural/frontier service areas - rural access coverage metric"
    - name: "rural_coverage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN urban_rural_designation IN ('Rural', 'Frontier') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service areas in rural/frontier areas - rural market focus indicator"
    - name: "out_of_area_flexibility_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN out_of_area_coverage_allowed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service areas allowing out-of-area coverage - network flexibility metric"
    - name: "unique_states_served"
      expr: COUNT(DISTINCT state_code)
      comment: "Number of unique states with service areas - multi-state footprint indicator"
    - name: "unique_counties_served"
      expr: COUNT(DISTINCT county_fips_code)
      comment: "Number of unique counties with service areas - county-level coverage breadth"
$$;