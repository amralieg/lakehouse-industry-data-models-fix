-- Metric views for domain: billing | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 18:58:55

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`billing_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Charge-level KPIs tracking gross revenue capture, billability, expected reimbursement, and charge correction quality across service lines and care sites. Core operational finance view for revenue integrity teams."
  source: "`healthcare_ecm`.`billing`.`charge`"
  dimensions:
    - name: "charge_category"
      expr: charge_category
      comment: "Clinical or administrative category of the charge (e.g., pharmacy, lab, room & board) for revenue segmentation."
    - name: "charge_type"
      expr: charge_type
      comment: "Type classification of the charge (e.g., professional, facility, ancillary) used for payer contract analysis."
    - name: "charge_status"
      expr: charge_status
      comment: "Current workflow status of the charge (e.g., posted, held, voided) to monitor charge capture pipeline health."
    - name: "revenue_code"
      expr: revenue_code
      comment: "UB-04 revenue code associated with the charge, used for payer billing and revenue categorization."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "CMS place-of-service code indicating the setting where the service was rendered (e.g., inpatient, outpatient, office)."
    - name: "is_billable"
      expr: is_billable
      comment: "Flag indicating whether the charge is eligible for billing to a payer or patient."
    - name: "is_voided"
      expr: is_voided
      comment: "Flag indicating the charge has been voided, used to exclude invalid charges from revenue calculations."
    - name: "is_corrected"
      expr: is_corrected
      comment: "Flag indicating the charge was corrected after initial posting, a signal of charge capture quality issues."
    - name: "service_date"
      expr: DATE_TRUNC('month', service_date)
      comment: "Month of service date, used for trending gross charges and reimbursement over time."
    - name: "posting_date"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month charges were posted to the billing system, used to measure charge lag and capture timeliness."
    - name: "modifier_1"
      expr: modifier_1
      comment: "Primary CPT modifier applied to the charge, affecting reimbursement rates and medical necessity."
  measures:
    - name: "total_gross_charge_amount"
      expr: SUM(CAST(gross_charge_amount AS DOUBLE))
      comment: "Total gross charges billed before adjustments, contractual allowances, or payments. Primary top-line revenue capture metric."
    - name: "total_expected_reimbursement"
      expr: SUM(CAST(expected_reimbursement_amount AS DOUBLE))
      comment: "Sum of expected reimbursement amounts across all charges, representing anticipated net revenue after contractual adjustments."
    - name: "avg_gross_charge_per_encounter"
      expr: AVG(CAST(gross_charge_amount AS DOUBLE))
      comment: "Average gross charge amount per charge record, used to benchmark charge intensity and detect outliers."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across all charges, used to monitor CDM pricing consistency and fee schedule alignment."
    - name: "total_charge_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total units of service charged, used to normalize revenue metrics and assess service volume."
    - name: "billable_charge_count"
      expr: COUNT(CASE WHEN is_billable = TRUE THEN charge_id END)
      comment: "Count of charges flagged as billable, indicating the volume of revenue-generating activity submitted for reimbursement."
    - name: "voided_charge_count"
      expr: COUNT(CASE WHEN is_voided = TRUE THEN charge_id END)
      comment: "Count of voided charges, a key revenue integrity metric indicating charge capture errors or late cancellations."
    - name: "corrected_charge_count"
      expr: COUNT(CASE WHEN is_corrected = TRUE THEN charge_id END)
      comment: "Count of corrected charges, indicating rework volume and charge capture quality issues that may delay reimbursement."
    - name: "held_charge_count"
      expr: COUNT(CASE WHEN charge_status = 'HELD' THEN charge_id END)
      comment: "Count of charges currently on hold, representing revenue at risk due to billing edits, missing information, or compliance holds."
    - name: "total_gross_charge_on_hold"
      expr: SUM(CASE WHEN charge_status = 'HELD' THEN CAST(gross_charge_amount AS DOUBLE) ELSE 0 END)
      comment: "Total gross charge dollars currently on hold, quantifying the financial impact of the charge hold queue on cash flow."
    - name: "reimbursement_capture_rate"
      expr: ROUND(100.0 * SUM(CAST(expected_reimbursement_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_charge_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of expected reimbursement to gross charges (%), measuring how much of billed charges are anticipated to be collected — a core revenue yield metric."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice-level financial performance metrics covering total charges, collections, outstanding balances, contractual adjustments, and denial activity. Primary view for AR management, payer performance, and revenue cycle leadership."
  source: "`healthcare_ecm`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g., submitted, paid, denied, appealed) for AR pipeline monitoring."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., professional, institutional, self-pay) for segmenting revenue cycle performance."
    - name: "bill_type_code"
      expr: bill_type_code
      comment: "UB-04 bill type code indicating facility type and claim frequency, used for payer-specific billing analysis."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "CMS place-of-service code for the invoice, enabling revenue analysis by care setting."
    - name: "collection_status"
      expr: collection_status
      comment: "Collection workflow status of the invoice (e.g., active, referred, written-off) for AR aging and collections management."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any payer appeal associated with the invoice, used to track denial reversal rates and appeal effectiveness."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Payer denial reason code, used to identify systemic denial patterns and prioritize denial management efforts."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the invoice to the payer (e.g., electronic, paper), used to assess submission efficiency."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month the invoice was generated, used for trending revenue cycle volume and financial performance over time."
    - name: "service_from_date_month"
      expr: DATE_TRUNC('month', service_from_date)
      comment: "Month of service start date, used to align revenue recognition with clinical activity periods."
    - name: "submission_date_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month the invoice was submitted to the payer, used to measure claim submission timeliness."
    - name: "form_type"
      expr: form_type
      comment: "Claim form type (e.g., CMS-1500, UB-04) indicating the billing format used, relevant for payer and regulatory compliance."
  measures:
    - name: "total_charges"
      expr: SUM(CAST(total_charges AS DOUBLE))
      comment: "Total gross charges across all invoices, the primary top-line revenue metric for the revenue cycle."
    - name: "total_covered_charges"
      expr: SUM(CAST(covered_charges AS DOUBLE))
      comment: "Total charges covered by insurance, indicating the payer-eligible portion of billed revenue."
    - name: "total_non_covered_charges"
      expr: SUM(CAST(non_covered_charges AS DOUBLE))
      comment: "Total charges not covered by insurance, representing patient responsibility or write-off exposure."
    - name: "total_insurance_payment"
      expr: SUM(CAST(insurance_payment AS DOUBLE))
      comment: "Total payments received from insurance payers, the primary cash collection metric for payer performance management."
    - name: "total_patient_payment"
      expr: SUM(CAST(patient_payment AS DOUBLE))
      comment: "Total payments received directly from patients, used to monitor patient collections and self-pay revenue performance."
    - name: "total_contractual_adjustment"
      expr: SUM(CAST(contractual_adjustment AS DOUBLE))
      comment: "Total contractual write-downs applied to invoices, reflecting the discount from gross charges to allowed amounts under payer contracts."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total unpaid balance across all invoices, the core accounts receivable metric driving collections prioritization."
    - name: "total_patient_responsibility"
      expr: SUM(CAST(patient_responsibility AS DOUBLE))
      comment: "Total amount patients are responsible for (copays, deductibles, coinsurance), used to forecast patient collections and financial counseling needs."
    - name: "total_bad_debt"
      expr: SUM(CAST(bad_debt_amount AS DOUBLE))
      comment: "Total amount written off as bad debt, a critical financial risk metric indicating uncollectable revenue."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total payer-allowed amounts across invoices, representing the contracted reimbursement ceiling and basis for underpayment analysis."
    - name: "avg_outstanding_balance_per_invoice"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average outstanding balance per invoice, used to benchmark AR intensity and identify high-balance claim segments."
    - name: "denied_invoice_count"
      expr: COUNT(CASE WHEN denial_reason_code IS NOT NULL AND denial_reason_code <> '' THEN invoice_id END)
      comment: "Count of invoices with a denial reason code, measuring denial volume as a key revenue cycle quality indicator."
    - name: "total_denied_charges"
      expr: SUM(CASE WHEN denial_reason_code IS NOT NULL AND denial_reason_code <> '' THEN CAST(total_charges AS DOUBLE) ELSE 0 END)
      comment: "Total gross charges on denied invoices, quantifying the financial impact of payer denials on revenue."
    - name: "collection_rate"
      expr: ROUND(100.0 * SUM(CAST(insurance_payment AS DOUBLE) + CAST(patient_payment AS DOUBLE)) / NULLIF(SUM(CAST(total_charges AS DOUBLE)), 0), 2)
      comment: "Percentage of gross charges collected (insurance + patient payments), the primary revenue cycle efficiency KPI used by CFOs and revenue cycle directors."
    - name: "contractual_adjustment_rate"
      expr: ROUND(100.0 * SUM(CAST(contractual_adjustment AS DOUBLE)) / NULLIF(SUM(CAST(total_charges AS DOUBLE)), 0), 2)
      comment: "Contractual adjustments as a percentage of gross charges, measuring the effective discount rate from payer contracts — key for contract negotiation strategy."
    - name: "bad_debt_rate"
      expr: ROUND(100.0 * SUM(CAST(bad_debt_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_charges AS DOUBLE)), 0), 2)
      comment: "Bad debt as a percentage of gross charges, a critical financial health metric for assessing credit risk and charity care policy effectiveness."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level billing metrics for procedure-level reimbursement analysis, underpayment detection, denial management, and RVU-based productivity measurement. Used by revenue integrity, coding, and managed care teams."
  source: "`healthcare_ecm`.`billing`.`invoice_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the invoice line (e.g., paid, denied, pending) for granular AR and denial tracking."
    - name: "revenue_code"
      expr: revenue_code
      comment: "UB-04 revenue code on the invoice line, used for service-level revenue analysis and payer contract validation."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service code at the line level, enabling reimbursement analysis by care setting."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Payer denial reason code at the line level, used to identify the most impactful denial categories for targeted remediation."
    - name: "claim_adjustment_reason_code"
      expr: claim_adjustment_reason_code
      comment: "CARC code explaining payer payment adjustments, essential for underpayment identification and contract compliance audits."
    - name: "claim_adjustment_group_code"
      expr: claim_adjustment_group_code
      comment: "CAGC grouping the adjustment reason (e.g., CO=contractual, PR=patient responsibility), used for high-level adjustment categorization."
    - name: "modifier_1"
      expr: modifier_1
      comment: "Primary CPT modifier on the invoice line, affecting reimbursement and used for modifier-level payment variance analysis."
    - name: "service_date_month"
      expr: DATE_TRUNC('month', service_date)
      comment: "Month of service at the line level, used for trending procedure-level revenue and payment performance."
    - name: "service_location_code"
      expr: service_location_code
      comment: "Code identifying the service location at the line level, used for site-of-service reimbursement analysis."
    - name: "drug_unit_of_measure"
      expr: drug_unit_of_measure
      comment: "Unit of measure for drug charges on the invoice line, used for pharmacy revenue and utilization analysis."
  measures:
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total billed charge amount at the invoice line level, the foundational revenue metric for procedure-level financial analysis."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount paid by payers at the line level, the primary cash realization metric for procedure-level reimbursement performance."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total payer-allowed amounts at the line level, used as the benchmark for underpayment detection and contract compliance."
    - name: "total_contractual_adjustment"
      expr: SUM(CAST(contractual_adjustment_amount AS DOUBLE))
      comment: "Total contractual write-downs at the line level, measuring the discount from billed to allowed amounts by procedure."
    - name: "total_patient_responsibility"
      expr: SUM(CAST(patient_responsibility_amount AS DOUBLE))
      comment: "Total patient-responsible amounts at the line level (copays, deductibles, coinsurance), used for patient collections forecasting."
    - name: "total_rvu_work"
      expr: SUM(CAST(rvu_work AS DOUBLE))
      comment: "Total work RVUs across invoice lines, the standard measure of physician productivity and effort used for compensation modeling and staffing decisions."
    - name: "total_rvu_practice_expense"
      expr: SUM(CAST(rvu_practice_expense AS DOUBLE))
      comment: "Total practice expense RVUs, used to assess overhead cost allocation and facility resource consumption by service."
    - name: "total_rvu_malpractice"
      expr: SUM(CAST(rvu_malpractice AS DOUBLE))
      comment: "Total malpractice RVUs, used in total RVU-based reimbursement calculations and risk-adjusted productivity analysis."
    - name: "avg_paid_per_line"
      expr: AVG(CAST(paid_amount AS DOUBLE))
      comment: "Average payment received per invoice line, used to benchmark reimbursement rates by procedure, modifier, or payer."
    - name: "underpayment_amount"
      expr: SUM(CASE WHEN CAST(paid_amount AS DOUBLE) < CAST(allowed_amount AS DOUBLE) THEN CAST(allowed_amount AS DOUBLE) - CAST(paid_amount AS DOUBLE) ELSE 0 END)
      comment: "Total underpayment dollars (allowed minus paid when paid is less than allowed), a critical revenue integrity metric for identifying payer shortfalls and driving recovery actions."
    - name: "denied_line_count"
      expr: COUNT(CASE WHEN denial_reason_code IS NOT NULL AND denial_reason_code <> '' THEN invoice_line_id END)
      comment: "Count of denied invoice lines, measuring denial volume at the procedure level for targeted denial management."
    - name: "total_denied_charge_amount"
      expr: SUM(CASE WHEN denial_reason_code IS NOT NULL AND denial_reason_code <> '' THEN CAST(charge_amount AS DOUBLE) ELSE 0 END)
      comment: "Total billed charges on denied lines, quantifying the financial exposure from line-level denials."
    - name: "line_payment_rate"
      expr: ROUND(100.0 * SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(charge_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of billed charges collected at the line level, measuring reimbursement yield by procedure, payer, or modifier."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment-level cash flow metrics tracking collections by source, method, and payer. Supports treasury, revenue cycle, and CFO dashboards for cash position, refund management, and payment posting efficiency."
  source: "`healthcare_ecm`.`billing`.`payment`"
  dimensions:
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g., insurance, patient, capitation) for segmenting cash collections by source."
    - name: "payment_source"
      expr: payment_source
      comment: "Source of the payment (e.g., ERA, lockbox, portal) used to analyze collection channel effectiveness."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (e.g., EFT, check, credit card, cash) for treasury reconciliation and payment channel analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., posted, unapplied, reversed) for cash application monitoring."
    - name: "payment_category"
      expr: payment_category
      comment: "Business category of the payment (e.g., copay, deductible, coinsurance, full payment) for patient financial services analysis."
    - name: "posting_status"
      expr: posting_status
      comment: "Status of payment posting to the billing system, used to identify cash application backlogs and posting errors."
    - name: "refund_flag"
      expr: refund_flag
      comment: "Flag indicating the payment record includes a refund, used to track refund volume and financial liability."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Flag indicating the payment was reversed, used to identify payment integrity issues and reconciliation exceptions."
    - name: "payment_date_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of payment receipt, used for cash flow trending and monthly close reporting."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month payments were posted to the billing system, used to measure posting lag and cash application timeliness."
    - name: "channel"
      expr: channel
      comment: "Payment collection channel (e.g., online portal, call center, in-person) for patient engagement and collections strategy analysis."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total cash received across all payment records, the primary cash collections metric for revenue cycle and treasury management."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total payment dollars applied to invoices, measuring cash application completeness and AR reduction."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total unapplied payment dollars, representing cash received but not yet matched to invoices — a key cash application backlog metric."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refunds issued, a financial liability metric used to monitor overpayment recovery and patient refund obligations."
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction, used to benchmark payment size by channel, method, or payer type."
    - name: "refund_transaction_count"
      expr: COUNT(CASE WHEN refund_flag = TRUE THEN payment_id END)
      comment: "Count of payment records with refunds issued, used to monitor refund volume and identify overpayment patterns."
    - name: "reversal_transaction_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN payment_id END)
      comment: "Count of reversed payments, a payment integrity metric indicating posting errors, fraud risk, or payer recoupments."
    - name: "unapplied_payment_rate"
      expr: ROUND(100.0 * SUM(CAST(unapplied_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total payments that remain unapplied, measuring cash application efficiency — high rates indicate AR reconciliation risk."
    - name: "refund_rate"
      expr: ROUND(100.0 * SUM(CAST(refund_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Refund amount as a percentage of total payments collected, measuring overpayment exposure and refund liability relative to cash inflows."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`billing_patient_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient account financial health metrics covering AR aging, bad debt, financial assistance utilization, payment plan adoption, and collection performance. Core view for patient financial services, compliance (501(r)), and CFO reporting."
  source: "`healthcare_ecm`.`billing`.`patient_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the patient account (e.g., active, closed, in collections) for AR portfolio segmentation."
    - name: "account_type"
      expr: account_type
      comment: "Type of patient account (e.g., inpatient, outpatient, self-pay) for revenue cycle segmentation and payer mix analysis."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "AR aging bucket (e.g., 0-30, 31-60, 61-90, 90+ days) for accounts receivable aging analysis and collections prioritization."
    - name: "collection_status"
      expr: collection_status
      comment: "Collections workflow status (e.g., active, referred to agency, written off) for collections performance monitoring."
    - name: "financial_assistance_eligibility"
      expr: financial_assistance_eligibility
      comment: "Patient financial assistance eligibility determination, used for charity care program management and 501(r) compliance reporting."
    - name: "financial_assistance_approval_status"
      expr: financial_assistance_approval_status
      comment: "Approval status of financial assistance applications, used to track charity care program utilization and approval rates."
    - name: "bad_debt_flag"
      expr: bad_debt_flag
      comment: "Flag indicating the account has been referred to bad debt, used to segment uncollectable AR from active collections."
    - name: "payment_plan_flag"
      expr: payment_plan_flag
      comment: "Flag indicating the patient is enrolled in a payment plan, used to assess payment plan adoption and its impact on collections."
    - name: "irs_501r_compliance_flag"
      expr: irs_501r_compliance_flag
      comment: "Flag indicating the account meets IRS 501(r) compliance requirements for nonprofit hospital financial assistance policies."
    - name: "account_opened_month"
      expr: DATE_TRUNC('month', account_opened_date)
      comment: "Month the patient account was opened, used for cohort analysis of AR aging and collections performance."
  measures:
    - name: "total_account_balance"
      expr: SUM(CAST(account_balance AS DOUBLE))
      comment: "Total outstanding balance across all patient accounts, the primary AR metric for patient financial services and CFO reporting."
    - name: "total_patient_balance"
      expr: SUM(CAST(patient_balance AS DOUBLE))
      comment: "Total patient-responsible balance across accounts, used to forecast patient collections and assess self-pay AR exposure."
    - name: "total_insurance_balance"
      expr: SUM(CAST(insurance_balance AS DOUBLE))
      comment: "Total insurance-responsible balance across accounts, used to monitor payer AR and identify slow-paying payers."
    - name: "total_bad_debt_amount"
      expr: SUM(CAST(bad_debt_amount AS DOUBLE))
      comment: "Total bad debt written off across patient accounts, a critical financial risk and charity care compliance metric."
    - name: "total_original_balance"
      expr: SUM(CAST(original_balance AS DOUBLE))
      comment: "Total original balance at account creation, used as the denominator for collection rate and bad debt rate calculations."
    - name: "total_total_payments"
      expr: SUM(CAST(total_payments AS DOUBLE))
      comment: "Total payments received across all patient accounts, measuring cumulative cash collections at the account level."
    - name: "total_total_adjustments"
      expr: SUM(CAST(total_adjustments AS DOUBLE))
      comment: "Total adjustments applied across patient accounts (contractual, charity, write-offs), used to reconcile gross charges to net AR."
    - name: "total_recovered_amount"
      expr: SUM(CAST(recovered_amount AS DOUBLE))
      comment: "Total amount recovered from collections agencies, measuring the effectiveness of third-party collections programs."
    - name: "total_referred_balance"
      expr: SUM(CAST(referred_balance AS DOUBLE))
      comment: "Total balance referred to external collections agencies, quantifying the volume of AR escalated beyond internal collections."
    - name: "avg_account_balance"
      expr: AVG(CAST(account_balance AS DOUBLE))
      comment: "Average outstanding balance per patient account, used to benchmark account-level AR intensity and identify high-balance segments."
    - name: "bad_debt_account_count"
      expr: COUNT(CASE WHEN bad_debt_flag = TRUE THEN patient_account_id END)
      comment: "Count of accounts flagged as bad debt, measuring the volume of uncollectable accounts for financial risk assessment."
    - name: "payment_plan_account_count"
      expr: COUNT(CASE WHEN payment_plan_flag = TRUE THEN patient_account_id END)
      comment: "Count of accounts enrolled in payment plans, measuring payment plan adoption as a patient financial engagement metric."
    - name: "financial_assistance_account_count"
      expr: COUNT(CASE WHEN financial_assistance_approval_status = 'APPROVED' THEN patient_account_id END)
      comment: "Count of accounts approved for financial assistance, used for charity care program reporting and 501(r) compliance documentation."
    - name: "account_collection_rate"
      expr: ROUND(100.0 * SUM(CAST(total_payments AS DOUBLE)) / NULLIF(SUM(CAST(original_balance AS DOUBLE)), 0), 2)
      comment: "Percentage of original balance collected across patient accounts, the primary patient financial services performance KPI."
    - name: "bad_debt_rate"
      expr: ROUND(100.0 * SUM(CAST(bad_debt_amount AS DOUBLE)) / NULLIF(SUM(CAST(original_balance AS DOUBLE)), 0), 2)
      comment: "Bad debt as a percentage of original balance, a key financial health and charity care policy effectiveness metric for CFO and compliance reporting."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`billing_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adjustment-level metrics for revenue integrity, contractual write-down analysis, write-off classification, and denial-driven adjustment tracking. Used by revenue cycle, compliance, and finance teams to monitor adjustment patterns and financial impact."
  source: "`healthcare_ecm`.`billing`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (e.g., contractual, write-off, refund, correction) for categorizing financial impact by adjustment class."
    - name: "adjustment_category"
      expr: adjustment_category
      comment: "Business category of the adjustment (e.g., payer contractual, charity care, bad debt) for revenue integrity segmentation."
    - name: "adjustment_source"
      expr: adjustment_source
      comment: "Source system or process that generated the adjustment (e.g., ERA, manual, denial), used to identify automation gaps."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment (e.g., posted, pending, reversed) for adjustment workflow monitoring."
    - name: "reason_code"
      expr: reason_code
      comment: "Adjustment reason code (e.g., CARC, RARC, internal code) used to identify the most impactful adjustment drivers."
    - name: "write_off_classification"
      expr: write_off_classification
      comment: "Classification of write-off adjustments (e.g., charity, bad debt, small balance) for financial reporting and 501(r) compliance."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the adjustment, used to identify unreconciled adjustments that may affect financial close accuracy."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Flag indicating the adjustment was reversed, used to identify adjustment integrity issues and net financial impact."
    - name: "appeal_flag"
      expr: appeal_flag
      comment: "Flag indicating the adjustment is associated with a payer appeal, used to track appeal-driven adjustment recovery."
    - name: "adjustment_date_month"
      expr: DATE_TRUNC('month', adjustment_date)
      comment: "Month the adjustment was applied, used for trending adjustment volume and financial impact over time."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center associated with the adjustment, used for departmental financial reporting and GL reconciliation."
  measures:
    - name: "total_adjustment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total adjustment dollars applied across all records, the primary metric for measuring the financial impact of adjustments on net revenue."
    - name: "total_contract_rate_amount"
      expr: SUM(CAST(contract_rate AS DOUBLE))
      comment: "Total contracted rate amounts associated with adjustments, used to validate that contractual adjustments align with payer contract terms."
    - name: "avg_adjustment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average adjustment amount per record, used to benchmark adjustment size by type, payer, or reason code."
    - name: "reversal_adjustment_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN adjustment_id END)
      comment: "Count of reversed adjustments, indicating adjustment posting errors or payer recoupments that require remediation."
    - name: "appeal_adjustment_count"
      expr: COUNT(CASE WHEN appeal_flag = TRUE THEN adjustment_id END)
      comment: "Count of adjustments associated with payer appeals, measuring the volume of contested adjustments in the denial management pipeline."
    - name: "total_appeal_adjustment_amount"
      expr: SUM(CASE WHEN appeal_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total dollars in adjustments associated with active appeals, quantifying the financial recovery opportunity in the appeals pipeline."
    - name: "write_off_adjustment_amount"
      expr: SUM(CASE WHEN adjustment_type = 'WRITE_OFF' THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total write-off adjustment dollars, a key financial risk metric for assessing uncollectable revenue and charity care exposure."
    - name: "reversal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_flag = TRUE THEN adjustment_id END) / NULLIF(COUNT(adjustment_id), 0), 2)
      comment: "Percentage of adjustments that were reversed, measuring adjustment posting quality and the rework burden on the revenue cycle team."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`billing_coding_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical coding quality and CDI (Clinical Documentation Improvement) metrics covering coding accuracy, DRG financial impact, MCC/CC capture rates, and CDI query effectiveness. Used by HIM, CDI, and revenue integrity leadership."
  source: "`healthcare_ecm`.`billing`.`coding_assignment`"
  dimensions:
    - name: "coding_status"
      expr: coding_status
      comment: "Current status of the coding assignment (e.g., complete, pending, queried) for coding workflow management."
    - name: "coding_method"
      expr: coding_method
      comment: "Method used for coding (e.g., manual, computer-assisted, AI-assisted) for productivity and accuracy benchmarking."
    - name: "mdc_code"
      expr: mdc_code
      comment: "Major Diagnostic Category code, used to segment DRG-based reimbursement and case mix by clinical service line."
    - name: "mdc_description"
      expr: mdc_description
      comment: "Description of the Major Diagnostic Category, providing human-readable service line context for executive reporting."
    - name: "complication_comorbidity_flag"
      expr: complication_comorbidity_flag
      comment: "Flag indicating the case has a complication or comorbidity (CC), which increases DRG weight and reimbursement."
    - name: "major_complication_comorbidity_flag"
      expr: major_complication_comorbidity_flag
      comment: "Flag indicating the case has a major complication or comorbidity (MCC), the highest DRG complexity tier with the greatest reimbursement impact."
    - name: "audit_flag"
      expr: audit_flag
      comment: "Flag indicating the coding assignment was selected for audit, used to track audit coverage and compliance risk."
    - name: "cdi_query_type"
      expr: cdi_query_type
      comment: "Type of CDI query issued (e.g., clarification, specificity, POA), used to analyze CDI program focus areas."
    - name: "discharge_disposition_code"
      expr: discharge_disposition_code
      comment: "Discharge disposition code (e.g., home, SNF, expired), used for case mix and post-acute care utilization analysis."
    - name: "coding_date_month"
      expr: DATE_TRUNC('month', coding_date)
      comment: "Month coding was completed, used for trending coding productivity, accuracy, and CDI impact over time."
    - name: "admission_type_code"
      expr: admission_type_code
      comment: "Admission type code (e.g., emergency, elective, urgent) for case mix and revenue analysis by admission category."
  measures:
    - name: "total_expected_reimbursement"
      expr: SUM(CAST(expected_reimbursement_amount AS DOUBLE))
      comment: "Total expected reimbursement across coded cases, the primary financial output of the coding and CDI program."
    - name: "avg_coding_accuracy_score"
      expr: AVG(CAST(coding_accuracy_score AS DOUBLE))
      comment: "Average coding accuracy score across assignments, the primary quality metric for HIM and coding compliance programs."
    - name: "total_cdi_drg_impact_amount"
      expr: SUM(CAST(cdi_drg_impact_amount AS DOUBLE))
      comment: "Total financial impact of CDI-driven DRG changes, measuring the revenue contribution of the Clinical Documentation Improvement program."
    - name: "avg_arithmetic_mean_los"
      expr: AVG(CAST(arithmetic_mean_los AS DOUBLE))
      comment: "Average arithmetic mean length of stay for coded cases, used to benchmark case complexity and identify outlier cases."
    - name: "avg_geometric_mean_los"
      expr: AVG(CAST(geometric_mean_los AS DOUBLE))
      comment: "Average geometric mean length of stay, the CMS benchmark for DRG-based LOS comparison and outlier payment analysis."
    - name: "mcc_case_count"
      expr: COUNT(CASE WHEN major_complication_comorbidity_flag = TRUE THEN coding_assignment_id END)
      comment: "Count of cases with Major Complications or Comorbidities (MCC), measuring the high-complexity case volume that drives premium DRG reimbursement."
    - name: "cc_case_count"
      expr: COUNT(CASE WHEN complication_comorbidity_flag = TRUE THEN coding_assignment_id END)
      comment: "Count of cases with Complications or Comorbidities (CC), measuring the moderate-complexity case volume affecting DRG weight and reimbursement."
    - name: "audited_case_count"
      expr: COUNT(CASE WHEN audit_flag = TRUE THEN coding_assignment_id END)
      comment: "Count of coding assignments selected for audit, used to monitor audit coverage rates and compliance program activity."
    - name: "mcc_capture_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN major_complication_comorbidity_flag = TRUE THEN coding_assignment_id END) / NULLIF(COUNT(coding_assignment_id), 0), 2)
      comment: "Percentage of coded cases with MCC designation, a key CDI effectiveness metric — low rates may indicate documentation gaps and missed reimbursement."
    - name: "avg_outlier_threshold_amount"
      expr: AVG(CAST(outlier_threshold_amount AS DOUBLE))
      comment: "Average outlier threshold amount across coded cases, used to identify cases approaching cost outlier payment eligibility for additional reimbursement."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`billing_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Insurance coverage and eligibility metrics tracking active coverage rates, deductible and out-of-pocket utilization, copay levels, and authorization requirements. Used by patient access, managed care, and revenue cycle teams."
  source: "`healthcare_ecm`.`billing`.`coverage`"
  dimensions:
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of insurance coverage (e.g., commercial, Medicare, Medicaid, self-pay) for payer mix analysis and revenue forecasting."
    - name: "coverage_status"
      expr: coverage_status
      comment: "Current status of the coverage record (e.g., active, terminated, pending) for eligibility management."
    - name: "network_status"
      expr: network_status
      comment: "In-network or out-of-network status of the coverage, used to assess reimbursement risk and patient cost-sharing exposure."
    - name: "coordination_of_benefits_order"
      expr: coordination_of_benefits_order
      comment: "COB order (primary, secondary, tertiary) for multi-payer coverage analysis and billing sequencing."
    - name: "active_flag"
      expr: active_flag
      comment: "Flag indicating the coverage is currently active, used to filter for valid coverage in eligibility and billing workflows."
    - name: "authorization_required_flag"
      expr: authorization_required_flag
      comment: "Flag indicating prior authorization is required under this coverage, used to manage authorization workflows and denial prevention."
    - name: "referral_required_flag"
      expr: referral_required_flag
      comment: "Flag indicating a referral is required under this coverage, used to manage care coordination and denial prevention."
    - name: "last_verification_status"
      expr: last_verification_status
      comment: "Status of the most recent eligibility verification, used to monitor verification quality and identify coverage at risk."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month coverage became effective, used for enrollment trend analysis and payer mix forecasting."
    - name: "plan_year_start_date_month"
      expr: DATE_TRUNC('month', plan_year_start_date)
      comment: "Plan year start month, used to align deductible and out-of-pocket metrics with benefit year cycles."
  measures:
    - name: "total_deductible_amount"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductible amounts across coverage records, used to assess patient financial responsibility exposure at the population level."
    - name: "total_deductible_met_amount"
      expr: SUM(CAST(deductible_met_amount AS DOUBLE))
      comment: "Total deductible amounts already met by patients, used to forecast remaining patient responsibility and collections timing."
    - name: "total_out_of_pocket_maximum"
      expr: SUM(CAST(out_of_pocket_maximum AS DOUBLE))
      comment: "Total out-of-pocket maximum amounts across coverage records, representing the ceiling on patient financial liability."
    - name: "total_out_of_pocket_met_amount"
      expr: SUM(CAST(out_of_pocket_met_amount AS DOUBLE))
      comment: "Total out-of-pocket amounts already met, used to identify patients who have reached their OOP maximum and have no further cost-sharing liability."
    - name: "avg_copay_amount"
      expr: AVG(CAST(copay_amount AS DOUBLE))
      comment: "Average copay amount across coverage records, used to benchmark patient cost-sharing levels by payer and plan type."
    - name: "avg_coinsurance_percentage"
      expr: AVG(CAST(coinsurance_percentage AS DOUBLE))
      comment: "Average coinsurance percentage across coverage records, used to assess patient cost-sharing burden and collections risk by payer mix."
    - name: "active_coverage_count"
      expr: COUNT(CASE WHEN active_flag = TRUE THEN coverage_id END)
      comment: "Count of active coverage records, measuring the enrolled patient population with valid insurance coverage."
    - name: "authorization_required_coverage_count"
      expr: COUNT(CASE WHEN authorization_required_flag = TRUE THEN coverage_id END)
      comment: "Count of coverage records requiring prior authorization, used to size the authorization management workload and denial prevention effort."
    - name: "deductible_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(deductible_met_amount AS DOUBLE)) / NULLIF(SUM(CAST(deductible_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total deductible amounts that have been met, indicating how far into the plan year patients have progressed — used to forecast patient payment timing and collections strategy."
    - name: "oop_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(out_of_pocket_met_amount AS DOUBLE)) / NULLIF(SUM(CAST(out_of_pocket_maximum AS DOUBLE)), 0), 2)
      comment: "Percentage of out-of-pocket maximum amounts that have been met, used to identify patients with no remaining cost-sharing liability and adjust collections strategy accordingly."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`billing_payment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment plan performance metrics tracking enrollment, completion rates, default risk, and financial recovery through structured patient payment arrangements. Used by patient financial services and revenue cycle leadership."
  source: "`healthcare_ecm`.`billing`.`payment_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the payment plan (e.g., active, completed, defaulted, cancelled) for portfolio health monitoring."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of payment plan (e.g., interest-free, interest-bearing, financial assistance) for program mix analysis."
    - name: "installment_frequency"
      expr: installment_frequency
      comment: "Frequency of installment payments (e.g., monthly, bi-weekly) for cash flow forecasting and patient engagement analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for plan installments (e.g., auto-pay, check, credit card) for collections efficiency analysis."
    - name: "auto_pay_flag"
      expr: auto_pay_flag
      comment: "Flag indicating the plan is enrolled in automatic payment, used to assess auto-pay adoption and its impact on default rates."
    - name: "agreement_signed_flag"
      expr: agreement_signed_flag
      comment: "Flag indicating the patient has signed the payment plan agreement, used for compliance and collections enforceability."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the patient enrolled in the payment plan (e.g., online, in-person, call center) for patient engagement analysis."
    - name: "financial_assistance_program_code"
      expr: financial_assistance_program_code
      comment: "Financial assistance program associated with the payment plan, used for charity care and sliding-scale program reporting."
    - name: "enrollment_date_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of payment plan enrollment, used for trending plan adoption and financial recovery program growth."
  measures:
    - name: "total_plan_amount"
      expr: SUM(CAST(total_plan_amount AS DOUBLE))
      comment: "Total dollar value of all payment plans, representing the structured payment recovery pipeline for patient financial services."
    - name: "total_paid_amount"
      expr: SUM(CAST(total_paid_amount AS DOUBLE))
      comment: "Total amount collected through payment plans, measuring the cash recovery contribution of the payment plan program."
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance_amount AS DOUBLE))
      comment: "Total remaining balance across active payment plans, representing the future cash recovery pipeline from structured arrangements."
    - name: "total_original_balance"
      expr: SUM(CAST(original_balance_amount AS DOUBLE))
      comment: "Total original balance at payment plan enrollment, used as the denominator for plan completion and recovery rate calculations."
    - name: "avg_installment_amount"
      expr: AVG(CAST(installment_amount AS DOUBLE))
      comment: "Average installment payment amount, used to assess affordability of payment plans and benchmark against patient income levels."
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate_percentage AS DOUBLE))
      comment: "Average interest rate across payment plans, used to monitor financing cost to patients and compliance with state usury regulations."
    - name: "defaulted_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'DEFAULTED' THEN payment_plan_id END)
      comment: "Count of defaulted payment plans, a key risk metric for patient financial services indicating failed structured payment arrangements."
    - name: "auto_pay_plan_count"
      expr: COUNT(CASE WHEN auto_pay_flag = TRUE THEN payment_plan_id END)
      comment: "Count of payment plans enrolled in auto-pay, measuring adoption of the highest-compliance payment method."
    - name: "plan_completion_rate"
      expr: ROUND(100.0 * SUM(CAST(total_paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_plan_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total plan amount collected, measuring the overall effectiveness of the payment plan program in recovering patient balances."
    - name: "plan_default_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN plan_status = 'DEFAULTED' THEN payment_plan_id END) / NULLIF(COUNT(payment_plan_id), 0), 2)
      comment: "Percentage of payment plans that have defaulted, a critical risk metric for patient financial services leadership and collections strategy."
$$;