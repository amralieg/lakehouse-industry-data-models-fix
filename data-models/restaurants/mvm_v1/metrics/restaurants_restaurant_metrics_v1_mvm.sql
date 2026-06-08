-- Metric views for domain: restaurant | Business: Restaurants | Version: 1 | Generated on: 2026-05-06 03:57:03

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`restaurant_unit_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core financial and operational KPIs for each restaurant unit by financial period. Covers revenue, margin, cost structure, and same-store sales growth — the primary steering dashboard for field operations and finance leadership."
  source: "`restaurants_ecm`.`restaurant`.`unit_performance`"
  dimensions:
    - name: "unit_id"
      expr: primary_restaurant_unit_id
      comment: "Foreign key to the restaurant unit — enables slicing all KPIs by individual unit."
    - name: "financial_period_id"
      expr: financial_period_id
      comment: "Foreign key to the financial period — enables trending KPIs across weeks, periods, or fiscal years."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center associated with the unit performance record — supports P&L roll-up by cost center hierarchy."
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center dimension — enables profitability analysis segmented by profit center."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which financial amounts are reported — critical for multi-currency global operations."
    - name: "performance_status"
      expr: performance_status
      comment: "Operational performance classification of the unit (e.g. On-Track, At-Risk, Underperforming) — used for exception-based management."
    - name: "source_system"
      expr: source_system
      comment: "Source system that generated the performance record — supports data lineage and reconciliation."
  measures:
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_revenue_amount AS DOUBLE))
      comment: "Total gross revenue across all units and periods. Primary top-line KPI used in every executive review and board deck."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after discounts and adjustments. Used to assess true earned revenue and compare against cost structure."
    - name: "total_ebitda"
      expr: SUM(CAST(ebitda_amount AS DOUBLE))
      comment: "Total EBITDA across units. Core profitability KPI used by finance and executive leadership to evaluate unit-level and portfolio-level earnings power."
    - name: "total_operating_income"
      expr: SUM(CAST(operating_income_amount AS DOUBLE))
      comment: "Total operating income. Measures profit from core restaurant operations before interest and taxes — key for operational efficiency assessment."
    - name: "total_net_income"
      expr: SUM(CAST(net_income_amount AS DOUBLE))
      comment: "Total net income across units. Bottom-line profitability metric used in investor reporting and franchise performance reviews."
    - name: "total_cogs"
      expr: SUM(CAST(cogs_amount AS DOUBLE))
      comment: "Total cost of goods sold. Directly tied to food cost management — a primary lever for margin improvement in foodservice."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost across units. Labor is typically the second-largest cost in restaurant operations; tracked closely against revenue targets."
    - name: "total_operating_expenses"
      expr: SUM(CAST(total_operating_expenses_amount AS DOUBLE))
      comment: "Total operating expenses. Aggregated cost base used to compute operating leverage and benchmark against revenue growth."
    - name: "total_marketing_expense"
      expr: SUM(CAST(marketing_expense_amount AS DOUBLE))
      comment: "Total marketing spend across units. Tracked against revenue to evaluate marketing ROI and fund contribution compliance."
    - name: "total_rent_expense"
      expr: SUM(CAST(rent_expense_amount AS DOUBLE))
      comment: "Total occupancy/rent expense. A fixed cost driver that impacts unit-level profitability and lease renegotiation decisions."
    - name: "total_waste_amount"
      expr: SUM(CAST(waste_amount AS DOUBLE))
      comment: "Total food and product waste cost. Waste reduction is a key sustainability and margin improvement initiative in foodservice operations."
    - name: "avg_cogs_percent"
      expr: AVG(CAST(cogs_percent AS DOUBLE))
      comment: "Average COGS as a percentage of revenue across units. Benchmarked against brand targets to identify units with food cost control issues."
    - name: "avg_labor_percent"
      expr: AVG(CAST(labor_percent AS DOUBLE))
      comment: "Average labor cost as a percentage of revenue. A critical efficiency ratio — deviations from target trigger staffing and scheduling interventions."
    - name: "avg_waste_percent"
      expr: AVG(CAST(waste_percent AS DOUBLE))
      comment: "Average waste as a percentage of revenue. Elevated waste percent signals over-production, spoilage, or portion control failures."
    - name: "avg_sss_growth_percent"
      expr: AVG(CAST(sss_growth_percent AS DOUBLE))
      comment: "Average same-store sales growth percentage. The gold-standard organic growth metric for restaurant chains — used in every investor and franchise performance review."
    - name: "total_comp_sales"
      expr: SUM(CAST(comp_sales_amount AS DOUBLE))
      comment: "Total comparable (same-store) sales. Measures revenue from units open long enough to be included in comp base — isolates organic growth from new unit openings."
    - name: "total_comp_sales_variance"
      expr: SUM(CAST(comp_sales_variance_amount AS DOUBLE))
      comment: "Total variance of comparable sales versus prior period or plan. Positive variance indicates outperformance; negative triggers operational review."
    - name: "avg_unit_volume"
      expr: AVG(CAST(auc_amount AS DOUBLE))
      comment: "Average unit volume (AUV) — the average revenue per unit per period. A foundational benchmark for unit economics and franchise investment decisions."
    - name: "total_acv"
      expr: SUM(CAST(acv_amount AS DOUBLE))
      comment: "Total annualized contract value or average check value across units. Used to track ticket-level revenue trends and pricing strategy effectiveness."
    - name: "ebitda_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(ebitda_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_revenue_amount AS DOUBLE)), 0), 2)
      comment: "EBITDA margin as a percentage of net revenue. A compound profitability ratio used by executives and investors to compare unit and portfolio efficiency."
    - name: "operating_income_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(operating_income_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_revenue_amount AS DOUBLE)), 0), 2)
      comment: "Operating income margin percentage. Measures operational efficiency — how much of each revenue dollar converts to operating profit after all operating costs."
    - name: "net_income_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(net_income_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_revenue_amount AS DOUBLE)), 0), 2)
      comment: "Net income margin as a percentage of gross revenue. Bottom-line profitability ratio used in franchise disclosure documents and investor reporting."
    - name: "labor_cost_ratio"
      expr: ROUND(100.0 * SUM(CAST(labor_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_revenue_amount AS DOUBLE)), 0), 2)
      comment: "Labor cost as a percentage of net revenue, computed from raw amounts. Compound efficiency ratio — deviations from brand target trigger workforce scheduling reviews."
    - name: "cogs_ratio"
      expr: ROUND(100.0 * SUM(CAST(cogs_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_revenue_amount AS DOUBLE)), 0), 2)
      comment: "COGS as a percentage of net revenue, computed from raw amounts. Food cost ratio — the primary lever for margin management in restaurant operations."
    - name: "unit_count"
      expr: COUNT(DISTINCT primary_restaurant_unit_id)
      comment: "Count of distinct restaurant units with performance records in the selected period. Used to normalize portfolio-level KPIs and track active unit base."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`restaurant_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Restaurant unit master KPIs covering the operational footprint, capacity, and structural attributes of each unit. Used for network planning, franchise portfolio management, and operational benchmarking."
  source: "`restaurants_ecm`.`restaurant`.`unit`"
  dimensions:
    - name: "unit_id"
      expr: unit_id
      comment: "Primary key of the restaurant unit — the atomic grain for all unit-level analysis."
    - name: "brand_id"
      expr: brand_id
      comment: "Brand the unit belongs to — enables KPI segmentation by brand across a multi-brand portfolio."
    - name: "ownership_model"
      expr: ownership_model
      comment: "Ownership model of the unit (e.g. Company-Owned, Franchised, Joint Venture) — critical for separating franchise vs. corporate performance."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the unit (e.g. Open, Closed, Under Renovation) — used to filter active network and track closure/opening trends."
    - name: "concept_type"
      expr: concept_type
      comment: "Restaurant concept type (e.g. Quick Service, Casual Dining, Fine Dining) — enables performance benchmarking within format segments."
    - name: "country_code"
      expr: country_code
      comment: "Country where the unit operates — supports geographic segmentation for international portfolio analysis."
    - name: "state_province"
      expr: state_province
      comment: "State or province of the unit — enables regional performance analysis and territory management."
    - name: "city"
      expr: city
      comment: "City where the unit is located — supports local market analysis and competitive benchmarking."
    - name: "area_management_id"
      expr: area_management_id
      comment: "Area management region the unit belongs to — enables area-level roll-up of unit KPIs for field leadership."
    - name: "franchisee_id"
      expr: franchisee_id
      comment: "Franchisee operating the unit — enables franchisee-level portfolio performance analysis."
    - name: "opening_date"
      expr: opening_date
      comment: "Date the unit opened — used for unit age cohort analysis and new unit ramp performance tracking."
    - name: "closure_date"
      expr: closure_date
      comment: "Date the unit closed — used to track net unit growth and closure rate trends."
    - name: "has_online_ordering"
      expr: has_online_ordering
      comment: "Whether the unit supports online ordering — enables digital channel penetration analysis across the network."
    - name: "has_third_party_delivery"
      expr: has_third_party_delivery
      comment: "Whether the unit is enabled for third-party delivery — supports delivery channel strategy and incremental revenue analysis."
    - name: "haccp_certified"
      expr: haccp_certified
      comment: "Whether the unit holds HACCP food safety certification — used in compliance and brand standard reporting."
  measures:
    - name: "total_units"
      expr: COUNT(DISTINCT unit_id)
      comment: "Total count of distinct restaurant units. The foundational network size metric — used in every executive review to track portfolio scale and net unit growth."
    - name: "avg_unit_volume_usd"
      expr: AVG(CAST(average_unit_volume_usd AS DOUBLE))
      comment: "Average unit volume in USD across the network. AUV is the primary unit economics benchmark — used to evaluate brand health, franchise investment returns, and network quality."
    - name: "total_portfolio_auv"
      expr: SUM(CAST(average_unit_volume_usd AS DOUBLE))
      comment: "Sum of average unit volumes across all units. Approximates total annualized system sales — used for portfolio-level revenue sizing and market share estimation."
    - name: "avg_same_store_sales_pct"
      expr: AVG(CAST(same_store_sales_pct AS DOUBLE))
      comment: "Average same-store sales percentage across units. Organic growth indicator — a core metric in franchise disclosure, investor reporting, and brand health assessment."
    - name: "avg_table_turn_rate"
      expr: AVG(CAST(table_turn_rate AS DOUBLE))
      comment: "Average table turn rate across units. Measures dining room throughput efficiency — higher turn rates indicate better capacity utilization and revenue per seat."
    - name: "online_ordering_penetration_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN has_online_ordering = TRUE THEN unit_id END) / NULLIF(COUNT(DISTINCT unit_id), 0), 2)
      comment: "Percentage of units enabled for online ordering. Digital channel readiness metric — used to track omnichannel strategy execution across the network."
    - name: "third_party_delivery_penetration_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN has_third_party_delivery = TRUE THEN unit_id END) / NULLIF(COUNT(DISTINCT unit_id), 0), 0)
      comment: "Percentage of units enabled for third-party delivery. Delivery channel coverage metric — informs delivery strategy investment and incremental revenue opportunity sizing."
    - name: "haccp_certified_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN haccp_certified = TRUE THEN unit_id END) / NULLIF(COUNT(DISTINCT unit_id), 0), 2)
      comment: "Percentage of units with HACCP food safety certification. Compliance coverage metric — used in brand standard audits and regulatory reporting."
    - name: "franchised_unit_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ownership_model = 'Franchised' THEN unit_id END) / NULLIF(COUNT(DISTINCT unit_id), 0), 2)
      comment: "Percentage of units operating under a franchise model. Asset-light strategy metric — tracks progress toward franchise mix targets set by executive leadership."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`restaurant_unit_ownership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise and ownership structure KPIs covering royalty rates, marketing fees, compliance status, and ownership transfer activity. Used by franchise development, legal, and finance teams to manage the franchise portfolio."
  source: "`restaurants_ecm`.`restaurant`.`unit_ownership`"
  dimensions:
    - name: "unit_ownership_id"
      expr: unit_ownership_id
      comment: "Primary key of the ownership record — atomic grain for ownership analysis."
    - name: "unit_id"
      expr: primary_restaurant_unit_id
      comment: "Restaurant unit associated with this ownership record — enables unit-level ownership analysis."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Type of ownership arrangement (e.g. Franchise, Company-Owned, Joint Venture) — primary segmentation dimension for franchise portfolio analysis."
    - name: "ownership_status"
      expr: ownership_status
      comment: "Current status of the ownership record (e.g. Active, Expired, Transferred) — used to filter active franchise agreements."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the franchisee (e.g. Compliant, Non-Compliant, Under Review) — used in franchise compliance dashboards and audit planning."
    - name: "franchisee_id"
      expr: primary_unit_franchise_partner_franchisee_id
      comment: "Franchisee operating the unit — enables franchisee-level portfolio and compliance analysis."
    - name: "legal_entity_id"
      expr: legal_entity_id
      comment: "Legal entity holding the ownership — supports legal and tax reporting by entity."
    - name: "master_franchise_flag"
      expr: master_franchise_flag
      comment: "Indicates whether this is a master franchise arrangement — used to segment master vs. sub-franchise performance."
    - name: "area_development_agreement_flag"
      expr: area_development_agreement_flag
      comment: "Indicates whether an area development agreement is in place — used to track development pipeline commitments."
    - name: "ownership_effective_start_date"
      expr: ownership_effective_start_date
      comment: "Date the ownership arrangement became effective — used for tenure analysis and agreement lifecycle tracking."
    - name: "franchise_agreement_expiration_date"
      expr: franchise_agreement_expiration_date
      comment: "Expiration date of the franchise agreement — used to proactively manage renewal pipeline and avoid lapses."
  measures:
    - name: "total_ownership_records"
      expr: COUNT(DISTINCT unit_ownership_id)
      comment: "Total count of active ownership records. Measures the size of the franchise and ownership portfolio — baseline for all franchise management KPIs."
    - name: "avg_royalty_rate_pct"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate percentage across franchise agreements. A key revenue driver for the franchisor — deviations from standard rate indicate negotiated exceptions requiring review."
    - name: "avg_marketing_fee_pct"
      expr: AVG(CAST(marketing_fee_percent AS DOUBLE))
      comment: "Average marketing fee percentage across franchise agreements. Tracks fund contribution compliance — used by marketing leadership to size the national advertising fund."
    - name: "avg_ownership_percentage"
      expr: AVG(CAST(ownership_percentage AS DOUBLE))
      comment: "Average ownership percentage across joint venture and partial ownership arrangements. Used to assess equity exposure and consolidation requirements."
    - name: "total_initial_franchise_fees"
      expr: SUM(CAST(initial_franchise_fee_usd AS DOUBLE))
      comment: "Total initial franchise fees collected. A revenue recognition metric for franchise development — tracks new unit fee income and development pipeline value."
    - name: "non_compliant_unit_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN unit_ownership_id END)
      comment: "Count of units with non-compliant ownership status. A risk management KPI — elevated counts trigger franchise compliance intervention programs."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Compliant' THEN unit_ownership_id END) / NULLIF(COUNT(DISTINCT unit_ownership_id), 0), 2)
      comment: "Percentage of ownership records in compliant status. Brand protection metric — used in franchise compliance reviews and regulatory reporting."
    - name: "agreements_expiring_within_90_days"
      expr: COUNT(CASE WHEN franchise_agreement_expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN unit_ownership_id END)
      comment: "Count of franchise agreements expiring within the next 90 days. Renewal pipeline urgency metric — used by franchise development to prioritize renewal outreach and avoid unplanned lapses."
    - name: "ownership_transfer_count"
      expr: COUNT(CASE WHEN ownership_transfer_date IS NOT NULL THEN unit_ownership_id END)
      comment: "Count of ownership records with a recorded transfer. Tracks franchise resale and transfer activity — used to monitor portfolio churn and assess franchisee succession health."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`restaurant_brand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand-level portfolio KPIs covering market position, unit economics benchmarks, and franchise economics. Used by brand management, strategy, and executive leadership to evaluate brand health and competitive positioning."
  source: "`restaurants_ecm`.`restaurant`.`brand`"
  dimensions:
    - name: "brand_id"
      expr: brand_id
      comment: "Primary key of the brand — atomic grain for brand-level analysis."
    - name: "brand_name"
      expr: brand_name
      comment: "Brand name — primary label for brand segmentation in dashboards and reports."
    - name: "brand_category"
      expr: brand_category
      comment: "Category of the brand (e.g. Quick Service, Fast Casual, Fine Dining) — enables cross-segment benchmarking."
    - name: "brand_type"
      expr: brand_type
      comment: "Type classification of the brand — supports portfolio segmentation by brand archetype."
    - name: "brand_status"
      expr: brand_status
      comment: "Current status of the brand (e.g. Active, Sunset, In Development) — used to filter active brands in portfolio analysis."
    - name: "segment"
      expr: segment
      comment: "Market segment the brand competes in — used for competitive benchmarking and strategic portfolio analysis."
    - name: "primary_market_region"
      expr: primary_market_region
      comment: "Primary geographic market region of the brand — supports regional portfolio strategy analysis."
    - name: "headquarters_country_code"
      expr: headquarters_country_code
      comment: "Country of brand headquarters — used for international portfolio segmentation."
    - name: "franchise_allowed"
      expr: franchise_allowed
      comment: "Whether the brand permits franchising — used to segment franchisable vs. company-only brands in development strategy."
    - name: "established_date"
      expr: established_date
      comment: "Date the brand was established — used for brand age cohort analysis and heritage positioning."
  measures:
    - name: "total_brands"
      expr: COUNT(DISTINCT brand_id)
      comment: "Total count of distinct brands in the portfolio. Network breadth metric — used in investor presentations and portfolio strategy reviews."
    - name: "avg_annual_sales_usd"
      expr: AVG(CAST(average_annual_sales_usd AS DOUBLE))
      comment: "Average annual sales per brand in USD. Brand-level revenue benchmark — used to compare brand performance and prioritize investment allocation."
    - name: "total_portfolio_annual_sales"
      expr: SUM(CAST(average_annual_sales_usd AS DOUBLE))
      comment: "Total annualized system sales across all brands. Top-line portfolio revenue metric — used in board reporting and investor communications."
    - name: "avg_check_amount_usd"
      expr: AVG(CAST(average_check_amount_usd AS DOUBLE))
      comment: "Average check amount per brand in USD. Ticket size benchmark — used to evaluate pricing strategy effectiveness and brand positioning relative to competitors."
    - name: "avg_store_size_sqft"
      expr: AVG(CAST(average_store_size_sqft AS DOUBLE))
      comment: "Average store size in square feet across brands. Real estate and capital planning metric — used to size new unit investment requirements and optimize footprint strategy."
    - name: "avg_royalty_fee_pct"
      expr: AVG(CAST(royalty_fee_percent AS DOUBLE))
      comment: "Average royalty fee percentage across brands. Franchise economics metric — used to benchmark brand royalty structures against industry norms and optimize franchise revenue."
    - name: "avg_franchise_fee_pct"
      expr: AVG(CAST(franchise_fee_percent AS DOUBLE))
      comment: "Average franchise fee percentage across brands. Initial fee benchmark — used in franchise development pricing strategy and competitive positioning."
    - name: "avg_market_share_pct"
      expr: AVG(CAST(market_share_percent AS DOUBLE))
      comment: "Average market share percentage across brands. Competitive position metric — used by strategy and marketing leadership to track brand penetration and set growth targets."
    - name: "franchisable_brand_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN franchise_allowed = TRUE THEN brand_id END) / NULLIF(COUNT(DISTINCT brand_id), 0), 2)
      comment: "Percentage of brands that permit franchising. Asset-light strategy metric — tracks the franchise-eligible share of the portfolio for development planning."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`restaurant_area_management`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Area and regional management KPIs covering target performance benchmarks, network composition, and franchise economics by geographic area. Used by field operations, area managers, and regional VPs to manage territory performance."
  source: "`restaurants_ecm`.`restaurant`.`area_management`"
  dimensions:
    - name: "area_management_id"
      expr: area_management_id
      comment: "Primary key of the area management record — atomic grain for area-level analysis."
    - name: "brand_id"
      expr: brand_id
      comment: "Brand associated with the area — enables brand-specific area performance analysis."
    - name: "area_name"
      expr: area_name
      comment: "Name of the area or region — primary label for geographic segmentation in field operations dashboards."
    - name: "area_type"
      expr: area_type
      comment: "Type of area (e.g. Division, Region, District) — supports hierarchical roll-up of area KPIs."
    - name: "area_status"
      expr: area_status
      comment: "Current status of the area (e.g. Active, Inactive) — used to filter active territories in network analysis."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Hierarchy level of the area within the organizational structure — enables drill-down from division to district."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the area — supports macro-level regional performance segmentation."
    - name: "division"
      expr: division
      comment: "Division the area belongs to — enables division-level roll-up for senior field leadership."
    - name: "country_code"
      expr: country_code
      comment: "Country of the area — supports international network segmentation."
    - name: "state_province"
      expr: state_province
      comment: "State or province of the area — enables sub-national geographic analysis."
    - name: "franchise_agreement_flag"
      expr: franchise_agreement_flag
      comment: "Indicates whether the area operates under a franchise agreement — used to segment franchise vs. company-operated areas."
  measures:
    - name: "avg_auv_target"
      expr: AVG(CAST(auv_target AS DOUBLE))
      comment: "Average AUV (Average Unit Volume) target set for areas. Benchmark metric — used to assess how ambitious area targets are and compare against actual unit performance."
    - name: "avg_cogs_percent_target"
      expr: AVG(CAST(cogs_percent_target AS DOUBLE))
      comment: "Average COGS percentage target across areas. Food cost benchmark — used to evaluate whether area targets are aligned with brand standards and identify areas with lax cost targets."
    - name: "avg_labor_percent_target"
      expr: AVG(CAST(labor_percent_target AS DOUBLE))
      comment: "Average labor percentage target across areas. Labor efficiency benchmark — used to ensure area targets are consistent with brand labor standards."
    - name: "avg_csat_target_score"
      expr: AVG(CAST(csat_target_score AS DOUBLE))
      comment: "Average customer satisfaction score target across areas. Guest experience benchmark — used to track whether area CSAT targets are aligned with brand guest experience standards."
    - name: "avg_nps_target_score"
      expr: AVG(CAST(nps_target_score AS DOUBLE))
      comment: "Average Net Promoter Score target across areas. Guest loyalty benchmark — NPS targets are used in area manager scorecards and incentive compensation."
    - name: "avg_sss_target_pct"
      expr: AVG(CAST(sss_target_percent AS DOUBLE))
      comment: "Average same-store sales growth target across areas. Organic growth benchmark — used to evaluate the ambition of area growth plans and compare against actual SSS performance."
    - name: "avg_royalty_rate_pct"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate percentage across areas. Franchise revenue benchmark — used to identify areas with non-standard royalty arrangements requiring review."
    - name: "avg_marketing_fund_contribution_pct"
      expr: AVG(CAST(marketing_fund_contribution_percent AS DOUBLE))
      comment: "Average marketing fund contribution percentage across areas. Fund compliance metric — used to ensure all areas are contributing at the required rate to the national marketing fund."
    - name: "total_areas"
      expr: COUNT(DISTINCT area_management_id)
      comment: "Total count of distinct area management records. Network coverage metric — used to track the organizational span of field management and identify coverage gaps."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`restaurant_equipment_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment asset KPIs covering maintenance compliance, asset condition, financial value, and temperature-critical equipment monitoring. Used by facilities management, operations, and finance to manage asset lifecycle and minimize equipment-related downtime."
  source: "`restaurants_ecm`.`restaurant`.`equipment_asset`"
  dimensions:
    - name: "equipment_asset_id"
      expr: equipment_asset_id
      comment: "Primary key of the equipment asset — atomic grain for asset-level analysis."
    - name: "unit_id"
      expr: primary_equipment_restaurant_unit_id
      comment: "Restaurant unit the equipment is assigned to — enables unit-level asset inventory and maintenance analysis."
    - name: "equipment_category"
      expr: equipment_category
      comment: "Category of equipment (e.g. Cooking, Refrigeration, POS) — used to segment maintenance and replacement costs by equipment type."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Specific type of equipment — enables granular asset analysis within categories."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the equipment (e.g. Active, Out of Service, Decommissioned) — used to track equipment availability and downtime."
    - name: "asset_condition_rating"
      expr: asset_condition_rating
      comment: "Condition rating of the asset (e.g. Good, Fair, Poor) — used to prioritize replacement and maintenance investment."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Whether the asset is owned, leased, or rented — used for capital vs. operating expense classification."
    - name: "temperature_critical_flag"
      expr: temperature_critical_flag
      comment: "Indicates whether the equipment is temperature-critical (e.g. refrigeration, freezers) — used to prioritize food safety monitoring and maintenance urgency."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied to the asset — used in financial reporting and asset valuation analysis."
    - name: "installation_date"
      expr: installation_date
      comment: "Date the equipment was installed — used for asset age analysis and useful life tracking."
    - name: "next_scheduled_maintenance_date"
      expr: next_scheduled_maintenance_date
      comment: "Next scheduled maintenance date — used to identify overdue maintenance and plan preventive maintenance programs."
  measures:
    - name: "total_assets"
      expr: COUNT(DISTINCT equipment_asset_id)
      comment: "Total count of equipment assets across the network. Asset inventory metric — used to size maintenance programs and capital replacement budgets."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost_usd AS DOUBLE))
      comment: "Total acquisition cost of all equipment assets. Capital investment metric — used in asset register reporting and capital expenditure analysis."
    - name: "total_replacement_cost"
      expr: SUM(CAST(replacement_cost_usd AS DOUBLE))
      comment: "Total replacement cost of all equipment assets. Capital planning metric — used to size future replacement budgets and insurance coverage requirements."
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(acquisition_cost_usd AS DOUBLE))
      comment: "Average acquisition cost per equipment asset. Benchmarking metric — used to evaluate procurement efficiency and compare against industry equipment cost norms."
    - name: "temperature_critical_asset_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN temperature_critical_flag = TRUE THEN equipment_asset_id END) / NULLIF(COUNT(DISTINCT equipment_asset_id), 0), 2)
      comment: "Percentage of assets that are temperature-critical. Food safety risk metric — used to size temperature monitoring programs and prioritize maintenance resources."
    - name: "out_of_service_asset_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN operational_status = 'Out of Service' THEN equipment_asset_id END) / NULLIF(COUNT(DISTINCT equipment_asset_id), 0), 2)
      comment: "Percentage of assets currently out of service. Equipment availability metric — elevated rates signal maintenance backlog or capital replacement urgency."
    - name: "maintenance_overdue_count"
      expr: COUNT(CASE WHEN next_scheduled_maintenance_date < CURRENT_DATE AND operational_status != 'Decommissioned' THEN equipment_asset_id END)
      comment: "Count of assets with overdue scheduled maintenance. Operational risk metric — overdue maintenance on food equipment creates food safety and regulatory compliance exposure."
    - name: "replacement_cost_to_acquisition_ratio"
      expr: ROUND(SUM(CAST(replacement_cost_usd AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost_usd AS DOUBLE)), 0), 2)
      comment: "Ratio of total replacement cost to total acquisition cost. Asset inflation metric — a ratio significantly above 1.0 indicates that replacement costs have risen materially, signaling capital budget pressure."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`restaurant_pos_terminal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "POS terminal fleet KPIs covering payment capability coverage, PCI compliance, operational status, and technology readiness. Used by IT operations, finance, and compliance teams to manage the point-of-sale technology estate."
  source: "`restaurants_ecm`.`restaurant`.`pos_terminal`"
  dimensions:
    - name: "pos_terminal_id"
      expr: pos_terminal_id
      comment: "Primary key of the POS terminal — atomic grain for terminal-level analysis."
    - name: "unit_id"
      expr: primary_pos_restaurant_unit_id
      comment: "Restaurant unit the terminal is assigned to — enables unit-level POS fleet analysis."
    - name: "pos_terminal_status"
      expr: pos_terminal_status
      comment: "Current status of the POS terminal (e.g. Active, Inactive, Decommissioned) — used to track active fleet size and terminal lifecycle."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the terminal — used to identify terminals that are down or degraded."
    - name: "pci_compliance_status"
      expr: pci_compliance_status
      comment: "PCI DSS compliance status of the terminal — a critical regulatory compliance dimension for payment security audits."
    - name: "terminal_type"
      expr: terminal_type
      comment: "Type of terminal (e.g. Counter, Drive-Thru, Kiosk, Mobile) — used to analyze fleet composition by service channel."
    - name: "service_channel"
      expr: service_channel
      comment: "Service channel the terminal supports (e.g. Dine-In, Drive-Thru, Delivery) — enables channel-level technology coverage analysis."
    - name: "station_type"
      expr: station_type
      comment: "Station type assignment of the terminal — used for operational layout and throughput analysis."
    - name: "payment_processing_vendor"
      expr: payment_processing_vendor
      comment: "Payment processing vendor for the terminal — used to manage vendor concentration risk and contract negotiations."
    - name: "installation_date"
      expr: installation_date
      comment: "Date the terminal was installed — used for fleet age analysis and refresh cycle planning."
    - name: "next_pci_audit_date"
      expr: next_pci_audit_date
      comment: "Next scheduled PCI audit date — used to manage compliance calendar and avoid audit lapses."
  measures:
    - name: "total_terminals"
      expr: COUNT(DISTINCT pos_terminal_id)
      comment: "Total count of POS terminals across the network. Fleet size metric — used to size IT support, licensing costs, and hardware refresh programs."
    - name: "active_terminal_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN pos_terminal_id END)
      comment: "Count of currently active POS terminals. Operational fleet metric — used to ensure adequate terminal coverage per unit and identify units with insufficient active terminals."
    - name: "active_terminal_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_active = TRUE THEN pos_terminal_id END) / NULLIF(COUNT(DISTINCT pos_terminal_id), 0), 2)
      comment: "Percentage of terminals that are currently active. Fleet utilization metric — low active rates indicate decommissioning lag or hardware failures requiring intervention."
    - name: "pci_compliant_terminal_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pci_compliance_status = 'Compliant' THEN pos_terminal_id END) / NULLIF(COUNT(DISTINCT pos_terminal_id), 0), 2)
      comment: "Percentage of terminals with PCI DSS compliant status. Payment security compliance metric — non-compliant terminals create regulatory and financial liability; tracked in every security audit."
    - name: "contactless_payment_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN supports_contactless = TRUE THEN pos_terminal_id END) / NULLIF(COUNT(DISTINCT pos_terminal_id), 0), 2)
      comment: "Percentage of terminals supporting contactless payment. Digital payment readiness metric — contactless coverage is a guest experience and competitive positioning KPI."
    - name: "mobile_wallet_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN supports_mobile_wallet = TRUE THEN pos_terminal_id END) / NULLIF(COUNT(DISTINCT pos_terminal_id), 0), 2)
      comment: "Percentage of terminals supporting mobile wallet payments (e.g. Apple Pay, Google Pay). Digital payment strategy metric — used to track omnichannel payment readiness across the fleet."
    - name: "olo_enabled_terminal_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN supports_olo = TRUE THEN pos_terminal_id END) / NULLIF(COUNT(DISTINCT pos_terminal_id), 0), 2)
      comment: "Percentage of terminals supporting online ordering integration. Digital channel enablement metric — OLO-enabled terminals are required for seamless online-to-in-store order fulfillment."
    - name: "pci_audit_overdue_count"
      expr: COUNT(CASE WHEN next_pci_audit_date < CURRENT_DATE AND is_active = TRUE THEN pos_terminal_id END)
      comment: "Count of active terminals with overdue PCI audits. Compliance risk metric — overdue PCI audits on active payment terminals create direct regulatory and financial exposure."
    - name: "third_party_delivery_enabled_terminal_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN supports_third_party_delivery = TRUE THEN pos_terminal_id END) / NULLIF(COUNT(DISTINCT pos_terminal_id), 0), 2)
      comment: "Percentage of terminals enabled for third-party delivery integration. Delivery channel readiness metric — used to track technology enablement for delivery revenue streams."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`restaurant_brand_standard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand standard compliance and governance KPIs covering standard coverage, certification requirements, training obligations, and audit frequency. Used by brand operations, quality assurance, and compliance teams to manage brand integrity across the network."
  source: "`restaurants_ecm`.`restaurant`.`brand_standard`"
  dimensions:
    - name: "brand_standard_id"
      expr: brand_standard_id
      comment: "Primary key of the brand standard — atomic grain for standard-level analysis."
    - name: "brand_id"
      expr: brand_id
      comment: "Brand the standard applies to — enables brand-specific compliance analysis."
    - name: "standard_category"
      expr: standard_category
      comment: "Category of the brand standard (e.g. Food Safety, Guest Experience, Operations) — used to segment compliance coverage by standard domain."
    - name: "brand_standard_status"
      expr: brand_standard_status
      comment: "Current status of the standard (e.g. Active, Superseded, Draft) — used to filter active standards in compliance analysis."
    - name: "compliance_requirement_level"
      expr: compliance_requirement_level
      comment: "Requirement level of the standard (e.g. Mandatory, Recommended, Optional) — used to prioritize compliance enforcement and audit focus."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the standard — used to triage non-compliance remediation by business impact."
    - name: "audit_frequency"
      expr: audit_frequency
      comment: "How frequently the standard is audited (e.g. Monthly, Quarterly, Annually) — used in audit planning and resource allocation."
    - name: "applicable_format"
      expr: applicable_format
      comment: "Restaurant format the standard applies to (e.g. Drive-Thru, Dine-In, Delivery) — enables format-specific compliance analysis."
    - name: "applicable_ownership_model"
      expr: applicable_ownership_model
      comment: "Ownership model the standard applies to (e.g. Franchise, Company-Owned) — used to differentiate compliance obligations by ownership type."
    - name: "guest_facing_flag"
      expr: guest_facing_flag
      comment: "Indicates whether the standard directly impacts the guest experience — used to prioritize guest-facing compliance in brand protection programs."
    - name: "certification_required_flag"
      expr: certification_required_flag
      comment: "Indicates whether certification is required for this standard — used to track certification compliance obligations across the network."
    - name: "training_required_flag"
      expr: training_required_flag
      comment: "Indicates whether training is required for this standard — used to size training program scope and track completion."
    - name: "effective_date"
      expr: effective_date
      comment: "Date the standard became effective — used for compliance timeline analysis and new standard rollout tracking."
    - name: "expiry_date"
      expr: expiry_date
      comment: "Date the standard expires — used to proactively manage standard renewal and avoid compliance gaps."
  measures:
    - name: "total_active_standards"
      expr: COUNT(CASE WHEN brand_standard_status = 'Active' THEN brand_standard_id END)
      comment: "Total count of active brand standards. Compliance scope metric — used to size audit programs and assess the breadth of brand standard obligations across the network."
    - name: "mandatory_standard_count"
      expr: COUNT(CASE WHEN compliance_requirement_level = 'Mandatory' THEN brand_standard_id END)
      comment: "Count of mandatory brand standards. Compliance obligation metric — mandatory standards represent non-negotiable brand requirements; their count drives audit scope and enforcement resource needs."
    - name: "certification_required_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_required_flag = TRUE THEN brand_standard_id END) / NULLIF(COUNT(DISTINCT brand_standard_id), 0), 2)
      comment: "Percentage of standards requiring certification. Certification burden metric — used to assess the compliance certification load on franchisees and company-operated units."
    - name: "training_required_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN training_required_flag = TRUE THEN brand_standard_id END) / NULLIF(COUNT(DISTINCT brand_standard_id), 0), 2)
      comment: "Percentage of standards requiring training. Training program scope metric — used to size training content development and delivery requirements."
    - name: "guest_facing_standard_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN guest_facing_flag = TRUE THEN brand_standard_id END) / NULLIF(COUNT(DISTINCT brand_standard_id), 0), 2)
      comment: "Percentage of standards that are guest-facing. Brand protection metric — a high guest-facing percentage indicates that most standards directly impact customer experience, elevating compliance urgency."
    - name: "avg_target_metric_value"
      expr: AVG(CAST(target_metric_value AS DOUBLE))
      comment: "Average target metric value across quantitative brand standards. Benchmark calibration metric — used to assess whether standard targets are aligned with operational capabilities and industry benchmarks."
    - name: "standards_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) AND brand_standard_status = 'Active' THEN brand_standard_id END)
      comment: "Count of active standards expiring within 90 days. Standard renewal urgency metric — used by brand operations to prioritize standard review and renewal to avoid compliance gaps."
    - name: "total_standards"
      expr: COUNT(DISTINCT brand_standard_id)
      comment: "Total count of all brand standards regardless of status. Portfolio completeness metric — used to track the full scope of brand standard governance obligations."
$$;