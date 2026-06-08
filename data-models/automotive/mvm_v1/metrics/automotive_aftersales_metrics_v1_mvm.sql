-- Metric views for domain: aftersales | Business: Automotive | Version: 1 | Generated on: 2026-05-07 02:15:05

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`aftersales_repair_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core aftersales repair order KPIs tracking revenue, labor efficiency, warranty mix, and customer satisfaction across service operations"
  source: "`automotive_ecm`.`aftersales`.`aftersales_repair_order`"
  dimensions:
    - name: "repair_order_status"
      expr: aftersales_repair_order_status
      comment: "Current status of the repair order (open, in-progress, completed, closed)"
    - name: "service_type"
      expr: service_type
      comment: "Type of service performed (maintenance, repair, recall, warranty, diagnostic)"
    - name: "warranty_flag"
      expr: warranty_flag
      comment: "Indicates whether the repair order is covered under warranty"
    - name: "service_priority"
      expr: service_priority
      comment: "Priority level of the service request (standard, urgent, critical)"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the repair order (pending, paid, partial, refunded)"
    - name: "service_center_region"
      expr: service_center_region
      comment: "Geographic region of the service center performing the repair"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for financial amounts"
    - name: "is_estimate"
      expr: is_estimate
      comment: "Indicates whether the repair order is an estimate or actual work"
    - name: "customer_feedback_score"
      expr: customer_feedback_score
      comment: "Customer satisfaction score for the service experience"
    - name: "service_year"
      expr: YEAR(created_timestamp)
      comment: "Year the repair order was created"
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the repair order was created"
    - name: "service_quarter"
      expr: DATE_TRUNC('QUARTER', created_timestamp)
      comment: "Quarter the repair order was created"
  measures:
    - name: "total_repair_orders"
      expr: COUNT(1)
      comment: "Total number of repair orders processed"
    - name: "total_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total revenue from all repair orders including labor, parts, and tax"
    - name: "total_net_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net revenue from repair orders excluding tax and discounts"
    - name: "total_labor_revenue"
      expr: SUM(CAST(labor_total_cost AS DOUBLE))
      comment: "Total revenue from labor charges across all repair orders"
    - name: "total_parts_revenue"
      expr: SUM(CAST(parts_total_cost AS DOUBLE))
      comment: "Total revenue from parts sales across all repair orders"
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_total_hours AS DOUBLE))
      comment: "Total labor hours consumed across all repair orders"
    - name: "avg_labor_hours_per_ro"
      expr: AVG(CAST(labor_total_hours AS DOUBLE))
      comment: "Average labor hours per repair order, indicating service complexity"
    - name: "avg_revenue_per_ro"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average revenue per repair order, a key profitability indicator"
    - name: "avg_labor_rate"
      expr: AVG(CAST(labor_rate_per_hour AS DOUBLE))
      comment: "Average labor rate per hour charged across repair orders"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied across all repair orders"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on repair orders"
    - name: "warranty_ro_count"
      expr: SUM(CASE WHEN warranty_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of repair orders covered under warranty"
    - name: "warranty_penetration_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN warranty_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of repair orders covered under warranty, indicating warranty claim rate"
    - name: "parts_to_labor_ratio"
      expr: ROUND(SUM(CAST(parts_total_cost AS DOUBLE)) / NULLIF(SUM(CAST(labor_total_cost AS DOUBLE)), 0), 2)
      comment: "Ratio of parts revenue to labor revenue, indicating service mix and profitability structure"
    - name: "effective_labor_rate"
      expr: ROUND(SUM(CAST(labor_total_cost AS DOUBLE)) / NULLIF(SUM(CAST(labor_total_hours AS DOUBLE)), 0), 2)
      comment: "Effective labor rate realized (total labor revenue divided by total labor hours)"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT primary_aftersales_customer_party_id)
      comment: "Number of unique customers served across repair orders"
    - name: "distinct_vehicles"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of unique vehicles serviced across repair orders"
    - name: "distinct_service_centers"
      expr: COUNT(DISTINCT service_center_id)
      comment: "Number of unique service centers processing repair orders"
    - name: "distinct_technicians"
      expr: COUNT(DISTINCT technician_id)
      comment: "Number of unique technicians working on repair orders"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`aftersales_warranty_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warranty claim performance metrics tracking claim volume, approval rates, cost recovery, and adjudication efficiency"
  source: "`automotive_ecm`.`aftersales`.`aftersales_warranty_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the warranty claim (submitted, approved, rejected, pending, paid)"
    - name: "claim_category"
      expr: claim_category
      comment: "Category of the warranty claim (powertrain, electrical, body, paint, etc.)"
    - name: "warranty_type"
      expr: warranty_type
      comment: "Type of warranty coverage (basic, powertrain, extended, CPO)"
    - name: "adjudication_outcome"
      expr: adjudication_outcome
      comment: "Final outcome of the claim adjudication process"
    - name: "goodwill_flag"
      expr: goodwill_flag
      comment: "Indicates whether the claim was approved as a goodwill gesture outside warranty terms"
    - name: "claim_adjusted_flag"
      expr: claim_adjusted_flag
      comment: "Indicates whether the claim amount was adjusted during adjudication"
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Code indicating the reason for claim rejection"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for claim amounts"
    - name: "claim_submission_year"
      expr: YEAR(claim_submission_timestamp)
      comment: "Year the warranty claim was submitted"
    - name: "claim_submission_month"
      expr: DATE_TRUNC('MONTH', claim_submission_timestamp)
      comment: "Month the warranty claim was submitted"
    - name: "claim_submission_quarter"
      expr: DATE_TRUNC('QUARTER', claim_submission_timestamp)
      comment: "Quarter the warranty claim was submitted"
    - name: "repair_year"
      expr: YEAR(repair_date)
      comment: "Year the repair was performed"
  measures:
    - name: "total_warranty_claims"
      expr: COUNT(1)
      comment: "Total number of warranty claims submitted"
    - name: "total_claim_amount"
      expr: SUM(CAST(total_claim_amount AS DOUBLE))
      comment: "Total amount claimed across all warranty claims"
    - name: "total_approved_labor_cost"
      expr: SUM(CAST(approved_labor_cost AS DOUBLE))
      comment: "Total approved labor cost across all warranty claims"
    - name: "total_approved_parts_cost"
      expr: SUM(CAST(approved_parts_cost AS DOUBLE))
      comment: "Total approved parts cost across all warranty claims"
    - name: "total_adjusted_amount"
      expr: SUM(CAST(adjusted_amount AS DOUBLE))
      comment: "Total amount adjusted during claim adjudication"
    - name: "total_approved_labor_hours"
      expr: SUM(CAST(approved_labor_hours AS DOUBLE))
      comment: "Total labor hours approved across warranty claims"
    - name: "avg_claim_amount"
      expr: AVG(CAST(total_claim_amount AS DOUBLE))
      comment: "Average warranty claim amount, indicating typical claim severity"
    - name: "avg_approved_labor_hours"
      expr: AVG(CAST(approved_labor_hours AS DOUBLE))
      comment: "Average approved labor hours per warranty claim"
    - name: "avg_labor_rate"
      expr: AVG(CAST(labor_rate_per_hour AS DOUBLE))
      comment: "Average labor rate per hour for warranty claims"
    - name: "effective_approved_labor_rate"
      expr: ROUND(SUM(CAST(approved_labor_cost AS DOUBLE)) / NULLIF(SUM(CAST(approved_labor_hours AS DOUBLE)), 0), 2)
      comment: "Effective labor rate for approved warranty claims (approved labor cost divided by approved hours)"
    - name: "claim_approval_count"
      expr: SUM(CASE WHEN claim_status = 'approved' THEN 1 ELSE 0 END)
      comment: "Number of warranty claims approved"
    - name: "claim_rejection_count"
      expr: SUM(CASE WHEN claim_status = 'rejected' THEN 1 ELSE 0 END)
      comment: "Number of warranty claims rejected"
    - name: "claim_approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN claim_status = 'approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of warranty claims approved, a key quality and cost control metric"
    - name: "claim_adjustment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN claim_adjusted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims that required adjustment during adjudication"
    - name: "goodwill_claim_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN goodwill_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims approved as goodwill outside warranty terms"
    - name: "parts_to_labor_cost_ratio"
      expr: ROUND(SUM(CAST(approved_parts_cost AS DOUBLE)) / NULLIF(SUM(CAST(approved_labor_cost AS DOUBLE)), 0), 2)
      comment: "Ratio of approved parts cost to approved labor cost in warranty claims"
    - name: "distinct_vehicles"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of unique vehicles with warranty claims"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT primary_aftersales_customer_party_id)
      comment: "Number of unique customers filing warranty claims"
    - name: "distinct_service_centers"
      expr: COUNT(DISTINCT service_center_id)
      comment: "Number of unique service centers processing warranty claims"
    - name: "distinct_dealers"
      expr: COUNT(DISTINCT primary_aftersales_dealer_dealership_id)
      comment: "Number of unique dealers submitting warranty claims"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`aftersales_service_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service campaign and recall performance metrics tracking campaign execution, cost, compliance, and vehicle population coverage"
  source: "`automotive_ecm`.`aftersales`.`service_campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the service campaign (active, completed, suspended, cancelled)"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of service campaign (recall, TSB, field action, customer satisfaction)"
    - name: "campaign_priority"
      expr: campaign_priority
      comment: "Priority level of the campaign (critical, high, medium, low)"
    - name: "campaign_region"
      expr: campaign_region
      comment: "Geographic region where the campaign is active"
    - name: "safety_recall_flag"
      expr: safety_recall_flag
      comment: "Indicates whether the campaign is a safety recall"
    - name: "emissions_recall_flag"
      expr: emissions_recall_flag
      comment: "Indicates whether the campaign is an emissions-related recall"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the campaign"
    - name: "nhtsa_compliance_flag"
      expr: nhtsa_compliance_flag
      comment: "Indicates whether the campaign is NHTSA compliant"
    - name: "warranty_impact_flag"
      expr: warranty_impact_flag
      comment: "Indicates whether the campaign impacts warranty coverage"
    - name: "technical_service_bulletin_flag"
      expr: technical_service_bulletin_flag
      comment: "Indicates whether the campaign is associated with a TSB"
    - name: "campaign_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the campaign became effective"
    - name: "campaign_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the campaign became effective"
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of service campaigns"
    - name: "total_affected_vehicles"
      expr: SUM(CAST(affected_vin_population AS DOUBLE))
      comment: "Total number of vehicles affected across all campaigns"
    - name: "avg_affected_vehicles_per_campaign"
      expr: AVG(CAST(affected_vin_population AS DOUBLE))
      comment: "Average number of vehicles affected per campaign"
    - name: "total_campaign_cost_estimate"
      expr: SUM(CAST(campaign_cost_estimate AS DOUBLE))
      comment: "Total estimated cost across all service campaigns"
    - name: "total_parts_cost_estimate"
      expr: SUM(CAST(parts_cost_estimate AS DOUBLE))
      comment: "Total estimated parts cost across all campaigns"
    - name: "avg_campaign_cost"
      expr: AVG(CAST(campaign_cost_estimate AS DOUBLE))
      comment: "Average estimated cost per campaign"
    - name: "avg_cost_per_vehicle"
      expr: ROUND(SUM(CAST(campaign_cost_estimate AS DOUBLE)) / NULLIF(SUM(CAST(affected_vin_population AS DOUBLE)), 0), 2)
      comment: "Average estimated cost per affected vehicle across all campaigns"
    - name: "safety_recall_count"
      expr: SUM(CASE WHEN safety_recall_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of safety-related recalls"
    - name: "emissions_recall_count"
      expr: SUM(CASE WHEN emissions_recall_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of emissions-related recalls"
    - name: "safety_recall_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN safety_recall_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of campaigns that are safety recalls, a critical quality indicator"
    - name: "nhtsa_compliant_campaign_count"
      expr: SUM(CASE WHEN nhtsa_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of campaigns compliant with NHTSA regulations"
    - name: "nhtsa_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN nhtsa_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of campaigns compliant with NHTSA regulations"
    - name: "distinct_vehicle_programs"
      expr: COUNT(DISTINCT vehicle_program_id)
      comment: "Number of unique vehicle programs affected by campaigns"
    - name: "distinct_models"
      expr: COUNT(DISTINCT model_id)
      comment: "Number of unique vehicle models affected by campaigns"
    - name: "distinct_plants"
      expr: COUNT(DISTINCT plant_id)
      comment: "Number of unique manufacturing plants associated with campaigns"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`aftersales_service_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service center operational performance metrics tracking capacity, authorization levels, certification status, and service throughput"
  source: "`automotive_ecm`.`aftersales`.`service_center`"
  dimensions:
    - name: "service_center_type"
      expr: service_center_type
      comment: "Type of service center (dealer, independent, fleet, collision)"
    - name: "network_status"
      expr: network_status
      comment: "Status of the service center in the network (active, inactive, suspended)"
    - name: "authorization_level"
      expr: authorization_level
      comment: "Authorization level of the service center (full, limited, basic)"
    - name: "region"
      expr: region
      comment: "Geographic region of the service center"
    - name: "market"
      expr: market
      comment: "Market segment served by the service center"
    - name: "country"
      expr: country
      comment: "Country where the service center is located"
    - name: "warranty_authorized"
      expr: warranty_authorized
      comment: "Indicates whether the service center is authorized to perform warranty work"
    - name: "recall_authorized"
      expr: recall_authorized
      comment: "Indicates whether the service center is authorized to perform recall work"
    - name: "ev_certified"
      expr: ev_certified
      comment: "Indicates whether the service center is certified for electric vehicle service"
    - name: "collision_authorized"
      expr: collision_authorized
      comment: "Indicates whether the service center is authorized for collision repair"
    - name: "adas_calibration_authorized"
      expr: adas_calibration_authorized
      comment: "Indicates whether the service center is authorized for ADAS calibration"
    - name: "iso9001_certified"
      expr: iso9001_certified
      comment: "Indicates whether the service center is ISO 9001 certified"
    - name: "iatf_certified"
      expr: iatf_certified
      comment: "Indicates whether the service center is IATF certified"
    - name: "is_primary_center"
      expr: is_primary_center
      comment: "Indicates whether this is a primary service center in the network"
  measures:
    - name: "total_service_centers"
      expr: COUNT(1)
      comment: "Total number of service centers in the network"
    - name: "total_service_orders_processed"
      expr: SUM(CAST(service_orders_processed AS DOUBLE))
      comment: "Total number of service orders processed across all service centers"
    - name: "total_warranty_claims_processed"
      expr: SUM(CAST(warranty_claims_processed AS DOUBLE))
      comment: "Total number of warranty claims processed across all service centers"
    - name: "avg_service_orders_per_center"
      expr: AVG(CAST(service_orders_processed AS DOUBLE))
      comment: "Average number of service orders processed per service center"
    - name: "avg_warranty_claims_per_center"
      expr: AVG(CAST(warranty_claims_processed AS DOUBLE))
      comment: "Average number of warranty claims processed per service center"
    - name: "avg_service_time_minutes"
      expr: AVG(CAST(average_service_time_minutes AS DOUBLE))
      comment: "Average service time in minutes across service centers"
    - name: "warranty_authorized_center_count"
      expr: SUM(CASE WHEN warranty_authorized = TRUE THEN 1 ELSE 0 END)
      comment: "Number of service centers authorized for warranty work"
    - name: "recall_authorized_center_count"
      expr: SUM(CASE WHEN recall_authorized = TRUE THEN 1 ELSE 0 END)
      comment: "Number of service centers authorized for recall work"
    - name: "ev_certified_center_count"
      expr: SUM(CASE WHEN ev_certified = TRUE THEN 1 ELSE 0 END)
      comment: "Number of service centers certified for electric vehicle service"
    - name: "collision_authorized_center_count"
      expr: SUM(CASE WHEN collision_authorized = TRUE THEN 1 ELSE 0 END)
      comment: "Number of service centers authorized for collision repair"
    - name: "adas_authorized_center_count"
      expr: SUM(CASE WHEN adas_calibration_authorized = TRUE THEN 1 ELSE 0 END)
      comment: "Number of service centers authorized for ADAS calibration"
    - name: "iso9001_certified_center_count"
      expr: SUM(CASE WHEN iso9001_certified = TRUE THEN 1 ELSE 0 END)
      comment: "Number of service centers with ISO 9001 certification"
    - name: "warranty_authorization_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN warranty_authorized = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service centers authorized for warranty work"
    - name: "ev_certification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN ev_certified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service centers certified for EV service, indicating network readiness for electrification"
    - name: "distinct_dealerships"
      expr: COUNT(DISTINCT dealership_id)
      comment: "Number of unique dealerships operating service centers"
    - name: "distinct_jurisdictions"
      expr: COUNT(DISTINCT jurisdiction_id)
      comment: "Number of unique jurisdictions where service centers operate"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`aftersales_parts_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Parts order fulfillment and logistics metrics tracking order volume, value, delivery performance, and backorder rates"
  source: "`automotive_ecm`.`aftersales`.`parts_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the parts order (pending, confirmed, shipped, delivered, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of parts order (stock, emergency, warranty, campaign)"
    - name: "backorder_flag"
      expr: backorder_flag
      comment: "Indicates whether the order has backordered items"
    - name: "priority_flag"
      expr: priority_flag
      comment: "Indicates whether the order is marked as priority"
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method used for the order (ground, air, express, freight)"
    - name: "freight_terms"
      expr: freight_terms
      comment: "Freight terms for the order (prepaid, collect, FOB)"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for the order (net 30, net 60, COD)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for order amounts"
    - name: "order_year"
      expr: YEAR(order_timestamp)
      comment: "Year the parts order was placed"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_timestamp)
      comment: "Month the parts order was placed"
    - name: "order_quarter"
      expr: DATE_TRUNC('QUARTER', order_timestamp)
      comment: "Quarter the parts order was placed"
    - name: "delivery_year"
      expr: YEAR(actual_delivery_date)
      comment: "Year the parts order was delivered"
  measures:
    - name: "total_parts_orders"
      expr: COUNT(1)
      comment: "Total number of parts orders placed"
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total value of all parts orders including freight and tax"
    - name: "total_net_value"
      expr: SUM(CAST(net_total AS DOUBLE))
      comment: "Total net value of parts orders excluding freight and tax"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across all parts orders"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied to parts orders"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on parts orders"
    - name: "avg_order_value"
      expr: AVG(CAST(total_order_value AS DOUBLE))
      comment: "Average value per parts order"
    - name: "avg_freight_cost"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per parts order"
    - name: "backorder_count"
      expr: SUM(CASE WHEN backorder_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of parts orders with backordered items"
    - name: "priority_order_count"
      expr: SUM(CASE WHEN priority_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of priority parts orders"
    - name: "backorder_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN backorder_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of parts orders with backordered items, a key supply chain performance indicator"
    - name: "priority_order_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN priority_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of parts orders marked as priority"
    - name: "freight_to_order_ratio"
      expr: ROUND(100.0 * SUM(CAST(freight_cost AS DOUBLE)) / NULLIF(SUM(CAST(net_total AS DOUBLE)), 0), 2)
      comment: "Freight cost as a percentage of net order value, indicating logistics efficiency"
    - name: "discount_to_order_ratio"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_order_value AS DOUBLE)), 0), 2)
      comment: "Discount amount as a percentage of total order value"
    - name: "distinct_service_centers"
      expr: COUNT(DISTINCT service_center_id)
      comment: "Number of unique service centers placing parts orders"
    - name: "distinct_dealerships"
      expr: COUNT(DISTINCT primary_aftersales_dealership_id)
      comment: "Number of unique dealerships placing parts orders"
    - name: "distinct_repair_orders"
      expr: COUNT(DISTINCT aftersales_repair_order_id)
      comment: "Number of unique repair orders associated with parts orders"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`aftersales_goodwill_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goodwill adjustment and customer satisfaction investment metrics tracking adjustment volume, approval rates, and NPS impact"
  source: "`automotive_ecm`.`aftersales`.`goodwill_adjustment`"
  dimensions:
    - name: "goodwill_adjustment_status"
      expr: goodwill_adjustment_status
      comment: "Current status of the goodwill adjustment (pending, approved, rejected, paid)"
    - name: "goodwill_type"
      expr: goodwill_type
      comment: "Type of goodwill adjustment (service recovery, loyalty, warranty extension, compensation)"
    - name: "approval_authority_level"
      expr: approval_authority_level
      comment: "Authority level required to approve the adjustment (dealer, regional, corporate)"
    - name: "nps_impact_flag"
      expr: nps_impact_flag
      comment: "Indicates whether the adjustment is expected to impact NPS"
    - name: "warranty_flag"
      expr: warranty_flag
      comment: "Indicates whether the adjustment is related to warranty"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for adjustment amounts"
    - name: "adjustment_year"
      expr: YEAR(adjustment_timestamp)
      comment: "Year the goodwill adjustment was made"
    - name: "adjustment_month"
      expr: DATE_TRUNC('MONTH', adjustment_timestamp)
      comment: "Month the goodwill adjustment was made"
    - name: "adjustment_quarter"
      expr: DATE_TRUNC('QUARTER', adjustment_timestamp)
      comment: "Quarter the goodwill adjustment was made"
    - name: "approval_year"
      expr: YEAR(approval_timestamp)
      comment: "Year the goodwill adjustment was approved"
  measures:
    - name: "total_goodwill_adjustments"
      expr: COUNT(1)
      comment: "Total number of goodwill adjustments processed"
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total amount approved across all goodwill adjustments"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost covered by goodwill adjustments"
    - name: "total_part_cost"
      expr: SUM(CAST(part_cost AS DOUBLE))
      comment: "Total parts cost covered by goodwill adjustments"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount covered by goodwill adjustments"
    - name: "total_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total amount of all goodwill adjustments including tax"
    - name: "avg_approved_amount"
      expr: AVG(CAST(approved_amount AS DOUBLE))
      comment: "Average approved amount per goodwill adjustment"
    - name: "approved_adjustment_count"
      expr: SUM(CASE WHEN goodwill_adjustment_status = 'approved' THEN 1 ELSE 0 END)
      comment: "Number of goodwill adjustments approved"
    - name: "rejected_adjustment_count"
      expr: SUM(CASE WHEN goodwill_adjustment_status = 'rejected' THEN 1 ELSE 0 END)
      comment: "Number of goodwill adjustments rejected"
    - name: "approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN goodwill_adjustment_status = 'approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goodwill adjustments approved, indicating customer satisfaction investment discipline"
    - name: "nps_impact_adjustment_count"
      expr: SUM(CASE WHEN nps_impact_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of goodwill adjustments expected to impact NPS"
    - name: "nps_impact_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN nps_impact_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goodwill adjustments expected to impact NPS, indicating strategic customer satisfaction investment"
    - name: "parts_to_labor_ratio"
      expr: ROUND(SUM(CAST(part_cost AS DOUBLE)) / NULLIF(SUM(CAST(labor_cost AS DOUBLE)), 0), 2)
      comment: "Ratio of parts cost to labor cost in goodwill adjustments"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT primary_goodwill_customer_party_id)
      comment: "Number of unique customers receiving goodwill adjustments"
    - name: "distinct_vehicles"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of unique vehicles associated with goodwill adjustments"
    - name: "distinct_dealers"
      expr: COUNT(DISTINCT primary_goodwill_dealer_dealership_id)
      comment: "Number of unique dealers processing goodwill adjustments"
    - name: "distinct_repair_orders"
      expr: COUNT(DISTINCT aftersales_repair_order_id)
      comment: "Number of unique repair orders associated with goodwill adjustments"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`aftersales_technician`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technician workforce performance metrics tracking skill levels, certifications, efficiency ratings, and capacity utilization"
  source: "`automotive_ecm`.`aftersales`.`technician`"
  dimensions:
    - name: "technician_status"
      expr: technician_status
      comment: "Current employment status of the technician (active, inactive, on leave, terminated)"
    - name: "availability_status"
      expr: availability_status
      comment: "Current availability status of the technician (available, busy, on break, off duty)"
    - name: "skill_level"
      expr: skill_level
      comment: "Skill level of the technician (apprentice, journeyman, master, expert)"
    - name: "certification_level"
      expr: certification_level
      comment: "Certification level of the technician (basic, advanced, master, specialized)"
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification held by the technician (ASE, manufacturer, specialty)"
    - name: "specialization"
      expr: specialization
      comment: "Area of specialization for the technician (engine, transmission, electrical, ADAS, EV)"
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type worked by the technician (day, evening, night, rotating)"
    - name: "overtime_eligible"
      expr: overtime_eligible
      comment: "Indicates whether the technician is eligible for overtime"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year the technician was hired"
    - name: "certification_expiry_year"
      expr: YEAR(certification_expiry_date)
      comment: "Year the technician's certification expires"
  measures:
    - name: "total_technicians"
      expr: COUNT(1)
      comment: "Total number of technicians in the workforce"
    - name: "avg_flat_rate_efficiency"
      expr: AVG(CAST(flat_rate_efficiency_rating AS DOUBLE))
      comment: "Average flat rate efficiency rating across all technicians, a key productivity indicator"
    - name: "avg_overtime_rate_multiplier"
      expr: AVG(CAST(overtime_rate_multiplier AS DOUBLE))
      comment: "Average overtime rate multiplier across technicians"
    - name: "active_technician_count"
      expr: SUM(CASE WHEN technician_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of active technicians"
    - name: "available_technician_count"
      expr: SUM(CASE WHEN availability_status = 'available' THEN 1 ELSE 0 END)
      comment: "Number of technicians currently available for work"
    - name: "overtime_eligible_count"
      expr: SUM(CASE WHEN overtime_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Number of technicians eligible for overtime"
    - name: "master_technician_count"
      expr: SUM(CASE WHEN skill_level = 'master' THEN 1 ELSE 0 END)
      comment: "Number of master-level technicians"
    - name: "active_technician_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN technician_status = 'active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of technicians currently active"
    - name: "availability_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN availability_status = 'available' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of technicians currently available for work, indicating capacity utilization"
    - name: "master_technician_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN skill_level = 'master' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of technicians at master skill level, indicating workforce quality"
    - name: "overtime_eligible_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN overtime_eligible = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of technicians eligible for overtime"
    - name: "distinct_service_centers"
      expr: COUNT(DISTINCT service_center_id)
      comment: "Number of unique service centers employing technicians"
    - name: "distinct_specializations"
      expr: COUNT(DISTINCT specialization)
      comment: "Number of unique specializations across the technician workforce"
$$;