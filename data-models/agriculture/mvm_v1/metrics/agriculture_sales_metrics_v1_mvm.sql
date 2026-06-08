-- Metric views for domain: sales | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 18:41:06

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`sales_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core sales order performance metrics tracking revenue, volume, discounting, and order mix across the agricultural sales pipeline. Primary KPI surface for sales leadership and territory managers."
  source: "`agriculture_ecm`.`sales`.`order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the sales order (e.g. Open, Confirmed, Delivered, Cancelled) — used to filter pipeline vs. closed business."
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order type (e.g. Spot, Forward, Contract) — drives pricing strategy and fulfillment routing analysis."
    - name: "order_date_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Calendar month of order placement — enables month-over-month revenue and volume trend analysis."
    - name: "order_date_year"
      expr: DATE_TRUNC('YEAR', order_date)
      comment: "Calendar year of order placement — supports annual performance benchmarking and target attainment."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the order — required for multi-currency revenue reporting and FX exposure analysis."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "International commercial terms governing delivery responsibility — impacts logistics cost allocation and margin analysis."
    - name: "quality_grade"
      expr: quality_grade
      comment: "Commodity quality grade assigned to the order — enables premium/discount analysis by grade tier."
    - name: "order_channel"
      expr: order_type
      comment: "Sales channel proxy derived from order type — used for channel mix and distribution strategy analysis."
    - name: "cool_country_of_origin"
      expr: cool_country_of_origin
      comment: "Country of Origin Labeling (COOL) country code — required for regulatory compliance reporting and export market segmentation."
    - name: "requested_delivery_month"
      expr: DATE_TRUNC('MONTH', requested_delivery_date)
      comment: "Month in which delivery was requested — used to align order intake with logistics capacity planning."
  measures:
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross revenue across all orders before discounts and taxes. Primary top-line revenue KPI for sales leadership and board reporting."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net revenue after discounts, representing actual realized sales value. Core metric for P&L and margin analysis."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value granted across all orders. Tracks pricing discipline and promotional spend impact on margin."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across orders. Required for tax liability reporting and compliance with fiscal authorities."
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight charges across orders. Tracks logistics cost burden and informs incoterms and carrier strategy decisions."
    - name: "total_volume_ordered"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total commodity volume ordered (in order UOM). Primary volume throughput KPI for supply planning and capacity utilization."
    - name: "avg_price_per_unit"
      expr: AVG(CAST(price_per_unit AS DOUBLE))
      comment: "Average realized price per unit across orders. Tracks pricing effectiveness and market competitiveness over time."
    - name: "avg_order_net_value"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net value per sales order. Indicates deal size trends and customer purchasing behavior shifts."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of gross revenue. Measures pricing discipline — high values signal margin erosion risk requiring commercial intervention."
    - name: "freight_as_pct_of_net_revenue"
      expr: ROUND(100.0 * SUM(CAST(freight_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Freight cost as a percentage of net revenue. Tracks logistics efficiency — rising values indicate supply chain cost pressure."
    - name: "order_count"
      expr: COUNT(1)
      comment: "Total number of sales orders. Baseline volume metric for order intake rate, sales team productivity, and pipeline velocity."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts placing orders. Measures customer breadth and concentration risk in the revenue base."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`sales_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level sales metrics providing granular commodity, grade, and fulfillment performance visibility. Enables SKU-level margin, delivery compliance, and quality analysis."
  source: "`agriculture_ecm`.`sales`.`order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the order line (e.g. Open, Confirmed, Delivered, Cancelled) — used to track fulfillment progress at line level."
    - name: "commodity_code"
      expr: commodity_code
      comment: "Commodity identifier code on the order line — primary dimension for commodity-level revenue and volume analysis."
    - name: "grade_code"
      expr: grade_code
      comment: "Quality grade code of the commodity on the line — enables premium/discount analysis by grade tier."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for the order line — required for multi-currency revenue reporting."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country of origin for the commodity on this line — supports COOL compliance and export market analysis."
    - name: "delivery_terms"
      expr: delivery_terms
      comment: "Delivery terms agreed for this line — impacts logistics cost allocation and fulfillment responsibility."
    - name: "mrl_compliant"
      expr: mrl_compliant
      comment: "Maximum Residue Level compliance flag — critical quality and regulatory dimension for food safety reporting."
    - name: "phi_cleared"
      expr: phi_cleared
      comment: "Pre-Harvest Interval clearance flag — indicates whether the commodity meets PHI requirements for safe harvest and sale."
    - name: "confirmed_delivery_month"
      expr: DATE_TRUNC('MONTH', confirmed_delivery_date)
      comment: "Month of confirmed delivery — used for delivery schedule analysis and logistics capacity planning."
    - name: "class_code"
      expr: class_code
      comment: "Product class classification on the order line — supports product mix and portfolio analysis."
  measures:
    - name: "total_line_net_revenue"
      expr: SUM(CAST(line_net_amount AS DOUBLE))
      comment: "Total net revenue across all order lines. Granular revenue KPI enabling commodity and grade-level P&L analysis."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total volume ordered at line level. Primary demand signal for supply planning and inventory positioning."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total volume confirmed for delivery. Measures committed supply against demand and identifies fulfillment gaps."
    - name: "total_delivered_quantity"
      expr: SUM(CAST(delivered_quantity AS DOUBLE))
      comment: "Total volume actually delivered. Core fulfillment throughput metric for operational performance tracking."
    - name: "total_line_discount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted at line level. Enables commodity and grade-specific pricing discipline analysis."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across order lines. Tracks realized pricing vs. market benchmarks by commodity and grade."
    - name: "avg_moisture_pct"
      expr: AVG(CAST(moisture_pct AS DOUBLE))
      comment: "Average moisture content of commodities on order lines. Quality KPI — high moisture drives dockage and price penalties."
    - name: "avg_test_weight"
      expr: AVG(CAST(test_weight AS DOUBLE))
      comment: "Average test weight of commodities on order lines. Quality indicator directly linked to grade classification and price premiums."
    - name: "fulfillment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(delivered_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered volume that has been delivered. Critical service level KPI — low values signal supply shortfalls or logistics failures."
    - name: "confirmation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered volume confirmed for delivery. Early warning indicator of supply availability and commitment reliability."
    - name: "mrl_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN mrl_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of order lines meeting MRL compliance requirements. Regulatory quality KPI — non-compliance triggers product rejection and market access risk."
    - name: "line_count"
      expr: COUNT(1)
      comment: "Total number of order lines. Baseline measure for order complexity, product mix breadth, and processing workload."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`sales_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agricultural sales contract performance metrics tracking contracted volume, fulfillment, pricing, and compliance. Enables contract portfolio management and forward commitment analysis."
  source: "`agriculture_ecm`.`sales`.`contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract (e.g. Active, Expired, Cancelled, Pending) — primary filter for active portfolio vs. historical analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g. Forward, Spot, Basis, HTA) — drives pricing mechanism and risk exposure classification."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency — required for multi-currency portfolio valuation and FX risk reporting."
    - name: "quality_grade"
      expr: quality_grade
      comment: "Quality grade specified in the contract — enables grade-tier portfolio analysis and premium/discount tracking."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Delivery terms in the contract — impacts logistics cost allocation and risk transfer point analysis."
    - name: "fsma_compliant"
      expr: fsma_compliant
      comment: "FSMA (Food Safety Modernization Act) compliance flag — regulatory dimension for food safety audit and market access reporting."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the contract became effective — used for contract vintage analysis and seasonal commitment patterns."
    - name: "delivery_start_month"
      expr: DATE_TRUNC('MONTH', delivery_start_date)
      comment: "Month delivery window opens — aligns contracted supply with logistics and storage capacity planning."
    - name: "futures_contract_month"
      expr: futures_contract_month
      comment: "Futures delivery month referenced in the contract — links physical contracts to derivatives positions for basis risk management."
    - name: "cool_country_code"
      expr: cool_country_code
      comment: "Country of Origin Labeling country code on the contract — supports COOL regulatory compliance and export market segmentation."
  measures:
    - name: "total_contracted_volume"
      expr: SUM(CAST(contracted_volume AS DOUBLE))
      comment: "Total volume committed under active contracts. Primary forward supply commitment KPI for procurement and logistics planning."
    - name: "total_fulfilled_volume"
      expr: SUM(CAST(fulfilled_volume AS DOUBLE))
      comment: "Total volume delivered against contracts. Measures contract execution performance and supply reliability."
    - name: "total_contract_value"
      expr: SUM(CAST(price AS DOUBLE) * CAST(contracted_volume AS DOUBLE))
      comment: "Total notional value of contracts (price × contracted volume). Portfolio valuation KPI for revenue forecasting and credit exposure management."
    - name: "avg_contract_price"
      expr: AVG(CAST(price AS DOUBLE))
      comment: "Average contracted price per unit. Benchmarks realized pricing against market prices and price agreement targets."
    - name: "contract_fulfillment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(fulfilled_volume AS DOUBLE)) / NULLIF(SUM(CAST(contracted_volume AS DOUBLE)), 0), 2)
      comment: "Percentage of contracted volume fulfilled. Critical contract performance KPI — low rates signal supply shortfalls, logistics failures, or counterparty risk."
    - name: "unfulfilled_volume"
      expr: SUM(CAST(contracted_volume AS DOUBLE) - CAST(fulfilled_volume AS DOUBLE))
      comment: "Open volume remaining to be fulfilled under contracts. Operational KPI for supply gap identification and logistics scheduling."
    - name: "avg_moisture_max_pct"
      expr: AVG(CAST(moisture_max_pct AS DOUBLE))
      comment: "Average maximum moisture tolerance specified in contracts. Quality specification benchmark for procurement and grading standards alignment."
    - name: "avg_test_weight_min"
      expr: AVG(CAST(test_weight_min AS DOUBLE))
      comment: "Average minimum test weight specified in contracts. Quality floor benchmark — tracks whether contracted quality standards are commercially competitive."
    - name: "fsma_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN fsma_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts meeting FSMA compliance requirements. Regulatory KPI — non-compliance exposes the business to FDA enforcement and market access loss."
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of contracts. Baseline portfolio size metric for sales pipeline, counterparty exposure, and contract management workload."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts under contract. Measures customer commitment breadth and concentration risk in the contracted portfolio."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales pipeline and opportunity metrics tracking estimated revenue, conversion probability, and pipeline stage distribution. Core CRM analytics surface for sales forecasting and resource allocation."
  source: "`agriculture_ecm`.`sales`.`opportunity`"
  dimensions:
    - name: "pipeline_stage"
      expr: pipeline_stage
      comment: "Current stage of the opportunity in the sales pipeline (e.g. Prospecting, Qualification, Proposal, Negotiation, Closed Won/Lost) — primary pipeline funnel dimension."
    - name: "lead_source"
      expr: lead_source
      comment: "Origin channel of the sales lead (e.g. Inbound, Referral, Trade Show, Broker) — measures marketing and channel effectiveness."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the opportunity estimated revenue — required for multi-currency pipeline valuation."
    - name: "quality_grade"
      expr: quality_grade
      comment: "Target quality grade for the opportunity — enables grade-tier pipeline analysis and premium opportunity identification."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing approach for the opportunity (e.g. Fixed, Basis, Market) — informs commercial strategy and margin forecasting."
    - name: "open_date_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the opportunity was opened — tracks pipeline creation velocity and seasonal demand patterns."
    - name: "expected_close_month"
      expr: DATE_TRUNC('MONTH', expected_close_date)
      comment: "Expected month of opportunity close — used for revenue forecasting and sales team target attainment projections."
    - name: "cool_country_of_origin"
      expr: cool_country_of_origin
      comment: "Country of origin specified in the opportunity — supports export market pipeline analysis and COOL compliance planning."
    - name: "delivery_terms"
      expr: delivery_terms
      comment: "Delivery terms requested in the opportunity — impacts logistics cost estimation and margin forecasting."
  measures:
    - name: "total_estimated_revenue"
      expr: SUM(CAST(estimated_revenue AS DOUBLE))
      comment: "Total estimated revenue across all open opportunities. Primary pipeline value KPI for revenue forecasting and sales target tracking."
    - name: "total_estimated_volume"
      expr: SUM(CAST(estimated_volume AS DOUBLE))
      comment: "Total estimated commodity volume across opportunities. Supply planning signal for forward procurement and logistics capacity reservation."
    - name: "weighted_pipeline_revenue"
      expr: SUM(CAST(estimated_revenue AS DOUBLE) * CAST(close_probability_pct AS DOUBLE) / 100.0)
      comment: "Probability-weighted pipeline revenue (estimated revenue × close probability). Most accurate revenue forecast metric — used in board-level sales forecasting and quota attainment projections."
    - name: "avg_close_probability_pct"
      expr: AVG(CAST(close_probability_pct AS DOUBLE))
      comment: "Average close probability across pipeline opportunities. Tracks pipeline quality and sales team confidence — declining values signal deteriorating pipeline health."
    - name: "avg_target_price"
      expr: AVG(CAST(target_price AS DOUBLE))
      comment: "Average target price across opportunities. Benchmarks customer price expectations against market prices and contracted rates."
    - name: "avg_estimated_revenue_per_opportunity"
      expr: AVG(CAST(estimated_revenue AS DOUBLE))
      comment: "Average deal size by estimated revenue. Tracks deal size trends and informs sales resource allocation between large and small accounts."
    - name: "opportunity_count"
      expr: COUNT(1)
      comment: "Total number of opportunities in the pipeline. Baseline pipeline volume metric for sales activity tracking and funnel stage analysis."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts in the pipeline. Measures pipeline breadth and customer acquisition activity."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`sales_delivery_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery execution metrics tracking physical commodity movement, weight accuracy, delivery timeliness, and proof-of-delivery compliance. Operational KPI surface for logistics and supply chain management."
  source: "`agriculture_ecm`.`sales`.`order`"
  dimensions:
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Delivery terms on the delivery order — determines risk transfer point and logistics cost responsibility."
  measures:
    - name: "delivery_count"
      expr: COUNT(1)
      comment: "Total number of delivery orders. Baseline logistics throughput metric for operational capacity and carrier performance benchmarking."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers receiving deliveries. Measures delivery service breadth and identifies customer concentration in logistics operations."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`sales_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales quotation metrics tracking quote volume, value, conversion activity, and pricing competitiveness. Enables sales effectiveness analysis from quote to order conversion."
  source: "`agriculture_ecm`.`sales`.`quote`"
  dimensions:
    - name: "quote_status"
      expr: quote_status
      comment: "Current status of the quote (e.g. Draft, Sent, Accepted, Rejected, Expired) — primary funnel dimension for quote-to-order conversion analysis."
    - name: "quote_type"
      expr: quote_type
      comment: "Type of quote (e.g. Spot, Forward, Contract) — drives pricing mechanism and commercial strategy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the quote — required for multi-currency pipeline valuation and pricing analysis."
    - name: "commodity_grade"
      expr: commodity_grade
      comment: "Quality grade quoted — enables grade-tier pricing and conversion rate analysis."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Delivery terms in the quote — impacts logistics cost inclusion and net price competitiveness."
    - name: "mrl_compliant"
      expr: mrl_compliant
      comment: "MRL compliance flag on the quote — regulatory quality dimension for food safety market access analysis."
    - name: "multi_commodity_flag"
      expr: multi_commodity_flag
      comment: "Flag indicating whether the quote covers multiple commodities — identifies complex multi-commodity deals requiring specialized handling."
    - name: "quote_date_month"
      expr: DATE_TRUNC('MONTH', quote_date)
      comment: "Month the quote was issued — tracks quoting activity velocity and seasonal demand patterns."
    - name: "valid_to_month"
      expr: DATE_TRUNC('MONTH', valid_to_date)
      comment: "Month the quote expires — used to identify quotes at risk of expiry requiring follow-up action."
  measures:
    - name: "total_quoted_value"
      expr: SUM(CAST(total_quoted_value AS DOUBLE))
      comment: "Total value of all quotes issued. Primary pipeline value metric for sales funnel analysis and revenue forecasting."
    - name: "total_quoted_volume"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total commodity volume quoted. Demand signal for supply planning and logistics capacity reservation."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount offered across quotes. Tracks pricing discipline and commercial concession levels at the quoting stage."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price quoted. Benchmarks quoted pricing against market prices and price agreements to assess competitiveness."
    - name: "avg_net_price"
      expr: AVG(CAST(net_price AS DOUBLE))
      comment: "Average net price after discounts across quotes. Tracks effective pricing levels and discount impact on realized price."
    - name: "avg_quote_value"
      expr: AVG(CAST(total_quoted_value AS DOUBLE))
      comment: "Average total value per quote. Tracks deal size trends and informs sales resource allocation strategy."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_quoted_value AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of total quoted value. Pricing discipline KPI — high values at quote stage signal margin risk before order conversion."
    - name: "quote_count"
      expr: COUNT(1)
      comment: "Total number of quotes issued. Baseline sales activity metric for quoting velocity, team productivity, and funnel stage analysis."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers receiving quotes. Measures market outreach breadth and customer engagement activity."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`sales_market_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity market price analytics tracking price levels, spreads, volatility, and basis values. Essential for pricing strategy, contract benchmarking, and commodity risk management."
  source: "`agriculture_ecm`.`sales`.`market_price`"
  dimensions:
    - name: "price_type"
      expr: price_type
      comment: "Type of price record (e.g. Spot, Futures, Basis, Settlement) — primary classification for price series analysis."
    - name: "price_source"
      expr: price_source
      comment: "Source of the price data (e.g. CME, CBOT, USDA, Internal) — tracks data provenance and enables source comparison."
    - name: "exchange_code"
      expr: exchange_code
      comment: "Exchange where the price was quoted (e.g. CME, ICE) — enables exchange-level price comparison and arbitrage analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the price — required for cross-currency price comparison and FX-adjusted analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country associated with the price — enables geographic price differential and export parity analysis."
    - name: "futures_contract_month"
      expr: futures_contract_month
      comment: "Futures delivery month — links spot and basis prices to specific futures contract months for basis risk management."
    - name: "price_date_month"
      expr: DATE_TRUNC('MONTH', price_date)
      comment: "Calendar month of the price record — enables monthly price trend and seasonality analysis."
    - name: "price_frequency"
      expr: price_frequency
      comment: "Frequency of price observation (e.g. Daily, Weekly, Monthly) — used to normalize price series for consistent trend analysis."
    - name: "price_status"
      expr: price_status
      comment: "Status of the price record (e.g. Active, Superseded, Holiday) — filters for valid price observations in analysis."
    - name: "is_holiday"
      expr: is_holiday
      comment: "Flag indicating whether the price date is a market holiday — used to exclude non-trading days from price trend calculations."
  measures:
    - name: "avg_settlement_price"
      expr: AVG(CAST(settlement_price AS DOUBLE))
      comment: "Average settlement price across observations. Primary benchmark price for contract valuation, margin-to-market calculations, and pricing strategy."
    - name: "avg_close_price"
      expr: AVG(CAST(close_price AS DOUBLE))
      comment: "Average closing price across trading sessions. Standard price reference for daily P&L marking and contract benchmarking."
    - name: "avg_basis_value"
      expr: AVG(CAST(basis_value AS DOUBLE))
      comment: "Average basis value (local cash price minus futures price). Core commodity trading KPI — tracks local market supply/demand dynamics and informs basis contract pricing."
    - name: "avg_bid_ask_spread"
      expr: AVG(CAST(ask_price AS DOUBLE) - CAST(bid_price AS DOUBLE))
      comment: "Average bid-ask spread across price observations. Market liquidity indicator — wide spreads signal thin markets and increased transaction cost risk."
    - name: "avg_daily_price_change"
      expr: AVG(CAST(price_change AS DOUBLE))
      comment: "Average daily price change across observations. Volatility indicator — large absolute values signal market stress requiring hedging strategy review."
    - name: "avg_high_low_range"
      expr: AVG(CAST(high_price AS DOUBLE) - CAST(low_price AS DOUBLE))
      comment: "Average intraday price range (high minus low). Intraday volatility measure — used for options pricing, risk management, and execution timing decisions."
    - name: "total_trading_volume"
      expr: SUM(CAST(volume AS BIGINT))
      comment: "Total trading volume across price observations. Market activity KPI — low volume signals illiquid conditions affecting price reliability and hedging effectiveness."
    - name: "avg_open_interest"
      expr: AVG(CAST(open_interest AS BIGINT))
      comment: "Average open interest across futures observations. Measures market participation depth — declining open interest signals position unwinding and potential price trend reversal."
    - name: "price_observation_count"
      expr: COUNT(1)
      comment: "Total number of price observations. Baseline data completeness metric for price series integrity and market coverage validation."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`sales_broker`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Broker performance and portfolio metrics tracking volume facilitation, commission economics, and contract compliance. Enables broker network management and channel performance optimization."
  source: "`agriculture_ecm`.`sales`.`broker`"
  dimensions:
    - name: "broker_type"
      expr: broker_type
      comment: "Classification of broker type (e.g. Independent, Captive, Regional) — primary segmentation for broker network strategy analysis."
    - name: "broker_category"
      expr: broker_category
      comment: "Business category of the broker — enables portfolio segmentation by broker specialization and market focus."
    - name: "relationship_status"
      expr: relationship_status
      comment: "Current relationship status with the broker (e.g. Active, Inactive, Probation, Terminated) — primary filter for active network analysis."
    - name: "commission_structure_type"
      expr: commission_structure_type
      comment: "Type of commission structure (e.g. Flat Rate, Tiered, Volume-Based) — drives commission cost modeling and broker incentive analysis."
    - name: "preferred_sales_channel"
      expr: preferred_sales_channel
      comment: "Broker's preferred sales channel — aligns broker capabilities with channel strategy and distribution planning."
    - name: "business_country_code"
      expr: business_country_code
      comment: "Country where the broker operates — enables geographic broker network coverage analysis and market penetration assessment."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Flag indicating whether the broker has an exclusivity arrangement — identifies exclusive vs. non-exclusive broker relationships for competitive strategy."
    - name: "globalg_ap_certified"
      expr: globalg_ap_certified
      comment: "GlobalG.A.P. certification status of the broker — quality and compliance dimension for premium market access and retailer requirements."
    - name: "contract_start_month"
      expr: DATE_TRUNC('MONTH', contract_start_date)
      comment: "Month broker contract commenced — used for broker cohort analysis and contract renewal planning."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed with the broker — impacts cash flow timing and commission liability management."
  measures:
    - name: "total_ytd_volume_facilitated_mt"
      expr: SUM(CAST(ytd_volume_facilitated_mt AS DOUBLE))
      comment: "Total year-to-date volume facilitated by brokers in metric tonnes. Primary broker network throughput KPI for channel performance and target attainment."
    - name: "total_annual_volume_target_mt"
      expr: SUM(CAST(annual_volume_target_mt AS DOUBLE))
      comment: "Total annual volume target committed by brokers in metric tonnes. Baseline for broker target attainment and network capacity planning."
    - name: "broker_volume_attainment_pct"
      expr: ROUND(100.0 * SUM(CAST(ytd_volume_facilitated_mt AS DOUBLE)) / NULLIF(SUM(CAST(annual_volume_target_mt AS DOUBLE)), 0), 2)
      comment: "YTD volume facilitated as a percentage of annual target. Broker performance KPI — low attainment triggers account review, support intervention, or contract renegotiation."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate across the broker network. Cost of channel KPI — tracks commission expense trends and informs broker contract renegotiation strategy."
    - name: "broker_count"
      expr: COUNT(1)
      comment: "Total number of brokers in the network. Baseline network size metric for channel coverage and broker relationship management workload."
    - name: "active_broker_count"
      expr: COUNT(CASE WHEN relationship_status = 'Active' THEN 1 END)
      comment: "Number of brokers with active relationship status. Measures effective network size — declining active count signals channel attrition requiring retention action."
    - name: "exclusive_broker_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END)
      comment: "Number of brokers with exclusivity arrangements. Tracks exclusive channel commitment — high concentration in exclusive brokers signals competitive lock-in risk."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`sales_price_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price agreement portfolio metrics tracking pricing levels, discount structures, volume thresholds, and agreement compliance. Enables commercial pricing governance and margin protection analysis."
  source: "`agriculture_ecm`.`sales`.`price_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the price agreement (e.g. Active, Expired, Pending Approval) — primary filter for active pricing portfolio analysis."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of price agreement (e.g. Annual, Seasonal, Spot, Framework) — drives pricing strategy and commercial relationship classification."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the agreement — tracks pricing governance compliance and identifies agreements pending authorization."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the price agreement — required for multi-currency pricing portfolio analysis."
    - name: "commodity_grade"
      expr: commodity_grade
      comment: "Quality grade covered by the agreement — enables grade-tier pricing analysis and premium/discount structure review."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Delivery terms in the agreement — impacts net price competitiveness and logistics cost allocation."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Flag indicating whether the price agreement is exclusive — identifies exclusive pricing commitments and their impact on market flexibility."
    - name: "gmo_status"
      expr: gmo_status
      comment: "GMO status of the commodity covered by the agreement — regulatory and market access dimension for GMO-free premium pricing analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the price agreement becomes effective — used for pricing vintage analysis and seasonal pricing pattern identification."
    - name: "renewal_type"
      expr: renewal_type
      comment: "Renewal mechanism for the agreement (e.g. Auto-Renew, Manual, One-Time) — tracks contract renewal risk and commercial relationship continuity."
  measures:
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base price across price agreements. Benchmarks contracted pricing levels against market prices and cost of production."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate across price agreements. Tracks commercial concession levels — high averages signal margin erosion risk in the pricing portfolio."
    - name: "total_flat_discount_amount"
      expr: SUM(CAST(flat_discount_amount AS DOUBLE))
      comment: "Total flat discount value committed across price agreements. Quantifies absolute discount liability in the pricing portfolio."
    - name: "avg_quality_premium"
      expr: AVG(CAST(quality_premium AS DOUBLE))
      comment: "Average quality premium across price agreements. Tracks premium capture for high-grade commodities — key metric for quality-differentiated pricing strategy."
    - name: "avg_freight_allowance"
      expr: AVG(CAST(freight_allowance AS DOUBLE))
      comment: "Average freight allowance granted in price agreements. Tracks logistics subsidy levels — impacts net margin and informs incoterms strategy."
    - name: "total_max_volume_threshold"
      expr: SUM(CAST(max_volume_threshold AS DOUBLE))
      comment: "Total maximum volume committed under price agreements. Measures maximum supply obligation and capacity commitment in the pricing portfolio."
    - name: "total_min_volume_threshold"
      expr: SUM(CAST(min_volume_threshold AS DOUBLE))
      comment: "Total minimum volume committed under price agreements. Measures minimum supply guarantee obligations — critical for procurement planning and take-or-pay risk management."
    - name: "price_agreement_count"
      expr: COUNT(1)
      comment: "Total number of price agreements. Baseline portfolio size metric for pricing governance workload and commercial relationship breadth."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers covered by price agreements. Measures pricing agreement penetration across the customer base."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`sales_territory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales territory performance and capacity metrics tracking revenue targets, volume commitments, market penetration, and geographic coverage. Enables territory planning, resource allocation, and sales force effectiveness analysis."
  source: "`agriculture_ecm`.`sales`.`territory`"
  dimensions:
    - name: "territory_status"
      expr: territory_status
      comment: "Current operational status of the territory (e.g. Active, Inactive, Under Review) — primary filter for active territory portfolio analysis."
    - name: "territory_type"
      expr: territory_type
      comment: "Classification of territory type (e.g. Domestic, Export, Key Account) — drives resource allocation and go-to-market strategy."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the territory hierarchy (e.g. National, Regional, District) — enables hierarchical roll-up analysis for management reporting."
    - name: "region"
      expr: region
      comment: "Geographic region of the territory — primary geographic dimension for regional performance benchmarking."
    - name: "country_code"
      expr: country_code
      comment: "Country of the territory — enables country-level market analysis and international expansion planning."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment focus of the territory (e.g. Large Grower, Co-op, Processor) — aligns territory strategy with customer segmentation."
    - name: "is_export_territory"
      expr: is_export_territory
      comment: "Flag indicating whether the territory covers export markets — separates domestic and export performance for trade strategy analysis."
    - name: "cool_compliance_required"
      expr: cool_compliance_required
      comment: "Flag indicating COOL compliance requirement in the territory — regulatory dimension for market access and compliance cost analysis."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy applied in the territory (e.g. Market-Based, Cost-Plus, Competitive) — informs commercial strategy and margin management."
    - name: "effective_from_year"
      expr: DATE_TRUNC('YEAR', effective_from)
      comment: "Year the territory became effective — used for territory vintage analysis and realignment impact assessment."
  measures:
    - name: "total_annual_revenue_target_usd"
      expr: SUM(CAST(annual_revenue_target_usd AS DOUBLE))
      comment: "Total annual revenue target across territories in USD. Primary sales target KPI for quota setting, resource allocation, and board-level revenue planning."
    - name: "total_annual_volume_target_mt"
      expr: SUM(CAST(annual_volume_target_mt AS DOUBLE))
      comment: "Total annual volume target across territories in metric tonnes. Supply planning KPI for procurement, logistics, and storage capacity alignment."
    - name: "total_annual_volume_target_bu"
      expr: SUM(CAST(annual_volume_target_bu AS DOUBLE))
      comment: "Total annual volume target across territories in bushels. North American market volume KPI for grain elevator and co-op channel planning."
    - name: "total_farmland_acres"
      expr: SUM(CAST(total_farmland_acres AS DOUBLE))
      comment: "Total farmland acreage covered by territories. Market size indicator — tracks addressable land base for crop input sales and agronomic service coverage."
    - name: "avg_market_penetration_pct"
      expr: AVG(CAST(market_penetration_pct AS DOUBLE))
      comment: "Average market penetration percentage across territories. Strategic KPI — low penetration identifies growth opportunities; high penetration signals saturation requiring new market development."
    - name: "territory_count"
      expr: COUNT(1)
      comment: "Total number of sales territories. Baseline coverage metric for sales force structure and geographic market coverage analysis."
    - name: "export_territory_count"
      expr: COUNT(CASE WHEN is_export_territory = TRUE THEN 1 END)
      comment: "Number of export-designated territories. Tracks international market coverage — informs export growth strategy and trade compliance resource allocation."
$$;