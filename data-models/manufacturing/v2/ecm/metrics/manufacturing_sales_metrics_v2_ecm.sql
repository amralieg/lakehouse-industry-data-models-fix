-- Metric views for domain: sales | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 08:28:29

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pipeline health and conversion metrics derived from sales opportunities. Tracks deal value, win rates, and stage progression to steer revenue forecasting and sales strategy."
  source: "`vibe_manufacturing_v1`.`sales`.`opportunity`"
  dimensions:
    - name: "stage"
      expr: stage
      comment: "Current opportunity stage (e.g. Prospecting, Qualification, Proposal, Closed Won) for funnel analysis."
    - name: "forecast_category"
      expr: forecast_category
      comment: "Forecast category (Commit, Best Case, Pipeline) used in revenue forecasting."
    - name: "opportunity_type"
      expr: opportunity_type
      comment: "Type of opportunity (New Business, Renewal, Upsell) for mix analysis."
    - name: "lead_source"
      expr: lead_source
      comment: "Origin channel of the opportunity (e.g. Web, Partner, Campaign) for marketing attribution."
    - name: "region"
      expr: region
      comment: "Geographic region of the opportunity for territory performance analysis."
    - name: "industry_segment"
      expr: industry_segment
      comment: "Industry vertical of the customer for segment-level pipeline analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year the opportunity is expected to close for annual planning."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter the opportunity is expected to close for quarterly pipeline reviews."
    - name: "product_line"
      expr: product_line
      comment: "Product line associated with the opportunity for product mix analysis."
    - name: "is_won"
      expr: is_won
      comment: "Flag indicating whether the opportunity was won, used to segment won vs lost deals."
    - name: "is_closed"
      expr: is_closed
      comment: "Flag indicating whether the opportunity is closed (won or lost)."
    - name: "close_date_month"
      expr: DATE_TRUNC('MONTH', close_date)
      comment: "Month of expected close date for time-series pipeline trending."
  measures:
    - name: "total_pipeline_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total pipeline value across all open opportunities. Core metric for revenue forecasting and pipeline coverage analysis."
    - name: "total_expected_revenue"
      expr: SUM(CAST(expected_revenue AS DOUBLE))
      comment: "Sum of probability-weighted expected revenue across opportunities. Used for risk-adjusted pipeline reporting."
    - name: "avg_deal_size"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average opportunity value. Tracks deal size trends and informs sales capacity planning."
    - name: "avg_probability_percent"
      expr: AVG(CAST(probability_percent AS DOUBLE))
      comment: "Average win probability across open opportunities. Indicates overall pipeline quality and confidence."
    - name: "opportunity_count"
      expr: COUNT(1)
      comment: "Total number of opportunities. Used to measure pipeline volume and sales activity levels."
    - name: "won_opportunity_count"
      expr: COUNT(CASE WHEN is_won = TRUE THEN 1 END)
      comment: "Count of won opportunities. Numerator for win rate calculation and closed revenue tracking."
    - name: "win_rate_percent"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_won = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_closed = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of closed opportunities that were won. Primary sales effectiveness KPI tracked in every QBR."
    - name: "total_discount_percent_avg"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage granted on opportunities. Monitors pricing discipline and margin erosion risk."
    - name: "avg_sales_cycle_days"
      expr: AVG(CAST(sales_cycle_days AS DOUBLE))
      comment: "Average number of days from opportunity creation to close. Tracks sales velocity and process efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_order_intake`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order intake (bookings) metrics tracking the volume and value of orders received. Critical for revenue recognition, backlog management, and demand planning."
  source: "`vibe_manufacturing_v1`.`sales`.`order_intake`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of order (Standard, Project, Service) for mix and margin analysis."
    - name: "order_priority"
      expr: order_priority
      comment: "Priority level of the order for fulfillment scheduling and SLA compliance."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the order intake for annual bookings reporting."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the order intake for quarterly bookings reviews."
    - name: "industry_segment"
      expr: industry_segment
      comment: "Industry segment of the customer for vertical market analysis."
    - name: "product_line"
      expr: product_line
      comment: "Product line of the order for product mix and revenue attribution."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency bookings analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms (e.g. DDP, EXW) affecting revenue recognition timing."
    - name: "handoff_status"
      expr: handoff_status
      comment: "Status of order handoff to operations, tracking sales-to-delivery transition quality."
    - name: "intake_date_month"
      expr: DATE_TRUNC('MONTH', intake_date)
      comment: "Month of order intake for monthly bookings trend analysis."
    - name: "booking_recognized_flag"
      expr: booking_recognized_flag
      comment: "Whether the booking has been formally recognized, used to separate recognized vs pending bookings."
  measures:
    - name: "total_order_value"
      expr: SUM(CAST(order_value AS DOUBLE))
      comment: "Total value of orders booked in transaction currency. Primary bookings KPI for revenue planning."
    - name: "total_order_value_base_currency"
      expr: SUM(CAST(order_value_base_currency AS DOUBLE))
      comment: "Total order value normalized to base currency. Enables consistent cross-currency bookings comparison."
    - name: "avg_order_value"
      expr: AVG(CAST(order_value AS DOUBLE))
      comment: "Average order value per intake record. Tracks deal size trends and informs pricing strategy."
    - name: "order_intake_count"
      expr: COUNT(1)
      comment: "Total number of orders received. Measures booking volume and sales throughput."
    - name: "recognized_booking_count"
      expr: COUNT(CASE WHEN booking_recognized_flag = TRUE THEN 1 END)
      comment: "Count of orders where booking has been formally recognized. Tracks revenue recognition pipeline."
    - name: "booking_recognition_rate_percent"
      expr: ROUND(100.0 * COUNT(CASE WHEN booking_recognized_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of intake orders that have been booking-recognized. Monitors revenue recognition completeness."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied to orders. Used to assess currency exposure on the order book."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales forecast accuracy and pipeline coverage metrics. Enables management to assess forecast reliability, quota attainment trajectory, and pipeline health across periods."
  source: "`vibe_manufacturing_v1`.`sales`.`forecast`"
  dimensions:
    - name: "forecast_category"
      expr: forecast_category
      comment: "Forecast category (Commit, Best Case, Pipeline, Closed) for tiered forecast analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the forecast for annual planning alignment."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the forecast for quarterly business review reporting."
    - name: "period_type"
      expr: period_type
      comment: "Granularity of the forecast period (Monthly, Quarterly, Annual)."
    - name: "region"
      expr: region
      comment: "Geographic region for territory-level forecast analysis."
    - name: "product_line"
      expr: product_line
      comment: "Product line for product mix forecast analysis."
    - name: "industry_segment"
      expr: industry_segment
      comment: "Industry vertical for segment-level forecast tracking."
    - name: "forecast_status"
      expr: forecast_status
      comment: "Current status of the forecast (Draft, Submitted, Approved) for governance tracking."
    - name: "is_latest_version"
      expr: is_latest_version
      comment: "Flag to filter to the most current forecast version, avoiding double-counting revisions."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of forecast submission for trend analysis of forecasting cadence."
  measures:
    - name: "total_submitted_amount"
      expr: SUM(CAST(submitted_amount AS DOUBLE))
      comment: "Total submitted forecast amount. Primary forecast KPI used in executive pipeline reviews."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed forecast amount representing high-confidence revenue. Used for revenue guidance."
    - name: "total_best_case_amount"
      expr: SUM(CAST(best_case_amount AS DOUBLE))
      comment: "Total best-case forecast amount representing upside potential. Used for scenario planning."
    - name: "total_pipeline_amount"
      expr: SUM(CAST(pipeline_amount AS DOUBLE))
      comment: "Total pipeline amount in forecast. Measures overall pipeline coverage relative to quota."
    - name: "total_closed_amount"
      expr: SUM(CAST(closed_amount AS DOUBLE))
      comment: "Total closed/won amount within the forecast period. Tracks actual revenue realization."
    - name: "total_quota_amount"
      expr: SUM(CAST(quota_amount AS DOUBLE))
      comment: "Total quota assigned for the forecast period. Denominator for attainment calculations."
    - name: "avg_quota_attainment_percent"
      expr: AVG(CAST(quota_attainment_percent AS DOUBLE))
      comment: "Average quota attainment percentage across forecast records. Core sales performance KPI."
    - name: "total_weighted_pipeline"
      expr: SUM(CAST(weighted_pipeline_amount AS DOUBLE))
      comment: "Total probability-weighted pipeline. Risk-adjusted revenue estimate used in financial planning."
    - name: "total_variance_to_quota"
      expr: SUM(CAST(variance_to_quota AS DOUBLE))
      comment: "Total gap between forecast and quota. Identifies shortfall risk requiring management intervention."
    - name: "total_manager_adjusted_amount"
      expr: SUM(CAST(manager_adjusted_amount AS DOUBLE))
      comment: "Total manager-adjusted forecast amount. Measures management override magnitude and forecasting discipline."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_quota`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quota attainment and allocation metrics for sales performance management. Tracks rep and team performance against targets across fiscal periods."
  source: "`vibe_manufacturing_v1`.`sales`.`quota`"
  dimensions:
    - name: "quota_type"
      expr: quota_type
      comment: "Type of quota (Revenue, Units, Activity) for multi-dimensional performance tracking."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the quota for annual performance management."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the quota for quarterly attainment reviews."
    - name: "region"
      expr: region
      comment: "Geographic region for territory-level quota performance analysis."
    - name: "product_line"
      expr: product_line
      comment: "Product line for product-specific quota tracking."
    - name: "quota_status"
      expr: quota_status
      comment: "Status of the quota (Draft, Approved, Active) for governance and planning."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the quota for compliance with quota-setting governance."
    - name: "is_team_quota"
      expr: is_team_quota
      comment: "Flag distinguishing individual rep quotas from team-level quotas."
    - name: "industry_segment"
      expr: industry_segment
      comment: "Industry vertical for segment-level quota analysis."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Start month of the quota period for time-series attainment trending."
  measures:
    - name: "total_base_quota_amount"
      expr: SUM(CAST(base_quota_amount AS DOUBLE))
      comment: "Total base quota assigned. Baseline for all attainment calculations and capacity planning."
    - name: "total_attainment_amount"
      expr: SUM(CAST(attainment_amount AS DOUBLE))
      comment: "Total quota attainment achieved. Measures actual sales performance against targets."
    - name: "avg_attainment_percent"
      expr: AVG(CAST(attainment_percent AS DOUBLE))
      comment: "Average quota attainment percentage. Primary sales performance KPI for rep and team reviews."
    - name: "total_remaining_amount"
      expr: SUM(CAST(remaining_amount AS DOUBLE))
      comment: "Total remaining quota gap. Identifies how much more revenue is needed to hit targets."
    - name: "total_stretch_quota_amount"
      expr: SUM(CAST(stretch_quota_amount AS DOUBLE))
      comment: "Total stretch quota assigned. Used to assess upside potential and incentive plan design."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total quota adjustments made. Monitors quota stability and fairness of mid-period changes."
    - name: "quota_count"
      expr: COUNT(1)
      comment: "Number of quota records. Used to track quota coverage and ensure all reps have assigned targets."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quote conversion and value metrics tracking the commercial proposal pipeline. Enables analysis of quote-to-order conversion, average deal size, and discount discipline."
  source: "`vibe_manufacturing_v1`.`sales`.`quote`"
  dimensions:
    - name: "quote_status"
      expr: quote_status
      comment: "Current status of the quote (Draft, Presented, Accepted, Rejected) for funnel analysis."
    - name: "quote_type"
      expr: quote_type
      comment: "Type of quote (Standard, Custom, Framework) for mix analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the quote for governance and discount authorization tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency quote analysis."
    - name: "incoterm"
      expr: incoterm
      comment: "Delivery terms on the quote affecting total cost and revenue recognition."
    - name: "non_standard_discount_flag"
      expr: non_standard_discount_flag
      comment: "Flag for quotes with non-standard discounts requiring special approval."
    - name: "quote_date_month"
      expr: DATE_TRUNC('MONTH', quote_date)
      comment: "Month of quote creation for time-series quoting activity analysis."
    - name: "valid_until_month"
      expr: DATE_TRUNC('MONTH', valid_until_date)
      comment: "Month the quote expires, used to track quote expiry pipeline."
  measures:
    - name: "total_quote_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total value of all quotes. Measures the commercial pipeline value at the quoting stage."
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total pre-tax, pre-shipping quote value. Used for net revenue analysis."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted across quotes. Monitors pricing discipline and margin impact."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across quotes. Key pricing governance metric."
    - name: "avg_win_probability_percentage"
      expr: AVG(CAST(win_probability_percentage AS DOUBLE))
      comment: "Average win probability assigned to quotes. Indicates commercial confidence in the quote pipeline."
    - name: "quote_count"
      expr: COUNT(1)
      comment: "Total number of quotes issued. Measures quoting activity and sales team throughput."
    - name: "accepted_quote_count"
      expr: COUNT(CASE WHEN quote_status = 'Accepted' THEN 1 END)
      comment: "Count of accepted quotes. Numerator for quote-to-order conversion rate."
    - name: "quote_conversion_rate_percent"
      expr: ROUND(100.0 * COUNT(CASE WHEN quote_status = 'Accepted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of quotes that were accepted. Measures commercial effectiveness of the quoting process."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on quotes. Used for tax liability estimation and compliance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales contract portfolio metrics tracking contracted revenue, SLA commitments, and contract lifecycle. Enables management of contract value, compliance risk, and renewal pipeline."
  source: "`vibe_manufacturing_v1`.`sales`.`sales_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract (Active, Expired, Terminated, Pending) for portfolio management."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (Framework, Project, Service, Supply) for mix analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms on the contract affecting revenue recognition and logistics obligations."
    - name: "dispute_resolution_method"
      expr: dispute_resolution_method
      comment: "Dispute resolution mechanism (Arbitration, Litigation, Mediation) for legal risk profiling."
    - name: "governing_law"
      expr: governing_law
      comment: "Jurisdiction governing the contract for legal and compliance risk analysis."
    - name: "compliance_certifications_required"
      expr: compliance_certifications_required
      comment: "Flag indicating whether compliance certifications are required, for regulatory risk tracking."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the contract became effective for contract inception trend analysis."
    - name: "signature_date_month"
      expr: DATE_TRUNC('MONTH', signature_date)
      comment: "Month the contract was signed for bookings and backlog reporting."
  measures:
    - name: "total_net_contract_value"
      expr: SUM(CAST(net_contract_value AS DOUBLE))
      comment: "Total net contract value across the portfolio. Primary contracted revenue KPI for backlog and revenue planning."
    - name: "avg_net_contract_value"
      expr: AVG(CAST(net_contract_value AS DOUBLE))
      comment: "Average net contract value. Tracks deal size trends and informs pricing and negotiation strategy."
    - name: "total_liability_cap_amount"
      expr: SUM(CAST(liability_cap_amount AS DOUBLE))
      comment: "Total liability cap exposure across contracts. Critical for legal risk quantification and insurance planning."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across contracts. Used for tax liability estimation and financial planning."
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of contracts. Measures portfolio size and contract management workload."
    - name: "avg_sla_uptime_percentage"
      expr: AVG(CAST(sla_uptime_percentage AS DOUBLE))
      comment: "Average SLA uptime commitment across contracts. Monitors service obligation risk and delivery capability."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing campaign performance and ROI metrics. Enables marketing and sales leadership to evaluate campaign effectiveness, lead generation efficiency, and revenue attribution."
  source: "`vibe_manufacturing_v1`.`sales`.`campaign`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Marketing channel (Digital, Email, Event, Partner) for channel effectiveness comparison."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign (Active, Completed, Paused) for portfolio management."
    - name: "objective"
      expr: objective
      comment: "Campaign objective (Lead Generation, Brand Awareness, Retention) for goal-based analysis."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the campaign for regional marketing performance analysis."
    - name: "priority"
      expr: priority
      comment: "Campaign priority level for resource allocation and investment decisions."
    - name: "is_test_campaign"
      expr: is_test_campaign
      comment: "Flag to exclude test campaigns from production performance reporting."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the campaign started for time-series marketing spend and performance analysis."
    - name: "language_code"
      expr: language_code
      comment: "Language of the campaign for localization and market penetration analysis."
  measures:
    - name: "total_actual_revenue"
      expr: SUM(CAST(actual_revenue AS DOUBLE))
      comment: "Total revenue attributed to campaigns. Primary marketing ROI metric for budget justification."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total marketing spend across campaigns. Used for budget tracking and cost efficiency analysis."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted campaign spend. Denominator for budget utilization and variance analysis."
    - name: "total_actual_leads"
      expr: SUM(CAST(actual_leads AS DOUBLE))
      comment: "Total leads generated by campaigns. Measures top-of-funnel contribution to sales pipeline."
    - name: "total_actual_impressions"
      expr: SUM(CAST(actual_impressions AS DOUBLE))
      comment: "Total impressions delivered. Measures campaign reach and brand exposure."
    - name: "total_actual_clicks"
      expr: SUM(CAST(actual_clicks AS DOUBLE))
      comment: "Total clicks generated. Measures audience engagement and campaign response rates."
    - name: "campaign_roi_revenue_per_spend"
      expr: ROUND(SUM(CAST(actual_revenue AS DOUBLE)) / NULLIF(SUM(CAST(actual_spend AS DOUBLE)), 0), 4)
      comment: "Revenue generated per unit of spend. Primary campaign ROI metric for marketing investment decisions."
    - name: "cost_per_lead"
      expr: ROUND(SUM(CAST(actual_spend AS DOUBLE)) / NULLIF(SUM(CAST(actual_leads AS DOUBLE)), 0), 2)
      comment: "Average cost to generate one lead. Key efficiency metric for comparing campaign and channel performance."
    - name: "click_through_rate"
      expr: ROUND(SUM(CAST(actual_clicks AS DOUBLE)) / NULLIF(SUM(CAST(actual_impressions AS DOUBLE)), 0), 6)
      comment: "Ratio of clicks to impressions. Measures audience engagement quality and creative effectiveness."
    - name: "budget_utilization_percent"
      expr: ROUND(100.0 * SUM(CAST(actual_spend AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of campaign budget consumed. Tracks marketing spend pacing and budget discipline."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_lead`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead generation and qualification metrics. Tracks lead volume, conversion rates, and source effectiveness to optimize top-of-funnel sales investment."
  source: "`vibe_manufacturing_v1`.`sales`.`sales_lead`"
  dimensions:
    - name: "lead_status"
      expr: lead_status
      comment: "Current status of the lead (New, Working, Qualified, Converted, Disqualified) for funnel stage analysis."
    - name: "lead_source"
      expr: lead_source
      comment: "Origin of the lead (Web, Referral, Campaign, Trade Show) for source attribution analysis."
    - name: "industry_segment"
      expr: industry_segment
      comment: "Industry vertical of the lead for segment-level pipeline contribution analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the lead for geographic market penetration analysis."
    - name: "rating"
      expr: rating
      comment: "Lead quality rating (Hot, Warm, Cold) for prioritization and resource allocation."
    - name: "is_converted"
      expr: is_converted
      comment: "Flag indicating whether the lead was converted to an opportunity."
    - name: "do_not_contact"
      expr: do_not_contact
      comment: "Flag for leads marked do-not-contact, used to ensure compliance with contact preferences."
    - name: "created_date_month"
      expr: DATE_TRUNC('MONTH', created_date)
      comment: "Month the lead was created for time-series lead generation trend analysis."
  measures:
    - name: "total_lead_count"
      expr: COUNT(1)
      comment: "Total number of leads. Measures top-of-funnel volume and marketing effectiveness."
    - name: "converted_lead_count"
      expr: COUNT(CASE WHEN is_converted = TRUE THEN 1 END)
      comment: "Number of leads converted to opportunities. Measures lead quality and sales follow-up effectiveness."
    - name: "lead_conversion_rate_percent"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_converted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of leads converted to opportunities. Primary lead quality KPI for marketing and sales alignment."
    - name: "total_estimated_project_value"
      expr: SUM(CAST(estimated_project_value AS DOUBLE))
      comment: "Total estimated value of projects associated with leads. Measures potential pipeline value from lead generation."
    - name: "avg_estimated_project_value"
      expr: AVG(CAST(estimated_project_value AS DOUBLE))
      comment: "Average estimated project value per lead. Used to prioritize high-value leads and allocate sales resources."
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Total annual revenue of companies associated with leads. Measures the quality and size of target accounts in the lead pool."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_rep`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales representative performance and capacity metrics. Enables sales management to assess rep productivity, quota coverage, and portfolio health for coaching and resource decisions."
  source: "`vibe_manufacturing_v1`.`sales`.`rep`"
  dimensions:
    - name: "rep_status"
      expr: rep_status
      comment: "Current status of the rep (Active, On Leave, Terminated) for workforce planning."
    - name: "sales_role"
      expr: sales_role
      comment: "Role of the rep (Account Executive, Inside Sales, Key Account Manager) for role-based performance analysis."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel the rep operates in (Direct, Partner, Inside) for channel mix analysis."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment the rep covers (Enterprise, Mid-Market, SMB) for segment performance analysis."
    - name: "industry_vertical_focus"
      expr: industry_vertical_focus
      comment: "Industry vertical focus of the rep for vertical market coverage analysis."
    - name: "performance_rating"
      expr: performance_rating
      comment: "Latest performance rating of the rep for talent management and coaching prioritization."
    - name: "is_key_account_manager"
      expr: is_key_account_manager
      comment: "Flag identifying key account managers for strategic account coverage analysis."
    - name: "hire_date_year"
      expr: DATE_TRUNC('YEAR', hire_date)
      comment: "Year of hire for tenure-based performance cohort analysis."
  measures:
    - name: "total_annual_quota_amount"
      expr: SUM(CAST(annual_quota_amount AS DOUBLE))
      comment: "Total annual quota assigned across reps. Measures total revenue target and sales capacity."
    - name: "avg_annual_quota_amount"
      expr: AVG(CAST(annual_quota_amount AS DOUBLE))
      comment: "Average annual quota per rep. Benchmarks quota allocation fairness and capacity planning."
    - name: "total_book_of_business_value"
      expr: SUM(CAST(book_of_business_value AS DOUBLE))
      comment: "Total book of business value across reps. Measures the revenue base managed by the sales force."
    - name: "avg_book_of_business_value"
      expr: AVG(CAST(book_of_business_value AS DOUBLE))
      comment: "Average book of business per rep. Identifies concentration risk and rep capacity utilization."
    - name: "rep_count"
      expr: COUNT(1)
      comment: "Total number of sales reps. Measures sales force size for capacity and coverage planning."
    - name: "avg_travel_percentage"
      expr: AVG(CAST(travel_percentage AS DOUBLE))
      comment: "Average travel percentage across reps. Used for cost management and rep workload balancing."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_channel_partner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel partner performance and portfolio metrics. Tracks partner revenue targets, certification status, and program health to optimize indirect sales channel investment."
  source: "`vibe_manufacturing_v1`.`sales`.`channel_partner`"
  dimensions:
    - name: "partner_status"
      expr: partner_status
      comment: "Current status of the partner (Active, Inactive, Suspended) for portfolio health monitoring."
    - name: "partner_tier"
      expr: partner_tier
      comment: "Partner tier (Gold, Silver, Bronze) for tiered program management and incentive allocation."
    - name: "partner_type"
      expr: partner_type
      comment: "Type of partner (Reseller, Distributor, System Integrator) for channel mix analysis."
    - name: "certification_status"
      expr: certification_status
      comment: "Partner certification status for compliance and program eligibility tracking."
    - name: "geographic_coverage"
      expr: geographic_coverage
      comment: "Geographic coverage of the partner for territory and market coverage analysis."
    - name: "industry_focus"
      expr: industry_focus
      comment: "Industry vertical focus of the partner for vertical market coverage analysis."
    - name: "mdf_eligible"
      expr: mdf_eligible
      comment: "Flag indicating eligibility for Market Development Funds for MDF budget allocation."
    - name: "partner_program_enrollment_month"
      expr: DATE_TRUNC('MONTH', partner_program_enrollment_date)
      comment: "Month of program enrollment for partner cohort and retention analysis."
  measures:
    - name: "total_annual_revenue_target"
      expr: SUM(CAST(annual_revenue_target AS DOUBLE))
      comment: "Total annual revenue target across channel partners. Measures indirect channel revenue contribution to overall sales plan."
    - name: "avg_annual_revenue_target"
      expr: AVG(CAST(annual_revenue_target AS DOUBLE))
      comment: "Average annual revenue target per partner. Benchmarks partner productivity and program ROI."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended to channel partners. Measures financial exposure in the partner channel."
    - name: "partner_count"
      expr: COUNT(1)
      comment: "Total number of channel partners. Measures indirect channel breadth and coverage."
    - name: "certified_partner_count"
      expr: COUNT(CASE WHEN certification_status = 'Certified' THEN 1 END)
      comment: "Number of certified partners. Measures partner program quality and compliance with certification requirements."
    - name: "certification_rate_percent"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_status = 'Certified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners that are certified. Tracks partner program health and compliance."
    - name: "mdf_eligible_partner_count"
      expr: COUNT(CASE WHEN mdf_eligible = TRUE THEN 1 END)
      comment: "Number of MDF-eligible partners. Used for MDF budget planning and partner investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_discount_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discount schedule governance and pricing discipline metrics. Tracks discount levels, approval requirements, and schedule coverage to manage margin risk and pricing consistency."
  source: "`vibe_manufacturing_v1`.`sales`.`discount_schedule`"
  dimensions:
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of discount schedule (Volume, Promotional, Partner, Customer-Specific) for pricing strategy analysis."
    - name: "discount_schedule_status"
      expr: discount_schedule_status
      comment: "Current status of the schedule (Active, Expired, Draft) for pricing governance."
    - name: "applies_to_customer_segment"
      expr: applies_to_customer_segment
      comment: "Customer segment the discount applies to for segment-level pricing analysis."
    - name: "applies_to_product_category"
      expr: applies_to_product_category
      comment: "Product category the discount applies to for product-level margin analysis."
    - name: "approval_required"
      expr: approval_required
      comment: "Flag indicating whether the discount requires approval for governance tracking."
    - name: "is_stackable"
      expr: is_stackable
      comment: "Flag indicating whether the discount can be combined with others for pricing risk assessment."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region the discount applies to for regional pricing consistency analysis."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the discount schedule became effective for pricing change trend analysis."
  measures:
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate across schedules. Monitors overall pricing discipline and margin risk."
    - name: "avg_max_discount_amount"
      expr: AVG(CAST(max_discount_amount AS DOUBLE))
      comment: "Average maximum discount amount allowed. Tracks the ceiling on discount exposure across the portfolio."
    - name: "total_max_discount_amount"
      expr: SUM(CAST(max_discount_amount AS DOUBLE))
      comment: "Total maximum discount exposure across all active schedules. Quantifies worst-case margin risk from discounting."
    - name: "avg_minimum_order_value"
      expr: AVG(CAST(minimum_order_value AS DOUBLE))
      comment: "Average minimum order value required to qualify for discounts. Tracks order size thresholds in pricing strategy."
    - name: "discount_schedule_count"
      expr: COUNT(1)
      comment: "Total number of discount schedules. Measures pricing complexity and governance overhead."
    - name: "approval_required_schedule_count"
      expr: COUNT(CASE WHEN approval_required = TRUE THEN 1 END)
      comment: "Number of schedules requiring approval. Measures the proportion of discounts under governance control."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`sales_territory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales territory coverage and quota metrics. Enables sales operations to assess territory design effectiveness, quota allocation, and geographic coverage for go-to-market optimization."
  source: "`vibe_manufacturing_v1`.`sales`.`territory`"
  dimensions:
    - name: "territory_status"
      expr: territory_status
      comment: "Current status of the territory (Active, Inactive, Pending) for coverage management."
    - name: "territory_type"
      expr: territory_type
      comment: "Type of territory (Geographic, Named Account, Vertical, Overlay) for territory design analysis."
    - name: "region_level"
      expr: region_level
      comment: "Hierarchical level of the territory (Global, Regional, Country, District) for roll-up reporting."
    - name: "coverage_model"
      expr: coverage_model
      comment: "Coverage model (Direct, Partner, Hybrid) for go-to-market strategy analysis."
    - name: "is_overlay_territory"
      expr: is_overlay_territory
      comment: "Flag identifying overlay territories for specialist coverage analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the territory for market coverage analysis."
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry vertical focus of the territory for vertical market coverage analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the territory became effective for territory change trend analysis."
  measures:
    - name: "total_annual_revenue_quota"
      expr: SUM(CAST(annual_revenue_quota AS DOUBLE))
      comment: "Total annual revenue quota across territories. Measures total addressable revenue target by territory design."
    - name: "avg_annual_revenue_quota"
      expr: AVG(CAST(annual_revenue_quota AS DOUBLE))
      comment: "Average annual revenue quota per territory. Benchmarks territory sizing and quota equity."
    - name: "territory_count"
      expr: COUNT(1)
      comment: "Total number of territories. Measures sales coverage breadth and territory management complexity."
    - name: "overlay_territory_count"
      expr: COUNT(CASE WHEN is_overlay_territory = TRUE THEN 1 END)
      comment: "Number of overlay territories. Tracks specialist coverage investment and potential territory conflict risk."
$$;