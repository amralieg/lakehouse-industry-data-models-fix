-- Metric views for domain: program | Business: Ngo | Version: 2 | Generated on: 2026-06-23 02:03:19

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic program portfolio metrics providing executive visibility into program count, budget scale, multi-year and emergency program distribution, and portfolio health by status, sector, and geography."
  source: "`vibe_ngo_v1`.`program`.`program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Lifecycle status of the program (e.g. Active, Closed, Pipeline) — primary filter for portfolio health dashboards."
    - name: "program_type"
      expr: program_type
      comment: "Classification of the program type (e.g. Development, Humanitarian, Recovery) — used to segment portfolio by strategic intent."
    - name: "sector_name"
      expr: sector_name
      comment: "Sector the program operates in (e.g. Health, WASH, Education) — key dimension for sector-level resource allocation analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the program — enables regional portfolio comparison and resource distribution analysis."
    - name: "is_emergency"
      expr: is_emergency
      comment: "Flag indicating whether the program is an emergency response — used to split development vs. humanitarian portfolio."
    - name: "is_multi_year"
      expr: is_multi_year
      comment: "Flag indicating whether the program spans multiple years — relevant for long-term funding commitment analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the program (e.g. Low, Medium, High) — used to identify high-risk programs requiring oversight."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG goal(s) the program is aligned to — used for donor reporting and strategic SDG contribution tracking."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the program — used to flag programs with compliance gaps requiring corrective action."
    - name: "program_start_year"
      expr: YEAR(start_date)
      comment: "Year the program started — enables cohort analysis of programs by start year."
    - name: "program_end_year"
      expr: YEAR(end_date)
      comment: "Year the program is scheduled to end — used for pipeline and closeout planning."
  measures:
    - name: "total_program_budget"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total approved budget across all programs — primary financial scale indicator for the program portfolio."
    - name: "avg_program_budget"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per program — used to benchmark program investment levels and identify outliers."
    - name: "active_program_count"
      expr: COUNT(CASE WHEN program_status = 'Active' THEN program_id END)
      comment: "Number of currently active programs — core operational KPI for portfolio size and capacity management."
    - name: "emergency_program_count"
      expr: COUNT(CASE WHEN is_emergency = TRUE THEN program_id END)
      comment: "Number of emergency response programs — tracks humanitarian surge capacity and emergency portfolio scale."
    - name: "multi_year_program_count"
      expr: COUNT(CASE WHEN is_multi_year = TRUE THEN program_id END)
      comment: "Number of multi-year programs — indicates long-term funding commitment and programmatic continuity."
    - name: "high_risk_program_count"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN program_id END)
      comment: "Number of programs rated high risk — critical oversight KPI for risk management and escalation decisions."
    - name: "total_programs"
      expr: COUNT(1)
      comment: "Total number of programs in the portfolio — baseline denominator for portfolio composition ratios."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_intervention`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intervention-level operational and quality metrics covering budget utilization, gender and disability inclusion marker scores, implementation status, and programmatic compliance — enabling program managers and executives to steer intervention performance."
  source: "`vibe_ngo_v1`.`program`.`intervention`"
  dimensions:
    - name: "intervention_status"
      expr: intervention_status
      comment: "Current lifecycle status of the intervention (e.g. Active, Completed, Cancelled) — primary filter for operational dashboards."
    - name: "intervention_type"
      expr: intervention_type
      comment: "Type of intervention (e.g. Direct Service, Capacity Building, Advocacy) — used to segment performance by modality."
    - name: "sector"
      expr: sector
      comment: "Sector the intervention operates in — enables sector-level performance benchmarking."
    - name: "sub_sector"
      expr: sub_sector
      comment: "Sub-sector classification — provides granular sector segmentation for detailed analysis."
    - name: "phase"
      expr: phase
      comment: "Implementation phase of the intervention — used to track pipeline vs. active vs. closeout interventions."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the intervention — used for geographic distribution and coverage analysis."
    - name: "sdg_goal_primary"
      expr: sdg_goal_primary
      comment: "Primary SDG goal the intervention contributes to — used for SDG portfolio reporting to donors and boards."
    - name: "chs_compliant"
      expr: chs_compliant
      comment: "Whether the intervention is compliant with Core Humanitarian Standards — quality and accountability indicator."
    - name: "safeguarding_policy_applied"
      expr: safeguarding_policy_applied
      comment: "Whether safeguarding policy has been applied — critical compliance dimension for risk and governance reporting."
    - name: "rbm_framework_applied"
      expr: rbm_framework_applied
      comment: "Whether Results-Based Management framework is applied — indicator of programmatic quality and accountability."
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year the intervention is planned to start — used for pipeline planning and cohort analysis."
  measures:
    - name: "total_intervention_budget"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total budget allocated across all interventions — primary financial KPI for intervention portfolio investment."
    - name: "avg_intervention_budget"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average budget per intervention — used to benchmark investment levels and identify under- or over-resourced interventions."
    - name: "avg_gender_marker_score"
      expr: AVG(CAST(gender_marker_score AS DOUBLE))
      comment: "Average gender marker score across interventions — strategic KPI for gender mainstreaming compliance and donor reporting."
    - name: "avg_disability_inclusion_score"
      expr: AVG(CAST(disability_inclusion_marker_score AS DOUBLE))
      comment: "Average disability inclusion marker score — tracks inclusion quality across the intervention portfolio."
    - name: "chs_compliant_intervention_count"
      expr: COUNT(CASE WHEN chs_compliant = TRUE THEN intervention_id END)
      comment: "Number of interventions meeting Core Humanitarian Standards — accountability and quality compliance KPI."
    - name: "safeguarding_applied_count"
      expr: COUNT(CASE WHEN safeguarding_policy_applied = TRUE THEN intervention_id END)
      comment: "Number of interventions with safeguarding policy applied — critical governance and risk management KPI."
    - name: "active_intervention_count"
      expr: COUNT(CASE WHEN intervention_status = 'Active' THEN intervention_id END)
      comment: "Number of currently active interventions — operational throughput indicator for program delivery capacity."
    - name: "total_interventions"
      expr: COUNT(1)
      comment: "Total number of interventions — baseline denominator for compliance rate and quality ratio calculations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_budget_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget plan financial metrics providing visibility into total approved budgets, cost structure (personnel, travel, equipment, indirect), cost-sharing commitments, and indirect cost rates — enabling finance and program leadership to manage budget health and donor compliance."
  source: "`vibe_ngo_v1`.`program`.`budget_plan`"
  dimensions:
    - name: "budget_version_number"
      expr: budget_version_number
      comment: "Version number of the budget plan — used to track budget revisions and compare original vs. amended budgets."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code — used for donor reporting and sector-level budget allocation analysis."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the budget plan — used for SDG-tagged budget reporting to donors and boards."
    - name: "sector_classification"
      expr: sector_classification
      comment: "Sector classification of the budget — enables sector-level financial analysis."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Whether the budget plan is visible to donors — used to segment donor-facing vs. internal budget views."
    - name: "budget_period_start_year"
      expr: YEAR(budget_period_start_date)
      comment: "Year the budget period starts — used for annual budget planning and multi-year trend analysis."
    - name: "amendment_date_month"
      expr: DATE_TRUNC('MONTH', amendment_date)
      comment: "Month of the most recent budget amendment — used to track amendment frequency and timing."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_budget_amount AS DOUBLE))
      comment: "Total approved budget across all budget plans — primary financial commitment KPI for program portfolio."
    - name: "total_direct_costs"
      expr: SUM(CAST(total_direct_costs AS DOUBLE))
      comment: "Total direct costs across budget plans — used to assess direct program delivery investment."
    - name: "total_personnel_costs"
      expr: SUM(CAST(personnel_costs AS DOUBLE))
      comment: "Total personnel costs — largest cost driver in most NGO budgets; critical for workforce planning and cost efficiency."
    - name: "total_indirect_costs"
      expr: SUM(CAST(indirect_costs AS DOUBLE))
      comment: "Total indirect costs (overhead) — used to monitor overhead ratios and donor compliance with indirect cost caps."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-sharing contributions — tracks co-financing commitments and donor leverage ratios."
    - name: "total_travel_costs"
      expr: SUM(CAST(travel_costs AS DOUBLE))
      comment: "Total travel costs — monitored for cost efficiency and donor compliance with travel budget caps."
    - name: "total_equipment_costs"
      expr: SUM(CAST(equipment_costs AS DOUBLE))
      comment: "Total equipment costs — tracked for asset management and donor prior-approval compliance."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate across budget plans — key donor negotiation and overhead management KPI."
    - name: "total_supplies_costs"
      expr: SUM(CAST(supplies_costs AS DOUBLE))
      comment: "Total supplies and materials costs — used for procurement planning and cost structure analysis."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_budget_plan_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget line-level metrics enabling granular cost analysis by category, fiscal year, and cost-sharing status — supporting finance teams in budget execution monitoring, cost allowability compliance, and donor reporting."
  source: "`vibe_ngo_v1`.`program`.`budget_plan_line`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget line — primary time dimension for annual budget execution analysis."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code on the budget line — used for sector-level expenditure reporting."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the budget line — used for SDG-tagged expenditure reporting."
    - name: "allowable_cost_flag"
      expr: allowable_cost_flag
      comment: "Whether the cost is allowable under the grant/award — critical compliance dimension for audit and donor reporting."
    - name: "cost_sharing_flag"
      expr: cost_sharing_flag
      comment: "Whether the line item is a cost-sharing contribution — used to track co-financing by line item."
    - name: "direct_cost_flag"
      expr: direct_cost_flag
      comment: "Whether the cost is a direct program cost — used to separate direct vs. indirect cost analysis."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Whether prior approval is required for this cost — used to flag items needing donor authorization."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the budget line — used for quantity-based cost analysis."
    - name: "budget_period_start_year"
      expr: YEAR(budget_period_start_date)
      comment: "Year the budget line period starts — used for annual budget planning cohort analysis."
  measures:
    - name: "total_planned_amount"
      expr: SUM(CAST(total_planned_amount AS DOUBLE))
      comment: "Total planned budget amount across all lines — primary financial execution KPI at line-item level."
    - name: "total_cost_sharing_amount"
      expr: SUM(CAST(cost_sharing_amount AS DOUBLE))
      comment: "Total cost-sharing amount at line level — tracks co-financing contributions with granular detail."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across budget lines — used for cost benchmarking and value-for-money analysis."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate at line level — used to monitor overhead application consistency across budget lines."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of units planned across budget lines — used for procurement planning and value-for-money analysis."
    - name: "non_allowable_line_count"
      expr: COUNT(CASE WHEN allowable_cost_flag = FALSE THEN budget_plan_line_id END)
      comment: "Number of budget lines flagged as non-allowable — critical compliance KPI for audit risk management."
    - name: "approval_required_line_count"
      expr: COUNT(CASE WHEN approval_required_flag = TRUE THEN budget_plan_line_id END)
      comment: "Number of lines requiring prior donor approval — used to manage approval pipeline and avoid compliance breaches."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program risk portfolio metrics providing leadership with visibility into risk distribution by level, category, and escalation status — enabling proactive risk management, mitigation prioritization, and donor compliance reporting."
  source: "`vibe_ngo_v1`.`program`.`risk_register`"
  dimensions:
    - name: "risk_level"
      expr: risk_level
      comment: "Overall risk level (e.g. Low, Medium, High, Critical) — primary dimension for risk prioritization dashboards."
    - name: "risk_category"
      expr: risk_category
      comment: "Category of risk (e.g. Financial, Operational, Security, Reputational) — used for risk type distribution analysis."
    - name: "risk_subcategory"
      expr: risk_subcategory
      comment: "Sub-category of risk — provides granular risk classification for detailed risk management."
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk (e.g. Open, Mitigated, Closed) — used to track risk lifecycle and resolution rates."
    - name: "impact_rating"
      expr: impact_rating
      comment: "Impact rating of the risk — used to prioritize high-impact risks for executive attention."
    - name: "likelihood_rating"
      expr: likelihood_rating
      comment: "Likelihood rating of the risk — combined with impact rating for risk matrix analysis."
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Whether the risk requires escalation — used to identify risks needing senior leadership intervention."
    - name: "affected_sector"
      expr: affected_sector
      comment: "Sector affected by the risk — used for sector-level risk exposure analysis."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Whether the risk is visible to donors — used to manage donor-facing risk reporting."
    - name: "identification_year"
      expr: YEAR(identification_date)
      comment: "Year the risk was identified — used for risk trend analysis and aging risk detection."
  measures:
    - name: "open_risk_count"
      expr: COUNT(CASE WHEN risk_status = 'Open' THEN risk_register_id END)
      comment: "Number of currently open risks — primary operational KPI for risk management workload and exposure."
    - name: "escalation_required_count"
      expr: COUNT(CASE WHEN escalation_required_flag = TRUE THEN risk_register_id END)
      comment: "Number of risks requiring escalation — critical KPI for senior leadership attention and governance."
    - name: "high_risk_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN risk_register_id END)
      comment: "Number of high-level risks — used to track portfolio risk concentration and trigger mitigation reviews."
    - name: "avg_mitigation_strategy_score"
      expr: AVG(CAST(mitigation_strategy AS DOUBLE))
      comment: "Average mitigation strategy score across risks — proxy for mitigation quality and risk management maturity."
    - name: "total_risks"
      expr: COUNT(1)
      comment: "Total number of risks in the register — baseline denominator for risk rate and distribution calculations."
    - name: "distinct_interventions_with_risk"
      expr: COUNT(DISTINCT intervention_id)
      comment: "Number of distinct interventions with at least one registered risk — used to assess risk coverage and identify unregistered interventions."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_logframe_row`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Logframe results metrics providing visibility into target vs. baseline performance, budget allocation by result level, and results framework completeness — enabling MEL and program teams to track programmatic accountability and results achievement."
  source: "`vibe_ngo_v1`.`program`.`logframe_row`"
  dimensions:
    - name: "result_level"
      expr: result_level
      comment: "Result level in the logframe hierarchy (e.g. Impact, Outcome, Output, Activity) — primary dimension for results chain analysis."
    - name: "logframe_row_status"
      expr: logframe_row_status
      comment: "Status of the logframe row (e.g. Active, Achieved, Off-Track) — used to monitor results achievement rates."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of reporting for this result (e.g. Monthly, Quarterly, Annual) — used for reporting workload planning."
    - name: "sector_classification"
      expr: sector_classification
      comment: "Sector classification of the result — used for sector-level results analysis."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the logframe result — used for SDG contribution tracking and donor reporting."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the result — used for geographic results distribution analysis."
    - name: "is_active"
      expr: is_active
      comment: "Whether the logframe row is currently active — used to filter active vs. archived results."
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Method used to collect data for this result — used to assess data quality and evidence standards."
    - name: "target_year"
      expr: YEAR(target_date)
      comment: "Year the result target is due — used for annual results planning and target achievement tracking."
  measures:
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Sum of all result target values — aggregate programmatic ambition indicator across the results framework."
    - name: "total_baseline_value"
      expr: SUM(CAST(baseline_value AS DOUBLE))
      comment: "Sum of all baseline values — used to contextualize target ambition relative to starting conditions."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated AS DOUBLE))
      comment: "Total budget allocated to logframe results — used to assess resource alignment with results framework priorities."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value per logframe row — used to benchmark ambition levels across results and interventions."
    - name: "active_result_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN logframe_row_id END)
      comment: "Number of active logframe results — indicates results framework scope and MEL workload."
    - name: "total_logframe_rows"
      expr: COUNT(1)
      comment: "Total number of logframe rows — baseline denominator for results framework completeness ratios."
    - name: "distinct_interventions_with_results"
      expr: COUNT(DISTINCT intervention_id)
      comment: "Number of distinct interventions with logframe results — used to assess results framework coverage across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_component`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program component metrics providing visibility into component budget envelopes, approval status, risk levels, and implementation modalities — enabling program managers to track component-level resource allocation and delivery quality."
  source: "`vibe_ngo_v1`.`program`.`component`"
  dimensions:
    - name: "component_status"
      expr: component_status
      comment: "Current status of the component (e.g. Active, Completed, Suspended) — primary filter for component portfolio health."
    - name: "component_type"
      expr: component_type
      comment: "Type of component (e.g. Technical, Administrative, Cross-Cutting) — used for component mix analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the component — used to track components pending approval and governance bottlenecks."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the component — used to prioritize high-risk components for management attention."
    - name: "implementation_modality"
      expr: implementation_modality
      comment: "How the component is implemented (e.g. Direct, Partner, Government) — used for modality mix and partnership analysis."
    - name: "sector"
      expr: sector
      comment: "Sector of the component — used for sector-level component distribution analysis."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code — used for donor reporting and sector classification."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Hierarchy level of the component within the program structure — used for structural analysis of program design."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Whether the component is visible to donors — used to manage donor-facing program reporting."
    - name: "grant_requirement_flag"
      expr: grant_requirement_flag
      comment: "Whether the component is a grant requirement — used to track donor-mandated vs. discretionary components."
  measures:
    - name: "total_budget_envelope"
      expr: SUM(CAST(budget_envelope_amount AS DOUBLE))
      comment: "Total budget envelope across all components — primary financial allocation KPI at component level."
    - name: "avg_budget_envelope"
      expr: AVG(CAST(budget_envelope_amount AS DOUBLE))
      comment: "Average budget envelope per component — used to benchmark component investment levels."
    - name: "high_risk_component_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN component_id END)
      comment: "Number of high-risk components — used to identify components requiring intensified oversight."
    - name: "pending_approval_component_count"
      expr: COUNT(CASE WHEN approval_status = 'Pending' THEN component_id END)
      comment: "Number of components pending approval — used to track governance bottlenecks and approval pipeline."
    - name: "grant_required_component_count"
      expr: COUNT(CASE WHEN grant_requirement_flag = TRUE THEN component_id END)
      comment: "Number of components that are grant requirements — used to track donor-mandated delivery obligations."
    - name: "total_components"
      expr: COUNT(1)
      comment: "Total number of components — baseline denominator for component health and risk rate calculations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_implementation_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Implementation plan metrics providing visibility into planned resource allocation, plan status distribution, risk levels, and planning coverage — enabling program managers to assess implementation readiness and resource alignment."
  source: "`vibe_ngo_v1`.`program`.`implementation_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the implementation plan (e.g. Draft, Approved, Under Review) — primary filter for plan readiness dashboards."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of implementation plan (e.g. Annual, Quarterly, Emergency) — used to segment plans by planning horizon."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the implementation plan — used to prioritize high-risk plans for management attention."
    - name: "sector_classification"
      expr: sector_classification
      comment: "Sector classification of the plan — used for sector-level implementation planning analysis."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Reporting frequency for the plan — used for reporting workload and compliance planning."
    - name: "grant_requirement_flag"
      expr: grant_requirement_flag
      comment: "Whether the plan is a grant requirement — used to track donor-mandated planning obligations."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Whether the plan is visible to donors — used to manage donor-facing implementation reporting."
    - name: "planning_period_start_year"
      expr: YEAR(planning_period_start_date)
      comment: "Year the planning period starts — used for annual planning cycle analysis."
  measures:
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated across implementation plans — primary financial planning KPI for resource commitment."
    - name: "avg_budget_allocated"
      expr: AVG(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Average budget allocated per implementation plan — used to benchmark planning investment levels."
    - name: "approved_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'Approved' THEN implementation_plan_id END)
      comment: "Number of approved implementation plans — indicates implementation readiness across the portfolio."
    - name: "high_risk_plan_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN implementation_plan_id END)
      comment: "Number of high-risk implementation plans — used to identify plans requiring additional risk mitigation resources."
    - name: "grant_required_plan_count"
      expr: COUNT(CASE WHEN grant_requirement_flag = TRUE THEN implementation_plan_id END)
      comment: "Number of plans that are grant requirements — tracks donor-mandated planning compliance."
    - name: "total_implementation_plans"
      expr: COUNT(1)
      comment: "Total number of implementation plans — baseline denominator for plan approval rate and risk distribution calculations."
$$;