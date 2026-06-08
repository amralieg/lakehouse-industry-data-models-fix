-- Metric views for domain: livestock | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 16:21:15

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`livestock_animal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core animal inventory KPIs for strategic herd valuation and health monitoring"
  source: "`agriculture_ecm`.`livestock`.`animal`"
  dimensions:
    - name: "species_code"
      expr: species_code
      comment: "Species code of the animal"
    - name: "breed_id"
      expr: breed_id
      comment: "Breed identifier"
    - name: "herd_id"
      expr: herd_id
      comment: "Herd identifier"
    - name: "facility_id"
      expr: facility_id
      comment: "Facility where the animal is located"
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Current lifecycle stage of the animal"
    - name: "acquisition_month"
      expr: DATE_TRUNC('month', acquisition_date)
      comment: "Month of animal acquisition"
  measures:
    - name: "total_animal_count"
      expr: COUNT(1)
      comment: "Total number of animal records"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Sum of acquisition cost for all animals"
    - name: "avg_current_weight_kg"
      expr: AVG(CAST(current_weight_kg AS DOUBLE))
      comment: "Average current weight (kg) of animals"
    - name: "count_antibiotic_free"
      expr: SUM(CASE WHEN antibiotic_free THEN 1 ELSE 0 END)
      comment: "Number of animals flagged as antibiotic free"
    - name: "count_organic_certified"
      expr: SUM(CASE WHEN organic_certified THEN 1 ELSE 0 END)
      comment: "Number of animals certified organic"
    - name: "avg_age_days"
      expr: AVG(DATEDIFF(current_timestamp, birth_date))
      comment: "Average age in days calculated from birth date"
    - name: "avg_birth_weight_kg"
      expr: AVG(CAST(birth_weight_kg AS DOUBLE))
      comment: "Average birth weight (kg)"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`livestock_animal_disposition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disposition outcomes and revenue‑related KPIs"
  source: "`agriculture_ecm`.`livestock`.`animal_disposition`"
  dimensions:
    - name: "disposition_type"
      expr: disposition_type
      comment: "Type of disposition (e.g., slaughter, sale)"
    - name: "disposition_status"
      expr: disposition_status
      comment: "Current status of the disposition"
    - name: "disposition_month"
      expr: DATE_TRUNC('month', disposition_date)
      comment: "Month of disposition"
    - name: "species_code"
      expr: species_code
      comment: "Species code of the animal"
  measures:
    - name: "total_disposition_count"
      expr: COUNT(1)
      comment: "Number of disposition events"
    - name: "total_salvage_sale_value"
      expr: SUM(CAST(salvage_sale_value AS DOUBLE))
      comment: "Total salvage sale value from dispositions"
    - name: "avg_dressing_yield_pct"
      expr: AVG(CAST(dressing_yield_pct AS DOUBLE))
      comment: "Average dressing yield percentage"
    - name: "avg_hot_carcass_weight_kg"
      expr: AVG(CAST(hot_carcass_weight_kg AS DOUBLE))
      comment: "Average hot carcass weight (kg)"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`livestock_animal_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial performance of animal sales and purchases"
  source: "`agriculture_ecm`.`livestock`.`animal_transaction`"
  dimensions:
    - name: "transaction_direction"
      expr: transaction_direction
      comment: "Direction of transaction (inbound/outbound)"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the transaction"
    - name: "transaction_month"
      expr: DATE_TRUNC('month', transaction_date)
      comment: "Month of transaction"
    - name: "species"
      expr: species
      comment: "Species involved in the transaction"
  measures:
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of animal transactions"
    - name: "total_transaction_value"
      expr: SUM(CAST(total_transaction_value AS DOUBLE))
      comment: "Total monetary value of animal transactions"
    - name: "avg_price_per_head"
      expr: AVG(CAST(price_per_head AS DOUBLE))
      comment: "Average price per head across transactions"
    - name: "avg_total_weight_lbs"
      expr: AVG(CAST(total_weight_lbs AS DOUBLE))
      comment: "Average total weight (lbs) per transaction"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`livestock_milk_production`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key dairy production quality and volume metrics"
  source: "`agriculture_ecm`.`livestock`.`milk_production_record`"
  dimensions:
    - name: "milking_month"
      expr: DATE_TRUNC('month', milking_date)
      comment: "Month of milking event"
    - name: "herd_id"
      expr: herd_id
      comment: "Herd identifier"
    - name: "animal_id"
      expr: animal_id
      comment: "Animal identifier"
  measures:
    - name: "total_milk_yield_kg"
      expr: SUM(CAST(milk_yield_kg AS DOUBLE))
      comment: "Total milk produced (kg)"
    - name: "avg_fat_pct"
      expr: AVG(CAST(fat_pct AS DOUBLE))
      comment: "Average milk fat percentage"
    - name: "avg_protein_pct"
      expr: AVG(CAST(protein_pct AS DOUBLE))
      comment: "Average milk protein percentage"
    - name: "avg_somatic_cell_count"
      expr: AVG(CAST(somatic_cell_count AS DOUBLE))
      comment: "Average somatic cell count indicating milk quality"
$$;