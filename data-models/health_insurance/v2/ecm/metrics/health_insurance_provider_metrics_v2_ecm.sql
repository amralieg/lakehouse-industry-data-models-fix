-- Metric views for domain: provider | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 00:30:14

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_network_participation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs measuring provider network participation health, reimbursement economics, credentialing currency, and panel capacity utilization. Used by Network Management and Finance leadership to steer network adequacy, contract performance, and provider panel strategy."
  source: "`vibe_health_insurance_v1`.`provider`.`provider_network_participation`"
  dimensions:
    - name: "participation_status"
      expr: participation_status
      comment: "Current participation status of the provider in the network (e.g., Active, Terminated, Pending)."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier assignment (e.g., Tier 1, Tier 2) used for benefit design and cost-sharing differentiation."
    - name: "contracted_reimbursement_model"
      expr: contracted_reimbursement_model
      comment: "Reimbursement model type (e.g., FFS, Capitation, VBC) driving financial exposure analysis."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Current credentialing status of the provider, critical for compliance and claims adjudication eligibility."
    - name: "par_status"
      expr: par_status
      comment: "Participating vs. non-participating indicator, directly affecting member cost-sharing and claims routing."
    - name: "specialty_code"
      expr: specialty_code
      comment: "Provider specialty code enabling network adequacy analysis by specialty type."
    - name: "service_area_code"
      expr: service_area_code
      comment: "Geographic service area code for regional network adequacy and access standard reporting."
    - name: "vbc_participation_flag"
      expr: vbc_participation_flag
      comment: "Indicates whether the provider participates in a value-based care arrangement."
    - name: "is_pcp"
      expr: is_pcp
      comment: "Flags primary care providers, enabling PCP panel capacity and access analysis."
    - name: "participation_effective_date_month"
      expr: DATE_TRUNC('MONTH', participation_effective_date)
      comment: "Month of participation effective date for trend analysis of network growth."
  measures:
    - name: "total_participating_providers"
      expr: COUNT(DISTINCT provider_network_participation_id)
      comment: "Total number of active network participation records. Core network size KPI used in adequacy assessments and regulatory filings."
    - name: "avg_reimbursement_rate"
      expr: AVG(CAST(reimbursement_rate AS DOUBLE))
      comment: "Average contracted reimbursement rate across participating providers. Drives financial modeling and contract benchmarking decisions."
    - name: "total_capitation_rate_exposure"
      expr: SUM(CAST(capitation_rate AS DOUBLE))
      comment: "Total capitation rate commitment across all capitated provider arrangements. Critical for actuarial reserve and PMPM cost projections."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average provider quality score across the network. Used by Medical Management and Network teams to steer quality improvement programs and tiering decisions."
    - name: "pct_accepting_new_patients"
      expr: ROUND(100.0 * SUM(CASE WHEN is_accepting_new_patients = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of network providers currently accepting new patients. A key access standard metric monitored by regulators and used to identify panel capacity gaps."
    - name: "pct_credentialing_current"
      expr: ROUND(100.0 * SUM(CASE WHEN credentialing_status = 'Active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers with current/active credentialing status. Compliance risk indicator — lapsed credentialing can trigger claims denials and regulatory penalties."
    - name: "pct_vbc_participating"
      expr: ROUND(100.0 * SUM(CASE WHEN vbc_participation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of network providers enrolled in value-based care arrangements. Strategic KPI tracking VBC transformation progress reported to executive leadership."
    - name: "pct_par_providers"
      expr: ROUND(100.0 * SUM(CASE WHEN par_status_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers with participating (PAR) status. Affects member out-of-pocket costs and claims adjudication routing; monitored in network adequacy reports."
    - name: "providers_with_attestation"
      expr: COUNT(CASE WHEN network_participation_attestation_flag = TRUE THEN provider_network_participation_id END)
      comment: "Count of providers with a completed network participation attestation. Regulatory compliance metric for CMS and state directory accuracy requirements."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_participation_status`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs tracking provider participation status across health plans and networks, including panel management, credentialing compliance, and termination trends. Used by Network Operations and Compliance teams."
  source: "`vibe_health_insurance_v1`.`provider`.`participation_status`"
  dimensions:
    - name: "participation_status_code"
      expr: participation_status_code
      comment: "Standardized participation status code (e.g., Active, Terminated, Suspended) for network roster management."
    - name: "participation_category"
      expr: participation_category
      comment: "Category of participation (e.g., PCP, Specialist, Facility) for segmented network analysis."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code (e.g., Commercial, Medicare, Medicaid) enabling cross-LOB network adequacy comparison."
    - name: "network_tier_code"
      expr: network_tier_code
      comment: "Network tier code for tiered network benefit design analysis."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status at time of participation record, used for compliance monitoring."
    - name: "pcp_flag"
      expr: pcp_flag
      comment: "Identifies primary care providers for PCP panel capacity and access reporting."
    - name: "panel_status"
      expr: panel_status
      comment: "Panel open/closed status indicating whether the provider is accepting new member assignments."
    - name: "termination_reason_code"
      expr: termination_reason_code
      comment: "Reason code for participation termination, used to analyze voluntary vs. involuntary attrition."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of participation effective date for network growth trend analysis."
  measures:
    - name: "total_participation_records"
      expr: COUNT(DISTINCT participation_status_id)
      comment: "Total provider participation records across all health plans and networks. Baseline network roster size metric."
    - name: "active_participating_providers"
      expr: COUNT(CASE WHEN current_record_flag = TRUE AND participation_status_code = 'Active' THEN participation_status_id END)
      comment: "Count of currently active participating providers. Core network adequacy metric used in regulatory filings and executive dashboards."
    - name: "pct_open_panel"
      expr: ROUND(100.0 * SUM(CASE WHEN panel_status = 'Open' THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN current_record_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active providers with open panels. Access standard KPI — low open panel rates trigger network adequacy interventions."
    - name: "pct_with_regulatory_sanction"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_sanction_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of participation records flagged with a regulatory sanction. Compliance risk KPI requiring immediate executive attention when elevated."
    - name: "providers_terminated_current_period"
      expr: COUNT(CASE WHEN termination_date IS NOT NULL AND current_record_flag = FALSE THEN participation_status_id END)
      comment: "Count of providers with a recorded termination date. Network attrition metric used to assess network stability and trigger recruitment actions."
    - name: "pct_directory_displayed"
      expr: ROUND(100.0 * SUM(CASE WHEN directory_display_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN current_record_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active providers displayed in the member-facing directory. CMS directory accuracy compliance metric with direct regulatory penalty exposure."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_sanction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring provider sanction activity, CMS/NCQA reportability, and resolution effectiveness. Used by Compliance, Legal, and Network Management to manage regulatory risk and provider exclusion obligations."
  source: "`vibe_health_insurance_v1`.`provider`.`sanction`"
  dimensions:
    - name: "sanction_type"
      expr: sanction_type
      comment: "Type of sanction (e.g., Exclusion, Suspension, Probation) for risk stratification."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the sanction, used to prioritize compliance response and escalation."
    - name: "participation_impact"
      expr: participation_impact
      comment: "Describes the impact on provider network participation status resulting from the sanction."
    - name: "cms_reportable_flag"
      expr: cms_reportable_flag
      comment: "Indicates whether the sanction must be reported to CMS, a critical regulatory compliance flag."
    - name: "ncqa_reportable_flag"
      expr: ncqa_reportable_flag
      comment: "Indicates whether the sanction must be reported to NCQA for accreditation compliance."
    - name: "screening_source"
      expr: screening_source
      comment: "Source of the sanction screening (e.g., OIG, SAM, State) for data provenance and audit trails."
    - name: "sanction_date_month"
      expr: DATE_TRUNC('MONTH', sanction_date)
      comment: "Month of sanction date for trend analysis of sanction volume over time."
    - name: "current_record_flag"
      expr: current_record_flag
      comment: "Flags the current active sanction record for point-in-time roster accuracy."
  measures:
    - name: "total_sanctions"
      expr: COUNT(DISTINCT sanction_id)
      comment: "Total number of provider sanctions recorded. Baseline compliance risk metric tracked by Compliance and Legal leadership."
    - name: "active_sanctions"
      expr: COUNT(CASE WHEN current_record_flag = TRUE AND record_end_date IS NULL THEN sanction_id END)
      comment: "Count of currently active sanctions with no end date. Immediate compliance risk exposure metric requiring executive oversight."
    - name: "cms_reportable_sanctions"
      expr: COUNT(CASE WHEN cms_reportable_flag = TRUE THEN sanction_id END)
      comment: "Count of sanctions requiring CMS reporting. Regulatory obligation metric — failure to report triggers significant federal penalties."
    - name: "pct_resolved_sanctions"
      expr: ROUND(100.0 * COUNT(CASE WHEN resolution_date IS NOT NULL THEN sanction_id END) / NULLIF(COUNT(DISTINCT sanction_id), 0), 2)
      comment: "Percentage of sanctions with a recorded resolution date. Compliance program effectiveness KPI — low resolution rates indicate systemic remediation failures."
    - name: "pct_notification_sent"
      expr: ROUND(100.0 * SUM(CASE WHEN notification_sent_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sanctions for which member/provider notification was sent. Regulatory notification compliance rate with direct CMS audit exposure."
    - name: "sanctions_with_waiver"
      expr: COUNT(CASE WHEN exclusion_waiver_flag = TRUE THEN sanction_id END)
      comment: "Count of sanctions where an exclusion waiver was granted. Risk management metric — elevated waiver counts require executive review of waiver policy."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_exclusion_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring provider exclusion screening program coverage, compliance status, and resolution effectiveness. Used by Compliance and Network Operations to meet OIG/SAM screening mandates and manage exclusion risk."
  source: "`vibe_health_insurance_v1`.`provider`.`exclusion_screening`"
  dimensions:
    - name: "screening_result"
      expr: screening_result
      comment: "Outcome of the exclusion screening (e.g., Clear, Match, Pending Review) for compliance triage."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status of the screening record, used for regulatory reporting."
    - name: "exclusion_type"
      expr: exclusion_type
      comment: "Type of exclusion identified (e.g., OIG, State Medicaid) for risk stratification."
    - name: "screening_source"
      expr: screening_source
      comment: "Source database screened (e.g., OIG LEIE, SAM.gov) for audit trail and coverage analysis."
    - name: "screening_frequency"
      expr: screening_frequency
      comment: "Frequency of screening (e.g., Monthly, Quarterly) for program design evaluation."
    - name: "cms_reporting_flag"
      expr: cms_reporting_flag
      comment: "Indicates whether the screening result requires CMS reporting."
    - name: "screening_date_month"
      expr: DATE_TRUNC('MONTH', screening_date)
      comment: "Month of screening date for trend analysis of screening program activity."
  measures:
    - name: "total_screenings"
      expr: COUNT(DISTINCT exclusion_screening_id)
      comment: "Total number of exclusion screenings performed. Program coverage metric used to demonstrate OIG compliance to regulators."
    - name: "exclusion_match_count"
      expr: COUNT(CASE WHEN screening_result = 'Match' THEN exclusion_screening_id END)
      comment: "Count of screenings resulting in an exclusion match. Critical compliance risk metric — each match requires immediate participation termination action."
    - name: "pct_exclusion_match_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN screening_result = 'Match' THEN exclusion_screening_id END) / NULLIF(COUNT(DISTINCT exclusion_screening_id), 0), 2)
      comment: "Percentage of screenings resulting in an exclusion match. Benchmark metric for assessing network exclusion risk concentration."
    - name: "pct_resolved_exclusions"
      expr: ROUND(100.0 * COUNT(CASE WHEN resolution_date IS NOT NULL THEN exclusion_screening_id END) / NULLIF(COUNT(CASE WHEN screening_result = 'Match' THEN exclusion_screening_id END), 0), 2)
      comment: "Percentage of exclusion matches with a recorded resolution. Compliance program effectiveness KPI — unresolved matches create federal fraud and abuse liability."
    - name: "cms_reportable_screenings"
      expr: COUNT(CASE WHEN cms_reporting_flag = TRUE THEN exclusion_screening_id END)
      comment: "Count of screenings flagged for CMS reporting. Regulatory obligation metric ensuring federal reporting mandates are met."
    - name: "overdue_screenings"
      expr: COUNT(CASE WHEN next_screening_due_date < CURRENT_DATE() THEN exclusion_screening_id END)
      comment: "Count of providers whose next scheduled screening is past due. Compliance gap metric — overdue screenings create OIG audit exposure and potential False Claims Act liability."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring provider license currency, expiration risk, disciplinary action rates, and primary source verification compliance. Used by Credentialing and Compliance teams to manage licensure risk and meet NCQA/URAC standards."
  source: "`vibe_health_insurance_v1`.`provider`.`license`"
  dimensions:
    - name: "license_type"
      expr: license_type
      comment: "Type of license (e.g., MD, DO, NP, PA) for specialty-specific compliance analysis."
    - name: "license_status"
      expr: license_status
      comment: "Current status of the license (e.g., Active, Expired, Suspended) for compliance triage."
    - name: "issuing_state"
      expr: issuing_state
      comment: "State that issued the license, enabling geographic compliance gap analysis."
    - name: "disciplinary_action_flag"
      expr: disciplinary_action_flag
      comment: "Indicates whether a disciplinary action has been recorded against this license."
    - name: "compact_participation_flag"
      expr: compact_participation_flag
      comment: "Indicates participation in an interstate compact (e.g., NLC), relevant for telehealth and multi-state practice."
    - name: "telemedicine_authorized_flag"
      expr: telemedicine_authorized_flag
      comment: "Indicates whether the license authorizes telemedicine practice, critical for telehealth network adequacy."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month of license expiration for proactive renewal pipeline management."
  measures:
    - name: "total_licenses"
      expr: COUNT(DISTINCT license_id)
      comment: "Total number of provider licenses on file. Baseline credentialing inventory metric."
    - name: "active_licenses"
      expr: COUNT(CASE WHEN license_status = 'Active' AND record_current_flag = TRUE THEN license_id END)
      comment: "Count of currently active licenses. Core credentialing compliance metric — providers must hold active licenses to participate in the network."
    - name: "expired_licenses"
      expr: COUNT(CASE WHEN expiration_date < CURRENT_DATE() AND license_status != 'Renewed' THEN license_id END)
      comment: "Count of licenses past their expiration date. Immediate compliance risk metric — expired licenses trigger claims adjudication failures and regulatory sanctions."
    - name: "licenses_expiring_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN license_id END)
      comment: "Count of licenses expiring within 90 days. Proactive renewal pipeline metric used by Credentialing Operations to prioritize outreach."
    - name: "pct_with_disciplinary_action"
      expr: ROUND(100.0 * SUM(CASE WHEN disciplinary_action_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT license_id), 0), 2)
      comment: "Percentage of licenses with a recorded disciplinary action. Quality and risk metric — elevated rates require Medical Staff Committee review and potential network action."
    - name: "pct_primary_source_verified"
      expr: ROUND(100.0 * COUNT(CASE WHEN primary_source_verification_date IS NOT NULL THEN license_id END) / NULLIF(COUNT(DISTINCT license_id), 0), 2)
      comment: "Percentage of licenses with completed primary source verification. NCQA credentialing standard compliance metric — below threshold triggers accreditation risk."
    - name: "avg_continuing_education_hours_required"
      expr: AVG(CAST(continuing_education_hours_required AS DOUBLE))
      comment: "Average continuing education hours required across licensed providers. Workforce development planning metric for CME program design."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_specialty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring provider specialty distribution, board certification rates, credentialing currency, and network adequacy by specialty. Used by Network Management and Medical Affairs to ensure specialty access standards and HEDIS compliance."
  source: "`vibe_health_insurance_v1`.`provider`.`specialty`"
  dimensions:
    - name: "specialty_name"
      expr: specialty_name
      comment: "Provider specialty name for network adequacy analysis by specialty type."
    - name: "specialty_category"
      expr: specialty_category
      comment: "Broad specialty category (e.g., Primary Care, Behavioral Health, Surgery) for portfolio-level analysis."
    - name: "specialty_type"
      expr: specialty_type
      comment: "Specialty type classification for regulatory and adequacy reporting."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status for this specialty, used to identify compliance gaps."
    - name: "board_certified_flag"
      expr: board_certified_flag
      comment: "Indicates board certification status, a quality differentiator used in tiered network design."
    - name: "pcp_eligible_flag"
      expr: pcp_eligible_flag
      comment: "Indicates whether this specialty qualifies for PCP designation, relevant for PCP panel adequacy."
    - name: "hedis_specialty_flag"
      expr: hedis_specialty_flag
      comment: "Flags specialties relevant to HEDIS measure compliance, used in quality program targeting."
    - name: "network_adequacy_category"
      expr: network_adequacy_category
      comment: "Network adequacy category assignment for regulatory time-distance standard reporting."
    - name: "telehealth_enabled_flag"
      expr: telehealth_enabled_flag
      comment: "Indicates whether the provider offers telehealth services for this specialty."
  measures:
    - name: "total_specialty_records"
      expr: COUNT(DISTINCT specialty_id)
      comment: "Total specialty records on file. Baseline metric for specialty inventory and network breadth assessment."
    - name: "board_certified_providers"
      expr: COUNT(CASE WHEN board_certified_flag = TRUE AND current_record_flag = TRUE THEN specialty_id END)
      comment: "Count of providers with active board certification. Quality network metric — board certification rates influence tiering decisions and member satisfaction."
    - name: "pct_board_certified"
      expr: ROUND(100.0 * SUM(CASE WHEN board_certified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN current_record_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active specialty records with board certification. Quality benchmark used in NCQA accreditation and network tiering strategy."
    - name: "pct_credentialing_active"
      expr: ROUND(100.0 * SUM(CASE WHEN credentialing_status = 'Active' THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN current_record_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active specialty records with current credentialing. Compliance metric — lapsed credentialing by specialty creates claims adjudication and regulatory risk."
    - name: "hedis_relevant_specialties"
      expr: COUNT(CASE WHEN hedis_specialty_flag = TRUE AND current_record_flag = TRUE THEN specialty_id END)
      comment: "Count of active providers in HEDIS-relevant specialties. Quality program planning metric used to assess HEDIS measure compliance capacity."
    - name: "pct_telehealth_enabled"
      expr: ROUND(100.0 * SUM(CASE WHEN telehealth_enabled_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN current_record_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active specialty records with telehealth enabled. Access and innovation metric — low telehealth rates may trigger network adequacy concerns for rural populations."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring facility network composition, quality ratings, credentialing status, and service capability. Used by Network Management and Quality teams to manage facility adequacy, accreditation compliance, and member access."
  source: "`vibe_health_insurance_v1`.`provider`.`facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (e.g., Hospital, SNF, ASC, Urgent Care) for network composition analysis."
    - name: "participation_status"
      expr: participation_status
      comment: "Current network participation status of the facility."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status of the facility, required for claims adjudication and network participation."
    - name: "state_code"
      expr: state_code
      comment: "State where the facility is located for geographic network adequacy analysis."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Facility ownership type (e.g., Non-profit, For-profit, Government) for strategic contracting analysis."
    - name: "teaching_hospital_flag"
      expr: teaching_hospital_flag
      comment: "Identifies teaching hospitals, which carry different reimbursement and quality profiles."
    - name: "critical_access_hospital_flag"
      expr: critical_access_hospital_flag
      comment: "Identifies Critical Access Hospitals with special Medicare reimbursement rules and rural access importance."
    - name: "emergency_services_flag"
      expr: emergency_services_flag
      comment: "Indicates whether the facility provides emergency services, critical for network adequacy standards."
    - name: "medicare_certified_flag"
      expr: medicare_certified_flag
      comment: "Indicates Medicare certification status, required for Medicare Advantage network participation."
  measures:
    - name: "total_facilities"
      expr: COUNT(DISTINCT facility_id)
      comment: "Total number of facilities in the network. Baseline facility network size metric for adequacy reporting."
    - name: "active_participating_facilities"
      expr: COUNT(CASE WHEN participation_status = 'Active' THEN facility_id END)
      comment: "Count of facilities with active participation status. Core network adequacy metric reported to regulators and used in member communications."
    - name: "avg_quality_rating"
      expr: AVG(CAST(quality_rating AS DOUBLE))
      comment: "Average quality rating across network facilities. Strategic quality metric used in tiered network design and member steerage programs."
    - name: "pct_credentialing_current"
      expr: ROUND(100.0 * COUNT(CASE WHEN credentialing_status = 'Active' THEN facility_id END) / NULLIF(COUNT(DISTINCT facility_id), 0), 2)
      comment: "Percentage of facilities with current credentialing. Compliance metric — lapsed facility credentialing creates claims adjudication failures and regulatory exposure."
    - name: "facilities_with_emergency_services"
      expr: COUNT(CASE WHEN emergency_services_flag = TRUE AND participation_status = 'Active' THEN facility_id END)
      comment: "Count of active network facilities offering emergency services. Network adequacy metric for CMS time-distance standards and state regulatory filings."
    - name: "pct_telehealth_enabled"
      expr: ROUND(100.0 * SUM(CASE WHEN telehealth_enabled_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT facility_id), 0), 2)
      comment: "Percentage of facilities with telehealth capabilities. Innovation and access metric used in product design and regulatory filings."
    - name: "pct_accepting_new_patients"
      expr: ROUND(100.0 * SUM(CASE WHEN accepting_new_patients_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN participation_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active facilities accepting new patients. Member access metric — low rates trigger network adequacy interventions and member complaints."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_npi_registry_sync`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring NPI registry synchronization quality, discrepancy rates, and directory accuracy risk. Used by Provider Data Management and Compliance teams to meet CMS directory accuracy mandates and reduce claims submission risk."
  source: "`vibe_health_insurance_v1`.`provider`.`npi_registry_sync`"
  dimensions:
    - name: "sync_status"
      expr: sync_status
      comment: "Status of the NPI registry sync operation (e.g., Success, Failed, Pending Review)."
    - name: "match_status"
      expr: match_status
      comment: "Match status between internal records and NPPES registry data."
    - name: "manual_review_required_flag"
      expr: manual_review_required_flag
      comment: "Indicates whether the sync record requires manual review due to discrepancies."
    - name: "directory_accuracy_impact_flag"
      expr: directory_accuracy_impact_flag
      comment: "Flags sync records where discrepancies impact directory accuracy, a CMS compliance concern."
    - name: "claims_submission_risk_flag"
      expr: claims_submission_risk_flag
      comment: "Flags records where NPI discrepancies create claims submission risk."
    - name: "sync_run_date_month"
      expr: DATE_TRUNC('MONTH', sync_run_date)
      comment: "Month of sync run date for trend analysis of data quality over time."
  measures:
    - name: "total_sync_records"
      expr: COUNT(DISTINCT npi_registry_sync_id)
      comment: "Total NPI registry sync records processed. Program coverage metric for provider data governance reporting."
    - name: "records_with_discrepancies"
      expr: COUNT(CASE WHEN address_discrepancy_flag = TRUE OR name_discrepancy_flag = TRUE OR taxonomy_discrepancy_flag = TRUE OR credential_discrepancy_flag = TRUE THEN npi_registry_sync_id END)
      comment: "Count of sync records with any type of discrepancy. Data quality risk metric — high discrepancy counts indicate systemic provider data integrity issues."
    - name: "pct_discrepancy_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN address_discrepancy_flag = TRUE OR name_discrepancy_flag = TRUE OR taxonomy_discrepancy_flag = TRUE OR credential_discrepancy_flag = TRUE THEN npi_registry_sync_id END) / NULLIF(COUNT(DISTINCT npi_registry_sync_id), 0), 2)
      comment: "Percentage of sync records with discrepancies. CMS directory accuracy compliance KPI — rates above threshold trigger regulatory penalties under the No Surprises Act."
    - name: "directory_accuracy_risk_records"
      expr: COUNT(CASE WHEN directory_accuracy_impact_flag = TRUE THEN npi_registry_sync_id END)
      comment: "Count of sync records with directory accuracy impact. Regulatory risk metric directly tied to CMS directory accuracy penalty exposure."
    - name: "claims_submission_risk_records"
      expr: COUNT(CASE WHEN claims_submission_risk_flag = TRUE THEN npi_registry_sync_id END)
      comment: "Count of records flagged for claims submission risk due to NPI discrepancies. Financial risk metric — NPI errors cause claims rejections and revenue leakage."
    - name: "pending_manual_review"
      expr: COUNT(CASE WHEN manual_review_required_flag = TRUE AND manual_review_completed_date IS NULL THEN npi_registry_sync_id END)
      comment: "Count of sync records requiring manual review that have not yet been completed. Operational backlog metric used to staff Provider Data Management teams."
    - name: "pct_auto_applied_updates"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_applied_update_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT npi_registry_sync_id), 0), 2)
      comment: "Percentage of sync updates automatically applied without manual intervention. Automation efficiency metric for provider data operations productivity."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_directory_verification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring provider directory verification program coverage, outcomes, and currency. Used by Provider Data Management and Compliance to meet CMS and state directory accuracy mandates."
  source: "`vibe_health_insurance_v1`.`provider`.`provider_directory_verification`"
  dimensions:
    - name: "verification_status"
      expr: verification_status
      comment: "Status of the directory verification (e.g., Verified, Failed, Pending) for compliance tracking."
    - name: "verification_outcome"
      expr: verification_outcome
      comment: "Outcome of the verification attempt (e.g., Confirmed, Updated, Unable to Reach) for quality analysis."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used for verification (e.g., Phone, Mail, Portal) for channel effectiveness analysis."
    - name: "current_record_flag"
      expr: current_record_flag
      comment: "Flags the most current verification record for point-in-time accuracy reporting."
    - name: "record_effective_date_month"
      expr: DATE_TRUNC('MONTH', record_effective_date)
      comment: "Month of verification effective date for trend analysis of verification program activity."
  measures:
    - name: "total_verifications"
      expr: COUNT(DISTINCT provider_directory_verification_id)
      comment: "Total directory verification records. Program coverage metric for CMS directory accuracy compliance reporting."
    - name: "successful_verifications"
      expr: COUNT(CASE WHEN verification_status = 'Verified' THEN provider_directory_verification_id END)
      comment: "Count of successfully completed verifications. Core directory accuracy compliance metric required by CMS and state regulators."
    - name: "pct_verification_success_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'Verified' THEN provider_directory_verification_id END) / NULLIF(COUNT(DISTINCT provider_directory_verification_id), 0), 2)
      comment: "Percentage of verification attempts resulting in successful verification. CMS directory accuracy compliance rate — below threshold triggers regulatory penalties."
    - name: "overdue_verifications"
      expr: COUNT(CASE WHEN next_verification_date < CURRENT_DATE() AND current_record_flag = TRUE THEN provider_directory_verification_id END)
      comment: "Count of providers whose next directory verification is past due. Compliance gap metric — overdue verifications create CMS directory accuracy penalty exposure."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_outreach_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring provider outreach campaign performance, budget efficiency, and audience reach. Used by Provider Relations and Network Development leadership to optimize outreach investment and campaign ROI."
  source: "`vibe_health_insurance_v1`.`provider`.`outreach_campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of outreach campaign (e.g., Recruitment, Retention, Directory Verification) for portfolio analysis."
    - name: "campaign_channel"
      expr: campaign_channel
      comment: "Communication channel used (e.g., Email, Phone, Mail) for channel effectiveness comparison."
    - name: "campaign_approval_status"
      expr: campaign_approval_status
      comment: "Approval status of the campaign for governance and spend authorization tracking."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the campaign (e.g., Planning, Active, Completed) for pipeline management."
    - name: "owner_department"
      expr: owner_department
      comment: "Department owning the campaign for cost allocation and accountability reporting."
    - name: "campaign_currency"
      expr: campaign_currency
      comment: "Currency of campaign budget and spend for multi-currency financial reporting."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month campaign became effective for trend analysis of outreach activity."
  measures:
    - name: "total_campaigns"
      expr: COUNT(DISTINCT outreach_campaign_id)
      comment: "Total number of provider outreach campaigns. Portfolio size metric for Provider Relations program management."
    - name: "total_campaign_budget"
      expr: SUM(CAST(campaign_budget AS DOUBLE))
      comment: "Total budgeted spend across all outreach campaigns. Financial planning metric for Provider Relations budget management."
    - name: "total_campaign_spend"
      expr: SUM(CAST(campaign_spend AS DOUBLE))
      comment: "Total actual spend across all outreach campaigns. Financial accountability metric compared against budget for variance analysis."
    - name: "avg_campaign_budget"
      expr: AVG(CAST(campaign_budget AS DOUBLE))
      comment: "Average budget per outreach campaign. Benchmarking metric for campaign investment sizing decisions."
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(campaign_spend AS DOUBLE)) / NULLIF(SUM(CAST(campaign_budget AS DOUBLE)), 0), 2)
      comment: "Percentage of campaign budget actually spent. Financial efficiency metric — significant under/over-spend triggers budget reallocation decisions."
    - name: "total_target_audience_size"
      expr: SUM(CAST(campaign_target_audience_size AS DOUBLE))
      comment: "Total number of providers targeted across all campaigns. Reach metric for assessing outreach program scale and coverage."
    - name: "avg_target_audience_income_range"
      expr: AVG(CAST(campaign_target_audience_income_range AS DOUBLE))
      comment: "Average income range of targeted provider audience. Segmentation metric for tailoring outreach messaging and channel strategy."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_audit_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring provider audit assignment volume, completion rates, and outcome distribution. Used by Compliance and Network Operations leadership to manage audit program effectiveness and regulatory obligation fulfillment."
  source: "`vibe_health_insurance_v1`.`provider`.`audit_assignment`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., Credentialing, Billing, Quality) for program-level analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (e.g., Assigned, In Progress, Completed) for workload management."
    - name: "audit_outcome"
      expr: audit_outcome
      comment: "Outcome of the completed audit (e.g., Pass, Fail, Conditional) for quality trend analysis."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Assignment status of the audit task for operational pipeline management."
    - name: "audit_scope"
      expr: audit_scope
      comment: "Scope of the audit for resource planning and risk stratification."
    - name: "assigned_date_month"
      expr: DATE_TRUNC('MONTH', assigned_date)
      comment: "Month of audit assignment for trend analysis of audit program activity."
  measures:
    - name: "total_audit_assignments"
      expr: COUNT(DISTINCT audit_assignment_id)
      comment: "Total number of provider audit assignments. Program volume metric for compliance program capacity planning."
    - name: "completed_audits"
      expr: COUNT(CASE WHEN is_completed = TRUE THEN audit_assignment_id END)
      comment: "Count of completed audit assignments. Program throughput metric used to assess compliance team productivity."
    - name: "pct_audit_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_completed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT audit_assignment_id), 0), 2)
      comment: "Percentage of audit assignments completed. Compliance program effectiveness KPI — low completion rates indicate resource gaps or process failures."
    - name: "overdue_audits"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE() AND is_completed = FALSE THEN audit_assignment_id END)
      comment: "Count of audit assignments past their due date and not yet completed. Compliance risk metric — overdue audits create regulatory obligation gaps."
    - name: "pct_overdue_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN due_date < CURRENT_DATE() AND is_completed = FALSE THEN audit_assignment_id END) / NULLIF(COUNT(DISTINCT audit_assignment_id), 0), 2)
      comment: "Percentage of audit assignments that are overdue. Operational efficiency and compliance risk KPI monitored by Compliance leadership."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_obligation_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring provider obligation compliance status, assessment currency, and remediation pipeline. Used by Compliance and Network Operations to manage provider regulatory obligation fulfillment and identify systemic compliance gaps."
  source: "`vibe_health_insurance_v1`.`provider`.`obligation_compliance`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory or contractual obligation (e.g., Credentialing, Reporting, Training) for compliance gap analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (e.g., Compliant, Non-Compliant, Pending) for risk triage."
    - name: "is_compliant"
      expr: is_compliant
      comment: "Boolean compliance indicator for quick dashboard filtering and alerting."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of compliance assessment for trend analysis of compliance program activity."
  measures:
    - name: "total_obligation_records"
      expr: COUNT(DISTINCT obligation_compliance_id)
      comment: "Total provider obligation compliance records. Baseline metric for compliance program scope and coverage."
    - name: "compliant_obligations"
      expr: COUNT(CASE WHEN is_compliant = TRUE THEN obligation_compliance_id END)
      comment: "Count of obligations currently in compliance. Core compliance program health metric reported to executive leadership."
    - name: "pct_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT obligation_compliance_id), 0), 2)
      comment: "Overall provider obligation compliance rate. Strategic compliance KPI — below-threshold rates trigger regulatory intervention and corrective action plans."
    - name: "overdue_remediation"
      expr: COUNT(CASE WHEN remediation_due_date < CURRENT_DATE() AND is_compliant = FALSE THEN obligation_compliance_id END)
      comment: "Count of non-compliant obligations with overdue remediation deadlines. Escalation metric requiring immediate Compliance leadership attention."
    - name: "obligations_due_for_review"
      expr: COUNT(CASE WHEN next_review_date <= DATE_ADD(CURRENT_DATE(), 30) THEN obligation_compliance_id END)
      comment: "Count of obligations due for review within 30 days. Proactive compliance management metric for workload planning."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_directory_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider directory entry metrics for directory accuracy, completeness, and compliance with CMS No Surprises Act and state directory accuracy requirements."
  source: "`vibe_health_insurance_v1`.`provider`.`directory_entry`"
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
  measures:
    - name: "total_directory_entries"
      expr: COUNT(1)
      comment: "Total directory entries for directory size tracking."
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

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_practice_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Practice location metrics for geographic access analysis, ADA compliance, telehealth availability, and network adequacy supporting CMS time/distance standards."
  source: "`vibe_health_insurance_v1`.`provider`.`practice_location`"
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

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`provider_outreach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider outreach and directory verification metrics tracking contact success rates, data verification outcomes, and attestation compliance for CMS and state directory accuracy mandates."
  source: "`vibe_health_insurance_v1`.`provider`.`provider_outreach`"
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