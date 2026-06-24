-- Metric views for domain: sales | Business: Automotive | Version: 2 | Generated on: 2026-06-23 04:49:37

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_vehicle_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core sales order KPIs tracking order volume, revenue, discounts, incentives, and channel mix — the primary steering dashboard for sales leadership."
  source: "`vibe_automotive_v1`.`sales`.`vehicle_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the vehicle order (e.g., confirmed, in-production, delivered, cancelled) for pipeline stage analysis."
    - name: "order_type"
      expr: order_type
      comment: "Type of order (retail, fleet, online, subscription) to segment revenue streams."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel through which the order was placed (dealer, direct, online, fleet) for channel performance analysis."
    - name: "sales_channel_type"
      expr: sales_channel_type
      comment: "Broader channel type classification for channel mix reporting."
    - name: "financing_type"
      expr: financing_type
      comment: "Financing method (cash, loan, lease, subscription) to understand F&I penetration."
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type (ICE, BEV, PHEV, HEV) for electrification mix tracking."
    - name: "model_year"
      expr: model_year
      comment: "Model year of the ordered vehicle for vintage and aging analysis."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the order for regional performance comparison."
    - name: "is_online_order"
      expr: is_online_order
      comment: "Flag indicating whether the order was placed through a digital/online channel."
    - name: "is_subscription"
      expr: is_subscription
      comment: "Flag indicating whether the order is a vehicle-as-a-service subscription order."
    - name: "is_certified_pre_owned"
      expr: is_certified_pre_owned
      comment: "Flag indicating whether the order is for a certified pre-owned vehicle."
    - name: "order_date"
      expr: order_date
      comment: "Date the order was placed for time-series trend analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the order for financial period reporting."
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of vehicle orders placed — primary volume KPI for sales leadership."
    - name: "total_order_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross order revenue (MSRP-based) across all vehicle orders — top-line revenue KPI."
    - name: "total_selling_price_revenue"
      expr: SUM(CAST(selling_price AS DOUBLE))
      comment: "Total net selling price revenue after negotiation — reflects actual realized revenue vs. MSRP."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount dollars given across all orders — key profitability and pricing discipline metric."
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total OEM/dealer incentive dollars applied to orders — measures incentive spend effectiveness."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across vehicle orders — required for financial reconciliation."
    - name: "total_trade_in_value"
      expr: SUM(CAST(trade_in_value AS DOUBLE))
      comment: "Total trade-in value credited across orders — indicates trade-in program utilization and used vehicle pipeline."
    - name: "avg_selling_price"
      expr: AVG(CAST(selling_price AS DOUBLE))
      comment: "Average net selling price per vehicle order — tracks pricing trends and mix shift impact."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per order — monitors pricing discipline and discount creep."
    - name: "avg_incentive_per_order"
      expr: AVG(CAST(incentive_amount AS DOUBLE))
      comment: "Average incentive spend per order — measures cost of incentive programs per unit sold."
    - name: "online_order_count"
      expr: SUM(CASE WHEN is_online_order = TRUE THEN 1 ELSE 0 END)
      comment: "Count of orders placed through digital/online channels — tracks e-commerce channel growth."
    - name: "subscription_order_count"
      expr: SUM(CASE WHEN is_subscription = TRUE THEN 1 ELSE 0 END)
      comment: "Count of subscription-model vehicle orders — tracks vehicle-as-a-service adoption."
    - name: "cpo_order_count"
      expr: SUM(CASE WHEN is_certified_pre_owned = TRUE THEN 1 ELSE 0 END)
      comment: "Count of certified pre-owned vehicle orders — tracks CPO program volume."
    - name: "total_msrp_value"
      expr: SUM(CAST(msrp AS DOUBLE))
      comment: "Total MSRP value of all ordered vehicles — baseline for discount and incentive rate calculations."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales pipeline and funnel KPIs tracking opportunity volume, estimated value, win rates, and conversion — essential for sales forecasting and pipeline management."
  source: "`vibe_automotive_v1`.`sales`.`opportunity`"
  dimensions:
    - name: "sales_stage"
      expr: sales_stage
      comment: "Current stage in the sales funnel (prospect, qualified, quoted, negotiation, closed) for pipeline stage analysis."
    - name: "opportunity_type"
      expr: opportunity_type
      comment: "Type of opportunity (new vehicle, CPO, fleet, subscription) for segment-level pipeline reporting."
    - name: "financing_type"
      expr: financing_type
      comment: "Financing type of interest (cash, loan, lease, subscription) for F&I pipeline planning."
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type of interest for electrification pipeline tracking."
    - name: "model_year"
      expr: model_year
      comment: "Model year of vehicle of interest for vintage mix in pipeline."
    - name: "lead_source"
      expr: lead_source
      comment: "Source of the lead that generated the opportunity (web, referral, campaign, walk-in) for lead quality analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the opportunity for regional pipeline comparison."
    - name: "is_won"
      expr: is_won
      comment: "Flag indicating whether the opportunity was won — used to segment won vs. lost pipeline."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the opportunity is currently active in the pipeline."
    - name: "is_certified_pre_owned_interest"
      expr: is_certified_pre_owned_interest
      comment: "Flag indicating CPO interest — tracks CPO pipeline separately from new vehicle pipeline."
    - name: "is_online_lead"
      expr: is_online_lead
      comment: "Flag indicating whether the opportunity originated from a digital/online lead."
    - name: "subscription_interest_flag"
      expr: subscription_interest_flag
      comment: "Flag indicating customer interest in subscription model — tracks subscription pipeline."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period-based pipeline reporting."
    - name: "expected_close_date"
      expr: expected_close_date
      comment: "Expected close date for pipeline aging and forecast timing analysis."
  measures:
    - name: "total_opportunities"
      expr: COUNT(1)
      comment: "Total number of sales opportunities in the pipeline — primary pipeline volume KPI."
    - name: "total_pipeline_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of all opportunities in the pipeline — top-line pipeline revenue forecast."
    - name: "total_won_opportunities"
      expr: SUM(CASE WHEN is_won = TRUE THEN 1 ELSE 0 END)
      comment: "Count of won opportunities — numerator for win rate calculation."
    - name: "total_active_opportunities"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of currently active (open) opportunities — active pipeline size."
    - name: "total_won_value"
      expr: SUM(CASE WHEN is_won = TRUE THEN estimated_value ELSE 0 END)
      comment: "Total estimated value of won opportunities — realized pipeline conversion value."
    - name: "avg_opportunity_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average estimated value per opportunity — tracks deal size trends and mix shift."
    - name: "avg_probability"
      expr: AVG(CAST(probability AS DOUBLE))
      comment: "Average win probability across pipeline opportunities — weighted pipeline health indicator."
    - name: "total_discount_offered"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount offered across opportunities — measures pricing pressure in the pipeline."
    - name: "total_incentive_offered"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive amount offered across opportunities — measures incentive commitment in pipeline."
    - name: "subscription_pipeline_count"
      expr: SUM(CASE WHEN subscription_interest_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of opportunities with subscription interest — tracks vehicle-as-a-service pipeline growth."
    - name: "online_lead_opportunity_count"
      expr: SUM(CASE WHEN is_online_lead = TRUE THEN 1 ELSE 0 END)
      comment: "Count of opportunities originating from online/digital leads — measures digital channel pipeline contribution."
    - name: "weighted_pipeline_value"
      expr: SUM(CAST(estimated_value AS DOUBLE) * CAST(probability AS DOUBLE) / 100.0)
      comment: "Probability-weighted pipeline value — the most accurate revenue forecast metric for sales leadership."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_lead`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead generation and qualification KPIs tracking lead volume, source effectiveness, digital penetration, and conversion readiness — drives marketing ROI and sales funnel optimization."
  source: "`vibe_automotive_v1`.`sales`.`lead`"
  dimensions:
    - name: "lead_status"
      expr: lead_status
      comment: "Current status of the lead (new, contacted, qualified, converted, lost) for funnel stage analysis."
    - name: "lead_type"
      expr: lead_type
      comment: "Type of lead (individual, fleet, CPO, subscription) for segment-level lead analysis."
    - name: "lead_source"
      expr: source
      comment: "Source channel that generated the lead (web, referral, campaign, event, walk-in) for marketing attribution."
    - name: "vehicle_interest_category"
      expr: vehicle_interest_category
      comment: "Vehicle category of interest (SUV, sedan, truck, EV) for product demand signal analysis."
    - name: "vehicle_model_interest"
      expr: vehicle_model_interest
      comment: "Specific model of interest for model-level demand forecasting."
    - name: "model_year_interest"
      expr: model_year_interest
      comment: "Model year of interest for vintage demand planning."
    - name: "purchase_timeframe"
      expr: purchase_timeframe
      comment: "Customer's stated purchase timeframe (immediate, 1-3 months, 3-6 months, 6+ months) for pipeline urgency scoring."
    - name: "digital_lead_flag"
      expr: digital_lead_flag
      comment: "Flag indicating whether the lead originated from a digital channel — tracks digital lead penetration."
    - name: "is_online_lead"
      expr: is_online_lead
      comment: "Flag indicating whether the lead came through an online channel specifically."
    - name: "cpo_interest_flag"
      expr: cpo_interest_flag
      comment: "Flag indicating CPO interest — tracks CPO demand pipeline."
    - name: "subscription_interest_flag"
      expr: subscription_interest_flag
      comment: "Flag indicating subscription model interest — tracks vehicle-as-a-service demand."
    - name: "financing_interest"
      expr: financing_interest
      comment: "Flag indicating F&I interest — tracks financing product demand."
    - name: "region"
      expr: region
      comment: "Geographic region of the lead for regional demand analysis."
    - name: "created_timestamp"
      expr: created_timestamp
      comment: "Timestamp when the lead was created for lead velocity and aging analysis."
  measures:
    - name: "total_leads"
      expr: COUNT(1)
      comment: "Total number of leads generated — primary lead volume KPI for marketing and sales."
    - name: "converted_leads"
      expr: SUM(CASE WHEN lead_status = 'Converted' THEN 1 ELSE 0 END)
      comment: "Count of leads converted to opportunities — numerator for lead conversion rate."
    - name: "digital_leads"
      expr: SUM(CASE WHEN digital_lead_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of leads from digital channels — tracks digital channel lead generation effectiveness."
    - name: "online_leads"
      expr: SUM(CASE WHEN is_online_lead = TRUE THEN 1 ELSE 0 END)
      comment: "Count of leads from online channels specifically — measures e-commerce funnel entry volume."
    - name: "cpo_interest_leads"
      expr: SUM(CASE WHEN cpo_interest_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of leads with CPO interest — measures CPO program demand generation."
    - name: "subscription_interest_leads"
      expr: SUM(CASE WHEN subscription_interest_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of leads with subscription model interest — tracks vehicle-as-a-service demand pipeline."
    - name: "financing_interest_leads"
      expr: SUM(CASE WHEN financing_interest = TRUE THEN 1 ELSE 0 END)
      comment: "Count of leads with financing interest — measures F&I product demand from top of funnel."
    - name: "avg_estimated_budget"
      expr: AVG(CAST(estimated_budget_amount AS DOUBLE))
      comment: "Average estimated budget of leads — tracks deal size potential at top of funnel."
    - name: "total_estimated_budget"
      expr: SUM(CAST(estimated_budget_amount AS DOUBLE))
      comment: "Total estimated budget across all leads — measures total addressable pipeline value at lead stage."
    - name: "unique_lead_sources"
      expr: COUNT(DISTINCT source)
      comment: "Number of distinct lead sources active — measures breadth of lead generation channel diversity."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quote-to-order conversion and pricing KPIs tracking quote volume, value, F&I attachment, and conversion — critical for sales effectiveness and pricing strategy."
  source: "`vibe_automotive_v1`.`sales`.`quote`"
  dimensions:
    - name: "quote_status"
      expr: quote_status
      comment: "Current status of the quote (draft, presented, accepted, rejected, expired) for funnel stage analysis."
    - name: "quote_type"
      expr: quote_type
      comment: "Type of quote (retail, fleet, CPO, lease, subscription) for segment-level quote analysis."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel through which the quote was generated for channel effectiveness analysis."
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type quoted for electrification mix tracking."
    - name: "model_year"
      expr: model_year
      comment: "Model year of the quoted vehicle for vintage mix analysis."
    - name: "converted_to_order"
      expr: converted_to_order
      comment: "Flag indicating whether the quote was converted to an order — used to segment converted vs. unconverted quotes."
    - name: "is_certified_pre_owned"
      expr: is_certified_pre_owned
      comment: "Flag indicating whether the quote is for a CPO vehicle."
    - name: "financing_offered"
      expr: financing_offered
      comment: "Flag indicating whether financing was offered in the quote."
    - name: "lease_offered"
      expr: lease_offered
      comment: "Flag indicating whether a lease option was offered in the quote."
    - name: "gap_insurance_flag"
      expr: gap_insurance_flag
      comment: "Flag indicating whether GAP insurance was included in the quote."
    - name: "extended_warranty_flag"
      expr: extended_warranty_flag
      comment: "Flag indicating whether an extended warranty was included in the quote."
    - name: "subscription_option_flag"
      expr: subscription_option_flag
      comment: "Flag indicating whether a subscription option was offered in the quote."
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region of the quote for regional performance analysis."
    - name: "quote_date"
      expr: quote_date
      comment: "Date the quote was generated for time-series trend analysis."
  measures:
    - name: "total_quotes"
      expr: COUNT(1)
      comment: "Total number of quotes generated — primary quote volume KPI."
    - name: "converted_quotes"
      expr: SUM(CASE WHEN converted_to_order = TRUE THEN 1 ELSE 0 END)
      comment: "Count of quotes converted to orders — numerator for quote-to-order conversion rate."
    - name: "total_quoted_msrp"
      expr: SUM(CAST(msrp_base AS DOUBLE))
      comment: "Total MSRP value across all quotes — measures total quoted vehicle value."
    - name: "total_net_selling_price"
      expr: SUM(CAST(net_selling_price AS DOUBLE))
      comment: "Total net selling price across all quotes — measures actual revenue potential in quote pipeline."
    - name: "total_incentive_total"
      expr: SUM(CAST(incentive_total AS DOUBLE))
      comment: "Total incentive value offered across all quotes — measures incentive spend commitment in quote pipeline."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all quotes — required for financial planning and compliance."
    - name: "total_trade_in_allowance"
      expr: SUM(CAST(trade_in_allowance AS DOUBLE))
      comment: "Total trade-in allowance offered across quotes — measures trade-in program utilization."
    - name: "avg_net_selling_price"
      expr: AVG(CAST(net_selling_price AS DOUBLE))
      comment: "Average net selling price per quote — tracks average deal size and pricing trends."
    - name: "avg_monthly_payment"
      expr: AVG(CAST(monthly_payment AS DOUBLE))
      comment: "Average monthly payment quoted — key metric for affordability and F&I product positioning."
    - name: "avg_lease_monthly_payment"
      expr: AVG(CAST(lease_monthly_payment AS DOUBLE))
      comment: "Average monthly lease payment quoted — tracks lease product competitiveness."
    - name: "avg_down_payment"
      expr: AVG(CAST(down_payment AS DOUBLE))
      comment: "Average down payment across quotes — measures customer equity contribution and financing structure."
    - name: "financing_offered_quotes"
      expr: SUM(CASE WHEN financing_offered = TRUE THEN 1 ELSE 0 END)
      comment: "Count of quotes with financing offered — measures F&I product attachment at quote stage."
    - name: "lease_offered_quotes"
      expr: SUM(CASE WHEN lease_offered = TRUE THEN 1 ELSE 0 END)
      comment: "Count of quotes with lease option offered — measures lease product penetration."
    - name: "subscription_option_quotes"
      expr: SUM(CASE WHEN subscription_option_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of quotes with subscription option — tracks vehicle-as-a-service quote penetration."
    - name: "total_quote_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross quote value including all fees and taxes — measures total quote pipeline value."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing campaign performance KPIs tracking spend, ROI, market share impact, and digital effectiveness — drives marketing investment decisions."
  source: "`vibe_automotive_v1`.`sales`.`campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign (planned, active, completed, cancelled) for portfolio management."
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (awareness, conquest, retention, launch, incentive) for campaign mix analysis."
    - name: "digital_campaign_flag"
      expr: digital_campaign_flag
      comment: "Flag indicating whether the campaign is a digital campaign — tracks digital marketing investment."
    - name: "digital_channel_flag"
      expr: digital_channel_flag
      comment: "Flag indicating whether the campaign uses digital channels."
    - name: "dealer_participation_flag"
      expr: dealer_participation_flag
      comment: "Flag indicating whether dealers participate in the campaign — measures dealer co-op program engagement."
    - name: "target_customer_segment"
      expr: target_customer_segment
      comment: "Target customer segment for the campaign for audience effectiveness analysis."
    - name: "target_nameplate"
      expr: target_nameplate
      comment: "Target vehicle nameplate for the campaign for model-level marketing attribution."
    - name: "target_model_year"
      expr: target_model_year
      comment: "Target model year for the campaign for vintage-specific marketing analysis."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the campaign for regional marketing spend analysis."
    - name: "start_date"
      expr: start_date
      comment: "Campaign start date for time-series marketing spend analysis."
    - name: "end_date"
      expr: end_date
      comment: "Campaign end date for campaign duration and timing analysis."
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of marketing campaigns — measures marketing program breadth."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total marketing budget committed across all campaigns — primary marketing investment KPI."
    - name: "total_actual_spent"
      expr: SUM(CAST(actual_spent_amount AS DOUBLE))
      comment: "Total actual marketing spend across all campaigns — measures realized marketing investment."
    - name: "avg_budget_per_campaign"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per campaign — tracks campaign investment sizing trends."
    - name: "avg_actual_spent_per_campaign"
      expr: AVG(CAST(actual_spent_amount AS DOUBLE))
      comment: "Average actual spend per campaign — measures typical campaign execution cost."
    - name: "total_kpi_market_share_actual"
      expr: SUM(CAST(kpi_market_share_actual AS DOUBLE))
      comment: "Sum of actual market share KPI values across campaigns — aggregate market share impact measure."
    - name: "avg_kpi_market_share_actual"
      expr: AVG(CAST(kpi_market_share_actual AS DOUBLE))
      comment: "Average actual market share KPI across campaigns — measures average market share impact per campaign."
    - name: "avg_kpi_market_share_target"
      expr: AVG(CAST(kpi_market_share_target AS DOUBLE))
      comment: "Average target market share KPI across campaigns — baseline for market share attainment analysis."
    - name: "digital_campaign_count"
      expr: SUM(CASE WHEN digital_campaign_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of digital campaigns — tracks digital marketing program growth."
    - name: "dealer_participation_campaign_count"
      expr: SUM(CASE WHEN dealer_participation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of campaigns with dealer participation — measures dealer co-op program scale."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_fi_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Finance & Insurance application KPIs tracking application volume, approval rates, loan amounts, and product penetration — critical for F&I revenue and compliance management."
  source: "`vibe_automotive_v1`.`sales`.`fi_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the F&I application (submitted, approved, declined, funded) for pipeline stage analysis."
    - name: "application_type"
      expr: application_type
      comment: "Type of F&I application (loan, lease, balloon) for product mix analysis."
    - name: "fi_product_type"
      expr: fi_product_type
      comment: "Type of F&I product (GAP, extended warranty, paint protection) for product penetration analysis."
    - name: "employment_status"
      expr: employment_status
      comment: "Applicant employment status for credit risk segmentation."
    - name: "credit_bureau_source"
      expr: credit_bureau_source
      comment: "Credit bureau used for the application for data quality and compliance tracking."
    - name: "market_country_code"
      expr: market_country_code
      comment: "Market country of the application for geographic F&I performance analysis."
    - name: "adverse_action_notice_sent"
      expr: adverse_action_notice_sent
      comment: "Flag indicating whether an adverse action notice was sent — critical compliance metric."
    - name: "regulatory_disclosure_flag"
      expr: regulatory_disclosure_flag
      comment: "Flag indicating whether required regulatory disclosures were made — compliance tracking."
    - name: "submission_timestamp"
      expr: submission_timestamp
      comment: "Timestamp of application submission for application velocity and aging analysis."
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of F&I applications submitted — primary F&I volume KPI."
    - name: "approved_applications"
      expr: SUM(CASE WHEN application_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Count of approved F&I applications — numerator for approval rate calculation."
    - name: "funded_applications"
      expr: SUM(CASE WHEN application_status = 'Funded' THEN 1 ELSE 0 END)
      comment: "Count of funded F&I applications — measures actual F&I revenue realization."
    - name: "declined_applications"
      expr: SUM(CASE WHEN application_status = 'Declined' THEN 1 ELSE 0 END)
      comment: "Count of declined F&I applications — tracks credit quality and lender selectivity."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved loan/lease amount across all F&I applications — measures F&I portfolio size."
    - name: "total_requested_amount"
      expr: SUM(CAST(requested_amount AS DOUBLE))
      comment: "Total requested financing amount — measures total F&I demand."
    - name: "total_down_payment"
      expr: SUM(CAST(down_payment_amount AS DOUBLE))
      comment: "Total down payment collected across F&I applications — measures customer equity contribution."
    - name: "total_fi_product_premium"
      expr: SUM(CAST(fi_product_premium AS DOUBLE))
      comment: "Total F&I product premium revenue (GAP, warranty, etc.) — key F&I profitability KPI."
    - name: "total_dealer_reserve"
      expr: SUM(CAST(dealer_reserve_amount AS DOUBLE))
      comment: "Total dealer reserve earned across F&I applications — measures dealer F&I profit contribution."
    - name: "avg_approved_amount"
      expr: AVG(CAST(approved_amount AS DOUBLE))
      comment: "Average approved financing amount — tracks average deal size and credit quality trends."
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average interest rate across approved applications — monitors rate environment and lender competitiveness."
    - name: "avg_monthly_payment"
      expr: AVG(CAST(monthly_payment_amount AS DOUBLE))
      comment: "Average monthly payment across F&I applications — tracks affordability and payment structure trends."
    - name: "adverse_action_count"
      expr: SUM(CASE WHEN adverse_action_notice_sent = TRUE THEN 1 ELSE 0 END)
      comment: "Count of applications requiring adverse action notices — critical compliance and fair lending KPI."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_fi_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "F&I contract portfolio KPIs tracking financed volume, contract terms, product attachment, and portfolio health — drives F&I revenue management and captive finance strategy."
  source: "`vibe_automotive_v1`.`sales`.`contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the F&I contract (active, completed, defaulted, terminated) for portfolio health monitoring."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of F&I contract (retail installment, lease, balloon) for product mix analysis."
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of active F&I contracts — primary portfolio volume KPI."
    - name: "total_down_payment"
      expr: SUM(CAST(down_payment_amount AS DOUBLE))
      comment: "Total down payment collected across contracts — measures customer equity in portfolio."
    - name: "avg_monthly_payment"
      expr: AVG(CAST(monthly_payment_amount AS DOUBLE))
      comment: "Average monthly payment across contracts — tracks affordability and payment structure."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_fleet_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fleet sales contract KPIs tracking fleet volume commitments, contract values, delivery performance, and program utilization — essential for fleet channel management."
  source: "`vibe_automotive_v1`.`sales`.`fleet_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the fleet contract (active, completed, terminated, pending) for portfolio management."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of fleet contract (government, commercial, rental, subscription) for fleet segment analysis."
    - name: "financing_type"
      expr: financing_type
      comment: "Financing type for the fleet contract for F&I fleet product analysis."
    - name: "government_contract_flag"
      expr: government_contract_flag
      comment: "Flag indicating government fleet contract — tracks public sector fleet business."
    - name: "national_fleet_account_flag"
      expr: national_fleet_account_flag
      comment: "Flag indicating national fleet account — tracks strategic large fleet customer contracts."
    - name: "subscription_model_flag"
      expr: subscription_model_flag
      comment: "Flag indicating subscription-based fleet contract — tracks fleet-as-a-service adoption."
    - name: "maintenance_included_flag"
      expr: maintenance_included_flag
      comment: "Flag indicating maintenance is included in the fleet contract — tracks full-service fleet penetration."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Flag indicating auto-renewal — tracks contract retention and renewal pipeline."
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region of the fleet contract for regional fleet performance analysis."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Contract effective start date for fleet portfolio vintage analysis."
  measures:
    - name: "total_fleet_contracts"
      expr: COUNT(1)
      comment: "Total number of fleet contracts — primary fleet channel volume KPI."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value_amount AS DOUBLE))
      comment: "Total value of all fleet contracts — primary fleet revenue KPI."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value_amount AS DOUBLE))
      comment: "Average fleet contract value — tracks deal size trends in fleet channel."
    - name: "avg_base_discount_percentage"
      expr: AVG(CAST(base_discount_percentage AS DOUBLE))
      comment: "Average base discount percentage across fleet contracts — monitors fleet pricing discipline."
    - name: "avg_volume_tier_discount"
      expr: AVG(CAST(volume_tier_discount_percentage AS DOUBLE))
      comment: "Average volume tier discount percentage — measures volume incentive program cost."
    - name: "government_contract_count"
      expr: SUM(CASE WHEN government_contract_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of government fleet contracts — tracks public sector fleet business volume."
    - name: "national_fleet_account_count"
      expr: SUM(CASE WHEN national_fleet_account_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of national fleet account contracts — tracks strategic large fleet customer relationships."
    - name: "subscription_fleet_contracts"
      expr: SUM(CASE WHEN subscription_model_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of subscription-model fleet contracts — tracks fleet-as-a-service adoption."
    - name: "maintenance_included_contracts"
      expr: SUM(CASE WHEN maintenance_included_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of fleet contracts with maintenance included — measures full-service fleet penetration."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_win_loss`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Win/loss analysis KPIs tracking competitive outcomes, deal values, and decision factors — drives competitive strategy and sales effectiveness improvement."
  source: "`vibe_automotive_v1`.`sales`.`win_loss`"
  dimensions:
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the sales opportunity (won, lost) for win rate calculation."
    - name: "primary_reason_code"
      expr: primary_reason_code
      comment: "Primary reason code for win or loss — identifies top competitive and operational factors."
    - name: "secondary_reason_code"
      expr: secondary_reason_code
      comment: "Secondary reason code for win or loss — provides additional context for competitive analysis."
    - name: "opportunity_type"
      expr: opportunity_type
      comment: "Type of opportunity (retail, fleet, CPO) for segment-level win/loss analysis."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel of the opportunity for channel-level win rate analysis."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region for regional competitive performance analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period-based win/loss trend analysis."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for quarterly competitive performance review."
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle in the opportunity for vintage-level competitive analysis."
    - name: "customer_decision_factor_price"
      expr: CASE WHEN customer_decision_factor_price > 0 THEN 'Price Factor' ELSE 'Non-Price Factor' END
      comment: "Whether price was a significant customer decision factor — segments price-sensitive vs. non-price-sensitive deals."
    - name: "fi_factor_flag"
      expr: fi_factor_flag
      comment: "Flag indicating F&I was a decision factor — measures F&I impact on win/loss outcomes."
    - name: "outcome_date"
      expr: outcome_date
      comment: "Date of the win/loss outcome for time-series competitive trend analysis."
  measures:
    - name: "total_outcomes"
      expr: COUNT(1)
      comment: "Total number of win/loss records analyzed — primary competitive analysis volume KPI."
    - name: "total_wins"
      expr: SUM(CASE WHEN outcome = 'Won' THEN 1 ELSE 0 END)
      comment: "Total number of won opportunities — numerator for win rate calculation."
    - name: "total_losses"
      expr: SUM(CASE WHEN outcome = 'Lost' THEN 1 ELSE 0 END)
      comment: "Total number of lost opportunities — measures competitive loss volume."
    - name: "total_deal_value"
      expr: SUM(CAST(deal_value AS DOUBLE))
      comment: "Total deal value across all win/loss outcomes — measures total competitive opportunity value."
    - name: "total_won_deal_value"
      expr: SUM(CASE WHEN outcome = 'Won' THEN deal_value ELSE 0 END)
      comment: "Total deal value of won opportunities — measures revenue captured from competitive situations."
    - name: "total_lost_deal_value"
      expr: SUM(CASE WHEN outcome = 'Lost' THEN deal_value ELSE 0 END)
      comment: "Total deal value of lost opportunities — measures revenue lost to competition."
    - name: "avg_deal_value"
      expr: AVG(CAST(deal_value AS DOUBLE))
      comment: "Average deal value across all competitive outcomes — tracks deal size in competitive situations."
    - name: "avg_competitor_price"
      expr: AVG(CAST(competitor_price AS DOUBLE))
      comment: "Average competitor price in competitive situations — tracks competitive pricing intelligence."
    - name: "price_factor_outcomes"
      expr: SUM(CASE WHEN customer_decision_factor_price > 0 THEN 1 ELSE 0 END)
      comment: "Count of outcomes where price was a customer decision factor — measures price sensitivity in competitive deals."
    - name: "fi_factor_outcomes"
      expr: SUM(CASE WHEN fi_factor_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of outcomes where F&I was a decision factor — measures F&I competitive impact."
    - name: "brand_factor_wins"
      expr: SUM(CASE WHEN customer_decision_factor_brand = TRUE AND outcome = 'Won' THEN 1 ELSE 0 END)
      comment: "Count of wins where brand was a decision factor — measures brand equity contribution to sales success."
    - name: "features_factor_wins"
      expr: SUM(CASE WHEN customer_decision_factor_features = TRUE AND outcome = 'Won' THEN 1 ELSE 0 END)
      comment: "Count of wins where features were a decision factor — measures product feature competitiveness."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_incentive_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales incentive program KPIs tracking program budgets, incentive rates, and eligibility — drives incentive spend optimization and program effectiveness."
  source: "`vibe_automotive_v1`.`sales`.`sales_incentive_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current status of the incentive program (active, expired, planned) for program portfolio management."
    - name: "program_type"
      expr: program_type
      comment: "Type of incentive program (cash back, rate subvention, loyalty, conquest) for program mix analysis."
    - name: "incentive_type"
      expr: incentive_type
      comment: "Specific incentive type for granular program categorization."
    - name: "region"
      expr: region
      comment: "Geographic region of the program for regional incentive spend analysis."
    - name: "active_flag"
      expr: active_flag
      comment: "Flag indicating whether the program is currently active."
    - name: "digital_channel_eligible_flag"
      expr: digital_channel_eligible_flag
      comment: "Flag indicating whether the program is eligible for digital channel — tracks digital incentive coverage."
    - name: "subscription_eligible_flag"
      expr: subscription_eligible_flag
      comment: "Flag indicating whether the program is eligible for subscription orders — tracks subscription incentive support."
    - name: "start_date"
      expr: start_date
      comment: "Program start date for incentive program timing analysis."
    - name: "end_date"
      expr: end_date
      comment: "Program end date for program duration and expiry management."
  measures:
    - name: "total_programs"
      expr: COUNT(1)
      comment: "Total number of incentive programs — measures incentive program portfolio breadth."
    - name: "active_programs"
      expr: SUM(CASE WHEN active_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of currently active incentive programs — measures active incentive portfolio size."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget committed across all incentive programs — primary incentive investment KPI."
    - name: "avg_incentive_amount"
      expr: AVG(CAST(incentive_amount AS DOUBLE))
      comment: "Average incentive amount per program — tracks typical incentive level and cost per unit."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate across incentive programs — monitors incentive pricing strategy."
    - name: "avg_incentive_rate"
      expr: AVG(CAST(incentive_rate AS DOUBLE))
      comment: "Average incentive rate across programs — tracks incentive intensity trends."
    - name: "digital_eligible_programs"
      expr: SUM(CASE WHEN digital_channel_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of programs eligible for digital channels — measures digital incentive coverage."
    - name: "subscription_eligible_programs"
      expr: SUM(CASE WHEN subscription_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of programs eligible for subscription orders — tracks subscription incentive support breadth."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_incentive_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incentive claim processing KPIs tracking claim volume, approval rates, payout amounts, and processing efficiency — drives incentive program financial control."
  source: "`vibe_automotive_v1`.`sales`.`sales_incentive_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the incentive claim (submitted, approved, rejected, paid) for claim pipeline management."
    - name: "digital_channel_flag"
      expr: digital_channel_flag
      comment: "Flag indicating whether the claim is from a digital channel order."
    - name: "claim_date"
      expr: claim_date
      comment: "Date the claim was submitted for time-series claim volume analysis."
    - name: "payment_date"
      expr: payment_date
      comment: "Date the claim was paid for payment timing and cash flow analysis."
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of incentive claims submitted — primary claim volume KPI."
    - name: "approved_claims"
      expr: SUM(CASE WHEN claim_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Count of approved incentive claims — numerator for claim approval rate."
    - name: "rejected_claims"
      expr: SUM(CASE WHEN claim_status = 'Rejected' THEN 1 ELSE 0 END)
      comment: "Count of rejected incentive claims — measures claim quality and compliance issues."
    - name: "paid_claims"
      expr: SUM(CASE WHEN claim_status = 'Paid' THEN 1 ELSE 0 END)
      comment: "Count of paid incentive claims — measures actual incentive payout volume."
    - name: "total_claim_amount"
      expr: SUM(CAST(claim_amount AS DOUBLE))
      comment: "Total claimed incentive amount — measures total incentive liability submitted."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved incentive payout amount — measures actual incentive spend committed."
    - name: "avg_claim_amount"
      expr: AVG(CAST(claim_amount AS DOUBLE))
      comment: "Average incentive claim amount — tracks typical claim size and incentive per unit."
    - name: "avg_approved_amount"
      expr: AVG(CAST(approved_amount AS DOUBLE))
      comment: "Average approved incentive amount — tracks typical approved payout per claim."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_configurator_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Online vehicle configurator KPIs tracking session volume, conversion, configured prices, and digital engagement — drives e-commerce and digital sales channel optimization."
  source: "`vibe_automotive_v1`.`sales`.`configurator_session`"
  dimensions:
    - name: "session_status"
      expr: session_status
      comment: "Status of the configurator session (active, saved, converted, abandoned) for funnel analysis."
    - name: "channel"
      expr: channel
      comment: "Channel through which the configurator was accessed (web, mobile, dealer kiosk) for channel analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device type used for the configurator session (desktop, mobile, tablet) for UX optimization."
    - name: "market_country_code"
      expr: market_country_code
      comment: "Market country of the session for geographic demand analysis."
    - name: "geo_region"
      expr: geo_region
      comment: "Geographic region of the session for regional digital engagement analysis."
    - name: "conversion_flag"
      expr: conversion_flag
      comment: "Flag indicating whether the session converted to a lead or order — primary conversion indicator."
    - name: "fi_interest_flag"
      expr: fi_interest_flag
      comment: "Flag indicating F&I interest expressed during configuration — measures F&I demand at top of funnel."
    - name: "subscription_interest_flag"
      expr: subscription_interest_flag
      comment: "Flag indicating subscription interest during configuration — tracks vehicle-as-a-service digital demand."
    - name: "selected_powertrain"
      expr: selected_powertrain
      comment: "Powertrain selected during configuration for electrification demand analysis."
    - name: "session_start_timestamp"
      expr: session_start_timestamp
      comment: "Session start timestamp for time-series digital engagement analysis."
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total number of configurator sessions — primary digital engagement volume KPI."
    - name: "converted_sessions"
      expr: SUM(CASE WHEN conversion_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of sessions that converted to a lead or order — measures configurator conversion effectiveness."
    - name: "fi_interest_sessions"
      expr: SUM(CASE WHEN fi_interest_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of sessions with F&I interest — measures F&I demand generation from digital configurator."
    - name: "subscription_interest_sessions"
      expr: SUM(CASE WHEN subscription_interest_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of sessions with subscription interest — tracks vehicle-as-a-service digital demand."
    - name: "total_configured_price"
      expr: SUM(CAST(total_configured_price AS DOUBLE))
      comment: "Total configured vehicle price across all sessions — measures total digital pipeline value."
    - name: "avg_configured_price"
      expr: AVG(CAST(total_configured_price AS DOUBLE))
      comment: "Average configured vehicle price — tracks average deal size in digital channel."
    - name: "avg_monthly_payment_estimate"
      expr: AVG(CAST(monthly_payment_estimate AS DOUBLE))
      comment: "Average monthly payment estimate shown during configuration — tracks affordability positioning in digital channel."
    - name: "avg_trade_in_estimate"
      expr: AVG(CAST(trade_in_estimate_amount AS DOUBLE))
      comment: "Average trade-in estimate provided during configuration — measures trade-in program digital engagement."
    - name: "total_trade_in_estimate"
      expr: SUM(CAST(trade_in_estimate_amount AS DOUBLE))
      comment: "Total trade-in estimate value across sessions — measures total trade-in pipeline from digital channel."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_quota`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales quota attainment KPIs tracking quota targets, thresholds, and incentive eligibility — drives sales performance management and compensation planning."
  source: "`vibe_automotive_v1`.`sales`.`quota`"
  dimensions:
    - name: "quota_status"
      expr: quota_status
      comment: "Current status of the quota (draft, approved, active, closed) for quota lifecycle management."
    - name: "quota_type"
      expr: quota_type
      comment: "Type of quota (unit volume, revenue, market share, subscription) for quota mix analysis."
    - name: "assignee_type"
      expr: assignee_type
      comment: "Type of quota assignee (rep, dealer, territory, region) for organizational performance analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the quota for governance and planning process tracking."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the quota for annual planning cycle analysis."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the quota for quarterly performance management."
    - name: "fiscal_month"
      expr: fiscal_month
      comment: "Fiscal month of the quota for monthly performance tracking."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the quota for regional performance comparison."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel of the quota for channel-level performance management."
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type focus of the quota for electrification target tracking."
    - name: "incentive_eligible"
      expr: incentive_eligible
      comment: "Flag indicating whether the quota is incentive-eligible — tracks compensation-linked quota coverage."
    - name: "period_start_date"
      expr: period_start_date
      comment: "Quota period start date for time-series quota planning analysis."
  measures:
    - name: "total_quotas"
      expr: COUNT(1)
      comment: "Total number of quota records — measures quota assignment breadth across the sales organization."
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Total quota target value across all assignments — measures total sales organization target."
    - name: "total_threshold_minimum"
      expr: SUM(CAST(threshold_minimum AS DOUBLE))
      comment: "Total minimum threshold value across quotas — measures minimum acceptable performance baseline."
    - name: "total_threshold_stretch"
      expr: SUM(CAST(threshold_stretch AS DOUBLE))
      comment: "Total stretch target value across quotas — measures aspirational performance ceiling."
    - name: "total_subscription_quota"
      expr: SUM(CAST(subscription_quota_amount AS DOUBLE))
      comment: "Total subscription quota amount across assignments — tracks vehicle-as-a-service sales targets."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average quota target value per assignment — tracks typical quota sizing and fairness."
    - name: "incentive_eligible_quotas"
      expr: SUM(CASE WHEN incentive_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incentive-eligible quota assignments — measures compensation-linked quota coverage."
    - name: "approved_quotas"
      expr: SUM(CASE WHEN approval_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Count of approved quotas — measures quota planning process completion rate."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_trade_in`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade-in program KPIs tracking appraisal values, CPO eligibility, reconditioning costs, and disposition — drives used vehicle strategy and trade-in program profitability."
  source: "`vibe_automotive_v1`.`sales`.`trade_in`"
  dimensions:
    - name: "disposition_type"
      expr: disposition_type
      comment: "How the trade-in vehicle was disposed (CPO, wholesale, auction, retail) for used vehicle channel analysis."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Condition grade of the trade-in vehicle (excellent, good, fair, poor) for inventory quality analysis."
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type of the trade-in vehicle for used EV/ICE mix analysis."
    - name: "model_year"
      expr: model_year
      comment: "Model year of the trade-in vehicle for vintage analysis of used vehicle pipeline."
    - name: "cpo_eligible_flag"
      expr: cpo_eligible_flag
      comment: "Flag indicating whether the trade-in is eligible for CPO certification — tracks CPO pipeline from trade-ins."
    - name: "accident_history_flag"
      expr: accident_history_flag
      comment: "Flag indicating accident history — tracks clean title vs. accident history vehicle mix."
    - name: "inspection_completed"
      expr: inspection_completed
      comment: "Flag indicating whether inspection was completed — tracks inspection process compliance."
    - name: "service_records_available"
      expr: service_records_available
      comment: "Flag indicating service records availability — tracks documentation quality of trade-ins."
    - name: "digital_channel_flag"
      expr: digital_channel_flag
      comment: "Flag indicating whether the trade-in was initiated through a digital channel."
    - name: "appraisal_date"
      expr: appraisal_date
      comment: "Date of trade-in appraisal for time-series trade-in volume analysis."
  measures:
    - name: "total_trade_ins"
      expr: COUNT(1)
      comment: "Total number of trade-in vehicles — primary trade-in program volume KPI."
    - name: "total_appraised_value"
      expr: SUM(CAST(appraised_value AS DOUBLE))
      comment: "Total appraised value of all trade-in vehicles — measures total used vehicle pipeline value."
    - name: "total_allowance"
      expr: SUM(CAST(allowance AS DOUBLE))
      comment: "Total trade-in allowance credited to customers — measures trade-in program financial commitment."
    - name: "total_outstanding_loan_balance"
      expr: SUM(CAST(outstanding_loan_balance AS DOUBLE))
      comment: "Total outstanding loan balance on trade-in vehicles — measures negative equity exposure in trade-in program."
    - name: "total_reconditioning_cost"
      expr: SUM(CAST(reconditioning_cost AS DOUBLE))
      comment: "Total reconditioning cost across trade-in vehicles — measures used vehicle preparation investment."
    - name: "total_disposition_amount"
      expr: SUM(CAST(disposition_amount AS DOUBLE))
      comment: "Total disposition proceeds from trade-in vehicles — measures used vehicle revenue realization."
    - name: "avg_appraised_value"
      expr: AVG(CAST(appraised_value AS DOUBLE))
      comment: "Average appraised value per trade-in — tracks typical trade-in vehicle value and market trends."
    - name: "avg_allowance"
      expr: AVG(CAST(allowance AS DOUBLE))
      comment: "Average trade-in allowance per vehicle — monitors trade-in pricing generosity and competitiveness."
    - name: "avg_reconditioning_cost"
      expr: AVG(CAST(reconditioning_cost AS DOUBLE))
      comment: "Average reconditioning cost per trade-in — tracks used vehicle preparation cost efficiency."
    - name: "cpo_eligible_count"
      expr: SUM(CASE WHEN cpo_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of CPO-eligible trade-ins — measures CPO pipeline supply from trade-in program."
    - name: "accident_history_count"
      expr: SUM(CASE WHEN accident_history_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of trade-ins with accident history — tracks used vehicle quality risk in trade-in pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_cpo_listing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Certified Pre-Owned program KPIs tracking CPO inventory, pricing, days-on-lot, and reconditioning — drives CPO program profitability and inventory management."
  source: "`vibe_automotive_v1`.`sales`.`cpo_listing`"
  dimensions:
    - name: "listing_status"
      expr: listing_status
      comment: "Current status of the CPO listing (active, sold, expired, withdrawn) for inventory management."
    - name: "model_year"
      expr: model_year
      comment: "Model year of the CPO vehicle for vintage mix analysis."
    - name: "online_listing_flag"
      expr: online_listing_flag
      comment: "Flag indicating whether the CPO vehicle is listed online — tracks digital CPO channel coverage."
    - name: "vehicle_history_clean_flag"
      expr: vehicle_history_clean_flag
      comment: "Flag indicating clean vehicle history — tracks CPO inventory quality."
    - name: "listing_date"
      expr: listing_date
      comment: "Date the CPO vehicle was listed for inventory aging analysis."
    - name: "sale_date"
      expr: sale_date
      comment: "Date the CPO vehicle was sold for time-series CPO sales analysis."
  measures:
    - name: "total_cpo_listings"
      expr: COUNT(1)
      comment: "Total number of CPO listings — primary CPO inventory volume KPI."
    - name: "total_asking_price"
      expr: SUM(CAST(asking_price AS DOUBLE))
      comment: "Total asking price across all CPO listings — measures total CPO inventory retail value."
    - name: "total_sale_price"
      expr: SUM(CAST(sale_price AS DOUBLE))
      comment: "Total sale price of sold CPO vehicles — measures CPO program revenue."
    - name: "total_reconditioning_cost"
      expr: SUM(CAST(reconditioning_cost AS DOUBLE))
      comment: "Total reconditioning cost across CPO vehicles — measures CPO program preparation investment."
    - name: "avg_asking_price"
      expr: AVG(CAST(asking_price AS DOUBLE))
      comment: "Average CPO asking price — tracks CPO pricing strategy and market positioning."
    - name: "avg_sale_price"
      expr: AVG(CAST(sale_price AS DOUBLE))
      comment: "Average CPO sale price — tracks actual CPO revenue per unit."
    - name: "avg_reconditioning_cost"
      expr: AVG(CAST(reconditioning_cost AS DOUBLE))
      comment: "Average reconditioning cost per CPO vehicle — monitors CPO preparation cost efficiency."
    - name: "online_listed_count"
      expr: SUM(CASE WHEN online_listing_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of CPO vehicles listed online — measures digital CPO channel coverage."
    - name: "clean_history_count"
      expr: SUM(CASE WHEN vehicle_history_clean_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of CPO vehicles with clean history — measures CPO inventory quality composition."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_subscription_sales_link`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle subscription sales KPIs tracking subscription contract values, commitment terms, and service inclusions — drives vehicle-as-a-service revenue strategy."
  source: "`vibe_automotive_v1`.`sales`.`subscription_sales_link`"
  dimensions:
    - name: "link_status"
      expr: link_status
      comment: "Current status of the subscription sales link (active, cancelled, completed) for subscription portfolio management."
    - name: "link_type"
      expr: link_type
      comment: "Type of subscription sales link (new, renewal, upgrade, swap) for subscription lifecycle analysis."
    - name: "insurance_included_flag"
      expr: insurance_included_flag
      comment: "Flag indicating insurance is included in the subscription — tracks full-service subscription penetration."
    - name: "maintenance_included_flag"
      expr: maintenance_included_flag
      comment: "Flag indicating maintenance is included in the subscription — tracks maintenance-inclusive subscription mix."
    - name: "swap_eligible_flag"
      expr: swap_eligible_flag
      comment: "Flag indicating vehicle swap eligibility — tracks flexible subscription product adoption."
    - name: "sales_attribution_type"
      expr: sales_attribution_type
      comment: "How the subscription sale is attributed (direct, dealer, digital) for channel attribution analysis."
    - name: "revenue_recognition_method"
      expr: revenue_recognition_method
      comment: "Revenue recognition method for the subscription — critical for financial reporting compliance."
    - name: "subscription_start_date"
      expr: subscription_start_date
      comment: "Subscription start date for cohort and vintage analysis."
    - name: "subscription_end_date"
      expr: subscription_end_date
      comment: "Subscription end date for churn and renewal analysis."
  measures:
    - name: "total_subscription_links"
      expr: COUNT(1)
      comment: "Total number of subscription sales links — primary vehicle-as-a-service volume KPI."
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total contract value across all subscription sales — primary subscription revenue KPI."
    - name: "total_monthly_subscription_revenue"
      expr: SUM(CAST(monthly_subscription_amount AS DOUBLE))
      comment: "Total monthly subscription revenue across active subscriptions — measures recurring revenue base."
    - name: "avg_monthly_subscription_amount"
      expr: AVG(CAST(monthly_subscription_amount AS DOUBLE))
      comment: "Average monthly subscription amount — tracks subscription pricing and ARPU trends."
    - name: "avg_total_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average total contract value per subscription — tracks subscription deal size."
    - name: "total_cancellation_fee"
      expr: SUM(CAST(cancellation_fee_amount AS DOUBLE))
      comment: "Total cancellation fees collected — measures early termination revenue and churn cost."
    - name: "insurance_included_subscriptions"
      expr: SUM(CASE WHEN insurance_included_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of subscriptions with insurance included — measures full-service subscription penetration."
    - name: "maintenance_included_subscriptions"
      expr: SUM(CASE WHEN maintenance_included_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of subscriptions with maintenance included — measures maintenance-inclusive subscription mix."
    - name: "swap_eligible_subscriptions"
      expr: SUM(CASE WHEN swap_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of swap-eligible subscriptions — tracks flexible subscription product adoption."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_test_drive`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test drive program KPIs tracking test drive volume, conversion outcomes, and digital booking — measures test drive program effectiveness as a sales conversion tool."
  source: "`vibe_automotive_v1`.`sales`.`sales_test_drive`"
  dimensions:
    - name: "test_drive_status"
      expr: test_drive_status
      comment: "Current status of the test drive (scheduled, completed, no-show, cancelled) for program management."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the test drive (converted, follow-up, no interest) for conversion analysis."
    - name: "online_booking_flag"
      expr: online_booking_flag
      comment: "Flag indicating whether the test drive was booked online — tracks digital booking adoption."
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Flag indicating follow-up is required — measures post-test-drive engagement pipeline."
    - name: "digital_channel_flag"
      expr: digital_channel_flag
      comment: "Flag indicating digital channel origin of the test drive booking."
    - name: "test_drive_date"
      expr: test_drive_date
      comment: "Date of the test drive for time-series volume analysis."
    - name: "scheduled_date"
      expr: scheduled_date
      comment: "Scheduled date of the test drive for capacity planning analysis."
  measures:
    - name: "total_test_drives"
      expr: COUNT(1)
      comment: "Total number of test drives — primary test drive program volume KPI."
    - name: "completed_test_drives"
      expr: SUM(CASE WHEN test_drive_status = 'Completed' THEN 1 ELSE 0 END)
      comment: "Count of completed test drives — measures actual test drive program execution."
    - name: "online_booked_test_drives"
      expr: SUM(CASE WHEN online_booking_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of test drives booked online — tracks digital booking channel adoption."
    - name: "follow_up_required_count"
      expr: SUM(CASE WHEN follow_up_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of test drives requiring follow-up — measures post-test-drive sales pipeline."
    - name: "avg_customer_feedback_score"
      expr: AVG(CAST(customer_feedback AS DOUBLE))
      comment: "Average customer feedback score from test drives — measures test drive experience quality."
    - name: "avg_feedback_score"
      expr: AVG(CAST(feedback_score AS DOUBLE))
      comment: "Average overall feedback score — tracks test drive program satisfaction and quality."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_price_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price adjustment and discount KPIs tracking adjustment volumes, approval rates, and financial impact — drives pricing discipline and discount governance."
  source: "`vibe_automotive_v1`.`sales`.`price_adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of price adjustment (discount, incentive, markup, rebate) for adjustment mix analysis."
    - name: "adjustment_category"
      expr: adjustment_category
      comment: "Category of the adjustment for granular pricing analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the price adjustment (pending, approved, rejected) for governance tracking."
    - name: "authorization_level"
      expr: authorization_level
      comment: "Authorization level required for the adjustment — tracks discount authority utilization."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel of the adjustment for channel-level pricing analysis."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the adjustment for regional pricing discipline analysis."
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle receiving the adjustment for vintage pricing analysis."
    - name: "online_exclusive_flag"
      expr: online_exclusive_flag
      comment: "Flag indicating online-exclusive price adjustment — tracks digital pricing strategy."
    - name: "stacking_allowed"
      expr: stacking_allowed
      comment: "Flag indicating whether the adjustment can be stacked with others — tracks incentive stacking risk."
    - name: "audit_flag"
      expr: audit_flag
      comment: "Flag indicating the adjustment is under audit — tracks pricing compliance risk."
    - name: "applied_date"
      expr: applied_date
      comment: "Date the adjustment was applied for time-series pricing analysis."
  measures:
    - name: "total_adjustments"
      expr: COUNT(1)
      comment: "Total number of price adjustments — primary pricing governance volume KPI."
    - name: "approved_adjustments"
      expr: SUM(CASE WHEN approval_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Count of approved price adjustments — measures approval rate numerator."
    - name: "rejected_adjustments"
      expr: SUM(CASE WHEN approval_status = 'Rejected' THEN 1 ELSE 0 END)
      comment: "Count of rejected price adjustments — measures pricing discipline enforcement."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total price adjustment amount — measures total discount/incentive financial impact."
    - name: "total_base_price"
      expr: SUM(CAST(base_price AS DOUBLE))
      comment: "Total base price before adjustments — baseline for discount rate calculation."
    - name: "total_adjusted_price"
      expr: SUM(CAST(adjusted_price AS DOUBLE))
      comment: "Total adjusted (net) price after all adjustments — measures actual revenue after discounting."
    - name: "avg_adjustment_amount"
      expr: AVG(CAST(adjustment_amount AS DOUBLE))
      comment: "Average price adjustment amount — tracks typical discount level per transaction."
    - name: "avg_adjustment_percentage"
      expr: AVG(CAST(adjustment_percentage AS DOUBLE))
      comment: "Average adjustment percentage — monitors discount rate trends and pricing discipline."
    - name: "audit_flagged_adjustments"
      expr: SUM(CASE WHEN audit_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of adjustments flagged for audit — measures pricing compliance risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational activity metrics for sales engagement monitoring"
  source: "`vibe_automotive_v1`.`sales`.`activity`"
  dimensions:
    - name: "activity_date"
      expr: activity_date
      comment: "Date of the activity"
    - name: "activity_type"
      expr: activity_type
      comment: "Type of sales activity"
    - name: "activity_status"
      expr: activity_status
      comment: "Current status of the activity"
    - name: "region"
      expr: region
      comment: "Geographic region of the activity"
    - name: "sales_territory_id"
      expr: sales_territory_id
      comment: "Sales territory identifier"
    - name: "rep_id"
      expr: rep_id
      comment: "Sales representative identifier"
  measures:
    - name: "activity_count"
      expr: COUNT(1)
      comment: "Number of sales activities recorded"
    - name: "total_estimated_deal_value"
      expr: SUM(CAST(estimated_deal_value AS DOUBLE))
      comment: "Sum of estimated deal values from activities"
    - name: "demo_completed_count"
      expr: SUM(CASE WHEN demo_completed THEN 1 ELSE 0 END)
      comment: "Count of activities where a demo was completed"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial performance of signed contracts"
  source: "`vibe_automotive_v1`.`sales`.`contract`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the contract"
    - name: "region_code"
      expr: region_code
      comment: "Region code for the contract"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel used for the contract"
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle under contract"
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Sum of contract values"
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value"
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Number of contracts"
    - name: "total_discount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount across contracts"
    - name: "net_revenue"
      expr: SUM(total_contract_value - discount_amount - tax_amount)
      comment: "Net revenue after discounts and taxes"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`sales_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and volume metrics at the order line level"
  source: "`vibe_automotive_v1`.`sales`.`order_line`"
  dimensions:
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type of the vehicle"
    - name: "rep_id"
      expr: rep_id
      comment: "Sales representative identifier"
  measures:
    - name: "total_line_revenue"
      expr: SUM(CAST(line_total AS DOUBLE))
      comment: "Total revenue from order lines"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of items sold"
    - name: "avg_net_price"
      expr: AVG(CAST(net_price AS DOUBLE))
      comment: "Average net price per line item"
    - name: "total_discount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied on order lines"
$$;