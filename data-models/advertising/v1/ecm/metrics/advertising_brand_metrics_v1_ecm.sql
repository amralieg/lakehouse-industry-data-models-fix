-- Metric views for domain: brand | Business: Advertising | Version: 1 | Generated on: 2026-05-08 02:25:35

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`brand_advertiser_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advertiser Policy business metrics"
  source: "`advertising_ecm`.`brand`.`advertiser_policy`"
  dimensions:
    - name: "Allowed Content Categories"
      expr: allowed_content_categories
    - name: "Applies To Channels"
      expr: applies_to_channels
    - name: "Approval Date"
      expr: approval_date
    - name: "Auto Enforcement Enabled"
      expr: auto_enforcement_enabled
    - name: "Compliance Framework"
      expr: compliance_framework
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Documentation Url"
      expr: documentation_url
    - name: "Effective Date"
      expr: effective_date
    - name: "Enforcement Level"
      expr: enforcement_level
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Geographic Restrictions"
      expr: geographic_restrictions
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Next Review Date"
      expr: next_review_date
    - name: "Notes"
      expr: notes
    - name: "Notification Recipients"
      expr: notification_recipients
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Advertiser Policy"
      expr: COUNT(DISTINCT advertiser_policy_id)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`brand_architecture`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Architecture business metrics"
  source: "`advertising_ecm`.`brand`.`architecture`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Date"
      expr: approved_date
    - name: "Architecture Code"
      expr: architecture_code
    - name: "Architecture Name"
      expr: architecture_name
    - name: "Architecture Status"
      expr: architecture_status
    - name: "Architecture Type"
      expr: architecture_type
    - name: "Brand Role"
      expr: brand_role
    - name: "Channel Applicability"
      expr: channel_applicability
    - name: "Co Branding Allowed"
      expr: co_branding_allowed
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Endorsement Strength"
      expr: endorsement_strength
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Geographic Scope"
      expr: geographic_scope
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Architecture"
      expr: COUNT(DISTINCT architecture_id)
    - name: "Total Brand Equity Contribution Score"
      expr: SUM(brand_equity_contribution_score)
    - name: "Average Brand Equity Contribution Score"
      expr: AVG(brand_equity_contribution_score)
    - name: "Total Target Audience Overlap Pct"
      expr: SUM(target_audience_overlap_pct)
    - name: "Average Target Audience Overlap Pct"
      expr: AVG(target_audience_overlap_pct)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`brand_asset_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset Deployment business metrics"
  source: "`advertising_ecm`.`brand`.`asset_deployment`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Deployment Date"
      expr: deployment_date
    - name: "Deployment End Date"
      expr: deployment_end_date
    - name: "Media Placement Count"
      expr: media_placement_count
    - name: "Usage Context"
      expr: usage_context
    - name: "Usage Notes"
      expr: usage_notes
    - name: "Deployment Date Month"
      expr: DATE_TRUNC('MONTH', deployment_date)
    - name: "Deployment End Date Month"
      expr: DATE_TRUNC('MONTH', deployment_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Asset Deployment"
      expr: COUNT(DISTINCT asset_deployment_id)
    - name: "Total Asset Performance Score"
      expr: SUM(asset_performance_score)
    - name: "Average Asset Performance Score"
      expr: AVG(asset_performance_score)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`brand_brand_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand Asset business metrics"
  source: "`advertising_ecm`.`brand`.`brand_asset`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Channels"
      expr: approved_channels
    - name: "Asset Description"
      expr: asset_description
    - name: "Asset Name"
      expr: asset_name
    - name: "Asset Type"
      expr: asset_type
    - name: "Cobranding Partner"
      expr: cobranding_partner
    - name: "Color Mode"
      expr: color_mode
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deployment Count"
      expr: deployment_count
    - name: "File Format"
      expr: file_format
    - name: "Height Px"
      expr: height_px
    - name: "Is Master Asset"
      expr: is_master_asset
    - name: "Language Code"
      expr: language_code
    - name: "Last Deployed Date"
      expr: last_deployed_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Brand Asset"
      expr: COUNT(DISTINCT brand_asset_id)
    - name: "Total File Size Kb"
      expr: SUM(file_size_kb)
    - name: "Average File Size Kb"
      expr: AVG(file_size_kb)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`brand_brand_compliance_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand Compliance Check business metrics"
  source: "`advertising_ecm`.`brand`.`brand_compliance_check`"
  dimensions:
    - name: "Approver Name"
      expr: approver_name
    - name: "Check Number"
      expr: check_number
    - name: "Compliance Outcome"
      expr: compliance_outcome
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Item Identifier"
      expr: item_identifier
    - name: "Item Title"
      expr: item_title
    - name: "Item Type"
      expr: item_type
    - name: "Jurisdiction"
      expr: jurisdiction
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Partner Brand Name"
      expr: partner_brand_name
    - name: "Partnership Type"
      expr: partnership_type
    - name: "Regulatory Framework"
      expr: regulatory_framework
    - name: "Remediation Deadline"
      expr: remediation_deadline
    - name: "Remediation Notes"
      expr: remediation_notes
    - name: "Remediation Required Flag"
      expr: remediation_required_flag
    - name: "Resubmission Count"
      expr: resubmission_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Brand Compliance Check"
      expr: COUNT(DISTINCT brand_compliance_check_id)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`brand_brand_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand Profile business metrics"
  source: "`advertising_ecm`.`brand`.`brand_profile`"
  dimensions:
    - name: "Active Markets"
      expr: active_markets
    - name: "Agency Onboard Date"
      expr: agency_onboard_date
    - name: "Asa Compliant"
      expr: asa_compliant
    - name: "Brand Archetype"
      expr: brand_archetype
    - name: "Brand Code"
      expr: brand_code
    - name: "Brand Guidelines Url"
      expr: brand_guidelines_url
    - name: "Brand Name"
      expr: brand_name
    - name: "Brand Safety Category"
      expr: brand_safety_category
    - name: "Brand Status"
      expr: brand_status
    - name: "Brand Tier"
      expr: brand_tier
    - name: "Ccpa Opt Out"
      expr: ccpa_opt_out
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Easa Compliant"
      expr: easa_compliant
    - name: "Ftc Compliant"
      expr: ftc_compliant
    - name: "Gdpr Data Use Consent"
      expr: gdpr_data_use_consent
    - name: "Industry Vertical"
      expr: industry_vertical
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Brand Profile"
      expr: COUNT(DISTINCT brand_profile_id)
    - name: "Total Brand Awareness Baseline Pct"
      expr: SUM(brand_awareness_baseline_pct)
    - name: "Average Brand Awareness Baseline Pct"
      expr: AVG(brand_awareness_baseline_pct)
    - name: "Total Nps Baseline Score"
      expr: SUM(nps_baseline_score)
    - name: "Average Nps Baseline Score"
      expr: AVG(nps_baseline_score)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`brand_brand_spokesperson`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand Spokesperson business metrics"
  source: "`advertising_ecm`.`brand`.`brand_spokesperson`"
  dimensions:
    - name: "Applicable Markets"
      expr: applicable_markets
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Expiry Date"
      expr: approval_expiry_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Topics"
      expr: approved_topics
    - name: "Background Check Status"
      expr: background_check_status
    - name: "Biography"
      expr: biography
    - name: "Compensation Type"
      expr: compensation_type
    - name: "Conflict Of Interest Check Date"
      expr: conflict_of_interest_check_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crisis Contact Name"
      expr: crisis_contact_name
    - name: "Crisis Contact Phone"
      expr: crisis_contact_phone
    - name: "Email Address"
      expr: email_address
    - name: "Exclusivity Flag"
      expr: exclusivity_flag
    - name: "Headshot Url"
      expr: headshot_url
    - name: "Media Training Date"
      expr: media_training_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Brand Spokesperson"
      expr: COUNT(DISTINCT brand_spokesperson_id)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`brand_competitive_brand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Competitive Brand business metrics"
  source: "`advertising_ecm`.`brand`.`competitive_brand`"
  dimensions:
    - name: "Brand Archetype"
      expr: brand_archetype
    - name: "Brand Name"
      expr: brand_name
    - name: "Brand Positioning Statement"
      expr: brand_positioning_statement
    - name: "Brand Website Url"
      expr: brand_website_url
    - name: "Competitive Differentiation Factors"
      expr: competitive_differentiation_factors
    - name: "Competitive Threat Level"
      expr: competitive_threat_level
    - name: "Comscore Entity Code"
      expr: comscore_entity_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source Systems"
      expr: data_source_systems
    - name: "Estimated Annual Ad Spend Tier"
      expr: estimated_annual_ad_spend_tier
    - name: "Industry Vertical"
      expr: industry_vertical
    - name: "Key Messaging Themes"
      expr: key_messaging_themes
    - name: "Known Agency Relationships"
      expr: known_agency_relationships
    - name: "Last Intelligence Update Date"
      expr: last_intelligence_update_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Media Mix Strategy"
      expr: media_mix_strategy
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Competitive Brand"
      expr: COUNT(DISTINCT competitive_brand_id)
    - name: "Total Brand Sentiment Score"
      expr: SUM(brand_sentiment_score)
    - name: "Average Brand Sentiment Score"
      expr: AVG(brand_sentiment_score)
    - name: "Total Estimated Brand Awareness Percentage"
      expr: SUM(estimated_brand_awareness_percentage)
    - name: "Average Estimated Brand Awareness Percentage"
      expr: AVG(estimated_brand_awareness_percentage)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`brand_competitive_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Competitive Monitoring business metrics"
  source: "`advertising_ecm`.`brand`.`competitive_monitoring`"
  dimensions:
    - name: "Competitive Rank"
      expr: competitive_rank
    - name: "Competitive Threat Level"
      expr: competitive_threat_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Last Intelligence Update Date"
      expr: last_intelligence_update_date
    - name: "Monitoring Cadence"
      expr: monitoring_cadence
    - name: "Monitoring Start Date"
      expr: monitoring_start_date
    - name: "Monitoring Status"
      expr: monitoring_status
    - name: "Notes"
      expr: notes
    - name: "Sov Comparison Enabled"
      expr: sov_comparison_enabled
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Last Intelligence Update Date Month"
      expr: DATE_TRUNC('MONTH', last_intelligence_update_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Competitive Monitoring"
      expr: COUNT(DISTINCT competitive_monitoring_id)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`brand_crisis_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crisis Event business metrics"
  source: "`advertising_ecm`.`brand`.`crisis_event`"
  dimensions:
    - name: "Affected Markets"
      expr: affected_markets
    - name: "Communication Channels Used"
      expr: communication_channels_used
    - name: "Corrective Action Plan"
      expr: corrective_action_plan
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crisis Name"
      expr: crisis_name
    - name: "Crisis Status"
      expr: crisis_status
    - name: "Crisis Type"
      expr: crisis_type
    - name: "Detection Source"
      expr: detection_source
    - name: "Detection Timestamp"
      expr: detection_timestamp
    - name: "Escalation Timestamp"
      expr: escalation_timestamp
    - name: "Holding Statement Reference"
      expr: holding_statement_reference
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Legal Action Flag"
      expr: legal_action_flag
    - name: "Media Mentions Count"
      expr: media_mentions_count
    - name: "Post Crisis Impact Assessment Flag"
      expr: post_crisis_impact_assessment_flag
    - name: "Regulatory Body Involved"
      expr: regulatory_body_involved
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Crisis Event"
      expr: COUNT(DISTINCT crisis_event_id)
    - name: "Total Brand Awareness Impact Pct"
      expr: SUM(brand_awareness_impact_pct)
    - name: "Average Brand Awareness Impact Pct"
      expr: AVG(brand_awareness_impact_pct)
    - name: "Total Estimated Reach"
      expr: SUM(estimated_reach)
    - name: "Average Estimated Reach"
      expr: AVG(estimated_reach)
    - name: "Total Financial Impact Estimate"
      expr: SUM(financial_impact_estimate)
    - name: "Average Financial Impact Estimate"
      expr: AVG(financial_impact_estimate)
    - name: "Total Nps Impact Score"
      expr: SUM(nps_impact_score)
    - name: "Average Nps Impact Score"
      expr: AVG(nps_impact_score)
    - name: "Total Sentiment Score"
      expr: SUM(sentiment_score)
    - name: "Average Sentiment Score"
      expr: AVG(sentiment_score)
    - name: "Total Social Media Volume"
      expr: SUM(social_media_volume)
    - name: "Average Social Media Volume"
      expr: AVG(social_media_volume)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`brand_guideline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guideline business metrics"
  source: "`advertising_ecm`.`brand`.`guideline`"
  dimensions:
    - name: "Applicable Markets"
      expr: applicable_markets
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Date"
      expr: approved_date
    - name: "Approved Typefaces"
      expr: approved_typefaces
    - name: "Audience Message Map"
      expr: audience_message_map
    - name: "Brand Pillars"
      expr: brand_pillars
    - name: "Brand Promise"
      expr: brand_promise
    - name: "Change Summary"
      expr: change_summary
    - name: "Channel Scope"
      expr: channel_scope
    - name: "Co Brand Partner Name"
      expr: co_brand_partner_name
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dam Uri"
      expr: dam_uri
    - name: "Effective Date"
      expr: effective_date
    - name: "Elevator Pitch"
      expr: elevator_pitch
    - name: "Expiry Date"
      expr: expiry_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Guideline"
      expr: COUNT(DISTINCT guideline_id)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`brand_health_metric`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health Metric business metrics"
  source: "`advertising_ecm`.`brand`.`health_metric`"
  dimensions:
    - name: "Collection Frequency"
      expr: collection_frequency
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source"
      expr: data_source
    - name: "Geography Code"
      expr: geography_code
    - name: "Is Statistically Significant"
      expr: is_statistically_significant
    - name: "Market Segment"
      expr: market_segment
    - name: "Measurement Date"
      expr: measurement_date
    - name: "Measurement Period End"
      expr: measurement_period_end
    - name: "Measurement Period Start"
      expr: measurement_period_start
    - name: "Measurement Type"
      expr: measurement_type
    - name: "Mention Volume"
      expr: mention_volume
    - name: "Methodology"
      expr: methodology
    - name: "Metric Name"
      expr: metric_name
    - name: "Notes"
      expr: notes
    - name: "Research Vendor"
      expr: research_vendor
    - name: "Review Event Type"
      expr: review_event_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Health Metric"
      expr: COUNT(DISTINCT health_metric_id)
    - name: "Total Benchmark Value"
      expr: SUM(benchmark_value)
    - name: "Average Benchmark Value"
      expr: AVG(benchmark_value)
    - name: "Total Confidence Level"
      expr: SUM(confidence_level)
    - name: "Average Confidence Level"
      expr: AVG(confidence_level)
    - name: "Total Data Quality Score"
      expr: SUM(data_quality_score)
    - name: "Average Data Quality Score"
      expr: AVG(data_quality_score)
    - name: "Total Margin Of Error"
      expr: SUM(margin_of_error)
    - name: "Average Margin Of Error"
      expr: AVG(margin_of_error)
    - name: "Total Metric Value"
      expr: SUM(metric_value)
    - name: "Average Metric Value"
      expr: AVG(metric_value)
    - name: "Total Prior Period Value"
      expr: SUM(prior_period_value)
    - name: "Average Prior Period Value"
      expr: AVG(prior_period_value)
    - name: "Total Sentiment Magnitude"
      expr: SUM(sentiment_magnitude)
    - name: "Average Sentiment Magnitude"
      expr: AVG(sentiment_magnitude)
    - name: "Total Share Of Voice Percentage"
      expr: SUM(share_of_voice_percentage)
    - name: "Average Share Of Voice Percentage"
      expr: AVG(share_of_voice_percentage)
    - name: "Total Target Value"
      expr: SUM(target_value)
    - name: "Average Target Value"
      expr: AVG(target_value)
    - name: "Total Variance Percentage"
      expr: SUM(variance_percentage)
    - name: "Average Variance Percentage"
      expr: AVG(variance_percentage)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`brand_media_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media Coverage business metrics"
  source: "`advertising_ecm`.`brand`.`media_coverage`"
  dimensions:
    - name: "Article Word Count"
      expr: article_word_count
    - name: "Ave Currency Code"
      expr: ave_currency_code
    - name: "Brand Mention Count"
      expr: brand_mention_count
    - name: "Competitive Mention Flag"
      expr: competitive_mention_flag
    - name: "Coverage Date"
      expr: coverage_date
    - name: "Coverage Prominence"
      expr: coverage_prominence
    - name: "Coverage Reference Number"
      expr: coverage_reference_number
    - name: "Coverage Status"
      expr: coverage_status
    - name: "Coverage Timestamp"
      expr: coverage_timestamp
    - name: "Coverage Type"
      expr: coverage_type
    - name: "Coverage Url"
      expr: coverage_url
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Domain Authority Score"
      expr: domain_authority_score
    - name: "Geographic Market"
      expr: geographic_market
    - name: "Headline"
      expr: headline
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Media Coverage"
      expr: COUNT(DISTINCT media_coverage_id)
    - name: "Total Ave Amount"
      expr: SUM(ave_amount)
    - name: "Average Ave Amount"
      expr: AVG(ave_amount)
    - name: "Total Circulation Count"
      expr: SUM(circulation_count)
    - name: "Average Circulation Count"
      expr: AVG(circulation_count)
    - name: "Total Estimated Reach"
      expr: SUM(estimated_reach)
    - name: "Average Estimated Reach"
      expr: AVG(estimated_reach)
    - name: "Total Key Message Alignment Score"
      expr: SUM(key_message_alignment_score)
    - name: "Average Key Message Alignment Score"
      expr: AVG(key_message_alignment_score)
    - name: "Total Sentiment Score"
      expr: SUM(sentiment_score)
    - name: "Average Sentiment Score"
      expr: AVG(sentiment_score)
    - name: "Total Share Of Voice Contribution"
      expr: SUM(share_of_voice_contribution)
    - name: "Average Share Of Voice Contribution"
      expr: AVG(share_of_voice_contribution)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`brand_partnership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partnership business metrics"
  source: "`advertising_ecm`.`brand`.`partnership`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Cobranded Asset References"
      expr: approved_cobranded_asset_references
    - name: "Channel Scope"
      expr: channel_scope
    - name: "Compliance Check Required Flag"
      expr: compliance_check_required_flag
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Reference"
      expr: contract_reference
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Exclusivity Category"
      expr: exclusivity_category
    - name: "Exclusivity Flag"
      expr: exclusivity_flag
    - name: "Last Compliance Check Date"
      expr: last_compliance_check_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Market Scope"
      expr: market_scope
    - name: "Modified By"
      expr: modified_by
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partnership"
      expr: COUNT(DISTINCT partnership_id)
    - name: "Total Actual Brand Awareness Lift Pct"
      expr: SUM(actual_brand_awareness_lift_pct)
    - name: "Average Actual Brand Awareness Lift Pct"
      expr: AVG(actual_brand_awareness_lift_pct)
    - name: "Total Actual Roi Percentage"
      expr: SUM(actual_roi_percentage)
    - name: "Average Actual Roi Percentage"
      expr: AVG(actual_roi_percentage)
    - name: "Total Brand Fit Score"
      expr: SUM(brand_fit_score)
    - name: "Average Brand Fit Score"
      expr: AVG(brand_fit_score)
    - name: "Total Revenue Share Percentage"
      expr: SUM(revenue_share_percentage)
    - name: "Average Revenue Share Percentage"
      expr: AVG(revenue_share_percentage)
    - name: "Total Target Audience Overlap Pct"
      expr: SUM(target_audience_overlap_pct)
    - name: "Average Target Audience Overlap Pct"
      expr: AVG(target_audience_overlap_pct)
    - name: "Total Target Brand Awareness Lift Pct"
      expr: SUM(target_brand_awareness_lift_pct)
    - name: "Average Target Brand Awareness Lift Pct"
      expr: AVG(target_brand_awareness_lift_pct)
    - name: "Total Target Roi Percentage"
      expr: SUM(target_roi_percentage)
    - name: "Average Target Roi Percentage"
      expr: AVG(target_roi_percentage)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`brand_positioning`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Positioning business metrics"
  source: "`advertising_ecm`.`brand`.`positioning`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Date"
      expr: approved_date
    - name: "Awareness Type"
      expr: awareness_type
    - name: "Brand Essence"
      expr: brand_essence
    - name: "Brand Personality"
      expr: brand_personality
    - name: "Brand Promise"
      expr: brand_promise
    - name: "Competitive Set Ids"
      expr: competitive_set_ids
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Frame Of Reference"
      expr: frame_of_reference
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Is Global Master"
      expr: is_global_master
    - name: "Language Code"
      expr: language_code
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Messaging Framework"
      expr: messaging_framework
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Positioning"
      expr: COUNT(DISTINCT positioning_id)
    - name: "Total Brand Awareness Baseline Pct"
      expr: SUM(brand_awareness_baseline_pct)
    - name: "Average Brand Awareness Baseline Pct"
      expr: AVG(brand_awareness_baseline_pct)
    - name: "Total Brand Sentiment Baseline"
      expr: SUM(brand_sentiment_baseline)
    - name: "Average Brand Sentiment Baseline"
      expr: AVG(brand_sentiment_baseline)
    - name: "Total Nps Baseline"
      expr: SUM(nps_baseline)
    - name: "Average Nps Baseline"
      expr: AVG(nps_baseline)
    - name: "Total Sov Target Pct"
      expr: SUM(sov_target_pct)
    - name: "Average Sov Target Pct"
      expr: AVG(sov_target_pct)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`brand_pr_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pr Campaign business metrics"
  source: "`advertising_ecm`.`brand`.`pr_campaign`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Date"
      expr: approved_date
    - name: "Campaign Code"
      expr: campaign_code
    - name: "Campaign Name"
      expr: campaign_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crisis Flag"
      expr: crisis_flag
    - name: "Currency Code"
      expr: currency_code
    - name: "End Date"
      expr: end_date
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Key Messages Reference"
      expr: key_messages_reference
    - name: "Media Kit Reference"
      expr: media_kit_reference
    - name: "Media Placements Count"
      expr: media_placements_count
    - name: "Modified By"
      expr: modified_by
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pr Campaign"
      expr: COUNT(DISTINCT pr_campaign_id)
    - name: "Total Actual Earned Media Value"
      expr: SUM(actual_earned_media_value)
    - name: "Average Actual Earned Media Value"
      expr: AVG(actual_earned_media_value)
    - name: "Total Actual Media Impressions"
      expr: SUM(actual_media_impressions)
    - name: "Average Actual Media Impressions"
      expr: AVG(actual_media_impressions)
    - name: "Total Budget Allocation"
      expr: SUM(budget_allocation)
    - name: "Average Budget Allocation"
      expr: AVG(budget_allocation)
    - name: "Total Earned Media Value Target"
      expr: SUM(earned_media_value_target)
    - name: "Average Earned Media Value Target"
      expr: AVG(earned_media_value_target)
    - name: "Total Sentiment Score"
      expr: SUM(sentiment_score)
    - name: "Average Sentiment Score"
      expr: AVG(sentiment_score)
    - name: "Total Share Of Voice Percentage"
      expr: SUM(share_of_voice_percentage)
    - name: "Average Share Of Voice Percentage"
      expr: AVG(share_of_voice_percentage)
    - name: "Total Target Media Impressions"
      expr: SUM(target_media_impressions)
    - name: "Average Target Media Impressions"
      expr: AVG(target_media_impressions)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`brand_press_release`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Press Release business metrics"
  source: "`advertising_ecm`.`brand`.`press_release`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Boilerplate Text"
      expr: boilerplate_text
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Distribution Date"
      expr: distribution_date
    - name: "Distribution Geography"
      expr: distribution_geography
    - name: "Document Url"
      expr: document_url
    - name: "Draft Version"
      expr: draft_version
    - name: "Embargo Date"
      expr: embargo_date
    - name: "Key Messages"
      expr: key_messages
    - name: "Language Variants"
      expr: language_variants
    - name: "Media Contact Email"
      expr: media_contact_email
    - name: "Media Contact Name"
      expr: media_contact_name
    - name: "Media Contact Phone"
      expr: media_contact_phone
    - name: "Modified By"
      expr: modified_by
    - name: "Modified Timestamp"
      expr: modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Press Release"
      expr: COUNT(DISTINCT press_release_id)
    - name: "Total Estimated Reach"
      expr: SUM(estimated_reach)
    - name: "Average Estimated Reach"
      expr: AVG(estimated_reach)
    - name: "Total Sentiment Score"
      expr: SUM(sentiment_score)
    - name: "Average Sentiment Score"
      expr: AVG(sentiment_score)
    - name: "Total Sov Impact"
      expr: SUM(sov_impact)
    - name: "Average Sov Impact"
      expr: AVG(sov_impact)
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`brand_share_of_voice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Share Of Voice business metrics"
  source: "`advertising_ecm`.`brand`.`share_of_voice`"
  dimensions:
    - name: "Competitive Rank"
      expr: competitive_rank
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Source Reference"
      expr: data_source_reference
    - name: "Data Source System"
      expr: data_source_system
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Market Geography"
      expr: market_geography
    - name: "Market Geography Code"
      expr: market_geography_code
    - name: "Measurement Methodology"
      expr: measurement_methodology
    - name: "Measurement Period End Date"
      expr: measurement_period_end_date
    - name: "Measurement Period Start Date"
      expr: measurement_period_start_date
    - name: "Measurement Period Type"
      expr: measurement_period_type
    - name: "Media Channel"
      expr: media_channel
    - name: "Notes"
      expr: notes
    - name: "Product Category"
      expr: product_category
    - name: "Product Subcategory"
      expr: product_subcategory
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Share Of Voice"
      expr: COUNT(DISTINCT share_of_voice_id)
    - name: "Total Brand Impression Count"
      expr: SUM(brand_impression_count)
    - name: "Average Brand Impression Count"
      expr: AVG(brand_impression_count)
    - name: "Total Brand Sov Percentage"
      expr: SUM(brand_sov_percentage)
    - name: "Average Brand Sov Percentage"
      expr: AVG(brand_sov_percentage)
    - name: "Total Brand Spend Estimate"
      expr: SUM(brand_spend_estimate)
    - name: "Average Brand Spend Estimate"
      expr: AVG(brand_spend_estimate)
    - name: "Total Competitor Impression Count"
      expr: SUM(competitor_impression_count)
    - name: "Average Competitor Impression Count"
      expr: AVG(competitor_impression_count)
    - name: "Total Competitor Sov Percentage"
      expr: SUM(competitor_sov_percentage)
    - name: "Average Competitor Sov Percentage"
      expr: AVG(competitor_sov_percentage)
    - name: "Total Competitor Spend Estimate"
      expr: SUM(competitor_spend_estimate)
    - name: "Average Competitor Spend Estimate"
      expr: AVG(competitor_spend_estimate)
    - name: "Total Data Quality Score"
      expr: SUM(data_quality_score)
    - name: "Average Data Quality Score"
      expr: AVG(data_quality_score)
    - name: "Total Sov Index Vs Category Average"
      expr: SUM(sov_index_vs_category_average)
    - name: "Average Sov Index Vs Category Average"
      expr: AVG(sov_index_vs_category_average)
    - name: "Total Total Category Impression Count"
      expr: SUM(total_category_impression_count)
    - name: "Average Total Category Impression Count"
      expr: AVG(total_category_impression_count)
    - name: "Total Total Category Spend Estimate"
      expr: SUM(total_category_spend_estimate)
    - name: "Average Total Category Spend Estimate"
      expr: AVG(total_category_spend_estimate)
$$;