-- Metric views for domain: encounter | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 16:05:56

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core encounter visit metrics tracking volume, length of stay, readmission risk, observation utilization, and care transition compliance across all patient visits. Primary KPI surface for hospital operations and executive dashboards."
  source: "`vibe_healthcare_v1`.`encounter`.`visit`"
  dimensions:
    - name: "visit_type"
      expr: visit_type
      comment: "Type of visit (inpatient, outpatient, ED, etc.) for segmenting volume and performance metrics."
    - name: "admission_type"
      expr: admission_type
      comment: "Admission classification (elective, emergency, urgent, newborn) for case-mix analysis."
    - name: "admission_source"
      expr: admission_source
      comment: "Source of admission (ED, physician referral, transfer, etc.) to understand patient flow origins."
    - name: "discharge_disposition"
      expr: discharge_disposition
      comment: "Where the patient was discharged to (home, SNF, rehab, expired) for post-acute utilization analysis."
    - name: "care_setting"
      expr: care_setting
      comment: "Clinical care setting (ICU, med-surg, telemetry, etc.) for resource and capacity planning."
    - name: "financial_class"
      expr: financial_class
      comment: "Payer financial class (Medicare, Medicaid, commercial, self-pay) for revenue and payer-mix analysis."
    - name: "visit_status"
      expr: visit_status
      comment: "Current status of the visit (active, discharged, cancelled) for operational filtering."
    - name: "drg_type"
      expr: drg_type
      comment: "DRG classification type (MS-DRG, APR-DRG) for reimbursement and case-mix analysis."
    - name: "observation_status"
      expr: observation_status
      comment: "Flag indicating whether the visit is under observation status vs. inpatient admission — critical for Two-Midnight Rule compliance."
    - name: "readmission_flag"
      expr: readmission_flag
      comment: "Boolean flag indicating whether this visit is a readmission, used to segment readmission volume."
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_timestamp)
      comment: "Month of admission for trend analysis of visit volume and performance over time."
    - name: "discharge_month"
      expr: DATE_TRUNC('MONTH', discharge_timestamp)
      comment: "Month of discharge for throughput and LOS trend reporting."
    - name: "two_midnight_compliant"
      expr: two_midnight_compliant
      comment: "Compliance with the CMS Two-Midnight Rule for inpatient admission appropriateness."
    - name: "converted_to_inpatient"
      expr: converted_to_inpatient
      comment: "Flag indicating observation-to-inpatient conversion, relevant for revenue cycle and compliance."
    - name: "telehealth_platform"
      expr: telehealth_platform
      comment: "Telehealth platform used for virtual visits, enabling telehealth utilization analysis."
  measures:
    - name: "total_visits"
      expr: COUNT(1)
      comment: "Total number of patient visits. Baseline volume KPI used in all operational and executive dashboards."
    - name: "total_readmissions"
      expr: COUNT(CASE WHEN readmission_flag = TRUE THEN 1 END)
      comment: "Total number of visits flagged as readmissions. Directly tied to HRRP penalties and quality scores."
    - name: "readmission_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN readmission_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visits that are readmissions. Key quality and penalty-risk metric for CMS HRRP compliance."
    - name: "avg_expected_los_days"
      expr: AVG(CAST(expected_los_days AS DOUBLE))
      comment: "Average expected length of stay in days. Benchmark for capacity planning and case management efficiency."
    - name: "avg_drg_weight"
      expr: AVG(CAST(drg_weight AS DOUBLE))
      comment: "Average DRG weight across visits, reflecting case-mix complexity and expected reimbursement intensity."
    - name: "total_observation_hours"
      expr: SUM(CAST(observation_hours AS DOUBLE))
      comment: "Total observation hours across all visits. Drives revenue cycle decisions on observation vs. inpatient status."
    - name: "avg_observation_hours"
      expr: AVG(CAST(observation_hours AS DOUBLE))
      comment: "Average observation hours per visit. Informs Two-Midnight Rule compliance and observation-to-inpatient conversion strategy."
    - name: "avg_readmission_risk_score"
      expr: AVG(CAST(readmission_risk_score AS DOUBLE))
      comment: "Average readmission risk score across visits. Enables proactive care management targeting for high-risk patients."
    - name: "observation_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN converted_to_inpatient = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN observation_status = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of observation visits converted to inpatient. Measures revenue capture effectiveness and clinical appropriateness."
    - name: "care_transition_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN care_transition_plan_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visits with a completed care transition plan. Linked to readmission reduction and quality measure performance."
    - name: "discharge_instructions_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN discharge_instructions_issued = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visits where discharge instructions were issued. Regulatory and quality compliance KPI."
    - name: "telehealth_visit_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN telehealth_platform IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visits conducted via telehealth. Strategic metric for digital health program investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_drg_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DRG assignment metrics covering case-mix complexity, reimbursement performance, length-of-stay efficiency, and outlier risk. Critical for revenue cycle, CDI programs, and payer contract negotiations."
  source: "`vibe_healthcare_v1`.`encounter`.`drg_assignment`"
  dimensions:
    - name: "drg_description"
      expr: drg_description
      comment: "Human-readable DRG description for case-mix reporting and clinical program analysis."
    - name: "mdc_code"
      expr: mdc_code
      comment: "Major Diagnostic Category code for high-level service line grouping."
    - name: "mdc_description"
      expr: mdc_description
      comment: "Major Diagnostic Category description for executive service line dashboards."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of DRG assignment (initial, final, appeal) for tracking CDI and coding workflow stages."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the DRG assignment for workflow and revenue cycle monitoring."
    - name: "patient_type"
      expr: patient_type
      comment: "Patient type classification (inpatient, observation) for reimbursement segmentation."
    - name: "admit_source_code"
      expr: admit_source_code
      comment: "Source of admission code for case-mix and referral pattern analysis."
    - name: "cc_mcc_flag"
      expr: cc_mcc_flag
      comment: "Flag indicating presence of a complication or comorbidity (CC) or major CC (MCC), directly impacting DRG weight and reimbursement."
    - name: "is_outlier"
      expr: is_outlier
      comment: "Flag indicating the case qualifies for outlier payment, signaling high-cost or extended-stay cases."
    - name: "drg_changed_flag"
      expr: drg_changed_flag
      comment: "Flag indicating the DRG was changed after initial assignment, reflecting CDI query impact."
    - name: "rac_review_flag"
      expr: rac_review_flag
      comment: "Flag indicating the case was selected for RAC (Recovery Audit Contractor) review — a compliance and financial risk indicator."
    - name: "grouping_month"
      expr: DATE_TRUNC('MONTH', grouping_date)
      comment: "Month of DRG grouping for trend analysis of case-mix and reimbursement over time."
    - name: "grouper_software"
      expr: grouper_software
      comment: "Grouper software used for DRG assignment, relevant for audit and version-control tracking."
    - name: "transfer_case_flag"
      expr: transfer_case_flag
      comment: "Flag indicating a transfer case, which affects reimbursement calculation under transfer payment rules."
  measures:
    - name: "total_drg_assignments"
      expr: COUNT(1)
      comment: "Total number of DRG assignments. Baseline volume for case-mix and CDI program reporting."
    - name: "avg_drg_weight"
      expr: AVG(CAST(drg_weight AS DOUBLE))
      comment: "Average DRG weight reflecting case-mix complexity. A rising CMI indicates higher-acuity patients and greater reimbursement potential."
    - name: "total_expected_reimbursement"
      expr: SUM(CAST(expected_reimbursement AS DOUBLE))
      comment: "Total expected reimbursement across all DRG assignments. Primary revenue forecast metric for finance and revenue cycle leadership."
    - name: "avg_expected_reimbursement"
      expr: AVG(CAST(expected_reimbursement AS DOUBLE))
      comment: "Average expected reimbursement per case. Benchmarks reimbursement efficiency against case complexity."
    - name: "avg_actual_los"
      expr: AVG(CAST(actual_los AS DOUBLE))
      comment: "Average actual length of stay in days. Core efficiency metric compared against geometric and arithmetic mean LOS benchmarks."
    - name: "avg_geometric_mean_los"
      expr: AVG(CAST(geometric_mean_los AS DOUBLE))
      comment: "Average geometric mean LOS (CMS benchmark). Used to assess whether actual LOS is above or below the national standard."
    - name: "avg_arithmetic_mean_los"
      expr: AVG(CAST(arithmetic_mean_los AS DOUBLE))
      comment: "Average arithmetic mean LOS (CMS benchmark). Secondary LOS benchmark for outlier threshold calculations."
    - name: "los_efficiency_ratio"
      expr: ROUND(AVG(CAST(actual_los AS DOUBLE)) / NULLIF(AVG(CAST(geometric_mean_los AS DOUBLE)), 0), 3)
      comment: "Ratio of actual LOS to geometric mean LOS. Values above 1.0 indicate inefficiency vs. national benchmarks; drives case management intervention."
    - name: "total_outlier_payment"
      expr: SUM(CAST(outlier_payment AS DOUBLE))
      comment: "Total outlier payments received. High outlier payments signal high-cost cases requiring clinical and financial review."
    - name: "outlier_case_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_outlier = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases qualifying for outlier payment. Elevated rates may indicate documentation gaps or high-acuity case concentration."
    - name: "cc_mcc_capture_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cc_mcc_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases with a CC or MCC captured. Key CDI program effectiveness metric — higher rates reflect better clinical documentation."
    - name: "drg_change_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN drg_changed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DRG assignments that were changed after initial grouping. Measures CDI query impact and coding accuracy."
    - name: "avg_initial_drg_weight"
      expr: AVG(CAST(initial_drg_weight AS DOUBLE))
      comment: "Average DRG weight at initial assignment. Compared against final avg_drg_weight to quantify CDI program uplift."
    - name: "rac_review_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rac_review_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases selected for RAC review. Elevated rates signal compliance risk and potential recoupment exposure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_readmission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Readmission analytics covering HRRP penalty exposure, preventability assessment, risk stratification, and care gap identification. Directly tied to CMS quality programs and financial penalties."
  source: "`vibe_healthcare_v1`.`encounter`.`readmission`"
  dimensions:
    - name: "readmission_type"
      expr: readmission_type
      comment: "Type of readmission (planned, unplanned, related, unrelated) for quality program segmentation."
    - name: "readmission_status"
      expr: readmission_status
      comment: "Current review status of the readmission record for workflow tracking."
    - name: "hrrp_measure_category"
      expr: hrrp_measure_category
      comment: "CMS HRRP measure category (AMI, HF, pneumonia, COPD, hip/knee, CABG) for penalty exposure analysis by condition."
    - name: "is_hrrp_applicable"
      expr: is_hrrp_applicable
      comment: "Flag indicating whether the readmission falls under a CMS HRRP measure, directly linking to penalty calculations."
    - name: "is_related_to_index"
      expr: is_related_to_index
      comment: "Flag indicating whether the readmission is clinically related to the index admission."
    - name: "payer_type"
      expr: payer_type
      comment: "Payer type (Medicare, Medicaid, commercial) for readmission analysis by payer segment."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the readmission (medication, follow-up, social determinants, etc.) for targeted intervention design."
    - name: "preventability_assessment"
      expr: preventability_assessment
      comment: "Clinical assessment of whether the readmission was preventable — core metric for quality improvement programs."
    - name: "admit_source"
      expr: admit_source
      comment: "Source of the readmission admission for patient flow and care coordination analysis."
    - name: "sdoh_flag"
      expr: sdoh_flag
      comment: "Flag indicating social determinants of health contributed to the readmission — informs community health investment decisions."
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Month of readmission for trend analysis of readmission rates over time."
    - name: "index_discharge_month"
      expr: DATE_TRUNC('MONTH', index_discharge_date)
      comment: "Month of index discharge for cohort-based readmission rate tracking."
    - name: "risk_score_model"
      expr: risk_score_model
      comment: "Model used to generate the readmission risk score for methodology comparison and validation."
    - name: "aco_attributed"
      expr: aco_attributed
      comment: "Flag indicating ACO attribution, relevant for value-based care contract performance."
  measures:
    - name: "total_readmissions"
      expr: COUNT(1)
      comment: "Total number of readmission events. Baseline volume for HRRP and quality program reporting."
    - name: "hrrp_applicable_readmissions"
      expr: COUNT(CASE WHEN is_hrrp_applicable = TRUE THEN 1 END)
      comment: "Number of readmissions subject to CMS HRRP penalty calculation. Direct financial risk exposure metric."
    - name: "preventable_readmissions"
      expr: COUNT(CASE WHEN preventability_assessment = 'Preventable' THEN 1 END)
      comment: "Number of readmissions assessed as preventable. Primary target for care management and quality improvement interventions."
    - name: "preventable_readmission_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN preventability_assessment = 'Preventable' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of readmissions assessed as preventable. Drives quality improvement investment and care management program design."
    - name: "total_estimated_penalty_amount"
      expr: SUM(CAST(estimated_penalty_amount AS DOUBLE))
      comment: "Total estimated HRRP penalty amount across readmissions. Direct financial impact metric for CFO and revenue cycle leadership."
    - name: "avg_estimated_penalty_amount"
      expr: AVG(CAST(estimated_penalty_amount AS DOUBLE))
      comment: "Average estimated penalty per readmission event. Benchmarks penalty exposure per case for prioritization."
    - name: "avg_hrrp_excess_readmission_ratio"
      expr: AVG(CAST(hrrp_excess_readmission_ratio AS DOUBLE))
      comment: "Average HRRP excess readmission ratio. Values above 1.0 indicate performance worse than the national average, triggering penalties."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average readmission risk score across the cohort. Enables risk stratification for proactive care management targeting."
    - name: "sdoh_readmission_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sdoh_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of readmissions with a social determinants of health flag. Informs community health and social work investment decisions."
    - name: "medication_reconciliation_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN medication_reconciliation_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of readmissions where medication reconciliation was completed at index discharge. Measures a key preventable readmission intervention."
    - name: "follow_up_scheduling_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_appointment_scheduled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of readmissions where a follow-up appointment was scheduled post-index discharge. Measures care transition effectiveness."
    - name: "transition_of_care_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN transition_of_care_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of readmissions where transition of care was completed. Directly linked to readmission prevention program effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization metrics covering approval rates, denial patterns, turnaround time, peer-to-peer review outcomes, and financial authorization amounts. Critical for revenue cycle, utilization management, and payer relations."
  source: "`vibe_healthcare_v1`.`encounter`.`authorization`"
  dimensions:
    - name: "authorization_type"
      expr: authorization_type
      comment: "Type of authorization (inpatient, outpatient, procedure, DME) for utilization management segmentation."
    - name: "authorization_status"
      expr: authorization_status
      comment: "Current status of the authorization (approved, denied, pending, appealed) for workflow and revenue risk monitoring."
    - name: "service_category"
      expr: service_category
      comment: "Service category requiring authorization for utilization pattern analysis by clinical program."
    - name: "service_type"
      expr: service_type
      comment: "Specific service type within the category for granular denial and approval analysis."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Payer denial reason code for root cause analysis of authorization denials and appeal strategy."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency level of the authorization request (routine, urgent, emergent) for turnaround time benchmarking."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the authorization (portal, phone, fax, EDI) for process efficiency analysis."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility requesting authorization for network and contract analysis."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any appeal filed against a denial, for tracking appeal success rates."
    - name: "peer_to_peer_review_flag"
      expr: peer_to_peer_review_flag
      comment: "Flag indicating a peer-to-peer review was conducted, used to measure P2P utilization and outcomes."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_datetime)
      comment: "Month of authorization request for trend analysis of volume and turnaround time."
    - name: "extension_requested_flag"
      expr: extension_requested_flag
      comment: "Flag indicating an extension was requested, signaling cases with extended care needs."
    - name: "priority"
      expr: priority
      comment: "Priority level of the authorization request for workload and SLA management."
  measures:
    - name: "total_authorizations"
      expr: COUNT(1)
      comment: "Total number of authorization requests. Baseline volume for utilization management and revenue cycle reporting."
    - name: "approved_authorizations"
      expr: COUNT(CASE WHEN authorization_status = 'Approved' THEN 1 END)
      comment: "Number of approved authorizations. Numerator for approval rate calculation."
    - name: "denied_authorizations"
      expr: COUNT(CASE WHEN authorization_status = 'Denied' THEN 1 END)
      comment: "Number of denied authorizations. Key revenue risk and payer relations metric."
    - name: "authorization_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN authorization_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of authorization requests that are approved. Low rates signal payer friction and revenue risk."
    - name: "authorization_denial_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN authorization_status = 'Denied' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of authorization requests that are denied. Elevated rates trigger payer contract renegotiation and clinical documentation improvement."
    - name: "avg_turnaround_time_hours"
      expr: AVG(CAST(turnaround_time_hours AS DOUBLE))
      comment: "Average authorization turnaround time in hours. Measures payer responsiveness and operational efficiency against SLA targets."
    - name: "total_authorized_amount"
      expr: SUM(CAST(authorized_amount AS DOUBLE))
      comment: "Total dollar amount authorized across all requests. Revenue cycle metric for expected reimbursement forecasting."
    - name: "avg_authorized_amount"
      expr: AVG(CAST(authorized_amount AS DOUBLE))
      comment: "Average authorized amount per authorization. Benchmarks authorization value by service type and payer."
    - name: "peer_to_peer_utilization_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN peer_to_peer_review_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN authorization_status = 'Denied' THEN 1 END), 0), 2)
      comment: "Percentage of denied authorizations that proceeded to peer-to-peer review. Measures utilization management team's appeal aggressiveness."
    - name: "appeal_filed_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_status IS NOT NULL AND appeal_status != '' THEN 1 END) / NULLIF(COUNT(CASE WHEN authorization_status = 'Denied' THEN 1 END), 0), 2)
      comment: "Percentage of denied authorizations for which an appeal was filed. Measures revenue recovery effort intensity."
    - name: "avg_approved_quantity"
      expr: AVG(CAST(approved_quantity AS DOUBLE))
      comment: "Average quantity approved per authorization. Compared against requested quantity to assess payer reduction patterns."
    - name: "avg_requested_quantity"
      expr: AVG(CAST(requested_quantity AS DOUBLE))
      comment: "Average quantity requested per authorization. Baseline for measuring payer-approved quantity vs. clinical need."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_triage_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Emergency department triage metrics covering acuity distribution, door-to-triage time, left-without-being-seen rates, sepsis and stroke alert activation, and vital sign benchmarks. Core ED operational and quality KPIs."
  source: "`vibe_healthcare_v1`.`encounter`.`triage_assessment`"
  dimensions:
    - name: "esi_level"
      expr: esi_level
      comment: "Emergency Severity Index (ESI) triage level (1-5) for acuity distribution and resource allocation analysis."
    - name: "triage_category"
      expr: triage_category
      comment: "Triage category classification for ED patient flow and capacity management."
    - name: "arrival_mode"
      expr: arrival_mode
      comment: "Mode of patient arrival (ambulance, walk-in, helicopter, etc.) for ED resource and diversion planning."
    - name: "chief_complaint"
      expr: chief_complaint
      comment: "Chief complaint at triage for clinical program and disease burden analysis."
    - name: "triage_status"
      expr: triage_status
      comment: "Current status of the triage assessment for workflow monitoring."
    - name: "sepsis_alert_flag"
      expr: sepsis_alert_flag
      comment: "Flag indicating a sepsis alert was triggered at triage — critical quality and mortality metric."
    - name: "stroke_alert_flag"
      expr: stroke_alert_flag
      comment: "Flag indicating a stroke alert was triggered at triage — time-sensitive quality metric."
    - name: "trauma_activation_flag"
      expr: trauma_activation_flag
      comment: "Flag indicating trauma team activation at triage for trauma program volume and resource planning."
    - name: "trauma_level"
      expr: trauma_level
      comment: "Trauma activation level (Level 1, 2, 3) for trauma program performance benchmarking."
    - name: "mental_health_flag"
      expr: mental_health_flag
      comment: "Flag indicating a mental health presentation at triage for behavioral health capacity planning."
    - name: "isolation_required_flag"
      expr: isolation_required_flag
      comment: "Flag indicating isolation was required at triage for infection control and capacity management."
    - name: "lwbs_flag"
      expr: lwbs_flag
      comment: "Left Without Being Seen flag — a key ED quality and patient satisfaction metric."
    - name: "arrival_month"
      expr: DATE_TRUNC('MONTH', door_arrival_timestamp)
      comment: "Month of patient arrival for ED volume trend analysis."
    - name: "triage_reassessment_flag"
      expr: triage_reassessment_flag
      comment: "Flag indicating a triage reassessment was performed, relevant for acuity escalation monitoring."
  measures:
    - name: "total_triage_assessments"
      expr: COUNT(1)
      comment: "Total number of triage assessments. Baseline ED volume metric for staffing and capacity planning."
    - name: "lwbs_count"
      expr: COUNT(CASE WHEN lwbs_flag = TRUE THEN 1 END)
      comment: "Number of patients who left without being seen. Directly impacts patient satisfaction scores and revenue leakage."
    - name: "lwbs_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN lwbs_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ED patients who left without being seen. A key ED throughput and patient experience KPI; elevated rates signal capacity or flow problems."
    - name: "sepsis_alert_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sepsis_alert_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of triage assessments triggering a sepsis alert. Monitors sepsis screening protocol adherence and disease burden."
    - name: "stroke_alert_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN stroke_alert_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of triage assessments triggering a stroke alert. Monitors stroke protocol activation rates for time-to-treatment quality metrics."
    - name: "trauma_activation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN trauma_activation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of triage assessments resulting in trauma team activation. Informs trauma program resource planning and volume benchmarking."
    - name: "mental_health_presentation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN mental_health_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ED presentations with a mental health component. Drives behavioral health capacity and diversion program investment."
    - name: "avg_spo2_percent"
      expr: AVG(CAST(spo2_percent AS DOUBLE))
      comment: "Average oxygen saturation at triage. Population-level vital sign benchmark for respiratory acuity monitoring."
    - name: "avg_temperature_celsius"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average temperature at triage in Celsius. Population-level vital sign benchmark for infection and sepsis surveillance."
    - name: "avg_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average patient weight at triage in kilograms. Population health metric for obesity burden and medication dosing protocol analysis."
    - name: "high_acuity_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN esi_level IN ('1', '2') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of triage assessments classified as ESI Level 1 or 2 (highest acuity). Drives ED staffing ratios and resuscitation bay capacity planning."
    - name: "isolation_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN isolation_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of triage assessments requiring isolation. Informs infection control resource planning and isolation room capacity management."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_visit_procedure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procedure-level metrics covering surgical volume, RVU productivity, complication rates, cancellation rates, and charge capture. Core metrics for surgical program performance, physician productivity, and revenue cycle."
  source: "`vibe_healthcare_v1`.`encounter`.`visit_procedure`"
  dimensions:
    - name: "procedure_type"
      expr: procedure_type
      comment: "Type of procedure (surgical, diagnostic, therapeutic) for service line volume and revenue analysis."
    - name: "procedure_status"
      expr: procedure_status
      comment: "Current status of the procedure (completed, cancelled, in-progress) for operational monitoring."
    - name: "cpt_code"
      expr: cpt_code
      comment: "CPT code for the procedure — primary dimension for charge capture, reimbursement, and utilization analysis."
    - name: "anesthesia_type"
      expr: anesthesia_type
      comment: "Type of anesthesia used for anesthesia program volume and resource planning."
    - name: "asa_class"
      expr: asa_class
      comment: "ASA physical status classification for surgical risk stratification and outcome benchmarking."
    - name: "body_site"
      expr: body_site
      comment: "Anatomical body site of the procedure for clinical program and surgical volume analysis."
    - name: "wound_class"
      expr: wound_class
      comment: "Wound classification (clean, clean-contaminated, contaminated, dirty) for infection risk and quality reporting."
    - name: "surgical_approach"
      expr: surgical_approach
      comment: "Surgical approach (open, laparoscopic, robotic) for technology utilization and outcome analysis."
    - name: "is_elective"
      expr: is_elective
      comment: "Flag indicating whether the procedure was elective vs. emergent for scheduling and capacity planning."
    - name: "is_principal_procedure"
      expr: is_principal_procedure
      comment: "Flag indicating the principal procedure for DRG assignment and reimbursement analysis."
    - name: "complication_flag"
      expr: complication_flag
      comment: "Flag indicating a procedural complication occurred — key quality and patient safety metric."
    - name: "is_cancelled"
      expr: is_cancelled
      comment: "Flag indicating the procedure was cancelled for OR efficiency and revenue leakage analysis."
    - name: "procedure_month"
      expr: DATE_TRUNC('MONTH', procedure_date)
      comment: "Month of procedure for volume trend and productivity reporting."
    - name: "laterality"
      expr: laterality
      comment: "Laterality of the procedure (left, right, bilateral) for wrong-site surgery prevention and quality reporting."
    - name: "drg_relevant_flag"
      expr: drg_relevant_flag
      comment: "Flag indicating the procedure is relevant to DRG assignment, linking procedure volume to reimbursement impact."
  measures:
    - name: "total_procedures"
      expr: COUNT(1)
      comment: "Total number of procedures performed. Baseline surgical and procedural volume metric."
    - name: "total_rvu_work"
      expr: SUM(CAST(rvu_work AS DOUBLE))
      comment: "Total work RVUs generated. Primary physician productivity metric used for compensation, benchmarking, and staffing decisions."
    - name: "avg_rvu_work"
      expr: AVG(CAST(rvu_work AS DOUBLE))
      comment: "Average work RVUs per procedure. Benchmarks procedure-level physician productivity against national standards."
    - name: "total_rvu"
      expr: SUM(CAST(rvu_total AS DOUBLE))
      comment: "Total RVUs (work + practice expense + malpractice) generated. Comprehensive productivity and reimbursement metric."
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charges generated by procedures. Revenue cycle metric for gross charge capture and service line revenue analysis."
    - name: "avg_charge_amount"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge amount per procedure. Benchmarks charge capture efficiency by procedure type and provider."
    - name: "complication_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN complication_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of procedures with a documented complication. Key patient safety and quality metric for surgical program accreditation."
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_cancelled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of scheduled procedures that were cancelled. Measures OR efficiency and revenue leakage from cancellations."
    - name: "timeout_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN timeout_performed_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_cancelled = FALSE OR is_cancelled IS NULL THEN 1 END), 0), 2)
      comment: "Percentage of completed procedures where a surgical timeout was performed. Critical patient safety and Joint Commission compliance metric."
    - name: "consent_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_obtained_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_cancelled = FALSE OR is_cancelled IS NULL THEN 1 END), 0), 2)
      comment: "Percentage of completed procedures with documented consent obtained. Regulatory compliance and risk management metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_discharge_summary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discharge summary completion and quality metrics covering documentation timeliness, care transition compliance, medication reconciliation, and follow-up scheduling. Drives regulatory compliance, readmission prevention, and quality program performance."
  source: "`vibe_healthcare_v1`.`encounter`.`discharge_summary`"
  dimensions:
    - name: "summary_status"
      expr: summary_status
      comment: "Status of the discharge summary (draft, finalized, addended) for documentation workflow monitoring."
    - name: "discharge_disposition"
      expr: discharge_disposition
      comment: "Discharge disposition (home, SNF, rehab, expired) for post-acute utilization and care transition analysis."
    - name: "discharge_disposition_code"
      expr: discharge_disposition_code
      comment: "Standardized discharge disposition code for regulatory reporting and payer billing."
    - name: "discharge_condition"
      expr: discharge_condition
      comment: "Patient condition at discharge (good, fair, poor, critical) for outcome and quality reporting."
    - name: "functional_status_at_discharge"
      expr: functional_status_at_discharge
      comment: "Patient functional status at discharge for post-acute care planning and outcome benchmarking."
    - name: "follow_up_scheduled"
      expr: follow_up_scheduled
      comment: "Flag indicating a follow-up appointment was scheduled — key readmission prevention metric."
    - name: "medication_reconciliation_completed"
      expr: medication_reconciliation_completed
      comment: "Flag indicating medication reconciliation was completed at discharge — regulatory and readmission prevention metric."
    - name: "home_health_referral_made"
      expr: home_health_referral_made
      comment: "Flag indicating a home health referral was made — post-acute utilization and care transition metric."
    - name: "discharge_month"
      expr: DATE_TRUNC('MONTH', discharge_date)
      comment: "Month of discharge for trend analysis of documentation timeliness and compliance."
    - name: "care_transition_plan_completed"
      expr: care_transition_plan_completed
      comment: "Flag indicating a care transition plan was completed — directly linked to readmission prevention program effectiveness."
    - name: "patient_education_provided"
      expr: patient_education_provided
      comment: "Flag indicating patient education was provided at discharge — quality and regulatory compliance metric."
  measures:
    - name: "total_discharge_summaries"
      expr: COUNT(1)
      comment: "Total number of discharge summaries. Baseline documentation volume metric."
    - name: "avg_time_to_completion_hours"
      expr: AVG(CAST(time_to_completion_hours AS DOUBLE))
      comment: "Average time from discharge to summary completion in hours. Regulatory compliance metric — CMS and Joint Commission require timely completion."
    - name: "medication_reconciliation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN medication_reconciliation_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of discharge summaries with completed medication reconciliation. Key readmission prevention and quality measure metric."
    - name: "follow_up_scheduling_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_scheduled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of discharges with a follow-up appointment scheduled. Directly linked to readmission reduction and care continuity."
    - name: "care_transition_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN care_transition_plan_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of discharges with a completed care transition plan. Measures care coordination program effectiveness."
    - name: "discharge_instructions_issuance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN discharge_instructions_issued = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of discharges where instructions were issued to the patient. Regulatory compliance and patient safety metric."
    - name: "patient_education_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN patient_education_provided = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of discharges where patient education was provided. Quality measure metric linked to patient engagement and readmission prevention."
    - name: "home_health_referral_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN home_health_referral_made = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of discharges with a home health referral. Measures post-acute care utilization and care transition intensity."
    - name: "composite_discharge_quality_score"
      expr: ROUND(100.0 * (COUNT(CASE WHEN medication_reconciliation_completed = TRUE THEN 1 END) + COUNT(CASE WHEN follow_up_scheduled = TRUE THEN 1 END) + COUNT(CASE WHEN care_transition_plan_completed = TRUE THEN 1 END) + COUNT(CASE WHEN discharge_instructions_issued = TRUE THEN 1 END)) / NULLIF(4.0 * COUNT(1), 0), 2)
      comment: "Composite discharge quality score averaging four key discharge process completion rates (medication reconciliation, follow-up scheduling, care transition plan, discharge instructions). Executive-level quality scorecard metric."
$$;