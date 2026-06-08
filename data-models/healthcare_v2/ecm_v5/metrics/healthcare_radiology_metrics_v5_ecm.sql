-- Metric views for domain: radiology | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`radiology_imaging_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core radiology order metrics tracking volume, turnaround times, completion rates, and operational efficiency for imaging services management."
  source: "`healthcare_ecm_v1`.`radiology`.`imaging_order`"
  dimensions:
    - name: "modality_type"
      expr: modality_type
      comment: "Imaging modality (CT, MRI, X-ray, US, etc.) for volume and utilization analysis"
    - name: "order_status"
      expr: order_status
      comment: "Current order lifecycle status for pipeline and backlog analysis"
    - name: "order_priority"
      expr: order_priority
      comment: "Order urgency level (stat, urgent, routine) for prioritization analysis"
    - name: "body_part"
      expr: body_part
      comment: "Anatomical region being imaged for demand pattern analysis"
    - name: "referring_department"
      expr: referring_department
      comment: "Department originating the order for demand source analysis"
    - name: "contrast_required"
      expr: CAST(contrast_required AS STRING)
      comment: "Whether contrast agent is needed, impacts scheduling and prep time"
    - name: "prior_auth_status"
      expr: prior_auth_status
      comment: "Prior authorization status for revenue cycle and denial analysis"
    - name: "order_source"
      expr: order_source
      comment: "Origin system of the order (CPOE, verbal, fax) for workflow analysis"
    - name: "ordered_month"
      expr: DATE_TRUNC('MONTH', ordered_timestamp)
      comment: "Month of order placement for trend analysis"
    - name: "is_stat_override"
      expr: CAST(is_stat_override AS STRING)
      comment: "Whether stat priority was overridden for appropriateness monitoring"
  measures:
    - name: "total_imaging_orders"
      expr: COUNT(1)
      comment: "Total number of imaging orders placed - baseline volume metric"
    - name: "completed_orders"
      expr: SUM(CASE WHEN order_status = 'Completed' THEN 1 ELSE 0 END)
      comment: "Count of orders that reached completion for throughput tracking"
    - name: "cancelled_orders"
      expr: SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END)
      comment: "Count of cancelled orders for waste and workflow analysis"
    - name: "stat_order_count"
      expr: SUM(CASE WHEN order_priority = 'Stat' THEN 1 ELSE 0 END)
      comment: "Volume of stat-priority orders for resource planning and appropriateness review"
    - name: "orders_with_critical_findings"
      expr: SUM(CASE WHEN critical_finding_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Orders resulting in critical findings for patient safety monitoring"
    - name: "avg_radiation_dose_ctdi"
      expr: AVG(CAST(radiation_dose_ctdi AS DOUBLE))
      comment: "Average CT dose index for radiation safety monitoring and ALARA compliance"
    - name: "avg_radiation_dose_dlp"
      expr: AVG(CAST(radiation_dose_dlp AS DOUBLE))
      comment: "Average dose-length product for cumulative radiation exposure tracking"
    - name: "orders_requiring_prior_auth"
      expr: SUM(CASE WHEN prior_auth_status IS NOT NULL AND prior_auth_status != '' THEN 1 ELSE 0 END)
      comment: "Orders requiring prior authorization for revenue cycle burden analysis"
    - name: "contrast_orders"
      expr: SUM(CASE WHEN contrast_required = TRUE THEN 1 ELSE 0 END)
      comment: "Orders requiring contrast for supply planning and adverse reaction risk monitoring"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`radiology_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiology study execution metrics covering throughput, report turnaround, critical findings, and operational performance for department leadership."
  source: "`healthcare_ecm_v1`.`radiology`.`radiology_study`"
  dimensions:
    - name: "study_status"
      expr: study_status
      comment: "Current study lifecycle status for pipeline monitoring"
    - name: "report_status"
      expr: report_status
      comment: "Report completion status for TAT and backlog analysis"
    - name: "body_part_examined"
      expr: body_part_examined
      comment: "Anatomical region studied for workload distribution analysis"
    - name: "priority"
      expr: priority
      comment: "Study priority level for resource allocation analysis"
    - name: "referring_department"
      expr: referring_department
      comment: "Referring department for demand pattern and relationship management"
    - name: "contrast_administered"
      expr: CAST(contrast_administered AS STRING)
      comment: "Whether contrast was used for protocol and safety analysis"
    - name: "is_external_import"
      expr: CAST(is_external_import AS STRING)
      comment: "Whether study was imported from external facility for network utilization analysis"
    - name: "study_month"
      expr: DATE_TRUNC('MONTH', study_date)
      comment: "Month of study for volume trending"
    - name: "pacs_status"
      expr: pacs_status
      comment: "PACS archive status for storage management"
  measures:
    - name: "total_studies"
      expr: COUNT(1)
      comment: "Total radiology studies performed - primary volume metric for department capacity planning"
    - name: "studies_with_critical_findings"
      expr: SUM(CASE WHEN critical_finding_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Studies with critical findings requiring immediate communication for patient safety compliance"
    - name: "stat_reads_completed"
      expr: SUM(CASE WHEN is_stat_read_completed = TRUE THEN 1 ELSE 0 END)
      comment: "Stat reads completed for emergency department throughput monitoring"
    - name: "avg_radiation_dose_ctdi_vol"
      expr: AVG(CAST(radiation_dose_ctdi_vol AS DOUBLE))
      comment: "Average CTDIvol across studies for dose optimization and DRL comparison"
    - name: "avg_radiation_dose_dlp"
      expr: AVG(CAST(radiation_dose_dlp AS DOUBLE))
      comment: "Average DLP for cumulative dose monitoring and ACR compliance"
    - name: "avg_study_size_mb"
      expr: AVG(CAST(size_mb AS DOUBLE))
      comment: "Average study storage size for PACS capacity planning"
    - name: "external_import_count"
      expr: SUM(CASE WHEN is_external_import = TRUE THEN 1 ELSE 0 END)
      comment: "Externally imported studies for network integration and interoperability tracking"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`radiology_reader_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiologist productivity and turnaround time metrics for workforce management, SLA compliance, and teleradiology performance monitoring."
  source: "`healthcare_ecm_v1`.`radiology`.`reader_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current assignment status for workload pipeline analysis"
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of reading assignment (primary, overread, second opinion) for workload categorization"
    - name: "modality"
      expr: modality
      comment: "Imaging modality for subspecialty workload distribution"
    - name: "body_part"
      expr: body_part
      comment: "Body part for subspecialty demand analysis"
    - name: "priority"
      expr: priority
      comment: "Read priority for SLA tier analysis"
    - name: "is_teleradiology"
      expr: CAST(is_teleradiology AS STRING)
      comment: "Whether read was performed via teleradiology for outsourcing analysis"
    - name: "subspecialty_match"
      expr: CAST(subspecialty_match AS STRING)
      comment: "Whether reader subspecialty matched study type for quality assurance"
    - name: "sla_met"
      expr: CAST(sla_met AS STRING)
      comment: "Whether SLA target was met for performance monitoring"
    - name: "assignment_month"
      expr: DATE_TRUNC('MONTH', assigned_timestamp)
      comment: "Month of assignment for trend analysis"
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total reader assignments for workload volume tracking"
    - name: "sla_met_count"
      expr: SUM(CASE WHEN sla_met = TRUE THEN 1 ELSE 0 END)
      comment: "Assignments meeting SLA targets for contractual compliance and quality reporting"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_met = FALSE THEN 1 ELSE 0 END)
      comment: "Assignments breaching SLA for escalation and staffing intervention triggers"
    - name: "teleradiology_assignments"
      expr: SUM(CASE WHEN is_teleradiology = TRUE THEN 1 ELSE 0 END)
      comment: "Teleradiology volume for outsourcing cost and dependency analysis"
    - name: "critical_finding_count"
      expr: SUM(CASE WHEN critical_finding_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Critical findings identified for communication compliance tracking"
    - name: "avg_rvu_value"
      expr: AVG(CAST(rvu_value AS DOUBLE))
      comment: "Average RVU per assignment for radiologist productivity and compensation analysis"
    - name: "total_rvu_value"
      expr: SUM(CAST(rvu_value AS DOUBLE))
      comment: "Total RVUs generated for department revenue and productivity benchmarking"
    - name: "avg_radiation_dose_dlp"
      expr: AVG(CAST(radiation_dose_dlp AS DOUBLE))
      comment: "Average DLP across assignments for dose monitoring by reader"
    - name: "subspecialty_matched_count"
      expr: SUM(CASE WHEN subspecialty_match = TRUE THEN 1 ELSE 0 END)
      comment: "Assignments with subspecialty match for quality and appropriateness monitoring"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`radiology_critical_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Critical result communication metrics for Joint Commission compliance, patient safety, and closed-loop notification tracking."
  source: "`healthcare_ecm_v1`.`radiology`.`critical_result`"
  dimensions:
    - name: "finding_severity"
      expr: finding_severity
      comment: "Severity classification of critical finding for risk stratification"
    - name: "finding_category"
      expr: finding_category
      comment: "Category of critical finding for pattern analysis"
    - name: "notification_status"
      expr: notification_status
      comment: "Status of provider notification for compliance gap identification"
    - name: "notification_method"
      expr: notification_method
      comment: "Method used to communicate critical result for process optimization"
    - name: "acknowledgment_method"
      expr: acknowledgment_method
      comment: "How acknowledgment was received for closed-loop verification"
    - name: "modality"
      expr: modality
      comment: "Imaging modality producing critical finding for risk profiling"
    - name: "tjc_compliance_status"
      expr: tjc_compliance_status
      comment: "Joint Commission compliance status for accreditation readiness"
    - name: "escalation_flag"
      expr: CAST(escalation_flag AS STRING)
      comment: "Whether escalation was triggered for process failure analysis"
    - name: "finding_month"
      expr: DATE_TRUNC('MONTH', finding_datetime)
      comment: "Month of finding for trend monitoring"
  measures:
    - name: "total_critical_results"
      expr: COUNT(1)
      comment: "Total critical results requiring communication for patient safety volume tracking"
    - name: "acknowledged_results"
      expr: SUM(CASE WHEN acknowledgment_datetime IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Critical results with confirmed acknowledgment for closed-loop compliance"
    - name: "escalated_results"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Results requiring escalation indicating communication failures or delays"
    - name: "read_back_performed_count"
      expr: SUM(CASE WHEN read_back_performed = TRUE THEN 1 ELSE 0 END)
      comment: "Results with read-back verification for Joint Commission NPSG compliance"
    - name: "emtala_applicable_count"
      expr: SUM(CASE WHEN emtala_applicable = TRUE THEN 1 ELSE 0 END)
      comment: "EMTALA-applicable critical results for regulatory compliance monitoring"
    - name: "patient_safety_events"
      expr: SUM(CASE WHEN patient_safety_event_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Critical results linked to patient safety events for harm prevention analysis"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`radiology_dose_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiation dose monitoring metrics for ALARA compliance, diagnostic reference level comparison, and patient safety dose tracking."
  source: "`healthcare_ecm_v1`.`radiology`.`dose_record`"
  dimensions:
    - name: "modality_type"
      expr: modality_type
      comment: "Imaging modality for dose benchmarking by equipment type"
    - name: "body_part_examined"
      expr: body_part_examined
      comment: "Body region for anatomical dose reference level comparison"
    - name: "dose_alert_flag"
      expr: CAST(dose_alert_flag AS STRING)
      comment: "Whether dose exceeded alert threshold for safety intervention tracking"
    - name: "dose_record_status"
      expr: dose_record_status
      comment: "Record status for data quality and completeness monitoring"
    - name: "drl_comparison_result"
      expr: drl_comparison_result
      comment: "Comparison against diagnostic reference levels for optimization opportunities"
    - name: "dose_registry_submission_status"
      expr: dose_registry_submission_status
      comment: "Registry submission status for ACR DIR compliance"
    - name: "contrast_administered"
      expr: CAST(contrast_administered AS STRING)
      comment: "Whether contrast was used for protocol-specific dose analysis"
    - name: "study_month"
      expr: DATE_TRUNC('MONTH', study_date)
      comment: "Month of study for dose trending over time"
  measures:
    - name: "total_dose_records"
      expr: COUNT(1)
      comment: "Total dose records for volume and completeness tracking"
    - name: "avg_effective_dose_msv"
      expr: AVG(CAST(effective_dose_msv AS DOUBLE))
      comment: "Average effective dose in millisieverts for population dose monitoring and ALARA compliance"
    - name: "avg_ctdivol_mgy"
      expr: AVG(CAST(ctdivol_mgy AS DOUBLE))
      comment: "Average CTDIvol for CT dose optimization and DRL comparison"
    - name: "avg_dlp_mgy_cm"
      expr: AVG(CAST(dlp_mgy_cm AS DOUBLE))
      comment: "Average dose-length product for cumulative CT dose monitoring"
    - name: "dose_alerts_triggered"
      expr: SUM(CASE WHEN dose_alert_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of dose alerts triggered for safety threshold review and protocol optimization"
    - name: "physicist_reviews_required"
      expr: SUM(CASE WHEN physicist_review_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Dose records requiring physicist review for high-dose case monitoring"
    - name: "avg_cumulative_dose_msv"
      expr: AVG(CAST(cumulative_dose_msv AS DOUBLE))
      comment: "Average cumulative patient dose for lifetime exposure tracking"
    - name: "avg_fluoroscopy_time_sec"
      expr: AVG(CAST(fluoroscopy_time_sec AS DOUBLE))
      comment: "Average fluoroscopy time for interventional procedure dose optimization"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`radiology_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiology report production metrics covering volume, critical findings communication, and report quality indicators for department performance management."
  source: "`healthcare_ecm_v1`.`radiology`.`report`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Report lifecycle status for backlog and completion analysis"
    - name: "modality_code"
      expr: modality_code
      comment: "Modality of the study reported for workload distribution"
    - name: "body_part"
      expr: body_part
      comment: "Body part for subspecialty workload analysis"
    - name: "stat_priority_flag"
      expr: CAST(stat_priority_flag AS STRING)
      comment: "Whether report was stat priority for emergency TAT monitoring"
    - name: "critical_finding_flag"
      expr: CAST(critical_finding_flag AS STRING)
      comment: "Whether report contains critical finding for safety compliance"
    - name: "critical_finding_communicated_flag"
      expr: CAST(critical_finding_communicated_flag AS STRING)
      comment: "Whether critical finding was communicated for closed-loop compliance"
    - name: "rads_category"
      expr: rads_category
      comment: "Standardized reporting category (BI-RADS, LI-RADS, etc.) for follow-up tracking"
    - name: "laterality"
      expr: laterality
      comment: "Laterality for completeness and accuracy monitoring"
    - name: "report_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month of report creation for production trending"
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total radiology reports produced for department productivity measurement"
    - name: "finalized_reports"
      expr: SUM(CASE WHEN report_status = 'Final' THEN 1 ELSE 0 END)
      comment: "Reports in final status for completion rate tracking"
    - name: "critical_finding_reports"
      expr: SUM(CASE WHEN critical_finding_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Reports with critical findings for patient safety volume monitoring"
    - name: "critical_findings_communicated"
      expr: SUM(CASE WHEN critical_finding_communicated_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Critical findings with confirmed communication for Joint Commission compliance rate"
    - name: "stat_reports"
      expr: SUM(CASE WHEN stat_priority_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Stat priority reports for emergency department service level monitoring"
    - name: "reports_with_follow_up_recommendation"
      expr: SUM(CASE WHEN follow_up_recommendation IS NOT NULL AND follow_up_recommendation != '' THEN 1 ELSE 0 END)
      comment: "Reports recommending follow-up for care gap and lost-to-follow-up tracking"
    - name: "avg_radiation_dose_dlp"
      expr: AVG(CAST(radiation_dose_dlp AS DOUBLE))
      comment: "Average DLP reported for dose documentation completeness"
    - name: "contrast_administered_count"
      expr: SUM(CASE WHEN contrast_administered_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Reports noting contrast administration for safety and supply tracking"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`radiology_teleradiology_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Teleradiology outsourcing metrics for vendor performance, SLA compliance, cost management, and quality reconciliation."
  source: "`healthcare_ecm_v1`.`radiology`.`teleradiology_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Case lifecycle status for pipeline and completion monitoring"
    - name: "modality_code"
      expr: modality_code
      comment: "Imaging modality for outsourcing pattern analysis by study type"
    - name: "priority_level"
      expr: priority_level
      comment: "Case priority for SLA tier analysis"
    - name: "subspecialty_required"
      expr: subspecialty_required
      comment: "Required subspecialty for coverage gap identification"
    - name: "sla_met"
      expr: CAST(sla_met AS STRING)
      comment: "Whether vendor met SLA for contract performance evaluation"
    - name: "transmission_method"
      expr: transmission_method
      comment: "Image transmission method for infrastructure reliability analysis"
    - name: "billing_responsibility"
      expr: billing_responsibility
      comment: "Which party bills for revenue cycle clarity"
    - name: "reconciliation_discrepancy_flag"
      expr: CAST(reconciliation_discrepancy_flag AS STRING)
      comment: "Whether discrepancy exists between preliminary and final reads for quality monitoring"
    - name: "order_routing_reason"
      expr: order_routing_reason
      comment: "Reason for teleradiology routing for staffing gap analysis"
    - name: "case_month"
      expr: DATE_TRUNC('MONTH', study_datetime)
      comment: "Month of study for volume trending"
  measures:
    - name: "total_teleradiology_cases"
      expr: COUNT(1)
      comment: "Total cases sent to teleradiology for outsourcing volume and cost tracking"
    - name: "sla_met_count"
      expr: SUM(CASE WHEN sla_met = TRUE THEN 1 ELSE 0 END)
      comment: "Cases meeting SLA for vendor performance scorecard"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_met = FALSE THEN 1 ELSE 0 END)
      comment: "Cases breaching SLA for vendor penalty and escalation tracking"
    - name: "discrepancy_cases"
      expr: SUM(CASE WHEN reconciliation_discrepancy_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Cases with read discrepancies for quality and patient safety monitoring"
    - name: "critical_finding_cases"
      expr: SUM(CASE WHEN critical_finding_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Teleradiology cases with critical findings for communication compliance tracking"
    - name: "transmission_failures"
      expr: SUM(CASE WHEN transmission_success = FALSE THEN 1 ELSE 0 END)
      comment: "Failed transmissions for infrastructure reliability and vendor connectivity monitoring"
    - name: "professional_component_billed_count"
      expr: SUM(CASE WHEN professional_component_billed = TRUE THEN 1 ELSE 0 END)
      comment: "Cases where professional component was billed for revenue capture analysis"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`radiology_peer_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Peer review quality metrics for radiologist performance evaluation, OPPE/FPPE compliance, and ACR RADPEER program management."
  source: "`healthcare_ecm_v1`.`radiology`.`radiology_peer_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of peer review (random, targeted, focused) for program management"
    - name: "review_status"
      expr: review_status
      comment: "Review completion status for backlog monitoring"
    - name: "review_disposition"
      expr: review_disposition
      comment: "Final disposition of review for quality trending"
    - name: "discrepancy_category"
      expr: discrepancy_category
      comment: "Category of discrepancy found for pattern analysis and education targeting"
    - name: "acr_radpeer_score"
      expr: acr_radpeer_score
      comment: "ACR RADPEER score for standardized quality benchmarking"
    - name: "modality_code"
      expr: modality_code
      comment: "Modality reviewed for subspecialty quality analysis"
    - name: "subspecialty"
      expr: subspecialty
      comment: "Subspecialty area for targeted quality improvement"
    - name: "oppe_fppe_flag"
      expr: CAST(oppe_fppe_flag AS STRING)
      comment: "Whether review is part of OPPE/FPPE for credentialing compliance"
    - name: "review_month"
      expr: DATE_TRUNC('MONTH', review_datetime)
      comment: "Month of review for program compliance trending"
  measures:
    - name: "total_peer_reviews"
      expr: COUNT(1)
      comment: "Total peer reviews conducted for program volume and compliance tracking"
    - name: "reviews_with_discrepancy"
      expr: SUM(CASE WHEN discrepancy_category IS NOT NULL AND discrepancy_category != '' THEN 1 ELSE 0 END)
      comment: "Reviews identifying discrepancies for quality improvement targeting"
    - name: "patient_safety_events_identified"
      expr: SUM(CASE WHEN patient_safety_event_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Reviews identifying patient safety events for harm prevention"
    - name: "escalated_to_chair"
      expr: SUM(CASE WHEN escalated_to_chair_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Reviews escalated to department chair for serious quality concerns"
    - name: "oppe_fppe_reviews"
      expr: SUM(CASE WHEN oppe_fppe_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Reviews conducted for OPPE/FPPE credentialing compliance"
    - name: "blinded_reviews"
      expr: SUM(CASE WHEN blinded_review_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Blinded reviews for unbiased quality assessment"
    - name: "educational_feedback_given"
      expr: SUM(CASE WHEN educational_feedback_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Reviews resulting in educational feedback for continuous improvement culture"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`radiology_follow_up`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiology follow-up recommendation tracking metrics for care gap closure, lost-to-follow-up prevention, and population health management."
  source: "`healthcare_ecm_v1`.`radiology`.`follow_up`"
  dimensions:
    - name: "recommendation_status"
      expr: recommendation_status
      comment: "Current status of follow-up recommendation for pipeline management"
    - name: "recommendation_type"
      expr: recommendation_type
      comment: "Type of follow-up recommended for resource planning"
    - name: "recommended_modality"
      expr: recommended_modality
      comment: "Modality recommended for follow-up for scheduling and capacity planning"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority of follow-up for risk-based outreach"
    - name: "finding_category_code"
      expr: finding_category_code
      comment: "Category of finding driving follow-up for clinical pattern analysis"
    - name: "care_gap_flag"
      expr: CAST(care_gap_flag AS STRING)
      comment: "Whether this represents a quality care gap for value-based program compliance"
    - name: "escalation_flag"
      expr: CAST(escalation_flag AS STRING)
      comment: "Whether follow-up was escalated for overdue tracking"
    - name: "patient_notification_status"
      expr: patient_notification_status
      comment: "Patient notification status for outreach effectiveness"
    - name: "recommendation_month"
      expr: DATE_TRUNC('MONTH', recommendation_date)
      comment: "Month of recommendation for trend analysis"
  measures:
    - name: "total_follow_up_recommendations"
      expr: COUNT(1)
      comment: "Total follow-up recommendations for workload and compliance volume tracking"
    - name: "completed_follow_ups"
      expr: SUM(CASE WHEN recommendation_status = 'Completed' THEN 1 ELSE 0 END)
      comment: "Follow-ups completed for closure rate calculation"
    - name: "overdue_follow_ups"
      expr: SUM(CASE WHEN recommendation_status NOT IN ('Completed', 'Declined') AND recommended_due_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Overdue follow-ups for lost-to-follow-up risk identification and patient safety"
    - name: "care_gap_follow_ups"
      expr: SUM(CASE WHEN care_gap_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Follow-ups flagged as quality care gaps for value-based program reporting"
    - name: "escalated_follow_ups"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Escalated follow-ups for process failure and patient safety intervention"
    - name: "declined_follow_ups"
      expr: SUM(CASE WHEN recommendation_status = 'Declined' THEN 1 ELSE 0 END)
      comment: "Patient-declined follow-ups for shared decision-making documentation"
    - name: "cms_quality_measure_count"
      expr: SUM(CASE WHEN cms_quality_measure_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Follow-ups linked to CMS quality measures for regulatory reporting"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`radiology_modality`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Imaging equipment fleet metrics for asset utilization, maintenance compliance, accreditation readiness, and capital planning."
  source: "`healthcare_ecm_v1`.`radiology`.`modality`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current equipment operational status for availability monitoring"
    - name: "dicom_modality_code"
      expr: dicom_modality_code
      comment: "DICOM modality type for fleet composition analysis"
    - name: "manufacturer"
      expr: manufacturer
      comment: "Equipment manufacturer for vendor management and standardization"
    - name: "acr_accreditation_status"
      expr: acr_accreditation_status
      comment: "ACR accreditation status for compliance and payer requirement tracking"
    - name: "is_mobile"
      expr: CAST(is_mobile AS STRING)
      comment: "Whether unit is mobile for deployment flexibility analysis"
    - name: "radiation_emitting"
      expr: CAST(radiation_emitting AS STRING)
      comment: "Whether modality emits radiation for safety program scope"
    - name: "dose_tracking_enabled"
      expr: CAST(dose_tracking_enabled AS STRING)
      comment: "Whether dose tracking is active for compliance gap identification"
    - name: "department_name"
      expr: department_name
      comment: "Department housing the modality for resource allocation"
  measures:
    - name: "total_modalities"
      expr: COUNT(1)
      comment: "Total imaging equipment units for fleet size and capital planning"
    - name: "operational_units"
      expr: SUM(CASE WHEN operational_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Currently operational units for availability rate calculation"
    - name: "units_needing_calibration"
      expr: SUM(CASE WHEN next_calibration_due_date <= CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Units with overdue calibration for maintenance compliance and patient safety"
    - name: "units_needing_pm"
      expr: SUM(CASE WHEN next_preventive_maintenance_date <= CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Units with overdue preventive maintenance for uptime risk management"
    - name: "acr_accredited_units"
      expr: SUM(CASE WHEN acr_accreditation_status = 'Accredited' THEN 1 ELSE 0 END)
      comment: "ACR-accredited units for payer requirement and quality compliance"
    - name: "avg_scheduled_hours_per_day"
      expr: AVG(CAST(scheduled_hours_per_day AS DOUBLE))
      comment: "Average scheduled operating hours for utilization benchmarking"
    - name: "radiation_emitting_units"
      expr: SUM(CASE WHEN radiation_emitting = TRUE THEN 1 ELSE 0 END)
      comment: "Radiation-emitting units for safety program scope and regulatory compliance"
    - name: "contrast_capable_units"
      expr: SUM(CASE WHEN contrast_capable = TRUE THEN 1 ELSE 0 END)
      comment: "Units capable of contrast studies for scheduling and capacity planning"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`radiology_interventional_procedure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interventional radiology procedure metrics for volume tracking, complication rates, radiation safety, and clinical outcomes."
  source: "`healthcare_ecm_v1`.`radiology`.`interventional_procedure`"
  dimensions:
    - name: "procedure_category"
      expr: procedure_category
      comment: "Category of interventional procedure for volume and outcome analysis"
    - name: "procedure_status"
      expr: procedure_status
      comment: "Procedure completion status for throughput monitoring"
    - name: "imaging_guidance_modality"
      expr: imaging_guidance_modality
      comment: "Guidance modality used for resource utilization analysis"
    - name: "body_region"
      expr: body_region
      comment: "Body region for subspecialty workload distribution"
    - name: "anesthesia_type"
      expr: anesthesia_type
      comment: "Anesthesia type for resource planning and scheduling"
    - name: "complication_occurred"
      expr: CAST(complication_occurred AS STRING)
      comment: "Whether complication occurred for safety and quality monitoring"
    - name: "complication_severity"
      expr: complication_severity
      comment: "Severity of complication for risk stratification"
    - name: "technical_success"
      expr: CAST(technical_success AS STRING)
      comment: "Whether procedure was technically successful for outcomes reporting"
    - name: "procedure_month"
      expr: DATE_TRUNC('MONTH', procedure_start_timestamp)
      comment: "Month of procedure for volume trending"
  measures:
    - name: "total_procedures"
      expr: COUNT(1)
      comment: "Total interventional procedures for volume and capacity planning"
    - name: "completed_procedures"
      expr: SUM(CASE WHEN procedure_status = 'Completed' THEN 1 ELSE 0 END)
      comment: "Successfully completed procedures for throughput measurement"
    - name: "procedures_with_complications"
      expr: SUM(CASE WHEN complication_occurred = TRUE THEN 1 ELSE 0 END)
      comment: "Procedures with complications for safety monitoring and quality improvement"
    - name: "technically_successful"
      expr: SUM(CASE WHEN technical_success = TRUE THEN 1 ELSE 0 END)
      comment: "Technically successful procedures for outcomes benchmarking"
    - name: "specimens_collected"
      expr: SUM(CASE WHEN specimen_collected = TRUE THEN 1 ELSE 0 END)
      comment: "Procedures with specimen collection for pathology coordination"
    - name: "avg_fluoroscopy_time_minutes"
      expr: AVG(CAST(fluoroscopy_time_minutes AS DOUBLE))
      comment: "Average fluoroscopy time for radiation dose optimization"
    - name: "avg_contrast_volume_ml"
      expr: AVG(CAST(contrast_volume_ml AS DOUBLE))
      comment: "Average contrast volume for nephrotoxicity risk monitoring"
    - name: "avg_radiation_dose_dap"
      expr: AVG(CAST(radiation_dose_dap_gycm2 AS DOUBLE))
      comment: "Average dose-area product for interventional dose benchmarking"
    - name: "cancelled_procedures"
      expr: SUM(CASE WHEN procedure_status = 'Cancelled' THEN 1 ELSE 0 END)
      comment: "Cancelled procedures for scheduling efficiency and root cause analysis"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`radiology_contrast_admin`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contrast administration safety metrics for adverse reaction monitoring, extravasation tracking, and patient safety compliance."
  source: "`healthcare_ecm_v1`.`radiology`.`contrast_admin`"
  dimensions:
    - name: "administration_status"
      expr: administration_status
      comment: "Status of contrast administration for completion tracking"
    - name: "agent_class"
      expr: agent_class
      comment: "Contrast agent class for safety profiling by agent type"
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Administration route for protocol compliance monitoring"
    - name: "modality"
      expr: modality
      comment: "Imaging modality for contrast usage pattern analysis"
    - name: "body_region"
      expr: body_region
      comment: "Body region for protocol-specific contrast analysis"
    - name: "adverse_reaction_occurred"
      expr: CAST(adverse_reaction_occurred AS STRING)
      comment: "Whether adverse reaction occurred for safety rate monitoring"
    - name: "adverse_reaction_severity"
      expr: adverse_reaction_severity
      comment: "Severity of adverse reaction for risk stratification"
    - name: "extravasation_occurred"
      expr: CAST(extravasation_occurred AS STRING)
      comment: "Whether extravasation occurred for technique quality monitoring"
    - name: "pregnancy_status"
      expr: pregnancy_status
      comment: "Patient pregnancy status for safety protocol compliance"
    - name: "admin_month"
      expr: DATE_TRUNC('MONTH', administration_datetime)
      comment: "Month of administration for trend analysis"
  measures:
    - name: "total_contrast_administrations"
      expr: COUNT(1)
      comment: "Total contrast administrations for volume and supply planning"
    - name: "adverse_reactions"
      expr: SUM(CASE WHEN adverse_reaction_occurred = TRUE THEN 1 ELSE 0 END)
      comment: "Adverse reactions for patient safety rate monitoring and quality improvement"
    - name: "extravasation_events"
      expr: SUM(CASE WHEN extravasation_occurred = TRUE THEN 1 ELSE 0 END)
      comment: "Extravasation events for technique quality and training needs assessment"
    - name: "premedication_given_count"
      expr: SUM(CASE WHEN premedication_given = TRUE THEN 1 ELSE 0 END)
      comment: "Administrations with premedication for allergy protocol compliance"
    - name: "avg_dose_volume_ml"
      expr: AVG(CAST(dose_volume_ml AS DOUBLE))
      comment: "Average contrast volume for protocol adherence and cost management"
    - name: "avg_injection_rate"
      expr: AVG(CAST(injection_rate_ml_per_sec AS DOUBLE))
      comment: "Average injection rate for protocol standardization"
    - name: "power_injector_used_count"
      expr: SUM(CASE WHEN power_injector_used = TRUE THEN 1 ELSE 0 END)
      comment: "Power injector usage for equipment utilization and safety tracking"
    - name: "consent_obtained_count"
      expr: SUM(CASE WHEN informed_consent_obtained = TRUE THEN 1 ELSE 0 END)
      comment: "Administrations with documented informed consent for compliance monitoring"
$$;