-- Metric views for domain: pricing | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 19:31:38

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`pricing_contract_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic metrics for contract rate management including rate levels, discount analysis, and margin protection indicators for the transport shipping business."
  source: "`transport_shipping_ecm`.`pricing`.`contract_rate`"
  dimensions:
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (air, ocean, road, rail) for rate segmentation"
    - name: "service_type"
      expr: service_type
      comment: "Service type classification (express, standard, economy)"
    - name: "rate_status"
      expr: rate_status
      comment: "Current status of the contract rate (active, expired, pending)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the rate"
    - name: "rate_type"
      expr: rate_type
      comment: "Type of rate (standard, promotional, volume-based)"
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterm governing cost/risk allocation"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the rate is denominated"
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of shipment (FCL, LCL, parcel, etc.)"
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month when the contract rate becomes effective"
    - name: "deviation_flag"
      expr: deviation_flag
      comment: "Whether this rate deviates from standard pricing"
  measures:
    - name: "total_contract_rates"
      expr: COUNT(1)
      comment: "Total number of contract rates for volume and coverage analysis"
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate AS DOUBLE))
      comment: "Average base rate across contracts indicating overall pricing level"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage granted, key indicator of pricing pressure"
    - name: "total_base_rate_value"
      expr: SUM(CAST(base_rate AS DOUBLE))
      comment: "Sum of all base rates for total contract value estimation"
    - name: "avg_floor_rate"
      expr: AVG(CAST(floor_rate AS DOUBLE))
      comment: "Average floor rate representing minimum acceptable pricing threshold"
    - name: "deviation_rate_count"
      expr: COUNT(CASE WHEN deviation_flag = true THEN 1 END)
      comment: "Number of rates with deviations from standard pricing, indicating exception frequency"
    - name: "avg_minimum_charge"
      expr: AVG(CAST(minimum_charge AS DOUBLE))
      comment: "Average minimum charge ensuring baseline revenue per shipment"
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers with contract rates, measuring pricing coverage"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`pricing_spot_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spot market pricing metrics tracking quote volumes, conversion potential, rate competitiveness, and revenue from ad-hoc pricing in the transport shipping business."
  source: "`transport_shipping_ecm`.`pricing`.`spot_quote`"
  dimensions:
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for the quoted shipment"
    - name: "quote_status"
      expr: quote_status
      comment: "Current status of the quote (pending, accepted, expired, rejected)"
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterm applicable to the quoted shipment"
    - name: "service_level"
      expr: service_level
      comment: "Service level offered (express, standard, economy)"
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of shipment being quoted"
    - name: "currency_code"
      expr: currency_code
      comment: "Quote currency"
    - name: "quote_request_month"
      expr: DATE_TRUNC('month', quote_request_date)
      comment: "Month of quote request for trend analysis"
    - name: "is_dangerous_goods"
      expr: is_dangerous_goods
      comment: "Whether the shipment involves dangerous goods"
    - name: "quote_source"
      expr: quote_source
      comment: "Channel through which the quote was requested (online, sales, agent)"
  measures:
    - name: "total_quotes"
      expr: COUNT(1)
      comment: "Total number of spot quotes issued, measuring market demand"
    - name: "avg_total_quoted_amount"
      expr: AVG(CAST(total_quoted_amount AS DOUBLE))
      comment: "Average total quoted amount indicating spot market pricing levels"
    - name: "total_quoted_revenue"
      expr: SUM(CAST(total_quoted_amount AS DOUBLE))
      comment: "Total potential revenue from all spot quotes"
    - name: "avg_base_freight_rate"
      expr: AVG(CAST(base_freight_rate AS DOUBLE))
      comment: "Average base freight rate in spot market for benchmarking"
    - name: "avg_chargeable_weight_kg"
      expr: AVG(CAST(chargeable_weight_kg AS DOUBLE))
      comment: "Average chargeable weight per quote indicating shipment size trends"
    - name: "total_fuel_surcharge"
      expr: SUM(CAST(fuel_surcharge_amount AS DOUBLE))
      comment: "Total fuel surcharge revenue from spot quotes"
    - name: "avg_insurance_premium"
      expr: AVG(CAST(insurance_premium AS DOUBLE))
      comment: "Average insurance premium per quote for risk pricing analysis"
    - name: "distinct_customers_quoting"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Unique customers requesting spot quotes, measuring market engagement"
    - name: "total_terminal_handling_charges"
      expr: SUM(CAST(terminal_handling_charge AS DOUBLE))
      comment: "Total terminal handling charges across spot quotes"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`pricing_carrier_buy_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier procurement cost metrics tracking buy rates, cost structure, and margin floor analysis for transport shipping carrier management."
  source: "`transport_shipping_ecm`.`pricing`.`carrier_buy_rate`"
  dimensions:
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for carrier rate segmentation"
    - name: "service_type"
      expr: service_type
      comment: "Service type offered by the carrier"
    - name: "rate_status"
      expr: rate_status
      comment: "Current status of the buy rate"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status"
    - name: "rate_currency_code"
      expr: rate_currency_code
      comment: "Currency of the buy rate"
    - name: "equipment_type"
      expr: equipment_type
      comment: "Equipment type applicable to the rate"
    - name: "commodity_group_code"
      expr: commodity_group_code
      comment: "Commodity group for rate differentiation"
    - name: "incoterm_code"
      expr: incoterm_code
      comment: "Incoterm governing the carrier rate"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month when the buy rate becomes effective"
  measures:
    - name: "total_buy_rates"
      expr: COUNT(1)
      comment: "Total number of carrier buy rates in the system"
    - name: "avg_buy_rate_amount"
      expr: AVG(CAST(buy_rate_amount AS DOUBLE))
      comment: "Average carrier buy rate indicating procurement cost levels"
    - name: "total_buy_rate_value"
      expr: SUM(CAST(buy_rate_amount AS DOUBLE))
      comment: "Total carrier buy rate value for cost exposure analysis"
    - name: "avg_margin_floor_percentage"
      expr: AVG(CAST(margin_floor_percentage AS DOUBLE))
      comment: "Average margin floor percentage ensuring minimum profitability on carrier rates"
    - name: "avg_minimum_charge"
      expr: AVG(CAST(minimum_charge_amount AS DOUBLE))
      comment: "Average minimum charge from carriers for cost floor analysis"
    - name: "distinct_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers with buy rates, measuring procurement diversification"
    - name: "distinct_lanes"
      expr: COUNT(DISTINCT lane_id)
      comment: "Number of unique lanes covered by buy rates, measuring network cost coverage"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`pricing_rate_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate change governance metrics tracking pricing modifications, change magnitude, and audit compliance for pricing integrity in transport shipping."
  source: "`transport_shipping_ecm`.`pricing`.`rate_audit`"
  dimensions:
    - name: "change_event_type"
      expr: change_event_type
      comment: "Type of rate change event (creation, modification, deletion)"
    - name: "entity_type"
      expr: entity_type
      comment: "Type of pricing entity that was changed"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the rate change"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode affected by the rate change"
    - name: "service_type"
      expr: service_type
      comment: "Service type affected by the rate change"
    - name: "change_source"
      expr: change_source
      comment: "Source/trigger of the rate change (manual, system, GRI, market)"
    - name: "change_reason_code"
      expr: change_reason_code
      comment: "Coded reason for the rate change"
    - name: "audit_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of rate change effective date for trend analysis"
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterm context of the rate change"
  measures:
    - name: "total_rate_changes"
      expr: COUNT(1)
      comment: "Total number of rate changes for pricing volatility assessment"
    - name: "avg_change_percentage"
      expr: AVG(CAST(change_percentage AS DOUBLE))
      comment: "Average percentage change in rates indicating pricing trend direction"
    - name: "avg_change_magnitude"
      expr: AVG(CAST(change_magnitude AS DOUBLE))
      comment: "Average absolute magnitude of rate changes for volatility measurement"
    - name: "total_change_magnitude"
      expr: SUM(CAST(change_magnitude AS DOUBLE))
      comment: "Total cumulative rate change magnitude for impact assessment"
    - name: "distinct_entities_changed"
      expr: COUNT(DISTINCT entity_reference_code)
      comment: "Number of unique pricing entities modified, measuring change breadth"
    - name: "regulatory_flagged_changes"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = true THEN 1 END)
      comment: "Number of rate changes flagged for regulatory compliance review"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`pricing_volume_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volume commitment performance metrics tracking commitment fulfillment, revenue attainment, and penalty/bonus exposure for transport shipping pricing agreements."
  source: "`transport_shipping_ecm`.`pricing`.`pricing_volume_commitment`"
  dimensions:
    - name: "commitment_status"
      expr: commitment_status
      comment: "Current status of the volume commitment (active, fulfilled, breached)"
    - name: "commitment_type"
      expr: commitment_type
      comment: "Type of volume commitment (minimum volume, tiered, revenue-based)"
    - name: "commitment_period_type"
      expr: commitment_period_type
      comment: "Period type for the commitment (annual, quarterly, monthly)"
    - name: "commitment_currency_code"
      expr: commitment_currency_code
      comment: "Currency of the commitment"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of commitment reconciliation"
    - name: "service_mode_scope"
      expr: service_mode_scope
      comment: "Service mode scope of the commitment"
    - name: "trade_lane_scope"
      expr: trade_lane_scope
      comment: "Trade lane scope of the commitment"
    - name: "commitment_start_month"
      expr: DATE_TRUNC('month', commitment_start_date)
      comment: "Month when the commitment period starts"
  measures:
    - name: "total_commitments"
      expr: COUNT(1)
      comment: "Total number of volume commitments for portfolio analysis"
    - name: "total_committed_revenue"
      expr: SUM(CAST(committed_revenue_amount AS DOUBLE))
      comment: "Total committed revenue across all agreements for revenue forecasting"
    - name: "total_actual_revenue_to_date"
      expr: SUM(CAST(actual_revenue_to_date AS DOUBLE))
      comment: "Total actual revenue achieved against commitments"
    - name: "total_committed_volume"
      expr: SUM(CAST(committed_volume_quantity AS DOUBLE))
      comment: "Total committed volume quantity across all agreements"
    - name: "total_actual_volume_to_date"
      expr: SUM(CAST(actual_volume_to_date AS DOUBLE))
      comment: "Total actual volume delivered against commitments"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage between committed and actual volumes"
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount exposure from underperforming commitments"
    - name: "total_bonus_potential"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus amount potential from overperforming commitments"
    - name: "distinct_customers_with_commitments"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers with volume commitments"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`pricing_gri_announcement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General Rate Increase (GRI) metrics tracking market-driven rate adjustments, their magnitude, and acceptance across the transport shipping network."
  source: "`transport_shipping_ecm`.`pricing`.`gri_announcement`"
  dimensions:
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode affected by the GRI"
    - name: "gri_type"
      expr: gri_type
      comment: "Type of GRI (general, peak season, emergency)"
    - name: "announcement_status"
      expr: announcement_status
      comment: "Current status of the GRI announcement"
    - name: "acceptance_status"
      expr: acceptance_status
      comment: "Customer acceptance status of the GRI"
    - name: "service_type"
      expr: service_type
      comment: "Service type scope of the GRI"
    - name: "announcing_party_type"
      expr: announcing_party_type
      comment: "Party announcing the GRI (carrier, consortium, authority)"
    - name: "gri_currency"
      expr: gri_currency
      comment: "Currency of the GRI amount"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month when the GRI takes effect"
    - name: "applies_to_contract"
      expr: applies_to_contract
      comment: "Whether the GRI applies to contract rates"
    - name: "applies_to_spot"
      expr: applies_to_spot
      comment: "Whether the GRI applies to spot rates"
  measures:
    - name: "total_gri_announcements"
      expr: COUNT(1)
      comment: "Total number of GRI announcements for market pressure assessment"
    - name: "avg_gri_amount"
      expr: AVG(CAST(gri_amount AS DOUBLE))
      comment: "Average GRI amount indicating magnitude of market rate increases"
    - name: "total_gri_amount"
      expr: SUM(CAST(gri_amount AS DOUBLE))
      comment: "Total GRI amount for cumulative cost impact analysis"
    - name: "avg_gri_percentage"
      expr: AVG(CAST(gri_percentage AS DOUBLE))
      comment: "Average GRI percentage increase for rate inflation tracking"
    - name: "distinct_carriers_announcing"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers issuing GRIs, measuring market-wide pressure"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`pricing_surcharge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Surcharge management metrics tracking surcharge levels, types, and revenue contribution for transport shipping ancillary pricing."
  source: "`transport_shipping_ecm`.`pricing`.`surcharge`"
  dimensions:
    - name: "surcharge_category"
      expr: surcharge_category
      comment: "Category of surcharge (fuel, security, peak season, etc.)"
    - name: "surcharge_status"
      expr: surcharge_status
      comment: "Current status of the surcharge (active, expired, pending)"
    - name: "applicable_transport_mode"
      expr: applicable_transport_mode
      comment: "Transport mode the surcharge applies to"
    - name: "applicable_service_type"
      expr: applicable_service_type
      comment: "Service type the surcharge applies to"
    - name: "calculation_method"
      expr: calculation_method
      comment: "How the surcharge is calculated (flat, percentage, tiered)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the surcharge"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the surcharge"
    - name: "fuel_index_linked_flag"
      expr: fuel_index_linked_flag
      comment: "Whether the surcharge is linked to a fuel index"
    - name: "regulatory_mandate_flag"
      expr: regulatory_mandate_flag
      comment: "Whether the surcharge is mandated by regulation"
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month when the surcharge becomes effective"
  measures:
    - name: "total_surcharges"
      expr: COUNT(1)
      comment: "Total number of surcharges in the pricing system"
    - name: "avg_flat_rate_amount"
      expr: AVG(CAST(flat_rate_amount AS DOUBLE))
      comment: "Average flat rate surcharge amount for cost impact analysis"
    - name: "avg_percentage_rate"
      expr: AVG(CAST(percentage_rate AS DOUBLE))
      comment: "Average percentage-based surcharge rate"
    - name: "avg_per_unit_rate"
      expr: AVG(CAST(per_unit_rate AS DOUBLE))
      comment: "Average per-unit surcharge rate"
    - name: "avg_minimum_charge"
      expr: AVG(CAST(minimum_charge_amount AS DOUBLE))
      comment: "Average minimum surcharge amount ensuring baseline recovery"
    - name: "distinct_carriers_with_surcharges"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers with active surcharges"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`pricing_rate_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate request pipeline metrics tracking pricing demand, approval efficiency, and competitive positioning for transport shipping sales enablement."
  source: "`transport_shipping_ecm`.`pricing`.`rate_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Current status of the rate request (pending, approved, rejected)"
    - name: "request_type"
      expr: request_type
      comment: "Type of rate request (new, renewal, amendment)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for the requested rate"
    - name: "service_type"
      expr: service_type
      comment: "Service type for the requested rate"
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency level of the rate request"
    - name: "requestor_type"
      expr: requestor_type
      comment: "Type of requestor (sales, customer, agent)"
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterm for the requested rate"
    - name: "request_month"
      expr: DATE_TRUNC('month', request_date)
      comment: "Month of rate request submission for pipeline analysis"
  measures:
    - name: "total_rate_requests"
      expr: COUNT(1)
      comment: "Total number of rate requests measuring pricing demand"
    - name: "avg_requested_rate"
      expr: AVG(CAST(requested_rate_amount AS DOUBLE))
      comment: "Average requested rate amount indicating customer price expectations"
    - name: "avg_approved_rate"
      expr: AVG(CAST(approved_rate_amount AS DOUBLE))
      comment: "Average approved rate amount indicating actual pricing decisions"
    - name: "avg_competitive_benchmark"
      expr: AVG(CAST(competitive_benchmark_rate AS DOUBLE))
      comment: "Average competitive benchmark rate for market positioning analysis"
    - name: "total_estimated_volume"
      expr: SUM(CAST(estimated_volume AS DOUBLE))
      comment: "Total estimated volume from rate requests for demand forecasting"
    - name: "distinct_customers_requesting"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers submitting rate requests"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`pricing_fuel_index`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fuel index tracking metrics for monitoring fuel cost drivers that impact surcharge calculations and overall transport shipping pricing."
  source: "`transport_shipping_ecm`.`pricing`.`fuel_index`"
  dimensions:
    - name: "fuel_type"
      expr: fuel_type
      comment: "Type of fuel (diesel, bunker, jet fuel, LNG)"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the fuel index"
    - name: "index_source"
      expr: index_source
      comment: "Source/publisher of the fuel index"
    - name: "index_status"
      expr: index_status
      comment: "Current status of the index value"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the index data"
    - name: "publication_frequency"
      expr: publication_frequency
      comment: "How frequently the index is published"
    - name: "index_currency"
      expr: index_currency
      comment: "Currency of the fuel index value"
    - name: "index_month"
      expr: DATE_TRUNC('month', index_date)
      comment: "Month of the fuel index reading for trend analysis"
  measures:
    - name: "total_index_readings"
      expr: COUNT(1)
      comment: "Total number of fuel index readings for data completeness monitoring"
    - name: "avg_index_value"
      expr: AVG(CAST(index_value AS DOUBLE))
      comment: "Average fuel index value for cost trend analysis"
    - name: "avg_index_change_percentage"
      expr: AVG(CAST(index_change_percentage AS DOUBLE))
      comment: "Average index change percentage indicating fuel cost volatility"
    - name: "max_index_value"
      expr: MAX(CAST(index_value AS DOUBLE))
      comment: "Maximum fuel index value for peak cost identification"
    - name: "avg_adjustment_factor"
      expr: AVG(CAST(adjustment_factor AS DOUBLE))
      comment: "Average adjustment factor applied to fuel indices"
$$;