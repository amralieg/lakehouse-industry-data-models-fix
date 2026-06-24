-- Metric views for domain: radiology | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 14:47:42

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_imaging_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Imaging order volume, turnaround, prior-auth and STAT operational KPIs used by radiology operations and revenue leadership to steer throughput and access."
  source: "`vibe_healthcare_v1`.`radiology`.`imaging_order`"
  dimensions:
    - name: "modality_type"
      expr: modality_type
      comment: "Imaging modality (CT, MR, XR, US) for volume and capacity steering by modality line."
    - name: "order_priority"
      expr: order_priority
      comment: "Order priority used to track STAT vs routine mix and access management."
    - name: "order_status"
      expr: order_status
      comment: "Lifecycle status of the imaging order to monitor backlog and cancellations."
    - name: "prior_auth_status"
      expr: prior_auth_status
      comment: "Prior authorization status, a key revenue-leakage and denial-risk dimension."
    - name: "referring_department"
      expr: referring_department
      comment: "Referring department to identify ordering demand sources for capacity planning."
    - name: "body_part"
      expr: body_part
      comment: "Anatomical body part examined for service-line analysis."
    - name: "ordered_month"
      expr: DATE_TRUNC('MONTH', ordered_timestamp)
      comment: "Month the order was placed for trended volume analysis."
  measures:
    - name: "Imaging Order Volume"
      expr: COUNT(1)
      comment: "Total imaging orders; baseline demand metric for capacity and staffing decisions."
    - name: "Distinct Patients Imaged"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Unique patients ordered for imaging; measures reach and avoids double-counting repeat orders."
    - name: "STAT Order Count"
      expr: COUNT(CASE WHEN is_stat_override = TRUE THEN 1 END)
      comment: "Count of STAT-override orders; drives urgent-workflow staffing and SLA monitoring."
    - name: "Cancelled Order Count"
      expr: COUNT(CASE WHEN cancelled_timestamp IS NOT NULL THEN 1 END)
      comment: "Cancelled orders; cancellation leakage impacts utilization and revenue."
    - name: "Critical Finding Order Count"
      expr: COUNT(CASE WHEN critical_finding_flag = TRUE THEN 1 END)
      comment: "Orders flagged with critical findings; patient-safety and notification compliance signal."
    - name: "Prior Auth Pending Count"
      expr: COUNT(CASE WHEN prior_auth_status = 'PENDING' THEN 1 END)
      comment: "Orders awaiting prior authorization; revenue-at-risk indicator for denial prevention."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiology appointment access, no-show, and scheduling efficiency KPIs to steer capacity utilization and patient access."
  source: "`vibe_healthcare_v1`.`radiology`.`radiology_appointment`"
  dimensions:
    - name: "appointment_status"
      expr: appointment_status
      comment: "Appointment status to track completion, cancellation, and no-show mix."
    - name: "modality_type"
      expr: modality_type
      comment: "Modality of the appointment for modality-level utilization steering."
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel used to book; informs self-service and digital access strategy."
    - name: "insurance_verification_status"
      expr: insurance_verification_status
      comment: "Insurance verification status, a financial clearance and denial-prevention dimension."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting (inpatient/outpatient/ED) for access and capacity segmentation."
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Scheduled month for trended access and volume analysis."
  measures:
    - name: "Appointment Volume"
      expr: COUNT(1)
      comment: "Total scheduled radiology appointments; baseline for capacity and access planning."
    - name: "No Show Count"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "No-show appointments; directly impacts utilization, revenue, and patient access."
    - name: "No Show Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of appointments that no-showed; key utilization-loss KPI for intervention."
    - name: "STAT Appointment Count"
      expr: COUNT(CASE WHEN is_stat = TRUE THEN 1 END)
      comment: "STAT appointments; urgent-access workload indicator."
    - name: "Avg Scheduled Duration Min"
      expr: AVG(CAST(scheduled_duration_minutes AS DOUBLE))
      comment: "Average scheduled appointment duration; informs slot template and capacity design."
    - name: "Insurance Unverified Count"
      expr: COUNT(CASE WHEN insurance_verification_status <> 'VERIFIED' THEN 1 END)
      comment: "Appointments without verified insurance; financial-clearance risk for denial prevention."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_reader_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiologist reading turnaround time, SLA compliance, RVU productivity, and teleradiology routing KPIs for read-quality and throughput steering."
  source: "`vibe_healthcare_v1`.`radiology`.`reader_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Reading assignment status to monitor unread worklist backlog."
    - name: "modality"
      expr: modality
      comment: "Modality of the assigned study for subspecialty workload balancing."
    - name: "priority"
      expr: priority
      comment: "Assignment priority to track STAT vs routine reading SLAs."
    - name: "reading_site"
      expr: reading_site
      comment: "Site performing the read; distributed-read and teleradiology steering."
    - name: "assigned_month"
      expr: DATE_TRUNC('MONTH', assigned_timestamp)
      comment: "Month assigned for trended productivity and TAT analysis."
  measures:
    - name: "Reading Assignment Volume"
      expr: COUNT(1)
      comment: "Total reading assignments; baseline radiologist workload metric."
    - name: "Avg Turnaround Minutes"
      expr: AVG(CAST(tat_minutes AS DOUBLE))
      comment: "Average read turnaround; core throughput and patient-care timeliness KPI."
    - name: "SLA Met Count"
      expr: COUNT(CASE WHEN sla_met = TRUE THEN 1 END)
      comment: "Reads meeting SLA; drives TAT performance management."
    - name: "SLA Compliance Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_met = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of reads meeting SLA target; key service-quality KPI on steering dashboards."
    - name: "Total RVU"
      expr: SUM(CAST(rvu_value AS DOUBLE))
      comment: "Total relative value units read; productivity and revenue-capacity measure."
    - name: "Teleradiology Read Count"
      expr: COUNT(CASE WHEN is_teleradiology = TRUE THEN 1 END)
      comment: "Teleradiology-routed reads; outsourcing cost and coverage indicator."
    - name: "Subspecialty Match Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN subspecialty_match = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Reads matched to subspecialty; read-quality and accuracy steering metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiology report finalization, critical-finding communication, and addendum KPIs to steer reporting quality and patient-safety compliance."
  source: "`vibe_healthcare_v1`.`radiology`.`report`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Report lifecycle status to monitor preliminary vs finalized backlog."
    - name: "modality_code"
      expr: modality_code
      comment: "Modality of the report for service-line quality segmentation."
    - name: "rads_category"
      expr: rads_category
      comment: "RADS structured-reporting category for standardized result analysis."
    - name: "body_part"
      expr: body_part
      comment: "Body part reported for clinical service-line analysis."
    - name: "finalized_month"
      expr: DATE_TRUNC('MONTH', study_datetime)
      comment: "Month of the study for trended reporting volume and quality."
  measures:
    - name: "Report Volume"
      expr: COUNT(1)
      comment: "Total radiology reports; baseline reporting output metric."
    - name: "Critical Finding Count"
      expr: COUNT(CASE WHEN critical_finding_flag = TRUE THEN 1 END)
      comment: "Reports with critical findings; patient-safety and notification compliance driver."
    - name: "Critical Finding Communicated Count"
      expr: COUNT(CASE WHEN critical_finding_communicated_flag = TRUE THEN 1 END)
      comment: "Critical findings communicated; The Joint Commission compliance KPI."
    - name: "Critical Communication Compliance Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_finding_communicated_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN critical_finding_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percent of critical findings communicated; mandatory patient-safety compliance metric."
    - name: "STAT Report Count"
      expr: COUNT(CASE WHEN stat_priority_flag = TRUE THEN 1 END)
      comment: "STAT-priority reports; urgent-reporting workload indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_dose_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiation dose monitoring KPIs (CTDIvol, DLP, effective dose, alerts, registry submission) for radiation safety and regulatory compliance steering."
  source: "`vibe_healthcare_v1`.`radiology`.`dose_record`"
  dimensions:
    - name: "modality_type"
      expr: modality_type
      comment: "Modality type for dose benchmarking by imaging line."
    - name: "body_part_examined"
      expr: body_part_examined
      comment: "Body part examined for protocol-level dose optimization analysis."
    - name: "drl_comparison_result"
      expr: drl_comparison_result
      comment: "Diagnostic reference level comparison result for dose-optimization governance."
    - name: "dose_registry_submission_status"
      expr: dose_registry_submission_status
      comment: "ACR Dose Index Registry submission status for compliance reporting."
    - name: "study_month"
      expr: DATE_TRUNC('MONTH', study_date)
      comment: "Month of study for dose trend monitoring."
  measures:
    - name: "Dose Record Volume"
      expr: COUNT(1)
      comment: "Total dose records; baseline radiation exposure event count."
    - name: "Avg Effective Dose mSv"
      expr: AVG(CAST(effective_dose_msv AS DOUBLE))
      comment: "Average effective dose; core radiation-safety KPI for ALARA monitoring."
    - name: "Avg CTDIvol mGy"
      expr: AVG(CAST(ctdivol_mgy AS DOUBLE))
      comment: "Average CT dose index volume; equipment and protocol dose-optimization metric."
    - name: "Avg DLP mGy cm"
      expr: AVG(CAST(dlp_mgy_cm AS DOUBLE))
      comment: "Average dose-length product; protocol-level radiation exposure indicator."
    - name: "Dose Alert Count"
      expr: COUNT(CASE WHEN dose_alert_flag = TRUE THEN 1 END)
      comment: "Records exceeding dose alert thresholds; safety-intervention trigger."
    - name: "Dose Alert Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dose_alert_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of studies triggering dose alerts; radiation-safety governance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_critical_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Critical result notification and acknowledgment turnaround KPIs for patient-safety and EMTALA/TJC compliance steering."
  source: "`vibe_healthcare_v1`.`radiology`.`critical_result`"
  dimensions:
    - name: "finding_severity"
      expr: finding_severity
      comment: "Severity of the critical finding for prioritization and escalation analysis."
    - name: "notification_status"
      expr: notification_status
      comment: "Notification status to monitor unacknowledged critical results."
    - name: "notification_method"
      expr: notification_method
      comment: "Method of notification for closed-loop communication analysis."
    - name: "tjc_compliance_status"
      expr: tjc_compliance_status
      comment: "Joint Commission compliance status for critical-result reporting governance."
    - name: "finding_month"
      expr: DATE_TRUNC('MONTH', finding_datetime)
      comment: "Month finding occurred for trended safety compliance analysis."
  measures:
    - name: "Critical Result Volume"
      expr: COUNT(1)
      comment: "Total critical results; baseline patient-safety event count."
    - name: "Acknowledged Count"
      expr: COUNT(CASE WHEN acknowledgment_datetime IS NOT NULL THEN 1 END)
      comment: "Critical results acknowledged; closed-loop communication completion metric."
    - name: "Read Back Performed Count"
      expr: COUNT(CASE WHEN read_back_performed = TRUE THEN 1 END)
      comment: "Read-back-confirmed notifications; verified communication safety metric."
    - name: "Escalation Count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Escalated critical results; indicates notification breakdowns requiring intervention."
    - name: "Patient Safety Event Count"
      expr: COUNT(CASE WHEN patient_safety_event_flag = TRUE THEN 1 END)
      comment: "Critical results linked to safety events; risk-management steering metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_follow_up`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incidental finding follow-up recommendation tracking, overdue and care-gap closure KPIs to steer follow-up compliance and reduce lost-to-follow-up risk."
  source: "`vibe_healthcare_v1`.`radiology`.`follow_up`"
  dimensions:
    - name: "follow_up_status"
      expr: follow_up_status
      comment: "Follow-up lifecycle status to monitor open vs closed recommendations."
    - name: "follow_up_type"
      expr: follow_up_type
      comment: "Type of follow-up for recommendation category analysis."
    - name: "recommended_modality"
      expr: recommended_modality
      comment: "Recommended modality for follow-up demand planning."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the follow-up for risk-based prioritization."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month follow-up is due for backlog and aging analysis."
  measures:
    - name: "Follow Up Volume"
      expr: COUNT(1)
      comment: "Total follow-up recommendations; baseline care-coordination workload."
    - name: "Overdue Count"
      expr: COUNT(CASE WHEN is_overdue = TRUE THEN 1 END)
      comment: "Overdue follow-ups; directly impacts patient-safety and malpractice risk."
    - name: "Overdue Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_overdue = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of follow-ups overdue; key follow-up compliance KPI for intervention."
    - name: "Care Gap Count"
      expr: COUNT(CASE WHEN care_gap_flag = TRUE THEN 1 END)
      comment: "Follow-ups flagged as care gaps; population-health and quality-measure driver."
    - name: "Lost To Follow Up Count"
      expr: COUNT(CASE WHEN lost_to_follow_up_date IS NOT NULL THEN 1 END)
      comment: "Patients lost to follow-up; risk and missed-diagnosis exposure metric."
    - name: "Patient Notified Count"
      expr: COUNT(CASE WHEN patient_notified_flag = TRUE THEN 1 END)
      comment: "Follow-ups with patient notification; closed-loop outreach completion metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_interventional_procedure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interventional radiology procedure outcome, complication, and efficiency KPIs to steer IR quality and procedural safety."
  source: "`vibe_healthcare_v1`.`radiology`.`interventional_procedure`"
  dimensions:
    - name: "procedure_category"
      expr: procedure_category
      comment: "IR procedure category for service-line outcome analysis."
    - name: "procedure_status"
      expr: procedure_status
      comment: "Procedure status to monitor completion and cancellation."
    - name: "anesthesia_type"
      expr: anesthesia_type
      comment: "Anesthesia type for procedural-risk and resourcing analysis."
    - name: "case_complexity"
      expr: case_complexity
      comment: "Case complexity for outcome benchmarking and resourcing."
    - name: "procedure_month"
      expr: DATE_TRUNC('MONTH', procedure_datetime)
      comment: "Month of procedure for trended IR volume and quality."
  measures:
    - name: "Procedure Volume"
      expr: COUNT(1)
      comment: "Total interventional procedures; baseline IR throughput metric."
    - name: "Complication Count"
      expr: COUNT(CASE WHEN complication_occurred = TRUE THEN 1 END)
      comment: "Procedures with complications; core IR safety and quality KPI."
    - name: "Complication Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN complication_occurred = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of procedures with complications; quality and risk steering metric."
    - name: "Technical Success Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN technical_success = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of procedures technically successful; outcome-quality KPI."
    - name: "Avg Procedure Duration Min"
      expr: AVG(CAST(procedure_duration_minutes AS DOUBLE))
      comment: "Average procedure duration; OR/IR-suite efficiency and scheduling metric."
    - name: "Avg Fluoroscopy Time Min"
      expr: AVG(CAST(fluoroscopy_time_minutes AS DOUBLE))
      comment: "Average fluoroscopy time; operator radiation-dose and technique-safety metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_modality`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Imaging equipment asset utilization, accreditation, and maintenance KPIs for capital and operational asset-management steering."
  source: "`vibe_healthcare_v1`.`radiology`.`modality`"
  dimensions:
    - name: "equipment_type"
      expr: equipment_type
      comment: "Equipment type for fleet composition and utilization analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status to monitor available vs down equipment."
    - name: "acr_accreditation_status"
      expr: acr_accreditation_status
      comment: "ACR accreditation status, a billing-eligibility and compliance dimension."
    - name: "manufacturer"
      expr: manufacturer
      comment: "Equipment manufacturer for vendor and standardization analysis."
  measures:
    - name: "Modality Asset Count"
      expr: COUNT(1)
      comment: "Total imaging equipment assets; capital fleet sizing metric."
    - name: "Operational Asset Count"
      expr: COUNT(CASE WHEN operational_status = 'OPERATIONAL' THEN 1 END)
      comment: "Operational assets; available capacity for scheduling and utilization."
    - name: "Avg Scheduled Hours Per Day"
      expr: AVG(CAST(scheduled_hours_per_day AS DOUBLE))
      comment: "Average scheduled hours per day per asset; capacity-utilization planning metric."
    - name: "Accreditation Expired Count"
      expr: COUNT(CASE WHEN acr_accreditation_status <> 'ACTIVE' THEN 1 END)
      comment: "Assets without active ACR accreditation; billing-risk and compliance indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_teleradiology_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Teleradiology case turnaround, SLA compliance, and reconciliation discrepancy KPIs to steer outsourced reading quality and vendor performance."
  source: "`vibe_healthcare_v1`.`radiology`.`teleradiology_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Teleradiology case status to monitor pending vs finalized reads."
    - name: "priority_level"
      expr: priority_level
      comment: "Case priority for STAT vs routine teleradiology SLA tracking."
    - name: "modality_code"
      expr: modality_code
      comment: "Modality of teleradiology case for workload distribution analysis."
    - name: "routing_reason"
      expr: routing_reason
      comment: "Reason for teleradiology routing; informs after-hours/coverage strategy."
    - name: "study_month"
      expr: DATE_TRUNC('MONTH', study_datetime)
      comment: "Month of study for trended teleradiology volume and TAT."
  measures:
    - name: "Teleradiology Case Volume"
      expr: COUNT(1)
      comment: "Total teleradiology cases; baseline outsourced-read demand metric."
    - name: "Avg Actual TAT Minutes"
      expr: AVG(CAST(actual_tat_minutes AS DOUBLE))
      comment: "Average actual turnaround; outsourced-read timeliness and vendor-SLA KPI."
    - name: "SLA Met Count"
      expr: COUNT(CASE WHEN sla_met = TRUE THEN 1 END)
      comment: "Cases meeting SLA; vendor performance-management metric."
    - name: "SLA Compliance Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_met = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of teleradiology cases meeting SLA; vendor accountability KPI."
    - name: "Reconciliation Discrepancy Count"
      expr: COUNT(CASE WHEN reconciliation_discrepancy_flag = TRUE THEN 1 END)
      comment: "Cases with preliminary/final discrepancy; read-quality and patient-safety signal."
    - name: "Critical Finding Count"
      expr: COUNT(CASE WHEN critical_finding_flag = TRUE THEN 1 END)
      comment: "Teleradiology cases with critical findings; safety-notification workload metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_report_distribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Report delivery, acknowledgment, retry, and SLA KPIs to steer report-distribution reliability and closed-loop result communication."
  source: "`vibe_healthcare_v1`.`radiology`.`report_distribution`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status to monitor failed vs successful report distribution."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Delivery channel (fax, Direct, portal, HIE) for channel-reliability analysis."
    - name: "recipient_type"
      expr: recipient_type
      comment: "Recipient type (provider, patient, organization) for distribution segmentation."
    - name: "distribution_priority"
      expr: distribution_priority
      comment: "Distribution priority for STAT vs routine delivery SLA tracking."
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', delivery_datetime)
      comment: "Month of delivery for trended distribution reliability."
  measures:
    - name: "Distribution Volume"
      expr: COUNT(1)
      comment: "Total report distributions; baseline delivery workload metric."
    - name: "Failed Delivery Count"
      expr: COUNT(CASE WHEN delivery_status = 'FAILED' THEN 1 END)
      comment: "Failed deliveries; reliability and result-communication risk indicator."
    - name: "SLA Compliance Count"
      expr: COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END)
      comment: "Deliveries meeting SLA; distribution timeliness performance metric."
    - name: "SLA Compliance Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of deliveries meeting SLA; distribution reliability steering KPI."
    - name: "Critical Result Acknowledged Count"
      expr: COUNT(CASE WHEN critical_result_acknowledged_flag = TRUE THEN 1 END)
      comment: "Critical-result distributions acknowledged; closed-loop safety compliance metric."
    - name: "Avg Delivery Latency Seconds"
      expr: AVG(CAST(delivery_latency_seconds AS DOUBLE))
      comment: "Average delivery latency; channel-performance and timeliness metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_peer_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiologist peer-review (RADPEER) discrepancy and OPPE/FPPE KPIs to steer interpretation quality and provider performance governance."
  source: "`vibe_healthcare_v1`.`radiology`.`radiology_peer_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Peer-review status to monitor open vs completed reviews."
    - name: "acr_radpeer_score"
      expr: acr_radpeer_score
      comment: "ACR RADPEER concordance score for interpretation-quality benchmarking."
    - name: "discrepancy_category"
      expr: discrepancy_category
      comment: "Discrepancy category for error-pattern and quality-improvement analysis."
    - name: "subspecialty"
      expr: subspecialty
      comment: "Subspecialty under review for targeted quality governance."
    - name: "review_month"
      expr: DATE_TRUNC('MONTH', review_datetime)
      comment: "Month of review for trended peer-review quality analysis."
  measures:
    - name: "Peer Review Volume"
      expr: COUNT(1)
      comment: "Total peer reviews completed; baseline quality-governance activity metric."
    - name: "Patient Safety Event Count"
      expr: COUNT(CASE WHEN patient_safety_event_flag = TRUE THEN 1 END)
      comment: "Peer reviews tied to safety events; risk-management escalation metric."
    - name: "Escalated To Chair Count"
      expr: COUNT(CASE WHEN escalated_to_chair_flag = TRUE THEN 1 END)
      comment: "Reviews escalated to department chair; significant-discrepancy governance signal."
    - name: "OPPE FPPE Count"
      expr: COUNT(CASE WHEN oppe_fppe_flag = TRUE THEN 1 END)
      comment: "Reviews tied to OPPE/FPPE; provider-performance evaluation compliance metric."
    - name: "Subspecialty Matched Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN subspecialty_matched_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of reviews with subspecialty-matched reviewer; review-validity quality metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_contrast_admin`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contrast media administration safety KPIs (adverse reactions, extravasation, screening compliance) for contrast-safety governance."
  source: "`vibe_healthcare_v1`.`radiology`.`contrast_admin`"
  dimensions:
    - name: "agent_class"
      expr: agent_class
      comment: "Contrast agent class for safety benchmarking by agent type."
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration for reaction-pattern analysis."
    - name: "modality"
      expr: modality
      comment: "Modality during contrast administration for safety segmentation."
    - name: "administration_status"
      expr: administration_status
      comment: "Administration status to monitor completed vs aborted contrast events."
    - name: "administration_month"
      expr: DATE_TRUNC('MONTH', administration_datetime)
      comment: "Month of administration for trended contrast-safety analysis."
  measures:
    - name: "Contrast Administration Volume"
      expr: COUNT(1)
      comment: "Total contrast administrations; baseline contrast-utilization metric."
    - name: "Adverse Reaction Count"
      expr: COUNT(CASE WHEN adverse_reaction_occurred = TRUE THEN 1 END)
      comment: "Contrast adverse reactions; core contrast-safety and pharmacovigilance KPI."
    - name: "Adverse Reaction Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN adverse_reaction_occurred = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of administrations with adverse reactions; safety steering metric."
    - name: "Extravasation Count"
      expr: COUNT(CASE WHEN extravasation_occurred = TRUE THEN 1 END)
      comment: "Contrast extravasation events; technique-quality and safety indicator."
    - name: "Screening Performed Count"
      expr: COUNT(CASE WHEN contrast_allergy_screening_result IS NOT NULL THEN 1 END)
      comment: "Administrations with allergy screening; pre-contrast safety-protocol compliance metric."
    - name: "Avg Dose Volume mL"
      expr: AVG(CAST(dose_volume_ml AS DOUBLE))
      comment: "Average contrast dose volume; utilization and dose-optimization metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_order_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order workflow transition timing and SLA-breach KPIs to steer radiology workflow efficiency and bottleneck identification."
  source: "`vibe_healthcare_v1`.`radiology`.`radiology_order_status_history`"
  dimensions:
    - name: "new_status"
      expr: new_status
      comment: "New status of the transition for workflow-stage analysis."
    - name: "workflow_step"
      expr: workflow_step
      comment: "Workflow step for bottleneck identification across the imaging pipeline."
    - name: "modality_type"
      expr: modality_type
      comment: "Modality type for stage-timing analysis by imaging line."
    - name: "order_priority"
      expr: order_priority
      comment: "Order priority for SLA-breach analysis by urgency tier."
    - name: "transition_month"
      expr: DATE_TRUNC('MONTH', status_change_timestamp)
      comment: "Month of transition for trended workflow-timing analysis."
  measures:
    - name: "Status Transition Volume"
      expr: COUNT(1)
      comment: "Total status transitions; baseline workflow-event count."
    - name: "SLA Breach Count"
      expr: COUNT(CASE WHEN is_sla_breach = TRUE THEN 1 END)
      comment: "Transitions breaching SLA; workflow-bottleneck and timeliness indicator."
    - name: "SLA Breach Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_sla_breach = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of transitions breaching SLA; workflow-efficiency steering KPI."
    - name: "Avg Duration In Status Min"
      expr: AVG(CAST(duration_in_status_minutes AS DOUBLE))
      comment: "Average time spent in status; identifies workflow stage delays."
    - name: "Corrective Entry Count"
      expr: COUNT(CASE WHEN is_corrective_entry = TRUE THEN 1 END)
      comment: "Corrective status entries; data-quality and rework indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Study-level metrics focusing on volume, critical findings, and radiation exposure."
  source: "`vibe_healthcare_v1`.`radiology`.`radiology_study`"
  dimensions:
    - name: "modality_id"
      expr: modality_id
      comment: "Identifier of the imaging modality used."
    - name: "body_part_examined"
      expr: body_part_examined
      comment: "Body part examined in the study."
    - name: "study_date"
      expr: DATE_TRUNC('day', study_date)
      comment: "Date of the study."
    - name: "critical_finding_flag"
      expr: critical_finding_flag
      comment: "Indicates if the study contains a critical finding."
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where the study was performed."
  measures:
    - name: "total_studies"
      expr: COUNT(1)
      comment: "Total number of radiology studies."
    - name: "critical_finding_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_finding_flag THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percentage of studies with critical findings."
    - name: "avg_ctdi_vol"
      expr: AVG(CAST(radiation_dose_ctdi_vol AS DOUBLE))
      comment: "Average CTDI volume dose per study."
    - name: "total_ctdi_vol"
      expr: SUM(CAST(radiation_dose_ctdi_vol AS DOUBLE))
      comment: "Total CTDI volume dose across studies."
    - name: "avg_study_size_mb"
      expr: AVG(CAST(size_mb AS DOUBLE))
      comment: "Average size of study files in megabytes."
$$;