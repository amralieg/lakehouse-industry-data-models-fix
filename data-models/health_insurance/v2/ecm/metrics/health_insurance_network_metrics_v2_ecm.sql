-- Metric views for domain: network | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 00:30:14

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_provider_network`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for provider network health, adequacy status, and composition. Used by network executives to monitor network breadth, adequacy compliance, and VBC participation across lines of business."
  source: "`vibe_health_insurance_v1`.`network`.`provider_network`"
  dimensions:
    - name: "network_status"
      expr: network_status
      comment: "Current operational status of the provider network (e.g., Active, Inactive, Pending)."
    - name: "network_type"
      expr: network_type
      comment: "Type of network (e.g., HMO, PPO, EPO, POS) used to segment adequacy and performance analysis."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business the network serves (e.g., Commercial, Medicare Advantage, Medicaid)."
    - name: "network_adequacy_status"
      expr: network_adequacy_status
      comment: "Current regulatory adequacy status of the network (e.g., Compliant, Deficient, Under Review)."
    - name: "ncqa_accreditation_status"
      expr: ncqa_accreditation_status
      comment: "NCQA accreditation status, used to track quality certification compliance."
    - name: "service_area_type"
      expr: service_area_type
      comment: "Geographic classification of the service area (e.g., Urban, Rural, Mixed)."
    - name: "tier_classification"
      expr: tier_classification
      comment: "Network tier classification used for cost-sharing and steerage analysis."
    - name: "vbc_arrangement_flag"
      expr: vbc_arrangement_flag
      comment: "Indicates whether the network participates in a value-based care arrangement."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the network became effective, used for trend analysis."
  measures:
    - name: "total_active_networks"
      expr: COUNT(CASE WHEN network_status = 'Active' THEN 1 END)
      comment: "Count of currently active provider networks. Executives use this to monitor network portfolio size and operational footprint."
    - name: "avg_star_rating"
      expr: AVG(CAST(star_rating AS DOUBLE))
      comment: "Average star rating across provider networks. Directly tied to CMS quality bonuses and member plan selection; a drop triggers immediate remediation."
    - name: "networks_with_adequacy_deficiency"
      expr: COUNT(CASE WHEN network_adequacy_status = 'Deficient' THEN 1 END)
      comment: "Number of networks with a regulatory adequacy deficiency. Regulatory non-compliance risk metric that drives immediate corrective action and filing obligations."
    - name: "adequacy_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN network_adequacy_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of networks meeting regulatory adequacy standards. Core compliance KPI reviewed at every regulatory steering meeting."
    - name: "vbc_network_participation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN vbc_arrangement_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of networks participating in value-based care arrangements. Strategic KPI for VBC transformation progress tracked by the CMO and CFO."
    - name: "ncqa_accredited_network_count"
      expr: COUNT(CASE WHEN ncqa_accreditation_status = 'Accredited' THEN 1 END)
      comment: "Number of NCQA-accredited networks. Accreditation is a market differentiator and regulatory requirement for certain plan types."
    - name: "avg_network_star_rating_by_lob"
      expr: AVG(CASE WHEN line_of_business IS NOT NULL THEN star_rating END)
      comment: "Average star rating segmented by line of business. Enables LOB-level quality benchmarking and targeted improvement investment."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_adequacy_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network adequacy assessment KPIs measuring compliance rates, gap identification, and remediation performance. Used by regulatory affairs and network operations to manage state and federal adequacy filings."
  source: "`vibe_health_insurance_v1`.`network`.`adequacy_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of adequacy assessment (e.g., Annual, Quarterly, Triggered) used to segment compliance analysis."
    - name: "compliance_outcome"
      expr: compliance_outcome
      comment: "Outcome of the adequacy assessment (e.g., Compliant, Non-Compliant, Conditional) for regulatory tracking."
    - name: "specialty_type"
      expr: specialty_type
      comment: "Provider specialty type assessed, enabling gap analysis by clinical specialty."
    - name: "facility_type"
      expr: facility_type
      comment: "Facility type assessed (e.g., Hospital, Urgent Care, SNF) for facility-level adequacy tracking."
    - name: "gap_severity"
      expr: gap_severity
      comment: "Severity of identified adequacy gap (e.g., Critical, Moderate, Minor) used to prioritize remediation."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Current status of remediation actions taken to address adequacy gaps."
    - name: "submission_status"
      expr: submission_status
      comment: "Status of the regulatory submission associated with this assessment."
    - name: "assessment_period_start"
      expr: DATE_TRUNC('month', assessment_period_start_date)
      comment: "Month the assessment period began, used for trend and cycle analysis."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of adequacy assessments conducted. Baseline volume metric for regulatory workload tracking."
    - name: "compliant_assessment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_outcome = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments resulting in a compliant outcome. Primary regulatory KPI reviewed at board and regulatory steering meetings."
    - name: "gap_identification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gap_identified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments that identified an adequacy gap. Drives network recruitment investment and regulatory filing decisions."
    - name: "avg_member_to_provider_ratio"
      expr: AVG(CAST(member_to_provider_ratio AS DOUBLE))
      comment: "Average member-to-provider ratio across assessments. A rising ratio signals access risk and triggers provider recruitment."
    - name: "avg_time_distance_compliance_pct"
      expr: AVG(CAST(time_distance_compliance_percentage AS DOUBLE))
      comment: "Average time-distance compliance percentage across assessments. Measures geographic access standard adherence for CMS and state filings."
    - name: "critical_gap_count"
      expr: COUNT(CASE WHEN gap_severity = 'Critical' THEN 1 END)
      comment: "Number of assessments with critical adequacy gaps. Critical gaps require immediate executive escalation and regulatory notification."
    - name: "remediation_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN remediation_status = 'Completed' THEN 1 END) / NULLIF(COUNT(CASE WHEN gap_identified_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of identified gaps with completed remediation. Measures operational effectiveness of the network gap closure process."
    - name: "avg_time_distance_standard_miles"
      expr: AVG(CAST(time_distance_standard_miles AS DOUBLE))
      comment: "Average time-distance standard in miles applied across assessments. Used to benchmark geographic access requirements by network and LOB."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_adequacy_gap`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs tracking open and resolved network adequacy gaps by specialty, geography, and severity. Used by network operations and regulatory affairs to prioritize recruitment and manage regulatory risk."
  source: "`vibe_health_insurance_v1`.`network`.`adequacy_gap`"
  dimensions:
    - name: "gap_type"
      expr: gap_type
      comment: "Type of adequacy gap (e.g., Time-Distance, Provider Count, Specialty) for targeted remediation planning."
    - name: "gap_severity"
      expr: gap_severity
      comment: "Severity classification of the gap (e.g., Critical, Moderate, Minor) used to prioritize executive action."
    - name: "gap_status"
      expr: gap_status
      comment: "Current status of the gap (e.g., Open, In Remediation, Closed) for operational tracking."
    - name: "specialty_name"
      expr: specialty_name
      comment: "Provider specialty with the identified gap, enabling specialty-level recruitment prioritization."
    - name: "geographic_area_type"
      expr: geographic_area_type
      comment: "Geographic classification of the gap area (e.g., Urban, Rural, Frontier) for access equity analysis."
    - name: "lob"
      expr: lob
      comment: "Line of business affected by the gap (e.g., Commercial, Medicare Advantage, Medicaid)."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year in which the gap was identified, used for year-over-year trend analysis."
    - name: "regulatory_filing_required_flag"
      expr: regulatory_filing_required_flag
      comment: "Indicates whether the gap requires a regulatory filing, used to prioritize compliance workload."
    - name: "identified_date_month"
      expr: DATE_TRUNC('month', identified_date)
      comment: "Month the gap was identified, used for trend and aging analysis."
  measures:
    - name: "total_open_gaps"
      expr: COUNT(CASE WHEN gap_status = 'Open' THEN 1 END)
      comment: "Total number of open adequacy gaps. Primary operational metric for network adequacy risk management."
    - name: "critical_open_gap_count"
      expr: COUNT(CASE WHEN gap_status = 'Open' AND gap_severity = 'Critical' THEN 1 END)
      comment: "Number of open critical adequacy gaps requiring immediate executive escalation and regulatory action."
    - name: "exception_grant_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_granted_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN exception_requested_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of exception requests that were granted. Measures regulatory flexibility and the effectiveness of exception justification strategies."
    - name: "regulatory_filing_required_gap_count"
      expr: COUNT(CASE WHEN regulatory_filing_required_flag = TRUE THEN 1 END)
      comment: "Number of gaps requiring regulatory filing. Drives compliance workload planning and filing deadline management."
    - name: "gap_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gap_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of all identified gaps that have been closed. Measures network operations effectiveness in resolving access deficiencies."
    - name: "distinct_specialty_gaps"
      expr: COUNT(DISTINCT specialty_code)
      comment: "Number of distinct specialties with identified adequacy gaps. Breadth of specialty gap exposure informs targeted recruitment strategy."
    - name: "distinct_geographic_areas_with_gaps"
      expr: COUNT(DISTINCT geographic_area_code)
      comment: "Number of distinct geographic areas with adequacy gaps. Geographic breadth of gaps informs service area expansion and recruitment investment."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_provider`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring provider participation quality, panel availability, credentialing status, and directory accuracy within networks. Used by network operations and credentialing teams to manage provider roster health."
  source: "`vibe_health_insurance_v1`.`network`.`network_provider`"
  dimensions:
    - name: "participation_status"
      expr: participation_status
      comment: "Current participation status of the provider in the network (e.g., Active, Terminated, Pending)."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status of the provider, used to ensure only credentialed providers are active in the network."
    - name: "network_participation_type"
      expr: network_participation_type
      comment: "Type of network participation (e.g., Par, Non-Par, Contracted) for contract and cost analysis."
    - name: "panel_status"
      expr: panel_status
      comment: "Panel open/closed status, used to monitor member access to primary care."
    - name: "pcp_flag"
      expr: pcp_flag
      comment: "Indicates whether the provider is a primary care physician, used for PCP-to-member ratio analysis."
    - name: "specialist_flag"
      expr: specialist_flag
      comment: "Indicates whether the provider is a specialist, used for specialty access analysis."
    - name: "telehealth_available_flag"
      expr: telehealth_available_flag
      comment: "Indicates telehealth availability, used to assess virtual access capacity."
    - name: "vbc_participant_flag"
      expr: vbc_participant_flag
      comment: "Indicates VBC program participation, used to track value-based care provider penetration."
    - name: "network_adequacy_category"
      expr: network_adequacy_category
      comment: "Adequacy category assigned to the provider (e.g., PCP, Specialist, Facility) for adequacy reporting."
    - name: "quality_tier_designation"
      expr: quality_tier_designation
      comment: "Quality tier assigned to the provider, used for member steerage and cost-sharing design."
  measures:
    - name: "total_active_providers"
      expr: COUNT(CASE WHEN participation_status = 'Active' THEN 1 END)
      comment: "Total number of active network providers. Baseline network size metric used in adequacy assessments and member-to-provider ratio calculations."
    - name: "pcp_active_count"
      expr: COUNT(CASE WHEN pcp_flag = TRUE AND participation_status = 'Active' THEN 1 END)
      comment: "Number of active PCPs in the network. Critical for PCP-to-member ratio adequacy compliance and member access to primary care."
    - name: "panel_open_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN accepting_new_patients_flag = TRUE AND participation_status = 'Active' THEN 1 END) / NULLIF(COUNT(CASE WHEN participation_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active providers accepting new patients. A declining rate signals member access risk and triggers network recruitment."
    - name: "credentialing_compliant_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN credentialing_status = 'Credentialed' AND participation_status = 'Active' THEN 1 END) / NULLIF(COUNT(CASE WHEN participation_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active providers with current credentialing. Non-credentialed active providers represent a compliance and liability risk."
    - name: "telehealth_provider_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN telehealth_available_flag = TRUE AND participation_status = 'Active' THEN 1 END) / NULLIF(COUNT(CASE WHEN participation_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active providers offering telehealth. Measures virtual access capacity, a key metric for CMS star ratings and member satisfaction."
    - name: "vbc_provider_penetration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN vbc_participant_flag = TRUE AND participation_status = 'Active' THEN 1 END) / NULLIF(COUNT(CASE WHEN participation_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active providers participating in VBC arrangements. Strategic KPI for VBC transformation progress tracked by the CMO."
    - name: "directory_verified_provider_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN directory_listing_flag = TRUE AND participation_status = 'Active' THEN 1 END) / NULLIF(COUNT(CASE WHEN participation_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active providers with verified directory listings. CMS requires quarterly directory verification; non-compliance triggers civil monetary penalties."
    - name: "recredentialing_overdue_count"
      expr: COUNT(CASE WHEN recredentialing_due_date < CURRENT_DATE() AND participation_status = 'Active' THEN 1 END)
      comment: "Number of active providers with overdue recredentialing. Overdue recredentialing is a compliance violation and accreditation risk."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_directory_verification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring provider directory accuracy, verification completion rates, and CMS compliance. Used by network operations and compliance teams to manage CMS quarterly directory accuracy requirements."
  source: "`vibe_health_insurance_v1`.`network`.`network_directory_verification`"
  dimensions:
    - name: "verification_status"
      expr: verification_status
      comment: "Current status of the directory verification (e.g., Verified, Failed, Pending) for compliance tracking."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used for verification (e.g., Phone, Mail, Online Portal) to analyze outreach effectiveness."
    - name: "compliance_quarter"
      expr: compliance_quarter
      comment: "CMS compliance quarter for the verification, used for quarterly reporting and trend analysis."
    - name: "compliance_year"
      expr: compliance_year
      comment: "Compliance year for the verification cycle, used for year-over-year accuracy trend analysis."
    - name: "cms_reportable"
      expr: cms_reportable
      comment: "Indicates whether the verification result is reportable to CMS, used to scope regulatory reporting workload."
    - name: "changes_identified"
      expr: changes_identified
      comment: "Indicates whether the verification identified changes to directory data, used to measure data staleness."
    - name: "verification_date_month"
      expr: DATE_TRUNC('month', verification_date)
      comment: "Month of verification, used for trend analysis of verification volume and accuracy."
  measures:
    - name: "total_verifications"
      expr: COUNT(1)
      comment: "Total number of directory verifications conducted. Baseline volume metric for CMS quarterly compliance reporting."
    - name: "verification_success_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of verifications resulting in a successful outcome. CMS requires high directory accuracy rates; failure triggers civil monetary penalties."
    - name: "avg_accuracy_score"
      expr: AVG(CAST(accuracy_score AS DOUBLE))
      comment: "Average directory accuracy score across verifications. CMS benchmarks directory accuracy; scores below threshold trigger corrective action plans."
    - name: "directory_change_detection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN changes_identified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of verifications that detected directory data changes. High rates indicate data staleness and drive investment in real-time data feeds."
    - name: "avg_provider_response_time_hours"
      expr: AVG(CAST(provider_response_time_hours AS DOUBLE))
      comment: "Average hours for providers to respond to verification outreach. Long response times increase verification cycle time and CMS compliance risk."
    - name: "npi_verified_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN npi_verified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of verifications with NPI confirmed. NPI accuracy is a CMS directory requirement; low rates trigger regulatory scrutiny."
    - name: "address_verified_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN address_verified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of verifications with address confirmed. Address accuracy is critical for member access and CMS directory compliance."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_vbc_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring value-based care arrangement performance, financial benchmarks, and quality thresholds. Used by the CFO, CMO, and VBC strategy team to manage shared savings, risk exposure, and quality performance."
  source: "`vibe_health_insurance_v1`.`network`.`vbc_arrangement`"
  dimensions:
    - name: "arrangement_type"
      expr: arrangement_type
      comment: "Type of VBC arrangement (e.g., Shared Savings, Capitation, Bundled Payment) for financial modeling."
    - name: "arrangement_status"
      expr: arrangement_status
      comment: "Current status of the arrangement (e.g., Active, Terminated, Pending) for portfolio management."
    - name: "risk_model"
      expr: risk_model
      comment: "Risk model applied (e.g., One-Sided, Two-Sided, Full Risk) for financial exposure analysis."
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year of the arrangement, used for year-over-year VBC performance benchmarking."
    - name: "reconciliation_frequency"
      expr: reconciliation_frequency
      comment: "Frequency of financial reconciliation (e.g., Annual, Semi-Annual, Quarterly) for cash flow planning."
    - name: "cms_reporting_required_flag"
      expr: cms_reporting_required_flag
      comment: "Indicates CMS reporting obligation, used to scope regulatory reporting workload."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the arrangement became effective, used for cohort and vintage analysis."
  measures:
    - name: "total_active_arrangements"
      expr: COUNT(CASE WHEN arrangement_status = 'Active' THEN 1 END)
      comment: "Total number of active VBC arrangements. Portfolio size metric used by the VBC strategy team to track program scale."
    - name: "avg_benchmark_amount"
      expr: AVG(CAST(benchmark_amount AS DOUBLE))
      comment: "Average financial benchmark amount across VBC arrangements. Benchmarks set the financial target; deviations drive renegotiation decisions."
    - name: "total_benchmark_amount"
      expr: SUM(CAST(benchmark_amount AS DOUBLE))
      comment: "Total financial benchmark amount across all active VBC arrangements. Represents total VBC financial exposure for CFO risk management."
    - name: "avg_shared_savings_rate"
      expr: AVG(CAST(shared_savings_rate AS DOUBLE))
      comment: "Average shared savings rate across arrangements. Determines the financial upside for providers; drives provider recruitment into VBC programs."
    - name: "avg_quality_performance_threshold"
      expr: AVG(CAST(quality_performance_threshold AS DOUBLE))
      comment: "Average quality performance threshold required for shared savings eligibility. Tracks the quality bar set across VBC contracts."
    - name: "avg_minimum_savings_rate"
      expr: AVG(CAST(minimum_savings_rate AS DOUBLE))
      comment: "Average minimum savings rate required before shared savings are triggered. Used to assess how achievable the savings threshold is across the portfolio."
    - name: "avg_stop_loss_limit"
      expr: AVG(CAST(stop_loss_limit AS DOUBLE))
      comment: "Average stop-loss limit across two-sided risk arrangements. Measures maximum financial exposure per arrangement for CFO risk management."
    - name: "avg_performance_guarantee_amount"
      expr: AVG(CAST(performance_guarantee_amount AS DOUBLE))
      comment: "Average performance guarantee amount across arrangements. Performance guarantees represent contractual financial commitments reviewed at board level."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_vbc_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring VBC program portfolio, quality thresholds, and financial parameters by line of business and program type. Used by the VBC strategy team and CMO to manage program design and performance targets."
  source: "`vibe_health_insurance_v1`.`network`.`vbc_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current status of the VBC program (e.g., Active, Inactive, Pending) for portfolio management."
    - name: "program_type"
      expr: program_type
      comment: "Type of VBC program (e.g., ACO, PCMH, Bundled Payment) for program-level performance analysis."
    - name: "program_category"
      expr: program_category
      comment: "Category of the VBC program (e.g., Commercial, Medicare, Medicaid) for LOB-level strategy."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business the program operates in, used for LOB-level VBC penetration analysis."
    - name: "risk_model"
      expr: risk_model
      comment: "Risk model applied in the program (e.g., One-Sided, Two-Sided) for financial exposure segmentation."
    - name: "program_year"
      expr: program_year
      comment: "Program year, used for year-over-year performance benchmarking."
    - name: "care_coordination_required_flag"
      expr: care_coordination_required_flag
      comment: "Indicates whether care coordination is required, used to assess operational complexity and cost."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the program became effective, used for program launch trend analysis."
  measures:
    - name: "total_active_programs"
      expr: COUNT(CASE WHEN program_status = 'Active' THEN 1 END)
      comment: "Total number of active VBC programs. Portfolio breadth metric used by the VBC strategy team to track program scale."
    - name: "avg_quality_performance_threshold"
      expr: AVG(CAST(quality_performance_threshold AS DOUBLE))
      comment: "Average quality performance threshold across VBC programs. Sets the quality bar for shared savings eligibility; reviewed at CMO steering meetings."
    - name: "avg_minimum_savings_rate"
      expr: AVG(CAST(minimum_savings_rate AS DOUBLE))
      comment: "Average minimum savings rate required across programs. Determines achievability of shared savings triggers across the program portfolio."
    - name: "avg_shared_savings_rate"
      expr: AVG(CAST(shared_savings_rate AS DOUBLE))
      comment: "Average shared savings rate offered across programs. Provider financial incentive level; drives provider recruitment and engagement in VBC."
    - name: "avg_minimum_loss_rate"
      expr: AVG(CAST(minimum_loss_rate AS DOUBLE))
      comment: "Average minimum loss rate threshold across two-sided risk programs. Measures downside risk exposure for financial planning."
    - name: "programs_with_cms_identifier_count"
      expr: COUNT(CASE WHEN cms_program_identifier IS NOT NULL THEN 1 END)
      comment: "Number of programs with a CMS program identifier, indicating federal program participation and associated reporting obligations."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_aco_provider`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring ACO provider participation, quality performance, and cost efficiency. Used by the VBC strategy team and CMO to manage ACO provider roster quality and shared savings eligibility."
  source: "`vibe_health_insurance_v1`.`network`.`aco_provider`"
  dimensions:
    - name: "participation_status"
      expr: participation_status
      comment: "Current participation status of the ACO provider (e.g., Active, Terminated, Pending)."
    - name: "participation_type"
      expr: participation_type
      comment: "Type of ACO participation (e.g., Primary Care, Specialist, Facility) for role-based analysis."
    - name: "participation_role"
      expr: participation_role
      comment: "Specific role of the provider within the ACO for care coordination analysis."
    - name: "vbc_track"
      expr: vbc_track
      comment: "VBC track the provider participates in (e.g., Track 1, Track 2, BASIC, ENHANCED) for risk model analysis."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status of the ACO provider, used to ensure quality and compliance of the ACO roster."
    - name: "primary_care_flag"
      expr: primary_care_flag
      comment: "Indicates whether the provider is a primary care provider, used for PCP-to-member ratio analysis."
    - name: "shared_savings_eligible_flag"
      expr: shared_savings_eligible_flag
      comment: "Indicates shared savings eligibility, used to track the proportion of providers eligible for financial incentives."
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year for the ACO provider, used for year-over-year quality and cost benchmarking."
  measures:
    - name: "total_active_aco_providers"
      expr: COUNT(CASE WHEN participation_status = 'Active' THEN 1 END)
      comment: "Total number of active ACO providers. ACO size metric used to assess program scale and CMS minimum participation thresholds."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across ACO providers. Quality scores determine shared savings eligibility; a drop triggers targeted quality improvement programs."
    - name: "avg_cost_efficiency_score"
      expr: AVG(CAST(cost_efficiency_score AS DOUBLE))
      comment: "Average cost efficiency score across ACO providers. Measures cost performance relative to benchmark; drives provider-level cost management interventions."
    - name: "avg_risk_sharing_percentage"
      expr: AVG(CAST(risk_sharing_percentage AS DOUBLE))
      comment: "Average risk-sharing percentage across ACO providers. Measures the financial risk distribution between the plan and ACO providers."
    - name: "shared_savings_eligible_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN shared_savings_eligible_flag = TRUE AND participation_status = 'Active' THEN 1 END) / NULLIF(COUNT(CASE WHEN participation_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active ACO providers eligible for shared savings. Measures the proportion of the ACO roster that can earn financial incentives."
    - name: "quality_reporting_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_reporting_flag = TRUE AND participation_status = 'Active' THEN 1 END) / NULLIF(COUNT(CASE WHEN participation_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active ACO providers meeting quality reporting requirements. Non-compliance disqualifies providers from shared savings and triggers CMS penalties."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_termination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring provider termination volume, member impact, regulatory filing compliance, and continuity of care obligations. Used by network operations and compliance teams to manage termination risk and regulatory obligations."
  source: "`vibe_health_insurance_v1`.`network`.`termination`"
  dimensions:
    - name: "termination_type"
      expr: termination_type
      comment: "Type of termination (e.g., Voluntary, Involuntary, For Cause) for root cause and risk analysis."
    - name: "termination_status"
      expr: termination_status
      comment: "Current status of the termination process (e.g., Pending, Effective, Appealed) for operational tracking."
    - name: "for_cause_flag"
      expr: for_cause_flag
      comment: "Indicates for-cause termination, which carries heightened regulatory and legal obligations."
    - name: "specialty_type"
      expr: specialty_type
      comment: "Specialty of the terminated provider, used to assess adequacy impact by specialty."
    - name: "network_adequacy_impact_flag"
      expr: network_adequacy_impact_flag
      comment: "Indicates whether the termination impacts network adequacy, triggering regulatory notification requirements."
    - name: "regulatory_filing_required_flag"
      expr: regulatory_filing_required_flag
      comment: "Indicates whether a regulatory filing is required for the termination."
    - name: "credentialing_related_flag"
      expr: credentialing_related_flag
      comment: "Indicates whether the termination is credentialing-related, used for NPDB reporting analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the termination became effective, used for trend and seasonality analysis."
  measures:
    - name: "total_terminations"
      expr: COUNT(1)
      comment: "Total number of provider terminations. Volume metric used to monitor network attrition and adequacy risk."
    - name: "for_cause_termination_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN for_cause_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminations that are for-cause. For-cause terminations require NPDB reporting and heightened legal review; a rising rate signals provider quality issues."
    - name: "adequacy_impacting_termination_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN network_adequacy_impact_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminations that impact network adequacy. Adequacy-impacting terminations trigger regulatory notification and recruitment obligations."
    - name: "regulatory_filing_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_filing_required_flag = TRUE AND regulatory_filing_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN regulatory_filing_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of terminations requiring regulatory filing where the filing was completed. Non-compliance with filing obligations triggers civil monetary penalties."
    - name: "member_notification_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN member_notification_required_flag = TRUE AND member_notification_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN member_notification_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of terminations requiring member notification where notification was sent. Member notification compliance is a CMS and state regulatory requirement."
    - name: "appeals_filed_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeals_filed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminations where the provider filed an appeal. High appeal rates signal process or fairness issues in the termination workflow."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_access_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring member access to care through provider appointment availability surveys. Used by network operations and quality teams to monitor access standard compliance and HEDIS/CMS star rating performance."
  source: "`vibe_health_insurance_v1`.`network`.`access_survey`"
  dimensions:
    - name: "survey_status"
      expr: survey_status
      comment: "Status of the access survey (e.g., Completed, Pending, Failed) for operational tracking."
    - name: "appointment_type_requested"
      expr: appointment_type_requested
      comment: "Type of appointment requested (e.g., Routine, Urgent, Preventive) for access standard compliance analysis."
    - name: "specialty_name"
      expr: specialty_name
      comment: "Provider specialty surveyed, used for specialty-level access standard compliance analysis."
    - name: "compliance_outcome"
      expr: compliance_outcome
      comment: "Access standard compliance outcome (e.g., Compliant, Non-Compliant) for regulatory reporting."
    - name: "survey_method"
      expr: survey_method
      comment: "Method used to conduct the survey (e.g., Phone, Online, In-Person) for methodology analysis."
    - name: "hedis_measure_applicable_flag"
      expr: hedis_measure_applicable_flag
      comment: "Indicates whether the survey result applies to a HEDIS measure, used for quality reporting."
    - name: "cms_star_rating_applicable_flag"
      expr: cms_star_rating_applicable_flag
      comment: "Indicates whether the survey result applies to CMS star ratings, used for star rating performance management."
    - name: "survey_date_month"
      expr: DATE_TRUNC('month', survey_date)
      comment: "Month the survey was conducted, used for trend and cycle analysis."
  measures:
    - name: "total_surveys_conducted"
      expr: COUNT(1)
      comment: "Total number of access surveys conducted. Baseline volume metric for access monitoring program coverage."
    - name: "access_standard_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN access_standard_met_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of surveys where the access standard was met. Primary access compliance KPI reviewed at regulatory and quality steering meetings."
    - name: "appointment_scheduled_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appointment_scheduled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of survey calls resulting in a scheduled appointment. Measures actual member access to care, a direct outcome metric for the CMO."
    - name: "accepting_new_patients_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN accepting_new_patients_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of surveyed providers accepting new patients. A declining rate signals member access risk and triggers network recruitment."
    - name: "telehealth_offered_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN telehealth_offered_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of surveyed providers offering telehealth. Measures virtual access capacity, a key CMS star rating and HEDIS metric."
    - name: "language_services_available_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN language_services_available_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of surveyed providers offering language services. Measures health equity access compliance for LEP member populations."
    - name: "after_hours_access_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN after_hours_access_available_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of surveyed providers offering after-hours access. After-hours availability is an access standard requirement for many LOBs."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring network adequacy regulatory filing volume, approval rates, and deficiency management. Used by regulatory affairs and network operations to manage state and federal filing obligations."
  source: "`vibe_health_insurance_v1`.`network`.`filing`"
  dimensions:
    - name: "filing_type"
      expr: filing_type
      comment: "Type of regulatory filing (e.g., Annual, Quarterly, Triggered) for workload and compliance analysis."
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the filing (e.g., Submitted, Approved, Rejected, Pending) for pipeline management."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body receiving the filing (e.g., CMS, State DOI) for jurisdiction-level compliance tracking."
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "State or federal jurisdiction of the filing, used for geographic compliance analysis."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business covered by the filing (e.g., Commercial, Medicare Advantage, Medicaid)."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year of the filing, used for year-over-year compliance trend analysis."
    - name: "adequacy_standard_met_flag"
      expr: adequacy_standard_met_flag
      comment: "Indicates whether the filing attests to meeting adequacy standards."
    - name: "submission_date_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month the filing was submitted, used for filing cycle and deadline compliance analysis."
  measures:
    - name: "total_filings"
      expr: COUNT(1)
      comment: "Total number of regulatory filings submitted. Baseline volume metric for regulatory affairs workload management."
    - name: "filing_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN filing_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings approved by the regulatory body. Low approval rates signal systemic adequacy or documentation issues requiring executive attention."
    - name: "filing_rejection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN filing_status = 'Rejected' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings rejected. Rejections trigger rework, delay plan approvals, and may result in regulatory sanctions."
    - name: "deficiency_issued_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN deficiency_issued_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings that resulted in a deficiency notice. Deficiencies require corrective action and may delay plan certification."
    - name: "exception_approved_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_approved_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN exception_approved_flag IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of filings with an approved exception. Measures regulatory flexibility granted for adequacy gaps."
    - name: "adequacy_standard_met_filing_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN adequacy_standard_met_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings attesting to meeting adequacy standards. Primary adequacy compliance rate for regulatory affairs reporting."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_recruitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring provider recruitment pipeline performance, conversion rates, and adequacy gap closure. Used by network development and operations teams to manage recruitment efficiency and adequacy remediation."
  source: "`vibe_health_insurance_v1`.`network`.`network_recruitment`"
  dimensions:
    - name: "recruitment_status"
      expr: recruitment_status
      comment: "Current status of the recruitment effort (e.g., Outreach, Negotiating, Contracted, Declined) for pipeline management."
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the recruitment effort (e.g., Contracted, Declined, No Response) for conversion analysis."
    - name: "target_specialty"
      expr: target_specialty
      comment: "Specialty being recruited, used to track recruitment progress by specialty gap."
    - name: "lob"
      expr: lob
      comment: "Line of business for which the provider is being recruited."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the recruitment effort (e.g., Critical, High, Medium, Low) for resource allocation."
    - name: "outreach_method"
      expr: outreach_method
      comment: "Method used for provider outreach (e.g., Phone, Mail, In-Person) for channel effectiveness analysis."
    - name: "regulatory_filing_required_flag"
      expr: regulatory_filing_required_flag
      comment: "Indicates whether the recruitment is tied to a regulatory filing obligation."
    - name: "outreach_date_month"
      expr: DATE_TRUNC('month', outreach_date)
      comment: "Month of initial outreach, used for recruitment pipeline trend analysis."
  measures:
    - name: "total_recruitment_efforts"
      expr: COUNT(1)
      comment: "Total number of provider recruitment efforts. Baseline volume metric for network development workload management."
    - name: "recruitment_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN disposition = 'Contracted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recruitment efforts resulting in a contracted provider. Primary efficiency KPI for the network development team."
    - name: "critical_priority_recruitment_count"
      expr: COUNT(CASE WHEN priority_level = 'Critical' THEN 1 END)
      comment: "Number of critical-priority recruitment efforts. Critical recruitments are tied to regulatory adequacy gaps requiring immediate resolution."
    - name: "avg_estimated_annual_claims_volume"
      expr: AVG(CAST(estimated_annual_claims_volume AS DOUBLE))
      comment: "Average estimated annual claims volume for recruited providers. Measures the financial impact of successful recruitment on claims cost management."
    - name: "total_estimated_annual_claims_volume"
      expr: SUM(CAST(estimated_annual_claims_volume AS DOUBLE))
      comment: "Total estimated annual claims volume across all recruitment efforts. Measures the aggregate financial impact of the recruitment pipeline."
    - name: "regulatory_driven_recruitment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_filing_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recruitment efforts driven by regulatory filing obligations. Measures the proportion of recruitment activity that is compliance-mandated."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_change_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring provider network change events, member impact, and regulatory notification compliance. Used by network operations and compliance teams to manage change-driven regulatory obligations and member continuity."
  source: "`vibe_health_insurance_v1`.`network`.`change_event`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of network change event (e.g., Termination, Tier Change, Panel Status Change) for impact analysis."
    - name: "change_status"
      expr: change_status
      comment: "Current status of the change event (e.g., Pending, Approved, Effective) for operational tracking."
    - name: "change_reason_code"
      expr: change_reason_code
      comment: "Reason code for the change, used for root cause analysis and trend identification."
    - name: "network_adequacy_impact_flag"
      expr: network_adequacy_impact_flag
      comment: "Indicates whether the change impacts network adequacy, triggering regulatory obligations."
    - name: "member_notification_required_flag"
      expr: member_notification_required_flag
      comment: "Indicates whether member notification is required for the change."
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Indicates whether regulatory reporting is required for the change."
    - name: "change_effective_date_month"
      expr: DATE_TRUNC('month', change_effective_date)
      comment: "Month the change became effective, used for trend and volume analysis."
  measures:
    - name: "total_change_events"
      expr: COUNT(1)
      comment: "Total number of network change events. Volume metric for network stability monitoring; high volumes signal instability."
    - name: "adequacy_impacting_change_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN network_adequacy_impact_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of change events that impact network adequacy. Adequacy-impacting changes trigger regulatory notification and recruitment obligations."
    - name: "member_notification_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN member_notification_required_flag = TRUE AND member_notification_sent_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN member_notification_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of change events requiring member notification where notification was sent. Member notification compliance is a CMS and state regulatory requirement."
    - name: "regulatory_reporting_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_reporting_required_flag = TRUE AND regulatory_filing_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of change events requiring regulatory reporting where the filing was completed. Non-compliance triggers civil monetary penalties."
    - name: "vbc_arrangement_change_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN vbc_arrangement_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of change events involving VBC arrangement providers. VBC provider changes have financial and quality performance implications."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`network_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network adequacy exception KPIs measuring exception volume, approval rates, appeal outcomes, and regulatory compliance for adequacy standard waivers."
  source: "`vibe_health_insurance_v1`.`network`.`exception`"
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