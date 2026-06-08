-- Metric views for domain: fleet | Business: Airlines | Version: 1 | Generated on: 2026-05-07 12:47:29

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`fleet_aircraft`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core aircraft asset metrics tracking fleet composition, operational status, and utilization hours"
  source: "`airlines_ecm`.`fleet`.`aircraft`"
  dimensions:
    - name: "aircraft_type_id"
      expr: aircraft_type_id
      comment: "Foreign key to aircraft type for fleet composition analysis"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the aircraft (active, stored, maintenance, retired)"
    - name: "ownership_category"
      expr: ownership_category
      comment: "Ownership structure (owned, leased, subleased)"
    - name: "country_of_registration"
      expr: country_of_registration
      comment: "Country where aircraft is registered for regulatory analysis"
    - name: "etops_certified"
      expr: etops_certified
      comment: "Extended-range twin-engine operations certification flag"
    - name: "rvsm_approved"
      expr: rvsm_approved
      comment: "Reduced vertical separation minima approval flag"
    - name: "delivery_year"
      expr: YEAR(delivery_date)
      comment: "Year aircraft was delivered for fleet age analysis"
    - name: "registration_year"
      expr: YEAR(registration_date)
      comment: "Year aircraft was registered"
  measures:
    - name: "total_aircraft_count"
      expr: COUNT(1)
      comment: "Total number of aircraft in fleet"
    - name: "total_block_hours"
      expr: SUM(CAST(total_block_hours AS DOUBLE))
      comment: "Total accumulated block hours across all aircraft"
    - name: "avg_block_hours_per_aircraft"
      expr: AVG(CAST(total_block_hours AS DOUBLE))
      comment: "Average block hours per aircraft for utilization benchmarking"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`fleet_aircraft_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Daily aircraft utilization metrics tracking flight hours, cycles, fuel efficiency, and operational reliability"
  source: "`airlines_ecm`.`fleet`.`aircraft_utilization`"
  dimensions:
    - name: "utilization_date"
      expr: utilization_date
      comment: "Date of utilization record for time-series analysis"
    - name: "utilization_year"
      expr: YEAR(utilization_date)
      comment: "Year of utilization for annual trending"
    - name: "utilization_month"
      expr: DATE_TRUNC('MONTH', utilization_date)
      comment: "Month of utilization for monthly trending"
    - name: "aircraft_id"
      expr: aircraft_id
      comment: "Aircraft identifier for tail-level analysis"
    - name: "tail_number"
      expr: tail_number
      comment: "Aircraft registration mark for operational tracking"
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status during utilization period"
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality indicator for filtering reliable records"
  measures:
    - name: "total_utilization_records"
      expr: COUNT(1)
      comment: "Total number of daily utilization records"
    - name: "total_block_hours"
      expr: SUM(CAST(block_hours AS DOUBLE))
      comment: "Total block hours flown across all aircraft and dates"
    - name: "total_flight_hours"
      expr: SUM(CAST(flight_hours AS DOUBLE))
      comment: "Total flight hours (wheels-up to wheels-down)"
    - name: "total_revenue_block_hours"
      expr: SUM(CAST(revenue_block_hours AS DOUBLE))
      comment: "Total revenue-generating block hours for commercial analysis"
    - name: "total_non_revenue_block_hours"
      expr: SUM(CAST(non_revenue_block_hours AS DOUBLE))
      comment: "Total non-revenue block hours (ferry, positioning, training)"
    - name: "total_fuel_burn_kg"
      expr: SUM(CAST(fuel_burn_kg AS DOUBLE))
      comment: "Total fuel consumed in kilograms for cost and environmental analysis"
    - name: "avg_daily_utilization_hours"
      expr: AVG(CAST(average_daily_utilization_hours AS DOUBLE))
      comment: "Average daily utilization hours per aircraft for productivity benchmarking"
    - name: "avg_fuel_burn_per_block_hour"
      expr: AVG(CAST(fuel_burn_kg AS DOUBLE) / NULLIF(CAST(block_hours AS DOUBLE), 0))
      comment: "Average fuel burn per block hour for efficiency analysis"
    - name: "total_apu_hours"
      expr: SUM(CAST(apu_hours AS DOUBLE))
      comment: "Total auxiliary power unit operating hours"
    - name: "total_night_flight_hours"
      expr: SUM(CAST(night_flight_hours AS DOUBLE))
      comment: "Total night flight hours for crew scheduling and safety analysis"
    - name: "revenue_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(revenue_block_hours AS DOUBLE)) / NULLIF(SUM(CAST(block_hours AS DOUBLE)), 0), 2)
      comment: "Percentage of block hours that are revenue-generating"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`fleet_aircraft_lease`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aircraft lease portfolio metrics tracking rental costs, maintenance reserves, and lease economics"
  source: "`airlines_ecm`.`fleet`.`aircraft_lease`"
  dimensions:
    - name: "lease_status"
      expr: lease_status
      comment: "Current status of lease agreement (active, expired, terminated)"
    - name: "lease_type"
      expr: lease_type
      comment: "Type of lease (operating, finance, wet, dry)"
    - name: "lessor_id"
      expr: lessor_id
      comment: "Lessor identifier for vendor concentration analysis"
    - name: "aircraft_type_code"
      expr: aircraft_type_code
      comment: "Aircraft type code for fleet mix analysis"
    - name: "lease_start_year"
      expr: YEAR(lease_start_date)
      comment: "Year lease commenced for vintage analysis"
    - name: "lease_end_year"
      expr: YEAR(lease_end_date)
      comment: "Year lease expires for renewal planning"
    - name: "maintenance_responsibility"
      expr: maintenance_responsibility
      comment: "Party responsible for maintenance (lessee, lessor, shared)"
    - name: "early_termination_clause_flag"
      expr: early_termination_clause_flag
      comment: "Indicates if early termination option exists"
    - name: "extension_option_available_flag"
      expr: extension_option_available_flag
      comment: "Indicates if lease extension option is available"
  measures:
    - name: "total_active_leases"
      expr: COUNT(1)
      comment: "Total number of lease agreements"
    - name: "total_monthly_rental_usd"
      expr: SUM(CAST(monthly_rental_rate_usd AS DOUBLE))
      comment: "Total monthly lease rental payments in USD"
    - name: "avg_monthly_rental_per_lease_usd"
      expr: AVG(CAST(monthly_rental_rate_usd AS DOUBLE))
      comment: "Average monthly rental rate per lease for benchmarking"
    - name: "total_security_deposits_usd"
      expr: SUM(CAST(security_deposit_amount_usd AS DOUBLE))
      comment: "Total security deposits held by lessors"
    - name: "total_early_termination_penalties_usd"
      expr: SUM(CAST(early_termination_penalty_usd AS DOUBLE))
      comment: "Total early termination penalty exposure"
    - name: "avg_maintenance_reserve_per_fh"
      expr: AVG(CAST(maintenance_reserve_rate_per_fh AS DOUBLE))
      comment: "Average maintenance reserve rate per flight hour"
    - name: "avg_maintenance_reserve_per_cycle"
      expr: AVG(CAST(maintenance_reserve_rate_per_cycle AS DOUBLE))
      comment: "Average maintenance reserve rate per flight cycle"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`fleet_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fleet acquisition pipeline metrics tracking order book value, delivery schedules, and capital commitments"
  source: "`airlines_ecm`.`fleet`.`fleet_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of fleet order (firm, option, delivered, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of order (purchase, lease, conversion)"
    - name: "aircraft_type_id"
      expr: aircraft_type_id
      comment: "Aircraft type being ordered"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Manufacturer or lessor vendor identifier"
    - name: "order_year"
      expr: YEAR(order_date)
      comment: "Year order was placed"
    - name: "delivery_window_start_year"
      expr: YEAR(delivery_window_start_date)
      comment: "Year delivery window opens for capacity planning"
    - name: "counterparty_type"
      expr: counterparty_type
      comment: "Type of counterparty (OEM, lessor, broker)"
    - name: "financing_structure"
      expr: financing_structure
      comment: "Financing method (cash, debt, lease, hybrid)"
    - name: "purpose"
      expr: purpose
      comment: "Strategic purpose of order (growth, replacement, fleet renewal)"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of fleet orders"
    - name: "total_order_value_usd"
      expr: SUM(CAST(total_order_value_usd AS DOUBLE))
      comment: "Total committed order book value in USD"
    - name: "avg_negotiated_price_per_unit_usd"
      expr: AVG(CAST(negotiated_price_per_unit_usd AS DOUBLE))
      comment: "Average negotiated price per aircraft unit"
    - name: "avg_list_price_per_unit_usd"
      expr: AVG(CAST(list_price_per_unit_usd AS DOUBLE))
      comment: "Average list price per aircraft unit for discount analysis"
    - name: "total_deposit_amount_usd"
      expr: SUM(CAST(deposit_amount_usd AS DOUBLE))
      comment: "Total deposits paid on orders"
    - name: "total_cancellation_penalties_usd"
      expr: SUM(CAST(cancellation_penalty_usd AS DOUBLE))
      comment: "Total cancellation penalty exposure"
    - name: "avg_discount_rate"
      expr: AVG(ROUND(100.0 * (CAST(list_price_per_unit_usd AS DOUBLE) - CAST(negotiated_price_per_unit_usd AS DOUBLE)) / NULLIF(CAST(list_price_per_unit_usd AS DOUBLE), 0), 2))
      comment: "Average discount percentage negotiated off list price"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`fleet_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic fleet planning metrics tracking capacity targets, capital expenditure, and unit economics forecasts"
  source: "`airlines_ecm`.`fleet`.`fleet_plan`"
  dimensions:
    - name: "planning_year"
      expr: planning_year
      comment: "Planning year for multi-year fleet strategy analysis"
    - name: "planning_quarter"
      expr: planning_quarter
      comment: "Planning quarter for quarterly planning cycles"
    - name: "plan_status"
      expr: plan_status
      comment: "Status of fleet plan (draft, approved, active, archived)"
    - name: "scenario_name"
      expr: scenario_name
      comment: "Planning scenario name for scenario analysis"
    - name: "aircraft_type_id"
      expr: aircraft_type_id
      comment: "Aircraft type being planned"
    - name: "network_deployment_strategy"
      expr: network_deployment_strategy
      comment: "Network deployment strategy (hub expansion, point-to-point, regional)"
    - name: "version"
      expr: version
      comment: "Plan version for tracking revisions"
  measures:
    - name: "total_fleet_plans"
      expr: COUNT(1)
      comment: "Total number of fleet planning scenarios"
    - name: "total_planned_capital_expenditure"
      expr: SUM(CAST(planned_capital_expenditure AS DOUBLE))
      comment: "Total planned capital expenditure for fleet investments"
    - name: "total_planned_operating_expense"
      expr: SUM(CAST(planned_operating_expense AS DOUBLE))
      comment: "Total planned operating expense for fleet operations"
    - name: "total_planned_block_hours"
      expr: SUM(CAST(planned_total_block_hours AS DOUBLE))
      comment: "Total planned block hours for capacity planning"
    - name: "total_planned_rpk"
      expr: SUM(CAST(planned_rpk AS DOUBLE))
      comment: "Total planned revenue passenger kilometers for demand forecasting"
    - name: "total_planned_ask"
      expr: SUM(CAST(planned_ask AS DOUBLE))
      comment: "Total planned available seat kilometers for supply planning"
    - name: "avg_target_load_factor_pct"
      expr: AVG(CAST(target_load_factor_percent AS DOUBLE))
      comment: "Average target load factor percentage for revenue optimization"
    - name: "avg_target_utilization_hours_per_day"
      expr: AVG(CAST(target_utilization_block_hours_per_day AS DOUBLE))
      comment: "Average target daily utilization hours per aircraft for productivity planning"
    - name: "avg_planned_cask"
      expr: AVG(CAST(planned_cask_target AS DOUBLE))
      comment: "Average planned cost per available seat kilometer for cost efficiency targeting"
    - name: "avg_planned_rask"
      expr: AVG(CAST(planned_rask_target AS DOUBLE))
      comment: "Average planned revenue per available seat kilometer for revenue targeting"
    - name: "avg_planned_yield"
      expr: AVG(CAST(planned_yield_target AS DOUBLE))
      comment: "Average planned yield per revenue passenger kilometer for pricing strategy"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`fleet_aircraft_redelivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aircraft lease redelivery metrics tracking return condition, settlement costs, and lessor disputes"
  source: "`airlines_ecm`.`fleet`.`aircraft_redelivery`"
  dimensions:
    - name: "redelivery_acceptance_status"
      expr: redelivery_acceptance_status
      comment: "Lessor acceptance status of redelivery (accepted, disputed, pending)"
    - name: "redelivery_condition_status"
      expr: redelivery_condition_status
      comment: "Condition status at redelivery (on-condition, off-condition)"
    - name: "redelivery_type"
      expr: redelivery_type
      comment: "Type of redelivery (lease end, early termination, sale)"
    - name: "dispute_raised_flag"
      expr: dispute_raised_flag
      comment: "Indicates if lessor raised a dispute on redelivery condition"
    - name: "redelivery_certificate_issued_flag"
      expr: redelivery_certificate_issued_flag
      comment: "Indicates if redelivery certificate was issued"
    - name: "redelivery_year"
      expr: YEAR(redelivery_date)
      comment: "Year aircraft was redelivered"
    - name: "lessor_id"
      expr: lessor_id
      comment: "Lessor receiving the aircraft"
  measures:
    - name: "total_redeliveries"
      expr: COUNT(1)
      comment: "Total number of aircraft redeliveries"
    - name: "total_final_settlement_amount_usd"
      expr: SUM(CAST(final_settlement_amount_usd AS DOUBLE))
      comment: "Total final settlement amounts paid at redelivery"
    - name: "total_maintenance_reserve_settlement_usd"
      expr: SUM(CAST(maintenance_reserve_settlement_amount_usd AS DOUBLE))
      comment: "Total maintenance reserve settlements at redelivery"
    - name: "total_security_deposit_returned_usd"
      expr: SUM(CAST(security_deposit_return_amount_usd AS DOUBLE))
      comment: "Total security deposits returned to lessee"
    - name: "avg_airframe_hours_at_redelivery"
      expr: AVG(CAST(airframe_hours_at_redelivery AS DOUBLE))
      comment: "Average airframe hours at redelivery for utilization analysis"
    - name: "avg_engine_1_hours_at_redelivery"
      expr: AVG(CAST(engine_1_hours_at_redelivery AS DOUBLE))
      comment: "Average engine 1 hours at redelivery"
    - name: "avg_apu_hours_at_redelivery"
      expr: AVG(CAST(apu_hours_at_redelivery AS DOUBLE))
      comment: "Average APU hours at redelivery"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`fleet_engine`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engine asset metrics tracking time since new, shop visit cycles, and LLP status for maintenance planning"
  source: "`airlines_ecm`.`fleet`.`engine`"
  dimensions:
    - name: "engine_status"
      expr: engine_status
      comment: "Current status of engine (on-wing, in-shop, spare, scrapped)"
    - name: "manufacturer"
      expr: manufacturer
      comment: "Engine manufacturer for vendor analysis"
    - name: "model"
      expr: model
      comment: "Engine model designation"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership structure (owned, leased, power-by-hour)"
    - name: "position"
      expr: position
      comment: "Engine position on aircraft (1, 2, 3, 4, spare)"
    - name: "etops_eligible"
      expr: etops_eligible
      comment: "ETOPS eligibility flag for extended-range operations"
    - name: "power_by_hour_contract"
      expr: power_by_hour_contract
      comment: "Indicates if engine is under power-by-hour maintenance contract"
    - name: "last_shop_visit_type"
      expr: last_shop_visit_type
      comment: "Type of last shop visit (overhaul, performance restoration, repair)"
  measures:
    - name: "total_engines"
      expr: COUNT(1)
      comment: "Total number of engines in inventory"
    - name: "total_tsn_hours"
      expr: SUM(CAST(tsn_hours AS DOUBLE))
      comment: "Total time since new hours across all engines"
    - name: "avg_tsn_hours"
      expr: AVG(CAST(tsn_hours AS DOUBLE))
      comment: "Average time since new hours per engine for age analysis"
    - name: "total_tslsv_hours"
      expr: SUM(CAST(tslsv_hours AS DOUBLE))
      comment: "Total time since last shop visit hours"
    - name: "avg_tslsv_hours"
      expr: AVG(CAST(tslsv_hours AS DOUBLE))
      comment: "Average time since last shop visit for maintenance planning"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of engine inventory"
    - name: "total_current_book_value"
      expr: SUM(CAST(current_book_value AS DOUBLE))
      comment: "Total current book value of engine assets"
    - name: "avg_thrust_rating_kn"
      expr: AVG(CAST(thrust_rating_kn AS DOUBLE))
      comment: "Average thrust rating in kilonewtons"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`fleet_aircraft_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aircraft type performance characteristics and fleet composition metrics for strategic planning"
  source: "`airlines_ecm`.`fleet`.`aircraft_type`"
  dimensions:
    - name: "manufacturer_name"
      expr: manufacturer_name
      comment: "Aircraft manufacturer for OEM analysis"
    - name: "aircraft_family"
      expr: aircraft_family
      comment: "Aircraft family grouping (e.g., A320, 737, 787)"
    - name: "aircraft_variant"
      expr: aircraft_variant
      comment: "Specific variant within family"
    - name: "iata_type_code"
      expr: iata_type_code
      comment: "IATA aircraft type code"
    - name: "icao_type_code"
      expr: icao_type_code
      comment: "ICAO aircraft type designator"
    - name: "aircraft_type_status"
      expr: aircraft_type_status
      comment: "Status of aircraft type in fleet (active, retired, planned)"
    - name: "in_fleet_flag"
      expr: in_fleet_flag
      comment: "Indicates if type is currently in fleet"
    - name: "fuselage_width_category"
      expr: fuselage_width_category
      comment: "Fuselage width category (narrowbody, widebody)"
    - name: "engine_type"
      expr: engine_type
      comment: "Engine type (turbofan, turboprop)"
    - name: "etops_certified_flag"
      expr: etops_certified_flag
      comment: "ETOPS certification flag"
    - name: "noise_chapter"
      expr: noise_chapter
      comment: "Noise certification chapter for environmental compliance"
  measures:
    - name: "total_aircraft_types"
      expr: COUNT(1)
      comment: "Total number of distinct aircraft types in fleet portfolio"
    - name: "avg_mtow_kg"
      expr: AVG(CAST(mtow_kg AS DOUBLE))
      comment: "Average maximum takeoff weight in kilograms"
    - name: "avg_fuel_capacity_liters"
      expr: AVG(CAST(fuel_capacity_liters AS DOUBLE))
      comment: "Average fuel capacity in liters for range analysis"
    - name: "avg_cargo_volume_m3"
      expr: AVG(CAST(cargo_volume_m3 AS DOUBLE))
      comment: "Average cargo volume in cubic meters for cargo capacity planning"
    - name: "avg_max_structural_payload_kg"
      expr: AVG(CAST(max_structural_payload_kg AS DOUBLE))
      comment: "Average maximum structural payload in kilograms"
    - name: "avg_typical_block_fuel_per_hour_kg"
      expr: AVG(CAST(typical_block_fuel_per_hour_kg AS DOUBLE))
      comment: "Average typical block fuel burn per hour for cost modeling"
    - name: "avg_wingspan_m"
      expr: AVG(CAST(wingspan_m AS DOUBLE))
      comment: "Average wingspan in meters for airport compatibility analysis"
    - name: "avg_fuselage_length_m"
      expr: AVG(CAST(fuselage_length_m AS DOUBLE))
      comment: "Average fuselage length in meters"
$$;