-- Metric views for domain: content | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 19:19:28

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`content_title`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core content title performance metrics tracking acquisition costs, runtime efficiency, and content availability across formats and territories"
  source: "`media_broadcasting_ecm`.`content`.`title`"
  dimensions:
    - name: "content_type"
      expr: content_type
      comment: "Type of content (movie, series episode, documentary, etc.)"
    - name: "content_status"
      expr: content_status
      comment: "Current lifecycle status of the title (active, archived, in production, etc.)"
    - name: "rights_status"
      expr: rights_status
      comment: "Rights clearance and availability status"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the content was originally produced"
    - name: "original_language"
      expr: original_language
      comment: "Original language of the content"
    - name: "production_year"
      expr: production_year
      comment: "Year the content was produced"
    - name: "release_year"
      expr: YEAR(release_date)
      comment: "Year the content was released"
    - name: "release_quarter"
      expr: CONCAT('Q', QUARTER(release_date), '-', YEAR(release_date))
      comment: "Quarter and year of content release"
    - name: "hd_available"
      expr: hd_available_flag
      comment: "Whether HD version is available"
    - name: "uhd_4k_available"
      expr: uhd_4k_available_flag
      comment: "Whether UHD 4K version is available"
    - name: "theatrical_release"
      expr: theatrical_release_flag
      comment: "Whether content had theatrical release"
    - name: "premiere_content"
      expr: premiere_flag
      comment: "Whether this is premiere content"
    - name: "closed_caption_available"
      expr: closed_caption_available_flag
      comment: "Whether closed captions are available"
    - name: "audio_description_available"
      expr: audio_description_available_flag
      comment: "Whether audio description is available for accessibility"
  measures:
    - name: "total_titles"
      expr: COUNT(DISTINCT title_id)
      comment: "Total number of unique titles in the catalog"
    - name: "total_runtime_hours"
      expr: SUM(CAST(runtime_seconds AS DOUBLE)) / 3600.0
      comment: "Total content runtime in hours across all titles"
    - name: "avg_runtime_minutes"
      expr: AVG(CAST(runtime_seconds AS DOUBLE)) / 60.0
      comment: "Average runtime per title in minutes"
    - name: "hd_availability_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN hd_available_flag = true THEN title_id END) / NULLIF(COUNT(DISTINCT title_id), 0), 2)
      comment: "Percentage of titles available in HD format"
    - name: "uhd_4k_availability_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN uhd_4k_available_flag = true THEN title_id END) / NULLIF(COUNT(DISTINCT title_id), 0), 2)
      comment: "Percentage of titles available in UHD 4K format"
    - name: "accessibility_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN closed_caption_available_flag = true AND audio_description_available_flag = true THEN title_id END) / NULLIF(COUNT(DISTINCT title_id), 0), 2)
      comment: "Percentage of titles with full accessibility features (closed captions and audio description)"
    - name: "premiere_content_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN premiere_flag = true THEN title_id END) / NULLIF(COUNT(DISTINCT title_id), 0), 2)
      comment: "Percentage of titles that are premiere content"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`content_series`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Series-level performance metrics tracking episodic content scale, syndication eligibility, and accessibility compliance"
  source: "`media_broadcasting_ecm`.`content`.`series`"
  dimensions:
    - name: "series_status"
      expr: series_status
      comment: "Current status of the series (active, ended, on hiatus, etc.)"
    - name: "series_type"
      expr: series_type
      comment: "Type of series (drama, comedy, reality, documentary, etc.)"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the series was originally produced"
    - name: "original_language"
      expr: language_original
      comment: "Original language of the series"
    - name: "original_network"
      expr: original_network
      comment: "Network that originally aired the series"
    - name: "syndication_eligible"
      expr: syndication_eligible
      comment: "Whether the series is eligible for syndication"
    - name: "closed_caption_available"
      expr: closed_caption_available
      comment: "Whether closed captions are available"
    - name: "audio_description_available"
      expr: audio_description_available
      comment: "Whether audio description is available"
    - name: "premiere_year"
      expr: YEAR(premiere_date)
      comment: "Year the series premiered"
    - name: "target_demographic"
      expr: target_demographic
      comment: "Target audience demographic for the series"
  measures:
    - name: "total_series"
      expr: COUNT(DISTINCT series_id)
      comment: "Total number of unique series in the catalog"
    - name: "total_seasons"
      expr: SUM(CAST(total_season_count AS DOUBLE))
      comment: "Total number of seasons across all series"
    - name: "total_episodes"
      expr: SUM(CAST(total_episode_count AS DOUBLE))
      comment: "Total number of episodes across all series"
    - name: "avg_seasons_per_series"
      expr: AVG(CAST(total_season_count AS DOUBLE))
      comment: "Average number of seasons per series"
    - name: "avg_episodes_per_series"
      expr: AVG(CAST(total_episode_count AS DOUBLE))
      comment: "Average number of episodes per series"
    - name: "avg_episode_runtime_minutes"
      expr: AVG(CAST(episode_runtime_minutes AS DOUBLE))
      comment: "Average runtime per episode in minutes"
    - name: "syndication_eligibility_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN syndication_eligible = true THEN series_id END) / NULLIF(COUNT(DISTINCT series_id), 0), 2)
      comment: "Percentage of series eligible for syndication"
    - name: "accessibility_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN closed_caption_available = true AND audio_description_available = true THEN series_id END) / NULLIF(COUNT(DISTINCT series_id), 0), 2)
      comment: "Percentage of series with full accessibility features"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`content_episode`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Episode-level content metrics tracking broadcast performance, VOD availability windows, and rights clearance status"
  source: "`media_broadcasting_ecm`.`content`.`content_episode`"
  dimensions:
    - name: "episode_status"
      expr: episode_status
      comment: "Current status of the episode (aired, scheduled, in production, archived, etc.)"
    - name: "episode_type"
      expr: episode_type
      comment: "Type of episode (regular, special, pilot, finale, etc.)"
    - name: "premiere_episode"
      expr: premiere_flag
      comment: "Whether this is a premiere episode"
    - name: "rerun_episode"
      expr: rerun_flag
      comment: "Whether this is a rerun"
    - name: "rights_clearance_status"
      expr: rights_clearance_status
      comment: "Status of rights clearance for the episode"
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of the episode"
    - name: "closed_caption_available"
      expr: closed_caption_available
      comment: "Whether closed captions are available"
    - name: "audio_description_available"
      expr: audio_description_available
      comment: "Whether audio description is available"
    - name: "subtitles_available"
      expr: subtitles_available
      comment: "Whether subtitles are available"
    - name: "music_cue_sheet_submitted"
      expr: music_cue_sheet_submitted
      comment: "Whether music cue sheet has been submitted for royalty tracking"
    - name: "original_air_year"
      expr: YEAR(original_air_date)
      comment: "Year the episode originally aired"
    - name: "original_air_quarter"
      expr: CONCAT('Q', QUARTER(original_air_date), '-', YEAR(original_air_date))
      comment: "Quarter and year the episode originally aired"
  measures:
    - name: "total_episodes"
      expr: COUNT(DISTINCT content_episode_id)
      comment: "Total number of unique episodes"
    - name: "total_broadcast_count"
      expr: SUM(CAST(broadcast_count AS DOUBLE))
      comment: "Total number of times episodes have been broadcast"
    - name: "avg_broadcast_count_per_episode"
      expr: AVG(CAST(broadcast_count AS DOUBLE))
      comment: "Average number of broadcasts per episode"
    - name: "total_runtime_hours"
      expr: SUM(CAST(runtime_seconds AS DOUBLE)) / 3600.0
      comment: "Total runtime of all episodes in hours"
    - name: "avg_runtime_minutes"
      expr: AVG(CAST(runtime_seconds AS DOUBLE)) / 60.0
      comment: "Average runtime per episode in minutes"
    - name: "total_runtime_with_ads_hours"
      expr: SUM(CAST(runtime_with_ads_seconds AS DOUBLE)) / 3600.0
      comment: "Total runtime including ad breaks in hours"
    - name: "avg_ad_time_minutes"
      expr: AVG(CAST(runtime_with_ads_seconds AS DOUBLE) - CAST(runtime_seconds AS DOUBLE)) / 60.0
      comment: "Average ad time per episode in minutes"
    - name: "rights_cleared_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN rights_clearance_status = 'cleared' THEN content_episode_id END) / NULLIF(COUNT(DISTINCT content_episode_id), 0), 2)
      comment: "Percentage of episodes with cleared rights"
    - name: "accessibility_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN closed_caption_available = true AND audio_description_available = true THEN content_episode_id END) / NULLIF(COUNT(DISTINCT content_episode_id), 0), 2)
      comment: "Percentage of episodes with full accessibility features"
    - name: "music_cue_sheet_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN music_cue_sheet_submitted = true THEN content_episode_id END) / NULLIF(COUNT(DISTINCT content_episode_id), 0), 2)
      comment: "Percentage of episodes with submitted music cue sheets for royalty compliance"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`content_acquisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content acquisition financial and operational metrics tracking deal costs, license terms, rights scope, and payment obligations"
  source: "`media_broadcasting_ecm`.`content`.`acquisition`"
  dimensions:
    - name: "acquisition_type"
      expr: acquisition_type
      comment: "Type of acquisition (license, purchase, co-production, etc.)"
    - name: "acquisition_status"
      expr: acquisition_status
      comment: "Current status of the acquisition (pending, active, expired, etc.)"
    - name: "clearance_status"
      expr: clearance_status
      comment: "Rights clearance status"
    - name: "cost_currency"
      expr: cost_currency
      comment: "Currency of the acquisition cost"
    - name: "territory_scope"
      expr: territory_scope
      comment: "Geographic scope of the acquisition rights"
    - name: "content_window_type"
      expr: content_window_type
      comment: "Type of content window (theatrical, SVOD, AVOD, linear, etc.)"
    - name: "exclusivity"
      expr: exclusivity_flag
      comment: "Whether the acquisition includes exclusive rights"
    - name: "sublicensing_allowed"
      expr: sublicensing_allowed_flag
      comment: "Whether sublicensing is permitted"
    - name: "ancillary_rights"
      expr: ancillary_rights_flag
      comment: "Whether ancillary rights are included"
    - name: "residuals_obligation"
      expr: residuals_obligation_flag
      comment: "Whether there are residual payment obligations"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year the acquisition was made"
    - name: "acquisition_quarter"
      expr: CONCAT('Q', QUARTER(acquisition_date), '-', YEAR(acquisition_date))
      comment: "Quarter and year of acquisition"
    - name: "license_year"
      expr: YEAR(license_start_date)
      comment: "Year the license period starts"
  measures:
    - name: "total_acquisitions"
      expr: COUNT(DISTINCT acquisition_id)
      comment: "Total number of content acquisitions"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of all acquisitions"
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per acquisition"
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee amounts across all acquisitions"
    - name: "avg_minimum_guarantee"
      expr: AVG(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Average minimum guarantee per acquisition"
    - name: "avg_royalty_rate_pct"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate percentage across acquisitions"
    - name: "exclusive_acquisition_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN exclusivity_flag = true THEN acquisition_id END) / NULLIF(COUNT(DISTINCT acquisition_id), 0), 2)
      comment: "Percentage of acquisitions with exclusive rights"
    - name: "sublicensing_allowed_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN sublicensing_allowed_flag = true THEN acquisition_id END) / NULLIF(COUNT(DISTINCT acquisition_id), 0), 2)
      comment: "Percentage of acquisitions allowing sublicensing"
    - name: "residuals_obligation_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN residuals_obligation_flag = true THEN acquisition_id END) / NULLIF(COUNT(DISTINCT acquisition_id), 0), 2)
      comment: "Percentage of acquisitions with residual payment obligations"
    - name: "rights_cleared_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN clearance_status = 'cleared' THEN acquisition_id END) / NULLIF(COUNT(DISTINCT acquisition_id), 0), 2)
      comment: "Percentage of acquisitions with cleared rights status"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`content_localization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content localization operational and financial metrics tracking translation costs, quality control pass rates, delivery timeliness, and compliance certification"
  source: "`media_broadcasting_ecm`.`content`.`localization`"
  dimensions:
    - name: "localization_type"
      expr: localization_type
      comment: "Type of localization (dubbing, subtitling, voice-over, etc.)"
    - name: "localization_status"
      expr: localization_status
      comment: "Current status of the localization work (in progress, completed, approved, etc.)"
    - name: "target_language"
      expr: target_language_code
      comment: "Target language for localization"
    - name: "target_territory"
      expr: target_territory_code
      comment: "Target territory for localization"
    - name: "currency"
      expr: currency_code
      comment: "Currency of localization costs"
    - name: "qc_pass"
      expr: qc_pass_flag
      comment: "Whether the localization passed quality control"
    - name: "compliance_certified"
      expr: compliance_certification_flag
      comment: "Whether the localization has compliance certification"
    - name: "accessibility_standard_met"
      expr: accessibility_standard_met
      comment: "Accessibility standard compliance status"
    - name: "order_year"
      expr: YEAR(order_date)
      comment: "Year the localization was ordered"
    - name: "order_quarter"
      expr: CONCAT('Q', QUARTER(order_date), '-', YEAR(order_date))
      comment: "Quarter and year of localization order"
  measures:
    - name: "total_localizations"
      expr: COUNT(DISTINCT localization_id)
      comment: "Total number of localization projects"
    - name: "total_localization_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of all localization work"
    - name: "avg_localization_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per localization project"
    - name: "total_duration_hours"
      expr: SUM(CAST(duration_minutes AS DOUBLE)) / 60.0
      comment: "Total duration of localized content in hours"
    - name: "avg_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration per localization in minutes"
    - name: "avg_cost_per_minute"
      expr: AVG(CAST(cost_amount AS DOUBLE) / NULLIF(CAST(duration_minutes AS DOUBLE), 0))
      comment: "Average localization cost per minute of content"
    - name: "qc_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN qc_pass_flag = true THEN localization_id END) / NULLIF(COUNT(DISTINCT localization_id), 0), 2)
      comment: "Percentage of localizations that passed quality control"
    - name: "compliance_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN compliance_certification_flag = true THEN localization_id END) / NULLIF(COUNT(DISTINCT localization_id), 0), 2)
      comment: "Percentage of localizations with compliance certification"
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN actual_delivery_date <= scheduled_delivery_date THEN localization_id END) / NULLIF(COUNT(DISTINCT localization_id), 0), 2)
      comment: "Percentage of localizations delivered on or before scheduled date"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`content_windowing_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content distribution windowing strategy metrics tracking revenue model mix, exclusivity tiers, minimum guarantees, and window sequencing effectiveness"
  source: "`media_broadcasting_ecm`.`content`.`windowing_plan`"
  dimensions:
    - name: "window_type"
      expr: window_type
      comment: "Type of distribution window (theatrical, PVOD, SVOD, AVOD, linear, etc.)"
    - name: "window_status"
      expr: window_status
      comment: "Current status of the windowing plan (planned, active, closed, etc.)"
    - name: "revenue_model"
      expr: revenue_model
      comment: "Revenue model for the window (subscription, transactional, ad-supported, etc.)"
    - name: "exclusivity_tier"
      expr: exclusivity_tier
      comment: "Exclusivity tier of the window"
    - name: "territory"
      expr: territory_code
      comment: "Territory code for the windowing plan"
    - name: "currency"
      expr: currency_code
      comment: "Currency for pricing and guarantees"
    - name: "content_format"
      expr: content_format
      comment: "Format of the content for this window"
    - name: "language_version"
      expr: language_version
      comment: "Language version for the window"
    - name: "abr_enabled"
      expr: abr_enabled
      comment: "Whether adaptive bitrate streaming is enabled"
    - name: "download_to_go_enabled"
      expr: download_to_go_enabled
      comment: "Whether download-to-go is enabled"
    - name: "bundle_eligibility"
      expr: bundle_eligibility
      comment: "Whether content is eligible for bundling"
    - name: "promotional_pricing"
      expr: promotional_pricing_flag
      comment: "Whether promotional pricing is active"
    - name: "dubbing_available"
      expr: dubbing_availability
      comment: "Whether dubbing is available"
    - name: "subtitle_available"
      expr: subtitle_availability
      comment: "Whether subtitles are available"
    - name: "planned_open_year"
      expr: YEAR(planned_open_date)
      comment: "Year the window is planned to open"
    - name: "planned_open_quarter"
      expr: CONCAT('Q', QUARTER(planned_open_date), '-', YEAR(planned_open_date))
      comment: "Quarter and year the window is planned to open"
  measures:
    - name: "total_windowing_plans"
      expr: COUNT(DISTINCT windowing_plan_id)
      comment: "Total number of windowing plans"
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee amounts across all windowing plans"
    - name: "avg_minimum_guarantee"
      expr: AVG(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Average minimum guarantee per windowing plan"
    - name: "total_price_point_value"
      expr: SUM(CAST(price_point AS DOUBLE))
      comment: "Total price point value across all windows"
    - name: "avg_price_point"
      expr: AVG(CAST(price_point AS DOUBLE))
      comment: "Average price point per window"
    - name: "avg_holdback_duration_days"
      expr: AVG(CAST(holdback_duration_days AS DOUBLE))
      comment: "Average holdback duration in days between windows"
    - name: "avg_viewing_window_hours"
      expr: AVG(CAST(viewing_window_hours AS DOUBLE))
      comment: "Average viewing window duration in hours"
    - name: "download_to_go_enabled_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN download_to_go_enabled = true THEN windowing_plan_id END) / NULLIF(COUNT(DISTINCT windowing_plan_id), 0), 2)
      comment: "Percentage of windows with download-to-go enabled"
    - name: "bundle_eligibility_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN bundle_eligibility = true THEN windowing_plan_id END) / NULLIF(COUNT(DISTINCT windowing_plan_id), 0), 2)
      comment: "Percentage of windows eligible for bundling"
    - name: "promotional_pricing_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN promotional_pricing_flag = true THEN windowing_plan_id END) / NULLIF(COUNT(DISTINCT windowing_plan_id), 0), 2)
      comment: "Percentage of windows with promotional pricing"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`content_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content version quality and technical compliance metrics tracking QC pass rates, file sizes, format distribution, and broadcast safety compliance"
  source: "`media_broadcasting_ecm`.`content`.`version`"
  dimensions:
    - name: "version_type"
      expr: version_type
      comment: "Type of version (master, proxy, distribution, preview, etc.)"
    - name: "version_status"
      expr: version_status
      comment: "Current status of the version (draft, approved, archived, etc.)"
    - name: "qc_status"
      expr: qc_status
      comment: "Quality control status"
    - name: "broadcast_safe"
      expr: broadcast_safe
      comment: "Whether the version is broadcast safe"
    - name: "target_platform"
      expr: target_platform
      comment: "Target platform for the version"
    - name: "target_territory"
      expr: target_territory
      comment: "Target territory for the version"
    - name: "file_format"
      expr: file_format
      comment: "File format of the version"
    - name: "video_codec"
      expr: video_codec
      comment: "Video codec used"
    - name: "audio_codec"
      expr: audio_codec
      comment: "Audio codec used"
    - name: "resolution"
      expr: resolution
      comment: "Video resolution"
    - name: "hdr_format"
      expr: hdr_format
      comment: "HDR format if applicable"
    - name: "aspect_ratio"
      expr: aspect_ratio
      comment: "Aspect ratio of the video"
    - name: "primary_language"
      expr: primary_language_code
      comment: "Primary language of the version"
    - name: "closed_caption_available"
      expr: closed_caption_available
      comment: "Whether closed captions are available"
    - name: "audio_description_available"
      expr: audio_description_available
      comment: "Whether audio description is available"
    - name: "qc_completed_year"
      expr: YEAR(qc_completed_date)
      comment: "Year QC was completed"
  measures:
    - name: "total_versions"
      expr: COUNT(DISTINCT version_id)
      comment: "Total number of content versions"
    - name: "total_file_size_gb"
      expr: SUM(CAST(file_size_bytes AS DOUBLE)) / 1073741824.0
      comment: "Total file size of all versions in gigabytes"
    - name: "avg_file_size_gb"
      expr: AVG(CAST(file_size_bytes AS DOUBLE)) / 1073741824.0
      comment: "Average file size per version in gigabytes"
    - name: "total_runtime_hours"
      expr: SUM(CAST(runtime_seconds AS DOUBLE)) / 3600.0
      comment: "Total runtime of all versions in hours"
    - name: "avg_runtime_minutes"
      expr: AVG(CAST(runtime_seconds AS DOUBLE)) / 60.0
      comment: "Average runtime per version in minutes"
    - name: "avg_frame_rate"
      expr: AVG(CAST(frame_rate AS DOUBLE))
      comment: "Average frame rate across versions"
    - name: "avg_file_size_per_minute_mb"
      expr: AVG((CAST(file_size_bytes AS DOUBLE) / 1048576.0) / NULLIF(CAST(runtime_seconds AS DOUBLE) / 60.0, 0))
      comment: "Average file size per minute of runtime in megabytes"
    - name: "qc_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN qc_status = 'passed' THEN version_id END) / NULLIF(COUNT(DISTINCT version_id), 0), 2)
      comment: "Percentage of versions that passed quality control"
    - name: "broadcast_safe_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN broadcast_safe = true THEN version_id END) / NULLIF(COUNT(DISTINCT version_id), 0), 2)
      comment: "Percentage of versions that are broadcast safe"
    - name: "accessibility_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN closed_caption_available = true AND audio_description_available = true THEN version_id END) / NULLIF(COUNT(DISTINCT version_id), 0), 2)
      comment: "Percentage of versions with full accessibility features"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`content_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content package commercial performance metrics tracking package value, title count, runtime inventory, and format availability for distribution deals"
  source: "`media_broadcasting_ecm`.`content`.`package`"
  dimensions:
    - name: "package_type"
      expr: package_type
      comment: "Type of content package (bundle, collection, season, series, etc.)"
    - name: "package_status"
      expr: package_status
      comment: "Current status of the package (active, pending, expired, etc.)"
    - name: "commercial_context"
      expr: commercial_context
      comment: "Commercial context for the package"
    - name: "territory_scope"
      expr: territory_scope
      comment: "Geographic scope of the package"
    - name: "language_primary"
      expr: language_primary
      comment: "Primary language of the package"
    - name: "exclusivity"
      expr: exclusivity_flag
      comment: "Whether the package includes exclusive rights"
    - name: "hd_available"
      expr: hd_available_flag
      comment: "Whether HD versions are available"
    - name: "uhd_4k_available"
      expr: uhd_4k_available_flag
      comment: "Whether UHD 4K versions are available"
    - name: "closed_caption_available"
      expr: closed_caption_available_flag
      comment: "Whether closed captions are available"
    - name: "drm_required"
      expr: drm_required_flag
      comment: "Whether DRM is required for the package"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the package becomes effective"
    - name: "effective_quarter"
      expr: CONCAT('Q', QUARTER(effective_date), '-', YEAR(effective_date))
      comment: "Quarter and year the package becomes effective"
  measures:
    - name: "total_packages"
      expr: COUNT(DISTINCT package_id)
      comment: "Total number of content packages"
    - name: "total_package_value_usd"
      expr: SUM(CAST(value_usd AS DOUBLE))
      comment: "Total value of all packages in USD"
    - name: "avg_package_value_usd"
      expr: AVG(CAST(value_usd AS DOUBLE))
      comment: "Average value per package in USD"
    - name: "total_title_count"
      expr: SUM(CAST(total_title_count AS DOUBLE))
      comment: "Total number of titles across all packages"
    - name: "avg_title_count_per_package"
      expr: AVG(CAST(total_title_count AS DOUBLE))
      comment: "Average number of titles per package"
    - name: "total_runtime_hours"
      expr: SUM(CAST(total_runtime_hours AS DOUBLE))
      comment: "Total runtime of all packages in hours"
    - name: "avg_runtime_hours_per_package"
      expr: AVG(CAST(total_runtime_hours AS DOUBLE))
      comment: "Average runtime per package in hours"
    - name: "avg_value_per_title_usd"
      expr: AVG(CAST(value_usd AS DOUBLE) / NULLIF(CAST(total_title_count AS DOUBLE), 0))
      comment: "Average value per title in USD"
    - name: "avg_value_per_hour_usd"
      expr: AVG(CAST(value_usd AS DOUBLE) / NULLIF(CAST(total_runtime_hours AS DOUBLE), 0))
      comment: "Average value per hour of content in USD"
    - name: "exclusive_package_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN exclusivity_flag = true THEN package_id END) / NULLIF(COUNT(DISTINCT package_id), 0), 2)
      comment: "Percentage of packages with exclusive rights"
    - name: "uhd_4k_availability_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN uhd_4k_available_flag = true THEN package_id END) / NULLIF(COUNT(DISTINCT package_id), 0), 2)
      comment: "Percentage of packages available in UHD 4K"
$$;