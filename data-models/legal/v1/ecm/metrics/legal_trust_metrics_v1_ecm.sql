-- Metric views for domain: trust | Business: Legal | Version: 1 | Generated on: 2026-05-07 11:54:14

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`trust_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trust account financial position and compliance metrics for fiduciary oversight and regulatory reporting"
  source: "`legal_ecm`.`trust`.`account`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Type of trust account (client trust, IOLTA, escrow, retainer)"
    - name: "account_status"
      expr: account_status
      comment: "Current operational status of the trust account"
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Legal jurisdiction governing the trust account"
    - name: "aml_risk_rating"
      expr: aml_risk_rating
      comment: "Anti-money laundering risk classification"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Current reconciliation state for compliance tracking"
    - name: "interest_bearing_flag"
      expr: interest_bearing_flag
      comment: "Whether account earns interest (IOLTA indicator)"
    - name: "opened_year"
      expr: YEAR(opened_date)
      comment: "Year the trust account was opened"
    - name: "opened_quarter"
      expr: CONCAT('Q', QUARTER(opened_date), '-', YEAR(opened_date))
      comment: "Quarter the trust account was opened"
  measures:
    - name: "total_trust_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total fiduciary funds held across trust accounts - primary regulatory reporting metric"
    - name: "average_account_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Mean balance per trust account for portfolio analysis"
    - name: "total_minimum_balance_requirement"
      expr: SUM(CAST(minimum_balance_required AS DOUBLE))
      comment: "Aggregate minimum balance obligations for liquidity planning"
    - name: "account_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of active trust accounts under management"
    - name: "iolta_account_count"
      expr: COUNT(DISTINCT CASE WHEN interest_bearing_flag = TRUE THEN account_id END)
      comment: "Count of Interest on Lawyers Trust Accounts for regulatory compliance tracking"
    - name: "overdue_reconciliation_count"
      expr: COUNT(DISTINCT CASE WHEN next_reconciliation_due_date < CURRENT_DATE() THEN account_id END)
      comment: "Number of accounts with overdue reconciliations - critical compliance risk indicator"
    - name: "high_risk_aml_account_count"
      expr: COUNT(DISTINCT CASE WHEN aml_risk_rating = 'High' THEN account_id END)
      comment: "Count of accounts flagged as high AML risk requiring enhanced monitoring"
    - name: "average_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Mean interest rate across interest-bearing accounts for yield analysis"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`trust_ledger_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trust transaction activity metrics for cash flow analysis, compliance monitoring, and audit trail integrity"
  source: "`legal_ecm`.`trust`.`ledger_entry`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of trust transaction (deposit, disbursement, transfer, adjustment)"
    - name: "entry_direction"
      expr: entry_direction
      comment: "Direction of funds movement (inbound, outbound)"
    - name: "disbursement_category"
      expr: disbursement_category
      comment: "Category of disbursement for expense classification"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (wire, check, ACH, electronic)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation state of the ledger entry"
    - name: "aml_screening_status"
      expr: aml_screening_status
      comment: "AML screening result for transaction monitoring"
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction for regulatory reporting"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of transaction for time-series analysis"
    - name: "transaction_quarter"
      expr: CONCAT('Q', QUARTER(transaction_date), '-', YEAR(transaction_date))
      comment: "Quarter of transaction for quarterly reporting"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether this entry is a reversal transaction"
  measures:
    - name: "total_transaction_volume"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total monetary value of trust transactions - primary cash flow metric"
    - name: "transaction_count"
      expr: COUNT(DISTINCT ledger_entry_id)
      comment: "Number of trust ledger entries for activity volume tracking"
    - name: "average_transaction_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Mean transaction size for pattern analysis and anomaly detection"
    - name: "unreconciled_transaction_count"
      expr: COUNT(DISTINCT CASE WHEN reconciliation_status != 'Reconciled' THEN ledger_entry_id END)
      comment: "Count of unreconciled entries - key control metric for audit readiness"
    - name: "unreconciled_transaction_value"
      expr: SUM(CASE WHEN reconciliation_status != 'Reconciled' THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of unreconciled transactions - financial exposure indicator"
    - name: "reversal_transaction_count"
      expr: COUNT(DISTINCT CASE WHEN reversal_flag = TRUE THEN ledger_entry_id END)
      comment: "Number of reversed transactions - error rate and process quality indicator"
    - name: "aml_flagged_transaction_count"
      expr: COUNT(DISTINCT CASE WHEN aml_screening_status IN ('Flagged', 'Under Review', 'Suspicious') THEN ledger_entry_id END)
      comment: "Count of transactions flagged for AML review - compliance risk metric"
    - name: "regulatory_reportable_transaction_count"
      expr: COUNT(DISTINCT CASE WHEN regulatory_reporting_flag = TRUE THEN ledger_entry_id END)
      comment: "Number of transactions requiring regulatory reporting for compliance workload planning"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`trust_three_way_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trust reconciliation quality and variance metrics for fiduciary control effectiveness and regulatory compliance"
  source: "`legal_ecm`.`trust`.`three_way_reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of the three-way reconciliation process"
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction for regulatory reporting requirements"
    - name: "reconciliation_method"
      expr: reconciliation_method
      comment: "Method used to perform reconciliation (manual, automated, hybrid)"
    - name: "regulatory_filing_required"
      expr: regulatory_filing_required
      comment: "Whether this reconciliation requires regulatory filing"
    - name: "reconciliation_month"
      expr: DATE_TRUNC('MONTH', reconciliation_performed_date)
      comment: "Month reconciliation was performed for trend analysis"
    - name: "reconciliation_quarter"
      expr: CONCAT('Q', QUARTER(reconciliation_performed_date), '-', YEAR(reconciliation_performed_date))
      comment: "Quarter of reconciliation for quarterly compliance reporting"
  measures:
    - name: "total_variance_amount"
      expr: SUM(CAST(total_variance_amount AS DOUBLE))
      comment: "Total reconciliation variance - primary control effectiveness metric for fiduciary risk"
    - name: "total_unresolved_variance"
      expr: SUM(CAST(unresolved_variance_amount AS DOUBLE))
      comment: "Total unresolved variance requiring investigation - critical risk exposure indicator"
    - name: "reconciliation_count"
      expr: COUNT(DISTINCT three_way_reconciliation_id)
      comment: "Number of reconciliations performed for compliance activity tracking"
    - name: "average_variance_amount"
      expr: AVG(CAST(total_variance_amount AS DOUBLE))
      comment: "Mean variance per reconciliation for process quality assessment"
    - name: "total_outstanding_checks"
      expr: SUM(CAST(outstanding_checks_total AS DOUBLE))
      comment: "Total value of outstanding checks for liquidity and timing analysis"
    - name: "total_deposits_in_transit"
      expr: SUM(CAST(deposits_in_transit_total AS DOUBLE))
      comment: "Total deposits in transit for cash flow timing analysis"
    - name: "total_exception_count"
      expr: SUM(CAST(exception_count AS BIGINT))
      comment: "Total number of reconciliation exceptions - process quality and control effectiveness metric"
    - name: "unresolved_exception_count"
      expr: SUM(CAST(unresolved_exception_count AS BIGINT))
      comment: "Count of unresolved exceptions requiring remediation - operational risk indicator"
    - name: "reconciliations_with_variance_count"
      expr: COUNT(DISTINCT CASE WHEN CAST(total_variance_amount AS DOUBLE) != 0 THEN three_way_reconciliation_id END)
      comment: "Number of reconciliations with non-zero variance - control failure rate indicator"
    - name: "average_bank_errors"
      expr: AVG(CAST(bank_errors_total AS DOUBLE))
      comment: "Mean bank errors per reconciliation for financial institution quality assessment"
    - name: "average_ledger_errors"
      expr: AVG(CAST(ledger_errors_total AS DOUBLE))
      comment: "Mean ledger errors per reconciliation for internal process quality assessment"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`trust_disbursement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trust disbursement metrics for fiduciary payment control, authorization effectiveness, and compliance monitoring"
  source: "`legal_ecm`.`trust`.`trust_disbursement`"
  dimensions:
    - name: "disbursement_type"
      expr: disbursement_type
      comment: "Type of disbursement (client payment, vendor payment, court payment, fee transfer)"
    - name: "disbursement_category"
      expr: disbursement_category
      comment: "Category of disbursement for expense classification"
    - name: "authorization_status"
      expr: authorization_status
      comment: "Authorization status of the disbursement"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (wire, check, ACH, electronic)"
    - name: "payee_type"
      expr: payee_type
      comment: "Type of payee (client, vendor, court, government, third party)"
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction for regulatory compliance"
    - name: "is_iolta_reportable"
      expr: is_iolta_reportable
      comment: "Whether disbursement is reportable under IOLTA rules"
    - name: "is_three_way_reconciled"
      expr: is_three_way_reconciled
      comment: "Whether disbursement has been three-way reconciled"
    - name: "disbursement_month"
      expr: DATE_TRUNC('MONTH', disbursement_date)
      comment: "Month of disbursement for time-series analysis"
    - name: "disbursement_quarter"
      expr: CONCAT('Q', QUARTER(disbursement_date), '-', YEAR(disbursement_date))
      comment: "Quarter of disbursement for quarterly reporting"
  measures:
    - name: "total_disbursement_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total value of trust disbursements - primary cash outflow metric for fiduciary oversight"
    - name: "disbursement_count"
      expr: COUNT(DISTINCT trust_disbursement_id)
      comment: "Number of trust disbursements for payment volume tracking"
    - name: "average_disbursement_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Mean disbursement size for payment pattern analysis"
    - name: "pending_authorization_count"
      expr: COUNT(DISTINCT CASE WHEN authorization_status IN ('Pending', 'Submitted', 'Under Review') THEN trust_disbursement_id END)
      comment: "Count of disbursements awaiting authorization - workflow bottleneck indicator"
    - name: "pending_authorization_value"
      expr: SUM(CASE WHEN authorization_status IN ('Pending', 'Submitted', 'Under Review') THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of disbursements awaiting authorization - liquidity planning metric"
    - name: "unreconciled_disbursement_count"
      expr: COUNT(DISTINCT CASE WHEN is_three_way_reconciled = FALSE THEN trust_disbursement_id END)
      comment: "Count of unreconciled disbursements - control effectiveness indicator"
    - name: "unreconciled_disbursement_value"
      expr: SUM(CASE WHEN is_three_way_reconciled = FALSE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of unreconciled disbursements - financial exposure metric"
    - name: "iolta_reportable_disbursement_count"
      expr: COUNT(DISTINCT CASE WHEN is_iolta_reportable = TRUE THEN trust_disbursement_id END)
      comment: "Count of IOLTA-reportable disbursements for regulatory compliance workload"
    - name: "iolta_reportable_disbursement_value"
      expr: SUM(CASE WHEN is_iolta_reportable = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of IOLTA-reportable disbursements for regulatory reporting"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`trust_client_trust_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client-level trust balance metrics for fiduciary position monitoring, dormancy tracking, and escheatment risk management"
  source: "`legal_ecm`.`trust`.`client_trust_balance`"
  dimensions:
    - name: "balance_status"
      expr: balance_status
      comment: "Current status of the client trust balance"
    - name: "trust_account_type"
      expr: trust_account_type
      comment: "Type of trust account holding the balance"
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction governing the trust balance"
    - name: "negative_balance_flag"
      expr: negative_balance_flag
      comment: "Whether balance is negative - critical control failure indicator"
    - name: "escheatment_eligible_flag"
      expr: escheatment_eligible_flag
      comment: "Whether balance is eligible for escheatment to state"
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Whether balance requires regulatory reporting"
    - name: "balance_as_of_month"
      expr: DATE_TRUNC('MONTH', balance_as_of_date)
      comment: "Month of balance snapshot for trend analysis"
    - name: "balance_as_of_quarter"
      expr: CONCAT('Q', QUARTER(balance_as_of_date), '-', YEAR(balance_as_of_date))
      comment: "Quarter of balance snapshot for quarterly reporting"
  measures:
    - name: "total_client_trust_balance"
      expr: SUM(CAST(current_balance_amount AS DOUBLE))
      comment: "Total client trust balances - primary fiduciary liability metric for regulatory reporting"
    - name: "total_available_balance"
      expr: SUM(CAST(available_balance_amount AS DOUBLE))
      comment: "Total available client balances for liquidity analysis"
    - name: "total_held_balance"
      expr: SUM(CAST(held_balance_amount AS DOUBLE))
      comment: "Total held balances (restricted funds) for fiduciary control tracking"
    - name: "client_balance_count"
      expr: COUNT(DISTINCT client_trust_balance_id)
      comment: "Number of client trust balances under management"
    - name: "average_client_balance"
      expr: AVG(CAST(current_balance_amount AS DOUBLE))
      comment: "Mean balance per client for portfolio analysis"
    - name: "negative_balance_count"
      expr: COUNT(DISTINCT CASE WHEN negative_balance_flag = TRUE THEN client_trust_balance_id END)
      comment: "Count of negative balances - critical control failure requiring immediate remediation"
    - name: "negative_balance_amount"
      expr: SUM(CASE WHEN negative_balance_flag = TRUE THEN CAST(current_balance_amount AS DOUBLE) ELSE 0 END)
      comment: "Total negative balance exposure - fiduciary risk and potential regulatory breach"
    - name: "escheatment_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN escheatment_eligible_flag = TRUE THEN client_trust_balance_id END)
      comment: "Count of balances eligible for escheatment - dormancy management metric"
    - name: "escheatment_eligible_amount"
      expr: SUM(CASE WHEN escheatment_eligible_flag = TRUE THEN CAST(current_balance_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value eligible for escheatment - state remittance liability"
    - name: "total_interest_earned"
      expr: SUM(CAST(interest_earned_amount AS DOUBLE))
      comment: "Total interest earned on client balances for IOLTA reporting"
    - name: "total_deposits"
      expr: SUM(CAST(total_deposits_amount AS DOUBLE))
      comment: "Total deposits into client trust balances for cash flow analysis"
    - name: "total_disbursements"
      expr: SUM(CAST(total_disbursements_amount AS DOUBLE))
      comment: "Total disbursements from client trust balances for cash flow analysis"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`trust_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trust exception and control failure metrics for risk management, regulatory breach tracking, and remediation effectiveness"
  source: "`legal_ecm`.`trust`.`trust_exception`"
  dimensions:
    - name: "exception_type"
      expr: exception_type
      comment: "Type of trust exception (reconciliation variance, unauthorized disbursement, negative balance, etc.)"
    - name: "exception_category"
      expr: exception_category
      comment: "Category of exception for classification and reporting"
    - name: "exception_status"
      expr: exception_status
      comment: "Current status of exception resolution"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the exception (critical, high, medium, low)"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level for management attention"
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Whether exception must be reported to regulators"
    - name: "professional_indemnity_notified_flag"
      expr: professional_indemnity_notified_flag
      comment: "Whether professional indemnity insurer has been notified"
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether this is a recurring exception - systemic control weakness indicator"
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction for regulatory reporting"
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_date)
      comment: "Month exception was detected for trend analysis"
    - name: "detection_quarter"
      expr: CONCAT('Q', QUARTER(detection_date), '-', YEAR(detection_date))
      comment: "Quarter exception was detected for quarterly risk reporting"
  measures:
    - name: "total_exception_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total monetary value of trust exceptions - primary risk exposure metric"
    - name: "exception_count"
      expr: COUNT(DISTINCT trust_exception_id)
      comment: "Number of trust exceptions - control effectiveness and process quality indicator"
    - name: "average_exception_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Mean exception value for risk assessment and materiality analysis"
    - name: "unresolved_exception_count"
      expr: COUNT(DISTINCT CASE WHEN exception_status IN ('Open', 'Under Investigation', 'Pending Resolution') THEN trust_exception_id END)
      comment: "Count of unresolved exceptions - operational risk and remediation backlog indicator"
    - name: "unresolved_exception_value"
      expr: SUM(CASE WHEN exception_status IN ('Open', 'Under Investigation', 'Pending Resolution') THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of unresolved exceptions - financial exposure requiring management attention"
    - name: "critical_exception_count"
      expr: COUNT(DISTINCT CASE WHEN severity_level = 'Critical' THEN trust_exception_id END)
      comment: "Count of critical exceptions - highest priority risk requiring immediate action"
    - name: "critical_exception_value"
      expr: SUM(CASE WHEN severity_level = 'Critical' THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of critical exceptions - material risk exposure"
    - name: "regulatory_reportable_exception_count"
      expr: COUNT(DISTINCT CASE WHEN regulatory_reportable_flag = TRUE THEN trust_exception_id END)
      comment: "Count of exceptions requiring regulatory reporting - compliance breach indicator"
    - name: "regulatory_reportable_exception_value"
      expr: SUM(CASE WHEN regulatory_reportable_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of regulatory reportable exceptions - regulatory risk exposure"
    - name: "recurring_exception_count"
      expr: COUNT(DISTINCT CASE WHEN recurrence_flag = TRUE THEN trust_exception_id END)
      comment: "Count of recurring exceptions - systemic control weakness requiring root cause remediation"
    - name: "indemnity_notified_exception_count"
      expr: COUNT(DISTINCT CASE WHEN professional_indemnity_notified_flag = TRUE THEN trust_exception_id END)
      comment: "Count of exceptions escalated to professional indemnity - potential claim indicator"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`trust_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trust receipt metrics for cash inflow monitoring, AML compliance, and deposit processing effectiveness"
  source: "`legal_ecm`.`trust`.`receipt`"
  dimensions:
    - name: "receipt_type"
      expr: receipt_type
      comment: "Type of receipt (client deposit, retainer, settlement, reimbursement)"
    - name: "receipt_status"
      expr: receipt_status
      comment: "Current status of the receipt"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment received (wire, check, ACH, cash, electronic)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the receipt"
    - name: "aml_screening_status"
      expr: aml_screening_status
      comment: "AML screening result for compliance monitoring"
    - name: "kyc_verification_status"
      expr: kyc_verification_status
      comment: "Know Your Client verification status"
    - name: "sanctions_screening_status"
      expr: sanctions_screening_status
      comment: "Sanctions screening result for compliance"
    - name: "third_party_payment_flag"
      expr: third_party_payment_flag
      comment: "Whether payment is from a third party - elevated AML risk indicator"
    - name: "iolta_eligible_flag"
      expr: iolta_eligible_flag
      comment: "Whether receipt is eligible for IOLTA account"
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month of receipt for time-series analysis"
    - name: "receipt_quarter"
      expr: CONCAT('Q', QUARTER(receipt_date), '-', YEAR(receipt_date))
      comment: "Quarter of receipt for quarterly reporting"
  measures:
    - name: "total_receipt_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total value of trust receipts - primary cash inflow metric for fiduciary oversight"
    - name: "receipt_count"
      expr: COUNT(DISTINCT receipt_id)
      comment: "Number of trust receipts for deposit volume tracking"
    - name: "average_receipt_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Mean receipt size for deposit pattern analysis"
    - name: "unreconciled_receipt_count"
      expr: COUNT(DISTINCT CASE WHEN reconciliation_status != 'Reconciled' THEN receipt_id END)
      comment: "Count of unreconciled receipts - control effectiveness indicator"
    - name: "unreconciled_receipt_value"
      expr: SUM(CASE WHEN reconciliation_status != 'Reconciled' THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of unreconciled receipts - financial exposure metric"
    - name: "aml_flagged_receipt_count"
      expr: COUNT(DISTINCT CASE WHEN aml_screening_status IN ('Flagged', 'Under Review', 'Suspicious') THEN receipt_id END)
      comment: "Count of receipts flagged for AML review - compliance risk indicator"
    - name: "aml_flagged_receipt_value"
      expr: SUM(CASE WHEN aml_screening_status IN ('Flagged', 'Under Review', 'Suspicious') THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of AML-flagged receipts - financial crime risk exposure"
    - name: "third_party_payment_count"
      expr: COUNT(DISTINCT CASE WHEN third_party_payment_flag = TRUE THEN receipt_id END)
      comment: "Count of third-party payments - elevated AML risk requiring enhanced due diligence"
    - name: "third_party_payment_value"
      expr: SUM(CASE WHEN third_party_payment_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of third-party payments - AML risk exposure metric"
    - name: "average_aml_risk_score"
      expr: AVG(CAST(aml_risk_score AS DOUBLE))
      comment: "Mean AML risk score across receipts for portfolio risk assessment"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`trust_account_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trust account audit metrics for compliance assurance, control effectiveness, and remediation tracking"
  source: "`legal_ecm`.`trust`.`account_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (internal, external, regulatory, compliance)"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit"
    - name: "overall_audit_result"
      expr: overall_audit_result
      comment: "Overall result of the audit (pass, pass with findings, fail)"
    - name: "auditor_type"
      expr: auditor_type
      comment: "Type of auditor (internal, external, regulatory)"
    - name: "remediation_required_flag"
      expr: remediation_required_flag
      comment: "Whether audit findings require remediation"
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation efforts"
    - name: "regulatory_notification_required_flag"
      expr: regulatory_notification_required_flag
      comment: "Whether audit findings require regulatory notification"
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction for regulatory compliance"
    - name: "audit_year"
      expr: YEAR(commencement_date)
      comment: "Year audit commenced for trend analysis"
    - name: "audit_quarter"
      expr: CONCAT('Q', QUARTER(commencement_date), '-', YEAR(commencement_date))
      comment: "Quarter audit commenced for quarterly reporting"
  measures:
    - name: "total_audit_cost"
      expr: SUM(CAST(audit_cost AS DOUBLE))
      comment: "Total cost of trust account audits - compliance program investment metric"
    - name: "audit_count"
      expr: COUNT(DISTINCT account_audit_id)
      comment: "Number of trust account audits performed for compliance activity tracking"
    - name: "average_audit_cost"
      expr: AVG(CAST(audit_cost AS DOUBLE))
      comment: "Mean audit cost for budgeting and efficiency analysis"
    - name: "total_deficiency_count"
      expr: SUM(CAST(deficiency_count AS BIGINT))
      comment: "Total number of audit deficiencies identified - control effectiveness indicator"
    - name: "total_material_deficiency_count"
      expr: SUM(CAST(material_deficiency_count AS BIGINT))
      comment: "Total material deficiencies - critical control failures requiring immediate remediation"
    - name: "audits_requiring_remediation_count"
      expr: COUNT(DISTINCT CASE WHEN remediation_required_flag = TRUE THEN account_audit_id END)
      comment: "Count of audits requiring remediation - control failure rate indicator"
    - name: "audits_with_regulatory_notification_count"
      expr: COUNT(DISTINCT CASE WHEN regulatory_notification_required_flag = TRUE THEN account_audit_id END)
      comment: "Count of audits requiring regulatory notification - regulatory risk indicator"
    - name: "failed_audit_count"
      expr: COUNT(DISTINCT CASE WHEN overall_audit_result = 'Fail' THEN account_audit_id END)
      comment: "Count of failed audits - critical compliance failure requiring escalation"
    - name: "overdue_remediation_count"
      expr: COUNT(DISTINCT CASE WHEN remediation_required_flag = TRUE AND remediation_deadline < CURRENT_DATE() AND remediation_status != 'Completed' THEN account_audit_id END)
      comment: "Count of audits with overdue remediation - compliance risk and management effectiveness indicator"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`trust_iolta_interest_remittance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IOLTA interest remittance metrics for regulatory compliance, public interest funding, and reporting accuracy"
  source: "`legal_ecm`.`trust`.`iolta_interest_remittance`"
  dimensions:
    - name: "remittance_status"
      expr: remittance_status
      comment: "Status of the IOLTA remittance"
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction for IOLTA program compliance"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of remittance payment"
    - name: "compliance_certification_flag"
      expr: compliance_certification_flag
      comment: "Whether compliance certification has been completed"
    - name: "form_1099_required_flag"
      expr: form_1099_required_flag
      comment: "Whether IRS Form 1099 is required"
    - name: "reporting_year"
      expr: reporting_year
      comment: "Year of IOLTA reporting"
    - name: "reporting_quarter"
      expr: reporting_quarter
      comment: "Quarter of IOLTA reporting"
    - name: "remittance_month"
      expr: DATE_TRUNC('MONTH', remittance_date)
      comment: "Month of remittance for time-series analysis"
  measures:
    - name: "total_gross_interest_earned"
      expr: SUM(CAST(gross_interest_earned_amount AS DOUBLE))
      comment: "Total gross interest earned on IOLTA accounts - primary public interest funding metric"
    - name: "total_net_remittance"
      expr: SUM(CAST(net_remittance_amount AS DOUBLE))
      comment: "Total net remittance to IOLTA programs - actual public interest funding delivered"
    - name: "total_bank_service_charges"
      expr: SUM(CAST(bank_service_charge_amount AS DOUBLE))
      comment: "Total bank service charges reducing IOLTA remittances - cost efficiency metric"
    - name: "remittance_count"
      expr: COUNT(DISTINCT iolta_interest_remittance_id)
      comment: "Number of IOLTA remittances for compliance activity tracking"
    - name: "average_gross_interest"
      expr: AVG(CAST(gross_interest_earned_amount AS DOUBLE))
      comment: "Mean gross interest per remittance for yield analysis"
    - name: "average_net_remittance"
      expr: AVG(CAST(net_remittance_amount AS DOUBLE))
      comment: "Mean net remittance per transaction for program funding analysis"
    - name: "pending_remittance_count"
      expr: COUNT(DISTINCT CASE WHEN remittance_status IN ('Pending', 'Approved', 'Processing') THEN iolta_interest_remittance_id END)
      comment: "Count of pending remittances - workflow and timing indicator"
    - name: "uncertified_remittance_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_certification_flag = FALSE THEN iolta_interest_remittance_id END)
      comment: "Count of uncertified remittances - compliance risk indicator"
$$;