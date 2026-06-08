-- Metric views for domain: store | Business: Retail | Version: 1 | Generated on: 2026-05-04 13:23:00

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`store_pl`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store Profit & Loss performance metrics providing executive-level visibility into revenue, margin, cost efficiency, and comparable-store growth across locations and financial periods."
  source: "`retail_ecm`.`store`.`pl`"
  dimensions:
    - name: "location_id"
      expr: location_id
      comment: "Foreign key to store location — enables per-store P&L slicing."
    - name: "financial_period_id"
      expr: financial_period_id
      comment: "Foreign key to financial period — enables period-over-period trending."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency reporting normalization."
    - name: "pl_status"
      expr: pl_status
      comment: "Status of the P&L record (e.g., Draft, Finalized) — filters to authoritative data."
    - name: "comp_sales_flag"
      expr: comp_sales_flag
      comment: "Boolean flag indicating whether the store qualifies as a comparable store for comp-sales analysis."
    - name: "reporting_entity"
      expr: reporting_entity
      comment: "Legal or organizational reporting entity — supports segment and banner-level roll-ups."
    - name: "period_start_date"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Month-truncated period start date for time-series aggregation."
    - name: "period_end_date"
      expr: DATE_TRUNC('month', period_end_date)
      comment: "Month-truncated period end date for time-series aggregation."
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Foreign key to profit center — enables financial hierarchy roll-ups."
    - name: "promo_campaign_id"
      expr: promo_campaign_id
      comment: "Foreign key to promotional campaign — isolates P&L impact of promotions."
  measures:
    - name: "total_gross_sales"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales revenue before returns and discounts. Core top-line KPI for store performance reviews."
    - name: "total_net_sales"
      expr: SUM(CAST(net_sales_amount AS DOUBLE))
      comment: "Total net sales after returns and discounts. Primary revenue measure used in executive dashboards and comp-store analysis."
    - name: "total_gross_margin"
      expr: SUM(CAST(gross_margin_amount AS DOUBLE))
      comment: "Total gross margin dollars. Directly measures merchandising profitability and drives pricing and assortment decisions."
    - name: "avg_gross_margin_percent"
      expr: AVG(CAST(gross_margin_percent AS DOUBLE))
      comment: "Average gross margin percentage across P&L records. Tracks margin health and triggers investigation when below target thresholds."
    - name: "total_ebitda"
      expr: SUM(CAST(ebitda_amount AS DOUBLE))
      comment: "Total EBITDA — key profitability metric used in board-level financial reviews and store investment decisions."
    - name: "avg_ebitda_percent"
      expr: AVG(CAST(ebitda_percent AS DOUBLE))
      comment: "Average EBITDA margin percentage. Signals operational efficiency and is a primary metric for store portfolio management."
    - name: "total_cogs"
      expr: SUM(CAST(cogs_amount AS DOUBLE))
      comment: "Total cost of goods sold. Drives gross margin analysis and supplier negotiation decisions."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost. One of the largest controllable expense lines; monitored against sales targets for labor efficiency."
    - name: "total_shrinkage"
      expr: SUM(CAST(shrinkage_amount AS DOUBLE))
      comment: "Total shrinkage expense. Directly impacts margin and triggers loss-prevention interventions when elevated."
    - name: "total_occupancy_cost"
      expr: SUM(CAST(occupancy_cost_amount AS DOUBLE))
      comment: "Total occupancy cost (rent, utilities, etc.). Key fixed-cost driver used in store profitability and lease renewal decisions."
    - name: "total_operating_expense"
      expr: SUM(CAST(total_operating_expense_amount AS DOUBLE))
      comment: "Total operating expenses. Aggregate cost base used to compute operating leverage and efficiency ratios."
    - name: "total_returns"
      expr: SUM(CAST(returns_amount AS DOUBLE))
      comment: "Total returns value. Elevated returns signal product quality or customer experience issues requiring action."
    - name: "total_discounts"
      expr: SUM(CAST(discounts_amount AS DOUBLE))
      comment: "Total discounts granted. Tracks promotional spend and margin erosion from markdowns."
    - name: "total_marketing_expense"
      expr: SUM(CAST(marketing_expense_amount AS DOUBLE))
      comment: "Total marketing expense. Measured against sales lift to evaluate marketing ROI."
    - name: "total_units_sold"
      expr: SUM(CAST(units_sold AS DOUBLE))
      comment: "Total units sold. Volume KPI used alongside revenue to compute average selling price and track sell-through."
    - name: "total_transaction_count"
      expr: SUM(CAST(transaction_count AS DOUBLE))
      comment: "Total number of transactions. Baseline volume metric for traffic conversion and basket analysis."
    - name: "avg_transaction_value"
      expr: AVG(CAST(atv_amount AS DOUBLE))
      comment: "Average transaction value (ATV). Key basket-size KPI; decline triggers promotional or assortment interventions."
    - name: "avg_units_per_transaction"
      expr: AVG(CAST(upt AS DOUBLE))
      comment: "Average units per transaction (UPT). Measures cross-sell effectiveness and basket depth."
    - name: "avg_comp_sales_growth_percent"
      expr: AVG(CAST(comp_sales_growth_percent AS DOUBLE))
      comment: "Average comparable-store sales growth percentage. The primary same-store performance metric used in investor and board reporting."
    - name: "labor_cost_to_net_sales_ratio"
      expr: ROUND(100.0 * SUM(CAST(labor_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_sales_amount AS DOUBLE)), 0), 2)
      comment: "Labor cost as a percentage of net sales. Operational efficiency ratio; high values trigger staffing model reviews."
    - name: "shrinkage_to_net_sales_ratio"
      expr: ROUND(100.0 * SUM(CAST(shrinkage_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_sales_amount AS DOUBLE)), 0), 2)
      comment: "Shrinkage as a percentage of net sales. Loss-prevention KPI; elevated ratio triggers audit and security interventions."
    - name: "returns_to_gross_sales_ratio"
      expr: ROUND(100.0 * SUM(CAST(returns_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_sales_amount AS DOUBLE)), 0), 2)
      comment: "Returns as a percentage of gross sales. Tracks product quality and customer satisfaction; high ratio triggers category reviews."
    - name: "discount_to_gross_sales_ratio"
      expr: ROUND(100.0 * SUM(CAST(discounts_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_sales_amount AS DOUBLE)), 0), 2)
      comment: "Discounts as a percentage of gross sales. Measures promotional intensity and margin erosion risk."
    - name: "operating_expense_to_net_sales_ratio"
      expr: ROUND(100.0 * SUM(CAST(total_operating_expense_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_sales_amount AS DOUBLE)), 0), 2)
      comment: "Total operating expense as a percentage of net sales. Measures overall cost efficiency; drives cost reduction programs."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`store_shrinkage_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store shrinkage and loss-prevention metrics providing visibility into inventory loss by type, location, department, and responsible party to drive LP strategy and financial recovery."
  source: "`retail_ecm`.`store`.`shrinkage_event`"
  dimensions:
    - name: "location_id"
      expr: location_id
      comment: "Store location where the shrinkage event occurred — primary dimension for geographic loss analysis."
    - name: "department_id"
      expr: department_id
      comment: "Department where shrinkage occurred — enables category-level loss analysis."
    - name: "shrinkage_type"
      expr: shrinkage_type
      comment: "Type of shrinkage (e.g., theft, administrative error, vendor fraud, damage) — drives targeted LP interventions."
    - name: "responsible_party_type"
      expr: responsible_party_type
      comment: "Party responsible for the shrinkage (e.g., employee, external, vendor) — informs HR and vendor management actions."
    - name: "detection_method"
      expr: detection_method
      comment: "How the shrinkage was detected (e.g., cycle count, camera, audit) — evaluates detection program effectiveness."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the shrinkage event — tracks case closure rates."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the shrinkage event — enables period-over-period loss trending."
    - name: "event_date"
      expr: DATE_TRUNC('month', event_date)
      comment: "Month-truncated event date for time-series shrinkage trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency loss reporting."
    - name: "incident_report_filed"
      expr: incident_report_filed
      comment: "Whether a formal incident report was filed — tracks compliance with LP reporting procedures."
    - name: "zone_location"
      expr: zone_location
      comment: "Zone within the store where shrinkage occurred — enables hot-spot analysis for LP resource deployment."
  measures:
    - name: "total_retail_value_lost"
      expr: SUM(CAST(total_retail_value_lost AS DOUBLE))
      comment: "Total retail value of inventory lost to shrinkage. Primary financial impact KPI for loss-prevention programs."
    - name: "total_cost_value_lost"
      expr: SUM(CAST(cost_value_lost AS DOUBLE))
      comment: "Total cost value of inventory lost. Used for P&L impact assessment and insurance claims."
    - name: "total_quantity_lost"
      expr: SUM(CAST(quantity_lost AS DOUBLE))
      comment: "Total units lost to shrinkage. Volume metric for inventory accuracy and replenishment planning."
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total value recovered from shrinkage events (e.g., insurance, restitution). Measures LP program financial effectiveness."
    - name: "shrinkage_event_count"
      expr: COUNT(1)
      comment: "Total number of shrinkage events recorded. Frequency KPI for loss-prevention trend monitoring."
    - name: "distinct_location_count"
      expr: COUNT(DISTINCT location_id)
      comment: "Number of distinct store locations with shrinkage events. Identifies breadth of loss exposure across the estate."
    - name: "avg_retail_value_per_event"
      expr: AVG(CAST(total_retail_value_lost AS DOUBLE))
      comment: "Average retail value lost per shrinkage event. Tracks severity trend; rising average signals escalating theft or damage incidents."
    - name: "avg_unit_retail_value"
      expr: AVG(CAST(unit_retail_value AS DOUBLE))
      comment: "Average retail value per unit lost. Indicates whether high-value items are disproportionately targeted."
    - name: "net_loss_after_recovery"
      expr: ROUND(SUM(CAST(total_retail_value_lost AS DOUBLE)) - SUM(CAST(recovery_amount AS DOUBLE)), 2)
      comment: "Net financial loss after recovery amounts. True economic cost of shrinkage; drives LP budget and investment decisions."
    - name: "recovery_rate_percent"
      expr: ROUND(100.0 * SUM(CAST(recovery_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_retail_value_lost AS DOUBLE)), 0), 2)
      comment: "Percentage of retail value lost that was recovered. Measures LP program recovery effectiveness; low rate triggers process review."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`store_traffic_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store traffic and conversion metrics providing visibility into customer footfall, dwell time, conversion rates, and peak occupancy to drive staffing, layout, and promotional decisions."
  source: "`retail_ecm`.`store`.`traffic_count`"
  dimensions:
    - name: "location_id"
      expr: location_id
      comment: "Store location — primary dimension for comparing traffic performance across the estate."
    - name: "department_id"
      expr: department_id
      comment: "Department within the store — enables zone-level traffic analysis."
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week — identifies weekly traffic patterns for staffing optimization."
    - name: "hour_of_day"
      expr: hour_of_day
      comment: "Hour of day — enables intraday traffic analysis for labor scheduling."
    - name: "is_holiday"
      expr: is_holiday
      comment: "Holiday flag — isolates holiday traffic lift for event planning and inventory positioning."
    - name: "is_promotional_event"
      expr: is_promotional_event
      comment: "Promotional event flag — measures traffic lift attributable to promotions."
    - name: "is_store_open"
      expr: is_store_open
      comment: "Store open flag — filters to valid trading hours for accurate conversion analysis."
    - name: "sensor_type"
      expr: sensor_type
      comment: "Type of traffic counting sensor — used to segment data quality and calibration status."
    - name: "zone_type"
      expr: zone_type
      comment: "Zone type (e.g., entrance, department, checkout) — enables zone-level footfall analysis."
    - name: "weather_condition_code"
      expr: weather_condition_code
      comment: "Weather condition code — quantifies weather impact on store traffic for demand forecasting."
    - name: "measurement_timestamp"
      expr: DATE_TRUNC('day', measurement_timestamp)
      comment: "Day-truncated measurement timestamp for daily traffic trend analysis."
    - name: "promo_campaign_id"
      expr: promo_campaign_id
      comment: "Promotional campaign associated with the traffic measurement — enables campaign-level traffic attribution."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality indicator — used to filter or weight traffic records in analysis."
  measures:
    - name: "avg_conversion_rate_percent"
      expr: AVG(CAST(conversion_rate_percent AS DOUBLE))
      comment: "Average traffic-to-transaction conversion rate. Primary store effectiveness KPI; decline triggers layout, staffing, or assortment interventions."
    - name: "avg_dwell_time_minutes"
      expr: AVG(CAST(average_dwell_time_minutes AS DOUBLE))
      comment: "Average customer dwell time in minutes. Longer dwell correlates with higher basket size; used to evaluate store layout and engagement."
    - name: "avg_accuracy_confidence_percent"
      expr: AVG(CAST(accuracy_confidence_percent AS DOUBLE))
      comment: "Average sensor accuracy confidence percentage. Monitors data quality of traffic counting infrastructure."
    - name: "avg_temperature_fahrenheit"
      expr: AVG(CAST(temperature_fahrenheit AS DOUBLE))
      comment: "Average in-store or ambient temperature during measurement periods. Supports environmental analysis of traffic patterns."
    - name: "traffic_measurement_count"
      expr: COUNT(1)
      comment: "Total number of traffic measurement records. Baseline count for data completeness and coverage monitoring."
    - name: "distinct_location_count"
      expr: COUNT(DISTINCT location_id)
      comment: "Number of distinct store locations with traffic data. Measures coverage of the traffic counting program."
    - name: "promotional_traffic_measurement_count"
      expr: COUNT(CASE WHEN is_promotional_event = TRUE THEN 1 END)
      comment: "Number of traffic measurements taken during promotional events. Used to isolate and compare promotional vs. baseline traffic."
    - name: "holiday_traffic_measurement_count"
      expr: COUNT(CASE WHEN is_holiday = TRUE THEN 1 END)
      comment: "Number of traffic measurements taken on holidays. Supports holiday staffing and inventory planning."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`store_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store estate and capability metrics providing visibility into the physical footprint, omnichannel readiness, and geographic distribution of the store network to support portfolio strategy and capital allocation."
  source: "`retail_ecm`.`store`.`location`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Store lifecycle status (e.g., Open, Closed, Under Renovation) — primary filter for active estate analysis."
    - name: "banner_brand"
      expr: banner_brand
      comment: "Retail banner or brand — enables banner-level portfolio performance comparison."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region code — supports regional performance and investment allocation analysis."
    - name: "district_code"
      expr: district_code
      comment: "District code — enables district-level operational management and benchmarking."
    - name: "state_province"
      expr: state_province
      comment: "State or province — supports regulatory compliance and geographic market analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country code — enables international portfolio segmentation."
    - name: "format_size_band"
      expr: format_size_band
      comment: "Store size band (e.g., Small, Medium, Large) — used to benchmark performance within comparable format tiers."
    - name: "staffing_model_type"
      expr: staffing_model_type
      comment: "Staffing model type — supports labor efficiency benchmarking across store types."
    - name: "climate_zone"
      expr: climate_zone
      comment: "Climate zone — used for seasonal assortment planning and energy cost analysis."
    - name: "bopis_capable"
      expr: bopis_capable
      comment: "Buy Online Pick Up In Store capability flag — segments omnichannel-enabled stores for fulfillment strategy."
    - name: "sfs_capable"
      expr: sfs_capable
      comment: "Ship From Store capability flag — identifies stores contributing to e-commerce fulfillment network."
    - name: "ropis_capable"
      expr: ropis_capable
      comment: "Reserve Online Pick Up In Store capability flag — tracks omnichannel service breadth."
    - name: "dsd_receiving"
      expr: dsd_receiving
      comment: "Direct Store Delivery receiving capability — relevant for supplier routing and logistics planning."
    - name: "opening_date"
      expr: DATE_TRUNC('year', opening_date)
      comment: "Year-truncated store opening date — enables store age cohort analysis."
    - name: "format_id"
      expr: format_id
      comment: "Store format — enables format-level performance benchmarking."
  measures:
    - name: "total_store_count"
      expr: COUNT(1)
      comment: "Total number of store locations. Fundamental estate size KPI used in investor reporting and market coverage analysis."
    - name: "total_selling_square_footage"
      expr: SUM(CAST(selling_square_footage AS DOUBLE))
      comment: "Total selling square footage across the estate. Key capacity metric for sales-per-sqft benchmarking and capital planning."
    - name: "total_square_footage"
      expr: SUM(CAST(total_square_footage AS DOUBLE))
      comment: "Total gross square footage across all locations. Used for occupancy cost benchmarking and real estate portfolio management."
    - name: "avg_selling_square_footage"
      expr: AVG(CAST(selling_square_footage AS DOUBLE))
      comment: "Average selling square footage per store. Benchmark for format consistency and space productivity analysis."
    - name: "avg_total_square_footage"
      expr: AVG(CAST(total_square_footage AS DOUBLE))
      comment: "Average total square footage per store. Used to assess format size trends and real estate strategy."
    - name: "selling_to_total_sqft_ratio"
      expr: ROUND(100.0 * SUM(CAST(selling_square_footage AS DOUBLE)) / NULLIF(SUM(CAST(total_square_footage AS DOUBLE)), 0), 2)
      comment: "Selling area as a percentage of total area. Space efficiency ratio; low values indicate back-of-house inefficiency and drive remodel decisions."
    - name: "bopis_capable_store_count"
      expr: COUNT(CASE WHEN bopis_capable = TRUE THEN 1 END)
      comment: "Number of BOPIS-capable stores. Tracks omnichannel fulfillment network coverage; drives click-and-collect expansion strategy."
    - name: "sfs_capable_store_count"
      expr: COUNT(CASE WHEN sfs_capable = TRUE THEN 1 END)
      comment: "Number of Ship-From-Store capable locations. Measures e-commerce fulfillment capacity within the store network."
    - name: "omnichannel_penetration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN bopis_capable = TRUE OR sfs_capable = TRUE OR ropis_capable = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stores with at least one omnichannel fulfillment capability. Strategic KPI for digital transformation progress reporting."
    - name: "avg_latitude"
      expr: AVG(CAST(latitude AS DOUBLE))
      comment: "Average latitude of store locations. Used for geographic centroid analysis and logistics network optimization."
    - name: "avg_longitude"
      expr: AVG(CAST(longitude AS DOUBLE))
      comment: "Average longitude of store locations. Used alongside latitude for geographic distribution and white-space analysis."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`store_department`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store department operational metrics providing visibility into selling space, financial targets, shrinkage exposure, and temperature-controlled infrastructure to support merchandising and operations decisions."
  source: "`retail_ecm`.`store`.`department`"
  dimensions:
    - name: "location_id"
      expr: location_id
      comment: "Store location — enables per-store department analysis."
    - name: "department_status"
      expr: department_status
      comment: "Operational status of the department (e.g., Active, Inactive) — filters to live departments."
    - name: "department_type"
      expr: department_type
      comment: "Type of department (e.g., Grocery, Apparel, Electronics) — primary category dimension for benchmarking."
    - name: "zone_code"
      expr: zone_code
      comment: "Zone code within the store — supports zone-level space and performance analysis."
    - name: "floor_number"
      expr: floor_number
      comment: "Floor number — enables multi-floor store layout analysis."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Whether the department is temperature-controlled — segments perishable vs. ambient departments for cost and compliance analysis."
    - name: "omnichannel_fulfillment_enabled_flag"
      expr: omnichannel_fulfillment_enabled_flag
      comment: "Whether the department supports omnichannel fulfillment — tracks fulfillment capability at department level."
    - name: "visual_merchandising_standard"
      expr: visual_merchandising_standard
      comment: "Visual merchandising standard applied — used to correlate VM compliance with sales performance."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year-truncated effective start date — enables department age cohort analysis."
    - name: "category_id"
      expr: category_id
      comment: "Merchandise category — enables category-level department performance analysis."
  measures:
    - name: "total_selling_area_sq_ft"
      expr: SUM(CAST(selling_area_sq_ft AS DOUBLE))
      comment: "Total selling area in square feet across departments. Space allocation KPI used in planogram and assortment planning."
    - name: "avg_selling_area_sq_ft"
      expr: AVG(CAST(selling_area_sq_ft AS DOUBLE))
      comment: "Average selling area per department. Benchmark for space allocation consistency across the estate."
    - name: "total_monthly_sales_target"
      expr: SUM(CAST(sales_target_monthly AS DOUBLE))
      comment: "Total monthly sales target across departments. Aggregate target used to assess plan attainment at store and portfolio level."
    - name: "total_monthly_labor_budget"
      expr: SUM(CAST(labor_budget_monthly AS DOUBLE))
      comment: "Total monthly labor budget across departments. Drives labor cost management and scheduling decisions."
    - name: "avg_gross_margin_target_percent"
      expr: AVG(CAST(gross_margin_target_percent AS DOUBLE))
      comment: "Average gross margin target percentage across departments. Benchmark for merchandising performance vs. plan."
    - name: "avg_shrinkage_rate_percent"
      expr: AVG(CAST(shrinkage_rate_percent AS DOUBLE))
      comment: "Average shrinkage rate percentage across departments. Loss-prevention KPI; elevated rates trigger targeted LP interventions."
    - name: "temperature_controlled_department_count"
      expr: COUNT(CASE WHEN temperature_controlled_flag = TRUE THEN 1 END)
      comment: "Number of temperature-controlled departments. Tracks cold-chain infrastructure footprint for compliance and energy cost management."
    - name: "omnichannel_enabled_department_count"
      expr: COUNT(CASE WHEN omnichannel_fulfillment_enabled_flag = TRUE THEN 1 END)
      comment: "Number of departments enabled for omnichannel fulfillment. Measures fulfillment capability depth within the store."
    - name: "avg_temperature_range_spread_f"
      expr: AVG(CAST(temperature_range_max_f AS DOUBLE) - CAST(temperature_range_min_f AS DOUBLE))
      comment: "Average temperature range spread (max minus min) in Fahrenheit for temperature-controlled departments. Monitors cold-chain compliance and equipment performance."
    - name: "labor_budget_to_sales_target_ratio"
      expr: ROUND(100.0 * SUM(CAST(labor_budget_monthly AS DOUBLE)) / NULLIF(SUM(CAST(sales_target_monthly AS DOUBLE)), 0), 2)
      comment: "Labor budget as a percentage of monthly sales target. Planned labor efficiency ratio; used to set and benchmark department staffing models."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`store_sfs_fulfillment_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ship-From-Store fulfillment node performance metrics providing visibility into fulfillment capacity, operational efficiency, and cost-per-order to drive e-commerce fulfillment network optimization."
  source: "`retail_ecm`.`store`.`sfs_fulfillment_node`"
  dimensions:
    - name: "location_id"
      expr: location_id
      comment: "Store location hosting the fulfillment node — primary dimension for node-level performance analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the fulfillment node (e.g., Active, Inactive, Suspended) — filters to live nodes."
    - name: "node_type"
      expr: node_type
      comment: "Type of fulfillment node (e.g., SFS, BOPIS, Curbside) — enables capability-level performance segmentation."
    - name: "primary_carrier_code"
      expr: primary_carrier_code
      comment: "Primary shipping carrier — used to benchmark carrier performance and negotiate rates."
    - name: "supports_same_day_delivery"
      expr: supports_same_day_delivery
      comment: "Same-day delivery capability flag — segments premium fulfillment nodes for capacity planning."
    - name: "supports_next_day_delivery"
      expr: supports_next_day_delivery
      comment: "Next-day delivery capability flag — tracks express fulfillment network coverage."
    - name: "supports_bopis"
      expr: supports_bopis
      comment: "BOPIS support flag — identifies nodes contributing to click-and-collect fulfillment."
    - name: "supports_curbside_pickup"
      expr: supports_curbside_pickup
      comment: "Curbside pickup support flag — tracks contactless fulfillment capability."
    - name: "oms_integration_enabled"
      expr: oms_integration_enabled
      comment: "OMS integration flag — identifies nodes fully integrated into the order management system."
    - name: "activation_date"
      expr: DATE_TRUNC('year', activation_date)
      comment: "Year-truncated node activation date — enables node age cohort analysis."
    - name: "promo_campaign_id"
      expr: promo_campaign_id
      comment: "Promotional campaign associated with the node — enables campaign-level fulfillment demand analysis."
  measures:
    - name: "total_fulfillment_node_count"
      expr: COUNT(1)
      comment: "Total number of SFS fulfillment nodes. Measures e-commerce fulfillment network scale."
    - name: "avg_cost_per_order"
      expr: AVG(CAST(cost_per_order AS DOUBLE))
      comment: "Average fulfillment cost per order. Key efficiency KPI for SFS operations; rising cost triggers process or carrier optimization."
    - name: "total_cost_per_order_sum"
      expr: SUM(CAST(cost_per_order AS DOUBLE))
      comment: "Total fulfillment cost across all nodes. Aggregate cost base for SFS program financial management."
    - name: "avg_pick_time_minutes"
      expr: AVG(CAST(average_pick_time_minutes AS DOUBLE))
      comment: "Average pick time per order in minutes. Operational throughput KPI; elevated pick times trigger process improvement initiatives."
    - name: "avg_pack_time_minutes"
      expr: AVG(CAST(average_pack_time_minutes AS DOUBLE))
      comment: "Average pack time per order in minutes. Measures packing efficiency; used alongside pick time for total fulfillment cycle time analysis."
    - name: "avg_service_radius_km"
      expr: AVG(CAST(service_radius_km AS DOUBLE))
      comment: "Average service radius in kilometers. Measures geographic coverage of the SFS network; informs node placement strategy."
    - name: "same_day_capable_node_count"
      expr: COUNT(CASE WHEN supports_same_day_delivery = TRUE THEN 1 END)
      comment: "Number of nodes supporting same-day delivery. Tracks premium fulfillment capacity; drives investment in same-day expansion."
    - name: "oms_integrated_node_count"
      expr: COUNT(CASE WHEN oms_integration_enabled = TRUE THEN 1 END)
      comment: "Number of nodes with OMS integration enabled. Measures digital integration maturity of the fulfillment network."
    - name: "oms_integration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN oms_integration_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of fulfillment nodes with OMS integration. Tracks digital readiness of the SFS network; low rate signals integration backlog."
    - name: "avg_total_fulfillment_cycle_time_minutes"
      expr: AVG(CAST(average_pick_time_minutes AS DOUBLE) + CAST(average_pack_time_minutes AS DOUBLE))
      comment: "Average total fulfillment cycle time (pick + pack) in minutes. End-to-end throughput KPI for SFS operational efficiency benchmarking."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`store_pos_terminal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "POS terminal fleet metrics providing visibility into payment capability coverage, PCI compliance status, and technology modernization across the store estate to support IT investment and compliance decisions."
  source: "`retail_ecm`.`store`.`pos_terminal`"
  dimensions:
    - name: "location_id"
      expr: location_id
      comment: "Store location — primary dimension for per-store terminal fleet analysis."
    - name: "department_id"
      expr: department_id
      comment: "Department where the terminal is deployed — enables department-level checkout capacity analysis."
    - name: "terminal_status"
      expr: terminal_status
      comment: "Current operational status of the terminal (e.g., Active, Offline, Maintenance) — filters to live terminals."
    - name: "terminal_type"
      expr: terminal_type
      comment: "Type of POS terminal (e.g., Fixed, Mobile, Self-Checkout) — enables fleet composition analysis."
    - name: "hardware_model"
      expr: hardware_model
      comment: "Hardware model — tracks fleet standardization and end-of-life planning."
    - name: "operating_system"
      expr: operating_system
      comment: "Operating system version — monitors OS currency for security and compliance management."
    - name: "payment_processor"
      expr: payment_processor
      comment: "Payment processor — enables processor-level performance and cost benchmarking."
    - name: "contactless_enabled"
      expr: contactless_enabled
      comment: "Contactless payment capability flag — tracks modern payment acceptance coverage."
    - name: "emv_chip_enabled"
      expr: emv_chip_enabled
      comment: "EMV chip capability flag — monitors PCI compliance-relevant hardware coverage."
    - name: "mobile_wallet_enabled"
      expr: mobile_wallet_enabled
      comment: "Mobile wallet acceptance flag — tracks digital payment modernization."
    - name: "installation_date"
      expr: DATE_TRUNC('year', installation_date)
      comment: "Year-truncated installation date — enables terminal age cohort analysis for refresh planning."
    - name: "pci_dss_certification_expiry_date"
      expr: DATE_TRUNC('month', pci_dss_certification_expiry_date)
      comment: "Month-truncated PCI DSS certification expiry — tracks upcoming compliance renewal deadlines."
  measures:
    - name: "total_terminal_count"
      expr: COUNT(1)
      comment: "Total number of POS terminals in the fleet. Baseline capacity metric for checkout throughput and IT asset management."
    - name: "active_terminal_count"
      expr: COUNT(CASE WHEN terminal_status = 'Active' THEN 1 END)
      comment: "Number of currently active POS terminals. Operational availability metric; low active count signals checkout capacity risk."
    - name: "contactless_enabled_terminal_count"
      expr: COUNT(CASE WHEN contactless_enabled = TRUE THEN 1 END)
      comment: "Number of terminals with contactless payment enabled. Tracks modern payment acceptance coverage across the estate."
    - name: "contactless_penetration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN contactless_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminals with contactless payment capability. Strategic KPI for payment modernization; low rate triggers hardware refresh investment."
    - name: "mobile_wallet_penetration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN mobile_wallet_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminals accepting mobile wallet payments. Tracks digital payment readiness; informs customer experience investment decisions."
    - name: "distinct_location_count"
      expr: COUNT(DISTINCT location_id)
      comment: "Number of distinct store locations with POS terminals. Measures fleet deployment coverage across the estate."
    - name: "encryption_enabled_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN encryption_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminals with encryption enabled. PCI DSS compliance KPI; any gap triggers immediate security remediation."
    - name: "tokenization_enabled_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN tokenization_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminals with tokenization enabled. Payment security modernization KPI; low rate signals cardholder data risk exposure."
$$;