-- Metric views for domain: equipment | Business: Construction | Version: 2 | Generated on: 2026-06-22 17:18:52

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the equipment asset master. Tracks fleet composition, financial value, lifecycle health, and disposal performance to support capital planning, asset replacement decisions, and fleet optimisation."
  source: "`vibe_construction_v1`.`equipment`.`asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Current operational status of the asset (e.g. Active, Idle, Disposed, Under Maintenance). Primary filter for fleet availability analysis."
    - name: "asset_category_id"
      expr: asset_category_id
      comment: "Foreign key to asset category. Enables grouping of KPIs by equipment category (e.g. Cranes, Excavators, Vehicles)."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Stage in the asset lifecycle (e.g. New, In-Service, End-of-Life). Used to segment fleet health and replacement planning."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Indicates whether the asset is Owned, Leased, or Rented. Critical for cost structure and capital allocation decisions."
    - name: "classification"
      expr: classification
      comment: "Equipment classification code used for regulatory and operational grouping."
    - name: "emissions_tier"
      expr: emissions_tier
      comment: "Emissions compliance tier of the asset. Supports environmental reporting and fleet decarbonisation tracking."
    - name: "make"
      expr: make
      comment: "Manufacturer of the asset. Used for vendor performance and fleet standardisation analysis."
    - name: "acquisition_date"
      expr: DATE_TRUNC('year', acquisition_date)
      comment: "Year of asset acquisition. Enables cohort analysis of fleet age and capital expenditure trends."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method used to dispose of the asset (e.g. Sale, Scrap, Trade-in). Used in disposal performance and proceeds analysis."
    - name: "asset_construction_project_id"
      expr: asset_construction_project_id
      comment: "Project the asset is primarily associated with. Enables project-level fleet cost and value tracking."
  measures:
    - name: "total_fleet_count"
      expr: COUNT(1)
      comment: "Total number of assets in the fleet. Baseline measure for fleet size tracking and capacity planning."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total capital invested in acquiring the fleet. Drives capital expenditure reporting and investment decisions."
    - name: "total_current_book_value"
      expr: SUM(CAST(current_book_value AS DOUBLE))
      comment: "Aggregate net book value of all assets. Used for balance sheet reporting and asset impairment assessments."
    - name: "avg_current_book_value"
      expr: AVG(CAST(current_book_value AS DOUBLE))
      comment: "Average net book value per asset. Indicates average remaining economic value across the fleet."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds received from asset disposals. Measures the effectiveness of the disposal programme and residual value recovery."
    - name: "avg_disposal_proceeds"
      expr: AVG(CAST(disposal_proceeds AS DOUBLE))
      comment: "Average proceeds per disposed asset. Benchmarks disposal efficiency and residual value realisation."
    - name: "total_operating_hours"
      expr: SUM(CAST(total_operating_hours AS DOUBLE))
      comment: "Cumulative operating hours across the fleet. Key indicator of fleet utilisation intensity and maintenance trigger planning."
    - name: "avg_operating_hours_per_asset"
      expr: AVG(CAST(total_operating_hours AS DOUBLE))
      comment: "Average lifetime operating hours per asset. Used to benchmark asset utilisation and identify under-used or over-worked equipment."
    - name: "avg_operating_weight_kg"
      expr: AVG(CAST(operating_weight_kg AS DOUBLE))
      comment: "Average operating weight of assets in the fleet. Supports logistics, site access, and load planning decisions."
    - name: "distinct_active_assets"
      expr: COUNT(DISTINCT CASE WHEN asset_status = 'Active' THEN asset_id END)
      comment: "Count of distinct assets currently in Active status. Measures the productive fleet size available for deployment."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_fleet_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPI layer over fleet assignment events. Tracks equipment deployment efficiency, utilisation versus plan, mobilisation costs, and idle time to support project scheduling and cost control decisions."
  source: "`vibe_construction_v1`.`equipment`.`fleet_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the fleet assignment (e.g. Active, Completed, Cancelled). Primary filter for deployment pipeline analysis."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (e.g. Owned, Rented, Standby). Drives cost rate selection and utilisation benchmarking."
    - name: "assignment_priority"
      expr: assignment_priority
      comment: "Priority level of the assignment. Used to triage resource conflicts and schedule critical equipment deployments."
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Current mobilisation status of the equipment. Tracks readiness and on-time deployment performance."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project to which the equipment is assigned. Enables project-level fleet cost and utilisation reporting."
    - name: "asset_id"
      expr: asset_id
      comment: "Asset being assigned. Enables per-asset utilisation and cost tracking across assignments."
    - name: "assignment_start_date"
      expr: DATE_TRUNC('month', assignment_start_date)
      comment: "Month the assignment commenced. Supports trend analysis of fleet deployment volumes over time."
    - name: "assignment_purpose"
      expr: assignment_purpose
      comment: "Business purpose of the assignment (e.g. Earthworks, Lifting, Haulage). Enables activity-based fleet cost analysis."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of fleet assignment records. Baseline measure for deployment volume tracking."
    - name: "total_planned_utilization_hours"
      expr: SUM(CAST(planned_utilization_hours AS DOUBLE))
      comment: "Total planned utilisation hours across all assignments. Baseline for schedule adherence and capacity planning."
    - name: "total_actual_utilization_hours"
      expr: SUM(CAST(actual_utilization_hours AS DOUBLE))
      comment: "Total actual utilisation hours recorded. Measures real fleet productivity against plan."
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total idle hours across assignments. High idle hours indicate wasted capacity and unnecessary hire costs."
    - name: "avg_utilization_hours_per_assignment"
      expr: AVG(CAST(actual_utilization_hours AS DOUBLE))
      comment: "Average actual utilisation hours per assignment. Benchmarks deployment intensity and equipment productivity."
    - name: "total_mobilization_cost"
      expr: SUM(CAST(mobilization_cost AS DOUBLE))
      comment: "Total mobilisation costs incurred. Mobilisation is a significant non-productive cost that impacts project margins."
    - name: "total_demobilization_cost"
      expr: SUM(CAST(demobilization_cost AS DOUBLE))
      comment: "Total demobilisation costs incurred. Combined with mobilisation cost, drives total logistics overhead per project."
    - name: "total_daily_rate_cost"
      expr: SUM(CAST(daily_rate AS DOUBLE))
      comment: "Sum of daily hire rates across assignments. Proxy for total hire cost commitment in the assignment portfolio."
    - name: "avg_operating_rate_per_hour"
      expr: AVG(CAST(operating_rate_per_hour AS DOUBLE))
      comment: "Average operating cost rate per hour across assignments. Used to benchmark equipment cost efficiency and negotiate hire rates."
    - name: "distinct_assets_deployed"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of distinct assets deployed across assignments. Measures fleet breadth in use and identifies concentration risk."
    - name: "distinct_projects_served"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of distinct projects receiving equipment. Indicates fleet sharing efficiency across the project portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_hours`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift-level KPI layer over equipment hours records. Tracks operating productivity, downtime, utilisation rates, fuel consumption, and cost per hour to support daily operational decisions and equipment performance management."
  source: "`vibe_construction_v1`.`equipment`.`hours`"
  dimensions:
    - name: "shift_date"
      expr: DATE_TRUNC('month', shift_date)
      comment: "Month of the shift. Enables trend analysis of equipment productivity and downtime over time."
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (e.g. Day, Night, Extended). Used to analyse productivity and downtime patterns by shift."
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of downtime event (e.g. Mechanical, Operator, Weather). Drives root-cause analysis and maintenance prioritisation."
    - name: "downtime_root_cause_code"
      expr: downtime_root_cause_code
      comment: "Root cause code for downtime. Enables systematic failure pattern analysis to reduce recurring downtime."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type of the equipment (Owned/Rented). Enables cost-per-hour comparison between owned and rented fleet."
    - name: "asset_id"
      expr: asset_id
      comment: "Asset for which hours are recorded. Enables per-asset performance benchmarking."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project context for the hours record. Supports project-level equipment productivity and cost reporting."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions during the shift. Used to correlate weather impact on equipment productivity and downtime."
    - name: "is_billable"
      expr: is_billable
      comment: "Indicates whether the hours are billable to a client. Drives revenue recognition and billing efficiency analysis."
  measures:
    - name: "total_operating_hours"
      expr: SUM(CAST(operating_hours AS DOUBLE))
      comment: "Total productive operating hours recorded. Primary measure of fleet output and productivity."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total downtime hours across all records. High downtime directly reduces project throughput and increases cost."
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total idle hours (available but not operating). Idle time represents wasted hire cost and deployment inefficiency."
    - name: "total_standby_hours"
      expr: SUM(CAST(standby_hours AS DOUBLE))
      comment: "Total standby hours. Standby costs are often contractually charged and must be minimised."
    - name: "avg_equipment_utilization_rate"
      expr: AVG(CAST(equipment_utilization_rate AS DOUBLE))
      comment: "Average equipment utilisation rate (pre-computed on source). Core KPI for fleet productivity — low rates trigger redeployment or return of rented equipment."
    - name: "avg_equipment_availability_rate"
      expr: AVG(CAST(equipment_availability_rate AS DOUBLE))
      comment: "Average equipment availability rate (pre-computed on source). Measures mechanical reliability — low availability drives maintenance investment decisions."
    - name: "total_fuel_consumption_liters"
      expr: SUM(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Total fuel consumed across all shifts. Drives fuel cost forecasting, carbon reporting, and efficiency benchmarking."
    - name: "total_equipment_cost"
      expr: SUM(CAST(total_equipment_cost AS DOUBLE))
      comment: "Total equipment cost recorded across shifts. Aggregates all cost components for project cost control and budget variance analysis."
    - name: "avg_cost_per_hour"
      expr: AVG(CAST(cost_per_hour AS DOUBLE))
      comment: "Average cost per operating hour. Key efficiency KPI used to benchmark equipment against budget rates and industry norms."
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total production output quantity (e.g. m³ excavated, tonnes hauled). Links equipment hours to physical project progress."
    - name: "distinct_assets_with_downtime"
      expr: COUNT(DISTINCT CASE WHEN downtime_hours > 0 THEN asset_id END)
      comment: "Number of distinct assets that experienced downtime. Identifies the breadth of reliability issues across the fleet."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_fuel_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transaction-level KPI layer over equipment fuel consumption. Tracks fuel spend, consumption volumes, carbon emissions, unit costs, and anomalies (theft, emergency refuels) to support cost control, sustainability reporting, and fraud detection."
  source: "`vibe_construction_v1`.`equipment`.`fuel_transaction`"
  dimensions:
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the fuel transaction (e.g. Approved, Pending, Rejected). Used to filter confirmed spend from unprocessed records."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the transaction. Unapproved transactions may indicate control gaps or fraud risk."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction. Required for multi-currency cost consolidation."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for fuel quantity (e.g. Litres, Gallons). Ensures consistent volume aggregation."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project context for the fuel transaction. Enables project-level fuel cost and consumption reporting."
    - name: "asset_id"
      expr: asset_id
      comment: "Asset that consumed the fuel. Enables per-asset fuel efficiency and cost tracking."
    - name: "is_emergency_refuel"
      expr: is_emergency_refuel
      comment: "Flags emergency refuel events. High emergency refuel rates indicate poor fuel planning or supply chain issues."
    - name: "is_theft_suspected"
      expr: is_theft_suspected
      comment: "Flags transactions where fuel theft is suspected. Critical for fraud detection and loss prevention reporting."
    - name: "transaction_timestamp"
      expr: DATE_TRUNC('month', transaction_timestamp)
      comment: "Month of the fuel transaction. Enables trend analysis of fuel consumption and spend over time."
  measures:
    - name: "total_fuel_transactions"
      expr: COUNT(1)
      comment: "Total number of fuel transactions. Baseline measure for transaction volume and refuelling frequency."
    - name: "total_fuel_quantity_issued"
      expr: SUM(CAST(quantity_issued AS DOUBLE))
      comment: "Total fuel volume issued across all transactions. Primary consumption metric for fuel budget management and sustainability reporting."
    - name: "total_fuel_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total fuel expenditure. One of the largest variable operating costs for construction fleets — directly impacts project margins."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average fuel unit cost per transaction. Used to benchmark procurement efficiency and detect price anomalies."
    - name: "total_carbon_emission_kg"
      expr: SUM(CAST(carbon_emission_kg AS DOUBLE))
      comment: "Total carbon emissions (kg CO₂e) from fuel consumption. Mandatory for ESG reporting and decarbonisation target tracking."
    - name: "avg_carbon_emission_per_transaction"
      expr: AVG(CAST(carbon_emission_kg AS DOUBLE))
      comment: "Average carbon emissions per fuel transaction. Benchmarks emission intensity and supports carbon reduction initiatives."
    - name: "suspected_theft_transaction_count"
      expr: COUNT(DISTINCT CASE WHEN is_theft_suspected = TRUE THEN fuel_transaction_id END)
      comment: "Number of transactions flagged for suspected fuel theft. Drives fraud investigation and loss prevention actions."
    - name: "emergency_refuel_count"
      expr: COUNT(DISTINCT CASE WHEN is_emergency_refuel = TRUE THEN fuel_transaction_id END)
      comment: "Number of emergency refuel events. High counts indicate fuel supply planning failures that increase operational risk and cost."
    - name: "distinct_assets_refuelled"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of distinct assets refuelled. Measures the breadth of fleet fuel consumption and supports per-asset cost allocation."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_maintenance_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work-order-level KPI layer over equipment maintenance. Tracks maintenance cost components, labour efficiency, downtime impact, warranty recovery, and order completion performance to support asset reliability and cost management decisions."
  source: "`vibe_construction_v1`.`equipment`.`maintenance_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the maintenance order (e.g. Open, In Progress, Closed). Used to track work-in-progress and backlog."
    - name: "order_type"
      expr: order_type
      comment: "Type of maintenance order (e.g. Preventive, Corrective, Emergency). Drives maintenance strategy analysis and cost benchmarking."
    - name: "priority"
      expr: priority
      comment: "Priority level of the maintenance order. High-priority orders indicate critical asset reliability risks."
    - name: "failure_code"
      expr: failure_code
      comment: "Standardised failure code. Enables systematic failure pattern analysis and root-cause driven maintenance strategy improvements."
    - name: "asset_id"
      expr: asset_id
      comment: "Asset subject to maintenance. Enables per-asset maintenance cost and reliability tracking."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project context for the maintenance order. Supports project-level maintenance cost reporting and budget control."
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Indicates whether a warranty claim was raised. Tracks warranty recovery opportunities and supplier accountability."
    - name: "compliance_inspection_flag"
      expr: compliance_inspection_flag
      comment: "Indicates whether the order was triggered by a compliance inspection. Tracks regulatory-driven maintenance volumes."
    - name: "planned_start_date"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month the maintenance was planned to start. Enables trend analysis of maintenance volumes and scheduling adherence."
  measures:
    - name: "total_maintenance_orders"
      expr: COUNT(1)
      comment: "Total number of maintenance orders. Baseline measure for maintenance workload and fleet reliability demand."
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_maintenance_cost AS DOUBLE))
      comment: "Total maintenance expenditure. One of the largest controllable cost categories for equipment-intensive construction businesses."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labour cost component of maintenance. Used to benchmark labour efficiency and identify opportunities for in-house vs. outsourced maintenance."
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total parts and materials cost for maintenance. Drives spare parts inventory investment and procurement strategy decisions."
    - name: "total_external_services_cost"
      expr: SUM(CAST(external_services_cost AS DOUBLE))
      comment: "Total cost of external maintenance services. High external costs may indicate capability gaps or opportunities for insourcing."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total equipment downtime hours caused by maintenance. Directly measures the productivity impact of maintenance events on project schedules."
    - name: "avg_labor_hours_per_order"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labour hours per maintenance order. Benchmarks maintenance complexity and workforce efficiency."
    - name: "avg_maintenance_cost_per_order"
      expr: AVG(CAST(total_maintenance_cost AS DOUBLE))
      comment: "Average total cost per maintenance order. Used to benchmark maintenance efficiency and detect cost outliers."
    - name: "warranty_claim_order_count"
      expr: COUNT(DISTINCT CASE WHEN warranty_claim_flag = TRUE THEN maintenance_order_id END)
      comment: "Number of maintenance orders with warranty claims raised. Tracks warranty recovery value and supplier accountability."
    - name: "distinct_assets_under_maintenance"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of distinct assets that have had maintenance orders. Measures the breadth of fleet maintenance demand."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_inspection_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection-level KPI layer over equipment inspection records. Tracks inspection outcomes, defect rates, compliance certification, and inspection costs to support regulatory compliance, safety management, and asset reliability decisions."
  source: "`vibe_construction_v1`.`equipment`.`inspection_record`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection record (e.g. Completed, Pending, Overdue). Used to track compliance posture and inspection backlog."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (e.g. Pre-Start, Periodic, Regulatory). Enables analysis of inspection volumes and outcomes by type."
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Result of the inspection (e.g. Pass, Fail, Conditional Pass). Primary KPI driver for fleet compliance and safety risk assessment."
    - name: "certificate_type"
      expr: certificate_type
      comment: "Type of compliance certificate issued. Tracks regulatory certification coverage across the fleet."
    - name: "asset_id"
      expr: asset_id
      comment: "Asset inspected. Enables per-asset compliance history and defect trend analysis."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project context for the inspection. Supports project-level compliance reporting and audit readiness."
    - name: "certificate_issued_flag"
      expr: certificate_issued_flag
      comment: "Indicates whether a compliance certificate was issued following the inspection. Tracks certification conversion rate."
    - name: "inspection_date"
      expr: DATE_TRUNC('month', inspection_date)
      comment: "Month the inspection was conducted. Enables trend analysis of inspection volumes and compliance rates over time."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspection records. Baseline measure for inspection programme activity and compliance coverage."
    - name: "total_inspection_cost"
      expr: SUM(CAST(inspection_cost AS DOUBLE))
      comment: "Total cost of inspections conducted. Drives inspection programme budget management and cost-per-asset compliance tracking."
    - name: "avg_inspection_cost"
      expr: AVG(CAST(inspection_cost AS DOUBLE))
      comment: "Average cost per inspection. Used to benchmark inspection efficiency and evaluate third-party inspector value."
    - name: "total_equipment_hours_at_inspection"
      expr: SUM(CAST(equipment_hours_at_inspection AS DOUBLE))
      comment: "Total equipment hours logged at time of inspection. Used to validate inspection frequency compliance against hour-based triggers."
    - name: "avg_equipment_hours_at_inspection"
      expr: AVG(CAST(equipment_hours_at_inspection AS DOUBLE))
      comment: "Average equipment hours at time of inspection. Benchmarks whether inspections are occurring at the correct hour intervals."
    - name: "failed_inspection_count"
      expr: COUNT(DISTINCT CASE WHEN inspection_outcome = 'Fail' THEN inspection_record_id END)
      comment: "Number of inspections with a Fail outcome. High failure counts indicate systemic fleet reliability or maintenance quality issues."
    - name: "certificate_issued_count"
      expr: COUNT(DISTINCT CASE WHEN certificate_issued_flag = TRUE THEN inspection_record_id END)
      comment: "Number of inspections resulting in a compliance certificate being issued. Tracks regulatory certification throughput."
    - name: "distinct_assets_inspected"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of distinct assets that have been inspected. Measures compliance coverage breadth across the fleet."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_rental_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agreement-level KPI layer over equipment rental contracts. Tracks rental cost commitments, hire rate benchmarks, mobilisation charges, and rental portfolio composition to support procurement negotiation, cost control, and make-vs-rent decisions."
  source: "`vibe_construction_v1`.`equipment`.`rental_agreement`"
  dimensions:
    - name: "rental_status"
      expr: rental_status
      comment: "Current status of the rental agreement (e.g. Active, Expired, Cancelled). Used to filter the active rental cost portfolio."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment covered by the rental agreement. Enables hire rate benchmarking and spend analysis by equipment category."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rental agreement. Required for multi-currency cost consolidation and FX exposure analysis."
    - name: "maintenance_responsibility"
      expr: maintenance_responsibility
      comment: "Party responsible for maintenance under the agreement (Owner/Renter). Impacts total cost of ownership calculations."
    - name: "operator_supplied_flag"
      expr: operator_supplied_flag
      comment: "Indicates whether the operator is supplied by the rental vendor. Affects all-in cost comparisons and workforce planning."
    - name: "fuel_included_flag"
      expr: fuel_included_flag
      comment: "Indicates whether fuel is included in the hire rate. Critical for accurate total cost of hire calculations."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project the rental agreement is associated with. Enables project-level rental cost reporting and budget control."
    - name: "rental_start_date"
      expr: DATE_TRUNC('month', rental_start_date)
      comment: "Month the rental commenced. Enables trend analysis of rental portfolio growth and seasonal demand patterns."
  measures:
    - name: "total_rental_agreements"
      expr: COUNT(1)
      comment: "Total number of rental agreements. Baseline measure for rental portfolio size and vendor relationship breadth."
    - name: "total_committed_rental_cost"
      expr: SUM(CAST(total_committed_cost AS DOUBLE))
      comment: "Total committed cost across all rental agreements. Primary measure of rental expenditure exposure for budget and cash flow management."
    - name: "avg_daily_hire_rate"
      expr: AVG(CAST(daily_hire_rate AS DOUBLE))
      comment: "Average daily hire rate across agreements. Used to benchmark procurement efficiency and negotiate competitive rates."
    - name: "avg_weekly_hire_rate"
      expr: AVG(CAST(weekly_hire_rate AS DOUBLE))
      comment: "Average weekly hire rate across agreements. Supports rate benchmarking for medium-duration equipment rentals."
    - name: "avg_monthly_hire_rate"
      expr: AVG(CAST(monthly_hire_rate AS DOUBLE))
      comment: "Average monthly hire rate across agreements. Used for long-duration rental cost planning and make-vs-rent analysis."
    - name: "total_mobilization_charge"
      expr: SUM(CAST(mobilization_charge AS DOUBLE))
      comment: "Total mobilisation charges across rental agreements. Mobilisation is a significant upfront cost that affects project cash flow."
    - name: "total_demobilization_charge"
      expr: SUM(CAST(demobilization_charge AS DOUBLE))
      comment: "Total demobilisation charges across rental agreements. Combined with mobilisation, represents total logistics overhead for rented equipment."
    - name: "total_security_deposit"
      expr: SUM(CAST(security_deposit_amount AS DOUBLE))
      comment: "Total security deposits held across active rental agreements. Represents working capital tied up in rental commitments."
    - name: "distinct_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct rental vendors. Measures supplier diversification and concentration risk in the rental portfolio."
$$;