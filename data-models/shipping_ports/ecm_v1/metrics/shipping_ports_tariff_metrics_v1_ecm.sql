-- Metric views for domain: tariff | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 03:36:32

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`tariff_rate_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic rate card performance metrics tracking committed volumes, discount effectiveness, and SLA-linked commercial agreements for shipping lines and port community participants"
  source: "`shipping_ports_ecm`.`tariff`.`rate_card`"
  dimensions:
    - name: "rate_card_type"
      expr: rate_card_type
      comment: "Type of rate card (contract, spot, promotional, standard)"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment classification for targeted pricing analysis"
    - name: "service_type"
      expr: service_type
      comment: "Type of service covered by the rate card"
    - name: "trade_lane"
      expr: trade_lane
      comment: "Trade lane or route covered by the rate card"
    - name: "sla_tier"
      expr: sla_tier
      comment: "Service level agreement tier for performance-linked pricing"
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the rate card"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year when rate card becomes effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month when rate card becomes effective"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the rate card automatically renews"
  measures:
    - name: "total_rate_cards"
      expr: COUNT(1)
      comment: "Total number of rate cards"
    - name: "total_committed_volume_teu"
      expr: SUM(CAST(committed_volume_teu AS DOUBLE))
      comment: "Total committed container volume in TEU across all rate cards"
    - name: "avg_committed_volume_teu"
      expr: AVG(CAST(committed_volume_teu AS DOUBLE))
      comment: "Average committed volume per rate card in TEU"
    - name: "total_minimum_commitment_amount"
      expr: SUM(CAST(minimum_commitment_amount AS DOUBLE))
      comment: "Total minimum revenue commitment across all rate cards"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage offered across rate cards"
    - name: "avg_premium_percentage"
      expr: AVG(CAST(premium_percentage AS DOUBLE))
      comment: "Average premium percentage charged for enhanced services"
    - name: "avg_vessel_turnaround_target_hours"
      expr: AVG(CAST(vessel_turnaround_time_target_hours AS DOUBLE))
      comment: "Average vessel turnaround time target in hours across SLA-linked rate cards"
    - name: "avg_crane_productivity_target"
      expr: AVG(CAST(crane_productivity_target_moves_per_hour AS DOUBLE))
      comment: "Average crane productivity target in moves per hour for operational efficiency"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT primary_rate_port_community_participant_id)
      comment: "Number of unique customers with active rate cards"
    - name: "distinct_shipping_lines"
      expr: COUNT(DISTINCT masterdata_shipping_line_id)
      comment: "Number of unique shipping lines with negotiated rate cards"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`tariff_negotiation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commercial negotiation effectiveness metrics tracking pricing dynamics, win rates, discount levels, and revenue commitments for strategic customer agreements"
  source: "`shipping_ports_ecm`.`tariff`.`negotiation`"
  dimensions:
    - name: "negotiation_status"
      expr: negotiation_status
      comment: "Current status of the negotiation (in progress, approved, rejected, expired)"
    - name: "negotiation_type"
      expr: negotiation_type
      comment: "Type of negotiation (new contract, renewal, amendment, exception)"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment for targeted negotiation analysis"
    - name: "service_type"
      expr: service_type
      comment: "Type of service being negotiated"
    - name: "trade_lane"
      expr: trade_lane
      comment: "Trade lane covered by the negotiation"
    - name: "sla_tier"
      expr: sla_tier
      comment: "Service level agreement tier being negotiated"
    - name: "cargo_type"
      expr: cargo_type
      comment: "Type of cargo covered by the negotiation"
    - name: "initiated_year"
      expr: YEAR(initiated_date)
      comment: "Year when negotiation was initiated"
    - name: "initiated_month"
      expr: DATE_TRUNC('MONTH', initiated_date)
      comment: "Month when negotiation was initiated"
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Whether the negotiation requires approval authority"
  measures:
    - name: "total_negotiations"
      expr: COUNT(1)
      comment: "Total number of negotiations"
    - name: "avg_proposed_rate"
      expr: AVG(CAST(proposed_rate_amount AS DOUBLE))
      comment: "Average initially proposed rate amount"
    - name: "avg_counter_offer_rate"
      expr: AVG(CAST(counter_offer_rate_amount AS DOUBLE))
      comment: "Average counter-offer rate from customers"
    - name: "avg_final_agreed_rate"
      expr: AVG(CAST(final_agreed_rate_amount AS DOUBLE))
      comment: "Average final agreed rate after negotiation"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage granted in negotiations"
    - name: "avg_premium_percentage"
      expr: AVG(CAST(premium_percentage AS DOUBLE))
      comment: "Average premium percentage achieved in negotiations"
    - name: "total_revenue_commitment"
      expr: SUM(CAST(revenue_commitment_amount AS DOUBLE))
      comment: "Total revenue commitment secured through negotiations"
    - name: "avg_revenue_commitment"
      expr: AVG(CAST(revenue_commitment_amount AS DOUBLE))
      comment: "Average revenue commitment per negotiation"
    - name: "total_volume_commitment_teu"
      expr: SUM(CAST(volume_commitment_teu AS DOUBLE))
      comment: "Total volume commitment in TEU secured through negotiations"
    - name: "avg_competitor_benchmark_rate"
      expr: AVG(CAST(competitor_benchmark_rate AS DOUBLE))
      comment: "Average competitor benchmark rate used in negotiations"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT port_community_participant_id)
      comment: "Number of unique customers in negotiations"
    - name: "distinct_shipping_lines"
      expr: COUNT(DISTINCT masterdata_shipping_line_id)
      comment: "Number of unique shipping lines in negotiations"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`tariff_port_dues_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Port dues revenue and compliance metrics tracking vessel-based charges, exemptions, frequency discounts, and regulatory levy collection across vessel size bands"
  source: "`shipping_ports_ecm`.`tariff`.`port_dues_schedule`"
  dimensions:
    - name: "port_dues_schedule_status"
      expr: port_dues_schedule_status
      comment: "Current status of the port dues schedule"
    - name: "dues_type"
      expr: dues_type
      comment: "Type of port dues (arrival, departure, anchorage, berth)"
    - name: "vessel_type"
      expr: vessel_type
      comment: "Type of vessel subject to port dues"
    - name: "trade_type"
      expr: trade_type
      comment: "Trade type classification (international, coastal, domestic)"
    - name: "call_frequency_tier"
      expr: call_frequency_tier
      comment: "Frequency tier for volume-based discounting"
    - name: "exemption_flag"
      expr: exemption_flag
      comment: "Whether exemptions apply to this schedule"
    - name: "effective_year"
      expr: YEAR(effective_from_date)
      comment: "Year when port dues schedule becomes effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_from_date)
      comment: "Month when port dues schedule becomes effective"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority governing the port dues"
  measures:
    - name: "total_schedules"
      expr: COUNT(1)
      comment: "Total number of port dues schedules"
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average base rate amount for port dues"
    - name: "total_base_rate_revenue_potential"
      expr: SUM(CAST(base_rate_amount AS DOUBLE))
      comment: "Total base rate revenue potential across all schedules"
    - name: "avg_minimum_charge"
      expr: AVG(CAST(minimum_charge_amount AS DOUBLE))
      comment: "Average minimum charge amount ensuring baseline revenue"
    - name: "avg_maximum_charge"
      expr: AVG(CAST(maximum_charge_amount AS DOUBLE))
      comment: "Average maximum charge cap limiting exposure"
    - name: "avg_call_frequency_discount_pct"
      expr: AVG(CAST(call_frequency_discount_percentage AS DOUBLE))
      comment: "Average discount percentage for frequent callers"
    - name: "avg_dangerous_goods_surcharge_pct"
      expr: AVG(CAST(dangerous_goods_surcharge_percentage AS DOUBLE))
      comment: "Average surcharge percentage for dangerous goods handling"
    - name: "avg_environmental_levy_pct"
      expr: AVG(CAST(environmental_levy_percentage AS DOUBLE))
      comment: "Average environmental levy percentage for sustainability programs"
    - name: "avg_security_levy_pct"
      expr: AVG(CAST(security_levy_percentage AS DOUBLE))
      comment: "Average security levy percentage for ISPS compliance"
    - name: "avg_late_payment_penalty_pct"
      expr: AVG(CAST(late_payment_penalty_percentage AS DOUBLE))
      comment: "Average late payment penalty percentage for collections management"
    - name: "avg_grt_band_midpoint"
      expr: AVG((CAST(grt_band_min AS DOUBLE) + CAST(grt_band_max AS DOUBLE)) / 2.0)
      comment: "Average midpoint of GRT bands for vessel size analysis"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`tariff_storage_tariff`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Container storage revenue and dwell time management metrics tracking free time allowances, tiered daily rates, and demurrage conversion for yard utilization optimization"
  source: "`shipping_ports_ecm`.`tariff`.`storage_tariff`"
  dimensions:
    - name: "tariff_status"
      expr: tariff_status
      comment: "Current status of the storage tariff"
    - name: "cargo_type"
      expr: cargo_type
      comment: "Type of cargo subject to storage charges"
    - name: "container_status"
      expr: container_status
      comment: "Status of container (full, empty, damaged)"
    - name: "customer_tier"
      expr: customer_tier
      comment: "Customer tier for differentiated storage pricing"
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG dangerous goods class for specialized storage"
    - name: "demurrage_linkage_flag"
      expr: demurrage_linkage_flag
      comment: "Whether storage converts to demurrage charges"
    - name: "weekend_charge_flag"
      expr: weekend_charge_flag
      comment: "Whether storage charges apply on weekends"
    - name: "public_holiday_charge_flag"
      expr: public_holiday_charge_flag
      comment: "Whether storage charges apply on public holidays"
    - name: "effective_year"
      expr: YEAR(effective_from_date)
      comment: "Year when storage tariff becomes effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_from_date)
      comment: "Month when storage tariff becomes effective"
  measures:
    - name: "total_tariffs"
      expr: COUNT(1)
      comment: "Total number of storage tariffs"
    - name: "avg_minimum_charge"
      expr: AVG(CAST(minimum_charge_amount AS DOUBLE))
      comment: "Average minimum storage charge ensuring baseline revenue"
    - name: "avg_maximum_charge"
      expr: AVG(CAST(maximum_charge_amount AS DOUBLE))
      comment: "Average maximum storage charge cap"
    - name: "avg_rate_band_1_daily_rate"
      expr: AVG(CAST(rate_band_1_daily_rate AS DOUBLE))
      comment: "Average daily rate for first storage tier"
    - name: "avg_rate_band_2_daily_rate"
      expr: AVG(CAST(rate_band_2_daily_rate AS DOUBLE))
      comment: "Average daily rate for second storage tier"
    - name: "avg_rate_band_3_daily_rate"
      expr: AVG(CAST(rate_band_3_daily_rate AS DOUBLE))
      comment: "Average daily rate for third storage tier showing escalation"
    - name: "distinct_terminal_zones"
      expr: COUNT(DISTINCT terminal_zone_id)
      comment: "Number of unique terminal zones with storage tariffs"
    - name: "distinct_warehouses"
      expr: COUNT(DISTINCT warehouse_id)
      comment: "Number of unique warehouses with storage tariffs"
    - name: "distinct_container_types"
      expr: COUNT(DISTINCT masterdata_container_type_id)
      comment: "Number of unique container types with differentiated storage pricing"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`tariff_demurrage_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demurrage revenue and container dwell time penalty metrics tracking free time allowances, tiered escalation rates, and waiver authority for yard congestion management"
  source: "`shipping_ports_ecm`.`tariff`.`demurrage_schedule`"
  dimensions:
    - name: "demurrage_schedule_status"
      expr: demurrage_schedule_status
      comment: "Current status of the demurrage schedule"
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of demurrage schedule (import, export, transshipment)"
    - name: "cargo_type"
      expr: cargo_type
      comment: "Type of cargo subject to demurrage"
    - name: "customer_tier"
      expr: customer_tier
      comment: "Customer tier for differentiated demurrage terms"
    - name: "trade_lane"
      expr: trade_lane
      comment: "Trade lane covered by the demurrage schedule"
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate demurrage charges"
    - name: "holiday_exclusion_flag"
      expr: holiday_exclusion_flag
      comment: "Whether holidays are excluded from demurrage calculation"
    - name: "weekend_exclusion_flag"
      expr: weekend_exclusion_flag
      comment: "Whether weekends are excluded from demurrage calculation"
    - name: "prorated_calculation_flag"
      expr: prorated_calculation_flag
      comment: "Whether demurrage is prorated for partial days"
    - name: "effective_year"
      expr: YEAR(effective_from_date)
      comment: "Year when demurrage schedule becomes effective"
  measures:
    - name: "total_schedules"
      expr: COUNT(1)
      comment: "Total number of demurrage schedules"
    - name: "avg_rate_tier_1"
      expr: AVG(CAST(rate_tier_1_amount AS DOUBLE))
      comment: "Average rate for first demurrage tier"
    - name: "avg_rate_tier_2"
      expr: AVG(CAST(rate_tier_2_amount AS DOUBLE))
      comment: "Average rate for second demurrage tier"
    - name: "avg_rate_tier_3"
      expr: AVG(CAST(rate_tier_3_amount AS DOUBLE))
      comment: "Average rate for third demurrage tier showing escalation penalty"
    - name: "avg_maximum_demurrage_cap"
      expr: AVG(CAST(maximum_demurrage_cap AS DOUBLE))
      comment: "Average maximum demurrage cap limiting customer exposure"
    - name: "distinct_container_types"
      expr: COUNT(DISTINCT masterdata_container_type_id)
      comment: "Number of unique container types with differentiated demurrage rates"
    - name: "distinct_terminal_zones"
      expr: COUNT(DISTINCT terminal_zone_id)
      comment: "Number of unique terminal zones with demurrage schedules"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`tariff_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tariff exception and waiver management metrics tracking discount approvals, revenue commitments, volume commitments, and exception justification for commercial flexibility and risk management"
  source: "`shipping_ports_ecm`.`tariff`.`exception`"
  dimensions:
    - name: "exception_status"
      expr: exception_status
      comment: "Current status of the tariff exception"
    - name: "exception_type"
      expr: exception_type
      comment: "Type of exception (discount, waiver, rate override, free time extension)"
    - name: "service_type"
      expr: service_type
      comment: "Type of service covered by the exception"
    - name: "cargo_type"
      expr: cargo_type
      comment: "Type of cargo covered by the exception"
    - name: "trade_lane"
      expr: trade_lane
      comment: "Trade lane covered by the exception"
    - name: "application_scope"
      expr: application_scope
      comment: "Scope of exception application (single transaction, agreement-wide, customer-wide)"
    - name: "approval_authority"
      expr: approval_authority
      comment: "Authority level that approved the exception"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year when exception becomes effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month when exception becomes effective"
  measures:
    - name: "total_exceptions"
      expr: COUNT(1)
      comment: "Total number of tariff exceptions granted"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage granted through exceptions"
    - name: "avg_rate_amount"
      expr: AVG(CAST(rate_amount AS DOUBLE))
      comment: "Average exception rate amount"
    - name: "avg_standard_rate_amount"
      expr: AVG(CAST(standard_rate_amount AS DOUBLE))
      comment: "Average standard rate before exception"
    - name: "total_waiver_amount"
      expr: SUM(CAST(waiver_amount AS DOUBLE))
      comment: "Total revenue waived through exceptions"
    - name: "avg_waiver_amount"
      expr: AVG(CAST(waiver_amount AS DOUBLE))
      comment: "Average waiver amount per exception"
    - name: "total_revenue_commitment"
      expr: SUM(CAST(revenue_commitment_amount AS DOUBLE))
      comment: "Total revenue commitment secured in exchange for exceptions"
    - name: "total_volume_commitment_teu"
      expr: SUM(CAST(volume_commitment_teu AS DOUBLE))
      comment: "Total volume commitment in TEU secured in exchange for exceptions"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT port_community_participant_id)
      comment: "Number of unique customers receiving tariff exceptions"
    - name: "distinct_rate_cards"
      expr: COUNT(DISTINCT rate_card_id)
      comment: "Number of unique rate cards with exceptions"
    - name: "distinct_vessel_calls"
      expr: COUNT(DISTINCT vessel_call_id)
      comment: "Number of unique vessel calls with tariff exceptions"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`tariff_pilotage_tariff`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pilotage service revenue and operational efficiency metrics tracking vessel size-based fees, distance charges, waiting time surcharges, and cancellation penalties for safe navigation services"
  source: "`shipping_ports_ecm`.`tariff`.`pilotage_tariff`"
  dimensions:
    - name: "pilotage_tariff_status"
      expr: pilotage_tariff_status
      comment: "Current status of the pilotage tariff"
    - name: "pilotage_type"
      expr: pilotage_type
      comment: "Type of pilotage service (inbound, outbound, shifting, escort)"
    - name: "service_category"
      expr: service_category
      comment: "Category of pilotage service"
    - name: "time_of_day_category"
      expr: time_of_day_category
      comment: "Time of day category for differential pricing (day, night, weekend)"
    - name: "distance_based_flag"
      expr: distance_based_flag
      comment: "Whether pilotage charges are distance-based"
    - name: "discount_eligible_flag"
      expr: discount_eligible_flag
      comment: "Whether the tariff is eligible for discounts"
    - name: "tax_applicable_flag"
      expr: tax_applicable_flag
      comment: "Whether tax applies to pilotage charges"
    - name: "effective_year"
      expr: YEAR(effective_from_date)
      comment: "Year when pilotage tariff becomes effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_from_date)
      comment: "Month when pilotage tariff becomes effective"
  measures:
    - name: "total_tariffs"
      expr: COUNT(1)
      comment: "Total number of pilotage tariffs"
    - name: "avg_base_pilotage_fee"
      expr: AVG(CAST(base_pilotage_fee AS DOUBLE))
      comment: "Average base pilotage fee"
    - name: "avg_minimum_charge"
      expr: AVG(CAST(minimum_charge AS DOUBLE))
      comment: "Average minimum pilotage charge"
    - name: "avg_maximum_charge"
      expr: AVG(CAST(maximum_charge AS DOUBLE))
      comment: "Average maximum pilotage charge cap"
    - name: "avg_rate_per_nautical_mile"
      expr: AVG(CAST(rate_per_nautical_mile AS DOUBLE))
      comment: "Average rate per nautical mile for distance-based pilotage"
    - name: "avg_waiting_time_surcharge"
      expr: AVG(CAST(waiting_time_surcharge_per_hour AS DOUBLE))
      comment: "Average waiting time surcharge per hour for pilot standby"
    - name: "avg_cancellation_fee"
      expr: AVG(CAST(cancellation_fee AS DOUBLE))
      comment: "Average cancellation fee for late cancellations"
    - name: "avg_dangerous_goods_surcharge"
      expr: AVG(CAST(dangerous_goods_surcharge AS DOUBLE))
      comment: "Average surcharge for piloting vessels carrying dangerous goods"
    - name: "avg_extraordinary_conditions_surcharge"
      expr: AVG(CAST(extraordinary_conditions_surcharge AS DOUBLE))
      comment: "Average surcharge for pilotage under extraordinary conditions (weather, congestion)"
    - name: "distinct_berths"
      expr: COUNT(DISTINCT berth_id)
      comment: "Number of unique berths with pilotage tariffs"
    - name: "distinct_channels"
      expr: COUNT(DISTINCT channel_id)
      comment: "Number of unique channels with pilotage tariffs"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`tariff_discount_scheme`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discount scheme effectiveness and customer incentive metrics tracking volume thresholds, promotional campaigns, SLA-linked discounts, and combinability rules for revenue optimization"
  source: "`shipping_ports_ecm`.`tariff`.`discount_scheme`"
  dimensions:
    - name: "scheme_status"
      expr: scheme_status
      comment: "Current status of the discount scheme"
    - name: "discount_category"
      expr: discount_category
      comment: "Category of discount (volume, loyalty, promotional, seasonal)"
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount (percentage, fixed amount, tiered)"
    - name: "customer_tier_eligibility"
      expr: customer_tier_eligibility
      comment: "Customer tiers eligible for the discount scheme"
    - name: "customer_type_eligibility"
      expr: customer_type_eligibility
      comment: "Customer types eligible for the discount scheme"
    - name: "threshold_type"
      expr: threshold_type
      comment: "Type of threshold for discount qualification (volume, revenue, frequency)"
    - name: "auto_apply_flag"
      expr: auto_apply_flag
      comment: "Whether discount is automatically applied or requires request"
    - name: "combinable_with_other_discounts"
      expr: combinable_with_other_discounts
      comment: "Whether this discount can be combined with other discounts"
    - name: "sla_linked_flag"
      expr: sla_linked_flag
      comment: "Whether discount is linked to SLA performance"
    - name: "effective_year"
      expr: YEAR(effective_from_date)
      comment: "Year when discount scheme becomes effective"
  measures:
    - name: "total_schemes"
      expr: COUNT(1)
      comment: "Total number of discount schemes"
    - name: "avg_discount_value"
      expr: AVG(CAST(discount_value AS DOUBLE))
      comment: "Average discount value (percentage or amount depending on type)"
    - name: "avg_maximum_discount_cap"
      expr: AVG(CAST(maximum_discount_cap AS DOUBLE))
      comment: "Average maximum discount cap limiting revenue impact"
    - name: "avg_minimum_charge_threshold"
      expr: AVG(CAST(minimum_charge_threshold AS DOUBLE))
      comment: "Average minimum charge threshold for discount eligibility"
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average threshold value for discount qualification"
    - name: "distinct_promotional_campaigns"
      expr: COUNT(DISTINCT promotional_campaign_code)
      comment: "Number of unique promotional campaigns with discount schemes"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`tariff_bunker_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bunker adjustment factor (BAF) revenue recovery metrics tracking fuel index linkage, vessel size bands, and regulatory compliance for fuel cost pass-through management"
  source: "`shipping_ports_ecm`.`tariff`.`bunker_adjustment`"
  dimensions:
    - name: "bunker_adjustment_status"
      expr: bunker_adjustment_status
      comment: "Current status of the bunker adjustment factor"
    - name: "baf_type"
      expr: baf_type
      comment: "Type of bunker adjustment (fixed, indexed, tiered)"
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate bunker adjustment"
    - name: "vessel_size_category"
      expr: vessel_size_category
      comment: "Vessel size category for differentiated BAF rates"
    - name: "vessel_type_applicability"
      expr: vessel_type_applicability
      comment: "Vessel types to which BAF applies"
    - name: "cargo_type_applicability"
      expr: cargo_type_applicability
      comment: "Cargo types to which BAF applies"
    - name: "container_type_applicability"
      expr: container_type_applicability
      comment: "Container types to which BAF applies"
    - name: "trade_lane_scope"
      expr: trade_lane_scope
      comment: "Trade lanes covered by the BAF"
    - name: "regulatory_filing_required_flag"
      expr: regulatory_filing_required_flag
      comment: "Whether regulatory filing is required for BAF changes"
    - name: "effective_year"
      expr: YEAR(effective_from_date)
      comment: "Year when bunker adjustment becomes effective"
  measures:
    - name: "total_adjustments"
      expr: COUNT(1)
      comment: "Total number of bunker adjustment factors"
    - name: "avg_baf_rate_amount"
      expr: AVG(CAST(baf_rate_amount AS DOUBLE))
      comment: "Average bunker adjustment factor rate amount"
    - name: "avg_minimum_charge_amount"
      expr: AVG(CAST(minimum_charge_amount AS DOUBLE))
      comment: "Average minimum BAF charge"
    - name: "avg_maximum_charge_amount"
      expr: AVG(CAST(maximum_charge_amount AS DOUBLE))
      comment: "Average maximum BAF charge cap"
    - name: "avg_fuel_index_value"
      expr: AVG(CAST(fuel_index_value AS DOUBLE))
      comment: "Average fuel index value used for BAF calculation"
    - name: "distinct_countries"
      expr: COUNT(DISTINCT country_id)
      comment: "Number of unique countries with bunker adjustment factors"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`tariff_currency_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Currency adjustment factor (CAF) revenue protection metrics tracking exchange rate volatility, hedging thresholds, and multi-currency billing for foreign exchange risk management"
  source: "`shipping_ports_ecm`.`tariff`.`currency_adjustment`"
  dimensions:
    - name: "currency_adjustment_status"
      expr: currency_adjustment_status
      comment: "Current status of the currency adjustment factor"
    - name: "base_currency_code"
      expr: base_currency_code
      comment: "Base currency for CAF calculation"
    - name: "adjustment_currency_code"
      expr: adjustment_currency_code
      comment: "Adjustment currency for CAF calculation"
    - name: "calculation_basis"
      expr: calculation_basis
      comment: "Basis for calculating currency adjustment (spot rate, average rate, forward rate)"
    - name: "trade_lane_scope"
      expr: trade_lane_scope
      comment: "Trade lanes covered by the CAF"
    - name: "service_type_scope"
      expr: service_type_scope
      comment: "Service types covered by the CAF"
    - name: "cargo_type_scope"
      expr: cargo_type_scope
      comment: "Cargo types covered by the CAF"
    - name: "auto_apply_flag"
      expr: auto_apply_flag
      comment: "Whether CAF is automatically applied"
    - name: "regulatory_filing_required_flag"
      expr: regulatory_filing_required_flag
      comment: "Whether regulatory filing is required for CAF changes"
    - name: "effective_year"
      expr: YEAR(effective_from_date)
      comment: "Year when currency adjustment becomes effective"
  measures:
    - name: "total_adjustments"
      expr: COUNT(1)
      comment: "Total number of currency adjustment factors"
    - name: "avg_caf_percentage"
      expr: AVG(CAST(caf_percentage AS DOUBLE))
      comment: "Average currency adjustment factor percentage"
    - name: "avg_minimum_caf_amount"
      expr: AVG(CAST(minimum_caf_amount AS DOUBLE))
      comment: "Average minimum CAF charge"
    - name: "avg_maximum_caf_amount"
      expr: AVG(CAST(maximum_caf_amount AS DOUBLE))
      comment: "Average maximum CAF charge cap"
    - name: "avg_current_exchange_rate"
      expr: AVG(CAST(current_exchange_rate AS DOUBLE))
      comment: "Average current exchange rate used for CAF"
    - name: "avg_reference_exchange_rate"
      expr: AVG(CAST(reference_exchange_rate AS DOUBLE))
      comment: "Average reference exchange rate for CAF baseline"
    - name: "distinct_countries"
      expr: COUNT(DISTINCT country_id)
      comment: "Number of unique countries with currency adjustment factors"
$$;