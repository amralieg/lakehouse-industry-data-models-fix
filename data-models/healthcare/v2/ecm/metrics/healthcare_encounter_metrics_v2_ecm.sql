-- Metric views for domain: encounter | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 14:47:42

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_drg_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DRG assignment KPIs for case-mix index, expected reimbursement, length-of-stay variance, and CDI/coding integrity steering."
  source: "`vibe_healthcare_v1`.`encounter`.`drg_assignment`"
  dimensions:
    - name: "patient_type"
      expr: patient_type
      comment: "Patient type for inpatient vs outpatient DRG case-mix segmentation."
    - name: "mdc_description"
      expr: mdc_description
      comment: "Major Diagnostic Category for service-line case-mix and reimbursement analysis."
    - name: "assignment_status"
      expr: assignment_status
      comment: "DRG assignment status to track finalized vs working DRGs."
    - name: "drg_description"
      expr: drg_description
      comment: "DRG description for case-level reimbursement and length-of-stay benchmarking."
    - name: "grouping_month"
      expr: DATE_TRUNC('MONTH', grouping_date)
      comment: "Month of DRG grouping for trended case-mix index analysis."
  measures:
    - name: "DRG Assignment Count"
      expr: COUNT(1)
      comment: "Number of DRG assignments — baseline inpatient case volume for case-mix steering."
    - name: "Avg DRG Weight"
      expr: AVG(CAST(drg_weight AS DOUBLE))
      comment: "Average DRG relative weight (case-mix index proxy) — directly drives expected reimbursement and acuity profile."
    - name: "Total Expected Reimbursement"
      expr: SUM(CAST(expected_reimbursement AS DOUBLE))
      comment: "Total expected DRG reimbursement — core revenue forecasting metric for inpatient services."
    - name: "Avg Actual LOS"
      expr: AVG(CAST(actual_los AS DOUBLE))
      comment: "Average actual length of stay — compared to GMLOS for efficiency and cost-of-care steering."
    - name: "Avg Geometric Mean LOS"
      expr: AVG(CAST(geometric_mean_los AS DOUBLE))
      comment: "Average geometric mean LOS benchmark — the standard against which actual LOS variance is evaluated."
    - name: "Total Outlier Payment"
      expr: SUM(CAST(outlier_payment AS DOUBLE))
      comment: "Total outlier payments — flags high-cost cases and reimbursement variability."
    - name: "CC MCC Capture Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cc_mcc_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of cases with CC/MCC capture — measures CDI effectiveness and documentation-driven reimbursement."
    - name: "DRG Change Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN drg_changed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of DRGs changed from initial assignment — indicates coding accuracy and CDI query impact."
    - name: "Outlier Case Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_outlier = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of cases classified as outliers — signals cost and length-of-stay management opportunities."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_readmission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Readmission KPIs for HRRP penalty exposure, preventability, and care-transition effectiveness steering."
  source: "`vibe_healthcare_v1`.`encounter`.`readmission`"
  dimensions:
    - name: "readmission_type"
      expr: readmission_type
      comment: "Type of readmission (planned/unplanned) for penalty-relevant segmentation."
    - name: "hrrp_measure_category"
      expr: hrrp_measure_category
      comment: "HRRP measure category (e.g. AMI, HF, PNA) for CMS penalty cohort analysis."
    - name: "payer_type"
      expr: payer_type
      comment: "Payer type for readmission cost and penalty exposure by payer mix."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for targeting readmission-reduction interventions."
    - name: "readmission_status"
      expr: readmission_status
      comment: "Readmission tracking status for case review workflow monitoring."
  measures:
    - name: "Readmission Count"
      expr: COUNT(1)
      comment: "Total tracked readmissions — baseline metric for readmission-reduction program steering."
    - name: "Total Estimated Penalty Amount"
      expr: SUM(CAST(estimated_penalty_amount AS DOUBLE))
      comment: "Total estimated HRRP penalty exposure — directly ties readmissions to financial risk for leadership."
    - name: "Avg HRRP Excess Readmission Ratio"
      expr: AVG(CAST(hrrp_excess_readmission_ratio AS DOUBLE))
      comment: "Average HRRP excess readmission ratio — the CMS metric driving payment penalties."
    - name: "Avg Risk Score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average readmission risk score — informs care management resource allocation."
    - name: "HRRP Applicable Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_hrrp_applicable = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of readmissions falling under HRRP — sizes penalty-relevant population."
    - name: "Follow Up Appointment Scheduled Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_appointment_scheduled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with scheduled follow-up — leading indicator of care-transition effectiveness."
    - name: "Medication Reconciliation Completion Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN medication_reconciliation_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with completed med reconciliation — actionable readmission-prevention process measure."
    - name: "Transition Of Care Completion Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN transition_of_care_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with completed transition-of-care — core driver of readmission reduction."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_triage_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ED triage KPIs for acuity mix, LWBS rate, and time-critical alert performance steering."
  source: "`vibe_healthcare_v1`.`encounter`.`triage_assessment`"
  dimensions:
    - name: "esi_level"
      expr: esi_level
      comment: "Emergency Severity Index level for ED acuity-mix and staffing analysis."
    - name: "triage_category"
      expr: triage_category
      comment: "Triage category for ED throughput and resource segmentation."
    - name: "arrival_mode"
      expr: arrival_mode
      comment: "Mode of arrival (ambulance, walk-in) for ED volume and capacity planning."
    - name: "triage_status"
      expr: triage_status
      comment: "Triage status for active ED workflow monitoring."
    - name: "triage_month"
      expr: DATE_TRUNC('MONTH', triage_timestamp)
      comment: "Triage month bucket for trended ED volume analysis."
  measures:
    - name: "Triage Assessment Count"
      expr: COUNT(1)
      comment: "Total ED triage assessments — baseline ED volume metric for capacity and staffing steering."
    - name: "LWBS Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN lwbs_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Left-without-being-seen rate — a key ED access, patient-safety, and revenue-leakage indicator."
    - name: "Sepsis Alert Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sepsis_alert_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Sepsis alert rate at triage — drives early-recognition quality and mortality-reduction efforts."
    - name: "Stroke Alert Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN stroke_alert_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Stroke alert rate — measures time-critical pathway activation for quality steering."
    - name: "Trauma Activation Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN trauma_activation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Trauma activation rate — informs trauma-center resource readiness and designation compliance."
    - name: "Mental Health Presentation Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mental_health_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Behavioral-health presentation rate — sizes psychiatric boarding and resource demand."
    - name: "Avg Pulse Oximetry Pct"
      expr: AVG(CAST(spo2_percent AS DOUBLE))
      comment: "Average SpO2 at triage — population acuity indicator for respiratory-illness surveillance."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_bed_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bed assignment KPIs for throughput, length of stay, request-to-assignment delay, and isolation/private-room utilization."
  source: "`vibe_healthcare_v1`.`encounter`.`bed_assignment`"
  dimensions:
    - name: "bed_type"
      expr: bed_type
      comment: "Bed type (ICU, med-surg, telemetry) for capacity and acuity utilization analysis."
    - name: "unit_name"
      expr: unit_name
      comment: "Nursing unit name for unit-level throughput and occupancy steering."
    - name: "patient_class"
      expr: patient_class
      comment: "Patient class for inpatient vs observation bed-utilization segmentation."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Assignment status for active bed-management monitoring."
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Admission month bucket for trended bed-demand analysis."
  measures:
    - name: "Bed Assignment Count"
      expr: COUNT(1)
      comment: "Total bed assignments — baseline throughput metric for capacity-management steering."
    - name: "Avg LOS Days"
      expr: AVG(CAST(los_days AS DOUBLE))
      comment: "Average bed length of stay — primary driver of bed availability and cost-per-day analysis."
    - name: "Isolation Bed Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_isolation_bed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of assignments to isolation beds — informs infection-control capacity demand."
    - name: "Observation Status Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_observation_status = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of bed assignments in observation status — flags observation revenue risk."
    - name: "Telemetry Monitored Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_telemetry_monitored = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of telemetry-monitored assignments — sizes monitored-bed capacity demand."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_discharge_summary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discharge documentation KPIs for timeliness, care-transition completion, and medication reconciliation compliance."
  source: "`vibe_healthcare_v1`.`encounter`.`discharge_summary`"
  dimensions:
    - name: "discharge_disposition"
      expr: discharge_disposition
      comment: "Discharge disposition for post-acute placement and care-transition analysis."
    - name: "summary_status"
      expr: summary_status
      comment: "Discharge summary status for documentation-completion workflow monitoring."
    - name: "discharge_condition"
      expr: discharge_condition
      comment: "Patient condition at discharge for outcome and quality segmentation."
    - name: "discharge_month"
      expr: DATE_TRUNC('MONTH', discharge_date)
      comment: "Discharge month bucket for trended discharge-volume and timeliness analysis."
  measures:
    - name: "Discharge Summary Count"
      expr: COUNT(1)
      comment: "Total discharge summaries — baseline discharge-volume metric for care-transition steering."
    - name: "Avg Time To Completion Hours"
      expr: AVG(CAST(time_to_completion_hours AS DOUBLE))
      comment: "Average hours to complete discharge summary — key documentation-timeliness and billing-cycle metric."
    - name: "Care Transition Plan Completion Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN care_transition_plan_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with completed care-transition plans — drives readmission reduction and CMS compliance."
    - name: "Medication Reconciliation Completion Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN medication_reconciliation_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with completed med reconciliation at discharge — patient-safety and quality measure."
    - name: "Follow Up Scheduled Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_scheduled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with scheduled follow-up appointments — leading indicator of transition-of-care quality."
    - name: "Home Health Referral Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN home_health_referral_made = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with home-health referrals — informs post-acute network utilization and care-continuity."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_visit_procedure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Encounter procedure KPIs for RVU productivity, charge capture, complication rates, and elective vs cancellation tracking."
  source: "`vibe_healthcare_v1`.`encounter`.`visit_procedure`"
  dimensions:
    - name: "procedure_type"
      expr: procedure_type
      comment: "Procedure type for service-line volume and revenue segmentation."
    - name: "procedure_status"
      expr: procedure_status
      comment: "Procedure status for completion and cancellation monitoring."
    - name: "anesthesia_type"
      expr: anesthesia_type
      comment: "Anesthesia type for OR resource and acuity analysis."
    - name: "asa_class"
      expr: asa_class
      comment: "ASA physical-status class for surgical risk stratification."
    - name: "procedure_month"
      expr: DATE_TRUNC('MONTH', procedure_date)
      comment: "Procedure month bucket for trended procedural-volume analysis."
  measures:
    - name: "Procedure Count"
      expr: COUNT(1)
      comment: "Total procedures performed — baseline procedural-volume metric for service-line steering."
    - name: "Total Charge Amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total procedural charges — core revenue metric for procedural service lines."
    - name: "Total Work RVUs"
      expr: SUM(CAST(rvu_work AS DOUBLE))
      comment: "Total work RVUs — primary physician-productivity and compensation-modeling metric."
    - name: "Total RVUs"
      expr: SUM(CAST(rvu_total AS DOUBLE))
      comment: "Total RVUs — measures overall procedural resource intensity and productivity."
    - name: "Complication Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN complication_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Procedural complication rate — core quality and patient-safety steering metric."
    - name: "Cancellation Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_cancelled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Procedure cancellation rate — informs OR utilization and scheduling efficiency."
    - name: "Timeout Performed Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN timeout_performed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Surgical timeout compliance rate — critical Joint Commission patient-safety measure."
    - name: "Elective Procedure Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_elective = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent elective procedures — informs scheduling predictability and capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Encounter authorization KPIs for approval rate, turnaround time, denial tracking, and payer authorization performance steering."
  source: "`vibe_healthcare_v1`.`encounter`.`encounter_authorization`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Authorization status (approved, denied, pending) for revenue-cycle risk monitoring."
    - name: "authorization_type"
      expr: authorization_type
      comment: "Authorization type for prior-auth workflow segmentation."
    - name: "service_category"
      expr: service_category
      comment: "Service category for authorization volume and denial-pattern analysis by service."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency level for prioritization and turnaround-time SLA monitoring."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_datetime)
      comment: "Request month bucket for trended authorization-volume analysis."
  measures:
    - name: "Authorization Count"
      expr: COUNT(1)
      comment: "Total authorization requests — baseline revenue-cycle volume metric for prior-auth steering."
    - name: "Total Authorized Amount"
      expr: SUM(CAST(authorized_amount AS DOUBLE))
      comment: "Total authorized dollar amount — informs expected-revenue and denial-risk exposure."
    - name: "Avg Turnaround Time Hours"
      expr: AVG(CAST(turnaround_time_hours AS DOUBLE))
      comment: "Average authorization turnaround hours — drives access-to-care timeliness and revenue-cycle efficiency."
    - name: "Approval Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN authorization_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Authorization approval rate — leading indicator of denial risk and revenue capture."
    - name: "Peer To Peer Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN peer_to_peer_conducted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent requiring peer-to-peer review — sizes physician-time burden in authorization workflow."
    - name: "Extension Requested Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN extension_requested_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of authorizations requesting extensions — flags length-of-stay and continued-stay risk."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_transfer_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inter-facility transfer KPIs for EMTALA compliance, acceptance, and bed-availability readiness steering."
  source: "`vibe_healthcare_v1`.`encounter`.`transfer_request`"
  dimensions:
    - name: "transfer_type"
      expr: transfer_type
      comment: "Transfer type (inbound, outbound, intra-system) for network-flow analysis."
    - name: "transfer_status"
      expr: transfer_status
      comment: "Transfer status for active transfer-coordination monitoring."
    - name: "acuity_level"
      expr: acuity_level
      comment: "Patient acuity level for transfer prioritization and resource matching."
    - name: "level_of_care_required"
      expr: level_of_care_required
      comment: "Required level of care for receiving-facility capability matching."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Request month bucket for trended transfer-volume analysis."
  measures:
    - name: "Transfer Request Count"
      expr: COUNT(1)
      comment: "Total transfer requests — baseline volume metric for transfer-center and network-flow steering."
    - name: "EMTALA Compliance Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN emtala_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "EMTALA compliance rate — critical regulatory-risk and patient-safety metric for transfers."
    - name: "Bed Availability Confirmed Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN bed_availability_confirmed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with confirmed bed availability — informs transfer-acceptance readiness and throughput."
    - name: "Patient Consent Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN patient_consent_obtained = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Patient-consent completion rate — compliance and documentation-integrity measure for transfers."
    - name: "Medical Records Sent Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN medical_records_sent = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with medical records sent — continuity-of-care and care-coordination quality metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_visit_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Visit coverage KPIs for eligibility verification, network status, and patient cost-share exposure for revenue-cycle steering."
  source: "`vibe_healthcare_v1`.`encounter`.`visit_coverage`"
  dimensions:
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Eligibility status for coverage-verification and denial-risk monitoring."
    - name: "network_status"
      expr: network_status
      comment: "Network status (in/out of network) for patient-liability and revenue analysis."
    - name: "authorization_status"
      expr: authorization_status
      comment: "Authorization status for revenue-cycle risk segmentation."
    - name: "coverage_sequence"
      expr: coverage_sequence
      comment: "Coverage sequence (primary/secondary) for coordination-of-benefits analysis."
  measures:
    - name: "Visit Coverage Count"
      expr: COUNT(1)
      comment: "Total coverage records — baseline metric for coverage-verification workload steering."
    - name: "Total Copay Amount"
      expr: SUM(CAST(copay_amount AS DOUBLE))
      comment: "Total copay exposure — informs patient-responsibility collection planning."
    - name: "Avg Copay Amount"
      expr: AVG(CAST(copay_amount AS DOUBLE))
      comment: "Average copay per visit — informs point-of-service collection strategy."
    - name: "Total Deductible Met Amount"
      expr: SUM(CAST(deductible_met_amount AS DOUBLE))
      comment: "Total deductible met — informs patient cost-share and revenue-cycle forecasting."
    - name: "Eligibility Verified Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN eligibility_status = 'Verified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with verified eligibility — leading indicator of clean-claim rate and denial avoidance."
    - name: "Out Of Network Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN network_status = 'Out of Network' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Out-of-network coverage rate — flags patient-liability and surprise-billing risk."
$$;