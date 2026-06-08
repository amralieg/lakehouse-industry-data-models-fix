-- Metric views for domain: billing | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue cycle invoice metrics tracking billing performance, outstanding balances, and claim submission efficiency for healthcare financial operations."
  source: "`healthcare_ecm_v1`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g., submitted, paid, denied, pending) for workflow tracking"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (professional, institutional, etc.) for billing category analysis"
    - name: "form_type"
      expr: form_type
      comment: "Claim form type (CMS-1500, UB-04) indicating professional vs facility billing"
    - name: "bill_type_code"
      expr: bill_type_code
      comment: "UB-04 bill type code indicating facility type and billing frequency"
    - name: "submission_method"
      expr: submission_method
      comment: "How the claim was submitted (electronic, paper, clearinghouse) for efficiency analysis"
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status of the invoice for AR aging analysis"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice creation for trend analysis"
    - name: "drg_code"
      expr: drg_code
      comment: "DRG code for case-mix and reimbursement analysis"
  measures:
    - name: "total_invoices"
      expr: COUNT(1)
      comment: "Total number of invoices generated for volume tracking"
    - name: "total_charges"
      expr: SUM(CAST(total_charges AS DOUBLE))
      comment: "Total gross charges billed across all invoices"
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total payer-allowed amounts representing expected reimbursement"
    - name: "total_contractual_adjustment"
      expr: SUM(CAST(contractual_adjustment AS DOUBLE))
      comment: "Total contractual adjustments representing difference between charges and allowed amounts"
    - name: "total_insurance_payment"
      expr: SUM(CAST(insurance_payment AS DOUBLE))
      comment: "Total payments received from insurance payers"
    - name: "total_patient_payment"
      expr: SUM(CAST(patient_payment AS DOUBLE))
      comment: "Total payments received from patients"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding AR balance across all invoices"
    - name: "total_patient_responsibility"
      expr: SUM(CAST(patient_responsibility AS DOUBLE))
      comment: "Total patient responsibility amount for patient collections forecasting"
    - name: "total_bad_debt"
      expr: SUM(CAST(bad_debt_amount AS DOUBLE))
      comment: "Total bad debt amount indicating uncollectable revenue"
    - name: "avg_total_charges_per_invoice"
      expr: AVG(CAST(total_charges AS DOUBLE))
      comment: "Average charge amount per invoice for case-mix monitoring"
    - name: "avg_outstanding_balance"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average outstanding balance per invoice for AR management"
    - name: "denied_invoice_count"
      expr: COUNT(CASE WHEN claim_denial_reason_code IS NOT NULL THEN 1 END)
      comment: "Count of invoices with denial reason codes for denial management"
    - name: "total_non_covered_charges"
      expr: SUM(CAST(non_covered_charges AS DOUBLE))
      comment: "Total non-covered charges representing revenue at risk"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment collection metrics tracking cash flow, payment methods, and posting efficiency for revenue cycle management."
  source: "`healthcare_ecm_v1`.`billing`.`payment`"
  dimensions:
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (insurance, patient, refund) for source analysis"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (check, EFT, credit card, cash) for channel optimization"
    - name: "payment_source"
      expr: payment_source
      comment: "Source of payment (payer, patient, guarantor) for collections strategy"
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of payment for reconciliation tracking"
    - name: "payment_category"
      expr: payment_category
      comment: "Category of payment for financial reporting segmentation"
    - name: "posting_status"
      expr: posting_status
      comment: "Whether payment has been posted to patient account"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment receipt for cash flow trending"
    - name: "channel"
      expr: channel
      comment: "Payment channel (online portal, mail, in-person) for patient experience analysis"
  measures:
    - name: "total_payments"
      expr: COUNT(1)
      comment: "Total number of payment transactions received"
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total cash collected across all payment sources"
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total payment amount applied to invoices"
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total unapplied cash requiring reconciliation action"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refunds issued reducing net collections"
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction for benchmarking"
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Count of reversed payments indicating posting errors or disputes"
    - name: "refund_count"
      expr: COUNT(CASE WHEN refund_flag = TRUE THEN 1 END)
      comment: "Count of refund transactions for overpayment monitoring"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`billing_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Charge capture metrics tracking gross revenue, charge volume, and charge integrity for revenue assurance."
  source: "`healthcare_ecm_v1`.`billing`.`charge`"
  dimensions:
    - name: "charge_status"
      expr: charge_status
      comment: "Current status of the charge (posted, held, voided) for workflow monitoring"
    - name: "charge_type"
      expr: charge_type
      comment: "Type of charge (facility, professional, supply) for revenue category analysis"
    - name: "charge_category"
      expr: charge_category
      comment: "Category of charge for departmental revenue reporting"
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service for site-level revenue analysis"
    - name: "revenue_code"
      expr: revenue_code
      comment: "Revenue code for UB-04 revenue center analysis"
    - name: "is_billable"
      expr: CAST(is_billable AS STRING)
      comment: "Whether charge is billable for revenue leakage identification"
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', facility_service_date)
      comment: "Month of service for revenue trending"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month charge was posted for charge lag analysis"
  measures:
    - name: "total_charges"
      expr: COUNT(1)
      comment: "Total number of charge transactions captured"
    - name: "total_gross_charge_amount"
      expr: SUM(CAST(gross_charge_amount AS DOUBLE))
      comment: "Total gross charges representing top-line revenue before adjustments"
    - name: "total_expected_reimbursement"
      expr: SUM(CAST(expected_reimbursement_amount AS DOUBLE))
      comment: "Total expected reimbursement for revenue forecasting"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price per charge for pricing analysis"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total units of service delivered for volume analysis"
    - name: "voided_charge_count"
      expr: COUNT(CASE WHEN is_voided = TRUE THEN 1 END)
      comment: "Count of voided charges indicating charge capture errors"
    - name: "corrected_charge_count"
      expr: COUNT(CASE WHEN is_corrected = TRUE THEN 1 END)
      comment: "Count of corrected charges for charge accuracy monitoring"
    - name: "held_charge_count"
      expr: COUNT(CASE WHEN hold_reason IS NOT NULL THEN 1 END)
      comment: "Count of charges on hold requiring resolution before billing"
    - name: "non_billable_charge_count"
      expr: COUNT(CASE WHEN is_billable = FALSE THEN 1 END)
      comment: "Count of non-billable charges for revenue leakage analysis"
    - name: "avg_gross_charge_per_service"
      expr: AVG(CAST(gross_charge_amount AS DOUBLE))
      comment: "Average gross charge per service for case-mix and pricing benchmarking"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`billing_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adjustment metrics tracking contractual write-downs, denials, and revenue adjustments for net revenue management."
  source: "`healthcare_ecm_v1`.`billing`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (contractual, bad debt, charity, admin) for categorization"
    - name: "adjustment_category"
      expr: adjustment_category
      comment: "Category of adjustment for financial reporting"
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment for workflow tracking"
    - name: "adjustment_source"
      expr: adjustment_source
      comment: "Source of adjustment (payer, internal, patient) for root cause analysis"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for adjustment categorization and denial trending"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status for month-end close tracking"
    - name: "adjustment_month"
      expr: DATE_TRUNC('MONTH', adjustment_date)
      comment: "Month of adjustment for trend analysis"
    - name: "write_off_classification"
      expr: write_off_classification
      comment: "Write-off classification for bad debt and charity care reporting"
  measures:
    - name: "total_adjustments"
      expr: COUNT(1)
      comment: "Total number of adjustment transactions"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total dollar value of all adjustments impacting net revenue"
    - name: "avg_adjustment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average adjustment amount for outlier detection"
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Count of reversed adjustments indicating correction activity"
    - name: "appeal_count"
      expr: COUNT(CASE WHEN claim_appeal_flag = TRUE THEN 1 END)
      comment: "Count of adjustments with associated appeals for denial management"
    - name: "total_facility_contract_rate"
      expr: SUM(CAST(facility_contract_rate AS DOUBLE))
      comment: "Total facility contract rate amounts for payer contract performance analysis"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`billing_collection_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collections performance metrics tracking recovery rates, aging, and collection agency effectiveness for bad debt management."
  source: "`healthcare_ecm_v1`.`billing`.`collection_account`"
  dimensions:
    - name: "collection_status"
      expr: collection_status
      comment: "Current status of collection account for pipeline tracking"
    - name: "collection_type"
      expr: collection_type
      comment: "Type of collection (internal, external agency, legal) for strategy analysis"
    - name: "aging_days"
      expr: aging_days
      comment: "Aging bucket for AR aging report segmentation"
    - name: "payment_plan_flag"
      expr: CAST(payment_plan_flag AS STRING)
      comment: "Whether account has payment plan for self-pay strategy analysis"
    - name: "legal_action_flag"
      expr: CAST(legal_action_flag AS STRING)
      comment: "Whether legal action has been taken for escalation tracking"
    - name: "settlement_flag"
      expr: CAST(settlement_flag AS STRING)
      comment: "Whether account has been settled for resolution analysis"
  measures:
    - name: "total_collection_accounts"
      expr: COUNT(1)
      comment: "Total number of accounts in collections"
    - name: "total_referred_balance"
      expr: SUM(CAST(referred_balance AS DOUBLE))
      comment: "Total balance referred to collections representing at-risk revenue"
    - name: "total_recovered_amount"
      expr: SUM(CAST(recovered_amount AS DOUBLE))
      comment: "Total amount recovered from collection efforts"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance still in collections"
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as uncollectable"
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amounts accepted below full balance"
    - name: "total_collection_fees"
      expr: SUM(CAST(collection_fee_amount AS DOUBLE))
      comment: "Total fees paid to collection agencies impacting net recovery"
    - name: "avg_principal_amount"
      expr: AVG(CAST(principal_amount AS DOUBLE))
      comment: "Average principal amount per collection account for segmentation"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`billing_patient_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient account financial health metrics tracking balances, financial assistance, and self-pay performance."
  source: "`healthcare_ecm_v1`.`billing`.`patient_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of patient account for lifecycle tracking"
    - name: "account_type"
      expr: account_type
      comment: "Type of patient account for segmentation"
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status for AR management"
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket for AR aging analysis"
    - name: "financial_assistance_eligibility"
      expr: financial_assistance_eligibility
      comment: "Financial assistance eligibility status for charity care reporting"
    - name: "bad_debt_flag"
      expr: CAST(bad_debt_flag AS STRING)
      comment: "Whether account has been classified as bad debt"
    - name: "payment_plan_flag"
      expr: CAST(payment_plan_flag AS STRING)
      comment: "Whether account has active payment plan"
  measures:
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total number of patient accounts"
    - name: "total_account_balance"
      expr: SUM(CAST(account_balance AS DOUBLE))
      comment: "Total outstanding patient account balances"
    - name: "total_patient_balance"
      expr: SUM(CAST(patient_balance AS DOUBLE))
      comment: "Total patient-responsible balance for self-pay collections"
    - name: "total_insurance_balance"
      expr: SUM(CAST(insurance_balance AS DOUBLE))
      comment: "Total insurance-pending balance for payer follow-up"
    - name: "total_bad_debt_amount"
      expr: SUM(CAST(bad_debt_amount AS DOUBLE))
      comment: "Total bad debt across patient accounts"
    - name: "total_payments"
      expr: SUM(CAST(total_payments AS DOUBLE))
      comment: "Total payments received across all patient accounts"
    - name: "total_adjustments"
      expr: SUM(CAST(total_adjustments AS DOUBLE))
      comment: "Total adjustments applied to patient accounts"
    - name: "avg_account_balance"
      expr: AVG(CAST(account_balance AS DOUBLE))
      comment: "Average account balance for benchmarking and segmentation"
    - name: "avg_fpl_percentage"
      expr: AVG(CAST(fpl_percentage AS DOUBLE))
      comment: "Average federal poverty level percentage for financial assistance program analysis"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`billing_coding_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical coding performance metrics tracking CDI impact, coding accuracy, and DRG optimization for revenue integrity."
  source: "`healthcare_ecm_v1`.`billing`.`coding_assignment`"
  dimensions:
    - name: "coding_status"
      expr: coding_status
      comment: "Current coding status for workflow throughput analysis"
    - name: "coding_method"
      expr: coding_method
      comment: "Coding method (manual, CAC-assisted, AI-assisted) for productivity analysis"
    - name: "cdi_query_type"
      expr: cdi_query_type
      comment: "Type of CDI query for clinical documentation improvement tracking"
    - name: "cdi_query_topic"
      expr: cdi_query_topic
      comment: "Topic of CDI query for physician education targeting"
    - name: "mdc_code"
      expr: mdc_code
      comment: "Major Diagnostic Category for case-mix analysis"
    - name: "audit_flag"
      expr: CAST(audit_flag AS STRING)
      comment: "Whether coding assignment has been audited"
    - name: "coding_month"
      expr: DATE_TRUNC('MONTH', coding_date)
      comment: "Month of coding for productivity trending"
  measures:
    - name: "total_coding_assignments"
      expr: COUNT(1)
      comment: "Total number of coding assignments for volume tracking"
    - name: "total_cdi_drg_impact"
      expr: SUM(CAST(cdi_drg_impact_amount AS DOUBLE))
      comment: "Total CDI DRG impact in dollars representing revenue captured through documentation improvement"
    - name: "avg_coding_accuracy_score"
      expr: AVG(CAST(coding_accuracy_score AS DOUBLE))
      comment: "Average coding accuracy score for quality monitoring"
    - name: "total_expected_reimbursement"
      expr: SUM(CAST(expected_reimbursement_amount AS DOUBLE))
      comment: "Total expected reimbursement from coded encounters"
    - name: "avg_geometric_mean_los"
      expr: AVG(CAST(geometric_mean_los AS DOUBLE))
      comment: "Average geometric mean LOS for DRG efficiency benchmarking"
    - name: "cdi_query_count"
      expr: COUNT(CASE WHEN cdi_query_date IS NOT NULL THEN 1 END)
      comment: "Count of CDI queries issued for documentation improvement program tracking"
    - name: "cc_mcc_capture_count"
      expr: COUNT(CASE WHEN complication_comorbidity_flag = TRUE OR major_complication_comorbidity_flag = TRUE THEN 1 END)
      comment: "Count of cases with CC/MCC capture for severity of illness documentation"
    - name: "avg_drg_weight"
      expr: AVG(CAST(geometric_mean_los AS DOUBLE))
      comment: "Average DRG geometric mean LOS as proxy for case complexity"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`billing_write_off`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Write-off metrics tracking bad debt, charity care, and contractual write-offs for financial reporting and compliance."
  source: "`healthcare_ecm_v1`.`billing`.`write_off`"
  dimensions:
    - name: "write_off_type"
      expr: write_off_type
      comment: "Type of write-off (bad debt, charity, contractual, admin) for categorization"
    - name: "write_off_category"
      expr: write_off_category
      comment: "Category of write-off for financial statement classification"
    - name: "write_off_status"
      expr: write_off_status
      comment: "Current status of write-off for approval workflow tracking"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for write-off root cause analysis"
    - name: "write_off_month"
      expr: DATE_TRUNC('MONTH', write_off_date)
      comment: "Month of write-off for trend analysis and period reporting"
  measures:
    - name: "total_write_offs"
      expr: COUNT(1)
      comment: "Total number of write-off transactions"
    - name: "total_write_off_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total dollar value of write-offs impacting net revenue"
    - name: "total_original_balance"
      expr: SUM(CAST(original_balance AS DOUBLE))
      comment: "Total original balance before write-off for recovery rate calculation"
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Total remaining balance after partial write-offs"
    - name: "avg_write_off_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average write-off amount for threshold monitoring"
    - name: "appeal_count"
      expr: COUNT(CASE WHEN claim_appeal_flag = TRUE THEN 1 END)
      comment: "Count of write-offs with associated appeals for recovery opportunity tracking"
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Count of reversed write-offs indicating successful recovery"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`billing_rac_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recovery Audit Contractor metrics tracking audit exposure, appeal success, and recoupment for compliance and revenue protection."
  source: "`healthcare_ecm_v1`.`billing`.`rac_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of RAC audit for risk categorization"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of RAC audit for pipeline tracking"
    - name: "finding_type"
      expr: finding_type
      comment: "Type of audit finding for root cause analysis"
    - name: "claim_appeal_status"
      expr: claim_appeal_status
      comment: "Appeal status for win-rate tracking"
    - name: "claim_appeal_level"
      expr: claim_appeal_level
      comment: "Appeal level (1st, 2nd, ALJ, Council, Federal Court) for escalation tracking"
    - name: "contractor_name"
      expr: contractor_name
      comment: "RAC contractor name for contractor-specific performance analysis"
    - name: "recoupment_method"
      expr: recoupment_method
      comment: "Method of recoupment for cash flow impact analysis"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of RAC audit cases"
    - name: "total_finding_amount"
      expr: SUM(CAST(finding_amount AS DOUBLE))
      comment: "Total dollar value of audit findings representing revenue at risk"
    - name: "total_overpayment_amount"
      expr: SUM(CAST(overpayment_amount AS DOUBLE))
      comment: "Total overpayment identified by auditors"
    - name: "total_recoupment_amount"
      expr: SUM(CAST(recoupment_amount AS DOUBLE))
      comment: "Total amount recouped by CMS/contractors"
    - name: "total_appeal_outcome_amount"
      expr: SUM(CAST(claim_appeal_outcome_amount AS DOUBLE))
      comment: "Total dollar value recovered through appeals"
    - name: "total_interest_amount"
      expr: SUM(CAST(interest_amount AS DOUBLE))
      comment: "Total interest charges on recoupments"
    - name: "appealed_count"
      expr: COUNT(CASE WHEN claim_appeal_filed_flag = TRUE THEN 1 END)
      comment: "Count of audits where appeals were filed for appeal rate calculation"
    - name: "extrapolation_count"
      expr: COUNT(CASE WHEN extrapolation_flag = TRUE THEN 1 END)
      comment: "Count of audits with statistical extrapolation representing highest financial risk"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`billing_payment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment plan performance metrics tracking enrollment, compliance, and default rates for patient financial engagement."
  source: "`healthcare_ecm_v1`.`billing`.`payment_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of payment plan for lifecycle analysis"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of payment plan for program analysis"
    - name: "installment_frequency"
      expr: installment_frequency
      comment: "Payment frequency for cash flow forecasting"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method on file for auto-pay analysis"
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which plan was enrolled for digital engagement tracking"
    - name: "auto_pay_flag"
      expr: CAST(auto_pay_flag AS STRING)
      comment: "Whether plan has auto-pay enabled for retention analysis"
  measures:
    - name: "total_payment_plans"
      expr: COUNT(1)
      comment: "Total number of payment plans for program volume tracking"
    - name: "total_plan_amount"
      expr: SUM(CAST(total_plan_amount AS DOUBLE))
      comment: "Total dollar value of all payment plans"
    - name: "total_paid_amount"
      expr: SUM(CAST(total_paid_amount AS DOUBLE))
      comment: "Total amount collected through payment plans"
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance_amount AS DOUBLE))
      comment: "Total remaining balance on active payment plans"
    - name: "avg_installment_amount"
      expr: AVG(CAST(installment_amount AS DOUBLE))
      comment: "Average installment amount for affordability analysis"
    - name: "defaulted_plan_count"
      expr: COUNT(CASE WHEN default_reason IS NOT NULL THEN 1 END)
      comment: "Count of defaulted payment plans for risk monitoring"
    - name: "cancelled_plan_count"
      expr: COUNT(CASE WHEN cancellation_reason IS NOT NULL THEN 1 END)
      comment: "Count of cancelled plans for retention analysis"
    - name: "total_down_payment"
      expr: SUM(CAST(down_payment_amount AS DOUBLE))
      comment: "Total down payments collected at plan enrollment"
$$;