-- Metric views for domain: audience | Business: Advertising | Version: 1 | Generated on: 2026-05-08 02:25:55

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`audience_activation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Activation business metrics"
  source: "`advertising_ecm`.`audience`.`activation`"
  dimensions:
    - name: "Activation Date"
      expr: activation_date
    - name: "Activation Method"
      expr: activation_method
    - name: "Activation Name"
      expr: activation_name
    - name: "Activation Status"
      expr: activation_status
    - name: "Activation Timestamp"
      expr: activation_timestamp
    - name: "Activation Type"
      expr: activation_type
    - name: "Consent Framework"
      expr: consent_framework
    - name: "Consent Status"
      expr: consent_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Source Type"
      expr: data_source_type
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Error Message"
      expr: error_message
    - name: "Frequency Cap"
      expr: frequency_cap
    - name: "Frequency Cap Window Hours"
      expr: frequency_cap_window_hours
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Activation"
      expr: COUNT(DISTINCT activation_id)
    - name: "Total Bid Modifier"
      expr: SUM(bid_modifier)
    - name: "Average Bid Modifier"
      expr: AVG(bid_modifier)
    - name: "Total Cost Cpm"
      expr: SUM(cost_cpm)
    - name: "Average Cost Cpm"
      expr: AVG(cost_cpm)
    - name: "Total Estimated Reach"
      expr: SUM(estimated_reach)
    - name: "Average Estimated Reach"
      expr: AVG(estimated_reach)
    - name: "Total Match Rate Percentage"
      expr: SUM(match_rate_percentage)
    - name: "Average Match Rate Percentage"
      expr: AVG(match_rate_percentage)
    - name: "Total Matched User Count"
      expr: SUM(matched_user_count)
    - name: "Average Matched User Count"
      expr: AVG(matched_user_count)
    - name: "Total Unmatched User Count"
      expr: SUM(unmatched_user_count)
    - name: "Average Unmatched User Count"
      expr: AVG(unmatched_user_count)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`audience_audience_consent_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audience Consent Record business metrics"
  source: "`advertising_ecm`.`audience`.`audience_consent_record`"
  dimensions:
    - name: "Audience Identifier"
      expr: audience_identifier
    - name: "Cdp Profile Sync Enabled"
      expr: cdp_profile_sync_enabled
    - name: "Consent Channel"
      expr: consent_channel
    - name: "Consent Expiry Date"
      expr: consent_expiry_date
    - name: "Consent Language"
      expr: consent_language
    - name: "Consent Method"
      expr: consent_method
    - name: "Consent Notice Url"
      expr: consent_notice_url
    - name: "Consent Notice Version"
      expr: consent_notice_version
    - name: "Consent Proof Document Url"
      expr: consent_proof_document_url
    - name: "Consent Scope Analytics"
      expr: consent_scope_analytics
    - name: "Consent Scope Data Sharing"
      expr: consent_scope_data_sharing
    - name: "Consent Scope Personalization"
      expr: consent_scope_personalization
    - name: "Consent Scope Targeting"
      expr: consent_scope_targeting
    - name: "Consent Source"
      expr: consent_source
    - name: "Consent Source System"
      expr: consent_source_system
    - name: "Consent Status"
      expr: consent_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Audience Consent Record"
      expr: COUNT(DISTINCT audience_consent_record_id)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`audience_audience_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audience Segment business metrics"
  source: "`advertising_ecm`.`audience`.`audience_segment`"
  dimensions:
    - name: "Activation Status"
      expr: activation_status
    - name: "Age Band Max"
      expr: age_band_max
    - name: "Age Band Min"
      expr: age_band_min
    - name: "App Usage Flag"
      expr: app_usage_flag
    - name: "Audience Segment Description"
      expr: audience_segment_description
    - name: "Audience Segment Name"
      expr: audience_segment_name
    - name: "Audience Segment Status"
      expr: audience_segment_status
    - name: "Audience Segment Type"
      expr: audience_segment_type
    - name: "Brand Affinity List"
      expr: brand_affinity_list
    - name: "Browsing Categories"
      expr: browsing_categories
    - name: "Ccpa Compliant Flag"
      expr: ccpa_compliant_flag
    - name: "Consent Status"
      expr: consent_status
    - name: "Content Consumption Topics"
      expr: content_consumption_topics
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Creation Method"
      expr: creation_method
    - name: "Cross Device Flag"
      expr: cross_device_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Audience Segment"
      expr: COUNT(DISTINCT audience_segment_id)
    - name: "Total Size"
      expr: SUM(size)
    - name: "Average Size"
      expr: AVG(size)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`audience_behavioral_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Behavioral Profile business metrics"
  source: "`advertising_ecm`.`audience`.`behavioral_profile`"
  dimensions:
    - name: "App Usage Pattern"
      expr: app_usage_pattern
    - name: "Brand Affinity Category"
      expr: brand_affinity_category
    - name: "Browsing Category Primary"
      expr: browsing_category_primary
    - name: "Browsing Category Secondary"
      expr: browsing_category_secondary
    - name: "Consent Status"
      expr: consent_status
    - name: "Consent Timestamp"
      expr: consent_timestamp
    - name: "Content Consumption Category"
      expr: content_consumption_category
    - name: "Cross Device Activity Flag"
      expr: cross_device_activity_flag
    - name: "Data Retention Expiry Date"
      expr: data_retention_expiry_date
    - name: "Data Source Description"
      expr: data_source_description
    - name: "Day Of Week Preference"
      expr: day_of_week_preference
    - name: "Device Type Primary"
      expr: device_type_primary
    - name: "Engagement Level"
      expr: engagement_level
    - name: "Frequency Score"
      expr: frequency_score
    - name: "Geographic Behavior Pattern"
      expr: geographic_behavior_pattern
    - name: "Last Observed Behavior Date"
      expr: last_observed_behavior_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Behavioral Profile"
      expr: COUNT(DISTINCT behavioral_profile_id)
    - name: "Total Lookalike Similarity Score"
      expr: SUM(lookalike_similarity_score)
    - name: "Average Lookalike Similarity Score"
      expr: AVG(lookalike_similarity_score)
    - name: "Total Profile Quality Score"
      expr: SUM(profile_quality_score)
    - name: "Average Profile Quality Score"
      expr: AVG(profile_quality_score)
    - name: "Total Profile Reach Estimate"
      expr: SUM(profile_reach_estimate)
    - name: "Average Profile Reach Estimate"
      expr: AVG(profile_reach_estimate)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`audience_clean_room`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clean Room business metrics"
  source: "`advertising_ecm`.`audience`.`clean_room`"
  dimensions:
    - name: "Activation Permissions"
      expr: activation_permissions
    - name: "Api Endpoint Url"
      expr: api_endpoint_url
    - name: "Authentication Method"
      expr: authentication_method
    - name: "Ccpa Compliant Flag"
      expr: ccpa_compliant_flag
    - name: "Collaboration Code"
      expr: collaboration_code
    - name: "Collaboration End Date"
      expr: collaboration_end_date
    - name: "Collaboration Name"
      expr: collaboration_name
    - name: "Collaboration Start Date"
      expr: collaboration_start_date
    - name: "Collaboration Status"
      expr: collaboration_status
    - name: "Collaboration Type"
      expr: collaboration_type
    - name: "Consent Framework Compliance"
      expr: consent_framework_compliance
    - name: "Cost Model"
      expr: cost_model
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Governance Rules"
      expr: data_governance_rules
    - name: "Data Retention Days"
      expr: data_retention_days
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Clean Room"
      expr: COUNT(DISTINCT clean_room_id)
    - name: "Total Collaboration Cost Amount"
      expr: SUM(collaboration_cost_amount)
    - name: "Average Collaboration Cost Amount"
      expr: AVG(collaboration_cost_amount)
    - name: "Total Data Volume Mb"
      expr: SUM(data_volume_mb)
    - name: "Average Data Volume Mb"
      expr: AVG(data_volume_mb)
    - name: "Total Match Rate Percentage"
      expr: SUM(match_rate_percentage)
    - name: "Average Match Rate Percentage"
      expr: AVG(match_rate_percentage)
    - name: "Total Matched Audience Count"
      expr: SUM(matched_audience_count)
    - name: "Average Matched Audience Count"
      expr: AVG(matched_audience_count)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`audience_demographic_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demographic Profile business metrics"
  source: "`advertising_ecm`.`audience`.`demographic_profile`"
  dimensions:
    - name: "Age Band"
      expr: age_band
    - name: "Children Age Range"
      expr: children_age_range
    - name: "Consent Date"
      expr: consent_date
    - name: "Consent Expiration Date"
      expr: consent_expiration_date
    - name: "Consent Status"
      expr: consent_status
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dma Code"
      expr: dma_code
    - name: "Dma Name"
      expr: dma_name
    - name: "Education Level"
      expr: education_level
    - name: "Employment Category"
      expr: employment_category
    - name: "Ethnicity"
      expr: ethnicity
    - name: "Gender"
      expr: gender
    - name: "Geographic Region"
      expr: geographic_region
    - name: "Homeownership Status"
      expr: homeownership_status
    - name: "Household Income Tier"
      expr: household_income_tier
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Demographic Profile"
      expr: COUNT(DISTINCT demographic_profile_id)
    - name: "Total Estimated Population Size"
      expr: SUM(estimated_population_size)
    - name: "Average Estimated Population Size"
      expr: AVG(estimated_population_size)
    - name: "Total Profile Confidence Score"
      expr: SUM(profile_confidence_score)
    - name: "Average Profile Confidence Score"
      expr: AVG(profile_confidence_score)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`audience_dmp_integration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dmp Integration business metrics"
  source: "`advertising_ecm`.`audience`.`dmp_integration`"
  dimensions:
    - name: "Api Endpoint Url"
      expr: api_endpoint_url
    - name: "Api Version"
      expr: api_version
    - name: "Authentication Method"
      expr: authentication_method
    - name: "Consent Framework Compliance"
      expr: consent_framework_compliance
    - name: "Consent String Format"
      expr: consent_string_format
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credential Expiry Date"
      expr: credential_expiry_date
    - name: "Data Retention Days"
      expr: data_retention_days
    - name: "Dmp Integration Status"
      expr: dmp_integration_status
    - name: "Error Log Path"
      expr: error_log_path
    - name: "Integration Type"
      expr: integration_type
    - name: "Is Production"
      expr: is_production
    - name: "Last Sync Timestamp"
      expr: last_sync_timestamp
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Next Scheduled Sync Timestamp"
      expr: next_scheduled_sync_timestamp
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dmp Integration"
      expr: COUNT(DISTINCT dmp_integration_id)
    - name: "Total Cost Per Sync Usd"
      expr: SUM(cost_per_sync_usd)
    - name: "Average Cost Per Sync Usd"
      expr: AVG(cost_per_sync_usd)
    - name: "Total Data Volume Mb"
      expr: SUM(data_volume_mb)
    - name: "Average Data Volume Mb"
      expr: AVG(data_volume_mb)
    - name: "Total Monthly Cost Cap Usd"
      expr: SUM(monthly_cost_cap_usd)
    - name: "Average Monthly Cost Cap Usd"
      expr: AVG(monthly_cost_cap_usd)
    - name: "Total Records Failed Count"
      expr: SUM(records_failed_count)
    - name: "Average Records Failed Count"
      expr: AVG(records_failed_count)
    - name: "Total Records Synced Count"
      expr: SUM(records_synced_count)
    - name: "Average Records Synced Count"
      expr: AVG(records_synced_count)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`audience_holdout_group`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Holdout Group business metrics"
  source: "`advertising_ecm`.`audience`.`holdout_group`"
  dimensions:
    - name: "Activation Status"
      expr: activation_status
    - name: "Ccpa Compliant Flag"
      expr: ccpa_compliant_flag
    - name: "Consent Compliant Flag"
      expr: consent_compliant_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Retention Days"
      expr: data_retention_days
    - name: "Dsp Platform Name"
      expr: dsp_platform_name
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Gdpr Compliant Flag"
      expr: gdpr_compliant_flag
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Group Code"
      expr: group_code
    - name: "Group Name"
      expr: group_name
    - name: "Group Type"
      expr: group_type
    - name: "Holdout Group Description"
      expr: holdout_group_description
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Sync Timestamp"
      expr: last_sync_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Holdout Group"
      expr: COUNT(DISTINCT holdout_group_id)
    - name: "Total Confidence Level"
      expr: SUM(confidence_level)
    - name: "Average Confidence Level"
      expr: AVG(confidence_level)
    - name: "Total Estimated Reach"
      expr: SUM(estimated_reach)
    - name: "Average Estimated Reach"
      expr: AVG(estimated_reach)
    - name: "Total Group Size"
      expr: SUM(group_size)
    - name: "Average Group Size"
      expr: AVG(group_size)
    - name: "Total Match Rate Percentage"
      expr: SUM(match_rate_percentage)
    - name: "Average Match Rate Percentage"
      expr: AVG(match_rate_percentage)
    - name: "Total Minimum Detectable Effect"
      expr: SUM(minimum_detectable_effect)
    - name: "Average Minimum Detectable Effect"
      expr: AVG(minimum_detectable_effect)
    - name: "Total Split Percentage"
      expr: SUM(split_percentage)
    - name: "Average Split Percentage"
      expr: AVG(split_percentage)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`audience_identity_graph`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Identity Graph business metrics"
  source: "`advertising_ecm`.`audience`.`identity_graph`"
  dimensions:
    - name: "Browser"
      expr: browser
    - name: "Consent Status"
      expr: consent_status
    - name: "Consent Timestamp"
      expr: consent_timestamp
    - name: "Cookie Identifier"
      expr: cookie_identifier
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crm Identifier"
      expr: crm_identifier
    - name: "Ctv Device Identifier"
      expr: ctv_device_identifier
    - name: "Data Source"
      expr: data_source
    - name: "Device Type"
      expr: device_type
    - name: "First Seen Timestamp"
      expr: first_seen_timestamp
    - name: "Geographic Country Code"
      expr: geographic_country_code
    - name: "Geographic Dma Code"
      expr: geographic_dma_code
    - name: "Geographic Region"
      expr: geographic_region
    - name: "Hashed Email"
      expr: hashed_email
    - name: "Household Identifier"
      expr: household_identifier
    - name: "Identity Graph Status"
      expr: identity_graph_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Identity Graph"
      expr: COUNT(DISTINCT identity_graph_id)
    - name: "Total Match Confidence Score"
      expr: SUM(match_confidence_score)
    - name: "Average Match Confidence Score"
      expr: AVG(match_confidence_score)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`audience_lookalike_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lookalike Model business metrics"
  source: "`advertising_ecm`.`audience`.`lookalike_model`"
  dimensions:
    - name: "Algorithm Type"
      expr: algorithm_type
    - name: "Consent Compliant Flag"
      expr: consent_compliant_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Source Type"
      expr: data_source_type
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Feature Set"
      expr: feature_set
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Last Refresh Date"
      expr: last_refresh_date
    - name: "Model Description"
      expr: model_description
    - name: "Model Name"
      expr: model_name
    - name: "Model Status"
      expr: model_status
    - name: "Model Version"
      expr: model_version
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Next Refresh Date"
      expr: next_refresh_date
    - name: "Performance Metric Type"
      expr: performance_metric_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Lookalike Model"
      expr: COUNT(DISTINCT lookalike_model_id)
    - name: "Total Baseline Performance Value"
      expr: SUM(baseline_performance_value)
    - name: "Average Baseline Performance Value"
      expr: AVG(baseline_performance_value)
    - name: "Total Estimated Reach"
      expr: SUM(estimated_reach)
    - name: "Average Estimated Reach"
      expr: AVG(estimated_reach)
    - name: "Total Expansion Ratio"
      expr: SUM(expansion_ratio)
    - name: "Average Expansion Ratio"
      expr: AVG(expansion_ratio)
    - name: "Total Model Cost"
      expr: SUM(model_cost)
    - name: "Average Model Cost"
      expr: AVG(model_cost)
    - name: "Total Similarity Threshold"
      expr: SUM(similarity_threshold)
    - name: "Average Similarity Threshold"
      expr: AVG(similarity_threshold)
    - name: "Total Validation Accuracy"
      expr: SUM(validation_accuracy)
    - name: "Average Validation Accuracy"
      expr: AVG(validation_accuracy)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`audience_persona`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Persona business metrics"
  source: "`advertising_ecm`.`audience`.`persona`"
  dimensions:
    - name: "Ccpa Opt Out Eligible"
      expr: ccpa_opt_out_eligible
    - name: "Cdp Audience Key"
      expr: cdp_audience_key
    - name: "Consent Compliant Flag"
      expr: consent_compliant_flag
    - name: "Content Preferences"
      expr: content_preferences
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source Type"
      expr: data_source_type
    - name: "Dmp Segment Ids"
      expr: dmp_segment_ids
    - name: "Gdpr Lawful Basis"
      expr: gdpr_lawful_basis
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Last Validated Date"
      expr: last_validated_date
    - name: "Narrative Description"
      expr: narrative_description
    - name: "Owning Team"
      expr: owning_team
    - name: "Pain Points"
      expr: pain_points
    - name: "Persona Code"
      expr: persona_code
    - name: "Persona Name"
      expr: persona_name
    - name: "Persona Status"
      expr: persona_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Persona"
      expr: COUNT(DISTINCT persona_id)
    - name: "Total Cltv Estimate"
      expr: SUM(cltv_estimate)
    - name: "Average Cltv Estimate"
      expr: AVG(cltv_estimate)
    - name: "Total Conversion Propensity"
      expr: SUM(conversion_propensity)
    - name: "Average Conversion Propensity"
      expr: AVG(conversion_propensity)
    - name: "Total Estimated Reach"
      expr: SUM(estimated_reach)
    - name: "Average Estimated Reach"
      expr: AVG(estimated_reach)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`audience_pixel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pixel business metrics"
  source: "`advertising_ecm`.`audience`.`pixel`"
  dimensions:
    - name: "Activated Date"
      expr: activated_date
    - name: "Consent Category"
      expr: consent_category
    - name: "Consent Required"
      expr: consent_required
    - name: "Container Code"
      expr: container_code
    - name: "Container Tag Manager"
      expr: container_tag_manager
    - name: "Conversion Value Currency"
      expr: conversion_value_currency
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cross Domain Tracking Enabled"
      expr: cross_domain_tracking_enabled
    - name: "Data Collected"
      expr: data_collected
    - name: "Data Retention Days"
      expr: data_retention_days
    - name: "Deactivated Date"
      expr: deactivated_date
    - name: "Deployment Domain"
      expr: deployment_domain
    - name: "Deployment Url"
      expr: deployment_url
    - name: "Event Schema Definition"
      expr: event_schema_definition
    - name: "Event Types Captured"
      expr: event_types_captured
    - name: "Firing Rule"
      expr: firing_rule
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pixel"
      expr: COUNT(DISTINCT pixel_id)
    - name: "Total Total Events Captured"
      expr: SUM(total_events_captured)
    - name: "Average Total Events Captured"
      expr: AVG(total_events_captured)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`audience_pixel_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pixel Event business metrics"
  source: "`advertising_ecm`.`audience`.`pixel_event`"
  dimensions:
    - name: "Browser"
      expr: browser
    - name: "Browser Version"
      expr: browser_version
    - name: "Ccpa Opt Out"
      expr: ccpa_opt_out
    - name: "Consent Status"
      expr: consent_status
    - name: "Conversion Flag"
      expr: conversion_flag
    - name: "Cookie Identifier"
      expr: cookie_identifier
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Device Type"
      expr: device_type
    - name: "Event Source"
      expr: event_source
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Event Type"
      expr: event_type
    - name: "Gdpr Applies"
      expr: gdpr_applies
    - name: "Geographic City"
      expr: geographic_city
    - name: "Geographic Country"
      expr: geographic_country
    - name: "Geographic Region"
      expr: geographic_region
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pixel Event"
      expr: COUNT(DISTINCT pixel_event_id)
    - name: "Total Event Value"
      expr: SUM(event_value)
    - name: "Average Event Value"
      expr: AVG(event_value)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`audience_psychographic_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Psychographic Profile business metrics"
  source: "`advertising_ecm`.`audience`.`psychographic_profile`"
  dimensions:
    - name: "Brand Affinity Tier"
      expr: brand_affinity_tier
    - name: "Consent Compliant Flag"
      expr: consent_compliant_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cultural Orientation"
      expr: cultural_orientation
    - name: "Digital Engagement Level"
      expr: digital_engagement_level
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Last Refresh Date"
      expr: last_refresh_date
    - name: "Lifestyle Category"
      expr: lifestyle_category
    - name: "Media Consumption Attitude"
      expr: media_consumption_attitude
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Opinion Leader Indicator"
      expr: opinion_leader_indicator
    - name: "Personality Archetype"
      expr: personality_archetype
    - name: "Primary Interest Category"
      expr: primary_interest_category
    - name: "Privacy Classification"
      expr: privacy_classification
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Psychographic Profile"
      expr: COUNT(DISTINCT psychographic_profile_id)
    - name: "Total Brand Loyalty Score"
      expr: SUM(brand_loyalty_score)
    - name: "Average Brand Loyalty Score"
      expr: AVG(brand_loyalty_score)
    - name: "Total Environmental Consciousness Score"
      expr: SUM(environmental_consciousness_score)
    - name: "Average Environmental Consciousness Score"
      expr: AVG(environmental_consciousness_score)
    - name: "Total Innovation Adoption Index"
      expr: SUM(innovation_adoption_index)
    - name: "Average Innovation Adoption Index"
      expr: AVG(innovation_adoption_index)
    - name: "Total Price Sensitivity Index"
      expr: SUM(price_sensitivity_index)
    - name: "Average Price Sensitivity Index"
      expr: AVG(price_sensitivity_index)
    - name: "Total Profile Confidence Score"
      expr: SUM(profile_confidence_score)
    - name: "Average Profile Confidence Score"
      expr: AVG(profile_confidence_score)
    - name: "Total Social Media Activity Score"
      expr: SUM(social_media_activity_score)
    - name: "Average Social Media Activity Score"
      expr: AVG(social_media_activity_score)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`audience_segment_activation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Segment Activation business metrics"
  source: "`advertising_ecm`.`audience`.`segment_activation`"
  dimensions:
    - name: "Activation End Date"
      expr: activation_end_date
    - name: "Activation Start Date"
      expr: activation_start_date
    - name: "Activation Status"
      expr: activation_status
    - name: "Created Date"
      expr: created_date
    - name: "Frequency Cap"
      expr: frequency_cap
    - name: "Frequency Cap Window Hours"
      expr: frequency_cap_window_hours
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Date"
      expr: last_modified_date
    - name: "Segment Priority"
      expr: segment_priority
    - name: "Activation End Date Month"
      expr: DATE_TRUNC('MONTH', activation_end_date)
    - name: "Activation Start Date Month"
      expr: DATE_TRUNC('MONTH', activation_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Segment Activation"
      expr: COUNT(DISTINCT segment_activation_id)
    - name: "Total Allocated Budget"
      expr: SUM(allocated_budget)
    - name: "Average Allocated Budget"
      expr: AVG(allocated_budget)
    - name: "Total Allocated Impressions"
      expr: SUM(allocated_impressions)
    - name: "Average Allocated Impressions"
      expr: AVG(allocated_impressions)
    - name: "Total Bid Modifier"
      expr: SUM(bid_modifier)
    - name: "Average Bid Modifier"
      expr: AVG(bid_modifier)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`audience_segment_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Segment Membership business metrics"
  source: "`advertising_ecm`.`audience`.`segment_membership`"
  dimensions:
    - name: "Activation Status"
      expr: activation_status
    - name: "Activation Timestamp"
      expr: activation_timestamp
    - name: "Audience Identifier"
      expr: audience_identifier
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Device Type"
      expr: device_type
    - name: "Dsp Platform"
      expr: dsp_platform
    - name: "Frequency Cap"
      expr: frequency_cap
    - name: "Geographic Region"
      expr: geographic_region
    - name: "Identifier Type"
      expr: identifier_type
    - name: "Inclusion Flag"
      expr: inclusion_flag
    - name: "Last Refresh Timestamp"
      expr: last_refresh_timestamp
    - name: "Membership Expiry Date"
      expr: membership_expiry_date
    - name: "Membership Source"
      expr: membership_source
    - name: "Membership Start Date"
      expr: membership_start_date
    - name: "Membership Status"
      expr: membership_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Segment Membership"
      expr: COUNT(DISTINCT segment_membership_id)
    - name: "Total Confidence Score"
      expr: SUM(confidence_score)
    - name: "Average Confidence Score"
      expr: AVG(confidence_score)
    - name: "Total Cost Per Member"
      expr: SUM(cost_per_member)
    - name: "Average Cost Per Member"
      expr: AVG(cost_per_member)
    - name: "Total Match Rate"
      expr: SUM(match_rate)
    - name: "Average Match Rate"
      expr: AVG(match_rate)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`audience_segment_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Segment Usage business metrics"
  source: "`advertising_ecm`.`audience`.`segment_usage`"
  dimensions:
    - name: "Activation Status"
      expr: activation_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Priority Tier"
      expr: priority_tier
    - name: "Segment Role"
      expr: segment_role
    - name: "Usage End Date"
      expr: usage_end_date
    - name: "Usage Start Date"
      expr: usage_start_date
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Last Modified Timestamp Month"
      expr: DATE_TRUNC('MONTH', last_modified_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Segment Usage"
      expr: COUNT(DISTINCT segment_usage_id)
    - name: "Total Actual Spend"
      expr: SUM(actual_spend)
    - name: "Average Actual Spend"
      expr: AVG(actual_spend)
    - name: "Total Budget Allocated"
      expr: SUM(budget_allocated)
    - name: "Average Budget Allocated"
      expr: AVG(budget_allocated)
    - name: "Total Clicks Delivered"
      expr: SUM(clicks_delivered)
    - name: "Average Clicks Delivered"
      expr: AVG(clicks_delivered)
    - name: "Total Conversions Delivered"
      expr: SUM(conversions_delivered)
    - name: "Average Conversions Delivered"
      expr: AVG(conversions_delivered)
    - name: "Total Impressions Delivered"
      expr: SUM(impressions_delivered)
    - name: "Average Impressions Delivered"
      expr: AVG(impressions_delivered)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`audience_suppression_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Suppression List business metrics"
  source: "`advertising_ecm`.`audience`.`suppression_list`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Archive Date"
      expr: archive_date
    - name: "Consent Withdrawal Flag"
      expr: consent_withdrawal_flag
    - name: "Data Provider"
      expr: data_provider
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Frequency Cap Period"
      expr: frequency_cap_period
    - name: "Frequency Cap Threshold"
      expr: frequency_cap_threshold
    - name: "Hashing Algorithm"
      expr: hashing_algorithm
    - name: "Identifier Type"
      expr: identifier_type
    - name: "Last Refresh Timestamp"
      expr: last_refresh_timestamp
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "List Code"
      expr: list_code
    - name: "List Name"
      expr: list_name
    - name: "List Status"
      expr: list_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Suppression List"
      expr: COUNT(DISTINCT suppression_list_id)
    - name: "Total Data Cost"
      expr: SUM(data_cost)
    - name: "Average Data Cost"
      expr: AVG(data_cost)
    - name: "Total List Size"
      expr: SUM(list_size)
    - name: "Average List Size"
      expr: AVG(list_size)
    - name: "Total Match Rate Percentage"
      expr: SUM(match_rate_percentage)
    - name: "Average Match Rate Percentage"
      expr: AVG(match_rate_percentage)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`audience_taxonomy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Taxonomy business metrics"
  source: "`advertising_ecm`.`audience`.`taxonomy`"
  dimensions:
    - name: "Applicable Platforms"
      expr: applicable_platforms
    - name: "Category Description"
      expr: category_description
    - name: "Category Name"
      expr: category_name
    - name: "Cdp Integration Enabled"
      expr: cdp_integration_enabled
    - name: "Comscore Compatible"
      expr: comscore_compatible
    - name: "Consent Required"
      expr: consent_required
    - name: "Cpm Last Updated Date"
      expr: cpm_last_updated_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source Type"
      expr: data_source_type
    - name: "Data Type"
      expr: data_type
    - name: "Deprecation Reason"
      expr: deprecation_reason
    - name: "Dmp Integration Enabled"
      expr: dmp_integration_enabled
    - name: "Dsp Activation Enabled"
      expr: dsp_activation_enabled
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Exclusion Categories"
      expr: exclusion_categories
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Taxonomy"
      expr: COUNT(DISTINCT taxonomy_id)
    - name: "Total Average Cpm Usd"
      expr: SUM(average_cpm_usd)
    - name: "Average Average Cpm Usd"
      expr: AVG(average_cpm_usd)
    - name: "Total Estimated Reach"
      expr: SUM(estimated_reach)
    - name: "Average Estimated Reach"
      expr: AVG(estimated_reach)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`audience_third_party_feed`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Third Party Feed business metrics"
  source: "`advertising_ecm`.`audience`.`third_party_feed`"
  dimensions:
    - name: "Activated Timestamp"
      expr: activated_timestamp
    - name: "Api Endpoint Url"
      expr: api_endpoint_url
    - name: "Authentication Method"
      expr: authentication_method
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Ccpa Compliant Flag"
      expr: ccpa_compliant_flag
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Cost Model"
      expr: cost_model
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Expiry Days"
      expr: data_expiry_days
    - name: "Data Retention Days"
      expr: data_retention_days
    - name: "Data Taxonomy Version"
      expr: data_taxonomy_version
    - name: "Error Count"
      expr: error_count
    - name: "Feed Type"
      expr: feed_type
    - name: "Gdpr Compliant Flag"
      expr: gdpr_compliant_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Third Party Feed"
      expr: COUNT(DISTINCT third_party_feed_id)
    - name: "Total Cpm Rate"
      expr: SUM(cpm_rate)
    - name: "Average Cpm Rate"
      expr: AVG(cpm_rate)
    - name: "Total Data Volume Mb"
      expr: SUM(data_volume_mb)
    - name: "Average Data Volume Mb"
      expr: AVG(data_volume_mb)
    - name: "Total Integration Health Score"
      expr: SUM(integration_health_score)
    - name: "Average Integration Health Score"
      expr: AVG(integration_health_score)
    - name: "Total Last Sync Record Count"
      expr: SUM(last_sync_record_count)
    - name: "Average Last Sync Record Count"
      expr: AVG(last_sync_record_count)
    - name: "Total Monthly Cost Amount"
      expr: SUM(monthly_cost_amount)
    - name: "Average Monthly Cost Amount"
      expr: AVG(monthly_cost_amount)
    - name: "Total Total Records Synced"
      expr: SUM(total_records_synced)
    - name: "Average Total Records Synced"
      expr: AVG(total_records_synced)
$$;