-- Metric views for domain: engineering | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 10:21:17

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for engineering projects — budget performance, schedule adherence, and portfolio health. Used by engineering leadership and PMO to steer investment decisions and resource allocation."
  source: "`vibe_manufacturing_v1`.`engineering`.`project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current lifecycle status of the project (e.g. Active, On Hold, Completed, Cancelled) — primary filter for portfolio health dashboards."
    - name: "project_type"
      expr: project_type
      comment: "Classification of the project type (e.g. New Product Development, Cost Reduction, Sustaining Engineering) — used to segment investment by strategic intent."
    - name: "priority_level"
      expr: priority_level
      comment: "Business priority assigned to the project (e.g. High, Medium, Low) — used to triage resource allocation."
    - name: "program_phase"
      expr: program_phase
      comment: "Current phase of the product development program (e.g. Concept, Design, Prototype, Launch) — used to track portfolio stage-gate progression."
    - name: "risk_level"
      expr: risk_level
      comment: "Assessed risk level of the project — used by leadership to identify projects requiring intervention."
    - name: "capex_opex_classification"
      expr: capex_opex_classification
      comment: "Whether the project spend is classified as capital expenditure or operating expenditure — critical for financial reporting."
    - name: "design_methodology"
      expr: design_methodology
      comment: "Engineering design methodology applied (e.g. Agile, Stage-Gate, DFSS) — used to evaluate methodology effectiveness."
    - name: "target_market_segment"
      expr: target_market_segment
      comment: "Market segment the project is targeting — used to align engineering investment with commercial strategy."
    - name: "technology_platform"
      expr: technology_platform
      comment: "Technology platform underpinning the project — used to track platform-level investment and reuse."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the project started — used for cohort and trend analysis of project launches."
    - name: "target_launch_date_month"
      expr: DATE_TRUNC('MONTH', target_launch_date)
      comment: "Month the project is targeted to launch — used for pipeline and capacity planning."
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of engineering projects in the portfolio — baseline measure for portfolio size and workload."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated across all engineering projects — key input for investment governance and financial planning."
    - name: "total_budget_spent"
      expr: SUM(CAST(budget_spent_amount AS DOUBLE))
      comment: "Total budget consumed across all engineering projects — used to track actual spend against plan."
    - name: "avg_budget_utilization_pct"
      expr: AVG(ROUND(100.0 * CAST(budget_spent_amount AS DOUBLE) / NULLIF(CAST(budget_allocated_amount AS DOUBLE), 0), 2))
      comment: "Average budget utilization percentage per project — measures how efficiently project budgets are being consumed; high values signal overrun risk."
    - name: "budget_variance"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE) - CAST(budget_spent_amount AS DOUBLE))
      comment: "Aggregate remaining budget (allocated minus spent) across all projects — negative values indicate portfolio-level budget overrun."
    - name: "projects_with_dfm_completed"
      expr: COUNT(CASE WHEN dfm_analysis_completed = TRUE THEN 1 END)
      comment: "Number of projects where Design for Manufacturability analysis has been completed — indicates engineering quality maturity."
    - name: "dfm_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dfm_analysis_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of projects with DFM analysis completed — a leading indicator of downstream manufacturing quality and cost."
    - name: "projects_with_ppap_required"
      expr: COUNT(CASE WHEN ppap_required = TRUE THEN 1 END)
      comment: "Number of projects requiring Production Part Approval Process — used to plan quality and supplier qualification workload."
    - name: "projects_launched_on_time"
      expr: COUNT(CASE WHEN actual_launch_date <= target_launch_date AND actual_launch_date IS NOT NULL THEN 1 END)
      comment: "Number of projects that launched on or before their target launch date — measures schedule adherence."
    - name: "on_time_launch_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_launch_date <= target_launch_date AND actual_launch_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_launch_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of completed projects launched on or before target date — a key engineering execution KPI tracked at QBRs."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_eco`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering Change Order (ECO) performance metrics — cycle time, cost impact, and change volume. Used by engineering managers and quality leaders to govern the change management process and reduce change-driven disruption."
  source: "`vibe_manufacturing_v1`.`engineering`.`eco`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current status of the ECO (e.g. Draft, Under Review, Approved, Implemented, Closed) — primary filter for change pipeline management."
    - name: "change_type"
      expr: change_type
      comment: "Type of engineering change (e.g. Design, Process, Material, Documentation) — used to categorize change volume by impact area."
    - name: "change_priority"
      expr: change_priority
      comment: "Priority assigned to the ECO (e.g. Critical, High, Medium, Low) — used to triage and expedite high-impact changes."
    - name: "reason_code"
      expr: reason_code
      comment: "Root cause category driving the engineering change — used for Pareto analysis of change drivers."
    - name: "effectivity_type"
      expr: effectivity_type
      comment: "How the change takes effect (e.g. Date-based, Serial Number, Lot) — used to plan implementation logistics."
    - name: "initiator_department"
      expr: initiator_department
      comment: "Department that initiated the ECO — used to identify which functions are generating the most engineering changes."
    - name: "requires_customer_approval"
      expr: requires_customer_approval
      comment: "Whether the ECO requires customer sign-off before implementation — flags changes with external dependency and longer cycle times."
    - name: "initiated_date_month"
      expr: DATE_TRUNC('MONTH', initiated_date)
      comment: "Month the ECO was initiated — used for trend analysis of change volume over time."
    - name: "effectivity_date_month"
      expr: DATE_TRUNC('MONTH', effectivity_date)
      comment: "Month the change becomes effective — used for implementation planning and capacity forecasting."
  measures:
    - name: "total_ecos"
      expr: COUNT(1)
      comment: "Total number of Engineering Change Orders — baseline measure of change management workload and engineering volatility."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Total estimated cost impact of all ECOs — used by finance and engineering leadership to quantify the financial exposure from engineering changes."
    - name: "total_actual_cost_impact"
      expr: SUM(CAST(actual_cost_impact AS DOUBLE))
      comment: "Total actual cost impact realized from implemented ECOs — compared against estimates to assess change cost forecasting accuracy."
    - name: "cost_impact_variance"
      expr: SUM(CAST(actual_cost_impact AS DOUBLE) - CAST(estimated_cost_impact AS DOUBLE))
      comment: "Aggregate variance between actual and estimated cost impact — positive values indicate cost overruns in the change process."
    - name: "avg_eco_cycle_time_days"
      expr: AVG(DATEDIFF(closure_date, initiated_date))
      comment: "Average number of days from ECO initiation to closure — a key process efficiency KPI; high values indicate bottlenecks in the change approval workflow."
    - name: "avg_implementation_lead_time_days"
      expr: AVG(DATEDIFF(implementation_date, approval_date))
      comment: "Average days from ECO approval to implementation — measures execution speed after approval; used to identify post-approval delays."
    - name: "ecos_requiring_customer_approval"
      expr: COUNT(CASE WHEN requires_customer_approval = TRUE THEN 1 END)
      comment: "Number of ECOs that require customer approval — used to manage customer-facing change communication workload."
    - name: "customer_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN customer_approval_received = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN requires_customer_approval = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of ECOs requiring customer approval that have received it — tracks customer change approval throughput."
    - name: "avg_estimated_cost_impact"
      expr: AVG(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Average estimated cost impact per ECO — used to benchmark the typical financial weight of engineering changes."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_ecn`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering Change Notice (ECN) distribution and impact metrics — tracks change notification effectiveness, regulatory exposure, and BOM/inventory impact. Used by engineering, supply chain, and compliance teams."
  source: "`vibe_manufacturing_v1`.`engineering`.`ecn`"
  dimensions:
    - name: "ecn_status"
      expr: ecn_status
      comment: "Current status of the ECN (e.g. Draft, Released, Superseded) — primary filter for active change notice management."
    - name: "ecn_type"
      expr: ecn_type
      comment: "Type of engineering change notice — used to categorize notices by scope and urgency."
    - name: "change_category"
      expr: change_category
      comment: "Category of the change described in the ECN — used for Pareto analysis of change drivers."
    - name: "priority"
      expr: priority
      comment: "Priority level of the ECN — used to triage and expedite critical change communications."
    - name: "erp_sync_status"
      expr: erp_sync_status
      comment: "Status of ERP system synchronization for this ECN — used to identify ECNs not yet reflected in production systems."
    - name: "mes_sync_status"
      expr: mes_sync_status
      comment: "Status of MES system synchronization — used to ensure shop floor systems reflect the latest engineering changes."
    - name: "bom_impact_flag"
      expr: bom_impact_flag
      comment: "Whether the ECN impacts the Bill of Materials — used to prioritize ECNs requiring BOM updates."
    - name: "regulatory_impact_flag"
      expr: regulatory_impact_flag
      comment: "Whether the ECN has regulatory compliance implications — used to flag changes requiring compliance review."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the ECN becomes effective — used for change implementation planning."
    - name: "release_date_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month the ECN was released — used for trend analysis of change release cadence."
  measures:
    - name: "total_ecns"
      expr: COUNT(1)
      comment: "Total number of Engineering Change Notices — baseline measure of change communication volume."
    - name: "total_cost_impact_estimate"
      expr: SUM(CAST(cost_impact_estimate AS DOUBLE))
      comment: "Total estimated cost impact across all ECNs — used by finance to quantify the financial exposure from pending engineering changes."
    - name: "avg_cost_impact_per_ecn"
      expr: AVG(CAST(cost_impact_estimate AS DOUBLE))
      comment: "Average estimated cost impact per ECN — benchmarks the typical financial weight of change notices."
    - name: "ecns_with_bom_impact"
      expr: COUNT(CASE WHEN bom_impact_flag = TRUE THEN 1 END)
      comment: "Number of ECNs that impact the Bill of Materials — used to plan BOM update workload for engineering and ERP teams."
    - name: "ecns_with_regulatory_impact"
      expr: COUNT(CASE WHEN regulatory_impact_flag = TRUE THEN 1 END)
      comment: "Number of ECNs with regulatory compliance implications — used by compliance teams to prioritize review and approval activities."
    - name: "ecns_with_inventory_impact"
      expr: COUNT(CASE WHEN inventory_impact_flag = TRUE THEN 1 END)
      comment: "Number of ECNs that impact existing inventory — used by supply chain to plan disposition of affected stock."
    - name: "acknowledgement_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN acknowledgement_required = FALSE OR acknowledgement_count = acknowledgement_target_count THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ECNs where all required acknowledgements have been received — measures change communication effectiveness."
    - name: "ecns_pending_erp_sync"
      expr: COUNT(CASE WHEN erp_sync_status != 'SYNCED' AND erp_sync_status IS NOT NULL THEN 1 END)
      comment: "Number of ECNs not yet synchronized to ERP — a critical operational risk metric; unsynced ECNs mean production systems are out of date."
    - name: "avg_ecn_implementation_cycle_days"
      expr: AVG(DATEDIFF(implementation_date, effective_date))
      comment: "Average days between ECN effective date and implementation date — measures how quickly changes are operationalized after release."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_bom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of Materials (BOM) quality, cost, and complexity metrics. Used by engineering, manufacturing, and finance to govern BOM accuracy, cost estimation, and structural complexity."
  source: "`vibe_manufacturing_v1`.`engineering`.`bom`"
  dimensions:
    - name: "bom_status"
      expr: bom_status
      comment: "Current status of the BOM (e.g. Draft, Released, Obsolete) — primary filter for active BOM management."
    - name: "bom_type"
      expr: bom_type
      comment: "Type of BOM (e.g. Engineering, Manufacturing, Sales) — used to segment BOM metrics by lifecycle stage."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the BOM — used to identify BOMs pending release authorization."
    - name: "category"
      expr: category
      comment: "Product category associated with the BOM — used to analyze BOM complexity and cost by product line."
    - name: "explosion_type"
      expr: explosion_type
      comment: "BOM explosion method (e.g. Single-level, Multi-level, Summarized) — used to understand BOM structure depth."
    - name: "is_configurable"
      expr: is_configurable
      comment: "Whether the BOM supports product configuration variants — used to identify configurable product complexity."
    - name: "is_critical_bom"
      expr: is_critical_bom
      comment: "Whether the BOM is flagged as critical — used to prioritize governance and review activities."
    - name: "base_unit_of_measure"
      expr: base_unit_of_measure
      comment: "Base unit of measure for the BOM — used to ensure consistency in quantity and cost calculations."
    - name: "approved_date_month"
      expr: DATE_TRUNC('MONTH', approved_date)
      comment: "Month the BOM was approved — used for trend analysis of BOM release cadence."
    - name: "effective_from_date_month"
      expr: DATE_TRUNC('MONTH', effective_from_date)
      comment: "Month the BOM becomes effective — used for production planning and change management."
  measures:
    - name: "total_boms"
      expr: COUNT(1)
      comment: "Total number of BOMs in the engineering repository — baseline measure of BOM portfolio size."
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate_total AS DOUBLE))
      comment: "Total estimated cost across all BOMs — used by finance and engineering to track aggregate product cost exposure."
    - name: "avg_cost_estimate_per_bom"
      expr: AVG(CAST(cost_estimate_total AS DOUBLE))
      comment: "Average estimated cost per BOM — benchmarks typical product cost and identifies outliers requiring cost reduction focus."
    - name: "avg_scrap_percentage"
      expr: AVG(CAST(scrap_percentage AS DOUBLE))
      comment: "Average scrap percentage across all BOMs — a key manufacturing efficiency indicator; high values signal material waste and cost overrun risk."
    - name: "total_weight"
      expr: SUM(CAST(weight_total AS DOUBLE))
      comment: "Total weight across all BOM assemblies — used for logistics, packaging, and sustainability analysis."
    - name: "avg_lot_size"
      expr: AVG(CAST(lot_size AS DOUBLE))
      comment: "Average production lot size across BOMs — used for production planning and inventory optimization."
    - name: "critical_bom_count"
      expr: COUNT(CASE WHEN is_critical_bom = TRUE THEN 1 END)
      comment: "Number of BOMs flagged as critical — used to prioritize governance, review, and change control activities."
    - name: "configurable_bom_count"
      expr: COUNT(CASE WHEN is_configurable = TRUE THEN 1 END)
      comment: "Number of configurable BOMs — used to assess product variant complexity and configure-to-order capability."
    - name: "bom_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of BOMs in approved status — measures BOM governance health; low values indicate a backlog in the approval process."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_component`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Component portfolio health, compliance, and cost metrics. Used by engineering, procurement, and quality teams to manage component lifecycle, regulatory compliance, and cost performance."
  source: "`vibe_manufacturing_v1`.`engineering`.`component`"
  dimensions:
    - name: "component_type"
      expr: component_type
      comment: "Type of component (e.g. Mechanical, Electrical, Software, Purchased) — primary segmentation for component portfolio analysis."
    - name: "lifecycle_phase"
      expr: lifecycle_phase
      comment: "Current lifecycle phase of the component (e.g. Active, Obsolete, Phase-Out, New) — used to manage component obsolescence risk."
    - name: "make_or_buy"
      expr: make_or_buy
      comment: "Whether the component is manufactured in-house or purchased — used for make-vs-buy strategic analysis."
    - name: "release_status"
      expr: release_status
      comment: "Engineering release status of the component — used to identify components pending release authorization."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC inventory classification of the component — used to prioritize management attention on high-value components."
    - name: "technology_family"
      expr: technology_family
      comment: "Technology family the component belongs to — used for platform-level component reuse and standardization analysis."
    - name: "functional_group"
      expr: functional_group
      comment: "Functional group or subsystem the component belongs to — used for subsystem-level cost and quality analysis."
    - name: "rohs_compliant_flag"
      expr: rohs_compliant_flag
      comment: "Whether the component is RoHS compliant — critical for regulatory compliance reporting and market access."
    - name: "reach_compliant_flag"
      expr: reach_compliant_flag
      comment: "Whether the component is REACH compliant — used for EU regulatory compliance tracking."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Whether the component contains hazardous materials — used for EHS compliance and supply chain risk management."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the component became effective — used for trend analysis of new component introductions."
  measures:
    - name: "total_components"
      expr: COUNT(1)
      comment: "Total number of components in the engineering master — baseline measure of component portfolio size and complexity."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost across all components — used by finance and engineering to track aggregate component cost exposure."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per component — benchmarks typical component cost and identifies high-cost outliers for cost reduction focus."
    - name: "rohs_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rohs_compliant_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of components that are RoHS compliant — a mandatory regulatory KPI for electronics manufacturers; non-compliance blocks market access."
    - name: "reach_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reach_compliant_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of components that are REACH compliant — tracks EU chemical regulation compliance across the component portfolio."
    - name: "hazardous_component_count"
      expr: COUNT(CASE WHEN hazardous_material_flag = TRUE THEN 1 END)
      comment: "Number of components containing hazardous materials — used by EHS and supply chain to manage regulatory and logistics risk."
    - name: "obsolete_component_count"
      expr: COUNT(CASE WHEN lifecycle_phase = 'Obsolete' THEN 1 END)
      comment: "Number of components in obsolete lifecycle phase — used to drive component rationalization and substitution programs."
    - name: "avg_dfm_score"
      expr: AVG(CAST(dfm_score AS DOUBLE))
      comment: "Average Design for Manufacturability score across components — a leading indicator of manufacturing cost and quality; low scores predict production issues."
    - name: "avg_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average component weight in kilograms — used for product weight optimization and sustainability target tracking."
    - name: "make_component_count"
      expr: COUNT(CASE WHEN make_or_buy = 'Make' THEN 1 END)
      comment: "Number of components manufactured in-house — used for capacity planning and make-vs-buy strategic review."
    - name: "buy_component_count"
      expr: COUNT(CASE WHEN make_or_buy = 'Buy' THEN 1 END)
      comment: "Number of purchased components — used for supplier base management and procurement workload planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_revision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering revision lifecycle and compliance metrics. Used by engineering managers and quality teams to track design maturity, regulatory compliance readiness, and revision cycle health."
  source: "`vibe_manufacturing_v1`.`engineering`.`revision`"
  dimensions:
    - name: "lifecycle_state"
      expr: lifecycle_state
      comment: "Current lifecycle state of the revision (e.g. In Work, Released, Obsolete) — primary filter for active revision management."
    - name: "revision_type"
      expr: revision_type
      comment: "Type of revision (e.g. Major, Minor, Administrative) — used to categorize change impact and governance requirements."
    - name: "change_impact_level"
      expr: change_impact_level
      comment: "Assessed impact level of the revision change — used to prioritize review and approval resources."
    - name: "change_category"
      expr: change_category
      comment: "Category of the change driving the revision — used for root cause analysis of design instability."
    - name: "regulatory_compliance_status"
      expr: regulatory_compliance_status
      comment: "Regulatory compliance status of the revision — used by compliance teams to track certification readiness."
    - name: "ppap_required"
      expr: ppap_required
      comment: "Whether PPAP is required for this revision — used to plan supplier qualification workload."
    - name: "mass_production_approved"
      expr: mass_production_approved
      comment: "Whether the revision has been approved for mass production — a critical gate metric for product launch readiness."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "Whether the revision is RoHS compliant — mandatory regulatory compliance dimension."
    - name: "release_date_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month the revision was released — used for trend analysis of design release cadence."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the revision becomes effective — used for production planning and change management."
  measures:
    - name: "total_revisions"
      expr: COUNT(1)
      comment: "Total number of engineering revisions — baseline measure of design change volume and engineering instability."
    - name: "revisions_mass_production_approved"
      expr: COUNT(CASE WHEN mass_production_approved = TRUE THEN 1 END)
      comment: "Number of revisions approved for mass production — tracks design maturity and production readiness across the portfolio."
    - name: "mass_production_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mass_production_approved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of revisions approved for mass production — a key product launch readiness KPI used in stage-gate reviews."
    - name: "revisions_with_dfm_completed"
      expr: COUNT(CASE WHEN dfm_analysis_completed = TRUE THEN 1 END)
      comment: "Number of revisions with DFM analysis completed — measures engineering quality process adherence."
    - name: "dfm_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dfm_analysis_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of revisions with DFM analysis completed — a leading indicator of downstream manufacturing quality and cost."
    - name: "revisions_prototype_tested"
      expr: COUNT(CASE WHEN prototype_tested = TRUE THEN 1 END)
      comment: "Number of revisions that have undergone prototype testing — measures design validation thoroughness."
    - name: "prototype_test_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN prototype_tested = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of revisions that have been prototype tested — tracks design validation coverage; low rates indicate quality risk."
    - name: "rohs_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rohs_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of revisions that are RoHS compliant — mandatory regulatory compliance KPI for electronics product lines."
    - name: "avg_revision_active_duration_days"
      expr: AVG(DATEDIFF(effective_end_date, effective_start_date))
      comment: "Average number of days a revision remains active (effective start to end) — measures design stability; short durations indicate high change frequency."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_cad_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CAD model portfolio quality, maturity, and DFM metrics. Used by engineering leads to govern design data quality, track model maturity, and identify manufacturability risks before release."
  source: "`vibe_manufacturing_v1`.`engineering`.`cad_model`"
  dimensions:
    - name: "model_maturity_state"
      expr: model_maturity_state
      comment: "Maturity state of the CAD model (e.g. In Work, Released, Obsolete) — primary filter for active model management."
    - name: "dataset_type"
      expr: dataset_type
      comment: "Type of CAD dataset (e.g. Part, Assembly, Drawing) — used to segment model metrics by design artifact type."
    - name: "file_format"
      expr: file_format
      comment: "CAD file format (e.g. STEP, IGES, NX, CATIA) — used to track authoring tool standardization and interoperability."
    - name: "authoring_tool"
      expr: authoring_tool
      comment: "CAD authoring tool used to create the model — used to manage tool license utilization and standardization."
    - name: "dfm_analysis_status"
      expr: dfm_analysis_status
      comment: "Status of Design for Manufacturability analysis on the model — used to identify models with unresolved manufacturability issues."
    - name: "export_control_classification"
      expr: export_control_classification
      comment: "Export control classification of the CAD model — used for compliance with ITAR/EAR regulations."
    - name: "cam_programming_required"
      expr: cam_programming_required
      comment: "Whether CAM programming is required for this model — used to plan manufacturing engineering workload."
    - name: "is_confidential"
      expr: is_confidential
      comment: "Whether the CAD model is classified as confidential — used for IP protection and access control governance."
    - name: "released_date_month"
      expr: DATE_TRUNC('MONTH', released_timestamp)
      comment: "Month the CAD model was released — used for trend analysis of design release cadence."
  measures:
    - name: "total_cad_models"
      expr: COUNT(1)
      comment: "Total number of CAD models in the engineering vault — baseline measure of design data portfolio size."
    - name: "avg_dfm_complexity_score"
      expr: AVG(CAST(dfm_complexity_score AS DOUBLE))
      comment: "Average DFM complexity score across all CAD models — a leading indicator of manufacturing cost and producibility; high scores predict tooling and process challenges."
    - name: "total_file_size_gb"
      expr: ROUND(SUM(CAST(file_size_bytes AS DOUBLE)) / 1073741824.0, 4)
      comment: "Total CAD vault storage consumed in gigabytes — used for infrastructure capacity planning and vault management."
    - name: "avg_model_mass_kg"
      expr: AVG(CAST(model_mass AS DOUBLE))
      comment: "Average model mass across all CAD models — used for product weight optimization and sustainability target tracking."
    - name: "models_requiring_cam_programming"
      expr: COUNT(CASE WHEN cam_programming_required = TRUE THEN 1 END)
      comment: "Number of CAD models requiring CAM programming — used to plan manufacturing engineering capacity for CNC and machining programs."
    - name: "dfm_analysis_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dfm_analysis_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CAD models with completed DFM analysis — measures design quality process adherence; low rates indicate manufacturability risk in the pipeline."
    - name: "released_model_count"
      expr: COUNT(CASE WHEN model_maturity_state = 'Released' THEN 1 END)
      comment: "Number of CAD models in released state — measures the volume of design data approved for production use."
    - name: "avg_model_volume"
      expr: AVG(CAST(model_volume AS DOUBLE))
      comment: "Average volumetric size of CAD models — used for material estimation, packaging design, and logistics planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_specification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering specification governance metrics — approval status, validation coverage, and compliance readiness. Used by engineering and quality leadership to ensure specifications are current, validated, and compliant before production release."
  source: "`vibe_manufacturing_v1`.`engineering`.`engineering_specification`"
  dimensions:
    - name: "specification_type"
      expr: specification_type
      comment: "Type of engineering specification (e.g. Design, Material, Process, Test) — primary segmentation for specification portfolio analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the specification — used to identify specifications pending authorization."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the specification — used to track whether specifications have been formally validated against requirements."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the specification — used for IP protection and access control governance."
    - name: "design_authority"
      expr: design_authority
      comment: "Organizational authority responsible for the specification — used to track accountability and review workload."
    - name: "supplier_qualification_required"
      expr: supplier_qualification_required
      comment: "Whether supplier qualification is required against this specification — used to plan supplier development workload."
    - name: "prototype_required"
      expr: prototype_required
      comment: "Whether a prototype is required to validate this specification — used to plan prototype build and test activities."
    - name: "dfm_analysis_completed"
      expr: dfm_analysis_completed
      comment: "Whether DFM analysis has been completed for this specification — used to track manufacturability review coverage."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the specification becomes effective — used for change management and production planning."
    - name: "approval_date_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the specification was approved — used for trend analysis of specification release cadence."
  measures:
    - name: "total_specifications"
      expr: COUNT(1)
      comment: "Total number of engineering specifications — baseline measure of specification portfolio size and governance workload."
    - name: "approved_specification_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of specifications in approved status — measures the volume of specifications ready for production use."
    - name: "specification_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of specifications that are approved — a key governance health KPI; low rates indicate a backlog in the specification approval process."
    - name: "validated_specification_count"
      expr: COUNT(CASE WHEN validation_status = 'Validated' THEN 1 END)
      comment: "Number of specifications that have been formally validated — measures design verification coverage."
    - name: "validation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN validation_status = 'Validated' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of specifications that have been validated — tracks design verification thoroughness; low rates indicate quality risk before production release."
    - name: "specifications_requiring_supplier_qualification"
      expr: COUNT(CASE WHEN supplier_qualification_required = TRUE THEN 1 END)
      comment: "Number of specifications requiring supplier qualification — used to plan supplier development and qualification workload."
    - name: "dfm_analysis_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dfm_analysis_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of specifications with DFM analysis completed — measures manufacturability review coverage across the specification portfolio."
    - name: "obsolete_specification_count"
      expr: COUNT(CASE WHEN obsolete_date IS NOT NULL AND obsolete_date <= CURRENT_DATE() THEN 1 END)
      comment: "Number of specifications that have passed their obsolete date — used to drive specification rationalization and archive activities."
$$;