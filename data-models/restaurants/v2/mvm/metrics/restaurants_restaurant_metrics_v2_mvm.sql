-- Metric views for domain: restaurant | Business: Restaurants | Version: 2 | Generated on: 2026-06-22 17:03:36

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core restaurant unit performance metrics covering financial productivity, operational health, and service quality KPIs used by operations leadership to steer portfolio decisions."
  source: "`vibe_restaurants_v1`.`restaurant`.`unit`"
  dimensions:
    - name: "brand_id"
      expr: brand_id
      comment: "Foreign key to brand — enables brand-level roll-up of unit performance metrics."
    - name: "ownership_model"
      expr: ownership_model
      comment: "Franchise vs. company-owned classification — critical for P&L attribution and investment decisions."
    - name: "concept_type"
      expr: concept_type
      comment: "Restaurant concept type (e.g. QSR, Fast Casual, Full Service) — drives segment-level benchmarking."
    - name: "country_code"
      expr: country_code
      comment: "Country of operation — supports geographic performance analysis and regional strategy."
    - name: "state_province"
      expr: state_province
      comment: "State or province — enables sub-national geographic drill-down for regional operations."
    - name: "city"
      expr: city
      comment: "City of the unit — supports local market performance comparisons."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the unit — used to filter active vs. inactive units in reporting."
    - name: "has_online_ordering"
      expr: has_online_ordering
      comment: "Whether the unit supports online ordering — enables digital channel adoption analysis."
    - name: "has_third_party_delivery"
      expr: has_third_party_delivery
      comment: "Whether the unit participates in third-party delivery — supports delivery channel mix analysis."
    - name: "haccp_certified"
      expr: haccp_certified
      comment: "HACCP food safety certification flag — used in compliance and risk reporting."
    - name: "opening_date"
      expr: DATE_TRUNC('month', opening_date)
      comment: "Month of unit opening — supports cohort analysis of unit maturity and ramp performance."
    - name: "opening_year"
      expr: YEAR(opening_date)
      comment: "Year of unit opening — enables vintage cohort analysis for AUV benchmarking."
    - name: "last_inspection_date"
      expr: DATE_TRUNC('month', last_inspection_date)
      comment: "Month of last health inspection — used to track inspection recency across the portfolio."
  measures:
    - name: "total_units"
      expr: COUNT(1)
      comment: "Total number of restaurant units in the portfolio. Baseline KPI for portfolio size tracking and growth reporting."
    - name: "total_average_unit_volume_usd"
      expr: SUM(CAST(average_unit_volume_usd AS DOUBLE))
      comment: "Sum of average unit volumes across all units (USD). Used to estimate total system-wide revenue potential and benchmark brand productivity."
    - name: "avg_unit_volume_usd"
      expr: AVG(CAST(average_unit_volume_usd AS DOUBLE))
      comment: "Average Unit Volume (AUV) in USD — the primary financial productivity KPI for restaurant brands. Executives use AUV to benchmark unit economics and guide investment decisions."
    - name: "avg_same_store_sales_pct"
      expr: AVG(CAST(same_store_sales_pct AS DOUBLE))
      comment: "Average same-store sales growth percentage across comparable units. Core comp-sales KPI used in quarterly earnings, board decks, and franchise performance reviews."
    - name: "avg_health_inspection_score"
      expr: AVG(CAST(health_inspection_score AS DOUBLE))
      comment: "Average health inspection score across units. Tracks food safety compliance quality — a critical risk and brand-protection metric for operations leadership."
    - name: "avg_table_turn_rate"
      expr: AVG(CAST(table_turn_rate AS DOUBLE))
      comment: "Average table turn rate across units. Measures dining room throughput efficiency — directly linked to revenue per seat and labor productivity."
    - name: "units_with_online_ordering"
      expr: COUNT(CASE WHEN has_online_ordering = TRUE THEN 1 END)
      comment: "Count of units enabled for online ordering. Tracks digital channel penetration across the portfolio — a strategic growth KPI for digital transformation initiatives."
    - name: "online_ordering_penetration_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN has_online_ordering = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of units with online ordering enabled. Measures digital readiness of the portfolio — used by digital and operations leadership to track channel expansion."
    - name: "third_party_delivery_penetration_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN has_third_party_delivery = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of units participating in third-party delivery. Tracks off-premise channel adoption — a key strategic metric for delivery-driven revenue growth."
    - name: "haccp_certified_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN haccp_certified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of units with HACCP food safety certification. Measures portfolio-wide food safety compliance — a regulatory and brand risk KPI monitored by QA and legal leadership."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_brand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand-level strategic metrics covering market position, financial scale, franchise economics, and brand health KPIs used by brand management and executive leadership."
  source: "`vibe_restaurants_v1`.`restaurant`.`brand`"
  dimensions:
    - name: "brand_status"
      expr: brand_status
      comment: "Current lifecycle status of the brand (e.g. Active, Retired, Pilot) — used to filter active brands in performance reporting."
    - name: "brand_type"
      expr: brand_type
      comment: "Classification of the brand type — supports portfolio segmentation and strategic analysis."
    - name: "segment"
      expr: segment
      comment: "Market segment (e.g. QSR, Fast Casual, Fine Dining) — the primary strategic segmentation dimension for brand portfolio analysis."
    - name: "concept_type"
      expr: concept_type
      comment: "Concept type of the brand — supports concept-level performance grouping."
    - name: "concept_category"
      expr: concept_category
      comment: "Broader concept category grouping — used for portfolio-level strategic analysis."
    - name: "primary_market_region"
      expr: primary_market_region
      comment: "Primary geographic market region of the brand — supports regional portfolio strategy and investment allocation."
    - name: "headquarters_country_code"
      expr: headquarters_country_code
      comment: "Country of brand headquarters — used for international portfolio analysis and regulatory reporting."
    - name: "franchise_allowed"
      expr: franchise_allowed
      comment: "Whether the brand permits franchising — key dimension for franchise vs. company-owned portfolio analysis."
    - name: "established_year"
      expr: YEAR(established_date)
      comment: "Year the brand was established — supports brand age/maturity analysis and vintage benchmarking."
    - name: "launch_year"
      expr: YEAR(launch_date)
      comment: "Year the brand was launched — used for brand lifecycle and growth trajectory analysis."
  measures:
    - name: "total_brands"
      expr: COUNT(1)
      comment: "Total number of brands in the portfolio. Baseline portfolio size metric used in brand management and M&A reporting."
    - name: "avg_annual_sales_usd"
      expr: AVG(CAST(average_annual_sales_usd AS DOUBLE))
      comment: "Average annual sales per brand (USD). Core financial productivity KPI for brand-level revenue benchmarking and investment prioritization."
    - name: "total_annual_sales_usd"
      expr: SUM(CAST(average_annual_sales_usd AS DOUBLE))
      comment: "Total estimated annual sales across all brands (USD). System-wide revenue scale metric used in board reporting and investor communications."
    - name: "avg_check_amount_usd"
      expr: AVG(CAST(average_check_amount_usd AS DOUBLE))
      comment: "Average customer check amount across brands (USD). Measures pricing power and transaction value — a key driver of revenue per visit and brand positioning."
    - name: "avg_market_share_pct"
      expr: AVG(CAST(market_share_percent AS DOUBLE))
      comment: "Average market share percentage across brands. Tracks competitive positioning — a strategic KPI used in brand investment and M&A decisions."
    - name: "avg_franchise_fee_pct"
      expr: AVG(CAST(franchise_fee_percent AS DOUBLE))
      comment: "Average franchise fee percentage across brands. Measures franchise economics — used by franchise development leadership to benchmark fee structures."
    - name: "avg_royalty_fee_pct"
      expr: AVG(CAST(royalty_fee_percent AS DOUBLE))
      comment: "Average royalty fee percentage across brands. Core franchise revenue metric — directly tied to system-wide royalty income for franchisors."
    - name: "avg_store_size_sqft"
      expr: AVG(CAST(average_store_size_sqft AS DOUBLE))
      comment: "Average store size in square feet across brands. Drives real estate strategy, capital expenditure planning, and sales-per-sqft benchmarking."
    - name: "franchise_enabled_brands"
      expr: COUNT(CASE WHEN franchise_allowed = TRUE THEN 1 END)
      comment: "Number of brands that permit franchising. Tracks franchise-eligible portfolio size — used in franchise development strategy and growth planning."
    - name: "franchise_enabled_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN franchise_allowed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of brands with franchising enabled. Measures franchise strategy penetration across the brand portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_equipment_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment asset lifecycle and financial metrics covering acquisition cost, replacement value, maintenance compliance, and operational risk — used by facilities and operations leadership."
  source: "`vibe_restaurants_v1`.`restaurant`.`equipment_asset`"
  dimensions:
    - name: "equipment_category"
      expr: equipment_category
      comment: "Category of equipment (e.g. Cooking, Refrigeration, POS) — enables category-level asset analysis and capital planning."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Specific equipment type — supports granular asset tracking and maintenance scheduling."
    - name: "asset_condition_rating"
      expr: asset_condition_rating
      comment: "Current condition rating of the asset — used to prioritize replacement and maintenance investment."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Whether the asset is owned, leased, or financed — drives capital vs. operating expense classification."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied to the asset — relevant for financial reporting and tax planning."
    - name: "energy_rating"
      expr: energy_rating
      comment: "Energy efficiency rating of the equipment — used in sustainability reporting and utility cost analysis."
    - name: "temperature_critical_flag"
      expr: temperature_critical_flag
      comment: "Whether the asset is temperature-critical (e.g. refrigeration, freezers) — used for food safety risk prioritization."
    - name: "installation_year"
      expr: YEAR(installation_date)
      comment: "Year of equipment installation — supports asset age analysis and replacement cycle planning."
    - name: "next_scheduled_maintenance_month"
      expr: DATE_TRUNC('month', next_scheduled_maintenance_date)
      comment: "Month of next scheduled maintenance — used for maintenance workload planning and compliance tracking."
  measures:
    - name: "total_equipment_assets"
      expr: COUNT(1)
      comment: "Total number of equipment assets in the portfolio. Baseline asset inventory metric for facilities management."
    - name: "total_acquisition_cost_usd"
      expr: SUM(CAST(acquisition_cost_usd AS DOUBLE))
      comment: "Total acquisition cost of all equipment assets (USD). Measures total capital deployed in equipment — a key input for asset management and capital budgeting."
    - name: "avg_acquisition_cost_usd"
      expr: AVG(CAST(acquisition_cost_usd AS DOUBLE))
      comment: "Average acquisition cost per equipment asset (USD). Benchmarks equipment investment per unit — used in new unit build-out cost modeling."
    - name: "total_replacement_cost_usd"
      expr: SUM(CAST(replacement_cost_usd AS DOUBLE))
      comment: "Total replacement cost of all equipment assets (USD). Quantifies the capital exposure from aging equipment — critical for capital reserve planning and insurance valuation."
    - name: "avg_replacement_cost_usd"
      expr: AVG(CAST(replacement_cost_usd AS DOUBLE))
      comment: "Average replacement cost per equipment asset (USD). Used to estimate per-unit equipment refresh investment in capital planning cycles."
    - name: "replacement_cost_to_acquisition_ratio"
      expr: ROUND(SUM(CAST(replacement_cost_usd AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost_usd AS DOUBLE)), 0), 4)
      comment: "Ratio of total replacement cost to total acquisition cost. Values above 1.0 indicate asset appreciation or inflation — used in capital reserve adequacy assessment."
    - name: "temperature_critical_assets"
      expr: COUNT(CASE WHEN temperature_critical_flag = TRUE THEN 1 END)
      comment: "Count of temperature-critical equipment assets. Tracks food safety risk exposure — used by QA and operations to prioritize maintenance and monitoring resources."
    - name: "temperature_critical_asset_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN temperature_critical_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of equipment assets that are temperature-critical. Measures food safety risk concentration in the asset portfolio."
    - name: "avg_temperature_max_f"
      expr: AVG(CAST(temperature_max_f AS DOUBLE))
      comment: "Average maximum operating temperature (°F) across temperature-relevant assets. Used in food safety compliance monitoring and equipment specification reviews."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_kitchen_station`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Kitchen station operational efficiency metrics covering throughput, capacity utilization, and maintenance compliance — used by operations and culinary leadership to optimize kitchen performance."
  source: "`vibe_restaurants_v1`.`restaurant`.`kitchen_station`"
  dimensions:
    - name: "station_type"
      expr: station_type
      comment: "Type of kitchen station (e.g. Grill, Fryer, Prep, Expo) — enables station-type performance benchmarking."
    - name: "station_status"
      expr: station_status
      comment: "Current operational status of the station — used to filter active stations and track downtime."
    - name: "kitchen_station_status"
      expr: kitchen_station_status
      comment: "Detailed kitchen station status — supports granular operational status reporting."
    - name: "is_active"
      expr: is_active
      comment: "Whether the kitchen station is currently active — primary filter for operational reporting."
    - name: "is_automated"
      expr: is_automated
      comment: "Whether the station uses automated equipment — tracks automation adoption and its impact on throughput."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Whether the station is temperature-controlled — used in food safety compliance analysis."
    - name: "health_inspection_status"
      expr: health_inspection_status
      comment: "Current health inspection status of the station — a food safety compliance KPI dimension."
    - name: "daypart_schedule"
      expr: daypart_schedule
      comment: "Daypart schedule the station operates in — supports daypart-level throughput and staffing analysis."
    - name: "health_inspection_month"
      expr: DATE_TRUNC('month', health_inspection_date)
      comment: "Month of last health inspection — used to track inspection recency and compliance cadence."
  measures:
    - name: "total_kitchen_stations"
      expr: COUNT(1)
      comment: "Total number of kitchen stations. Baseline capacity metric for kitchen infrastructure planning."
    - name: "active_kitchen_stations"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active kitchen stations. Measures operational kitchen capacity — used to identify downtime and capacity gaps."
    - name: "station_activation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_active = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of kitchen stations that are active. Measures kitchen operational readiness — a key throughput capacity KPI for operations leadership."
    - name: "automated_station_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_automated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of kitchen stations that are automated. Tracks kitchen automation adoption — linked to labor efficiency and throughput improvement initiatives."
    - name: "total_area_sqft"
      expr: SUM(CAST(area_sqft AS DOUBLE))
      comment: "Total kitchen station area in square feet. Measures total kitchen footprint — used in space utilization and remodel planning."
    - name: "avg_area_sqft"
      expr: AVG(CAST(area_sqft AS DOUBLE))
      comment: "Average kitchen station area in square feet. Benchmarks station sizing for new unit design and remodel specifications."
    - name: "avg_operational_hours"
      expr: AVG(CAST(operational_hours AS DOUBLE))
      comment: "Average operational hours per kitchen station. Measures station utilization intensity — used to identify over/under-utilized stations and optimize scheduling."
    - name: "total_power_consumption_kw"
      expr: SUM(CAST(power_rating_kw AS DOUBLE))
      comment: "Total power consumption across all kitchen stations (kW). Measures energy demand — used in utility cost management and sustainability reporting."
    - name: "avg_power_rating_kw"
      expr: AVG(CAST(power_rating_kw AS DOUBLE))
      comment: "Average power rating per kitchen station (kW). Benchmarks energy consumption per station — used in energy efficiency analysis and equipment specification."
    - name: "temperature_controlled_station_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN temperature_controlled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of kitchen stations with temperature control. Measures food safety infrastructure coverage — a compliance KPI for QA and regulatory reporting."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_pos_terminal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "POS terminal fleet metrics covering payment capability coverage, PCI compliance, operational readiness, and digital payment adoption — used by IT, operations, and finance leadership."
  source: "`vibe_restaurants_v1`.`restaurant`.`pos_terminal`"
  dimensions:
    - name: "pos_terminal_status"
      expr: pos_terminal_status
      comment: "Current status of the POS terminal — used to filter active terminals and track fleet health."
    - name: "is_active"
      expr: is_active
      comment: "Whether the POS terminal is currently active — primary operational readiness filter."
    - name: "pci_compliance_status"
      expr: pci_compliance_status
      comment: "PCI DSS compliance status of the terminal — a critical regulatory and financial risk dimension."
    - name: "terminal_type"
      expr: terminal_type
      comment: "Type of POS terminal (e.g. Counter, Kiosk, Mobile, Drive-Thru) — supports channel-level payment infrastructure analysis."
    - name: "service_channel"
      expr: service_channel
      comment: "Service channel the terminal supports (e.g. Dine-In, Drive-Thru, Delivery) — enables channel-level POS fleet analysis."
    - name: "network_type"
      expr: network_type
      comment: "Network connectivity type of the terminal — used in IT infrastructure planning and uptime analysis."
    - name: "supports_contactless"
      expr: supports_contactless
      comment: "Whether the terminal supports contactless payment — tracks modern payment capability adoption."
    - name: "supports_mobile_wallet"
      expr: supports_mobile_wallet
      comment: "Whether the terminal supports mobile wallet payments (e.g. Apple Pay, Google Pay) — measures digital payment readiness."
    - name: "installation_year"
      expr: YEAR(installation_date)
      comment: "Year of terminal installation — supports fleet age analysis and refresh cycle planning."
    - name: "last_pci_audit_month"
      expr: DATE_TRUNC('month', last_pci_audit_date)
      comment: "Month of last PCI audit — used to track audit recency and compliance cadence across the terminal fleet."
  measures:
    - name: "total_pos_terminals"
      expr: COUNT(1)
      comment: "Total number of POS terminals in the fleet. Baseline infrastructure metric for IT and operations fleet management."
    - name: "active_pos_terminals"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active POS terminals. Measures operational payment processing capacity — a direct driver of transaction throughput."
    - name: "terminal_activation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_active = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of POS terminals that are active. Measures fleet operational readiness — used by IT leadership to track uptime and identify underperforming units."
    - name: "pci_compliant_terminals"
      expr: COUNT(CASE WHEN pci_compliance_status = 'Compliant' THEN 1 END)
      comment: "Number of PCI-compliant POS terminals. Tracks payment security compliance — a critical regulatory risk metric monitored by IT security and finance leadership."
    - name: "pci_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pci_compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of POS terminals that are PCI compliant. Measures payment security posture across the fleet — a board-level risk and compliance KPI."
    - name: "contactless_capable_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN supports_contactless = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of POS terminals supporting contactless payment. Tracks modern payment capability penetration — used by digital and operations leadership to guide fleet upgrade investment."
    - name: "mobile_wallet_capable_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN supports_mobile_wallet = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of POS terminals supporting mobile wallet payments. Measures digital payment readiness — a strategic KPI for customer experience and digital transformation initiatives."
    - name: "nfc_capable_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN supports_nfc = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of POS terminals with NFC capability. Tracks contactless infrastructure readiness — used in payment technology modernization planning."
    - name: "olo_capable_terminals"
      expr: COUNT(CASE WHEN supports_olo = TRUE THEN 1 END)
      comment: "Number of POS terminals supporting online ordering integration. Measures digital order channel infrastructure — used to track OLO deployment progress across the fleet."
    - name: "third_party_delivery_capable_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN supports_third_party_delivery = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of POS terminals supporting third-party delivery integration. Tracks off-premise channel infrastructure readiness — a key metric for delivery strategy execution."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_operating_hours`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operating hours and scheduling metrics covering daypart coverage, service window availability, and throughput targets — used by operations leadership to optimize unit scheduling and capacity planning."
  source: "`vibe_restaurants_v1`.`restaurant`.`operating_hours`"
  dimensions:
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week for the operating schedule — enables day-of-week performance and coverage analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart (e.g. Breakfast, Lunch, Dinner, Late Night) — the primary scheduling dimension for restaurant operations analysis."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of schedule (e.g. Regular, Holiday, Special Event) — used to distinguish standard vs. exception scheduling."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the schedule record — used to filter active vs. expired schedules."
    - name: "is_24_hour_operation"
      expr: is_24_hour_operation
      comment: "Whether the unit operates 24 hours — tracks 24-hour coverage across the portfolio."
    - name: "is_closed"
      expr: is_closed
      comment: "Whether the unit is closed for this schedule period — used to track closure patterns and availability."
    - name: "holiday_schedule_override_flag"
      expr: holiday_schedule_override_flag
      comment: "Whether a holiday schedule override is in effect — used to analyze holiday operational patterns."
    - name: "seasonal_adjustment_flag"
      expr: seasonal_adjustment_flag
      comment: "Whether a seasonal schedule adjustment is applied — supports seasonal operations planning."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the schedule becomes effective — used for scheduling trend and seasonality analysis."
  measures:
    - name: "total_schedule_records"
      expr: COUNT(1)
      comment: "Total number of operating hours schedule records. Baseline metric for schedule coverage completeness analysis."
    - name: "closed_schedule_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_closed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of schedule records where the unit is closed. Measures closure frequency — used to identify units with excessive downtime or scheduling gaps."
    - name: "holiday_override_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN holiday_schedule_override_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of schedule records with holiday overrides. Tracks holiday scheduling complexity — used in labor planning and customer communication strategy."
    - name: "avg_expected_table_turn_count"
      expr: AVG(CAST(expected_table_turn_count AS DOUBLE))
      comment: "Average expected table turn count per schedule period. Measures planned dining room throughput — a key input for labor scheduling and revenue forecasting."
    - name: "total_expected_table_turns"
      expr: SUM(CAST(expected_table_turn_count AS DOUBLE))
      comment: "Total expected table turns across all schedule periods. Aggregates planned throughput capacity — used in revenue forecasting and staffing models."
    - name: "seasonal_adjustment_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN seasonal_adjustment_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of schedule records with seasonal adjustments. Tracks seasonal scheduling complexity — used in annual operations planning and labor budgeting."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_brand_standard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand standard compliance and governance metrics covering certification requirements, training obligations, and standard lifecycle — used by QA, compliance, and brand leadership."
  source: "`vibe_restaurants_v1`.`restaurant`.`brand_standard`"
  dimensions:
    - name: "brand_id"
      expr: brand_id
      comment: "Brand the standard applies to — enables brand-level compliance standard analysis."
    - name: "brand_standard_status"
      expr: brand_standard_status
      comment: "Current lifecycle status of the brand standard (e.g. Active, Superseded, Draft) — used to filter active standards in compliance reporting."
    - name: "standard_category"
      expr: standard_category
      comment: "Category of the brand standard (e.g. Food Safety, Service, Facilities) — enables category-level compliance analysis."
    - name: "compliance_requirement_level"
      expr: compliance_requirement_level
      comment: "Compliance requirement level (e.g. Mandatory, Recommended) — used to prioritize compliance enforcement actions."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the standard — used to focus compliance resources on high-priority standards."
    - name: "certification_required_flag"
      expr: certification_required_flag
      comment: "Whether certification is required for this standard — tracks certification obligation scope."
    - name: "training_required_flag"
      expr: training_required_flag
      comment: "Whether training is required for this standard — tracks training obligation scope across the standard library."
    - name: "guest_facing_flag"
      expr: guest_facing_flag
      comment: "Whether the standard is guest-facing — used to prioritize standards with direct customer experience impact."
    - name: "applicable_format"
      expr: applicable_format
      comment: "Restaurant format the standard applies to — enables format-specific compliance analysis."
    - name: "applicable_ownership_model"
      expr: applicable_ownership_model
      comment: "Ownership model the standard applies to (e.g. Franchise, Company-Owned) — supports ownership-model-specific compliance tracking."
    - name: "audit_frequency"
      expr: audit_frequency
      comment: "How frequently the standard is audited — used in audit scheduling and resource planning."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the standard became effective — supports standard vintage analysis and compliance timeline tracking."
  measures:
    - name: "total_brand_standards"
      expr: COUNT(1)
      comment: "Total number of brand standards in the library. Baseline metric for compliance program scope and governance complexity."
    - name: "active_brand_standards"
      expr: COUNT(CASE WHEN brand_standard_status = 'Active' THEN 1 END)
      comment: "Number of currently active brand standards. Measures the active compliance obligation set — used by QA leadership to scope audit and enforcement programs."
    - name: "certification_required_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of brand standards requiring certification. Measures certification obligation density — used to plan certification program resources and timelines."
    - name: "training_required_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN training_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of brand standards requiring training. Measures training obligation scope — used by L&D leadership to size training program investment."
    - name: "guest_facing_standards_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN guest_facing_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of brand standards that are guest-facing. Measures the proportion of standards with direct customer experience impact — used to prioritize compliance enforcement."
    - name: "avg_target_metric_value"
      expr: AVG(CAST(target_metric_value AS DOUBLE))
      comment: "Average target metric value across quantitative brand standards. Provides a benchmark of standard stringency — used in standard-setting and competitive benchmarking."
    - name: "distinct_brands_with_standards"
      expr: COUNT(DISTINCT brand_id)
      comment: "Number of distinct brands with at least one brand standard defined. Measures brand standard coverage — used to identify brands lacking formal compliance frameworks."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_location_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Restaurant location profile metrics covering site characteristics, accessibility features, and proximity analytics — used by real estate, development, and operations leadership for site strategy."
  source: "`vibe_restaurants_v1`.`restaurant`.`location_profile`"
  dimensions:
    - name: "city"
      expr: city
      comment: "City of the restaurant location — enables city-level site portfolio analysis."
    - name: "state_province"
      expr: state_province
      comment: "State or province of the location — supports regional real estate portfolio analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the location — enables international portfolio geographic analysis."
    - name: "site_status"
      expr: site_status
      comment: "Current status of the site (e.g. Open, Closed, Under Construction) — primary filter for active site analysis."
    - name: "trade_area_classification"
      expr: trade_area_classification
      comment: "Trade area classification (e.g. Urban, Suburban, Rural) — key dimension for site performance benchmarking and new site selection."
    - name: "building_ownership_type"
      expr: building_ownership_type
      comment: "Whether the building is owned or leased — drives real estate cost structure and capital allocation analysis."
    - name: "has_drive_thru"
      expr: has_drive_thru
      comment: "Whether the location has a drive-thru — a key format differentiator for revenue and throughput analysis."
    - name: "has_patio_seating"
      expr: has_patio_seating
      comment: "Whether the location has patio seating — tracks outdoor dining capacity across the portfolio."
    - name: "has_wifi"
      expr: has_wifi
      comment: "Whether the location offers WiFi — tracks guest amenity availability."
    - name: "has_accessible_parking"
      expr: has_accessible_parking
      comment: "Whether the location has accessible parking — used in ADA compliance and accessibility reporting."
    - name: "has_wheelchair_access"
      expr: has_wheelchair_access
      comment: "Whether the location has wheelchair access — tracks ADA compliance across the portfolio."
    - name: "site_opened_year"
      expr: YEAR(site_opened_date)
      comment: "Year the site opened — supports site vintage analysis and portfolio age distribution reporting."
    - name: "lease_expiration_month"
      expr: DATE_TRUNC('month', lease_expiration_date)
      comment: "Month of lease expiration — used in real estate lease management and renewal planning."
  measures:
    - name: "total_locations"
      expr: COUNT(1)
      comment: "Total number of restaurant locations in the portfolio. Baseline real estate portfolio size metric."
    - name: "locations_with_drive_thru"
      expr: COUNT(CASE WHEN has_drive_thru = TRUE THEN 1 END)
      comment: "Number of locations with drive-thru capability. Tracks drive-thru format penetration — a key revenue channel and site selection criterion."
    - name: "drive_thru_penetration_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN has_drive_thru = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of locations with drive-thru capability. Measures drive-thru format coverage — used in format strategy and capital investment planning."
    - name: "avg_delivery_radius_km"
      expr: AVG(CAST(delivery_radius_km AS DOUBLE))
      comment: "Average delivery radius in kilometers across locations. Measures delivery coverage footprint — used in delivery strategy and market coverage analysis."
    - name: "avg_proximity_to_highway_km"
      expr: AVG(CAST(proximity_to_highway_km AS DOUBLE))
      comment: "Average proximity to nearest highway in kilometers. Measures traffic accessibility of the portfolio — a key site selection and performance predictor."
    - name: "avg_proximity_to_mall_km"
      expr: AVG(CAST(proximity_to_mall_km AS DOUBLE))
      comment: "Average proximity to nearest mall in kilometers. Measures co-tenancy proximity — used in site selection and trade area analysis."
    - name: "avg_proximity_to_airport_km"
      expr: AVG(CAST(proximity_to_airport_km AS DOUBLE))
      comment: "Average proximity to nearest airport in kilometers. Tracks airport-adjacent site concentration — relevant for travel hub revenue strategy."
    - name: "wheelchair_accessible_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN has_wheelchair_access = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of locations with wheelchair access. Measures ADA compliance coverage — a regulatory risk and brand inclusivity KPI."
    - name: "avg_latitude"
      expr: AVG(CAST(latitude AS DOUBLE))
      comment: "Average latitude of restaurant locations. Used as a geographic centroid metric for portfolio geographic distribution analysis and market mapping."
    - name: "avg_longitude"
      expr: AVG(CAST(longitude AS DOUBLE))
      comment: "Average longitude of restaurant locations. Used alongside avg_latitude for portfolio geographic centroid analysis and market coverage mapping."
$$;