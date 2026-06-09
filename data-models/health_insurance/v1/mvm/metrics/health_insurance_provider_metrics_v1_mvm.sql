-- Metric views for domain: provider | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 21:18:32

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`provider`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core provider metrics tracking active provider counts, credentialing status, network participation, and board certification rates for workforce planning and quality assurance"
  source: "`health_insurance_ecm`.`provider`.`provider_provider`"
  dimensions:
    - name: "provider_type"
      expr: provider_type
      comment: "Type of provider (e.g., physician, nurse practitioner, physician assistant)"
    - name: "primary_specialty"
      expr: primary_specialty
      comment: "Primary specialty of the provider for specialty mix analysis"
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Current credentialing status (e.g., active, pending, expired) for compliance monitoring"
    - name: "participation_status"
      expr: participation_status
      comment: "Network participation status for network adequacy tracking"
    - name: "gender"
      expr: gender
      comment: "Provider gender for diversity reporting and patient preference matching"
    - name: "state"
      expr: state
      comment: "State where provider practices for geographic distribution analysis"
    - name: "board_certification_summary_status"
      expr: board_certification_summary_status
      comment: "Summary board certification status for quality metrics"
    - name: "network_participation_flag"
      expr: network_participation_flag
      comment: "Whether provider participates in network for adequacy calculations"
    - name: "malpractice_coverage_flag"
      expr: malpractice_coverage_flag
      comment: "Whether provider has malpractice coverage for risk management"
  measures:
    - name: "total_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Total unique providers for workforce capacity planning and network adequacy reporting"
    - name: "active_credentialed_providers"
      expr: COUNT(DISTINCT CASE WHEN credentialing_status = 'Active' THEN provider_id END)
      comment: "Count of actively credentialed providers for quality assurance and regulatory compliance"
    - name: "network_participating_providers"
      expr: COUNT(DISTINCT CASE WHEN network_participation_flag = TRUE THEN provider_id END)
      comment: "Count of providers participating in network for network adequacy calculations"
    - name: "board_certified_providers"
      expr: COUNT(DISTINCT CASE WHEN board_certification_summary_status = 'Certified' THEN provider_id END)
      comment: "Count of board-certified providers for quality metrics and HEDIS reporting"
    - name: "providers_with_malpractice_coverage"
      expr: COUNT(DISTINCT CASE WHEN malpractice_coverage_flag = TRUE THEN provider_id END)
      comment: "Count of providers with malpractice coverage for risk management and credentialing compliance"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`provider_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility metrics tracking network capacity, certification status, quality ratings, and bed capacity for network adequacy and strategic planning"
  source: "`health_insurance_ecm`.`provider`.`facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (e.g., hospital, clinic, surgery center) for capacity planning"
    - name: "participation_status"
      expr: participation_status
      comment: "Network participation status for adequacy monitoring"
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status for compliance tracking"
    - name: "state_code"
      expr: state_code
      comment: "State location for geographic network adequacy analysis"
    - name: "medicare_certified_flag"
      expr: medicare_certified_flag
      comment: "Medicare certification status for regulatory compliance"
    - name: "medicaid_certified_flag"
      expr: medicaid_certified_flag
      comment: "Medicaid certification status for regulatory compliance"
    - name: "emergency_services_flag"
      expr: emergency_services_flag
      comment: "Whether facility provides emergency services for access planning"
    - name: "teaching_hospital_flag"
      expr: teaching_hospital_flag
      comment: "Teaching hospital designation for quality and innovation metrics"
    - name: "critical_access_hospital_flag"
      expr: critical_access_hospital_flag
      comment: "Critical access hospital designation for rural access monitoring"
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier assignment for cost and quality steering"
  measures:
    - name: "total_facilities"
      expr: COUNT(DISTINCT facility_id)
      comment: "Total unique facilities for network capacity and adequacy reporting"
    - name: "active_credentialed_facilities"
      expr: COUNT(DISTINCT CASE WHEN credentialing_status = 'Active' THEN facility_id END)
      comment: "Count of actively credentialed facilities for compliance and quality assurance"
    - name: "medicare_certified_facilities"
      expr: COUNT(DISTINCT CASE WHEN medicare_certified_flag = TRUE THEN facility_id END)
      comment: "Count of Medicare-certified facilities for regulatory compliance and member access"
    - name: "medicaid_certified_facilities"
      expr: COUNT(DISTINCT CASE WHEN medicaid_certified_flag = TRUE THEN facility_id END)
      comment: "Count of Medicaid-certified facilities for regulatory compliance and member access"
    - name: "emergency_services_facilities"
      expr: COUNT(DISTINCT CASE WHEN emergency_services_flag = TRUE THEN facility_id END)
      comment: "Count of facilities with emergency services for access and adequacy planning"
    - name: "avg_quality_rating"
      expr: AVG(CAST(quality_rating AS DOUBLE))
      comment: "Average facility quality rating for network quality steering and tiering decisions"
    - name: "total_bed_capacity"
      expr: SUM(CAST(bed_count AS DOUBLE))
      comment: "Total bed capacity across facilities for capacity planning and utilization analysis"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`provider_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider licensing metrics tracking license status, expiration risk, disciplinary actions, and compact participation for credentialing compliance and risk management"
  source: "`health_insurance_ecm`.`provider`.`license`"
  dimensions:
    - name: "license_status"
      expr: license_status
      comment: "Current license status (e.g., active, expired, suspended) for compliance monitoring"
    - name: "license_type"
      expr: license_type
      comment: "Type of license for regulatory tracking"
    - name: "issuing_state"
      expr: issuing_state
      comment: "State that issued the license for multi-state compliance"
    - name: "compact_participation_flag"
      expr: compact_participation_flag
      comment: "Whether license participates in interstate compact for multi-state practice analysis"
    - name: "disciplinary_action_flag"
      expr: disciplinary_action_flag
      comment: "Whether license has disciplinary actions for risk management"
    - name: "telemedicine_authorized_flag"
      expr: telemedicine_authorized_flag
      comment: "Whether license authorizes telemedicine for virtual care capacity planning"
    - name: "continuing_education_required_flag"
      expr: continuing_education_required_flag
      comment: "Whether continuing education is required for compliance tracking"
    - name: "record_current_flag"
      expr: record_current_flag
      comment: "Whether this is the current license record for accurate counts"
  measures:
    - name: "total_active_licenses"
      expr: COUNT(DISTINCT CASE WHEN license_status = 'Active' AND record_current_flag = TRUE THEN license_id END)
      comment: "Count of active current licenses for credentialing compliance and workforce capacity"
    - name: "licenses_with_disciplinary_action"
      expr: COUNT(DISTINCT CASE WHEN disciplinary_action_flag = TRUE AND record_current_flag = TRUE THEN license_id END)
      comment: "Count of licenses with disciplinary actions for risk management and quality oversight"
    - name: "compact_participating_licenses"
      expr: COUNT(DISTINCT CASE WHEN compact_participation_flag = TRUE AND record_current_flag = TRUE THEN license_id END)
      comment: "Count of compact-participating licenses for multi-state practice capacity and telemedicine expansion"
    - name: "telemedicine_authorized_licenses"
      expr: COUNT(DISTINCT CASE WHEN telemedicine_authorized_flag = TRUE AND record_current_flag = TRUE THEN license_id END)
      comment: "Count of telemedicine-authorized licenses for virtual care capacity planning"
    - name: "licenses_expiring_within_90_days"
      expr: COUNT(DISTINCT CASE WHEN expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) AND record_current_flag = TRUE THEN license_id END)
      comment: "Count of licenses expiring in next 90 days for proactive credentialing and compliance risk mitigation"
    - name: "avg_continuing_education_hours_required"
      expr: AVG(CAST(continuing_education_hours_required AS DOUBLE))
      comment: "Average continuing education hours required for compliance planning and provider support"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`provider_exclusion_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Exclusion screening metrics tracking compliance status, screening frequency, match rates, and resolution for fraud prevention and regulatory compliance"
  source: "`health_insurance_ecm`.`provider`.`exclusion_screening`"
  dimensions:
    - name: "screening_result"
      expr: screening_result
      comment: "Result of exclusion screening (e.g., clear, match, pending) for compliance monitoring"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status for regulatory reporting"
    - name: "screening_source"
      expr: screening_source
      comment: "Source of screening data (e.g., OIG, SAM, state Medicaid) for audit trail"
    - name: "exclusion_type"
      expr: exclusion_type
      comment: "Type of exclusion if match found for risk categorization"
    - name: "match_type"
      expr: match_type
      comment: "Type of match (e.g., exact, fuzzy) for quality assessment"
    - name: "cms_reporting_flag"
      expr: cms_reporting_flag
      comment: "Whether screening requires CMS reporting for regulatory compliance"
    - name: "state_reporting_flag"
      expr: state_reporting_flag
      comment: "Whether screening requires state reporting for regulatory compliance"
    - name: "audit_flag"
      expr: audit_flag
      comment: "Whether screening is flagged for audit for quality control"
    - name: "screening_vendor"
      expr: screening_vendor
      comment: "Vendor performing screening for vendor performance analysis"
  measures:
    - name: "total_screenings"
      expr: COUNT(DISTINCT exclusion_screening_id)
      comment: "Total exclusion screenings performed for compliance volume tracking and audit readiness"
    - name: "screenings_with_matches"
      expr: COUNT(DISTINCT CASE WHEN screening_result = 'Match' THEN exclusion_screening_id END)
      comment: "Count of screenings with exclusion matches for fraud risk management and immediate action"
    - name: "screenings_requiring_cms_reporting"
      expr: COUNT(DISTINCT CASE WHEN cms_reporting_flag = TRUE THEN exclusion_screening_id END)
      comment: "Count of screenings requiring CMS reporting for regulatory compliance workload planning"
    - name: "screenings_requiring_state_reporting"
      expr: COUNT(DISTINCT CASE WHEN state_reporting_flag = TRUE THEN exclusion_screening_id END)
      comment: "Count of screenings requiring state reporting for regulatory compliance workload planning"
    - name: "screenings_flagged_for_audit"
      expr: COUNT(DISTINCT CASE WHEN audit_flag = TRUE THEN exclusion_screening_id END)
      comment: "Count of screenings flagged for audit for quality assurance and process improvement"
    - name: "resolved_screenings"
      expr: COUNT(DISTINCT CASE WHEN resolution_date IS NOT NULL THEN exclusion_screening_id END)
      comment: "Count of resolved screenings for compliance closure tracking and operational efficiency"
    - name: "unique_providers_screened"
      expr: COUNT(DISTINCT provider_id)
      comment: "Unique providers screened for coverage assessment and compliance gap analysis"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`provider_directory_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider directory metrics tracking directory accuracy, accepting new patients status, telehealth availability, and attestation compliance for member access and regulatory reporting"
  source: "`health_insurance_ecm`.`provider`.`directory_entry`"
  dimensions:
    - name: "participation_status"
      expr: participation_status
      comment: "Provider participation status in directory for accuracy monitoring"
    - name: "accepting_new_patients_flag"
      expr: accepting_new_patients_flag
      comment: "Whether provider is accepting new patients for member access planning"
    - name: "pcp_flag"
      expr: pcp_flag
      comment: "Whether provider is a primary care physician for PCP capacity analysis"
    - name: "telehealth_available_flag"
      expr: telehealth_available_flag
      comment: "Whether provider offers telehealth for virtual care capacity"
    - name: "attestation_status"
      expr: attestation_status
      comment: "Directory attestation status for regulatory compliance (CMS accuracy requirements)"
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier for cost and quality steering"
    - name: "provider_type"
      expr: provider_type
      comment: "Type of provider for directory composition analysis"
    - name: "gender"
      expr: gender
      comment: "Provider gender for diversity and patient preference matching"
  measures:
    - name: "total_directory_entries"
      expr: COUNT(DISTINCT directory_entry_id)
      comment: "Total directory entries for directory size and coverage tracking"
    - name: "active_directory_entries"
      expr: COUNT(DISTINCT CASE WHEN participation_status = 'Active' THEN directory_entry_id END)
      comment: "Count of active directory entries for member-facing directory accuracy and CMS compliance"
    - name: "providers_accepting_new_patients"
      expr: COUNT(DISTINCT CASE WHEN accepting_new_patients_flag = TRUE THEN directory_entry_id END)
      comment: "Count of providers accepting new patients for member access and network adequacy reporting"
    - name: "pcp_directory_entries"
      expr: COUNT(DISTINCT CASE WHEN pcp_flag = TRUE THEN directory_entry_id END)
      comment: "Count of PCP directory entries for primary care capacity and adequacy calculations"
    - name: "telehealth_enabled_entries"
      expr: COUNT(DISTINCT CASE WHEN telehealth_available_flag = TRUE THEN directory_entry_id END)
      comment: "Count of telehealth-enabled directory entries for virtual care capacity and member convenience"
    - name: "attested_directory_entries"
      expr: COUNT(DISTINCT CASE WHEN attestation_status = 'Attested' THEN directory_entry_id END)
      comment: "Count of attested directory entries for CMS directory accuracy compliance and audit readiness"
    - name: "entries_requiring_verification"
      expr: COUNT(DISTINCT CASE WHEN next_verification_due_date <= CURRENT_DATE() THEN directory_entry_id END)
      comment: "Count of entries requiring verification for proactive directory accuracy maintenance and CMS compliance"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`provider_specialty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider specialty metrics tracking specialty mix, board certification rates, PCP eligibility, and telehealth capacity for network adequacy and strategic workforce planning"
  source: "`health_insurance_ecm`.`provider`.`specialty`"
  dimensions:
    - name: "specialty_name"
      expr: specialty_name
      comment: "Name of specialty for specialty mix analysis"
    - name: "specialty_category"
      expr: specialty_category
      comment: "Category of specialty for high-level capacity planning"
    - name: "specialty_type"
      expr: specialty_type
      comment: "Type of specialty (e.g., primary, specialty, subspecialty) for adequacy calculations"
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status for compliance monitoring"
    - name: "board_certified_flag"
      expr: board_certified_flag
      comment: "Whether provider is board certified in specialty for quality metrics"
    - name: "pcp_eligible_flag"
      expr: pcp_eligible_flag
      comment: "Whether specialty is eligible for PCP designation for primary care capacity"
    - name: "hedis_specialty_flag"
      expr: hedis_specialty_flag
      comment: "Whether specialty is tracked for HEDIS reporting for quality program planning"
    - name: "telehealth_enabled_flag"
      expr: telehealth_enabled_flag
      comment: "Whether specialty offers telehealth for virtual care capacity"
    - name: "accepting_new_patients_flag"
      expr: accepting_new_patients_flag
      comment: "Whether specialty is accepting new patients for access planning"
    - name: "current_record_flag"
      expr: current_record_flag
      comment: "Whether this is the current specialty record for accurate counts"
  measures:
    - name: "total_active_specialties"
      expr: COUNT(DISTINCT CASE WHEN current_record_flag = TRUE THEN specialty_id END)
      comment: "Total active specialty records for network breadth and adequacy reporting"
    - name: "board_certified_specialties"
      expr: COUNT(DISTINCT CASE WHEN board_certified_flag = TRUE AND current_record_flag = TRUE THEN specialty_id END)
      comment: "Count of board-certified specialty records for quality metrics and HEDIS reporting"
    - name: "pcp_eligible_specialties"
      expr: COUNT(DISTINCT CASE WHEN pcp_eligible_flag = TRUE AND current_record_flag = TRUE THEN specialty_id END)
      comment: "Count of PCP-eligible specialty records for primary care capacity and adequacy calculations"
    - name: "hedis_tracked_specialties"
      expr: COUNT(DISTINCT CASE WHEN hedis_specialty_flag = TRUE AND current_record_flag = TRUE THEN specialty_id END)
      comment: "Count of HEDIS-tracked specialty records for quality program planning and performance monitoring"
    - name: "telehealth_enabled_specialties"
      expr: COUNT(DISTINCT CASE WHEN telehealth_enabled_flag = TRUE AND current_record_flag = TRUE THEN specialty_id END)
      comment: "Count of telehealth-enabled specialty records for virtual care capacity and strategic expansion"
    - name: "specialties_accepting_new_patients"
      expr: COUNT(DISTINCT CASE WHEN accepting_new_patients_flag = TRUE AND current_record_flag = TRUE THEN specialty_id END)
      comment: "Count of specialties accepting new patients for member access and network adequacy steering"
    - name: "unique_providers_with_specialty"
      expr: COUNT(DISTINCT provider_id)
      comment: "Unique providers with specialty assignments for workforce capacity and specialty distribution analysis"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`provider_practice_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Practice location metrics tracking geographic distribution, accessibility features, telehealth availability, and new patient acceptance for network adequacy and member access planning"
  source: "`health_insurance_ecm`.`provider`.`practice_location`"
  dimensions:
    - name: "location_type"
      expr: location_type
      comment: "Type of practice location (e.g., office, clinic, hospital-based) for capacity planning"
    - name: "participation_status"
      expr: participation_status
      comment: "Network participation status for adequacy monitoring"
    - name: "state_code"
      expr: state_code
      comment: "State location for geographic network adequacy analysis"
    - name: "county_name"
      expr: county_name
      comment: "County location for local adequacy and rural access analysis"
    - name: "accepting_new_patients_flag"
      expr: accepting_new_patients_flag
      comment: "Whether location is accepting new patients for member access planning"
    - name: "telehealth_available_flag"
      expr: telehealth_available_flag
      comment: "Whether location offers telehealth for virtual care capacity"
    - name: "ada_compliant_flag"
      expr: ada_compliant_flag
      comment: "Whether location is ADA compliant for accessibility planning"
    - name: "wheelchair_accessible_flag"
      expr: wheelchair_accessible_flag
      comment: "Whether location is wheelchair accessible for accessibility planning"
    - name: "public_transportation_access_flag"
      expr: public_transportation_access_flag
      comment: "Whether location has public transportation access for member convenience"
    - name: "directory_display_flag"
      expr: directory_display_flag
      comment: "Whether location is displayed in directory for member-facing accuracy"
  measures:
    - name: "total_practice_locations"
      expr: COUNT(DISTINCT practice_location_id)
      comment: "Total practice locations for network geographic coverage and adequacy reporting"
    - name: "active_practice_locations"
      expr: COUNT(DISTINCT CASE WHEN participation_status = 'Active' THEN practice_location_id END)
      comment: "Count of active practice locations for member access and network adequacy calculations"
    - name: "locations_accepting_new_patients"
      expr: COUNT(DISTINCT CASE WHEN accepting_new_patients_flag = TRUE THEN practice_location_id END)
      comment: "Count of locations accepting new patients for member access and capacity planning"
    - name: "telehealth_enabled_locations"
      expr: COUNT(DISTINCT CASE WHEN telehealth_available_flag = TRUE THEN practice_location_id END)
      comment: "Count of telehealth-enabled locations for virtual care capacity and strategic expansion"
    - name: "ada_compliant_locations"
      expr: COUNT(DISTINCT CASE WHEN ada_compliant_flag = TRUE THEN practice_location_id END)
      comment: "Count of ADA-compliant locations for accessibility compliance and member accommodation"
    - name: "wheelchair_accessible_locations"
      expr: COUNT(DISTINCT CASE WHEN wheelchair_accessible_flag = TRUE THEN practice_location_id END)
      comment: "Count of wheelchair-accessible locations for accessibility planning and member support"
    - name: "public_transit_accessible_locations"
      expr: COUNT(DISTINCT CASE WHEN public_transportation_access_flag = TRUE THEN practice_location_id END)
      comment: "Count of public transit accessible locations for member convenience and access equity"
    - name: "directory_displayed_locations"
      expr: COUNT(DISTINCT CASE WHEN directory_display_flag = TRUE THEN practice_location_id END)
      comment: "Count of directory-displayed locations for member-facing directory accuracy and CMS compliance"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`provider_dea_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DEA registration metrics tracking controlled substance authorization, registration status, and expiration risk for regulatory compliance and prescribing capacity"
  source: "`health_insurance_ecm`.`provider`.`dea_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "DEA registration status (e.g., active, expired, suspended) for compliance monitoring"
    - name: "registration_type"
      expr: registration_type
      comment: "Type of DEA registration for regulatory tracking"
    - name: "registration_state"
      expr: registration_state
      comment: "State of DEA registration for multi-state compliance"
    - name: "controlled_substance_authorized_flag"
      expr: controlled_substance_authorized_flag
      comment: "Whether authorized to prescribe controlled substances for prescribing capacity"
    - name: "schedule_authorized"
      expr: schedule_authorized
      comment: "Controlled substance schedules authorized for prescribing scope analysis"
    - name: "current_record_flag"
      expr: current_record_flag
      comment: "Whether this is the current DEA record for accurate counts"
  measures:
    - name: "total_active_dea_registrations"
      expr: COUNT(DISTINCT CASE WHEN registration_status = 'Active' AND current_record_flag = TRUE THEN dea_registration_id END)
      comment: "Count of active DEA registrations for prescribing capacity and regulatory compliance"
    - name: "controlled_substance_authorized_registrations"
      expr: COUNT(DISTINCT CASE WHEN controlled_substance_authorized_flag = TRUE AND current_record_flag = TRUE THEN dea_registration_id END)
      comment: "Count of controlled substance authorized registrations for prescribing capacity and opioid stewardship planning"
    - name: "dea_registrations_expiring_within_90_days"
      expr: COUNT(DISTINCT CASE WHEN expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) AND current_record_flag = TRUE THEN dea_registration_id END)
      comment: "Count of DEA registrations expiring in next 90 days for proactive renewal and compliance risk mitigation"
    - name: "unique_providers_with_dea"
      expr: COUNT(DISTINCT provider_id)
      comment: "Unique providers with DEA registration for prescribing workforce capacity and network adequacy"
$$;