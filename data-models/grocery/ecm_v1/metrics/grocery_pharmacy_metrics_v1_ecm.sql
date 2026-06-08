-- Metric views for domain: pharmacy | Business: Grocery | Version: 1 | Generated on: 2026-05-04 18:32:13

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`pharmacy_rx_fill`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and fill activity metrics for pharmacy fills"
  source: "`grocery_ecm`.`pharmacy`.`rx_fill`"
  dimensions:
    - name: "pharmacy_location_id"
      expr: pharmacy_location_id
      comment: "Identifier of the pharmacy location where the fill occurred"
    - name: "drug_id"
      expr: drug_id
      comment: "Identifier of the dispensed drug"
    - name: "fill_month"
      expr: DATE_TRUNC('month', fill_date)
      comment: "Month of the fill date for time‑based analysis"
  measures:
    - name: "total_revenue"
      expr: SUM(CAST(total_price AS DOUBLE))
      comment: "Total revenue generated from all fills (including drug cost and fees)"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`pharmacy_rx_fill_counts`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Count and payment breakdown for pharmacy fills"
  source: "`grocery_ecm`.`pharmacy`.`rx_fill`"
  dimensions:
    - name: "pharmacy_location_id"
      expr: pharmacy_location_id
      comment: "Pharmacy location identifier"
    - name: "fill_month"
      expr: DATE_TRUNC('month', fill_date)
      comment: "Month of fill"
  measures:
    - name: "fill_count"
      expr: COUNT(1)
      comment: "Number of fill transactions"
    - name: "total_copay"
      expr: SUM(CAST(copay_amount AS DOUBLE))
      comment: "Total copay amount collected from patients"
    - name: "total_insurance_paid"
      expr: SUM(CAST(insurance_paid_amount AS DOUBLE))
      comment: "Total amount paid by insurers"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`pharmacy_prescription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prescription volume and dosage metrics"
  source: "`grocery_ecm`.`pharmacy`.`prescription`"
  dimensions:
    - name: "pharmacy_location_id"
      expr: pharmacy_location_id
      comment: "Pharmacy location where prescription was created"
    - name: "drug_id"
      expr: drug_id
      comment: "Drug prescribed"
    - name: "prescription_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of prescription creation"
  measures:
    - name: "prescription_count"
      expr: COUNT(1)
      comment: "Total number of prescriptions written"
    - name: "total_quantity_prescribed"
      expr: SUM(CAST(quantity_prescribed AS DOUBLE))
      comment: "Aggregate quantity of drug units prescribed"
    - name: "average_quantity_per_prescription"
      expr: AVG(CAST(quantity_prescribed AS DOUBLE))
      comment: "Average units prescribed per prescription"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`pharmacy_clinical_service_encounter`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Utilization and financial performance of clinical services"
  source: "`grocery_ecm`.`pharmacy`.`clinical_service_encounter`"
  dimensions:
    - name: "pharmacy_location_id"
      expr: pharmacy_location_id
      comment: "Pharmacy location where service was delivered"
    - name: "service_type"
      expr: service_type
      comment: "High‑level type of clinical service"
    - name: "service_subtype"
      expr: service_subtype
      comment: "Specific subtype of the clinical service"
    - name: "encounter_month"
      expr: DATE_TRUNC('month', encounter_date)
      comment: "Month of the encounter"
  measures:
    - name: "encounter_count"
      expr: COUNT(1)
      comment: "Number of clinical service encounters"
    - name: "total_reimbursement"
      expr: SUM(CAST(reimbursement_amount AS DOUBLE))
      comment: "Total reimbursement amount paid for clinical services"
    - name: "average_reimbursement"
      expr: AVG(CAST(reimbursement_amount AS DOUBLE))
      comment: "Average reimbursement per encounter"
    - name: "vaccine_administered_count"
      expr: SUM(CASE WHEN vaccine_administered_flag THEN 1 ELSE 0 END)
      comment: "Count of encounters where a vaccine was administered"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`pharmacy_controlled_substance_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory movement of controlled substances"
  source: "`grocery_ecm`.`pharmacy`.`controlled_substance_log`"
  dimensions:
    - name: "pharmacy_location_id"
      expr: pharmacy_location_id
      comment: "Pharmacy location handling the controlled substance"
    - name: "drug_id"
      expr: drug_id
      comment: "Controlled substance drug identifier"
    - name: "transaction_month"
      expr: DATE_TRUNC('month', transaction_date)
      comment: "Month of the inventory transaction"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of transaction (e.g., receipt, dispense, destruction)"
  measures:
    - name: "total_quantity_in"
      expr: SUM(CAST(quantity_in AS DOUBLE))
      comment: "Total quantity of controlled substances received"
    - name: "total_quantity_out"
      expr: SUM(CAST(quantity_out AS DOUBLE))
      comment: "Total quantity of controlled substances dispensed"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`pharmacy_drug_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and quantity snapshot of drug inventory"
  source: "`grocery_ecm`.`pharmacy`.`drug_inventory`"
  dimensions:
    - name: "pharmacy_location_id"
      expr: pharmacy_location_id
      comment: "Pharmacy location storing the inventory"
    - name: "drug_id"
      expr: drug_id
      comment: "Drug identifier"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier of the drug"
    - name: "expiration_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month of drug expiration"
  measures:
    - name: "total_inventory_value"
      expr: SUM(CAST(inventory_value AS DOUBLE))
      comment: "Monetary value of drug inventory on hand"
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE))
      comment: "Total units of drug inventory currently on hand"
$$;