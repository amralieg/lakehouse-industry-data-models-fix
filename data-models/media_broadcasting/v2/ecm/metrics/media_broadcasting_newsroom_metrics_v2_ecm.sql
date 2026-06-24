-- Metric views for domain: newsroom | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-22 23:42:33

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`newsroom_news_story`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the news story master entity. Tracks story volume, publishing velocity, breaking-news intensity, kill rates, and content mix — the core editorial performance dashboard for news directors and VP-level leadership."
  source: "`vibe_media_broadcasting_v1`.`newsroom`.`newsroom_news_story`"
  dimensions:
    - name: "story_type"
      expr: story_type
      comment: "Type of news story (e.g. breaking, feature, analysis, wire) — primary editorial classification for audience and resource planning."
    - name: "content_category"
      expr: content_category
      comment: "Editorial content category (e.g. politics, sports, business, entertainment) — used to track category mix and resource allocation."
    - name: "editorial_desk"
      expr: editorial_desk
      comment: "Originating editorial desk (e.g. national, international, investigative) — key dimension for desk-level productivity reporting."
    - name: "story_status"
      expr: story_status
      comment: "Current lifecycle status of the story (draft, filed, published, killed) — drives pipeline health monitoring."
    - name: "priority_level"
      expr: priority_level
      comment: "Editorial priority assigned to the story (urgent, high, normal, low) — used to assess resource alignment with priority."
    - name: "language_code"
      expr: language_code
      comment: "Language of the story — supports multilingual content mix analysis."
    - name: "wire_source"
      expr: wire_source
      comment: "Wire service originating the story (AP, AFP, Bloomberg, Reuters) — tracks wire dependency vs. original reporting ratio."
    - name: "geographic_focus"
      expr: geographic_focus
      comment: "Geographic scope of the story (local, regional, national, international) — informs coverage balance decisions."
    - name: "is_breaking"
      expr: is_breaking
      comment: "Flag indicating whether the story was classified as breaking news — used to segment breaking vs. planned content KPIs."
    - name: "publish_month"
      expr: DATE_TRUNC('MONTH', publish_datetime)
      comment: "Month of story publication — enables trend analysis of publishing volume over time."
    - name: "publish_week"
      expr: DATE_TRUNC('WEEK', publish_datetime)
      comment: "Week of story publication — supports weekly editorial cadence reporting."
    - name: "has_video_flag"
      expr: has_video_flag
      comment: "Whether the story includes video content — used to track multimedia enrichment rate."
    - name: "has_audio_flag"
      expr: has_audio_flag
      comment: "Whether the story includes audio content — supports audio/podcast content mix analysis."
    - name: "killed_flag"
      expr: killed_flag
      comment: "Whether the story was killed before publication — key quality and editorial decision metric."
  measures:
    - name: "total_stories_published"
      expr: COUNT(CASE WHEN story_status = 'published' THEN newsroom_news_story_id END)
      comment: "Total number of stories successfully published. Core editorial throughput KPI — executives use this to assess newsroom output capacity and publishing velocity."
    - name: "total_stories_filed"
      expr: COUNT(CASE WHEN story_status IN ('filed', 'published') THEN newsroom_news_story_id END)
      comment: "Total stories filed (including published) — measures reporter productivity and pipeline fill rate upstream of publication."
    - name: "total_breaking_news_stories"
      expr: COUNT(CASE WHEN is_breaking = TRUE THEN newsroom_news_story_id END)
      comment: "Count of stories classified as breaking news. Tracks breaking-news intensity and the proportion of reactive vs. planned editorial output."
    - name: "total_killed_stories"
      expr: COUNT(CASE WHEN killed_flag = TRUE THEN newsroom_news_story_id END)
      comment: "Total stories killed before publication. High kill rates signal editorial quality issues, resource waste, or legal/compliance friction — a key editorial risk KPI."
    - name: "kill_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN killed_flag = TRUE THEN newsroom_news_story_id END) / NULLIF(COUNT(newsroom_news_story_id), 0), 2)
      comment: "Percentage of all stories that were killed before publication. A rising kill rate indicates editorial pipeline inefficiency or quality control issues requiring leadership intervention."
    - name: "wire_story_count"
      expr: COUNT(CASE WHEN wire_source IS NOT NULL AND wire_source <> '' THEN newsroom_news_story_id END)
      comment: "Count of stories sourced from wire services. Tracks wire dependency — a high ratio may indicate under-investment in original reporting."
    - name: "original_story_count"
      expr: COUNT(CASE WHEN (wire_source IS NULL OR wire_source = '') AND story_status = 'published' THEN newsroom_news_story_id END)
      comment: "Count of originally reported (non-wire) published stories. Original content is a key differentiator and brand value driver for news organisations."
    - name: "wire_dependency_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN wire_source IS NOT NULL AND wire_source <> '' THEN newsroom_news_story_id END) / NULLIF(COUNT(CASE WHEN story_status = 'published' THEN newsroom_news_story_id END), 0), 2)
      comment: "Percentage of published stories sourced from wire services vs. original reporting. Executives use this to evaluate editorial independence and content investment strategy."
    - name: "multimedia_story_count"
      expr: COUNT(CASE WHEN has_video_flag = TRUE OR has_audio_flag = TRUE THEN newsroom_news_story_id END)
      comment: "Count of stories enriched with video or audio. Multimedia enrichment drives audience engagement and digital platform performance — a strategic content investment KPI."
    - name: "multimedia_enrichment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN has_video_flag = TRUE OR has_audio_flag = TRUE THEN newsroom_news_story_id END) / NULLIF(COUNT(CASE WHEN story_status = 'published' THEN newsroom_news_story_id END), 0), 2)
      comment: "Percentage of published stories that include video or audio. A key digital strategy KPI — low enrichment rates correlate with reduced audience engagement on OTT and social platforms."
    - name: "distinct_editorial_desks_active"
      expr: COUNT(DISTINCT editorial_desk)
      comment: "Number of distinct editorial desks contributing published stories. Tracks breadth of newsroom coverage and identifies desks that may be under-resourced or inactive."
    - name: "distinct_content_categories_covered"
      expr: COUNT(DISTINCT content_category)
      comment: "Number of distinct content categories covered in published stories. Measures editorial breadth — a narrow category spread may indicate coverage gaps vs. audience demand."
    - name: "embargoed_story_count"
      expr: COUNT(CASE WHEN embargo_datetime IS NOT NULL THEN newsroom_news_story_id END)
      comment: "Count of stories with an active embargo. Tracks the volume of time-sensitive content under embargo management — important for legal and editorial compliance oversight."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`newsroom_editorial_workflow_state`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Editorial pipeline efficiency and SLA compliance metrics. Tracks story throughput by workflow state, SLA breach rates, legal review bottlenecks, and desk-level pipeline health — the primary operational dashboard for managing editors and editorial operations leadership."
  source: "`vibe_media_broadcasting_v1`.`newsroom`.`newsroom_editorial_workflow_state`"
  dimensions:
    - name: "state_name"
      expr: state_name
      comment: "Current workflow state of the story (draft, assigned, filed, edited, cleared, published) — the primary pipeline stage dimension."
    - name: "editorial_desk"
      expr: editorial_desk
      comment: "Editorial desk owning the story at this workflow state — enables desk-level pipeline and SLA performance comparison."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the story at this state — used to assess whether high-priority stories are receiving appropriate throughput."
    - name: "target_publication_channel"
      expr: target_publication_channel
      comment: "Intended publication channel (linear, OTT, digital, social) — enables channel-specific pipeline performance analysis."
    - name: "is_current_state"
      expr: is_current_state
      comment: "Whether this record represents the current active state of the story — used to filter to live pipeline snapshots."
    - name: "is_sla_breached"
      expr: is_sla_breached
      comment: "Whether the SLA target for this workflow state was breached — the primary SLA compliance flag for editorial operations."
    - name: "legal_review_required_flag"
      expr: legal_review_required_flag
      comment: "Whether legal review was required at this state — used to track legal review volume and its impact on throughput."
    - name: "legal_review_completed_flag"
      expr: legal_review_completed_flag
      comment: "Whether legal review was completed — used to identify stories blocked in legal review."
    - name: "approval_authority"
      expr: approval_authority
      comment: "Role or individual responsible for approving the story at this state — identifies approval bottlenecks."
    - name: "entered_month"
      expr: DATE_TRUNC('MONTH', entered_at)
      comment: "Month the story entered this workflow state — enables trend analysis of pipeline throughput over time."
    - name: "entered_week"
      expr: DATE_TRUNC('WEEK', entered_at)
      comment: "Week the story entered this workflow state — supports weekly editorial operations cadence reporting."
  measures:
    - name: "total_workflow_state_transitions"
      expr: COUNT(newsroom_editorial_workflow_state_id)
      comment: "Total number of workflow state transitions recorded. Measures overall editorial pipeline activity volume — a baseline throughput indicator for editorial operations."
    - name: "total_sla_breaches"
      expr: COUNT(CASE WHEN is_sla_breached = TRUE THEN newsroom_editorial_workflow_state_id END)
      comment: "Total number of workflow states where the SLA target was breached. A critical editorial operations KPI — high breach counts indicate systemic pipeline bottlenecks requiring management intervention."
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_sla_breached = TRUE THEN newsroom_editorial_workflow_state_id END) / NULLIF(COUNT(newsroom_editorial_workflow_state_id), 0), 2)
      comment: "Percentage of workflow state transitions that breached their SLA target. The primary editorial pipeline health KPI — executives use this to assess whether the newsroom can meet publication deadlines reliably."
    - name: "legal_review_required_count"
      expr: COUNT(CASE WHEN legal_review_required_flag = TRUE THEN newsroom_editorial_workflow_state_id END)
      comment: "Count of workflow states requiring legal review. Tracks legal review volume — high counts may indicate editorial risk exposure or over-cautious legal escalation patterns."
    - name: "legal_review_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN legal_review_completed_flag = TRUE THEN newsroom_editorial_workflow_state_id END) / NULLIF(COUNT(CASE WHEN legal_review_required_flag = TRUE THEN newsroom_editorial_workflow_state_id END), 0), 2)
      comment: "Percentage of stories requiring legal review where review was completed. A low rate signals a legal review bottleneck that is blocking publication — a key editorial risk and compliance KPI."
    - name: "stories_currently_in_pipeline"
      expr: COUNT(CASE WHEN is_current_state = TRUE THEN newsroom_editorial_workflow_state_id END)
      comment: "Count of stories currently active in the editorial pipeline (at their current state). Measures live pipeline depth — used by managing editors to assess workload and capacity."
    - name: "high_priority_sla_breaches"
      expr: COUNT(CASE WHEN is_sla_breached = TRUE AND priority_level IN ('urgent', 'high') THEN newsroom_editorial_workflow_state_id END)
      comment: "SLA breaches specifically on high-priority or urgent stories. Executives treat this as a critical failure indicator — breaking news and urgent stories must not miss SLA targets."
    - name: "distinct_desks_with_sla_breaches"
      expr: COUNT(DISTINCT CASE WHEN is_sla_breached = TRUE THEN editorial_desk END)
      comment: "Number of distinct editorial desks experiencing SLA breaches. Identifies which desks are systematically underperforming — used to target resource reallocation or process improvement."
    - name: "embargoed_stories_in_pipeline"
      expr: COUNT(CASE WHEN embargo_until_timestamp IS NOT NULL AND is_current_state = TRUE THEN newsroom_editorial_workflow_state_id END)
      comment: "Count of currently active pipeline stories under embargo. Tracks embargo management burden — important for editorial compliance and publication timing risk."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`newsroom_correction_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Editorial accuracy, regulatory compliance, and correction management KPIs. Tracks correction volume, on-air correction rates, regulatory mandate compliance, and legal review throughput — a critical dashboard for editorial standards, compliance officers, and broadcast regulators."
  source: "`vibe_media_broadcasting_v1`.`newsroom`.`newsroom_correction_record`"
  dimensions:
    - name: "correction_type"
      expr: correction_type
      comment: "Type of correction (factual, retraction, clarification, editor's note, FCC/Ofcom-mandated) — primary classification for editorial standards reporting."
    - name: "correction_status"
      expr: correction_status
      comment: "Current status of the correction (pending, issued, broadcast, closed) — tracks correction lifecycle completion."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the correction (critical, major, minor) — used to prioritise editorial response and escalation."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body mandating the correction (FCC, Ofcom, CRTC) — enables regulator-specific compliance reporting."
    - name: "regulatory_mandate_flag"
      expr: regulatory_mandate_flag
      comment: "Whether the correction was mandated by a regulatory body — the primary flag for regulatory compliance tracking."
    - name: "on_air_correction_flag"
      expr: on_air_correction_flag
      comment: "Whether the correction required an on-air broadcast — tracks the most visible and reputationally significant corrections."
    - name: "legal_review_flag"
      expr: legal_review_flag
      comment: "Whether the correction required legal review — used to track legal exposure from editorial errors."
    - name: "public_acknowledgment_flag"
      expr: public_acknowledgment_flag
      comment: "Whether the correction required a public acknowledgment — tracks reputational risk events."
    - name: "issued_month"
      expr: DATE_TRUNC('MONTH', issued_datetime)
      comment: "Month the correction was issued — enables trend analysis of correction frequency over time."
    - name: "issued_week"
      expr: DATE_TRUNC('WEEK', issued_datetime)
      comment: "Week the correction was issued — supports weekly editorial quality monitoring."
    - name: "affected_section"
      expr: affected_section
      comment: "Section of the story affected by the correction — identifies which content areas generate the most errors."
  measures:
    - name: "total_corrections_issued"
      expr: COUNT(newsroom_correction_record_id)
      comment: "Total number of corrections issued. The primary editorial accuracy KPI — a rising correction count signals systemic quality issues requiring editorial leadership intervention."
    - name: "regulatory_mandated_corrections"
      expr: COUNT(CASE WHEN regulatory_mandate_flag = TRUE THEN newsroom_correction_record_id END)
      comment: "Count of corrections mandated by a regulatory body (FCC, Ofcom). Regulatory corrections carry legal and licence risk — executives must track these as a compliance obligation."
    - name: "regulatory_mandate_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_mandate_flag = TRUE THEN newsroom_correction_record_id END) / NULLIF(COUNT(newsroom_correction_record_id), 0), 2)
      comment: "Percentage of all corrections that were regulatory mandates. A high rate indicates systemic compliance failures that could threaten broadcast licences."
    - name: "on_air_corrections_count"
      expr: COUNT(CASE WHEN on_air_correction_flag = TRUE THEN newsroom_correction_record_id END)
      comment: "Count of corrections requiring on-air broadcast. On-air corrections are the most reputationally damaging — executives track this as a brand risk KPI."
    - name: "on_air_correction_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN on_air_correction_flag = TRUE THEN newsroom_correction_record_id END) / NULLIF(COUNT(newsroom_correction_record_id), 0), 2)
      comment: "Percentage of corrections requiring on-air broadcast. A rising rate signals deteriorating editorial quality with direct audience and regulatory visibility."
    - name: "critical_corrections_count"
      expr: COUNT(CASE WHEN severity_level = 'critical' THEN newsroom_correction_record_id END)
      comment: "Count of corrections classified as critical severity. Critical corrections represent the highest editorial and legal risk — a non-zero count triggers immediate executive review."
    - name: "legal_review_required_corrections"
      expr: COUNT(CASE WHEN legal_review_flag = TRUE THEN newsroom_correction_record_id END)
      comment: "Count of corrections requiring legal review. Tracks legal exposure from editorial errors — used by General Counsel and editorial leadership to assess litigation risk."
    - name: "public_acknowledgment_corrections"
      expr: COUNT(CASE WHEN public_acknowledgment_flag = TRUE THEN newsroom_correction_record_id END)
      comment: "Count of corrections requiring public acknowledgment. Public acknowledgments carry significant reputational risk and are tracked at board level for brand integrity reporting."
    - name: "distinct_regulatory_bodies_involved"
      expr: COUNT(DISTINCT regulatory_body)
      comment: "Number of distinct regulatory bodies involved in mandated corrections. Multiple regulators involved simultaneously signals a systemic compliance crisis requiring executive escalation."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`newsroom_wire_ingest`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wire service ingest pipeline performance and editorial routing KPIs. Tracks ingest volume, processing throughput, kill notice rates, correction rates, and wire service dependency — used by editorial operations and technology leadership to manage wire feed reliability and editorial workflow efficiency."
  source: "`vibe_media_broadcasting_v1`.`newsroom`.`newsroom_wire_ingest`"
  dimensions:
    - name: "wire_service_name"
      expr: wire_service_name
      comment: "Name of the wire service (AP, AFP, Bloomberg, Reuters) — primary dimension for wire service performance comparison."
    - name: "wire_service_code"
      expr: wire_service_code
      comment: "Standardised code for the wire service — used for system-level wire feed monitoring."
    - name: "wire_category"
      expr: wire_category
      comment: "Editorial category of the wire story (politics, business, sports, entertainment) — tracks category mix from each wire service."
    - name: "wire_priority"
      expr: wire_priority
      comment: "Priority level assigned by the wire service (urgent, bulletin, regular) — used to assess high-priority ingest throughput."
    - name: "processing_status"
      expr: processing_status
      comment: "Current processing status of the ingested wire item (pending, routed, published, killed, rejected) — primary pipeline health dimension."
    - name: "language_code"
      expr: language_code
      comment: "Language of the wire story — supports multilingual ingest volume analysis."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the wire story — tracks regional coverage balance from wire feeds."
    - name: "auto_routed_to_desk"
      expr: auto_routed_to_desk
      comment: "Editorial desk the wire story was automatically routed to — measures auto-routing effectiveness and desk-level wire intake."
    - name: "is_correction_flag"
      expr: is_correction_flag
      comment: "Whether the wire item is a correction to a previously ingested story — tracks wire correction volume."
    - name: "is_kill_notice_flag"
      expr: is_kill_notice_flag
      comment: "Whether the wire item is a kill notice — tracks retracted wire content that must be removed from editorial pipeline."
    - name: "has_media_attachment_flag"
      expr: has_media_attachment_flag
      comment: "Whether the wire item includes media attachments (photos, video) — tracks multimedia-enriched wire ingest volume."
    - name: "subscription_tier"
      expr: subscription_tier
      comment: "Wire service subscription tier (premium, standard, basic) — used to assess ROI of wire service subscription spend."
    - name: "ingested_month"
      expr: DATE_TRUNC('MONTH', ingested_at)
      comment: "Month of wire story ingest — enables trend analysis of wire ingest volume over time."
    - name: "ingested_week"
      expr: DATE_TRUNC('WEEK', ingested_at)
      comment: "Week of wire story ingest — supports weekly wire feed performance monitoring."
    - name: "media_type"
      expr: media_type
      comment: "Type of media attached to the wire story (photo, video, audio, graphic) — tracks multimedia content mix from wire feeds."
  measures:
    - name: "total_wire_items_ingested"
      expr: COUNT(newsroom_wire_ingest_id)
      comment: "Total number of wire items ingested. Baseline wire feed volume KPI — used to monitor wire service activity levels and detect feed outages or anomalies."
    - name: "total_kill_notices"
      expr: COUNT(CASE WHEN is_kill_notice_flag = TRUE THEN newsroom_wire_ingest_id END)
      comment: "Total wire kill notices received. Kill notices require immediate editorial action to retract published content — a high count signals wire service quality issues or breaking story volatility."
    - name: "kill_notice_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_kill_notice_flag = TRUE THEN newsroom_wire_ingest_id END) / NULLIF(COUNT(newsroom_wire_ingest_id), 0), 2)
      comment: "Percentage of wire items that are kill notices. A high kill rate from a specific wire service indicates reliability issues that may warrant subscription review."
    - name: "wire_correction_count"
      expr: COUNT(CASE WHEN is_correction_flag = TRUE THEN newsroom_wire_ingest_id END)
      comment: "Count of wire items that are corrections to previously ingested stories. Tracks wire service accuracy — high correction rates from a service indicate quality concerns."
    - name: "wire_correction_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_correction_flag = TRUE THEN newsroom_wire_ingest_id END) / NULLIF(COUNT(newsroom_wire_ingest_id), 0), 2)
      comment: "Percentage of wire items that are corrections. Used to compare accuracy across wire services and inform subscription and sourcing decisions."
    - name: "multimedia_wire_items_count"
      expr: COUNT(CASE WHEN has_media_attachment_flag = TRUE THEN newsroom_wire_ingest_id END)
      comment: "Count of wire items with media attachments. Multimedia-enriched wire content has higher editorial value — tracks the proportion of wire feed that can be used for digital/OTT publishing."
    - name: "multimedia_wire_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN has_media_attachment_flag = TRUE THEN newsroom_wire_ingest_id END) / NULLIF(COUNT(newsroom_wire_ingest_id), 0), 2)
      comment: "Percentage of wire items that include media attachments. A key wire service value metric — higher multimedia rates justify premium subscription tiers."
    - name: "embargoed_wire_items_count"
      expr: COUNT(CASE WHEN embargo_until_timestamp IS NOT NULL THEN newsroom_wire_ingest_id END)
      comment: "Count of wire items received under embargo. Tracks embargo management burden from wire feeds — important for editorial compliance and publication timing risk."
    - name: "distinct_wire_services_active"
      expr: COUNT(DISTINCT wire_service_code)
      comment: "Number of distinct wire services actively delivering content. Tracks wire service portfolio breadth — used to assess coverage redundancy and single-source dependency risk."
    - name: "urgent_wire_items_count"
      expr: COUNT(CASE WHEN wire_priority = 'urgent' THEN newsroom_wire_ingest_id END)
      comment: "Count of wire items flagged as urgent priority. Urgent wire items require immediate editorial triage — volume spikes indicate breaking news events requiring newsroom resource reallocation."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`newsroom_breaking_news_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Breaking news event management and broadcast impact KPIs. Tracks breaking event volume, severity distribution, resolution rates, national vs. local scope, and pre-emption impact — used by news directors, programming leadership, and operations to manage breaking news response capability."
  source: "`vibe_media_broadcasting_v1`.`newsroom`.`newsroom_breaking_news_event`"
  dimensions:
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the breaking news event (critical, major, moderate, minor) — primary triage dimension for resource allocation."
    - name: "breaking_news_event_status"
      expr: newsroom_breaking_news_event_status
      comment: "Current status of the breaking news event (active, resolved, cancelled) — tracks live vs. resolved event pipeline."
    - name: "trigger_source"
      expr: trigger_source
      comment: "Source that triggered the breaking news event (wire, social, scanner, editorial) — used to assess detection channel effectiveness."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the event (local, regional, national, international) — used to assess coverage resource requirements."
    - name: "is_national"
      expr: is_national
      comment: "Whether the event is classified as national scope — used to segment national vs. local breaking news KPIs."
    - name: "triggered_month"
      expr: DATE_TRUNC('MONTH', triggered_at)
      comment: "Month the breaking news event was triggered — enables trend analysis of breaking news frequency over time."
    - name: "triggered_week"
      expr: DATE_TRUNC('WEEK', triggered_at)
      comment: "Week the breaking news event was triggered — supports weekly breaking news cadence reporting."
    - name: "source_code"
      expr: source_code
      comment: "Source system code for the breaking news event record — used for data lineage and system-level monitoring."
  measures:
    - name: "total_breaking_news_events"
      expr: COUNT(newsroom_breaking_news_event_id)
      comment: "Total number of breaking news events triggered. Baseline breaking news activity KPI — used to assess newsroom reactive capacity and breaking news frequency trends."
    - name: "active_breaking_news_events"
      expr: COUNT(CASE WHEN newsroom_breaking_news_event_status = 'active' THEN newsroom_breaking_news_event_id END)
      comment: "Count of currently active breaking news events. Real-time operational KPI — executives use this to assess live newsroom load and resource deployment."
    - name: "resolved_breaking_news_events"
      expr: COUNT(CASE WHEN newsroom_breaking_news_event_status = 'resolved' THEN newsroom_breaking_news_event_id END)
      comment: "Count of breaking news events successfully resolved. Tracks newsroom resolution throughput — used alongside active count to assess pipeline clearance rate."
    - name: "resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN newsroom_breaking_news_event_status = 'resolved' THEN newsroom_breaking_news_event_id END) / NULLIF(COUNT(newsroom_breaking_news_event_id), 0), 2)
      comment: "Percentage of breaking news events that have been resolved. A low resolution rate indicates events are lingering in active status — a newsroom operational efficiency concern."
    - name: "critical_breaking_events_count"
      expr: COUNT(CASE WHEN severity_level = 'critical' THEN newsroom_breaking_news_event_id END)
      comment: "Count of breaking news events at critical severity. Critical events require maximum resource deployment and executive awareness — tracked as a top-tier operational risk KPI."
    - name: "national_breaking_events_count"
      expr: COUNT(CASE WHEN is_national = TRUE THEN newsroom_breaking_news_event_id END)
      comment: "Count of breaking news events classified as national scope. National events drive the highest audience impact and advertising pre-emption costs — a key programming and revenue risk KPI."
    - name: "national_event_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_national = TRUE THEN newsroom_breaking_news_event_id END) / NULLIF(COUNT(newsroom_breaking_news_event_id), 0), 2)
      comment: "Percentage of breaking news events that are national in scope. Tracks the proportion of high-impact events — used to calibrate national breaking news response capacity."
    - name: "events_with_program_preemption"
      expr: COUNT(CASE WHEN pre_empted_program_schedule_id IS NOT NULL THEN newsroom_breaking_news_event_id END)
      comment: "Count of breaking news events that caused a scheduled program to be pre-empted. Program pre-emptions have direct advertising revenue impact — a critical KPI for programming and sales leadership."
    - name: "program_preemption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pre_empted_program_schedule_id IS NOT NULL THEN newsroom_breaking_news_event_id END) / NULLIF(COUNT(newsroom_breaking_news_event_id), 0), 2)
      comment: "Percentage of breaking news events that resulted in program pre-emption. High pre-emption rates directly reduce ad revenue and require make-good commitments — a key sales and programming risk metric."
    - name: "distinct_trigger_sources"
      expr: COUNT(DISTINCT trigger_source)
      comment: "Number of distinct trigger sources generating breaking news events. Tracks detection channel diversity — over-reliance on a single trigger source creates breaking news detection risk."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`newsroom_byline_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reporter productivity, contributor diversity, and byline attribution KPIs. Tracks byline volume by contributor role, primary vs. secondary credit distribution, anonymous reporting rates, and wire vs. staff contributor mix — used by editorial leadership for talent management, diversity reporting, and contributor performance evaluation."
  source: "`vibe_media_broadcasting_v1`.`newsroom`.`newsroom_byline_credit`"
  dimensions:
    - name: "contributor_role"
      expr: contributor_role
      comment: "Role of the contributor (reporter, photographer, editor, producer, wire) — primary dimension for contributor type analysis."
    - name: "credit_type"
      expr: credit_type
      comment: "Type of byline credit (byline, photo credit, contributing, wire attribution) — used to classify credit attribution patterns."
    - name: "contributor_affiliation"
      expr: contributor_affiliation
      comment: "Affiliation of the contributor (staff, freelance, wire service, stringer) — tracks staff vs. freelance contributor mix."
    - name: "is_primary_byline"
      expr: is_primary_byline
      comment: "Whether this is the primary byline for the story — used to segment lead reporter attribution from secondary credits."
    - name: "is_anonymous_flag"
      expr: is_anonymous_flag
      comment: "Whether the byline is anonymous — tracks anonymous sourcing rates, which carry editorial and legal risk."
    - name: "wire_source_code"
      expr: wire_source_code
      comment: "Wire service code for wire-attributed bylines — used to track wire vs. original staff byline mix."
    - name: "credit_month"
      expr: DATE_TRUNC('MONTH', created_at)
      comment: "Month the byline credit was created — enables trend analysis of contributor activity over time."
    - name: "credit_week"
      expr: DATE_TRUNC('WEEK', created_at)
      comment: "Week the byline credit was created — supports weekly contributor productivity reporting."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from_date)
      comment: "Month the byline credit became effective — used for contributor tenure and activity period analysis."
  measures:
    - name: "total_byline_credits"
      expr: COUNT(newsroom_byline_credit_id)
      comment: "Total number of byline credits issued. Baseline contributor activity KPI — used to track overall newsroom contributor engagement and story attribution volume."
    - name: "distinct_contributors_credited"
      expr: COUNT(DISTINCT contributor_employee_id)
      comment: "Number of distinct contributors receiving byline credits. Measures contributor breadth — a narrow contributor base indicates over-reliance on a small number of reporters, a talent risk."
    - name: "primary_byline_count"
      expr: COUNT(CASE WHEN is_primary_byline = TRUE THEN newsroom_byline_credit_id END)
      comment: "Count of primary byline credits. Tracks lead reporter attribution volume — used to measure individual reporter productivity and story ownership."
    - name: "anonymous_byline_count"
      expr: COUNT(CASE WHEN is_anonymous_flag = TRUE THEN newsroom_byline_credit_id END)
      comment: "Count of anonymous byline credits. Anonymous bylines carry editorial credibility and legal risk — executives track this to ensure anonymous sourcing is used judiciously."
    - name: "anonymous_byline_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_anonymous_flag = TRUE THEN newsroom_byline_credit_id END) / NULLIF(COUNT(newsroom_byline_credit_id), 0), 2)
      comment: "Percentage of byline credits that are anonymous. A rising anonymous rate may indicate source protection concerns or editorial credibility risks requiring policy review."
    - name: "wire_attributed_bylines_count"
      expr: COUNT(CASE WHEN wire_source_code IS NOT NULL AND wire_source_code <> '' THEN newsroom_byline_credit_id END)
      comment: "Count of bylines attributed to wire services rather than staff reporters. Tracks wire dependency in published content — used alongside original reporting metrics to assess editorial investment."
    - name: "staff_byline_count"
      expr: COUNT(CASE WHEN contributor_affiliation = 'staff' THEN newsroom_byline_credit_id END)
      comment: "Count of bylines from staff contributors. Staff bylines represent the newsroom's original reporting investment — a key editorial quality and brand differentiation KPI."
    - name: "freelance_byline_count"
      expr: COUNT(CASE WHEN contributor_affiliation = 'freelance' THEN newsroom_byline_credit_id END)
      comment: "Count of bylines from freelance contributors. Tracks freelance contributor utilisation — used to manage variable editorial cost and capacity planning."
    - name: "staff_vs_freelance_ratio"
      expr: ROUND(COUNT(CASE WHEN contributor_affiliation = 'staff' THEN newsroom_byline_credit_id END) / NULLIF(COUNT(CASE WHEN contributor_affiliation = 'freelance' THEN newsroom_byline_credit_id END), 0), 2)
      comment: "Ratio of staff bylines to freelance bylines. A declining ratio indicates increasing reliance on freelancers — a cost and editorial quality signal that informs headcount and budget decisions."
$$;