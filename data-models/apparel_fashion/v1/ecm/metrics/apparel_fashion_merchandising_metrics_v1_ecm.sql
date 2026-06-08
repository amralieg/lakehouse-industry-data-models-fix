-- Metric views for domain: merchandising | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 15:42:09

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`merchandising_allocation_detail`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Allocation execution metrics tracking planned vs actual shipment and receipt performance, OTIF compliance, and inventory flow efficiency"
  source: "`apparel_fashion_ecm`.`merchandising`.`allocation_detail`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the allocation (e.g., planned, shipped, received, cancelled)"
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate inventory (e.g., store-grade, size-curve, manual)"
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel receiving the allocation (e.g., retail, wholesale, e-commerce)"
    - name: "location_type"
      expr: location_type
      comment: "Type of destination location (e.g., store, DC, franchise)"
    - name: "otif_status"
      expr: otif_status
      comment: "On-time in-full delivery status (e.g., on-time, late, short)"
    - name: "is_replenishment"
      expr: is_replenishment
      comment: "Flag indicating whether this is a replenishment allocation vs initial allocation"
    - name: "season_code"
      expr: season_code
      comment: "Season code for the allocated merchandise"
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month when the allocation was created"
    - name: "planned_ship_month"
      expr: DATE_TRUNC('MONTH', planned_ship_date)
      comment: "Planned shipment month"
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total number of allocation detail records"
    - name: "total_planned_units"
      expr: SUM(CAST(planned_qty AS DOUBLE))
      comment: "Total units planned for allocation"
    - name: "total_shipped_units"
      expr: SUM(CAST(shipped_qty AS DOUBLE))
      comment: "Total units actually shipped"
    - name: "total_received_units"
      expr: SUM(CAST(received_qty AS DOUBLE))
      comment: "Total units received at destination"
    - name: "total_allocation_retail_value"
      expr: SUM(CAST(msrp AS DOUBLE) * CAST(planned_qty AS DOUBLE))
      comment: "Total retail value of planned allocations (MSRP × planned quantity)"
    - name: "total_allocation_cost_value"
      expr: SUM(CAST(unit_cost AS DOUBLE) * CAST(planned_qty AS DOUBLE))
      comment: "Total cost value of planned allocations (unit cost × planned quantity)"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across allocations"
    - name: "avg_msrp"
      expr: AVG(CAST(msrp AS DOUBLE))
      comment: "Average MSRP across allocations"
    - name: "otif_compliant_allocations"
      expr: COUNT(CASE WHEN otif_status = 'on-time' THEN 1 END)
      comment: "Count of allocations delivered on-time in-full"
    - name: "avg_wos_target"
      expr: AVG(CAST(wos_target AS DOUBLE))
      comment: "Average weeks-of-supply target across allocations"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`merchandising_allocation_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic allocation planning metrics tracking planned vs actual unit distribution, store coverage, and allocation efficiency by channel and cluster"
  source: "`apparel_fashion_ecm`.`merchandising`.`allocation_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the allocation plan (e.g., draft, approved, executed, closed)"
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation (e.g., initial, replenishment, markdown)"
    - name: "channel"
      expr: channel
      comment: "Sales channel for the allocation plan"
    - name: "is_manual_override"
      expr: is_manual_override
      comment: "Flag indicating whether the plan was manually overridden vs system-generated"
    - name: "is_nos_eligible"
      expr: is_nos_eligible
      comment: "Flag indicating whether the plan is eligible for never-out-of-stock replenishment"
    - name: "plan_month"
      expr: DATE_TRUNC('MONTH', plan_date)
      comment: "Month when the allocation plan was created"
    - name: "in_store_month"
      expr: DATE_TRUNC('MONTH', in_store_date)
      comment: "Target month for merchandise to be in stores"
  measures:
    - name: "total_allocation_plans"
      expr: COUNT(1)
      comment: "Total number of allocation plans"
    - name: "total_planned_units"
      expr: SUM(CAST(total_planned_units AS DOUBLE))
      comment: "Total units planned across all allocation plans"
    - name: "total_actual_units"
      expr: SUM(CAST(total_actual_units AS DOUBLE))
      comment: "Total units actually allocated"
    - name: "total_unallocated_units"
      expr: SUM(CAST(unallocated_units AS DOUBLE))
      comment: "Total units remaining unallocated"
    - name: "total_planned_retail_value"
      expr: SUM(CAST(msrp AS DOUBLE) * CAST(total_planned_units AS DOUBLE))
      comment: "Total retail value of planned allocations"
    - name: "total_planned_cost_value"
      expr: SUM(CAST(cost_per_unit AS DOUBLE) * CAST(total_planned_units AS DOUBLE))
      comment: "Total cost value of planned allocations"
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit across allocation plans"
    - name: "avg_msrp"
      expr: AVG(CAST(msrp AS DOUBLE))
      comment: "Average MSRP across allocation plans"
    - name: "avg_str_target_pct"
      expr: AVG(CAST(str_target_pct AS DOUBLE))
      comment: "Average sell-through rate target percentage"
    - name: "avg_wos_target"
      expr: AVG(CAST(wos_target AS DOUBLE))
      comment: "Average weeks-of-supply target"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`merchandising_assortment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assortment planning metrics tracking style and SKU breadth, margin targets, and channel allocation strategy effectiveness"
  source: "`apparel_fashion_ecm`.`merchandising`.`assortment_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the assortment plan (e.g., draft, approved, in-execution, closed)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of assortment plan (e.g., seasonal, capsule, core)"
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel for the assortment"
    - name: "allocation_strategy"
      expr: allocation_strategy
      comment: "Strategy used for allocating the assortment (e.g., store-grade, cluster, manual)"
    - name: "is_final_version"
      expr: is_final_version
      comment: "Flag indicating whether this is the final approved version"
    - name: "replenishment_eligible"
      expr: replenishment_eligible
      comment: "Flag indicating whether the assortment is eligible for replenishment"
    - name: "sustainability_certified"
      expr: sustainability_certified
      comment: "Flag indicating whether the assortment meets sustainability certification requirements"
    - name: "plan_start_month"
      expr: DATE_TRUNC('MONTH', plan_start_date)
      comment: "Month when the assortment plan starts"
    - name: "season_year"
      expr: season_year
      comment: "Year of the season for the assortment"
  measures:
    - name: "total_assortment_plans"
      expr: COUNT(1)
      comment: "Total number of assortment plans"
    - name: "total_style_count_planned"
      expr: SUM(CAST(style_count_planned AS DOUBLE))
      comment: "Total number of styles planned across all assortments"
    - name: "total_sku_count_planned"
      expr: SUM(CAST(total_sku_count_planned AS DOUBLE))
      comment: "Total number of SKUs planned across all assortments"
    - name: "total_otb_units_planned"
      expr: SUM(CAST(otb_units_planned AS DOUBLE))
      comment: "Total open-to-buy units planned"
    - name: "total_markdown_budget"
      expr: SUM(CAST(markdown_budget_amount AS DOUBLE))
      comment: "Total markdown budget allocated across assortment plans"
    - name: "avg_aur_target"
      expr: AVG(CAST(aur_target AS DOUBLE))
      comment: "Average unit retail target across assortment plans"
    - name: "avg_imu_target_pct"
      expr: AVG(CAST(imu_target_pct AS DOUBLE))
      comment: "Average initial markup target percentage"
    - name: "avg_mmu_target_pct"
      expr: AVG(CAST(mmu_target_pct AS DOUBLE))
      comment: "Average maintained markup target percentage"
    - name: "avg_str_target_pct"
      expr: AVG(CAST(str_target_pct AS DOUBLE))
      comment: "Average sell-through rate target percentage"
    - name: "avg_wos_target"
      expr: AVG(CAST(wos_target AS DOUBLE))
      comment: "Average weeks-of-supply target"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`merchandising_buy_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Buy plan financial metrics tracking planned purchases, cost structure, margin targets, and sourcing efficiency"
  source: "`apparel_fashion_ecm`.`merchandising`.`buy_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the buy plan (e.g., draft, approved, ordered, received)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of buy plan (e.g., seasonal, replenishment, special-buy)"
    - name: "channel"
      expr: channel
      comment: "Sales channel for the buy plan"
    - name: "sourcing_type"
      expr: sourcing_type
      comment: "Type of sourcing (e.g., direct, agent, domestic)"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the merchandise is manufactured"
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Flag indicating whether the buy is exclusive to this retailer"
    - name: "is_nos"
      expr: is_nos
      comment: "Flag indicating whether the buy is never-out-of-stock eligible"
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms defining cost and risk transfer"
    - name: "approved_month"
      expr: DATE_TRUNC('MONTH', approved_date)
      comment: "Month when the buy plan was approved"
  measures:
    - name: "total_buy_plans"
      expr: COUNT(1)
      comment: "Total number of buy plans"
    - name: "total_planned_units"
      expr: SUM(CAST(planned_units AS DOUBLE))
      comment: "Total units planned for purchase"
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_total_cost AS DOUBLE))
      comment: "Total planned cost of purchases"
    - name: "total_planned_retail"
      expr: SUM(CAST(planned_total_retail AS DOUBLE))
      comment: "Total planned retail value of purchases"
    - name: "avg_fob_cost"
      expr: AVG(CAST(fob_cost AS DOUBLE))
      comment: "Average free-on-board cost per unit"
    - name: "avg_ldp_cost"
      expr: AVG(CAST(ldp_cost AS DOUBLE))
      comment: "Average landed duty paid cost per unit"
    - name: "avg_msrp"
      expr: AVG(CAST(msrp AS DOUBLE))
      comment: "Average manufacturer suggested retail price"
    - name: "avg_imu_percent"
      expr: AVG(CAST(imu_percent AS DOUBLE))
      comment: "Average initial markup percentage"
    - name: "avg_planned_str_percent"
      expr: AVG(CAST(planned_str_percent AS DOUBLE))
      comment: "Average planned sell-through rate percentage"
    - name: "avg_wos_target"
      expr: AVG(CAST(wos_target AS DOUBLE))
      comment: "Average weeks-of-supply target"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`merchandising_buy_plan_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SKU-level buy plan metrics tracking unit economics, markup performance, and sourcing compliance"
  source: "`apparel_fashion_ecm`.`merchandising`.`buy_plan_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the buy plan line (e.g., planned, confirmed, cancelled)"
    - name: "channel_code"
      expr: channel_code
      comment: "Sales channel code for the line item"
    - name: "product_category"
      expr: product_category
      comment: "Product category of the line item"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the merchandise"
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Flag indicating whether the item is exclusive"
    - name: "is_never_out_of_stock"
      expr: is_never_out_of_stock
      comment: "Flag indicating whether the item is never-out-of-stock eligible"
    - name: "season_code"
      expr: season_code
      comment: "Season code for the merchandise"
    - name: "size_run_type"
      expr: size_run_type
      comment: "Type of size run (e.g., full, abbreviated, single)"
    - name: "planned_receipt_month"
      expr: DATE_TRUNC('MONTH', planned_receipt_date)
      comment: "Planned month for merchandise receipt"
  measures:
    - name: "total_buy_plan_lines"
      expr: COUNT(1)
      comment: "Total number of buy plan line items"
    - name: "total_planned_units"
      expr: SUM(CAST(planned_units AS DOUBLE))
      comment: "Total units planned across all line items"
    - name: "total_confirmed_units"
      expr: SUM(CAST(confirmed_units AS DOUBLE))
      comment: "Total units confirmed with vendors"
    - name: "total_revised_units"
      expr: SUM(CAST(revised_units AS DOUBLE))
      comment: "Total units after revisions"
    - name: "total_planned_cost"
      expr: SUM(CAST(unit_cost AS DOUBLE) * CAST(planned_units AS DOUBLE))
      comment: "Total planned cost value (unit cost × planned units)"
    - name: "total_planned_retail"
      expr: SUM(CAST(msrp AS DOUBLE) * CAST(planned_units AS DOUBLE))
      comment: "Total planned retail value (MSRP × planned units)"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across line items"
    - name: "avg_msrp"
      expr: AVG(CAST(msrp AS DOUBLE))
      comment: "Average MSRP across line items"
    - name: "avg_initial_markup_pct"
      expr: AVG(CAST(initial_markup_pct AS DOUBLE))
      comment: "Average initial markup percentage"
    - name: "avg_planned_sell_through_pct"
      expr: AVG(CAST(planned_sell_through_pct AS DOUBLE))
      comment: "Average planned sell-through rate percentage"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`merchandising_merchandise_financial_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Top-line merchandise financial planning metrics tracking sales, margin, inventory turns, and GMROI targets by department and channel"
  source: "`apparel_fashion_ecm`.`merchandising`.`merchandise_financial_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the financial plan (e.g., draft, approved, locked, closed)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of financial plan (e.g., annual, seasonal, monthly)"
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel for the plan"
    - name: "department_code"
      expr: department_code
      comment: "Department code"
    - name: "class_code"
      expr: class_code
      comment: "Class code within the department"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the plan"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (e.g., Q1, Q2, M01)"
    - name: "is_locked"
      expr: is_locked
      comment: "Flag indicating whether the plan is locked from further edits"
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy for the plan (e.g., premium, value, promotional)"
    - name: "plan_start_month"
      expr: DATE_TRUNC('MONTH', plan_start_date)
      comment: "Month when the plan period starts"
  measures:
    - name: "total_financial_plans"
      expr: COUNT(1)
      comment: "Total number of merchandise financial plans"
    - name: "total_planned_net_sales"
      expr: SUM(CAST(planned_net_sales_amt AS DOUBLE))
      comment: "Total planned net sales amount"
    - name: "total_planned_cogs"
      expr: SUM(CAST(planned_cogs_amt AS DOUBLE))
      comment: "Total planned cost of goods sold"
    - name: "total_planned_gross_margin"
      expr: SUM(CAST(planned_gross_margin_amt AS DOUBLE))
      comment: "Total planned gross margin amount"
    - name: "total_planned_markdown"
      expr: SUM(CAST(planned_markdown_amt AS DOUBLE))
      comment: "Total planned markdown amount"
    - name: "total_planned_otb"
      expr: SUM(CAST(planned_otb_amt AS DOUBLE))
      comment: "Total planned open-to-buy amount"
    - name: "total_planned_receipts"
      expr: SUM(CAST(planned_receipts_amt AS DOUBLE))
      comment: "Total planned receipts amount"
    - name: "total_planned_units_sold"
      expr: SUM(CAST(planned_units_sold AS DOUBLE))
      comment: "Total planned units sold"
    - name: "avg_planned_aur"
      expr: AVG(CAST(planned_aur AS DOUBLE))
      comment: "Average planned unit retail"
    - name: "avg_planned_gross_margin_pct"
      expr: AVG(CAST(planned_gross_margin_pct AS DOUBLE))
      comment: "Average planned gross margin percentage"
    - name: "avg_planned_imu_pct"
      expr: AVG(CAST(planned_imu_pct AS DOUBLE))
      comment: "Average planned initial markup percentage"
    - name: "avg_planned_mmu_pct"
      expr: AVG(CAST(planned_mmu_pct AS DOUBLE))
      comment: "Average planned maintained markup percentage"
    - name: "avg_planned_str_pct"
      expr: AVG(CAST(planned_str_pct AS DOUBLE))
      comment: "Average planned sell-through rate percentage"
    - name: "avg_planned_gmroi"
      expr: AVG(CAST(planned_gmroi AS DOUBLE))
      comment: "Average planned gross margin return on investment"
    - name: "avg_planned_inventory_turns"
      expr: AVG(CAST(planned_inventory_turns AS DOUBLE))
      comment: "Average planned inventory turns"
    - name: "avg_planned_wos"
      expr: AVG(CAST(planned_wos AS DOUBLE))
      comment: "Average planned weeks of supply"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`merchandising_otb_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Open-to-buy budget tracking metrics measuring planned vs actual receipts, sales variance, and inventory position by month and channel"
  source: "`apparel_fashion_ecm`.`merchandising`.`otb_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Status of the OTB budget (e.g., active, locked, closed)"
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel for the budget"
    - name: "budget_year"
      expr: budget_year
      comment: "Year of the budget"
    - name: "budget_month"
      expr: budget_month
      comment: "Month of the budget"
    - name: "alert_triggered"
      expr: alert_triggered
      comment: "Flag indicating whether a budget alert has been triggered"
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month when the budget becomes effective"
  measures:
    - name: "total_otb_budgets"
      expr: COUNT(1)
      comment: "Total number of OTB budget records"
    - name: "total_otb_cost"
      expr: SUM(CAST(otb_cost AS DOUBLE))
      comment: "Total open-to-buy at cost"
    - name: "total_otb_retail"
      expr: SUM(CAST(otb_retail AS DOUBLE))
      comment: "Total open-to-buy at retail"
    - name: "total_planned_receipts_cost"
      expr: SUM(CAST(planned_receipts_cost AS DOUBLE))
      comment: "Total planned receipts at cost"
    - name: "total_planned_receipts_retail"
      expr: SUM(CAST(planned_receipts_retail AS DOUBLE))
      comment: "Total planned receipts at retail"
    - name: "total_actual_receipts_cost"
      expr: SUM(CAST(actual_receipts_cost AS DOUBLE))
      comment: "Total actual receipts at cost"
    - name: "total_actual_receipts_retail"
      expr: SUM(CAST(actual_receipts_retail AS DOUBLE))
      comment: "Total actual receipts at retail"
    - name: "total_planned_sales_retail"
      expr: SUM(CAST(planned_sales_retail AS DOUBLE))
      comment: "Total planned sales at retail"
    - name: "total_planned_markdown_retail"
      expr: SUM(CAST(planned_markdown_retail AS DOUBLE))
      comment: "Total planned markdown at retail"
    - name: "total_variance_receipts_retail"
      expr: SUM(CAST(variance_receipts_retail AS DOUBLE))
      comment: "Total variance between planned and actual receipts at retail"
    - name: "total_variance_sales_retail"
      expr: SUM(CAST(variance_sales_retail AS DOUBLE))
      comment: "Total variance between planned and actual sales at retail"
    - name: "avg_imu_percent"
      expr: AVG(CAST(imu_percent AS DOUBLE))
      comment: "Average initial markup percentage"
    - name: "avg_planned_gmroi"
      expr: AVG(CAST(planned_gmroi AS DOUBLE))
      comment: "Average planned gross margin return on investment"
    - name: "avg_planned_sell_through_rate"
      expr: AVG(CAST(planned_sell_through_rate AS DOUBLE))
      comment: "Average planned sell-through rate"
    - name: "avg_planned_weeks_of_supply"
      expr: AVG(CAST(planned_weeks_of_supply AS DOUBLE))
      comment: "Average planned weeks of supply"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`merchandising_price_change_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price change and markdown event metrics tracking markdown depth, frequency, inventory exposure, and margin impact"
  source: "`apparel_fashion_ecm`.`merchandising`.`price_change_event`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of price change (e.g., markdown, markup, promotional)"
    - name: "change_reason_code"
      expr: change_reason_code
      comment: "Reason code for the price change"
    - name: "event_status"
      expr: event_status
      comment: "Status of the price change event (e.g., pending, applied, cancelled)"
    - name: "channel"
      expr: channel
      comment: "Sales channel where the price change applies"
    - name: "is_clearance"
      expr: is_clearance
      comment: "Flag indicating whether this is a clearance markdown"
    - name: "is_competitive_response"
      expr: is_competitive_response
      comment: "Flag indicating whether the price change is in response to competitor pricing"
    - name: "is_pos_applied"
      expr: is_pos_applied
      comment: "Flag indicating whether the price change has been applied to point-of-sale systems"
    - name: "price_change_level"
      expr: price_change_level
      comment: "Level at which the price change is applied (e.g., SKU, style, class)"
    - name: "season_code"
      expr: season_code
      comment: "Season code for the merchandise"
    - name: "department_code"
      expr: department_code
      comment: "Department code"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month when the price change becomes effective"
  measures:
    - name: "total_price_change_events"
      expr: COUNT(1)
      comment: "Total number of price change events"
    - name: "total_units_on_hand"
      expr: SUM(CAST(units_on_hand AS DOUBLE))
      comment: "Total units on hand affected by price changes"
    - name: "total_markdown_amount"
      expr: SUM(CAST(price_change_amount AS DOUBLE))
      comment: "Total markdown amount (negative price change)"
    - name: "total_original_retail_value"
      expr: SUM(CAST(original_retail_price AS DOUBLE) * CAST(units_on_hand AS DOUBLE))
      comment: "Total retail value at original price"
    - name: "total_new_retail_value"
      expr: SUM(CAST(new_retail_price AS DOUBLE) * CAST(units_on_hand AS DOUBLE))
      comment: "Total retail value at new price"
    - name: "avg_original_retail_price"
      expr: AVG(CAST(original_retail_price AS DOUBLE))
      comment: "Average original retail price"
    - name: "avg_new_retail_price"
      expr: AVG(CAST(new_retail_price AS DOUBLE))
      comment: "Average new retail price"
    - name: "avg_price_change_percent"
      expr: AVG(CAST(price_change_percent AS DOUBLE))
      comment: "Average price change percentage"
    - name: "avg_imu_percent"
      expr: AVG(CAST(imu_percent AS DOUBLE))
      comment: "Average initial markup percentage at time of change"
    - name: "avg_mmu_percent"
      expr: AVG(CAST(mmu_percent AS DOUBLE))
      comment: "Average maintained markup percentage at time of change"
    - name: "avg_str_at_change"
      expr: AVG(CAST(str_at_change AS DOUBLE))
      comment: "Average sell-through rate at time of price change"
    - name: "avg_wos_at_change"
      expr: AVG(CAST(wos_at_change AS DOUBLE))
      comment: "Average weeks of supply at time of price change"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`merchandising_price_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Master pricing metrics tracking cost structure, markup performance, price elasticity, and competitive positioning by SKU and channel"
  source: "`apparel_fashion_ecm`.`merchandising`.`price_master`"
  dimensions:
    - name: "price_status"
      expr: price_status
      comment: "Status of the price record (e.g., active, pending, expired)"
    - name: "price_type"
      expr: price_type
      comment: "Type of price (e.g., regular, promotional, clearance)"
    - name: "price_tier"
      expr: price_tier
      comment: "Price tier (e.g., premium, mid, value)"
    - name: "sales_channel_type"
      expr: sales_channel_type
      comment: "Sales channel type for the price"
    - name: "country_code"
      expr: country_code
      comment: "Country code for the price"
    - name: "price_zone_code"
      expr: price_zone_code
      comment: "Pricing zone code"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the price (e.g., approved, pending, rejected)"
    - name: "tax_inclusive_flag"
      expr: tax_inclusive_flag
      comment: "Flag indicating whether the price includes tax"
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month when the price becomes effective"
  measures:
    - name: "total_price_records"
      expr: COUNT(1)
      comment: "Total number of price master records"
    - name: "avg_msrp"
      expr: AVG(CAST(msrp AS DOUBLE))
      comment: "Average manufacturer suggested retail price"
    - name: "avg_cost_price"
      expr: AVG(CAST(cost_price AS DOUBLE))
      comment: "Average cost price"
    - name: "avg_fob_cost"
      expr: AVG(CAST(fob_cost AS DOUBLE))
      comment: "Average free-on-board cost"
    - name: "avg_landed_duty_paid_cost"
      expr: AVG(CAST(landed_duty_paid_cost AS DOUBLE))
      comment: "Average landed duty paid cost"
    - name: "avg_wholesale_price"
      expr: AVG(CAST(wholesale_price AS DOUBLE))
      comment: "Average wholesale price"
    - name: "avg_transfer_price"
      expr: AVG(CAST(transfer_price AS DOUBLE))
      comment: "Average transfer price between entities"
    - name: "avg_markdown_price"
      expr: AVG(CAST(markdown_price AS DOUBLE))
      comment: "Average markdown price"
    - name: "avg_aur"
      expr: AVG(CAST(aur AS DOUBLE))
      comment: "Average unit retail (actual selling price)"
    - name: "avg_competitor_price"
      expr: AVG(CAST(competitor_price AS DOUBLE))
      comment: "Average competitor price"
    - name: "avg_imu_percent"
      expr: AVG(CAST(imu_percent AS DOUBLE))
      comment: "Average initial markup percentage"
    - name: "avg_mmu_percent"
      expr: AVG(CAST(mmu_percent AS DOUBLE))
      comment: "Average maintained markup percentage"
    - name: "avg_markdown_percent"
      expr: AVG(CAST(markdown_percent AS DOUBLE))
      comment: "Average markdown percentage"
    - name: "avg_price_elasticity_index"
      expr: AVG(CAST(price_elasticity_index AS DOUBLE))
      comment: "Average price elasticity index"
    - name: "avg_vat_rate_percent"
      expr: AVG(CAST(vat_rate_percent AS DOUBLE))
      comment: "Average VAT rate percentage"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`merchandising_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion performance metrics tracking planned vs actual lift, revenue impact, sell-through acceleration, and GMROI effect"
  source: "`apparel_fashion_ecm`.`merchandising`.`promotion`"
  dimensions:
    - name: "promotion_status"
      expr: promotion_status
      comment: "Status of the promotion (e.g., planned, active, completed, cancelled)"
    - name: "promotion_type"
      expr: promotion_type
      comment: "Type of promotion (e.g., percent-off, BOGO, fixed-price, gift-with-purchase)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the promotion"
    - name: "channel_applicability"
      expr: channel_applicability
      comment: "Channels where the promotion applies"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the promotion"
    - name: "merchandise_scope"
      expr: merchandise_scope
      comment: "Merchandise scope of the promotion"
    - name: "coupon_required"
      expr: coupon_required
      comment: "Flag indicating whether a coupon is required"
    - name: "is_loyalty_exclusive"
      expr: is_loyalty_exclusive
      comment: "Flag indicating whether the promotion is exclusive to loyalty members"
    - name: "stackable"
      expr: stackable
      comment: "Flag indicating whether the promotion can be stacked with other offers"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when the promotion starts"
  measures:
    - name: "total_promotions"
      expr: COUNT(1)
      comment: "Total number of promotions"
    - name: "total_planned_revenue"
      expr: SUM(CAST(planned_revenue AS DOUBLE))
      comment: "Total planned revenue from promotions"
    - name: "total_actual_revenue"
      expr: SUM(CAST(actual_revenue AS DOUBLE))
      comment: "Total actual revenue from promotions"
    - name: "total_planned_units"
      expr: SUM(CAST(planned_units AS DOUBLE))
      comment: "Total planned units sold through promotions"
    - name: "total_actual_units"
      expr: SUM(CAST(actual_units AS DOUBLE))
      comment: "Total actual units sold through promotions"
    - name: "total_markdown_budget"
      expr: SUM(CAST(markdown_budget AS DOUBLE))
      comment: "Total markdown budget allocated to promotions"
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate across promotions"
    - name: "avg_planned_lift_pct"
      expr: AVG(CAST(planned_lift_pct AS DOUBLE))
      comment: "Average planned sales lift percentage"
    - name: "avg_actual_lift_pct"
      expr: AVG(CAST(actual_lift_pct AS DOUBLE))
      comment: "Average actual sales lift percentage"
    - name: "avg_sell_through_rate"
      expr: AVG(CAST(sell_through_rate AS DOUBLE))
      comment: "Average sell-through rate during promotions"
    - name: "avg_gmroi_impact"
      expr: AVG(CAST(gmroi_impact AS DOUBLE))
      comment: "Average gross margin return on investment impact"
    - name: "avg_minimum_purchase_amount"
      expr: AVG(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Average minimum purchase amount required for promotion"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`merchandising_season`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Seasonal planning and performance metrics tracking OTB budget, planned sales, margin targets, and SKU breadth by season"
  source: "`apparel_fashion_ecm`.`merchandising`.`season`"
  dimensions:
    - name: "season_status"
      expr: season_status
      comment: "Status of the season (e.g., planning, active, closed)"
    - name: "season_type"
      expr: season_type
      comment: "Type of season (e.g., spring, fall, holiday, capsule)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the season"
    - name: "fiscal_half"
      expr: fiscal_half
      comment: "Fiscal half (H1 or H2)"
    - name: "gender_target"
      expr: gender_target
      comment: "Target gender for the season (e.g., mens, womens, unisex)"
    - name: "channel_scope"
      expr: channel_scope
      comment: "Channel scope for the season"
    - name: "region_scope"
      expr: region_scope
      comment: "Regional scope for the season"
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the season is currently active"
    - name: "is_nos"
      expr: is_nos
      comment: "Flag indicating whether the season includes never-out-of-stock items"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when the season starts"
  measures:
    - name: "total_seasons"
      expr: COUNT(1)
      comment: "Total number of seasons"
    - name: "total_otb_budget"
      expr: SUM(CAST(otb_budget_amount AS DOUBLE))
      comment: "Total open-to-buy budget across seasons"
    - name: "total_planned_sales"
      expr: SUM(CAST(planned_sales_amount AS DOUBLE))
      comment: "Total planned sales amount across seasons"
    - name: "total_planned_skus"
      expr: SUM(CAST(num_planned_skus AS DOUBLE))
      comment: "Total number of planned SKUs across seasons"
    - name: "total_planned_styles"
      expr: SUM(CAST(num_planned_styles AS DOUBLE))
      comment: "Total number of planned styles across seasons"
    - name: "avg_planned_gross_margin_pct"
      expr: AVG(CAST(planned_gross_margin_pct AS DOUBLE))
      comment: "Average planned gross margin percentage"
    - name: "avg_planned_imu_pct"
      expr: AVG(CAST(planned_imu_pct AS DOUBLE))
      comment: "Average planned initial markup percentage"
    - name: "avg_planned_str_pct"
      expr: AVG(CAST(planned_str_pct AS DOUBLE))
      comment: "Average planned sell-through rate percentage"
    - name: "avg_weeks_of_supply_target"
      expr: AVG(CAST(weeks_of_supply_target AS DOUBLE))
      comment: "Average weeks of supply target"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`merchandising_vendor_allowance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor allowance and co-op funding metrics tracking earned vs claimed amounts, settlement performance, and GMROI impact"
  source: "`apparel_fashion_ecm`.`merchandising`.`vendor_allowance`"
  dimensions:
    - name: "allowance_status"
      expr: allowance_status
      comment: "Status of the vendor allowance (e.g., pending, claimed, settled, disputed)"
    - name: "allowance_type"
      expr: allowance_type
      comment: "Type of allowance (e.g., markdown, advertising, volume, performance)"
    - name: "settlement_method"
      expr: settlement_method
      comment: "Method of settlement (e.g., credit-memo, check, offset)"
    - name: "accrual_period_start_month"
      expr: DATE_TRUNC('MONTH', accrual_period_start_date)
      comment: "Month when the accrual period starts"
    - name: "agreement_start_month"
      expr: DATE_TRUNC('MONTH', agreement_start_date)
      comment: "Month when the allowance agreement starts"
  measures:
    - name: "total_vendor_allowances"
      expr: COUNT(1)
      comment: "Total number of vendor allowance records"
    - name: "total_agreement_amount"
      expr: SUM(CAST(agreement_amount AS DOUBLE))
      comment: "Total agreed allowance amount"
    - name: "total_earned_amount"
      expr: SUM(CAST(earned_amount AS DOUBLE))
      comment: "Total earned allowance amount"
    - name: "total_claimed_amount"
      expr: SUM(CAST(claimed_amount AS DOUBLE))
      comment: "Total claimed allowance amount"
    - name: "total_settled_amount"
      expr: SUM(CAST(settled_amount AS DOUBLE))
      comment: "Total settled allowance amount"
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total outstanding allowance amount"
    - name: "total_actual_performance_amount"
      expr: SUM(CAST(actual_performance_amount AS DOUBLE))
      comment: "Total actual performance amount triggering allowances"
    - name: "total_performance_threshold_amount"
      expr: SUM(CAST(performance_threshold_amount AS DOUBLE))
      comment: "Total performance threshold amount required for allowances"
    - name: "avg_allowance_rate_percent"
      expr: AVG(CAST(allowance_rate_percent AS DOUBLE))
      comment: "Average allowance rate percentage"
    - name: "avg_gmroi_impact_percent"
      expr: AVG(CAST(gmroi_impact_percent AS DOUBLE))
      comment: "Average gross margin return on investment impact percentage"
$$;