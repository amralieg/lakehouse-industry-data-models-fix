-- Metric views for domain: program | Business: Ngo | Version: 2 | Generated on: 2026-06-23 01:23:48

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_intervention`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for humanitarian and development interventions. Covers portfolio composition, budget scale, and programmatic quality markers. Aligns with IPSAS project accounting and eTools/SAP programme management systems used by UN agencies and large INGOs. Supports donor audits, cluster coordination reporting, and executive portfolio reviews."
  source: "`vibe_ngo_v1`.`program`.`intervention`"
  dimensions:
    - name: "intervention_status"
      expr: intervention_status
      comment: "Lifecycle status of the intervention (e.g. Active, Closed, Pipeline). Primary filter for portfolio dashboards."
    - name: "intervention_type"
      expr: intervention_type
      comment: "Programmatic type (e.g. Emergency Response, Development, Resilience). Used to segment portfolio by modality."
    - name: "sector"
      expr: sector
      comment: "Primary humanitarian/development sector (e.g. Nutrition, WASH, Protection). Aligns with OCHA cluster system and DAC sector codes."
    - name: "sub_sector"
      expr: sub_sector
      comment: "Sub-sector classification for granular programmatic analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic coverage of the intervention (national, sub-national, regional). Used for geographic portfolio analysis."
    - name: "phase"
      expr: phase
      comment: "Implementation phase (e.g. Design, Implementation, Closeout). Tracks lifecycle stage across the portfolio."
    - name: "sdg_goal_primary"
      expr: sdg_goal_primary
      comment: "Primary SDG goal alignment. Used for SDG contribution reporting to donors and UN system."
    - name: "planned_start_year"
      expr: DATE_TRUNC('YEAR', planned_start_date)
      comment: "Year the intervention was planned to start. Used for cohort and vintage analysis of the portfolio."
    - name: "planned_end_year"
      expr: DATE_TRUNC('YEAR', planned_end_date)
      comment: "Year the intervention was planned to end. Used for pipeline and closeout forecasting."
    - name: "chs_compliant"
      expr: chs_compliant
      comment: "Boolean flag indicating Core Humanitarian Standard compliance. Used for accountability and quality assurance reporting."
    - name: "safeguarding_policy_applied"
      expr: safeguarding_policy_applied
      comment: "Boolean flag indicating whether the safeguarding policy has been applied. Critical for donor audits and PSEA compliance."
    - name: "rbm_framework_applied"
      expr: rbm_framework_applied
      comment: "Boolean flag for Results-Based Management framework application. Used for UN system and bilateral donor reporting."
  measures:
    - name: "total_interventions"
      expr: COUNT(1)
      comment: "Total number of interventions in the portfolio. Baseline KPI for portfolio size and scope reporting to leadership."
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Sum of total approved budget across all interventions (in base currency). Core financial KPI for portfolio investment reporting under IPSAS and US GAAP ASC 958."
    - name: "avg_budget_per_intervention"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average budget per intervention. Indicates typical investment scale and helps identify outliers requiring additional oversight."
    - name: "active_intervention_count"
      expr: COUNT(CASE WHEN intervention_status = 'Active' THEN 1 END)
      comment: "Number of currently active interventions. Used by programme directors to assess operational load and resource allocation."
    - name: "chs_compliant_count"
      expr: COUNT(CASE WHEN chs_compliant = TRUE THEN 1 END)
      comment: "Number of interventions with Core Humanitarian Standard compliance confirmed. Used for accountability reporting to donors and cluster leads."
    - name: "safeguarding_applied_count"
      expr: COUNT(CASE WHEN safeguarding_policy_applied = TRUE THEN 1 END)
      comment: "Number of interventions with safeguarding policy applied. Critical for PSEA compliance audits and donor requirements."
    - name: "gender_marker_avg_score"
      expr: AVG(CAST(gender_marker_score AS DOUBLE))
      comment: "Average gender marker score across interventions. Used to assess gender mainstreaming quality across the portfolio, aligned with IASC gender marker standards."
    - name: "disability_inclusion_marker_avg_score"
      expr: AVG(CAST(disability_inclusion_marker_score AS DOUBLE))
      comment: "Average disability inclusion marker score. Used to track inclusion quality across the portfolio per IASC and donor requirements."
    - name: "emergency_intervention_count"
      expr: COUNT(CASE WHEN intervention_type = 'Emergency' THEN 1 END)
      comment: "Count of emergency-type interventions. Used for humanitarian response portfolio analysis and OCHA reporting."
    - name: "multi_sector_intervention_count"
      expr: COUNT(CASE WHEN sphere_standards_applied = TRUE THEN 1 END)
      comment: "Count of interventions with Sphere standards applied. Proxy for humanitarian quality compliance in the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_budget_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial planning KPIs for programme budget plans. Covers budget composition by cost category, cost-sharing, and indirect cost rates. Supports IPSAS project budget reporting, US GAAP ASC 958 functional expense analysis, and donor financial reporting requirements. Relevant for SAP VISION, eZHACT, and finance system reconciliation."
  source: "`vibe_ngo_v1`.`program`.`budget_plan`"
  dimensions:
    - name: "budget_status"
      expr: CAST(budget_status AS STRING)
      comment: "Approval and lifecycle status of the budget plan. Used to filter active vs. draft vs. approved budgets."
    - name: "budget_type"
      expr: CAST(budget_type AS STRING)
      comment: "Type of budget plan (e.g. Original, Revised, Supplemental). Used to track budget evolution over the programme lifecycle."
    - name: "budget_version_number"
      expr: budget_version_number
      comment: "Version identifier for the budget plan. Used to compare budget iterations and track amendments."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code for the budget plan. Used for donor reporting and international aid transparency (IATI) compliance."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment tag for the budget plan. Used for SDG contribution reporting."
    - name: "budget_period_start_year"
      expr: DATE_TRUNC('YEAR', budget_period_start_date)
      comment: "Fiscal year the budget period starts. Used for annual budget cycle analysis."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Indicates whether the budget plan is visible to donors. Used for donor reporting and transparency management."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_budget_amount AS DOUBLE))
      comment: "Total approved budget amount across all budget plans. Primary financial KPI for programme investment reporting under IPSAS and ASC 958."
    - name: "total_personnel_costs"
      expr: SUM(CAST(personnel_costs AS DOUBLE))
      comment: "Total personnel costs across budget plans. Used for workforce cost analysis and functional expense reporting."
    - name: "total_direct_costs"
      expr: SUM(CAST(total_direct_costs AS DOUBLE))
      comment: "Total direct programme costs. Used for cost efficiency analysis and donor financial reporting."
    - name: "total_indirect_costs"
      expr: SUM(CAST(indirect_costs AS DOUBLE))
      comment: "Total indirect/overhead costs. Used to assess cost recovery and NICRA compliance."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-sharing contributions across budget plans. Used for donor leverage reporting and cost-share compliance tracking."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate across budget plans. Used to monitor NICRA compliance and overhead efficiency."
    - name: "total_travel_costs"
      expr: SUM(CAST(travel_costs AS DOUBLE))
      comment: "Total travel costs across budget plans. Used for operational cost analysis and donor budget justification."
    - name: "total_equipment_costs"
      expr: SUM(CAST(equipment_costs AS DOUBLE))
      comment: "Total equipment costs. Used for asset planning and donor prior-approval tracking."
    - name: "total_supplies_costs"
      expr: SUM(CAST(supplies_costs AS DOUBLE))
      comment: "Total supplies and materials costs. Used for supply chain budget alignment and procurement planning."
    - name: "budget_plan_count"
      expr: COUNT(1)
      comment: "Total number of budget plans. Used to assess planning activity volume and amendment frequency."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_budget_plan_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level budget KPIs for granular cost analysis. Supports functional expense reporting under IPSAS and ASC 958, donor budget line tracking, and cost-sharing compliance. Used in SAP VISION, eZHACT, and finance reconciliation workflows."
  source: "`vibe_ngo_v1`.`program`.`budget_plan_line`"
  dimensions:
    - name: "cost_category"
      expr: CAST(cost_category AS STRING)
      comment: "High-level cost category (e.g. Personnel, Travel, Supplies). Used for functional expense analysis."
    - name: "cost_subcategory"
      expr: CAST(cost_subcategory AS STRING)
      comment: "Sub-category of cost for granular budget analysis."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code at the line level. Used for IATI and donor sector reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget line. Used for annual budget cycle and multi-year programme analysis."
    - name: "direct_cost_flag"
      expr: direct_cost_flag
      comment: "Indicates whether the line is a direct cost. Used to separate direct vs. indirect cost reporting."
    - name: "cost_sharing_flag"
      expr: cost_sharing_flag
      comment: "Indicates whether the line includes cost-sharing. Used for cost-share compliance and donor leverage reporting."
    - name: "allowable_cost_flag"
      expr: allowable_cost_flag
      comment: "Indicates whether the cost is allowable under the award. Used for compliance and audit readiness."
    - name: "budget_period_start_year"
      expr: DATE_TRUNC('YEAR', budget_period_start_date)
      comment: "Year the budget line period starts. Used for annual cost planning analysis."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment at the budget line level. Used for SDG contribution financial reporting."
  measures:
    - name: "total_planned_amount"
      expr: SUM(CAST(total_planned_amount AS DOUBLE))
      comment: "Total planned budget amount across all lines. Core financial KPI for budget execution monitoring."
    - name: "total_cost_sharing_amount"
      expr: SUM(CAST(cost_sharing_amount AS DOUBLE))
      comment: "Total cost-sharing amount at line level. Used for donor leverage and cost-share compliance reporting."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across budget lines. Used for cost benchmarking and value-for-money analysis."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of units budgeted. Used for procurement planning and supply chain alignment."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate at line level. Used for NICRA compliance monitoring."
    - name: "direct_cost_line_count"
      expr: COUNT(CASE WHEN direct_cost_flag = TRUE THEN 1 END)
      comment: "Number of direct cost budget lines. Used to assess direct programme investment vs. overhead."
    - name: "cost_sharing_line_count"
      expr: COUNT(CASE WHEN cost_sharing_flag = TRUE THEN 1 END)
      comment: "Number of budget lines with cost-sharing. Used for cost-share compliance and donor reporting."
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Total number of budget plan lines. Used to assess budget granularity and planning completeness."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Portfolio-level KPIs for the programme master entity. Covers programme count, budget scale, multi-year and emergency programme composition, and strategic alignment. Used by programme directors and executives for portfolio steering. Aligns with eTools programme management and SAP VISION financial systems."
  source: "`vibe_ngo_v1`.`program`.`program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Lifecycle status of the programme (e.g. Active, Closed, Pipeline). Primary filter for portfolio dashboards."
    - name: "program_type"
      expr: program_type
      comment: "Type of programme (e.g. Emergency, Development, Resilience). Used to segment portfolio by modality."
    - name: "sector_code"
      expr: sector_code
      comment: "Sector code for the programme. Aligns with OCHA cluster system and DAC sector codes."
    - name: "sector_name"
      expr: sector_name
      comment: "Human-readable sector name. Used for portfolio reporting and donor communications."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic coverage of the programme. Used for geographic portfolio analysis."
    - name: "region"
      expr: region
      comment: "Regional classification of the programme. Used for regional portfolio analysis and resource allocation."
    - name: "is_emergency"
      expr: is_emergency
      comment: "Boolean flag for emergency programmes. Used to separate humanitarian emergency from development portfolio."
    - name: "is_multi_year"
      expr: is_multi_year
      comment: "Boolean flag for multi-year programmes. Used for long-term planning and multi-year funding analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the programme. Used for risk-based portfolio management and oversight prioritization."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the programme. Used for SDG contribution reporting."
    - name: "start_year"
      expr: DATE_TRUNC('YEAR', start_date)
      comment: "Year the programme started. Used for cohort and vintage analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the programme. Used for compliance monitoring and donor audit readiness."
  measures:
    - name: "total_programs"
      expr: COUNT(1)
      comment: "Total number of programmes in the portfolio. Baseline KPI for portfolio size reporting."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total programme budget across the portfolio. Core financial KPI for investment reporting under IPSAS and ASC 958."
    - name: "avg_budget_per_program"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per programme. Used to assess typical investment scale and identify outliers."
    - name: "active_program_count"
      expr: COUNT(CASE WHEN program_status = 'Active' THEN 1 END)
      comment: "Number of currently active programmes. Used by programme directors to assess operational load."
    - name: "emergency_program_count"
      expr: COUNT(CASE WHEN is_emergency = TRUE THEN 1 END)
      comment: "Number of emergency programmes. Used for humanitarian response portfolio analysis."
    - name: "multi_year_program_count"
      expr: COUNT(CASE WHEN is_multi_year = TRUE THEN 1 END)
      comment: "Number of multi-year programmes. Used for long-term funding pipeline and sustainability analysis."
    - name: "high_risk_program_count"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN 1 END)
      comment: "Number of high-risk programmes. Used for risk-based oversight and resource allocation decisions."
    - name: "distinct_sectors_count"
      expr: COUNT(DISTINCT sector_code)
      comment: "Number of distinct sectors covered by the portfolio. Used to assess sectoral breadth and diversification."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_humanitarian_response_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for Humanitarian Response Plans (HRPs) and Flash Appeals. Tracks funding requirements, coverage, and people-in-need vs. people-targeted ratios. Aligns with OCHA FTS reporting, UN IPSAS project accounting, and cluster coordination dashboards. Critical for executive humanitarian response oversight."
  source: "`vibe_ngo_v1`.`program`.`humanitarian_response_plan`"
  dimensions:
    - name: "hrp_status"
      expr: hrp_status
      comment: "Status of the HRP (e.g. Active, Closed, Draft). Used to filter current vs. historical plans."
    - name: "appeal_type"
      expr: appeal_type
      comment: "Type of appeal (e.g. HRP, Flash Appeal, Regional Response Plan). Used to segment by response modality."
    - name: "lead_cluster"
      expr: lead_cluster
      comment: "Lead cluster for the HRP. Used for cluster coordination analysis and resource allocation."
    - name: "coordinating_agency"
      expr: coordinating_agency
      comment: "Lead coordinating agency (e.g. OCHA, UNHCR). Used for inter-agency coordination reporting."
    - name: "plan_year"
      expr: plan_year
      comment: "Year of the HRP. Used for annual humanitarian response cycle analysis."
    - name: "funding_currency_code"
      expr: funding_currency_code
      comment: "Currency of the funding amounts. Used for multi-currency financial analysis."
    - name: "plan_start_year"
      expr: DATE_TRUNC('YEAR', plan_start_date)
      comment: "Year the plan started. Used for temporal analysis of humanitarian response cycles."
  measures:
    - name: "total_funded_amount"
      expr: SUM(CAST(total_funded_amount AS DOUBLE))
      comment: "Total funded amount across all HRPs. Used to assess funding mobilization success against requirements."
    - name: "avg_funding_coverage_percent"
      expr: AVG(CAST(funding_coverage_percent AS DOUBLE))
      comment: "Average funding coverage percentage across HRPs. Used to assess overall humanitarian funding gap at portfolio level."
    - name: "total_people_in_need"
      expr: SUM(CAST(people_in_need AS DOUBLE))
      comment: "Total people in need across all HRPs. Core humanitarian scale KPI for executive and donor reporting."
    - name: "total_people_targeted"
      expr: SUM(CAST(people_targeted AS DOUBLE))
      comment: "Total people targeted for assistance across all HRPs. Used to assess response ambition vs. need."
    - name: "total_people_reached"
      expr: SUM(CAST(people_reached_count AS DOUBLE))
      comment: "Total people reached across all HRPs. Used to measure humanitarian response delivery against targets."
    - name: "total_funding_received"
      expr: SUM(CAST(funding_received_amount AS DOUBLE))
      comment: "Total funding received across all HRPs. Used for cash flow and funding pipeline analysis."
    - name: "active_hrp_count"
      expr: COUNT(CASE WHEN hrp_status = 'Active' THEN 1 END)
      comment: "Number of active HRPs. Used to assess current humanitarian response portfolio scale."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_closeout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for programme closeout quality and financial reconciliation. Tracks budget utilization, variance, compliance certification, and donor sign-off status. Critical for grant closeout audits, donor reporting, and IPSAS/ASC 958 financial closure. Used in SAP VISION and eZHACT closeout workflows."
  source: "`vibe_ngo_v1`.`program`.`program_closeout`"
  dimensions:
    - name: "closeout_status"
      expr: closeout_status
      comment: "Status of the closeout process (e.g. In Progress, Complete, Pending Donor Sign-off). Used to track closeout pipeline."
    - name: "closeout_type"
      expr: closeout_type
      comment: "Type of closeout (e.g. Planned, Early Termination). Used to segment closeout analysis by cause."
    - name: "donor_signoff_status"
      expr: donor_signoff_status
      comment: "Status of donor sign-off on the closeout. Used for donor relationship and compliance management."
    - name: "compliance_certification_flag"
      expr: compliance_certification_flag
      comment: "Indicates whether compliance certification has been obtained. Used for audit readiness and donor reporting."
    - name: "outstanding_obligations_flag"
      expr: outstanding_obligations_flag
      comment: "Indicates whether there are outstanding financial obligations. Used for financial risk management."
    - name: "audit_completion_status"
      expr: audit_completion_status
      comment: "Status of the closeout audit. Used for audit management and donor compliance reporting."
    - name: "completion_year"
      expr: DATE_TRUNC('YEAR', completion_date)
      comment: "Year the programme was completed. Used for closeout cohort analysis."
    - name: "final_financial_reconciliation_status"
      expr: final_financial_reconciliation_status
      comment: "Status of final financial reconciliation. Used for finance team closeout tracking."
  measures:
    - name: "total_final_budget"
      expr: SUM(CAST(final_budget_amount AS DOUBLE))
      comment: "Total final approved budget across closed programmes. Used for portfolio financial closure reporting."
    - name: "total_final_expenditure"
      expr: SUM(CAST(final_expenditure_amount AS DOUBLE))
      comment: "Total final expenditure across closed programmes. Core KPI for financial accountability and donor reporting."
    - name: "avg_budget_utilization_pct"
      expr: AVG(CAST(budget_utilization_percentage AS DOUBLE))
      comment: "Average budget utilization percentage at closeout. Used to assess programme financial efficiency and identify under/over-spending patterns."
    - name: "total_budget_variance"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total budget variance (final budget minus final expenditure) across closed programmes. Used for financial risk and efficiency analysis."
    - name: "closeout_count"
      expr: COUNT(1)
      comment: "Total number of programme closeouts. Used to track closeout pipeline volume."
    - name: "compliant_closeout_count"
      expr: COUNT(CASE WHEN compliance_certification_flag = TRUE THEN 1 END)
      comment: "Number of closeouts with compliance certification obtained. Used for compliance quality reporting."
    - name: "donor_signoff_complete_count"
      expr: COUNT(CASE WHEN donor_signoff_status = 'Complete' THEN 1 END)
      comment: "Number of closeouts with donor sign-off complete. Used for donor relationship management and grant closure tracking."
    - name: "outstanding_obligations_count"
      expr: COUNT(CASE WHEN outstanding_obligations_flag = TRUE THEN 1 END)
      comment: "Number of closeouts with outstanding financial obligations. Used for financial risk management and audit preparation."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_review_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for programme review events including progress reviews, donor reports, and evaluations. Tracks beneficiary reach, financial performance, and compliance quality. Supports Results-Based Management (RBM) reporting, IPSAS project performance disclosure, and donor accountability. Used in eTools and InSight BI systems."
  source: "`vibe_ngo_v1`.`program`.`review_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of review event (e.g. Quarterly Review, Mid-Term Review, Final Evaluation). Used to segment review analysis by type."
    - name: "event_status"
      expr: event_status
      comment: "Status of the review event (e.g. Planned, In Progress, Complete). Used to track review pipeline."
    - name: "chs_compliance_flag"
      expr: chs_compliance_flag
      comment: "Indicates CHS compliance at the review event level. Used for accountability and quality assurance reporting."
    - name: "sphere_standards_applied_flag"
      expr: sphere_standards_applied_flag
      comment: "Indicates Sphere standards application. Used for humanitarian quality reporting."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Indicates whether the review is visible to donors. Used for donor reporting management."
    - name: "cluster_submission_flag"
      expr: cluster_submission_flag
      comment: "Indicates whether the review was submitted to the cluster. Used for cluster coordination reporting."
    - name: "reporting_period_start_year"
      expr: DATE_TRUNC('YEAR', reporting_period_start_date)
      comment: "Year of the reporting period. Used for annual review cycle analysis."
    - name: "review_year"
      expr: DATE_TRUNC('YEAR', review_date)
      comment: "Year the review was conducted. Used for temporal analysis of review activity."
  measures:
    - name: "total_beneficiary_reach"
      expr: SUM(CAST(beneficiary_reach_total AS DOUBLE))
      comment: "Total beneficiaries reached across all review events. Core humanitarian accountability KPI for donor and cluster reporting."
    - name: "total_beneficiary_reach_female"
      expr: SUM(CAST(beneficiary_reach_female AS DOUBLE))
      comment: "Total female beneficiaries reached. Used for gender disaggregation reporting per IASC and donor requirements."
    - name: "total_beneficiary_reach_male"
      expr: SUM(CAST(beneficiary_reach_male AS DOUBLE))
      comment: "Total male beneficiaries reached. Used for gender disaggregation reporting."
    - name: "total_beneficiary_reach_children"
      expr: SUM(CAST(beneficiary_reach_children AS DOUBLE))
      comment: "Total children reached. Used for child-focused programme reporting and UNICEF/child protection donor requirements."
    - name: "total_financial_summary_budget"
      expr: SUM(CAST(financial_summary_budget_amount AS DOUBLE))
      comment: "Total budget amount reported across review events. Used for financial performance tracking."
    - name: "total_financial_summary_expenditure"
      expr: SUM(CAST(financial_summary_expenditure_amount AS DOUBLE))
      comment: "Total expenditure reported across review events. Used for financial accountability and burn rate analysis."
    - name: "review_event_count"
      expr: COUNT(1)
      comment: "Total number of review events. Used to assess review activity volume and compliance with reporting schedules."
    - name: "chs_compliant_review_count"
      expr: COUNT(CASE WHEN chs_compliance_flag = TRUE THEN 1 END)
      comment: "Number of review events with CHS compliance confirmed. Used for accountability quality reporting."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for programme risk management. Tracks risk distribution by level, category, and status. Supports risk-based programme management, donor risk reporting, and organizational risk governance. Aligns with IPSAS risk disclosure requirements and SAP risk management modules."
  source: "`vibe_ngo_v1`.`program`.`risk_register`"
  dimensions:
    - name: "risk_level"
      expr: risk_level
      comment: "Overall risk level (e.g. High, Medium, Low). Primary dimension for risk portfolio analysis."
    - name: "risk_category"
      expr: risk_category
      comment: "Category of risk (e.g. Fiduciary, Operational, Security, Reputational). Used for risk type analysis."
    - name: "risk_subcategory"
      expr: risk_subcategory
      comment: "Sub-category of risk for granular analysis."
    - name: "risk_status"
      expr: risk_status
      comment: "Status of the risk (e.g. Open, Mitigated, Closed). Used to track risk lifecycle."
    - name: "likelihood_rating"
      expr: likelihood_rating
      comment: "Likelihood rating of the risk materializing. Used for risk prioritization."
    - name: "impact_rating"
      expr: impact_rating
      comment: "Impact rating if the risk materializes. Used for risk prioritization and escalation decisions."
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Indicates whether the risk requires escalation. Used for risk governance and oversight."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the risk. Used for geographic risk analysis."
    - name: "identification_year"
      expr: DATE_TRUNC('YEAR', identification_date)
      comment: "Year the risk was identified. Used for risk trend analysis over time."
  measures:
    - name: "total_risks"
      expr: COUNT(1)
      comment: "Total number of risks in the register. Baseline KPI for risk portfolio size."
    - name: "high_risk_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Number of high-level risks. Used by leadership to prioritize risk mitigation investment."
    - name: "open_risk_count"
      expr: COUNT(CASE WHEN risk_status = 'Open' THEN 1 END)
      comment: "Number of open (unresolved) risks. Used for risk management workload and oversight prioritization."
    - name: "escalation_required_count"
      expr: COUNT(CASE WHEN escalation_required_flag = TRUE THEN 1 END)
      comment: "Number of risks requiring escalation. Used for governance and senior management attention."
    - name: "distinct_risk_categories"
      expr: COUNT(DISTINCT risk_category)
      comment: "Number of distinct risk categories present. Used to assess breadth of risk exposure across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_partner_linkage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for implementing partner performance and financial management. Tracks budget allocation, capacity assessment scores, compliance status, and monitoring visit frequency. Supports partner accountability frameworks, sub-award management, and donor due diligence reporting. Aligns with IPSAS transfer accounting and partnership management systems."
  source: "`vibe_ngo_v1`.`program`.`partner_linkage`"
  dimensions:
    - name: "partnership_status"
      expr: partnership_status
      comment: "Status of the partner linkage (e.g. Active, Suspended, Closed). Used to filter active partnerships."
    - name: "partnership_type"
      expr: partnership_type
      comment: "Type of partnership (e.g. Sub-award, MOU, Consortium). Used to segment by partnership modality."
    - name: "partnership_role"
      expr: partnership_role
      comment: "Role of the partner in the intervention (e.g. Implementing, Technical, Advocacy). Used for partner function analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the partner linkage. Used for compliance monitoring and donor reporting."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the partner. Used for risk-based partner oversight and monitoring frequency decisions."
    - name: "performance_rating"
      expr: performance_rating
      comment: "Performance rating of the partner. Used for partner performance management and renewal decisions."
    - name: "local_partner_flag"
      expr: local_partner_flag
      comment: "Indicates whether the partner is a local organization. Used for localization reporting and donor commitments."
    - name: "capacity_building_required_flag"
      expr: capacity_building_required_flag
      comment: "Indicates whether capacity building is required. Used for partner development planning."
    - name: "ip_transfer_modality"
      expr: ip_transfer_modality
      comment: "Transfer modality to the implementing partner (e.g. Direct Cash Transfer, Reimbursement). Used for financial management analysis."
    - name: "start_year"
      expr: DATE_TRUNC('YEAR', start_date)
      comment: "Year the partnership started. Used for cohort analysis of partner relationships."
  measures:
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated to implementing partners. Core KPI for sub-award financial management and localization reporting."
    - name: "avg_capacity_assessment_score"
      expr: AVG(CAST(capacity_assessment_score AS DOUBLE))
      comment: "Average capacity assessment score across partners. Used to assess partner portfolio quality and capacity building needs."
    - name: "local_partner_count"
      expr: COUNT(CASE WHEN local_partner_flag = TRUE THEN 1 END)
      comment: "Number of local partner linkages. Used for localization reporting and Grand Bargain commitment tracking."
    - name: "high_risk_partner_count"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN 1 END)
      comment: "Number of high-risk partner linkages. Used for risk-based oversight and monitoring resource allocation."
    - name: "total_partner_linkages"
      expr: COUNT(1)
      comment: "Total number of partner linkages. Used to assess partnership portfolio scale."
    - name: "distinct_partners"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of distinct implementing partner organizations. Used to assess partner diversity and concentration risk."
    - name: "capacity_building_required_count"
      expr: COUNT(CASE WHEN capacity_building_required_flag = TRUE THEN 1 END)
      comment: "Number of partners requiring capacity building. Used for partner development planning and resource allocation."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for programme amendment management. Tracks amendment volume, budget changes, timeline extensions, and compliance impact. Used for donor prior-approval management, grant amendment reporting, and programme change governance. Aligns with award management systems and SAP VISION change management."
  source: "`vibe_ngo_v1`.`program`.`program_amendment`"
  dimensions:
    - name: "amendment_status"
      expr: amendment_status
      comment: "Status of the amendment (e.g. Pending, Approved, Rejected). Used to track amendment pipeline."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (e.g. No-Cost Extension, Budget Revision, Scope Change). Used to segment amendment analysis by type."
    - name: "grant_requirement_flag"
      expr: grant_requirement_flag
      comment: "Indicates whether the amendment requires donor/grant approval. Used for prior-approval compliance tracking."
    - name: "logframe_revision_flag"
      expr: logframe_revision_flag
      comment: "Indicates whether the amendment includes a logframe revision. Used for MEL and results framework change management."
    - name: "submission_year"
      expr: DATE_TRUNC('YEAR', submission_date)
      comment: "Year the amendment was submitted. Used for temporal analysis of amendment activity."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the amendment became effective. Used for programme change timeline analysis."
  measures:
    - name: "total_amendments"
      expr: COUNT(1)
      comment: "Total number of programme amendments. Used to assess programme change frequency and management complexity."
    - name: "total_budget_change_amount"
      expr: SUM(CAST(budget_change_amount AS DOUBLE))
      comment: "Total budget change amount across all amendments. Used to assess financial scope changes and donor prior-approval requirements."
    - name: "approved_amendment_count"
      expr: COUNT(CASE WHEN amendment_status = 'Approved' THEN 1 END)
      comment: "Number of approved amendments. Used to track amendment approval rate and donor responsiveness."
    - name: "donor_approval_required_count"
      expr: COUNT(CASE WHEN grant_requirement_flag = TRUE THEN 1 END)
      comment: "Number of amendments requiring donor approval. Used for prior-approval compliance management."
    - name: "logframe_revision_count"
      expr: COUNT(CASE WHEN logframe_revision_flag = TRUE THEN 1 END)
      comment: "Number of amendments with logframe revisions. Used to track results framework stability and MEL change management."
    - name: "avg_budget_change_amount"
      expr: AVG(CAST(budget_change_amount AS DOUBLE))
      comment: "Average budget change per amendment. Used to assess typical financial scope of programme changes."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_logframe_row`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for logframe results framework performance. Tracks target vs. baseline values, budget allocation by result level, and results framework completeness. Supports RBM reporting, donor logframe compliance, and MEL quality assurance. Aligns with eTools results management and DHIS2 indicator tracking."
  source: "`vibe_ngo_v1`.`program`.`logframe_row`"
  dimensions:
    - name: "result_level"
      expr: result_level
      comment: "Level in the results hierarchy (e.g. Impact, Outcome, Output, Activity). Used to segment logframe analysis by result level."
    - name: "logframe_row_status"
      expr: logframe_row_status
      comment: "Status of the logframe row (e.g. Active, Revised, Closed). Used to filter active results framework entries."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of reporting for this result (e.g. Monthly, Quarterly, Annual). Used for reporting schedule analysis."
    - name: "dac_code"
      expr: dac_code
      comment: "DAC sector code for the logframe row. Used for sector-level results analysis."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the logframe row. Used for SDG contribution results reporting."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the result. Used for geographic results analysis."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag for active logframe rows. Used to filter current results framework."
    - name: "implementation_start_year"
      expr: DATE_TRUNC('YEAR', implementation_start_date)
      comment: "Year implementation started for this result. Used for temporal results analysis."
  measures:
    - name: "total_logframe_rows"
      expr: COUNT(1)
      comment: "Total number of logframe rows. Used to assess results framework size and complexity."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated AS DOUBLE))
      comment: "Total budget allocated across logframe rows. Used to assess resource allocation by result level."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across logframe indicators. Used to assess ambition level of the results framework."
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline value across logframe indicators. Used to contextualize target ambition and change magnitude."
    - name: "active_row_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of active logframe rows. Used to assess current results framework scope."
    - name: "outcome_level_count"
      expr: COUNT(CASE WHEN result_level = 'Outcome' THEN 1 END)
      comment: "Number of outcome-level logframe rows. Used to assess results framework depth and RBM quality."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_component`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for programme component management. Tracks component portfolio composition, budget envelopes, risk levels, and approval status. Used for programme architecture governance, donor reporting, and component-level financial oversight. Aligns with eTools programme management and SAP VISION project structures."
  source: "`vibe_ngo_v1`.`program`.`component`"
  dimensions:
    - name: "component_status"
      expr: component_status
      comment: "Status of the component (e.g. Active, Closed, Planned). Used to filter active programme components."
    - name: "component_type"
      expr: component_type
      comment: "Type of component (e.g. Technical, Administrative, Cross-cutting). Used to segment component analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the component. Used for governance and compliance tracking."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the component. Used for risk-based oversight and resource allocation."
    - name: "sector"
      expr: sector
      comment: "Sector of the component. Used for sectoral portfolio analysis."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "DAC sector code for the component. Used for donor reporting and IATI compliance."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Indicates donor visibility for the component. Used for donor reporting management."
    - name: "grant_requirement_flag"
      expr: grant_requirement_flag
      comment: "Indicates whether the component has grant requirements. Used for compliance tracking."
    - name: "start_year"
      expr: DATE_TRUNC('YEAR', start_date)
      comment: "Year the component started. Used for cohort analysis."
  measures:
    - name: "total_components"
      expr: COUNT(1)
      comment: "Total number of programme components. Used to assess programme architecture complexity."
    - name: "total_budget_envelope"
      expr: SUM(CAST(budget_envelope_amount AS DOUBLE))
      comment: "Total budget envelope across all components. Used for component-level financial planning and oversight."
    - name: "avg_budget_envelope"
      expr: AVG(CAST(budget_envelope_amount AS DOUBLE))
      comment: "Average budget envelope per component. Used to assess typical component investment scale."
    - name: "high_risk_component_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Number of high-risk components. Used for risk-based oversight prioritization."
    - name: "approved_component_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of approved components. Used to track programme readiness and governance compliance."
    - name: "distinct_sectors"
      expr: COUNT(DISTINCT sector)
      comment: "Number of distinct sectors covered by components. Used to assess sectoral breadth of the programme."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_target_population`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for target population planning and vulnerability analysis. Tracks population size, displacement status composition, and protection mainstreaming. NOTE: population count fields contain PII-adjacent aggregate data (pii_de_identified classification applies). Supports beneficiary targeting, donor reporting, and SPHERE/CHS accountability. Aligns with Kobo Toolbox assessments and UNHCR population data."
  source: "`vibe_ngo_v1`.`program`.`target_population`"
  dimensions:
    - name: "target_population_status"
      expr: target_population_status
      comment: "Status of the target population definition (e.g. Active, Revised, Closed). Used to filter current targeting."
    - name: "displacement_status"
      expr: displacement_status
      comment: "Displacement status of the target population (e.g. IDP, Refugee, Host Community). Used for displacement-disaggregated analysis. pii_de_identified classification applies to aggregate counts."
    - name: "vulnerability_category"
      expr: vulnerability_category
      comment: "Vulnerability category of the target population. Used for vulnerability-based targeting analysis. pii_de_identified classification applies."
    - name: "sector_classification"
      expr: sector_classification
      comment: "Sector classification for the target population. Used for sectoral targeting analysis."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "DAC sector code for the target population. Used for donor reporting."
    - name: "protection_mainstreaming_flag"
      expr: protection_mainstreaming_flag
      comment: "Indicates whether protection mainstreaming is applied. Used for protection quality reporting."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Indicates donor visibility for the target population. Used for donor reporting management."
    - name: "effective_start_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the target population definition became effective. Used for temporal analysis."
  measures:
    - name: "total_target_populations"
      expr: COUNT(1)
      comment: "Total number of target population definitions. Used to assess targeting coverage across the portfolio."
    - name: "protection_mainstreamed_count"
      expr: COUNT(CASE WHEN protection_mainstreaming_flag = TRUE THEN 1 END)
      comment: "Number of target populations with protection mainstreaming applied. Used for protection quality reporting and CHS compliance."
    - name: "distinct_vulnerability_categories"
      expr: COUNT(DISTINCT vulnerability_category)
      comment: "Number of distinct vulnerability categories targeted. Used to assess breadth of vulnerability-based targeting."
    - name: "distinct_displacement_statuses"
      expr: COUNT(DISTINCT displacement_status)
      comment: "Number of distinct displacement statuses targeted. Used to assess comprehensiveness of displacement-based targeting."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_intervention_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for intervention-level donor compliance requirement management. Tracks compliance effort, cost, waiver rates, and submission timeliness. Supports donor compliance reporting, audit readiness, and compliance cost analysis. Aligns with compliance management systems and SAP VISION grant management."
  source: "`vibe_ngo_v1`.`program`.`intervention_compliance`"
  dimensions:
    - name: "requirement_status"
      expr: requirement_status
      comment: "Status of the compliance requirement (e.g. Pending, Submitted, Overdue, Waived). Used to track compliance pipeline."
    - name: "waiver_granted_flag"
      expr: waiver_granted_flag
      comment: "Indicates whether a waiver was granted for the requirement. Used for compliance exception tracking."
    - name: "deliverable_format"
      expr: deliverable_format
      comment: "Format of the compliance deliverable (e.g. Report, Audit, Certification). Used to segment compliance by deliverable type."
    - name: "due_year"
      expr: DATE_TRUNC('YEAR', due_date)
      comment: "Year the compliance requirement is due. Used for compliance calendar and workload planning."
    - name: "submission_year"
      expr: DATE_TRUNC('YEAR', submission_date)
      comment: "Year the compliance requirement was submitted. Used for timeliness analysis."
  measures:
    - name: "total_compliance_requirements"
      expr: COUNT(1)
      comment: "Total number of compliance requirements across interventions. Used to assess compliance workload and resource needs."
    - name: "total_actual_effort_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE))
      comment: "Total staff hours spent on compliance activities. Used for compliance cost analysis and resource planning."
    - name: "total_associated_cost"
      expr: SUM(CAST(associated_cost_amount AS DOUBLE))
      comment: "Total cost associated with compliance activities. Used for compliance cost management and donor reporting."
    - name: "avg_effort_hours_per_requirement"
      expr: AVG(CAST(actual_effort_hours AS DOUBLE))
      comment: "Average staff hours per compliance requirement. Used for compliance efficiency benchmarking."
    - name: "waiver_granted_count"
      expr: COUNT(CASE WHEN waiver_granted_flag = TRUE THEN 1 END)
      comment: "Number of compliance requirements with waivers granted. Used for compliance exception management and donor relationship analysis."
    - name: "overdue_requirement_count"
      expr: COUNT(CASE WHEN requirement_status = 'Overdue' THEN 1 END)
      comment: "Number of overdue compliance requirements. Used for compliance risk management and escalation decisions."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_sdg_indicator_alignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for SDG indicator alignment across the programme portfolio. Tracks SDG coverage, alignment quality, and primary vs. secondary alignment distribution. Supports SDG contribution reporting to donors, UN system, and public accountability. Aligns with IATI SDG reporting standards and UN system SDG tracking."
  source: "`vibe_ngo_v1`.`program`.`program_sdg_indicator_alignment`"
  dimensions:
    - name: "sdg_goal_number"
      expr: sdg_goal_number
      comment: "SDG goal number (1-17). Used to analyze portfolio contribution by SDG goal."
    - name: "alignment_type"
      expr: alignment_type
      comment: "Type of SDG alignment (e.g. Direct, Indirect, Enabling). Used to assess quality of SDG contribution."
    - name: "alignment_status"
      expr: alignment_status
      comment: "Status of the SDG alignment (e.g. Active, Pending Review). Used to filter current alignments."
    - name: "is_primary"
      expr: is_primary
      comment: "Indicates whether this is the primary SDG alignment. Used to distinguish primary from secondary SDG contributions."
    - name: "sdg_target_code"
      expr: sdg_target_code
      comment: "SDG target code (e.g. 1.1, 2.2). Used for granular SDG target-level analysis."
    - name: "created_year"
      expr: DATE_TRUNC('YEAR', created_timestamp)
      comment: "Year the alignment was created. Used for temporal analysis of SDG alignment activity."
  measures:
    - name: "total_sdg_alignments"
      expr: COUNT(1)
      comment: "Total number of SDG indicator alignments. Used to assess breadth of SDG contribution across the portfolio."
    - name: "distinct_sdg_goals_covered"
      expr: COUNT(DISTINCT sdg_goal_number)
      comment: "Number of distinct SDG goals covered by the portfolio. Used for SDG breadth reporting to donors and UN system."
    - name: "primary_alignment_count"
      expr: COUNT(CASE WHEN is_primary = TRUE THEN 1 END)
      comment: "Number of primary SDG alignments. Used to identify the portfolio's core SDG focus areas."
    - name: "distinct_sdg_targets_covered"
      expr: COUNT(DISTINCT sdg_target_code)
      comment: "Number of distinct SDG targets covered. Used for granular SDG contribution reporting."
    - name: "distinct_interventions_with_sdg"
      expr: COUNT(DISTINCT intervention_id)
      comment: "Number of distinct interventions with SDG alignments. Used to assess SDG mainstreaming coverage across the portfolio."
$$;