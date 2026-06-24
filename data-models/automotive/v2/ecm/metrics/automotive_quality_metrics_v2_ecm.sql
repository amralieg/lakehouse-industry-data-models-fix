-- Metric views for domain: quality | Business: Automotive | Version: 2 | Generated on: 2026-06-23 04:49:37

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_defect_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational defect tracking KPIs covering defect volume, severity distribution, PPM rates, and repeat-defect rates. Used by Quality Directors and Plant Managers to steer corrective action prioritization and supplier quality programs."
  source: "`vibe_automotive_v1`.`quality`.`defect_record`"
  dimensions:
    - name: "defect_category"
      expr: defect_category
      comment: "Category of defect (e.g., dimensional, cosmetic, functional) for segmenting defect volumes."
    - name: "defect_type"
      expr: defect_type
      comment: "Specific defect type classification for drill-down analysis."
    - name: "severity"
      expr: severity
      comment: "Severity level of the defect (critical, major, minor) for risk-based prioritization."
    - name: "detection_method"
      expr: detection_method
      comment: "How the defect was detected (in-process, end-of-line, field) to evaluate detection effectiveness."
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the defect (rework, scrap, use-as-is) for cost impact analysis."
    - name: "defect_record_status"
      expr: defect_record_status
      comment: "Current status of the defect record (open, closed, in-progress) for workload management."
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause category to identify systemic quality issues."
    - name: "detected_month"
      expr: DATE_TRUNC('MONTH', detected_timestamp)
      comment: "Month of defect detection for trend analysis."
    - name: "is_repeat_defect"
      expr: is_repeat_defect
      comment: "Flag indicating whether this is a recurring defect, critical for recurrence prevention programs."
  measures:
    - name: "total_defect_records"
      expr: COUNT(1)
      comment: "Total number of defect records. Baseline volume metric for quality performance dashboards."
    - name: "avg_ppm_rate"
      expr: AVG(CAST(ppm_rate AS DOUBLE))
      comment: "Average Parts Per Million defect rate across all records. Core quality KPI used in supplier scorecards and plant performance reviews."
    - name: "repeat_defect_count"
      expr: COUNT(CASE WHEN is_repeat_defect = TRUE THEN 1 END)
      comment: "Count of repeat defects. High repeat rates signal ineffective corrective actions and drive escalation decisions."
    - name: "critical_defect_count"
      expr: COUNT(CASE WHEN severity = 'Critical' THEN 1 END)
      comment: "Count of critical-severity defects. Directly triggers safety reviews and potential recall investigations."
    - name: "open_defect_count"
      expr: COUNT(CASE WHEN defect_record_status = 'Open' THEN 1 END)
      comment: "Count of unresolved defect records. Measures quality backlog and response effectiveness."
    - name: "distinct_affected_vins"
      expr: COUNT(DISTINCT vin)
      comment: "Number of distinct VINs affected by defects. Indicates field exposure breadth for recall risk assessment."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_ppm_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PPM (Parts Per Million) quality performance metrics by supplier, plant, and model year. Used by Quality VPs and Supply Chain Directors to manage supplier quality agreements and plant performance targets."
  source: "`vibe_automotive_v1`.`quality`.`ppm_record`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code for geographic and facility-level PPM benchmarking."
    - name: "model_year"
      expr: model_year
      comment: "Model year for tracking quality trends across vehicle generations."
    - name: "defect_category"
      expr: defect_category
      comment: "Defect category for PPM breakdown by failure type."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (incoming, in-process, final) to segment PPM by detection stage."
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period (month, quarter) for periodic quality reviews."
    - name: "ppm_record_status"
      expr: ppm_record_status
      comment: "Status of the PPM record for filtering active vs. closed measurements."
    - name: "trend_indicator"
      expr: trend_indicator
      comment: "Trend direction (improving, stable, deteriorating) for executive quality dashboards."
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month of measurement for time-series PPM trend analysis."
  measures:
    - name: "avg_ppm_value"
      expr: AVG(CAST(ppm_value AS DOUBLE))
      comment: "Average PPM value across all records. Primary quality KPI for supplier and plant performance scorecards."
    - name: "max_ppm_value"
      expr: MAX(ppm_value)
      comment: "Maximum PPM value observed. Identifies worst-case quality outliers requiring immediate intervention."
    - name: "avg_ppm_variance"
      expr: AVG(CAST(ppm_variance AS DOUBLE))
      comment: "Average variance between actual and target PPM. Measures consistency of quality performance against commitments."
    - name: "total_defective_parts_sum"
      expr: SUM(CAST(total_defective_parts AS DOUBLE))
      comment: "Total number of defective parts across all PPM records. Drives scrap cost and rework resource planning."
    - name: "total_parts_received_sum"
      expr: SUM(CAST(total_parts_received AS DOUBLE))
      comment: "Total parts received across all PPM records. Denominator for overall incoming quality rate calculations."
    - name: "avg_target_ppm"
      expr: AVG(CAST(target_ppm AS DOUBLE))
      comment: "Average PPM target. Used alongside avg_ppm_value to assess target attainment."
    - name: "outlier_record_count"
      expr: COUNT(CASE WHEN is_outlier = TRUE THEN 1 END)
      comment: "Count of PPM records flagged as statistical outliers. Signals process instability requiring investigation."
    - name: "gate_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_gate_passed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PPM records where the quality gate was passed. Key throughput quality metric for production readiness."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_inspection_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dimensional quality inspection outcome metrics covering process capability (Cp/Cpk), measurement accuracy, and defect detection rates. Used by Quality Engineers and Plant Managers to assess process stability and gauge effectiveness."
  source: "`vibe_automotive_v1`.`quality`.`inspection_result`"
  dimensions:
    - name: "result_status"
      expr: result_status
      comment: "Pass/fail/conditional result status for filtering conforming vs. non-conforming measurements."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Measurement method used (CMM, manual, automated) for method capability comparison."
    - name: "measurement_unit"
      expr: measurement_unit
      comment: "Unit of measure for grouping results by characteristic type."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag for critical characteristics requiring tighter control limits."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_timestamp)
      comment: "Month of inspection for trend analysis of process capability over time."
    - name: "record_status"
      expr: record_status
      comment: "Record lifecycle status for filtering active inspection results."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total inspection results recorded. Baseline volume for inspection throughput reporting."
    - name: "avg_cpk_value"
      expr: AVG(CAST(cpk_value AS DOUBLE))
      comment: "Average process capability index (Cpk). Core SPC metric — Cpk < 1.33 triggers process improvement actions."
    - name: "avg_cp_value"
      expr: AVG(CAST(cp_value AS DOUBLE))
      comment: "Average process potential index (Cp). Measures inherent process spread relative to specification width."
    - name: "avg_deviation_amount"
      expr: AVG(CAST(deviation_amount AS DOUBLE))
      comment: "Average deviation from nominal. Indicates systematic bias in the manufacturing process."
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty. Drives gauge calibration and MSA investment decisions."
    - name: "non_conforming_count"
      expr: COUNT(CASE WHEN result_status = 'Fail' THEN 1 END)
      comment: "Count of non-conforming inspection results. Directly feeds defect rate and scrap cost calculations."
    - name: "critical_non_conforming_count"
      expr: COUNT(CASE WHEN is_critical = TRUE AND result_status = 'Fail' THEN 1 END)
      comment: "Count of non-conforming results on critical characteristics. Triggers immediate production stop and escalation."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality audit performance metrics covering audit scores, finding rates, corrective action compliance, and closure rates. Used by Quality Directors and Compliance Officers to manage supplier and plant audit programs."
  source: "`vibe_automotive_v1`.`quality`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (process, product, system, supplier) for segmenting audit performance by scope."
    - name: "audit_status"
      expr: audit_status
      comment: "Current audit status (planned, in-progress, closed) for workload and compliance tracking."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the audit for prioritizing follow-up resources."
    - name: "result"
      expr: result
      comment: "Overall audit result (pass, conditional pass, fail) for compliance reporting."
    - name: "score_category"
      expr: score_category
      comment: "Score band category for executive-level audit performance distribution reporting."
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', audit_date)
      comment: "Month of audit for trend analysis of audit program cadence and outcomes."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating whether a corrective action was required, for CA burden analysis."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body associated with the audit for compliance program segmentation."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audits conducted. Baseline for audit program coverage and cadence reporting."
    - name: "avg_audit_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average audit score. Primary KPI for supplier and plant quality system maturity assessment."
    - name: "audits_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of audits that generated corrective action requirements. Measures systemic quality risk exposure."
    - name: "closed_audit_count"
      expr: COUNT(CASE WHEN audit_status = 'Closed' THEN 1 END)
      comment: "Count of closed audits. Used to calculate audit closure rate and program effectiveness."
    - name: "corrective_action_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_status = 'Closed' THEN 1 END) / NULLIF(COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of required corrective actions that have been closed. Measures CA program effectiveness and compliance."
    - name: "ai_inspection_utilization_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ai_inspection_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits utilizing AI-assisted inspection. Tracks digital quality transformation progress."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action program effectiveness metrics covering closure rates, recurrence, cost of quality, and 8D compliance. Used by Quality VPs and Operations Directors to evaluate the effectiveness of the quality improvement system."
  source: "`vibe_automotive_v1`.`quality`.`quality_corrective_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action (containment, root cause, preventive) for program segmentation."
    - name: "action_status"
      expr: action_status
      comment: "Current status of the corrective action for workload and compliance tracking."
    - name: "severity"
      expr: severity
      comment: "Severity level of the underlying issue driving the corrective action."
    - name: "priority"
      expr: priority
      comment: "Priority level for resource allocation and escalation decisions."
    - name: "effectiveness_status"
      expr: effectiveness_status
      comment: "Effectiveness verification status (verified, not verified, pending) for CA quality assessment."
    - name: "is_eight_d_flag"
      expr: is_eight_d_flag
      comment: "Flag indicating 8D methodology was applied. Tracks structured problem-solving adoption."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Flag for recurring issues. High recurrence rates indicate systemic root cause failures."
    - name: "opened_month"
      expr: DATE_TRUNC('MONTH', opened_date)
      comment: "Month the corrective action was opened for trend and aging analysis."
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total corrective actions raised. Baseline volume metric for quality problem management."
    - name: "total_cost_of_corrective_actions"
      expr: SUM(CAST(cost_of_action AS DOUBLE))
      comment: "Total cost of all corrective actions. Directly measures cost of poor quality (COPQ) for financial reporting."
    - name: "avg_cost_per_corrective_action"
      expr: AVG(CAST(cost_of_action AS DOUBLE))
      comment: "Average cost per corrective action. Benchmarks CA efficiency and drives make-vs-buy quality investment decisions."
    - name: "effectiveness_verified_count"
      expr: COUNT(CASE WHEN effectiveness_verified = TRUE THEN 1 END)
      comment: "Count of corrective actions with verified effectiveness. Measures quality of the CA closure process."
    - name: "recurring_issue_count"
      expr: COUNT(CASE WHEN is_recurring = TRUE THEN 1 END)
      comment: "Count of recurring corrective actions. High recurrence signals systemic root cause failures requiring escalation."
    - name: "eight_d_adoption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_eight_d_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions using 8D methodology. Tracks structured problem-solving discipline."
    - name: "open_corrective_action_count"
      expr: COUNT(CASE WHEN action_status = 'Open' THEN 1 END)
      comment: "Count of open corrective actions. Measures quality backlog and response capacity."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_supplier_quality_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier quality event metrics covering defect volumes, resolution times, repeat issues, and critical event rates. Used by Supplier Quality Engineers and Procurement Directors to manage supplier performance and sourcing decisions."
  source: "`vibe_automotive_v1`.`quality`.`supplier_quality_event`"
  dimensions:
    - name: "defect_severity"
      expr: defect_severity
      comment: "Severity of the supplier quality event for risk-based supplier management."
    - name: "detection_method"
      expr: detection_method
      comment: "How the supplier quality event was detected (incoming inspection, line stoppage, field) for detection effectiveness analysis."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status for tracking open supplier quality issues."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the event for supplier escalation and development program prioritization."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag for critical supplier quality events that may trigger line stoppages or recalls."
    - name: "is_repeat_issue"
      expr: is_repeat_issue
      comment: "Flag for repeat supplier quality issues. Drives supplier development or disqualification decisions."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of the supplier quality event for trend analysis and supplier scorecards."
    - name: "sca_requested"
      expr: sca_requested
      comment: "Flag indicating a Supplier Corrective Action was requested. Tracks formal escalation rate."
  measures:
    - name: "total_supplier_quality_events"
      expr: COUNT(1)
      comment: "Total supplier quality events. Baseline volume for supplier quality scorecards and sourcing reviews."
    - name: "critical_event_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Count of critical supplier quality events. Directly informs supplier risk ratings and sourcing decisions."
    - name: "repeat_issue_count"
      expr: COUNT(CASE WHEN is_repeat_issue = TRUE THEN 1 END)
      comment: "Count of repeat supplier quality issues. High repeat rates trigger supplier development plans or disqualification."
    - name: "sca_request_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sca_requested = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of supplier quality events escalated to formal Supplier Corrective Action. Measures escalation intensity."
    - name: "regulatory_compliance_event_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Count of supplier quality events with regulatory compliance implications. Drives compliance risk management."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_warranty_quality_signal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warranty quality signal metrics covering systemic failure detection, financial impact, and affected vehicle populations. Used by Quality Directors and Product Engineering to prioritize field quality investigations and recall risk assessments."
  source: "`vibe_automotive_v1`.`quality`.`warranty_quality_signal`"
  dimensions:
    - name: "failure_mode"
      expr: failure_mode
      comment: "Failure mode classification for systemic issue identification and engineering escalation."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the warranty signal for risk-based prioritization."
    - name: "source_type"
      expr: source_type
      comment: "Source of the quality signal (warranty claim, field return, telemetry) for signal triangulation."
    - name: "signal_status"
      expr: signal_status
      comment: "Current status of the quality signal (new, under investigation, closed) for workload management."
    - name: "is_systemic"
      expr: is_systemic
      comment: "Flag for systemic quality signals affecting multiple vehicles. Triggers recall risk assessment."
    - name: "is_repeat_signal"
      expr: is_repeat_signal
      comment: "Flag for recurring quality signals. Indicates ineffective prior corrective actions."
    - name: "model_year"
      expr: model_year
      comment: "Model year of affected vehicles for vintage quality analysis."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of the signal for management attention and resource allocation."
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_timestamp)
      comment: "Month of signal detection for early warning trend analysis."
  measures:
    - name: "total_quality_signals"
      expr: COUNT(1)
      comment: "Total warranty quality signals. Baseline for field quality monitoring and early warning systems."
    - name: "total_affected_vins"
      expr: SUM(CAST(affected_vin_count AS DOUBLE))
      comment: "Total VINs affected across all quality signals. Primary metric for recall risk exposure quantification."
    - name: "total_financial_impact"
      expr: SUM(CAST(impact_amount AS DOUBLE))
      comment: "Total financial impact of warranty quality signals. Drives cost of poor quality reporting and engineering investment decisions."
    - name: "avg_severity_score"
      expr: AVG(CAST(severity_score AS DOUBLE))
      comment: "Average severity score of quality signals. Used to prioritize engineering investigation resources."
    - name: "systemic_signal_count"
      expr: COUNT(CASE WHEN is_systemic = TRUE THEN 1 END)
      comment: "Count of systemic quality signals. Each systemic signal triggers a formal field quality investigation and potential recall assessment."
    - name: "total_occurrence_count"
      expr: SUM(CAST(occurrence_count AS DOUBLE))
      comment: "Total occurrences across all quality signals. Measures field failure frequency for statistical significance assessment."
    - name: "distinct_failure_modes"
      expr: COUNT(DISTINCT failure_mode)
      comment: "Number of distinct failure modes observed. Breadth of failure mode diversity informs engineering resource allocation."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_field_return`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field return financial and operational metrics covering return volumes, labor costs, repair completion rates, and warranty linkage. Used by Quality and Aftersales Directors to manage field quality costs and repair network efficiency."
  source: "`vibe_automotive_v1`.`quality`.`field_return`"
  dimensions:
    - name: "return_type"
      expr: return_type
      comment: "Type of field return (warranty, goodwill, recall) for cost categorization."
    - name: "return_reason"
      expr: return_reason
      comment: "Reason for return for root cause and product improvement analysis."
    - name: "repair_status"
      expr: repair_status
      comment: "Current repair status for tracking open field return workload."
    - name: "defect_code"
      expr: defect_code
      comment: "Defect code associated with the return for failure mode analysis."
    - name: "field_return_status"
      expr: field_return_status
      comment: "Overall status of the field return record for lifecycle management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of financial amounts for multi-currency cost reporting."
    - name: "return_month"
      expr: DATE_TRUNC('MONTH', return_timestamp)
      comment: "Month of return for trend analysis of field quality costs."
  measures:
    - name: "total_field_returns"
      expr: COUNT(1)
      comment: "Total field returns. Baseline volume for field quality performance reporting."
    - name: "total_gross_return_cost"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross cost of all field returns. Primary financial KPI for cost of poor quality in the field."
    - name: "total_net_return_cost"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net cost after adjustments. Used for accurate COPQ financial reporting."
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labor hours consumed by field returns. Drives service network capacity planning."
    - name: "avg_labor_hours_per_return"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labor hours per field return. Benchmarks repair complexity and technician efficiency."
    - name: "avg_labor_rate"
      expr: AVG(CAST(labor_rate AS DOUBLE))
      comment: "Average labor rate across field returns. Used for cost modeling and service network rate negotiations."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on field returns. Required for accurate financial accruals and tax reporting."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_ncap_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NCAP safety test result metrics covering star ratings, raw scores by crash test type, and homologation compliance. Used by Product Safety Directors and Regulatory Affairs teams to manage vehicle safety certification and market launch readiness."
  source: "`vibe_automotive_v1`.`quality`.`ncap_test_result`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "NCAP test type (frontal, side, pole, pedestrian) for safety performance segmentation."
    - name: "test_program"
      expr: test_program
      comment: "NCAP program (Euro NCAP, NHTSA, ANCAP) for regional safety compliance tracking."
    - name: "star_rating"
      expr: star_rating
      comment: "Overall star rating for executive safety performance reporting and marketing decisions."
    - name: "homologation_status"
      expr: homologation_status
      comment: "Homologation status for regulatory compliance and market launch gate decisions."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status for regulatory reporting and type approval management."
    - name: "model_year"
      expr: model_year
      comment: "Model year for tracking safety performance improvements across vehicle generations."
    - name: "test_result_status"
      expr: test_result_status
      comment: "Status of the test result record for filtering confirmed vs. provisional results."
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', test_date)
      comment: "Month of test for program timeline and homologation milestone tracking."
  measures:
    - name: "total_ncap_tests"
      expr: COUNT(1)
      comment: "Total NCAP tests conducted. Baseline for safety testing program coverage."
    - name: "avg_raw_score_front"
      expr: AVG(CAST(raw_score_front AS DOUBLE))
      comment: "Average frontal crash raw score. Key safety KPI for product development and regulatory compliance."
    - name: "avg_raw_score_side"
      expr: AVG(CAST(raw_score_side AS DOUBLE))
      comment: "Average side impact raw score. Tracks side protection performance across vehicle variants."
    - name: "avg_raw_score_pole"
      expr: AVG(CAST(raw_score_pole AS DOUBLE))
      comment: "Average pole impact raw score. Measures structural integrity performance for safety certification."
    - name: "homologation_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN homologation_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NCAP tests achieving homologation approval. Critical gate metric for market launch readiness."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_wltp_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "WLTP emissions and fuel consumption test result metrics for regulatory compliance and ESG reporting. Used by Regulatory Affairs, Product Engineering, and Sustainability teams to manage emissions certification and CO2 fleet average compliance."
  source: "`vibe_automotive_v1`.`quality`.`wltp_test_result`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "WLTP test type (full, partial, combined) for regulatory reporting segmentation."
    - name: "homologation_status"
      expr: homologation_status
      comment: "Homologation status for type approval and market launch gate management."
    - name: "test_result_status"
      expr: test_result_status
      comment: "Status of the test result for filtering confirmed vs. provisional emissions data."
    - name: "model_year"
      expr: model_year
      comment: "Model year for tracking emissions performance improvements across vehicle generations."
    - name: "powertrain_variant_code"
      expr: powertrain_variant_code
      comment: "Powertrain variant for segmenting emissions performance by drivetrain type."
    - name: "test_methodology"
      expr: test_methodology
      comment: "Test methodology applied for regulatory compliance verification."
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', test_timestamp)
      comment: "Month of test for emissions trend analysis and regulatory submission planning."
  measures:
    - name: "total_wltp_tests"
      expr: COUNT(1)
      comment: "Total WLTP tests conducted. Baseline for emissions certification program coverage."
    - name: "avg_total_co2_g_per_km"
      expr: AVG(CAST(total_co2_g_per_km AS DOUBLE))
      comment: "Average combined CO2 emissions in g/km. Primary regulatory KPI for EU fleet average CO2 compliance and ESG reporting."
    - name: "avg_total_fuel_l_per_100km"
      expr: AVG(CAST(total_fuel_l_per_100km AS DOUBLE))
      comment: "Average combined fuel consumption in L/100km. Key product efficiency metric for consumer labeling and regulatory compliance."
    - name: "avg_electric_range_km"
      expr: AVG(CAST(electric_range_km AS DOUBLE))
      comment: "Average electric range in km. Critical KPI for BEV/PHEV product positioning and regulatory zero-emission vehicle credits."
    - name: "avg_nox_mg_per_km"
      expr: AVG(CAST(nox_mg_per_km AS DOUBLE))
      comment: "Average NOx emissions in mg/km. Regulatory compliance metric for Euro 6/7 and equivalent standards."
    - name: "avg_particulate_mg_per_km"
      expr: AVG(CAST(particulate_mg_per_km AS DOUBLE))
      comment: "Average particulate emissions in mg/km. Regulatory compliance metric for particulate emission standards."
    - name: "homologation_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN homologation_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of WLTP tests achieving homologation approval. Gate metric for vehicle market launch readiness."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_ppap_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PPAP (Production Part Approval Process) submission metrics covering approval rates, resubmission rates, and interim approval usage. Used by Supplier Quality and Procurement teams to manage part approval readiness for production launch."
  source: "`vibe_automotive_v1`.`quality`.`quality_ppap_submission`"
  dimensions:
    - name: "ppap_level"
      expr: ppap_level
      comment: "PPAP submission level (1-5) for understanding depth of supplier quality evidence required."
    - name: "submission_status"
      expr: submission_status
      comment: "Current submission status (approved, rejected, pending) for launch readiness tracking."
    - name: "disposition"
      expr: disposition
      comment: "Disposition of the PPAP submission for quality program management."
    - name: "reason_for_submission"
      expr: reason_for_submission
      comment: "Reason for PPAP submission (new part, engineering change, supplier change) for change management analysis."
    - name: "interim_approval_flag"
      expr: interim_approval_flag
      comment: "Flag for interim approvals. High interim approval rates signal launch readiness risk."
    - name: "resubmission_required"
      expr: resubmission_required
      comment: "Flag for submissions requiring resubmission. Measures first-time approval quality."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of submission for launch timeline and PPAP backlog management."
  measures:
    - name: "total_ppap_submissions"
      expr: COUNT(1)
      comment: "Total PPAP submissions. Baseline for supplier part approval program coverage."
    - name: "approved_submission_count"
      expr: COUNT(CASE WHEN submission_status = 'Approved' THEN 1 END)
      comment: "Count of approved PPAP submissions. Measures launch readiness of the supply base."
    - name: "first_time_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN resubmission_required = FALSE AND submission_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PPAP submissions approved without resubmission. Key supplier quality maturity KPI."
    - name: "interim_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN interim_approval_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions with interim approvals. High rates indicate launch risk and require management escalation."
    - name: "psw_signed_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN psw_signed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions with signed Part Submission Warrants. Measures documentation compliance for production readiness."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_spc_data_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statistical Process Control (SPC) data point metrics covering process capability indices, out-of-control rates, and measurement system performance. Used by Quality Engineers and Plant Managers to monitor and control manufacturing process stability."
  source: "`vibe_automotive_v1`.`quality`.`spc_data_point`"
  dimensions:
    - name: "process_step"
      expr: process_step
      comment: "Manufacturing process step for locating quality control issues in the production flow."
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement (variable, attribute) for SPC chart type selection."
    - name: "measurement_unit"
      expr: measurement_unit
      comment: "Unit of measure for grouping SPC data by characteristic type."
    - name: "shift"
      expr: shift
      comment: "Production shift for identifying shift-to-shift process variation."
    - name: "out_of_control_flag"
      expr: out_of_control_flag
      comment: "Flag for out-of-control data points. Triggers immediate process investigation."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag for critical characteristics requiring tighter SPC monitoring."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Flag for data quality issues in the measurement. Used to filter unreliable data from capability calculations."
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month of measurement for process capability trend analysis."
  measures:
    - name: "total_spc_data_points"
      expr: COUNT(1)
      comment: "Total SPC data points collected. Baseline for measurement system coverage and sampling adequacy."
    - name: "avg_cpk_value"
      expr: AVG(CAST(cpk_value AS DOUBLE))
      comment: "Average process capability index (Cpk). Core SPC KPI — values below 1.33 trigger process improvement actions."
    - name: "avg_cp_value"
      expr: AVG(CAST(cp_value AS DOUBLE))
      comment: "Average process potential (Cp). Measures inherent process spread relative to specification width."
    - name: "avg_ppk_value"
      expr: AVG(CAST(ppk_value AS DOUBLE))
      comment: "Average overall process performance index (Ppk). Used for PPAP submissions and customer capability reporting."
    - name: "out_of_control_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN out_of_control_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SPC data points that are out of control. Measures process instability rate for corrective action prioritization."
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measured value across all SPC data points. Used to detect process mean shifts."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding metrics covering finding severity distribution, closure rates, and corrective action compliance. Used by Quality Compliance Officers and Audit Program Managers to assess audit effectiveness and regulatory risk."
  source: "`vibe_automotive_v1`.`quality`.`quality_audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Type of audit finding (observation, minor NC, major NC) for severity-based prioritization."
    - name: "finding_severity"
      expr: finding_severity
      comment: "Severity of the finding for risk-based corrective action prioritization."
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the finding (process, documentation, system) for systemic issue identification."
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the finding for closure rate tracking."
    - name: "nonconformance_category"
      expr: nonconformance_category
      comment: "Non-conformance category for quality system gap analysis."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating corrective action is required for this finding."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the finding for management escalation decisions."
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month finding was identified for trend analysis of audit program outcomes."
  measures:
    - name: "total_audit_findings"
      expr: COUNT(1)
      comment: "Total audit findings. Baseline for audit program effectiveness and quality system health assessment."
    - name: "open_finding_count"
      expr: COUNT(CASE WHEN finding_status = 'Open' THEN 1 END)
      comment: "Count of open audit findings. Measures compliance backlog and corrective action responsiveness."
    - name: "finding_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN finding_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audit findings that have been closed. Primary KPI for audit program effectiveness and regulatory compliance."
    - name: "major_nc_count"
      expr: COUNT(CASE WHEN finding_severity = 'Major' THEN 1 END)
      comment: "Count of major non-conformance findings. Directly triggers escalation and potential certification suspension."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of findings requiring corrective action. Measures quality system improvement burden."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_apqp_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "APQP (Advanced Product Quality Planning) program metrics covering gate completion rates, PPM target attainment, and launch readiness. Used by Program Quality Managers and Product Development Directors to manage quality milestones for new vehicle launches."
  source: "`vibe_automotive_v1`.`quality`.`apqp_plan`"
  dimensions:
    - name: "apqp_phase"
      expr: apqp_phase
      comment: "APQP phase (1-5) for tracking quality planning progress through the product development lifecycle."
    - name: "gate_status"
      expr: gate_status
      comment: "Status of the current quality gate for launch readiness assessment."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the APQP plan for resource prioritization and escalation decisions."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the APQP plan for program portfolio management."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status for regulatory and customer quality requirement tracking."
    - name: "model_year"
      expr: model_year
      comment: "Model year for tracking APQP quality performance across vehicle program generations."
    - name: "milestone_gate"
      expr: milestone_gate
      comment: "Specific milestone gate for granular program quality milestone tracking."
  measures:
    - name: "total_apqp_plans"
      expr: COUNT(1)
      comment: "Total APQP plans. Baseline for quality planning program coverage across vehicle programs."
    - name: "avg_actual_ppm"
      expr: AVG(CAST(actual_ppm AS DOUBLE))
      comment: "Average actual PPM achieved at launch. Measures quality launch readiness against program targets."
    - name: "avg_target_ppm"
      expr: AVG(CAST(target_ppm AS DOUBLE))
      comment: "Average PPM target across APQP plans. Baseline for target attainment calculations."
    - name: "avg_quality_goal_ppm"
      expr: AVG(CAST(quality_goal_ppm AS DOUBLE))
      comment: "Average quality goal PPM. Used to assess ambition level of quality targets across programs."
    - name: "on_time_gate_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gate_completion_date <= gate_due_date AND gate_status = 'Completed' THEN 1 END) / NULLIF(COUNT(CASE WHEN gate_status = 'Completed' THEN 1 END), 0), 2)
      comment: "Percentage of quality gates completed on time. Critical launch readiness KPI for program management reviews."
    - name: "high_risk_plan_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Count of APQP plans at high risk level. Drives executive escalation and resource reallocation decisions."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_gate_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance of quality gates across production"
  source: "`vibe_automotive_v1`.`quality`.`gate_result`"
  dimensions:
    - name: "gate_id"
      expr: gate_id
      comment: "Identifier of the gate"
    - name: "gate_type"
      expr: gate_type
      comment: "Type of gate (e.g., assembly, final)"
    - name: "gate_status"
      expr: gate_status
      comment: "Result status of the gate"
    - name: "gate_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of gate result creation"
  measures:
    - name: "gate_result_count"
      expr: COUNT(1)
      comment: "Total number of gate result events"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score assigned at gate"
    - name: "gate_pass_rate"
      expr: AVG(CAST(CASE WHEN gate_status = 'PASS' THEN 1 ELSE 0 END AS DOUBLE))
      comment: "Proportion of gates with a PASS status"
$$;