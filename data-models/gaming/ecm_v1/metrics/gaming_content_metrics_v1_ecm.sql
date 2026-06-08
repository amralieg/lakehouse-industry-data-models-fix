-- Metric views for domain: content | Business: Gaming | Version: 1 | Generated on: 2026-05-08 07:57:15

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`content_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core asset metrics tracking creation, usage, and storage efficiency across game content library"
  source: "`gaming_ecm`.`content`.`asset`"
  dimensions:
    - name: "asset_type"
      expr: asset_type
      comment: "Type of asset (texture, model, audio, animation, etc.)"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the asset (draft, approved, published, deprecated)"
    - name: "platform_target"
      expr: platform_target
      comment: "Target platform for the asset (console, PC, mobile)"
    - name: "feature_area"
      expr: feature_area
      comment: "Game feature area the asset supports"
    - name: "drm_protected"
      expr: drm_protected
      comment: "Whether the asset is DRM protected"
    - name: "ugc_flag"
      expr: ugc_flag
      comment: "Whether the asset is user-generated content"
    - name: "creation_year"
      expr: YEAR(creation_date)
      comment: "Year the asset was created"
    - name: "creation_month"
      expr: DATE_TRUNC('MONTH', creation_date)
      comment: "Month the asset was created"
  measures:
    - name: "total_assets"
      expr: COUNT(1)
      comment: "Total number of assets"
    - name: "total_storage_gb"
      expr: SUM(CAST(file_size_bytes AS DOUBLE)) / 1073741824.0
      comment: "Total storage consumed by assets in gigabytes"
    - name: "avg_asset_size_mb"
      expr: AVG(CAST(file_size_bytes AS DOUBLE)) / 1048576.0
      comment: "Average asset size in megabytes"
    - name: "total_downloads"
      expr: SUM(CAST(download_count AS DOUBLE))
      comment: "Total number of asset downloads across all assets"
    - name: "avg_downloads_per_asset"
      expr: AVG(CAST(download_count AS DOUBLE))
      comment: "Average number of downloads per asset"
    - name: "unique_game_titles"
      expr: COUNT(DISTINCT game_title_id)
      comment: "Number of unique game titles using these assets"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`content_asset_bundle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset bundle deployment and distribution metrics tracking bundle efficiency and delivery performance"
  source: "`gaming_ecm`.`content`.`asset_bundle`"
  dimensions:
    - name: "bundle_type"
      expr: bundle_type
      comment: "Type of asset bundle (base, DLC, patch, seasonal)"
    - name: "bundle_status"
      expr: bundle_status
      comment: "Current status of the bundle (draft, testing, published, deprecated)"
    - name: "target_platform"
      expr: target_platform
      comment: "Target platform for the bundle"
    - name: "encryption_enabled"
      expr: encryption_enabled
      comment: "Whether the bundle is encrypted"
    - name: "ugc_content_included"
      expr: ugc_content_included
      comment: "Whether the bundle includes user-generated content"
    - name: "release_year"
      expr: YEAR(release_date)
      comment: "Year the bundle was released"
    - name: "release_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month the bundle was released"
  measures:
    - name: "total_bundles"
      expr: COUNT(1)
      comment: "Total number of asset bundles"
    - name: "total_compressed_size_gb"
      expr: SUM(CAST(compressed_size_mb AS DOUBLE)) / 1024.0
      comment: "Total compressed size of all bundles in gigabytes"
    - name: "total_uncompressed_size_gb"
      expr: SUM(CAST(uncompressed_size_mb AS DOUBLE)) / 1024.0
      comment: "Total uncompressed size of all bundles in gigabytes"
    - name: "avg_compression_ratio"
      expr: AVG(CAST(compressed_size_mb AS DOUBLE) / NULLIF(CAST(uncompressed_size_mb AS DOUBLE), 0))
      comment: "Average compression ratio across bundles (lower is better)"
    - name: "total_bundle_downloads"
      expr: SUM(CAST(download_count AS DOUBLE))
      comment: "Total number of bundle downloads"
    - name: "avg_error_rate_pct"
      expr: AVG(CAST(error_rate_percent AS DOUBLE))
      comment: "Average error rate percentage across bundles"
    - name: "unique_game_titles"
      expr: COUNT(DISTINCT game_title_id)
      comment: "Number of unique game titles served by these bundles"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`content_release`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content release and live operations metrics tracking deployment success, player engagement, and release quality"
  source: "`gaming_ecm`.`content`.`content_release`"
  dimensions:
    - name: "release_type"
      expr: release_type
      comment: "Type of content release (major, minor, hotfix, seasonal, event)"
    - name: "release_status"
      expr: release_status
      comment: "Current status of the release (planned, in-progress, live, rolled-back)"
    - name: "patch_type"
      expr: patch_type
      comment: "Type of patch included in the release"
    - name: "deployment_status"
      expr: deployment_status
      comment: "Deployment status of the release"
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Whether the release is mandatory for players"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the release"
    - name: "scheduled_year"
      expr: YEAR(CAST(scheduled_go_live_timestamp AS DATE))
      comment: "Year the release was scheduled"
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', CAST(scheduled_go_live_timestamp AS DATE))
      comment: "Month the release was scheduled"
  measures:
    - name: "total_releases"
      expr: COUNT(1)
      comment: "Total number of content releases"
    - name: "total_download_size_console_gb"
      expr: SUM(CAST(download_size_mb_console AS DOUBLE)) / 1024.0
      comment: "Total download size for console platforms in gigabytes"
    - name: "total_download_size_pc_gb"
      expr: SUM(CAST(download_size_mb_pc AS DOUBLE)) / 1024.0
      comment: "Total download size for PC platform in gigabytes"
    - name: "total_download_size_mobile_gb"
      expr: SUM(CAST(download_size_mb_mobile AS DOUBLE)) / 1024.0
      comment: "Total download size for mobile platforms in gigabytes"
    - name: "avg_player_feedback_score"
      expr: AVG(CAST(player_feedback_score AS DOUBLE))
      comment: "Average player feedback score across releases"
    - name: "unique_game_titles"
      expr: COUNT(DISTINCT game_title_id)
      comment: "Number of unique game titles with content releases"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`content_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content deployment operations metrics tracking deployment efficiency, downtime, and rollback rates"
  source: "`gaming_ecm`.`content`.`content_deployment`"
  dimensions:
    - name: "deployment_type"
      expr: deployment_type
      comment: "Type of deployment (full, incremental, hotfix, rollback)"
    - name: "deployment_status"
      expr: deployment_status
      comment: "Current status of the deployment"
    - name: "deployment_method"
      expr: deployment_method
      comment: "Method used for deployment (blue-green, canary, rolling)"
    - name: "target_environment"
      expr: target_environment
      comment: "Target environment for deployment (dev, staging, production)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the deployment"
    - name: "rollback_flag"
      expr: rollback_flag
      comment: "Whether the deployment was rolled back"
    - name: "downtime_required_flag"
      expr: downtime_required_flag
      comment: "Whether the deployment required downtime"
    - name: "deployment_year"
      expr: YEAR(CAST(deployment_timestamp AS DATE))
      comment: "Year the deployment occurred"
    - name: "deployment_month"
      expr: DATE_TRUNC('MONTH', CAST(deployment_timestamp AS DATE))
      comment: "Month the deployment occurred"
  measures:
    - name: "total_deployments"
      expr: COUNT(1)
      comment: "Total number of content deployments"
    - name: "total_asset_bundle_size_gb"
      expr: SUM(CAST(asset_bundle_size_mb AS DOUBLE)) / 1024.0
      comment: "Total size of asset bundles deployed in gigabytes"
    - name: "avg_deployment_size_mb"
      expr: AVG(CAST(asset_bundle_size_mb AS DOUBLE))
      comment: "Average deployment size in megabytes"
    - name: "rollback_count"
      expr: SUM(CASE WHEN rollback_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of deployments that were rolled back"
    - name: "rollback_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN rollback_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deployments that were rolled back"
    - name: "downtime_required_count"
      expr: SUM(CASE WHEN downtime_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of deployments that required downtime"
    - name: "unique_game_titles"
      expr: COUNT(DISTINCT game_title_id)
      comment: "Number of unique game titles with deployments"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`content_patch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patch release metrics tracking patch size, deployment timing, and platform-specific distribution"
  source: "`gaming_ecm`.`content`.`patch`"
  dimensions:
    - name: "patch_type"
      expr: patch_type
      comment: "Type of patch (hotfix, maintenance, content, security)"
    - name: "patch_status"
      expr: patch_status
      comment: "Current status of the patch"
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the patch is mandatory for players"
    - name: "content_drop_flag"
      expr: content_drop_flag
      comment: "Whether the patch includes a content drop"
    - name: "security_fixes_included"
      expr: security_fixes_included
      comment: "Whether the patch includes security fixes"
    - name: "gold_master_year"
      expr: YEAR(gold_master_date)
      comment: "Year the patch reached gold master status"
    - name: "gold_master_month"
      expr: DATE_TRUNC('MONTH', gold_master_date)
      comment: "Month the patch reached gold master status"
  measures:
    - name: "total_patches"
      expr: COUNT(1)
      comment: "Total number of patches released"
    - name: "total_patch_size_console_gb"
      expr: SUM(CAST(size_console_mb AS DOUBLE)) / 1024.0
      comment: "Total patch size for console platforms in gigabytes"
    - name: "total_patch_size_pc_gb"
      expr: SUM(CAST(size_pc_mb AS DOUBLE)) / 1024.0
      comment: "Total patch size for PC platform in gigabytes"
    - name: "total_patch_size_mobile_gb"
      expr: SUM(CAST(size_mobile_mb AS DOUBLE)) / 1024.0
      comment: "Total patch size for mobile platforms in gigabytes"
    - name: "avg_patch_size_console_mb"
      expr: AVG(CAST(size_console_mb AS DOUBLE))
      comment: "Average patch size for console platforms in megabytes"
    - name: "avg_patch_size_pc_mb"
      expr: AVG(CAST(size_pc_mb AS DOUBLE))
      comment: "Average patch size for PC platform in megabytes"
    - name: "avg_patch_size_mobile_mb"
      expr: AVG(CAST(size_mobile_mb AS DOUBLE))
      comment: "Average patch size for mobile platforms in megabytes"
    - name: "unique_game_titles"
      expr: COUNT(DISTINCT game_title_id)
      comment: "Number of unique game titles with patches"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`content_seasonal_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Seasonal event performance metrics tracking participation, revenue impact, and event ROI"
  source: "`gaming_ecm`.`content`.`seasonal_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of seasonal event (holiday, anniversary, limited-time, crossover)"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the event (planned, active, completed, cancelled)"
    - name: "event_theme"
      expr: event_theme
      comment: "Theme of the seasonal event"
    - name: "certification_status"
      expr: certification_status
      comment: "Certification status of the event content"
    - name: "qa_status"
      expr: qa_status
      comment: "Quality assurance status of the event"
    - name: "localization_status"
      expr: localization_status
      comment: "Localization status of the event content"
    - name: "start_year"
      expr: YEAR(CAST(start_timestamp AS DATE))
      comment: "Year the event started"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', CAST(start_timestamp AS DATE))
      comment: "Month the event started"
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of seasonal events"
    - name: "total_event_budget"
      expr: SUM(CAST(event_budget_amount AS DOUBLE))
      comment: "Total budget allocated across all seasonal events"
    - name: "avg_event_budget"
      expr: AVG(CAST(event_budget_amount AS DOUBLE))
      comment: "Average budget per seasonal event"
    - name: "total_target_revenue"
      expr: SUM(CAST(target_revenue_amount AS DOUBLE))
      comment: "Total target revenue across all seasonal events"
    - name: "avg_target_revenue"
      expr: AVG(CAST(target_revenue_amount AS DOUBLE))
      comment: "Average target revenue per seasonal event"
    - name: "avg_target_dau_lift_pct"
      expr: AVG(CAST(target_dau_lift_percent AS DOUBLE))
      comment: "Average target daily active user lift percentage across events"
    - name: "avg_revenue_per_budget_dollar"
      expr: AVG(CAST(target_revenue_amount AS DOUBLE) / NULLIF(CAST(event_budget_amount AS DOUBLE), 0))
      comment: "Average target revenue per dollar of event budget (ROI proxy)"
    - name: "unique_game_titles"
      expr: COUNT(DISTINCT game_title_id)
      comment: "Number of unique game titles with seasonal events"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`content_localization_translation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Localization translation efficiency and quality metrics tracking translation cost, speed, and quality assurance"
  source: "`gaming_ecm`.`content`.`localization_translation`"
  dimensions:
    - name: "locale_code"
      expr: locale_code
      comment: "Target locale code for the translation"
    - name: "review_status"
      expr: review_status
      comment: "Review status of the translation"
    - name: "translator_type"
      expr: translator_type
      comment: "Type of translator (human, machine, hybrid)"
    - name: "machine_translation_flag"
      expr: machine_translation_flag
      comment: "Whether machine translation was used"
    - name: "qa_flag"
      expr: qa_flag
      comment: "Whether the translation passed QA"
    - name: "glossary_compliance_flag"
      expr: glossary_compliance_flag
      comment: "Whether the translation complies with glossary standards"
    - name: "translation_year"
      expr: YEAR(translation_date)
      comment: "Year the translation was completed"
    - name: "translation_month"
      expr: DATE_TRUNC('MONTH', translation_date)
      comment: "Month the translation was completed"
  measures:
    - name: "total_translations"
      expr: COUNT(1)
      comment: "Total number of translations"
    - name: "total_translation_cost"
      expr: SUM(CAST(translation_cost AS DOUBLE))
      comment: "Total cost of all translations"
    - name: "avg_translation_cost"
      expr: AVG(CAST(translation_cost AS DOUBLE))
      comment: "Average cost per translation"
    - name: "total_word_count"
      expr: SUM(CAST(word_count AS DOUBLE))
      comment: "Total word count across all translations"
    - name: "avg_word_count"
      expr: AVG(CAST(word_count AS DOUBLE))
      comment: "Average word count per translation"
    - name: "avg_cost_per_word"
      expr: AVG(CAST(translation_cost AS DOUBLE) / NULLIF(CAST(word_count AS DOUBLE), 0))
      comment: "Average translation cost per word"
    - name: "avg_translation_memory_match_score"
      expr: AVG(CAST(translation_memory_match_score AS DOUBLE))
      comment: "Average translation memory match score (higher indicates more reuse)"
    - name: "qa_pass_count"
      expr: SUM(CASE WHEN qa_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of translations that passed QA"
    - name: "qa_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN qa_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of translations that passed QA"
    - name: "unique_locales"
      expr: COUNT(DISTINCT locale_code)
      comment: "Number of unique locales with translations"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`content_asset_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset version control and iteration metrics tracking version churn, file size growth, and promotion velocity"
  source: "`gaming_ecm`.`content`.`asset_version`"
  dimensions:
    - name: "asset_category"
      expr: asset_category
      comment: "Category of the asset being versioned"
    - name: "promotion_stage"
      expr: promotion_stage
      comment: "Current promotion stage (dev, staging, production)"
    - name: "build_pipeline_status"
      expr: build_pipeline_status
      comment: "Status of the build pipeline for this version"
    - name: "cdn_distribution_status"
      expr: cdn_distribution_status
      comment: "CDN distribution status of the version"
    - name: "is_deprecated"
      expr: is_deprecated
      comment: "Whether the version is deprecated"
    - name: "drm_protected"
      expr: drm_protected
      comment: "Whether the version is DRM protected"
    - name: "platform_target"
      expr: platform_target
      comment: "Target platform for the version"
    - name: "commit_year"
      expr: YEAR(CAST(commit_timestamp AS DATE))
      comment: "Year the version was committed"
    - name: "commit_month"
      expr: DATE_TRUNC('MONTH', CAST(commit_timestamp AS DATE))
      comment: "Month the version was committed"
  measures:
    - name: "total_versions"
      expr: COUNT(1)
      comment: "Total number of asset versions"
    - name: "total_version_storage_gb"
      expr: SUM(CAST(file_size_bytes AS DOUBLE)) / 1073741824.0
      comment: "Total storage consumed by all versions in gigabytes"
    - name: "avg_version_size_mb"
      expr: AVG(CAST(file_size_bytes AS DOUBLE)) / 1048576.0
      comment: "Average version size in megabytes"
    - name: "avg_file_size_delta_mb"
      expr: AVG(CAST(file_size_delta_bytes AS DOUBLE)) / 1048576.0
      comment: "Average file size change between versions in megabytes"
    - name: "avg_audio_duration_seconds"
      expr: AVG(CAST(audio_duration_seconds AS DOUBLE))
      comment: "Average audio duration for audio asset versions in seconds"
    - name: "unique_assets"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique assets with versions"
    - name: "unique_game_titles"
      expr: COUNT(DISTINCT game_title_id)
      comment: "Number of unique game titles with asset versions"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`content_asset_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset review and approval workflow metrics tracking review cycle time, SLA compliance, and quality gate effectiveness"
  source: "`gaming_ecm`.`content`.`asset_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of review (technical, creative, compliance, legal)"
    - name: "decision"
      expr: decision
      comment: "Review decision (approved, rejected, revision-requested)"
    - name: "pipeline_stage"
      expr: pipeline_stage
      comment: "Pipeline stage where the review occurred"
    - name: "platform_target"
      expr: platform_target
      comment: "Target platform for the asset under review"
    - name: "automated_check_passed"
      expr: automated_check_passed
      comment: "Whether automated checks passed"
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Whether the review met SLA targets"
    - name: "ugc_moderation_flag"
      expr: ugc_moderation_flag
      comment: "Whether the review was for user-generated content moderation"
    - name: "review_year"
      expr: YEAR(CAST(review_timestamp AS DATE))
      comment: "Year the review was conducted"
    - name: "review_month"
      expr: DATE_TRUNC('MONTH', CAST(review_timestamp AS DATE))
      comment: "Month the review was conducted"
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of asset reviews"
    - name: "avg_review_duration_minutes"
      expr: AVG(CAST(audio_duration_seconds AS DOUBLE)) / 60.0
      comment: "Average review duration in minutes"
    - name: "avg_file_size_mb"
      expr: AVG(CAST(file_size_mb AS DOUBLE))
      comment: "Average file size of reviewed assets in megabytes"
    - name: "avg_sla_actual_hours"
      expr: AVG(CAST(sla_actual_hours AS DOUBLE))
      comment: "Average actual hours to complete review"
    - name: "sla_compliant_count"
      expr: SUM(CASE WHEN sla_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reviews that met SLA targets"
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews that met SLA targets"
    - name: "automated_check_pass_count"
      expr: SUM(CASE WHEN automated_check_passed = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reviews where automated checks passed"
    - name: "automated_check_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN automated_check_passed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews where automated checks passed"
    - name: "unique_reviewers"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of unique employees conducting reviews"
$$;