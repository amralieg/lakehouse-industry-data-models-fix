-- Metric views for domain: licensing | Business: Gaming | Version: 1 | Generated on: 2026-05-08 07:57:15

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_agreement_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agreement Amendment business metrics"
  source: "`gaming_ecm`.`licensing`.`agreement_amendment`"
  dimensions:
    - name: "Amendment Date"
      expr: amendment_date
    - name: "Amendment Description"
      expr: amendment_description
    - name: "Amendment Number"
      expr: amendment_number
    - name: "Amendment Status"
      expr: amendment_status
    - name: "Amendment Type"
      expr: amendment_type
    - name: "Approval Chain"
      expr: approval_chain
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Date"
      expr: approved_date
    - name: "Compliance Impact"
      expr: compliance_impact
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Document Reference"
      expr: document_reference
    - name: "Effective Date"
      expr: effective_date
    - name: "Executed By Licensee"
      expr: executed_by_licensee
    - name: "Executed By Licensor"
      expr: executed_by_licensor
    - name: "Execution Date"
      expr: execution_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Agreement Amendment"
      expr: COUNT(DISTINCT agreement_amendment_id)
    - name: "Total Financial Impact Amount"
      expr: SUM(financial_impact_amount)
    - name: "Average Financial Impact Amount"
      expr: AVG(financial_impact_amount)
    - name: "Total New Minimum Guarantee"
      expr: SUM(new_minimum_guarantee)
    - name: "Average New Minimum Guarantee"
      expr: AVG(new_minimum_guarantee)
    - name: "Total New Royalty Rate"
      expr: SUM(new_royalty_rate)
    - name: "Average New Royalty Rate"
      expr: AVG(new_royalty_rate)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_audit_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit Event business metrics"
  source: "`gaming_ecm`.`licensing`.`audit_event`"
  dimensions:
    - name: "Audit Period End Date"
      expr: audit_period_end_date
    - name: "Audit Period Start Date"
      expr: audit_period_start_date
    - name: "Auditor Name"
      expr: auditor_name
    - name: "Auditor Organization"
      expr: auditor_organization
    - name: "Auditor Type"
      expr: auditor_type
    - name: "Case Number"
      expr: case_number
    - name: "Compliance Action Required"
      expr: compliance_action_required
    - name: "Confidentiality Agreement Flag"
      expr: confidentiality_agreement_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Disputed Amount Currency"
      expr: disputed_amount_currency
    - name: "Event Completed Date"
      expr: event_completed_date
    - name: "Event Initiated Date"
      expr: event_initiated_date
    - name: "Event Status"
      expr: event_status
    - name: "Event Type"
      expr: event_type
    - name: "Findings Summary"
      expr: findings_summary
    - name: "Follow Up Audit Date"
      expr: follow_up_audit_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Audit Event"
      expr: COUNT(DISTINCT audit_event_id)
    - name: "Total Disputed Amount"
      expr: SUM(disputed_amount)
    - name: "Average Disputed Amount"
      expr: AVG(disputed_amount)
    - name: "Total Settlement Amount"
      expr: SUM(settlement_amount)
    - name: "Average Settlement Amount"
      expr: AVG(settlement_amount)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_battle_pass`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Battle Pass business metrics"
  source: "`gaming_ecm`.`licensing`.`battle_pass`"
  dimensions:
    - name: "Approved By"
      expr: approved_by
    - name: "Contains Loot Box"
      expr: contains_loot_box
    - name: "Content Entitlements"
      expr: content_entitlements
    - name: "Coppa Restricted"
      expr: coppa_restricted
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Duration Days"
      expr: duration_days
    - name: "End Date"
      expr: end_date
    - name: "Esrb Rating"
      expr: esrb_rating
    - name: "Free Tier Count"
      expr: free_tier_count
    - name: "Gdpr Data Processing Note"
      expr: gdpr_data_processing_note
    - name: "Has Free Track"
      expr: has_free_track
    - name: "Has Premium Plus"
      expr: has_premium_plus
    - name: "Is Cross Platform"
      expr: is_cross_platform
    - name: "Jira Epic Key"
      expr: jira_epic_key
    - name: "Launch Region"
      expr: launch_region
    - name: "Loot Box Disclosure Url"
      expr: loot_box_disclosure_url
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Battle Pass"
      expr: COUNT(DISTINCT battle_pass_id)
    - name: "Total Premium Plus Price Usd"
      expr: SUM(premium_plus_price_usd)
    - name: "Average Premium Plus Price Usd"
      expr: AVG(premium_plus_price_usd)
    - name: "Total Premium Price Usd"
      expr: SUM(premium_price_usd)
    - name: "Average Premium Price Usd"
      expr: AVG(premium_price_usd)
    - name: "Total Tier Skip Price Usd"
      expr: SUM(tier_skip_price_usd)
    - name: "Average Tier Skip Price Usd"
      expr: AVG(tier_skip_price_usd)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_battle_pass_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Battle Pass Entitlement business metrics"
  source: "`gaming_ecm`.`licensing`.`battle_pass_entitlement`"
  dimensions:
    - name: "Acquisition Channel"
      expr: acquisition_channel
    - name: "Age Gate Verified"
      expr: age_gate_verified
    - name: "Auto Renew Enabled"
      expr: auto_renew_enabled
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Current Tier"
      expr: current_tier
    - name: "Current Xp"
      expr: current_xp
    - name: "Entitlement Reference Code"
      expr: entitlement_reference_code
    - name: "Entitlement Status"
      expr: entitlement_status
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Free Tier Unlocked"
      expr: free_tier_unlocked
    - name: "Is Completed"
      expr: is_completed
    - name: "Is Gifted"
      expr: is_gifted
    - name: "Is Premium Active"
      expr: is_premium_active
    - name: "Last Progression Timestamp"
      expr: last_progression_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Battle Pass Entitlement"
      expr: COUNT(DISTINCT battle_pass_entitlement_id)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Net Purchase Amount"
      expr: SUM(net_purchase_amount)
    - name: "Average Net Purchase Amount"
      expr: AVG(net_purchase_amount)
    - name: "Total Purchase Price Amount"
      expr: SUM(purchase_price_amount)
    - name: "Average Purchase Price Amount"
      expr: AVG(purchase_price_amount)
    - name: "Total Tier Skip Spend Amount"
      expr: SUM(tier_skip_spend_amount)
    - name: "Average Tier Skip Spend Amount"
      expr: AVG(tier_skip_spend_amount)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_brand_partnership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand Partnership business metrics"
  source: "`gaming_ecm`.`licensing`.`brand_partnership`"
  dimensions:
    - name: "Approval Turnaround Days"
      expr: approval_turnaround_days
    - name: "Approval Workflow Required Flag"
      expr: approval_workflow_required_flag
    - name: "Audit Frequency"
      expr: audit_frequency
    - name: "Audit Rights Flag"
      expr: audit_rights_flag
    - name: "Brand Usage Guidelines Url"
      expr: brand_usage_guidelines_url
    - name: "Co Marketing Obligation Flag"
      expr: co_marketing_obligation_flag
    - name: "Co Marketing Requirements"
      expr: co_marketing_requirements
    - name: "Compliance Requirements"
      expr: compliance_requirements
    - name: "Contract Document Reference"
      expr: contract_document_reference
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Exclusivity Flag"
      expr: exclusivity_flag
    - name: "Exclusivity Terms"
      expr: exclusivity_terms
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Brand Partnership"
      expr: COUNT(DISTINCT brand_partnership_id)
    - name: "Total Fixed Fee Amount"
      expr: SUM(fixed_fee_amount)
    - name: "Average Fixed Fee Amount"
      expr: AVG(fixed_fee_amount)
    - name: "Total Minimum Guarantee Amount"
      expr: SUM(minimum_guarantee_amount)
    - name: "Average Minimum Guarantee Amount"
      expr: AVG(minimum_guarantee_amount)
    - name: "Total Royalty Rate Percent"
      expr: SUM(royalty_rate_percent)
    - name: "Average Royalty Rate Percent"
      expr: AVG(royalty_rate_percent)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_catalog_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Catalog Offer business metrics"
  source: "`gaming_ecm`.`licensing`.`catalog_offer`"
  dimensions:
    - name: "Ab Test Variant Assignment"
      expr: ab_test_variant_assignment
    - name: "Added To Campaign Timestamp"
      expr: added_to_campaign_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Display Priority In Campaign"
      expr: display_priority_in_campaign
    - name: "Is Featured Item"
      expr: is_featured_item
    - name: "Removed From Campaign Timestamp"
      expr: removed_from_campaign_timestamp
    - name: "Added To Campaign Timestamp Month"
      expr: DATE_TRUNC('MONTH', added_to_campaign_timestamp)
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Catalog Offer"
      expr: COUNT(DISTINCT catalog_offer_id)
    - name: "Total Campaign Specific Discount Value"
      expr: SUM(campaign_specific_discount_value)
    - name: "Average Campaign Specific Discount Value"
      expr: AVG(campaign_specific_discount_value)
    - name: "Total Conversion Rate For Item"
      expr: SUM(conversion_rate_for_item)
    - name: "Average Conversion Rate For Item"
      expr: AVG(conversion_rate_for_item)
    - name: "Total Impression Count For Item"
      expr: SUM(impression_count_for_item)
    - name: "Average Impression Count For Item"
      expr: AVG(impression_count_for_item)
    - name: "Total Redemption Count For Item"
      expr: SUM(redemption_count_for_item)
    - name: "Average Redemption Count For Item"
      expr: AVG(redemption_count_for_item)
    - name: "Total Revenue Generated For Item"
      expr: SUM(revenue_generated_for_item)
    - name: "Average Revenue Generated For Item"
      expr: AVG(revenue_generated_for_item)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_catalog_promotion_eligibility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Catalog Promotion Eligibility business metrics"
  source: "`gaming_ecm`.`licensing`.`catalog_promotion_eligibility`"
  dimensions:
    - name: "Added To Promotion Timestamp"
      expr: added_to_promotion_timestamp
    - name: "Display Order In Promotion"
      expr: display_order_in_promotion
    - name: "Eligibility Status"
      expr: eligibility_status
    - name: "Eligible Sku List"
      expr: eligible_sku_list
    - name: "Featured Flag"
      expr: featured_flag
    - name: "Promotion Priority Rank"
      expr: promotion_priority_rank
    - name: "Removed From Promotion Timestamp"
      expr: removed_from_promotion_timestamp
    - name: "Added To Promotion Timestamp Month"
      expr: DATE_TRUNC('MONTH', added_to_promotion_timestamp)
    - name: "Removed From Promotion Timestamp Month"
      expr: DATE_TRUNC('MONTH', removed_from_promotion_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Catalog Promotion Eligibility"
      expr: COUNT(DISTINCT catalog_promotion_eligibility_id)
    - name: "Total Effective Discount Percentage"
      expr: SUM(effective_discount_percentage)
    - name: "Average Effective Discount Percentage"
      expr: AVG(effective_discount_percentage)
    - name: "Total Item Specific Redemption Count"
      expr: SUM(item_specific_redemption_count)
    - name: "Average Item Specific Redemption Count"
      expr: AVG(item_specific_redemption_count)
    - name: "Total Item Specific Revenue Generated"
      expr: SUM(item_specific_revenue_generated)
    - name: "Average Item Specific Revenue Generated"
      expr: AVG(item_specific_revenue_generated)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_commercial_term`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commercial Term business metrics"
  source: "`gaming_ecm`.`licensing`.`commercial_term`"
  dimensions:
    - name: "Advance Recoupment Terms"
      expr: advance_recoupment_terms
    - name: "Audit Frequency Limit"
      expr: audit_frequency_limit
    - name: "Audit Rights Clause"
      expr: audit_rights_clause
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Derivative Works Rights"
      expr: derivative_works_rights
    - name: "Exclusivity Window Months"
      expr: exclusivity_window_months
    - name: "Indemnification Terms"
      expr: indemnification_terms
    - name: "Marketing Approval Required Flag"
      expr: marketing_approval_required_flag
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Payment Due Days"
      expr: payment_due_days
    - name: "Payment Frequency"
      expr: payment_frequency
    - name: "Performance Milestone Terms"
      expr: performance_milestone_terms
    - name: "Platform Exclusivity Flag"
      expr: platform_exclusivity_flag
    - name: "Platform Exclusivity List"
      expr: platform_exclusivity_list
    - name: "Quality Assurance Requirements"
      expr: quality_assurance_requirements
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Commercial Term"
      expr: COUNT(DISTINCT commercial_term_id)
    - name: "Total Advance Payment Amount"
      expr: SUM(advance_payment_amount)
    - name: "Average Advance Payment Amount"
      expr: AVG(advance_payment_amount)
    - name: "Total Late Payment Penalty Rate"
      expr: SUM(late_payment_penalty_rate)
    - name: "Average Late Payment Penalty Rate"
      expr: AVG(late_payment_penalty_rate)
    - name: "Total Liability Cap Amount"
      expr: SUM(liability_cap_amount)
    - name: "Average Liability Cap Amount"
      expr: AVG(liability_cap_amount)
    - name: "Total Marketing Spend Commitment Amount"
      expr: SUM(marketing_spend_commitment_amount)
    - name: "Average Marketing Spend Commitment Amount"
      expr: AVG(marketing_spend_commitment_amount)
    - name: "Total Minimum Guarantee Amount"
      expr: SUM(minimum_guarantee_amount)
    - name: "Average Minimum Guarantee Amount"
      expr: AVG(minimum_guarantee_amount)
    - name: "Total Royalty Rate Percentage"
      expr: SUM(royalty_rate_percentage)
    - name: "Average Royalty Rate Percentage"
      expr: AVG(royalty_rate_percentage)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance Obligation business metrics"
  source: "`gaming_ecm`.`licensing`.`compliance_obligation`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Audit Submission Requirement"
      expr: audit_submission_requirement
    - name: "Completion Date"
      expr: completion_date
    - name: "Content Restriction Clause"
      expr: content_restriction_clause
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Handling Requirement"
      expr: data_handling_requirement
    - name: "Drm Requirement"
      expr: drm_requirement
    - name: "Due Date"
      expr: due_date
    - name: "Effective Date"
      expr: effective_date
    - name: "Escalation Contact"
      expr: escalation_contact
    - name: "Governing Body"
      expr: governing_body
    - name: "Is Blocking Release"
      expr: is_blocking_release
    - name: "Jurisdiction"
      expr: jurisdiction
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Next Recurrence Date"
      expr: next_recurrence_date
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Compliance Obligation"
      expr: COUNT(DISTINCT compliance_obligation_id)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_economy_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Economy Config business metrics"
  source: "`gaming_ecm`.`licensing`.`economy_config`"
  dimensions:
    - name: "Ab Test Variant"
      expr: ab_test_variant
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Config Code"
      expr: config_code
    - name: "Config Name"
      expr: config_name
    - name: "Config Notes"
      expr: config_notes
    - name: "Config Status"
      expr: config_status
    - name: "Config Version"
      expr: config_version
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Expiry Days"
      expr: currency_expiry_days
    - name: "Currency Expiry Enabled"
      expr: currency_expiry_enabled
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Inflation Control Enabled"
      expr: inflation_control_enabled
    - name: "Primary Currency Code"
      expr: primary_currency_code
    - name: "Region Code"
      expr: region_code
    - name: "Secondary Currency Code"
      expr: secondary_currency_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Economy Config"
      expr: COUNT(DISTINCT economy_config_id)
    - name: "Total Base Earn Rate Primary"
      expr: SUM(base_earn_rate_primary)
    - name: "Average Base Earn Rate Primary"
      expr: AVG(base_earn_rate_primary)
    - name: "Total Base Earn Rate Secondary"
      expr: SUM(base_earn_rate_secondary)
    - name: "Average Base Earn Rate Secondary"
      expr: AVG(base_earn_rate_secondary)
    - name: "Total Conversion Fee Pct"
      expr: SUM(conversion_fee_pct)
    - name: "Average Conversion Fee Pct"
      expr: AVG(conversion_fee_pct)
    - name: "Total Daily Earn Cap Primary"
      expr: SUM(daily_earn_cap_primary)
    - name: "Average Daily Earn Cap Primary"
      expr: AVG(daily_earn_cap_primary)
    - name: "Total Daily Earn Cap Secondary"
      expr: SUM(daily_earn_cap_secondary)
    - name: "Average Daily Earn Cap Secondary"
      expr: AVG(daily_earn_cap_secondary)
    - name: "Total Deflation Threshold Pct"
      expr: SUM(deflation_threshold_pct)
    - name: "Average Deflation Threshold Pct"
      expr: AVG(deflation_threshold_pct)
    - name: "Total Economy Health Score Min"
      expr: SUM(economy_health_score_min)
    - name: "Average Economy Health Score Min"
      expr: AVG(economy_health_score_min)
    - name: "Total Economy Health Score Target"
      expr: SUM(economy_health_score_target)
    - name: "Average Economy Health Score Target"
      expr: AVG(economy_health_score_target)
    - name: "Total Exchange Rate Primary To Secondary"
      expr: SUM(exchange_rate_primary_to_secondary)
    - name: "Average Exchange Rate Primary To Secondary"
      expr: AVG(exchange_rate_primary_to_secondary)
    - name: "Total Exchange Rate Secondary To Primary"
      expr: SUM(exchange_rate_secondary_to_primary)
    - name: "Average Exchange Rate Secondary To Primary"
      expr: AVG(exchange_rate_secondary_to_primary)
    - name: "Total Inflation Threshold Pct"
      expr: SUM(inflation_threshold_pct)
    - name: "Average Inflation Threshold Pct"
      expr: AVG(inflation_threshold_pct)
    - name: "Total Max Balance Cap Primary"
      expr: SUM(max_balance_cap_primary)
    - name: "Average Max Balance Cap Primary"
      expr: AVG(max_balance_cap_primary)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Entitlement business metrics"
  source: "`gaming_ecm`.`licensing`.`entitlement`"
  dimensions:
    - name: "Activation Date"
      expr: activation_date
    - name: "Audit Frequency Limit"
      expr: audit_frequency_limit
    - name: "Authorized Distribution Channels"
      expr: authorized_distribution_channels
    - name: "Authorized Platforms"
      expr: authorized_platforms
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Compliance Audit Rights"
      expr: compliance_audit_rights
    - name: "Content Rating Requirements"
      expr: content_rating_requirements
    - name: "Covered Territories"
      expr: covered_territories
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Drm Activation Limit"
      expr: drm_activation_limit
    - name: "Drm Offline Grace Period Hours"
      expr: drm_offline_grace_period_hours
    - name: "Drm Provider"
      expr: drm_provider
    - name: "Engine Version Scope"
      expr: engine_version_scope
    - name: "Entitlement Number"
      expr: entitlement_number
    - name: "Entitlement Status"
      expr: entitlement_status
    - name: "Entitlement Type"
      expr: entitlement_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Entitlement"
      expr: COUNT(DISTINCT entitlement_id)
    - name: "Total Minimum Guarantee Amount"
      expr: SUM(minimum_guarantee_amount)
    - name: "Average Minimum Guarantee Amount"
      expr: AVG(minimum_guarantee_amount)
    - name: "Total Revenue Threshold For Royalty"
      expr: SUM(revenue_threshold_for_royalty)
    - name: "Average Revenue Threshold For Royalty"
      expr: AVG(revenue_threshold_for_royalty)
    - name: "Total Royalty Rate Percentage"
      expr: SUM(royalty_rate_percentage)
    - name: "Average Royalty Rate Percentage"
      expr: AVG(royalty_rate_percentage)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_gacha_pool`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gacha Pool business metrics"
  source: "`gaming_ecm`.`licensing`.`gacha_pool`"
  dimensions:
    - name: "Age Gate Required"
      expr: age_gate_required
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Banner Image Url"
      expr: banner_image_url
    - name: "Collaboration Partner"
      expr: collaboration_partner
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Type"
      expr: currency_type
    - name: "Duplicate Conversion Enabled"
      expr: duplicate_conversion_enabled
    - name: "Hard Pity Threshold"
      expr: hard_pity_threshold
    - name: "Max Pulls Per Player"
      expr: max_pulls_per_player
    - name: "Minimum Player Level"
      expr: minimum_player_level
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Multi Pull Quantity"
      expr: multi_pull_quantity
    - name: "Notes"
      expr: notes
    - name: "Pity Counter Shared"
      expr: pity_counter_shared
    - name: "Platform Availability"
      expr: platform_availability
    - name: "Pool Active End Timestamp"
      expr: pool_active_end_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Gacha Pool"
      expr: COUNT(DISTINCT gacha_pool_id)
    - name: "Total Base Drop Rate R"
      expr: SUM(base_drop_rate_r)
    - name: "Average Base Drop Rate R"
      expr: AVG(base_drop_rate_r)
    - name: "Total Base Drop Rate Sr"
      expr: SUM(base_drop_rate_sr)
    - name: "Average Base Drop Rate Sr"
      expr: AVG(base_drop_rate_sr)
    - name: "Total Base Drop Rate Ssr"
      expr: SUM(base_drop_rate_ssr)
    - name: "Average Base Drop Rate Ssr"
      expr: AVG(base_drop_rate_ssr)
    - name: "Total Cost Per Multi Pull"
      expr: SUM(cost_per_multi_pull)
    - name: "Average Cost Per Multi Pull"
      expr: AVG(cost_per_multi_pull)
    - name: "Total Cost Per Single Pull"
      expr: SUM(cost_per_single_pull)
    - name: "Average Cost Per Single Pull"
      expr: AVG(cost_per_single_pull)
    - name: "Total Duplicate Conversion Rate"
      expr: SUM(duplicate_conversion_rate)
    - name: "Average Duplicate Conversion Rate"
      expr: AVG(duplicate_conversion_rate)
    - name: "Total Featured Item Boost Rate"
      expr: SUM(featured_item_boost_rate)
    - name: "Average Featured Item Boost Rate"
      expr: AVG(featured_item_boost_rate)
    - name: "Total Total Pulls Lifetime"
      expr: SUM(total_pulls_lifetime)
    - name: "Average Total Pulls Lifetime"
      expr: AVG(total_pulls_lifetime)
    - name: "Total Total Revenue Lifetime"
      expr: SUM(total_revenue_lifetime)
    - name: "Average Total Revenue Lifetime"
      expr: AVG(total_revenue_lifetime)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_gacha_pull`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gacha Pull business metrics"
  source: "`gaming_ecm`.`licensing`.`gacha_pull`"
  dimensions:
    - name: "Ab Test Variant"
      expr: ab_test_variant
    - name: "Age Gate Verified Flag"
      expr: age_gate_verified_flag
    - name: "Bonus Items Granted Flag"
      expr: bonus_items_granted_flag
    - name: "Client Version"
      expr: client_version
    - name: "Currency Type"
      expr: currency_type
    - name: "Days Since Install"
      expr: days_since_install
    - name: "Device Type"
      expr: device_type
    - name: "Duplicate Flag"
      expr: duplicate_flag
    - name: "Outcome Item Quantity"
      expr: outcome_item_quantity
    - name: "Outcome Rarity Tier"
      expr: outcome_rarity_tier
    - name: "Pity Counter After"
      expr: pity_counter_after
    - name: "Pity Counter Before"
      expr: pity_counter_before
    - name: "Pity Triggered Flag"
      expr: pity_triggered_flag
    - name: "Player Level At Pull"
      expr: player_level_at_pull
    - name: "Pull Quantity"
      expr: pull_quantity
    - name: "Pull Timestamp"
      expr: pull_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Gacha Pull"
      expr: COUNT(DISTINCT gacha_pull_id)
    - name: "Total Conversion Currency Amount"
      expr: SUM(conversion_currency_amount)
    - name: "Average Conversion Currency Amount"
      expr: AVG(conversion_currency_amount)
    - name: "Total Currency Amount"
      expr: SUM(currency_amount)
    - name: "Average Currency Amount"
      expr: AVG(currency_amount)
    - name: "Total Disclosed Drop Rate Pct"
      expr: SUM(disclosed_drop_rate_pct)
    - name: "Average Disclosed Drop Rate Pct"
      expr: AVG(disclosed_drop_rate_pct)
    - name: "Total Fraud Risk Score"
      expr: SUM(fraud_risk_score)
    - name: "Average Fraud Risk Score"
      expr: AVG(fraud_risk_score)
    - name: "Total Lifetime Gacha Spend Usd"
      expr: SUM(lifetime_gacha_spend_usd)
    - name: "Average Lifetime Gacha Spend Usd"
      expr: AVG(lifetime_gacha_spend_usd)
    - name: "Total Real Money Equivalent Usd"
      expr: SUM(real_money_equivalent_usd)
    - name: "Average Real Money Equivalent Usd"
      expr: AVG(real_money_equivalent_usd)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_iap_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Iap Transaction business metrics"
  source: "`gaming_ecm`.`licensing`.`iap_transaction`"
  dimensions:
    - name: "Attribution Source"
      expr: attribution_source
    - name: "Coppa Verified"
      expr: coppa_verified
    - name: "Currency Code"
      expr: currency_code
    - name: "Device Type"
      expr: device_type
    - name: "Entitlement Granted"
      expr: entitlement_granted
    - name: "Entitlement Granted At"
      expr: entitlement_granted_at
    - name: "Is F2p Conversion"
      expr: is_f2p_conversion
    - name: "Is First Purchase"
      expr: is_first_purchase
    - name: "Is Whale"
      expr: is_whale
    - name: "Item Type"
      expr: item_type
    - name: "Loot Box Regulatory Flag"
      expr: loot_box_regulatory_flag
    - name: "Payment Method"
      expr: payment_method
    - name: "Platform"
      expr: platform
    - name: "Player Country Code"
      expr: player_country_code
    - name: "Player Level At Purchase"
      expr: player_level_at_purchase
    - name: "Purchased At"
      expr: purchased_at
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Iap Transaction"
      expr: COUNT(DISTINCT iap_transaction_id)
    - name: "Total Bonus Virtual Currency"
      expr: SUM(bonus_virtual_currency)
    - name: "Average Bonus Virtual Currency"
      expr: AVG(bonus_virtual_currency)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Discount Rate"
      expr: SUM(discount_rate)
    - name: "Average Discount Rate"
      expr: AVG(discount_rate)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Gross Amount"
      expr: SUM(gross_amount)
    - name: "Average Gross Amount"
      expr: AVG(gross_amount)
    - name: "Total Net Proceeds Amount"
      expr: SUM(net_proceeds_amount)
    - name: "Average Net Proceeds Amount"
      expr: AVG(net_proceeds_amount)
    - name: "Total Platform Fee Amount"
      expr: SUM(platform_fee_amount)
    - name: "Average Platform Fee Amount"
      expr: AVG(platform_fee_amount)
    - name: "Total Platform Fee Rate"
      expr: SUM(platform_fee_rate)
    - name: "Average Platform Fee Rate"
      expr: AVG(platform_fee_rate)
    - name: "Total Reporting Currency Amount"
      expr: SUM(reporting_currency_amount)
    - name: "Average Reporting Currency Amount"
      expr: AVG(reporting_currency_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Virtual Currency Awarded"
      expr: SUM(virtual_currency_awarded)
    - name: "Average Virtual Currency Awarded"
      expr: AVG(virtual_currency_awarded)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_ip_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ip Agreement business metrics"
  source: "`gaming_ecm`.`licensing`.`ip_agreement`"
  dimensions:
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Assigned Account Manager"
      expr: assigned_account_manager
    - name: "Brand Owner Name"
      expr: brand_owner_name
    - name: "Brand Partnership Type"
      expr: brand_partnership_type
    - name: "Brand Usage Guidelines Url"
      expr: brand_usage_guidelines_url
    - name: "Co Marketing Obligations"
      expr: co_marketing_obligations
    - name: "Compliance Rating Board Requirements"
      expr: compliance_rating_board_requirements
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Exclusivity Flag"
      expr: exclusivity_flag
    - name: "Exclusivity Scope"
      expr: exclusivity_scope
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Governing Law Jurisdiction"
      expr: governing_law_jurisdiction
    - name: "Ip Ownership Terms"
      expr: ip_ownership_terms
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ip Agreement"
      expr: COUNT(DISTINCT ip_agreement_id)
    - name: "Total Minimum Guarantee Amount"
      expr: SUM(minimum_guarantee_amount)
    - name: "Average Minimum Guarantee Amount"
      expr: AVG(minimum_guarantee_amount)
    - name: "Total Royalty Rate Percent"
      expr: SUM(royalty_rate_percent)
    - name: "Average Royalty Rate Percent"
      expr: AVG(royalty_rate_percent)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_ip_compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ip Compliance Obligation business metrics"
  source: "`gaming_ecm`.`licensing`.`ip_compliance_obligation`"
  dimensions:
    - name: "Audit Findings"
      expr: audit_findings
    - name: "Compliance Owner"
      expr: compliance_owner
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Date"
      expr: created_date
    - name: "Effective Date"
      expr: effective_date
    - name: "Exemption Expiration Date"
      expr: exemption_expiration_date
    - name: "Exemption Granted"
      expr: exemption_granted
    - name: "Implementation Deadline"
      expr: implementation_deadline
    - name: "Last Audit Date"
      expr: last_audit_date
    - name: "Last Updated Date"
      expr: last_updated_date
    - name: "Next Review Date"
      expr: next_review_date
    - name: "Remediation Plan Url"
      expr: remediation_plan_url
    - name: "Risk Level"
      expr: risk_level
    - name: "Created Date Month"
      expr: DATE_TRUNC('MONTH', created_date)
    - name: "Effective Date Month"
      expr: DATE_TRUNC('MONTH', effective_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ip Compliance Obligation"
      expr: COUNT(DISTINCT ip_compliance_obligation_id)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_ip_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ip Dispute business metrics"
  source: "`gaming_ecm`.`licensing`.`ip_dispute`"
  dimensions:
    - name: "Alleged Violation Date"
      expr: alleged_violation_date
    - name: "Claimant Legal Counsel"
      expr: claimant_legal_counsel
    - name: "Claimant Name"
      expr: claimant_name
    - name: "Confidentiality Flag"
      expr: confidentiality_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Description"
      expr: dispute_description
    - name: "Dispute Number"
      expr: dispute_number
    - name: "Dispute Status"
      expr: dispute_status
    - name: "Dispute Type"
      expr: dispute_type
    - name: "Disputed Ip Asset Name"
      expr: disputed_ip_asset_name
    - name: "Document Repository Url"
      expr: document_repository_url
    - name: "Filing Date"
      expr: filing_date
    - name: "Internal Notes"
      expr: internal_notes
    - name: "Jurisdiction"
      expr: jurisdiction
    - name: "Litigation Start Date"
      expr: litigation_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ip Dispute"
      expr: COUNT(DISTINCT ip_dispute_id)
    - name: "Total Actual Legal Cost"
      expr: SUM(actual_legal_cost)
    - name: "Average Actual Legal Cost"
      expr: AVG(actual_legal_cost)
    - name: "Total Claim Amount"
      expr: SUM(claim_amount)
    - name: "Average Claim Amount"
      expr: AVG(claim_amount)
    - name: "Total Estimated Legal Cost"
      expr: SUM(estimated_legal_cost)
    - name: "Average Estimated Legal Cost"
      expr: AVG(estimated_legal_cost)
    - name: "Total Settlement Amount"
      expr: SUM(settlement_amount)
    - name: "Average Settlement Amount"
      expr: AVG(settlement_amount)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_licensed_ip`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Licensed Ip business metrics"
  source: "`gaming_ecm`.`licensing`.`licensed_ip`"
  dimensions:
    - name: "Active License Count"
      expr: active_license_count
    - name: "Asset Thumbnail Url"
      expr: asset_thumbnail_url
    - name: "Cero Rating"
      expr: cero_rating
    - name: "Content Descriptors"
      expr: content_descriptors
    - name: "Coppa Compliant"
      expr: coppa_compliant
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Documentation Url"
      expr: documentation_url
    - name: "Drm Protection Enabled"
      expr: drm_protection_enabled
    - name: "Esrb Rating"
      expr: esrb_rating
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Gdpr Compliant"
      expr: gdpr_compliant
    - name: "Grac Rating"
      expr: grac_rating
    - name: "Ip Category"
      expr: ip_category
    - name: "Ip Code"
      expr: ip_code
    - name: "Ip Description"
      expr: ip_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Licensed Ip"
      expr: COUNT(DISTINCT licensed_ip_id)
    - name: "Total Minimum Guarantee Amount"
      expr: SUM(minimum_guarantee_amount)
    - name: "Average Minimum Guarantee Amount"
      expr: AVG(minimum_guarantee_amount)
    - name: "Total Standard Royalty Rate"
      expr: SUM(standard_royalty_rate)
    - name: "Average Standard Royalty Rate"
      expr: AVG(standard_royalty_rate)
    - name: "Total Total Revenue To Date"
      expr: SUM(total_revenue_to_date)
    - name: "Average Total Revenue To Date"
      expr: AVG(total_revenue_to_date)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_licensee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Licensee business metrics"
  source: "`gaming_ecm`.`licensing`.`licensee`"
  dimensions:
    - name: "Annual Revenue Range"
      expr: annual_revenue_range
    - name: "Compliance Tier"
      expr: compliance_tier
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Rating"
      expr: credit_rating
    - name: "Doing Business As Name"
      expr: doing_business_as_name
    - name: "Duns Number"
      expr: duns_number
    - name: "Employee Count Range"
      expr: employee_count_range
    - name: "Entity Type"
      expr: entity_type
    - name: "First Contract Date"
      expr: first_contract_date
    - name: "Headquarters Address Line1"
      expr: headquarters_address_line1
    - name: "Headquarters Address Line2"
      expr: headquarters_address_line2
    - name: "Headquarters City"
      expr: headquarters_city
    - name: "Headquarters Country Code"
      expr: headquarters_country_code
    - name: "Headquarters Postal Code"
      expr: headquarters_postal_code
    - name: "Headquarters State Province"
      expr: headquarters_state_province
    - name: "Is Publicly Traded"
      expr: is_publicly_traded
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Licensee"
      expr: COUNT(DISTINCT licensee_id)
    - name: "Total Credit Limit Amount"
      expr: SUM(credit_limit_amount)
    - name: "Average Credit Limit Amount"
      expr: AVG(credit_limit_amount)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_middleware_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Middleware Agreement business metrics"
  source: "`gaming_ecm`.`licensing`.`middleware_agreement`"
  dimensions:
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Attribution Required Flag"
      expr: attribution_required_flag
    - name: "Audit Rights"
      expr: audit_rights
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Compliance Obligations"
      expr: compliance_obligations
    - name: "Contract Document Reference"
      expr: contract_document_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Governing Law Jurisdiction"
      expr: governing_law_jurisdiction
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "License Type"
      expr: license_type
    - name: "Notes"
      expr: notes
    - name: "Notice Period Days"
      expr: notice_period_days
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Middleware Agreement"
      expr: COUNT(DISTINCT middleware_agreement_id)
    - name: "Total Fixed License Fee"
      expr: SUM(fixed_license_fee)
    - name: "Average Fixed License Fee"
      expr: AVG(fixed_license_fee)
    - name: "Total Revenue Share Percentage"
      expr: SUM(revenue_share_percentage)
    - name: "Average Revenue Share Percentage"
      expr: AVG(revenue_share_percentage)
    - name: "Total Revenue Threshold Amount"
      expr: SUM(revenue_threshold_amount)
    - name: "Average Revenue Threshold Amount"
      expr: AVG(revenue_threshold_amount)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_mtx_catalog`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mtx Catalog business metrics"
  source: "`gaming_ecm`.`licensing`.`mtx_catalog`"
  dimensions:
    - name: "Age Restriction Minimum"
      expr: age_restriction_minimum
    - name: "Bundle Parent Sku Code"
      expr: bundle_parent_sku_code
    - name: "Content Rating Esrb"
      expr: content_rating_esrb
    - name: "Content Rating Pegi"
      expr: content_rating_pegi
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Rounding Policy"
      expr: currency_rounding_policy
    - name: "Drm Protection Type"
      expr: drm_protection_type
    - name: "Drop Rate Disclosed"
      expr: drop_rate_disclosed
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective Until Date"
      expr: effective_until_date
    - name: "Image Asset Path"
      expr: image_asset_path
    - name: "Internal Notes"
      expr: internal_notes
    - name: "Is Giftable"
      expr: is_giftable
    - name: "Is Promo Code Redeemable"
      expr: is_promo_code_redeemable
    - name: "Is Sale Eligible"
      expr: is_sale_eligible
    - name: "Item Description"
      expr: item_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Mtx Catalog"
      expr: COUNT(DISTINCT mtx_catalog_id)
    - name: "Total Base Price Usd"
      expr: SUM(base_price_usd)
    - name: "Average Base Price Usd"
      expr: AVG(base_price_usd)
    - name: "Total Platform Fee Pct"
      expr: SUM(platform_fee_pct)
    - name: "Average Platform Fee Pct"
      expr: AVG(platform_fee_pct)
    - name: "Total Price Eur"
      expr: SUM(price_eur)
    - name: "Average Price Eur"
      expr: AVG(price_eur)
    - name: "Total Price Gbp"
      expr: SUM(price_gbp)
    - name: "Average Price Gbp"
      expr: AVG(price_gbp)
    - name: "Total Price Jpy"
      expr: SUM(price_jpy)
    - name: "Average Price Jpy"
      expr: AVG(price_jpy)
    - name: "Total Price Krw"
      expr: SUM(price_krw)
    - name: "Average Price Krw"
      expr: AVG(price_krw)
    - name: "Total Promo Discount Pct"
      expr: SUM(promo_discount_pct)
    - name: "Average Promo Discount Pct"
      expr: AVG(promo_discount_pct)
    - name: "Total Virtual Currency Cost"
      expr: SUM(virtual_currency_cost)
    - name: "Average Virtual Currency Cost"
      expr: AVG(virtual_currency_cost)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_music_sync_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Music Sync License business metrics"
  source: "`gaming_ecm`.`licensing`.`music_sync_license`"
  dimensions:
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Composer Name"
      expr: composer_name
    - name: "Composition Rights Status"
      expr: composition_rights_status
    - name: "Content Rating Restrictions"
      expr: content_rating_restrictions
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Attribution Required"
      expr: credit_attribution_required
    - name: "Currency Code"
      expr: currency_code
    - name: "Derivative Works Allowed Flag"
      expr: derivative_works_allowed_flag
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Exclusivity Flag"
      expr: exclusivity_flag
    - name: "Isrc Code"
      expr: isrc_code
    - name: "Iswc Code"
      expr: iswc_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "License Number"
      expr: license_number
    - name: "License Status"
      expr: license_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Music Sync License"
      expr: COUNT(DISTINCT music_sync_license_id)
    - name: "Total Flat Fee Amount"
      expr: SUM(flat_fee_amount)
    - name: "Average Flat Fee Amount"
      expr: AVG(flat_fee_amount)
    - name: "Total Minimum Guarantee Amount"
      expr: SUM(minimum_guarantee_amount)
    - name: "Average Minimum Guarantee Amount"
      expr: AVG(minimum_guarantee_amount)
    - name: "Total Per Unit Royalty Rate"
      expr: SUM(per_unit_royalty_rate)
    - name: "Average Per Unit Royalty Rate"
      expr: AVG(per_unit_royalty_rate)
    - name: "Total Revenue Share Percentage"
      expr: SUM(revenue_share_percentage)
    - name: "Average Revenue Share Percentage"
      expr: AVG(revenue_share_percentage)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_offer_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Offer Campaign business metrics"
  source: "`gaming_ecm`.`licensing`.`offer_campaign`"
  dimensions:
    - name: "Ab Test Variant"
      expr: ab_test_variant
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Campaign Code"
      expr: campaign_code
    - name: "Campaign End Timestamp"
      expr: campaign_end_timestamp
    - name: "Campaign Name"
      expr: campaign_name
    - name: "Campaign Notes"
      expr: campaign_notes
    - name: "Campaign Start Timestamp"
      expr: campaign_start_timestamp
    - name: "Campaign Status"
      expr: campaign_status
    - name: "Compliance Notes"
      expr: compliance_notes
    - name: "Compliance Review Status"
      expr: compliance_review_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Discount Type"
      expr: discount_type
    - name: "Display Image Url"
      expr: display_image_url
    - name: "Eligible Sku List"
      expr: eligible_sku_list
    - name: "Geo Restriction List"
      expr: geo_restriction_list
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Offer Campaign"
      expr: COUNT(DISTINCT offer_campaign_id)
    - name: "Total Campaign Budget"
      expr: SUM(campaign_budget)
    - name: "Average Campaign Budget"
      expr: AVG(campaign_budget)
    - name: "Total Conversion Rate"
      expr: SUM(conversion_rate)
    - name: "Average Conversion Rate"
      expr: AVG(conversion_rate)
    - name: "Total Discount Value"
      expr: SUM(discount_value)
    - name: "Average Discount Value"
      expr: AVG(discount_value)
    - name: "Total Target Ltv Min"
      expr: SUM(target_ltv_min)
    - name: "Average Target Ltv Min"
      expr: AVG(target_ltv_min)
    - name: "Total Total Impressions"
      expr: SUM(total_impressions)
    - name: "Average Total Impressions"
      expr: AVG(total_impressions)
    - name: "Total Total Redemptions"
      expr: SUM(total_redemptions)
    - name: "Average Total Redemptions"
      expr: AVG(total_redemptions)
    - name: "Total Total Revenue Generated"
      expr: SUM(total_revenue_generated)
    - name: "Average Total Revenue Generated"
      expr: AVG(total_revenue_generated)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion business metrics"
  source: "`gaming_ecm`.`licensing`.`promotion`"
  dimensions:
    - name: "Ab Test Variant"
      expr: ab_test_variant
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Banner Image Url"
      expr: banner_image_url
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Discount Type"
      expr: discount_type
    - name: "Display Priority"
      expr: display_priority
    - name: "End Timestamp"
      expr: end_timestamp
    - name: "Geographic Restriction"
      expr: geographic_restriction
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Platform Availability"
      expr: platform_availability
    - name: "Promotion Code"
      expr: promotion_code
    - name: "Promotion Name"
      expr: promotion_name
    - name: "Promotion Status"
      expr: promotion_status
    - name: "Promotion Type"
      expr: promotion_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promotion"
      expr: COUNT(DISTINCT promotion_id)
    - name: "Total Conversion Rate"
      expr: SUM(conversion_rate)
    - name: "Average Conversion Rate"
      expr: AVG(conversion_rate)
    - name: "Total Discount Value"
      expr: SUM(discount_value)
    - name: "Average Discount Value"
      expr: AVG(discount_value)
    - name: "Total Max Discount Amount"
      expr: SUM(max_discount_amount)
    - name: "Average Max Discount Amount"
      expr: AVG(max_discount_amount)
    - name: "Total Min Purchase Amount"
      expr: SUM(min_purchase_amount)
    - name: "Average Min Purchase Amount"
      expr: AVG(min_purchase_amount)
    - name: "Total Total Discount Given"
      expr: SUM(total_discount_given)
    - name: "Average Total Discount Given"
      expr: AVG(total_discount_given)
    - name: "Total Total Impressions"
      expr: SUM(total_impressions)
    - name: "Average Total Impressions"
      expr: AVG(total_impressions)
    - name: "Total Total Redemptions"
      expr: SUM(total_redemptions)
    - name: "Average Total Redemptions"
      expr: AVG(total_redemptions)
    - name: "Total Total Revenue Generated"
      expr: SUM(total_revenue_generated)
    - name: "Average Total Revenue Generated"
      expr: AVG(total_revenue_generated)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_rating_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rating Submission business metrics"
  source: "`gaming_ecm`.`licensing`.`rating_submission`"
  dimensions:
    - name: "Appeal Filed"
      expr: appeal_filed
    - name: "Appeal Outcome"
      expr: appeal_outcome
    - name: "Assigned Rating"
      expr: assigned_rating
    - name: "Compliance Notes"
      expr: compliance_notes
    - name: "Content Descriptors"
      expr: content_descriptors
    - name: "Content Modifications Required"
      expr: content_modifications_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Developer Name"
      expr: developer_name
    - name: "Expected Release Date"
      expr: expected_release_date
    - name: "Interactive Elements"
      expr: interactive_elements
    - name: "Ip Ownership Confirmed"
      expr: ip_ownership_confirmed
    - name: "Modification Compliance Date"
      expr: modification_compliance_date
    - name: "Modification Description"
      expr: modification_description
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Payment Date"
      expr: payment_date
    - name: "Payment Status"
      expr: payment_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rating Submission"
      expr: COUNT(DISTINCT rating_submission_id)
    - name: "Total Submission Fee Amount"
      expr: SUM(submission_fee_amount)
    - name: "Average Submission Fee Amount"
      expr: AVG(submission_fee_amount)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_royalty_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Royalty Payment business metrics"
  source: "`gaming_ecm`.`licensing`.`royalty_payment`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Bank Reference"
      expr: bank_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Late Payment Flag"
      expr: late_payment_flag
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Payee Identifier"
      expr: payee_identifier
    - name: "Payment Currency"
      expr: payment_currency
    - name: "Payment Date"
      expr: payment_date
    - name: "Payment Direction"
      expr: payment_direction
    - name: "Payment Due Date"
      expr: payment_due_date
    - name: "Payment Method"
      expr: payment_method
    - name: "Payment Notes"
      expr: payment_notes
    - name: "Payment Period End Date"
      expr: payment_period_end_date
    - name: "Payment Period Start Date"
      expr: payment_period_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Royalty Payment"
      expr: COUNT(DISTINCT royalty_payment_id)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Late Payment Penalty Amount"
      expr: SUM(late_payment_penalty_amount)
    - name: "Average Late Payment Penalty Amount"
      expr: AVG(late_payment_penalty_amount)
    - name: "Total Net Payment Amount"
      expr: SUM(net_payment_amount)
    - name: "Average Net Payment Amount"
      expr: AVG(net_payment_amount)
    - name: "Total Payment Amount"
      expr: SUM(payment_amount)
    - name: "Average Payment Amount"
      expr: AVG(payment_amount)
    - name: "Total Payment Amount Reporting Currency"
      expr: SUM(payment_amount_reporting_currency)
    - name: "Average Payment Amount Reporting Currency"
      expr: AVG(payment_amount_reporting_currency)
    - name: "Total Payment Processor Fee"
      expr: SUM(payment_processor_fee)
    - name: "Average Payment Processor Fee"
      expr: AVG(payment_processor_fee)
    - name: "Total Reconciliation Variance Amount"
      expr: SUM(reconciliation_variance_amount)
    - name: "Average Reconciliation Variance Amount"
      expr: AVG(reconciliation_variance_amount)
    - name: "Total Withholding Tax Amount"
      expr: SUM(withholding_tax_amount)
    - name: "Average Withholding Tax Amount"
      expr: AVG(withholding_tax_amount)
    - name: "Total Withholding Tax Rate"
      expr: SUM(withholding_tax_rate)
    - name: "Average Withholding Tax Rate"
      expr: AVG(withholding_tax_rate)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_royalty_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Royalty Report business metrics"
  source: "`gaming_ecm`.`licensing`.`royalty_report`"
  dimensions:
    - name: "Attachment Url"
      expr: attachment_url
    - name: "Audit Flag"
      expr: audit_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Reason"
      expr: dispute_reason
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Payment Due Date"
      expr: payment_due_date
    - name: "Platform"
      expr: platform
    - name: "Report Number"
      expr: report_number
    - name: "Report Status"
      expr: report_status
    - name: "Report Type"
      expr: report_type
    - name: "Reporting Period End Date"
      expr: reporting_period_end_date
    - name: "Reporting Period Start Date"
      expr: reporting_period_start_date
    - name: "Review Completed Date"
      expr: review_completed_date
    - name: "Submission Date"
      expr: submission_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Royalty Report"
      expr: COUNT(DISTINCT royalty_report_id)
    - name: "Total Applicable Royalty Rate"
      expr: SUM(applicable_royalty_rate)
    - name: "Average Applicable Royalty Rate"
      expr: AVG(applicable_royalty_rate)
    - name: "Total Calculated Royalty Amount"
      expr: SUM(calculated_royalty_amount)
    - name: "Average Calculated Royalty Amount"
      expr: AVG(calculated_royalty_amount)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Minimum Guarantee Credit"
      expr: SUM(minimum_guarantee_credit)
    - name: "Average Minimum Guarantee Credit"
      expr: AVG(minimum_guarantee_credit)
    - name: "Total Net Royalty Payable"
      expr: SUM(net_royalty_payable)
    - name: "Average Net Royalty Payable"
      expr: AVG(net_royalty_payable)
    - name: "Total Reported Deductions"
      expr: SUM(reported_deductions)
    - name: "Average Reported Deductions"
      expr: AVG(reported_deductions)
    - name: "Total Reported Gross Revenue"
      expr: SUM(reported_gross_revenue)
    - name: "Average Reported Gross Revenue"
      expr: AVG(reported_gross_revenue)
    - name: "Total Reported Net Revenue"
      expr: SUM(reported_net_revenue)
    - name: "Average Reported Net Revenue"
      expr: AVG(reported_net_revenue)
    - name: "Total Reported Unit Sales"
      expr: SUM(reported_unit_sales)
    - name: "Average Reported Unit Sales"
      expr: AVG(reported_unit_sales)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_royalty_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Royalty Schedule business metrics"
  source: "`gaming_ecm`.`licensing`.`royalty_schedule`"
  dimensions:
    - name: "Audit Frequency Months"
      expr: audit_frequency_months
    - name: "Audit Required Flag"
      expr: audit_required_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Exclusivity Flag"
      expr: exclusivity_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Payment Due Days"
      expr: payment_due_days
    - name: "Platform Deduction Rule"
      expr: platform_deduction_rule
    - name: "Platform Scope"
      expr: platform_scope
    - name: "Product Scope"
      expr: product_scope
    - name: "Rate Structure"
      expr: rate_structure
    - name: "Recoupment Allowed Flag"
      expr: recoupment_allowed_flag
    - name: "Reporting Period Cadence"
      expr: reporting_period_cadence
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Royalty Schedule"
      expr: COUNT(DISTINCT royalty_schedule_id)
    - name: "Total Base Rate Percentage"
      expr: SUM(base_rate_percentage)
    - name: "Average Base Rate Percentage"
      expr: AVG(base_rate_percentage)
    - name: "Total Late Payment Penalty Rate"
      expr: SUM(late_payment_penalty_rate)
    - name: "Average Late Payment Penalty Rate"
      expr: AVG(late_payment_penalty_rate)
    - name: "Total Maximum Cap Amount"
      expr: SUM(maximum_cap_amount)
    - name: "Average Maximum Cap Amount"
      expr: AVG(maximum_cap_amount)
    - name: "Total Minimum Guarantee Amount"
      expr: SUM(minimum_guarantee_amount)
    - name: "Average Minimum Guarantee Amount"
      expr: AVG(minimum_guarantee_amount)
    - name: "Total Tier 1 Rate Percentage"
      expr: SUM(tier_1_rate_percentage)
    - name: "Average Tier 1 Rate Percentage"
      expr: AVG(tier_1_rate_percentage)
    - name: "Total Tier 1 Threshold"
      expr: SUM(tier_1_threshold)
    - name: "Average Tier 1 Threshold"
      expr: AVG(tier_1_threshold)
    - name: "Total Tier 2 Rate Percentage"
      expr: SUM(tier_2_rate_percentage)
    - name: "Average Tier 2 Rate Percentage"
      expr: AVG(tier_2_rate_percentage)
    - name: "Total Tier 2 Threshold"
      expr: SUM(tier_2_threshold)
    - name: "Average Tier 2 Threshold"
      expr: AVG(tier_2_threshold)
    - name: "Total Tier 3 Rate Percentage"
      expr: SUM(tier_3_rate_percentage)
    - name: "Average Tier 3 Rate Percentage"
      expr: AVG(tier_3_rate_percentage)
    - name: "Total Tier 3 Threshold"
      expr: SUM(tier_3_threshold)
    - name: "Average Tier 3 Threshold"
      expr: AVG(tier_3_threshold)
    - name: "Total Withholding Tax Rate Percentage"
      expr: SUM(withholding_tax_rate_percentage)
    - name: "Average Withholding Tax Rate Percentage"
      expr: AVG(withholding_tax_rate_percentage)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_sublicense`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sublicense business metrics"
  source: "`gaming_ecm`.`licensing`.`sublicense`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Audit Rights Flag"
      expr: audit_rights_flag
    - name: "Compliance Monitoring Required Flag"
      expr: compliance_monitoring_required_flag
    - name: "Contract Document Reference"
      expr: contract_document_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Exclusivity Flag"
      expr: exclusivity_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Modification Rights"
      expr: modification_rights
    - name: "Notes"
      expr: notes
    - name: "Payment Frequency"
      expr: payment_frequency
    - name: "Platform Scope"
      expr: platform_scope
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sublicense"
      expr: COUNT(DISTINCT sublicense_id)
    - name: "Total Fixed Fee Amount"
      expr: SUM(fixed_fee_amount)
    - name: "Average Fixed Fee Amount"
      expr: AVG(fixed_fee_amount)
    - name: "Total Minimum Guarantee Amount"
      expr: SUM(minimum_guarantee_amount)
    - name: "Average Minimum Guarantee Amount"
      expr: AVG(minimum_guarantee_amount)
    - name: "Total Pass Through Royalty Rate Percentage"
      expr: SUM(pass_through_royalty_rate_percentage)
    - name: "Average Pass Through Royalty Rate Percentage"
      expr: AVG(pass_through_royalty_rate_percentage)
    - name: "Total Sublicensee Royalty Rate Percentage"
      expr: SUM(sublicensee_royalty_rate_percentage)
    - name: "Average Sublicensee Royalty Rate Percentage"
      expr: AVG(sublicensee_royalty_rate_percentage)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_team_brand_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Team Brand License business metrics"
  source: "`gaming_ecm`.`licensing`.`team_brand_license`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Contract Reference Code"
      expr: contract_reference_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Exclusivity Flag"
      expr: exclusivity_flag
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Licensing End Date"
      expr: licensing_end_date
    - name: "Licensing Start Date"
      expr: licensing_start_date
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Last Updated Timestamp Month"
      expr: DATE_TRUNC('MONTH', last_updated_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Team Brand License"
      expr: COUNT(DISTINCT team_brand_license_id)
    - name: "Total Revenue Share Amount"
      expr: SUM(revenue_share_amount)
    - name: "Average Revenue Share Amount"
      expr: AVG(revenue_share_amount)
    - name: "Total Royalty Percentage"
      expr: SUM(royalty_percentage)
    - name: "Average Royalty Percentage"
      expr: AVG(royalty_percentage)
    - name: "Total Sales Count"
      expr: SUM(sales_count)
    - name: "Average Sales Count"
      expr: AVG(sales_count)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_usage_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Usage Report business metrics"
  source: "`gaming_ecm`.`licensing`.`usage_report`"
  dimensions:
    - name: "Audit Required Flag"
      expr: audit_required_flag
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Name"
      expr: contact_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dispute Date"
      expr: dispute_date
    - name: "Dispute Reason"
      expr: dispute_reason
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Metric Type"
      expr: metric_type
    - name: "Notes"
      expr: notes
    - name: "Platform"
      expr: platform
    - name: "Report Number"
      expr: report_number
    - name: "Report Status"
      expr: report_status
    - name: "Report Type"
      expr: report_type
    - name: "Reporting Period End"
      expr: reporting_period_end
    - name: "Reporting Period Start"
      expr: reporting_period_start
    - name: "Resolution Date"
      expr: resolution_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Usage Report"
      expr: COUNT(DISTINCT usage_report_id)
    - name: "Total Expected Value"
      expr: SUM(expected_value)
    - name: "Average Expected Value"
      expr: AVG(expected_value)
    - name: "Total Prior Period Value"
      expr: SUM(prior_period_value)
    - name: "Average Prior Period Value"
      expr: AVG(prior_period_value)
    - name: "Total Reported Value"
      expr: SUM(reported_value)
    - name: "Average Reported Value"
      expr: AVG(reported_value)
    - name: "Total Variance Percentage"
      expr: SUM(variance_percentage)
    - name: "Average Variance Percentage"
      expr: AVG(variance_percentage)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_virtual_currency_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Virtual Currency Account business metrics"
  source: "`gaming_ecm`.`licensing`.`virtual_currency_account`"
  dimensions:
    - name: "Account Close Date"
      expr: account_close_date
    - name: "Account Code"
      expr: account_code
    - name: "Account Open Date"
      expr: account_open_date
    - name: "Account Status"
      expr: account_status
    - name: "Balance Expiry Date"
      expr: balance_expiry_date
    - name: "Conversion Status"
      expr: conversion_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Currency Name"
      expr: currency_name
    - name: "Currency Type"
      expr: currency_type
    - name: "Data Residency Region"
      expr: data_residency_region
    - name: "First Purchase Date"
      expr: first_purchase_date
    - name: "Fraud Flag"
      expr: fraud_flag
    - name: "Gdpr Erasure Requested"
      expr: gdpr_erasure_requested
    - name: "Is Purchasable"
      expr: is_purchasable
    - name: "Is Refundable"
      expr: is_refundable
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Virtual Currency Account"
      expr: COUNT(DISTINCT virtual_currency_account_id)
    - name: "Total Current Balance"
      expr: SUM(current_balance)
    - name: "Average Current Balance"
      expr: AVG(current_balance)
    - name: "Total Earn Cap Daily"
      expr: SUM(earn_cap_daily)
    - name: "Average Earn Cap Daily"
      expr: AVG(earn_cap_daily)
    - name: "Total Fraud Risk Score"
      expr: SUM(fraud_risk_score)
    - name: "Average Fraud Risk Score"
      expr: AVG(fraud_risk_score)
    - name: "Total Lifetime Earned"
      expr: SUM(lifetime_earned)
    - name: "Average Lifetime Earned"
      expr: AVG(lifetime_earned)
    - name: "Total Lifetime Spent"
      expr: SUM(lifetime_spent)
    - name: "Average Lifetime Spent"
      expr: AVG(lifetime_spent)
    - name: "Total Max Balance Cap"
      expr: SUM(max_balance_cap)
    - name: "Average Max Balance Cap"
      expr: AVG(max_balance_cap)
    - name: "Total Pending Balance"
      expr: SUM(pending_balance)
    - name: "Average Pending Balance"
      expr: AVG(pending_balance)
    - name: "Total Reserved Balance"
      expr: SUM(reserved_balance)
    - name: "Average Reserved Balance"
      expr: AVG(reserved_balance)
    - name: "Total Spend Cap Daily"
      expr: SUM(spend_cap_daily)
    - name: "Average Spend Cap Daily"
      expr: AVG(spend_cap_daily)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_virtual_currency_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Virtual Currency Ledger business metrics"
  source: "`gaming_ecm`.`licensing`.`virtual_currency_ledger`"
  dimensions:
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Currency Name"
      expr: currency_name
    - name: "Currency Type"
      expr: currency_type
    - name: "Data Source System"
      expr: data_source_system
    - name: "Device Type"
      expr: device_type
    - name: "Entry Reference Code"
      expr: entry_reference_code
    - name: "Entry Type"
      expr: entry_type
    - name: "Expiry Timestamp"
      expr: expiry_timestamp
    - name: "Fraud Flag"
      expr: fraud_flag
    - name: "Fraud Review Status"
      expr: fraud_review_status
    - name: "Is First Purchase"
      expr: is_first_purchase
    - name: "Is Reversal"
      expr: is_reversal
    - name: "Ledger Entry Status"
      expr: ledger_entry_status
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Virtual Currency Ledger"
      expr: COUNT(DISTINCT virtual_currency_ledger_id)
    - name: "Total Balance After"
      expr: SUM(balance_after)
    - name: "Average Balance After"
      expr: AVG(balance_after)
    - name: "Total Balance Before"
      expr: SUM(balance_before)
    - name: "Average Balance Before"
      expr: AVG(balance_before)
    - name: "Total Bonus Amount"
      expr: SUM(bonus_amount)
    - name: "Average Bonus Amount"
      expr: AVG(bonus_amount)
    - name: "Total Delta Amount"
      expr: SUM(delta_amount)
    - name: "Average Delta Amount"
      expr: AVG(delta_amount)
    - name: "Total Exchange Rate To Usd"
      expr: SUM(exchange_rate_to_usd)
    - name: "Average Exchange Rate To Usd"
      expr: AVG(exchange_rate_to_usd)
    - name: "Total Real Money Amount"
      expr: SUM(real_money_amount)
    - name: "Average Real Money Amount"
      expr: AVG(real_money_amount)
    - name: "Total Virtual To Real Ratio"
      expr: SUM(virtual_to_real_ratio)
    - name: "Average Virtual To Real Ratio"
      expr: AVG(virtual_to_real_ratio)
$$;