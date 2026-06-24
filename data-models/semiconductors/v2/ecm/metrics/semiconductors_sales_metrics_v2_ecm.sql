-- Metric views for domain: sales | Business: Semiconductors | Version: 2 | Generated on: 2026-06-23 23:34:49

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic pipeline metrics for semiconductor sales opportunities — tracks pipeline value, win rates, NRE commitments, and stage velocity to steer revenue forecasting and resource allocation decisions."
  source: "`vibe_semiconductors_v1`.`sales`.`opportunity`"
  dimensions:
    - name: "opportunity_stage"
      expr: stage
      comment: "Current pipeline stage of the opportunity (e.g., Prospecting, Qualification, Proposal, Closed Won/Lost) — primary dimension for funnel analysis."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Channel through which the opportunity is pursued (Direct, Distribution, FAE) — used to evaluate channel effectiveness."
    - name: "end_market"
      expr: end_market
      comment: "Target end market for the opportunity (Automotive, Consumer, Industrial, Data Center) — critical for market segment revenue analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the opportunity — used for regional pipeline and revenue distribution analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country code of the opportunity — enables country-level pipeline drill-down."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract associated with the opportunity (NRE, Volume, Wafer Supply) — differentiates revenue streams."
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model applied (Fixed, Volume Tiered, Cost-Plus) — used to assess pricing strategy effectiveness."
    - name: "expected_close_fiscal_quarter"
      expr: DATE_TRUNC('quarter', expected_close_date)
      comment: "Fiscal quarter in which the opportunity is expected to close — essential for quarterly pipeline forecasting."
    - name: "win_loss_date_month"
      expr: DATE_TRUNC('month', win_loss_date)
      comment: "Month in which the opportunity was won or lost — used for win/loss trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the opportunity value — needed for multi-currency pipeline reporting."
  measures:
    - name: "total_pipeline_gross_amount"
      expr: SUM(CAST(expected_gross_amount AS DOUBLE))
      comment: "Total gross pipeline value across all open opportunities — primary KPI for sales pipeline health and revenue forecasting."
    - name: "total_pipeline_net_amount"
      expr: SUM(CAST(expected_net_amount AS DOUBLE))
      comment: "Total net pipeline value after expected discounts — used for realistic revenue projection and quota attainment tracking."
    - name: "total_nre_pipeline_amount"
      expr: SUM(CAST(nre_amount AS DOUBLE))
      comment: "Total NRE (Non-Recurring Engineering) value in the pipeline — critical for R&D cost recovery and engineering resource planning."
    - name: "total_expected_discount_amount"
      expr: SUM(CAST(expected_discount_amount AS DOUBLE))
      comment: "Total expected discount across all opportunities — used to monitor discount leakage and pricing discipline."
    - name: "avg_opportunity_net_amount"
      expr: AVG(CAST(expected_net_amount AS DOUBLE))
      comment: "Average net deal size per opportunity — used to benchmark deal quality and identify upsell potential."
    - name: "avg_price_per_unit"
      expr: AVG(CAST(price_per_unit AS DOUBLE))
      comment: "Average unit price across opportunities — used to monitor ASP (Average Selling Price) trends and pricing strategy effectiveness."
    - name: "opportunity_count"
      expr: COUNT(1)
      comment: "Total number of opportunities in the pipeline — baseline volume metric for funnel analysis and sales productivity measurement."
    - name: "distinct_account_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customer accounts with active opportunities — measures breadth of customer engagement and pipeline diversification."
    - name: "avg_discount_rate"
      expr: AVG(CAST(expected_discount_amount AS DOUBLE) / NULLIF(expected_gross_amount, 0))
      comment: "Average discount rate as a fraction of gross opportunity value — key pricing discipline KPI for sales leadership."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue booking metrics for semiconductor orders — tracks booked revenue, discount impact, tax, and order volume to drive revenue recognition and backlog management decisions."
  source: "`vibe_semiconductors_v1`.`sales`.`booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the booking (Open, Shipped, Cancelled, On Hold) — primary filter for active backlog analysis."
    - name: "order_type"
      expr: order_type
      comment: "Type of order (Standard, NRE, MPW, Wafer, Die Bank) — differentiates revenue streams for product mix analysis."
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region of the booking — used for regional revenue performance reporting."
    - name: "ship_to_country"
      expr: ship_to_country
      comment: "Destination country for the shipment — used for geographic revenue distribution and export compliance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the booking — required for multi-currency revenue consolidation."
    - name: "delivery_mode"
      expr: delivery_mode
      comment: "Delivery mode (Wafer, Die, Packaged) — used to analyze revenue by product form factor."
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model applied to the booking — used to evaluate pricing strategy effectiveness across order types."
    - name: "product_family"
      expr: product_family
      comment: "Product family of the booked item — enables product-line revenue analysis."
    - name: "booking_month"
      expr: DATE_TRUNC('month', booking_timestamp)
      comment: "Month of booking — primary time dimension for monthly revenue booking trend analysis."
    - name: "requested_delivery_quarter"
      expr: DATE_TRUNC('quarter', requested_delivery_date)
      comment: "Quarter in which delivery is requested — used for delivery schedule and backlog aging analysis."
    - name: "backlog_flag"
      expr: backlog_flag
      comment: "Indicates whether the booking is in backlog — used to segment active backlog from fulfilled orders."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Export/trade compliance status of the booking — critical for regulatory reporting and shipment release decisions."
  measures:
    - name: "total_booked_revenue_gross"
      expr: SUM(CAST(booked_revenue_gross AS DOUBLE))
      comment: "Total gross booked revenue — primary top-line revenue KPI for sales performance and quota attainment tracking."
    - name: "total_booked_revenue_net"
      expr: SUM(CAST(booked_revenue_net AS DOUBLE))
      comment: "Total net booked revenue after discounts — used for accurate revenue recognition and financial reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted across all bookings — used to monitor pricing discipline and discount leakage."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on bookings — required for tax liability reporting and financial close."
    - name: "total_booked_quantity"
      expr: SUM(CAST(booked_quantity AS DOUBLE))
      comment: "Total units booked — volume KPI used for capacity planning, wafer start authorization, and supply chain alignment."
    - name: "booking_count"
      expr: COUNT(1)
      comment: "Total number of bookings — baseline order volume metric for sales operations and fulfillment planning."
    - name: "avg_booking_net_revenue"
      expr: AVG(CAST(booked_revenue_net AS DOUBLE))
      comment: "Average net revenue per booking — used to track deal size trends and identify revenue concentration risk."
    - name: "net_discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(booked_revenue_gross AS DOUBLE)), 0), 2)
      comment: "Net discount rate as a percentage of gross booked revenue — key pricing discipline KPI reviewed in quarterly business reviews."
    - name: "distinct_account_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customer accounts with bookings — measures customer breadth and revenue concentration."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales forecast accuracy and pipeline metrics — tracks forecast volume, revenue, bias, and MAPE to drive forecast quality improvement and supply chain alignment decisions."
  source: "`vibe_semiconductors_v1`.`sales`.`sales_forecast`"
  dimensions:
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (Commit, Best Case, Upside, Consensus) — used to segment forecast by confidence tier."
    - name: "forecast_category"
      expr: forecast_category
      comment: "Category of the forecast (Wafer Start, Revenue, Unit) — differentiates forecast dimensions for supply and financial planning."
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast (Draft, Submitted, Approved, Locked) — used to filter for approved forecasts in planning cycles."
    - name: "end_market"
      expr: end_market
      comment: "End market segment of the forecast — used for market-level demand planning and revenue allocation."
    - name: "geography"
      expr: geography
      comment: "Geographic region of the forecast — used for regional demand analysis and territory planning."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (quarter/month) of the forecast — primary time dimension for forecast cycle management."
    - name: "scenario_name"
      expr: scenario_name
      comment: "Forecast scenario (Base, Bull, Bear) — used for scenario planning and risk-adjusted revenue analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start)
      comment: "Month the forecast period begins — used for time-series forecast trend analysis."
    - name: "is_locked"
      expr: is_locked
      comment: "Indicates whether the forecast is locked for the planning cycle — used to distinguish final from working forecasts."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the forecast revenue — required for multi-currency consolidation."
  measures:
    - name: "total_forecast_revenue"
      expr: SUM(CAST(revenue AS DOUBLE))
      comment: "Total forecasted revenue across all forecast records — primary demand planning KPI used in S&OP and financial planning cycles."
    - name: "total_forecast_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total forecasted unit volume — used for wafer start planning, capacity allocation, and supply chain synchronization."
    - name: "avg_forecast_revenue"
      expr: AVG(CAST(revenue AS DOUBLE))
      comment: "Average forecasted revenue per forecast record — used to benchmark forecast size and identify outliers."
    - name: "avg_mape"
      expr: AVG(CAST(mape AS DOUBLE))
      comment: "Average Mean Absolute Percentage Error (MAPE) across forecasts — primary forecast accuracy KPI; drives process improvement in demand planning."
    - name: "avg_bias"
      expr: AVG(CAST(bias AS DOUBLE))
      comment: "Average forecast bias — measures systematic over- or under-forecasting tendency; used to calibrate forecast models and reduce supply imbalances."
    - name: "avg_variance_to_actual"
      expr: AVG(CAST(variance_to_actual AS DOUBLE))
      comment: "Average variance between forecast and actual — used to assess forecast reliability and drive corrective action in planning processes."
    - name: "forecast_record_count"
      expr: COUNT(1)
      comment: "Total number of forecast records — baseline volume metric for forecast coverage and submission compliance tracking."
    - name: "distinct_account_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customer accounts with active forecasts — measures forecast coverage breadth across the customer base."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quote conversion and pricing metrics — tracks quote volume, value, win/loss rates, and discount levels to optimize pricing strategy and sales cycle efficiency."
  source: "`vibe_semiconductors_v1`.`sales`.`quote`"
  dimensions:
    - name: "quote_status"
      expr: quote_status
      comment: "Current status of the quote (Draft, Submitted, Won, Lost, Expired) — primary dimension for quote funnel analysis."
    - name: "win_loss_status"
      expr: win_loss_status
      comment: "Win/loss outcome of the quote — used to calculate win rates and analyze competitive positioning."
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region of the quote — used for regional pricing and win rate benchmarking."
    - name: "currency"
      expr: currency
      comment: "Currency of the quote — required for multi-currency revenue analysis."
    - name: "delivery_terms"
      expr: delivery_terms
      comment: "Delivery terms (FOB, CIF, DDP) — used to analyze logistics cost impact on quote competitiveness."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms offered in the quote — used to assess working capital impact of quote terms."
    - name: "quote_date_month"
      expr: DATE_TRUNC('month', quote_date)
      comment: "Month the quote was issued — primary time dimension for quote volume and conversion trend analysis."
    - name: "valid_until_quarter"
      expr: DATE_TRUNC('quarter', valid_until)
      comment: "Quarter in which the quote expires — used for quote pipeline aging and expiry risk management."
    - name: "is_converted"
      expr: is_converted
      comment: "Indicates whether the quote was converted to an order — used to calculate quote-to-order conversion rate."
    - name: "volume_tier"
      expr: volume_tier
      comment: "Volume pricing tier applied to the quote — used to analyze pricing tier effectiveness and volume discount strategy."
  measures:
    - name: "total_quote_gross_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross value of all quotes — measures the size of the quoted pipeline and potential revenue at risk."
    - name: "total_quote_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net value of all quotes after discounts — used for realistic revenue pipeline assessment."
    - name: "total_quote_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted across all quotes — used to monitor pricing discipline and discount approval compliance."
    - name: "total_quote_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all quotes — used for tax liability estimation and financial planning."
    - name: "avg_quote_net_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net quote value — used to benchmark deal size and identify pricing optimization opportunities."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across all quotes — primary ASP (Average Selling Price) KPI for pricing strategy review."
    - name: "quote_count"
      expr: COUNT(1)
      comment: "Total number of quotes issued — baseline volume metric for sales activity and quoting efficiency measurement."
    - name: "converted_quote_count"
      expr: COUNT(CASE WHEN is_converted = TRUE THEN 1 END)
      comment: "Number of quotes converted to orders — numerator for quote-to-order conversion rate calculation."
    - name: "quote_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_converted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of quotes converted to orders — critical sales effectiveness KPI used in QBRs to evaluate quoting process efficiency."
    - name: "avg_discount_rate_pct"
      expr: ROUND(100.0 * AVG(CAST(discount_amount AS DOUBLE) / NULLIF(total_amount, 0)), 2)
      comment: "Average discount rate as a percentage of total quote value — used to enforce pricing guardrails and identify discount outliers."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_design_win`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design win revenue and competitive displacement metrics — tracks design win pipeline value, ramp rates, and competitor displacement to steer product strategy and market share decisions."
  source: "`vibe_semiconductors_v1`.`sales`.`sales_design_win`"
  dimensions:
    - name: "sales_design_win_status"
      expr: sales_design_win_status
      comment: "Current status of the design win (Active, Ramping, Mature, Lost) — primary dimension for design win lifecycle analysis."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment of the design win (Automotive, Industrial, Consumer, Data Center) — used for market share and revenue mix analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the design win — used for regional market penetration analysis."
    - name: "target_application"
      expr: target_application
      comment: "Target application for the design win (ADAS, 5G, IoT, etc.) — used to analyze application-level revenue concentration."
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model for the design win — used to evaluate pricing strategy effectiveness across design wins."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the design win revenue — required for multi-currency revenue consolidation."
    - name: "win_timestamp_month"
      expr: DATE_TRUNC('month', win_timestamp)
      comment: "Month the design win was recorded — primary time dimension for design win trend and momentum analysis."
    - name: "revenue_ramp_start_quarter"
      expr: DATE_TRUNC('quarter', revenue_ramp_start_date)
      comment: "Quarter when revenue ramp begins — used for revenue ramp planning and supply readiness alignment."
    - name: "export_controlled"
      expr: export_controlled
      comment: "Indicates whether the design win involves export-controlled technology — used for compliance risk monitoring."
    - name: "is_key_account"
      expr: is_key_account
      comment: "Indicates whether the design win is with a key/strategic account — used to prioritize support and resource allocation."
  measures:
    - name: "total_estimated_annual_revenue_gross"
      expr: SUM(CAST(estimated_annual_revenue_gross AS DOUBLE))
      comment: "Total estimated annual gross revenue from design wins — primary strategic KPI for market share and revenue pipeline assessment."
    - name: "total_estimated_annual_revenue_net"
      expr: SUM(CAST(estimated_annual_revenue_net AS DOUBLE))
      comment: "Total estimated annual net revenue from design wins — used for realistic revenue planning and quota setting."
    - name: "total_estimated_annual_unit_volume"
      expr: SUM(CAST(estimated_annual_unit_volume AS DOUBLE))
      comment: "Total estimated annual unit volume from design wins — used for capacity planning and wafer start authorization."
    - name: "total_revenue_adjustment"
      expr: SUM(CAST(revenue_adjustment AS DOUBLE))
      comment: "Total revenue adjustments applied to design wins — used to track pricing corrections and revenue restatements."
    - name: "avg_estimated_annual_revenue_net"
      expr: AVG(CAST(estimated_annual_revenue_net AS DOUBLE))
      comment: "Average annual net revenue per design win — used to benchmark design win quality and prioritize account investment."
    - name: "avg_forecast_accuracy"
      expr: AVG(CAST(forecast_accuracy AS DOUBLE))
      comment: "Average forecast accuracy across design wins — used to assess reliability of design win revenue projections."
    - name: "avg_competitor_displacement_score"
      expr: AVG(CAST(competitor_displacement_score AS DOUBLE))
      comment: "Average competitor displacement score — measures competitive win strength; used to evaluate market share capture effectiveness."
    - name: "avg_monthly_ramp_rate"
      expr: AVG(CAST(forecasted_ramp_rate_per_month AS DOUBLE))
      comment: "Average monthly revenue ramp rate across design wins — used for supply chain ramp planning and revenue acceleration tracking."
    - name: "design_win_count"
      expr: COUNT(1)
      comment: "Total number of design wins — baseline volume KPI for market penetration and sales effectiveness measurement."
    - name: "distinct_account_count"
      expr: COUNT(DISTINCT primary_sales_account_id)
      comment: "Number of distinct customer accounts with design wins — measures breadth of design win penetration across the customer base."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_nre_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NRE (Non-Recurring Engineering) agreement financial metrics — tracks NRE contract value, milestone completion, and revenue recognition to manage engineering cost recovery and R&D investment decisions."
  source: "`vibe_semiconductors_v1`.`sales`.`sales_nre_agreement`"
  dimensions:
    - name: "sales_nre_agreement_status"
      expr: sales_nre_agreement_status
      comment: "Current status of the NRE agreement (Active, Completed, Terminated, On Hold) — primary dimension for NRE portfolio management."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of NRE agreement (Tapeout, Process Development, IP Licensing, Mask Set) — used to analyze NRE revenue by engineering service type."
    - name: "deliverable_type"
      expr: deliverable_type
      comment: "Type of deliverable committed in the NRE agreement — used to track engineering output and milestone completion."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the NRE agreement — used to filter for approved agreements in revenue recognition."
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region of the NRE agreement — used for regional NRE revenue analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the NRE agreement — required for multi-currency NRE revenue consolidation."
    - name: "effective_start_quarter"
      expr: DATE_TRUNC('quarter', effective_start_date)
      comment: "Quarter the NRE agreement becomes effective — used for NRE revenue timing and backlog analysis."
    - name: "effective_end_quarter"
      expr: DATE_TRUNC('quarter', effective_end_date)
      comment: "Quarter the NRE agreement ends — used for NRE revenue completion and renewal planning."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Indicates whether the NRE agreement includes exclusivity — used to assess strategic value and pricing premium justification."
    - name: "change_order_flag"
      expr: change_order_flag
      comment: "Indicates whether a change order has been issued — used to track scope changes and associated revenue adjustments."
  measures:
    - name: "total_nre_contract_value"
      expr: SUM(CAST(nre_total_amount AS DOUBLE))
      comment: "Total contracted NRE value across all agreements — primary KPI for engineering cost recovery and R&D investment tracking."
    - name: "total_forecasted_nre_revenue"
      expr: SUM(CAST(forecasted_revenue AS DOUBLE))
      comment: "Total forecasted NRE revenue — used for financial planning and revenue recognition scheduling."
    - name: "total_actual_nre_revenue_recognized"
      expr: SUM(CAST(actual_revenue_recognized AS DOUBLE))
      comment: "Total NRE revenue actually recognized — used for financial close and performance-to-plan analysis."
    - name: "total_milestone_amount"
      expr: SUM(CAST(milestone_amount AS DOUBLE))
      comment: "Total value of NRE milestones — used to track milestone-based billing and cash flow from engineering agreements."
    - name: "avg_nre_contract_value"
      expr: AVG(CAST(nre_total_amount AS DOUBLE))
      comment: "Average NRE contract value — used to benchmark NRE deal size and evaluate pricing adequacy for engineering services."
    - name: "nre_revenue_recognition_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_revenue_recognized AS DOUBLE)) / NULLIF(SUM(CAST(nre_total_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of contracted NRE value that has been recognized as revenue — used to track NRE execution progress and revenue realization risk."
    - name: "nre_agreement_count"
      expr: COUNT(1)
      comment: "Total number of NRE agreements — baseline volume metric for engineering services portfolio management."
    - name: "distinct_account_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customer accounts with NRE agreements — measures breadth of engineering partnership and customer co-investment."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_lead`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead generation and qualification metrics — tracks lead volume, estimated revenue pipeline, conversion rates, and market segment coverage to optimize demand generation and sales pipeline creation."
  source: "`vibe_semiconductors_v1`.`sales`.`lead`"
  dimensions:
    - name: "lead_status"
      expr: lead_status
      comment: "Current status of the lead (New, Working, Qualified, Converted, Disqualified) — primary dimension for lead funnel analysis."
    - name: "lead_type"
      expr: lead_type
      comment: "Type of lead (Inbound, Outbound, Referral, Event) — used to evaluate lead source effectiveness."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment of the lead (Automotive, Consumer, Industrial, Data Center) — used for demand generation targeting analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the lead — used for regional pipeline creation analysis."
    - name: "source"
      expr: source
      comment: "Lead source (Web, Trade Show, Partner, Cold Call) — used to measure marketing channel ROI and lead quality by source."
    - name: "target_application"
      expr: target_application
      comment: "Target application of the lead (ADAS, 5G, IoT, etc.) — used to align demand generation with product roadmap priorities."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node of interest for the lead — used to align lead pipeline with fab capacity and process node availability."
    - name: "creation_month"
      expr: DATE_TRUNC('month', creation_timestamp)
      comment: "Month the lead was created — primary time dimension for lead generation trend analysis."
    - name: "conversion_date_month"
      expr: DATE_TRUNC('month', conversion_date)
      comment: "Month the lead was converted — used for lead-to-opportunity conversion cycle time analysis."
    - name: "is_nre"
      expr: is_nre
      comment: "Indicates whether the lead involves NRE engagement — used to segment NRE pipeline from standard product leads."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the estimated lead revenue — required for multi-currency pipeline analysis."
  measures:
    - name: "total_estimated_lead_revenue"
      expr: SUM(CAST(estimated_revenue AS DOUBLE))
      comment: "Total estimated revenue from all leads — measures the top-of-funnel revenue pipeline and demand generation effectiveness."
    - name: "total_estimated_lead_quantity"
      expr: SUM(CAST(estimated_quantity AS DOUBLE))
      comment: "Total estimated unit volume from leads — used for early-stage capacity planning and wafer start demand signaling."
    - name: "avg_estimated_lead_revenue"
      expr: AVG(CAST(estimated_revenue AS DOUBLE))
      comment: "Average estimated revenue per lead — used to benchmark lead quality and prioritize follow-up investment."
    - name: "lead_count"
      expr: COUNT(1)
      comment: "Total number of leads — baseline volume metric for demand generation activity and pipeline creation measurement."
    - name: "converted_lead_count"
      expr: COUNT(CASE WHEN lead_status = 'Converted' THEN 1 END)
      comment: "Number of leads converted to opportunities — numerator for lead conversion rate calculation."
    - name: "lead_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN lead_status = 'Converted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of leads converted to opportunities — critical demand generation effectiveness KPI used in marketing and sales alignment reviews."
    - name: "distinct_account_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct accounts with leads — measures breadth of market coverage and new account prospecting activity."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_partner_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel partner inventory health metrics — tracks stock levels, sell-through rates, weeks of supply, and excess inventory to optimize channel inventory management and prevent stock-outs or over-stocking."
  source: "`vibe_semiconductors_v1`.`sales`.`partner_inventory`"
  dimensions:
    - name: "warehouse_location"
      expr: warehouse_location
      comment: "Warehouse location of the partner inventory — used for geographic inventory distribution analysis."
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period of the inventory snapshot — used for period-over-period inventory trend analysis."
    - name: "consignment_flag"
      expr: consignment_flag
      comment: "Indicates whether inventory is on consignment — used to separate consignment from owned inventory in financial reporting."
    - name: "excess_flag"
      expr: excess_flag
      comment: "Indicates whether inventory is classified as excess — used to identify excess stock requiring price protection or return actions."
    - name: "snapshot_date_month"
      expr: DATE_TRUNC('month', snapshot_date)
      comment: "Month of the inventory snapshot — primary time dimension for inventory trend analysis."
    - name: "report_date_quarter"
      expr: DATE_TRUNC('quarter', report_date)
      comment: "Quarter of the inventory report — used for quarterly channel inventory review and hub management."
  measures:
    - name: "total_stock_on_hand"
      expr: SUM(CAST(stock_on_hand AS DOUBLE))
      comment: "Total units on hand at channel partners — primary inventory level KPI for channel stock management and supply alignment."
    - name: "total_inventory_value_usd"
      expr: SUM(CAST(inventory_value_usd AS DOUBLE))
      comment: "Total dollar value of channel partner inventory — used for channel inventory exposure and price protection liability assessment."
    - name: "total_units_sold_through"
      expr: SUM(CAST(units_sold_through AS DOUBLE))
      comment: "Total units sold through the channel — primary sell-through volume KPI for channel performance measurement."
    - name: "total_aging_over_90_days_qty"
      expr: SUM(CAST(aging_over_90_days_qty AS DOUBLE))
      comment: "Total units aged over 90 days at channel partners — used to identify slow-moving inventory requiring markdown or return action."
    - name: "avg_weeks_of_supply"
      expr: AVG(CAST(weeks_of_supply AS DOUBLE))
      comment: "Average weeks of supply at channel partners — critical inventory health KPI; values outside 4-12 weeks trigger replenishment or excess actions."
    - name: "avg_sell_through_rate"
      expr: AVG(CAST(sell_through_rate AS DOUBLE))
      comment: "Average sell-through rate at channel partners — measures channel velocity and product demand health."
    - name: "avg_inventory_turn_rate"
      expr: AVG(CAST(inventory_turn_rate AS DOUBLE))
      comment: "Average inventory turn rate at channel partners — used to evaluate channel efficiency and working capital utilization."
    - name: "avg_average_selling_price_usd"
      expr: AVG(CAST(average_selling_price_usd AS DOUBLE))
      comment: "Average selling price at channel partners — used to monitor channel ASP trends and detect price erosion."
    - name: "total_quantity_in_transit"
      expr: SUM(CAST(quantity_in_transit AS DOUBLE))
      comment: "Total units in transit to channel partners — used for in-transit inventory visibility and delivery planning."
    - name: "partner_inventory_record_count"
      expr: COUNT(1)
      comment: "Total number of partner inventory records — baseline metric for channel inventory reporting coverage."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_rebate_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel rebate program financial metrics — tracks rebate accruals, payout rates, and program effectiveness to optimize channel incentive spend and partner performance management."
  source: "`vibe_semiconductors_v1`.`sales`.`rebate_program`"
  dimensions:
    - name: "rebate_program_status"
      expr: rebate_program_status
      comment: "Current status of the rebate program (Active, Expired, Pending Approval) — primary dimension for active program management."
    - name: "program_type"
      expr: program_type
      comment: "Type of rebate program (Volume, Growth, Loyalty, Market Development Fund) — used to analyze incentive spend by program category."
    - name: "partner_type"
      expr: partner_type
      comment: "Type of channel partner (Distributor, VAR, Rep Firm) — used to analyze rebate spend by partner tier."
    - name: "region"
      expr: region
      comment: "Geographic region of the rebate program — used for regional channel incentive spend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rebate program — required for multi-currency rebate liability consolidation."
    - name: "effective_from_quarter"
      expr: DATE_TRUNC('quarter', effective_from)
      comment: "Quarter the rebate program becomes effective — used for rebate program lifecycle and accrual timing analysis."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status of the rebate (Pending, Settled, Disputed) — used to track rebate payment obligations and cash flow."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate the rebate (Flat Rate, Tiered, Incremental) — used to analyze program structure effectiveness."
  measures:
    - name: "total_max_payout_amount"
      expr: SUM(CAST(max_payout_amount AS DOUBLE))
      comment: "Total maximum rebate payout liability across all programs — used for financial accrual and cash flow planning."
    - name: "avg_rebate_pct"
      expr: AVG(CAST(rebate_pct AS DOUBLE))
      comment: "Average rebate percentage across all programs — used to benchmark channel incentive generosity and optimize rebate spend efficiency."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate embedded in rebate programs — used to assess total channel discount exposure."
    - name: "avg_tier1_rate_percent"
      expr: AVG(CAST(tier1_rate_percent AS DOUBLE))
      comment: "Average Tier 1 rebate rate — used to evaluate entry-level incentive competitiveness in channel programs."
    - name: "avg_tier2_rate_percent"
      expr: AVG(CAST(tier2_rate_percent AS DOUBLE))
      comment: "Average Tier 2 rebate rate — used to evaluate stretch incentive effectiveness for high-volume partners."
    - name: "total_tier1_threshold_amount"
      expr: SUM(CAST(tier1_threshold_amount AS DOUBLE))
      comment: "Total Tier 1 threshold commitment across all programs — used to assess minimum revenue commitment required to trigger rebates."
    - name: "rebate_program_count"
      expr: COUNT(1)
      comment: "Total number of rebate programs — baseline metric for channel incentive program portfolio management."
    - name: "distinct_partner_count"
      expr: COUNT(DISTINCT channel_partner_id)
      comment: "Number of distinct channel partners enrolled in rebate programs — measures breadth of channel incentive coverage."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing campaign spend and ROI metrics — tracks campaign budget utilization, estimated ROI, and pipeline contribution to optimize marketing investment allocation and demand generation effectiveness."
  source: "`vibe_semiconductors_v1`.`sales`.`campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign (Planning, Active, Completed, Cancelled) — primary dimension for campaign portfolio management."
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (Trade Show, Digital, Email, Webinar, Field Event) — used to analyze marketing channel effectiveness."
    - name: "channel"
      expr: channel
      comment: "Marketing channel of the campaign — used to evaluate channel-level marketing ROI."
    - name: "region"
      expr: region
      comment: "Geographic region of the campaign — used for regional marketing spend and pipeline contribution analysis."
    - name: "target_market"
      expr: target_market
      comment: "Target market segment of the campaign — used to align marketing investment with strategic market priorities."
    - name: "target_product_family"
      expr: target_product_family
      comment: "Product family targeted by the campaign — used to measure product-level marketing investment and pipeline contribution."
    - name: "objective"
      expr: objective
      comment: "Campaign objective (Brand Awareness, Lead Generation, Pipeline Acceleration) — used to categorize campaigns by strategic intent."
    - name: "start_date_quarter"
      expr: DATE_TRUNC('quarter', start_date)
      comment: "Quarter the campaign starts — primary time dimension for marketing spend and pipeline contribution trend analysis."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the campaign meets compliance requirements — used to flag campaigns requiring regulatory review."
  measures:
    - name: "total_campaign_budget"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total marketing budget allocated across all campaigns — primary marketing spend KPI for budget management and allocation decisions."
    - name: "total_actual_campaign_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual marketing spend across all campaigns — used to track budget utilization and identify over/under-spend."
    - name: "total_estimated_roi"
      expr: SUM(CAST(roi_estimate AS DOUBLE))
      comment: "Total estimated ROI across all campaigns — used to evaluate marketing investment effectiveness and prioritize future spend."
    - name: "avg_estimated_roi"
      expr: AVG(CAST(roi_estimate AS DOUBLE))
      comment: "Average estimated ROI per campaign — used to benchmark campaign effectiveness and optimize marketing mix."
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_spend AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of campaign budget actually spent — used to assess marketing execution efficiency and identify budget waste or under-investment."
    - name: "campaign_count"
      expr: COUNT(1)
      comment: "Total number of campaigns — baseline volume metric for marketing activity level and program portfolio management."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_customer_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer contract value and compliance metrics — tracks contracted revenue, credit exposure, discount rates, and contract lifecycle to manage revenue backlog and customer commitment risk."
  source: "`vibe_semiconductors_v1`.`sales`.`customer_contract`"
  dimensions:
    - name: "customer_contract_status"
      expr: customer_contract_status
      comment: "Current status of the customer contract (Active, Expired, Terminated, Pending) — primary dimension for contract portfolio management."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (Long-Term Supply, NRE, Frame Agreement, Spot) — used to analyze revenue by contract structure."
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region of the contract — used for regional contracted revenue analysis."
    - name: "product_family"
      expr: product_family
      comment: "Product family covered by the contract — used for product-line revenue commitment analysis."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node covered by the contract — used to align contracted revenue with fab capacity planning."
    - name: "currency"
      expr: currency
      comment: "Currency of the contract — required for multi-currency contracted revenue consolidation."
    - name: "effective_from_quarter"
      expr: DATE_TRUNC('quarter', effective_from)
      comment: "Quarter the contract becomes effective — used for contract backlog and revenue recognition timing analysis."
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Indicates whether the contract auto-renews — used to forecast recurring revenue and manage renewal risk."
    - name: "ltb_provision"
      expr: ltb_provision
      comment: "Indicates whether the contract includes a Last Time Buy provision — used for EOL planning and inventory commitment management."
    - name: "invoicing_frequency"
      expr: invoicing_frequency
      comment: "Frequency of invoicing under the contract (Monthly, Quarterly, Milestone) — used for cash flow planning."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value_total AS DOUBLE))
      comment: "Total contracted revenue value across all customer contracts — primary backlog KPI for revenue visibility and financial planning."
    - name: "total_annual_contract_value"
      expr: SUM(CAST(annual_value AS DOUBLE))
      comment: "Total annual contract value (ACV) — used for recurring revenue tracking and year-over-year growth analysis."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended to customers under contracts — used for credit risk exposure management."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate across customer contracts — used to monitor pricing discipline and identify discount outliers requiring approval."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average contracted unit price — used to track ASP trends and evaluate pricing strategy effectiveness."
    - name: "total_volume_commitment"
      expr: SUM(CAST(volume_commitment AS DOUBLE))
      comment: "Total volume commitment across all contracts — used for supply planning and wafer start authorization."
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of customer contracts — baseline metric for contract portfolio size and renewal pipeline management."
    - name: "distinct_account_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customer accounts with active contracts — measures contracted customer base breadth."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_territory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales territory coverage and target metrics — tracks revenue targets, territory structure, and coverage to optimize sales force deployment and quota allocation decisions."
  source: "`vibe_semiconductors_v1`.`sales`.`territory`"
  dimensions:
    - name: "territory_status"
      expr: territory_status
      comment: "Current status of the territory (Active, Inactive, Restructuring) — used to filter for active territories in coverage analysis."
    - name: "territory_type"
      expr: territory_type
      comment: "Type of territory (Named Account, Geographic, Vertical, Overlay) — used to analyze sales coverage model effectiveness."
    - name: "region_code"
      expr: region_code
      comment: "Region code of the territory — used for regional sales force deployment and quota analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country code of the territory — used for country-level sales coverage analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the territory assignment — used for year-over-year territory performance comparison."
    - name: "channel_tier"
      expr: channel_tier
      comment: "Channel tier of the territory (Direct, Tier 1 Distribution, Tier 2) — used to analyze coverage by channel model."
    - name: "is_overlay"
      expr: is_overlay
      comment: "Indicates whether the territory is an overlay (specialist) territory — used to distinguish overlay from primary coverage territories."
    - name: "effective_start_year"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the territory assignment becomes effective — used for territory restructuring and coverage change analysis."
  measures:
    - name: "total_revenue_target"
      expr: SUM(CAST(revenue_target_amount AS DOUBLE))
      comment: "Total revenue target across all territories — primary quota management KPI used in sales planning and performance evaluation."
    - name: "avg_revenue_target"
      expr: AVG(CAST(revenue_target_amount AS DOUBLE))
      comment: "Average revenue target per territory — used to benchmark quota allocation equity and identify under/over-loaded territories."
    - name: "territory_count"
      expr: COUNT(1)
      comment: "Total number of territories — baseline metric for sales coverage model assessment and headcount planning."
    - name: "multi_rep_territory_count"
      expr: COUNT(CASE WHEN multi_rep_coverage = TRUE THEN 1 END)
      comment: "Number of territories with multi-rep coverage — used to identify complex accounts requiring team selling and assess coverage model efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_design_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design registration pipeline and price protection metrics — tracks registration volume, protected pricing, and channel conflict to manage design win protection and channel partner compliance."
  source: "`vibe_semiconductors_v1`.`sales`.`sales_design_registration`"
  dimensions:
    - name: "sales_design_registration_status"
      expr: sales_design_registration_status
      comment: "Current status of the design registration (Pending, Approved, Expired, Rejected) — primary dimension for registration pipeline management."
    - name: "registration_type"
      expr: registration_type
      comment: "Type of design registration (New Design, Renewal, Transfer) — used to analyze registration activity by type."
    - name: "region"
      expr: region
      comment: "Geographic region of the design registration — used for regional channel design win protection analysis."
    - name: "device_family"
      expr: device_family
      comment: "Device family covered by the registration — used to analyze design win protection by product line."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node of the registered design — used to align design win pipeline with process node capacity."
    - name: "end_application"
      expr: end_application
      comment: "End application of the registered design — used for application-level design win pipeline analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the protected price — required for multi-currency price protection analysis."
    - name: "submission_date_quarter"
      expr: DATE_TRUNC('quarter', submission_date)
      comment: "Quarter the registration was submitted — primary time dimension for registration pipeline trend analysis."
    - name: "is_price_protected"
      expr: is_price_protected
      comment: "Indicates whether the registration includes price protection — used to quantify price protection liability."
    - name: "is_channel_conflict"
      expr: is_channel_conflict
      comment: "Indicates whether a channel conflict exists for this registration — used to identify and resolve channel coverage disputes."
  measures:
    - name: "total_protected_price_value"
      expr: SUM(CAST(protected_price_usd AS DOUBLE))
      comment: "Total protected price value across all design registrations — used to quantify price protection liability and channel discount exposure."
    - name: "avg_protected_price_usd"
      expr: AVG(CAST(protected_price_usd AS DOUBLE))
      comment: "Average protected price per design registration — used to benchmark price protection levels and detect pricing anomalies."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage granted in design registrations — used to monitor channel discount discipline and pricing strategy adherence."
    - name: "registration_count"
      expr: COUNT(1)
      comment: "Total number of design registrations — baseline volume metric for channel design win protection activity."
    - name: "approved_registration_count"
      expr: COUNT(CASE WHEN sales_design_registration_status = 'Approved' THEN 1 END)
      comment: "Number of approved design registrations — used to measure channel design win protection coverage and approval rate."
    - name: "channel_conflict_count"
      expr: COUNT(CASE WHEN is_channel_conflict = TRUE THEN 1 END)
      comment: "Number of registrations with channel conflicts — used to identify and resolve channel coverage disputes that risk customer satisfaction."
    - name: "registration_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sales_design_registration_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of design registrations approved — used to evaluate channel registration process efficiency and partner compliance."
$$;