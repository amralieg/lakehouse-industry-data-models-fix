-- Metric views for domain: quality | Business: Semiconductors | Version: 2 | Generated on: 2026-06-23 23:34:49

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_yield_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer and die yield performance metrics tracking yield rates, defect density, and fallout across process steps, tools, and product nodes — core KPIs for fab efficiency and quality steering."
  source: "`vibe_semiconductors_v1`.`quality`.`yield_record`"
  dimensions:
    - name: "process_node"
      expr: process_node
      comment: "Technology node (e.g. 7nm, 14nm) for yield segmentation by process generation."
    - name: "yield_type"
      expr: yield_type
      comment: "Classification of yield measurement (wafer sort, final test, inline) for stage-level analysis."
    - name: "measurement_stage"
      expr: measurement_stage
      comment: "Stage in the manufacturing flow where yield was measured (e.g. post-etch, post-CMP)."
    - name: "fab_line"
      expr: fab_line
      comment: "Fab production line identifier for line-level yield benchmarking."
    - name: "shift"
      expr: shift
      comment: "Production shift (day/night/weekend) to detect shift-based yield variation."
    - name: "defect_type"
      expr: defect_type
      comment: "Category of defect driving yield loss for root-cause prioritization."
    - name: "yield_loss_category"
      expr: CAST(yield_loss_category AS STRING)
      comment: "Yield loss classification bucket for Pareto analysis of loss drivers."
    - name: "lot_status"
      expr: lot_status
      comment: "Current lot disposition status (pass/fail/hold) for operational triage."
    - name: "quality_gate"
      expr: quality_gate
      comment: "Quality gate checkpoint name where yield was evaluated."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Measurement technique used (optical, e-beam, etc.) for method-level yield comparison."
  measures:
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average die yield percentage across all lots — primary fab efficiency KPI tracked at every steering review."
    - name: "avg_yield_target_percent"
      expr: AVG(CAST(yield_target_percent AS DOUBLE))
      comment: "Average yield target percentage, used to compute yield gap vs. target."
    - name: "avg_yield_gap_percent"
      expr: AVG(CAST(yield_gap_percent AS DOUBLE))
      comment: "Average gap between actual and target yield — directly quantifies improvement opportunity and drives engineering investment decisions."
    - name: "avg_defect_density_per_cm2"
      expr: AVG(CAST(defect_density_per_cm2 AS DOUBLE))
      comment: "Average defect density per cm² — leading indicator of process cleanliness and yield trajectory."
    - name: "total_good_die"
      expr: SUM(CAST(good_die_count AS DOUBLE))
      comment: "Total good die produced — directly tied to revenue capacity and supply planning."
    - name: "total_die_count"
      expr: SUM(CAST(total_die_count AS DOUBLE))
      comment: "Total die processed, used as denominator for yield rate calculations and capacity utilization."
    - name: "total_defect_count"
      expr: SUM(CAST(defect_count AS DOUBLE))
      comment: "Total defect count across all lots — volume indicator for process excursion detection."
    - name: "avg_fallout_rate"
      expr: AVG(CAST(fallout_rate AS DOUBLE))
      comment: "Average fallout rate (fraction of die lost) — operational KPI for process control and scrap cost management."
    - name: "avg_bin_yield_pct"
      expr: AVG(CAST(bin_yield_pct AS DOUBLE))
      comment: "Average bin-level yield percentage for bin distribution analysis and product mix optimization."
    - name: "lot_count"
      expr: COUNT(1)
      comment: "Number of yield records (lots measured) — baseline volume metric for statistical significance assessment."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_defect_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Defect-level quality metrics tracking defect density, size, severity, and spatial distribution across wafers, process steps, and tools — drives root-cause prioritization and process improvement investment."
  source: "`vibe_semiconductors_v1`.`quality`.`defect_record`"
  dimensions:
    - name: "defect_classification"
      expr: defect_classification
      comment: "Defect type classification (particle, scratch, pattern, etc.) for Pareto-driven root-cause analysis."
    - name: "defect_layer"
      expr: defect_layer
      comment: "Process layer where defect was detected for layer-level yield loss attribution."
    - name: "defect_severity"
      expr: defect_severity
      comment: "Severity rating of the defect (critical/major/minor) for risk-based prioritization."
    - name: "detection_method"
      expr: detection_method
      comment: "Inspection method used to detect the defect for method effectiveness benchmarking."
    - name: "defect_status"
      expr: defect_status
      comment: "Current disposition status of the defect record for workflow tracking."
    - name: "disposition"
      expr: disposition
      comment: "Final disposition decision (scrap/rework/use-as-is) for cost impact analysis."
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause classification for systematic defect elimination tracking."
    - name: "bin_assignment"
      expr: bin_assignment
      comment: "Electrical bin assignment associated with the defect for yield-bin correlation."
    - name: "repeatability_flag"
      expr: CAST(repeatability_flag AS STRING)
      comment: "Indicates whether the defect is a repeating pattern (systematic vs. random) — critical for process control decisions."
    - name: "edge_exclusion_zone_flag"
      expr: CAST(edge_exclusion_zone_flag AS STRING)
      comment: "Flags defects in the wafer edge exclusion zone for edge-process optimization."
  measures:
    - name: "total_defect_count"
      expr: COUNT(1)
      comment: "Total number of defect records — baseline volume KPI for defect rate trending and excursion detection."
    - name: "avg_defect_area_um2"
      expr: AVG(CAST(defect_area_um2 AS DOUBLE))
      comment: "Average defect area in µm² — larger defects correlate with higher yield loss and drive process intervention thresholds."
    - name: "avg_defect_size_nm"
      expr: AVG(CAST(defect_size_nm AS DOUBLE))
      comment: "Average defect size in nanometers — tracks process cleanliness and tool qualification status."
    - name: "avg_defect_density_per_zone"
      expr: AVG(CAST(defect_density_per_zone AS DOUBLE))
      comment: "Average defect density per wafer zone — spatial density KPI for identifying systematic process or tool issues."
    - name: "total_defect_area_um2"
      expr: SUM(CAST(defect_area_um2 AS DOUBLE))
      comment: "Total defect area across all records — aggregate impact measure for scrap cost estimation."
    - name: "repeatability_defect_count"
      expr: COUNT(CASE WHEN repeatability_flag = TRUE THEN 1 END)
      comment: "Count of repeating (systematic) defects — systematic defects drive higher yield loss and require immediate engineering escalation."
    - name: "critical_defect_count"
      expr: COUNT(CASE WHEN defect_severity = 'critical' THEN 1 END)
      comment: "Count of critical-severity defects — directly tied to customer escapes and reliability risk, triggers mandatory CAPA."
    - name: "distinct_affected_wafers"
      expr: COUNT(DISTINCT wafer_id)
      comment: "Number of distinct wafers with defects — breadth-of-impact metric for excursion containment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_dppm_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Defective parts per million (DPPM) quality metrics tracking customer-facing defect rates, shipment quality, and corrective action closure — key customer satisfaction and quality system KPIs."
  source: "`vibe_semiconductors_v1`.`quality`.`dppm_record`"
  dimensions:
    - name: "notification_type"
      expr: notification_type
      comment: "Type of quality notification (customer return, field failure, incoming inspection) for defect source analysis."
    - name: "closure_status"
      expr: closure_status
      comment: "CAPA closure status for tracking corrective action completion rates."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Record lifecycle status for pipeline and aging analysis."
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause classification for systematic defect elimination tracking."
    - name: "part_number"
      expr: part_number
      comment: "Part number for product-level DPPM benchmarking and customer reporting."
    - name: "is_kgd_certified"
      expr: CAST(is_kgd_certified AS STRING)
      comment: "Known Good Die certification flag for KGD-specific quality tracking."
    - name: "compliance_iso9001"
      expr: CAST(compliance_iso9001 AS STRING)
      comment: "ISO 9001 compliance flag for regulatory quality reporting."
  measures:
    - name: "avg_dppm_value"
      expr: AVG(CAST(dppm_value AS DOUBLE))
      comment: "Average DPPM value — primary customer-facing quality KPI reported at QBRs and used in supplier scorecards."
    - name: "total_defective_units"
      expr: SUM(CAST(defective_units AS DOUBLE))
      comment: "Total defective units shipped — absolute volume of customer-impacting quality failures driving warranty and recall cost."
    - name: "total_units_shipped"
      expr: SUM(CAST(total_units_shipped AS DOUBLE))
      comment: "Total units shipped in scope — denominator for DPPM rate calculation and shipment volume baseline."
    - name: "avg_defect_rate"
      expr: AVG(CAST(defect_rate AS DOUBLE))
      comment: "Average defect rate across all DPPM records — trend KPI for quality system effectiveness."
    - name: "avg_reject_rate"
      expr: AVG(CAST(reject_rate AS DOUBLE))
      comment: "Average rejection rate — incoming quality metric used to evaluate supplier and process performance."
    - name: "open_dppm_record_count"
      expr: COUNT(CASE WHEN closure_status != 'closed' THEN 1 END)
      comment: "Count of open DPPM records — backlog KPI for quality team capacity and customer escalation risk."
    - name: "dppm_record_count"
      expr: COUNT(1)
      comment: "Total DPPM records in period — volume baseline for quality event frequency trending."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_capa_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and Preventive Action (CAPA) metrics tracking quality system responsiveness, cost of poor quality, and corrective action effectiveness — critical for ISO 9001 compliance and continuous improvement governance."
  source: "`vibe_semiconductors_v1`.`quality`.`capa_record`"
  dimensions:
    - name: "capa_type"
      expr: capa_type
      comment: "CAPA classification (corrective vs. preventive) for action type distribution analysis."
    - name: "capa_status"
      expr: capa_status
      comment: "Current CAPA workflow status for pipeline and aging analysis."
    - name: "priority"
      expr: priority
      comment: "CAPA priority level (critical/high/medium/low) for resource allocation decisions."
    - name: "severity"
      expr: severity
      comment: "Severity of the quality event triggering the CAPA for risk-based prioritization."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk classification of the CAPA for escalation and governance decisions."
    - name: "detection_phase"
      expr: detection_phase
      comment: "Phase where the defect was detected (design/fab/test/field) for detection effectiveness analysis."
    - name: "detection_source"
      expr: detection_source
      comment: "Source system or process that triggered the CAPA for detection method benchmarking."
    - name: "root_cause_method"
      expr: root_cause_method
      comment: "Root cause analysis method used (8D, 5-Why, Fishbone) for methodology effectiveness tracking."
    - name: "closure_approval_status"
      expr: closure_approval_status
      comment: "Approval status of CAPA closure for governance and audit compliance."
    - name: "department"
      expr: department
      comment: "Responsible department for CAPA ownership and accountability reporting."
  measures:
    - name: "total_capa_cost_actual"
      expr: SUM(CAST(cost_actual AS DOUBLE))
      comment: "Total actual cost of poor quality (COPQ) across all CAPAs — direct financial impact of quality failures, reported to CFO and quality leadership."
    - name: "total_capa_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated CAPA cost for budget planning and quality investment justification."
    - name: "avg_capa_cost_actual"
      expr: AVG(CAST(cost_actual AS DOUBLE))
      comment: "Average cost per CAPA — benchmarks cost efficiency of quality resolution processes."
    - name: "open_capa_count"
      expr: COUNT(CASE WHEN capa_status != 'closed' THEN 1 END)
      comment: "Count of open CAPAs — quality system backlog KPI; high open counts signal systemic quality issues or resource constraints."
    - name: "overdue_capa_count"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE AND capa_status != 'closed' THEN 1 END)
      comment: "Count of CAPAs past their due date — compliance risk indicator for ISO 9001 audits and customer quality reviews."
    - name: "capa_count"
      expr: COUNT(1)
      comment: "Total CAPA records — volume baseline for quality event frequency and system load trending."
    - name: "critical_priority_capa_count"
      expr: COUNT(CASE WHEN priority = 'critical' THEN 1 END)
      comment: "Count of critical-priority CAPAs — executive escalation metric for highest-risk quality events."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_inspection_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incoming and in-process inspection lot quality metrics tracking acceptance rates, defect density, and yield at inspection gates — drives supplier qualification and process control decisions."
  source: "`vibe_semiconductors_v1`.`quality`.`inspection_lot`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (incoming, in-process, final) for stage-level quality analysis."
    - name: "inspection_stage"
      expr: inspection_stage
      comment: "Manufacturing stage at which inspection occurred for process-step quality benchmarking."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Overall inspection outcome (pass/fail/conditional) for acceptance rate trending."
    - name: "disposition"
      expr: disposition
      comment: "Lot disposition decision (accept/reject/rework) for material flow and scrap cost analysis."
    - name: "lot_type"
      expr: lot_type
      comment: "Lot classification (production/qualification/engineering) for segmented quality reporting."
    - name: "material_type"
      expr: material_type
      comment: "Material type for incoming quality analysis by material category."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node for node-level quality benchmarking."
    - name: "kgd_certified"
      expr: CAST(kgd_certified AS STRING)
      comment: "KGD certification status for known-good-die quality tracking."
    - name: "iso_9001_compliant"
      expr: CAST(iso_9001_compliant AS STRING)
      comment: "ISO 9001 compliance flag for regulatory quality segmentation."
    - name: "iatf_16949_compliant"
      expr: CAST(iatf_16949_compliant AS STRING)
      comment: "IATF 16949 compliance flag for automotive quality segmentation."
  measures:
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average lot yield percentage at inspection — primary incoming and in-process quality KPI."
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density AS DOUBLE))
      comment: "Average defect density per lot — leading indicator of supplier and process quality trends."
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measured parameter value across inspection lots for process centering analysis."
    - name: "total_lot_size"
      expr: SUM(CAST(lot_size AS DOUBLE))
      comment: "Total units inspected — volume baseline for acceptance rate and defect rate normalization."
    - name: "pass_lot_count"
      expr: COUNT(CASE WHEN inspection_result = 'pass' THEN 1 END)
      comment: "Count of lots passing inspection — numerator for first-pass yield rate calculation."
    - name: "fail_lot_count"
      expr: COUNT(CASE WHEN inspection_result = 'fail' THEN 1 END)
      comment: "Count of lots failing inspection — volume of quality escapes requiring disposition and CAPA."
    - name: "inspection_lot_count"
      expr: COUNT(1)
      comment: "Total inspection lots processed — throughput baseline for inspection capacity planning."
    - name: "kgd_certified_lot_count"
      expr: COUNT(CASE WHEN kgd_certified = TRUE THEN 1 END)
      comment: "Count of KGD-certified lots — supply availability metric for premium die customers."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_nonconformance_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nonconformance report (NCR) metrics tracking quality escapes, financial impact, hold management, and corrective action responsiveness — core quality governance KPIs for ISO 9001 and customer quality reporting."
  source: "`vibe_semiconductors_v1`.`quality`.`nonconformance_report`"
  dimensions:
    - name: "ncr_status"
      expr: ncr_status
      comment: "Current NCR workflow status for pipeline and aging analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the nonconformance for risk-based prioritization."
    - name: "priority"
      expr: priority
      comment: "NCR priority level for resource allocation and escalation decisions."
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision (scrap/rework/use-as-is/return) for material cost impact analysis."
    - name: "hold_type"
      expr: hold_type
      comment: "Type of quality hold associated with the NCR for hold management reporting."
    - name: "detection_point"
      expr: detection_point
      comment: "Process point where nonconformance was detected for detection effectiveness analysis."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action for CAPA closure rate tracking."
    - name: "is_customer_impact"
      expr: CAST(is_customer_impact AS STRING)
      comment: "Flag indicating customer-impacting nonconformances for customer quality reporting and escalation."
    - name: "compliance_standard"
      expr: compliance_standard
      comment: "Applicable compliance standard (ISO 9001, IATF 16949) for regulatory reporting segmentation."
    - name: "mrb_decision"
      expr: mrb_decision
      comment: "Material Review Board decision for disposition outcome analysis."
  measures:
    - name: "total_financial_impact"
      expr: SUM(CAST(impact_amount AS DOUBLE))
      comment: "Total financial impact of nonconformances — direct cost of poor quality metric reported to finance and quality leadership."
    - name: "avg_financial_impact"
      expr: AVG(CAST(impact_amount AS DOUBLE))
      comment: "Average financial impact per NCR — benchmarks cost severity of quality events for prioritization."
    - name: "open_ncr_count"
      expr: COUNT(CASE WHEN ncr_status != 'closed' THEN 1 END)
      comment: "Count of open NCRs — quality backlog KPI; high counts signal systemic issues or insufficient resolution capacity."
    - name: "customer_impact_ncr_count"
      expr: COUNT(CASE WHEN is_customer_impact = TRUE THEN 1 END)
      comment: "Count of customer-impacting NCRs — customer satisfaction risk metric requiring executive visibility."
    - name: "ncr_count"
      expr: COUNT(1)
      comment: "Total NCR records — quality event frequency baseline for trend analysis and system load assessment."
    - name: "on_hold_ncr_count"
      expr: COUNT(CASE WHEN hold_type IS NOT NULL THEN 1 END)
      comment: "Count of NCRs with active holds — material at risk metric for supply chain and production planning."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_reliability_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reliability test metrics tracking failure rates, FIT rates, test coverage, and qualification outcomes — critical for product qualification, customer confidence, and regulatory compliance in semiconductor markets."
  source: "`vibe_semiconductors_v1`.`quality`.`reliability_test`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Reliability test type (HTOL, ELFR, ESD, latch-up, etc.) for test category performance benchmarking."
    - name: "test_status"
      expr: test_status
      comment: "Current test execution status for pipeline and completion rate tracking."
    - name: "test_result"
      expr: test_result
      comment: "Overall test outcome (pass/fail/inconclusive) for qualification success rate analysis."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Qualification program type (AEC-Q100, JEDEC, customer-specific) for standards-based reporting."
    - name: "reliability_grade"
      expr: reliability_grade
      comment: "Reliability grade assigned (automotive/industrial/commercial) for product tier analysis."
    - name: "failure_mechanism"
      expr: failure_mechanism
      comment: "Physical failure mechanism (electromigration, TDDB, HCI, etc.) for reliability physics analysis."
    - name: "failure_mode"
      expr: failure_mode
      comment: "Failure mode classification for FMEA correlation and design improvement prioritization."
    - name: "device_type"
      expr: device_type
      comment: "Device type under test for product-family reliability benchmarking."
    - name: "overall_status"
      expr: overall_status
      comment: "Overall qualification program status for executive qualification dashboard."
    - name: "is_kgd_certified"
      expr: CAST(is_kgd_certified AS STRING)
      comment: "KGD certification flag for known-good-die reliability tracking."
  measures:
    - name: "avg_fit_rate"
      expr: AVG(CAST(fit_rate AS DOUBLE))
      comment: "Average FIT (Failures In Time) rate — primary reliability KPI used in product datasheets, customer qualification, and warranty cost modeling."
    - name: "avg_fit_rate_confidence"
      expr: AVG(CAST(fit_rate_confidence AS DOUBLE))
      comment: "Average FIT rate confidence level — statistical quality of reliability estimates for qualification report credibility."
    - name: "avg_failure_time_hours"
      expr: AVG(CAST(failure_time_hours AS DOUBLE))
      comment: "Average time-to-failure in hours — MTTF proxy for reliability modeling and warranty reserve calculations."
    - name: "avg_test_duration_hours"
      expr: AVG(CAST(test_duration_hours AS DOUBLE))
      comment: "Average test duration in hours — capacity planning metric for reliability lab scheduling."
    - name: "avg_test_temperature_c"
      expr: AVG(CAST(test_temperature_c AS DOUBLE))
      comment: "Average test temperature in Celsius — stress condition tracking for test standardization and comparison."
    - name: "avg_weibull_shape_parameter"
      expr: AVG(CAST(weibull_shape_parameter AS DOUBLE))
      comment: "Average Weibull shape parameter (beta) — characterizes failure distribution (infant mortality vs. wear-out) for reliability engineering decisions."
    - name: "avg_weibull_scale_parameter"
      expr: AVG(CAST(weibull_scale_parameter AS DOUBLE))
      comment: "Average Weibull scale parameter (eta) — characteristic life estimate for product lifetime modeling."
    - name: "pass_test_count"
      expr: COUNT(CASE WHEN test_result = 'pass' THEN 1 END)
      comment: "Count of passing reliability tests — qualification success rate numerator for program completion tracking."
    - name: "fail_test_count"
      expr: COUNT(CASE WHEN test_result = 'fail' THEN 1 END)
      comment: "Count of failing reliability tests — triggers mandatory failure analysis and qualification hold decisions."
    - name: "reliability_test_count"
      expr: COUNT(1)
      comment: "Total reliability tests executed — throughput baseline for qualification program progress tracking."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_spc_chart`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statistical Process Control (SPC) chart metrics tracking process capability, out-of-control events, and control limit adherence — drives real-time process intervention and continuous improvement decisions."
  source: "`vibe_semiconductors_v1`.`quality`.`spc_chart`"
  dimensions:
    - name: "chart_type"
      expr: chart_type
      comment: "SPC chart type (X-bar R, X-bar S, CUSUM, EWMA) for methodology-level analysis."
    - name: "parameter_name"
      expr: parameter_name
      comment: "Process parameter being monitored (e.g. CD, thickness, overlay) for parameter-level SPC performance."
    - name: "parameter_unit"
      expr: parameter_unit
      comment: "Unit of measure for the monitored parameter for dimensional analysis."
    - name: "out_of_control_flag"
      expr: CAST(out_of_control_flag AS STRING)
      comment: "Flags out-of-control SPC events — primary trigger for process engineer intervention."
    - name: "is_baseline"
      expr: CAST(is_baseline AS STRING)
      comment: "Indicates whether the chart represents a baseline period for capability benchmarking."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Measurement method used for SPC data collection for gauge R&R correlation."
    - name: "shift"
      expr: shift
      comment: "Production shift for shift-based process variation analysis."
    - name: "assignable_cause_code"
      expr: assignable_cause_code
      comment: "Root cause code assigned to out-of-control events for systematic cause elimination tracking."
    - name: "spc_chart_status"
      expr: spc_chart_status
      comment: "Chart status (active/archived/suspended) for SPC coverage monitoring."
  measures:
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measured parameter value — process centering KPI for process control and capability analysis."
    - name: "avg_center_line"
      expr: AVG(CAST(center_line AS DOUBLE))
      comment: "Average SPC center line value — process target tracking for drift detection."
    - name: "avg_upper_control_limit"
      expr: AVG(CAST(upper_control_limit AS DOUBLE))
      comment: "Average upper control limit — process spread baseline for control limit tightening decisions."
    - name: "avg_lower_control_limit"
      expr: AVG(CAST(lower_control_limit AS DOUBLE))
      comment: "Average lower control limit — process spread baseline for control limit tightening decisions."
    - name: "avg_control_limit_upper"
      expr: AVG(CAST(control_limit_upper AS DOUBLE))
      comment: "Average computed upper control limit for cross-chart control band comparison."
    - name: "avg_control_limit_lower"
      expr: AVG(CAST(control_limit_lower AS DOUBLE))
      comment: "Average computed lower control limit for cross-chart control band comparison."
    - name: "out_of_control_event_count"
      expr: COUNT(CASE WHEN out_of_control_flag = TRUE THEN 1 END)
      comment: "Count of out-of-control SPC events — primary process stability KPI; high counts trigger mandatory process engineering review and potential lot holds."
    - name: "total_spc_measurements"
      expr: COUNT(1)
      comment: "Total SPC measurements recorded — coverage metric for SPC program completeness and monitoring density."
    - name: "distinct_parameters_monitored"
      expr: COUNT(DISTINCT parameter_name)
      comment: "Number of distinct process parameters under SPC control — breadth-of-coverage KPI for process control program maturity."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_supplier_quality_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier quality scorecard metrics tracking overall supplier performance, delivery conformance, incoming quality rates, and cost of poor quality — drives supplier development, qualification, and sourcing decisions."
  source: "`vibe_semiconductors_v1`.`quality`.`supplier_quality_scorecard`"
  dimensions:
    - name: "scorecard_period"
      expr: scorecard_period
      comment: "Evaluation period (e.g. Q1-2024) for time-series supplier performance trending."
    - name: "supplier_type"
      expr: supplier_type
      comment: "Supplier category (OSAT, material, equipment) for segment-level quality benchmarking."
    - name: "tier_classification"
      expr: tier_classification
      comment: "Supplier tier (Tier 1/2/3) for tiered quality management and development prioritization."
    - name: "trend_direction"
      expr: trend_direction
      comment: "Quality trend direction (improving/stable/declining) for proactive supplier management."
    - name: "supplier_development_program"
      expr: supplier_development_program
      comment: "Active supplier development program for improvement initiative tracking."
  measures:
    - name: "avg_overall_quality_score"
      expr: AVG(CAST(overall_quality_score AS DOUBLE))
      comment: "Average overall supplier quality score — primary supplier performance KPI used in sourcing decisions and contract renewals."
    - name: "avg_delivery_score"
      expr: AVG(CAST(delivery_score AS DOUBLE))
      comment: "Average delivery performance score — on-time delivery KPI for supply chain reliability assessment."
    - name: "avg_kpi_incoming_quality_rate"
      expr: AVG(CAST(kpi_incoming_quality_rate AS DOUBLE))
      comment: "Average incoming quality rate KPI — measures fraction of incoming material meeting quality specifications."
    - name: "avg_kpi_delivery_conformance"
      expr: AVG(CAST(kpi_delivery_conformance AS DOUBLE))
      comment: "Average delivery conformance KPI — measures supplier adherence to committed delivery schedules."
    - name: "avg_kpi_cost_of_poor_quality"
      expr: AVG(CAST(kpi_cost_of_poor_quality AS DOUBLE))
      comment: "Average cost of poor quality KPI — financial impact of supplier quality failures for total cost of ownership analysis."
    - name: "avg_kpi_responsiveness"
      expr: AVG(CAST(kpi_responsiveness AS DOUBLE))
      comment: "Average supplier responsiveness score — measures speed of corrective action response for quality event management."
    - name: "supplier_scorecard_count"
      expr: COUNT(1)
      comment: "Total supplier scorecards issued — coverage metric for supplier quality program completeness."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_qualification_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality qualification program metrics tracking program completion rates, yield performance, DPPM targets, and budget utilization — drives product launch readiness and customer qualification decisions."
  source: "`vibe_semiconductors_v1`.`quality`.`quality_qualification_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current qualification program status (in-progress/complete/on-hold) for pipeline management."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Qualification type (AEC-Q100, JEDEC, customer-specific) for standards-based program tracking."
    - name: "qualification_standard"
      expr: qualification_standard
      comment: "Applicable qualification standard for compliance reporting."
    - name: "program_category"
      expr: program_category
      comment: "Program category (new product, process change, re-qualification) for portfolio analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Program risk level for executive escalation and resource prioritization."
    - name: "overall_status"
      expr: overall_status
      comment: "Overall qualification program health status for executive dashboard."
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status for compliance-gated product launches."
    - name: "kgd_certification_required"
      expr: CAST(kgd_certification_required AS STRING)
      comment: "Flag indicating KGD certification requirement for premium die qualification tracking."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Program lifecycle status for portfolio health monitoring."
  measures:
    - name: "avg_actual_yield_percent"
      expr: AVG(CAST(actual_yield_percent AS DOUBLE))
      comment: "Average actual yield achieved in qualification — measures whether qualification lots meet yield targets for production readiness."
    - name: "avg_target_yield_percent"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield for qualification programs — baseline for yield gap analysis."
    - name: "avg_dppm_actual"
      expr: AVG(CAST(dppm_actual AS DOUBLE))
      comment: "Average actual DPPM achieved in qualification — customer-facing quality metric for qualification approval decisions."
    - name: "avg_dppm_target"
      expr: AVG(CAST(dppm_target AS DOUBLE))
      comment: "Average DPPM target for qualification programs — baseline for quality gap analysis."
    - name: "total_program_budget_usd"
      expr: SUM(CAST(program_budget_usd AS DOUBLE))
      comment: "Total qualification program budget in USD — financial investment tracking for R&D and qualification cost management."
    - name: "avg_program_budget_usd"
      expr: AVG(CAST(program_budget_usd AS DOUBLE))
      comment: "Average qualification program budget — benchmarks investment per qualification for portfolio prioritization."
    - name: "active_program_count"
      expr: COUNT(CASE WHEN program_status = 'in-progress' THEN 1 END)
      comment: "Count of active qualification programs — pipeline capacity metric for qualification lab and engineering resource planning."
    - name: "completed_program_count"
      expr: COUNT(CASE WHEN program_status = 'complete' THEN 1 END)
      comment: "Count of completed qualification programs — throughput KPI for qualification team productivity."
    - name: "qualification_program_count"
      expr: COUNT(1)
      comment: "Total qualification programs — portfolio size baseline for capacity and investment planning."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_wafer_map`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer map quality metrics tracking die yield, defect density, and KGD certification rates across wafers — foundational spatial quality KPIs for yield management and die bank planning."
  source: "`vibe_semiconductors_v1`.`quality`.`wafer_map`"
  dimensions:
    - name: "map_status"
      expr: map_status
      comment: "Wafer map status (active/archived/pending) for data completeness tracking."
    - name: "defect_type"
      expr: defect_type
      comment: "Defect type captured in the wafer map for defect-type yield loss attribution."
    - name: "defect_zone"
      expr: defect_zone
      comment: "Spatial zone of defect concentration for systematic defect pattern identification."
    - name: "flat_orientation"
      expr: flat_orientation
      comment: "Wafer flat/notch orientation for orientation-dependent process analysis."
    - name: "is_kgd_certified"
      expr: CAST(is_kgd_certified AS STRING)
      comment: "KGD certification status for known-good-die supply planning."
    - name: "compliance_iso9001"
      expr: CAST(compliance_iso9001 AS STRING)
      comment: "ISO 9001 compliance flag for quality system reporting."
    - name: "compliance_iatf16949"
      expr: CAST(compliance_iatf16949 AS STRING)
      comment: "IATF 16949 compliance flag for automotive quality reporting."
  measures:
    - name: "avg_die_yield_percentage"
      expr: AVG(CAST(die_yield_percentage AS DOUBLE))
      comment: "Average die yield percentage per wafer map — primary wafer-level yield KPI for fab performance and revenue capacity planning."
    - name: "avg_defect_density_per_sqmm"
      expr: AVG(CAST(defect_density_per_sqmm AS DOUBLE))
      comment: "Average defect density per mm² — process cleanliness KPI for tool and process qualification decisions."
    - name: "avg_edge_exclusion_zone_mm"
      expr: AVG(CAST(edge_exclusion_zone_mm AS DOUBLE))
      comment: "Average edge exclusion zone in mm — process optimization metric for maximizing usable die area per wafer."
    - name: "kgd_certified_wafer_count"
      expr: COUNT(CASE WHEN is_kgd_certified = TRUE THEN 1 END)
      comment: "Count of KGD-certified wafer maps — supply availability metric for premium die customers and die bank planning."
    - name: "total_wafer_map_count"
      expr: COUNT(1)
      comment: "Total wafer maps generated — throughput baseline for wafer sort capacity and data completeness monitoring."
    - name: "distinct_wafers_mapped"
      expr: COUNT(DISTINCT wafer_id)
      comment: "Number of distinct wafers with maps — coverage metric for wafer sort program completeness."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_wafer_zone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer zone quality metrics tracking spatial defect density, yield variation, and critical zone identification — enables spatial yield analysis for process optimization and equipment qualification."
  source: "`vibe_semiconductors_v1`.`quality`.`wafer_zone`"
  dimensions:
    - name: "zone_type"
      expr: zone_type
      comment: "Zone classification (center, edge, ring, quadrant) for spatial yield pattern analysis."
    - name: "zone_status"
      expr: zone_status
      comment: "Zone status for active monitoring coverage tracking."
    - name: "shape"
      expr: shape
      comment: "Geometric shape of the zone (circular, rectangular, annular) for spatial analysis."
    - name: "is_critical"
      expr: CAST(is_critical AS STRING)
      comment: "Flags critical zones with elevated defect risk for priority monitoring and process intervention."
    - name: "process_step"
      expr: process_step
      comment: "Process step associated with zone defects for step-level spatial yield attribution."
    - name: "responsible_team"
      expr: responsible_team
      comment: "Team responsible for zone quality for accountability and escalation routing."
  measures:
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density AS DOUBLE))
      comment: "Average defect density per wafer zone — spatial quality KPI for identifying systematic process or equipment signatures."
    - name: "avg_typical_defect_density"
      expr: AVG(CAST(typical_defect_density AS DOUBLE))
      comment: "Average baseline (typical) defect density per zone — reference for excursion detection and control limit setting."
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average yield percentage per zone — spatial yield KPI for identifying yield-limiting zones and prioritizing process improvements."
    - name: "avg_area_um2"
      expr: AVG(CAST(area_um2 AS DOUBLE))
      comment: "Average zone area in µm² — normalization factor for defect density calculations and zone size standardization."
    - name: "critical_zone_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Count of critical wafer zones — risk exposure metric for process control prioritization."
    - name: "total_zone_count"
      expr: COUNT(1)
      comment: "Total wafer zones defined — coverage baseline for spatial monitoring program completeness."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_failure_analysis_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Failure analysis report metrics tracking analysis cycle time, failure mechanism distribution, and report closure rates — drives root-cause resolution speed and reliability improvement decisions."
  source: "`vibe_semiconductors_v1`.`quality`.`failure_analysis_report`"
  dimensions:
    - name: "failure_analysis_report_status"
      expr: failure_analysis_report_status
      comment: "Current FA report status for pipeline and aging analysis."
    - name: "report_type"
      expr: report_type
      comment: "FA report type (customer return, internal, reliability) for source-based analysis."
    - name: "failure_mechanism"
      expr: failure_mechanism
      comment: "Physical failure mechanism identified for reliability physics trending and design feedback."
    - name: "failure_severity"
      expr: failure_severity
      comment: "Severity of the failure for risk-based prioritization of analysis resources."
    - name: "analysis_method"
      expr: analysis_method
      comment: "FA analysis method (SEM, TEM, FIB, OBIRCH) for method effectiveness benchmarking."
    - name: "analysis_technique"
      expr: analysis_technique
      comment: "Specific analysis technique for detailed methodology tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Report approval status for quality system compliance tracking."
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause identified for systematic failure elimination tracking."
  measures:
    - name: "open_far_count"
      expr: COUNT(CASE WHEN failure_analysis_report_status != 'closed' THEN 1 END)
      comment: "Count of open failure analysis reports — backlog KPI for FA lab capacity and customer response time risk."
    - name: "total_far_count"
      expr: COUNT(1)
      comment: "Total failure analysis reports — volume baseline for FA demand trending and resource planning."
    - name: "distinct_failure_mechanisms"
      expr: COUNT(DISTINCT failure_mechanism)
      comment: "Number of distinct failure mechanisms identified — diversity metric for reliability risk portfolio assessment."
    - name: "approved_far_count"
      expr: COUNT(CASE WHEN approval_status = 'approved' THEN 1 END)
      comment: "Count of approved FA reports — completion rate metric for FA program throughput and quality system compliance."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_metrology_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality metrology measurement metrics tracking measurement accuracy, process parameter distributions, and spec conformance — drives process control, tool qualification, and yield improvement decisions."
  source: "`vibe_semiconductors_v1`.`quality`.`quality_metrology_measurement`"
  dimensions:
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of metrology measurement (CD-SEM, ellipsometry, profilometry) for method-level analysis."
    - name: "measurement_unit"
      expr: measurement_unit
      comment: "Unit of measure for dimensional analysis and cross-parameter comparison."
    - name: "parameter_name"
      expr: parameter_name
      comment: "Process parameter measured (e.g. CD, thickness, overlay) for parameter-level quality tracking."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Measurement pass/fail result for spec conformance rate analysis."
    - name: "measurement_mode"
      expr: measurement_mode
      comment: "Measurement mode (inline, offline, monitor) for measurement program coverage analysis."
    - name: "tool_qualification_status"
      expr: tool_qualification_status
      comment: "Qualification status of the measurement tool for data quality assurance."
    - name: "site_map_type"
      expr: site_map_type
      comment: "Site map pattern used for measurement for spatial coverage analysis."
    - name: "process_step"
      expr: process_step
      comment: "Process step at which measurement was taken for step-level process control."
  measures:
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measured parameter value — process centering KPI for process control and capability analysis."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value for measured parameters — baseline for process centering gap analysis."
    - name: "avg_spec_upper_limit"
      expr: AVG(CAST(spec_upper_limit AS DOUBLE))
      comment: "Average upper specification limit — process window baseline for capability analysis."
    - name: "avg_spec_lower_limit"
      expr: AVG(CAST(spec_lower_limit AS DOUBLE))
      comment: "Average lower specification limit — process window baseline for capability analysis."
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty — gauge capability KPI for measurement system qualification and data reliability assessment."
    - name: "pass_measurement_count"
      expr: COUNT(CASE WHEN pass_fail_status = 'pass' THEN 1 END)
      comment: "Count of passing measurements — spec conformance volume for process capability trending."
    - name: "fail_measurement_count"
      expr: COUNT(CASE WHEN pass_fail_status = 'fail' THEN 1 END)
      comment: "Count of failing measurements — out-of-spec volume triggering process engineer review and potential lot holds."
    - name: "total_measurement_count"
      expr: COUNT(1)
      comment: "Total metrology measurements — monitoring density baseline for process control program coverage assessment."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality hold metrics tracking hold volume, affected quantities, hold duration, and resolution rates — drives material risk management, supply chain impact assessment, and quality system responsiveness."
  source: "`vibe_semiconductors_v1`.`quality`.`quality_hold`"
  dimensions:
    - name: "hold_type"
      expr: hold_type
      comment: "Type of quality hold (process, material, customer, compliance) for hold category analysis."
    - name: "hold_status"
      expr: hold_status
      comment: "Current hold status (active/released/escalated) for hold pipeline management."
    - name: "hold_category"
      expr: hold_category
      comment: "Hold category for Pareto analysis of hold drivers."
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Standardized hold reason code for systematic hold cause analysis."
    - name: "priority"
      expr: priority
      comment: "Hold priority level for resource allocation and escalation decisions."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Hold resolution status for closure rate tracking."
    - name: "affected_entity_type"
      expr: affected_entity_type
      comment: "Type of entity on hold (lot, wafer, die bank) for material impact categorization."
    - name: "is_kgd_certified"
      expr: CAST(is_kgd_certified AS STRING)
      comment: "KGD certification status of held material for premium die supply impact assessment."
  measures:
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS DOUBLE))
      comment: "Total units/lots on quality hold — material at risk metric directly impacting supply availability and revenue."
    - name: "active_hold_count"
      expr: COUNT(CASE WHEN hold_status = 'active' THEN 1 END)
      comment: "Count of active quality holds — real-time supply risk KPI for operations and customer service escalation."
    - name: "total_hold_count"
      expr: COUNT(1)
      comment: "Total quality holds issued — volume baseline for hold frequency trending and quality system load assessment."
    - name: "released_hold_count"
      expr: COUNT(CASE WHEN hold_status = 'released' THEN 1 END)
      comment: "Count of released holds — resolution throughput metric for quality team responsiveness."
    - name: "kgd_material_on_hold_count"
      expr: COUNT(CASE WHEN is_kgd_certified = TRUE THEN 1 END)
      comment: "Count of KGD-certified material on hold — premium die supply risk metric requiring priority resolution."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality audit metrics tracking audit outcomes, nonconformance rates, and corrective action responsiveness — drives quality system maturity assessment and regulatory compliance governance."
  source: "`vibe_semiconductors_v1`.`quality`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Audit type (internal, supplier, customer, regulatory) for audit program portfolio analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Current audit status for pipeline and completion rate tracking."
    - name: "overall_result"
      expr: overall_result
      comment: "Overall audit result (pass/fail/conditional) for quality system health assessment."
    - name: "applicable_standard"
      expr: applicable_standard
      comment: "Applicable quality standard (ISO 9001, IATF 16949, JEDEC) for standards-based compliance reporting."
    - name: "scope"
      expr: scope
      comment: "Audit scope for coverage analysis and gap identification."
    - name: "result"
      expr: result
      comment: "Detailed audit result classification for outcome distribution analysis."
  measures:
    - name: "total_audit_count"
      expr: COUNT(1)
      comment: "Total audits conducted — quality program activity baseline for audit frequency and coverage tracking."
    - name: "pass_audit_count"
      expr: COUNT(CASE WHEN overall_result = 'pass' THEN 1 END)
      comment: "Count of passing audits — quality system compliance rate numerator for regulatory and customer reporting."
    - name: "fail_audit_count"
      expr: COUNT(CASE WHEN overall_result = 'fail' THEN 1 END)
      comment: "Count of failing audits — compliance risk indicator triggering mandatory CAPA and management review."
    - name: "open_audit_count"
      expr: COUNT(CASE WHEN audit_status != 'closed' THEN 1 END)
      comment: "Count of open audits — audit backlog metric for quality team capacity planning."
    - name: "distinct_standards_audited"
      expr: COUNT(DISTINCT applicable_standard)
      comment: "Number of distinct quality standards covered by audits — compliance program breadth metric for regulatory coverage assessment."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_defect_cluster`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Defect cluster metrics tracking systematic defect patterns, yield impact, and cluster severity — enables identification of equipment signatures and process excursions driving systematic yield loss."
  source: "`vibe_semiconductors_v1`.`quality`.`defect_cluster`"
  dimensions:
    - name: "cluster_type"
      expr: cluster_type
      comment: "Defect cluster type (ring, arc, edge, random) for pattern-based root cause analysis."
    - name: "defect_pattern"
      expr: defect_pattern
      comment: "Specific defect pattern signature for equipment and process correlation."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for systematic defect elimination prioritization."
    - name: "severity_level"
      expr: severity_level
      comment: "Cluster severity level for risk-based prioritization of investigation resources."
    - name: "review_status"
      expr: review_status
      comment: "Engineering review status for cluster investigation pipeline management."
    - name: "is_critical"
      expr: CAST(is_critical AS STRING)
      comment: "Flags critical defect clusters requiring immediate process engineering intervention."
    - name: "is_customer_reported"
      expr: CAST(is_customer_reported AS STRING)
      comment: "Flags customer-reported clusters for customer satisfaction impact tracking."
    - name: "customer_impact_flag"
      expr: CAST(customer_impact_flag AS STRING)
      comment: "Indicates customer-impacting clusters for escalation prioritization."
    - name: "associated_process_step"
      expr: associated_process_step
      comment: "Process step associated with the cluster for step-level yield loss attribution."
  measures:
    - name: "avg_impact_yield_percent"
      expr: AVG(CAST(impact_yield_percent AS DOUBLE))
      comment: "Average yield impact percentage per defect cluster — quantifies revenue impact of systematic defects for prioritization of engineering resources."
    - name: "avg_dppm"
      expr: AVG(CAST(dppm AS DOUBLE))
      comment: "Average DPPM associated with defect clusters — customer-facing quality impact metric for cluster severity assessment."
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average cluster measurement value for quantitative cluster characterization and trend tracking."
    - name: "critical_cluster_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Count of critical defect clusters — highest-priority yield loss drivers requiring immediate process engineering action."
    - name: "customer_reported_cluster_count"
      expr: COUNT(CASE WHEN is_customer_reported = TRUE THEN 1 END)
      comment: "Count of customer-reported defect clusters — customer satisfaction risk metric for quality escalation management."
    - name: "total_cluster_count"
      expr: COUNT(1)
      comment: "Total defect clusters identified — systematic defect volume baseline for process stability trending."
$$;