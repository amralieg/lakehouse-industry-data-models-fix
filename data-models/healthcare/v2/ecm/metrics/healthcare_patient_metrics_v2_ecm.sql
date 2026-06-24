-- Metric views for domain: patient | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 14:47:42

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_care_program_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs on care management program enrollment, retention, and disenrollment used by population health and value-based care leadership to steer program ROI and engagement."
  source: "`vibe_healthcare_v1`.`patient`.`care_program_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current lifecycle state of the enrollment (active, disenrolled, pending) for cohort segmentation."
    - name: "program_outcome"
      expr: program_outcome
      comment: "Outcome of the program episode used to evaluate clinical/financial effectiveness."
    - name: "value_based_contract_type"
      expr: value_based_contract_type
      comment: "VBC contract type tying enrollment to risk-bearing arrangements."
    - name: "disenrollment_reason"
      expr: disenrollment_reason
      comment: "Reason for disenrollment to diagnose attrition drivers."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Enrollment month for cohort and trend analysis."
  measures:
    - name: "Total Enrollments"
      expr: COUNT(1)
      comment: "Count of program enrollment records — base volume for capacity and growth tracking."
    - name: "Active Enrollment Count"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'active' THEN care_program_enrollment_id END)
      comment: "Distinct active enrollments — directly drives staffing and capacity decisions."
    - name: "Consent Obtained Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_obtained_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of enrollments with documented consent — a compliance and risk KPI."
    - name: "Disenrollment Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN enrollment_status = 'disenrolled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Attrition rate that leadership monitors to assess program retention."
    - name: "Enrolled Patient Count"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct patients enrolled — true reach of care programs for ROI evaluation."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_eligibility_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Insurance eligibility verification KPIs used by revenue cycle leadership to reduce denials and accelerate front-end clearance."
  source: "`vibe_healthcare_v1`.`patient`.`eligibility_check`"
  dimensions:
    - name: "verification_status"
      expr: verification_status
      comment: "Outcome of the eligibility verification used to track clean verification rates."
    - name: "network_status"
      expr: network_status
      comment: "In/out-of-network status driving patient liability and steering decisions."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage category for payer-mix analysis."
    - name: "verification_method"
      expr: verification_method
      comment: "How eligibility was verified (electronic vs manual) for automation tracking."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Service month for trending verification volumes."
  measures:
    - name: "Total Eligibility Checks"
      expr: COUNT(1)
      comment: "Volume of eligibility verifications — workload and automation baseline."
    - name: "Verified Clean Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'verified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "First-pass verification success rate — leading indicator of downstream denial risk."
    - name: "Prior Auth Required Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN prior_auth_required = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of services requiring prior authorization — drives PA staffing and workflow."
    - name: "Avg Copay Amount"
      expr: ROUND(AVG(CAST(copay_amount AS DOUBLE)), 2)
      comment: "Average patient copay — informs point-of-service collection targets."
    - name: "Avg Individual Deductible Remaining"
      expr: ROUND(AVG(CAST(individual_deductible_amount AS DOUBLE) - CAST(individual_deductible_met_amount AS DOUBLE)), 2)
      comment: "Average remaining deductible — supports patient financial counseling and estimated liability."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_financial_assistance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Charity care and financial assistance KPIs used by finance and community-benefit leadership for IRS 990 reporting and uncompensated care management."
  source: "`vibe_healthcare_v1`.`patient`.`financial_assistance`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Status of the assistance application for pipeline and approval analysis."
    - name: "program_type"
      expr: program_type
      comment: "Type of assistance program (charity, sliding scale) for community-benefit categorization."
    - name: "community_benefit_category"
      expr: community_benefit_category
      comment: "Community benefit category for regulatory reporting."
    - name: "application_month"
      expr: DATE_TRUNC('MONTH', application_date)
      comment: "Application month for trending demand."
  measures:
    - name: "Total Applications"
      expr: COUNT(1)
      comment: "Volume of financial assistance applications — demand and staffing baseline."
    - name: "Approval Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN application_status = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of applications approved — equity and access KPI for leadership."
    - name: "Total Approved Assistance Amount"
      expr: SUM(CAST(approved_assistance_amount AS DOUBLE))
      comment: "Total dollars approved — directly feeds uncompensated care and community-benefit reporting."
    - name: "Total Write Off Amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total write-offs from assistance — bad debt vs charity classification for finance."
    - name: "Avg Household FPL Pct"
      expr: ROUND(AVG(CAST(fpl_percentage AS DOUBLE)), 2)
      comment: "Average federal poverty level of applicants — informs eligibility policy and equity analysis."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_quality_measure_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality measure and care-gap KPIs used by VBC and quality leadership to track HEDIS/Stars performance and gap closure."
  source: "`vibe_healthcare_v1`.`patient`.`quality_measure_evaluation`"
  dimensions:
    - name: "gap_status"
      expr: gap_status
      comment: "Open/closed status of a care gap for closure tracking."
    - name: "program_type"
      expr: program_type
      comment: "Quality program (HEDIS, MIPS, Stars) for measure attribution."
    - name: "measurement_year"
      expr: measurement_year
      comment: "Performance/measurement year for trend and reporting alignment."
    - name: "evaluation_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month the measure was evaluated for trending."
  measures:
    - name: "Total Measure Evaluations"
      expr: COUNT(1)
      comment: "Count of patient-measure evaluations — denominator universe baseline."
    - name: "Numerator Compliance Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN numerator_compliant = true THEN 1 END) / NULLIF(COUNT(CASE WHEN denominator_eligible = true THEN 1 END), 0), 2)
      comment: "Compliant numerator over eligible denominator — the core quality performance rate steering Stars/HEDIS bonuses."
    - name: "Open Care Gap Count"
      expr: COUNT(CASE WHEN care_gap_flag = true AND gap_status = 'open' THEN 1 END)
      comment: "Open care gaps — directly drives outreach targeting and revenue-at-risk."
    - name: "Gap Closure Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gap_status = 'closed' THEN 1 END) / NULLIF(COUNT(CASE WHEN care_gap_flag = true THEN 1 END), 0), 2)
      comment: "Share of identified gaps that were closed — measures effectiveness of intervention programs."
    - name: "Avg Performance Rate"
      expr: ROUND(AVG(CAST(performance_rate AS DOUBLE)), 2)
      comment: "Average measure performance rate — composite quality signal for executive dashboards."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_population_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk stratification KPIs used by population health leadership to size high-risk cohorts and target care management."
  source: "`vibe_healthcare_v1`.`patient`.`population_segment`"
  dimensions:
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier classification for cohort sizing and resource targeting."
    - name: "segment_type"
      expr: segment_type
      comment: "Type of population segment for analytic grouping."
    - name: "payer_product_type"
      expr: payer_product_type
      comment: "Payer product type for contract-level cohort analysis."
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year for VBC contract alignment."
  measures:
    - name: "Total Segment Records"
      expr: COUNT(1)
      comment: "Count of segment assignments — base population sizing."
    - name: "Distinct Patients Stratified"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct patients with a risk stratification — coverage of risk model."
    - name: "High Risk Patient Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_tier = 'high' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of population in the high-risk tier — drives care management capacity and spend."
    - name: "Avg HCC Risk Score"
      expr: ROUND(AVG(CAST(hcc_risk_score AS DOUBLE)), 4)
      comment: "Average HCC risk score — drives risk-adjusted revenue and acuity tracking."
    - name: "Care Management Enrolled Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN care_management_enrollment_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Penetration of care management among the segment — gap between identified risk and intervention."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_pcp_attribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PCP/ACO attribution KPIs used by network and VBC leadership to track panel attribution and risk."
  source: "`vibe_healthcare_v1`.`patient`.`pcp_attribution`"
  dimensions:
    - name: "attribution_status"
      expr: attribution_status
      comment: "Status of the attribution relationship for active panel tracking."
    - name: "attribution_method"
      expr: attribution_method
      comment: "Method used to attribute the patient (claims, encounter) for transparency."
    - name: "risk_stratification_tier"
      expr: risk_stratification_tier
      comment: "Risk tier of attributed patients for panel acuity analysis."
    - name: "measurement_year"
      expr: measurement_year
      comment: "Attribution measurement year for VBC reporting."
  measures:
    - name: "Total Attributions"
      expr: COUNT(1)
      comment: "Count of attribution records — base attributed-life volume."
    - name: "Attributed Patient Count"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct attributed patients — true panel size driving VBC revenue."
    - name: "Primary Attribution Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_primary_attribution = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of primary attributions — avoids double counting and informs panel ownership."
    - name: "Avg HCC Risk Score"
      expr: ROUND(AVG(CAST(hcc_risk_score AS DOUBLE)), 4)
      comment: "Average HCC risk of attributed lives — drives risk-adjusted payment modeling."
    - name: "Care Management Enrolled Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN care_management_enrolled = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Care management penetration of attributed panel — intervention coverage gap."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_communication_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient outreach KPIs used by population health and engagement leadership to measure outreach effectiveness and opt-out risk."
  source: "`vibe_healthcare_v1`.`patient`.`communication_log`"
  dimensions:
    - name: "communication_channel"
      expr: communication_channel
      comment: "Channel used (SMS, email, phone) for channel effectiveness analysis."
    - name: "communication_type"
      expr: communication_type
      comment: "Type/purpose of communication for campaign segmentation."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery outcome for deliverability monitoring."
    - name: "communication_month"
      expr: DATE_TRUNC('MONTH', communication_date)
      comment: "Communication month for outreach volume trending."
  measures:
    - name: "Total Communications"
      expr: COUNT(1)
      comment: "Volume of outreach attempts — engagement workload baseline."
    - name: "Delivery Success Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN delivery_status = 'delivered' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of communications successfully delivered — deliverability KPI for channel investment."
    - name: "Patient Response Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN patient_response_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Patient response rate — measures outreach effectiveness and engagement."
    - name: "Opt Out Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN opt_out_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Opt-out rate — compliance and channel-fatigue risk indicator."
    - name: "Patients Contacted Count"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients reached — true outreach reach for campaign ROI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_portal_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient portal adoption KPIs used by digital health leadership to drive activation and engagement."
  source: "`vibe_healthcare_v1`.`patient`.`portal_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Portal account status for active-user tracking."
    - name: "portal_platform"
      expr: portal_platform
      comment: "Portal platform for vendor and channel analysis."
    - name: "activation_method"
      expr: activation_method
      comment: "How the account was activated for onboarding effectiveness."
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', activation_date)
      comment: "Activation month for adoption trending."
  measures:
    - name: "Total Portal Accounts"
      expr: COUNT(1)
      comment: "Total portal accounts — digital footprint baseline."
    - name: "Active Account Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN account_status = 'active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of active accounts — digital engagement KPI for leadership."
    - name: "Identity Verified Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN identity_verified_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Identity verification rate — security/compliance KPI for portal access."
    - name: "Two Factor Enrollment Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN two_factor_auth_enrolled = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "MFA enrollment rate — security posture metric for digital health governance."
    - name: "Messaging Opt In Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN messaging_opt_in = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Secure messaging opt-in rate — enables digital engagement programs."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_registration_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Registration/access KPIs used by patient access leadership to monitor front-end data quality and eligibility clearance."
  source: "`vibe_healthcare_v1`.`patient`.`registration_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of registration event (admit, register) for workflow segmentation."
    - name: "registration_source"
      expr: registration_source
      comment: "Source of registration (web, in-person) for channel analysis."
    - name: "financial_class"
      expr: financial_class
      comment: "Financial class for payer-mix front-end visibility."
    - name: "registration_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Registration month for volume trending."
  measures:
    - name: "Total Registration Events"
      expr: COUNT(1)
      comment: "Volume of registration events — patient access workload baseline."
    - name: "Eligibility Verified Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN eligibility_verified_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Front-end eligibility clearance rate — leading indicator of denial prevention."
    - name: "Duplicate Registration Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN duplicate_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Duplicate creation rate — MPI data-quality and patient-safety KPI."
    - name: "Avg Registration Completeness Score"
      expr: ROUND(AVG(CAST(completeness_score AS DOUBLE)), 2)
      comment: "Average registration completeness — front-end data quality driving downstream revenue cycle."
    - name: "Consent Obtained Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_obtained_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Consent capture rate at registration — compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_sdoh_referral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Social-needs referral KPIs used by community health leadership to track closed-loop referral performance and equity."
  source: "`vibe_healthcare_v1`.`patient`.`sdoh_referral`"
  dimensions:
    - name: "referral_status"
      expr: referral_status
      comment: "Current status of the SDOH referral for closure pipeline tracking."
    - name: "sdoh_domain"
      expr: sdoh_domain
      comment: "Social determinant domain (housing, food) for needs analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority of the referral for triage and resource allocation."
    - name: "referral_month"
      expr: DATE_TRUNC('MONTH', referral_date)
      comment: "Referral month for demand trending."
  measures:
    - name: "Total SDOH Referrals"
      expr: COUNT(1)
      comment: "Volume of social-needs referrals — community-need demand baseline."
    - name: "Closed Loop Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN closed_loop_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Closed-loop completion rate — core SDOH program effectiveness KPI."
    - name: "Patients Referred Count"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients referred — true reach of social-needs intervention."
    - name: "Avg Risk Priority Score"
      expr: ROUND(AVG(CAST(risk_priority_score AS DOUBLE)), 2)
      comment: "Average risk priority of referrals — acuity signal for resource targeting."
    - name: "Consent Obtained Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_obtained_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Consent capture rate for SDOH referrals — compliance and trust KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_rpm_device_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Remote patient monitoring KPIs used by chronic care leadership to track RPM adherence and alert burden."
  source: "`vibe_healthcare_v1`.`patient`.`patient_rpm_device_reading`"
  dimensions:
    - name: "measure_type"
      expr: measure_type
      comment: "Type of physiologic measure (BP, glucose, weight) for clinical segmentation."
    - name: "reading_unit"
      expr: unit
      comment: "Unit of measure for the reading for correct interpretation."
    - name: "reading_month"
      expr: DATE_TRUNC('MONTH', reading_at)
      comment: "Month the reading was captured for adherence trending."
  measures:
    - name: "Total Device Readings"
      expr: COUNT(1)
      comment: "Volume of RPM readings — supports CPT 99454 monitoring-day billing thresholds."
    - name: "Alert Triggered Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_alert_triggered = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of readings breaching thresholds — clinical alert burden and intervention need."
    - name: "Monitored Patient Count"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with RPM readings — true monitored panel for program ROI."
    - name: "Avg Reading Value"
      expr: ROUND(AVG(CAST(reading_value AS DOUBLE)), 2)
      comment: "Average physiologic reading value — population trend signal (interpret by measure_type)."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_prom_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient-reported outcome KPIs used by clinical quality leadership to track PROM collection and outcome scores."
  source: "`vibe_healthcare_v1`.`patient`.`patient_prom_response`"
  dimensions:
    - name: "instrument_name"
      expr: instrument_name
      comment: "PROM instrument (PHQ-9, PROMIS) for outcome-domain segmentation."
    - name: "question_code"
      expr: question_code
      comment: "Specific question/item code for granular analysis."
    - name: "collected_month"
      expr: DATE_TRUNC('MONTH', collected_at)
      comment: "Month the PROM was collected for trend analysis."
  measures:
    - name: "Total PROM Responses"
      expr: COUNT(1)
      comment: "Volume of PROM responses — collection coverage baseline."
    - name: "Patients With PROM Count"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients completing PROMs — outcome-measurement reach."
    - name: "Avg PROM Score"
      expr: ROUND(AVG(CAST(score AS DOUBLE)), 2)
      comment: "Average instrument score — population outcome signal (interpret by instrument_name)."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_identity_merge_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MPI identity-resolution KPIs used by HIM leadership to track merge quality and patient-safety risk."
  source: "`vibe_healthcare_v1`.`patient`.`identity_merge_history`"
  dimensions:
    - name: "merge_event_type"
      expr: merge_event_type
      comment: "Type of merge event (merge, unmerge, overlay) for HIM workflow segmentation."
    - name: "merge_status"
      expr: merge_status
      comment: "Status of the merge for review-queue tracking."
    - name: "review_priority"
      expr: review_priority
      comment: "Review priority for HIM triage."
    - name: "merge_month"
      expr: DATE_TRUNC('MONTH', merge_timestamp)
      comment: "Month the merge occurred for trending."
  measures:
    - name: "Total Merge Events"
      expr: COUNT(1)
      comment: "Volume of identity merge events — HIM workload and data-integrity baseline."
    - name: "Patient Safety Impact Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN patient_safety_impact_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of merges flagged with patient-safety impact — critical HIM risk KPI."
    - name: "Breach Assessment Required Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN breach_assessment_required = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Merges requiring breach assessment — HIPAA compliance exposure indicator."
    - name: "Avg Merge Confidence Score"
      expr: ROUND(AVG(CAST(merge_confidence_score AS DOUBLE)), 2)
      comment: "Average algorithmic merge confidence — quality of identity resolution."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_communication_success`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Effectiveness of patient communications across channels"
  source: "`vibe_healthcare_v1`.`patient`.`communication_log`"
  dimensions:
    - name: "communication_channel"
      expr: communication_channel
      comment: "Channel used for communication (e.g., SMS, Email)"
    - name: "communication_type"
      expr: communication_type
      comment: "Type of communication (e.g., reminder, alert)"
  measures:
    - name: "total_messages"
      expr: COUNT(1)
      comment: "Total communication log entries"
    - name: "delivered_message_count"
      expr: SUM(CASE WHEN delivery_status = 'Delivered' THEN 1 ELSE 0 END)
      comment: "Number of messages successfully delivered"
    - name: "consented_message_count"
      expr: SUM(CASE WHEN consent_obtained_flag THEN 1 ELSE 0 END)
      comment: "Number of messages sent where patient consent was obtained"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_demographics`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core patient population broken down by key demographic attributes"
  source: "`vibe_healthcare_v1`.`patient`.`demographics`"
  dimensions:
    - name: "gender_identity"
      expr: gender_identity
      comment: "Self‑identified gender of the patient"
    - name: "race_code"
      expr: race_code
      comment: "Race classification code"
    - name: "age_bucket"
      expr: FLOOR(DATEDIFF(current_date(), birth_date) / 365)
      comment: "Patient age in years, bucketed as integer years"
  measures:
    - name: "patient_count"
      expr: COUNT(1)
      comment: "Total number of patients in the demographics table"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_flag_summary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical flag monitoring for safety and quality"
  source: "`vibe_healthcare_v1`.`patient`.`flag`"
  dimensions:
    - name: "flag_type"
      expr: flag_type
      comment: "Category of the flag (e.g., allergy, infection)"
    - name: "severity"
      expr: severity
      comment: "Severity level of the flag"
    - name: "flag_status"
      expr: flag_status
      comment: "Current status of the flag (Active, Resolved)"
  measures:
    - name: "total_flags"
      expr: COUNT(1)
      comment: "Total number of clinical flags recorded"
    - name: "active_flag_count"
      expr: SUM(CASE WHEN flag_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of flags currently active"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_population_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk stratification metrics for population management"
  source: "`vibe_healthcare_v1`.`patient`.`population_segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Logical segment classification (e.g., chronic, acute)"
  measures:
    - name: "total_patients"
      expr: COUNT(1)
      comment: "Total patients in the population segment table"
    - name: "high_risk_patient_count"
      expr: SUM(CASE WHEN hcc_risk_score > 20 THEN 1 ELSE 0 END)
      comment: "Count of patients with HCC risk score above 20 (high risk)"
    - name: "average_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average overall risk score for the segment"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_expected_los`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Length‑of‑stay planning KPI derived from registration events"
  source: "`vibe_healthcare_v1`.`patient`.`registration_event`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where the patient was admitted"
    - name: "admission_type"
      expr: admission_type
      comment: "Admission classification (e.g., emergency, elective)"
  measures:
    - name: "avg_expected_los_days"
      expr: AVG(CAST(expected_los_days AS DOUBLE))
      comment: "Average expected length of stay (in days) across admissions"
    - name: "total_expected_los_days"
      expr: SUM(CAST(expected_los_days AS DOUBLE))
      comment: "Total expected length of stay (in days) for all admissions"
$$;