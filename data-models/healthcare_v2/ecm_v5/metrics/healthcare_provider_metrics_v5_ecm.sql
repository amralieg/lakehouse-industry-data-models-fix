-- Metric views for domain: provider | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`provider_clinician`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core clinician workforce metrics tracking credentialing status, employment, and provider readiness for patient care delivery."
  source: "`healthcare_ecm_v1`.`provider`.`clinician`"
  dimensions:
    - name: "clinician_type"
      expr: clinician_type
      comment: "Type of clinician (MD, DO, NP, PA, etc.) for workforce composition analysis"
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status for active workforce tracking"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment arrangement (full-time, part-time, locum) for workforce planning"
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Current credentialing status for compliance monitoring"
    - name: "payer_enrollment_status"
      expr: payer_enrollment_status
      comment: "Payer enrollment status for revenue readiness assessment"
    - name: "gender"
      expr: gender
      comment: "Clinician gender for diversity and equity reporting"
    - name: "license_state"
      expr: license_state
      comment: "State of licensure for geographic coverage analysis"
    - name: "board_certified"
      expr: board_certified
      comment: "Board certification status for quality credentialing metrics"
    - name: "medicare_enrolled"
      expr: medicare_enrolled
      comment: "Medicare enrollment flag for government payer readiness"
    - name: "medicaid_enrolled"
      expr: medicaid_enrolled
      comment: "Medicaid enrollment flag for government payer readiness"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year of hire for tenure and recruitment trend analysis"
  measures:
    - name: "total_clinicians"
      expr: COUNT(1)
      comment: "Total count of clinician records for workforce sizing"
    - name: "board_certified_count"
      expr: COUNT(CASE WHEN board_certified = TRUE THEN 1 END)
      comment: "Number of board-certified clinicians for quality compliance"
    - name: "board_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN board_certified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of clinicians who are board certified - key quality indicator"
    - name: "credentialing_expired_count"
      expr: COUNT(CASE WHEN credentialing_expiration_date < CURRENT_DATE() THEN 1 END)
      comment: "Clinicians with expired credentialing requiring immediate action"
    - name: "license_expiring_90_days"
      expr: COUNT(CASE WHEN license_expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Clinicians with licenses expiring within 90 days for proactive renewal management"
    - name: "malpractice_expiring_30_days"
      expr: COUNT(CASE WHEN malpractice_expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 30) THEN 1 END)
      comment: "Clinicians with malpractice coverage expiring within 30 days - critical risk metric"
    - name: "oig_exclusion_not_checked_count"
      expr: COUNT(CASE WHEN oig_exclusion_checked = FALSE OR oig_exclusion_checked IS NULL THEN 1 END)
      comment: "Clinicians without OIG exclusion verification - compliance risk indicator"
    - name: "medicare_enrolled_count"
      expr: COUNT(CASE WHEN medicare_enrolled = TRUE THEN 1 END)
      comment: "Clinicians enrolled in Medicare for government payer capacity planning"
    - name: "avg_days_since_oig_check"
      expr: AVG(CAST(DATEDIFF(CURRENT_DATE(), oig_exclusion_check_date) AS DOUBLE))
      comment: "Average days since last OIG exclusion check for compliance monitoring cadence"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`provider_credentialing_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credentialing application pipeline metrics tracking throughput, cycle times, and compliance verification status for medical staff office operations."
  source: "`healthcare_ecm_v1`.`provider`.`credentialing_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current application status for pipeline stage analysis"
    - name: "application_type"
      expr: application_type
      comment: "Type of credentialing application (initial, reappointment, payer) for workload segmentation"
    - name: "decision_type"
      expr: decision_type
      comment: "Committee decision outcome for approval rate tracking"
    - name: "medical_staff_category"
      expr: medical_staff_category
      comment: "Medical staff category for privilege-level analysis"
    - name: "board_certification_status"
      expr: board_certification_status
      comment: "Board certification verification status within application"
    - name: "npdb_response_status"
      expr: npdb_response_status
      comment: "NPDB query response status for background check compliance"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year of submission for trend analysis"
    - name: "provisional_privileges_flag"
      expr: provisional_privileges_flag
      comment: "Whether provisional privileges were granted during processing"
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total credentialing applications for workload and capacity planning"
    - name: "pending_applications"
      expr: COUNT(CASE WHEN application_status = 'Pending' OR application_status = 'In Review' THEN 1 END)
      comment: "Applications currently in pipeline requiring processing"
    - name: "approved_applications"
      expr: COUNT(CASE WHEN decision_type = 'Approved' THEN 1 END)
      comment: "Applications approved for approval rate calculation"
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN decision_type = 'Approved' THEN 1 END) / NULLIF(COUNT(CASE WHEN decision_type IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of decided applications that were approved - quality of applicant pool indicator"
    - name: "avg_processing_days"
      expr: AVG(CAST(DATEDIFF(decision_date, received_date) AS DOUBLE))
      comment: "Average days from receipt to decision - key operational efficiency metric for medical staff office"
    - name: "npdb_adverse_action_count"
      expr: COUNT(CASE WHEN npdb_adverse_action_flag = TRUE THEN 1 END)
      comment: "Applications with NPDB adverse actions found - risk indicator"
    - name: "peer_references_incomplete_count"
      expr: COUNT(CASE WHEN peer_references_complete_flag = FALSE OR peer_references_complete_flag IS NULL THEN 1 END)
      comment: "Applications with incomplete peer references blocking committee review"
    - name: "provisional_privileges_count"
      expr: COUNT(CASE WHEN provisional_privileges_flag = TRUE THEN 1 END)
      comment: "Applications granted provisional privileges - tracks temporary privilege exposure"
    - name: "avg_malpractice_per_occurrence_limit"
      expr: AVG(CAST(malpractice_per_occurrence_limit AS DOUBLE))
      comment: "Average malpractice coverage per occurrence across applicants for risk assessment"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`provider_privileging`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical privilege management metrics tracking privilege status, compliance with FPPE/OPPE requirements, and privilege utilization for patient safety governance."
  source: "`healthcare_ecm_v1`.`provider`.`privileging`"
  dimensions:
    - name: "privilege_status"
      expr: privilege_status
      comment: "Current privilege status for active/suspended/revoked analysis"
    - name: "privilege_type"
      expr: privilege_type
      comment: "Type of privilege (clinical, surgical, procedural) for category analysis"
    - name: "privilege_category"
      expr: privilege_category
      comment: "Privilege category for departmental grouping"
    - name: "is_provisional"
      expr: is_provisional
      comment: "Whether privilege is provisional for new practitioner tracking"
    - name: "telemedicine_authorized"
      expr: telemedicine_authorized
      comment: "Telemedicine authorization status for virtual care capacity"
    - name: "fppe_required"
      expr: fppe_required
      comment: "Whether focused professional practice evaluation is required"
    - name: "emtala_covered"
      expr: emtala_covered
      comment: "Whether privilege includes EMTALA coverage obligations"
  measures:
    - name: "total_privileges"
      expr: COUNT(1)
      comment: "Total privilege records for scope of practice inventory"
    - name: "active_privileges"
      expr: COUNT(CASE WHEN privilege_status = 'Active' THEN 1 END)
      comment: "Currently active privileges for capacity assessment"
    - name: "suspended_privileges"
      expr: COUNT(CASE WHEN privilege_status = 'Suspended' THEN 1 END)
      comment: "Suspended privileges requiring investigation or remediation"
    - name: "expired_privileges"
      expr: COUNT(CASE WHEN expiration_date < CURRENT_DATE() THEN 1 END)
      comment: "Privileges past expiration requiring immediate reappointment action"
    - name: "expiring_60_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 60) THEN 1 END)
      comment: "Privileges expiring within 60 days for proactive renewal management"
    - name: "fppe_pending_count"
      expr: COUNT(CASE WHEN fppe_required = TRUE AND fppe_completion_date IS NULL THEN 1 END)
      comment: "Privileges with incomplete FPPE - Joint Commission compliance risk"
    - name: "provisional_privilege_count"
      expr: COUNT(CASE WHEN is_provisional = TRUE THEN 1 END)
      comment: "Provisional privileges requiring monitoring and conversion to full privileges"
    - name: "avg_peer_review_score"
      expr: AVG(CAST(peer_review_score AS DOUBLE))
      comment: "Average peer review score across privileges for quality benchmarking"
    - name: "telemedicine_authorized_count"
      expr: COUNT(CASE WHEN telemedicine_authorized = TRUE THEN 1 END)
      comment: "Privileges with telemedicine authorization for virtual care capacity planning"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`provider_reappointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical staff reappointment cycle metrics tracking compliance with reappointment timelines, quality indicators, and CME requirements for ongoing privilege maintenance."
  source: "`healthcare_ecm_v1`.`provider`.`reappointment`"
  dimensions:
    - name: "reappointment_status"
      expr: reappointment_status
      comment: "Current reappointment status for pipeline tracking"
    - name: "decision"
      expr: decision
      comment: "Reappointment decision outcome for approval rate analysis"
    - name: "medical_staff_category"
      expr: medical_staff_category
      comment: "Medical staff category for segmented compliance reporting"
    - name: "cme_compliance_status"
      expr: cme_compliance_status
      comment: "CME compliance status for education requirement tracking"
    - name: "oppe_performance_rating"
      expr: oppe_performance_rating
      comment: "OPPE performance rating for quality-based reappointment decisions"
  measures:
    - name: "total_reappointments"
      expr: COUNT(1)
      comment: "Total reappointment cycles for workload planning"
    - name: "approved_reappointments"
      expr: COUNT(CASE WHEN decision = 'Approved' THEN 1 END)
      comment: "Reappointments approved for retention rate analysis"
    - name: "reappointment_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN decision = 'Approved' THEN 1 END) / NULLIF(COUNT(CASE WHEN decision IS NOT NULL THEN 1 END), 0), 2)
      comment: "Reappointment approval rate - indicator of ongoing provider quality"
    - name: "cme_non_compliant_count"
      expr: COUNT(CASE WHEN cme_compliance_status != 'Compliant' AND cme_compliance_status IS NOT NULL THEN 1 END)
      comment: "Reappointments with CME non-compliance requiring remediation"
    - name: "npdb_adverse_finding_count"
      expr: COUNT(CASE WHEN npdb_adverse_finding = TRUE THEN 1 END)
      comment: "Reappointments with NPDB adverse findings requiring committee review"
    - name: "avg_cme_hours_completed"
      expr: AVG(CAST(cme_hours_completed AS DOUBLE))
      comment: "Average CME hours completed per reappointment cycle for education benchmarking"
    - name: "cme_hours_deficit"
      expr: SUM(CAST(CASE WHEN cme_hours_required > cme_hours_completed THEN cme_hours_required - cme_hours_completed ELSE 0 END AS DOUBLE))
      comment: "Total CME hours deficit across all reappointments for education gap analysis"
    - name: "due_process_initiated_count"
      expr: COUNT(CASE WHEN due_process_initiated = TRUE THEN 1 END)
      comment: "Reappointments where due process was initiated - serious quality/conduct concern indicator"
    - name: "quality_indicator_met_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_indicator_met = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reappointments meeting quality indicators for performance benchmarking"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`provider_payer_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider payer enrollment metrics tracking enrollment status, credentialing tiers, and revenue readiness across payer relationships."
  source: "`healthcare_ecm_v1`.`provider`.`provider_payer_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status for payer access tracking"
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment (individual, group, facility) for segmentation"
    - name: "payer_type"
      expr: payer_type
      comment: "Payer type (commercial, Medicare, Medicaid, managed care) for payer mix analysis"
    - name: "network_status"
      expr: network_status
      comment: "Network participation status for in-network/out-of-network analysis"
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status with payer for enrollment readiness"
    - name: "credentialing_tier"
      expr: credentialing_tier
      comment: "Credentialing tier level for tiered network analysis"
    - name: "provider_type"
      expr: provider_type
      comment: "Provider type classification for enrollment segmentation"
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total payer enrollment records for network coverage assessment"
    - name: "active_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'Active' THEN 1 END)
      comment: "Currently active payer enrollments for revenue capacity"
    - name: "pending_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'Pending' THEN 1 END)
      comment: "Pending enrollments representing potential revenue not yet accessible"
    - name: "terminated_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'Terminated' THEN 1 END)
      comment: "Terminated enrollments for network attrition tracking"
    - name: "revalidation_overdue_count"
      expr: COUNT(CASE WHEN revalidation_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Enrollments past revalidation due date - risk of involuntary termination"
    - name: "revalidation_due_90_days"
      expr: COUNT(CASE WHEN revalidation_due_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Enrollments requiring revalidation within 90 days for proactive management"
    - name: "avg_days_to_approval"
      expr: AVG(CAST(DATEDIFF(approval_date, application_submitted_date) AS DOUBLE))
      comment: "Average days from application to approval - payer enrollment cycle time"
    - name: "distinct_payer_count"
      expr: COUNT(DISTINCT payer_id)
      comment: "Number of distinct payers enrolled with for network breadth assessment"
    - name: "credentialing_expired_count"
      expr: COUNT(CASE WHEN credentialing_expiration_date < CURRENT_DATE() THEN 1 END)
      comment: "Enrollments with expired credentialing - immediate revenue risk"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`provider_sanction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider sanction and exclusion monitoring metrics for compliance risk management, NPDB reporting, and payer enrollment impact assessment."
  source: "`healthcare_ecm_v1`.`provider`.`provider_sanction`"
  dimensions:
    - name: "provider_sanction_type"
      expr: provider_sanction_type
      comment: "Type of sanction for categorization and severity analysis"
    - name: "provider_sanction_status"
      expr: provider_sanction_status
      comment: "Current sanction status for active risk tracking"
    - name: "issuing_authority_type"
      expr: issuing_authority_type
      comment: "Type of issuing authority (state board, federal, payer) for source analysis"
    - name: "exclusion_type_code"
      expr: exclusion_type_code
      comment: "OIG exclusion type code for federal program risk classification"
    - name: "federal_program_exclusion"
      expr: federal_program_exclusion
      comment: "Whether sanction involves federal program exclusion - highest severity"
    - name: "internal_review_status"
      expr: internal_review_status
      comment: "Internal review status for remediation tracking"
  measures:
    - name: "total_sanctions"
      expr: COUNT(1)
      comment: "Total sanction records for compliance risk inventory"
    - name: "active_sanctions"
      expr: COUNT(CASE WHEN provider_sanction_status = 'Active' THEN 1 END)
      comment: "Currently active sanctions requiring ongoing monitoring and restriction"
    - name: "federal_exclusion_count"
      expr: COUNT(CASE WHEN federal_program_exclusion = TRUE THEN 1 END)
      comment: "Federal program exclusions - most severe compliance risk requiring immediate action"
    - name: "medicare_exclusion_count"
      expr: COUNT(CASE WHEN medicare_exclusion = TRUE THEN 1 END)
      comment: "Medicare exclusions impacting government payer revenue"
    - name: "privilege_suspension_count"
      expr: COUNT(CASE WHEN privilege_suspension = TRUE THEN 1 END)
      comment: "Sanctions resulting in privilege suspension - direct patient care impact"
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amounts for financial exposure quantification"
    - name: "total_civil_monetary_penalties"
      expr: SUM(CAST(civil_monetary_penalty_amount AS DOUBLE))
      comment: "Total civil monetary penalties for regulatory cost tracking"
    - name: "npdb_reported_count"
      expr: COUNT(CASE WHEN reported_to_npdb = TRUE THEN 1 END)
      comment: "Sanctions reported to NPDB for national reporting compliance"
    - name: "corporate_integrity_agreement_count"
      expr: COUNT(CASE WHEN corporate_integrity_agreement = TRUE THEN 1 END)
      comment: "Sanctions with corporate integrity agreements - long-term compliance obligation indicator"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`provider_malpractice_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Malpractice insurance coverage metrics tracking coverage adequacy, lapse risk, and financial exposure for risk management."
  source: "`healthcare_ecm_v1`.`provider`.`malpractice_coverage`"
  dimensions:
    - name: "coverage_status"
      expr: coverage_status
      comment: "Current coverage status for active/expired/pending analysis"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of malpractice coverage (occurrence, claims-made) for risk profile"
    - name: "coverage_specialty"
      expr: coverage_specialty
      comment: "Specialty covered for specialty-specific risk analysis"
    - name: "coverage_state"
      expr: coverage_state
      comment: "State of coverage for geographic risk management"
    - name: "self_insured_indicator"
      expr: self_insured_indicator
      comment: "Whether provider is self-insured for financial risk classification"
    - name: "tail_coverage_indicator"
      expr: tail_coverage_indicator
      comment: "Whether tail coverage exists for claims-made policy gap protection"
  measures:
    - name: "total_coverage_records"
      expr: COUNT(1)
      comment: "Total malpractice coverage records for inventory management"
    - name: "active_coverage_count"
      expr: COUNT(CASE WHEN coverage_status = 'Active' THEN 1 END)
      comment: "Currently active malpractice policies for coverage verification"
    - name: "coverage_lapse_count"
      expr: COUNT(CASE WHEN coverage_lapse_indicator = TRUE THEN 1 END)
      comment: "Policies with coverage lapses - critical credentialing and patient safety risk"
    - name: "expiring_30_days_count"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 30) THEN 1 END)
      comment: "Policies expiring within 30 days requiring immediate renewal action"
    - name: "avg_per_occurrence_limit"
      expr: AVG(CAST(per_occurrence_limit AS DOUBLE))
      comment: "Average per-occurrence coverage limit for adequacy benchmarking"
    - name: "avg_aggregate_limit"
      expr: AVG(CAST(aggregate_limit AS DOUBLE))
      comment: "Average aggregate coverage limit for total exposure assessment"
    - name: "total_aggregate_coverage"
      expr: SUM(CAST(aggregate_limit AS DOUBLE))
      comment: "Total aggregate malpractice coverage across all policies for enterprise risk quantification"
    - name: "claims_history_flagged_count"
      expr: COUNT(CASE WHEN claims_history_indicator = TRUE THEN 1 END)
      comment: "Policies with claims history - risk indicator for credentialing review"
    - name: "tail_coverage_missing_count"
      expr: COUNT(CASE WHEN coverage_type = 'Claims-Made' AND (tail_coverage_indicator = FALSE OR tail_coverage_indicator IS NULL) THEN 1 END)
      comment: "Claims-made policies without tail coverage - gap exposure risk"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`provider_cme_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Continuing medical education activity metrics tracking credit accumulation, compliance with licensure and board certification requirements, and education investment."
  source: "`healthcare_ecm_v1`.`provider`.`cme_activity`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of CME activity for education modality analysis"
    - name: "cme_category"
      expr: cme_category
      comment: "CME credit category (Category 1, Category 2) for requirement tracking"
    - name: "activity_status"
      expr: activity_status
      comment: "Activity completion status for pipeline tracking"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Delivery method (live, online, self-study) for education format analysis"
    - name: "mandatory_topic_type"
      expr: mandatory_topic_type
      comment: "Mandatory topic type for regulatory requirement tracking"
    - name: "accreditation_standard"
      expr: accreditation_standard
      comment: "Accreditation standard met for compliance mapping"
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year of completion for annual tracking and trending"
  measures:
    - name: "total_activities"
      expr: COUNT(1)
      comment: "Total CME activities for education volume tracking"
    - name: "total_credit_hours"
      expr: SUM(CAST(credit_hours AS DOUBLE))
      comment: "Total CME credit hours earned for compliance requirement fulfillment"
    - name: "avg_credit_hours_per_activity"
      expr: AVG(CAST(credit_hours AS DOUBLE))
      comment: "Average credit hours per activity for education efficiency assessment"
    - name: "total_moc_points"
      expr: SUM(CAST(moc_points_earned AS DOUBLE))
      comment: "Total Maintenance of Certification points for board recertification tracking"
    - name: "mandatory_topic_completion_count"
      expr: COUNT(CASE WHEN mandatory_topic_flag = TRUE AND activity_status = 'Completed' THEN 1 END)
      comment: "Completed mandatory topic activities for regulatory compliance verification"
    - name: "evaluation_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN evaluation_completed_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN activity_status = 'Completed' THEN 1 END), 0), 2)
      comment: "Percentage of completed activities with evaluations for accreditation compliance"
    - name: "avg_post_test_score"
      expr: AVG(CAST(post_test_score AS DOUBLE))
      comment: "Average post-test score for education effectiveness measurement"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`provider_npdb_query`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "National Practitioner Data Bank query metrics tracking query compliance, adverse findings, and continuous query enrollment for background screening governance."
  source: "`healthcare_ecm_v1`.`provider`.`npdb_query`"
  dimensions:
    - name: "query_status"
      expr: query_status
      comment: "Query processing status for pipeline tracking"
    - name: "query_type"
      expr: query_type
      comment: "Type of NPDB query (initial, reappointment, continuous) for purpose analysis"
    - name: "response_status"
      expr: response_status
      comment: "Response status for turnaround tracking"
    - name: "credentialing_purpose"
      expr: credentialing_purpose
      comment: "Purpose of query for credentialing workflow alignment"
    - name: "continuous_query_enrollment_flag"
      expr: continuous_query_enrollment_flag
      comment: "Whether enrolled in continuous query for proactive monitoring"
    - name: "review_outcome"
      expr: review_outcome
      comment: "Committee review outcome for adverse finding disposition"
  measures:
    - name: "total_queries"
      expr: COUNT(1)
      comment: "Total NPDB queries for compliance volume tracking"
    - name: "adverse_action_found_count"
      expr: COUNT(CASE WHEN adverse_action_flag = TRUE THEN 1 END)
      comment: "Queries returning adverse actions - critical credentialing risk findings"
    - name: "malpractice_payment_found_count"
      expr: COUNT(CASE WHEN malpractice_payment_flag = TRUE THEN 1 END)
      comment: "Queries returning malpractice payments for risk assessment"
    - name: "adverse_finding_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN adverse_action_flag = TRUE OR malpractice_payment_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of queries with any adverse finding for population risk benchmarking"
    - name: "continuous_query_enrolled_count"
      expr: COUNT(CASE WHEN continuous_query_enrollment_flag = TRUE THEN 1 END)
      comment: "Providers enrolled in continuous query for proactive monitoring coverage"
    - name: "review_required_pending_count"
      expr: COUNT(CASE WHEN review_required_flag = TRUE AND review_completed_date IS NULL THEN 1 END)
      comment: "Queries requiring committee review not yet completed - action backlog"
    - name: "avg_response_turnaround_days"
      expr: AVG(CAST(DATEDIFF(response_date, query_date) AS DOUBLE))
      comment: "Average days from query submission to response for process efficiency"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`provider_network_affiliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider network affiliation metrics tracking network participation, panel capacity, and geographic access for network adequacy compliance."
  source: "`healthcare_ecm_v1`.`provider`.`network_affiliation`"
  dimensions:
    - name: "affiliation_status"
      expr: affiliation_status
      comment: "Network affiliation status for active participation tracking"
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier level for tiered benefit analysis"
    - name: "participation_type"
      expr: participation_type
      comment: "Type of network participation (par, non-par) for contracting analysis"
    - name: "network_adequacy_category"
      expr: network_adequacy_category
      comment: "Network adequacy category for regulatory compliance reporting"
    - name: "panel_status"
      expr: panel_status
      comment: "Panel status (open, closed) for patient access tracking"
    - name: "reimbursement_model"
      expr: reimbursement_model
      comment: "Reimbursement model (FFS, capitation, VBC) for payment model analysis"
    - name: "accepts_new_patients"
      expr: accepts_new_patients
      comment: "Whether accepting new patients for access availability"
  measures:
    - name: "total_affiliations"
      expr: COUNT(1)
      comment: "Total network affiliations for network size assessment"
    - name: "active_affiliations"
      expr: COUNT(CASE WHEN affiliation_status = 'Active' THEN 1 END)
      comment: "Currently active network affiliations for network capacity"
    - name: "accepting_new_patients_count"
      expr: COUNT(CASE WHEN accepts_new_patients = TRUE THEN 1 END)
      comment: "Affiliations accepting new patients for access availability reporting"
    - name: "panel_open_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN panel_status = 'Open' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of affiliations with open panels for network access adequacy"
    - name: "telehealth_eligible_count"
      expr: COUNT(CASE WHEN telehealth_eligible = TRUE THEN 1 END)
      comment: "Affiliations with telehealth eligibility for virtual care network capacity"
    - name: "terminated_count"
      expr: COUNT(CASE WHEN affiliation_status = 'Terminated' THEN 1 END)
      comment: "Terminated affiliations for network attrition and stability analysis"
    - name: "distinct_provider_count"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Distinct clinicians in network for unique provider count reporting"
    - name: "credentialing_expired_count"
      expr: COUNT(CASE WHEN credentialing_expiration_date < CURRENT_DATE() THEN 1 END)
      comment: "Affiliations with expired credentialing - network compliance risk"
$$;