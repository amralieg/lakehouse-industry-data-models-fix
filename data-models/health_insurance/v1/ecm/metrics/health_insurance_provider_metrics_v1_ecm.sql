-- Metric views for domain: provider | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 18:36:19

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`provider`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core provider master metrics covering network participation, credentialing status, and provider demographics for strategic workforce and network adequacy analysis."
  source: "`health_insurance_ecm`.`provider`.`provider_provider`"
  dimensions:
    - name: "provider_type"
      expr: provider_type
      comment: "Classification of provider (e.g., MD, DO, NP, PA) for workforce mix analysis."
    - name: "provider_category"
      expr: provider_category
      comment: "Broad provider category (individual, organizational) for network composition."
    - name: "primary_specialty"
      expr: primary_specialty
      comment: "Provider primary medical specialty for network adequacy and access reporting."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Current credentialing status for compliance and operational readiness tracking."
    - name: "participation_status"
      expr: participation_status
      comment: "Provider network participation status (active, terminated, pending) for network management."
    - name: "state"
      expr: state
      comment: "Provider state for geographic distribution and regulatory reporting."
    - name: "gender"
      expr: gender
      comment: "Provider gender for diversity and member access analysis."
    - name: "board_certification_summary_status"
      expr: board_certification_summary_status
      comment: "Summary board certification status for quality and credentialing oversight."
    - name: "network_participation_flag"
      expr: CAST(network_participation_flag AS STRING)
      comment: "Whether provider participates in any network, critical for directory and adequacy."
    - name: "malpractice_coverage_flag"
      expr: CAST(malpractice_coverage_flag AS STRING)
      comment: "Whether provider has active malpractice coverage for risk management."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year provider became effective for cohort and tenure analysis."
  measures:
    - name: "total_providers"
      expr: COUNT(1)
      comment: "Total count of provider records for network size benchmarking."
    - name: "distinct_provider_count"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct provider count for accurate headcount reporting."
    - name: "network_participating_provider_count"
      expr: COUNT(CASE WHEN network_participation_flag = TRUE THEN 1 END)
      comment: "Count of providers actively participating in networks, key for CMS network adequacy."
    - name: "credentialed_provider_count"
      expr: COUNT(CASE WHEN credentialing_status = 'Active' THEN 1 END)
      comment: "Count of providers with active credentialing status for compliance reporting."
    - name: "board_certified_provider_count"
      expr: COUNT(CASE WHEN board_certification_summary_status = 'Board Certified' THEN 1 END)
      comment: "Count of board-certified providers for quality benchmarking."
    - name: "malpractice_covered_provider_count"
      expr: COUNT(CASE WHEN malpractice_coverage_flag = TRUE THEN 1 END)
      comment: "Count of providers with malpractice coverage for risk exposure analysis."
    - name: "terminated_provider_count"
      expr: COUNT(CASE WHEN participation_status = 'Terminated' THEN 1 END)
      comment: "Count of terminated providers for attrition and network stability tracking."
    - name: "distinct_specialty_count"
      expr: COUNT(DISTINCT primary_specialty)
      comment: "Number of distinct specialties represented for network breadth assessment."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`provider_participation_status`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider network participation lifecycle metrics tracking active participation, credentialing compliance, panel status, and termination patterns for network management and regulatory reporting."
  source: "`health_insurance_ecm`.`provider`.`participation_status`"
  dimensions:
    - name: "participation_status_name"
      expr: participation_status_name
      comment: "Human-readable participation status for operational dashboards."
    - name: "participation_status_code"
      expr: participation_status_code
      comment: "Coded participation status for system-level filtering."
    - name: "participation_category"
      expr: participation_category
      comment: "Category of participation (e.g., full, provisional) for tiered analysis."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code (Commercial, Medicare, Medicaid) for regulatory segmentation."
    - name: "network_tier_code"
      expr: network_tier_code
      comment: "Network tier for tiered network and cost-sharing analysis."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status tied to participation for compliance tracking."
    - name: "panel_status"
      expr: panel_status
      comment: "Provider panel status (open/closed) for member access management."
    - name: "pcp_flag"
      expr: CAST(pcp_flag AS STRING)
      comment: "Whether provider is a PCP, critical for primary care access adequacy."
    - name: "specialist_flag"
      expr: CAST(specialist_flag AS STRING)
      comment: "Whether provider is a specialist for specialty access reporting."
    - name: "telehealth_enabled_flag"
      expr: CAST(telehealth_enabled_flag AS STRING)
      comment: "Whether provider offers telehealth for virtual care access metrics."
    - name: "termination_reason_code"
      expr: termination_reason_code
      comment: "Reason for termination for root cause and retention analysis."
    - name: "risk_arrangement_code"
      expr: risk_arrangement_code
      comment: "Risk arrangement type (capitation, FFS, shared savings) for value-based care tracking."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year participation became effective for trend analysis."
    - name: "current_record_flag"
      expr: CAST(current_record_flag AS STRING)
      comment: "Whether this is the current/active record for point-in-time reporting."
  measures:
    - name: "total_participation_records"
      expr: COUNT(1)
      comment: "Total participation status records for volume tracking."
    - name: "active_participation_count"
      expr: COUNT(CASE WHEN participation_status_code = 'Active' THEN 1 END)
      comment: "Count of active participations for network size reporting."
    - name: "terminated_participation_count"
      expr: COUNT(CASE WHEN participation_status_code = 'Terminated' THEN 1 END)
      comment: "Count of terminated participations for attrition analysis."
    - name: "pcp_participation_count"
      expr: COUNT(CASE WHEN pcp_flag = TRUE THEN 1 END)
      comment: "Count of PCP participations for primary care adequacy reporting."
    - name: "telehealth_enabled_count"
      expr: COUNT(CASE WHEN telehealth_enabled_flag = TRUE THEN 1 END)
      comment: "Count of telehealth-enabled participations for virtual care access."
    - name: "accepting_new_patients_count"
      expr: COUNT(CASE WHEN accepting_new_patients_flag = TRUE THEN 1 END)
      comment: "Count of providers accepting new patients for member access and adequacy."
    - name: "sanctioned_provider_count"
      expr: COUNT(CASE WHEN regulatory_sanction_flag = TRUE THEN 1 END)
      comment: "Count of providers with regulatory sanctions for compliance risk monitoring."
    - name: "distinct_participating_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct providers with participation records for unduplicated network headcount."
    - name: "current_active_participation_count"
      expr: COUNT(CASE WHEN current_record_flag = TRUE AND participation_status_code = 'Active' THEN 1 END)
      comment: "Current active participations for real-time network adequacy."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`provider_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility-level metrics for network composition, quality ratings, bed capacity, and certification status supporting network adequacy, accreditation, and strategic facility management."
  source: "`health_insurance_ecm`.`provider`.`facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (hospital, clinic, ASC, SNF) for network composition analysis."
    - name: "participation_status"
      expr: participation_status
      comment: "Facility network participation status for active network tracking."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Facility credentialing status for compliance monitoring."
    - name: "state_code"
      expr: state_code
      comment: "Facility state for geographic adequacy and regulatory reporting."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier assignment for tiered benefit design analysis."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Facility ownership type (for-profit, non-profit, government) for market analysis."
    - name: "accreditation_body"
      expr: accreditation_body
      comment: "Accrediting organization (Joint Commission, NCQA, etc.) for quality oversight."
    - name: "trauma_level"
      expr: trauma_level
      comment: "Trauma center designation level for emergency care access analysis."
    - name: "critical_access_hospital_flag"
      expr: CAST(critical_access_hospital_flag AS STRING)
      comment: "Whether facility is a critical access hospital for rural access reporting."
    - name: "teaching_hospital_flag"
      expr: CAST(teaching_hospital_flag AS STRING)
      comment: "Whether facility is a teaching hospital for academic network analysis."
    - name: "emergency_services_flag"
      expr: CAST(emergency_services_flag AS STRING)
      comment: "Whether facility provides emergency services for access compliance."
    - name: "medicare_certified_flag"
      expr: CAST(medicare_certified_flag AS STRING)
      comment: "Medicare certification status for government program compliance."
    - name: "medicaid_certified_flag"
      expr: CAST(medicaid_certified_flag AS STRING)
      comment: "Medicaid certification status for government program compliance."
    - name: "telehealth_enabled_flag"
      expr: CAST(telehealth_enabled_flag AS STRING)
      comment: "Whether facility supports telehealth for virtual care strategy."
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total facility count for network size benchmarking."
    - name: "active_facility_count"
      expr: COUNT(CASE WHEN participation_status = 'Active' THEN 1 END)
      comment: "Count of active facilities for current network adequacy."
    - name: "avg_quality_rating"
      expr: AVG(CAST(quality_rating AS DOUBLE))
      comment: "Average facility quality rating for network quality benchmarking."
    - name: "emergency_services_facility_count"
      expr: COUNT(CASE WHEN emergency_services_flag = TRUE THEN 1 END)
      comment: "Count of facilities with emergency services for access compliance."
    - name: "critical_access_hospital_count"
      expr: COUNT(CASE WHEN critical_access_hospital_flag = TRUE THEN 1 END)
      comment: "Count of critical access hospitals for rural access adequacy."
    - name: "medicare_certified_count"
      expr: COUNT(CASE WHEN medicare_certified_flag = TRUE THEN 1 END)
      comment: "Count of Medicare-certified facilities for government program network reporting."
    - name: "telehealth_enabled_facility_count"
      expr: COUNT(CASE WHEN telehealth_enabled_flag = TRUE THEN 1 END)
      comment: "Count of telehealth-enabled facilities for virtual care strategy."
    - name: "teaching_hospital_count"
      expr: COUNT(CASE WHEN teaching_hospital_flag = TRUE THEN 1 END)
      comment: "Count of teaching hospitals for academic network composition."
    - name: "distinct_facility_states"
      expr: COUNT(DISTINCT state_code)
      comment: "Number of distinct states with facilities for geographic coverage assessment."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`provider_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider license lifecycle metrics tracking active licenses, expirations, disciplinary actions, and compact participation for credentialing compliance and risk management."
  source: "`health_insurance_ecm`.`provider`.`license`"
  dimensions:
    - name: "license_type"
      expr: license_type
      comment: "Type of license (medical, nursing, etc.) for workforce composition."
    - name: "license_status"
      expr: license_status
      comment: "Current license status for compliance monitoring."
    - name: "issuing_state"
      expr: issuing_state
      comment: "State that issued the license for geographic credentialing analysis."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Licensing authority for regulatory body tracking."
    - name: "disciplinary_action_flag"
      expr: CAST(disciplinary_action_flag AS STRING)
      comment: "Whether disciplinary action exists for risk and compliance flagging."
    - name: "compact_participation_flag"
      expr: CAST(compact_participation_flag AS STRING)
      comment: "Whether license participates in interstate compact for multi-state practice tracking."
    - name: "telemedicine_authorized_flag"
      expr: CAST(telemedicine_authorized_flag AS STRING)
      comment: "Whether license authorizes telemedicine for virtual care workforce planning."
    - name: "record_current_flag"
      expr: CAST(record_current_flag AS STRING)
      comment: "Whether this is the current license record for point-in-time analysis."
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "License expiration year for renewal pipeline forecasting."
  measures:
    - name: "total_license_records"
      expr: COUNT(1)
      comment: "Total license records for volume tracking."
    - name: "active_license_count"
      expr: COUNT(CASE WHEN license_status = 'Active' THEN 1 END)
      comment: "Count of active licenses for credentialing compliance."
    - name: "expired_license_count"
      expr: COUNT(CASE WHEN license_status = 'Expired' THEN 1 END)
      comment: "Count of expired licenses for compliance risk identification."
    - name: "disciplinary_action_count"
      expr: COUNT(CASE WHEN disciplinary_action_flag = TRUE THEN 1 END)
      comment: "Count of licenses with disciplinary actions for risk management."
    - name: "compact_license_count"
      expr: COUNT(CASE WHEN compact_participation_flag = TRUE THEN 1 END)
      comment: "Count of compact licenses for multi-state practice capacity."
    - name: "telemedicine_authorized_count"
      expr: COUNT(CASE WHEN telemedicine_authorized_flag = TRUE THEN 1 END)
      comment: "Count of telemedicine-authorized licenses for virtual care workforce."
    - name: "distinct_licensed_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct providers with license records for unduplicated credentialing headcount."
    - name: "distinct_licensing_states"
      expr: COUNT(DISTINCT issuing_state)
      comment: "Number of distinct states with licensed providers for geographic coverage."
    - name: "avg_continuing_education_hours_required"
      expr: AVG(CAST(continuing_education_hours_required AS DOUBLE))
      comment: "Average CE hours required across licenses for training burden analysis."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`provider_sanction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider sanction and exclusion metrics for compliance risk monitoring, CMS/NCQA reporting, and network integrity management."
  source: "`health_insurance_ecm`.`provider`.`sanction`"
  dimensions:
    - name: "sanction_type"
      expr: sanction_type
      comment: "Type of sanction for categorized risk analysis."
    - name: "sanction_source"
      expr: sanction_source
      comment: "Source of sanction (OIG, SAM, state) for regulatory tracking."
    - name: "severity_level"
      expr: severity_level
      comment: "Sanction severity for risk prioritization."
    - name: "screening_result"
      expr: screening_result
      comment: "Screening outcome for match rate analysis."
    - name: "participation_impact"
      expr: participation_impact
      comment: "Impact on network participation for operational action tracking."
    - name: "resolution_action"
      expr: resolution_action
      comment: "Resolution action taken for remediation tracking."
    - name: "cms_reportable_flag"
      expr: CAST(cms_reportable_flag AS STRING)
      comment: "Whether sanction is CMS-reportable for federal compliance."
    - name: "ncqa_reportable_flag"
      expr: CAST(ncqa_reportable_flag AS STRING)
      comment: "Whether sanction is NCQA-reportable for accreditation compliance."
    - name: "current_record_flag"
      expr: CAST(current_record_flag AS STRING)
      comment: "Whether this is the current sanction record."
    - name: "sanction_year"
      expr: YEAR(sanction_date)
      comment: "Year of sanction for trend analysis."
  measures:
    - name: "total_sanction_records"
      expr: COUNT(1)
      comment: "Total sanction records for compliance volume tracking."
    - name: "distinct_sanctioned_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct providers with sanctions for unduplicated risk exposure."
    - name: "cms_reportable_sanction_count"
      expr: COUNT(CASE WHEN cms_reportable_flag = TRUE THEN 1 END)
      comment: "Count of CMS-reportable sanctions for federal compliance reporting."
    - name: "ncqa_reportable_sanction_count"
      expr: COUNT(CASE WHEN ncqa_reportable_flag = TRUE THEN 1 END)
      comment: "Count of NCQA-reportable sanctions for accreditation compliance."
    - name: "unresolved_sanction_count"
      expr: COUNT(CASE WHEN resolution_date IS NULL AND current_record_flag = TRUE THEN 1 END)
      comment: "Count of unresolved current sanctions for active risk monitoring."
    - name: "exclusion_waiver_count"
      expr: COUNT(CASE WHEN exclusion_waiver_flag = TRUE THEN 1 END)
      comment: "Count of sanctions with exclusion waivers for exception tracking."
    - name: "notification_sent_count"
      expr: COUNT(CASE WHEN notification_sent_flag = TRUE THEN 1 END)
      comment: "Count of sanctions where notification was sent for communication compliance."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`provider_exclusion_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Exclusion screening metrics for OIG/SAM compliance, screening timeliness, and match rate analysis supporting federal and state regulatory requirements."
  source: "`health_insurance_ecm`.`provider`.`exclusion_screening`"
  dimensions:
    - name: "screening_result"
      expr: screening_result
      comment: "Screening outcome (match, no match, pending) for hit rate analysis."
    - name: "screening_source"
      expr: screening_source
      comment: "Database screened (OIG LEIE, SAM, state) for source coverage tracking."
    - name: "exclusion_type"
      expr: exclusion_type
      comment: "Type of exclusion for categorized risk analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the screening for operational tracking."
    - name: "screening_method"
      expr: screening_method
      comment: "Method of screening (automated, manual) for process efficiency analysis."
    - name: "screening_frequency"
      expr: screening_frequency
      comment: "Frequency of screening (monthly, quarterly) for compliance cadence tracking."
    - name: "match_type"
      expr: match_type
      comment: "Type of match (exact, partial, fuzzy) for false positive analysis."
    - name: "screening_vendor"
      expr: screening_vendor
      comment: "Vendor performing screening for vendor performance tracking."
    - name: "cms_reporting_flag"
      expr: CAST(cms_reporting_flag AS STRING)
      comment: "Whether screening is CMS-reportable for federal compliance."
    - name: "screening_year"
      expr: YEAR(screening_date)
      comment: "Year of screening for trend and volume analysis."
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total screening records for compliance volume tracking."
    - name: "distinct_screened_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct providers screened for coverage rate analysis."
    - name: "match_found_count"
      expr: COUNT(CASE WHEN screening_result = 'Match Found' THEN 1 END)
      comment: "Count of screenings with matches for exclusion hit rate."
    - name: "no_match_count"
      expr: COUNT(CASE WHEN screening_result = 'No Match' THEN 1 END)
      comment: "Count of clean screenings for compliance assurance."
    - name: "cms_reportable_screening_count"
      expr: COUNT(CASE WHEN cms_reporting_flag = TRUE THEN 1 END)
      comment: "Count of CMS-reportable screenings for federal compliance."
    - name: "unresolved_exclusion_count"
      expr: COUNT(CASE WHEN resolution_date IS NULL AND screening_result = 'Match Found' THEN 1 END)
      comment: "Count of unresolved exclusion matches for active risk monitoring."
    - name: "audit_flagged_count"
      expr: COUNT(CASE WHEN audit_flag = TRUE THEN 1 END)
      comment: "Count of screenings flagged for audit for quality assurance."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`provider_specialty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider specialty metrics for network adequacy, board certification rates, and specialty composition analysis supporting CMS and NCQA requirements."
  source: "`health_insurance_ecm`.`provider`.`specialty`"
  dimensions:
    - name: "specialty_name"
      expr: specialty_name
      comment: "Name of medical specialty for network composition analysis."
    - name: "specialty_category"
      expr: specialty_category
      comment: "Broad specialty category for high-level network adequacy."
    - name: "specialty_type"
      expr: specialty_type
      comment: "Type of specialty (primary, sub-specialty) for depth analysis."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status for the specialty for compliance tracking."
    - name: "board_certified_flag"
      expr: CAST(board_certified_flag AS STRING)
      comment: "Whether provider is board certified in this specialty."
    - name: "pcp_eligible_flag"
      expr: CAST(pcp_eligible_flag AS STRING)
      comment: "Whether specialty qualifies as PCP for primary care adequacy."
    - name: "telehealth_enabled_flag"
      expr: CAST(telehealth_enabled_flag AS STRING)
      comment: "Whether telehealth is enabled for this specialty."
    - name: "network_adequacy_category"
      expr: network_adequacy_category
      comment: "Network adequacy classification for regulatory reporting."
    - name: "certifying_board_name"
      expr: certifying_board_name
      comment: "Name of certifying board for credential verification tracking."
    - name: "hedis_specialty_flag"
      expr: CAST(hedis_specialty_flag AS STRING)
      comment: "Whether specialty is HEDIS-relevant for quality measure attribution."
    - name: "current_record_flag"
      expr: CAST(current_record_flag AS STRING)
      comment: "Whether this is the current specialty record."
  measures:
    - name: "total_specialty_records"
      expr: COUNT(1)
      comment: "Total specialty assignment records for volume tracking."
    - name: "distinct_providers_with_specialty"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct providers with specialty assignments for headcount."
    - name: "board_certified_specialty_count"
      expr: COUNT(CASE WHEN board_certified_flag = TRUE THEN 1 END)
      comment: "Count of board-certified specialty assignments for quality benchmarking."
    - name: "pcp_eligible_specialty_count"
      expr: COUNT(CASE WHEN pcp_eligible_flag = TRUE THEN 1 END)
      comment: "Count of PCP-eligible specialty records for primary care access."
    - name: "telehealth_enabled_specialty_count"
      expr: COUNT(CASE WHEN telehealth_enabled_flag = TRUE THEN 1 END)
      comment: "Count of telehealth-enabled specialties for virtual care capacity."
    - name: "hedis_specialty_count"
      expr: COUNT(CASE WHEN hedis_specialty_flag = TRUE THEN 1 END)
      comment: "Count of HEDIS-relevant specialty records for quality measure attribution."
    - name: "distinct_specialty_names"
      expr: COUNT(DISTINCT specialty_name)
      comment: "Number of distinct specialties for network breadth assessment."
    - name: "fellowship_completed_count"
      expr: COUNT(CASE WHEN fellowship_completed_flag = TRUE THEN 1 END)
      comment: "Count of providers with completed fellowships for advanced training tracking."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`provider_directory_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider directory entry metrics for directory accuracy, completeness, and compliance with CMS No Surprises Act and state directory accuracy requirements."
  source: "`health_insurance_ecm`.`provider`.`directory_entry`"
  dimensions:
    - name: "participation_status"
      expr: participation_status
      comment: "Directory participation status for active listing tracking."
    - name: "attestation_status"
      expr: attestation_status
      comment: "Provider attestation status for directory accuracy compliance."
    - name: "provider_type"
      expr: provider_type
      comment: "Provider type in directory for composition analysis."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier displayed in directory for tiered network reporting."
    - name: "practice_state"
      expr: practice_state
      comment: "State of practice location for geographic directory analysis."
    - name: "gender"
      expr: gender
      comment: "Provider gender in directory for diversity and access reporting."
    - name: "pcp_flag"
      expr: CAST(pcp_flag AS STRING)
      comment: "Whether listed as PCP for primary care directory accuracy."
    - name: "telehealth_available_flag"
      expr: CAST(telehealth_available_flag AS STRING)
      comment: "Whether telehealth is available for virtual care directory accuracy."
    - name: "accepting_new_patients_flag"
      expr: CAST(accepting_new_patients_flag AS STRING)
      comment: "Whether accepting new patients for member access accuracy."
    - name: "source_system"
      expr: source_system
      comment: "Source system of directory data for data lineage tracking."
  measures:
    - name: "total_directory_entries"
      expr: COUNT(1)
      comment: "Total directory entries for directory size tracking."
    - name: "distinct_directory_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct providers in directory for unduplicated directory headcount."
    - name: "accepting_new_patients_count"
      expr: COUNT(CASE WHEN accepting_new_patients_flag = TRUE THEN 1 END)
      comment: "Count of directory entries accepting new patients for access reporting."
    - name: "telehealth_available_count"
      expr: COUNT(CASE WHEN telehealth_available_flag = TRUE THEN 1 END)
      comment: "Count of directory entries with telehealth for virtual care access."
    - name: "pcp_directory_count"
      expr: COUNT(CASE WHEN pcp_flag = TRUE THEN 1 END)
      comment: "Count of PCP directory entries for primary care access adequacy."
    - name: "attested_entry_count"
      expr: COUNT(CASE WHEN attestation_status = 'Attested' THEN 1 END)
      comment: "Count of attested directory entries for compliance with directory accuracy rules."
    - name: "distinct_practice_states"
      expr: COUNT(DISTINCT practice_state)
      comment: "Number of distinct states with directory entries for geographic coverage."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`provider_outreach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider outreach and directory verification metrics tracking contact success rates, data verification outcomes, and attestation compliance for CMS and state directory accuracy mandates."
  source: "`health_insurance_ecm`.`provider`.`provider_outreach`"
  dimensions:
    - name: "outreach_method"
      expr: outreach_method
      comment: "Method of outreach (phone, email, fax, mail) for channel effectiveness analysis."
    - name: "outreach_type"
      expr: outreach_type
      comment: "Type of outreach (verification, attestation, update) for purpose tracking."
    - name: "outreach_status"
      expr: outreach_status
      comment: "Current status of outreach for pipeline tracking."
    - name: "outcome"
      expr: outcome
      comment: "Outreach outcome for success rate analysis."
    - name: "purpose"
      expr: purpose
      comment: "Purpose of outreach for categorized analysis."
    - name: "compliance_quarter"
      expr: compliance_quarter
      comment: "Compliance quarter for regulatory period tracking."
    - name: "current_record_flag"
      expr: CAST(current_record_flag AS STRING)
      comment: "Whether this is the current outreach record."
    - name: "outreach_year"
      expr: YEAR(outreach_date)
      comment: "Year of outreach for trend analysis."
  measures:
    - name: "total_outreach_attempts"
      expr: COUNT(1)
      comment: "Total outreach attempts for volume and effort tracking."
    - name: "distinct_providers_contacted"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct providers contacted for coverage rate analysis."
    - name: "contact_reached_count"
      expr: COUNT(CASE WHEN contact_reached_flag = TRUE THEN 1 END)
      comment: "Count of outreach where contact was reached for success rate."
    - name: "data_verified_count"
      expr: COUNT(CASE WHEN data_verified_flag = TRUE THEN 1 END)
      comment: "Count of outreach where data was verified for accuracy compliance."
    - name: "attestation_received_count"
      expr: COUNT(CASE WHEN attestation_received_flag = TRUE THEN 1 END)
      comment: "Count of outreach with attestation received for compliance tracking."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END)
      comment: "Count of outreach requiring follow-up for workload planning."
    - name: "directory_removal_flagged_count"
      expr: COUNT(CASE WHEN directory_removal_flag = TRUE THEN 1 END)
      comment: "Count of outreach flagging directory removal for data quality action."
    - name: "data_updated_count"
      expr: COUNT(CASE WHEN data_updated_flag = TRUE THEN 1 END)
      comment: "Count of outreach resulting in data updates for directory improvement tracking."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`provider_npi_registry_sync`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NPI registry synchronization metrics tracking NPPES data discrepancies, sync status, and data quality for provider directory accuracy and claims submission integrity."
  source: "`health_insurance_ecm`.`provider`.`npi_registry_sync`"
  dimensions:
    - name: "sync_status"
      expr: sync_status
      comment: "Status of NPI sync operation for pipeline monitoring."
    - name: "match_status"
      expr: match_status
      comment: "NPI match status for data quality tracking."
    - name: "sync_source"
      expr: sync_source
      comment: "Source of sync data for data lineage."
    - name: "name_discrepancy_flag"
      expr: CAST(name_discrepancy_flag AS STRING)
      comment: "Whether name discrepancy exists for data quality flagging."
    - name: "address_discrepancy_flag"
      expr: CAST(address_discrepancy_flag AS STRING)
      comment: "Whether address discrepancy exists for directory accuracy."
    - name: "taxonomy_discrepancy_flag"
      expr: CAST(taxonomy_discrepancy_flag AS STRING)
      comment: "Whether taxonomy discrepancy exists for specialty accuracy."
    - name: "credential_discrepancy_flag"
      expr: CAST(credential_discrepancy_flag AS STRING)
      comment: "Whether credential discrepancy exists for credentialing accuracy."
    - name: "manual_review_required_flag"
      expr: CAST(manual_review_required_flag AS STRING)
      comment: "Whether manual review is required for workload tracking."
    - name: "claims_submission_risk_flag"
      expr: CAST(claims_submission_risk_flag AS STRING)
      comment: "Whether claims submission risk exists for revenue cycle impact."
    - name: "sync_run_year"
      expr: YEAR(sync_run_date)
      comment: "Year of sync run for trend analysis."
  measures:
    - name: "total_sync_records"
      expr: COUNT(1)
      comment: "Total NPI sync records for volume tracking."
    - name: "distinct_synced_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct providers synced for coverage tracking."
    - name: "name_discrepancy_count"
      expr: COUNT(CASE WHEN name_discrepancy_flag = TRUE THEN 1 END)
      comment: "Count of name discrepancies for data quality remediation."
    - name: "address_discrepancy_count"
      expr: COUNT(CASE WHEN address_discrepancy_flag = TRUE THEN 1 END)
      comment: "Count of address discrepancies for directory accuracy remediation."
    - name: "taxonomy_discrepancy_count"
      expr: COUNT(CASE WHEN taxonomy_discrepancy_flag = TRUE THEN 1 END)
      comment: "Count of taxonomy discrepancies for specialty accuracy."
    - name: "manual_review_required_count"
      expr: COUNT(CASE WHEN manual_review_required_flag = TRUE THEN 1 END)
      comment: "Count of records requiring manual review for workload planning."
    - name: "claims_risk_count"
      expr: COUNT(CASE WHEN claims_submission_risk_flag = TRUE THEN 1 END)
      comment: "Count of records with claims submission risk for revenue cycle protection."
    - name: "any_discrepancy_count"
      expr: COUNT(CASE WHEN name_discrepancy_flag = TRUE OR address_discrepancy_flag = TRUE OR taxonomy_discrepancy_flag = TRUE OR credential_discrepancy_flag = TRUE THEN 1 END)
      comment: "Count of records with any discrepancy for overall data quality monitoring."
    - name: "auto_applied_update_count"
      expr: COUNT(CASE WHEN auto_applied_update_flag = TRUE THEN 1 END)
      comment: "Count of auto-applied updates for automation effectiveness tracking."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`provider_practice_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Practice location metrics for geographic access analysis, ADA compliance, telehealth availability, and network adequacy supporting CMS time/distance standards."
  source: "`health_insurance_ecm`.`provider`.`practice_location`"
  dimensions:
    - name: "location_type"
      expr: location_type
      comment: "Type of practice location for network composition."
    - name: "participation_status"
      expr: participation_status
      comment: "Location participation status for active network tracking."
    - name: "state_code"
      expr: state_code
      comment: "State of practice location for geographic adequacy."
    - name: "city"
      expr: city
      comment: "City of practice location for local access analysis."
    - name: "county_name"
      expr: county_name
      comment: "County for rural/urban access classification."
    - name: "accepting_new_patients_flag"
      expr: CAST(accepting_new_patients_flag AS STRING)
      comment: "Whether location accepts new patients for access reporting."
    - name: "telehealth_available_flag"
      expr: CAST(telehealth_available_flag AS STRING)
      comment: "Whether telehealth is available at location for virtual care access."
    - name: "wheelchair_accessible_flag"
      expr: CAST(wheelchair_accessible_flag AS STRING)
      comment: "Whether location is wheelchair accessible for ADA compliance."
    - name: "ada_compliant_flag"
      expr: CAST(ada_compliant_flag AS STRING)
      comment: "Whether location is ADA compliant for accessibility reporting."
    - name: "record_status"
      expr: record_status
      comment: "Record status for data quality tracking."
  measures:
    - name: "total_practice_locations"
      expr: COUNT(1)
      comment: "Total practice locations for network size tracking."
    - name: "active_location_count"
      expr: COUNT(CASE WHEN participation_status = 'Active' THEN 1 END)
      comment: "Count of active practice locations for current network adequacy."
    - name: "accepting_new_patients_location_count"
      expr: COUNT(CASE WHEN accepting_new_patients_flag = TRUE THEN 1 END)
      comment: "Count of locations accepting new patients for member access."
    - name: "telehealth_available_location_count"
      expr: COUNT(CASE WHEN telehealth_available_flag = TRUE THEN 1 END)
      comment: "Count of telehealth-available locations for virtual care access."
    - name: "ada_compliant_location_count"
      expr: COUNT(CASE WHEN ada_compliant_flag = TRUE THEN 1 END)
      comment: "Count of ADA-compliant locations for accessibility compliance."
    - name: "wheelchair_accessible_location_count"
      expr: COUNT(CASE WHEN wheelchair_accessible_flag = TRUE THEN 1 END)
      comment: "Count of wheelchair-accessible locations for accessibility reporting."
    - name: "distinct_location_states"
      expr: COUNT(DISTINCT state_code)
      comment: "Number of distinct states with practice locations for geographic coverage."
    - name: "distinct_location_counties"
      expr: COUNT(DISTINCT county_name)
      comment: "Number of distinct counties for granular geographic adequacy."
    - name: "distinct_providers_at_locations"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct providers with practice locations for network headcount."
$$;