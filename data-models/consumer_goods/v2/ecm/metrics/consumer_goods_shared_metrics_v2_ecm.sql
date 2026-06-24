-- Metric views for domain: shared | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-23 23:38:27

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`shared_region`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regional performance and demographic metrics for geographic analysis, market sizing, and strategic planning across territories."
  source: "`vibe_consumer_goods_v1`.`shared`.`region`"
  dimensions:
    - name: "Region Name"
      expr: region_name
      comment: "Name of the geographic region for grouping and filtering."
    - name: "Region Type"
      expr: region_type
      comment: "Classification of region (e.g., country, state, metro, district) for hierarchical analysis."
    - name: "Region Code"
      expr: region_code
      comment: "Standardized code identifier for the region."
    - name: "Hierarchy Level"
      expr: hierarchy_level
      comment: "Level in the regional hierarchy (e.g., L1=country, L2=state, L3=city) for roll-up analysis."
    - name: "Climate Zone"
      expr: climate_zone
      comment: "Climate classification of the region for seasonal demand planning and product assortment."
    - name: "ISO Country Code"
      expr: iso_country_code
      comment: "ISO country code for international reporting and compliance."
    - name: "Currency Code"
      expr: currency_code
      comment: "Primary currency used in the region for financial analysis."
    - name: "Time Zone"
      expr: time_zone
      comment: "Time zone of the region for operational scheduling and logistics."
    - name: "Region Status"
      expr: region_status
      comment: "Current operational status of the region (active, inactive, planned)."
    - name: "Is Cross Border"
      expr: is_cross_border
      comment: "Flag indicating if region spans multiple countries, affecting logistics and compliance."
    - name: "Primary Language"
      expr: primary_language
      comment: "Dominant language in the region for marketing and customer communication."
    - name: "Effective From Year"
      expr: YEAR(effective_from)
      comment: "Year the region definition became effective for trend analysis."
    - name: "Effective From Month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the region definition became effective for time-series analysis."
  measures:
    - name: "Total Regional GDP USD"
      expr: SUM(CAST(gdp_usd AS DOUBLE))
      comment: "Total gross domestic product across regions in USD, indicating market size and economic opportunity."
    - name: "Average Regional GDP USD"
      expr: AVG(CAST(gdp_usd AS DOUBLE))
      comment: "Average GDP per region in USD for market potential benchmarking."
    - name: "Total Population"
      expr: SUM(CAST(population AS BIGINT))
      comment: "Total population across regions for market sizing and demand forecasting."
    - name: "Average Population Per Region"
      expr: AVG(CAST(population AS DOUBLE))
      comment: "Average population per region for market density analysis."
    - name: "Total Area Sq Km"
      expr: SUM(CAST(area_sq_km AS DOUBLE))
      comment: "Total geographic area in square kilometers for logistics and distribution planning."
    - name: "Average Median Income USD"
      expr: AVG(CAST(median_income_usd AS DOUBLE))
      comment: "Average median household income across regions in USD for pricing strategy and product positioning."
    - name: "Average Urbanization Rate"
      expr: AVG(CAST(urbanization_rate AS DOUBLE))
      comment: "Average urbanization rate across regions for channel strategy and retail footprint planning."
    - name: "GDP Per Capita USD"
      expr: SUM(CAST(gdp_usd AS DOUBLE)) / NULLIF(SUM(CAST(population AS BIGINT)), 0)
      comment: "GDP per capita in USD, indicating purchasing power and market attractiveness for premium products."
    - name: "Population Density Per Sq Km"
      expr: SUM(CAST(population AS BIGINT)) / NULLIF(SUM(CAST(area_sq_km AS DOUBLE)), 0)
      comment: "Population density per square kilometer for distribution center placement and route optimization."
    - name: "Active Region Count"
      expr: COUNT(DISTINCT CASE WHEN region_status = 'active' THEN region_id END)
      comment: "Count of active regions for operational footprint tracking."
    - name: "Cross Border Region Count"
      expr: COUNT(DISTINCT CASE WHEN is_cross_border = true THEN region_id END)
      comment: "Count of cross-border regions requiring special logistics and compliance handling."
    - name: "Region Count"
      expr: COUNT(DISTINCT region_id)
      comment: "Total distinct regions for geographic coverage analysis."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`shared_country`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Country-level economic and demographic metrics for international market analysis, expansion planning, and regulatory compliance."
  source: "`vibe_consumer_goods_v1`.`shared`.`country`"
  dimensions:
    - name: "Country Name"
      expr: country_name
      comment: "Name of the country for grouping and filtering."
    - name: "ISO Alpha2 Code"
      expr: iso_alpha2_code
      comment: "Two-letter ISO country code for international standards compliance."
    - name: "ISO Alpha3 Code"
      expr: iso_alpha3_code
      comment: "Three-letter ISO country code for extended international reporting."
    - name: "Continent"
      expr: continent
      comment: "Continent classification for regional roll-up and strategic planning."
    - name: "Currency Code"
      expr: currency_code
      comment: "National currency code for financial reporting and pricing."
    - name: "Official Language"
      expr: official_language
      comment: "Official language for localization and marketing strategy."
    - name: "Is EU Member"
      expr: is_eu_member
      comment: "Flag indicating EU membership for regulatory and trade compliance."
    - name: "Is Active"
      expr: is_active
      comment: "Flag indicating if country is active in operational scope."
    - name: "Capital City"
      expr: capital_city
      comment: "Capital city for headquarters and distribution hub planning."
    - name: "Time Zone Offset"
      expr: time_zone_offset
      comment: "Time zone offset for operational coordination and customer service."
  measures:
    - name: "Total Country GDP USD"
      expr: SUM(CAST(gdp_usd AS DOUBLE))
      comment: "Total GDP across countries in USD for market opportunity assessment and investment prioritization."
    - name: "Average Country GDP USD"
      expr: AVG(CAST(gdp_usd AS DOUBLE))
      comment: "Average GDP per country in USD for market size benchmarking."
    - name: "Total Country Population"
      expr: SUM(CAST(population AS BIGINT))
      comment: "Total population across countries for addressable market sizing and demand forecasting."
    - name: "Average Country Population"
      expr: AVG(CAST(population AS DOUBLE))
      comment: "Average population per country for market scale analysis."
    - name: "GDP Per Capita USD"
      expr: SUM(CAST(gdp_usd AS DOUBLE)) / NULLIF(SUM(CAST(population AS BIGINT)), 0)
      comment: "GDP per capita in USD, indicating consumer purchasing power and premium product viability."
    - name: "Active Country Count"
      expr: COUNT(DISTINCT CASE WHEN is_active = true THEN country_id END)
      comment: "Count of active countries in operational footprint for market coverage tracking."
    - name: "EU Member Country Count"
      expr: COUNT(DISTINCT CASE WHEN is_eu_member = true THEN country_id END)
      comment: "Count of EU member countries for regulatory harmonization and trade strategy."
    - name: "Country Count"
      expr: COUNT(DISTINCT country_id)
      comment: "Total distinct countries for international presence measurement."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`shared_currency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Currency exchange rate and volatility metrics for financial planning, pricing strategy, and foreign exchange risk management."
  source: "`vibe_consumer_goods_v1`.`shared`.`currency`"
  dimensions:
    - name: "Currency Code"
      expr: currency_code
      comment: "ISO currency code for grouping and filtering."
    - name: "Currency Name"
      expr: currency_name
      comment: "Full name of the currency for reporting."
    - name: "Currency Symbol"
      expr: symbol
      comment: "Currency symbol for display and formatting."
    - name: "Is Active"
      expr: is_active
      comment: "Flag indicating if currency is actively used in transactions."
    - name: "Decimal Places"
      expr: decimal_places
      comment: "Number of decimal places for precision in financial calculations."
    - name: "Rate Effective Year"
      expr: YEAR(rate_effective_date)
      comment: "Year the exchange rate became effective for trend analysis."
    - name: "Rate Effective Month"
      expr: DATE_TRUNC('MONTH', rate_effective_date)
      comment: "Month the exchange rate became effective for time-series analysis."
  measures:
    - name: "Average Exchange Rate To USD"
      expr: AVG(CAST(exchange_rate_to_usd AS DOUBLE))
      comment: "Average exchange rate to USD for financial consolidation and reporting."
    - name: "Min Exchange Rate To USD"
      expr: MIN(CAST(exchange_rate_to_usd AS DOUBLE))
      comment: "Minimum exchange rate to USD for best-case scenario planning and hedging strategy."
    - name: "Max Exchange Rate To USD"
      expr: MAX(CAST(exchange_rate_to_usd AS DOUBLE))
      comment: "Maximum exchange rate to USD for worst-case scenario planning and risk assessment."
    - name: "Active Currency Count"
      expr: COUNT(DISTINCT CASE WHEN is_active = true THEN currency_id END)
      comment: "Count of active currencies for treasury operations complexity measurement."
    - name: "Currency Count"
      expr: COUNT(DISTINCT currency_id)
      comment: "Total distinct currencies for multi-currency operations scope."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`shared_calendar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Calendar and business day metrics for operational planning, workforce scheduling, and time-series analysis."
  source: "`vibe_consumer_goods_v1`.`shared`.`calendar`"
  dimensions:
    - name: "Calendar Date"
      expr: calendar_date
      comment: "Specific calendar date for daily analysis."
    - name: "Fiscal Year"
      expr: fiscal_year
      comment: "Fiscal year for financial reporting and planning cycles."
    - name: "Fiscal Quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for quarterly business reviews and forecasting."
    - name: "Fiscal Period"
      expr: fiscal_period
      comment: "Fiscal period (month) for monthly performance tracking."
    - name: "Fiscal Week"
      expr: fiscal_week
      comment: "Fiscal week for weekly operational metrics."
    - name: "Calendar Year"
      expr: year
      comment: "Calendar year for year-over-year comparisons."
    - name: "Calendar Month"
      expr: month
      comment: "Calendar month for monthly trend analysis."
    - name: "Calendar Week"
      expr: week
      comment: "Calendar week for weekly reporting."
    - name: "Day Of Week"
      expr: day_of_week
      comment: "Day of the week for day-of-week pattern analysis."
    - name: "Season"
      expr: season
      comment: "Season classification for seasonal demand planning and inventory management."
    - name: "Is Business Day"
      expr: is_business_day
      comment: "Flag indicating if date is a business day for operational capacity planning."
    - name: "Is Holiday"
      expr: is_holiday
      comment: "Flag indicating if date is a holiday for workforce and logistics planning."
    - name: "Holiday Name"
      expr: holiday_name
      comment: "Name of the holiday for promotional planning and staffing."
  measures:
    - name: "Total Business Days"
      expr: COUNT(DISTINCT CASE WHEN is_business_day = true THEN calendar_date END)
      comment: "Total business days for operational capacity and productivity calculations."
    - name: "Total Holiday Days"
      expr: COUNT(DISTINCT CASE WHEN is_holiday = true THEN calendar_date END)
      comment: "Total holiday days for workforce planning and promotional calendar alignment."
    - name: "Total Calendar Days"
      expr: COUNT(DISTINCT calendar_date)
      comment: "Total calendar days for time-period normalization."
    - name: "Business Day Percentage"
      expr: 100.0 * COUNT(DISTINCT CASE WHEN is_business_day = true THEN calendar_date END) / NULLIF(COUNT(DISTINCT calendar_date), 0)
      comment: "Percentage of days that are business days for operational efficiency benchmarking."
    - name: "Holiday Percentage"
      expr: 100.0 * COUNT(DISTINCT CASE WHEN is_holiday = true THEN calendar_date END) / NULLIF(COUNT(DISTINCT calendar_date), 0)
      comment: "Percentage of days that are holidays for staffing and logistics impact assessment."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`shared_unit_of_measure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Unit of measure standardization and conversion metrics for inventory management, procurement, and supply chain operations."
  source: "`vibe_consumer_goods_v1`.`shared`.`unit_of_measure`"
  dimensions:
    - name: "UOM Code"
      expr: uom_code
      comment: "Unit of measure code for grouping and filtering."
    - name: "UOM Name"
      expr: uom_name
      comment: "Full name of the unit of measure for reporting."
    - name: "UOM Category"
      expr: uom_category
      comment: "Category of unit (e.g., weight, volume, length, count) for classification."
    - name: "Base UOM Code"
      expr: base_uom_code
      comment: "Base unit of measure for conversion calculations."
    - name: "ISO Code"
      expr: iso_code
      comment: "ISO standard code for international compliance."
    - name: "Is Active"
      expr: is_active
      comment: "Flag indicating if UOM is actively used in operations."
  measures:
    - name: "Average Conversion Factor"
      expr: AVG(CAST(conversion_factor AS DOUBLE))
      comment: "Average conversion factor to base unit for standardization analysis."
    - name: "Min Conversion Factor"
      expr: MIN(CAST(conversion_factor AS DOUBLE))
      comment: "Minimum conversion factor for smallest unit identification."
    - name: "Max Conversion Factor"
      expr: MAX(CAST(conversion_factor AS DOUBLE))
      comment: "Maximum conversion factor for largest unit identification."
    - name: "Active UOM Count"
      expr: COUNT(DISTINCT CASE WHEN is_active = true THEN unit_of_measure_id END)
      comment: "Count of active units of measure for operational complexity measurement."
    - name: "UOM Count"
      expr: COUNT(DISTINCT unit_of_measure_id)
      comment: "Total distinct units of measure for standardization scope."
$$;