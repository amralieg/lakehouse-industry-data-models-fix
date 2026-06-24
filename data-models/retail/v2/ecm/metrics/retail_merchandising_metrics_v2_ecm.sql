-- Metric views for domain: merchandising | Business: Retail | Version: 2 | Generated on: 2026-06-23 23:42:36

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_merch_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic merchandising plan KPIs tracking planned financial performance, margin targets, and inventory efficiency goals at the category/department/season level. Used by merchandising leadership to evaluate plan health and steer buying decisions."
  source: "`vibe_retail_v1`.`merchandising`.`merch_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current lifecycle status of the merchandising plan (e.g. draft, approved, active, closed)."
    - name: "plan_type"
      expr: plan_type
      comment: "Classification of the plan (e.g. seasonal, annual, promotional) for segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which plan financials are denominated."
    - name: "plan_start_date"
      expr: plan_start_date
      comment: "Start date of the plan period for time-series analysis."
    - name: "plan_end_date"
      expr: plan_end_date
      comment: "End date of the plan period for time-series analysis."
    - name: "fiscal_year_plan"
      expr: DATE_TRUNC('year', plan_start_date)
      comment: "Fiscal year derived from plan start date for annual roll-up reporting."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the plan is currently active."
  measures:
    - name: "total_planned_sales_amount"
      expr: SUM(CAST(planned_sales_amount AS DOUBLE))
      comment: "Total planned net sales revenue across all merchandising plans. Core top-line planning KPI used in QBRs."
    - name: "total_planned_margin_amount"
      expr: SUM(CAST(planned_margin_amount AS DOUBLE))
      comment: "Total planned gross margin dollars. Directly drives profitability forecasting and OTB decisions."
    - name: "avg_planned_margin_percent"
      expr: AVG(CAST(planned_margin_percent AS DOUBLE))
      comment: "Average planned gross margin percentage across plans. Benchmarks margin health against targets."
    - name: "total_planned_markdown_amount"
      expr: SUM(CAST(planned_markdown_amount AS DOUBLE))
      comment: "Total planned markdown spend. Signals inventory clearance cost and pricing strategy aggressiveness."
    - name: "avg_planned_markdown_percent"
      expr: AVG(CAST(planned_markdown_percent AS DOUBLE))
      comment: "Average planned markdown rate. Indicates how much of revenue is expected to be sacrificed to clear inventory."
    - name: "total_otb_budget_amount"
      expr: SUM(CAST(otb_budget_amount AS DOUBLE))
      comment: "Total open-to-buy budget committed across plans. Controls buying authority and cash flow exposure."
    - name: "total_planned_receipt_amount"
      expr: SUM(CAST(planned_receipt_amount AS DOUBLE))
      comment: "Total planned inventory receipts at cost. Drives inbound logistics and vendor commitment planning."
    - name: "total_planned_cost_amount"
      expr: SUM(CAST(planned_cost_amount AS DOUBLE))
      comment: "Total planned cost of goods. Used to compute planned gross margin and evaluate cost efficiency."
    - name: "avg_gmroi_target"
      expr: AVG(CAST(gmroi_target AS DOUBLE))
      comment: "Average Gross Margin Return on Inventory Investment target. Key efficiency metric for capital allocation in merchandising."
    - name: "avg_inventory_turn_target"
      expr: AVG(CAST(inventory_turn_target AS DOUBLE))
      comment: "Average planned inventory turn rate. Measures how efficiently inventory is expected to cycle through."
    - name: "avg_sell_through_target_percent"
      expr: AVG(CAST(sell_through_target_percent AS DOUBLE))
      comment: "Average planned sell-through rate. Indicates expected proportion of inventory sold before markdown or clearance."
    - name: "total_planned_beginning_inventory"
      expr: SUM(CAST(planned_beginning_inventory_amount AS DOUBLE))
      comment: "Total planned beginning-of-period inventory value. Baseline for inventory flow and turn calculations."
    - name: "total_planned_ending_inventory"
      expr: SUM(CAST(planned_ending_inventory_amount AS DOUBLE))
      comment: "Total planned end-of-period inventory value. Signals residual stock risk and clearance exposure."
    - name: "plan_count"
      expr: COUNT(1)
      comment: "Number of active merchandising plans. Tracks planning coverage across categories and seasons."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_otb_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Open-to-Buy budget utilization and efficiency metrics. Tracks how buying authority is allocated, consumed, and balanced across categories, seasons, and departments. Critical for cash flow management and inventory investment control."
  source: "`vibe_retail_v1`.`merchandising`.`otb_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the OTB budget (e.g. draft, approved, active, closed)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the budget record."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year the OTB budget applies to."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (e.g. month, quarter) for granular budget tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of the budget."
    - name: "budget_start_date"
      expr: budget_start_date
      comment: "Start date of the budget period for time-series analysis."
  measures:
    - name: "total_planned_receipts_at_cost"
      expr: SUM(CAST(planned_receipts_at_cost AS DOUBLE))
      comment: "Total planned inventory receipts at cost across all OTB budgets. Represents total buying authority granted."
    - name: "total_actual_receipts_at_cost"
      expr: SUM(CAST(actual_receipts_at_cost AS DOUBLE))
      comment: "Total actual inventory receipts at cost. Measures how much of the buying plan has been executed."
    - name: "total_available_otb_balance"
      expr: SUM(CAST(available_otb_balance AS DOUBLE))
      comment: "Total remaining open-to-buy balance. Indicates uncommitted buying capacity — critical for in-season agility."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed OTB spend (purchase orders placed but not yet received). Tracks financial exposure."
    - name: "total_budget_adjustment_amount"
      expr: SUM(CAST(budget_adjustment_amount AS DOUBLE))
      comment: "Net budget adjustments applied. Signals how much plans have deviated from original approval."
    - name: "total_budget_transfer_in_amount"
      expr: SUM(CAST(budget_transfer_in_amount AS DOUBLE))
      comment: "Total OTB transferred into this budget from other categories. Measures reallocation activity."
    - name: "total_budget_transfer_out_amount"
      expr: SUM(CAST(budget_transfer_out_amount AS DOUBLE))
      comment: "Total OTB transferred out of this budget. Measures how much buying authority was redistributed."
    - name: "avg_gmroi_target"
      expr: AVG(CAST(gmroi_target AS DOUBLE))
      comment: "Average GMROI target across OTB budgets. Benchmarks return expectations on inventory investment."
    - name: "avg_inventory_turn_target"
      expr: AVG(CAST(inventory_turn_target AS DOUBLE))
      comment: "Average inventory turn target. Measures expected velocity of inventory relative to investment."
    - name: "avg_sell_through_target_pct"
      expr: AVG(CAST(sell_through_target_pct AS DOUBLE))
      comment: "Average sell-through target percentage. Indicates expected clearance efficiency before markdown."
    - name: "avg_markdown_budget_pct"
      expr: AVG(CAST(markdown_budget_pct AS DOUBLE))
      comment: "Average markdown budget as a percentage of total OTB. Signals planned price reduction exposure."
    - name: "otb_budget_count"
      expr: COUNT(1)
      comment: "Number of OTB budget records. Tracks planning coverage across categories and periods."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_buying_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Buying order financial and operational KPIs. Tracks order volume, cost, landed cost components, and order lifecycle status. Used by buyers and finance to manage vendor commitments and cost of goods."
  source: "`vibe_retail_v1`.`merchandising`.`buying_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the buying order (e.g. draft, submitted, approved, cancelled, received)."
    - name: "order_type"
      expr: order_type
      comment: "Classification of the buying order (e.g. domestic, import, direct-to-store)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the order is denominated."
    - name: "destination_type"
      expr: destination_type
      comment: "Destination type for the order (e.g. DC, store, drop-ship)."
    - name: "fob_terms"
      expr: fob_terms
      comment: "Free-on-board terms governing cost and risk transfer point."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Vendor payment terms (e.g. net 30, net 60) affecting cash flow timing."
    - name: "order_date"
      expr: order_date
      comment: "Date the buying order was placed for time-series trend analysis."
    - name: "order_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month of order placement for monthly buying trend analysis."
  measures:
    - name: "total_order_cost"
      expr: SUM(CAST(total_order_cost AS DOUBLE))
      comment: "Total cost of all buying orders. Primary measure of vendor spend and cost of goods commitment."
    - name: "total_landed_cost"
      expr: SUM(CAST(landed_cost AS DOUBLE))
      comment: "Total landed cost including freight and duty. True cost basis for margin calculation."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across buying orders. Identifies logistics cost drivers and import efficiency."
    - name: "total_duty_cost"
      expr: SUM(CAST(duty_cost AS DOUBLE))
      comment: "Total import duty cost. Tracks tariff exposure and informs sourcing strategy decisions."
    - name: "avg_order_cost"
      expr: AVG(CAST(total_order_cost AS DOUBLE))
      comment: "Average buying order value. Benchmarks order size and vendor engagement scale."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to orders. Monitors FX exposure on international buying."
    - name: "total_order_quantity"
      expr: SUM(CAST(total_order_quantity AS DOUBLE))
      comment: "Total units ordered across all buying orders. Measures buying volume for capacity and logistics planning."
    - name: "buying_order_count"
      expr: COUNT(1)
      comment: "Number of buying orders placed. Tracks buying activity volume and vendor engagement breadth."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with active buying orders. Measures vendor base breadth and concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_buying_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level buying order KPIs tracking unit economics, margin planning, and order fulfillment at the SKU level. Used by buyers to evaluate cost efficiency, fill rates, and planned margin by item."
  source: "`vibe_retail_v1`.`merchandising`.`buying_order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the buying order line (e.g. open, received, cancelled, short-shipped)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of the line cost."
    - name: "private_label_flag"
      expr: private_label_flag
      comment: "Indicates whether the line item is a private label product. Enables private label vs national brand analysis."
    - name: "drop_ship_flag"
      expr: drop_ship_flag
      comment: "Indicates whether the line is fulfilled via drop-ship. Affects inventory and margin treatment."
    - name: "delivery_date"
      expr: delivery_date
      comment: "Planned delivery date for the line. Used for receipt timing and inventory flow analysis."
    - name: "delivery_month"
      expr: DATE_TRUNC('month', delivery_date)
      comment: "Month of planned delivery for monthly receipt flow analysis."
  measures:
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total extended cost (unit cost × quantity) across all buying order lines. Primary cost-of-goods measure at line level."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total units ordered. Measures buying volume at SKU level for capacity and vendor planning."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total units received. Measures actual inbound flow against orders placed."
    - name: "total_cancelled_quantity"
      expr: SUM(CAST(cancelled_quantity AS DOUBLE))
      comment: "Total units cancelled. Signals vendor fill-rate issues and demand forecast misses."
    - name: "total_allocation_quantity"
      expr: SUM(CAST(allocation_quantity AS DOUBLE))
      comment: "Total units allocated to stores. Measures distribution breadth and store-level inventory commitment."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across buying order lines. Benchmarks cost efficiency and vendor pricing trends."
    - name: "avg_retail_price"
      expr: AVG(CAST(retail_price AS DOUBLE))
      comment: "Average planned retail price. Used to compute initial markup and planned margin at line level."
    - name: "total_planned_margin_amount"
      expr: SUM(CAST(planned_margin_amount AS DOUBLE))
      comment: "Total planned gross margin dollars across all lines. Drives profitability forecasting at SKU level."
    - name: "avg_planned_margin_percent"
      expr: AVG(CAST(planned_margin_percent AS DOUBLE))
      comment: "Average planned gross margin percentage. Benchmarks margin health by vendor, category, and season."
    - name: "total_minimum_order_quantity"
      expr: SUM(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Total minimum order quantity commitments. Tracks vendor MOQ exposure and inventory risk."
    - name: "buying_order_line_count"
      expr: COUNT(1)
      comment: "Number of buying order lines. Measures SKU-level buying breadth and order complexity."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_assortment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assortment planning KPIs tracking SKU breadth, depth, private label mix, and financial targets. Used by category managers and buyers to evaluate assortment strategy effectiveness and alignment with financial goals."
  source: "`vibe_retail_v1`.`merchandising`.`assortment_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the assortment plan (e.g. draft, approved, active, archived)."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of assortment plan (e.g. seasonal, annual, cluster-specific)."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year the assortment plan covers."
    - name: "otb_currency_code"
      expr: otb_currency_code
      comment: "Currency in which OTB budget is denominated."
    - name: "planogram_required_flag"
      expr: planogram_required_flag
      comment: "Indicates whether a planogram is required for this assortment. Drives space planning workload."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date of the assortment plan effective period."
    - name: "plan_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the assortment plan becomes effective for trend analysis."
  measures:
    - name: "total_otb_budget_amount"
      expr: SUM(CAST(otb_budget_amount AS DOUBLE))
      comment: "Total OTB budget allocated across assortment plans. Measures total buying authority committed to assortment strategy."
    - name: "avg_target_gmroi"
      expr: AVG(CAST(target_gmroi AS DOUBLE))
      comment: "Average GMROI target across assortment plans. Benchmarks return expectations on assortment investment."
    - name: "avg_target_inventory_turn_rate"
      expr: AVG(CAST(target_inventory_turn_rate AS DOUBLE))
      comment: "Average inventory turn rate target. Measures expected velocity of assortment relative to investment."
    - name: "avg_target_sell_through_rate_percent"
      expr: AVG(CAST(target_sell_through_rate_percent AS DOUBLE))
      comment: "Average sell-through rate target. Indicates expected proportion of assortment sold before clearance."
    - name: "avg_private_label_mix_percent"
      expr: AVG(CAST(private_label_mix_percent AS DOUBLE))
      comment: "Average private label SKU mix percentage. Tracks private label penetration strategy execution."
    - name: "assortment_plan_count"
      expr: COUNT(1)
      comment: "Number of assortment plans. Tracks planning coverage across categories, clusters, and seasons."
    - name: "distinct_cluster_count"
      expr: COUNT(DISTINCT cluster_id)
      comment: "Number of distinct store clusters covered by assortment plans. Measures localization breadth of assortment strategy."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_assortment_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assortment item-level KPIs tracking planned unit economics, sell-through targets, and lifecycle status at the SKU-assortment intersection. Used by buyers and category managers to evaluate item-level assortment health."
  source: "`vibe_retail_v1`.`merchandising`.`assortment_item`"
  dimensions:
    - name: "inclusion_status"
      expr: inclusion_status
      comment: "Whether the item is included, excluded, or pending in the assortment."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Current lifecycle stage of the item (e.g. new, core, declining, exit). Drives assortment refresh decisions."
    - name: "assortment_role"
      expr: assortment_role
      comment: "Strategic role of the item in the assortment (e.g. traffic driver, margin builder, destination)."
    - name: "assortment_depth_tier"
      expr: assortment_depth_tier
      comment: "Depth tier classification (e.g. A, B, C) indicating inventory depth commitment."
    - name: "private_label_flag"
      expr: private_label_flag
      comment: "Indicates whether the item is a private label product. Enables private label vs national brand analysis."
    - name: "clearance_strategy"
      expr: clearance_strategy
      comment: "Planned clearance approach for the item (e.g. markdown, liquidation, return to vendor)."
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Item onboarding completion status. Tracks readiness for go-live."
    - name: "go_live_date"
      expr: go_live_date
      comment: "Planned go-live date for the assortment item."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date of the item's assortment inclusion period."
  measures:
    - name: "total_planned_aur"
      expr: SUM(CAST(planned_aur AS DOUBLE))
      comment: "Total planned average unit retail across assortment items. Measures revenue potential of the assortment."
    - name: "avg_planned_aur"
      expr: AVG(CAST(planned_aur AS DOUBLE))
      comment: "Average planned unit retail price. Benchmarks price positioning of the assortment."
    - name: "avg_planned_gmroi"
      expr: AVG(CAST(planned_gmroi AS DOUBLE))
      comment: "Average planned GMROI per assortment item. Identifies high-return items driving assortment profitability."
    - name: "avg_planned_sell_through_rate"
      expr: AVG(CAST(planned_sell_through_rate AS DOUBLE))
      comment: "Average planned sell-through rate. Benchmarks expected clearance efficiency across assortment items."
    - name: "avg_planned_weeks_of_supply"
      expr: AVG(CAST(planned_weeks_of_supply AS DOUBLE))
      comment: "Average planned weeks of supply. Signals inventory depth relative to expected sales velocity."
    - name: "assortment_item_count"
      expr: COUNT(1)
      comment: "Total number of assortment items. Measures assortment breadth across categories and clusters."
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs in the assortment. Core breadth metric for assortment strategy evaluation."
    - name: "planogram_required_item_count"
      expr: SUM(CASE WHEN planogram_position_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of items requiring planogram placement. Drives space planning and visual merchandising workload."
    - name: "attributes_complete_item_count"
      expr: SUM(CASE WHEN attributes_checklist_complete = TRUE THEN 1 ELSE 0 END)
      comment: "Number of items with complete attribute checklists. Measures data readiness for digital and in-store execution."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_markdown_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Markdown event financial impact and effectiveness KPIs. Tracks planned vs actual revenue and margin impact of markdowns, sell-through lift, and vendor contribution. Used by merchants and finance to evaluate markdown ROI and clearance strategy."
  source: "`vibe_retail_v1`.`merchandising`.`markdown_event`"
  dimensions:
    - name: "markdown_status"
      expr: markdown_status
      comment: "Current status of the markdown event (e.g. planned, active, completed, cancelled)."
    - name: "markdown_type"
      expr: markdown_type
      comment: "Type of markdown (e.g. permanent, promotional, clearance). Drives accounting and strategy classification."
    - name: "markdown_reason"
      expr: markdown_reason
      comment: "Business reason for the markdown (e.g. slow seller, end of season, competitive response)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which markdown financials are denominated."
    - name: "effective_date"
      expr: effective_date
      comment: "Date the markdown becomes effective for time-series analysis."
    - name: "markdown_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of markdown effectiveness for monthly trend analysis."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Indicates whether the markdown required approval. Tracks governance compliance."
  measures:
    - name: "total_markdown_amount"
      expr: SUM(CAST(markdown_amount AS DOUBLE))
      comment: "Total markdown dollars taken. Primary measure of price reduction investment and clearance cost."
    - name: "avg_markdown_percentage"
      expr: AVG(CAST(markdown_percentage AS DOUBLE))
      comment: "Average markdown depth as a percentage of original price. Benchmarks markdown aggressiveness."
    - name: "total_projected_revenue_impact"
      expr: SUM(CAST(projected_revenue_impact AS DOUBLE))
      comment: "Total projected revenue impact from markdowns. Used in pre-season planning to size clearance exposure."
    - name: "total_actual_revenue_impact"
      expr: SUM(CAST(actual_revenue_impact AS DOUBLE))
      comment: "Total actual revenue impact realized from markdowns. Measures execution vs plan for markdown strategy."
    - name: "total_projected_margin_impact"
      expr: SUM(CAST(projected_margin_impact AS DOUBLE))
      comment: "Total projected margin impact from markdowns. Quantifies planned profitability sacrifice for clearance."
    - name: "total_actual_margin_impact"
      expr: SUM(CAST(actual_margin_impact AS DOUBLE))
      comment: "Total actual margin impact from markdowns. Measures true profitability cost of clearance execution."
    - name: "avg_projected_sell_through_lift"
      expr: AVG(CAST(projected_sell_through_lift_percentage AS DOUBLE))
      comment: "Average projected sell-through lift from markdowns. Benchmarks expected demand response to price reductions."
    - name: "avg_actual_sell_through_lift"
      expr: AVG(CAST(actual_sell_through_lift_percentage AS DOUBLE))
      comment: "Average actual sell-through lift achieved. Measures effectiveness of markdown in driving demand."
    - name: "total_vendor_contribution_amount"
      expr: SUM(CAST(vendor_contribution_amount AS DOUBLE))
      comment: "Total vendor markdown allowance contributions. Measures cost recovery from vendor partnerships on clearance events."
    - name: "total_original_price_value"
      expr: SUM(CAST(original_price AS DOUBLE))
      comment: "Total original retail value before markdown. Provides denominator context for markdown rate calculations."
    - name: "markdown_event_count"
      expr: COUNT(1)
      comment: "Number of markdown events. Tracks markdown activity volume and clearance strategy breadth."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_vendor_negotiation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor negotiation outcome KPIs tracking cost changes, allowances, co-op funding, and fill rate commitments. Used by buyers and sourcing leadership to evaluate negotiation effectiveness and vendor partnership value."
  source: "`vibe_retail_v1`.`merchandising`.`vendor_negotiation`"
  dimensions:
    - name: "negotiation_status"
      expr: negotiation_status
      comment: "Current status of the negotiation (e.g. in-progress, agreed, executed, expired)."
    - name: "negotiation_type"
      expr: negotiation_type
      comment: "Type of negotiation (e.g. cost, terms, allowance, co-op). Classifies negotiation scope."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the negotiation outcome."
    - name: "allowance_type"
      expr: allowance_type
      comment: "Type of vendor allowance negotiated (e.g. markdown support, co-op advertising, volume rebate)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which negotiation financials are denominated."
    - name: "effective_date"
      expr: effective_date
      comment: "Date the negotiated terms become effective."
    - name: "negotiation_start_date"
      expr: negotiation_start_date
      comment: "Start date of the negotiation process for cycle time analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms governing cost and risk transfer. Affects landed cost calculations."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Negotiated payment terms (e.g. net 30, net 60). Affects cash flow and working capital."
  measures:
    - name: "total_allowance_amount"
      expr: SUM(CAST(allowance_amount AS DOUBLE))
      comment: "Total vendor allowance dollars negotiated. Measures total vendor financial support secured by buyers."
    - name: "total_coop_advertising_fund"
      expr: SUM(CAST(coop_advertising_fund AS DOUBLE))
      comment: "Total co-op advertising funds negotiated. Measures vendor investment in joint marketing programs."
    - name: "total_markdown_support_amount"
      expr: SUM(CAST(markdown_support_amount AS DOUBLE))
      comment: "Total vendor markdown support negotiated. Measures vendor contribution to clearance cost recovery."
    - name: "avg_cost_change_percentage"
      expr: AVG(CAST(cost_change_percentage AS DOUBLE))
      comment: "Average cost change percentage negotiated. Benchmarks buying team effectiveness in managing cost inflation."
    - name: "avg_new_cost_price"
      expr: AVG(CAST(new_cost_price AS DOUBLE))
      comment: "Average new negotiated cost price. Tracks cost basis changes across vendor negotiations."
    - name: "avg_old_cost_price"
      expr: AVG(CAST(old_cost_price AS DOUBLE))
      comment: "Average prior cost price before negotiation. Provides baseline for cost change measurement."
    - name: "avg_fill_rate_commitment_percentage"
      expr: AVG(CAST(fill_rate_commitment_percentage AS DOUBLE))
      comment: "Average vendor fill rate commitment percentage. Measures supply reliability commitments secured in negotiations."
    - name: "vendor_negotiation_count"
      expr: COUNT(1)
      comment: "Number of vendor negotiations. Tracks negotiation activity volume and buyer workload."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with active negotiations. Measures vendor engagement breadth."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_category`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category-level performance and planning KPIs tracking financial targets, margin goals, and assortment strategy. Used by category managers and merchandising leadership to evaluate category health and strategic positioning."
  source: "`vibe_retail_v1`.`merchandising`.`category`"
  dimensions:
    - name: "category_status"
      expr: category_status
      comment: "Current status of the category (e.g. active, inactive, under review)."
    - name: "category_role"
      expr: category_role
      comment: "Strategic role of the category (e.g. destination, routine, convenience, seasonal)."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the merchandise hierarchy (e.g. department, class, subclass)."
    - name: "merchandise_type"
      expr: merchandise_type
      comment: "Type of merchandise (e.g. hardlines, softlines, food, general merchandise)."
    - name: "division"
      expr: division
      comment: "Business division the category belongs to for organizational roll-up."
    - name: "seasonality_flag"
      expr: seasonality_flag
      comment: "Indicates whether the category has significant seasonal demand patterns."
    - name: "is_leaf_node"
      expr: is_leaf_node
      comment: "Indicates whether this is a leaf-level category node (no children). Leaf nodes are where items are assigned."
    - name: "peak_season"
      expr: peak_season
      comment: "Primary peak selling season for the category. Drives seasonal planning and OTB timing."
  measures:
    - name: "total_otb_budget_amount"
      expr: SUM(CAST(otb_budget_amount AS DOUBLE))
      comment: "Total OTB budget allocated to categories. Measures buying authority distribution across the merchandise hierarchy."
    - name: "avg_target_gmroi"
      expr: AVG(CAST(target_gmroi AS DOUBLE))
      comment: "Average GMROI target across categories. Benchmarks return expectations on category inventory investment."
    - name: "avg_actual_gmroi"
      expr: AVG(CAST(actual_gmroi AS DOUBLE))
      comment: "Average actual GMROI achieved. Measures realized return on inventory investment vs target."
    - name: "avg_target_margin_percent"
      expr: AVG(CAST(target_margin_percent AS DOUBLE))
      comment: "Average target gross margin percentage. Benchmarks margin expectations across the category portfolio."
    - name: "avg_target_inventory_turns"
      expr: AVG(CAST(target_inventory_turns AS DOUBLE))
      comment: "Average target inventory turn rate. Measures expected inventory velocity across categories."
    - name: "avg_actual_sell_through_rate"
      expr: AVG(CAST(actual_sell_through_rate AS DOUBLE))
      comment: "Average actual sell-through rate achieved. Measures clearance effectiveness vs plan."
    - name: "avg_target_sell_through_rate"
      expr: AVG(CAST(target_sell_through_rate AS DOUBLE))
      comment: "Average target sell-through rate. Benchmarks expected clearance performance."
    - name: "avg_private_label_penetration_target"
      expr: AVG(CAST(private_label_penetration_target AS DOUBLE))
      comment: "Average private label penetration target. Tracks strategic intent for own-brand development by category."
    - name: "category_count"
      expr: COUNT(1)
      comment: "Number of active categories. Measures merchandise hierarchy breadth and category management scope."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_private_label_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Private label program financial and strategic KPIs. Tracks investment, margin premium targets, sell-through, and program lifecycle. Used by merchandising and brand leadership to evaluate own-brand program ROI and strategic positioning."
  source: "`vibe_retail_v1`.`merchandising`.`private_label_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current status of the private label program (e.g. development, active, discontinued)."
    - name: "quality_tier"
      expr: quality_tier
      comment: "Quality positioning tier of the private label (e.g. premium, standard, value). Drives pricing and margin strategy."
    - name: "exclusive_flag"
      expr: exclusive_flag
      comment: "Indicates whether the program is exclusive to this retailer. Signals competitive differentiation."
    - name: "seasonal_flag"
      expr: seasonal_flag
      comment: "Indicates whether the program is seasonal. Affects OTB timing and inventory planning."
    - name: "sustainability_certified_flag"
      expr: sustainability_certified_flag
      comment: "Indicates whether the program has sustainability certification. Tracks ESG commitment in private label."
    - name: "vendor_managed_inventory_flag"
      expr: vendor_managed_inventory_flag
      comment: "Indicates whether inventory is vendor-managed. Affects working capital and replenishment strategy."
    - name: "launch_date"
      expr: launch_date
      comment: "Program launch date for cohort and lifecycle analysis."
    - name: "launch_year"
      expr: DATE_TRUNC('year', launch_date)
      comment: "Year of program launch for annual portfolio analysis."
  measures:
    - name: "total_marketing_investment_usd"
      expr: SUM(CAST(marketing_investment_usd AS DOUBLE))
      comment: "Total marketing investment in private label programs. Measures brand-building spend on own-label portfolio."
    - name: "total_otb_budget_amount"
      expr: SUM(CAST(otb_budget_amount AS DOUBLE))
      comment: "Total OTB budget allocated to private label programs. Measures buying authority committed to own-brand development."
    - name: "avg_target_gmroi"
      expr: AVG(CAST(target_gmroi AS DOUBLE))
      comment: "Average GMROI target for private label programs. Benchmarks return expectations vs national brand alternatives."
    - name: "avg_target_margin_premium_pct"
      expr: AVG(CAST(target_margin_premium_pct AS DOUBLE))
      comment: "Average target margin premium over national brands. Quantifies the financial rationale for private label investment."
    - name: "avg_target_price_point_usd"
      expr: AVG(CAST(target_price_point_usd AS DOUBLE))
      comment: "Average target retail price point. Benchmarks price positioning of private label vs national brands."
    - name: "avg_target_sell_through_rate_pct"
      expr: AVG(CAST(target_sell_through_rate_pct AS DOUBLE))
      comment: "Average target sell-through rate. Measures expected clearance efficiency of private label assortment."
    - name: "private_label_program_count"
      expr: COUNT(1)
      comment: "Number of active private label programs. Tracks own-brand portfolio breadth and development pipeline."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors manufacturing private label products. Measures supply base concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_planogram`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planogram compliance, space productivity, and execution KPIs. Used by visual merchandising and store operations to evaluate space allocation effectiveness and planogram reset compliance."
  source: "`vibe_retail_v1`.`merchandising`.`merchandising_planogram`"
  dimensions:
    - name: "merchandising_planogram_status"
      expr: merchandising_planogram_status
      comment: "Current status of the planogram (e.g. draft, approved, active, expired)."
    - name: "fixture_type"
      expr: fixture_type
      comment: "Type of fixture the planogram applies to (e.g. gondola, endcap, wall). Drives space planning analysis."
    - name: "seasonal_flag"
      expr: seasonal_flag
      comment: "Indicates whether the planogram is seasonal. Affects reset frequency and space planning cycles."
    - name: "compliance_required_flag"
      expr: compliance_required_flag
      comment: "Indicates whether compliance measurement is required for this planogram."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date of the planogram effective period."
    - name: "planogram_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the planogram becomes effective for trend analysis."
  measures:
    - name: "total_space_allocation_sqft"
      expr: SUM(CAST(space_allocation_sqft AS DOUBLE))
      comment: "Total square footage allocated across planograms. Measures total space under planogram management."
    - name: "avg_space_allocation_sqft"
      expr: AVG(CAST(space_allocation_sqft AS DOUBLE))
      comment: "Average space allocation per planogram. Benchmarks typical planogram footprint for space planning."
    - name: "avg_target_gmroi"
      expr: AVG(CAST(target_gmroi AS DOUBLE))
      comment: "Average GMROI target per planogram. Benchmarks return expectations on allocated space."
    - name: "avg_target_sales_per_sqft"
      expr: AVG(CAST(target_sales_per_sqft AS DOUBLE))
      comment: "Average target sales per square foot. Core space productivity KPI used to evaluate planogram ROI."
    - name: "avg_compliance_tolerance_pct"
      expr: AVG(CAST(compliance_tolerance_pct AS DOUBLE))
      comment: "Average compliance tolerance percentage. Measures how strictly planogram adherence is enforced."
    - name: "avg_fixture_width_cm"
      expr: AVG(CAST(fixture_width_cm AS DOUBLE))
      comment: "Average fixture width across planograms. Supports space planning and fixture standardization analysis."
    - name: "planogram_count"
      expr: COUNT(1)
      comment: "Number of active planograms. Tracks visual merchandising coverage across locations and categories."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_planogram_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planogram position-level KPIs tracking space productivity, compliance scores, and facing allocation at the SKU-shelf level. Used by space planners and category managers to optimize shelf space allocation."
  source: "`vibe_retail_v1`.`merchandising`.`planogram_position`"
  dimensions:
    - name: "position_status"
      expr: position_status
      comment: "Current status of the planogram position (e.g. active, inactive, pending reset)."
    - name: "fixture_type"
      expr: fixture_type
      comment: "Type of fixture for this position (e.g. shelf, peg, endcap). Drives space planning analysis."
    - name: "merchandising_zone"
      expr: merchandising_zone
      comment: "Merchandising zone within the store (e.g. front-of-store, back wall, checkout). Affects traffic and conversion."
    - name: "is_hero_position"
      expr: is_hero_position
      comment: "Indicates whether this is a hero/feature position. Hero positions command premium space and drive traffic."
    - name: "is_promotional"
      expr: is_promotional
      comment: "Indicates whether the position is designated for promotional items."
    - name: "is_new_item"
      expr: is_new_item
      comment: "Indicates whether the position is allocated to a new item. Tracks new item launch space support."
    - name: "signage_required"
      expr: signage_required
      comment: "Indicates whether signage is required at this position. Drives in-store communication planning."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date of the position assignment for time-series analysis."
  measures:
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average planogram compliance score across positions. Measures how well stores execute the planogram vs plan."
    - name: "avg_space_productivity_index"
      expr: AVG(CAST(space_productivity_index AS DOUBLE))
      comment: "Average space productivity index. Measures revenue generated per unit of shelf space — core space ROI KPI."
    - name: "total_position_width_cm"
      expr: SUM(CAST(position_width_cm AS DOUBLE))
      comment: "Total shelf width allocated across planogram positions. Measures total linear space under management."
    - name: "avg_position_width_cm"
      expr: AVG(CAST(position_width_cm AS DOUBLE))
      comment: "Average position width. Benchmarks typical space allocation per SKU position."
    - name: "planogram_position_count"
      expr: COUNT(1)
      comment: "Total number of planogram positions. Measures total shelf slots under planogram management."
    - name: "hero_position_count"
      expr: SUM(CASE WHEN is_hero_position = TRUE THEN 1 ELSE 0 END)
      comment: "Number of hero/feature positions. Tracks premium space allocation for high-priority items."
    - name: "promotional_position_count"
      expr: SUM(CASE WHEN is_promotional = TRUE THEN 1 ELSE 0 END)
      comment: "Number of promotional positions. Measures space dedicated to promotional execution."
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with planogram positions. Measures assortment breadth represented on shelf."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_buyer_profit_center_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Buyer profit center assignment KPIs tracking budget authority, OTB utilization, margin performance, and financial accountability. Used by merchandising finance and leadership to evaluate buyer performance against financial targets."
  source: "`vibe_retail_v1`.`merchandising`.`buyer_profit_center_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the buyer-profit center assignment (e.g. active, inactive, pending)."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (e.g. primary, secondary, delegated). Clarifies accountability structure."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the assignment for annual performance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which financial targets are denominated."
    - name: "delegation_flag"
      expr: delegation_flag
      comment: "Indicates whether this is a delegated assignment. Tracks authority delegation patterns."
    - name: "primary_flag"
      expr: primary_flag
      comment: "Indicates whether this is the primary assignment for the buyer. Identifies primary accountability."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date of the assignment for tenure and coverage analysis."
  measures:
    - name: "total_budget_authority_limit_amount"
      expr: SUM(CAST(budget_authority_limit_amount AS DOUBLE))
      comment: "Total buying authority limit across assignments. Measures total financial authority delegated to buyers."
    - name: "total_otb_allocation_amount"
      expr: SUM(CAST(otb_allocation_amount AS DOUBLE))
      comment: "Total OTB allocated to buyer-profit center assignments. Measures buying budget distribution."
    - name: "total_otb_consumed_amount"
      expr: SUM(CAST(otb_consumed_amount AS DOUBLE))
      comment: "Total OTB consumed by buyers. Measures buying execution against allocated budget."
    - name: "total_revenue_target_amount"
      expr: SUM(CAST(revenue_target_amount AS DOUBLE))
      comment: "Total revenue target across buyer assignments. Measures aggregate sales accountability."
    - name: "total_markdown_budget_amount"
      expr: SUM(CAST(markdown_budget_amount AS DOUBLE))
      comment: "Total markdown budget allocated. Measures clearance authority granted to buyers."
    - name: "total_markdown_spent_amount"
      expr: SUM(CAST(markdown_spent_amount AS DOUBLE))
      comment: "Total markdown budget consumed. Measures clearance spend execution vs budget."
    - name: "avg_margin_target_pct"
      expr: AVG(CAST(margin_target_pct AS DOUBLE))
      comment: "Average margin target percentage across assignments. Benchmarks profitability expectations by buyer."
    - name: "avg_gross_margin_actual_pct"
      expr: AVG(CAST(gross_margin_actual_pct AS DOUBLE))
      comment: "Average actual gross margin percentage achieved. Measures buyer performance against margin targets."
    - name: "avg_target_inventory_turns"
      expr: AVG(CAST(target_inventory_turns AS DOUBLE))
      comment: "Average inventory turn target. Benchmarks expected inventory velocity by buyer assignment."
    - name: "avg_actual_inventory_turns"
      expr: AVG(CAST(actual_inventory_turns AS DOUBLE))
      comment: "Average actual inventory turns achieved. Measures buyer execution on inventory efficiency targets."
    - name: "assignment_count"
      expr: COUNT(1)
      comment: "Number of buyer-profit center assignments. Tracks organizational accountability coverage."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_season`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Season-level planning KPIs tracking OTB budgets, financial targets, and key milestone dates. Used by merchandising leadership to evaluate seasonal planning health and target-setting rigor."
  source: "`vibe_retail_v1`.`merchandising`.`season`"
  dimensions:
    - name: "season_status"
      expr: season_status
      comment: "Current status of the season (e.g. planning, active, clearance, closed)."
    - name: "season_type"
      expr: season_type
      comment: "Type of season (e.g. spring/summer, fall/winter, holiday, back-to-school)."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year the season belongs to for annual roll-up analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which season financials are denominated."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the season is currently active."
    - name: "start_date"
      expr: start_date
      comment: "Season start date for time-series and calendar analysis."
  measures:
    - name: "total_otb_budget_amount"
      expr: SUM(CAST(otb_budget_amount AS DOUBLE))
      comment: "Total OTB budget allocated across seasons. Measures total buying authority by season."
    - name: "avg_target_gmroi"
      expr: AVG(CAST(target_gmroi AS DOUBLE))
      comment: "Average GMROI target across seasons. Benchmarks return expectations on seasonal inventory investment."
    - name: "avg_target_inventory_turns"
      expr: AVG(CAST(target_inventory_turns AS DOUBLE))
      comment: "Average inventory turn target by season. Measures expected velocity of seasonal inventory."
    - name: "avg_target_sell_through_rate"
      expr: AVG(CAST(target_sell_through_rate AS DOUBLE))
      comment: "Average sell-through rate target. Benchmarks expected clearance efficiency before season end."
    - name: "season_count"
      expr: COUNT(1)
      comment: "Number of seasons in the planning calendar. Tracks seasonal planning coverage and cadence."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_category_accrual_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category accrual rule financial KPIs tracking accrual rates, caps, thresholds, and settlement activity. Used by finance and merchandising to manage vendor accrual programs and ensure accurate financial posting."
  source: "`vibe_retail_v1`.`merchandising`.`category_accrual_rule`"
  dimensions:
    - name: "category_accrual_rule_status"
      expr: category_accrual_rule_status
      comment: "Current status of the accrual rule (e.g. active, inactive, pending approval)."
    - name: "accrual_type"
      expr: accrual_type
      comment: "Type of accrual (e.g. vendor allowance, co-op, rebate). Classifies the financial nature of the accrual."
    - name: "accrual_basis"
      expr: accrual_basis
      comment: "Basis for accrual calculation (e.g. sales, cost, units). Determines how the accrual is computed."
    - name: "accrual_frequency"
      expr: accrual_frequency
      comment: "Frequency of accrual calculation (e.g. daily, weekly, monthly)."
    - name: "settlement_method"
      expr: settlement_method
      comment: "Method of settlement (e.g. check, credit memo, deduction). Affects AP/AR treatment."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which accrual amounts are denominated."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the accrual rule."
    - name: "stacking_allowed_flag"
      expr: stacking_allowed_flag
      comment: "Indicates whether multiple accrual rules can stack. Affects total accrual exposure calculation."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date of the accrual rule effective period."
  measures:
    - name: "total_accrued_amount"
      expr: SUM(CAST(total_accrued_amount AS DOUBLE))
      comment: "Total amount accrued under category accrual rules. Measures total vendor financial obligation recognized."
    - name: "total_posted_amount"
      expr: SUM(CAST(total_posted_amount AS DOUBLE))
      comment: "Total amount posted to GL under accrual rules. Measures financial settlement execution."
    - name: "total_accrual_cap_amount"
      expr: SUM(CAST(accrual_cap_amount AS DOUBLE))
      comment: "Total accrual cap across rules. Measures maximum vendor obligation exposure."
    - name: "avg_accrual_rate_pct"
      expr: AVG(CAST(accrual_rate_pct AS DOUBLE))
      comment: "Average accrual rate percentage. Benchmarks vendor program generosity and financial impact."
    - name: "avg_minimum_spend_threshold"
      expr: AVG(CAST(minimum_spend_threshold AS DOUBLE))
      comment: "Average minimum spend threshold to qualify for accrual. Measures vendor program entry barriers."
    - name: "avg_points_multiplier"
      expr: AVG(CAST(points_multiplier AS DOUBLE))
      comment: "Average points multiplier for loyalty-linked accrual rules. Measures loyalty program integration intensity."
    - name: "avg_variance_threshold_pct"
      expr: AVG(CAST(variance_threshold_pct AS DOUBLE))
      comment: "Average variance threshold percentage. Measures tolerance for accrual calculation discrepancies before escalation."
    - name: "accrual_rule_count"
      expr: COUNT(1)
      comment: "Number of active category accrual rules. Tracks vendor program complexity and financial obligation breadth."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_buyer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Buyer business metrics"
  source: "`vibe_retail_v1`.`merchandising`.`buyer`"
  dimensions:
    - name: "Assigned Category Codes"
      expr: assigned_category_codes
    - name: "Assigned Department Codes"
      expr: assigned_department_codes
    - name: "Assortment Planning System Access"
      expr: assortment_planning_system_access
    - name: "Buyer Code"
      expr: buyer_code
    - name: "Buyer Name"
      expr: buyer_name
    - name: "Buyer Status"
      expr: buyer_status
    - name: "Buyer Type"
      expr: buyer_type
    - name: "Certification Credentials"
      expr: certification_credentials
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source System"
      expr: data_source_system
    - name: "Division Code"
      expr: division_code
    - name: "Email Address"
      expr: email_address
    - name: "Hire Date"
      expr: hire_date
    - name: "International Sourcing Flag"
      expr: international_sourcing_flag
    - name: "Language Proficiency"
      expr: language_proficiency
    - name: "Last Modified By User"
      expr: last_modified_by_user
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Buyer"
      expr: COUNT(DISTINCT buyer_id)
    - name: "Total Buying Authority Limit"
      expr: SUM(buying_authority_limit)
    - name: "Average Buying Authority Limit"
      expr: AVG(buying_authority_limit)
    - name: "Total Gmroi Target"
      expr: SUM(gmroi_target)
    - name: "Average Gmroi Target"
      expr: AVG(gmroi_target)
    - name: "Total Inventory Turn Target"
      expr: SUM(inventory_turn_target)
    - name: "Average Inventory Turn Target"
      expr: AVG(inventory_turn_target)
    - name: "Total Markdown Percentage Limit"
      expr: SUM(markdown_percentage_limit)
    - name: "Average Markdown Percentage Limit"
      expr: AVG(markdown_percentage_limit)
    - name: "Total Otb Budget Limit"
      expr: SUM(otb_budget_limit)
    - name: "Average Otb Budget Limit"
      expr: AVG(otb_budget_limit)
    - name: "Total Sell Through Rate Target"
      expr: SUM(sell_through_rate_target)
    - name: "Average Sell Through Rate Target"
      expr: AVG(sell_through_rate_target)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_category_campaign_placement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category Campaign Placement business metrics"
  source: "`vibe_retail_v1`.`merchandising`.`category_campaign_placement`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Is Featured"
      expr: is_featured
    - name: "Placement Status"
      expr: placement_status
    - name: "Priority Rank"
      expr: priority_rank
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Category Campaign Placement"
      expr: COUNT(DISTINCT category_campaign_placement_id)
    - name: "Total Actual Sales Amount"
      expr: SUM(actual_sales_amount)
    - name: "Average Actual Sales Amount"
      expr: AVG(actual_sales_amount)
    - name: "Total Actual Spend Amount"
      expr: SUM(actual_spend_amount)
    - name: "Average Actual Spend Amount"
      expr: AVG(actual_spend_amount)
    - name: "Total Budget Allocation Amount"
      expr: SUM(budget_allocation_amount)
    - name: "Average Budget Allocation Amount"
      expr: AVG(budget_allocation_amount)
    - name: "Total Target Sales Amount"
      expr: SUM(target_sales_amount)
    - name: "Average Target Sales Amount"
      expr: AVG(target_sales_amount)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_merchandising_planogram`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Merchandising Planogram business metrics"
  source: "`vibe_retail_v1`.`merchandising`.`merchandising_planogram`"
  dimensions:
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Compliance Required Flag"
      expr: compliance_required_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Fixture Type"
      expr: fixture_type
    - name: "Implementation Instructions"
      expr: implementation_instructions
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Reset Date"
      expr: last_reset_date
    - name: "Merchandising Planogram Status"
      expr: merchandising_planogram_status
    - name: "Next Scheduled Reset Date"
      expr: next_scheduled_reset_date
    - name: "Planogram Code"
      expr: planogram_code
    - name: "Planogram Name"
      expr: planogram_name
    - name: "Seasonal Flag"
      expr: seasonal_flag
    - name: "Shelf Count"
      expr: shelf_count
    - name: "Space Planning System Code"
      expr: space_planning_system_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Merchandising Planogram"
      expr: COUNT(DISTINCT merchandising_planogram_id)
    - name: "Total Compliance Tolerance Pct"
      expr: SUM(compliance_tolerance_pct)
    - name: "Average Compliance Tolerance Pct"
      expr: AVG(compliance_tolerance_pct)
    - name: "Total Fixture Depth Cm"
      expr: SUM(fixture_depth_cm)
    - name: "Average Fixture Depth Cm"
      expr: AVG(fixture_depth_cm)
    - name: "Total Fixture Height Cm"
      expr: SUM(fixture_height_cm)
    - name: "Average Fixture Height Cm"
      expr: AVG(fixture_height_cm)
    - name: "Total Fixture Width Cm"
      expr: SUM(fixture_width_cm)
    - name: "Average Fixture Width Cm"
      expr: AVG(fixture_width_cm)
    - name: "Total Space Allocation Sqft"
      expr: SUM(space_allocation_sqft)
    - name: "Average Space Allocation Sqft"
      expr: AVG(space_allocation_sqft)
    - name: "Total Target Gmroi"
      expr: SUM(target_gmroi)
    - name: "Average Target Gmroi"
      expr: AVG(target_gmroi)
    - name: "Total Target Sales Per Sqft"
      expr: SUM(target_sales_per_sqft)
    - name: "Average Target Sales Per Sqft"
      expr: AVG(target_sales_per_sqft)
$$;