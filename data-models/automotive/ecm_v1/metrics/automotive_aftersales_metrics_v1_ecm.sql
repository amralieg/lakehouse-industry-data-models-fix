-- Metric views for domain: aftersales | Business: Automotive | Version: 1 | Generated on: 2026-05-07 00:10:14

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`aftersales_repair_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for aftersales repair orders"
  source: "`automotive_ecm`.`aftersales`.`aftersales_repair_order`"
  dimensions:
    - name: "service_center_id"
      expr: service_center_id
      comment: "Identifier of the service center handling the repair"
    - name: "service_center_region"
      expr: service_center_region
      comment: "Geographic region of the service center"
    - name: "service_type"
      expr: service_type
      comment: "Type of service performed (e.g., maintenance, repair)"
    - name: "service_priority"
      expr: service_priority
      comment: "Priority level assigned to the service order"
    - name: "technician_id"
      expr: technician_id
      comment: "Technician who performed the repair"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center associated with the repair order"
    - name: "warranty_flag"
      expr: warranty_flag
      comment: "Indicates if the repair was covered by warranty"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the repair order was created"
  measures:
    - name: "total_repair_orders"
      expr: COUNT(1)
      comment: "Total number of repair orders recorded"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_total_cost AS DOUBLE))
      comment: "Sum of labor cost across all repair orders"
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_total_cost AS DOUBLE))
      comment: "Sum of parts cost across all repair orders"
    - name: "avg_labor_hours"
      expr: AVG(CAST(labor_total_hours AS DOUBLE))
      comment: "Average labor hours per repair order"
    - name: "warranty_repair_count"
      expr: SUM(CASE WHEN warranty_flag THEN 1 ELSE 0 END)
      comment: "Count of repair orders covered under warranty"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`aftersales_parts_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics to monitor parts ordering performance and cost"
  source: "`automotive_ecm`.`aftersales`.`aftersales_parts_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the parts order"
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order (e.g., standard, emergency)"
    - name: "priority_flag"
      expr: priority_flag
      comment: "Indicates if the order is flagged as priority"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for the order amounts"
    - name: "backorder_flag"
      expr: backorder_flag
      comment: "Indicates if the order is backordered"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the parts order was created"
  measures:
    - name: "total_parts_orders"
      expr: COUNT(1)
      comment: "Total number of parts orders"
    - name: "total_net_total"
      expr: SUM(CAST(net_total AS DOUBLE))
      comment: "Sum of net total amount for all parts orders"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Sum of tax collected on parts orders"
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount applied per parts order"
    - name: "high_priority_order_count"
      expr: SUM(CASE WHEN priority_flag THEN 1 ELSE 0 END)
      comment: "Count of parts orders marked as high priority"
    - name: "backorder_count"
      expr: SUM(CASE WHEN backorder_flag THEN 1 ELSE 0 END)
      comment: "Count of parts orders that are backordered"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`aftersales_service_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for service appointment scheduling and utilization"
  source: "`automotive_ecm`.`aftersales`.`aftersales_service_appointment`"
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Type of service requested"
    - name: "service_priority"
      expr: service_priority
      comment: "Priority level of the appointment"
    - name: "service_category"
      expr: service_category
      comment: "Broad category of service (e.g., maintenance, repair)"
    - name: "appointment_source"
      expr: appointment_source
      comment: "Source channel through which the appointment was booked"
    - name: "is_first_time_customer"
      expr: is_first_time_customer
      comment: "Indicates if the customer is new to the service center"
    - name: "is_repeat_service"
      expr: is_repeat_service
      comment: "Indicates if the service is a repeat visit"
    - name: "no_show_flag"
      expr: no_show_flag
      comment: "Flag for no‑show appointments"
    - name: "warranty_flag"
      expr: warranty_flag
      comment: "Indicates if the appointment is covered by warranty"
    - name: "appointment_date"
      expr: DATE_TRUNC('day', scheduled_timestamp)
      comment: "Date the appointment was scheduled for"
  measures:
    - name: "total_appointments"
      expr: COUNT(1)
      comment: "Total number of service appointments scheduled"
    - name: "avg_estimated_duration_minutes"
      expr: AVG(CAST(estimated_duration_minutes AS DOUBLE))
      comment: "Average estimated duration of appointments in minutes"
    - name: "total_estimated_gross_amount"
      expr: SUM(CAST(estimated_gross_amount AS DOUBLE))
      comment: "Sum of estimated gross amount for all appointments"
    - name: "total_estimated_net_amount"
      expr: SUM(CAST(estimated_net_amount AS DOUBLE))
      comment: "Sum of estimated net amount for all appointments"
    - name: "no_show_count"
      expr: SUM(CASE WHEN no_show_flag THEN 1 ELSE 0 END)
      comment: "Count of appointments where the customer did not show up"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`aftersales_dtc_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and compliance metrics derived from diagnostic trouble code events"
  source: "`automotive_ecm`.`aftersales`.`aftersales_dtc_event`"
  dimensions:
    - name: "dtc_category"
      expr: dtc_category
      comment: "High‑level category of the DTC"
    - name: "dtc_code"
      expr: dtc_code
      comment: "Specific DTC code identifier"
    - name: "dtc_status"
      expr: dtc_status
      comment: "Current status of the DTC (e.g., active, pending)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity rating of the DTC"
    - name: "service_center_id"
      expr: service_center_id
      comment: "Service center where the DTC was recorded"
    - name: "event_type"
      expr: event_type
      comment: "Type of diagnostic event"
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date the DTC event occurred"
    - name: "warranty_covered_flag"
      expr: warranty_covered_flag
      comment: "Indicates if the DTC is covered under warranty"
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of DTC events captured"
    - name: "distinct_vehicles_affected"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of unique vehicles that generated DTC events"
    - name: "cleared_event_count"
      expr: SUM(CASE WHEN cleared_flag THEN 1 ELSE 0 END)
      comment: "Count of DTC events that have been cleared"
    - name: "emission_related_event_count"
      expr: SUM(CASE WHEN emission_related_flag THEN 1 ELSE 0 END)
      comment: "Count of DTC events related to emissions"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`aftersales_warranty_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial impact and processing metrics for warranty claims"
  source: "`automotive_ecm`.`aftersales`.`aftersales_warranty_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current processing status of the claim"
    - name: "claim_category"
      expr: claim_category
      comment: "Category of the claim (e.g., parts, labor)"
    - name: "warranty_type"
      expr: warranty_type
      comment: "Type of warranty covering the claim"
    - name: "service_center_id"
      expr: service_center_id
      comment: "Service center handling the claim"
    - name: "claim_submission_date"
      expr: DATE_TRUNC('day', claim_submission_timestamp)
      comment: "Date the claim was submitted"
    - name: "claim_adjusted_flag"
      expr: claim_adjusted_flag
      comment: "Indicates if the claim amount was adjusted"
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of warranty claims filed"
    - name: "total_claim_amount"
      expr: SUM(CAST(total_claim_amount AS DOUBLE))
      comment: "Aggregate monetary value of all warranty claims"
    - name: "adjusted_amount_total"
      expr: SUM(CAST(adjusted_amount AS DOUBLE))
      comment: "Sum of adjusted amounts across claims"
    - name: "claim_adjusted_count"
      expr: SUM(CASE WHEN claim_adjusted_flag THEN 1 ELSE 0 END)
      comment: "Count of claims that were adjusted"
$$;