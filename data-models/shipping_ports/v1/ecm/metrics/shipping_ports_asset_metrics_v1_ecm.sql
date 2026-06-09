-- Metric views for domain: asset | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 03:36:32

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`asset_port_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core asset performance and financial metrics for port equipment and infrastructure, tracking utilization, reliability, and book value"
  source: "`shipping_ports_ecm`.`asset`.`port_asset`"
  dimensions:
    - name: "asset_category"
      expr: asset_category
      comment: "Type of port asset (crane, tug, terminal equipment, infrastructure)"
    - name: "asset_status"
      expr: asset_status
      comment: "Current operational status of the asset"
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Business criticality classification of the asset"
    - name: "maintenance_strategy"
      expr: maintenance_strategy
      comment: "Maintenance approach (preventive, predictive, reactive)"
    - name: "capex_classification"
      expr: capex_classification
      comment: "Capital expenditure classification for financial reporting"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation calculation method applied to the asset"
    - name: "commissioning_year"
      expr: YEAR(commissioning_date)
      comment: "Year the asset was commissioned for service"
    - name: "environmental_compliance_flag"
      expr: environmental_compliance_flag
      comment: "Whether asset meets environmental compliance standards"
  measures:
    - name: "total_asset_count"
      expr: COUNT(1)
      comment: "Total number of port assets in the portfolio"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total capital invested in acquiring port assets"
    - name: "total_current_book_value"
      expr: SUM(CAST(current_book_value AS DOUBLE))
      comment: "Total current book value of all port assets"
    - name: "total_residual_value"
      expr: SUM(CAST(residual_value AS DOUBLE))
      comment: "Total estimated residual value at end of useful life"
    - name: "avg_asset_age_years"
      expr: AVG(DATEDIFF(CURRENT_DATE(), commissioning_date) / 365.25)
      comment: "Average age of port assets in years since commissioning"
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mean_time_between_failures AS DOUBLE))
      comment: "Average mean time between failures across all assets, indicating reliability"
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mean_time_to_repair AS DOUBLE))
      comment: "Average mean time to repair across all assets, indicating maintainability"
    - name: "total_operating_hours"
      expr: SUM(CAST(operating_hours AS DOUBLE))
      comment: "Total cumulative operating hours across all port assets"
    - name: "avg_swl_rating_tonnes"
      expr: AVG(CAST(swl_rating AS DOUBLE))
      comment: "Average safe working load rating in tonnes for lifting equipment"
    - name: "asset_depreciation_rate_pct"
      expr: ROUND(100.0 * (SUM(CAST(acquisition_cost AS DOUBLE)) - SUM(CAST(current_book_value AS DOUBLE))) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Portfolio-wide depreciation rate as percentage of original acquisition cost"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`asset_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance execution and cost performance metrics tracking work order completion, efficiency, and budget variance"
  source: "`shipping_ports_ecm`.`asset`.`work_order`"
  dimensions:
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of maintenance work (preventive, corrective, predictive, emergency)"
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the work order"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_datetime)
      comment: "Month when work order was completed"
    - name: "equipment_shutdown_required_flag"
      expr: equipment_shutdown_required_flag
      comment: "Whether equipment shutdown was required for maintenance"
    - name: "safety_permit_required_flag"
      expr: safety_permit_required_flag
      comment: "Whether safety permit was required for the work"
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Whether work order is associated with a warranty claim"
    - name: "parts_availability_status"
      expr: parts_availability_status
      comment: "Status of spare parts availability for the work order"
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of maintenance work orders"
    - name: "total_work_order_cost"
      expr: SUM(CAST(total_work_order_cost AS DOUBLE))
      comment: "Total cost of all work orders including labor, materials, and contractor costs"
    - name: "total_labour_hours"
      expr: SUM(CAST(actual_labour_hours AS DOUBLE))
      comment: "Total actual labor hours spent on maintenance work orders"
    - name: "total_material_cost"
      expr: SUM(CAST(actual_material_cost AS DOUBLE))
      comment: "Total cost of materials consumed in maintenance work orders"
    - name: "total_contractor_cost"
      expr: SUM(CAST(actual_contractor_cost AS DOUBLE))
      comment: "Total cost paid to external contractors for maintenance work"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total equipment downtime hours caused by maintenance activities"
    - name: "avg_work_order_cost"
      expr: AVG(CAST(total_work_order_cost AS DOUBLE))
      comment: "Average cost per work order"
    - name: "avg_labour_hours_per_wo"
      expr: AVG(CAST(actual_labour_hours AS DOUBLE))
      comment: "Average labor hours per work order"
    - name: "avg_downtime_hours_per_wo"
      expr: AVG(CAST(downtime_hours AS DOUBLE))
      comment: "Average equipment downtime per work order"
    - name: "schedule_variance_pct"
      expr: ROUND(100.0 * AVG(DATEDIFF(actual_end_datetime, planned_end_datetime)) / NULLIF(AVG(DATEDIFF(planned_end_datetime, planned_start_datetime)), 0), 2)
      comment: "Average schedule variance as percentage of planned duration, indicating planning accuracy"
    - name: "cost_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(actual_labour_hours AS DOUBLE)) - SUM(CAST(estimated_labour_hours AS DOUBLE))) / NULLIF(SUM(CAST(estimated_labour_hours AS DOUBLE)), 0), 2)
      comment: "Labor hour variance as percentage of estimate, indicating cost control effectiveness"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`asset_downtime_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset availability and downtime impact metrics tracking unplanned outages, root causes, and operational impact on port throughput"
  source: "`shipping_ports_ecm`.`asset`.`downtime_record`"
  dimensions:
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of downtime event (mechanical, electrical, operational, environmental)"
    - name: "downtime_status"
      expr: downtime_status
      comment: "Current status of the downtime event"
    - name: "downtime_reason_code"
      expr: downtime_reason_code
      comment: "Standardized code for downtime root cause"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level category of root cause analysis"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the downtime event"
    - name: "downtime_month"
      expr: DATE_TRUNC('MONTH', downtime_start_timestamp)
      comment: "Month when downtime event started"
    - name: "is_safety_related"
      expr: is_safety_related
      comment: "Whether downtime event was related to safety concerns"
    - name: "is_regulatory_reportable"
      expr: is_regulatory_reportable
      comment: "Whether downtime event requires regulatory reporting"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether downtime event breached service level agreement"
    - name: "mtbf_impact_flag"
      expr: mtbf_impact_flag
      comment: "Whether event impacts mean time between failures calculation"
    - name: "mttr_impact_flag"
      expr: mttr_impact_flag
      comment: "Whether event impacts mean time to repair calculation"
  measures:
    - name: "total_downtime_events"
      expr: COUNT(1)
      comment: "Total number of downtime events recorded"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Total hours of asset downtime across all events"
    - name: "total_maintenance_cost"
      expr: SUM(CAST(maintenance_cost_amount AS DOUBLE))
      comment: "Total maintenance cost incurred due to downtime events"
    - name: "avg_downtime_duration_hours"
      expr: AVG(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Average duration of downtime events in hours"
    - name: "avg_resolution_time_hours"
      expr: AVG(DATEDIFF(resolution_timestamp, reported_timestamp) * 24.0)
      comment: "Average time from downtime report to resolution in hours"
    - name: "avg_response_time_hours"
      expr: AVG(DATEDIFF(acknowledged_timestamp, reported_timestamp) * 24.0)
      comment: "Average time from downtime report to acknowledgment in hours"
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of downtime events that breached service level agreements"
    - name: "safety_related_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_safety_related = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of downtime events related to safety concerns"
    - name: "regulatory_reportable_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_regulatory_reportable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of downtime events requiring regulatory reporting"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`asset_failure_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset failure analysis and reliability metrics tracking failure modes, severity, recurrence, and impact on operations"
  source: "`shipping_ports_ecm`.`asset`.`failure_report`"
  dimensions:
    - name: "failure_class"
      expr: failure_class
      comment: "Classification of failure type"
    - name: "failure_mode"
      expr: failure_mode
      comment: "Specific mode of failure (wear, fatigue, overload, etc.)"
    - name: "failure_severity"
      expr: failure_severity
      comment: "Severity level of the failure event"
    - name: "root_cause"
      expr: root_cause
      comment: "Identified root cause of the failure"
    - name: "report_status"
      expr: report_status
      comment: "Current status of the failure report"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the failure"
    - name: "failure_month"
      expr: DATE_TRUNC('MONTH', failure_datetime)
      comment: "Month when failure occurred"
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Whether failure resulted in a safety incident"
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Whether failure had environmental impact"
    - name: "failure_recurrence_flag"
      expr: failure_recurrence_flag
      comment: "Whether this is a recurring failure"
    - name: "warranty_claim_eligible_flag"
      expr: warranty_claim_eligible_flag
      comment: "Whether failure is eligible for warranty claim"
    - name: "swl_exceeded_flag"
      expr: swl_exceeded_flag
      comment: "Whether safe working load was exceeded at time of failure"
  measures:
    - name: "total_failure_reports"
      expr: COUNT(1)
      comment: "Total number of asset failure reports"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total downtime hours caused by failures"
    - name: "total_estimated_repair_cost"
      expr: SUM(CAST(estimated_repair_cost AS DOUBLE))
      comment: "Total estimated cost to repair all failures"
    - name: "avg_downtime_per_failure"
      expr: AVG(CAST(downtime_hours AS DOUBLE))
      comment: "Average downtime hours per failure event"
    - name: "avg_repair_cost_per_failure"
      expr: AVG(CAST(estimated_repair_cost AS DOUBLE))
      comment: "Average estimated repair cost per failure"
    - name: "avg_operating_hours_at_failure"
      expr: AVG(CAST(operating_hours_at_failure AS DOUBLE))
      comment: "Average operating hours accumulated before failure, indicating reliability"
    - name: "avg_cycles_at_failure"
      expr: AVG(CAST(cycles_at_failure AS DOUBLE))
      comment: "Average operational cycles before failure"
    - name: "failure_recurrence_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN failure_recurrence_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of failures that are recurring, indicating chronic issues"
    - name: "safety_incident_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN safety_incident_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of failures resulting in safety incidents"
    - name: "warranty_eligible_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN warranty_claim_eligible_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of failures eligible for warranty claims"
    - name: "swl_exceeded_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN swl_exceeded_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of failures where safe working load was exceeded"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`asset_maintenance_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance planning and compliance metrics tracking scheduled maintenance execution, cost, and adherence"
  source: "`shipping_ports_ecm`.`asset`.`maintenance_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of maintenance plan (preventive, predictive, condition-based)"
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the maintenance plan"
    - name: "priority"
      expr: priority
      comment: "Priority level of the maintenance plan"
    - name: "asset_class"
      expr: asset_class
      comment: "Class of assets covered by the plan"
    - name: "maintenance_frequency_unit"
      expr: maintenance_frequency_unit
      comment: "Unit of measurement for maintenance frequency (days, hours, cycles)"
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for executing the maintenance plan"
    - name: "compliance_certificate_required"
      expr: compliance_certificate_required
      comment: "Whether compliance certification is required"
    - name: "auto_generate_work_order"
      expr: auto_generate_work_order
      comment: "Whether work orders are automatically generated from this plan"
    - name: "regulatory_requirement"
      expr: regulatory_requirement
      comment: "Regulatory requirement driving the maintenance plan"
  measures:
    - name: "total_maintenance_plans"
      expr: COUNT(1)
      comment: "Total number of active maintenance plans"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all maintenance plans"
    - name: "total_estimated_downtime_hours"
      expr: SUM(CAST(estimated_downtime_hours AS DOUBLE))
      comment: "Total estimated downtime hours for planned maintenance"
    - name: "total_estimated_labor_hours"
      expr: SUM(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Total estimated labor hours for all maintenance plans"
    - name: "avg_estimated_cost_per_plan"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per maintenance plan"
    - name: "avg_estimated_downtime_per_plan"
      expr: AVG(CAST(estimated_downtime_hours AS DOUBLE))
      comment: "Average estimated downtime per maintenance plan"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days for maintenance plan execution"
    - name: "avg_days_since_last_completion"
      expr: AVG(DATEDIFF(CURRENT_DATE(), last_completed_date))
      comment: "Average days since last maintenance completion, indicating schedule adherence"
    - name: "overdue_plans_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN next_due_date < CURRENT_DATE() AND plan_status = 'Active' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN plan_status = 'Active' THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of active maintenance plans that are overdue"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`asset_spare_part`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spare parts inventory and cost metrics tracking stock levels, turnover, obsolescence, and carrying costs"
  source: "`shipping_ports_ecm`.`asset`.`spare_part`"
  dimensions:
    - name: "part_category"
      expr: part_category
      comment: "Category of spare part"
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification for inventory management (A=high value, B=medium, C=low)"
    - name: "criticality_classification"
      expr: criticality_classification
      comment: "Criticality level of the spare part to operations"
    - name: "spare_part_status"
      expr: spare_part_status
      comment: "Current status of the spare part"
    - name: "obsolescence_status"
      expr: obsolescence_status
      comment: "Obsolescence status of the spare part"
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Whether spare part is classified as hazardous material"
    - name: "warehouse_code"
      expr: warehouse_code
      comment: "Warehouse location code where part is stored"
    - name: "storage_location"
      expr: storage_location
      comment: "Specific storage location within warehouse"
  measures:
    - name: "total_spare_parts"
      expr: COUNT(1)
      comment: "Total number of unique spare part SKUs"
    - name: "total_stock_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Total value of spare parts inventory on hand"
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity of spare parts in stock"
    - name: "total_quantity_on_order"
      expr: SUM(CAST(quantity_on_order AS DOUBLE))
      comment: "Total quantity of spare parts on order"
    - name: "total_quantity_reserved"
      expr: SUM(CAST(quantity_reserved AS DOUBLE))
      comment: "Total quantity of spare parts reserved for planned work"
    - name: "total_annual_usage_quantity"
      expr: SUM(CAST(annual_usage_quantity AS DOUBLE))
      comment: "Total annual usage quantity across all spare parts"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per spare part"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days for spare part procurement"
    - name: "inventory_turnover_ratio"
      expr: ROUND(SUM(CAST(annual_usage_quantity AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Inventory turnover ratio indicating how many times inventory is used per year"
    - name: "stockout_risk_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN quantity_on_hand < reorder_point THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of spare parts below reorder point, indicating stockout risk"
    - name: "excess_stock_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN quantity_on_hand > (reorder_point + reorder_quantity) THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of spare parts with excess stock above optimal levels"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`asset_inspection_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset inspection compliance and quality metrics tracking inspection outcomes, defect rates, and regulatory compliance"
  source: "`shipping_ports_ecm`.`asset`.`inspection_record`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed (statutory, internal, third-party)"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection record"
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Outcome of the inspection (pass, fail, conditional)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status determined by inspection"
    - name: "defect_severity_highest"
      expr: defect_severity_highest
      comment: "Highest severity level of defects found"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month when inspection was performed"
    - name: "inspector_authority"
      expr: inspector_authority
      comment: "Authority or organization conducting the inspection"
    - name: "load_test_performed"
      expr: load_test_performed
      comment: "Whether load testing was performed during inspection"
    - name: "regulatory_reference"
      expr: regulatory_reference
      comment: "Regulatory standard or reference for the inspection"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of asset inspections performed"
    - name: "total_inspection_cost"
      expr: SUM(CAST(inspection_cost AS DOUBLE))
      comment: "Total cost of all inspections"
    - name: "total_defects_identified"
      expr: SUM(CAST(defects_identified_count AS DOUBLE))
      comment: "Total number of defects identified across all inspections"
    - name: "total_critical_defects"
      expr: SUM(CAST(critical_defects_count AS DOUBLE))
      comment: "Total number of critical defects identified"
    - name: "total_major_defects"
      expr: SUM(CAST(major_defects_count AS DOUBLE))
      comment: "Total number of major defects identified"
    - name: "total_minor_defects"
      expr: SUM(CAST(minor_defects_count AS DOUBLE))
      comment: "Total number of minor defects identified"
    - name: "avg_defects_per_inspection"
      expr: AVG(CAST(defects_identified_count AS DOUBLE))
      comment: "Average number of defects found per inspection"
    - name: "avg_inspection_cost"
      expr: AVG(CAST(inspection_cost AS DOUBLE))
      comment: "Average cost per inspection"
    - name: "inspection_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN inspection_outcome = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections that passed without defects"
    - name: "critical_defect_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN CAST(critical_defects_count AS DOUBLE) > 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections that identified critical defects"
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections resulting in compliant status"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`asset_depreciation_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset depreciation and financial performance metrics tracking book value erosion, impairment, and revaluation"
  source: "`shipping_ports_ecm`.`asset`.`depreciation_schedule`"
  dimensions:
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Method used to calculate depreciation"
    - name: "depreciation_status"
      expr: depreciation_status
      comment: "Current status of depreciation schedule"
    - name: "depreciation_area"
      expr: depreciation_area
      comment: "Depreciation area or business unit"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the depreciation schedule"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period within the year"
    - name: "impairment_indicator"
      expr: impairment_indicator
      comment: "Whether asset shows indicators of impairment"
    - name: "valuation_type"
      expr: valuation_type
      comment: "Type of asset valuation performed"
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account code for depreciation"
  measures:
    - name: "total_depreciation_schedules"
      expr: COUNT(1)
      comment: "Total number of depreciation schedule records"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total original acquisition cost of all assets"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across all assets"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of all assets"
    - name: "total_annual_depreciation"
      expr: SUM(CAST(annual_depreciation_amount AS DOUBLE))
      comment: "Total annual depreciation expense"
    - name: "total_period_depreciation"
      expr: SUM(CAST(period_depreciation_amount AS DOUBLE))
      comment: "Total depreciation expense for the current period"
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss AS DOUBLE))
      comment: "Total impairment losses recognized"
    - name: "total_revaluation_surplus"
      expr: SUM(CAST(revaluation_surplus AS DOUBLE))
      comment: "Total revaluation surplus from asset revaluations"
    - name: "total_residual_value"
      expr: SUM(CAST(residual_value AS DOUBLE))
      comment: "Total estimated residual value at end of useful life"
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life in years across all assets"
    - name: "avg_depreciation_percentage"
      expr: AVG(CAST(depreciation_percentage AS DOUBLE))
      comment: "Average depreciation rate as percentage"
    - name: "portfolio_depreciation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(accumulated_depreciation AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Portfolio-wide accumulated depreciation as percentage of acquisition cost"
    - name: "impairment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN impairment_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assets showing impairment indicators"
$$;