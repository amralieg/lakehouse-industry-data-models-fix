-- Metric views for domain: content | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-23 04:34:26

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_acquisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for content acquisition activity — tracks cost, royalty obligations, minimum guarantees, and exclusivity across acquired titles to inform investment and rights portfolio decisions."
  source: "`vibe_media_broadcasting_v1`.`content`.`acquisition`"
  dimensions:
    - name: "cost_currency"
      expr: cost_currency
      comment: "Currency denomination of the acquisition cost, enabling multi-currency portfolio analysis."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Indicates whether the acquisition carries exclusive rights, used to segment exclusive vs. non-exclusive deals."
    - name: "format_rights"
      expr: format_rights
      comment: "Format rights granted (e.g., linear, VOD, SVOD), used to analyze rights coverage by format."
    - name: "language_rights"
      expr: language_rights
      comment: "Language rights associated with the acquisition, supporting localization and territory planning."
    - name: "ancillary_rights_flag"
      expr: ancillary_rights_flag
      comment: "Indicates whether ancillary rights (e.g., merchandising, music) are included in the acquisition."
    - name: "sublicensing_allowed_flag"
      expr: sublicensing_allowed_flag
      comment: "Indicates whether the acquired rights can be sublicensed, a key factor in distribution strategy."
    - name: "residuals_obligation_flag"
      expr: residuals_obligation_flag
      comment: "Flags acquisitions carrying residuals obligations, impacting long-term cost forecasting."
    - name: "acquisition_date"
      expr: DATE_TRUNC('month', acquisition_date)
      comment: "Month of acquisition, enabling trend analysis of content spend over time."
    - name: "license_end_date"
      expr: DATE_TRUNC('month', license_end_date)
      comment: "Month the license expires, used to identify upcoming rights expirations requiring renewal decisions."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for the acquisition deal, used to analyze cash flow obligations by deal structure."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total spend on content acquisitions. Core investment KPI used by finance and content strategy to track content budget utilization."
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per acquisition deal. Benchmarks deal efficiency and informs negotiation strategy."
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee obligations across all acquisitions. Critical for financial liability and cash flow planning."
    - name: "avg_royalty_rate_percent"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate across acquisitions. Informs rights cost modeling and profitability forecasting per title."
    - name: "total_acquisitions"
      expr: COUNT(1)
      comment: "Total number of acquisition records. Baseline volume metric for content portfolio growth tracking."
    - name: "exclusive_acquisition_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END)
      comment: "Number of acquisitions with exclusive rights. Tracks the exclusivity depth of the content portfolio, a key competitive differentiator."
    - name: "sublicensable_acquisition_count"
      expr: COUNT(CASE WHEN sublicensing_allowed_flag = TRUE THEN 1 END)
      comment: "Number of acquisitions where sublicensing is permitted. Identifies revenue-generating sublicensing opportunities within the portfolio."
    - name: "residuals_obligation_count"
      expr: COUNT(CASE WHEN residuals_obligation_flag = TRUE THEN 1 END)
      comment: "Number of acquisitions carrying residuals obligations. Supports long-term cost liability forecasting for talent and union compliance."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_title`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Master content title KPIs — tracks the breadth, accessibility, and technical readiness of the title catalog to support programming, distribution, and compliance decisions."
  source: "`vibe_media_broadcasting_v1`.`content`.`title`"
  dimensions:
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the title was produced, used for content origin analysis and regulatory compliance."
    - name: "original_language"
      expr: original_language
      comment: "Original language of the title, supporting localization prioritization and audience targeting."
    - name: "sub_genre"
      expr: sub_genre
      comment: "Sub-genre classification of the title, enabling granular content catalog segmentation."
    - name: "hd_available_flag"
      expr: hd_available_flag
      comment: "Indicates whether an HD version is available, used to assess catalog technical quality for premium distribution."
    - name: "uhd_4k_available_flag"
      expr: uhd_4k_available_flag
      comment: "Indicates whether a 4K UHD version is available, key for premium OTT platform readiness."
    - name: "audio_description_available_flag"
      expr: audio_description_available_flag
      comment: "Indicates availability of audio description track, used to measure accessibility compliance across the catalog."
    - name: "closed_caption_available_flag"
      expr: closed_caption_available_flag
      comment: "Indicates availability of closed captions, a regulatory and accessibility requirement for broadcast and OTT."
    - name: "premiere_flag"
      expr: premiere_flag
      comment: "Flags titles designated as premieres, used to track high-priority content launches."
    - name: "theatrical_release_flag"
      expr: theatrical_release_flag
      comment: "Indicates whether the title had a theatrical release, used to segment theatrical vs. direct-to-streaming content."
    - name: "parental_advisory_flag"
      expr: parental_advisory_flag
      comment: "Indicates whether the title carries a parental advisory, used for content compliance and audience segmentation."
    - name: "release_date"
      expr: DATE_TRUNC('year', release_date)
      comment: "Year of title release, enabling catalog vintage analysis and content lifecycle management."
    - name: "acquisition_date"
      expr: DATE_TRUNC('month', acquisition_date)
      comment: "Month the title was acquired, used to track catalog growth velocity over time."
    - name: "studio_name"
      expr: studio_name
      comment: "Studio that produced the title, used to analyze catalog composition by studio partner."
    - name: "distributor_name"
      expr: distributor_name
      comment: "Distributor of the title, used to evaluate distribution partner portfolio coverage."
    - name: "coppa_child_directed_flag"
      expr: coppa_child_directed_flag
      comment: "Indicates whether the title is directed at children under COPPA, critical for regulatory compliance tracking."
  measures:
    - name: "total_titles"
      expr: COUNT(1)
      comment: "Total number of titles in the catalog. Baseline measure for catalog size and growth tracking."
    - name: "hd_ready_title_count"
      expr: COUNT(CASE WHEN hd_available_flag = TRUE THEN 1 END)
      comment: "Number of titles available in HD. Measures catalog technical readiness for HD distribution channels."
    - name: "uhd_4k_ready_title_count"
      expr: COUNT(CASE WHEN uhd_4k_available_flag = TRUE THEN 1 END)
      comment: "Number of titles available in 4K UHD. Tracks premium format readiness for high-value OTT platforms."
    - name: "accessibility_compliant_title_count"
      expr: COUNT(CASE WHEN audio_description_available_flag = TRUE AND closed_caption_available_flag = TRUE THEN 1 END)
      comment: "Number of titles meeting both audio description and closed caption accessibility requirements. Tracks regulatory compliance posture across the catalog."
    - name: "premiere_title_count"
      expr: COUNT(CASE WHEN premiere_flag = TRUE THEN 1 END)
      comment: "Number of premiere titles in the catalog. Tracks high-priority content launches that drive audience acquisition."
    - name: "coppa_compliant_title_count"
      expr: COUNT(CASE WHEN coppa_child_directed_flag = TRUE THEN 1 END)
      comment: "Number of titles flagged as child-directed under COPPA. Essential for regulatory compliance reporting and risk management."
    - name: "avg_aspect_ratio"
      expr: AVG(CAST(aspect_ratio AS DOUBLE))
      comment: "Average aspect ratio across titles. Indicates catalog format composition for display and delivery planning."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_episode`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Episode-level KPIs tracking broadcast readiness, accessibility compliance, and content availability across the episodic catalog for programming and operations decisions."
  source: "`vibe_media_broadcasting_v1`.`content`.`episode`"
  dimensions:
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of the episode, used for localization coverage and audience reach analysis."
    - name: "video_resolution"
      expr: video_resolution
      comment: "Video resolution of the episode (e.g., HD, 4K), used to assess technical quality distribution across the episodic catalog."
    - name: "audio_description_available"
      expr: audio_description_available
      comment: "Indicates whether audio description is available for the episode, used for accessibility compliance tracking."
    - name: "closed_caption_available"
      expr: closed_caption_available
      comment: "Indicates whether closed captions are available, a regulatory requirement for broadcast and streaming."
    - name: "subtitles_available"
      expr: subtitles_available
      comment: "Indicates whether subtitles are available, supporting international distribution readiness."
    - name: "premiere_flag"
      expr: premiere_flag
      comment: "Flags premiere episodes, used to track high-priority content events."
    - name: "rerun_flag"
      expr: rerun_flag
      comment: "Indicates whether the episode is a rerun, used to analyze original vs. repeat content scheduling."
    - name: "music_cue_sheet_submitted"
      expr: music_cue_sheet_submitted
      comment: "Indicates whether the music cue sheet has been submitted, a rights compliance requirement for broadcast."
    - name: "original_air_date"
      expr: DATE_TRUNC('month', original_air_date)
      comment: "Month of original air date, used to analyze content freshness and catalog vintage."
    - name: "vod_available_from_date"
      expr: DATE_TRUNC('month', vod_available_from_date)
      comment: "Month VOD availability begins, used to track windowing strategy execution."
  measures:
    - name: "total_episodes"
      expr: COUNT(1)
      comment: "Total number of episodes in the catalog. Baseline measure for episodic content volume."
    - name: "accessibility_compliant_episode_count"
      expr: COUNT(CASE WHEN audio_description_available = TRUE AND closed_caption_available = TRUE THEN 1 END)
      comment: "Episodes meeting both audio description and closed caption requirements. Tracks accessibility compliance posture for regulatory and brand risk management."
    - name: "music_cue_sheet_submitted_count"
      expr: COUNT(CASE WHEN music_cue_sheet_submitted = TRUE THEN 1 END)
      comment: "Number of episodes with music cue sheets submitted. Tracks rights compliance readiness for broadcast, reducing royalty dispute risk."
    - name: "vod_ready_episode_count"
      expr: COUNT(CASE WHEN vod_available_from_date IS NOT NULL THEN 1 END)
      comment: "Number of episodes with a VOD availability date set. Measures digital distribution readiness of the episodic catalog."
    - name: "premiere_episode_count"
      expr: COUNT(CASE WHEN premiere_flag = TRUE THEN 1 END)
      comment: "Number of premiere episodes. Tracks high-value content events that drive audience acquisition and ratings."
    - name: "rerun_episode_count"
      expr: COUNT(CASE WHEN rerun_flag = TRUE THEN 1 END)
      comment: "Number of rerun episodes. Used to analyze original vs. repeat content ratio, informing programming investment decisions."
    - name: "avg_aspect_ratio"
      expr: AVG(CAST(aspect_ratio AS DOUBLE))
      comment: "Average aspect ratio across episodes. Indicates technical format consistency for delivery and display planning."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_localization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Localization investment and quality KPIs — tracks cost, delivery performance, and QC pass rates across localization orders to optimize international content readiness and vendor management."
  source: "`vibe_media_broadcasting_v1`.`content`.`localization`"
  dimensions:
    - name: "version_number"
      expr: version_number
      comment: "Localization version number, used to track revision cycles and rework rates."
    - name: "qc_pass_flag"
      expr: qc_pass_flag
      comment: "Indicates whether the localization passed quality control, used to measure vendor quality performance."
    - name: "compliance_certification_flag"
      expr: compliance_certification_flag
      comment: "Indicates whether the localization meets compliance certification standards, critical for regulated markets."
    - name: "accessibility_standard_met"
      expr: accessibility_standard_met
      comment: "Accessibility standard achieved by the localization, used to track regulatory compliance across territories."
    - name: "order_date"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month the localization was ordered, used to analyze localization pipeline volume over time."
    - name: "actual_delivery_date"
      expr: DATE_TRUNC('month', actual_delivery_date)
      comment: "Month of actual delivery, used to track delivery performance trends."
    - name: "qc_review_date"
      expr: DATE_TRUNC('month', qc_review_date)
      comment: "Month of QC review, used to analyze QC throughput and backlog."
    - name: "qc_reviewer_name"
      expr: qc_reviewer_name
      comment: "Name of the QC reviewer, used to analyze reviewer workload and quality consistency."
  measures:
    - name: "total_localization_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total spend on localization orders. Core investment KPI for international content strategy and budget management."
    - name: "avg_localization_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per localization order. Benchmarks vendor pricing and informs budget forecasting for new territories."
    - name: "total_localization_duration_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total minutes of content localized. Measures localization throughput and pipeline capacity utilization."
    - name: "avg_localization_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration per localization order in minutes. Used to estimate future localization timelines and resource planning."
    - name: "total_localizations"
      expr: COUNT(1)
      comment: "Total number of localization orders. Baseline volume metric for international content pipeline management."
    - name: "qc_pass_count"
      expr: COUNT(CASE WHEN qc_pass_flag = TRUE THEN 1 END)
      comment: "Number of localizations that passed QC. Used to measure vendor quality and identify rework cost drivers."
    - name: "compliance_certified_count"
      expr: COUNT(CASE WHEN compliance_certification_flag = TRUE THEN 1 END)
      comment: "Number of localizations meeting compliance certification. Tracks regulatory readiness for market launches in certified territories."
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_date <= scheduled_delivery_date THEN 1 END)
      comment: "Number of localizations delivered on or before the scheduled date. Measures vendor delivery performance and supply chain reliability."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content package portfolio KPIs — tracks package value, runtime, exclusivity, and technical readiness to support distribution deal-making and OTT platform strategy."
  source: "`vibe_media_broadcasting_v1`.`content`.`package`"
  dimensions:
    - name: "language_primary"
      expr: language_primary
      comment: "Primary language of the package, used to analyze language coverage across distribution packages."
    - name: "commercial_context"
      expr: commercial_context
      comment: "Commercial context of the package (e.g., SVOD, AVOD, linear), used to segment packages by monetization model."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Indicates whether the package carries exclusive rights, a key differentiator in distribution negotiations."
    - name: "drm_required_flag"
      expr: drm_required_flag
      comment: "Indicates whether DRM is required for the package, used to assess technical delivery complexity."
    - name: "hd_available_flag"
      expr: hd_available_flag
      comment: "Indicates whether HD content is available in the package, used to assess premium format coverage."
    - name: "uhd_4k_available_flag"
      expr: uhd_4k_available_flag
      comment: "Indicates whether 4K UHD content is available in the package, used for premium OTT platform readiness."
    - name: "audio_description_available_flag"
      expr: audio_description_available_flag
      comment: "Indicates whether audio description is available in the package, used for accessibility compliance."
    - name: "closed_caption_available_flag"
      expr: closed_caption_available_flag
      comment: "Indicates whether closed captions are available in the package, a regulatory requirement."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the package becomes effective, used to track distribution pipeline activation."
    - name: "expiry_date"
      expr: DATE_TRUNC('month', expiry_date)
      comment: "Month the package expires, used to identify upcoming renewals and revenue risk."
  measures:
    - name: "total_package_value_usd"
      expr: SUM(CAST(value_usd AS DOUBLE))
      comment: "Total USD value of all content packages. Core revenue and portfolio value KPI for distribution strategy and deal performance."
    - name: "avg_package_value_usd"
      expr: AVG(CAST(value_usd AS DOUBLE))
      comment: "Average USD value per content package. Benchmarks deal size and informs pricing strategy for new distribution agreements."
    - name: "total_runtime_hours"
      expr: SUM(CAST(total_runtime_hours AS DOUBLE))
      comment: "Total runtime hours across all packages. Measures content volume committed to distribution partners, informing capacity and scheduling."
    - name: "avg_runtime_hours"
      expr: AVG(CAST(total_runtime_hours AS DOUBLE))
      comment: "Average runtime hours per package. Used to benchmark package size and assess content depth per distribution deal."
    - name: "total_packages"
      expr: COUNT(1)
      comment: "Total number of content packages. Baseline measure for distribution portfolio breadth."
    - name: "exclusive_package_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END)
      comment: "Number of packages with exclusive rights. Tracks exclusivity depth in the distribution portfolio, a key competitive and revenue driver."
    - name: "drm_required_package_count"
      expr: COUNT(CASE WHEN drm_required_flag = TRUE THEN 1 END)
      comment: "Number of packages requiring DRM. Informs technical infrastructure investment and delivery complexity planning."
    - name: "uhd_4k_package_count"
      expr: COUNT(CASE WHEN uhd_4k_available_flag = TRUE THEN 1 END)
      comment: "Number of packages with 4K UHD availability. Tracks premium format readiness for high-value OTT distribution deals."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_windowing_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content windowing strategy KPIs — tracks planned window economics, pricing, promotional activity, and streaming capability across distribution windows to optimize revenue sequencing and platform strategy."
  source: "`vibe_media_broadcasting_v1`.`content`.`windowing_plan`"
  dimensions:
    - name: "revenue_model"
      expr: revenue_model
      comment: "Revenue model for the window (e.g., SVOD, AVOD, TVOD, linear), used to analyze monetization strategy distribution."
    - name: "language_version"
      expr: language_version
      comment: "Language version of the content in this window, used to analyze localization coverage across windows."
    - name: "streaming_protocol"
      expr: streaming_protocol
      comment: "Streaming protocol used for delivery (e.g., HLS, DASH), used to assess technical delivery infrastructure."
    - name: "abr_enabled"
      expr: abr_enabled
      comment: "Indicates whether adaptive bitrate streaming is enabled, used to assess streaming quality capability."
    - name: "download_to_go_enabled"
      expr: download_to_go_enabled
      comment: "Indicates whether offline download is enabled for this window, a premium feature for subscriber retention."
    - name: "promotional_pricing_flag"
      expr: promotional_pricing_flag
      comment: "Indicates whether promotional pricing is applied, used to analyze promotional window strategy and revenue impact."
    - name: "subtitle_availability"
      expr: subtitle_availability
      comment: "Indicates whether subtitles are available in this window, used for international accessibility compliance."
    - name: "dubbing_availability"
      expr: dubbing_availability
      comment: "Indicates whether dubbing is available in this window, used to assess localization depth for international markets."
    - name: "bundle_eligibility"
      expr: bundle_eligibility
      comment: "Indicates whether the title is eligible for bundling in this window, used to support bundle packaging strategy."
    - name: "planned_open_date"
      expr: DATE_TRUNC('month', planned_open_date)
      comment: "Month the window is planned to open, used to analyze windowing pipeline and release cadence."
    - name: "planned_close_date"
      expr: DATE_TRUNC('month', planned_close_date)
      comment: "Month the window is planned to close, used to track rights expiration and renewal planning."
    - name: "daypart_restriction"
      expr: daypart_restriction
      comment: "Daypart restriction applied to the window, used to analyze scheduling constraints across the windowing portfolio."
  measures:
    - name: "total_minimum_guarantee_amount"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee obligations across all windowing plans. Critical financial liability KPI for revenue forecasting and rights cost management."
    - name: "avg_minimum_guarantee_amount"
      expr: AVG(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Average minimum guarantee per windowing plan. Benchmarks deal economics and informs pricing strategy for new window negotiations."
    - name: "total_price_point_value"
      expr: SUM(CAST(price_point AS DOUBLE))
      comment: "Sum of price points across all windowing plans. Proxy for total planned window revenue potential across the distribution portfolio."
    - name: "avg_price_point"
      expr: AVG(CAST(price_point AS DOUBLE))
      comment: "Average price point per windowing plan. Used to benchmark pricing strategy across revenue models and platforms."
    - name: "total_windowing_plans"
      expr: COUNT(1)
      comment: "Total number of windowing plans. Baseline measure for distribution window pipeline volume."
    - name: "promotional_window_count"
      expr: COUNT(CASE WHEN promotional_pricing_flag = TRUE THEN 1 END)
      comment: "Number of windows with promotional pricing. Tracks promotional strategy intensity and its potential revenue impact."
    - name: "download_to_go_enabled_count"
      expr: COUNT(CASE WHEN download_to_go_enabled = TRUE THEN 1 END)
      comment: "Number of windows with offline download enabled. Measures premium feature availability across the distribution portfolio, a key subscriber value driver."
    - name: "bundle_eligible_window_count"
      expr: COUNT(CASE WHEN bundle_eligibility = TRUE THEN 1 END)
      comment: "Number of windows eligible for bundling. Supports bundle packaging strategy and cross-platform deal structuring."
    - name: "distinct_titles_in_windows"
      expr: COUNT(DISTINCT title_id)
      comment: "Number of distinct titles with active windowing plans. Measures breadth of the windowed content portfolio across distribution channels."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_series`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Series-level portfolio KPIs — tracks catalog composition, accessibility readiness, and syndication eligibility across the series catalog to inform programming investment and distribution strategy."
  source: "`vibe_media_broadcasting_v1`.`content`.`series`"
  dimensions:
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the series, used to analyze catalog geographic diversity and co-production strategy."
    - name: "language_original"
      expr: language_original
      comment: "Original language of the series, used to assess localization needs and international distribution potential."
    - name: "original_network"
      expr: original_network
      comment: "Network that originally aired the series, used to analyze catalog composition by network partner."
    - name: "production_company"
      expr: production_company
      comment: "Production company behind the series, used to evaluate production partner portfolio and deal concentration."
    - name: "syndication_eligible"
      expr: syndication_eligible
      comment: "Indicates whether the series is eligible for syndication, a key revenue diversification indicator."
    - name: "audio_description_available"
      expr: audio_description_available
      comment: "Indicates whether audio description is available for the series, used for accessibility compliance tracking."
    - name: "closed_caption_available"
      expr: closed_caption_available
      comment: "Indicates whether closed captions are available, a regulatory requirement for broadcast and streaming."
    - name: "target_demographic"
      expr: target_demographic
      comment: "Target demographic for the series, used to analyze catalog composition by audience segment."
    - name: "franchise_name"
      expr: franchise_name
      comment: "Franchise the series belongs to, used to track franchise portfolio value and cross-title strategy."
    - name: "premiere_date"
      expr: DATE_TRUNC('year', premiere_date)
      comment: "Year of series premiere, used to analyze catalog vintage and content lifecycle."
  measures:
    - name: "total_series"
      expr: COUNT(1)
      comment: "Total number of series in the catalog. Baseline measure for series portfolio breadth and growth."
    - name: "syndication_eligible_series_count"
      expr: COUNT(CASE WHEN syndication_eligible = TRUE THEN 1 END)
      comment: "Number of series eligible for syndication. Tracks revenue diversification potential through syndication deals."
    - name: "accessibility_compliant_series_count"
      expr: COUNT(CASE WHEN audio_description_available = TRUE AND closed_caption_available = TRUE THEN 1 END)
      comment: "Number of series meeting both audio description and closed caption requirements. Tracks accessibility compliance posture for regulatory and brand risk management."
    - name: "avg_aspect_ratio"
      expr: AVG(CAST(aspect_ratio AS DOUBLE))
      comment: "Average aspect ratio across series. Indicates technical format composition for display and delivery planning."
    - name: "distinct_production_companies"
      expr: COUNT(DISTINCT production_company)
      comment: "Number of distinct production companies in the series catalog. Measures production partner diversity and deal concentration risk."
    - name: "distinct_franchises"
      expr: COUNT(DISTINCT franchise_name)
      comment: "Number of distinct franchises represented in the series catalog. Tracks franchise portfolio breadth, a key driver of brand value and audience loyalty."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content version technical readiness KPIs — tracks QC completion, broadcast safety, accessibility, and file size across content versions to ensure delivery quality and operational efficiency."
  source: "`vibe_media_broadcasting_v1`.`content`.`version`"
  dimensions:
    - name: "resolution"
      expr: resolution
      comment: "Video resolution of the content version (e.g., 1080p, 4K), used to analyze technical quality distribution."
    - name: "audio_codec"
      expr: audio_codec
      comment: "Audio codec used in the version, used to assess delivery format compatibility across platforms."
    - name: "video_codec"
      expr: video_codec
      comment: "Video codec used in the version, used to assess delivery format compatibility and transcoding requirements."
    - name: "broadcast_safe"
      expr: broadcast_safe
      comment: "Indicates whether the version meets broadcast safety standards, a hard requirement for linear broadcast delivery."
    - name: "audio_description_available"
      expr: audio_description_available
      comment: "Indicates whether audio description is available in this version, used for accessibility compliance."
    - name: "closed_caption_available"
      expr: closed_caption_available
      comment: "Indicates whether closed captions are available in this version, a regulatory requirement."
    - name: "qc_completed_date"
      expr: DATE_TRUNC('month', qc_completed_date)
      comment: "Month QC was completed, used to track QC throughput and backlog trends."
    - name: "label"
      expr: label
      comment: "Version label (e.g., theatrical, broadcast, streaming), used to segment versions by intended use case."
    - name: "audio_track_configuration"
      expr: audio_track_configuration
      comment: "Audio track configuration (e.g., stereo, 5.1, Dolby Atmos), used to assess premium audio availability across the version catalog."
  measures:
    - name: "total_versions"
      expr: COUNT(1)
      comment: "Total number of content versions. Baseline measure for version catalog volume and technical asset management."
    - name: "broadcast_safe_version_count"
      expr: COUNT(CASE WHEN broadcast_safe = TRUE THEN 1 END)
      comment: "Number of versions certified as broadcast safe. Tracks delivery readiness for linear broadcast channels, a hard operational requirement."
    - name: "qc_completed_version_count"
      expr: COUNT(CASE WHEN qc_completed_date IS NOT NULL THEN 1 END)
      comment: "Number of versions with QC completed. Measures technical pipeline throughput and delivery readiness."
    - name: "total_file_size_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total storage footprint of all content versions in bytes. Drives infrastructure cost planning and storage capacity management."
    - name: "avg_file_size_bytes"
      expr: AVG(CAST(file_size_bytes AS DOUBLE))
      comment: "Average file size per content version in bytes. Benchmarks storage and delivery bandwidth requirements per version."
    - name: "avg_frame_rate"
      expr: AVG(CAST(frame_rate AS DOUBLE))
      comment: "Average frame rate across content versions. Indicates technical format consistency for broadcast and streaming delivery standards."
    - name: "accessibility_compliant_version_count"
      expr: COUNT(CASE WHEN audio_description_available = TRUE AND closed_caption_available = TRUE THEN 1 END)
      comment: "Number of versions meeting both audio description and closed caption requirements. Tracks accessibility compliance at the version level for regulatory reporting."
$$;