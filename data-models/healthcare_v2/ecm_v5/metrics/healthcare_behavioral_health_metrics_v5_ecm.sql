-- Metric views for domain: behavioral_health | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`behavioral_health_crisis_episode`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crisis episode metrics tracking severity, outcomes, repeat patterns, and intervention effectiveness for behavioral health crisis services management."
  source: "`healthcare_ecm_v1`.`behavioral_health`.`crisis_episode`"
  dimensions:
    - name: "crisis_type"
      expr: crisis_type
      comment: "Type of behavioral health crisis (suicidal ideation, psychotic episode, substance-related, etc.)"
    - name: "severity_level"
      expr: severity_level
      comment: "Clinical severity classification of the crisis episode"
    - name: "disposition"
      expr: disposition
      comment: "Patient disposition after crisis intervention (admitted, discharged, transferred, etc.)"
  measures:
    - name: "total_crisis_episodes"
      expr: COUNT(1)
      comment: "Total number of behavioral health crisis episodes"
    - name: "distinct_patients_in_crisis"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients experiencing crisis episodes for population-level tracking"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`behavioral_health_sud_episode`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Substance use disorder episode metrics tracking treatment outcomes, MAT utilization, relapse rates, and program effectiveness for SUD program management."
  source: "`healthcare_ecm_v1`.`behavioral_health`.`sud_episode`"
  dimensions:
    - name: "primary_substance"
      expr: primary_substance
      comment: "Primary substance of abuse driving the treatment episode"
    - name: "episode_type"
      expr: episode_type
      comment: "Type of SUD treatment episode (inpatient, outpatient, intensive outpatient, etc.)"
    - name: "severity_level"
      expr: severity_level
      comment: "Clinical severity level of the substance use disorder"
  measures:
    - name: "total_sud_episodes"
      expr: COUNT(1)
      comment: "Total substance use disorder treatment episodes"
    - name: "distinct_sud_patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients in SUD treatment for population prevalence tracking"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`behavioral_health_mat_treatment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medication-Assisted Treatment metrics tracking dosage management, compliance, adverse events, telehealth utilization, and financial performance for MAT program oversight."
  source: "`healthcare_ecm_v1`.`behavioral_health`.`mat_treatment`"
  dimensions:
    - name: "treatment_type"
      expr: treatment_type
      comment: "Type of MAT (buprenorphine, methadone, naltrexone, etc.)"
  measures:
    - name: "total_mat_treatments"
      expr: COUNT(1)
      comment: "Total MAT treatment records for program volume tracking"
    - name: "avg_dosage_amount"
      expr: AVG(CAST(dosage_amount AS DOUBLE))
      comment: "Average medication dosage across treatments for dosing protocol analysis"
    - name: "distinct_mat_patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients receiving MAT for program reach measurement"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`behavioral_health_otp_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Opioid Treatment Program enrollment metrics tracking program capacity, medication dosing, compliance, and retention for OTP program management and SAMHSA reporting."
  source: "`healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status in the OTP program"
    - name: "referral_source"
      expr: referral_source
      comment: "Source of referral to OTP for outreach effectiveness analysis"
  measures:
    - name: "total_otp_enrollments"
      expr: COUNT(1)
      comment: "Total OTP enrollments for program capacity planning"
    - name: "active_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'active' THEN 1 END)
      comment: "Currently active OTP enrollments for census reporting"
    - name: "distinct_otp_patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients enrolled in OTP for unduplicated count reporting"
    - name: "discharged_count"
      expr: COUNT(CASE WHEN enrollment_status = 'discharged' THEN 1 END)
      comment: "Count of discharged enrollments for retention analysis"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`behavioral_health_psychiatric_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Psychiatric assessment metrics tracking assessment volumes, telehealth adoption, clinical scoring patterns, and follow-up compliance for behavioral health clinical operations."
  source: "`healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total psychiatric assessments performed for workload and capacity planning"
    - name: "distinct_patients_assessed"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients receiving psychiatric assessment for population coverage"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`behavioral_health_therapy_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Therapy session metrics tracking session volumes, revenue, telehealth utilization, clinical outcomes, and group vs individual modality mix for behavioral health service line management."
  source: "`healthcare_ecm_v1`.`behavioral_health`.`therapy_session`"
  dimensions:
    - name: "session_type"
      expr: session_type
      comment: "Type of therapy session (individual, group, family, couples)"
    - name: "modality"
      expr: modality
      comment: "Therapeutic modality used (CBT, DBT, EMDR, motivational interviewing, etc.)"
    - name: "session_status"
      expr: session_status
      comment: "Status of the session (completed, cancelled, no-show, etc.)"
    - name: "is_telehealth"
      expr: CAST(is_telehealth AS STRING)
      comment: "Whether session was delivered via telehealth"
    - name: "is_group_session"
      expr: CAST(is_group_session AS STRING)
      comment: "Whether this is a group therapy session"
    - name: "risk_level"
      expr: risk_level
      comment: "Patient risk level at time of session"
    - name: "session_outcome"
      expr: session_outcome
      comment: "Clinical outcome rating of the session"
    - name: "session_month"
      expr: DATE_TRUNC('MONTH', session_date)
      comment: "Month of session for trend and seasonality analysis"
    - name: "follow_up_required"
      expr: CAST(follow_up_required AS STRING)
      comment: "Whether follow-up action is required after session"
    - name: "billing_code"
      expr: billing_code
      comment: "CPT/billing code for revenue mix analysis"
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total therapy sessions for volume and productivity tracking"
    - name: "total_gross_charges"
      expr: SUM(CAST(charge_amount_gross AS DOUBLE))
      comment: "Total gross charges for therapy sessions for revenue cycle management"
    - name: "total_net_charges"
      expr: SUM(CAST(charge_amount_net AS DOUBLE))
      comment: "Total net charges after adjustments for actual revenue tracking"
    - name: "total_charge_adjustments"
      expr: SUM(CAST(charge_adjustment AS DOUBLE))
      comment: "Total charge adjustments for contractual and write-off analysis"
    - name: "avg_outcome_measure_score"
      expr: AVG(CAST(outcome_measure_score AS DOUBLE))
      comment: "Average clinical outcome measure score for treatment effectiveness"
    - name: "telehealth_session_count"
      expr: COUNT(CASE WHEN is_telehealth = TRUE THEN 1 END)
      comment: "Count of telehealth sessions for virtual care program performance"
    - name: "no_show_count"
      expr: COUNT(CASE WHEN session_status = 'no_show' THEN 1 END)
      comment: "Count of no-show sessions for patient engagement and scheduling optimization"
    - name: "distinct_therapy_patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients receiving therapy for active caseload measurement"
    - name: "group_session_count"
      expr: COUNT(CASE WHEN is_group_session = TRUE THEN 1 END)
      comment: "Count of group sessions for group therapy program utilization"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`behavioral_health_cfr42_consent_workflow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "42 CFR Part 2 consent workflow metrics tracking consent processing times, revocation rates, and compliance status for federal substance use disorder privacy regulation adherence."
  source: "`healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow`"
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of 42 CFR Part 2 consent (disclosure, redisclosure, research, etc.)"
    - name: "workflow_status"
      expr: cfr42_consent_workflow_status
      comment: "Current status of the consent workflow"
    - name: "consent_scope"
      expr: consent_scope
      comment: "Scope of information covered by the consent"
    - name: "signature_method"
      expr: signature_method
      comment: "Method used to obtain signature (electronic, wet ink, verbal)"
    - name: "is_emergency_consent"
      expr: CAST(is_emergency_consent AS STRING)
      comment: "Whether consent was obtained under emergency circumstances"
    - name: "is_revoked_by_provider"
      expr: CAST(is_revoked_by_provider AS STRING)
      comment: "Whether consent was revoked by provider action"
    - name: "review_required"
      expr: CAST(review_required AS STRING)
      comment: "Whether consent requires periodic review"
    - name: "consent_language"
      expr: consent_language
      comment: "Language in which consent was obtained for LEP compliance"
    - name: "consent_created_month"
      expr: DATE_TRUNC('MONTH', consent_created_timestamp)
      comment: "Month consent was created for processing volume trends"
    - name: "purpose_of_use"
      expr: purpose_of_use
      comment: "Purpose for which disclosure is authorized"
  measures:
    - name: "total_consent_workflows"
      expr: COUNT(1)
      comment: "Total 42 CFR Part 2 consent workflows for compliance volume tracking"
    - name: "revoked_consent_count"
      expr: COUNT(CASE WHEN cfr42_consent_workflow_status = 'revoked' THEN 1 END)
      comment: "Count of revoked consents for patient rights and compliance monitoring"
    - name: "emergency_consent_count"
      expr: COUNT(CASE WHEN is_emergency_consent = TRUE THEN 1 END)
      comment: "Count of emergency consents for exception tracking and audit readiness"
    - name: "review_required_count"
      expr: COUNT(CASE WHEN review_required = TRUE THEN 1 END)
      comment: "Count of consents requiring periodic review for workload planning"
    - name: "distinct_patients_with_consent"
      expr: COUNT(DISTINCT primary_mpi_record_id)
      comment: "Unique patients with 42 CFR Part 2 consent workflows for coverage analysis"
    - name: "confidential_consent_count"
      expr: COUNT(CASE WHEN is_confidential = TRUE THEN 1 END)
      comment: "Count of consents marked confidential for heightened privacy protection tracking"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`behavioral_health_cfr42_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "42 CFR Part 2 consent record metrics tracking consent status distribution, court-ordered disclosures, MAT program consent coverage, and expiration management for regulatory compliance."
  source: "`healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the 42 CFR Part 2 consent"
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent (general, specific, court-ordered)"
    - name: "recipient_type"
      expr: recipient_type
      comment: "Type of entity receiving disclosed information"
    - name: "substance_category"
      expr: substance_category
      comment: "Category of substance use information covered by consent"
    - name: "is_court_ordered"
      expr: CAST(is_court_ordered AS STRING)
      comment: "Whether disclosure is court-ordered"
    - name: "mat_program_indicator"
      expr: CAST(mat_program_indicator AS STRING)
      comment: "Whether consent is associated with MAT program"
    - name: "signature_method"
      expr: signature_method
      comment: "Method of consent signature"
    - name: "is_minor_consent"
      expr: CAST(is_minor_consent AS STRING)
      comment: "Whether consent involves a minor patient"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month consent became effective for trend analysis"
  measures:
    - name: "total_cfr42_consents"
      expr: COUNT(1)
      comment: "Total 42 CFR Part 2 consent records for compliance inventory"
    - name: "active_consent_count"
      expr: COUNT(CASE WHEN consent_status = 'active' THEN 1 END)
      comment: "Count of currently active consents for disclosure authorization coverage"
    - name: "court_ordered_count"
      expr: COUNT(CASE WHEN is_court_ordered = TRUE THEN 1 END)
      comment: "Count of court-ordered disclosures for legal compliance tracking"
    - name: "mat_program_consent_count"
      expr: COUNT(CASE WHEN mat_program_indicator = TRUE THEN 1 END)
      comment: "Count of MAT-related consents for program compliance coverage"
    - name: "distinct_patients_consented"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients with 42 CFR Part 2 consents for population coverage"
    - name: "revoked_consent_count"
      expr: COUNT(CASE WHEN consent_status = 'revoked' THEN 1 END)
      comment: "Count of revoked consents for patient autonomy and compliance monitoring"
$$;