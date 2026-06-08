-- Metric views for domain: subcontractor | Business: Construction | Version: 1 | Generated on: 2026-05-07 07:27:43

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`subcontractor_back_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and status metrics for subcontractor back charges"
  source: "`construction_ecm`.`subcontractor`.`back_charge`"
  dimensions:
    - name: "back_charge_status"
      expr: back_charge_status
      comment: "Current status of the back charge"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the back charge amounts"
    - name: "approval_month"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month of back charge approval"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates if the back charge is disputed"
    - name: "subcontract_id"
      expr: subcontract_id
      comment: "Identifier of the subcontract associated with the back charge"
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Identifier of the construction project"
  measures:
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved back charge amount across all records"
    - name: "total_deduction_applied_amount"
      expr: SUM(CAST(deduction_applied_amount AS DOUBLE))
      comment: "Total amount of deductions applied to back charges"
    - name: "total_back_charge_amount"
      expr: SUM(CAST(total_claimed_amount AS DOUBLE))
      comment: "Sum of total claimed amounts for back charges"
    - name: "back_charge_count"
      expr: COUNT(1)
      comment: "Number of back charge records"
    - name: "approved_back_charge_count"
      expr: COUNT(CASE WHEN back_charge_status = 'Approved' THEN 1 END)
      comment: "Count of back charges with status Approved"
    - name: "disputed_back_charge_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Count of back charges flagged as disputed"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`subcontractor_final_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial outcomes and status of subcontractor final accounts"
  source: "`construction_ecm`.`subcontractor`.`final_account`"
  dimensions:
    - name: "final_account_status"
      expr: final_account_status
      comment: "Current status of the final account"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the final account amounts"
    - name: "approval_month"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month of final account approval"
    - name: "subcontract_id"
      expr: subcontract_id
      comment: "Identifier of the subcontract linked to the final account"
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Identifier of the construction project"
  measures:
    - name: "total_final_agreed_value"
      expr: SUM(CAST(final_agreed_value AS DOUBLE))
      comment: "Total value of final agreed amounts across final accounts"
    - name: "total_original_contract_value"
      expr: SUM(CAST(original_contract_value AS DOUBLE))
      comment: "Sum of original contract values for final accounts"
    - name: "total_retention_released"
      expr: SUM(CAST(retention_released AS DOUBLE))
      comment: "Total retention amount released"
    - name: "total_liquidated_damages_deducted"
      expr: SUM(CAST(liquidated_damages_deducted AS DOUBLE))
      comment: "Sum of liquidated damages deducted"
    - name: "final_account_count"
      expr: COUNT(1)
      comment: "Number of final account records"
    - name: "approved_final_account_count"
      expr: COUNT(CASE WHEN final_account_status = 'Approved' THEN 1 END)
      comment: "Count of final accounts with status Approved"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`subcontractor_change_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key metrics for subcontractor change orders, including financial impact and back‑charge identification"
  source: "`construction_ecm`.`subcontractor`.`subcontractor_change_order`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the change order"
    - name: "change_type"
      expr: change_type
      comment: "Type/category of the change order"
    - name: "is_back_charge"
      expr: is_back_charge
      comment: "Flag indicating if the change order is a back charge"
    - name: "is_time_and_material"
      expr: is_time_and_material
      comment: "Flag indicating if the change order is time‑and‑material"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the change order amounts"
    - name: "approval_month"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month when the change order was approved"
    - name: "subcontract_id"
      expr: subcontract_id
      comment: "Identifier of the subcontract linked to the change order"
  measures:
    - name: "total_change_amount"
      expr: SUM(CAST(change_amount AS DOUBLE))
      comment: "Total monetary value of change orders"
    - name: "total_contingency_allocation"
      expr: SUM(CAST(contingency_allocation AS DOUBLE))
      comment: "Sum of contingency allocations across change orders"
    - name: "change_order_count"
      expr: COUNT(1)
      comment: "Number of change order records"
    - name: "back_charge_change_order_count"
      expr: COUNT(CASE WHEN is_back_charge = TRUE THEN 1 END)
      comment: "Count of change orders that are back charges"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`subcontractor_eot_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational metrics for subcontractor extensions of time claims, focusing on impact and concurrency"
  source: "`construction_ecm`.`subcontractor`.`subcontractor_eot_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the EOT claim"
    - name: "delay_cause_category"
      expr: delay_cause_category
      comment: "Category of the delay cause reported in the claim"
    - name: "critical_path_impact_flag"
      expr: critical_path_impact_flag
      comment: "Indicates if the claim impacts the critical path"
    - name: "concurrent_delay_flag"
      expr: concurrent_delay_flag
      comment: "Indicates if the claim involves concurrent delays"
    - name: "submission_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month when the EOT claim was submitted"
    - name: "subcontract_id"
      expr: subcontract_id
      comment: "Identifier of the subcontract linked to the EOT claim"
  measures:
    - name: "eot_claim_count"
      expr: COUNT(1)
      comment: "Total number of EOT (Extension of Time) claims"
    - name: "critical_path_impact_claim_count"
      expr: COUNT(CASE WHEN critical_path_impact_flag = TRUE THEN 1 END)
      comment: "Count of EOT claims that impact the critical path"
    - name: "concurrent_delay_claim_count"
      expr: COUNT(CASE WHEN concurrent_delay_flag = TRUE THEN 1 END)
      comment: "Count of EOT claims with concurrent delay flag"
$$;