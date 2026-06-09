-- Metric views for domain: supply | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 12:58:41

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`supply_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Batch-level inventory and quality metrics for supply chain."
  source: "`genomics_biotech_ecm`.`supply`.`batch`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant where the batch is produced."
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier of the batch."
    - name: "material_id"
      expr: material_id
      comment: "Material identifier for the batch."
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the batch."
    - name: "cold_chain_compliant_flag"
      expr: cold_chain_compliant_flag
      comment: "Indicates if the batch complies with cold chain requirements."
    - name: "manufacturing_month"
      expr: DATE_TRUNC('month', manufacturing_date)
      comment: "Manufacturing month of the batch."
    - name: "expiry_month"
      expr: DATE_TRUNC('month', expiry_date)
      comment: "Expiry month of the batch."
  measures:
    - name: "batch_count"
      expr: COUNT(1)
      comment: "Number of batch records."
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total available quantity across batches."
    - name: "total_blocked_quantity"
      expr: SUM(CAST(blocked_quantity AS DOUBLE))
      comment: "Total blocked quantity across batches."
    - name: "total_quarantine_quantity"
      expr: SUM(CAST(quarantine_quantity AS DOUBLE))
      comment: "Total quantity in quarantine across batches."
    - name: "total_recall_quantity"
      expr: SUM(CASE WHEN recall_flag THEN available_quantity ELSE 0 END)
      comment: "Total quantity subject to recall (available quantity where recall flag is true)."
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`supply_inventory_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Current inventory stock levels and valuation."
  source: "`genomics_biotech_ecm`.`supply`.`inventory_stock`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant where stock is held."
    - name: "material_id"
      expr: material_id
      comment: "Material identifier."
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier of the material."
    - name: "stock_type"
      expr: stock_type
      comment: "Classification of stock (e.g., unrestricted, blocked)."
    - name: "stock_status"
      expr: stock_status
      comment: "Current status of the stock record."
    - name: "abc_indicator"
      expr: abc_indicator
      comment: "ABC inventory classification."
    - name: "gmp_controlled_flag"
      expr: gmp_controlled_flag
      comment: "Indicates GMP controlled stock."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates if stock is hazardous."
    - name: "snapshot_month"
      expr: DATE_TRUNC('month', snapshot_timestamp)
      comment: "Month of the inventory snapshot."
  measures:
    - name: "stock_record_count"
      expr: COUNT(1)
      comment: "Number of inventory stock records."
    - name: "total_available_stock_quantity"
      expr: SUM(CAST(available_stock_quantity AS DOUBLE))
      comment: "Total available stock quantity."
    - name: "total_blocked_stock_quantity"
      expr: SUM(CAST(blocked_stock_quantity AS DOUBLE))
      comment: "Total blocked stock quantity."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity."
    - name: "total_stock_value_amount"
      expr: SUM(CAST(stock_value_amount AS DOUBLE))
      comment: "Total monetary value of stock."
    - name: "avg_valuation_price_per_unit"
      expr: AVG(CAST(valuation_price_per_unit AS DOUBLE))
      comment: "Average valuation price per unit across stock records."
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial overview of purchase orders."
  source: "`genomics_biotech_ecm`.`supply`.`purchase_order`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier associated with the purchase order."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the purchase order."
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g., standard, subcontract)."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms defined for the PO."
    - name: "po_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month when the purchase order was created."
  measures:
    - name: "po_count"
      expr: COUNT(1)
      comment: "Number of purchase orders."
    - name: "total_net_value"
      expr: SUM(CAST(net_value AS DOUBLE))
      comment: "Total net monetary value of purchase orders."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across purchase orders."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across purchase orders."
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`supply_supplier_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for supplier reliability and cost."
  source: "`genomics_biotech_ecm`.`supply`.`supplier_performance`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier being evaluated."
    - name: "performance_tier"
      expr: performance_tier
      comment: "Performance tier classification."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization responsible for the supplier."
    - name: "evaluation_year"
      expr: DATE_TRUNC('year', evaluation_period_start_date)
      comment: "Year of the performance evaluation period."
  measures:
    - name: "performance_record_count"
      expr: COUNT(1)
      comment: "Number of supplier performance evaluation records."
    - name: "avg_on_time_delivery_rate_pct"
      expr: AVG(CAST(on_time_delivery_rate_pct AS DOUBLE))
      comment: "Average on‑time delivery rate percentage."
    - name: "avg_otif_rate_pct"
      expr: AVG(CAST(otif_rate_pct AS DOUBLE))
      comment: "Average OTIF (On‑time In‑Full) rate percentage."
    - name: "avg_sla_compliance_rate_pct"
      expr: AVG(CAST(sla_compliance_rate_pct AS DOUBLE))
      comment: "Average SLA compliance rate percentage."
    - name: "avg_price_variance_pct"
      expr: AVG(CAST(price_variance_pct AS DOUBLE))
      comment: "Average price variance percentage."
    - name: "avg_lead_time_adherence_rate_pct"
      expr: AVG(CAST(lead_time_adherence_rate_pct AS DOUBLE))
      comment: "Average lead‑time adherence rate percentage."
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`supply_demand_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Forecast and planning metrics for demand planning."
  source: "`genomics_biotech_ecm`.`supply`.`demand_plan`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant for which demand is planned."
    - name: "material_id"
      expr: material_id
      comment: "Material being forecasted."
    - name: "demand_category"
      expr: demand_category
      comment: "Category of demand (e.g., internal, external)."
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the demand plan."
    - name: "planning_horizon"
      expr: planning_horizon
      comment: "Planning horizon descriptor."
    - name: "forecast_method"
      expr: forecast_method
      comment: "Method used for forecasting."
    - name: "plan_month"
      expr: DATE_TRUNC('month', planning_period_start_date)
      comment: "Month of the planning period start date."
  measures:
    - name: "demand_plan_count"
      expr: COUNT(1)
      comment: "Number of demand plan records."
    - name: "total_forecasted_quantity"
      expr: SUM(CAST(forecasted_quantity AS DOUBLE))
      comment: "Total forecasted quantity across demand plans."
    - name: "avg_forecast_accuracy_percentage"
      expr: AVG(CAST(forecast_accuracy_percentage AS DOUBLE))
      comment: "Average forecast accuracy percentage."
    - name: "total_production_plan_quantity"
      expr: SUM(CAST(production_plan_quantity AS DOUBLE))
      comment: "Total quantity planned for production."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity defined in demand plans."
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`supply_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Movement of stock across locations and plants."
  source: "`genomics_biotech_ecm`.`supply`.`stock_movement`"
  dimensions:
    - name: "movement_type_code"
      expr: movement_type_code
      comment: "Code describing the type of stock movement."
    - name: "plant_id"
      expr: plant_id
      comment: "Plant where the movement occurred."
    - name: "material_id"
      expr: material_id
      comment: "Material being moved."
    - name: "movement_indicator"
      expr: movement_indicator
      comment: "Indicator of movement direction (e.g., inbound, outbound)."
    - name: "posting_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of the posting date for the movement."
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier associated with the movement, if applicable."
  measures:
    - name: "stock_movement_count"
      expr: COUNT(1)
      comment: "Number of stock movement records."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved."
    - name: "total_amount_company_currency"
      expr: SUM(CAST(amount_in_company_currency AS DOUBLE))
      comment: "Total monetary value of movements in company currency."
$$;