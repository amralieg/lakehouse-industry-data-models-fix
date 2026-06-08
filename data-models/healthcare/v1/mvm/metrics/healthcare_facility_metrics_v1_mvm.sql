-- Metric views for domain: facility | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 18:58:55

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`facility_bed`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational bed inventory and capability metrics. Tracks bed availability, staffing status, isolation capacity, and special-capability coverage to support capacity planning, patient placement, and infection control decisions."
  source: "`healthcare_ecm`.`facility`.`bed`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site identifier — enables analysis of bed metrics by hospital or clinic location."
    - name: "unit_id"
      expr: unit_id
      comment: "Clinical unit identifier — supports bed capacity analysis at the nursing unit level."
    - name: "bed_type"
      expr: bed_type
      comment: "Type of bed (e.g., ICU, Med-Surg, Step-Down) — key dimension for capacity mix analysis."
    - name: "bed_category"
      expr: bed_category
      comment: "Broad category of the bed — supports grouping for capacity planning and reporting."
    - name: "bed_status"
      expr: bed_status
      comment: "Current operational status of the bed (e.g., Available, Occupied, Dirty, Out of Service) — primary dimension for real-time capacity dashboards."
    - name: "is_active"
      expr: is_active
      comment: "Whether the bed is currently active in the inventory — filters out decommissioned beds."
    - name: "is_licensed"
      expr: is_licensed
      comment: "Whether the bed holds a valid license — critical for regulatory compliance reporting."
    - name: "is_staffed"
      expr: is_staffed
      comment: "Whether the bed is currently staffed — key driver of effective capacity vs. licensed capacity."
    - name: "is_isolation_capable"
      expr: is_isolation_capable
      comment: "Whether the bed supports isolation protocols — essential for infection control capacity planning."
    - name: "is_negative_pressure_room"
      expr: is_negative_pressure_room
      comment: "Whether the bed is in a negative pressure room — critical for airborne infection management."
    - name: "is_telemetry_capable"
      expr: is_telemetry_capable
      comment: "Whether the bed supports telemetry monitoring — informs cardiac and step-down unit capacity."
    - name: "is_bariatric_capable"
      expr: is_bariatric_capable
      comment: "Whether the bed is bariatric-capable — supports specialized patient placement decisions."
    - name: "gender_restriction"
      expr: gender_restriction
      comment: "Gender restriction applied to the bed — used for patient placement compliance."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the bed became effective — supports trend analysis of bed inventory growth."
  measures:
    - name: "total_beds"
      expr: COUNT(1)
      comment: "Total number of beds in the inventory. Baseline capacity measure used in all bed utilization and availability calculations."
    - name: "licensed_beds"
      expr: COUNT(CASE WHEN is_licensed = TRUE THEN 1 END)
      comment: "Number of licensed beds. Regulatory baseline — licensed bed count is the denominator for CMS and state licensure compliance reporting."
    - name: "staffed_beds"
      expr: COUNT(CASE WHEN is_staffed = TRUE THEN 1 END)
      comment: "Number of currently staffed beds. Effective operational capacity — the gap between licensed and staffed beds signals staffing shortfalls that constrain patient throughput."
    - name: "available_beds"
      expr: COUNT(CASE WHEN bed_status = 'Available' THEN 1 END)
      comment: "Number of beds currently in Available status. Real-time capacity signal used by bed management and patient placement teams to prevent boarding and diversion."
    - name: "occupied_beds"
      expr: COUNT(CASE WHEN bed_status = 'Occupied' THEN 1 END)
      comment: "Number of beds currently occupied. Core census metric used in daily operations, staffing ratios, and capacity forecasting."
    - name: "out_of_service_beds"
      expr: COUNT(CASE WHEN bed_status = 'Out of Service' THEN 1 END)
      comment: "Number of beds currently out of service. Tracks capacity loss due to maintenance or equipment issues — high values trigger facilities and operations intervention."
    - name: "isolation_capable_beds"
      expr: COUNT(CASE WHEN is_isolation_capable = TRUE THEN 1 END)
      comment: "Number of isolation-capable beds. Critical for infection control capacity planning, especially during outbreak or pandemic conditions."
    - name: "negative_pressure_beds"
      expr: COUNT(CASE WHEN is_negative_pressure_room = TRUE THEN 1 END)
      comment: "Number of beds in negative pressure rooms. Airborne infection isolation capacity — a key metric for infection prevention and regulatory compliance."
    - name: "telemetry_capable_beds"
      expr: COUNT(CASE WHEN is_telemetry_capable = TRUE THEN 1 END)
      comment: "Number of telemetry-capable beds. Informs cardiac monitoring capacity and step-down unit planning."
    - name: "bariatric_capable_beds"
      expr: COUNT(CASE WHEN is_bariatric_capable = TRUE THEN 1 END)
      comment: "Number of bariatric-capable beds. Supports specialized patient placement and capital planning for bariatric program growth."
    - name: "avg_weight_capacity_lbs"
      expr: AVG(CAST(weight_capacity_lbs AS DOUBLE))
      comment: "Average weight capacity in pounds across beds. Informs bariatric readiness and equipment procurement decisions."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`facility_bed_status_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bed status transition event metrics. Tracks bed turnover velocity, emergency vs. elective demand, isolation usage, and ADT event patterns to optimize patient flow, reduce boarding, and improve bed management efficiency."
  source: "`healthcare_ecm`.`facility`.`bed_status_event`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where the bed status event occurred — enables site-level patient flow benchmarking."
    - name: "bed_id"
      expr: bed_id
      comment: "Specific bed involved in the status event — supports bed-level turnover and utilization analysis."
    - name: "new_status_code"
      expr: new_status_code
      comment: "The status the bed transitioned to — key dimension for tracking flow through Available, Occupied, Dirty, and Out-of-Service states."
    - name: "prior_status_code"
      expr: prior_status_code
      comment: "The status the bed transitioned from — enables transition-pair analysis (e.g., Occupied → Dirty turnaround time)."
    - name: "adt_event_type"
      expr: adt_event_type
      comment: "Type of ADT event driving the status change (Admit, Discharge, Transfer) — core dimension for patient flow analysis."
    - name: "acuity_level"
      expr: acuity_level
      comment: "Patient acuity level at time of event — supports demand-weighted capacity planning."
    - name: "isolation_type"
      expr: isolation_type
      comment: "Type of isolation required — tracks isolation demand patterns for infection control planning."
    - name: "is_emergency_flag"
      expr: is_emergency_flag
      comment: "Whether the event was driven by an emergency admission — separates planned vs. unplanned demand."
    - name: "is_elective_flag"
      expr: is_elective_flag
      comment: "Whether the event was driven by an elective admission — supports surgical schedule and capacity coordination."
    - name: "priority_flag"
      expr: priority_flag
      comment: "Whether the event was flagged as high priority — used to track urgent bed placement requests."
    - name: "initiating_user_role"
      expr: initiating_user_role
      comment: "Role of the user who initiated the status change — supports workflow accountability and process improvement."
    - name: "event_date_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of the bed status event — enables trend analysis of bed demand and turnover over time."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the status change — supports root cause analysis of bed blocks and delays."
    - name: "blocked_reason_category"
      expr: blocked_reason_category
      comment: "Category of reason a bed was blocked — key dimension for identifying systemic capacity constraints."
  measures:
    - name: "total_bed_status_events"
      expr: COUNT(1)
      comment: "Total number of bed status change events. Baseline volume metric for patient flow activity — high event counts indicate high throughput or high churn."
    - name: "emergency_events"
      expr: COUNT(CASE WHEN is_emergency_flag = TRUE THEN 1 END)
      comment: "Number of bed status events driven by emergency admissions. Tracks unplanned demand pressure on bed inventory — a key input to ED boarding and diversion analysis."
    - name: "elective_events"
      expr: COUNT(CASE WHEN is_elective_flag = TRUE THEN 1 END)
      comment: "Number of bed status events driven by elective admissions. Supports surgical schedule optimization and planned capacity management."
    - name: "priority_events"
      expr: COUNT(CASE WHEN priority_flag = TRUE THEN 1 END)
      comment: "Number of high-priority bed placement events. Tracks urgent placement demand — elevated counts signal capacity stress requiring immediate management response."
    - name: "isolation_events"
      expr: COUNT(CASE WHEN isolation_type IS NOT NULL AND isolation_type <> '' THEN 1 END)
      comment: "Number of events requiring isolation placement. Tracks infection control demand on specialized bed inventory — critical for outbreak preparedness."
    - name: "unique_beds_with_events"
      expr: COUNT(DISTINCT bed_id)
      comment: "Number of distinct beds that had a status change event. Measures breadth of bed activity — low values relative to total beds may indicate underutilized inventory."
    - name: "unique_visits_with_events"
      expr: COUNT(DISTINCT visit_id)
      comment: "Number of distinct patient visits associated with bed status events. Proxy for patient throughput volume through the bed management process."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`facility_building`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical building portfolio metrics. Tracks facility footprint, financial exposure, infrastructure capability, and compliance status to support capital planning, risk management, and regulatory reporting."
  source: "`healthcare_ecm`.`facility`.`building`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site the building belongs to — enables building metrics to be rolled up to the facility level."
    - name: "building_type"
      expr: building_type
      comment: "Type of building (e.g., Inpatient Tower, MOB, Outpatient Clinic) — key dimension for portfolio segmentation."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the building — filters active vs. inactive facilities for capacity and cost analysis."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Whether the building is owned, leased, or operated under another arrangement — drives capital vs. operating expense classification."
    - name: "leed_certification_level"
      expr: leed_certification_level
      comment: "LEED sustainability certification level — supports ESG reporting and energy efficiency benchmarking."
    - name: "joint_commission_accreditation_status"
      expr: joint_commission_accreditation_status
      comment: "Joint Commission accreditation status — critical compliance dimension for regulatory and payer reporting."
    - name: "fire_safety_classification"
      expr: fire_safety_classification
      comment: "Fire safety classification of the building — used in life safety compliance reporting."
    - name: "helipad_available"
      expr: helipad_available
      comment: "Whether the building has a helipad — relevant for trauma center capability and emergency transport planning."
    - name: "state_province"
      expr: state_province
      comment: "State or province where the building is located — enables geographic portfolio analysis."
    - name: "city"
      expr: city
      comment: "City where the building is located — supports local market capacity and access analysis."
    - name: "effective_date_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the building became effective — supports portfolio age and capital reinvestment cycle analysis."
  measures:
    - name: "total_buildings"
      expr: COUNT(1)
      comment: "Total number of buildings in the portfolio. Baseline footprint metric used in capital planning, real estate strategy, and operational cost allocation."
    - name: "total_gross_square_footage"
      expr: SUM(CAST(gross_square_footage AS DOUBLE))
      comment: "Total gross square footage across all buildings. Core real estate portfolio size metric — drives space utilization, lease cost, and capital reinvestment planning."
    - name: "total_net_usable_square_footage"
      expr: SUM(CAST(net_usable_square_footage AS DOUBLE))
      comment: "Total net usable square footage. Effective clinical and operational space — the gap between gross and net usable footage reveals inefficiency in space design."
    - name: "avg_gross_square_footage"
      expr: AVG(CAST(gross_square_footage AS DOUBLE))
      comment: "Average gross square footage per building. Benchmarks building size across the portfolio — outliers may indicate over- or under-built facilities."
    - name: "total_replacement_value"
      expr: SUM(CAST(replacement_value_amount AS DOUBLE))
      comment: "Total replacement value of all buildings. Key input to insurance adequacy, capital reserve planning, and risk management decisions."
    - name: "total_annual_property_tax"
      expr: SUM(CAST(annual_property_tax_amount AS DOUBLE))
      comment: "Total annual property tax liability across the building portfolio. Directly impacts operating cost structure and informs real estate ownership vs. lease decisions."
    - name: "total_emergency_generator_capacity_kw"
      expr: SUM(CAST(emergency_generator_capacity_kw AS DOUBLE))
      comment: "Total emergency generator capacity in kilowatts. Measures resilience of the facility portfolio — insufficient backup power is a life safety and regulatory risk."
    - name: "buildings_with_helipad"
      expr: COUNT(CASE WHEN helipad_available = TRUE THEN 1 END)
      comment: "Number of buildings with a helipad. Tracks trauma and emergency transport capability across the portfolio — relevant for trauma center designation and network planning."
    - name: "buildings_accredited_joint_commission"
      expr: COUNT(CASE WHEN joint_commission_accreditation_status = 'Accredited' THEN 1 END)
      comment: "Number of buildings with active Joint Commission accreditation. Compliance coverage metric — unaccredited buildings may face payer contract and regulatory risks."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`facility_care_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care site network metrics. Tracks facility capabilities, compliance status, geographic coverage, and operational readiness across the care delivery network to support network strategy, regulatory compliance, and payer contracting decisions."
  source: "`healthcare_ecm`.`facility`.`care_site`"
  dimensions:
    - name: "organization_id"
      expr: organization_id
      comment: "Parent organization — enables care site metrics to roll up to the health system level."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of care site (e.g., Hospital, Clinic, ASC, SNF) — primary dimension for network segmentation and service mix analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the care site — filters active vs. inactive sites for network capacity analysis."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership structure of the care site — informs capital allocation and governance decisions."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the organizational hierarchy — supports rollup and drill-down in network reporting."
    - name: "state"
      expr: state
      comment: "State where the care site is located — enables geographic network coverage and regulatory jurisdiction analysis."
    - name: "city"
      expr: city
      comment: "City where the care site is located — supports local market access and community health planning."
    - name: "trauma_level"
      expr: trauma_level
      comment: "Trauma center designation level — key capability dimension for network adequacy and emergency care planning."
    - name: "teaching_status"
      expr: teaching_status
      comment: "Whether the care site is a teaching facility — relevant for GME funding, research capacity, and workforce pipeline planning."
    - name: "critical_access_hospital"
      expr: critical_access_hospital
      comment: "Whether the site is designated as a Critical Access Hospital — drives Medicare reimbursement methodology and rural health strategy."
    - name: "emergency_services_available"
      expr: emergency_services_available
      comment: "Whether emergency services are available — core network adequacy dimension for payer contracting and community benefit reporting."
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Current accreditation status — compliance dimension for regulatory and payer reporting."
    - name: "licensure_status"
      expr: licensure_status
      comment: "Current licensure status — critical compliance dimension; unlicensed sites cannot bill or operate legally."
    - name: "go_live_date_year"
      expr: DATE_TRUNC('YEAR', go_live_date)
      comment: "Year the care site went live — supports network growth trend analysis."
  measures:
    - name: "total_care_sites"
      expr: COUNT(1)
      comment: "Total number of care sites in the network. Baseline network size metric used in market coverage, access, and growth strategy reporting."
    - name: "active_care_sites"
      expr: COUNT(CASE WHEN operational_status = 'Active' THEN 1 END)
      comment: "Number of operationally active care sites. Effective network size — the gap between total and active sites reveals inactive or transitional capacity."
    - name: "care_sites_with_emergency_services"
      expr: COUNT(CASE WHEN emergency_services_available = TRUE THEN 1 END)
      comment: "Number of care sites offering emergency services. Network emergency coverage metric — critical for payer network adequacy standards and community health access reporting."
    - name: "critical_access_hospitals"
      expr: COUNT(CASE WHEN critical_access_hospital = TRUE THEN 1 END)
      comment: "Number of Critical Access Hospital designations in the network. Tracks rural health footprint and associated Medicare cost-based reimbursement exposure."
    - name: "teaching_facilities"
      expr: COUNT(CASE WHEN teaching_status = TRUE THEN 1 END)
      comment: "Number of teaching facilities. Tracks GME capacity, research infrastructure, and workforce pipeline assets across the network."
    - name: "accredited_care_sites"
      expr: COUNT(CASE WHEN accreditation_status = 'Accredited' THEN 1 END)
      comment: "Number of accredited care sites. Compliance coverage metric — unaccredited sites risk payer contract termination and regulatory sanctions."
    - name: "care_sites_with_active_license"
      expr: COUNT(CASE WHEN licensure_status = 'Active' THEN 1 END)
      comment: "Number of care sites with an active license. Operational compliance baseline — sites without active licensure cannot legally provide or bill for services."
    - name: "disproportionate_share_hospitals"
      expr: COUNT(CASE WHEN disproportionate_share_hospital = TRUE THEN 1 END)
      comment: "Number of Disproportionate Share Hospital (DSH) designations. Tracks safety-net hospital exposure and associated Medicaid DSH payment eligibility."
    - name: "sole_community_hospitals"
      expr: COUNT(CASE WHEN sole_community_hospital = TRUE THEN 1 END)
      comment: "Number of Sole Community Hospital designations. Tracks rural and isolated market positions with special Medicare payment protections."
    - name: "unique_states_covered"
      expr: COUNT(DISTINCT state)
      comment: "Number of distinct states in which the network operates. Geographic footprint metric — drives multi-state licensure, regulatory, and payer contracting complexity."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`facility_equipment_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical equipment asset lifecycle and compliance metrics. Tracks acquisition cost, preventive maintenance compliance, recall exposure, and operational status to support capital planning, patient safety, and regulatory compliance decisions."
  source: "`healthcare_ecm`.`facility`.`equipment_asset`"
  dimensions:
    - name: "current_location_care_site_id"
      expr: current_location_care_site_id
      comment: "Care site where the equipment is currently located — enables site-level asset inventory and compliance analysis."
    - name: "unit_id"
      expr: unit_id
      comment: "Clinical unit where the equipment is deployed — supports unit-level asset management and PM scheduling."
    - name: "equipment_category"
      expr: equipment_category
      comment: "Category of equipment (e.g., Imaging, Infusion, Monitoring) — primary dimension for capital planning and maintenance budgeting."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Specific type of equipment — supports granular asset tracking and procurement decisions."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the equipment — identifies active, inactive, and retired assets."
    - name: "manufacturer"
      expr: manufacturer
      comment: "Equipment manufacturer — supports vendor performance analysis and recall risk concentration assessment."
    - name: "fda_device_class"
      expr: fda_device_class
      comment: "FDA device classification (Class I, II, III) — risk stratification dimension for regulatory compliance and patient safety reporting."
    - name: "recall_status"
      expr: recall_status
      comment: "Current recall status of the equipment — critical patient safety dimension; active recalls require immediate action."
    - name: "pm_compliance_status"
      expr: pm_compliance_status
      comment: "Preventive maintenance compliance status — key quality and regulatory dimension for Joint Commission and CMS compliance."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category of the equipment — supports risk-stratified maintenance prioritization."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied — relevant for financial reporting and capital replacement planning."
    - name: "acquisition_date_year"
      expr: DATE_TRUNC('YEAR', acquisition_date)
      comment: "Year of equipment acquisition — supports capital vintage analysis and replacement cycle planning."
  measures:
    - name: "total_equipment_assets"
      expr: COUNT(1)
      comment: "Total number of equipment assets in the inventory. Baseline asset count used in capital planning, maintenance budgeting, and regulatory reporting."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of all equipment assets. Capital investment baseline — drives depreciation schedules, insurance valuation, and replacement reserve planning."
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per equipment asset. Benchmarks capital intensity by equipment category — informs procurement strategy and budget forecasting."
    - name: "assets_with_active_recall"
      expr: COUNT(CASE WHEN recall_status IS NOT NULL AND recall_status <> '' AND recall_status <> 'No Recall' THEN 1 END)
      comment: "Number of equipment assets with an active recall. Patient safety KPI — any non-zero value requires immediate clinical engineering and risk management response."
    - name: "pm_compliant_assets"
      expr: COUNT(CASE WHEN pm_compliance_status = 'Compliant' THEN 1 END)
      comment: "Number of assets currently compliant with preventive maintenance schedules. Joint Commission and CMS compliance metric — non-compliant assets create regulatory and patient safety risk."
    - name: "pm_overdue_assets"
      expr: COUNT(CASE WHEN pm_compliance_status = 'Overdue' THEN 1 END)
      comment: "Number of assets with overdue preventive maintenance. Operational risk metric — overdue PM on high-risk devices can result in equipment failure, patient harm, and regulatory citations."
    - name: "calibration_required_assets"
      expr: COUNT(CASE WHEN calibration_required_flag = TRUE THEN 1 END)
      comment: "Number of assets requiring calibration. Tracks the scope of calibration compliance obligations — relevant for diagnostic accuracy and regulatory standards."
    - name: "active_operational_assets"
      expr: COUNT(CASE WHEN operational_status = 'Active' THEN 1 END)
      comment: "Number of equipment assets in active operational status. Effective deployed asset count — the gap between total and active assets reveals idle or retired inventory."
    - name: "unique_manufacturers"
      expr: COUNT(DISTINCT manufacturer)
      comment: "Number of distinct equipment manufacturers in the portfolio. Vendor concentration metric — high concentration increases recall and supply chain risk."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`facility_maintenance_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility and equipment maintenance order metrics. Tracks maintenance cost, labor efficiency, downtime, safety incidents, and vendor utilization to support facilities management, capital planning, and regulatory compliance decisions."
  source: "`healthcare_ecm`.`facility`.`maintenance_order`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where the maintenance work was performed — enables site-level maintenance cost and compliance benchmarking."
    - name: "building_id"
      expr: building_id
      comment: "Building where the maintenance work was performed — supports building-level lifecycle cost analysis."
    - name: "equipment_asset_id"
      expr: equipment_asset_id
      comment: "Equipment asset the maintenance order is associated with — enables asset-level maintenance history and cost tracking."
    - name: "order_type"
      expr: order_type
      comment: "Type of maintenance order (e.g., Preventive, Corrective, Emergency) — key dimension for planned vs. reactive maintenance ratio analysis."
    - name: "order_status"
      expr: order_status
      comment: "Current status of the maintenance order (e.g., Open, In Progress, Completed) — tracks work order backlog and completion rates."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the maintenance order — supports triage and resource allocation for maintenance backlog management."
    - name: "trade_type"
      expr: trade_type
      comment: "Trade type required for the work (e.g., Electrical, HVAC, Plumbing) — supports workforce planning and contractor management."
    - name: "regulatory_driver"
      expr: regulatory_driver
      comment: "Regulatory requirement driving the maintenance (e.g., Joint Commission, CMS, NFPA) — tracks compliance-driven maintenance volume and cost."
    - name: "vendor_service_flag"
      expr: vendor_service_flag
      comment: "Whether the work was performed by an external vendor — supports make-vs-buy analysis for maintenance services."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Whether the maintenance order was associated with a safety incident — critical patient and staff safety dimension."
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Whether the order resulted in a warranty claim — tracks warranty recovery and vendor accountability."
    - name: "request_date_month"
      expr: DATE_TRUNC('MONTH', request_datetime)
      comment: "Month the maintenance order was requested — enables trend analysis of maintenance demand and backlog growth."
  measures:
    - name: "total_maintenance_orders"
      expr: COUNT(1)
      comment: "Total number of maintenance orders. Baseline workload metric for facilities management — tracks maintenance demand volume and backlog trends."
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all maintenance orders including labor and parts. Primary financial KPI for facilities management — drives budget planning, cost benchmarking, and outsourcing decisions."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost across all maintenance orders. Workforce cost component — used to benchmark internal vs. vendor labor efficiency."
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total parts and materials cost across all maintenance orders. Supply chain cost component — informs parts inventory strategy and vendor contract negotiations."
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labor hours expended on maintenance orders. Workforce capacity metric — used to size maintenance teams and evaluate productivity."
    - name: "avg_labor_cost_per_order"
      expr: AVG(CAST(labor_cost AS DOUBLE))
      comment: "Average labor cost per maintenance order. Efficiency benchmark — rising averages may indicate skill mix issues, overtime, or vendor rate escalation."
    - name: "avg_total_cost_per_order"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average total cost per maintenance order. Cost efficiency KPI — benchmarks maintenance spend intensity and informs service contract vs. time-and-materials decisions."
    - name: "safety_incident_orders"
      expr: COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END)
      comment: "Number of maintenance orders associated with a safety incident. Patient and staff safety KPI — any non-zero value requires root cause analysis and corrective action."
    - name: "vendor_service_orders"
      expr: COUNT(CASE WHEN vendor_service_flag = TRUE THEN 1 END)
      comment: "Number of maintenance orders fulfilled by external vendors. Outsourcing volume metric — used to evaluate vendor dependency and contract utilization."
    - name: "warranty_claim_orders"
      expr: COUNT(CASE WHEN warranty_claim_flag = TRUE THEN 1 END)
      comment: "Number of maintenance orders resulting in warranty claims. Warranty recovery metric — tracks cost avoidance from vendor warranty utilization."
    - name: "completed_orders"
      expr: COUNT(CASE WHEN order_status = 'Completed' THEN 1 END)
      comment: "Number of completed maintenance orders. Throughput metric — used with total orders to calculate completion rate and backlog clearance velocity."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`facility_or_suite`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operating room suite capability and compliance metrics. Tracks OR inventory, specialized surgical capabilities, accreditation status, and infrastructure readiness to support surgical program planning, capacity management, and regulatory compliance."
  source: "`healthcare_ecm`.`facility`.`or_suite`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where the OR suite is located — enables site-level surgical capacity benchmarking."
    - name: "unit_id"
      expr: unit_id
      comment: "Clinical unit the OR suite belongs to — supports perioperative unit-level capacity analysis."
    - name: "or_type"
      expr: or_type
      comment: "Type of OR suite (e.g., General, Cardiac, Neuro, Hybrid) — primary dimension for surgical service line capacity planning."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the OR suite — identifies active, inactive, and under-renovation suites."
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Accreditation status of the OR suite — compliance dimension for surgical program certification and payer contracting."
    - name: "robotic_surgery_compatible_flag"
      expr: robotic_surgery_compatible_flag
      comment: "Whether the OR suite supports robotic surgery — tracks advanced surgical technology capacity for program development decisions."
    - name: "pediatric_capable_flag"
      expr: pediatric_capable_flag
      comment: "Whether the OR suite is pediatric-capable — supports pediatric surgical program capacity planning."
    - name: "isolation_capable_flag"
      expr: isolation_capable_flag
      comment: "Whether the OR suite supports isolation procedures — infection control capacity for immunocompromised and infectious patients."
    - name: "emergency_use_flag"
      expr: emergency_use_flag
      comment: "Whether the OR suite is designated for emergency use — tracks emergency surgical capacity."
    - name: "video_integration_capability_flag"
      expr: video_integration_capability_flag
      comment: "Whether the OR suite has video integration — supports telemedicine, training, and advanced surgical program capabilities."
    - name: "laminar_airflow_class"
      expr: laminar_airflow_class
      comment: "Laminar airflow classification — infection control infrastructure dimension relevant for orthopedic and transplant programs."
  measures:
    - name: "total_or_suites"
      expr: COUNT(1)
      comment: "Total number of OR suites in the portfolio. Baseline surgical capacity metric used in service line planning, scheduling optimization, and capital investment decisions."
    - name: "active_or_suites"
      expr: COUNT(CASE WHEN operational_status = 'Active' THEN 1 END)
      comment: "Number of operationally active OR suites. Effective surgical capacity — the gap between total and active suites reveals capacity lost to renovation, maintenance, or decommissioning."
    - name: "robotic_surgery_suites"
      expr: COUNT(CASE WHEN robotic_surgery_compatible_flag = TRUE THEN 1 END)
      comment: "Number of OR suites compatible with robotic surgery. Advanced surgical technology capacity metric — drives capital investment decisions for robotic program expansion."
    - name: "emergency_or_suites"
      expr: COUNT(CASE WHEN emergency_use_flag = TRUE THEN 1 END)
      comment: "Number of OR suites designated for emergency use. Emergency surgical capacity metric — critical for trauma center designation and emergency preparedness planning."
    - name: "pediatric_capable_suites"
      expr: COUNT(CASE WHEN pediatric_capable_flag = TRUE THEN 1 END)
      comment: "Number of pediatric-capable OR suites. Pediatric surgical program capacity — informs service line development and network adequacy for pediatric care."
    - name: "isolation_capable_suites"
      expr: COUNT(CASE WHEN isolation_capable_flag = TRUE THEN 1 END)
      comment: "Number of isolation-capable OR suites. Infection control surgical capacity — required for immunocompromised patients and infectious disease cases."
    - name: "total_or_floor_area_sqft"
      expr: SUM(CAST(room_length_feet AS DOUBLE) * CAST(room_width_feet AS DOUBLE))
      comment: "Total calculated floor area of OR suites in square feet (length × width). Physical capacity metric — larger suites accommodate more complex equipment configurations for advanced surgical programs."
    - name: "avg_or_room_height_feet"
      expr: AVG(CAST(room_height_feet AS DOUBLE))
      comment: "Average ceiling height of OR suites in feet. Infrastructure adequacy metric — minimum heights are required for robotic systems, imaging equipment, and boom configurations."
    - name: "accredited_or_suites"
      expr: COUNT(CASE WHEN accreditation_status = 'Accredited' THEN 1 END)
      comment: "Number of accredited OR suites. Compliance coverage metric — unaccredited suites may be ineligible for certain payer reimbursements and surgical program certifications."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`facility_license_accreditation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility license and accreditation compliance metrics. Tracks credential coverage, expiration risk, survey outcomes, and plan of correction status to support regulatory compliance, payer contracting, and risk management decisions."
  source: "`healthcare_ecm`.`facility`.`license_accreditation`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site the credential applies to — enables site-level compliance portfolio analysis."
    - name: "building_id"
      expr: building_id
      comment: "Building the credential applies to — supports building-level license and accreditation tracking."
    - name: "unit_id"
      expr: unit_id
      comment: "Clinical unit the credential applies to — enables unit-level accreditation compliance monitoring."
    - name: "credential_type"
      expr: credential_type
      comment: "Type of credential (e.g., License, Accreditation, Certification) — primary dimension for compliance portfolio segmentation."
    - name: "license_accreditation_status"
      expr: license_accreditation_status
      comment: "Current status of the license or accreditation — identifies active, expired, suspended, and pending credentials."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the credential (e.g., Joint Commission, CMS, State DOH) — supports regulator-specific compliance reporting."
    - name: "deemed_status_flag"
      expr: deemed_status_flag
      comment: "Whether the credential confers deemed status for Medicare/Medicaid — critical for CMS billing eligibility."
    - name: "payer_contract_requirement_flag"
      expr: payer_contract_requirement_flag
      comment: "Whether the credential is required by a payer contract — tracks credentials whose lapse would trigger contract termination."
    - name: "survey_outcome"
      expr: survey_outcome
      comment: "Outcome of the most recent accreditation survey — tracks pass/fail/conditional results for compliance trend analysis."
    - name: "expiration_date_year"
      expr: DATE_TRUNC('YEAR', expiration_date)
      comment: "Year the credential expires — supports expiration risk concentration analysis and renewal planning."
  measures:
    - name: "total_credentials"
      expr: COUNT(1)
      comment: "Total number of licenses and accreditations in the compliance portfolio. Baseline compliance inventory metric used in regulatory reporting and risk management."
    - name: "active_credentials"
      expr: COUNT(CASE WHEN license_accreditation_status = 'Active' THEN 1 END)
      comment: "Number of currently active credentials. Compliance coverage metric — the ratio of active to total credentials measures the health of the compliance portfolio."
    - name: "expired_credentials"
      expr: COUNT(CASE WHEN license_accreditation_status = 'Expired' THEN 1 END)
      comment: "Number of expired credentials. Critical compliance risk metric — expired licenses or accreditations can result in billing suspension, regulatory sanctions, and payer contract termination."
    - name: "credentials_with_deficiencies"
      expr: COUNT(CASE WHEN deficiency_count IS NOT NULL AND deficiency_count <> '0' AND deficiency_count <> '' THEN 1 END)
      comment: "Number of credentials with recorded deficiencies from surveys. Quality and compliance risk metric — deficiencies require plans of correction and signal regulatory scrutiny."
    - name: "deemed_status_credentials"
      expr: COUNT(CASE WHEN deemed_status_flag = TRUE THEN 1 END)
      comment: "Number of credentials conferring deemed status. CMS billing eligibility metric — loss of deemed status credentials directly impacts Medicare and Medicaid revenue."
    - name: "payer_required_credentials"
      expr: COUNT(CASE WHEN payer_contract_requirement_flag = TRUE THEN 1 END)
      comment: "Number of credentials required by payer contracts. Contract compliance metric — lapse of payer-required credentials triggers contract termination and revenue loss."
    - name: "credentials_with_plan_of_correction"
      expr: COUNT(CASE WHEN plan_of_correction_submitted_date IS NOT NULL THEN 1 END)
      comment: "Number of credentials with a submitted plan of correction. Regulatory remediation metric — tracks the volume of active compliance remediation obligations."
    - name: "unique_issuing_authorities"
      expr: COUNT(DISTINCT issuing_authority)
      comment: "Number of distinct regulatory authorities issuing credentials. Regulatory complexity metric — higher counts indicate greater multi-regulator compliance management burden."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`facility_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical unit capacity, capability, and compliance metrics. Tracks staffed bed inventory, specialized care capabilities, accreditation status, and operational readiness to support capacity planning, staffing decisions, and regulatory compliance."
  source: "`healthcare_ecm`.`facility`.`unit`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site the unit belongs to — enables site-level unit capacity and capability benchmarking."
    - name: "building_id"
      expr: building_id
      comment: "Building the unit is located in — supports building-level clinical capacity analysis."
    - name: "unit_type"
      expr: unit_type
      comment: "Type of clinical unit (e.g., ICU, Med-Surg, ED, NICU) — primary dimension for capacity mix and service line analysis."
    - name: "unit_status"
      expr: unit_status
      comment: "Current operational status of the unit — filters active vs. inactive units for capacity planning."
    - name: "acuity_level"
      expr: acuity_level
      comment: "Acuity level of the unit — supports demand-weighted capacity planning and staffing ratio analysis."
    - name: "trauma_level"
      expr: trauma_level
      comment: "Trauma designation level of the unit — relevant for trauma center compliance and emergency capacity planning."
    - name: "teaching_unit_flag"
      expr: teaching_unit_flag
      comment: "Whether the unit is a teaching unit — relevant for GME supervision requirements and workforce pipeline planning."
    - name: "magnet_recognition"
      expr: magnet_recognition
      comment: "Whether the unit has Magnet nursing recognition — quality and workforce retention indicator used in nursing excellence reporting."
    - name: "accepts_admissions"
      expr: accepts_admissions
      comment: "Whether the unit currently accepts admissions — real-time capacity availability dimension for patient placement."
    - name: "accepts_transfers"
      expr: accepts_transfers
      comment: "Whether the unit accepts patient transfers — network transfer capacity dimension for patient flow management."
    - name: "is_twenty_four_seven"
      expr: is_twenty_four_seven
      comment: "Whether the unit operates 24/7 — operational coverage dimension for access and staffing planning."
    - name: "telemetry_monitoring_capability"
      expr: telemetry_monitoring_capability
      comment: "Whether the unit has telemetry monitoring capability — cardiac monitoring capacity dimension."
    - name: "effective_date_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the unit became effective — supports trend analysis of unit inventory growth."
  measures:
    - name: "total_units"
      expr: COUNT(1)
      comment: "Total number of clinical units. Baseline organizational capacity metric used in staffing planning, accreditation reporting, and network capacity analysis."
    - name: "units_accepting_admissions"
      expr: COUNT(CASE WHEN accepts_admissions = TRUE THEN 1 END)
      comment: "Number of units currently accepting admissions. Real-time effective capacity metric — the gap between total and admission-accepting units reveals capacity constraints driving diversion or boarding."
    - name: "units_accepting_transfers"
      expr: COUNT(CASE WHEN accepts_transfers = TRUE THEN 1 END)
      comment: "Number of units accepting patient transfers. Network transfer capacity metric — critical for regional patient flow coordination and transfer center operations."
    - name: "twenty_four_seven_units"
      expr: COUNT(CASE WHEN is_twenty_four_seven = TRUE THEN 1 END)
      comment: "Number of units operating 24/7. Continuous care coverage metric — informs staffing model design and after-hours access planning."
    - name: "magnet_recognized_units"
      expr: COUNT(CASE WHEN magnet_recognition = TRUE THEN 1 END)
      comment: "Number of units with Magnet nursing recognition. Nursing excellence and workforce quality metric — Magnet status is associated with better patient outcomes and nurse retention."
    - name: "teaching_units"
      expr: COUNT(CASE WHEN teaching_unit_flag = TRUE THEN 1 END)
      comment: "Number of teaching units. GME capacity metric — tracks clinical training infrastructure and associated supervision and documentation requirements."
    - name: "telemetry_capable_units"
      expr: COUNT(CASE WHEN telemetry_monitoring_capability = TRUE THEN 1 END)
      comment: "Number of units with telemetry monitoring capability. Cardiac monitoring capacity metric — informs step-down and progressive care unit planning."
    - name: "total_unit_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total square footage across all clinical units. Physical capacity metric — drives space utilization analysis, renovation planning, and cost-per-square-foot benchmarking."
    - name: "avg_unit_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average square footage per clinical unit. Space efficiency benchmark — outliers may indicate overcrowded or underutilized units requiring reconfiguration."
$$;