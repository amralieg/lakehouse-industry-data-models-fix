-- Metric views for domain: facility | Business: Education | Version: 1 | Generated on: 2026-05-06 15:08:33

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`facility_building`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the physical building portfolio — space capacity, financial exposure, sustainability posture, and deferred maintenance risk across the campus estate."
  source: "`education_ecm`.`facility`.`building`"
  dimensions:
    - name: "building_type"
      expr: building_type
      comment: "Functional classification of the building (e.g., Academic, Residential, Administrative) enabling portfolio segmentation."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational state of the building (e.g., Active, Closed, Under Renovation) for filtering live vs. inactive assets."
    - name: "ownership_status"
      expr: ownership_status
      comment: "Whether the building is owned, leased, or managed — critical for capital planning and financial reporting."
    - name: "leed_certification_level"
      expr: leed_certification_level
      comment: "LEED sustainability certification tier (e.g., Certified, Silver, Gold, Platinum) for sustainability benchmarking."
    - name: "ada_compliant"
      expr: ada_compliant
      comment: "ADA compliance flag enabling compliance gap analysis across the building portfolio."
    - name: "building_name"
      expr: building_name
      comment: "Human-readable building name for drill-down reporting."
    - name: "city"
      expr: city
      comment: "City where the building is located, supporting geographic segmentation."
    - name: "state_province"
      expr: state_province
      comment: "State or province for regional portfolio analysis."
  measures:
    - name: "total_buildings"
      expr: COUNT(1)
      comment: "Total number of buildings in the portfolio. Baseline headcount for portfolio sizing and benchmarking."
    - name: "total_gross_square_feet"
      expr: SUM(CAST(gross_square_feet AS DOUBLE))
      comment: "Total gross square footage across all buildings. Core space inventory metric used in space planning and accreditation reporting."
    - name: "total_assignable_square_feet"
      expr: SUM(CAST(assignable_square_feet AS DOUBLE))
      comment: "Total assignable (usable) square footage. Drives space allocation decisions and IPEDS/FICM reporting."
    - name: "avg_space_utilization_rate"
      expr: AVG(CAST(space_utilization_rate AS DOUBLE))
      comment: "Average space utilization rate across buildings. A low rate signals underused real estate; a high rate signals capacity pressure — directly informs consolidation or expansion decisions."
    - name: "total_deferred_maintenance_backlog"
      expr: SUM(CAST(deferred_maintenance_backlog AS DOUBLE))
      comment: "Total deferred maintenance backlog in dollars. A leading indicator of capital reinvestment need and physical risk — a key metric for CFO and facilities VP."
    - name: "total_annual_operating_cost"
      expr: SUM(CAST(annual_operating_cost AS DOUBLE))
      comment: "Total annual operating cost across all buildings. Drives cost-per-square-foot benchmarking and budget planning."
    - name: "avg_annual_operating_cost_per_building"
      expr: AVG(CAST(annual_operating_cost AS DOUBLE))
      comment: "Average annual operating cost per building. Enables peer comparison and identification of outlier cost structures."
    - name: "total_replacement_value"
      expr: SUM(CAST(replacement_value AS DOUBLE))
      comment: "Total replacement value of the building portfolio. Essential for insurance adequacy, bond issuance, and capital planning."
    - name: "avg_facility_condition_index"
      expr: AVG(CAST(facility_condition_index AS DOUBLE))
      comment: "Average Facility Condition Index (FCI) across buildings. FCI is the industry-standard measure of physical plant health; a rising FCI signals deteriorating infrastructure."
    - name: "ada_non_compliant_building_count"
      expr: COUNT(CASE WHEN ada_compliant = FALSE THEN 1 END)
      comment: "Number of buildings not ADA compliant. Directly tied to regulatory risk and legal exposure — triggers remediation prioritization."
    - name: "leed_certified_building_count"
      expr: COUNT(CASE WHEN leed_certification_level IS NOT NULL AND leed_certification_level <> '' THEN 1 END)
      comment: "Number of buildings with any LEED certification. Tracks sustainability portfolio progress against institutional green building goals."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`facility_campus`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Portfolio-level KPIs for the campus estate — space inventory, accreditation status, and operational footprint used by senior leadership for strategic planning."
  source: "`education_ecm`.`facility`.`campus`"
  dimensions:
    - name: "campus_type"
      expr: campus_type
      comment: "Type of campus (e.g., Main, Satellite, Online, Medical) for portfolio segmentation."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the campus (e.g., Active, Closed) for filtering live vs. inactive campuses."
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Current accreditation status — a critical compliance dimension for federal financial aid eligibility."
    - name: "accreditor_name"
      expr: accreditor_name
      comment: "Name of the accrediting body, enabling analysis by accreditation authority."
    - name: "state_province"
      expr: state_province
      comment: "State or province for geographic portfolio analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country code for international campus portfolio analysis."
    - name: "ada_compliant_flag"
      expr: ada_compliant_flag
      comment: "ADA compliance flag at the campus level for regulatory compliance tracking."
  measures:
    - name: "total_campuses"
      expr: COUNT(1)
      comment: "Total number of campuses in the institutional portfolio. Baseline for portfolio sizing."
    - name: "total_gross_square_feet"
      expr: SUM(CAST(total_gross_square_feet AS DOUBLE))
      comment: "Total gross square footage across all campuses. Core space inventory metric for IPEDS reporting and capital planning."
    - name: "total_assignable_square_feet"
      expr: SUM(CAST(assignable_square_feet AS DOUBLE))
      comment: "Total assignable square footage across campuses. Drives space allocation and accreditation space adequacy assessments."
    - name: "total_acreage"
      expr: SUM(CAST(total_acreage AS DOUBLE))
      comment: "Total land acreage across all campuses. Used in master planning, environmental reporting, and real estate strategy."
    - name: "accredited_campus_count"
      expr: COUNT(CASE WHEN accreditation_status = 'Accredited' THEN 1 END)
      comment: "Number of campuses with active accreditation. Directly tied to federal financial aid eligibility and institutional reputation."
    - name: "campuses_with_library"
      expr: COUNT(CASE WHEN library_flag = TRUE THEN 1 END)
      comment: "Number of campuses with a library facility. Relevant for accreditation standards requiring adequate academic support resources."
    - name: "campuses_with_athletic_facilities"
      expr: COUNT(CASE WHEN athletic_facilities_flag = TRUE THEN 1 END)
      comment: "Number of campuses with athletic facilities. Informs student life investment decisions and NCAA compliance planning."
    - name: "avg_assignable_square_feet_per_campus"
      expr: AVG(CAST(assignable_square_feet AS DOUBLE))
      comment: "Average assignable square footage per campus. Enables peer benchmarking and identification of under-resourced campuses."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`facility_room`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room-level space inventory and quality KPIs — capacity, accessibility, technology readiness, and condition — used by space planners, registrars, and facilities leadership."
  source: "`education_ecm`.`facility`.`room`"
  dimensions:
    - name: "room_type"
      expr: room_type
      comment: "Functional type of the room (e.g., Classroom, Lab, Office, Conference) for space-use analysis."
    - name: "occupancy_status"
      expr: occupancy_status
      comment: "Current occupancy status of the room (e.g., Occupied, Vacant, Under Renovation) for utilization tracking."
    - name: "condition"
      expr: condition
      comment: "Physical condition rating of the room, used to prioritize renovation investments."
    - name: "ada_accessible_flag"
      expr: ada_accessible_flag
      comment: "Whether the room is ADA accessible — critical for compliance and equitable access reporting."
    - name: "smart_classroom_flag"
      expr: smart_classroom_flag
      comment: "Whether the room is equipped as a smart classroom — tracks technology modernization progress."
    - name: "scheduling_eligible_flag"
      expr: scheduling_eligible_flag
      comment: "Whether the room is eligible for centralized scheduling — determines available scheduling inventory."
    - name: "hazardous_materials_flag"
      expr: hazardous_materials_flag
      comment: "Whether the room contains hazardous materials — required for safety compliance reporting."
    - name: "room_subtype"
      expr: subtype
      comment: "Room subtype for granular space classification within a room type."
  measures:
    - name: "total_rooms"
      expr: COUNT(1)
      comment: "Total number of rooms in the inventory. Baseline space count for portfolio management."
    - name: "total_net_assignable_square_feet"
      expr: SUM(CAST(net_assignable_square_feet AS DOUBLE))
      comment: "Total net assignable square footage across all rooms. The primary space metric for FICM/IPEDS reporting and space allocation."
    - name: "total_gross_square_feet"
      expr: SUM(CAST(gross_square_feet AS DOUBLE))
      comment: "Total gross square footage across all rooms. Used in space efficiency ratio calculations."
    - name: "avg_net_assignable_square_feet_per_room"
      expr: AVG(CAST(net_assignable_square_feet AS DOUBLE))
      comment: "Average net assignable square footage per room. Benchmarks room sizing against peer institutions and program standards."
    - name: "scheduling_eligible_room_count"
      expr: COUNT(CASE WHEN scheduling_eligible_flag = TRUE THEN 1 END)
      comment: "Number of rooms available for centralized scheduling. Defines the schedulable space inventory for the registrar."
    - name: "smart_classroom_count"
      expr: COUNT(CASE WHEN smart_classroom_flag = TRUE THEN 1 END)
      comment: "Number of smart classrooms. Tracks technology modernization progress and informs capital investment in instructional technology."
    - name: "ada_non_accessible_room_count"
      expr: COUNT(CASE WHEN ada_accessible_flag = FALSE THEN 1 END)
      comment: "Number of rooms that are not ADA accessible. Drives ADA remediation prioritization and compliance risk management."
    - name: "hazardous_room_count"
      expr: COUNT(CASE WHEN hazardous_materials_flag = TRUE THEN 1 END)
      comment: "Number of rooms flagged for hazardous materials. Required for EHS compliance reporting and emergency planning."
    - name: "avg_ceiling_height_feet"
      expr: AVG(CAST(ceiling_height_feet AS DOUBLE))
      comment: "Average ceiling height in feet. Relevant for lab and specialized space planning where height clearance is a design constraint."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`facility_room_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room booking demand, utilization, and revenue KPIs — tracks scheduling throughput, cancellation rates, billing, and event-type patterns to optimize space utilization."
  source: "`education_ecm`.`facility`.`room_booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the booking (e.g., Confirmed, Cancelled, Pending) for pipeline and cancellation analysis."
    - name: "event_type"
      expr: event_type
      comment: "Type of event driving the booking (e.g., Class, Meeting, Conference, Athletics) for demand segmentation."
    - name: "setup_type"
      expr: setup_type
      comment: "Room setup configuration requested (e.g., Theater, Classroom, Banquet) for operational planning."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Whether the booking is part of a recurring series — distinguishes standing reservations from ad-hoc demand."
    - name: "billing_required"
      expr: billing_required
      comment: "Whether the booking generates a charge — segments revenue-generating vs. internal use bookings."
    - name: "av_equipment_required"
      expr: av_equipment_required
      comment: "Whether AV equipment was requested — informs technology resource demand planning."
    - name: "catering_required"
      expr: catering_required
      comment: "Whether catering was requested — informs auxiliary services demand planning."
    - name: "approval_required"
      expr: approval_required
      comment: "Whether the booking required approval — used to analyze approval workflow bottlenecks."
  measures:
    - name: "total_bookings"
      expr: COUNT(1)
      comment: "Total number of room booking requests. Baseline demand volume metric for space scheduling operations."
    - name: "confirmed_booking_count"
      expr: COUNT(CASE WHEN booking_status = 'Confirmed' THEN 1 END)
      comment: "Number of confirmed bookings. Represents actual scheduled demand on the space inventory."
    - name: "cancelled_booking_count"
      expr: COUNT(CASE WHEN booking_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled bookings. A high cancellation rate signals scheduling inefficiency or demand forecasting issues."
    - name: "total_billing_amount"
      expr: SUM(CAST(billing_amount AS DOUBLE))
      comment: "Total revenue generated from room bookings. Tracks auxiliary revenue contribution from space rental."
    - name: "avg_billing_amount_per_booking"
      expr: AVG(CAST(billing_amount AS DOUBLE))
      comment: "Average billing amount per booking. Benchmarks pricing and identifies revenue optimization opportunities."
    - name: "unique_rooms_booked"
      expr: COUNT(DISTINCT room_id)
      comment: "Number of distinct rooms that received at least one booking. Measures breadth of space utilization across the portfolio."
    - name: "bookings_requiring_av"
      expr: COUNT(CASE WHEN av_equipment_required = TRUE THEN 1 END)
      comment: "Number of bookings requiring AV equipment. Drives AV resource capacity planning and technology investment decisions."
    - name: "bookings_requiring_catering"
      expr: COUNT(CASE WHEN catering_required = TRUE THEN 1 END)
      comment: "Number of bookings requiring catering. Informs auxiliary services staffing and revenue forecasting."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`facility_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facilities maintenance operational KPIs — cost, labor efficiency, safety incidents, and warranty recovery — used by facilities directors and CFOs to manage maintenance spend and service quality."
  source: "`education_ecm`.`facility`.`work_order`"
  dimensions:
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order (e.g., Preventive, Corrective, Emergency, Inspection) for maintenance strategy analysis."
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order (e.g., Open, In Progress, Closed) for backlog and throughput tracking."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the work order (e.g., Critical, High, Medium, Low) for response-time SLA analysis."
    - name: "trade_category"
      expr: trade_category
      comment: "Trade discipline required (e.g., Electrical, Plumbing, HVAC, Carpentry) for workforce and contractor planning."
    - name: "ada_compliance_flag"
      expr: ada_compliance_flag
      comment: "Whether the work order is ADA compliance-related — tracks regulatory remediation activity."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Whether the work order is associated with a safety incident — critical for EHS risk management."
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Whether the work order is a warranty claim — tracks cost recovery from vendors and contractors."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders. Baseline maintenance demand volume for staffing and capacity planning."
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all work orders (labor + materials + contractor). Primary maintenance spend metric for budget management."
    - name: "avg_cost_per_work_order"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average cost per work order. Benchmarks maintenance efficiency and identifies cost outliers by type or trade."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total in-house labor cost across all work orders. Drives workforce planning and make-vs.-buy decisions for maintenance."
    - name: "total_contractor_cost"
      expr: SUM(CAST(contractor_cost AS DOUBLE))
      comment: "Total contractor spend across all work orders. Tracks outsourced maintenance expenditure for vendor management."
    - name: "total_materials_cost"
      expr: SUM(CAST(materials_cost AS DOUBLE))
      comment: "Total materials cost across all work orders. Informs parts inventory management and procurement strategy."
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours expended. Measures workforce utilization and informs staffing level decisions."
    - name: "avg_actual_labor_hours_per_work_order"
      expr: AVG(CAST(actual_labor_hours AS DOUBLE))
      comment: "Average actual labor hours per work order. Benchmarks task complexity and identifies efficiency improvement opportunities."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total facility downtime hours caused by maintenance activities. Directly tied to academic and operational disruption risk."
    - name: "safety_incident_work_order_count"
      expr: COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END)
      comment: "Number of work orders associated with safety incidents. A key EHS risk metric — any increase triggers immediate investigation."
    - name: "warranty_claim_work_order_count"
      expr: COUNT(CASE WHEN warranty_claim_flag = TRUE THEN 1 END)
      comment: "Number of work orders filed as warranty claims. Tracks cost recovery potential from vendor warranties."
    - name: "open_work_order_count"
      expr: COUNT(CASE WHEN work_order_status = 'Open' THEN 1 END)
      comment: "Number of currently open work orders. Measures maintenance backlog and service delivery capacity."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`facility_capital_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital project portfolio KPIs — budget performance, schedule variance, and risk exposure — used by CFOs, VPs of Facilities, and Boards to govern major construction and renovation investments."
  source: "`education_ecm`.`facility`.`capital_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the capital project (e.g., Planning, Design, Construction, Closed) for pipeline stage analysis."
    - name: "project_type"
      expr: project_type
      comment: "Type of capital project (e.g., New Construction, Renovation, Infrastructure, Deferred Maintenance) for investment category analysis."
    - name: "project_phase"
      expr: project_phase
      comment: "Current phase of the project lifecycle for stage-gate reporting."
    - name: "project_priority"
      expr: project_priority
      comment: "Priority classification of the project (e.g., Critical, High, Medium, Low) for resource allocation decisions."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the project — used to flag high-risk projects for executive oversight."
    - name: "ada_compliance_required"
      expr: ada_compliance_required
      comment: "Whether the project has an ADA compliance requirement — tracks regulatory-driven capital spend."
    - name: "leed_certification_target"
      expr: leed_certification_target
      comment: "Target LEED certification level for the project — tracks sustainability commitment in capital investments."
  measures:
    - name: "total_capital_projects"
      expr: COUNT(1)
      comment: "Total number of capital projects in the portfolio. Baseline for portfolio sizing and governance oversight."
    - name: "total_authorized_budget"
      expr: SUM(CAST(total_authorized_budget AS DOUBLE))
      comment: "Total authorized capital budget across all projects. Primary financial exposure metric for board and CFO reporting."
    - name: "total_actual_expenditures"
      expr: SUM(CAST(actual_expenditures_to_date AS DOUBLE))
      comment: "Total actual expenditures to date across all projects. Tracks capital spend pacing against authorized budgets."
    - name: "total_budget_variance"
      expr: SUM(CAST(budget_variance AS DOUBLE))
      comment: "Total budget variance (actual vs. authorized) across the portfolio. A negative aggregate signals systemic cost overruns requiring executive intervention."
    - name: "avg_budget_variance_per_project"
      expr: AVG(CAST(budget_variance AS DOUBLE))
      comment: "Average budget variance per project. Benchmarks project cost control performance and identifies systemic estimation issues."
    - name: "total_current_encumbrance"
      expr: SUM(CAST(current_encumbrance AS DOUBLE))
      comment: "Total current encumbrance (committed but not yet spent) across all projects. Critical for cash flow forecasting and budget availability analysis."
    - name: "over_budget_project_count"
      expr: COUNT(CASE WHEN budget_variance < 0 THEN 1 END)
      comment: "Number of projects currently over budget. A rising count is a leading indicator of portfolio cost control failure."
    - name: "high_risk_project_count"
      expr: COUNT(CASE WHEN risk_level IN ('High', 'Critical') THEN 1 END)
      comment: "Number of projects classified as high or critical risk. Drives executive risk review and contingency reserve decisions."
    - name: "avg_authorized_budget_per_project"
      expr: AVG(CAST(total_authorized_budget AS DOUBLE))
      comment: "Average authorized budget per capital project. Benchmarks project scale and informs future capital planning assumptions."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`facility_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical asset portfolio KPIs — acquisition value, replacement cost, lifecycle status, and maintenance readiness — used by facilities directors and CFOs for asset lifecycle management and capital reinvestment planning."
  source: "`education_ecm`.`facility`.`asset`"
  dimensions:
    - name: "asset_category"
      expr: asset_category
      comment: "High-level category of the asset (e.g., Equipment, Furniture, IT, Vehicle) for portfolio segmentation."
    - name: "asset_subcategory"
      expr: subcategory
      comment: "Subcategory of the asset for granular classification within a category."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the asset (e.g., Active, End-of-Life, Disposed) for replacement planning."
    - name: "condition_rating"
      expr: condition_rating
      comment: "Physical condition rating of the asset — drives maintenance prioritization and replacement decisions."
    - name: "ada_compliant"
      expr: ada_compliant
      comment: "Whether the asset is ADA compliant — tracks accessibility compliance across the asset portfolio."
    - name: "energy_star_certified"
      expr: energy_star_certified
      comment: "Whether the asset is ENERGY STAR certified — tracks energy efficiency of the equipment portfolio."
    - name: "hazardous_material_indicator"
      expr: hazardous_material_indicator
      comment: "Whether the asset contains hazardous materials — required for EHS compliance and disposal planning."
    - name: "criticality_level"
      expr: criticality_level
      comment: "Criticality classification of the asset (e.g., Mission Critical, Important, Non-Critical) for maintenance prioritization."
  measures:
    - name: "total_assets"
      expr: COUNT(1)
      comment: "Total number of assets in the inventory. Baseline for asset portfolio sizing and tracking."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total historical acquisition cost of all assets. Represents the total capital invested in the physical asset base."
    - name: "total_replacement_cost"
      expr: SUM(CAST(replacement_cost AS DOUBLE))
      comment: "Total current replacement cost of all assets. The primary metric for insurance adequacy and capital reinvestment planning."
    - name: "avg_replacement_cost_per_asset"
      expr: AVG(CAST(replacement_cost AS DOUBLE))
      comment: "Average replacement cost per asset. Benchmarks asset value and informs replacement reserve fund sizing."
    - name: "hazardous_asset_count"
      expr: COUNT(CASE WHEN hazardous_material_indicator = TRUE THEN 1 END)
      comment: "Number of assets containing hazardous materials. Required for EHS compliance reporting and disposal cost forecasting."
    - name: "energy_star_certified_asset_count"
      expr: COUNT(CASE WHEN energy_star_certified = TRUE THEN 1 END)
      comment: "Number of ENERGY STAR certified assets. Tracks energy efficiency of the equipment portfolio against sustainability goals."
    - name: "end_of_life_asset_count"
      expr: COUNT(CASE WHEN lifecycle_status IN ('End-of-Life', 'Disposed', 'Retired') THEN 1 END)
      comment: "Number of assets at or past end-of-life. Drives capital replacement budget requests and risk mitigation planning."
    - name: "total_replacement_cost_end_of_life"
      expr: SUM(CASE WHEN lifecycle_status IN ('End-of-Life', 'Disposed', 'Retired') THEN CAST(replacement_cost AS DOUBLE) ELSE 0 END)
      comment: "Total replacement cost of end-of-life assets. Quantifies the capital investment required to refresh the aging asset base."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`facility_space_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Space assignment portfolio KPIs — assigned square footage, chargeback revenue, occupancy rates, and compliance flags — used by space planners, research administrators, and CFOs to optimize space allocation and recover costs."
  source: "`education_ecm`.`facility`.`space_assignment`"
  dimensions:
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of space assignment (e.g., Academic, Research, Administrative, Residential) for space-use category analysis."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the assignment (e.g., Active, Expired, Pending) for active portfolio tracking."
    - name: "assignment_priority"
      expr: assignment_priority
      comment: "Priority level of the assignment — used to resolve space conflicts and prioritize allocations."
    - name: "ficm_room_use_code"
      expr: ficm_room_use_code
      comment: "FICM (Facilities Inventory and Classification Manual) room use code — the federal standard for space classification in higher education reporting."
    - name: "ipeds_reportable_flag"
      expr: ipeds_reportable_flag
      comment: "Whether the assignment is reportable to IPEDS — filters space data for federal compliance reporting."
    - name: "accreditation_reportable_flag"
      expr: accreditation_reportable_flag
      comment: "Whether the assignment is reportable for accreditation purposes — tracks space adequacy for accreditation self-studies."
    - name: "hazardous_materials_flag"
      expr: hazardous_materials_flag
      comment: "Whether the assigned space involves hazardous materials — required for EHS compliance and regulatory reporting."
    - name: "animal_research_flag"
      expr: animal_research_flag
      comment: "Whether the space is used for animal research — tracks IACUC-regulated space for compliance reporting."
  measures:
    - name: "total_space_assignments"
      expr: COUNT(1)
      comment: "Total number of space assignments. Baseline for space allocation portfolio management."
    - name: "total_assigned_square_footage"
      expr: SUM(CAST(assigned_square_footage AS DOUBLE))
      comment: "Total square footage assigned across all active assignments. Core space utilization metric for FICM/IPEDS reporting."
    - name: "avg_assigned_square_footage_per_assignment"
      expr: AVG(CAST(assigned_square_footage AS DOUBLE))
      comment: "Average square footage per assignment. Benchmarks space allocation equity and identifies over- or under-allocated units."
    - name: "total_annual_chargeback_amount"
      expr: SUM(CAST(annual_chargeback_amount AS DOUBLE))
      comment: "Total annual chargeback revenue from space assignments. Tracks cost recovery from departments and grants for space usage."
    - name: "avg_occupancy_percentage"
      expr: AVG(CAST(occupancy_percentage AS DOUBLE))
      comment: "Average occupancy percentage across all assignments. A low average signals underutilized space that could be reallocated or consolidated."
    - name: "avg_chargeback_rate"
      expr: AVG(CAST(chargeback_rate AS DOUBLE))
      comment: "Average chargeback rate per square foot. Benchmarks space pricing against market rates and cost recovery targets."
    - name: "unique_rooms_assigned"
      expr: COUNT(DISTINCT room_id)
      comment: "Number of distinct rooms with active assignments. Measures the breadth of assigned space across the portfolio."
    - name: "renewal_required_assignment_count"
      expr: COUNT(CASE WHEN renewal_required_flag = TRUE THEN 1 END)
      comment: "Number of assignments requiring renewal. Drives proactive space review workflows to prevent unauthorized holdovers."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`facility_pm_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance schedule KPIs — cost estimates, labor planning, compliance coverage, and schedule health — used by facilities managers to optimize PM programs and control deferred maintenance risk."
  source: "`education_ecm`.`facility`.`pm_schedule`"
  dimensions:
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of PM schedule (e.g., Time-Based, Meter-Based, Condition-Based) for maintenance strategy analysis."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the PM schedule (e.g., Active, Inactive, Suspended) for active program tracking."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the PM task — used to sequence maintenance activities and allocate resources."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Regulatory or compliance category driving the PM requirement (e.g., Fire Safety, OSHA, EPA) — tracks compliance-driven maintenance."
    - name: "frequency_type"
      expr: frequency_type
      comment: "Frequency type of the PM schedule (e.g., Daily, Weekly, Monthly, Annual) for workload distribution analysis."
    - name: "required_trade_skill"
      expr: required_trade_skill
      comment: "Trade skill required to execute the PM task — informs workforce planning and skill gap analysis."
    - name: "deferred_maintenance_eligible"
      expr: deferred_maintenance_eligible
      comment: "Whether the PM task is eligible for deferral — tracks deferred maintenance risk accumulation."
    - name: "warranty_related"
      expr: warranty_related
      comment: "Whether the PM task is required to maintain a warranty — tracks warranty compliance to protect cost recovery rights."
  measures:
    - name: "total_pm_schedules"
      expr: COUNT(1)
      comment: "Total number of PM schedules in the program. Baseline for PM program scope and coverage analysis."
    - name: "total_estimated_labor_cost"
      expr: SUM(CAST(estimated_labor_cost AS DOUBLE))
      comment: "Total estimated labor cost across all PM schedules. Drives annual PM labor budget planning."
    - name: "total_estimated_material_cost"
      expr: SUM(CAST(estimated_material_cost AS DOUBLE))
      comment: "Total estimated material cost across all PM schedules. Informs parts and supplies procurement planning."
    - name: "total_estimated_labor_hours"
      expr: SUM(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Total estimated labor hours across all PM schedules. Drives workforce capacity planning for the PM program."
    - name: "avg_estimated_labor_hours_per_schedule"
      expr: AVG(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Average estimated labor hours per PM schedule. Benchmarks task complexity and informs scheduling efficiency."
    - name: "total_estimated_downtime_hours"
      expr: SUM(CAST(estimated_downtime_hours AS DOUBLE))
      comment: "Total estimated downtime hours from PM activities. Quantifies planned operational disruption for academic and research scheduling."
    - name: "compliance_driven_schedule_count"
      expr: COUNT(CASE WHEN compliance_category IS NOT NULL AND compliance_category <> '' THEN 1 END)
      comment: "Number of PM schedules driven by regulatory compliance requirements. Tracks the compliance-mandated maintenance workload."
    - name: "warranty_related_schedule_count"
      expr: COUNT(CASE WHEN warranty_related = TRUE THEN 1 END)
      comment: "Number of PM schedules required to maintain active warranties. Ensures warranty obligations are tracked to protect cost recovery rights."
$$;