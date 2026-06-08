-- Metric views for domain: laboratory | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 16:32:35

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`laboratory_lab_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial performance of laboratory services by charge"
  source: "`healthcare_ecm`.`laboratory`.`lab_charge`"
  dimensions:
    - name: "charge_date"
      expr: DATE_TRUNC('day', charge_created_timestamp)
      comment: "Date the charge was created"
    - name: "health_plan_id"
      expr: health_plan_id
      comment: "Identifier of the health plan associated with the charge"
    - name: "payer_id"
      expr: payer_id
      comment: "Payer responsible for the charge"
    - name: "test_catalog_id"
      expr: test_catalog_id
      comment: "Test catalog reference for the charge"
    - name: "charge_entry_method"
      expr: charge_entry_method
      comment: "Method used to enter the charge"
  measures:
    - name: "charge_count"
      expr: COUNT(1)
      comment: "Number of lab charge records"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`laboratory_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and outcome metrics for laboratory test results"
  source: "`healthcare_ecm`.`laboratory`.`test_result`"
  dimensions:
    - name: "result_date"
      expr: DATE_TRUNC('day', result_datetime)
      comment: "Date the test result was recorded"
    - name: "result_status"
      expr: result_status
      comment: "Current status of the test result"
    - name: "test_catalog_id"
      expr: test_catalog_id
      comment: "Reference to the test catalog entry"
    - name: "instrument_id"
      expr: instrument_id
      comment: "Instrument that performed the test"
    - name: "demographics_id"
      expr: demographics_id
      comment: "Patient demographic identifier"
  measures:
    - name: "total_tests"
      expr: COUNT(1)
      comment: "Total number of test result records"
    - name: "abnormal_test_count"
      expr: SUM(CASE WHEN abnormal_flag = 'Y' THEN 1 ELSE 0 END)
      comment: "Count of tests flagged as abnormal"
    - name: "critical_value_count"
      expr: SUM(CASE WHEN is_critical_value = TRUE THEN 1 ELSE 0 END)
      comment: "Number of tests that triggered a critical value alert"
    - name: "average_numeric_result"
      expr: AVG(CAST(result_value_numeric AS DOUBLE))
      comment: "Average numeric result value across tests"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`laboratory_instrument`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational efficiency of laboratory instruments"
  source: "`healthcare_ecm`.`laboratory`.`instrument`"
  dimensions:
    - name: "instrument_type"
      expr: instrument_type
      comment: "Category of the instrument (e.g., analyzer, sequencer)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the instrument"
    - name: "manufacturer"
      expr: manufacturer
      comment: "Manufacturer of the instrument"
    - name: "installation_year"
      expr: DATE_TRUNC('year', installation_date)
      comment: "Year the instrument was installed"
  measures:
    - name: "instrument_count"
      expr: COUNT(1)
      comment: "Number of instruments tracked"
    - name: "total_downtime_hours"
      expr: SUM(CAST(total_downtime_hours AS DOUBLE))
      comment: "Cumulative downtime across all instruments"
    - name: "average_downtime_per_instrument"
      expr: AVG(CAST(total_downtime_hours AS DOUBLE))
      comment: "Average downtime per instrument"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`laboratory_blood_bank_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory and quality metrics for blood bank units"
  source: "`healthcare_ecm`.`laboratory`.`blood_bank_unit`"
  dimensions:
    - name: "unit_status"
      expr: unit_status
      comment: "Current status of the blood unit"
    - name: "abo_blood_group"
      expr: abo_blood_group
      comment: "ABO blood group of the unit"
    - name: "rh_type"
      expr: rh_type
      comment: "Rh factor of the unit"
    - name: "expiration_date"
      expr: expiration_date
      comment: "Expiration date of the unit"
  measures:
    - name: "total_units"
      expr: COUNT(1)
      comment: "Total blood bank units recorded"
    - name: "units_discarded"
      expr: SUM(CASE WHEN unit_status = 'Discarded' THEN 1 ELSE 0 END)
      comment: "Number of units that were discarded"
    - name: "average_storage_temperature"
      expr: AVG(CAST(storage_temperature_c AS DOUBLE))
      comment: "Average storage temperature of units"
$$;