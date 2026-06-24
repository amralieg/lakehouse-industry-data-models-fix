-- Metric views for domain: billing | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 16:05:56

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core billing invoice KPIs tracking revenue cycle performance, payer mix, outstanding balances, and denial activity. Used by Revenue Cycle Management leadership to steer collections, payer negotiations, and denial management strategy."
  source: "`vibe_healthcare_v1`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the invoice (e.g., submitted, paid, denied, voided). Enables segmentation of revenue cycle pipeline stages."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., professional, institutional). Drives payer billing rules and reimbursement strategy analysis."
    - name: "bill_type_code"
      expr: bill_type_code
      comment: "UB-04 bill type code indicating facility type and claim frequency. Used for regulatory and payer-specific reporting."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "CMS place of service code indicating care setting (inpatient, outpatient, office). Enables site-of-care revenue analysis."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month the invoice was generated. Supports monthly revenue cycle trend analysis."
    - name: "service_from_month"
      expr: DATE_TRUNC('MONTH', service_from_date)
      comment: "Month services were rendered. Enables service-period revenue attribution."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the claim (e.g., electronic, paper). Informs clearinghouse and EDI efficiency analysis."
    - name: "collection_status"
      expr: collection_status
      comment: "Current collection status of the invoice. Identifies accounts requiring escalation or write-off decisions."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any appeal filed against a denial. Tracks appeal pipeline and recovery potential."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Payer-assigned denial reason code. Critical for denial root-cause analysis and prevention programs."
    - name: "discharge_status_code"
      expr: discharge_status_code
      comment: "Patient discharge status code. Supports case-mix and post-acute referral revenue analysis."
    - name: "form_type"
      expr: form_type
      comment: "Claim form type (e.g., CMS-1500, UB-04). Differentiates professional vs. institutional billing workflows."
  measures:
    - name: "total_charges"
      expr: SUM(CAST(total_charges AS DOUBLE))
      comment: "Total gross charges billed across all invoices. Represents the top-line revenue ask before adjustments and payments — a primary revenue cycle KPI."
    - name: "total_covered_charges"
      expr: SUM(CAST(covered_charges AS DOUBLE))
      comment: "Sum of charges covered under the patient's insurance plan. Measures the insurer-eligible portion of billed revenue."
    - name: "total_non_covered_charges"
      expr: SUM(CAST(non_covered_charges AS DOUBLE))
      comment: "Sum of charges not covered by insurance. Identifies patient financial responsibility exposure and self-pay risk."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total payer-allowed amount across invoices. Represents the contracted reimbursement ceiling and is the basis for contractual adjustment calculations."
    - name: "total_insurance_payment"
      expr: SUM(CAST(insurance_payment AS DOUBLE))
      comment: "Total payments received from insurance payers. Core cash collections KPI for payer performance benchmarking."
    - name: "total_patient_payment"
      expr: SUM(CAST(patient_payment AS DOUBLE))
      comment: "Total payments received directly from patients. Tracks patient financial responsibility collections and self-pay revenue."
    - name: "total_contractual_adjustment"
      expr: SUM(CAST(contractual_adjustment AS DOUBLE))
      comment: "Total contractual write-downs applied to invoices. Measures the discount given to payers under contracted rates — key for net revenue analysis."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total unpaid balance remaining on invoices. Primary accounts receivable KPI driving collections prioritization."
    - name: "total_patient_responsibility"
      expr: SUM(CAST(patient_responsibility AS DOUBLE))
      comment: "Total amount patients are responsible for paying (copays, deductibles, coinsurance). Drives patient billing strategy and financial counseling programs."
    - name: "total_bad_debt_amount"
      expr: SUM(CAST(bad_debt_amount AS DOUBLE))
      comment: "Total amount written off as bad debt. Measures uncollectable revenue and informs credit risk and charity care policy decisions."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices. Baseline volume metric for revenue cycle throughput and workload analysis."
    - name: "distinct_patient_count"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients billed. Measures patient financial engagement breadth and supports per-patient revenue analysis."
    - name: "denied_invoice_count"
      expr: COUNT(CASE WHEN denial_reason_code IS NOT NULL AND denial_reason_code <> '' THEN invoice_id END)
      comment: "Number of invoices with a denial reason code. Numerator for denial rate calculation — a critical revenue cycle quality metric."
    - name: "avg_outstanding_balance"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average outstanding balance per invoice. Identifies average collection exposure and benchmarks AR aging performance."
    - name: "avg_allowed_amount"
      expr: AVG(CAST(allowed_amount AS DOUBLE))
      comment: "Average payer-allowed amount per invoice. Benchmarks reimbursement adequacy across payers and service types."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Charge capture and revenue integrity KPIs tracking gross charges, billability, voids, and service-level financial performance. Used by charge integrity and CDI teams to identify revenue leakage and capture gaps."
  source: "`vibe_healthcare_v1`.`billing`.`charge`"
  dimensions:
    - name: "charge_status"
      expr: charge_status
      comment: "Current status of the charge (e.g., posted, held, voided). Enables pipeline analysis of charge capture workflow."
    - name: "charge_type"
      expr: charge_type
      comment: "Classification of the charge (e.g., professional, facility, pharmacy). Supports charge mix and revenue category analysis."
    - name: "category"
      expr: category
      comment: "Charge category grouping (e.g., lab, radiology, surgery). Enables service-line revenue analysis."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "CMS place of service code for the charge. Supports site-of-care charge volume and revenue analysis."
    - name: "revenue_code"
      expr: revenue_code
      comment: "UB-04 revenue code associated with the charge. Enables revenue code-level charge and reimbursement analysis."
    - name: "is_billable"
      expr: is_billable
      comment: "Flag indicating whether the charge is billable. Segments billable vs. non-billable charge volume for capture rate analysis."
    - name: "is_voided"
      expr: is_voided
      comment: "Flag indicating the charge was voided. Tracks void rates as a charge integrity quality indicator."
    - name: "is_corrected"
      expr: is_corrected
      comment: "Flag indicating the charge was corrected after initial posting. Measures charge correction frequency as a quality metric."
    - name: "service_date_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month of service for the charge. Enables monthly charge volume and revenue trend analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month the charge was posted to the billing system. Supports charge lag and timely filing analysis."
  measures:
    - name: "total_gross_charge_amount"
      expr: SUM(CAST(gross_charge_amount AS DOUBLE))
      comment: "Total gross charges captured. Top-line charge volume metric for revenue integrity and CDI program performance."
    - name: "total_expected_reimbursement"
      expr: SUM(CAST(expected_reimbursement_amount AS DOUBLE))
      comment: "Total expected reimbursement across charges. Measures anticipated net revenue and supports payer contract performance analysis."
    - name: "total_charge_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total units of service charged. Supports productivity and utilization analysis by service type."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price per charge line. Benchmarks pricing consistency and supports CDM price transparency analysis."
    - name: "avg_gross_charge_amount"
      expr: AVG(CAST(gross_charge_amount AS DOUBLE))
      comment: "Average gross charge per charge line. Identifies charge intensity and case complexity trends."
    - name: "billable_charge_count"
      expr: COUNT(CASE WHEN is_billable = TRUE THEN charge_id END)
      comment: "Number of billable charges. Numerator for billable capture rate — a core charge integrity KPI."
    - name: "voided_charge_count"
      expr: COUNT(CASE WHEN is_voided = TRUE THEN charge_id END)
      comment: "Number of voided charges. Tracks charge void volume as a revenue leakage and workflow quality indicator."
    - name: "corrected_charge_count"
      expr: COUNT(CASE WHEN is_corrected = TRUE THEN charge_id END)
      comment: "Number of corrected charges. Measures charge correction frequency — high rates signal CDM or workflow issues."
    - name: "total_charge_count"
      expr: COUNT(1)
      comment: "Total number of charge lines. Baseline volume metric for charge capture throughput analysis."
    - name: "distinct_visit_count"
      expr: COUNT(DISTINCT visit_id)
      comment: "Number of distinct visits with charges. Measures charge capture breadth across patient encounters."
    - name: "total_billable_gross_charge_amount"
      expr: SUM(CASE WHEN is_billable = TRUE THEN CAST(gross_charge_amount AS DOUBLE) ELSE 0 END)
      comment: "Total gross charges on billable charge lines only. Measures the revenue-eligible charge base for reimbursement forecasting."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash collections and payment performance KPIs tracking payment amounts, refunds, reversals, and payment method mix. Used by Revenue Cycle and Finance leadership to monitor cash flow, payer remittance performance, and patient payment trends."
  source: "`vibe_healthcare_v1`.`billing`.`payment`"
  dimensions:
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g., insurance, patient, self-pay). Enables payer vs. patient cash collections segmentation."
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., posted, reversed, unapplied). Tracks payment lifecycle and unapplied cash exposure."
    - name: "method"
      expr: method
      comment: "Payment method (e.g., check, EFT, credit card, cash). Informs payment channel strategy and processing cost analysis."
    - name: "category"
      expr: category
      comment: "Payment category grouping. Supports classification of payment sources for cash posting analysis."
    - name: "channel"
      expr: channel
      comment: "Channel through which payment was received (e.g., online portal, mail, in-person). Drives patient payment channel optimization."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month payment was received. Enables monthly cash collections trend analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month payment was posted to the billing system. Supports cash posting lag and operational efficiency analysis."
    - name: "posting_status"
      expr: posting_status
      comment: "Status of payment posting (e.g., posted, pending, error). Identifies cash posting backlog and operational bottlenecks."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether the payment was reversed. Segments reversed payments for financial integrity monitoring."
    - name: "refund_flag"
      expr: refund_flag
      comment: "Indicates whether a refund was issued. Tracks refund activity for overpayment and compliance monitoring."
    - name: "source"
      expr: source
      comment: "Source system or origin of the payment record. Supports reconciliation across payment channels and systems."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total cash collected across all payments. Primary cash collections KPI for revenue cycle and finance dashboards."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied to invoices/accounts. Measures effective cash application and reduces unapplied cash risk."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total unapplied payment balance. Tracks cash posting backlog — high unapplied balances signal operational or compliance risk."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refunds issued. Monitors overpayment refund liability and payer/patient refund compliance obligations."
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction. Benchmarks payment size by type and channel for collections strategy."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payment transactions. Baseline volume metric for cash posting throughput and staffing analysis."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN payment_id END)
      comment: "Number of reversed payments. Tracks payment reversal volume as a financial integrity and payer dispute indicator."
    - name: "refund_count"
      expr: COUNT(CASE WHEN refund_flag = TRUE THEN payment_id END)
      comment: "Number of refund transactions. Monitors refund frequency for overpayment management and compliance reporting."
    - name: "distinct_payer_count"
      expr: COUNT(DISTINCT payer_id)
      comment: "Number of distinct payers remitting payments. Measures payer mix breadth and supports payer performance benchmarking."
    - name: "total_reversed_amount"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total dollar value of reversed payments. Quantifies financial exposure from payment reversals — key for net cash reconciliation."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing adjustment KPIs tracking contractual write-downs, write-offs, reversals, and appeal activity. Used by Revenue Cycle leadership to monitor net revenue realization, payer contract performance, and write-off policy compliance."
  source: "`vibe_healthcare_v1`.`billing`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (e.g., contractual, write-off, administrative). Enables segmentation of adjustment categories for net revenue analysis."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment (e.g., posted, pending, reversed). Tracks adjustment lifecycle and pending write-off exposure."
    - name: "category"
      expr: category
      comment: "Adjustment category grouping. Supports classification of adjustments by business reason for financial reporting."
    - name: "reason_code"
      expr: reason_code
      comment: "Adjustment reason code (e.g., CO-45, PR-1). Enables root-cause analysis of contractual and non-contractual adjustments."
    - name: "write_off_classification"
      expr: write_off_classification
      comment: "Classification of write-off type (e.g., bad debt, charity, small balance). Drives write-off policy compliance and 501(r) reporting."
    - name: "contractual_payer_name"
      expr: contractual_payer_name
      comment: "Name of the payer associated with the contractual adjustment. Enables payer-level contract performance and discount analysis."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether the adjustment was reversed. Segments reversed adjustments for financial integrity monitoring."
    - name: "appeal_flag"
      expr: appeal_flag
      comment: "Indicates whether an appeal is associated with this adjustment. Tracks appeal-linked adjustments for recovery opportunity analysis."
    - name: "adjustment_date_month"
      expr: DATE_TRUNC('MONTH', adjustment_date)
      comment: "Month the adjustment was applied. Enables monthly adjustment trend and net revenue analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the adjustment. Identifies unreconciled adjustments requiring financial close attention."
  measures:
    - name: "total_adjustment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total dollar value of all adjustments. Measures the aggregate impact of write-downs and write-offs on net revenue — a primary revenue integrity KPI."
    - name: "total_contract_rate_amount"
      expr: SUM(CAST(contract_rate AS DOUBLE))
      comment: "Total contracted rate amounts associated with adjustments. Benchmarks actual adjustments against contracted rates for payer contract compliance."
    - name: "avg_adjustment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average adjustment amount per transaction. Identifies adjustment size trends by type and payer for contract renegotiation insights."
    - name: "adjustment_count"
      expr: COUNT(1)
      comment: "Total number of adjustment transactions. Baseline volume metric for adjustment activity and workload analysis."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN adjustment_id END)
      comment: "Number of reversed adjustments. Tracks adjustment reversal frequency as a financial integrity and posting accuracy indicator."
    - name: "appeal_linked_adjustment_count"
      expr: COUNT(CASE WHEN appeal_flag = TRUE THEN adjustment_id END)
      comment: "Number of adjustments linked to an appeal. Measures appeal-driven adjustment activity and recovery program scope."
    - name: "total_write_off_amount"
      expr: SUM(CASE WHEN write_off_classification IS NOT NULL AND write_off_classification <> '' THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total amount written off across all write-off classifications. Tracks total write-off exposure for bad debt, charity, and small balance programs."
    - name: "distinct_claim_count"
      expr: COUNT(DISTINCT claim_id)
      comment: "Number of distinct claims with adjustments. Measures the breadth of claim-level adjustment activity for denial and underpayment analysis."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_patient_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient account financial health KPIs tracking account balances, bad debt, collections, and financial assistance. Used by Patient Financial Services and CFO to monitor self-pay portfolio health, collections effectiveness, and charity care program utilization."
  source: "`vibe_healthcare_v1`.`billing`.`patient_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the patient account (e.g., active, closed, collections). Enables AR portfolio segmentation by lifecycle stage."
    - name: "account_type"
      expr: account_type
      comment: "Type of patient account (e.g., self-pay, insured, guarantor). Drives payer mix and self-pay portfolio analysis."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "AR aging bucket (e.g., 0-30, 31-60, 61-90, 90+ days). Primary dimension for AR aging analysis and collections prioritization."
    - name: "collection_status"
      expr: collection_status
      comment: "Current collections status of the account. Tracks accounts in pre-collections, active collections, and agency referral stages."
    - name: "financial_assistance_eligibility"
      expr: financial_assistance_eligibility
      comment: "Patient financial assistance eligibility status. Supports charity care program utilization and 501(r) compliance reporting."
    - name: "financial_assistance_approval_status"
      expr: financial_assistance_approval_status
      comment: "Approval status of financial assistance application. Tracks charity care approval pipeline and program effectiveness."
    - name: "bad_debt_flag"
      expr: bad_debt_flag
      comment: "Indicates whether the account has been referred to bad debt. Segments bad debt accounts for write-off and recovery analysis."
    - name: "payment_plan_flag"
      expr: payment_plan_flag
      comment: "Indicates whether the account is on a payment plan. Tracks payment plan enrollment rates and self-pay resolution strategy."
    - name: "irs_501r_compliance_flag"
      expr: irs_501r_compliance_flag
      comment: "Indicates IRS 501(r) compliance status for the account. Critical for nonprofit hospital regulatory compliance monitoring."
    - name: "account_opened_month"
      expr: DATE_TRUNC('MONTH', account_opened_date)
      comment: "Month the patient account was opened. Enables cohort-based AR aging and collections performance analysis."
  measures:
    - name: "total_account_balance"
      expr: SUM(CAST(account_balance AS DOUBLE))
      comment: "Total outstanding balance across all patient accounts. Primary self-pay AR KPI for patient financial services leadership."
    - name: "total_patient_balance"
      expr: SUM(CAST(patient_balance AS DOUBLE))
      comment: "Total patient-responsible balance. Measures patient financial obligation exposure and drives collections prioritization."
    - name: "total_insurance_balance"
      expr: SUM(CAST(insurance_balance AS DOUBLE))
      comment: "Total insurance-responsible balance. Tracks payer AR exposure and identifies slow-paying payers."
    - name: "total_bad_debt_amount"
      expr: SUM(CAST(bad_debt_amount AS DOUBLE))
      comment: "Total bad debt amount across patient accounts. Measures uncollectable self-pay exposure and informs write-off policy decisions."
    - name: "total_recovered_amount"
      expr: SUM(CAST(recovered_amount AS DOUBLE))
      comment: "Total amount recovered from previously written-off or bad debt accounts. Measures collections recovery program effectiveness."
    - name: "total_original_balance"
      expr: SUM(CAST(original_balance AS DOUBLE))
      comment: "Total original balance at account creation. Denominator for collection rate calculation — measures total financial obligation created."
    - name: "total_total_payments"
      expr: SUM(CAST(total_payments AS DOUBLE))
      comment: "Total payments received across patient accounts. Measures cumulative cash collections at the account level."
    - name: "total_total_adjustments"
      expr: SUM(CAST(total_adjustments AS DOUBLE))
      comment: "Total adjustments applied across patient accounts. Tracks aggregate write-down activity at the account portfolio level."
    - name: "avg_account_balance"
      expr: AVG(CAST(account_balance AS DOUBLE))
      comment: "Average outstanding balance per patient account. Benchmarks account-level AR exposure and identifies high-balance outliers."
    - name: "avg_fpl_percentage"
      expr: AVG(CAST(fpl_percentage AS DOUBLE))
      comment: "Average Federal Poverty Level percentage across accounts. Informs financial assistance program eligibility thresholds and charity care policy."
    - name: "bad_debt_account_count"
      expr: COUNT(CASE WHEN bad_debt_flag = TRUE THEN patient_account_id END)
      comment: "Number of accounts flagged as bad debt. Tracks bad debt referral volume for write-off authorization and collections agency management."
    - name: "payment_plan_account_count"
      expr: COUNT(CASE WHEN payment_plan_flag = TRUE THEN patient_account_id END)
      comment: "Number of accounts enrolled in a payment plan. Measures payment plan adoption rate as a self-pay resolution strategy KPI."
    - name: "total_referred_balance"
      expr: SUM(CAST(referred_balance AS DOUBLE))
      comment: "Total balance referred to collections agencies. Tracks collections agency referral volume and associated recovery expectations."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice line-level reimbursement and denial KPIs tracking paid amounts, contractual adjustments, patient responsibility, and RVU-based productivity. Used by Revenue Cycle and Clinical Finance to analyze line-level reimbursement performance and denial patterns."
  source: "`vibe_healthcare_v1`.`billing`.`invoice_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the invoice line (e.g., paid, denied, pending). Enables line-level revenue cycle pipeline analysis."
    - name: "revenue_code"
      expr: revenue_code
      comment: "UB-04 revenue code for the invoice line. Enables revenue code-level reimbursement and denial analysis."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service code for the invoice line. Supports site-of-care reimbursement analysis."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Denial reason code at the line level. Enables granular denial root-cause analysis for prevention programs."
    - name: "claim_adjustment_group_code"
      expr: claim_adjustment_group_code
      comment: "ANSI X12 claim adjustment group code (e.g., CO, PR, OA). Classifies the type of adjustment applied to the line."
    - name: "claim_adjustment_reason_code"
      expr: claim_adjustment_reason_code
      comment: "ANSI X12 claim adjustment reason code. Provides specific reason for payer adjustments — critical for underpayment identification."
    - name: "service_date_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month of service for the invoice line. Enables monthly reimbursement trend analysis."
    - name: "modifier_1"
      expr: modifier_1
      comment: "Primary procedure modifier. Supports modifier-level reimbursement analysis and coding compliance review."
    - name: "service_location_code"
      expr: service_location_code
      comment: "Service location code for the invoice line. Enables facility-level reimbursement and denial analysis."
  measures:
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total billed charge amount at the invoice line level. Measures gross revenue ask at the most granular billing unit."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total payer-allowed amount at the line level. Measures contracted reimbursement ceiling for line-level underpayment analysis."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount paid by payers at the line level. Primary reimbursement collections KPI for line-level revenue analysis."
    - name: "total_contractual_adjustment_amount"
      expr: SUM(CAST(contractual_adjustment_amount AS DOUBLE))
      comment: "Total contractual adjustments at the line level. Measures payer discount impact on net revenue at the procedure level."
    - name: "total_patient_responsibility_amount"
      expr: SUM(CAST(patient_responsibility_amount AS DOUBLE))
      comment: "Total patient responsibility at the line level. Tracks patient financial obligation by procedure and service type."
    - name: "total_rvu_work"
      expr: SUM(CAST(rvu_work AS DOUBLE))
      comment: "Total work RVUs across invoice lines. Measures physician work productivity and supports value-based reimbursement analysis."
    - name: "total_rvu_practice_expense"
      expr: SUM(CAST(rvu_practice_expense AS DOUBLE))
      comment: "Total practice expense RVUs. Supports cost allocation and overhead analysis by service type."
    - name: "total_units_billed"
      expr: SUM(CAST(units AS DOUBLE))
      comment: "Total units of service billed. Measures service volume at the line level for productivity and utilization analysis."
    - name: "avg_paid_amount"
      expr: AVG(CAST(paid_amount AS DOUBLE))
      comment: "Average paid amount per invoice line. Benchmarks reimbursement adequacy by procedure, modifier, and payer."
    - name: "denied_line_count"
      expr: COUNT(CASE WHEN denial_reason_code IS NOT NULL AND denial_reason_code <> '' THEN invoice_line_id END)
      comment: "Number of denied invoice lines. Numerator for line-level denial rate — a critical revenue cycle quality and recovery KPI."
    - name: "invoice_line_count"
      expr: COUNT(1)
      comment: "Total number of invoice lines. Baseline volume metric for billing throughput and line-level workload analysis."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_payment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient payment plan portfolio KPIs tracking plan balances, completion rates, default activity, and financial assistance linkage. Used by Patient Financial Services to monitor self-pay resolution program performance and default risk."
  source: "`vibe_healthcare_v1`.`billing`.`payment_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the payment plan (e.g., active, completed, defaulted, cancelled). Enables portfolio segmentation by plan lifecycle stage."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of payment plan (e.g., interest-free, interest-bearing, charity). Supports plan type performance and adoption analysis."
    - name: "installment_frequency"
      expr: installment_frequency
      comment: "Frequency of installment payments (e.g., monthly, bi-weekly). Informs payment plan design and patient affordability analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for plan installments (e.g., auto-pay, check, credit card). Tracks auto-pay adoption and default risk by method."
    - name: "auto_pay_flag"
      expr: auto_pay_flag
      comment: "Indicates whether the plan is enrolled in auto-pay. Auto-pay enrollment is a strong predictor of plan completion — key for default risk analysis."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the patient enrolled in the plan (e.g., online, in-person, phone). Drives channel optimization for payment plan enrollment."
    - name: "financial_assistance_program_code"
      expr: financial_assistance_program_code
      comment: "Financial assistance program linked to the payment plan. Tracks charity care and sliding-scale program utilization within payment plans."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month the patient enrolled in the payment plan. Enables cohort-based plan performance and default rate analysis."
  measures:
    - name: "total_plan_amount"
      expr: SUM(CAST(total_plan_amount AS DOUBLE))
      comment: "Total dollar value of all payment plans. Measures the aggregate self-pay obligation being managed through structured payment arrangements."
    - name: "total_paid_amount"
      expr: SUM(CAST(total_paid_amount AS DOUBLE))
      comment: "Total amount paid across all payment plans. Measures cash collected through payment plan arrangements — a key self-pay collections KPI."
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance_amount AS DOUBLE))
      comment: "Total remaining balance across active payment plans. Tracks outstanding self-pay obligation in structured repayment — key for cash flow forecasting."
    - name: "total_original_balance"
      expr: SUM(CAST(original_balance_amount AS DOUBLE))
      comment: "Total original balance at plan creation. Denominator for payment plan collection rate calculation."
    - name: "total_down_payment_amount"
      expr: SUM(CAST(down_payment_amount AS DOUBLE))
      comment: "Total down payments collected at plan enrollment. Measures upfront cash capture from payment plan enrollment programs."
    - name: "avg_installment_amount"
      expr: AVG(CAST(installment_amount AS DOUBLE))
      comment: "Average monthly installment amount. Benchmarks payment plan affordability and informs plan design for patient financial counseling."
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate_percentage AS DOUBLE))
      comment: "Average interest rate across payment plans. Monitors interest-bearing plan prevalence and patient financial burden."
    - name: "payment_plan_count"
      expr: COUNT(1)
      comment: "Total number of payment plans. Baseline volume metric for self-pay resolution program scale."
    - name: "auto_pay_enrolled_count"
      expr: COUNT(CASE WHEN auto_pay_flag = TRUE THEN payment_plan_id END)
      comment: "Number of plans enrolled in auto-pay. Measures auto-pay adoption rate — a leading indicator of plan completion and reduced default risk."
    - name: "defaulted_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'defaulted' THEN payment_plan_id END)
      comment: "Number of payment plans in default status. Tracks default rate as a self-pay portfolio risk KPI requiring collections intervention."
    - name: "total_late_fee_amount"
      expr: SUM(CAST(late_fee_amount AS DOUBLE))
      comment: "Total late fees assessed across payment plans. Monitors late payment frequency and patient financial hardship indicators."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`billing_coding_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical coding and CDI (Clinical Documentation Improvement) KPIs tracking coding accuracy, DRG reimbursement impact, and CDI query performance. Used by HIM, CDI, and Revenue Cycle leadership to optimize DRG assignment, coding quality, and expected reimbursement."
  source: "`vibe_healthcare_v1`.`billing`.`coding_assignment`"
  dimensions:
    - name: "coding_status"
      expr: coding_status
      comment: "Current status of the coding assignment (e.g., complete, pending, queried). Tracks coding workflow throughput and backlog."
    - name: "coding_method"
      expr: coding_method
      comment: "Method used for coding (e.g., manual, computer-assisted, AI-assisted). Supports coding productivity and accuracy analysis by method."
    - name: "mdc_code"
      expr: mdc_code
      comment: "Major Diagnostic Category code. Enables case-mix and reimbursement analysis by clinical service line."
    - name: "mdc_description"
      expr: mdc_description
      comment: "Description of the Major Diagnostic Category. Provides human-readable service line grouping for executive reporting."
    - name: "discharge_disposition_code"
      expr: discharge_disposition_code
      comment: "Patient discharge disposition code. Supports post-acute care referral and readmission risk analysis."
    - name: "complication_comorbidity_flag"
      expr: complication_comorbidity_flag
      comment: "Indicates presence of a complication or comorbidity (CC). CC/MCC capture rate is a primary CDI program performance metric."
    - name: "major_complication_comorbidity_flag"
      expr: major_complication_comorbidity_flag
      comment: "Indicates presence of a major complication or comorbidity (MCC). MCC capture drives higher DRG weights and reimbursement."
    - name: "audit_flag"
      expr: audit_flag
      comment: "Indicates whether the coding assignment was audited. Segments audited cases for coding accuracy and compliance analysis."
    - name: "coding_date_month"
      expr: DATE_TRUNC('MONTH', coding_date)
      comment: "Month coding was completed. Enables monthly coding productivity and CDI program performance trend analysis."
    - name: "cdi_query_type"
      expr: cdi_query_type
      comment: "Type of CDI query issued (e.g., clarification, specificity, diagnosis). Supports CDI query mix and physician response analysis."
  measures:
    - name: "total_expected_reimbursement"
      expr: SUM(CAST(expected_reimbursement_amount AS DOUBLE))
      comment: "Total expected reimbursement based on DRG assignment. Primary CDI program financial impact KPI — measures revenue captured through accurate coding."
    - name: "total_cdi_drg_impact_amount"
      expr: SUM(CAST(cdi_drg_impact_amount AS DOUBLE))
      comment: "Total financial impact of CDI-driven DRG changes. Directly measures CDI program ROI — a critical KPI for CDI program investment decisions."
    - name: "avg_coding_accuracy_score"
      expr: AVG(CAST(coding_accuracy_score AS DOUBLE))
      comment: "Average coding accuracy score across assignments. Measures coding quality program performance and compliance risk."
    - name: "avg_arithmetic_mean_los"
      expr: AVG(CAST(arithmetic_mean_los AS DOUBLE))
      comment: "Average arithmetic mean length of stay for assigned DRGs. Benchmarks actual LOS against DRG norms for efficiency and outlier payment analysis."
    - name: "avg_geometric_mean_los"
      expr: AVG(CAST(geometric_mean_los AS DOUBLE))
      comment: "Average geometric mean length of stay for assigned DRGs. CMS uses geometric mean LOS for outlier payment thresholds — key for inlier/outlier analysis."
    - name: "coding_assignment_count"
      expr: COUNT(1)
      comment: "Total number of coding assignments. Baseline volume metric for HIM coding productivity and workload management."
    - name: "cc_capture_count"
      expr: COUNT(CASE WHEN complication_comorbidity_flag = TRUE THEN coding_assignment_id END)
      comment: "Number of cases with a CC captured. Measures CC capture rate — a primary CDI program quality and reimbursement optimization KPI."
    - name: "mcc_capture_count"
      expr: COUNT(CASE WHEN major_complication_comorbidity_flag = TRUE THEN coding_assignment_id END)
      comment: "Number of cases with an MCC captured. MCC capture drives the highest DRG weight tier — critical for CDI program ROI measurement."
    - name: "audited_case_count"
      expr: COUNT(CASE WHEN audit_flag = TRUE THEN coding_assignment_id END)
      comment: "Number of coding assignments that were audited. Tracks coding audit coverage rate for compliance and quality assurance programs."
    - name: "avg_outlier_threshold_amount"
      expr: AVG(CAST(outlier_threshold_amount AS DOUBLE))
      comment: "Average outlier threshold amount for assigned DRGs. Identifies cases approaching cost outlier thresholds for proactive case management."
$$;