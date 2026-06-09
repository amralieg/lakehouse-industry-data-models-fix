-- Metric views for domain: billing | Business: Education | Version: 1 | Generated on: 2026-05-06 15:08:33

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`billing_tuition_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over tuition and fee charges. Tracks gross revenue, net revenue after waivers and adjustments, credit-hour yield, and charge composition by program level, charge type, and student type. Used by Finance and the Provost office to monitor tuition revenue health and fee structure effectiveness."
  source: "`education_ecm`.`billing`.`tuition_charge`"
  dimensions:
    - name: "charge_type"
      expr: charge_type
      comment: "Category of the charge (e.g., Tuition, Housing, Dining, Lab Fee). Enables revenue decomposition by charge category."
    - name: "charge_status"
      expr: charge_status
      comment: "Current lifecycle status of the charge (e.g., Posted, Reversed, Pending). Used to filter to active vs. reversed charges."
    - name: "program_level"
      expr: program_level
      comment: "Academic program level (e.g., Undergraduate, Graduate, Doctoral). Key dimension for tuition revenue segmentation."
    - name: "student_type"
      expr: student_type
      comment: "Classification of the student (e.g., Domestic, International, Transfer). Drives pricing and revenue mix analysis."
    - name: "billing_method"
      expr: billing_method
      comment: "Method used to bill the charge (e.g., Per Credit Hour, Flat Rate). Informs fee structure and rate-setting decisions."
    - name: "revenue_category"
      expr: revenue_category
      comment: "Revenue classification for financial reporting (e.g., Instructional, Auxiliary). Supports fund accounting and budget variance analysis."
    - name: "is_reportable_1098t"
      expr: is_reportable_1098t
      comment: "Indicates whether the charge is reportable on IRS Form 1098-T. Critical for tax compliance reporting."
    - name: "is_refundable"
      expr: is_refundable
      comment: "Indicates whether the charge is eligible for refund. Informs refund liability exposure analysis."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month in which the charge was assessed. Enables monthly revenue trend analysis."
    - name: "posted_date_month"
      expr: DATE_TRUNC('MONTH', posted_date)
      comment: "Month in which the charge was posted to the ledger. Supports period-close revenue recognition tracking."
  measures:
    - name: "total_gross_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total gross tuition and fee charges assessed before waivers or adjustments. Primary revenue top-line KPI for Finance and the CFO."
    - name: "total_waiver_amount"
      expr: SUM(CAST(waiver_amount AS DOUBLE))
      comment: "Total dollar value of waivers applied to charges. Tracks institutional discount and benefit cost exposure."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total post-assessment adjustments (credits, corrections) applied to charges. Monitors billing correction volume and financial impact."
    - name: "total_net_charge_amount"
      expr: SUM(CAST(net_charge_amount AS DOUBLE))
      comment: "Total net revenue after waivers and adjustments. The definitive net tuition revenue figure used in budget-to-actual reporting."
    - name: "total_credit_hours_billed"
      expr: SUM(CAST(credit_hours AS DOUBLE))
      comment: "Total credit hours underlying assessed charges. Used to compute per-credit-hour yield and enrollment-revenue correlation."
    - name: "avg_charge_amount_per_record"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average gross charge amount per charge record. Benchmarks typical charge size and detects anomalous billing events."
    - name: "avg_net_charge_amount_per_record"
      expr: AVG(CAST(net_charge_amount AS DOUBLE))
      comment: "Average net charge amount per record after waivers and adjustments. Reflects effective realized revenue per billing event."
    - name: "avg_rate_per_credit_hour"
      expr: AVG(CAST(rate_per_credit_hour AS DOUBLE))
      comment: "Average per-credit-hour rate across all charge records. Key pricing benchmark for tuition rate-setting and competitive analysis."
    - name: "total_flat_rate_amount"
      expr: SUM(CAST(flat_rate_amount AS DOUBLE))
      comment: "Total flat-rate charges assessed (non-per-credit-hour billing). Tracks revenue from flat-rate program structures."
    - name: "count_distinct_student_accounts_charged"
      expr: COUNT(DISTINCT student_account_id)
      comment: "Number of unique student accounts with at least one charge. Measures billing reach and active student financial engagement."
    - name: "count_charge_records"
      expr: COUNT(1)
      comment: "Total number of charge records assessed. Baseline volume metric for billing operations throughput monitoring."
    - name: "waiver_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(waiver_amount AS DOUBLE)) / NULLIF(SUM(CAST(charge_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross charges offset by waivers. Measures institutional discount depth; high rates signal revenue leakage risk."
    - name: "refundable_charge_amount"
      expr: SUM(CASE WHEN is_refundable = TRUE THEN CAST(charge_amount AS DOUBLE) ELSE 0 END)
      comment: "Total gross charge amount on refundable charges. Quantifies maximum refund liability exposure on the books."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over student payment transactions. Tracks payment volume, net cash collected, processing costs, refund exposure, and payment method mix. Used by the Bursar and CFO to monitor cash collection efficiency, channel performance, and payment reversal risk."
  source: "`education_ecm`.`billing`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Lifecycle status of the payment (e.g., Posted, Reversed, Pending, Cleared). Essential for filtering to settled vs. in-flight payments."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to make the payment (e.g., ACH, Credit Card, Check, Wire). Drives channel cost and adoption analysis."
    - name: "payer_type"
      expr: payer_type
      comment: "Classification of who made the payment (e.g., Student, Parent, Sponsor, Employer). Informs third-party billing and collections strategy."
    - name: "channel"
      expr: channel
      comment: "Payment intake channel (e.g., Online Portal, In-Person, Mail). Used to optimize channel investment and self-service adoption."
    - name: "card_type"
      expr: card_type
      comment: "Card network type for card payments (e.g., Visa, Mastercard, Amex). Informs interchange cost analysis and card acceptance policy."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code of the payment. Supports multi-currency revenue reconciliation for international student billing."
    - name: "is_refundable"
      expr: is_refundable
      comment: "Indicates whether the payment is eligible for refund. Quantifies refund liability on collected payments."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment. Enables monthly cash collection trend and seasonality analysis."
    - name: "deposit_date_month"
      expr: DATE_TRUNC('MONTH', deposit_date)
      comment: "Month of bank deposit. Used to reconcile payment receipt timing against deposit clearing cycles."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross payment amount collected. Primary cash collection KPI for the Bursar and CFO."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment amount after processing fees. Reflects actual cash retained by the institution."
    - name: "total_processing_fee_amount"
      expr: SUM(CAST(processing_fee AS DOUBLE))
      comment: "Total payment processing fees incurred. Tracks cost of payment acceptance; informs fee pass-through and channel policy decisions."
    - name: "total_base_currency_amount"
      expr: SUM(CAST(base_currency_amount AS DOUBLE))
      comment: "Total payment amount converted to institutional base currency. Enables consistent multi-currency revenue reporting."
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction. Benchmarks typical payment size and detects anomalous large or small payments."
    - name: "avg_processing_fee_per_payment"
      expr: AVG(CAST(processing_fee AS DOUBLE))
      comment: "Average processing fee per payment transaction. Used to model cost-per-payment by channel and method."
    - name: "count_payments"
      expr: COUNT(1)
      comment: "Total number of payment transactions. Baseline volume metric for Bursar operations and payment processor SLA monitoring."
    - name: "count_distinct_student_accounts_paid"
      expr: COUNT(DISTINCT student_account_id)
      comment: "Number of unique student accounts that made at least one payment. Measures payment participation rate across the student population."
    - name: "count_reversed_payments"
      expr: COUNT(CASE WHEN payment_status = 'Reversed' THEN 1 END)
      comment: "Number of reversed payment transactions. High reversal counts signal fraud risk, NSF issues, or billing errors requiring investigation."
    - name: "total_reversed_payment_amount"
      expr: SUM(CASE WHEN payment_status = 'Reversed' THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total dollar value of reversed payments. Quantifies cash collection risk and revenue recognition adjustments needed."
    - name: "processing_fee_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(processing_fee AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Processing fees as a percentage of gross payments. Key cost efficiency ratio for payment channel management and vendor negotiation."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN payment_status = 'Reversed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payment transactions that were reversed. Monitors payment quality and fraud/NSF exposure rate."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`billing_student_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over student financial accounts. Tracks outstanding balances, collections exposure, hold prevalence, payment plan enrollment, and 1098-T eligibility. Used by the Bursar, CFO, and Student Services to manage receivables health and student financial standing."
  source: "`education_ecm`.`billing`.`student_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the student account (e.g., Active, Closed, Collections). Primary filter for receivables aging and collections analysis."
    - name: "account_type"
      expr: account_type
      comment: "Type of student account (e.g., Standard, Third-Party, Employee). Enables segmentation of billing population by account structure."
    - name: "collections_status"
      expr: collections_status
      comment: "Collections lifecycle status (e.g., Current, Delinquent, Referred, Written-Off). Drives collections prioritization and bad-debt reserve decisions."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code of the account. Supports multi-currency receivables reporting for international student accounts."
    - name: "payment_plan_enrolled"
      expr: payment_plan_enrolled
      comment: "Indicates whether the student is enrolled in a payment plan. Measures payment plan adoption rate across the student population."
    - name: "has_registration_hold"
      expr: has_registration_hold
      comment: "Indicates whether the account has a registration hold. Tracks financial hold prevalence impacting enrollment operations."
    - name: "has_transcript_hold"
      expr: has_transcript_hold
      comment: "Indicates whether the account has a transcript hold. Monitors financial barriers to student credential access."
    - name: "has_graduation_hold"
      expr: has_graduation_hold
      comment: "Indicates whether the account has a graduation hold. Tracks financial barriers to degree completion and commencement."
    - name: "third_party_billing_flag"
      expr: third_party_billing_flag
      comment: "Indicates whether the account is billed to a third-party sponsor. Enables sponsor billing volume and receivables segmentation."
    - name: "tax_form_1098t_eligible"
      expr: tax_form_1098t_eligible
      comment: "Indicates whether the account is eligible for IRS Form 1098-T. Critical for tax compliance population sizing."
    - name: "account_opened_date_month"
      expr: DATE_TRUNC('MONTH', account_opened_date)
      comment: "Month the account was opened. Enables cohort analysis of new student account creation aligned to enrollment cycles."
  measures:
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total outstanding balance across all student accounts. Primary accounts receivable KPI for the CFO and Bursar."
    - name: "total_pending_charges"
      expr: SUM(CAST(pending_charges AS DOUBLE))
      comment: "Total charges assessed but not yet posted. Measures near-term revenue recognition pipeline."
    - name: "total_pending_financial_aid"
      expr: SUM(CAST(pending_financial_aid AS DOUBLE))
      comment: "Total financial aid anticipated but not yet disbursed. Quantifies expected aid offset against outstanding balances."
    - name: "total_anticipated_balance"
      expr: SUM(CAST(anticipated_balance AS DOUBLE))
      comment: "Total anticipated net balance after pending aid and charges. Forward-looking receivables exposure metric for cash flow planning."
    - name: "total_cumulative_charges"
      expr: SUM(CAST(cumulative_charges AS DOUBLE))
      comment: "Total lifetime charges across all student accounts. Measures total billing volume generated by the institution."
    - name: "total_cumulative_payments"
      expr: SUM(CAST(cumulative_payments AS DOUBLE))
      comment: "Total lifetime payments received across all student accounts. Measures total cash collected against billed charges."
    - name: "total_cumulative_adjustments"
      expr: SUM(CAST(cumulative_adjustments AS DOUBLE))
      comment: "Total lifetime adjustments applied across all student accounts. Tracks billing correction and credit volume over time."
    - name: "avg_current_balance_per_account"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average outstanding balance per student account. Benchmarks typical student debt load and identifies high-balance cohorts."
    - name: "count_accounts"
      expr: COUNT(1)
      comment: "Total number of student accounts. Baseline population metric for receivables and billing operations."
    - name: "count_accounts_with_balance"
      expr: COUNT(CASE WHEN current_balance > 0 THEN 1 END)
      comment: "Number of accounts carrying a positive outstanding balance. Measures the active receivables population requiring collection action."
    - name: "count_accounts_in_collections"
      expr: COUNT(CASE WHEN collections_status IS NOT NULL AND collections_status != 'Current' THEN 1 END)
      comment: "Number of accounts in a non-current collections status. Tracks delinquency population size for collections resource planning."
    - name: "count_accounts_with_registration_hold"
      expr: COUNT(CASE WHEN has_registration_hold = TRUE THEN 1 END)
      comment: "Number of accounts with an active registration hold. Monitors financial barriers to enrollment; high counts require Bursar intervention."
    - name: "count_accounts_with_graduation_hold"
      expr: COUNT(CASE WHEN has_graduation_hold = TRUE THEN 1 END)
      comment: "Number of accounts with an active graduation hold. Tracks financial barriers to degree completion; escalated to senior leadership."
    - name: "payment_plan_enrollment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN payment_plan_enrolled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of student accounts enrolled in a payment plan. Measures payment plan adoption; low rates may indicate access or awareness gaps."
    - name: "collections_balance_amount"
      expr: SUM(CASE WHEN collections_status IS NOT NULL AND collections_status != 'Current' THEN CAST(current_balance AS DOUBLE) ELSE 0 END)
      comment: "Total outstanding balance on accounts in collections. Quantifies bad-debt exposure and informs reserve adequacy assessment."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`billing_payment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over student payment plans. Tracks plan enrollment, outstanding balances, completion rates, late fee exposure, and default risk. Used by the Bursar and Student Financial Services to manage installment plan health and student payment compliance."
  source: "`education_ecm`.`billing`.`payment_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the payment plan (e.g., Active, Completed, Defaulted, Cancelled). Primary dimension for plan health segmentation."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of payment plan (e.g., Standard, Extended, Employer-Sponsored). Enables plan structure performance comparison."
    - name: "installment_frequency"
      expr: installment_frequency
      comment: "Frequency of installment payments (e.g., Monthly, Bi-Weekly). Informs plan design and cash flow forecasting."
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Payment method associated with the plan (e.g., ACH, Credit Card). Drives auto-pay adoption and failure rate analysis."
    - name: "auto_pay_enabled_flag"
      expr: auto_pay_enabled_flag
      comment: "Indicates whether auto-pay is enabled on the plan. Measures auto-pay adoption rate and its correlation with on-time payment performance."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the payment plan became effective. Enables cohort analysis of plan enrollment aligned to term billing cycles."
  measures:
    - name: "total_plan_amount"
      expr: SUM(CAST(total_plan_amount AS DOUBLE))
      comment: "Total dollar value of all payment plans. Measures the total receivables committed to installment billing structures."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance_amount AS DOUBLE))
      comment: "Total remaining balance outstanding across all payment plans. Primary KPI for installment receivables exposure."
    - name: "total_paid_amount"
      expr: SUM(CAST(total_paid_amount AS DOUBLE))
      comment: "Total amount paid to date across all payment plans. Measures cash collected through installment structures."
    - name: "total_enrollment_fee_revenue"
      expr: SUM(CAST(enrollment_fee_amount AS DOUBLE))
      comment: "Total enrollment fees collected for payment plan setup. Tracks ancillary fee revenue from installment plan administration."
    - name: "total_late_fee_assessed"
      expr: SUM(CAST(late_fee_amount AS DOUBLE))
      comment: "Total late fees assessed on payment plans. Measures delinquency cost burden on students and late payment prevalence."
    - name: "total_down_payment_amount"
      expr: SUM(CAST(down_payment_amount AS DOUBLE))
      comment: "Total down payments collected at plan enrollment. Tracks upfront cash collection from installment plan participants."
    - name: "avg_outstanding_balance_per_plan"
      expr: AVG(CAST(outstanding_balance_amount AS DOUBLE))
      comment: "Average remaining balance per payment plan. Benchmarks typical installment debt load and identifies high-risk plan cohorts."
    - name: "avg_interest_rate_pct"
      expr: AVG(CAST(interest_rate_percent AS DOUBLE))
      comment: "Average interest rate across payment plans. Monitors pricing consistency and compliance with institutional interest rate policy."
    - name: "count_payment_plans"
      expr: COUNT(1)
      comment: "Total number of payment plans. Baseline volume metric for installment plan program scale."
    - name: "count_defaulted_plans"
      expr: COUNT(CASE WHEN plan_status = 'Defaulted' THEN 1 END)
      comment: "Number of payment plans in default status. Critical risk indicator for collections escalation and bad-debt reserve decisions."
    - name: "count_active_plans"
      expr: COUNT(CASE WHEN plan_status = 'Active' THEN 1 END)
      comment: "Number of currently active payment plans. Measures live installment plan portfolio size for operational planning."
    - name: "plan_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN plan_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payment plans successfully completed. Key success rate KPI for the payment plan program; low rates signal structural design issues."
    - name: "plan_default_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN plan_status = 'Defaulted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payment plans that defaulted. Primary risk KPI for the installment program; triggers policy review when elevated."
    - name: "auto_pay_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_pay_enabled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payment plans with auto-pay enabled. Higher auto-pay adoption correlates with lower default rates and reduced collections cost."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`billing_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over student refund transactions. Tracks refund volume, Title IV return obligations, processing timeliness, and refund method mix. Used by the Bursar, Financial Aid, and Compliance to manage refund liability, regulatory compliance, and cash outflow."
  source: "`education_ecm`.`billing`.`refund`"
  dimensions:
    - name: "refund_status"
      expr: refund_status
      comment: "Current lifecycle status of the refund (e.g., Pending, Processed, Cancelled). Enables pipeline vs. completed refund analysis."
    - name: "refund_type"
      expr: refund_type
      comment: "Classification of the refund (e.g., Overpayment, Financial Aid Excess, Withdrawal). Drives root-cause analysis of refund drivers."
    - name: "refund_method"
      expr: refund_method
      comment: "Method used to issue the refund (e.g., ACH, Check, Original Payment Method). Informs refund channel cost and speed analysis."
    - name: "is_title_iv_refund"
      expr: is_title_iv_refund
      comment: "Indicates whether the refund is a Title IV Return of Funds. Critical regulatory compliance dimension for federal financial aid audits."
    - name: "is_reportable_1098t"
      expr: is_reportable_1098t
      comment: "Indicates whether the refund is reportable on IRS Form 1098-T. Required for tax compliance reporting."
    - name: "originating_credit_source"
      expr: originating_credit_source
      comment: "Source of the credit that generated the refund (e.g., Financial Aid, Overpayment, Withdrawal Credit). Identifies refund drivers for policy review."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the refund. Enables systematic analysis of refund causes and policy improvement opportunities."
    - name: "academic_year"
      expr: academic_year
      comment: "Academic year associated with the refund. Supports year-over-year refund trend analysis aligned to enrollment cycles."
    - name: "refund_date_month"
      expr: DATE_TRUNC('MONTH', refund_date)
      comment: "Month the refund was issued. Enables monthly refund cash outflow trend and seasonality analysis."
  measures:
    - name: "total_refund_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total dollar value of all refunds issued. Primary cash outflow KPI for refund liability management and cash flow planning."
    - name: "total_title_iv_refund_amount"
      expr: SUM(CASE WHEN is_title_iv_refund = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total Title IV Return of Funds refund amount. Regulatory compliance KPI; must be tracked and reported to the Department of Education."
    - name: "avg_refund_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average refund amount per transaction. Benchmarks typical refund size and identifies anomalous large refund events."
    - name: "count_refunds"
      expr: COUNT(1)
      comment: "Total number of refund transactions. Baseline volume metric for refund operations workload and processing capacity planning."
    - name: "count_title_iv_refunds"
      expr: COUNT(CASE WHEN is_title_iv_refund = TRUE THEN 1 END)
      comment: "Number of Title IV Return of Funds refunds. Regulatory compliance count metric for federal audit readiness."
    - name: "count_distinct_students_refunded"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique students who received a refund. Measures refund population breadth and financial aid excess prevalence."
    - name: "count_pending_refunds"
      expr: COUNT(CASE WHEN refund_status = 'Pending' THEN 1 END)
      comment: "Number of refunds in pending status. Operational KPI for Bursar processing queue management and student satisfaction."
    - name: "pending_refund_amount"
      expr: SUM(CASE WHEN refund_status = 'Pending' THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total dollar value of refunds pending processing. Measures unresolved cash outflow obligation requiring immediate Bursar action."
    - name: "title_iv_refund_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_title_iv_refund = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of all refunds that are Title IV returns. Monitors regulatory refund burden relative to total refund activity."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`billing_account_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over student account holds. Tracks hold prevalence, restriction types, collections exposure, and hold resolution rates. Used by the Bursar, Registrar, and Student Services to manage financial barriers to enrollment, graduation, and transcript access."
  source: "`education_ecm`.`billing`.`account_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the hold (e.g., Active, Released, Expired). Primary filter for active vs. resolved hold analysis."
    - name: "hold_type"
      expr: hold_type
      comment: "Category of the hold (e.g., Financial, Collections, Returned Payment). Enables hold root-cause and policy analysis."
    - name: "hold_code"
      expr: hold_code
      comment: "Standardized code identifying the specific hold reason. Supports systematic hold pattern analysis and policy review."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the hold (e.g., Low, Medium, High, Critical). Drives hold prioritization and escalation workflows."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for hold resolution. Used to triage Bursar workload and student outreach sequencing."
    - name: "restricts_registration"
      expr: restricts_registration
      comment: "Indicates whether the hold blocks course registration. Tracks financial barriers to enrollment with direct academic impact."
    - name: "restricts_transcript"
      expr: restricts_transcript
      comment: "Indicates whether the hold blocks transcript release. Monitors financial barriers to credential access and employment outcomes."
    - name: "restricts_diploma"
      expr: restricts_diploma
      comment: "Indicates whether the hold blocks diploma issuance. Tracks financial barriers to degree completion recognition."
    - name: "restricts_financial_aid"
      expr: restricts_financial_aid
      comment: "Indicates whether the hold blocks financial aid disbursement. Critical dimension linking billing holds to aid access disruption."
    - name: "collections_flag"
      expr: collections_flag
      comment: "Indicates whether the hold is associated with a collections referral. Measures overlap between holds and active collections activity."
    - name: "academic_year"
      expr: academic_year
      comment: "Academic year associated with the hold. Enables year-over-year hold trend analysis aligned to billing cycles."
    - name: "placed_date_month"
      expr: DATE_TRUNC('MONTH', placed_date)
      comment: "Month the hold was placed. Enables monthly hold placement trend and seasonality analysis."
  measures:
    - name: "count_holds"
      expr: COUNT(1)
      comment: "Total number of account holds placed. Baseline volume metric for financial hold prevalence across the student population."
    - name: "count_active_holds"
      expr: COUNT(CASE WHEN hold_status = 'Active' THEN 1 END)
      comment: "Number of currently active holds. Operational KPI for Bursar workload and student financial barrier monitoring."
    - name: "count_registration_blocking_holds"
      expr: COUNT(CASE WHEN restricts_registration = TRUE AND hold_status = 'Active' THEN 1 END)
      comment: "Number of active holds blocking course registration. Critical enrollment operations KPI; high counts require immediate Bursar and Registrar escalation."
    - name: "count_diploma_blocking_holds"
      expr: COUNT(CASE WHEN restricts_diploma = TRUE AND hold_status = 'Active' THEN 1 END)
      comment: "Number of active holds blocking diploma issuance. Tracks financial barriers to degree completion; escalated to senior leadership pre-commencement."
    - name: "count_financial_aid_blocking_holds"
      expr: COUNT(CASE WHEN restricts_financial_aid = TRUE AND hold_status = 'Active' THEN 1 END)
      comment: "Number of active holds blocking financial aid disbursement. Monitors cascading financial impact where holds prevent aid that would resolve the hold."
    - name: "count_collections_holds"
      expr: COUNT(CASE WHEN collections_flag = TRUE THEN 1 END)
      comment: "Number of holds associated with collections activity. Measures the intersection of hold management and collections operations."
    - name: "total_minimum_payment_required"
      expr: SUM(CAST(minimum_payment_amount AS DOUBLE))
      comment: "Total minimum payment amount required to release active holds. Quantifies the minimum cash collection needed to clear the hold backlog."
    - name: "avg_minimum_payment_to_release"
      expr: AVG(CAST(minimum_payment_amount AS DOUBLE))
      comment: "Average minimum payment required per hold. Benchmarks typical hold resolution cost and informs student payment counseling."
    - name: "hold_release_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hold_status = 'Released' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds that have been released. Measures hold resolution effectiveness and Bursar operational throughput."
    - name: "waiver_eligible_hold_count"
      expr: COUNT(CASE WHEN waiver_eligible_flag = TRUE AND hold_status = 'Active' THEN 1 END)
      comment: "Number of active holds eligible for waiver. Identifies the population where waiver processing could rapidly reduce hold backlog."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`billing_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over student billing statements. Tracks net balance trends, charge composition, financial aid offset, late fee prevalence, and statement delivery. Used by the Bursar and Finance to monitor billing cycle health, student balance trends, and aid disbursement effectiveness."
  source: "`education_ecm`.`billing`.`statement`"
  dimensions:
    - name: "statement_status"
      expr: statement_status
      comment: "Current status of the statement (e.g., Draft, Issued, Paid, Overdue). Primary filter for active vs. settled statement analysis."
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing cycle associated with the statement (e.g., Fall 2024, Spring 2025). Enables term-level billing trend analysis."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method used to deliver the statement (e.g., Email, Portal, Paper Mail). Informs digital delivery adoption and paper cost reduction initiatives."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code of the statement. Supports multi-currency billing analysis for international student accounts."
    - name: "account_hold_indicator"
      expr: account_hold_indicator
      comment: "Indicates whether the account had a hold at statement generation. Measures hold prevalence at billing cycle close."
    - name: "is_1098t_eligible"
      expr: is_1098t_eligible
      comment: "Indicates whether the statement is associated with a 1098-T eligible account. Supports tax compliance population tracking."
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year associated with the statement. Enables annual tax reporting population and amount analysis."
    - name: "statement_date_month"
      expr: DATE_TRUNC('MONTH', statement_date)
      comment: "Month the statement was generated. Enables monthly billing cycle volume and balance trend analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the statement payment is due. Supports cash flow forecasting and collections timing analysis."
  measures:
    - name: "total_net_balance"
      expr: SUM(CAST(net_balance AS DOUBLE))
      comment: "Total net balance across all statements. Primary receivables KPI reflecting what students owe after all credits and aid."
    - name: "total_tuition_charges"
      expr: SUM(CAST(tuition_charges AS DOUBLE))
      comment: "Total tuition charges on statements. Core revenue line item for academic program billing analysis."
    - name: "total_housing_charges"
      expr: SUM(CAST(housing_charges AS DOUBLE))
      comment: "Total housing charges on statements. Tracks auxiliary revenue from residential services."
    - name: "total_meal_plan_charges"
      expr: SUM(CAST(meal_plan_charges AS DOUBLE))
      comment: "Total meal plan charges on statements. Tracks auxiliary revenue from dining services."
    - name: "total_fee_charges"
      expr: SUM(CAST(fee_charges AS DOUBLE))
      comment: "Total miscellaneous fee charges on statements. Monitors fee revenue contribution and fee structure effectiveness."
    - name: "total_financial_aid_disbursed"
      expr: SUM(CAST(financial_aid_disbursed AS DOUBLE))
      comment: "Total financial aid disbursed and applied to statements. Measures aid offset against billed charges; key for net tuition revenue analysis."
    - name: "total_scholarship_amount"
      expr: SUM(CAST(scholarship_amount AS DOUBLE))
      comment: "Total scholarship credits applied on statements. Tracks institutional scholarship investment and its impact on net revenue."
    - name: "total_grant_amount"
      expr: SUM(CAST(grant_amount AS DOUBLE))
      comment: "Total grant credits applied on statements. Measures grant funding offset against student charges."
    - name: "total_third_party_sponsor_amount"
      expr: SUM(CAST(third_party_sponsor_amount AS DOUBLE))
      comment: "Total third-party sponsor payments applied on statements. Tracks employer and sponsor billing contribution to revenue."
    - name: "total_late_fee_amount"
      expr: SUM(CAST(late_fee_amount AS DOUBLE))
      comment: "Total late fees assessed on statements. Monitors late payment prevalence and associated fee revenue."
    - name: "total_minimum_payment_due"
      expr: SUM(CAST(minimum_payment_due AS DOUBLE))
      comment: "Total minimum payments due across all statements. Measures near-term cash collection obligation for cash flow planning."
    - name: "avg_net_balance_per_statement"
      expr: AVG(CAST(net_balance AS DOUBLE))
      comment: "Average net balance per statement. Benchmarks typical student balance and identifies high-balance cohorts requiring outreach."
    - name: "count_statements"
      expr: COUNT(1)
      comment: "Total number of statements generated. Baseline billing cycle volume metric for Bursar operations."
    - name: "financial_aid_offset_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(financial_aid_disbursed AS DOUBLE)) / NULLIF(SUM(CAST(total_charges AS DOUBLE)), 0), 2)
      comment: "Financial aid disbursed as a percentage of total charges. Measures how much of gross billing is offset by aid; key for net tuition revenue and affordability analysis."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`billing_tax_form_1098t`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over IRS Form 1098-T tax reporting. Tracks qualified tuition payments, scholarship offsets, prior-year adjustments, and filing compliance. Used by the Bursar, Finance, and Compliance to ensure accurate and timely 1098-T filing with the IRS and delivery to students."
  source: "`education_ecm`.`billing`.`tax_form_1098t`"
  dimensions:
    - name: "form_status"
      expr: form_status
      comment: "Current status of the 1098-T form (e.g., Draft, Filed, Corrected, Voided). Primary filter for compliance reporting on filed vs. pending forms."
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for which the 1098-T is filed. Enables year-over-year tax reporting volume and amount trend analysis."
    - name: "reporting_method"
      expr: reporting_method
      comment: "IRS reporting method used (Box 1 Payments Received vs. Box 2 Amounts Billed). Tracks institutional reporting method consistency and any method changes."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method used to deliver the form to the student (e.g., Electronic, Paper). Monitors electronic consent adoption and paper delivery cost."
    - name: "correction_indicator"
      expr: correction_indicator
      comment: "Indicates whether the form is a correction to a previously filed form. Tracks correction volume as a data quality and compliance risk indicator."
    - name: "box8_half_time_student"
      expr: box8_half_time_student
      comment: "Indicates whether the student was enrolled at least half-time. Required IRS reporting field; enables enrollment intensity segmentation of tax population."
    - name: "box9_graduate_student"
      expr: box9_graduate_student
      comment: "Indicates whether the student is a graduate student. Required IRS reporting field; enables graduate vs. undergraduate tax reporting segmentation."
    - name: "irs_submission_date_month"
      expr: DATE_TRUNC('MONTH', irs_submission_date)
      comment: "Month the form was submitted to the IRS. Monitors filing timeliness relative to IRS deadlines."
  measures:
    - name: "total_box1_payments_received"
      expr: SUM(CAST(box1_payments_received AS DOUBLE))
      comment: "Total qualified tuition payments received reported in Box 1. Primary IRS-reportable revenue figure for 1098-T compliance."
    - name: "total_box2_amounts_billed"
      expr: SUM(CAST(box2_amounts_billed AS DOUBLE))
      comment: "Total qualified tuition amounts billed reported in Box 2. Alternative IRS reporting basis; tracked for institutions using the billed method."
    - name: "total_box5_scholarships_grants"
      expr: SUM(CAST(box5_scholarships_grants AS DOUBLE))
      comment: "Total scholarships and grants reported in Box 5. Measures institutional aid investment reportable to the IRS and students for tax credit purposes."
    - name: "total_box4_adjustments_prior_year"
      expr: SUM(CAST(box4_adjustments_prior_year AS DOUBLE))
      comment: "Total prior-year tuition adjustments reported in Box 4. Tracks retroactive billing corrections with IRS reporting implications."
    - name: "total_box6_adjustments_scholarships_prior_year"
      expr: SUM(CAST(box6_adjustments_scholarships_prior_year AS DOUBLE))
      comment: "Total prior-year scholarship adjustments reported in Box 6. Monitors retroactive aid corrections affecting student tax credit eligibility."
    - name: "total_box10_insurance_reimbursement"
      expr: SUM(CAST(box10_insurance_contract_reimbursement AS DOUBLE))
      comment: "Total insurance contract reimbursements reported in Box 10. Tracks insurance-related tuition reimbursements with IRS reporting obligations."
    - name: "count_forms_filed"
      expr: COUNT(1)
      comment: "Total number of 1098-T forms generated. Baseline compliance volume metric for IRS filing population sizing."
    - name: "count_corrections_filed"
      expr: COUNT(CASE WHEN correction_indicator = TRUE THEN 1 END)
      comment: "Number of corrected 1098-T forms filed. Measures data quality issues in original filings; high correction rates signal billing data integrity problems."
    - name: "count_graduate_student_forms"
      expr: COUNT(CASE WHEN box9_graduate_student = TRUE THEN 1 END)
      comment: "Number of 1098-T forms for graduate students. Enables graduate vs. undergraduate tax reporting population segmentation."
    - name: "correction_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN correction_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of 1098-T forms that required correction. Key data quality and compliance risk KPI; high rates trigger IRS audit risk and student tax filing disruption."
    - name: "net_reportable_tuition_amount"
      expr: SUM(CAST(box1_payments_received AS DOUBLE) - CAST(box5_scholarships_grants AS DOUBLE))
      comment: "Net IRS-reportable tuition amount after subtracting scholarships and grants from payments received. Approximates the net qualified education expense figure relevant to student tax credit eligibility."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`billing_payment_plan_installment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over individual payment plan installments. Tracks on-time payment rates, late fee prevalence, auto-pay performance, collections referrals, and remaining balance exposure. Used by the Bursar and Student Financial Services to manage installment-level delinquency and collections risk."
  source: "`education_ecm`.`billing`.`payment_plan_installment`"
  dimensions:
    - name: "installment_status"
      expr: installment_status
      comment: "Current status of the installment (e.g., Paid, Overdue, Waived, In Collections). Primary dimension for delinquency and collections analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the installment (e.g., ACH, Credit Card, Check). Enables payment method performance and failure rate analysis."
    - name: "auto_pay_enabled"
      expr: auto_pay_enabled
      comment: "Indicates whether auto-pay was enabled for this installment. Measures auto-pay coverage and its correlation with on-time payment."
    - name: "auto_pay_status"
      expr: auto_pay_status
      comment: "Status of the auto-pay attempt (e.g., Success, Failed, Pending). Tracks auto-pay reliability and failure patterns by method."
    - name: "late_fee_assessed"
      expr: late_fee_assessed
      comment: "Indicates whether a late fee was assessed on this installment. Measures late payment prevalence at the installment level."
    - name: "hold_applied"
      expr: hold_applied
      comment: "Indicates whether a hold was applied due to this installment being overdue. Tracks the downstream academic impact of installment delinquency."
    - name: "scheduled_due_date_month"
      expr: DATE_TRUNC('MONTH', scheduled_due_date)
      comment: "Month the installment was scheduled to be paid. Enables monthly installment due volume and cash flow forecasting."
  measures:
    - name: "total_scheduled_amount"
      expr: SUM(CAST(scheduled_amount AS DOUBLE))
      comment: "Total amount scheduled across all installments. Measures total installment billing obligation for cash flow planning."
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total amount actually paid across all installments. Measures cash collected through the installment program."
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Total remaining balance outstanding across all installments. Primary installment-level receivables exposure KPI."
    - name: "total_late_fee_amount"
      expr: SUM(CAST(late_fee_amount AS DOUBLE))
      comment: "Total late fees assessed on installments. Tracks delinquency cost burden on students and late payment revenue."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to installments. Monitors billing correction volume and authorized modification activity."
    - name: "avg_remaining_balance_per_installment"
      expr: AVG(CAST(remaining_balance AS DOUBLE))
      comment: "Average remaining balance per installment. Benchmarks typical unpaid installment exposure and identifies high-risk cohorts."
    - name: "count_installments"
      expr: COUNT(1)
      comment: "Total number of installment records. Baseline volume metric for installment program scale and Bursar processing workload."
    - name: "count_overdue_installments"
      expr: COUNT(CASE WHEN installment_status = 'Overdue' THEN 1 END)
      comment: "Number of overdue installments. Primary delinquency KPI for collections prioritization and student outreach."
    - name: "count_late_fee_assessed_installments"
      expr: COUNT(CASE WHEN late_fee_assessed = TRUE THEN 1 END)
      comment: "Number of installments on which a late fee was assessed. Measures late payment prevalence and student financial stress indicators."
    - name: "count_collections_referred_installments"
      expr: COUNT(CASE WHEN collections_agency IS NOT NULL THEN 1 END)
      comment: "Number of installments referred to a collections agency. Tracks escalation rate from internal delinquency management to external collections."
    - name: "installment_on_time_payment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN installment_status = 'Paid' AND late_fee_assessed = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of installments paid on time without a late fee. Key program health KPI; low rates signal student financial distress or plan design issues."
    - name: "auto_pay_failure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_pay_status = 'Failed' THEN 1 END) / NULLIF(COUNT(CASE WHEN auto_pay_enabled = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of auto-pay enabled installments where auto-pay failed. Monitors payment processor reliability and student account funding issues."
    - name: "collections_referral_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN collections_agency IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of installments escalated to external collections. Measures severity of installment delinquency and collections cost exposure."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`billing_fee_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the institutional fee schedule. Tracks rate levels, financial aid eligibility, refundability, proration policies, and schedule coverage by program level and enrollment intensity. Used by Finance and the Provost office to govern fee structures, ensure policy compliance, and support tuition rate-setting decisions."
  source: "`education_ecm`.`billing`.`fee_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the fee schedule (e.g., Active, Inactive, Pending Approval). Filters to currently operative fee structures."
    - name: "fee_category"
      expr: fee_category
      comment: "Category of the fee (e.g., Tuition, Technology, Activity, Housing). Enables fee revenue decomposition by category."
    - name: "program_level"
      expr: program_level
      comment: "Academic program level the schedule applies to (e.g., Undergraduate, Graduate). Key dimension for tuition rate benchmarking by level."
    - name: "enrollment_intensity"
      expr: enrollment_intensity
      comment: "Enrollment intensity the schedule applies to (e.g., Full-Time, Half-Time, Per Credit). Enables rate analysis by enrollment load category."
    - name: "residency_status"
      expr: residency_status
      comment: "Residency classification the schedule applies to (e.g., In-State, Out-of-State, International). Drives differential tuition rate analysis."
    - name: "financial_aid_eligible"
      expr: financial_aid_eligible
      comment: "Indicates whether charges under this schedule are eligible for financial aid. Ensures fee structures align with aid eligibility policy."
    - name: "refundable"
      expr: refundable
      comment: "Indicates whether charges under this schedule are refundable. Tracks refund liability exposure by fee type."
    - name: "proration_allowed"
      expr: proration_allowed
      comment: "Indicates whether proration is allowed for this fee schedule. Monitors proration policy coverage for withdrawal and enrollment change scenarios."
    - name: "tax_reportable_1098t"
      expr: tax_reportable_1098t
      comment: "Indicates whether charges under this schedule are reportable on IRS Form 1098-T. Ensures fee schedule tax compliance classification."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the fee schedule became effective. Enables rate change timeline analysis and policy version tracking."
  measures:
    - name: "avg_rate_amount"
      expr: AVG(CAST(rate_amount AS DOUBLE))
      comment: "Average fee rate amount across all active schedules. Benchmarks institutional fee levels for competitive positioning and board reporting."
    - name: "max_rate_amount"
      expr: MAX(CAST(rate_amount AS DOUBLE))
      comment: "Maximum fee rate amount in the schedule. Identifies the highest-cost fee structures for affordability and policy review."
    - name: "min_rate_amount"
      expr: MIN(CAST(rate_amount AS DOUBLE))
      comment: "Minimum fee rate amount in the schedule. Establishes the floor of institutional fee pricing for policy analysis."
    - name: "avg_maximum_credit_hours"
      expr: AVG(CAST(maximum_credit_hours AS DOUBLE))
      comment: "Average maximum credit hours covered by fee schedules. Informs flat-rate vs. per-credit-hour billing structure analysis."
    - name: "avg_minimum_credit_hours"
      expr: AVG(CAST(minimum_credit_hours AS DOUBLE))
      comment: "Average minimum credit hours required for fee schedule applicability. Monitors enrollment intensity thresholds across fee structures."
    - name: "count_fee_schedules"
      expr: COUNT(1)
      comment: "Total number of fee schedule records. Baseline metric for fee structure complexity and governance overhead."
    - name: "count_active_fee_schedules"
      expr: COUNT(CASE WHEN schedule_status = 'Active' THEN 1 END)
      comment: "Number of currently active fee schedules. Measures the operative fee structure portfolio size."
    - name: "count_financial_aid_eligible_schedules"
      expr: COUNT(CASE WHEN financial_aid_eligible = TRUE THEN 1 END)
      comment: "Number of fee schedules eligible for financial aid offset. Ensures adequate aid-eligible fee coverage for student affordability."
    - name: "count_1098t_reportable_schedules"
      expr: COUNT(CASE WHEN tax_reportable_1098t = TRUE THEN 1 END)
      comment: "Number of fee schedules with 1098-T reportable charges. Monitors tax compliance classification coverage across the fee structure."
    - name: "financial_aid_eligible_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN financial_aid_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of fee schedules that are financial aid eligible. Measures the proportion of institutional fees accessible to aid recipients."
$$;