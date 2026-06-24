-- Metric views for domain: sales | Business: Semiconductors | Version: 2 | Generated on: 2026-06-24 02:09:37

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core booking revenue and order metrics for semiconductor sales performance tracking and revenue recognition analysis."
  source: "`vibe_semiconductors_v1`.`sales`.`booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the booking (e.g., confirmed, pending, cancelled) for pipeline and fulfillment tracking."
    - name: "order_type"
      expr: order_type
      comment: "Type of order (e.g., standard, rush, consignment) for operational segmentation."
    - name: "sales_region"
      expr: sales_region
      comment: "Geographic sales region for regional performance analysis and territory management."
    - name: "product_family"
      expr: product_family
      comment: "Product family of the booked items for product line performance tracking."
    - name: "ship_to_country"
      expr: ship_to_country
      comment: "Destination country for geographic revenue distribution and export compliance analysis."
    - name: "delivery_mode"
      expr: delivery_mode
      comment: "Delivery method (e.g., air, sea, ground) for logistics cost and speed analysis."
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing structure applied (e.g., list, volume, contract) for pricing strategy effectiveness."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the booking for multi-currency revenue consolidation."
    - name: "booking_year"
      expr: YEAR(booking_timestamp)
      comment: "Year of booking for annual trend analysis."
    - name: "booking_quarter"
      expr: CONCAT('Q', QUARTER(booking_timestamp), '-', YEAR(booking_timestamp))
      comment: "Fiscal quarter of booking for quarterly business reviews."
    - name: "booking_month"
      expr: DATE_TRUNC('MONTH', booking_timestamp)
      comment: "Month of booking for monthly sales performance tracking."
    - name: "revenue_recognition_year"
      expr: YEAR(revenue_recognition_date)
      comment: "Year of revenue recognition for financial reporting alignment."
    - name: "revenue_recognition_quarter"
      expr: CONCAT('Q', QUARTER(revenue_recognition_date), '-', YEAR(revenue_recognition_date))
      comment: "Fiscal quarter of revenue recognition for quarterly financial close."
    - name: "backlog_flag"
      expr: backlog_flag
      comment: "Indicates whether booking is in backlog for order fulfillment pipeline visibility."
    - name: "forecast_flag"
      expr: forecast_flag
      comment: "Indicates whether booking is forecasted vs. actual for pipeline accuracy assessment."
    - name: "is_critical"
      expr: is_critical
      comment: "Flags critical priority bookings for expedited handling and executive visibility."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status for export control and trade compliance monitoring."
  measures:
    - name: "total_booked_revenue_net"
      expr: SUM(CAST(booked_revenue_net AS DOUBLE))
      comment: "Total net revenue booked (after discounts and adjustments) - primary top-line revenue KPI for sales performance."
    - name: "total_booked_revenue_gross"
      expr: SUM(CAST(booked_revenue_gross AS DOUBLE))
      comment: "Total gross revenue booked (before discounts) for pricing power and discount impact analysis."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied across bookings for pricing strategy and margin erosion tracking."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on bookings for tax liability and compliance reporting."
    - name: "total_booked_quantity"
      expr: SUM(CAST(booked_quantity AS BIGINT))
      comment: "Total units booked for volume trend analysis and capacity planning."
    - name: "booking_count"
      expr: COUNT(1)
      comment: "Total number of bookings for order velocity and sales activity tracking."
    - name: "unique_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts placing orders for customer base breadth and concentration risk."
    - name: "avg_booking_value_net"
      expr: AVG(CAST(booked_revenue_net AS DOUBLE))
      comment: "Average net revenue per booking for deal size trends and sales effectiveness."
    - name: "avg_discount_per_booking"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per booking for pricing discipline and negotiation effectiveness."
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(booked_revenue_gross AS DOUBLE)), 0), 2)
      comment: "Percentage of gross revenue given as discounts - key margin and pricing power indicator for executive review."
    - name: "backlog_bookings_count"
      expr: SUM(CASE WHEN backlog_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of bookings in backlog for fulfillment capacity and delivery risk assessment."
    - name: "critical_bookings_count"
      expr: SUM(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END)
      comment: "Number of critical priority bookings for resource allocation and escalation management."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales pipeline and opportunity conversion metrics for forecasting, win/loss analysis, and sales effectiveness."
  source: "`vibe_semiconductors_v1`.`sales`.`opportunity`"
  dimensions:
    - name: "stage"
      expr: stage
      comment: "Current sales stage (e.g., prospecting, qualification, proposal, negotiation, closed) for pipeline health analysis."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel (e.g., direct, partner, distributor) for channel effectiveness and coverage strategy."
    - name: "region"
      expr: region
      comment: "Geographic region of the opportunity for regional pipeline and quota tracking."
    - name: "end_market"
      expr: end_market
      comment: "Target end market (e.g., automotive, consumer, industrial) for vertical market strategy and product-market fit."
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing approach (e.g., volume-based, contract, spot) for pricing strategy optimization."
    - name: "country_code"
      expr: country_code
      comment: "Country of the opportunity for country-level pipeline and market penetration analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract being pursued (e.g., MSA, SOW, purchase order) for deal structure analysis."
    - name: "contract_status"
      expr: contract_status
      comment: "Status of contract negotiation for legal and commercial bottleneck identification."
    - name: "competitive_landscape"
      expr: competitive_landscape
      comment: "Competitive situation (e.g., sole source, competitive, incumbent displacement) for win strategy and positioning."
    - name: "target_application"
      expr: target_application
      comment: "Specific application the customer is targeting for product roadmap alignment and design-in tracking."
    - name: "expected_close_year"
      expr: YEAR(expected_close_date)
      comment: "Year of expected close for annual pipeline forecasting."
    - name: "expected_close_quarter"
      expr: CONCAT('Q', QUARTER(expected_close_date), '-', YEAR(expected_close_date))
      comment: "Fiscal quarter of expected close for quarterly quota and forecast management."
    - name: "expected_close_month"
      expr: DATE_TRUNC('MONTH', expected_close_date)
      comment: "Month of expected close for monthly pipeline coverage and sales velocity."
    - name: "win_loss_reason"
      expr: win_loss_reason
      comment: "Reason for win or loss outcome for competitive intelligence and sales process improvement."
  measures:
    - name: "total_pipeline_value_gross"
      expr: SUM(CAST(expected_gross_amount AS DOUBLE))
      comment: "Total gross value of all opportunities in pipeline - primary pipeline health and coverage KPI for sales leadership."
    - name: "total_pipeline_value_net"
      expr: SUM(CAST(expected_net_amount AS DOUBLE))
      comment: "Total net value of pipeline (after expected discounts) for realistic revenue forecasting."
    - name: "total_expected_discount"
      expr: SUM(CAST(expected_discount_amount AS DOUBLE))
      comment: "Total expected discounts across pipeline for pricing strategy and margin planning."
    - name: "total_nre_amount"
      expr: SUM(CAST(nre_amount AS DOUBLE))
      comment: "Total non-recurring engineering fees in pipeline for services revenue and custom design tracking."
    - name: "opportunity_count"
      expr: COUNT(1)
      comment: "Total number of opportunities for pipeline breadth and sales activity level."
    - name: "unique_accounts_in_pipeline"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique accounts with active opportunities for customer engagement breadth and concentration risk."
    - name: "avg_opportunity_value_net"
      expr: AVG(CAST(expected_net_amount AS DOUBLE))
      comment: "Average net value per opportunity for deal size trends and sales targeting effectiveness."
    - name: "avg_expected_discount_per_opp"
      expr: AVG(CAST(expected_discount_amount AS DOUBLE))
      comment: "Average expected discount per opportunity for pricing discipline in pipeline."
    - name: "weighted_pipeline_value"
      expr: SUM(CAST(expected_net_amount AS DOUBLE) * CAST(REGEXP_REPLACE(probability_percent, '[^0-9.]', '') AS DOUBLE) / 100.0)
      comment: "Probability-weighted pipeline value for risk-adjusted revenue forecasting and quota coverage - critical for CFO and sales ops."
    - name: "avg_price_per_unit"
      expr: AVG(CAST(price_per_unit AS DOUBLE))
      comment: "Average unit price across opportunities for pricing trend analysis and ASP tracking."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand forecast accuracy and planning metrics for supply chain alignment, revenue planning, and forecast quality management."
  source: "`vibe_semiconductors_v1`.`sales`.`forecast`"
  dimensions:
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g., demand, supply, consensus) for forecast process segmentation."
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of forecast (e.g., draft, submitted, approved, locked) for forecast governance and workflow tracking."
    - name: "confidence_level"
      expr: confidence_level
      comment: "Confidence level of forecast (e.g., high, medium, low) for risk assessment and safety stock planning."
    - name: "scenario_name"
      expr: scenario_name
      comment: "Scenario identifier (e.g., base, upside, downside) for scenario planning and sensitivity analysis."
    - name: "geography"
      expr: geography
      comment: "Geographic region of demand for regional capacity and inventory allocation."
    - name: "end_market"
      expr: end_market
      comment: "Target end market for vertical-specific demand planning and product mix optimization."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the forecast for financial planning alignment."
    - name: "forecast_year"
      expr: YEAR(effective_start)
      comment: "Year of forecast effective start for annual planning cycles."
    - name: "forecast_quarter"
      expr: CONCAT('Q', QUARTER(effective_start), '-', YEAR(effective_start))
      comment: "Fiscal quarter of forecast for quarterly S&OP and business planning."
    - name: "forecast_month"
      expr: DATE_TRUNC('MONTH', effective_start)
      comment: "Month of forecast for monthly demand review and rolling forecast updates."
    - name: "is_locked"
      expr: is_locked
      comment: "Indicates whether forecast is locked for change control and baseline tracking."
    - name: "approved_by"
      expr: approved_by
      comment: "Approver of the forecast for accountability and governance audit trail."
  measures:
    - name: "total_forecast_quantity"
      expr: SUM(CAST(quantity AS BIGINT))
      comment: "Total forecasted unit demand for capacity planning and material procurement - primary S&OP input metric."
    - name: "total_forecast_revenue"
      expr: SUM(CAST(revenue AS DOUBLE))
      comment: "Total forecasted revenue for financial planning and revenue guidance - critical CFO and investor relations KPI."
    - name: "forecast_count"
      expr: COUNT(1)
      comment: "Number of forecast records for forecast granularity and coverage assessment."
    - name: "unique_accounts_forecasted"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique accounts in forecast for customer concentration and demand diversification."
    - name: "avg_forecast_quantity"
      expr: AVG(CAST(quantity AS BIGINT))
      comment: "Average forecasted quantity per record for typical order size and lot planning."
    - name: "avg_forecast_revenue"
      expr: AVG(CAST(revenue AS DOUBLE))
      comment: "Average forecasted revenue per record for deal size and ASP trends."
    - name: "total_forecast_bias"
      expr: SUM(CAST(bias AS DOUBLE))
      comment: "Total forecast bias (systematic over/under-forecast) for forecast process improvement and planner accountability."
    - name: "avg_forecast_bias"
      expr: AVG(CAST(bias AS DOUBLE))
      comment: "Average forecast bias for systematic accuracy assessment - key metric for demand planning quality."
    - name: "avg_mape"
      expr: AVG(CAST(mape AS DOUBLE))
      comment: "Average Mean Absolute Percentage Error for forecast accuracy benchmarking - critical S&OP and executive KPI."
    - name: "total_variance_to_actual"
      expr: SUM(CAST(variance_to_actual AS DOUBLE))
      comment: "Total variance between forecast and actual for aggregate accuracy and planning effectiveness."
    - name: "avg_variance_to_actual"
      expr: AVG(CAST(variance_to_actual AS DOUBLE))
      comment: "Average variance to actual for typical forecast error magnitude and process tuning."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_customer_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer contract value, compliance, and lifecycle metrics for contract management, revenue assurance, and customer relationship governance."
  source: "`vibe_semiconductors_v1`.`sales`.`customer_contract`"
  dimensions:
    - name: "customer_contract_status"
      expr: customer_contract_status
      comment: "Current status of contract (e.g., active, expired, pending renewal) for contract lifecycle management."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g., MSA, supply agreement, NRE) for contract portfolio segmentation."
    - name: "sales_region"
      expr: sales_region
      comment: "Geographic sales region for regional contract coverage and compliance tracking."
    - name: "currency"
      expr: currency
      comment: "Contract currency for multi-currency exposure and hedging analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms (e.g., Net 30, Net 60) for cash flow planning and DSO management."
    - name: "pricing_terms"
      expr: pricing_terms
      comment: "Pricing structure in contract for pricing model effectiveness and margin protection."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Customer credit rating for credit risk assessment and exposure management."
    - name: "renewal_option"
      expr: renewal_option
      comment: "Contract renewal terms for retention planning and revenue continuity."
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Indicates automatic renewal for revenue predictability and customer stickiness."
    - name: "contract_year"
      expr: YEAR(effective_from)
      comment: "Year contract became effective for vintage analysis and contract portfolio trends."
    - name: "contract_quarter"
      expr: CONCAT('Q', QUARTER(effective_from), '-', YEAR(effective_from))
      comment: "Fiscal quarter of contract start for quarterly contract acquisition tracking."
    - name: "expiration_year"
      expr: YEAR(effective_until)
      comment: "Year of contract expiration for renewal pipeline and churn risk management."
    - name: "expiration_quarter"
      expr: CONCAT('Q', QUARTER(effective_until), '-', YEAR(effective_until))
      comment: "Fiscal quarter of contract expiration for proactive renewal engagement."
    - name: "ltb_provision"
      expr: ltb_provision
      comment: "Last-time-buy provision flag for EOL risk and customer transition planning."
    - name: "eol_clause"
      expr: eol_clause
      comment: "End-of-life clause presence for product lifecycle and customer notification obligations."
    - name: "pcn_obligation"
      expr: pcn_obligation
      comment: "Product change notification obligation for compliance and customer communication requirements."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value_total AS DOUBLE))
      comment: "Total value of all customer contracts - primary contracted revenue and customer commitment KPI for executive review."
    - name: "total_annual_value"
      expr: SUM(CAST(annual_value AS DOUBLE))
      comment: "Total annualized contract value for recurring revenue tracking and ARR reporting."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit extended to customers for credit exposure and risk management - critical for CFO and credit committee."
    - name: "total_volume_commitment"
      expr: SUM(CAST(volume_commitment AS BIGINT))
      comment: "Total committed purchase volumes for capacity planning and minimum revenue assurance."
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of customer contracts for contract portfolio size and administrative workload."
    - name: "unique_accounts_under_contract"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique accounts with active contracts for contracted customer base and relationship depth."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value_total AS DOUBLE))
      comment: "Average total value per contract for deal size benchmarking and customer segmentation."
    - name: "avg_annual_value"
      expr: AVG(CAST(annual_value AS DOUBLE))
      comment: "Average annualized value per contract for recurring revenue per customer and pricing effectiveness."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate across contracts for pricing discipline and margin protection assessment."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per contract for credit policy effectiveness and risk appetite."
    - name: "contracts_with_auto_renew"
      expr: SUM(CASE WHEN auto_renew_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of contracts with automatic renewal for revenue retention and churn risk mitigation."
    - name: "contracts_with_ltb_provision"
      expr: SUM(CASE WHEN ltb_provision = TRUE THEN 1 ELSE 0 END)
      comment: "Number of contracts with last-time-buy provisions for EOL planning and customer transition risk."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quote conversion, win/loss, and pricing effectiveness metrics for sales process optimization and pricing strategy."
  source: "`vibe_semiconductors_v1`.`sales`.`quote`"
  dimensions:
    - name: "quote_status"
      expr: quote_status
      comment: "Current status of quote (e.g., draft, sent, accepted, rejected) for quote lifecycle and follow-up management."
    - name: "win_loss_status"
      expr: win_loss_status
      comment: "Win/loss outcome of quote for conversion analysis and competitive intelligence."
    - name: "reason_lost"
      expr: reason_lost
      comment: "Reason for lost quote (e.g., price, lead time, competitor) for sales process improvement and competitive response."
    - name: "sales_region"
      expr: sales_region
      comment: "Geographic sales region for regional quote activity and conversion performance."
    - name: "currency"
      expr: currency
      comment: "Quote currency for multi-currency pricing and FX impact analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms offered for terms competitiveness and cash flow impact."
    - name: "delivery_terms"
      expr: delivery_terms
      comment: "Delivery terms (e.g., FOB, CIF) for logistics cost allocation and customer preference."
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms for trade compliance and cost responsibility."
    - name: "volume_tier"
      expr: volume_tier
      comment: "Volume pricing tier applied for volume discount effectiveness and customer segmentation."
    - name: "is_converted"
      expr: is_converted
      comment: "Indicates whether quote converted to booking for conversion rate calculation."
    - name: "quote_year"
      expr: YEAR(quote_date)
      comment: "Year of quote creation for annual quote activity trends."
    - name: "quote_quarter"
      expr: CONCAT('Q', QUARTER(quote_date), '-', YEAR(quote_date))
      comment: "Fiscal quarter of quote for quarterly sales activity and pipeline generation."
    - name: "quote_month"
      expr: DATE_TRUNC('MONTH', quote_date)
      comment: "Month of quote for monthly sales velocity and lead generation tracking."
    - name: "conversion_year"
      expr: YEAR(conversion_date)
      comment: "Year of quote conversion for conversion timing and sales cycle analysis."
  measures:
    - name: "total_quote_value_net"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net value of all quotes (after discounts) for quote pipeline and potential revenue tracking."
    - name: "total_quote_value_gross"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross value of quotes (before discounts) for pricing power and discount impact."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts offered in quotes for pricing strategy and margin erosion assessment."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on quotes for tax burden and pricing competitiveness."
    - name: "quote_count"
      expr: COUNT(1)
      comment: "Total number of quotes for sales activity level and quote volume trends."
    - name: "unique_accounts_quoted"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique accounts receiving quotes for customer engagement breadth and market coverage."
    - name: "converted_quote_count"
      expr: SUM(CASE WHEN is_converted = TRUE THEN 1 ELSE 0 END)
      comment: "Number of quotes converted to bookings for conversion effectiveness tracking."
    - name: "quote_conversion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_converted = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of quotes converted to bookings - critical sales effectiveness and process quality KPI for sales leadership."
    - name: "avg_quote_value_net"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net value per quote for deal size trends and pricing strategy."
    - name: "avg_discount_per_quote"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per quote for pricing discipline and negotiation effectiveness."
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross quote value given as discounts - key pricing power and margin protection indicator."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across quotes for ASP trends and pricing competitiveness."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`sales_channel_partner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel partner performance, inventory, and sell-through metrics for channel management, partner enablement, and indirect sales optimization."
  source: "`vibe_semiconductors_v1`.`sales`.`channel_partner`"
  dimensions:
    - name: "partner_type"
      expr: partner_type
      comment: "Type of channel partner (e.g., distributor, VAR, OEM) for channel strategy segmentation."
    - name: "tier_classification"
      expr: tier_classification
      comment: "Partner tier (e.g., platinum, gold, silver) for partner program effectiveness and resource allocation."
    - name: "channel_partner_status"
      expr: channel_partner_status
      comment: "Current status of partner relationship (e.g., active, inactive, probation) for partner lifecycle management."
    - name: "contract_status"
      expr: contract_status
      comment: "Status of partner contract for contract compliance and renewal tracking."
    - name: "country_code"
      expr: country_code
      comment: "Country of partner for geographic channel coverage and market access."
    - name: "territory_coverage"
      expr: territory_coverage
      comment: "Geographic territory covered by partner for territory planning and conflict management."
    - name: "authorized_product_lines"
      expr: authorized_product_lines
      comment: "Product lines partner is authorized to sell for product coverage and specialization."
    - name: "pricing_agreement_type"
      expr: pricing_agreement_type
      comment: "Type of pricing agreement (e.g., cost-plus, margin-based) for channel margin management."
    - name: "hub_consignment_level"
      expr: hub_consignment_level
      comment: "Consignment inventory level at partner hub for inventory investment and availability."
    - name: "inventory_reporting_obligation"
      expr: inventory_reporting_obligation
      comment: "Whether partner must report inventory for channel visibility and demand sensing."
    - name: "price_protection_claims_allowed"
      expr: price_protection_claims_allowed
      comment: "Whether partner can claim price protection for channel margin stability and pricing change impact."
    - name: "contract_year"
      expr: YEAR(contract_effective_from)
      comment: "Year partner contract became effective for partner program vintage analysis."
  measures:
    - name: "total_stock_on_hand"
      expr: SUM(CAST(stock_on_hand AS BIGINT))
      comment: "Total inventory units held by channel partners for channel inventory investment and availability - critical for supply chain and sales ops."
    - name: "partner_count"
      expr: COUNT(1)
      comment: "Total number of channel partners for channel breadth and coverage assessment."
    - name: "avg_sell_through_rate"
      expr: AVG(CAST(sell_through_rate AS DOUBLE))
      comment: "Average sell-through rate across partners - key channel velocity and demand health indicator for channel management."
    - name: "avg_weeks_of_supply"
      expr: AVG(CAST(weeks_of_supply AS DOUBLE))
      comment: "Average weeks of supply held by partners for channel inventory health and obsolescence risk - critical S&OP metric."
    - name: "avg_stock_per_partner"
      expr: AVG(CAST(stock_on_hand AS BIGINT))
      comment: "Average inventory per partner for stocking level benchmarking and partner capability."
    - name: "partners_with_inventory_reporting"
      expr: SUM(CASE WHEN inventory_reporting_obligation = TRUE THEN 1 ELSE 0 END)
      comment: "Number of partners with inventory reporting obligation for channel visibility coverage."
    - name: "partners_with_price_protection"
      expr: SUM(CASE WHEN price_protection_claims_allowed = TRUE THEN 1 ELSE 0 END)
      comment: "Number of partners eligible for price protection for pricing change financial exposure."
$$;