-- Metric views for domain: store | Business: Grocery | Version: 1 | Generated on: 2026-05-04 20:38:05

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`store_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core store portfolio metrics covering physical footprint, service capability mix, and operational status. Used by Real Estate, Operations, and Strategy teams to evaluate store health, capacity, and omnichannel readiness across the network."
  source: "`grocery_ecm`.`store`.`store_location`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the store (e.g., Open, Closed, Remodeling). Primary filter for active-store analysis."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Whether the store is company-owned, franchised, or leased. Drives capital allocation and P&L treatment decisions."
    - name: "state_province_code"
      expr: state_province_code
      comment: "State or province where the store operates. Used for geographic performance segmentation and regulatory compliance grouping."
    - name: "country_code"
      expr: country_code
      comment: "Country of store operation. Supports multi-country portfolio analysis."
    - name: "has_pharmacy"
      expr: has_pharmacy
      comment: "Indicates whether the store includes a pharmacy. Used to segment stores by service capability for pharmacy-specific KPIs."
    - name: "has_fuel_center"
      expr: has_fuel_center
      comment: "Indicates whether the store has a fuel center. Used to segment stores for fuel-related revenue and traffic analysis."
    - name: "supports_home_delivery"
      expr: supports_home_delivery
      comment: "Indicates whether the store supports home delivery. Key dimension for omnichannel capability reporting."
    - name: "supports_curbside_pickup"
      expr: supports_curbside_pickup
      comment: "Indicates whether the store supports curbside pickup. Key dimension for omnichannel capability reporting."
    - name: "accepts_snap_ebt"
      expr: accepts_snap_ebt
      comment: "Indicates SNAP/EBT acceptance. Used for community access and regulatory compliance reporting."
    - name: "has_bakery"
      expr: has_bakery
      comment: "Indicates presence of an in-store bakery. Used for fresh department capability segmentation."
    - name: "has_deli"
      expr: has_deli
      comment: "Indicates presence of a deli department. Used for fresh department capability segmentation."
    - name: "opening_year"
      expr: YEAR(opening_date)
      comment: "Year the store opened. Used for store vintage analysis and cohort-based performance comparisons."
    - name: "last_remodel_year"
      expr: YEAR(last_remodel_date)
      comment: "Year of the most recent store remodel. Used to assess capital reinvestment recency and correlate with performance."
  measures:
    - name: "total_active_stores"
      expr: COUNT(CASE WHEN operational_status = 'Open' THEN store_location_id END)
      comment: "Count of stores currently in Open operational status. The primary network size KPI used in executive dashboards and investor reporting."
    - name: "total_gross_square_footage"
      expr: SUM(CAST(gross_square_footage AS DOUBLE))
      comment: "Total gross square footage across all stores in the portfolio. Measures physical footprint scale; used in real estate strategy and capital planning."
    - name: "total_selling_square_footage"
      expr: SUM(CAST(selling_square_footage AS DOUBLE))
      comment: "Total selling floor area across all stores. Directly tied to revenue-generating capacity; used in sales-per-square-foot benchmarking."
    - name: "avg_selling_square_footage"
      expr: AVG(CAST(selling_square_footage AS DOUBLE))
      comment: "Average selling square footage per store. Benchmarks store size profile against format targets and competitor footprints."
    - name: "avg_gross_square_footage"
      expr: AVG(CAST(gross_square_footage AS DOUBLE))
      comment: "Average gross square footage per store. Used in format strategy and real estate portfolio planning."
    - name: "total_backroom_square_footage"
      expr: SUM(CAST(backroom_square_footage AS DOUBLE))
      comment: "Total backroom storage area across the network. Used in supply chain and inventory capacity planning."
    - name: "omnichannel_enabled_store_count"
      expr: COUNT(CASE WHEN supports_home_delivery = TRUE OR supports_curbside_pickup = TRUE THEN store_location_id END)
      comment: "Number of stores offering at least one omnichannel fulfillment option (delivery or curbside). Tracks omnichannel network penetration, a key strategic KPI."
    - name: "home_delivery_store_count"
      expr: COUNT(CASE WHEN supports_home_delivery = TRUE THEN store_location_id END)
      comment: "Number of stores enabled for home delivery. Tracks delivery network coverage for e-commerce strategy."
    - name: "curbside_pickup_store_count"
      expr: COUNT(CASE WHEN supports_curbside_pickup = TRUE THEN store_location_id END)
      comment: "Number of stores enabled for curbside pickup. Tracks click-and-collect network coverage."
    - name: "pharmacy_store_count"
      expr: COUNT(CASE WHEN has_pharmacy = TRUE THEN store_location_id END)
      comment: "Number of stores with an in-store pharmacy. Used in pharmacy network planning and healthcare service strategy."
    - name: "fuel_center_store_count"
      expr: COUNT(CASE WHEN has_fuel_center = TRUE THEN store_location_id END)
      comment: "Number of stores with a fuel center. Used in fuel network strategy and traffic-driving capability analysis."
    - name: "snap_ebt_accepting_store_count"
      expr: COUNT(CASE WHEN accepts_snap_ebt = TRUE THEN store_location_id END)
      comment: "Number of stores accepting SNAP/EBT. Used for community access reporting and government program compliance."
    - name: "avg_parking_spaces"
      expr: AVG(CAST(parking_spaces_count AS DOUBLE))
      comment: "Average number of parking spaces per store. Used in site accessibility and customer experience benchmarking."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`store_lease`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real estate lease portfolio metrics covering occupancy cost, lease term risk, and financial exposure. Used by Real Estate, Finance, and Legal teams to manage lease obligations, renewal risk, and cost-per-square-foot efficiency."
  source: "`grocery_ecm`.`store`.`lease`"
  dimensions:
    - name: "lease_status"
      expr: lease_status
      comment: "Current status of the lease (e.g., Active, Expired, Terminated). Primary filter for active lease obligation analysis."
    - name: "lease_type"
      expr: lease_type
      comment: "Type of lease agreement (e.g., NNN, Gross, Modified Gross). Drives cost structure and landlord/tenant responsibility analysis."
    - name: "property_state_code"
      expr: property_state_code
      comment: "State where the leased property is located. Used for geographic concentration and regulatory exposure analysis."
    - name: "property_country_code"
      expr: property_country_code
      comment: "Country of the leased property. Supports multi-country real estate portfolio analysis."
    - name: "rent_escalation_type"
      expr: rent_escalation_type
      comment: "Type of rent escalation clause (e.g., Fixed, CPI, Percentage). Used to model future rent cost trajectories."
    - name: "early_termination_allowed_flag"
      expr: early_termination_allowed_flag
      comment: "Whether the lease allows early termination. Used in portfolio flexibility and exit strategy analysis."
    - name: "sox_disclosure_required_flag"
      expr: sox_disclosure_required_flag
      comment: "Whether the lease requires SOX disclosure. Used for financial compliance and audit reporting."
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the lease expires. Used to identify lease maturity clusters and renewal planning horizons."
    - name: "commencement_year"
      expr: YEAR(commencement_date)
      comment: "Year the lease commenced. Used for lease vintage analysis and term-length benchmarking."
  measures:
    - name: "total_active_leases"
      expr: COUNT(CASE WHEN lease_status = 'Active' THEN lease_id END)
      comment: "Count of currently active leases. Baseline measure for the size of the real estate obligation portfolio."
    - name: "total_annual_base_rent_usd"
      expr: SUM(CAST(base_rent_amount_usd AS DOUBLE))
      comment: "Total base rent obligation across all leases. Primary occupancy cost KPI used in P&L and budget planning."
    - name: "avg_base_rent_per_lease_usd"
      expr: AVG(CAST(base_rent_amount_usd AS DOUBLE))
      comment: "Average base rent per lease. Used to benchmark individual lease costs against portfolio norms."
    - name: "total_cam_charges_usd"
      expr: SUM(CAST(cam_charges_usd AS DOUBLE))
      comment: "Total Common Area Maintenance (CAM) charges across all leases. Represents a significant variable occupancy cost component."
    - name: "total_property_tax_usd"
      expr: SUM(CAST(property_tax_amount_usd AS DOUBLE))
      comment: "Total property tax obligations across all leases. Used in total occupancy cost modeling and tax planning."
    - name: "total_leased_square_footage"
      expr: SUM(CAST(leased_square_footage AS DOUBLE))
      comment: "Total square footage under lease across the portfolio. Used to compute rent-per-square-foot efficiency metrics."
    - name: "avg_leased_square_footage"
      expr: AVG(CAST(leased_square_footage AS DOUBLE))
      comment: "Average leased square footage per lease. Used to benchmark lease size against format targets."
    - name: "total_security_deposit_usd"
      expr: SUM(CAST(security_deposit_usd AS DOUBLE))
      comment: "Total security deposits held across all leases. Represents locked capital that could be redeployed; tracked in treasury and balance sheet reporting."
    - name: "total_early_termination_penalty_usd"
      expr: SUM(CAST(early_termination_penalty_usd AS DOUBLE))
      comment: "Total potential early termination penalties across the portfolio. Used in portfolio exit scenario planning and risk quantification."
    - name: "avg_rent_escalation_rate_pct"
      expr: AVG(CAST(rent_escalation_rate_percent AS DOUBLE))
      comment: "Average rent escalation rate across leases. Used to project future occupancy cost growth and model lease renewal economics."
    - name: "total_insurance_obligation_usd"
      expr: SUM(CAST(insurance_amount_usd AS DOUBLE))
      comment: "Total insurance obligations embedded in lease agreements. Used in total cost of occupancy analysis."
    - name: "leases_expiring_within_2_years"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 730) THEN lease_id END)
      comment: "Number of leases expiring within the next 2 years. Critical renewal pipeline KPI used by Real Estate to prioritize negotiation resources."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`store_health_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Food safety and regulatory compliance metrics derived from health inspection records. Used by Operations, Food Safety, and Risk teams to monitor compliance posture, violation trends, and closure risk across the store network."
  source: "`grocery_ecm`.`store`.`health_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of health inspection (e.g., Routine, Follow-up, Complaint-driven). Used to segment compliance performance by inspection trigger."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection record (e.g., Passed, Failed, Pending). Primary compliance status dimension."
    - name: "inspecting_agency"
      expr: inspecting_agency
      comment: "Regulatory agency conducting the inspection. Used to segment results by jurisdiction and agency stringency."
    - name: "letter_grade"
      expr: letter_grade
      comment: "Letter grade assigned by the inspecting agency. High-visibility consumer-facing compliance indicator used in executive reporting."
    - name: "haccp_compliance_status"
      expr: haccp_compliance_status
      comment: "HACCP (Hazard Analysis Critical Control Points) compliance status. Critical food safety regulatory dimension."
    - name: "closure_ordered"
      expr: closure_ordered
      comment: "Whether a store closure was ordered as a result of the inspection. Used to flag highest-severity compliance events."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether a corrective action plan was required. Used to track remediation workload and compliance follow-through."
    - name: "reinspection_required"
      expr: reinspection_required
      comment: "Whether a reinspection was mandated. Used to track ongoing regulatory scrutiny and resource planning for follow-up visits."
    - name: "inspection_year"
      expr: YEAR(inspection_date)
      comment: "Year of the inspection. Used for year-over-year compliance trend analysis."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of the inspection. Used for monthly compliance trend monitoring and seasonal pattern analysis."
  measures:
    - name: "total_inspections"
      expr: COUNT(health_inspection_id)
      comment: "Total number of health inspections conducted. Baseline volume measure for compliance activity tracking."
    - name: "avg_inspection_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average health inspection score across all inspections. Primary food safety quality KPI used in executive compliance dashboards."
    - name: "min_inspection_score"
      expr: MIN(overall_score)
      comment: "Lowest inspection score recorded. Used to identify worst-performing stores and highest-risk compliance events."
    - name: "closure_ordered_count"
      expr: COUNT(CASE WHEN closure_ordered = TRUE THEN health_inspection_id END)
      comment: "Number of inspections that resulted in a store closure order. Highest-severity compliance KPI; directly tied to brand risk and revenue loss."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN health_inspection_id END)
      comment: "Number of inspections requiring a corrective action plan. Tracks remediation workload and systemic compliance gaps."
    - name: "reinspection_required_count"
      expr: COUNT(CASE WHEN reinspection_required = TRUE THEN health_inspection_id END)
      comment: "Number of inspections triggering a mandatory reinspection. Indicates persistent compliance issues requiring follow-up regulatory engagement."
    - name: "distinct_stores_inspected"
      expr: COUNT(DISTINCT store_location_id)
      comment: "Number of distinct store locations that received at least one inspection. Used to measure inspection coverage across the network."
    - name: "haccp_non_compliant_count"
      expr: COUNT(CASE WHEN haccp_compliance_status != 'Compliant' THEN health_inspection_id END)
      comment: "Number of inspections where HACCP compliance was not achieved. Critical food safety regulatory KPI with direct liability implications."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`store_mfc_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Micro-Fulfillment Center (MFC) operational performance metrics covering fulfillment efficiency, accuracy, food safety, and capacity utilization. Used by E-Commerce Operations, Supply Chain, and Technology teams to optimize automated fulfillment performance."
  source: "`grocery_ecm`.`store`.`mfc_profile`"
  dimensions:
    - name: "mfc_type"
      expr: mfc_type
      comment: "Type of MFC (e.g., In-store, Dark Store, Standalone). Used to segment performance by fulfillment center architecture."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the MFC (e.g., Active, Inactive, Commissioning). Primary filter for live MFC performance analysis."
    - name: "robotics_vendor"
      expr: robotics_vendor
      comment: "Vendor supplying the robotics system. Used to benchmark performance across automation technology providers."
    - name: "haccp_certified"
      expr: haccp_certified
      comment: "Whether the MFC holds HACCP certification. Used for food safety compliance segmentation."
    - name: "twenty_four_hour_operation"
      expr: twenty_four_hour_operation
      comment: "Whether the MFC operates 24 hours. Used to segment capacity and throughput analysis by operating model."
    - name: "frozen_zone_enabled"
      expr: frozen_zone_enabled
      comment: "Whether the MFC has a frozen temperature zone. Used to assess cold-chain fulfillment capability."
    - name: "chilled_zone_enabled"
      expr: chilled_zone_enabled
      comment: "Whether the MFC has a chilled temperature zone. Used to assess fresh and chilled product fulfillment capability."
    - name: "activation_year"
      expr: YEAR(activation_date)
      comment: "Year the MFC was activated. Used for MFC vintage analysis and ramp-up performance benchmarking."
  measures:
    - name: "total_active_mfcs"
      expr: COUNT(CASE WHEN operational_status = 'Active' THEN mfc_profile_id END)
      comment: "Count of currently active MFCs. Baseline measure for automated fulfillment network scale."
    - name: "avg_order_fulfillment_time_minutes"
      expr: AVG(CAST(average_order_fulfillment_time_minutes AS DOUBLE))
      comment: "Average order fulfillment time in minutes across MFCs. Primary throughput efficiency KPI; directly tied to customer SLA performance."
    - name: "avg_order_accuracy_pct"
      expr: AVG(CAST(average_order_accuracy_percent AS DOUBLE))
      comment: "Average order accuracy percentage across MFCs. Key quality KPI; low accuracy drives customer complaints, returns, and churn."
    - name: "avg_inventory_accuracy_pct"
      expr: AVG(CAST(average_inventory_accuracy_percent AS DOUBLE))
      comment: "Average inventory accuracy percentage across MFCs. Drives fulfillment reliability; low inventory accuracy causes substitutions and cancellations."
    - name: "avg_pick_time_seconds"
      expr: AVG(CAST(average_pick_time_seconds AS DOUBLE))
      comment: "Average time to pick a single item in seconds. Operational efficiency KPI used to benchmark robotics performance and identify automation improvement opportunities."
    - name: "avg_food_safety_inspection_score"
      expr: AVG(CAST(food_safety_inspection_score AS DOUBLE))
      comment: "Average food safety inspection score across MFCs. Compliance KPI ensuring automated fulfillment meets food safety standards."
    - name: "total_picking_square_footage"
      expr: SUM(CAST(picking_square_footage AS DOUBLE))
      comment: "Total picking floor area across all MFCs. Used in capacity planning and throughput-per-square-foot efficiency analysis."
    - name: "total_mfc_square_footage"
      expr: SUM(CAST(total_square_footage AS DOUBLE))
      comment: "Total physical footprint of all MFCs. Used in real estate and capital investment planning for the automated fulfillment network."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`store_department`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "In-store department operational metrics covering space allocation, labor standards, shrink targets, and compliance attributes. Used by Store Operations, Merchandising, and Finance teams to optimize department-level performance and resource allocation."
  source: "`grocery_ecm`.`store`.`department`"
  dimensions:
    - name: "department_type"
      expr: department_type
      comment: "Type of department (e.g., Produce, Deli, Bakery, Pharmacy). Primary segmentation dimension for department-level performance analysis."
    - name: "department_status"
      expr: department_status
      comment: "Current operational status of the department. Used to filter active departments for performance reporting."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone of the department (e.g., Ambient, Chilled, Frozen). Used for cold-chain compliance and energy cost analysis."
    - name: "replenishment_method"
      expr: replenishment_method
      comment: "Replenishment approach used (e.g., Scan-based, Manual, Automated). Used to assess supply chain efficiency by department."
    - name: "haccp_classification"
      expr: haccp_classification
      comment: "HACCP risk classification of the department. Used for food safety compliance segmentation and audit prioritization."
    - name: "organic_certified_flag"
      expr: organic_certified_flag
      comment: "Whether the department holds organic certification. Used to track organic assortment capability across the network."
    - name: "private_label_focus_flag"
      expr: private_label_focus_flag
      comment: "Whether the department has a private label focus. Used to track private brand penetration strategy by department type."
    - name: "snap_eligible_flag"
      expr: snap_eligible_flag
      comment: "Whether the department sells SNAP-eligible items. Used for government program compliance and community access reporting."
    - name: "backroom_cooler_flag"
      expr: backroom_cooler_flag
      comment: "Whether the department has a backroom cooler. Used in cold-chain infrastructure planning."
  measures:
    - name: "total_departments"
      expr: COUNT(department_id)
      comment: "Total number of department records. Baseline measure for department portfolio size."
    - name: "total_selling_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total square footage allocated to departments across the network. Used in space productivity and planogram optimization."
    - name: "avg_department_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average square footage per department. Used to benchmark department size against format standards and identify space reallocation opportunities."
    - name: "total_labor_standard_hours_per_week"
      expr: SUM(CAST(labor_standard_hours_per_week AS DOUBLE))
      comment: "Total standard labor hours per week across all departments. Used in workforce planning, scheduling, and labor cost budgeting."
    - name: "avg_labor_standard_hours_per_week"
      expr: AVG(CAST(labor_standard_hours_per_week AS DOUBLE))
      comment: "Average standard labor hours per week per department. Used to benchmark labor intensity by department type and identify staffing efficiency opportunities."
    - name: "avg_shrink_budget_target_pct"
      expr: AVG(CAST(shrink_budget_target_percent AS DOUBLE))
      comment: "Average shrink budget target percentage across departments. Used to set shrink reduction goals and evaluate actual shrink performance against targets."
    - name: "total_backroom_capacity_cubic_feet"
      expr: SUM(CAST(backroom_capacity_cubic_feet AS DOUBLE))
      comment: "Total backroom storage capacity in cubic feet across all departments. Used in inventory capacity planning and supply chain optimization."
    - name: "avg_backroom_capacity_cubic_feet"
      expr: AVG(CAST(backroom_capacity_cubic_feet AS DOUBLE))
      comment: "Average backroom storage capacity per department. Used to benchmark storage adequacy against replenishment frequency and inventory turn targets."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`store_banner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Banner-level strategic metrics covering brand portfolio performance, franchise economics, and market positioning. Used by Strategy, Finance, and Brand Management teams to evaluate banner health, franchise fee economics, and loyalty program alignment."
  source: "`grocery_ecm`.`store`.`banner`"
  dimensions:
    - name: "banner_status"
      expr: banner_status
      comment: "Current status of the banner (e.g., Active, Retired, Pilot). Used to filter active banners for performance reporting."
    - name: "banner_type"
      expr: banner_type
      comment: "Type of banner (e.g., Supermarket, Discount, Premium). Used to segment performance by brand positioning."
    - name: "market_segment"
      expr: market_segment
      comment: "Target market segment for the banner (e.g., Value, Premium, Ethnic). Used for competitive positioning and assortment strategy analysis."
    - name: "is_franchise"
      expr: is_franchise
      comment: "Whether the banner operates under a franchise model. Used to separate company-operated vs. franchise economics."
    - name: "country_code"
      expr: country_code
      comment: "Country where the banner operates. Used for multi-country brand portfolio analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the banner. Used for regional brand performance segmentation."
    - name: "online_presence"
      expr: online_presence
      comment: "Whether the banner has an online presence. Used to segment banners by omnichannel maturity."
    - name: "loyalty_program_eligible"
      expr: loyalty_program_eligible
      comment: "Whether the banner participates in a loyalty program. Used to assess loyalty program coverage across the brand portfolio."
    - name: "target_customer_group"
      expr: target_customer_group
      comment: "Primary customer demographic targeted by the banner. Used in brand strategy and marketing investment allocation."
  measures:
    - name: "total_active_banners"
      expr: COUNT(CASE WHEN banner_status = 'Active' THEN banner_id END)
      comment: "Count of currently active banners. Baseline measure for brand portfolio breadth."
    - name: "total_avg_sales_per_store_usd"
      expr: SUM(CAST(average_sales_per_store AS DOUBLE))
      comment: "Sum of average sales per store across all banners. Used as a portfolio-level revenue productivity indicator in brand performance reviews."
    - name: "avg_sales_per_store_usd"
      expr: AVG(CAST(average_sales_per_store AS DOUBLE))
      comment: "Average sales per store across banners. Primary banner productivity KPI used to compare brand performance and guide investment decisions."
    - name: "avg_franchise_fee_pct"
      expr: AVG(CAST(franchise_fee_percent AS DOUBLE))
      comment: "Average franchise fee percentage across franchise banners. Used in franchise economics modeling and fee structure benchmarking."
    - name: "franchise_banner_count"
      expr: COUNT(CASE WHEN is_franchise = TRUE THEN banner_id END)
      comment: "Number of banners operating under a franchise model. Used to track franchise network scale and asset-light strategy progress."
    - name: "loyalty_eligible_banner_count"
      expr: COUNT(CASE WHEN loyalty_program_eligible = TRUE THEN banner_id END)
      comment: "Number of banners eligible for the loyalty program. Used to assess loyalty program reach across the brand portfolio."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`store_region`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regional performance target and organizational metrics used by Regional VPs and Finance to track revenue targets, EBITDA goals, and workforce scale across geographic regions."
  source: "`grocery_ecm`.`store`.`region`"
  dimensions:
    - name: "region_status"
      expr: region_status
      comment: "Current status of the region (e.g., Active, Inactive). Used to filter active regions for performance reporting."
    - name: "region_type"
      expr: region_type
      comment: "Type of region (e.g., Metro, Rural, Suburban). Used to segment performance by geographic market type."
    - name: "primary_state_code"
      expr: primary_state_code
      comment: "Primary state associated with the region. Used for geographic performance segmentation."
    - name: "comp_sales_reporting_flag"
      expr: comp_sales_reporting_flag
      comment: "Whether the region is included in comparable-store sales reporting. Used to filter regions for comp-sales analysis, a key retail performance metric."
    - name: "time_zone"
      expr: time_zone
      comment: "Time zone of the regional office. Used for operational scheduling and reporting alignment."
  measures:
    - name: "total_annual_revenue_target_usd"
      expr: SUM(CAST(annual_revenue_target_usd AS DOUBLE))
      comment: "Total annual revenue target across all regions. Used in top-down financial planning and target-setting for the store network."
    - name: "avg_annual_revenue_target_usd"
      expr: AVG(CAST(annual_revenue_target_usd AS DOUBLE))
      comment: "Average annual revenue target per region. Used to benchmark regional ambition levels and identify under-targeted geographies."
    - name: "total_annual_ebitda_target_usd"
      expr: SUM(CAST(annual_ebitda_target_usd AS DOUBLE))
      comment: "Total EBITDA target across all regions. Primary profitability planning KPI used in board-level financial reporting."
    - name: "avg_annual_ebitda_target_usd"
      expr: AVG(CAST(annual_ebitda_target_usd AS DOUBLE))
      comment: "Average EBITDA target per region. Used to compare regional profitability ambition and identify gaps in financial planning."
    - name: "total_regions"
      expr: COUNT(region_id)
      comment: "Total number of regions in the organizational hierarchy. Used as a baseline for network structure analysis."
    - name: "comp_sales_region_count"
      expr: COUNT(CASE WHEN comp_sales_reporting_flag = TRUE THEN region_id END)
      comment: "Number of regions included in comparable-store sales reporting. Used to validate comp-sales reporting coverage and ensure consistent benchmarking."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`store_format`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store format portfolio metrics covering revenue target ranges, physical footprint standards, and capability profiles. Used by Real Estate, Strategy, and Merchandising teams to evaluate format economics, capability mix, and expansion planning."
  source: "`grocery_ecm`.`store`.`format`"
  dimensions:
    - name: "format_status"
      expr: format_status
      comment: "Current status of the format (e.g., Active, Retired, Pilot). Used to filter active formats for planning analysis."
    - name: "format_category"
      expr: format_category
      comment: "Category of the format (e.g., Supermarket, Convenience, Hypermarket). Used for format strategy segmentation."
    - name: "pharmacy_included"
      expr: pharmacy_included
      comment: "Whether the format includes a pharmacy. Used to segment formats by healthcare service capability."
    - name: "fuel_center_included"
      expr: fuel_center_included
      comment: "Whether the format includes a fuel center. Used to segment formats by traffic-driving service capability."
    - name: "home_delivery_enabled"
      expr: home_delivery_enabled
      comment: "Whether the format supports home delivery. Used to segment formats by omnichannel capability."
    - name: "online_pickup_enabled"
      expr: online_pickup_enabled
      comment: "Whether the format supports online pickup. Used to segment formats by click-and-collect capability."
    - name: "mfc_enabled"
      expr: mfc_enabled
      comment: "Whether the format includes a Micro-Fulfillment Center. Used to track automated fulfillment capability by format."
    - name: "self_checkout_enabled"
      expr: self_checkout_enabled
      comment: "Whether the format includes self-checkout. Used to assess labor efficiency and customer experience capability by format."
    - name: "fresh_produce_included"
      expr: fresh_produce_included
      comment: "Whether the format includes a fresh produce department. Used to segment formats by fresh food capability."
  measures:
    - name: "total_active_formats"
      expr: COUNT(CASE WHEN format_status = 'Active' THEN format_id END)
      comment: "Count of currently active store formats. Baseline measure for format portfolio breadth."
    - name: "avg_annual_revenue_target_min_usd"
      expr: AVG(CAST(annual_revenue_target_min AS DOUBLE))
      comment: "Average minimum annual revenue target across formats. Used to benchmark the lower bound of format revenue expectations in expansion planning."
    - name: "avg_annual_revenue_target_max_usd"
      expr: AVG(CAST(annual_revenue_target_max AS DOUBLE))
      comment: "Average maximum annual revenue target across formats. Used to benchmark the upper bound of format revenue potential in investment decisions."
    - name: "avg_capital_investment_usd"
      expr: AVG(CAST(capital_investment_typical AS DOUBLE))
      comment: "Average typical capital investment required per format. Primary capital planning KPI used in new store and remodel investment decisions."
    - name: "total_capital_investment_usd"
      expr: SUM(CAST(capital_investment_typical AS DOUBLE))
      comment: "Total typical capital investment across all active formats. Used in portfolio-level capital expenditure planning."
    - name: "avg_selling_area_percentage"
      expr: AVG(CAST(selling_area_percentage AS DOUBLE))
      comment: "Average percentage of total store area dedicated to selling across formats. Used to benchmark space efficiency and identify formats with suboptimal floor plan utilization."
    - name: "omnichannel_format_count"
      expr: COUNT(CASE WHEN home_delivery_enabled = TRUE OR online_pickup_enabled = TRUE THEN format_id END)
      comment: "Number of formats with at least one omnichannel fulfillment capability. Tracks omnichannel readiness across the format portfolio."
    - name: "mfc_enabled_format_count"
      expr: COUNT(CASE WHEN mfc_enabled = TRUE THEN format_id END)
      comment: "Number of formats that include MFC capability. Used to track automated fulfillment adoption across the format portfolio."
$$;