-- Metric views for domain: provider | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 18:58:55

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`provider_clinician`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the clinician workforce — credentialing health, board certification coverage, enrollment status, and workforce composition. Used by CMO, VP Medical Staff, and Credentialing leadership to steer provider readiness and compliance."
  source: "`healthcare_ecm`.`provider`.`clinician`"
  dimensions:
    - name: "clinician_type"
      expr: clinician_type
      comment: "Type of clinician (e.g., MD, DO, NP, PA) — used to segment workforce metrics by provider category."
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status of the clinician (e.g., Active, Terminated, On Leave) — key filter for active workforce analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment arrangement (e.g., Full-Time, Part-Time, Contracted) — used to analyze workforce composition and FTE planning."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Current credentialing status of the clinician — critical for compliance and privileging readiness dashboards."
    - name: "gender"
      expr: gender
      comment: "Clinician gender — used for workforce diversity and equity reporting."
    - name: "medical_degree"
      expr: medical_degree
      comment: "Highest medical degree held (e.g., MD, DO, PhD) — used to segment clinical workforce by qualification level."
    - name: "license_state"
      expr: license_state
      comment: "State in which the clinician holds their primary license — used for geographic workforce distribution and multi-state licensing analysis."
    - name: "payer_enrollment_status"
      expr: payer_enrollment_status
      comment: "Status of the clinician's payer enrollment — used to track revenue readiness and billing eligibility."
    - name: "board_certified"
      expr: board_certified
      comment: "Boolean flag indicating whether the clinician is board certified — used to measure clinical quality and credentialing standards."
    - name: "medicaid_enrolled"
      expr: medicaid_enrolled
      comment: "Boolean flag indicating Medicaid enrollment — used to assess access and payer mix coverage."
    - name: "medicare_enrolled"
      expr: medicare_enrolled
      comment: "Boolean flag indicating Medicare enrollment — used to assess access and payer mix coverage."
    - name: "hire_year"
      expr: DATE_TRUNC('YEAR', hire_date)
      comment: "Year the clinician was hired — used for cohort-based retention and tenure analysis."
    - name: "credentialing_expiration_month"
      expr: DATE_TRUNC('MONTH', credentialing_expiration_date)
      comment: "Month in which the clinician's credentialing expires — used for proactive renewal pipeline management."
  measures:
    - name: "total_clinicians"
      expr: COUNT(1)
      comment: "Total number of clinician records — baseline headcount for workforce sizing and planning."
    - name: "active_clinicians"
      expr: COUNT(CASE WHEN employment_status = 'Active' THEN 1 END)
      comment: "Count of clinicians with Active employment status — core workforce availability metric used in staffing and capacity planning."
    - name: "board_certified_clinicians"
      expr: COUNT(CASE WHEN board_certified = TRUE THEN 1 END)
      comment: "Count of board-certified clinicians — measures clinical quality standard adherence; tracked by CMO for accreditation and quality reporting."
    - name: "board_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN board_certified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of clinicians who are board certified — strategic quality KPI used in accreditation submissions and payer contracting negotiations."
    - name: "credentialing_expiring_within_90_days"
      expr: COUNT(CASE WHEN credentialing_expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Count of clinicians whose credentialing expires within the next 90 days — operational risk metric used by credentialing teams to prioritize renewal workload."
    - name: "license_expiring_within_90_days"
      expr: COUNT(CASE WHEN license_expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Count of clinicians with a state license expiring within 90 days — compliance risk metric; unresolved expirations can result in billing suspension."
    - name: "medicaid_enrolled_clinicians"
      expr: COUNT(CASE WHEN medicaid_enrolled = TRUE THEN 1 END)
      comment: "Count of Medicaid-enrolled clinicians — access and payer mix metric used by network strategy and government programs leadership."
    - name: "medicare_enrolled_clinicians"
      expr: COUNT(CASE WHEN medicare_enrolled = TRUE THEN 1 END)
      comment: "Count of Medicare-enrolled clinicians — access and payer mix metric used by network strategy and government programs leadership."
    - name: "primary_source_verified_clinicians"
      expr: COUNT(CASE WHEN primary_source_verified = TRUE THEN 1 END)
      comment: "Count of clinicians with completed primary source verification — credentialing compliance metric required for NCQA and URAC accreditation."
    - name: "primary_source_verification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN primary_source_verified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of clinicians with primary source verification completed — accreditation readiness KPI; falling below thresholds triggers corrective action plans."
    - name: "oig_exclusion_checked_clinicians"
      expr: COUNT(CASE WHEN oig_exclusion_checked = TRUE THEN 1 END)
      comment: "Count of clinicians with OIG exclusion screening completed — federal compliance metric; failure to screen can result in CMS penalties and False Claims Act exposure."
    - name: "oig_exclusion_check_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN oig_exclusion_checked = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of clinicians with OIG exclusion check completed — regulatory compliance rate tracked by Compliance and Legal leadership."
    - name: "malpractice_expiring_within_90_days"
      expr: COUNT(CASE WHEN malpractice_expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Count of clinicians with malpractice coverage expiring within 90 days — risk management metric; lapsed coverage creates institutional liability exposure."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`provider_board_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs tracking board certification status, maintenance of certification (MOC) compliance, and expiration risk across the clinician population. Used by CMO, Medical Staff Office, and Credentialing leadership."
  source: "`healthcare_ecm`.`provider`.`board_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the board certification (e.g., Active, Expired, Revoked) — primary filter for certification health dashboards."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of board certification (e.g., Initial, Recertification) — used to distinguish new certifications from renewals in pipeline analysis."
    - name: "certifying_board_name"
      expr: certifying_board_name
      comment: "Name of the certifying board (e.g., ABIM, ABS) — used to segment certification metrics by specialty board for targeted outreach."
    - name: "certifying_organization_type"
      expr: certifying_organization_type
      comment: "Type of certifying organization — used to categorize certifications by ABMS, AOA, or other bodies."
    - name: "moc_status"
      expr: moc_status
      comment: "Maintenance of Certification (MOC) program status — used to track ongoing compliance with continuous certification requirements."
    - name: "verification_status"
      expr: verification_status
      comment: "Status of certification verification — used to identify certifications pending or failed primary source verification."
    - name: "is_primary_specialty"
      expr: is_primary_specialty
      comment: "Boolean flag indicating whether this certification is for the clinician's primary specialty — used to prioritize primary specialty certification tracking."
    - name: "is_lifetime_certification"
      expr: is_lifetime_certification
      comment: "Boolean flag indicating lifetime certification — used to exclude lifetime-certified clinicians from expiration risk calculations."
    - name: "expiration_year"
      expr: DATE_TRUNC('YEAR', expiration_date)
      comment: "Year of certification expiration — used for annual expiration cohort analysis and renewal planning."
    - name: "recertification_year"
      expr: DATE_TRUNC('YEAR', recertification_date)
      comment: "Year of most recent recertification — used to track recertification cycle compliance."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of board certification records — baseline count for certification portfolio management."
    - name: "active_certifications"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN 1 END)
      comment: "Count of currently active board certifications — primary metric for clinical quality and credentialing compliance dashboards."
    - name: "active_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of board certifications that are currently active — quality and accreditation KPI; declining rates trigger credentialing intervention."
    - name: "certifications_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) AND certification_status = 'Active' THEN 1 END)
      comment: "Count of active certifications expiring within 90 days — operational risk metric used by Medical Staff Office to prioritize renewal outreach."
    - name: "moc_compliant_certifications"
      expr: COUNT(CASE WHEN moc_status = 'Compliant' THEN 1 END)
      comment: "Count of certifications with compliant MOC status — tracks ongoing certification maintenance compliance required by ABMS boards."
    - name: "moc_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN moc_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications with compliant MOC status — strategic quality KPI; non-compliance can result in certification lapse and privileging restrictions."
    - name: "verified_certifications"
      expr: COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END)
      comment: "Count of certifications with completed primary source verification — credentialing compliance metric required for NCQA accreditation."
    - name: "verification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications with completed verification — accreditation readiness KPI tracked by Credentialing and Compliance leadership."
    - name: "distinct_certified_clinicians"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Count of unique clinicians with at least one board certification record — used to measure board certification coverage across the clinician workforce."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`provider_credential`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for provider credential management — expiration risk, verification compliance, CME credit tracking, and privileging relevance. Used by Credentialing, Compliance, and Medical Staff leadership."
  source: "`healthcare_ecm`.`provider`.`credential`"
  dimensions:
    - name: "credential_type"
      expr: credential_type
      comment: "Type of credential (e.g., State License, DEA, CME, Hospital Privilege) — primary segmentation dimension for credential portfolio analysis."
    - name: "credential_status"
      expr: credential_status
      comment: "Current status of the credential (e.g., Active, Expired, Pending) — used to filter and segment credential health dashboards."
    - name: "issuing_state"
      expr: issuing_state
      comment: "State that issued the credential — used for geographic compliance analysis and multi-state licensing strategy."
    - name: "issuing_authority_name"
      expr: issuing_authority_name
      comment: "Name of the issuing authority — used to segment credentials by regulatory body for targeted compliance tracking."
    - name: "moc_status"
      expr: moc_status
      comment: "MOC status associated with the credential — used to track ongoing maintenance compliance."
    - name: "primary_source_verified"
      expr: primary_source_verified
      comment: "Boolean flag indicating primary source verification completion — used to filter credentials requiring verification action."
    - name: "privileging_relevant"
      expr: privileging_relevant
      comment: "Boolean flag indicating whether the credential is relevant to privileging decisions — used to prioritize credentialing workload."
    - name: "payer_enrollment_relevant"
      expr: payer_enrollment_relevant
      comment: "Boolean flag indicating whether the credential is required for payer enrollment — used to track revenue-impacting credential gaps."
    - name: "oig_exclusion_checked"
      expr: oig_exclusion_checked
      comment: "Boolean flag indicating OIG exclusion check completion — used to identify credentials with outstanding federal compliance screening."
    - name: "expiration_year"
      expr: DATE_TRUNC('YEAR', expiration_date)
      comment: "Year of credential expiration — used for annual expiration cohort planning and renewal pipeline management."
    - name: "cme_activity_type"
      expr: cme_activity_type
      comment: "Type of CME activity (e.g., Live, Enduring, Performance Improvement) — used to analyze CME credit distribution by activity type."
    - name: "cme_category"
      expr: cme_category
      comment: "CME category (e.g., Category 1, Category 2) — used to ensure clinicians meet category-specific CME requirements for licensure renewal."
  measures:
    - name: "total_credentials"
      expr: COUNT(1)
      comment: "Total number of credential records — baseline count for credential portfolio management."
    - name: "active_credentials"
      expr: COUNT(CASE WHEN credential_status = 'Active' THEN 1 END)
      comment: "Count of currently active credentials — primary compliance health metric used by Credentialing leadership."
    - name: "active_credential_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN credential_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of credentials that are currently active — compliance readiness KPI; declining rates indicate credentialing backlog or expiration risk."
    - name: "credentials_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) AND credential_status = 'Active' THEN 1 END)
      comment: "Count of active credentials expiring within 90 days — operational risk metric used to prioritize renewal workload and prevent lapses."
    - name: "primary_source_verified_credentials"
      expr: COUNT(CASE WHEN primary_source_verified = TRUE THEN 1 END)
      comment: "Count of credentials with completed primary source verification — NCQA/URAC accreditation compliance metric."
    - name: "primary_source_verification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN primary_source_verified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of credentials with primary source verification completed — accreditation readiness KPI; falling below thresholds triggers corrective action."
    - name: "total_cme_credit_hours"
      expr: SUM(CAST(cme_credit_hours AS DOUBLE))
      comment: "Total CME credit hours across all credential records — used to track aggregate CME completion for licensure and privileging requirements."
    - name: "avg_cme_credit_hours_per_credential"
      expr: AVG(CAST(cme_credit_hours AS DOUBLE))
      comment: "Average CME credit hours per credential record — used to benchmark CME completion rates and identify clinicians below required thresholds."
    - name: "oig_exclusion_checked_credentials"
      expr: COUNT(CASE WHEN oig_exclusion_checked = TRUE THEN 1 END)
      comment: "Count of credentials with OIG exclusion check completed — federal compliance metric; gaps create False Claims Act and CMS penalty exposure."
    - name: "oig_exclusion_check_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN oig_exclusion_checked = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of credentials with OIG exclusion check completed — regulatory compliance rate tracked by Compliance and Legal leadership."
    - name: "privileging_relevant_credentials"
      expr: COUNT(CASE WHEN privileging_relevant = TRUE THEN 1 END)
      comment: "Count of credentials flagged as relevant to privileging decisions — used to scope privileging-critical credential review workload."
    - name: "payer_enrollment_relevant_credentials"
      expr: COUNT(CASE WHEN payer_enrollment_relevant = TRUE THEN 1 END)
      comment: "Count of credentials required for payer enrollment — used to identify revenue-impacting credential gaps that block billing activation."
    - name: "distinct_credentialed_clinicians"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Count of unique clinicians with at least one credential record — used to measure credentialing coverage across the provider workforce."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`provider_privileging`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for clinical privileging — privilege status distribution, FPPE/OPPE compliance, expiration risk, and peer review performance. Used by CMO, Medical Staff Office, and Department Chiefs to govern clinical scope of practice."
  source: "`healthcare_ecm`.`provider`.`privileging`"
  dimensions:
    - name: "privilege_status"
      expr: privilege_status
      comment: "Current status of the privilege (e.g., Active, Suspended, Revoked, Pending) — primary filter for privileging health and compliance dashboards."
    - name: "privilege_type"
      expr: privilege_type
      comment: "Type of privilege (e.g., Core, Supplemental, Telemedicine) — used to segment privileging metrics by scope category."
    - name: "privilege_category"
      expr: privilege_category
      comment: "Category of the privilege (e.g., Surgical, Diagnostic, Procedural) — used to analyze privileging distribution by clinical domain."
    - name: "is_provisional"
      expr: is_provisional
      comment: "Boolean flag indicating provisional privilege status — used to track FPPE-required provisional privileges requiring proctor oversight."
    - name: "fppe_required"
      expr: fppe_required
      comment: "Boolean flag indicating whether Focused Professional Practice Evaluation is required — used to manage FPPE pipeline and proctor assignments."
    - name: "board_certification_required"
      expr: board_certification_required
      comment: "Boolean flag indicating whether board certification is required for this privilege — used to enforce credentialing standards."
    - name: "telemedicine_authorized"
      expr: telemedicine_authorized
      comment: "Boolean flag indicating telemedicine authorization — used to track telehealth-enabled privilege coverage for virtual care capacity planning."
    - name: "emtala_covered"
      expr: emtala_covered
      comment: "Boolean flag indicating EMTALA coverage — used to ensure adequate on-call coverage for emergency care compliance."
    - name: "malpractice_verified"
      expr: malpractice_verified
      comment: "Boolean flag indicating malpractice coverage verification — used to ensure all privileged clinicians have verified insurance coverage."
    - name: "expiration_year"
      expr: DATE_TRUNC('YEAR', expiration_date)
      comment: "Year of privilege expiration — used for annual reappointment cycle planning and renewal pipeline management."
    - name: "approval_year"
      expr: DATE_TRUNC('YEAR', approval_date)
      comment: "Year of privilege approval — used for cohort analysis of privileging cycle times and approval trends."
  measures:
    - name: "total_privileges"
      expr: COUNT(1)
      comment: "Total number of privilege records — baseline count for privileging portfolio management."
    - name: "active_privileges"
      expr: COUNT(CASE WHEN privilege_status = 'Active' THEN 1 END)
      comment: "Count of currently active privileges — primary metric for clinical scope of practice coverage and medical staff readiness."
    - name: "active_privilege_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN privilege_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of privileges that are currently active — privileging health KPI used in medical staff committee reporting and accreditation."
    - name: "privileges_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) AND privilege_status = 'Active' THEN 1 END)
      comment: "Count of active privileges expiring within 90 days — operational risk metric used by Medical Staff Office to manage reappointment workload."
    - name: "provisional_privileges"
      expr: COUNT(CASE WHEN is_provisional = TRUE AND privilege_status = 'Active' THEN 1 END)
      comment: "Count of active provisional privileges — used to track FPPE pipeline volume and proctor resource requirements."
    - name: "fppe_required_privileges"
      expr: COUNT(CASE WHEN fppe_required = TRUE THEN 1 END)
      comment: "Count of privileges requiring Focused Professional Practice Evaluation — used to manage FPPE workload and ensure timely completion per medical staff bylaws."
    - name: "fppe_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fppe_required = TRUE AND fppe_completion_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN fppe_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of FPPE-required privileges with completed evaluations — quality and compliance KPI; incomplete FPPEs create accreditation risk."
    - name: "avg_peer_review_score"
      expr: AVG(CAST(peer_review_score AS DOUBLE))
      comment: "Average peer review score across privileged clinicians — clinical quality KPI used by Department Chiefs and CMO to identify performance outliers."
    - name: "suspended_or_revoked_privileges"
      expr: COUNT(CASE WHEN privilege_status IN ('Suspended', 'Revoked') THEN 1 END)
      comment: "Count of suspended or revoked privileges — patient safety and risk management metric; elevated counts trigger immediate medical staff committee review."
    - name: "telemedicine_authorized_privileges"
      expr: COUNT(CASE WHEN telemedicine_authorized = TRUE AND privilege_status = 'Active' THEN 1 END)
      comment: "Count of active telemedicine-authorized privileges — used to assess telehealth capacity and virtual care program scalability."
    - name: "malpractice_verified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN malpractice_verified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of privileges with verified malpractice coverage — risk management compliance KPI; unverified coverage creates institutional liability."
    - name: "distinct_privileged_clinicians"
      expr: COUNT(DISTINCT privileging_clinician_id)
      comment: "Count of unique clinicians with at least one privilege record — used to measure privileging coverage across the medical staff."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`provider_network_affiliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for provider network participation — panel status, credentialing compliance, telehealth eligibility, and network adequacy. Used by Network Strategy, Contracting, and Payer Relations leadership to manage network composition and adequacy."
  source: "`healthcare_ecm`.`provider`.`network_affiliation`"
  dimensions:
    - name: "affiliation_status"
      expr: affiliation_status
      comment: "Current status of the network affiliation (e.g., Active, Terminated, Pending) — primary filter for network participation health dashboards."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier designation (e.g., Tier 1, Tier 2, Preferred) — used to analyze provider distribution across network tiers for benefit design and cost management."
    - name: "participation_type"
      expr: participation_type
      comment: "Type of network participation (e.g., In-Network, Preferred, Contracted) — used to segment network metrics by participation category."
    - name: "network_adequacy_category"
      expr: network_adequacy_category
      comment: "Network adequacy category assigned to the affiliation — used to track compliance with state and federal network adequacy standards."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status for this network affiliation — used to identify providers pending credentialing who cannot yet bill under the network."
    - name: "panel_status"
      expr: panel_status
      comment: "Panel status (e.g., Open, Closed, Waitlist) — used to track patient access capacity across the network."
    - name: "service_area_state"
      expr: service_area_state
      comment: "State of the service area — used for geographic network adequacy analysis and state-level regulatory reporting."
    - name: "accepts_new_patients"
      expr: accepts_new_patients
      comment: "Boolean flag indicating whether the provider is accepting new patients — used to measure patient access capacity within the network."
    - name: "telehealth_eligible"
      expr: telehealth_eligible
      comment: "Boolean flag indicating telehealth eligibility — used to assess virtual care capacity within the network."
    - name: "primary_care_designation"
      expr: primary_care_designation
      comment: "Boolean flag indicating primary care designation — used to track PCP availability for network adequacy and access reporting."
    - name: "mips_eligible"
      expr: mips_eligible
      comment: "Boolean flag indicating MIPS eligibility — used to identify providers subject to value-based payment adjustments."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the network affiliation became effective — used for cohort analysis of network growth and provider onboarding trends."
  measures:
    - name: "total_network_affiliations"
      expr: COUNT(1)
      comment: "Total number of network affiliation records — baseline count for network size and composition analysis."
    - name: "active_network_affiliations"
      expr: COUNT(CASE WHEN affiliation_status = 'Active' THEN 1 END)
      comment: "Count of active network affiliations — primary network size metric used in network adequacy reporting and payer contracting."
    - name: "active_affiliation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN affiliation_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of network affiliations that are currently active — network health KPI used in payer contract compliance and adequacy filings."
    - name: "open_panel_providers"
      expr: COUNT(CASE WHEN accepts_new_patients = TRUE AND affiliation_status = 'Active' THEN 1 END)
      comment: "Count of active network providers accepting new patients — patient access metric used by Network Strategy to identify access gaps and recruit providers."
    - name: "open_panel_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN accepts_new_patients = TRUE AND affiliation_status = 'Active' THEN 1 END) / NULLIF(COUNT(CASE WHEN affiliation_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active network providers with open panels — patient access KPI; declining rates trigger network recruitment and adequacy remediation."
    - name: "telehealth_eligible_providers"
      expr: COUNT(CASE WHEN telehealth_eligible = TRUE AND affiliation_status = 'Active' THEN 1 END)
      comment: "Count of active network providers eligible for telehealth — virtual care capacity metric used by Digital Health and Network Strategy leadership."
    - name: "telehealth_eligibility_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN telehealth_eligible = TRUE AND affiliation_status = 'Active' THEN 1 END) / NULLIF(COUNT(CASE WHEN affiliation_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active network providers with telehealth eligibility — virtual care readiness KPI used in digital health strategy and payer contract negotiations."
    - name: "credentialing_pending_affiliations"
      expr: COUNT(CASE WHEN credentialing_status = 'Pending' AND affiliation_status = 'Active' THEN 1 END)
      comment: "Count of active affiliations with pending credentialing — revenue risk metric; pending credentialing blocks billing activation and delays network participation."
    - name: "credentialing_expiring_within_90_days"
      expr: COUNT(CASE WHEN credentialing_expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) AND affiliation_status = 'Active' THEN 1 END)
      comment: "Count of active network affiliations with credentialing expiring within 90 days — compliance risk metric used to prioritize recredentialing workload."
    - name: "mips_eligible_providers"
      expr: COUNT(CASE WHEN mips_eligible = TRUE AND affiliation_status = 'Active' THEN 1 END)
      comment: "Count of active MIPS-eligible providers — value-based care metric used to scope quality reporting obligations and potential payment adjustments."
    - name: "primary_care_providers"
      expr: COUNT(CASE WHEN primary_care_designation = TRUE AND affiliation_status = 'Active' THEN 1 END)
      comment: "Count of active primary care providers in the network — access and adequacy metric; PCP availability is a key regulatory network adequacy standard."
    - name: "distinct_network_clinicians"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Count of unique clinicians with active or historical network affiliations — used to measure network breadth and provider diversity."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`provider_dea_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for DEA registration compliance — registration status, controlled substance schedule authorizations, expiration risk, and fee management. Used by Compliance, Pharmacy, and Medical Staff leadership to manage controlled substance prescribing authority."
  source: "`healthcare_ecm`.`provider`.`dea_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current DEA registration status (e.g., Active, Expired, Surrendered, Revoked) — primary filter for DEA compliance dashboards."
    - name: "registration_type"
      expr: registration_type
      comment: "Type of DEA registration (e.g., Practitioner, Mid-Level Practitioner) — used to segment DEA metrics by registrant category."
    - name: "registration_state"
      expr: registration_state
      comment: "State of DEA registration — used for geographic compliance analysis and multi-state prescribing authority tracking."
    - name: "business_activity_type"
      expr: business_activity_type
      comment: "DEA business activity type — used to categorize registrations by authorized prescribing activity."
    - name: "schedule_ii_authorized"
      expr: schedule_ii_authorized
      comment: "Boolean flag for Schedule II controlled substance authorization — used to track high-risk prescribing authority coverage."
    - name: "schedule_iii_authorized"
      expr: schedule_iii_authorized
      comment: "Boolean flag for Schedule III controlled substance authorization — used to track prescribing authority scope."
    - name: "schedule_iv_authorized"
      expr: schedule_iv_authorized
      comment: "Boolean flag for Schedule IV controlled substance authorization — used to track prescribing authority scope."
    - name: "x_waiver_authorized"
      expr: x_waiver_authorized
      comment: "Boolean flag for X-waiver (buprenorphine) authorization — used to track MAT (Medication-Assisted Treatment) prescribing capacity for opioid use disorder programs."
    - name: "fee_exempt"
      expr: fee_exempt
      comment: "Boolean flag indicating DEA fee exemption — used to identify exempt registrants (e.g., federal employees) in fee management reporting."
    - name: "pdmp_reporting_required"
      expr: pdmp_reporting_required
      comment: "Boolean flag indicating PDMP reporting requirement — used to ensure compliance with state prescription drug monitoring program obligations."
    - name: "expiration_year"
      expr: DATE_TRUNC('YEAR', expiration_date)
      comment: "Year of DEA registration expiration — used for annual renewal pipeline planning."
  measures:
    - name: "total_dea_registrations"
      expr: COUNT(1)
      comment: "Total number of DEA registration records — baseline count for controlled substance prescribing authority management."
    - name: "active_dea_registrations"
      expr: COUNT(CASE WHEN registration_status = 'Active' THEN 1 END)
      comment: "Count of active DEA registrations — primary compliance metric for controlled substance prescribing authority coverage."
    - name: "active_registration_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN registration_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DEA registrations that are currently active — compliance health KPI; lapsed registrations create prescribing authority gaps and regulatory risk."
    - name: "registrations_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) AND registration_status = 'Active' THEN 1 END)
      comment: "Count of active DEA registrations expiring within 90 days — operational risk metric used by Compliance to prioritize renewal submissions."
    - name: "total_registration_fees"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total DEA registration fees across all records — financial metric used for compliance budget planning and cost management."
    - name: "avg_registration_fee"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average DEA registration fee per record — used to benchmark fee levels and identify anomalies in fee assessments."
    - name: "schedule_ii_authorized_registrations"
      expr: COUNT(CASE WHEN schedule_ii_authorized = TRUE AND registration_status = 'Active' THEN 1 END)
      comment: "Count of active registrations with Schedule II authorization — used to assess high-risk controlled substance prescribing capacity and coverage."
    - name: "x_waiver_authorized_registrations"
      expr: COUNT(CASE WHEN x_waiver_authorized = TRUE AND registration_status = 'Active' THEN 1 END)
      comment: "Count of active X-waiver authorized registrations — MAT capacity metric used by Behavioral Health and Population Health leadership to assess opioid treatment access."
    - name: "revoked_or_surrendered_registrations"
      expr: COUNT(CASE WHEN registration_status IN ('Revoked', 'Surrendered') THEN 1 END)
      comment: "Count of revoked or surrendered DEA registrations — patient safety and compliance risk metric; elevated counts trigger immediate Compliance and Legal review."
    - name: "distinct_dea_registered_clinicians"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Count of unique clinicians with DEA registrations — used to measure controlled substance prescribing authority coverage across the clinician workforce."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`provider_malpractice_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for malpractice insurance coverage management — coverage status, expiration risk, coverage limits, and claims history. Used by Risk Management, Legal, and Medical Staff leadership to ensure adequate liability protection."
  source: "`healthcare_ecm`.`provider`.`malpractice_coverage`"
  dimensions:
    - name: "coverage_status"
      expr: coverage_status
      comment: "Current malpractice coverage status (e.g., Active, Expired, Lapsed) — primary filter for coverage health and risk dashboards."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of malpractice coverage (e.g., Claims-Made, Occurrence) — used to segment coverage metrics by policy structure for risk analysis."
    - name: "coverage_state"
      expr: coverage_state
      comment: "State of malpractice coverage — used for geographic risk analysis and multi-state coverage gap identification."
    - name: "self_insured_indicator"
      expr: self_insured_indicator
      comment: "Boolean flag indicating self-insured coverage — used to segment institutional vs. commercial coverage for risk management reporting."
    - name: "tail_coverage_indicator"
      expr: tail_coverage_indicator
      comment: "Boolean flag indicating tail coverage — used to track post-employment liability protection for departed clinicians."
    - name: "nose_coverage_indicator"
      expr: nose_coverage_indicator
      comment: "Boolean flag indicating nose (prior acts) coverage — used to ensure continuity of coverage for newly onboarded clinicians."
    - name: "coverage_lapse_indicator"
      expr: coverage_lapse_indicator
      comment: "Boolean flag indicating a coverage lapse — used to identify clinicians with historical coverage gaps that create institutional liability risk."
    - name: "claims_history_indicator"
      expr: claims_history_indicator
      comment: "Boolean flag indicating a claims history — used to identify high-risk clinicians for enhanced credentialing review and risk stratification."
    - name: "group_policy_indicator"
      expr: group_policy_indicator
      comment: "Boolean flag indicating group policy coverage — used to distinguish group vs. individual policy holders for coverage management."
    - name: "expiration_year"
      expr: DATE_TRUNC('YEAR', expiration_date)
      comment: "Year of malpractice coverage expiration — used for annual renewal pipeline planning and risk exposure management."
  measures:
    - name: "total_coverage_records"
      expr: COUNT(1)
      comment: "Total number of malpractice coverage records — baseline count for coverage portfolio management."
    - name: "active_coverage_records"
      expr: COUNT(CASE WHEN coverage_status = 'Active' THEN 1 END)
      comment: "Count of active malpractice coverage records — primary risk management metric; gaps in active coverage create institutional liability exposure."
    - name: "active_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN coverage_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of malpractice coverage records that are currently active — risk management KPI; declining rates indicate coverage gaps requiring immediate remediation."
    - name: "coverage_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) AND coverage_status = 'Active' THEN 1 END)
      comment: "Count of active malpractice policies expiring within 90 days — operational risk metric used by Risk Management to prioritize renewal actions."
    - name: "total_per_occurrence_limit"
      expr: SUM(CAST(per_occurrence_limit AS DOUBLE))
      comment: "Total per-occurrence coverage limit across all active policies — used to assess aggregate institutional liability protection capacity."
    - name: "avg_per_occurrence_limit"
      expr: AVG(CAST(per_occurrence_limit AS DOUBLE))
      comment: "Average per-occurrence coverage limit — used to benchmark coverage adequacy against industry standards and payer contract requirements."
    - name: "total_aggregate_limit"
      expr: SUM(CAST(aggregate_limit AS DOUBLE))
      comment: "Total aggregate coverage limit across all policies — used to assess total institutional liability protection and identify under-insured providers."
    - name: "avg_aggregate_limit"
      expr: AVG(CAST(aggregate_limit AS DOUBLE))
      comment: "Average aggregate coverage limit per policy — used to benchmark coverage levels and identify providers below minimum required thresholds."
    - name: "coverage_lapse_count"
      expr: COUNT(CASE WHEN coverage_lapse_indicator = TRUE THEN 1 END)
      comment: "Count of coverage records with a lapse indicator — risk management metric; lapses create credentialing and privileging compliance issues."
    - name: "claims_history_count"
      expr: COUNT(CASE WHEN claims_history_indicator = TRUE THEN 1 END)
      comment: "Count of coverage records with a claims history — risk stratification metric used by Risk Management and Credentialing to identify high-risk providers."
    - name: "distinct_covered_clinicians"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Count of unique clinicians with malpractice coverage records — used to measure coverage breadth across the clinical workforce."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`provider_affiliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for clinician-to-organization affiliation management — affiliation type distribution, FTE allocation, primary affiliation coverage, and temporal affiliation trends. Used by Medical Staff, Workforce Planning, and Operations leadership."
  source: "`healthcare_ecm`.`provider`.`affiliation`"
  dimensions:
    - name: "affiliation_type"
      expr: affiliation_type
      comment: "Type of affiliation (e.g., Employed, Contracted, Voluntary) — used to segment workforce metrics by employment arrangement."
    - name: "medical_staff_category"
      expr: medical_staff_category
      comment: "Medical staff category (e.g., Active, Associate, Courtesy, Consulting) — used to analyze medical staff composition and voting rights distribution."
    - name: "primary_affiliation_flag"
      expr: primary_affiliation_flag
      comment: "Boolean flag indicating primary affiliation — used to identify each clinician's primary organizational relationship for workforce planning."
    - name: "source_system"
      expr: source_system
      comment: "Source system of record for the affiliation — used for data quality monitoring and reconciliation across HR and credentialing systems."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the affiliation became effective — used for cohort analysis of affiliation growth and workforce onboarding trends."
    - name: "end_year"
      expr: DATE_TRUNC('YEAR', end_date)
      comment: "Year the affiliation ended — used for attrition analysis and workforce turnover trend reporting."
  measures:
    - name: "total_affiliations"
      expr: COUNT(1)
      comment: "Total number of affiliation records — baseline count for organizational affiliation portfolio management."
    - name: "active_affiliations"
      expr: COUNT(CASE WHEN end_date IS NULL OR end_date > CURRENT_DATE THEN 1 END)
      comment: "Count of currently active affiliations (no end date or future end date) — primary workforce availability metric for staffing and capacity planning."
    - name: "primary_affiliations"
      expr: COUNT(CASE WHEN primary_affiliation_flag = TRUE THEN 1 END)
      comment: "Count of primary affiliation records — used to verify each clinician has a designated primary organizational relationship."
    - name: "total_fte"
      expr: SUM(CAST(fte_percentage AS DOUBLE))
      comment: "Total FTE percentage across all affiliations — workforce capacity metric used by Operations and Finance for staffing model and budget planning."
    - name: "avg_fte_percentage"
      expr: AVG(CAST(fte_percentage AS DOUBLE))
      comment: "Average FTE percentage per affiliation — used to benchmark workforce utilization and identify part-time vs. full-time workforce composition."
    - name: "distinct_affiliated_clinicians"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Count of unique clinicians with active or historical affiliations — used to measure organizational affiliation coverage across the provider workforce."
    - name: "distinct_affiliated_organizations"
      expr: COUNT(DISTINCT org_provider_id)
      comment: "Count of unique organizations with clinician affiliations — used to measure organizational network breadth and multi-site provider distribution."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`provider_group`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for provider group management — group status, credentialing compliance, network participation, telehealth capability, and payer enrollment. Used by Network Strategy, Contracting, and Provider Relations leadership."
  source: "`healthcare_ecm`.`provider`.`group`"
  dimensions:
    - name: "group_status"
      expr: group_status
      comment: "Current status of the provider group (e.g., Active, Terminated, Pending) — primary filter for group portfolio health dashboards."
    - name: "group_type"
      expr: group_type
      comment: "Type of provider group (e.g., Single Specialty, Multi-Specialty, IPA) — used to segment group metrics by organizational structure."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status of the group — used to identify groups pending credentialing that cannot yet participate in payer networks."
    - name: "network_participation_status"
      expr: network_participation_status
      comment: "Network participation status of the group — used to track in-network vs. out-of-network group distribution."
    - name: "medicaid_enrollment_status"
      expr: medicaid_enrollment_status
      comment: "Medicaid enrollment status of the group — used to assess Medicaid network coverage and access for low-income populations."
    - name: "medicare_enrollment_status"
      expr: medicare_enrollment_status
      comment: "Medicare enrollment status of the group — used to assess Medicare network coverage and PECOS enrollment compliance."
    - name: "payer_enrollment_status"
      expr: payer_enrollment_status
      comment: "Overall payer enrollment status of the group — used to track revenue readiness and billing activation across payer contracts."
    - name: "telehealth_capable"
      expr: telehealth_capable
      comment: "Boolean flag indicating telehealth capability — used to assess virtual care capacity across the provider group network."
    - name: "accepts_new_patients"
      expr: accepts_new_patients
      comment: "Boolean flag indicating whether the group is accepting new patients — used to measure patient access capacity across the group network."
    - name: "mips_eligible"
      expr: mips_eligible
      comment: "Boolean flag indicating MIPS eligibility — used to identify groups subject to value-based payment adjustments."
    - name: "fqhc_designation"
      expr: fqhc_designation
      comment: "Boolean flag indicating Federally Qualified Health Center designation — used to track safety-net provider coverage and federal funding eligibility."
    - name: "primary_service_state"
      expr: primary_service_state
      comment: "State of the group's primary service location — used for geographic network analysis and state-level adequacy reporting."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the group became effective — used for cohort analysis of group onboarding and network growth trends."
  measures:
    - name: "total_groups"
      expr: COUNT(1)
      comment: "Total number of provider group records — baseline count for group portfolio management."
    - name: "active_groups"
      expr: COUNT(CASE WHEN group_status = 'Active' THEN 1 END)
      comment: "Count of active provider groups — primary network composition metric used in network adequacy reporting and payer contracting."
    - name: "active_group_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN group_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of provider groups that are currently active — network health KPI used in payer contract compliance and adequacy filings."
    - name: "telehealth_capable_groups"
      expr: COUNT(CASE WHEN telehealth_capable = TRUE AND group_status = 'Active' THEN 1 END)
      comment: "Count of active telehealth-capable provider groups — virtual care capacity metric used by Digital Health and Network Strategy leadership."
    - name: "telehealth_capability_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN telehealth_capable = TRUE AND group_status = 'Active' THEN 1 END) / NULLIF(COUNT(CASE WHEN group_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active groups with telehealth capability — virtual care readiness KPI used in digital health strategy and payer negotiations."
    - name: "groups_accepting_new_patients"
      expr: COUNT(CASE WHEN accepts_new_patients = TRUE AND group_status = 'Active' THEN 1 END)
      comment: "Count of active groups accepting new patients — patient access metric used by Network Strategy to identify access gaps and guide recruitment."
    - name: "credentialing_expiring_within_90_days"
      expr: COUNT(CASE WHEN credentialing_expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) AND group_status = 'Active' THEN 1 END)
      comment: "Count of active groups with credentialing expiring within 90 days — compliance risk metric used to prioritize group recredentialing workload."
    - name: "mips_eligible_groups"
      expr: COUNT(CASE WHEN mips_eligible = TRUE AND group_status = 'Active' THEN 1 END)
      comment: "Count of active MIPS-eligible groups — value-based care metric used to scope quality reporting obligations and potential payment adjustments."
    - name: "fqhc_designated_groups"
      expr: COUNT(CASE WHEN fqhc_designation = TRUE AND group_status = 'Active' THEN 1 END)
      comment: "Count of active FQHC-designated groups — safety-net access metric used by Community Health and Government Programs leadership."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`provider_org_provider`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for organizational provider management — facility status, credentialing compliance, Medicare participation, OIG/SAM exclusion screening, and accreditation. Used by Network Strategy, Compliance, and Operations leadership."
  source: "`healthcare_ecm`.`provider`.`org_provider`"
  dimensions:
    - name: "provider_status"
      expr: provider_status
      comment: "Current status of the organizational provider (e.g., Active, Terminated, Suspended) — primary filter for org provider health dashboards."
    - name: "organization_type"
      expr: organization_type
      comment: "Type of organization (e.g., Hospital, Clinic, ASC, SNF) — used to segment org provider metrics by facility category."
    - name: "facility_type"
      expr: facility_type
      comment: "Facility type designation — used to analyze network composition by care setting and facility classification."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status of the organizational provider — used to identify facilities pending credentialing that cannot yet participate in payer networks."
    - name: "network_participation_status"
      expr: network_participation_status
      comment: "Network participation status — used to track in-network vs. out-of-network facility distribution."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Payer enrollment status of the organizational provider — used to track revenue readiness and billing activation."
    - name: "medicare_participation_flag"
      expr: medicare_participation_flag
      comment: "Boolean flag indicating Medicare participation — used to assess Medicare network coverage and CMS compliance."
    - name: "oig_exclusion_flag"
      expr: oig_exclusion_flag
      comment: "Boolean flag indicating OIG exclusion — critical compliance flag; excluded organizations cannot receive federal healthcare program payments."
    - name: "sam_exclusion_flag"
      expr: sam_exclusion_flag
      comment: "Boolean flag indicating SAM (System for Award Management) exclusion — federal compliance flag used by Compliance and Legal leadership."
    - name: "critical_access_hospital_flag"
      expr: critical_access_hospital_flag
      comment: "Boolean flag indicating Critical Access Hospital designation — used to track rural safety-net facility coverage and special Medicare reimbursement eligibility."
    - name: "teaching_status"
      expr: teaching_status
      comment: "Teaching status of the facility (e.g., Major Teaching, Minor Teaching, Non-Teaching) — used to segment facilities by academic mission and GME funding eligibility."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type of the organization (e.g., Non-Profit, For-Profit, Government) — used for network composition and strategic partnership analysis."
    - name: "state"
      expr: state
      comment: "State of the organizational provider — used for geographic network analysis and state-level adequacy reporting."
  measures:
    - name: "total_org_providers"
      expr: COUNT(1)
      comment: "Total number of organizational provider records — baseline count for facility network management."
    - name: "active_org_providers"
      expr: COUNT(CASE WHEN provider_status = 'Active' THEN 1 END)
      comment: "Count of active organizational providers — primary network size metric used in network adequacy reporting and payer contracting."
    - name: "active_org_provider_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN provider_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of organizational providers that are currently active — network health KPI used in payer contract compliance and adequacy filings."
    - name: "medicare_participating_facilities"
      expr: COUNT(CASE WHEN medicare_participation_flag = TRUE AND provider_status = 'Active' THEN 1 END)
      comment: "Count of active facilities participating in Medicare — network coverage metric used by Government Programs and Network Strategy leadership."
    - name: "oig_excluded_facilities"
      expr: COUNT(CASE WHEN oig_exclusion_flag = TRUE THEN 1 END)
      comment: "Count of facilities with OIG exclusion flags — critical compliance metric; any excluded facility must be immediately removed from federal program billing."
    - name: "sam_excluded_facilities"
      expr: COUNT(CASE WHEN sam_exclusion_flag = TRUE THEN 1 END)
      comment: "Count of facilities with SAM exclusion flags — federal compliance metric tracked by Compliance and Legal; excluded facilities cannot receive federal contracts or payments."
    - name: "credentialing_expiring_within_90_days"
      expr: COUNT(CASE WHEN credentialing_expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) AND provider_status = 'Active' THEN 1 END)
      comment: "Count of active org providers with credentialing expiring within 90 days — compliance risk metric used to prioritize facility recredentialing workload."
    - name: "critical_access_hospitals"
      expr: COUNT(CASE WHEN critical_access_hospital_flag = TRUE AND provider_status = 'Active' THEN 1 END)
      comment: "Count of active Critical Access Hospitals — rural access and safety-net metric used by Community Health and Government Programs leadership."
    - name: "state_license_expiring_within_90_days"
      expr: COUNT(CASE WHEN state_license_expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) AND provider_status = 'Active' THEN 1 END)
      comment: "Count of active org providers with state license expiring within 90 days — regulatory compliance metric; lapsed licenses can result in facility closure and billing suspension."
$$;