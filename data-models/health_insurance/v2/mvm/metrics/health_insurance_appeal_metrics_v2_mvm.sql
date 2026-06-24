-- Metric views for domain: appeal | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 01:44:05

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_adverse_determination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over adverse determinations — tracks denial financials, appeal outcomes, and overturn rates to steer clinical and operational policy decisions."
  source: "`vibe_health_insurance_v1`.`appeal`.`adverse_determination`"
  dimensions:
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal associated with this adverse determination (e.g., Open, Closed, Pending)."
    - name: "appeal_outcome"
      expr: appeal_outcome
      comment: "Final outcome of the appeal (e.g., Upheld, Overturned, Partially Overturned)."
    - name: "determination_type"
      expr: determination_type
      comment: "Type of adverse determination (e.g., Medical Necessity, Experimental, Out-of-Network)."
    - name: "determination_status"
      expr: determination_status
      comment: "Current processing status of the determination record."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Standardized code representing the reason for denial — used to identify systemic denial patterns."
    - name: "basis_of_denial"
      expr: basis_of_denial
      comment: "Clinical or administrative basis cited for the denial decision."
    - name: "network_status"
      expr: network_status
      comment: "In-network or out-of-network status of the service at time of determination."
    - name: "appeal_eligibility_flag"
      expr: appeal_eligibility_flag
      comment: "Indicates whether the member is eligible to file an appeal for this determination."
    - name: "determination_month"
      expr: DATE_TRUNC('MONTH', determination_date)
      comment: "Month of the adverse determination date — used for trend analysis."
    - name: "appeal_filed_month"
      expr: DATE_TRUNC('MONTH', appeal_filed_date)
      comment: "Month the appeal was filed — used to track appeal filing volume over time."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which monetary amounts are denominated."
  measures:
    - name: "total_adverse_determinations"
      expr: COUNT(1)
      comment: "Total number of adverse determination records — baseline volume KPI for denial management."
    - name: "total_amount_denied"
      expr: SUM(CAST(monetary_amount_denied AS DOUBLE))
      comment: "Total dollar amount denied across all adverse determinations — directly measures financial exposure from denials."
    - name: "total_amount_adjusted"
      expr: SUM(CAST(monetary_amount_adjusted AS DOUBLE))
      comment: "Total dollar amount adjusted (reversed or modified) following appeal — measures financial recovery from successful appeals."
    - name: "avg_amount_denied_per_determination"
      expr: AVG(CAST(monetary_amount_denied AS DOUBLE))
      comment: "Average denied amount per adverse determination — identifies high-cost denial categories for prioritization."
    - name: "appeal_filed_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_filed_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adverse determinations for which an appeal was filed — measures member/provider engagement with the appeals process."
    - name: "appeal_overturn_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_outcome = 'Overturned' THEN 1 END) / NULLIF(COUNT(CASE WHEN appeal_filed_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of filed appeals that resulted in an overturn — key quality indicator; high rates signal problematic initial denial decisions."
    - name: "prior_auth_required_determination_count"
      expr: COUNT(CASE WHEN prior_authorization_required_flag = TRUE THEN 1 END)
      comment: "Count of adverse determinations where prior authorization was required — informs PA policy review and member friction analysis."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over appeal cases — tracks case volume, cycle times, escalation rates, and resolution patterns to drive operational efficiency and regulatory compliance."
  source: "`vibe_health_insurance_v1`.`appeal`.`case`"
  dimensions:
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal case (e.g., Open, Closed, Pending, Withdrawn)."
    - name: "appeal_type"
      expr: appeal_type
      comment: "Type of appeal (e.g., Clinical, Administrative, Expedited, Standard)."
    - name: "appeal_priority"
      expr: appeal_priority
      comment: "Priority level assigned to the appeal case — drives SLA and resource allocation decisions."
    - name: "decision_type"
      expr: decision_type
      comment: "Type of decision rendered on the appeal (e.g., Upheld, Overturned, Partially Overturned)."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business associated with the appeal case (e.g., Commercial, Medicare, Medicaid)."
    - name: "filing_channel"
      expr: filing_channel
      comment: "Channel through which the appeal was filed (e.g., Phone, Web, Mail, Fax)."
    - name: "filing_party_type"
      expr: filing_party_type
      comment: "Type of party that filed the appeal (e.g., Member, Provider, Authorized Representative)."
    - name: "regulatory_tier"
      expr: regulatory_tier
      comment: "Regulatory tier governing the appeal (e.g., ERISA, State, Federal) — critical for compliance reporting."
    - name: "appeal_escalation_flag"
      expr: appeal_escalation_flag
      comment: "Indicates whether the appeal case has been escalated — flags high-risk cases requiring executive attention."
    - name: "expedited_trigger"
      expr: expedited_trigger
      comment: "Indicates whether the case triggered an expedited review process due to clinical urgency."
    - name: "filing_month"
      expr: DATE_TRUNC('MONTH', filing_timestamp)
      comment: "Month the appeal was filed — used for volume trend analysis."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_timestamp)
      comment: "Month the appeal decision was rendered — used for decision throughput trending."
  measures:
    - name: "total_appeal_cases"
      expr: COUNT(1)
      comment: "Total number of appeal cases — primary volume KPI for appeals operations management."
    - name: "escalated_case_count"
      expr: COUNT(CASE WHEN appeal_escalation_flag = TRUE THEN 1 END)
      comment: "Number of appeal cases that were escalated — high escalation volume signals systemic issues requiring leadership intervention."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeal cases that were escalated — key operational quality metric; elevated rates indicate process or policy failures."
    - name: "expedited_case_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN expedited_trigger = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases that triggered expedited review — measures clinical urgency burden and regulatory compliance risk."
    - name: "overturn_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN decision_type = 'Overturned' THEN 1 END) / NULLIF(COUNT(CASE WHEN decision_type IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of decided appeal cases that were overturned — high overturn rates indicate poor initial denial quality and drive corrective action."
    - name: "cases_with_decision_count"
      expr: COUNT(CASE WHEN decision_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of appeal cases that have received a decision — measures decision throughput and backlog management."
    - name: "distinct_members_appealing"
      expr: COUNT(DISTINCT policy_id)
      comment: "Count of distinct member policies with at least one appeal case — measures breadth of member dissatisfaction and appeals utilization."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_expedited_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over expedited appeal reviews — tracks compliance, financial impact, and decision timeliness for clinically urgent cases subject to strict regulatory deadlines."
  source: "`vibe_health_insurance_v1`.`appeal`.`review`"
  dimensions:
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the expedited review met all regulatory compliance requirements."
  measures:
    - name: "total_expedited_reviews"
      expr: COUNT(1)
      comment: "Total number of expedited review records — baseline volume KPI for urgent appeals operations."
    - name: "compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of expedited reviews that met regulatory compliance requirements — critical regulatory KPI; non-compliance triggers penalties and corrective action plans."
    - name: "non_compliant_review_count"
      expr: COUNT(CASE WHEN compliance_flag = FALSE THEN 1 END)
      comment: "Absolute count of non-compliant expedited reviews — used for regulatory reporting and root cause analysis."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_external_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over external (independent) appeal reviews — tracks IRO decision outcomes, regulatory reporting compliance, financial exposure, and overdue review rates."
  source: "`vibe_health_insurance_v1`.`appeal`.`review`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "total_external_reviews"
      expr: COUNT(1)
      comment: "Total number of external review records — baseline volume KPI for independent review operations."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_grievance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over member and provider grievances — tracks grievance volume, resolution rates, escalation patterns, and compliance to drive member experience and regulatory performance."
  source: "`vibe_health_insurance_v1`.`appeal`.`grievance`"
  dimensions:
    - name: "grievance_type"
      expr: grievance_type
      comment: "Type of grievance filed (e.g., Quality of Care, Access, Billing, Customer Service)."
    - name: "appeal_grievance_status"
      expr: appeal_grievance_status
      comment: "Current status of the grievance (e.g., Open, Resolved, Escalated, Withdrawn)."
    - name: "resolution_type"
      expr: resolution_type
      comment: "Type of resolution applied to the grievance (e.g., Upheld, Overturned, Withdrawn, No Action)."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Level to which the grievance was escalated — used to identify systemic issues requiring executive attention."
    - name: "filing_party_type"
      expr: filing_party_type
      comment: "Type of party that filed the grievance (e.g., Member, Provider, Authorized Representative)."
    - name: "filing_channel"
      expr: filing_channel
      comment: "Channel through which the grievance was filed (e.g., Phone, Web, Mail)."
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the grievance — used for compliance reporting to state and federal regulators."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the grievance was handled in compliance with regulatory requirements."
    - name: "external_review_requested"
      expr: external_review_requested
      comment: "Indicates whether an external review was requested as part of the grievance — measures escalation to independent review."
    - name: "state_code"
      expr: state_code
      comment: "State jurisdiction of the grievance — used for state-level regulatory compliance reporting."
    - name: "filing_month"
      expr: DATE_TRUNC('MONTH', filing_date)
      comment: "Month the grievance was filed — used for volume trend analysis."
    - name: "resolution_month"
      expr: DATE_TRUNC('MONTH', resolution_date)
      comment: "Month the grievance was resolved — used for resolution throughput trending."
  measures:
    - name: "total_grievances"
      expr: COUNT(1)
      comment: "Total number of grievances filed — primary volume KPI for member and provider experience management."
    - name: "compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of grievances handled in compliance with regulatory requirements — critical regulatory KPI for health plan accreditation and audit readiness."
    - name: "resolution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN resolution_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of grievances that have been resolved — measures operational throughput and backlog management."
    - name: "external_review_escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN external_review_requested = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of grievances that escalated to external review — high rates indicate unresolved member/provider dissatisfaction and regulatory risk."
    - name: "open_grievance_count"
      expr: COUNT(CASE WHEN resolution_date IS NULL THEN 1 END)
      comment: "Count of grievances without a resolution date — measures current open backlog requiring operational attention."
    - name: "distinct_members_with_grievances"
      expr: COUNT(DISTINCT policy_id)
      comment: "Count of distinct member policies with at least one grievance — measures breadth of member dissatisfaction across the book of business."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_outcome`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over appeal outcomes — tracks financial impact of appeal decisions, compliance rates, and downstream action patterns to inform appeals strategy and cost management."
  source: "`vibe_health_insurance_v1`.`appeal`.`outcome`"
  dimensions:
    - name: "outcome_type"
      expr: outcome_type
      comment: "Type of appeal outcome (e.g., Upheld, Overturned, Partially Overturned, Withdrawn)."
    - name: "outcome_status"
      expr: outcome_status
      comment: "Current status of the outcome record (e.g., Final, Pending, Under Review)."
    - name: "downstream_action"
      expr: downstream_action
      comment: "Action triggered by the outcome (e.g., Reprocess Claim, Issue Payment, Update Authorization)."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the outcome — used to identify patterns in appeal resolutions."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the outcome was processed in compliance with regulatory requirements."
    - name: "jurisdiction_state"
      expr: jurisdiction_state
      comment: "State jurisdiction of the outcome — used for state-level regulatory compliance and financial reporting."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body overseeing the outcome (e.g., CMS, State DOI)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which financial impact amounts are denominated."
    - name: "outcome_month"
      expr: DATE_TRUNC('MONTH', outcome_timestamp)
      comment: "Month the outcome was recorded — used for financial impact trend analysis."
  measures:
    - name: "total_outcomes"
      expr: COUNT(1)
      comment: "Total number of appeal outcome records — baseline volume KPI for appeals resolution tracking."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of all appeal outcomes — measures the aggregate cost effect of appeal decisions on plan financials; key CFO-level metric."
    - name: "avg_financial_impact_per_outcome"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per appeal outcome — used to benchmark cost per appeal and identify high-impact outcome categories."
    - name: "overturn_financial_impact"
      expr: SUM(CASE WHEN outcome_type = 'Overturned' THEN CAST(financial_impact_amount AS DOUBLE) ELSE 0 END)
      comment: "Total financial impact attributable to overturned appeal outcomes — measures the cost of reversed denial decisions."
    - name: "compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeal outcomes processed in compliance with regulatory requirements — critical for accreditation and audit readiness."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over appeal clinical reviews — tracks reviewer throughput, compliance, and outcome quality to manage clinical review operations and ensure regulatory adherence."
  source: "`vibe_health_insurance_v1`.`appeal`.`review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of clinical review conducted (e.g., Medical Necessity, Experimental, Coverage)."
    - name: "review_status"
      expr: review_status
      comment: "Current status of the review (e.g., Pending, Completed, In Progress)."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the clinical review (e.g., Upheld, Overturned, Modified)."
    - name: "reviewer_type"
      expr: reviewer_type
      comment: "Type of reviewer conducting the review (e.g., Medical Director, Peer Reviewer, External IRO)."
    - name: "is_independent_reviewer"
      expr: is_independent_reviewer
      comment: "Indicates whether the reviewer is independent of the health plan — used for IRO vs. internal review segmentation."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the review was conducted in compliance with regulatory and accreditation standards."
    - name: "appeal_status_at_review"
      expr: appeal_status_at_review
      comment: "Status of the appeal at the time the review was conducted — provides context for review timing analysis."
    - name: "appeal_reason_code"
      expr: appeal_reason_code
      comment: "Reason code for the appeal being reviewed — used to identify high-volume appeal reason categories."
    - name: "review_month"
      expr: DATE_TRUNC('MONTH', review_timestamp)
      comment: "Month the review was conducted — used for reviewer throughput trend analysis."
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of clinical appeal reviews conducted — baseline throughput KPI for clinical review operations."
    - name: "compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of clinical reviews conducted in compliance with regulatory and accreditation standards — critical for NCQA/URAC accreditation and regulatory audits."
    - name: "overturn_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN outcome = 'Overturned' THEN 1 END) / NULLIF(COUNT(CASE WHEN outcome IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of completed clinical reviews that resulted in an overturn — high rates signal initial denial quality issues requiring clinical policy review."
    - name: "independent_review_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_independent_reviewer = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews conducted by independent reviewers — measures reliance on external IROs vs. internal clinical staff."
    - name: "distinct_reviewers"
      expr: COUNT(DISTINCT reviewer_npi)
      comment: "Count of distinct reviewers (by NPI) conducting appeal reviews — used for reviewer capacity planning and workload distribution analysis."
    - name: "distinct_cases_reviewed"
      expr: COUNT(DISTINCT case_id)
      comment: "Count of distinct appeal cases that have received at least one clinical review — measures review coverage across the active appeals portfolio."
$$;