-- Metric views for domain: service | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 08:25:38

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`service_field_service_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for field service order execution and cost efficiency"
  source: "`manufacturing_ecm`.`service`.`field_service_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of service order"
    - name: "priority"
      expr: priority
      comment: "Priority level of the order"
    - name: "service_category"
      expr: service_category
      comment: "Service category of the order"
    - name: "city"
      expr: city
      comment: "City where service was performed"
    - name: "state"
      expr: state
      comment: "State or province of service location"
    - name: "country"
      expr: country
      comment: "Country of service location"
    - name: "order_month"
      expr: DATE_TRUNC('month', request_timestamp)
      comment: "Month of the order request"
  measures:
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost for field service orders"
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total parts cost for field service orders"
    - name: "total_gross_amount"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Total gross amount billed for field service orders"
    - name: "average_labor_hours"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labor hours per field service order"
    - name: "average_travel_distance_km"
      expr: AVG(CAST(travel_distance_km AS DOUBLE))
      comment: "Average travel distance (km) per field service order"
    - name: "orders_started_on_time"
      expr: SUM(CASE WHEN actual_start_timestamp <= scheduled_start_timestamp THEN 1 ELSE 0 END)
      comment: "Count of orders where actual start was on or before scheduled start"
    - name: "orders_ended_on_time"
      expr: SUM(CASE WHEN actual_end_timestamp <= scheduled_end_timestamp THEN 1 ELSE 0 END)
      comment: "Count of orders where actual end was on or before scheduled end"
    - name: "order_count"
      expr: COUNT(1)
      comment: "Total number of field service orders"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`service_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and renewal health metrics for service contracts"
  source: "`manufacturing_ecm`.`service`.`service_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g., fixed, variable)"
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier or level"
    - name: "contract_status"
      expr: service_contract_status
      comment: "Current status of the contract"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract amounts"
    - name: "contract_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month when the contract became effective"
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contract value across all service contracts"
    - name: "total_net_contract_value"
      expr: SUM(CAST(net_contract_value AS DOUBLE))
      comment: "Total net contract value after discounts and taxes"
    - name: "average_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average contract value"
    - name: "renewal_count"
      expr: SUM(CASE WHEN renewal_flag THEN 1 ELSE 0 END)
      comment: "Number of contracts flagged for renewal"
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of service contracts"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`service_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost and timeliness metrics for service requests"
  source: "`manufacturing_ecm`.`service`.`request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Category of the service request"
    - name: "priority"
      expr: priority
      comment: "Priority level of the request"
    - name: "service_category"
      expr: service_category
      comment: "Service category associated with the request"
    - name: "request_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month when the request was created"
  measures:
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Sum of estimated costs for service requests"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Sum of actual costs incurred for service requests"
    - name: "average_travel_distance_km"
      expr: AVG(CAST(travel_distance_km AS DOUBLE))
      comment: "Average travel distance (km) per service request"
    - name: "overdue_request_count"
      expr: SUM(CASE WHEN due_date < CURRENT_DATE() AND request_status != 'Closed' THEN 1 ELSE 0 END)
      comment: "Count of requests past due date and not closed"
    - name: "request_count"
      expr: COUNT(1)
      comment: "Total number of service requests"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`service_satisfaction_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer satisfaction and NPS metrics for service interactions"
  source: "`manufacturing_ecm`.`service`.`satisfaction_survey`"
  dimensions:
    - name: "survey_type"
      expr: survey_type
      comment: "Type of survey (e.g., post-service, periodic)"
    - name: "language"
      expr: language
      comment: "Language in which the survey was completed"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the survey record"
    - name: "survey_month"
      expr: DATE_TRUNC('month', record_audit_created)
      comment: "Month when the survey was recorded"
  measures:
    - name: "average_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall satisfaction score"
    - name: "average_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score"
    - name: "survey_count"
      expr: COUNT(1)
      comment: "Total number of satisfaction surveys collected"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`service_installed_base`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity and performance metrics for installed equipment"
  source: "`manufacturing_ecm`.`service`.`installed_base`"
  dimensions:
    - name: "product_category"
      expr: product_category
      comment: "Category of the product installed"
    - name: "country_code"
      expr: country_code
      comment: "Country where the equipment is installed"
    - name: "city"
      expr: city
      comment: "City of installation"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the equipment"
    - name: "installation_method"
      expr: installation_method
      comment: "Method used for installation"
    - name: "installation_month"
      expr: DATE_TRUNC('month', installation_date)
      comment: "Month of equipment installation"
  measures:
    - name: "installed_count"
      expr: COUNT(1)
      comment: "Number of installed base records"
    - name: "total_capacity_kw"
      expr: SUM(CAST(capacity_kw AS DOUBLE))
      comment: "Total installed capacity in kilowatts"
    - name: "average_power_rating_kw"
      expr: AVG(CAST(power_rating_kw AS DOUBLE))
      comment: "Average power rating of installed equipment"
    - name: "average_oee"
      expr: AVG(CAST(overall_equipment_effectiveness AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness (OEE)"
$$;