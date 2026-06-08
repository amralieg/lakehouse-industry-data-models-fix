-- Metric views for domain: appeal | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 18:36:19

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`appeal_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core appeal case metrics tracking volume, type distribution, expedited rates, and decision timeliness for health insurance appeal management."
  source: "`health_insurance_ecm`.`appeal`.`case`"
  dimensions:
    - name: "appeal_type"
      expr: appeal_type
      comment: "Classification of the appeal (e.g., pre-service, post-service, urgent care)."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal case (e.g., open, closed, pending)."
    - name: "decision_type"
      expr: decision_type
      comment: "Type of decision rendered (e.g., upheld, overturned, partial overturn)."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business associated with the appeal (e.g., commercial, Medicare, Medicaid)."
    - name: "regulatory_tier"
      expr: regulatory_tier
      comment: "Regulatory tier classification of the appeal for compliance tracking."
    - name: "filing_party_type"
      expr: filing_party_type
      comment: "Type of party who filed the appeal (e.g., member, provider, authorized representative)."
    - name: "filing_channel"
      expr: filing_channel
      comment: "Channel through which the appeal was filed (e.g., mail, phone, portal)."
    - name: "appeal_priority"
      expr: appeal_priority
      comment: "Priority level assigned to the appeal case."
    - name: "filing_year"
      expr: YEAR(filing_timestamp)
      comment: "Year the appeal was filed for trend analysis."
    - name: "filing_month"
      expr: DATE_TRUNC('month', filing_timestamp)
      comment: "Month the appeal was filed for trend analysis."
    - name: "is_expedited"
      expr: CASE WHEN expedited_trigger = TRUE THEN 'Expedited' ELSE 'Standard' END
      comment: "Whether the appeal was flagged as expedited due to clinical urgency."
    - name: "completeness_determination"
      expr: completeness_determination
      comment: "Whether the appeal submission was determined complete or incomplete."
  measures:
    - name: "total_appeal_cases"
      expr: COUNT(1)
      comment: "Total number of appeal cases filed — baseline volume metric for appeal operations."
    - name: "distinct_members_appealing"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Count of unique members who have filed appeals, indicating breadth of member dissatisfaction."
    - name: "expedited_appeal_count"
      expr: SUM(CASE WHEN expedited_trigger = TRUE THEN 1 ELSE 0 END)
      comment: "Number of appeals flagged as expedited due to clinical urgency — key compliance and operational metric."
    - name: "escalated_appeal_count"
      expr: SUM(CASE WHEN appeal_escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of appeals that were escalated, indicating complexity or member dissatisfaction."
    - name: "overturned_appeal_count"
      expr: SUM(CASE WHEN decision_type = 'Overturned' THEN 1 ELSE 0 END)
      comment: "Number of appeals where the original determination was overturned — signals quality issues in initial decisions."
    - name: "decided_appeal_count"
      expr: SUM(CASE WHEN decision_type IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of appeals that have received a decision — denominator for overturn rate calculation in BI layer."
    - name: "distinct_providers_appealed"
      expr: COUNT(DISTINCT provider_id)
      comment: "Count of unique providers associated with appeals — helps identify provider-driven appeal patterns."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`appeal_adverse_determination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics on adverse determinations (denials) that drive the appeal process, tracking denial volumes, monetary impact, and appeal eligibility."
  source: "`health_insurance_ecm`.`appeal`.`adverse_determination`"
  dimensions:
    - name: "determination_type"
      expr: determination_type
      comment: "Type of adverse determination (e.g., medical necessity, experimental, not covered)."
    - name: "determination_status"
      expr: determination_status
      comment: "Current status of the adverse determination."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Standardized code for the reason of denial."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any appeal filed against this adverse determination."
    - name: "appeal_outcome"
      expr: appeal_outcome
      comment: "Outcome of the appeal if one was filed."
    - name: "network_status"
      expr: network_status
      comment: "Whether the service was in-network or out-of-network at time of denial."
    - name: "appeal_eligible"
      expr: CASE WHEN appeal_eligibility_flag = TRUE THEN 'Eligible' ELSE 'Not Eligible' END
      comment: "Whether the adverse determination is eligible for appeal."
    - name: "service_month"
      expr: DATE_TRUNC('month', service_date)
      comment: "Month of the denied service for trend analysis."
    - name: "determination_month"
      expr: DATE_TRUNC('month', determination_date)
      comment: "Month the adverse determination was made."
    - name: "diagnosis_code"
      expr: diagnosis_code
      comment: "Diagnosis code associated with the denied service."
    - name: "service_code"
      expr: service_code
      comment: "Service/procedure code that was denied."
    - name: "prior_auth_required"
      expr: CASE WHEN prior_authorization_required_flag = TRUE THEN 'Required' ELSE 'Not Required' END
      comment: "Whether prior authorization was required for the denied service."
  measures:
    - name: "total_adverse_determinations"
      expr: COUNT(1)
      comment: "Total number of adverse determinations issued — key volume metric for denial management."
    - name: "total_denied_amount"
      expr: SUM(CAST(monetary_amount_denied AS DOUBLE))
      comment: "Total monetary amount denied across all adverse determinations — financial exposure metric."
    - name: "total_adjusted_amount"
      expr: SUM(CAST(monetary_amount_adjusted AS DOUBLE))
      comment: "Total monetary amount adjusted post-determination — measures financial recovery through appeals."
    - name: "avg_denied_amount"
      expr: AVG(CAST(monetary_amount_denied AS DOUBLE))
      comment: "Average denied amount per adverse determination — indicates severity of denials."
    - name: "appeal_eligible_count"
      expr: SUM(CASE WHEN appeal_eligibility_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of adverse determinations eligible for appeal."
    - name: "appeals_filed_count"
      expr: SUM(CASE WHEN appeal_filed_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of adverse determinations where an appeal was actually filed — numerator for appeal filing rate."
    - name: "distinct_members_denied"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Unique members receiving adverse determinations — breadth of denial impact on membership."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`appeal_outcome`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics on appeal outcomes including financial impact, outcome distribution, and compliance — critical for measuring appeal program effectiveness."
  source: "`health_insurance_ecm`.`appeal`.`outcome`"
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
    - name: "distinct_members_with_outcomes"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Unique members receiving appeal outcomes."
    - name: "distinct_cases_resolved"
      expr: COUNT(DISTINCT case_id)
      comment: "Unique appeal cases that have received outcomes — measures resolution throughput."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`appeal_external_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics on external (independent) reviews of appeals — a key regulatory compliance and quality indicator for health insurers."
  source: "`health_insurance_ecm`.`appeal`.`review`"
  dimensions:
    - name: "appeal_reason_code"
      expr: appeal_reason_code
      comment: "Reason code for the appeal that triggered external review."
  measures:
    - name: "total_external_reviews"
      expr: COUNT(1)
      comment: "Total number of external reviews requested — indicates volume of appeals escalated beyond internal process."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`appeal_expedited_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics on expedited appeal reviews driven by clinical urgency — critical for regulatory compliance with turnaround time requirements."
  source: "`health_insurance_ecm`.`appeal`.`review`"
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

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`appeal_timeline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics on appeal processing timelines, SLA compliance, and breach tracking — essential for regulatory compliance and operational efficiency."
  source: "`health_insurance_ecm`.`appeal`.`timeline`"
  dimensions:
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal in the timeline."
    - name: "appeal_category"
      expr: appeal_category
      comment: "Category of the appeal for timeline tracking."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the appeal timeline."
    - name: "jurisdiction_state"
      expr: jurisdiction_state
      comment: "State jurisdiction governing timeline requirements."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body overseeing timeline compliance."
    - name: "priority"
      expr: priority
      comment: "Priority level of the appeal."
    - name: "appeal_origin"
      expr: appeal_origin
      comment: "Origin channel of the appeal."
    - name: "clock_type"
      expr: clock_type
      comment: "Type of regulatory clock applied (e.g., standard, expedited)."
    - name: "is_breached"
      expr: CASE WHEN breach_flag = TRUE THEN 'Breached' ELSE 'Within SLA' END
      comment: "Whether the appeal timeline breached regulatory requirements."
    - name: "is_sla_breached"
      expr: CASE WHEN sla_breach = TRUE THEN 'SLA Breached' ELSE 'SLA Met' END
      comment: "Whether the appeal breached its SLA target."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for timeline breaches."
    - name: "filing_month"
      expr: DATE_TRUNC('month', appeal_filed_timestamp)
      comment: "Month the appeal was filed for trend analysis."
  measures:
    - name: "total_timeline_records"
      expr: COUNT(1)
      comment: "Total number of appeal timeline records tracked."
    - name: "breach_count"
      expr: SUM(CASE WHEN breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of appeals that breached regulatory timelines — critical compliance metric reported to regulators."
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach = TRUE THEN 1 ELSE 0 END)
      comment: "Number of appeals that breached SLA targets — operational efficiency metric."
    - name: "self_reported_breach_count"
      expr: SUM(CASE WHEN self_report_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of breaches self-reported to regulators — transparency and compliance metric."
    - name: "distinct_cases_tracked"
      expr: COUNT(DISTINCT case_id)
      comment: "Unique appeal cases with timeline tracking."
    - name: "distinct_members_tracked"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Unique members with appeal timelines being tracked."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`appeal_coverage_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics on coverage disputes including coordination of benefits, subrogation, and dispute resolution — key for financial recovery and member satisfaction."
  source: "`health_insurance_ecm`.`appeal`.`coverage_dispute`"
  dimensions:
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of coverage dispute (e.g., COB, eligibility, benefit interpretation)."
    - name: "coverage_dispute_status"
      expr: coverage_dispute_status
      comment: "Current status of the coverage dispute."
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of the dispute resolution."
    - name: "network_status"
      expr: network_status
      comment: "Network status of the disputed service."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the coverage dispute."
    - name: "disputing_party_type"
      expr: disputing_party_type
      comment: "Type of party disputing coverage."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any appeal filed for this dispute."
    - name: "is_critical"
      expr: CASE WHEN is_critical = TRUE THEN 'Critical' ELSE 'Standard' END
      comment: "Whether the dispute is classified as critical."
    - name: "has_subrogation"
      expr: CASE WHEN subrogation_flag = TRUE THEN 'Subrogation' ELSE 'No Subrogation' END
      comment: "Whether the dispute involves subrogation recovery."
    - name: "disputed_benefit_code"
      expr: disputed_benefit_code
      comment: "Benefit code being disputed."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the dispute was created for trend analysis."
  measures:
    - name: "total_coverage_disputes"
      expr: COUNT(1)
      comment: "Total number of coverage disputes — volume metric for dispute management."
    - name: "total_coordination_amount"
      expr: SUM(CAST(coordination_amount AS DOUBLE))
      comment: "Total coordination of benefits amount in dispute."
    - name: "total_subrogation_amount"
      expr: SUM(CAST(subrogation_amount AS DOUBLE))
      comment: "Total subrogation recovery amount — financial recovery metric."
    - name: "critical_dispute_count"
      expr: SUM(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END)
      comment: "Number of disputes classified as critical — requires immediate attention."
    - name: "subrogation_dispute_count"
      expr: SUM(CASE WHEN subrogation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of disputes involving subrogation — financial recovery opportunity metric."
    - name: "avg_coordination_amount"
      expr: AVG(CAST(coordination_amount AS DOUBLE))
      comment: "Average coordination of benefits amount per dispute."
    - name: "distinct_members_disputing"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Unique members involved in coverage disputes."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`appeal_penalty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics on penalties assessed against the health plan for appeal-related compliance failures — critical for regulatory risk management and financial planning."
  source: "`health_insurance_ecm`.`appeal`.`penalty`"
  dimensions:
    - name: "penalty_type"
      expr: penalty_type
      comment: "Type of penalty assessed (e.g., monetary, corrective action, sanctions)."
    - name: "penalty_category"
      expr: penalty_category
      comment: "Category of the penalty for classification."
    - name: "penalty_status"
      expr: penalty_status
      comment: "Current status of the penalty."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the penalty amount."
    - name: "severity"
      expr: severity
      comment: "Severity level of the penalty."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body that assessed the penalty."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the penalty assessment."
    - name: "appeal_outcome"
      expr: appeal_outcome
      comment: "Outcome of any appeal filed against the penalty."
    - name: "has_appeal_filed"
      expr: CASE WHEN appeal_filed_flag = TRUE THEN 'Appeal Filed' ELSE 'No Appeal' END
      comment: "Whether an appeal has been filed against the penalty."
    - name: "assessment_month"
      expr: DATE_TRUNC('month', assessment_timestamp)
      comment: "Month the penalty was assessed for trend analysis."
  measures:
    - name: "total_penalties"
      expr: COUNT(1)
      comment: "Total number of penalties assessed — regulatory compliance failure volume."
    - name: "total_penalty_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total base penalty amount assessed — direct financial impact of compliance failures."
    - name: "total_penalty_with_interest"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total penalty amount including interest — full financial liability."
    - name: "total_interest_amount"
      expr: SUM(CAST(interest_amount AS DOUBLE))
      comment: "Total interest accrued on penalties — cost of delayed compliance resolution."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average penalty amount — indicates typical severity of compliance failures."
    - name: "appealed_penalty_count"
      expr: SUM(CASE WHEN appeal_filed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of penalties where an appeal was filed — measures contestation rate."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`appeal_grievance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics on member grievances and appeals filed through the grievance process — key indicator of member satisfaction and service quality."
  source: "`health_insurance_ecm`.`appeal`.`appeal_grievance`"
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
    - name: "distinct_members_grieving"
      expr: COUNT(DISTINCT filing_party_id)
      comment: "Unique filing parties who submitted grievances."
    - name: "distinct_providers_involved"
      expr: COUNT(DISTINCT provider_id)
      comment: "Unique providers associated with grievances — identifies provider quality patterns."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`appeal_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics on internal appeal reviews including reviewer activity, review outcomes, and clinical review patterns."
  source: "`health_insurance_ecm`.`appeal`.`review`"
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