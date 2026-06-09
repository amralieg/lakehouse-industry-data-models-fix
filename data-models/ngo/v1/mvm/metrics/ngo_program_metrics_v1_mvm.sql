-- Metric views for domain: program | Business: Ngo | Version: 1 | Generated on: 2026-05-07 03:19:07

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic program portfolio metrics providing executive visibility into program health, lifecycle status, geographic spread, and multi-year commitment across the NGO's mission portfolio."
  source: "`ngo_ecm`.`program`.`program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current lifecycle status of the program (e.g. Active, Closed, Pipeline) — primary filter for portfolio health dashboards."
    - name: "program_type"
      expr: program_type
      comment: "Classification of the program by type (e.g. Emergency Response, Development, Resilience) — used to segment portfolio by strategic pillar."
    - name: "sector_name"
      expr: sector_name
      comment: "Humanitarian or development sector the program addresses (e.g. Health, WASH, Education) — key dimension for sector-level resource allocation decisions."
    - name: "region"
      expr: region
      comment: "Geographic region where the program operates — enables regional portfolio analysis and resource distribution reviews."
    - name: "country_code"
      expr: country_code
      comment: "ISO country code of the program's primary operating country — supports country-level portfolio and compliance reporting."
    - name: "is_emergency"
      expr: is_emergency
      comment: "Boolean flag indicating whether the program is an emergency response — allows rapid segmentation of humanitarian vs. development portfolio."
    - name: "is_multi_year"
      expr: is_multi_year
      comment: "Boolean flag indicating multi-year programs — critical for long-term funding commitment and pipeline planning."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Organizational risk rating assigned to the program — used in risk-weighted portfolio reviews."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG goals the program contributes to — supports donor reporting and strategic alignment narratives."
    - name: "program_start_year"
      expr: YEAR(start_date)
      comment: "Year the program started — enables cohort analysis of program vintages and pipeline maturity."
    - name: "program_end_year"
      expr: YEAR(end_date)
      comment: "Year the program is scheduled to end — supports closeout planning and pipeline forecasting."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the program — used to flag programs requiring regulatory or donor compliance action."
  measures:
    - name: "total_active_programs"
      expr: COUNT(CASE WHEN program_status = 'Active' THEN program_id END)
      comment: "Count of currently active programs — primary portfolio health KPI for executive dashboards and steering meetings."
    - name: "total_programs"
      expr: COUNT(1)
      comment: "Total number of programs in the portfolio — baseline denominator for portfolio composition ratios."
    - name: "total_emergency_programs"
      expr: COUNT(CASE WHEN is_emergency = TRUE THEN program_id END)
      comment: "Count of emergency response programs — tracks humanitarian surge capacity and emergency portfolio size."
    - name: "total_multi_year_programs"
      expr: COUNT(CASE WHEN is_multi_year = TRUE THEN program_id END)
      comment: "Count of multi-year programs — indicates long-term funding commitment and strategic continuity."
    - name: "total_high_risk_programs"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN program_id END)
      comment: "Count of programs rated high risk — triggers executive risk review and mitigation resource allocation."
    - name: "distinct_countries_covered"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of distinct countries with active programs — measures geographic reach and operational footprint."
    - name: "distinct_sectors_covered"
      expr: COUNT(DISTINCT sector_name)
      comment: "Number of distinct humanitarian/development sectors covered — indicates portfolio diversification and mandate breadth."
    - name: "avg_program_duration_days"
      expr: AVG(DATEDIFF(end_date, start_date))
      comment: "Average planned duration of programs in days — informs planning cycles and resource commitment horizons."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`program_intervention`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational intervention-level metrics tracking budget allocation, implementation progress, gender and disability inclusion markers, and SDG contribution across all program interventions."
  source: "`ngo_ecm`.`program`.`intervention`"
  dimensions:
    - name: "intervention_status"
      expr: intervention_status
      comment: "Current status of the intervention (e.g. Active, Completed, Suspended) — primary operational health dimension."
    - name: "intervention_type"
      expr: intervention_type
      comment: "Type of intervention (e.g. Cash Transfer, In-Kind, Training) — used to analyze modality mix and cost-effectiveness."
    - name: "sector"
      expr: sector
      comment: "Sector the intervention addresses — enables sector-level performance and resource analysis."
    - name: "sub_sector"
      expr: sub_sector
      comment: "Sub-sector classification — provides granular sector analysis for technical advisors and donors."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the intervention — supports geographic targeting and coverage analysis."
    - name: "phase"
      expr: phase
      comment: "Implementation phase of the intervention — tracks pipeline maturity and phase transition rates."
    - name: "gender_marker_score"
      expr: gender_marker_score
      comment: "IASC gender marker score assigned to the intervention — key accountability dimension for gender-responsive programming."
    - name: "disability_inclusion_marker_score"
      expr: disability_inclusion_marker_score
      comment: "Disability inclusion marker score — tracks inclusion mainstreaming across the intervention portfolio."
    - name: "sdg_goal_primary"
      expr: sdg_goal_primary
      comment: "Primary SDG goal the intervention contributes to — supports SDG-aligned donor reporting."
    - name: "chs_compliant"
      expr: chs_compliant
      comment: "Boolean flag for Core Humanitarian Standard compliance — critical accountability and quality assurance dimension."
    - name: "do_no_harm_assessment_completed"
      expr: do_no_harm_assessment_completed
      comment: "Boolean flag indicating Do No Harm assessment completion — tracks safeguarding compliance across interventions."
    - name: "rbm_framework_applied"
      expr: rbm_framework_applied
      comment: "Boolean flag for Results-Based Management framework application — measures programmatic quality standards adherence."
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year the intervention is planned to start — supports pipeline and workload planning."
  measures:
    - name: "total_interventions"
      expr: COUNT(1)
      comment: "Total number of interventions — baseline portfolio count for operational dashboards."
    - name: "total_active_interventions"
      expr: COUNT(CASE WHEN intervention_status = 'Active' THEN intervention_id END)
      comment: "Count of currently active interventions — primary operational throughput KPI."
    - name: "total_budget_allocated"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total budget allocated across all interventions — primary financial scale KPI for resource planning and donor reporting."
    - name: "avg_budget_per_intervention"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average budget per intervention — benchmarks resource intensity and informs cost-efficiency analysis."
    - name: "total_chs_compliant_interventions"
      expr: COUNT(CASE WHEN chs_compliant = TRUE THEN intervention_id END)
      comment: "Count of CHS-compliant interventions — tracks accountability standard adherence across the portfolio."
    - name: "total_do_no_harm_assessed_interventions"
      expr: COUNT(CASE WHEN do_no_harm_assessment_completed = TRUE THEN intervention_id END)
      comment: "Count of interventions with completed Do No Harm assessments — measures safeguarding compliance coverage."
    - name: "total_rbm_applied_interventions"
      expr: COUNT(CASE WHEN rbm_framework_applied = TRUE THEN intervention_id END)
      comment: "Count of interventions with RBM framework applied — tracks programmatic quality standards adoption."
    - name: "distinct_sectors_served"
      expr: COUNT(DISTINCT sector)
      comment: "Number of distinct sectors covered by interventions — measures mandate breadth and sector diversification."
    - name: "avg_planned_duration_days"
      expr: AVG(DATEDIFF(planned_end_date, planned_start_date))
      comment: "Average planned duration of interventions in days — informs workload planning and resource commitment cycles."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`program_budget_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program budget plan metrics providing financial oversight of approved budgets, cost structure analysis, indirect cost rates, and cost-sharing commitments across the program portfolio."
  source: "`ngo_ecm`.`program`.`budget_plan`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget plan (e.g. Approved, Draft, Submitted) — primary filter for financial governance reviews."
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget plan (e.g. Original, Revised, Supplemental) — tracks budget revision history and amendment frequency."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget plan — required for multi-currency portfolio consolidation and FX risk analysis."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code — mandatory dimension for official development assistance (ODA) reporting."
    - name: "sector_classification"
      expr: sector_classification
      comment: "Internal sector classification of the budget plan — supports sector-level budget allocation analysis."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the budget plan — supports SDG-tagged budget reporting to donors and governing bodies."
    - name: "budget_period_start_year"
      expr: YEAR(budget_period_start_date)
      comment: "Fiscal year the budget period starts — enables year-over-year budget trend analysis."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Boolean flag indicating whether the budget plan is visible to donors — governs donor-facing financial reporting."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the budget plan was approved — tracks approval cycle timeliness and budget governance."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_budget_amount AS DOUBLE))
      comment: "Total approved budget across all budget plans — primary financial scale KPI for executive and donor reporting."
    - name: "total_direct_costs"
      expr: SUM(CAST(total_direct_costs AS DOUBLE))
      comment: "Total direct program costs — measures the share of budget directly funding program activities."
    - name: "total_personnel_costs"
      expr: SUM(CAST(personnel_costs AS DOUBLE))
      comment: "Total personnel costs across budget plans — largest cost driver; critical for workforce planning and cost efficiency analysis."
    - name: "total_indirect_costs"
      expr: SUM(CAST(indirect_costs AS DOUBLE))
      comment: "Total indirect/overhead costs — tracked against donor-imposed indirect cost rate ceilings."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-sharing contributions committed — measures leverage ratio and co-financing mobilization."
    - name: "total_travel_costs"
      expr: SUM(CAST(travel_costs AS DOUBLE))
      comment: "Total travel costs — monitored for cost efficiency and donor compliance with travel budget caps."
    - name: "total_equipment_costs"
      expr: SUM(CAST(equipment_costs AS DOUBLE))
      comment: "Total equipment costs — tracked for asset management and donor prior-approval compliance."
    - name: "total_supplies_costs"
      expr: SUM(CAST(supplies_costs AS DOUBLE))
      comment: "Total supplies costs — key cost category for in-kind and commodity-based programs."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate across budget plans — benchmarks overhead efficiency and donor negotiation position."
    - name: "total_budget_plans"
      expr: COUNT(1)
      comment: "Total number of budget plans — baseline count for budget governance and amendment frequency analysis."
    - name: "total_approved_budget_plans"
      expr: COUNT(CASE WHEN budget_status = 'Approved' THEN budget_plan_id END)
      comment: "Count of approved budget plans — tracks budget approval pipeline and governance cycle efficiency."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`program_budget_plan_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular budget line-level metrics enabling cost category analysis, cost-sharing tracking, unit cost benchmarking, and budget line compliance monitoring across program budget plans."
  source: "`ngo_ecm`.`program`.`budget_plan_line`"
  dimensions:
    - name: "cost_category"
      expr: cost_category
      comment: "High-level cost category of the budget line (e.g. Personnel, Travel, Supplies) — primary dimension for cost structure analysis."
    - name: "cost_subcategory"
      expr: cost_subcategory
      comment: "Granular cost sub-category — enables detailed cost breakdown for budget variance and efficiency analysis."
    - name: "budget_plan_line_status"
      expr: budget_plan_line_status
      comment: "Current status of the budget line — tracks approval pipeline and identifies blocked budget lines."
    - name: "direct_cost_flag"
      expr: direct_cost_flag
      comment: "Boolean flag indicating whether the line is a direct cost — used to compute direct vs. indirect cost ratios."
    - name: "allowable_cost_flag"
      expr: allowable_cost_flag
      comment: "Boolean flag indicating donor-allowable cost — critical for compliance and audit risk management."
    - name: "cost_sharing_flag"
      expr: cost_sharing_flag
      comment: "Boolean flag indicating cost-sharing lines — tracks co-financing commitments at line level."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget line — required for multi-currency budget consolidation."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget line — enables year-over-year budget line trend analysis."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code at line level — supports ODA-tagged expenditure reporting."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the budget line quantity — supports unit cost benchmarking across programs."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the budget line — enables SDG-tagged budget analysis at granular level."
  measures:
    - name: "total_planned_amount"
      expr: SUM(CAST(total_planned_amount AS DOUBLE))
      comment: "Total planned budget amount across all lines — primary financial KPI for budget execution monitoring."
    - name: "total_cost_sharing_amount"
      expr: SUM(CAST(cost_sharing_amount AS DOUBLE))
      comment: "Total cost-sharing amount committed at line level — measures co-financing leverage at granular cost level."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of units planned across budget lines — supports unit cost benchmarking and procurement planning."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across budget lines — key efficiency benchmark for cost-effectiveness analysis and donor negotiations."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate at line level — monitors overhead allocation consistency across budget lines."
    - name: "total_budget_lines"
      expr: COUNT(1)
      comment: "Total number of budget lines — baseline count for budget complexity and governance workload analysis."
    - name: "total_direct_cost_lines"
      expr: COUNT(CASE WHEN direct_cost_flag = TRUE THEN budget_plan_line_id END)
      comment: "Count of direct cost budget lines — tracks proportion of budget directly funding program delivery."
    - name: "total_non_allowable_cost_lines"
      expr: COUNT(CASE WHEN allowable_cost_flag = FALSE THEN budget_plan_line_id END)
      comment: "Count of non-allowable cost lines — critical compliance KPI flagging lines at risk of donor disallowance."
    - name: "total_cost_sharing_lines"
      expr: COUNT(CASE WHEN cost_sharing_flag = TRUE THEN budget_plan_line_id END)
      comment: "Count of cost-sharing budget lines — tracks co-financing commitment breadth across the budget."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`program_implementation_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Implementation plan metrics tracking planning quality, budget allocation, risk levels, and donor compliance across program implementation plans — key inputs for operational steering and donor reporting."
  source: "`ngo_ecm`.`program`.`implementation_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the implementation plan (e.g. Approved, Draft, Revised) — primary governance filter."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of implementation plan (e.g. Annual, Multi-Year, Emergency) — segments planning horizon and complexity."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the implementation plan — triggers escalation and mitigation resource allocation."
    - name: "sector_classification"
      expr: sector_classification
      comment: "Sector classification of the implementation plan — supports sector-level operational performance analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the implementation plan — enables geographic coverage and reach analysis."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of progress reporting required — tracks reporting burden and compliance obligations."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Boolean flag indicating donor-visible plans — governs donor-facing operational reporting."
    - name: "grant_requirement_flag"
      expr: grant_requirement_flag
      comment: "Boolean flag indicating grant-mandated plans — tracks compliance with grant conditionalities."
    - name: "budget_currency_code"
      expr: budget_currency_code
      comment: "Currency of the plan budget — required for multi-currency financial consolidation."
    - name: "planning_period_start_year"
      expr: YEAR(planning_period_start_date)
      comment: "Year the planning period starts — enables annual planning cycle analysis."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code — supports ODA-aligned planning and donor reporting."
  measures:
    - name: "total_implementation_plans"
      expr: COUNT(1)
      comment: "Total number of implementation plans — baseline count for planning governance and workload analysis."
    - name: "total_approved_plans"
      expr: COUNT(CASE WHEN plan_status = 'Approved' THEN implementation_plan_id END)
      comment: "Count of approved implementation plans — tracks planning approval pipeline efficiency."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated across implementation plans — primary financial commitment KPI for operational planning."
    - name: "avg_budget_per_plan"
      expr: AVG(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Average budget allocated per implementation plan — benchmarks resource intensity and planning scale."
    - name: "total_high_risk_plans"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN implementation_plan_id END)
      comment: "Count of high-risk implementation plans — triggers executive risk review and mitigation resource allocation."
    - name: "total_grant_required_plans"
      expr: COUNT(CASE WHEN grant_requirement_flag = TRUE THEN implementation_plan_id END)
      comment: "Count of grant-mandated implementation plans — tracks compliance obligations tied to grant conditionalities."
    - name: "avg_planning_period_days"
      expr: AVG(DATEDIFF(planning_period_end_date, planning_period_start_date))
      comment: "Average planning period duration in days — informs planning horizon benchmarks and multi-year commitment analysis."
    - name: "distinct_geographic_scopes"
      expr: COUNT(DISTINCT geographic_scope)
      comment: "Number of distinct geographic scopes covered by implementation plans — measures operational geographic reach."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`program_partner_linkage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner linkage metrics providing strategic oversight of implementing partner performance, budget delegation, compliance status, and local partnership ratios — critical for partnership governance and donor accountability."
  source: "`ngo_ecm`.`program`.`partner_linkage`"
  dimensions:
    - name: "partnership_status"
      expr: partnership_status
      comment: "Current status of the partner linkage (e.g. Active, Suspended, Closed) — primary governance filter for partner portfolio."
    - name: "partnership_type"
      expr: partnership_type
      comment: "Type of partnership (e.g. Implementing, Consortium, Sub-grant) — segments partner portfolio by engagement modality."
    - name: "partnership_role"
      expr: partnership_role
      comment: "Role of the partner in the program (e.g. Lead, Co-implementer, Technical) — tracks role distribution across the partner network."
    - name: "performance_rating"
      expr: performance_rating
      comment: "Performance rating of the partner — primary KPI dimension for partner quality management and renewal decisions."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the partner linkage — drives enhanced monitoring and capacity building decisions."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the partner linkage — critical for donor accountability and audit readiness."
    - name: "local_partner_flag"
      expr: local_partner_flag
      comment: "Boolean flag indicating local/national partner — tracks localization agenda progress and local partner investment."
    - name: "community_based_organization_flag"
      expr: community_based_organization_flag
      comment: "Boolean flag for community-based organizations — measures grassroots partnership depth."
    - name: "capacity_building_required_flag"
      expr: capacity_building_required_flag
      comment: "Boolean flag indicating capacity building need — drives capacity investment planning and resource allocation."
    - name: "sector_focus"
      expr: sector_focus
      comment: "Sector focus of the partner linkage — enables sector-level partner portfolio analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the partner linkage — supports geographic partner coverage analysis."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Reporting frequency required from the partner — tracks reporting compliance burden."
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the partnership started — enables partnership vintage and longevity analysis."
  measures:
    - name: "total_partner_linkages"
      expr: COUNT(1)
      comment: "Total number of partner linkages — baseline count for partner portfolio size and network analysis."
    - name: "total_active_partner_linkages"
      expr: COUNT(CASE WHEN partnership_status = 'Active' THEN partner_linkage_id END)
      comment: "Count of active partner linkages — primary partner portfolio health KPI."
    - name: "total_budget_delegated_to_partners"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated to implementing partners — measures financial delegation scale and partner dependency."
    - name: "avg_budget_per_partner_linkage"
      expr: AVG(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Average budget per partner linkage — benchmarks partner financial scale and informs sub-grant sizing decisions."
    - name: "total_local_partners"
      expr: COUNT(CASE WHEN local_partner_flag = TRUE THEN partner_linkage_id END)
      comment: "Count of local/national partner linkages — primary localization agenda KPI tracked by donors and leadership."
    - name: "total_high_risk_partners"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN partner_linkage_id END)
      comment: "Count of high-risk partner linkages — triggers enhanced monitoring and capacity building interventions."
    - name: "total_capacity_building_required"
      expr: COUNT(CASE WHEN capacity_building_required_flag = TRUE THEN partner_linkage_id END)
      comment: "Count of partner linkages requiring capacity building — drives capacity investment planning and budget allocation."
    - name: "distinct_partners"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of distinct partner organizations engaged — measures partner network breadth and diversification."
    - name: "total_non_compliant_partners"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN partner_linkage_id END)
      comment: "Count of non-compliant partner linkages — critical accountability KPI for donor reporting and audit risk management."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`program_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program risk register metrics providing executive visibility into risk portfolio composition, escalation requirements, open risk exposure, and risk mitigation coverage across programs and interventions."
  source: "`ngo_ecm`.`program`.`risk_register`"
  dimensions:
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk (e.g. Open, Mitigated, Closed) — primary filter for active risk exposure analysis."
    - name: "risk_category"
      expr: risk_category
      comment: "High-level risk category (e.g. Operational, Financial, Security, Reputational) — primary dimension for risk portfolio composition."
    - name: "risk_subcategory"
      expr: risk_subcategory
      comment: "Granular risk sub-category — enables detailed risk type analysis for technical risk owners."
    - name: "risk_level"
      expr: risk_level
      comment: "Overall risk level (e.g. High, Medium, Low) — primary executive risk dashboard dimension."
    - name: "impact_rating"
      expr: impact_rating
      comment: "Impact rating of the risk — used in risk matrix analysis and prioritization."
    - name: "likelihood_rating"
      expr: likelihood_rating
      comment: "Likelihood rating of the risk — combined with impact rating for risk matrix scoring."
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Boolean flag indicating escalation requirement — drives executive attention and governance escalation workflows."
    - name: "affected_sector"
      expr: affected_sector
      comment: "Sector affected by the risk — enables sector-level risk exposure analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the risk — supports geographic risk concentration analysis."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Boolean flag for donor-visible risks — governs risk disclosure in donor reports."
    - name: "identification_year"
      expr: YEAR(identification_date)
      comment: "Year the risk was identified — enables risk vintage and aging analysis."
    - name: "affected_sdg"
      expr: affected_sdg
      comment: "SDG goal affected by the risk — supports SDG-risk linkage reporting."
  measures:
    - name: "total_risks"
      expr: COUNT(1)
      comment: "Total number of risks in the register — baseline risk portfolio size KPI."
    - name: "total_open_risks"
      expr: COUNT(CASE WHEN risk_status = 'Open' THEN risk_register_id END)
      comment: "Count of open/unmitigated risks — primary risk exposure KPI for executive and board risk dashboards."
    - name: "total_high_level_risks"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN risk_register_id END)
      comment: "Count of high-level risks — triggers executive escalation and risk mitigation resource allocation."
    - name: "total_escalation_required_risks"
      expr: COUNT(CASE WHEN escalation_required_flag = TRUE THEN risk_register_id END)
      comment: "Count of risks requiring escalation — critical governance KPI for board and senior management attention."
    - name: "total_closed_risks"
      expr: COUNT(CASE WHEN risk_status = 'Closed' THEN risk_register_id END)
      comment: "Count of closed/resolved risks — measures risk mitigation effectiveness and closure rate."
    - name: "distinct_risk_categories"
      expr: COUNT(DISTINCT risk_category)
      comment: "Number of distinct risk categories present — measures risk portfolio breadth and complexity."
    - name: "avg_risk_age_days"
      expr: AVG(DATEDIFF(COALESCE(closure_date, CURRENT_DATE()), identification_date))
      comment: "Average age of risks in days from identification to closure (or today if open) — measures risk resolution velocity and backlog aging."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`program_review_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program review event metrics tracking beneficiary reach, review quality, CHS compliance, and reporting timeliness — key accountability and learning KPIs for donor reporting and program steering."
  source: "`ngo_ecm`.`program`.`review_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of review event (e.g. Mid-Term Review, Final Evaluation, Monitoring Visit) — primary dimension for review portfolio analysis."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the review event (e.g. Completed, In Progress, Planned) — tracks review pipeline and completion rates."
    - name: "chs_compliance_flag"
      expr: chs_compliance_flag
      comment: "Boolean flag for CHS compliance confirmed in the review — tracks accountability standard adherence."
    - name: "sphere_standards_applied_flag"
      expr: sphere_standards_applied_flag
      comment: "Boolean flag for Sphere standards application — tracks humanitarian quality standards adherence."
    - name: "cluster_submission_flag"
      expr: cluster_submission_flag
      comment: "Boolean flag for cluster system submission — tracks inter-agency coordination reporting compliance."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Boolean flag for donor-visible review events — governs donor-facing accountability reporting."
    - name: "review_year"
      expr: YEAR(review_date)
      comment: "Year the review was conducted — enables annual review cycle analysis and trend tracking."
    - name: "reporting_period_start_year"
      expr: YEAR(reporting_period_start_date)
      comment: "Year of the reporting period start — supports annual and multi-year performance trend analysis."
  measures:
    - name: "total_review_events"
      expr: COUNT(1)
      comment: "Total number of review events — baseline count for accountability and learning cycle analysis."
    - name: "total_completed_reviews"
      expr: COUNT(CASE WHEN event_status = 'Completed' THEN review_event_id END)
      comment: "Count of completed review events — tracks review completion rate and accountability cycle adherence."
    - name: "total_beneficiaries_reached"
      expr: SUM(CAST(beneficiary_reach_total AS BIGINT))
      comment: "Total beneficiaries reached as reported in review events — primary humanitarian impact KPI for donor and board reporting."
    - name: "total_female_beneficiaries_reached"
      expr: SUM(CAST(beneficiary_reach_female AS BIGINT))
      comment: "Total female beneficiaries reached — tracks gender disaggregation of humanitarian reach for gender accountability."
    - name: "total_male_beneficiaries_reached"
      expr: SUM(CAST(beneficiary_reach_male AS BIGINT))
      comment: "Total male beneficiaries reached — supports sex-disaggregated reach reporting."
    - name: "total_children_beneficiaries_reached"
      expr: SUM(CAST(beneficiary_reach_children AS BIGINT))
      comment: "Total children beneficiaries reached — tracks child-focused programming reach for child protection and education donors."
    - name: "avg_beneficiaries_per_review"
      expr: AVG(CAST(beneficiary_reach_total AS BIGINT))
      comment: "Average beneficiaries reached per review event — benchmarks program scale and reach intensity."
    - name: "total_chs_compliant_reviews"
      expr: COUNT(CASE WHEN chs_compliance_flag = TRUE THEN review_event_id END)
      comment: "Count of review events confirming CHS compliance — tracks accountability standard adherence across the review portfolio."
    - name: "total_sphere_standards_reviews"
      expr: COUNT(CASE WHEN sphere_standards_applied_flag = TRUE THEN review_event_id END)
      comment: "Count of reviews with Sphere standards applied — measures humanitarian quality standards adoption."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`program_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program amendment metrics tracking amendment frequency, budget change volumes, scope changes, and approval cycle efficiency — critical for donor compliance, grant management, and program governance."
  source: "`ngo_ecm`.`program`.`program_amendment`"
  dimensions:
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the amendment (e.g. Approved, Pending, Rejected) — primary governance filter for amendment pipeline."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (e.g. Budget Revision, Timeline Extension, Scope Change) — segments amendment portfolio by change driver."
    - name: "grant_requirement_flag"
      expr: grant_requirement_flag
      comment: "Boolean flag indicating grant-mandated amendment — tracks donor-required vs. internally-initiated amendments."
    - name: "logframe_revision_flag"
      expr: logframe_revision_flag
      comment: "Boolean flag indicating logframe revision — tracks amendments that alter program results framework."
    - name: "budget_change_currency"
      expr: budget_change_currency
      comment: "Currency of the budget change — required for multi-currency amendment financial analysis."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the amendment was approved — enables annual amendment frequency trend analysis."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the amendment takes effect — tracks amendment implementation lag and governance cycle efficiency."
  measures:
    - name: "total_amendments"
      expr: COUNT(1)
      comment: "Total number of program amendments — baseline KPI for program stability and change management burden."
    - name: "total_approved_amendments"
      expr: COUNT(CASE WHEN amendment_status = 'Approved' THEN program_amendment_id END)
      comment: "Count of approved amendments — tracks amendment approval rate and governance cycle efficiency."
    - name: "total_rejected_amendments"
      expr: COUNT(CASE WHEN amendment_status = 'Rejected' THEN program_amendment_id END)
      comment: "Count of rejected amendments — measures amendment quality and donor alignment before submission."
    - name: "total_budget_change_amount"
      expr: SUM(CAST(budget_change_amount AS DOUBLE))
      comment: "Total budget change amount across all amendments — measures financial volatility and re-programming scale."
    - name: "avg_budget_change_per_amendment"
      expr: AVG(CAST(budget_change_amount AS DOUBLE))
      comment: "Average budget change per amendment — benchmarks amendment financial materiality and re-programming intensity."
    - name: "total_logframe_revisions"
      expr: COUNT(CASE WHEN logframe_revision_flag = TRUE THEN program_amendment_id END)
      comment: "Count of amendments involving logframe revisions — tracks results framework stability and donor re-negotiation frequency."
    - name: "total_timeline_extensions"
      expr: COUNT(CASE WHEN amendment_type = 'Timeline Extension' THEN program_amendment_id END)
      comment: "Count of timeline extension amendments — measures program delivery delays and no-cost extension frequency."
    - name: "avg_approval_cycle_days"
      expr: AVG(DATEDIFF(approval_date, submission_date))
      comment: "Average days from amendment submission to approval — measures governance cycle efficiency and donor responsiveness."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`program_component`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program component metrics providing visibility into component portfolio health, budget envelope allocation, approval status, risk levels, and implementing partner engagement across program components."
  source: "`ngo_ecm`.`program`.`component`"
  dimensions:
    - name: "component_status"
      expr: component_status
      comment: "Current status of the component (e.g. Active, Completed, Suspended) — primary portfolio health dimension."
    - name: "component_type"
      expr: component_type
      comment: "Type of component (e.g. Output, Outcome, Activity) — segments component portfolio by results hierarchy level."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the component — tracks governance pipeline and identifies unapproved components."
    - name: "sector"
      expr: sector
      comment: "Sector of the component — enables sector-level component portfolio analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the component — drives risk-weighted portfolio management decisions."
    - name: "implementation_modality"
      expr: implementation_modality
      comment: "Implementation modality (e.g. Direct, Partner, Government) — tracks delivery channel mix."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Hierarchy level of the component in the program structure — supports results chain analysis."
    - name: "funding_source"
      expr: funding_source
      comment: "Funding source of the component — enables funding source diversification analysis."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code — supports ODA-aligned component reporting."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Boolean flag for donor-visible components — governs donor-facing program structure reporting."
    - name: "grant_requirement_flag"
      expr: grant_requirement_flag
      comment: "Boolean flag for grant-required components — tracks compliance with grant conditionalities."
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the component starts — enables component vintage and pipeline analysis."
  measures:
    - name: "total_components"
      expr: COUNT(1)
      comment: "Total number of program components — baseline count for program structure complexity analysis."
    - name: "total_active_components"
      expr: COUNT(CASE WHEN component_status = 'Active' THEN component_id END)
      comment: "Count of active components — primary operational portfolio health KPI."
    - name: "total_budget_envelope"
      expr: SUM(CAST(budget_envelope_amount AS DOUBLE))
      comment: "Total budget envelope allocated across components — primary financial scale KPI for component-level resource planning."
    - name: "avg_budget_envelope_per_component"
      expr: AVG(CAST(budget_envelope_amount AS DOUBLE))
      comment: "Average budget envelope per component — benchmarks component financial scale and resource intensity."
    - name: "total_high_risk_components"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN component_id END)
      comment: "Count of high-risk components — triggers executive risk review and mitigation resource allocation."
    - name: "total_approved_components"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN component_id END)
      comment: "Count of approved components — tracks governance approval pipeline efficiency."
    - name: "distinct_implementing_partners"
      expr: COUNT(DISTINCT implementing_partner_org_id)
      comment: "Number of distinct implementing partner organizations engaged at component level — measures partner network breadth."
    - name: "avg_component_duration_days"
      expr: AVG(DATEDIFF(end_date, start_date))
      comment: "Average planned duration of components in days — informs planning cycles and resource commitment horizons."
$$;