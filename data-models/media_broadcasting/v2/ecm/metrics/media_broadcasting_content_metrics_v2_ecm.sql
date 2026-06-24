-- Metric views for domain: content | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-22 23:42:33

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_acquisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks content acquisition economics — license costs, royalty obligations, minimum guarantees, and run utilisation — enabling executives to evaluate portfolio spend efficiency and rights utilisation against committed minimums."
  source: "`vibe_media_broadcasting_v1`.`content`.`acquisition`"
  dimensions:
    - name: "acquisition_type"
      expr: acquisition_type_id
      comment: "FK to acquisition type reference — groups acquisitions by deal structure (buy-out, license, co-production, etc.)."
    - name: "acquisition_status"
      expr: acquisition_status_id
      comment: "FK to acquisition status reference — filters by active, expired, pending, or cancelled deals."
    - name: "clearance_status"
      expr: clearance_status_id
      comment: "FK to clearance status — identifies deals awaiting rights clearance vs. fully cleared."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Boolean indicating whether the acquisition carries exclusive rights — used to segment premium vs. non-exclusive spend."
    - name: "sublicensing_allowed_flag"
      expr: sublicensing_allowed_flag
      comment: "Boolean indicating whether sublicensing is permitted — informs downstream revenue potential."
    - name: "residuals_obligation_flag"
      expr: residuals_obligation_flag
      comment: "Boolean indicating residuals liability — used to segment deals with ongoing talent payment obligations."
    - name: "license_start_date"
      expr: DATE_TRUNC('month', license_start_date)
      comment: "Month bucket of license start date — enables cohort analysis of deal vintages."
    - name: "license_end_date"
      expr: DATE_TRUNC('quarter', license_end_date)
      comment: "Quarter bucket of license end date — supports rights expiry pipeline planning."
    - name: "acquisition_date"
      expr: DATE_TRUNC('year', acquisition_date)
      comment: "Year bucket of acquisition date — supports multi-year spend trend analysis."
    - name: "cost_currency"
      expr: cost_currency
      comment: "Currency of the acquisition cost — enables multi-currency portfolio segmentation."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total committed acquisition spend across all deals in scope. Core P&L input for content investment decisions."
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per acquisition deal — benchmarks deal economics and flags outlier spend."
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee obligations committed — critical liability figure for finance and treasury."
    - name: "avg_royalty_rate_percent"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate across acquisitions — informs blended rights cost modelling."
    - name: "acquisition_deal_count"
      expr: COUNT(1)
      comment: "Total number of acquisition deals — baseline volume metric for portfolio breadth."
    - name: "exclusive_deal_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END)
      comment: "Number of exclusive acquisition deals — measures premium rights concentration."
    - name: "residuals_obligated_deal_count"
      expr: COUNT(CASE WHEN residuals_obligation_flag = TRUE THEN 1 END)
      comment: "Number of deals carrying residuals obligations — quantifies ongoing talent payment liability exposure."
    - name: "sublicensable_deal_count"
      expr: COUNT(CASE WHEN sublicensing_allowed_flag = TRUE THEN 1 END)
      comment: "Number of deals where sublicensing is permitted — measures monetisation optionality in the portfolio."
    - name: "cost_per_exclusive_deal"
      expr: SUM(CASE WHEN exclusivity_flag = TRUE THEN cost_amount ELSE 0 END)
      comment: "Total spend on exclusive deals — isolates premium rights investment for ROI analysis."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_episode`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures episode catalogue health, availability, and broadcast readiness — enabling programming and operations teams to track episode volume, accessibility compliance, and VOD window coverage."
  source: "`vibe_media_broadcasting_v1`.`content`.`content_episode`"
  dimensions:
    - name: "episode_status"
      expr: episode_status_id
      comment: "FK to episode status reference — segments episodes by production/broadcast lifecycle stage."
    - name: "episode_type"
      expr: episode_type_id
      comment: "FK to episode type reference — distinguishes regular, special, pilot, finale episodes."
    - name: "genre"
      expr: genre_id
      comment: "FK to genre — enables genre-level episode catalogue analysis."
    - name: "rights_clearance_status"
      expr: rights_clearance_status_id
      comment: "FK to rights clearance status — identifies episodes blocked from distribution due to rights issues."
    - name: "premiere_flag"
      expr: premiere_flag
      comment: "Boolean indicating premiere episode — used to segment high-value premiere inventory."
    - name: "rerun_flag"
      expr: rerun_flag
      comment: "Boolean indicating rerun — distinguishes original vs. repeat broadcast inventory."
    - name: "closed_caption_available"
      expr: closed_caption_available
      comment: "Boolean indicating closed caption availability — tracks accessibility compliance coverage."
    - name: "audio_description_available"
      expr: audio_description_available
      comment: "Boolean indicating audio description availability — tracks accessibility compliance for visually impaired audiences."
    - name: "original_air_date"
      expr: DATE_TRUNC('month', original_air_date)
      comment: "Month bucket of original air date — supports catalogue vintage and scheduling analysis."
    - name: "vod_available_from_date"
      expr: DATE_TRUNC('month', vod_available_from_date)
      comment: "Month bucket of VOD availability start — tracks windowing pipeline."
  measures:
    - name: "total_episode_count"
      expr: COUNT(1)
      comment: "Total episodes in catalogue — baseline measure of content library depth."
    - name: "premiere_episode_count"
      expr: COUNT(CASE WHEN premiere_flag = TRUE THEN 1 END)
      comment: "Number of premiere episodes — measures new original content volume, a key programming investment indicator."
    - name: "closed_caption_coverage_count"
      expr: COUNT(CASE WHEN closed_caption_available = TRUE THEN 1 END)
      comment: "Episodes with closed captions available — measures FCC/Ofcom accessibility compliance coverage."
    - name: "audio_description_coverage_count"
      expr: COUNT(CASE WHEN audio_description_available = TRUE THEN 1 END)
      comment: "Episodes with audio description available — measures accessibility compliance for visually impaired viewers."
    - name: "music_cue_sheet_submitted_count"
      expr: COUNT(CASE WHEN music_cue_sheet_submitted = TRUE THEN 1 END)
      comment: "Episodes with music cue sheets submitted — tracks music rights compliance readiness for broadcast."
    - name: "vod_available_episode_count"
      expr: COUNT(CASE WHEN vod_available_from_date IS NOT NULL THEN 1 END)
      comment: "Episodes with an active VOD availability window — measures digital distribution catalogue depth."
    - name: "rights_cleared_episode_count"
      expr: COUNT(CASE WHEN rights_clearance_status_id IS NOT NULL THEN 1 END)
      comment: "Episodes with a rights clearance status assigned — proxy for rights-ready inventory."
    - name: "subtitles_available_count"
      expr: COUNT(CASE WHEN subtitles_available = TRUE THEN 1 END)
      comment: "Episodes with subtitles available — measures localisation and accessibility readiness."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_title`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides a strategic view of the title catalogue — tracking rights status, accessibility compliance, content type mix, and release pipeline to support programming, rights, and distribution decisions."
  source: "`vibe_media_broadcasting_v1`.`content`.`title`"
  dimensions:
    - name: "content_type"
      expr: content_type_id
      comment: "FK to content type reference — segments titles by movie, series, short, documentary, etc."
    - name: "content_status"
      expr: content_status_id
      comment: "FK to content status reference — filters active, archived, or in-production titles."
    - name: "rights_status"
      expr: rights_status_id
      comment: "FK to rights status reference — identifies titles with cleared, expired, or contested rights."
    - name: "genre"
      expr: genre_id
      comment: "FK to genre — enables genre-level catalogue analysis."
    - name: "theatrical_release_flag"
      expr: theatrical_release_flag
      comment: "Boolean indicating theatrical release — segments premium theatrical titles from direct-to-streaming."
    - name: "hd_available_flag"
      expr: hd_available_flag
      comment: "Boolean indicating HD availability — measures technical quality coverage of catalogue."
    - name: "uhd_4k_available_flag"
      expr: uhd_4k_available_flag
      comment: "Boolean indicating 4K UHD availability — tracks premium format catalogue depth."
    - name: "coppa_child_directed_flag"
      expr: coppa_child_directed_flag
      comment: "Boolean indicating COPPA child-directed content — critical for regulatory compliance segmentation."
    - name: "release_date"
      expr: DATE_TRUNC('year', release_date)
      comment: "Year bucket of release date — supports vintage analysis of catalogue."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin — enables geographic content mix analysis."
  measures:
    - name: "total_title_count"
      expr: COUNT(1)
      comment: "Total titles in catalogue — baseline measure of content library breadth."
    - name: "hd_available_title_count"
      expr: COUNT(CASE WHEN hd_available_flag = TRUE THEN 1 END)
      comment: "Titles available in HD — measures technical quality coverage for distribution SLA compliance."
    - name: "uhd_4k_available_title_count"
      expr: COUNT(CASE WHEN uhd_4k_available_flag = TRUE THEN 1 END)
      comment: "Titles available in 4K UHD — tracks premium format catalogue investment."
    - name: "theatrical_title_count"
      expr: COUNT(CASE WHEN theatrical_release_flag = TRUE THEN 1 END)
      comment: "Titles with theatrical release history — measures premium content depth in catalogue."
    - name: "coppa_flagged_title_count"
      expr: COUNT(CASE WHEN coppa_child_directed_flag = TRUE THEN 1 END)
      comment: "Titles flagged as COPPA child-directed — critical compliance metric for FTC regulatory exposure."
    - name: "closed_caption_compliant_title_count"
      expr: COUNT(CASE WHEN closed_caption_available_flag = TRUE THEN 1 END)
      comment: "Titles with closed captions available — measures FCC accessibility compliance coverage."
    - name: "audio_description_compliant_title_count"
      expr: COUNT(CASE WHEN audio_description_available_flag = TRUE THEN 1 END)
      comment: "Titles with audio description available — measures accessibility compliance for visually impaired audiences."
    - name: "distinct_series_count"
      expr: COUNT(DISTINCT series_id)
      comment: "Number of distinct series represented in the title catalogue — measures franchise breadth."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_windowing_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks content windowing economics and distribution strategy — measuring price points, minimum guarantees, exclusivity, and window sequencing to optimise multi-platform revenue maximisation."
  source: "`vibe_media_broadcasting_v1`.`content`.`windowing_plan`"
  dimensions:
    - name: "window_type"
      expr: window_type_id
      comment: "FK to window type reference — segments by theatrical, SVOD, AVOD, FAST, linear, etc."
    - name: "window_status"
      expr: window_status_id
      comment: "FK to window status reference — filters active, planned, expired, or cancelled windows."
    - name: "exclusivity_tier"
      expr: exclusivity_tier_id
      comment: "FK to exclusivity tier — segments windows by exclusivity level for premium pricing analysis."
    - name: "abr_enabled"
      expr: abr_enabled
      comment: "Boolean indicating ABR streaming is enabled — segments streaming-ready windows."
    - name: "download_to_go_enabled"
      expr: download_to_go_enabled
      comment: "Boolean indicating download-to-go is enabled — measures offline viewing capability coverage."
    - name: "promotional_pricing_flag"
      expr: promotional_pricing_flag
      comment: "Boolean indicating promotional pricing — segments discounted windows for revenue impact analysis."
    - name: "bundle_eligibility"
      expr: bundle_eligibility
      comment: "Boolean indicating bundle eligibility — measures content available for bundled distribution deals."
    - name: "planned_open_date"
      expr: DATE_TRUNC('month', planned_open_date)
      comment: "Month bucket of planned window open date — supports distribution pipeline planning."
    - name: "planned_close_date"
      expr: DATE_TRUNC('quarter', planned_close_date)
      comment: "Quarter bucket of planned window close date — supports rights expiry and renewal planning."
    - name: "revenue_model"
      expr: revenue_model
      comment: "Revenue model string (SVOD, AVOD, TVOD, FAST, etc.) — segments windows by monetisation strategy."
  measures:
    - name: "total_windowing_plans"
      expr: COUNT(1)
      comment: "Total windowing plans — baseline measure of distribution strategy breadth across titles."
    - name: "total_minimum_guarantee_committed"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee amounts committed across all windowing plans — key liability figure for finance."
    - name: "avg_price_point"
      expr: AVG(CAST(price_point AS DOUBLE))
      comment: "Average price point across windowing plans — benchmarks TVOD/EST pricing strategy."
    - name: "total_price_point_revenue_potential"
      expr: SUM(CAST(price_point AS DOUBLE))
      comment: "Sum of price points across all plans — proxy for total transactional revenue potential in pipeline."
    - name: "exclusive_window_count"
      expr: COUNT(CASE WHEN exclusivity_tier_id IS NOT NULL THEN 1 END)
      comment: "Number of windows with an exclusivity tier assigned — measures premium exclusive distribution coverage."
    - name: "abr_enabled_window_count"
      expr: COUNT(CASE WHEN abr_enabled = TRUE THEN 1 END)
      comment: "Number of windows with ABR streaming enabled — measures adaptive streaming distribution readiness."
    - name: "download_to_go_window_count"
      expr: COUNT(CASE WHEN download_to_go_enabled = TRUE THEN 1 END)
      comment: "Number of windows with download-to-go enabled — measures offline viewing capability in distribution portfolio."
    - name: "promotional_window_count"
      expr: COUNT(CASE WHEN promotional_pricing_flag = TRUE THEN 1 END)
      comment: "Number of windows with promotional pricing — quantifies discounted distribution exposure."
    - name: "bundle_eligible_window_count"
      expr: COUNT(CASE WHEN bundle_eligibility = TRUE THEN 1 END)
      comment: "Number of windows eligible for bundled distribution — measures content available for package deals."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_localization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures localisation pipeline performance — tracking delivery timeliness, QC pass rates, and cost per localisation to optimise international distribution readiness and vendor management."
  source: "`vibe_media_broadcasting_v1`.`content`.`localization`"
  dimensions:
    - name: "localization_type"
      expr: localization_type_id
      comment: "FK to localisation type reference — segments by dubbing, subtitling, metadata translation, etc."
    - name: "localization_status"
      expr: localization_status_id
      comment: "FK to localisation status reference — filters in-progress, completed, or failed localisations."
    - name: "target_language_code"
      expr: target_language_code_id
      comment: "FK to target language code — enables language-level localisation coverage analysis."
    - name: "target_territory_code"
      expr: target_territory_code_id
      comment: "FK to target territory code — enables territory-level localisation pipeline analysis."
    - name: "qc_pass_flag"
      expr: qc_pass_flag
      comment: "Boolean indicating QC pass — segments quality-approved vs. failed localisations."
    - name: "compliance_certification_flag"
      expr: compliance_certification_flag
      comment: "Boolean indicating compliance certification — tracks regulatory-ready localisations."
    - name: "order_date"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month bucket of localisation order date — supports pipeline volume trend analysis."
    - name: "scheduled_delivery_date"
      expr: DATE_TRUNC('month', scheduled_delivery_date)
      comment: "Month bucket of scheduled delivery date — supports SLA monitoring."
  measures:
    - name: "total_localization_orders"
      expr: COUNT(1)
      comment: "Total localisation orders — baseline measure of international distribution pipeline volume."
    - name: "total_localization_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total localisation spend — key input for international distribution cost management."
    - name: "avg_localization_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per localisation order — benchmarks vendor pricing and identifies cost outliers."
    - name: "qc_passed_count"
      expr: COUNT(CASE WHEN qc_pass_flag = TRUE THEN 1 END)
      comment: "Number of localisations that passed QC — measures quality delivery rate."
    - name: "qc_failed_count"
      expr: COUNT(CASE WHEN qc_pass_flag = FALSE THEN 1 END)
      comment: "Number of localisations that failed QC — identifies quality issues requiring rework and cost overruns."
    - name: "compliance_certified_count"
      expr: COUNT(CASE WHEN compliance_certification_flag = TRUE THEN 1 END)
      comment: "Number of localisations with compliance certification — measures regulatory-ready international content."
    - name: "total_localization_duration_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total minutes of content localised — measures throughput volume for capacity planning."
    - name: "avg_localization_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration per localisation order — benchmarks complexity and informs cost modelling."
    - name: "distinct_target_languages"
      expr: COUNT(DISTINCT target_language_code_id)
      comment: "Number of distinct target languages in localisation pipeline — measures international reach breadth."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_compliance_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks content compliance violations — measuring fine exposure, remediation costs, recurrence rates, and resolution timeliness to manage regulatory risk and operational compliance quality."
  source: "`vibe_media_broadcasting_v1`.`content`.`compliance_finding`"
  dimensions:
    - name: "compliance_type"
      expr: compliance_type_id
      comment: "FK to compliance type reference — segments findings by violation category (FCC, COPPA, accessibility, etc.)."
    - name: "severity_level"
      expr: severity_level_id
      comment: "FK to severity level reference — prioritises findings by regulatory impact."
    - name: "resolution_status"
      expr: resolution_status_id
      comment: "FK to resolution status reference — tracks open vs. resolved compliance findings."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Boolean indicating recurring violation — identifies systemic compliance failures requiring process change."
    - name: "makegoods_required_flag"
      expr: makegoods_required_flag
      comment: "Boolean indicating makegoods are required — measures advertiser remediation obligations."
    - name: "finding_date"
      expr: DATE_TRUNC('month', finding_date)
      comment: "Month bucket of finding date — supports compliance trend analysis."
    - name: "due_date"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month bucket of remediation due date — supports SLA breach risk monitoring."
    - name: "affected_platform"
      expr: affected_platform
      comment: "Platform where the violation occurred — segments compliance risk by distribution channel."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body issuing the finding — segments by FCC, Ofcom, FTC, etc."
  measures:
    - name: "total_compliance_findings"
      expr: COUNT(1)
      comment: "Total compliance findings — baseline measure of regulatory violation volume."
    - name: "total_fine_amount"
      expr: SUM(CAST(fine_amount AS DOUBLE))
      comment: "Total fines levied across all compliance findings — direct financial risk measure for regulatory exposure."
    - name: "avg_fine_amount"
      expr: AVG(CAST(fine_amount AS DOUBLE))
      comment: "Average fine per compliance finding — benchmarks severity of regulatory penalties."
    - name: "total_remediation_cost"
      expr: SUM(CAST(remediation_cost AS DOUBLE))
      comment: "Total remediation costs incurred — measures operational cost of compliance failures."
    - name: "avg_remediation_cost"
      expr: AVG(CAST(remediation_cost AS DOUBLE))
      comment: "Average remediation cost per finding — benchmarks compliance resolution efficiency."
    - name: "recurring_finding_count"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Number of recurring compliance violations — identifies systemic process failures requiring escalation."
    - name: "makegoods_required_count"
      expr: COUNT(CASE WHEN makegoods_required_flag = TRUE THEN 1 END)
      comment: "Number of findings requiring advertiser makegoods — quantifies commercial remediation obligations."
    - name: "open_finding_count"
      expr: COUNT(CASE WHEN resolution_date IS NULL THEN 1 END)
      comment: "Number of unresolved compliance findings — measures current regulatory risk exposure."
    - name: "total_fine_plus_remediation"
      expr: SUM(CAST(fine_amount AS DOUBLE) + CAST(remediation_cost AS DOUBLE))
      comment: "Combined total of fines and remediation costs — full financial impact of compliance failures."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_ingest_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors content ingest pipeline performance — tracking throughput, file volumes, QC outcomes, and error rates to ensure operational efficiency and SLA compliance for content delivery."
  source: "`vibe_media_broadcasting_v1`.`content`.`ingest_event`"
  dimensions:
    - name: "ingest_status"
      expr: ingest_status_id
      comment: "FK to ingest status reference — segments events by success, failure, in-progress, or retry states."
    - name: "ingest_source_type"
      expr: ingest_source_type_id
      comment: "FK to ingest source type reference — segments by satellite, FTP, cloud, tape, etc."
    - name: "delivery_method"
      expr: delivery_method_id
      comment: "FK to delivery method reference — segments by delivery channel for throughput analysis."
    - name: "priority_level"
      expr: priority_level_id
      comment: "FK to priority level reference — segments high-priority vs. standard ingest jobs."
    - name: "audio_description_detected_flag"
      expr: audio_description_detected_flag
      comment: "Boolean indicating audio description was detected in source — measures accessibility compliance at ingest."
    - name: "closed_caption_detected_flag"
      expr: closed_caption_detected_flag
      comment: "Boolean indicating closed captions detected in source — measures accessibility compliance at ingest."
    - name: "metadata_package_received_flag"
      expr: metadata_package_received_flag
      comment: "Boolean indicating metadata package was received — tracks metadata completeness at ingest."
    - name: "ingest_timestamp"
      expr: DATE_TRUNC('day', ingest_timestamp)
      comment: "Day bucket of ingest timestamp — supports daily throughput trend analysis."
  measures:
    - name: "total_ingest_events"
      expr: COUNT(1)
      comment: "Total ingest events — baseline measure of content pipeline throughput volume."
    - name: "total_source_file_size_bytes"
      expr: SUM(CAST(source_file_size_bytes AS DOUBLE))
      comment: "Total bytes ingested — measures storage and bandwidth consumption for capacity planning."
    - name: "avg_source_file_size_bytes"
      expr: AVG(CAST(source_file_size_bytes AS DOUBLE))
      comment: "Average file size per ingest event — benchmarks typical content package size for infrastructure planning."
    - name: "total_source_duration_seconds"
      expr: SUM(CAST(source_duration_seconds AS DOUBLE))
      comment: "Total seconds of content ingested — measures content volume throughput."
    - name: "avg_source_frame_rate"
      expr: AVG(CAST(source_frame_rate AS DOUBLE))
      comment: "Average source frame rate across ingest events — monitors technical quality of incoming content."
    - name: "closed_caption_detected_count"
      expr: COUNT(CASE WHEN closed_caption_detected_flag = TRUE THEN 1 END)
      comment: "Ingest events where closed captions were detected — measures accessibility compliance at source."
    - name: "audio_description_detected_count"
      expr: COUNT(CASE WHEN audio_description_detected_flag = TRUE THEN 1 END)
      comment: "Ingest events where audio description was detected — measures accessibility compliance at source."
    - name: "metadata_package_received_count"
      expr: COUNT(CASE WHEN metadata_package_received_flag = TRUE THEN 1 END)
      comment: "Ingest events with metadata package received — measures metadata completeness rate for catalogue quality."
    - name: "distinct_titles_ingested"
      expr: COUNT(DISTINCT title_id)
      comment: "Number of distinct titles ingested — measures breadth of content pipeline activity."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_lifecycle_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks content lifecycle transitions — measuring SLA adherence, transition velocity, and blocking conditions to optimise content operations and reduce time-to-air for new content."
  source: "`vibe_media_broadcasting_v1`.`content`.`lifecycle_event`"
  dimensions:
    - name: "qc_status"
      expr: qc_status_id
      comment: "FK to QC status reference — segments lifecycle events by quality control outcome."
    - name: "automated_flag"
      expr: automated_flag
      comment: "Boolean indicating automated transition — segments manual vs. automated workflow steps for efficiency analysis."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Boolean indicating SLA breach — identifies lifecycle stages with systemic delays."
    - name: "blocking_resolved_flag"
      expr: blocking_resolved_flag
      comment: "Boolean indicating blocking condition was resolved — tracks workflow unblocking rate."
    - name: "compliance_checkpoint_passed"
      expr: compliance_checkpoint_passed
      comment: "Boolean indicating compliance checkpoint passed — measures regulatory readiness at each lifecycle stage."
    - name: "rollback_flag"
      expr: rollback_flag
      comment: "Boolean indicating a rollback occurred — identifies quality or process failures requiring reversion."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Lifecycle stage label — segments events by production, post-production, QC, distribution, archive stages."
    - name: "transition_timestamp"
      expr: DATE_TRUNC('week', transition_timestamp)
      comment: "Week bucket of transition timestamp — supports weekly workflow throughput analysis."
  measures:
    - name: "total_lifecycle_events"
      expr: COUNT(1)
      comment: "Total lifecycle transition events — baseline measure of content operations workflow volume."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of lifecycle events that breached SLA — key operational KPI for content delivery performance."
    - name: "total_transition_duration_hours"
      expr: SUM(CAST(transition_duration_hours AS DOUBLE))
      comment: "Total hours spent in lifecycle transitions — measures cumulative workflow time for capacity planning."
    - name: "avg_transition_duration_hours"
      expr: AVG(CAST(transition_duration_hours AS DOUBLE))
      comment: "Average transition duration per lifecycle event — benchmarks workflow velocity and identifies bottlenecks."
    - name: "rollback_event_count"
      expr: COUNT(CASE WHEN rollback_flag = TRUE THEN 1 END)
      comment: "Number of lifecycle rollbacks — measures quality failure rate requiring reprocessing."
    - name: "compliance_checkpoint_passed_count"
      expr: COUNT(CASE WHEN compliance_checkpoint_passed = TRUE THEN 1 END)
      comment: "Lifecycle events that passed compliance checkpoints — measures regulatory readiness throughput."
    - name: "automated_transition_count"
      expr: COUNT(CASE WHEN automated_flag = TRUE THEN 1 END)
      comment: "Number of automated lifecycle transitions — measures workflow automation coverage and efficiency."
    - name: "blocking_condition_count"
      expr: COUNT(CASE WHEN blocking_resolved_flag = FALSE THEN 1 END)
      comment: "Number of lifecycle events with unresolved blocking conditions — measures current workflow bottleneck exposure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures content package portfolio economics — tracking package value, title counts, exclusivity, and DRM coverage to support distribution deal structuring and revenue optimisation."
  source: "`vibe_media_broadcasting_v1`.`content`.`package`"
  dimensions:
    - name: "package_type"
      expr: package_type_id
      comment: "FK to package type reference — segments by SVOD bundle, AVOD catalogue, syndication package, etc."
    - name: "package_status"
      expr: package_status_id
      comment: "FK to package status reference — filters active, expired, or draft packages."
    - name: "genre"
      expr: genre_id
      comment: "FK to genre — enables genre-level package portfolio analysis."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Boolean indicating exclusive package — segments premium exclusive distribution packages."
    - name: "drm_required_flag"
      expr: drm_required_flag
      comment: "Boolean indicating DRM is required — measures content protection coverage in distribution packages."
    - name: "hd_available_flag"
      expr: hd_available_flag
      comment: "Boolean indicating HD availability in package — segments premium quality packages."
    - name: "uhd_4k_available_flag"
      expr: uhd_4k_available_flag
      comment: "Boolean indicating 4K UHD availability in package — tracks premium format distribution."
    - name: "effective_date"
      expr: DATE_TRUNC('quarter', effective_date)
      comment: "Quarter bucket of package effective date — supports distribution pipeline planning."
    - name: "territory_scope"
      expr: territory_scope
      comment: "Territory scope of the package — enables geographic distribution analysis."
  measures:
    - name: "total_packages"
      expr: COUNT(1)
      comment: "Total content packages — baseline measure of distribution portfolio breadth."
    - name: "total_package_value_usd"
      expr: SUM(CAST(value_usd AS DOUBLE))
      comment: "Total value of content packages in USD — key revenue pipeline measure for distribution deals."
    - name: "avg_package_value_usd"
      expr: AVG(CAST(value_usd AS DOUBLE))
      comment: "Average package value in USD — benchmarks deal economics for distribution negotiations."
    - name: "total_runtime_hours"
      expr: SUM(CAST(total_runtime_hours AS DOUBLE))
      comment: "Total runtime hours across all packages — measures content volume available for distribution."
    - name: "avg_runtime_hours_per_package"
      expr: AVG(CAST(total_runtime_hours AS DOUBLE))
      comment: "Average runtime hours per package — benchmarks package depth for distribution deal structuring."
    - name: "exclusive_package_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END)
      comment: "Number of exclusive packages — measures premium exclusive distribution inventory."
    - name: "drm_required_package_count"
      expr: COUNT(CASE WHEN drm_required_flag = TRUE THEN 1 END)
      comment: "Number of packages requiring DRM — measures content protection infrastructure requirements."
    - name: "uhd_4k_package_count"
      expr: COUNT(CASE WHEN uhd_4k_available_flag = TRUE THEN 1 END)
      comment: "Number of packages with 4K UHD content — tracks premium format distribution portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_episode_transmission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures broadcast transmission performance — tracking live vs. repeat ratios, signal quality, viewer counts, and preemption rates to optimise linear broadcast scheduling and technical operations."
  source: "`vibe_media_broadcasting_v1`.`content`.`episode_transmission`"
  dimensions:
    - name: "transmission_status"
      expr: transmission_status_id
      comment: "FK to transmission status reference — segments by successful, failed, preempted, or delayed transmissions."
    - name: "live_flag"
      expr: live_flag
      comment: "Boolean indicating live transmission — segments live vs. pre-recorded broadcast events."
    - name: "repeat_flag"
      expr: repeat_flag
      comment: "Boolean indicating repeat transmission — distinguishes original vs. repeat broadcast inventory."
    - name: "preempted_flag"
      expr: preempted_flag
      comment: "Boolean indicating preemption — tracks schedule disruptions for advertiser makegood obligations."
    - name: "hd_flag"
      expr: hd_flag
      comment: "Boolean indicating HD transmission — measures HD broadcast coverage."
    - name: "closed_caption_flag"
      expr: closed_caption_flag
      comment: "Boolean indicating closed captions were transmitted — measures FCC accessibility compliance."
    - name: "blackout_override_flag"
      expr: blackout_override_flag
      comment: "Boolean indicating blackout override was applied — tracks rights blackout management."
    - name: "technical_issues_flag"
      expr: technical_issues_flag
      comment: "Boolean indicating technical issues during transmission — measures broadcast quality incidents."
    - name: "air_date"
      expr: DATE_TRUNC('week', air_date)
      comment: "Week bucket of air date — supports weekly broadcast performance trend analysis."
    - name: "market_code"
      expr: market_code
      comment: "Market code of transmission — enables geographic broadcast performance analysis."
  measures:
    - name: "total_transmissions"
      expr: COUNT(1)
      comment: "Total episode transmissions — baseline measure of broadcast schedule execution volume."
    - name: "total_viewer_count"
      expr: SUM(CAST(viewer_count AS DOUBLE))
      comment: "Total viewers across all transmissions — primary audience reach measure for programming decisions."
    - name: "avg_viewer_count"
      expr: AVG(CAST(viewer_count AS DOUBLE))
      comment: "Average viewers per transmission — benchmarks episode audience performance for scheduling optimisation."
    - name: "avg_signal_strength_dbm"
      expr: AVG(CAST(signal_strength_dbm AS DOUBLE))
      comment: "Average signal strength in dBm — measures broadcast technical quality for engineering SLA monitoring."
    - name: "live_transmission_count"
      expr: COUNT(CASE WHEN live_flag = TRUE THEN 1 END)
      comment: "Number of live transmissions — measures live programming volume in broadcast schedule."
    - name: "preempted_transmission_count"
      expr: COUNT(CASE WHEN preempted_flag = TRUE THEN 1 END)
      comment: "Number of preempted transmissions — quantifies schedule disruptions and advertiser makegood obligations."
    - name: "technical_issue_transmission_count"
      expr: COUNT(CASE WHEN technical_issues_flag = TRUE THEN 1 END)
      comment: "Number of transmissions with technical issues — measures broadcast quality failure rate."
    - name: "closed_caption_compliant_transmission_count"
      expr: COUNT(CASE WHEN closed_caption_flag = TRUE THEN 1 END)
      comment: "Number of transmissions with closed captions — measures FCC accessibility compliance in broadcast."
    - name: "distinct_channels_used"
      expr: COUNT(DISTINCT channel_id)
      comment: "Number of distinct channels used for transmission — measures broadcast distribution breadth."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_billing_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks content billing economics — measuring revenue per title, billing period performance, and unit consumption rates to support content monetisation reporting and finance reconciliation."
  source: "`vibe_media_broadcasting_v1`.`content`.`billing_line`"
  dimensions:
    - name: "line_status"
      expr: line_status_id
      comment: "FK to line status reference — segments billing lines by invoiced, paid, disputed, or cancelled status."
    - name: "license_window_type"
      expr: license_window_type_id
      comment: "FK to license window type — segments revenue by distribution window (SVOD, AVOD, linear, etc.)."
    - name: "territory_code"
      expr: territory_code_id
      comment: "FK to territory code — enables geographic revenue analysis."
    - name: "billing_period_start_date"
      expr: DATE_TRUNC('month', billing_period_start_date)
      comment: "Month bucket of billing period start — supports monthly revenue trend analysis."
    - name: "billing_period_end_date"
      expr: DATE_TRUNC('quarter', billing_period_end_date)
      comment: "Quarter bucket of billing period end — supports quarterly revenue reporting."
  measures:
    - name: "total_billed_amount"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Total billed amount across all content billing lines — primary revenue recognition measure."
    - name: "avg_billed_amount_per_line"
      expr: AVG(CAST(line_amount AS DOUBLE))
      comment: "Average billed amount per billing line — benchmarks deal economics and identifies outliers."
    - name: "total_units_consumed"
      expr: SUM(CAST(units_consumed AS DOUBLE))
      comment: "Total units consumed across billing lines — measures content consumption volume for usage-based billing."
    - name: "avg_rate_per_unit"
      expr: AVG(CAST(rate_per_unit AS DOUBLE))
      comment: "Average rate per unit across billing lines — benchmarks content pricing across distribution windows."
    - name: "total_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage across billing lines — measures blended revenue share economics."
    - name: "total_billing_lines"
      expr: COUNT(1)
      comment: "Total billing lines — baseline measure of billing activity volume."
    - name: "distinct_titles_billed"
      expr: COUNT(DISTINCT title_id)
      comment: "Number of distinct titles generating billing lines — measures monetised catalogue breadth."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_news_story`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks news story production pipeline — measuring editorial throughput, embargo management, correction rates, and publication velocity to support newsroom operations and editorial quality management."
  source: "`vibe_media_broadcasting_v1`.`content`.`news_story`"
  dimensions:
    - name: "story_status"
      expr: story_status
      comment: "Current story status (draft, filed, edited, published, etc.) — segments editorial pipeline stages."
    - name: "editorial_workflow_state"
      expr: editorial_workflow_state
      comment: "Current editorial workflow state — tracks stories through the editorial approval pipeline."
    - name: "embargo_flag"
      expr: embargo_flag
      comment: "Boolean indicating story is under embargo — measures embargoed content volume requiring release management."
    - name: "correction_flag"
      expr: correction_flag
      comment: "Boolean indicating story has a correction — measures editorial accuracy and correction rate."
    - name: "wire_source"
      expr: wire_source
      comment: "Wire service source (AP, AFP, Bloomberg, Reuters, etc.) — segments stories by origination source."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of the story — enables multilingual newsroom analysis."
    - name: "section"
      expr: section
      comment: "Editorial section (news, sports, business, entertainment, etc.) — segments by content category."
    - name: "published_at"
      expr: DATE_TRUNC('day', published_at)
      comment: "Day bucket of publication timestamp — supports daily editorial throughput analysis."
    - name: "filed_at"
      expr: DATE_TRUNC('week', filed_at)
      comment: "Week bucket of filing timestamp — supports weekly editorial pipeline volume analysis."
  measures:
    - name: "total_stories"
      expr: COUNT(1)
      comment: "Total news stories — baseline measure of newsroom editorial output volume."
    - name: "published_story_count"
      expr: COUNT(CASE WHEN published_at IS NOT NULL THEN 1 END)
      comment: "Number of published stories — measures editorial throughput and publication rate."
    - name: "embargoed_story_count"
      expr: COUNT(CASE WHEN embargo_flag = TRUE THEN 1 END)
      comment: "Number of stories currently under embargo — measures embargoed content pipeline requiring release management."
    - name: "correction_story_count"
      expr: COUNT(CASE WHEN correction_flag = TRUE THEN 1 END)
      comment: "Number of stories with corrections issued — measures editorial accuracy and quality failure rate."
    - name: "wire_sourced_story_count"
      expr: COUNT(CASE WHEN wire_source IS NOT NULL THEN 1 END)
      comment: "Number of stories sourced from wire services — measures reliance on external news feeds vs. original reporting."
    - name: "distinct_wire_sources"
      expr: COUNT(DISTINCT wire_source)
      comment: "Number of distinct wire services used — measures news source diversity for editorial independence analysis."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_sports_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks sports event catalogue and broadcast performance — measuring live event volume, blackout exposure, and scheduling coverage to support sports rights utilisation and broadcast operations."
  source: "`vibe_media_broadcasting_v1`.`content`.`sports_event`"
  dimensions:
    - name: "event_status"
      expr: event_status
      comment: "Current event status (scheduled, live, completed, postponed, cancelled) — segments sports event pipeline."
    - name: "sport_type"
      expr: sport_type
      comment: "Sport type (NFL, NBA, UEFA, etc.) — enables sport-level rights and audience analysis."
    - name: "is_live_flag"
      expr: is_live_flag
      comment: "Boolean indicating live event — segments live vs. tape-delayed sports broadcasts."
    - name: "blackout_flag"
      expr: blackout_flag
      comment: "Boolean indicating blackout restriction — measures rights blackout exposure in sports schedule."
    - name: "event_date"
      expr: DATE_TRUNC('month', event_date)
      comment: "Month bucket of event date — supports monthly sports schedule volume analysis."
    - name: "venue_country"
      expr: venue_country
      comment: "Country of event venue — enables geographic sports rights and broadcast analysis."
    - name: "season_label"
      expr: season_label
      comment: "Season label (e.g. 2024-25) — segments events by sports season for rights utilisation analysis."
  measures:
    - name: "total_sports_events"
      expr: COUNT(1)
      comment: "Total sports events in catalogue — baseline measure of sports rights portfolio breadth."
    - name: "live_event_count"
      expr: COUNT(CASE WHEN is_live_flag = TRUE THEN 1 END)
      comment: "Number of live sports events — measures live rights utilisation, a key driver of subscriber acquisition."
    - name: "blacked_out_event_count"
      expr: COUNT(CASE WHEN blackout_flag = TRUE THEN 1 END)
      comment: "Number of events subject to blackout restrictions — quantifies rights blackout exposure in sports schedule."
    - name: "completed_event_count"
      expr: COUNT(CASE WHEN event_status = 'completed' THEN 1 END)
      comment: "Number of completed sports events — measures rights utilisation against contracted event volumes."
    - name: "distinct_competitions"
      expr: COUNT(DISTINCT sports_competition_id)
      comment: "Number of distinct sports competitions covered — measures breadth of sports rights portfolio."
    - name: "distinct_sports_teams"
      expr: COUNT(DISTINCT sports_team_id)
      comment: "Number of distinct sports teams featured — measures team coverage depth in sports rights portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_composition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks music composition catalogue economics — measuring mechanical royalty rates, publisher share structures, and public domain status to support music rights management and royalty obligation planning."
  source: "`vibe_media_broadcasting_v1`.`content`.`composition`"
  dimensions:
    - name: "composition_status"
      expr: composition_status
      comment: "Current composition status (registered, pending, disputed, etc.) — segments catalogue by rights status."
    - name: "is_public_domain_flag"
      expr: is_public_domain_flag
      comment: "Boolean indicating public domain status — segments royalty-free vs. licensed compositions."
    - name: "pro_affiliation"
      expr: pro_affiliation
      comment: "Performing rights organisation affiliation (ASCAP, BMI, SESAC, PRS, etc.) — segments by PRO for royalty reporting."
    - name: "language"
      expr: language
      comment: "Language of the composition — enables multilingual catalogue analysis."
    - name: "first_publication_date"
      expr: DATE_TRUNC('year', first_publication_date)
      comment: "Year bucket of first publication date — supports vintage analysis for public domain eligibility tracking."
  measures:
    - name: "total_compositions"
      expr: COUNT(1)
      comment: "Total compositions in catalogue — baseline measure of music rights portfolio breadth."
    - name: "public_domain_composition_count"
      expr: COUNT(CASE WHEN is_public_domain_flag = TRUE THEN 1 END)
      comment: "Number of public domain compositions — measures royalty-free music available for use without licensing cost."
    - name: "licensed_composition_count"
      expr: COUNT(CASE WHEN is_public_domain_flag = FALSE THEN 1 END)
      comment: "Number of licensed compositions requiring royalty payments — quantifies music licensing obligation scope."
    - name: "avg_mechanical_royalty_rate"
      expr: AVG(CAST(mechanical_royalty_rate AS DOUBLE))
      comment: "Average mechanical royalty rate across compositions — benchmarks music licensing cost for budget planning."
    - name: "avg_publisher_share_pct"
      expr: AVG(CAST(publisher_share_pct AS DOUBLE))
      comment: "Average publisher share percentage — measures publisher economics in music rights portfolio."
    - name: "avg_writer_share_pct"
      expr: AVG(CAST(writer_share_pct AS DOUBLE))
      comment: "Average writer share percentage — measures writer economics and residuals obligation in music catalogue."
    - name: "distinct_pro_affiliations"
      expr: COUNT(DISTINCT pro_affiliation)
      comment: "Number of distinct PRO affiliations in catalogue — measures PRO reporting complexity and royalty distribution scope."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`content_content_clearance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors content clearance pipeline — tracking clearance rates, fee commitments, SLA adherence, and escalation rates to ensure rights-cleared content is available for broadcast and distribution on schedule."
  source: "`vibe_media_broadcasting_v1`.`content`.`content_clearance`"
  dimensions:
    - name: "clearance_status"
      expr: clearance_status_id
      comment: "FK to clearance status reference — segments by cleared, pending, blocked, or expired status."
    - name: "clearance_type"
      expr: clearance_type_id
      comment: "FK to clearance type reference — segments by music, talent, location, archive, or third-party clearance."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Boolean indicating escalation — identifies clearances requiring senior intervention."
    - name: "broadcast_ready_flag"
      expr: broadcast_ready_flag
      comment: "Boolean indicating broadcast readiness — measures clearances that have completed the full approval chain."
    - name: "legal_review_required_flag"
      expr: legal_review_required_flag
      comment: "Boolean indicating legal review is required — segments high-complexity clearances."
    - name: "clearance_date"
      expr: DATE_TRUNC('month', clearance_date)
      comment: "Month bucket of clearance date — supports monthly clearance throughput analysis."
    - name: "request_date"
      expr: DATE_TRUNC('month', request_date)
      comment: "Month bucket of clearance request date — supports pipeline intake volume analysis."
    - name: "intended_platform"
      expr: intended_platform
      comment: "Intended distribution platform — segments clearances by linear, OTT, SVOD, etc."
  measures:
    - name: "total_clearance_requests"
      expr: COUNT(1)
      comment: "Total content clearance requests — baseline measure of rights clearance pipeline volume."
    - name: "broadcast_ready_count"
      expr: COUNT(CASE WHEN broadcast_ready_flag = TRUE THEN 1 END)
      comment: "Number of clearances that are broadcast-ready — measures rights-cleared content available for air."
    - name: "escalated_clearance_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of escalated clearances — measures high-complexity rights issues requiring senior resolution."
    - name: "legal_review_required_count"
      expr: COUNT(CASE WHEN legal_review_required_flag = TRUE THEN 1 END)
      comment: "Number of clearances requiring legal review — quantifies legal resource demand in rights pipeline."
    - name: "total_clearance_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total clearance fees committed — measures rights acquisition cost for cleared content."
    - name: "avg_clearance_fee_amount"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average clearance fee per request — benchmarks rights clearance cost for budget planning."
    - name: "distinct_titles_in_clearance"
      expr: COUNT(DISTINCT title_id)
      comment: "Number of distinct titles with active clearance requests — measures breadth of rights pipeline activity."
$$;