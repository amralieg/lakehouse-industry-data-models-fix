-- Metric views for domain: vendor | Business: Grocery | Version: 1 | Generated on: 2026-05-04 18:32:13

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`vendor_performance_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key supplier performance KPIs derived from the performance_scorecard fact table."
  source: "`grocery_ecm`.`vendor`.`performance_scorecard`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Identifier of the supplier."
    - name: "measurement_period_type"
      expr: measurement_period_type
      comment: "Period type of the scorecard (e.g., monthly, quarterly)."
    - name: "scorecard_month"
      expr: DATE_TRUNC('month', scorecard_period_start_date)
      comment: "Month of the scorecard period start."
  measures:
    - name: "total_cases_delivered"
      expr: SUM(CAST(total_cases_delivered AS DOUBLE))
      comment: "Total cases delivered by supplier."
    - name: "total_cases_ordered"
      expr: SUM(CAST(total_cases_ordered AS DOUBLE))
      comment: "Total cases ordered by supplier."
    - name: "avg_on_time_delivery_rate_pct"
      expr: AVG(CAST(on_time_delivery_rate_percentage AS DOUBLE))
      comment: "Average on‑time delivery rate percentage."
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_percentage AS DOUBLE))
      comment: "Average fill rate percentage."
    - name: "avg_composite_score"
      expr: AVG(CAST(composite_score AS DOUBLE))
      comment: "Average composite performance score."
    - name: "scorecard_record_count"
      expr: COUNT(1)
      comment: "Number of performance scorecard records."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`vendor_quality_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality incident metrics that drive risk and cost management."
  source: "`grocery_ecm`.`vendor`.`quality_incident`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Identifier of the supplier linked to the incident."
    - name: "incident_type"
      expr: incident_type
      comment: "Classification of the incident (e.g., contamination, labeling)."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the incident."
    - name: "incident_month"
      expr: DATE_TRUNC('month', incident_date)
      comment: "Month when the incident occurred."
  measures:
    - name: "incident_count"
      expr: COUNT(1)
      comment: "Number of quality incidents recorded."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Total estimated cost impact of incidents."
    - name: "high_severity_incident_count"
      expr: SUM(CASE WHEN severity_level = 'High' THEN 1 ELSE 0 END)
      comment: "Count of high‑severity incidents."
    - name: "recall_initiated_count"
      expr: SUM(CASE WHEN recall_initiated_flag THEN 1 ELSE 0 END)
      comment: "Count of incidents that triggered a recall."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`vendor_cost_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial cost and allowance KPIs for supplier contracts."
  source: "`grocery_ecm`.`vendor`.`cost_schedule`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier associated with the cost schedule."
    - name: "cost_type"
      expr: cost_type
      comment: "Type of cost (e.g., unit, case)."
    - name: "cost_status"
      expr: cost_status
      comment: "Current status of the cost schedule."
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month when the cost schedule became effective."
  measures:
    - name: "cost_schedule_count"
      expr: COUNT(1)
      comment: "Number of cost schedule records."
    - name: "total_net_cost"
      expr: SUM(CAST(net_cost AS DOUBLE))
      comment: "Total net cost across all schedules."
    - name: "avg_allowance_amount"
      expr: AVG(CAST(allowance_amount AS DOUBLE))
      comment: "Average allowance amount granted."
    - name: "total_freight_cost_per_unit"
      expr: SUM(CAST(freight_cost_per_unit AS DOUBLE))
      comment: "Aggregate freight cost per unit."
    - name: "total_allowance_amount"
      expr: SUM(CAST(allowance_amount AS DOUBLE))
      comment: "Total allowance amount across schedules."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`vendor_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic supplier portfolio metrics for governance and sustainability."
  source: "`grocery_ecm`.`vendor`.`supplier`"
  dimensions:
    - name: "vendor_tier"
      expr: vendor_tier
      comment: "Tier classification of the supplier."
    - name: "supplier_status"
      expr: supplier_status
      comment: "Current operational status of the supplier."
    - name: "headquarters_state"
      expr: headquarters_state
      comment: "State where the supplier's headquarters are located."
    - name: "minority_owned_flag"
      expr: minority_owned_flag
      comment: "Indicates if the supplier is minority owned."
    - name: "small_business_flag"
      expr: small_business_flag
      comment: "Indicates if the supplier is a small business."
  measures:
    - name: "supplier_count"
      expr: COUNT(1)
      comment: "Total number of suppliers."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across suppliers."
    - name: "avg_organic_acreage"
      expr: AVG(CAST(organic_acreage AS DOUBLE))
      comment: "Average organic acreage owned by suppliers."
    - name: "minority_owned_supplier_count"
      expr: SUM(CASE WHEN minority_owned_flag THEN 1 ELSE 0 END)
      comment: "Count of minority‑owned suppliers."
    - name: "small_business_supplier_count"
      expr: SUM(CASE WHEN small_business_flag THEN 1 ELSE 0 END)
      comment: "Count of small‑business suppliers."
$$;