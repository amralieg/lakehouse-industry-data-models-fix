-- Metric views for domain: engineering | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 09:37:16

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`engineering_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for engineering projects covering budget performance, schedule adherence, and portfolio health. Used by engineering VPs and PMO to steer R&D investment and resource allocation."
  source: "`manufacturing_ecm`.`engineering`.`project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current lifecycle status of the project (e.g. Active, On Hold, Completed, Cancelled) — primary filter for portfolio health dashboards."
    - name: "project_type"
      expr: project_type
      comment: "Classification of the project (e.g. New Product Development, Cost Reduction, Platform Upgrade) — used to segment investment by strategic intent."
    - name: "priority_level"
      expr: priority_level
      comment: "Business priority assigned to the project (e.g. Critical, High, Medium, Low) — used to triage resource allocation decisions."
    - name: "program_phase"
      expr: program_phase
      comment: "Current phase of the engineering program (e.g. Concept, Design, Prototype, Validation, Launch) — tracks gate progression across the portfolio."
    - name: "risk_level"
      expr: risk_level
      comment: "Assessed risk level of the project — used by leadership to identify projects requiring intervention."
    - name: "technology_platform"
      expr: technology_platform
      comment: "Technology platform the project belongs to — enables platform-level investment analysis."
    - name: "capex_opex_classification"
      expr: capex_opex_classification
      comment: "Whether the project spend is classified as CapEx or OpEx — critical for financial reporting and budget governance."
    - name: "design_methodology"
      expr: design_methodology
      comment: "Engineering design methodology used (e.g. Agile, Stage-Gate, Lean) — used to benchmark methodology effectiveness."
    - name: "target_market_segment"
      expr: target_market_segment
      comment: "Market segment the project targets — enables market-aligned portfolio analysis."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the project started — used for cohort and trend analysis of project launches."
    - name: "target_launch_date_month"
      expr: DATE_TRUNC('MONTH', target_launch_date)
      comment: "Month the project is targeted to launch — used for pipeline and capacity planning."
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of engineering projects in the portfolio. Baseline KPI for portfolio size and workload assessment."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated across all engineering projects. Used by CFO and engineering VP to govern R&D spend commitments."
    - name: "total_budget_spent"
      expr: SUM(CAST(budget_spent_amount AS DOUBLE))
      comment: "Total budget consumed across all engineering projects. Compared against allocated budget to assess burn rate and financial risk."
    - name: "avg_budget_allocated_per_project"
      expr: AVG(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Average budget allocated per engineering project. Benchmarks investment intensity and helps identify over- or under-funded projects."
    - name: "avg_budget_spent_per_project"
      expr: AVG(CAST(budget_spent_amount AS DOUBLE))
      comment: "Average budget consumed per engineering project. Used alongside average allocated budget to assess typical spend efficiency."
    - name: "projects_with_dfmea_completed"
      expr: COUNT(CASE WHEN dfmea_completed = TRUE THEN 1 END)
      comment: "Number of projects where Design Failure Mode and Effects Analysis (DFMEA) has been completed. Tracks design quality gate compliance across the portfolio."
    - name: "projects_with_pfmea_completed"
      expr: COUNT(CASE WHEN pfmea_completed = TRUE THEN 1 END)
      comment: "Number of projects where Process Failure Mode and Effects Analysis (PFMEA) has been completed. Tracks process quality gate compliance."
    - name: "projects_requiring_ppap"
      expr: COUNT(CASE WHEN ppap_required = TRUE THEN 1 END)
      comment: "Number of projects requiring Production Part Approval Process (PPAP). Used to plan supplier qualification workload and regulatory readiness."
    - name: "projects_with_dfm_completed"
      expr: COUNT(CASE WHEN dfm_analysis_completed = TRUE THEN 1 END)
      comment: "Number of projects where Design for Manufacturability (DFM) analysis has been completed. Tracks manufacturing readiness across the portfolio."
    - name: "distinct_active_projects"
      expr: COUNT(DISTINCT CASE WHEN project_status = 'Active' THEN project_id END)
      comment: "Count of distinct active engineering projects. Used by PMO to assess current workload and resource demand."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`engineering_eco`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for Engineering Change Orders (ECOs) covering change velocity, cost impact, cycle time, and approval governance. Used by engineering directors and quality leaders to manage change risk and throughput."
  source: "`manufacturing_ecm`.`engineering`.`eco`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the ECO (e.g. Draft, Submitted, Approved, Implemented, Closed) — primary filter for change pipeline analysis."
    - name: "change_type"
      expr: change_type
      comment: "Type of engineering change (e.g. Design, Process, Material, Documentation) — used to categorize change drivers."
    - name: "change_priority"
      expr: change_priority
      comment: "Priority assigned to the ECO (e.g. Critical, High, Medium, Low) — used to triage change backlog and resource allocation."
    - name: "reason_code"
      expr: reason_code
      comment: "Root cause category for the engineering change (e.g. Customer Request, Quality Issue, Cost Reduction) — used for Pareto analysis of change drivers."
    - name: "initiator_department"
      expr: initiator_department
      comment: "Department that initiated the ECO — used to identify which functions generate the most change requests."
    - name: "effectivity_type"
      expr: effectivity_type
      comment: "How the change becomes effective (e.g. Date-based, Serial Number, Lot) — used to plan implementation logistics."
    - name: "disposition_action"
      expr: disposition_action
      comment: "Action taken on existing inventory/WIP as part of the change (e.g. Use As Is, Rework, Scrap) — used to estimate inventory impact."
    - name: "requires_customer_approval"
      expr: requires_customer_approval
      comment: "Whether the ECO requires customer sign-off before implementation — used to identify changes with external dependency risk."
    - name: "initiated_date_month"
      expr: DATE_TRUNC('MONTH', initiated_date)
      comment: "Month the ECO was initiated — used for change velocity trend analysis."
    - name: "approval_date_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the ECO was approved — used to track approval throughput over time."
    - name: "implementation_date_month"
      expr: DATE_TRUNC('MONTH', implementation_date)
      comment: "Month the ECO was implemented — used to measure change execution cadence."
  measures:
    - name: "total_ecos"
      expr: COUNT(1)
      comment: "Total number of Engineering Change Orders. Baseline measure for change volume and pipeline size."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Total estimated cost impact across all ECOs. Used by finance and engineering leadership to quantify the financial exposure of the change pipeline."
    - name: "total_actual_cost_impact"
      expr: SUM(CAST(actual_cost_impact AS DOUBLE))
      comment: "Total actual cost impact realized from implemented ECOs. Compared against estimated cost impact to assess change cost forecasting accuracy."
    - name: "avg_estimated_cost_impact"
      expr: AVG(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Average estimated cost impact per ECO. Used to benchmark the typical financial weight of engineering changes."
    - name: "avg_actual_cost_impact"
      expr: AVG(CAST(actual_cost_impact AS DOUBLE))
      comment: "Average actual cost impact per implemented ECO. Used alongside average estimated cost to assess cost estimation accuracy at the ECO level."
    - name: "ecos_requiring_customer_approval"
      expr: COUNT(CASE WHEN requires_customer_approval = TRUE THEN 1 END)
      comment: "Number of ECOs that require customer approval before implementation. Tracks external dependency exposure in the change pipeline."
    - name: "ecos_with_customer_approval_received"
      expr: COUNT(CASE WHEN customer_approval_received = TRUE THEN 1 END)
      comment: "Number of ECOs where customer approval has been received. Used to track customer approval throughput and identify bottlenecks."
    - name: "ecos_requiring_supplier_notification"
      expr: COUNT(CASE WHEN requires_supplier_notification = TRUE THEN 1 END)
      comment: "Number of ECOs requiring supplier notification. Used to plan supplier communication workload and assess supply chain change risk."
    - name: "distinct_projects_with_ecos"
      expr: COUNT(DISTINCT project_id)
      comment: "Number of distinct engineering projects that have at least one ECO. Indicates breadth of change activity across the project portfolio."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`engineering_ecn`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for Engineering Change Notices (ECNs) covering change notification throughput, cost impact, system synchronization, and regulatory exposure. Used by engineering and supply chain leadership to govern change communication and compliance."
  source: "`manufacturing_ecm`.`engineering`.`ecn`"
  dimensions:
    - name: "ecn_status"
      expr: ecn_status
      comment: "Current status of the ECN (e.g. Draft, Released, Closed) — primary filter for change notice pipeline management."
    - name: "ecn_type"
      expr: ecn_type
      comment: "Type of engineering change notice — used to categorize change communication by nature of change."
    - name: "change_category"
      expr: change_category
      comment: "Category of the change described in the ECN — used for Pareto analysis of change drivers."
    - name: "priority"
      expr: priority
      comment: "Priority level of the ECN — used to triage change notice backlog."
    - name: "erp_sync_status"
      expr: erp_sync_status
      comment: "Synchronization status of the ECN with the ERP system — used to identify change notices not yet reflected in production systems."
    - name: "mes_sync_status"
      expr: mes_sync_status
      comment: "Synchronization status of the ECN with the MES system — used to identify change notices not yet reflected on the shop floor."
    - name: "bom_impact_flag"
      expr: bom_impact_flag
      comment: "Whether the ECN impacts the Bill of Materials — used to prioritize ECNs requiring BOM updates."
    - name: "regulatory_impact_flag"
      expr: regulatory_impact_flag
      comment: "Whether the ECN has regulatory compliance implications — used to flag changes requiring compliance review."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the ECN becomes effective — used for change implementation timeline analysis."
    - name: "release_date_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month the ECN was released — used for change release velocity trend analysis."
  measures:
    - name: "total_ecns"
      expr: COUNT(1)
      comment: "Total number of Engineering Change Notices. Baseline measure for change communication volume."
    - name: "total_cost_impact_estimate"
      expr: SUM(CAST(cost_impact_estimate AS DOUBLE))
      comment: "Total estimated cost impact across all ECNs. Used by finance and engineering leadership to quantify financial exposure from change notices."
    - name: "avg_cost_impact_estimate"
      expr: AVG(CAST(cost_impact_estimate AS DOUBLE))
      comment: "Average estimated cost impact per ECN. Benchmarks the typical financial weight of engineering change notices."
    - name: "ecns_with_bom_impact"
      expr: COUNT(CASE WHEN bom_impact_flag = TRUE THEN 1 END)
      comment: "Number of ECNs that impact the Bill of Materials. Used to plan BOM update workload and assess structural change exposure."
    - name: "ecns_with_regulatory_impact"
      expr: COUNT(CASE WHEN regulatory_impact_flag = TRUE THEN 1 END)
      comment: "Number of ECNs with regulatory compliance implications. Used by compliance teams to prioritize regulatory review workload."
    - name: "ecns_with_inventory_impact"
      expr: COUNT(CASE WHEN inventory_impact_flag = TRUE THEN 1 END)
      comment: "Number of ECNs that impact inventory. Used by supply chain to plan inventory disposition and obsolescence actions."
    - name: "ecns_with_routing_impact"
      expr: COUNT(CASE WHEN routing_impact_flag = TRUE THEN 1 END)
      comment: "Number of ECNs that impact production routing. Used by manufacturing engineering to plan process change workload."
    - name: "ecns_requiring_customer_notification"
      expr: COUNT(CASE WHEN customer_notification_required = TRUE THEN 1 END)
      comment: "Number of ECNs requiring customer notification. Used to manage customer communication obligations and relationship risk."
    - name: "ecns_requiring_supplier_notification"
      expr: COUNT(CASE WHEN supplier_notification_required = TRUE THEN 1 END)
      comment: "Number of ECNs requiring supplier notification. Used to plan supplier communication workload and supply chain change risk."
    - name: "ecns_pending_erp_sync"
      expr: COUNT(CASE WHEN erp_sync_status != 'Synced' THEN 1 END)
      comment: "Number of ECNs not yet synchronized with the ERP system. Tracks system integration lag that could cause production discrepancies."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`engineering_component`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for engineering components covering cost, compliance, lifecycle health, and design quality. Used by engineering, procurement, and quality leadership to govern the component library and manage supply risk."
  source: "`manufacturing_ecm`.`engineering`.`component`"
  dimensions:
    - name: "component_type"
      expr: component_type
      comment: "Type of component (e.g. Mechanical, Electrical, Electronic, Software) — primary segmentation for component portfolio analysis."
    - name: "lifecycle_phase"
      expr: lifecycle_phase
      comment: "Current lifecycle phase of the component (e.g. Active, Obsolete, Phase-Out, New) — used to manage component obsolescence risk."
    - name: "make_or_buy"
      expr: make_or_buy
      comment: "Whether the component is manufactured in-house or purchased — used for make-vs-buy strategic analysis."
    - name: "release_status"
      expr: release_status
      comment: "Engineering release status of the component — used to track design maturity and release gate compliance."
    - name: "technology_family"
      expr: technology_family
      comment: "Technology family the component belongs to — used for technology platform investment analysis."
    - name: "functional_group"
      expr: functional_group
      comment: "Functional group or subsystem the component belongs to — used for subsystem-level cost and quality analysis."
    - name: "rohs_compliant_flag"
      expr: rohs_compliant_flag
      comment: "Whether the component is RoHS compliant — used to track regulatory compliance posture of the component library."
    - name: "reach_compliant_flag"
      expr: reach_compliant_flag
      comment: "Whether the component is REACH compliant — used to track chemical regulatory compliance."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Whether the component contains hazardous materials — used for environmental and safety risk management."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC inventory classification of the component — used to prioritize management attention and procurement strategy."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the component became effective — used for component introduction trend analysis."
  measures:
    - name: "total_components"
      expr: COUNT(1)
      comment: "Total number of components in the engineering component library. Baseline measure for portfolio size and complexity."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost across all components. Used by finance and engineering to assess the cost base of the component library."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per component. Used to benchmark component cost levels and identify outliers requiring cost reduction focus."
    - name: "avg_dfm_score"
      expr: AVG(CAST(dfm_score AS DOUBLE))
      comment: "Average Design for Manufacturability (DFM) score across components. Used by engineering leadership to track overall design quality and manufacturability of the component portfolio."
    - name: "avg_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average component weight in kilograms. Used for product weight optimization and logistics cost analysis."
    - name: "components_rohs_compliant"
      expr: COUNT(CASE WHEN rohs_compliant_flag = TRUE THEN 1 END)
      comment: "Number of RoHS-compliant components. Used to track regulatory compliance coverage and identify non-compliant components requiring remediation."
    - name: "components_reach_compliant"
      expr: COUNT(CASE WHEN reach_compliant_flag = TRUE THEN 1 END)
      comment: "Number of REACH-compliant components. Used to track chemical regulatory compliance across the component library."
    - name: "components_hazardous_material"
      expr: COUNT(CASE WHEN hazardous_material_flag = TRUE THEN 1 END)
      comment: "Number of components containing hazardous materials. Used for environmental risk management and regulatory reporting."
    - name: "components_obsolete"
      expr: COUNT(CASE WHEN lifecycle_phase = 'Obsolete' THEN 1 END)
      comment: "Number of obsolete components in the library. Used to track technical debt and drive component rationalization programs."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across components. Used by procurement to assess inventory commitment levels and working capital requirements."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity across all components. Used by supply chain to assess buffer inventory investment and supply risk coverage."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`engineering_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for engineering test results covering test pass rates, measurement accuracy, failure analysis, and validation throughput. Used by engineering, quality, and product leadership to govern design validation and product release readiness."
  source: "`manufacturing_ecm`.`engineering`.`test_result`"
  dimensions:
    - name: "test_outcome"
      expr: test_outcome
      comment: "Outcome of the test (e.g. Pass, Fail, Inconclusive) — primary dimension for quality and validation analysis."
    - name: "test_type"
      expr: test_type
      comment: "Type of test performed (e.g. Functional, Environmental, Reliability, Safety) — used to segment test results by validation category."
    - name: "test_status"
      expr: test_status
      comment: "Current status of the test record (e.g. Completed, In Progress, Pending Review) — used to track test execution pipeline."
    - name: "prototype_phase"
      expr: prototype_phase
      comment: "Prototype phase during which the test was conducted (e.g. EVT, DVT, PVT) — used to track validation maturity progression."
    - name: "failure_mode_code"
      expr: failure_mode_code
      comment: "Coded failure mode for failed tests — used for Pareto analysis of failure drivers and root cause prioritization."
    - name: "test_purpose"
      expr: test_purpose
      comment: "Business purpose of the test (e.g. Design Validation, Process Validation, Regulatory Submission) — used to segment test activity by strategic intent."
    - name: "regulatory_submission_flag"
      expr: regulatory_submission_flag
      comment: "Whether the test result is used for regulatory submission — used to track regulatory evidence completeness."
    - name: "retest_flag"
      expr: retest_flag
      comment: "Whether this is a retest of a previously failed test — used to track rework and retest burden."
    - name: "test_date_month"
      expr: DATE_TRUNC('MONTH', test_date)
      comment: "Month the test was conducted — used for test throughput trend analysis."
    - name: "measured_value_unit"
      expr: measured_value_unit
      comment: "Unit of measurement for the test result — used to segment test results by measurement type."
  measures:
    - name: "total_tests"
      expr: COUNT(1)
      comment: "Total number of test results recorded. Baseline measure for test execution volume and validation throughput."
    - name: "tests_passed"
      expr: COUNT(CASE WHEN test_outcome = 'Pass' THEN 1 END)
      comment: "Number of tests with a passing outcome. Used to track validation success volume and release readiness."
    - name: "tests_failed"
      expr: COUNT(CASE WHEN test_outcome = 'Fail' THEN 1 END)
      comment: "Number of tests with a failing outcome. Used to identify quality issues requiring engineering investigation and corrective action."
    - name: "retests_count"
      expr: COUNT(CASE WHEN retest_flag = TRUE THEN 1 END)
      comment: "Number of retests performed. High retest volume indicates systemic design or process issues driving rework cost and schedule delay."
    - name: "tests_requiring_root_cause_analysis"
      expr: COUNT(CASE WHEN root_cause_analysis_required = TRUE THEN 1 END)
      comment: "Number of test failures requiring formal root cause analysis. Used to track quality investigation workload and systemic failure exposure."
    - name: "regulatory_submission_tests"
      expr: COUNT(CASE WHEN regulatory_submission_flag = TRUE THEN 1 END)
      comment: "Number of tests conducted for regulatory submission purposes. Used to track regulatory evidence generation progress and compliance readiness."
    - name: "total_test_duration_hours"
      expr: SUM(CAST(test_duration_hours AS DOUBLE))
      comment: "Total test duration in hours across all test records. Used to assess test lab capacity consumption and validation schedule impact."
    - name: "avg_test_duration_hours"
      expr: AVG(CAST(test_duration_hours AS DOUBLE))
      comment: "Average test duration in hours. Used to benchmark test execution efficiency and plan lab capacity requirements."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across test results. Used to track central tendency of test measurements relative to acceptance criteria targets."
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty across test results. Used to assess test equipment calibration quality and measurement system reliability."
    - name: "distinct_components_tested"
      expr: COUNT(DISTINCT component_id)
      comment: "Number of distinct components that have been tested. Used to track validation coverage breadth across the component portfolio."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`engineering_revision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for engineering revisions covering revision throughput, compliance gate completion, and design maturity. Used by engineering and quality leadership to govern design release processes and regulatory readiness."
  source: "`manufacturing_ecm`.`engineering`.`engineering_revision`"
  dimensions:
    - name: "lifecycle_state"
      expr: lifecycle_state
      comment: "Current lifecycle state of the engineering revision (e.g. Draft, Released, Obsolete) — primary filter for revision pipeline analysis."
    - name: "revision_type"
      expr: revision_type
      comment: "Type of revision (e.g. Major, Minor, Administrative) — used to categorize change magnitude and assess design stability."
    - name: "change_category"
      expr: change_category
      comment: "Category of the change driving the revision — used for Pareto analysis of revision drivers."
    - name: "change_impact_level"
      expr: change_impact_level
      comment: "Assessed impact level of the revision (e.g. High, Medium, Low) — used to prioritize review and approval resources."
    - name: "ppap_level"
      expr: ppap_level
      comment: "PPAP submission level required for this revision — used to plan supplier qualification workload."
    - name: "regulatory_compliance_status"
      expr: regulatory_compliance_status
      comment: "Regulatory compliance status of the revision — used to track compliance gate completion and identify revisions at regulatory risk."
    - name: "mass_production_approved"
      expr: mass_production_approved
      comment: "Whether the revision has been approved for mass production — used to track production readiness across the revision portfolio."
    - name: "release_date_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month the revision was released — used for revision release velocity trend analysis."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the revision became effective — used for change effectivity timeline analysis."
  measures:
    - name: "total_revisions"
      expr: COUNT(1)
      comment: "Total number of engineering revisions. Baseline measure for design change velocity and revision pipeline size."
    - name: "revisions_mass_production_approved"
      expr: COUNT(CASE WHEN mass_production_approved = TRUE THEN 1 END)
      comment: "Number of revisions approved for mass production. Tracks production readiness throughput — a key gate metric for new product launches."
    - name: "revisions_with_dfmea_completed"
      expr: COUNT(CASE WHEN dfmea_completed = TRUE THEN 1 END)
      comment: "Number of revisions where DFMEA has been completed. Tracks design quality gate compliance across the revision portfolio."
    - name: "revisions_with_pfmea_completed"
      expr: COUNT(CASE WHEN pfmea_completed = TRUE THEN 1 END)
      comment: "Number of revisions where PFMEA has been completed. Tracks process quality gate compliance."
    - name: "revisions_with_dfm_completed"
      expr: COUNT(CASE WHEN dfm_analysis_completed = TRUE THEN 1 END)
      comment: "Number of revisions where DFM analysis has been completed. Tracks manufacturability gate compliance."
    - name: "revisions_requiring_ppap"
      expr: COUNT(CASE WHEN ppap_required = TRUE THEN 1 END)
      comment: "Number of revisions requiring PPAP submission. Used to plan supplier qualification and regulatory submission workload."
    - name: "revisions_prototype_tested"
      expr: COUNT(CASE WHEN prototype_tested = TRUE THEN 1 END)
      comment: "Number of revisions where prototype testing has been completed. Tracks physical validation coverage across the revision portfolio."
    - name: "revisions_requiring_ce_marking"
      expr: COUNT(CASE WHEN ce_marking_required = TRUE THEN 1 END)
      comment: "Number of revisions requiring CE marking. Used to track European regulatory compliance obligations across the revision portfolio."
    - name: "revisions_requiring_ul_certification"
      expr: COUNT(CASE WHEN ul_certification_required = TRUE THEN 1 END)
      comment: "Number of revisions requiring UL certification. Used to track North American safety certification obligations."
    - name: "distinct_components_revised"
      expr: COUNT(DISTINCT component_id)
      comment: "Number of distinct components that have had engineering revisions. Used to assess the breadth of design change activity across the component portfolio."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`engineering_bom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for Bills of Materials covering cost estimation, BOM complexity, configuration governance, and structural health. Used by engineering, manufacturing, and finance leadership to govern product structure and cost accuracy."
  source: "`manufacturing_ecm`.`engineering`.`bom`"
  dimensions:
    - name: "bom_status"
      expr: bom_status
      comment: "Current status of the BOM (e.g. Active, Obsolete, In Review) — primary filter for BOM portfolio health analysis."
    - name: "bom_type"
      expr: bom_type
      comment: "Type of BOM (e.g. Engineering BOM, Manufacturing BOM, Sales BOM) — used to segment BOM analysis by lifecycle stage."
    - name: "bom_category"
      expr: bom_category
      comment: "Category of the BOM — used for portfolio segmentation and governance reporting."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the BOM — used to track BOM governance compliance and identify unapproved structures in production."
    - name: "is_configurable"
      expr: is_configurable
      comment: "Whether the BOM supports product configuration — used to segment configurable vs. standard product structures."
    - name: "is_critical_bom"
      expr: is_critical_bom
      comment: "Whether the BOM is classified as critical — used to prioritize governance and change control attention."
    - name: "is_phantom_bom"
      expr: is_phantom_bom
      comment: "Whether the BOM is a phantom (non-stocked assembly) — used to identify structural complexity in the product hierarchy."
    - name: "usage"
      expr: usage
      comment: "Usage context of the BOM (e.g. Production, Prototype, Spare Parts) — used to segment BOM analysis by operational context."
    - name: "approved_date_month"
      expr: DATE_TRUNC('MONTH', approved_date)
      comment: "Month the BOM was approved — used for BOM approval throughput trend analysis."
    - name: "effective_from_date_month"
      expr: DATE_TRUNC('MONTH', effective_from_date)
      comment: "Month the BOM became effective — used for BOM effectivity timeline analysis."
  measures:
    - name: "total_boms"
      expr: COUNT(1)
      comment: "Total number of Bills of Materials. Baseline measure for product structure portfolio size and complexity."
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate_total AS DOUBLE))
      comment: "Total cost estimate across all BOMs. Used by finance and engineering to assess the total estimated cost base of the product portfolio."
    - name: "avg_cost_estimate"
      expr: AVG(CAST(cost_estimate_total AS DOUBLE))
      comment: "Average cost estimate per BOM. Used to benchmark product cost levels and identify outliers requiring cost reduction focus."
    - name: "total_weight"
      expr: SUM(CAST(weight_total AS DOUBLE))
      comment: "Total weight across all BOMs. Used for product weight optimization programs and logistics cost analysis."
    - name: "avg_weight"
      expr: AVG(CAST(weight_total AS DOUBLE))
      comment: "Average BOM weight. Used to benchmark product weight and track progress against weight reduction targets."
    - name: "avg_scrap_percentage"
      expr: AVG(CAST(scrap_percentage AS DOUBLE))
      comment: "Average scrap percentage across BOMs. Used to track material waste in product structures and identify cost reduction opportunities."
    - name: "boms_approved"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of approved BOMs. Used to track BOM governance compliance and ensure only approved structures are used in production."
    - name: "critical_boms_count"
      expr: COUNT(CASE WHEN is_critical_bom = TRUE THEN 1 END)
      comment: "Number of BOMs classified as critical. Used to scope governance oversight and change control rigor for high-risk product structures."
    - name: "configurable_boms_count"
      expr: COUNT(CASE WHEN is_configurable = TRUE THEN 1 END)
      comment: "Number of configurable BOMs. Used to assess the complexity of the configure-to-order product portfolio."
    - name: "avg_lot_size"
      expr: AVG(CAST(lot_size AS DOUBLE))
      comment: "Average lot size across BOMs. Used by production planning to benchmark standard production batch sizes and assess inventory policy alignment."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`engineering_specification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for engineering specifications covering specification governance, validation completeness, and compliance readiness. Used by engineering and quality leadership to ensure product specifications are current, validated, and compliant."
  source: "`manufacturing_ecm`.`engineering`.`engineering_specification`"
  dimensions:
    - name: "specification_type"
      expr: specification_type
      comment: "Type of engineering specification (e.g. Material, Performance, Interface, Safety) — primary segmentation for specification portfolio analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the specification — used to track governance compliance and identify unapproved specifications in use."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the specification — used to track whether specifications have been formally validated against test evidence."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the specification — used for information security governance and access control reporting."
    - name: "dfm_analysis_completed"
      expr: dfm_analysis_completed
      comment: "Whether DFM analysis has been completed for this specification — used to track manufacturability gate compliance."
    - name: "supplier_qualification_required"
      expr: supplier_qualification_required
      comment: "Whether supplier qualification is required for this specification — used to plan supplier qualification workload."
    - name: "prototype_required"
      expr: prototype_required
      comment: "Whether a prototype is required to validate this specification — used to plan prototype build and test resources."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the specification became effective — used for specification release velocity trend analysis."
    - name: "approval_date_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the specification was approved — used for approval throughput trend analysis."
    - name: "validation_date_month"
      expr: DATE_TRUNC('MONTH', validation_date)
      comment: "Month the specification was validated — used for validation throughput trend analysis."
  measures:
    - name: "total_specifications"
      expr: COUNT(1)
      comment: "Total number of engineering specifications. Baseline measure for specification library size and governance scope."
    - name: "specifications_approved"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of approved engineering specifications. Used to track governance compliance and ensure only approved specifications are referenced in design."
    - name: "specifications_validated"
      expr: COUNT(CASE WHEN validation_status = 'Validated' THEN 1 END)
      comment: "Number of validated engineering specifications. Tracks the proportion of specifications backed by formal test evidence — a key quality gate metric."
    - name: "specifications_with_dfm_completed"
      expr: COUNT(CASE WHEN dfm_analysis_completed = TRUE THEN 1 END)
      comment: "Number of specifications where DFM analysis has been completed. Tracks manufacturability gate compliance across the specification library."
    - name: "specifications_requiring_supplier_qualification"
      expr: COUNT(CASE WHEN supplier_qualification_required = TRUE THEN 1 END)
      comment: "Number of specifications requiring supplier qualification. Used to plan supplier qualification workload and assess supply chain readiness."
    - name: "specifications_requiring_prototype"
      expr: COUNT(CASE WHEN prototype_required = TRUE THEN 1 END)
      comment: "Number of specifications requiring prototype validation. Used to plan prototype build resources and track validation pipeline."
    - name: "distinct_components_with_specifications"
      expr: COUNT(DISTINCT component_id)
      comment: "Number of distinct components that have at least one engineering specification. Used to assess specification coverage breadth across the component portfolio."
    - name: "distinct_suppliers_with_specifications"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers referenced in engineering specifications. Used to assess supplier specification governance scope."
$$;