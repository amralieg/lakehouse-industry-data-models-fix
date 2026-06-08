-- Metric views for domain: platform | Business: Gaming | Version: 1 | Generated on: 2026-05-08 09:42:21

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`platform_storefront_listing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storefront listing performance metrics tracking visibility, engagement, and conversion indicators for published game titles across digital storefronts"
  source: "`gaming_ecm`.`platform`.`storefront_listing`"
  dimensions:
    - name: "listing_status"
      expr: listing_status
      comment: "Current publication status of the storefront listing (published, draft, delisted, etc.)"
    - name: "content_rating"
      expr: content_rating
      comment: "Age-appropriate content rating assigned to the listing"
    - name: "primary_category"
      expr: primary_category
      comment: "Primary storefront category classification for the game"
    - name: "localization_language_code"
      expr: localization_language_code
      comment: "Language code for the localized listing content"
    - name: "drm_type"
      expr: drm_type
      comment: "Digital rights management system applied to the listing"
    - name: "cross_platform_play_flag"
      expr: cross_platform_play
      comment: "Indicates whether the title supports cross-platform multiplayer"
    - name: "in_app_purchases_flag"
      expr: in_app_purchases
      comment: "Indicates whether the title includes in-app purchase monetization"
    - name: "multiplayer_support_flag"
      expr: multiplayer_support
      comment: "Indicates whether the title supports multiplayer gameplay"
    - name: "release_year"
      expr: YEAR(release_date)
      comment: "Year the title was released on the storefront"
    - name: "release_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month the title was released on the storefront"
  measures:
    - name: "total_listings"
      expr: COUNT(1)
      comment: "Total number of storefront listings"
    - name: "total_review_count"
      expr: SUM(CAST(review_count AS BIGINT))
      comment: "Aggregate count of user reviews across all listings"
    - name: "avg_review_score"
      expr: AVG(CAST(aggregate_review_score AS DOUBLE))
      comment: "Average user review score across listings (quality indicator)"
    - name: "avg_file_size_mb"
      expr: AVG(CAST(file_size_mb AS DOUBLE))
      comment: "Average download file size in megabytes"
    - name: "total_file_size_mb"
      expr: SUM(CAST(file_size_mb AS DOUBLE))
      comment: "Total storage footprint of all listed titles in megabytes"
    - name: "distinct_titles"
      expr: COUNT(DISTINCT game_title_id)
      comment: "Count of unique game titles represented in listings"
    - name: "distinct_storefronts"
      expr: COUNT(DISTINCT storefront_id)
      comment: "Count of unique storefronts hosting listings"
    - name: "cross_platform_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cross_platform_play = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of listings supporting cross-platform play (strategic feature adoption metric)"
    - name: "iap_monetization_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN in_app_purchases = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of listings with in-app purchase monetization enabled"
    - name: "multiplayer_penetration_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN multiplayer_support = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of listings offering multiplayer gameplay (engagement driver)"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`platform_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Platform SKU performance metrics tracking pricing, ratings, and feature adoption across platform-specific product offerings"
  source: "`gaming_ecm`.`platform`.`platform_sku`"
  dimensions:
    - name: "listing_status"
      expr: listing_status
      comment: "Current availability status of the SKU on the platform"
    - name: "hardware_generation"
      expr: hardware_generation
      comment: "Target hardware generation for the SKU (e.g., PS5, Xbox Series X)"
    - name: "esrb_rating"
      expr: esrb_rating
      comment: "ESRB content rating assigned to the SKU"
    - name: "pegi_rating"
      expr: pegi_rating
      comment: "PEGI content rating assigned to the SKU"
    - name: "pricing_tier"
      expr: pricing_tier
      comment: "Pricing tier classification for the SKU"
    - name: "storefront_category"
      expr: storefront_category
      comment: "Storefront merchandising category for the SKU"
    - name: "drm_entitlement_type"
      expr: drm_entitlement_type
      comment: "Digital rights management entitlement model applied"
    - name: "is_early_access_flag"
      expr: is_early_access
      comment: "Indicates whether the SKU is in early access release phase"
    - name: "is_preorder_available_flag"
      expr: is_preorder_available
      comment: "Indicates whether pre-orders are currently accepted"
    - name: "release_year"
      expr: YEAR(release_date)
      comment: "Year the SKU was released"
    - name: "release_quarter"
      expr: DATE_TRUNC('QUARTER', release_date)
      comment: "Quarter the SKU was released"
  measures:
    - name: "total_skus"
      expr: COUNT(1)
      comment: "Total number of platform SKUs"
    - name: "avg_base_price_usd"
      expr: AVG(CAST(base_price_usd AS DOUBLE))
      comment: "Average base price in USD across SKUs (pricing strategy indicator)"
    - name: "total_base_price_usd"
      expr: SUM(CAST(base_price_usd AS DOUBLE))
      comment: "Total catalog value at base pricing in USD"
    - name: "avg_user_review_score"
      expr: AVG(CAST(user_review_score AS DOUBLE))
      comment: "Average user review score across SKUs (quality and satisfaction metric)"
    - name: "distinct_titles"
      expr: COUNT(DISTINCT game_title_id)
      comment: "Count of unique game titles represented by SKUs"
    - name: "distinct_storefronts"
      expr: COUNT(DISTINCT storefront_id)
      comment: "Count of unique storefronts distributing SKUs"
    - name: "cloud_saves_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN supports_cloud_saves = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SKUs supporting cloud save functionality (player retention feature)"
    - name: "crossplay_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN supports_crossplay = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SKUs supporting cross-platform play (strategic feature metric)"
    - name: "achievements_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN supports_achievements = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SKUs with achievement system integration (engagement driver)"
    - name: "leaderboards_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN supports_leaderboards = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SKUs with leaderboard functionality (competitive engagement metric)"
    - name: "early_access_penetration_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_early_access = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SKUs released via early access model (go-to-market strategy indicator)"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`platform_pricing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing strategy and promotional effectiveness metrics tracking base pricing, discounts, and regional pricing dynamics"
  source: "`gaming_ecm`.`platform`.`pricing`"
  dimensions:
    - name: "pricing_status"
      expr: pricing_status
      comment: "Current status of the pricing record (active, expired, pending)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for the pricing change"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the pricing is denominated"
    - name: "price_tier"
      expr: price_tier
      comment: "Pricing tier classification"
    - name: "content_type"
      expr: content_type
      comment: "Type of content being priced (base game, DLC, season pass, etc.)"
    - name: "regional_pricing_strategy"
      expr: regional_pricing_strategy
      comment: "Regional pricing strategy applied (global parity, purchasing power parity, etc.)"
    - name: "price_change_reason"
      expr: price_change_reason
      comment: "Business reason for price adjustment"
    - name: "bundle_eligible_flag"
      expr: bundle_eligible
      comment: "Indicates whether the item is eligible for bundle pricing"
    - name: "price_lock_enabled_flag"
      expr: price_lock_enabled
      comment: "Indicates whether pricing is locked and cannot be changed"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the pricing became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the pricing became effective"
  measures:
    - name: "total_pricing_records"
      expr: COUNT(1)
      comment: "Total number of pricing records"
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base price across all pricing records"
    - name: "avg_promotional_price"
      expr: AVG(CAST(promotional_price AS DOUBLE))
      comment: "Average promotional price when discounts are applied"
    - name: "avg_promotional_discount_pct"
      expr: AVG(CAST(promotional_discount_percentage AS DOUBLE))
      comment: "Average promotional discount percentage (pricing aggressiveness indicator)"
    - name: "avg_platform_revenue_share_pct"
      expr: AVG(CAST(platform_revenue_share_percentage AS DOUBLE))
      comment: "Average platform revenue share percentage (cost of distribution metric)"
    - name: "avg_tax_rate_pct"
      expr: AVG(CAST(tax_rate_percentage AS DOUBLE))
      comment: "Average tax rate applied to pricing"
    - name: "avg_minimum_advertised_price"
      expr: AVG(CAST(minimum_advertised_price AS DOUBLE))
      comment: "Average minimum advertised price floor"
    - name: "avg_recommended_retail_price"
      expr: AVG(CAST(recommended_retail_price AS DOUBLE))
      comment: "Average recommended retail price"
    - name: "distinct_titles"
      expr: COUNT(DISTINCT game_title_id)
      comment: "Count of unique game titles with pricing records"
    - name: "distinct_storefronts"
      expr: COUNT(DISTINCT storefront_id)
      comment: "Count of unique storefronts with pricing records"
    - name: "promotional_penetration_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN promotional_price IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pricing records with active promotional pricing (discount strategy metric)"
    - name: "price_lock_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN price_lock_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pricing records with price lock enabled (pricing stability indicator)"
    - name: "bundle_eligibility_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN bundle_eligible = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of items eligible for bundle pricing (merchandising flexibility metric)"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`platform_cert_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Platform certification submission performance metrics tracking approval rates, cycle times, and compliance quality"
  source: "`gaming_ecm`.`platform`.`cert_submission`"
  dimensions:
    - name: "certification_outcome"
      expr: certification_outcome
      comment: "Final outcome of the certification submission (approved, rejected, conditional)"
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the submission in the certification workflow"
    - name: "submission_type"
      expr: submission_type
      comment: "Type of certification submission (initial, resubmission, patch, etc.)"
    - name: "esrb_rating"
      expr: esrb_rating
      comment: "ESRB content rating assigned during certification"
    - name: "pegi_rating"
      expr: pegi_rating
      comment: "PEGI content rating assigned during certification"
    - name: "waiver_granted_flag"
      expr: waiver_granted
      comment: "Indicates whether a compliance waiver was granted"
    - name: "cross_platform_compatible_flag"
      expr: cross_platform_compatible
      comment: "Indicates whether the submission passed cross-platform compatibility checks"
    - name: "multiplayer_enabled_flag"
      expr: multiplayer_enabled
      comment: "Indicates whether multiplayer functionality is enabled"
    - name: "in_app_purchases_enabled_flag"
      expr: in_app_purchases_enabled
      comment: "Indicates whether in-app purchases are enabled"
    - name: "accessibility_features_included_flag"
      expr: accessibility_features_included
      comment: "Indicates whether accessibility features are included"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the certification was submitted"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the certification was submitted"
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of certification submissions"
    - name: "distinct_titles"
      expr: COUNT(DISTINCT game_title_id)
      comment: "Count of unique game titles submitted for certification"
    - name: "distinct_developers"
      expr: COUNT(DISTINCT developer_account_id)
      comment: "Count of unique developer accounts submitting for certification"
    - name: "distinct_storefronts"
      expr: COUNT(DISTINCT storefront_id)
      comment: "Count of unique storefronts receiving submissions"
    - name: "approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN certification_outcome = 'approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions approved on first attempt (quality and readiness indicator)"
    - name: "rejection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN certification_outcome = 'rejected' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions rejected (compliance risk metric)"
    - name: "waiver_grant_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN waiver_granted = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions receiving compliance waivers (exception management metric)"
    - name: "cross_platform_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cross_platform_compatible = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions passing cross-platform compatibility checks"
    - name: "accessibility_inclusion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN accessibility_features_included = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions including accessibility features (inclusivity metric)"
    - name: "iap_enabled_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN in_app_purchases_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions with in-app purchases enabled (monetization strategy indicator)"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`platform_patch_release`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patch release deployment metrics tracking update frequency, size, rollout strategy, and post-launch support quality"
  source: "`gaming_ecm`.`platform`.`patch_release`"
  dimensions:
    - name: "patch_status"
      expr: patch_status
      comment: "Current deployment status of the patch"
    - name: "patch_type"
      expr: patch_type
      comment: "Type of patch (hotfix, content update, balance patch, etc.)"
    - name: "rollout_strategy"
      expr: rollout_strategy
      comment: "Deployment rollout strategy (phased, immediate, regional, etc.)"
    - name: "download_priority"
      expr: download_priority
      comment: "Download priority classification for the patch"
    - name: "contains_monetization_changes_flag"
      expr: contains_monetization_changes
      comment: "Indicates whether the patch includes monetization changes"
    - name: "privacy_policy_updated_flag"
      expr: privacy_policy_updated
      comment: "Indicates whether the patch updates privacy policy"
    - name: "requires_player_consent_flag"
      expr: requires_player_consent
      comment: "Indicates whether the patch requires explicit player consent"
    - name: "rollback_available_flag"
      expr: rollback_available
      comment: "Indicates whether rollback to previous version is available"
    - name: "is_cross_platform_compatible_flag"
      expr: is_cross_platform_compatible
      comment: "Indicates whether the patch is compatible across platforms"
    - name: "release_year"
      expr: YEAR(release_date)
      comment: "Year the patch was released"
    - name: "release_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month the patch was released"
  measures:
    - name: "total_patches"
      expr: COUNT(1)
      comment: "Total number of patch releases"
    - name: "avg_patch_size_bytes"
      expr: AVG(CAST(patch_size_bytes AS DOUBLE))
      comment: "Average patch download size in bytes (player experience and bandwidth cost metric)"
    - name: "total_patch_size_bytes"
      expr: SUM(CAST(patch_size_bytes AS DOUBLE))
      comment: "Total bandwidth footprint of all patches in bytes"
    - name: "avg_rollout_percentage"
      expr: AVG(CAST(rollout_percentage AS DOUBLE))
      comment: "Average rollout percentage across patches (deployment risk management indicator)"
    - name: "distinct_titles"
      expr: COUNT(DISTINCT game_title_id)
      comment: "Count of unique game titles receiving patches"
    - name: "distinct_storefronts"
      expr: COUNT(DISTINCT storefront_id)
      comment: "Count of unique storefronts distributing patches"
    - name: "monetization_change_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN contains_monetization_changes = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of patches containing monetization changes (revenue optimization activity metric)"
    - name: "privacy_update_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN privacy_policy_updated = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of patches updating privacy policy (compliance activity indicator)"
    - name: "consent_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN requires_player_consent = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of patches requiring player consent (regulatory compliance metric)"
    - name: "rollback_availability_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN rollback_available = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of patches with rollback capability (deployment safety metric)"
    - name: "cross_platform_compatibility_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_cross_platform_compatible = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of patches compatible across platforms (technical quality indicator)"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`platform_drm_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DRM entitlement lifecycle metrics tracking grant activity, revocation rates, and license management effectiveness"
  source: "`gaming_ecm`.`platform`.`drm_entitlement`"
  dimensions:
    - name: "entitlement_type"
      expr: entitlement_type
      comment: "Type of DRM entitlement (perpetual, subscription, rental, etc.)"
    - name: "grant_channel"
      expr: grant_channel
      comment: "Channel through which the entitlement was granted (purchase, promotion, bundle, etc.)"
    - name: "license_scope"
      expr: license_scope
      comment: "Scope of the license (single-user, family, enterprise, etc.)"
    - name: "revocation_status"
      expr: revocation_status
      comment: "Current revocation status of the entitlement"
    - name: "revocation_policy"
      expr: revocation_policy
      comment: "Revocation policy applied to the entitlement"
    - name: "expiry_rule"
      expr: expiry_rule
      comment: "Rule governing entitlement expiration"
    - name: "offline_play_allowed_flag"
      expr: offline_play_allowed
      comment: "Indicates whether offline play is permitted"
    - name: "family_share_enabled_flag"
      expr: family_share_enabled
      comment: "Indicates whether family sharing is enabled"
    - name: "transfer_allowed_flag"
      expr: transfer_allowed
      comment: "Indicates whether entitlement transfer is allowed"
    - name: "region_lock_enabled_flag"
      expr: region_lock_enabled
      comment: "Indicates whether regional restrictions are enforced"
    - name: "grant_year"
      expr: YEAR(grant_timestamp)
      comment: "Year the entitlement was granted"
    - name: "grant_month"
      expr: DATE_TRUNC('MONTH', grant_timestamp)
      comment: "Month the entitlement was granted"
  measures:
    - name: "total_entitlements"
      expr: COUNT(1)
      comment: "Total number of DRM entitlements granted"
    - name: "distinct_players"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Count of unique players with entitlements"
    - name: "distinct_skus"
      expr: COUNT(DISTINCT platform_sku_id)
      comment: "Count of unique SKUs with entitlements"
    - name: "distinct_storefronts"
      expr: COUNT(DISTINCT storefront_id)
      comment: "Count of unique storefronts issuing entitlements"
    - name: "revocation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN revocation_status IS NOT NULL AND revocation_status != 'none' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of entitlements revoked (fraud and abuse indicator)"
    - name: "offline_play_allowance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN offline_play_allowed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of entitlements permitting offline play (player flexibility metric)"
    - name: "family_share_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN family_share_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of entitlements with family sharing enabled (household penetration driver)"
    - name: "transfer_allowance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN transfer_allowed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of entitlements allowing transfer (secondary market flexibility)"
    - name: "region_lock_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN region_lock_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of entitlements with regional restrictions (geo-licensing compliance metric)"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`platform_developer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Developer account health and engagement metrics tracking enrollment, access levels, and partnership status"
  source: "`gaming_ecm`.`platform`.`developer_account`"
  dimensions:
    - name: "account_tier"
      expr: account_tier
      comment: "Developer account tier classification (indie, pro, enterprise, etc.)"
    - name: "account_type"
      expr: account_type
      comment: "Type of developer account (individual, studio, publisher, etc.)"
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status of the developer account"
    - name: "contract_status"
      expr: contract_status
      comment: "Status of the developer contract"
    - name: "revenue_threshold_tier"
      expr: revenue_threshold_tier
      comment: "Revenue-based tier classification"
    - name: "sdk_access_level"
      expr: sdk_access_level
      comment: "Level of SDK access granted to the developer"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the developer account"
    - name: "certification_access_flag"
      expr: certification_access_flag
      comment: "Indicates whether the developer has certification access"
    - name: "dev_kit_access_flag"
      expr: dev_kit_access_flag
      comment: "Indicates whether the developer has dev kit access"
    - name: "drm_entitlement_access_flag"
      expr: drm_entitlement_access
      comment: "Indicates whether the developer has DRM entitlement access"
    - name: "cross_platform_enabled_flag"
      expr: cross_platform_enabled
      comment: "Indicates whether cross-platform development is enabled"
    - name: "two_factor_auth_enabled_flag"
      expr: two_factor_auth_enabled
      comment: "Indicates whether two-factor authentication is enabled"
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year the developer enrolled"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month the developer enrolled"
  measures:
    - name: "total_developer_accounts"
      expr: COUNT(1)
      comment: "Total number of developer accounts"
    - name: "active_developer_accounts"
      expr: SUM(CASE WHEN enrollment_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active developer accounts (ecosystem health indicator)"
    - name: "certification_access_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN certification_access_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of developers with certification access (readiness metric)"
    - name: "dev_kit_access_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN dev_kit_access_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of developers with dev kit access (development enablement metric)"
    - name: "drm_access_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN drm_entitlement_access = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of developers with DRM entitlement access (monetization readiness)"
    - name: "cross_platform_enablement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cross_platform_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of developers enabled for cross-platform development (strategic capability metric)"
    - name: "two_factor_auth_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN two_factor_auth_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of developers with two-factor authentication enabled (security posture metric)"
    - name: "suspended_account_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN suspension_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of developer accounts suspended (compliance and quality risk indicator)"
    - name: "terminated_account_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN termination_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of developer accounts terminated (partnership attrition metric)"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`platform_sdk_integration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SDK integration adoption and feature enablement metrics tracking platform service usage and technical capability adoption"
  source: "`gaming_ecm`.`platform`.`sdk_integration`"
  dimensions:
    - name: "sdk_name"
      expr: sdk_name
      comment: "Name of the SDK integrated"
    - name: "sdk_version"
      expr: sdk_version
      comment: "Version of the SDK integrated"
    - name: "integration_status"
      expr: integration_status
      comment: "Current status of the SDK integration"
    - name: "certification_compliance_status"
      expr: certification_compliance_status
      comment: "Certification compliance status of the integration"
    - name: "achievements_enabled_flag"
      expr: achievements_enabled
      comment: "Indicates whether achievements are enabled"
    - name: "analytics_enabled_flag"
      expr: analytics_enabled
      comment: "Indicates whether analytics are enabled"
    - name: "cloud_saves_enabled_flag"
      expr: cloud_saves_enabled
      comment: "Indicates whether cloud saves are enabled"
    - name: "cross_play_enabled_flag"
      expr: cross_play_enabled
      comment: "Indicates whether cross-play is enabled"
    - name: "drm_enabled_flag"
      expr: drm_enabled
      comment: "Indicates whether DRM is enabled"
    - name: "iap_enabled_flag"
      expr: iap_enabled
      comment: "Indicates whether in-app purchases are enabled"
    - name: "leaderboards_enabled_flag"
      expr: leaderboards_enabled
      comment: "Indicates whether leaderboards are enabled"
    - name: "matchmaking_enabled_flag"
      expr: matchmaking_enabled
      comment: "Indicates whether matchmaking is enabled"
    - name: "voice_chat_enabled_flag"
      expr: voice_chat_enabled
      comment: "Indicates whether voice chat is enabled"
    - name: "integration_year"
      expr: YEAR(integration_date)
      comment: "Year the SDK was integrated"
    - name: "integration_month"
      expr: DATE_TRUNC('MONTH', integration_date)
      comment: "Month the SDK was integrated"
  measures:
    - name: "total_integrations"
      expr: COUNT(1)
      comment: "Total number of SDK integrations"
    - name: "distinct_titles"
      expr: COUNT(DISTINCT game_title_id)
      comment: "Count of unique game titles with SDK integrations"
    - name: "distinct_developers"
      expr: COUNT(DISTINCT developer_account_id)
      comment: "Count of unique developers with SDK integrations"
    - name: "achievements_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN achievements_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of integrations with achievements enabled (engagement feature adoption)"
    - name: "analytics_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN analytics_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of integrations with analytics enabled (data-driven development metric)"
    - name: "cloud_saves_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cloud_saves_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of integrations with cloud saves enabled (retention feature adoption)"
    - name: "cross_play_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cross_play_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of integrations with cross-play enabled (strategic feature metric)"
    - name: "drm_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN drm_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of integrations with DRM enabled (content protection metric)"
    - name: "iap_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN iap_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of integrations with in-app purchases enabled (monetization capability metric)"
    - name: "leaderboards_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN leaderboards_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of integrations with leaderboards enabled (competitive engagement driver)"
    - name: "matchmaking_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN matchmaking_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of integrations with matchmaking enabled (multiplayer enablement metric)"
    - name: "voice_chat_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN voice_chat_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of integrations with voice chat enabled (social feature adoption)"
$$;