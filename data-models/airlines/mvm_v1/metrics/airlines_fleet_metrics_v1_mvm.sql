-- Metric views for domain: fleet | Business: Airlines | Version: 1 | Generated on: 2026-05-07 15:08:57

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`fleet_aircraft_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational efficiency and utilization KPIs for the active fleet. Tracks block hours, flight hours, fuel burn, and revenue productivity per aircraft and operating station. Core dashboard for Fleet Operations and Network Planning executives."
  source: "`airlines_ecm`.`fleet`.`aircraft_utilization`"
  dimensions:
    - name: "utilization_date"
      expr: utilization_date
      comment: "Calendar date of the utilization record, used for daily/monthly/quarterly trending of fleet productivity."
    - name: "tail_number"
      expr: tail_number
      comment: "Aircraft tail number, enabling per-aircraft drill-down on utilization performance."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the aircraft (e.g. Active, AOG, Maintenance), used to filter or segment utilization analysis."
    - name: "data_source"
      expr: data_source
      comment: "Source system that generated the utilization record, supporting data lineage and quality audits."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality indicator for the utilization record, allowing analysts to exclude suspect records from KPI calculations."
  measures:
    - name: "total_block_hours"
      expr: SUM(CAST(block_hours AS DOUBLE))
      comment: "Total block hours flown across the fleet or segment. Primary measure of fleet productivity and the basis for lease cost allocation and maintenance scheduling."
    - name: "total_flight_hours"
      expr: SUM(CAST(flight_hours AS DOUBLE))
      comment: "Total airborne flight hours. Used to track airframe life consumption and compare against block hours to assess ground-time efficiency."
    - name: "total_revenue_block_hours"
      expr: SUM(CAST(revenue_block_hours AS DOUBLE))
      comment: "Block hours flown on revenue-generating operations. Directly linked to revenue yield and asset monetisation efficiency."
    - name: "total_non_revenue_block_hours"
      expr: SUM(CAST(non_revenue_block_hours AS DOUBLE))
      comment: "Block hours consumed on non-revenue operations (ferry, positioning, training). Measures unproductive asset deployment cost."
    - name: "revenue_block_hour_ratio"
      expr: ROUND(100.0 * SUM(CAST(revenue_block_hours AS DOUBLE)) / NULLIF(SUM(CAST(block_hours AS DOUBLE)), 0), 2)
      comment: "Percentage of total block hours that are revenue-generating. A key fleet monetisation efficiency KPI — declining ratio signals rising non-productive flying costs."
    - name: "total_fuel_burn_kg"
      expr: SUM(CAST(fuel_burn_kg AS DOUBLE))
      comment: "Total fuel consumed in kilograms. Largest single operating cost driver; tracked by fleet planners and sustainability teams for cost and emissions management."
    - name: "avg_fuel_burn_per_block_hour_kg"
      expr: ROUND(SUM(CAST(fuel_burn_kg AS DOUBLE)) / NULLIF(SUM(CAST(block_hours AS DOUBLE)), 0), 2)
      comment: "Average fuel burn per block hour (kg/BH). Efficiency ratio used to benchmark aircraft types, identify fuel-inefficient tails, and validate fleet renewal business cases."
    - name: "avg_daily_utilization_hours"
      expr: AVG(CAST(average_daily_utilization_hours AS DOUBLE))
      comment: "Average daily utilization hours per aircraft record. Benchmarked against industry targets (e.g. 12–14 BH/day for narrowbodies) to assess scheduling efficiency and aircraft productivity."
    - name: "total_apu_hours"
      expr: SUM(CAST(apu_hours AS DOUBLE))
      comment: "Total APU operating hours. High APU usage indicates ground power dependency, driving maintenance costs and emissions — actionable for ground operations investment decisions."
    - name: "total_night_flight_hours"
      expr: SUM(CAST(night_flight_hours AS DOUBLE))
      comment: "Total night flight hours flown. Relevant for crew rostering costs, noise curfew compliance risk, and slot utilisation at noise-restricted airports."
    - name: "total_airframe_hours_tsn"
      expr: SUM(CAST(total_airframe_hours_tsn AS DOUBLE))
      comment: "Cumulative total airframe hours since new (TSN) across the fleet. Tracks aggregate airframe life consumption, informing heavy maintenance scheduling and fleet retirement planning."
    - name: "aircraft_utilization_record_count"
      expr: COUNT(1)
      comment: "Count of utilization records in the selected period and grouping. Used as a denominator baseline and to detect data completeness gaps."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`fleet_aircraft_lease`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and contractual KPIs for the aircraft lease portfolio. Tracks lease cost exposure, security deposits, maintenance reserves, and early-termination risk. Used by Fleet Finance, Treasury, and the CFO to manage lease liability and negotiate renewals."
  source: "`airlines_ecm`.`fleet`.`aircraft_lease`"
  dimensions:
    - name: "lease_status"
      expr: lease_status
      comment: "Current status of the lease agreement (e.g. Active, Expired, Terminated), used to segment the active vs. historical lease portfolio."
    - name: "lease_type"
      expr: lease_type
      comment: "Type of lease arrangement (e.g. Operating, Finance/Capital), critical for balance-sheet classification and IFRS 16 reporting."
    - name: "lease_currency_code"
      expr: lease_currency_code
      comment: "Currency in which lease payments are denominated. Used to assess FX exposure in the lease portfolio."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of rental payments (e.g. Monthly, Quarterly). Relevant for cash-flow forecasting and treasury planning."
    - name: "governing_law_jurisdiction"
      expr: governing_law_jurisdiction
      comment: "Legal jurisdiction governing the lease contract. Used for legal risk segmentation and regulatory compliance reporting."
    - name: "maintenance_responsibility"
      expr: maintenance_responsibility
      comment: "Party responsible for maintenance obligations under the lease (Lessee/Lessor). Drives maintenance cost allocation and reserve adequacy analysis."
    - name: "early_termination_clause_flag"
      expr: early_termination_clause_flag
      comment: "Indicates whether the lease contains an early termination clause. Flags leases with fleet flexibility optionality for strategic planning."
    - name: "extension_option_available_flag"
      expr: extension_option_available_flag
      comment: "Indicates whether a lease extension option exists. Used to identify leases where renewal negotiations should be initiated proactively."
    - name: "lease_start_date"
      expr: lease_start_date
      comment: "Lease commencement date, used for vintage analysis and lease maturity profiling."
    - name: "lease_end_date"
      expr: lease_end_date
      comment: "Scheduled lease expiry date. Critical for fleet planning — used to identify upcoming redeliveries and capacity gaps."
  measures:
    - name: "total_monthly_rental_cost_usd"
      expr: SUM(CAST(monthly_rental_rate_usd AS DOUBLE))
      comment: "Total monthly rental obligation across the lease portfolio in USD. Primary lease cost KPI for the CFO and Fleet Finance — directly impacts EBITDAR and cash flow."
    - name: "avg_monthly_rental_rate_usd"
      expr: AVG(CAST(monthly_rental_rate_usd AS DOUBLE))
      comment: "Average monthly rental rate per lease in USD. Benchmarked against market rates to assess lease cost competitiveness and inform renegotiation priorities."
    - name: "total_security_deposit_usd"
      expr: SUM(CAST(security_deposit_amount_usd AS DOUBLE))
      comment: "Total security deposits held by lessors in USD. Represents locked-up capital; tracked by Treasury for liquidity management and lessor negotiation leverage."
    - name: "total_early_termination_penalty_usd"
      expr: SUM(CAST(early_termination_penalty_usd AS DOUBLE))
      comment: "Total early termination penalty exposure across the lease portfolio in USD. Quantifies the financial cost of fleet flexibility — critical for fleet restructuring and crisis scenario planning."
    - name: "total_maintenance_reserve_per_cycle_usd"
      expr: SUM(CAST(maintenance_reserve_rate_per_cycle AS DOUBLE))
      comment: "Total maintenance reserve accrual rate per cycle across all leases in USD. Tracks aggregate maintenance reserve liability build-up, informing MRO budget planning."
    - name: "total_maintenance_reserve_per_fh_usd"
      expr: SUM(CAST(maintenance_reserve_rate_per_fh AS DOUBLE))
      comment: "Total maintenance reserve accrual rate per flight hour across all leases in USD. Combined with utilization data, drives total maintenance reserve cash-out forecasting."
    - name: "active_lease_count"
      expr: COUNT(1)
      comment: "Total number of lease records in the selected segment. Used as the fleet size denominator for per-aircraft cost benchmarking."
    - name: "leases_with_early_termination_count"
      expr: COUNT(CASE WHEN early_termination_clause_flag = TRUE THEN 1 END)
      comment: "Number of leases containing an early termination clause. Measures the proportion of the fleet with contractual flexibility — a strategic fleet agility KPI."
    - name: "leases_with_extension_option_count"
      expr: COUNT(CASE WHEN extension_option_available_flag = TRUE THEN 1 END)
      comment: "Number of leases with an extension option available. Identifies the fleet segment where capacity can be retained without new orders — key for capacity planning under demand uncertainty."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`fleet_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fleet acquisition pipeline KPIs covering order values, delivery windows, and order status. Used by Fleet Planning, Finance, and the Board to track capital commitments, delivery schedules, and fleet renewal progress."
  source: "`airlines_ecm`.`fleet`.`fleet_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the fleet order (e.g. Firm, Option, LOI, Cancelled, Delivered). Used to segment the active order book from historical and cancelled orders."
    - name: "order_type"
      expr: order_type
      comment: "Type of fleet order (e.g. Purchase, Sale-and-Leaseback, Conversion). Drives financing structure analysis and balance-sheet impact assessment."
    - name: "financing_structure"
      expr: financing_structure
      comment: "Financing mechanism for the order (e.g. Cash, ECA, EETC, Operating Lease). Critical for Treasury and Capital Markets teams managing fleet financing mix."
    - name: "counterparty_type"
      expr: counterparty_type
      comment: "Type of counterparty (e.g. OEM, Lessor, Broker). Used to segment order book by procurement channel and counterparty risk."
    - name: "engine_type"
      expr: engine_type
      comment: "Engine type specified in the order. Used for fleet commonality analysis and engine MRO cost planning."
    - name: "purpose"
      expr: purpose
      comment: "Strategic purpose of the order (e.g. Growth, Replacement, Wet Lease). Aligns capital expenditure to fleet strategy objectives."
    - name: "order_date"
      expr: order_date
      comment: "Date the order was placed. Used for order vintage analysis and capital commitment timeline tracking."
    - name: "delivery_window_start_date"
      expr: delivery_window_start_date
      comment: "Start of the contracted delivery window. Used to forecast near-term fleet additions and capacity ramp-up."
    - name: "delivery_window_end_date"
      expr: delivery_window_end_date
      comment: "End of the contracted delivery window. Used to identify delivery schedule risk and negotiate slot adjustments with OEMs."
  measures:
    - name: "total_order_value_usd"
      expr: SUM(CAST(total_order_value_usd AS DOUBLE))
      comment: "Total contracted value of fleet orders in USD. The primary capital commitment KPI — reported to the Board and used by Treasury for long-term financing planning."
    - name: "total_negotiated_price_per_unit_usd"
      expr: SUM(CAST(negotiated_price_per_unit_usd AS DOUBLE))
      comment: "Sum of negotiated unit prices across orders in USD. Used alongside list prices to quantify total discount achieved in fleet procurement negotiations."
    - name: "total_list_price_per_unit_usd"
      expr: SUM(CAST(list_price_per_unit_usd AS DOUBLE))
      comment: "Sum of OEM list prices per unit across orders in USD. Baseline for calculating procurement discount and benchmarking negotiation outcomes."
    - name: "avg_negotiated_discount_pct"
      expr: ROUND(100.0 * (1.0 - SUM(CAST(negotiated_price_per_unit_usd AS DOUBLE)) / NULLIF(SUM(CAST(list_price_per_unit_usd AS DOUBLE)), 0)), 2)
      comment: "Average percentage discount achieved on negotiated unit prices vs. OEM list prices. A direct measure of procurement effectiveness — tracked by Fleet Planning and the CFO."
    - name: "total_deposit_amount_usd"
      expr: SUM(CAST(deposit_amount_usd AS DOUBLE))
      comment: "Total pre-delivery deposits paid to OEMs and lessors in USD. Represents locked-up capital ahead of delivery — tracked by Treasury for liquidity management."
    - name: "total_cancellation_penalty_usd"
      expr: SUM(CAST(cancellation_penalty_usd AS DOUBLE))
      comment: "Total cancellation penalty exposure across the order book in USD. Quantifies the cost of fleet plan flexibility — critical for scenario planning during demand downturns."
    - name: "fleet_order_count"
      expr: COUNT(1)
      comment: "Total number of fleet orders in the selected segment. Used as the order book size baseline for per-order benchmarking."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`fleet_engine`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engine asset health, cost, and lifecycle KPIs. Tracks engine book values, shop visit cycles, thrust ratings, and lease exposure. Used by Engineering, MRO Planning, and Fleet Finance to manage engine asset value and maintenance cost risk."
  source: "`airlines_ecm`.`fleet`.`engine`"
  dimensions:
    - name: "engine_status"
      expr: engine_status
      comment: "Current operational status of the engine (e.g. Installed, Spare, In-Shop, Retired). Used to segment the active engine fleet from assets under maintenance or retired."
    - name: "manufacturer"
      expr: manufacturer
      comment: "Engine manufacturer (e.g. CFM, GE, Rolls-Royce, Pratt & Whitney). Used for fleet commonality analysis and OEM relationship management."
    - name: "model"
      expr: model
      comment: "Engine model designation. Used for MRO cost benchmarking and maintenance program planning by engine type."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership structure of the engine (e.g. Owned, Leased, PBH). Drives accounting treatment and maintenance cost responsibility."
    - name: "position"
      expr: position
      comment: "Engine position on the aircraft (e.g. 1, 2, 3, 4). Used for positional wear analysis and maintenance scheduling."
    - name: "power_by_hour_contract"
      expr: power_by_hour_contract
      comment: "Indicates whether the engine is covered by a Power-by-the-Hour MRO contract. Segments engines by maintenance cost structure — PBH engines have predictable costs vs. time-and-material."
    - name: "etops_eligible"
      expr: etops_eligible
      comment: "Indicates whether the engine is ETOPS-certified. Used to track ETOPS-capable engine availability for long-haul route planning."
    - name: "last_shop_visit_type"
      expr: last_shop_visit_type
      comment: "Type of the most recent shop visit (e.g. Performance Restoration, LLP Replacement). Used to assess maintenance maturity and forecast next shop visit scope."
    - name: "acquisition_date"
      expr: acquisition_date
      comment: "Date the engine was acquired. Used for asset age analysis and depreciation schedule validation."
    - name: "next_shop_visit_due_date"
      expr: next_shop_visit_due_date
      comment: "Scheduled date for the next engine shop visit. Critical for MRO capacity planning and aircraft availability forecasting."
  measures:
    - name: "total_acquisition_cost_usd"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of engines in the selected segment in USD. Represents the gross capital invested in the engine fleet — used for asset register reconciliation and insurance valuation."
    - name: "total_current_book_value_usd"
      expr: SUM(CAST(current_book_value AS DOUBLE))
      comment: "Total current net book value of engines in USD. Key balance-sheet KPI for Fleet Finance — tracks asset value erosion and informs impairment testing."
    - name: "avg_current_book_value_usd"
      expr: AVG(CAST(current_book_value AS DOUBLE))
      comment: "Average current book value per engine in USD. Used to benchmark individual engine valuations against fleet average and identify outliers requiring impairment review."
    - name: "book_value_to_acquisition_cost_ratio"
      expr: ROUND(100.0 * SUM(CAST(current_book_value AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Ratio of current book value to original acquisition cost as a percentage. Measures aggregate fleet depreciation progress — a declining ratio signals accelerating asset value erosion."
    - name: "total_tsn_hours"
      expr: SUM(CAST(tsn_hours AS DOUBLE))
      comment: "Total time-since-new hours across the engine fleet. Tracks aggregate airframe life consumption and informs fleet-wide LLP replacement planning."
    - name: "avg_tsn_hours"
      expr: AVG(CAST(tsn_hours AS DOUBLE))
      comment: "Average time-since-new hours per engine. Used to assess fleet age profile and benchmark against manufacturer overhaul intervals."
    - name: "total_tslsv_hours"
      expr: SUM(CAST(tslsv_hours AS DOUBLE))
      comment: "Total time-since-last-shop-visit hours across the engine fleet. Tracks aggregate maintenance maturity — high TSLSV values signal increasing near-term shop visit demand and MRO cost exposure."
    - name: "avg_thrust_rating_kn"
      expr: AVG(CAST(thrust_rating_kn AS DOUBLE))
      comment: "Average thrust rating in kilonewtons across the engine fleet. Used for fleet capability analysis and to validate engine selection for route performance requirements."
    - name: "engine_count"
      expr: COUNT(1)
      comment: "Total number of engines in the selected segment. Used as the fleet size denominator for per-engine cost and performance benchmarking."
    - name: "pbh_engine_count"
      expr: COUNT(CASE WHEN power_by_hour_contract = TRUE THEN 1 END)
      comment: "Number of engines covered by Power-by-the-Hour MRO contracts. Measures the proportion of the engine fleet with predictable maintenance costs — a key MRO cost risk management KPI."
    - name: "etops_eligible_engine_count"
      expr: COUNT(CASE WHEN etops_eligible = TRUE THEN 1 END)
      comment: "Number of ETOPS-eligible engines. Tracks the airline's ETOPS-capable engine pool, which constrains long-haul route operations and spare engine positioning strategy."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`fleet_aircraft`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fleet composition, airworthiness, and operational readiness KPIs at the individual aircraft level. Used by Fleet Planning, Safety, and Operations to monitor fleet status, certification compliance, and asset lifecycle."
  source: "`airlines_ecm`.`fleet`.`aircraft`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the aircraft (e.g. Active, AOG, Stored, Retired). Primary filter for active fleet analysis."
    - name: "ownership_category"
      expr: ownership_category
      comment: "Ownership structure of the aircraft (e.g. Owned, Leased, Finance Lease). Used for balance-sheet classification and fleet financing mix analysis."
    - name: "country_of_registration"
      expr: country_of_registration
      comment: "Country where the aircraft is registered. Used for regulatory compliance segmentation and cross-border operational risk analysis."
    - name: "airworthiness_category"
      expr: airworthiness_category
      comment: "Airworthiness classification of the aircraft. Used to segment the fleet by certification category for safety and regulatory reporting."
    - name: "noise_chapter"
      expr: noise_chapter
      comment: "ICAO noise chapter compliance level of the aircraft. Used for environmental compliance tracking and slot access risk at noise-restricted airports."
    - name: "etops_certified"
      expr: etops_certified
      comment: "Indicates whether the aircraft holds ETOPS certification. Used to track ETOPS-capable fleet size for long-haul route planning."
    - name: "cabin_configuration_code"
      expr: cabin_configuration_code
      comment: "Cabin configuration code of the aircraft. Used to segment fleet by product offering for revenue management and customer experience analysis."
    - name: "delivery_date"
      expr: delivery_date
      comment: "Date the aircraft was delivered to the airline. Used for fleet age analysis and depreciation schedule management."
    - name: "retirement_date"
      expr: retirement_date
      comment: "Scheduled or actual retirement date of the aircraft. Used for fleet renewal planning and capacity gap analysis."
    - name: "registration_expiry_date"
      expr: registration_expiry_date
      comment: "Expiry date of the aircraft registration certificate. Used to proactively manage registration renewal compliance and avoid operational disruptions."
  measures:
    - name: "total_block_hours"
      expr: SUM(CAST(total_block_hours AS DOUBLE))
      comment: "Total cumulative block hours flown across the fleet. Primary measure of fleet utilisation and airframe life consumption — used for maintenance scheduling and asset valuation."
    - name: "avg_block_hours_per_aircraft"
      expr: AVG(CAST(total_block_hours AS DOUBLE))
      comment: "Average cumulative block hours per aircraft. Used to assess fleet age homogeneity and identify high-cycle aircraft approaching heavy maintenance thresholds."
    - name: "active_aircraft_count"
      expr: COUNT(CASE WHEN operational_status = 'Active' THEN 1 END)
      comment: "Number of aircraft in active operational status. The primary fleet size KPI — used by Network Planning to validate capacity availability against schedule requirements."
    - name: "total_aircraft_count"
      expr: COUNT(1)
      comment: "Total number of aircraft records in the selected segment. Used as the fleet size denominator for availability rate and utilisation benchmarking."
    - name: "etops_certified_aircraft_count"
      expr: COUNT(CASE WHEN etops_certified = TRUE THEN 1 END)
      comment: "Number of ETOPS-certified aircraft in the fleet. Tracks the airline's long-haul operational capability — a strategic constraint for Pacific and transatlantic route expansion."
    - name: "rvsm_approved_aircraft_count"
      expr: COUNT(CASE WHEN rvsm_approved = TRUE THEN 1 END)
      comment: "Number of aircraft approved for Reduced Vertical Separation Minima (RVSM) operations. RVSM approval is mandatory for most high-altitude airspace — non-compliance restricts route access and increases fuel burn."
    - name: "cat_iii_ils_approved_count"
      expr: COUNT(CASE WHEN cat_iii_ils_approved = TRUE THEN 1 END)
      comment: "Number of aircraft approved for CAT III ILS low-visibility approaches. Tracks the fleet's all-weather operational capability — critical for on-time performance at fog-prone hub airports."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`fleet_aircraft_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory compliance KPIs for aircraft registrations and airworthiness certificates. Tracks registration status, expiry risk, and noise compliance across the fleet. Used by Safety, Compliance, and Legal teams to manage regulatory risk and avoid operational disruptions."
  source: "`airlines_ecm`.`fleet`.`aircraft_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current status of the aircraft registration (e.g. Valid, Expired, Suspended, Cancelled). Primary compliance filter."
    - name: "registering_country_code"
      expr: registering_country_code
      comment: "Country code of the registering civil aviation authority. Used for multi-jurisdiction compliance tracking and cross-border operational risk analysis."
    - name: "national_caa_name"
      expr: national_caa_name
      comment: "Name of the national civil aviation authority. Used to segment compliance obligations by regulatory body."
    - name: "airworthiness_category"
      expr: airworthiness_category
      comment: "Airworthiness classification assigned by the registering authority. Used for safety compliance segmentation."
    - name: "noise_chapter_compliance"
      expr: noise_chapter_compliance
      comment: "ICAO noise chapter compliance level recorded on the registration. Used for environmental compliance reporting and slot access risk management at noise-restricted airports."
    - name: "registration_date"
      expr: registration_date
      comment: "Date the aircraft was registered. Used for registration vintage analysis and renewal cycle planning."
    - name: "registration_expiry_date"
      expr: registration_expiry_date
      comment: "Expiry date of the registration certificate. Used to identify registrations requiring imminent renewal action."
    - name: "airworthiness_expiry_date"
      expr: airworthiness_expiry_date
      comment: "Expiry date of the certificate of airworthiness. Lapsed airworthiness certificates ground aircraft immediately — a critical compliance risk KPI."
  measures:
    - name: "total_registration_count"
      expr: COUNT(1)
      comment: "Total number of aircraft registration records. Used as the compliance universe baseline for calculating expiry and lapse rates."
    - name: "valid_registration_count"
      expr: COUNT(CASE WHEN registration_status = 'Valid' THEN 1 END)
      comment: "Number of aircraft with a currently valid registration. Tracks the compliant fleet size — any gap vs. total fleet signals immediate regulatory risk."
    - name: "expired_registration_count"
      expr: COUNT(CASE WHEN registration_status = 'Expired' THEN 1 END)
      comment: "Number of aircraft with an expired registration. Expired registrations prohibit commercial operations — a zero-tolerance compliance KPI monitored daily by the Safety team."
    - name: "registration_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN registration_status = 'Valid' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of aircraft registrations that are currently valid. The headline fleet regulatory compliance KPI — any value below 100% requires immediate executive escalation."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`fleet_cabin_configuration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cabin product and seat inventory KPIs across the fleet. Tracks seat capacity by class, amenity availability (Wi-Fi, IFE, lie-flat), and configuration status. Used by Product, Revenue Management, and Network Planning to align cabin product with route demand and revenue strategy."
  source: "`airlines_ecm`.`fleet`.`cabin_configuration`"
  dimensions:
    - name: "configuration_code"
      expr: configuration_code
      comment: "Cabin configuration code. Used to segment fleet by product variant for revenue management and schedule planning."
    - name: "configuration_status"
      expr: configuration_status
      comment: "Current status of the cabin configuration (e.g. Active, Retired, In-Modification). Used to filter analysis to live configurations."
    - name: "ife_system_type"
      expr: ife_system_type
      comment: "In-flight entertainment system type installed. Used to segment fleet by IFE product generation for customer experience benchmarking."
    - name: "wifi_available"
      expr: wifi_available
      comment: "Indicates whether Wi-Fi is available in this cabin configuration. Tracks the Wi-Fi-enabled fleet proportion — a key ancillary revenue and customer satisfaction driver."
    - name: "wifi_provider"
      expr: wifi_provider
      comment: "Wi-Fi service provider for this configuration. Used for vendor performance analysis and contract management."
    - name: "lie_flat_seat_available"
      expr: lie_flat_seat_available
      comment: "Indicates whether lie-flat seats are available in this configuration. Tracks premium product availability — critical for long-haul business class revenue strategy."
    - name: "effective_date"
      expr: effective_date
      comment: "Date from which this cabin configuration became effective. Used for product change timeline analysis."
  measures:
    - name: "avg_business_class_seat_pitch_inches"
      expr: AVG(CAST(business_class_seat_pitch_inches AS DOUBLE))
      comment: "Average business class seat pitch in inches across configurations. Benchmarked against competitor products to assess premium cabin competitiveness and inform reconfiguration investment decisions."
    - name: "avg_economy_seat_pitch_inches"
      expr: AVG(CAST(economy_seat_pitch_inches AS DOUBLE))
      comment: "Average economy class seat pitch in inches. Tracks passenger comfort standards across the fleet — declining pitch signals densification risk and potential customer satisfaction impact."
    - name: "avg_premium_economy_seat_pitch_inches"
      expr: AVG(CAST(premium_economy_seat_pitch_inches AS DOUBLE))
      comment: "Average premium economy seat pitch in inches. Used to assess the premium economy product proposition relative to competitor benchmarks."
    - name: "wifi_enabled_configuration_count"
      expr: COUNT(CASE WHEN wifi_available = TRUE THEN 1 END)
      comment: "Number of cabin configurations with Wi-Fi enabled. Tracks the Wi-Fi fleet rollout progress — a key ancillary revenue and digital connectivity KPI."
    - name: "lie_flat_configuration_count"
      expr: COUNT(CASE WHEN lie_flat_seat_available = TRUE THEN 1 END)
      comment: "Number of configurations offering lie-flat seats. Measures premium long-haul product availability — directly linked to business class revenue yield and corporate travel contract competitiveness."
    - name: "wifi_penetration_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN wifi_available = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cabin configurations with Wi-Fi available. Tracks fleet-wide digital connectivity rollout progress — a strategic customer experience and ancillary revenue KPI."
    - name: "total_configuration_count"
      expr: COUNT(1)
      comment: "Total number of cabin configuration records. Used as the denominator for penetration rate calculations and configuration portfolio analysis."
$$;