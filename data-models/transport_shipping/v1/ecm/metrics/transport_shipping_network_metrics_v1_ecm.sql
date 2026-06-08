-- Metric views for domain: network | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 19:31:38

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`network_capacity_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity allocation utilization and efficiency metrics for monitoring how effectively blocked space and contracted capacity is being consumed across the network."
  source: "`transport_shipping_ecm`.`network`.`capacity_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the capacity allocation (e.g., active, expired, cancelled)"
    - name: "allocation_period_type"
      expr: allocation_period_type
      comment: "Period granularity of the allocation (weekly, monthly, quarterly)"
    - name: "capacity_source_type"
      expr: capacity_source_type
      comment: "Source of capacity (e.g., blocked space agreement, spot market, contract)"
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment allocated (container type, trailer type)"
    - name: "origin_location_code"
      expr: origin_location_code
      comment: "Origin location code for the capacity allocation"
    - name: "destination_location_code"
      expr: destination_location_code
      comment: "Destination location code for the capacity allocation"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to this allocation"
    - name: "allocation_start_month"
      expr: DATE_TRUNC('month', allocation_start_date)
      comment: "Month when the allocation period starts"
  measures:
    - name: "total_allocated_volume_cbm"
      expr: SUM(CAST(allocated_capacity_volume_cbm AS DOUBLE))
      comment: "Total allocated capacity in cubic meters across all allocations"
    - name: "total_utilized_volume_cbm"
      expr: SUM(CAST(utilized_capacity_volume_cbm AS DOUBLE))
      comment: "Total utilized capacity in cubic meters"
    - name: "total_allocated_weight_kg"
      expr: SUM(CAST(allocated_capacity_weight_kg AS DOUBLE))
      comment: "Total allocated capacity in kilograms"
    - name: "total_utilized_weight_kg"
      expr: SUM(CAST(utilized_capacity_weight_kg AS DOUBLE))
      comment: "Total utilized capacity in kilograms"
    - name: "total_allocated_teu"
      expr: SUM(CAST(allocated_capacity_teu AS DOUBLE))
      comment: "Total allocated capacity in TEU (Twenty-foot Equivalent Units)"
    - name: "total_utilized_teu"
      expr: SUM(CAST(utilized_capacity_teu AS DOUBLE))
      comment: "Total utilized capacity in TEU"
    - name: "avg_capacity_fill_rate_pct"
      expr: AVG(CAST(capacity_fill_rate_percent AS DOUBLE))
      comment: "Average capacity fill rate percentage indicating utilization efficiency"
    - name: "total_minimum_commitment_amount"
      expr: SUM(CAST(minimum_commitment_amount AS DOUBLE))
      comment: "Total minimum commitment amounts across allocations"
    - name: "allocation_count"
      expr: COUNT(1)
      comment: "Total number of capacity allocation records"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`network_carrier_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier network health and performance metrics for evaluating carrier reliability, compliance, and operational readiness."
  source: "`transport_shipping_ecm`.`network`.`carrier`"
  dimensions:
    - name: "carrier_type"
      expr: carrier_type
      comment: "Type of carrier (ocean, air, road, rail, multimodal)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the carrier"
    - name: "country_of_registration"
      expr: country_of_registration
      comment: "Country where the carrier is registered"
    - name: "service_scope"
      expr: service_scope
      comment: "Geographic service scope of the carrier (global, regional, domestic)"
    - name: "preferred_carrier_flag"
      expr: CAST(preferred_carrier_flag AS STRING)
      comment: "Whether the carrier is flagged as preferred"
    - name: "onboarding_stage"
      expr: onboarding_stage
      comment: "Current onboarding stage of the carrier"
    - name: "credit_rating"
      expr: credit_rating
      comment: "Financial credit rating of the carrier"
    - name: "transport_modes"
      expr: transport_modes
      comment: "Transport modes supported by the carrier"
  measures:
    - name: "total_carriers"
      expr: COUNT(1)
      comment: "Total number of carriers in the network"
    - name: "avg_otd_percentage"
      expr: AVG(CAST(otd_percentage AS DOUBLE))
      comment: "Average on-time delivery percentage across carriers — key reliability indicator"
    - name: "avg_performance_rating"
      expr: AVG(CAST(performance_rating AS DOUBLE))
      comment: "Average carrier performance rating score"
    - name: "total_insurance_coverage"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage amount across all carriers"
    - name: "distinct_carrier_count"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Distinct count of carriers for network diversity analysis"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`network_partner_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner performance evaluation metrics tracking OTD, damage rates, documentation accuracy, and composite scores for partner governance and tier management."
  source: "`transport_shipping_ecm`.`network`.`partner_performance`"
  dimensions:
    - name: "review_outcome"
      expr: review_outcome
      comment: "Outcome of the performance review (e.g., satisfactory, needs improvement, critical)"
    - name: "evaluation_frequency"
      expr: evaluation_frequency
      comment: "How often the partner is evaluated (monthly, quarterly, annually)"
    - name: "service_mode"
      expr: service_mode
      comment: "Service mode being evaluated (air, ocean, road, rail)"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the performance evaluation"
    - name: "trend_direction"
      expr: trend_direction
      comment: "Direction of performance trend (improving, stable, declining)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the performance evaluation"
    - name: "corrective_action_required"
      expr: CAST(corrective_action_required_flag AS STRING)
      comment: "Whether corrective action is required based on evaluation"
    - name: "evaluation_period_month"
      expr: DATE_TRUNC('month', evaluation_period_start_date)
      comment: "Month of the evaluation period start"
  measures:
    - name: "avg_composite_score"
      expr: AVG(CAST(composite_score AS DOUBLE))
      comment: "Average composite performance score across all evaluated partners"
    - name: "avg_otd_rate_actual_pct"
      expr: AVG(CAST(otd_rate_actual_pct AS DOUBLE))
      comment: "Average actual on-time delivery rate across partners"
    - name: "avg_damage_rate_actual_pct"
      expr: AVG(CAST(damage_rate_actual_pct AS DOUBLE))
      comment: "Average actual damage rate — lower is better, key quality indicator"
    - name: "avg_claims_rate_actual_pct"
      expr: AVG(CAST(claims_rate_actual_pct AS DOUBLE))
      comment: "Average actual claims rate — indicator of service quality issues"
    - name: "avg_documentation_accuracy_pct"
      expr: AVG(CAST(documentation_accuracy_actual_pct AS DOUBLE))
      comment: "Average documentation accuracy rate — critical for customs and compliance"
    - name: "avg_transit_time_compliance_pct"
      expr: AVG(CAST(transit_time_compliance_actual_pct AS DOUBLE))
      comment: "Average transit time compliance rate against SLA targets"
    - name: "avg_capacity_fulfillment_pct"
      expr: AVG(CAST(capacity_fulfillment_actual_pct AS DOUBLE))
      comment: "Average capacity fulfillment rate against committed targets"
    - name: "total_shipments_evaluated"
      expr: SUM(CAST(total_shipments_evaluated AS BIGINT))
      comment: "Total number of shipments evaluated across all performance reviews"
    - name: "total_volume_teu"
      expr: SUM(CAST(total_volume_teu AS DOUBLE))
      comment: "Total volume in TEU evaluated across performance reviews"
    - name: "evaluation_count"
      expr: COUNT(1)
      comment: "Total number of performance evaluations conducted"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`network_partner_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner financial settlement metrics tracking gross/net amounts, deductions, disputes, and payment efficiency for interline and partner revenue management."
  source: "`transport_shipping_ecm`.`network`.`partner_settlement`"
  dimensions:
    - name: "settlement_status"
      expr: settlement_status
      comment: "Current status of the settlement (pending, approved, paid, disputed)"
    - name: "settlement_type"
      expr: settlement_type
      comment: "Type of settlement (interline, commission, service fee)"
    - name: "settlement_method"
      expr: settlement_method
      comment: "Payment method used for settlement (wire, ACH, check)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the settlement"
    - name: "settlement_currency_code"
      expr: settlement_currency_code
      comment: "Currency in which the settlement is denominated"
    - name: "dispute_flag"
      expr: CAST(dispute_flag AS STRING)
      comment: "Whether the settlement is under dispute"
    - name: "settlement_period_month"
      expr: DATE_TRUNC('month', settlement_period_start_date)
      comment: "Month of the settlement period start"
  measures:
    - name: "total_gross_settlement_amount"
      expr: SUM(CAST(gross_settlement_amount AS DOUBLE))
      comment: "Total gross settlement amounts before deductions"
    - name: "total_net_settlement_amount"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Total net settlement amounts after deductions and withholdings"
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total deductions applied across settlements"
    - name: "total_tax_withholding_amount"
      expr: SUM(CAST(tax_withholding_amount AS DOUBLE))
      comment: "Total tax withholding amounts across settlements"
    - name: "total_volume_cbm"
      expr: SUM(CAST(total_volume_cbm AS DOUBLE))
      comment: "Total volume in CBM covered by settlements"
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight in KG covered by settlements"
    - name: "avg_net_settlement_amount"
      expr: AVG(CAST(net_settlement_amount AS DOUBLE))
      comment: "Average net settlement amount per settlement record"
    - name: "settlement_count"
      expr: COUNT(1)
      comment: "Total number of settlement records"
    - name: "distinct_partner_count"
      expr: COUNT(DISTINCT partner_id)
      comment: "Number of distinct partners with settlements in the period"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`network_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network disruption and event metrics for monitoring operational resilience, severity distribution, financial impact, and response effectiveness."
  source: "`transport_shipping_ecm`.`network`.`network_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of network event (disruption, delay, capacity constraint, force majeure)"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the event (open, mitigated, resolved, closed)"
    - name: "severity"
      expr: severity
      comment: "Severity level of the event (critical, high, medium, low)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the event"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Category of root cause (weather, labor, equipment, regulatory)"
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month when the event occurred"
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of network events recorded"
    - name: "total_financial_impact_usd"
      expr: SUM(CAST(financial_impact_estimated_usd AS DOUBLE))
      comment: "Total estimated financial impact in USD from network events"
    - name: "avg_financial_impact_usd"
      expr: AVG(CAST(financial_impact_estimated_usd AS DOUBLE))
      comment: "Average estimated financial impact per event in USD"
    - name: "total_estimated_delay_hours"
      expr: SUM(CAST(estimated_delay_hours AS DOUBLE))
      comment: "Total estimated delay hours caused by network events"
    - name: "avg_estimated_delay_hours"
      expr: AVG(CAST(estimated_delay_hours AS DOUBLE))
      comment: "Average estimated delay hours per event"
    - name: "total_capacity_loss_teu"
      expr: SUM(CAST(estimated_capacity_loss_teu AS DOUBLE))
      comment: "Total estimated capacity loss in TEU from disruptions"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`network_blocked_space_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Blocked space agreement metrics for monitoring guaranteed capacity commitments, utilization thresholds, and commercial terms with carriers."
  source: "`transport_shipping_ecm`.`network`.`blocked_space_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of blocked space agreement"
    - name: "blocked_space_agreement_status"
      expr: blocked_space_agreement_status
      comment: "Current status of the agreement (active, expired, terminated)"
    - name: "origin_region"
      expr: origin_region
      comment: "Origin region covered by the agreement"
    - name: "destination_region"
      expr: destination_region
      comment: "Destination region covered by the agreement"
    - name: "allocation_frequency"
      expr: allocation_frequency
      comment: "Frequency of capacity allocation (weekly, monthly)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the agreement"
    - name: "exclusivity_flag"
      expr: CAST(exclusivity_flag AS STRING)
      comment: "Whether the agreement is exclusive"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month when the agreement became effective"
  measures:
    - name: "total_guaranteed_capacity_teu"
      expr: SUM(CAST(guaranteed_capacity_teu AS DOUBLE))
      comment: "Total guaranteed capacity in TEU across all agreements"
    - name: "total_guaranteed_capacity_cbm"
      expr: SUM(CAST(guaranteed_capacity_cbm AS DOUBLE))
      comment: "Total guaranteed capacity in cubic meters"
    - name: "total_guaranteed_capacity_kg"
      expr: SUM(CAST(guaranteed_capacity_kg AS DOUBLE))
      comment: "Total guaranteed capacity in kilograms"
    - name: "avg_minimum_utilization_pct"
      expr: AVG(CAST(minimum_utilization_commitment_percent AS DOUBLE))
      comment: "Average minimum utilization commitment percentage across agreements"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amounts for underutilization across agreements"
    - name: "avg_base_rate_per_unit"
      expr: AVG(CAST(base_rate_per_unit AS DOUBLE))
      comment: "Average base rate per unit across agreements"
    - name: "agreement_count"
      expr: COUNT(1)
      comment: "Total number of blocked space agreements"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`network_partner_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner incident metrics for tracking service failures, SLA breaches, financial impact, and corrective action effectiveness across the partner network."
  source: "`transport_shipping_ecm`.`network`.`partner_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of partner incident (service failure, SLA breach, compliance violation)"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident (open, investigating, resolved, closed)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the incident"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Category of root cause for the incident"
    - name: "sla_breach_flag"
      expr: CAST(sla_breach_flag AS STRING)
      comment: "Whether the incident resulted in an SLA breach"
    - name: "penalty_applied_flag"
      expr: CAST(penalty_applied_flag AS STRING)
      comment: "Whether a financial penalty was applied"
    - name: "customer_impact_flag"
      expr: CAST(customer_impact_flag AS STRING)
      comment: "Whether the incident had direct customer impact"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level reached for the incident"
    - name: "incident_month"
      expr: DATE_TRUNC('month', incident_date)
      comment: "Month when the incident occurred"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of partner incidents recorded"
    - name: "total_financial_impact_amount"
      expr: SUM(CAST(financial_impact_estimate_amount AS DOUBLE))
      comment: "Total estimated financial impact from partner incidents"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amounts applied to partners for incidents"
    - name: "avg_financial_impact_amount"
      expr: AVG(CAST(financial_impact_estimate_amount AS DOUBLE))
      comment: "Average financial impact per incident"
    - name: "distinct_partners_with_incidents"
      expr: COUNT(DISTINCT partner_id)
      comment: "Number of distinct partners with incidents — concentration risk indicator"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`network_interline_prorate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interline prorate revenue metrics for monitoring revenue sharing, settlement accuracy, and dispute rates across interline partnerships."
  source: "`transport_shipping_ecm`.`network`.`interline_prorate`"
  dimensions:
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for the interline segment"
    - name: "service_type"
      expr: service_type
      comment: "Service type for the prorate calculation"
    - name: "prorate_basis"
      expr: prorate_basis
      comment: "Basis used for prorate calculation (weight, distance, revenue)"
    - name: "dispute_flag"
      expr: CAST(dispute_flag AS STRING)
      comment: "Whether the prorate is under dispute"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the prorate amounts"
    - name: "calculation_month"
      expr: DATE_TRUNC('month', calculation_date)
      comment: "Month when the prorate was calculated"
  measures:
    - name: "total_prorate_amount"
      expr: SUM(CAST(prorate_amount AS DOUBLE))
      comment: "Total prorate amounts across all interline segments"
    - name: "total_revenue_amount"
      expr: SUM(CAST(total_revenue_amount AS DOUBLE))
      comment: "Total revenue amount subject to proration"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amounts applied to prorates"
    - name: "avg_prorate_percentage"
      expr: AVG(CAST(prorate_percentage AS DOUBLE))
      comment: "Average prorate percentage across interline segments"
    - name: "avg_prorate_factor"
      expr: AVG(CAST(prorate_factor AS DOUBLE))
      comment: "Average prorate factor used in calculations"
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight in KG across interline prorate segments"
    - name: "prorate_record_count"
      expr: COUNT(1)
      comment: "Total number of interline prorate records"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`network_hub_gateway`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hub and gateway infrastructure metrics for monitoring network node capacity, operational readiness, and geographic coverage."
  source: "`transport_shipping_ecm`.`network`.`hub_gateway`"
  dimensions:
    - name: "hub_type"
      expr: hub_type
      comment: "Type of hub (airport, seaport, inland depot, cross-dock)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the hub"
    - name: "country_code"
      expr: country_code
      comment: "Country where the hub is located"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the hub"
    - name: "operator_type"
      expr: operator_type
      comment: "Type of operator managing the hub"
    - name: "security_level"
      expr: security_level
      comment: "Security level classification of the hub"
    - name: "customs_clearance_capable"
      expr: CAST(customs_clearance_capable AS STRING)
      comment: "Whether the hub has customs clearance capability"
    - name: "dangerous_goods_certified"
      expr: CAST(dangerous_goods_certified AS STRING)
      comment: "Whether the hub is certified for dangerous goods handling"
  measures:
    - name: "total_hubs"
      expr: COUNT(1)
      comment: "Total number of hub/gateway nodes in the network"
    - name: "total_handling_capacity_teu"
      expr: SUM(CAST(handling_capacity_teu AS DOUBLE))
      comment: "Total handling capacity in TEU across all hubs"
    - name: "total_handling_capacity_tonnes"
      expr: SUM(CAST(handling_capacity_tonnes AS DOUBLE))
      comment: "Total handling capacity in tonnes across all hubs"
    - name: "total_storage_area_sqm"
      expr: SUM(CAST(storage_area_sqm AS DOUBLE))
      comment: "Total storage area in square meters across all hubs"
    - name: "avg_handling_capacity_teu"
      expr: AVG(CAST(handling_capacity_teu AS DOUBLE))
      comment: "Average handling capacity per hub in TEU"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`network_carrier_service_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier service agreement metrics for monitoring contracted rates, volume commitments, and performance targets across carrier partnerships."
  source: "`transport_shipping_ecm`.`network`.`carrier_service_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the service agreement"
    - name: "service_type"
      expr: service_type
      comment: "Type of service covered by the agreement"
    - name: "performance_tier"
      expr: performance_tier
      comment: "Performance tier classification of the agreement"
    - name: "trade_lane"
      expr: trade_lane
      comment: "Trade lane covered by the agreement"
    - name: "rate_currency"
      expr: rate_currency
      comment: "Currency of the contracted rate"
    - name: "rate_unit"
      expr: rate_unit
      comment: "Unit basis for the rate (per kg, per TEU, per CBM)"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month when the agreement became effective"
  measures:
    - name: "total_volume_commitment"
      expr: SUM(CAST(volume_commitment AS DOUBLE))
      comment: "Total volume commitments across all carrier service agreements"
    - name: "avg_contracted_rate"
      expr: AVG(CAST(rate AS DOUBLE))
      comment: "Average contracted rate across agreements"
    - name: "avg_otd_target_pct"
      expr: AVG(CAST(on_time_delivery_target_pct AS DOUBLE))
      comment: "Average on-time delivery target percentage across agreements"
    - name: "avg_transit_time_commitment_days"
      expr: AVG(CAST(transit_time_commitment_days AS DOUBLE))
      comment: "Average transit time commitment in days"
    - name: "agreement_count"
      expr: COUNT(1)
      comment: "Total number of carrier service agreements"
$$;