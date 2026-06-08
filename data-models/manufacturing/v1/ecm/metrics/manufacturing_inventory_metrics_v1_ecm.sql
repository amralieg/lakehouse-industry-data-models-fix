-- Metric views for domain: inventory | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 08:25:38

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for inventory cycle counting activities"
  source: "`manufacturing_ecm`.`inventory`.`cycle_count`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Identifier of the plant where the cycle count was performed"
    - name: "count_date"
      expr: count_date
      comment: "Date of the cycle count"
    - name: "abc_indicator"
      expr: abc_indicator
      comment: "ABC classification of the counted items"
  measures:
    - name: "total_cycle_counts"
      expr: COUNT(1)
      comment: "Total number of cycle count records captured"
    - name: "avg_accuracy_percentage"
      expr: AVG(CAST(accuracy_percentage AS DOUBLE))
      comment: "Average accuracy percentage across cycle counts"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`inventory_stock_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and aging health of inventory balances"
  source: "`manufacturing_ecm`.`inventory`.`stock_balance`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant owning the stock"
    - name: "stock_location_id"
      expr: stock_location_id
      comment: "Warehouse or location identifier"
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material identifier"
    - name: "snapshot_date"
      expr: period_end_snapshot_date
      comment: "Date of the inventory snapshot"
  measures:
    - name: "total_stock_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Total monetary value of stock on hand"
    - name: "avg_days_to_expire"
      expr: AVG(DATEDIFF(expiration_date, CURRENT_DATE()))
      comment: "Average number of days until stock expires"
    - name: "stockout_rate"
      expr: AVG(CASE WHEN quantity_on_hand <= reorder_point THEN 1 ELSE 0 END)
      comment: "Proportion of SKUs where on‑hand quantity is at or below reorder point"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`inventory_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational efficiency of replenishment ordering"
  source: "`manufacturing_ecm`.`inventory`.`replenishment_order`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant for which the order was created"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier fulfilling the order"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the replenishment order"
    - name: "order_created_date"
      expr: created_timestamp
      comment: "Timestamp when the order was created"
  measures:
    - name: "total_fulfilled_quantity"
      expr: SUM(CAST(fulfilled_quantity AS DOUBLE))
      comment: "Total quantity that was fulfilled across all replenishment orders"
    - name: "total_required_quantity"
      expr: SUM(CAST(required_quantity AS DOUBLE))
      comment: "Total quantity that was originally required"
    - name: "order_count"
      expr: COUNT(1)
      comment: "Number of replenishment orders"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`inventory_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Movement activity across inventory locations"
  source: "`manufacturing_ecm`.`inventory`.`stock_movement`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant where movement occurred"
    - name: "movement_type_code"
      expr: movement_type_code
      comment: "Code indicating type of movement (e.g., transfer, adjustment)"
    - name: "movement_reason_code"
      expr: movement_reason_code
      comment: "Reason for the movement"
    - name: "document_date"
      expr: document_date
      comment: "Date of the movement document"
  measures:
    - name: "total_issue_quantity"
      expr: SUM(CASE WHEN goods_issue_indicator THEN quantity ELSE 0 END)
      comment: "Total quantity issued (goods issue)"
    - name: "total_receipt_quantity"
      expr: SUM(CASE WHEN goods_receipt_indicator THEN quantity ELSE 0 END)
      comment: "Total quantity received (goods receipt)"
    - name: "total_movement_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Overall quantity moved regardless of direction"
    - name: "movement_count"
      expr: COUNT(1)
      comment: "Number of stock movement records"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`inventory_safety_stock_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Effectiveness of safety stock policies"
  source: "`manufacturing_ecm`.`inventory`.`inventory_safety_stock_policy`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant to which the policy applies"
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material governed by the policy"
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the material"
    - name: "policy_type"
      expr: policy_type
      comment: "Type of safety stock policy (e.g., static, dynamic)"
  measures:
    - name: "avg_safety_coverage_pct"
      expr: AVG(safety_stock_quantity / NULLIF(reorder_point, 0) * 100)
      comment: "Average safety stock coverage as a percentage of reorder point"
    - name: "avg_service_level_target_pct"
      expr: AVG(CAST(service_level_target_percent AS DOUBLE))
      comment: "Average service level target percentage across policies"
    - name: "policy_count"
      expr: COUNT(1)
      comment: "Number of active safety stock policies"
$$;