-- Metric views for domain: claim | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 16:05:56

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core claim financial performance metrics covering billed, allowed, paid, and patient responsibility amounts, plus denial and appeal rates. Primary KPI layer for revenue cycle management and payer performance analysis."
  source: "`vibe_healthcare_v1`.`claim`.`claim`"
  dimensions:
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim (e.g., professional, institutional, dental) used to segment financial performance by claim category."
    - name: "claim_status"
      expr: claim_status
      comment: "Current adjudication status of the claim (e.g., paid, denied, pending) for pipeline and resolution analysis."
    - name: "bill_type"
      expr: bill_type
      comment: "Billing type code indicating the type of facility or service bill submitted to the payer."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "CMS place of service code indicating the setting where services were rendered (e.g., inpatient, outpatient, office)."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Payer-assigned denial reason code enabling root-cause analysis of claim denials."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the claim (e.g., electronic, paper) for operational efficiency benchmarking."
    - name: "primary_payer_flag"
      expr: primary_payer_flag
      comment: "Indicates whether the payer is the primary payer, enabling COB segmentation."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Indicates whether an appeal was filed on the claim, used to track appeal volume trends."
    - name: "rac_audit_flag"
      expr: rac_audit_flag
      comment: "Indicates whether the claim is subject to a Recovery Audit Contractor audit, a key compliance risk signal."
    - name: "service_from_date"
      expr: DATE_TRUNC('month', service_from_date)
      comment: "Service start month used for trending claim volumes and financials over time."
    - name: "principal_diagnosis_code"
      expr: principal_diagnosis_code
      comment: "Primary ICD diagnosis code on the claim for clinical and financial segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which claim amounts are denominated, required for multi-currency financial reporting."
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of claims submitted. Baseline volume metric for revenue cycle throughput monitoring."
    - name: "total_billed_amount"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Total gross charges billed to payers. Represents the top-line revenue cycle exposure and is a primary financial KPI for CFO reporting."
    - name: "total_allowed_amount"
      expr: SUM(CAST(total_allowed_amount AS DOUBLE))
      comment: "Total amount allowed by payers per contract terms. Measures contractual reimbursement ceiling and payer contract performance."
    - name: "total_paid_amount"
      expr: SUM(CAST(total_paid_amount AS DOUBLE))
      comment: "Total amount actually paid by payers. Core cash collections metric for revenue cycle and treasury management."
    - name: "total_patient_responsibility_amount"
      expr: SUM(CAST(patient_responsibility_amount AS DOUBLE))
      comment: "Total patient-owed portion (copay, deductible, coinsurance). Drives patient billing strategy and bad debt risk assessment."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total contractual and other adjustments applied to claims. Measures write-down exposure against gross charges."
    - name: "avg_billed_amount_per_claim"
      expr: AVG(CAST(total_billed_amount AS DOUBLE))
      comment: "Average billed amount per claim. Tracks case mix intensity and charge capture trends over time."
    - name: "avg_paid_amount_per_claim"
      expr: AVG(CAST(total_paid_amount AS DOUBLE))
      comment: "Average reimbursement received per claim. Key payer performance and contract yield indicator."
    - name: "denied_claims_count"
      expr: COUNT(CASE WHEN claim_status = 'DENIED' THEN 1 END)
      comment: "Number of claims in denied status. Directly measures denial volume for revenue recovery prioritization."
    - name: "appeal_filed_claims_count"
      expr: COUNT(CASE WHEN appeal_filed_flag = TRUE THEN 1 END)
      comment: "Number of claims with an appeal filed. Tracks appeal workload and denial management program activity."
    - name: "rac_audit_claims_count"
      expr: COUNT(CASE WHEN rac_audit_flag = TRUE THEN 1 END)
      comment: "Number of claims flagged for RAC audit. Measures compliance risk exposure requiring executive attention."
    - name: "paid_to_billed_ratio"
      expr: ROUND(100.0 * SUM(CAST(total_paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_billed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of billed charges actually collected from payers. Core revenue cycle efficiency KPI — low ratios signal payer contract or denial issues."
    - name: "allowed_to_billed_ratio"
      expr: ROUND(100.0 * SUM(CAST(total_allowed_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_billed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of billed charges allowed by payers. Measures payer contract yield and charge master alignment."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_denial`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Denial management KPIs tracking denial volumes, financial impact, recovery performance, and root cause distribution. Critical for revenue recovery programs and preventable denial reduction initiatives."
  source: "`vibe_healthcare_v1`.`claim`.`denial`"
  dimensions:
    - name: "denial_type"
      expr: denial_type
      comment: "Classification of denial type (e.g., clinical, administrative, technical) for root-cause segmentation."
    - name: "category"
      expr: category
      comment: "Denial category grouping for high-level trend analysis and executive reporting."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause code assigned to the denial, enabling targeted process improvement initiatives."
    - name: "carc_code"
      expr: carc_code
      comment: "Claim Adjustment Reason Code (CARC) from the payer, the industry-standard denial classification for benchmarking."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the denial (e.g., appealed, written off, recovered) for pipeline management."
    - name: "appeal_outcome"
      expr: appeal_outcome
      comment: "Outcome of the appeal filed against the denial (e.g., overturned, upheld) for appeal effectiveness measurement."
    - name: "is_preventable"
      expr: is_preventable
      comment: "Flag indicating whether the denial was preventable through upstream process improvement — key for quality programs."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department accountable for the denial root cause, enabling departmental performance accountability."
    - name: "denial_date_month"
      expr: DATE_TRUNC('month', denial_date)
      comment: "Month of denial for trending denial volumes and financial impact over time."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the denial for work queue management and SLA compliance."
    - name: "is_rac_audit"
      expr: is_rac_audit
      comment: "Indicates whether the denial is related to a RAC audit, a high-risk compliance category."
  measures:
    - name: "total_denials"
      expr: COUNT(1)
      comment: "Total number of denials. Baseline volume metric for denial management program sizing and trending."
    - name: "total_denied_amount"
      expr: SUM(CAST(denied_amount AS DOUBLE))
      comment: "Total dollar value of denied claims. Primary financial exposure metric for revenue recovery prioritization."
    - name: "total_recovered_amount"
      expr: SUM(CAST(recovered_amount AS DOUBLE))
      comment: "Total amount recovered through appeals and resubmissions. Measures revenue recovery program effectiveness."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as unrecoverable. Directly impacts net revenue and bad debt expense — a key CFO metric."
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total billed amount on denied claims. Provides context for denial financial impact relative to gross charges."
    - name: "preventable_denials_count"
      expr: COUNT(CASE WHEN is_preventable = TRUE THEN 1 END)
      comment: "Number of denials classified as preventable. Quantifies the opportunity for upstream process improvement."
    - name: "overturned_denials_count"
      expr: COUNT(CASE WHEN appeal_outcome = 'OVERTURNED' THEN 1 END)
      comment: "Number of denials successfully overturned on appeal. Measures appeal program ROI and clinical documentation quality."
    - name: "recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(recovered_amount AS DOUBLE)) / NULLIF(SUM(CAST(denied_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of denied dollars recovered. Core KPI for denial management program effectiveness — directly tied to net revenue."
    - name: "write_off_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(write_off_amount AS DOUBLE)) / NULLIF(SUM(CAST(denied_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of denied dollars written off. Measures unrecoverable revenue loss — a key risk metric for CFO and revenue cycle leadership."
    - name: "avg_denied_amount_per_denial"
      expr: AVG(CAST(denied_amount AS DOUBLE))
      comment: "Average denied amount per denial record. Helps prioritize high-value denial categories for focused recovery efforts."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_appeal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appeal lifecycle and financial outcome metrics tracking appeal volumes, overturn rates, and recovered revenue. Supports denial management strategy and payer negotiation decisions."
  source: "`vibe_healthcare_v1`.`claim`.`appeal`"
  dimensions:
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal (e.g., submitted, pending, resolved) for pipeline and workload management."
    - name: "appeal_type"
      expr: appeal_type
      comment: "Type of appeal filed (e.g., clinical, administrative, external review) for segmentation of appeal strategy effectiveness."
    - name: "level"
      expr: level
      comment: "Appeal level (e.g., first-level, second-level, external) indicating escalation stage and complexity."
    - name: "outcome_code"
      expr: outcome_code
      comment: "Payer-assigned outcome code for the appeal resolution, enabling standardized outcome benchmarking."
    - name: "service_type_code"
      expr: service_type_code
      comment: "Type of service associated with the appeal for clinical and financial segmentation."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the appeal (e.g., electronic, fax, mail) for operational efficiency analysis."
    - name: "external_review_requested_flag"
      expr: external_review_requested_flag
      comment: "Indicates whether an external independent review was requested — a signal of high-stakes or complex appeals."
    - name: "priority_flag"
      expr: priority_flag
      comment: "Indicates whether the appeal is flagged as high priority for SLA and resource allocation management."
    - name: "submission_date_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month of appeal submission for trending appeal volumes and resolution cycle times."
    - name: "rac_audit_related_flag"
      expr: rac_audit_related_flag
      comment: "Indicates whether the appeal is related to a RAC audit — a high-compliance-risk category requiring executive visibility."
  measures:
    - name: "total_appeals"
      expr: COUNT(1)
      comment: "Total number of appeals filed. Baseline volume metric for appeal program capacity planning and trend monitoring."
    - name: "total_denied_amount"
      expr: SUM(CAST(denied_amount AS DOUBLE))
      comment: "Total dollar value under appeal. Measures the financial stakes of the active appeal portfolio."
    - name: "total_requested_amount"
      expr: SUM(CAST(requested_amount AS DOUBLE))
      comment: "Total amount requested in appeals. Represents the maximum recoverable revenue from the appeal program."
    - name: "total_overturn_amount"
      expr: SUM(CAST(overturn_amount AS DOUBLE))
      comment: "Total amount recovered through successful appeal overturns. Directly measures appeal program revenue impact."
    - name: "total_original_claim_amount"
      expr: SUM(CAST(original_claim_amount AS DOUBLE))
      comment: "Total original claim amount for appealed claims. Provides context for appeal financial exposure relative to original billing."
    - name: "overturn_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(overturn_amount AS DOUBLE)) / NULLIF(SUM(CAST(denied_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of denied dollars recovered via appeal overturns. Core KPI for appeal program ROI and payer dispute effectiveness."
    - name: "avg_overturn_amount_per_appeal"
      expr: AVG(CAST(overturn_amount AS DOUBLE))
      comment: "Average amount recovered per appeal. Helps prioritize appeal types and levels by financial return."
    - name: "external_review_appeals_count"
      expr: COUNT(CASE WHEN external_review_requested_flag = TRUE THEN 1 END)
      comment: "Number of appeals escalated to external review. Measures payer dispute escalation rate and associated cost exposure."
    - name: "priority_appeals_count"
      expr: COUNT(CASE WHEN priority_flag = TRUE THEN 1 END)
      comment: "Number of high-priority appeals. Drives SLA compliance monitoring and resource allocation decisions."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_prior_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization approval, denial, and utilization metrics. Supports medical management, payer relations, and care access performance monitoring."
  source: "`vibe_healthcare_v1`.`claim`.`prior_authorization`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Current status of the prior authorization request (e.g., approved, denied, pending) for pipeline management."
    - name: "payer_type"
      expr: payer_type
      comment: "Type of payer (e.g., commercial, Medicare, Medicaid) for segmenting authorization approval rates by payer category."
    - name: "service_setting"
      expr: service_setting
      comment: "Clinical setting for the requested service (e.g., inpatient, outpatient, home health) for utilization management analysis."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency classification of the authorization request (e.g., routine, urgent, emergent) for SLA and access-to-care monitoring."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code for prior authorization denial, enabling targeted clinical documentation and appeal strategy improvements."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Indicates whether an appeal was filed against a prior authorization denial."
    - name: "appeal_outcome"
      expr: appeal_outcome
      comment: "Outcome of the prior authorization appeal (e.g., approved, upheld) for measuring appeal effectiveness."
    - name: "peer_review_required_flag"
      expr: peer_review_required_flag
      comment: "Indicates whether peer review was required, a signal of clinical complexity and potential access delay."
    - name: "submission_date_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month of prior authorization submission for trending volumes and approval rates over time."
    - name: "requested_service_cpt_code"
      expr: requested_service_cpt_code
      comment: "CPT code for the requested service, enabling procedure-level authorization approval rate analysis."
  measures:
    - name: "total_prior_auth_requests"
      expr: COUNT(1)
      comment: "Total number of prior authorization requests submitted. Baseline volume metric for utilization management capacity planning."
    - name: "approved_requests_count"
      expr: COUNT(CASE WHEN authorization_status = 'APPROVED' THEN 1 END)
      comment: "Number of prior authorization requests approved. Measures access-to-care throughput and payer approval rates."
    - name: "denied_requests_count"
      expr: COUNT(CASE WHEN authorization_status = 'DENIED' THEN 1 END)
      comment: "Number of prior authorization requests denied. Key metric for medical management and payer relations strategy."
    - name: "total_approved_units"
      expr: SUM(CAST(approved_units AS DOUBLE))
      comment: "Total units of service approved across all authorizations. Measures authorized care volume for capacity and utilization planning."
    - name: "total_requested_units"
      expr: SUM(CAST(requested_units AS DOUBLE))
      comment: "Total units of service requested across all authorizations. Baseline for measuring payer approval yield."
    - name: "total_units_consumed"
      expr: SUM(CAST(units_consumed AS DOUBLE))
      comment: "Total authorized units actually consumed. Measures authorization utilization efficiency and potential over-authorization waste."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN authorization_status = 'APPROVED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prior authorization requests approved. Core payer relations and access-to-care KPI tracked by medical directors."
    - name: "units_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(units_consumed AS DOUBLE)) / NULLIF(SUM(CAST(approved_units AS DOUBLE)), 0), 2)
      comment: "Percentage of approved units actually consumed. Identifies over-authorization waste and informs authorization policy calibration."
    - name: "units_approval_yield_pct"
      expr: ROUND(100.0 * SUM(CAST(approved_units AS DOUBLE)) / NULLIF(SUM(CAST(requested_units AS DOUBLE)), 0), 2)
      comment: "Percentage of requested units approved by payers. Measures payer restrictiveness and clinical documentation effectiveness."
    - name: "peer_review_required_count"
      expr: COUNT(CASE WHEN peer_review_required_flag = TRUE THEN 1 END)
      comment: "Number of authorizations requiring peer review. Tracks clinical complexity burden and potential care access delays."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_remittance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Remittance payment reconciliation and cash posting metrics. Supports treasury, revenue cycle, and payer payment performance monitoring."
  source: "`vibe_healthcare_v1`.`claim`.`remittance`"
  dimensions:
    - name: "remittance_status"
      expr: remittance_status
      comment: "Current status of the remittance (e.g., posted, pending, reconciled) for cash posting pipeline management."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the remittance against expected payments — key for identifying payment discrepancies."
    - name: "payment_method_code"
      expr: payment_method_code
      comment: "Method of payment (e.g., EFT, check) for cash management and electronic payment adoption tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the remittance payment for multi-currency treasury reporting."
    - name: "payment_date_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of payment for trending cash collections and payer payment cycle analysis."
    - name: "fiscal_period_date"
      expr: DATE_TRUNC('month', fiscal_period_date)
      comment: "Fiscal period month for aligning remittance cash to accounting periods."
    - name: "provider_adjustment_reason_code"
      expr: provider_adjustment_reason_code
      comment: "Reason code for provider-level adjustments on the remittance, enabling adjustment root-cause analysis."
  measures:
    - name: "total_remittances"
      expr: COUNT(1)
      comment: "Total number of remittance transactions processed. Baseline volume metric for cash posting operations."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total cash received from payers via remittance. Primary treasury and revenue cycle collections KPI."
    - name: "total_billed_amount"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Total billed amount on remittances. Provides gross charge context for payment yield analysis."
    - name: "total_allowed_amount"
      expr: SUM(CAST(total_allowed_amount AS DOUBLE))
      comment: "Total allowed amount per remittances. Measures contractual reimbursement against billed charges."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(total_adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied across remittances. Measures contractual write-down exposure at the remittance level."
    - name: "total_patient_responsibility_amount"
      expr: SUM(CAST(total_patient_responsibility_amount AS DOUBLE))
      comment: "Total patient-owed balance identified on remittances. Drives patient billing follow-up and bad debt forecasting."
    - name: "total_provider_adjustment_amount"
      expr: SUM(CAST(provider_adjustment_amount AS DOUBLE))
      comment: "Total provider-level adjustments on remittances. Identifies systematic payer recoupment or bonus payment patterns."
    - name: "payment_to_billed_ratio"
      expr: ROUND(100.0 * SUM(CAST(payment_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_billed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of billed charges collected via remittance. Core revenue cycle yield KPI for payer contract performance."
    - name: "avg_payment_per_remittance"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per remittance transaction. Tracks payer payment batch size trends for cash flow forecasting."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim line-level financial and utilization metrics for procedure-level revenue analysis, denial management, and service utilization benchmarking."
  source: "`vibe_healthcare_v1`.`claim`.`line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Adjudication status of the claim line (e.g., paid, denied, adjusted) for line-level revenue cycle analysis."
    - name: "procedure_code"
      expr: procedure_code
      comment: "Procedure code billed on the claim line for procedure-level financial and utilization analysis."
    - name: "revenue_code"
      expr: revenue_code
      comment: "UB-04 revenue code for the service line, enabling departmental revenue analysis for facility claims."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service code on the claim line for setting-level financial benchmarking."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Denial reason code at the line level for granular denial root-cause analysis."
    - name: "drug_unit_of_measure"
      expr: drug_unit_of_measure
      comment: "Unit of measure for drug lines, enabling pharmaceutical utilization and cost analysis."
    - name: "service_from_date_month"
      expr: DATE_TRUNC('month', service_from_date)
      comment: "Month of service for trending line-level volumes and financials over time."
    - name: "modifier_1"
      expr: modifier_1
      comment: "Primary procedure modifier affecting reimbursement, used for modifier-level payment variance analysis."
  measures:
    - name: "total_claim_lines"
      expr: COUNT(1)
      comment: "Total number of claim lines processed. Baseline volume metric for service utilization and billing operations."
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total gross charges billed at the line level. Procedure-level revenue exposure metric for charge capture analysis."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total allowed amount at the line level. Measures procedure-level payer contract yield."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount paid at the line level. Procedure-level cash collections metric for revenue cycle management."
    - name: "total_patient_responsibility_amount"
      expr: SUM(CAST(patient_responsibility_amount AS DOUBLE))
      comment: "Total patient-owed amount at the line level. Drives patient billing strategy and collections prioritization."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied at the line level. Measures procedure-level contractual write-down exposure."
    - name: "total_units_of_service"
      expr: SUM(CAST(units_of_service AS DOUBLE))
      comment: "Total units of service billed. Core utilization metric for capacity planning and payer utilization management."
    - name: "total_drug_quantity"
      expr: SUM(CAST(drug_quantity AS DOUBLE))
      comment: "Total drug quantity billed on pharmaceutical claim lines. Supports pharmacy cost and utilization management."
    - name: "avg_paid_per_unit"
      expr: ROUND(SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(units_of_service AS DOUBLE)), 0), 2)
      comment: "Average reimbursement per unit of service. Measures procedure-level payment rate for payer contract benchmarking."
    - name: "line_paid_to_billed_ratio"
      expr: ROUND(100.0 * SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(billed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of billed charges paid at the line level. Procedure-level revenue yield KPI for charge master and contract analysis."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim submission operational metrics covering timely filing compliance, rejection rates, and resubmission activity. Supports revenue cycle operations and compliance monitoring."
  source: "`vibe_healthcare_v1`.`claim`.`submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the claim submission (e.g., accepted, rejected, pending) for submission pipeline management."
    - name: "submission_type"
      expr: submission_type
      comment: "Type of submission (e.g., original, corrected, void) for tracking resubmission and correction activity."
    - name: "method"
      expr: method
      comment: "Submission method (e.g., electronic, paper) for operational efficiency and EDI adoption tracking."
    - name: "acknowledgment_status"
      expr: acknowledgment_status
      comment: "Payer acknowledgment status of the submission for tracking accepted vs. rejected submissions."
    - name: "claim_filing_indicator_code"
      expr: claim_filing_indicator_code
      comment: "Filing indicator code (e.g., Medicare, commercial) for payer-type segmentation of submission performance."
    - name: "is_timely_filed"
      expr: is_timely_filed
      comment: "Indicates whether the claim was submitted within the payer's timely filing deadline — a critical compliance KPI."
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Reason code for submission rejection, enabling targeted front-end edit and clearinghouse improvement."
    - name: "submission_date_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month of submission for trending submission volumes, rejection rates, and timely filing compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the submitted claim charges for multi-currency financial reporting."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of claim submissions. Baseline volume metric for revenue cycle throughput and operations staffing."
    - name: "total_claim_charge_amount"
      expr: SUM(CAST(claim_charge_amount AS DOUBLE))
      comment: "Total charge amount submitted to payers. Measures gross revenue cycle submission volume in dollars."
    - name: "timely_filed_submissions_count"
      expr: COUNT(CASE WHEN is_timely_filed = TRUE THEN 1 END)
      comment: "Number of claims submitted within timely filing deadlines. Compliance metric — late filings result in direct revenue loss."
    - name: "rejected_submissions_count"
      expr: COUNT(CASE WHEN submission_status = 'REJECTED' THEN 1 END)
      comment: "Number of rejected submissions. Measures front-end claim quality and clearinghouse edit effectiveness."
    - name: "timely_filing_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_timely_filed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims submitted within timely filing deadlines. Critical compliance KPI — failure directly causes claim denials and revenue loss."
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN submission_status = 'REJECTED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions rejected by payers or clearinghouses. Measures claim quality and front-end edit effectiveness — high rates signal systemic billing issues."
    - name: "avg_charge_amount_per_submission"
      expr: AVG(CAST(claim_charge_amount AS DOUBLE))
      comment: "Average charge amount per submission. Tracks case mix and charge capture trends at the submission level."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_eligibility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Insurance eligibility verification metrics covering coverage status, deductible and out-of-pocket exposure, and verification performance. Supports patient access, financial counseling, and revenue cycle front-end operations."
  source: "`vibe_healthcare_v1`.`claim`.`eligibility`"
  dimensions:
    - name: "coverage_status"
      expr: coverage_status
      comment: "Current insurance coverage status (e.g., active, terminated, pending) for eligibility pipeline management."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of insurance coverage (e.g., HMO, PPO, Medicare) for payer mix and benefit design analysis."
    - name: "coverage_level"
      expr: coverage_level
      comment: "Coverage level (e.g., individual, family) for benefit utilization and patient responsibility analysis."
    - name: "network_status"
      expr: network_status
      comment: "In-network vs. out-of-network status — directly impacts patient cost-sharing and reimbursement rates."
    - name: "verification_status"
      expr: verification_status
      comment: "Status of the eligibility verification transaction (e.g., verified, failed, pending) for front-end operations monitoring."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used for eligibility verification (e.g., real-time EDI, manual) for automation adoption tracking."
    - name: "prior_authorization_required"
      expr: prior_authorization_required
      comment: "Indicates whether prior authorization is required per the patient's benefit plan — drives PA workflow volume."
    - name: "referral_required"
      expr: referral_required
      comment: "Indicates whether a referral is required — impacts care coordination and claim denial risk."
    - name: "service_date_month"
      expr: DATE_TRUNC('month', service_date)
      comment: "Month of service for trending eligibility verification volumes and coverage status distributions."
    - name: "coordination_of_benefits_order"
      expr: coordination_of_benefits_order
      comment: "COB order (primary, secondary, tertiary) for payer sequencing and coordination of benefits analysis."
  measures:
    - name: "total_eligibility_checks"
      expr: COUNT(1)
      comment: "Total number of eligibility verification transactions. Baseline metric for front-end revenue cycle operations volume."
    - name: "total_deductible_amount"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductible exposure across verified patients. Drives patient financial counseling and upfront collection strategy."
    - name: "total_deductible_met_amount"
      expr: SUM(CAST(deductible_met_amount AS DOUBLE))
      comment: "Total deductible already met by patients. Informs patient responsibility estimates and point-of-service collection opportunities."
    - name: "total_deductible_remaining_amount"
      expr: SUM(CAST(deductible_remaining_amount AS DOUBLE))
      comment: "Total remaining deductible balance across patients. Quantifies upfront patient collection opportunity at point of service."
    - name: "total_out_of_pocket_maximum"
      expr: SUM(CAST(out_of_pocket_maximum AS DOUBLE))
      comment: "Total out-of-pocket maximum exposure across verified patients. Supports patient financial risk stratification."
    - name: "total_out_of_pocket_met_amount"
      expr: SUM(CAST(out_of_pocket_met_amount AS DOUBLE))
      comment: "Total out-of-pocket maximum already met. Identifies patients with no remaining cost-sharing — impacts collection strategy."
    - name: "total_copay_amount"
      expr: SUM(CAST(copay_amount AS DOUBLE))
      comment: "Total copay amounts across verified patients. Measures point-of-service collection opportunity and patient cost-sharing burden."
    - name: "avg_deductible_remaining"
      expr: AVG(CAST(deductible_remaining_amount AS DOUBLE))
      comment: "Average remaining deductible per patient. Benchmarks patient financial exposure for counseling program design."
    - name: "deductible_met_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(deductible_met_amount AS DOUBLE)) / NULLIF(SUM(CAST(deductible_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total deductible already met by patients. Indicates seasonal benefit utilization patterns and collection timing strategy."
    - name: "prior_auth_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN prior_authorization_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of eligibility checks where prior authorization is required. Drives PA workflow capacity planning and denial prevention."
$$;