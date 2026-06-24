-- Metric views for domain: provider | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 16:05:56

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_clinician`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the clinician workforce — credentialing health, board certification rates, enrollment coverage, and workforce composition. Used by CMO, credentialing leadership, and network operations to steer provider quality and compliance."
  source: "`vibe_healthcare_v1`.`provider`.`clinician`"
  dimensions:
    - name: "clinician_type"
      expr: clinician_type
      comment: "Type of clinician (e.g., MD, DO, NP, PA) — used to segment workforce metrics by provider category."
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status of the clinician (e.g., active, terminated, on-leave) — used to filter active workforce metrics."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment arrangement (e.g., full-time, part-time, contracted) — used to analyze workforce composition."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Current credentialing status of the clinician — key compliance dimension for credentialing pipeline analysis."
    - name: "payer_enrollment_status"
      expr: payer_enrollment_status
      comment: "Status of the clinician's payer enrollment — used to track revenue-impacting enrollment gaps."
    - name: "license_state"
      expr: license_state
      comment: "State in which the clinician holds their primary license — used for geographic workforce distribution analysis."
    - name: "gender"
      expr: gender
      comment: "Clinician gender — used for workforce diversity reporting."
    - name: "medical_degree"
      expr: medical_degree
      comment: "Highest medical degree held (e.g., MD, DO, PhD) — used to segment clinical workforce by training level."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the clinician is currently active — primary filter for active workforce metrics."
    - name: "board_certified"
      expr: board_certified
      comment: "Boolean flag indicating board certification status — used to measure quality of the clinical workforce."
    - name: "medicare_enrolled"
      expr: medicare_enrolled
      comment: "Boolean flag indicating Medicare enrollment — used to assess revenue eligibility coverage."
    - name: "medicaid_enrolled"
      expr: medicaid_enrolled
      comment: "Boolean flag indicating Medicaid enrollment — used to assess safety-net coverage and compliance."
    - name: "hire_date_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month of hire date — used to analyze clinician onboarding trends over time."
    - name: "termination_date_month"
      expr: DATE_TRUNC('MONTH', termination_date)
      comment: "Month of termination — used to analyze attrition trends over time."
  measures:
    - name: "total_active_clinicians"
      expr: COUNT(CASE WHEN is_active = TRUE THEN clinician_id END)
      comment: "Total number of currently active clinicians. Core workforce size KPI used by CMO and network operations to assess provider capacity."
    - name: "board_certified_clinician_count"
      expr: COUNT(CASE WHEN board_certified = TRUE THEN clinician_id END)
      comment: "Number of clinicians who are board certified. Directly measures clinical quality of the workforce — a key credentialing and quality KPI."
    - name: "board_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN board_certified = TRUE THEN clinician_id END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN clinician_id END), 0), 2)
      comment: "Percentage of active clinicians who are board certified. Executive KPI for clinical quality — low rates trigger credentialing intervention and network quality reviews."
    - name: "medicare_enrollment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN medicare_enrolled = TRUE THEN clinician_id END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN clinician_id END), 0), 2)
      comment: "Percentage of active clinicians enrolled in Medicare. Revenue-critical KPI — unenrolled clinicians cannot bill Medicare, directly impacting reimbursement."
    - name: "medicaid_enrollment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN medicaid_enrolled = TRUE THEN clinician_id END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN clinician_id END), 0), 2)
      comment: "Percentage of active clinicians enrolled in Medicaid. Compliance and access KPI — low rates signal gaps in safety-net coverage and regulatory risk."
    - name: "primary_source_verified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN primary_source_verified = TRUE THEN clinician_id END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN clinician_id END), 0), 2)
      comment: "Percentage of active clinicians with completed primary source verification. Regulatory compliance KPI — NCQA and URAC credentialing standards require PSV completion."
    - name: "avg_board_certification_expiration_days"
      expr: AVG(CAST(board_certification_expiration_date AS DOUBLE))
      comment: "Average days until board certification expiration across clinicians. Operational KPI — declining values signal upcoming mass recertification workload for credentialing teams."
    - name: "avg_credentialing_expiration_days"
      expr: AVG(CAST(credentialing_expiration_date AS DOUBLE))
      comment: "Average days until credentialing expiration across clinicians. Credentialing operations KPI — used to forecast renewal workload and prevent lapses that block billing."
    - name: "avg_license_expiration_days"
      expr: AVG(CAST(license_expiration_date AS DOUBLE))
      comment: "Average days until state license expiration across clinicians. Compliance KPI — license lapses create immediate legal and billing risk; monitored by credentialing leadership."
    - name: "oig_exclusion_checked_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN oig_exclusion_checked = TRUE THEN clinician_id END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN clinician_id END), 0), 2)
      comment: "Percentage of active clinicians with a completed OIG exclusion check. Regulatory compliance KPI — billing for excluded providers triggers federal False Claims Act liability."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_board_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs tracking board certification portfolio health — certification status distribution, expiration risk, MOC compliance, and recertification cycle management. Used by credentialing leadership and CMO to ensure clinical quality standards."
  source: "`vibe_healthcare_v1`.`provider`.`board_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the board certification (e.g., active, expired, revoked) — primary filter for certification health analysis."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of board certification — used to segment certification metrics by specialty category."
    - name: "certifying_board_name"
      expr: certifying_board_name
      comment: "Name of the certifying board (e.g., ABIM, ABS) — used to analyze certification distribution across boards."
    - name: "certifying_organization_type"
      expr: certifying_organization_type
      comment: "Type of certifying organization — used to group certifications by organizational category."
    - name: "moc_status"
      expr: moc_status
      comment: "Maintenance of Certification (MOC) program status — used to track ongoing recertification compliance."
    - name: "verification_status"
      expr: verification_status
      comment: "Status of certification verification — used to identify certifications pending or failing primary source verification."
    - name: "is_primary_specialty"
      expr: is_primary_specialty
      comment: "Boolean flag indicating whether this certification is for the clinician's primary specialty — used to prioritize primary specialty certification metrics."
    - name: "is_lifetime_certification"
      expr: is_lifetime_certification
      comment: "Boolean flag indicating lifetime certification — used to exclude lifetime certs from expiration risk calculations."
    - name: "board_certification_status"
      expr: board_certification_status
      comment: "Overall board certification status — used as a high-level status dimension for certification portfolio views."
    - name: "effective_date_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year of certification effective date — used to analyze certification issuance trends over time."
    - name: "expiration_date_year"
      expr: DATE_TRUNC('YEAR', expiration_date)
      comment: "Year of certification expiration — used to forecast upcoming expiration volumes by year."
  measures:
    - name: "total_active_certifications"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN board_certification_id END)
      comment: "Total number of active board certifications across all clinicians. Core portfolio size KPI for credentialing leadership."
    - name: "expiring_certifications_90_days"
      expr: COUNT(CASE WHEN certification_status = 'Active' AND is_lifetime_certification = FALSE AND expiration_date <= DATE_ADD(CURRENT_DATE(), 90) AND expiration_date >= CURRENT_DATE() THEN board_certification_id END)
      comment: "Number of active, non-lifetime certifications expiring within 90 days. Operational urgency KPI — drives credentialing team workload prioritization and clinician outreach."
    - name: "expired_certification_count"
      expr: COUNT(CASE WHEN expiration_date < CURRENT_DATE() AND is_lifetime_certification = FALSE THEN board_certification_id END)
      comment: "Number of certifications that have passed their expiration date. Compliance risk KPI — expired certifications may violate payer contracts and hospital bylaws."
    - name: "moc_compliant_count"
      expr: COUNT(CASE WHEN moc_status = 'Compliant' THEN board_certification_id END)
      comment: "Number of certifications with compliant MOC status. Quality KPI — MOC compliance is required by many health systems and payers as a condition of participation."
    - name: "moc_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN moc_status = 'Compliant' THEN board_certification_id END) / NULLIF(COUNT(CASE WHEN certification_status = 'Active' AND is_lifetime_certification = FALSE THEN board_certification_id END), 0), 2)
      comment: "Percentage of active, non-lifetime certifications with compliant MOC status. Strategic quality KPI — low MOC compliance rates signal systemic recertification risk across the medical staff."
    - name: "primary_source_verified_certification_count"
      expr: COUNT(CASE WHEN verification_status = 'Verified' THEN board_certification_id END)
      comment: "Number of certifications with completed primary source verification. Regulatory compliance KPI — NCQA credentialing standards mandate PSV for board certifications."
    - name: "revoked_certification_count"
      expr: COUNT(CASE WHEN revocation_date IS NOT NULL THEN board_certification_id END)
      comment: "Number of certifications that have been revoked. Risk and quality KPI — revocations signal serious clinical quality or conduct issues requiring immediate leadership attention."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_credential`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for the provider credentialing portfolio — expiration risk, verification compliance, CME tracking, and DEA authorization coverage. Used by credentialing operations, compliance, and medical staff leadership."
  source: "`vibe_healthcare_v1`.`provider`.`credential`"
  dimensions:
    - name: "credential_type"
      expr: credential_type
      comment: "Type of credential (e.g., state license, DEA, CME, malpractice) — primary segmentation dimension for credential portfolio analysis."
    - name: "credential_status"
      expr: credential_status
      comment: "Current status of the credential (e.g., active, expired, pending) — used to filter and segment credential health metrics."
    - name: "issuing_state"
      expr: issuing_state
      comment: "State that issued the credential — used for geographic compliance analysis and multi-state licensure tracking."
    - name: "issuing_authority_name"
      expr: issuing_authority_name
      comment: "Name of the issuing authority — used to segment credentials by regulatory body."
    - name: "moc_status"
      expr: moc_status
      comment: "MOC status associated with the credential — used to track ongoing recertification compliance."
    - name: "primary_source_verified"
      expr: primary_source_verified
      comment: "Boolean flag indicating primary source verification completion — key compliance dimension."
    - name: "payer_enrollment_relevant"
      expr: payer_enrollment_relevant
      comment: "Boolean flag indicating whether this credential is relevant to payer enrollment — used to prioritize revenue-impacting credential renewals."
    - name: "privileging_relevant"
      expr: privileging_relevant
      comment: "Boolean flag indicating whether this credential is relevant to clinical privileging — used to prioritize patient safety-critical renewals."
    - name: "cme_activity_type"
      expr: cme_activity_type
      comment: "Type of CME activity — used to analyze CME credit distribution by activity category."
    - name: "cme_category"
      expr: cme_category
      comment: "CME category (e.g., AMA PRA Category 1) — used to segment CME compliance metrics by accreditation category."
    - name: "effective_from_year"
      expr: DATE_TRUNC('YEAR', effective_from)
      comment: "Year the credential became effective — used to analyze credential issuance trends over time."
    - name: "recredentialing_due_date_month"
      expr: DATE_TRUNC('MONTH', recredentialing_due_date)
      comment: "Month recredentialing is due — used to forecast credentialing renewal workload by month."
  measures:
    - name: "total_active_credentials"
      expr: COUNT(CASE WHEN credential_status = 'Active' THEN credential_id END)
      comment: "Total number of active credentials across all clinicians. Core portfolio size KPI for credentialing operations."
    - name: "credentials_expiring_90_days"
      expr: COUNT(CASE WHEN credential_status = 'Active' AND CAST(expiration_date AS DOUBLE) > 0 AND CAST(expiration_date AS DOUBLE) <= 90 THEN credential_id END)
      comment: "Number of active credentials expiring within 90 days (using days_to_expiration proxy). Operational urgency KPI — drives credentialing team renewal prioritization."
    - name: "avg_days_to_expiration"
      expr: AVG(CAST(days_to_expiration AS DOUBLE))
      comment: "Average days to expiration across all active credentials. Portfolio health KPI — declining averages signal an approaching wave of credential renewals requiring resource planning."
    - name: "primary_source_verified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN primary_source_verified = TRUE THEN credential_id END) / NULLIF(COUNT(CASE WHEN credential_status = 'Active' THEN credential_id END), 0), 2)
      comment: "Percentage of active credentials with completed primary source verification. Regulatory compliance KPI — NCQA and URAC standards mandate PSV; low rates create accreditation risk."
    - name: "total_cme_credit_hours"
      expr: SUM(CAST(cme_credit_hours AS DOUBLE))
      comment: "Total CME credit hours accumulated across all credential records. Compliance KPI — state licensing boards and specialty societies require minimum CME hours for license renewal."
    - name: "avg_cme_credit_hours_per_credential"
      expr: AVG(CAST(cme_credit_hours AS DOUBLE))
      comment: "Average CME credit hours per credential record. Quality KPI — used to identify clinicians at risk of falling below minimum CME requirements for license renewal."
    - name: "npdb_queried_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN npdb_queried = TRUE THEN credential_id END) / NULLIF(COUNT(CASE WHEN credential_status = 'Active' THEN credential_id END), 0), 2)
      comment: "Percentage of active credentials with a completed NPDB query. Compliance KPI — HCQIA mandates NPDB queries at initial credentialing and every 2 years; gaps create legal liability."
    - name: "oig_exclusion_checked_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN oig_exclusion_checked = TRUE THEN credential_id END) / NULLIF(COUNT(CASE WHEN credential_status = 'Active' THEN credential_id END), 0), 2)
      comment: "Percentage of active credentials with a completed OIG exclusion check. Federal compliance KPI — billing for OIG-excluded providers triggers False Claims Act penalties."
    - name: "board_action_flag_count"
      expr: COUNT(CASE WHEN board_action_flag = TRUE THEN credential_id END)
      comment: "Number of credentials with a board action flag. Risk KPI — board actions signal serious disciplinary events requiring immediate credentialing committee review."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_dea_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for DEA registration portfolio management — schedule authorization coverage, expiration risk, fee tracking, and compliance monitoring. Used by compliance leadership, pharmacy operations, and credentialing teams."
  source: "`vibe_healthcare_v1`.`provider`.`dea_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current DEA registration status (e.g., active, expired, revoked) — primary filter for DEA compliance metrics."
    - name: "registration_state"
      expr: registration_state
      comment: "State of DEA registration — used for geographic compliance analysis and multi-state prescribing coverage."
    - name: "registration_type"
      expr: registration_type
      comment: "Type of DEA registration — used to segment registrations by practitioner category."
    - name: "business_activity_type"
      expr: business_activity_type
      comment: "DEA business activity type — used to classify registrations by practice setting."
    - name: "practitioner_type_code"
      expr: practitioner_type_code
      comment: "DEA practitioner type code — used to segment prescribing authority metrics by provider type."
    - name: "schedule_ii_authorized"
      expr: schedule_ii_authorized
      comment: "Boolean flag for Schedule II controlled substance authorization — used to assess high-risk prescribing authority coverage."
    - name: "pdmp_reporting_required"
      expr: pdmp_reporting_required
      comment: "Boolean flag indicating PDMP reporting requirement — used to identify registrations subject to prescription drug monitoring compliance."
    - name: "fee_exempt"
      expr: fee_exempt
      comment: "Boolean flag indicating DEA fee exemption — used to segment fee-bearing vs. exempt registrations for financial planning."
    - name: "expiration_date_year"
      expr: DATE_TRUNC('YEAR', expiration_date)
      comment: "Year of DEA registration expiration — used to forecast renewal volumes and fee obligations by year."
    - name: "registration_date_year"
      expr: DATE_TRUNC('YEAR', registration_date)
      comment: "Year of initial DEA registration — used to analyze registration issuance trends."
  measures:
    - name: "total_active_dea_registrations"
      expr: COUNT(CASE WHEN registration_status = 'Active' THEN dea_registration_id END)
      comment: "Total number of active DEA registrations. Core prescribing authority KPI — directly measures the organization's controlled substance prescribing capacity."
    - name: "dea_registrations_expiring_90_days"
      expr: COUNT(CASE WHEN registration_status = 'Active' AND expiration_date <= DATE_ADD(CURRENT_DATE(), 90) AND expiration_date >= CURRENT_DATE() THEN dea_registration_id END)
      comment: "Number of active DEA registrations expiring within 90 days. Operational urgency KPI — expired DEA registrations immediately halt controlled substance prescribing."
    - name: "total_dea_registration_fees"
      expr: SUM(CASE WHEN fee_exempt = FALSE THEN CAST(fee_amount AS DOUBLE) ELSE 0 END)
      comment: "Total DEA registration fees for non-exempt registrations. Financial KPI — used for budget planning and cost management of DEA compliance program."
    - name: "avg_dea_registration_fee"
      expr: AVG(CASE WHEN fee_exempt = FALSE THEN CAST(fee_amount AS DOUBLE) END)
      comment: "Average DEA registration fee for non-exempt registrations. Financial benchmarking KPI — used to assess per-registration cost and identify anomalies."
    - name: "schedule_ii_authorization_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN schedule_ii_authorized = TRUE AND registration_status = 'Active' THEN dea_registration_id END) / NULLIF(COUNT(CASE WHEN registration_status = 'Active' THEN dea_registration_id END), 0), 2)
      comment: "Percentage of active DEA registrations with Schedule II authorization. Clinical capability KPI — Schedule II authorization is required for high-acuity pain management and oncology prescribing."
    - name: "x_waiver_authorized_count"
      expr: COUNT(CASE WHEN x_waiver_authorized = TRUE AND registration_status = 'Active' THEN dea_registration_id END)
      comment: "Number of active DEA registrations with X-waiver (buprenorphine) authorization. Access and quality KPI — X-waiver capacity directly measures the organization's opioid use disorder treatment capability."
    - name: "revoked_dea_registration_count"
      expr: COUNT(CASE WHEN revocation_date IS NOT NULL THEN dea_registration_id END)
      comment: "Number of DEA registrations that have been revoked. Compliance risk KPI — DEA revocations signal serious regulatory violations requiring immediate leadership escalation."
    - name: "expiration_alert_sent_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN expiration_alert_sent = TRUE THEN dea_registration_id END) / NULLIF(COUNT(CASE WHEN registration_status = 'Active' THEN dea_registration_id END), 0), 2)
      comment: "Percentage of active DEA registrations for which an expiration alert has been sent. Operational process KPI — low rates indicate gaps in the renewal notification workflow, increasing lapse risk."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_network_affiliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for provider network participation — network adequacy, panel capacity, telehealth coverage, credentialing compliance, and directory accuracy. Used by network management, contracting, and regulatory affairs teams."
  source: "`vibe_healthcare_v1`.`provider`.`network_affiliation`"
  dimensions:
    - name: "affiliation_status"
      expr: affiliation_status
      comment: "Current network affiliation status (e.g., active, terminated, pending) — primary filter for network participation metrics."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier designation (e.g., preferred, standard, out-of-network) — used to analyze provider distribution across network tiers."
    - name: "participation_type"
      expr: participation_type
      comment: "Type of network participation (e.g., in-network, preferred, exclusive) — used to segment network metrics by participation category."
    - name: "network_adequacy_category"
      expr: network_adequacy_category
      comment: "Network adequacy category assigned to this affiliation — used for regulatory network adequacy reporting."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status of the affiliated provider — used to identify network providers with credentialing compliance gaps."
    - name: "panel_status"
      expr: panel_status
      comment: "Panel open/closed status — used to track patient access capacity across the network."
    - name: "accepts_new_patients"
      expr: accepts_new_patients
      comment: "Boolean flag indicating whether the provider is accepting new patients — key access metric for network adequacy."
    - name: "telehealth_eligible"
      expr: telehealth_eligible
      comment: "Boolean flag indicating telehealth eligibility — used to measure virtual care capacity within the network."
    - name: "primary_care_designation"
      expr: primary_care_designation
      comment: "Boolean flag indicating primary care designation — used to segment network adequacy metrics by care level."
    - name: "service_area_state"
      expr: service_area_state
      comment: "State of the provider's service area — used for geographic network adequacy analysis and regulatory reporting."
    - name: "gender_served"
      expr: gender_served
      comment: "Gender(s) served by the provider — used for network access equity analysis."
    - name: "reimbursement_model"
      expr: reimbursement_model
      comment: "Reimbursement model for this affiliation (e.g., FFS, capitation, value-based) — used to analyze network composition by payment model."
    - name: "effective_date_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the network affiliation became effective — used to analyze network growth trends over time."
  measures:
    - name: "total_active_network_affiliations"
      expr: COUNT(CASE WHEN affiliation_status = 'Active' THEN network_affiliation_id END)
      comment: "Total number of active provider network affiliations. Core network size KPI — used by network management to track overall network capacity."
    - name: "accepting_new_patients_count"
      expr: COUNT(CASE WHEN accepts_new_patients = TRUE AND affiliation_status = 'Active' THEN network_affiliation_id END)
      comment: "Number of active network affiliations where the provider is accepting new patients. Access KPI — directly measures patient access capacity; low values trigger network adequacy interventions."
    - name: "accepting_new_patients_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN accepts_new_patients = TRUE AND affiliation_status = 'Active' THEN network_affiliation_id END) / NULLIF(COUNT(CASE WHEN affiliation_status = 'Active' THEN network_affiliation_id END), 0), 2)
      comment: "Percentage of active network providers accepting new patients. Network adequacy KPI — regulators and payers use this to assess member access; low rates trigger corrective action plans."
    - name: "telehealth_eligible_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN telehealth_eligible = TRUE AND affiliation_status = 'Active' THEN network_affiliation_id END) / NULLIF(COUNT(CASE WHEN affiliation_status = 'Active' THEN network_affiliation_id END), 0), 2)
      comment: "Percentage of active network providers eligible for telehealth. Strategic KPI — telehealth coverage is a key differentiator for payer contracting and member access in rural/underserved areas."
    - name: "directory_published_count"
      expr: COUNT(CASE WHEN directory_published_flag = TRUE AND affiliation_status = 'Active' THEN network_affiliation_id END)
      comment: "Number of active affiliations published in the provider directory. Compliance KPI — CMS and state regulators require accurate, up-to-date provider directories; gaps trigger penalties."
    - name: "directory_accuracy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN directory_published_flag = TRUE AND affiliation_status = 'Active' THEN network_affiliation_id END) / NULLIF(COUNT(CASE WHEN affiliation_status = 'Active' THEN network_affiliation_id END), 0), 2)
      comment: "Percentage of active network affiliations published in the provider directory. Regulatory compliance KPI — CMS No Surprises Act and state laws mandate directory accuracy; low rates create significant penalty risk."
    - name: "credentialing_compliant_network_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN credentialing_status = 'Active' AND affiliation_status = 'Active' THEN network_affiliation_id END) / NULLIF(COUNT(CASE WHEN affiliation_status = 'Active' THEN network_affiliation_id END), 0), 2)
      comment: "Percentage of active network affiliations with active credentialing status. Quality and compliance KPI — non-credentialed network providers create patient safety risk and payer contract violations."
    - name: "terminated_affiliations_count"
      expr: COUNT(CASE WHEN termination_date IS NOT NULL AND termination_date <= CURRENT_DATE() THEN network_affiliation_id END)
      comment: "Number of network affiliations that have been terminated. Network attrition KPI — high termination counts signal network instability, impacting adequacy and member continuity of care."
    - name: "mips_eligible_network_count"
      expr: COUNT(CASE WHEN mips_eligible = TRUE AND affiliation_status = 'Active' THEN network_affiliation_id END)
      comment: "Number of active network affiliations where the provider is MIPS eligible. Value-based care KPI — MIPS performance directly impacts Medicare reimbursement rates for the network."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_privileging`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for clinical privileging portfolio management — privilege status, FPPE/OPPE compliance, peer review performance, expiration risk, and telemedicine authorization. Used by medical staff leadership, CMO, and quality management."
  source: "`vibe_healthcare_v1`.`provider`.`privileging`"
  dimensions:
    - name: "privilege_status"
      expr: privilege_status
      comment: "Current status of the clinical privilege (e.g., active, suspended, revoked, expired) — primary filter for privileging compliance metrics."
    - name: "privilege_category"
      expr: privilege_category
      comment: "Category of the clinical privilege — used to segment privileging metrics by clinical service line."
    - name: "privilege_type"
      expr: privilege_type
      comment: "Type of clinical privilege (e.g., core, special, temporary) — used to analyze privilege portfolio composition."
    - name: "is_provisional"
      expr: is_provisional
      comment: "Boolean flag indicating provisional privilege status — used to track new providers under focused evaluation."
    - name: "fppe_required"
      expr: fppe_required
      comment: "Boolean flag indicating FPPE (Focused Professional Practice Evaluation) requirement — used to monitor new or at-risk providers."
    - name: "board_certification_required"
      expr: board_certification_required
      comment: "Boolean flag indicating board certification is required for this privilege — used to identify high-standards privileges."
    - name: "telemedicine_authorized"
      expr: telemedicine_authorized
      comment: "Boolean flag indicating telemedicine authorization for this privilege — used to measure virtual care privileging coverage."
    - name: "emtala_covered"
      expr: emtala_covered
      comment: "Boolean flag indicating EMTALA coverage for this privilege — used for emergency care compliance analysis."
    - name: "privilege_name"
      expr: privilege_name
      comment: "Name of the clinical privilege — used to analyze metrics at the individual privilege level."
    - name: "approval_date_year"
      expr: DATE_TRUNC('YEAR', approval_date)
      comment: "Year of privilege approval — used to analyze privileging volume trends over time."
    - name: "oppe_last_review_date_quarter"
      expr: DATE_TRUNC('QUARTER', oppe_last_review_date)
      comment: "Quarter of last OPPE review — used to identify providers overdue for ongoing performance evaluation."
  measures:
    - name: "total_active_privileges"
      expr: COUNT(CASE WHEN privilege_status = 'Active' THEN privileging_id END)
      comment: "Total number of active clinical privileges. Core medical staff KPI — measures the breadth of authorized clinical services across the organization."
    - name: "provisional_privilege_count"
      expr: COUNT(CASE WHEN is_provisional = TRUE AND privilege_status = 'Active' THEN privileging_id END)
      comment: "Number of active provisional privileges. Quality oversight KPI — provisional privileges require FPPE monitoring; high counts signal elevated supervisory workload for department chairs."
    - name: "fppe_required_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fppe_required = TRUE AND fppe_completion_date IS NOT NULL THEN privileging_id END) / NULLIF(COUNT(CASE WHEN fppe_required = TRUE THEN privileging_id END), 0), 2)
      comment: "Percentage of privileges requiring FPPE that have a completed FPPE. Joint Commission compliance KPI — incomplete FPPEs for active providers create accreditation risk."
    - name: "avg_peer_review_score"
      expr: AVG(CAST(peer_review_score AS DOUBLE))
      comment: "Average peer review score across privileged providers. Clinical quality KPI — declining scores trigger quality committee review and potential privilege modification."
    - name: "suspended_privilege_count"
      expr: COUNT(CASE WHEN suspension_date IS NOT NULL AND revocation_date IS NULL THEN privileging_id END)
      comment: "Number of privileges currently under suspension. Patient safety KPI — suspended privileges indicate active quality or conduct investigations requiring immediate leadership attention."
    - name: "revoked_privilege_count"
      expr: COUNT(CASE WHEN revocation_date IS NOT NULL THEN privileging_id END)
      comment: "Number of privileges that have been revoked. Risk and quality KPI — privilege revocations are NPDB-reportable events with significant legal and reputational implications."
    - name: "telemedicine_authorized_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN telemedicine_authorized = TRUE AND privilege_status = 'Active' THEN privileging_id END) / NULLIF(COUNT(CASE WHEN privilege_status = 'Active' THEN privileging_id END), 0), 2)
      comment: "Percentage of active privileges with telemedicine authorization. Strategic KPI — telemedicine privileging coverage directly impacts the organization's virtual care capacity and revenue."
    - name: "npdb_report_required_count"
      expr: COUNT(CASE WHEN npdb_report_required = TRUE THEN privileging_id END)
      comment: "Number of privileges with an NPDB report required. Compliance risk KPI — HCQIA mandates NPDB reporting for adverse privilege actions; unreported actions create federal liability."
    - name: "avg_peer_review_score_provisional"
      expr: AVG(CASE WHEN is_provisional = TRUE THEN CAST(peer_review_score AS DOUBLE) END)
      comment: "Average peer review score for provisional privileges only. Quality oversight KPI — used by department chairs to evaluate new providers under FPPE and make permanent privilege decisions."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_group`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for provider group management — network participation, credentialing compliance, telehealth capability, value-based care readiness, and enrollment status. Used by network contracting, operations, and executive leadership."
  source: "`vibe_healthcare_v1`.`provider`.`group`"
  dimensions:
    - name: "group_status"
      expr: group_status
      comment: "Current status of the provider group (e.g., active, terminated, pending) — primary filter for group portfolio metrics."
    - name: "group_type"
      expr: group_type
      comment: "Type of provider group (e.g., single-specialty, multi-specialty, IPA) — used to segment group metrics by organizational model."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status of the group — used to identify groups with compliance gaps."
    - name: "network_participation_status"
      expr: network_participation_status
      comment: "Network participation status of the group — used to analyze in-network vs. out-of-network group distribution."
    - name: "medicare_enrollment_status"
      expr: medicare_enrollment_status
      comment: "Medicare enrollment status of the group — used to assess Medicare billing eligibility across the group portfolio."
    - name: "medicaid_enrollment_status"
      expr: medicaid_enrollment_status
      comment: "Medicaid enrollment status of the group — used to assess safety-net coverage and compliance."
    - name: "primary_service_state"
      expr: primary_service_state
      comment: "State of the group's primary service location — used for geographic distribution and network adequacy analysis."
    - name: "telehealth_capable"
      expr: telehealth_capable
      comment: "Boolean flag indicating telehealth capability — used to measure virtual care readiness across the group network."
    - name: "mips_eligible"
      expr: mips_eligible
      comment: "Boolean flag indicating MIPS eligibility — used to identify groups subject to value-based payment adjustments."
    - name: "mips_group_reporting"
      expr: mips_group_reporting
      comment: "Boolean flag indicating MIPS group reporting election — used to track value-based care program participation."
    - name: "aco_participant"
      expr: aco_participant
      comment: "Boolean flag indicating ACO participation — used to segment groups by value-based care model participation."
    - name: "accepts_new_patients"
      expr: accepts_new_patients
      comment: "Boolean flag indicating whether the group is accepting new patients — key access metric for network adequacy."
    - name: "contract_effective_date_year"
      expr: DATE_TRUNC('YEAR', contract_effective_date)
      comment: "Year the group contract became effective — used to analyze contracting trends over time."
  measures:
    - name: "total_active_groups"
      expr: COUNT(CASE WHEN group_status = 'Active' THEN group_id END)
      comment: "Total number of active provider groups. Core network composition KPI — used by network management to track group-level network capacity."
    - name: "telehealth_capable_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN telehealth_capable = TRUE AND group_status = 'Active' THEN group_id END) / NULLIF(COUNT(CASE WHEN group_status = 'Active' THEN group_id END), 0), 2)
      comment: "Percentage of active groups with telehealth capability. Strategic KPI — telehealth-capable groups expand virtual access; low rates signal investment gaps in digital care delivery."
    - name: "mips_eligible_group_count"
      expr: COUNT(CASE WHEN mips_eligible = TRUE AND group_status = 'Active' THEN group_id END)
      comment: "Number of active MIPS-eligible groups. Value-based care KPI — MIPS performance directly impacts Medicare reimbursement; tracking eligible groups drives quality program management."
    - name: "mips_group_reporting_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mips_group_reporting = TRUE AND group_status = 'Active' THEN group_id END) / NULLIF(COUNT(CASE WHEN mips_eligible = TRUE AND group_status = 'Active' THEN group_id END), 0), 2)
      comment: "Percentage of MIPS-eligible active groups electing group reporting. Value-based care strategy KPI — group reporting can optimize MIPS scores; low adoption rates signal missed reimbursement optimization opportunities."
    - name: "aco_participant_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN aco_participant = TRUE AND group_status = 'Active' THEN group_id END) / NULLIF(COUNT(CASE WHEN group_status = 'Active' THEN group_id END), 0), 2)
      comment: "Percentage of active groups participating in an ACO. Value-based care transformation KPI — ACO participation rate reflects the organization's progress toward risk-based contracting."
    - name: "credentialing_compliant_group_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN credentialing_status = 'Active' AND group_status = 'Active' THEN group_id END) / NULLIF(COUNT(CASE WHEN group_status = 'Active' THEN group_id END), 0), 2)
      comment: "Percentage of active groups with active credentialing status. Compliance KPI — non-credentialed groups cannot participate in payer networks, creating revenue and access risk."
    - name: "accepting_new_patients_group_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN accepts_new_patients = TRUE AND group_status = 'Active' THEN group_id END) / NULLIF(COUNT(CASE WHEN group_status = 'Active' THEN group_id END), 0), 2)
      comment: "Percentage of active groups accepting new patients. Network access KPI — low rates signal capacity constraints that may trigger network adequacy deficiency findings from regulators."
    - name: "terminated_groups_count"
      expr: COUNT(CASE WHEN termination_date IS NOT NULL AND termination_date <= CURRENT_DATE() THEN group_id END)
      comment: "Number of groups with a past termination date. Network attrition KPI — high termination counts signal network instability and potential access gaps requiring contracting intervention."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_group_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for provider group membership — workforce composition, credentialing compliance, FTE allocation, MIPS participation, and membership attrition. Used by medical staff leadership, HR, and network operations."
  source: "`vibe_healthcare_v1`.`provider`.`group_membership`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current membership status (e.g., active, terminated, suspended) — primary filter for active membership metrics."
    - name: "membership_role"
      expr: membership_role
      comment: "Role of the clinician within the group (e.g., attending, resident, fellow) — used to segment workforce metrics by clinical role."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment arrangement within the group (e.g., employed, contracted, voluntary) — used to analyze workforce composition."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status of the group member — used to identify members with compliance gaps."
    - name: "privileging_status"
      expr: privileging_status
      comment: "Privileging status of the group member — used to identify members without active clinical privileges."
    - name: "medical_staff_category"
      expr: medical_staff_category
      comment: "Medical staff category (e.g., active, associate, courtesy) — used to segment medical staff metrics by appointment category."
    - name: "network_participation_status"
      expr: network_participation_status
      comment: "Network participation status of the member — used to analyze in-network vs. out-of-network membership."
    - name: "mips_eligible"
      expr: mips_eligible
      comment: "Boolean flag indicating MIPS eligibility for this membership — used to track value-based care program participation."
    - name: "is_primary_affiliation"
      expr: is_primary_affiliation
      comment: "Boolean flag indicating this is the clinician's primary group affiliation — used to identify primary employment relationships."
    - name: "is_accepting_patients"
      expr: is_accepting_patients
      comment: "Boolean flag indicating whether the member is accepting patients — used for panel capacity analysis."
    - name: "departure_reason"
      expr: departure_reason
      comment: "Reason for membership departure — used to analyze attrition patterns and identify retention risk factors."
    - name: "effective_date_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the membership became effective — used to analyze membership growth trends over time."
  measures:
    - name: "total_active_memberships"
      expr: COUNT(CASE WHEN membership_status = 'Active' THEN group_membership_id END)
      comment: "Total number of active group memberships. Core workforce size KPI — measures total provider headcount across all group affiliations."
    - name: "total_fte_allocation"
      expr: SUM(CASE WHEN membership_status = 'Active' THEN CAST(fte_allocation AS DOUBLE) ELSE 0 END)
      comment: "Total FTE allocation across all active group memberships. Workforce capacity KPI — total FTE directly drives clinical throughput, scheduling capacity, and revenue potential."
    - name: "avg_fte_allocation"
      expr: AVG(CASE WHEN membership_status = 'Active' THEN CAST(fte_allocation AS DOUBLE) END)
      comment: "Average FTE allocation per active group membership. Workforce efficiency KPI — low averages may indicate over-reliance on part-time providers, impacting care continuity."
    - name: "credentialing_compliant_membership_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN credentialing_status = 'Active' AND membership_status = 'Active' THEN group_membership_id END) / NULLIF(COUNT(CASE WHEN membership_status = 'Active' THEN group_membership_id END), 0), 2)
      comment: "Percentage of active group members with active credentialing status. Compliance KPI — non-credentialed members cannot bill payers, creating immediate revenue risk."
    - name: "accepting_patients_membership_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_accepting_patients = TRUE AND membership_status = 'Active' THEN group_membership_id END) / NULLIF(COUNT(CASE WHEN membership_status = 'Active' THEN group_membership_id END), 0), 2)
      comment: "Percentage of active group members accepting patients. Access capacity KPI — low rates signal panel capacity constraints requiring network expansion or access improvement initiatives."
    - name: "mips_eligible_membership_count"
      expr: COUNT(CASE WHEN mips_eligible = TRUE AND membership_status = 'Active' THEN group_membership_id END)
      comment: "Number of active MIPS-eligible group memberships. Value-based care KPI — MIPS-eligible provider count determines the scope of quality reporting obligations and reimbursement impact."
    - name: "voluntary_separation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_voluntary_separation = TRUE AND end_date IS NOT NULL THEN group_membership_id END) / NULLIF(COUNT(CASE WHEN end_date IS NOT NULL THEN group_membership_id END), 0), 2)
      comment: "Percentage of terminated memberships that were voluntary separations. Workforce retention KPI — high voluntary separation rates signal retention problems requiring HR and leadership intervention."
    - name: "npdb_report_required_count"
      expr: COUNT(CASE WHEN npdb_report_required = TRUE THEN group_membership_id END)
      comment: "Number of group memberships with an NPDB report required. Compliance risk KPI — unreported adverse membership actions create federal HCQIA liability for the organization."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`provider_org_provider`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for organizational provider (facility) management — accreditation status, credentialing compliance, Medicare participation, OIG/SAM exclusion risk, and network participation. Used by facility management, compliance, and executive leadership."
  source: "`vibe_healthcare_v1`.`provider`.`org_provider`"
  dimensions:
    - name: "provider_status"
      expr: provider_status
      comment: "Current status of the organizational provider (e.g., active, inactive, terminated) — primary filter for facility portfolio metrics."
    - name: "organization_type"
      expr: organization_type
      comment: "Type of organization (e.g., hospital, clinic, ASC, SNF) — used to segment facility metrics by care setting."
    - name: "facility_type"
      expr: facility_type
      comment: "Specific facility type — used for detailed facility portfolio analysis."
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Accreditation status of the facility (e.g., accredited, provisional, not accredited) — used to monitor accreditation compliance."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status of the organizational provider — used to identify facilities with compliance gaps."
    - name: "network_participation_status"
      expr: network_participation_status
      comment: "Network participation status — used to analyze in-network vs. out-of-network facility distribution."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Enrollment status with payers — used to assess billing eligibility across the facility portfolio."
    - name: "state"
      expr: state
      comment: "State where the facility is located — used for geographic distribution and regulatory compliance analysis."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type of the facility (e.g., non-profit, for-profit, government) — used to segment facilities by ownership model."
    - name: "teaching_status"
      expr: teaching_status
      comment: "Teaching status of the facility (e.g., major teaching, minor teaching, non-teaching) — used for academic medical center analysis."
    - name: "medicare_participation_flag"
      expr: medicare_participation_flag
      comment: "Boolean flag indicating Medicare participation — used to assess Medicare billing eligibility across the facility portfolio."
    - name: "critical_access_hospital_flag"
      expr: critical_access_hospital_flag
      comment: "Boolean flag indicating Critical Access Hospital designation — used for rural health policy and reimbursement analysis."
    - name: "effective_date_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the organizational provider became effective — used to analyze facility onboarding trends."
  measures:
    - name: "total_active_org_providers"
      expr: COUNT(CASE WHEN provider_status = 'Active' THEN org_provider_id END)
      comment: "Total number of active organizational providers. Core facility portfolio KPI — measures the breadth of the organization's facility network."
    - name: "accredited_facility_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN accreditation_status = 'Accredited' AND provider_status = 'Active' THEN org_provider_id END) / NULLIF(COUNT(CASE WHEN provider_status = 'Active' THEN org_provider_id END), 0), 2)
      comment: "Percentage of active facilities with full accreditation. Quality and compliance KPI — accreditation is required for Medicare/Medicaid participation; low rates signal systemic quality risk."
    - name: "medicare_participating_facility_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN medicare_participation_flag = TRUE AND provider_status = 'Active' THEN org_provider_id END) / NULLIF(COUNT(CASE WHEN provider_status = 'Active' THEN org_provider_id END), 0), 2)
      comment: "Percentage of active facilities participating in Medicare. Revenue KPI — non-participating facilities cannot bill Medicare, representing significant revenue risk."
    - name: "oig_exclusion_flagged_count"
      expr: COUNT(CASE WHEN oig_exclusion_flag = TRUE THEN org_provider_id END)
      comment: "Number of organizational providers flagged for OIG exclusion. Critical compliance KPI — billing through OIG-excluded facilities triggers False Claims Act liability and potential program exclusion."
    - name: "sam_exclusion_flagged_count"
      expr: COUNT(CASE WHEN sam_exclusion_flag = TRUE THEN org_provider_id END)
      comment: "Number of organizational providers flagged in SAM exclusion database. Federal compliance KPI — SAM exclusions prohibit federal contract and grant participation, creating immediate legal risk."
    - name: "avg_accreditation_expiration_days"
      expr: AVG(CAST(accreditation_expiration_date AS DOUBLE))
      comment: "Average days until accreditation expiration across facilities. Operational planning KPI — declining averages signal upcoming accreditation renewal workload requiring resource allocation."
    - name: "avg_credentialing_expiration_days"
      expr: AVG(CAST(credentialing_expiration_date AS DOUBLE))
      comment: "Average days until credentialing expiration across organizational providers. Compliance KPI — used to forecast credentialing renewal workload and prevent lapses that block payer billing."
    - name: "critical_access_hospital_count"
      expr: COUNT(CASE WHEN critical_access_hospital_flag = TRUE AND provider_status = 'Active' THEN org_provider_id END)
      comment: "Number of active Critical Access Hospitals. Rural health policy KPI — CAH count determines eligibility for cost-based Medicare reimbursement and rural health program funding."
    - name: "disproportionate_share_facility_count"
      expr: COUNT(CASE WHEN disproportionate_share_flag = TRUE AND provider_status = 'Active' THEN org_provider_id END)
      comment: "Number of active facilities with Disproportionate Share Hospital designation. Financial and policy KPI — DSH status determines eligibility for supplemental Medicaid payments supporting safety-net care."
$$;