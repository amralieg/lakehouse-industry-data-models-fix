-- Metric views for domain: ingredient | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 21:55:54

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`ingredient_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost KPIs for raw materials and suppliers"
  source: "`food_beverage_ecm`.`ingredient`.`cost`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier identifier"
    - name: "raw_material_id"
      expr: raw_material_id
      comment: "Raw material identifier"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost"
    - name: "effective_date"
      expr: effective_date
      comment: "Date when the cost became effective"
    - name: "cost_status"
      expr: cost_status
      comment: "Status of the cost record"
    - name: "is_current_cost"
      expr: is_current_cost
      comment: "Flag indicating if this is the current cost"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where the cost is applied"
  measures:
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Sum of standard cost per unit across all cost records"
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per unit"
    - name: "total_landed_cost"
      expr: SUM(CAST(landed_cost_per_unit AS DOUBLE))
      comment: "Sum of landed cost per unit"
    - name: "avg_landed_cost"
      expr: AVG(CAST(landed_cost_per_unit AS DOUBLE))
      comment: "Average landed cost per unit"
    - name: "cost_record_count"
      expr: COUNT(1)
      comment: "Number of cost records"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`ingredient_price_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price trend and variance KPIs for ingredients"
  source: "`food_beverage_ecm`.`ingredient`.`ingredient_price_history`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier identifier"
    - name: "raw_material_id"
      expr: raw_material_id
      comment: "Raw material identifier"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the price"
    - name: "price_type"
      expr: price_type
      comment: "Type of price (e.g., spot, contract)"
    - name: "price_validity_region"
      expr: price_validity_region
      comment: "Geographic region for price validity"
    - name: "effective_date"
      expr: effective_date
      comment: "Date when the price became effective"
  measures:
    - name: "avg_spot_price"
      expr: AVG(CAST(spot_price AS DOUBLE))
      comment: "Average spot price across price history records"
    - name: "avg_contract_price"
      expr: AVG(CAST(contract_price AS DOUBLE))
      comment: "Average contract price"
    - name: "avg_price_variance_pct"
      expr: AVG(CAST(price_variance_percentage AS DOUBLE))
      comment: "Average price variance percentage"
    - name: "price_record_count"
      expr: COUNT(1)
      comment: "Number of price history records"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`ingredient_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory lot KPIs for traceability and availability"
  source: "`food_beverage_ecm`.`ingredient`.`lot`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier identifier"
    - name: "raw_material_id"
      expr: raw_material_id
      comment: "Raw material identifier"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where the lot is stored"
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the lot"
    - name: "manufacturing_date"
      expr: manufacturing_date
      comment: "Date the lot was manufactured"
    - name: "best_before_date"
      expr: best_before_date
      comment: "Best before date for the lot"
  measures:
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity received across lots"
    - name: "total_quantity_available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total quantity currently available"
    - name: "avg_quantity_received"
      expr: AVG(CAST(quantity_received AS DOUBLE))
      comment: "Average quantity received per lot"
    - name: "lot_count"
      expr: COUNT(1)
      comment: "Number of lot records"
    - name: "quarantine_lot_count"
      expr: SUM(CASE WHEN quarantine_flag THEN 1 ELSE 0 END)
      comment: "Count of lots flagged for quarantine"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`ingredient_sample_quality`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality testing KPIs for ingredient samples"
  source: "`food_beverage_ecm`.`ingredient`.`sample`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier identifier"
    - name: "raw_material_id"
      expr: raw_material_id
      comment: "Raw material identifier"
    - name: "analysis_date"
      expr: analysis_date
      comment: "Date the sample was analyzed"
    - name: "test_method"
      expr: test_method
      comment: "Method used for testing"
    - name: "sample_type"
      expr: sample_type
      comment: "Type/category of the sample"
  measures:
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score from sample testing"
    - name: "sample_count"
      expr: COUNT(1)
      comment: "Number of sample records"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`ingredient_nutritional_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nutritional KPIs for raw materials"
  source: "`food_beverage_ecm`.`ingredient`.`nutritional_profile`"
  dimensions:
    - name: "analysis_date"
      expr: analysis_date
      comment: "Date of nutritional analysis"
    - name: "version_number"
      expr: version_number
      comment: "Version of the nutritional profile"
  measures:
    - name: "avg_energy_kcal"
      expr: AVG(CAST(energy_kcal AS DOUBLE))
      comment: "Average energy (kcal) per serving"
    - name: "avg_protein_g"
      expr: AVG(CAST(protein_g AS DOUBLE))
      comment: "Average protein (g) per serving"
    - name: "avg_total_fat_g"
      expr: AVG(CAST(total_fat_g AS DOUBLE))
      comment: "Average total fat (g) per serving"
    - name: "avg_total_sugars_g"
      expr: AVG(CAST(total_sugars_g AS DOUBLE))
      comment: "Average total sugars (g) per serving"
    - name: "profile_count"
      expr: COUNT(1)
      comment: "Number of nutritional profile records"
$$;