-- Metric views for domain: quality | Business: Automotive | Version: 2 | Generated on: 2026-06-23 05:54:22

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_apqp_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for Advanced Product Quality Planning (APQP) gate performance, PPM achievement, and program risk. Used by Quality VPs and Program Directors to steer launch readiness and quality targets."
  source: "`vibe_automotive_v1`.`quality`.`apqp_plan`"
  dimensions:
    - name: "apqp_phase"
      expr: apqp_phase
      comment: "Current APQP phase (e.g. Phase 1 – Plan and Define, Phase 2 – Product Design, etc.) for phase-level quality gate analysis."
    - name: "gate_status"
      expr: gate_status
      comment: "Status of the current milestone gate (e.g. Open, Passed, Failed, At Risk) to track launch readiness."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the APQP plan (e.g. Active, Closed, On Hold) for portfolio-level filtering."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk classification (e.g. High, Medium, Low) assigned to the APQP plan for risk-tiered reporting."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory and quality compliance status of the plan, used for compliance dashboard filtering."
    - name: "model_year"
      expr: model_year
      comment: "Vehicle model year associated with the APQP plan, enabling year-over-year quality program comparison."
    - name: "responsible_team"
      expr: responsible_team
      comment: "Team responsible for the APQP plan, used for accountability and workload distribution analysis."
    - name: "sop_date_month"
      expr: DATE_TRUNC('MONTH', sop_date)
      comment: "Start-of-production date truncated to month for launch timeline trend analysis."
    - name: "ai_inspection_flag"
      expr: ai_inspection_flag
      comment: "Indicates whether AI-assisted inspection is enabled for this plan, used to track AI adoption in quality programs."
  measures:
    - name: "total_apqp_plans"
      expr: COUNT(1)
      comment: "Total number of APQP plans. Baseline volume metric for program portfolio sizing and capacity planning."
    - name: "avg_actual_ppm"
      expr: AVG(CAST(actual_ppm AS DOUBLE))
      comment: "Average actual Parts Per Million (PPM) defect rate across APQP plans. Core quality KPI used by Quality VPs to assess manufacturing defect performance against targets."
    - name: "avg_target_ppm"
      expr: AVG(CAST(target_ppm AS DOUBLE))
      comment: "Average target PPM across APQP plans. Benchmarks the ambition level of quality goals set during program planning."
    - name: "avg_quality_goal_ppm"
      expr: AVG(CAST(quality_goal_ppm AS DOUBLE))
      comment: "Average quality goal PPM across plans. Used alongside actual PPM to assess goal-setting rigor and achievement."
    - name: "ppm_variance_actual_vs_target"
      expr: AVG(CAST(actual_ppm AS DOUBLE) - CAST(target_ppm AS DOUBLE))
      comment: "Average gap between actual and target PPM. Positive values indicate quality underperformance vs. plan; drives corrective action prioritization."
    - name: "high_risk_plan_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Number of APQP plans classified as high risk. Directly informs executive risk reviews and resource reallocation decisions."
    - name: "gate_failed_count"
      expr: COUNT(CASE WHEN gate_status = 'Failed' THEN 1 END)
      comment: "Number of APQP plans with a failed gate status. A leading indicator of launch delays and quality escapes requiring immediate intervention."
    - name: "gate_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gate_status = 'Passed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of APQP plans that have passed their current gate. Key launch readiness KPI tracked in program steering meetings."
    - name: "non_compliant_plan_count"
      expr: COUNT(CASE WHEN compliance_status != 'Compliant' THEN 1 END)
      comment: "Number of APQP plans not in a compliant status. Regulatory risk indicator used by compliance and quality leadership."
    - name: "ai_inspection_enabled_count"
      expr: COUNT(CASE WHEN ai_inspection_flag = TRUE THEN 1 END)
      comment: "Number of APQP plans with AI inspection enabled. Tracks digital quality transformation adoption across the program portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_defect_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and strategic defect analytics covering defect volume, severity distribution, repeat defect rates, and PPM performance. Used by Quality Directors, Plant Managers, and Operations VPs to drive defect reduction programs."
  source: "`vibe_automotive_v1`.`quality`.`defect_record`"
  dimensions:
    - name: "defect_category"
      expr: defect_category
      comment: "Category of the defect (e.g. Dimensional, Surface, Functional) for Pareto analysis and root cause prioritization."
    - name: "defect_type"
      expr: defect_type
      comment: "Type classification of the defect for granular defect taxonomy reporting."
    - name: "severity"
      expr: severity
      comment: "Severity level of the defect (e.g. Critical, Major, Minor) used to prioritize corrective actions and assess customer impact."
    - name: "detection_method"
      expr: detection_method
      comment: "Method by which the defect was detected (e.g. In-line inspection, Customer complaint, Audit) to evaluate detection effectiveness."
    - name: "defect_record_status"
      expr: defect_record_status
      comment: "Current status of the defect record (e.g. Open, Closed, Under Investigation) for workload and closure rate tracking."
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision for the defective item (e.g. Scrap, Rework, Use As Is) to track material loss and rework costs."
    - name: "location_zone"
      expr: location_zone
      comment: "Physical zone or area where the defect was detected, enabling spatial defect concentration analysis."
    - name: "is_repeat_defect"
      expr: is_repeat_defect
      comment: "Flag indicating whether this is a recurring defect. Repeat defects signal systemic quality failures requiring escalated corrective action."
    - name: "ai_inspection_flag"
      expr: ai_inspection_flag
      comment: "Indicates whether AI inspection was used in detecting this defect, supporting AI vs. manual detection effectiveness comparison."
    - name: "detected_date_month"
      expr: DATE_TRUNC('MONTH', detected_timestamp)
      comment: "Month of defect detection for trend analysis and monthly quality performance reporting."
  measures:
    - name: "total_defects"
      expr: COUNT(1)
      comment: "Total number of defect records. Baseline volume KPI for defect trend monitoring and quality performance dashboards."
    - name: "critical_defect_count"
      expr: COUNT(CASE WHEN severity = 'Critical' THEN 1 END)
      comment: "Number of critical severity defects. Directly tied to safety, regulatory risk, and potential recall exposure — a primary executive quality KPI."
    - name: "repeat_defect_count"
      expr: COUNT(CASE WHEN is_repeat_defect = TRUE THEN 1 END)
      comment: "Number of repeat defects. High repeat rates indicate corrective actions are ineffective, triggering escalation and systemic review."
    - name: "repeat_defect_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_repeat_defect = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of defects that are repeat occurrences. A key corrective action effectiveness KPI used in quality steering reviews."
    - name: "avg_ppm_rate"
      expr: AVG(CAST(ppm_rate AS DOUBLE))
      comment: "Average PPM defect rate across defect records. Core manufacturing quality KPI benchmarked against customer and internal targets."
    - name: "open_defect_count"
      expr: COUNT(CASE WHEN defect_record_status = 'Open' THEN 1 END)
      comment: "Number of currently open defect records. Operational backlog metric used by quality teams to manage resolution workload."
    - name: "scrap_disposition_count"
      expr: COUNT(CASE WHEN disposition = 'Scrap' THEN 1 END)
      comment: "Number of defective items dispositioned as scrap. Proxy for material waste cost and manufacturing yield loss."
    - name: "ai_detected_defect_count"
      expr: COUNT(CASE WHEN ai_inspection_flag = TRUE THEN 1 END)
      comment: "Number of defects detected via AI inspection. Tracks AI inspection effectiveness and coverage in the quality process."
    - name: "distinct_defect_codes"
      expr: COUNT(DISTINCT defect_code)
      comment: "Number of distinct defect codes observed. Measures defect variety and complexity of the quality problem landscape."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for corrective and preventive action (CAPA) effectiveness, closure rates, and 8D compliance. Used by Quality Directors and Operations leadership to evaluate the health of the quality improvement system."
  source: "`vibe_automotive_v1`.`quality`.`corrective_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action (e.g. Containment, Root Cause, Preventive) for CAPA process stage analysis."
    - name: "action_status"
      expr: action_status
      comment: "Current status of the corrective action (e.g. Open, Closed, Overdue) for workload and closure tracking."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the corrective action (e.g. High, Medium, Low) for resource prioritization."
    - name: "severity"
      expr: severity
      comment: "Severity of the underlying quality issue driving the corrective action, used to tier response urgency."
    - name: "effectiveness_status"
      expr: effectiveness_status
      comment: "Status of the effectiveness verification (e.g. Verified Effective, Not Effective, Pending) — key CAPA quality indicator."
    - name: "is_eight_d_flag"
      expr: is_eight_d_flag
      comment: "Indicates whether the corrective action follows the 8D problem-solving methodology, used to track 8D compliance rates."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Flags recurring quality issues where previous corrective actions were insufficient, signaling systemic failure."
    - name: "raised_date_month"
      expr: DATE_TRUNC('MONTH', raised_date)
      comment: "Month the corrective action was raised, used for trend analysis of quality issue emergence rates."
    - name: "closed_date_month"
      expr: DATE_TRUNC('MONTH', closed_date)
      comment: "Month the corrective action was closed, used for closure rate trend analysis."
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total number of corrective actions. Baseline CAPA volume metric for quality system workload assessment."
    - name: "open_corrective_action_count"
      expr: COUNT(CASE WHEN action_status = 'Open' THEN 1 END)
      comment: "Number of open corrective actions. Operational backlog KPI — high open counts signal quality system capacity or effectiveness issues."
    - name: "overdue_corrective_action_count"
      expr: COUNT(CASE WHEN action_status = 'Overdue' THEN 1 END)
      comment: "Number of overdue corrective actions. Directly indicates CAPA process discipline failures requiring management escalation."
    - name: "closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN action_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions that have been closed. Primary CAPA effectiveness KPI tracked in quality steering meetings."
    - name: "effectiveness_verified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN effectiveness_verified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions with verified effectiveness. Measures whether quality fixes are actually working — a critical quality system health KPI."
    - name: "recurring_issue_count"
      expr: COUNT(CASE WHEN is_recurring = TRUE THEN 1 END)
      comment: "Number of corrective actions for recurring issues. High counts indicate systemic quality failures and ineffective root cause elimination."
    - name: "eight_d_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_eight_d_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions using the 8D methodology. Tracks adherence to structured problem-solving standards required by OEM customers."
    - name: "avg_cost_of_action"
      expr: AVG(CAST(cost_of_action AS DOUBLE))
      comment: "Average cost per corrective action. Enables cost-of-quality analysis and justification of upstream defect prevention investments."
    - name: "total_cost_of_corrective_actions"
      expr: SUM(CAST(cost_of_action AS DOUBLE))
      comment: "Total financial cost of all corrective actions. A direct cost-of-poor-quality (COPQ) metric used in executive quality cost reporting."
    - name: "high_priority_open_count"
      expr: COUNT(CASE WHEN priority = 'High' AND action_status = 'Open' THEN 1 END)
      comment: "Number of high-priority corrective actions still open. Urgent operational KPI used to focus quality team attention on highest-risk issues."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_inspection_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection lot quality KPIs covering acceptance rates, rejection rates, corrective action triggers, and AI inspection adoption. Used by Quality Engineers and Plant Managers to monitor incoming and in-process inspection performance."
  source: "`vibe_automotive_v1`.`quality`.`inspection_lot`"
  dimensions:
    - name: "inspection_lot_status"
      expr: inspection_lot_status
      comment: "Status of the inspection lot (e.g. Accepted, Rejected, In Progress) for lot disposition tracking."
    - name: "lot_type"
      expr: lot_type
      comment: "Type of inspection lot (e.g. Incoming, In-Process, Final) to segment quality performance by inspection stage."
    - name: "lot_origin"
      expr: lot_origin
      comment: "Origin of the inspection lot (e.g. Supplier, Internal, Customer Return) for source-based quality analysis."
    - name: "decision"
      expr: decision
      comment: "Final disposition decision on the lot (e.g. Accept, Reject, Conditional Release) for acceptance rate analysis."
    - name: "inspection_method"
      expr: inspection_method
      comment: "Method used for inspection (e.g. Visual, Dimensional, Automated) to compare inspection method effectiveness."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating whether a corrective action was triggered by this lot, used to measure defect escape rates."
    - name: "measurement_result_status"
      expr: measurement_result_status
      comment: "Status of measurement results (e.g. Pass, Fail, Marginal) for measurement-level quality analysis."
    - name: "ai_inspection_flag"
      expr: ai_inspection_flag
      comment: "Indicates AI-assisted inspection was used, enabling AI vs. manual inspection performance benchmarking."
    - name: "inspection_date_month"
      expr: DATE_TRUNC('MONTH', inspection_timestamp)
      comment: "Month of inspection for trend analysis of lot acceptance and rejection rates over time."
  measures:
    - name: "total_inspection_lots"
      expr: COUNT(1)
      comment: "Total number of inspection lots processed. Baseline throughput metric for inspection capacity planning."
    - name: "rejected_lot_count"
      expr: COUNT(CASE WHEN decision = 'Reject' THEN 1 END)
      comment: "Number of lots rejected at inspection. Key quality gate metric — high rejection rates signal supplier or process quality issues."
    - name: "lot_rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN decision = 'Reject' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspection lots rejected. Primary incoming quality KPI used to evaluate supplier and process quality performance."
    - name: "corrective_action_trigger_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspection lots that triggered a corrective action. Measures the rate at which quality escapes require formal remediation."
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measured value across inspection lots. Used to monitor process centering and drift relative to specification targets."
    - name: "ai_inspected_lot_count"
      expr: COUNT(CASE WHEN ai_inspection_flag = TRUE THEN 1 END)
      comment: "Number of lots inspected using AI. Tracks AI inspection adoption and coverage across the inspection process."
    - name: "failed_measurement_lot_count"
      expr: COUNT(CASE WHEN measurement_result_status = 'Fail' THEN 1 END)
      comment: "Number of lots with failed measurement results. Granular quality signal used to identify measurement-level quality failures."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_inspection_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statistical process control and measurement quality KPIs including Cp/Cpk capability indices, deviation rates, and critical characteristic failure rates. Used by Quality Engineers and Six Sigma practitioners to assess process capability and measurement system performance."
  source: "`vibe_automotive_v1`.`quality`.`inspection_result`"
  dimensions:
    - name: "result_status"
      expr: result_status
      comment: "Pass/Fail/Marginal status of the inspection result for acceptance rate analysis."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to obtain the measurement (e.g. CMM, Manual Gauge, Vision System) for measurement system comparison."
    - name: "measurement_tool"
      expr: measurement_tool
      comment: "Specific tool used for measurement, enabling gauge R&R and tool performance analysis."
    - name: "is_critical"
      expr: is_critical
      comment: "Indicates whether the inspected characteristic is safety-critical, used to prioritize critical characteristic failure analysis."
    - name: "measurement_location"
      expr: measurement_location
      comment: "Physical location where measurement was taken, enabling spatial quality analysis."
    - name: "record_status"
      expr: record_status
      comment: "Administrative status of the inspection result record (e.g. Active, Voided) for data quality filtering."
    - name: "ai_inspection_flag"
      expr: ai_inspection_flag
      comment: "Indicates AI-assisted inspection, enabling comparison of AI vs. manual inspection result quality."
    - name: "inspection_date_month"
      expr: DATE_TRUNC('MONTH', inspection_timestamp)
      comment: "Month of inspection for process capability trend analysis over time."
  measures:
    - name: "total_inspection_results"
      expr: COUNT(1)
      comment: "Total number of inspection results. Baseline volume metric for inspection throughput and coverage analysis."
    - name: "avg_cpk_value"
      expr: AVG(CAST(cpk_value AS DOUBLE))
      comment: "Average Cpk (process capability index) across inspection results. The primary Six Sigma process capability KPI — Cpk < 1.33 triggers process improvement action."
    - name: "avg_cp_value"
      expr: AVG(CAST(cp_value AS DOUBLE))
      comment: "Average Cp (process potential index) across inspection results. Measures inherent process spread relative to specification width."
    - name: "below_minimum_cpk_count"
      expr: COUNT(CASE WHEN cpk_value < 1.33 THEN 1 END)
      comment: "Number of inspection results with Cpk below the automotive industry minimum threshold of 1.33. Directly identifies processes requiring capability improvement."
    - name: "critical_characteristic_fail_count"
      expr: COUNT(CASE WHEN is_critical = TRUE AND result_status = 'Fail' THEN 1 END)
      comment: "Number of failed results on safety-critical characteristics. Highest-priority quality KPI — any failure here triggers immediate escalation and potential production stop."
    - name: "critical_characteristic_fail_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_critical = TRUE AND result_status = 'Fail' THEN 1 END) / NULLIF(COUNT(CASE WHEN is_critical = TRUE THEN 1 END), 0), 2)
      comment: "Failure rate for safety-critical characteristics. Used by Quality VPs to assess safety risk exposure in production."
    - name: "avg_deviation_amount"
      expr: AVG(CAST(deviation_amount AS DOUBLE))
      comment: "Average deviation of measured values from specification. Measures process centering quality and systematic bias in manufacturing."
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty across inspection results. Tracks measurement system quality — high uncertainty undermines the reliability of all quality decisions."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN result_status = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspection results that passed. Overall first-pass quality yield KPI used in production quality dashboards."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_ncap_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NCAP safety test performance KPIs including star rating distribution, compliance rates, and crash test score analysis. Used by Safety Engineering VPs and Regulatory Affairs leadership to manage vehicle safety ratings and homologation status."
  source: "`vibe_automotive_v1`.`quality`.`ncap_test_result`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of NCAP test (e.g. Frontal, Side, Pole, Pedestrian) for test-category safety performance analysis."
    - name: "test_program"
      expr: test_program
      comment: "NCAP test program (e.g. Euro NCAP, NHTSA, ANCAP) for regional safety standard compliance tracking."
    - name: "star_rating"
      expr: star_rating
      comment: "NCAP star rating achieved (e.g. 5-star, 4-star) — the primary consumer-facing vehicle safety KPI."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the test result, used for homologation and market entry risk assessment."
    - name: "homologation_status"
      expr: homologation_status
      comment: "Homologation approval status, indicating whether the vehicle has received type approval for market entry."
    - name: "test_result_status"
      expr: test_result_status
      comment: "Overall status of the test result record (e.g. Final, Provisional, Under Review)."
    - name: "test_facility"
      expr: test_facility
      comment: "Testing facility where the NCAP test was conducted, for facility-level performance benchmarking."
    - name: "test_date_month"
      expr: DATE_TRUNC('MONTH', test_date)
      comment: "Month of the NCAP test for safety performance trend analysis over model development cycles."
    - name: "ai_inspection_flag"
      expr: ai_inspection_flag
      comment: "Indicates AI-assisted analysis was used in the test evaluation process."
  measures:
    - name: "total_ncap_tests"
      expr: COUNT(1)
      comment: "Total number of NCAP test results. Baseline metric for safety testing program coverage and throughput."
    - name: "five_star_rating_count"
      expr: COUNT(CASE WHEN star_rating = '5' THEN 1 END)
      comment: "Number of vehicles achieving a 5-star NCAP rating. Primary product safety excellence KPI used in marketing and regulatory reporting."
    - name: "five_star_achievement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN star_rating = '5' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NCAP tests achieving 5-star rating. Strategic safety KPI used by C-suite to benchmark product safety leadership vs. competitors."
    - name: "non_compliant_test_count"
      expr: COUNT(CASE WHEN compliance_status != 'Compliant' THEN 1 END)
      comment: "Number of NCAP test results with non-compliant status. Regulatory risk KPI — non-compliance blocks market entry and triggers engineering remediation."
    - name: "avg_raw_score_front"
      expr: AVG(CAST(raw_score_front AS DOUBLE))
      comment: "Average frontal crash test raw score. Tracks frontal impact safety performance trends across vehicle programs."
    - name: "avg_raw_score_side"
      expr: AVG(CAST(raw_score_side AS DOUBLE))
      comment: "Average side impact crash test raw score. Tracks side impact safety performance trends across vehicle programs."
    - name: "avg_raw_score_pole"
      expr: AVG(CAST(raw_score_pole AS DOUBLE))
      comment: "Average pole impact crash test raw score. Tracks pole impact safety performance — a critical NCAP test category for occupant protection."
    - name: "homologation_approved_count"
      expr: COUNT(CASE WHEN homologation_status = 'Approved' THEN 1 END)
      comment: "Number of test results with approved homologation status. Tracks regulatory type approval progress for market launch readiness."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_spc_chart`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statistical Process Control (SPC) chart KPIs covering process control limit performance, capability targets, and AI-assisted monitoring adoption. Used by Quality Engineers and Manufacturing leadership to manage process stability and capability."
  source: "`vibe_automotive_v1`.`quality`.`spc_chart`"
  dimensions:
    - name: "chart_type"
      expr: chart_type
      comment: "Type of SPC chart (e.g. X-bar R, X-bar S, P-chart, C-chart) for chart methodology analysis."
    - name: "spc_chart_status"
      expr: spc_chart_status
      comment: "Current status of the SPC chart (e.g. Active, Suspended, Under Review) for active monitoring coverage analysis."
    - name: "process_step"
      expr: process_step
      comment: "Manufacturing process step monitored by the SPC chart, enabling process-level quality performance analysis."
    - name: "statistical_method"
      expr: statistical_method
      comment: "Statistical method used in the SPC chart (e.g. Shewhart, CUSUM, EWMA) for methodology benchmarking."
    - name: "ai_inspection_flag"
      expr: ai_inspection_flag
      comment: "Indicates AI-assisted SPC monitoring is enabled, tracking digital quality transformation in process control."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the SPC chart became effective, used for SPC program rollout trend analysis."
  measures:
    - name: "total_spc_charts"
      expr: COUNT(1)
      comment: "Total number of SPC charts. Baseline metric for SPC program coverage across manufacturing processes."
    - name: "active_spc_chart_count"
      expr: COUNT(CASE WHEN spc_chart_status = 'Active' THEN 1 END)
      comment: "Number of currently active SPC charts. Measures real-time process monitoring coverage — a key quality system infrastructure KPI."
    - name: "avg_control_limit_spread"
      expr: AVG(CAST(control_limit_ucl AS DOUBLE) - CAST(control_limit_lcl AS DOUBLE))
      comment: "Average spread between upper and lower control limits. Measures process variability bandwidth — wider spreads indicate less capable or less tightly controlled processes."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across SPC charts. Used to understand the central tendency of process targets for benchmarking and goal-setting."
    - name: "avg_confidence_level"
      expr: AVG(CAST(confidence_level AS DOUBLE))
      comment: "Average statistical confidence level across SPC charts. Tracks the rigor of statistical process control methodology applied."
    - name: "ai_monitored_chart_count"
      expr: COUNT(CASE WHEN ai_inspection_flag = TRUE THEN 1 END)
      comment: "Number of SPC charts with AI-assisted monitoring. Tracks AI adoption in real-time process control — a strategic digital manufacturing KPI."
    - name: "ai_monitoring_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ai_inspection_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SPC charts covered by AI monitoring. Strategic KPI for digital quality transformation progress reporting to leadership."
$$;