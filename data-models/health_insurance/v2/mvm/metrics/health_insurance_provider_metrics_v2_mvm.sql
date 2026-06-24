-- Metric views for domain: provider | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 01:44:05

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_network_participation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs measuring provider network participation health, panel capacity utilization, quality scoring, reimbursement economics, and credentialing compliance. Primary steering dashboard for network adequacy and value-based care program management."
  source: "`vibe_health_insurance_v1`.`provider`.`provider_network_participation`"
  dimensions:
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier assignment (e.g., Tier 1, Tier 2) used to segment providers by cost and quality for member steerage and benefit design decisions."
    - name: "participation_status"
      expr: participation_status
      comment: "Current participation status of the provider (e.g., Active, Terminated, Pending) for filtering active network members."
    - name: "participation_type"
      expr: participation_type
      comment: "Type of participation arrangement (e.g., PAR, Non-PAR, Capitated) used to analyze network composition and reimbursement model mix."
    - name: "contracted_reimbursement_model"
      expr: contracted_reimbursement_model
      comment: "Reimbursement model under which the provider is contracted (e.g., FFS, Capitation, VBC) for financial modeling and network strategy."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Current credentialing status of the provider network participation record, used to monitor compliance and identify credentialing gaps."
    - name: "par_status"
      expr: par_status
      comment: "Participating vs. non-participating indicator for claims adjudication and member cost-sharing analysis."
    - name: "network_adequacy_role"
      expr: network_adequacy_role
      comment: "Role the provider plays in satisfying network adequacy requirements (e.g., PCP, Specialist, OB) for regulatory compliance reporting."
    - name: "is_pcp"
      expr: is_pcp
      comment: "Flag indicating whether the provider serves as a Primary Care Provider, used to segment PCP vs. specialist network metrics."
    - name: "telehealth_available"
      expr: telehealth_available
      comment: "Indicates whether the provider offers telehealth services, used to measure virtual care network coverage."
    - name: "is_essential_community_provider"
      expr: is_essential_community_provider
      comment: "Flag for Essential Community Provider designation, critical for ACA marketplace regulatory compliance reporting."
    - name: "vbc_participation_flag"
      expr: vbc_participation_flag
      comment: "Indicates provider participation in value-based care arrangements, used to track VBC program penetration."
    - name: "contract_effective_date_month"
      expr: DATE_TRUNC('MONTH', contract_effective_date)
      comment: "Month of contract effective date for trending new provider contracting activity over time."
    - name: "credentialing_expiration_month"
      expr: DATE_TRUNC('MONTH', credentialing_expiration_date)
      comment: "Month when credentialing expires, used to proactively identify providers requiring recredentialing to avoid network gaps."
    - name: "geo_access_flag"
      expr: geo_access_flag
      comment: "Indicates whether the provider satisfies geographic access standards, used for time-distance compliance and network adequacy analysis."
    - name: "time_distance_compliant"
      expr: time_distance_compliant
      comment: "Flag indicating the provider meets time-and-distance access standards required by state and federal regulators."
  measures:
    - name: "total_active_participations"
      expr: COUNT(CASE WHEN participation_status = 'Active' THEN provider_network_participation_id END)
      comment: "Total count of active provider network participation records. Core network size KPI used by network management to assess adequacy and coverage."
    - name: "total_par_providers"
      expr: COUNT(CASE WHEN par_status_flag = TRUE THEN provider_network_participation_id END)
      comment: "Count of participating (PAR) providers in the network. Drives claims adjudication strategy and member benefit design decisions."
    - name: "total_pcp_providers"
      expr: COUNT(CASE WHEN is_pcp = TRUE THEN provider_network_participation_id END)
      comment: "Count of providers designated as Primary Care Providers. Critical for PCP network adequacy compliance and member attribution."
    - name: "total_telehealth_enabled_providers"
      expr: COUNT(CASE WHEN telehealth_available = TRUE THEN provider_network_participation_id END)
      comment: "Count of providers offering telehealth services. Measures virtual care network capacity for member access and digital health strategy."
    - name: "total_vbc_participating_providers"
      expr: COUNT(CASE WHEN vbc_participation_flag = TRUE THEN provider_network_participation_id END)
      comment: "Count of providers enrolled in value-based care arrangements. Tracks VBC program penetration and population health management reach."
    - name: "total_essential_community_providers"
      expr: COUNT(CASE WHEN is_essential_community_provider = TRUE THEN provider_network_participation_id END)
      comment: "Count of Essential Community Providers in the network. Required for ACA marketplace plan certification and regulatory compliance."
    - name: "total_geo_access_compliant_providers"
      expr: COUNT(CASE WHEN geo_access_flag = TRUE THEN provider_network_participation_id END)
      comment: "Count of providers meeting geographic access standards. Used to demonstrate network adequacy to regulators and identify access gaps."
    - name: "total_time_distance_compliant_providers"
      expr: COUNT(CASE WHEN time_distance_compliant = TRUE THEN provider_network_participation_id END)
      comment: "Count of providers satisfying time-and-distance access requirements. Core metric for state and federal network adequacy filings."
    - name: "pcp_participation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_pcp = TRUE THEN provider_network_participation_id END) / NULLIF(COUNT(provider_network_participation_id), 0), 2)
      comment: "Percentage of network participations that are PCP-designated. Benchmarked against adequacy standards to ensure sufficient primary care access."
    - name: "telehealth_penetration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN telehealth_available = TRUE THEN provider_network_participation_id END) / NULLIF(COUNT(provider_network_participation_id), 0), 2)
      comment: "Percentage of network providers offering telehealth. Tracks digital care access expansion and informs virtual-first network strategy."
    - name: "vbc_penetration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN vbc_participation_flag = TRUE THEN provider_network_participation_id END) / NULLIF(COUNT(provider_network_participation_id), 0), 2)
      comment: "Percentage of network providers in value-based care arrangements. Key executive KPI for tracking the shift from fee-for-service to value-based models."
    - name: "geo_access_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN geo_access_flag = TRUE THEN provider_network_participation_id END) / NULLIF(COUNT(provider_network_participation_id), 0), 2)
      comment: "Percentage of providers meeting geographic access standards. Regulatory compliance KPI reported to state insurance departments and CMS."
    - name: "credentialing_expiring_within_90_days"
      expr: COUNT(CASE WHEN credentialing_expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN provider_network_participation_id END)
      comment: "Count of providers whose credentialing expires within 90 days. Operational risk KPI that triggers recredentialing workflows to prevent network disruption."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across network providers. Executive KPI for monitoring overall network quality and informing tiering and incentive program decisions."
    - name: "avg_capitation_rate"
      expr: AVG(CAST(capitation_rate AS DOUBLE))
      comment: "Average capitation rate across capitated provider arrangements. Financial KPI used by actuarial and finance teams to monitor per-member cost trends."
    - name: "total_capitation_spend"
      expr: SUM(CAST(capitation_rate AS DOUBLE))
      comment: "Total capitation rate commitment across all capitated providers. Proxy for capitation budget exposure used in financial planning and risk management."
    - name: "avg_reimbursement_rate"
      expr: AVG(CAST(reimbursement_rate AS DOUBLE))
      comment: "Average contracted reimbursement rate across network providers. Used by contracting and finance teams to benchmark rates and manage unit cost trends."
    - name: "accepting_new_patients_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN accepting_new_patients_flag = TRUE THEN provider_network_participation_id END) / NULLIF(COUNT(provider_network_participation_id), 0), 2)
      comment: "Percentage of network providers currently accepting new patients. Member access KPI that drives provider directory accuracy and member assignment capacity."
    - name: "total_accepting_new_patients"
      expr: COUNT(CASE WHEN accepting_new_patients_flag = TRUE THEN provider_network_participation_id END)
      comment: "Absolute count of providers accepting new patients. Used alongside capacity metrics to assess member access and identify panel closure hotspots."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_participation_status`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and compliance KPIs for provider participation status management, including panel status, credentialing compliance, sanction monitoring, and network tier distribution. Used by network operations, compliance, and regulatory affairs teams."
  source: "`vibe_health_insurance_v1`.`provider`.`participation_status`"
  dimensions:
    - name: "participation_category"
      expr: participation_category
      comment: "Category of participation (e.g., Individual, Group, Facility) for segmenting network composition analysis."
    - name: "network_tier_code"
      expr: network_tier_code
      comment: "Network tier code assigned to the provider participation record, used for benefit design and member steerage analytics."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Current credentialing status (e.g., Approved, Pending, Expired) for compliance monitoring and credentialing pipeline management."
    - name: "panel_status"
      expr: panel_status
      comment: "Panel open/closed status indicating whether the provider is accepting new patient assignments."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code (e.g., Commercial, Medicare, Medicaid) for segmenting participation metrics by product line."
    - name: "pcp_flag"
      expr: pcp_flag
      comment: "Indicates whether the participation record is for a Primary Care Provider, used for PCP adequacy and attribution analysis."
    - name: "specialist_flag"
      expr: specialist_flag
      comment: "Indicates specialist designation for network adequacy specialty coverage analysis."
    - name: "telehealth_enabled_flag"
      expr: telehealth_enabled_flag
      comment: "Indicates telehealth capability for virtual care network coverage reporting."
    - name: "regulatory_sanction_flag"
      expr: regulatory_sanction_flag
      comment: "Flags providers under regulatory sanction, critical for compliance monitoring and risk management."
    - name: "current_record_flag"
      expr: current_record_flag
      comment: "Indicates the current active record for SCD-style participation status tables, used to filter to point-in-time snapshots."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of participation effective date for trending new participation activations over time."
    - name: "termination_date_month"
      expr: DATE_TRUNC('MONTH', termination_date)
      comment: "Month of participation termination for trending provider attrition and network churn analysis."
    - name: "risk_arrangement_code"
      expr: risk_arrangement_code
      comment: "Risk arrangement type (e.g., Global Cap, Shared Savings) for segmenting value-based payment model participation."
  measures:
    - name: "total_active_participation_records"
      expr: COUNT(CASE WHEN current_record_flag = TRUE THEN participation_status_id END)
      comment: "Total current active participation status records. Baseline network size KPI for network operations and adequacy reporting."
    - name: "total_sanctioned_providers"
      expr: COUNT(CASE WHEN regulatory_sanction_flag = TRUE AND current_record_flag = TRUE THEN participation_status_id END)
      comment: "Count of providers currently under regulatory sanction. Critical compliance KPI monitored by legal, compliance, and network integrity teams."
    - name: "sanction_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_sanction_flag = TRUE AND current_record_flag = TRUE THEN participation_status_id END) / NULLIF(COUNT(CASE WHEN current_record_flag = TRUE THEN participation_status_id END), 0), 2)
      comment: "Percentage of active providers under regulatory sanction. Executive risk KPI that triggers compliance review and potential network removal actions."
    - name: "total_open_panel_providers"
      expr: COUNT(CASE WHEN panel_status = 'Open' AND current_record_flag = TRUE THEN participation_status_id END)
      comment: "Count of providers with open panels accepting new patients. Member access KPI used to assess assignment capacity and identify access gaps."
    - name: "panel_open_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN panel_status = 'Open' AND current_record_flag = TRUE THEN participation_status_id END) / NULLIF(COUNT(CASE WHEN current_record_flag = TRUE THEN participation_status_id END), 0), 2)
      comment: "Percentage of active providers with open panels. Tracks member access capacity and informs network expansion decisions when rates fall below thresholds."
    - name: "total_credentialing_approved"
      expr: COUNT(CASE WHEN credentialing_status = 'Approved' AND current_record_flag = TRUE THEN participation_status_id END)
      comment: "Count of providers with approved credentialing status. Compliance KPI ensuring only credentialed providers are active in the network."
    - name: "credentialing_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN credentialing_status = 'Approved' AND current_record_flag = TRUE THEN participation_status_id END) / NULLIF(COUNT(CASE WHEN current_record_flag = TRUE THEN participation_status_id END), 0), 2)
      comment: "Percentage of active providers with approved credentialing. Regulatory compliance KPI; low rates signal credentialing backlog risk and potential claims payment issues."
    - name: "total_terminations"
      expr: COUNT(CASE WHEN termination_date IS NOT NULL AND termination_date <= CURRENT_DATE THEN participation_status_id END)
      comment: "Total count of provider participation terminations. Network attrition KPI used to monitor churn and trigger retention or replacement recruitment."
    - name: "recredentialing_due_within_90_days"
      expr: COUNT(CASE WHEN next_recredentialing_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) AND current_record_flag = TRUE THEN participation_status_id END)
      comment: "Count of providers due for recredentialing within 90 days. Operational risk KPI that drives credentialing team workload planning and prevents lapses."
    - name: "directory_display_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN directory_display_flag = TRUE AND current_record_flag = TRUE THEN participation_status_id END) / NULLIF(COUNT(CASE WHEN current_record_flag = TRUE THEN participation_status_id END), 0), 2)
      comment: "Percentage of active providers displayed in the member-facing provider directory. Regulatory compliance KPI for No Surprises Act and CMS directory accuracy requirements."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_directory_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider directory accuracy, completeness, and attestation compliance KPIs. Used by network operations, compliance, and member experience teams to ensure directory data meets CMS and No Surprises Act accuracy standards."
  source: "`vibe_health_insurance_v1`.`provider`.`directory_entry`"
  dimensions:
    - name: "provider_type"
      expr: provider_type
      comment: "Type of provider (e.g., MD, DO, NP, PA) for segmenting directory completeness and attestation metrics by provider category."
    - name: "attestation_status"
      expr: attestation_status
      comment: "Current attestation status of the directory entry (e.g., Attested, Pending, Overdue) for compliance monitoring."
    - name: "attestation_method"
      expr: attestation_method
      comment: "Method used for directory attestation (e.g., Online Portal, Phone, Mail) for process efficiency analysis."
    - name: "practice_state"
      expr: practice_state
      comment: "State where the provider practices, used for geographic network adequacy and state-level regulatory compliance reporting."
    - name: "gender"
      expr: gender
      comment: "Provider gender for diversity and member preference matching analytics."
    - name: "pcp_flag"
      expr: pcp_flag
      comment: "Indicates PCP designation in the directory for PCP-specific directory accuracy and adequacy reporting."
    - name: "accepting_new_patients_flag"
      expr: accepting_new_patients_flag
      comment: "Directory-published accepting new patients status for member access and directory accuracy analysis."
    - name: "telehealth_available_flag"
      expr: telehealth_available_flag
      comment: "Telehealth availability as published in the directory for virtual care access reporting."
    - name: "vreq_validated"
      expr: vreq_validated
      comment: "Indicates whether the directory entry has passed validation requirements, used for data quality and compliance reporting."
    - name: "directory_publication_date_month"
      expr: DATE_TRUNC('MONTH', directory_publication_date)
      comment: "Month of directory publication for trending directory update frequency and freshness."
    - name: "last_verified_date_month"
      expr: DATE_TRUNC('MONTH', last_verified_date)
      comment: "Month of last verification for identifying stale directory records requiring re-attestation."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source system that originated the directory entry for data lineage and quality root-cause analysis."
  measures:
    - name: "total_directory_entries"
      expr: COUNT(directory_entry_id)
      comment: "Total provider directory entries. Baseline KPI for directory size and coverage used in network adequacy and member access reporting."
    - name: "total_attested_entries"
      expr: COUNT(CASE WHEN attestation_status = 'Attested' THEN directory_entry_id END)
      comment: "Count of directory entries with confirmed attestation. CMS and No Surprises Act compliance KPI; unattested entries create regulatory and member harm risk."
    - name: "attestation_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN attestation_status = 'Attested' THEN directory_entry_id END) / NULLIF(COUNT(directory_entry_id), 0), 2)
      comment: "Percentage of directory entries with valid attestation. Primary regulatory compliance KPI for CMS directory accuracy rules; below 95% triggers corrective action."
    - name: "total_validated_entries"
      expr: COUNT(CASE WHEN vreq_validated = TRUE THEN directory_entry_id END)
      comment: "Count of directory entries passing validation requirements. Data quality KPI ensuring directory accuracy and reducing member misdirection."
    - name: "validation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN vreq_validated = TRUE THEN directory_entry_id END) / NULLIF(COUNT(directory_entry_id), 0), 2)
      comment: "Percentage of directory entries that have passed validation. Tracks data quality program effectiveness and regulatory readiness."
    - name: "total_accepting_new_patients"
      expr: COUNT(CASE WHEN accepting_new_patients_flag = TRUE THEN directory_entry_id END)
      comment: "Count of directory-published providers accepting new patients. Member access KPI used to assess network capacity and identify access deserts."
    - name: "accepting_new_patients_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN accepting_new_patients_flag = TRUE THEN directory_entry_id END) / NULLIF(COUNT(directory_entry_id), 0), 2)
      comment: "Percentage of directory providers accepting new patients. Member access and network adequacy KPI monitored against regulatory thresholds."
    - name: "stale_directory_entries"
      expr: COUNT(CASE WHEN next_verification_due_date < CURRENT_DATE THEN directory_entry_id END)
      comment: "Count of directory entries past their verification due date. Compliance risk KPI; stale entries violate CMS directory accuracy requirements and expose the plan to penalties."
    - name: "stale_entry_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN next_verification_due_date < CURRENT_DATE THEN directory_entry_id END) / NULLIF(COUNT(directory_entry_id), 0), 2)
      comment: "Percentage of directory entries that are overdue for verification. Executive compliance KPI directly tied to CMS audit risk and potential civil monetary penalties."
    - name: "total_telehealth_listed_providers"
      expr: COUNT(CASE WHEN telehealth_available_flag = TRUE THEN directory_entry_id END)
      comment: "Count of providers listed in the directory as telehealth-enabled. Tracks virtual care network visibility and member access to digital health services."
    - name: "telehealth_directory_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN telehealth_available_flag = TRUE THEN directory_entry_id END) / NULLIF(COUNT(directory_entry_id), 0), 2)
      comment: "Percentage of directory entries with telehealth availability. Informs digital health strategy and member communication about virtual care options."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider licensure compliance KPIs tracking license status, expiration risk, disciplinary actions, and continuing education requirements. Used by credentialing, compliance, and network integrity teams to ensure only properly licensed providers are active in the network."
  source: "`vibe_health_insurance_v1`.`provider`.`license`"
  dimensions:
    - name: "license_type"
      expr: license_type
      comment: "Type of license (e.g., MD, RN, LCSW) for segmenting compliance metrics by provider credential category."
    - name: "license_status"
      expr: license_status
      comment: "Current status of the license (e.g., Active, Expired, Suspended, Revoked) for compliance monitoring and network integrity."
    - name: "issuing_state"
      expr: issuing_state
      comment: "State that issued the license for geographic compliance analysis and multi-state practice monitoring."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Licensing authority (e.g., State Medical Board) for tracking verification sources and regulatory body relationships."
    - name: "disciplinary_action_flag"
      expr: disciplinary_action_flag
      comment: "Indicates whether a disciplinary action has been recorded against this license, critical for network integrity and compliance risk management."
    - name: "compact_participation_flag"
      expr: compact_participation_flag
      comment: "Indicates participation in interstate compact (e.g., Nurse Licensure Compact) for multi-state practice and telehealth eligibility analysis."
    - name: "telemedicine_authorized_flag"
      expr: telemedicine_authorized_flag
      comment: "Indicates whether the license authorizes telemedicine practice, used for virtual care network eligibility verification."
    - name: "continuing_education_required_flag"
      expr: continuing_education_required_flag
      comment: "Indicates whether continuing education is required for license renewal, used for compliance tracking and provider education program planning."
    - name: "record_current_flag"
      expr: record_current_flag
      comment: "Indicates the current active license record for SCD-style license tables, used to filter to current licensure state."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month of license expiration for trending upcoming expirations and planning renewal outreach campaigns."
    - name: "issue_date_year"
      expr: DATE_TRUNC('YEAR', issue_date)
      comment: "Year of license issuance for cohort analysis of provider tenure and license vintage."
  measures:
    - name: "total_active_licenses"
      expr: COUNT(CASE WHEN license_status = 'Active' AND record_current_flag = TRUE THEN license_id END)
      comment: "Total count of active provider licenses. Baseline credentialing compliance KPI ensuring network providers maintain valid licensure."
    - name: "total_expired_licenses"
      expr: COUNT(CASE WHEN license_status = 'Expired' AND record_current_flag = TRUE THEN license_id END)
      comment: "Count of expired licenses among current records. Critical compliance risk KPI; expired licenses require immediate network suspension to avoid regulatory penalties."
    - name: "license_expiration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN license_status = 'Expired' AND record_current_flag = TRUE THEN license_id END) / NULLIF(COUNT(CASE WHEN record_current_flag = TRUE THEN license_id END), 0), 2)
      comment: "Percentage of current licenses that are expired. Executive compliance KPI; elevated rates signal credentialing process failures and regulatory audit risk."
    - name: "licenses_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) AND license_status = 'Active' AND record_current_flag = TRUE THEN license_id END)
      comment: "Count of active licenses expiring within 90 days. Operational risk KPI that drives proactive renewal outreach to prevent network disruption."
    - name: "total_disciplinary_actions"
      expr: COUNT(CASE WHEN disciplinary_action_flag = TRUE AND record_current_flag = TRUE THEN license_id END)
      comment: "Count of licenses with recorded disciplinary actions. Network integrity KPI monitored by compliance and legal teams; triggers provider review and potential termination."
    - name: "disciplinary_action_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN disciplinary_action_flag = TRUE AND record_current_flag = TRUE THEN license_id END) / NULLIF(COUNT(CASE WHEN record_current_flag = TRUE THEN license_id END), 0), 2)
      comment: "Percentage of current licenses with disciplinary actions. Risk management KPI used to benchmark network quality and identify high-risk provider concentrations."
    - name: "total_telemedicine_authorized_licenses"
      expr: COUNT(CASE WHEN telemedicine_authorized_flag = TRUE AND license_status = 'Active' AND record_current_flag = TRUE THEN license_id END)
      comment: "Count of active licenses with telemedicine authorization. Tracks the licensed capacity for virtual care delivery across the provider network."
    - name: "avg_continuing_education_hours_required"
      expr: AVG(CAST(continuing_education_hours_required AS DOUBLE))
      comment: "Average continuing education hours required per license. Used by provider relations teams to understand CE burden and design support programs."
    - name: "total_compact_participating_licenses"
      expr: COUNT(CASE WHEN compact_participation_flag = TRUE AND record_current_flag = TRUE THEN license_id END)
      comment: "Count of licenses participating in interstate compact arrangements. Tracks multi-state practice capacity relevant to telehealth and border-area network adequacy."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility network quality, accreditation, certification, and access KPIs. Used by network management, quality, and regulatory teams to monitor facility network composition, quality ratings, and compliance status."
  source: "`vibe_health_insurance_v1`.`provider`.`facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (e.g., Hospital, Urgent Care, SNF, ASC) for segmenting network composition and adequacy metrics by facility category."
    - name: "participation_status"
      expr: participation_status
      comment: "Current participation status of the facility (e.g., Active, Terminated) for filtering active network facilities."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier assignment for the facility, used for benefit design, member steerage, and cost management analytics."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status of the facility for compliance monitoring and network integrity."
    - name: "accreditation_body"
      expr: accreditation_body
      comment: "Accrediting body (e.g., The Joint Commission, DNV) for quality benchmarking and accreditation compliance tracking."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Facility ownership type (e.g., Non-Profit, For-Profit, Government) for network composition and strategic partnership analysis."
    - name: "state_code"
      expr: state_code
      comment: "State where the facility is located for geographic network adequacy and state-level regulatory reporting."
    - name: "teaching_hospital_flag"
      expr: teaching_hospital_flag
      comment: "Indicates teaching hospital designation for academic medical center network analysis and graduate medical education tracking."
    - name: "critical_access_hospital_flag"
      expr: critical_access_hospital_flag
      comment: "Indicates Critical Access Hospital designation for rural access and CMS reimbursement compliance analysis."
    - name: "emergency_services_flag"
      expr: emergency_services_flag
      comment: "Indicates availability of emergency services for network adequacy and No Surprises Act compliance analysis."
    - name: "telehealth_enabled_flag"
      expr: telehealth_enabled_flag
      comment: "Indicates telehealth capability for virtual care facility network coverage reporting."
    - name: "medicare_certified_flag"
      expr: medicare_certified_flag
      comment: "Indicates Medicare certification for dual-eligible program eligibility and Medicare Advantage network compliance."
    - name: "medicaid_certified_flag"
      expr: medicaid_certified_flag
      comment: "Indicates Medicaid certification for Medicaid managed care network adequacy and compliance reporting."
    - name: "effective_date_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the facility became effective in the network for trending network growth and facility contracting activity."
  measures:
    - name: "total_active_facilities"
      expr: COUNT(CASE WHEN participation_status = 'Active' THEN facility_id END)
      comment: "Total active facilities in the network. Baseline facility network size KPI for adequacy reporting and member access analysis."
    - name: "total_accredited_facilities"
      expr: COUNT(CASE WHEN accreditation_body IS NOT NULL AND participation_status = 'Active' THEN facility_id END)
      comment: "Count of active facilities with accreditation. Quality KPI used in network tiering, member communications, and plan quality ratings."
    - name: "accreditation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN accreditation_body IS NOT NULL AND participation_status = 'Active' THEN facility_id END) / NULLIF(COUNT(CASE WHEN participation_status = 'Active' THEN facility_id END), 0), 2)
      comment: "Percentage of active facilities that are accredited. Network quality KPI benchmarked against industry standards and used in NCQA and URAC accreditation submissions."
    - name: "avg_quality_rating"
      expr: AVG(CAST(quality_rating AS DOUBLE))
      comment: "Average quality rating across network facilities. Executive quality KPI used to monitor overall facility network quality and inform tiering and incentive decisions."
    - name: "total_emergency_services_facilities"
      expr: COUNT(CASE WHEN emergency_services_flag = TRUE AND participation_status = 'Active' THEN facility_id END)
      comment: "Count of active facilities offering emergency services. Network adequacy KPI for emergency access compliance and No Surprises Act readiness."
    - name: "total_critical_access_hospitals"
      expr: COUNT(CASE WHEN critical_access_hospital_flag = TRUE AND participation_status = 'Active' THEN facility_id END)
      comment: "Count of active Critical Access Hospitals in the network. Rural access KPI critical for CMS network adequacy standards and Medicaid managed care contracts."
    - name: "total_teaching_hospitals"
      expr: COUNT(CASE WHEN teaching_hospital_flag = TRUE AND participation_status = 'Active' THEN facility_id END)
      comment: "Count of active teaching hospitals in the network. Strategic KPI for academic medical center relationships and complex care access."
    - name: "total_telehealth_enabled_facilities"
      expr: COUNT(CASE WHEN telehealth_enabled_flag = TRUE AND participation_status = 'Active' THEN facility_id END)
      comment: "Count of active facilities with telehealth capability. Tracks virtual care infrastructure across the facility network."
    - name: "accreditation_expiring_within_90_days"
      expr: COUNT(CASE WHEN accreditation_expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) AND participation_status = 'Active' THEN facility_id END)
      comment: "Count of active facilities with accreditation expiring within 90 days. Compliance risk KPI that triggers renewal outreach to prevent quality designation lapses."
    - name: "medicare_certified_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN medicare_certified_flag = TRUE AND participation_status = 'Active' THEN facility_id END) / NULLIF(COUNT(CASE WHEN participation_status = 'Active' THEN facility_id END), 0), 2)
      comment: "Percentage of active facilities with Medicare certification. Compliance KPI for Medicare Advantage network adequacy and dual-eligible program management."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_practice_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Practice location access, geographic coverage, and accessibility KPIs. Used by network adequacy, member experience, and regulatory teams to monitor physical access points, ADA compliance, and geographic distribution of the provider network."
  source: "`vibe_health_insurance_v1`.`provider`.`practice_location`"
  dimensions:
    - name: "location_type"
      expr: location_type
      comment: "Type of practice location (e.g., Office, Hospital, Clinic) for segmenting access metrics by care setting."
    - name: "state_code"
      expr: state_code
      comment: "State of the practice location for geographic network adequacy analysis and state-level regulatory reporting."
    - name: "participation_status"
      expr: participation_status
      comment: "Participation status of the practice location for filtering active access points."
    - name: "accepting_new_patients_flag"
      expr: accepting_new_patients_flag
      comment: "Indicates whether the location is accepting new patients for member access and panel capacity analysis."
    - name: "telehealth_available_flag"
      expr: telehealth_available_flag
      comment: "Indicates telehealth availability at this location for virtual care access reporting."
    - name: "wheelchair_accessible_flag"
      expr: wheelchair_accessible_flag
      comment: "Indicates wheelchair accessibility for ADA compliance and member accessibility reporting."
    - name: "ada_compliant_flag"
      expr: ada_compliant_flag
      comment: "Indicates full ADA compliance for regulatory accessibility reporting and member accommodation analysis."
    - name: "directory_display_flag"
      expr: directory_display_flag
      comment: "Indicates whether the location is published in the member-facing directory for directory accuracy compliance."
    - name: "public_transportation_access_flag"
      expr: public_transportation_access_flag
      comment: "Indicates public transportation access for member accessibility and health equity analysis."
    - name: "vreq_validated"
      expr: vreq_validated
      comment: "Indicates whether the location record has passed validation for data quality monitoring."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the practice location became effective for trending network location growth."
  measures:
    - name: "total_active_locations"
      expr: COUNT(CASE WHEN participation_status = 'Active' THEN practice_location_id END)
      comment: "Total active practice locations in the network. Baseline access point KPI for network adequacy and geographic coverage analysis."
    - name: "total_accepting_new_patients_locations"
      expr: COUNT(CASE WHEN accepting_new_patients_flag = TRUE AND participation_status = 'Active' THEN practice_location_id END)
      comment: "Count of active locations accepting new patients. Member access KPI used to identify capacity and geographic access gaps."
    - name: "accepting_new_patients_location_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN accepting_new_patients_flag = TRUE AND participation_status = 'Active' THEN practice_location_id END) / NULLIF(COUNT(CASE WHEN participation_status = 'Active' THEN practice_location_id END), 0), 2)
      comment: "Percentage of active locations accepting new patients. Network access KPI monitored against adequacy thresholds to ensure member assignment capacity."
    - name: "total_ada_compliant_locations"
      expr: COUNT(CASE WHEN ada_compliant_flag = TRUE AND participation_status = 'Active' THEN practice_location_id END)
      comment: "Count of active ADA-compliant practice locations. Regulatory compliance and health equity KPI ensuring accessible care for members with disabilities."
    - name: "ada_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ada_compliant_flag = TRUE AND participation_status = 'Active' THEN practice_location_id END) / NULLIF(COUNT(CASE WHEN participation_status = 'Active' THEN practice_location_id END), 0), 2)
      comment: "Percentage of active locations that are ADA compliant. Regulatory and health equity KPI; low rates signal accessibility gaps and potential ADA compliance risk."
    - name: "total_telehealth_locations"
      expr: COUNT(CASE WHEN telehealth_available_flag = TRUE AND participation_status = 'Active' THEN practice_location_id END)
      comment: "Count of active locations offering telehealth services. Virtual care access KPI for network digital health strategy and member access reporting."
    - name: "telehealth_location_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN telehealth_available_flag = TRUE AND participation_status = 'Active' THEN practice_location_id END) / NULLIF(COUNT(CASE WHEN participation_status = 'Active' THEN practice_location_id END), 0), 2)
      comment: "Percentage of active locations with telehealth availability. Tracks virtual care infrastructure penetration across the physical network."
    - name: "stale_verification_locations"
      expr: COUNT(CASE WHEN last_verified_date < DATE_ADD(CURRENT_DATE, -180) AND participation_status = 'Active' THEN practice_location_id END)
      comment: "Count of active locations not verified in the past 180 days. Directory accuracy and compliance risk KPI for CMS and No Surprises Act requirements."
    - name: "stale_verification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN last_verified_date < DATE_ADD(CURRENT_DATE, -180) AND participation_status = 'Active' THEN practice_location_id END) / NULLIF(COUNT(CASE WHEN participation_status = 'Active' THEN practice_location_id END), 0), 2)
      comment: "Percentage of active locations with stale verification data. Regulatory compliance KPI directly tied to CMS directory accuracy audit risk."
    - name: "distinct_states_covered"
      expr: COUNT(DISTINCT state_code)
      comment: "Count of distinct states with active practice locations. Geographic coverage KPI used in network adequacy filings and multi-state plan management."
    - name: "validated_location_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN vreq_validated = TRUE AND participation_status = 'Active' THEN practice_location_id END) / NULLIF(COUNT(CASE WHEN participation_status = 'Active' THEN practice_location_id END), 0), 2)
      comment: "Percentage of active locations passing validation requirements. Data quality KPI ensuring location data accuracy for directory and claims adjudication."
$$;