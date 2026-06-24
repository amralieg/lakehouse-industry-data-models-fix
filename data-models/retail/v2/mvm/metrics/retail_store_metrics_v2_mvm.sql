-- Metric views for domain: store | Business: Retail | Version: 2 | Generated on: 2026-06-24 00:42:49

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the store location master — covers store footprint, omnichannel capability penetration, and selling-area efficiency. Used by Real Estate, Operations, and Omnichannel leadership to evaluate the store network."
  source: "`vibe_retail_v1`.`store`.`location`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Operational lifecycle stage of the store (e.g., Open, Closed, Under Renovation). Primary filter for active-store analysis."
    - name: "banner_brand"
      expr: banner_brand
      comment: "Banner or brand the store operates under. Enables cross-banner performance comparison."
    - name: "format_size_band"
      expr: format_size_band
      comment: "Size band classification of the store format (e.g., Small, Medium, Large). Used to benchmark stores of comparable footprint."
    - name: "city"
      expr: city
      comment: "City where the store is located. Supports geographic drill-down analysis."
    - name: "state_province"
      expr: state_province
      comment: "State or province of the store. Enables regional and regulatory segmentation."
    - name: "country_code"
      expr: country_code
      comment: "ISO country code for the store. Supports international portfolio analysis."
    - name: "climate_zone"
      expr: climate_zone
      comment: "Climate zone classification of the store location. Relevant for seasonal assortment and HVAC cost analysis."
    - name: "staffing_model_type"
      expr: staffing_model_type
      comment: "Staffing model applied to the store (e.g., Full-Service, Self-Service). Drives labor cost benchmarking."
    - name: "bopis_capable"
      expr: bopis_capable
      comment: "Whether the store supports Buy Online, Pick Up In Store. Key omnichannel capability flag."
    - name: "sfs_capable"
      expr: sfs_capable
      comment: "Whether the store supports Ship From Store. Indicates fulfillment network contribution."
    - name: "ropis_capable"
      expr: ropis_capable
      comment: "Whether the store supports Reserve Online, Pick Up In Store. Indicates omnichannel service breadth."
    - name: "opening_year"
      expr: YEAR(opening_date)
      comment: "Year the store opened. Used for cohort analysis of store maturity and performance ramp."
    - name: "accessibility_certified"
      expr: accessibility_certified
      comment: "Whether the store holds accessibility certification. Relevant for compliance and ESG reporting."
  measures:
    - name: "total_store_count"
      expr: COUNT(1)
      comment: "Total number of store locations in the network. Baseline KPI for portfolio size tracking used in executive dashboards and board decks."
    - name: "total_selling_square_footage"
      expr: SUM(CAST(selling_square_footage AS DOUBLE))
      comment: "Total selling square footage across all stores. Drives real estate investment decisions and revenue-per-sqft benchmarking."
    - name: "total_gross_square_footage"
      expr: SUM(CAST(total_square_footage AS DOUBLE))
      comment: "Total gross square footage across all stores. Used for occupancy cost analysis and portfolio footprint planning."
    - name: "avg_selling_square_footage"
      expr: AVG(CAST(selling_square_footage AS DOUBLE))
      comment: "Average selling square footage per store. Benchmarks store size against format targets and informs remodel prioritization."
    - name: "avg_total_square_footage"
      expr: AVG(CAST(total_square_footage AS DOUBLE))
      comment: "Average total square footage per store. Used alongside avg_selling_square_footage to assess back-of-house efficiency."
    - name: "bopis_enabled_store_count"
      expr: COUNT(CASE WHEN bopis_capable = TRUE THEN 1 END)
      comment: "Number of stores with BOPIS capability active. Tracks omnichannel readiness and informs fulfillment network coverage decisions."
    - name: "sfs_enabled_store_count"
      expr: COUNT(CASE WHEN sfs_capable = TRUE THEN 1 END)
      comment: "Number of stores enabled for Ship From Store. Directly tied to last-mile fulfillment capacity and delivery promise coverage."
    - name: "ropis_enabled_store_count"
      expr: COUNT(CASE WHEN ropis_capable = TRUE THEN 1 END)
      comment: "Number of stores with Reserve Online Pick Up In Store capability. Measures breadth of omnichannel service offering."
    - name: "fully_omnichannel_store_count"
      expr: COUNT(CASE WHEN bopis_capable = TRUE AND sfs_capable = TRUE AND ropis_capable = TRUE THEN 1 END)
      comment: "Number of stores supporting all three omnichannel fulfillment modes (BOPIS, SFS, ROPIS). Strategic KPI for omnichannel transformation progress."
    - name: "dsd_receiving_store_count"
      expr: COUNT(CASE WHEN dsd_receiving = TRUE THEN 1 END)
      comment: "Number of stores configured for Direct Store Delivery receiving. Informs supplier logistics and replenishment network design."
    - name: "sum_selling_sqft_bopis_stores"
      expr: SUM(CASE WHEN bopis_capable = TRUE THEN selling_square_footage ELSE 0 END)
      comment: "Total selling square footage of BOPIS-capable stores. Used to assess what share of the physical footprint is omnichannel-enabled."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_department`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and operational KPIs at the store department level — covers sales targets, labor budgets, gross margin goals, and physical space allocation. Used by Merchandising, Store Operations, and Finance to manage department-level P&L and productivity."
  source: "`vibe_retail_v1`.`store`.`department`"
  dimensions:
    - name: "department_status"
      expr: department_status
      comment: "Operational status of the department (e.g., Active, Inactive, Seasonal). Primary filter for active department analysis."
    - name: "department_type"
      expr: department_type
      comment: "Classification of the department type (e.g., Grocery, Apparel, Electronics). Enables cross-department benchmarking."
    - name: "floor_number"
      expr: floor_number
      comment: "Floor on which the department is located. Used for store layout and traffic flow analysis."
    - name: "licensed_department_flag"
      expr: licensed_department_flag
      comment: "Whether the department operates under a license agreement. Relevant for lease/license cost and compliance tracking."
    - name: "omnichannel_fulfillment_enabled_flag"
      expr: omnichannel_fulfillment_enabled_flag
      comment: "Whether the department supports omnichannel fulfillment. Tracks fulfillment capability at department granularity."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Whether the department requires temperature control. Drives energy cost and compliance analysis."
    - name: "visual_merchandising_standard"
      expr: visual_merchandising_standard
      comment: "Visual merchandising standard applied to the department. Used to correlate presentation standards with sales performance."
    - name: "zone_code"
      expr: zone_code
      comment: "Zone code within the store for the department. Supports planogram and space planning analysis."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the department became effective. Used for cohort and vintage analysis of department performance."
  measures:
    - name: "total_monthly_sales_target"
      expr: SUM(CAST(sales_target_monthly AS DOUBLE))
      comment: "Sum of monthly sales targets across departments. Baseline for revenue planning and target-setting at the store and chain level."
    - name: "avg_monthly_sales_target"
      expr: AVG(CAST(sales_target_monthly AS DOUBLE))
      comment: "Average monthly sales target per department. Benchmarks individual department ambition against the portfolio average."
    - name: "total_monthly_labor_budget"
      expr: SUM(CAST(labor_budget_monthly AS DOUBLE))
      comment: "Total monthly labor budget across departments. Critical input for workforce planning and cost control decisions."
    - name: "avg_monthly_labor_budget"
      expr: AVG(CAST(labor_budget_monthly AS DOUBLE))
      comment: "Average monthly labor budget per department. Used to identify over- or under-resourced departments relative to sales targets."
    - name: "total_selling_area_sqft"
      expr: SUM(CAST(selling_area_sq_ft AS DOUBLE))
      comment: "Total selling area in square feet across departments. Drives space productivity analysis and reallocation decisions."
    - name: "avg_selling_area_sqft"
      expr: AVG(CAST(selling_area_sq_ft AS DOUBLE))
      comment: "Average selling area per department. Used to benchmark space allocation against sales target efficiency."
    - name: "avg_gross_margin_target_pct"
      expr: AVG(CAST(gross_margin_target_percent AS DOUBLE))
      comment: "Average gross margin target percentage across departments. Key financial KPI for merchandising strategy and category management."
    - name: "avg_shrinkage_rate_pct"
      expr: AVG(CAST(shrinkage_rate_percent AS DOUBLE))
      comment: "Average shrinkage rate percentage across departments. Directly tied to loss prevention investment and security strategy decisions."
    - name: "total_shrinkage_rate_sum"
      expr: SUM(CAST(shrinkage_rate_percent AS DOUBLE))
      comment: "Sum of shrinkage rate percentages — used as a portfolio-level loss exposure indicator when averaged against department count."
    - name: "sales_target_per_sqft"
      expr: SUM(CAST(sales_target_monthly AS DOUBLE)) / NULLIF(SUM(CAST(selling_area_sq_ft AS DOUBLE)), 0)
      comment: "Monthly sales target per square foot of selling area. Compound productivity KPI used by Real Estate and Merchandising to evaluate space efficiency and justify remodel or closure decisions."
    - name: "labor_budget_to_sales_target_ratio"
      expr: SUM(CAST(labor_budget_monthly AS DOUBLE)) / NULLIF(SUM(CAST(sales_target_monthly AS DOUBLE)), 0)
      comment: "Ratio of total labor budget to total sales target. Measures labor cost intensity relative to revenue ambition — a key operational efficiency KPI for Store Operations and Finance."
    - name: "licensed_department_count"
      expr: COUNT(CASE WHEN licensed_department_flag = TRUE THEN 1 END)
      comment: "Number of licensed departments. Tracks the scale of licensed operations for lease management and compliance oversight."
    - name: "omnichannel_enabled_department_count"
      expr: COUNT(CASE WHEN omnichannel_fulfillment_enabled_flag = TRUE THEN 1 END)
      comment: "Number of departments with omnichannel fulfillment enabled. Measures omnichannel readiness at department granularity."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_fixture`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and capital KPIs for store fixtures — covers fixture inventory, capacity, technology enablement, and maintenance posture. Used by Store Operations, Visual Merchandising, and Capital Planning to manage fixture assets and plan refreshes."
  source: "`vibe_retail_v1`.`store`.`fixture`"
  dimensions:
    - name: "fixture_status"
      expr: fixture_status
      comment: "Current operational status of the fixture (e.g., Active, Decommissioned, Under Repair). Primary filter for active asset analysis."
    - name: "fixture_type"
      expr: fixture_type
      comment: "Type of fixture (e.g., Gondola, Endcap, Wall Unit). Enables fixture-type benchmarking and space planning."
    - name: "category"
      expr: category
      comment: "Merchandise category the fixture is assigned to. Links fixture assets to category management decisions."
    - name: "mobility_type"
      expr: mobility_type
      comment: "Whether the fixture is fixed, mobile, or semi-permanent. Relevant for store reset planning and flexibility analysis."
    - name: "ada_compliant_flag"
      expr: ada_compliant_flag
      comment: "Whether the fixture meets ADA accessibility standards. Critical for compliance reporting and risk management."
    - name: "digital_display_flag"
      expr: digital_display_flag
      comment: "Whether the fixture includes a digital display. Tracks digital merchandising asset penetration."
    - name: "rfid_enabled_flag"
      expr: rfid_enabled_flag
      comment: "Whether the fixture is RFID-enabled. Measures inventory visibility technology adoption at fixture level."
    - name: "refrigeration_type"
      expr: refrigeration_type
      comment: "Type of refrigeration on the fixture (if applicable). Used for energy and maintenance cost analysis."
    - name: "installation_year"
      expr: YEAR(installation_date)
      comment: "Year the fixture was installed. Used for asset age analysis and capital refresh prioritization."
    - name: "manufacturer_name"
      expr: manufacturer_name
      comment: "Manufacturer of the fixture. Used for vendor performance and warranty management analysis."
  measures:
    - name: "total_fixture_count"
      expr: COUNT(1)
      comment: "Total number of fixtures across the store network. Baseline capital asset count for portfolio management and refresh planning."
    - name: "total_weight_capacity_lbs"
      expr: SUM(CAST(weight_capacity_lbs AS DOUBLE))
      comment: "Total weight capacity in pounds across all fixtures. Measures aggregate merchandising load capacity for assortment planning."
    - name: "avg_weight_capacity_lbs"
      expr: AVG(CAST(weight_capacity_lbs AS DOUBLE))
      comment: "Average weight capacity per fixture. Used to benchmark fixture specifications against merchandising requirements."
    - name: "avg_fixture_width_inches"
      expr: AVG(CAST(width_inches AS DOUBLE))
      comment: "Average fixture width in inches. Supports planogram design and aisle space planning."
    - name: "avg_fixture_height_inches"
      expr: AVG(CAST(height_inches AS DOUBLE))
      comment: "Average fixture height in inches. Used for visual merchandising standard compliance and safety assessments."
    - name: "avg_fixture_depth_inches"
      expr: AVG(CAST(depth_inches AS DOUBLE))
      comment: "Average fixture depth in inches. Relevant for aisle clearance compliance and space efficiency analysis."
    - name: "digital_display_fixture_count"
      expr: COUNT(CASE WHEN digital_display_flag = TRUE THEN 1 END)
      comment: "Number of fixtures with integrated digital displays. Tracks digital merchandising asset base — a strategic KPI for omnichannel and in-store media investment decisions."
    - name: "rfid_enabled_fixture_count"
      expr: COUNT(CASE WHEN rfid_enabled_flag = TRUE THEN 1 END)
      comment: "Number of RFID-enabled fixtures. Measures inventory visibility technology penetration across the fixture estate."
    - name: "ada_compliant_fixture_count"
      expr: COUNT(CASE WHEN ada_compliant_flag = TRUE THEN 1 END)
      comment: "Number of ADA-compliant fixtures. Used for compliance gap analysis and risk mitigation reporting."
    - name: "fixtures_needing_maintenance_count"
      expr: COUNT(CASE WHEN next_maintenance_date <= CURRENT_DATE() THEN 1 END)
      comment: "Number of fixtures with a past-due or due-today maintenance date. Operational risk KPI that triggers maintenance scheduling and budget allocation decisions."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_pos_terminal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technology and compliance KPIs for POS terminals — covers payment capability penetration, PCI-DSS certification posture, and terminal fleet health. Used by IT, Loss Prevention, and Store Operations to manage checkout technology and payment security compliance."
  source: "`vibe_retail_v1`.`store`.`pos_terminal`"
  dimensions:
    - name: "terminal_status"
      expr: terminal_status
      comment: "Current operational status of the POS terminal (e.g., Active, Offline, Decommissioned). Primary filter for active fleet analysis."
    - name: "terminal_type"
      expr: terminal_type
      comment: "Type of POS terminal (e.g., Fixed, Mobile, Self-Checkout). Enables fleet composition analysis."
    - name: "payment_processor"
      expr: payment_processor
      comment: "Payment processor used by the terminal. Relevant for processor contract management and fee benchmarking."
    - name: "operating_system"
      expr: operating_system
      comment: "Operating system running on the terminal. Used for software lifecycle and security patch management."
    - name: "contactless_enabled"
      expr: contactless_enabled
      comment: "Whether the terminal supports contactless payments. Tracks modern payment acceptance capability."
    - name: "emv_chip_enabled"
      expr: emv_chip_enabled
      comment: "Whether the terminal supports EMV chip card payments. Relevant for fraud liability and compliance."
    - name: "mobile_wallet_enabled"
      expr: mobile_wallet_enabled
      comment: "Whether the terminal accepts mobile wallet payments (e.g., Apple Pay, Google Pay). Measures digital payment readiness."
    - name: "ebt_snap_enabled"
      expr: ebt_snap_enabled
      comment: "Whether the terminal supports EBT/SNAP payments. Required for government program compliance and customer accessibility."
    - name: "network_zone"
      expr: network_zone
      comment: "Network security zone of the terminal. Used for IT security segmentation and PCI-DSS scope analysis."
    - name: "installation_year"
      expr: YEAR(installation_date)
      comment: "Year the terminal was installed. Used for fleet age analysis and capital refresh planning."
  measures:
    - name: "total_terminal_count"
      expr: COUNT(1)
      comment: "Total number of POS terminals in the fleet. Baseline KPI for checkout capacity planning and capital asset management."
    - name: "contactless_enabled_terminal_count"
      expr: COUNT(CASE WHEN contactless_enabled = TRUE THEN 1 END)
      comment: "Number of terminals with contactless payment capability. Tracks modern payment acceptance penetration — a strategic KPI for customer experience and payment technology investment."
    - name: "mobile_wallet_enabled_terminal_count"
      expr: COUNT(CASE WHEN mobile_wallet_enabled = TRUE THEN 1 END)
      comment: "Number of terminals accepting mobile wallet payments. Measures digital payment readiness across the checkout fleet."
    - name: "emv_enabled_terminal_count"
      expr: COUNT(CASE WHEN emv_chip_enabled = TRUE THEN 1 END)
      comment: "Number of EMV chip-enabled terminals. Tracks fraud liability compliance across the POS fleet."
    - name: "pci_expired_terminal_count"
      expr: COUNT(CASE WHEN pci_dss_certification_expiry_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of terminals with expired PCI-DSS certification. Critical compliance risk KPI — expired terminals represent active regulatory and financial exposure requiring immediate remediation."
    - name: "terminals_past_due_maintenance_count"
      expr: COUNT(CASE WHEN next_scheduled_maintenance_date <= CURRENT_DATE() THEN 1 END)
      comment: "Number of terminals with past-due scheduled maintenance. Operational risk KPI that drives maintenance prioritization and SLA compliance."
    - name: "tokenization_enabled_terminal_count"
      expr: COUNT(CASE WHEN tokenization_enabled = TRUE THEN 1 END)
      comment: "Number of terminals with payment tokenization enabled. Measures data security posture and PCI-DSS scope reduction progress."
    - name: "encryption_enabled_terminal_count"
      expr: COUNT(CASE WHEN encryption_enabled = TRUE THEN 1 END)
      comment: "Number of terminals with encryption enabled. Tracks point-to-point encryption adoption — a key payment security compliance KPI."
    - name: "fully_secure_terminal_count"
      expr: COUNT(CASE WHEN tokenization_enabled = TRUE AND encryption_enabled = TRUE AND emv_chip_enabled = TRUE THEN 1 END)
      comment: "Number of terminals with all three core security features active (tokenization, encryption, EMV). Compound security posture KPI used by CISO and Compliance leadership."
    - name: "ebt_snap_enabled_terminal_count"
      expr: COUNT(CASE WHEN ebt_snap_enabled = TRUE THEN 1 END)
      comment: "Number of terminals supporting EBT/SNAP payments. Tracks government program accessibility compliance across the checkout fleet."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_sfs_fulfillment_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational efficiency and capacity KPIs for Ship-From-Store fulfillment nodes — covers pick/pack productivity, cost per order, and service capability. Used by Supply Chain, Omnichannel Operations, and Finance to manage SFS network performance and investment."
  source: "`vibe_retail_v1`.`store`.`sfs_fulfillment_node`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the SFS node (e.g., Active, Inactive, Suspended). Primary filter for active node analysis."
    - name: "node_type"
      expr: node_type
      comment: "Type of fulfillment node (e.g., Full-Service, Limited). Used to segment performance by node capability tier."
    - name: "primary_carrier_code"
      expr: primary_carrier_code
      comment: "Primary shipping carrier used by the node. Enables carrier performance and cost benchmarking."
    - name: "supports_bopis"
      expr: supports_bopis
      comment: "Whether the node supports BOPIS fulfillment. Tracks multi-modal fulfillment capability."
    - name: "supports_same_day_delivery"
      expr: supports_same_day_delivery
      comment: "Whether the node supports same-day delivery. Key capability flag for competitive delivery promise analysis."
    - name: "supports_next_day_delivery"
      expr: supports_next_day_delivery
      comment: "Whether the node supports next-day delivery. Tracks express delivery network coverage."
    - name: "supports_curbside_pickup"
      expr: supports_curbside_pickup
      comment: "Whether the node supports curbside pickup. Measures contactless fulfillment capability penetration."
    - name: "oms_integration_enabled"
      expr: oms_integration_enabled
      comment: "Whether the node is integrated with the Order Management System. Tracks automation and order routing readiness."
    - name: "wms_integration_enabled"
      expr: wms_integration_enabled
      comment: "Whether the node is integrated with the Warehouse Management System. Measures inventory accuracy and fulfillment automation maturity."
    - name: "activation_year"
      expr: YEAR(activation_date)
      comment: "Year the SFS node was activated. Used for cohort analysis of node maturity and performance ramp."
    - name: "timezone"
      expr: timezone
      comment: "Timezone of the fulfillment node. Used for cutoff time analysis and same-day delivery window management."
  measures:
    - name: "total_sfs_node_count"
      expr: COUNT(1)
      comment: "Total number of active SFS fulfillment nodes. Baseline KPI for omnichannel fulfillment network scale and coverage."
    - name: "avg_pick_time_minutes"
      expr: AVG(CAST(average_pick_time_minutes AS DOUBLE))
      comment: "Average pick time in minutes across SFS nodes. Core operational efficiency KPI — directly tied to fulfillment SLA compliance and labor productivity."
    - name: "avg_pack_time_minutes"
      expr: AVG(CAST(average_pack_time_minutes AS DOUBLE))
      comment: "Average pack time in minutes across SFS nodes. Measures packing productivity and informs process improvement investments."
    - name: "total_avg_fulfillment_cycle_minutes"
      expr: SUM(CAST(average_pick_time_minutes AS DOUBLE) + CAST(average_pack_time_minutes AS DOUBLE))
      comment: "Sum of combined pick and pack time across all nodes. Used as a portfolio-level throughput indicator for SFS network capacity planning."
    - name: "avg_fulfillment_cycle_minutes"
      expr: AVG(CAST(average_pick_time_minutes AS DOUBLE) + CAST(average_pack_time_minutes AS DOUBLE))
      comment: "Average total fulfillment cycle time (pick + pack) per node. Compound efficiency KPI used by Omnichannel Operations to benchmark node performance and set SLA targets."
    - name: "avg_cost_per_order"
      expr: AVG(CAST(cost_per_order AS DOUBLE))
      comment: "Average cost per fulfilled order across SFS nodes. Key financial efficiency KPI for omnichannel P&L management and carrier/process optimization decisions."
    - name: "total_cost_per_order_sum"
      expr: SUM(CAST(cost_per_order AS DOUBLE))
      comment: "Sum of cost-per-order values across nodes. Used as a portfolio-level cost exposure indicator for SFS network investment analysis."
    - name: "avg_service_radius_km"
      expr: AVG(CAST(service_radius_km AS DOUBLE))
      comment: "Average service radius in kilometers across SFS nodes. Measures geographic coverage density of the fulfillment network."
    - name: "same_day_capable_node_count"
      expr: COUNT(CASE WHEN supports_same_day_delivery = TRUE THEN 1 END)
      comment: "Number of SFS nodes supporting same-day delivery. Strategic KPI for competitive delivery promise coverage and market expansion decisions."
    - name: "fully_integrated_node_count"
      expr: COUNT(CASE WHEN oms_integration_enabled = TRUE AND wms_integration_enabled = TRUE THEN 1 END)
      comment: "Number of SFS nodes with both OMS and WMS integration active. Compound technology maturity KPI — fully integrated nodes deliver higher inventory accuracy and order routing efficiency."
    - name: "curbside_capable_node_count"
      expr: COUNT(CASE WHEN supports_curbside_pickup = TRUE THEN 1 END)
      comment: "Number of SFS nodes supporting curbside pickup. Tracks contactless fulfillment capability penetration across the network."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_sales_territory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Market potential and revenue planning KPIs for sales territories — covers revenue targets, market opportunity, demographic reach, and territory prioritization. Used by Sales Leadership, Strategy, and Finance to allocate resources and set territory-level performance expectations."
  source: "`vibe_retail_v1`.`store`.`sales_territory`"
  dimensions:
    - name: "sales_territory_status"
      expr: sales_territory_status
      comment: "Operational status of the sales territory (e.g., Active, Inactive, Pending). Primary filter for active territory analysis."
    - name: "territory_type"
      expr: territory_type
      comment: "Type of sales territory (e.g., Geographic, Account-Based). Enables segmentation by territory model."
    - name: "territory_level"
      expr: territory_level
      comment: "Hierarchy level of the territory (e.g., District, Region, National). Supports roll-up and drill-down analysis."
    - name: "priority_tier"
      expr: priority_tier
      comment: "Priority tier assigned to the territory (e.g., Tier 1, Tier 2). Used for resource allocation and investment prioritization."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel associated with the territory (e.g., In-Store, Online, Hybrid). Enables channel-level performance analysis."
    - name: "competition_level"
      expr: competition_level
      comment: "Competitive intensity level of the territory. Used to contextualize performance targets and market share strategy."
    - name: "country_code"
      expr: country_code
      comment: "Country code of the territory. Supports international portfolio analysis."
    - name: "state_province_code"
      expr: state_province_code
      comment: "State or province code of the territory. Enables sub-national geographic analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for financial targets in the territory. Required for multi-currency portfolio normalization."
  measures:
    - name: "total_annual_revenue_target"
      expr: SUM(CAST(annual_revenue_target AS DOUBLE))
      comment: "Total annual revenue target across all sales territories. Top-line planning KPI used in board decks and annual operating plan reviews."
    - name: "avg_annual_revenue_target"
      expr: AVG(CAST(annual_revenue_target AS DOUBLE))
      comment: "Average annual revenue target per territory. Used to benchmark individual territory ambition against the portfolio average."
    - name: "total_population_size"
      expr: SUM(CAST(population_size AS DOUBLE))
      comment: "Total addressable population across all territories. Measures market reach and informs territory expansion and investment decisions."
    - name: "total_household_count"
      expr: SUM(CAST(household_count AS DOUBLE))
      comment: "Total number of households across all territories. Key demand potential indicator used for store network planning and marketing investment allocation."
    - name: "avg_market_potential_score"
      expr: AVG(CAST(market_potential_score AS DOUBLE))
      comment: "Average market potential score across territories. Composite opportunity index used by Strategy and Sales leadership to prioritize territory investment."
    - name: "avg_median_household_income"
      expr: AVG(CAST(median_household_income AS DOUBLE))
      comment: "Average median household income across territories. Demographic KPI used to align assortment strategy, pricing tiers, and promotional intensity with territory affluence."
    - name: "total_market_potential_score"
      expr: SUM(CAST(market_potential_score AS DOUBLE))
      comment: "Sum of market potential scores across territories. Portfolio-level opportunity index used to compare total addressable market across regions or channels."
    - name: "revenue_target_per_household"
      expr: SUM(CAST(annual_revenue_target AS DOUBLE)) / NULLIF(SUM(CAST(household_count AS DOUBLE)), 0)
      comment: "Annual revenue target per household in the territory. Compound efficiency KPI that normalizes revenue ambition against market size — used to identify over- and under-targeted territories."
    - name: "revenue_target_per_capita"
      expr: SUM(CAST(annual_revenue_target AS DOUBLE)) / NULLIF(SUM(CAST(population_size AS DOUBLE)), 0)
      comment: "Annual revenue target per capita. Measures revenue intensity relative to addressable population — a strategic KPI for market penetration analysis and territory sizing decisions."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`store_cluster`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for store clusters — covers cluster scale, sales performance benchmarks, and operational characteristics. Used by Merchandising, Pricing, and Store Strategy to manage cluster-based assortment, pricing, and promotional strategies."
  source: "`vibe_retail_v1`.`store`.`cluster`"
  dimensions:
    - name: "cluster_status"
      expr: cluster_status
      comment: "Operational status of the cluster (e.g., Active, Inactive, Draft). Primary filter for active cluster analysis."
    - name: "cluster_type"
      expr: cluster_type
      comment: "Type of cluster (e.g., Assortment, Pricing, Promotional). Enables analysis by clustering purpose."
    - name: "clustering_methodology"
      expr: clustering_methodology
      comment: "Methodology used to form the cluster (e.g., Statistical, Rule-Based). Used to assess cluster quality and consistency."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the cluster (e.g., National, Regional, Local). Supports hierarchical cluster analysis."
    - name: "urbanization_level"
      expr: urbanization_level
      comment: "Urbanization classification of the cluster (e.g., Urban, Suburban, Rural). Used to align strategies with demographic context."
    - name: "climate_zone"
      expr: climate_zone
      comment: "Climate zone of the cluster. Relevant for seasonal assortment and promotional planning."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy applied to the cluster (e.g., EDLP, Hi-Lo). Core dimension for pricing performance analysis."
    - name: "promotional_intensity"
      expr: promotional_intensity
      comment: "Promotional intensity level of the cluster. Used to correlate promotional investment with sales outcomes."
    - name: "assortment_depth_strategy"
      expr: assortment_depth_strategy
      comment: "Assortment depth strategy applied to the cluster. Used by Merchandising to evaluate SKU rationalization decisions."
    - name: "supports_omnichannel"
      expr: supports_omnichannel
      comment: "Whether the cluster supports omnichannel operations. Tracks omnichannel readiness at cluster level."
    - name: "level"
      expr: level
      comment: "Hierarchy level of the cluster within the clustering structure. Supports roll-up and drill-down analysis."
  measures:
    - name: "total_cluster_count"
      expr: COUNT(1)
      comment: "Total number of store clusters. Baseline KPI for cluster portfolio management and governance."
    - name: "total_average_annual_sales_usd"
      expr: SUM(CAST(average_annual_sales_usd AS DOUBLE))
      comment: "Sum of average annual sales USD across clusters. Portfolio-level revenue benchmark used by Finance and Merchandising for cluster-based planning."
    - name: "avg_annual_sales_usd"
      expr: AVG(CAST(average_annual_sales_usd AS DOUBLE))
      comment: "Average annual sales USD per cluster. Used to benchmark cluster revenue performance and identify under-performing cluster groups."
    - name: "total_average_store_size_sqft"
      expr: SUM(CAST(average_store_size_sqft AS DOUBLE))
      comment: "Sum of average store sizes across clusters. Used as a portfolio footprint indicator for real estate and space planning."
    - name: "avg_store_size_sqft"
      expr: AVG(CAST(average_store_size_sqft AS DOUBLE))
      comment: "Average store size in square feet across clusters. Used to align assortment depth and fixture strategies with typical store footprint."
    - name: "sales_per_sqft_benchmark"
      expr: SUM(CAST(average_annual_sales_usd AS DOUBLE)) / NULLIF(SUM(CAST(average_store_size_sqft AS DOUBLE)), 0)
      comment: "Estimated annual sales per square foot across clusters. Compound productivity KPI used by Real Estate and Merchandising to benchmark cluster efficiency and prioritize investment."
    - name: "omnichannel_cluster_count"
      expr: COUNT(CASE WHEN supports_omnichannel = TRUE THEN 1 END)
      comment: "Number of clusters with omnichannel support enabled. Tracks omnichannel strategy penetration across the cluster portfolio."
$$;