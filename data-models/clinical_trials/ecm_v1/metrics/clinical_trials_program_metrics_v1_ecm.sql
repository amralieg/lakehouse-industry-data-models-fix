-- Metric views for domain: program | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-06 23:23:25

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`program_clinical_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic metrics for clinical program portfolio management, tracking program investment, phase distribution, and regulatory designations to inform portfolio prioritization and resource allocation decisions."
  source: "`clinical_trials_ecm`.`program`.`clinical_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current status of the clinical program (e.g., Active, On Hold, Completed, Terminated)"
    - name: "development_phase"
      expr: development_phase
      comment: "Current development phase of the program (e.g., Phase I, II, III, IV)"
    - name: "program_type"
      expr: program_type
      comment: "Type classification of the clinical program"
    - name: "modality"
      expr: modality
      comment: "Drug modality (e.g., small molecule, biologic, gene therapy)"
    - name: "portfolio_priority"
      expr: portfolio_priority
      comment: "Portfolio priority tier assigned to the program"
    - name: "program_start_year"
      expr: YEAR(program_start_date)
      comment: "Year the program was initiated"
    - name: "has_breakthrough_designation"
      expr: CAST(breakthrough_therapy_designation AS STRING)
      comment: "Whether the program has breakthrough therapy designation"
    - name: "has_fast_track"
      expr: CAST(fast_track_designation AS STRING)
      comment: "Whether the program has fast track designation"
    - name: "has_orphan_drug"
      expr: CAST(orphan_drug_designation AS STRING)
      comment: "Whether the program has orphan drug designation"
    - name: "target_submission_type"
      expr: target_submission_type
      comment: "Target regulatory submission type (e.g., NDA, BLA, MAA)"
  measures:
    - name: "total_programs"
      expr: COUNT(1)
      comment: "Total number of clinical programs in the portfolio"
    - name: "total_program_budget"
      expr: SUM(CAST(program_budget AS DOUBLE))
      comment: "Total budgeted investment across clinical programs in portfolio currency"
    - name: "avg_program_budget"
      expr: AVG(CAST(program_budget AS DOUBLE))
      comment: "Average budget per clinical program, indicating typical program investment size"
    - name: "programs_with_breakthrough_designation"
      expr: SUM(CASE WHEN breakthrough_therapy_designation = true THEN 1 ELSE 0 END)
      comment: "Count of programs with breakthrough therapy designation, indicating accelerated development potential"
    - name: "programs_with_fast_track"
      expr: SUM(CASE WHEN fast_track_designation = true THEN 1 ELSE 0 END)
      comment: "Count of programs with fast track designation"
    - name: "programs_requiring_dsmb"
      expr: SUM(CASE WHEN dsmb_required = true THEN 1 ELSE 0 END)
      comment: "Count of programs requiring Data Safety Monitoring Board oversight, indicating safety complexity"
    - name: "regulatory_designation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN breakthrough_therapy_designation = true OR fast_track_designation = true OR orphan_drug_designation = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of programs with at least one regulatory designation, indicating portfolio regulatory advantage"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`program_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial metrics for clinical program budgets, tracking total approved amounts, budget composition by functional area, and contingency reserves to support financial governance and cost management."
  source: "`clinical_trials_ecm`.`program`.`budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current approval/lifecycle status of the budget"
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., initial, revised, supplemental)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year the budget applies to"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of the budget"
    - name: "is_locked"
      expr: CAST(is_locked AS STRING)
      comment: "Whether the budget is locked from further changes"
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_amount AS DOUBLE))
      comment: "Total approved budget amount across all programs"
    - name: "total_contingency"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency reserves allocated across budgets"
    - name: "contingency_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(contingency_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_approved_amount AS DOUBLE)), 0), 2)
      comment: "Contingency as percentage of total approved budget, indicating risk buffer adequacy"
    - name: "total_cro_budget"
      expr: SUM(CAST(cro_budget_amount AS DOUBLE))
      comment: "Total budget allocated to CRO partners"
    - name: "cro_spend_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(cro_budget_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_approved_amount AS DOUBLE)), 0), 2)
      comment: "CRO spend as percentage of total budget, indicating outsourcing intensity"
    - name: "avg_budget_per_program"
      expr: AVG(CAST(total_approved_amount AS DOUBLE))
      comment: "Average approved budget per budget record"
    - name: "total_clinical_ops_budget"
      expr: SUM(CAST(clinical_ops_budget_amount AS DOUBLE))
      comment: "Total clinical operations budget allocation"
    - name: "total_regulatory_budget"
      expr: SUM(CAST(regulatory_budget_amount AS DOUBLE))
      comment: "Total regulatory affairs budget allocation"
    - name: "phase3_budget_concentration_pct"
      expr: ROUND(100.0 * SUM(CAST(phase3_budget_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_approved_amount AS DOUBLE)), 0), 2)
      comment: "Phase 3 budget as percentage of total, indicating late-stage investment concentration"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`program_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk management metrics for clinical programs, tracking risk exposure, safety impacts, and resolution timelines to support proactive risk governance and mitigation planning."
  source: "`clinical_trials_ecm`.`program`.`risk`"
  dimensions:
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk (e.g., Open, Mitigated, Closed)"
    - name: "risk_category"
      expr: risk_category
      comment: "Category classification of the risk (e.g., Operational, Regulatory, Safety)"
    - name: "impact_rating"
      expr: impact_rating
      comment: "Assessed impact severity rating"
    - name: "probability_rating"
      expr: probability_rating
      comment: "Assessed probability/likelihood rating"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the risk"
    - name: "mitigation_status"
      expr: mitigation_status
      comment: "Current status of risk mitigation efforts"
    - name: "has_patient_safety_impact"
      expr: CAST(patient_safety_impact_flag AS STRING)
      comment: "Whether the risk has potential patient safety impact"
    - name: "has_regulatory_impact"
      expr: CAST(regulatory_impact_flag AS STRING)
      comment: "Whether the risk has regulatory impact"
    - name: "escalation_required"
      expr: CAST(escalation_required AS STRING)
      comment: "Whether the risk requires escalation to governance"
  measures:
    - name: "total_open_risks"
      expr: COUNT(1)
      comment: "Total number of risks in the portfolio"
    - name: "total_financial_exposure_usd"
      expr: SUM(CAST(financial_exposure_usd AS DOUBLE))
      comment: "Total financial exposure from identified risks in USD"
    - name: "avg_financial_exposure_usd"
      expr: AVG(CAST(financial_exposure_usd AS DOUBLE))
      comment: "Average financial exposure per risk, indicating typical risk magnitude"
    - name: "patient_safety_risk_count"
      expr: SUM(CASE WHEN patient_safety_impact_flag = true THEN 1 ELSE 0 END)
      comment: "Count of risks with patient safety implications requiring priority attention"
    - name: "regulatory_impact_risk_count"
      expr: SUM(CASE WHEN regulatory_impact_flag = true THEN 1 ELSE 0 END)
      comment: "Count of risks with regulatory impact that could affect submissions or approvals"
    - name: "escalation_required_count"
      expr: SUM(CASE WHEN escalation_required = true THEN 1 ELSE 0 END)
      comment: "Count of risks requiring governance escalation"
    - name: "safety_risk_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN patient_safety_impact_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of risks with patient safety impact, indicating safety risk concentration"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`program_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program milestone execution metrics tracking on-time delivery, critical path adherence, and schedule variance to support timeline governance and proactive intervention."
  source: "`clinical_trials_ecm`.`program`.`program_milestone`"
  dimensions:
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone (e.g., Planned, In Progress, Completed, Delayed)"
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type classification of the milestone"
    - name: "is_critical_path"
      expr: CAST(is_critical_path AS STRING)
      comment: "Whether the milestone is on the critical path"
    - name: "is_regulatory_commitment"
      expr: CAST(is_regulatory_commitment AS STRING)
      comment: "Whether the milestone is a regulatory commitment"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the milestone"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating associated with the milestone"
    - name: "responsible_function"
      expr: responsible_function
      comment: "Functional area responsible for milestone delivery"
    - name: "governing_phase"
      expr: governing_phase
      comment: "Development phase the milestone belongs to"
    - name: "escalation_flag"
      expr: CAST(escalation_flag AS STRING)
      comment: "Whether the milestone has been escalated"
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total number of program milestones"
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across milestones, indicating overall progress"
    - name: "critical_path_milestones"
      expr: SUM(CASE WHEN is_critical_path = true THEN 1 ELSE 0 END)
      comment: "Count of milestones on the critical path"
    - name: "regulatory_commitment_milestones"
      expr: SUM(CASE WHEN is_regulatory_commitment = true THEN 1 ELSE 0 END)
      comment: "Count of milestones that are regulatory commitments"
    - name: "escalated_milestones"
      expr: SUM(CASE WHEN escalation_flag = true THEN 1 ELSE 0 END)
      comment: "Count of milestones that have been escalated due to risk or delay"
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN milestone_status = 'Completed' AND actual_date <= planned_date THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN milestone_status = 'Completed' THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of completed milestones delivered on or before planned date"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`program_kri_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key Risk Indicator reading metrics tracking threshold breaches, escalations, and trend analysis to support proactive quality and risk oversight across clinical programs."
  source: "`clinical_trials_ecm`.`program`.`kri_reading`"
  dimensions:
    - name: "threshold_status"
      expr: threshold_status
      comment: "RAG status of the KRI reading (e.g., Green, Amber, Red)"
    - name: "reading_status"
      expr: reading_status
      comment: "Processing status of the KRI reading"
    - name: "kri_category"
      expr: kri_category
      comment: "Category of the KRI being measured"
    - name: "trend_direction"
      expr: trend_direction
      comment: "Direction of trend (improving, stable, worsening)"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Level of escalation triggered by the reading"
    - name: "review_cycle_type"
      expr: review_cycle_type
      comment: "Type of review cycle (e.g., monthly, quarterly)"
    - name: "action_required"
      expr: CAST(action_required_flag AS STRING)
      comment: "Whether the reading requires corrective action"
    - name: "escalation_flag"
      expr: CAST(escalation_flag AS STRING)
      comment: "Whether the reading triggered an escalation"
    - name: "reading_month"
      expr: DATE_TRUNC('MONTH', reading_date)
      comment: "Month of the KRI reading for trend analysis"
  measures:
    - name: "total_readings"
      expr: COUNT(1)
      comment: "Total number of KRI readings recorded"
    - name: "avg_observed_value"
      expr: AVG(CAST(observed_value AS DOUBLE))
      comment: "Average observed KRI value across readings"
    - name: "avg_variance_from_target"
      expr: AVG(CAST(variance_from_target AS DOUBLE))
      comment: "Average variance from target threshold, indicating overall KRI health"
    - name: "breach_count"
      expr: SUM(CASE WHEN threshold_status = 'Red' THEN 1 ELSE 0 END)
      comment: "Count of critical threshold breaches (Red status)"
    - name: "breach_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN threshold_status = 'Red' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of readings in critical breach status"
    - name: "escalation_count"
      expr: SUM(CASE WHEN escalation_flag = true THEN 1 ELSE 0 END)
      comment: "Count of readings that triggered governance escalation"
    - name: "action_required_count"
      expr: SUM(CASE WHEN action_required_flag = true THEN 1 ELSE 0 END)
      comment: "Count of readings requiring corrective action"
    - name: "action_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN action_required_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of readings requiring action, indicating overall program quality health"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`program_decision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program decision metrics tracking investment decisions, go/no-go outcomes, and governance effectiveness to support decision quality assessment and portfolio steering."
  source: "`clinical_trials_ecm`.`program`.`decision`"
  dimensions:
    - name: "decision_type"
      expr: decision_type
      comment: "Type of decision (e.g., Go/No-Go, Phase Transition, Investment)"
    - name: "decision_status"
      expr: decision_status
      comment: "Current status of the decision"
    - name: "outcome"
      expr: outcome
      comment: "Decision outcome (e.g., Approved, Rejected, Deferred)"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area context of the decision"
    - name: "phase_from"
      expr: phase_from
      comment: "Development phase the decision transitions from"
    - name: "phase_to"
      expr: phase_to
      comment: "Development phase the decision transitions to"
    - name: "decision_year"
      expr: YEAR(decision_date)
      comment: "Year the decision was made"
    - name: "has_safety_signal"
      expr: CAST(safety_signal_flag AS STRING)
      comment: "Whether the decision involved a safety signal consideration"
    - name: "sponsor_concurrence"
      expr: CAST(sponsor_concurrence_flag AS STRING)
      comment: "Whether sponsor concurrence was obtained"
  measures:
    - name: "total_decisions"
      expr: COUNT(1)
      comment: "Total number of program decisions recorded"
    - name: "total_investment_amount"
      expr: SUM(CAST(investment_amount AS DOUBLE))
      comment: "Total investment amount committed through decisions"
    - name: "avg_investment_per_decision"
      expr: AVG(CAST(investment_amount AS DOUBLE))
      comment: "Average investment amount per decision, indicating typical decision magnitude"
    - name: "safety_signal_decisions"
      expr: SUM(CASE WHEN safety_signal_flag = true THEN 1 ELSE 0 END)
      comment: "Count of decisions involving safety signal considerations"
    - name: "sponsor_concurrence_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sponsor_concurrence_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of decisions with sponsor concurrence, indicating alignment quality"
    - name: "dissenting_opinion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN dissenting_opinion_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of decisions with dissenting opinions, indicating governance debate health"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`program_resource_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Resource planning metrics tracking FTE allocation, cost forecasting, and resource gaps to support workforce planning and capacity management across clinical programs."
  source: "`clinical_trials_ecm`.`program`.`program_resource_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the resource plan"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of resource plan (e.g., internal, outsourced, hybrid)"
    - name: "functional_area"
      expr: functional_area
      comment: "Functional area the resources are planned for"
    - name: "resource_category"
      expr: resource_category
      comment: "Category of resource (e.g., FTE, contractor, vendor)"
    - name: "development_phase"
      expr: development_phase
      comment: "Development phase the resource plan covers"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area the resources support"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the resource plan"
    - name: "planning_granularity"
      expr: planning_granularity
      comment: "Granularity level of the plan (e.g., monthly, quarterly)"
  measures:
    - name: "total_planned_fte"
      expr: SUM(CAST(planned_fte_count AS DOUBLE))
      comment: "Total planned FTE count across resource plans"
    - name: "total_actual_fte"
      expr: SUM(CAST(actual_fte_count AS DOUBLE))
      comment: "Total actual FTE deployed"
    - name: "total_resource_gap_fte"
      expr: SUM(CAST(resource_gap_fte AS DOUBLE))
      comment: "Total FTE gap (unfilled positions) across programs"
    - name: "fte_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_fte_count AS DOUBLE)) / NULLIF(SUM(CAST(planned_fte_count AS DOUBLE)), 0), 2)
      comment: "Percentage of planned FTEs actually filled, indicating staffing adequacy"
    - name: "total_planned_cost_usd"
      expr: SUM(CAST(planned_cost_usd AS DOUBLE))
      comment: "Total planned resource cost in USD"
    - name: "total_forecasted_cost_usd"
      expr: SUM(CAST(forecasted_cost_usd AS DOUBLE))
      comment: "Total forecasted resource cost in USD"
    - name: "cost_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(forecasted_cost_usd AS DOUBLE)) - SUM(CAST(planned_cost_usd AS DOUBLE))) / NULLIF(SUM(CAST(planned_cost_usd AS DOUBLE)), 0), 2)
      comment: "Percentage variance between forecasted and planned costs, indicating budget pressure"
    - name: "total_planned_hours"
      expr: SUM(CAST(planned_hours AS DOUBLE))
      comment: "Total planned hours across resource plans"
    - name: "hours_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(forecasted_hours AS DOUBLE)) / NULLIF(SUM(CAST(planned_hours AS DOUBLE)), 0), 2)
      comment: "Forecasted hours as percentage of planned hours, indicating capacity utilization"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`program_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Protocol amendment metrics tracking amendment volume, types, and impact flags to assess protocol stability and change management effectiveness."
  source: "`clinical_trials_ecm`.`program`.`amendment`"
  dimensions:
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the amendment (e.g., Draft, Approved, Implemented)"
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (e.g., Substantial, Non-substantial)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the amendment"
    - name: "amendment_year"
      expr: YEAR(amendment_date)
      comment: "Year the amendment was initiated"
    - name: "has_budget_impact"
      expr: CAST(budget_impact_flag AS STRING)
      comment: "Whether the amendment has budget impact"
    - name: "has_regulatory_impact"
      expr: CAST(regulatory_impact_flag AS STRING)
      comment: "Whether the amendment has regulatory impact"
    - name: "has_safety_impact"
      expr: CAST(safety_impact_flag AS STRING)
      comment: "Whether the amendment has safety impact"
    - name: "has_timeline_impact"
      expr: CAST(timeline_impact_flag AS STRING)
      comment: "Whether the amendment has timeline impact"
  measures:
    - name: "total_amendments"
      expr: COUNT(1)
      comment: "Total number of protocol amendments"
    - name: "budget_impacting_amendments"
      expr: SUM(CASE WHEN budget_impact_flag = true THEN 1 ELSE 0 END)
      comment: "Count of amendments with budget impact"
    - name: "regulatory_impacting_amendments"
      expr: SUM(CASE WHEN regulatory_impact_flag = true THEN 1 ELSE 0 END)
      comment: "Count of amendments requiring regulatory notification"
    - name: "safety_impacting_amendments"
      expr: SUM(CASE WHEN safety_impact_flag = true THEN 1 ELSE 0 END)
      comment: "Count of amendments with safety implications"
    - name: "multi_impact_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN (CASE WHEN budget_impact_flag = true THEN 1 ELSE 0 END + CASE WHEN regulatory_impact_flag = true THEN 1 ELSE 0 END + CASE WHEN safety_impact_flag = true THEN 1 ELSE 0 END + CASE WHEN timeline_impact_flag = true THEN 1 ELSE 0 END) >= 2 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of amendments impacting multiple dimensions (budget, regulatory, safety, timeline), indicating protocol instability severity"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`program_timeline_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Timeline event execution metrics tracking schedule adherence, critical path performance, and delay patterns to support proactive timeline management."
  source: "`clinical_trials_ecm`.`program`.`timeline_event`"
  dimensions:
    - name: "event_status"
      expr: event_status
      comment: "Current status of the timeline event"
    - name: "event_type"
      expr: event_type
      comment: "Type of timeline event"
    - name: "event_category"
      expr: event_category
      comment: "Category of the timeline event"
    - name: "critical_path_flag"
      expr: CAST(critical_path_flag AS STRING)
      comment: "Whether the event is on the critical path"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the event"
    - name: "priority"
      expr: priority
      comment: "Priority of the timeline event"
    - name: "delay_reason_code"
      expr: delay_reason_code
      comment: "Coded reason for delay if applicable"
    - name: "responsible_role"
      expr: responsible_role
      comment: "Role responsible for the event"
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of timeline events"
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across timeline events"
    - name: "critical_path_events"
      expr: SUM(CASE WHEN critical_path_flag = true THEN 1 ELSE 0 END)
      comment: "Count of events on the critical path"
    - name: "delayed_events"
      expr: SUM(CASE WHEN event_status = 'Delayed' OR (actual_date IS NOT NULL AND planned_date IS NOT NULL AND actual_date > planned_date) THEN 1 ELSE 0 END)
      comment: "Count of events that are delayed beyond planned date"
    - name: "critical_path_delay_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN critical_path_flag = true AND actual_date IS NOT NULL AND planned_date IS NOT NULL AND actual_date > planned_date THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN critical_path_flag = true AND actual_date IS NOT NULL THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of completed critical path events that were delayed, indicating schedule risk"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`program_team_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Team composition and compliance metrics tracking FTE allocation, GCP certification status, and confidentiality compliance to support workforce governance and training oversight."
  source: "`clinical_trials_ecm`.`program`.`team_member`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the team member assignment"
    - name: "program_role"
      expr: program_role
      comment: "Role of the team member within the program"
    - name: "role_category"
      expr: role_category
      comment: "Category of the role (e.g., Clinical, Regulatory, Data Management)"
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (e.g., Full-time, Part-time, Advisory)"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (e.g., Employee, Contractor, Vendor)"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the team member"
    - name: "gcp_certification_status"
      expr: gcp_certification_status
      comment: "GCP certification status of the team member"
    - name: "therapeutic_area_expertise"
      expr: therapeutic_area_expertise
      comment: "Therapeutic area expertise of the team member"
  measures:
    - name: "total_team_members"
      expr: COUNT(1)
      comment: "Total number of team member assignments"
    - name: "avg_fte_allocation_pct"
      expr: AVG(CAST(fte_allocation_percentage AS DOUBLE))
      comment: "Average FTE allocation percentage per team member assignment"
    - name: "total_fte_allocated"
      expr: SUM(CAST(fte_allocation_percentage AS DOUBLE)) / 100.0
      comment: "Total FTE equivalents allocated (sum of allocation percentages / 100)"
    - name: "confidentiality_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN confidentiality_agreement_signed = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of team members with signed confidentiality agreements"
    - name: "gcp_certified_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN gcp_certification_status = 'Current' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of team members with current GCP certification, critical for regulatory compliance"
    - name: "primary_contacts"
      expr: SUM(CASE WHEN is_primary_contact = true THEN 1 ELSE 0 END)
      comment: "Count of team members designated as primary contacts"
$$;