-- Metric views for domain: creative | Business: Advertising | Version: 1 | Generated on: 2026-05-08 03:48:00

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`creative_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the creative asset library — tracks asset volume, compliance health, rights exposure, file weight, and reuse efficiency to inform DAM governance and brand risk decisions."
  source: "`advertising_ecm`.`creative`.`asset`"
  dimensions:
    - name: "asset_type"
      expr: asset_type
      comment: "Type of creative asset (e.g. video, image, copy, audio) — primary segmentation for asset portfolio analysis."
    - name: "file_format"
      expr: file_format
      comment: "File format of the asset (e.g. MP4, JPEG, PDF) — used to assess format standardisation and spec compliance."
    - name: "brand_compliance_status"
      expr: brand_compliance_status
      comment: "Current brand compliance status of the asset — critical for brand governance reporting."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Stage in the asset lifecycle (e.g. draft, active, archived) — used to track asset currency and retirement."
    - name: "rights_clearance_status"
      expr: rights_clearance_status
      comment: "Rights clearance status of the asset — essential for legal risk management and usage eligibility."
    - name: "geographic_market"
      expr: geographic_market
      comment: "Geographic market the asset is targeted at — supports regional portfolio analysis."
    - name: "language_code"
      expr: language_code
      comment: "Language of the asset — used for localisation coverage analysis."
    - name: "channel_suitability"
      expr: channel_suitability
      comment: "Channels the asset is suitable for (e.g. digital, OOH, broadcast) — supports channel mix planning."
    - name: "is_master_asset"
      expr: is_master_asset
      comment: "Indicates whether the asset is a master (True) or derivative (False) — used to measure master-to-derivative ratios."
    - name: "approved_month"
      expr: DATE_TRUNC('MONTH', approved_timestamp)
      comment: "Month the asset was approved — enables trend analysis of asset approval throughput."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the asset was created — supports asset production volume trending."
    - name: "rights_expiry_date"
      expr: rights_expiry_date
      comment: "Date on which asset rights expire — used to identify assets approaching rights expiry for proactive renewal."
  measures:
    - name: "total_assets"
      expr: COUNT(1)
      comment: "Total number of creative assets in the library — baseline volume KPI for DAM portfolio sizing."
    - name: "brand_compliant_assets"
      expr: COUNT(CASE WHEN brand_compliance_status = 'Compliant' THEN 1 END)
      comment: "Number of assets with a compliant brand status — measures brand governance health."
    - name: "brand_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN brand_compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assets that are brand-compliant — executive KPI for brand risk; a declining rate triggers brand governance intervention."
    - name: "rights_cleared_assets"
      expr: COUNT(CASE WHEN rights_clearance_status = 'Cleared' THEN 1 END)
      comment: "Number of assets with cleared rights — measures legal readiness of the asset library."
    - name: "rights_clearance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rights_clearance_status = 'Cleared' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assets with cleared rights — critical legal risk KPI; low rates indicate exposure to rights infringement."
    - name: "master_asset_count"
      expr: COUNT(CASE WHEN is_master_asset = TRUE THEN 1 END)
      comment: "Number of master assets — used to assess the ratio of original creative to derivatives."
    - name: "total_file_size_gb"
      expr: ROUND(SUM(CAST(file_size_bytes AS DOUBLE)) / 1073741824.0, 4)
      comment: "Total storage footprint of all assets in gigabytes — informs DAM infrastructure cost and storage planning decisions."
    - name: "avg_file_size_mb"
      expr: ROUND(AVG(CAST(file_size_bytes AS DOUBLE)) / 1048576.0, 2)
      comment: "Average asset file size in megabytes — used to benchmark asset weight against channel delivery specs."
    - name: "avg_asset_duration_seconds"
      expr: ROUND(AVG(CAST(duration_seconds AS DOUBLE)), 2)
      comment: "Average duration of video/audio assets in seconds — used to assess creative length compliance with channel specs."
    - name: "distinct_geographic_markets"
      expr: COUNT(DISTINCT geographic_market)
      comment: "Number of distinct geographic markets covered by assets — measures localisation breadth of the creative library."
    - name: "distinct_languages"
      expr: COUNT(DISTINCT language_code)
      comment: "Number of distinct languages represented in the asset library — measures language localisation coverage."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`creative_asset_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for creative asset versioning — tracks revision cycles, approval throughput, promotion rates, and file weight trends to identify rework inefficiency and quality bottlenecks."
  source: "`advertising_ecm`.`creative`.`asset_version`"
  dimensions:
    - name: "version_status"
      expr: version_status
      comment: "Current status of the asset version (e.g. draft, approved, rejected, archived) — primary segmentation for version pipeline analysis."
    - name: "file_format"
      expr: file_format
      comment: "File format of this version — used to track format standardisation across version history."
    - name: "brand_compliance_status"
      expr: brand_compliance_status
      comment: "Brand compliance status of this specific version — used to measure compliance improvement across revision rounds."
    - name: "is_promoted"
      expr: is_promoted
      comment: "Whether this version has been promoted to production — used to measure promotion rate."
    - name: "is_archived"
      expr: is_archived
      comment: "Whether this version has been archived — used to measure archive rate and library hygiene."
    - name: "approved_by_name"
      expr: approved_by_name
      comment: "Name of the approver — used to analyse approval workload distribution."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_timestamp)
      comment: "Month the version was approved — enables approval throughput trending."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the version was created — supports version production volume trending."
  measures:
    - name: "total_versions"
      expr: COUNT(1)
      comment: "Total number of asset versions — baseline measure of revision volume across the creative pipeline."
    - name: "approved_versions"
      expr: COUNT(CASE WHEN version_status = 'Approved' THEN 1 END)
      comment: "Number of versions that reached approved status — measures approval throughput."
    - name: "rejected_versions"
      expr: COUNT(CASE WHEN version_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected versions — a high rejection count signals quality or briefing issues upstream."
    - name: "version_rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN version_status = 'Rejected' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of versions that were rejected — executive quality KPI; high rates indicate rework cost and briefing misalignment."
    - name: "promoted_versions"
      expr: COUNT(CASE WHEN is_promoted = TRUE THEN 1 END)
      comment: "Number of versions promoted to production — measures how many versions successfully reach live deployment."
    - name: "version_promotion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_promoted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of versions promoted to production — measures creative pipeline efficiency; low rates indicate excessive rework."
    - name: "brand_compliant_versions"
      expr: COUNT(CASE WHEN brand_compliance_status = 'Compliant' THEN 1 END)
      comment: "Number of versions that are brand-compliant — measures brand governance adherence at the version level."
    - name: "brand_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN brand_compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of asset versions that are brand-compliant — tracks brand quality improvement across revision cycles."
    - name: "total_file_size_gb"
      expr: ROUND(SUM(CAST(file_size_bytes AS DOUBLE)) / 1073741824.0, 4)
      comment: "Total storage consumed by all versions in gigabytes — informs version retention policy and storage cost management."
    - name: "avg_version_duration_seconds"
      expr: ROUND(AVG(CAST(duration_seconds AS DOUBLE)), 2)
      comment: "Average duration of versioned video/audio assets in seconds — used to track creative length compliance across revision rounds."
    - name: "distinct_assets_versioned"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of distinct assets that have at least one version record — measures the breadth of the versioned asset portfolio."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`creative_brief`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for creative brief management — tracks brief volume, status pipeline, priority distribution, and cycle times to measure briefing efficiency and workload across the creative function."
  source: "`advertising_ecm`.`creative`.`creative_brief`"
  dimensions:
    - name: "creative_brief_status"
      expr: creative_brief_status
      comment: "Current status of the creative brief (e.g. draft, submitted, approved, in-progress) — primary pipeline segmentation."
    - name: "brief_type"
      expr: brief_type
      comment: "Type of creative brief (e.g. campaign, tactical, brand) — used to analyse workload by brief category."
    - name: "priority"
      expr: priority
      comment: "Priority level of the brief — used to assess urgency distribution and resource allocation."
    - name: "channel_distribution"
      expr: channel_distribution
      comment: "Channel(s) the brief targets — used to analyse brief volume by channel."
    - name: "tone_of_voice"
      expr: tone_of_voice
      comment: "Tone of voice specified in the brief — used to track brand voice consistency across briefs."
    - name: "submitted_month"
      expr: DATE_TRUNC('MONTH', submitted_date)
      comment: "Month the brief was submitted — enables brief intake volume trending."
    - name: "approved_month"
      expr: DATE_TRUNC('MONTH', approved_date)
      comment: "Month the brief was approved — used to track approval throughput over time."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the brief is due — used for workload forecasting and deadline management."
  measures:
    - name: "total_briefs"
      expr: COUNT(1)
      comment: "Total number of creative briefs — baseline volume KPI for creative demand management."
    - name: "approved_briefs"
      expr: COUNT(CASE WHEN creative_brief_status = 'Approved' THEN 1 END)
      comment: "Number of approved creative briefs — measures how many briefs have cleared the approval gate."
    - name: "brief_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN creative_brief_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of briefs that have been approved — measures briefing quality and approval efficiency; low rates indicate briefing process issues."
    - name: "high_priority_briefs"
      expr: COUNT(CASE WHEN priority = 'High' THEN 1 END)
      comment: "Number of high-priority creative briefs — used to assess urgent workload pressure on the creative team."
    - name: "high_priority_brief_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN priority = 'High' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of briefs classified as high priority — a rising share signals resource strain and potential delivery risk."
    - name: "distinct_brands_briefed"
      expr: COUNT(DISTINCT brand_id)
      comment: "Number of distinct brands with active creative briefs — measures breadth of creative demand across the brand portfolio."
    - name: "distinct_campaigns_briefed"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns driving creative briefs — measures campaign-level creative demand."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`creative_concept`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for creative concept development — tracks concept pipeline health, approval rates, production cost estimates, complexity distribution, and legal review exposure to steer creative strategy and investment."
  source: "`advertising_ecm`.`creative`.`concept`"
  dimensions:
    - name: "concept_status"
      expr: concept_status
      comment: "Current status of the concept (e.g. ideation, in-review, approved, rejected) — primary pipeline segmentation."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the concept — used to measure concept approval throughput."
    - name: "production_complexity"
      expr: production_complexity
      comment: "Complexity level of the concept (e.g. low, medium, high) — used to assess production risk and resource requirements."
    - name: "channel_applicability"
      expr: channel_applicability
      comment: "Channels the concept is applicable to — used to analyse concept distribution across channel strategy."
    - name: "creative_territory"
      expr: creative_territory
      comment: "Creative territory or theme of the concept — used to track strategic creative direction trends."
    - name: "tone_of_voice"
      expr: tone_of_voice
      comment: "Tone of voice of the concept — used to assess brand voice consistency across concepts."
    - name: "legal_review_required"
      expr: legal_review_required
      comment: "Whether the concept requires legal review — used to forecast legal workload."
    - name: "legal_review_status"
      expr: legal_review_status
      comment: "Current legal review status of the concept — used to track legal clearance pipeline."
    - name: "brand_compliance_flag"
      expr: brand_compliance_flag
      comment: "Whether the concept has been flagged for brand compliance — used to identify brand risk at the concept stage."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the concept was approved — enables concept approval throughput trending."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the concept was created — supports concept ideation volume trending."
  measures:
    - name: "total_concepts"
      expr: COUNT(1)
      comment: "Total number of creative concepts — baseline volume KPI for creative ideation pipeline management."
    - name: "approved_concepts"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of concepts that have been approved — measures creative ideation success rate."
    - name: "concept_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of concepts approved — executive KPI for creative quality; low rates indicate strategic misalignment or briefing gaps."
    - name: "concepts_requiring_legal_review"
      expr: COUNT(CASE WHEN legal_review_required = TRUE THEN 1 END)
      comment: "Number of concepts requiring legal review — used to forecast legal team workload and identify regulatory exposure."
    - name: "legal_review_required_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN legal_review_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of concepts requiring legal review — a high rate signals elevated regulatory risk in the creative pipeline."
    - name: "brand_compliance_flagged_concepts"
      expr: COUNT(CASE WHEN brand_compliance_flag = TRUE THEN 1 END)
      comment: "Number of concepts flagged for brand compliance issues — measures brand risk at the earliest creative stage."
    - name: "total_estimated_production_cost"
      expr: SUM(CAST(estimated_production_cost AS DOUBLE))
      comment: "Total estimated production cost across all concepts — used to assess creative investment pipeline and budget exposure."
    - name: "avg_estimated_production_cost"
      expr: ROUND(AVG(CAST(estimated_production_cost AS DOUBLE)), 2)
      comment: "Average estimated production cost per concept — benchmarks concept investment level and identifies outliers."
    - name: "high_complexity_concepts"
      expr: COUNT(CASE WHEN production_complexity = 'High' THEN 1 END)
      comment: "Number of high-complexity concepts — used to assess production risk concentration and resource planning."
    - name: "high_complexity_concept_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN production_complexity = 'High' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of concepts classified as high complexity — a rising share signals increasing production risk and cost pressure."
    - name: "distinct_brands_with_concepts"
      expr: COUNT(DISTINCT brand_id)
      comment: "Number of distinct brands with active concepts — measures creative ideation breadth across the brand portfolio."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`creative_production_job`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for production job management — tracks job volume, cost variance, hours efficiency, delivery performance, and compliance to steer production operations and vendor management decisions."
  source: "`advertising_ecm`.`creative`.`production_job`"
  dimensions:
    - name: "job_status"
      expr: job_status
      comment: "Current status of the production job (e.g. in-progress, completed, on-hold) — primary pipeline segmentation."
    - name: "job_type"
      expr: job_type
      comment: "Type of production job (e.g. video, print, digital) — used to analyse production volume and cost by job category."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the production job — used to assess urgency distribution and resource allocation."
    - name: "brand_compliance_status"
      expr: brand_compliance_status
      comment: "Brand compliance status of the production job — used to track compliance at the production stage."
    - name: "legal_review_status"
      expr: legal_review_status
      comment: "Legal review status of the production job — used to track legal clearance pipeline."
    - name: "is_billable"
      expr: is_billable
      comment: "Whether the production job is billable to the client — used to segment billable vs. non-billable production activity."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the production job costs — used for multi-currency cost analysis."
    - name: "assigned_studio"
      expr: assigned_studio
      comment: "Studio assigned to the production job — used to analyse production workload and performance by studio."
    - name: "production_start_month"
      expr: DATE_TRUNC('MONTH', production_start_date)
      comment: "Month production started — enables production volume and cost trending."
    - name: "delivery_deadline_month"
      expr: DATE_TRUNC('MONTH', delivery_deadline)
      comment: "Month the delivery deadline falls — used for delivery workload forecasting."
    - name: "final_delivery_month"
      expr: DATE_TRUNC('MONTH', final_delivery_date)
      comment: "Month of final delivery — used to track actual delivery timing vs. deadline."
  measures:
    - name: "total_production_jobs"
      expr: COUNT(1)
      comment: "Total number of production jobs — baseline volume KPI for production capacity and throughput management."
    - name: "completed_jobs"
      expr: COUNT(CASE WHEN job_status = 'Completed' THEN 1 END)
      comment: "Number of completed production jobs — measures production throughput."
    - name: "job_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN job_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of production jobs completed — executive throughput KPI; declining rates signal production bottlenecks."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual production cost across all jobs — primary financial KPI for production spend management."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated production cost across all jobs — used as the budget baseline for cost variance analysis."
    - name: "cost_variance"
      expr: SUM((CAST(actual_cost AS DOUBLE)) - (CAST(estimated_cost AS DOUBLE)))
      comment: "Absolute cost variance (actual minus estimated) across all production jobs — positive values indicate cost overruns requiring management action."
    - name: "avg_cost_per_job"
      expr: ROUND(AVG(CAST(actual_cost AS DOUBLE)), 2)
      comment: "Average actual cost per production job — used to benchmark production unit economics and identify outliers."
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual hours spent across all production jobs — measures total production labour consumption."
    - name: "total_estimated_hours"
      expr: SUM(CAST(estimated_hours AS DOUBLE))
      comment: "Total estimated hours across all production jobs — used as the baseline for hours efficiency analysis."
    - name: "hours_variance"
      expr: SUM((CAST(actual_hours AS DOUBLE)) - (CAST(estimated_hours AS DOUBLE)))
      comment: "Absolute hours variance (actual minus estimated) — positive values indicate scope creep or underestimation, triggering resourcing review."
    - name: "avg_hours_per_job"
      expr: ROUND(AVG(CAST(actual_hours AS DOUBLE)), 2)
      comment: "Average actual hours per production job — used to benchmark production effort and identify inefficient jobs."
    - name: "billable_jobs"
      expr: COUNT(CASE WHEN is_billable = TRUE THEN 1 END)
      comment: "Number of billable production jobs — used to assess revenue-generating production activity."
    - name: "billable_job_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_billable = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of production jobs that are billable — measures the proportion of production activity generating client revenue."
    - name: "brand_compliant_jobs"
      expr: COUNT(CASE WHEN brand_compliance_status = 'Compliant' THEN 1 END)
      comment: "Number of production jobs meeting brand compliance requirements — measures brand governance at the production stage."
    - name: "brand_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN brand_compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of production jobs that are brand-compliant — executive brand risk KPI for production operations."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`creative_deliverable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for creative deliverable tracking — measures delivery performance, cost efficiency, revision burden, legal compliance, and brand quality to steer creative operations and client commitments."
  source: "`advertising_ecm`.`creative`.`creative_deliverable`"
  dimensions:
    - name: "deliverable_status"
      expr: deliverable_status
      comment: "Current status of the deliverable (e.g. in-progress, delivered, accepted, rejected) — primary pipeline segmentation."
    - name: "deliverable_type"
      expr: deliverable_type
      comment: "Type of deliverable (e.g. video, banner, print) — used to analyse delivery volume and cost by format."
    - name: "channel"
      expr: channel
      comment: "Channel the deliverable is intended for — used to analyse delivery performance by channel."
    - name: "brand_compliance_status"
      expr: brand_compliance_status
      comment: "Brand compliance status of the deliverable — used to track brand quality at the delivery stage."
    - name: "legal_approval_status"
      expr: legal_approval_status
      comment: "Legal approval status of the deliverable — used to track legal clearance pipeline."
    - name: "legal_approval_required"
      expr: legal_approval_required
      comment: "Whether legal approval is required for this deliverable — used to forecast legal workload."
    - name: "priority"
      expr: priority
      comment: "Priority of the deliverable — used to assess urgency distribution and resource allocation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the deliverable costs — used for multi-currency cost analysis."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of delivery (e.g. digital upload, physical, FTP) — used to analyse delivery channel efficiency."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the deliverable is due — used for delivery workload forecasting."
    - name: "delivered_month"
      expr: DATE_TRUNC('MONTH', delivered_date)
      comment: "Month the deliverable was actually delivered — used to track delivery timing and on-time performance."
    - name: "production_start_month"
      expr: DATE_TRUNC('MONTH', production_start_date)
      comment: "Month production started for this deliverable — used to track production lead time."
  measures:
    - name: "total_deliverables"
      expr: COUNT(1)
      comment: "Total number of creative deliverables — baseline volume KPI for delivery pipeline management."
    - name: "delivered_deliverables"
      expr: COUNT(CASE WHEN deliverable_status = 'Delivered' THEN 1 END)
      comment: "Number of deliverables that have been delivered — measures delivery throughput."
    - name: "accepted_deliverables"
      expr: COUNT(CASE WHEN deliverable_status = 'Accepted' THEN 1 END)
      comment: "Number of deliverables accepted by the client — measures final delivery quality and client satisfaction."
    - name: "deliverable_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN deliverable_status = 'Accepted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliverables accepted by the client — executive quality KPI; low rates indicate rework cost and client dissatisfaction."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of all deliverables — primary financial KPI for deliverable spend management."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all deliverables — used as the budget baseline for cost variance analysis."
    - name: "deliverable_cost_variance"
      expr: SUM((CAST(actual_cost AS DOUBLE)) - (CAST(estimated_cost AS DOUBLE)))
      comment: "Absolute cost variance (actual minus estimated) across deliverables — positive values indicate cost overruns requiring management action."
    - name: "avg_actual_cost_per_deliverable"
      expr: ROUND(AVG(CAST(actual_cost AS DOUBLE)), 2)
      comment: "Average actual cost per deliverable — used to benchmark deliverable unit economics and identify cost outliers."
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual hours spent producing deliverables — measures total creative labour consumption."
    - name: "hours_variance"
      expr: SUM((CAST(actual_hours AS DOUBLE)) - (CAST(estimated_hours AS DOUBLE)))
      comment: "Absolute hours variance (actual minus estimated) across deliverables — positive values indicate scope creep or underestimation."
    - name: "total_file_size_mb"
      expr: SUM(CAST(file_size_mb AS DOUBLE))
      comment: "Total file size of all deliverables in megabytes — used to assess delivery payload and channel spec compliance."
    - name: "avg_file_size_mb"
      expr: ROUND(AVG(CAST(file_size_mb AS DOUBLE)), 2)
      comment: "Average file size per deliverable in megabytes — used to benchmark deliverable weight against channel delivery specs."
    - name: "brand_compliant_deliverables"
      expr: COUNT(CASE WHEN brand_compliance_status = 'Compliant' THEN 1 END)
      comment: "Number of deliverables meeting brand compliance requirements — measures brand governance at the final delivery stage."
    - name: "brand_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN brand_compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliverables that are brand-compliant — executive brand risk KPI for delivery operations."
    - name: "legally_approved_deliverables"
      expr: COUNT(CASE WHEN legal_approval_status = 'Approved' THEN 1 END)
      comment: "Number of deliverables with legal approval — measures legal clearance throughput for the delivery pipeline."
    - name: "legal_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN legal_approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(CASE WHEN legal_approval_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of legally-required deliverables that have received legal approval — measures legal clearance efficiency; low rates indicate delivery risk."
    - name: "distinct_campaigns_with_deliverables"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns with active deliverables — measures breadth of creative delivery activity across campaigns."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`creative_proof`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for creative proof and approval workflow — tracks proof cycle efficiency, SLA adherence, escalation rates, and turnaround times to identify approval bottlenecks and quality control performance."
  source: "`advertising_ecm`.`creative`.`proof`"
  dimensions:
    - name: "proof_status"
      expr: proof_status
      comment: "Current status of the proof (e.g. pending, approved, rejected, in-review) — primary pipeline segmentation."
    - name: "proof_type"
      expr: proof_type
      comment: "Type of proof (e.g. digital, print, video) — used to analyse proof volume and performance by format."
    - name: "overall_decision"
      expr: overall_decision
      comment: "Final decision on the proof (e.g. approved, rejected, approved-with-changes) — used to measure proof outcome distribution."
    - name: "stage"
      expr: stage
      comment: "Stage of the proof in the approval workflow — used to identify where proofs are stalling."
    - name: "sla_met_flag"
      expr: sla_met_flag
      comment: "Whether the proof was completed within SLA — primary SLA compliance dimension."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the proof was escalated — used to identify high-risk or contentious proofs."
    - name: "automated_check_flag"
      expr: automated_check_flag
      comment: "Whether an automated compliance check was run on the proof — used to measure automation adoption in the approval workflow."
    - name: "automated_check_result"
      expr: automated_check_result
      comment: "Result of the automated compliance check — used to assess automated check accuracy and pass rates."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month the proof was submitted — enables proof volume and SLA trending."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_timestamp)
      comment: "Month the proof decision was made — used to track approval throughput over time."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the proof is due — used for approval workload forecasting."
  measures:
    - name: "total_proofs"
      expr: COUNT(1)
      comment: "Total number of proofs submitted — baseline volume KPI for approval workflow capacity management."
    - name: "approved_proofs"
      expr: COUNT(CASE WHEN overall_decision = 'Approved' THEN 1 END)
      comment: "Number of proofs approved — measures approval throughput in the creative review workflow."
    - name: "rejected_proofs"
      expr: COUNT(CASE WHEN overall_decision = 'Rejected' THEN 1 END)
      comment: "Number of proofs rejected — a high rejection count signals quality issues upstream in the creative process."
    - name: "proof_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_decision = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of proofs approved on first or any submission — executive quality KPI; low rates indicate rework cost and creative quality issues."
    - name: "proof_rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_decision = 'Rejected' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of proofs rejected — a rising rejection rate triggers investigation into creative quality and briefing alignment."
    - name: "sla_met_proofs"
      expr: COUNT(CASE WHEN sla_met_flag = TRUE THEN 1 END)
      comment: "Number of proofs completed within SLA — measures SLA compliance in the approval workflow."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_met_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of proofs completed within SLA — executive SLA KPI; declining rates indicate approval process bottlenecks and potential contract penalties."
    - name: "escalated_proofs"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of proofs that were escalated — measures the volume of high-risk or contentious approval decisions."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of proofs escalated — a rising escalation rate signals systemic approval issues requiring process intervention."
    - name: "avg_turnaround_time_hours"
      expr: ROUND(AVG(CAST(turnaround_time_hours AS DOUBLE)), 2)
      comment: "Average proof turnaround time in hours — measures approval workflow speed; high values indicate bottlenecks impacting delivery timelines."
    - name: "max_turnaround_time_hours"
      expr: MAX(CAST(turnaround_time_hours AS DOUBLE))
      comment: "Maximum proof turnaround time in hours — identifies worst-case approval delays for SLA breach investigation."
    - name: "automated_check_proofs"
      expr: COUNT(CASE WHEN automated_check_flag = TRUE THEN 1 END)
      comment: "Number of proofs with automated compliance checks — measures automation adoption in the approval workflow."
    - name: "automation_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN automated_check_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of proofs using automated compliance checks — measures process automation maturity; low rates indicate manual review inefficiency."
$$;