-- Metric views for domain: content | Business: Gaming | Version: 1 | Generated on: 2026-05-08 09:42:21

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`content_release`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for content release performance, deployment efficiency, and player impact across platforms and storefronts"
  source: "`gaming_ecm`.`content`.`content_release`"
  dimensions:
    - name: "release_type"
      expr: release_type
      comment: "Type of content release (e.g., major update, seasonal event, patch)"
    - name: "release_status"
      expr: release_status
      comment: "Current status of the release (e.g., planned, in-progress, live, rolled-back)"
    - name: "deployment_status"
      expr: deployment_status
      comment: "Deployment status indicating rollout progress"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for release governance"
    - name: "patch_type"
      expr: patch_type
      comment: "Type of patch included in release"
    - name: "target_platforms"
      expr: target_platforms
      comment: "Platforms targeted by this release"
    - name: "cdn_distribution_status"
      expr: cdn_distribution_status
      comment: "CDN distribution status for content delivery"
    - name: "trc_tcr_certification_status"
      expr: trc_tcr_certification_status
      comment: "Platform certification status (TRC/TCR compliance)"
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Whether the release is mandatory for players"
    - name: "release_year"
      expr: YEAR(scheduled_go_live_timestamp)
      comment: "Year of scheduled go-live"
    - name: "release_month"
      expr: DATE_TRUNC('MONTH', scheduled_go_live_timestamp)
      comment: "Month of scheduled go-live"
    - name: "release_quarter"
      expr: DATE_TRUNC('QUARTER', scheduled_go_live_timestamp)
      comment: "Quarter of scheduled go-live"
  measures:
    - name: "total_releases"
      expr: COUNT(1)
      comment: "Total number of content releases"
    - name: "total_download_size_pc_mb"
      expr: SUM(CAST(download_size_mb_pc AS DOUBLE))
      comment: "Total download size for PC platform in megabytes"
    - name: "total_download_size_console_mb"
      expr: SUM(CAST(download_size_mb_console AS DOUBLE))
      comment: "Total download size for console platform in megabytes"
    - name: "total_download_size_mobile_mb"
      expr: SUM(CAST(download_size_mb_mobile AS DOUBLE))
      comment: "Total download size for mobile platform in megabytes"
    - name: "avg_download_size_pc_mb"
      expr: AVG(CAST(download_size_mb_pc AS DOUBLE))
      comment: "Average download size per release for PC platform"
    - name: "avg_download_size_console_mb"
      expr: AVG(CAST(download_size_mb_console AS DOUBLE))
      comment: "Average download size per release for console platform"
    - name: "avg_download_size_mobile_mb"
      expr: AVG(CAST(download_size_mb_mobile AS DOUBLE))
      comment: "Average download size per release for mobile platform"
    - name: "avg_player_feedback_score"
      expr: AVG(CAST(player_feedback_score AS DOUBLE))
      comment: "Average player feedback score across releases, indicating player satisfaction"
    - name: "rollback_count"
      expr: COUNT(CASE WHEN rollback_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of releases that were rolled back, indicating deployment quality issues"
    - name: "rollback_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rollback_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of releases rolled back, key quality and risk metric"
    - name: "mandatory_release_count"
      expr: COUNT(CASE WHEN mandatory_flag = TRUE THEN 1 END)
      comment: "Number of mandatory releases requiring player action"
    - name: "mandatory_release_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mandatory_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of releases that are mandatory, impacting player experience"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`content_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for content deployment efficiency, downtime impact, and deployment quality across environments and regions"
  source: "`gaming_ecm`.`content`.`content_deployment`"
  dimensions:
    - name: "deployment_status"
      expr: deployment_status
      comment: "Current status of the deployment"
    - name: "deployment_type"
      expr: deployment_type
      comment: "Type of deployment (e.g., full, incremental, hotfix)"
    - name: "deployment_method"
      expr: deployment_method
      comment: "Method used for deployment"
    - name: "target_environment"
      expr: target_environment
      comment: "Target environment (e.g., production, staging, dev)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for deployment governance"
    - name: "cdn_distribution_status"
      expr: cdn_distribution_status
      comment: "CDN distribution status"
    - name: "post_deployment_validation_status"
      expr: post_deployment_validation_status
      comment: "Validation status after deployment"
    - name: "rollback_flag"
      expr: rollback_flag
      comment: "Whether the deployment was rolled back"
    - name: "downtime_required_flag"
      expr: downtime_required_flag
      comment: "Whether downtime was required for deployment"
    - name: "player_impact_level"
      expr: player_impact_level
      comment: "Level of impact on players (e.g., high, medium, low)"
    - name: "deployment_year"
      expr: YEAR(deployment_timestamp)
      comment: "Year of deployment"
    - name: "deployment_month"
      expr: DATE_TRUNC('MONTH', deployment_timestamp)
      comment: "Month of deployment"
    - name: "deployment_week"
      expr: DATE_TRUNC('WEEK', deployment_timestamp)
      comment: "Week of deployment"
  measures:
    - name: "total_deployments"
      expr: COUNT(1)
      comment: "Total number of content deployments"
    - name: "total_asset_bundle_size_mb"
      expr: SUM(CAST(asset_bundle_size_mb AS DOUBLE))
      comment: "Total size of asset bundles deployed in megabytes"
    - name: "avg_asset_bundle_size_mb"
      expr: AVG(CAST(asset_bundle_size_mb AS DOUBLE))
      comment: "Average asset bundle size per deployment"
    - name: "rollback_count"
      expr: COUNT(CASE WHEN rollback_flag = TRUE THEN 1 END)
      comment: "Number of deployments rolled back, indicating deployment quality"
    - name: "rollback_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rollback_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deployments rolled back, key operational quality metric"
    - name: "downtime_required_count"
      expr: COUNT(CASE WHEN downtime_required_flag = TRUE THEN 1 END)
      comment: "Number of deployments requiring downtime"
    - name: "downtime_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN downtime_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deployments requiring downtime, impacting player availability"
    - name: "high_player_impact_count"
      expr: COUNT(CASE WHEN player_impact_level = 'high' THEN 1 END)
      comment: "Number of deployments with high player impact"
    - name: "high_player_impact_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN player_impact_level = 'high' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deployments with high player impact, key risk metric"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`content_seasonal_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for seasonal event performance, player engagement lift, revenue impact, and live-ops effectiveness"
  source: "`gaming_ecm`.`content`.`seasonal_event`"
  dimensions:
    - name: "event_status"
      expr: event_status
      comment: "Current status of the seasonal event"
    - name: "event_type"
      expr: event_type
      comment: "Type of seasonal event (e.g., holiday, competitive, community)"
    - name: "event_theme"
      expr: event_theme
      comment: "Theme of the event"
    - name: "certification_status"
      expr: certification_status
      comment: "Certification status for compliance"
    - name: "qa_status"
      expr: qa_status
      comment: "Quality assurance status"
    - name: "localization_status"
      expr: localization_status
      comment: "Localization status for multi-region support"
    - name: "recurrence_pattern"
      expr: recurrence_pattern
      comment: "Recurrence pattern (e.g., annual, quarterly, one-time)"
    - name: "event_year"
      expr: YEAR(start_timestamp)
      comment: "Year of event start"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month of event start"
    - name: "event_quarter"
      expr: DATE_TRUNC('QUARTER', start_timestamp)
      comment: "Quarter of event start"
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of seasonal events"
    - name: "total_event_budget"
      expr: SUM(CAST(event_budget_amount AS DOUBLE))
      comment: "Total budget allocated to seasonal events"
    - name: "avg_event_budget"
      expr: AVG(CAST(event_budget_amount AS DOUBLE))
      comment: "Average budget per seasonal event"
    - name: "total_target_revenue"
      expr: SUM(CAST(target_revenue_amount AS DOUBLE))
      comment: "Total target revenue from seasonal events"
    - name: "avg_target_revenue"
      expr: AVG(CAST(target_revenue_amount AS DOUBLE))
      comment: "Average target revenue per event"
    - name: "avg_target_dau_lift_pct"
      expr: AVG(CAST(target_dau_lift_percent AS DOUBLE))
      comment: "Average target daily active user lift percentage, key engagement metric"
    - name: "target_roi_ratio"
      expr: ROUND(SUM(CAST(target_revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(event_budget_amount AS DOUBLE)), 0), 2)
      comment: "Target return on investment ratio (target revenue / budget), key financial efficiency metric"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`content_asset_bundle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for asset bundle distribution efficiency, compression effectiveness, and download performance"
  source: "`gaming_ecm`.`content`.`asset_bundle`"
  dimensions:
    - name: "bundle_status"
      expr: bundle_status
      comment: "Current status of the asset bundle"
    - name: "bundle_type"
      expr: bundle_type
      comment: "Type of asset bundle"
    - name: "target_platform"
      expr: target_platform
      comment: "Target platform for the bundle"
    - name: "compression_format"
      expr: compression_format
      comment: "Compression format used"
    - name: "encryption_enabled"
      expr: encryption_enabled
      comment: "Whether encryption is enabled for the bundle"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for distribution"
    - name: "ugc_content_included"
      expr: ugc_content_included
      comment: "Whether user-generated content is included"
    - name: "build_configuration"
      expr: build_configuration
      comment: "Build configuration used"
    - name: "release_year"
      expr: YEAR(release_date)
      comment: "Year of bundle release"
    - name: "release_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month of bundle release"
  measures:
    - name: "total_bundles"
      expr: COUNT(1)
      comment: "Total number of asset bundles"
    - name: "total_downloads"
      expr: SUM(CAST(download_count AS DOUBLE))
      comment: "Total download count across all bundles"
    - name: "avg_downloads_per_bundle"
      expr: AVG(CAST(download_count AS DOUBLE))
      comment: "Average downloads per bundle, indicating popularity"
    - name: "total_compressed_size_mb"
      expr: SUM(CAST(compressed_size_mb AS DOUBLE))
      comment: "Total compressed size in megabytes"
    - name: "total_uncompressed_size_mb"
      expr: SUM(CAST(uncompressed_size_mb AS DOUBLE))
      comment: "Total uncompressed size in megabytes"
    - name: "avg_compressed_size_mb"
      expr: AVG(CAST(compressed_size_mb AS DOUBLE))
      comment: "Average compressed size per bundle"
    - name: "avg_uncompressed_size_mb"
      expr: AVG(CAST(uncompressed_size_mb AS DOUBLE))
      comment: "Average uncompressed size per bundle"
    - name: "compression_ratio"
      expr: ROUND(SUM(CAST(compressed_size_mb AS DOUBLE)) / NULLIF(SUM(CAST(uncompressed_size_mb AS DOUBLE)), 0), 2)
      comment: "Overall compression ratio (compressed / uncompressed), key efficiency metric for bandwidth and storage"
    - name: "avg_error_rate_pct"
      expr: AVG(CAST(error_rate_percent AS DOUBLE))
      comment: "Average error rate percentage across bundles, key quality metric"
    - name: "high_error_bundle_count"
      expr: COUNT(CASE WHEN CAST(error_rate_percent AS DOUBLE) > 5.0 THEN 1 END)
      comment: "Number of bundles with error rate above 5%, indicating quality issues"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`content_patch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for patch deployment effectiveness, platform coverage, compliance impact, and patch quality"
  source: "`gaming_ecm`.`content`.`patch`"
  dimensions:
    - name: "patch_status"
      expr: patch_status
      comment: "Current status of the patch"
    - name: "patch_type"
      expr: patch_type
      comment: "Type of patch (e.g., hotfix, scheduled, emergency)"
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the patch is mandatory for players"
    - name: "content_drop_flag"
      expr: content_drop_flag
      comment: "Whether the patch includes a content drop"
    - name: "security_fixes_included"
      expr: security_fixes_included
      comment: "Whether security fixes are included"
    - name: "cdn_distribution_status"
      expr: cdn_distribution_status
      comment: "CDN distribution status"
    - name: "target_platforms"
      expr: target_platforms
      comment: "Target platforms for the patch"
    - name: "esrb_rating_impact"
      expr: esrb_rating_impact
      comment: "ESRB rating impact from patch content"
    - name: "pegi_rating_impact"
      expr: pegi_rating_impact
      comment: "PEGI rating impact from patch content"
    - name: "deployment_year"
      expr: YEAR(deployment_date_pc)
      comment: "Year of PC deployment"
    - name: "deployment_month"
      expr: DATE_TRUNC('MONTH', deployment_date_pc)
      comment: "Month of PC deployment"
  measures:
    - name: "total_patches"
      expr: COUNT(1)
      comment: "Total number of patches deployed"
    - name: "total_size_pc_mb"
      expr: SUM(CAST(size_pc_mb AS DOUBLE))
      comment: "Total patch size for PC platform in megabytes"
    - name: "total_size_console_mb"
      expr: SUM(CAST(size_console_mb AS DOUBLE))
      comment: "Total patch size for console platform in megabytes"
    - name: "total_size_mobile_mb"
      expr: SUM(CAST(size_mobile_mb AS DOUBLE))
      comment: "Total patch size for mobile platform in megabytes"
    - name: "avg_size_pc_mb"
      expr: AVG(CAST(size_pc_mb AS DOUBLE))
      comment: "Average patch size for PC platform"
    - name: "avg_size_console_mb"
      expr: AVG(CAST(size_console_mb AS DOUBLE))
      comment: "Average patch size for console platform"
    - name: "avg_size_mobile_mb"
      expr: AVG(CAST(size_mobile_mb AS DOUBLE))
      comment: "Average patch size for mobile platform"
    - name: "mandatory_patch_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END)
      comment: "Number of mandatory patches"
    - name: "mandatory_patch_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of patches that are mandatory, impacting player experience"
    - name: "security_patch_count"
      expr: COUNT(CASE WHEN security_fixes_included = TRUE THEN 1 END)
      comment: "Number of patches including security fixes"
    - name: "security_patch_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN security_fixes_included = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of patches including security fixes, key risk mitigation metric"
    - name: "rollback_count"
      expr: COUNT(CASE WHEN rollback_date IS NOT NULL THEN 1 END)
      comment: "Number of patches rolled back, indicating quality issues"
    - name: "rollback_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rollback_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of patches rolled back, key quality and risk metric"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`content_localization_translation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for localization efficiency, translation quality, cost management, and multi-region content readiness"
  source: "`gaming_ecm`.`content`.`localization_translation`"
  dimensions:
    - name: "locale_code"
      expr: locale_code
      comment: "Locale code for the translation"
    - name: "review_status"
      expr: review_status
      comment: "Review status of the translation"
    - name: "translator_type"
      expr: translator_type
      comment: "Type of translator (e.g., human, machine, hybrid)"
    - name: "machine_translation_flag"
      expr: machine_translation_flag
      comment: "Whether machine translation was used"
    - name: "qa_flag"
      expr: qa_flag
      comment: "Whether QA has been performed"
    - name: "glossary_compliance_flag"
      expr: glossary_compliance_flag
      comment: "Whether translation complies with glossary standards"
    - name: "platform_certification_status"
      expr: platform_certification_status
      comment: "Platform certification status for the translation"
    - name: "translation_year"
      expr: YEAR(translation_date)
      comment: "Year of translation"
    - name: "translation_month"
      expr: DATE_TRUNC('MONTH', translation_date)
      comment: "Month of translation"
  measures:
    - name: "total_translations"
      expr: COUNT(1)
      comment: "Total number of translations"
    - name: "total_translation_cost"
      expr: SUM(CAST(translation_cost AS DOUBLE))
      comment: "Total cost of translations"
    - name: "avg_translation_cost"
      expr: AVG(CAST(translation_cost AS DOUBLE))
      comment: "Average cost per translation"
    - name: "avg_translation_memory_match_score"
      expr: AVG(CAST(translation_memory_match_score AS DOUBLE))
      comment: "Average translation memory match score, indicating reuse efficiency"
    - name: "machine_translation_count"
      expr: COUNT(CASE WHEN machine_translation_flag = TRUE THEN 1 END)
      comment: "Number of machine translations"
    - name: "machine_translation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN machine_translation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of translations using machine translation, cost efficiency indicator"
    - name: "qa_completed_count"
      expr: COUNT(CASE WHEN qa_flag = TRUE THEN 1 END)
      comment: "Number of translations with QA completed"
    - name: "qa_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN qa_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of translations with QA completed, key quality metric"
    - name: "glossary_compliance_count"
      expr: COUNT(CASE WHEN glossary_compliance_flag = TRUE THEN 1 END)
      comment: "Number of translations compliant with glossary"
    - name: "glossary_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN glossary_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of translations compliant with glossary standards, key consistency metric"
    - name: "distinct_locales"
      expr: COUNT(DISTINCT locale_code)
      comment: "Number of distinct locales supported, indicating market reach"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`content_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for asset utilization, lifecycle management, DRM compliance, and content library health"
  source: "`gaming_ecm`.`content`.`asset`"
  dimensions:
    - name: "asset_type"
      expr: asset_type
      comment: "Type of asset (e.g., texture, model, audio, video)"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the asset"
    - name: "moderation_status"
      expr: moderation_status
      comment: "Moderation status for content compliance"
    - name: "platform_target"
      expr: platform_target
      comment: "Target platform for the asset"
    - name: "format"
      expr: format
      comment: "File format of the asset"
    - name: "drm_protected"
      expr: drm_protected
      comment: "Whether the asset is DRM protected"
    - name: "ugc_flag"
      expr: ugc_flag
      comment: "Whether the asset is user-generated content"
    - name: "ip_rights_status"
      expr: ip_rights_status
      comment: "Intellectual property rights status"
    - name: "is_locale_variant"
      expr: is_locale_variant
      comment: "Whether the asset is a locale variant"
    - name: "creation_year"
      expr: YEAR(creation_date)
      comment: "Year of asset creation"
    - name: "creation_month"
      expr: DATE_TRUNC('MONTH', creation_date)
      comment: "Month of asset creation"
  measures:
    - name: "total_assets"
      expr: COUNT(1)
      comment: "Total number of assets in the library"
    - name: "total_file_size_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total file size of all assets in bytes"
    - name: "avg_file_size_bytes"
      expr: AVG(CAST(file_size_bytes AS DOUBLE))
      comment: "Average file size per asset"
    - name: "total_downloads"
      expr: SUM(CAST(download_count AS DOUBLE))
      comment: "Total download count across all assets"
    - name: "avg_downloads_per_asset"
      expr: AVG(CAST(download_count AS DOUBLE))
      comment: "Average downloads per asset, indicating utilization"
    - name: "drm_protected_count"
      expr: COUNT(CASE WHEN drm_protected = TRUE THEN 1 END)
      comment: "Number of DRM-protected assets"
    - name: "drm_protection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN drm_protected = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assets with DRM protection, key IP protection metric"
    - name: "ugc_asset_count"
      expr: COUNT(CASE WHEN ugc_flag = TRUE THEN 1 END)
      comment: "Number of user-generated content assets"
    - name: "ugc_asset_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ugc_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assets that are user-generated, indicating community engagement"
    - name: "deprecated_asset_count"
      expr: COUNT(CASE WHEN deprecated_date IS NOT NULL THEN 1 END)
      comment: "Number of deprecated assets"
    - name: "deprecated_asset_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN deprecated_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deprecated assets, indicating library health and cleanup needs"
    - name: "distinct_asset_types"
      expr: COUNT(DISTINCT asset_type)
      comment: "Number of distinct asset types, indicating content diversity"
$$;