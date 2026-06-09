-- Metric views for domain: marketing | Business: Travel Hospitality | Version: 1 | Generated on: 2026-05-08 05:56:59

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`marketing_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic campaign financial performance and budget governance metrics. Enables CMOs and finance partners to track spend efficiency, budget utilisation, and variance across all active marketing campaigns."
  source: "`travel_hospitality_ecm`.`marketing`.`campaign`"
  dimensions:
    - name: "campaign_name"
      expr: campaign_name
      comment: "Human-readable campaign name for grouping and filtering in dashboards."
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (e.g. email, paid search, social) used to compare spend efficiency across channels."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current lifecycle status of the campaign (active, completed, paused) for operational filtering."
    - name: "campaign_objective"
      expr: objective
      comment: "Business objective of the campaign (e.g. acquisition, retention, upsell) for strategic segmentation."
    - name: "target_segment"
      expr: target_segment
      comment: "Guest segment the campaign is targeting, enabling segment-level performance comparison."
    - name: "brand_scope"
      expr: brand_scope
      comment: "Brand(s) the campaign is scoped to, supporting brand-level budget and performance analysis."
    - name: "budget_period"
      expr: budget_period
      comment: "Fiscal or calendar period the campaign budget is allocated to, for period-over-period comparisons."
    - name: "campaign_start_date"
      expr: DATE_TRUNC('month', start_date)
      comment: "Campaign start month bucket for trend analysis."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the campaign is currently active, for live vs. historical filtering."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the campaign, used to track governance compliance."
  measures:
    - name: "total_campaign_budget"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total approved marketing budget across campaigns. Core financial planning KPI used in budget reviews."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend incurred across campaigns. Compared against budget to assess financial discipline."
    - name: "total_committed_spend"
      expr: SUM(CAST(committed_spend_amount AS DOUBLE))
      comment: "Total committed (obligated but not yet invoiced) spend. Critical for cash-flow forecasting."
    - name: "total_remaining_budget"
      expr: SUM(CAST(remaining_budget_amount AS DOUBLE))
      comment: "Total unspent budget remaining across campaigns. Signals under- or over-investment risk."
    - name: "total_budget_variance"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Aggregate budget variance (actual vs. planned). Negative values indicate overspend; positive indicates underspend."
    - name: "avg_campaign_budget"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average budget per campaign. Benchmarks investment level and supports resource allocation decisions."
    - name: "total_email_budget"
      expr: SUM(CAST(email_budget_amount AS DOUBLE))
      comment: "Total budget allocated to email channel across campaigns. Supports channel mix optimisation."
    - name: "total_paid_search_budget"
      expr: SUM(CAST(paid_search_budget_amount AS DOUBLE))
      comment: "Total budget allocated to paid search. Enables SEM investment tracking and ROI benchmarking."
    - name: "total_social_budget"
      expr: SUM(CAST(social_budget_amount AS DOUBLE))
      comment: "Total budget allocated to social media channels. Supports social channel investment decisions."
    - name: "total_display_budget"
      expr: SUM(CAST(display_budget_amount AS DOUBLE))
      comment: "Total budget allocated to display advertising. Enables display vs. other channel budget comparison."
    - name: "campaign_count"
      expr: COUNT(1)
      comment: "Total number of campaigns. Baseline volume metric for portfolio size and governance reporting."
    - name: "active_campaign_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active campaigns. Operational KPI for marketing execution capacity."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`marketing_campaign_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign execution performance metrics covering delivery, engagement, conversion, and cost efficiency. Enables marketing operations teams to evaluate channel-level execution quality and ROI."
  source: "`travel_hospitality_ecm`.`marketing`.`campaign_execution`"
  dimensions:
    - name: "execution_status"
      expr: execution_status
      comment: "Current status of the execution run (sent, completed, failed) for operational monitoring."
    - name: "channel_category"
      expr: channel_category
      comment: "High-level channel category (email, SMS, push, display) for cross-channel performance comparison."
    - name: "channel_cost_model"
      expr: channel_cost_model
      comment: "Cost model used for the channel (CPM, CPC, CPA) to support cost efficiency analysis."
    - name: "spend_category"
      expr: spend_category
      comment: "Spend classification (media, production, agency) for granular cost management."
    - name: "ab_test_variant"
      expr: ab_test_variant
      comment: "A/B test variant identifier, enabling lift and performance comparison between test cells."
    - name: "attribution_model_type"
      expr: attribution_model_type
      comment: "Attribution model applied (last-click, first-click, linear) for revenue attribution analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the execution invoice, used for financial reconciliation."
    - name: "execution_month"
      expr: DATE_TRUNC('month', execution_timestamp)
      comment: "Month of execution for trend and seasonality analysis."
    - name: "creative_version"
      expr: creative_version
      comment: "Creative version used in the execution, enabling creative performance benchmarking."
  measures:
    - name: "total_execution_cost"
      expr: SUM(CAST(execution_cost AS DOUBLE))
      comment: "Total cost incurred across all campaign executions. Primary financial KPI for marketing spend management."
    - name: "total_revenue_attributed"
      expr: SUM(CAST(revenue_attributed AS DOUBLE))
      comment: "Total revenue attributed to campaign executions. Core ROI numerator for marketing investment decisions."
    - name: "avg_execution_cost"
      expr: AVG(CAST(execution_cost AS DOUBLE))
      comment: "Average cost per execution run. Benchmarks efficiency and identifies outlier spend events."
    - name: "avg_revenue_attributed"
      expr: AVG(CAST(revenue_attributed AS DOUBLE))
      comment: "Average revenue attributed per execution. Supports per-execution ROI benchmarking."
    - name: "execution_count"
      expr: COUNT(1)
      comment: "Total number of execution runs. Volume baseline for throughput and capacity planning."
    - name: "distinct_campaign_count"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns with executions. Measures breadth of active campaign portfolio."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`marketing_attribution_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital attribution and conversion performance metrics. Enables marketing analytics teams to evaluate channel effectiveness, conversion rates, and attribution credit distribution across touchpoints."
  source: "`travel_hospitality_ecm`.`marketing`.`attribution_event`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Marketing channel (organic, paid, email, social) for channel-level attribution analysis."
    - name: "attribution_model"
      expr: attribution_model
      comment: "Attribution model applied to the event (last-click, first-click, data-driven) for model comparison."
    - name: "ad_platform"
      expr: ad_platform
      comment: "Advertising platform (Google, Meta, programmatic) for platform-level ROI analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device type (mobile, desktop, tablet) for device-level conversion analysis."
    - name: "geo_country_code"
      expr: geo_country_code
      comment: "Country of the attribution event for geographic performance segmentation."
    - name: "geo_region"
      expr: geo_region
      comment: "Region of the attribution event for sub-national geographic analysis."
    - name: "utm_source"
      expr: utm_source
      comment: "UTM source parameter for campaign traffic source attribution."
    - name: "utm_medium"
      expr: utm_medium
      comment: "UTM medium parameter for campaign medium-level attribution."
    - name: "utm_campaign"
      expr: utm_campaign
      comment: "UTM campaign tag for campaign-level digital attribution."
    - name: "event_status"
      expr: event_status
      comment: "Status of the attribution event (valid, duplicate, suppressed) for data quality filtering."
    - name: "conversion_flag"
      expr: conversion_flag
      comment: "Boolean indicating whether the event resulted in a conversion, for conversion funnel analysis."
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of the attribution event for trend analysis."
    - name: "touchpoint_sequence"
      expr: touchpoint_sequence
      comment: "Position of the touchpoint in the customer journey (first, middle, last) for path analysis."
  measures:
    - name: "total_attribution_credit"
      expr: SUM(CAST(attribution_credit AS DOUBLE))
      comment: "Total attribution credit assigned across all events. Measures channel contribution to conversions."
    - name: "total_conversion_value"
      expr: SUM(CAST(conversion_value AS DOUBLE))
      comment: "Total monetary value of conversions attributed. Primary revenue attribution KPI for marketing ROI."
    - name: "avg_conversion_value"
      expr: AVG(CAST(conversion_value AS DOUBLE))
      comment: "Average conversion value per event. Benchmarks quality of conversions across channels and campaigns."
    - name: "avg_time_to_conversion_hours"
      expr: AVG(CAST(time_to_conversion_hours AS DOUBLE))
      comment: "Average hours from first touchpoint to conversion. Measures funnel velocity and campaign urgency effectiveness."
    - name: "conversion_event_count"
      expr: COUNT(CASE WHEN conversion_flag = TRUE THEN 1 END)
      comment: "Total number of conversion events. Core volume KPI for campaign conversion performance."
    - name: "total_event_count"
      expr: COUNT(1)
      comment: "Total attribution events recorded. Denominator for conversion rate calculations."
    - name: "distinct_profile_count"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guest profiles touched by marketing events. Measures campaign reach."
    - name: "distinct_campaign_count"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns generating attribution events. Measures active campaign breadth."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`marketing_offer_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Offer redemption and discount economics metrics. Enables revenue management and marketing teams to evaluate offer uptake, discount depth, and net rate impact across campaigns and properties."
  source: "`travel_hospitality_ecm`.`marketing`.`offer_redemption`"
  dimensions:
    - name: "offer_code"
      expr: offer_code
      comment: "Offer code redeemed, enabling offer-level performance tracking."
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount applied (percentage, flat, points) for discount structure analysis."
    - name: "attribution_source"
      expr: attribution_source
      comment: "Source channel that drove the redemption, for channel-level offer attribution."
    - name: "device_type"
      expr: device_type
      comment: "Device used at redemption (mobile, desktop) for device-level conversion analysis."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation outcome of the redemption (approved, rejected) for fraud and compliance monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the redemption transaction for multi-currency financial reporting."
    - name: "redemption_month"
      expr: DATE_TRUNC('month', redemption_timestamp)
      comment: "Month of redemption for trend and seasonality analysis."
    - name: "booking_date"
      expr: DATE_TRUNC('month', booking_date)
      comment: "Booking month associated with the redemption for lead-time analysis."
  measures:
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value granted through offer redemptions. Measures revenue dilution from promotional activity."
    - name: "total_final_rate_amount"
      expr: SUM(CAST(final_rate_amount AS DOUBLE))
      comment: "Total net rate revenue after discount. Core post-promotion revenue KPI."
    - name: "total_original_rate_amount"
      expr: SUM(CAST(original_rate_amount AS DOUBLE))
      comment: "Total rack/original rate before discount. Used to compute revenue dilution and discount depth."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied per redemption. Measures promotional depth and pricing discipline."
    - name: "avg_final_rate_amount"
      expr: AVG(CAST(final_rate_amount AS DOUBLE))
      comment: "Average net rate per redemption. Benchmarks effective rate quality across offers."
    - name: "redemption_count"
      expr: COUNT(1)
      comment: "Total number of offer redemptions. Volume KPI for offer uptake and campaign activation."
    - name: "distinct_guest_count"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guests redeeming offers. Measures offer reach and guest activation breadth."
    - name: "distinct_offer_count"
      expr: COUNT(DISTINCT campaign_offer_id)
      comment: "Number of distinct offers redeemed. Measures offer portfolio utilisation."
    - name: "approved_redemption_count"
      expr: COUNT(CASE WHEN validation_status = 'approved' THEN 1 END)
      comment: "Number of validated and approved redemptions. Excludes fraudulent or invalid claims for clean revenue reporting."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`marketing_guest_communication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest communication engagement and conversion metrics. Enables CRM and digital marketing teams to measure email/SMS delivery quality, open rates, click-through, and revenue conversion across communication programmes."
  source: "`travel_hospitality_ecm`.`marketing`.`guest_communication`"
  dimensions:
    - name: "communication_type"
      expr: communication_type
      comment: "Type of communication (transactional, promotional, service) for programme-level analysis."
    - name: "channel"
      expr: channel
      comment: "Delivery channel (email, SMS, push) for channel-level engagement benchmarking."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery outcome (delivered, bounced, suppressed) for deliverability monitoring."
    - name: "opt_in_status"
      expr: opt_in_status
      comment: "Guest opt-in status at time of send, for consent-compliant reporting."
    - name: "language_code"
      expr: language_code
      comment: "Language of the communication for localisation performance analysis."
    - name: "ab_test_variant"
      expr: ab_test_variant
      comment: "A/B test variant for subject line, content, or send-time optimisation analysis."
    - name: "conversion_flag"
      expr: conversion_flag
      comment: "Boolean indicating whether the communication led to a conversion event."
    - name: "send_month"
      expr: DATE_TRUNC('month', sent_timestamp)
      comment: "Month communications were sent for trend and volume analysis."
    - name: "send_priority"
      expr: send_priority
      comment: "Priority level of the send (high, normal, low) for queue management analysis."
  measures:
    - name: "total_communications_sent"
      expr: COUNT(1)
      comment: "Total communications sent. Baseline volume KPI for CRM programme scale and capacity."
    - name: "total_conversion_value"
      expr: SUM(CAST(conversion_value AS DOUBLE))
      comment: "Total revenue value generated from communication conversions. Primary CRM revenue attribution KPI."
    - name: "avg_conversion_value"
      expr: AVG(CAST(conversion_value AS DOUBLE))
      comment: "Average revenue per converting communication. Measures communication quality and targeting effectiveness."
    - name: "delivered_count"
      expr: COUNT(CASE WHEN delivery_status = 'delivered' THEN 1 END)
      comment: "Number of successfully delivered communications. Deliverability KPI for sender reputation management."
    - name: "bounced_count"
      expr: COUNT(CASE WHEN delivery_status = 'bounced' THEN 1 END)
      comment: "Number of bounced communications. High bounce rates signal list hygiene issues requiring action."
    - name: "conversion_count"
      expr: COUNT(CASE WHEN conversion_flag = TRUE THEN 1 END)
      comment: "Number of communications that resulted in a conversion. Core CRM effectiveness KPI."
    - name: "distinct_guest_count"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guests communicated with. Measures CRM programme reach."
    - name: "distinct_campaign_count"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns driving communications. Measures campaign activation breadth."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`marketing_survey_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest satisfaction and NPS survey response metrics. Enables guest experience and marketing teams to track satisfaction scores, sentiment, and survey response rates to drive service improvement decisions."
  source: "`travel_hospitality_ecm`.`marketing`.`survey_response`"
  dimensions:
    - name: "nps_classification"
      expr: nps_classification
      comment: "NPS classification (Promoter, Passive, Detractor) for loyalty and advocacy segmentation."
    - name: "sentiment_classification"
      expr: sentiment_classification
      comment: "Sentiment classification (positive, neutral, negative) derived from verbatim analysis."
    - name: "response_channel"
      expr: response_channel
      comment: "Channel through which the survey was completed (email, in-app, kiosk) for channel response analysis."
    - name: "guest_type"
      expr: guest_type
      comment: "Guest type (leisure, business, group) for segment-level satisfaction benchmarking."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Loyalty tier of the responding guest for tier-level satisfaction and NPS analysis."
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel used to book the stay, enabling satisfaction analysis by booking source."
    - name: "response_status"
      expr: response_status
      comment: "Status of the survey response (complete, partial, abandoned) for response quality filtering."
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Boolean flag indicating whether a service recovery follow-up is required."
    - name: "checkout_month"
      expr: DATE_TRUNC('month', checkout_date)
      comment: "Month of guest checkout for trend analysis of satisfaction over time."
    - name: "survey_language"
      expr: survey_language
      comment: "Language in which the survey was completed for localisation and market analysis."
  measures:
    - name: "avg_gss_score"
      expr: AVG(CAST(gss_score AS DOUBLE))
      comment: "Average Guest Satisfaction Score. Primary guest experience KPI used in executive dashboards and property rankings."
    - name: "avg_csat_score"
      expr: AVG(CAST(csat_score AS DOUBLE))
      comment: "Average Customer Satisfaction Score. Operational quality KPI for service delivery benchmarking."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score from verbatim analysis. Tracks qualitative guest perception trends."
    - name: "total_survey_responses"
      expr: COUNT(1)
      comment: "Total survey responses received. Volume baseline for response rate and programme reach calculations."
    - name: "promoter_count"
      expr: COUNT(CASE WHEN nps_classification = 'Promoter' THEN 1 END)
      comment: "Number of Promoter responses. Used to compute NPS and track advocacy pipeline."
    - name: "detractor_count"
      expr: COUNT(CASE WHEN nps_classification = 'Detractor' THEN 1 END)
      comment: "Number of Detractor responses. Tracks at-risk guests requiring service recovery intervention."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END)
      comment: "Number of responses flagging a required follow-up. Operational KPI for service recovery workload management."
    - name: "avg_total_spend_amount"
      expr: AVG(CAST(total_spend_amount AS DOUBLE))
      comment: "Average total spend per responding guest. Enables correlation of satisfaction scores with guest value."
    - name: "distinct_property_count"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties represented in survey responses. Measures programme coverage breadth."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`marketing_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest consent and marketing permission metrics. Enables compliance, legal, and CRM teams to monitor opt-in rates, consent coverage, and regulatory compliance across jurisdictions and brands."
  source: "`travel_hospitality_ecm`.`marketing`.`consent`"
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent captured (marketing, data processing, third-party sharing) for compliance categorisation."
    - name: "consent_status"
      expr: consent_status
      comment: "Current consent status (active, withdrawn, expired) for live permission state reporting."
    - name: "consent_source"
      expr: consent_source
      comment: "Source through which consent was captured (web, in-property, call centre) for channel analysis."
    - name: "legal_basis"
      expr: legal_basis
      comment: "Legal basis for processing (consent, legitimate interest, contract) for GDPR/regulatory reporting."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Regulatory jurisdiction (EU, US, APAC) for region-specific compliance monitoring."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag for currently active consents, enabling live addressable audience sizing."
    - name: "double_opt_in_confirmed"
      expr: double_opt_in_confirmed
      comment: "Boolean indicating double opt-in confirmation, critical for email compliance in regulated markets."
    - name: "consent_month"
      expr: DATE_TRUNC('month', consent_date)
      comment: "Month consent was captured for trend analysis of opt-in growth."
    - name: "consent_scope"
      expr: consent_scope
      comment: "Scope of consent (brand-wide, property-specific, programme-specific) for audience segmentation."
  measures:
    - name: "total_consent_records"
      expr: COUNT(1)
      comment: "Total consent records. Baseline for addressable audience size and compliance coverage reporting."
    - name: "active_consent_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active consents. Defines the legally addressable marketing audience."
    - name: "double_opt_in_count"
      expr: COUNT(CASE WHEN double_opt_in_confirmed = TRUE THEN 1 END)
      comment: "Number of double opt-in confirmed consents. Highest-quality consent tier for regulated market compliance."
    - name: "withdrawn_consent_count"
      expr: COUNT(CASE WHEN consent_status = 'withdrawn' THEN 1 END)
      comment: "Number of withdrawn consents. Tracks opt-out volume and signals potential brand trust issues."
    - name: "distinct_guest_count"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guests with consent records. Measures CRM database coverage and addressable audience breadth."
    - name: "distinct_brand_count"
      expr: COUNT(DISTINCT brand_id)
      comment: "Number of distinct brands covered by consent records. Measures consent programme breadth across the portfolio."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`marketing_campaign_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign offer design and discount economics metrics. Enables revenue management and marketing teams to evaluate offer portfolio composition, discount depth, and minimum spend thresholds across campaigns."
  source: "`travel_hospitality_ecm`.`marketing`.`campaign_offer`"
  dimensions:
    - name: "offer_type"
      expr: offer_type
      comment: "Type of offer (rate discount, bonus points, package inclusion) for offer portfolio analysis."
    - name: "offer_status"
      expr: offer_status
      comment: "Current status of the offer (active, expired, draft) for live offer portfolio monitoring."
    - name: "discount_type"
      expr: discount_type
      comment: "Discount mechanism (percentage, flat amount, points multiplier) for discount structure analysis."
    - name: "eligible_property_scope"
      expr: eligible_property_scope
      comment: "Property scope eligibility (all, select, specific codes) for offer distribution analysis."
    - name: "member_exclusive_flag"
      expr: member_exclusive_flag
      comment: "Boolean indicating whether the offer is exclusive to loyalty members, for loyalty programme value analysis."
    - name: "enrollment_required_flag"
      expr: enrollment_required_flag
      comment: "Boolean indicating whether loyalty enrolment is required to redeem, for acquisition offer tracking."
    - name: "booking_window_start_month"
      expr: DATE_TRUNC('month', booking_window_start_date)
      comment: "Booking window start month for offer timing and advance purchase analysis."
    - name: "eligible_tier_levels"
      expr: eligible_tier_levels
      comment: "Loyalty tier levels eligible for the offer, for tier-targeted offer analysis."
  measures:
    - name: "total_offers"
      expr: COUNT(1)
      comment: "Total number of campaign offers. Baseline for offer portfolio size and diversity reporting."
    - name: "avg_discount_value"
      expr: AVG(CAST(discount_value AS DOUBLE))
      comment: "Average discount value per offer. Measures promotional depth and pricing strategy aggressiveness."
    - name: "avg_minimum_spend_amount"
      expr: AVG(CAST(minimum_spend_amount AS DOUBLE))
      comment: "Average minimum spend threshold per offer. Indicates revenue protection level built into offer design."
    - name: "avg_bonus_points_multiplier"
      expr: AVG(CAST(bonus_points_multiplier AS DOUBLE))
      comment: "Average bonus points multiplier across offers. Measures loyalty currency investment in promotional activity."
    - name: "avg_tier_credit_multiplier"
      expr: AVG(CAST(tier_credit_multiplier AS DOUBLE))
      comment: "Average tier credit multiplier across offers. Measures tier acceleration investment in promotional design."
    - name: "member_exclusive_offer_count"
      expr: COUNT(CASE WHEN member_exclusive_flag = TRUE THEN 1 END)
      comment: "Number of member-exclusive offers. Measures loyalty programme differentiation through exclusive benefits."
    - name: "active_offer_count"
      expr: COUNT(CASE WHEN offer_status = 'active' THEN 1 END)
      comment: "Number of currently active offers. Operational KPI for live promotional inventory management."
    - name: "distinct_campaign_count"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns with associated offers. Measures offer-to-campaign linkage breadth."
$$;