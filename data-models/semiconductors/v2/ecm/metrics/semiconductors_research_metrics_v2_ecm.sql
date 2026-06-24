-- Metric views for domain: research | Business: Semiconductors | Version: 2 | Generated on: 2026-06-23 23:34:49

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for research programs — budget envelope, NRE spend, IP filing activity, and program health across the semiconductor R&D portfolio."
  source: "`vibe_semiconductors_v1`.`research`.`research_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current lifecycle status of the research program (Active, Completed, On Hold, Cancelled)."
    - name: "program_type"
      expr: program_type
      comment: "Classification of the program (Exploratory, Development, Qualification, etc.)."
    - name: "technology_platform"
      expr: technology_platform
      comment: "Technology platform targeted by the program (e.g., FinFET, GAA, FDSOI)."
    - name: "technology_generation_target"
      expr: technology_generation_target
      comment: "Target technology generation node (e.g., 3nm, 5nm, 7nm)."
    - name: "current_phase"
      expr: current_phase
      comment: "Current gate/phase of the program (Concept, Feasibility, Development, Qualification)."
    - name: "risk_level"
      expr: risk_level
      comment: "Assessed risk level of the program (Low, Medium, High, Critical)."
    - name: "chips_act_program_flag"
      expr: chips_act_program_flag
      comment: "Indicates whether the program is funded or obligated under the CHIPS Act."
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "Indicates whether the program is subject to ITAR export control restrictions."
    - name: "sponsoring_business_unit"
      expr: sponsoring_business_unit
      comment: "Business unit sponsoring and funding the research program."
    - name: "technology_readiness_level"
      expr: technology_readiness_level
      comment: "TRL rating indicating maturity of the technology under development."
    - name: "planned_start_date"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month the program was planned to start — used for cohort and pipeline analysis."
    - name: "planned_completion_date"
      expr: DATE_TRUNC('quarter', planned_completion_date)
      comment: "Quarter the program is planned to complete — used for roadmap scheduling."
  measures:
    - name: "total_programs"
      expr: COUNT(1)
      comment: "Total number of research programs — baseline portfolio size metric for executive portfolio reviews."
    - name: "total_budget_envelope_usd"
      expr: SUM(CAST(budget_envelope_amount AS DOUBLE))
      comment: "Total committed R&D budget across all programs — primary investment exposure metric for CFO and CTO."
    - name: "avg_budget_per_program_usd"
      expr: AVG(CAST(budget_envelope_amount AS DOUBLE))
      comment: "Average budget envelope per program — used to benchmark program investment levels and detect outliers."
    - name: "active_program_count"
      expr: COUNT(CASE WHEN program_status = 'Active' THEN 1 END)
      comment: "Number of currently active research programs — indicates R&D pipeline throughput and resource demand."
    - name: "chips_act_program_count"
      expr: COUNT(CASE WHEN chips_act_program_flag = TRUE THEN 1 END)
      comment: "Number of programs with CHIPS Act funding obligations — critical for regulatory compliance reporting."
    - name: "high_risk_program_count"
      expr: COUNT(CASE WHEN risk_level IN ('High', 'Critical') THEN 1 END)
      comment: "Number of programs rated High or Critical risk — triggers executive risk review and mitigation planning."
    - name: "programs_with_ip_filings"
      expr: COUNT(CASE WHEN CAST(ip_filing_count AS BIGINT) > 0 THEN 1 END)
      comment: "Number of programs that have generated at least one IP filing — measures R&D innovation output."
    - name: "total_tapeout_milestones"
      expr: SUM(CAST(tapeout_milestone_count AS BIGINT))
      comment: "Total tapeout milestones across all programs — key indicator of silicon validation pipeline activity."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project-level R&D execution KPIs — budget utilization, schedule adherence, IP output, and risk posture for semiconductor research projects."
  source: "`vibe_semiconductors_v1`.`research`.`project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the project (Active, Completed, On Hold, Cancelled)."
    - name: "project_type"
      expr: project_type
      comment: "Type of research project (Process Development, Device Architecture, Materials, IP Development, etc.)."
    - name: "phase"
      expr: phase
      comment: "Current execution phase of the project (Concept, Feasibility, Development, Qualification, Production)."
    - name: "risk_level"
      expr: risk_level
      comment: "Assessed risk level of the project (Low, Medium, High, Critical)."
    - name: "technology_node_target"
      expr: technology_node_target
      comment: "Target technology node for the project (e.g., 3nm, 5nm, 7nm)."
    - name: "technology_readiness_level"
      expr: technology_readiness_level
      comment: "TRL rating for the project's technology maturity."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of project funding (Internal, Government Grant, Collaboration, etc.)."
    - name: "research_domain"
      expr: research_domain
      comment: "Research domain focus area (Process, Device, Materials, Packaging, IP, etc.)."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Indicates whether the project is subject to ITAR export control."
    - name: "strategic_priority"
      expr: strategic_priority
      comment: "Strategic priority classification of the project (Critical, High, Medium, Low)."
    - name: "start_date_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the project started — used for cohort analysis and pipeline tracking."
    - name: "planned_end_date_quarter"
      expr: DATE_TRUNC('quarter', planned_end_date)
      comment: "Quarter the project is planned to complete — used for delivery forecasting."
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of research projects — baseline portfolio count for R&D pipeline management."
    - name: "total_nre_budget_allocated_usd"
      expr: SUM(CAST(nre_budget_allocated AS DOUBLE))
      comment: "Total NRE budget allocated across all projects — primary R&D investment commitment metric."
    - name: "total_nre_budget_spent_usd"
      expr: SUM(CAST(nre_budget_spent AS DOUBLE))
      comment: "Total NRE budget spent across all projects — actual R&D expenditure for financial tracking."
    - name: "avg_nre_budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(nre_budget_spent AS DOUBLE)) / NULLIF(SUM(CAST(nre_budget_allocated AS DOUBLE)), 0), 2)
      comment: "Average NRE budget utilization rate — measures R&D spend efficiency and budget discipline."
    - name: "active_project_count"
      expr: COUNT(CASE WHEN project_status = 'Active' THEN 1 END)
      comment: "Number of currently active research projects — indicates R&D execution capacity utilization."
    - name: "projects_with_ip_filings"
      expr: COUNT(CASE WHEN ip_filing_planned = TRUE THEN 1 END)
      comment: "Number of projects with planned IP filings — measures innovation pipeline and IP strategy execution."
    - name: "high_risk_project_count"
      expr: COUNT(CASE WHEN risk_level IN ('High', 'Critical') THEN 1 END)
      comment: "Number of high or critical risk projects — triggers executive risk review and resource reallocation decisions."
    - name: "mpw_shuttle_project_count"
      expr: COUNT(CASE WHEN mpw_shuttle_participation = TRUE THEN 1 END)
      comment: "Number of projects participating in MPW shuttle runs — indicates silicon validation activity and cost-sharing strategy."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_experimental_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Experimental wafer lot execution KPIs — yield performance, cost efficiency, and throughput for semiconductor R&D fabrication runs."
  source: "`vibe_semiconductors_v1`.`research`.`experimental_lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the experimental lot (Active, Completed, Scrapped, On Hold)."
    - name: "lot_type"
      expr: lot_type
      comment: "Type of experimental lot (Split, Baseline, DOE, Qualification, etc.)."
    - name: "experimental_outcome_status"
      expr: experimental_outcome_status
      comment: "Outcome classification of the experiment (Pass, Fail, Inconclusive, Partial Pass)."
    - name: "technology_node_nm"
      expr: technology_node_nm
      comment: "Technology node in nanometers targeted by this experimental lot."
    - name: "substrate_type"
      expr: substrate_type
      comment: "Wafer substrate type used (Bulk Silicon, SOI, SiGe, GaN, etc.)."
    - name: "priority_level"
      expr: priority_level
      comment: "Execution priority of the lot (Critical, High, Medium, Low)."
    - name: "fab_line_assignment"
      expr: fab_line_assignment
      comment: "Fab line where the experimental lot is being processed."
    - name: "is_archived"
      expr: is_archived
      comment: "Indicates whether the lot has been archived — used to filter active vs. historical analysis."
    - name: "planned_start_date_month"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month the lot was planned to start — used for capacity planning and pipeline analysis."
    - name: "actual_start_date_month"
      expr: DATE_TRUNC('month', actual_start_date)
      comment: "Month the lot actually started — used for schedule adherence analysis."
  measures:
    - name: "total_experimental_lots"
      expr: COUNT(1)
      comment: "Total number of experimental lots — baseline throughput metric for R&D fab utilization."
    - name: "total_actual_cost_usd"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE))
      comment: "Total actual cost of all experimental lots — primary R&D fabrication cost metric for budget management."
    - name: "total_estimated_cost_usd"
      expr: SUM(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Total estimated cost of experimental lots — used for budget forecasting and variance analysis."
    - name: "cost_variance_usd"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE) - CAST(estimated_cost_usd AS DOUBLE))
      comment: "Total cost variance (actual minus estimated) — measures R&D cost estimation accuracy and overrun exposure."
    - name: "avg_actual_yield_pct"
      expr: AVG(CAST(actual_yield_percent AS DOUBLE))
      comment: "Average actual yield percentage across experimental lots — key R&D process performance indicator."
    - name: "avg_target_yield_pct"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield percentage — baseline for yield gap analysis and process improvement prioritization."
    - name: "yield_attainment_pct"
      expr: ROUND(100.0 * AVG(CAST(actual_yield_percent AS DOUBLE)) / NULLIF(AVG(CAST(target_yield_percent AS DOUBLE)), 0), 2)
      comment: "Yield attainment rate (actual vs. target yield) — measures R&D process maturity and learning curve progress."
    - name: "scrapped_lot_count"
      expr: COUNT(CASE WHEN lot_status = 'Scrapped' THEN 1 END)
      comment: "Number of scrapped experimental lots — indicates process instability and wasted R&D investment."
    - name: "avg_cost_per_lot_usd"
      expr: AVG(CAST(actual_cost_usd AS DOUBLE))
      comment: "Average actual cost per experimental lot — used for R&D cost benchmarking and fab efficiency analysis."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_characterization_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Device and process characterization KPIs — measurement yield, defect density, and electrical performance metrics for semiconductor R&D learning cycles."
  source: "`vibe_semiconductors_v1`.`research`.`characterization_result`"
  dimensions:
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of characterization measurement (Electrical, Physical, Optical, Chemical, etc.)."
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the measurement result (Pass, Fail, Pending Review, Inconclusive)."
    - name: "defect_type"
      expr: defect_type
      comment: "Primary defect type identified in the characterization (Particle, Pattern, Scratch, etc.)."
    - name: "dominant_yield_detractor"
      expr: dominant_yield_detractor
      comment: "Primary yield loss mechanism identified — used for Pareto analysis and process improvement targeting."
    - name: "yield_limiting_mechanism"
      expr: yield_limiting_mechanism
      comment: "Root cause mechanism limiting yield (Lithography, Etch, Deposition, CMP, etc.)."
    - name: "device_architecture"
      expr: device_architecture
      comment: "Device architecture type characterized (FinFET, GAA, Planar, etc.)."
    - name: "pdk_calibration_flag"
      expr: pdk_calibration_flag
      comment: "Indicates whether the result was used for PDK calibration — critical for design enablement tracking."
    - name: "measurement_timestamp_month"
      expr: DATE_TRUNC('month', measurement_timestamp)
      comment: "Month of measurement — used for trend analysis and learning cycle tracking."
    - name: "learning_cycle_number"
      expr: learning_cycle_number
      comment: "Learning cycle identifier — used to track yield improvement progression across R&D iterations."
  measures:
    - name: "total_characterization_results"
      expr: COUNT(1)
      comment: "Total number of characterization measurements — baseline R&D data generation throughput metric."
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measured parameter value — tracks process parameter trends and specification compliance."
    - name: "avg_die_yield_pct"
      expr: AVG(CAST(die_yield_percent AS DOUBLE))
      comment: "Average die yield percentage from characterization — primary silicon learning metric for process development."
    - name: "avg_functional_yield_pct"
      expr: AVG(CAST(functional_yield_percent AS DOUBLE))
      comment: "Average functional yield percentage — measures device functionality rate and process maturity."
    - name: "avg_parametric_yield_pct"
      expr: AVG(CAST(parametric_yield_percent AS DOUBLE))
      comment: "Average parametric yield percentage — measures electrical parameter compliance rate."
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density AS DOUBLE))
      comment: "Average defect density across characterization results — key process cleanliness and yield predictor."
    - name: "avg_yield_improvement_delta"
      expr: AVG(CAST(yield_improvement_delta AS DOUBLE))
      comment: "Average yield improvement delta — measures R&D learning effectiveness and process optimization progress."
    - name: "pdk_calibration_result_count"
      expr: COUNT(CASE WHEN pdk_calibration_flag = TRUE THEN 1 END)
      comment: "Number of results used for PDK calibration — measures design enablement data generation rate."
    - name: "spec_upper_limit_avg"
      expr: AVG(CAST(specification_upper_limit AS DOUBLE))
      comment: "Average specification upper limit across measurements — used for process window analysis."
    - name: "spec_lower_limit_avg"
      expr: AVG(CAST(specification_lower_limit AS DOUBLE))
      comment: "Average specification lower limit across measurements — used for process window analysis."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_process_integration_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process integration run KPIs — electrical performance, yield, and TCAD correlation metrics for semiconductor process development milestones."
  source: "`vibe_semiconductors_v1`.`research`.`process_integration_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Current status of the process integration run (In Progress, Completed, Failed, Aborted)."
    - name: "pass_fail_determination"
      expr: pass_fail_determination
      comment: "Overall pass/fail determination for the integration run — primary go/no-go decision metric."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the run results (Approved, Pending, Rejected)."
    - name: "device_architecture_type"
      expr: device_architecture_type
      comment: "Device architecture type being integrated (FinFET, GAA, Planar, etc.)."
    - name: "doe_design_type"
      expr: doe_design_type
      comment: "Design of experiment type used (Full Factorial, Fractional, Response Surface, etc.)."
    - name: "pdk_contribution_flag"
      expr: pdk_contribution_flag
      comment: "Indicates whether run results contribute to PDK development — tracks design enablement progress."
    - name: "tcad_simulation_correlation_flag"
      expr: tcad_simulation_correlation_flag
      comment: "Indicates whether TCAD simulation correlation was performed — measures modeling accuracy validation."
    - name: "learning_cycle_number"
      expr: learning_cycle_number
      comment: "Learning cycle number — used to track process improvement progression across integration runs."
    - name: "run_start_month"
      expr: DATE_TRUNC('month', run_start_timestamp)
      comment: "Month the integration run started — used for throughput and cycle time trend analysis."
  measures:
    - name: "total_integration_runs"
      expr: COUNT(1)
      comment: "Total number of process integration runs — baseline R&D silicon learning throughput metric."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_determination = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of integration runs that passed — primary process development success rate KPI."
    - name: "avg_yield_pct"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across integration runs — measures process maturity and learning curve progress."
    - name: "avg_threshold_voltage_mv"
      expr: AVG(CAST(threshold_voltage_mv AS DOUBLE))
      comment: "Average transistor threshold voltage in millivolts — key electrical performance metric for process targeting."
    - name: "avg_drive_current_ua"
      expr: AVG(CAST(drive_current_ua AS DOUBLE))
      comment: "Average transistor drive current in microamps — measures device performance against design targets."
    - name: "avg_leakage_current_na"
      expr: AVG(CAST(leakage_current_na AS DOUBLE))
      comment: "Average transistor leakage current in nanoamps — critical power consumption and process quality metric."
    - name: "avg_gate_oxide_thickness_nm"
      expr: AVG(CAST(gate_oxide_thickness_nm AS DOUBLE))
      comment: "Average gate oxide thickness in nanometers — key process control metric for device reliability."
    - name: "avg_tcad_correlation_accuracy_pct"
      expr: AVG(CAST(tcad_correlation_accuracy_percentage AS DOUBLE))
      comment: "Average TCAD simulation correlation accuracy — measures predictive modeling quality for process development."
    - name: "pdk_contributing_run_count"
      expr: COUNT(CASE WHEN pdk_contribution_flag = TRUE THEN 1 END)
      comment: "Number of runs contributing to PDK development — tracks design enablement data generation velocity."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_yield_learning_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Yield learning KPIs — defect density, yield improvement deltas, and root cause analysis metrics for semiconductor R&D yield engineering."
  source: "`vibe_semiconductors_v1`.`research`.`yield_learning_record`"
  dimensions:
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of yield loss (Lithography, Etch, Deposition, CMP, Contamination, etc.)."
    - name: "dominant_yield_detractor"
      expr: dominant_yield_detractor
      comment: "Primary yield detractor identified — used for Pareto-driven improvement prioritization."
    - name: "defect_type_primary"
      expr: defect_type_primary
      comment: "Primary defect type causing yield loss — drives process engineering corrective actions."
    - name: "device_architecture_type"
      expr: device_architecture_type
      comment: "Device architecture type for which yield learning was performed."
    - name: "technology_node_nm"
      expr: technology_node_nm
      comment: "Technology node in nanometers — used to compare yield learning progress across nodes."
    - name: "learning_cycle_phase"
      expr: learning_cycle_phase
      comment: "Phase of the learning cycle (Early, Mid, Late, Production Ramp) — tracks maturity progression."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions proposed from yield learning (Open, In Progress, Closed, Verified)."
    - name: "production_applicability_flag"
      expr: production_applicability_flag
      comment: "Indicates whether the yield learning is applicable to production — measures R&D-to-production transfer value."
    - name: "pareto_analysis_performed_flag"
      expr: pareto_analysis_performed_flag
      comment: "Indicates whether Pareto analysis was performed — measures analytical rigor of yield investigations."
    - name: "analysis_date_month"
      expr: DATE_TRUNC('month', analysis_date)
      comment: "Month of yield analysis — used for trend tracking and learning velocity measurement."
  measures:
    - name: "total_yield_learning_records"
      expr: COUNT(1)
      comment: "Total number of yield learning records — baseline R&D yield engineering activity metric."
    - name: "avg_die_yield_pct"
      expr: AVG(CAST(die_yield_percentage AS DOUBLE))
      comment: "Average die yield percentage across learning records — primary yield performance KPI for R&D."
    - name: "avg_functional_yield_pct"
      expr: AVG(CAST(functional_yield_percentage AS DOUBLE))
      comment: "Average functional yield percentage — measures device functionality rate improvement over learning cycles."
    - name: "avg_baseline_yield_pct"
      expr: AVG(CAST(baseline_yield_percentage AS DOUBLE))
      comment: "Average baseline yield percentage — reference point for measuring yield improvement effectiveness."
    - name: "avg_yield_improvement_delta_pct"
      expr: AVG(CAST(yield_improvement_delta_percentage AS DOUBLE))
      comment: "Average yield improvement delta — measures R&D yield engineering effectiveness and learning velocity."
    - name: "avg_defect_density_per_cm2"
      expr: AVG(CAST(defect_density_per_cm2 AS DOUBLE))
      comment: "Average defect density per cm² — key process cleanliness metric and yield predictor."
    - name: "production_applicable_record_count"
      expr: COUNT(CASE WHEN production_applicability_flag = TRUE THEN 1 END)
      comment: "Number of yield learning records applicable to production — measures R&D-to-manufacturing knowledge transfer."
    - name: "open_corrective_action_count"
      expr: COUNT(CASE WHEN corrective_action_status = 'Open' THEN 1 END)
      comment: "Number of open corrective actions from yield learning — tracks unresolved yield issues requiring engineering attention."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_patent_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IP portfolio KPIs — patent filing activity, prosecution status, strategic value, and cost metrics for semiconductor R&D intellectual property management."
  source: "`vibe_semiconductors_v1`.`research`.`patent_filing`"
  dimensions:
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the patent filing (Filed, Pending, Granted, Abandoned, Expired)."
    - name: "patent_type"
      expr: patent_type
      comment: "Type of patent (Utility, Design, Provisional, PCT, Continuation, etc.)."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction where the patent is filed (US, EU, CN, JP, KR, etc.) — used for IP portfolio geographic analysis."
    - name: "prosecution_stage"
      expr: prosecution_stage
      comment: "Current prosecution stage (Application, Examination, Allowance, Grant, Appeal, etc.)."
    - name: "technology_domain"
      expr: technology_domain
      comment: "Technology domain of the patent (Process, Device, Materials, Packaging, EDA, etc.)."
    - name: "chips_act_reportable"
      expr: chips_act_reportable
      comment: "Indicates whether the patent is reportable under CHIPS Act obligations."
    - name: "prior_art_search_completed"
      expr: prior_art_search_completed
      comment: "Indicates whether prior art search was completed — measures IP prosecution readiness."
    - name: "filing_date_year"
      expr: DATE_TRUNC('year', filing_date)
      comment: "Year of patent filing — used for IP portfolio growth trend analysis."
    - name: "grant_date_year"
      expr: DATE_TRUNC('year', grant_date)
      comment: "Year of patent grant — used for IP portfolio maturity and grant rate analysis."
  measures:
    - name: "total_patent_filings"
      expr: COUNT(1)
      comment: "Total number of patent filings — baseline IP portfolio size metric for executive IP strategy reviews."
    - name: "granted_patent_count"
      expr: COUNT(CASE WHEN filing_status = 'Granted' THEN 1 END)
      comment: "Number of granted patents — measures IP portfolio strength and R&D innovation output."
    - name: "grant_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN filing_status = 'Granted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Patent grant rate percentage — measures IP prosecution effectiveness and portfolio quality."
    - name: "total_actual_filing_cost_usd"
      expr: SUM(CAST(actual_filing_cost AS DOUBLE))
      comment: "Total actual patent filing and prosecution cost — primary IP investment metric for budget management."
    - name: "total_estimated_filing_cost_usd"
      expr: SUM(CAST(estimated_filing_cost AS DOUBLE))
      comment: "Total estimated patent filing cost — used for IP budget forecasting and variance analysis."
    - name: "avg_strategic_value_score"
      expr: AVG(CAST(strategic_value AS DOUBLE))
      comment: "Average strategic value score of patent filings — measures IP portfolio quality and competitive positioning."
    - name: "avg_business_value_score"
      expr: AVG(CAST(business_value_score AS DOUBLE))
      comment: "Average business value score — used to prioritize IP maintenance and prosecution investment decisions."
    - name: "abandoned_patent_count"
      expr: COUNT(CASE WHEN filing_status = 'Abandoned' THEN 1 END)
      comment: "Number of abandoned patents — measures IP portfolio attrition and prosecution efficiency."
    - name: "chips_act_reportable_count"
      expr: COUNT(CASE WHEN chips_act_reportable = TRUE THEN 1 END)
      comment: "Number of CHIPS Act reportable patents — critical for government grant compliance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_budget_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "R&D budget allocation KPIs — award amounts, funding source distribution, CHIPS Act compliance, and budget period coverage for semiconductor research investment management."
  source: "`vibe_semiconductors_v1`.`research`.`budget_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the budget allocation (Active, Approved, Pending, Closed, Cancelled)."
    - name: "funding_source_type"
      expr: funding_source_type
      comment: "Type of funding source (Internal, Government Grant, Collaboration, CHIPS Act, etc.)."
    - name: "grant_type"
      expr: grant_type
      comment: "Type of grant funding the allocation (Research, Development, Commercialization, etc.)."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the budget allocation (Low, Medium, High)."
    - name: "chips_act_compliance_flag"
      expr: chips_act_compliance_flag
      comment: "Indicates whether the allocation is compliant with CHIPS Act requirements."
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "Indicates whether the allocation involves ITAR-controlled research activities."
    - name: "strategic_priority_level"
      expr: strategic_priority_level
      comment: "Strategic priority level of the allocation (Critical, High, Medium, Low)."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget allocation — used for annual R&D investment planning and reporting."
    - name: "allocation_date_month"
      expr: DATE_TRUNC('month', allocation_date)
      comment: "Month of budget allocation — used for investment timing and cash flow analysis."
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total number of budget allocations — baseline R&D funding activity metric."
    - name: "total_award_amount_usd"
      expr: SUM(CAST(award_amount AS DOUBLE))
      comment: "Total award amount across all budget allocations — primary R&D funding received metric for executive reporting."
    - name: "avg_award_amount_usd"
      expr: AVG(CAST(award_amount AS DOUBLE))
      comment: "Average award amount per allocation — used for funding benchmarking and grant size analysis."
    - name: "total_budget_for_program_usd"
      expr: SUM(CAST(budget_for_program AS DOUBLE))
      comment: "Total budget allocated to research programs — measures R&D program investment commitment."
    - name: "chips_act_allocation_count"
      expr: COUNT(CASE WHEN chips_act_compliance_flag = TRUE THEN 1 END)
      comment: "Number of CHIPS Act compliant allocations — critical for government funding compliance tracking."
    - name: "high_risk_allocation_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Number of high-risk budget allocations — triggers executive review and risk mitigation planning."
    - name: "total_budget_funds_program_usd"
      expr: SUM(CAST(budget_funds_program AS DOUBLE))
      comment: "Total budget funds committed to programs — measures R&D program funding coverage and adequacy."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_technology_roadmap`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technology roadmap KPIs — PPA improvement targets, competitive benchmarking, and investment priorities for semiconductor technology strategy planning."
  source: "`vibe_semiconductors_v1`.`research`.`technology_roadmap`"
  dimensions:
    - name: "roadmap_status"
      expr: roadmap_status
      comment: "Current status of the technology roadmap (Active, Draft, Approved, Archived)."
    - name: "technology_focus_area"
      expr: technology_focus_area
      comment: "Technology focus area of the roadmap (Logic, Memory, Analog, RF, Power, Packaging, etc.)."
    - name: "device_architecture_type"
      expr: device_architecture_type
      comment: "Device architecture type targeted by the roadmap (FinFET, GAA, Planar, etc.)."
    - name: "investment_priority_level"
      expr: investment_priority_level
      comment: "Investment priority level for the roadmap (Critical, High, Medium, Low)."
    - name: "chips_act_compliance_flag"
      expr: chips_act_compliance_flag
      comment: "Indicates whether the roadmap is aligned with CHIPS Act compliance requirements."
    - name: "target_process_node"
      expr: target_process_node
      comment: "Target process node for the roadmap (e.g., 3nm, 5nm, 7nm) — used for node-level investment analysis."
    - name: "target_introduction_date_year"
      expr: DATE_TRUNC('year', target_introduction_date)
      comment: "Year of planned technology introduction — used for roadmap timeline and investment scheduling."
    - name: "planning_horizon_start"
      expr: DATE_TRUNC('year', planning_horizon_start_date)
      comment: "Start year of the planning horizon — used for long-range technology investment analysis."
  measures:
    - name: "total_roadmaps"
      expr: COUNT(1)
      comment: "Total number of technology roadmaps — baseline technology strategy portfolio metric."
    - name: "avg_performance_improvement_target_pct"
      expr: AVG(CAST(performance_improvement_target_percent AS DOUBLE))
      comment: "Average performance improvement target percentage — measures ambition level of technology roadmap commitments."
    - name: "avg_power_improvement_target_pct"
      expr: AVG(CAST(power_improvement_target_percent AS DOUBLE))
      comment: "Average power improvement target percentage — measures energy efficiency ambition in technology roadmaps."
    - name: "avg_area_improvement_target_pct"
      expr: AVG(CAST(area_improvement_target_percent AS DOUBLE))
      comment: "Average area scaling improvement target — measures density improvement ambition in technology roadmaps."
    - name: "avg_estimated_nre_cost_usd"
      expr: AVG(CAST(estimated_nre_cost AS DOUBLE))
      comment: "Average estimated NRE cost per roadmap — used for technology investment planning and budget forecasting."
    - name: "total_estimated_nre_cost_usd"
      expr: SUM(CAST(estimated_nre_cost AS DOUBLE))
      comment: "Total estimated NRE cost across all roadmaps — primary technology investment commitment metric."
    - name: "avg_transistor_density_target"
      expr: AVG(CAST(transistor_density_target AS DOUBLE))
      comment: "Average transistor density target (MTr/mm²) — measures technology scaling ambition vs. industry benchmarks."
    - name: "chips_act_aligned_roadmap_count"
      expr: COUNT(CASE WHEN chips_act_compliance_flag = TRUE THEN 1 END)
      comment: "Number of roadmaps aligned with CHIPS Act requirements — measures strategic alignment with government funding programs."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_ip_core_development`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IP core development KPIs — NRE cost, verification coverage, design completeness, and technology readiness for semiconductor IP portfolio management."
  source: "`vibe_semiconductors_v1`.`research`.`ip_core_development`"
  dimensions:
    - name: "development_status"
      expr: development_status
      comment: "Current development status of the IP core (Concept, Design, Verification, Silicon Validation, Released)."
    - name: "ip_type"
      expr: ip_type
      comment: "Type of IP core (Hard IP, Soft IP, Firm IP) — used for portfolio classification and licensing strategy."
    - name: "ip_category"
      expr: ip_category
      comment: "IP category (Interface, Memory, Processor, Analog, RF, Security, etc.)."
    - name: "technology_readiness_level"
      expr: technology_readiness_level
      comment: "TRL rating for the IP core — measures development maturity and production readiness."
    - name: "licensing_model"
      expr: licensing_model
      comment: "Licensing model for the IP core (Royalty, Paid-Up, Subscription, etc.) — used for revenue strategy analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Development risk level (Low, Medium, High, Critical)."
    - name: "silicon_validation_status"
      expr: silicon_validation_status
      comment: "Silicon validation status (Not Started, In Progress, Passed, Failed) — key milestone for IP release readiness."
    - name: "target_process_node"
      expr: target_process_node
      comment: "Target process node for the IP core — used for node-level IP portfolio coverage analysis."
    - name: "project_start_date_year"
      expr: DATE_TRUNC('year', project_start_date)
      comment: "Year the IP development project started — used for development cycle time analysis."
  measures:
    - name: "total_ip_core_developments"
      expr: COUNT(1)
      comment: "Total number of IP core development projects — baseline IP portfolio pipeline metric."
    - name: "total_actual_nre_cost_usd"
      expr: SUM(CAST(actual_nre_cost_usd AS DOUBLE))
      comment: "Total actual NRE cost for IP core development — primary IP investment expenditure metric."
    - name: "total_estimated_nre_cost_usd"
      expr: SUM(CAST(estimated_nre_cost_usd AS DOUBLE))
      comment: "Total estimated NRE cost — used for IP development budget forecasting and variance analysis."
    - name: "nre_cost_variance_usd"
      expr: SUM(CAST(actual_nre_cost_usd AS DOUBLE) - CAST(estimated_nre_cost_usd AS DOUBLE))
      comment: "Total NRE cost variance (actual minus estimated) — measures IP development cost estimation accuracy."
    - name: "avg_verification_coverage_pct"
      expr: AVG(CAST(verification_coverage_percentage AS DOUBLE))
      comment: "Average verification coverage percentage — measures IP quality and readiness for silicon validation."
    - name: "avg_rtl_completion_pct"
      expr: AVG(CAST(rtl_completion_percentage AS DOUBLE))
      comment: "Average RTL completion percentage — tracks IP design progress across the development portfolio."
    - name: "avg_documentation_completeness_pct"
      expr: AVG(CAST(documentation_completeness_percentage AS DOUBLE))
      comment: "Average documentation completeness percentage — measures IP release readiness and customer deliverable quality."
    - name: "avg_design_for_testability_coverage_pct"
      expr: AVG(CAST(design_for_testability_coverage AS DOUBLE))
      comment: "Average DFT coverage percentage — measures testability of IP cores and downstream test cost efficiency."
    - name: "silicon_validated_count"
      expr: COUNT(CASE WHEN silicon_validation_status = 'Passed' THEN 1 END)
      comment: "Number of IP cores with passed silicon validation — measures production-ready IP portfolio size."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_collaboration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "R&D collaboration KPIs — partnership activity, funding contributions, IP terms, and export control posture for semiconductor research alliance management."
  source: "`vibe_semiconductors_v1`.`research`.`collaboration`"
  dimensions:
    - name: "collaboration_status"
      expr: collaboration_status
      comment: "Current status of the collaboration (Active, Completed, Terminated, Pending)."
    - name: "collaboration_type"
      expr: collaboration_type
      comment: "Type of collaboration (Joint Development, Consortium, Sponsored Research, Technology License, etc.)."
    - name: "technology_focus_area"
      expr: technology_focus_area
      comment: "Technology focus area of the collaboration (Process, Device, Materials, Packaging, etc.)."
    - name: "export_control_classification"
      expr: export_control_classification
      comment: "Export control classification of the collaboration — used for compliance risk assessment."
    - name: "confidentiality_classification"
      expr: confidentiality_classification
      comment: "Confidentiality level of the collaboration (Public, Confidential, Restricted, Top Secret)."
    - name: "renewal_option_flag"
      expr: renewal_option_flag
      comment: "Indicates whether the collaboration has a renewal option — used for partnership continuity planning."
    - name: "background_ip_included_flag"
      expr: background_ip_included_flag
      comment: "Indicates whether background IP is included in the collaboration — critical for IP risk management."
    - name: "start_date_year"
      expr: DATE_TRUNC('year', start_date)
      comment: "Year the collaboration started — used for partnership portfolio vintage analysis."
  measures:
    - name: "total_collaborations"
      expr: COUNT(1)
      comment: "Total number of R&D collaborations — baseline partnership portfolio metric for executive alliance reviews."
    - name: "active_collaboration_count"
      expr: COUNT(CASE WHEN collaboration_status = 'Active' THEN 1 END)
      comment: "Number of currently active collaborations — measures R&D partnership engagement level."
    - name: "total_funding_contribution_usd"
      expr: SUM(CAST(funding_contribution_amount AS DOUBLE))
      comment: "Total funding contributed across all collaborations — measures external R&D investment attracted."
    - name: "avg_funding_contribution_usd"
      expr: AVG(CAST(funding_contribution_amount AS DOUBLE))
      comment: "Average funding contribution per collaboration — used for partnership value benchmarking."
    - name: "avg_cost_sharing_pct"
      expr: AVG(CAST(cost_sharing_percentage AS DOUBLE))
      comment: "Average cost sharing percentage across collaborations — measures R&D cost leverage from partnerships."
    - name: "background_ip_risk_count"
      expr: COUNT(CASE WHEN background_ip_included_flag = TRUE THEN 1 END)
      comment: "Number of collaborations with background IP included — measures IP exposure requiring legal oversight."
    - name: "export_controlled_collaboration_count"
      expr: COUNT(CASE WHEN export_control_classification IS NOT NULL AND export_control_classification != '' THEN 1 END)
      comment: "Number of collaborations with export control classifications — measures compliance risk exposure in partnerships."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_government_grant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Government grant KPIs — award amounts, CHIPS Act funding, tax credits, and compliance posture for semiconductor public funding management."
  source: "`vibe_semiconductors_v1`.`research`.`government_grant`"
  dimensions:
    - name: "government_grant_status"
      expr: government_grant_status
      comment: "Current status of the government grant (Active, Completed, Pending, Terminated)."
    - name: "grant_type"
      expr: grant_type
      comment: "Type of government grant (Research, Development, Commercialization, Infrastructure, etc.)."
    - name: "grant_category"
      expr: grant_category
      comment: "Category of the grant (CHIPS Act, DOE, DARPA, NSF, EU Horizon, etc.)."
    - name: "awarding_agency"
      expr: awarding_agency
      comment: "Government agency awarding the grant — used for funding source diversification analysis."
    - name: "chips_act_compliance_flag"
      expr: chips_act_compliance_flag
      comment: "Indicates whether the grant is subject to CHIPS Act compliance requirements."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Indicates whether the grant involves ITAR-controlled research."
    - name: "funding_source"
      expr: funding_source
      comment: "Funding source classification (Federal, State, International, etc.)."
    - name: "award_date_year"
      expr: DATE_TRUNC('year', award_date)
      comment: "Year of grant award — used for funding pipeline and annual grant activity analysis."
  measures:
    - name: "total_grants"
      expr: COUNT(1)
      comment: "Total number of government grants — baseline public funding portfolio metric."
    - name: "total_award_amount_usd"
      expr: SUM(CAST(award_amount AS DOUBLE))
      comment: "Total government grant award amount — primary public funding received metric for executive and board reporting."
    - name: "avg_award_amount_usd"
      expr: AVG(CAST(award_amount AS DOUBLE))
      comment: "Average grant award amount — used for funding benchmarking and grant strategy optimization."
    - name: "total_matching_fund_amount_usd"
      expr: SUM(CAST(matching_fund_amount AS DOUBLE))
      comment: "Total matching funds committed — measures company co-investment in government-funded R&D programs."
    - name: "total_tax_credit_amount_usd"
      expr: SUM(CAST(tax_credit_amount AS DOUBLE))
      comment: "Total tax credits from government grants — measures financial benefit from R&D tax incentive programs."
    - name: "chips_act_grant_count"
      expr: COUNT(CASE WHEN chips_act_compliance_flag = TRUE THEN 1 END)
      comment: "Number of CHIPS Act grants — critical metric for tracking government semiconductor investment program participation."
    - name: "active_grant_count"
      expr: COUNT(CASE WHEN government_grant_status = 'Active' THEN 1 END)
      comment: "Number of currently active government grants — measures ongoing public funding engagement."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_pdk_development`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PDK development KPIs — validation progress, feature completeness, and release readiness for semiconductor process design kit lifecycle management."
  source: "`vibe_semiconductors_v1`.`research`.`pdk_development`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the PDK (Development, Beta, Released, Deprecated, End of Support)."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the PDK (Not Started, In Progress, Completed, Failed)."
    - name: "release_type"
      expr: release_type
      comment: "Type of PDK release (Major, Minor, Patch, Beta, Hotfix)."
    - name: "process_type"
      expr: process_type
      comment: "Process type the PDK supports (Logic, Analog, RF, Memory, Power, Mixed-Signal)."
    - name: "is_customer_accessible"
      expr: is_customer_accessible
      comment: "Indicates whether the PDK is accessible to external customers — used for design enablement tracking."
    - name: "supports_euv_lithography"
      expr: supports_euv_lithography
      comment: "Indicates whether the PDK supports EUV lithography — key capability flag for advanced node design enablement."
    - name: "cadence_virtuoso_compatible"
      expr: cadence_virtuoso_compatible
      comment: "Indicates Cadence Virtuoso compatibility — measures EDA tool ecosystem coverage."
    - name: "synopsys_compatible"
      expr: synopsys_compatible
      comment: "Indicates Synopsys tool compatibility — measures EDA tool ecosystem coverage."
    - name: "release_date_year"
      expr: DATE_TRUNC('year', release_date)
      comment: "Year of PDK release — used for design enablement timeline and release cadence analysis."
  measures:
    - name: "total_pdk_developments"
      expr: COUNT(1)
      comment: "Total number of PDK development projects — baseline design enablement portfolio metric."
    - name: "avg_validation_completion_pct"
      expr: AVG(CAST(validation_completion_percentage AS DOUBLE))
      comment: "Average PDK validation completion percentage — measures design enablement readiness across the PDK portfolio."
    - name: "avg_minimum_feature_size_nm"
      expr: AVG(CAST(minimum_feature_size_nm AS DOUBLE))
      comment: "Average minimum feature size in nanometers — measures technology node coverage of the PDK portfolio."
    - name: "customer_accessible_pdk_count"
      expr: COUNT(CASE WHEN is_customer_accessible = TRUE THEN 1 END)
      comment: "Number of customer-accessible PDKs — measures design enablement reach and customer design activity support."
    - name: "euv_capable_pdk_count"
      expr: COUNT(CASE WHEN supports_euv_lithography = TRUE THEN 1 END)
      comment: "Number of PDKs supporting EUV lithography — measures advanced node design enablement capability."
    - name: "released_pdk_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'Released' THEN 1 END)
      comment: "Number of released PDKs — measures active design enablement portfolio size for customer design starts."
    - name: "avg_metal_layers_count"
      expr: AVG(CAST(metal_layers_count AS DOUBLE))
      comment: "Average number of metal layers across PDKs — measures interconnect complexity and routing capability of the PDK portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_competitive_benchmark`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Competitive benchmarking KPIs — PPA gap analysis, transistor density comparison, and technology positioning metrics for semiconductor strategic intelligence."
  source: "`vibe_semiconductors_v1`.`research`.`competitive_benchmark`"
  dimensions:
    - name: "benchmark_status"
      expr: benchmark_status
      comment: "Current status of the benchmark (Active, Archived, Draft, Approved)."
    - name: "benchmark_source_type"
      expr: benchmark_source_type
      comment: "Source type of benchmark data (Published Paper, Conference, Teardown, Analyst Report, etc.)."
    - name: "device_architecture_type"
      expr: device_architecture_type
      comment: "Device architecture type benchmarked (FinFET, GAA, Planar, etc.)."
    - name: "technology_node_nm"
      expr: technology_node_nm
      comment: "Technology node in nanometers of the benchmarked competitor — used for node-level competitive analysis."
    - name: "competitor_name"
      expr: competitor_name
      comment: "Name of the competitor being benchmarked — used for competitive landscape analysis."
    - name: "technology_readiness_level"
      expr: technology_readiness_level
      comment: "TRL of the benchmarked technology — measures competitive maturity level."
    - name: "confidence_level"
      expr: confidence_level
      comment: "Confidence level of the benchmark data (High, Medium, Low) — used for data quality weighting."
    - name: "benchmark_date_year"
      expr: DATE_TRUNC('year', benchmark_date)
      comment: "Year of benchmark — used for competitive trend analysis over time."
  measures:
    - name: "total_benchmarks"
      expr: COUNT(1)
      comment: "Total number of competitive benchmarks — baseline competitive intelligence activity metric."
    - name: "avg_ppa_performance_score"
      expr: AVG(CAST(ppa_performance_score AS DOUBLE))
      comment: "Average PPA performance score of benchmarked competitors — measures competitive performance gap."
    - name: "avg_ppa_power_score"
      expr: AVG(CAST(ppa_power_score AS DOUBLE))
      comment: "Average PPA power score of benchmarked competitors — measures competitive power efficiency gap."
    - name: "avg_ppa_area_score"
      expr: AVG(CAST(ppa_area_score AS DOUBLE))
      comment: "Average PPA area score of benchmarked competitors — measures competitive density gap."
    - name: "avg_transistor_density_mtransistors_per_mm2"
      expr: AVG(CAST(transistor_density_mtransistors_per_mm2 AS DOUBLE))
      comment: "Average competitor transistor density (MTr/mm²) — key technology scaling benchmark for roadmap targeting."
    - name: "avg_operating_frequency_ghz"
      expr: AVG(CAST(operating_frequency_ghz AS DOUBLE))
      comment: "Average competitor operating frequency in GHz — measures performance competitive gap."
    - name: "avg_power_consumption_mw"
      expr: AVG(CAST(power_consumption_mw AS DOUBLE))
      comment: "Average competitor power consumption in milliwatts — measures power efficiency competitive gap."
    - name: "avg_drive_current_ua_per_um"
      expr: AVG(CAST(drive_current_ua_per_um AS DOUBLE))
      comment: "Average competitor drive current (µA/µm) — key transistor performance benchmark metric."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_tapeout_experiment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tapeout experiment KPIs — NRE cost, DRC/LVS completion, and silicon return metrics for semiconductor R&D silicon validation pipeline management."
  source: "`vibe_semiconductors_v1`.`research`.`tapeout_experiment`"
  dimensions:
    - name: "experiment_status"
      expr: experiment_status
      comment: "Current status of the tapeout experiment (Design, Submitted, In Fab, Returned, Completed, Failed)."
    - name: "drc_status"
      expr: drc_status
      comment: "DRC (Design Rule Check) status — measures design quality and fab submission readiness."
    - name: "lvs_status"
      expr: lvs_status
      comment: "LVS (Layout vs. Schematic) status — measures design verification completeness."
    - name: "device_architecture_type"
      expr: device_architecture_type
      comment: "Device architecture type being taped out (FinFET, GAA, Planar, etc.)."
    - name: "tapeout_purpose"
      expr: tapeout_purpose
      comment: "Purpose of the tapeout (Process Characterization, IP Validation, Product Prototype, PDK Calibration, etc.)."
    - name: "wafer_allocation_type"
      expr: wafer_allocation_type
      comment: "Wafer allocation type (MPW, Dedicated, Engineering Run) — used for cost and capacity analysis."
    - name: "export_control_classification"
      expr: export_control_classification
      comment: "Export control classification of the tapeout — used for compliance risk assessment."
    - name: "gds_submission_date_month"
      expr: DATE_TRUNC('month', gds_submission_date)
      comment: "Month of GDS submission — used for tapeout pipeline throughput and schedule analysis."
  measures:
    - name: "total_tapeout_experiments"
      expr: COUNT(1)
      comment: "Total number of tapeout experiments — baseline silicon validation pipeline throughput metric."
    - name: "total_nre_cost_usd"
      expr: SUM(CAST(nre_cost_usd AS DOUBLE))
      comment: "Total NRE cost across all tapeout experiments — primary silicon validation investment metric."
    - name: "avg_nre_cost_usd"
      expr: AVG(CAST(nre_cost_usd AS DOUBLE))
      comment: "Average NRE cost per tapeout experiment — used for silicon validation cost benchmarking."
    - name: "avg_die_size_mm2"
      expr: AVG(CAST(die_size_mm2 AS DOUBLE))
      comment: "Average die size in mm² across tapeout experiments — measures design complexity and wafer cost efficiency."
    - name: "drc_clean_tapeout_count"
      expr: COUNT(CASE WHEN drc_status = 'Clean' THEN 1 END)
      comment: "Number of tapeouts with clean DRC — measures design quality and first-pass submission success rate."
    - name: "completed_tapeout_count"
      expr: COUNT(CASE WHEN experiment_status = 'Completed' THEN 1 END)
      comment: "Number of completed tapeout experiments — measures silicon validation pipeline completion rate."
    - name: "mpw_tapeout_count"
      expr: COUNT(CASE WHEN wafer_allocation_type = 'MPW' THEN 1 END)
      comment: "Number of MPW (Multi-Project Wafer) tapeouts — measures cost-sharing silicon validation strategy utilization."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research milestone KPIs — schedule adherence, gate review outcomes, and IP trigger activity for semiconductor R&D program execution tracking."
  source: "`vibe_semiconductors_v1`.`research`.`research_milestone`"
  dimensions:
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone (On Track, At Risk, Delayed, Completed, Cancelled)."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (Gate Review, Tapeout, Silicon Return, IP Filing, Qualification, etc.)."
    - name: "gate_review_outcome"
      expr: gate_review_outcome
      comment: "Outcome of the gate review (Approved, Conditional, Rejected, Deferred) — key program progression decision."
    - name: "technology_readiness_level"
      expr: technology_readiness_level
      comment: "TRL at milestone completion — measures technology maturity progression."
    - name: "critical_path_indicator"
      expr: critical_path_indicator
      comment: "Indicates whether the milestone is on the critical path — used for schedule risk prioritization."
    - name: "chips_act_reportable"
      expr: chips_act_reportable
      comment: "Indicates whether the milestone is reportable under CHIPS Act obligations."
    - name: "ip_filing_triggered"
      expr: ip_filing_triggered
      comment: "Indicates whether the milestone triggered an IP filing — measures innovation output from R&D milestones."
    - name: "planned_date_quarter"
      expr: DATE_TRUNC('quarter', planned_date)
      comment: "Quarter the milestone was planned — used for schedule adherence and pipeline analysis."
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total number of research milestones — baseline R&D program execution tracking metric."
    - name: "completed_milestone_count"
      expr: COUNT(CASE WHEN milestone_status = 'Completed' THEN 1 END)
      comment: "Number of completed milestones — measures R&D program execution progress."
    - name: "milestone_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN milestone_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Milestone completion rate percentage — primary R&D program execution KPI for executive steering reviews."
    - name: "delayed_milestone_count"
      expr: COUNT(CASE WHEN milestone_status = 'Delayed' THEN 1 END)
      comment: "Number of delayed milestones — triggers schedule recovery planning and resource reallocation."
    - name: "critical_path_milestone_count"
      expr: COUNT(CASE WHEN critical_path_indicator = TRUE THEN 1 END)
      comment: "Number of critical path milestones — measures schedule risk exposure in R&D programs."
    - name: "ip_filing_triggered_count"
      expr: COUNT(CASE WHEN ip_filing_triggered = TRUE THEN 1 END)
      comment: "Number of milestones that triggered IP filings — measures innovation output rate from R&D execution."
    - name: "total_budget_impact_usd"
      expr: SUM(CAST(budget_impact_amount AS DOUBLE))
      comment: "Total budget impact from milestone changes — measures financial exposure from R&D schedule variances."
    - name: "chips_act_reportable_milestone_count"
      expr: COUNT(CASE WHEN chips_act_reportable = TRUE THEN 1 END)
      comment: "Number of CHIPS Act reportable milestones — critical for government grant compliance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`research_process_flow_experiment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process flow experiment KPIs — yield performance, cycle time efficiency, and DOE split activity for semiconductor process development optimization."
  source: "`vibe_semiconductors_v1`.`research`.`process_flow_experiment`"
  dimensions:
    - name: "process_flow_experiment_status"
      expr: process_flow_experiment_status
      comment: "Current status of the process flow experiment (Active, Completed, Failed, Aborted)."
    - name: "flow_type"
      expr: flow_type
      comment: "Type of process flow experiment (Baseline, DOE, Split, Optimization, Qualification)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the experiment (Approved, Pending, Rejected)."
    - name: "doe_split_flag"
      expr: doe_split_flag
      comment: "Indicates whether the experiment uses a DOE split design — used for experimental design analysis."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node targeted by the process flow experiment."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the process flow experiment (Low, Medium, High, Critical)."
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "Indicates whether the experiment involves ITAR-controlled process technology."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Primary equipment type used in the experiment — used for tool utilization and capacity analysis."
  measures:
    - name: "total_process_flow_experiments"
      expr: COUNT(1)
      comment: "Total number of process flow experiments — baseline process development activity metric."
    - name: "avg_actual_yield_pct"
      expr: AVG(CAST(actual_yield_percent AS DOUBLE))
      comment: "Average actual yield percentage across process flow experiments — measures process development effectiveness."
    - name: "avg_expected_yield_pct"
      expr: AVG(CAST(expected_yield_percent AS DOUBLE))
      comment: "Average expected yield percentage — baseline for yield gap analysis and process optimization targeting."
    - name: "yield_gap_pct"
      expr: ROUND(AVG(CAST(expected_yield_percent AS DOUBLE)) - AVG(CAST(actual_yield_percent AS DOUBLE)), 2)
      comment: "Average yield gap (expected minus actual) — measures process development shortfall requiring engineering attention."
    - name: "avg_actual_cycle_time_minutes"
      expr: AVG(CAST(actual_cycle_time_minutes AS DOUBLE))
      comment: "Average actual cycle time in minutes — measures process flow execution efficiency."
    - name: "avg_target_cycle_time_minutes"
      expr: AVG(CAST(target_cycle_time_minutes AS DOUBLE))
      comment: "Average target cycle time in minutes — baseline for cycle time efficiency analysis."
    - name: "doe_split_experiment_count"
      expr: COUNT(CASE WHEN doe_split_flag = TRUE THEN 1 END)
      comment: "Number of DOE split experiments — measures structured experimental design utilization in process development."
    - name: "avg_process_temperature_c"
      expr: AVG(CAST(process_temperature_c AS DOUBLE))
      comment: "Average process temperature in Celsius — used for process condition monitoring and recipe optimization."
$$;