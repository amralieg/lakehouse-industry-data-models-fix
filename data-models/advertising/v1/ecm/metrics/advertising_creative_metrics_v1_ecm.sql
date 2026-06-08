-- Metric views for domain: creative | Business: Advertising | Version: 1 | Generated on: 2026-05-08 02:24:04

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`creative_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core creative asset performance and lifecycle metrics tracking asset utilization, compliance status, and rights management across campaigns and channels"
  source: "`advertising_ecm`.`creative`.`creative_asset`"
  dimensions:
    - name: "asset_type"
      expr: asset_type
      comment: "Type of creative asset (video, image, audio, etc.)"
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Current lifecycle stage of the asset (draft, approved, active, archived)"
    - name: "brand_compliance_status"
      expr: brand_compliance_status
      comment: "Brand compliance status (compliant, non-compliant, pending review)"
    - name: "rights_clearance_status"
      expr: rights_clearance_status
      comment: "Rights clearance status for legal usage"
    - name: "channel_suitability"
      expr: channel_suitability
      comment: "Channels where asset is suitable for use"
    - name: "geographic_market"
      expr: geographic_market
      comment: "Geographic market or region for asset deployment"
    - name: "language_code"
      expr: language_code
      comment: "Language code of the creative asset"
    - name: "file_format"
      expr: file_format
      comment: "File format of the asset"
    - name: "is_master_asset"
      expr: is_master_asset
      comment: "Flag indicating if this is a master/source asset"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month when asset was created"
    - name: "approved_month"
      expr: DATE_TRUNC('MONTH', approved_timestamp)
      comment: "Month when asset was approved"
  measures:
    - name: "total_assets"
      expr: COUNT(1)
      comment: "Total number of creative assets"
    - name: "unique_assets"
      expr: COUNT(DISTINCT creative_asset_id)
      comment: "Count of unique creative assets"
    - name: "avg_file_size_mb"
      expr: AVG(CAST(file_size_bytes AS DOUBLE) / 1048576.0)
      comment: "Average file size in megabytes across assets"
    - name: "total_file_size_gb"
      expr: SUM(CAST(file_size_bytes AS DOUBLE) / 1073741824.0)
      comment: "Total storage consumed by assets in gigabytes"
    - name: "avg_duration_seconds"
      expr: AVG(CAST(duration_seconds AS DOUBLE))
      comment: "Average duration in seconds for time-based assets"
    - name: "master_asset_count"
      expr: COUNT(CASE WHEN is_master_asset = TRUE THEN 1 END)
      comment: "Count of master/source assets"
    - name: "compliant_asset_count"
      expr: COUNT(CASE WHEN brand_compliance_status = 'compliant' THEN 1 END)
      comment: "Count of brand-compliant assets"
    - name: "rights_cleared_asset_count"
      expr: COUNT(CASE WHEN rights_clearance_status = 'cleared' THEN 1 END)
      comment: "Count of assets with cleared rights"
    - name: "brand_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN brand_compliance_status = 'compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assets that are brand compliant"
    - name: "rights_clearance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rights_clearance_status = 'cleared' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assets with cleared rights"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`creative_asset_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Creative asset usage and performance metrics tracking impressions, clicks, engagement, and rights compliance across campaigns and placements"
  source: "`advertising_ecm`.`creative`.`asset_usage`"
  dimensions:
    - name: "usage_type"
      expr: usage_type
      comment: "Type of asset usage (paid, organic, test, etc.)"
    - name: "usage_status"
      expr: usage_status
      comment: "Current status of asset usage"
    - name: "channel"
      expr: channel
      comment: "Media channel where asset is used"
    - name: "platform"
      expr: platform
      comment: "Platform where asset is deployed"
    - name: "market"
      expr: market
      comment: "Geographic market for usage"
    - name: "language"
      expr: language
      comment: "Language of the asset usage"
    - name: "is_rights_compliant"
      expr: is_rights_compliant
      comment: "Flag indicating rights compliance for this usage"
    - name: "rights_territory"
      expr: rights_territory
      comment: "Territory covered by rights for this usage"
    - name: "usage_month"
      expr: DATE_TRUNC('MONTH', usage_start_date)
      comment: "Month when asset usage started"
    - name: "trafficking_month"
      expr: DATE_TRUNC('MONTH', trafficking_date)
      comment: "Month when asset was trafficked"
  measures:
    - name: "total_usages"
      expr: COUNT(1)
      comment: "Total number of asset usage instances"
    - name: "unique_assets_used"
      expr: COUNT(DISTINCT creative_asset_id)
      comment: "Count of unique creative assets used"
    - name: "total_impressions"
      expr: SUM(CAST(impression_count AS DOUBLE))
      comment: "Total impressions delivered across all asset usages"
    - name: "total_clicks"
      expr: SUM(CAST(click_count AS DOUBLE))
      comment: "Total clicks generated across all asset usages"
    - name: "avg_ctr_pct"
      expr: AVG(CAST(ctr AS DOUBLE))
      comment: "Average click-through rate percentage across usages"
    - name: "avg_video_completion_rate_pct"
      expr: AVG(CAST(video_completion_rate AS DOUBLE))
      comment: "Average video completion rate percentage"
    - name: "overall_ctr_pct"
      expr: ROUND(100.0 * SUM(CAST(click_count AS DOUBLE)) / NULLIF(SUM(CAST(impression_count AS DOUBLE)), 0), 2)
      comment: "Overall click-through rate across all usages"
    - name: "rights_compliant_usage_count"
      expr: COUNT(CASE WHEN is_rights_compliant = TRUE THEN 1 END)
      comment: "Count of rights-compliant asset usages"
    - name: "rights_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_rights_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of asset usages that are rights compliant"
    - name: "avg_file_size_kb"
      expr: AVG(CAST(file_size_kb AS DOUBLE))
      comment: "Average file size in kilobytes for used assets"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`creative_production_job`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Creative production job performance metrics tracking cost efficiency, timeline adherence, billability, and quality compliance across production workflows"
  source: "`advertising_ecm`.`creative`.`production_job`"
  dimensions:
    - name: "job_type"
      expr: job_type
      comment: "Type of production job (video, photo, design, etc.)"
    - name: "job_status"
      expr: job_status
      comment: "Current status of production job"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the job"
    - name: "assigned_studio"
      expr: assigned_studio
      comment: "Studio assigned to the production job"
    - name: "brand_compliance_status"
      expr: brand_compliance_status
      comment: "Brand compliance status of the job output"
    - name: "legal_review_status"
      expr: legal_review_status
      comment: "Legal review status of the job"
    - name: "is_billable"
      expr: is_billable
      comment: "Flag indicating if job is billable to client"
    - name: "brand_compliance_required"
      expr: brand_compliance_required
      comment: "Flag indicating if brand compliance review is required"
    - name: "legal_review_required"
      expr: legal_review_required
      comment: "Flag indicating if legal review is required"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for job costs"
    - name: "production_start_month"
      expr: DATE_TRUNC('MONTH', production_start_date)
      comment: "Month when production started"
    - name: "delivery_deadline_month"
      expr: DATE_TRUNC('MONTH', delivery_deadline)
      comment: "Month of delivery deadline"
  measures:
    - name: "total_jobs"
      expr: COUNT(1)
      comment: "Total number of production jobs"
    - name: "unique_jobs"
      expr: COUNT(DISTINCT production_job_id)
      comment: "Count of unique production jobs"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost across all production jobs"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across all production jobs"
    - name: "total_estimated_hours"
      expr: SUM(CAST(estimated_hours AS DOUBLE))
      comment: "Total estimated hours across all production jobs"
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual hours spent across all production jobs"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per production job"
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per production job"
    - name: "cost_variance"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(estimated_cost AS DOUBLE))
      comment: "Total cost variance (actual minus estimated)"
    - name: "hours_variance"
      expr: SUM(CAST(actual_hours AS DOUBLE) - CAST(estimated_hours AS DOUBLE))
      comment: "Total hours variance (actual minus estimated)"
    - name: "cost_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(estimated_cost AS DOUBLE)) / NULLIF(SUM(CAST(actual_cost AS DOUBLE)), 0), 2)
      comment: "Cost efficiency percentage (estimated vs actual)"
    - name: "hours_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(estimated_hours AS DOUBLE)) / NULLIF(SUM(CAST(actual_hours AS DOUBLE)), 0), 2)
      comment: "Hours efficiency percentage (estimated vs actual)"
    - name: "billable_job_count"
      expr: COUNT(CASE WHEN is_billable = TRUE THEN 1 END)
      comment: "Count of billable production jobs"
    - name: "billable_job_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_billable = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of jobs that are billable"
    - name: "brand_compliant_job_count"
      expr: COUNT(CASE WHEN brand_compliance_status = 'approved' THEN 1 END)
      comment: "Count of brand-compliant production jobs"
    - name: "legal_approved_job_count"
      expr: COUNT(CASE WHEN legal_review_status = 'approved' THEN 1 END)
      comment: "Count of legally approved production jobs"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`creative_deliverable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Creative deliverable performance metrics tracking delivery timeliness, cost efficiency, quality compliance, and revision cycles across campaigns"
  source: "`advertising_ecm`.`creative`.`creative_deliverable`"
  dimensions:
    - name: "deliverable_type"
      expr: deliverable_type
      comment: "Type of creative deliverable"
    - name: "deliverable_status"
      expr: deliverable_status
      comment: "Current status of the deliverable"
    - name: "channel"
      expr: channel
      comment: "Media channel for the deliverable"
    - name: "priority"
      expr: priority
      comment: "Priority level of the deliverable"
    - name: "brand_compliance_status"
      expr: brand_compliance_status
      comment: "Brand compliance status of the deliverable"
    - name: "legal_approval_status"
      expr: legal_approval_status
      comment: "Legal approval status of the deliverable"
    - name: "legal_approval_required"
      expr: legal_approval_required
      comment: "Flag indicating if legal approval is required"
    - name: "file_format"
      expr: file_format
      comment: "File format of the deliverable"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for deliverable costs"
    - name: "requested_month"
      expr: DATE_TRUNC('MONTH', requested_date)
      comment: "Month when deliverable was requested"
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month when deliverable is due"
    - name: "delivered_month"
      expr: DATE_TRUNC('MONTH', delivered_date)
      comment: "Month when deliverable was delivered"
  measures:
    - name: "total_deliverables"
      expr: COUNT(1)
      comment: "Total number of creative deliverables"
    - name: "unique_deliverables"
      expr: COUNT(DISTINCT creative_deliverable_id)
      comment: "Count of unique creative deliverables"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost across all deliverables"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across all deliverables"
    - name: "total_estimated_hours"
      expr: SUM(CAST(estimated_hours AS DOUBLE))
      comment: "Total estimated hours across all deliverables"
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual hours spent across all deliverables"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per deliverable"
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per deliverable"
    - name: "cost_variance"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(estimated_cost AS DOUBLE))
      comment: "Total cost variance (actual minus estimated)"
    - name: "hours_variance"
      expr: SUM(CAST(actual_hours AS DOUBLE) - CAST(estimated_hours AS DOUBLE))
      comment: "Total hours variance (actual minus estimated)"
    - name: "cost_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(estimated_cost AS DOUBLE)) / NULLIF(SUM(CAST(actual_cost AS DOUBLE)), 0), 2)
      comment: "Cost efficiency percentage (estimated vs actual)"
    - name: "hours_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(estimated_hours AS DOUBLE)) / NULLIF(SUM(CAST(actual_hours AS DOUBLE)), 0), 2)
      comment: "Hours efficiency percentage (estimated vs actual)"
    - name: "avg_file_size_mb"
      expr: AVG(CAST(file_size_mb AS DOUBLE))
      comment: "Average file size in megabytes"
    - name: "brand_compliant_deliverable_count"
      expr: COUNT(CASE WHEN brand_compliance_status = 'approved' THEN 1 END)
      comment: "Count of brand-compliant deliverables"
    - name: "legal_approved_deliverable_count"
      expr: COUNT(CASE WHEN legal_approval_status = 'approved' THEN 1 END)
      comment: "Count of legally approved deliverables"
    - name: "brand_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN brand_compliance_status = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliverables that are brand compliant"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`creative_proof`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Creative proofing and review cycle metrics tracking approval velocity, SLA adherence, escalation rates, and review efficiency"
  source: "`advertising_ecm`.`creative`.`proof`"
  dimensions:
    - name: "proof_type"
      expr: proof_type
      comment: "Type of proof (creative, legal, compliance, etc.)"
    - name: "proof_status"
      expr: proof_status
      comment: "Current status of the proof"
    - name: "overall_decision"
      expr: overall_decision
      comment: "Overall decision on the proof (approved, rejected, changes requested)"
    - name: "stage"
      expr: stage
      comment: "Stage of the proofing process"
    - name: "automated_check_flag"
      expr: automated_check_flag
      comment: "Flag indicating if automated checks were performed"
    - name: "automated_check_result"
      expr: automated_check_result
      comment: "Result of automated checks"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Flag indicating if proof was escalated"
    - name: "sla_met_flag"
      expr: sla_met_flag
      comment: "Flag indicating if SLA was met"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month when proof was submitted"
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_timestamp)
      comment: "Month when decision was made"
  measures:
    - name: "total_proofs"
      expr: COUNT(1)
      comment: "Total number of proofs submitted"
    - name: "unique_proofs"
      expr: COUNT(DISTINCT proof_id)
      comment: "Count of unique proofs"
    - name: "approved_proof_count"
      expr: COUNT(CASE WHEN overall_decision = 'approved' THEN 1 END)
      comment: "Count of approved proofs"
    - name: "rejected_proof_count"
      expr: COUNT(CASE WHEN overall_decision = 'rejected' THEN 1 END)
      comment: "Count of rejected proofs"
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_decision = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of proofs approved on first submission"
    - name: "escalated_proof_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Count of proofs that were escalated"
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of proofs that required escalation"
    - name: "sla_met_count"
      expr: COUNT(CASE WHEN sla_met_flag = TRUE THEN 1 END)
      comment: "Count of proofs where SLA was met"
    - name: "sla_adherence_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_met_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of proofs meeting SLA targets"
    - name: "avg_turnaround_time_hours"
      expr: AVG(CAST(turnaround_time_hours AS DOUBLE))
      comment: "Average turnaround time in hours for proof review"
    - name: "avg_sla_target_hours"
      expr: AVG(CAST(sla_target_hours AS DOUBLE))
      comment: "Average SLA target in hours"
    - name: "avg_comment_count"
      expr: AVG(CAST(comment_count AS DOUBLE))
      comment: "Average number of comments per proof"
    - name: "avg_reviewer_count"
      expr: AVG(CAST(reviewer_count AS DOUBLE))
      comment: "Average number of reviewers per proof"
    - name: "automated_check_pass_count"
      expr: COUNT(CASE WHEN automated_check_result = 'pass' THEN 1 END)
      comment: "Count of proofs passing automated checks"
    - name: "automated_check_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN automated_check_result = 'pass' THEN 1 END) / NULLIF(COUNT(CASE WHEN automated_check_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of automated checks that passed"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`creative_rights_clearance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rights clearance and licensing metrics tracking license costs, territory coverage, exclusivity, renewal risk, and compliance across creative assets"
  source: "`advertising_ecm`.`creative`.`rights_clearance`"
  dimensions:
    - name: "rights_type"
      expr: rights_type
      comment: "Type of rights (music, talent, stock media, etc.)"
    - name: "clearance_status"
      expr: clearance_status
      comment: "Current clearance status"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Flag indicating if rights are exclusive"
    - name: "renewal_option_available"
      expr: renewal_option_available
      comment: "Flag indicating if renewal option is available"
    - name: "usage_tracking_required"
      expr: usage_tracking_required
      comment: "Flag indicating if usage tracking is required"
    - name: "permitted_territories"
      expr: permitted_territories
      comment: "Territories where usage is permitted"
    - name: "permitted_channels"
      expr: permitted_channels
      comment: "Channels where usage is permitted"
    - name: "license_fee_currency"
      expr: license_fee_currency
      comment: "Currency of license fee"
    - name: "stock_media_provider"
      expr: stock_media_provider
      comment: "Provider of stock media"
    - name: "risk_assessment"
      expr: risk_assessment
      comment: "Risk assessment level for rights usage"
    - name: "license_start_month"
      expr: DATE_TRUNC('MONTH', license_start_date)
      comment: "Month when license starts"
    - name: "license_end_month"
      expr: DATE_TRUNC('MONTH', license_end_date)
      comment: "Month when license ends"
  measures:
    - name: "total_clearances"
      expr: COUNT(1)
      comment: "Total number of rights clearances"
    - name: "unique_clearances"
      expr: COUNT(DISTINCT rights_clearance_id)
      comment: "Count of unique rights clearances"
    - name: "total_license_fees"
      expr: SUM(CAST(license_fee_amount AS DOUBLE))
      comment: "Total license fees paid across all clearances"
    - name: "avg_license_fee"
      expr: AVG(CAST(license_fee_amount AS DOUBLE))
      comment: "Average license fee per clearance"
    - name: "cleared_rights_count"
      expr: COUNT(CASE WHEN clearance_status = 'cleared' THEN 1 END)
      comment: "Count of cleared rights"
    - name: "clearance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN clearance_status = 'cleared' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rights successfully cleared"
    - name: "exclusive_rights_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END)
      comment: "Count of exclusive rights agreements"
    - name: "exclusivity_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rights that are exclusive"
    - name: "renewable_rights_count"
      expr: COUNT(CASE WHEN renewal_option_available = TRUE THEN 1 END)
      comment: "Count of rights with renewal options"
    - name: "usage_tracking_required_count"
      expr: COUNT(CASE WHEN usage_tracking_required = TRUE THEN 1 END)
      comment: "Count of rights requiring usage tracking"
    - name: "high_risk_clearance_count"
      expr: COUNT(CASE WHEN risk_assessment = 'high' THEN 1 END)
      comment: "Count of high-risk rights clearances"
    - name: "high_risk_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_assessment = 'high' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of clearances assessed as high risk"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`creative_compliance_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Creative compliance check metrics tracking brand, legal, and platform policy adherence, violation rates, remediation velocity, and sign-off efficiency"
  source: "`advertising_ecm`.`creative`.`creative_compliance_check`"
  dimensions:
    - name: "check_type"
      expr: check_type
      comment: "Type of compliance check (brand, legal, platform, regulatory)"
    - name: "check_status"
      expr: check_status
      comment: "Current status of the compliance check"
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the compliance check"
    - name: "brand_compliance_pass"
      expr: brand_compliance_pass
      comment: "Flag indicating if brand compliance passed"
    - name: "legal_compliance_pass"
      expr: legal_compliance_pass
      comment: "Flag indicating if legal compliance passed"
    - name: "platform_policy_pass"
      expr: platform_policy_pass
      comment: "Flag indicating if platform policy compliance passed"
    - name: "remediation_required"
      expr: remediation_required
      comment: "Flag indicating if remediation is required"
    - name: "recheck_required"
      expr: recheck_required
      comment: "Flag indicating if recheck is required"
    - name: "sign_off_status"
      expr: sign_off_status
      comment: "Sign-off status of the compliance check"
    - name: "platform_target"
      expr: platform_target
      comment: "Target platform for compliance check"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework applied"
    - name: "violation_severity"
      expr: violation_severity
      comment: "Severity level of violations identified"
    - name: "reviewer_role"
      expr: reviewer_role
      comment: "Role of the reviewer"
    - name: "check_month"
      expr: DATE_TRUNC('MONTH', check_date)
      comment: "Month when compliance check was performed"
  measures:
    - name: "total_checks"
      expr: COUNT(1)
      comment: "Total number of compliance checks performed"
    - name: "unique_checks"
      expr: COUNT(DISTINCT creative_compliance_check_id)
      comment: "Count of unique compliance checks"
    - name: "brand_compliance_pass_count"
      expr: COUNT(CASE WHEN brand_compliance_pass = TRUE THEN 1 END)
      comment: "Count of checks passing brand compliance"
    - name: "legal_compliance_pass_count"
      expr: COUNT(CASE WHEN legal_compliance_pass = TRUE THEN 1 END)
      comment: "Count of checks passing legal compliance"
    - name: "platform_policy_pass_count"
      expr: COUNT(CASE WHEN platform_policy_pass = TRUE THEN 1 END)
      comment: "Count of checks passing platform policy compliance"
    - name: "brand_compliance_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN brand_compliance_pass = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checks passing brand compliance"
    - name: "legal_compliance_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN legal_compliance_pass = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checks passing legal compliance"
    - name: "platform_policy_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN platform_policy_pass = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checks passing platform policy compliance"
    - name: "remediation_required_count"
      expr: COUNT(CASE WHEN remediation_required = TRUE THEN 1 END)
      comment: "Count of checks requiring remediation"
    - name: "remediation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN remediation_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checks requiring remediation"
    - name: "recheck_required_count"
      expr: COUNT(CASE WHEN recheck_required = TRUE THEN 1 END)
      comment: "Count of checks requiring recheck"
    - name: "signed_off_count"
      expr: COUNT(CASE WHEN sign_off_status = 'signed_off' THEN 1 END)
      comment: "Count of checks that have been signed off"
    - name: "sign_off_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sign_off_status = 'signed_off' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checks that have been signed off"
    - name: "high_severity_violation_count"
      expr: COUNT(CASE WHEN violation_severity = 'high' THEN 1 END)
      comment: "Count of checks with high-severity violations"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`creative_adaptation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Creative adaptation metrics tracking localization efficiency, cultural compliance, brand consistency, and market-specific asset performance"
  source: "`advertising_ecm`.`creative`.`adaptation`"
  dimensions:
    - name: "adaptation_type"
      expr: adaptation_type
      comment: "Type of adaptation (localization, resize, format conversion, etc.)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the adaptation"
    - name: "target_channel"
      expr: target_channel
      comment: "Target channel for the adaptation"
    - name: "target_market"
      expr: target_market
      comment: "Target market for the adaptation"
    - name: "target_locale"
      expr: target_locale
      comment: "Target locale for the adaptation"
    - name: "source_language"
      expr: source_language
      comment: "Source language of the original asset"
    - name: "target_language"
      expr: target_language
      comment: "Target language for the adaptation"
    - name: "cultural_review_status"
      expr: cultural_review_status
      comment: "Cultural review status"
    - name: "regulatory_review_status"
      expr: regulatory_review_status
      comment: "Regulatory review status"
    - name: "accessibility_compliance_flag"
      expr: accessibility_compliance_flag
      comment: "Flag indicating accessibility compliance"
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating if adaptation is currently active"
    - name: "aspect_ratio"
      expr: aspect_ratio
      comment: "Aspect ratio of the adapted asset"
    - name: "color_space"
      expr: color_space
      comment: "Color space of the adapted asset"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month when adaptation was created"
    - name: "approved_month"
      expr: DATE_TRUNC('MONTH', approved_timestamp)
      comment: "Month when adaptation was approved"
  measures:
    - name: "total_adaptations"
      expr: COUNT(1)
      comment: "Total number of creative adaptations"
    - name: "unique_adaptations"
      expr: COUNT(DISTINCT adaptation_id)
      comment: "Count of unique adaptations"
    - name: "approved_adaptation_count"
      expr: COUNT(CASE WHEN approval_status = 'approved' THEN 1 END)
      comment: "Count of approved adaptations"
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adaptations approved"
    - name: "active_adaptation_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active adaptations"
    - name: "accessibility_compliant_count"
      expr: COUNT(CASE WHEN accessibility_compliance_flag = TRUE THEN 1 END)
      comment: "Count of accessibility-compliant adaptations"
    - name: "accessibility_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN accessibility_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adaptations meeting accessibility standards"
    - name: "cultural_review_approved_count"
      expr: COUNT(CASE WHEN cultural_review_status = 'approved' THEN 1 END)
      comment: "Count of adaptations passing cultural review"
    - name: "regulatory_review_approved_count"
      expr: COUNT(CASE WHEN regulatory_review_status = 'approved' THEN 1 END)
      comment: "Count of adaptations passing regulatory review"
    - name: "avg_brand_compliance_score"
      expr: AVG(CAST(brand_compliance_score AS DOUBLE))
      comment: "Average brand compliance score across adaptations"
    - name: "avg_duration_seconds"
      expr: AVG(CAST(duration_seconds AS DOUBLE))
      comment: "Average duration in seconds for time-based adaptations"
    - name: "avg_file_size_kb"
      expr: AVG(CAST(file_size_kb AS DOUBLE))
      comment: "Average file size in kilobytes"
    - name: "unique_target_markets"
      expr: COUNT(DISTINCT target_market)
      comment: "Count of unique target markets covered"
    - name: "unique_target_languages"
      expr: COUNT(DISTINCT target_language)
      comment: "Count of unique target languages covered"
$$;