-- Metric views for domain: equipment | Business: Construction | Version: 2 | Generated on: 2026-06-22 15:07:26

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the equipment asset master — tracks fleet size, book value, acquisition investment, disposal proceeds, and operating hours to support capital planning and lifecycle decisions."
  source: "`vibe_construction_v1`.`equipment`.`asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Current operational status of the asset (Active, Idle, Under Maintenance, Disposed) — primary fleet health dimension."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Whether the asset is owned, rented, or leased — drives make-vs-buy and capital allocation decisions."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Stage in the asset lifecycle (New, In-Service, End-of-Life) — used to prioritise replacement planning."
    - name: "classification"
      expr: classification
      comment: "Equipment classification (Heavy, Light, Specialised) — supports category-level fleet analysis."
    - name: "emissions_tier"
      expr: emissions_tier
      comment: "Regulatory emissions tier of the asset — used for environmental compliance reporting."
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year the asset was acquired — enables cohort analysis of fleet age and investment timing."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method used to dispose of the asset (Sale, Scrap, Transfer) — informs residual value recovery analysis."
  measures:
    - name: "total_assets"
      expr: COUNT(1)
      comment: "Total number of assets in the fleet — baseline fleet size KPI for capacity planning."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total capital invested in acquiring the fleet — key input to capital expenditure reporting."
    - name: "total_current_book_value"
      expr: SUM(CAST(current_book_value AS DOUBLE))
      comment: "Aggregate net book value of all assets — reflects remaining balance sheet value of the fleet."
    - name: "avg_current_book_value"
      expr: AVG(CAST(current_book_value AS DOUBLE))
      comment: "Average net book value per asset — benchmarks depreciation progress across the fleet."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total cash recovered from asset disposals — measures residual value realisation effectiveness."
    - name: "total_operating_hours"
      expr: SUM(CAST(total_operating_hours AS DOUBLE))
      comment: "Cumulative operating hours across all assets — proxy for fleet utilisation and wear."
    - name: "avg_operating_hours_per_asset"
      expr: AVG(CAST(total_operating_hours AS DOUBLE))
      comment: "Average lifetime operating hours per asset — identifies over-worked or under-utilised equipment."
    - name: "total_operating_weight_kg"
      expr: SUM(CAST(operating_weight_kg AS DOUBLE))
      comment: "Total fleet operating weight — used for logistics, site load planning, and permit compliance."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_asset_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial valuation KPIs for equipment assets — tracks depreciation, impairment, fair market value, and residual value to support balance sheet accuracy and capital recovery decisions."
  source: "`vibe_construction_v1`.`equipment`.`asset_valuation`"
  dimensions:
    - name: "valuation_status"
      expr: valuation_status
      comment: "Status of the valuation record (Draft, Approved, Superseded) — filters to active valuations."
    - name: "valuation_source"
      expr: valuation_source
      comment: "Source of the valuation (Internal, External Appraiser, Market) — indicates reliability of the estimate."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (Straight-Line, Declining Balance) — affects book value trajectory."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Asset ownership classification — segments valuation analysis by owned vs. leased fleet."
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class grouping — enables portfolio-level valuation roll-ups."
    - name: "valuation_year"
      expr: YEAR(valuation_date)
      comment: "Year of the valuation — supports trend analysis of fleet value over time."
    - name: "impairment_indicator"
      expr: CAST(impairment_indicator AS STRING)
      comment: "Whether the asset has been flagged for impairment — isolates impaired assets for write-down analysis."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total original acquisition cost across all valued assets — gross investment baseline."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total depreciation charged to date — measures how much of the fleet investment has been expensed."
    - name: "total_current_book_value"
      expr: SUM(CAST(current_book_value AS DOUBLE))
      comment: "Aggregate net book value — the carrying amount of the fleet on the balance sheet."
    - name: "total_fair_market_value"
      expr: SUM(CAST(fair_market_value AS DOUBLE))
      comment: "Total fair market value of the fleet — used for insurance, disposal, and refinancing decisions."
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss AS DOUBLE))
      comment: "Total impairment losses recognised — quantifies write-downs due to asset value deterioration."
    - name: "total_residual_value"
      expr: SUM(CAST(residual_value AS DOUBLE))
      comment: "Total expected residual value at end of useful life — informs depreciation base and disposal planning."
    - name: "avg_remaining_useful_life_years"
      expr: AVG(CAST(remaining_useful_life_years AS DOUBLE))
      comment: "Average remaining useful life across the fleet — key input to replacement scheduling."
    - name: "avg_depreciation_rate_percent"
      expr: AVG(CAST(depreciation_rate_percent AS DOUBLE))
      comment: "Average depreciation rate applied across assets — benchmarks depreciation policy consistency."
    - name: "total_revaluation_amount"
      expr: SUM(CAST(revaluation_amount AS DOUBLE))
      comment: "Total upward or downward revaluation adjustments — tracks fair-value remeasurement impact on equity."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_hours`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational efficiency KPIs derived from equipment hour records — tracks utilisation, downtime, idle time, fuel consumption, and cost per operating hour to drive fleet productivity decisions."
  source: "`vibe_construction_v1`.`equipment`.`hours`"
  dimensions:
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the shift — primary time dimension for daily operational analysis."
    - name: "shift_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Month of the shift — supports monthly trend analysis of utilisation and cost."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift classification (Day, Night, Extended) — identifies productivity differences by shift."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Asset ownership type — compares owned vs. rented equipment performance."
    - name: "downtime_category"
      expr: downtime_category
      comment: "Root cause category of downtime (Mechanical, Operator, Weather, Planned) — drives maintenance prioritisation."
    - name: "is_billable"
      expr: CAST(is_billable AS STRING)
      comment: "Whether the hours are billable to a client — separates revenue-generating from overhead utilisation."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions during the shift — quantifies weather-related productivity impact."
  measures:
    - name: "total_operating_hours"
      expr: SUM(CAST(operating_hours AS DOUBLE))
      comment: "Total productive operating hours — primary fleet utilisation volume metric."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total hours lost to downtime — key reliability KPI; high values trigger maintenance intervention."
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total idle hours — measures unproductive time that inflates cost without output."
    - name: "total_standby_hours"
      expr: SUM(CAST(standby_hours AS DOUBLE))
      comment: "Total standby hours — quantifies time equipment is available but not actively working."
    - name: "avg_equipment_utilisation_rate"
      expr: AVG(CAST(equipment_utilization_rate AS DOUBLE))
      comment: "Average utilisation rate across all hour records — headline fleet efficiency KPI."
    - name: "avg_equipment_availability_rate"
      expr: AVG(CAST(equipment_availability_rate AS DOUBLE))
      comment: "Average availability rate — measures the proportion of time equipment is ready to operate."
    - name: "total_fuel_consumption_liters"
      expr: SUM(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Total fuel consumed — drives fuel cost management and carbon emission calculations."
    - name: "total_equipment_cost"
      expr: SUM(CAST(total_equipment_cost AS DOUBLE))
      comment: "Total equipment cost charged across all hour records — primary cost accountability metric."
    - name: "avg_cost_per_hour"
      expr: AVG(CAST(cost_per_hour AS DOUBLE))
      comment: "Average cost per operating hour — benchmarks equipment cost efficiency across the fleet."
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total production output recorded against equipment hours — links equipment cost to output volume."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_fleet_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fleet deployment and cost KPIs — tracks assignment utilisation, idle time, mobilisation costs, and rate efficiency to optimise how equipment is allocated across projects and work fronts."
  source: "`vibe_construction_v1`.`equipment`.`fleet_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the fleet assignment (Active, Completed, Cancelled) — filters to live deployments."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (Owned, Rented, Transferred) — segments cost analysis by procurement mode."
    - name: "assignment_priority"
      expr: assignment_priority
      comment: "Priority level of the assignment — identifies critical equipment deployments."
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Mobilisation status of the assigned equipment — tracks readiness for deployment."
    - name: "assignment_start_month"
      expr: DATE_TRUNC('MONTH', assignment_start_date)
      comment: "Month the assignment started — enables monthly fleet deployment trend analysis."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of fleet assignments — baseline deployment volume metric."
    - name: "total_planned_utilisation_hours"
      expr: SUM(CAST(planned_utilization_hours AS DOUBLE))
      comment: "Total planned utilisation hours across all assignments — baseline for utilisation gap analysis."
    - name: "total_actual_utilisation_hours"
      expr: SUM(CAST(actual_utilization_hours AS DOUBLE))
      comment: "Total actual utilisation hours — measures real fleet productivity against plan."
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total idle hours across assignments — quantifies unproductive deployment time and wasted cost."
    - name: "total_mobilisation_cost"
      expr: SUM(CAST(mobilization_cost AS DOUBLE))
      comment: "Total mobilisation costs incurred — significant overhead in construction fleet management."
    - name: "total_demobilisation_cost"
      expr: SUM(CAST(demobilization_cost AS DOUBLE))
      comment: "Total demobilisation costs — combined with mobilisation cost gives full deployment overhead."
    - name: "avg_daily_rate"
      expr: AVG(CAST(daily_rate AS DOUBLE))
      comment: "Average daily hire rate across assignments — benchmarks rental cost competitiveness."
    - name: "avg_operating_rate_per_hour"
      expr: AVG(CAST(operating_rate_per_hour AS DOUBLE))
      comment: "Average operating rate per hour — used to validate cost codes and budget assumptions."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_maintenance_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance execution KPIs — tracks maintenance cost, labour hours, downtime, and order completion to drive preventive vs. corrective maintenance strategy and cost control."
  source: "`vibe_construction_v1`.`equipment`.`maintenance_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Status of the maintenance order (Open, In Progress, Completed, Cancelled) — tracks execution pipeline."
    - name: "order_type"
      expr: order_type
      comment: "Type of maintenance (Preventive, Corrective, Predictive, Statutory) — key strategic split for maintenance mix analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the maintenance order — identifies critical work that affects fleet availability."
    - name: "failure_code"
      expr: failure_code
      comment: "Failure code associated with the order — enables Pareto analysis of recurring failure modes."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month the maintenance was planned to start — supports maintenance backlog trend analysis."
    - name: "compliance_inspection_flag"
      expr: CAST(compliance_inspection_flag AS STRING)
      comment: "Whether the order is a regulatory compliance inspection — isolates statutory maintenance obligations."
    - name: "warranty_claim_flag"
      expr: CAST(warranty_claim_flag AS STRING)
      comment: "Whether a warranty claim was raised — tracks warranty recovery opportunities."
  measures:
    - name: "total_maintenance_orders"
      expr: COUNT(1)
      comment: "Total number of maintenance orders — baseline maintenance workload volume."
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_maintenance_cost AS DOUBLE))
      comment: "Total maintenance expenditure — primary cost KPI for fleet maintenance budget management."
    - name: "total_labour_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labour cost component of maintenance — benchmarks labour efficiency in maintenance execution."
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total parts and materials cost — identifies high-consumption components for inventory optimisation."
    - name: "total_external_services_cost"
      expr: SUM(CAST(external_services_cost AS DOUBLE))
      comment: "Total cost of external maintenance services — measures outsourcing spend vs. in-house capability."
    - name: "total_labour_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labour hours consumed by maintenance — workforce demand planning input."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total equipment downtime caused by maintenance — directly impacts project schedule and productivity."
    - name: "avg_maintenance_cost_per_order"
      expr: AVG(CAST(total_maintenance_cost AS DOUBLE))
      comment: "Average cost per maintenance order — benchmarks maintenance efficiency and detects cost outliers."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_maintenance_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance planning KPIs — tracks plan coverage, estimated cost, downtime requirements, and scheduling adherence to ensure proactive fleet reliability management."
  source: "`vibe_construction_v1`.`equipment`.`maintenance_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the maintenance plan (Active, Suspended, Expired) — filters to live plans."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of maintenance plan (Time-Based, Usage-Based, Condition-Based) — drives scheduling strategy analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the plan — identifies safety-critical and high-priority maintenance obligations."
    - name: "safety_critical_flag"
      expr: CAST(safety_critical_flag AS STRING)
      comment: "Whether the plan covers safety-critical maintenance — mandatory for regulatory compliance reporting."
    - name: "interval_unit"
      expr: interval_unit
      comment: "Unit of the maintenance interval (Days, Hours, Kilometres) — segments plans by scheduling basis."
    - name: "downtime_required_flag"
      expr: CAST(downtime_required_flag AS STRING)
      comment: "Whether the maintenance requires equipment downtime — used to schedule around production windows."
  measures:
    - name: "total_maintenance_plans"
      expr: COUNT(1)
      comment: "Total number of active maintenance plans — measures preventive maintenance programme coverage."
    - name: "total_estimated_labour_cost"
      expr: SUM(CAST(estimated_labor_cost AS DOUBLE))
      comment: "Total estimated labour cost across all plans — input to annual maintenance budget."
    - name: "total_estimated_material_cost"
      expr: SUM(CAST(estimated_material_cost AS DOUBLE))
      comment: "Total estimated material cost across all plans — drives spare parts procurement planning."
    - name: "total_estimated_downtime_hours"
      expr: SUM(CAST(estimated_downtime_hours AS DOUBLE))
      comment: "Total planned downtime hours from maintenance — critical input to project schedule risk assessment."
    - name: "avg_estimated_duration_hours"
      expr: AVG(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average estimated duration per maintenance task — benchmarks maintenance crew planning."
    - name: "avg_interval_value"
      expr: AVG(CAST(interval_value AS DOUBLE))
      comment: "Average maintenance interval — indicates how frequently the fleet requires planned maintenance."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_fuel_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fuel consumption and cost KPIs — tracks total fuel issued, unit cost, carbon emissions, and emergency refuels to drive fuel efficiency, cost control, and sustainability reporting."
  source: "`vibe_construction_v1`.`equipment`.`fuel_transaction`"
  dimensions:
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the fuel transaction (Approved, Pending, Rejected) — filters to confirmed consumption data."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for fuel quantity (Litres, Gallons) — ensures consistent volume aggregation."
    - name: "is_emergency_refuel"
      expr: CAST(is_emergency_refuel AS STRING)
      comment: "Whether the transaction was an emergency refuel — identifies unplanned fuel events that signal operational issues."
    - name: "is_theft_suspected"
      expr: CAST(is_theft_suspected AS STRING)
      comment: "Whether fuel theft is suspected — critical flag for loss prevention and audit."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of the fuel transaction — supports monthly fuel cost and consumption trend analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the transaction — separates approved from pending/rejected fuel records."
  measures:
    - name: "total_fuel_transactions"
      expr: COUNT(1)
      comment: "Total number of fuel transactions — baseline refuelling activity volume."
    - name: "total_quantity_issued_liters"
      expr: SUM(CAST(quantity_issued AS DOUBLE))
      comment: "Total fuel volume issued — primary fuel consumption KPI for fleet management."
    - name: "total_fuel_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total fuel expenditure — major operating cost component for construction equipment fleets."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average fuel unit cost — benchmarks procurement efficiency and detects price anomalies."
    - name: "total_carbon_emission_kg"
      expr: SUM(CAST(carbon_emission_kg AS DOUBLE))
      comment: "Total carbon emissions from fuel consumption — mandatory for ESG and sustainability reporting."
    - name: "avg_tank_capacity_percentage"
      expr: AVG(CAST(tank_capacity_percentage AS DOUBLE))
      comment: "Average tank fill level at time of transaction — identifies over- or under-fuelling patterns."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_inspection_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment inspection compliance and cost KPIs — tracks inspection outcomes, defect rates, overdue inspections, and inspection costs to ensure regulatory compliance and fleet safety."
  source: "`vibe_construction_v1`.`equipment`.`inspection_record`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Status of the inspection (Scheduled, In Progress, Completed, Overdue) — primary compliance health dimension."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (Statutory, Preventive, Pre-Operational) — segments compliance vs. operational inspections."
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Result of the inspection (Pass, Fail, Conditional Pass) — drives corrective action prioritisation."
    - name: "certificate_issued_flag"
      expr: CAST(certificate_issued_flag AS STRING)
      comment: "Whether a compliance certificate was issued — tracks regulatory certification coverage."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of the inspection — supports monthly compliance trend analysis."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspections conducted — baseline compliance activity volume."
    - name: "total_inspection_cost"
      expr: SUM(CAST(inspection_cost AS DOUBLE))
      comment: "Total cost of inspections — input to compliance budget management."
    - name: "avg_inspection_cost"
      expr: AVG(CAST(inspection_cost AS DOUBLE))
      comment: "Average cost per inspection — benchmarks inspection efficiency across asset types."
    - name: "total_equipment_hours_at_inspection"
      expr: SUM(CAST(equipment_hours_at_inspection AS DOUBLE))
      comment: "Total equipment hours logged at time of inspection — correlates usage intensity with inspection frequency."
    - name: "avg_equipment_hours_at_inspection"
      expr: AVG(CAST(equipment_hours_at_inspection AS DOUBLE))
      comment: "Average equipment hours at inspection — identifies whether inspections are occurring at correct usage intervals."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_rental_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment rental cost and commitment KPIs — tracks rental rates, total committed cost, security deposits, and mobilisation charges to optimise the rent-vs-own decision and control rental spend."
  source: "`vibe_construction_v1`.`equipment`.`rental_agreement`"
  dimensions:
    - name: "rental_status"
      expr: rental_status
      comment: "Status of the rental agreement (Active, Expired, Terminated) — filters to live rental commitments."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of rented equipment — enables category-level rental spend analysis."
    - name: "maintenance_responsibility"
      expr: maintenance_responsibility
      comment: "Who is responsible for maintenance (Owner, Renter) — affects total cost of ownership calculation."
    - name: "operator_supplied_flag"
      expr: CAST(operator_supplied_flag AS STRING)
      comment: "Whether the operator is supplied by the rental vendor — impacts labour cost planning."
    - name: "fuel_included_flag"
      expr: CAST(fuel_included_flag AS STRING)
      comment: "Whether fuel is included in the rental rate — affects true cost comparison across agreements."
    - name: "rental_start_month"
      expr: DATE_TRUNC('MONTH', rental_start_date)
      comment: "Month the rental commenced — supports rental commitment trend analysis."
  measures:
    - name: "total_rental_agreements"
      expr: COUNT(1)
      comment: "Total number of rental agreements — baseline rental fleet size metric."
    - name: "total_committed_rental_cost"
      expr: SUM(CAST(total_committed_cost AS DOUBLE))
      comment: "Total committed rental expenditure — key input to project cost-at-completion forecasting."
    - name: "avg_daily_hire_rate"
      expr: AVG(CAST(daily_hire_rate AS DOUBLE))
      comment: "Average daily hire rate — benchmarks rental procurement competitiveness."
    - name: "avg_weekly_hire_rate"
      expr: AVG(CAST(weekly_hire_rate AS DOUBLE))
      comment: "Average weekly hire rate — supports rate negotiation and vendor comparison."
    - name: "avg_monthly_hire_rate"
      expr: AVG(CAST(monthly_hire_rate AS DOUBLE))
      comment: "Average monthly hire rate — used for long-term rental cost forecasting."
    - name: "total_mobilisation_charge"
      expr: SUM(CAST(mobilization_charge AS DOUBLE))
      comment: "Total mobilisation charges across rental agreements — quantifies deployment overhead cost."
    - name: "total_demobilisation_charge"
      expr: SUM(CAST(demobilization_charge AS DOUBLE))
      comment: "Total demobilisation charges — combined with mobilisation gives full deployment cost burden."
    - name: "total_security_deposit"
      expr: SUM(CAST(security_deposit_amount AS DOUBLE))
      comment: "Total security deposits held — tracks cash tied up in rental security obligations."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_telematics_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time equipment telematics KPIs — tracks engine hours, fuel consumption, idle time, speed, and fault events from IoT sensors to enable predictive maintenance and operational efficiency decisions."
  source: "`vibe_construction_v1`.`equipment`.`telematics_reading`"
  dimensions:
    - name: "data_source"
      expr: data_source
      comment: "Source system of the telematics data (GPS, OBD, Telematics Platform) — validates data provenance."
    - name: "geofence_status"
      expr: geofence_status
      comment: "Whether the asset is inside or outside its assigned geofence — detects unauthorised equipment movement."
    - name: "fault_severity"
      expr: fault_severity
      comment: "Severity of any fault detected (Critical, Warning, Info) — prioritises maintenance response."
    - name: "reading_quality"
      expr: reading_quality
      comment: "Quality flag of the telematics reading (Good, Degraded, Invalid) — filters to reliable data."
    - name: "reading_month"
      expr: DATE_TRUNC('MONTH', reading_timestamp)
      comment: "Month of the telematics reading — supports monthly utilisation and fuel trend analysis."
  measures:
    - name: "total_telematics_readings"
      expr: COUNT(1)
      comment: "Total telematics readings received — measures IoT data coverage and device health."
    - name: "total_engine_hours"
      expr: SUM(CAST(engine_hours AS DOUBLE))
      comment: "Total engine hours recorded via telematics — most accurate source of utilisation data."
    - name: "total_fuel_consumed_liters"
      expr: SUM(CAST(fuel_consumed_liters AS DOUBLE))
      comment: "Total fuel consumed as measured by telematics — enables precise fuel efficiency benchmarking."
    - name: "avg_fuel_level_percent"
      expr: AVG(CAST(fuel_level_percent AS DOUBLE))
      comment: "Average fuel level across readings — identifies assets at risk of running out of fuel."
    - name: "total_idle_time_minutes"
      expr: SUM(CAST(idle_time_minutes AS DOUBLE))
      comment: "Total idle time in minutes — quantifies unproductive engine-on time that wastes fuel and increases emissions."
    - name: "avg_speed_kmh"
      expr: AVG(CAST(speed_kmh AS DOUBLE))
      comment: "Average operating speed — used for safety compliance and haul road efficiency analysis."
    - name: "total_payload_weight_kg"
      expr: SUM(CAST(payload_weight_kg AS DOUBLE))
      comment: "Total payload weight transported — measures haulage productivity from telematics data."
    - name: "avg_battery_voltage"
      expr: AVG(CAST(battery_voltage AS DOUBLE))
      comment: "Average battery voltage across readings — early warning indicator for electrical system issues."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_operator_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operator certification compliance KPIs — tracks certification coverage, expiry risk, assessment scores, and training hours to ensure all equipment operators hold valid licences and reduce safety and legal exposure."
  source: "`vibe_construction_v1`.`equipment`.`operator_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Status of the certification (Active, Expired, Suspended, Pending Renewal) — primary compliance health dimension."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (Crane, Forklift, Explosive Handling) — segments compliance by equipment class."
    - name: "certification_level"
      expr: certification_level
      comment: "Level of certification (Basic, Advanced, Master) — tracks operator skill progression."
    - name: "certifying_body"
      expr: certifying_body
      comment: "Organisation that issued the certification — validates accreditation source."
    - name: "issuing_country_code"
      expr: issuing_country_code
      comment: "Country of certification issuance — supports multi-jurisdiction compliance management."
    - name: "medical_clearance_required"
      expr: CAST(medical_clearance_required AS STRING)
      comment: "Whether medical clearance is required for this certification — identifies health-gated licences."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the certification expires — enables forward-looking renewal planning."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total operator certifications on record — baseline compliance coverage metric."
    - name: "total_training_hours_completed"
      expr: SUM(CAST(training_hours_completed AS DOUBLE))
      comment: "Total training hours completed by operators — measures investment in workforce competency."
    - name: "avg_theory_assessment_score"
      expr: AVG(CAST(theory_assessment_score AS DOUBLE))
      comment: "Average theory assessment score — benchmarks operator knowledge quality across the workforce."
    - name: "avg_practical_assessment_score"
      expr: AVG(CAST(practical_assessment_score AS DOUBLE))
      comment: "Average practical assessment score — measures hands-on competency of certified operators."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of operator certifications — input to workforce compliance budget management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_mobilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment mobilisation logistics KPIs — tracks transport cost, transit time accuracy, distance, and mobilisation status to optimise fleet deployment logistics and reduce mobilisation overhead."
  source: "`vibe_construction_v1`.`equipment`.`equipment_mobilization`"
  dimensions:
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Status of the mobilisation event (Planned, In Transit, Arrived, Cancelled) — tracks deployment pipeline."
    - name: "event_type"
      expr: event_type
      comment: "Type of mobilisation event (Mobilise, Demobilise, Transfer) — segments inbound vs. outbound movements."
    - name: "transport_method"
      expr: transport_method
      comment: "Method of transport (Road, Rail, Sea, Air) — enables cost and time analysis by transport mode."
    - name: "permit_required_flag"
      expr: CAST(permit_required_flag AS STRING)
      comment: "Whether a transport permit is required — identifies high-complexity movements with regulatory overhead."
    - name: "insurance_coverage_flag"
      expr: CAST(insurance_coverage_flag AS STRING)
      comment: "Whether insurance coverage is in place for the mobilisation — flags uninsured transport risk."
    - name: "dispatch_month"
      expr: DATE_TRUNC('MONTH', planned_dispatch_date)
      comment: "Month of planned dispatch — supports monthly mobilisation volume and cost trend analysis."
  measures:
    - name: "total_mobilisations"
      expr: COUNT(1)
      comment: "Total number of mobilisation events — baseline fleet movement volume metric."
    - name: "total_transport_cost"
      expr: SUM(CAST(transport_cost AS DOUBLE))
      comment: "Total transport cost across all mobilisations — major overhead cost in construction fleet management."
    - name: "avg_transport_cost"
      expr: AVG(CAST(transport_cost AS DOUBLE))
      comment: "Average transport cost per mobilisation — benchmarks logistics efficiency and vendor rates."
    - name: "total_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Total distance covered in mobilisations — correlates with transport cost and carbon footprint."
    - name: "total_actual_transit_hours"
      expr: SUM(CAST(actual_transit_hours AS DOUBLE))
      comment: "Total actual transit hours — measures real logistics time consumed by fleet movements."
    - name: "total_estimated_transit_hours"
      expr: SUM(CAST(estimated_transit_hours AS DOUBLE))
      comment: "Total estimated transit hours — baseline for transit time variance analysis."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`equipment_asset_activity_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment-to-schedule assignment performance KPIs — tracks planned vs. actual hours, cost variance, and utilisation rate for equipment assigned to schedule activities to drive resource efficiency on construction projects."
  source: "`vibe_construction_v1`.`equipment`.`asset_activity_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Status of the assignment (Planned, Active, Completed, Cancelled) — filters to relevant assignment records."
    - name: "resource_role"
      expr: resource_role
      comment: "Role of the equipment resource on the activity (Primary, Support, Standby) — segments utilisation by deployment role."
    - name: "is_critical_resource"
      expr: CAST(is_critical_resource AS STRING)
      comment: "Whether the equipment is on the critical path — prioritises monitoring of schedule-critical assets."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the assignment quantity — ensures consistent quantity aggregation."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the assignment started — supports monthly resource deployment trend analysis."
  measures:
    - name: "total_planned_hours"
      expr: SUM(CAST(planned_hours AS DOUBLE))
      comment: "Total planned equipment hours across all activity assignments — baseline for schedule resource planning."
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual equipment hours consumed — measures real resource consumption against plan."
    - name: "total_allocated_hours"
      expr: SUM(CAST(allocated_hours AS DOUBLE))
      comment: "Total hours allocated to assignments — tracks committed resource capacity."
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned cost for equipment assignments — input to project budget baseline."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred — primary cost accountability metric for equipment resource management."
    - name: "total_assignment_cost"
      expr: SUM(CAST(assignment_cost AS DOUBLE))
      comment: "Total committed assignment cost — measures total equipment cost obligation on the schedule."
    - name: "avg_utilisation_rate"
      expr: AVG(CAST(utilization_rate AS DOUBLE))
      comment: "Average utilisation rate across assignments — headline equipment productivity KPI on scheduled activities."
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate charged for equipment assignments — benchmarks cost assumptions in project estimates."
$$;