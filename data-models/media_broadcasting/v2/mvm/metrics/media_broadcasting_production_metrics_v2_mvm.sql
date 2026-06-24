-- Metric views for domain: production | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-23 04:34:26

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for production projects — budget performance, delivery timeliness, and portfolio composition. Used by production executives to steer greenlight decisions, track spend vs. approved budget, and monitor delivery health across the active slate."
  source: "`vibe_media_broadcasting_v1`.`production`.`project`"
  dimensions:
    - name: "production_phase"
      expr: production_phase
      comment: "Current phase of the production project (e.g., pre-production, principal photography, post-production). Enables phase-level performance analysis."
    - name: "production_country"
      expr: production_country
      comment: "Country where the production is primarily based. Supports geographic cost and portfolio analysis."
    - name: "content_genre"
      expr: content_genre
      comment: "Genre of the content being produced (e.g., drama, comedy, documentary). Enables genre-level investment and performance tracking."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of the production. Supports international content portfolio analysis."
    - name: "co_production_flag"
      expr: co_production_flag
      comment: "Indicates whether the project is a co-production with an external partner. Enables co-production vs. wholly-owned portfolio segmentation."
    - name: "original_ip_flag"
      expr: original_ip_flag
      comment: "Indicates whether the project is based on original IP. Supports original vs. adapted content investment analysis."
    - name: "drm_required"
      expr: drm_required
      comment: "Indicates whether DRM protection is required for this project. Relevant for rights and distribution planning."
    - name: "greenlight_year"
      expr: YEAR(greenlight_date)
      comment: "Year the project received greenlight approval. Enables cohort analysis of projects by greenlight vintage."
    - name: "target_delivery_year"
      expr: YEAR(target_delivery_date)
      comment: "Year the project is targeted for delivery. Supports forward-looking slate planning."
    - name: "principal_photography_start_year"
      expr: YEAR(principal_photography_start_date)
      comment: "Year principal photography began. Enables production activity timeline analysis."
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of production projects. Baseline measure for portfolio size and throughput tracking."
    - name: "total_approved_budget_usd"
      expr: SUM(CAST(approved_budget_usd AS DOUBLE))
      comment: "Total approved budget in USD across all production projects. Core financial commitment metric for executive budget oversight."
    - name: "total_actual_spend_usd"
      expr: SUM(CAST(actual_spend_usd AS DOUBLE))
      comment: "Total actual spend in USD across all production projects. Tracks realized cost against approved budget."
    - name: "avg_approved_budget_usd"
      expr: AVG(CAST(approved_budget_usd AS DOUBLE))
      comment: "Average approved budget per production project. Benchmarks typical project investment size for portfolio planning."
    - name: "avg_actual_spend_usd"
      expr: AVG(CAST(actual_spend_usd AS DOUBLE))
      comment: "Average actual spend per production project. Supports cost benchmarking and budget calibration for future projects."
    - name: "total_budget_variance_usd"
      expr: SUM(CAST(actual_spend_usd AS DOUBLE) - CAST(approved_budget_usd AS DOUBLE))
      comment: "Total variance between actual spend and approved budget (positive = over budget). Critical financial health indicator for the production portfolio."
    - name: "over_budget_project_count"
      expr: COUNT(CASE WHEN actual_spend_usd > approved_budget_usd THEN 1 END)
      comment: "Number of projects where actual spend exceeds approved budget. Flags financial risk concentration in the active slate."
    - name: "co_production_project_count"
      expr: COUNT(CASE WHEN co_production_flag = TRUE THEN 1 END)
      comment: "Number of co-production projects. Tracks partnership-based production volume for strategic alliance management."
    - name: "original_ip_project_count"
      expr: COUNT(CASE WHEN original_ip_flag = TRUE THEN 1 END)
      comment: "Number of projects based on original IP. Measures the organization's investment in proprietary content creation."
    - name: "late_delivery_project_count"
      expr: COUNT(CASE WHEN actual_delivery_date > target_delivery_date AND actual_delivery_date IS NOT NULL THEN 1 END)
      comment: "Number of projects delivered after their target delivery date. Key operational KPI for production schedule adherence."
    - name: "avg_delivery_delay_days"
      expr: AVG(CASE WHEN actual_delivery_date > target_delivery_date THEN DATEDIFF(actual_delivery_date, target_delivery_date) ELSE 0 END)
      comment: "Average number of days late for projects that missed their target delivery date. Quantifies delivery schedule slippage for operational intervention."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial control KPIs for production budgets — variance analysis, forecast accuracy, contingency utilization, and cost category breakdown. Used by production finance teams and CFOs to monitor budget health and cost discipline."
  source: "`vibe_media_broadcasting_v1`.`production`.`budget`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the budget record (e.g., approved, pending, rejected). Enables filtering to approved vs. unapproved budget commitments."
    - name: "cost_category_name"
      expr: cost_category_name
      comment: "Name of the cost category (e.g., above-the-line, below-the-line, post-production). Enables cost structure analysis by category."
    - name: "cost_category_code"
      expr: cost_category_code
      comment: "Code for the cost category. Supports integration with financial systems and standardized cost reporting."
    - name: "cost_line_type"
      expr: cost_line_type
      comment: "Type of cost line (e.g., labor, equipment, facility). Enables granular cost type analysis."
    - name: "production_phase"
      expr: production_phase
      comment: "Production phase associated with this budget record. Enables phase-level budget tracking."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget record. Supports annual financial planning and reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the budget record. Enables period-level budget monitoring and accrual analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the budget amounts are denominated. Supports multi-currency budget analysis."
    - name: "is_greenlight_budget"
      expr: is_greenlight_budget
      comment: "Indicates whether this is the greenlight-approved budget version. Enables comparison of greenlight vs. revised budget positions."
    - name: "is_locked"
      expr: is_locked
      comment: "Indicates whether the budget record is locked from further changes. Supports budget governance and change control monitoring."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month the budget period starts. Enables monthly budget trend analysis."
  measures:
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved budget amount. Primary financial authorization metric for production cost control."
    - name: "total_actual_cost_amount"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost incurred. Tracks realized spend against approved budget for financial oversight."
    - name: "total_forecast_amount"
      expr: SUM(CAST(forecast_amount AS DOUBLE))
      comment: "Total forecasted cost amount. Enables estimate-at-completion analysis for proactive budget management."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed (obligated) spend. Measures financial obligations not yet invoiced, critical for cash flow planning."
    - name: "total_revised_amount"
      expr: SUM(CAST(revised_amount AS DOUBLE))
      comment: "Total revised budget amount after change orders. Tracks budget evolution from original approval."
    - name: "total_contingency_amount"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency budget held in reserve. Monitors risk buffer availability across the production portfolio."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (actual vs. approved). Aggregate financial health indicator for production cost discipline."
    - name: "avg_contingency_percentage"
      expr: AVG(CAST(contingency_percentage AS DOUBLE))
      comment: "Average contingency percentage held across budget records. Benchmarks risk provisioning practices across productions."
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Total number of budget records. Baseline measure for budget complexity and granularity tracking."
    - name: "over_budget_line_count"
      expr: COUNT(CASE WHEN actual_cost_amount > approved_amount THEN 1 END)
      comment: "Number of budget lines where actual cost exceeds approved amount. Identifies cost overrun concentration by category or phase."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to budget records. Supports FX exposure monitoring for international productions."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular budget line KPIs for production cost management — actual vs. budgeted spend, forecast accuracy, fringe costs, and above/below-the-line labor analysis. Used by production accountants and line producers to manage detailed cost control."
  source: "`vibe_media_broadcasting_v1`.`production`.`budget_line`"
  dimensions:
    - name: "cost_category"
      expr: cost_category
      comment: "High-level cost category for the budget line (e.g., labor, equipment, travel). Enables category-level cost analysis."
    - name: "cost_sub_category"
      expr: cost_sub_category
      comment: "Sub-category of the cost line for granular cost breakdown analysis."
    - name: "production_phase"
      expr: production_phase
      comment: "Production phase associated with this budget line. Enables phase-level cost tracking."
    - name: "is_above_the_line"
      expr: is_above_the_line
      comment: "Indicates whether the cost is above-the-line (creative talent, rights) vs. below-the-line (crew, equipment). Core production finance segmentation."
    - name: "is_union_labor"
      expr: is_union_labor
      comment: "Indicates whether the cost relates to union labor. Enables union vs. non-union cost analysis for labor compliance and negotiation."
    - name: "tax_credit_eligible"
      expr: tax_credit_eligible
      comment: "Indicates whether the budget line is eligible for tax credits. Supports tax incentive optimization and reporting."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the budget line quantity (e.g., days, hours, units). Enables rate and quantity analysis."
    - name: "shoot_date_start_month"
      expr: DATE_TRUNC('MONTH', shoot_date_start)
      comment: "Month the shoot period starts for this budget line. Enables monthly production cost phasing analysis."
  measures:
    - name: "total_budgeted_amount"
      expr: SUM(CAST(budgeted_amount AS DOUBLE))
      comment: "Total originally budgeted amount across all lines. Baseline financial plan for production cost management."
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual spend recorded against budget lines. Tracks realized cost for financial close and variance reporting."
    - name: "total_forecast_amount"
      expr: SUM(CAST(forecast_amount AS DOUBLE))
      comment: "Total forecasted spend across budget lines. Enables estimate-at-completion analysis for proactive cost management."
    - name: "total_revised_budgeted_amount"
      expr: SUM(CAST(revised_budgeted_amount AS DOUBLE))
      comment: "Total revised budget after change orders. Tracks budget evolution from original plan to current authorization."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed (obligated) spend on budget lines. Measures financial obligations not yet invoiced."
    - name: "total_accrued_amount"
      expr: SUM(CAST(accrued_amount AS DOUBLE))
      comment: "Total accrued cost on budget lines. Supports period-end financial close and accrual accounting."
    - name: "total_actual_vs_budget_variance"
      expr: SUM(CAST(actual_amount AS DOUBLE) - CAST(budgeted_amount AS DOUBLE))
      comment: "Total variance between actual spend and original budget (positive = over budget). Primary cost control KPI for line producers."
    - name: "avg_fringe_rate_pct"
      expr: AVG(CAST(fringe_rate_pct AS DOUBLE))
      comment: "Average fringe benefit rate percentage across budget lines. Benchmarks labor burden costs for workforce planning."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity (days, hours, units) across budget lines. Supports resource utilization and rate analysis."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate across budget lines. Benchmarks cost rates for negotiation and future budget planning."
    - name: "tax_credit_eligible_amount"
      expr: SUM(CASE WHEN tax_credit_eligible = TRUE THEN CAST(budgeted_amount AS DOUBLE) ELSE 0 END)
      comment: "Total budgeted amount eligible for tax credits. Quantifies the tax incentive opportunity for production finance optimization."
    - name: "above_the_line_actual_amount"
      expr: SUM(CASE WHEN is_above_the_line = TRUE THEN CAST(actual_amount AS DOUBLE) ELSE 0 END)
      comment: "Total actual spend on above-the-line costs (creative talent, rights). Tracks the most strategically sensitive cost category."
    - name: "union_labor_actual_amount"
      expr: SUM(CASE WHEN is_union_labor = TRUE THEN CAST(actual_amount AS DOUBLE) ELSE 0 END)
      comment: "Total actual spend on union labor. Supports guild compliance reporting and labor cost management."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_cost_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transactional cost KPIs for production spend — payment status, invoice aging, tax exposure, and FX impact. Used by production finance and accounts payable to manage vendor payments, cash flow, and cost reporting accuracy."
  source: "`vibe_media_broadcasting_v1`.`production`.`cost_transaction`"
  dimensions:
    - name: "cost_category_name"
      expr: cost_category_name
      comment: "Name of the cost category for the transaction. Enables category-level spend analysis."
    - name: "cost_category_code"
      expr: cost_category_code
      comment: "Code for the cost category. Supports financial system integration and standardized reporting."
    - name: "production_phase"
      expr: production_phase
      comment: "Production phase when the cost was incurred. Enables phase-level cost flow analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the transaction (e.g., paid, pending, overdue). Critical for accounts payable management."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment used (e.g., wire, check, ACH). Supports payment process analysis and fraud monitoring."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the cost transaction. Supports annual financial reporting and period-end close."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the cost transaction. Enables period-level cost accrual and reporting."
    - name: "payee_name"
      expr: payee_name
      comment: "Name of the vendor or payee. Enables vendor-level spend concentration analysis."
    - name: "transaction_date_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of the cost transaction. Enables monthly spend trend analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month the transaction was posted to the ledger. Supports period-end financial close analysis."
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total gross transaction amount across all cost transactions. Primary spend volume metric for production cost management."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after adjustments. Tracks net cost exposure for financial reporting."
    - name: "total_reporting_currency_amount"
      expr: SUM(CAST(reporting_currency_amount AS DOUBLE))
      comment: "Total spend converted to reporting currency. Enables consolidated financial reporting across multi-currency productions."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across cost transactions. Supports tax liability reporting and reclaim analysis."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of cost transactions. Baseline measure for transaction volume and processing throughput."
    - name: "pending_payment_count"
      expr: COUNT(CASE WHEN payment_status = 'pending' THEN 1 END)
      comment: "Number of transactions with pending payment status. Tracks accounts payable backlog for cash flow management."
    - name: "pending_payment_amount"
      expr: SUM(CASE WHEN payment_status = 'pending' THEN CAST(transaction_amount AS DOUBLE) ELSE 0 END)
      comment: "Total amount of transactions with pending payment. Quantifies outstanding payables for cash flow planning."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to cost transactions. Monitors FX rate exposure for international production cost management."
    - name: "distinct_payee_count"
      expr: COUNT(DISTINCT payee_name)
      comment: "Number of distinct vendors/payees. Measures vendor base breadth for procurement and vendor management analysis."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_crew_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crew workforce KPIs for production — labor cost rates, union composition, overtime eligibility, per diem exposure, and work permit compliance. Used by production managers and HR to manage crew costs, compliance, and scheduling."
  source: "`vibe_media_broadcasting_v1`.`production`.`crew_assignment`"
  dimensions:
    - name: "department"
      expr: department
      comment: "Production department of the crew member (e.g., camera, sound, art). Enables department-level workforce and cost analysis."
    - name: "role_title"
      expr: role_title
      comment: "Job title/role of the crew member. Supports role-level rate benchmarking and headcount analysis."
    - name: "union_guild_affiliation"
      expr: union_guild_affiliation
      comment: "Union or guild the crew member is affiliated with (e.g., IATSE, SAG-AFTRA). Enables union labor compliance and cost analysis."
    - name: "filming_location_country"
      expr: filming_location_country
      comment: "Country where filming takes place for this assignment. Supports international labor cost and compliance analysis."
    - name: "production_company"
      expr: production_company
      comment: "Production company associated with the crew assignment. Enables entity-level workforce analysis for co-productions."
    - name: "overtime_eligible"
      expr: overtime_eligible
      comment: "Indicates whether the crew member is eligible for overtime pay. Enables overtime cost exposure analysis."
    - name: "residuals_eligible"
      expr: residuals_eligible
      comment: "Indicates whether the crew member is eligible for residual payments. Tracks long-term labor cost obligations."
    - name: "work_permit_required"
      expr: work_permit_required
      comment: "Indicates whether a work permit is required for this assignment. Supports compliance monitoring for international crew."
    - name: "safety_training_certified"
      expr: safety_training_certified
      comment: "Indicates whether the crew member has completed required safety training. Supports on-set safety compliance tracking."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the crew assignment starts. Enables monthly crew deployment and cost phasing analysis."
  measures:
    - name: "total_crew_assignments"
      expr: COUNT(1)
      comment: "Total number of crew assignments. Baseline measure for workforce deployment volume across productions."
    - name: "distinct_crew_members"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct crew members deployed. Measures actual headcount for workforce planning and capacity management."
    - name: "total_contracted_rate"
      expr: SUM(CAST(contracted_rate AS DOUBLE))
      comment: "Total contracted daily/weekly rate across all crew assignments. Aggregate labor cost commitment for production budgeting."
    - name: "avg_contracted_rate"
      expr: AVG(CAST(contracted_rate AS DOUBLE))
      comment: "Average contracted rate per crew assignment. Benchmarks labor rates for negotiation and future budget planning."
    - name: "total_per_diem_rate"
      expr: SUM(CAST(per_diem_rate AS DOUBLE))
      comment: "Total per diem allowance across crew assignments. Tracks travel and living expense obligations for location shoots."
    - name: "total_travel_allowance"
      expr: SUM(CAST(travel_allowance AS DOUBLE))
      comment: "Total travel allowance committed across crew assignments. Quantifies travel cost exposure for location productions."
    - name: "total_box_rental_rate"
      expr: SUM(CAST(box_rental_rate AS DOUBLE))
      comment: "Total box/equipment rental rate paid to crew. Tracks equipment-related labor cost components."
    - name: "total_kit_rental_rate"
      expr: SUM(CAST(kit_rental_rate AS DOUBLE))
      comment: "Total kit rental rate paid to crew. Monitors kit rental cost exposure across the production."
    - name: "overtime_eligible_crew_count"
      expr: COUNT(CASE WHEN overtime_eligible = TRUE THEN 1 END)
      comment: "Number of crew assignments eligible for overtime. Quantifies overtime cost exposure for production scheduling decisions."
    - name: "residuals_eligible_crew_count"
      expr: COUNT(CASE WHEN residuals_eligible = TRUE THEN 1 END)
      comment: "Number of crew assignments eligible for residuals. Tracks long-term labor cost obligations beyond the production period."
    - name: "work_permit_required_count"
      expr: COUNT(CASE WHEN work_permit_required = TRUE THEN 1 END)
      comment: "Number of crew assignments requiring work permits. Supports compliance risk monitoring for international productions."
    - name: "safety_certified_crew_count"
      expr: COUNT(CASE WHEN safety_training_certified = TRUE THEN 1 END)
      comment: "Number of crew members with valid safety training certification. Tracks on-set safety compliance for risk management."
    - name: "avg_overtime_rate_multiplier"
      expr: AVG(CAST(overtime_rate_multiplier AS DOUBLE))
      comment: "Average overtime rate multiplier across eligible crew. Benchmarks overtime cost burden for labor cost modeling."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_deliverable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deliverable quality and timeliness KPIs — QC pass rates, delivery schedule adherence, file size, and compliance flags. Used by post-production supervisors and distribution teams to ensure on-time, compliant content delivery."
  source: "`vibe_media_broadcasting_v1`.`production`.`deliverable`"
  dimensions:
    - name: "delivery_location"
      expr: delivery_location
      comment: "Destination location for the deliverable. Enables delivery channel and platform analysis."
    - name: "audio_channels"
      expr: audio_channels
      comment: "Audio channel configuration of the deliverable (e.g., stereo, 5.1). Supports technical specification compliance analysis."
    - name: "qc_pass_flag"
      expr: qc_pass_flag
      comment: "Indicates whether the deliverable passed quality control. Primary quality gate metric for content delivery."
    - name: "closed_caption_flag"
      expr: closed_caption_flag
      comment: "Indicates whether closed captions are included. Supports accessibility compliance monitoring."
    - name: "audio_description_flag"
      expr: audio_description_flag
      comment: "Indicates whether audio description track is included. Supports accessibility compliance monitoring."
    - name: "compliance_certificate_flag"
      expr: compliance_certificate_flag
      comment: "Indicates whether a compliance certificate has been issued. Tracks regulatory clearance for distribution."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the deliverable is due. Enables monthly delivery pipeline and workload analysis."
    - name: "revision_number"
      expr: revision_number
      comment: "Revision number of the deliverable. Tracks rework cycles and quality iteration costs."
  measures:
    - name: "total_deliverables"
      expr: COUNT(1)
      comment: "Total number of deliverables. Baseline measure for delivery pipeline volume and throughput."
    - name: "qc_passed_count"
      expr: COUNT(CASE WHEN qc_pass_flag = TRUE THEN 1 END)
      comment: "Number of deliverables that passed QC. Tracks quality throughput for post-production performance management."
    - name: "qc_failed_count"
      expr: COUNT(CASE WHEN qc_pass_flag = FALSE THEN 1 END)
      comment: "Number of deliverables that failed QC. Identifies quality issues requiring remediation and rework cost."
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_timestamp <= scheduled_delivery_timestamp AND actual_delivery_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of deliverables delivered on or before the scheduled timestamp. Measures delivery schedule adherence."
    - name: "late_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_timestamp > scheduled_delivery_timestamp THEN 1 END)
      comment: "Number of deliverables delivered after the scheduled timestamp. Tracks delivery schedule failures for operational intervention."
    - name: "total_deliverable_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of all deliverables. Tracks post-production and delivery cost for financial management."
    - name: "avg_deliverable_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per deliverable. Benchmarks delivery cost efficiency for budget planning."
    - name: "total_file_size_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total file size of all deliverables in bytes. Supports storage capacity planning and distribution bandwidth management."
    - name: "avg_duration_seconds"
      expr: AVG(CAST(duration_seconds AS DOUBLE))
      comment: "Average duration of deliverables in seconds. Benchmarks content length for scheduling and distribution planning."
    - name: "compliance_certified_count"
      expr: COUNT(CASE WHEN compliance_certificate_flag = TRUE THEN 1 END)
      comment: "Number of deliverables with compliance certificates issued. Tracks regulatory clearance readiness for distribution."
    - name: "closed_caption_compliant_count"
      expr: COUNT(CASE WHEN closed_caption_flag = TRUE THEN 1 END)
      comment: "Number of deliverables with closed captions. Monitors accessibility compliance across the delivery pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_qc_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality control review KPIs — error rates, review throughput, loudness compliance, and remediation rates. Used by QC supervisors and technical operations to maintain broadcast and streaming technical standards."
  source: "`vibe_media_broadcasting_v1`.`production`.`qc_review`"
  dimensions:
    - name: "qc_result"
      expr: qc_result
      comment: "Overall result of the QC review (e.g., pass, fail, conditional pass). Primary quality outcome dimension."
    - name: "qc_platform"
      expr: qc_platform
      comment: "Platform or tool used to perform the QC review. Enables platform-level quality performance analysis."
    - name: "video_codec"
      expr: video_codec
      comment: "Video codec of the reviewed asset. Supports codec-level quality and compliance analysis."
    - name: "audio_codec"
      expr: audio_codec
      comment: "Audio codec of the reviewed asset. Supports audio technical compliance analysis."
    - name: "video_resolution"
      expr: video_resolution
      comment: "Video resolution of the reviewed asset (e.g., 1080p, 4K). Enables resolution-level quality tracking."
    - name: "audio_channel_configuration"
      expr: audio_channel_configuration
      comment: "Audio channel configuration of the reviewed asset. Supports audio compliance monitoring."
    - name: "loudness_compliance_flag"
      expr: loudness_compliance_flag
      comment: "Indicates whether the asset meets loudness standards (e.g., EBU R128, ATSC A/85). Critical broadcast compliance KPI."
    - name: "closed_caption_compliance_flag"
      expr: closed_caption_compliance_flag
      comment: "Indicates whether closed captions meet compliance standards. Tracks accessibility regulatory compliance."
    - name: "audio_description_compliance_flag"
      expr: audio_description_compliance_flag
      comment: "Indicates whether audio description meets compliance standards. Tracks accessibility regulatory compliance."
    - name: "remediation_required_flag"
      expr: remediation_required_flag
      comment: "Indicates whether remediation is required following the QC review. Tracks rework volume and post-production cost impact."
    - name: "review_date_month"
      expr: DATE_TRUNC('MONTH', review_date)
      comment: "Month the QC review was conducted. Enables monthly QC throughput and quality trend analysis."
  measures:
    - name: "total_qc_reviews"
      expr: COUNT(1)
      comment: "Total number of QC reviews conducted. Baseline measure for QC throughput and team capacity utilization."
    - name: "qc_pass_count"
      expr: COUNT(CASE WHEN qc_result = 'pass' THEN 1 END)
      comment: "Number of QC reviews with a pass result. Tracks quality throughput for post-production performance management."
    - name: "qc_fail_count"
      expr: COUNT(CASE WHEN qc_result = 'fail' THEN 1 END)
      comment: "Number of QC reviews with a fail result. Identifies quality failure volume requiring remediation and rework."
    - name: "remediation_required_count"
      expr: COUNT(CASE WHEN remediation_required_flag = TRUE THEN 1 END)
      comment: "Number of QC reviews requiring remediation. Quantifies rework volume and associated post-production cost impact."
    - name: "loudness_non_compliant_count"
      expr: COUNT(CASE WHEN loudness_compliance_flag = FALSE THEN 1 END)
      comment: "Number of assets failing loudness compliance standards. Critical broadcast regulatory KPI — non-compliance risks broadcast penalties."
    - name: "avg_review_duration_minutes"
      expr: AVG(CAST(review_duration_minutes AS DOUBLE))
      comment: "Average time spent per QC review in minutes. Benchmarks QC team efficiency and capacity planning."
    - name: "total_review_duration_minutes"
      expr: SUM(CAST(review_duration_minutes AS DOUBLE))
      comment: "Total QC review time in minutes. Measures overall QC team workload for resource planning."
    - name: "avg_loudness_lufs"
      expr: AVG(CAST(loudness_lufs AS DOUBLE))
      comment: "Average loudness level in LUFS across reviewed assets. Monitors broadcast loudness compliance against regulatory standards (e.g., EBU R128 target -23 LUFS)."
    - name: "avg_video_frame_rate"
      expr: AVG(CAST(video_frame_rate AS DOUBLE))
      comment: "Average video frame rate across reviewed assets. Supports technical specification compliance monitoring."
    - name: "closed_caption_non_compliant_count"
      expr: COUNT(CASE WHEN closed_caption_compliance_flag = FALSE THEN 1 END)
      comment: "Number of assets failing closed caption compliance. Tracks accessibility regulatory risk across the content pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_shoot_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shoot day efficiency KPIs — actual vs. estimated shoot hours, overtime days, meal penalties, and turnaround compliance. Used by production managers and UPMs to optimize on-set productivity and control labor costs."
  source: "`vibe_media_broadcasting_v1`.`production`.`shoot_schedule`"
  dimensions:
    - name: "production_unit"
      expr: production_unit
      comment: "Production unit (e.g., main unit, second unit). Enables unit-level productivity and cost analysis."
    - name: "is_overtime_day"
      expr: is_overtime_day
      comment: "Indicates whether the shoot day incurred overtime. Enables overtime day frequency and cost analysis."
    - name: "meal_penalty_flag"
      expr: meal_penalty_flag
      comment: "Indicates whether a meal penalty was incurred on this shoot day. Tracks labor compliance violations and associated costs."
    - name: "weather_contingency_flag"
      expr: weather_contingency_flag
      comment: "Indicates whether weather contingency was invoked. Tracks weather-related production disruptions."
    - name: "shoot_date_month"
      expr: DATE_TRUNC('MONTH', shoot_date)
      comment: "Month of the shoot date. Enables monthly production activity and cost phasing analysis."
    - name: "shoot_date_year"
      expr: YEAR(shoot_date)
      comment: "Year of the shoot date. Supports annual production activity analysis."
  measures:
    - name: "total_shoot_days"
      expr: COUNT(1)
      comment: "Total number of scheduled shoot days. Baseline measure for production activity volume and schedule density."
    - name: "total_actual_shoot_hours"
      expr: SUM(CAST(actual_shoot_hours AS DOUBLE))
      comment: "Total actual hours spent shooting. Measures on-set production time for efficiency and cost analysis."
    - name: "total_estimated_shoot_hours"
      expr: SUM(CAST(estimated_shoot_hours AS DOUBLE))
      comment: "Total estimated shoot hours from the schedule. Baseline for actual vs. planned shoot time comparison."
    - name: "avg_actual_shoot_hours"
      expr: AVG(CAST(actual_shoot_hours AS DOUBLE))
      comment: "Average actual shoot hours per day. Benchmarks daily production efficiency for scheduling optimization."
    - name: "shoot_hour_variance"
      expr: SUM(CAST(actual_shoot_hours AS DOUBLE) - CAST(estimated_shoot_hours AS DOUBLE))
      comment: "Total variance between actual and estimated shoot hours (positive = over schedule). Key production efficiency KPI for UPMs."
    - name: "overtime_day_count"
      expr: COUNT(CASE WHEN is_overtime_day = TRUE THEN 1 END)
      comment: "Number of shoot days that incurred overtime. Tracks overtime frequency for labor cost and crew welfare management."
    - name: "meal_penalty_day_count"
      expr: COUNT(CASE WHEN meal_penalty_flag = TRUE THEN 1 END)
      comment: "Number of shoot days with meal penalties. Tracks labor compliance violations and associated penalty costs."
    - name: "weather_contingency_day_count"
      expr: COUNT(CASE WHEN weather_contingency_flag = TRUE THEN 1 END)
      comment: "Number of shoot days where weather contingency was invoked. Quantifies weather-related production disruption for risk planning."
    - name: "avg_turnaround_hours"
      expr: AVG(CAST(turnaround_hours AS DOUBLE))
      comment: "Average crew turnaround hours between shoot days. Monitors crew rest compliance — below-minimum turnaround triggers union penalties and safety risks."
    - name: "total_pages_shot"
      expr: SUM(CAST(page_count AS DOUBLE))
      comment: "Total script pages shot across all shoot days. Measures production throughput against the script for schedule efficiency analysis."
    - name: "avg_pages_per_day"
      expr: AVG(CAST(page_count AS DOUBLE))
      comment: "Average script pages shot per day. Industry-standard production efficiency metric — benchmarks against typical 3-5 pages/day target."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_facility_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility utilization and cost KPIs — booking cost efficiency, cancellation rates, overtime usage, and actual vs. estimated cost variance. Used by production managers to optimize facility spend and scheduling."
  source: "`vibe_media_broadcasting_v1`.`production`.`facility_booking`"
  dimensions:
    - name: "facility_location"
      expr: facility_location
      comment: "Location of the booked facility. Enables facility-level cost and utilization analysis."
    - name: "production_phase"
      expr: production_phase
      comment: "Production phase for which the facility is booked. Enables phase-level facility cost analysis."
    - name: "rate_type"
      expr: rate_type
      comment: "Rate type for the facility booking (e.g., hourly, daily, weekly). Supports rate structure analysis and negotiation."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Indicates whether the facility is booked exclusively. Enables exclusive vs. shared booking cost comparison."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for booking cancellation. Enables root cause analysis of cancellation costs and schedule disruptions."
    - name: "booking_start_month"
      expr: DATE_TRUNC('MONTH', booking_start)
      comment: "Month the facility booking starts. Enables monthly facility utilization and cost phasing analysis."
  measures:
    - name: "total_facility_bookings"
      expr: COUNT(1)
      comment: "Total number of facility bookings. Baseline measure for facility utilization volume."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of facility bookings. Primary facility spend metric for production cost management."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of facility bookings. Baseline for actual vs. estimated cost variance analysis."
    - name: "total_cost_variance"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(estimated_cost AS DOUBLE))
      comment: "Total variance between actual and estimated facility costs (positive = over budget). Tracks facility cost estimation accuracy."
    - name: "total_cancellation_fee"
      expr: SUM(CAST(cancellation_fee AS DOUBLE))
      comment: "Total cancellation fees incurred. Quantifies the financial cost of booking cancellations for schedule change management."
    - name: "cancelled_booking_count"
      expr: COUNT(CASE WHEN cancellation_date IS NOT NULL THEN 1 END)
      comment: "Number of cancelled facility bookings. Tracks cancellation frequency for schedule stability analysis."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours incurred at booked facilities. Tracks facility overtime cost exposure for budget management."
    - name: "avg_rate_amount"
      expr: AVG(CAST(rate_amount AS DOUBLE))
      comment: "Average facility rate amount. Benchmarks facility costs for negotiation and future budget planning."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_equipment_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment utilization and cost KPIs — rental costs, damage claims, insurance exposure, and owned vs. rented asset mix. Used by production managers to optimize equipment spend and manage asset risk."
  source: "`vibe_media_broadcasting_v1`.`production`.`equipment_allocation`"
  dimensions:
    - name: "equipment_name"
      expr: equipment_name
      comment: "Name of the allocated equipment. Enables equipment-level utilization and cost analysis."
    - name: "production_department"
      expr: production_department
      comment: "Production department using the equipment. Enables department-level equipment cost analysis."
    - name: "rental_rate_type"
      expr: rental_rate_type
      comment: "Rate type for equipment rental (e.g., daily, weekly). Supports rate structure optimization."
    - name: "is_owned_asset"
      expr: is_owned_asset
      comment: "Indicates whether the equipment is owned vs. rented. Enables owned vs. rented asset cost comparison for make-vs-buy decisions."
    - name: "is_insurance_required"
      expr: is_insurance_required
      comment: "Indicates whether insurance is required for the equipment. Supports insurance cost and compliance tracking."
    - name: "checkout_condition"
      expr: checkout_condition
      comment: "Condition of equipment at checkout. Enables damage rate analysis by initial condition."
    - name: "allocation_start_month"
      expr: DATE_TRUNC('MONTH', allocation_start_date)
      comment: "Month the equipment allocation starts. Enables monthly equipment utilization and cost phasing analysis."
  measures:
    - name: "total_equipment_allocations"
      expr: COUNT(1)
      comment: "Total number of equipment allocations. Baseline measure for equipment utilization volume across productions."
    - name: "total_rental_cost"
      expr: SUM(CAST(rental_rate_amount AS DOUBLE))
      comment: "Total equipment rental cost across all allocations. Primary equipment spend metric for production cost management."
    - name: "avg_rental_rate"
      expr: AVG(CAST(rental_rate_amount AS DOUBLE))
      comment: "Average equipment rental rate. Benchmarks equipment costs for negotiation and future budget planning."
    - name: "total_damage_claim_amount"
      expr: SUM(CAST(damage_claim_amount AS DOUBLE))
      comment: "Total damage claim amount across equipment allocations. Tracks equipment damage cost exposure for risk management."
    - name: "damage_claim_count"
      expr: COUNT(CASE WHEN damage_claim_amount > 0 THEN 1 END)
      comment: "Number of equipment allocations with damage claims. Measures equipment damage frequency for asset management."
    - name: "total_insurance_value"
      expr: SUM(CAST(insurance_value AS DOUBLE))
      comment: "Total insured value of allocated equipment. Quantifies insurance exposure for risk management and premium optimization."
    - name: "owned_asset_count"
      expr: COUNT(CASE WHEN is_owned_asset = TRUE THEN 1 END)
      comment: "Number of allocations using owned assets. Tracks owned asset utilization for capital investment justification."
    - name: "rented_asset_count"
      expr: COUNT(CASE WHEN is_owned_asset = FALSE THEN 1 END)
      comment: "Number of allocations using rented assets. Measures rental dependency for make-vs-buy equipment strategy decisions."
$$;