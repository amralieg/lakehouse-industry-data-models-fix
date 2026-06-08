-- Metric views for domain: marketing | Business: Ecommerce | Version: 1 | Generated on: 2026-05-05 00:54:17

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`marketing_campaign_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core campaign performance KPIs measuring spend efficiency, audience reach, conversion effectiveness, and revenue return across all marketing campaigns. Primary steering dashboard for CMO and VP Marketing."
  source: "`ecommerce_ecm`.`marketing`.`campaign_performance`"
  dimensions:
    - name: "campaign_objective"
      expr: campaign_objective
      comment: "The stated business objective of the campaign (e.g. awareness, conversion, retention), enabling performance comparison across objective types."
    - name: "campaign_performance_status"
      expr: campaign_performance_status
      comment: "Current delivery status of the campaign performance record (e.g. active, paused, completed), used to filter live vs. historical performance."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Operational delivery status indicating whether the campaign is actively serving impressions, useful for diagnosing under-delivery."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which spend and revenue figures are denominated, required for multi-currency normalization."
    - name: "performance_month"
      expr: DATE_TRUNC('MONTH', scheduled_start)
      comment: "Calendar month derived from scheduled campaign start, used for month-over-month trend analysis."
    - name: "performance_quarter"
      expr: DATE_TRUNC('QUARTER', scheduled_start)
      comment: "Calendar quarter derived from scheduled campaign start, used for quarterly business review reporting."
  measures:
    - name: "total_impressions"
      expr: SUM(CAST(impressions AS DOUBLE))
      comment: "Total number of ad impressions served. Measures top-of-funnel reach and brand exposure volume."
    - name: "total_clicks"
      expr: SUM(CAST(clicks AS DOUBLE))
      comment: "Total number of clicks generated across all campaigns. Indicates audience engagement and intent signal strength."
    - name: "total_conversions"
      expr: SUM(CAST(conversions AS DOUBLE))
      comment: "Total number of conversion events attributed to campaigns. Directly tied to revenue outcomes and campaign ROI."
    - name: "total_spend"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total marketing spend across all campaigns. Core cost input for efficiency and ROI calculations."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue AS DOUBLE))
      comment: "Total net revenue attributed to campaigns after discounts. Primary revenue outcome metric for marketing investment decisions."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value applied through campaign promotions. Tracks promotional cost and margin erosion from marketing activity."
    - name: "avg_cost_per_click"
      expr: AVG(CAST(cpc AS DOUBLE))
      comment: "Average cost per click across campaigns. Key efficiency metric for paid media budget allocation decisions."
    - name: "avg_cost_per_mille"
      expr: AVG(CAST(cpm AS DOUBLE))
      comment: "Average cost per thousand impressions. Benchmarks media buying efficiency for awareness-focused campaigns."
    - name: "avg_click_through_rate"
      expr: AVG(CAST(ctr AS DOUBLE))
      comment: "Average click-through rate across campaigns. Measures creative and targeting effectiveness; triggers creative refresh decisions when below benchmark."
    - name: "avg_conversion_rate"
      expr: AVG(CAST(cvr AS DOUBLE))
      comment: "Average conversion rate across campaigns. Core funnel efficiency metric linking ad engagement to purchase outcomes."
    - name: "avg_roas"
      expr: AVG(CAST(roas AS DOUBLE))
      comment: "Average return on ad spend across campaigns. Primary profitability signal for marketing investment reallocation decisions."
    - name: "avg_customer_acquisition_cost"
      expr: AVG(CAST(cac AS DOUBLE))
      comment: "Average customer acquisition cost across campaigns. Compared against customer lifetime value to assess long-term marketing sustainability."
    - name: "avg_order_value"
      expr: AVG(CAST(aov AS DOUBLE))
      comment: "Average order value attributed to campaign-driven conversions. Informs upsell and cross-sell strategy effectiveness."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated across campaign performance records. Used to compute budget utilization and pacing against spend."
    - name: "spend_to_budget_ratio"
      expr: ROUND(SUM(CAST(spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 4)
      comment: "Ratio of actual spend to allocated budget. Measures budget pacing and utilization; values near 1.0 indicate full budget deployment."
    - name: "revenue_per_impression"
      expr: ROUND(SUM(CAST(net_revenue AS DOUBLE)) / NULLIF(SUM(CAST(impressions AS DOUBLE)), 0), 4)
      comment: "Net revenue generated per impression served (RPM proxy). Combines reach and revenue to assess overall campaign value density."
    - name: "cost_per_conversion"
      expr: ROUND(SUM(CAST(spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(conversions AS DOUBLE)), 0), 2)
      comment: "Actual cost incurred per conversion event. Operational efficiency KPI used to optimize bidding strategy and budget allocation."
    - name: "total_audience_size"
      expr: SUM(CAST(audience_size AS DOUBLE))
      comment: "Total addressable audience size targeted across campaigns. Measures market reach potential and segmentation breadth."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`marketing_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic campaign portfolio metrics covering budget planning, expected ROI, and campaign mix analysis. Used by marketing leadership to govern campaign investment and portfolio strategy."
  source: "`ecommerce_ecm`.`marketing`.`campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Classification of the campaign (e.g. paid search, display, email, social), enabling performance comparison across campaign types."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current lifecycle status of the campaign (e.g. active, draft, completed, paused), used to filter portfolio views."
    - name: "objective"
      expr: objective
      comment: "Strategic objective of the campaign (e.g. acquisition, retention, brand awareness), aligning spend to business goals."
    - name: "bidding_strategy"
      expr: bidding_strategy
      comment: "Automated or manual bidding approach used (e.g. target CPA, maximize clicks), informing optimization strategy reviews."
    - name: "attribution_model"
      expr: attribution_model
      comment: "Attribution model applied to the campaign (e.g. last-click, data-driven), critical context for interpreting conversion and revenue metrics."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which campaign budgets and costs are denominated."
    - name: "campaign_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month in which the campaign launched, used for cohort-based campaign performance trending."
    - name: "ad_format"
      expr: ad_format
      comment: "Ad format used in the campaign (e.g. video, banner, native), enabling creative format effectiveness analysis."
    - name: "is_test"
      expr: is_test
      comment: "Flag indicating whether the campaign is a test/experiment, used to exclude test campaigns from production reporting."
  measures:
    - name: "total_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Total number of distinct campaigns in the portfolio. Baseline measure for campaign volume and portfolio breadth."
    - name: "total_gross_budget"
      expr: SUM(CAST(budget_gross AS DOUBLE))
      comment: "Total gross budget committed across all campaigns. Primary input for marketing spend governance and CFO-level budget oversight."
    - name: "total_net_budget"
      expr: SUM(CAST(budget_net AS DOUBLE))
      comment: "Total net budget after adjustments. Reflects actual deployable marketing investment after discounts and reallocations."
    - name: "total_budget_adjustments"
      expr: SUM(CAST(budget_adjustments AS DOUBLE))
      comment: "Total budget adjustment amounts applied across campaigns. Tracks in-flight budget reallocation activity and financial control compliance."
    - name: "avg_expected_roi"
      expr: AVG(CAST(expected_roi AS DOUBLE))
      comment: "Average expected return on investment across campaigns at planning time. Benchmarks forecast accuracy when compared against actual ROAS."
    - name: "avg_cost_per_acquisition_planned"
      expr: AVG(CAST(cost_per_acquisition AS DOUBLE))
      comment: "Average planned cost per acquisition across campaigns. Used to assess whether campaign planning assumptions are realistic vs. actuals."
    - name: "avg_cost_per_click_planned"
      expr: AVG(CAST(cost_per_click AS DOUBLE))
      comment: "Average planned cost per click at campaign setup. Compared against actual CPC to evaluate bid strategy effectiveness."
    - name: "avg_daily_budget_cap"
      expr: AVG(CAST(daily_budget_cap AS DOUBLE))
      comment: "Average daily budget cap across campaigns. Informs pacing strategy and identifies campaigns at risk of early budget exhaustion."
    - name: "total_lifetime_budget_cap"
      expr: SUM(CAST(lifetime_budget_cap AS DOUBLE))
      comment: "Total lifetime budget cap committed across all campaigns. Represents maximum possible marketing spend exposure for financial risk management."
    - name: "net_to_gross_budget_ratio"
      expr: ROUND(SUM(CAST(budget_net AS DOUBLE)) / NULLIF(SUM(CAST(budget_gross AS DOUBLE)), 0), 4)
      comment: "Ratio of net to gross budget. Values below 1.0 indicate significant budget adjustments or discounts; used to assess budget efficiency and negotiation outcomes."
    - name: "avg_planned_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average planned conversion rate at campaign setup. Baseline for comparing forecast vs. actual conversion performance."
    - name: "avg_planned_click_through_rate"
      expr: AVG(CAST(click_through_rate AS DOUBLE))
      comment: "Average planned click-through rate at campaign setup. Used to evaluate whether creative and targeting assumptions held true in execution."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`marketing_campaign_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing budget governance metrics tracking allocation, spend pacing, remaining budget, and cost-per-acquisition efficiency. Used by finance and marketing ops to govern spend controls and budget health."
  source: "`ecommerce_ecm`.`marketing`.`campaign_budget`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Classification of the budget (e.g. annual, quarterly, campaign-level), enabling budget governance by planning horizon."
    - name: "campaign_budget_status"
      expr: campaign_budget_status
      comment: "Current status of the budget record (e.g. approved, pending, exhausted), used to identify at-risk or over-spent budgets."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate budget to campaigns (e.g. manual, algorithmic, proportional), informing budget process efficiency reviews."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which budget amounts are denominated."
    - name: "budget_effective_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month in which the budget became effective, used for monthly budget pacing and trend analysis."
    - name: "is_test"
      expr: is_test
      comment: "Flag indicating whether this is a test budget record, used to exclude test data from financial reporting."
  measures:
    - name: "total_allocated_budget"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total budget allocated across all campaign budget records. Primary financial governance metric for marketing spend authorization."
    - name: "total_spent_amount"
      expr: SUM(CAST(spent_amount AS DOUBLE))
      comment: "Total amount spent against allocated budgets. Core spend tracking metric for financial control and pacing oversight."
    - name: "total_remaining_budget"
      expr: SUM(CAST(remaining_amount AS DOUBLE))
      comment: "Total unspent budget remaining across all active budgets. Critical for identifying under-utilized budgets and reallocation opportunities."
    - name: "budget_utilization_rate"
      expr: ROUND(SUM(CAST(spent_amount AS DOUBLE)) / NULLIF(SUM(CAST(allocated_amount AS DOUBLE)), 0), 4)
      comment: "Ratio of spent to allocated budget. Values near 1.0 indicate full budget deployment; low values signal under-pacing requiring intervention."
    - name: "avg_cost_per_acquisition_actual"
      expr: AVG(CAST(cost_per_acquisition_actual AS DOUBLE))
      comment: "Average actual cost per acquisition across budget records. Compared against target CPA to assess campaign efficiency and bidding performance."
    - name: "avg_cost_per_acquisition_target"
      expr: AVG(CAST(cost_per_acquisition_target AS DOUBLE))
      comment: "Average target cost per acquisition set at budget planning time. Baseline for evaluating whether campaigns are meeting efficiency goals."
    - name: "cpa_efficiency_ratio"
      expr: ROUND(AVG(CAST(cost_per_acquisition_target AS DOUBLE)) / NULLIF(AVG(CAST(cost_per_acquisition_actual AS DOUBLE)), 0), 4)
      comment: "Ratio of target CPA to actual CPA. Values above 1.0 indicate campaigns are beating efficiency targets; below 1.0 signals overspend per acquisition."
    - name: "total_budget_records"
      expr: COUNT(DISTINCT campaign_budget_id)
      comment: "Total number of distinct budget records. Used to track budget fragmentation and governance complexity across the campaign portfolio."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`marketing_attribution_touchpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Multi-touch attribution metrics quantifying revenue and cost attribution across channels, devices, and interaction types. Enables data-driven channel investment decisions and attribution model validation."
  source: "`ecommerce_ecm`.`marketing`.`attribution_touchpoint`"
  dimensions:
    - name: "attribution_model"
      expr: attribution_model
      comment: "Attribution model applied to the touchpoint (e.g. last-click, first-click, linear, data-driven), critical for interpreting attributed revenue figures."
    - name: "touchpoint_position"
      expr: touchpoint_position
      comment: "Position of the touchpoint in the conversion path (e.g. first, middle, last), used for path analysis and model comparison."
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of user interaction recorded (e.g. click, view, engagement), enabling interaction-level attribution analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device category used during the touchpoint (e.g. mobile, desktop, tablet), informing cross-device attribution and media mix decisions."
    - name: "utm_medium"
      expr: utm_medium
      comment: "UTM medium parameter (e.g. cpc, email, organic), used to segment performance by marketing medium for channel mix analysis."
    - name: "utm_source"
      expr: utm_source
      comment: "UTM source parameter identifying the traffic origin (e.g. google, facebook, newsletter), enabling source-level ROI analysis."
    - name: "utm_campaign"
      expr: utm_campaign
      comment: "UTM campaign parameter linking touchpoints to specific campaign names for cross-channel campaign attribution."
    - name: "country_code"
      expr: country_code
      comment: "Country of the touchpoint interaction, enabling geographic attribution and regional marketing investment decisions."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which attributed cost and revenue are denominated."
    - name: "is_converted"
      expr: is_converted
      comment: "Flag indicating whether the touchpoint session resulted in a conversion, used to segment converting vs. non-converting paths."
    - name: "touchpoint_month"
      expr: DATE_TRUNC('MONTH', touchpoint_timestamp)
      comment: "Calendar month of the touchpoint, used for monthly attribution trend analysis."
  measures:
    - name: "total_attributed_revenue"
      expr: SUM(CAST(revenue_attributed AS DOUBLE))
      comment: "Total revenue attributed to marketing touchpoints. Primary outcome metric for measuring marketing's contribution to business revenue."
    - name: "total_attributed_cost"
      expr: SUM(CAST(cost_attributed AS DOUBLE))
      comment: "Total cost attributed to marketing touchpoints. Used alongside attributed revenue to compute channel-level ROAS."
    - name: "attributed_roas"
      expr: ROUND(SUM(CAST(revenue_attributed AS DOUBLE)) / NULLIF(SUM(CAST(cost_attributed AS DOUBLE)), 0), 4)
      comment: "Return on ad spend computed from attributed revenue and cost. Primary efficiency metric for channel investment reallocation decisions."
    - name: "total_touchpoints"
      expr: COUNT(DISTINCT attribution_touchpoint_id)
      comment: "Total number of distinct attribution touchpoints. Measures marketing interaction volume and path complexity across the conversion funnel."
    - name: "total_converted_touchpoints"
      expr: COUNT(DISTINCT CASE WHEN is_converted = TRUE THEN attribution_touchpoint_id END)
      comment: "Number of touchpoints that resulted in a conversion. Used to compute touchpoint-level conversion rates and identify high-converting interaction patterns."
    - name: "touchpoint_conversion_rate"
      expr: ROUND(COUNT(DISTINCT CASE WHEN is_converted = TRUE THEN attribution_touchpoint_id END) / NULLIF(COUNT(DISTINCT attribution_touchpoint_id), 0), 4)
      comment: "Proportion of touchpoints that resulted in a conversion. Measures the effectiveness of marketing interactions in driving purchase outcomes."
    - name: "avg_attribution_score"
      expr: AVG(CAST(attribution_score AS DOUBLE))
      comment: "Average attribution score assigned to touchpoints by the attribution model. Higher scores indicate touchpoints with greater modeled influence on conversion."
    - name: "avg_revenue_per_touchpoint"
      expr: ROUND(SUM(CAST(revenue_attributed AS DOUBLE)) / NULLIF(COUNT(DISTINCT attribution_touchpoint_id), 0), 2)
      comment: "Average attributed revenue generated per touchpoint. Measures the revenue density of marketing interactions across channels."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`marketing_email_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Email marketing engagement and deliverability metrics tracking open rates, click behavior, bounce rates, and event outcomes by campaign and audience segment. Used by CRM and email marketing teams to optimize email program performance."
  source: "`ecommerce_ecm`.`marketing`.`email_event`"
  filter: is_test = FALSE
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of email event recorded (e.g. sent, opened, clicked, bounced, unsubscribed), the primary dimension for email funnel analysis."
    - name: "event_outcome"
      expr: event_outcome
      comment: "Outcome classification of the email event, used to segment successful engagements from negative outcomes like bounces and spam reports."
    - name: "bounce_category"
      expr: bounce_category
      comment: "Category of email bounce (e.g. hard bounce, soft bounce), used to assess list quality and deliverability health."
    - name: "device_type"
      expr: device_type
      comment: "Device used to interact with the email (e.g. mobile, desktop), informing responsive design and send-time optimization decisions."
    - name: "email_client"
      expr: email_client
      comment: "Email client used by the recipient (e.g. Gmail, Outlook, Apple Mail), used to optimize rendering and compatibility."
    - name: "language_code"
      expr: language_code
      comment: "Language of the email content, enabling localization performance analysis."
    - name: "location_country_code"
      expr: location_country_code
      comment: "Country of the email recipient, used for geographic segmentation of email program performance."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Calendar month of the email event, used for monthly email program trend analysis and QBR reporting."
  measures:
    - name: "total_email_events"
      expr: COUNT(DISTINCT email_event_id)
      comment: "Total number of distinct email events recorded. Baseline volume metric for email program scale and deliverability monitoring."
    - name: "total_sends"
      expr: COUNT(DISTINCT CASE WHEN event_type = 'sent' THEN email_event_id END)
      comment: "Total number of emails sent. Denominator for open rate, click rate, and bounce rate calculations."
    - name: "total_opens"
      expr: COUNT(DISTINCT CASE WHEN event_type = 'opened' THEN email_event_id END)
      comment: "Total number of email open events. Primary engagement signal for subject line and send-time effectiveness."
    - name: "total_clicks"
      expr: COUNT(DISTINCT CASE WHEN event_type = 'clicked' THEN email_event_id END)
      comment: "Total number of email click events. Measures content relevance and call-to-action effectiveness."
    - name: "total_bounces"
      expr: COUNT(DISTINCT CASE WHEN event_type = 'bounced' THEN email_event_id END)
      comment: "Total number of email bounce events. High bounce rates signal list quality degradation and deliverability risk."
    - name: "total_unsubscribes"
      expr: COUNT(DISTINCT CASE WHEN event_type = 'unsubscribed' THEN email_event_id END)
      comment: "Total number of unsubscribe events. Critical compliance and list health metric; rising unsubscribes trigger content and frequency reviews."
    - name: "email_open_rate"
      expr: ROUND(COUNT(DISTINCT CASE WHEN event_type = 'opened' THEN email_event_id END) / NULLIF(COUNT(DISTINCT CASE WHEN event_type = 'sent' THEN email_event_id END), 0), 4)
      comment: "Proportion of sent emails that were opened. Primary subject line and deliverability effectiveness KPI for email program optimization."
    - name: "email_click_to_open_rate"
      expr: ROUND(COUNT(DISTINCT CASE WHEN event_type = 'clicked' THEN email_event_id END) / NULLIF(COUNT(DISTINCT CASE WHEN event_type = 'opened' THEN email_event_id END), 0), 4)
      comment: "Proportion of opened emails that generated a click. Measures content and CTA effectiveness independent of deliverability factors."
    - name: "email_bounce_rate"
      expr: ROUND(COUNT(DISTINCT CASE WHEN event_type = 'bounced' THEN email_event_id END) / NULLIF(COUNT(DISTINCT CASE WHEN event_type = 'sent' THEN email_event_id END), 0), 4)
      comment: "Proportion of sent emails that bounced. Values above industry thresholds (~2%) trigger list hygiene and sender reputation remediation."
    - name: "email_unsubscribe_rate"
      expr: ROUND(COUNT(DISTINCT CASE WHEN event_type = 'unsubscribed' THEN email_event_id END) / NULLIF(COUNT(DISTINCT CASE WHEN event_type = 'sent' THEN email_event_id END), 0), 4)
      comment: "Proportion of sent emails resulting in unsubscribes. Compliance and audience health KPI; rising rates indicate content fatigue or targeting misalignment."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`marketing_referral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Referral program performance metrics tracking referral volume, incentive costs, reward payouts, and program conversion effectiveness. Used by growth and marketing teams to evaluate referral program ROI and optimize incentive structures."
  source: "`ecommerce_ecm`.`marketing`.`referral`"
  dimensions:
    - name: "referral_status"
      expr: referral_status
      comment: "Current status of the referral (e.g. pending, converted, expired, cancelled), used to segment active vs. completed referrals."
    - name: "incentive_type"
      expr: incentive_type
      comment: "Type of incentive offered to the referrer (e.g. credit, discount, cash), used to compare incentive structure effectiveness."
    - name: "reward_type"
      expr: reward_type
      comment: "Type of reward issued to the referee upon conversion (e.g. voucher, cashback, free shipping), used to optimize referee conversion rates."
    - name: "incentive_currency"
      expr: incentive_currency
      comment: "Currency of the referral incentive, required for multi-currency cost normalization."
    - name: "referral_month"
      expr: DATE_TRUNC('MONTH', referral_date)
      comment: "Calendar month of the referral event, used for monthly referral program trend analysis."
  measures:
    - name: "total_referrals"
      expr: COUNT(DISTINCT referral_id)
      comment: "Total number of referrals generated. Baseline volume metric for referral program reach and viral growth potential."
    - name: "total_converted_referrals"
      expr: COUNT(DISTINCT CASE WHEN referral_status = 'converted' THEN referral_id END)
      comment: "Total number of referrals that resulted in a successful conversion. Primary outcome metric for referral program effectiveness."
    - name: "referral_conversion_rate"
      expr: ROUND(COUNT(DISTINCT CASE WHEN referral_status = 'converted' THEN referral_id END) / NULLIF(COUNT(DISTINCT referral_id), 0), 4)
      comment: "Proportion of referrals that converted to customers. Core program effectiveness KPI; low rates trigger incentive structure and UX reviews."
    - name: "total_incentive_cost"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive cost paid to referrers. Key cost input for referral program ROI calculation and budget governance."
    - name: "total_reward_payout"
      expr: SUM(CAST(reward_amount AS DOUBLE))
      comment: "Total reward amount paid to referees upon conversion. Combined with incentive cost to compute total referral program cost."
    - name: "avg_incentive_per_referral"
      expr: AVG(CAST(incentive_amount AS DOUBLE))
      comment: "Average incentive amount offered per referral. Used to benchmark incentive generosity and optimize cost-per-acquisition through the referral channel."
    - name: "avg_reward_per_conversion"
      expr: ROUND(SUM(CAST(reward_amount AS DOUBLE)) / NULLIF(COUNT(DISTINCT CASE WHEN referral_status = 'converted' THEN referral_id END), 0), 2)
      comment: "Average reward payout per converted referral. Measures the effective cost of acquiring a customer through the referral channel."
    - name: "total_referral_program_cost"
      expr: SUM(incentive_amount + reward_amount)
      comment: "Total combined cost of the referral program (incentives + rewards). Primary financial input for referral channel ROI and budget justification."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`marketing_audience_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audience segment health and scale metrics tracking segment size, freshness, and composition. Used by marketing strategists to govern audience quality, targeting precision, and segmentation strategy."
  source: "`ecommerce_ecm`.`marketing`.`audience_segment`"
  dimensions:
    - name: "audience_segment_type"
      expr: audience_segment_type
      comment: "Classification of the audience segment (e.g. behavioral, demographic, lookalike, retargeting), enabling targeting strategy analysis."
    - name: "audience_segment_status"
      expr: audience_segment_status
      comment: "Current status of the segment (e.g. active, archived, draft), used to filter production-ready segments from inactive ones."
    - name: "audience_scope"
      expr: audience_scope
      comment: "Geographic or organizational scope of the segment (e.g. global, regional, local), used for market-level targeting governance."
    - name: "creation_method"
      expr: creation_method
      comment: "Method used to create the segment (e.g. rule-based, ML-model, manual), informing segment quality and maintenance overhead."
    - name: "is_dynamic"
      expr: is_dynamic
      comment: "Flag indicating whether the segment membership updates dynamically, used to distinguish real-time from static audience pools."
    - name: "refresh_frequency"
      expr: refresh_frequency
      comment: "How frequently the segment membership is refreshed (e.g. daily, weekly, real-time), used to assess audience data freshness."
    - name: "region"
      expr: region
      comment: "Geographic region associated with the segment, enabling regional audience strategy analysis."
    - name: "segment_effective_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month in which the segment became effective, used for segment lifecycle and portfolio trend analysis."
  measures:
    - name: "total_active_segments"
      expr: COUNT(DISTINCT CASE WHEN audience_segment_status = 'active' THEN audience_segment_id END)
      comment: "Total number of active audience segments. Measures the breadth of the targeting portfolio available for campaign activation."
    - name: "total_addressable_audience"
      expr: SUM(CAST(member_count AS DOUBLE))
      comment: "Total addressable audience across all segments. Measures the overall reach potential of the marketing targeting infrastructure."
    - name: "avg_segment_size"
      expr: AVG(CAST(member_count AS DOUBLE))
      comment: "Average number of members per audience segment. Segments that are too small reduce statistical significance; too large reduce targeting precision."
    - name: "total_segments"
      expr: COUNT(DISTINCT audience_segment_id)
      comment: "Total number of audience segments in the portfolio. Used to assess segmentation complexity and governance overhead."
    - name: "dynamic_segment_ratio"
      expr: ROUND(COUNT(DISTINCT CASE WHEN is_dynamic = TRUE THEN audience_segment_id END) / NULLIF(COUNT(DISTINCT audience_segment_id), 0), 4)
      comment: "Proportion of segments that are dynamically refreshed. Higher ratios indicate a more real-time and responsive targeting infrastructure."
    - name: "active_segment_ratio"
      expr: ROUND(COUNT(DISTINCT CASE WHEN audience_segment_status = 'active' THEN audience_segment_id END) / NULLIF(COUNT(DISTINCT audience_segment_id), 0), 4)
      comment: "Proportion of total segments that are currently active. Low ratios indicate segment portfolio bloat and governance debt."
$$;