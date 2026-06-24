-- Metric views for domain: asset | Business: Automotive | Version: 2 | Generated on: 2026-06-23 04:49:37

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`asset_equipment_reliability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for equipment reliability and OEE performance, enabling maintenance and operations leadership to track asset health, availability, and overall equipment effectiveness across the fleet."
  source: "`vibe_automotive_v1`.`asset`.`equipment_reliability`"
  dimensions:
    - name: "plant_location"
      expr: plant_location
      comment: "Plant or facility location for geographic segmentation of reliability metrics."
    - name: "reliability_category"
      expr: reliability_category
      comment: "Category of reliability classification (e.g., critical, standard) for prioritized analysis."
    - name: "reliability_status"
      expr: reliability_status
      comment: "Current reliability status of the equipment record for filtering active vs. historical periods."
    - name: "reporting_period_start"
      expr: DATE_TRUNC('month', reporting_period_start)
      comment: "Monthly bucket of the reporting period start date for trend analysis."
    - name: "reporting_period_end"
      expr: DATE_TRUNC('month', reporting_period_end)
      comment: "Monthly bucket of the reporting period end date for period-over-period comparison."
  measures:
    - name: "avg_overall_oee_pct"
      expr: AVG(CAST(overall_oee_percentage AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness (OEE) percentage across equipment records. Core manufacturing KPI combining availability, performance, and quality — executives use this to benchmark plant efficiency and justify capital investment."
    - name: "avg_oee_availability_pct"
      expr: AVG(CAST(oee_availability_percentage AS DOUBLE))
      comment: "Average OEE availability component percentage. Measures the proportion of scheduled time equipment is actually available, directly informing maintenance scheduling decisions."
    - name: "avg_oee_performance_pct"
      expr: AVG(CAST(oee_performance_percentage AS DOUBLE))
      comment: "Average OEE performance component percentage. Measures how fast equipment runs relative to its designed speed, identifying throughput losses for operational improvement."
    - name: "avg_oee_quality_pct"
      expr: AVG(CAST(oee_quality_percentage AS DOUBLE))
      comment: "Average OEE quality component percentage. Measures the ratio of good parts to total parts produced, linking asset performance to product quality outcomes."
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mean_time_between_failures_hours AS DOUBLE))
      comment: "Average Mean Time Between Failures in hours. A leading reliability indicator — declining MTBF signals deteriorating asset health and triggers proactive maintenance investment decisions."
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mean_time_to_repair_hours AS DOUBLE))
      comment: "Average Mean Time To Repair in hours. Measures maintenance responsiveness — high MTTR indicates repair process inefficiencies or spare parts shortages requiring operational intervention."
    - name: "avg_availability_pct"
      expr: AVG(CAST(availability_percentage AS DOUBLE))
      comment: "Average equipment availability percentage across the reporting period. Directly tied to production capacity utilization and revenue generation potential."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(total_downtime_minutes AS DOUBLE))
      comment: "Total accumulated downtime minutes across all equipment records. Quantifies the aggregate production loss exposure and drives maintenance budget prioritization."
    - name: "total_uptime_minutes"
      expr: SUM(CAST(total_uptime_minutes AS DOUBLE))
      comment: "Total accumulated uptime minutes across all equipment records. Baseline for capacity utilization calculations and production planning."
    - name: "avg_failure_rate_per_hour"
      expr: AVG(CAST(failure_rate_per_hour AS DOUBLE))
      comment: "Average equipment failure rate per operating hour. A key reliability engineering metric used to predict maintenance intervals and optimize spare parts inventory."
    - name: "total_maintenance_cost"
      expr: SUM(CAST(maintenance_cost_amount AS DOUBLE))
      comment: "Total maintenance cost across all equipment reliability records. Directly informs maintenance budget allocation and cost-of-ownership analysis for asset lifecycle decisions."
    - name: "equipment_record_count"
      expr: COUNT(1)
      comment: "Count of equipment reliability records in the reporting period. Baseline denominator for fleet-level reliability benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`asset_equipment_downtime`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for equipment downtime events, enabling plant managers and maintenance leaders to quantify production losses, identify root causes, and prioritize corrective investments."
  source: "`vibe_automotive_v1`.`asset`.`equipment_downtime`"
  dimensions:
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of downtime event (e.g., planned, unplanned, breakdown) for structured root-cause analysis."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause code for the downtime event, enabling Pareto analysis of failure drivers."
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of maintenance associated with the downtime (e.g., corrective, preventive) for maintenance strategy evaluation."
    - name: "cause_severity"
      expr: cause_severity
      comment: "Severity classification of the downtime cause for risk-based prioritization."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the downtime event affected a critical asset, enabling focused executive attention on high-impact failures."
    - name: "shift"
      expr: shift
      comment: "Production shift during which the downtime occurred, enabling shift-level performance comparison."
    - name: "downtime_start_month"
      expr: DATE_TRUNC('month', start_timestamp)
      comment: "Monthly bucket of downtime start timestamp for trend analysis."
  measures:
    - name: "total_cost_of_downtime"
      expr: SUM(CAST(cost_of_downtime AS DOUBLE))
      comment: "Total financial cost of all downtime events. The primary financial KPI for downtime — directly informs maintenance investment decisions and insurance/risk management strategies."
    - name: "avg_oee_impact_pct"
      expr: AVG(CAST(oee_impact_percentage AS DOUBLE))
      comment: "Average OEE impact percentage per downtime event. Quantifies how much each downtime category degrades overall equipment effectiveness, steering maintenance prioritization."
    - name: "total_oee_impact_pct"
      expr: SUM(CAST(oee_impact_percentage AS DOUBLE))
      comment: "Cumulative OEE impact percentage across all downtime events in the period. Aggregated view of total OEE degradation for executive reporting."
    - name: "downtime_event_count"
      expr: COUNT(1)
      comment: "Total number of downtime events. Baseline frequency metric — rising event counts signal deteriorating asset health or inadequate preventive maintenance."
    - name: "critical_downtime_event_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Count of downtime events on critical assets. Executives track this separately because critical asset failures have disproportionate impact on production throughput and safety."
    - name: "unplanned_downtime_event_count"
      expr: COUNT(CASE WHEN scheduled_maintenance_flag = FALSE THEN 1 END)
      comment: "Count of unplanned (unscheduled) downtime events. Unplanned downtime is the primary driver of production loss and maintenance cost overruns — a key operational steering metric."
    - name: "avg_cost_per_downtime_event"
      expr: AVG(CAST(cost_of_downtime AS DOUBLE))
      comment: "Average financial cost per downtime event. Enables cost benchmarking across equipment categories and root cause codes to prioritize high-cost failure modes."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`asset_maintenance_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial KPIs for maintenance expenditure, enabling finance and operations leadership to track total cost of ownership, labor vs. materials split, and maintenance cost efficiency across the asset fleet."
  source: "`vibe_automotive_v1`.`asset`.`maintenance_cost`"
  dimensions:
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of maintenance (e.g., corrective, preventive, predictive) for cost-by-strategy analysis."
    - name: "maintenance_status"
      expr: maintenance_status
      comment: "Current status of the maintenance activity for filtering completed vs. in-progress cost records."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the maintenance cost record for multi-currency fleet cost consolidation."
    - name: "work_center"
      expr: work_center
      comment: "Work center where maintenance was performed for cost allocation by production area."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Monthly bucket of the cost posting date for trend and budget variance analysis."
    - name: "warranty_flag"
      expr: warranty_flag
      comment: "Flag indicating whether the maintenance was covered under warranty, enabling warranty recovery tracking."
  measures:
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total maintenance expenditure across all records. The primary financial KPI for asset management — directly informs maintenance budget planning and cost-of-ownership analysis."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost component of maintenance. Enables workforce cost analysis and make-vs-buy decisions for maintenance services."
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost AS DOUBLE))
      comment: "Total material cost component of maintenance. Drives spare parts inventory investment decisions and supplier negotiation strategies."
    - name: "total_spare_parts_cost"
      expr: SUM(CAST(spare_parts_cost AS DOUBLE))
      comment: "Total spare parts cost across maintenance activities. Key input for spare parts stocking strategy and supplier contract negotiations."
    - name: "total_external_service_cost"
      expr: SUM(CAST(external_service_cost AS DOUBLE))
      comment: "Total cost of externally contracted maintenance services. Informs outsourcing strategy and vendor performance management decisions."
    - name: "avg_labor_hours_per_order"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labor hours per maintenance cost record. Benchmarks maintenance labor efficiency and informs workforce capacity planning."
    - name: "avg_labor_rate"
      expr: AVG(CAST(labor_rate AS DOUBLE))
      comment: "Average labor rate applied to maintenance activities. Enables cost benchmarking across work centers and informs rate negotiation with service providers."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on maintenance costs. Required for accurate financial reporting and tax compliance in multi-jurisdiction operations."
    - name: "warranty_covered_record_count"
      expr: COUNT(CASE WHEN warranty_flag = TRUE THEN 1 END)
      comment: "Count of maintenance records covered under warranty. Quantifies warranty recovery opportunities and informs supplier warranty negotiation."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`asset_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial KPIs for asset valuation and depreciation, enabling finance leadership to track net book value, accumulated depreciation, impairment exposure, and revaluation activity across the asset portfolio."
  source: "`vibe_automotive_v1`.`asset`.`asset_valuation`"
  dimensions:
    - name: "valuation_type"
      expr: valuation_type
      comment: "Type of valuation (e.g., book, fair value, impairment) for segmented financial reporting."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (e.g., straight-line, declining balance) for accounting policy analysis."
    - name: "asset_valuation_status"
      expr: asset_valuation_status
      comment: "Current status of the valuation record for filtering active vs. historical valuations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the valuation for multi-currency portfolio consolidation."
    - name: "valuation_date_month"
      expr: DATE_TRUNC('month', valuation_date)
      comment: "Monthly bucket of the valuation date for period-over-period balance sheet analysis."
    - name: "impairment_indicator"
      expr: impairment_indicator
      comment: "Flag indicating whether an impairment was recognized, enabling focused review of impaired assets."
    - name: "revaluation_flag"
      expr: revaluation_flag
      comment: "Flag indicating whether a revaluation was applied, for tracking revaluation surplus/deficit."
  measures:
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of all assets in the portfolio. The primary balance sheet KPI for asset management — directly reported in financial statements and used for capital allocation decisions."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across the asset portfolio. Measures the consumed economic value of assets and informs asset replacement planning."
    - name: "total_depreciation_expense_current_year"
      expr: SUM(CAST(depreciation_expense_current_year AS DOUBLE))
      comment: "Total current-year depreciation expense. A key P&L line item that directly impacts EBITDA and tax calculations — tracked closely by CFOs."
    - name: "total_impairment_amount"
      expr: SUM(CAST(impairment_amount AS DOUBLE))
      comment: "Total impairment charges recognized across the portfolio. Impairment is a significant non-cash charge that impacts earnings — executives monitor this for early warning of asset value deterioration."
    - name: "total_revaluation_amount"
      expr: SUM(CAST(revaluation_amount AS DOUBLE))
      comment: "Total revaluation adjustments applied to assets. Tracks the cumulative impact of fair value adjustments on the balance sheet."
    - name: "total_residual_value"
      expr: SUM(CAST(residual_value AS DOUBLE))
      comment: "Total estimated residual value of assets at end of useful life. Informs asset disposal planning and lease vs. buy decisions."
    - name: "avg_depreciation_rate_pct"
      expr: AVG(CAST(depreciation_rate_percent AS DOUBLE))
      comment: "Average depreciation rate percentage across the asset portfolio. Enables benchmarking of depreciation policy consistency and identification of outlier assets."
    - name: "impaired_asset_count"
      expr: COUNT(CASE WHEN impairment_indicator = TRUE THEN 1 END)
      comment: "Count of asset valuation records with recognized impairment. Tracks the breadth of impairment exposure across the portfolio for risk management reporting."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`asset_maintenance_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for maintenance order execution, enabling maintenance managers to track cost performance, schedule adherence, and order throughput across the maintenance program."
  source: "`vibe_automotive_v1`.`asset`.`maintenance_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of maintenance order (e.g., corrective, preventive, inspection) for strategy-level performance analysis."
    - name: "order_status"
      expr: order_status
      comment: "Current status of the maintenance order (e.g., open, in-progress, completed) for backlog and throughput tracking."
    - name: "priority"
      expr: priority
      comment: "Priority level of the maintenance order for risk-based workload management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the maintenance order cost for multi-currency reporting."
    - name: "planned_start_month"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Monthly bucket of planned start date for maintenance schedule analysis."
  measures:
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual maintenance cost across all orders. Primary financial KPI for maintenance execution — compared against budget to identify cost overruns requiring management action."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated maintenance cost across all orders. Baseline for budget planning and cost variance analysis."
    - name: "avg_actual_cost_per_order"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per maintenance order. Benchmarks maintenance cost efficiency and identifies high-cost order types for process improvement."
    - name: "maintenance_order_count"
      expr: COUNT(1)
      comment: "Total number of maintenance orders. Baseline volume metric for maintenance workload planning and resource allocation."
    - name: "open_order_count"
      expr: COUNT(CASE WHEN order_status NOT IN ('COMPLETED', 'CLOSED', 'CANCELLED') THEN 1 END)
      comment: "Count of open (not yet completed) maintenance orders. Tracks maintenance backlog — a key operational risk indicator when backlog grows beyond capacity."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`asset_calibration_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and compliance KPIs for equipment calibration, enabling quality managers to track calibration compliance rates, costs, and overdue calibrations that create regulatory and product quality risk."
  source: "`vibe_automotive_v1`.`asset`.`calibration_record`"
  dimensions:
    - name: "calibration_type"
      expr: calibration_type
      comment: "Type of calibration performed (e.g., dimensional, electrical, pressure) for compliance tracking by measurement category."
    - name: "calibration_record_status"
      expr: calibration_record_status
      comment: "Current status of the calibration record (e.g., passed, failed, overdue) for compliance monitoring."
    - name: "result"
      expr: result
      comment: "Calibration result outcome (e.g., pass, fail, conditional) for quality compliance reporting."
    - name: "calibration_method"
      expr: calibration_method
      comment: "Calibration method applied for traceability and standards compliance analysis."
    - name: "calibration_date_month"
      expr: DATE_TRUNC('month', calibration_date)
      comment: "Monthly bucket of calibration date for trend analysis of calibration activity and compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of calibration cost for financial reporting."
  measures:
    - name: "total_calibration_cost"
      expr: SUM(CAST(calibration_cost AS DOUBLE))
      comment: "Total cost of calibration activities. Informs quality assurance budget planning and make-vs-buy decisions for calibration services."
    - name: "avg_calibration_cost"
      expr: AVG(CAST(calibration_cost AS DOUBLE))
      comment: "Average cost per calibration event. Benchmarks calibration cost efficiency and identifies high-cost calibration types for optimization."
    - name: "calibration_record_count"
      expr: COUNT(1)
      comment: "Total number of calibration records. Baseline for calibration program coverage and compliance rate calculations."
    - name: "failed_calibration_count"
      expr: COUNT(CASE WHEN result = 'FAIL' THEN 1 END)
      comment: "Count of failed calibration events. Failed calibrations indicate measurement system risk — a critical quality and regulatory compliance indicator requiring immediate corrective action."
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty across calibration records. Tracks the precision of the measurement system — high uncertainty values signal calibration quality degradation affecting product conformance."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`asset_compliance_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory and compliance KPIs for asset compliance assessments, enabling EHS and compliance leadership to track assessment outcomes, corrective action requirements, and regulatory exposure across the asset fleet."
  source: "`vibe_automotive_v1`.`asset`.`compliance_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of compliance assessment (e.g., safety, environmental, regulatory) for domain-specific compliance tracking."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status outcome (e.g., compliant, non-compliant, conditional) for executive risk reporting."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment record (e.g., open, closed, in-review) for workflow management."
    - name: "compliance_standard"
      expr: compliance_standard
      comment: "Regulatory or industry standard assessed against (e.g., ISO 14001, OSHA) for standard-specific compliance tracking."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Regulatory jurisdiction of the assessment for geographic compliance risk analysis."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Flag indicating whether corrective action is required, enabling focused tracking of non-compliant assets."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Monthly bucket of assessment date for compliance trend analysis."
  measures:
    - name: "assessment_count"
      expr: COUNT(1)
      comment: "Total number of compliance assessments conducted. Baseline for compliance program coverage and audit frequency tracking."
    - name: "non_compliant_assessment_count"
      expr: COUNT(CASE WHEN compliance_status = 'NON_COMPLIANT' THEN 1 END)
      comment: "Count of assessments with non-compliant outcomes. The primary regulatory risk KPI — rising non-compliance counts signal systemic issues requiring executive intervention and potential regulatory penalties."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Count of assessments requiring corrective action. Tracks the open corrective action backlog — a key compliance risk indicator for EHS leadership."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across all assessments. Provides a normalized view of compliance health across the asset fleet for executive dashboard reporting."
    - name: "distinct_equipment_assessed_count"
      expr: COUNT(DISTINCT equipment_registry_id)
      comment: "Count of distinct equipment assets that have been compliance-assessed. Measures the breadth of compliance program coverage across the asset fleet."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`asset_acquisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure KPIs for asset acquisitions, enabling finance and asset management leadership to track acquisition spend, installation costs, and asset portfolio growth by category and type."
  source: "`vibe_automotive_v1`.`asset`.`acquisition`"
  dimensions:
    - name: "asset_type"
      expr: asset_type
      comment: "Type of asset acquired (e.g., machinery, tooling, IT equipment) for capex portfolio analysis."
    - name: "asset_category"
      expr: asset_category
      comment: "Category of asset for financial classification and depreciation policy assignment."
    - name: "acquisition_status"
      expr: acquisition_status
      comment: "Current status of the acquisition (e.g., approved, in-progress, commissioned) for capex pipeline tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the acquisition request for governance and budget control monitoring."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method assigned at acquisition for accounting policy consistency analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the acquisition cost for multi-currency capex reporting."
    - name: "acquisition_month"
      expr: DATE_TRUNC('month', acquisition_timestamp)
      comment: "Monthly bucket of acquisition timestamp for capex spend trend analysis."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total acquisition cost of assets. The primary capex KPI — directly reported in capital expenditure budgets and used by CFOs to track investment against approved capex plans."
    - name: "total_installation_cost"
      expr: SUM(CAST(installation_cost AS DOUBLE))
      comment: "Total installation cost associated with asset acquisitions. Often underestimated in capex planning — tracking this separately enables more accurate total cost of ownership modeling."
    - name: "total_gross_amount"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Total gross acquisition amount including all charges. Used for full capex commitment tracking in financial reporting."
    - name: "total_net_amount"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net acquisition amount after discounts. The net capex figure used in financial statements and budget variance analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax amount on asset acquisitions. Required for tax planning and VAT/GST recovery analysis in multi-jurisdiction operations."
    - name: "acquisition_count"
      expr: COUNT(1)
      comment: "Total number of asset acquisitions. Tracks the volume of capital investment activity and portfolio growth rate."
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average acquisition cost per asset. Benchmarks unit investment levels across asset categories and informs future capex budgeting."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`asset_equipment_service_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service contract KPIs for equipment service subscriptions, enabling asset and procurement leadership to track contracted service spend, coverage levels, and subscription portfolio health."
  source: "`vibe_automotive_v1`.`asset`.`equipment_service_subscription`"
  dimensions:
    - name: "subscription_type"
      expr: subscription_type
      comment: "Type of service subscription (e.g., full-service, parts-only, remote monitoring) for contract portfolio analysis."
    - name: "equipment_service_subscription_status"
      expr: equipment_service_subscription_status
      comment: "Current status of the subscription (e.g., active, expired, cancelled) for contract lifecycle management."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage type of the subscription (e.g., 24/7, business hours) for SLA compliance analysis."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency (e.g., monthly, annual) for cash flow planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the subscription billing for multi-currency contract portfolio reporting."
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Flag indicating auto-renewal status for contract renewal risk management."
    - name: "spare_parts_included_flag"
      expr: spare_parts_included_flag
      comment: "Flag indicating whether spare parts are included in the subscription for total cost of ownership analysis."
  measures:
    - name: "total_billing_amount"
      expr: SUM(CAST(billing_amount AS DOUBLE))
      comment: "Total contracted billing amount across all service subscriptions. Primary financial KPI for service contract spend — tracked by procurement and finance for vendor cost management."
    - name: "total_monthly_fee"
      expr: SUM(CAST(monthly_fee AS DOUBLE))
      comment: "Total monthly recurring fee across all active subscriptions. Enables run-rate service cost forecasting for budget planning."
    - name: "total_claims_value"
      expr: SUM(CAST(total_claims_value AS DOUBLE))
      comment: "Total value of claims made against service subscriptions. Measures the utilization of contracted service coverage and informs contract value assessment."
    - name: "avg_uptime_guarantee_pct"
      expr: AVG(CAST(uptime_guarantee_pct AS DOUBLE))
      comment: "Average contracted uptime guarantee percentage across subscriptions. Benchmarks SLA commitments and informs vendor selection and contract negotiation."
    - name: "avg_penalty_per_hour_downtime"
      expr: AVG(CAST(penalty_per_hour_downtime AS DOUBLE))
      comment: "Average penalty rate per hour of downtime across service contracts. Quantifies the financial incentive structure for vendor performance and informs contract design."
    - name: "active_subscription_count"
      expr: COUNT(CASE WHEN equipment_service_subscription_status = 'ACTIVE' THEN 1 END)
      comment: "Count of currently active service subscriptions. Tracks the size of the contracted service portfolio and coverage breadth across the asset fleet."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`asset_condition_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IoT and predictive maintenance KPIs for equipment condition monitoring, enabling maintenance and operations leadership to track anomaly rates, predicted failure timelines, and sensor health across the connected asset fleet."
  source: "`vibe_automotive_v1`.`asset`.`condition_monitoring`"
  dimensions:
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement being monitored (e.g., vibration, temperature, pressure) for sensor-specific analysis."
    - name: "equipment_status"
      expr: equipment_status
      comment: "Current operational status of the monitored equipment for fleet health segmentation."
    - name: "condition_monitoring_status"
      expr: condition_monitoring_status
      comment: "Status of the condition monitoring record for workflow and alert management."
    - name: "anomaly_detected"
      expr: anomaly_detected
      comment: "Flag indicating whether an anomaly was detected in the monitoring reading, enabling focused analysis of at-risk assets."
    - name: "maintenance_action_required"
      expr: maintenance_action_required
      comment: "Flag indicating whether a maintenance action was triggered by the monitoring event, for proactive maintenance tracking."
    - name: "threshold_breach_flag"
      expr: threshold_breach_flag
      comment: "Flag indicating whether a sensor threshold was breached, for alert frequency analysis."
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Monthly bucket of the monitoring event timestamp for trend analysis of condition deterioration."
  measures:
    - name: "anomaly_detection_count"
      expr: COUNT(CASE WHEN anomaly_detected = TRUE THEN 1 END)
      comment: "Count of monitoring readings where an anomaly was detected. The primary predictive maintenance KPI — rising anomaly counts signal accelerating asset degradation requiring proactive intervention."
    - name: "threshold_breach_count"
      expr: COUNT(CASE WHEN threshold_breach_flag = TRUE THEN 1 END)
      comment: "Count of sensor threshold breach events. Threshold breaches trigger maintenance alerts — tracking frequency by equipment and measurement type enables targeted maintenance prioritization."
    - name: "avg_anomaly_score"
      expr: AVG(CAST(anomaly_score AS DOUBLE))
      comment: "Average ML-derived anomaly score across monitoring readings. Provides a continuous health index for the asset fleet, enabling risk-ranked maintenance scheduling."
    - name: "avg_predicted_time_to_failure_hours"
      expr: AVG(CAST(predicted_time_to_failure_hours AS DOUBLE))
      comment: "Average predicted time to failure in hours across monitored assets. The core predictive maintenance KPI — enables just-in-time maintenance scheduling to minimize both downtime and unnecessary preventive maintenance costs."
    - name: "avg_reliability_score"
      expr: AVG(CAST(reliability_score AS DOUBLE))
      comment: "Average ML-derived reliability score across monitored assets. Provides a normalized fleet health index for executive reporting and maintenance investment prioritization."
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average sensor measurement value across all readings. Baseline for detecting drift in operating conditions that precede equipment failures."
    - name: "monitoring_reading_count"
      expr: COUNT(1)
      comment: "Total number of condition monitoring readings. Tracks sensor data coverage and monitoring program completeness across the connected asset fleet."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`asset_acquisition_financials`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial view of asset acquisitions for CFO and investment decisions"
  source: "`vibe_automotive_v1`.`asset`.`acquisition`"
  dimensions:
    - name: "acquisition_month"
      expr: DATE_TRUNC('month', acquisition_timestamp)
      comment: "Month of acquisition"
    - name: "asset_category"
      expr: asset_category
      comment: "Category of the acquired asset"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction"
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total acquisition cost (raw cost) across all assets"
    - name: "average_acquisition_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average acquisition cost per asset"
    - name: "total_gross_amount"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Sum of gross amounts invoiced for acquisitions"
    - name: "total_net_amount"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Sum of net amounts after discounts/taxes"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`asset_equipment_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core equipment inventory and performance KPIs for operations leadership"
  source: "`vibe_automotive_v1`.`asset`.`equipment_registry`"
  dimensions:
    - name: "equipment_category"
      expr: equipment_category
      comment: "Category of equipment (e.g., motor, pump)"
  measures:
    - name: "equipment_count"
      expr: COUNT(1)
      comment: "Number of equipment records"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`asset_equipment_registry_attributes`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dimensional view for slicing equipment KPIs"
  source: "`vibe_automotive_v1`.`asset`.`equipment_registry`"
  dimensions:
    - name: "manufacturer"
      expr: manufacturer
      comment: "Equipment manufacturer"
    - name: "model_number"
      expr: model_number
      comment: "Model number of equipment"
  measures:
    - name: "Row Count"
      expr: COUNT(1)
      comment: "Total rows"
$$;