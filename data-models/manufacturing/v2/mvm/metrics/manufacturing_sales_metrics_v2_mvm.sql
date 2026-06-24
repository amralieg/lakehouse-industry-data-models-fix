-- Metric views for domain: sales | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 10:21:17

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the sales opportunity pipeline — win rates, pipeline value, discount behaviour, and forecast accuracy. Used by Sales VPs and CROs to steer pipeline health and forecast calls."
  source: "`vibe_manufacturing_v1`.`sales`.`opportunity`"
  dimensions:
    - name: "stage"
      expr: stage
      comment: "Current pipeline stage of the opportunity (e.g. Prospecting, Proposal, Negotiation, Closed Won)."
    - name: "forecast_category"
      expr: forecast_category
      comment: "Forecast bucket assigned to the opportunity (e.g. Commit, Best Case, Pipeline, Omitted)."
    - name: "lead_source"
      expr: lead_source
      comment: "Channel or campaign that originated the opportunity (e.g. Web, Partner, Trade Show)."
    - name: "region"
      expr: region
      comment: "Geographic sales region associated with the opportunity."
    - name: "industry_segment"
      expr: industry_segment
      comment: "Industry vertical or market segment targeted by the opportunity."
    - name: "product_line"
      expr: product_line
      comment: "Product line or portfolio category associated with the opportunity."
    - name: "opportunity_type"
      expr: opportunity_type
      comment: "Classification of the opportunity (e.g. New Business, Renewal, Upsell, Cross-sell)."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year in which the opportunity is expected to close."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter in which the opportunity is expected to close."
    - name: "close_month"
      expr: DATE_TRUNC('MONTH', close_date)
      comment: "Month-level bucket of the expected close date, used for pipeline trend analysis."
    - name: "is_won"
      expr: is_won
      comment: "Boolean flag indicating whether the opportunity was won."
    - name: "is_closed"
      expr: is_closed
      comment: "Boolean flag indicating whether the opportunity is in a closed state (won or lost)."
    - name: "loss_reason"
      expr: loss_reason
      comment: "Reason recorded when an opportunity was lost, used for competitive and process analysis."
    - name: "competitor_name"
      expr: competitor_name
      comment: "Primary competitor identified on the opportunity, used for win/loss competitive analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country associated with the opportunity for geographic segmentation."
  measures:
    - name: "total_pipeline_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total value of all opportunities in the pipeline. Core metric for pipeline coverage and capacity planning."
    - name: "total_expected_revenue"
      expr: SUM(CAST(expected_revenue AS DOUBLE))
      comment: "Sum of probability-weighted expected revenue across all opportunities. Used for probabilistic forecast roll-ups."
    - name: "opportunity_count"
      expr: COUNT(DISTINCT opportunity_id)
      comment: "Number of distinct opportunities. Used to assess pipeline volume and rep productivity."
    - name: "won_opportunity_count"
      expr: COUNT(DISTINCT CASE WHEN is_won = TRUE THEN opportunity_id END)
      comment: "Number of opportunities marked as won. Numerator for win rate calculation."
    - name: "closed_opportunity_count"
      expr: COUNT(DISTINCT CASE WHEN is_closed = TRUE THEN opportunity_id END)
      comment: "Number of opportunities in a closed state (won or lost). Denominator for win rate calculation."
    - name: "win_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_won = TRUE THEN opportunity_id END) / NULLIF(COUNT(DISTINCT CASE WHEN is_closed = TRUE THEN opportunity_id END), 0), 2)
      comment: "Percentage of closed opportunities that were won. Primary sales effectiveness KPI tracked in every QBR."
    - name: "avg_deal_size"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average opportunity amount. Tracks deal size trends and informs capacity and quota planning."
    - name: "avg_probability_pct"
      expr: AVG(CAST(probability_percent AS DOUBLE))
      comment: "Average win probability across open opportunities. Indicates overall pipeline quality and confidence."
    - name: "avg_discount_pct"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage applied to opportunities. Monitors pricing discipline and margin leakage risk."
    - name: "total_won_amount"
      expr: SUM(CASE WHEN is_won = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total closed-won revenue. Core bookings metric used to measure attainment against quota."
    - name: "weighted_pipeline_amount"
      expr: SUM(CAST(amount AS DOUBLE) * CAST(probability_percent AS DOUBLE) / 100.0)
      comment: "Probability-weighted pipeline value (amount × probability). Used for statistical forecast models and pipeline coverage ratios."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_order_intake`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order intake (bookings) KPIs tracking order value, delivery commitments, credit health, and fulfilment readiness. Used by Sales Operations, Finance, and Supply Chain leadership."
  source: "`vibe_manufacturing_v1`.`sales`.`order_intake`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order (e.g. Standard, Rush, Blanket, Frame Agreement)."
    - name: "order_priority"
      expr: order_priority
      comment: "Priority level assigned to the order, used for fulfilment sequencing."
    - name: "product_line"
      expr: product_line
      comment: "Product line associated with the order intake record."
    - name: "industry_segment"
      expr: industry_segment
      comment: "Industry segment of the customer placing the order."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the order."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year in which the order was booked."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter in which the order was booked."
    - name: "intake_month"
      expr: DATE_TRUNC('MONTH', intake_date)
      comment: "Month-level bucket of the order intake date for trend analysis."
    - name: "handoff_status"
      expr: handoff_status
      comment: "Status of the order handoff to manufacturing or fulfilment (e.g. Pending, Completed, Blocked)."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method selected for the order (e.g. Air, Sea, Ground)."
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms governing delivery responsibility for the order."
    - name: "booking_recognized_flag"
      expr: booking_recognized_flag
      comment: "Boolean flag indicating whether the booking has been formally recognised for revenue/backlog purposes."
    - name: "committed_delivery_month"
      expr: DATE_TRUNC('MONTH', committed_delivery_date)
      comment: "Month-level bucket of the committed delivery date, used for delivery schedule analysis."
  measures:
    - name: "total_order_value"
      expr: SUM(CAST(order_value AS DOUBLE))
      comment: "Total order intake value in transaction currency. Primary bookings KPI for revenue planning and backlog management."
    - name: "total_order_value_base_currency"
      expr: SUM(CAST(order_value_base_currency AS DOUBLE))
      comment: "Total order intake value normalised to base/reporting currency. Used for consolidated financial reporting."
    - name: "order_intake_count"
      expr: COUNT(DISTINCT order_intake_id)
      comment: "Number of distinct order intake records. Tracks order volume for capacity and demand planning."
    - name: "avg_order_value"
      expr: AVG(CAST(order_value AS DOUBLE))
      comment: "Average order value per intake record. Monitors deal size trends and mix shift."
    - name: "recognized_booking_count"
      expr: COUNT(DISTINCT CASE WHEN booking_recognized_flag = TRUE THEN order_intake_id END)
      comment: "Number of orders where the booking has been formally recognised. Used for backlog and revenue recognition tracking."
    - name: "booking_recognition_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN booking_recognized_flag = TRUE THEN order_intake_id END) / NULLIF(COUNT(DISTINCT order_intake_id), 0), 2)
      comment: "Percentage of orders that have been formally recognised as bookings. Indicates order quality and process compliance."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied to orders. Used to monitor currency exposure and translation risk."
    - name: "avg_payment_terms_days"
      expr: AVG(CAST(payment_terms_days AS DOUBLE))
      comment: "Average payment terms in days across orders. Tracks working capital and cash conversion cycle exposure."
    - name: "total_unrecognized_order_value"
      expr: SUM(CASE WHEN booking_recognized_flag = FALSE THEN CAST(order_value_base_currency AS DOUBLE) ELSE 0 END)
      comment: "Total order value (base currency) for orders not yet formally recognised as bookings. Represents pending backlog exposure."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quoting process KPIs covering quote conversion, discount levels, win probability, and cycle time. Used by Sales leadership to optimise the quote-to-order process and pricing strategy."
  source: "`vibe_manufacturing_v1`.`sales`.`quote`"
  dimensions:
    - name: "quote_status"
      expr: quote_status
      comment: "Current status of the quote (e.g. Draft, Presented, Accepted, Rejected, Expired)."
    - name: "quote_type"
      expr: quote_type
      comment: "Type of quote (e.g. Standard, Custom, Framework, Spot)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the quote (e.g. Pending, Approved, Rejected)."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the quote."
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterms governing delivery responsibility on the quote."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method specified on the quote."
    - name: "non_standard_discount_flag"
      expr: non_standard_discount_flag
      comment: "Boolean flag indicating whether a non-standard (exception) discount was applied to the quote."
    - name: "quote_month"
      expr: DATE_TRUNC('MONTH', quote_date)
      comment: "Month-level bucket of the quote creation date for trend analysis."
    - name: "competitor_name"
      expr: competitor_name
      comment: "Competitor identified on the quote, used for competitive win/loss analysis."
  measures:
    - name: "total_quote_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total value of all quotes issued. Measures quoting activity volume and pipeline coverage."
    - name: "total_quote_subtotal"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of pre-tax, pre-shipping subtotals across quotes. Used for net revenue estimation."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value granted across all quotes. Monitors pricing discipline and margin leakage."
    - name: "quote_count"
      expr: COUNT(DISTINCT quote_id)
      comment: "Number of distinct quotes issued. Tracks quoting activity and sales team throughput."
    - name: "accepted_quote_count"
      expr: COUNT(DISTINCT CASE WHEN quote_status = 'Accepted' THEN quote_id END)
      comment: "Number of quotes that were accepted by the customer. Numerator for quote conversion rate."
    - name: "quote_conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN quote_status = 'Accepted' THEN quote_id END) / NULLIF(COUNT(DISTINCT quote_id), 0), 2)
      comment: "Percentage of quotes that were accepted. Key sales effectiveness KPI for the quote-to-order funnel."
    - name: "avg_discount_pct"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied across quotes. Tracks pricing discipline and identifies discount creep."
    - name: "avg_win_probability_pct"
      expr: AVG(CAST(win_probability_percentage AS DOUBLE))
      comment: "Average win probability assigned to quotes. Indicates overall quote quality and pipeline confidence."
    - name: "non_standard_discount_quote_count"
      expr: COUNT(DISTINCT CASE WHEN non_standard_discount_flag = TRUE THEN quote_id END)
      comment: "Number of quotes with non-standard (exception) discounts. Used to monitor pricing exception frequency and approval compliance."
    - name: "avg_quote_total_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average total quote value. Tracks deal size trends and informs quota and capacity planning."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all quotes. Used for tax liability estimation and compliance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_quote_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level quoting KPIs covering margin, discount, and product mix. Used by Product Management, Pricing, and Sales Operations to optimise product-level pricing and margin performance."
  source: "`vibe_manufacturing_v1`.`sales`.`quote_line`"
  dimensions:
    - name: "product_family"
      expr: product_family
      comment: "Product family of the quoted line item, used for product mix and margin analysis."
    - name: "line_status"
      expr: line_status
      comment: "Status of the quote line (e.g. Active, Cancelled, Substituted)."
    - name: "line_type"
      expr: line_type
      comment: "Type of quote line (e.g. Product, Service, Spare Part, Option)."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the quote line."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the quoted quantity."
    - name: "approval_level"
      expr: approval_level
      comment: "Approval tier required for this quote line (e.g. Standard, Manager, Director, VP)."
    - name: "is_optional"
      expr: is_optional
      comment: "Boolean flag indicating whether the line item is optional (not committed). Used to separate firm vs. optional scope."
    - name: "is_bundle_parent"
      expr: is_bundle_parent
      comment: "Boolean flag indicating whether this line is the parent of a product bundle."
    - name: "committed_delivery_month"
      expr: DATE_TRUNC('MONTH', committed_delivery_date)
      comment: "Month-level bucket of the committed delivery date for the line item."
  measures:
    - name: "total_line_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total value of all quote lines. Measures quoted revenue at the product/line level."
    - name: "total_margin_amount"
      expr: SUM(CAST(margin_amount AS DOUBLE))
      comment: "Total gross margin amount across quote lines. Core profitability KPI for product and pricing decisions."
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of goods across quote lines. Used for margin and cost structure analysis."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value granted at the line level. Monitors line-level pricing discipline."
    - name: "avg_margin_pct"
      expr: AVG(CAST(margin_percent AS DOUBLE))
      comment: "Average gross margin percentage across quote lines. Key profitability indicator for product mix and pricing strategy."
    - name: "avg_discount_pct"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage at the line level. Identifies product lines with excessive discounting."
    - name: "avg_commission_pct"
      expr: AVG(CAST(commission_percent AS DOUBLE))
      comment: "Average commission percentage across quote lines. Used for sales compensation cost analysis."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity quoted across all lines. Used for demand forecasting and capacity planning."
    - name: "quote_line_count"
      expr: COUNT(DISTINCT quote_line_id)
      comment: "Number of distinct quote lines. Tracks quoting complexity and product mix breadth."
    - name: "margin_to_revenue_pct"
      expr: ROUND(100.0 * SUM(CAST(margin_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Gross margin as a percentage of total quoted revenue at the line level. Headline profitability ratio for product pricing reviews."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_rep`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales representative performance and capacity KPIs. Used by Sales Management to evaluate rep productivity, quota coverage, and talent pipeline health."
  source: "`vibe_manufacturing_v1`.`sales`.`rep`"
  dimensions:
    - name: "sales_role"
      expr: sales_role
      comment: "Role of the sales representative (e.g. Account Executive, Inside Sales, Key Account Manager)."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel the rep operates in (e.g. Direct, Partner, Distribution)."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment the rep is assigned to (e.g. Enterprise, Mid-Market, SMB)."
    - name: "industry_vertical_focus"
      expr: industry_vertical_focus
      comment: "Industry vertical the rep specialises in."
    - name: "product_line_specialization"
      expr: product_line_specialization
      comment: "Product line(s) the rep is specialised in."
    - name: "rep_status"
      expr: rep_status
      comment: "Current employment/activity status of the rep (e.g. Active, On Leave, Terminated)."
    - name: "performance_rating"
      expr: performance_rating
      comment: "Latest performance rating of the rep (e.g. Exceeds, Meets, Below Expectations)."
    - name: "sales_office_location"
      expr: sales_office_location
      comment: "Office location of the sales rep for geographic workforce analysis."
    - name: "is_key_account_manager"
      expr: is_key_account_manager
      comment: "Boolean flag indicating whether the rep manages key/strategic accounts."
    - name: "quota_currency_code"
      expr: quota_currency_code
      comment: "Currency in which the rep's quota is denominated."
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year the rep was hired, used for tenure cohort analysis."
  measures:
    - name: "total_annual_quota"
      expr: SUM(CAST(annual_quota_amount AS DOUBLE))
      comment: "Total annual quota across all reps. Used for aggregate quota coverage and capacity planning."
    - name: "avg_annual_quota"
      expr: AVG(CAST(annual_quota_amount AS DOUBLE))
      comment: "Average annual quota per rep. Benchmarks quota assignment levels across roles and segments."
    - name: "total_book_of_business_value"
      expr: SUM(CAST(book_of_business_value AS DOUBLE))
      comment: "Total book of business value managed across all reps. Indicates total revenue responsibility and account coverage."
    - name: "avg_book_of_business_value"
      expr: AVG(CAST(book_of_business_value AS DOUBLE))
      comment: "Average book of business value per rep. Used to assess workload balance and account coverage equity."
    - name: "active_rep_count"
      expr: COUNT(DISTINCT CASE WHEN rep_status = 'Active' THEN rep_id END)
      comment: "Number of currently active sales reps. Core capacity metric for sales force sizing decisions."
    - name: "key_account_manager_count"
      expr: COUNT(DISTINCT CASE WHEN is_key_account_manager = TRUE THEN rep_id END)
      comment: "Number of reps designated as Key Account Managers. Used to assess strategic account coverage."
    - name: "avg_travel_percentage"
      expr: AVG(CAST(travel_percentage AS DOUBLE))
      comment: "Average travel percentage across reps. Used for travel budget planning and rep capacity modelling."
    - name: "book_of_business_to_quota_ratio"
      expr: ROUND(SUM(CAST(book_of_business_value AS DOUBLE)) / NULLIF(SUM(CAST(annual_quota_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of total book of business value to total annual quota. Indicates whether reps have sufficient account coverage to achieve quota."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales contract portfolio KPIs covering contract value, SLA compliance, liability exposure, and contract lifecycle health. Used by Legal, Finance, and Sales leadership for contract governance and risk management."
  source: "`vibe_manufacturing_v1`.`sales`.`sales_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current lifecycle status of the contract (e.g. Draft, Active, Expired, Terminated)."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of sales contract (e.g. Master Service Agreement, Purchase Order, Frame Contract)."
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms governing delivery responsibility under the contract."
    - name: "governing_law"
      expr: governing_law
      comment: "Jurisdiction whose law governs the contract. Used for legal risk and compliance analysis."
    - name: "dispute_resolution_method"
      expr: dispute_resolution_method
      comment: "Method specified for resolving disputes (e.g. Arbitration, Litigation, Mediation)."
    - name: "compliance_certifications_required"
      expr: compliance_certifications_required
      comment: "Boolean flag indicating whether compliance certifications are required under the contract."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the contract became effective, used for contract vintage and renewal cohort analysis."
    - name: "signature_month"
      expr: DATE_TRUNC('MONTH', signature_date)
      comment: "Month the contract was signed, used for bookings and contract activity trend analysis."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(value_amount AS DOUBLE))
      comment: "Total value of all sales contracts. Primary KPI for contracted revenue backlog and revenue assurance."
    - name: "total_net_contract_value"
      expr: SUM(CAST(net_contract_value AS DOUBLE))
      comment: "Total net contract value after adjustments. Used for net revenue recognition and financial planning."
    - name: "total_liability_cap"
      expr: SUM(CAST(liability_cap_amount AS DOUBLE))
      comment: "Total aggregate liability cap across all contracts. Used by Legal and Finance to quantify maximum contractual risk exposure."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all contracts. Used for tax liability estimation and compliance reporting."
    - name: "contract_count"
      expr: COUNT(DISTINCT sales_contract_id)
      comment: "Number of distinct sales contracts. Tracks contract portfolio size and activity."
    - name: "active_contract_count"
      expr: COUNT(DISTINCT CASE WHEN contract_status = 'Active' THEN sales_contract_id END)
      comment: "Number of currently active contracts. Measures live contractual commitments and revenue assurance coverage."
    - name: "avg_sla_uptime_pct"
      expr: AVG(CAST(sla_uptime_percentage AS DOUBLE))
      comment: "Average SLA uptime percentage committed across contracts. Used to assess SLA risk and service delivery obligations."
    - name: "avg_net_contract_value"
      expr: AVG(CAST(net_contract_value AS DOUBLE))
      comment: "Average net contract value. Benchmarks deal size and informs contract negotiation strategy."
    - name: "compliance_required_contract_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_certifications_required = TRUE THEN sales_contract_id END)
      comment: "Number of contracts requiring compliance certifications. Used by compliance teams to prioritise certification workload."
    - name: "liability_to_contract_value_ratio"
      expr: ROUND(SUM(CAST(liability_cap_amount AS DOUBLE)) / NULLIF(SUM(CAST(value_amount AS DOUBLE)), 0), 4)
      comment: "Ratio of total liability cap to total contract value. Measures contractual risk exposure relative to revenue — a key legal risk governance metric."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_price_book_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing catalogue KPIs covering list price levels, discount policies, margin floors, and pricing coverage. Used by Pricing, Product Management, and Sales Operations to govern pricing strategy and catalogue health."
  source: "`vibe_manufacturing_v1`.`sales`.`price_book_entry`"
  dimensions:
    - name: "product_family"
      expr: product_family
      comment: "Product family of the price book entry, used for product-level pricing analysis."
    - name: "product_line"
      expr: product_line
      comment: "Product line of the price book entry."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the price book entry is denominated."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment for which this price book entry applies."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment targeted by this price book entry."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel for which this price book entry is valid (e.g. Direct, Distributor, OEM)."
    - name: "geography_code"
      expr: geography_code
      comment: "Geographic region or country code for which this price book entry applies."
    - name: "pricing_method"
      expr: pricing_method
      comment: "Pricing methodology applied (e.g. Cost-Plus, Market-Based, Value-Based)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the price book entry (e.g. Pending, Approved, Rejected)."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the price book entry is currently active."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the priced item."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the price book entry became effective, used for pricing change trend analysis."
  measures:
    - name: "avg_list_price"
      expr: AVG(CAST(list_price AS DOUBLE))
      comment: "Average list price across price book entries. Tracks pricing level trends and informs price positioning strategy."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price (after standard adjustments) across price book entries. Used for net price realisation analysis."
    - name: "avg_cost_price"
      expr: AVG(CAST(cost_price AS DOUBLE))
      comment: "Average cost price across price book entries. Used to assess cost structure and margin floor."
    - name: "avg_minimum_price"
      expr: AVG(CAST(minimum_price AS DOUBLE))
      comment: "Average minimum allowable price across entries. Monitors pricing floor compliance and margin protection."
    - name: "avg_maximum_discount_pct"
      expr: AVG(CAST(maximum_discount_percent AS DOUBLE))
      comment: "Average maximum discount percentage permitted across price book entries. Used to assess discount policy generosity and margin risk."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across price book entries. Used for order policy and fulfilment planning."
    - name: "active_entry_count"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN price_book_entry_id END)
      comment: "Number of currently active price book entries. Measures the breadth of the active pricing catalogue."
    - name: "price_book_entry_count"
      expr: COUNT(DISTINCT price_book_entry_id)
      comment: "Total number of price book entries. Tracks pricing catalogue size and coverage."
    - name: "avg_price_to_cost_ratio"
      expr: ROUND(AVG(CAST(unit_price AS DOUBLE)) / NULLIF(AVG(CAST(cost_price AS DOUBLE)), 0), 4)
      comment: "Ratio of average unit price to average cost price. Indicates average mark-up multiple and pricing power across the catalogue."
$$;