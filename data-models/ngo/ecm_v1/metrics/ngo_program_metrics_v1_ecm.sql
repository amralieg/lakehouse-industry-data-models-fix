-- Metric views for domain: program | Business: Ngo | Version: 1 | Generated on: 2026-05-07 01:23:35

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`program_intervention`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core intervention performance metrics tracking budget execution, beneficiary reach, and program lifecycle for strategic decision-making on resource allocation and program effectiveness"
  source: "`ngo_ecm`.`program`.`intervention`"
  dimensions:
    - name: "intervention_status"
      expr: intervention_status
      comment: "Current lifecycle status of the intervention (active, planned, closed, etc.) for pipeline and portfolio analysis"
    - name: "intervention_type"
      expr: intervention_type
      comment: "Classification of intervention modality (emergency response, development, capacity building, etc.)"
    - name: "sector"
      expr: sector
      comment: "Primary humanitarian or development sector (health, WASH, education, protection, etc.)"
    - name: "sub_sector"
      expr: sub_sector
      comment: "Detailed sector classification for granular program analysis"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic coverage level (national, regional, district, community) for territorial analysis"
    - name: "phase"
      expr: phase
      comment: "Program implementation phase (design, startup, implementation, closeout) for lifecycle tracking"
    - name: "sdg_goal_primary"
      expr: sdg_goal_primary
      comment: "Primary Sustainable Development Goal alignment for impact reporting and strategic planning"
    - name: "gender_marker_score"
      expr: gender_marker_score
      comment: "IASC Gender Marker score (0-4) indicating level of gender integration for compliance and quality assurance"
    - name: "disability_inclusion_marker_score"
      expr: disability_inclusion_marker_score
      comment: "Disability inclusion marker score for accessibility and inclusion monitoring"
    - name: "budget_currency_code"
      expr: budget_currency_code
      comment: "Currency denomination for financial aggregation and multi-currency portfolio analysis"
    - name: "intervention_year"
      expr: YEAR(planned_start_date)
      comment: "Year of intervention start for temporal trend analysis and annual planning cycles"
    - name: "intervention_quarter"
      expr: CONCAT('Q', QUARTER(planned_start_date))
      comment: "Quarter of intervention start for quarterly portfolio reviews and board reporting"
    - name: "chs_compliant_flag"
      expr: CASE WHEN chs_compliant = TRUE THEN 'CHS Compliant' ELSE 'Non-Compliant' END
      comment: "Core Humanitarian Standard compliance status for quality assurance and accountability"
    - name: "safeguarding_applied_flag"
      expr: CASE WHEN safeguarding_policy_applied = TRUE THEN 'Safeguarding Applied' ELSE 'Not Applied' END
      comment: "Safeguarding policy application status for risk management and duty of care"
  measures:
    - name: "total_intervention_budget"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total approved budget across all interventions - primary financial KPI for portfolio value and resource allocation decisions"
    - name: "intervention_count"
      expr: COUNT(DISTINCT intervention_id)
      comment: "Number of unique interventions for portfolio size tracking and capacity planning"
    - name: "avg_intervention_budget"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average intervention budget size for benchmarking and resource planning"
    - name: "active_intervention_count"
      expr: COUNT(DISTINCT CASE WHEN intervention_status = 'Active' THEN intervention_id END)
      comment: "Count of currently active interventions for operational capacity and workload management"
    - name: "planned_beneficiary_reach"
      expr: SUM(CAST(REGEXP_REPLACE(target_beneficiary_count, '[^0-9]', '') AS BIGINT))
      comment: "Total planned beneficiary reach across portfolio - critical impact KPI for strategic planning and donor reporting"
    - name: "chs_compliance_rate"
      expr: COUNT(DISTINCT CASE WHEN chs_compliant = TRUE THEN intervention_id END)
      comment: "Count of CHS-compliant interventions for quality assurance monitoring (calculate rate in BI by dividing by intervention_count)"
    - name: "safeguarding_coverage_count"
      expr: COUNT(DISTINCT CASE WHEN safeguarding_policy_applied = TRUE THEN intervention_id END)
      comment: "Count of interventions with safeguarding policies applied for risk management oversight (calculate rate in BI)"
    - name: "emergency_intervention_count"
      expr: COUNT(DISTINCT CASE WHEN intervention_type = 'Emergency Response' THEN intervention_id END)
      comment: "Count of emergency response interventions for humanitarian surge capacity planning"
    - name: "avg_intervention_duration_days"
      expr: AVG(DATEDIFF(planned_end_date, planned_start_date))
      comment: "Average planned intervention duration in days for program design benchmarking and timeline planning"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`program_budget_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget planning and execution metrics tracking approved budgets, cost categories, and budget utilization for financial stewardship and donor compliance"
  source: "`ngo_ecm`.`program`.`budget_plan`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Budget approval and execution status (draft, approved, revised, closed) for financial governance"
    - name: "budget_type"
      expr: budget_type
      comment: "Budget classification (program, operational, capital, restricted) for financial planning and reporting"
    - name: "currency_code"
      expr: currency_code
      comment: "Budget currency for multi-currency financial consolidation"
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code for international development reporting and donor compliance"
    - name: "sector_classification"
      expr: sector_classification
      comment: "Sector grouping for portfolio analysis and resource allocation by thematic area"
    - name: "budget_year"
      expr: YEAR(budget_period_start_date)
      comment: "Fiscal year of budget period for annual financial planning and board reporting"
    - name: "budget_quarter"
      expr: CONCAT('Q', QUARTER(budget_period_start_date))
      comment: "Quarter of budget period for quarterly financial reviews and variance analysis"
    - name: "donor_visibility_flag"
      expr: CASE WHEN donor_visibility_flag = TRUE THEN 'Donor Visible' ELSE 'Internal Only' END
      comment: "Donor visibility classification for external reporting and transparency requirements"
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_budget_amount AS DOUBLE))
      comment: "Total approved budget amount - primary financial control KPI for budget authority and spending limits"
    - name: "total_direct_costs"
      expr: SUM(CAST(total_direct_costs AS DOUBLE))
      comment: "Sum of all direct program costs for cost structure analysis and donor reporting"
    - name: "total_indirect_costs"
      expr: SUM(CAST(indirect_costs AS DOUBLE))
      comment: "Sum of all indirect costs for overhead analysis and cost recovery planning"
    - name: "total_personnel_costs"
      expr: SUM(CAST(personnel_costs AS DOUBLE))
      comment: "Total personnel and staffing costs - largest cost driver for workforce planning and efficiency analysis"
    - name: "total_travel_costs"
      expr: SUM(CAST(travel_costs AS DOUBLE))
      comment: "Total travel and transportation costs for operational efficiency monitoring"
    - name: "total_equipment_costs"
      expr: SUM(CAST(equipment_costs AS DOUBLE))
      comment: "Total equipment and capital expenditure for asset management and procurement planning"
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-sharing contributions for co-financing tracking and donor match requirements"
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate across budget plans for overhead benchmarking and rate negotiation"
    - name: "budget_plan_count"
      expr: COUNT(DISTINCT budget_plan_id)
      comment: "Number of budget plans for financial planning workload and governance oversight"
    - name: "approved_budget_plan_count"
      expr: COUNT(DISTINCT CASE WHEN budget_status = 'Approved' THEN budget_plan_id END)
      comment: "Count of approved budget plans for financial authority tracking and spending readiness"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`program_partner_linkage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partnership performance metrics tracking partner capacity, compliance, beneficiary reach, and risk for partnership management and due diligence decisions"
  source: "`ngo_ecm`.`program`.`partner_linkage`"
  dimensions:
    - name: "partnership_status"
      expr: partnership_status
      comment: "Current partnership lifecycle status (active, suspended, closed) for partnership portfolio management"
    - name: "partnership_type"
      expr: partnership_type
      comment: "Partnership modality (sub-grant, consortium, MOU, service contract) for partnership strategy analysis"
    - name: "partnership_role"
      expr: partnership_role
      comment: "Partner role in intervention (implementing, technical, coordination) for capacity mapping"
    - name: "capacity_assessment_status"
      expr: capacity_assessment_status
      comment: "Partner capacity assessment completion status for due diligence and risk management"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Partner compliance standing for risk monitoring and partnership continuation decisions"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Partner risk classification (low, medium, high, critical) for assurance planning and oversight intensity"
    - name: "performance_rating"
      expr: performance_rating
      comment: "Partner performance score for partnership renewal and resource allocation decisions"
    - name: "local_partner_flag"
      expr: CASE WHEN local_partner_flag = TRUE THEN 'Local Partner' ELSE 'International Partner' END
      comment: "Local vs international partner classification for localization tracking and Grand Bargain commitments"
    - name: "sector_focus"
      expr: sector_focus
      comment: "Partner sector specialization for technical capacity matching and partnership strategy"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Partner geographic coverage for territorial partnership mapping and gap analysis"
    - name: "partnership_year"
      expr: YEAR(start_date)
      comment: "Year partnership commenced for partnership portfolio trend analysis"
  measures:
    - name: "total_partner_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated to partners - critical KPI for partnership investment and localization funding tracking"
    - name: "partner_linkage_count"
      expr: COUNT(DISTINCT partner_linkage_id)
      comment: "Number of partnership agreements for partnership portfolio size and management capacity"
    - name: "active_partnership_count"
      expr: COUNT(DISTINCT CASE WHEN partnership_status = 'Active' THEN partner_linkage_id END)
      comment: "Count of active partnerships for current partnership management workload"
    - name: "local_partner_count"
      expr: COUNT(DISTINCT CASE WHEN local_partner_flag = TRUE THEN partner_linkage_id END)
      comment: "Count of local partner linkages for localization agenda tracking and Grand Bargain reporting"
    - name: "high_risk_partner_count"
      expr: COUNT(DISTINCT CASE WHEN risk_rating IN ('High', 'Critical') THEN partner_linkage_id END)
      comment: "Count of high-risk partnerships requiring enhanced oversight for risk management and assurance planning"
    - name: "avg_capacity_assessment_score"
      expr: AVG(CAST(capacity_assessment_score AS DOUBLE))
      comment: "Average partner capacity score for partnership quality benchmarking and capacity building prioritization"
    - name: "total_beneficiaries_reached_via_partners"
      expr: SUM(CAST(REGEXP_REPLACE(beneficiary_reached_count, '[^0-9]', '') AS BIGINT))
      comment: "Total beneficiaries reached through partner delivery - key impact KPI for partnership effectiveness and localization outcomes"
    - name: "avg_monitoring_visits_per_partner"
      expr: AVG(CAST(REGEXP_REPLACE(monitoring_visit_count, '[^0-9]', '') AS DOUBLE))
      comment: "Average monitoring visits per partnership for assurance coverage and oversight intensity benchmarking"
    - name: "avg_partner_budget"
      expr: AVG(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Average budget per partnership for partnership sizing and resource distribution analysis"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`program_closeout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program closeout performance metrics tracking budget utilization, beneficiary achievement, compliance certification, and closeout efficiency for accountability and lessons learned"
  source: "`ngo_ecm`.`program`.`program_closeout`"
  dimensions:
    - name: "closeout_status"
      expr: closeout_status
      comment: "Closeout process status (initiated, in progress, completed, certified) for closeout pipeline management"
    - name: "closeout_type"
      expr: closeout_type
      comment: "Type of closeout (normal, early termination, extension) for closeout process analysis"
    - name: "donor_signoff_status"
      expr: donor_signoff_status
      comment: "Donor approval status for final closeout for compliance and donor relations tracking"
    - name: "compliance_certification_flag"
      expr: CASE WHEN compliance_certification_flag = TRUE THEN 'Certified' ELSE 'Not Certified' END
      comment: "Compliance certification status for audit readiness and regulatory compliance"
    - name: "audit_completion_status"
      expr: audit_completion_status
      comment: "Final audit completion status for financial accountability and donor requirements"
    - name: "asset_disposition_status"
      expr: asset_disposition_status
      comment: "Asset disposal completion status for asset management and donor asset rules compliance"
    - name: "currency_code"
      expr: currency_code
      comment: "Financial reporting currency for multi-currency closeout consolidation"
    - name: "closeout_year"
      expr: YEAR(completion_date)
      comment: "Year of closeout completion for annual closeout performance tracking"
    - name: "outstanding_obligations_flag"
      expr: CASE WHEN outstanding_obligations_flag = TRUE THEN 'Outstanding Obligations' ELSE 'No Outstanding Obligations' END
      comment: "Outstanding obligations indicator for closeout risk and financial liability tracking"
  measures:
    - name: "total_final_budget"
      expr: SUM(CAST(final_budget_amount AS DOUBLE))
      comment: "Total final approved budget at closeout for budget authority reconciliation"
    - name: "total_final_expenditure"
      expr: SUM(CAST(final_expenditure_amount AS DOUBLE))
      comment: "Total actual expenditure at closeout - critical financial accountability KPI for budget execution and donor reporting"
    - name: "total_budget_variance"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total budget variance (under/over spend) for financial management performance and forecasting accuracy"
    - name: "avg_budget_utilization_rate"
      expr: AVG(CAST(budget_utilization_percentage AS DOUBLE))
      comment: "Average budget utilization percentage - key efficiency KPI for financial management quality and resource optimization"
    - name: "closeout_count"
      expr: COUNT(DISTINCT program_closeout_id)
      comment: "Number of program closeouts for closeout workload and process capacity planning"
    - name: "completed_closeout_count"
      expr: COUNT(DISTINCT CASE WHEN closeout_status = 'Completed' THEN program_closeout_id END)
      comment: "Count of completed closeouts for closeout completion rate tracking and process efficiency"
    - name: "certified_closeout_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_certification_flag = TRUE THEN program_closeout_id END)
      comment: "Count of compliance-certified closeouts for quality assurance and audit readiness"
    - name: "total_final_beneficiaries_reached"
      expr: SUM(CAST(REGEXP_REPLACE(final_beneficiary_count, '[^0-9]', '') AS BIGINT))
      comment: "Total final beneficiaries reached at closeout - ultimate impact KPI for program effectiveness and donor accountability"
    - name: "total_female_beneficiaries"
      expr: SUM(CAST(REGEXP_REPLACE(final_beneficiary_count_female, '[^0-9]', '') AS BIGINT))
      comment: "Total female beneficiaries reached for gender-disaggregated impact reporting and gender equality commitments"
    - name: "total_male_beneficiaries"
      expr: SUM(CAST(REGEXP_REPLACE(final_beneficiary_count_male, '[^0-9]', '') AS BIGINT))
      comment: "Total male beneficiaries reached for gender-disaggregated impact reporting"
    - name: "avg_closeout_duration_days"
      expr: AVG(DATEDIFF(completion_date, initiation_date))
      comment: "Average closeout process duration in days for closeout efficiency benchmarking and process improvement"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`program_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program risk management metrics tracking risk exposure, mitigation effectiveness, and risk portfolio composition for enterprise risk management and board oversight"
  source: "`ngo_ecm`.`program`.`risk_register`"
  dimensions:
    - name: "risk_status"
      expr: risk_status
      comment: "Current risk lifecycle status (open, mitigated, closed, escalated) for risk portfolio management"
    - name: "risk_category"
      expr: risk_category
      comment: "Risk taxonomy category (operational, financial, reputational, compliance, security) for risk classification and reporting"
    - name: "risk_level"
      expr: risk_level
      comment: "Overall risk severity level (low, medium, high, critical) for risk prioritization and escalation"
    - name: "impact_rating"
      expr: impact_rating
      comment: "Risk impact severity rating for consequence assessment and response planning"
    - name: "likelihood_rating"
      expr: likelihood_rating
      comment: "Risk likelihood rating for probability assessment and risk scoring"
    - name: "affected_sector"
      expr: affected_sector
      comment: "Sector impacted by risk for sector-specific risk analysis and mitigation planning"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of risk exposure for territorial risk mapping and context analysis"
    - name: "escalation_required_flag"
      expr: CASE WHEN escalation_required_flag = TRUE THEN 'Escalation Required' ELSE 'No Escalation' END
      comment: "Escalation requirement indicator for governance and senior management attention"
    - name: "risk_year"
      expr: YEAR(identification_date)
      comment: "Year risk was identified for risk trend analysis and emerging risk detection"
  measures:
    - name: "total_risk_count"
      expr: COUNT(DISTINCT risk_register_id)
      comment: "Total number of risks in register for risk portfolio size and risk management workload"
    - name: "open_risk_count"
      expr: COUNT(DISTINCT CASE WHEN risk_status = 'Open' THEN risk_register_id END)
      comment: "Count of open risks requiring active management - key risk exposure KPI for risk appetite and board reporting"
    - name: "critical_risk_count"
      expr: COUNT(DISTINCT CASE WHEN risk_level = 'Critical' THEN risk_register_id END)
      comment: "Count of critical risks - highest priority KPI for executive attention and crisis management readiness"
    - name: "high_risk_count"
      expr: COUNT(DISTINCT CASE WHEN risk_level = 'High' THEN risk_register_id END)
      comment: "Count of high-severity risks for risk concentration analysis and mitigation resource allocation"
    - name: "escalation_required_count"
      expr: COUNT(DISTINCT CASE WHEN escalation_required_flag = TRUE THEN risk_register_id END)
      comment: "Count of risks requiring escalation for governance oversight and senior management agenda"
    - name: "avg_inherent_risk_score"
      expr: AVG(CAST(REGEXP_REPLACE(inherent_risk_score, '[^0-9.]', '') AS DOUBLE))
      comment: "Average inherent risk score before mitigation for baseline risk exposure assessment"
    - name: "avg_residual_risk_score"
      expr: AVG(CAST(REGEXP_REPLACE(residual_risk_score, '[^0-9.]', '') AS DOUBLE))
      comment: "Average residual risk score after mitigation - key KPI for risk mitigation effectiveness and risk management ROI"
    - name: "mitigated_risk_count"
      expr: COUNT(DISTINCT CASE WHEN risk_status = 'Mitigated' THEN risk_register_id END)
      comment: "Count of successfully mitigated risks for risk management performance and control effectiveness"
    - name: "closed_risk_count"
      expr: COUNT(DISTINCT CASE WHEN risk_status = 'Closed' THEN risk_register_id END)
      comment: "Count of closed risks for risk resolution tracking and risk register hygiene"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`program_review_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program review and reporting event metrics tracking beneficiary reach, financial performance, compliance, and review completion for accountability and learning"
  source: "`ngo_ecm`.`program`.`review_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Review event classification (mid-term review, final evaluation, audit, monitoring visit) for review portfolio management"
    - name: "event_status"
      expr: event_status
      comment: "Review event lifecycle status (planned, in progress, completed, approved) for review pipeline tracking"
    - name: "donor_visibility_flag"
      expr: CASE WHEN donor_visibility_flag = TRUE THEN 'Donor Visible' ELSE 'Internal Only' END
      comment: "Donor visibility classification for external reporting and transparency requirements"
    - name: "chs_compliance_flag"
      expr: CASE WHEN chs_compliance_flag = TRUE THEN 'CHS Compliant' ELSE 'Non-Compliant' END
      comment: "Core Humanitarian Standard compliance status for quality assurance"
    - name: "sphere_standards_applied_flag"
      expr: CASE WHEN sphere_standards_applied_flag = TRUE THEN 'Sphere Applied' ELSE 'Not Applied' END
      comment: "Sphere Standards application status for humanitarian quality and accountability"
    - name: "cluster_submission_flag"
      expr: CASE WHEN cluster_submission_flag = TRUE THEN 'Cluster Submitted' ELSE 'Not Submitted' END
      comment: "Humanitarian cluster reporting submission status for coordination and information management"
    - name: "financial_summary_currency_code"
      expr: financial_summary_currency_code
      comment: "Financial reporting currency for multi-currency review consolidation"
    - name: "review_year"
      expr: YEAR(review_date)
      comment: "Year of review event for annual review cycle tracking"
    - name: "review_quarter"
      expr: CONCAT('Q', QUARTER(review_date))
      comment: "Quarter of review event for quarterly reporting cycle management"
  measures:
    - name: "review_event_count"
      expr: COUNT(DISTINCT review_event_id)
      comment: "Number of review events for review workload and MEL capacity planning"
    - name: "completed_review_count"
      expr: COUNT(DISTINCT CASE WHEN event_status = 'Completed' THEN review_event_id END)
      comment: "Count of completed reviews for review completion rate and accountability tracking"
    - name: "total_beneficiaries_reported"
      expr: SUM(CAST(beneficiary_reach_total AS BIGINT))
      comment: "Total beneficiaries reported across all review events - primary impact KPI for program reach and donor reporting"
    - name: "total_female_beneficiaries_reported"
      expr: SUM(CAST(beneficiary_reach_female AS BIGINT))
      comment: "Total female beneficiaries reported for gender-disaggregated impact tracking"
    - name: "total_male_beneficiaries_reported"
      expr: SUM(CAST(beneficiary_reach_male AS BIGINT))
      comment: "Total male beneficiaries reported for gender-disaggregated impact tracking"
    - name: "total_children_beneficiaries_reported"
      expr: SUM(CAST(beneficiary_reach_children AS BIGINT))
      comment: "Total child beneficiaries reported for age-disaggregated impact and child protection monitoring"
    - name: "total_budget_reported"
      expr: SUM(CAST(financial_summary_budget_amount AS DOUBLE))
      comment: "Total budget reported in review events for financial reporting completeness"
    - name: "total_expenditure_reported"
      expr: SUM(CAST(financial_summary_expenditure_amount AS DOUBLE))
      comment: "Total expenditure reported in review events - key financial accountability KPI for budget execution tracking"
    - name: "chs_compliant_review_count"
      expr: COUNT(DISTINCT CASE WHEN chs_compliance_flag = TRUE THEN review_event_id END)
      comment: "Count of CHS-compliant reviews for quality assurance and accountability standards tracking"
    - name: "sphere_applied_review_count"
      expr: COUNT(DISTINCT CASE WHEN sphere_standards_applied_flag = TRUE THEN review_event_id END)
      comment: "Count of reviews applying Sphere Standards for humanitarian quality monitoring"
    - name: "avg_review_cycle_days"
      expr: AVG(DATEDIFF(approval_date, review_date))
      comment: "Average days from review to approval for review process efficiency and timeliness benchmarking"
$$;