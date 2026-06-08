-- Metric views for domain: interconnection | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-04 21:07:37

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`interconnection_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core application pipeline KPIs that drive strategic planning and capacity forecasting"
  source: "`energy_utilities_ecm`.`interconnection`.`application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the application (e.g., Pending, Approved, Rejected)"
    - name: "application_tier"
      expr: application_tier
      comment: "Tier classification of the application (e.g., Tier 1, Tier 2)"
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of interconnection applications submitted"
    - name: "total_requested_export_capacity_kw"
      expr: SUM(CAST(export_capacity_kw AS DOUBLE))
      comment: "Sum of export capacity requested (kW) across all applications"
    - name: "total_approved_capacity_kw"
      expr: SUM(CAST(proposed_capacity_kw AS DOUBLE))
      comment: "Sum of approved interconnection capacity (kW)"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fee amount charged to applicants"
    - name: "fee_paid_count"
      expr: SUM(CASE WHEN fee_paid THEN 1 ELSE 0 END)
      comment: "Number of applications where the fee has been paid"
    - name: "avg_days_to_approval"
      expr: AVG(DATEDIFF(approval_date, application_date))
      comment: "Average number of days from application submission to approval"
    - name: "avg_days_to_completion"
      expr: AVG(DATEDIFF(completion_date, approval_date))
      comment: "Average number of days from approval to project completion"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`interconnection_fee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial performance of fee collection and outstanding balances"
  source: "`energy_utilities_ecm`.`interconnection`.`fee`"
  dimensions:
    - name: "fee_status"
      expr: fee_status
      comment: "Current processing status of the fee (e.g., Paid, Pending, Waived)"
    - name: "fee_type"
      expr: fee_type
      comment: "Categorization of the fee (e.g., Application, Inspection, Upgrade)"
  measures:
    - name: "total_fee_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total monetary amount of fees recorded"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Sum of outstanding balances across all fee records"
    - name: "average_fee_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average fee amount per record"
    - name: "fee_record_count"
      expr: COUNT(1)
      comment: "Count of fee records"
    - name: "paid_fee_record_count"
      expr: SUM(CASE WHEN fee_status = 'Paid' THEN 1 ELSE 0 END)
      comment: "Number of fee records with status marked as Paid"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`interconnection_cost_responsibility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key cost allocation and responsibility metrics for budgeting and regulatory reporting"
  source: "`energy_utilities_ecm`.`interconnection`.`cost_responsibility`"
  dimensions:
    - name: "cost_category"
      expr: cost_category
      comment: "Category of cost (e.g., Capital, O&M, Study)"
  measures:
    - name: "total_estimated_cost"
      expr: SUM(CAST(total_estimated_cost AS DOUBLE))
      comment: "Aggregate of all estimated costs for interconnection projects"
    - name: "total_final_settled_cost"
      expr: SUM(CAST(final_settled_cost AS DOUBLE))
      comment: "Sum of final settled costs after adjustments"
    - name: "total_applicant_cost_share"
      expr: SUM(CAST(applicant_cost_share_amount AS DOUBLE))
      comment: "Total cost share amount borne by applicants"
    - name: "total_utility_cost_share"
      expr: SUM(CAST(utility_cost_share_amount AS DOUBLE))
      comment: "Total cost share amount borne by the utility"
    - name: "total_sgip_incentive"
      expr: SUM(CAST(sgip_incentive_amount AS DOUBLE))
      comment: "Aggregate SGIP incentive amounts allocated"
    - name: "cost_responsibility_record_count"
      expr: COUNT(1)
      comment: "Number of cost responsibility records"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`interconnection_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic capacity and cost metrics from interconnection agreements"
  source: "`energy_utilities_ecm`.`interconnection`.`interconnection_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the agreement (e.g., Active, Terminated)"
  measures:
    - name: "total_max_export_capacity_kw"
      expr: SUM(CAST(maximum_export_capacity_kw AS DOUBLE))
      comment: "Total maximum export capacity authorized across agreements (kW)"
    - name: "total_max_import_capacity_kw"
      expr: SUM(CAST(maximum_import_capacity_kw AS DOUBLE))
      comment: "Total maximum import capacity authorized across agreements (kW)"
    - name: "average_network_upgrade_cost_usd"
      expr: AVG(CAST(network_upgrade_cost_usd AS DOUBLE))
      comment: "Average network upgrade cost per agreement (USD)"
    - name: "agreement_count"
      expr: COUNT(1)
      comment: "Number of interconnection agreements"
$$;