-- Metric views for domain: dealer | Business: Automotive | Version: 2 | Generated on: 2026-06-23 04:49:37

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_retail_sale`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retail vehicle sales performance metrics covering revenue, gross profit, financing mix, and incentive efficiency at the dealership level. Core KPI view for sales steering meetings and dealer performance reviews."
  source: "`vibe_automotive_v1`.`dealer`.`retail_sale`"
  dimensions:
    - name: "sale_date"
      expr: DATE_TRUNC('month', sale_date)
      comment: "Month of retail sale for trend analysis and period-over-period comparisons."
    - name: "financing_type"
      expr: financing_type
      comment: "Financing method (cash, loan, lease) to analyze F&I product mix and revenue contribution."
    - name: "vehicle_condition"
      expr: vehicle_condition
      comment: "New vs. used vehicle condition to segment sales performance and margin profiles."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Delivery channel (showroom, home delivery, etc.) to evaluate last-mile delivery adoption and cost."
    - name: "model_year"
      expr: model_year
      comment: "Model year of sold vehicle for aging inventory and incentive program analysis."
    - name: "deal_status"
      expr: deal_status
      comment: "Current deal status to filter completed vs. pending transactions."
    - name: "fleet_sale_flag"
      expr: fleet_sale
      comment: "Indicates whether the sale was a fleet transaction, enabling fleet vs. retail revenue segmentation."
  measures:
    - name: "total_retail_sales_count"
      expr: COUNT(1)
      comment: "Total number of retail vehicle sales transactions. Baseline volume KPI for dealer throughput."
    - name: "total_sale_revenue"
      expr: SUM(CAST(sale_price AS DOUBLE))
      comment: "Total retail sale price revenue across all transactions. Primary top-line revenue KPI for dealer performance."
    - name: "total_msrp_value"
      expr: SUM(CAST(msrp_amount AS DOUBLE))
      comment: "Total MSRP value of vehicles sold. Used to compute discount depth and pricing efficiency."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount given across all retail sales. Tracks pricing discipline and incentive spend."
    - name: "total_oem_incentive_amount"
      expr: SUM(CAST(oem_incentive_amount AS DOUBLE))
      comment: "Total OEM incentive dollars applied to retail sales. Measures OEM program utilization and cost to OEM."
    - name: "total_front_end_gross"
      expr: SUM(CAST(front_end_gross AS DOUBLE))
      comment: "Total front-end gross profit (vehicle margin before F&I). Core dealer profitability KPI."
    - name: "total_back_end_gross"
      expr: SUM(CAST(back_end_gross AS DOUBLE))
      comment: "Total back-end gross profit from F&I products. Measures F&I department contribution to dealer profitability."
    - name: "total_fi_product_revenue"
      expr: SUM(CAST(fi_product_revenue AS DOUBLE))
      comment: "Total F&I product revenue (warranties, GAP, protection plans). Key revenue stream beyond vehicle margin."
    - name: "avg_sale_price"
      expr: AVG(CAST(sale_price AS DOUBLE))
      comment: "Average retail sale price per transaction. Tracks pricing trends and mix shift impact."
    - name: "avg_front_end_gross"
      expr: AVG(CAST(front_end_gross AS DOUBLE))
      comment: "Average front-end gross profit per deal. Benchmark for sales consultant performance and pricing strategy."
    - name: "avg_oem_incentive_per_unit"
      expr: AVG(CAST(oem_incentive_amount AS DOUBLE))
      comment: "Average OEM incentive per unit sold. Monitors incentive dependency and program effectiveness."
    - name: "total_trade_in_allowance"
      expr: SUM(CAST(trade_in_allowance AS DOUBLE))
      comment: "Total trade-in allowance granted. Measures used vehicle acquisition cost embedded in new vehicle deals."
    - name: "total_finance_amount"
      expr: SUM(CAST(finance_amount AS DOUBLE))
      comment: "Total amount financed across all retail deals. Indicates captive finance penetration and lender volume."
    - name: "avg_apr"
      expr: AVG(CAST(apr AS DOUBLE))
      comment: "Average APR on financed deals. Tracks financing cost to customers and lender rate competitiveness."
    - name: "pdi_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pdi_completed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of retail sales where PDI was completed before delivery. Measures delivery quality compliance."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_service_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service appointment scheduling and throughput metrics for dealer service operations. Drives service capacity planning, advisor performance, and customer experience management."
  source: "`vibe_automotive_v1`.`dealer`.`dealer_service_appointment`"
  dimensions:
    - name: "dealership_id"
      expr: dealership_id
      comment: "Dealership identifier for service volume and capacity analysis by location."
    - name: "appointment_month"
      expr: DATE_TRUNC('month', appointment_date)
      comment: "Month of appointment for trend analysis and seasonal capacity planning."
    - name: "service_type"
      expr: service_type
      comment: "Type of service (maintenance, repair, recall, warranty) to segment workload and revenue."
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current appointment status (scheduled, completed, no-show, cancelled) for throughput and no-show analysis."
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which appointment was booked (online, phone, walk-in) to measure digital adoption."
    - name: "home_service_flag"
      expr: home_service_flag
      comment: "Indicates mobile/home service appointments to track field service adoption and capacity."
    - name: "loaner_requested_flag"
      expr: loaner_requested_flag
      comment: "Whether a loaner vehicle was requested, driving loaner fleet utilization planning."
  measures:
    - name: "total_appointments"
      expr: COUNT(1)
      comment: "Total number of service appointments. Baseline throughput KPI for service department capacity planning."
    - name: "completed_appointments"
      expr: SUM(CASE WHEN appointment_status = 'COMPLETED' THEN 1 ELSE 0 END)
      comment: "Count of completed service appointments. Measures actual service throughput vs. scheduled volume."
    - name: "no_show_count"
      expr: SUM(CASE WHEN appointment_status = 'NO_SHOW' THEN 1 ELSE 0 END)
      comment: "Count of no-show appointments. High no-show rates indicate scheduling inefficiency and lost service revenue."
    - name: "no_show_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN appointment_status = 'NO_SHOW' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments that resulted in no-shows. Key service efficiency and revenue leakage metric."
    - name: "avg_estimated_duration_hours"
      expr: AVG(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average estimated service duration per appointment. Used for bay utilization and technician scheduling."
    - name: "avg_estimated_labor_hours"
      expr: AVG(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Average estimated labor hours per appointment. Drives technician capacity planning and labor revenue forecasting."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated service cost across all appointments. Forward-looking service revenue indicator."
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per service appointment. Benchmarks service ticket value and pricing adequacy."
    - name: "home_service_appointment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN home_service_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments booked as home/mobile service. Tracks field service channel adoption."
    - name: "loaner_request_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN loaner_requested_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments requiring a loaner vehicle. Drives loaner fleet sizing decisions."
    - name: "online_booking_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN booking_channel = 'ONLINE' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments booked through digital channels. Measures digital service adoption and CX investment ROI."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_repair_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Repair order financial and operational metrics covering labor, parts, warranty, and cycle time performance. Core view for service department profitability and quality management."
  source: "`vibe_automotive_v1`.`dealer`.`order`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "total_repair_orders"
      expr: COUNT(1)
      comment: "Total number of repair orders. Baseline service volume KPI for throughput and capacity management."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_warranty_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warranty claim financial metrics and approval performance. Tracks claim volumes, approval rates, and reimbursement amounts to manage warranty cost exposure and OEM recovery efficiency."
  source: "`vibe_automotive_v1`.`dealer`.`dealer_warranty_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Warranty claim status (submitted, approved, rejected, paid) for pipeline and approval rate analysis."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of warranty claim (goodwill, policy, warranty) to segment cost exposure by claim category."
    - name: "claim_date_month"
      expr: DATE_TRUNC('month', claim_date)
      comment: "Month of claim submission for trend analysis and warranty reserve planning."
    - name: "failure_code"
      expr: failure_code
      comment: "Failure code to identify top failure modes driving warranty cost and quality improvement priorities."
    - name: "home_pickup_flag"
      expr: home_pickup_flag
      comment: "Indicates claims involving home pickup service to track mobile warranty service cost."
  measures:
    - name: "total_warranty_claims"
      expr: COUNT(1)
      comment: "Total number of warranty claims submitted. Baseline volume KPI for warranty program management."
    - name: "total_claimed_amount"
      expr: SUM(CAST(claimed_amount AS DOUBLE))
      comment: "Total amount claimed across all warranty submissions. Measures gross warranty cost exposure."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total amount approved for reimbursement. Measures actual OEM warranty cost recovery."
    - name: "total_labor_amount"
      expr: SUM(CAST(labor_amount AS DOUBLE))
      comment: "Total labor cost component of warranty claims. Tracks labor-driven warranty expense."
    - name: "total_parts_amount"
      expr: SUM(CAST(parts_amount AS DOUBLE))
      comment: "Total parts cost component of warranty claims. Tracks parts-driven warranty expense and supplier recovery potential."
    - name: "claim_approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN claim_status = 'APPROVED' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of warranty claims approved. Low approval rates indicate documentation quality issues or policy disputes."
    - name: "avg_claim_amount"
      expr: AVG(CAST(claimed_amount AS DOUBLE))
      comment: "Average warranty claim amount per submission. Benchmarks claim severity and warranty reserve adequacy."
    - name: "avg_approved_amount"
      expr: AVG(CAST(approved_amount AS DOUBLE))
      comment: "Average approved reimbursement per claim. Measures OEM reimbursement adequacy vs. actual repair cost."
    - name: "approval_recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(approved_amount AS DOUBLE)) / NULLIF(SUM(CAST(claimed_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of approved amount to claimed amount. Measures how much of claimed warranty cost is recovered from OEM."
    - name: "avg_labor_hours_per_claim"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labor hours per warranty claim. Benchmarks repair complexity and technician efficiency on warranty work."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_csi_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer satisfaction index (CSI) metrics covering overall satisfaction, NPS, and departmental scores. Drives dealer performance management, incentive eligibility, and customer experience investment decisions."
  source: "`vibe_automotive_v1`.`dealer`.`csi_survey`"
  dimensions:
    - name: "dealership_id"
      expr: csi_dealership_id
      comment: "Dealership identifier for CSI performance benchmarking and ranking."
    - name: "survey_month"
      expr: DATE_TRUNC('month', survey_date)
      comment: "Month of survey for trend analysis and period-over-period CSI tracking."
    - name: "survey_type"
      expr: survey_type
      comment: "Survey type (sales, service, delivery) to segment satisfaction scores by customer touchpoint."
    - name: "nps_category"
      expr: nps_category
      comment: "NPS category (Promoter, Passive, Detractor) for loyalty segmentation and advocacy analysis."
    - name: "complaint_flag"
      expr: complaint_flag
      comment: "Indicates surveys with formal complaints to track complaint incidence and resolution effectiveness."
    - name: "response_channel"
      expr: response_channel
      comment: "Channel through which survey was completed (email, phone, online) for response bias analysis."
    - name: "market_code"
      expr: market_code
      comment: "Market code for regional CSI benchmarking and competitive positioning."
  measures:
    - name: "total_surveys"
      expr: COUNT(1)
      comment: "Total number of CSI surveys completed. Baseline response volume for statistical significance assessment."
    - name: "avg_overall_satisfaction_score"
      expr: AVG(CAST(overall_satisfaction_score AS DOUBLE))
      comment: "Average overall customer satisfaction score. Primary CSI KPI used in dealer incentive eligibility and OEM rankings."
    - name: "avg_sales_consultant_score"
      expr: AVG(CAST(sales_consultant_score AS DOUBLE))
      comment: "Average sales consultant satisfaction score. Drives individual sales staff coaching and performance management."
    - name: "avg_service_quality_score"
      expr: AVG(CAST(service_quality_score AS DOUBLE))
      comment: "Average service quality satisfaction score. Key metric for service department quality improvement programs."
    - name: "avg_service_timeliness_score"
      expr: AVG(CAST(service_timeliness_score AS DOUBLE))
      comment: "Average service timeliness score. Measures customer perception of service speed and appointment adherence."
    - name: "avg_delivery_process_score"
      expr: AVG(CAST(delivery_process_score AS DOUBLE))
      comment: "Average vehicle delivery process satisfaction score. Tracks delivery experience quality and PDI effectiveness."
    - name: "avg_facility_cleanliness_score"
      expr: AVG(CAST(facility_cleanliness_score AS DOUBLE))
      comment: "Average facility cleanliness score. Measures facility standard compliance from customer perspective."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score. Strategic loyalty metric used in executive dashboards and dealer ranking programs."
    - name: "complaint_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN complaint_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of surveys with formal complaints. High complaint rates trigger dealer intervention and corrective action."
    - name: "oem_program_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN oem_program_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of surveys indicating OEM program compliance. Measures adherence to OEM customer experience standards."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score from verbatim analysis. Provides unstructured feedback signal to complement structured scores."
    - name: "survey_completion_rate"
      expr: AVG(CAST(survey_completion_percentage AS DOUBLE))
      comment: "Average survey completion percentage. Low completion rates indicate survey fatigue or poor customer engagement."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dealer vehicle inventory metrics covering stock value, aging, pricing, and PDI compliance. Drives inventory turn management, floor plan cost optimization, and allocation decisions."
  source: "`vibe_automotive_v1`.`dealer`.`dealer_inventory`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current inventory status (available, sold, in-transit, hold) for stock availability analysis."
    - name: "inventory_type"
      expr: inventory_type
      comment: "Inventory type (new, used, CPO, demo) to segment stock value and turn metrics by vehicle category."
    - name: "body_style"
      expr: body_style
      comment: "Vehicle body style for mix analysis and allocation planning."
    - name: "certified_pre_owned"
      expr: certified_pre_owned
      comment: "CPO flag to segment certified pre-owned inventory for program compliance and pricing analysis."
    - name: "recall_hold"
      expr: recall_hold
      comment: "Recall hold flag to identify vehicles blocked from sale due to open recall campaigns."
    - name: "pdi_completed"
      expr: pdi_completed
      comment: "PDI completion status to track delivery readiness and compliance across inventory."
    - name: "source_type"
      expr: source_type
      comment: "Vehicle source type (factory order, trade-in, auction) for acquisition channel analysis."
  measures:
    - name: "total_units_in_stock"
      expr: COUNT(1)
      comment: "Total vehicle units in dealer inventory. Baseline stock level KPI for days supply calculation."
    - name: "total_msrp_value"
      expr: SUM(CAST(msrp AS DOUBLE))
      comment: "Total MSRP value of dealer inventory. Measures gross inventory investment and floor plan exposure."
    - name: "total_invoice_value"
      expr: SUM(CAST(invoice_price AS DOUBLE))
      comment: "Total invoice price value of inventory. Measures actual dealer cost basis for floor plan financing."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of inventory. Tracks total capital deployed in vehicle stock."
    - name: "avg_asking_price"
      expr: AVG(CAST(asking_price AS DOUBLE))
      comment: "Average asking price across inventory. Monitors pricing strategy and discount depth vs. MSRP."
    - name: "avg_msrp"
      expr: AVG(CAST(msrp AS DOUBLE))
      comment: "Average MSRP of inventory units. Tracks mix shift toward higher or lower value vehicles."
    - name: "recall_hold_units"
      expr: SUM(CASE WHEN recall_hold = TRUE THEN 1 ELSE 0 END)
      comment: "Count of vehicles on recall hold. Measures inventory blocked from sale due to safety campaigns."
    - name: "pdi_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pdi_completed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inventory units with PDI completed. Measures delivery readiness and quality compliance."
    - name: "avg_fuel_economy_city"
      expr: AVG(CAST(fuel_economy_city_mpg AS DOUBLE))
      comment: "Average city fuel economy of inventory. Tracks fleet efficiency mix for regulatory and customer demand alignment."
    - name: "avg_fuel_economy_highway"
      expr: AVG(CAST(fuel_economy_highway_mpg AS DOUBLE))
      comment: "Average highway fuel economy of inventory. Supports emissions compliance and customer value proposition analysis."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_performance_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dealer performance scorecard metrics aggregating sales attainment, CSI, NPS, parts fill rate, and service absorption. Primary executive view for dealer network health and incentive eligibility management."
  source: "`vibe_automotive_v1`.`dealer`.`performance_scorecard`"
  dimensions:
    - name: "dealership_id"
      expr: performance_dealership_id
      comment: "Dealership identifier for individual dealer performance ranking and benchmarking."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual performance review and target-setting cycles."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for quarterly business review (QBR) performance tracking."
    - name: "performance_tier"
      expr: performance_tier
      comment: "Dealer performance tier (Platinum, Gold, Silver, etc.) for tiered incentive program eligibility."
    - name: "franchise_compliance_status"
      expr: franchise_compliance_status
      comment: "Franchise compliance status to identify dealers at risk of agreement breach or termination."
    - name: "incentive_eligibility_flag"
      expr: incentive_eligibility_flag
      comment: "Whether dealer is eligible for incentive programs based on scorecard performance."
    - name: "period_type"
      expr: period_type
      comment: "Scorecard period type (monthly, quarterly, annual) for appropriate aggregation context."
  measures:
    - name: "avg_composite_score"
      expr: AVG(CAST(composite_score AS DOUBLE))
      comment: "Average composite dealer performance score. Primary KPI for dealer network health and ranking."
    - name: "avg_csi_score"
      expr: AVG(CAST(csi_score AS DOUBLE))
      comment: "Average CSI score across dealers. Tracks customer satisfaction performance vs. OEM benchmark."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average NPS score across dealers. Measures customer loyalty and advocacy at network level."
    - name: "avg_new_vehicle_sales_attainment"
      expr: AVG(CAST(new_vehicle_sales_attainment_pct AS DOUBLE))
      comment: "Average new vehicle sales attainment percentage vs. objective. Core sales performance KPI for dealer network."
    - name: "avg_used_vehicle_sales_attainment"
      expr: AVG(CAST(used_vehicle_sales_attainment_pct AS DOUBLE))
      comment: "Average used vehicle sales attainment percentage. Tracks used vehicle program performance across dealer network."
    - name: "avg_parts_fill_rate"
      expr: AVG(CAST(parts_fill_rate_pct AS DOUBLE))
      comment: "Average parts fill rate percentage. Measures parts availability and supply chain effectiveness at dealer level."
    - name: "avg_service_absorption_rate"
      expr: AVG(CAST(service_absorption_rate_pct AS DOUBLE))
      comment: "Average service absorption rate (service gross covering fixed overhead). Key dealer financial health metric."
    - name: "avg_inventory_turn_rate"
      expr: AVG(CAST(inventory_turn_rate AS DOUBLE))
      comment: "Average inventory turn rate. Measures how efficiently dealers are converting stock to sales."
    - name: "avg_market_share_pct"
      expr: AVG(CAST(market_share_pct AS DOUBLE))
      comment: "Average market share percentage by dealer territory. Tracks competitive positioning and conquest performance."
    - name: "avg_warranty_claim_approval_rate"
      expr: AVG(CAST(warranty_claim_approval_rate_pct AS DOUBLE))
      comment: "Average warranty claim approval rate. Measures dealer documentation quality and OEM reimbursement efficiency."
    - name: "total_parts_revenue"
      expr: SUM(CAST(parts_revenue_actual AS DOUBLE))
      comment: "Total actual parts revenue across dealer network. Measures parts department contribution to dealer group revenue."
    - name: "total_service_revenue"
      expr: SUM(CAST(service_revenue_actual AS DOUBLE))
      comment: "Total actual service revenue across dealer network. Measures aftersales revenue stream at network level."
    - name: "incentive_eligible_dealer_count"
      expr: SUM(CASE WHEN incentive_eligibility_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of dealers eligible for incentive programs. Measures program reach and dealer network quality threshold attainment."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_incentive_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dealer incentive claim financial metrics covering claim volumes, approval rates, payout amounts, and dispute management. Drives incentive program ROI analysis and budget management."
  source: "`vibe_automotive_v1`.`dealer`.`dealer_incentive_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Claim status (submitted, approved, rejected, paid) for pipeline and approval rate analysis."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of incentive claim (volume bonus, CSI bonus, floor plan support) for program cost segmentation."
    - name: "claim_period_month"
      expr: DATE_TRUNC('month', claim_period_start_date)
      comment: "Claim period month for trend analysis and budget accrual management."
    - name: "program_year"
      expr: program_year
      comment: "Program year for annual incentive budget tracking and year-over-year comparison."
    - name: "region_code"
      expr: region_code
      comment: "Sales region for regional incentive spend analysis and budget allocation."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates disputed claims to track dispute volume and resolution efficiency."
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of incentive claims submitted. Baseline volume KPI for program utilization."
    - name: "total_claimed_amount"
      expr: SUM(CAST(claimed_amount AS DOUBLE))
      comment: "Total amount claimed across all incentive submissions. Measures gross incentive program liability."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved incentive amount. Measures actual incentive program cost to OEM."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total incentive amount paid out. Tracks cash outflow from incentive programs and payment timing."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total claim adjustment amount. Measures correction volume and potential documentation quality issues."
    - name: "claim_approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN claim_status = 'APPROVED' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incentive claims approved. Low rates indicate eligibility issues or documentation gaps."
    - name: "avg_approved_amount_per_claim"
      expr: AVG(CAST(approved_amount AS DOUBLE))
      comment: "Average approved incentive amount per claim. Benchmarks incentive value per dealer transaction."
    - name: "dispute_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims with disputes. High dispute rates indicate program rule ambiguity or dealer dissatisfaction."
    - name: "payment_recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(approved_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of paid to approved incentive amounts. Measures payment processing efficiency and cash flow timing."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_floor_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Floor plan financing metrics covering outstanding balances, interest costs, aging, and curtailment performance. Critical for managing dealer capital efficiency and OEM financial exposure."
  source: "`vibe_automotive_v1`.`dealer`.`floor_plan`"
  dimensions:
    - name: "dealership_id"
      expr: floor_dealership_id
      comment: "Dealership identifier for floor plan exposure analysis by dealer."
    - name: "floor_plan_status"
      expr: floor_plan_status
      comment: "Current floor plan status (active, paid off, defaulted) for portfolio health monitoring."
    - name: "financing_institution_code"
      expr: financing_institution_code
      comment: "Lender code to analyze floor plan portfolio by financing institution."
    - name: "aged_inventory_flag"
      expr: aged_inventory_flag
      comment: "Indicates aged inventory units to track high-cost floor plan exposure on slow-moving stock."
    - name: "default_flag"
      expr: default_flag
      comment: "Indicates defaulted floor plan units to monitor credit risk and OEM financial exposure."
    - name: "financing_start_month"
      expr: DATE_TRUNC('month', financing_start_date)
      comment: "Month floor plan financing started for cohort aging analysis."
  measures:
    - name: "total_floor_plan_units"
      expr: COUNT(1)
      comment: "Total number of vehicles on floor plan financing. Baseline inventory financing volume KPI."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance_amount AS DOUBLE))
      comment: "Total outstanding floor plan balance across all units. Measures total dealer financing exposure."
    - name: "total_credit_line"
      expr: SUM(CAST(credit_line_amount AS DOUBLE))
      comment: "Total approved floor plan credit line. Measures total financing capacity extended to dealer network."
    - name: "total_interest_paid"
      expr: SUM(CAST(total_interest_paid AS DOUBLE))
      comment: "Total floor plan interest paid. Measures carrying cost of dealer inventory financing."
    - name: "total_daily_interest"
      expr: SUM(CAST(daily_interest_amount AS DOUBLE))
      comment: "Total daily interest accruing across all floor plan units. Tracks daily financing cost run rate."
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate_pct AS DOUBLE))
      comment: "Average floor plan interest rate. Benchmarks financing cost and lender rate competitiveness."
    - name: "total_oem_assistance"
      expr: SUM(CAST(oem_assistance_amount AS DOUBLE))
      comment: "Total OEM floor plan assistance provided. Measures OEM subsidy investment in dealer inventory financing."
    - name: "default_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN default_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of floor plan units in default. Key credit risk metric for OEM and lender portfolio management."
    - name: "aged_inventory_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN aged_inventory_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of floor plan units classified as aged inventory. Drives incentive and clearance program decisions."
    - name: "credit_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(outstanding_balance_amount AS DOUBLE)) / NULLIF(SUM(CAST(credit_line_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of outstanding balance to approved credit line. Measures floor plan credit utilization and dealer liquidity."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_recall_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recall campaign completion metrics tracking remedy rates, reimbursement recovery, and labor efficiency. Critical for regulatory compliance reporting, NHTSA obligations, and OEM liability management."
  source: "`vibe_automotive_v1`.`dealer`.`recall_completion`"
  dimensions:
    - name: "dealership_id"
      expr: recall_dealership_id
      comment: "Dealership identifier for recall completion rate analysis by dealer."
    - name: "recall_campaign_number"
      expr: recall_campaign_number
      comment: "Recall campaign identifier for campaign-level completion tracking and regulatory reporting."
    - name: "completion_status"
      expr: completion_status
      comment: "Recall completion status (completed, pending, parts-on-order) for pipeline management."
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of recall campaign (safety recall, service campaign, TSB) for regulatory classification."
    - name: "completion_month"
      expr: DATE_TRUNC('month', completion_date)
      comment: "Month of recall completion for trend analysis and regulatory deadline tracking."
    - name: "nhtsa_report_flag"
      expr: nhtsa_report_flag
      comment: "Indicates completions reported to NHTSA for regulatory compliance monitoring."
    - name: "home_service_completion_flag"
      expr: home_service_completion_flag
      comment: "Indicates recalls completed via mobile/home service to track field service recall execution."
  measures:
    - name: "total_recall_completions"
      expr: COUNT(1)
      comment: "Total recall remedy completions. Baseline KPI for recall campaign execution progress."
    - name: "total_labor_amount"
      expr: SUM(CAST(labor_amount AS DOUBLE))
      comment: "Total labor cost for recall remedies. Measures OEM reimbursement liability for recall labor."
    - name: "total_parts_amount"
      expr: SUM(CAST(parts_amount AS DOUBLE))
      comment: "Total parts cost for recall remedies. Measures OEM parts cost exposure for recall campaigns."
    - name: "total_reimbursement_amount"
      expr: SUM(CAST(total_reimbursement_amount AS DOUBLE))
      comment: "Total reimbursement claimed for recall completions. Measures OEM financial liability for recall program."
    - name: "avg_labor_hours_per_recall"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labor hours per recall completion. Benchmarks remedy complexity and technician efficiency."
    - name: "nhtsa_reporting_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN nhtsa_report_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recall completions reported to NHTSA. Measures regulatory reporting compliance."
    - name: "quality_verification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN quality_verification_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recall completions with quality verification performed. Measures post-repair quality assurance compliance."
    - name: "home_service_recall_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN home_service_completion_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recalls completed via mobile/home service. Tracks field service recall execution capability."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_dealership_quality_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dealership quality assessment scores across facility, service, sales, and compliance dimensions. Drives dealer certification decisions, corrective action programs, and network quality investment."
  source: "`vibe_automotive_v1`.`dealer`.`dealership_quality_assessment`"
  dimensions:
    - name: "dealership_id"
      expr: dealership_id
      comment: "Dealership identifier for quality assessment benchmarking and ranking."
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of quality assessment (annual audit, spot check, certification) for appropriate score comparison."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status (compliant, non-compliant, conditional) for network health monitoring."
    - name: "is_certified"
      expr: is_certified
      comment: "Certification outcome flag to track certified vs. non-certified dealer count."
    - name: "assessment_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month of assessment for trend analysis and certification cycle management."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of dealership quality assessments conducted. Baseline audit program coverage KPI."
    - name: "avg_overall_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average overall compliance score across assessments. Primary dealer quality network health KPI."
    - name: "avg_facility_score"
      expr: AVG(CAST(facility_score AS DOUBLE))
      comment: "Average facility quality score. Measures physical facility standard compliance across dealer network."
    - name: "avg_service_score"
      expr: AVG(CAST(service_score AS DOUBLE))
      comment: "Average service department quality score. Tracks service process compliance and quality standards."
    - name: "avg_sales_score"
      expr: AVG(CAST(sales_score AS DOUBLE))
      comment: "Average sales process quality score. Measures sales compliance with OEM standards and customer experience requirements."
    - name: "avg_customer_experience_score"
      expr: AVG(CAST(customer_experience_score AS DOUBLE))
      comment: "Average customer experience quality score. Tracks CX standard compliance across dealer network."
    - name: "avg_ev_readiness_score"
      expr: AVG(CAST(ev_readiness_score AS DOUBLE))
      comment: "Average EV readiness score. Measures dealer network preparedness for electric vehicle sales and service."
    - name: "avg_digital_readiness_score"
      expr: AVG(CAST(digital_readiness_score AS DOUBLE))
      comment: "Average digital readiness score. Tracks dealer adoption of digital retailing and DMS integration capabilities."
    - name: "certification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_certified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments resulting in certification. Measures dealer network quality standard attainment."
    - name: "avg_audit_duration_hours"
      expr: AVG(CAST(audit_duration_hours AS DOUBLE))
      comment: "Average audit duration in hours. Benchmarks assessment thoroughness and resource planning for audit programs."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_parts_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dealer parts inventory metrics covering stock levels, fill rates, pricing, and obsolescence. Drives parts department profitability, supply chain efficiency, and customer service level management."
  source: "`vibe_automotive_v1`.`dealer`.`parts_inventory`"
  dimensions:
    - name: "dealership_id"
      expr: parts_dealership_id
      comment: "Dealership identifier for parts inventory analysis by dealer location."
    - name: "inventory_status"
      expr: inventory_status
      comment: "Parts inventory status (active, obsolete, superseded) for stock health analysis."
    - name: "parts_classification"
      expr: parts_classification
      comment: "Parts classification (fast-mover, slow-mover, critical) for inventory optimization and stocking strategy."
    - name: "parts_group_code"
      expr: parts_group_code
      comment: "Parts group code for category-level inventory analysis and purchasing decisions."
    - name: "recall_flag"
      expr: recall_flag
      comment: "Indicates recall-related parts to track recall parts availability and campaign readiness."
    - name: "is_hazardous_material"
      expr: is_hazardous_material
      comment: "Hazardous material flag for compliance and dangerous goods handling tracking."
    - name: "warranty_eligible"
      expr: warranty_eligible
      comment: "Warranty eligibility flag to segment parts inventory by warranty vs. customer-pay usage."
  measures:
    - name: "total_sku_count"
      expr: COUNT(1)
      comment: "Total number of parts SKUs stocked. Measures breadth of parts inventory coverage."
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total parts quantity on hand. Baseline stock level KPI for parts availability management."
    - name: "total_quantity_on_order"
      expr: SUM(CAST(quantity_on_order AS DOUBLE))
      comment: "Total parts quantity on order. Measures replenishment pipeline and inbound supply coverage."
    - name: "total_inventory_value_at_cost"
      expr: SUM(CAST(dealer_cost_price AS DOUBLE) * CAST(quantity_on_hand AS DOUBLE))
      comment: "Total parts inventory value at dealer cost. Measures capital invested in parts stock."
    - name: "total_inventory_value_at_retail"
      expr: SUM(CAST(retail_price AS DOUBLE) * CAST(quantity_on_hand AS DOUBLE))
      comment: "Total parts inventory value at retail price. Measures potential revenue from current parts stock."
    - name: "avg_months_supply"
      expr: AVG(CAST(months_supply AS DOUBLE))
      comment: "Average months of supply across parts inventory. Identifies overstocked and understocked parts categories."
    - name: "avg_monthly_demand"
      expr: AVG(CAST(average_monthly_demand AS DOUBLE))
      comment: "Average monthly demand per SKU. Drives reorder point and safety stock calculations."
    - name: "lost_sales_quantity_total"
      expr: SUM(CAST(lost_sales_quantity AS DOUBLE))
      comment: "Total lost sales quantity due to stockouts. Measures revenue leakage from parts unavailability."
    - name: "avg_list_price"
      expr: AVG(CAST(list_price AS DOUBLE))
      comment: "Average parts list price. Benchmarks pricing strategy and margin management across parts portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_service_capacity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dealer service capacity utilization metrics covering bay utilization, technician productivity, and EV/ADAS readiness. Drives capacity investment decisions and service network planning."
  source: "`vibe_automotive_v1`.`dealer`.`service_capacity`"
  dimensions:
    - name: "dealership_id"
      expr: service_dealership_id
      comment: "Dealership identifier for service capacity benchmarking across dealer network."
    - name: "capacity_status"
      expr: capacity_status
      comment: "Current capacity status (at capacity, under capacity, over capacity) for network planning."
    - name: "effective_period_start"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Effective period start month for capacity trend analysis."
    - name: "has_mobile_service_capability"
      expr: has_mobile_service_capability
      comment: "Mobile service capability flag to segment dealers by field service readiness."
  measures:
    - name: "avg_capacity_utilization_pct"
      expr: AVG(CAST(current_capacity_utilization_pct AS DOUBLE))
      comment: "Average service bay capacity utilization percentage. Primary capacity management KPI for service network planning."
    - name: "avg_available_labor_hours_per_day"
      expr: AVG(CAST(available_labor_hours_per_day AS DOUBLE))
      comment: "Average available labor hours per day. Measures total service throughput capacity across dealer network."
    - name: "avg_ro_cycle_time_hours"
      expr: AVG(CAST(avg_ro_cycle_time_hours AS DOUBLE))
      comment: "Average repair order cycle time in hours. Key service efficiency metric driving customer satisfaction and bay throughput."
    - name: "avg_warranty_work_capacity_pct"
      expr: AVG(CAST(warranty_work_capacity_pct AS DOUBLE))
      comment: "Average percentage of service capacity allocated to warranty work. Tracks warranty workload burden on service operations."
    - name: "avg_customer_pay_capacity_pct"
      expr: AVG(CAST(customer_pay_capacity_pct AS DOUBLE))
      comment: "Average percentage of service capacity allocated to customer-pay work. Measures revenue-generating capacity utilization."
    - name: "avg_loaner_fleet_utilization_pct"
      expr: AVG(CAST(loaner_fleet_utilization_pct AS DOUBLE))
      comment: "Average loaner fleet utilization percentage. Measures loaner asset efficiency and sizing adequacy."
    - name: "avg_hours_per_shift"
      expr: AVG(CAST(hours_per_shift AS DOUBLE))
      comment: "Average productive hours per shift. Benchmarks shift efficiency and scheduling effectiveness."
    - name: "mobile_service_capable_dealer_count"
      expr: SUM(CASE WHEN has_mobile_service_capability = TRUE THEN 1 ELSE 0 END)
      comment: "Count of dealers with mobile service capability. Tracks field service network coverage expansion."
    - name: "avg_target_utilization_pct"
      expr: AVG(CAST(target_capacity_utilization_pct AS DOUBLE))
      comment: "Average target capacity utilization percentage. Benchmarks actual utilization against planned targets."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_test_drive`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test drive activity and conversion metrics. Tracks test drive volume, home test drive adoption, and outcome rates to measure sales funnel effectiveness and digital/home delivery channel performance."
  source: "`vibe_automotive_v1`.`dealer`.`dealer_test_drive`"
  dimensions:
    - name: "dealership_id"
      expr: dealership_id
      comment: "Dealership identifier for test drive volume and conversion analysis by location."
    - name: "test_drive_month"
      expr: DATE_TRUNC('month', test_drive_date)
      comment: "Month of test drive for trend analysis and sales funnel tracking."
    - name: "test_drive_status"
      expr: test_drive_status
      comment: "Test drive status (completed, cancelled, no-show) for funnel conversion analysis."
    - name: "outcome"
      expr: outcome
      comment: "Test drive outcome (purchase intent, follow-up, no interest) to measure sales conversion effectiveness."
    - name: "home_test_drive_flag"
      expr: home_test_drive_flag
      comment: "Indicates home/mobile test drives to track at-home delivery channel adoption and conversion."
    - name: "route_type"
      expr: route_type
      comment: "Test drive route type for experience quality analysis."
  measures:
    - name: "total_test_drives"
      expr: COUNT(1)
      comment: "Total number of test drives conducted. Baseline sales funnel activity KPI."
    - name: "completed_test_drives"
      expr: SUM(CASE WHEN test_drive_status = 'COMPLETED' THEN 1 ELSE 0 END)
      comment: "Count of completed test drives. Measures actual test drive throughput vs. scheduled volume."
    - name: "home_test_drive_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN home_test_drive_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of test drives conducted at customer home. Tracks home delivery channel adoption and direct-to-consumer strategy execution."
    - name: "purchase_intent_conversion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN outcome = 'PURCHASE_INTENT' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN test_drive_status = 'COMPLETED' THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of completed test drives resulting in purchase intent. Key sales funnel conversion KPI."
    - name: "unique_vehicles_test_driven"
      expr: COUNT(DISTINCT vin)
      comment: "Count of distinct vehicles used for test drives. Measures demo fleet utilization breadth."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`dealer_vehicle_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle allocation metrics covering allocation volumes, acceptance rates, delivery performance, and incentive utilization. Drives production planning alignment, dealer satisfaction, and inventory pipeline management."
  source: "`vibe_automotive_v1`.`dealer`.`vehicle_allocation`"
  dimensions:
    - name: "dealership_id"
      expr: vehicle_dealership_id
      comment: "Dealership identifier for allocation analysis by dealer."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Allocation status (allocated, accepted, rejected, delivered) for pipeline tracking."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Allocation type (stock, customer order, demo) for demand-driven vs. stock allocation analysis."
    - name: "region_code"
      expr: region_code
      comment: "Sales region for regional allocation distribution analysis."
    - name: "allocation_month"
      expr: DATE_TRUNC('month', allocation_date)
      comment: "Month of allocation for production pipeline and delivery timing analysis."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode (rail, truck, ship) for logistics cost and lead time analysis."
    - name: "is_customer_order"
      expr: is_customer_order
      comment: "Indicates customer-specific orders vs. stock allocations for build-to-order vs. build-to-stock analysis."
    - name: "pdi_required"
      expr: pdi_required
      comment: "PDI requirement flag to track PDI workload in allocation pipeline."
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total vehicle allocations issued. Baseline production-to-dealer pipeline volume KPI."
    - name: "total_dealer_invoice_value"
      expr: SUM(CAST(dealer_invoice_price AS DOUBLE))
      comment: "Total dealer invoice value of allocated vehicles. Measures wholesale revenue pipeline from production to dealer."
    - name: "total_msrp_value"
      expr: SUM(CAST(msrp AS DOUBLE))
      comment: "Total MSRP value of allocated vehicles. Measures retail value of production pipeline."
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive amount applied to allocations. Measures OEM incentive investment in allocation pipeline."
    - name: "avg_dealer_invoice_price"
      expr: AVG(CAST(dealer_invoice_price AS DOUBLE))
      comment: "Average dealer invoice price per allocated unit. Tracks mix shift and pricing trends in allocation pipeline."
    - name: "pdi_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pdi_completed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocated vehicles with PDI completed. Measures delivery quality compliance in allocation pipeline."
    - name: "customer_order_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_customer_order = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocations that are customer-specific orders. Measures build-to-order demand vs. stock production."
$$;