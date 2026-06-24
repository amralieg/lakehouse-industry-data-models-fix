-- Metric views for domain: engineering | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 08:28:29

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_bom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of Materials health and cost metrics — tracks BOM completeness, cost estimates, and lifecycle status to support engineering cost governance and release readiness decisions."
  source: "`vibe_manufacturing_v1`.`engineering`.`bom`"
  dimensions:
    - name: "bom_type"
      expr: bom_type
      comment: "Type of BOM (e.g., manufacturing, engineering, sales) for segmenting cost and complexity analysis."
    - name: "bom_status"
      expr: bom_status
      comment: "Current lifecycle status of the BOM (e.g., draft, released, obsolete) for release pipeline tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the BOM to identify bottlenecks in the engineering release process."
    - name: "bom_category"
      expr: bom_category
      comment: "Category classification of the BOM for portfolio-level cost and complexity segmentation."
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing plant associated with the BOM for site-level analysis."
    - name: "effective_from_date"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the BOM became effective, used for trend analysis of BOM releases over time."
    - name: "is_configurable"
      expr: is_configurable
      comment: "Indicates whether the BOM supports product configuration variants."
    - name: "is_critical_bom"
      expr: is_critical_bom
      comment: "Flags BOMs designated as critical, enabling prioritized review and governance."
  measures:
    - name: "total_bom_count"
      expr: COUNT(1)
      comment: "Total number of BOMs — baseline measure for BOM portfolio size and release pipeline volume."
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate_total AS DOUBLE))
      comment: "Sum of all BOM cost estimates in the portfolio — directly informs product cost governance and budget alignment."
    - name: "avg_cost_estimate_per_bom"
      expr: AVG(CAST(cost_estimate_total AS DOUBLE))
      comment: "Average cost estimate per BOM — benchmarks engineering cost efficiency across product lines."
    - name: "avg_scrap_percentage"
      expr: AVG(CAST(scrap_percentage AS DOUBLE))
      comment: "Average scrap percentage across BOMs — high values signal material waste risk and drive yield improvement initiatives."
    - name: "total_weight"
      expr: SUM(CAST(weight_total AS DOUBLE))
      comment: "Total weight across all BOM assemblies — supports logistics cost estimation and sustainability reporting."
    - name: "avg_lot_size"
      expr: AVG(CAST(lot_size AS DOUBLE))
      comment: "Average lot size across BOMs — informs production planning and minimum order quantity decisions."
    - name: "configurable_bom_count"
      expr: COUNT(CASE WHEN is_configurable = TRUE THEN 1 END)
      comment: "Number of configurable BOMs — measures the breadth of variant management capability in the product portfolio."
    - name: "critical_bom_count"
      expr: COUNT(CASE WHEN is_critical_bom = TRUE THEN 1 END)
      comment: "Number of critical BOMs requiring elevated governance attention — drives prioritization of engineering review resources."
    - name: "phantom_bom_count"
      expr: COUNT(CASE WHEN is_phantom_bom = TRUE THEN 1 END)
      comment: "Number of phantom BOMs — used to assess structural complexity and MRP explosion accuracy."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_component`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Component portfolio metrics covering cost, compliance, lifecycle, and supply risk — essential for engineering cost management, regulatory compliance, and supply chain resilience decisions."
  source: "`vibe_manufacturing_v1`.`engineering`.`component`"
  dimensions:
    - name: "component_type"
      expr: component_type
      comment: "Type classification of the component (e.g., mechanical, electrical, software) for portfolio segmentation."
    - name: "lifecycle_phase"
      expr: lifecycle_phase
      comment: "Current lifecycle phase (e.g., design, production, obsolete) for managing component transitions."
    - name: "make_or_buy"
      expr: make_or_buy
      comment: "Make-or-buy designation — drives sourcing strategy and cost structure analysis."
    - name: "release_status"
      expr: release_status
      comment: "Engineering release status of the component for release pipeline governance."
    - name: "technology_family"
      expr: technology_family
      comment: "Technology family grouping for portfolio-level technology investment analysis."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC inventory classification for prioritizing component management effort."
    - name: "functional_group"
      expr: functional_group
      comment: "Functional group the component belongs to for cross-functional cost and complexity analysis."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the component became effective — tracks the pace of new component introductions."
  measures:
    - name: "total_component_count"
      expr: COUNT(1)
      comment: "Total number of components in the engineering portfolio — baseline for complexity and diversity management."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost across all components — directly informs product cost rollup and margin analysis."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per component — benchmarks cost efficiency and identifies high-cost outliers."
    - name: "avg_dfm_score"
      expr: AVG(CAST(dfm_score AS DOUBLE))
      comment: "Average Design for Manufacturability score — low scores signal manufacturing complexity risk and drive design improvement."
    - name: "hazardous_component_count"
      expr: COUNT(CASE WHEN hazardous_material_flag = TRUE THEN 1 END)
      comment: "Number of components flagged as hazardous — critical for regulatory compliance and EHS risk management."
    - name: "rohs_non_compliant_count"
      expr: COUNT(CASE WHEN rohs_compliant_flag = FALSE THEN 1 END)
      comment: "Number of RoHS non-compliant components — directly drives regulatory risk exposure and remediation priority."
    - name: "reach_non_compliant_count"
      expr: COUNT(CASE WHEN reach_compliant_flag = FALSE THEN 1 END)
      comment: "Number of REACH non-compliant components — informs chemical compliance risk and supplier corrective action needs."
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average component lead time in days — key input for supply chain risk assessment and production scheduling."
    - name: "avg_safety_stock_quantity"
      expr: AVG(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Average safety stock quantity across components — informs inventory investment and supply continuity risk."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock held across all components — measures overall inventory buffer investment."
    - name: "obsolete_component_count"
      expr: COUNT(CASE WHEN lifecycle_phase = 'obsolete' THEN 1 END)
      comment: "Number of obsolete components still in the system — drives component rationalization and BOM cleanup initiatives."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_eco`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering Change Order (ECO) pipeline metrics — tracks change velocity, cost impact, and cycle time to govern engineering change management and product cost control."
  source: "`vibe_manufacturing_v1`.`engineering`.`eco`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of engineering change (e.g., design, process, material) for categorizing change impact."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current status of the ECO (e.g., draft, submitted, approved, closed) for pipeline visibility."
    - name: "change_priority"
      expr: change_priority
      comment: "Priority level of the ECO — enables triage and resource allocation for change execution."
    - name: "reason_code"
      expr: reason_code
      comment: "Root cause category for the engineering change — identifies systemic design or process issues."
    - name: "initiator_department"
      expr: initiator_department
      comment: "Department that initiated the ECO — tracks change origin for accountability and process improvement."
    - name: "effectivity_type"
      expr: effectivity_type
      comment: "How the change takes effect (e.g., date-based, serial-number-based) for production planning alignment."
    - name: "initiated_date_month"
      expr: DATE_TRUNC('month', initiated_date)
      comment: "Month the ECO was initiated — tracks change volume trends over time."
    - name: "requires_customer_approval"
      expr: requires_customer_approval
      comment: "Flags ECOs requiring customer sign-off — identifies changes with extended cycle time risk."
  measures:
    - name: "total_eco_count"
      expr: COUNT(1)
      comment: "Total number of Engineering Change Orders — baseline measure for change management workload and velocity."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Total estimated cost impact of all ECOs — directly informs product cost variance and budget risk."
    - name: "total_actual_cost_impact"
      expr: SUM(CAST(actual_cost_impact AS DOUBLE))
      comment: "Total actual cost impact realized from ECOs — measures true cost of engineering changes vs. estimates."
    - name: "avg_estimated_cost_impact"
      expr: AVG(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Average estimated cost impact per ECO — benchmarks change complexity and cost governance effectiveness."
    - name: "customer_approval_required_count"
      expr: COUNT(CASE WHEN requires_customer_approval = TRUE THEN 1 END)
      comment: "Number of ECOs requiring customer approval — measures external dependency risk in the change pipeline."
    - name: "supplier_notification_required_count"
      expr: COUNT(CASE WHEN requires_supplier_notification = TRUE THEN 1 END)
      comment: "Number of ECOs requiring supplier notification — drives supply chain coordination workload planning."
    - name: "open_eco_count"
      expr: COUNT(CASE WHEN lifecycle_status NOT IN ('closed', 'cancelled') THEN 1 END)
      comment: "Number of ECOs currently open — measures active change management backlog and engineering capacity demand."
    - name: "cost_estimate_accuracy_ratio"
      expr: ROUND(SUM(CAST(actual_cost_impact AS DOUBLE)) / NULLIF(SUM(CAST(estimated_cost_impact AS DOUBLE)), 0), 4)
      comment: "Ratio of actual to estimated cost impact — measures engineering cost estimation accuracy; values far from 1.0 indicate systemic estimation bias."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_ecn`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering Change Notice (ECN) execution metrics — tracks change notice volume, cost impact, and cross-system synchronization status to ensure timely and accurate change implementation."
  source: "`vibe_manufacturing_v1`.`engineering`.`ecn`"
  dimensions:
    - name: "ecn_type"
      expr: ecn_type
      comment: "Type of ECN (e.g., immediate, scheduled, deviation) for change classification and prioritization."
    - name: "ecn_status"
      expr: ecn_status
      comment: "Current status of the ECN for pipeline and backlog management."
    - name: "change_category"
      expr: change_category
      comment: "Category of the engineering change for root cause and trend analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the ECN for resource allocation and escalation decisions."
    - name: "erp_sync_status"
      expr: erp_sync_status
      comment: "ERP synchronization status — identifies ECNs not yet reflected in production systems, a key operational risk."
    - name: "mes_sync_status"
      expr: mes_sync_status
      comment: "MES synchronization status — identifies ECNs not yet propagated to the shop floor."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the ECN becomes effective — tracks change implementation cadence."
  measures:
    - name: "total_ecn_count"
      expr: COUNT(1)
      comment: "Total number of Engineering Change Notices — baseline for change execution workload."
    - name: "total_cost_impact_estimate"
      expr: SUM(CAST(cost_impact_estimate AS DOUBLE))
      comment: "Total estimated cost impact across all ECNs — informs product cost variance and financial planning."
    - name: "avg_cost_impact_estimate"
      expr: AVG(CAST(cost_impact_estimate AS DOUBLE))
      comment: "Average cost impact per ECN — benchmarks change complexity and cost governance."
    - name: "erp_sync_pending_count"
      expr: COUNT(CASE WHEN erp_sync_status NOT IN ('synced', 'complete') THEN 1 END)
      comment: "Number of ECNs not yet synchronized to ERP — measures operational risk from change implementation lag."
    - name: "bom_impacting_ecn_count"
      expr: COUNT(CASE WHEN bom_impact_flag = TRUE THEN 1 END)
      comment: "Number of ECNs that impact BOMs — drives BOM maintenance workload and production planning risk."
    - name: "inventory_impacting_ecn_count"
      expr: COUNT(CASE WHEN inventory_impact_flag = TRUE THEN 1 END)
      comment: "Number of ECNs with inventory impact — informs obsolescence risk and write-off exposure."
    - name: "regulatory_impacting_ecn_count"
      expr: COUNT(CASE WHEN regulatory_impact_flag = TRUE THEN 1 END)
      comment: "Number of ECNs with regulatory impact — critical for compliance risk management and regulatory filing decisions."
    - name: "customer_notification_required_count"
      expr: COUNT(CASE WHEN customer_notification_required = TRUE THEN 1 END)
      comment: "Number of ECNs requiring customer notification — measures customer communication workload and relationship risk."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_dfmea`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design FMEA risk metrics — tracks failure mode severity, occurrence, detection, and RPN trends to drive proactive design risk reduction and regulatory compliance."
  source: "`vibe_manufacturing_v1`.`engineering`.`dfmea`"
  dimensions:
    - name: "dfmea_status"
      expr: dfmea_status
      comment: "Current status of the DFMEA (e.g., in-progress, approved, closed) for governance tracking."
    - name: "design_phase"
      expr: design_phase
      comment: "Design phase in which the DFMEA was conducted — aligns risk analysis to product development stage gates."
    - name: "action_priority"
      expr: action_priority
      comment: "Priority of corrective actions — enables triage of high-risk failure modes."
    - name: "action_status"
      expr: action_status
      comment: "Status of corrective actions — tracks closure rate of identified risks."
    - name: "safety_related_flag"
      expr: safety_related_flag
      comment: "Flags safety-critical failure modes requiring elevated attention and regulatory scrutiny."
    - name: "regulatory_impact_flag"
      expr: regulatory_impact_flag
      comment: "Flags failure modes with regulatory compliance implications."
    - name: "analysis_date_month"
      expr: DATE_TRUNC('month', analysis_date)
      comment: "Month of DFMEA analysis — tracks risk analysis activity over the product development timeline."
  measures:
    - name: "total_dfmea_count"
      expr: COUNT(1)
      comment: "Total number of DFMEA records — baseline for design risk analysis coverage."
    - name: "safety_related_failure_mode_count"
      expr: COUNT(CASE WHEN safety_related_flag = TRUE THEN 1 END)
      comment: "Number of safety-critical failure modes identified — directly informs product safety risk and regulatory exposure."
    - name: "open_action_count"
      expr: COUNT(CASE WHEN action_status NOT IN ('closed', 'completed', 'cancelled') THEN 1 END)
      comment: "Number of DFMEA actions not yet closed — measures outstanding design risk remediation backlog."
    - name: "regulatory_impact_count"
      expr: COUNT(CASE WHEN regulatory_impact_flag = TRUE THEN 1 END)
      comment: "Number of failure modes with regulatory impact — drives compliance risk prioritization."
    - name: "special_characteristics_count"
      expr: COUNT(CASE WHEN special_characteristics_flag = TRUE THEN 1 END)
      comment: "Number of failure modes linked to special product characteristics — informs control plan and PPAP requirements."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_dfm_analysis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design for Manufacturability analysis metrics — tracks DFM issue resolution, cost savings, and supplier feedback to optimize product designs for efficient manufacturing."
  source: "`vibe_manufacturing_v1`.`engineering`.`dfm_analysis`"
  dimensions:
    - name: "analysis_type"
      expr: analysis_type
      comment: "Type of DFM analysis (e.g., casting, machining, assembly) for process-specific improvement tracking."
    - name: "disposition_status"
      expr: disposition_status
      comment: "Resolution status of the DFM issue — tracks closure rate and outstanding design improvement backlog."
    - name: "priority"
      expr: priority
      comment: "Priority of the DFM issue for resource allocation and escalation."
    - name: "severity_classification"
      expr: severity_classification
      comment: "Severity of the DFM issue — enables risk-based prioritization of design changes."
    - name: "manufacturing_process_scope"
      expr: manufacturing_process_scope
      comment: "Manufacturing process affected by the DFM issue for process-level improvement analysis."
    - name: "eco_initiated"
      expr: eco_initiated
      comment: "Indicates whether an ECO was initiated as a result of the DFM finding — measures design change conversion rate."
    - name: "review_date_month"
      expr: DATE_TRUNC('month', review_date)
      comment: "Month of DFM review — tracks analysis activity and issue discovery trends over time."
  measures:
    - name: "total_dfm_issue_count"
      expr: COUNT(1)
      comment: "Total number of DFM issues identified — baseline for design manufacturability risk exposure."
    - name: "total_estimated_cost_savings"
      expr: SUM(CAST(estimated_cost_savings AS DOUBLE))
      comment: "Total estimated cost savings from DFM improvements — directly measures the financial return on DFM investment."
    - name: "avg_estimated_cost_savings"
      expr: AVG(CAST(estimated_cost_savings AS DOUBLE))
      comment: "Average cost savings per DFM issue resolved — benchmarks DFM program effectiveness."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Total estimated cost impact of unresolved DFM issues — quantifies financial risk from design-to-manufacturing gaps."
    - name: "eco_conversion_count"
      expr: COUNT(CASE WHEN eco_initiated = TRUE THEN 1 END)
      comment: "Number of DFM issues that triggered an ECO — measures the rate at which DFM findings drive formal design changes."
    - name: "open_issue_count"
      expr: COUNT(CASE WHEN disposition_status NOT IN ('closed', 'resolved', 'accepted') THEN 1 END)
      comment: "Number of open DFM issues — measures outstanding manufacturability risk in the product design portfolio."
    - name: "avg_supplier_feedback_score"
      expr: AVG(CAST(supplier_feedback AS DOUBLE))
      comment: "Average supplier feedback score on DFM issues — informs supplier collaboration quality and design-supply alignment."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering test result metrics — tracks test pass rates, measurement accuracy, and retest rates to govern product validation quality and certification readiness."
  source: "`vibe_manufacturing_v1`.`engineering`.`test_result`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of engineering test (e.g., functional, environmental, durability) for test program coverage analysis."
    - name: "test_outcome"
      expr: test_outcome
      comment: "Pass/fail outcome of the test — primary dimension for quality and validation performance analysis."
    - name: "test_status"
      expr: test_status
      comment: "Current status of the test record (e.g., pending, in-progress, complete) for pipeline management."
    - name: "prototype_phase"
      expr: prototype_phase
      comment: "Prototype phase during which the test was conducted — aligns test results to development stage gates."
    - name: "regulatory_submission_flag"
      expr: regulatory_submission_flag
      comment: "Flags tests required for regulatory submission — prioritizes compliance-critical test management."
    - name: "test_date_month"
      expr: DATE_TRUNC('month', test_date)
      comment: "Month the test was conducted — tracks test execution velocity and validation timeline adherence."
    - name: "test_facility"
      expr: test_facility
      comment: "Facility where the test was conducted — enables lab performance and capacity analysis."
  measures:
    - name: "total_test_count"
      expr: COUNT(1)
      comment: "Total number of engineering tests executed — baseline for test program coverage and validation throughput."
    - name: "pass_count"
      expr: COUNT(CASE WHEN test_outcome = 'pass' THEN 1 END)
      comment: "Number of tests with a passing outcome — measures product validation success rate."
    - name: "fail_count"
      expr: COUNT(CASE WHEN test_outcome = 'fail' THEN 1 END)
      comment: "Number of tests with a failing outcome — drives root cause investigation and design corrective action."
    - name: "first_pass_yield_rate"
      expr: ROUND(COUNT(CASE WHEN test_outcome = 'pass' AND retest_flag = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 4)
      comment: "Proportion of tests passing on first attempt without retest — key indicator of design and process maturity."
    - name: "retest_count"
      expr: COUNT(CASE WHEN retest_flag = TRUE THEN 1 END)
      comment: "Number of tests requiring a retest — measures rework burden and design instability."
    - name: "avg_test_duration_hours"
      expr: AVG(CAST(test_duration_hours AS DOUBLE))
      comment: "Average test duration in hours — informs test lab capacity planning and validation timeline estimation."
    - name: "total_test_duration_hours"
      expr: SUM(CAST(test_duration_hours AS DOUBLE))
      comment: "Total test hours consumed — measures overall validation resource investment."
    - name: "regulatory_submission_test_count"
      expr: COUNT(CASE WHEN regulatory_submission_flag = TRUE THEN 1 END)
      comment: "Number of tests required for regulatory submission — tracks compliance validation progress."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured test value — used to monitor test result distributions and detect systematic measurement drift."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_certification_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product certification requirement metrics — tracks certification coverage, compliance status, cost, and schedule adherence to manage regulatory market access and certification risk."
  source: "`vibe_manufacturing_v1`.`engineering`.`certification_requirement`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification required (e.g., CE, UL, FCC) for market access and compliance portfolio analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status — identifies certifications at risk of non-compliance or expiry."
    - name: "certification_priority"
      expr: certification_priority
      comment: "Priority level of the certification requirement for resource allocation."
    - name: "target_market"
      expr: target_market
      comment: "Target market for the certification — enables market-level compliance coverage analysis."
    - name: "target_country_code"
      expr: target_country_code
      comment: "Target country for the certification — supports geographic compliance risk management."
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Indicates whether the certification is mandatory — prioritizes compliance-critical requirements."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Flags certifications requiring periodic renewal — drives proactive renewal planning."
    - name: "planned_completion_date_month"
      expr: DATE_TRUNC('month', planned_completion_date)
      comment: "Month the certification is planned to be completed — tracks certification pipeline and schedule risk."
  measures:
    - name: "total_certification_requirement_count"
      expr: COUNT(1)
      comment: "Total number of certification requirements — baseline for compliance portfolio scope and workload."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated cost of all certification activities — informs compliance budget planning."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost incurred for certifications — measures compliance spend vs. budget."
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Average estimated cost per certification requirement — benchmarks certification program cost efficiency."
    - name: "mandatory_requirement_count"
      expr: COUNT(CASE WHEN mandatory_flag = TRUE THEN 1 END)
      comment: "Number of mandatory certification requirements — measures non-negotiable compliance obligations."
    - name: "non_compliant_count"
      expr: COUNT(CASE WHEN compliance_status NOT IN ('compliant', 'certified', 'approved') THEN 1 END)
      comment: "Number of certification requirements not yet in a compliant state — measures regulatory risk exposure."
    - name: "renewal_required_count"
      expr: COUNT(CASE WHEN renewal_required_flag = TRUE THEN 1 END)
      comment: "Number of certifications requiring renewal — drives proactive renewal workload planning."
    - name: "cost_overrun_ratio"
      expr: ROUND(SUM(CAST(actual_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(estimated_cost_amount AS DOUBLE)), 0), 4)
      comment: "Ratio of actual to estimated certification cost — values above 1.0 indicate cost overruns in the compliance program."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering project portfolio metrics — tracks project budget performance, schedule adherence, and design readiness to govern R&D investment and product launch timelines."
  source: "`vibe_manufacturing_v1`.`engineering`.`engineering_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the engineering project (e.g., active, on-hold, completed) for portfolio health monitoring."
    - name: "project_type"
      expr: project_type
      comment: "Type of engineering project (e.g., new product, sustaining, platform) for investment portfolio analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the project for resource allocation and executive attention."
    - name: "program_phase"
      expr: program_phase
      comment: "Current phase of the engineering program (e.g., concept, development, launch) for stage-gate governance."
    - name: "capex_opex_classification"
      expr: capex_opex_classification
      comment: "CapEx vs. OpEx classification for financial reporting and budget governance."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the project — enables risk-based portfolio prioritization."
    - name: "target_market_segment"
      expr: target_market_segment
      comment: "Target market segment for the project — aligns engineering investment to commercial strategy."
    - name: "start_date_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the project started — tracks project launch cadence and pipeline velocity."
  measures:
    - name: "total_project_count"
      expr: COUNT(1)
      comment: "Total number of engineering projects — baseline for R&D portfolio size and resource demand."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated across all engineering projects — measures total R&D investment commitment."
    - name: "total_budget_spent"
      expr: SUM(CAST(budget_spent_amount AS DOUBLE))
      comment: "Total budget spent across all engineering projects — tracks actual R&D expenditure."
    - name: "avg_budget_utilization_rate"
      expr: ROUND(AVG(CAST(budget_spent_amount AS DOUBLE) / NULLIF(CAST(budget_allocated_amount AS DOUBLE), 0)), 4)
      comment: "Average budget utilization rate per project — identifies over- and under-spending projects for corrective action."
    - name: "ppap_required_project_count"
      expr: COUNT(CASE WHEN ppap_required = TRUE THEN 1 END)
      comment: "Number of projects requiring PPAP submission — measures customer quality validation workload."
    - name: "dfmea_completed_project_count"
      expr: COUNT(CASE WHEN dfmea_completed = TRUE THEN 1 END)
      comment: "Number of projects with completed DFMEA — tracks design risk analysis coverage across the portfolio."
    - name: "dfm_analysis_completed_project_count"
      expr: COUNT(CASE WHEN dfm_analysis_completed = TRUE THEN 1 END)
      comment: "Number of projects with completed DFM analysis — measures design-for-manufacturability readiness."
    - name: "avg_team_size"
      expr: AVG(CAST(team_size_count AS DOUBLE))
      comment: "Average team size across engineering projects — informs workforce planning and resource allocation."
    - name: "total_eco_count"
      expr: SUM(CAST(eco_count AS DOUBLE))
      comment: "Total number of ECOs raised across all engineering projects — measures design change volume and instability."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_bom_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering BOM line metrics — tracks BOM structure complexity, scrap factors, and component criticality to support cost rollup accuracy and manufacturing readiness."
  source: "`vibe_manufacturing_v1`.`engineering`.`engineering_bom_line`"
  dimensions:
    - name: "engineering_bom_line_status"
      expr: engineering_bom_line_status
      comment: "Status of the BOM line (e.g., active, superseded, obsolete) for BOM accuracy governance."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type of the BOM line component (e.g., make, buy, phantom) for supply strategy analysis."
    - name: "critical_component_flag"
      expr: critical_component_flag
      comment: "Flags BOM lines with critical components — prioritizes supply risk management and quality control."
    - name: "phantom_flag"
      expr: phantom_flag
      comment: "Indicates phantom BOM lines — affects MRP explosion logic and production planning accuracy."
    - name: "bulk_material_flag"
      expr: bulk_material_flag
      comment: "Indicates bulk material BOM lines — informs material planning and cost rollup methodology."
    - name: "effectivity_start_date_month"
      expr: DATE_TRUNC('month', effectivity_start_date)
      comment: "Month the BOM line became effective — tracks BOM change cadence and version management."
  measures:
    - name: "total_bom_line_count"
      expr: COUNT(1)
      comment: "Total number of BOM lines — measures BOM structural complexity and component diversity."
    - name: "total_quantity_per_assembly"
      expr: SUM(CAST(quantity_per_assembly AS DOUBLE))
      comment: "Total quantity of components across all BOM lines — informs material requirements and procurement volume."
    - name: "avg_quantity_per_assembly"
      expr: AVG(CAST(quantity_per_assembly AS DOUBLE))
      comment: "Average component quantity per BOM line — benchmarks assembly complexity."
    - name: "avg_scrap_factor_percentage"
      expr: AVG(CAST(scrap_factor_percentage AS DOUBLE))
      comment: "Average scrap factor across BOM lines — high values indicate material waste risk and drive yield improvement."
    - name: "critical_component_line_count"
      expr: COUNT(CASE WHEN critical_component_flag = TRUE THEN 1 END)
      comment: "Number of BOM lines with critical components — measures supply chain risk concentration."
    - name: "distinct_bom_count"
      expr: COUNT(DISTINCT bom_id)
      comment: "Number of distinct BOMs represented in the BOM lines — measures BOM portfolio breadth."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_project_material_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering project material allocation metrics — tracks material consumption, cost efficiency, and delivery performance to govern prototype and development material spend."
  source: "`vibe_manufacturing_v1`.`engineering`.`project_material_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the material allocation (e.g., planned, allocated, consumed, cancelled) for pipeline management."
    - name: "allocation_priority"
      expr: allocation_priority
      comment: "Priority of the material allocation — enables triage of critical material needs across projects."
    - name: "allocation_uom"
      expr: allocation_uom
      comment: "Unit of measure for the allocation — ensures consistent quantity analysis across material types."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the allocation cost — enables multi-currency cost analysis."
    - name: "allocation_date_month"
      expr: DATE_TRUNC('month', allocation_date)
      comment: "Month the material was allocated — tracks material demand patterns over the project lifecycle."
    - name: "required_by_date_month"
      expr: DATE_TRUNC('month', required_by_date)
      comment: "Month the material is required — identifies upcoming material demand peaks."
  measures:
    - name: "total_allocation_count"
      expr: COUNT(1)
      comment: "Total number of material allocations — baseline for engineering material demand volume."
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity of materials allocated to engineering projects — measures material demand commitment."
    - name: "total_consumed_quantity"
      expr: SUM(CAST(consumed_quantity AS DOUBLE))
      comment: "Total quantity of materials actually consumed — measures actual material usage vs. allocation."
    - name: "total_required_quantity"
      expr: SUM(CAST(required_quantity AS DOUBLE))
      comment: "Total quantity of materials required across all allocations — informs procurement planning."
    - name: "material_consumption_rate"
      expr: ROUND(SUM(CAST(consumed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(allocated_quantity AS DOUBLE)), 0), 4)
      comment: "Ratio of consumed to allocated material quantity — measures allocation efficiency; low values indicate over-allocation or project delays."
    - name: "total_allocation_cost"
      expr: SUM(CAST(allocation_cost AS DOUBLE))
      comment: "Total cost of material allocations — measures engineering material spend commitment."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of required materials — informs project budget planning."
    - name: "cost_variance"
      expr: ROUND(SUM(CAST(cost_amount AS DOUBLE)) - SUM(CAST(estimated_cost AS DOUBLE)), 2)
      comment: "Difference between actual and estimated material cost — measures cost estimation accuracy and budget adherence."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_design_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design review gate metrics — tracks review outcomes, action item closure, and compliance status to govern product development stage-gate quality and launch readiness."
  source: "`vibe_manufacturing_v1`.`engineering`.`design_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of design review (e.g., PDR, CDR, PRR) for stage-gate coverage analysis."
    - name: "review_status"
      expr: review_status
      comment: "Current status of the design review — tracks completion and approval pipeline."
    - name: "gate_decision"
      expr: gate_decision
      comment: "Gate decision outcome (e.g., pass, conditional pass, fail) — primary KPI for design readiness."
    - name: "apqp_phase"
      expr: apqp_phase
      comment: "APQP phase associated with the review — aligns design reviews to the APQP quality planning framework."
    - name: "design_maturity_level"
      expr: design_maturity_level
      comment: "Maturity level of the design at review time — tracks design progression toward production readiness."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status at the time of review — identifies reviews with outstanding regulatory issues."
    - name: "review_date_month"
      expr: DATE_TRUNC('month', review_date)
      comment: "Month the design review was conducted — tracks review cadence and stage-gate velocity."
  measures:
    - name: "total_design_review_count"
      expr: COUNT(1)
      comment: "Total number of design reviews conducted — baseline for stage-gate governance activity."
    - name: "gate_pass_count"
      expr: COUNT(CASE WHEN gate_decision = 'pass' THEN 1 END)
      comment: "Number of design reviews with a passing gate decision — measures product development pipeline throughput."
    - name: "gate_fail_count"
      expr: COUNT(CASE WHEN gate_decision = 'fail' THEN 1 END)
      comment: "Number of design reviews that failed the gate — drives root cause analysis and design rework prioritization."
    - name: "gate_pass_rate"
      expr: ROUND(COUNT(CASE WHEN gate_decision = 'pass' THEN 1 END) / NULLIF(COUNT(1), 0), 4)
      comment: "Proportion of design reviews passing the gate — key indicator of design quality and development process effectiveness."
    - name: "avg_meeting_duration_minutes"
      expr: AVG(CAST(meeting_duration_minutes AS DOUBLE))
      comment: "Average design review meeting duration — informs review efficiency and resource planning."
    - name: "approval_required_count"
      expr: COUNT(CASE WHEN approval_required_flag = TRUE THEN 1 END)
      comment: "Number of design reviews requiring formal approval — measures governance workload."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_configuration_baseline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Configuration baseline metrics — tracks baseline stability, change impact, and compliance status to govern product configuration management and regulatory traceability."
  source: "`vibe_manufacturing_v1`.`engineering`.`configuration_baseline`"
  dimensions:
    - name: "baseline_type"
      expr: baseline_type
      comment: "Type of configuration baseline (e.g., functional, allocated, product) for configuration management governance."
    - name: "change_category"
      expr: change_category
      comment: "Category of change associated with the baseline — tracks change drivers across the configuration portfolio."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the configuration baseline — identifies baselines with outstanding regulatory issues."
    - name: "project_phase"
      expr: project_phase
      comment: "Project phase associated with the baseline — aligns configuration control to development milestones."
    - name: "change_lock_flag"
      expr: change_lock_flag
      comment: "Indicates whether the baseline is locked against further changes — measures configuration stability."
    - name: "regulatory_impact_flag"
      expr: regulatory_impact_flag
      comment: "Flags baselines with regulatory impact — prioritizes compliance-critical configuration management."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the baseline became effective — tracks configuration release cadence."
  measures:
    - name: "total_baseline_count"
      expr: COUNT(1)
      comment: "Total number of configuration baselines — baseline for configuration management portfolio scope."
    - name: "total_cost_impact_estimate"
      expr: SUM(CAST(cost_impact_estimate AS DOUBLE))
      comment: "Total estimated cost impact of configuration changes — informs product cost governance."
    - name: "avg_cost_impact_estimate"
      expr: AVG(CAST(cost_impact_estimate AS DOUBLE))
      comment: "Average cost impact per configuration baseline change — benchmarks change cost efficiency."
    - name: "locked_baseline_count"
      expr: COUNT(CASE WHEN change_lock_flag = TRUE THEN 1 END)
      comment: "Number of locked configuration baselines — measures configuration stability across the product portfolio."
    - name: "regulatory_impact_baseline_count"
      expr: COUNT(CASE WHEN regulatory_impact_flag = TRUE THEN 1 END)
      comment: "Number of baselines with regulatory impact — drives compliance risk prioritization."
    - name: "functional_baseline_count"
      expr: COUNT(CASE WHEN is_functional_baseline = TRUE THEN 1 END)
      comment: "Number of functional baselines established — measures functional requirements traceability coverage."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_component_quality`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and cost metrics for engineering components"
  source: "`vibe_manufacturing_v1`.`engineering`.`component`"
  dimensions:
    - name: "component_type"
      expr: component_type
      comment: "Classification of component (e.g., Mechanical, Electrical)"
    - name: "material_specification"
      expr: material_specification
      comment: "Material specification code for the component"
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates if component contains hazardous material"
    - name: "reach_compliant_flag"
      expr: reach_compliant_flag
      comment: "Indicates REACH compliance"
    - name: "rohs_compliant_flag"
      expr: rohs_compliant_flag
      comment: "Indicates RoHS compliance"
  measures:
    - name: "component_count"
      expr: COUNT(1)
      comment: "Number of component records"
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Sum of standard cost for all components"
    - name: "average_dfm_score"
      expr: AVG(CAST(dfm_score AS DOUBLE))
      comment: "Average Design for Manufacturability (DFM) score"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_project_financials`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial health of engineering projects"
  source: "`vibe_manufacturing_v1`.`engineering`.`engineering_project`"
  dimensions:
    - name: "project_type"
      expr: project_type
      comment: "Type of engineering project (e.g., New Product, Upgrade)"
    - name: "priority_level"
      expr: priority_level
      comment: "Business priority assigned to the project"
    - name: "program_phase"
      expr: program_phase
      comment: "Current phase of the program (e.g., Concept, Development)"
  measures:
    - name: "project_count"
      expr: COUNT(1)
      comment: "Number of engineering projects"
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total allocated budget for projects"
    - name: "total_budget_spent"
      expr: SUM(CAST(budget_spent_amount AS DOUBLE))
      comment: "Total amount spent across projects"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`engineering_test_result_quality`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality outcomes from engineering test results"
  source: "`vibe_manufacturing_v1`.`engineering`.`test_result`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of test performed (e.g., Functional, Stress)"
    - name: "test_outcome"
      expr: test_outcome
      comment: "Result of the test (Pass/Fail)"
    - name: "test_date"
      expr: test_date
      comment: "Date the test was executed"
  measures:
    - name: "test_count"
      expr: COUNT(1)
      comment: "Total number of test result records"
    - name: "average_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across tests"
    - name: "pass_count"
      expr: COUNT(CASE WHEN test_outcome = 'Pass' THEN 1 END)
      comment: "Number of tests that passed"
$$;