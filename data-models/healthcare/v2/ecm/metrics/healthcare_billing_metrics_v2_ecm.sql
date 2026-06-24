-- Metric views for domain: billing | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 14:47:42

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue cycle charge capture KPIs covering gross charges, expected reimbursement, and charge integrity. Used by revenue cycle leadership to monitor charge capture completeness and pricing realization."
  source: "`vibe_healthcare_v1`.`billing`.`charge`"
  dimensions:
    - name: "charge_category"
      expr: charge_category
      comment: "Category of charge (e.g., room, supply, procedure) for revenue mix analysis."
    - name: "charge_status"
      expr: charge_status
      comment: "Lifecycle status of the charge (held, released, posted) used to monitor charge throughput."
    - name: "charge_type"
      expr: charge_type
      comment: "Type classification of the charge for service-line segmentation."
    - name: "revenue_code"
      expr: revenue_code
      comment: "UB-04 revenue code used for departmental revenue reporting."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service for outpatient vs inpatient charge analysis."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Service month for charge volume trending."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Posting month for revenue recognition timing analysis."
  measures:
    - name: "Charge Count"
      expr: COUNT(1)
      comment: "Total number of charge records, a base volume measure for charge capture throughput."
    - name: "Total Gross Charges"
      expr: SUM(CAST(gross_charge_amount AS DOUBLE))
      comment: "Total gross charge dollars billed, the top-line revenue cycle indicator."
    - name: "Total Expected Reimbursement"
      expr: SUM(CAST(expected_reimbursement_amount AS DOUBLE))
      comment: "Total expected reimbursement, used to assess net realizable revenue vs gross charges."
    - name: "Avg Gross Charge"
      expr: AVG(CAST(gross_charge_amount AS DOUBLE))
      comment: "Average gross charge per line, useful for pricing and case-mix monitoring."
    - name: "Voided Charge Count"
      expr: COUNT(CASE WHEN is_voided = true THEN 1 END)
      comment: "Count of voided charges, a charge-integrity and rework indicator."
    - name: "Corrected Charge Count"
      expr: COUNT(CASE WHEN is_corrected = true THEN 1 END)
      comment: "Count of corrected charges, signals charge capture accuracy issues."
    - name: "Total Quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total billed quantity across charges, supports utilization analysis."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice/claim-level financial KPIs for net revenue, contractual adjustments, denials, and AR. Used in revenue cycle steering reviews."
  source: "`vibe_healthcare_v1`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Status of the invoice (open, paid, denied) for AR pipeline analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (inpatient, outpatient, professional) for service-line segmentation."
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status driving follow-up workflow prioritization."
    - name: "bill_type_code"
      expr: bill_type_code
      comment: "UB-04 bill type code for regulatory and payer-mix reporting."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Denial reason code used for denial root-cause analysis."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Invoice month for revenue trending."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Submission month for billing lag and cash flow analysis."
  measures:
    - name: "Invoice Count"
      expr: COUNT(1)
      comment: "Total invoices, base volume for billing throughput."
    - name: "Total Charges"
      expr: SUM(CAST(total_charges AS DOUBLE))
      comment: "Total billed charges across invoices, gross revenue indicator."
    - name: "Total Allowed Amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total payer-allowed amount, the net realizable revenue baseline."
    - name: "Total Insurance Payment"
      expr: SUM(CAST(insurance_payment AS DOUBLE))
      comment: "Total insurance payments collected, core cash realization measure."
    - name: "Total Patient Payment"
      expr: SUM(CAST(patient_payment AS DOUBLE))
      comment: "Total patient payments, monitors patient self-pay collection performance."
    - name: "Total Contractual Adjustment"
      expr: SUM(CAST(contractual_adjustment AS DOUBLE))
      comment: "Total contractual adjustments, quantifies revenue lost to payer contracts."
    - name: "Total Outstanding Balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding AR balance, primary days-in-AR and cash-flow driver."
    - name: "Total Bad Debt Amount"
      expr: SUM(CAST(bad_debt_amount AS DOUBLE))
      comment: "Total bad debt written off, a financial risk and net revenue erosion indicator."
    - name: "Denied Invoice Count"
      expr: COUNT(CASE WHEN denial_reason_code IS NOT NULL THEN 1 END)
      comment: "Count of denied invoices, drives denial-management intervention."
    - name: "Avg Outstanding Balance"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average outstanding balance per invoice, supports AR aging assessment."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash posting and payment KPIs measuring collections, applied/unapplied cash, refunds, and reversals. Used to monitor cash flow and posting quality."
  source: "`vibe_healthcare_v1`.`billing`.`payment`"
  dimensions:
    - name: "payment_category"
      expr: payment_category
      comment: "Category of payment (insurance, patient, etc.) for collection mix analysis."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment for cash composition reporting."
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the payment for posting workflow monitoring."
    - name: "method"
      expr: method
      comment: "Payment method (EFT, check, card) for cash channel analysis."
    - name: "channel"
      expr: channel
      comment: "Payment channel for self-service vs back-office collection insight."
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status for cash-application backlog monitoring."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Payment month for cash trending."
  measures:
    - name: "Payment Count"
      expr: COUNT(1)
      comment: "Total payment transactions, base volume for cash posting throughput."
    - name: "Total Payment Amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total payment dollars received, primary cash collection measure."
    - name: "Total Applied Amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total payment dollars applied to accounts, measures cash-application completion."
    - name: "Total Unapplied Amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total unapplied cash, a cash-posting backlog and risk indicator."
    - name: "Total Refund Amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refunds issued, monitors overpayment and refund liability."
    - name: "Reversed Payment Count"
      expr: COUNT(CASE WHEN reversal_flag = true THEN 1 END)
      comment: "Count of reversed payments, a posting-accuracy and rework indicator."
    - name: "Avg Payment Amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment size, supports payer remittance pattern analysis."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adjustment KPIs covering contractual, write-off, and reversal adjustments. Used to quantify revenue leakage and adjustment behavior."
  source: "`vibe_healthcare_v1`.`billing`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment for revenue-leakage classification."
    - name: "adjustment_category"
      expr: adjustment_category
      comment: "Adjustment category for grouping contractual vs administrative adjustments."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Status of adjustment for processing workflow monitoring."
    - name: "reason_code"
      expr: reason_code
      comment: "Adjustment reason code for root-cause analysis."
    - name: "write_off_classification"
      expr: write_off_classification
      comment: "Write-off classification for bad debt vs charity segmentation."
    - name: "adjustment_month"
      expr: DATE_TRUNC('MONTH', adjustment_date)
      comment: "Adjustment month for trending revenue concessions."
  measures:
    - name: "Adjustment Count"
      expr: COUNT(1)
      comment: "Total adjustment records, base volume measure."
    - name: "Total Adjustment Amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total adjustment dollars, quantifies revenue reductions affecting net revenue."
    - name: "Total Contract Rate"
      expr: SUM(CAST(contract_rate AS DOUBLE))
      comment: "Total contracted rate amount, supports contract realization analysis."
    - name: "Reversed Adjustment Count"
      expr: COUNT(CASE WHEN reversal_flag = true THEN 1 END)
      comment: "Count of reversed adjustments, an accuracy/rework indicator."
    - name: "Appealed Adjustment Count"
      expr: COUNT(CASE WHEN appeal_flag = true THEN 1 END)
      comment: "Count of adjustments under appeal, monitors recovery opportunity."
    - name: "Avg Adjustment Amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average adjustment size, supports payer concession monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_collection_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collections and bad debt recovery KPIs measuring outstanding balances, recovery, settlements, and write-offs. Used by collections leadership."
  source: "`vibe_healthcare_v1`.`billing`.`collection_account`"
  dimensions:
    - name: "collection_status"
      expr: collection_status
      comment: "Status of the collection account for recovery pipeline monitoring."
    - name: "collection_type"
      expr: collection_type
      comment: "Type of collection (in-house, agency) for channel performance analysis."
    - name: "collection_agency_name"
      expr: collection_agency_name
      comment: "Collection agency name for agency performance comparison."
    - name: "aging_days"
      expr: aging_days
      comment: "Aging bucket of the account for delinquency analysis."
    - name: "referral_month"
      expr: DATE_TRUNC('MONTH', referral_date)
      comment: "Referral month for collections cohort trending."
  measures:
    - name: "Collection Account Count"
      expr: COUNT(1)
      comment: "Total collection accounts, base volume of accounts in collections."
    - name: "Total Outstanding Balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total balance in collections, the recovery exposure measure."
    - name: "Total Recovered Amount"
      expr: SUM(CAST(recovered_amount AS DOUBLE))
      comment: "Total amount recovered, the core collections performance measure."
    - name: "Total Settlement Amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement dollars, monitors negotiated recovery concessions."
    - name: "Total Write Off Amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total write-offs from collections, quantifies uncollectable losses."
    - name: "Total Collection Fee"
      expr: SUM(CAST(collection_fee_amount AS DOUBLE))
      comment: "Total collection fees, supports cost-to-collect analysis."
    - name: "Legal Action Account Count"
      expr: COUNT(CASE WHEN legal_action_flag = true THEN 1 END)
      comment: "Count of accounts in legal action, a high-cost escalation indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_patient_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient account financial health KPIs covering balances, payments, bad debt, and financial assistance. Used to monitor patient AR and self-pay performance."
  source: "`vibe_healthcare_v1`.`billing`.`patient_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Status of the patient account for portfolio monitoring."
    - name: "account_type"
      expr: account_type
      comment: "Type of patient account for segmentation."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket for patient AR delinquency analysis."
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status for self-pay follow-up prioritization."
    - name: "financial_assistance_eligibility"
      expr: financial_assistance_eligibility
      comment: "Financial assistance eligibility for charity vs self-pay segmentation."
  measures:
    - name: "Patient Account Count"
      expr: COUNT(1)
      comment: "Total patient accounts, base portfolio volume."
    - name: "Total Account Balance"
      expr: SUM(CAST(account_balance AS DOUBLE))
      comment: "Total patient account balance, primary patient AR exposure measure."
    - name: "Total Patient Balance"
      expr: SUM(CAST(patient_balance AS DOUBLE))
      comment: "Total patient-responsible balance, drives self-pay collection strategy."
    - name: "Total Insurance Balance"
      expr: SUM(CAST(insurance_balance AS DOUBLE))
      comment: "Total insurance-pending balance, monitors payer follow-up exposure."
    - name: "Total Payments"
      expr: SUM(CAST(total_payments AS DOUBLE))
      comment: "Total payments received on accounts, cash realization measure."
    - name: "Total Bad Debt Amount"
      expr: SUM(CAST(bad_debt_amount AS DOUBLE))
      comment: "Total bad debt on accounts, a financial risk indicator."
    - name: "Total Recovered Amount"
      expr: SUM(CAST(recovered_amount AS DOUBLE))
      comment: "Total recovered amount, measures bad-debt recovery effectiveness."
    - name: "Bad Debt Account Count"
      expr: COUNT(CASE WHEN bad_debt_flag = true THEN 1 END)
      comment: "Count of accounts flagged bad debt, drives recovery and policy action."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_write_off`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Write-off KPIs quantifying revenue leakage by category, recovery, and appeals. Used by finance to monitor net revenue erosion."
  source: "`vibe_healthcare_v1`.`billing`.`write_off`"
  dimensions:
    - name: "write_off_type"
      expr: write_off_type
      comment: "Type of write-off for revenue leakage classification."
    - name: "write_off_category"
      expr: write_off_category
      comment: "Write-off category for contractual vs bad debt vs charity segmentation."
    - name: "write_off_status"
      expr: write_off_status
      comment: "Status of write-off for approval workflow monitoring."
    - name: "reason_code"
      expr: reason_code
      comment: "Write-off reason code for root-cause analysis."
    - name: "write_off_month"
      expr: DATE_TRUNC('MONTH', write_off_date)
      comment: "Write-off month for trending revenue losses."
  measures:
    - name: "Write Off Count"
      expr: COUNT(1)
      comment: "Total write-off records, base volume measure."
    - name: "Total Write Off Amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total write-off dollars, primary measure of net revenue erosion."
    - name: "Total Original Balance"
      expr: SUM(CAST(original_balance AS DOUBLE))
      comment: "Total original balance written off, supports leakage-rate analysis."
    - name: "Total Remaining Balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Total remaining balance after write-off, monitors residual exposure."
    - name: "Reversed Write Off Count"
      expr: COUNT(CASE WHEN reversal_flag = true THEN 1 END)
      comment: "Count of reversed write-offs, an accuracy/recovery indicator."
    - name: "Appealed Write Off Count"
      expr: COUNT(CASE WHEN appeal_flag = true THEN 1 END)
      comment: "Count of write-offs under appeal, monitors recovery opportunity."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_charity_care_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Charity care / financial assistance KPIs measuring application volume, approval rates, and discounts. Used for IRS 501(r) compliance and community benefit reporting."
  source: "`vibe_healthcare_v1`.`billing`.`charity_care_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Status of the charity care application for processing pipeline monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for charity determination outcome analysis."
    - name: "program_type"
      expr: program_type
      comment: "Charity program type for community benefit segmentation."
    - name: "application_source"
      expr: application_source
      comment: "Source of application for intake channel analysis."
    - name: "application_month"
      expr: DATE_TRUNC('MONTH', application_date)
      comment: "Application month for charity care demand trending."
  measures:
    - name: "Application Count"
      expr: COUNT(1)
      comment: "Total charity care applications, base demand volume."
    - name: "Approved Application Count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Count of approved applications, the core charity approval measure."
    - name: "Denied Application Count"
      expr: COUNT(CASE WHEN denial_date IS NOT NULL THEN 1 END)
      comment: "Count of denied applications, monitors access-to-assistance outcomes."
    - name: "Presumptive Eligible Count"
      expr: COUNT(CASE WHEN presumptive_eligibility_flag = true THEN 1 END)
      comment: "Count of presumptively eligible applications, supports 501(r) workflow analysis."
    - name: "Avg Approved Discount Pct"
      expr: AVG(CAST(approved_discount_percentage AS DOUBLE))
      comment: "Average approved discount percentage, quantifies assistance generosity."
    - name: "Avg Household Income"
      expr: AVG(CAST(household_income AS DOUBLE))
      comment: "Average applicant household income, supports eligibility distribution analysis."
    - name: "Avg FPL Percentage"
      expr: AVG(CAST(fpl_percentage AS DOUBLE))
      comment: "Average federal poverty level percentage, supports community need assessment."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_payment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient payment plan KPIs measuring enrollment, balances, defaults, and completion. Used to monitor patient financing program performance."
  source: "`vibe_healthcare_v1`.`billing`.`payment_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the payment plan for portfolio monitoring."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of payment plan for program segmentation."
    - name: "installment_frequency"
      expr: installment_frequency
      comment: "Installment frequency for cash-flow pattern analysis."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Enrollment channel for plan acquisition analysis."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Enrollment month for payment plan cohort trending."
  measures:
    - name: "Payment Plan Count"
      expr: COUNT(1)
      comment: "Total payment plans, base enrollment volume."
    - name: "Total Plan Amount"
      expr: SUM(CAST(total_plan_amount AS DOUBLE))
      comment: "Total financed plan amount, the program exposure measure."
    - name: "Total Paid Amount"
      expr: SUM(CAST(total_paid_amount AS DOUBLE))
      comment: "Total amount paid against plans, the realization measure."
    - name: "Total Remaining Balance"
      expr: SUM(CAST(remaining_balance_amount AS DOUBLE))
      comment: "Total remaining plan balance, monitors outstanding exposure."
    - name: "Defaulted Plan Count"
      expr: COUNT(CASE WHEN default_date IS NOT NULL THEN 1 END)
      comment: "Count of defaulted plans, a delinquency and risk indicator."
    - name: "Avg Installment Amount"
      expr: AVG(CAST(installment_amount AS DOUBLE))
      comment: "Average installment amount, supports affordability and cash-flow analysis."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_rac_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RAC/payer audit KPIs measuring overpayment findings, recoupment, and appeal outcomes. Used by compliance and revenue integrity leadership."
  source: "`vibe_healthcare_v1`.`billing`.`rac_audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Status of the audit for audit pipeline monitoring."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit for risk segmentation."
    - name: "finding_type"
      expr: finding_type
      comment: "Type of audit finding for risk classification."
    - name: "contractor_name"
      expr: contractor_name
      comment: "Audit contractor name for contractor exposure comparison."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Appeal status for recovery outcome monitoring."
    - name: "audit_request_month"
      expr: DATE_TRUNC('MONTH', audit_request_date)
      comment: "Audit request month for audit-activity trending."
  measures:
    - name: "Audit Count"
      expr: COUNT(1)
      comment: "Total RAC audits, base audit activity volume."
    - name: "Total Finding Amount"
      expr: SUM(CAST(finding_amount AS DOUBLE))
      comment: "Total audit finding dollars, the primary revenue-risk exposure measure."
    - name: "Total Overpayment Amount"
      expr: SUM(CAST(overpayment_amount AS DOUBLE))
      comment: "Total identified overpayments, drives recoupment and compliance action."
    - name: "Total Recoupment Amount"
      expr: SUM(CAST(recoupment_amount AS DOUBLE))
      comment: "Total recouped dollars, quantifies realized revenue loss from audits."
    - name: "Total Appeal Outcome Amount"
      expr: SUM(CAST(appeal_outcome_amount AS DOUBLE))
      comment: "Total amount recovered through appeals, measures appeal effectiveness."
    - name: "Appealed Audit Count"
      expr: COUNT(CASE WHEN appeal_filed_flag = true THEN 1 END)
      comment: "Count of audits appealed, monitors defense activity."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice line-level reimbursement KPIs covering charges, allowed, paid, contractual adjustments, and patient responsibility. Used for service-line and payer realization analysis."
  source: "`vibe_healthcare_v1`.`billing`.`invoice_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the invoice line for adjudication monitoring."
    - name: "revenue_code"
      expr: revenue_code
      comment: "Revenue code for departmental reimbursement analysis."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Line-level denial reason for denial root-cause analysis."
    - name: "claim_adjustment_reason_code"
      expr: claim_adjustment_reason_code
      comment: "Claim adjustment reason code (CARC) for payer adjustment analysis."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Service month for line-level revenue trending."
  measures:
    - name: "Invoice Line Count"
      expr: COUNT(1)
      comment: "Total invoice lines, base volume of billed services."
    - name: "Total Charge Amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total line charges, gross revenue at the service line level."
    - name: "Total Allowed Amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total allowed amount, the net realizable revenue baseline by line."
    - name: "Total Paid Amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total paid amount, the cash realization measure by line."
    - name: "Total Contractual Adjustment"
      expr: SUM(CAST(contractual_adjustment_amount AS DOUBLE))
      comment: "Total contractual adjustments, quantifies payer concessions by line."
    - name: "Total Patient Responsibility"
      expr: SUM(CAST(patient_responsibility_amount AS DOUBLE))
      comment: "Total patient responsibility, drives self-pay collection strategy."
    - name: "Denied Line Count"
      expr: COUNT(CASE WHEN denial_reason_code IS NOT NULL THEN 1 END)
      comment: "Count of denied lines, drives line-level denial management."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_cdm_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chargemaster KPIs covering price, cost, and RVU benchmarking for pricing strategy and price transparency compliance."
  source: "`vibe_healthcare_v1`.`billing`.`cdm_entry`"
  dimensions:
    - name: "charge_category"
      expr: charge_category
      comment: "Charge category for chargemaster segmentation."
    - name: "item_type"
      expr: item_type
      comment: "Item type for chargemaster line classification."
    - name: "revenue_code"
      expr: revenue_code
      comment: "Revenue code for departmental pricing analysis."
    - name: "apc_code"
      expr: apc_code
      comment: "APC code for outpatient prospective payment grouping."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for departmental margin analysis."
  measures:
    - name: "CDM Entry Count"
      expr: COUNT(1)
      comment: "Total chargemaster entries, base catalog volume."
    - name: "Avg Charge Amount"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average chargemaster price, supports pricing strategy and benchmarking."
    - name: "Avg Cost Amount"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average item cost, supports cost-to-charge and margin analysis."
    - name: "Total Work RVU"
      expr: SUM(CAST(rvu_work AS DOUBLE))
      comment: "Total work RVUs across the chargemaster, supports productivity benchmarking."
    - name: "Price Transparency Item Count"
      expr: COUNT(CASE WHEN price_transparency_flag = true THEN 1 END)
      comment: "Count of price-transparency-flagged items, monitors CMS transparency compliance."
    - name: "Active Item Count"
      expr: COUNT(CASE WHEN active_flag = true THEN 1 END)
      comment: "Count of active chargemaster items, monitors catalog currency."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Refund KPIs measuring overpayment refund volume, dollars, CMS credit balance compliance, and reconciliation. Used by finance and compliance."
  source: "`vibe_healthcare_v1`.`billing`.`refund`"
  dimensions:
    - name: "refund_status"
      expr: refund_status
      comment: "Status of the refund for processing pipeline monitoring."
    - name: "refund_type"
      expr: refund_type
      comment: "Type of refund for classification."
    - name: "refund_category"
      expr: refund_category
      comment: "Refund category for root-cause segmentation."
    - name: "reason_code"
      expr: reason_code
      comment: "Refund reason code for analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status for refund close-out monitoring."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Refund request month for trending."
  measures:
    - name: "Refund Count"
      expr: COUNT(1)
      comment: "Total refunds, base volume measure."
    - name: "Total Refund Amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total refund dollars issued, the refund liability measure."
    - name: "CMS Credit Balance Refund Count"
      expr: COUNT(CASE WHEN cms_credit_balance_report_flag = true THEN 1 END)
      comment: "Count of CMS credit balance refunds, monitors regulatory reporting compliance."
    - name: "Voided Refund Count"
      expr: COUNT(CASE WHEN void_flag = true THEN 1 END)
      comment: "Count of voided refunds, an accuracy/rework indicator."
    - name: "Avg Refund Amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average refund size, supports overpayment pattern analysis."
$$;