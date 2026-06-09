-- Metric views for domain: encounter | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 18:58:55

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`encounter_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core encounter visit metrics tracking volume, throughput, length of stay, readmission risk, and care quality across all visit types. Primary operational and strategic KPI layer for hospital and clinic leadership."
  source: "`healthcare_ecm`.`encounter`.`visit`"
  dimensions:
    - name: "visit_type"
      expr: visit_type
      comment: "Type of visit (e.g., inpatient, outpatient, ED, observation) — primary segmentation axis for all visit KPIs."
    - name: "admission_type"
      expr: admission_type
      comment: "Classification of admission (e.g., elective, emergency, urgent) — used to stratify volume and LOS metrics."
    - name: "care_setting"
      expr: care_setting
      comment: "Physical or virtual care setting (e.g., inpatient ward, telehealth, outpatient clinic) — key dimension for capacity and utilization analysis."
    - name: "visit_status"
      expr: visit_status
      comment: "Current status of the visit (e.g., active, discharged, cancelled) — used to filter operational dashboards."
    - name: "discharge_disposition"
      expr: discharge_disposition
      comment: "Where the patient went after discharge (e.g., home, SNF, expired) — critical for post-acute care planning and quality reporting."
    - name: "financial_class"
      expr: financial_class
      comment: "Payer financial class (e.g., Medicare, Medicaid, commercial) — essential for revenue cycle and payer mix analysis."
    - name: "admission_source"
      expr: admission_source
      comment: "Source of the admission (e.g., ED, physician referral, transfer) — used to analyze referral patterns and care pathways."
    - name: "drg_type"
      expr: drg_type
      comment: "DRG classification type (e.g., MS-DRG, APR-DRG) — used to segment reimbursement and case mix analysis."
    - name: "observation_status"
      expr: observation_status
      comment: "Flag indicating whether the visit is under observation status (True/False) — relevant for CMS two-midnight rule compliance and billing."
    - name: "readmission_flag"
      expr: readmission_flag
      comment: "Indicates whether this visit is a readmission (True/False) — core quality and penalty-risk indicator."
    - name: "two_midnight_compliant"
      expr: two_midnight_compliant
      comment: "Whether the visit meets CMS two-midnight rule criteria (True/False) — compliance dimension for inpatient billing audits."
    - name: "telehealth_platform"
      expr: telehealth_platform
      comment: "Telehealth platform used for virtual visits — used to track telehealth adoption and platform performance."
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_timestamp)
      comment: "Month of admission — time bucketing dimension for trend analysis of visit volume and LOS."
    - name: "discharge_month"
      expr: DATE_TRUNC('MONTH', discharge_timestamp)
      comment: "Month of discharge — time bucketing for throughput and discharge disposition trend analysis."
  measures:
    - name: "total_visits"
      expr: COUNT(1)
      comment: "Total number of patient visits. Baseline volume metric used in all operational and strategic dashboards to track census and throughput."
    - name: "total_inpatient_visits"
      expr: COUNT(CASE WHEN visit_type = 'Inpatient' THEN 1 END)
      comment: "Count of inpatient visits. Drives bed capacity planning, staffing, and inpatient revenue projections."
    - name: "total_observation_visits"
      expr: COUNT(CASE WHEN observation_status = TRUE THEN 1 END)
      comment: "Count of visits under observation status. Tracks CMS two-midnight rule exposure and potential billing risk."
    - name: "total_readmissions"
      expr: COUNT(CASE WHEN readmission_flag = TRUE THEN 1 END)
      comment: "Count of visits flagged as readmissions. Directly tied to HRRP penalty risk and quality improvement programs."
    - name: "readmission_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN readmission_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visits that are readmissions. Key quality KPI monitored by CMOs and used in CMS value-based care reporting."
    - name: "avg_readmission_risk_score"
      expr: AVG(CAST(readmission_risk_score AS DOUBLE))
      comment: "Average predictive readmission risk score across visits. Used by care management teams to prioritize high-risk patients for intervention."
    - name: "avg_expected_los_days"
      expr: AVG(CAST(expected_los_days AS DOUBLE))
      comment: "Average expected length of stay in days. Benchmarked against actual LOS to identify throughput inefficiencies and case management opportunities."
    - name: "avg_observation_hours"
      expr: AVG(CAST(observation_hours AS DOUBLE))
      comment: "Average hours spent in observation status. Elevated averages signal potential two-midnight rule compliance issues and revenue leakage."
    - name: "avg_drg_weight"
      expr: AVG(CAST(drg_weight AS DOUBLE))
      comment: "Average DRG relative weight across visits. Reflects case mix complexity; higher weights indicate more resource-intensive and higher-reimbursed cases."
    - name: "total_drg_weight"
      expr: SUM(CAST(drg_weight AS DOUBLE))
      comment: "Sum of DRG weights across all visits. Represents total case mix index volume — a primary driver of inpatient reimbursement and resource planning."
    - name: "telehealth_visit_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN telehealth_platform IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visits conducted via telehealth. Tracks digital care adoption and informs virtual care investment decisions."
    - name: "two_midnight_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN two_midnight_compliant = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN visit_type = 'Inpatient' THEN 1 END), 0), 2)
      comment: "Percentage of inpatient visits meeting CMS two-midnight rule compliance. Non-compliance exposes the organization to RAC audit risk and claim denials."
    - name: "discharge_instructions_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN discharge_instructions_issued = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visits where discharge instructions were issued. Linked to patient safety, HCAHPS scores, and readmission reduction programs."
    - name: "care_transition_plan_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN care_transition_plan_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visits with a completed care transition plan. Directly tied to readmission prevention and post-acute care coordination quality."
    - name: "converted_to_inpatient_count"
      expr: COUNT(CASE WHEN converted_to_inpatient = TRUE THEN 1 END)
      comment: "Count of visits that converted from observation or outpatient to inpatient status. Tracks clinical escalation patterns and revenue upcoding opportunities."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`encounter_drg_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DRG assignment metrics tracking case mix complexity, reimbursement accuracy, length of stay variance, and clinical documentation integrity. Used by finance, coding, and clinical leadership to optimize inpatient revenue and quality."
  source: "`healthcare_ecm`.`encounter`.`drg_assignment`"
  dimensions:
    - name: "drg_description"
      expr: drg_description
      comment: "Human-readable DRG description — primary grouping dimension for case mix and reimbursement analysis."
    - name: "mdc_code"
      expr: mdc_code
      comment: "Major Diagnostic Category code — broad clinical grouping used for service line and case mix reporting."
    - name: "mdc_description"
      expr: mdc_description
      comment: "Human-readable MDC description — used in executive dashboards for service line performance."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of DRG assignment (e.g., initial, final, revised) — used to track coding workflow stages."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the DRG assignment (e.g., pending, finalized) — used to monitor coding completion rates."
    - name: "cc_mcc_flag"
      expr: cc_mcc_flag
      comment: "Complication/Comorbidity or Major Complication/Comorbidity flag — key CDI metric indicating documentation quality and DRG weight impact."
    - name: "patient_type"
      expr: patient_type
      comment: "Patient classification type (e.g., Medicare, Medicaid, commercial) — used to segment reimbursement analysis by payer."
    - name: "is_outlier"
      expr: is_outlier
      comment: "Indicates whether the case qualifies as a cost outlier (True/False) — outlier cases receive supplemental Medicare payments."
    - name: "drg_changed_flag"
      expr: drg_changed_flag
      comment: "Indicates whether the DRG was changed after initial assignment (True/False) — tracks CDI query impact and coding revision activity."
    - name: "rac_review_flag"
      expr: rac_review_flag
      comment: "Indicates whether the case was flagged for Recovery Audit Contractor review (True/False) — compliance and audit risk dimension."
    - name: "grouping_month"
      expr: DATE_TRUNC('MONTH', grouping_date)
      comment: "Month of DRG grouping — time dimension for trend analysis of case mix and reimbursement."
    - name: "drg_version"
      expr: drg_version
      comment: "DRG grouper version used for assignment — ensures comparability of metrics across fiscal years and grouper updates."
  measures:
    - name: "total_drg_assignments"
      expr: COUNT(1)
      comment: "Total number of DRG assignments. Baseline volume metric for inpatient coding and reimbursement reporting."
    - name: "avg_drg_weight"
      expr: AVG(CAST(drg_weight AS DOUBLE))
      comment: "Average DRG relative weight. Primary case mix index metric — higher values indicate more complex, higher-reimbursed cases."
    - name: "total_drg_weight"
      expr: SUM(CAST(drg_weight AS DOUBLE))
      comment: "Sum of all DRG weights. Represents total case mix volume — directly drives inpatient reimbursement projections."
    - name: "avg_expected_reimbursement"
      expr: AVG(CAST(expected_reimbursement AS DOUBLE))
      comment: "Average expected Medicare reimbursement per DRG assignment. Used by finance to forecast inpatient revenue."
    - name: "total_expected_reimbursement"
      expr: SUM(CAST(expected_reimbursement AS DOUBLE))
      comment: "Total expected reimbursement across all DRG assignments. Core inpatient revenue forecast metric for CFO and finance leadership."
    - name: "avg_actual_los"
      expr: AVG(CAST(actual_los AS DOUBLE))
      comment: "Average actual length of stay in days. Benchmarked against geometric mean LOS to identify throughput and efficiency gaps."
    - name: "avg_geometric_mean_los"
      expr: AVG(CAST(geometric_mean_los AS DOUBLE))
      comment: "Average geometric mean LOS for assigned DRGs. CMS benchmark used to evaluate whether actual LOS is above or below expected norms."
    - name: "avg_arithmetic_mean_los"
      expr: AVG(CAST(arithmetic_mean_los AS DOUBLE))
      comment: "Average arithmetic mean LOS for assigned DRGs. Secondary LOS benchmark used alongside geometric mean for outlier identification."
    - name: "avg_los_variance"
      expr: AVG(actual_los - geometric_mean_los)
      comment: "Average difference between actual LOS and geometric mean LOS. Positive values indicate cases staying longer than expected, signaling throughput or clinical management issues."
    - name: "total_outlier_payment"
      expr: SUM(CAST(outlier_payment AS DOUBLE))
      comment: "Total supplemental outlier payments received. Tracks revenue from high-cost cases exceeding the fixed-loss threshold — important for finance and case management."
    - name: "outlier_case_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_outlier = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DRG assignments classified as cost outliers. High rates may indicate documentation gaps or unusually complex patient populations."
    - name: "drg_change_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN drg_changed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DRG assignments that were revised after initial grouping. Reflects CDI program effectiveness and coding accuracy."
    - name: "avg_initial_drg_weight"
      expr: AVG(CAST(initial_drg_weight AS DOUBLE))
      comment: "Average DRG weight at initial assignment before any CDI-driven revisions. Compared to final DRG weight to quantify CDI program revenue impact."
    - name: "avg_base_payment_rate"
      expr: AVG(CAST(base_payment_rate AS DOUBLE))
      comment: "Average base payment rate applied to DRG assignments. Used to validate reimbursement calculations and detect rate anomalies."
    - name: "rac_review_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rac_review_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DRG assignments flagged for RAC review. Elevated rates signal compliance risk and potential recoupment exposure."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`encounter_readmission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Readmission analytics metrics supporting HRRP penalty management, root cause analysis, care transition quality, and preventability assessment. Used by quality, case management, and executive leadership."
  source: "`healthcare_ecm`.`encounter`.`readmission`"
  dimensions:
    - name: "readmission_type"
      expr: readmission_type
      comment: "Classification of readmission (e.g., planned, unplanned, related) — used to distinguish avoidable from clinically expected readmissions."
    - name: "readmission_status"
      expr: readmission_status
      comment: "Current review status of the readmission record — used to track case review workflow completion."
    - name: "hrrp_measure_category"
      expr: hrrp_measure_category
      comment: "CMS HRRP condition category (e.g., AMI, HF, pneumonia, COPD, CABG, THA/TKA) — primary dimension for penalty risk stratification."
    - name: "is_hrrp_applicable"
      expr: is_hrrp_applicable
      comment: "Whether the readmission falls under a CMS HRRP-measured condition (True/False) — filters penalty-relevant readmissions."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Categorized root cause of the readmission (e.g., medication non-adherence, inadequate follow-up) — drives quality improvement initiatives."
    - name: "preventability_assessment"
      expr: preventability_assessment
      comment: "Clinical assessment of whether the readmission was preventable — used to prioritize intervention programs."
    - name: "payer_type"
      expr: payer_type
      comment: "Payer type for the readmission encounter (e.g., Medicare, Medicaid) — used to segment penalty exposure by payer."
    - name: "admit_source"
      expr: admit_source
      comment: "Source of the readmission admission (e.g., ED, direct admit) — used to analyze care pathway failures."
    - name: "sdoh_flag"
      expr: sdoh_flag
      comment: "Indicates whether social determinants of health contributed to the readmission (True/False) — used for equity and population health reporting."
    - name: "aco_attributed"
      expr: aco_attributed
      comment: "Whether the patient is attributed to an ACO (True/False) — used to track readmission performance under value-based care contracts."
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Month of readmission — time dimension for trend analysis of readmission rates and penalty risk."
    - name: "index_discharge_disposition"
      expr: index_discharge_disposition
      comment: "Discharge disposition of the index encounter — used to analyze whether discharge destination influences readmission risk."
  measures:
    - name: "total_readmissions"
      expr: COUNT(1)
      comment: "Total number of readmission events. Baseline volume metric for readmission program tracking and HRRP penalty risk assessment."
    - name: "total_hrrp_readmissions"
      expr: COUNT(CASE WHEN is_hrrp_applicable = TRUE THEN 1 END)
      comment: "Count of readmissions subject to CMS HRRP penalty measurement. Directly tied to Medicare penalty exposure for the organization."
    - name: "total_preventable_readmissions"
      expr: COUNT(CASE WHEN preventability_assessment = 'Preventable' THEN 1 END)
      comment: "Count of readmissions assessed as clinically preventable. Primary target for quality improvement and care management intervention programs."
    - name: "preventable_readmission_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN preventability_assessment = 'Preventable' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of readmissions deemed preventable. Key quality KPI used by CMOs and quality committees to evaluate care transition effectiveness."
    - name: "avg_hrrp_excess_readmission_ratio"
      expr: AVG(CAST(hrrp_excess_readmission_ratio AS DOUBLE))
      comment: "Average CMS HRRP excess readmission ratio. Values above 1.0 trigger Medicare payment penalties — monitored closely by finance and quality leadership."
    - name: "total_estimated_penalty_amount"
      expr: SUM(CAST(estimated_penalty_amount AS DOUBLE))
      comment: "Total estimated financial penalty from HRRP-applicable readmissions. Direct revenue-at-risk metric for CFO and finance leadership."
    - name: "avg_estimated_penalty_amount"
      expr: AVG(CAST(estimated_penalty_amount AS DOUBLE))
      comment: "Average estimated penalty per readmission event. Used to prioritize high-penalty condition categories for quality intervention."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average predictive readmission risk score at time of index discharge. Used to evaluate risk stratification model performance and care management targeting."
    - name: "sdoh_readmission_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sdoh_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of readmissions with a social determinants of health contributing factor. Informs equity-focused care management and community health investment decisions."
    - name: "medication_reconciliation_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN medication_reconciliation_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of readmission cases where medication reconciliation was completed at index discharge. Incomplete reconciliation is a leading preventable readmission driver."
    - name: "transition_of_care_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN transition_of_care_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of readmission cases with a completed transition of care plan. Directly linked to readmission prevention program effectiveness."
    - name: "is_related_to_index_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_related_to_index = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of readmissions clinically related to the index admission. Higher rates indicate potential care quality gaps during the initial hospitalization."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`encounter_triage_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Emergency department triage metrics tracking acuity distribution, throughput efficiency, critical alert rates, and patient safety indicators. Used by ED leadership, nursing, and hospital operations."
  source: "`healthcare_ecm`.`encounter`.`triage_assessment`"
  dimensions:
    - name: "esi_level"
      expr: esi_level
      comment: "Emergency Severity Index triage level (1-5) — primary acuity dimension for ED volume and resource utilization analysis."
    - name: "triage_category"
      expr: triage_category
      comment: "Clinical triage category assigned at assessment — used to segment patient acuity and care urgency."
    - name: "triage_status"
      expr: triage_status
      comment: "Current status of the triage assessment (e.g., completed, in-progress) — used to monitor ED workflow completion."
    - name: "arrival_mode"
      expr: arrival_mode
      comment: "How the patient arrived (e.g., ambulance, walk-in, helicopter) — used to analyze ED demand sources and resource pre-positioning."
    - name: "isolation_type"
      expr: isolation_type
      comment: "Type of isolation required (e.g., contact, airborne, droplet) — used for infection control capacity planning."
    - name: "sepsis_alert_flag"
      expr: sepsis_alert_flag
      comment: "Whether a sepsis alert was triggered at triage (True/False) — critical patient safety and quality metric."
    - name: "stroke_alert_flag"
      expr: stroke_alert_flag
      comment: "Whether a stroke alert was triggered at triage (True/False) — time-sensitive quality metric tied to door-to-needle performance."
    - name: "trauma_activation_flag"
      expr: trauma_activation_flag
      comment: "Whether a trauma activation was triggered (True/False) — used to track trauma volume and resource activation rates."
    - name: "mental_health_flag"
      expr: mental_health_flag
      comment: "Whether the patient presented with a mental health concern (True/False) — used for behavioral health capacity and boarding analysis."
    - name: "lwbs_flag"
      expr: lwbs_flag
      comment: "Left Without Being Seen flag (True/False) — patient satisfaction and throughput quality indicator."
    - name: "triage_month"
      expr: DATE_TRUNC('MONTH', triage_timestamp)
      comment: "Month of triage — time dimension for ED volume trend analysis."
    - name: "trauma_level"
      expr: trauma_level
      comment: "Trauma activation level (e.g., Level 1, Level 2) — used to stratify trauma resource utilization."
  measures:
    - name: "total_triage_assessments"
      expr: COUNT(1)
      comment: "Total number of triage assessments. Baseline ED volume metric used for staffing, capacity, and throughput planning."
    - name: "sepsis_alert_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sepsis_alert_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of triage assessments triggering a sepsis alert. Elevated rates drive early intervention protocols and are monitored for SEP-1 bundle compliance."
    - name: "stroke_alert_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN stroke_alert_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of triage assessments triggering a stroke alert. Tied to door-to-needle time quality metrics and Joint Commission stroke certification."
    - name: "trauma_activation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN trauma_activation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of triage assessments resulting in trauma activation. Used to evaluate trauma team utilization and activation appropriateness."
    - name: "lwbs_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN lwbs_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of patients who left without being seen. Key ED throughput and patient satisfaction KPI — high rates indicate capacity or flow problems."
    - name: "isolation_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN isolation_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of triage assessments requiring isolation. Used for infection control capacity planning and isolation room utilization."
    - name: "mental_health_presentation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN mental_health_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ED presentations with a mental health component. Informs behavioral health resource allocation and boarding reduction initiatives."
    - name: "avg_spo2_percent"
      expr: AVG(CAST(spo2_percent AS DOUBLE))
      comment: "Average oxygen saturation at triage. Low averages may indicate a high-acuity patient population or respiratory illness surge."
    - name: "avg_temperature_celsius"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average body temperature at triage. Elevated averages may signal infectious disease surges or sepsis screening opportunities."
    - name: "avg_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average patient weight at triage. Used for population health analytics and medication dosing quality programs."
    - name: "high_acuity_visit_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN esi_level IN ('1', '2') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of triage assessments classified as ESI level 1 or 2 (highest acuity). Drives ED staffing ratios, resuscitation bay utilization, and critical care capacity planning."
    - name: "triage_reassessment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN triage_reassessment_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of patients requiring a triage reassessment. High rates may indicate initial acuity under-assignment or rapid clinical deterioration in the waiting area."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`encounter_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization metrics tracking approval rates, denial patterns, peer-to-peer review outcomes, and financial authorization amounts. Used by revenue cycle, utilization management, and finance leadership."
  source: "`healthcare_ecm`.`encounter`.`authorization`"
  dimensions:
    - name: "authorization_type"
      expr: authorization_type
      comment: "Type of authorization request (e.g., inpatient, outpatient, procedure, medication) — primary segmentation for utilization management analysis."
    - name: "authorization_status"
      expr: authorization_status
      comment: "Current status of the authorization (e.g., approved, denied, pending, appealed) — core dimension for denial management dashboards."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency classification of the authorization request (e.g., routine, urgent, emergent) — used to analyze turnaround time by urgency tier."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Payer-assigned denial reason code — used to identify systemic denial patterns and target appeal strategies."
    - name: "submission_method"
      expr: submission_method
      comment: "How the authorization was submitted (e.g., portal, phone, fax, EDI) — used to optimize submission channel efficiency."
    - name: "appeal_decision"
      expr: appeal_decision
      comment: "Outcome of the authorization appeal (e.g., upheld, overturned) — used to evaluate appeal program effectiveness."
    - name: "peer_to_peer_review_flag"
      expr: peer_to_peer_review_flag
      comment: "Whether a peer-to-peer review was conducted (True/False) — used to track physician engagement in denial overturn efforts."
    - name: "extension_requested_flag"
      expr: extension_requested_flag
      comment: "Whether an authorization extension was requested (True/False) — indicates cases with prolonged stays requiring continued payer approval."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_submitted_timestamp)
      comment: "Month the authorization request was submitted — time dimension for trend analysis of authorization volume and turnaround."
    - name: "cpt_code"
      expr: cpt_code
      comment: "CPT procedure code associated with the authorization — used to identify high-denial procedure categories."
  measures:
    - name: "total_authorizations"
      expr: COUNT(1)
      comment: "Total number of authorization requests. Baseline volume metric for utilization management workload and payer interaction tracking."
    - name: "total_approved_authorizations"
      expr: COUNT(CASE WHEN authorization_status = 'Approved' THEN 1 END)
      comment: "Count of approved authorization requests. Used to track approval throughput and payer cooperation rates."
    - name: "total_denied_authorizations"
      expr: COUNT(CASE WHEN authorization_status = 'Denied' THEN 1 END)
      comment: "Count of denied authorization requests. Drives denial management programs and payer contract renegotiation decisions."
    - name: "authorization_denial_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN authorization_status = 'Denied' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of authorization requests that were denied. Key revenue cycle KPI — high denial rates signal payer friction, documentation gaps, or contract issues."
    - name: "total_authorized_amount"
      expr: SUM(CAST(authorized_amount AS DOUBLE))
      comment: "Total dollar amount authorized across all approved requests. Represents the financial scope of payer-approved services — used in revenue forecasting."
    - name: "avg_authorized_amount"
      expr: AVG(CAST(authorized_amount AS DOUBLE))
      comment: "Average authorized dollar amount per request. Used to benchmark authorization values by procedure type and payer."
    - name: "peer_to_peer_review_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN peer_to_peer_review_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN authorization_status = 'Denied' THEN 1 END), 0), 2)
      comment: "Percentage of denied authorizations that proceeded to peer-to-peer review. Measures physician engagement in the denial appeal process."
    - name: "peer_to_peer_overturn_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN peer_to_peer_review_flag = TRUE AND peer_to_peer_outcome = 'Overturned' THEN 1 END) / NULLIF(COUNT(CASE WHEN peer_to_peer_review_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of peer-to-peer reviews resulting in denial overturn. Measures the ROI of physician-led appeal efforts and informs escalation protocols."
    - name: "appeal_overturn_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_decision = 'Overturned' THEN 1 END) / NULLIF(COUNT(CASE WHEN appeal_decision IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of appealed authorizations that were overturned in the organization's favor. Measures appeal program effectiveness and revenue recovery."
    - name: "retro_authorization_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN retro_authorization_reason IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of authorizations submitted retrospectively. High retro rates indicate process failures in prospective authorization workflows and increase denial risk."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`encounter_visit_procedure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procedure-level metrics tracking surgical and clinical procedure volume, revenue value, complication rates, and RVU productivity. Used by service line leaders, OR management, and finance."
  source: "`healthcare_ecm`.`encounter`.`visit_procedure`"
  dimensions:
    - name: "procedure_type"
      expr: procedure_type
      comment: "Classification of the procedure (e.g., surgical, diagnostic, therapeutic) — primary segmentation for service line and volume analysis."
    - name: "procedure_status"
      expr: procedure_status
      comment: "Current status of the procedure (e.g., completed, cancelled, in-progress) — used to filter active vs. completed procedure metrics."
    - name: "cpt_code"
      expr: cpt_code
      comment: "CPT procedure code — used to analyze volume, revenue, and complication rates by specific procedure."
    - name: "anesthesia_type"
      expr: anesthesia_type
      comment: "Type of anesthesia used (e.g., general, regional, local, MAC) — used for anesthesia utilization and risk stratification."
    - name: "asa_class"
      expr: asa_class
      comment: "ASA physical status classification — used to stratify procedural risk and benchmark complication rates."
    - name: "wound_class"
      expr: wound_class
      comment: "Surgical wound classification (e.g., clean, contaminated, dirty) — used for infection risk and quality reporting."
    - name: "is_elective"
      expr: is_elective
      comment: "Whether the procedure was elective (True/False) — used to separate elective from emergent procedure volume for scheduling and capacity analysis."
    - name: "is_principal_procedure"
      expr: is_principal_procedure
      comment: "Whether this is the principal procedure for the visit (True/False) — used to identify primary revenue-generating procedures."
    - name: "drg_relevant_flag"
      expr: drg_relevant_flag
      comment: "Whether the procedure influences DRG assignment (True/False) — used in CDI and coding quality analysis."
    - name: "complication_flag"
      expr: complication_flag
      comment: "Whether a complication occurred during the procedure (True/False) — patient safety and quality KPI dimension."
    - name: "procedure_month"
      expr: DATE_TRUNC('MONTH', procedure_date)
      comment: "Month of procedure — time dimension for volume trend and revenue cycle analysis."
    - name: "surgical_approach"
      expr: surgical_approach
      comment: "Surgical approach used (e.g., laparoscopic, open, robotic) — used to track minimally invasive surgery adoption and outcomes."
  measures:
    - name: "total_procedures"
      expr: COUNT(1)
      comment: "Total number of procedures performed. Baseline volume metric for OR utilization, service line productivity, and revenue cycle reporting."
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total gross charges for all procedures. Primary revenue volume metric for service line financial performance and charge capture audits."
    - name: "avg_charge_amount"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge amount per procedure. Used to benchmark procedure pricing and identify charge capture anomalies."
    - name: "total_rvu_work"
      expr: SUM(CAST(rvu_work AS DOUBLE))
      comment: "Total work RVUs generated across all procedures. Primary physician productivity metric used for compensation modeling and service line benchmarking."
    - name: "avg_rvu_work"
      expr: AVG(CAST(rvu_work AS DOUBLE))
      comment: "Average work RVUs per procedure. Used to compare procedural complexity and physician productivity across specialties."
    - name: "total_rvu_total"
      expr: SUM(CAST(rvu_total AS DOUBLE))
      comment: "Total RVUs (work + practice expense + malpractice) across all procedures. Comprehensive productivity metric used in reimbursement modeling."
    - name: "procedure_complication_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN complication_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of procedures with a documented complication. Key patient safety and quality KPI monitored by CMOs and surgical quality committees."
    - name: "procedure_cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_cancelled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of scheduled procedures that were cancelled. High cancellation rates indicate OR scheduling inefficiency and lost revenue."
    - name: "timeout_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN timeout_performed_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN procedure_status = 'Completed' THEN 1 END), 0), 2)
      comment: "Percentage of completed procedures with a documented surgical timeout. Joint Commission patient safety requirement — non-compliance is a regulatory risk."
    - name: "consent_obtained_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_obtained_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of procedures with documented patient consent. Compliance metric — missing consent documentation creates legal and regulatory exposure."
    - name: "minimally_invasive_procedure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN surgical_approach IN ('Laparoscopic', 'Robotic', 'Endoscopic') THEN 1 END) / NULLIF(COUNT(CASE WHEN surgical_approach IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of surgical procedures performed using minimally invasive approaches. Tracks adoption of advanced surgical techniques linked to better outcomes and shorter LOS."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`encounter_visit_diagnosis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Visit diagnosis metrics tracking coding quality, HAI rates, HCC capture, chronic condition burden, and CDI performance. Used by coding, CDI, quality, and population health teams."
  source: "`healthcare_ecm`.`encounter`.`visit_diagnosis`"
  dimensions:
    - name: "diagnosis_type"
      expr: diagnosis_type
      comment: "Type of diagnosis (e.g., admitting, principal, secondary, discharge) — used to segment coding quality and DRG impact analysis."
    - name: "diagnosis_source"
      expr: diagnosis_source
      comment: "Source of the diagnosis assignment (e.g., physician, coder, CDI) — used to track documentation and coding workflow."
    - name: "coding_status"
      expr: coding_status
      comment: "Current coding status of the diagnosis (e.g., coded, pending, queried) — used to monitor coding completion and CDI workflow."
    - name: "poa_indicator"
      expr: poa_indicator
      comment: "Present on Admission indicator (Y/N/U/W/1) — critical for HAI reporting, quality metrics, and CMS payment adjustments."
    - name: "cc_mcc_indicator"
      expr: cc_mcc_indicator
      comment: "Complication/Comorbidity or Major CC indicator — key CDI metric indicating documentation quality and DRG weight impact."
    - name: "icd10_code"
      expr: icd10_code
      comment: "ICD-10-CM diagnosis code — used for clinical analytics, quality measure reporting, and population health stratification."
    - name: "hcc_category_code"
      expr: hcc_category_code
      comment: "Hierarchical Condition Category code — used for risk adjustment and value-based care performance reporting."
    - name: "chronic_condition_flag"
      expr: chronic_condition_flag
      comment: "Whether the diagnosis represents a chronic condition (True/False) — used for population health and care management program targeting."
    - name: "mental_health_flag"
      expr: mental_health_flag
      comment: "Whether the diagnosis is a mental health condition (True/False) — used for behavioral health capacity and co-morbidity analysis."
    - name: "sdoh_flag"
      expr: sdoh_flag
      comment: "Whether the diagnosis relates to social determinants of health (True/False) — used for equity reporting and community health investment."
    - name: "coded_month"
      expr: DATE_TRUNC('MONTH', coded_date)
      comment: "Month the diagnosis was coded — time dimension for coding productivity and CDI trend analysis."
  measures:
    - name: "total_visit_diagnoses"
      expr: COUNT(1)
      comment: "Total number of visit diagnosis records. Baseline coding volume metric for CDI and coding department productivity tracking."
    - name: "total_hai_diagnoses"
      expr: COUNT(CASE WHEN hai_flag = TRUE THEN 1 END)
      comment: "Count of diagnoses flagged as hospital-acquired infections. Critical patient safety metric tied to CMS non-payment policies and quality reporting."
    - name: "hai_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hai_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of diagnoses flagged as hospital-acquired infections. Key patient safety KPI monitored by infection control, CMOs, and regulatory bodies."
    - name: "hcc_capture_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hcc_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of diagnoses with an HCC code captured. Directly impacts risk adjustment scores and value-based care reimbursement — undercapture leads to revenue leakage."
    - name: "total_hcc_diagnoses"
      expr: COUNT(CASE WHEN hcc_flag = TRUE THEN 1 END)
      comment: "Total count of HCC-mapped diagnoses. Drives risk adjustment revenue in Medicare Advantage and ACO contracts."
    - name: "cc_mcc_capture_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cc_mcc_indicator IN ('CC', 'MCC') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of diagnoses capturing a CC or MCC. Higher rates reflect stronger CDI documentation and translate directly to higher DRG weights and reimbursement."
    - name: "primary_diagnosis_flag_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN primary_diagnosis_flag = TRUE THEN 1 END) / NULLIF(COUNT(DISTINCT visit_id), 0), 2)
      comment: "Average number of visits with a primary diagnosis flagged per total visits. Ensures coding completeness — visits without a primary diagnosis flag may have billing issues."
    - name: "chronic_condition_diagnosis_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN chronic_condition_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of diagnoses representing chronic conditions. Informs population health program design and care management resource allocation."
    - name: "sdoh_diagnosis_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sdoh_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of diagnoses with a social determinants of health code. Used for equity reporting, community benefit documentation, and targeted social work interventions."
    - name: "quality_measure_diagnosis_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_measure_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of diagnoses flagged as relevant to quality measures. Used to track quality measure denominator completeness and reporting accuracy."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`encounter_discharge_summary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discharge summary completion and quality metrics tracking documentation timeliness, care transition plan completion, and patient education compliance. Used by HIM, quality, and clinical leadership."
  source: "`healthcare_ecm`.`encounter`.`discharge_summary`"
  dimensions:
    - name: "summary_status"
      expr: summary_status
      comment: "Current status of the discharge summary (e.g., draft, finalized, addended) — used to monitor documentation completion rates."
    - name: "discharge_disposition"
      expr: discharge_disposition
      comment: "Where the patient was discharged to (e.g., home, SNF, rehab, expired) — used to analyze post-acute care transitions and readmission risk."
    - name: "discharge_disposition_code"
      expr: discharge_disposition_code
      comment: "Standardized discharge disposition code — used for CMS reporting and post-acute care analytics."
    - name: "discharge_condition"
      expr: discharge_condition
      comment: "Patient condition at discharge (e.g., stable, critical, improved) — used for quality and outcomes reporting."
    - name: "discharge_month"
      expr: DATE_TRUNC('MONTH', discharge_date)
      comment: "Month of discharge — time dimension for discharge summary timeliness trend analysis."
    - name: "care_transition_plan_completed"
      expr: care_transition_plan_completed
      comment: "Whether a care transition plan was completed at discharge (True/False) — key readmission prevention quality indicator."
    - name: "medication_reconciliation_completed"
      expr: medication_reconciliation_completed
      comment: "Whether medication reconciliation was completed at discharge (True/False) — patient safety and readmission prevention metric."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the discharge summary meets compliance requirements (True/False) — used for HIM audit and regulatory reporting."
    - name: "home_health_referral_made"
      expr: home_health_referral_made
      comment: "Whether a home health referral was made at discharge (True/False) — used to track post-acute care coordination."
  measures:
    - name: "total_discharge_summaries"
      expr: COUNT(1)
      comment: "Total number of discharge summaries. Baseline documentation volume metric for HIM and clinical operations."
    - name: "avg_time_to_completion_hours"
      expr: AVG(CAST(time_to_completion_hours AS DOUBLE))
      comment: "Average hours from discharge to discharge summary finalization. Key HIM quality metric — delays increase compliance risk and can hold up billing."
    - name: "summary_finalization_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN summary_status = 'Finalized' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of discharge summaries in finalized status. Incomplete summaries delay billing, create compliance risk, and impair care continuity."
    - name: "care_transition_plan_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN care_transition_plan_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of discharges with a completed care transition plan. Directly linked to readmission prevention program effectiveness and CMS quality reporting."
    - name: "medication_reconciliation_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN medication_reconciliation_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of discharges with completed medication reconciliation. Patient safety metric — incomplete reconciliation is a leading cause of preventable readmissions."
    - name: "discharge_instructions_issuance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN discharge_instructions_issued = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of discharges where written instructions were issued to the patient. Linked to HCAHPS scores, patient safety, and readmission reduction."
    - name: "patient_education_provision_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN patient_education_provided = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of discharges where patient education was documented as provided. Quality and accreditation metric tied to patient engagement and self-management."
    - name: "home_health_referral_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN home_health_referral_made = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of discharges with a home health referral. Used to track post-acute care coordination and identify gaps in discharge planning."
    - name: "compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of discharge summaries meeting compliance documentation requirements. Non-compliance exposes the organization to audit findings and regulatory penalties."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`encounter_bed_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bed assignment and throughput metrics tracking assignment efficiency, length of stay, isolation utilization, and bed type demand. Used by bed management, nursing operations, and hospital capacity leadership."
  source: "`healthcare_ecm`.`encounter`.`bed_assignment`"
  dimensions:
    - name: "bed_type"
      expr: bed_type
      comment: "Type of bed assigned (e.g., ICU, step-down, med-surg, observation) — primary dimension for capacity and utilization analysis."
    - name: "bed_class"
      expr: bed_class
      comment: "Bed classification (e.g., acute, critical care, behavioral health) — used for service line capacity planning."
    - name: "patient_class"
      expr: patient_class
      comment: "Patient classification at time of assignment (e.g., inpatient, observation, ED) — used to segment LOS and throughput metrics."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the bed assignment (e.g., active, discharged, transferred) — used to monitor real-time census."
    - name: "is_isolation_bed"
      expr: is_isolation_bed
      comment: "Whether the assigned bed is an isolation bed (True/False) — used for infection control capacity planning."
    - name: "is_observation_status"
      expr: is_observation_status
      comment: "Whether the patient is under observation status in this bed (True/False) — used for CMS two-midnight rule compliance tracking."
    - name: "is_telemetry_monitored"
      expr: is_telemetry_monitored
      comment: "Whether the bed has telemetry monitoring (True/False) — used for cardiac monitoring capacity and utilization analysis."
    - name: "discharge_disposition_code"
      expr: discharge_disposition_code
      comment: "Discharge disposition code at end of bed assignment — used to analyze post-acute care transitions and bed turnover patterns."
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Month of admission — time dimension for bed utilization trend analysis."
    - name: "isolation_type"
      expr: isolation_type
      comment: "Type of isolation precaution required (e.g., contact, airborne, droplet) — used for infection control resource planning."
  measures:
    - name: "total_bed_assignments"
      expr: COUNT(1)
      comment: "Total number of bed assignments. Baseline census and throughput metric for bed management and capacity operations."
    - name: "avg_los_days"
      expr: AVG(CAST(los_days AS DOUBLE))
      comment: "Average length of stay in days across bed assignments. Core throughput metric — elevated LOS drives capacity constraints and increased cost per case."
    - name: "total_isolation_assignments"
      expr: COUNT(CASE WHEN is_isolation_bed = TRUE THEN 1 END)
      comment: "Count of bed assignments to isolation beds. Used for infection control capacity planning and isolation room utilization reporting."
    - name: "isolation_bed_utilization_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_isolation_bed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bed assignments utilizing isolation beds. High rates during outbreak periods signal capacity strain and infection control resource needs."
    - name: "telemetry_bed_utilization_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_telemetry_monitored = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bed assignments with telemetry monitoring. Used to assess cardiac monitoring capacity utilization and equipment investment needs."
    - name: "observation_status_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_observation_status = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bed assignments under observation status. Tracks CMS two-midnight rule exposure and potential inpatient conversion opportunities."
    - name: "avg_expected_vs_actual_los_variance"
      expr: AVG(los_days - CAST(DATEDIFF(discharge_date, admission_date) AS DECIMAL(18,2)))
      comment: "Average variance between recorded LOS days and date-calculated LOS. Used to identify data quality issues in LOS reporting and case management outliers."
$$;