-- Metric views for domain: trust | Business: Legal | Version: 1 | Generated on: 2026-05-07 14:29:57

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`trust_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and compliance metrics for trust accounts, covering balance health, interest-bearing exposure, IOLTA obligations, and AML risk distribution. Used by trust accounting managers and compliance officers to monitor account portfolio health."
  source: "`legal_ecm`.`trust`.`account`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Type of trust account (e.g., IOLTA, escrow, retainer) used to segment balance and compliance metrics by account category."
    - name: "account_status"
      expr: account_status
      comment: "Current lifecycle status of the account (e.g., active, closed, suspended) for filtering operational vs. dormant accounts."
    - name: "aml_risk_rating"
      expr: aml_risk_rating
      comment: "AML risk classification assigned to the account (e.g., low, medium, high) for risk-stratified compliance reporting."
    - name: "aml_kyc_status"
      expr: aml_kyc_status
      comment: "Current AML/KYC verification status of the account, used to identify accounts requiring remediation."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Regulatory jurisdiction governing the account, enabling jurisdiction-level compliance and balance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of the account balance for multi-currency portfolio analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Current reconciliation state of the account (e.g., reconciled, pending, discrepancy) for identifying accounts requiring attention."
    - name: "interest_bearing_flag"
      expr: CASE WHEN interest_bearing_flag = TRUE THEN 'Interest-Bearing' ELSE 'Non-Interest-Bearing' END
      comment: "Indicates whether the account accrues interest, used to segment IOLTA and non-IOLTA balances."
    - name: "iolta_reporting_required_flag"
      expr: CASE WHEN iolta_reporting_required_flag = TRUE THEN 'IOLTA Reportable' ELSE 'Non-IOLTA' END
      comment: "Flags accounts subject to IOLTA regulatory reporting requirements."
    - name: "opened_year_month"
      expr: DATE_TRUNC('MONTH', opened_date)
      comment: "Month the account was opened, used for cohort and trend analysis of account portfolio growth."
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the account for compliance segmentation and reporting."
    - name: "financial_institution_name"
      expr: financial_institution_name
      comment: "Name of the financial institution holding the trust account, used for counterparty concentration analysis."
  measures:
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current balance across all trust accounts. Core KPI for trust portfolio size and client fund stewardship obligations."
    - name: "avg_account_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average balance per trust account. Indicates typical account size and helps identify outliers requiring enhanced oversight."
    - name: "total_minimum_balance_required"
      expr: SUM(CAST(minimum_balance_required AS DOUBLE))
      comment: "Aggregate minimum balance requirement across all accounts. Used to assess total regulatory floor exposure."
    - name: "count_active_accounts"
      expr: COUNT(CASE WHEN account_status = 'active' THEN account_id END)
      comment: "Number of currently active trust accounts. Baseline operational capacity metric for trust department staffing and oversight."
    - name: "count_iolta_reportable_accounts"
      expr: COUNT(CASE WHEN iolta_reporting_required_flag = TRUE THEN account_id END)
      comment: "Number of accounts subject to IOLTA reporting. Drives compliance workload planning and regulatory filing obligations."
    - name: "count_high_aml_risk_accounts"
      expr: COUNT(CASE WHEN aml_risk_rating = 'high' THEN account_id END)
      comment: "Number of accounts classified as high AML risk. Critical compliance KPI triggering enhanced due diligence and escalation."
    - name: "count_pending_reconciliation_accounts"
      expr: COUNT(CASE WHEN reconciliation_status = 'pending' THEN account_id END)
      comment: "Number of accounts with pending reconciliation status. Operational risk indicator for unresolved trust accounting discrepancies."
    - name: "total_interest_rate_exposure"
      expr: SUM(CASE WHEN interest_bearing_flag = TRUE THEN CAST(interest_rate AS DOUBLE) ELSE 0 END)
      comment: "Sum of interest rates across interest-bearing accounts. Proxy for total interest income generation potential in the trust portfolio."
    - name: "balance_below_minimum_count"
      expr: COUNT(CASE WHEN current_balance < minimum_balance_required THEN account_id END)
      comment: "Number of accounts where current balance falls below the required minimum. Regulatory compliance risk indicator requiring immediate remediation."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`trust_ledger_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transaction-level metrics for trust ledger entries, covering fund flows, reconciliation status, AML screening, and GL posting integrity. Used by trust accountants, compliance officers, and finance leadership to monitor trust transaction activity and regulatory adherence."
  source: "`legal_ecm`.`trust`.`ledger_entry`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of ledger transaction (e.g., deposit, disbursement, transfer, reversal) for transaction flow analysis."
    - name: "entry_direction"
      expr: entry_direction
      comment: "Direction of the ledger entry (debit or credit) for net flow and balance movement analysis."
    - name: "disbursement_category"
      expr: disbursement_category
      comment: "Category of disbursement (e.g., legal fees, client refund, court costs) for spend classification and reporting."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation state of the ledger entry (e.g., reconciled, unreconciled, disputed) for identifying unresolved items."
    - name: "aml_screening_status"
      expr: aml_screening_status
      comment: "AML screening outcome for the transaction, used to identify entries requiring compliance review or SAR filing."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g., wire, check, ACH) for payment channel analysis and fraud risk assessment."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction associated with the ledger entry for cross-border compliance and regulatory reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the ledger entry for multi-currency trust accounting analysis."
    - name: "reversal_flag"
      expr: CASE WHEN reversal_flag = TRUE THEN 'Reversal' ELSE 'Original' END
      comment: "Indicates whether the entry is a reversal transaction, used to measure error correction rates and operational quality."
    - name: "posted_to_gl_flag"
      expr: CASE WHEN posted_to_gl_flag = TRUE THEN 'Posted' ELSE 'Unposted' END
      comment: "Indicates whether the entry has been posted to the general ledger, used to track GL reconciliation completeness."
    - name: "transaction_year_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of the transaction date for trend analysis of trust fund flows over time."
    - name: "source_of_funds"
      expr: source_of_funds
      comment: "Declared source of funds for the transaction, critical for AML compliance and client due diligence."
    - name: "regulatory_reporting_flag"
      expr: CASE WHEN regulatory_reporting_flag = TRUE THEN 'Reportable' ELSE 'Non-Reportable' END
      comment: "Flags transactions subject to regulatory reporting obligations (e.g., CTR, SAR thresholds)."
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total value of all trust ledger entries. Primary measure of trust fund flow volume and fiduciary activity scale."
    - name: "avg_transaction_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average transaction amount per ledger entry. Baseline for anomaly detection and transaction size benchmarking."
    - name: "total_credit_amount"
      expr: SUM(CASE WHEN entry_direction = 'credit' THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of credit (inflow) entries. Measures total funds received into trust accounts."
    - name: "total_debit_amount"
      expr: SUM(CASE WHEN entry_direction = 'debit' THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of debit (outflow) entries. Measures total funds disbursed from trust accounts."
    - name: "total_reversal_amount"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of reversed transactions. Elevated reversal amounts signal operational errors or potential fraud requiring investigation."
    - name: "count_unreconciled_entries"
      expr: COUNT(CASE WHEN reconciliation_status != 'reconciled' THEN ledger_entry_id END)
      comment: "Number of ledger entries not yet reconciled. Key operational risk metric for trust accounting integrity and regulatory compliance."
    - name: "count_aml_flagged_entries"
      expr: COUNT(CASE WHEN aml_screening_status = 'flagged' THEN ledger_entry_id END)
      comment: "Number of transactions flagged during AML screening. Drives compliance escalation and SAR filing decisions."
    - name: "count_unposted_gl_entries"
      expr: COUNT(CASE WHEN posted_to_gl_flag = FALSE THEN ledger_entry_id END)
      comment: "Number of ledger entries not yet posted to the general ledger. Financial close risk indicator for trust accounting completeness."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_flag = TRUE THEN ledger_entry_id END) / NULLIF(COUNT(ledger_entry_id), 0), 2)
      comment: "Percentage of ledger entries that are reversals. Quality metric for trust transaction processing accuracy; high rates indicate systemic errors."
    - name: "regulatory_reportable_amount"
      expr: SUM(CASE WHEN regulatory_reporting_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of transactions subject to regulatory reporting. Used to size compliance reporting obligations and assess regulatory exposure."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`trust_disbursement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disbursement-level metrics for trust fund outflows, covering authorization compliance, IOLTA reportability, reconciliation status, and disbursement type distribution. Used by trust managers, compliance officers, and finance leadership to govern client fund disbursements."
  source: "`legal_ecm`.`trust`.`trust_disbursement`"
  dimensions:
    - name: "disbursement_type"
      expr: disbursement_type
      comment: "Type of disbursement (e.g., wire transfer, check, ACH) for payment channel analysis and operational efficiency."
    - name: "disbursement_category"
      expr: disbursement_category
      comment: "Business category of the disbursement (e.g., legal fees, client refund, settlement) for spend classification."
    - name: "authorization_status"
      expr: authorization_status
      comment: "Authorization state of the disbursement (e.g., authorized, pending, rejected) for compliance gate monitoring."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the disbursement for channel mix and fraud risk analysis."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction of the disbursement for cross-border compliance and regulatory reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the disbursement for multi-currency trust accounting."
    - name: "is_iolta_reportable"
      expr: CASE WHEN is_iolta_reportable = TRUE THEN 'IOLTA Reportable' ELSE 'Non-IOLTA' END
      comment: "Flags disbursements subject to IOLTA regulatory reporting, driving compliance filing obligations."
    - name: "is_three_way_reconciled"
      expr: CASE WHEN is_three_way_reconciled = TRUE THEN 'Reconciled' ELSE 'Unreconciled' END
      comment: "Indicates whether the disbursement has been included in a three-way reconciliation, a core trust accounting control."
    - name: "payee_type"
      expr: payee_type
      comment: "Type of payee receiving the disbursement (e.g., client, court, third party) for beneficiary analysis."
    - name: "disbursement_year_month"
      expr: DATE_TRUNC('MONTH', disbursement_date)
      comment: "Month of disbursement for trend analysis of trust fund outflows over time."
    - name: "is_taxable"
      expr: CASE WHEN is_taxable = TRUE THEN 'Taxable' ELSE 'Non-Taxable' END
      comment: "Indicates whether the disbursement has tax implications, used for tax reporting and withholding compliance."
  measures:
    - name: "total_disbursement_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total value of trust disbursements. Primary measure of client fund outflow volume and fiduciary obligation fulfillment."
    - name: "avg_disbursement_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average disbursement amount. Baseline for anomaly detection and disbursement size benchmarking across matter types."
    - name: "count_unauthorized_disbursements"
      expr: COUNT(CASE WHEN authorization_status != 'authorized' THEN trust_disbursement_id END)
      comment: "Number of disbursements lacking proper authorization. Critical compliance KPI; any non-zero value triggers immediate investigation."
    - name: "count_unreconciled_disbursements"
      expr: COUNT(CASE WHEN is_three_way_reconciled = FALSE THEN trust_disbursement_id END)
      comment: "Number of disbursements not yet included in a three-way reconciliation. Regulatory compliance gap metric for trust accounting controls."
    - name: "total_iolta_reportable_amount"
      expr: SUM(CASE WHEN is_iolta_reportable = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of IOLTA-reportable disbursements. Drives IOLTA regulatory filing completeness and interest remittance calculations."
    - name: "unauthorized_disbursement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN authorization_status != 'authorized' THEN trust_disbursement_id END) / NULLIF(COUNT(trust_disbursement_id), 0), 2)
      comment: "Percentage of disbursements without proper authorization. Zero-tolerance compliance KPI; any positive rate signals a control failure."
    - name: "three_way_reconciliation_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_three_way_reconciled = TRUE THEN trust_disbursement_id END) / NULLIF(COUNT(trust_disbursement_id), 0), 2)
      comment: "Percentage of disbursements covered by three-way reconciliation. Measures trust accounting control completeness; target is 100%."
    - name: "count_distinct_matters_with_disbursements"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of distinct matters with trust disbursements. Measures breadth of active trust activity across the matter portfolio."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`trust_disbursement_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Authorization control metrics for trust disbursements, covering approval workflow compliance, dual-signatory adherence, AML screening, and rejection analysis. Used by compliance officers and managing partners to govern disbursement authorization integrity."
  source: "`legal_ecm`.`trust`.`disbursement_authorization`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Current status of the disbursement authorization (e.g., approved, pending, rejected) for workflow monitoring."
    - name: "disbursement_type"
      expr: disbursement_type
      comment: "Type of disbursement being authorized for category-level approval rate analysis."
    - name: "disbursement_purpose"
      expr: disbursement_purpose
      comment: "Stated purpose of the disbursement for compliance review and audit trail documentation."
    - name: "aml_screening_status"
      expr: aml_screening_status
      comment: "AML screening outcome for the authorization request, used to identify high-risk disbursements requiring escalation."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction of the disbursement authorization for cross-border compliance monitoring."
    - name: "disbursement_currency"
      expr: disbursement_currency
      comment: "Currency of the authorized disbursement for multi-currency exposure analysis."
    - name: "dual_signatory_required_flag"
      expr: CASE WHEN dual_signatory_required_flag = TRUE THEN 'Dual Signatory Required' ELSE 'Single Signatory' END
      comment: "Indicates whether dual signatory approval is required, used to monitor high-value disbursement control adherence."
    - name: "client_consent_obtained_flag"
      expr: CASE WHEN client_consent_obtained_flag = TRUE THEN 'Consent Obtained' ELSE 'Consent Pending' END
      comment: "Indicates whether client consent has been obtained prior to disbursement, a mandatory compliance requirement."
    - name: "regulatory_reporting_flag"
      expr: CASE WHEN regulatory_reporting_flag = TRUE THEN 'Reportable' ELSE 'Non-Reportable' END
      comment: "Flags authorizations subject to regulatory reporting obligations."
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Coded reason for authorization rejection, used to identify systemic issues in the disbursement approval process."
    - name: "request_year_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month the authorization was requested for trend analysis of disbursement approval volumes."
    - name: "client_consent_method"
      expr: client_consent_method
      comment: "Method by which client consent was obtained (e.g., written, electronic, verbal) for consent quality analysis."
  measures:
    - name: "total_authorized_disbursement_amount"
      expr: SUM(CASE WHEN authorization_status = 'approved' THEN CAST(disbursement_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of approved disbursement authorizations. Measures the volume of client funds cleared for release under proper governance."
    - name: "total_pending_authorization_amount"
      expr: SUM(CASE WHEN authorization_status = 'pending' THEN CAST(disbursement_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of disbursements awaiting authorization. Operational backlog metric indicating pending fiduciary obligations."
    - name: "authorization_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN authorization_status = 'approved' THEN disbursement_authorization_id END) / NULLIF(COUNT(disbursement_authorization_id), 0), 2)
      comment: "Percentage of disbursement authorizations approved. Measures authorization workflow efficiency and compliance gate effectiveness."
    - name: "authorization_rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN authorization_status = 'rejected' THEN disbursement_authorization_id END) / NULLIF(COUNT(disbursement_authorization_id), 0), 2)
      comment: "Percentage of disbursement authorizations rejected. Elevated rejection rates signal systemic compliance issues or client instruction quality problems."
    - name: "count_missing_client_consent"
      expr: COUNT(CASE WHEN client_consent_obtained_flag = FALSE THEN disbursement_authorization_id END)
      comment: "Number of authorizations where client consent has not been obtained. Zero-tolerance compliance KPI; any positive count is a regulatory violation risk."
    - name: "count_dual_signatory_required"
      expr: COUNT(CASE WHEN dual_signatory_required_flag = TRUE THEN disbursement_authorization_id END)
      comment: "Number of authorizations requiring dual signatory approval. Used to monitor high-value disbursement control workload and adherence."
    - name: "total_dual_signatory_threshold_exposure"
      expr: SUM(CASE WHEN dual_signatory_required_flag = TRUE THEN CAST(disbursement_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of disbursements subject to dual signatory requirements. Measures high-value authorization control exposure."
    - name: "count_aml_flagged_authorizations"
      expr: COUNT(CASE WHEN aml_screening_status = 'flagged' THEN disbursement_authorization_id END)
      comment: "Number of disbursement authorizations flagged during AML screening. Drives compliance escalation and potential SAR filing decisions."
    - name: "avg_disbursement_authorization_amount"
      expr: AVG(CAST(disbursement_amount AS DOUBLE))
      comment: "Average authorized disbursement amount. Baseline for anomaly detection and benchmarking disbursement size against matter type norms."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`trust_client_trust_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client-level trust balance metrics covering fund availability, dormancy risk, escheatment exposure, reconciliation currency, and negative balance incidents. Used by trust accounting managers and compliance officers to monitor individual client fund stewardship obligations."
  source: "`legal_ecm`.`trust`.`client_trust_balance`"
  dimensions:
    - name: "trust_account_type"
      expr: trust_account_type
      comment: "Type of trust account holding the client balance (e.g., IOLTA, escrow, retainer) for portfolio segmentation."
    - name: "balance_status"
      expr: balance_status
      comment: "Current status of the client trust balance (e.g., active, dormant, closed) for lifecycle monitoring."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Regulatory jurisdiction governing the client trust balance for compliance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the client trust balance for multi-currency portfolio analysis."
    - name: "negative_balance_flag"
      expr: CASE WHEN negative_balance_flag = TRUE THEN 'Negative Balance' ELSE 'Positive Balance' END
      comment: "Flags client balances that have gone negative, a serious regulatory violation in trust accounting."
    - name: "escheatment_eligible_flag"
      expr: CASE WHEN escheatment_eligible_flag = TRUE THEN 'Escheatment Eligible' ELSE 'Not Eligible' END
      comment: "Indicates whether the client balance is eligible for escheatment to the state due to dormancy, triggering mandatory reporting."
    - name: "regulatory_reporting_required_flag"
      expr: CASE WHEN regulatory_reporting_required_flag = TRUE THEN 'Reporting Required' ELSE 'No Reporting Required' END
      comment: "Flags client balances subject to mandatory regulatory reporting obligations."
    - name: "client_authorization_on_file_flag"
      expr: CASE WHEN client_authorization_on_file_flag = TRUE THEN 'Authorization On File' ELSE 'Authorization Missing' END
      comment: "Indicates whether client authorization documentation is on file, a mandatory compliance requirement for trust fund management."
    - name: "balance_year_month"
      expr: DATE_TRUNC('MONTH', balance_as_of_date)
      comment: "Month of the balance snapshot for trend analysis of client trust fund levels over time."
    - name: "record_source_system"
      expr: record_source_system
      comment: "Source system from which the balance record originated, used for data lineage and reconciliation source analysis."
  measures:
    - name: "total_current_client_balance"
      expr: SUM(CAST(current_balance_amount AS DOUBLE))
      comment: "Total current balance held across all client trust accounts. Primary fiduciary KPI measuring total client funds under management."
    - name: "total_available_balance"
      expr: SUM(CAST(available_balance_amount AS DOUBLE))
      comment: "Total available (unrestricted) balance across client trust accounts. Measures immediately disbursable client funds."
    - name: "total_held_balance"
      expr: SUM(CAST(held_balance_amount AS DOUBLE))
      comment: "Total balance held (restricted) across client trust accounts. Measures funds subject to holds, disputes, or pending authorizations."
    - name: "total_interest_earned"
      expr: SUM(CAST(interest_earned_amount AS DOUBLE))
      comment: "Total interest earned across client trust balances. Drives IOLTA remittance calculations and client interest disbursement obligations."
    - name: "total_interest_disbursed"
      expr: SUM(CAST(interest_disbursed_amount AS DOUBLE))
      comment: "Total interest disbursed to clients or IOLTA programs. Measures fulfillment of interest remittance obligations."
    - name: "count_negative_balance_accounts"
      expr: COUNT(CASE WHEN negative_balance_flag = TRUE THEN client_trust_balance_id END)
      comment: "Number of client trust balances that have gone negative. Zero-tolerance compliance KPI; any positive count is a regulatory violation requiring immediate remediation."
    - name: "count_escheatment_eligible_balances"
      expr: COUNT(CASE WHEN escheatment_eligible_flag = TRUE THEN client_trust_balance_id END)
      comment: "Number of client balances eligible for escheatment. Drives mandatory state reporting and unclaimed property compliance obligations."
    - name: "total_escheatment_eligible_amount"
      expr: SUM(CASE WHEN escheatment_eligible_flag = TRUE THEN CAST(current_balance_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of client balances eligible for escheatment. Quantifies unclaimed property exposure and mandatory remittance obligations."
    - name: "count_missing_client_authorization"
      expr: COUNT(CASE WHEN client_authorization_on_file_flag = FALSE THEN client_trust_balance_id END)
      comment: "Number of client trust balances without authorization documentation on file. Compliance gap metric requiring immediate remediation."
    - name: "net_trust_fund_movement"
      expr: SUM(CAST(total_deposits_amount AS DOUBLE) - CAST(total_disbursements_amount AS DOUBLE))
      comment: "Net movement of client trust funds (deposits minus disbursements). Measures whether the trust portfolio is growing or contracting over the period."
    - name: "avg_client_balance"
      expr: AVG(CAST(current_balance_amount AS DOUBLE))
      comment: "Average client trust balance. Baseline for identifying outlier accounts and benchmarking client fund levels by matter type."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`trust_three_way_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Three-way reconciliation metrics covering variance detection, exception resolution, regulatory filing compliance, and reconciliation timeliness. Used by trust accounting managers and compliance officers to ensure the integrity of the trust accounting control framework."
  source: "`legal_ecm`.`trust`.`three_way_reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Outcome status of the three-way reconciliation (e.g., balanced, variance, pending) for compliance monitoring."
    - name: "reconciliation_method"
      expr: reconciliation_method
      comment: "Method used to perform the reconciliation (e.g., automated, manual) for process efficiency analysis."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction governing the reconciliation for cross-jurisdictional compliance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the reconciliation for multi-currency trust accounting analysis."
    - name: "regulatory_filing_required"
      expr: CASE WHEN regulatory_filing_required = TRUE THEN 'Filing Required' ELSE 'No Filing Required' END
      comment: "Indicates whether the reconciliation requires a regulatory filing, driving compliance reporting obligations."
    - name: "bank_name"
      expr: bank_name
      comment: "Name of the bank associated with the reconciliation for counterparty-level reconciliation analysis."
    - name: "reconciliation_period_year_month"
      expr: DATE_TRUNC('MONTH', reconciliation_period_start_date)
      comment: "Month of the reconciliation period for trend analysis of reconciliation outcomes over time."
  measures:
    - name: "total_variance_amount"
      expr: SUM(CAST(total_variance_amount AS DOUBLE))
      comment: "Total variance amount across all three-way reconciliations. Primary trust accounting integrity KPI; any non-zero variance requires investigation and resolution."
    - name: "total_unresolved_variance_amount"
      expr: SUM(CAST(unresolved_variance_amount AS DOUBLE))
      comment: "Total unresolved variance remaining after reconciliation review. Regulatory compliance risk metric; unresolved variances must be reported and remediated."
    - name: "total_prior_period_unresolved_variance"
      expr: SUM(CAST(prior_period_unresolved_variance AS DOUBLE))
      comment: "Total variance carried forward from prior periods. Measures the aging of unresolved reconciliation issues and escalation urgency."
    - name: "avg_variance_per_reconciliation"
      expr: AVG(CAST(total_variance_amount AS DOUBLE))
      comment: "Average variance amount per reconciliation. Baseline for identifying reconciliation periods with abnormal discrepancies."
    - name: "count_reconciliations_with_variance"
      expr: COUNT(CASE WHEN total_variance_amount != 0 THEN three_way_reconciliation_id END)
      comment: "Number of reconciliations with any non-zero variance. Measures the frequency of trust accounting discrepancies requiring investigation."
    - name: "reconciliation_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reconciliation_status = 'balanced' THEN three_way_reconciliation_id END) / NULLIF(COUNT(three_way_reconciliation_id), 0), 2)
      comment: "Percentage of three-way reconciliations that balanced without variance. Core trust accounting quality KPI; target is 100% for regulatory compliance."
    - name: "total_bank_errors"
      expr: SUM(CAST(bank_errors_total AS DOUBLE))
      comment: "Total value of errors attributable to the bank in reconciliations. Used to manage bank relationships and dispute resolution."
    - name: "total_ledger_errors"
      expr: SUM(CAST(ledger_errors_total AS DOUBLE))
      comment: "Total value of errors attributable to internal ledger entries. Measures internal trust accounting data quality and error correction needs."
    - name: "total_outstanding_checks"
      expr: SUM(CAST(outstanding_checks_total AS DOUBLE))
      comment: "Total value of outstanding checks across reconciliations. Measures timing differences and stale check exposure in trust accounts."
    - name: "total_deposits_in_transit"
      expr: SUM(CAST(deposits_in_transit_total AS DOUBLE))
      comment: "Total value of deposits in transit across reconciliations. Measures timing differences between trust ledger and bank statement recognition."
    - name: "count_pending_regulatory_filings"
      expr: COUNT(CASE WHEN regulatory_filing_required = TRUE AND regulatory_filing_date IS NULL THEN three_way_reconciliation_id END)
      comment: "Number of reconciliations requiring regulatory filing where the filing date has not been recorded. Compliance deadline risk metric."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`trust_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trust receipt metrics covering inbound fund volumes, AML/KYC screening compliance, IOLTA eligibility, reconciliation status, and third-party payment risk. Used by trust accountants and compliance officers to govern client fund intake."
  source: "`legal_ecm`.`trust`.`receipt`"
  dimensions:
    - name: "receipt_type"
      expr: receipt_type
      comment: "Type of receipt (e.g., retainer, settlement, court award) for inbound fund classification."
    - name: "receipt_status"
      expr: receipt_status
      comment: "Current processing status of the receipt (e.g., cleared, pending, reversed) for operational monitoring."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the receipt (e.g., wire, check, ACH) for channel analysis and fraud risk assessment."
    - name: "aml_screening_status"
      expr: aml_screening_status
      comment: "AML screening outcome for the receipt, used to identify high-risk inbound funds requiring compliance review."
    - name: "kyc_verification_status"
      expr: kyc_verification_status
      comment: "KYC verification status of the payor, used to ensure client due diligence is complete before funds are accepted."
    - name: "sanctions_screening_status"
      expr: sanctions_screening_status
      comment: "Sanctions screening outcome for the receipt, used to identify potential OFAC or international sanctions violations."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation state of the receipt for trust accounting completeness monitoring."
    - name: "iolta_eligible_flag"
      expr: CASE WHEN iolta_eligible_flag = TRUE THEN 'IOLTA Eligible' ELSE 'Non-IOLTA' END
      comment: "Indicates whether the receipt is eligible for IOLTA treatment, driving interest remittance obligations."
    - name: "third_party_payment_flag"
      expr: CASE WHEN third_party_payment_flag = TRUE THEN 'Third Party' ELSE 'Direct Client' END
      comment: "Flags receipts from third parties rather than direct clients, which carry elevated AML and compliance risk."
    - name: "source_of_funds"
      expr: source_of_funds
      comment: "Declared source of funds for the receipt, critical for AML compliance and client due diligence documentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the receipt for multi-currency trust accounting analysis."
    - name: "receipt_year_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month of receipt for trend analysis of inbound trust fund volumes over time."
  measures:
    - name: "total_receipt_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total value of trust receipts. Primary measure of inbound client fund volume and trust account funding activity."
    - name: "avg_receipt_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average receipt amount. Baseline for anomaly detection and benchmarking inbound fund sizes by matter type."
    - name: "total_iolta_eligible_amount"
      expr: SUM(CASE WHEN iolta_eligible_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of IOLTA-eligible receipts. Drives IOLTA interest calculation and remittance obligations to state bar programs."
    - name: "total_third_party_receipt_amount"
      expr: SUM(CASE WHEN third_party_payment_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of receipts from third parties. Elevated third-party volumes require enhanced AML scrutiny and source-of-funds documentation."
    - name: "count_aml_flagged_receipts"
      expr: COUNT(CASE WHEN aml_screening_status = 'flagged' THEN receipt_id END)
      comment: "Number of receipts flagged during AML screening. Drives compliance escalation and potential SAR filing decisions."
    - name: "count_sanctions_flagged_receipts"
      expr: COUNT(CASE WHEN sanctions_screening_status = 'flagged' THEN receipt_id END)
      comment: "Number of receipts flagged during sanctions screening. Critical compliance KPI; any positive count requires immediate legal and compliance escalation."
    - name: "count_unreconciled_receipts"
      expr: COUNT(CASE WHEN reconciliation_status != 'reconciled' THEN receipt_id END)
      comment: "Number of receipts not yet reconciled. Trust accounting completeness metric for identifying unmatched inbound fund entries."
    - name: "avg_aml_risk_score"
      expr: AVG(CAST(aml_risk_score AS DOUBLE))
      comment: "Average AML risk score across receipts. Portfolio-level AML risk indicator; rising averages signal increasing exposure requiring enhanced due diligence."
    - name: "aml_flag_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN aml_screening_status = 'flagged' THEN receipt_id END) / NULLIF(COUNT(receipt_id), 0), 2)
      comment: "Percentage of receipts flagged during AML screening. Trend metric for AML risk exposure in inbound trust fund flows."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`trust_escrow_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Escrow arrangement metrics covering fund balances, release activity, dispute exposure, IOLTA and regulatory reporting obligations, and arrangement lifecycle. Used by transactional lawyers, trust managers, and compliance officers to govern escrow fund stewardship."
  source: "`legal_ecm`.`trust`.`escrow_arrangement`"
  dimensions:
    - name: "escrow_status"
      expr: escrow_status
      comment: "Current lifecycle status of the escrow arrangement (e.g., active, released, disputed, closed) for portfolio monitoring."
    - name: "escrow_purpose"
      expr: escrow_purpose
      comment: "Business purpose of the escrow (e.g., M&A transaction, real estate, litigation settlement) for deal-type analysis."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of underlying transaction driving the escrow arrangement for practice area segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the escrow arrangement for multi-currency exposure analysis."
    - name: "governing_law_jurisdiction"
      expr: governing_law_jurisdiction
      comment: "Governing law jurisdiction of the escrow agreement for cross-border compliance and dispute resolution analysis."
    - name: "interest_bearing_flag"
      expr: CASE WHEN interest_bearing_flag = TRUE THEN 'Interest-Bearing' ELSE 'Non-Interest-Bearing' END
      comment: "Indicates whether the escrow arrangement accrues interest, driving interest allocation and IOLTA reporting obligations."
    - name: "dispute_flag"
      expr: CASE WHEN dispute_flag = TRUE THEN 'Disputed' ELSE 'Undisputed' END
      comment: "Flags escrow arrangements subject to active disputes, which require enhanced legal oversight and may delay fund release."
    - name: "regulatory_reporting_flag"
      expr: CASE WHEN regulatory_reporting_flag = TRUE THEN 'Reportable' ELSE 'Non-Reportable' END
      comment: "Flags escrow arrangements subject to regulatory reporting obligations."
    - name: "release_schedule_type"
      expr: release_schedule_type
      comment: "Type of release schedule (e.g., milestone-based, date-based, conditional) for escrow release planning."
    - name: "establishment_year_month"
      expr: DATE_TRUNC('MONTH', establishment_date)
      comment: "Month the escrow arrangement was established for cohort and trend analysis of escrow portfolio growth."
  measures:
    - name: "total_escrow_amount"
      expr: SUM(CAST(escrow_amount AS DOUBLE))
      comment: "Total value of funds held in escrow arrangements. Primary measure of escrow portfolio size and fiduciary obligation scale."
    - name: "total_current_escrow_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current balance across active escrow arrangements. Measures unreleased escrow funds still under management."
    - name: "total_released_amount"
      expr: SUM(CAST(total_released_amount AS DOUBLE))
      comment: "Total value of funds released from escrow arrangements. Measures escrow fulfillment activity and deal completion velocity."
    - name: "escrow_release_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_released_amount AS DOUBLE)) / NULLIF(SUM(CAST(escrow_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total escrow amount that has been released. Measures escrow portfolio maturity and deal completion progress."
    - name: "count_disputed_arrangements"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN escrow_arrangement_id END)
      comment: "Number of escrow arrangements with active disputes. Legal risk KPI; disputed escrows require enhanced oversight and may generate litigation exposure."
    - name: "total_disputed_escrow_balance"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN CAST(current_balance AS DOUBLE) ELSE 0 END)
      comment: "Total value of funds held in disputed escrow arrangements. Quantifies financial exposure from escrow disputes requiring legal resolution."
    - name: "count_active_escrow_arrangements"
      expr: COUNT(CASE WHEN escrow_status = 'active' THEN escrow_arrangement_id END)
      comment: "Number of currently active escrow arrangements. Operational capacity metric for trust department escrow management workload."
    - name: "count_distinct_matters_with_escrow"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of distinct matters with escrow arrangements. Measures the breadth of transactional matters requiring escrow fund management."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`trust_retainer_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retainer agreement metrics covering fund balances, replenishment activity, refund obligations, compliance status, and auto-replenishment adoption. Used by billing managers, practice group leaders, and compliance officers to govern retainer fund management."
  source: "`legal_ecm`.`trust`.`retainer_agreement`"
  dimensions:
    - name: "retainer_type"
      expr: retainer_type
      comment: "Type of retainer arrangement (e.g., evergreen, fixed, security) for portfolio segmentation and billing analysis."
    - name: "retainer_agreement_status"
      expr: retainer_agreement_status
      comment: "Current lifecycle status of the retainer agreement (e.g., active, expired, terminated) for portfolio health monitoring."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance review status of the retainer agreement for identifying agreements requiring remediation."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction governing the retainer agreement for cross-jurisdictional compliance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the retainer for multi-currency portfolio analysis."
    - name: "auto_replenishment_enabled"
      expr: CASE WHEN auto_replenishment_enabled = TRUE THEN 'Auto-Replenishment On' ELSE 'Manual Replenishment' END
      comment: "Indicates whether auto-replenishment is enabled, used to assess retainer continuity risk and billing efficiency."
    - name: "interest_bearing"
      expr: CASE WHEN interest_bearing = TRUE THEN 'Interest-Bearing' ELSE 'Non-Interest-Bearing' END
      comment: "Indicates whether the retainer account accrues interest, relevant for IOLTA and client interest obligations."
    - name: "effective_year_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the retainer agreement became effective for cohort analysis of retainer portfolio growth."
  measures:
    - name: "total_agreed_retainer_amount"
      expr: SUM(CAST(agreed_retainer_amount AS DOUBLE))
      comment: "Total agreed retainer value across all agreements. Measures the total committed retainer funding obligation from clients."
    - name: "total_current_retainer_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current balance held across all retainer accounts. Measures available retainer funds for billing drawdown."
    - name: "total_refund_due_amount"
      expr: SUM(CAST(refund_due_amount AS DOUBLE))
      comment: "Total retainer refunds owed to clients. Measures outstanding client refund obligations requiring timely processing."
    - name: "retainer_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_disbursements AS DOUBLE)) / NULLIF(SUM(CAST(agreed_retainer_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of agreed retainer amount that has been disbursed. Measures retainer consumption rate and remaining capacity for billing."
    - name: "avg_retainer_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average current balance per retainer agreement. Baseline for identifying underfunded retainers requiring replenishment."
    - name: "count_below_replenishment_threshold"
      expr: COUNT(CASE WHEN current_balance < replenishment_threshold_amount THEN retainer_agreement_id END)
      comment: "Number of retainer agreements where the current balance has fallen below the replenishment threshold. Drives client billing notifications and cash flow management."
    - name: "count_non_compliant_agreements"
      expr: COUNT(CASE WHEN compliance_status != 'compliant' THEN retainer_agreement_id END)
      comment: "Number of retainer agreements with non-compliant status. Compliance risk metric requiring review and remediation to avoid regulatory exposure."
    - name: "total_replenishment_amount"
      expr: SUM(CAST(replenishment_amount AS DOUBLE))
      comment: "Total value of retainer replenishments received. Measures client funding activity and retainer account top-up velocity."
    - name: "count_auto_replenishment_enabled"
      expr: COUNT(CASE WHEN auto_replenishment_enabled = TRUE THEN retainer_agreement_id END)
      comment: "Number of retainer agreements with auto-replenishment enabled. Measures adoption of automated billing controls that reduce underfunding risk."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`trust_regulatory_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory reporting metrics for trust accounts, covering submission timeliness, IOLTA interest remittance, discrepancy exposure, overdue filings, and compliance certification rates. Used by compliance officers and managing partners to govern regulatory filing obligations."
  source: "`legal_ecm`.`trust`.`regulatory_report`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of regulatory report (e.g., IOLTA, three-way reconciliation, AML) for filing category analysis."
    - name: "report_status"
      expr: report_status
      comment: "Current status of the regulatory report (e.g., submitted, pending, overdue) for compliance monitoring."
    - name: "regulatory_body_name"
      expr: regulatory_body_name
      comment: "Name of the regulatory body to which the report is submitted for regulator-level compliance tracking."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction of the regulatory report for cross-jurisdictional compliance reporting."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status associated with the regulatory report for identifying reports with unresolved discrepancies."
    - name: "is_overdue"
      expr: CASE WHEN is_overdue = TRUE THEN 'Overdue' ELSE 'On Time' END
      comment: "Flags regulatory reports that have missed their submission deadline, triggering compliance escalation."
    - name: "compliance_certification_flag"
      expr: CASE WHEN compliance_certification_flag = TRUE THEN 'Certified' ELSE 'Uncertified' END
      comment: "Indicates whether the report has been compliance-certified, a mandatory step for regulatory submission."
    - name: "regulatory_query_flag"
      expr: CASE WHEN regulatory_query_flag = TRUE THEN 'Query Received' ELSE 'No Query' END
      comment: "Flags reports that have received a regulatory query, requiring a formal response within the response due date."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the report (e.g., electronic, paper) for process efficiency analysis."
    - name: "reporting_period_year_month"
      expr: DATE_TRUNC('MONTH', reporting_period_start_date)
      comment: "Month of the reporting period for trend analysis of regulatory filing activity over time."
  measures:
    - name: "total_trust_balance_reported"
      expr: SUM(CAST(total_trust_balance_reported AS DOUBLE))
      comment: "Total trust balance reported across all regulatory filings. Measures the aggregate fiduciary obligation disclosed to regulators."
    - name: "total_iolta_interest_earned"
      expr: SUM(CAST(iolta_interest_earned AS DOUBLE))
      comment: "Total IOLTA interest earned as reported in regulatory filings. Drives state bar remittance obligations and IOLTA program funding."
    - name: "total_iolta_interest_remitted"
      expr: SUM(CAST(iolta_interest_remitted AS DOUBLE))
      comment: "Total IOLTA interest remitted to state bar programs. Measures fulfillment of IOLTA remittance obligations."
    - name: "iolta_remittance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(iolta_interest_remitted AS DOUBLE)) / NULLIF(SUM(CAST(iolta_interest_earned AS DOUBLE)), 0), 2)
      comment: "Percentage of earned IOLTA interest that has been remitted. Compliance KPI for IOLTA program obligations; target is 100%."
    - name: "total_discrepancy_amount"
      expr: SUM(CAST(discrepancy_amount AS DOUBLE))
      comment: "Total discrepancy amount identified across regulatory reports. Measures the scale of trust accounting errors requiring explanation and remediation."
    - name: "count_overdue_reports"
      expr: COUNT(CASE WHEN is_overdue = TRUE THEN regulatory_report_id END)
      comment: "Number of regulatory reports past their submission deadline. Zero-tolerance compliance KPI; overdue filings expose the firm to regulatory sanctions."
    - name: "count_uncertified_reports"
      expr: COUNT(CASE WHEN compliance_certification_flag = FALSE THEN regulatory_report_id END)
      comment: "Number of reports lacking compliance certification. Compliance gate metric; uncertified reports cannot be validly submitted to regulators."
    - name: "count_reports_with_regulatory_queries"
      expr: COUNT(CASE WHEN regulatory_query_flag = TRUE THEN regulatory_report_id END)
      comment: "Number of reports that have received regulatory queries. Measures regulatory scrutiny level and response workload for the compliance team."
    - name: "on_time_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_overdue = FALSE AND report_status = 'submitted' THEN regulatory_report_id END) / NULLIF(COUNT(CASE WHEN report_status = 'submitted' THEN regulatory_report_id END), 0), 2)
      comment: "Percentage of submitted regulatory reports filed on time. Compliance performance KPI for trust regulatory filing timeliness."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`trust_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trust fund transfer metrics covering inter-account movement volumes, IOLTA applicability, reconciliation status, earned fee transfers, and reversal activity. Used by trust accountants and billing managers to monitor fund movement integrity and fee transfer compliance."
  source: "`legal_ecm`.`trust`.`transfer`"
  dimensions:
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of trust transfer (e.g., fee transfer, client refund, inter-account) for fund movement classification."
    - name: "transfer_status"
      expr: transfer_status
      comment: "Current status of the transfer (e.g., completed, pending, reversed) for operational monitoring."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the transfer for channel analysis and operational efficiency."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation state of the transfer for trust accounting completeness monitoring."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction of the transfer for cross-border compliance and regulatory reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transfer for multi-currency trust accounting analysis."
    - name: "iolta_applicable_flag"
      expr: CASE WHEN iolta_applicable_flag = TRUE THEN 'IOLTA Applicable' ELSE 'Non-IOLTA' END
      comment: "Indicates whether the transfer is subject to IOLTA rules, driving interest calculation and reporting obligations."
    - name: "transfer_year_month"
      expr: DATE_TRUNC('MONTH', transfer_date)
      comment: "Month of the transfer for trend analysis of trust fund movement volumes over time."
  measures:
    - name: "total_transfer_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total value of trust fund transfers. Measures the volume of inter-account fund movements and fee transfer activity."
    - name: "total_earned_fee_transferred"
      expr: SUM(CAST(earned_fee_amount AS DOUBLE))
      comment: "Total earned fees transferred from trust to operating accounts. Core billing KPI measuring revenue recognition from trust fund drawdowns."
    - name: "avg_transfer_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average transfer amount. Baseline for anomaly detection and benchmarking transfer sizes against matter type norms."
    - name: "count_unreconciled_transfers"
      expr: COUNT(CASE WHEN reconciliation_status != 'reconciled' THEN transfer_id END)
      comment: "Number of transfers not yet reconciled. Trust accounting completeness metric for identifying unmatched fund movements."
    - name: "count_reversed_transfers"
      expr: COUNT(CASE WHEN transfer_status = 'reversed' THEN transfer_id END)
      comment: "Number of reversed transfers. Elevated reversal counts signal operational errors or disputed fund movements requiring investigation."
    - name: "total_iolta_applicable_transfer_amount"
      expr: SUM(CASE WHEN iolta_applicable_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of IOLTA-applicable transfers. Drives IOLTA interest calculation and regulatory reporting obligations."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN transfer_status = 'reversed' THEN transfer_id END) / NULLIF(COUNT(transfer_id), 0), 2)
      comment: "Percentage of transfers that have been reversed. Quality metric for trust fund transfer processing accuracy."
    - name: "count_distinct_matters_with_transfers"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of distinct matters with trust fund transfers. Measures the breadth of active matters generating trust fund movement activity."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`trust_bank_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bank statement reconciliation metrics covering discrepancy detection, credit/debit volumes, unmatched transaction exposure, and IOLTA reporting period coverage. Used by trust accountants to validate bank statement integrity and drive three-way reconciliation processes."
  source: "`legal_ecm`.`trust`.`bank_statement`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the bank statement (e.g., reconciled, pending, discrepancy) for identifying statements requiring attention."
    - name: "financial_institution_name"
      expr: financial_institution_name
      comment: "Name of the financial institution issuing the statement for counterparty-level reconciliation analysis."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction associated with the bank statement for cross-jurisdictional compliance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the bank statement for multi-currency trust accounting analysis."
    - name: "is_final_statement"
      expr: CASE WHEN is_final_statement = TRUE THEN 'Final' ELSE 'Interim' END
      comment: "Indicates whether the statement is a final or interim statement, used to determine reconciliation completeness."
    - name: "iolta_reporting_period"
      expr: iolta_reporting_period
      comment: "IOLTA reporting period associated with the statement for IOLTA compliance period tracking."
    - name: "statement_year_month"
      expr: DATE_TRUNC('MONTH', statement_date)
      comment: "Month of the bank statement for trend analysis of trust account activity over time."
    - name: "statement_source"
      expr: statement_source
      comment: "Source of the bank statement (e.g., electronic feed, manual upload) for data quality and import process monitoring."
  measures:
    - name: "total_closing_balance"
      expr: SUM(CAST(closing_balance AS DOUBLE))
      comment: "Total closing balance across all bank statements. Measures aggregate trust account balances as confirmed by financial institutions."
    - name: "total_credits"
      expr: SUM(CAST(total_credits AS DOUBLE))
      comment: "Total credit amounts across all bank statements. Measures total inbound fund flows confirmed by bank records."
    - name: "total_debits"
      expr: SUM(CAST(total_debits AS DOUBLE))
      comment: "Total debit amounts across all bank statements. Measures total outbound fund flows confirmed by bank records."
    - name: "total_discrepancy_amount"
      expr: SUM(CAST(discrepancy_amount AS DOUBLE))
      comment: "Total discrepancy amount across all bank statements. Measures the scale of unresolved differences between bank records and trust ledger entries."
    - name: "total_interest_earned"
      expr: SUM(CAST(interest_earned AS DOUBLE))
      comment: "Total interest earned as reported on bank statements. Drives IOLTA remittance calculations and client interest disbursement obligations."
    - name: "total_service_charges"
      expr: SUM(CAST(service_charges AS DOUBLE))
      comment: "Total bank service charges across all statements. Measures bank fee expense and identifies accounts with excessive service charge burdens."
    - name: "count_statements_with_discrepancy"
      expr: COUNT(CASE WHEN discrepancy_amount != 0 THEN bank_statement_id END)
      comment: "Number of bank statements with non-zero discrepancies. Frequency metric for trust accounting reconciliation failures requiring investigation."
    - name: "avg_daily_balance"
      expr: AVG(CAST(average_daily_balance AS DOUBLE))
      comment: "Average daily balance across all bank statements. Used for IOLTA interest calculation and account activity benchmarking."
    - name: "discrepancy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN discrepancy_amount != 0 THEN bank_statement_id END) / NULLIF(COUNT(bank_statement_id), 0), 2)
      comment: "Percentage of bank statements with discrepancies. Quality KPI for trust accounting reconciliation processes; target is 0%."
$$;