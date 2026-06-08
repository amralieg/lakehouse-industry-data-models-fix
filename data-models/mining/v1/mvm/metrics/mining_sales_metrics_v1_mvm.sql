-- Metric views for domain: sales | Business: Mining | Version: 1 | Generated on: 2026-05-05 14:14:10

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`sales_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core sales revenue and invoicing performance metrics. Tracks invoiced value, pricing realisation, settlement efficiency, and volume across the invoice lifecycle. Primary KPI surface for revenue management and commercial performance reporting."
  source: "`mining_ecm`.`sales`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the invoice (e.g. Draft, Issued, Settled, Disputed). Used to segment revenue by collection stage."
    - name: "price_currency"
      expr: price_currency
      comment: "Currency in which the invoice is denominated. Enables multi-currency revenue analysis."
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms governing delivery and risk transfer. Affects revenue recognition timing and logistics cost allocation."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Status of any price or quantity adjustment applied to the invoice. Identifies invoices subject to provisional-to-final price true-ups."
    - name: "quantity_unit"
      expr: quantity_unit
      comment: "Unit of measure for invoiced quantity (e.g. DMT, WMT). Required for volume aggregation consistency."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Calendar month of invoice issuance. Enables monthly revenue trend analysis."
    - name: "issue_date_year"
      expr: YEAR(issue_date)
      comment: "Calendar year of invoice issuance. Supports annual revenue reporting and year-on-year comparisons."
    - name: "shipment_date_month"
      expr: DATE_TRUNC('MONTH', shipment_date)
      comment: "Calendar month of the underlying shipment. Aligns revenue to physical delivery period."
    - name: "payment_due_date_month"
      expr: DATE_TRUNC('MONTH', payment_due_date)
      comment: "Month in which payment is contractually due. Used for cash flow forecasting and overdue analysis."
    - name: "quotational_period_start_month"
      expr: DATE_TRUNC('MONTH', quotational_period_start)
      comment: "Start month of the pricing quotational period. Used to align revenue to the pricing window for commodity price index analysis."
  measures:
    - name: "total_invoice_value_usd"
      expr: SUM(CAST(total_invoice_value AS DOUBLE))
      comment: "Total gross invoiced revenue across all invoices in scope. Primary top-line revenue KPI for commercial and executive reporting."
    - name: "total_invoiced_quantity"
      expr: SUM(CAST(invoiced_quantity AS DOUBLE))
      comment: "Total volume invoiced in the invoice unit of measure. Tracks shipped and billed tonnage against sales plan."
    - name: "avg_final_price_per_unit"
      expr: AVG(CAST(final_price AS DOUBLE))
      comment: "Average final realised price per unit across invoices. Measures price realisation quality versus benchmark and provisional price."
    - name: "avg_provisional_price_per_unit"
      expr: AVG(CAST(provisional_price AS DOUBLE))
      comment: "Average provisional price per unit at time of invoice issuance. Compared against final price to quantify provisional-to-final price adjustment exposure."
    - name: "total_adjustment_value"
      expr: SUM(CAST(adjustment_value AS DOUBLE))
      comment: "Total value of price and quantity adjustments applied to invoices. Quantifies the financial impact of provisional price true-ups and quality penalties."
    - name: "total_adjustment_quantity"
      expr: SUM(CAST(adjustment_quantity AS DOUBLE))
      comment: "Total quantity adjustment applied across invoices. Identifies systematic over- or under-invoicing of shipped volumes."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices. Used as denominator for per-invoice averages and to track invoicing activity volume."
    - name: "settled_invoice_count"
      expr: COUNT(CASE WHEN invoice_status = 'Settled' THEN 1 END)
      comment: "Number of invoices in Settled status. Tracks collection completion and cash conversion efficiency."
    - name: "avg_invoice_value_usd"
      expr: AVG(CAST(total_invoice_value AS DOUBLE))
      comment: "Average invoice value. Indicates average deal size and is used to detect anomalous invoices or pricing outliers."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`sales_cargo_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational shipment performance metrics covering shipped volumes, laytime efficiency, demurrage/despatch economics, and moisture management. Drives logistics cost control and shipping programme execution decisions."
  source: "`mining_ecm`.`sales`.`cargo_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the cargo shipment (e.g. Loading, Shipped, Discharged, Completed). Used to filter active versus completed shipments."
    - name: "port_of_loading_code"
      expr: port_of_loading_code
      comment: "Code of the port from which the cargo was loaded. Enables port-level throughput and cost analysis."
    - name: "port_of_discharge_code"
      expr: port_of_discharge_code
      comment: "Code of the destination discharge port. Supports trade lane and customer destination analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of shipment financial values. Required for multi-currency aggregation."
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of the shipping carrier. Enables carrier performance benchmarking on demurrage and laytime."
    - name: "bl_issue_date_month"
      expr: DATE_TRUNC('MONTH', bl_issue_date)
      comment: "Month of bill of lading issuance. Aligns shipment volumes to the commercial delivery month."
    - name: "bl_issue_date_year"
      expr: YEAR(bl_issue_date)
      comment: "Year of bill of lading issuance. Supports annual shipped volume and revenue reporting."
    - name: "documentary_credit_compliant_flag"
      expr: documentary_credit_compliant_flag
      comment: "Indicates whether the shipment documentation is compliant with letter of credit requirements. Non-compliant shipments risk payment delays."
  measures:
    - name: "total_shipped_quantity_wmt"
      expr: SUM(CAST(shipped_quantity_wmt AS DOUBLE))
      comment: "Total wet metric tonnes shipped. Primary volume KPI for the shipping programme and offtake agreement fulfilment tracking."
    - name: "total_net_dry_weight_dmt"
      expr: SUM(CAST(net_dry_weight_dmt AS DOUBLE))
      comment: "Total dry metric tonnes shipped after moisture deduction. The commercially binding quantity for pricing and revenue recognition."
    - name: "total_invoice_value_usd"
      expr: SUM(CAST(invoice_value_usd AS DOUBLE))
      comment: "Total invoiced value across shipments in USD. Tracks revenue generated from the shipping programme."
    - name: "total_demurrage_cost_usd"
      expr: SUM(CAST(demurrage_amount_usd AS DOUBLE))
      comment: "Total demurrage charges incurred across shipments. Demurrage is a direct cost of port and loading inefficiency — a key logistics cost KPI."
    - name: "total_despatch_earned_usd"
      expr: SUM(CAST(despatch_amount_usd AS DOUBLE))
      comment: "Total despatch credits earned for early vessel release. Offsets demurrage costs and reflects loading efficiency."
    - name: "total_insurance_cost_usd"
      expr: SUM(CAST(insurance_cost_usd AS DOUBLE))
      comment: "Total cargo insurance cost across shipments. Contributes to total cost of sales and is monitored for insurance programme optimisation."
    - name: "avg_moisture_content_percent"
      expr: AVG(CAST(moisture_content_percent AS DOUBLE))
      comment: "Average moisture content of shipped cargo. High moisture reduces net dry weight and therefore realised revenue — a critical quality and revenue KPI."
    - name: "avg_laytime_utilisation_percent"
      expr: ROUND(100.0 * AVG(CAST(laytime_used_hours AS DOUBLE)) / NULLIF(AVG(CAST(laytime_allowed_hours AS DOUBLE)), 0), 2)
      comment: "Average laytime utilisation as a percentage of allowed laytime. Values above 100% indicate demurrage risk; below 100% indicates efficient loading operations."
    - name: "total_laytime_used_hours"
      expr: SUM(CAST(laytime_used_hours AS DOUBLE))
      comment: "Total laytime hours consumed across all shipments. Aggregated input for demurrage exposure and port efficiency analysis."
    - name: "total_laytime_allowed_hours"
      expr: SUM(CAST(laytime_allowed_hours AS DOUBLE))
      comment: "Total contractually allowed laytime hours across all shipments. Denominator for fleet-level laytime utilisation calculations."
    - name: "shipment_count"
      expr: COUNT(1)
      comment: "Total number of cargo shipments. Used to normalise per-shipment cost and volume metrics."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`sales_commodity_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales order book metrics covering order value, volume, pricing, and fulfilment status. Provides the commercial pipeline view for revenue forecasting, order management, and offtake agreement utilisation tracking."
  source: "`mining_ecm`.`sales`.`commodity_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the commodity order (e.g. Confirmed, Pending, Cancelled, Completed). Segments the order book by lifecycle stage."
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order type (e.g. Spot, Term, Trial). Distinguishes contracted volume from spot market activity."
    - name: "delivery_terms"
      expr: delivery_terms
      comment: "Contractual delivery terms for the order. Affects revenue recognition and logistics cost allocation."
    - name: "price_currency"
      expr: price_currency
      comment: "Currency in which the order is priced. Required for multi-currency order book analysis."
    - name: "price_uom"
      expr: price_uom
      comment: "Unit of measure for the order price (e.g. USD/DMT). Ensures consistent price comparison across orders."
    - name: "quantity_uom"
      expr: quantity_uom
      comment: "Unit of measure for order quantity. Required for volume aggregation consistency."
    - name: "trade_date_month"
      expr: DATE_TRUNC('MONTH', trade_date)
      comment: "Month in which the order was traded/executed. Enables monthly order intake and revenue pipeline analysis."
    - name: "trade_date_year"
      expr: YEAR(trade_date)
      comment: "Year in which the order was traded. Supports annual order book and revenue trend reporting."
    - name: "delivery_window_start_month"
      expr: DATE_TRUNC('MONTH', delivery_window_start)
      comment: "Month of the order delivery window start. Used to align order volumes to planned shipment periods."
    - name: "lom_forecast_period"
      expr: lom_forecast_period
      comment: "Life-of-mine forecast period to which the order is aligned. Links commercial orders to long-term production planning."
  measures:
    - name: "total_order_value_usd"
      expr: SUM(CAST(order_value AS DOUBLE))
      comment: "Total value of all commodity orders. Represents the gross commercial pipeline and is the primary order book KPI for revenue forecasting."
    - name: "total_order_quantity"
      expr: SUM(CAST(order_quantity AS DOUBLE))
      comment: "Total volume across all commodity orders. Tracks committed sales volume against production plan and offtake agreement obligations."
    - name: "total_final_price_value"
      expr: SUM(CAST(final_price AS DOUBLE))
      comment: "Sum of final settled prices across orders. Used to compute realised revenue and compare against provisional pricing."
    - name: "avg_final_price_per_unit"
      expr: AVG(CAST(final_price AS DOUBLE))
      comment: "Average final price per unit across orders. Key commercial KPI for price realisation benchmarking against index prices."
    - name: "avg_provisional_price_per_unit"
      expr: AVG(CAST(provisional_price AS DOUBLE))
      comment: "Average provisional price per unit at order creation. Compared to final price to quantify pricing risk and provisional adjustment exposure."
    - name: "order_count"
      expr: COUNT(1)
      comment: "Total number of commodity orders. Used to normalise per-order metrics and track order intake velocity."
    - name: "confirmed_order_count"
      expr: COUNT(CASE WHEN order_status = 'Confirmed' THEN 1 END)
      comment: "Number of confirmed orders. Represents the firm order book and is used to assess revenue certainty."
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN order_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled orders. Elevated cancellation rates signal counterparty credit risk or market demand deterioration."
    - name: "avg_order_quantity"
      expr: AVG(CAST(order_quantity AS DOUBLE))
      comment: "Average order size by volume. Indicates typical shipment lot size and informs vessel and logistics planning."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`sales_offtake_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Offtake agreement portfolio metrics covering contracted volume, pricing terms, tenure, and agreement health. Provides strategic visibility into the long-term sales book, counterparty concentration, and revenue security."
  source: "`mining_ecm`.`sales`.`offtake_agreement`"
  dimensions:
    - name: "offtake_agreement_status"
      expr: offtake_agreement_status
      comment: "Current status of the offtake agreement (e.g. Active, Expired, Terminated, Pending). Segments the portfolio by commercial health."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of offtake agreement (e.g. Long-Term, Short-Term, Spot, Trial). Distinguishes revenue security profiles."
    - name: "pricing_mechanism"
      expr: pricing_mechanism
      comment: "Pricing mechanism used in the agreement (e.g. Index-linked, Fixed, Negotiated). Critical for revenue risk and hedging strategy."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the offtake agreement. Required for multi-currency portfolio analysis."
    - name: "delivery_basis"
      expr: delivery_basis
      comment: "Delivery basis (e.g. FOB, CIF, CFR). Determines cost and risk allocation between seller and buyer."
    - name: "loading_port"
      expr: loading_port
      comment: "Port of loading specified in the agreement. Enables port-level offtake volume and logistics planning."
    - name: "shipment_frequency"
      expr: shipment_frequency
      comment: "Agreed shipment frequency (e.g. Monthly, Quarterly). Informs logistics scheduling and cash flow timing."
    - name: "effective_date_year"
      expr: YEAR(effective_date)
      comment: "Year the agreement became effective. Used for vintage analysis of the offtake portfolio."
    - name: "expiry_date_year"
      expr: YEAR(expiry_date)
      comment: "Year the agreement expires. Critical for contract renewal pipeline management and revenue continuity planning."
    - name: "lom_alignment_flag"
      expr: lom_alignment_flag
      comment: "Indicates whether the agreement is aligned to the life-of-mine plan. Agreements not aligned to LOM represent potential volume commitment risk."
  measures:
    - name: "total_contracted_volume_tonnes"
      expr: SUM(CAST(contracted_volume_tonnes AS DOUBLE))
      comment: "Total volume committed under all offtake agreements. Primary measure of sales book coverage and revenue security."
    - name: "total_annual_volume_tonnes"
      expr: SUM(CAST(annual_volume_tonnes AS DOUBLE))
      comment: "Total annualised contracted volume across active agreements. Used for annual production planning and revenue forecasting alignment."
    - name: "avg_base_price_usd_per_tonne"
      expr: AVG(CAST(base_price_usd_per_tonne AS DOUBLE))
      comment: "Average base price per tonne across offtake agreements. Benchmarks the contracted price book against spot and index prices."
    - name: "avg_tenure_years"
      expr: AVG(CAST(tenure_years AS DOUBLE))
      comment: "Average agreement tenure in years. Longer average tenure indicates greater revenue security and lower re-contracting risk."
    - name: "total_max_shipment_size_tonnes"
      expr: SUM(CAST(maximum_shipment_size_tonnes AS DOUBLE))
      comment: "Sum of maximum shipment sizes across agreements. Indicates peak logistics capacity demand for vessel and port planning."
    - name: "avg_min_shipment_size_tonnes"
      expr: AVG(CAST(minimum_shipment_size_tonnes AS DOUBLE))
      comment: "Average minimum shipment size across agreements. Informs minimum lot size constraints for production and logistics scheduling."
    - name: "agreement_count"
      expr: COUNT(1)
      comment: "Total number of offtake agreements. Tracks portfolio breadth and counterparty diversification."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN offtake_agreement_status = 'Active' THEN 1 END)
      comment: "Number of currently active offtake agreements. Represents the live commercial book underpinning near-term revenue."
    - name: "quality_penalty_clause_count"
      expr: COUNT(CASE WHEN quality_penalty_clause = TRUE THEN 1 END)
      comment: "Number of agreements containing quality penalty clauses. Quantifies the proportion of the book exposed to quality-linked revenue deductions."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`sales_revenue_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue forecast accuracy and pipeline metrics. Tracks estimated revenue, forecast volume, price assumptions, and variance to prior forecasts. Supports board-level revenue guidance, budget management, and forecast quality governance."
  source: "`mining_ecm`.`sales`.`revenue_forecast`"
  dimensions:
    - name: "forecast_status"
      expr: forecast_status
      comment: "Current status of the revenue forecast (e.g. Draft, Approved, Superseded). Filters to approved forecasts for reporting."
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g. Budget, Latest Estimate, LOM). Distinguishes planning horizons and forecast purposes."
    - name: "forecast_confidence_level"
      expr: forecast_confidence_level
      comment: "Confidence level assigned to the forecast (e.g. High, Medium, Low). Used to risk-weight revenue pipeline in executive reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the forecast period. Primary time dimension for annual revenue planning and board reporting."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the forecast period. Enables quarterly revenue guidance and variance analysis."
    - name: "pricing_mechanism"
      expr: pricing_mechanism
      comment: "Pricing mechanism assumed in the forecast (e.g. Index-linked, Fixed). Affects revenue sensitivity to commodity price movements."
    - name: "revenue_currency_code"
      expr: revenue_currency_code
      comment: "Currency of the forecast revenue. Required for multi-currency consolidation and FX sensitivity analysis."
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterm assumed in the forecast. Affects revenue recognition basis and cost allocation."
    - name: "board_reporting_flag"
      expr: board_reporting_flag
      comment: "Indicates whether the forecast is included in board reporting. Filters to board-quality forecasts for executive dashboards."
    - name: "forecast_period_start_month"
      expr: DATE_TRUNC('MONTH', forecast_period_start_date)
      comment: "Start month of the forecast period. Enables time-series analysis of forecast evolution."
    - name: "shipment_destination_region"
      expr: shipment_destination_region
      comment: "Geographic region of the forecast shipment destination. Supports regional revenue mix and market exposure analysis."
  measures:
    - name: "total_estimated_revenue_amount"
      expr: SUM(CAST(estimated_revenue_amount AS DOUBLE))
      comment: "Total estimated revenue across all forecasts in scope. Primary top-line revenue forecast KPI for board and executive reporting."
    - name: "total_forecast_volume_tonnes"
      expr: SUM(CAST(forecast_volume_tonnes AS DOUBLE))
      comment: "Total forecast sales volume in tonnes. Tracks planned production-to-sales conversion and offtake agreement coverage."
    - name: "avg_assumed_benchmark_price"
      expr: AVG(CAST(assumed_benchmark_price AS DOUBLE))
      comment: "Average benchmark price assumed in revenue forecasts. Compared against actual market prices to assess forecast price risk."
    - name: "total_risk_adjustment_amount"
      expr: SUM(CAST(risk_adjustment_amount AS DOUBLE))
      comment: "Total risk adjustment applied to forecast revenue. Quantifies the downside revenue buffer built into the forecast for uncertainty."
    - name: "total_variance_to_prior_forecast"
      expr: SUM(CAST(variance_to_prior_forecast_amount AS DOUBLE))
      comment: "Total revenue variance versus the prior forecast version. Tracks forecast stability and identifies drivers of revenue guidance changes."
    - name: "avg_variance_to_prior_forecast_pct"
      expr: AVG(CAST(variance_to_prior_forecast_percentage AS DOUBLE))
      comment: "Average percentage variance to prior forecast. Measures forecast accuracy and revision magnitude — a key forecast quality governance KPI."
    - name: "avg_price_adjustment_factor"
      expr: AVG(CAST(price_adjustment_factor AS DOUBLE))
      comment: "Average price adjustment factor applied in forecasts. Reflects quality premiums or penalties assumed in the revenue model."
    - name: "forecast_count"
      expr: COUNT(1)
      comment: "Total number of revenue forecast records. Used to track forecast versioning activity and governance compliance."
    - name: "board_reported_forecast_count"
      expr: COUNT(CASE WHEN board_reporting_flag = TRUE THEN 1 END)
      comment: "Number of forecasts included in board reporting. Ensures board-quality forecast coverage across all planning periods."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`sales_offtake_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Offtake schedule execution metrics covering scheduled versus actual volumes, revenue scheduling, and fulfilment performance. Drives shipping programme management, volume variance monitoring, and offtake agreement compliance."
  source: "`mining_ecm`.`sales`.`offtake_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the offtake schedule entry (e.g. Planned, Confirmed, Completed, Cancelled). Segments the schedule by execution stage."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfilment status of the scheduled lifting (e.g. Fulfilled, Partially Fulfilled, Unfulfilled). Key KPI for offtake agreement compliance."
    - name: "schedule_year"
      expr: schedule_year
      comment: "Year of the scheduled lifting. Primary time dimension for annual volume planning and offtake agreement utilisation."
    - name: "schedule_quarter"
      expr: schedule_quarter
      comment: "Quarter of the scheduled lifting. Enables quarterly volume and revenue scheduling analysis."
    - name: "schedule_month"
      expr: schedule_month
      comment: "Month of the scheduled lifting. Supports monthly shipping programme management."
    - name: "pricing_mechanism"
      expr: pricing_mechanism
      comment: "Pricing mechanism for the scheduled lifting. Distinguishes index-linked from fixed-price schedule entries."
    - name: "port_of_loading"
      expr: port_of_loading
      comment: "Port from which the scheduled cargo will be loaded. Enables port-level throughput planning."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Country code of the scheduled cargo destination. Supports trade lane and market destination analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the scheduled revenue. Required for multi-currency schedule analysis."
    - name: "lom_alignment_flag"
      expr: lom_alignment_flag
      comment: "Indicates whether the schedule entry is aligned to the life-of-mine plan. Misaligned entries represent potential volume commitment risk."
    - name: "scheduled_lifting_date_month"
      expr: DATE_TRUNC('MONTH', scheduled_lifting_date)
      comment: "Month of the scheduled lifting date. Used for monthly shipping programme and cash flow scheduling."
  measures:
    - name: "total_scheduled_volume_tonnes"
      expr: SUM(CAST(scheduled_volume_tonnes AS DOUBLE))
      comment: "Total volume scheduled for lifting across all schedule entries. Primary volume planning KPI for the shipping programme."
    - name: "total_scheduled_revenue_amount"
      expr: SUM(CAST(scheduled_revenue_amount AS DOUBLE))
      comment: "Total revenue scheduled across all offtake schedule entries. Forward-looking revenue pipeline KPI for cash flow and budget management."
    - name: "avg_scheduled_price_per_tonne"
      expr: AVG(CAST(scheduled_price_per_tonne AS DOUBLE))
      comment: "Average scheduled price per tonne. Benchmarks the forward price book against current market indices."
    - name: "total_volume_variance_tonnes"
      expr: SUM(CAST(volume_variance_tonnes AS DOUBLE))
      comment: "Total volume variance between scheduled and actual liftings. Quantifies offtake agreement under- or over-performance."
    - name: "avg_tolerance_percentage"
      expr: AVG(CAST(tolerance_percentage AS DOUBLE))
      comment: "Average volume tolerance percentage across schedule entries. Indicates the contractual flexibility buffer in the shipping programme."
    - name: "schedule_entry_count"
      expr: COUNT(1)
      comment: "Total number of offtake schedule entries. Used to track scheduling activity and programme density."
    - name: "fulfilled_lifting_count"
      expr: COUNT(CASE WHEN fulfillment_status = 'Fulfilled' THEN 1 END)
      comment: "Number of fully fulfilled scheduled liftings. Measures offtake agreement execution reliability."
    - name: "unfulfilled_lifting_count"
      expr: COUNT(CASE WHEN fulfillment_status = 'Unfulfilled' THEN 1 END)
      comment: "Number of unfulfilled scheduled liftings. Elevated counts signal production shortfalls or logistics failures with potential contractual penalty exposure."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`sales_provisional_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provisional price adjustment metrics tracking the financial impact of provisional-to-final price true-ups, assay adjustments, and settlement timing. Critical for revenue accuracy, working capital management, and pricing risk governance."
  source: "`mining_ecm`.`sales`.`provisional_adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of provisional adjustment (e.g. Price, Quantity, Assay). Categorises the source of revenue true-up."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment (e.g. Pending, Approved, Settled). Tracks the adjustment lifecycle."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the adjustment (e.g. Unpaid, Paid, Overdue). Used for cash collection and working capital monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the adjustment. Required for multi-currency adjustment portfolio analysis."
    - name: "commodity_code"
      expr: commodity_code
      comment: "Commodity to which the adjustment relates. Enables commodity-level pricing risk analysis."
    - name: "assay_adjustment_applied"
      expr: assay_adjustment_applied
      comment: "Indicates whether an assay-based adjustment was applied. Assay adjustments reflect quality differences between provisional and final analysis."
    - name: "adjustment_invoice_date_month"
      expr: DATE_TRUNC('MONTH', adjustment_invoice_date)
      comment: "Month of the adjustment invoice. Aligns adjustment cash flows to the accounting period."
    - name: "quotational_period_start_month"
      expr: DATE_TRUNC('MONTH', quotational_period_start)
      comment: "Start month of the quotational period for the adjustment. Links price adjustments to the commodity price index window."
    - name: "settlement_date_month"
      expr: DATE_TRUNC('MONTH', settlement_date)
      comment: "Month of adjustment settlement. Used for cash flow timing and working capital analysis."
  measures:
    - name: "total_adjustment_value"
      expr: SUM(CAST(adjustment_value AS DOUBLE))
      comment: "Total financial value of all provisional adjustments. Quantifies the aggregate revenue true-up from provisional to final pricing — a key revenue accuracy KPI."
    - name: "total_price_difference"
      expr: SUM(CAST(price_difference AS DOUBLE))
      comment: "Total price difference between provisional and final prices across adjustments. Measures the magnitude of pricing risk materialised in the period."
    - name: "total_adjustment_quantity"
      expr: SUM(CAST(adjustment_quantity AS DOUBLE))
      comment: "Total quantity subject to provisional adjustment. Identifies the volume exposure to pricing true-ups."
    - name: "avg_final_price"
      expr: AVG(CAST(final_price AS DOUBLE))
      comment: "Average final settled price across adjustments. Compared to provisional price to assess systematic pricing bias."
    - name: "avg_provisional_price"
      expr: AVG(CAST(provisional_price AS DOUBLE))
      comment: "Average provisional price at time of initial invoicing. Baseline for measuring provisional-to-final price movement."
    - name: "adjustment_count"
      expr: COUNT(1)
      comment: "Total number of provisional adjustments. High counts indicate active price finalisation activity or elevated pricing uncertainty."
    - name: "pending_adjustment_count"
      expr: COUNT(CASE WHEN adjustment_status = 'Pending' THEN 1 END)
      comment: "Number of adjustments still pending approval or settlement. Represents open revenue exposure requiring resolution."
    - name: "assay_adjusted_count"
      expr: COUNT(CASE WHEN assay_adjustment_applied = TRUE THEN 1 END)
      comment: "Number of adjustments where an assay-based correction was applied. Tracks the frequency of quality-driven revenue adjustments."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`sales_quality_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product quality metrics derived from quality certificates. Tracks iron content, moisture, impurity levels, and quality penalty deductions across shipments. Drives quality management, penalty exposure monitoring, and product specification compliance."
  source: "`mining_ecm`.`sales`.`quality_certificate`"
  dimensions:
    - name: "certificate_status"
      expr: certificate_status
      comment: "Current status of the quality certificate (e.g. Issued, Disputed, Superseded). Filters to valid certificates for quality analysis."
    - name: "certificate_type"
      expr: certificate_type
      comment: "Type of quality certificate (e.g. Loading, Discharge, Umpire). Distinguishes loading-port from discharge-port quality determinations."
    - name: "issuing_laboratory_name"
      expr: issuing_laboratory_name
      comment: "Name of the laboratory that issued the certificate. Enables laboratory performance and accreditation benchmarking."
    - name: "loading_port"
      expr: loading_port
      comment: "Port of loading for the certified shipment. Enables port-level quality analysis."
    - name: "discharge_port"
      expr: discharge_port
      comment: "Port of discharge for the certified shipment. Supports destination-level quality comparison."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the quality certificate is under dispute. Disputed certificates represent revenue risk and potential contractual claims."
    - name: "sampling_method"
      expr: sampling_method
      comment: "Method used to collect the quality sample. Affects the reliability and contractual standing of the quality determination."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month of certificate issuance. Enables monthly quality trend analysis aligned to the shipping programme."
    - name: "issue_date_year"
      expr: YEAR(issue_date)
      comment: "Year of certificate issuance. Supports annual quality performance reporting."
  measures:
    - name: "avg_iron_content_percent"
      expr: AVG(CAST(iron_content_percent AS DOUBLE))
      comment: "Average iron content percentage across certified shipments. Primary product quality KPI — directly drives price realisation for iron ore."
    - name: "avg_moisture_content_percent"
      expr: AVG(CAST(moisture_content_percent AS DOUBLE))
      comment: "Average moisture content percentage. High moisture reduces net dry weight and realised revenue — a critical quality and commercial KPI."
    - name: "avg_alumina_content_percent"
      expr: AVG(CAST(alumina_content_percent AS DOUBLE))
      comment: "Average alumina content percentage. Alumina is a key impurity that attracts price penalties in iron ore sales contracts."
    - name: "avg_silica_content_percent"
      expr: AVG(CAST(silica_content_percent AS DOUBLE))
      comment: "Average silica content percentage. Silica is a primary impurity driving quality penalties and customer blending decisions."
    - name: "avg_phosphorus_content_percent"
      expr: AVG(CAST(phosphorus_content_percent AS DOUBLE))
      comment: "Average phosphorus content percentage. Phosphorus is a critical steel-making impurity with strict contractual limits and penalty thresholds."
    - name: "avg_sulfur_content_percent"
      expr: AVG(CAST(sulfur_content_percent AS DOUBLE))
      comment: "Average sulfur content percentage. Sulfur is a regulated impurity in metallurgical products with direct penalty implications."
    - name: "total_penalty_deduction_amount"
      expr: SUM(CAST(penalty_deduction_amount AS DOUBLE))
      comment: "Total quality penalty deductions across all certificates. Directly reduces realised revenue — a key commercial and quality management KPI."
    - name: "total_shipment_quantity_tonnes"
      expr: SUM(CAST(shipment_quantity_tonnes AS DOUBLE))
      comment: "Total certified shipment quantity in tonnes. Provides the quality-certified volume base for revenue and quality analysis."
    - name: "avg_price_adjustment_factor"
      expr: AVG(CAST(price_adjustment_factor AS DOUBLE))
      comment: "Average price adjustment factor applied based on quality. Values below 1.0 indicate systematic quality-driven revenue discounts."
    - name: "disputed_certificate_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of quality certificates under dispute. Elevated counts signal quality determination conflicts with revenue and contractual risk implications."
    - name: "certificate_count"
      expr: COUNT(1)
      comment: "Total number of quality certificates. Used to normalise per-certificate quality metrics and track certification activity."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`sales_volume_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales volume planning metrics covering planned volumes, revenue forecasts, offtake coverage, and pricing assumptions. Supports annual and life-of-mine sales planning, budget setting, and offtake agreement coverage analysis."
  source: "`mining_ecm`.`sales`.`volume_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the volume plan (e.g. Draft, Approved, Superseded). Filters to approved plans for reporting."
    - name: "plan_year"
      expr: plan_year
      comment: "Year of the volume plan. Primary time dimension for annual sales volume planning."
    - name: "plan_quarter"
      expr: plan_quarter
      comment: "Quarter of the volume plan. Enables quarterly volume and revenue planning analysis."
    - name: "pricing_mechanism"
      expr: pricing_mechanism
      comment: "Pricing mechanism assumed in the plan (e.g. Index-linked, Fixed). Affects revenue sensitivity assumptions."
    - name: "delivery_basis"
      expr: delivery_basis
      comment: "Delivery basis assumed in the plan (e.g. FOB, CIF). Determines cost and revenue recognition basis."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Target destination country for planned volumes. Supports market mix and trade lane planning."
    - name: "target_market"
      expr: target_market
      comment: "Target market segment for the planned volume. Enables market-level volume and revenue planning."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment targeted by the volume plan. Supports customer portfolio and revenue mix analysis."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category assigned to the volume plan. Used to risk-weight planned revenue in executive reporting."
    - name: "logistics_mode"
      expr: logistics_mode
      comment: "Logistics mode for planned shipments (e.g. Vessel, Rail, Truck). Informs logistics capacity planning."
    - name: "plan_effective_date_year"
      expr: YEAR(plan_effective_date)
      comment: "Year the volume plan became effective. Used for plan vintage analysis."
  measures:
    - name: "total_planned_volume_tonnes"
      expr: SUM(CAST(planned_volume_tonnes AS DOUBLE))
      comment: "Total planned sales volume in tonnes. Primary volume planning KPI linking production schedule to sales commitments."
    - name: "total_revenue_forecast_amount"
      expr: SUM(CAST(revenue_forecast_amount AS DOUBLE))
      comment: "Total forecast revenue from volume plans. Forward-looking revenue KPI for budget and board reporting."
    - name: "avg_planned_price_per_tonne"
      expr: AVG(CAST(planned_price_per_tonne AS DOUBLE))
      comment: "Average planned price per tonne across volume plans. Benchmarks the planned price book against market indices and offtake agreement prices."
    - name: "avg_offtake_coverage_percentage"
      expr: AVG(CAST(offtake_coverage_percentage AS DOUBLE))
      comment: "Average offtake agreement coverage percentage of planned volume. Measures the proportion of planned production backed by contracted sales — a key revenue security KPI."
    - name: "avg_variance_tolerance_percentage"
      expr: AVG(CAST(variance_tolerance_percentage AS DOUBLE))
      comment: "Average volume variance tolerance percentage in plans. Indicates the flexibility buffer built into the sales plan."
    - name: "volume_plan_count"
      expr: COUNT(1)
      comment: "Total number of volume plan records. Used to track planning activity and version management."
    - name: "approved_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'Approved' THEN 1 END)
      comment: "Number of approved volume plans. Ensures planning governance — only approved plans should drive production and logistics commitments."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`sales_benchmark_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity benchmark price metrics tracking market price levels, volatility, and trading volumes. Supports pricing strategy, contract benchmarking, and commodity price risk management."
  source: "`mining_ecm`.`sales`.`benchmark_price`"
  dimensions:
    - name: "price_type"
      expr: price_type
      comment: "Type of benchmark price (e.g. Spot, Forward, Settlement). Distinguishes price series for different commercial applications."
    - name: "index_status"
      expr: index_status
      comment: "Status of the price index (e.g. Active, Discontinued). Filters to active indices for current pricing analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the benchmark price. Required for multi-currency price comparison."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the benchmark price (e.g. USD/DMT, USD/lb). Ensures consistent price comparison across commodities."
    - name: "delivery_basis"
      expr: delivery_basis
      comment: "Delivery basis of the benchmark price (e.g. FOB, CFR). Affects comparability of price series."
    - name: "delivery_location"
      expr: delivery_location
      comment: "Delivery location for the benchmark price. Enables location-specific price analysis and basis risk assessment."
    - name: "publication_frequency"
      expr: publication_frequency
      comment: "Frequency of price publication (e.g. Daily, Weekly, Monthly). Affects the granularity of price trend analysis."
    - name: "price_date_month"
      expr: DATE_TRUNC('MONTH', price_date)
      comment: "Month of the benchmark price observation. Primary time dimension for monthly price trend analysis."
    - name: "price_date_year"
      expr: YEAR(price_date)
      comment: "Year of the benchmark price observation. Supports annual price trend and cycle analysis."
    - name: "assessment_methodology"
      expr: assessment_methodology
      comment: "Methodology used to assess the benchmark price. Affects the reliability and contractual applicability of the price series."
  measures:
    - name: "avg_price_value"
      expr: AVG(CAST(price_value AS DOUBLE))
      comment: "Average benchmark price value. Primary market price KPI for contract benchmarking and pricing strategy decisions."
    - name: "avg_price_close"
      expr: AVG(CAST(price_close AS DOUBLE))
      comment: "Average closing benchmark price. Used for period-end price reporting and settlement price calculations."
    - name: "avg_price_high"
      expr: AVG(CAST(price_high AS DOUBLE))
      comment: "Average high price across the period. Indicates the upper bound of price realisation potential."
    - name: "avg_price_low"
      expr: AVG(CAST(price_low AS DOUBLE))
      comment: "Average low price across the period. Indicates the lower bound of price risk exposure."
    - name: "total_volume_traded"
      expr: SUM(CAST(volume_traded AS DOUBLE))
      comment: "Total volume traded at the benchmark price. Indicates market liquidity and the reliability of the price signal."
    - name: "price_observation_count"
      expr: COUNT(1)
      comment: "Total number of benchmark price observations. Used to assess data completeness and price series continuity."
$$;