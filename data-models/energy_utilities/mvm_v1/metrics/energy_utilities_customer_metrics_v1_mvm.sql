-- Metric views for domain: customer | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-05 00:38:04

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`customer_account_summary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and status metrics at the customer account level."
  source: "`energy_utilities_ecm`.`customer`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the account (e.g., Active, Inactive)."
    - name: "account_type"
      expr: account_type
      comment: "Type of account (e.g., Residential, Commercial)."
    - name: "billing_cycle_code"
      expr: billing_cycle_code
      comment: "Billing cycle identifier."
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction governing the account."
    - name: "renewable_energy_plan"
      expr: renewable_energy_plan
      comment: "Flag indicating enrollment in a renewable energy plan."
    - name: "activation_month"
      expr: DATE_TRUNC('month', activation_timestamp)
      comment: "Month when the account was activated."
    - name: "control_area_id"
      expr: control_area_id
      comment: "Control area identifier for the account."
  measures:
    - name: "account_count"
      expr: COUNT(1)
      comment: "Total number of accounts."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Sum of deposit amounts across accounts."
    - name: "total_open_balance"
      expr: SUM(CAST(open_balance AS DOUBLE))
      comment: "Aggregate open balance across accounts."
    - name: "avg_open_balance"
      expr: AVG(CAST(open_balance AS DOUBLE))
      comment: "Average open balance per account."
    - name: "active_account_count"
      expr: SUM(CASE WHEN account_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of accounts with Active status."
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`customer_complaint_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Complaint handling performance and financial impact metrics."
  source: "`energy_utilities_ecm`.`customer`.`complaint`"
  dimensions:
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current status of the complaint."
    - name: "complaint_type"
      expr: complaint_type
      comment: "Category/type of complaint."
    - name: "complaint_source"
      expr: complaint_source
      comment: "Source channel where complaint originated."
    - name: "complaint_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the complaint was created."
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction associated with the complaint."
  measures:
    - name: "complaint_count"
      expr: COUNT(1)
      comment: "Total number of complaints."
    - name: "total_billing_dispute_amount"
      expr: SUM(CAST(billing_dispute_amount AS DOUBLE))
      comment: "Total amount disputed in billing across complaints."
    - name: "total_credit_issued_amount"
      expr: SUM(CAST(credit_issued_amount AS DOUBLE))
      comment: "Total credit issued to resolve complaints."
    - name: "avg_response_time_seconds"
      expr: AVG(unix_timestamp(first_response_timestamp) - unix_timestamp(filed_timestamp))
      comment: "Average time in seconds from filing to first response."
    - name: "sla_response_met_count"
      expr: SUM(CASE WHEN sla_response_met THEN 1 ELSE 0 END)
      comment: "Count of complaints where SLA response was met."
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`customer_interaction_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer interaction volume and escalation metrics."
  source: "`energy_utilities_ecm`.`customer`.`interaction`"
  dimensions:
    - name: "interaction_category"
      expr: interaction_category
      comment: "High-level category of the interaction."
    - name: "channel_type"
      expr: channel_type
      comment: "Communication channel used (e.g., Phone, Email)."
    - name: "interaction_date"
      expr: interaction_date
      comment: "Date of the interaction."
    - name: "interaction_month"
      expr: DATE_TRUNC('month', interaction_date)
      comment: "Month of the interaction."
    - name: "agent_queue"
      expr: agent_queue
      comment: "Queue handling the interaction."
  measures:
    - name: "interaction_count"
      expr: COUNT(1)
      comment: "Total number of interactions."
    - name: "escalated_interaction_count"
      expr: SUM(CASE WHEN escalation_flag THEN 1 ELSE 0 END)
      comment: "Number of interactions that were escalated."
    - name: "first_contact_resolution_count"
      expr: SUM(CASE WHEN first_contact_resolution_flag THEN 1 ELSE 0 END)
      comment: "Count of interactions resolved on first contact."
    - name: "ivr_containment_count"
      expr: SUM(CASE WHEN ivr_containment_flag THEN 1 ELSE 0 END)
      comment: "Number of interactions where IVR containment occurred."
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`customer_enrollment_capacity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enrollment program capacity and financial incentive metrics."
  source: "`energy_utilities_ecm`.`customer`.`enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the enrollment."
    - name: "der_technology_type"
      expr: der_technology_type
      comment: "DER technology type enrolled (e.g., Solar, Battery)."
    - name: "enrollment_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of enrollment."
    - name: "incentive_program_id"
      expr: incentive_program_id
      comment: "Identifier of the incentive program."
    - name: "low_income_program"
      expr: low_income_program
      comment: "Flag indicating low income program participation."
  measures:
    - name: "enrollment_count"
      expr: COUNT(1)
      comment: "Total number of enrollments."
    - name: "total_installed_capacity_kw"
      expr: SUM(CAST(installed_capacity_kw_dc AS DOUBLE))
      comment: "Sum of installed DER capacity (kW DC) across enrollments."
    - name: "total_monthly_credit_amount"
      expr: SUM(CAST(monthly_credit_amount AS DOUBLE))
      comment: "Total monthly credit amount awarded."
    - name: "average_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage offered."
    - name: "total_green_energy_percentage"
      expr: SUM(CAST(green_energy_percentage AS DOUBLE))
      comment: "Aggregate green energy percentage (used for reporting)."
$$;