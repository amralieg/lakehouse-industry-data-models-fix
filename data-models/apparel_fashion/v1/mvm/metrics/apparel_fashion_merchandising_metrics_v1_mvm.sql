-- Metric views for domain: merchandising | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 18:03:30

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`merchandising_assortment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic assortment planning metrics tracking planned units, SKU counts, financial targets (AUR, IMU, MMU, STR), and markdown budgets across seasons, channels, and merchandise hierarchies"
  source: "`apparel_fashion_ecm`.`merchandising`.`assortment_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the assortment plan (e.g., Draft, Approved, In Progress, Closed)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of assortment plan (e.g., Seasonal, Core, Capsule, Limited Edition)"
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel for the assortment (e.g., Retail, E-commerce, Wholesale)"
    - name: "season_year"
      expr: season_year
      comment: "Year of the season for the assortment plan"
    - name: "allocation_strategy"
      expr: allocation_strategy
      comment: "Strategy for allocating inventory across locations (e.g., Push, Pull, Hybrid)"
    - name: "plan_start_month"
      expr: DATE_TRUNC('MONTH', plan_start_date)
      comment: "Month when the assortment plan begins"
    - name: "plan_end_month"
      expr: DATE_TRUNC('MONTH', plan_end_date)
      comment: "Month when the assortment plan ends"
    - name: "is_final_version"
      expr: is_final_version
      comment: "Indicates whether this is the final approved version of the plan"
    - name: "sustainability_certified"
      expr: sustainability_certified
      comment: "Indicates whether the assortment meets sustainability certification requirements"
    - name: "sourcing_country_code"
      expr: sourcing_country_code
      comment: "Country code where products in this assortment are sourced"
  measures:
    - name: "total_assortment_plans"
      expr: COUNT(1)
      comment: "Total number of assortment plans"
    - name: "total_markdown_budget"
      expr: SUM(CAST(markdown_budget_amount AS DOUBLE))
      comment: "Total markdown budget allocated across all assortment plans"
    - name: "avg_aur_target"
      expr: AVG(CAST(aur_target AS DOUBLE))
      comment: "Average Unit Retail target - average planned selling price per unit"
    - name: "avg_imu_target_pct"
      expr: AVG(CAST(imu_target_pct AS DOUBLE))
      comment: "Average Initial Markup percentage target - measures planned margin at first price"
    - name: "avg_mmu_target_pct"
      expr: AVG(CAST(mmu_target_pct AS DOUBLE))
      comment: "Average Maintained Markup percentage target - measures planned margin after markdowns"
    - name: "avg_str_target_pct"
      expr: AVG(CAST(str_target_pct AS DOUBLE))
      comment: "Average Sell-Through Rate percentage target - measures planned inventory turnover efficiency"
    - name: "avg_wos_target"
      expr: AVG(CAST(wos_target AS DOUBLE))
      comment: "Average Weeks of Supply target - measures planned inventory coverage in weeks"
    - name: "avg_carry_forward_pct"
      expr: AVG(CAST(carry_forward_pct AS DOUBLE))
      comment: "Average percentage of inventory planned to carry forward to next season"
    - name: "avg_msrp_midpoint"
      expr: AVG((CAST(msrp_min AS DOUBLE) + CAST(msrp_max AS DOUBLE)) / 2.0)
      comment: "Average midpoint of MSRP range - indicates planned price positioning"
    - name: "sustainability_certified_plan_count"
      expr: SUM(CASE WHEN sustainability_certified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assortment plans that meet sustainability certification requirements"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`merchandising_buy_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Buy plan execution metrics tracking planned vs actual units, costs, retail values, margin targets (IMU, STR), and vendor performance across seasons and channels"
  source: "`apparel_fashion_ecm`.`merchandising`.`buy_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the buy plan (e.g., Draft, Approved, Ordered, Received)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of buy plan (e.g., Initial, Reorder, Fill-in, Closeout)"
    - name: "channel"
      expr: channel
      comment: "Sales channel for the buy plan (e.g., Retail, E-commerce, Wholesale)"
    - name: "sourcing_type"
      expr: sourcing_type
      comment: "Type of sourcing strategy (e.g., Direct, Agent, Domestic, Import)"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the products are manufactured"
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms defining shipping responsibilities (e.g., FOB, CIF, DDP)"
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Indicates whether the buy is for exclusive products"
    - name: "is_nos"
      expr: is_nos
      comment: "Indicates whether the buy is for Never Out of Stock items"
    - name: "ex_factory_month"
      expr: DATE_TRUNC('MONTH', ex_factory_date)
      comment: "Month when products are scheduled to leave the factory"
    - name: "in_dc_month"
      expr: DATE_TRUNC('MONTH', in_dc_date)
      comment: "Month when products are scheduled to arrive at distribution center"
  measures:
    - name: "total_buy_plans"
      expr: COUNT(1)
      comment: "Total number of buy plans"
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_total_cost AS DOUBLE))
      comment: "Total planned cost across all buy plans - key OTB budget tracking metric"
    - name: "total_planned_retail"
      expr: SUM(CAST(planned_total_retail AS DOUBLE))
      comment: "Total planned retail value across all buy plans - measures revenue potential"
    - name: "avg_fob_cost"
      expr: AVG(CAST(fob_cost AS DOUBLE))
      comment: "Average Free On Board cost per buy plan - measures base product cost"
    - name: "avg_ldp_cost"
      expr: AVG(CAST(ldp_cost AS DOUBLE))
      comment: "Average Landed Duty Paid cost per buy plan - measures total delivered cost including duties"
    - name: "avg_msrp"
      expr: AVG(CAST(msrp AS DOUBLE))
      comment: "Average Manufacturer Suggested Retail Price across buy plans"
    - name: "avg_imu_percent"
      expr: AVG(CAST(imu_percent AS DOUBLE))
      comment: "Average Initial Markup percentage - measures planned margin at first price"
    - name: "avg_planned_str_percent"
      expr: AVG(CAST(planned_str_percent AS DOUBLE))
      comment: "Average planned Sell-Through Rate percentage - measures expected inventory turnover"
    - name: "avg_wos_target"
      expr: AVG(CAST(wos_target AS DOUBLE))
      comment: "Average Weeks of Supply target - measures planned inventory coverage"
    - name: "planned_gross_margin"
      expr: SUM(CAST(planned_total_retail AS DOUBLE) - CAST(planned_total_cost AS DOUBLE))
      comment: "Total planned gross margin dollars - key profitability metric for buy plans"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`merchandising_buy_plan_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SKU-level buy plan line metrics tracking unit costs, MSRP, markup percentages, planned vs confirmed units, and markdown allowances for detailed assortment profitability analysis"
  source: "`apparel_fashion_ecm`.`merchandising`.`buy_plan_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the buy plan line (e.g., Planned, Confirmed, Ordered, Received, Cancelled)"
    - name: "channel_code"
      expr: channel_code
      comment: "Sales channel code for the line item"
    - name: "product_category"
      expr: product_category
      comment: "Product category for the line item"
    - name: "season_code"
      expr: season_code
      comment: "Season code for the line item"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the product is manufactured"
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Indicates whether the line item is for an exclusive product"
    - name: "is_never_out_of_stock"
      expr: is_never_out_of_stock
      comment: "Indicates whether the line item is designated as Never Out of Stock"
    - name: "size_run_type"
      expr: size_run_type
      comment: "Type of size run for the line item (e.g., Full, Limited, Extended)"
    - name: "cost_type"
      expr: cost_type
      comment: "Type of cost basis (e.g., FOB, Landed, DDP)"
    - name: "pre_production_sample_status"
      expr: pre_production_sample_status
      comment: "Status of pre-production sample approval"
  measures:
    - name: "total_buy_plan_lines"
      expr: COUNT(1)
      comment: "Total number of buy plan line items - measures assortment breadth"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across all line items - key cost management metric"
    - name: "avg_msrp"
      expr: AVG(CAST(msrp AS DOUBLE))
      comment: "Average MSRP across all line items - measures price positioning"
    - name: "avg_initial_markup_pct"
      expr: AVG(CAST(initial_markup_pct AS DOUBLE))
      comment: "Average Initial Markup percentage - measures planned margin at first price"
    - name: "avg_markdown_allowance_pct"
      expr: AVG(CAST(markdown_allowance_pct AS DOUBLE))
      comment: "Average markdown allowance percentage - measures planned promotional flexibility"
    - name: "avg_planned_sell_through_pct"
      expr: AVG(CAST(planned_sell_through_pct AS DOUBLE))
      comment: "Average planned sell-through rate percentage - measures expected inventory efficiency"
    - name: "total_unit_cost_value"
      expr: SUM(CAST(unit_cost AS DOUBLE))
      comment: "Total unit cost value across all line items - measures total cost exposure"
    - name: "total_msrp_value"
      expr: SUM(CAST(msrp AS DOUBLE))
      comment: "Total MSRP value across all line items - measures total retail potential"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of distinct SKUs in buy plan lines - measures assortment depth"
    - name: "distinct_style_count"
      expr: COUNT(DISTINCT style_id)
      comment: "Count of distinct styles in buy plan lines - measures style breadth"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`merchandising_merchandise_financial_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Top-level merchandise financial planning metrics tracking planned sales, COGS, gross margin, inventory turns, GMROI, OTB budgets, and markdown rates for strategic financial steering"
  source: "`apparel_fashion_ecm`.`merchandising`.`merchandise_financial_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the financial plan (e.g., Draft, Approved, Active, Closed)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of financial plan (e.g., Annual, Seasonal, Monthly, Reforecast)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for the financial plan"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (e.g., Q1, Q2, Month 01) for the financial plan"
    - name: "planning_horizon"
      expr: planning_horizon
      comment: "Planning time horizon (e.g., Short-term, Mid-term, Long-term)"
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy for the plan (e.g., Premium, Value, Competitive, Penetration)"
    - name: "is_locked"
      expr: is_locked
      comment: "Indicates whether the financial plan is locked from further changes"
    - name: "plan_version"
      expr: plan_version
      comment: "Version number of the financial plan"
    - name: "plan_start_month"
      expr: DATE_TRUNC('MONTH', plan_start_date)
      comment: "Month when the financial plan period begins"
    - name: "plan_end_month"
      expr: DATE_TRUNC('MONTH', plan_end_date)
      comment: "Month when the financial plan period ends"
  measures:
    - name: "total_financial_plans"
      expr: COUNT(1)
      comment: "Total number of merchandise financial plans"
    - name: "total_planned_net_sales"
      expr: SUM(CAST(planned_net_sales_amt AS DOUBLE))
      comment: "Total planned net sales amount - primary revenue target metric"
    - name: "total_planned_cogs"
      expr: SUM(CAST(planned_cogs_amt AS DOUBLE))
      comment: "Total planned Cost of Goods Sold - primary cost target metric"
    - name: "total_planned_gross_margin"
      expr: SUM(CAST(planned_gross_margin_amt AS DOUBLE))
      comment: "Total planned gross margin dollars - key profitability metric"
    - name: "avg_planned_gross_margin_pct"
      expr: AVG(CAST(planned_gross_margin_pct AS DOUBLE))
      comment: "Average planned gross margin percentage - measures profitability rate"
    - name: "total_planned_otb"
      expr: SUM(CAST(planned_otb_amt AS DOUBLE))
      comment: "Total planned Open-to-Buy amount - key inventory investment metric"
    - name: "total_planned_markdown"
      expr: SUM(CAST(planned_markdown_amt AS DOUBLE))
      comment: "Total planned markdown amount - measures promotional investment"
    - name: "avg_planned_markdown_pct"
      expr: AVG(CAST(planned_markdown_pct AS DOUBLE))
      comment: "Average planned markdown percentage - measures promotional intensity"
    - name: "avg_planned_imu_pct"
      expr: AVG(CAST(planned_imu_pct AS DOUBLE))
      comment: "Average planned Initial Markup percentage - measures pricing strategy effectiveness"
    - name: "avg_planned_mmu_pct"
      expr: AVG(CAST(planned_mmu_pct AS DOUBLE))
      comment: "Average planned Maintained Markup percentage - measures margin sustainability"
    - name: "avg_planned_str_pct"
      expr: AVG(CAST(planned_str_pct AS DOUBLE))
      comment: "Average planned Sell-Through Rate percentage - measures inventory efficiency"
    - name: "avg_planned_inventory_turns"
      expr: AVG(CAST(planned_inventory_turns AS DOUBLE))
      comment: "Average planned inventory turns - measures inventory velocity"
    - name: "avg_planned_gmroi"
      expr: AVG(CAST(planned_gmroi AS DOUBLE))
      comment: "Average planned Gross Margin Return on Investment - measures inventory productivity"
    - name: "avg_planned_wos"
      expr: AVG(CAST(planned_wos AS DOUBLE))
      comment: "Average planned Weeks of Supply - measures inventory coverage"
    - name: "total_planned_units_sold"
      expr: SUM(CAST(planned_units_sold AS BIGINT))
      comment: "Total planned units sold - measures volume targets"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`merchandising_otb_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Open-to-Buy budget tracking metrics comparing planned vs actual receipts and sales, monitoring OTB spend, variance analysis, and inventory targets for financial control"
  source: "`apparel_fashion_ecm`.`merchandising`.`otb_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the OTB budget (e.g., Active, Exhausted, Suspended, Closed)"
    - name: "budget_year"
      expr: budget_year
      comment: "Budget year for the OTB budget"
    - name: "budget_month"
      expr: budget_month
      comment: "Budget month for the OTB budget"
    - name: "budget_version"
      expr: budget_version
      comment: "Version number of the OTB budget"
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel type for the OTB budget"
    - name: "alert_triggered"
      expr: alert_triggered
      comment: "Indicates whether budget threshold alert has been triggered"
    - name: "source_system"
      expr: source_system
      comment: "Source system for the OTB budget (e.g., Anaplan, SAP, Oracle)"
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month when the OTB budget becomes effective"
    - name: "effective_end_month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
      comment: "Month when the OTB budget expires"
  measures:
    - name: "total_otb_budgets"
      expr: COUNT(1)
      comment: "Total number of OTB budget records"
    - name: "total_otb_cost"
      expr: SUM(CAST(otb_cost AS DOUBLE))
      comment: "Total Open-to-Buy budget at cost - key inventory investment control metric"
    - name: "total_otb_retail"
      expr: SUM(CAST(otb_retail AS DOUBLE))
      comment: "Total Open-to-Buy budget at retail - measures revenue potential of available budget"
    - name: "total_planned_receipts_cost"
      expr: SUM(CAST(planned_receipts_cost AS DOUBLE))
      comment: "Total planned receipts at cost - measures planned inventory investment"
    - name: "total_planned_receipts_retail"
      expr: SUM(CAST(planned_receipts_retail AS DOUBLE))
      comment: "Total planned receipts at retail - measures planned inventory value"
    - name: "total_actual_receipts_cost"
      expr: SUM(CAST(actual_receipts_cost AS DOUBLE))
      comment: "Total actual receipts at cost - measures realized inventory investment"
    - name: "total_actual_receipts_retail"
      expr: SUM(CAST(actual_receipts_retail AS DOUBLE))
      comment: "Total actual receipts at retail - measures realized inventory value"
    - name: "total_planned_sales_retail"
      expr: SUM(CAST(planned_sales_retail AS DOUBLE))
      comment: "Total planned sales at retail - key revenue target metric"
    - name: "total_variance_receipts_retail"
      expr: SUM(CAST(variance_receipts_retail AS DOUBLE))
      comment: "Total variance between planned and actual receipts at retail - measures budget adherence"
    - name: "total_variance_sales_retail"
      expr: SUM(CAST(variance_sales_retail AS DOUBLE))
      comment: "Total variance between planned and actual sales at retail - measures forecast accuracy"
    - name: "total_bom_inventory_cost"
      expr: SUM(CAST(bom_inventory_cost AS DOUBLE))
      comment: "Total Beginning of Month inventory at cost - measures starting inventory position"
    - name: "total_bom_inventory_retail"
      expr: SUM(CAST(bom_inventory_retail AS DOUBLE))
      comment: "Total Beginning of Month inventory at retail - measures starting inventory value"
    - name: "avg_imu_percent"
      expr: AVG(CAST(imu_percent AS DOUBLE))
      comment: "Average Initial Markup percentage - measures pricing strategy"
    - name: "avg_planned_gmroi"
      expr: AVG(CAST(planned_gmroi AS DOUBLE))
      comment: "Average planned Gross Margin Return on Investment - measures inventory productivity target"
    - name: "avg_planned_sell_through_rate"
      expr: AVG(CAST(planned_sell_through_rate AS DOUBLE))
      comment: "Average planned sell-through rate - measures expected inventory turnover"
    - name: "avg_planned_weeks_of_supply"
      expr: AVG(CAST(planned_weeks_of_supply AS DOUBLE))
      comment: "Average planned weeks of supply - measures inventory coverage target"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`merchandising_price_change_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price change event metrics tracking markdown sequences, price change amounts and percentages, margin impact (IMU, MMU), clearance activity, and competitive pricing responses"
  source: "`apparel_fashion_ecm`.`merchandising`.`price_change_event`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of price change (e.g., Markdown, Markup, Promotional, Clearance)"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the price change event (e.g., Pending, Active, Completed, Cancelled)"
    - name: "change_reason_code"
      expr: change_reason_code
      comment: "Code indicating reason for price change (e.g., EOL, Seasonal, Competitive, Overstock)"
    - name: "price_change_level"
      expr: price_change_level
      comment: "Level at which price change is applied (e.g., SKU, Style, Category, Store)"
    - name: "is_clearance"
      expr: is_clearance
      comment: "Indicates whether the price change is for clearance"
    - name: "is_competitive_response"
      expr: is_competitive_response
      comment: "Indicates whether the price change is in response to competitor pricing"
    - name: "is_pos_applied"
      expr: is_pos_applied
      comment: "Indicates whether the price change has been applied to point-of-sale systems"
    - name: "pricing_zone_code"
      expr: pricing_zone_code
      comment: "Pricing zone code for the price change"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month when the price change becomes effective"
    - name: "end_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month when the price change ends"
  measures:
    - name: "total_price_change_events"
      expr: COUNT(1)
      comment: "Total number of price change events - measures pricing activity volume"
    - name: "total_price_change_amount"
      expr: SUM(CAST(price_change_amount AS DOUBLE))
      comment: "Total dollar amount of price changes - measures aggregate markdown investment"
    - name: "avg_price_change_amount"
      expr: AVG(CAST(price_change_amount AS DOUBLE))
      comment: "Average dollar amount per price change - measures typical markdown depth"
    - name: "avg_price_change_percent"
      expr: AVG(CAST(price_change_percent AS DOUBLE))
      comment: "Average percentage of price change - measures markdown rate intensity"
    - name: "avg_original_retail_price"
      expr: AVG(CAST(original_retail_price AS DOUBLE))
      comment: "Average original retail price before change - measures starting price point"
    - name: "avg_new_retail_price"
      expr: AVG(CAST(new_retail_price AS DOUBLE))
      comment: "Average new retail price after change - measures resulting price point"
    - name: "avg_imu_percent"
      expr: AVG(CAST(imu_percent AS DOUBLE))
      comment: "Average Initial Markup percentage at time of change - measures starting margin"
    - name: "avg_mmu_percent"
      expr: AVG(CAST(mmu_percent AS DOUBLE))
      comment: "Average Maintained Markup percentage after change - measures resulting margin"
    - name: "avg_str_at_change"
      expr: AVG(CAST(str_at_change AS DOUBLE))
      comment: "Average Sell-Through Rate at time of price change - measures inventory position"
    - name: "avg_wos_at_change"
      expr: AVG(CAST(wos_at_change AS DOUBLE))
      comment: "Average Weeks of Supply at time of price change - measures inventory coverage"
    - name: "clearance_event_count"
      expr: SUM(CASE WHEN is_clearance = TRUE THEN 1 ELSE 0 END)
      comment: "Count of clearance price change events - measures end-of-life activity"
    - name: "competitive_response_count"
      expr: SUM(CASE WHEN is_competitive_response = TRUE THEN 1 ELSE 0 END)
      comment: "Count of competitive response price changes - measures market reactivity"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of distinct SKUs with price changes - measures breadth of pricing activity"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`merchandising_price_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Master pricing metrics tracking MSRP, cost prices, wholesale prices, margin percentages (IMU, MMU), markdown rates, competitor pricing, and price elasticity for strategic pricing decisions"
  source: "`apparel_fashion_ecm`.`merchandising`.`price_master`"
  dimensions:
    - name: "price_status"
      expr: price_status
      comment: "Current status of the price record (e.g., Active, Pending, Expired, Superseded)"
    - name: "price_type"
      expr: price_type
      comment: "Type of price (e.g., Regular, Promotional, Clearance, Wholesale)"
    - name: "price_tier"
      expr: price_tier
      comment: "Price tier classification (e.g., Premium, Mid, Value, Entry)"
    - name: "sales_channel_type"
      expr: sales_channel_type
      comment: "Sales channel type for the price (e.g., Retail, E-commerce, Wholesale, Outlet)"
    - name: "price_zone_code"
      expr: price_zone_code
      comment: "Pricing zone code for geographic price differentiation"
    - name: "country_code"
      expr: country_code
      comment: "Country code for the price"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the price (e.g., Draft, Pending Approval, Approved, Rejected)"
    - name: "tax_inclusive_flag"
      expr: tax_inclusive_flag
      comment: "Indicates whether the price includes tax"
    - name: "price_change_reason"
      expr: price_change_reason
      comment: "Reason for price change (e.g., Cost Change, Competitive, Promotional, Seasonal)"
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month when the price becomes effective"
  measures:
    - name: "total_price_records"
      expr: COUNT(1)
      comment: "Total number of price master records"
    - name: "avg_msrp"
      expr: AVG(CAST(msrp AS DOUBLE))
      comment: "Average Manufacturer Suggested Retail Price - measures standard retail price positioning"
    - name: "avg_cost_price"
      expr: AVG(CAST(cost_price AS DOUBLE))
      comment: "Average cost price - measures product cost basis"
    - name: "avg_wholesale_price"
      expr: AVG(CAST(wholesale_price AS DOUBLE))
      comment: "Average wholesale price - measures B2B pricing"
    - name: "avg_markdown_price"
      expr: AVG(CAST(markdown_price AS DOUBLE))
      comment: "Average markdown price - measures promotional pricing level"
    - name: "avg_competitor_price"
      expr: AVG(CAST(competitor_price AS DOUBLE))
      comment: "Average competitor price - measures competitive price positioning"
    - name: "avg_min_advertised_price"
      expr: AVG(CAST(min_advertised_price AS DOUBLE))
      comment: "Average minimum advertised price - measures MAP policy compliance"
    - name: "avg_imu_percent"
      expr: AVG(CAST(imu_percent AS DOUBLE))
      comment: "Average Initial Markup percentage - measures pricing strategy effectiveness"
    - name: "avg_mmu_percent"
      expr: AVG(CAST(mmu_percent AS DOUBLE))
      comment: "Average Maintained Markup percentage - measures realized margin after markdowns"
    - name: "avg_markdown_percent"
      expr: AVG(CAST(markdown_percent AS DOUBLE))
      comment: "Average markdown percentage - measures promotional intensity"
    - name: "avg_aur"
      expr: AVG(CAST(aur AS DOUBLE))
      comment: "Average Unit Retail - measures actual selling price achieved"
    - name: "avg_price_elasticity_index"
      expr: AVG(CAST(price_elasticity_index AS DOUBLE))
      comment: "Average price elasticity index - measures demand sensitivity to price changes"
    - name: "avg_fob_cost"
      expr: AVG(CAST(fob_cost AS DOUBLE))
      comment: "Average Free On Board cost - measures base product cost"
    - name: "avg_landed_duty_paid_cost"
      expr: AVG(CAST(landed_duty_paid_cost AS DOUBLE))
      comment: "Average Landed Duty Paid cost - measures total delivered cost"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of distinct SKUs with pricing - measures pricing coverage"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`merchandising_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion performance metrics tracking planned vs actual revenue and units, discount rates, lift percentages, GMROI impact, sell-through rates, and markdown budget utilization"
  source: "`apparel_fashion_ecm`.`merchandising`.`promotion`"
  dimensions:
    - name: "promotion_status"
      expr: promotion_status
      comment: "Current status of the promotion (e.g., Planned, Active, Completed, Cancelled)"
    - name: "promotion_type"
      expr: promotion_type
      comment: "Type of promotion (e.g., Percentage Off, BOGO, Fixed Price, Bundle, Gift with Purchase)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the promotion (e.g., Draft, Pending, Approved, Rejected)"
    - name: "channel_applicability"
      expr: channel_applicability
      comment: "Channels where the promotion is applicable (e.g., All, Retail Only, Online Only)"
    - name: "merchandise_scope"
      expr: merchandise_scope
      comment: "Merchandise scope of the promotion (e.g., Category, Brand, Style, SKU)"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the promotion (e.g., National, Regional, Store-specific)"
    - name: "coupon_required"
      expr: coupon_required
      comment: "Indicates whether a coupon code is required for the promotion"
    - name: "is_loyalty_exclusive"
      expr: is_loyalty_exclusive
      comment: "Indicates whether the promotion is exclusive to loyalty program members"
    - name: "stackable"
      expr: stackable
      comment: "Indicates whether the promotion can be combined with other promotions"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when the promotion starts"
  measures:
    - name: "total_promotions"
      expr: COUNT(1)
      comment: "Total number of promotions - measures promotional activity volume"
    - name: "total_planned_revenue"
      expr: SUM(CAST(planned_revenue AS DOUBLE))
      comment: "Total planned revenue from promotions - measures expected promotional sales"
    - name: "total_actual_revenue"
      expr: SUM(CAST(actual_revenue AS DOUBLE))
      comment: "Total actual revenue from promotions - measures realized promotional sales"
    - name: "total_markdown_budget"
      expr: SUM(CAST(markdown_budget AS DOUBLE))
      comment: "Total markdown budget allocated to promotions - measures promotional investment"
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate across promotions - measures promotional depth"
    - name: "avg_planned_lift_pct"
      expr: AVG(CAST(planned_lift_pct AS DOUBLE))
      comment: "Average planned lift percentage - measures expected incremental sales impact"
    - name: "avg_actual_lift_pct"
      expr: AVG(CAST(actual_lift_pct AS DOUBLE))
      comment: "Average actual lift percentage - measures realized incremental sales impact"
    - name: "avg_gmroi_impact"
      expr: AVG(CAST(gmroi_impact AS DOUBLE))
      comment: "Average GMROI impact - measures promotional return on inventory investment"
    - name: "avg_sell_through_rate"
      expr: AVG(CAST(sell_through_rate AS DOUBLE))
      comment: "Average sell-through rate during promotions - measures inventory turnover effectiveness"
    - name: "avg_minimum_purchase_amount"
      expr: AVG(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Average minimum purchase amount required - measures promotional threshold"
    - name: "avg_fixed_price_amount"
      expr: AVG(CAST(fixed_price_amount AS DOUBLE))
      comment: "Average fixed price amount for fixed-price promotions"
    - name: "loyalty_exclusive_count"
      expr: SUM(CASE WHEN is_loyalty_exclusive = TRUE THEN 1 ELSE 0 END)
      comment: "Count of loyalty-exclusive promotions - measures loyalty program engagement"
    - name: "stackable_promotion_count"
      expr: SUM(CASE WHEN stackable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of stackable promotions - measures promotional flexibility"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`merchandising_season`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Seasonal planning metrics tracking planned sales, gross margin, IMU, STR, OTB budgets, SKU and style counts, and delivery schedules for seasonal assortment strategy"
  source: "`apparel_fashion_ecm`.`merchandising`.`season`"
  dimensions:
    - name: "season_status"
      expr: season_status
      comment: "Current status of the season (e.g., Planning, Active, Closed, Archived)"
    - name: "season_type"
      expr: season_type
      comment: "Type of season (e.g., Spring, Summer, Fall, Winter, Holiday, Transitional)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for the season"
    - name: "fiscal_half"
      expr: fiscal_half
      comment: "Fiscal half (H1 or H2) for the season"
    - name: "gender_target"
      expr: gender_target
      comment: "Target gender for the season (e.g., Men, Women, Kids, Unisex)"
    - name: "channel_scope"
      expr: channel_scope
      comment: "Channel scope for the season (e.g., All Channels, Retail Only, E-commerce Only)"
    - name: "region_scope"
      expr: region_scope
      comment: "Regional scope for the season (e.g., Global, North America, EMEA, APAC)"
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the season is currently active"
    - name: "is_nos"
      expr: is_nos
      comment: "Indicates whether the season includes Never Out of Stock items"
    - name: "markdown_cadence"
      expr: markdown_cadence
      comment: "Markdown cadence for the season (e.g., Weekly, Bi-weekly, Monthly)"
  measures:
    - name: "total_seasons"
      expr: COUNT(1)
      comment: "Total number of seasons"
    - name: "total_planned_sales"
      expr: SUM(CAST(planned_sales_amount AS DOUBLE))
      comment: "Total planned sales amount across all seasons - key revenue target metric"
    - name: "total_otb_budget"
      expr: SUM(CAST(otb_budget_amount AS DOUBLE))
      comment: "Total Open-to-Buy budget across all seasons - measures inventory investment"
    - name: "avg_planned_gross_margin_pct"
      expr: AVG(CAST(planned_gross_margin_pct AS DOUBLE))
      comment: "Average planned gross margin percentage - measures profitability target"
    - name: "avg_planned_imu_pct"
      expr: AVG(CAST(planned_imu_pct AS DOUBLE))
      comment: "Average planned Initial Markup percentage - measures pricing strategy"
    - name: "avg_planned_str_pct"
      expr: AVG(CAST(planned_str_pct AS DOUBLE))
      comment: "Average planned Sell-Through Rate percentage - measures inventory efficiency target"
    - name: "avg_weeks_of_supply_target"
      expr: AVG(CAST(weeks_of_supply_target AS DOUBLE))
      comment: "Average weeks of supply target - measures inventory coverage goal"
    - name: "active_season_count"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of active seasons - measures current seasonal activity"
    - name: "nos_season_count"
      expr: SUM(CASE WHEN is_nos = TRUE THEN 1 ELSE 0 END)
      comment: "Count of seasons with Never Out of Stock items - measures core assortment strategy"
$$;