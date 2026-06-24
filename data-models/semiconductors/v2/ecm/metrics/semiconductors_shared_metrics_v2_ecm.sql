-- Metric views for domain: shared | Business: Semiconductors | Version: 2 | Generated on: 2026-06-23 23:34:49

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`shared_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for semiconductor manufacturing site portfolio — capacity, operational status, workforce density, and geographic footprint used by Real Estate, Operations, and Executive leadership to steer site investment and consolidation decisions."
  source: "`vibe_semiconductors_v1`.`shared`.`site`"
  dimensions:
    - name: "site_type"
      expr: site_type
      comment: "Classification of the site (e.g., fab, design center, test facility, office) for portfolio segmentation."
    - name: "site_status"
      expr: site_status
      comment: "Operational status of the site (e.g., active, under construction, decommissioned) for filtering live vs. inactive sites."
    - name: "country_code"
      expr: country_code
      comment: "ISO country code enabling geographic rollup of site metrics for regional capacity and risk analysis."
    - name: "region"
      expr: region
      comment: "Geographic region (e.g., APAC, EMEA, Americas) for regional portfolio dashboards."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory and environmental compliance status of the site, used for risk and audit reporting."
    - name: "environmental_certification"
      expr: environmental_certification
      comment: "Environmental certification held by the site (e.g., ISO 14001, LEED) for ESG reporting."
    - name: "security_classification"
      expr: security_classification
      comment: "Security clearance level of the site, relevant for export-control and government-contract compliance."
    - name: "data_center_flag"
      expr: data_center_flag
      comment: "Boolean flag indicating whether the site hosts a data center, used to segment IT infrastructure footprint."
  measures:
    - name: "total_sites"
      expr: COUNT(1)
      comment: "Total number of sites in the portfolio. Baseline KPI for site footprint tracking used in executive real-estate reviews."
    - name: "active_sites"
      expr: COUNT(CASE WHEN site_status = 'active' THEN 1 END)
      comment: "Count of operationally active sites. Drives capacity planning and consolidation decisions."
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total physical footprint in square feet across all sites. Used for real-estate cost allocation and capacity benchmarking."
    - name: "avg_square_footage_per_site"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average site size in square feet. Benchmarks site scale and informs expansion vs. consolidation strategy."
    - name: "total_power_capacity_kw"
      expr: SUM(CAST(power_capacity_kw AS DOUBLE))
      comment: "Aggregate power capacity in kilowatts across all sites. Critical for energy planning, sustainability targets, and fab expansion feasibility."
    - name: "avg_power_capacity_kw"
      expr: AVG(CAST(power_capacity_kw AS DOUBLE))
      comment: "Average power capacity per site in kilowatts. Used to identify under- or over-provisioned sites relative to operational needs."
    - name: "compliant_site_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sites with compliant regulatory status. A leading risk indicator monitored by Legal, EHS, and the CFO for regulatory exposure."
    - name: "sites_with_environmental_cert"
      expr: COUNT(CASE WHEN environmental_certification IS NOT NULL THEN 1 END)
      comment: "Number of sites holding an environmental certification. Tracks ESG commitment progress reported to the board and investors."
    - name: "distinct_countries"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of distinct countries where sites operate. Measures geographic diversification and geopolitical risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`shared_fab`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and sustainability KPIs for the semiconductor fab portfolio — capacity, energy consumption, water usage, carbon footprint, and audit performance used by Fab Operations, Sustainability, and Executive leadership to steer fab investment and ESG strategy."
  source: "`vibe_semiconductors_v1`.`shared`.`fab`"
  dimensions:
    - name: "fab_type"
      expr: fab_type
      comment: "Type of fab (e.g., logic, memory, analog, foundry) for portfolio segmentation and capacity analysis."
    - name: "fab_status"
      expr: fab_status
      comment: "Operational status of the fab (e.g., active, ramping, idle, decommissioned) for filtering live vs. inactive fabs."
    - name: "technology_node_nm"
      expr: technology_node_nm
      comment: "Technology node in nanometers (e.g., 5nm, 7nm, 28nm) for node-level capacity and yield benchmarking."
    - name: "owner_company"
      expr: owner_company
      comment: "Legal entity or company owning the fab, used for intercompany cost allocation and consolidation reporting."
    - name: "primary_product_family"
      expr: primary_product_family
      comment: "Primary product family manufactured at the fab (e.g., microprocessors, power ICs) for demand-supply alignment."
    - name: "environmental_compliance_status"
      expr: environmental_compliance_status
      comment: "Environmental compliance status of the fab for EHS and regulatory risk dashboards."
    - name: "is_critical_facility"
      expr: is_critical_facility
      comment: "Boolean flag indicating whether the fab is designated a critical facility, used for business continuity prioritization."
    - name: "security_clearance_level"
      expr: security_clearance_level
      comment: "Security clearance level of the fab, relevant for government contracts and export-control compliance."
  measures:
    - name: "total_fabs"
      expr: COUNT(1)
      comment: "Total number of fabs in the portfolio. Baseline KPI for fab footprint tracking used in executive capacity reviews."
    - name: "active_fabs"
      expr: COUNT(CASE WHEN fab_status = 'active' THEN 1 END)
      comment: "Count of operationally active fabs. Drives capacity planning and capital allocation decisions."
    - name: "total_annual_power_mwh"
      expr: SUM(CAST(annual_power_mwh AS DOUBLE))
      comment: "Total annual power consumption in megawatt-hours across all fabs. Core sustainability KPI for energy cost management and carbon reduction targets."
    - name: "avg_annual_power_mwh"
      expr: AVG(CAST(annual_power_mwh AS DOUBLE))
      comment: "Average annual power consumption per fab in MWh. Benchmarks energy efficiency across the fab portfolio."
    - name: "total_annual_water_m3"
      expr: SUM(CAST(annual_water_m3 AS DOUBLE))
      comment: "Total annual water consumption in cubic meters across all fabs. Critical ESG and operational KPI given semiconductor fabs' high water intensity."
    - name: "avg_annual_water_m3"
      expr: AVG(CAST(annual_water_m3 AS DOUBLE))
      comment: "Average annual water consumption per fab in cubic meters. Used to identify water-intensive fabs and drive conservation initiatives."
    - name: "total_carbon_footprint_tons"
      expr: SUM(CAST(carbon_footprint_tons AS DOUBLE))
      comment: "Total carbon footprint in metric tons CO2-equivalent across all fabs. Board-level ESG KPI tied to net-zero commitments and regulatory disclosure."
    - name: "avg_carbon_footprint_tons"
      expr: AVG(CAST(carbon_footprint_tons AS DOUBLE))
      comment: "Average carbon footprint per fab in metric tons. Identifies highest-emitting fabs for targeted decarbonization investment."
    - name: "total_area_sqft"
      expr: SUM(CAST(total_area_sqft AS DOUBLE))
      comment: "Total physical area of all fabs in square feet. Used for real-estate cost allocation and capacity density benchmarking."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score across all fabs. Tracks compliance and operational quality; a declining score triggers corrective action programs."
    - name: "environmentally_compliant_fab_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN environmental_compliance_status = 'compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of fabs with compliant environmental status. Leading risk indicator for EHS, Legal, and CFO regulatory exposure reporting."
    - name: "critical_facility_count"
      expr: COUNT(CASE WHEN is_critical_facility = TRUE THEN 1 END)
      comment: "Number of fabs designated as critical facilities. Used in business continuity planning and insurance risk assessments."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`shared_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical location portfolio KPIs — footprint, capacity, and geographic distribution used by Real Estate, Operations, and Finance for cost allocation, capacity planning, and site rationalization decisions."
  source: "`vibe_semiconductors_v1`.`shared`.`location`"
  dimensions:
    - name: "location_type"
      expr: location_type
      comment: "Type of location (e.g., fab, office, warehouse, test floor) for portfolio segmentation."
    - name: "location_status"
      expr: location_status
      comment: "Operational status of the location (e.g., active, closed, under construction) for filtering live vs. inactive locations."
    - name: "country_code"
      expr: country_code
      comment: "ISO country code for geographic rollup of location metrics."
    - name: "region"
      expr: region
      comment: "Geographic region for regional portfolio and cost dashboards."
    - name: "city"
      expr: city
      comment: "City where the location resides, enabling city-level capacity and workforce analysis."
    - name: "timezone"
      expr: timezone
      comment: "Timezone of the location, used for operational scheduling and shift planning across global sites."
  measures:
    - name: "total_locations"
      expr: COUNT(1)
      comment: "Total number of physical locations in the enterprise portfolio. Baseline KPI for real-estate footprint management."
    - name: "active_locations"
      expr: COUNT(CASE WHEN location_status = 'active' THEN 1 END)
      comment: "Count of operationally active locations. Drives capacity planning and lease management decisions."
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total physical footprint in square feet across all locations. Core real-estate KPI for cost-per-sqft and space utilization analysis."
    - name: "avg_square_footage_per_location"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average location size in square feet. Benchmarks location scale and informs consolidation vs. expansion strategy."
    - name: "total_daily_capacity"
      expr: SUM(CAST(capacity_per_day AS DOUBLE))
      comment: "Aggregate daily throughput capacity across all locations. Used by Supply Chain and Operations to assess network-wide production capacity."
    - name: "avg_daily_capacity_per_location"
      expr: AVG(CAST(capacity_per_day AS DOUBLE))
      comment: "Average daily capacity per location. Identifies under-utilized or over-loaded locations for rebalancing."
    - name: "distinct_countries"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of distinct countries with physical locations. Measures geographic diversification and geopolitical risk exposure."
    - name: "active_location_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN location_status = 'active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of locations that are operationally active. Tracks portfolio utilization efficiency and flags idle real-estate for rationalization."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`shared_currency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Currency reference and exchange-rate KPIs used by Finance, Treasury, and FP&A to monitor multi-currency exposure, exchange-rate coverage, and budget estimation accuracy across the global semiconductor enterprise."
  source: "`vibe_semiconductors_v1`.`shared`.`currency`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "ISO 4217 currency code (e.g., USD, EUR, JPY) for currency-level analysis."
    - name: "country_code"
      expr: country_code
      comment: "ISO country code associated with the currency for geographic exposure analysis."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the currency is currently active in the system, used to filter valid vs. deprecated currencies."
    - name: "exchange_rate_date"
      expr: exchange_rate_date
      comment: "Date of the exchange rate record, enabling time-series analysis of FX rate movements."
  measures:
    - name: "active_currency_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of active currencies in the enterprise system. Tracks multi-currency operational scope for Treasury and Finance."
    - name: "avg_exchange_rate_to_usd"
      expr: AVG(CAST(exchange_rate_to_usd AS DOUBLE))
      comment: "Average exchange rate to USD across all active currency records. Used by Treasury to monitor blended FX exposure and hedging effectiveness."
    - name: "max_exchange_rate_to_usd"
      expr: MAX(exchange_rate_to_usd)
      comment: "Maximum exchange rate to USD observed. Identifies currencies with extreme FX volatility relevant to risk management."
    - name: "min_exchange_rate_to_usd"
      expr: MIN(exchange_rate_to_usd)
      comment: "Minimum exchange rate to USD observed. Used alongside max to compute FX rate range for volatility assessment."
    - name: "total_estimated_budget_amount"
      expr: SUM(CAST(estimated_budget_amount AS DOUBLE))
      comment: "Total estimated budget amount across all currency records. Provides a consolidated view of multi-currency budget exposure for FP&A consolidation."
    - name: "avg_estimated_budget_amount"
      expr: AVG(CAST(estimated_budget_amount AS DOUBLE))
      comment: "Average estimated budget amount per currency record. Benchmarks budget allocation across currency zones for Finance planning."
    - name: "distinct_active_currencies"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN currency_code END)
      comment: "Number of distinct active currency codes. Measures the breadth of multi-currency operations and FX hedging requirements."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`shared_calendar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enterprise calendar KPIs used by Operations, Supply Chain, and HR to monitor working-day coverage, calendar activation rates, and scheduling completeness across global semiconductor manufacturing sites."
  source: "`vibe_semiconductors_v1`.`shared`.`calendar`"
  dimensions:
    - name: "calendar_type"
      expr: calendar_type
      comment: "Type of calendar (e.g., manufacturing, fiscal, shipping) for segmenting scheduling and planning calendars."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the calendar is currently active, used to filter valid scheduling calendars."
    - name: "timezone"
      expr: timezone
      comment: "Timezone associated with the calendar, enabling time-zone-aware scheduling analysis across global sites."
    - name: "year"
      expr: year
      comment: "Calendar year for year-over-year scheduling and capacity trend analysis."
    - name: "working_days_per_week"
      expr: working_days_per_week
      comment: "Number of working days per week configured for the calendar, used to assess shift and production scheduling intensity."
  measures:
    - name: "total_calendars"
      expr: COUNT(1)
      comment: "Total number of calendar records in the system. Baseline KPI for calendar governance and completeness audits."
    - name: "active_calendars"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active calendars. Ensures sufficient scheduling coverage across all manufacturing and logistics operations."
    - name: "active_calendar_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_active = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of calendars that are active. Tracks calendar governance health; a low rate signals stale or orphaned calendar records."
    - name: "distinct_timezones_covered"
      expr: COUNT(DISTINCT timezone)
      comment: "Number of distinct timezones covered by active calendars. Measures global scheduling completeness for 24/7 semiconductor operations."
    - name: "distinct_calendar_types"
      expr: COUNT(DISTINCT calendar_type)
      comment: "Number of distinct calendar types configured. Ensures all scheduling domains (manufacturing, fiscal, shipping) have dedicated calendar coverage."
    - name: "distinct_sites_with_calendars"
      expr: COUNT(DISTINCT site_id)
      comment: "Number of distinct sites that have at least one calendar assigned. Identifies sites lacking scheduling configuration, which is a production risk."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`shared_unit_of_measure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Unit-of-measure governance KPIs used by Data Governance, Supply Chain, and Manufacturing to ensure measurement standardization, ISO compliance, and conversion-factor completeness across the semiconductor enterprise."
  source: "`vibe_semiconductors_v1`.`shared`.`unit_of_measure`"
  dimensions:
    - name: "uom_category"
      expr: uom_category
      comment: "Category of the unit of measure (e.g., length, mass, volume, time) for domain-level governance analysis."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the UOM is currently active, used to filter valid vs. deprecated units."
    - name: "iso_standard"
      expr: iso_standard
      comment: "ISO standard governing the unit of measure (e.g., SI, ISO 80000) for compliance and interoperability reporting."
    - name: "base_uom_code"
      expr: base_uom_code
      comment: "Base unit code to which this UOM converts, enabling conversion-chain analysis and data quality checks."
  measures:
    - name: "total_uom_count"
      expr: COUNT(1)
      comment: "Total number of unit-of-measure records. Baseline KPI for UOM catalog governance and proliferation control."
    - name: "active_uom_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of active units of measure. Ensures the active UOM catalog is sufficient for all operational measurement needs."
    - name: "active_uom_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_active = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of UOM records that are active. Tracks catalog hygiene; a high inactive rate signals UOM proliferation and data quality risk."
    - name: "avg_conversion_factor_to_base"
      expr: AVG(CAST(conversion_factor_to_base AS DOUBLE))
      comment: "Average conversion factor to base unit across all UOM records. Used by Data Governance to detect anomalous conversion factors that could corrupt measurement calculations."
    - name: "distinct_uom_categories"
      expr: COUNT(DISTINCT uom_category)
      comment: "Number of distinct UOM categories covered. Ensures measurement completeness across all physical and business dimensions used in semiconductor manufacturing."
    - name: "iso_compliant_uom_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN iso_standard IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of UOM records with an ISO standard assigned. Tracks measurement standardization compliance, critical for cross-site and cross-customer interoperability."
$$;