-- Metric views for domain: appeal | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 00:30:14

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core appeal case metrics tracking volume, cycle time, overturn rates, and expedited processing for operational steering and regulatory compliance monitoring."
  source: "`vibe_health_insurance_v1`.`appeal`.`case`"
  dimensions:
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal case (e.g., Open, Closed, Pending Review, Escalated)."
    - name: "appeal_type"
      expr: appeal_type
      comment: "Type of appeal (e.g., Medical Necessity, Coverage Denial, Billing Dispute)."
    - name: "appeal_priority"
      expr: appeal_priority
      comment: "Priority level of the appeal (e.g., Standard, Expedited, Urgent)."
    - name: "regulatory_tier"
      expr: regulatory_tier
      comment: "Regulatory tier of the appeal (e.g., Level 1, Level 2, External Review)."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for the appeal (e.g., Commercial, Medicare, Medicaid)."
    - name: "decision_type"
      expr: decision_type
      comment: "Type of decision rendered (e.g., Upheld, Overturned, Partially Overturned)."
    - name: "filing_channel"
      expr: filing_channel
      comment: "Channel through which the appeal was filed (e.g., Phone, Portal, Mail, Fax)."
    - name: "filing_party_type"
      expr: filing_party_type
      comment: "Type of party filing the appeal (e.g., Member, Provider, Authorized Representative)."
    - name: "appeal_escalation_flag"
      expr: appeal_escalation_flag
      comment: "Flag indicating whether the appeal has been escalated."
    - name: "expedited_trigger"
      expr: expedited_trigger
      comment: "Flag indicating whether the appeal was triggered for expedited processing."
    - name: "filing_month"
      expr: DATE_TRUNC('MONTH', filing_timestamp)
      comment: "Month in which the appeal was filed."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_timestamp)
      comment: "Month in which the appeal decision was rendered."
  measures:
    - name: "total_appeals"
      expr: COUNT(1)
      comment: "Total number of appeal cases filed."
    - name: "total_expedited_appeals"
      expr: SUM(CASE WHEN expedited_trigger = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of appeals flagged for expedited processing."
    - name: "total_escalated_appeals"
      expr: SUM(CASE WHEN appeal_escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of appeals that have been escalated."
    - name: "total_overturned_appeals"
      expr: SUM(CASE WHEN decision_type IN ('Overturned', 'Partially Overturned') THEN 1 ELSE 0 END)
      comment: "Total number of appeals where the original decision was overturned or partially overturned."
    - name: "avg_appeal_cycle_days"
      expr: AVG(CAST(appeal_review_cycle_days AS DOUBLE))
      comment: "Average number of days from filing to decision for appeal cases."
    - name: "avg_decision_rationale_amount"
      expr: AVG(CAST(decision_rationale AS DOUBLE))
      comment: "Average decision rationale amount (if numeric) across appeal cases."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_adverse_determination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adverse determination metrics tracking denial volume, appeal eligibility, overturn rates, and financial impact for quality and compliance oversight."
  source: "`vibe_health_insurance_v1`.`appeal`.`adverse_determination`"
  dimensions:
    - name: "determination_status"
      expr: determination_status
      comment: "Current status of the adverse determination (e.g., Active, Appealed, Closed)."
    - name: "determination_type"
      expr: determination_type
      comment: "Type of adverse determination (e.g., Denial, Reduction, Termination)."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Code representing the reason for denial."
    - name: "appeal_eligibility_flag"
      expr: appeal_eligibility_flag
      comment: "Flag indicating whether the determination is eligible for appeal."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any appeal filed against this determination."
    - name: "appeal_outcome"
      expr: appeal_outcome
      comment: "Outcome of the appeal (e.g., Upheld, Overturned, Pending)."
    - name: "network_status"
      expr: network_status
      comment: "Network status of the service (e.g., In-Network, Out-of-Network)."
    - name: "prior_authorization_required_flag"
      expr: prior_authorization_required_flag
      comment: "Flag indicating whether prior authorization was required."
    - name: "determination_month"
      expr: DATE_TRUNC('MONTH', determination_date)
      comment: "Month in which the adverse determination was made."
    - name: "appeal_filed_month"
      expr: DATE_TRUNC('MONTH', appeal_filed_date)
      comment: "Month in which an appeal was filed against the determination."
  measures:
    - name: "total_adverse_determinations"
      expr: COUNT(1)
      comment: "Total number of adverse determinations issued."
    - name: "total_appeal_eligible_determinations"
      expr: SUM(CASE WHEN appeal_eligibility_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of adverse determinations eligible for appeal."
    - name: "total_appealed_determinations"
      expr: SUM(CASE WHEN appeal_filed_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Total number of adverse determinations that have been appealed."
    - name: "total_overturned_determinations"
      expr: SUM(CASE WHEN appeal_outcome = 'Overturned' THEN 1 ELSE 0 END)
      comment: "Total number of adverse determinations overturned on appeal."
    - name: "total_denied_amount"
      expr: SUM(CAST(monetary_amount_denied AS DOUBLE))
      comment: "Total monetary amount denied across all adverse determinations."
    - name: "total_adjusted_amount"
      expr: SUM(CAST(monetary_amount_adjusted AS DOUBLE))
      comment: "Total monetary amount adjusted (recovered) after appeal or review."
    - name: "avg_denied_amount"
      expr: AVG(CAST(monetary_amount_denied AS DOUBLE))
      comment: "Average monetary amount denied per adverse determination."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_external_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "External review metrics tracking IRO volume, overturn rates, timeliness, and regulatory compliance for quality assurance and risk management."
  source: "`vibe_health_insurance_v1`.`appeal`.`review`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "total_external_reviews"
      expr: COUNT(1)
      comment: "Total number of external reviews conducted."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_timeline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appeal timeline metrics tracking SLA compliance, breach rates, cycle time, and regulatory timeliness for operational performance and compliance monitoring."
  source: "`vibe_health_insurance_v1`.`appeal`.`timeline`"
  dimensions:
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal."
    - name: "appeal_category"
      expr: appeal_category
      comment: "Category of the appeal (e.g., Medical, Pharmacy, Billing)."
    - name: "appeal_origin"
      expr: appeal_origin
      comment: "Origin of the appeal (e.g., Member, Provider, Internal)."
    - name: "priority"
      expr: priority
      comment: "Priority level of the appeal."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the appeal timeline (e.g., Compliant, Non-Compliant)."
    - name: "sla_breach"
      expr: sla_breach
      comment: "Flag indicating whether the SLA was breached."
    - name: "breach_flag"
      expr: breach_flag
      comment: "Flag indicating whether a regulatory breach occurred."
    - name: "self_report_flag"
      expr: self_report_flag
      comment: "Flag indicating whether the breach was self-reported."
    - name: "clock_type"
      expr: clock_type
      comment: "Type of clock used for timeline tracking (e.g., Business Days, Calendar Days)."
    - name: "jurisdiction_state"
      expr: jurisdiction_state
      comment: "State jurisdiction for the appeal."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body overseeing the appeal timeline."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for any timeline breach."
    - name: "appeal_filed_month"
      expr: DATE_TRUNC('MONTH', appeal_filed_timestamp)
      comment: "Month in which the appeal was filed."
  measures:
    - name: "total_appeal_timelines"
      expr: COUNT(1)
      comment: "Total number of appeal timeline records."
    - name: "total_sla_breaches"
      expr: SUM(CASE WHEN sla_breach = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of appeals with SLA breaches."
    - name: "total_regulatory_breaches"
      expr: SUM(CASE WHEN breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of appeals with regulatory timeline breaches."
    - name: "total_self_reported_breaches"
      expr: SUM(CASE WHEN self_report_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of breaches that were self-reported to regulators."
    - name: "avg_sla_target_days"
      expr: AVG(CAST(sla_target_days AS DOUBLE))
      comment: "Average SLA target days across appeal timelines."
    - name: "avg_sla_actual_days"
      expr: AVG(CAST(sla_actual_days AS DOUBLE))
      comment: "Average actual days taken to resolve appeals."
    - name: "avg_days_overdue"
      expr: AVG(CAST(days_overdue AS DOUBLE))
      comment: "Average number of days overdue for breached appeals."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_penalty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Penalty metrics tracking regulatory fines, appeal outcomes, payment status, and financial exposure for compliance risk management and financial planning."
  source: "`vibe_health_insurance_v1`.`appeal`.`penalty`"
  dimensions:
    - name: "penalty_status"
      expr: penalty_status
      comment: "Current status of the penalty (e.g., Assessed, Paid, Appealed, Waived)."
    - name: "penalty_type"
      expr: penalty_type
      comment: "Type of penalty (e.g., Late Filing, SLA Breach, Quality Deficiency)."
    - name: "penalty_category"
      expr: penalty_category
      comment: "Category of the penalty (e.g., Regulatory, Contractual, Operational)."
    - name: "severity"
      expr: severity
      comment: "Severity level of the penalty (e.g., Low, Medium, High, Critical)."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body that assessed the penalty."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Flag indicating whether an appeal has been filed against the penalty."
    - name: "appeal_outcome"
      expr: appeal_outcome
      comment: "Outcome of the penalty appeal (e.g., Upheld, Reduced, Waived)."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating whether the penalty is related to a compliance issue."
    - name: "reason_code"
      expr: reason_code
      comment: "Code representing the reason for the penalty."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_timestamp)
      comment: "Month in which the penalty was assessed."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month in which the penalty payment is due."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month in which the penalty was paid."
  measures:
    - name: "total_penalties"
      expr: COUNT(1)
      comment: "Total number of penalties assessed."
    - name: "total_appealed_penalties"
      expr: SUM(CASE WHEN appeal_filed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of penalties that have been appealed."
    - name: "total_penalty_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total monetary amount of penalties assessed."
    - name: "total_interest_amount"
      expr: SUM(CAST(interest_amount AS DOUBLE))
      comment: "Total interest amount accrued on penalties."
    - name: "total_amount_due"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total amount due including penalties and interest."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average penalty amount per penalty record."
    - name: "avg_total_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average total amount due per penalty record."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_coverage_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coverage dispute metrics tracking volume, resolution rates, financial impact, and COB/subrogation complexity for claims operations and financial risk management."
  source: "`vibe_health_insurance_v1`.`appeal`.`coverage_dispute`"
  dimensions:
    - name: "coverage_dispute_status"
      expr: coverage_dispute_status
      comment: "Current status of the coverage dispute (e.g., Open, Resolved, Escalated)."
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of coverage dispute (e.g., Eligibility, Benefit Interpretation, COB)."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any appeal filed related to the dispute."
    - name: "disputing_party_type"
      expr: disputing_party_type
      comment: "Type of party disputing coverage (e.g., Member, Provider, Other Payer)."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the dispute."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the dispute is critical."
    - name: "network_status"
      expr: network_status
      comment: "Network status of the disputed service."
    - name: "cob_order"
      expr: cob_order
      comment: "Coordination of benefits order (e.g., Primary, Secondary)."
    - name: "subrogation_flag"
      expr: subrogation_flag
      comment: "Flag indicating whether subrogation is involved."
    - name: "formulary_exception_flag"
      expr: formulary_exception_flag
      comment: "Flag indicating whether a formulary exception is involved."
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of the dispute resolution (e.g., Approved, Denied, Partially Approved)."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month in which the coverage dispute was created."
    - name: "resolution_month"
      expr: DATE_TRUNC('MONTH', resolution_date)
      comment: "Month in which the coverage dispute was resolved."
  measures:
    - name: "total_coverage_disputes"
      expr: COUNT(1)
      comment: "Total number of coverage disputes."
    - name: "total_critical_disputes"
      expr: SUM(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of critical coverage disputes."
    - name: "total_subrogation_disputes"
      expr: SUM(CASE WHEN subrogation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of disputes involving subrogation."
    - name: "total_coordination_amount"
      expr: SUM(CAST(coordination_amount AS DOUBLE))
      comment: "Total coordination of benefits amount across disputes."
    - name: "total_subrogation_amount"
      expr: SUM(CAST(subrogation_amount AS DOUBLE))
      comment: "Total subrogation amount across disputes."
    - name: "avg_coordination_amount"
      expr: AVG(CAST(coordination_amount AS DOUBLE))
      comment: "Average coordination of benefits amount per dispute."
    - name: "avg_subrogation_amount"
      expr: AVG(CAST(subrogation_amount AS DOUBLE))
      comment: "Average subrogation amount per dispute."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_grievance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics on member grievances and appeals filed through the grievance process — key indicator of member satisfaction and service quality."
  source: "`vibe_health_insurance_v1`.`appeal`.`appeal_grievance`"
  dimensions:
    - name: "grievance_type"
      expr: grievance_type
      comment: "Type of grievance filed (e.g., quality of care, access, billing)."
    - name: "appeal_grievance_status"
      expr: appeal_grievance_status
      comment: "Current status of the grievance."
    - name: "resolution_type"
      expr: resolution_type
      comment: "Type of resolution applied to the grievance."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of the grievance."
    - name: "priority"
      expr: priority
      comment: "Priority level of the grievance."
    - name: "filing_party_type"
      expr: filing_party_type
      comment: "Type of party who filed the grievance."
    - name: "filing_channel"
      expr: filing_channel
      comment: "Channel through which the grievance was filed."
    - name: "state_code"
      expr: state_code
      comment: "State where the grievance was filed."
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the grievance."
    - name: "is_appeal"
      expr: CASE WHEN is_appeal = TRUE THEN 'Appeal' ELSE 'Grievance' END
      comment: "Whether the record is an appeal or a grievance."
    - name: "external_review_requested"
      expr: CASE WHEN external_review_requested = TRUE THEN 'Requested' ELSE 'Not Requested' END
      comment: "Whether external review was requested."
    - name: "filing_month"
      expr: DATE_TRUNC('month', filing_date)
      comment: "Month the grievance was filed for trend analysis."
  measures:
    - name: "total_grievances"
      expr: COUNT(1)
      comment: "Total number of grievances filed — primary volume metric for member dissatisfaction."
    - name: "appeal_count"
      expr: SUM(CASE WHEN is_appeal = TRUE THEN 1 ELSE 0 END)
      comment: "Number of records classified as appeals within the grievance process."
    - name: "grievance_only_count"
      expr: SUM(CASE WHEN is_appeal = FALSE THEN 1 ELSE 0 END)
      comment: "Number of pure grievances (non-appeal) — measures service quality complaints."
    - name: "external_review_requested_count"
      expr: SUM(CASE WHEN external_review_requested = TRUE THEN 1 ELSE 0 END)
      comment: "Number of grievances/appeals where external review was requested — escalation severity metric."
    - name: "compliant_count"
      expr: SUM(CASE WHEN compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of grievances handled in compliance with regulations."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_outcome`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics on appeal outcomes including financial impact, outcome distribution, and compliance — critical for measuring appeal program effectiveness."
  source: "`vibe_health_insurance_v1`.`appeal`.`outcome`"
  dimensions:
    - name: "outcome_type"
      expr: outcome_type
      comment: "Type of outcome rendered (e.g., upheld, overturned, partial overturn, withdrawn)."
    - name: "outcome_status"
      expr: outcome_status
      comment: "Current status of the outcome record."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the outcome decision."
    - name: "downstream_action"
      expr: downstream_action
      comment: "Action triggered by the outcome (e.g., claim reprocessing, benefit adjustment)."
    - name: "jurisdiction_state"
      expr: jurisdiction_state
      comment: "State jurisdiction governing the appeal outcome for regulatory analysis."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body overseeing the appeal outcome."
    - name: "is_compliant"
      expr: CASE WHEN compliance_flag = TRUE THEN 'Compliant' ELSE 'Non-Compliant' END
      comment: "Whether the outcome met compliance requirements."
    - name: "outcome_month"
      expr: DATE_TRUNC('month', outcome_timestamp)
      comment: "Month the outcome was rendered for trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the financial impact amount."
  measures:
    - name: "total_outcomes"
      expr: COUNT(1)
      comment: "Total number of appeal outcomes rendered."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of appeal outcomes — measures cost of overturned/modified decisions."
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per appeal outcome — indicates typical cost per resolved appeal."
    - name: "non_compliant_outcome_count"
      expr: SUM(CASE WHEN compliance_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Number of outcomes flagged as non-compliant — critical regulatory risk metric."
    - name: "distinct_cases_resolved"
      expr: COUNT(DISTINCT case_id)
      comment: "Unique appeal cases that have received outcomes — measures resolution throughput."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_expedited_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics on expedited appeal reviews driven by clinical urgency — critical for regulatory compliance with turnaround time requirements."
  source: "`vibe_health_insurance_v1`.`appeal`.`review`"
  dimensions:
    - name: "is_compliant"
      expr: CASE WHEN compliance_flag = TRUE THEN 'Compliant' ELSE 'Non-Compliant' END
      comment: "Whether the expedited review met compliance requirements."
  measures:
    - name: "total_expedited_reviews"
      expr: COUNT(1)
      comment: "Total number of expedited reviews — volume of clinically urgent appeals."
    - name: "non_compliant_count"
      expr: SUM(CASE WHEN compliance_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Number of expedited reviews flagged as non-compliant — regulatory risk indicator."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics on internal appeal reviews including reviewer activity, review outcomes, and clinical review patterns."
  source: "`vibe_health_insurance_v1`.`appeal`.`review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of review conducted (e.g., peer-to-peer, clinical, administrative)."
    - name: "review_status"
      expr: review_status
      comment: "Current status of the review."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the review (e.g., upheld, overturned, referred)."
    - name: "reviewer_type"
      expr: reviewer_type
      comment: "Type of reviewer (e.g., physician, nurse, administrative)."
    - name: "reviewer_specialty"
      expr: reviewer_specialty
      comment: "Medical specialty of the reviewer."
    - name: "appeal_status_at_review"
      expr: appeal_status_at_review
      comment: "Status of the appeal at the time of review."
    - name: "appeal_reason_code"
      expr: appeal_reason_code
      comment: "Reason code for the appeal being reviewed."
    - name: "is_independent_reviewer"
      expr: CASE WHEN is_independent_reviewer = TRUE THEN 'Independent' ELSE 'Internal' END
      comment: "Whether the reviewer is independent or internal."
    - name: "review_month"
      expr: DATE_TRUNC('month', review_timestamp)
      comment: "Month the review was conducted."
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of appeal reviews conducted — operational throughput metric."
    - name: "distinct_reviewers"
      expr: COUNT(DISTINCT reviewer_npi)
      comment: "Number of distinct reviewers by NPI — measures reviewer pool diversity."
    - name: "distinct_cases_reviewed"
      expr: COUNT(DISTINCT case_id)
      comment: "Unique appeal cases that received reviews."
    - name: "independent_review_count"
      expr: SUM(CASE WHEN is_independent_reviewer = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reviews conducted by independent reviewers — objectivity metric."
$$;