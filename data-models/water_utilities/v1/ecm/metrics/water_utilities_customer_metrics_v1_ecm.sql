-- Metric views for domain: customer | Business: Water Utilities | Version: 1 | Generated on: 2026-05-05 23:18:54

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`customer_account_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and status change metrics for customer accounts."
  source: "`water_utilities_ecm`.`customer`.`account_status_history`"
  dimensions:
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of the status effective date"
    - name: "new_status_code"
      expr: new_status_code
      comment: "New status code after change"
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source system identifier"
    - name: "customer_account_id"
      expr: customer_account_id
      comment: "Identifier of the customer account"
  measures:
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance_amount AS DOUBLE))
      comment: "Total outstanding balance amount across accounts"
    - name: "total_reconnection_fee"
      expr: SUM(CAST(reconnection_fee_amount AS DOUBLE))
      comment: "Total reconnection fees charged"
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts held"
    - name: "count_status_changes"
      expr: COUNT(1)
      comment: "Number of account status change records"
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`customer_account_enforcement_impact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial impact of enforcement actions on accounts."
  source: "`water_utilities_ecm`.`customer`.`account_enforcement_impact`"
  dimensions:
    - name: "impact_severity"
      expr: impact_severity
      comment: "Severity level of the enforcement impact"
    - name: "impact_resolution_month"
      expr: DATE_TRUNC('month', impact_resolution_date)
      comment: "Month when impact was resolved"
    - name: "customer_account_id"
      expr: customer_account_id
      comment: "Customer account identifier"
  measures:
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Sum of monetary impact from enforcement actions"
    - name: "count_enforcement_impacts"
      expr: COUNT(1)
      comment: "Number of enforcement impact records"
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`customer_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Complaint handling performance and financial adjustments."
  source: "`water_utilities_ecm`.`customer`.`customer_complaint`"
  dimensions:
    - name: "complaint_category"
      expr: complaint_category
      comment: "Category of the complaint"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the complaint"
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current status of the complaint"
    - name: "reported_month"
      expr: DATE_TRUNC('month', reported_timestamp)
      comment: "Month the complaint was reported"
    - name: "customer_account_id"
      expr: customer_customer_account_id
      comment: "Customer account related to the complaint"
  measures:
    - name: "total_billing_adjustment"
      expr: SUM(CAST(billing_adjustment_amount AS DOUBLE))
      comment: "Total billing adjustments issued for complaints"
    - name: "count_compensation_provided"
      expr: SUM(CASE WHEN compensation_provided_flag THEN 1 ELSE 0 END)
      comment: "Number of complaints where compensation was provided"
    - name: "average_resolution_time_days"
      expr: AVG(DATEDIFF(resolution_timestamp, reported_timestamp))
      comment: "Average time in days to resolve complaints"
    - name: "count_complaints"
      expr: COUNT(1)
      comment: "Total number of complaint records"
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`customer_deposit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deposit holdings across accounts and services."
  source: "`water_utilities_ecm`.`customer`.`deposit`"
  dimensions:
    - name: "fund_id"
      expr: fund_id
      comment: "Fund associated with the deposit"
    - name: "service_agreement_id"
      expr: service_agreement_id
      comment: "Service agreement linked to the deposit"
    - name: "customer_account_id"
      expr: customer_account_id
      comment: "Customer account owning the deposit"
  measures:
    - name: "count_deposits"
      expr: COUNT(1)
      comment: "Number of deposit records"
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`customer_parcel_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Valuation and tax metrics for parcels owned by customers."
  source: "`water_utilities_ecm`.`customer`.`parcel`"
  dimensions:
    - name: "county"
      expr: county
      comment: "County where parcel is located"
    - name: "city"
      expr: city
      comment: "City of the parcel"
    - name: "zip_code"
      expr: zip_code
      comment: "Postal code"
    - name: "owner_name"
      expr: owner_name
      comment: "Name of the parcel owner"
    - name: "status"
      expr: status
      comment: "Current status of the parcel"
  measures:
    - name: "total_tax_assessed"
      expr: SUM(CAST(tax_assessed_value AS DOUBLE))
      comment: "Total tax-assessed value of parcels"
    - name: "average_valuation_usd"
      expr: AVG(CAST(valuation_usd AS DOUBLE))
      comment: "Average valuation in USD"
    - name: "count_parcels"
      expr: COUNT(1)
      comment: "Number of parcel records"
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`customer_premise_demand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Water demand and building size metrics for premises."
  source: "`water_utilities_ecm`.`customer`.`premise`"
  dimensions:
    - name: "premise_type"
      expr: premise_type
      comment: "Type of premise"
    - name: "water_service_available_flag"
      expr: water_service_available_flag
      comment: "Flag indicating water service availability"
    - name: "pressure_zone"
      expr: pressure_zone
      comment: "Pressure zone of the premise"
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the premise record was created"
  measures:
    - name: "total_estimated_daily_demand_gallons"
      expr: SUM(CAST(estimated_daily_demand_gallons AS DOUBLE))
      comment: "Total estimated daily water demand across premises"
    - name: "average_building_square_footage"
      expr: AVG(CAST(building_square_footage AS DOUBLE))
      comment: "Average building square footage"
    - name: "count_premises"
      expr: COUNT(1)
      comment: "Number of premise records"
$$;