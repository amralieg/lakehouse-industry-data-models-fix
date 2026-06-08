-- Metric views for domain: title | Business: Gaming | Version: 1 | Generated on: 2026-05-08 07:57:15

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`title_game_title`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core game title performance and lifecycle metrics for strategic portfolio management and investment decisions"
  source: "`gaming_ecm`.`title`.`game_title`"
  dimensions:
    - name: "title_name"
      expr: official_title_name
      comment: "Official name of the game title"
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Current lifecycle stage (pre-production, development, live, sunset, etc.)"
    - name: "business_model"
      expr: business_model
      comment: "Monetization model (premium, free-to-play, subscription, etc.)"
    - name: "esrb_rating"
      expr: esrb_rating
      comment: "ESRB content rating for North American market"
    - name: "pegi_rating"
      expr: pegi_rating
      comment: "PEGI content rating for European market"
    - name: "is_esports_title"
      expr: is_esports_title
      comment: "Flag indicating if title supports competitive esports"
    - name: "is_gaas"
      expr: is_gaas
      comment: "Flag indicating if title is Games-as-a-Service model"
    - name: "supported_platforms"
      expr: supported_platforms
      comment: "Platforms where title is available"
    - name: "release_year"
      expr: YEAR(initial_release_date)
      comment: "Year of initial release"
    - name: "release_quarter"
      expr: CONCAT('Q', QUARTER(initial_release_date), '-', YEAR(initial_release_date))
      comment: "Quarter and year of initial release"
  measures:
    - name: "total_titles"
      expr: COUNT(DISTINCT game_title_id)
      comment: "Total number of unique game titles in portfolio"
    - name: "active_titles"
      expr: COUNT(DISTINCT CASE WHEN lifecycle_stage IN ('live', 'soft_launch', 'early_access') THEN game_title_id END)
      comment: "Number of titles currently live and generating revenue"
    - name: "gaas_title_count"
      expr: COUNT(DISTINCT CASE WHEN is_gaas = TRUE THEN game_title_id END)
      comment: "Number of Games-as-a-Service titles requiring ongoing content investment"
    - name: "esports_title_count"
      expr: COUNT(DISTINCT CASE WHEN is_esports_title = TRUE THEN game_title_id END)
      comment: "Number of titles with competitive esports programs"
    - name: "titles_with_mtx"
      expr: COUNT(DISTINCT CASE WHEN has_microtransactions = TRUE THEN game_title_id END)
      comment: "Number of titles with microtransaction monetization"
    - name: "cross_play_enabled_titles"
      expr: COUNT(DISTINCT CASE WHEN is_cross_play_supported = TRUE THEN game_title_id END)
      comment: "Number of titles supporting cross-platform play"
    - name: "ugc_enabled_titles"
      expr: COUNT(DISTINCT CASE WHEN is_ugc_enabled = TRUE THEN game_title_id END)
      comment: "Number of titles with user-generated content features"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`title_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SKU-level revenue performance and distribution metrics for pricing strategy and channel optimization"
  source: "`gaming_ecm`.`title`.`title_sku`"
  dimensions:
    - name: "sku_name"
      expr: sku_name
      comment: "Name of the SKU"
    - name: "platform_code"
      expr: platform_code
      comment: "Platform for this SKU (PlayStation, Xbox, Steam, etc.)"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region for this SKU"
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel (digital, physical, subscription)"
    - name: "package_type"
      expr: package_type
      comment: "Type of package (standard, deluxe, collector's edition, etc.)"
    - name: "sku_status"
      expr: sku_status
      comment: "Current status of SKU (active, deprecated, pre-order, etc.)"
    - name: "pricing_tier"
      expr: pricing_tier
      comment: "Pricing tier classification"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for MSRP pricing"
    - name: "is_pre_order_eligible"
      expr: pre_order_eligible_flag
      comment: "Flag indicating if SKU is available for pre-order"
    - name: "release_year"
      expr: YEAR(release_date)
      comment: "Year SKU was released"
    - name: "release_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month SKU was released"
  measures:
    - name: "total_skus"
      expr: COUNT(DISTINCT title_sku_id)
      comment: "Total number of unique SKUs across all titles and platforms"
    - name: "active_skus"
      expr: COUNT(DISTINCT CASE WHEN sku_status = 'active' THEN title_sku_id END)
      comment: "Number of currently active SKUs available for purchase"
    - name: "total_msrp_value"
      expr: SUM(CAST(msrp_amount AS DOUBLE))
      comment: "Sum of MSRP amounts across all SKUs (mixed currency, use for relative analysis only)"
    - name: "avg_msrp_amount"
      expr: AVG(CAST(msrp_amount AS DOUBLE))
      comment: "Average MSRP amount across SKUs (mixed currency)"
    - name: "avg_file_size_gb"
      expr: AVG(CAST(file_size_gb AS DOUBLE))
      comment: "Average file size in GB across SKUs, impacts download infrastructure costs"
    - name: "total_file_size_gb"
      expr: SUM(CAST(file_size_gb AS DOUBLE))
      comment: "Total file size in GB across all SKUs, impacts CDN and storage costs"
    - name: "digital_sku_count"
      expr: COUNT(DISTINCT CASE WHEN distribution_channel = 'digital' THEN title_sku_id END)
      comment: "Number of digital distribution SKUs with higher margin potential"
    - name: "physical_sku_count"
      expr: COUNT(DISTINCT CASE WHEN distribution_channel = 'physical' THEN title_sku_id END)
      comment: "Number of physical distribution SKUs with manufacturing and logistics costs"
    - name: "cross_buy_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN cross_buy_eligible_flag = TRUE THEN title_sku_id END)
      comment: "Number of SKUs supporting cross-buy between platforms"
    - name: "certified_sku_count"
      expr: COUNT(DISTINCT CASE WHEN certification_status = 'certified' THEN title_sku_id END)
      comment: "Number of SKUs that have passed platform certification"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`title_dlc_bundle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DLC and content bundle performance metrics for post-launch monetization and content strategy"
  source: "`gaming_ecm`.`title`.`dlc_bundle`"
  dimensions:
    - name: "bundle_name"
      expr: bundle_name
      comment: "Name of the DLC bundle"
    - name: "dlc_type"
      expr: dlc_type
      comment: "Type of DLC (expansion, cosmetic, season pass, etc.)"
    - name: "bundle_status"
      expr: bundle_status
      comment: "Current status of bundle (active, deprecated, planned, etc.)"
    - name: "is_free"
      expr: is_free
      comment: "Flag indicating if DLC is free content"
    - name: "is_time_limited"
      expr: is_time_limited
      comment: "Flag indicating if DLC has limited availability window"
    - name: "platform_availability"
      expr: platform_availability
      comment: "Platforms where DLC is available"
    - name: "certification_status"
      expr: certification_status
      comment: "Platform certification status"
    - name: "requires_base_game"
      expr: requires_base_game
      comment: "Flag indicating if base game purchase is required"
    - name: "release_year"
      expr: YEAR(release_date)
      comment: "Year DLC was released"
    - name: "release_quarter"
      expr: CONCAT('Q', QUARTER(release_date), '-', YEAR(release_date))
      comment: "Quarter and year of DLC release"
  measures:
    - name: "total_dlc_bundles"
      expr: COUNT(DISTINCT dlc_bundle_id)
      comment: "Total number of DLC bundles across all titles"
    - name: "active_dlc_bundles"
      expr: COUNT(DISTINCT CASE WHEN bundle_status = 'active' AND is_active = TRUE THEN dlc_bundle_id END)
      comment: "Number of currently active DLC bundles generating revenue"
    - name: "total_dlc_revenue_potential"
      expr: SUM(CAST(base_price_usd AS DOUBLE))
      comment: "Sum of base prices across all DLC bundles in USD"
    - name: "avg_dlc_price"
      expr: AVG(CAST(base_price_usd AS DOUBLE))
      comment: "Average base price of DLC bundles in USD"
    - name: "free_dlc_count"
      expr: COUNT(DISTINCT CASE WHEN is_free = TRUE THEN dlc_bundle_id END)
      comment: "Number of free DLC bundles used for player retention"
    - name: "paid_dlc_count"
      expr: COUNT(DISTINCT CASE WHEN is_free = FALSE THEN dlc_bundle_id END)
      comment: "Number of paid DLC bundles generating incremental revenue"
    - name: "time_limited_dlc_count"
      expr: COUNT(DISTINCT CASE WHEN is_time_limited = TRUE THEN dlc_bundle_id END)
      comment: "Number of time-limited DLC bundles creating urgency"
    - name: "avg_file_size_mb"
      expr: AVG(CAST(file_size_mb AS DOUBLE))
      comment: "Average file size of DLC bundles in MB"
    - name: "total_file_size_mb"
      expr: SUM(CAST(file_size_mb AS DOUBLE))
      comment: "Total file size of all DLC bundles in MB"
    - name: "certified_dlc_count"
      expr: COUNT(DISTINCT CASE WHEN certification_status = 'certified' THEN dlc_bundle_id END)
      comment: "Number of DLC bundles that have passed platform certification"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`title_season`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Seasonal content performance and live operations metrics for GaaS title management and player engagement"
  source: "`gaming_ecm`.`title`.`title_season`"
  dimensions:
    - name: "season_name"
      expr: season_name
      comment: "Name of the season"
    - name: "season_number"
      expr: season_number
      comment: "Sequential season number"
    - name: "title_season_status"
      expr: title_season_status
      comment: "Current status of season (active, planned, completed, etc.)"
    - name: "theme"
      expr: theme
      comment: "Thematic content of the season"
    - name: "battle_pass_included"
      expr: battle_pass_included
      comment: "Flag indicating if season includes battle pass monetization"
    - name: "competitive_season_flag"
      expr: competitive_season_flag
      comment: "Flag indicating if season includes competitive/ranked mode"
    - name: "platform_availability"
      expr: platform_availability
      comment: "Platforms where season content is available"
    - name: "region_availability"
      expr: region_availability
      comment: "Geographic regions where season is available"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year season started"
    - name: "start_quarter"
      expr: CONCAT('Q', QUARTER(start_date), '-', YEAR(start_date))
      comment: "Quarter and year season started"
  measures:
    - name: "total_seasons"
      expr: COUNT(DISTINCT title_season_id)
      comment: "Total number of seasons across all titles"
    - name: "active_seasons"
      expr: COUNT(DISTINCT CASE WHEN title_season_status = 'active' THEN title_season_id END)
      comment: "Number of currently active seasons driving player engagement"
    - name: "seasons_with_battle_pass"
      expr: COUNT(DISTINCT CASE WHEN battle_pass_included = TRUE THEN title_season_id END)
      comment: "Number of seasons with battle pass monetization"
    - name: "competitive_seasons"
      expr: COUNT(DISTINCT CASE WHEN competitive_season_flag = TRUE THEN title_season_id END)
      comment: "Number of seasons with competitive ranked modes"
    - name: "avg_planned_duration_days"
      expr: AVG(CAST(planned_duration_days AS DOUBLE))
      comment: "Average planned duration of seasons in days"
    - name: "avg_actual_duration_days"
      expr: AVG(CAST(actual_duration_days AS DOUBLE))
      comment: "Average actual duration of completed seasons in days"
    - name: "total_target_revenue"
      expr: SUM(CAST(target_revenue_amount AS DOUBLE))
      comment: "Sum of revenue targets across all seasons"
    - name: "avg_target_revenue"
      expr: AVG(CAST(target_revenue_amount AS DOUBLE))
      comment: "Average revenue target per season"
    - name: "avg_new_characters_per_season"
      expr: AVG(CAST(new_characters_count AS DOUBLE))
      comment: "Average number of new characters introduced per season"
    - name: "avg_new_maps_per_season"
      expr: AVG(CAST(new_maps_count AS DOUBLE))
      comment: "Average number of new maps introduced per season"
    - name: "avg_dlc_bundles_per_season"
      expr: AVG(CAST(dlc_bundle_count AS DOUBLE))
      comment: "Average number of DLC bundles released per season"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`title_release`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Release execution and deployment metrics for launch quality and time-to-market optimization"
  source: "`gaming_ecm`.`title`.`title_release`"
  dimensions:
    - name: "release_type"
      expr: release_type
      comment: "Type of release (major, patch, hotfix, content update, etc.)"
    - name: "release_status"
      expr: release_status
      comment: "Current status of release (planned, in_progress, live, rolled_back, etc.)"
    - name: "certification_status"
      expr: certification_status
      comment: "Platform certification status"
    - name: "region_scope"
      expr: region_scope
      comment: "Geographic scope of release"
    - name: "priority"
      expr: priority
      comment: "Priority level of release"
    - name: "early_access_flag"
      expr: early_access_flag
      comment: "Flag indicating if release is early access"
    - name: "phased_rollout_flag"
      expr: phased_rollout_flag
      comment: "Flag indicating if release uses phased rollout"
    - name: "rollback_flag"
      expr: rollback_flag
      comment: "Flag indicating if release was rolled back"
    - name: "gold_master_flag"
      expr: gold_master_flag
      comment: "Flag indicating if release is gold master build"
    - name: "release_year"
      expr: YEAR(actual_release_date)
      comment: "Year of actual release"
    - name: "release_month"
      expr: DATE_TRUNC('MONTH', actual_release_date)
      comment: "Month of actual release"
  measures:
    - name: "total_releases"
      expr: COUNT(DISTINCT title_release_id)
      comment: "Total number of releases across all titles"
    - name: "successful_releases"
      expr: COUNT(DISTINCT CASE WHEN release_status = 'live' AND rollback_flag = FALSE THEN title_release_id END)
      comment: "Number of releases successfully deployed without rollback"
    - name: "rolled_back_releases"
      expr: COUNT(DISTINCT CASE WHEN rollback_flag = TRUE THEN title_release_id END)
      comment: "Number of releases that required rollback due to issues"
    - name: "avg_patch_size_mb"
      expr: AVG(CAST(patch_size_mb AS DOUBLE))
      comment: "Average patch size in MB across releases"
    - name: "total_patch_size_mb"
      expr: SUM(CAST(patch_size_mb AS DOUBLE))
      comment: "Total patch size in MB across all releases"
    - name: "avg_rollout_percentage"
      expr: AVG(CAST(rollout_percentage AS DOUBLE))
      comment: "Average rollout percentage for phased releases"
    - name: "phased_rollout_count"
      expr: COUNT(DISTINCT CASE WHEN phased_rollout_flag = TRUE THEN title_release_id END)
      comment: "Number of releases using phased rollout strategy"
    - name: "early_access_release_count"
      expr: COUNT(DISTINCT CASE WHEN early_access_flag = TRUE THEN title_release_id END)
      comment: "Number of early access releases"
    - name: "gold_master_release_count"
      expr: COUNT(DISTINCT CASE WHEN gold_master_flag = TRUE THEN title_release_id END)
      comment: "Number of gold master releases"
    - name: "certified_release_count"
      expr: COUNT(DISTINCT CASE WHEN certification_status = 'certified' THEN title_release_id END)
      comment: "Number of releases that passed platform certification"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`title_achievement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Achievement design and player engagement metrics for retention and progression system optimization"
  source: "`gaming_ecm`.`title`.`achievement`"
  dimensions:
    - name: "achievement_name"
      expr: achievement_name
      comment: "Name of the achievement"
    - name: "achievement_type"
      expr: achievement_type
      comment: "Type of achievement (story, skill, collection, social, etc.)"
    - name: "achievement_status"
      expr: achievement_status
      comment: "Current status of achievement (active, deprecated, seasonal, etc.)"
    - name: "rarity_tier"
      expr: rarity_tier
      comment: "Rarity tier of achievement (common, rare, epic, legendary)"
    - name: "is_hidden"
      expr: is_hidden
      comment: "Flag indicating if achievement is hidden from players initially"
    - name: "is_secret"
      expr: is_secret
      comment: "Flag indicating if achievement is secret"
    - name: "is_time_limited"
      expr: is_time_limited
      comment: "Flag indicating if achievement has time limit"
    - name: "is_platinum_trophy"
      expr: is_platinum_trophy
      comment: "Flag indicating if achievement is platinum trophy (PlayStation)"
    - name: "platform_availability"
      expr: platform_availability
      comment: "Platforms where achievement is available"
    - name: "playstation_trophy_type"
      expr: playstation_trophy_type
      comment: "PlayStation trophy type (bronze, silver, gold, platinum)"
    - name: "release_year"
      expr: YEAR(release_date)
      comment: "Year achievement was released"
  measures:
    - name: "total_achievements"
      expr: COUNT(DISTINCT achievement_id)
      comment: "Total number of achievements across all titles"
    - name: "active_achievements"
      expr: COUNT(DISTINCT CASE WHEN achievement_status = 'active' THEN achievement_id END)
      comment: "Number of currently active achievements"
    - name: "avg_unlock_percentage"
      expr: AVG(CAST(unlock_percentage AS DOUBLE))
      comment: "Average unlock percentage across all achievements, indicates difficulty balance"
    - name: "rare_achievement_count"
      expr: COUNT(DISTINCT CASE WHEN rarity_tier IN ('rare', 'epic', 'legendary') THEN achievement_id END)
      comment: "Number of rare or higher tier achievements"
    - name: "time_limited_achievement_count"
      expr: COUNT(DISTINCT CASE WHEN is_time_limited = TRUE THEN achievement_id END)
      comment: "Number of time-limited achievements creating urgency"
    - name: "hidden_achievement_count"
      expr: COUNT(DISTINCT CASE WHEN is_hidden = TRUE THEN achievement_id END)
      comment: "Number of hidden achievements for discovery gameplay"
    - name: "platinum_trophy_count"
      expr: COUNT(DISTINCT CASE WHEN is_platinum_trophy = TRUE THEN achievement_id END)
      comment: "Number of platinum trophies (PlayStation completionist achievements)"
    - name: "achievements_requiring_localization"
      expr: COUNT(DISTINCT CASE WHEN localization_required = TRUE THEN achievement_id END)
      comment: "Number of achievements requiring localization work"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`title_franchise`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise portfolio performance and strategic value metrics for IP investment and brand management decisions"
  source: "`gaming_ecm`.`title`.`franchise`"
  dimensions:
    - name: "franchise_name"
      expr: franchise_name
      comment: "Name of the franchise"
    - name: "franchise_status"
      expr: franchise_status
      comment: "Current status of franchise (active, dormant, sunset, etc.)"
    - name: "franchise_tier"
      expr: franchise_tier
      comment: "Strategic tier classification (AAA, AA, indie, etc.)"
    - name: "strategic_priority_level"
      expr: strategic_priority_level
      comment: "Strategic priority level for investment decisions"
    - name: "monetization_model"
      expr: monetization_model
      comment: "Primary monetization model for franchise"
    - name: "esports_enabled_flag"
      expr: esports_enabled_flag
      comment: "Flag indicating if franchise supports esports"
    - name: "ugc_enabled_flag"
      expr: ugc_enabled_flag
      comment: "Flag indicating if franchise supports user-generated content"
    - name: "cross_media_film_flag"
      expr: cross_media_film_flag
      comment: "Flag indicating if franchise has film adaptations"
    - name: "cross_media_tv_flag"
      expr: cross_media_tv_flag
      comment: "Flag indicating if franchise has TV adaptations"
    - name: "cross_media_merchandise_flag"
      expr: cross_media_merchandise_flag
      comment: "Flag indicating if franchise has merchandise licensing"
    - name: "inception_decade"
      expr: CONCAT(FLOOR(CAST(inception_year AS INT) / 10) * 10, 's')
      comment: "Decade when franchise was created"
  measures:
    - name: "total_franchises"
      expr: COUNT(DISTINCT franchise_id)
      comment: "Total number of franchises in portfolio"
    - name: "active_franchises"
      expr: COUNT(DISTINCT CASE WHEN franchise_status = 'active' AND is_active = TRUE THEN franchise_id END)
      comment: "Number of active franchises generating revenue"
    - name: "total_lifetime_revenue_usd"
      expr: SUM(CAST(lifetime_revenue_usd AS DOUBLE))
      comment: "Total lifetime revenue across all franchises in USD"
    - name: "avg_lifetime_revenue_usd"
      expr: AVG(CAST(lifetime_revenue_usd AS DOUBLE))
      comment: "Average lifetime revenue per franchise in USD"
    - name: "total_franchise_valuation_usd"
      expr: SUM(CAST(valuation_usd AS DOUBLE))
      comment: "Total valuation of all franchises in USD"
    - name: "avg_franchise_valuation_usd"
      expr: AVG(CAST(valuation_usd AS DOUBLE))
      comment: "Average valuation per franchise in USD"
    - name: "avg_titles_per_franchise"
      expr: AVG(CAST(total_titles_count AS DOUBLE))
      comment: "Average number of titles per franchise"
    - name: "avg_active_titles_per_franchise"
      expr: AVG(CAST(active_titles_count AS DOUBLE))
      comment: "Average number of active titles per franchise"
    - name: "esports_enabled_franchises"
      expr: COUNT(DISTINCT CASE WHEN esports_enabled_flag = TRUE THEN franchise_id END)
      comment: "Number of franchises with esports programs"
    - name: "cross_media_franchises"
      expr: COUNT(DISTINCT CASE WHEN cross_media_film_flag = TRUE OR cross_media_tv_flag = TRUE THEN franchise_id END)
      comment: "Number of franchises with film or TV adaptations"
    - name: "merchandise_franchises"
      expr: COUNT(DISTINCT CASE WHEN cross_media_merchandise_flag = TRUE THEN franchise_id END)
      comment: "Number of franchises with merchandise licensing"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`title_build_artifact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Build quality and deployment readiness metrics for release velocity and technical debt management"
  source: "`gaming_ecm`.`title`.`build_artifact`"
  dimensions:
    - name: "build_type"
      expr: build_type
      comment: "Type of build (release, debug, profiling, etc.)"
    - name: "target_platform"
      expr: target_platform
      comment: "Target platform for build"
    - name: "certification_status"
      expr: certification_status
      comment: "Platform certification status"
    - name: "qa_status"
      expr: qa_status
      comment: "QA testing status"
    - name: "deployment_status"
      expr: deployment_status
      comment: "Deployment status"
    - name: "drm_enabled"
      expr: drm_enabled
      comment: "Flag indicating if DRM is enabled"
    - name: "includes_mtx"
      expr: includes_mtx
      comment: "Flag indicating if build includes microtransactions"
    - name: "includes_ugc"
      expr: includes_ugc
      comment: "Flag indicating if build includes user-generated content"
    - name: "is_mandatory_update"
      expr: is_mandatory_update
      comment: "Flag indicating if update is mandatory for players"
    - name: "is_rollback_available"
      expr: is_rollback_available
      comment: "Flag indicating if rollback is available"
    - name: "multiplayer_mode"
      expr: multiplayer_mode
      comment: "Multiplayer mode support"
    - name: "build_year"
      expr: YEAR(build_timestamp)
      comment: "Year build was created"
    - name: "build_month"
      expr: DATE_TRUNC('MONTH', build_timestamp)
      comment: "Month build was created"
  measures:
    - name: "total_builds"
      expr: COUNT(DISTINCT build_artifact_id)
      comment: "Total number of build artifacts created"
    - name: "certified_builds"
      expr: COUNT(DISTINCT CASE WHEN certification_status = 'certified' THEN build_artifact_id END)
      comment: "Number of builds that passed platform certification"
    - name: "deployed_builds"
      expr: COUNT(DISTINCT CASE WHEN deployment_status = 'deployed' THEN build_artifact_id END)
      comment: "Number of builds successfully deployed to production"
    - name: "avg_binary_size_mb"
      expr: AVG(CAST(binary_size_mb AS DOUBLE))
      comment: "Average binary size in MB across builds"
    - name: "total_binary_size_mb"
      expr: SUM(CAST(binary_size_mb AS DOUBLE))
      comment: "Total binary size in MB across all builds"
    - name: "avg_delta_patch_size_mb"
      expr: AVG(CAST(delta_patch_size_mb AS DOUBLE))
      comment: "Average delta patch size in MB for incremental updates"
    - name: "builds_with_drm"
      expr: COUNT(DISTINCT CASE WHEN drm_enabled = TRUE THEN build_artifact_id END)
      comment: "Number of builds with DRM protection enabled"
    - name: "builds_with_mtx"
      expr: COUNT(DISTINCT CASE WHEN includes_mtx = TRUE THEN build_artifact_id END)
      comment: "Number of builds with microtransaction support"
    - name: "mandatory_update_builds"
      expr: COUNT(DISTINCT CASE WHEN is_mandatory_update = TRUE THEN build_artifact_id END)
      comment: "Number of builds requiring mandatory player updates"
    - name: "rollback_capable_builds"
      expr: COUNT(DISTINCT CASE WHEN is_rollback_available = TRUE THEN build_artifact_id END)
      comment: "Number of builds with rollback capability"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`title_content_rating`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content rating compliance and market access metrics for regulatory risk management and territory expansion"
  source: "`gaming_ecm`.`title`.`content_rating`"
  dimensions:
    - name: "rating_authority"
      expr: rating_authority
      comment: "Rating authority organization (ESRB, PEGI, CERO, etc.)"
    - name: "rating_type"
      expr: rating_type
      comment: "Type of rating (age-based, content-based, etc.)"
    - name: "rating_status"
      expr: rating_status
      comment: "Current status of rating (active, pending, expired, etc.)"
    - name: "region_scope"
      expr: region_scope
      comment: "Geographic region covered by rating"
    - name: "platform_scope"
      expr: platform_scope
      comment: "Platform scope of rating"
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any rating appeal"
    - name: "in_game_purchases_flag"
      expr: in_game_purchases_flag
      comment: "Flag indicating if title has in-game purchases"
    - name: "loot_box_disclosure"
      expr: loot_box_disclosure
      comment: "Flag indicating if loot box disclosure is required"
    - name: "online_notice_required"
      expr: online_notice_required
      comment: "Flag indicating if online interaction notice is required"
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating if rating is currently active"
    - name: "certification_year"
      expr: YEAR(certification_date)
      comment: "Year rating was certified"
  measures:
    - name: "total_content_ratings"
      expr: COUNT(DISTINCT content_rating_id)
      comment: "Total number of content ratings across all titles and jurisdictions"
    - name: "active_content_ratings"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE AND rating_status = 'active' THEN content_rating_id END)
      comment: "Number of currently active content ratings"
    - name: "pending_ratings"
      expr: COUNT(DISTINCT CASE WHEN rating_status = 'pending' THEN content_rating_id END)
      comment: "Number of ratings pending approval"
    - name: "appealed_ratings"
      expr: COUNT(DISTINCT CASE WHEN appeal_status IS NOT NULL AND appeal_status != 'none' THEN content_rating_id END)
      comment: "Number of ratings that have been appealed"
    - name: "total_rating_fees"
      expr: SUM(CAST(rating_fee_amount AS DOUBLE))
      comment: "Total rating fees paid across all ratings"
    - name: "avg_rating_fee"
      expr: AVG(CAST(rating_fee_amount AS DOUBLE))
      comment: "Average rating fee per certification"
    - name: "ratings_with_iap_disclosure"
      expr: COUNT(DISTINCT CASE WHEN in_game_purchases_flag = TRUE THEN content_rating_id END)
      comment: "Number of ratings requiring in-game purchase disclosure"
    - name: "ratings_with_lootbox_disclosure"
      expr: COUNT(DISTINCT CASE WHEN loot_box_disclosure = TRUE THEN content_rating_id END)
      comment: "Number of ratings requiring loot box disclosure"
    - name: "ratings_with_online_notice"
      expr: COUNT(DISTINCT CASE WHEN online_notice_required = TRUE THEN content_rating_id END)
      comment: "Number of ratings requiring online interaction notice"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`title_leaderboard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leaderboard engagement and competitive feature metrics for player retention and esports program optimization"
  source: "`gaming_ecm`.`title`.`leaderboard`"
  dimensions:
    - name: "leaderboard_name"
      expr: leaderboard_name
      comment: "Name of the leaderboard"
    - name: "leaderboard_type"
      expr: leaderboard_type
      comment: "Type of leaderboard (global, regional, friends, etc.)"
    - name: "leaderboard_status"
      expr: leaderboard_status
      comment: "Current status of leaderboard"
    - name: "ranking_metric"
      expr: ranking_metric
      comment: "Metric used for ranking (score, time, kills, etc.)"
    - name: "reset_cadence"
      expr: reset_cadence
      comment: "How often leaderboard resets (daily, weekly, monthly, seasonal)"
    - name: "region_scope"
      expr: region_scope
      comment: "Geographic scope of leaderboard"
    - name: "platform_scope"
      expr: platform_scope
      comment: "Platform scope of leaderboard"
    - name: "anti_cheat_enabled"
      expr: anti_cheat_enabled
      comment: "Flag indicating if anti-cheat is enabled"
    - name: "reward_distribution_flag"
      expr: reward_distribution_flag
      comment: "Flag indicating if rewards are distributed"
    - name: "is_featured"
      expr: is_featured
      comment: "Flag indicating if leaderboard is featured"
    - name: "manual_review_required"
      expr: manual_review_required
      comment: "Flag indicating if manual review is required for top ranks"
  measures:
    - name: "total_leaderboards"
      expr: COUNT(DISTINCT leaderboard_id)
      comment: "Total number of leaderboards across all titles"
    - name: "active_leaderboards"
      expr: COUNT(DISTINCT CASE WHEN leaderboard_status = 'active' THEN leaderboard_id END)
      comment: "Number of currently active leaderboards"
    - name: "featured_leaderboards"
      expr: COUNT(DISTINCT CASE WHEN is_featured = TRUE THEN leaderboard_id END)
      comment: "Number of featured leaderboards driving player engagement"
    - name: "leaderboards_with_rewards"
      expr: COUNT(DISTINCT CASE WHEN reward_distribution_flag = TRUE THEN leaderboard_id END)
      comment: "Number of leaderboards with reward distribution"
    - name: "leaderboards_with_anticheat"
      expr: COUNT(DISTINCT CASE WHEN anti_cheat_enabled = TRUE THEN leaderboard_id END)
      comment: "Number of leaderboards with anti-cheat protection"
    - name: "leaderboards_requiring_review"
      expr: COUNT(DISTINCT CASE WHEN manual_review_required = TRUE THEN leaderboard_id END)
      comment: "Number of leaderboards requiring manual review for integrity"
$$;