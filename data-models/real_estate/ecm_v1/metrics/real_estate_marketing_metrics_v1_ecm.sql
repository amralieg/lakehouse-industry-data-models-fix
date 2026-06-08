-- Metric views for domain: marketing | Business: Real Estate | Version: 1 | Generated on: 2026-05-02 01:37:58

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`marketing_campaign_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign-level performance metrics tracking spend, budget utilization, and campaign effectiveness across channels and property types"
  source: "`real_estate_ecm`.`marketing`.`campaign`"
  dimensions:
    - name: "campaign_code"
      expr: campaign_code
      comment: "Unique campaign identifier code"
    - name: "campaign_name"
      expr: campaign_name
      comment: "Descriptive campaign name"
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current campaign status (active, paused, completed, etc.)"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (brand awareness, lead generation, etc.)"
    - name: "primary_channel"
      expr: primary_channel
      comment: "Primary marketing channel for the campaign"
    - name: "approval_status"
      expr: approval_status
      comment: "Campaign approval status"
    - name: "esg_aligned_flag"
      expr: esg_aligned_flag
      comment: "Whether campaign is aligned with ESG principles"
    - name: "fair_housing_compliant_flag"
      expr: fair_housing_compliant_flag
      comment: "Fair housing compliance indicator"
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year of planned campaign start"
    - name: "planned_start_quarter"
      expr: CONCAT('Q', QUARTER(planned_start_date))
      comment: "Quarter of planned campaign start"
    - name: "actual_start_year"
      expr: YEAR(actual_start_date)
      comment: "Year of actual campaign start"
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of campaigns"
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved budget amount across campaigns"
    - name: "total_spend_to_date"
      expr: SUM(CAST(total_spend_to_date AS DOUBLE))
      comment: "Total actual spend to date across campaigns"
    - name: "avg_campaign_budget"
      expr: AVG(CAST(approved_budget_amount AS DOUBLE))
      comment: "Average approved budget per campaign"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(total_spend_to_date AS DOUBLE)) / NULLIF(SUM(CAST(approved_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of approved budget spent to date across all campaigns"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`marketing_ad_spend_efficiency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ad spend efficiency metrics tracking spend patterns, payment status, and cost management across campaigns and channels"
  source: "`real_estate_ecm`.`marketing`.`ad_spend`"
  dimensions:
    - name: "spend_category"
      expr: spend_category
      comment: "Category of advertising spend"
    - name: "platform_name"
      expr: platform_name
      comment: "Advertising platform name"
    - name: "approval_status"
      expr: approval_status
      comment: "Spend approval status"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status for the spend"
    - name: "listing_type"
      expr: listing_type
      comment: "Type of property listing advertised"
    - name: "property_type"
      expr: property_type
      comment: "Type of property being marketed"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region code"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the spend"
    - name: "is_accrual"
      expr: is_accrual
      comment: "Whether spend is recorded on accrual basis"
    - name: "is_capitalized"
      expr: is_capitalized
      comment: "Whether spend is capitalized"
    - name: "spend_year"
      expr: YEAR(spend_date)
      comment: "Year of spend transaction"
    - name: "spend_quarter"
      expr: CONCAT('Q', QUARTER(spend_date))
      comment: "Quarter of spend transaction"
    - name: "spend_month"
      expr: DATE_TRUNC('MONTH', spend_date)
      comment: "Month of spend transaction"
  measures:
    - name: "total_spend_transactions"
      expr: COUNT(1)
      comment: "Total number of ad spend transactions"
    - name: "total_gross_spend"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total gross advertising spend amount"
    - name: "total_net_spend"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net advertising spend after discounts"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount received on ad spend"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on ad spend"
    - name: "avg_spend_per_transaction"
      expr: AVG(CAST(spend_amount AS DOUBLE))
      comment: "Average spend amount per transaction"
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(spend_amount AS DOUBLE)), 0), 2)
      comment: "Average discount rate as percentage of gross spend"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`marketing_campaign_flight_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign flight performance metrics tracking impressions, clicks, spend efficiency, and ROI at the flight level"
  source: "`real_estate_ecm`.`marketing`.`campaign_flight`"
  dimensions:
    - name: "flight_name"
      expr: flight_name
      comment: "Name of the campaign flight"
    - name: "flight_number"
      expr: flight_number
      comment: "Flight number identifier"
    - name: "flight_status"
      expr: flight_status
      comment: "Current status of the flight"
    - name: "approval_status"
      expr: approval_status
      comment: "Flight approval status"
    - name: "creative_format"
      expr: creative_format
      comment: "Format of creative used in flight"
    - name: "placement_name"
      expr: placement_name
      comment: "Ad placement name"
    - name: "esg_aligned"
      expr: esg_aligned
      comment: "Whether flight is ESG aligned"
    - name: "fair_housing_compliant"
      expr: fair_housing_compliant
      comment: "Fair housing compliance indicator"
    - name: "utm_source"
      expr: utm_source
      comment: "UTM source parameter for tracking"
    - name: "utm_medium"
      expr: utm_medium
      comment: "UTM medium parameter for tracking"
    - name: "utm_campaign"
      expr: utm_campaign
      comment: "UTM campaign parameter for tracking"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year of flight start"
    - name: "start_quarter"
      expr: CONCAT('Q', QUARTER(start_date))
      comment: "Quarter of flight start"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month of flight start"
  measures:
    - name: "total_flights"
      expr: COUNT(1)
      comment: "Total number of campaign flights"
    - name: "total_flight_budget"
      expr: SUM(CAST(flight_budget AS DOUBLE))
      comment: "Total budgeted amount for flights"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual spend on flights"
    - name: "total_impressions"
      expr: SUM(CAST(impressions_delivered AS BIGINT))
      comment: "Total impressions delivered across flights"
    - name: "total_clicks"
      expr: SUM(CAST(clicks AS BIGINT))
      comment: "Total clicks generated across flights"
    - name: "avg_cpm"
      expr: AVG(CAST(cpm_rate AS DOUBLE))
      comment: "Average cost per thousand impressions"
    - name: "avg_cpc"
      expr: AVG(CAST(cpc_rate AS DOUBLE))
      comment: "Average cost per click"
    - name: "click_through_rate"
      expr: ROUND(100.0 * SUM(CAST(clicks AS BIGINT)) / NULLIF(SUM(CAST(impressions_delivered AS BIGINT)), 0), 4)
      comment: "Overall click-through rate as percentage of impressions"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_spend AS DOUBLE)) / NULLIF(SUM(CAST(flight_budget AS DOUBLE)), 0), 2)
      comment: "Percentage of flight budget actually spent"
    - name: "cost_per_impression"
      expr: ROUND(SUM(CAST(actual_spend AS DOUBLE)) / NULLIF(SUM(CAST(impressions_delivered AS BIGINT)), 0), 4)
      comment: "Actual cost per impression delivered"
    - name: "cost_per_click"
      expr: ROUND(SUM(CAST(actual_spend AS DOUBLE)) / NULLIF(SUM(CAST(clicks AS BIGINT)), 0), 2)
      comment: "Actual cost per click generated"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`marketing_lead_generation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead generation and conversion metrics tracking lead volume, quality, conversion rates, and pipeline health"
  source: "`real_estate_ecm`.`marketing`.`lead`"
  dimensions:
    - name: "lead_status"
      expr: lead_status
      comment: "Current status of the lead"
    - name: "lead_type"
      expr: lead_type
      comment: "Type of lead"
    - name: "lead_source"
      expr: lead_source
      comment: "Source of the lead"
    - name: "source_portal"
      expr: source_portal
      comment: "Portal where lead originated"
    - name: "grade"
      expr: grade
      comment: "Lead grade or quality score"
    - name: "utm_source"
      expr: utm_source
      comment: "UTM source parameter"
    - name: "utm_medium"
      expr: utm_medium
      comment: "UTM medium parameter"
    - name: "utm_campaign"
      expr: utm_campaign
      comment: "UTM campaign parameter"
    - name: "do_not_contact"
      expr: do_not_contact
      comment: "Do not contact flag"
    - name: "gdpr_consent"
      expr: gdpr_consent
      comment: "GDPR consent status"
    - name: "is_duplicate"
      expr: is_duplicate
      comment: "Whether lead is a duplicate"
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year lead was created"
    - name: "created_quarter"
      expr: CONCAT('Q', QUARTER(created_timestamp))
      comment: "Quarter lead was created"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month lead was created"
    - name: "conversion_year"
      expr: YEAR(conversion_date)
      comment: "Year lead was converted"
  measures:
    - name: "total_leads"
      expr: COUNT(1)
      comment: "Total number of leads"
    - name: "unique_leads"
      expr: COUNT(DISTINCT lead_id)
      comment: "Count of unique leads"
    - name: "converted_leads"
      expr: SUM(CASE WHEN conversion_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of leads that converted"
    - name: "duplicate_leads"
      expr: SUM(CASE WHEN is_duplicate = TRUE THEN 1 ELSE 0 END)
      comment: "Number of duplicate leads"
    - name: "do_not_contact_leads"
      expr: SUM(CASE WHEN do_not_contact = TRUE THEN 1 ELSE 0 END)
      comment: "Number of leads marked do not contact"
    - name: "gdpr_consented_leads"
      expr: SUM(CASE WHEN gdpr_consent = TRUE THEN 1 ELSE 0 END)
      comment: "Number of leads with GDPR consent"
    - name: "avg_budget_max"
      expr: AVG(CAST(budget_max AS DOUBLE))
      comment: "Average maximum budget across leads"
    - name: "avg_budget_min"
      expr: AVG(CAST(budget_min AS DOUBLE))
      comment: "Average minimum budget across leads"
    - name: "lead_conversion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN conversion_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of leads that converted to opportunities or customers"
    - name: "duplicate_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_duplicate = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of leads that are duplicates"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`marketing_lead_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead engagement metrics tracking activity volume, conversion events, and engagement patterns across channels"
  source: "`real_estate_ecm`.`marketing`.`lead_activity`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of lead activity"
    - name: "activity_status"
      expr: activity_status
      comment: "Status of the activity"
    - name: "activity_direction"
      expr: activity_direction
      comment: "Direction of activity (inbound/outbound)"
    - name: "channel_subtype"
      expr: channel_subtype
      comment: "Subtype of marketing channel"
    - name: "content_type"
      expr: content_type
      comment: "Type of content engaged with"
    - name: "device_type"
      expr: device_type
      comment: "Device type used for activity"
    - name: "funnel_stage"
      expr: funnel_stage
      comment: "Marketing funnel stage"
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the activity"
    - name: "is_conversion_event"
      expr: is_conversion_event
      comment: "Whether activity is a conversion event"
    - name: "conversion_type"
      expr: conversion_type
      comment: "Type of conversion"
    - name: "consent_status"
      expr: consent_status
      comment: "Consent status at time of activity"
    - name: "opt_out_flag"
      expr: opt_out_flag
      comment: "Whether lead opted out"
    - name: "attribution_model"
      expr: attribution_model
      comment: "Attribution model used"
    - name: "utm_source"
      expr: utm_source
      comment: "UTM source parameter"
    - name: "utm_medium"
      expr: utm_medium
      comment: "UTM medium parameter"
    - name: "activity_year"
      expr: YEAR(activity_timestamp)
      comment: "Year of activity"
    - name: "activity_month"
      expr: DATE_TRUNC('MONTH', activity_timestamp)
      comment: "Month of activity"
  measures:
    - name: "total_activities"
      expr: COUNT(1)
      comment: "Total number of lead activities"
    - name: "unique_leads_engaged"
      expr: COUNT(DISTINCT lead_id)
      comment: "Number of unique leads with activity"
    - name: "conversion_events"
      expr: SUM(CASE WHEN is_conversion_event = TRUE THEN 1 ELSE 0 END)
      comment: "Number of conversion events"
    - name: "opt_out_events"
      expr: SUM(CASE WHEN opt_out_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of opt-out events"
    - name: "total_attribution_weight"
      expr: SUM(CAST(attribution_weight AS DOUBLE))
      comment: "Total attribution weight across activities"
    - name: "avg_attribution_weight"
      expr: AVG(CAST(attribution_weight AS DOUBLE))
      comment: "Average attribution weight per activity"
    - name: "conversion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_conversion_event = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of activities that are conversion events"
    - name: "opt_out_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN opt_out_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of activities resulting in opt-out"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`marketing_email_campaign_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Email campaign performance metrics tracking delivery, engagement, and conversion rates"
  source: "`real_estate_ecm`.`marketing`.`campaign`"
  dimensions:
    - name: "gdpr_compliant_flag"
      expr: gdpr_compliant_flag
      comment: "GDPR compliance indicator"
    - name: "fair_housing_compliant_flag"
      expr: fair_housing_compliant_flag
      comment: "Fair housing compliance indicator"
  measures:
    - name: "total_email_campaigns"
      expr: COUNT(1)
      comment: "Total number of email campaigns"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`marketing_event_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event marketing performance metrics tracking attendance, cost efficiency, and lead generation from events"
  source: "`real_estate_ecm`.`marketing`.`event`"
  dimensions:
    - name: "event_name"
      expr: event_name
      comment: "Name of the marketing event"
    - name: "event_number"
      expr: event_number
      comment: "Event number identifier"
    - name: "event_type"
      expr: event_type
      comment: "Type of event"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the event"
    - name: "is_public"
      expr: is_public
      comment: "Whether event is public"
    - name: "is_virtual"
      expr: is_virtual
      comment: "Whether event is virtual"
    - name: "requires_registration"
      expr: requires_registration
      comment: "Whether event requires registration"
    - name: "theme"
      expr: theme
      comment: "Event theme"
    - name: "venue_city"
      expr: venue_city
      comment: "City where event is held"
    - name: "venue_country"
      expr: venue_country
      comment: "Country where event is held"
    - name: "virtual_platform"
      expr: virtual_platform
      comment: "Virtual event platform used"
    - name: "event_year"
      expr: YEAR(event_date)
      comment: "Year of event"
    - name: "event_quarter"
      expr: CONCAT('Q', QUARTER(event_date))
      comment: "Quarter of event"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month of event"
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of marketing events"
    - name: "total_budgeted_cost"
      expr: SUM(CAST(budgeted_cost AS DOUBLE))
      comment: "Total budgeted cost for events"
    - name: "total_actual_cost"
      expr: SUM(CAST(total_event_cost AS DOUBLE))
      comment: "Total actual cost of events"
    - name: "avg_event_cost"
      expr: AVG(CAST(total_event_cost AS DOUBLE))
      comment: "Average cost per event"
    - name: "cost_variance"
      expr: SUM((CAST(total_event_cost AS DOUBLE)) - (CAST(budgeted_cost AS DOUBLE)))
      comment: "Total cost variance (actual minus budgeted)"
    - name: "cost_variance_rate"
      expr: ROUND(100.0 * (SUM(CAST(total_event_cost AS DOUBLE)) - SUM(CAST(budgeted_cost AS DOUBLE))) / NULLIF(SUM(CAST(budgeted_cost AS DOUBLE)), 0), 2)
      comment: "Cost variance as percentage of budgeted cost"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`marketing_budget_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing budget performance metrics tracking budget allocation, utilization, variance, and spend efficiency"
  source: "`real_estate_ecm`.`marketing`.`marketing_budget`"
  dimensions:
    - name: "budget_code"
      expr: budget_code
      comment: "Budget code identifier"
    - name: "budget_name"
      expr: budget_name
      comment: "Budget name"
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget"
    - name: "budget_scope"
      expr: budget_scope
      comment: "Scope of budget (campaign, channel, property, etc.)"
    - name: "budget_status"
      expr: budget_status
      comment: "Current budget status"
    - name: "period_type"
      expr: period_type
      comment: "Budget period type (monthly, quarterly, annual)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter"
    - name: "fiscal_month"
      expr: fiscal_month
      comment: "Fiscal month"
    - name: "opex_capex_flag"
      expr: opex_capex_flag
      comment: "Whether budget is OPEX or CAPEX"
    - name: "property_class"
      expr: property_class
      comment: "Property class for budget"
    - name: "version"
      expr: version
      comment: "Budget version"
  measures:
    - name: "total_budget_lines"
      expr: COUNT(1)
      comment: "Total number of budget line items"
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved budget amount"
    - name: "total_revised_amount"
      expr: SUM(CAST(revised_amount AS DOUBLE))
      comment: "Total revised budget amount"
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed budget amount"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual spend against budget"
    - name: "total_variance"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance"
    - name: "avg_approved_budget"
      expr: AVG(CAST(approved_amount AS DOUBLE))
      comment: "Average approved budget per line"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_spend AS DOUBLE)) / NULLIF(SUM(CAST(approved_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of approved budget actually spent"
    - name: "commitment_rate"
      expr: ROUND(100.0 * SUM(CAST(committed_amount AS DOUBLE)) / NULLIF(SUM(CAST(approved_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of approved budget committed"
    - name: "variance_rate"
      expr: ROUND(100.0 * SUM(CAST(variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(approved_amount AS DOUBLE)), 0), 2)
      comment: "Budget variance as percentage of approved budget"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`marketing_channel_effectiveness`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing channel effectiveness metrics tracking channel performance benchmarks and compliance"
  source: "`real_estate_ecm`.`marketing`.`channel`"
  dimensions:
    - name: "channel_code"
      expr: channel_code
      comment: "Channel code identifier"
    - name: "channel_name"
      expr: channel_name
      comment: "Channel name"
    - name: "channel_category"
      expr: channel_category
      comment: "Channel category"
    - name: "channel_status"
      expr: channel_status
      comment: "Current channel status"
    - name: "owned_paid_earned"
      expr: owned_paid_earned
      comment: "Channel classification (owned, paid, earned)"
    - name: "digital_flag"
      expr: digital_flag
      comment: "Whether channel is digital"
    - name: "platform_name"
      expr: platform_name
      comment: "Platform name"
    - name: "cost_model"
      expr: cost_model
      comment: "Cost model for the channel"
    - name: "audience_type"
      expr: audience_type
      comment: "Target audience type"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of channel"
    - name: "esg_aligned"
      expr: esg_aligned
      comment: "Whether channel is ESG aligned"
    - name: "fair_housing_compliant"
      expr: fair_housing_compliant
      comment: "Fair housing compliance indicator"
    - name: "gdpr_compliant"
      expr: gdpr_compliant
      comment: "GDPR compliance indicator"
    - name: "can_spam_compliant"
      expr: can_spam_compliant
      comment: "CAN-SPAM compliance indicator"
    - name: "mls_affiliated"
      expr: mls_affiliated
      comment: "Whether channel is MLS affiliated"
  measures:
    - name: "total_channels"
      expr: COUNT(1)
      comment: "Total number of marketing channels"
    - name: "active_channels"
      expr: SUM(CASE WHEN channel_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of active channels"
    - name: "avg_benchmark_cpm"
      expr: AVG(CAST(benchmark_cpm_amount AS DOUBLE))
      comment: "Average benchmark cost per thousand impressions across channels"
    - name: "avg_benchmark_cpc"
      expr: AVG(CAST(benchmark_cpc_amount AS DOUBLE))
      comment: "Average benchmark cost per click across channels"
    - name: "avg_benchmark_cpl"
      expr: AVG(CAST(benchmark_cpl_amount AS DOUBLE))
      comment: "Average benchmark cost per lead across channels"
    - name: "avg_lead_attribution_weight"
      expr: AVG(CAST(lead_attribution_weight AS DOUBLE))
      comment: "Average lead attribution weight across channels"
    - name: "avg_min_spend"
      expr: AVG(CAST(min_spend_amount AS DOUBLE))
      comment: "Average minimum spend requirement across channels"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`marketing_lead_attribution_roi`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead attribution and marketing ROI metrics tracking attributed deal value, campaign effectiveness, and conversion performance"
  source: "`real_estate_ecm`.`marketing`.`lead_attribution`"
  dimensions:
    - name: "attribution_model"
      expr: attribution_model
      comment: "Attribution model used (first-touch, last-touch, multi-touch, etc.)"
    - name: "attribution_model_version"
      expr: attribution_model_version
      comment: "Version of attribution model"
    - name: "attribution_status"
      expr: attribution_status
      comment: "Status of attribution record"
    - name: "conversion_event_type"
      expr: conversion_event_type
      comment: "Type of conversion event"
    - name: "is_primary_attribution"
      expr: is_primary_attribution
      comment: "Whether this is the primary attribution"
    - name: "is_cross_channel"
      expr: is_cross_channel
      comment: "Whether attribution spans multiple channels"
    - name: "conversion_year"
      expr: YEAR(conversion_date)
      comment: "Year of conversion"
    - name: "conversion_quarter"
      expr: CONCAT('Q', QUARTER(conversion_date))
      comment: "Quarter of conversion"
    - name: "conversion_month"
      expr: DATE_TRUNC('MONTH', conversion_date)
      comment: "Month of conversion"
    - name: "first_touch_year"
      expr: YEAR(first_touch_date)
      comment: "Year of first touch"
  measures:
    - name: "total_attributions"
      expr: COUNT(1)
      comment: "Total number of attribution records"
    - name: "unique_leads_attributed"
      expr: COUNT(DISTINCT lead_id)
      comment: "Number of unique leads with attribution"
    - name: "total_attributed_deal_value"
      expr: SUM(CAST(attributed_deal_value AS DOUBLE))
      comment: "Total deal value attributed to marketing"
    - name: "total_weighted_attributed_value"
      expr: SUM(CAST(weighted_attributed_value AS DOUBLE))
      comment: "Total weighted attributed value based on attribution model"
    - name: "total_campaign_cost_attributed"
      expr: SUM(CAST(campaign_cost_attributed AS DOUBLE))
      comment: "Total campaign cost attributed to conversions"
    - name: "avg_attribution_weight"
      expr: AVG(CAST(attribution_weight AS DOUBLE))
      comment: "Average attribution weight per record"
    - name: "avg_deal_value"
      expr: AVG(CAST(attributed_deal_value AS DOUBLE))
      comment: "Average attributed deal value"
    - name: "marketing_roi"
      expr: ROUND((SUM(CAST(attributed_deal_value AS DOUBLE)) - SUM(CAST(campaign_cost_attributed AS DOUBLE))) / NULLIF(SUM(CAST(campaign_cost_attributed AS DOUBLE)), 0), 2)
      comment: "Marketing return on investment (ROI) as ratio of net value to cost"
    - name: "cost_per_attributed_deal"
      expr: ROUND(SUM(CAST(campaign_cost_attributed AS DOUBLE)) / NULLIF(COUNT(DISTINCT lead_id), 0), 2)
      comment: "Average campaign cost per attributed deal"
$$;