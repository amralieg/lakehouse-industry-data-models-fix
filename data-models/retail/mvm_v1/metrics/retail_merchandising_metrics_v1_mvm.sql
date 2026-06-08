-- Metric views for domain: merchandising | Business: Retail | Version: 1 | Generated on: 2026-05-04 13:23:00

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`merchandising_buying_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for buying order execution — tracks total committed spend, landed cost efficiency, freight and duty burden, and order fulfilment velocity. Used by merchandising leadership to govern open-to-buy consumption and vendor cost performance."
  source: "`retail_ecm`.`merchandising`.`buying_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the buying order (e.g. Draft, Submitted, Approved, Cancelled) — primary filter for active vs. closed order analysis."
    - name: "order_type"
      expr: order_type
      comment: "Classification of the buying order (e.g. Regular, Replenishment, Promotional) — used to segment spend by procurement strategy."
    - name: "destination_type"
      expr: destination_type
      comment: "Destination channel for the order (e.g. Store, DC, Drop-Ship) — drives fulfilment cost and lead-time analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the order is denominated — required for multi-currency spend normalisation."
    - name: "fob_terms"
      expr: fob_terms
      comment: "Free-on-board terms agreed with the vendor — affects landed cost composition and risk allocation."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Vendor payment terms (e.g. Net 30, Net 60) — used to model cash-flow timing against OTB commitments."
    - name: "order_date"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month in which the buying order was placed — enables trend analysis of purchasing activity over time."
    - name: "planned_receipt_month"
      expr: DATE_TRUNC('month', planned_receipt_date)
      comment: "Month in which goods are planned to be received — used to align OTB commitments with inventory flow calendars."
    - name: "ship_window_start_month"
      expr: DATE_TRUNC('month', ship_window_start_date)
      comment: "Month the vendor ship window opens — used to monitor vendor on-time shipping compliance."
  measures:
    - name: "total_order_cost"
      expr: SUM(CAST(total_order_cost AS DOUBLE))
      comment: "Total committed buying spend across all orders in scope. Core OTB consumption metric used by buyers and finance to track budget utilisation."
    - name: "total_landed_cost"
      expr: SUM(CAST(landed_cost AS DOUBLE))
      comment: "Total landed cost (unit cost + freight + duty) for all orders. Reflects true cost of goods and is the primary input to gross margin planning."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Aggregate freight spend across buying orders. Monitored to identify logistics cost inflation and vendor routing inefficiencies."
    - name: "total_duty_cost"
      expr: SUM(CAST(duty_cost AS DOUBLE))
      comment: "Aggregate import duty spend across buying orders. Critical for international sourcing cost management and tariff impact assessment."
    - name: "total_order_quantity"
      expr: SUM(CAST(total_order_quantity AS DOUBLE))
      comment: "Total units ordered across all buying orders. Used to validate assortment depth commitments against plan."
    - name: "avg_order_cost"
      expr: AVG(CAST(total_order_cost AS DOUBLE))
      comment: "Average cost per buying order. Benchmarks order sizing efficiency and identifies outlier orders requiring review."
    - name: "freight_cost_per_unit"
      expr: SUM(CAST(freight_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_order_quantity AS DOUBLE)), 0)
      comment: "Freight cost per ordered unit. Key efficiency ratio for logistics cost benchmarking across vendors and routes."
    - name: "duty_cost_per_unit"
      expr: SUM(CAST(duty_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_order_quantity AS DOUBLE)), 0)
      comment: "Duty cost per ordered unit. Tracks tariff burden intensity and informs sourcing country diversification decisions."
    - name: "landed_cost_vs_order_cost_ratio"
      expr: SUM(CAST(landed_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_order_cost AS DOUBLE)), 0)
      comment: "Ratio of total landed cost to total order cost. Values above 1.0 indicate significant freight/duty burden; used to evaluate true cost of sourcing decisions."
    - name: "buying_order_count"
      expr: COUNT(1)
      comment: "Total number of buying orders. Baseline volume metric for order activity monitoring and buyer workload assessment."
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN order_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled buying orders. Elevated cancellation rates signal vendor reliability issues or demand forecast failures."
    - name: "cancellation_rate"
      expr: COUNT(CASE WHEN order_status = 'Cancelled' THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Proportion of buying orders that were cancelled. A leading indicator of supply chain disruption and vendor performance risk."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`merchandising_buying_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level buying metrics providing granular visibility into SKU-level cost, margin, fulfilment, and order fill rates. Used by buyers and planners to manage item-level OTB, vendor performance, and planned margin integrity."
  source: "`retail_ecm`.`merchandising`.`buying_order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the buying order line (e.g. Open, Received, Cancelled) — primary filter for active vs. closed line analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the order line — required for multi-currency cost and margin normalisation."
    - name: "private_label_flag"
      expr: private_label_flag
      comment: "Indicates whether the SKU is a private-label product — used to segment margin and cost performance by brand ownership strategy."
    - name: "drop_ship_flag"
      expr: drop_ship_flag
      comment: "Indicates whether the line is fulfilled via drop-ship — used to separate direct fulfilment economics from warehouse-routed orders."
    - name: "store_cluster_code"
      expr: store_cluster_code
      comment: "Store cluster to which the line is allocated — enables cluster-level assortment and cost performance analysis."
    - name: "delivery_month"
      expr: DATE_TRUNC('month', delivery_date)
      comment: "Month of planned delivery — used to align receipt flow with inventory and sales plans."
    - name: "cancel_month"
      expr: DATE_TRUNC('month', cancel_date)
      comment: "Month in which the line was cancelled — used to identify seasonal cancellation patterns and vendor reliability trends."
  measures:
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total extended cost (unit cost × ordered quantity) across all order lines. Primary measure of committed buying spend at the SKU level."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total units ordered across all buying order lines. Validates assortment depth commitments and vendor capacity utilisation."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total units actually received. Compared against ordered quantity to measure vendor fill rate and supply chain reliability."
    - name: "total_cancelled_quantity"
      expr: SUM(CAST(cancelled_quantity AS DOUBLE))
      comment: "Total units cancelled across order lines. High cancellation volumes indicate vendor non-performance or demand forecast revisions."
    - name: "order_fill_rate"
      expr: SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0)
      comment: "Ratio of received units to ordered units. Core vendor performance KPI — low fill rates directly impact in-stock levels and lost sales."
    - name: "cancellation_rate_by_quantity"
      expr: SUM(CAST(cancelled_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0)
      comment: "Proportion of ordered units that were cancelled. Tracks supply disruption severity and vendor reliability at the line level."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across order lines. Benchmarks cost negotiation outcomes and tracks cost inflation trends by category or vendor."
    - name: "total_planned_margin_amount"
      expr: SUM(CAST(planned_margin_amount AS DOUBLE))
      comment: "Total planned gross margin dollars across all order lines. Directly tied to financial plan attainment and category profitability targets."
    - name: "avg_planned_margin_percent"
      expr: AVG(CAST(planned_margin_percent AS DOUBLE))
      comment: "Average planned margin percentage across order lines. Used to assess whether buying decisions are aligned with category margin targets."
    - name: "total_retail_value"
      expr: SUM(CAST(retail_price AS DOUBLE) * CAST(ordered_quantity AS DOUBLE))
      comment: "Total planned retail value of ordered units (retail price × ordered quantity). Measures the revenue potential of the buying commitment."
    - name: "avg_retail_price"
      expr: AVG(CAST(retail_price AS DOUBLE))
      comment: "Average retail price across order lines. Tracks price positioning and average unit retail (AUR) trends by category or season."
    - name: "buying_order_line_count"
      expr: COUNT(1)
      comment: "Total number of buying order lines. Baseline volume metric for order complexity and buyer workload management."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`merchandising_merch_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Merchandise plan performance metrics tracking planned vs. prior-year sales, margin, inventory, and receipt flow. Used by merchandising leadership and finance to govern seasonal financial plans and evaluate plan quality."
  source: "`retail_ecm`.`merchandising`.`merch_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Approval and lifecycle status of the merchandise plan (e.g. Draft, Approved, Closed) — primary filter for active plan analysis."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of merchandise plan (e.g. Pre-Season, In-Season, Post-Season) — used to segment planning horizon and accuracy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the plan — required for multi-currency financial plan consolidation."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the plan is currently active — used to filter dashboards to live plans only."
    - name: "plan_start_month"
      expr: DATE_TRUNC('month', plan_start_date)
      comment: "Month the plan period begins — used to align plan metrics with the retail calendar."
    - name: "plan_end_month"
      expr: DATE_TRUNC('month', plan_end_date)
      comment: "Month the plan period ends — used to scope plan performance to the correct selling window."
    - name: "approval_month"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month the plan was approved — used to track planning cycle timeliness and governance compliance."
  measures:
    - name: "total_planned_sales_amount"
      expr: SUM(CAST(planned_sales_amount AS DOUBLE))
      comment: "Total planned sales revenue across all merchandise plans. Primary top-line financial target used in seasonal planning and budget governance."
    - name: "total_planned_margin_amount"
      expr: SUM(CAST(planned_margin_amount AS DOUBLE))
      comment: "Total planned gross margin dollars. Core profitability target used to evaluate whether the plan meets financial return requirements."
    - name: "avg_planned_margin_percent"
      expr: AVG(CAST(planned_margin_percent AS DOUBLE))
      comment: "Average planned gross margin percentage across plans. Benchmarks margin quality and identifies plans below category margin thresholds."
    - name: "total_planned_receipt_amount"
      expr: SUM(CAST(planned_receipt_amount AS DOUBLE))
      comment: "Total planned receipt dollars (inventory inflow). Used to validate OTB budget alignment and inventory build strategy."
    - name: "total_otb_budget_amount"
      expr: SUM(CAST(otb_budget_amount AS DOUBLE))
      comment: "Total open-to-buy budget allocated across merchandise plans. Governs buying authority and prevents over-commitment of inventory spend."
    - name: "total_planned_markdown_amount"
      expr: SUM(CAST(planned_markdown_amount AS DOUBLE))
      comment: "Total planned markdown dollars. Tracks the anticipated cost of clearance and promotional price reductions against the plan."
    - name: "avg_planned_markdown_percent"
      expr: AVG(CAST(planned_markdown_percent AS DOUBLE))
      comment: "Average planned markdown percentage across plans. Elevated markdown rates signal over-buying risk or weak demand forecasts."
    - name: "total_planned_beginning_inventory"
      expr: SUM(CAST(planned_beginning_inventory_amount AS DOUBLE))
      comment: "Total planned beginning-of-period inventory value. Used to compute planned inventory turns and assess carry-over stock risk."
    - name: "total_planned_ending_inventory"
      expr: SUM(CAST(planned_ending_inventory_amount AS DOUBLE))
      comment: "Total planned end-of-period inventory value. Tracks planned inventory exit position and clearance effectiveness."
    - name: "planned_inventory_turn_rate"
      expr: SUM(CAST(planned_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(planned_beginning_inventory_amount AS DOUBLE)), 0)
      comment: "Planned inventory turn rate (COGS / beginning inventory). Measures how efficiently inventory is expected to be converted to sales — a core merchandising efficiency KPI."
    - name: "planned_sales_vs_prior_year_growth"
      expr: SUM(CAST(planned_sales_amount AS DOUBLE)) / NULLIF(SUM(CAST(prior_year_sales_amount AS DOUBLE)), 0) - 1
      comment: "Planned sales growth rate versus prior year. Measures the ambition of the plan and is a primary input to executive target-setting and investor guidance."
    - name: "avg_gmroi_target"
      expr: AVG(CAST(gmroi_target AS DOUBLE))
      comment: "Average Gross Margin Return on Inventory Investment (GMROI) target across plans. GMROI is the definitive merchandising efficiency metric used by executives to evaluate category investment returns."
    - name: "avg_sell_through_target_percent"
      expr: AVG(CAST(sell_through_target_percent AS DOUBLE))
      comment: "Average planned sell-through rate target across merchandise plans. Tracks the ambition of inventory liquidation plans and clearance strategy effectiveness."
    - name: "merch_plan_count"
      expr: COUNT(1)
      comment: "Total number of merchandise plans. Used to monitor planning coverage and governance completeness across categories and seasons."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`merchandising_otb_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Open-to-Buy (OTB) budget utilisation and variance metrics. Tracks planned vs. actual receipt spend, available budget balance, and budget adjustment activity. Used by buyers, planners, and finance to govern in-season buying authority and prevent over-commitment."
  source: "`retail_ecm`.`merchandising`.`otb_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the OTB budget (e.g. Active, Closed, Suspended) — primary filter for live budget monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the OTB budget — used to identify budgets pending approval that may block buying activity."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the OTB budget — used for year-over-year budget trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (e.g. month or quarter) of the OTB budget — enables in-season budget pacing analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the OTB budget — required for multi-currency budget consolidation."
    - name: "budget_start_month"
      expr: DATE_TRUNC('month', budget_start_date)
      comment: "Month the budget period begins — used to align OTB metrics with the retail planning calendar."
    - name: "budget_end_month"
      expr: DATE_TRUNC('month', budget_end_date)
      comment: "Month the budget period ends — used to scope OTB analysis to the correct buying window."
  measures:
    - name: "total_planned_receipts_at_cost"
      expr: SUM(CAST(planned_receipts_at_cost AS DOUBLE))
      comment: "Total planned receipt dollars at cost across all OTB budgets. The primary OTB budget baseline used to govern buying authority."
    - name: "total_actual_receipts_at_cost"
      expr: SUM(CAST(actual_receipts_at_cost AS DOUBLE))
      comment: "Total actual receipt dollars at cost. Compared against planned receipts to measure OTB consumption and identify over/under-buying."
    - name: "total_available_otb_balance"
      expr: SUM(CAST(available_otb_balance AS DOUBLE))
      comment: "Total remaining open-to-buy balance available for commitment. Critical real-time metric for buyers to understand remaining buying authority."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total dollars committed against the OTB budget (orders placed but not yet received). Used to compute true available balance and prevent double-commitment."
    - name: "otb_utilisation_rate"
      expr: SUM(CAST(actual_receipts_at_cost AS DOUBLE)) / NULLIF(SUM(CAST(planned_receipts_at_cost AS DOUBLE)), 0)
      comment: "Ratio of actual receipts to planned receipts. Measures how fully the OTB budget has been consumed — under-utilisation signals missed buying opportunities; over-utilisation signals budget breach risk."
    - name: "total_budget_adjustment_amount"
      expr: SUM(CAST(budget_adjustment_amount AS DOUBLE))
      comment: "Total net budget adjustments (increases minus decreases) applied to OTB budgets. High adjustment volumes indicate forecast instability or reactive buying behaviour."
    - name: "total_budget_increase_amount"
      expr: SUM(CAST(budget_increase_amount AS DOUBLE))
      comment: "Total upward OTB budget revisions. Tracks in-season demand upside responses and their financial impact on buying authority."
    - name: "total_budget_decrease_amount"
      expr: SUM(CAST(budget_decrease_amount AS DOUBLE))
      comment: "Total downward OTB budget revisions. Tracks demand risk mitigation actions and their impact on vendor commitments."
    - name: "net_budget_transfer_amount"
      expr: SUM((CAST(budget_transfer_in_amount AS DOUBLE)) - (CAST(budget_transfer_out_amount AS DOUBLE)))
      comment: "Net OTB budget transferred in minus transferred out. Measures inter-category or inter-period budget reallocation activity — a key indicator of in-season plan agility."
    - name: "avg_gmroi_target"
      expr: AVG(CAST(gmroi_target AS DOUBLE))
      comment: "Average GMROI target across OTB budgets. Ensures buying decisions are governed by return-on-investment thresholds, not just spend limits."
    - name: "avg_sell_through_target_pct"
      expr: AVG(CAST(sell_through_target_pct AS DOUBLE))
      comment: "Average sell-through rate target across OTB budgets. Tracks the inventory liquidation ambition embedded in the buying plan."
    - name: "avg_markdown_budget_pct"
      expr: AVG(CAST(markdown_budget_pct AS DOUBLE))
      comment: "Average markdown budget as a percentage of OTB. Monitors the planned cost of clearance activity and its drag on gross margin."
    - name: "otb_budget_count"
      expr: COUNT(1)
      comment: "Total number of OTB budget records. Used to monitor budget governance coverage across categories, seasons, and buyers."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`merchandising_markdown_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Markdown event performance metrics tracking revenue impact, margin erosion, sell-through lift, and vendor contribution. Used by buyers, pricing teams, and finance to evaluate markdown effectiveness and optimise clearance strategy."
  source: "`retail_ecm`.`merchandising`.`markdown_event`"
  dimensions:
    - name: "markdown_status"
      expr: markdown_status
      comment: "Current status of the markdown event (e.g. Planned, Active, Completed, Cancelled) — primary filter for live vs. historical markdown analysis."
    - name: "markdown_type"
      expr: markdown_type
      comment: "Type of markdown (e.g. Clearance, Promotional, Permanent) — used to segment margin impact by markdown strategy."
    - name: "markdown_reason"
      expr: markdown_reason
      comment: "Business reason for the markdown (e.g. End of Season, Slow Seller, Competitive Response) — used to diagnose root causes of margin erosion."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the markdown event — required for multi-currency margin impact consolidation."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Indicates whether the markdown required management approval — used to audit governance compliance for high-impact markdowns."
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the markdown became effective — used to track markdown cadence and seasonal clearance timing."
    - name: "end_month"
      expr: DATE_TRUNC('month', end_date)
      comment: "Month the markdown event ended — used to measure markdown duration and its correlation with sell-through lift."
  measures:
    - name: "total_actual_revenue_impact"
      expr: SUM(CAST(actual_revenue_impact AS DOUBLE))
      comment: "Total actual revenue impact of markdown events. Measures the top-line cost of price reductions — a primary input to markdown ROI analysis."
    - name: "total_actual_margin_impact"
      expr: SUM(CAST(actual_margin_impact AS DOUBLE))
      comment: "Total actual gross margin impact of markdown events. The definitive measure of markdown cost — used by finance and merchants to evaluate clearance strategy profitability."
    - name: "total_projected_revenue_impact"
      expr: SUM(CAST(projected_revenue_impact AS DOUBLE))
      comment: "Total projected revenue impact at the time of markdown planning. Compared against actual impact to measure markdown forecast accuracy."
    - name: "total_projected_margin_impact"
      expr: SUM(CAST(projected_margin_impact AS DOUBLE))
      comment: "Total projected margin impact at planning time. Used to assess whether markdown decisions were financially justified ex-ante."
    - name: "revenue_impact_forecast_accuracy"
      expr: SUM(CAST(actual_revenue_impact AS DOUBLE)) / NULLIF(SUM(CAST(projected_revenue_impact AS DOUBLE)), 0)
      comment: "Ratio of actual to projected revenue impact. Measures markdown forecast accuracy — persistent over/under-estimation signals pricing model deficiencies."
    - name: "margin_impact_forecast_accuracy"
      expr: SUM(CAST(actual_margin_impact AS DOUBLE)) / NULLIF(SUM(CAST(projected_margin_impact AS DOUBLE)), 0)
      comment: "Ratio of actual to projected margin impact. Tracks the accuracy of margin erosion forecasts — critical for financial planning credibility."
    - name: "total_markdown_amount"
      expr: SUM(CAST(markdown_amount AS DOUBLE))
      comment: "Total dollar value of price reductions applied across markdown events. Measures the aggregate depth of price investment in clearance activity."
    - name: "avg_markdown_percentage"
      expr: AVG(CAST(markdown_percentage AS DOUBLE))
      comment: "Average markdown depth as a percentage of original price. Tracks the intensity of price reductions and their relationship to sell-through lift."
    - name: "avg_actual_sell_through_lift"
      expr: AVG(CAST(actual_sell_through_lift_percentage AS DOUBLE))
      comment: "Average actual sell-through rate lift achieved by markdown events. Measures markdown effectiveness — the primary KPI for evaluating whether price reductions are driving inventory liquidation."
    - name: "avg_projected_sell_through_lift"
      expr: AVG(CAST(projected_sell_through_lift_percentage AS DOUBLE))
      comment: "Average projected sell-through lift at planning time. Compared against actual lift to evaluate markdown planning model accuracy."
    - name: "total_vendor_contribution_amount"
      expr: SUM(CAST(vendor_contribution_amount AS DOUBLE))
      comment: "Total vendor funding contribution to markdown events. Measures the degree to which vendors share the cost of clearance — a key vendor negotiation and partnership metric."
    - name: "vendor_contribution_rate"
      expr: SUM(CAST(vendor_contribution_amount AS DOUBLE)) / NULLIF(SUM(CAST(markdown_amount AS DOUBLE)), 0)
      comment: "Vendor contribution as a proportion of total markdown dollars. Tracks vendor partnership quality and the retailer's net markdown cost after vendor offsets."
    - name: "markdown_event_count"
      expr: COUNT(1)
      comment: "Total number of markdown events. Baseline volume metric for markdown activity monitoring and governance compliance tracking."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`merchandising_assortment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assortment plan quality and financial target metrics. Tracks OTB budget allocation, private label mix, GMROI and sell-through targets, and plan governance. Used by merchants and category managers to evaluate assortment strategy and financial ambition."
  source: "`retail_ecm`.`merchandising`.`assortment_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Approval and lifecycle status of the assortment plan (e.g. Draft, Approved, Archived) — primary filter for active plan analysis."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of assortment plan (e.g. New Season, Replenishment, Promotional) — used to segment planning strategy and financial target analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the assortment plan — used for year-over-year assortment strategy comparison."
    - name: "clustering_methodology"
      expr: clustering_methodology
      comment: "Store clustering approach used in the assortment plan — used to evaluate the sophistication and localisation of assortment strategies."
    - name: "planogram_required_flag"
      expr: planogram_required_flag
      comment: "Indicates whether a planogram is required for this assortment plan — used to manage space planning workload and compliance."
    - name: "otb_currency_code"
      expr: otb_currency_code
      comment: "Currency of the OTB budget in the assortment plan — required for multi-currency budget consolidation."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the assortment plan becomes effective — used to align assortment metrics with the retail selling calendar."
    - name: "approval_month"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month the assortment plan was approved — used to track planning governance timeliness."
  measures:
    - name: "total_otb_budget_amount"
      expr: SUM(CAST(otb_budget_amount AS DOUBLE))
      comment: "Total OTB budget allocated across assortment plans. Governs the financial envelope for assortment investment decisions."
    - name: "avg_target_gmroi"
      expr: AVG(CAST(target_gmroi AS DOUBLE))
      comment: "Average GMROI target across assortment plans. Measures the return-on-investment ambition of assortment strategies — the primary financial efficiency KPI for merchandising."
    - name: "avg_target_inventory_turn_rate"
      expr: AVG(CAST(target_inventory_turn_rate AS DOUBLE))
      comment: "Average inventory turn rate target across assortment plans. Tracks the planned velocity of inventory conversion — high turns indicate lean, efficient assortments."
    - name: "avg_target_sell_through_rate"
      expr: AVG(CAST(target_sell_through_rate_percent AS DOUBLE))
      comment: "Average sell-through rate target across assortment plans. Measures the planned effectiveness of inventory liquidation — a key indicator of assortment quality and demand alignment."
    - name: "avg_private_label_mix_percent"
      expr: AVG(CAST(private_label_mix_percent AS DOUBLE))
      comment: "Average private label penetration target across assortment plans. Tracks the strategic shift toward owned-brand assortments, which typically carry higher margins."
    - name: "assortment_plan_count"
      expr: COUNT(1)
      comment: "Total number of assortment plans. Baseline governance metric for planning coverage across categories, seasons, and store formats."
    - name: "approved_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'Approved' THEN 1 END)
      comment: "Number of assortment plans in Approved status. Tracks planning governance completion — unapproved plans represent buying authority risk."
    - name: "plan_approval_rate"
      expr: COUNT(CASE WHEN plan_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Proportion of assortment plans that have been approved. Measures planning governance health — low approval rates signal process bottlenecks or quality issues."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`merchandising_category`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category performance and financial target metrics. Tracks actual vs. target GMROI, sell-through, margin, and OTB budget at the category level. Used by category managers and merchandising leadership to evaluate category health and strategic alignment."
  source: "`retail_ecm`.`merchandising`.`category`"
  dimensions:
    - name: "category_status"
      expr: category_status
      comment: "Current status of the category (e.g. Active, Discontinued, Under Review) — primary filter for live category performance analysis."
    - name: "category_role"
      expr: category_role
      comment: "Strategic role of the category (e.g. Destination, Routine, Convenience, Seasonal) — used to segment performance expectations and investment priorities."
    - name: "merchandise_type"
      expr: merchandise_type
      comment: "Type of merchandise in the category (e.g. Hardlines, Softlines, Grocery, Electronics) — used for cross-merchandise-type performance benchmarking."
    - name: "division"
      expr: division
      comment: "Business division owning the category — used for divisional performance roll-up and resource allocation decisions."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level of the category in the merchandise hierarchy (e.g. Department, Class, Subclass) — used to scope analysis to the correct planning granularity."
    - name: "is_leaf_node"
      expr: is_leaf_node
      comment: "Indicates whether the category is a leaf node in the hierarchy — used to filter to the most granular planning level."
    - name: "seasonality_flag"
      expr: seasonality_flag
      comment: "Indicates whether the category has significant seasonal demand patterns — used to contextualise sell-through and inventory turn performance."
    - name: "peak_season"
      expr: peak_season
      comment: "Primary peak selling season for the category — used to align performance metrics with seasonal demand cycles."
    - name: "strategic_objective"
      expr: strategic_objective
      comment: "Strategic objective assigned to the category (e.g. Grow, Maintain, Harvest) — used to evaluate whether financial performance aligns with strategic intent."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the category became effective — used to track category lifecycle and assortment evolution over time."
  measures:
    - name: "total_actual_gmroi"
      expr: SUM(CAST(actual_gmroi AS DOUBLE))
      comment: "Sum of actual GMROI across categories. Used in aggregate to assess portfolio-level return on inventory investment."
    - name: "avg_actual_gmroi"
      expr: AVG(CAST(actual_gmroi AS DOUBLE))
      comment: "Average actual GMROI across categories. The primary category-level efficiency KPI — measures how much gross margin is generated per dollar of average inventory investment."
    - name: "avg_target_gmroi"
      expr: AVG(CAST(target_gmroi AS DOUBLE))
      comment: "Average GMROI target across categories. Used alongside actual GMROI to compute performance-to-target variance and identify underperforming categories."
    - name: "gmroi_vs_target_ratio"
      expr: SUM(CAST(actual_gmroi AS DOUBLE)) / NULLIF(SUM(CAST(target_gmroi AS DOUBLE)), 0)
      comment: "Ratio of actual GMROI to target GMROI across categories. Values below 1.0 indicate categories missing their return targets — triggers strategic review and potential assortment rationalisation."
    - name: "avg_actual_sell_through_rate"
      expr: AVG(CAST(actual_sell_through_rate AS DOUBLE))
      comment: "Average actual sell-through rate across categories. Measures how effectively inventory is being converted to sales — low rates signal over-buying or weak demand."
    - name: "avg_target_sell_through_rate"
      expr: AVG(CAST(target_sell_through_rate AS DOUBLE))
      comment: "Average sell-through rate target across categories. Used alongside actual sell-through to identify categories at risk of excess inventory and markdown exposure."
    - name: "sell_through_vs_target_ratio"
      expr: SUM(CAST(actual_sell_through_rate AS DOUBLE)) / NULLIF(SUM(CAST(target_sell_through_rate AS DOUBLE)), 0)
      comment: "Ratio of actual to target sell-through rate. A ratio below 1.0 signals inventory liquidation risk and potential need for markdown intervention."
    - name: "avg_target_margin_percent"
      expr: AVG(CAST(target_margin_percent AS DOUBLE))
      comment: "Average target gross margin percentage across categories. Tracks the margin ambition of the category portfolio and its alignment with financial plan requirements."
    - name: "avg_target_inventory_turns"
      expr: AVG(CAST(target_inventory_turns AS DOUBLE))
      comment: "Average inventory turn target across categories. Measures the planned velocity of inventory conversion — a key input to working capital efficiency analysis."
    - name: "total_otb_budget_amount"
      expr: SUM(CAST(otb_budget_amount AS DOUBLE))
      comment: "Total OTB budget allocated at the category level. Used to govern buying authority and ensure category investment is aligned with strategic priorities."
    - name: "avg_private_label_penetration_target"
      expr: AVG(CAST(private_label_penetration_target AS DOUBLE))
      comment: "Average private label penetration target across categories. Tracks the strategic shift toward owned-brand assortments and their higher-margin contribution."
    - name: "category_count"
      expr: COUNT(1)
      comment: "Total number of active category records. Used to monitor assortment breadth and hierarchy governance completeness."
$$;