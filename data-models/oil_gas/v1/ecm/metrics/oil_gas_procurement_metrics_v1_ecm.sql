-- Metric views for domain: procurement | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 05:05:28

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`procurement_afe_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key budget performance metrics for AFE budgets."
  source: "`oil_gas_ecm`.`procurement`.`afe_budget`"
  dimensions:
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class of the AFE."
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit responsible for the AFE."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget."
    - name: "approval_year"
      expr: DATE_TRUNC('year', approval_date)
      comment: "Year of AFE approval."
    - name: "afe_status"
      expr: afe_status
      comment: "Current status of the AFE."
  measures:
    - name: "total_afe_count"
      expr: COUNT(1)
      comment: "Number of AFE records."
    - name: "total_approved_budget_amount"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Sum of approved budget amounts."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Sum of actual spend."
    - name: "total_budget_variance"
      expr: SUM(CAST(budget_variance AS DOUBLE))
      comment: "Sum of budget variance amount."
    - name: "total_remaining_budget"
      expr: SUM(CAST(remaining_budget AS DOUBLE))
      comment: "Sum of remaining budget."
    - name: "avg_budget_variance_percentage"
      expr: AVG(CAST(budget_variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage."
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`procurement_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated contract financials and status."
  source: "`oil_gas_ecm`.`procurement`.`contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract."
    - name: "contract_type"
      expr: contract_type
      comment: "Type/category of the contract."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used in the contract."
    - name: "approval_year"
      expr: DATE_TRUNC('year', approval_date)
      comment: "Year the contract was approved."
    - name: "governing_law"
      expr: governing_law
      comment: "Governing law jurisdiction for the contract."
  measures:
    - name: "total_contract_count"
      expr: COUNT(1)
      comment: "Number of contracts."
    - name: "total_contract_value_usd"
      expr: SUM(CAST(value_usd AS DOUBLE))
      comment: "Sum of contract values in USD."
    - name: "total_day_rate_usd"
      expr: SUM(CAST(day_rate_usd AS DOUBLE))
      comment: "Sum of day rates in USD."
    - name: "total_mobilization_fee_usd"
      expr: SUM(CAST(mobilization_fee_usd AS DOUBLE))
      comment: "Sum of mobilization fees in USD."
    - name: "avg_contract_value_usd"
      expr: AVG(CAST(value_usd AS DOUBLE))
      comment: "Average contract value in USD."
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core purchase order financial and status metrics."
  source: "`oil_gas_ecm`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order."
    - name: "po_type"
      expr: po_type
      comment: "Type/category of the purchase order."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the purchase order."
    - name: "approval_year"
      expr: DATE_TRUNC('year', approval_date)
      comment: "Year the PO was approved."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Identifier of the vendor supplying the PO."
  measures:
    - name: "total_po_count"
      expr: COUNT(1)
      comment: "Number of purchase orders."
    - name: "total_po_value_usd"
      expr: SUM(CAST(total_po_value_usd AS DOUBLE))
      comment: "Sum of PO values in USD."
    - name: "avg_po_value_usd"
      expr: AVG(CAST(total_po_value_usd AS DOUBLE))
      comment: "Average PO value in USD."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Sum of tax amounts across POs."
    - name: "total_po_value"
      expr: SUM(CAST(total_po_value AS DOUBLE))
      comment: "Sum of PO values in transaction currency."
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`procurement_vendor_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance scores aggregated for strategic supplier management."
  source: "`oil_gas_ecm`.`procurement`.`vendor_performance`"
  dimensions:
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor being evaluated."
    - name: "contract_id"
      expr: contract_id
      comment: "Contract associated with the evaluation."
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Type of performance evaluation."
    - name: "evaluation_year"
      expr: DATE_TRUNC('year', evaluation_date)
      comment: "Year of the evaluation."
  measures:
    - name: "total_performance_records"
      expr: COUNT(1)
      comment: "Number of vendor performance evaluation records."
    - name: "avg_commercial_compliance_score"
      expr: AVG(CAST(commercial_compliance_score AS DOUBLE))
      comment: "Average commercial compliance score."
    - name: "avg_hse_score"
      expr: AVG(CAST(hse_score AS DOUBLE))
      comment: "Average HSE (Health, Safety, Environment) score."
    - name: "avg_on_time_delivery_rate_percent"
      expr: AVG(CAST(on_time_delivery_rate_percent AS DOUBLE))
      comment: "Average on‑time delivery rate percentage."
    - name: "avg_invoice_accuracy_rate_percent"
      expr: AVG(CAST(invoice_accuracy_rate_percent AS DOUBLE))
      comment: "Average invoice accuracy rate percentage."
    - name: "avg_quality_acceptance_rate_percent"
      expr: AVG(CAST(quality_acceptance_rate_percent AS DOUBLE))
      comment: "Average quality acceptance rate percentage."
    - name: "avg_responsiveness_score"
      expr: AVG(CAST(responsiveness_score AS DOUBLE))
      comment: "Average vendor responsiveness score."
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`procurement_warehouse_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory valuation and stock level KPIs for warehouse management."
  source: "`oil_gas_ecm`.`procurement`.`warehouse_inventory`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code where inventory is stored."
    - name: "warehouse_code"
      expr: warehouse_code
      comment: "Warehouse identifier."
    - name: "material_group_code"
      expr: material_group_code
      comment: "Material group classification."
    - name: "valuation_class"
      expr: valuation_class
      comment: "Valuation class of the inventory."
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of inventory (e.g., available, blocked)."
  measures:
    - name: "total_inventory_value"
      expr: SUM(CAST(total_inventory_value AS DOUBLE))
      comment: "Total monetary value of inventory on hand."
    - name: "total_stock_quantity"
      expr: SUM(CAST(stock_quantity AS DOUBLE))
      comment: "Total quantity of stock units."
    - name: "avg_unit_cost"
      expr: AVG(CAST(moving_average_price AS DOUBLE))
      comment: "Average unit cost based on moving average price."
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Sum of quantities reserved for orders."
    - name: "total_safety_stock_level"
      expr: SUM(CAST(safety_stock_level AS DOUBLE))
      comment: "Sum of safety stock levels across locations."
$$;