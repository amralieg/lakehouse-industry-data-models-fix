-- Metric views for domain: dealer | Business: Automotive | Version: 2 | Generated on: 2026-06-23 05:54:22

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_retail_sale`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retail vehicle sales performance metrics covering revenue, gross profit, financing mix, incentive utilization, and deal economics. Primary KPI surface for sales leadership and dealer performance reviews."
  source: "`vibe_automotive_v1`.`dealer`.`retail_sale`"
  dimensions:
    - name: "deal_status"
      expr: deal_status
      comment: "Current status of the deal (e.g., funded, unwound, pending) — used to filter to completed/funded deals."
    - name: "financing_type"
      expr: financing_type
      comment: "Method of financing (cash, retail finance, lease) — key dimension for F&I mix analysis."
    - name: "vehicle_condition"
      expr: vehicle_condition
      comment: "New or used vehicle condition — drives separate new vs. used sales performance tracking."
    - name: "delivery_method"
      expr: delivery_method
      comment: "How the vehicle was delivered (in-store, home delivery) — supports digital retailing and last-mile analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — required for multi-market revenue normalization."
    - name: "sale_month"
      expr: DATE_TRUNC('MONTH', sale_date)
      comment: "Month of sale date — primary time grain for monthly sales reporting."
    - name: "sale_year"
      expr: YEAR(sale_date)
      comment: "Calendar year of sale — used for annual sales target tracking."
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month of vehicle delivery — used to track delivery lag vs. sale date."
    - name: "model_year"
      expr: model_year
      comment: "Model year of the sold vehicle — used for aging inventory and model-year mix analysis."
    - name: "fleet_sale_flag"
      expr: fleet_sale
      comment: "Boolean flag indicating whether the sale was a fleet transaction — separates retail from fleet volume."
    - name: "pdi_completed_flag"
      expr: pdi_completed
      comment: "Boolean indicating pre-delivery inspection was completed — quality gate for delivery readiness."
  measures:
    - name: "total_retail_units_sold"
      expr: COUNT(1)
      comment: "Total number of retail sale transactions. Baseline volume KPI for sales performance dashboards and quota attainment tracking."
    - name: "total_sale_revenue"
      expr: SUM(CAST(sale_price AS DOUBLE))
      comment: "Total retail sale revenue (sum of actual sale prices). Primary top-line revenue KPI for dealer and OEM sales reporting."
    - name: "total_msrp_value"
      expr: SUM(CAST(msrp_amount AS DOUBLE))
      comment: "Sum of MSRP across all sold units. Used as the denominator for discount rate calculations and to measure pricing discipline."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount dollars given across all deals. Tracks pricing concession exposure and incentive spend efficiency."
    - name: "total_front_end_gross"
      expr: SUM(CAST(front_end_gross AS DOUBLE))
      comment: "Total front-end gross profit (vehicle margin before F&I). Core dealer profitability KPI reviewed at every sales meeting."
    - name: "total_back_end_gross"
      expr: SUM(CAST(back_end_gross AS DOUBLE))
      comment: "Total back-end gross profit from F&I products. Measures F&I department contribution to overall deal profitability."
    - name: "total_fi_product_revenue"
      expr: SUM(CAST(fi_product_revenue AS DOUBLE))
      comment: "Total F&I product revenue (warranties, GAP, protection packages). Key F&I performance metric for dealer profitability."
    - name: "total_oem_incentive_amount"
      expr: SUM(CAST(oem_incentive_amount AS DOUBLE))
      comment: "Total OEM incentive dollars applied across all deals. Tracks incentive program utilization and cost-to-OEM exposure."
    - name: "total_trade_in_allowance"
      expr: SUM(CAST(trade_in_allowance AS DOUBLE))
      comment: "Total trade-in allowance granted. Indicates trade-in volume and used vehicle acquisition pipeline from retail sales."
    - name: "total_finance_amount"
      expr: SUM(CAST(finance_amount AS DOUBLE))
      comment: "Total amount financed across all retail deals. Measures captive finance penetration and lender exposure."
    - name: "avg_sale_price"
      expr: AVG(CAST(sale_price AS DOUBLE))
      comment: "Average retail sale price per unit. Tracks average transaction value trends and pricing strategy effectiveness."
    - name: "avg_front_end_gross_per_unit"
      expr: AVG(CAST(front_end_gross AS DOUBLE))
      comment: "Average front-end gross profit per unit sold. Industry-standard dealer profitability KPI (PVR — per vehicle retailed)."
    - name: "avg_back_end_gross_per_unit"
      expr: AVG(CAST(back_end_gross AS DOUBLE))
      comment: "Average back-end gross profit per unit. Measures F&I productivity on a per-deal basis — key F&I manager KPI."
    - name: "avg_oem_incentive_per_unit"
      expr: AVG(CAST(oem_incentive_amount AS DOUBLE))
      comment: "Average OEM incentive per unit sold. Tracks incentive dependency and program effectiveness per transaction."
    - name: "avg_discount_per_unit"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per unit. Measures pricing discipline and negotiation patterns at the deal level."
    - name: "total_sales_tax_collected"
      expr: SUM(CAST(sales_tax_amount AS DOUBLE))
      comment: "Total sales tax collected across all retail transactions. Required for tax compliance reporting and remittance reconciliation."
    - name: "total_doc_fee_revenue"
      expr: SUM(CAST(doc_fee AS DOUBLE))
      comment: "Total documentation fee revenue. Tracks ancillary fee income and compliance with state doc fee caps."
    - name: "financed_deal_count"
      expr: COUNT(CASE WHEN financing_type IS NOT NULL AND financing_type != 'cash' THEN 1 END)
      comment: "Number of deals with non-cash financing. Used to calculate finance penetration rate — a key F&I performance metric."
    - name: "fleet_sale_unit_count"
      expr: COUNT(CASE WHEN fleet_sale = TRUE THEN 1 END)
      comment: "Number of fleet sale transactions. Separates fleet volume from retail for accurate retail market share reporting."
    - name: "distinct_dealers_with_sales"
      expr: COUNT(DISTINCT primary_retail_dealer_dealership_id)
      comment: "Number of distinct dealerships generating retail sales. Measures active dealer network participation in a given period."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dealer inventory health and economics metrics covering stock valuation, pricing spread, PDI readiness, and inventory composition. Used by dealer operations, regional managers, and OEM supply teams to manage lot health and turn velocity."
  source: "`vibe_automotive_v1`.`dealer`.`dealer_inventory`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of the inventory unit (available, sold, hold, in-transit) — primary filter for active lot analysis."
    - name: "inventory_type"
      expr: inventory_type
      comment: "Type of inventory (new, used, CPO) — drives separate new vs. used vs. CPO inventory reporting."
    - name: "source_type"
      expr: source_type
      comment: "How the vehicle was sourced (trade-in, auction, OEM allocation) — used for used vehicle acquisition channel analysis."
    - name: "exterior_color_name"
      expr: exterior_color_name
      comment: "Exterior color of the vehicle — used for color mix analysis and slow-moving color identification."
    - name: "transport_status"
      expr: transport_status
      comment: "Current transport status of the vehicle — tracks in-transit units not yet available for sale."
    - name: "certified_pre_owned_flag"
      expr: certified_pre_owned
      comment: "Boolean flag for CPO designation — separates CPO premium inventory from standard used vehicles."
    - name: "pdi_completed_flag"
      expr: pdi_completed
      comment: "Boolean indicating PDI completion — identifies units ready for immediate delivery vs. requiring prep."
    - name: "recall_hold_flag"
      expr: recall_hold
      comment: "Boolean flag for recall hold status — critical for compliance; units on recall hold cannot be retailed."
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Month the vehicle was received at the dealership — used for aging cohort analysis."
    - name: "floor_plan_lender"
      expr: floor_plan_lender
      comment: "Lender financing the floor plan for this unit — used for floor plan cost and lender concentration analysis."
    - name: "location_code"
      expr: location_code
      comment: "Physical lot location code — used for yard management and lot utilization reporting."
  measures:
    - name: "total_units_in_inventory"
      expr: COUNT(1)
      comment: "Total inventory unit count. Baseline lot size KPI used for days supply calculations and capacity utilization."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of all inventory units. Measures total capital deployed in vehicle inventory — key floor plan exposure metric."
    - name: "total_msrp_value"
      expr: SUM(CAST(msrp AS DOUBLE))
      comment: "Total MSRP value of inventory on lot. Represents the gross retail value of the dealer's inventory portfolio."
    - name: "total_asking_price_value"
      expr: SUM(CAST(asking_price AS DOUBLE))
      comment: "Total asking price across all inventory units. Measures the dealer's current pricing position relative to MSRP."
    - name: "total_invoice_price_value"
      expr: SUM(CAST(invoice_price AS DOUBLE))
      comment: "Total invoice price of inventory. Used to calculate dealer cost basis and potential gross profit exposure."
    - name: "avg_acquisition_cost_per_unit"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per inventory unit. Tracks cost trends for used vehicle sourcing and new vehicle invoice pricing."
    - name: "avg_msrp_per_unit"
      expr: AVG(CAST(msrp AS DOUBLE))
      comment: "Average MSRP per unit on lot. Indicates the average price point of the dealer's inventory mix."
    - name: "avg_asking_price_per_unit"
      expr: AVG(CAST(asking_price AS DOUBLE))
      comment: "Average asking price per unit. Compared against avg MSRP to measure pricing strategy (above/below MSRP positioning)."
    - name: "avg_fuel_economy_city_mpg"
      expr: AVG(CAST(fuel_economy_city_mpg AS DOUBLE))
      comment: "Average city fuel economy across inventory. Tracks fleet efficiency profile and EV/hybrid mix trends."
    - name: "avg_fuel_economy_highway_mpg"
      expr: AVG(CAST(fuel_economy_highway_mpg AS DOUBLE))
      comment: "Average highway fuel economy across inventory. Supports regulatory reporting and consumer-facing efficiency positioning."
    - name: "units_on_recall_hold"
      expr: COUNT(CASE WHEN recall_hold = TRUE THEN 1 END)
      comment: "Number of inventory units currently on recall hold. Critical compliance KPI — recall-held units cannot be retailed and represent blocked revenue."
    - name: "units_pdi_completed"
      expr: COUNT(CASE WHEN pdi_completed = TRUE THEN 1 END)
      comment: "Number of units with PDI completed and ready for delivery. Measures delivery readiness and PDI throughput capacity."
    - name: "units_certified_pre_owned"
      expr: COUNT(CASE WHEN certified_pre_owned = TRUE THEN 1 END)
      comment: "Number of CPO-designated units in inventory. Tracks CPO program participation and premium used vehicle inventory depth."
    - name: "distinct_dealers_with_inventory"
      expr: COUNT(DISTINCT primary_dealer_dealership_id)
      comment: "Number of distinct dealerships holding inventory. Measures active inventory distribution across the dealer network."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_repair_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dealer service department repair order metrics covering labor revenue, parts revenue, warranty mix, and service throughput. Core KPIs for fixed operations performance management and service absorption analysis."
  source: "`vibe_automotive_v1`.`dealer`.`dealer_repair_order`"
  dimensions:
    - name: "repair_order_status"
      expr: repair_order_status
      comment: "Current status of the repair order (open, closed, pending parts) — used to filter to completed ROs for revenue recognition."
    - name: "payment_type"
      expr: payment_type
      comment: "Payment type for the RO (customer pay, warranty, internal, fleet) — critical for service revenue mix analysis."
    - name: "warranty_flag"
      expr: warranty_flag
      comment: "Boolean indicating whether the RO is a warranty claim — separates warranty from customer-pay revenue."
    - name: "pickup_delivery_flag"
      expr: pickup_delivery_flag
      comment: "Boolean indicating pickup/delivery service was used — tracks mobile service and convenience offering utilization."
    - name: "open_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the repair order was opened — primary time grain for service volume trending."
    - name: "close_month"
      expr: DATE_TRUNC('MONTH', close_date)
      comment: "Month the repair order was closed — used for revenue recognition timing and cycle time analysis."
    - name: "open_year"
      expr: YEAR(open_date)
      comment: "Calendar year the RO was opened — used for annual fixed ops performance comparisons."
  measures:
    - name: "total_repair_orders"
      expr: COUNT(1)
      comment: "Total number of repair orders. Baseline service throughput KPI — measures service department volume and capacity utilization."
    - name: "total_labor_revenue"
      expr: SUM(CAST(labor_amount AS DOUBLE))
      comment: "Total labor revenue across all repair orders. Primary fixed operations revenue KPI — directly tied to technician productivity and bay utilization."
    - name: "total_parts_revenue"
      expr: SUM(CAST(parts_amount AS DOUBLE))
      comment: "Total parts revenue across all repair orders. Measures parts department contribution to fixed ops gross profit."
    - name: "total_ro_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total repair order revenue (labor + parts + other). Top-line fixed operations revenue KPI for dealer P&L and service absorption calculations."
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labor hours billed across all ROs. Measures technician productivity and is the basis for effective labor rate calculations."
    - name: "avg_ro_total_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average revenue per repair order. Industry KPI (ELR — effective labor rate proxy) used to benchmark service department efficiency."
    - name: "avg_labor_hours_per_ro"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labor hours per repair order. Measures job complexity and technician efficiency — used in service capacity planning."
    - name: "avg_labor_amount_per_ro"
      expr: AVG(CAST(labor_amount AS DOUBLE))
      comment: "Average labor revenue per repair order. Used to track effective labor rate trends and pricing strategy in the service department."
    - name: "warranty_ro_count"
      expr: COUNT(CASE WHEN warranty_flag = TRUE THEN 1 END)
      comment: "Number of warranty repair orders. Tracks warranty claim volume — high warranty mix may indicate quality issues or recall activity."
    - name: "customer_pay_ro_count"
      expr: COUNT(CASE WHEN warranty_flag = FALSE OR warranty_flag IS NULL THEN 1 END)
      comment: "Number of customer-pay repair orders. Measures organic service revenue not dependent on warranty reimbursement."
    - name: "distinct_vehicles_serviced"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of distinct vehicles serviced. Measures service department reach and customer vehicle retention in the service lane."
    - name: "distinct_customers_served"
      expr: COUNT(DISTINCT party_id)
      comment: "Number of distinct customers with repair orders. Tracks active service customer base size — key retention and loyalty metric."
    - name: "distinct_dealers_with_ros"
      expr: COUNT(DISTINCT dealership_id)
      comment: "Number of distinct dealerships generating repair orders. Measures active fixed ops participation across the dealer network."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_service_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service appointment scheduling and fulfillment metrics covering booking volume, channel mix, estimated vs. actual throughput, and customer convenience service utilization. Used by service managers and dealer operations teams to optimize scheduling capacity and customer experience."
  source: "`vibe_automotive_v1`.`dealer`.`dealer_service_appointment`"
  dimensions:
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current status of the appointment (scheduled, completed, no-show, cancelled) — primary filter for appointment funnel analysis."
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the appointment was booked (online, phone, walk-in, app) — measures digital scheduling adoption."
    - name: "service_type"
      expr: service_type
      comment: "Type of service requested (maintenance, repair, recall, warranty) — drives service mix and capacity planning analysis."
    - name: "home_service_flag"
      expr: home_service_flag
      comment: "Boolean indicating home/mobile service appointment — tracks mobile service program utilization and growth."
    - name: "loaner_requested_flag"
      expr: loaner_requested_flag
      comment: "Boolean indicating customer requested a loaner vehicle — used for loaner fleet capacity planning."
    - name: "appointment_month"
      expr: DATE_TRUNC('MONTH', appointment_date)
      comment: "Month of the scheduled appointment — primary time grain for appointment volume trending."
    - name: "appointment_year"
      expr: YEAR(appointment_date)
      comment: "Calendar year of the appointment — used for year-over-year service volume comparisons."
  measures:
    - name: "total_appointments_scheduled"
      expr: COUNT(1)
      comment: "Total number of service appointments scheduled. Baseline service demand KPI — measures scheduling volume and service lane throughput."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated service cost across all appointments. Measures projected service revenue pipeline from scheduled appointments."
    - name: "avg_estimated_cost_per_appointment"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per service appointment. Tracks average ticket size at booking — used for revenue forecasting and advisor performance."
    - name: "total_estimated_labor_hours"
      expr: SUM(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Total estimated labor hours across all scheduled appointments. Used for technician capacity planning and bay scheduling optimization."
    - name: "avg_estimated_duration_hours"
      expr: AVG(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average estimated service duration per appointment. Measures job complexity mix and informs scheduling slot allocation."
    - name: "home_service_appointment_count"
      expr: COUNT(CASE WHEN home_service_flag = TRUE THEN 1 END)
      comment: "Number of home/mobile service appointments. Tracks mobile service program adoption — a key differentiator in dealer customer experience strategy."
    - name: "loaner_requested_count"
      expr: COUNT(CASE WHEN loaner_requested_flag = TRUE THEN 1 END)
      comment: "Number of appointments with loaner vehicle requests. Drives loaner fleet sizing decisions and customer satisfaction risk management."
    - name: "distinct_customers_with_appointments"
      expr: COUNT(DISTINCT party_id)
      comment: "Number of distinct customers with scheduled appointments. Measures active service customer base and retention in the service lane."
    - name: "distinct_vehicles_with_appointments"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of distinct vehicles with service appointments. Tracks vehicle-level service frequency and identifies vehicles due for service outreach."
    - name: "distinct_dealers_scheduling"
      expr: COUNT(DISTINCT dealership_id)
      comment: "Number of distinct dealerships with scheduled appointments. Measures active service scheduling participation across the dealer network."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_performance_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dealer performance scorecard metrics covering composite scores, CSI, NPS, sales attainment, service absorption, parts fill rate, and training compliance. The primary KPI surface for OEM dealer performance management, franchise compliance, and incentive eligibility decisions."
  source: "`vibe_automotive_v1`.`dealer`.`performance_scorecard`"
  dimensions:
    - name: "performance_tier"
      expr: performance_tier
      comment: "Dealer performance tier classification (Platinum, Gold, Silver, etc.) — used for tiered incentive and support allocation decisions."
    - name: "franchise_compliance_status"
      expr: franchise_compliance_status
      comment: "Franchise compliance status — identifies dealers at risk of franchise agreement breach requiring OEM intervention."
    - name: "scorecard_status"
      expr: scorecard_status
      comment: "Status of the scorecard (draft, published, finalized) — filters to official published scorecards for reporting."
    - name: "period_type"
      expr: period_type
      comment: "Scorecard period type (monthly, quarterly, annual) — used to select the appropriate reporting cadence."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the scorecard period — primary time dimension for annual dealer performance reviews."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the scorecard — used for quarterly business review (QBR) dealer performance analysis."
    - name: "incentive_eligibility_flag"
      expr: incentive_eligibility_flag
      comment: "Boolean indicating whether the dealer is eligible for OEM incentive programs based on scorecard performance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for financial scorecard metrics — required for multi-market revenue normalization."
    - name: "scorecard_period_start_month"
      expr: DATE_TRUNC('MONTH', scorecard_period_start_date)
      comment: "Month of scorecard period start — used for time-series trending of dealer performance scores."
  measures:
    - name: "total_scorecards_published"
      expr: COUNT(1)
      comment: "Total number of performance scorecards. Baseline count for scorecard coverage analysis — ensures all dealers have been evaluated."
    - name: "avg_composite_score"
      expr: AVG(CAST(composite_score AS DOUBLE))
      comment: "Average composite performance score across dealers. The single most important dealer performance KPI — used in QBRs, franchise reviews, and incentive eligibility decisions."
    - name: "avg_csi_score"
      expr: AVG(CAST(csi_score AS DOUBLE))
      comment: "Average Customer Satisfaction Index (CSI) score. Directly tied to OEM brand reputation and dealer incentive eligibility — a mandatory metric in all franchise agreements."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score across dealers. Measures customer loyalty and likelihood to recommend — a leading indicator of future sales and retention."
    - name: "avg_new_vehicle_sales_attainment_pct"
      expr: AVG(CAST(new_vehicle_sales_attainment_pct AS DOUBLE))
      comment: "Average new vehicle sales quota attainment percentage. Measures how well dealers are hitting OEM-assigned sales objectives — core franchise performance metric."
    - name: "avg_used_vehicle_sales_attainment_pct"
      expr: AVG(CAST(used_vehicle_sales_attainment_pct AS DOUBLE))
      comment: "Average used vehicle sales quota attainment percentage. Tracks used vehicle program performance and CPO program participation."
    - name: "avg_service_absorption_rate_pct"
      expr: AVG(CAST(service_absorption_rate_pct AS DOUBLE))
      comment: "Average service absorption rate (fixed ops gross covering dealership overhead). A critical dealer financial health KPI — dealers with >100% absorption are self-sustaining regardless of vehicle sales."
    - name: "avg_inventory_turn_rate"
      expr: AVG(CAST(inventory_turn_rate AS DOUBLE))
      comment: "Average inventory turn rate across dealers. Measures how efficiently dealers are converting inventory to sales — directly impacts floor plan cost and working capital efficiency."
    - name: "avg_market_share_pct"
      expr: AVG(CAST(market_share_pct AS DOUBLE))
      comment: "Average market share percentage across dealer territories. Tracks OEM brand penetration in each dealer's market — a strategic KPI for regional sales planning."
    - name: "avg_parts_fill_rate_pct"
      expr: AVG(CAST(parts_fill_rate_pct AS DOUBLE))
      comment: "Average parts fill rate percentage. Measures parts availability and supply chain effectiveness — directly impacts service throughput and customer satisfaction."
    - name: "avg_training_compliance_pct"
      expr: AVG(CAST(training_compliance_pct AS DOUBLE))
      comment: "Average training compliance percentage. Tracks dealer staff certification and training completion — a franchise requirement and leading indicator of service quality."
    - name: "avg_warranty_claim_approval_rate_pct"
      expr: AVG(CAST(warranty_claim_approval_rate_pct AS DOUBLE))
      comment: "Average warranty claim approval rate. Measures dealer warranty administration quality — low approval rates indicate documentation issues or potential fraud risk."
    - name: "total_service_revenue_actual"
      expr: SUM(CAST(service_revenue_actual AS DOUBLE))
      comment: "Total actual service revenue across all dealer scorecards. Aggregated fixed ops revenue KPI for regional and national service performance reporting."
    - name: "total_parts_revenue_actual"
      expr: SUM(CAST(parts_revenue_actual AS DOUBLE))
      comment: "Total actual parts revenue across all dealer scorecards. Measures parts department performance at network level — key for OEM parts sales planning."
    - name: "avg_delivery_satisfaction_score"
      expr: AVG(CAST(delivery_satisfaction_score AS DOUBLE))
      comment: "Average delivery satisfaction score. Measures customer experience at the critical vehicle delivery moment — a leading indicator of long-term loyalty and repurchase intent."
    - name: "avg_facility_standards_score"
      expr: AVG(CAST(facility_standards_score AS DOUBLE))
      comment: "Average facility standards compliance score. Tracks dealer facility investment and brand standards adherence — required for franchise renewal and incentive eligibility."
    - name: "dealers_above_csi_benchmark"
      expr: COUNT(CASE WHEN csi_score >= csi_benchmark THEN 1 END)
      comment: "Number of dealers meeting or exceeding their CSI benchmark. Measures the proportion of the network delivering acceptable customer satisfaction — used for franchise compliance monitoring."
    - name: "dealers_above_composite_benchmark"
      expr: COUNT(CASE WHEN composite_score >= composite_score_benchmark THEN 1 END)
      comment: "Number of dealers meeting or exceeding their composite score benchmark. Tracks overall network performance health and identifies dealers requiring intervention."
    - name: "incentive_eligible_dealer_count"
      expr: COUNT(CASE WHEN incentive_eligibility_flag = TRUE THEN 1 END)
      comment: "Number of dealers eligible for OEM incentive programs. Directly drives incentive budget allocation and program ROI calculations."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_dealership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dealer network master metrics covering network composition, capability certifications, capacity, and operational status. Used by OEM network development, franchise management, and regional operations teams to assess network coverage and investment needs."
  source: "`vibe_automotive_v1`.`dealer`.`dealership`"
  dimensions:
    - name: "dealer_status"
      expr: dealer_status
      comment: "Operational status of the dealership (active, inactive, suspended) — primary filter for active network analysis."
    - name: "dealer_tier"
      expr: dealer_tier
      comment: "Dealer tier classification — used for tiered support, incentive, and investment allocation decisions."
    - name: "franchise_type"
      expr: franchise_type
      comment: "Type of franchise agreement (full-line, satellite, EV-only) — drives network strategy and investment planning."
    - name: "channel_classification"
      expr: channel_classification
      comment: "Sales channel classification (traditional, digital, agency) — tracks channel transformation progress across the network."
    - name: "country_code"
      expr: country_code
      comment: "Country where the dealership operates — required for geographic network coverage and regulatory compliance analysis."
    - name: "state_province_code"
      expr: state_province_code
      comment: "State or province of the dealership — used for regional network density and coverage gap analysis."
    - name: "market_region_code"
      expr: market_region_code
      comment: "OEM market region code — aligns dealerships to regional sales and operations management structures."
    - name: "ownership_group_name"
      expr: ownership_group_name
      comment: "Dealer group or ownership entity name — used for dealer group consolidation analysis and group-level performance reporting."
    - name: "ev_certified_flag"
      expr: ev_certified
      comment: "Boolean indicating EV sales and service certification — tracks EV network readiness for electrification strategy reporting."
    - name: "home_delivery_enabled_flag"
      expr: home_delivery_enabled_flag
      comment: "Boolean indicating home delivery capability — measures digital retailing and last-mile delivery network coverage."
    - name: "warranty_authorized_flag"
      expr: warranty_authorized
      comment: "Boolean indicating warranty service authorization — identifies dealers authorized to perform warranty repairs."
    - name: "activation_year"
      expr: YEAR(activation_date)
      comment: "Year the dealership was activated — used for network vintage analysis and cohort performance comparisons."
  measures:
    - name: "total_active_dealerships"
      expr: COUNT(1)
      comment: "Total number of dealerships in the network. Baseline network size KPI — used for coverage analysis, market penetration, and network planning."
    - name: "ev_certified_dealer_count"
      expr: COUNT(CASE WHEN ev_certified = TRUE THEN 1 END)
      comment: "Number of EV-certified dealerships. Tracks electrification readiness of the dealer network — a critical OEM strategic KPI for EV rollout planning."
    - name: "home_delivery_enabled_count"
      expr: COUNT(CASE WHEN home_delivery_enabled_flag = TRUE THEN 1 END)
      comment: "Number of dealerships with home delivery capability. Measures digital retailing network coverage — key for OEM e-commerce strategy execution."
    - name: "warranty_authorized_count"
      expr: COUNT(CASE WHEN warranty_authorized = TRUE THEN 1 END)
      comment: "Number of warranty-authorized dealerships. Ensures adequate warranty service coverage across the network — a franchise compliance requirement."
    - name: "pdi_certified_count"
      expr: COUNT(CASE WHEN pdi_certified = TRUE THEN 1 END)
      comment: "Number of PDI-certified dealerships. Tracks delivery quality certification coverage — required for vehicle delivery standard compliance."
    - name: "avg_last_mile_delivery_radius_km"
      expr: AVG(CAST(last_mile_delivery_radius_km AS DOUBLE))
      comment: "Average last-mile delivery radius in kilometers. Measures the geographic reach of home delivery services across the network."
    - name: "total_parts_warehouse_area_sqm"
      expr: SUM(CAST(parts_warehouse_area_sqm AS DOUBLE))
      comment: "Total parts warehouse area in square meters across the network. Measures network-wide parts storage capacity — used for parts distribution and inventory planning."
    - name: "avg_parts_warehouse_area_sqm"
      expr: AVG(CAST(parts_warehouse_area_sqm AS DOUBLE))
      comment: "Average parts warehouse area per dealership. Benchmarks individual dealer parts capacity against network standards."
    - name: "distinct_ownership_groups"
      expr: COUNT(DISTINCT ownership_group_name)
      comment: "Number of distinct dealer ownership groups. Measures dealer group consolidation — high concentration in few groups creates franchise dependency risk."
    - name: "distinct_market_regions"
      expr: COUNT(DISTINCT market_region_code)
      comment: "Number of distinct market regions with active dealerships. Measures geographic coverage breadth of the dealer network."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_vehicle_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle allocation pipeline metrics covering allocation volume, invoice value, incentive deployment, PDI readiness, and delivery performance. Used by OEM supply chain, regional sales teams, and dealer operations to manage vehicle flow from plant to dealer lot."
  source: "`vibe_automotive_v1`.`dealer`.`vehicle_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the vehicle allocation (allocated, accepted, rejected, delivered) — primary filter for pipeline stage analysis."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation (stock order, customer order, fleet) — drives separate stock vs. customer order pipeline reporting."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for vehicle delivery (rail, truck, ship) — used for logistics cost and lead time analysis."
    - name: "priority_tier"
      expr: priority_tier
      comment: "Allocation priority tier — used to analyze whether high-priority allocations are being fulfilled faster than standard allocations."
    - name: "is_customer_order_flag"
      expr: is_customer_order
      comment: "Boolean indicating customer-ordered vs. stock allocation — tracks build-to-order vs. build-to-stock mix."
    - name: "pdi_completed_flag"
      expr: pdi_completed
      comment: "Boolean indicating PDI completion for the allocated vehicle — tracks delivery readiness in the allocation pipeline."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for allocation financial metrics — required for multi-market invoice value normalization."
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month of vehicle allocation — primary time grain for allocation volume trending and production planning alignment."
    - name: "region_code"
      expr: region_code
      comment: "Regional code for the allocation — used for regional supply distribution analysis and equity of allocation reporting."
    - name: "port_of_entry_code"
      expr: port_of_entry_code
      comment: "Port of entry for imported vehicles — used for import logistics analysis and port congestion impact assessment."
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total number of vehicle allocations. Baseline supply pipeline KPI — measures total vehicle flow from OEM to dealer network."
    - name: "total_dealer_invoice_value"
      expr: SUM(CAST(dealer_invoice_price AS DOUBLE))
      comment: "Total dealer invoice value of all allocations. Measures the total wholesale revenue value of the allocation pipeline — key OEM revenue recognition metric."
    - name: "total_msrp_value"
      expr: SUM(CAST(msrp AS DOUBLE))
      comment: "Total MSRP value of allocated vehicles. Represents the gross retail value of the OEM's vehicle supply pipeline to dealers."
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive dollars applied to vehicle allocations. Tracks OEM incentive program spend in the wholesale channel — key for incentive budget management."
    - name: "avg_dealer_invoice_price"
      expr: AVG(CAST(dealer_invoice_price AS DOUBLE))
      comment: "Average dealer invoice price per allocated vehicle. Tracks average wholesale price point and mix shift over time."
    - name: "avg_incentive_per_unit"
      expr: AVG(CAST(incentive_amount AS DOUBLE))
      comment: "Average incentive amount per allocated unit. Measures incentive intensity per vehicle — used to assess program cost efficiency."
    - name: "customer_order_count"
      expr: COUNT(CASE WHEN is_customer_order = TRUE THEN 1 END)
      comment: "Number of customer-ordered vehicle allocations. Tracks build-to-order volume — a key metric for demand-driven production planning and customer satisfaction."
    - name: "pdi_completed_count"
      expr: COUNT(CASE WHEN pdi_completed = TRUE THEN 1 END)
      comment: "Number of allocated vehicles with PDI completed. Measures delivery readiness in the allocation pipeline — PDI completion is required before retail delivery."
    - name: "distinct_dealers_receiving_allocations"
      expr: COUNT(DISTINCT primary_vehicle_dealer_dealership_id)
      comment: "Number of distinct dealerships receiving vehicle allocations. Measures allocation distribution breadth — ensures equitable supply distribution across the network."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_franchise_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise agreement portfolio metrics covering agreement status, financial obligations, territory exclusivity, and compliance requirements. Used by OEM franchise management, legal, and network development teams to govern dealer relationships and manage franchise risk."
  source: "`vibe_automotive_v1`.`dealer`.`franchise_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the franchise agreement (active, expired, terminated, pending renewal) — primary filter for active franchise portfolio analysis."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of franchise agreement (full-line, limited, EV, fleet) — used for franchise portfolio composition analysis."
    - name: "franchise_tier"
      expr: franchise_tier
      comment: "Franchise tier classification — drives tiered obligation, support, and incentive structures."
    - name: "ownership_model"
      expr: ownership_model
      comment: "Dealer ownership model (independent, dealer group, OEM-owned) — used for ownership concentration and risk analysis."
    - name: "exclusive_territory_flag"
      expr: exclusive_territory_flag
      comment: "Boolean indicating exclusive territory rights — tracks exclusivity commitments and potential territory overlap disputes."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Boolean indicating auto-renewal clause — used to forecast upcoming renewal events and manage franchise pipeline."
    - name: "ev_charging_infrastructure_required_flag"
      expr: ev_charging_infrastructure_required_flag
      comment: "Boolean indicating EV charging infrastructure is contractually required — tracks EV readiness obligations across the franchise portfolio."
    - name: "agreement_currency_code"
      expr: agreement_currency_code
      comment: "Currency of the franchise agreement — required for multi-market financial obligation normalization."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the franchise agreement became effective — used for agreement vintage analysis and cohort performance tracking."
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month of agreement expiration — used for renewal pipeline management and franchise risk forecasting."
  measures:
    - name: "total_franchise_agreements"
      expr: COUNT(1)
      comment: "Total number of franchise agreements. Baseline franchise portfolio size KPI — measures the scale of the OEM's dealer network contractual relationships."
    - name: "total_facility_investment_requirement"
      expr: SUM(CAST(facility_investment_requirement_amount AS DOUBLE))
      comment: "Total contractual facility investment requirements across all agreements. Measures the aggregate dealer investment commitment to OEM facility standards — a key network quality investment metric."
    - name: "avg_facility_investment_requirement"
      expr: AVG(CAST(facility_investment_requirement_amount AS DOUBLE))
      comment: "Average facility investment requirement per franchise agreement. Benchmarks investment obligations and tracks standard evolution over time."
    - name: "total_parts_inventory_requirement"
      expr: SUM(CAST(parts_inventory_requirement_amount AS DOUBLE))
      comment: "Total contractual parts inventory investment requirements. Measures aggregate parts stocking obligations — drives OEM parts revenue and service readiness."
    - name: "avg_customer_satisfaction_target"
      expr: AVG(CAST(customer_satisfaction_target_score AS DOUBLE))
      comment: "Average contractual CSI target score across franchise agreements. Tracks the OEM's customer satisfaction standards embedded in franchise contracts."
    - name: "avg_territory_radius_km"
      expr: AVG(CAST(territory_radius_km AS DOUBLE))
      comment: "Average franchise territory radius in kilometers. Measures territory size distribution — used for network density planning and territory overlap risk assessment."
    - name: "exclusive_territory_count"
      expr: COUNT(CASE WHEN exclusive_territory_flag = TRUE THEN 1 END)
      comment: "Number of franchise agreements with exclusive territory rights. Tracks exclusivity commitments that constrain OEM network expansion flexibility."
    - name: "ev_infrastructure_required_count"
      expr: COUNT(CASE WHEN ev_charging_infrastructure_required_flag = TRUE THEN 1 END)
      comment: "Number of franchise agreements requiring EV charging infrastructure. Measures the contractual EV readiness mandate across the network — tracks electrification transition progress."
    - name: "agreements_expiring_within_year"
      expr: COUNT(CASE WHEN expiration_date <= DATE_ADD(CURRENT_DATE(), 365) AND expiration_date >= CURRENT_DATE() THEN 1 END)
      comment: "Number of franchise agreements expiring within the next 12 months. Critical franchise risk KPI — identifies renewal pipeline and potential network attrition risk."
    - name: "auto_renewal_agreement_count"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Number of agreements with auto-renewal clauses. Measures the proportion of the franchise portfolio with automatic continuity — reduces renewal management overhead."
    - name: "distinct_active_franchise_dealers"
      expr: COUNT(DISTINCT primary_franchise_dealer_dealership_id)
      comment: "Number of distinct dealerships with franchise agreements. Measures the active franchised dealer count — the core network size metric for OEM franchise management."
$$;