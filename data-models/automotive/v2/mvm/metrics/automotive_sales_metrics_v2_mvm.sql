-- Metric views for domain: sales | Business: Automotive | Version: 2 | Generated on: 2026-06-23 05:54:22

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_vehicle_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for vehicle order performance including revenue, discounting, incentive spend, and order pipeline health. Primary steering dashboard for sales leadership."
  source: "`vibe_automotive_v1`.`sales`.`vehicle_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the vehicle order (e.g. Pending, Confirmed, Delivered, Cancelled) — used to slice pipeline health."
    - name: "order_type"
      expr: order_type
      comment: "Type of order (e.g. Retail, Fleet, Subscription) — enables channel-mix analysis."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel through which the order was placed (e.g. Dealer, Online, Direct) — critical for omnichannel strategy."
    - name: "sales_channel_type"
      expr: sales_channel_type
      comment: "Broader classification of the sales channel type — supports channel-tier reporting."
    - name: "financing_type"
      expr: financing_type
      comment: "Financing method selected by the customer (e.g. Cash, Loan, Lease) — informs F&I product mix decisions."
    - name: "model_year"
      expr: model_year
      comment: "Model year of the ordered vehicle — used for vintage/cohort analysis and inventory planning."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region code for the order — enables regional performance benchmarking."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year in which the order was placed — aligns metrics to financial reporting periods."
    - name: "order_date"
      expr: DATE_TRUNC('month', order_date)
      comment: "Order date truncated to month — supports time-series trending of order volumes and revenue."
    - name: "is_online_order"
      expr: is_online_order
      comment: "Flag indicating whether the order was placed online — tracks digital channel adoption."
    - name: "is_subscription"
      expr: is_subscription
      comment: "Flag indicating whether the order is a subscription model — tracks emerging revenue model penetration."
    - name: "is_certified_pre_owned"
      expr: is_certified_pre_owned
      comment: "Flag indicating whether the order is for a certified pre-owned vehicle — supports CPO program performance tracking."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the order — informs cash flow and financing partner strategy."
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of vehicle orders placed — baseline volume KPI for sales pipeline and capacity planning."
    - name: "total_order_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross revenue from all vehicle orders — primary top-line revenue KPI for executive reporting."
    - name: "total_selling_price"
      expr: SUM(CAST(selling_price AS DOUBLE))
      comment: "Sum of actual selling prices across all orders — reflects realized transaction value before taxes and fees."
    - name: "total_msrp"
      expr: SUM(CAST(msrp AS DOUBLE))
      comment: "Sum of MSRP across all orders — baseline for computing discount depth and price realization."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount dollars given across all orders — tracks discounting pressure and margin erosion risk."
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total manufacturer and dealer incentive spend across orders — critical for profitability and program ROI analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across all vehicle orders — supports tax liability and compliance reporting."
    - name: "total_trade_in_value"
      expr: SUM(CAST(trade_in_value AS DOUBLE))
      comment: "Total trade-in value applied across orders — measures used-vehicle acquisition volume and its impact on net transaction value."
    - name: "avg_selling_price"
      expr: AVG(CAST(selling_price AS DOUBLE))
      comment: "Average selling price per vehicle order — key indicator of product mix, pricing power, and segment shift."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per order — monitors discounting discipline and sales team pricing behavior."
    - name: "avg_incentive_amount"
      expr: AVG(CAST(incentive_amount AS DOUBLE))
      comment: "Average incentive per order — tracks incentive efficiency and cost-per-unit-sold."
    - name: "online_order_count"
      expr: COUNT(CASE WHEN is_online_order = TRUE THEN 1 END)
      comment: "Number of orders placed through online channels — tracks digital sales channel adoption and e-commerce growth."
    - name: "subscription_order_count"
      expr: COUNT(CASE WHEN is_subscription = TRUE THEN 1 END)
      comment: "Number of subscription-model orders — monitors penetration of the subscription revenue model."
    - name: "cpo_order_count"
      expr: COUNT(CASE WHEN is_certified_pre_owned = TRUE THEN 1 END)
      comment: "Number of certified pre-owned vehicle orders — tracks CPO program volume and used-vehicle business health."
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN order_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled orders — a leading indicator of customer satisfaction issues, inventory mismatches, or financing failures."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales funnel and pipeline KPIs derived from opportunity records. Enables win/loss analysis, pipeline value assessment, and conversion performance tracking for sales leadership."
  source: "`vibe_automotive_v1`.`sales`.`opportunity`"
  dimensions:
    - name: "sales_stage"
      expr: sales_stage
      comment: "Current stage of the opportunity in the sales funnel — used to analyze pipeline distribution and stage conversion rates."
    - name: "opportunity_type"
      expr: opportunity_type
      comment: "Type of opportunity (e.g. New Vehicle, CPO, Fleet) — enables segment-level pipeline analysis."
    - name: "lead_source"
      expr: lead_source
      comment: "Source that generated the opportunity (e.g. Web, Referral, Campaign) — informs marketing ROI and lead quality analysis."
    - name: "financing_type"
      expr: financing_type
      comment: "Financing type associated with the opportunity — supports F&I product mix and penetration analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the opportunity — enables regional pipeline and win-rate benchmarking."
    - name: "model_year"
      expr: model_year
      comment: "Model year of vehicle of interest — supports vintage demand analysis and inventory alignment."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the opportunity — aligns pipeline metrics to financial planning cycles."
    - name: "is_won"
      expr: is_won
      comment: "Flag indicating whether the opportunity was won — primary dimension for win/loss analysis."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the opportunity is currently active — used to filter live pipeline views."
    - name: "expected_close_date_month"
      expr: DATE_TRUNC('month', expected_close_date)
      comment: "Expected close date truncated to month — supports pipeline timing and forecast accuracy analysis."
    - name: "competitor_brand"
      expr: competitor_brand
      comment: "Competing brand identified in the opportunity — enables competitive win/loss intelligence."
    - name: "loss_reason"
      expr: loss_reason
      comment: "Reason the opportunity was lost — critical for identifying systemic sales or product gaps."
    - name: "digital_channel_source"
      expr: digital_channel_source
      comment: "Digital channel that sourced the opportunity — tracks digital marketing effectiveness."
  measures:
    - name: "total_opportunities"
      expr: COUNT(1)
      comment: "Total number of opportunities in the pipeline — baseline volume metric for sales funnel analysis."
    - name: "total_pipeline_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of all opportunities in the pipeline — primary pipeline health KPI for revenue forecasting."
    - name: "total_won_opportunities"
      expr: COUNT(CASE WHEN is_won = TRUE THEN 1 END)
      comment: "Number of won opportunities — measures sales team effectiveness and conversion success."
    - name: "total_won_value"
      expr: SUM(CASE WHEN is_won = TRUE THEN CAST(estimated_value AS DOUBLE) ELSE 0 END)
      comment: "Total estimated value of won opportunities — measures realized pipeline conversion in dollar terms."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount offered across all opportunities — tracks discounting behavior at the pipeline level."
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive value applied across opportunities — monitors incentive spend efficiency in the sales funnel."
    - name: "total_msrp"
      expr: SUM(CAST(msrp AS DOUBLE))
      comment: "Sum of MSRP across all opportunities — baseline for measuring discount depth and price realization in the funnel."
    - name: "total_trade_in_value"
      expr: SUM(CAST(trade_in_value AS DOUBLE))
      comment: "Total trade-in value across opportunities — measures trade-in program engagement and its role in deal facilitation."
    - name: "avg_probability"
      expr: AVG(CAST(probability AS DOUBLE))
      comment: "Average win probability across active opportunities — used for weighted pipeline forecasting."
    - name: "avg_estimated_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average estimated deal value per opportunity — tracks deal size trends and product mix shifts."
    - name: "weighted_pipeline_value"
      expr: SUM(CAST(estimated_value AS DOUBLE) * CAST(probability AS DOUBLE) / 100.0)
      comment: "Probability-weighted pipeline value — the gold-standard revenue forecast metric used in executive QBRs."
    - name: "test_drive_completed_count"
      expr: COUNT(CASE WHEN test_drive_completed = TRUE THEN 1 END)
      comment: "Number of opportunities where a test drive was completed — tracks a key conversion milestone in the sales process."
    - name: "quote_generated_count"
      expr: COUNT(CASE WHEN quote_generated = TRUE THEN 1 END)
      comment: "Number of opportunities that progressed to a quote — measures funnel advancement and sales engagement depth."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_lead`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead generation and qualification KPIs. Tracks lead volume, source effectiveness, conversion rates, and digital channel penetration to optimize top-of-funnel marketing and sales investment."
  source: "`vibe_automotive_v1`.`sales`.`lead`"
  dimensions:
    - name: "lead_status"
      expr: lead_status
      comment: "Current status of the lead (e.g. New, Contacted, Qualified, Converted, Lost) — primary dimension for funnel stage analysis."
    - name: "lead_type"
      expr: lead_type
      comment: "Type of lead (e.g. New Vehicle, Used Vehicle, Service) — enables segment-level lead quality analysis."
    - name: "source"
      expr: source
      comment: "Channel or system that generated the lead (e.g. Website, Referral, Event) — critical for marketing attribution and ROI."
    - name: "referral_source"
      expr: referral_source
      comment: "Specific referral source for the lead — enables granular attribution of referral program effectiveness."
    - name: "region"
      expr: region
      comment: "Geographic region of the lead — supports regional demand and marketing spend analysis."
    - name: "vehicle_interest_category"
      expr: vehicle_interest_category
      comment: "Category of vehicle the lead is interested in — informs inventory planning and targeted marketing."
    - name: "purchase_timeframe"
      expr: purchase_timeframe
      comment: "Estimated purchase timeframe expressed by the lead — used to prioritize follow-up and forecast near-term demand."
    - name: "rating"
      expr: rating
      comment: "Lead quality rating assigned by the sales team — used to assess lead scoring model effectiveness."
    - name: "is_online_lead"
      expr: is_online_lead
      comment: "Flag indicating whether the lead originated online — tracks digital channel contribution to lead volume."
    - name: "digital_lead_flag"
      expr: digital_lead_flag
      comment: "Flag indicating the lead came through a digital channel — supports digital vs. traditional channel mix analysis."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the lead was created — enables time-series trending of lead generation volume."
    - name: "lost_reason"
      expr: lost_reason
      comment: "Reason the lead was lost — identifies systemic issues in lead handling or product-market fit."
  measures:
    - name: "total_leads"
      expr: COUNT(1)
      comment: "Total number of leads generated — primary top-of-funnel volume KPI for marketing and sales planning."
    - name: "converted_lead_count"
      expr: COUNT(CASE WHEN lead_status = 'Converted' THEN 1 END)
      comment: "Number of leads successfully converted to opportunities — measures lead-to-opportunity conversion effectiveness."
    - name: "digital_lead_count"
      expr: COUNT(CASE WHEN digital_lead_flag = TRUE THEN 1 END)
      comment: "Number of leads originating from digital channels — tracks digital marketing contribution to the sales funnel."
    - name: "online_lead_count"
      expr: COUNT(CASE WHEN is_online_lead = TRUE THEN 1 END)
      comment: "Number of online-originated leads — measures e-commerce and digital retail channel effectiveness."
    - name: "test_drive_requested_count"
      expr: COUNT(CASE WHEN test_drive_requested = TRUE THEN 1 END)
      comment: "Number of leads that requested a test drive — a high-intent signal and key conversion milestone."
    - name: "trade_in_interest_count"
      expr: COUNT(CASE WHEN trade_in_interest = TRUE THEN 1 END)
      comment: "Number of leads expressing trade-in interest — informs used-vehicle acquisition pipeline and deal structuring."
    - name: "financing_interest_count"
      expr: COUNT(CASE WHEN financing_interest = TRUE THEN 1 END)
      comment: "Number of leads interested in financing — measures F&I product opportunity at the top of the funnel."
    - name: "total_estimated_budget"
      expr: SUM(CAST(estimated_budget_amount AS DOUBLE))
      comment: "Total estimated budget across all leads — proxy for addressable market value in the current lead pool."
    - name: "avg_estimated_budget"
      expr: AVG(CAST(estimated_budget_amount AS DOUBLE))
      comment: "Average estimated budget per lead — tracks lead quality and target segment alignment over time."
    - name: "unique_lead_parties"
      expr: COUNT(DISTINCT party_id)
      comment: "Number of distinct customers represented in the lead pool — measures unique demand reach and avoids double-counting."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quote-level KPIs covering pricing, discounting, F&I product attachment, and quote-to-order conversion. Enables pricing strategy, F&I performance, and sales process efficiency analysis."
  source: "`vibe_automotive_v1`.`sales`.`quote`"
  dimensions:
    - name: "quote_status"
      expr: quote_status
      comment: "Current status of the quote (e.g. Draft, Presented, Accepted, Rejected, Expired) — primary dimension for quote funnel analysis."
    - name: "quote_type"
      expr: quote_type
      comment: "Type of quote (e.g. Purchase, Lease, Subscription) — enables product-type mix analysis."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Channel through which the quote was generated — supports omnichannel pricing and conversion analysis."
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region associated with the quote — enables regional pricing and conversion benchmarking."
    - name: "financing_term_months"
      expr: financing_term_months
      comment: "Financing term in months offered on the quote — informs F&I product structuring and lender program analysis."
    - name: "credit_tier"
      expr: credit_tier
      comment: "Customer credit tier on the quote — used to analyze pricing and approval rates by credit quality."
    - name: "model_year"
      expr: model_year
      comment: "Model year of the quoted vehicle — supports vintage demand and pricing trend analysis."
    - name: "drivetrain"
      expr: drivetrain
      comment: "Drivetrain type of the quoted vehicle — enables product configuration demand analysis."
    - name: "converted_to_order"
      expr: converted_to_order
      comment: "Flag indicating whether the quote was converted to an order — primary dimension for quote conversion analysis."
    - name: "financing_offered"
      expr: financing_offered
      comment: "Flag indicating whether financing was offered on the quote — tracks F&I product presentation rates."
    - name: "lease_offered"
      expr: lease_offered
      comment: "Flag indicating whether a lease option was offered — monitors lease product penetration."
    - name: "quote_date_month"
      expr: DATE_TRUNC('month', quote_date)
      comment: "Quote date truncated to month — enables time-series analysis of quoting activity and conversion trends."
    - name: "is_certified_pre_owned"
      expr: is_certified_pre_owned
      comment: "Flag indicating whether the quote is for a CPO vehicle — tracks CPO program quoting and conversion performance."
  measures:
    - name: "total_quotes"
      expr: COUNT(1)
      comment: "Total number of quotes generated — baseline volume KPI for sales process activity and capacity."
    - name: "converted_quote_count"
      expr: COUNT(CASE WHEN converted_to_order = TRUE THEN 1 END)
      comment: "Number of quotes converted to orders — measures quote-to-order conversion effectiveness."
    - name: "total_net_selling_price"
      expr: SUM(CAST(net_selling_price AS DOUBLE))
      comment: "Total net selling price across all quotes — measures the aggregate transaction value being proposed to customers."
    - name: "total_msrp_base"
      expr: SUM(CAST(msrp_base AS DOUBLE))
      comment: "Total base MSRP across all quotes — baseline for computing discount depth and price realization at the quote stage."
    - name: "total_incentive_spend"
      expr: SUM(CAST(incentive_total AS DOUBLE))
      comment: "Total incentive value applied across all quotes — tracks incentive program cost and effectiveness."
    - name: "total_discount_from_msrp"
      expr: SUM(CAST(msrp_base AS DOUBLE) - CAST(net_selling_price AS DOUBLE))
      comment: "Total discount from MSRP across all quotes — measures aggregate pricing concession and margin risk."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all quotes — supports tax liability estimation and compliance reporting."
    - name: "total_trade_in_allowance"
      expr: SUM(CAST(trade_in_allowance AS DOUBLE))
      comment: "Total trade-in allowance offered across quotes — measures used-vehicle acquisition commitment at the quote stage."
    - name: "total_down_payment"
      expr: SUM(CAST(down_payment AS DOUBLE))
      comment: "Total down payment committed across quotes — informs cash flow forecasting and financing structure analysis."
    - name: "avg_net_selling_price"
      expr: AVG(CAST(net_selling_price AS DOUBLE))
      comment: "Average net selling price per quote — tracks average transaction value and product mix trends."
    - name: "avg_monthly_payment"
      expr: AVG(CAST(monthly_payment AS DOUBLE))
      comment: "Average estimated monthly payment across quotes — key affordability metric for F&I and product positioning decisions."
    - name: "avg_apr_rate"
      expr: AVG(CAST(apr_rate AS DOUBLE))
      comment: "Average APR rate offered across quotes — monitors lending rate competitiveness and F&I margin."
    - name: "financing_offered_count"
      expr: COUNT(CASE WHEN financing_offered = TRUE THEN 1 END)
      comment: "Number of quotes where financing was offered — tracks F&I product presentation compliance and penetration."
    - name: "lease_offered_count"
      expr: COUNT(CASE WHEN lease_offered = TRUE THEN 1 END)
      comment: "Number of quotes where a lease was offered — monitors lease product penetration and program utilization."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing campaign performance KPIs including budget utilization, market share attainment, and digital channel mix. Enables marketing ROI and campaign effectiveness analysis for CMO and sales leadership."
  source: "`vibe_automotive_v1`.`sales`.`campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign (e.g. Active, Completed, Paused) — used to filter and compare campaign lifecycle stages."
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (e.g. Launch, Incentive, Awareness) — enables campaign-type ROI comparison."
    - name: "target_customer_segment"
      expr: target_customer_segment
      comment: "Customer segment targeted by the campaign — supports segment-level marketing effectiveness analysis."
    - name: "target_model_year"
      expr: target_model_year
      comment: "Model year targeted by the campaign — aligns campaign performance to vehicle vintage strategy."
    - name: "digital_campaign_flag"
      expr: digital_campaign_flag
      comment: "Flag indicating whether the campaign is digital — enables digital vs. traditional campaign ROI comparison."
    - name: "digital_channel_flag"
      expr: digital_channel_flag
      comment: "Flag indicating whether the campaign uses digital channels — tracks digital channel investment and reach."
    - name: "dealer_participation_flag"
      expr: dealer_participation_flag
      comment: "Flag indicating dealer participation in the campaign — measures dealer network engagement in marketing programs."
    - name: "start_date_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Campaign start date truncated to month — enables time-series analysis of campaign launch cadence."
    - name: "priority"
      expr: priority
      comment: "Priority level of the campaign — used to analyze resource allocation relative to campaign importance."
    - name: "marketing_channels"
      expr: marketing_channels
      comment: "Marketing channels used in the campaign — supports channel mix and attribution analysis."
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of campaigns — baseline volume metric for marketing program portfolio management."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total marketing budget allocated across campaigns — primary input for marketing spend and ROI analysis."
    - name: "total_actual_spent"
      expr: SUM(CAST(actual_spent_amount AS DOUBLE))
      comment: "Total actual marketing spend across campaigns — measures realized marketing investment vs. plan."
    - name: "total_budget_variance"
      expr: SUM(CAST(actual_spent_amount AS DOUBLE) - CAST(budget_amount AS DOUBLE))
      comment: "Total variance between actual spend and budget across campaigns — identifies over/under-spend for budget management."
    - name: "avg_budget_amount"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per campaign — benchmarks campaign investment levels and informs future budget planning."
    - name: "avg_actual_spent"
      expr: AVG(CAST(actual_spent_amount AS DOUBLE))
      comment: "Average actual spend per campaign — tracks typical campaign execution cost for planning purposes."
    - name: "total_kpi_market_share_actual"
      expr: SUM(CAST(kpi_market_share_actual AS DOUBLE))
      comment: "Sum of actual market share KPI values across campaigns — aggregated market share attainment metric."
    - name: "avg_kpi_market_share_actual"
      expr: AVG(CAST(kpi_market_share_actual AS DOUBLE))
      comment: "Average actual market share KPI per campaign — measures campaign-level market share impact."
    - name: "avg_kpi_market_share_target"
      expr: AVG(CAST(kpi_market_share_target AS DOUBLE))
      comment: "Average target market share KPI per campaign — baseline for measuring attainment vs. plan."
    - name: "digital_campaign_count"
      expr: COUNT(CASE WHEN digital_campaign_flag = TRUE THEN 1 END)
      comment: "Number of digital campaigns — tracks digital marketing program volume and investment shift."
    - name: "dealer_participation_campaign_count"
      expr: COUNT(CASE WHEN dealer_participation_flag = TRUE THEN 1 END)
      comment: "Number of campaigns with dealer participation — measures dealer network engagement in co-op marketing programs."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_fleet_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fleet contract portfolio KPIs covering contract value, volume commitments, discount structures, and renewal pipeline. Enables fleet sales leadership to manage large-account revenue and contract performance."
  source: "`vibe_automotive_v1`.`sales`.`fleet_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the fleet contract (e.g. Active, Expired, Terminated, Pending) — primary dimension for portfolio health analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of fleet contract (e.g. National, Regional, Government) — enables segment-level fleet revenue analysis."
    - name: "financing_type"
      expr: financing_type
      comment: "Financing structure of the fleet contract — informs F&I and fleet financing program performance."
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region of the fleet contract — enables regional fleet business performance benchmarking."
    - name: "government_contract_flag"
      expr: government_contract_flag
      comment: "Flag indicating whether the contract is a government/GSA contract — separates public-sector fleet from commercial fleet."
    - name: "national_fleet_account_flag"
      expr: national_fleet_account_flag
      comment: "Flag indicating a national fleet account — used to track strategic large-account contract performance."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Flag indicating whether the contract auto-renews — tracks renewal pipeline and retention risk."
    - name: "maintenance_included_flag"
      expr: maintenance_included_flag
      comment: "Flag indicating whether maintenance is included in the contract — tracks bundled service revenue."
    - name: "subscription_model_flag"
      expr: subscription_model_flag
      comment: "Flag indicating a subscription-model fleet contract — monitors emerging fleet subscription revenue."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Contract effective start date truncated to month — enables cohort analysis of fleet contract origination."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the fleet contract — supports multi-currency fleet revenue reporting."
  measures:
    - name: "total_fleet_contracts"
      expr: COUNT(1)
      comment: "Total number of fleet contracts — baseline portfolio volume KPI for fleet sales management."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value_amount AS DOUBLE))
      comment: "Total value of all fleet contracts — primary revenue KPI for the fleet sales channel."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value_amount AS DOUBLE))
      comment: "Average fleet contract value — tracks deal size trends and account quality in the fleet portfolio."
    - name: "total_base_discount_percentage"
      expr: AVG(CAST(base_discount_percentage AS DOUBLE))
      comment: "Average base discount percentage across fleet contracts — monitors fleet pricing discipline and margin management."
    - name: "avg_volume_tier_discount"
      expr: AVG(CAST(volume_tier_discount_percentage AS DOUBLE))
      comment: "Average volume tier discount percentage — tracks volume incentive program cost and effectiveness."
    - name: "government_contract_count"
      expr: COUNT(CASE WHEN government_contract_flag = TRUE THEN 1 END)
      comment: "Number of government fleet contracts — tracks public-sector fleet business volume and strategic account penetration."
    - name: "national_fleet_account_count"
      expr: COUNT(CASE WHEN national_fleet_account_flag = TRUE THEN 1 END)
      comment: "Number of national fleet account contracts — measures strategic large-account portfolio size."
    - name: "auto_renewal_contract_count"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Number of contracts set for auto-renewal — measures retention pipeline strength in the fleet portfolio."
    - name: "subscription_contract_count"
      expr: COUNT(CASE WHEN subscription_model_flag = TRUE THEN 1 END)
      comment: "Number of subscription-model fleet contracts — tracks fleet subscription revenue model adoption."
    - name: "total_government_contract_value"
      expr: SUM(CASE WHEN government_contract_flag = TRUE THEN CAST(contract_value_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of government fleet contracts — measures public-sector revenue contribution to the fleet portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_trade_in`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade-in program KPIs covering appraisal accuracy, allowance levels, reconditioning costs, and CPO eligibility. Enables used-vehicle acquisition strategy and trade-in program profitability management."
  source: "`vibe_automotive_v1`.`sales`.`trade_in`"
  dimensions:
    - name: "condition_grade"
      expr: condition_grade
      comment: "Condition grade assigned to the trade-in vehicle — primary dimension for appraisal accuracy and reconditioning cost analysis."
    - name: "disposition_type"
      expr: disposition_type
      comment: "How the trade-in vehicle was disposed of (e.g. CPO, Auction, Wholesale) — enables disposition channel profitability analysis."
    - name: "make"
      expr: make
      comment: "Make of the trade-in vehicle — supports competitive conquest and brand loyalty analysis."
    - name: "model_year"
      expr: model_year
      comment: "Model year of the trade-in vehicle — enables vintage analysis of used-vehicle acquisition."
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type of the trade-in vehicle — informs electrification transition and used EV inventory strategy."
    - name: "title_status"
      expr: title_status
      comment: "Title status of the trade-in vehicle (e.g. Clean, Salvage, Rebuilt) — critical for risk and compliance in used-vehicle acquisition."
    - name: "cpo_eligible_flag"
      expr: cpo_eligible_flag
      comment: "Flag indicating whether the trade-in is eligible for CPO certification — tracks CPO pipeline from trade-in acquisitions."
    - name: "accident_history_flag"
      expr: accident_history_flag
      comment: "Flag indicating accident history on the trade-in — used to assess risk and adjust appraisal benchmarks."
    - name: "inspection_completed"
      expr: inspection_completed
      comment: "Flag indicating whether the inspection was completed — tracks process compliance in trade-in handling."
    - name: "appraisal_date_month"
      expr: DATE_TRUNC('month', appraisal_date)
      comment: "Appraisal date truncated to month — enables time-series analysis of trade-in volume and value trends."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the trade-in transaction — supports multi-currency used-vehicle reporting."
  measures:
    - name: "total_trade_ins"
      expr: COUNT(1)
      comment: "Total number of trade-in transactions — baseline volume KPI for used-vehicle acquisition program management."
    - name: "total_appraised_value"
      expr: SUM(CAST(appraised_value AS DOUBLE))
      comment: "Total appraised value of all trade-in vehicles — measures the aggregate used-vehicle acquisition value."
    - name: "total_allowance"
      expr: SUM(CAST(allowance AS DOUBLE))
      comment: "Total trade-in allowance granted to customers — measures the total credit extended in trade-in transactions."
    - name: "total_reconditioning_cost"
      expr: SUM(CAST(reconditioning_cost AS DOUBLE))
      comment: "Total reconditioning cost across all trade-ins — critical cost KPI for used-vehicle profitability management."
    - name: "total_disposition_amount"
      expr: SUM(CAST(disposition_amount AS DOUBLE))
      comment: "Total amount realized from trade-in dispositions — measures used-vehicle liquidation revenue."
    - name: "total_outstanding_loan_balance"
      expr: SUM(CAST(outstanding_loan_balance AS DOUBLE))
      comment: "Total outstanding loan balance across trade-ins — measures negative equity exposure in the trade-in portfolio."
    - name: "avg_appraised_value"
      expr: AVG(CAST(appraised_value AS DOUBLE))
      comment: "Average appraised value per trade-in — benchmarks appraisal levels and tracks used-vehicle market value trends."
    - name: "avg_allowance"
      expr: AVG(CAST(allowance AS DOUBLE))
      comment: "Average trade-in allowance per transaction — monitors allowance generosity and its impact on deal profitability."
    - name: "avg_reconditioning_cost"
      expr: AVG(CAST(reconditioning_cost AS DOUBLE))
      comment: "Average reconditioning cost per trade-in — tracks used-vehicle preparation cost efficiency."
    - name: "cpo_eligible_count"
      expr: COUNT(CASE WHEN cpo_eligible_flag = TRUE THEN 1 END)
      comment: "Number of CPO-eligible trade-ins — measures the CPO pipeline sourced from trade-in acquisitions."
    - name: "total_gross_profit_on_disposition"
      expr: SUM(CAST(disposition_amount AS DOUBLE) - CAST(allowance AS DOUBLE) - CAST(reconditioning_cost AS DOUBLE))
      comment: "Total gross profit on trade-in dispositions (disposition amount minus allowance and reconditioning cost) — key profitability KPI for the used-vehicle business."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_delivery_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle delivery experience KPIs covering appointment completion rates, PDI compliance, customer satisfaction, and digital delivery adoption. Enables delivery operations and customer experience management."
  source: "`vibe_automotive_v1`.`sales`.`delivery_appointment`"
  dimensions:
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current status of the delivery appointment (e.g. Scheduled, Completed, Cancelled, Rescheduled) — primary dimension for delivery pipeline analysis."
    - name: "delivery_type"
      expr: delivery_type
      comment: "Type of delivery (e.g. Dealer, Home, Remote) — enables delivery channel mix and cost analysis."
    - name: "delivery_location_type"
      expr: delivery_location_type
      comment: "Type of delivery location — supports logistics planning and home delivery program analysis."
    - name: "pdi_status"
      expr: pdi_status
      comment: "Pre-delivery inspection status — tracks PDI process compliance and quality gate performance."
    - name: "financing_status"
      expr: financing_status
      comment: "Financing status at time of delivery — identifies financing completion bottlenecks in the delivery process."
    - name: "documentation_status"
      expr: documentation_status
      comment: "Documentation completion status at delivery — tracks paperwork compliance and delivery readiness."
    - name: "home_delivery_flag"
      expr: home_delivery_flag
      comment: "Flag indicating home delivery — tracks home delivery program adoption and operational scale."
    - name: "digital_channel_flag"
      expr: digital_channel_flag
      comment: "Flag indicating digital channel delivery — monitors digital delivery experience adoption."
    - name: "connected_services_activated"
      expr: connected_services_activated
      comment: "Flag indicating whether connected services were activated at delivery — tracks connected vehicle onboarding rate."
    - name: "vehicle_orientation_completed"
      expr: vehicle_orientation_completed
      comment: "Flag indicating whether vehicle orientation was completed — measures delivery quality and customer education compliance."
    - name: "scheduled_delivery_date_month"
      expr: DATE_TRUNC('month', scheduled_delivery_date)
      comment: "Scheduled delivery date truncated to month — enables time-series analysis of delivery volume and scheduling patterns."
    - name: "delivery_country_code"
      expr: delivery_country_code
      comment: "Country code of the delivery location — supports geographic delivery operations analysis."
  measures:
    - name: "total_delivery_appointments"
      expr: COUNT(1)
      comment: "Total number of delivery appointments scheduled — baseline volume KPI for delivery operations capacity planning."
    - name: "completed_delivery_count"
      expr: COUNT(CASE WHEN appointment_status = 'Completed' THEN 1 END)
      comment: "Number of completed deliveries — measures delivery throughput and operational execution effectiveness."
    - name: "cancelled_delivery_count"
      expr: COUNT(CASE WHEN appointment_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled delivery appointments — tracks delivery failure rate and its impact on customer experience."
    - name: "home_delivery_count"
      expr: COUNT(CASE WHEN home_delivery_flag = TRUE THEN 1 END)
      comment: "Number of home deliveries — measures home delivery program scale and adoption."
    - name: "connected_services_activation_count"
      expr: COUNT(CASE WHEN connected_services_activated = TRUE THEN 1 END)
      comment: "Number of deliveries where connected services were activated — tracks connected vehicle onboarding rate at delivery."
    - name: "pdi_completed_count"
      expr: COUNT(CASE WHEN pdi_status = 'Completed' THEN 1 END)
      comment: "Number of deliveries with completed PDI — measures pre-delivery quality process compliance."
    - name: "vehicle_orientation_completed_count"
      expr: COUNT(CASE WHEN vehicle_orientation_completed = TRUE THEN 1 END)
      comment: "Number of deliveries where vehicle orientation was completed — tracks customer education compliance at delivery."
    - name: "digital_delivery_count"
      expr: COUNT(CASE WHEN digital_channel_flag = TRUE THEN 1 END)
      comment: "Number of deliveries through digital channels — monitors digital delivery experience adoption and scale."
    - name: "unique_customers_delivered"
      expr: COUNT(DISTINCT primary_delivery_customer_party_id)
      comment: "Number of distinct customers who received vehicle deliveries — measures unique customer delivery reach."
$$;