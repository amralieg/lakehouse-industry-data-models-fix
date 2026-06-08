-- Metric views for domain: contract | Business: Construction | Version: 1 | Generated on: 2026-05-07 07:27:43

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`contract_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and status metrics for contract agreements."
  source: "`construction_ecm`.`contract`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the agreement."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g., fixed-price, cost-plus)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract."
    - name: "geographic_location"
      expr: geographic_location
      comment: "Geographic location of the contract."
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Fiscal year of contract start."
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month of contract start."
  measures:
    - name: "agreement_count"
      expr: COUNT(1)
      comment: "Number of agreements."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contract value."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average contract value."
    - name: "total_liquidated_damages"
      expr: SUM(CAST(liquidated_damages_amount AS DOUBLE))
      comment: "Total liquidated damages amount."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across agreements."
    - name: "active_agreement_count"
      expr: SUM(CASE WHEN effective_end_date > CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of agreements currently active."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`contract_advance_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and risk metrics for contract advance payments."
  source: "`construction_ecm`.`contract`.`advance_payment`"
  dimensions:
    - name: "advance_payment_status"
      expr: advance_payment_status
      comment: "Status of the advance payment."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the advance payment."
    - name: "guarantee_type"
      expr: guarantee_type
      comment: "Type of guarantee associated with the advance payment."
    - name: "is_interest_applicable"
      expr: is_interest_applicable
      comment: "Whether interest is applicable for the advance payment."
    - name: "issue_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month the advance payment was issued."
  measures:
    - name: "advance_payment_count"
      expr: COUNT(1)
      comment: "Number of advance payment records."
    - name: "total_amount_gross"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross amount of advance payments."
    - name: "total_amount_net"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net amount of advance payments."
    - name: "total_interest_accrued"
      expr: SUM(CAST(interest_accrued_amount AS DOUBLE))
      comment: "Total interest accrued on advance payments."
    - name: "avg_interest_rate_percent"
      expr: AVG(CAST(interest_rate_percent AS DOUBLE))
      comment: "Average interest rate percent across advance payments."
    - name: "guarantee_required_count"
      expr: SUM(CASE WHEN is_guarantee_required THEN 1 ELSE 0 END)
      comment: "Count of advance payments where a guarantee is required."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`contract_change_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Impact and financial metrics for contract change orders."
  source: "`construction_ecm`.`contract`.`contract_change_order`"
  dimensions:
    - name: "change_order_type"
      expr: change_order_type
      comment: "Type of change order (e.g., scope, schedule)."
    - name: "change_order_status"
      expr: contract_change_order_status
      comment: "Current status of the change order."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used in the change order."
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the change order became effective."
  measures:
    - name: "change_order_count"
      expr: COUNT(1)
      comment: "Number of contract change orders."
    - name: "total_cost_impact_amount"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total cost impact amount from change orders."
    - name: "avg_cost_impact_amount"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact amount per change order."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount across change orders."
    - name: "avg_net_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net amount of change orders."
    - name: "critical_change_order_count"
      expr: SUM(CASE WHEN is_critical THEN 1 ELSE 0 END)
      comment: "Count of critical change orders."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`contract_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance and financial metrics for contract milestones."
  source: "`construction_ecm`.`contract`.`contract_milestone`"
  dimensions:
    - name: "milestone_type"
      expr: milestone_type
      comment: "Classification of the milestone (e.g., design, construction)."
    - name: "milestone_status"
      expr: contract_milestone_status
      comment: "Current status of the milestone."
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the milestone is marked as critical."
    - name: "planned_month"
      expr: DATE_TRUNC('month', planned_date)
      comment: "Planned month for the milestone."
  measures:
    - name: "milestone_count"
      expr: COUNT(1)
      comment: "Number of contract milestones."
    - name: "total_milestone_value"
      expr: SUM(CAST(milestone_value AS DOUBLE))
      comment: "Total monetary value of milestones."
    - name: "avg_milestone_value"
      expr: AVG(CAST(milestone_value AS DOUBLE))
      comment: "Average milestone value."
    - name: "total_cost_variance_amount"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Total cost variance across milestones."
    - name: "avg_ld_rate_per_day"
      expr: AVG(CAST(ld_rate_per_day AS DOUBLE))
      comment: "Average liquidated damages rate per day."
    - name: "ld_triggered_count"
      expr: SUM(CASE WHEN ld_triggered THEN 1 ELSE 0 END)
      comment: "Count of milestones where liquidated damages were triggered."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`contract_payment_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and progress metrics for payment certificates."
  source: "`construction_ecm`.`contract`.`payment_certificate`"
  dimensions:
    - name: "payment_certificate_status"
      expr: payment_certificate_status
      comment: "Current status of the payment certificate."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment certificate."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment used."
    - name: "certification_month"
      expr: DATE_TRUNC('month', certification_date)
      comment: "Month the certificate was issued."
  measures:
    - name: "certificate_count"
      expr: COUNT(1)
      comment: "Number of payment certificates issued."
    - name: "total_certified_amount"
      expr: SUM(CAST(certified_amount AS DOUBLE))
      comment: "Total certified amount across certificates."
    - name: "total_net_amount_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due across certificates."
    - name: "avg_work_progress_percent"
      expr: AVG(CAST(work_progress_percent AS DOUBLE))
      comment: "Average work progress percent reported on certificates."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention amount held across certificates."
    - name: "ld_applied_count"
      expr: SUM(CASE WHEN is_ld_applied THEN 1 ELSE 0 END)
      comment: "Count of certificates where liquidated damages were applied."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`contract_retention_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retention accounting metrics for contracts."
  source: "`construction_ecm`.`contract`.`contract_retention_ledger`"
  dimensions:
    - name: "ledger_status"
      expr: contract_retention_ledger_status
      comment: "Status of the retention ledger entry."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the retention amounts."
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_timestamp)
      comment: "Month of the ledger entry effective timestamp."
  measures:
    - name: "ledger_entry_count"
      expr: COUNT(1)
      comment: "Number of retention ledger entries."
    - name: "total_cumulative_retention_balance"
      expr: SUM(CAST(cumulative_retention_balance AS DOUBLE))
      comment: "Total cumulative retention balance."
    - name: "total_release_amount"
      expr: SUM(CAST(release_amount AS DOUBLE))
      comment: "Total amount released from retention."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across ledger entries."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`contract_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and risk metrics for contract disputes."
  source: "`construction_ecm`.`contract`.`dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute."
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type/category of the dispute."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the dispute."
    - name: "claim_currency"
      expr: claim_currency
      comment: "Currency of the claim amount."
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the dispute is flagged as critical."
  measures:
    - name: "dispute_count"
      expr: COUNT(1)
      comment: "Number of disputes recorded."
    - name: "total_claim_amount"
      expr: SUM(CAST(claim_amount AS DOUBLE))
      comment: "Total claim amount across disputes."
    - name: "avg_claim_amount"
      expr: AVG(CAST(claim_amount AS DOUBLE))
      comment: "Average claim amount per dispute."
    - name: "total_net_settlement_amount"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Total net settlement amount awarded."
    - name: "critical_dispute_count"
      expr: SUM(CASE WHEN is_critical THEN 1 ELSE 0 END)
      comment: "Count of disputes marked as critical."
$$;