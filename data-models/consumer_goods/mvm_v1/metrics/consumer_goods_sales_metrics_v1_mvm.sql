-- Metric views for domain: sales | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 10:59:38

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`sales_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core sales order performance metrics covering revenue, margin, discounting, and order fulfilment efficiency. Primary KPI surface for sales leadership and finance reviews."
  source: "`consumer_goods_ecm`.`sales`.`order`"
  dimensions:
    - name: "order_date"
      expr: order_date
      comment: "Calendar date the order was placed, used for time-series trending of order volume and revenue."
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the order (e.g. Open, Confirmed, Shipped, Cancelled) for pipeline and fulfilment analysis."
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order (e.g. Standard, Rush, Sample) to segment revenue and margin by order type."
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel through which the order was placed (e.g. DSD, Warehouse, E-Commerce) for channel-mix analysis."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel code associated with the order, enabling channel-level revenue and margin reporting."
    - name: "division"
      expr: division
      comment: "Business division responsible for the order, supporting divisional P&L reporting."
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organisation unit that owns the order, used for regional and organisational performance segmentation."
    - name: "otif_status"
      expr: otif_status
      comment: "On-Time In-Full delivery status flag for the order, used to measure fulfilment compliance."
    - name: "order_source"
      expr: order_source
      comment: "Origin system or channel that generated the order (e.g. EDI, Web, Field Sales) for source-mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the order is denominated, required for multi-currency revenue reporting."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed for the order, used in cash-flow and working-capital analysis."
    - name: "priority"
      expr: priority
      comment: "Order priority level (e.g. High, Normal, Low) to assess urgency distribution and service-level adherence."
  measures:
    - name: "total_order_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross revenue across all orders. Primary top-line revenue KPI for sales performance reviews and executive dashboards."
    - name: "total_gross_margin"
      expr: SUM(CAST(gross_margin_amount AS DOUBLE))
      comment: "Total gross margin dollars generated from orders. Directly measures profitability and is a core steering metric for pricing and trade investment decisions."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value granted across orders. Tracks discounting exposure and informs pricing strategy and trade spend governance."
    - name: "total_cogs"
      expr: SUM(CAST(cogs_amount AS DOUBLE))
      comment: "Total cost of goods sold across orders. Used alongside gross margin to assess product-level profitability and manufacturing efficiency."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight and logistics cost charged on orders. Monitors supply chain cost efficiency and informs logistics network decisions."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across orders. Required for financial compliance reporting and tax liability management."
    - name: "order_count"
      expr: COUNT(DISTINCT order_id)
      comment: "Count of distinct orders placed. Baseline volume KPI used to compute average order value and track sales activity levels."
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average revenue per order. A compound KPI that signals pricing power, mix shift, and upsell effectiveness — tracked closely by commercial leadership."
    - name: "avg_gross_margin_per_order"
      expr: AVG(CAST(gross_margin_amount AS DOUBLE))
      comment: "Average gross margin dollars per order. Enables margin-per-transaction benchmarking across channels, customers, and periods."
    - name: "avg_discount_per_order"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount granted per order. Highlights discounting intensity and supports pricing discipline governance."
    - name: "cancelled_order_count"
      expr: COUNT(DISTINCT CASE WHEN order_status = 'Cancelled' THEN order_id END)
      comment: "Count of cancelled orders. A key operational risk metric — high cancellation rates signal demand volatility, supply issues, or customer dissatisfaction."
    - name: "otif_compliant_order_count"
      expr: COUNT(DISTINCT CASE WHEN otif_status = 'OTIF' THEN order_id END)
      comment: "Count of orders delivered On-Time In-Full. Numerator for OTIF rate calculation; directly tied to customer service level agreements and retailer scorecards."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`sales_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice-level financial performance metrics covering billed revenue, collections, outstanding receivables, trade discounts, and margin. Essential for AR management, revenue recognition, and financial close processes."
  source: "`consumer_goods_ecm`.`sales`.`invoice`"
  dimensions:
    - name: "invoice_date"
      expr: invoice_date
      comment: "Date the invoice was issued, used for revenue recognition timing and period-over-period billing trend analysis."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g. Open, Paid, Disputed, Cancelled) for AR ageing and collections management."
    - name: "billing_type"
      expr: billing_type
      comment: "Type of billing document (e.g. Standard Invoice, Credit Memo, Debit Memo) to segment revenue and adjustments."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment collection status (e.g. Paid, Partially Paid, Overdue) for cash flow and DSO analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment used (e.g. EFT, Cheque, Credit Card) to analyse payment channel mix and processing costs."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice for multi-currency revenue and AR reporting."
    - name: "distribution_channel_code"
      expr: distribution_channel_code
      comment: "Distribution channel associated with the invoice for channel-level revenue and margin analysis."
    - name: "division_code"
      expr: division_code
      comment: "Business division code on the invoice for divisional P&L and revenue attribution."
    - name: "sales_organization_code"
      expr: sales_organization_code
      comment: "Sales organisation that issued the invoice, used for regional and organisational revenue reporting."
    - name: "revenue_recognition_category"
      expr: revenue_recognition_category
      comment: "Revenue recognition classification (e.g. Point-in-Time, Over-Time) required for ASC 606 / IFRS 15 compliance reporting."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Boolean flag indicating whether the invoice is under dispute. Used to segment disputed vs. clean AR for collections prioritisation."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms code on the invoice (e.g. Net 30, Net 60) for working capital and DSO segmentation."
  measures:
    - name: "total_gross_billed_revenue"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross billed revenue across all invoices. Top-line revenue KPI for financial reporting and period-close reconciliation."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net revenue after trade discounts and allowances. The primary revenue line used in P&L reporting and executive dashboards."
    - name: "total_gross_margin"
      expr: SUM(CAST(gross_margin_amount AS DOUBLE))
      comment: "Total gross margin dollars on invoiced sales. Core profitability KPI linking revenue to cost of goods sold."
    - name: "total_cogs"
      expr: SUM(CAST(cost_of_goods_sold_amount AS DOUBLE))
      comment: "Total cost of goods sold on invoiced transactions. Used with gross margin to assess product and channel profitability."
    - name: "total_trade_discount"
      expr: SUM(CAST(trade_discount_amount AS DOUBLE))
      comment: "Total trade discount and allowance value deducted from gross revenue. Tracks trade investment efficiency and net revenue realisation."
    - name: "total_outstanding_ar"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total accounts receivable outstanding across open invoices. Critical liquidity and working capital KPI monitored by CFO and treasury."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total cash collected against invoices. Measures collections effectiveness and cash conversion performance."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount billed on invoices. Required for tax compliance reporting and liability reconciliation."
    - name: "total_freight_charges"
      expr: SUM(CAST(freight_charge_amount AS DOUBLE))
      comment: "Total freight charges billed to customers. Monitors logistics cost pass-through and freight revenue contribution."
    - name: "invoice_count"
      expr: COUNT(DISTINCT invoice_id)
      comment: "Count of distinct invoices issued. Baseline billing volume metric used to compute average invoice value and billing frequency."
    - name: "disputed_invoice_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_flag = TRUE THEN invoice_id END)
      comment: "Count of invoices currently under dispute. High dispute counts signal pricing, delivery, or quality issues requiring commercial intervention."
    - name: "avg_net_invoice_value"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net revenue per invoice. Compound KPI indicating transaction size trends and customer order behaviour."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`sales_return_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return order metrics covering return volume, return value, credit memo issuance, and return reason analysis. Directly informs product quality, customer satisfaction, and net revenue management."
  source: "`consumer_goods_ecm`.`sales`.`order`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the return transaction for multi-currency financial reporting."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel through which the original sale and return occurred, for channel-level return rate analysis."
    - name: "division"
      expr: division
      comment: "Business division associated with the return for divisional return rate and cost reporting."
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organisation responsible for the return, used for regional return performance benchmarking."
  measures:
    - name: "Row Count"
      expr: COUNT(1)
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales pipeline and opportunity management metrics covering pipeline value, win/loss performance, forecast accuracy, and conversion efficiency. Core CRM KPI surface for sales leadership and revenue forecasting."
  source: "`consumer_goods_ecm`.`sales`.`opportunity`"
  dimensions:
    - name: "stage"
      expr: stage
      comment: "Current pipeline stage of the opportunity (e.g. Prospecting, Proposal, Negotiation, Closed Won) for funnel analysis."
    - name: "opportunity_type"
      expr: opportunity_type
      comment: "Type of opportunity (e.g. New Business, Expansion, Renewal) to segment pipeline by growth driver."
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel associated with the opportunity for channel-level pipeline and win-rate analysis."
    - name: "forecast_category"
      expr: forecast_category
      comment: "Forecast classification (e.g. Commit, Best Case, Pipeline) used in revenue forecasting and sales planning."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the opportunity for annual pipeline and quota attainment reporting."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the opportunity for quarterly business review pipeline analysis."
    - name: "lead_source"
      expr: lead_source
      comment: "Origin of the sales lead (e.g. Marketing Campaign, Field Sales, Referral) to measure lead generation ROI."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the opportunity value for multi-currency pipeline reporting."
    - name: "jbp_alignment_flag"
      expr: jbp_alignment_flag
      comment: "Boolean flag indicating whether the opportunity is aligned to a Joint Business Plan with the customer. Used to prioritise strategic account opportunities."
    - name: "expected_close_date"
      expr: expected_close_date
      comment: "Expected date the opportunity will close, used for pipeline timing and cash flow forecasting."
  measures:
    - name: "total_pipeline_value"
      expr: SUM(CAST(estimated_annual_revenue AS DOUBLE))
      comment: "Total estimated annual revenue across all open opportunities. The primary pipeline value KPI used in sales forecasting and executive revenue planning."
    - name: "total_weighted_pipeline_value"
      expr: SUM(CAST(estimated_annual_revenue AS DOUBLE) * CAST(probability_percentage AS DOUBLE) / 100.0)
      comment: "Probability-weighted pipeline value. A compound KPI that adjusts raw pipeline for close likelihood — the standard metric for revenue forecast accuracy and sales planning."
    - name: "total_estimated_acv_gain"
      expr: SUM(CAST(estimated_acv_gain AS DOUBLE))
      comment: "Total estimated All Commodity Volume gain from opportunities. Tracks distribution expansion potential and is a key metric for category and trade marketing teams."
    - name: "opportunity_count"
      expr: COUNT(DISTINCT opportunity_id)
      comment: "Count of distinct opportunities in the pipeline. Baseline volume metric for pipeline coverage and sales activity analysis."
    - name: "won_opportunity_count"
      expr: COUNT(DISTINCT CASE WHEN stage = 'Closed Won' THEN opportunity_id END)
      comment: "Count of opportunities closed as won. Numerator for win rate calculation — directly measures sales effectiveness and competitive performance."
    - name: "lost_opportunity_count"
      expr: COUNT(DISTINCT CASE WHEN stage = 'Closed Lost' THEN opportunity_id END)
      comment: "Count of opportunities closed as lost. Used with won count to compute win rate and analyse competitive displacement patterns."
    - name: "avg_probability_percentage"
      expr: AVG(CAST(probability_percentage AS DOUBLE))
      comment: "Average close probability across open opportunities. Indicates overall pipeline health and sales confidence — a leading indicator of forecast accuracy."
    - name: "avg_estimated_annual_revenue"
      expr: AVG(CAST(estimated_annual_revenue AS DOUBLE))
      comment: "Average estimated annual revenue per opportunity. Measures deal size trends and informs sales capacity planning and territory design."
    - name: "won_revenue_value"
      expr: SUM(CASE WHEN stage = 'Closed Won' THEN CAST(estimated_annual_revenue AS DOUBLE) ELSE 0 END)
      comment: "Total estimated annual revenue from won opportunities. Measures realised pipeline conversion value and is a core sales performance KPI."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`sales_quota`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales quota and target management metrics covering quota value, attainment benchmarking, and incentive compensation inputs. Used by sales operations and finance to govern sales performance and commission calculations."
  source: "`consumer_goods_ecm`.`sales`.`quota`"
  dimensions:
    - name: "quota_type"
      expr: quota_type
      comment: "Type of quota (e.g. Revenue, Volume, TDP) to segment performance targets by KPI category."
    - name: "period_type"
      expr: period_type
      comment: "Time period granularity of the quota (e.g. Monthly, Quarterly, Annual) for period-appropriate attainment reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the quota for annual target-setting and year-over-year quota growth analysis."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the quota for quarterly business review attainment reporting."
    - name: "fiscal_month"
      expr: fiscal_month
      comment: "Fiscal month of the quota for monthly sales performance and commission calculation cycles."
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel associated with the quota for channel-level target and attainment analysis."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel of the quota for granular channel performance benchmarking."
    - name: "division"
      expr: division
      comment: "Business division of the quota for divisional target and attainment reporting."
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organisation associated with the quota for regional performance management."
    - name: "quota_status"
      expr: quota_status
      comment: "Approval and activation status of the quota (e.g. Draft, Approved, Active) for quota governance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the quota value for multi-currency target management."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment the quota is assigned to, enabling segment-level target and attainment analysis."
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the quota period for time-based filtering and period-over-period comparisons."
  measures:
    - name: "total_quota_value"
      expr: SUM(CAST(quota_value AS DOUBLE))
      comment: "Total quota value assigned across all quota records. The primary target-setting KPI used in sales planning, territory design, and executive goal-setting."
    - name: "total_stretch_target"
      expr: SUM(CAST(stretch_target AS DOUBLE))
      comment: "Total stretch target value across quotas. Measures the upside ambition built into the sales plan and informs incentive compensation design."
    - name: "total_minimum_threshold"
      expr: SUM(CAST(minimum_threshold AS DOUBLE))
      comment: "Total minimum performance threshold across quotas. Defines the floor for commission eligibility and is used in compensation plan governance."
    - name: "avg_quota_value"
      expr: AVG(CAST(quota_value AS DOUBLE))
      comment: "Average quota value per quota record. Used to benchmark quota equity across reps, territories, and channels."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across active quotas. Monitors incentive compensation cost and ensures alignment with margin targets."
    - name: "avg_accelerator_rate"
      expr: AVG(CAST(accelerator_rate AS DOUBLE))
      comment: "Average accelerator rate for above-quota performance. Tracks the generosity of upside incentives and their potential cost to the business."
    - name: "quota_record_count"
      expr: COUNT(DISTINCT quota_id)
      comment: "Count of distinct quota records. Baseline metric for quota coverage — ensures all reps and territories have active targets assigned."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`sales_distribution_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution point metrics covering product availability, pricing compliance, planogram adherence, and distribution breadth. Core KPIs for category management, trade marketing, and field sales execution."
  source: "`consumer_goods_ecm`.`sales`.`distribution_point`"
  dimensions:
    - name: "distribution_status"
      expr: distribution_status
      comment: "Current distribution status of the SKU at the store (e.g. Active, Delisted, Pending) for availability and range management."
    - name: "channel_type"
      expr: channel_type
      comment: "Retail channel type (e.g. Grocery, Drug, Mass, E-Commerce) for channel-level distribution and pricing analysis."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel code for granular channel-level distribution breadth reporting."
    - name: "geographic_market"
      expr: geographic_market
      comment: "Geographic market of the distribution point for regional distribution coverage and market penetration analysis."
    - name: "division"
      expr: division
      comment: "Business division responsible for the distribution point for divisional distribution performance reporting."
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organisation managing the distribution point for regional execution accountability."
    - name: "osa_status"
      expr: osa_status
      comment: "On-Shelf Availability status at the distribution point. Key field execution KPI linked to lost sales and consumer satisfaction."
    - name: "pog_compliance_flag"
      expr: pog_compliance_flag
      comment: "Boolean flag indicating planogram compliance at the distribution point. Measures in-store execution quality and shelf standards adherence."
    - name: "new_product_flag"
      expr: new_product_flag
      comment: "Boolean flag indicating whether the SKU is a new product launch. Used to track new product distribution velocity and launch execution."
    - name: "dsd_flag"
      expr: dsd_flag
      comment: "Boolean flag indicating Direct Store Delivery for the distribution point. Used to segment DSD vs. warehouse-delivered distribution performance."
    - name: "vmi_flag"
      expr: vmi_flag
      comment: "Boolean flag indicating Vendor Managed Inventory at the distribution point. Tracks VMI programme coverage and its impact on availability."
    - name: "activation_date"
      expr: activation_date
      comment: "Date the SKU was activated at the distribution point. Used to measure new product distribution speed-to-shelf."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of pricing data at the distribution point for multi-currency price compliance reporting."
  measures:
    - name: "total_distribution_points"
      expr: COUNT(DISTINCT distribution_point_id)
      comment: "Total count of active distribution points (SKU × Store combinations). The primary distribution breadth KPI — directly measures market coverage and shelf presence."
    - name: "total_acv_weighted_distribution"
      expr: SUM(CAST(acv_percentage AS DOUBLE))
      comment: "Sum of ACV-weighted distribution percentages across distribution points. Measures distribution quality weighted by store sales volume — the industry-standard TDP/ACV metric used in category reviews."
    - name: "avg_actual_retail_price"
      expr: AVG(CAST(actual_retail_price AS DOUBLE))
      comment: "Average actual retail price across distribution points. Monitors price realisation vs. MSRP and RSP targets — a key pricing compliance and brand equity KPI."
    - name: "avg_msrp_price"
      expr: AVG(CAST(msrp_price AS DOUBLE))
      comment: "Average Manufacturer Suggested Retail Price across distribution points. Baseline for price compliance and retail price gap analysis."
    - name: "avg_rsp_price"
      expr: AVG(CAST(rsp_price AS DOUBLE))
      comment: "Average Recommended Selling Price across distribution points. Used to assess retailer price compliance and consumer price positioning."
    - name: "pog_compliant_distribution_points"
      expr: COUNT(DISTINCT CASE WHEN pog_compliance_flag = TRUE THEN distribution_point_id END)
      comment: "Count of distribution points with planogram compliance. Numerator for POG compliance rate — measures in-store execution quality and shelf standards adherence."
    - name: "tdp_count"
      expr: COUNT(DISTINCT CASE WHEN tdp_count_flag = TRUE THEN distribution_point_id END)
      comment: "Count of distribution points flagged as Total Distribution Points. The TDP metric is a standard consumer goods KPI measuring numeric distribution breadth used in retailer and internal scorecards."
    - name: "new_product_distribution_points"
      expr: COUNT(DISTINCT CASE WHEN new_product_flag = TRUE THEN distribution_point_id END)
      comment: "Count of distribution points carrying new product launches. Tracks new product distribution velocity — a critical innovation execution KPI for brand and category teams."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`sales_account_call`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field sales execution metrics covering call activity, in-store compliance, out-of-stock detection, and planogram adherence. Drives field force productivity management and retail execution quality."
  source: "`consumer_goods_ecm`.`sales`.`account_call`"
  dimensions:
    - name: "call_date"
      expr: call_date
      comment: "Date of the account call for daily and weekly field activity trending and scheduling compliance analysis."
    - name: "call_type"
      expr: call_type
      comment: "Type of account call (e.g. Routine, Promotional, Audit) to segment field activity by purpose and measure call mix."
    - name: "call_status"
      expr: call_status
      comment: "Status of the call (e.g. Completed, Missed, Rescheduled) for field force compliance and call completion rate analysis."
    - name: "call_outcome"
      expr: call_outcome
      comment: "Outcome of the account call (e.g. Order Placed, Issue Resolved, No Action) to measure call effectiveness and conversion."
    - name: "call_objective"
      expr: call_objective
      comment: "Primary objective of the call (e.g. Shelf Audit, Order Taking, Promotion Execution) for activity-type performance analysis."
    - name: "display_type"
      expr: display_type
      comment: "Type of in-store display observed or executed during the call for display compliance and promotional execution tracking."
    - name: "display_compliance_flag"
      expr: display_compliance_flag
      comment: "Boolean flag indicating whether the in-store display was compliant with standards. Key field execution KPI for promotional and planogram compliance."
    - name: "shelf_position_compliant_flag"
      expr: shelf_position_compliant_flag
      comment: "Boolean flag indicating shelf position compliance at the time of the call. Measures adherence to shelf standards and planogram requirements."
    - name: "competitor_pricing_flag"
      expr: competitor_pricing_flag
      comment: "Boolean flag indicating whether competitive pricing activity was observed during the call. Used for competitive intelligence and pricing response analysis."
    - name: "corrective_actions_required"
      expr: corrective_actions_required
      comment: "Description of corrective actions identified during the call. Used to track in-store issue resolution rates and field execution quality."
  measures:
    - name: "total_calls_completed"
      expr: COUNT(DISTINCT CASE WHEN call_status = 'Completed' THEN account_call_id END)
      comment: "Count of completed account calls. Primary field force productivity KPI — measures actual vs. planned call coverage and rep activity levels."
    - name: "total_account_calls"
      expr: COUNT(DISTINCT account_call_id)
      comment: "Total count of all account calls (all statuses). Baseline activity volume metric for field force capacity and scheduling analysis."
    - name: "avg_call_duration_score"
      expr: AVG(CAST(pog_compliance_score AS DOUBLE))
      comment: "Average planogram compliance score across account calls. Compound KPI measuring in-store execution quality — directly linked to shelf standards and category management outcomes."
    - name: "total_pog_compliance_score"
      expr: SUM(CAST(pog_compliance_score AS DOUBLE))
      comment: "Sum of planogram compliance scores across all calls. Used as the numerator in weighted POG compliance rate calculations at territory and account level."
    - name: "display_compliant_call_count"
      expr: COUNT(DISTINCT CASE WHEN display_compliance_flag = TRUE THEN account_call_id END)
      comment: "Count of calls where display compliance was confirmed. Numerator for display compliance rate — measures promotional execution effectiveness across the field force."
    - name: "shelf_compliant_call_count"
      expr: COUNT(DISTINCT CASE WHEN shelf_position_compliant_flag = TRUE THEN account_call_id END)
      comment: "Count of calls where shelf position compliance was confirmed. Measures adherence to planogram and shelf standards — a key retail execution KPI."
    - name: "calls_with_competitor_pricing_observed"
      expr: COUNT(DISTINCT CASE WHEN competitor_pricing_flag = TRUE THEN account_call_id END)
      comment: "Count of calls where competitive pricing activity was observed. Tracks competitive intensity in the field and informs pricing and promotional response strategies."
    - name: "calls_requiring_corrective_action"
      expr: COUNT(DISTINCT CASE WHEN corrective_actions_completed_flag = FALSE THEN account_call_id END)
      comment: "Count of calls with outstanding corrective actions not yet completed. Measures unresolved in-store execution issues and drives field follow-up prioritisation."
    - name: "avg_geolocation_latitude"
      expr: AVG(CAST(geolocation_latitude AS DOUBLE))
      comment: "Average geolocation latitude of account calls. Used for geographic clustering and territory coverage heat-map analysis of field activity."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`sales_pricing_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing agreement metrics covering contracted pricing, discount depth, rebate exposure, and promotional allowances. Enables commercial teams to govern net price realisation and trade investment efficiency."
  source: "`consumer_goods_ecm`.`sales`.`pricing_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of pricing agreement (e.g. Customer-Specific, National Account, Promotional) for segmenting pricing strategy by agreement category."
    - name: "pricing_agreement_status"
      expr: pricing_agreement_status
      comment: "Current status of the pricing agreement (e.g. Active, Expired, Pending Approval) for agreement lifecycle management."
    - name: "pricing_tier"
      expr: pricing_tier
      comment: "Pricing tier assigned to the agreement (e.g. Tier 1, Tier 2, Premium) for tiered pricing strategy analysis."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel of the pricing agreement for channel-level price and discount analysis."
    - name: "division"
      expr: division
      comment: "Business division of the pricing agreement for divisional pricing governance reporting."
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organisation associated with the pricing agreement for regional pricing compliance monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the pricing agreement for multi-currency pricing analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the pricing agreement (e.g. Approved, Pending, Rejected) for pricing governance and compliance tracking."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date of the pricing agreement validity period for time-based pricing analysis and contract renewal management."
    - name: "price_protection_flag"
      expr: price_protection_flag
      comment: "Boolean flag indicating whether price protection is included in the agreement. Used to quantify price protection exposure and manage pricing risk."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the pricing agreement (e.g. National, Regional) for geographic pricing strategy analysis."
  measures:
    - name: "total_contracted_net_price_value"
      expr: SUM(CAST(contracted_net_price AS DOUBLE))
      comment: "Total contracted net price value across all active pricing agreements. Measures the aggregate committed revenue at contracted rates — a key commercial governance KPI."
    - name: "total_promotional_allowance"
      expr: SUM(CAST(promotional_allowance AS DOUBLE))
      comment: "Total promotional allowance committed across pricing agreements. Tracks trade investment exposure and informs trade spend ROI analysis."
    - name: "total_rebate_amount"
      expr: SUM(CAST(rebate_amount AS DOUBLE))
      comment: "Total rebate liability committed across pricing agreements. A critical financial exposure KPI for accruals management and net revenue realisation."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across pricing agreements. Compound KPI measuring discounting depth — directly informs pricing strategy and net revenue management."
    - name: "avg_rebate_percentage"
      expr: AVG(CAST(rebate_percentage AS DOUBLE))
      comment: "Average rebate percentage across pricing agreements. Monitors rebate intensity and its impact on net revenue realisation."
    - name: "avg_contracted_net_price"
      expr: AVG(CAST(contracted_net_price AS DOUBLE))
      comment: "Average contracted net price per agreement. Benchmarks pricing levels across customer tiers and channels to identify pricing inconsistencies."
    - name: "pricing_agreement_count"
      expr: COUNT(DISTINCT pricing_agreement_id)
      comment: "Count of distinct pricing agreements. Baseline metric for commercial contract coverage — ensures all key accounts have active, approved pricing agreements."
    - name: "total_minimum_order_value"
      expr: SUM(CAST(minimum_order_value AS DOUBLE))
      comment: "Total minimum order value commitments across pricing agreements. Measures contracted volume floor and informs demand planning and production scheduling."
$$;