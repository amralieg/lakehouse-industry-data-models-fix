-- Metric views for domain: marketing | Business: Gaming | Version: 1 | Generated on: 2026-05-08 07:57:15

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`marketing_ad_creative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ad Creative business metrics"
  source: "`gaming_ecm`.`marketing`.`ad_creative`"
  dimensions:
    - name: "Agency Name"
      expr: agency_name
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Archived Date"
      expr: archived_date
    - name: "Body Text"
      expr: body_text
    - name: "Call To Action"
      expr: call_to_action
    - name: "Coppa Compliant"
      expr: coppa_compliant
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Creative Code"
      expr: creative_code
    - name: "Creative Concept"
      expr: creative_concept
    - name: "Creative Name"
      expr: creative_name
    - name: "Creative Status"
      expr: creative_status
    - name: "Esrb Rating Compliant"
      expr: esrb_rating_compliant
    - name: "File Reference Uri"
      expr: file_reference_uri
    - name: "First Deployed Date"
      expr: first_deployed_date
    - name: "Format Type"
      expr: format_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ad Creative"
      expr: COUNT(DISTINCT ad_creative_id)
    - name: "Total Duration Seconds"
      expr: SUM(duration_seconds)
    - name: "Average Duration Seconds"
      expr: AVG(duration_seconds)
    - name: "Total File Size Mb"
      expr: SUM(file_size_mb)
    - name: "Average File Size Mb"
      expr: AVG(file_size_mb)
    - name: "Total Production Cost Usd"
      expr: SUM(production_cost_usd)
    - name: "Average Production Cost Usd"
      expr: AVG(production_cost_usd)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`marketing_ad_network`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ad Network business metrics"
  source: "`gaming_ecm`.`marketing`.`ad_network`"
  dimensions:
    - name: "Api Key Encrypted"
      expr: api_key_encrypted
    - name: "Attribution Window Click Days"
      expr: attribution_window_click_days
    - name: "Attribution Window Impression Days"
      expr: attribution_window_impression_days
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Coppa Compliant"
      expr: coppa_compliant
    - name: "Cost Reporting Method"
      expr: cost_reporting_method
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Sharing Agreement Status"
      expr: data_sharing_agreement_status
    - name: "Deprecation Date"
      expr: deprecation_date
    - name: "Fraud Protection Tier"
      expr: fraud_protection_tier
    - name: "Gdpr Compliant"
      expr: gdpr_compliant
    - name: "Integration Type"
      expr: integration_type
    - name: "Is Privacy Sandbox Compatible"
      expr: is_privacy_sandbox_compatible
    - name: "Is San"
      expr: is_san
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ad Network"
      expr: COUNT(DISTINCT ad_network_id)
    - name: "Total Monthly Spend Cap Usd"
      expr: SUM(monthly_spend_cap_usd)
    - name: "Average Monthly Spend Cap Usd"
      expr: AVG(monthly_spend_cap_usd)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`marketing_ad_set`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ad Set business metrics"
  source: "`gaming_ecm`.`marketing`.`ad_set`"
  dimensions:
    - name: "Age Max"
      expr: age_max
    - name: "Age Min"
      expr: age_min
    - name: "App Store Url"
      expr: app_store_url
    - name: "Attribution Window Click"
      expr: attribution_window_click
    - name: "Attribution Window View"
      expr: attribution_window_view
    - name: "Bid Strategy"
      expr: bid_strategy
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Creative Rotation"
      expr: creative_rotation
    - name: "Currency Code"
      expr: currency_code
    - name: "Deep Link Url"
      expr: deep_link_url
    - name: "Device Platforms"
      expr: device_platforms
    - name: "End Date"
      expr: end_date
    - name: "External Code"
      expr: external_code
    - name: "Frequency Cap"
      expr: frequency_cap
    - name: "Frequency Cap Period Hours"
      expr: frequency_cap_period_hours
    - name: "Gender"
      expr: gender
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ad Set"
      expr: COUNT(DISTINCT ad_set_id)
    - name: "Total Bid Amount"
      expr: SUM(bid_amount)
    - name: "Average Bid Amount"
      expr: AVG(bid_amount)
    - name: "Total Daily Budget"
      expr: SUM(daily_budget)
    - name: "Average Daily Budget"
      expr: AVG(daily_budget)
    - name: "Total Lifetime Budget"
      expr: SUM(lifetime_budget)
    - name: "Average Lifetime Budget"
      expr: AVG(lifetime_budget)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`marketing_aso_listing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aso Listing business metrics"
  source: "`gaming_ecm`.`marketing`.`aso_listing`"
  dimensions:
    - name: "Active Experiment Flag"
      expr: active_experiment_flag
    - name: "Contains Ads Flag"
      expr: contains_ads_flag
    - name: "Content Rating"
      expr: content_rating
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Current Version"
      expr: current_version
    - name: "Data Classification"
      expr: data_classification
    - name: "Experiment End Date"
      expr: experiment_end_date
    - name: "Experiment Start Date"
      expr: experiment_start_date
    - name: "Experiment Variant Code"
      expr: experiment_variant_code
    - name: "Feature Graphic Reference"
      expr: feature_graphic_reference
    - name: "In App Purchase Flag"
      expr: in_app_purchase_flag
    - name: "Keyword Set"
      expr: keyword_set
    - name: "Last Metadata Update Date"
      expr: last_metadata_update_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Listing Status"
      expr: listing_status
    - name: "Listing Title"
      expr: listing_title
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Aso Listing"
      expr: COUNT(DISTINCT aso_listing_id)
    - name: "Total Average Rating"
      expr: SUM(average_rating)
    - name: "Average Average Rating"
      expr: AVG(average_rating)
    - name: "Total Historical Conversion Rate"
      expr: SUM(historical_conversion_rate)
    - name: "Average Historical Conversion Rate"
      expr: AVG(historical_conversion_rate)
    - name: "Total Impression Count"
      expr: SUM(impression_count)
    - name: "Average Impression Count"
      expr: AVG(impression_count)
    - name: "Total Install Count"
      expr: SUM(install_count)
    - name: "Average Install Count"
      expr: AVG(install_count)
    - name: "Total Page View Count"
      expr: SUM(page_view_count)
    - name: "Average Page View Count"
      expr: AVG(page_view_count)
    - name: "Total Review Count"
      expr: SUM(review_count)
    - name: "Average Review Count"
      expr: AVG(review_count)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`marketing_attribution_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Attribution Record business metrics"
  source: "`gaming_ecm`.`marketing`.`attribution_record`"
  dimensions:
    - name: "Ad Set Name"
      expr: ad_set_name
    - name: "App Code"
      expr: app_code
    - name: "App Name"
      expr: app_name
    - name: "Attribution Platform"
      expr: attribution_platform
    - name: "Attribution Platform Record Reference"
      expr: attribution_platform_record_reference
    - name: "Attribution Timestamp"
      expr: attribution_timestamp
    - name: "Attribution Type"
      expr: attribution_type
    - name: "Attribution Window Hours"
      expr: attribution_window_hours
    - name: "Channel"
      expr: channel
    - name: "Click Timestamp"
      expr: click_timestamp
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Device Type"
      expr: device_type
    - name: "Fraud Reason"
      expr: fraud_reason
    - name: "Fraud Rejection Flag"
      expr: fraud_rejection_flag
    - name: "Impression Timestamp"
      expr: impression_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Attribution Record"
      expr: COUNT(DISTINCT attribution_record_id)
    - name: "Total Cpi Usd"
      expr: SUM(cpi_usd)
    - name: "Average Cpi Usd"
      expr: AVG(cpi_usd)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`marketing_audience`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audience business metrics"
  source: "`gaming_ecm`.`marketing`.`audience`"
  dimensions:
    - name: "Activation Date"
      expr: activation_date
    - name: "Att Opt In Requirement"
      expr: att_opt_in_requirement
    - name: "Audience Code"
      expr: audience_code
    - name: "Audience Name"
      expr: audience_name
    - name: "Audience Status"
      expr: audience_status
    - name: "Audience Type"
      expr: audience_type
    - name: "Coppa Exclusion Flag"
      expr: coppa_exclusion_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Retention Days"
      expr: data_retention_days
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Gdpr Lawful Basis"
      expr: gdpr_lawful_basis
    - name: "Geo Target Countries"
      expr: geo_target_countries
    - name: "Hashing Algorithm"
      expr: hashing_algorithm
    - name: "Identifier Type"
      expr: identifier_type
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Sync Timestamp"
      expr: last_sync_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Audience"
      expr: COUNT(DISTINCT audience_id)
    - name: "Total Average D7 Retention Rate"
      expr: SUM(average_d7_retention_rate)
    - name: "Average Average D7 Retention Rate"
      expr: AVG(average_d7_retention_rate)
    - name: "Total Average Ltv Usd"
      expr: SUM(average_ltv_usd)
    - name: "Average Average Ltv Usd"
      expr: AVG(average_ltv_usd)
    - name: "Total Estimated Reach"
      expr: SUM(estimated_reach)
    - name: "Average Estimated Reach"
      expr: AVG(estimated_reach)
    - name: "Total Lookalike Expansion Percentage"
      expr: SUM(lookalike_expansion_percentage)
    - name: "Average Lookalike Expansion Percentage"
      expr: AVG(lookalike_expansion_percentage)
    - name: "Total Lookalike Seed Size"
      expr: SUM(lookalike_seed_size)
    - name: "Average Lookalike Seed Size"
      expr: AVG(lookalike_seed_size)
    - name: "Total Match Rate Percentage"
      expr: SUM(match_rate_percentage)
    - name: "Average Match Rate Percentage"
      expr: AVG(match_rate_percentage)
    - name: "Total Matched Count"
      expr: SUM(matched_count)
    - name: "Average Matched Count"
      expr: AVG(matched_count)
    - name: "Total Size"
      expr: SUM(size)
    - name: "Average Size"
      expr: AVG(size)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`marketing_campaign_exposure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign Exposure business metrics"
  source: "`gaming_ecm`.`marketing`.`campaign_exposure`"
  dimensions:
    - name: "Attributed Flag"
      expr: attributed_flag
    - name: "Click Timestamp"
      expr: click_timestamp
    - name: "Conversion Timestamp"
      expr: conversion_timestamp
    - name: "Device Type"
      expr: device_type
    - name: "Exposure Channel"
      expr: exposure_channel
    - name: "Exposure Count"
      expr: exposure_count
    - name: "Exposure Timestamp"
      expr: exposure_timestamp
    - name: "Geo Country Code"
      expr: geo_country_code
    - name: "Click Timestamp Month"
      expr: DATE_TRUNC('MONTH', click_timestamp)
    - name: "Conversion Timestamp Month"
      expr: DATE_TRUNC('MONTH', conversion_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Campaign Exposure"
      expr: COUNT(DISTINCT campaign_exposure_id)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`marketing_campaign_promo_distribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign Promo Distribution business metrics"
  source: "`gaming_ecm`.`marketing`.`campaign_promo_distribution`"
  dimensions:
    - name: "Activation Date"
      expr: activation_date
    - name: "Actual Distribution Timestamp"
      expr: actual_distribution_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Distribution Channel"
      expr: distribution_channel
    - name: "Distribution Status"
      expr: distribution_status
    - name: "Performance Tier"
      expr: performance_tier
    - name: "Redemption Cap"
      expr: redemption_cap
    - name: "Redemption Count From Campaign"
      expr: redemption_count_from_campaign
    - name: "Activation Date Month"
      expr: DATE_TRUNC('MONTH', activation_date)
    - name: "Actual Distribution Timestamp Month"
      expr: DATE_TRUNC('MONTH', actual_distribution_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Campaign Promo Distribution"
      expr: COUNT(DISTINCT campaign_promo_distribution_id)
    - name: "Total Total Discount Attributed Usd"
      expr: SUM(total_discount_attributed_usd)
    - name: "Average Total Discount Attributed Usd"
      expr: AVG(total_discount_attributed_usd)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`marketing_campaign_spend`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign Spend business metrics"
  source: "`gaming_ecm`.`marketing`.`campaign_spend`"
  dimensions:
    - name: "Attribution Window Days"
      expr: attribution_window_days
    - name: "Channel"
      expr: channel
    - name: "Cohort Date"
      expr: cohort_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Source"
      expr: data_source
    - name: "Geo Country Code"
      expr: geo_country_code
    - name: "Is Organic"
      expr: is_organic
    - name: "Launch Phase"
      expr: launch_phase
    - name: "Notes"
      expr: notes
    - name: "Platform"
      expr: platform
    - name: "Reconciliation Status"
      expr: reconciliation_status
    - name: "Spend Date"
      expr: spend_date
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Cohort Date Month"
      expr: DATE_TRUNC('MONTH', cohort_date)
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Campaign Spend"
      expr: COUNT(DISTINCT campaign_spend_id)
    - name: "Total Clicks"
      expr: SUM(clicks)
    - name: "Average Clicks"
      expr: AVG(clicks)
    - name: "Total Conversion Rate"
      expr: SUM(conversion_rate)
    - name: "Average Conversion Rate"
      expr: AVG(conversion_rate)
    - name: "Total Cpc"
      expr: SUM(cpc)
    - name: "Average Cpc"
      expr: AVG(cpc)
    - name: "Total Cpi"
      expr: SUM(cpi)
    - name: "Average Cpi"
      expr: AVG(cpi)
    - name: "Total Cpm"
      expr: SUM(cpm)
    - name: "Average Cpm"
      expr: AVG(cpm)
    - name: "Total Ctr"
      expr: SUM(ctr)
    - name: "Average Ctr"
      expr: AVG(ctr)
    - name: "Total Discrepancy Amount"
      expr: SUM(discrepancy_amount)
    - name: "Average Discrepancy Amount"
      expr: AVG(discrepancy_amount)
    - name: "Total Impressions"
      expr: SUM(impressions)
    - name: "Average Impressions"
      expr: AVG(impressions)
    - name: "Total Installs"
      expr: SUM(installs)
    - name: "Average Installs"
      expr: AVG(installs)
    - name: "Total Spend Amount"
      expr: SUM(spend_amount)
    - name: "Average Spend Amount"
      expr: AVG(spend_amount)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`marketing_consent_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent Record business metrics"
  source: "`gaming_ecm`.`marketing`.`consent_record`"
  dimensions:
    - name: "Age Verified Flag"
      expr: age_verified_flag
    - name: "Attribution Source"
      expr: attribution_source
    - name: "Consent Collection Context"
      expr: consent_collection_context
    - name: "Consent Granularity Level"
      expr: consent_granularity_level
    - name: "Consent Language"
      expr: consent_language
    - name: "Consent Method"
      expr: consent_method
    - name: "Consent Proof Document Url"
      expr: consent_proof_document_url
    - name: "Consent Renewal Required Flag"
      expr: consent_renewal_required_flag
    - name: "Consent Scope"
      expr: consent_scope
    - name: "Consent Source"
      expr: consent_source
    - name: "Consent Status"
      expr: consent_status
    - name: "Consent Text Snapshot"
      expr: consent_text_snapshot
    - name: "Consent Timestamp"
      expr: consent_timestamp
    - name: "Consent Type"
      expr: consent_type
    - name: "Consent Version"
      expr: consent_version
    - name: "Data Retention Period Days"
      expr: data_retention_period_days
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Consent Record"
      expr: COUNT(DISTINCT consent_record_id)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`marketing_creative_test_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Creative Test Assignment business metrics"
  source: "`gaming_ecm`.`marketing`.`creative_test_assignment`"
  dimensions:
    - name: "Ab Test Variant"
      expr: ab_test_variant
    - name: "Assigned By"
      expr: assigned_by
    - name: "Assignment Date"
      expr: assignment_date
    - name: "Assignment Status"
      expr: assignment_status
    - name: "Is Ab Test Control"
      expr: is_ab_test_control
    - name: "Performance Tier"
      expr: performance_tier
    - name: "Test End Date"
      expr: test_end_date
    - name: "Test Start Date"
      expr: test_start_date
    - name: "Variant Label"
      expr: variant_label
    - name: "Assignment Date Month"
      expr: DATE_TRUNC('MONTH', assignment_date)
    - name: "Test End Date Month"
      expr: DATE_TRUNC('MONTH', test_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Creative Test Assignment"
      expr: COUNT(DISTINCT creative_test_assignment_id)
    - name: "Total Impressions Allocated"
      expr: SUM(impressions_allocated)
    - name: "Average Impressions Allocated"
      expr: AVG(impressions_allocated)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`marketing_crm_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crm Campaign business metrics"
  source: "`gaming_ecm`.`marketing`.`crm_campaign`"
  dimensions:
    - name: "Ab Test Enabled"
      expr: ab_test_enabled
    - name: "Ab Test Variant Count"
      expr: ab_test_variant_count
    - name: "Actual Send Timestamp"
      expr: actual_send_timestamp
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Campaign Code"
      expr: campaign_code
    - name: "Campaign Name"
      expr: campaign_name
    - name: "Campaign Objective"
      expr: campaign_objective
    - name: "Campaign Status"
      expr: campaign_status
    - name: "Campaign Type"
      expr: campaign_type
    - name: "Communication Channel"
      expr: communication_channel
    - name: "Completed Timestamp"
      expr: completed_timestamp
    - name: "Coppa Age Gate Required"
      expr: coppa_age_gate_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Expected Send Volume"
      expr: expected_send_volume
    - name: "Frequency Cap Enabled"
      expr: frequency_cap_enabled
    - name: "Frequency Cap Limit"
      expr: frequency_cap_limit
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Crm Campaign"
      expr: COUNT(DISTINCT crm_campaign_id)
    - name: "Total Ab Test Split Percentage"
      expr: SUM(ab_test_split_percentage)
    - name: "Average Ab Test Split Percentage"
      expr: AVG(ab_test_split_percentage)
    - name: "Total Campaign Budget Usd"
      expr: SUM(campaign_budget_usd)
    - name: "Average Campaign Budget Usd"
      expr: AVG(campaign_budget_usd)
    - name: "Total Incentive Value"
      expr: SUM(incentive_value)
    - name: "Average Incentive Value"
      expr: AVG(incentive_value)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`marketing_influencer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Influencer business metrics"
  source: "`gaming_ecm`.`marketing`.`influencer`"
  dimensions:
    - name: "Affiliate Code"
      expr: affiliate_code
    - name: "Affiliate Program Enrolled"
      expr: affiliate_program_enrolled
    - name: "Audience Age Group"
      expr: audience_age_group
    - name: "Audience Gender Split"
      expr: audience_gender_split
    - name: "Content Category"
      expr: content_category
    - name: "Content Rating Suitability"
      expr: content_rating_suitability
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Contract Status"
      expr: contract_status
    - name: "Coppa Compliance Flag"
      expr: coppa_compliance_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Exclusivity Flag"
      expr: exclusivity_flag
    - name: "Follower Count Tier"
      expr: follower_count_tier
    - name: "Handle"
      expr: handle
    - name: "Language"
      expr: language
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Influencer"
      expr: COUNT(DISTINCT influencer_id)
    - name: "Total Average Views Per Post"
      expr: SUM(average_views_per_post)
    - name: "Average Average Views Per Post"
      expr: AVG(average_views_per_post)
    - name: "Total Cpi Benchmark"
      expr: SUM(cpi_benchmark)
    - name: "Average Cpi Benchmark"
      expr: AVG(cpi_benchmark)
    - name: "Total Engagement Rate"
      expr: SUM(engagement_rate)
    - name: "Average Engagement Rate"
      expr: AVG(engagement_rate)
    - name: "Total Follower Count"
      expr: SUM(follower_count)
    - name: "Average Follower Count"
      expr: AVG(follower_count)
    - name: "Total Rate Card Amount"
      expr: SUM(rate_card_amount)
    - name: "Average Rate Card Amount"
      expr: AVG(rate_card_amount)
    - name: "Total Roas Benchmark"
      expr: SUM(roas_benchmark)
    - name: "Average Roas Benchmark"
      expr: AVG(roas_benchmark)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`marketing_influencer_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Influencer Campaign business metrics"
  source: "`gaming_ecm`.`marketing`.`influencer_campaign`"
  dimensions:
    - name: "Activation Type"
      expr: activation_type
    - name: "Agreed Deliverables"
      expr: agreed_deliverables
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Compensation Model"
      expr: compensation_model
    - name: "Content Go Live Date"
      expr: content_go_live_date
    - name: "Content Platform"
      expr: content_platform
    - name: "Content Url"
      expr: content_url
    - name: "Contract Date"
      expr: contract_date
    - name: "Cookie Window Days"
      expr: cookie_window_days
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Engagement End Date"
      expr: engagement_end_date
    - name: "Engagement Start Date"
      expr: engagement_start_date
    - name: "Engagement Status"
      expr: engagement_status
    - name: "Exclusivity Flag"
      expr: exclusivity_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Influencer Campaign"
      expr: COUNT(DISTINCT influencer_campaign_id)
    - name: "Total Attributed Installs"
      expr: SUM(attributed_installs)
    - name: "Average Attributed Installs"
      expr: AVG(attributed_installs)
    - name: "Total Attributed Revenue"
      expr: SUM(attributed_revenue)
    - name: "Average Attributed Revenue"
      expr: AVG(attributed_revenue)
    - name: "Total Contracted Fee Amount"
      expr: SUM(contracted_fee_amount)
    - name: "Average Contracted Fee Amount"
      expr: AVG(contracted_fee_amount)
    - name: "Total Cpa Rate"
      expr: SUM(cpa_rate)
    - name: "Average Cpa Rate"
      expr: AVG(cpa_rate)
    - name: "Total Cpi Rate"
      expr: SUM(cpi_rate)
    - name: "Average Cpi Rate"
      expr: AVG(cpi_rate)
    - name: "Total Ctr"
      expr: SUM(ctr)
    - name: "Average Ctr"
      expr: AVG(ctr)
    - name: "Total Engagement Count"
      expr: SUM(engagement_count)
    - name: "Average Engagement Count"
      expr: AVG(engagement_count)
    - name: "Total Performance Vs Target Percentage"
      expr: SUM(performance_vs_target_percentage)
    - name: "Average Performance Vs Target Percentage"
      expr: AVG(performance_vs_target_percentage)
    - name: "Total Revenue Share Percentage"
      expr: SUM(revenue_share_percentage)
    - name: "Average Revenue Share Percentage"
      expr: AVG(revenue_share_percentage)
    - name: "Total Target Engagement Count"
      expr: SUM(target_engagement_count)
    - name: "Average Target Engagement Count"
      expr: AVG(target_engagement_count)
    - name: "Total Target Installs"
      expr: SUM(target_installs)
    - name: "Average Target Installs"
      expr: AVG(target_installs)
    - name: "Total Target Views"
      expr: SUM(target_views)
    - name: "Average Target Views"
      expr: AVG(target_views)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`marketing_launch_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Launch Event business metrics"
  source: "`gaming_ecm`.`marketing`.`launch_event`"
  dimensions:
    - name: "Actual Launch Date"
      expr: actual_launch_date
    - name: "Coppa Compliance Verified Flag"
      expr: coppa_compliance_verified_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Esrb Rating"
      expr: esrb_rating
    - name: "Gdpr Compliance Verified Flag"
      expr: gdpr_compliance_verified_flag
    - name: "Influencer Embargo Lift Timestamp"
      expr: influencer_embargo_lift_timestamp
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Launch Campaign Ids"
      expr: launch_campaign_ids
    - name: "Launch Event Code"
      expr: launch_event_code
    - name: "Launch Status"
      expr: launch_status
    - name: "Launch Type"
      expr: launch_type
    - name: "Pegi Rating"
      expr: pegi_rating
    - name: "Platform Certification Status"
      expr: platform_certification_status
    - name: "Post Launch Review Status"
      expr: post_launch_review_status
    - name: "Post Launch Review Summary"
      expr: post_launch_review_summary
    - name: "Press Embargo Lift Timestamp"
      expr: press_embargo_lift_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Launch Event"
      expr: COUNT(DISTINCT launch_event_id)
    - name: "Total Actual Spend Usd"
      expr: SUM(actual_spend_usd)
    - name: "Average Actual Spend Usd"
      expr: AVG(actual_spend_usd)
    - name: "Total Aso Optimization Score"
      expr: SUM(aso_optimization_score)
    - name: "Average Aso Optimization Score"
      expr: AVG(aso_optimization_score)
    - name: "Total Average Cpi Usd"
      expr: SUM(average_cpi_usd)
    - name: "Average Average Cpi Usd"
      expr: AVG(average_cpi_usd)
    - name: "Total Average Ctr Pct"
      expr: SUM(average_ctr_pct)
    - name: "Average Average Ctr Pct"
      expr: AVG(average_ctr_pct)
    - name: "Total Day One Actual Installs"
      expr: SUM(day_one_actual_installs)
    - name: "Average Day One Actual Installs"
      expr: AVG(day_one_actual_installs)
    - name: "Total Day One Install Target"
      expr: SUM(day_one_install_target)
    - name: "Average Day One Install Target"
      expr: AVG(day_one_install_target)
    - name: "Total Day Seven Actual Retention Pct"
      expr: SUM(day_seven_actual_retention_pct)
    - name: "Average Day Seven Actual Retention Pct"
      expr: AVG(day_seven_actual_retention_pct)
    - name: "Total Day Seven Retention Target Pct"
      expr: SUM(day_seven_retention_target_pct)
    - name: "Average Day Seven Retention Target Pct"
      expr: AVG(day_seven_retention_target_pct)
    - name: "Total Launch Budget Usd"
      expr: SUM(launch_budget_usd)
    - name: "Average Launch Budget Usd"
      expr: AVG(launch_budget_usd)
    - name: "Total Pre Registration Count"
      expr: SUM(pre_registration_count)
    - name: "Average Pre Registration Count"
      expr: AVG(pre_registration_count)
    - name: "Total Projected D30 Ltv Usd"
      expr: SUM(projected_d30_ltv_usd)
    - name: "Average Projected D30 Ltv Usd"
      expr: AVG(projected_d30_ltv_usd)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`marketing_marketing_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing Budget business metrics"
  source: "`gaming_ecm`.`marketing`.`marketing_budget`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Budget Code"
      expr: budget_code
    - name: "Budget Name"
      expr: budget_name
    - name: "Budget Status"
      expr: budget_status
    - name: "Budget Type"
      expr: budget_type
    - name: "Channel"
      expr: channel
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Fiscal Quarter"
      expr: fiscal_quarter
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Geo Region"
      expr: geo_region
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Revision Date"
      expr: last_revision_date
    - name: "Launch Type"
      expr: launch_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Marketing Budget"
      expr: COUNT(DISTINCT marketing_budget_id)
    - name: "Total Actual Spend Amount"
      expr: SUM(actual_spend_amount)
    - name: "Average Actual Spend Amount"
      expr: AVG(actual_spend_amount)
    - name: "Total Committed Amount"
      expr: SUM(committed_amount)
    - name: "Average Committed Amount"
      expr: AVG(committed_amount)
    - name: "Total Remaining Budget Amount"
      expr: SUM(remaining_budget_amount)
    - name: "Average Remaining Budget Amount"
      expr: AVG(remaining_budget_amount)
    - name: "Total Target Cpi"
      expr: SUM(target_cpi)
    - name: "Average Target Cpi"
      expr: AVG(target_cpi)
    - name: "Total Target D7 Retention Rate"
      expr: SUM(target_d7_retention_rate)
    - name: "Average Target D7 Retention Rate"
      expr: AVG(target_d7_retention_rate)
    - name: "Total Target Roas"
      expr: SUM(target_roas)
    - name: "Average Target Roas"
      expr: AVG(target_roas)
    - name: "Total Total Approved Budget Amount"
      expr: SUM(total_approved_budget_amount)
    - name: "Average Total Approved Budget Amount"
      expr: AVG(total_approved_budget_amount)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`marketing_marketing_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing Campaign business metrics"
  source: "`gaming_ecm`.`marketing`.`marketing_campaign`"
  dimensions:
    - name: "Adjust Campaign Token"
      expr: adjust_campaign_token
    - name: "Appsflyer Campaign Reference"
      expr: appsflyer_campaign_reference
    - name: "Aso Optimized"
      expr: aso_optimized
    - name: "Attribution Link"
      expr: attribution_link
    - name: "Attribution Partner"
      expr: attribution_partner
    - name: "Budget Currency Code"
      expr: budget_currency_code
    - name: "Campaign Code"
      expr: campaign_code
    - name: "Campaign Name"
      expr: campaign_name
    - name: "Campaign Status"
      expr: campaign_status
    - name: "Campaign Type"
      expr: campaign_type
    - name: "Channel Name"
      expr: channel_name
    - name: "Channel Subtype"
      expr: channel_subtype
    - name: "Channel Type"
      expr: channel_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Creative Theme"
      expr: creative_theme
    - name: "End Date"
      expr: end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Marketing Campaign"
      expr: COUNT(DISTINCT marketing_campaign_id)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total Target Cpi"
      expr: SUM(target_cpi)
    - name: "Average Target Cpi"
      expr: AVG(target_cpi)
    - name: "Total Target Roas"
      expr: SUM(target_roas)
    - name: "Average Target Roas"
      expr: AVG(target_roas)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`marketing_message_template`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Message Template business metrics"
  source: "`gaming_ecm`.`marketing`.`message_template`"
  dimensions:
    - name: "Ab Test Variant"
      expr: ab_test_variant
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Body Content"
      expr: body_content
    - name: "Call To Action Text"
      expr: call_to_action_text
    - name: "Call To Action Url"
      expr: call_to_action_url
    - name: "Campaign Type"
      expr: campaign_type
    - name: "Compliance Review Date"
      expr: compliance_review_date
    - name: "Compliance Reviewed"
      expr: compliance_reviewed
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Frequency Cap Hours"
      expr: frequency_cap_hours
    - name: "Language Code"
      expr: language_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lifecycle Stage"
      expr: lifecycle_stage
    - name: "Localization Key"
      expr: localization_key
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Message Template"
      expr: COUNT(DISTINCT message_template_id)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`marketing_player_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Player Segment business metrics"
  source: "`gaming_ecm`.`marketing`.`player_segment`"
  dimensions:
    - name: "Activated Timestamp"
      expr: activated_timestamp
    - name: "Activation Channels"
      expr: activation_channels
    - name: "Att Opt In Requirement"
      expr: att_opt_in_requirement
    - name: "Coppa Exclusion Flag"
      expr: coppa_exclusion_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source"
      expr: data_source
    - name: "Definition Criteria"
      expr: definition_criteria
    - name: "Definition Type"
      expr: definition_type
    - name: "Deprecated Timestamp"
      expr: deprecated_timestamp
    - name: "Game Title Scope"
      expr: game_title_scope
    - name: "Gdpr Lawful Basis"
      expr: gdpr_lawful_basis
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Last Refresh Date"
      expr: last_refresh_date
    - name: "Lookalike Seed Eligible"
      expr: lookalike_seed_eligible
    - name: "Ltv Tier"
      expr: ltv_tier
    - name: "Ml Model Reference"
      expr: ml_model_reference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Player Segment"
      expr: COUNT(DISTINCT player_segment_id)
    - name: "Total Actual Segment Size"
      expr: SUM(actual_segment_size)
    - name: "Average Actual Segment Size"
      expr: AVG(actual_segment_size)
    - name: "Total Average Arppu"
      expr: SUM(average_arppu)
    - name: "Average Average Arppu"
      expr: AVG(average_arppu)
    - name: "Total Average Arpu"
      expr: SUM(average_arpu)
    - name: "Average Average Arpu"
      expr: AVG(average_arpu)
    - name: "Total Average Session Length Minutes"
      expr: SUM(average_session_length_minutes)
    - name: "Average Average Session Length Minutes"
      expr: AVG(average_session_length_minutes)
    - name: "Total Churn Risk Score"
      expr: SUM(churn_risk_score)
    - name: "Average Churn Risk Score"
      expr: AVG(churn_risk_score)
    - name: "Total Conversion Rate"
      expr: SUM(conversion_rate)
    - name: "Average Conversion Rate"
      expr: AVG(conversion_rate)
    - name: "Total D1 Retention Rate"
      expr: SUM(d1_retention_rate)
    - name: "Average D1 Retention Rate"
      expr: AVG(d1_retention_rate)
    - name: "Total D30 Retention Rate"
      expr: SUM(d30_retention_rate)
    - name: "Average D30 Retention Rate"
      expr: AVG(d30_retention_rate)
    - name: "Total D7 Retention Rate"
      expr: SUM(d7_retention_rate)
    - name: "Average D7 Retention Rate"
      expr: AVG(d7_retention_rate)
    - name: "Total Estimated Segment Size"
      expr: SUM(estimated_segment_size)
    - name: "Average Estimated Segment Size"
      expr: AVG(estimated_segment_size)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`marketing_retention_cohort`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retention Cohort business metrics"
  source: "`gaming_ecm`.`marketing`.`retention_cohort`"
  dimensions:
    - name: "Attribution Channel"
      expr: attribution_channel
    - name: "Attribution Partner"
      expr: attribution_partner
    - name: "Attribution Source"
      expr: attribution_source
    - name: "Cohort Name"
      expr: cohort_name
    - name: "Cohort Segment"
      expr: cohort_segment
    - name: "Cohort Status"
      expr: cohort_status
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Install Date"
      expr: install_date
    - name: "Is Soft Launch"
      expr: is_soft_launch
    - name: "Measurement Window Days"
      expr: measurement_window_days
    - name: "Notes"
      expr: notes
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Install Date Month"
      expr: DATE_TRUNC('MONTH', install_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Retention Cohort"
      expr: COUNT(DISTINCT retention_cohort_id)
    - name: "Total Acquisition Cost"
      expr: SUM(acquisition_cost)
    - name: "Average Acquisition Cost"
      expr: AVG(acquisition_cost)
    - name: "Total Cohort Arppu"
      expr: SUM(cohort_arppu)
    - name: "Average Cohort Arppu"
      expr: AVG(cohort_arppu)
    - name: "Total Cohort Arpu"
      expr: SUM(cohort_arpu)
    - name: "Average Cohort Arpu"
      expr: AVG(cohort_arpu)
    - name: "Total Cohort Ltv Estimate"
      expr: SUM(cohort_ltv_estimate)
    - name: "Average Cohort Ltv Estimate"
      expr: AVG(cohort_ltv_estimate)
    - name: "Total Cohort Size"
      expr: SUM(cohort_size)
    - name: "Average Cohort Size"
      expr: AVG(cohort_size)
    - name: "Total Conversion To Payer Rate"
      expr: SUM(conversion_to_payer_rate)
    - name: "Average Conversion To Payer Rate"
      expr: AVG(conversion_to_payer_rate)
    - name: "Total Cpi"
      expr: SUM(cpi)
    - name: "Average Cpi"
      expr: AVG(cpi)
    - name: "Total D1 Retained Players"
      expr: SUM(d1_retained_players)
    - name: "Average D1 Retained Players"
      expr: AVG(d1_retained_players)
    - name: "Total D1 Retention Rate"
      expr: SUM(d1_retention_rate)
    - name: "Average D1 Retention Rate"
      expr: AVG(d1_retention_rate)
    - name: "Total D30 Retained Players"
      expr: SUM(d30_retained_players)
    - name: "Average D30 Retained Players"
      expr: AVG(d30_retained_players)
    - name: "Total D30 Retention Rate"
      expr: SUM(d30_retention_rate)
    - name: "Average D30 Retention Rate"
      expr: AVG(d30_retention_rate)
    - name: "Total D60 Retained Players"
      expr: SUM(d60_retained_players)
    - name: "Average D60 Retained Players"
      expr: AVG(d60_retained_players)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`marketing_suppression_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Suppression List business metrics"
  source: "`gaming_ecm`.`marketing`.`suppression_list`"
  dimensions:
    - name: "Advertising Identifier"
      expr: advertising_identifier
    - name: "Channel"
      expr: channel
    - name: "Consent Withdrawn Timestamp"
      expr: consent_withdrawn_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Email Address"
      expr: email_address
    - name: "Geographic Region"
      expr: geographic_region
    - name: "Is Active"
      expr: is_active
    - name: "Is Permanent"
      expr: is_permanent
    - name: "Last Contact Attempt Timestamp"
      expr: last_contact_attempt_timestamp
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Legal Basis"
      expr: legal_basis
    - name: "List Code"
      expr: list_code
    - name: "List Name"
      expr: list_name
    - name: "List Type"
      expr: list_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Suppression List"
      expr: COUNT(DISTINCT suppression_list_id)
$$;