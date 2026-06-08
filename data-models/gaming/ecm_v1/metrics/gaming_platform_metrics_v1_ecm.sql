-- Metric views for domain: platform | Business: Gaming | Version: 1 | Generated on: 2026-05-08 07:57:15

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`platform_build_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Build submission lifecycle metrics tracking submission volume, approval rates, build quality, and certification efficiency for game builds submitted to platform holders."
  source: "`gaming_ecm`.`platform`.`build_submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the build submission (e.g., pending, approved, rejected)"
    - name: "build_type"
      expr: build_type
      comment: "Type of build submitted (e.g., alpha, beta, release candidate, gold master)"
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the build was submitted"
    - name: "is_gold_master"
      expr: is_gold_master
      comment: "Flag indicating whether this is a gold master build ready for release"
    - name: "is_cross_platform"
      expr: is_cross_platform
      comment: "Flag indicating whether the build supports cross-platform play"
    - name: "requires_day_one_patch"
      expr: requires_day_one_patch
      comment: "Flag indicating whether the build requires a day-one patch"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month when the build was submitted"
    - name: "submission_year"
      expr: YEAR(submission_timestamp)
      comment: "Year when the build was submitted"
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of build submissions"
    - name: "approved_submissions"
      expr: COUNT(CASE WHEN approved_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of submissions that were approved"
    - name: "rejected_submissions"
      expr: COUNT(CASE WHEN rejected_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of submissions that were rejected"
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approved_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions that were approved - key quality indicator for build readiness"
    - name: "total_build_size_gb"
      expr: SUM(CAST(build_size_bytes AS DOUBLE)) / 1073741824.0
      comment: "Total size of all builds in gigabytes"
    - name: "avg_build_size_gb"
      expr: AVG(CAST(build_size_bytes AS DOUBLE)) / 1073741824.0
      comment: "Average build size in gigabytes - important for distribution planning and player download experience"
    - name: "avg_validation_duration_hours"
      expr: AVG(CAST(UNIX_TIMESTAMP(validation_completed_timestamp) - UNIX_TIMESTAMP(validation_started_timestamp) AS DOUBLE)) / 3600.0
      comment: "Average time in hours for validation to complete - key efficiency metric for certification pipeline"
    - name: "avg_packaging_duration_hours"
      expr: AVG(CAST(UNIX_TIMESTAMP(packaging_completed_timestamp) - UNIX_TIMESTAMP(packaging_started_timestamp) AS DOUBLE)) / 3600.0
      comment: "Average time in hours for packaging to complete - operational efficiency indicator"
    - name: "avg_upload_duration_hours"
      expr: AVG(CAST(UNIX_TIMESTAMP(upload_completed_timestamp) - UNIX_TIMESTAMP(upload_started_timestamp) AS DOUBLE)) / 3600.0
      comment: "Average time in hours for upload to complete - infrastructure performance metric"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`platform_certification_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Platform certification metrics tracking approval rates, certification costs, issue resolution, and compliance status for game titles across storefronts."
  source: "`gaming_ecm`.`platform`.`certification_certificate`"
  dimensions:
    - name: "certificate_status"
      expr: certificate_status
      comment: "Current status of the certification certificate"
    - name: "certificate_type"
      expr: certificate_type
      comment: "Type of certification certificate"
    - name: "certification_region"
      expr: certification_region
      comment: "Geographic region for which the certificate is valid"
    - name: "age_rating"
      expr: age_rating
      comment: "Age rating assigned to the game"
    - name: "cross_platform_compatible"
      expr: cross_platform_compatible
      comment: "Flag indicating cross-platform compatibility"
    - name: "resubmission_required"
      expr: resubmission_required
      comment: "Flag indicating whether resubmission is required"
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month when the certificate was approved"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year when the certificate was approved"
  measures:
    - name: "total_certificates"
      expr: COUNT(1)
      comment: "Total number of certification certificates"
    - name: "total_certification_fees"
      expr: SUM(CAST(certification_fee_amount AS DOUBLE))
      comment: "Total certification fees paid across all certificates - key cost metric for platform compliance"
    - name: "avg_certification_fee"
      expr: AVG(CAST(certification_fee_amount AS DOUBLE))
      comment: "Average certification fee per certificate - cost planning metric"
    - name: "avg_review_duration_days"
      expr: AVG(CAST(DATEDIFF(approval_date, review_start_date) AS DOUBLE))
      comment: "Average number of days from review start to approval - critical time-to-market metric"
    - name: "resubmission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN resubmission_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certificates requiring resubmission - quality and process efficiency indicator"
    - name: "first_time_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN resubmission_required = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certificates passing on first submission - key quality metric for development process"
    - name: "avg_critical_issues"
      expr: AVG(CAST(critical_issues_count AS DOUBLE))
      comment: "Average number of critical issues per certificate - quality indicator"
    - name: "avg_major_issues"
      expr: AVG(CAST(major_issues_count AS DOUBLE))
      comment: "Average number of major issues per certificate - quality indicator"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`platform_cert_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Platform certification submission metrics tracking submission outcomes, review efficiency, failure analysis, and waiver management for game certification processes."
  source: "`gaming_ecm`.`platform`.`platform_cert_submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the certification submission"
    - name: "submission_type"
      expr: submission_type
      comment: "Type of certification submission"
    - name: "certification_outcome"
      expr: certification_outcome
      comment: "Final outcome of the certification process"
    - name: "cross_platform_compatible"
      expr: cross_platform_compatible
      comment: "Flag indicating cross-platform compatibility"
    - name: "multiplayer_enabled"
      expr: multiplayer_enabled
      comment: "Flag indicating multiplayer functionality"
    - name: "in_app_purchases_enabled"
      expr: in_app_purchases_enabled
      comment: "Flag indicating in-app purchase functionality"
    - name: "waiver_granted"
      expr: waiver_granted
      comment: "Flag indicating whether a waiver was granted"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month when the submission was made"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year when the submission was made"
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of certification submissions"
    - name: "avg_review_duration_days"
      expr: AVG(CAST(DATEDIFF(review_completion_date, review_start_date) AS DOUBLE))
      comment: "Average number of days from review start to completion - critical time-to-market efficiency metric"
    - name: "avg_failure_count"
      expr: AVG(CAST(failure_count AS DOUBLE))
      comment: "Average number of failures per submission - quality indicator for submission readiness"
    - name: "waiver_grant_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN waiver_granted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions granted waivers - indicates flexibility in certification process"
    - name: "on_time_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN review_completion_date <= target_release_date THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions completed by target release date - critical schedule adherence metric"
    - name: "resubmission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN resubmission_deadline IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions requiring resubmission - quality and process efficiency indicator"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`platform_storefront_listing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storefront listing performance metrics tracking listing quality, review scores, content ratings, and feature adoption across digital storefronts."
  source: "`gaming_ecm`.`platform`.`storefront_listing`"
  dimensions:
    - name: "listing_status"
      expr: listing_status
      comment: "Current status of the storefront listing"
    - name: "content_rating"
      expr: content_rating
      comment: "Content rating assigned to the game"
    - name: "primary_category"
      expr: primary_category
      comment: "Primary category under which the game is listed"
    - name: "localization_language_code"
      expr: localization_language_code
      comment: "Language code for the listing localization"
    - name: "cross_platform_play"
      expr: cross_platform_play
      comment: "Flag indicating cross-platform play support"
    - name: "multiplayer_support"
      expr: multiplayer_support
      comment: "Flag indicating multiplayer support"
    - name: "in_app_purchases"
      expr: in_app_purchases
      comment: "Flag indicating in-app purchase availability"
    - name: "release_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month when the game was released"
    - name: "release_year"
      expr: YEAR(release_date)
      comment: "Year when the game was released"
  measures:
    - name: "total_listings"
      expr: COUNT(1)
      comment: "Total number of storefront listings"
    - name: "avg_review_score"
      expr: AVG(CAST(aggregate_review_score AS DOUBLE))
      comment: "Average review score across all listings - critical quality and player satisfaction metric"
    - name: "total_reviews"
      expr: SUM(CAST(review_count AS DOUBLE))
      comment: "Total number of reviews across all listings - engagement and reach indicator"
    - name: "avg_reviews_per_listing"
      expr: AVG(CAST(review_count AS DOUBLE))
      comment: "Average number of reviews per listing - engagement metric"
    - name: "avg_file_size_gb"
      expr: AVG(CAST(file_size_mb AS DOUBLE)) / 1024.0
      comment: "Average file size in gigabytes - important for player download experience and storage planning"
    - name: "cross_platform_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cross_platform_play = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of listings supporting cross-platform play - strategic feature adoption metric"
    - name: "multiplayer_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN multiplayer_support = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of listings with multiplayer support - feature adoption metric"
    - name: "iap_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN in_app_purchases = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of listings with in-app purchases - monetization strategy adoption metric"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`platform_pricing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing strategy metrics tracking price points, promotional effectiveness, regional pricing variations, and revenue share across platforms and regions."
  source: "`gaming_ecm`.`platform`.`pricing`"
  dimensions:
    - name: "pricing_status"
      expr: pricing_status
      comment: "Current status of the pricing record"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the pricing"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the pricing"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region code for the pricing"
    - name: "price_tier"
      expr: price_tier
      comment: "Pricing tier classification"
    - name: "content_type"
      expr: content_type
      comment: "Type of content being priced"
    - name: "bundle_eligible"
      expr: bundle_eligible
      comment: "Flag indicating bundle eligibility"
    - name: "price_lock_enabled"
      expr: price_lock_enabled
      comment: "Flag indicating whether price is locked"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month when the pricing becomes effective"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year when the pricing becomes effective"
  measures:
    - name: "total_pricing_records"
      expr: COUNT(1)
      comment: "Total number of pricing records"
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base price across all pricing records - key pricing strategy metric"
    - name: "avg_promotional_price"
      expr: AVG(CAST(promotional_price AS DOUBLE))
      comment: "Average promotional price - discount strategy metric"
    - name: "avg_promotional_discount_pct"
      expr: AVG(CAST(promotional_discount_percentage AS DOUBLE))
      comment: "Average promotional discount percentage - promotional effectiveness indicator"
    - name: "avg_platform_revenue_share_pct"
      expr: AVG(CAST(platform_revenue_share_percentage AS DOUBLE))
      comment: "Average platform revenue share percentage - critical profitability metric for platform economics"
    - name: "avg_tax_rate_pct"
      expr: AVG(CAST(tax_rate_percentage AS DOUBLE))
      comment: "Average tax rate percentage - financial planning metric"
    - name: "promotional_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN promotional_price IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pricing records with active promotions - promotional strategy coverage metric"
    - name: "avg_price_reduction_pct"
      expr: AVG(CAST((base_price - previous_base_price) AS DOUBLE) / NULLIF(CAST(previous_base_price AS DOUBLE), 0) * 100.0)
      comment: "Average percentage change in base price - pricing trend indicator"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`platform_release_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Release schedule performance metrics tracking on-time delivery, delays, regional rollout, and launch readiness across platforms and regions."
  source: "`gaming_ecm`.`platform`.`release_schedule`"
  dimensions:
    - name: "release_status"
      expr: release_status
      comment: "Current status of the release"
    - name: "release_type"
      expr: release_type
      comment: "Type of release (e.g., new release, update, DLC)"
    - name: "platform_approval_status"
      expr: platform_approval_status
      comment: "Platform holder approval status"
    - name: "launch_edition"
      expr: launch_edition
      comment: "Edition of the game being launched"
    - name: "release_region_scope"
      expr: release_region_scope
      comment: "Geographic scope of the release"
    - name: "cross_platform_enabled"
      expr: cross_platform_enabled
      comment: "Flag indicating cross-platform support"
    - name: "day_one_patch_required"
      expr: day_one_patch_required
      comment: "Flag indicating whether a day-one patch is required"
    - name: "physical_release"
      expr: physical_release
      comment: "Flag indicating physical release availability"
    - name: "mtx_enabled"
      expr: mtx_enabled
      comment: "Flag indicating microtransaction availability"
    - name: "dlc_available"
      expr: dlc_available
      comment: "Flag indicating DLC availability"
    - name: "planned_release_month"
      expr: DATE_TRUNC('MONTH', planned_release_date)
      comment: "Month of planned release"
    - name: "planned_release_year"
      expr: YEAR(planned_release_date)
      comment: "Year of planned release"
  measures:
    - name: "total_releases"
      expr: COUNT(1)
      comment: "Total number of scheduled releases"
    - name: "on_time_release_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_release_date <= planned_release_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_release_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of releases delivered on or before planned date - critical schedule adherence and execution metric"
    - name: "avg_delay_days"
      expr: AVG(CAST(DATEDIFF(actual_release_date, planned_release_date) AS DOUBLE))
      comment: "Average number of days releases are delayed - project management efficiency indicator"
    - name: "avg_preorder_discount_pct"
      expr: AVG(CAST(preorder_discount_percent AS DOUBLE))
      comment: "Average preorder discount percentage - promotional strategy metric"
    - name: "avg_release_price"
      expr: AVG(CAST(release_price AS DOUBLE))
      comment: "Average release price - pricing strategy metric"
    - name: "day_one_patch_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN day_one_patch_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of releases requiring day-one patches - quality and readiness indicator"
    - name: "cross_platform_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cross_platform_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of releases with cross-platform support - strategic feature adoption metric"
    - name: "mtx_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mtx_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of releases with microtransactions enabled - monetization strategy adoption metric"
    - name: "avg_gold_master_to_release_days"
      expr: AVG(CAST(DATEDIFF(actual_release_date, gold_master_date) AS DOUBLE))
      comment: "Average days from gold master to actual release - manufacturing and distribution efficiency metric"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`platform_drm_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DRM entitlement metrics tracking grant volume, revocation rates, family sharing adoption, and license management across platforms."
  source: "`gaming_ecm`.`platform`.`drm_entitlement`"
  dimensions:
    - name: "entitlement_type"
      expr: entitlement_type
      comment: "Type of DRM entitlement"
    - name: "grant_channel"
      expr: grant_channel
      comment: "Channel through which the entitlement was granted"
    - name: "license_scope"
      expr: license_scope
      comment: "Scope of the license"
    - name: "revocation_status"
      expr: revocation_status
      comment: "Current revocation status"
    - name: "expiry_rule"
      expr: expiry_rule
      comment: "Rule governing entitlement expiry"
    - name: "family_share_enabled"
      expr: family_share_enabled
      comment: "Flag indicating family sharing is enabled"
    - name: "offline_play_allowed"
      expr: offline_play_allowed
      comment: "Flag indicating offline play is allowed"
    - name: "region_lock_enabled"
      expr: region_lock_enabled
      comment: "Flag indicating region lock is enabled"
    - name: "transfer_allowed"
      expr: transfer_allowed
      comment: "Flag indicating transfer is allowed"
    - name: "grant_month"
      expr: DATE_TRUNC('MONTH', grant_timestamp)
      comment: "Month when the entitlement was granted"
    - name: "grant_year"
      expr: YEAR(grant_timestamp)
      comment: "Year when the entitlement was granted"
  measures:
    - name: "total_entitlements"
      expr: COUNT(1)
      comment: "Total number of DRM entitlements granted"
    - name: "active_entitlements"
      expr: COUNT(CASE WHEN revocation_timestamp IS NULL AND (grant_expiry_timestamp IS NULL OR grant_expiry_timestamp > CURRENT_TIMESTAMP) THEN 1 END)
      comment: "Number of currently active entitlements - key metric for active license base"
    - name: "revoked_entitlements"
      expr: COUNT(CASE WHEN revocation_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of revoked entitlements"
    - name: "revocation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN revocation_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of entitlements that have been revoked - fraud and abuse indicator"
    - name: "family_share_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN family_share_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of entitlements with family sharing enabled - feature adoption and player value metric"
    - name: "offline_play_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN offline_play_allowed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of entitlements allowing offline play - player experience metric"
    - name: "transfer_allowed_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN transfer_allowed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of entitlements allowing transfer - license flexibility metric"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`platform_compliance_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Platform compliance event metrics tracking violation frequency, remediation effectiveness, financial penalties, and escalation patterns for regulatory and platform policy adherence."
  source: "`gaming_ecm`.`platform`.`compliance_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of compliance event"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the compliance event"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the compliance event"
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation efforts"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Flag indicating whether the event was escalated"
    - name: "platform_suspension_flag"
      expr: platform_suspension_flag
      comment: "Flag indicating whether platform suspension occurred"
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Flag indicating whether this is a recurring event"
    - name: "originating_entity_type"
      expr: originating_entity_type
      comment: "Type of entity that originated the event"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month when the event occurred"
    - name: "event_year"
      expr: YEAR(event_timestamp)
      comment: "Year when the event occurred"
  measures:
    - name: "total_compliance_events"
      expr: COUNT(1)
      comment: "Total number of compliance events - overall compliance health indicator"
    - name: "total_financial_penalties"
      expr: SUM(CAST(financial_penalty_amount AS DOUBLE))
      comment: "Total financial penalties incurred - critical cost of non-compliance metric"
    - name: "avg_financial_penalty"
      expr: AVG(CAST(financial_penalty_amount AS DOUBLE))
      comment: "Average financial penalty per event - risk severity indicator"
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events that were escalated - severity and management attention indicator"
    - name: "platform_suspension_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN platform_suspension_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events resulting in platform suspension - critical business continuity risk metric"
    - name: "recurrence_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recurring compliance events - process effectiveness and learning indicator"
    - name: "avg_resolution_time_days"
      expr: AVG(CAST(DATEDIFF(resolution_timestamp, event_timestamp) AS DOUBLE))
      comment: "Average days to resolve compliance events - remediation efficiency metric"
    - name: "resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN resolution_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events that have been resolved - compliance management effectiveness metric"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`platform_sdk_integration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SDK integration metrics tracking feature adoption, certification compliance, integration health, and deprecation management across platform SDKs."
  source: "`gaming_ecm`.`platform`.`sdk_integration`"
  dimensions:
    - name: "sdk_name"
      expr: sdk_name
      comment: "Name of the SDK being integrated"
    - name: "sdk_version"
      expr: sdk_version
      comment: "Version of the SDK"
    - name: "integration_status"
      expr: integration_status
      comment: "Current status of the SDK integration"
    - name: "certification_compliance_status"
      expr: certification_compliance_status
      comment: "Certification compliance status"
    - name: "achievements_enabled"
      expr: achievements_enabled
      comment: "Flag indicating achievements are enabled"
    - name: "analytics_enabled"
      expr: analytics_enabled
      comment: "Flag indicating analytics are enabled"
    - name: "cloud_saves_enabled"
      expr: cloud_saves_enabled
      comment: "Flag indicating cloud saves are enabled"
    - name: "cross_play_enabled"
      expr: cross_play_enabled
      comment: "Flag indicating cross-play is enabled"
    - name: "drm_enabled"
      expr: drm_enabled
      comment: "Flag indicating DRM is enabled"
    - name: "iap_enabled"
      expr: iap_enabled
      comment: "Flag indicating in-app purchases are enabled"
    - name: "leaderboards_enabled"
      expr: leaderboards_enabled
      comment: "Flag indicating leaderboards are enabled"
    - name: "matchmaking_enabled"
      expr: matchmaking_enabled
      comment: "Flag indicating matchmaking is enabled"
    - name: "voice_chat_enabled"
      expr: voice_chat_enabled
      comment: "Flag indicating voice chat is enabled"
    - name: "integration_month"
      expr: DATE_TRUNC('MONTH', integration_date)
      comment: "Month when the SDK was integrated"
    - name: "integration_year"
      expr: YEAR(integration_date)
      comment: "Year when the SDK was integrated"
  measures:
    - name: "total_integrations"
      expr: COUNT(1)
      comment: "Total number of SDK integrations"
    - name: "achievements_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN achievements_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of integrations with achievements enabled - player engagement feature adoption"
    - name: "analytics_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN analytics_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of integrations with analytics enabled - data-driven decision capability metric"
    - name: "cloud_saves_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cloud_saves_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of integrations with cloud saves enabled - player experience feature adoption"
    - name: "cross_play_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cross_play_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of integrations with cross-play enabled - strategic feature adoption metric"
    - name: "drm_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN drm_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of integrations with DRM enabled - content protection strategy metric"
    - name: "iap_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN iap_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of integrations with IAP enabled - monetization capability adoption metric"
    - name: "matchmaking_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN matchmaking_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of integrations with matchmaking enabled - multiplayer feature adoption"
    - name: "voice_chat_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN voice_chat_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of integrations with voice chat enabled - social feature adoption metric"
    - name: "certification_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_compliance_status = 'compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of integrations that are certification compliant - compliance health indicator"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`platform_patch_release`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patch release metrics tracking patch deployment efficiency, size optimization, rollout strategy effectiveness, and certification compliance for game updates."
  source: "`gaming_ecm`.`platform`.`patch_release`"
  dimensions:
    - name: "patch_status"
      expr: patch_status
      comment: "Current status of the patch release"
    - name: "patch_type"
      expr: patch_type
      comment: "Type of patch (e.g., hotfix, content update, balance patch)"
    - name: "certification_status"
      expr: certification_status
      comment: "Certification status of the patch"
    - name: "rollout_strategy"
      expr: rollout_strategy
      comment: "Strategy used for patch rollout"
    - name: "contains_monetization_changes"
      expr: contains_monetization_changes
      comment: "Flag indicating monetization changes in the patch"
    - name: "is_cross_platform_compatible"
      expr: is_cross_platform_compatible
      comment: "Flag indicating cross-platform compatibility"
    - name: "rollback_available"
      expr: rollback_available
      comment: "Flag indicating rollback capability"
    - name: "privacy_policy_updated"
      expr: privacy_policy_updated
      comment: "Flag indicating privacy policy update"
    - name: "requires_player_consent"
      expr: requires_player_consent
      comment: "Flag indicating player consent requirement"
    - name: "release_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month when the patch was released"
    - name: "release_year"
      expr: YEAR(release_date)
      comment: "Year when the patch was released"
  measures:
    - name: "total_patches"
      expr: COUNT(1)
      comment: "Total number of patch releases"
    - name: "total_patch_size_gb"
      expr: SUM(CAST(patch_size_bytes AS DOUBLE)) / 1073741824.0
      comment: "Total size of all patches in gigabytes - infrastructure and player download impact metric"
    - name: "avg_patch_size_gb"
      expr: AVG(CAST(patch_size_bytes AS DOUBLE)) / 1073741824.0
      comment: "Average patch size in gigabytes - player experience and distribution efficiency metric"
    - name: "avg_rollout_percentage"
      expr: AVG(CAST(rollout_percentage AS DOUBLE))
      comment: "Average rollout percentage - deployment strategy metric"
    - name: "avg_estimated_install_time_minutes"
      expr: AVG(CAST(estimated_install_time_minutes AS DOUBLE))
      comment: "Average estimated install time in minutes - player experience metric"
    - name: "avg_submission_to_release_days"
      expr: AVG(CAST(DATEDIFF(release_date, submission_date) AS DOUBLE))
      comment: "Average days from submission to release - patch deployment efficiency metric"
    - name: "avg_certification_to_release_days"
      expr: AVG(CAST(DATEDIFF(release_date, certification_date) AS DOUBLE))
      comment: "Average days from certification to release - deployment pipeline efficiency"
    - name: "cross_platform_compatibility_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_cross_platform_compatible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of patches that are cross-platform compatible - platform strategy metric"
    - name: "rollback_availability_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rollback_available = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of patches with rollback capability - risk management and deployment safety metric"
    - name: "monetization_change_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN contains_monetization_changes = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of patches containing monetization changes - revenue optimization activity indicator"
$$;