-- Metric views for domain: customer | Business: Grocery | Version: 1 | Generated on: 2026-05-04 18:32:13

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`customer_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key interaction KPIs for customer support and digital touchpoints"
  source: "`grocery_ecm`.`customer`.`interaction`"
  dimensions:
    - name: "interaction_date"
      expr: interaction_date
      comment: "Date of the interaction"
    - name: "channel"
      expr: channel
      comment: "Channel through which the interaction occurred (e.g., in‑store, online, phone)"
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type/category of the interaction"
    - name: "store_location_id"
      expr: store_location_id
      comment: "Identifier of the store location where interaction took place"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the interaction"
    - name: "outcome"
      expr: outcome
      comment: "Result of the interaction (e.g., resolved, pending)"
    - name: "satisfaction_rating"
      expr: satisfaction_rating
      comment: "Customer satisfaction rating for the interaction"
    - name: "nps_score"
      expr: nps_score
      comment: "Net Promoter Score captured during the interaction"
  measures:
    - name: "total_interactions"
      expr: COUNT(1)
      comment: "Total number of interaction records captured"
    - name: "unique_shoppers"
      expr: COUNT(DISTINCT shopper_id)
      comment: "Count of distinct shoppers who had interactions"
    - name: "escalated_interactions"
      expr: SUM(CASE WHEN escalated THEN 1 ELSE 0 END)
      comment: "Number of interactions that were escalated to higher support"
    - name: "first_contact_resolved"
      expr: SUM(CASE WHEN first_contact_resolution THEN 1 ELSE 0 END)
      comment: "Interactions resolved on first contact"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`customer_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic case management metrics for operational oversight"
  source: "`grocery_ecm`.`customer`.`case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the case (e.g., open, closed)"
    - name: "case_type"
      expr: case_type
      comment: "Category of the case (e.g., complaint, inquiry)"
    - name: "channel"
      expr: channel
      comment: "Channel through which the case was submitted"
    - name: "priority"
      expr: priority
      comment: "Priority assigned to the case"
    - name: "is_food_safety"
      expr: is_food_safety
      comment: "Flag indicating if the case relates to food safety"
    - name: "is_pharmacy_related"
      expr: is_pharmacy_related
      comment: "Flag indicating pharmacy‑related case"
    - name: "open_date"
      expr: open_date
      comment: "Date the case was opened"
    - name: "closed_timestamp"
      expr: closed_timestamp
      comment: "Timestamp when the case was closed"
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total number of support cases opened"
    - name: "avg_resolution_time_hours"
      expr: AVG((unix_timestamp(resolution_timestamp) - unix_timestamp(open_timestamp))/3600.0)
      comment: "Average time to resolve a case in hours"
    - name: "escalated_cases"
      expr: SUM(CASE WHEN escalated_to_agent_associate_id IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of cases escalated to an agent"
    - name: "sla_breached_cases"
      expr: SUM(CASE WHEN sla_breached THEN 1 ELSE 0 END)
      comment: "Count of cases that breached the Service Level Agreement"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`customer_cltv_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High‑value CLTV and spend metrics to guide marketing and loyalty strategy"
  source: "`grocery_ecm`.`customer`.`cltv_profile`"
  dimensions:
    - name: "cltv_tier"
      expr: cltv_tier
      comment: "Customer Lifetime Value tier classification"
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the CLTV profile"
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location associated with the shopper"
    - name: "computation_date"
      expr: computation_date
      comment: "Date when the CLTV profile was computed"
  measures:
    - name: "avg_cltv_estimate"
      expr: AVG(CAST(cltv_estimate AS DOUBLE))
      comment: "Average estimated Customer Lifetime Value"
    - name: "total_trailing_12m_spend"
      expr: SUM(CAST(trailing_12m_spend AS DOUBLE))
      comment: "Total spend across all shoppers in the trailing 12 months"
    - name: "avg_basket_size"
      expr: AVG(CAST(avg_basket_size AS DOUBLE))
      comment: "Average basket size across shoppers"
    - name: "unique_shoppers"
      expr: COUNT(DISTINCT shopper_id)
      comment: "Number of distinct shoppers represented in the CLTV profile"
    - name: "targeting_eligible_shoppers"
      expr: SUM(CASE WHEN targeting_eligible THEN 1 ELSE 0 END)
      comment: "Count of shoppers eligible for targeted marketing"
$$;