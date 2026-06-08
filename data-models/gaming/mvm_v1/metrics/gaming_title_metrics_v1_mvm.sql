-- Metric views for domain: title | Business: Gaming | Version: 1 | Generated on: 2026-05-08 09:44:24

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`title_achievement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Achievement business metrics"
  source: "`gaming_ecm`.`title`.`achievement`"
  dimensions:
    - name: "Achievement Code"
      expr: achievement_code
    - name: "Achievement Name"
      expr: achievement_name
    - name: "Achievement Status"
      expr: achievement_status
    - name: "Achievement Type"
      expr: achievement_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deprecation Date"
      expr: deprecation_date
    - name: "Description Long"
      expr: description_long
    - name: "Description Short"
      expr: description_short
    - name: "Display Order"
      expr: display_order
    - name: "Epic Achievement Code"
      expr: epic_achievement_code
    - name: "Is Hidden"
      expr: is_hidden
    - name: "Is Platinum Trophy"
      expr: is_platinum_trophy
    - name: "Is Secret"
      expr: is_secret
    - name: "Is Time Limited"
      expr: is_time_limited
    - name: "Localization Required"
      expr: localization_required
    - name: "Platform Availability"
      expr: platform_availability
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Achievement"
      expr: COUNT(DISTINCT achievement_id)
    - name: "Total Unlock Percentage"
      expr: SUM(unlock_percentage)
    - name: "Average Unlock Percentage"
      expr: AVG(unlock_percentage)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`title_build_artifact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Build Artifact business metrics"
  source: "`gaming_ecm`.`title`.`build_artifact`"
  dimensions:
    - name: "Anti Cheat Version"
      expr: anti_cheat_version
    - name: "Build Timestamp"
      expr: build_timestamp
    - name: "Build Type"
      expr: build_type
    - name: "Cert Approved Timestamp"
      expr: cert_approved_timestamp
    - name: "Certification Status"
      expr: certification_status
    - name: "Checksum Sha256"
      expr: checksum_sha256
    - name: "Content Rating"
      expr: content_rating
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deployed Timestamp"
      expr: deployed_timestamp
    - name: "Deployment Status"
      expr: deployment_status
    - name: "Deprecated Timestamp"
      expr: deprecated_timestamp
    - name: "Drm Enabled"
      expr: drm_enabled
    - name: "Includes Mtx"
      expr: includes_mtx
    - name: "Includes Ugc"
      expr: includes_ugc
    - name: "Internal Notes"
      expr: internal_notes
    - name: "Is Mandatory Update"
      expr: is_mandatory_update
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Build Artifact"
      expr: COUNT(DISTINCT build_artifact_id)
    - name: "Total Binary Size Mb"
      expr: SUM(binary_size_mb)
    - name: "Average Binary Size Mb"
      expr: AVG(binary_size_mb)
    - name: "Total Delta Patch Size Mb"
      expr: SUM(delta_patch_size_mb)
    - name: "Average Delta Patch Size Mb"
      expr: AVG(delta_patch_size_mb)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`title_content_rating`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content Rating business metrics"
  source: "`gaming_ecm`.`title`.`content_rating`"
  dimensions:
    - name: "Appeal Date"
      expr: appeal_date
    - name: "Appeal Resolution Date"
      expr: appeal_resolution_date
    - name: "Appeal Status"
      expr: appeal_status
    - name: "Certification Date"
      expr: certification_date
    - name: "Certification Number"
      expr: certification_number
    - name: "Compliance Officer"
      expr: compliance_officer
    - name: "Content Descriptors"
      expr: content_descriptors
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Digital Certificate Url"
      expr: digital_certificate_url
    - name: "Expiration Date"
      expr: expiration_date
    - name: "In Game Purchases Flag"
      expr: in_game_purchases_flag
    - name: "Interactive Elements"
      expr: interactive_elements
    - name: "Is Active"
      expr: is_active
    - name: "Loot Box Disclosure"
      expr: loot_box_disclosure
    - name: "Online Notice Required"
      expr: online_notice_required
    - name: "Platform Scope"
      expr: platform_scope
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Content Rating"
      expr: COUNT(DISTINCT content_rating_id)
    - name: "Total Rating Fee Amount"
      expr: SUM(rating_fee_amount)
    - name: "Average Rating Fee Amount"
      expr: AVG(rating_fee_amount)
    - name: "Total Rating Value"
      expr: SUM(rating_value)
    - name: "Average Rating Value"
      expr: AVG(rating_value)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`title_dlc_bundle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dlc Bundle business metrics"
  source: "`gaming_ecm`.`title`.`dlc_bundle`"
  dimensions:
    - name: "Battle Pass Tier"
      expr: battle_pass_tier
    - name: "Bundle Code"
      expr: bundle_code
    - name: "Bundle Name"
      expr: bundle_name
    - name: "Bundle Status"
      expr: bundle_status
    - name: "Certification Date"
      expr: certification_date
    - name: "Certification Status"
      expr: certification_status
    - name: "Content Descriptors"
      expr: content_descriptors
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Description Long"
      expr: description_long
    - name: "Description Short"
      expr: description_short
    - name: "Developer Notes"
      expr: developer_notes
    - name: "Dlc Type"
      expr: dlc_type
    - name: "End Of Sale Date"
      expr: end_of_sale_date
    - name: "Entitlement Count"
      expr: entitlement_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dlc Bundle"
      expr: COUNT(DISTINCT dlc_bundle_id)
    - name: "Total Base Price Usd"
      expr: SUM(base_price_usd)
    - name: "Average Base Price Usd"
      expr: AVG(base_price_usd)
    - name: "Total File Size Mb"
      expr: SUM(file_size_mb)
    - name: "Average File Size Mb"
      expr: AVG(file_size_mb)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`title_edition_content_inclusion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Edition Content Inclusion business metrics"
  source: "`gaming_ecm`.`title`.`edition_content_inclusion`"
  dimensions:
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Display Order"
      expr: display_order
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Included In Edition"
      expr: included_in_edition
    - name: "Inclusion Type"
      expr: inclusion_type
    - name: "Is Primary Content"
      expr: is_primary_content
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective Date Month"
      expr: DATE_TRUNC('MONTH', effective_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Edition Content Inclusion"
      expr: COUNT(DISTINCT edition_content_inclusion_id)
    - name: "Total Price Contribution Usd"
      expr: SUM(price_contribution_usd)
    - name: "Average Price Contribution Usd"
      expr: AVG(price_contribution_usd)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`title_franchise`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise business metrics"
  source: "`gaming_ecm`.`title`.`franchise`"
  dimensions:
    - name: "Active Titles Count"
      expr: active_titles_count
    - name: "Brand Guidelines Url"
      expr: brand_guidelines_url
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cross Media Comics Flag"
      expr: cross_media_comics_flag
    - name: "Cross Media Film Flag"
      expr: cross_media_film_flag
    - name: "Cross Media Merchandise Flag"
      expr: cross_media_merchandise_flag
    - name: "Cross Media Theme Park Flag"
      expr: cross_media_theme_park_flag
    - name: "Cross Media Tv Flag"
      expr: cross_media_tv_flag
    - name: "Esports Enabled Flag"
      expr: esports_enabled_flag
    - name: "Franchise Code"
      expr: franchise_code
    - name: "Franchise Name"
      expr: franchise_name
    - name: "Franchise Status"
      expr: franchise_status
    - name: "Franchise Tier"
      expr: franchise_tier
    - name: "Inception Year"
      expr: inception_year
    - name: "Ip Owner Entity"
      expr: ip_owner_entity
    - name: "Is Active"
      expr: is_active
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Franchise"
      expr: COUNT(DISTINCT franchise_id)
    - name: "Total Lifetime Revenue Usd"
      expr: SUM(lifetime_revenue_usd)
    - name: "Average Lifetime Revenue Usd"
      expr: AVG(lifetime_revenue_usd)
    - name: "Total Valuation Usd"
      expr: SUM(valuation_usd)
    - name: "Average Valuation Usd"
      expr: AVG(valuation_usd)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`title_game_edition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Game Edition business metrics"
  source: "`gaming_ecm`.`title`.`game_edition`"
  dimensions:
    - name: "Base Game Included"
      expr: base_game_included
    - name: "Bonus Content Description"
      expr: bonus_content_description
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Discontinuation Date"
      expr: discontinuation_date
    - name: "Display Order"
      expr: display_order
    - name: "Dlc Bundle Count"
      expr: dlc_bundle_count
    - name: "Early Access Days"
      expr: early_access_days
    - name: "Edition Code"
      expr: edition_code
    - name: "Edition Name"
      expr: edition_name
    - name: "Edition Tier"
      expr: edition_tier
    - name: "Edition Type"
      expr: edition_type
    - name: "Game Edition Status"
      expr: game_edition_status
    - name: "Is Digital"
      expr: is_digital
    - name: "Is Limited Availability"
      expr: is_limited_availability
    - name: "Is Physical"
      expr: is_physical
    - name: "Is Pre Order Exclusive"
      expr: is_pre_order_exclusive
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Game Edition"
      expr: COUNT(DISTINCT game_edition_id)
    - name: "Total Msrp Amount"
      expr: SUM(msrp_amount)
    - name: "Average Msrp Amount"
      expr: AVG(msrp_amount)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`title_game_mode`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Game Mode business metrics"
  source: "`gaming_ecm`.`title`.`game_mode`"
  dimensions:
    - name: "Age Rating Override"
      expr: age_rating_override
    - name: "Anti Cheat Required Flag"
      expr: anti_cheat_required_flag
    - name: "Content Warning Flags"
      expr: content_warning_flags
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cross Play Supported Flag"
      expr: cross_play_supported_flag
    - name: "Cross Progression Enabled Flag"
      expr: cross_progression_enabled_flag
    - name: "Display Order"
      expr: display_order
    - name: "Esports Eligible Flag"
      expr: esports_eligible_flag
    - name: "Friendly Fire Enabled Flag"
      expr: friendly_fire_enabled_flag
    - name: "Game Mode Description"
      expr: game_mode_description
    - name: "Game Mode Status"
      expr: game_mode_status
    - name: "Gameplay Category"
      expr: gameplay_category
    - name: "Launch Date"
      expr: launch_date
    - name: "Limited Time Event Flag"
      expr: limited_time_event_flag
    - name: "Matchmaking Algorithm"
      expr: matchmaking_algorithm
    - name: "Matchmaking Enabled Flag"
      expr: matchmaking_enabled_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Game Mode"
      expr: COUNT(DISTINCT game_mode_id)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`title_game_title`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Game Title business metrics"
  source: "`gaming_ecm`.`title`.`game_title`"
  dimensions:
    - name: "Business Model"
      expr: business_model
    - name: "Cero Rating"
      expr: cero_rating
    - name: "Coppa Compliance Required"
      expr: coppa_compliance_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "End Of Life Date"
      expr: end_of_life_date
    - name: "Epic Catalog Item Code"
      expr: epic_catalog_item_code
    - name: "Esrb Rating"
      expr: esrb_rating
    - name: "Game Engine"
      expr: game_engine
    - name: "Game Modes"
      expr: game_modes
    - name: "Gdpr Scope"
      expr: gdpr_scope
    - name: "Has Dlc"
      expr: has_dlc
    - name: "Has Loot Boxes"
      expr: has_loot_boxes
    - name: "Has Microtransactions"
      expr: has_microtransactions
    - name: "Initial Release Date"
      expr: initial_release_date
    - name: "Ip Ownership Entity"
      expr: ip_ownership_entity
    - name: "Is Cross Play Supported"
      expr: is_cross_play_supported
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Game Title"
      expr: COUNT(DISTINCT game_title_id)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`title_genre_classification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Genre Classification business metrics"
  source: "`gaming_ecm`.`title`.`genre_classification`"
  dimensions:
    - name: "Art Style"
      expr: art_style
    - name: "Average Session Length Minutes"
      expr: average_session_length_minutes
    - name: "Camera Perspective"
      expr: camera_perspective
    - name: "Complexity Level"
      expr: complexity_level
    - name: "Console Store Category"
      expr: console_store_category
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Discovery Priority"
      expr: discovery_priority
    - name: "Epic Store Category"
      expr: epic_store_category
    - name: "Esrb Rating Guidance"
      expr: esrb_rating_guidance
    - name: "Gameplay Tag"
      expr: gameplay_tag
    - name: "Genre Classification Description"
      expr: genre_classification_description
    - name: "Genre Classification Status"
      expr: genre_classification_status
    - name: "Genre Code"
      expr: genre_code
    - name: "Genre Name"
      expr: genre_name
    - name: "Genre Type"
      expr: genre_type
    - name: "Industry Standard Alignment"
      expr: industry_standard_alignment
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Genre Classification"
      expr: COUNT(DISTINCT genre_classification_id)
    - name: "Total Recommendation Weight"
      expr: SUM(recommendation_weight)
    - name: "Average Recommendation Weight"
      expr: AVG(recommendation_weight)
    - name: "Total Typical Retention D1 Pct"
      expr: SUM(typical_retention_d1_pct)
    - name: "Average Typical Retention D1 Pct"
      expr: AVG(typical_retention_d1_pct)
    - name: "Total Typical Retention D30 Pct"
      expr: SUM(typical_retention_d30_pct)
    - name: "Average Typical Retention D30 Pct"
      expr: AVG(typical_retention_d30_pct)
    - name: "Total Typical Retention D7 Pct"
      expr: SUM(typical_retention_d7_pct)
    - name: "Average Typical Retention D7 Pct"
      expr: AVG(typical_retention_d7_pct)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`title_leaderboard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leaderboard business metrics"
  source: "`gaming_ecm`.`title`.`leaderboard`"
  dimensions:
    - name: "Anti Cheat Enabled"
      expr: anti_cheat_enabled
    - name: "Api Endpoint"
      expr: api_endpoint
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Display Order"
      expr: display_order
    - name: "Display Percentile"
      expr: display_percentile
    - name: "Display Player Count"
      expr: display_player_count
    - name: "Eligibility Criteria"
      expr: eligibility_criteria
    - name: "End Date"
      expr: end_date
    - name: "Is Featured"
      expr: is_featured
    - name: "Last Reset Timestamp"
      expr: last_reset_timestamp
    - name: "Leaderboard Code"
      expr: leaderboard_code
    - name: "Leaderboard Description"
      expr: leaderboard_description
    - name: "Leaderboard Name"
      expr: leaderboard_name
    - name: "Leaderboard Status"
      expr: leaderboard_status
    - name: "Leaderboard Type"
      expr: leaderboard_type
    - name: "Manual Review Required"
      expr: manual_review_required
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Leaderboard"
      expr: COUNT(DISTINCT leaderboard_id)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`title_mode_character_roster`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mode Character Roster business metrics"
  source: "`gaming_ecm`.`title`.`mode_character_roster`"
  dimensions:
    - name: "Availability Status"
      expr: availability_status
    - name: "Balance Override Version"
      expr: balance_override_version
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Is Default Available"
      expr: is_default_available
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Unlock Requirement Override"
      expr: unlock_requirement_override
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Mode Character Roster"
      expr: COUNT(DISTINCT mode_character_roster_id)
    - name: "Total Ban Rate Percentage"
      expr: SUM(ban_rate_percentage)
    - name: "Average Ban Rate Percentage"
      expr: AVG(ban_rate_percentage)
    - name: "Total Pick Rate Percentage"
      expr: SUM(pick_rate_percentage)
    - name: "Average Pick Rate Percentage"
      expr: AVG(pick_rate_percentage)
    - name: "Total Win Rate Percentage"
      expr: SUM(win_rate_percentage)
    - name: "Average Win Rate Percentage"
      expr: AVG(win_rate_percentage)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`title_playable_character`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Playable Character business metrics"
  source: "`gaming_ecm`.`title`.`playable_character`"
  dimensions:
    - name: "Age Rating Restriction"
      expr: age_rating_restriction
    - name: "Base Attack Power"
      expr: base_attack_power
    - name: "Base Defense Rating"
      expr: base_defense_rating
    - name: "Base Health Points"
      expr: base_health_points
    - name: "Base Speed Rating"
      expr: base_speed_rating
    - name: "Character Class"
      expr: character_class
    - name: "Character Code"
      expr: character_code
    - name: "Character Description"
      expr: character_description
    - name: "Character Icon Asset Path"
      expr: character_icon_asset_path
    - name: "Character Name"
      expr: character_name
    - name: "Character Type"
      expr: character_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Difficulty Rating"
      expr: difficulty_rating
    - name: "Faction Affiliation"
      expr: faction_affiliation
    - name: "Gender"
      expr: gender
    - name: "Intellectual Property Owner"
      expr: intellectual_property_owner
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Playable Character"
      expr: COUNT(DISTINCT playable_character_id)
    - name: "Total Popularity Score"
      expr: SUM(popularity_score)
    - name: "Average Popularity Score"
      expr: AVG(popularity_score)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`title_title_release`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Title Release business metrics"
  source: "`gaming_ecm`.`title`.`title_release`"
  dimensions:
    - name: "Actual Release Date"
      expr: actual_release_date
    - name: "Announcement Url"
      expr: announcement_url
    - name: "Certification Approval Date"
      expr: certification_approval_date
    - name: "Certification Status"
      expr: certification_status
    - name: "Certification Submission Date"
      expr: certification_submission_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deprecation Date"
      expr: deprecation_date
    - name: "Early Access Flag"
      expr: early_access_flag
    - name: "Forced Update Flag"
      expr: forced_update_flag
    - name: "Go Live Timestamp"
      expr: go_live_timestamp
    - name: "Gold Master Flag"
      expr: gold_master_flag
    - name: "Minimum Client Version"
      expr: minimum_client_version
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Phased Rollout Flag"
      expr: phased_rollout_flag
    - name: "Pre Order Flag"
      expr: pre_order_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Title Release"
      expr: COUNT(DISTINCT title_release_id)
    - name: "Total Patch Size Mb"
      expr: SUM(patch_size_mb)
    - name: "Average Patch Size Mb"
      expr: AVG(patch_size_mb)
    - name: "Total Rollout Percentage"
      expr: SUM(rollout_percentage)
    - name: "Average Rollout Percentage"
      expr: AVG(rollout_percentage)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`title_title_season`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Title Season business metrics"
  source: "`gaming_ecm`.`title`.`title_season`"
  dimensions:
    - name: "Actual Duration Days"
      expr: actual_duration_days
    - name: "Announcement Date"
      expr: announcement_date
    - name: "Balance Patch Version"
      expr: balance_patch_version
    - name: "Battle Pass Included"
      expr: battle_pass_included
    - name: "Competitive Season Flag"
      expr: competitive_season_flag
    - name: "Content Rating"
      expr: content_rating
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dlc Bundle Count"
      expr: dlc_bundle_count
    - name: "End Date"
      expr: end_date
    - name: "Featured Content Description"
      expr: featured_content_description
    - name: "Free To Play Content Flag"
      expr: free_to_play_content_flag
    - name: "Leaderboard Reset Flag"
      expr: leaderboard_reset_flag
    - name: "Marketing Tagline"
      expr: marketing_tagline
    - name: "Mid Season Update Flag"
      expr: mid_season_update_flag
    - name: "Narrative Summary"
      expr: narrative_summary
    - name: "New Characters Count"
      expr: new_characters_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Title Season"
      expr: COUNT(DISTINCT title_season_id)
    - name: "Total Target Revenue Amount"
      expr: SUM(target_revenue_amount)
    - name: "Average Target Revenue Amount"
      expr: AVG(target_revenue_amount)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`title_title_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Title Sku business metrics"
  source: "`gaming_ecm`.`title`.`title_sku`"
  dimensions:
    - name: "Age Gate Required Flag"
      expr: age_gate_required_flag
    - name: "Availability End Date"
      expr: availability_end_date
    - name: "Availability Start Date"
      expr: availability_start_date
    - name: "Bundle Component Flag"
      expr: bundle_component_flag
    - name: "Certification Date"
      expr: certification_date
    - name: "Certification Status"
      expr: certification_status
    - name: "Content Type"
      expr: content_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cross Buy Eligible Flag"
      expr: cross_buy_eligible_flag
    - name: "Currency Code"
      expr: currency_code
    - name: "Distribution Channel"
      expr: distribution_channel
    - name: "Drm Type"
      expr: drm_type
    - name: "Ean Code"
      expr: ean_code
    - name: "Exclusive Flag"
      expr: exclusive_flag
    - name: "Gold Master Date"
      expr: gold_master_date
    - name: "Launch Type"
      expr: launch_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Title Sku"
      expr: COUNT(DISTINCT title_sku_id)
    - name: "Total File Size Gb"
      expr: SUM(file_size_gb)
    - name: "Average File Size Gb"
      expr: AVG(file_size_gb)
    - name: "Total Msrp Amount"
      expr: SUM(msrp_amount)
    - name: "Average Msrp Amount"
      expr: AVG(msrp_amount)
$$;