-- Metric views for domain: claim | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 18:58:55

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core claim financial performance and operational KPIs covering billed, allowed, paid, and patient responsibility amounts, denial rates, and adjudication throughput. Primary steering dashboard for revenue cycle leadership."
  source: "`healthcare_ecm`.`claim`.`claim`"
  dimensions:
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim (e.g., professional, institutional, dental) used to segment financial performance by claim category."
    - name: "claim_status"
      expr: claim_status
      comment: "Current adjudication status of the claim (e.g., paid, denied, pending) for pipeline and throughput analysis."
    - name: "bill_type"
      expr: bill_type
      comment: "UB-04 bill type code indicating facility type and claim frequency, used for institutional claim segmentation."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "CMS place of service code indicating the setting where services were rendered (e.g., inpatient, outpatient, office)."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Payer-assigned denial reason code enabling root-cause analysis of claim denials."
    - name: "submission_method"
      expr: submission_method
      comment: "Channel through which the claim was submitted (e.g., EDI, paper, portal) for submission efficiency analysis."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Boolean flag indicating whether an appeal was filed against a denial, used to track appeal activity."
    - name: "coordination_of_benefits_flag"
      expr: coordination_of_benefits_flag
      comment: "Boolean flag indicating the claim involves coordination of benefits across multiple payers."
    - name: "primary_payer_flag"
      expr: primary_payer_flag
      comment: "Boolean flag identifying whether the payer is the primary payer for COB sequencing analysis."
    - name: "rac_audit_flag"
      expr: rac_audit_flag
      comment: "Boolean flag indicating the claim is subject to a Recovery Audit Contractor (RAC) audit, a key compliance risk indicator."
    - name: "service_from_date"
      expr: DATE_TRUNC('month', service_from_date)
      comment: "Service start date truncated to month for trend analysis of claim volumes and financials over time."
    - name: "admission_date"
      expr: DATE_TRUNC('month', admission_date)
      comment: "Inpatient admission date truncated to month for inpatient claim cohort analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which claim amounts are denominated, supporting multi-currency financial reporting."
    - name: "source_system"
      expr: source_system
      comment: "Source system of record that originated the claim, used for data quality and system migration analysis."
  measures:
    - name: "total_claims"
      expr: COUNT(DISTINCT claim_id)
      comment: "Total number of unique claims submitted. Baseline volume KPI for revenue cycle throughput and capacity planning."
    - name: "total_billed_amount"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Total gross charges billed to payers. Represents the top-line revenue cycle exposure and is a primary financial steering metric."
    - name: "total_allowed_amount"
      expr: SUM(CAST(total_allowed_amount AS DOUBLE))
      comment: "Total contractually allowed amount across all claims. Measures the contracted revenue ceiling and payer contract performance."
    - name: "total_paid_amount"
      expr: SUM(CAST(total_paid_amount AS DOUBLE))
      comment: "Total amount actually paid by payers. Core cash collections KPI directly tied to organizational revenue."
    - name: "total_patient_responsibility_amount"
      expr: SUM(CAST(patient_responsibility_amount AS DOUBLE))
      comment: "Total patient-owed portion (copay, deductible, coinsurance) across all claims. Drives patient billing strategy and bad debt forecasting."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total contractual and other adjustments applied to claims. Measures write-down exposure from payer contracts."
    - name: "avg_billed_amount_per_claim"
      expr: AVG(CAST(total_billed_amount AS DOUBLE))
      comment: "Average billed amount per claim. Tracks case mix intensity and charge capture efficiency over time."
    - name: "avg_paid_amount_per_claim"
      expr: AVG(CAST(total_paid_amount AS DOUBLE))
      comment: "Average payer payment per claim. Benchmarks reimbursement yield and contract performance at the claim level."
    - name: "denied_claims_count"
      expr: COUNT(DISTINCT CASE WHEN claim_status = 'denied' THEN claim_id END)
      comment: "Number of claims with a denied status. Numerator for denial rate calculation and a primary revenue recovery risk indicator."
    - name: "appeal_filed_claims_count"
      expr: COUNT(DISTINCT CASE WHEN appeal_filed_flag = TRUE THEN claim_id END)
      comment: "Number of claims for which an appeal was filed. Measures appeal activity volume and downstream recovery pipeline."
    - name: "rac_audit_claims_count"
      expr: COUNT(DISTINCT CASE WHEN rac_audit_flag = TRUE THEN claim_id END)
      comment: "Number of claims flagged for RAC audit. Key compliance risk KPI monitored by compliance and finance leadership."
    - name: "avg_days_to_adjudication"
      expr: AVG(CAST(DATEDIFF(DATE(adjudication_timestamp), service_from_date) AS DOUBLE))
      comment: "Average number of days from service date to adjudication. Measures payer processing speed and revenue cycle velocity."
    - name: "avg_days_to_payment"
      expr: AVG(CAST(DATEDIFF(DATE(paid_timestamp), DATE(submitted_timestamp)) AS DOUBLE))
      comment: "Average days from claim submission to payment receipt. Core cash flow efficiency metric for revenue cycle management."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`claim_denial`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Denial management KPIs tracking denial volumes, financial impact, recovery rates, preventability, and root cause distribution. Essential for denial prevention programs and revenue recovery initiatives."
  source: "`healthcare_ecm`.`claim`.`denial`"
  dimensions:
    - name: "denial_type"
      expr: denial_type
      comment: "Classification of the denial (e.g., clinical, administrative, technical) for targeted prevention strategy."
    - name: "denial_category"
      expr: denial_category
      comment: "Broader grouping of denial types enabling executive-level denial trend reporting."
    - name: "denial_source"
      expr: denial_source
      comment: "Origin of the denial (e.g., payer, clearinghouse) to identify systemic denial patterns by source."
    - name: "carc_code"
      expr: carc_code
      comment: "Claim Adjustment Reason Code (CARC) assigned by the payer, the industry-standard denial classification for benchmarking."
    - name: "rarc_code"
      expr: rarc_code
      comment: "Remittance Advice Remark Code (RARC) providing supplemental denial explanation for detailed root-cause analysis."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Internal root cause classification code enabling operational accountability and prevention program targeting."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department accountable for the denial root cause, used for departmental performance management and accountability."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution state of the denial (e.g., appealed, written off, recovered) for pipeline management."
    - name: "appeal_outcome"
      expr: appeal_outcome
      comment: "Outcome of the appeal process (e.g., overturned, upheld) for measuring appeal effectiveness."
    - name: "is_preventable"
      expr: is_preventable
      comment: "Boolean flag indicating whether the denial was preventable, the primary metric for denial prevention program ROI."
    - name: "is_rac_audit"
      expr: is_rac_audit
      comment: "Boolean flag indicating the denial is related to a RAC audit, a high-priority compliance and financial risk indicator."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the denial for work queue management and resource allocation."
    - name: "denial_date_month"
      expr: DATE_TRUNC('month', denial_date)
      comment: "Denial date truncated to month for trend analysis of denial volumes and financial impact over time."
    - name: "service_date_month"
      expr: DATE_TRUNC('month', service_date)
      comment: "Date of service truncated to month for cohort-based denial analysis by service period."
  measures:
    - name: "total_denials"
      expr: COUNT(DISTINCT denial_id)
      comment: "Total number of unique denials. Baseline volume KPI for denial management program sizing and trend monitoring."
    - name: "total_denied_amount"
      expr: SUM(CAST(denied_amount AS DOUBLE))
      comment: "Total dollar value of denied claims. Primary financial exposure metric for denial management and revenue recovery programs."
    - name: "total_recovered_amount"
      expr: SUM(CAST(recovered_amount AS DOUBLE))
      comment: "Total amount recovered through appeals and resubmissions. Measures the financial effectiveness of denial recovery efforts."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as unrecoverable. Quantifies permanent revenue loss from denials and informs write-off policy."
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total billed amount on denied claims. Denominator for denial rate calculations and financial exposure benchmarking."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total allowed amount on denied claims. Measures the contractual value at risk from denials."
    - name: "preventable_denials_count"
      expr: COUNT(DISTINCT CASE WHEN is_preventable = TRUE THEN denial_id END)
      comment: "Number of denials classified as preventable. Core KPI for denial prevention program targeting and ROI measurement."
    - name: "overturned_denials_count"
      expr: COUNT(DISTINCT CASE WHEN appeal_outcome = 'overturned' THEN denial_id END)
      comment: "Number of denials successfully overturned on appeal. Measures appeal program effectiveness and recovery success rate."
    - name: "avg_denied_amount_per_denial"
      expr: AVG(CAST(denied_amount AS DOUBLE))
      comment: "Average denied amount per denial record. Benchmarks denial severity and prioritizes high-value recovery efforts."
    - name: "avg_days_to_appeal_filing"
      expr: AVG(CAST(DATEDIFF(appeal_filed_date, denial_date) AS DOUBLE))
      comment: "Average days between denial date and appeal filing. Measures appeal response speed, critical for meeting payer appeal deadlines."
    - name: "avg_days_denial_to_resolution"
      expr: AVG(CAST(DATEDIFF(appeal_outcome_date, denial_date) AS DOUBLE))
      comment: "Average days from denial to final resolution. Measures end-to-end denial management cycle time and operational efficiency."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`claim_appeal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appeal program performance KPIs measuring appeal volumes, financial outcomes, overturn rates, and resolution timelines. Enables revenue recovery optimization and payer dispute management."
  source: "`healthcare_ecm`.`claim`.`appeal`"
  dimensions:
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal (e.g., submitted, pending, resolved) for pipeline management and SLA monitoring."
    - name: "appeal_type"
      expr: appeal_type
      comment: "Type of appeal (e.g., clinical, administrative, technical) for targeted appeal strategy development."
    - name: "appeal_level"
      expr: appeal_level
      comment: "Level of the appeal process (e.g., first-level, second-level, external review) for escalation tracking."
    - name: "outcome_code"
      expr: outcome_code
      comment: "Payer-assigned outcome code for the appeal, enabling standardized outcome classification and benchmarking."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Original denial reason code that triggered the appeal, linking appeal outcomes back to denial root causes."
    - name: "service_type_code"
      expr: service_type_code
      comment: "Type of service associated with the appealed claim for clinical and financial segmentation."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the appeal (e.g., electronic, fax, mail) for process efficiency analysis."
    - name: "external_review_requested_flag"
      expr: external_review_requested_flag
      comment: "Boolean flag indicating an external independent review was requested, a key escalation and compliance indicator."
    - name: "peer_review_required_flag"
      expr: peer_review_required_flag
      comment: "Boolean flag indicating peer review was required for the appeal, used to track clinical review resource utilization."
    - name: "prior_authorization_issue_flag"
      expr: prior_authorization_issue_flag
      comment: "Boolean flag indicating the appeal involves a prior authorization issue, linking to auth management performance."
    - name: "rac_audit_related_flag"
      expr: rac_audit_related_flag
      comment: "Boolean flag indicating the appeal is related to a RAC audit, a high-priority compliance risk indicator."
    - name: "submission_date_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Appeal submission date truncated to month for trend analysis of appeal volumes and financial outcomes."
    - name: "resolution_date_month"
      expr: DATE_TRUNC('month', resolution_date)
      comment: "Appeal resolution date truncated to month for tracking resolution throughput and backlog trends."
  measures:
    - name: "total_appeals"
      expr: COUNT(DISTINCT appeal_id)
      comment: "Total number of unique appeals filed. Baseline volume KPI for appeal program capacity and payer dispute trend monitoring."
    - name: "total_requested_amount"
      expr: SUM(CAST(requested_amount AS DOUBLE))
      comment: "Total dollar amount requested across all appeals. Measures the financial pipeline of the appeal recovery program."
    - name: "total_overturn_amount"
      expr: SUM(CAST(overturn_amount AS DOUBLE))
      comment: "Total amount recovered through successful appeal overturns. Primary financial ROI metric for the appeal program."
    - name: "total_denied_amount"
      expr: SUM(CAST(denied_amount AS DOUBLE))
      comment: "Total originally denied amount across appealed claims. Denominator for appeal recovery rate and financial exposure sizing."
    - name: "total_original_claim_amount"
      expr: SUM(CAST(original_claim_amount AS DOUBLE))
      comment: "Total original claim amount for appealed claims. Provides context for the scale of revenue at risk in the appeal pipeline."
    - name: "avg_overturn_amount_per_appeal"
      expr: AVG(CAST(overturn_amount AS DOUBLE))
      comment: "Average amount recovered per appeal. Benchmarks appeal program yield and informs prioritization of high-value appeals."
    - name: "avg_days_to_resolution"
      expr: AVG(CAST(DATEDIFF(resolution_date, submission_date) AS DOUBLE))
      comment: "Average days from appeal submission to resolution. Measures appeal cycle time efficiency and payer responsiveness."
    - name: "external_review_appeals_count"
      expr: COUNT(DISTINCT CASE WHEN external_review_requested_flag = TRUE THEN appeal_id END)
      comment: "Number of appeals escalated to external independent review. Tracks escalation rate and associated compliance risk."
    - name: "rac_related_appeals_count"
      expr: COUNT(DISTINCT CASE WHEN rac_audit_related_flag = TRUE THEN appeal_id END)
      comment: "Number of appeals related to RAC audits. Key compliance KPI for monitoring RAC audit financial exposure and recovery."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`claim_prior_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization program KPIs measuring approval rates, denial patterns, unit utilization, and processing timelines. Enables management of authorization bottlenecks and denial prevention."
  source: "`healthcare_ecm`.`claim`.`prior_authorization`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Current status of the prior authorization request (e.g., approved, denied, pending) for pipeline and approval rate analysis."
    - name: "payer_type"
      expr: payer_type
      comment: "Type of payer (e.g., commercial, Medicare, Medicaid) for segmenting authorization performance by payer category."
    - name: "service_setting"
      expr: service_setting
      comment: "Care setting for the authorized service (e.g., inpatient, outpatient, home health) for utilization management analysis."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency classification of the authorization request (e.g., routine, urgent, emergent) for SLA and throughput management."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code for authorization denial, enabling root-cause analysis and clinical documentation improvement targeting."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Boolean flag indicating an appeal was filed against an authorization denial, tracking appeal activity on auth denials."
    - name: "appeal_outcome"
      expr: appeal_outcome
      comment: "Outcome of the authorization appeal (e.g., approved, upheld) for measuring auth appeal effectiveness."
    - name: "peer_review_required_flag"
      expr: peer_review_required_flag
      comment: "Boolean flag indicating peer review was required, used to track clinical review resource demand and processing delays."
    - name: "authorization_source"
      expr: authorization_source
      comment: "Source channel through which the authorization was obtained (e.g., phone, portal, fax) for process efficiency analysis."
    - name: "submission_date_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Authorization submission date truncated to month for trend analysis of authorization volumes and approval rates."
    - name: "decision_date_month"
      expr: DATE_TRUNC('month', decision_date)
      comment: "Authorization decision date truncated to month for tracking payer decision turnaround trends."
  measures:
    - name: "total_authorization_requests"
      expr: COUNT(DISTINCT prior_authorization_id)
      comment: "Total number of prior authorization requests submitted. Baseline volume KPI for utilization management capacity planning."
    - name: "approved_authorizations_count"
      expr: COUNT(DISTINCT CASE WHEN authorization_status = 'approved' THEN prior_authorization_id END)
      comment: "Number of approved prior authorizations. Numerator for approval rate calculation and access-to-care performance monitoring."
    - name: "denied_authorizations_count"
      expr: COUNT(DISTINCT CASE WHEN authorization_status = 'denied' THEN prior_authorization_id END)
      comment: "Number of denied prior authorizations. Key metric for denial prevention programs and payer contract negotiations."
    - name: "total_requested_units"
      expr: SUM(CAST(requested_units AS DOUBLE))
      comment: "Total units of service requested across all authorizations. Measures demand volume for utilization management planning."
    - name: "total_approved_units"
      expr: SUM(CAST(approved_units AS DOUBLE))
      comment: "Total units of service approved by payers. Measures authorized capacity and payer approval yield on requested units."
    - name: "total_units_consumed"
      expr: SUM(CAST(units_consumed AS DOUBLE))
      comment: "Total authorized units actually consumed. Measures authorization utilization efficiency and identifies over-authorization waste."
    - name: "avg_days_to_decision"
      expr: AVG(CAST(DATEDIFF(decision_date, submission_date) AS DOUBLE))
      comment: "Average days from authorization submission to payer decision. Measures payer responsiveness and authorization bottleneck risk."
    - name: "avg_approved_units_per_auth"
      expr: AVG(CAST(approved_units AS DOUBLE))
      comment: "Average approved units per authorization. Benchmarks payer approval yield relative to requested units at the authorization level."
    - name: "peer_review_required_count"
      expr: COUNT(DISTINCT CASE WHEN peer_review_required_flag = TRUE THEN prior_authorization_id END)
      comment: "Number of authorizations requiring peer review. Tracks clinical review resource demand and associated processing delay risk."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`claim_remittance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Remittance and payment posting KPIs measuring payment volumes, adjustment amounts, reconciliation status, and posting timeliness. Supports cash posting operations and payer payment performance management."
  source: "`healthcare_ecm`.`claim`.`remittance`"
  dimensions:
    - name: "remittance_status"
      expr: remittance_status
      comment: "Processing status of the remittance advice (e.g., posted, pending, exception) for cash posting pipeline management."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation state of the remittance (e.g., reconciled, unreconciled, variance) for financial close and audit readiness."
    - name: "payment_method_code"
      expr: payment_method_code
      comment: "Payment method used by the payer (e.g., EFT, check) for payment channel analysis and EFT adoption tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the remittance payment for multi-currency financial reporting."
    - name: "provider_adjustment_reason_code"
      expr: provider_adjustment_reason_code
      comment: "Reason code for provider-level adjustments on the remittance, used to identify systematic payment adjustment patterns."
    - name: "payment_date_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Payment date truncated to month for cash collections trend analysis and revenue cycle performance reporting."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Posting date truncated to month for cash posting throughput and lag analysis."
    - name: "fiscal_period_date_month"
      expr: DATE_TRUNC('month', fiscal_period_date)
      comment: "Fiscal period date truncated to month for period-based financial reporting and close process management."
  measures:
    - name: "total_remittances"
      expr: COUNT(DISTINCT remittance_id)
      comment: "Total number of remittance advices received. Baseline volume KPI for cash posting workload and payer activity monitoring."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total cash received from payers via remittance. Primary cash collections KPI directly tied to organizational liquidity."
    - name: "total_billed_amount"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Total billed amount represented in remittances. Provides the gross charge context for payment yield analysis."
    - name: "total_allowed_amount"
      expr: SUM(CAST(total_allowed_amount AS DOUBLE))
      comment: "Total contractually allowed amount per remittances. Measures payer contract performance and allowed-to-billed yield."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(total_adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied across remittances. Quantifies contractual write-downs and other payment reductions."
    - name: "total_patient_responsibility_amount"
      expr: SUM(CAST(total_patient_responsibility_amount AS DOUBLE))
      comment: "Total patient responsibility amounts identified in remittances. Drives patient billing follow-up and bad debt forecasting."
    - name: "total_provider_adjustment_amount"
      expr: SUM(CAST(provider_adjustment_amount AS DOUBLE))
      comment: "Total provider-level adjustments (e.g., recoupments, settlements) on remittances. Monitors payer recoupment activity."
    - name: "avg_payment_amount_per_remittance"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per remittance advice. Benchmarks payer payment batch size and identifies anomalous payment patterns."
    - name: "avg_days_payment_to_posting"
      expr: AVG(CAST(DATEDIFF(posting_date, payment_date) AS DOUBLE))
      comment: "Average days between payment date and posting date. Measures cash posting lag, a key operational efficiency KPI for revenue cycle."
    - name: "unreconciled_remittances_count"
      expr: COUNT(DISTINCT CASE WHEN reconciliation_status = 'unreconciled' THEN remittance_id END)
      comment: "Number of remittances not yet reconciled. Tracks financial close risk and cash posting backlog for operational management."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`claim_remittance_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level remittance KPIs measuring payment accuracy, contractual adjustments, patient responsibility, and denial patterns at the service line granularity. Enables detailed payment variance and contract compliance analysis."
  source: "`healthcare_ecm`.`claim`.`line`"
  dimensions:
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Denial reason code at the line level for granular denial pattern analysis and prevention targeting."
    - name: "revenue_code"
      expr: revenue_code
      comment: "UB-04 revenue code identifying the type of service rendered, used for service-line financial performance analysis."
  measures:
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount paid at the service line level. Granular cash collections KPI for procedure and revenue code performance analysis."
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total billed amount at the service line level. Gross charge exposure for line-level payment yield analysis."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total contractually allowed amount at the line level. Measures payer contract compliance at the procedure level."
    - name: "total_patient_responsibility_amount"
      expr: SUM(CAST(patient_responsibility_amount AS DOUBLE))
      comment: "Total patient-owed amounts at the line level (copay, deductible, coinsurance). Drives patient billing and collections strategy."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`claim_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim submission operational KPIs measuring submission volumes, rejection rates, timely filing compliance, and resubmission activity. Enables front-end revenue cycle performance management and clearinghouse efficiency monitoring."
  source: "`healthcare_ecm`.`claim`.`submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the claim submission (e.g., accepted, rejected, pending) for submission pipeline management."
    - name: "submission_type"
      expr: submission_type
      comment: "Type of submission (e.g., original, corrected, void) for tracking resubmission and correction activity."
    - name: "submission_method"
      expr: submission_method
      comment: "Channel used for claim submission (e.g., EDI 837, paper, portal) for submission channel efficiency analysis."
    - name: "acknowledgment_status"
      expr: acknowledgment_status
      comment: "Payer or clearinghouse acknowledgment status (e.g., accepted, rejected) for front-end edit and rejection management."
    - name: "claim_filing_indicator_code"
      expr: claim_filing_indicator_code
      comment: "Insurance type code (e.g., Medicare, Medicaid, commercial) for segmenting submission performance by payer type."
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Reason code for submission rejection, enabling targeted front-end edit correction and rejection prevention."
    - name: "is_timely_filed"
      expr: is_timely_filed
      comment: "Boolean flag indicating whether the claim was submitted within the payer's timely filing deadline. Critical compliance KPI."
    - name: "edi_transaction_set"
      expr: edi_transaction_set
      comment: "EDI transaction set identifier (e.g., 837P, 837I) for submission format compliance and clearinghouse routing analysis."
    - name: "submission_date_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Submission date truncated to month for trend analysis of submission volumes and rejection rates over time."
    - name: "acknowledgment_date_month"
      expr: DATE_TRUNC('month', acknowledgment_date)
      comment: "Acknowledgment date truncated to month for tracking payer/clearinghouse response turnaround trends."
  measures:
    - name: "total_submissions"
      expr: COUNT(DISTINCT submission_id)
      comment: "Total number of claim submissions. Baseline volume KPI for submission throughput and revenue cycle front-end capacity."
    - name: "total_claim_charge_amount"
      expr: SUM(CAST(claim_charge_amount AS DOUBLE))
      comment: "Total charge amount across all submitted claims. Measures the gross financial value of the submission pipeline."
    - name: "rejected_submissions_count"
      expr: COUNT(DISTINCT CASE WHEN submission_status = 'rejected' THEN submission_id END)
      comment: "Number of rejected claim submissions. Numerator for rejection rate calculation and front-end edit performance monitoring."
    - name: "timely_filed_submissions_count"
      expr: COUNT(DISTINCT CASE WHEN is_timely_filed = TRUE THEN submission_id END)
      comment: "Number of claims submitted within the timely filing deadline. Numerator for timely filing compliance rate, a key revenue protection KPI."
    - name: "late_filed_submissions_count"
      expr: COUNT(DISTINCT CASE WHEN is_timely_filed = FALSE THEN submission_id END)
      comment: "Number of claims submitted after the timely filing deadline. Quantifies revenue at risk from timely filing failures."
    - name: "avg_days_to_acknowledgment"
      expr: AVG(CAST(DATEDIFF(acknowledgment_date, submission_date) AS DOUBLE))
      comment: "Average days from submission to payer/clearinghouse acknowledgment. Measures front-end processing speed and clearinghouse SLA compliance."
    - name: "avg_charge_amount_per_submission"
      expr: AVG(CAST(claim_charge_amount AS DOUBLE))
      comment: "Average charge amount per submitted claim. Benchmarks case mix and charge capture at the submission level."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`claim_eligibility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient eligibility verification KPIs measuring coverage status, deductible and out-of-pocket exposure, verification timeliness, and network status. Enables proactive eligibility management to prevent claim denials and patient financial risk."
  source: "`healthcare_ecm`.`claim`.`eligibility`"
  dimensions:
    - name: "coverage_status"
      expr: coverage_status
      comment: "Current insurance coverage status (e.g., active, terminated, pending) for eligibility pipeline and denial prevention analysis."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of insurance coverage (e.g., HMO, PPO, Medicare) for segmenting eligibility and financial exposure by plan type."
    - name: "coverage_level"
      expr: coverage_level
      comment: "Coverage level (e.g., individual, family) for patient financial responsibility estimation and benefit analysis."
    - name: "network_status"
      expr: network_status
      comment: "In-network or out-of-network status for the patient's coverage, directly impacting reimbursement rates and patient cost-sharing."
    - name: "verification_status"
      expr: verification_status
      comment: "Status of the eligibility verification transaction (e.g., verified, failed, pending) for verification workflow management."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify eligibility (e.g., real-time 270/271, phone, portal) for process efficiency and automation analysis."
    - name: "prior_authorization_required"
      expr: prior_authorization_required
      comment: "Boolean flag indicating prior authorization is required for the coverage, used to trigger auth workflows and prevent denials."
    - name: "referral_required"
      expr: referral_required
      comment: "Boolean flag indicating a referral is required under the patient's plan, used to prevent referral-related claim denials."
    - name: "coordination_of_benefits_order"
      expr: coordination_of_benefits_order
      comment: "COB sequencing order (e.g., primary, secondary, tertiary) for multi-payer billing coordination."
    - name: "coverage_effective_date_month"
      expr: DATE_TRUNC('month', coverage_effective_date)
      comment: "Coverage effective date truncated to month for enrollment trend analysis and coverage gap identification."
    - name: "verification_date_month"
      expr: DATE_TRUNC('month', verification_date)
      comment: "Verification date truncated to month for tracking eligibility verification activity and timeliness trends."
  measures:
    - name: "total_eligibility_checks"
      expr: COUNT(DISTINCT eligibility_id)
      comment: "Total number of eligibility verification transactions. Baseline volume KPI for eligibility workflow capacity and automation coverage."
    - name: "active_coverage_count"
      expr: COUNT(DISTINCT CASE WHEN coverage_status = 'active' THEN eligibility_id END)
      comment: "Number of eligibility records with active coverage. Measures the active insured patient population for capacity and revenue planning."
    - name: "total_deductible_amount"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductible amounts across verified eligibility records. Quantifies patient financial responsibility exposure for collections planning."
    - name: "total_deductible_met_amount"
      expr: SUM(CAST(deductible_met_amount AS DOUBLE))
      comment: "Total deductible amounts already met by patients. Measures how much of the deductible exposure has been satisfied."
    - name: "total_deductible_remaining_amount"
      expr: SUM(CAST(deductible_remaining_amount AS DOUBLE))
      comment: "Total remaining deductible amounts patients still owe. Directly informs patient financial counseling and upfront collection strategy."
    - name: "total_out_of_pocket_maximum"
      expr: SUM(CAST(out_of_pocket_maximum AS DOUBLE))
      comment: "Total out-of-pocket maximum amounts across verified patients. Measures the ceiling of patient financial liability for financial assistance targeting."
    - name: "total_out_of_pocket_met_amount"
      expr: SUM(CAST(out_of_pocket_met_amount AS DOUBLE))
      comment: "Total out-of-pocket amounts already met by patients. Identifies patients who have reached their OOP max, reducing future patient collections."
    - name: "avg_copay_amount"
      expr: AVG(CAST(copay_amount AS DOUBLE))
      comment: "Average copay amount across verified eligibility records. Benchmarks patient point-of-service collection expectations by plan type."
    - name: "avg_coinsurance_percentage"
      expr: AVG(CAST(coinsurance_percentage AS DOUBLE))
      comment: "Average coinsurance percentage across verified coverage records. Informs patient financial responsibility estimation and counseling."
    - name: "prior_auth_required_count"
      expr: COUNT(DISTINCT CASE WHEN prior_authorization_required = TRUE THEN eligibility_id END)
      comment: "Number of eligibility records requiring prior authorization. Drives auth workflow volume forecasting and denial prevention planning."
    - name: "avg_verification_response_time_seconds"
      expr: AVG(CAST(UNIX_TIMESTAMP(verification_response_timestamp) - UNIX_TIMESTAMP(verification_request_timestamp) AS DOUBLE))
      comment: "Average eligibility verification response time in seconds. Measures real-time eligibility system performance and clearinghouse SLA compliance."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`claim_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service line-level financial KPIs measuring billed, allowed, paid, and patient responsibility amounts at the procedure level. Enables procedure-level revenue analysis, contract compliance, and charge capture optimization."
  source: "`healthcare_ecm`.`claim`.`line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Adjudication status of the service line (e.g., paid, denied, pending) for line-level pipeline and denial analysis."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "CMS place of service code at the line level for service setting-based financial performance analysis."
    - name: "revenue_code"
      expr: revenue_code
      comment: "UB-04 revenue code identifying the service type for institutional claim line-level financial analysis."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Denial reason code at the service line level for granular denial root-cause analysis and prevention targeting."
    - name: "drug_unit_of_measure"
      expr: drug_unit_of_measure
      comment: "Unit of measure for drug dispensing on pharmacy claim lines, used for drug utilization and cost analysis."
    - name: "modifier_1"
      expr: modifier_1
      comment: "Primary procedure modifier code affecting reimbursement, used for modifier-level payment variance analysis."
    - name: "coordination_of_benefits_indicator"
      expr: coordination_of_benefits_indicator
      comment: "COB indicator at the line level for multi-payer coordination analysis."
    - name: "service_from_date_month"
      expr: DATE_TRUNC('month', service_from_date)
      comment: "Service start date truncated to month for trend analysis of service line volumes and financials."
    - name: "adjudication_date_month"
      expr: DATE_TRUNC('month', adjudication_date)
      comment: "Adjudication date truncated to month for tracking line-level adjudication throughput trends."
    - name: "paid_date_month"
      expr: DATE_TRUNC('month', paid_date)
      comment: "Payment date truncated to month for cash collections trend analysis at the service line level."
  measures:
    - name: "total_service_lines"
      expr: COUNT(DISTINCT line_id)
      comment: "Total number of claim service lines. Baseline volume KPI for charge capture completeness and billing throughput."
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total gross charges billed at the service line level. Procedure-level charge capture KPI for revenue integrity programs."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total contractually allowed amount at the service line level. Measures payer contract performance per procedure."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount paid at the service line level. Granular cash collections KPI for procedure-level revenue analysis."
    - name: "total_patient_responsibility_amount"
      expr: SUM(CAST(patient_responsibility_amount AS DOUBLE))
      comment: "Total patient-owed amounts at the service line level. Drives patient billing strategy and bad debt forecasting by procedure."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied at the service line level. Quantifies contractual write-downs per procedure for contract analysis."
    - name: "total_units_of_service"
      expr: SUM(CAST(units_of_service AS DOUBLE))
      comment: "Total units of service billed across all claim lines. Measures service volume for utilization management and capacity planning."
    - name: "total_drug_quantity"
      expr: SUM(CAST(drug_quantity AS DOUBLE))
      comment: "Total drug quantity dispensed on pharmacy claim lines. Measures pharmaceutical utilization volume for formulary and cost management."
    - name: "total_outlier_payment_amount"
      expr: SUM(CAST(outlier_payment_amount AS DOUBLE))
      comment: "Total outlier payment amounts on claim lines. Identifies high-cost outlier cases for case management and cost containment programs."
    - name: "avg_paid_amount_per_line"
      expr: AVG(CAST(paid_amount AS DOUBLE))
      comment: "Average payment per service line. Benchmarks procedure-level reimbursement yield for contract performance and underpayment detection."
    - name: "avg_units_of_service_per_line"
      expr: AVG(CAST(units_of_service AS DOUBLE))
      comment: "Average units of service per claim line. Tracks service intensity trends for utilization management and clinical efficiency analysis."
$$;