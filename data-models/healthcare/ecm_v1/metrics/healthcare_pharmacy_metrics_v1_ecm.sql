-- Metric views for domain: pharmacy | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 16:32:35

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`pharmacy_dispense_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key operational metrics for medication dispensing"
  source: "`healthcare_ecm`.`pharmacy`.`dispense_event`"
  dimensions:
    - name: "dispense_month"
      expr: DATE_TRUNC('month', dispense_timestamp)
      comment: "Month of the dispense event"
    - name: "pharmacy_location_id"
      expr: pharmacy_location_id
      comment: "Identifier of the pharmacy location"
    - name: "drug_master_id"
      expr: drug_master_id
      comment: "Identifier of the dispensed drug master record"
    - name: "ndc_code"
      expr: ndc_code
      comment: "National Drug Code of the dispensed product"
    - name: "dispense_status"
      expr: dispense_status
      comment: "Current status of the dispense"
  measures:
    - name: "total_dispensed_quantity"
      expr: SUM(CAST(dispensed_quantity AS DOUBLE))
      comment: "Total quantity of medication dispensed"
    - name: "total_dispense_fee"
      expr: SUM(CAST(dispensing_fee_amount AS DOUBLE))
      comment: "Total dispensing fees collected"
    - name: "total_dispenses"
      expr: COUNT(1)
      comment: "Number of dispense events"
    - name: "counseling_completed_count"
      expr: SUM(CASE WHEN patient_counseling_completed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of dispenses where patient counseling was completed"
    - name: "substitution_made_count"
      expr: SUM(CASE WHEN substitution_made_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of dispenses where a therapeutic substitution was made"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`pharmacy_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory availability and value metrics"
  source: "`healthcare_ecm`.`pharmacy`.`inventory`"
  dimensions:
    - name: "inventory_date"
      expr: DATE_TRUNC('day', snapshot_timestamp)
      comment: "Date of the inventory snapshot"
    - name: "pharmacy_location_id"
      expr: pharmacy_location_id
      comment: "Identifier of the pharmacy location"
    - name: "drug_master_id"
      expr: drug_master_id
      comment: "Identifier of the drug master"
    - name: "ndc"
      expr: ndc
      comment: "National Drug Code"
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of the inventory record"
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total units of medication on hand"
    - name: "total_inventory_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Monetary value of inventory on hand"
    - name: "shortage_indicator_count"
      expr: SUM(CASE WHEN shortage_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of inventory records flagged as shortage"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`pharmacy_drug_recall`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics tracking drug recall events and their impact"
  source: "`healthcare_ecm`.`pharmacy`.`drug_recall`"
  dimensions:
    - name: "recall_month"
      expr: DATE_TRUNC('month', recall_initiation_date)
      comment: "Month when the recall was initiated"
    - name: "pharmacy_location_id"
      expr: pharmacy_location_id
      comment: "Pharmacy location associated with the recall"
    - name: "recall_type"
      expr: recall_type
      comment: "Classification of the recall (e.g., Class I, II, III)"
    - name: "recall_status"
      expr: recall_status
      comment: "Current status of the recall"
  measures:
    - name: "total_recalls"
      expr: COUNT(1)
      comment: "Number of drug recall events"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Aggregate financial impact of recalls"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`pharmacy_prescription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prescription volume and utilization metrics"
  source: "`healthcare_ecm`.`pharmacy`.`prescription`"
  dimensions:
    - name: "prescription_month"
      expr: DATE_TRUNC('month', prescription_date)
      comment: "Month of the prescription"
    - name: "pharmacy_location_id"
      expr: pharmacy_location_id
      comment: "Pharmacy location where prescription was written"
    - name: "ndc"
      expr: ndc
      comment: "National Drug Code of the prescribed product"
  measures:
    - name: "total_prescriptions"
      expr: COUNT(1)
      comment: "Number of prescription records"
    - name: "total_quantity_prescribed"
      expr: SUM(CAST(quantity_prescribed AS DOUBLE))
      comment: "Aggregate quantity prescribed across all prescriptions"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`pharmacy_adverse_drug_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety and compliance metrics for adverse drug events"
  source: "`healthcare_ecm`.`pharmacy`.`adverse_drug_event`"
  dimensions:
    - name: "event_month"
      expr: DATE_TRUNC('month', event_date)
      comment: "Month when the adverse event occurred"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the event"
    - name: "event_type"
      expr: event_type
      comment: "Type/category of the adverse event"
    - name: "reported_to_fda"
      expr: reported_to_fda
      comment: "Whether the event was reported to the FDA"
  measures:
    - name: "total_adverse_events"
      expr: COUNT(1)
      comment: "Total number of adverse drug events reported"
    - name: "fda_reported_count"
      expr: SUM(CASE WHEN reported_to_fda = TRUE THEN 1 ELSE 0 END)
      comment: "Count of events reported to the FDA"
    - name: "high_severity_count"
      expr: SUM(CASE WHEN severity_level = 'High' THEN 1 ELSE 0 END)
      comment: "Count of high‑severity adverse events"
$$;