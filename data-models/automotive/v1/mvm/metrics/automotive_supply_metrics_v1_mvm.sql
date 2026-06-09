-- Metric views for domain: supply | Business: Automotive | Version: 1 | Generated on: 2026-05-07 02:15:05

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`supply_supplier_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier performance KPIs tracking quality, delivery, compliance, and risk across evaluation periods"
  source: "`automotive_ecm`.`supply`.`supplier_scorecard`"
  dimensions:
    - name: "evaluation_period_start"
      expr: evaluation_period_start
      comment: "Start date of the supplier evaluation period"
    - name: "evaluation_period_end"
      expr: evaluation_period_end
      comment: "End date of the supplier evaluation period"
    - name: "evaluation_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month of supplier evaluation for time-series analysis"
    - name: "evaluation_quarter"
      expr: DATE_TRUNC('QUARTER', evaluation_date)
      comment: "Quarter of supplier evaluation for quarterly business reviews"
    - name: "performance_tier"
      expr: performance_tier
      comment: "Supplier performance tier classification (e.g., Platinum, Gold, Silver, Bronze)"
    - name: "review_status"
      expr: review_status
      comment: "Current review status of the scorecard"
    - name: "corrective_action_required"
      expr: corrective_action_flag
      comment: "Flag indicating whether corrective action is required"
    - name: "evaluator_name"
      expr: evaluator_name
      comment: "Name of the person who evaluated the supplier"
    - name: "scoring_methodology_version"
      expr: scoring_methodology_version
      comment: "Version of the scoring methodology used"
  measures:
    - name: "supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers evaluated in the period"
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall supplier performance score across all evaluations"
    - name: "avg_otd_percentage"
      expr: AVG(CAST(otd_percentage AS DOUBLE))
      comment: "Average on-time delivery percentage across suppliers"
    - name: "avg_ppm_defect_rate"
      expr: AVG(CAST(ppm_defect_rate AS DOUBLE))
      comment: "Average parts-per-million defect rate across suppliers"
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score measuring regulatory and contractual adherence"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score indicating supplier risk exposure"
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score measuring environmental and social responsibility"
    - name: "avg_responsiveness_score"
      expr: AVG(CAST(responsiveness_score AS DOUBLE))
      comment: "Average responsiveness score measuring supplier communication and issue resolution speed"
    - name: "avg_ppap_completion_rate"
      expr: AVG(CAST(ppap_on_time_completion_rate AS DOUBLE))
      comment: "Average PPAP on-time completion rate for new part approvals"
    - name: "avg_delivery_accuracy_pct"
      expr: AVG(CAST(delivery_quantity_accuracy_pct AS DOUBLE))
      comment: "Average delivery quantity accuracy percentage"
    - name: "corrective_action_rate"
      expr: AVG(CASE WHEN corrective_action_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of evaluations requiring corrective action"
    - name: "evaluation_count"
      expr: COUNT(1)
      comment: "Total number of supplier scorecard evaluations"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`supply_inbound_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound quality inspection KPIs tracking defect rates, inspection outcomes, and quality performance"
  source: "`automotive_ecm`.`supply`.`inbound_inspection`"
  dimensions:
    - name: "inspection_date"
      expr: DATE(inspection_timestamp)
      comment: "Date of the inspection event"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_timestamp)
      comment: "Month of inspection for time-series trending"
    - name: "inspection_quarter"
      expr: DATE_TRUNC('QUARTER', inspection_timestamp)
      comment: "Quarter of inspection for quarterly quality reviews"
    - name: "inspection_result"
      expr: inspection_result
      comment: "Result of the inspection (e.g., Pass, Fail, Conditional)"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection process"
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision for inspected material (e.g., Accept, Reject, Rework)"
    - name: "inspection_method"
      expr: inspection_method
      comment: "Method used for inspection (e.g., Visual, Dimensional, Functional)"
    - name: "inspection_location"
      expr: inspection_location
      comment: "Physical location where inspection was performed"
  measures:
    - name: "inspection_count"
      expr: COUNT(1)
      comment: "Total number of inbound inspections performed"
    - name: "avg_defect_rate_ppm"
      expr: AVG(CAST(defect_rate_ppm AS DOUBLE))
      comment: "Average defect rate in parts per million across all inspections"
    - name: "total_defect_rate_ppm"
      expr: SUM(CAST(defect_rate_ppm AS DOUBLE))
      comment: "Total cumulative defect rate PPM for aggregated quality analysis"
    - name: "pass_rate"
      expr: AVG(CASE WHEN inspection_result = 'Pass' THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of inspections that passed quality standards"
    - name: "rejection_rate"
      expr: AVG(CASE WHEN disposition = 'Reject' THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of inspections resulting in material rejection"
    - name: "unique_suppliers_inspected"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers with inspections in the period"
    - name: "unique_parts_inspected"
      expr: COUNT(DISTINCT inbound_part_id)
      comment: "Number of unique part types inspected"
    - name: "unique_shipments_inspected"
      expr: COUNT(DISTINCT inbound_shipment_id)
      comment: "Number of unique inbound shipments inspected"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`supply_inbound_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound logistics KPIs tracking shipment performance, freight costs, and delivery timeliness"
  source: "`automotive_ecm`.`supply`.`inbound_shipment`"
  dimensions:
    - name: "actual_arrival_date"
      expr: DATE(actual_arrival_timestamp)
      comment: "Actual date the shipment arrived"
    - name: "arrival_month"
      expr: DATE_TRUNC('MONTH', actual_arrival_timestamp)
      comment: "Month of shipment arrival for time-series analysis"
    - name: "arrival_quarter"
      expr: DATE_TRUNC('QUARTER', actual_arrival_timestamp)
      comment: "Quarter of shipment arrival for quarterly logistics reviews"
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the inbound shipment"
    - name: "mode_of_transport"
      expr: mode_of_transport
      comment: "Transportation mode used (e.g., Air, Ocean, Ground)"
    - name: "is_expedited"
      expr: is_expedited
      comment: "Flag indicating whether shipment was expedited"
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flag indicating whether shipment contains hazardous materials"
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms governing the shipment"
    - name: "temperature_controlled"
      expr: temperature_control_required
      comment: "Flag indicating whether temperature control was required"
  measures:
    - name: "shipment_count"
      expr: COUNT(1)
      comment: "Total number of inbound shipments"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across all inbound shipments"
    - name: "avg_freight_cost"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per shipment"
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight in kilograms across all shipments"
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volume in cubic meters across all shipments"
    - name: "avg_weight_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average shipment weight in kilograms"
    - name: "avg_volume_m3"
      expr: AVG(CAST(total_volume_m3 AS DOUBLE))
      comment: "Average shipment volume in cubic meters"
    - name: "expedited_shipment_rate"
      expr: AVG(CASE WHEN is_expedited = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of shipments that were expedited"
    - name: "hazardous_shipment_rate"
      expr: AVG(CASE WHEN is_hazardous = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of shipments containing hazardous materials"
    - name: "unique_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers shipping in the period"
    - name: "unique_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers used for inbound shipments"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`supply_price_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier pricing and contract KPIs tracking unit prices, volumes, quality targets, and cost reduction commitments"
  source: "`automotive_ecm`.`supply`.`price_agreement`"
  dimensions:
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date of the price agreement"
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "End date of the price agreement"
    - name: "agreement_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month when agreement became effective"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of price agreement (e.g., Fixed, Variable, Index-linked)"
    - name: "price_agreement_status"
      expr: price_agreement_status
      comment: "Current status of the price agreement"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which prices are denominated"
    - name: "contract_scope"
      expr: contract_scope
      comment: "Scope of the contract (e.g., Global, Regional, Plant-specific)"
    - name: "compliance_approval_status"
      expr: compliance_approval_status
      comment: "Compliance approval status of the agreement"
    - name: "early_termination_allowed"
      expr: early_termination_allowed
      comment: "Flag indicating whether early termination is permitted"
  measures:
    - name: "agreement_count"
      expr: COUNT(1)
      comment: "Total number of active price agreements"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across all agreements"
    - name: "total_annual_volume"
      expr: SUM(CAST(total_annual_volume AS DOUBLE))
      comment: "Total committed annual volume across all agreements"
    - name: "avg_annual_volume"
      expr: AVG(CAST(total_annual_volume AS DOUBLE))
      comment: "Average annual volume per agreement"
    - name: "avg_target_otd_percent"
      expr: AVG(CAST(target_otd_percent AS DOUBLE))
      comment: "Average target on-time delivery percentage across agreements"
    - name: "avg_actual_otd_percent"
      expr: AVG(CAST(actual_otd_percent AS DOUBLE))
      comment: "Average actual on-time delivery percentage achieved"
    - name: "avg_target_ppm"
      expr: AVG(CAST(target_ppm AS DOUBLE))
      comment: "Average target defect rate in parts per million"
    - name: "avg_actual_ppm"
      expr: AVG(CAST(actual_ppm AS DOUBLE))
      comment: "Average actual defect rate in parts per million"
    - name: "avg_annual_price_reduction"
      expr: AVG(CAST(annual_price_reduction_commitment AS DOUBLE))
      comment: "Average annual price reduction commitment percentage"
    - name: "total_price_reduction_commitment"
      expr: SUM(CAST(annual_price_reduction_commitment AS DOUBLE))
      comment: "Total annual price reduction commitment across all agreements"
    - name: "unique_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers with active price agreements"
    - name: "unique_parts"
      expr: COUNT(DISTINCT inbound_part_id)
      comment: "Number of unique parts covered by price agreements"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`supply_rfq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Request for Quotation KPIs tracking sourcing activity, response rates, and pricing targets"
  source: "`automotive_ecm`.`supply`.`rfq`"
  dimensions:
    - name: "issue_date"
      expr: DATE(issue_timestamp)
      comment: "Date the RFQ was issued to suppliers"
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_timestamp)
      comment: "Month the RFQ was issued for time-series analysis"
    - name: "issue_quarter"
      expr: DATE_TRUNC('QUARTER', issue_timestamp)
      comment: "Quarter the RFQ was issued for quarterly sourcing reviews"
    - name: "rfq_status"
      expr: rfq_status
      comment: "Current status of the RFQ (e.g., Open, Closed, Awarded)"
    - name: "rfq_type"
      expr: rfq_type
      comment: "Type of RFQ (e.g., Competitive, Sole Source, Emergency)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the RFQ"
    - name: "priority"
      expr: priority
      comment: "Priority level of the RFQ"
    - name: "tooling_required"
      expr: tooling_required
      comment: "Flag indicating whether tooling investment is required"
    - name: "regulatory_approval_required"
      expr: regulatory_approval_required
      comment: "Flag indicating whether regulatory approval is required"
    - name: "program_model_year"
      expr: program_model_year
      comment: "Model year of the vehicle program for which parts are being sourced"
  measures:
    - name: "rfq_count"
      expr: COUNT(1)
      comment: "Total number of RFQs issued"
    - name: "total_quantity_estimate"
      expr: SUM(CAST(quantity_estimate AS DOUBLE))
      comment: "Total estimated quantity across all RFQs"
    - name: "avg_quantity_estimate"
      expr: AVG(CAST(quantity_estimate AS DOUBLE))
      comment: "Average estimated quantity per RFQ"
    - name: "avg_target_price"
      expr: AVG(CAST(target_price_amount AS DOUBLE))
      comment: "Average target price across all RFQs"
    - name: "total_target_price"
      expr: SUM(CAST(target_price_amount AS DOUBLE))
      comment: "Total target price amount across all RFQs"
    - name: "avg_net_price"
      expr: AVG(CAST(net_price_amount AS DOUBLE))
      comment: "Average net price after discounts"
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per RFQ"
    - name: "tooling_required_rate"
      expr: AVG(CASE WHEN tooling_required = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of RFQs requiring tooling investment"
    - name: "regulatory_approval_rate"
      expr: AVG(CASE WHEN regulatory_approval_required = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of RFQs requiring regulatory approval"
    - name: "unique_suppliers_invited"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers invited to quote"
    - name: "unique_parts_sourced"
      expr: COUNT(DISTINCT inbound_part_id)
      comment: "Number of unique parts being sourced via RFQ"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`supply_rfq_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFQ response KPIs tracking supplier quote competitiveness, lead times, and response rates"
  source: "`automotive_ecm`.`supply`.`rfq_response`"
  dimensions:
    - name: "submission_date"
      expr: DATE(submission_timestamp)
      comment: "Date the supplier submitted the quote"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of quote submission for time-series analysis"
    - name: "submission_quarter"
      expr: DATE_TRUNC('QUARTER', submission_timestamp)
      comment: "Quarter of quote submission for quarterly sourcing reviews"
    - name: "rfq_response_status"
      expr: rfq_response_status
      comment: "Status of the RFQ response (e.g., Submitted, Under Review, Awarded, Rejected)"
    - name: "is_preferred_supplier"
      expr: is_preferred_supplier
      comment: "Flag indicating whether the supplier is a preferred supplier"
    - name: "freight_included"
      expr: freight_included
      comment: "Flag indicating whether freight cost is included in the quote"
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method proposed by the supplier"
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status of the quoted part"
    - name: "quoted_currency"
      expr: quoted_currency
      comment: "Currency in which the quote was provided"
  measures:
    - name: "response_count"
      expr: COUNT(1)
      comment: "Total number of RFQ responses received"
    - name: "avg_quoted_unit_price"
      expr: AVG(CAST(quoted_unit_price AS DOUBLE))
      comment: "Average quoted unit price across all responses"
    - name: "avg_total_price"
      expr: AVG(CAST(total_price AS DOUBLE))
      comment: "Average total price per response"
    - name: "avg_tooling_cost"
      expr: AVG(CAST(tooling_cost AS DOUBLE))
      comment: "Average tooling cost quoted by suppliers"
    - name: "total_tooling_cost"
      expr: SUM(CAST(tooling_cost AS DOUBLE))
      comment: "Total tooling cost across all responses"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days quoted by suppliers"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage offered by suppliers"
    - name: "avg_tax_amount"
      expr: AVG(CAST(tax_amount AS DOUBLE))
      comment: "Average tax amount per response"
    - name: "avg_capacity_commitment"
      expr: AVG(CAST(capacity_commitment AS DOUBLE))
      comment: "Average capacity commitment offered by suppliers"
    - name: "preferred_supplier_rate"
      expr: AVG(CASE WHEN is_preferred_supplier = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of responses from preferred suppliers"
    - name: "freight_included_rate"
      expr: AVG(CASE WHEN freight_included = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of quotes including freight cost"
    - name: "unique_suppliers_responding"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers who submitted responses"
    - name: "unique_rfqs_responded"
      expr: COUNT(DISTINCT rfq_id)
      comment: "Number of unique RFQs that received responses"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`supply_supplier_part_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PPAP and supplier part approval KPIs tracking approval rates, lead times, quality readiness, and risk"
  source: "`automotive_ecm`.`supply`.`supplier_part_approval`"
  dimensions:
    - name: "approval_date"
      expr: approval_date
      comment: "Date the part approval was granted"
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month of part approval for time-series analysis"
    - name: "approval_quarter"
      expr: DATE_TRUNC('QUARTER', approval_date)
      comment: "Quarter of part approval for quarterly quality reviews"
    - name: "submission_date"
      expr: submission_date
      comment: "Date the PPAP submission was made"
    - name: "overall_status"
      expr: overall_status
      comment: "Overall approval status (e.g., Approved, Conditional, Rejected)"
    - name: "approval_outcome"
      expr: approval_outcome
      comment: "Outcome of the approval process"
    - name: "ppap_submission_level"
      expr: ppap_submission_level
      comment: "PPAP submission level (1-5) indicating documentation depth"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the approved part"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level classification of the part"
    - name: "quality_rating"
      expr: quality_rating
      comment: "Quality rating assigned to the part"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag indicating regulatory compliance status"
  measures:
    - name: "approval_count"
      expr: COUNT(1)
      comment: "Total number of supplier part approvals processed"
    - name: "avg_approval_score"
      expr: AVG(CAST(approval_score AS DOUBLE))
      comment: "Average approval score across all submissions"
    - name: "avg_cost_usd"
      expr: AVG(CAST(cost_usd AS DOUBLE))
      comment: "Average cost in USD per approved part"
    - name: "total_cost_usd"
      expr: SUM(CAST(cost_usd AS DOUBLE))
      comment: "Total cost in USD across all approved parts"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days for approved parts"
    - name: "approval_rate"
      expr: AVG(CASE WHEN overall_status = 'Approved' THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of submissions that were fully approved"
    - name: "regulatory_compliance_rate"
      expr: AVG(CASE WHEN regulatory_compliance_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of approvals meeting regulatory compliance requirements"
    - name: "unique_suppliers_approved"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers with approved parts"
    - name: "unique_parts_approved"
      expr: COUNT(DISTINCT inbound_part_id)
      comment: "Number of unique parts approved in the period"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`supply_scheduling_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Long-term supply scheduling agreement KPIs tracking volumes, quality targets, and delivery performance"
  source: "`automotive_ecm`.`supply`.`scheduling_agreement`"
  dimensions:
    - name: "start_date"
      expr: start_date
      comment: "Start date of the scheduling agreement"
    - name: "end_date"
      expr: end_date
      comment: "End date of the scheduling agreement"
    - name: "agreement_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when the scheduling agreement started"
    - name: "approval_date"
      expr: approval_date
      comment: "Date the agreement was approved"
    - name: "scheduling_agreement_status"
      expr: scheduling_agreement_status
      comment: "Current status of the scheduling agreement"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of scheduling agreement (e.g., JIT, JIS, Kanban)"
    - name: "delivery_rhythm"
      expr: delivery_rhythm
      comment: "Delivery rhythm or frequency (e.g., Daily, Weekly, Monthly)"
    - name: "kanban_flag"
      expr: kanban_flag
      comment: "Flag indicating whether Kanban pull system is used"
    - name: "compliance_approval_status"
      expr: compliance_approval_status
      comment: "Compliance approval status of the agreement"
    - name: "early_termination_allowed"
      expr: early_termination_allowed
      comment: "Flag indicating whether early termination is permitted"
    - name: "renewal_option"
      expr: renewal_option
      comment: "Flag indicating whether renewal option exists"
  measures:
    - name: "agreement_count"
      expr: COUNT(1)
      comment: "Total number of active scheduling agreements"
    - name: "total_annual_volume"
      expr: SUM(CAST(total_annual_volume AS DOUBLE))
      comment: "Total committed annual volume across all scheduling agreements"
    - name: "avg_annual_volume"
      expr: AVG(CAST(total_annual_volume AS DOUBLE))
      comment: "Average annual volume per scheduling agreement"
    - name: "avg_target_otd_percent"
      expr: AVG(CAST(target_otd_percent AS DOUBLE))
      comment: "Average target on-time delivery percentage"
    - name: "avg_actual_otd_percent"
      expr: AVG(CAST(actual_otd_percent AS DOUBLE))
      comment: "Average actual on-time delivery percentage achieved"
    - name: "avg_target_ppm"
      expr: AVG(CAST(target_ppm AS DOUBLE))
      comment: "Average target defect rate in parts per million"
    - name: "avg_actual_ppm"
      expr: AVG(CAST(actual_ppm AS DOUBLE))
      comment: "Average actual defect rate in parts per million"
    - name: "kanban_adoption_rate"
      expr: AVG(CASE WHEN kanban_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of agreements using Kanban pull system"
    - name: "early_termination_rate"
      expr: AVG(CASE WHEN early_termination_allowed = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of agreements allowing early termination"
    - name: "renewal_option_rate"
      expr: AVG(CASE WHEN renewal_option = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of agreements with renewal options"
    - name: "unique_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers with active scheduling agreements"
    - name: "unique_parts"
      expr: COUNT(DISTINCT inbound_part_id)
      comment: "Number of unique parts covered by scheduling agreements"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`supply_commodity_group`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity group KPIs tracking cost, risk, sustainability, and strategic classification of purchased materials"
  source: "`automotive_ecm`.`supply`.`commodity_group`"
  dimensions:
    - name: "commodity_group_name"
      expr: commodity_group_name
      comment: "Name of the commodity group"
    - name: "commodity_category"
      expr: commodity_category
      comment: "Category classification of the commodity"
    - name: "commodity_group_type"
      expr: commodity_group_type
      comment: "Type of commodity group (e.g., Direct, Indirect, MRO)"
    - name: "commodity_group_status"
      expr: commodity_group_status
      comment: "Current status of the commodity group"
    - name: "strategic_classification"
      expr: strategic_classification
      comment: "Strategic classification (e.g., Strategic, Leverage, Bottleneck, Non-critical)"
    - name: "risk_factor"
      expr: risk_factor
      comment: "Risk factor classification for the commodity"
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Flag indicating whether the commodity is hazardous"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag indicating regulatory compliance requirements"
    - name: "is_global"
      expr: is_global
      comment: "Flag indicating whether the commodity is globally sourced"
    - name: "commodity_manager"
      expr: commodity_manager
      comment: "Name of the commodity manager responsible"
  measures:
    - name: "commodity_group_count"
      expr: COUNT(1)
      comment: "Total number of commodity groups"
    - name: "avg_cost_usd"
      expr: AVG(CAST(average_cost_usd AS DOUBLE))
      comment: "Average cost in USD across commodity groups"
    - name: "total_cost_usd"
      expr: SUM(CAST(average_cost_usd AS DOUBLE))
      comment: "Total cost in USD across all commodity groups"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across commodity groups"
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score measuring environmental impact"
    - name: "avg_weight_per_unit_kg"
      expr: AVG(CAST(weight_per_unit_kg AS DOUBLE))
      comment: "Average weight per unit in kilograms"
    - name: "avg_volume_per_unit_cbm"
      expr: AVG(CAST(volume_per_unit_cbm AS DOUBLE))
      comment: "Average volume per unit in cubic meters"
    - name: "avg_price_range_high"
      expr: AVG(CAST(typical_price_range_high AS DOUBLE))
      comment: "Average high end of typical price range"
    - name: "avg_price_range_low"
      expr: AVG(CAST(typical_price_range_low AS DOUBLE))
      comment: "Average low end of typical price range"
    - name: "hazardous_material_rate"
      expr: AVG(CASE WHEN hazardous_material_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of commodity groups classified as hazardous"
    - name: "regulatory_compliance_rate"
      expr: AVG(CASE WHEN regulatory_compliance_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of commodity groups requiring regulatory compliance"
    - name: "global_sourcing_rate"
      expr: AVG(CASE WHEN is_global = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of commodity groups sourced globally"
$$;