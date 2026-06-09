-- Metric views for domain: underwriting | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 03:35:10

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`underwriting_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core underwriting application metrics tracking submission volume, decision outcomes, risk assessment, and premium economics across channels and product lines"
  source: "`life_insurance_ecm`.`underwriting`.`application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the application (e.g., Submitted, In Review, Approved, Declined)"
    - name: "application_type"
      expr: application_type
      comment: "Type of application (e.g., New Business, Conversion, Reinstatement)"
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which application was submitted (e.g., Agent, Direct, Broker)"
    - name: "underwriting_class"
      expr: underwriting_class
      comment: "Final underwriting risk class assigned (e.g., Preferred, Standard, Substandard)"
    - name: "decision_reason"
      expr: decision_reason
      comment: "Primary reason for underwriting decision"
    - name: "premium_mode"
      expr: premium_mode
      comment: "Premium payment frequency (e.g., Annual, Semi-Annual, Quarterly, Monthly)"
    - name: "reinsurance_type"
      expr: reinsurance_type
      comment: "Type of reinsurance arrangement (e.g., Automatic, Facultative, None)"
    - name: "application_year"
      expr: YEAR(application_date)
      comment: "Year of application submission"
    - name: "application_month"
      expr: DATE_TRUNC('MONTH', application_date)
      comment: "Month of application submission"
    - name: "decision_year"
      expr: YEAR(decision_date)
      comment: "Year of underwriting decision"
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month of underwriting decision"
    - name: "nigo_flag"
      expr: nigo_flag
      comment: "Not In Good Order flag indicating incomplete application"
    - name: "replacement_indicator"
      expr: replacement_indicator
      comment: "Indicates if application is replacing existing coverage"
    - name: "exchange_1035_flag"
      expr: exchange_1035_flag
      comment: "Indicates if application involves 1035 tax-free exchange"
    - name: "kyc_status"
      expr: kyc_status
      comment: "Know Your Customer verification status"
    - name: "mib_check_status"
      expr: mib_check_status
      comment: "Medical Information Bureau check status"
  measures:
    - name: "total_applications"
      expr: COUNT(DISTINCT application_id)
      comment: "Total number of unique applications submitted"
    - name: "total_face_amount"
      expr: SUM(CAST(face_amount AS DOUBLE))
      comment: "Total face amount (death benefit) applied for across all applications"
    - name: "avg_face_amount"
      expr: AVG(CAST(face_amount AS DOUBLE))
      comment: "Average face amount per application"
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium amount across all applications"
    - name: "avg_premium_amount"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium amount per application"
    - name: "total_nar_amount"
      expr: SUM(CAST(nar_amount AS DOUBLE))
      comment: "Total Net Amount at Risk (face amount minus reserves) across applications"
    - name: "avg_nar_amount"
      expr: AVG(CAST(nar_amount AS DOUBLE))
      comment: "Average Net Amount at Risk per application"
    - name: "total_flat_extra_amount"
      expr: SUM(CAST(flat_extra_amount AS DOUBLE))
      comment: "Total flat extra premium charges for substandard risks"
    - name: "avg_aml_risk_score"
      expr: AVG(CAST(aml_risk_score AS DOUBLE))
      comment: "Average Anti-Money Laundering risk score across applications"
    - name: "avg_stoli_risk_score"
      expr: AVG(CAST(stoli_risk_score AS DOUBLE))
      comment: "Average Stranger-Originated Life Insurance risk score"
    - name: "nigo_application_count"
      expr: COUNT(DISTINCT CASE WHEN nigo_flag = TRUE THEN application_id END)
      comment: "Count of Not In Good Order applications requiring rework"
    - name: "replacement_application_count"
      expr: COUNT(DISTINCT CASE WHEN replacement_indicator = TRUE THEN application_id END)
      comment: "Count of applications replacing existing coverage"
    - name: "exchange_1035_count"
      expr: COUNT(DISTINCT CASE WHEN exchange_1035_flag = TRUE THEN application_id END)
      comment: "Count of applications involving 1035 tax-free exchanges"
    - name: "medical_exam_required_count"
      expr: COUNT(DISTINCT CASE WHEN medical_exam_required = TRUE THEN application_id END)
      comment: "Count of applications requiring medical examination"
    - name: "aps_required_count"
      expr: COUNT(DISTINCT CASE WHEN aps_required = TRUE THEN application_id END)
      comment: "Count of applications requiring Attending Physician Statement"
    - name: "financial_uw_required_count"
      expr: COUNT(DISTINCT CASE WHEN financial_underwriting_required = TRUE THEN application_id END)
      comment: "Count of applications requiring financial underwriting review"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`underwriting_decision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Underwriting decision metrics tracking approval rates, decline reasons, risk adjustments, and decision cycle time for portfolio risk management"
  source: "`life_insurance_ecm`.`underwriting`.`decision`"
  dimensions:
    - name: "decision_status"
      expr: decision_status
      comment: "Status of the underwriting decision (e.g., Final, Pending, Revised)"
    - name: "decision_type"
      expr: decision_type
      comment: "Type of decision (e.g., Approve, Decline, Counter-Offer, Postpone)"
    - name: "decision_method"
      expr: decision_method
      comment: "Method used for decision (e.g., Automated, Manual, Hybrid)"
    - name: "decline_reason_code"
      expr: decline_reason_code
      comment: "Standardized code for decline reason"
    - name: "risk_class"
      expr: risk_class
      comment: "Final risk class assigned (e.g., Preferred, Standard, Rated)"
    - name: "table_rating"
      expr: table_rating
      comment: "Table rating applied for substandard risks"
    - name: "reinsurance_type"
      expr: reinsurance_type
      comment: "Type of reinsurance required (e.g., Automatic, Facultative)"
    - name: "decision_year"
      expr: YEAR(decision_date)
      comment: "Year of underwriting decision"
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month of underwriting decision"
    - name: "exclusion_rider_applied"
      expr: exclusion_rider_applied
      comment: "Indicates if exclusion rider was applied to policy"
    - name: "reinsurance_required"
      expr: reinsurance_required
      comment: "Indicates if reinsurance is required for this case"
    - name: "supervisory_approval_required"
      expr: supervisory_approval_required
      comment: "Indicates if supervisory approval was required"
    - name: "stoli_indicator"
      expr: stoli_indicator
      comment: "Stranger-Originated Life Insurance risk indicator"
    - name: "kyc_verification_status"
      expr: kyc_verification_status
      comment: "Know Your Customer verification status at decision time"
  measures:
    - name: "total_decisions"
      expr: COUNT(DISTINCT decision_id)
      comment: "Total number of underwriting decisions made"
    - name: "total_approved_face_amount"
      expr: SUM(CAST(approved_face_amount AS DOUBLE))
      comment: "Total approved face amount across all decisions"
    - name: "avg_approved_face_amount"
      expr: AVG(CAST(approved_face_amount AS DOUBLE))
      comment: "Average approved face amount per decision"
    - name: "total_approved_premium"
      expr: SUM(CAST(approved_premium_amount AS DOUBLE))
      comment: "Total approved premium amount across decisions"
    - name: "avg_approved_premium"
      expr: AVG(CAST(approved_premium_amount AS DOUBLE))
      comment: "Average approved premium per decision"
    - name: "total_nar_amount"
      expr: SUM(CAST(nar_amount AS DOUBLE))
      comment: "Total Net Amount at Risk approved across decisions"
    - name: "avg_flat_extra_per_thousand"
      expr: AVG(CAST(flat_extra_per_thousand AS DOUBLE))
      comment: "Average flat extra charge per thousand of coverage for substandard risks"
    - name: "decisions_with_exclusion_rider"
      expr: COUNT(DISTINCT CASE WHEN exclusion_rider_applied = TRUE THEN decision_id END)
      comment: "Count of decisions with exclusion riders applied"
    - name: "decisions_requiring_reinsurance"
      expr: COUNT(DISTINCT CASE WHEN reinsurance_required = TRUE THEN decision_id END)
      comment: "Count of decisions requiring reinsurance placement"
    - name: "decisions_requiring_supervisory_approval"
      expr: COUNT(DISTINCT CASE WHEN supervisory_approval_required = TRUE THEN decision_id END)
      comment: "Count of decisions requiring supervisory approval"
    - name: "stoli_flagged_decisions"
      expr: COUNT(DISTINCT CASE WHEN stoli_indicator = TRUE THEN decision_id END)
      comment: "Count of decisions flagged for STOLI risk"
    - name: "aps_ordered_count"
      expr: COUNT(DISTINCT CASE WHEN aps_ordered = TRUE THEN decision_id END)
      comment: "Count of decisions where Attending Physician Statement was ordered"
    - name: "medical_exam_required_count"
      expr: COUNT(DISTINCT CASE WHEN medical_exam_required = TRUE THEN decision_id END)
      comment: "Count of decisions requiring medical examination"
    - name: "aml_review_completed_count"
      expr: COUNT(DISTINCT CASE WHEN aml_review_completed = TRUE THEN decision_id END)
      comment: "Count of decisions with completed Anti-Money Laundering review"
    - name: "mib_inquiry_completed_count"
      expr: COUNT(DISTINCT CASE WHEN mib_inquiry_completed = TRUE THEN decision_id END)
      comment: "Count of decisions with completed MIB inquiry"
    - name: "financial_uw_completed_count"
      expr: COUNT(DISTINCT CASE WHEN financial_underwriting_completed = TRUE THEN decision_id END)
      comment: "Count of decisions with completed financial underwriting"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`underwriting_evidence_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Evidence requirement metrics tracking medical and financial evidence collection, vendor performance, and evidence review cycle time"
  source: "`life_insurance_ecm`.`underwriting`.`evidence_requirement`"
  dimensions:
    - name: "evidence_type"
      expr: evidence_type
      comment: "Type of evidence required (e.g., APS, Paramedical Exam, Lab Results, Financial Statement)"
    - name: "evidence_status"
      expr: evidence_status
      comment: "Current status of evidence requirement (e.g., Ordered, Received, Reviewed, Waived)"
    - name: "completion_status"
      expr: completion_status
      comment: "Completion status of evidence requirement"
    - name: "review_status"
      expr: review_status
      comment: "Review status of received evidence"
    - name: "ordered_year"
      expr: YEAR(ordered_date)
      comment: "Year evidence was ordered"
    - name: "ordered_month"
      expr: DATE_TRUNC('MONTH', ordered_date)
      comment: "Month evidence was ordered"
    - name: "received_year"
      expr: YEAR(received_date)
      comment: "Year evidence was received"
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Month evidence was received"
    - name: "follow_up_action_required_flag"
      expr: follow_up_action_required_flag
      comment: "Indicates if follow-up action is required on evidence"
    - name: "hipaa_authorization_received_flag"
      expr: hipaa_authorization_received_flag
      comment: "Indicates if HIPAA authorization was received"
    - name: "mib_applicant_consent_flag"
      expr: mib_applicant_consent_flag
      comment: "Indicates if MIB applicant consent was obtained"
    - name: "mib_follow_up_required_flag"
      expr: mib_follow_up_required_flag
      comment: "Indicates if MIB follow-up is required"
  measures:
    - name: "total_evidence_requirements"
      expr: COUNT(DISTINCT evidence_requirement_id)
      comment: "Total number of evidence requirements ordered"
    - name: "total_evidence_cost"
      expr: SUM(CAST(evidence_cost_amount AS DOUBLE))
      comment: "Total cost of evidence acquisition across all requirements"
    - name: "avg_evidence_cost"
      expr: AVG(CAST(evidence_cost_amount AS DOUBLE))
      comment: "Average cost per evidence requirement"
    - name: "avg_relevance_score"
      expr: AVG(CAST(relevance_score AS DOUBLE))
      comment: "Average relevance score of evidence to underwriting decision"
    - name: "avg_height_inches"
      expr: AVG(CAST(height_inches AS DOUBLE))
      comment: "Average height in inches from medical evidence"
    - name: "avg_weight_pounds"
      expr: AVG(CAST(weight_pounds AS DOUBLE))
      comment: "Average weight in pounds from medical evidence"
    - name: "follow_up_required_count"
      expr: COUNT(DISTINCT CASE WHEN follow_up_action_required_flag = TRUE THEN evidence_requirement_id END)
      comment: "Count of evidence requirements needing follow-up action"
    - name: "hipaa_authorization_received_count"
      expr: COUNT(DISTINCT CASE WHEN hipaa_authorization_received_flag = TRUE THEN evidence_requirement_id END)
      comment: "Count of evidence requirements with HIPAA authorization received"
    - name: "mib_consent_obtained_count"
      expr: COUNT(DISTINCT CASE WHEN mib_applicant_consent_flag = TRUE THEN evidence_requirement_id END)
      comment: "Count of evidence requirements with MIB consent obtained"
    - name: "mib_follow_up_required_count"
      expr: COUNT(DISTINCT CASE WHEN mib_follow_up_required_flag = TRUE THEN evidence_requirement_id END)
      comment: "Count of evidence requirements needing MIB follow-up"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`underwriting_case_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Case activity metrics tracking underwriting workflow efficiency, SLA compliance, queue management, and case processing throughput"
  source: "`life_insurance_ecm`.`underwriting`.`case_activity`"
  dimensions:
    - name: "activity_type_code"
      expr: activity_type_code
      comment: "Type of case activity (e.g., Review, Decision, Evidence Order, Escalation)"
    - name: "activity_status"
      expr: activity_status
      comment: "Status of the activity (e.g., Completed, In Progress, Pending)"
    - name: "case_priority_level"
      expr: case_priority_level
      comment: "Priority level of the case (e.g., High, Medium, Low)"
    - name: "queue_name"
      expr: queue_name
      comment: "Name of the underwriting queue handling the case"
    - name: "underwriting_team_name"
      expr: underwriting_team_name
      comment: "Name of the underwriting team assigned to the case"
    - name: "activity_year"
      expr: YEAR(activity_timestamp)
      comment: "Year of case activity"
    - name: "activity_month"
      expr: DATE_TRUNC('MONTH', activity_timestamp)
      comment: "Month of case activity"
    - name: "automated_flag"
      expr: automated_flag
      comment: "Indicates if activity was automated vs manual"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates if activity breached service level agreement"
    - name: "reinsurance_submission_flag"
      expr: reinsurance_submission_flag
      comment: "Indicates if activity involved reinsurance submission"
    - name: "new_status"
      expr: new_status
      comment: "New status after activity completion"
    - name: "previous_status"
      expr: previous_status
      comment: "Previous status before activity"
  measures:
    - name: "total_case_activities"
      expr: COUNT(DISTINCT case_activity_id)
      comment: "Total number of case activities performed"
    - name: "avg_duration_seconds"
      expr: AVG(CAST(duration_seconds AS DOUBLE))
      comment: "Average duration of case activities in seconds"
    - name: "total_duration_hours"
      expr: SUM(CAST(duration_seconds AS DOUBLE)) / 3600.0
      comment: "Total duration of all case activities in hours"
    - name: "automated_activity_count"
      expr: COUNT(DISTINCT CASE WHEN automated_flag = TRUE THEN case_activity_id END)
      comment: "Count of automated case activities"
    - name: "manual_activity_count"
      expr: COUNT(DISTINCT CASE WHEN automated_flag = FALSE THEN case_activity_id END)
      comment: "Count of manual case activities"
    - name: "sla_breach_count"
      expr: COUNT(DISTINCT CASE WHEN sla_breach_flag = TRUE THEN case_activity_id END)
      comment: "Count of activities that breached SLA"
    - name: "reinsurance_submission_count"
      expr: COUNT(DISTINCT CASE WHEN reinsurance_submission_flag = TRUE THEN case_activity_id END)
      comment: "Count of activities involving reinsurance submission"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`underwriting_financial_uw_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial underwriting review metrics tracking insurable interest verification, human life value calculations, STOLI detection, and over-insurance analysis"
  source: "`life_insurance_ecm`.`underwriting`.`financial_uw_review`"
  dimensions:
    - name: "financial_decision"
      expr: financial_decision
      comment: "Financial underwriting decision outcome (e.g., Approved, Declined, Reduced)"
    - name: "review_status"
      expr: review_status
      comment: "Status of financial review (e.g., Completed, In Progress, Pending)"
    - name: "review_type"
      expr: review_type
      comment: "Type of financial review (e.g., Standard, Enhanced, Simplified)"
    - name: "insurable_interest_determination"
      expr: insurable_interest_determination
      comment: "Determination of insurable interest (e.g., Verified, Questionable, Not Established)"
    - name: "stoli_risk_indicator"
      expr: stoli_risk_indicator
      comment: "STOLI risk indicator level (e.g., Low, Medium, High)"
    - name: "kyc_verification_status"
      expr: kyc_verification_status
      comment: "Know Your Customer verification status"
    - name: "review_start_year"
      expr: YEAR(review_start_date)
      comment: "Year financial review started"
    - name: "review_start_month"
      expr: DATE_TRUNC('MONTH', review_start_date)
      comment: "Month financial review started"
    - name: "over_insurance_indicator"
      expr: over_insurance_indicator
      comment: "Indicates if over-insurance was detected"
    - name: "financial_statement_reviewed"
      expr: financial_statement_reviewed
      comment: "Indicates if financial statements were reviewed"
  measures:
    - name: "total_financial_reviews"
      expr: COUNT(DISTINCT financial_uw_review_id)
      comment: "Total number of financial underwriting reviews conducted"
    - name: "total_applied_coverage"
      expr: SUM(CAST(applied_coverage_amount AS DOUBLE))
      comment: "Total coverage amount applied for across all financial reviews"
    - name: "total_approved_coverage"
      expr: SUM(CAST(approved_coverage_amount AS DOUBLE))
      comment: "Total coverage amount approved after financial review"
    - name: "avg_applied_coverage"
      expr: AVG(CAST(applied_coverage_amount AS DOUBLE))
      comment: "Average coverage amount applied for per review"
    - name: "avg_approved_coverage"
      expr: AVG(CAST(approved_coverage_amount AS DOUBLE))
      comment: "Average coverage amount approved per review"
    - name: "avg_annual_income"
      expr: AVG(CAST(annual_income AS DOUBLE))
      comment: "Average annual income of applicants under financial review"
    - name: "avg_net_worth"
      expr: AVG(CAST(net_worth AS DOUBLE))
      comment: "Average net worth of applicants under financial review"
    - name: "avg_liquid_assets"
      expr: AVG(CAST(liquid_assets AS DOUBLE))
      comment: "Average liquid assets of applicants"
    - name: "avg_total_liabilities"
      expr: AVG(CAST(total_liabilities AS DOUBLE))
      comment: "Average total liabilities of applicants"
    - name: "avg_human_life_value"
      expr: AVG(CAST(human_life_value AS DOUBLE))
      comment: "Average calculated human life value"
    - name: "avg_income_replacement_multiple"
      expr: AVG(CAST(income_replacement_multiple AS DOUBLE))
      comment: "Average income replacement multiple used in coverage justification"
    - name: "avg_business_ownership_percentage"
      expr: AVG(CAST(business_ownership_percentage AS DOUBLE))
      comment: "Average business ownership percentage for business insurance cases"
    - name: "avg_business_valuation"
      expr: AVG(CAST(business_valuation_amount AS DOUBLE))
      comment: "Average business valuation for business insurance cases"
    - name: "avg_existing_inforce_amount"
      expr: AVG(CAST(existing_inforce_amount AS DOUBLE))
      comment: "Average existing inforce coverage amount"
    - name: "avg_total_coverage_amount"
      expr: AVG(CAST(total_coverage_amount AS DOUBLE))
      comment: "Average total coverage amount including existing and applied"
    - name: "avg_aml_risk_score"
      expr: AVG(CAST(aml_risk_score AS DOUBLE))
      comment: "Average Anti-Money Laundering risk score"
    - name: "over_insurance_detected_count"
      expr: COUNT(DISTINCT CASE WHEN over_insurance_indicator = TRUE THEN financial_uw_review_id END)
      comment: "Count of reviews where over-insurance was detected"
    - name: "financial_statement_reviewed_count"
      expr: COUNT(DISTINCT CASE WHEN financial_statement_reviewed = TRUE THEN financial_uw_review_id END)
      comment: "Count of reviews where financial statements were reviewed"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`underwriting_reinsurance_placement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reinsurance placement metrics tracking cession amounts, facultative submissions, reinsurer decisions, and retention management"
  source: "`life_insurance_ecm`.`underwriting`.`reinsurance_placement`"
  dimensions:
    - name: "placement_type"
      expr: placement_type
      comment: "Type of reinsurance placement (e.g., Automatic, Facultative)"
    - name: "placement_status"
      expr: placement_status
      comment: "Status of reinsurance placement (e.g., Bound, Pending, Declined)"
    - name: "reinsurer_decision"
      expr: reinsurer_decision
      comment: "Reinsurer's decision on the placement (e.g., Accept, Decline, Counter-Offer)"
    - name: "ceding_risk_class_code"
      expr: ceding_risk_class_code
      comment: "Risk class code from ceding company perspective"
    - name: "reinsurer_risk_class_code"
      expr: reinsurer_risk_class_code
      comment: "Risk class code assigned by reinsurer"
    - name: "reinsurer_table_rating"
      expr: reinsurer_table_rating
      comment: "Table rating assigned by reinsurer"
    - name: "product_line"
      expr: product_line
      comment: "Product line of the reinsured policy"
    - name: "insured_gender"
      expr: insured_gender
      comment: "Gender of the insured"
    - name: "placement_effective_year"
      expr: YEAR(placement_effective_date)
      comment: "Year reinsurance placement became effective"
    - name: "placement_effective_month"
      expr: DATE_TRUNC('MONTH', placement_effective_date)
      comment: "Month reinsurance placement became effective"
    - name: "stoli_indicator"
      expr: stoli_indicator
      comment: "STOLI risk indicator for reinsurance placement"
    - name: "medical_evidence_transmitted"
      expr: medical_evidence_transmitted
      comment: "Indicates if medical evidence was transmitted to reinsurer"
    - name: "financial_evidence_transmitted"
      expr: financial_evidence_transmitted
      comment: "Indicates if financial evidence was transmitted to reinsurer"
  measures:
    - name: "total_reinsurance_placements"
      expr: COUNT(DISTINCT reinsurance_placement_id)
      comment: "Total number of reinsurance placements"
    - name: "total_cession_amount"
      expr: SUM(CAST(cession_amount AS DOUBLE))
      comment: "Total amount ceded to reinsurers"
    - name: "avg_cession_amount"
      expr: AVG(CAST(cession_amount AS DOUBLE))
      comment: "Average cession amount per placement"
    - name: "avg_cession_percentage"
      expr: AVG(CAST(cession_percentage AS DOUBLE))
      comment: "Average percentage of risk ceded"
    - name: "total_nar_amount"
      expr: SUM(CAST(nar_amount AS DOUBLE))
      comment: "Total Net Amount at Risk ceded to reinsurers"
    - name: "avg_retention_limit"
      expr: AVG(CAST(retention_limit_amount AS DOUBLE))
      comment: "Average retention limit before reinsurance"
    - name: "avg_reinsurance_premium_rate"
      expr: AVG(CAST(reinsurance_premium_rate AS DOUBLE))
      comment: "Average reinsurance premium rate"
    - name: "avg_reinsurer_flat_extra_per_thousand"
      expr: AVG(CAST(reinsurer_flat_extra_per_thousand AS DOUBLE))
      comment: "Average flat extra per thousand charged by reinsurer"
    - name: "avg_aml_risk_score"
      expr: AVG(CAST(aml_risk_score AS DOUBLE))
      comment: "Average AML risk score for reinsured cases"
    - name: "medical_evidence_transmitted_count"
      expr: COUNT(DISTINCT CASE WHEN medical_evidence_transmitted = TRUE THEN reinsurance_placement_id END)
      comment: "Count of placements with medical evidence transmitted"
    - name: "financial_evidence_transmitted_count"
      expr: COUNT(DISTINCT CASE WHEN financial_evidence_transmitted = TRUE THEN reinsurance_placement_id END)
      comment: "Count of placements with financial evidence transmitted"
    - name: "stoli_flagged_placements"
      expr: COUNT(DISTINCT CASE WHEN stoli_indicator = TRUE THEN reinsurance_placement_id END)
      comment: "Count of placements flagged for STOLI risk"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`underwriting_stoli_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "STOLI review metrics tracking stranger-originated life insurance detection, investigation outcomes, regulatory reporting, and SIU referrals"
  source: "`life_insurance_ecm`.`underwriting`.`stoli_review`"
  dimensions:
    - name: "stoli_determination"
      expr: stoli_determination
      comment: "Final STOLI determination (e.g., STOLI Confirmed, Not STOLI, Inconclusive)"
    - name: "review_status"
      expr: review_status
      comment: "Status of STOLI review (e.g., Completed, In Progress, Pending)"
    - name: "product_type"
      expr: product_type
      comment: "Type of insurance product under STOLI review"
    - name: "state_stoli_statute_jurisdiction"
      expr: state_stoli_statute_jurisdiction
      comment: "State jurisdiction with applicable STOLI statute"
    - name: "state_statute_compliance_status"
      expr: state_statute_compliance_status
      comment: "Compliance status with state STOLI statutes"
    - name: "review_initiated_year"
      expr: YEAR(review_initiated_date)
      comment: "Year STOLI review was initiated"
    - name: "review_initiated_month"
      expr: DATE_TRUNC('MONTH', review_initiated_date)
      comment: "Month STOLI review was initiated"
    - name: "investor_owned_indicator"
      expr: investor_owned_indicator
      comment: "Indicates if policy is investor-owned"
    - name: "premium_financing_indicator"
      expr: premium_financing_indicator
      comment: "Indicates if premium financing is involved"
    - name: "life_settlement_broker_involvement"
      expr: life_settlement_broker_involvement
      comment: "Indicates if life settlement broker is involved"
    - name: "siu_referral_flag"
      expr: siu_referral_flag
      comment: "Indicates if case was referred to Special Investigations Unit"
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required
      comment: "Indicates if regulatory reporting is required"
  measures:
    - name: "total_stoli_reviews"
      expr: COUNT(DISTINCT stoli_review_id)
      comment: "Total number of STOLI reviews conducted"
    - name: "total_face_amount_reviewed"
      expr: SUM(CAST(face_amount AS DOUBLE))
      comment: "Total face amount under STOLI review"
    - name: "avg_face_amount_reviewed"
      expr: AVG(CAST(face_amount AS DOUBLE))
      comment: "Average face amount per STOLI review"
    - name: "avg_stoli_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average STOLI risk score across reviews"
    - name: "investor_owned_count"
      expr: COUNT(DISTINCT CASE WHEN investor_owned_indicator = TRUE THEN stoli_review_id END)
      comment: "Count of investor-owned policies under review"
    - name: "premium_financing_count"
      expr: COUNT(DISTINCT CASE WHEN premium_financing_indicator = TRUE THEN stoli_review_id END)
      comment: "Count of reviews involving premium financing"
    - name: "life_settlement_broker_count"
      expr: COUNT(DISTINCT CASE WHEN life_settlement_broker_involvement = TRUE THEN stoli_review_id END)
      comment: "Count of reviews with life settlement broker involvement"
    - name: "siu_referral_count"
      expr: COUNT(DISTINCT CASE WHEN siu_referral_flag = TRUE THEN stoli_review_id END)
      comment: "Count of reviews referred to Special Investigations Unit"
    - name: "regulatory_reporting_required_count"
      expr: COUNT(DISTINCT CASE WHEN regulatory_reporting_required = TRUE THEN stoli_review_id END)
      comment: "Count of reviews requiring regulatory reporting"
$$;