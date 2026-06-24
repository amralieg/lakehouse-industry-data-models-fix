-- Metric views for domain: claim | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 14:47:42

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core claim financial and adjudication KPIs across the revenue cycle. Tracks billed vs allowed vs paid amounts, denial rates, patient responsibility, and claim status mix to steer net collection performance and payer mix decisions."
  source: "`vibe_healthcare_v1`.`claim`.`claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current lifecycle status of the claim (submitted, adjudicated, paid, denied). Used to monitor pipeline and AR aging."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim (professional, institutional, dental). Enables payer/service mix analysis."
    - name: "bill_type"
      expr: bill_type
      comment: "UB-04 bill type code grouping institutional claims by facility and frequency."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service where care was rendered. Used to analyze site-of-care revenue."
    - name: "submission_method"
      expr: submission_method
      comment: "How the claim was submitted (electronic, paper). Indicates clearinghouse efficiency."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code for claim denial. Used for root-cause denial management."
    - name: "primary_payer_flag"
      expr: primary_payer_flag
      comment: "Whether this is the primary payer claim. Distinguishes primary vs secondary billing."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_from_date)
      comment: "Service month bucket for trend analysis of clinical activity and revenue."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submitted_timestamp)
      comment: "Month the claim was submitted, for throughput and timely-filing analysis."
  measures:
    - name: "Claim Count"
      expr: COUNT(1)
      comment: "Total number of claims. Baseline volume metric for revenue cycle throughput."
    - name: "Distinct Claims"
      expr: COUNT(DISTINCT claim_id)
      comment: "Distinct claim count for deduplicated volume reporting."
    - name: "Total Billed Amount"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Total charges billed to payers. Top-of-funnel gross revenue indicator."
    - name: "Total Allowed Amount"
      expr: SUM(CAST(total_allowed_amount AS DOUBLE))
      comment: "Total contractually allowed amount. Basis for expected net revenue."
    - name: "Total Paid Amount"
      expr: SUM(CAST(total_paid_amount AS DOUBLE))
      comment: "Total amount paid by payers. Core net collection metric."
    - name: "Total Patient Responsibility"
      expr: SUM(CAST(patient_responsibility_amount AS DOUBLE))
      comment: "Total patient liability. Drives self-pay collection strategy and bad-debt risk."
    - name: "Total Adjustment Amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total contractual and other adjustments. Measures revenue leakage."
    - name: "Avg Billed Amount"
      expr: AVG(CAST(total_billed_amount AS DOUBLE))
      comment: "Average billed amount per claim. Indicates case acuity and charge intensity."
    - name: "Net Collection Rate Pct"
      expr: ROUND(100.0 * SUM(CAST(total_paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_allowed_amount AS DOUBLE)),0),2)
      comment: "Paid divided by allowed. Primary measure of collection effectiveness against contracts."
    - name: "Allowed To Billed Ratio Pct"
      expr: ROUND(100.0 * SUM(CAST(total_allowed_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_billed_amount AS DOUBLE)),0),2)
      comment: "Allowed over billed. Reflects contractual discount intensity and charge-master alignment."
    - name: "Appeal Filed Claim Count"
      expr: SUM(CASE WHEN appeal_filed_flag = true THEN 1 ELSE 0 END)
      comment: "Claims with appeals filed. Indicates denial dispute volume and appeals workload."
    - name: "RAC Audit Claim Count"
      expr: SUM(CASE WHEN rac_audit_flag = true THEN 1 ELSE 0 END)
      comment: "Claims flagged for RAC audit. Compliance and recovery-risk exposure metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_denial`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Denial management KPIs measuring denied dollars, preventability, recovery, and write-off. Steers denial-prevention initiatives and appeals prioritization across the revenue cycle."
  source: "`vibe_healthcare_v1`.`claim`.`denial`"
  dimensions:
    - name: "denial_category"
      expr: denial_category
      comment: "Category of denial (clinical, technical, eligibility). Used to target root-cause workstreams."
    - name: "denial_type"
      expr: denial_type
      comment: "Type of denial (hard, soft). Distinguishes recoverable vs final denials."
    - name: "carc_code"
      expr: carc_code
      comment: "Claim Adjustment Reason Code. Standard payer denial reason for trend analysis."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution state of the denial. Tracks open vs resolved backlog."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department accountable for the denial. Enables departmental accountability."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Identified root cause. Core driver for prevention initiatives."
    - name: "priority_level"
      expr: priority_level
      comment: "Work priority assigned to the denial for appeals queue management."
    - name: "denial_month"
      expr: DATE_TRUNC('MONTH', denial_date)
      comment: "Month the denial was received, for trend monitoring."
  measures:
    - name: "Denial Count"
      expr: COUNT(1)
      comment: "Total number of denials. Baseline denial volume metric."
    - name: "Total Denied Amount"
      expr: SUM(CAST(denied_amount AS DOUBLE))
      comment: "Total dollars denied. Primary revenue-at-risk indicator."
    - name: "Total Recovered Amount"
      expr: SUM(CAST(recovered_amount AS DOUBLE))
      comment: "Total dollars recovered after appeal. Measures appeals effectiveness."
    - name: "Total Write Off Amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total dollars written off from denials. Direct revenue leakage."
    - name: "Recovery Rate Pct"
      expr: ROUND(100.0 * SUM(CAST(recovered_amount AS DOUBLE)) / NULLIF(SUM(CAST(denied_amount AS DOUBLE)),0),2)
      comment: "Recovered over denied. Key appeals-program performance KPI."
    - name: "Preventable Denial Count"
      expr: SUM(CASE WHEN is_preventable = true THEN 1 ELSE 0 END)
      comment: "Count of preventable denials. Directly targets process-improvement opportunity."
    - name: "Preventable Denial Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_preventable = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Share of denials that were preventable. Steers denial-prevention investment."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_remittance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payer remittance (ERA/835) KPIs tracking payment posting, adjustments, and reconciliation status to steer cash posting efficiency and payer payment behavior."
  source: "`vibe_healthcare_v1`.`claim`.`remittance`"
  dimensions:
    - name: "remittance_status"
      expr: remittance_status
      comment: "Status of the remittance advice. Tracks posting pipeline."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation state of the remittance against expected payments."
    - name: "payment_method_code"
      expr: payment_method_code
      comment: "Payment method (EFT, check). Indicates payer payment channel mix."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month payment was made, for cash trend analysis."
  measures:
    - name: "Remittance Count"
      expr: COUNT(1)
      comment: "Total remittance advices received. Baseline posting volume."
    - name: "Total Payment Amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total cash received via remittances. Core cash-posting KPI."
    - name: "Total Billed On Remittance"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Total billed amount referenced on remittances for variance analysis."
    - name: "Total Allowed On Remittance"
      expr: SUM(CAST(total_allowed_amount AS DOUBLE))
      comment: "Total allowed amount on remittances. Basis for payment variance checks."
    - name: "Total Adjustment On Remittance"
      expr: SUM(CAST(total_adjustment_amount AS DOUBLE))
      comment: "Total adjustments on remittances. Measures contractual write-down volume."
    - name: "Payment Yield Pct"
      expr: ROUND(100.0 * SUM(CAST(payment_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_billed_amount AS DOUBLE)),0),2)
      comment: "Payment over billed. Indicates effective payer reimbursement rate."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_appeal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim appeal KPIs measuring overturn dollars, success, and appeals throughput across levels to steer appeals strategy and payer dispute resolution."
  source: "`vibe_healthcare_v1`.`claim`.`appeal`"
  dimensions:
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal. Tracks open vs resolved appeals."
    - name: "appeal_type"
      expr: appeal_type
      comment: "Type of appeal filed. Enables categorization of dispute strategy."
    - name: "appeal_level"
      expr: appeal_level
      comment: "Appeal escalation level (first, second, external). Tracks escalation patterns."
    - name: "outcome_code"
      expr: outcome_code
      comment: "Outcome of the appeal. Used to compute win/loss rates."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Underlying denial reason being appealed for root-cause analysis."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the appeal was submitted, for throughput trending."
  measures:
    - name: "Appeal Count"
      expr: COUNT(1)
      comment: "Total appeals filed. Baseline appeals workload metric."
    - name: "Total Denied Amount"
      expr: SUM(CAST(denied_amount AS DOUBLE))
      comment: "Total dollars under appeal. Revenue-at-stake metric."
    - name: "Total Overturn Amount"
      expr: SUM(CAST(overturn_amount AS DOUBLE))
      comment: "Total dollars overturned in favor of provider. Appeals value recovered."
    - name: "Total Requested Amount"
      expr: SUM(CAST(requested_amount AS DOUBLE))
      comment: "Total amount requested in appeals for recovery-target tracking."
    - name: "Overturn Rate Pct"
      expr: ROUND(100.0 * SUM(CAST(overturn_amount AS DOUBLE)) / NULLIF(SUM(CAST(denied_amount AS DOUBLE)),0),2)
      comment: "Overturned over denied. Primary appeals-success KPI steering appeals investment."
    - name: "Peer Review Required Count"
      expr: SUM(CASE WHEN peer_review_required_flag = true THEN 1 ELSE 0 END)
      comment: "Appeals requiring peer review. Indicates clinical-review resource demand."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim submission KPIs tracking timely filing, rejection, and resubmission to steer front-end claim quality and clearinghouse performance."
  source: "`vibe_healthcare_v1`.`claim`.`submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Status of the claim submission. Tracks accepted vs rejected."
    - name: "submission_type"
      expr: submission_type
      comment: "Type of submission (original, corrected, void). Categorizes filing activity."
    - name: "acknowledgment_status"
      expr: acknowledgment_status
      comment: "Clearinghouse/payer acknowledgment status for tracking accepted submissions."
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Reason for submission rejection. Drives front-end edit improvements."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of submission for throughput trending."
  measures:
    - name: "Submission Count"
      expr: COUNT(1)
      comment: "Total submissions. Baseline front-end claim volume."
    - name: "Distinct Claims Submitted"
      expr: COUNT(DISTINCT claim_id)
      comment: "Distinct claims submitted. Deduplicated submission volume."
    - name: "Total Charge Amount Submitted"
      expr: SUM(CAST(claim_charge_amount AS DOUBLE))
      comment: "Total charge amount submitted to payers. Submission dollar volume."
    - name: "Timely Filed Count"
      expr: SUM(CASE WHEN is_timely_filed = true THEN 1 ELSE 0 END)
      comment: "Submissions filed within payer deadlines. Avoids timely-filing write-offs."
    - name: "Timely Filing Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_timely_filed = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0),2)
      comment: "Share of submissions filed timely. Key compliance KPI preventing avoidable write-offs."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_prior_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization KPIs tracking approval rates, denials, and units to steer utilization management and reduce auth-related denials."
  source: "`vibe_healthcare_v1`.`claim`.`prior_authorization`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Status of the prior authorization request (approved, denied, pending)."
    - name: "payer_type"
      expr: payer_type
      comment: "Payer type for the authorization. Enables payer-mix auth analysis."
    - name: "service_setting"
      expr: service_setting
      comment: "Setting where authorized service occurs (inpatient, outpatient)."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency of the authorization request. Tracks expedited vs routine."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month the authorization decision was made, for trend monitoring."
  measures:
    - name: "Authorization Count"
      expr: COUNT(1)
      comment: "Total prior authorization requests. Baseline auth volume."
    - name: "Total Requested Units"
      expr: SUM(CAST(requested_units AS DOUBLE))
      comment: "Total units requested. Drives utilization-management capacity planning."
    - name: "Total Approved Units"
      expr: SUM(CAST(approved_units AS DOUBLE))
      comment: "Total units approved. Measures granted service capacity."
    - name: "Unit Approval Rate Pct"
      expr: ROUND(100.0 * SUM(CAST(approved_units AS DOUBLE)) / NULLIF(SUM(CAST(requested_units AS DOUBLE)),0),2)
      comment: "Approved over requested units. Indicates payer approval generosity and denial risk."
    - name: "Appeal Filed Count"
      expr: SUM(CASE WHEN appeal_filed_flag = true THEN 1 ELSE 0 END)
      comment: "Authorizations escalated to appeal. Indicates dispute and workflow burden."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim line-level KPIs giving granular billed vs paid analysis by procedure to steer charge accuracy and line-level denial management."
  source: "`vibe_healthcare_v1`.`claim`.`line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the claim line for line-level adjudication tracking."
    - name: "procedure_code"
      expr: procedure_code
      comment: "Procedure/CPT code billed on the line. Enables procedure-level revenue analysis."
    - name: "revenue_code"
      expr: revenue_code
      comment: "Revenue code categorizing the service for institutional billing analysis."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service for the line. Site-of-care line revenue analysis."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Line-level denial reason for granular root-cause analysis."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_from_date)
      comment: "Service month for the line, for revenue trending."
  measures:
    - name: "Line Count"
      expr: COUNT(1)
      comment: "Total claim lines. Baseline line-volume metric."
    - name: "Total Billed Amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total billed at line level. Granular charge volume."
    - name: "Total Allowed Amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total allowed at line level. Basis for line-level expected revenue."
    - name: "Total Paid Amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total paid at line level. Granular net collection."
    - name: "Total Units Of Service"
      expr: SUM(CAST(units_of_service AS DOUBLE))
      comment: "Total service units billed. Drives volume-based productivity analysis."
    - name: "Line Net Collection Rate Pct"
      expr: ROUND(100.0 * SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(allowed_amount AS DOUBLE)),0),2)
      comment: "Paid over allowed at line level. Pinpoints under-collection by procedure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_eligibility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Eligibility verification KPIs tracking coverage confirmation and patient cost-sharing to steer front-end registration accuracy and reduce eligibility denials."
  source: "`vibe_healthcare_v1`.`claim`.`eligibility`"
  dimensions:
    - name: "coverage_status"
      expr: coverage_status
      comment: "Coverage status returned by the payer (active, inactive). Front-end risk indicator."
    - name: "verification_status"
      expr: verification_status
      comment: "Status of the eligibility verification transaction."
    - name: "network_status"
      expr: network_status
      comment: "In/out-of-network status. Drives network-steerage and patient-cost analysis."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage verified. Enables payer-product mix analysis."
    - name: "verification_month"
      expr: DATE_TRUNC('MONTH', verification_date)
      comment: "Month of verification for trend monitoring."
  measures:
    - name: "Eligibility Check Count"
      expr: COUNT(1)
      comment: "Total eligibility verifications. Baseline front-end verification volume."
    - name: "Avg Deductible Remaining"
      expr: AVG(CAST(deductible_remaining_amount AS DOUBLE))
      comment: "Average remaining deductible. Estimates patient out-of-pocket exposure."
    - name: "Avg Out Of Pocket Maximum"
      expr: AVG(CAST(out_of_pocket_maximum AS DOUBLE))
      comment: "Average out-of-pocket max. Informs patient financial counseling."
    - name: "Avg Copay Amount"
      expr: AVG(CAST(copay_amount AS DOUBLE))
      comment: "Average copay per verification. Patient cost-sharing benchmark."
    - name: "Prior Auth Required Count"
      expr: SUM(CASE WHEN prior_authorization_required = true THEN 1 ELSE 0 END)
      comment: "Verifications requiring prior auth. Front-end auth-workflow trigger volume."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_cob`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "COB financial distribution metrics"
  source: "`vibe_healthcare_v1`.`claim`.`cob`"
  dimensions:
    - name: "cob_status"
      expr: cob_status
      comment: "Current status of the COB process"
    - name: "determination_method"
      expr: determination_method
      comment: "Method used to determine COB"
    - name: "cob_month"
      expr: DATE_TRUNC('month', determination_date)
      comment: "Month of COB determination"
  measures:
    - name: "total_primary_paid_amount"
      expr: SUM(CAST(primary_paid_amount AS DOUBLE))
      comment: "Sum of primary payer paid amounts"
    - name: "total_secondary_paid_amount"
      expr: SUM(CAST(secondary_paid_amount AS DOUBLE))
      comment: "Sum of secondary payer paid amounts"
    - name: "total_tertiary_paid_amount"
      expr: SUM(CAST(tertiary_paid_amount AS DOUBLE))
      comment: "Sum of tertiary payer paid amounts"
    - name: "cob_record_count"
      expr: COUNT(1)
      comment: "Number of coordination of benefits (COB) records"
$$;