-- Metric views for domain: pricing | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 22:31:03

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`pricing_contract_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic pricing KPIs for contracted customer rates including margin analysis, discount effectiveness, and rate card performance"
  source: "`transport_shipping_ecm`.`pricing`.`contract_rate`"
  dimensions:
    - name: "rate_status"
      expr: rate_status
      comment: "Current status of the contract rate (active, expired, pending)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for rate governance"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (air, ocean, road, rail)"
    - name: "service_type"
      expr: service_type
      comment: "Service level type (express, standard, economy)"
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms governing cost and risk transfer"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the rate is denominated"
    - name: "rate_type"
      expr: rate_type
      comment: "Classification of rate (spot, contract, promotional)"
    - name: "deviation_flag"
      expr: deviation_flag
      comment: "Indicates if rate deviates from standard pricing policy"
    - name: "fuel_surcharge_applicable"
      expr: fuel_surcharge_applicable
      comment: "Whether fuel surcharge applies to this rate"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year when the contract rate became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month when the contract rate became effective"
  measures:
    - name: "total_contract_rates"
      expr: COUNT(1)
      comment: "Total number of contract rate records"
    - name: "total_base_rate_revenue"
      expr: SUM(CAST(base_rate AS DOUBLE))
      comment: "Sum of all base rates across contracts"
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate AS DOUBLE))
      comment: "Average base rate across all contract rates"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage offered across contracts"
    - name: "total_discount_value"
      expr: SUM(CAST(base_rate AS DOUBLE) * CAST(discount_percentage AS DOUBLE) / 100.0)
      comment: "Total revenue impact of discounts across all contract rates"
    - name: "avg_minimum_charge"
      expr: AVG(CAST(minimum_charge AS DOUBLE))
      comment: "Average minimum charge threshold across contracts"
    - name: "avg_floor_rate"
      expr: AVG(CAST(floor_rate AS DOUBLE))
      comment: "Average floor rate (minimum acceptable rate) across contracts"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customer accounts with contract rates"
    - name: "distinct_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers in contract rate agreements"
    - name: "distinct_lanes"
      expr: COUNT(DISTINCT lane_id)
      comment: "Number of unique shipping lanes covered by contract rates"
    - name: "deviation_rate_count"
      expr: SUM(CASE WHEN deviation_flag = true THEN 1 ELSE 0 END)
      comment: "Count of rates that deviate from standard pricing policy"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`pricing_carrier_buy_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier procurement and cost management KPIs including buy rate analysis, margin opportunity, and supplier performance"
  source: "`transport_shipping_ecm`.`pricing`.`carrier_buy_rate`"
  dimensions:
    - name: "rate_status"
      expr: rate_status
      comment: "Current status of the carrier buy rate"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for procurement governance"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for the buy rate"
    - name: "service_type"
      expr: service_type
      comment: "Service level type for the carrier service"
    - name: "rate_currency_code"
      expr: rate_currency_code
      comment: "Currency in which the buy rate is denominated"
    - name: "incoterm_code"
      expr: incoterm_code
      comment: "Incoterm governing the buy rate agreement"
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment or container for the rate"
    - name: "fuel_surcharge_applicable"
      expr: fuel_surcharge_applicable
      comment: "Whether fuel surcharge applies to this buy rate"
    - name: "effective_year"
      expr: YEAR(effective_from_date)
      comment: "Year when the buy rate became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_from_date)
      comment: "Month when the buy rate became effective"
  measures:
    - name: "total_buy_rates"
      expr: COUNT(1)
      comment: "Total number of carrier buy rate records"
    - name: "total_buy_rate_cost"
      expr: SUM(CAST(buy_rate_amount AS DOUBLE))
      comment: "Total cost of all carrier buy rates"
    - name: "avg_buy_rate"
      expr: AVG(CAST(buy_rate_amount AS DOUBLE))
      comment: "Average buy rate amount across all carrier agreements"
    - name: "avg_minimum_charge"
      expr: AVG(CAST(minimum_charge_amount AS DOUBLE))
      comment: "Average minimum charge across buy rates"
    - name: "avg_margin_floor_percentage"
      expr: AVG(CAST(margin_floor_percentage AS DOUBLE))
      comment: "Average margin floor percentage enforced in buy rate agreements"
    - name: "distinct_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers with buy rate agreements"
    - name: "distinct_lanes"
      expr: COUNT(DISTINCT lane_id)
      comment: "Number of unique lanes covered by carrier buy rates"
    - name: "distinct_carrier_services"
      expr: COUNT(DISTINCT carrier_service_id)
      comment: "Number of unique carrier services with buy rates"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`pricing_spot_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spot market pricing intelligence and quote conversion KPIs for dynamic pricing strategy and sales effectiveness"
  source: "`transport_shipping_ecm`.`pricing`.`spot_quote`"
  dimensions:
    - name: "quote_status"
      expr: quote_status
      comment: "Current status of the spot quote (pending, accepted, rejected, expired)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for the spot quote"
    - name: "service_level"
      expr: service_level
      comment: "Service level offered in the quote"
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterm specified in the spot quote"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the quote is denominated"
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of shipment (FCL, LCL, parcel, etc.)"
    - name: "is_dangerous_goods"
      expr: is_dangerous_goods
      comment: "Whether the shipment contains dangerous goods"
    - name: "quote_source"
      expr: quote_source
      comment: "Source or channel through which the quote was requested"
    - name: "quote_issued_year"
      expr: YEAR(quote_issued_timestamp)
      comment: "Year when the quote was issued"
    - name: "quote_issued_month"
      expr: DATE_TRUNC('MONTH', quote_issued_timestamp)
      comment: "Month when the quote was issued"
  measures:
    - name: "total_spot_quotes"
      expr: COUNT(1)
      comment: "Total number of spot quotes issued"
    - name: "total_quoted_revenue"
      expr: SUM(CAST(total_quoted_amount AS DOUBLE))
      comment: "Total revenue value of all spot quotes"
    - name: "avg_quoted_amount"
      expr: AVG(CAST(total_quoted_amount AS DOUBLE))
      comment: "Average quoted amount per spot quote"
    - name: "avg_base_freight_rate"
      expr: AVG(CAST(base_freight_rate AS DOUBLE))
      comment: "Average base freight rate across spot quotes"
    - name: "total_fuel_surcharge"
      expr: SUM(CAST(fuel_surcharge_amount AS DOUBLE))
      comment: "Total fuel surcharge amount across all spot quotes"
    - name: "avg_fuel_surcharge"
      expr: AVG(CAST(fuel_surcharge_amount AS DOUBLE))
      comment: "Average fuel surcharge per spot quote"
    - name: "total_chargeable_weight_kg"
      expr: SUM(CAST(chargeable_weight_kg AS DOUBLE))
      comment: "Total chargeable weight across all spot quotes"
    - name: "avg_chargeable_weight_kg"
      expr: AVG(CAST(chargeable_weight_kg AS DOUBLE))
      comment: "Average chargeable weight per spot quote"
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total volume in cubic meters across all spot quotes"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers requesting spot quotes"
    - name: "distinct_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers involved in spot quotes"
    - name: "distinct_lanes"
      expr: COUNT(DISTINCT lane_id)
      comment: "Number of unique lanes covered by spot quotes"
    - name: "dangerous_goods_quote_count"
      expr: SUM(CASE WHEN is_dangerous_goods = true THEN 1 ELSE 0 END)
      comment: "Count of spot quotes involving dangerous goods"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`pricing_surcharge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Surcharge revenue and compliance KPIs including fuel index linkage, regulatory mandate tracking, and surcharge effectiveness"
  source: "`transport_shipping_ecm`.`pricing`.`surcharge`"
  dimensions:
    - name: "surcharge_status"
      expr: surcharge_status
      comment: "Current status of the surcharge (active, inactive, pending)"
    - name: "surcharge_category"
      expr: surcharge_category
      comment: "Category of surcharge (fuel, security, peak season, etc.)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for surcharge governance"
    - name: "applicable_transport_mode"
      expr: applicable_transport_mode
      comment: "Transport mode to which the surcharge applies"
    - name: "applicable_service_type"
      expr: applicable_service_type
      comment: "Service type to which the surcharge applies"
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate the surcharge (flat, percentage, tiered)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the surcharge is denominated"
    - name: "regulatory_mandate_flag"
      expr: regulatory_mandate_flag
      comment: "Whether the surcharge is mandated by regulatory authority"
    - name: "fuel_index_linked_flag"
      expr: fuel_index_linked_flag
      comment: "Whether the surcharge is linked to a fuel price index"
    - name: "customer_visibility_flag"
      expr: customer_visibility_flag
      comment: "Whether the surcharge is visible to customers"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year when the surcharge became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month when the surcharge became effective"
  measures:
    - name: "total_surcharges"
      expr: COUNT(1)
      comment: "Total number of surcharge definitions"
    - name: "total_flat_rate_revenue"
      expr: SUM(CAST(flat_rate_amount AS DOUBLE))
      comment: "Total revenue from flat rate surcharges"
    - name: "avg_flat_rate_amount"
      expr: AVG(CAST(flat_rate_amount AS DOUBLE))
      comment: "Average flat rate surcharge amount"
    - name: "avg_percentage_rate"
      expr: AVG(CAST(percentage_rate AS DOUBLE))
      comment: "Average percentage rate for percentage-based surcharges"
    - name: "avg_per_unit_rate"
      expr: AVG(CAST(per_unit_rate AS DOUBLE))
      comment: "Average per-unit rate for unit-based surcharges"
    - name: "avg_minimum_charge"
      expr: AVG(CAST(minimum_charge_amount AS DOUBLE))
      comment: "Average minimum charge across surcharges"
    - name: "avg_maximum_charge"
      expr: AVG(CAST(maximum_charge_amount AS DOUBLE))
      comment: "Average maximum charge cap across surcharges"
    - name: "distinct_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers with surcharge definitions"
    - name: "regulatory_mandate_count"
      expr: SUM(CASE WHEN regulatory_mandate_flag = true THEN 1 ELSE 0 END)
      comment: "Count of surcharges mandated by regulatory authorities"
    - name: "fuel_linked_surcharge_count"
      expr: SUM(CASE WHEN fuel_index_linked_flag = true THEN 1 ELSE 0 END)
      comment: "Count of surcharges linked to fuel price indices"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`pricing_rate_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate card portfolio management KPIs including coverage analysis, version control effectiveness, and rate card utilization"
  source: "`transport_shipping_ecm`.`pricing`.`rate_card`"
  dimensions:
    - name: "rate_card_status"
      expr: rate_card_status
      comment: "Current status of the rate card (active, expired, draft)"
    - name: "rate_card_type"
      expr: rate_card_type
      comment: "Type of rate card (standard, promotional, contract-specific)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for rate card governance"
    - name: "service_mode"
      expr: service_mode
      comment: "Service mode covered by the rate card"
    - name: "service_type"
      expr: service_type
      comment: "Service type covered by the rate card"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the rate card is denominated"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment targeted by the rate card"
    - name: "fuel_surcharge_applicable"
      expr: fuel_surcharge_applicable
      comment: "Whether fuel surcharge applies to this rate card"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year when the rate card became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month when the rate card became effective"
  measures:
    - name: "total_rate_cards"
      expr: COUNT(1)
      comment: "Total number of rate card definitions"
    - name: "avg_base_rate_minimum"
      expr: AVG(CAST(base_rate_minimum AS DOUBLE))
      comment: "Average minimum base rate across rate cards"
    - name: "avg_base_rate_maximum"
      expr: AVG(CAST(base_rate_maximum AS DOUBLE))
      comment: "Average maximum base rate across rate cards"
    - name: "avg_minimum_charge"
      expr: AVG(CAST(minimum_charge_amount AS DOUBLE))
      comment: "Average minimum charge across rate cards"
    - name: "distinct_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers with rate cards"
    - name: "distinct_lanes"
      expr: COUNT(DISTINCT lane_id)
      comment: "Number of unique lanes covered by rate cards"
    - name: "distinct_agreements"
      expr: COUNT(DISTINCT agreement_id)
      comment: "Number of unique agreements associated with rate cards"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`pricing_fuel_index`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fuel cost volatility and surcharge adjustment KPIs for dynamic fuel surcharge management and cost forecasting"
  source: "`transport_shipping_ecm`.`pricing`.`fuel_index`"
  dimensions:
    - name: "index_status"
      expr: index_status
      comment: "Current status of the fuel index (active, archived)"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Type of fuel tracked by the index (diesel, jet fuel, bunker)"
    - name: "index_source"
      expr: index_source
      comment: "Source or provider of the fuel index data"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region for the fuel index"
    - name: "index_currency"
      expr: index_currency
      comment: "Currency in which the index is denominated"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the index data"
    - name: "index_year"
      expr: YEAR(index_date)
      comment: "Year of the fuel index observation"
    - name: "index_month"
      expr: DATE_TRUNC('MONTH', index_date)
      comment: "Month of the fuel index observation"
  measures:
    - name: "total_index_observations"
      expr: COUNT(1)
      comment: "Total number of fuel index observations"
    - name: "avg_index_value"
      expr: AVG(CAST(index_value AS DOUBLE))
      comment: "Average fuel index value across observations"
    - name: "avg_baseline_index_value"
      expr: AVG(CAST(baseline_index_value AS DOUBLE))
      comment: "Average baseline fuel index value for comparison"
    - name: "avg_index_change_percentage"
      expr: AVG(CAST(index_change_percentage AS DOUBLE))
      comment: "Average percentage change in fuel index"
    - name: "avg_adjustment_factor"
      expr: AVG(CAST(adjustment_factor AS DOUBLE))
      comment: "Average adjustment factor applied to fuel surcharges"
    - name: "distinct_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers using this fuel index"
$$;