-- Metric views for domain: equipment | Business: Construction | Version: 1 | Generated on: 2026-05-07 09:21:54

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`equipment_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the equipment asset register — tracks fleet composition, financial value, lifecycle health, and compliance posture across the owned and leased asset base."
  source: "`construction_ecm`.`equipment`.`asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Operational status of the asset (e.g. Active, Idle, Disposed, Under Maintenance) — primary filter for fleet availability analysis."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Stage in the asset lifecycle (e.g. Acquisition, In-Service, End-of-Life) — used to track fleet renewal and retirement planning."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Whether the asset is owned, leased, or rented — drives make-vs-buy and capital allocation decisions."
    - name: "classification"
      expr: classification
      comment: "Asset classification grouping (e.g. Heavy Plant, Light Vehicle, Crane) — supports fleet segmentation and benchmarking."
    - name: "emissions_tier"
      expr: emissions_tier
      comment: "Emissions compliance tier of the asset — used for environmental reporting and regulatory compliance tracking."
    - name: "regulatory_compliance_class"
      expr: regulatory_compliance_class
      comment: "Regulatory compliance classification — supports compliance risk monitoring and audit readiness."
    - name: "make"
      expr: make
      comment: "Manufacturer of the asset — used for fleet standardisation and vendor performance analysis."
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year the asset was acquired — supports fleet age analysis and capital expenditure trending."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method used to dispose of the asset (e.g. Sale, Scrap, Trade-In) — informs disposal strategy and residual value recovery."
  measures:
    - name: "total_fleet_count"
      expr: COUNT(1)
      comment: "Total number of assets in the fleet register — baseline measure for fleet size tracking and capacity planning."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total capital invested in acquiring fleet assets — key input for capital expenditure reporting and ROI analysis."
    - name: "total_current_book_value"
      expr: SUM(CAST(current_book_value AS DOUBLE))
      comment: "Aggregate current book value of all assets — reflects net asset value on the balance sheet and informs depreciation tracking."
    - name: "avg_current_book_value"
      expr: AVG(CAST(current_book_value AS DOUBLE))
      comment: "Average book value per asset — used to benchmark asset value across fleet segments and identify over/under-valued equipment."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds recovered from asset disposals — measures residual value realisation and informs future disposal strategy."
    - name: "avg_total_operating_hours"
      expr: AVG(CAST(total_operating_hours AS DOUBLE))
      comment: "Average cumulative operating hours per asset — indicates fleet utilisation intensity and remaining useful life."
    - name: "total_operating_hours_fleet"
      expr: SUM(CAST(total_operating_hours AS DOUBLE))
      comment: "Total operating hours accumulated across the entire fleet — used for fleet-wide productivity and maintenance scheduling."
    - name: "book_value_to_acquisition_cost_ratio"
      expr: ROUND(100.0 * SUM(CAST(current_book_value AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Percentage of original acquisition cost retained as current book value — measures fleet depreciation rate and informs asset refresh decisions."
    - name: "disposal_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(disposal_proceeds AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Disposal proceeds as a percentage of original acquisition cost — measures residual value recovery efficiency across disposal events."
    - name: "assets_with_overdue_inspection_count"
      expr: COUNT(CASE WHEN next_inspection_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of assets whose next inspection due date has passed — critical compliance and safety risk indicator for fleet management."
    - name: "assets_with_overdue_maintenance_count"
      expr: COUNT(CASE WHEN next_scheduled_maintenance_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of assets with overdue scheduled maintenance — operational risk KPI that drives maintenance prioritisation and downtime prevention."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`equipment_fleet_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for equipment fleet assignments — measures utilisation efficiency, idle time, cost performance, and assignment throughput across projects and cost centres."
  source: "`construction_ecm`.`equipment`.`fleet_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the fleet assignment (e.g. Active, Completed, Cancelled) — primary filter for active fleet deployment analysis."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (e.g. Owned, Rented, Subcontracted) — supports cost structure and make-vs-buy analysis."
    - name: "assignment_priority"
      expr: assignment_priority
      comment: "Priority level of the assignment — used to assess resource allocation against critical project activities."
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Mobilisation status of the assigned equipment — tracks readiness and deployment progress."
    - name: "assignment_start_month"
      expr: DATE_TRUNC('MONTH', assignment_start_date)
      comment: "Month the assignment started — enables trending of fleet deployment activity over time."
    - name: "rate_currency_code"
      expr: rate_currency_code
      comment: "Currency in which rates are denominated — supports multi-currency fleet cost analysis."
    - name: "assignment_purpose"
      expr: assignment_purpose
      comment: "Business purpose of the assignment (e.g. Earthworks, Concrete Pour) — links equipment deployment to project activities."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of fleet assignments — baseline measure for fleet deployment volume and scheduling throughput."
    - name: "total_actual_utilization_hours"
      expr: SUM(CAST(actual_utilization_hours AS DOUBLE))
      comment: "Total actual hours equipment was productively utilised across all assignments — core fleet productivity KPI."
    - name: "total_planned_utilization_hours"
      expr: SUM(CAST(planned_utilization_hours AS DOUBLE))
      comment: "Total planned utilisation hours across all assignments — baseline for measuring utilisation performance against plan."
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total idle hours across all fleet assignments — measures unproductive equipment time and drives cost reduction initiatives."
    - name: "utilization_achievement_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_utilization_hours AS DOUBLE)) / NULLIF(SUM(CAST(planned_utilization_hours AS DOUBLE)), 0), 2)
      comment: "Actual utilisation hours as a percentage of planned — measures fleet scheduling effectiveness and identifies under-utilised assets."
    - name: "idle_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(idle_hours AS DOUBLE)) / NULLIF(SUM(CAST(actual_utilization_hours AS DOUBLE) + CAST(idle_hours AS DOUBLE)), 0), 2)
      comment: "Idle hours as a percentage of total available hours (actual + idle) — key efficiency KPI; high idle rates signal over-allocation or scheduling inefficiency."
    - name: "total_mobilization_cost"
      expr: SUM(CAST(mobilization_cost AS DOUBLE))
      comment: "Total cost incurred to mobilise equipment to project sites — input for project cost control and logistics optimisation."
    - name: "total_demobilization_cost"
      expr: SUM(CAST(demobilization_cost AS DOUBLE))
      comment: "Total cost incurred to demobilise equipment from project sites — supports end-of-assignment cost tracking."
    - name: "avg_daily_rate"
      expr: AVG(CAST(daily_rate AS DOUBLE))
      comment: "Average daily hire rate across fleet assignments — benchmarks rental cost efficiency and supports rate negotiation."
    - name: "avg_operating_rate_per_hour"
      expr: AVG(CAST(operating_rate_per_hour AS DOUBLE))
      comment: "Average operating cost rate per hour — used to benchmark equipment operating costs and inform budgeting."
    - name: "total_assignment_cost_estimate"
      expr: SUM(CAST(actual_utilization_hours AS DOUBLE) * CAST(operating_rate_per_hour AS DOUBLE))
      comment: "Estimated total operating cost derived from actual hours multiplied by operating rate — approximates assignment-level cost for project cost control."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`equipment_hours`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift-level equipment hours KPIs — measures productive utilisation, downtime, availability, fuel consumption, and cost efficiency at the daily shift grain for operational performance management."
  source: "`construction_ecm`.`equipment`.`hours`"
  dimensions:
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the shift — primary time dimension for daily operational performance trending."
    - name: "shift_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Month of the shift — supports monthly utilisation and downtime trend analysis."
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (e.g. Day, Night, Extended) — used to analyse productivity and downtime patterns by shift."
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of downtime event (e.g. Mechanical, Operator, Weather) — drives root cause analysis and maintenance prioritisation."
    - name: "downtime_root_cause_code"
      expr: downtime_root_cause_code
      comment: "Root cause code for downtime — enables structured failure analysis and recurring issue identification."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type of the equipment (Owned/Rented) — supports cost comparison between owned and rented fleet."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions during the shift — used to correlate weather impact on equipment productivity and downtime."
    - name: "is_billable"
      expr: is_billable
      comment: "Whether the equipment hours are billable to the client — supports revenue recognition and billing accuracy analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the hours record — used to filter confirmed vs. pending records in financial reporting."
  measures:
    - name: "total_operating_hours"
      expr: SUM(CAST(operating_hours AS DOUBLE))
      comment: "Total productive operating hours logged across all shifts — primary fleet productivity KPI used in project performance reviews."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total equipment downtime hours — critical operational KPI; high downtime directly impacts project schedule and cost."
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total idle hours where equipment was available but not operating — measures scheduling inefficiency and over-allocation."
    - name: "total_standby_hours"
      expr: SUM(CAST(standby_hours AS DOUBLE))
      comment: "Total standby hours where equipment was on-site but not deployed — informs fleet right-sizing and cost reduction."
    - name: "avg_equipment_utilization_rate"
      expr: AVG(CAST(equipment_utilization_rate AS DOUBLE))
      comment: "Average equipment utilisation rate across shifts — strategic KPI for fleet efficiency; benchmarked against industry standards and category targets."
    - name: "avg_equipment_availability_rate"
      expr: AVG(CAST(equipment_availability_rate AS DOUBLE))
      comment: "Average equipment availability rate — measures the proportion of time equipment is mechanically ready to operate; key maintenance performance indicator."
    - name: "total_fuel_consumption_liters"
      expr: SUM(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Total fuel consumed across all equipment shifts — drives fuel cost management, carbon emission tracking, and sustainability reporting."
    - name: "avg_fuel_consumption_per_operating_hour"
      expr: ROUND(SUM(CAST(fuel_consumption_liters AS DOUBLE)) / NULLIF(SUM(CAST(operating_hours AS DOUBLE)), 0), 3)
      comment: "Average fuel consumed per operating hour — efficiency ratio used to identify fuel-inefficient assets and benchmark against manufacturer specifications."
    - name: "total_equipment_cost"
      expr: SUM(CAST(total_equipment_cost AS DOUBLE))
      comment: "Total equipment cost across all shifts — key project cost control input for equipment cost-to-complete forecasting."
    - name: "avg_cost_per_operating_hour"
      expr: ROUND(SUM(CAST(total_equipment_cost AS DOUBLE)) / NULLIF(SUM(CAST(operating_hours AS DOUBLE)), 0), 2)
      comment: "Average equipment cost per productive operating hour — efficiency KPI used to benchmark cost performance and identify high-cost assets."
    - name: "downtime_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(downtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(operating_hours AS DOUBLE) + CAST(downtime_hours AS DOUBLE) + CAST(standby_hours AS DOUBLE)), 0), 2)
      comment: "Downtime as a percentage of total available hours — headline fleet reliability KPI; directly linked to project schedule risk and cost overrun."
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total production output quantity recorded against equipment shifts — links equipment deployment to physical project progress (e.g. m³ excavated, tonnes hauled)."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`equipment_fuel_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fuel consumption and cost KPIs at the transaction level — tracks fuel spend, carbon emissions, unit cost efficiency, and anomaly indicators across the fleet."
  source: "`construction_ecm`.`equipment`.`fuel_transaction`"
  dimensions:
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', CAST(transaction_timestamp AS DATE))
      comment: "Month of the fuel transaction — enables monthly fuel cost and consumption trending."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the fuel transaction — used to filter approved vs. pending transactions in financial reporting."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Processing status of the transaction — supports reconciliation and exception management workflows."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for fuel quantity (e.g. Litres, Gallons) — required for normalised consumption analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the fuel transaction — supports multi-currency cost consolidation."
    - name: "is_emergency_refuel"
      expr: is_emergency_refuel
      comment: "Flag indicating whether the refuel was an emergency — emergency refuels often carry premium costs and indicate operational disruption."
    - name: "is_theft_suspected"
      expr: is_theft_suspected
      comment: "Flag indicating suspected fuel theft — critical fraud and loss control indicator for fleet management."
  measures:
    - name: "total_fuel_quantity_issued"
      expr: SUM(CAST(quantity_issued AS DOUBLE))
      comment: "Total fuel quantity issued across all transactions — primary consumption volume KPI for fleet fuel management."
    - name: "total_fuel_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total fuel expenditure — major equipment operating cost component; tracked against project budgets and benchmarks."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average fuel unit cost per transaction — benchmarks procurement efficiency and identifies price anomalies across suppliers and sites."
    - name: "total_carbon_emission_kg"
      expr: SUM(CAST(carbon_emission_kg AS DOUBLE))
      comment: "Total carbon emissions in kilograms from fuel consumption — mandatory sustainability KPI for ESG reporting and emissions reduction targets."
    - name: "avg_carbon_emission_per_liter"
      expr: ROUND(SUM(CAST(carbon_emission_kg AS DOUBLE)) / NULLIF(SUM(CAST(quantity_issued AS DOUBLE)), 0), 4)
      comment: "Average carbon emission per litre of fuel — efficiency ratio used to compare emissions intensity across fuel types and asset categories."
    - name: "suspected_theft_transaction_count"
      expr: COUNT(CASE WHEN is_theft_suspected = TRUE THEN 1 END)
      comment: "Number of transactions flagged as suspected fuel theft — loss control KPI; elevated counts trigger investigation and tightened fuel management controls."
    - name: "emergency_refuel_count"
      expr: COUNT(CASE WHEN is_emergency_refuel = TRUE THEN 1 END)
      comment: "Number of emergency refuel events — operational risk indicator; high frequency signals poor fuel planning or asset reliability issues."
    - name: "emergency_refuel_cost"
      expr: SUM(CASE WHEN is_emergency_refuel = TRUE THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost of emergency refuel transactions — quantifies the financial premium of unplanned refuelling events."
    - name: "avg_tank_capacity_utilization_pct"
      expr: AVG(CAST(tank_capacity_percentage AS DOUBLE))
      comment: "Average tank capacity percentage at time of refuel — low averages indicate efficient top-up scheduling; very low values may signal theft or leakage."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`equipment_maintenance_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance execution KPIs — tracks maintenance cost, downtime, labour efficiency, warranty recovery, and compliance across all work orders to drive asset reliability and cost control."
  source: "`construction_ecm`.`equipment`.`maintenance_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of maintenance order (e.g. Preventive, Corrective, Emergency) — primary dimension for maintenance strategy analysis."
    - name: "order_status"
      expr: order_status
      comment: "Current status of the maintenance order (e.g. Open, In Progress, Closed) — used to track work order backlog and completion rates."
    - name: "priority"
      expr: priority
      comment: "Priority level of the maintenance order — used to assess whether high-priority maintenance is being executed on time."
    - name: "failure_code"
      expr: failure_code
      comment: "Standardised failure code — enables Pareto analysis of failure modes to drive reliability improvement programmes."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month the maintenance was planned to start — supports maintenance volume trending and resource planning."
    - name: "compliance_inspection_flag"
      expr: compliance_inspection_flag
      comment: "Whether the order is linked to a regulatory compliance inspection — used to track compliance-driven maintenance separately from operational maintenance."
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Whether a warranty claim was raised against this order — tracks warranty recovery opportunities and vendor accountability."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of maintenance cost amounts — supports multi-currency cost consolidation."
  measures:
    - name: "total_maintenance_orders"
      expr: COUNT(1)
      comment: "Total number of maintenance orders — baseline measure for maintenance workload volume and backlog management."
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_maintenance_cost AS DOUBLE))
      comment: "Total cost of all maintenance activities — primary maintenance cost KPI for budget control and cost-to-maintain benchmarking."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labour cost across maintenance orders — used to analyse labour as a proportion of total maintenance spend."
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total parts and materials cost across maintenance orders — tracks consumable spend and supports parts inventory optimisation."
    - name: "total_external_services_cost"
      expr: SUM(CAST(external_services_cost AS DOUBLE))
      comment: "Total cost of external contractor services for maintenance — measures outsourced maintenance spend and informs insource-vs-outsource decisions."
    - name: "total_maintenance_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total equipment downtime hours caused by maintenance activities — directly linked to project schedule impact and lost productivity cost."
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labour hours expended on maintenance — used for workforce planning and maintenance productivity benchmarking."
    - name: "avg_cost_per_maintenance_order"
      expr: ROUND(SUM(CAST(total_maintenance_cost AS DOUBLE)) / NULLIF(COUNT(1), 0), 2)
      comment: "Average cost per maintenance order — benchmarks maintenance efficiency and identifies cost outliers by order type or asset category."
    - name: "labor_cost_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(labor_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_maintenance_cost AS DOUBLE)), 0), 2)
      comment: "Labour cost as a percentage of total maintenance cost — used to assess labour intensity and identify automation or efficiency opportunities."
    - name: "warranty_claim_count"
      expr: COUNT(CASE WHEN warranty_claim_flag = TRUE THEN 1 END)
      comment: "Number of maintenance orders with warranty claims raised — measures warranty recovery activity and vendor accountability."
    - name: "avg_downtime_hours_per_order"
      expr: ROUND(SUM(CAST(downtime_hours AS DOUBLE)) / NULLIF(COUNT(1), 0), 2)
      comment: "Average downtime hours per maintenance order — measures maintenance execution efficiency and impact on equipment availability."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`equipment_inspection_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment inspection compliance and quality KPIs — tracks inspection outcomes, defect rates, certificate currency, and corrective action status to manage regulatory compliance and asset safety."
  source: "`construction_ecm`.`equipment`.`inspection_record`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (e.g. Pre-Start, Periodic, Regulatory, Post-Repair) — primary dimension for inspection programme analysis."
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Result of the inspection (e.g. Pass, Fail, Conditional Pass) — key quality and compliance indicator."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection record (e.g. Completed, Pending, Overdue) — used to track inspection programme execution."
    - name: "certificate_type"
      expr: certificate_type
      comment: "Type of certificate issued following inspection — supports certificate management and regulatory compliance tracking."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month the inspection was conducted — enables trending of inspection activity and compliance rates over time."
    - name: "certificate_issued_flag"
      expr: certificate_issued_flag
      comment: "Whether a compliance certificate was issued — used to track certification coverage across the fleet."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspection records — baseline measure for inspection programme volume and coverage."
    - name: "inspection_pass_count"
      expr: COUNT(CASE WHEN inspection_outcome = 'Pass' THEN 1 END)
      comment: "Number of inspections with a passing outcome — used to calculate fleet compliance pass rate."
    - name: "inspection_fail_count"
      expr: COUNT(CASE WHEN inspection_outcome = 'Fail' THEN 1 END)
      comment: "Number of failed inspections — critical safety and compliance KPI; failures trigger corrective action and potential equipment stand-down."
    - name: "inspection_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_outcome = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections that passed — headline fleet compliance KPI reported to HSE leadership and regulatory bodies."
    - name: "total_inspection_cost"
      expr: SUM(CAST(inspection_cost AS DOUBLE))
      comment: "Total cost of equipment inspections — tracks inspection programme expenditure against budget and benchmarks cost per inspection."
    - name: "avg_inspection_cost"
      expr: AVG(CAST(inspection_cost AS DOUBLE))
      comment: "Average cost per inspection — used to benchmark inspection efficiency and identify cost outliers by inspection type."
    - name: "certificates_expiring_within_30_days"
      expr: COUNT(CASE WHEN certificate_expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 30) THEN 1 END)
      comment: "Number of inspection certificates expiring within the next 30 days — proactive compliance risk KPI that triggers renewal actions."
    - name: "overdue_corrective_actions_count"
      expr: COUNT(CASE WHEN corrective_action_due_date < CURRENT_DATE() AND inspection_outcome = 'Fail' THEN 1 END)
      comment: "Number of failed inspections with overdue corrective actions — critical safety risk indicator; unresolved corrective actions expose the organisation to regulatory liability."
    - name: "avg_equipment_hours_at_inspection"
      expr: AVG(CAST(equipment_hours_at_inspection AS DOUBLE))
      comment: "Average equipment operating hours at time of inspection — used to validate that inspections are being conducted at the correct hour-based intervals."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`equipment_rental_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment rental cost and commitment KPIs — tracks rental spend, rate benchmarking, hire period efficiency, and financial exposure across all rental agreements to optimise the rented fleet strategy."
  source: "`construction_ecm`.`equipment`.`rental_agreement`"
  dimensions:
    - name: "rental_status"
      expr: rental_status
      comment: "Current status of the rental agreement (e.g. Active, Expired, Cancelled) — primary filter for active rental cost exposure analysis."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment being rented — supports rental cost analysis by equipment category and make-vs-rent decisions."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency of rental billing (e.g. Daily, Weekly, Monthly) — used to normalise rental costs for comparison across agreements."
    - name: "maintenance_responsibility"
      expr: maintenance_responsibility
      comment: "Party responsible for maintenance under the rental agreement (Owner/Renter) — impacts total cost of ownership calculation."
    - name: "operator_supplied_flag"
      expr: operator_supplied_flag
      comment: "Whether the operator is supplied by the rental vendor — affects all-in cost comparison and workforce planning."
    - name: "fuel_included_flag"
      expr: fuel_included_flag
      comment: "Whether fuel is included in the rental rate — required for accurate total cost of rental comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rental agreement — supports multi-currency rental cost consolidation."
    - name: "rental_start_month"
      expr: DATE_TRUNC('MONTH', rental_start_date)
      comment: "Month the rental commenced — enables trending of rental fleet intake and cost commitment over time."
  measures:
    - name: "total_rental_agreements"
      expr: COUNT(1)
      comment: "Total number of rental agreements — baseline measure for rented fleet size and vendor engagement volume."
    - name: "total_committed_rental_cost"
      expr: SUM(CAST(total_committed_cost AS DOUBLE))
      comment: "Total financial commitment across all rental agreements — primary rental cost exposure KPI for cash flow forecasting and budget management."
    - name: "avg_daily_hire_rate"
      expr: AVG(CAST(daily_hire_rate AS DOUBLE))
      comment: "Average daily hire rate across rental agreements — benchmarks rental rate competitiveness and supports vendor negotiation."
    - name: "avg_weekly_hire_rate"
      expr: AVG(CAST(weekly_hire_rate AS DOUBLE))
      comment: "Average weekly hire rate — used to compare weekly vs. daily rate efficiency and optimise billing frequency selection."
    - name: "total_mobilization_charge"
      expr: SUM(CAST(mobilization_charge AS DOUBLE))
      comment: "Total mobilisation charges across rental agreements — tracks logistics cost component of rental spend."
    - name: "total_demobilization_charge"
      expr: SUM(CAST(demobilization_charge AS DOUBLE))
      comment: "Total demobilisation charges — tracks end-of-rental logistics costs and informs total cost of rental calculation."
    - name: "total_damage_waiver_amount"
      expr: SUM(CAST(damage_waiver_amount AS DOUBLE))
      comment: "Total damage waiver amounts across rental agreements — quantifies risk transfer cost and informs insurance vs. waiver strategy."
    - name: "total_security_deposit"
      expr: SUM(CAST(security_deposit_amount AS DOUBLE))
      comment: "Total security deposits held across active rental agreements — tracks working capital tied up in rental security deposits."
    - name: "avg_hire_period_days"
      expr: ROUND(AVG(CAST(DATEDIFF(rental_end_date, rental_start_date) AS DOUBLE)), 1)
      comment: "Average hire period in days — measures rental duration efficiency; very short periods may indicate poor planning, very long periods may signal over-commitment."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`equipment_mobilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment mobilisation logistics KPIs — tracks transport cost, transit time performance, condition quality, and mobilisation throughput to optimise fleet deployment logistics."
  source: "`construction_ecm`.`equipment`.`equipment_mobilization`"
  dimensions:
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Current status of the mobilisation event (e.g. Planned, In Transit, Completed) — primary filter for active logistics tracking."
    - name: "event_type"
      expr: event_type
      comment: "Type of mobilisation event (e.g. Mobilise, Demobilise, Transfer) — used to analyse inbound vs. outbound fleet movements."
    - name: "transport_method"
      expr: transport_method
      comment: "Method of transport used (e.g. Low Loader, Self-Drive, Rail) — supports transport cost and efficiency analysis by mode."
    - name: "dispatch_condition"
      expr: dispatch_condition
      comment: "Condition of equipment at dispatch — used to track condition deterioration during transit."
    - name: "receipt_condition"
      expr: receipt_condition
      comment: "Condition of equipment upon receipt at destination — compared against dispatch condition to identify transit damage."
    - name: "planned_dispatch_month"
      expr: DATE_TRUNC('MONTH', planned_dispatch_date)
      comment: "Month of planned dispatch — enables trending of mobilisation activity and logistics planning."
    - name: "transport_currency_code"
      expr: transport_currency_code
      comment: "Currency of transport cost — supports multi-currency logistics cost consolidation."
  measures:
    - name: "total_mobilizations"
      expr: COUNT(1)
      comment: "Total number of mobilisation events — baseline measure for fleet movement volume and logistics throughput."
    - name: "total_transport_cost"
      expr: SUM(CAST(transport_cost AS DOUBLE))
      comment: "Total transport cost across all mobilisation events — major logistics cost KPI; tracked against project budgets and benchmarked by transport method."
    - name: "avg_transport_cost_per_km"
      expr: ROUND(SUM(CAST(transport_cost AS DOUBLE)) / NULLIF(SUM(CAST(distance_km AS DOUBLE)), 0), 2)
      comment: "Average transport cost per kilometre — efficiency ratio for benchmarking logistics cost across transport methods and vendors."
    - name: "total_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Total distance covered by equipment mobilisations — used for logistics planning, carbon footprint estimation, and transport cost modelling."
    - name: "avg_actual_transit_hours"
      expr: AVG(CAST(actual_transit_hours AS DOUBLE))
      comment: "Average actual transit time in hours — benchmarks logistics execution speed and identifies route or transport method inefficiencies."
    - name: "transit_time_variance_hours"
      expr: ROUND(AVG(CAST(actual_transit_hours AS DOUBLE) - CAST(estimated_transit_hours AS DOUBLE)), 2)
      comment: "Average variance between actual and estimated transit hours — measures logistics planning accuracy; positive values indicate delays impacting project schedules."
    - name: "on_time_arrival_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_arrival_date <= planned_arrival_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_arrival_date IS NOT NULL AND planned_arrival_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of mobilisations where equipment arrived on or before the planned arrival date — schedule adherence KPI for logistics performance management."
    - name: "permit_required_mobilization_count"
      expr: COUNT(CASE WHEN permit_required_flag = TRUE THEN 1 END)
      comment: "Number of mobilisations requiring permits — used to plan permit procurement lead times and avoid compliance-related delays."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`equipment_operator_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operator certification compliance KPIs — tracks certification currency, expiry risk, assessment performance, and training investment to ensure a legally compliant and competent equipment operator workforce."
  source: "`construction_ecm`.`equipment`.`operator_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (e.g. Active, Expired, Suspended) — primary filter for workforce compliance analysis."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g. Crane Operator, Forklift, Explosive Handler) — used to analyse compliance coverage by equipment category."
    - name: "certification_level"
      expr: certification_level
      comment: "Level of certification achieved — supports workforce capability assessment and career development tracking."
    - name: "certifying_body"
      expr: certifying_body
      comment: "Organisation that issued the certification — used to track accreditation sources and ensure certifications are from approved bodies."
    - name: "issuing_country_code"
      expr: issuing_country_code
      comment: "Country where the certification was issued — supports multi-jurisdiction compliance management."
    - name: "verification_status"
      expr: verification_status
      comment: "Status of certification verification (e.g. Verified, Pending, Failed) — ensures certifications have been independently validated."
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the certification was issued — supports cohort analysis of certification vintage and renewal cycle planning."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of operator certifications on record — baseline measure for workforce certification coverage."
    - name: "active_certifications_count"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN 1 END)
      comment: "Number of currently active certifications — measures the size of the compliant, deployable operator workforce."
    - name: "expired_certifications_count"
      expr: COUNT(CASE WHEN certification_status = 'Expired' THEN 1 END)
      comment: "Number of expired certifications — critical compliance risk KPI; expired certifications mean operators cannot legally operate equipment."
    - name: "certifications_expiring_within_30_days"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 30) THEN 1 END)
      comment: "Number of certifications expiring within 30 days — proactive workforce compliance risk indicator that triggers renewal scheduling."
    - name: "certification_active_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications that are currently active — headline workforce compliance KPI reported to HSE and project leadership."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total investment in operator certifications — tracks training and compliance expenditure for workforce development budgeting."
    - name: "avg_theory_assessment_score"
      expr: AVG(CAST(theory_assessment_score AS DOUBLE))
      comment: "Average theory assessment score across certifications — measures workforce knowledge quality and identifies training programme effectiveness."
    - name: "avg_practical_assessment_score"
      expr: AVG(CAST(practical_assessment_score AS DOUBLE))
      comment: "Average practical assessment score — measures hands-on competency of the operator workforce; low scores indicate training gaps."
    - name: "total_training_hours_completed"
      expr: SUM(CAST(training_hours_completed AS DOUBLE))
      comment: "Total training hours completed across all certifications — measures workforce development investment and supports regulatory training hour requirements."
    - name: "unverified_certifications_count"
      expr: COUNT(CASE WHEN verification_status != 'Verified' THEN 1 END)
      comment: "Number of certifications not yet independently verified — compliance risk indicator; unverified certifications may not be accepted by regulators or clients."
$$;