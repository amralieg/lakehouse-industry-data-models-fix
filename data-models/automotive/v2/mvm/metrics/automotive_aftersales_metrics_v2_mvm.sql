-- Metric views for domain: aftersales | Business: Automotive | Version: 2 | Generated on: 2026-06-23 05:54:22

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_repair_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core repair order KPIs covering revenue, cost efficiency, labor productivity, warranty exposure, and service quality for aftersales operations steering."
  source: "`vibe_automotive_v1`.`aftersales`.`aftersales_repair_order`"
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Type of service performed (e.g. maintenance, repair, recall) — primary segmentation for service mix analysis."
    - name: "aftersales_repair_order_status"
      expr: aftersales_repair_order_status
      comment: "Current status of the repair order (open, closed, in-progress) — used to filter active vs. completed work."
    - name: "service_center_region"
      expr: service_center_region
      comment: "Geographic region of the service center — enables regional performance benchmarking."
    - name: "warranty_flag"
      expr: warranty_flag
      comment: "Indicates whether the repair order is covered under warranty — critical for cost allocation between warranty and customer-pay."
    - name: "warranty_type"
      expr: warranty_type
      comment: "Type of warranty coverage applied (e.g. bumper-to-bumper, powertrain, extended) — informs warranty cost exposure by coverage category."
    - name: "service_priority"
      expr: service_priority
      comment: "Priority level assigned to the repair order — used to assess urgency distribution and SLA compliance."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the repair order — supports revenue collection and financing mix analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the repair order — used to track outstanding receivables."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the repair order is denominated — required for multi-currency revenue reporting."
    - name: "triggered_by_telemetry_flag"
      expr: triggered_by_telemetry_flag
      comment: "Indicates whether the repair order was triggered by connected vehicle telemetry — measures proactive service adoption."
    - name: "open_month"
      expr: DATE_TRUNC('MONTH', open_timestamp)
      comment: "Month the repair order was opened — used for trend analysis of repair order volume over time."
    - name: "close_month"
      expr: DATE_TRUNC('MONTH', close_timestamp)
      comment: "Month the repair order was closed — used for throughput and cycle-time trend analysis."
    - name: "customer_feedback_score"
      expr: customer_feedback_score
      comment: "Customer satisfaction score recorded at repair order close — key quality and loyalty indicator."
  measures:
    - name: "total_repair_order_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total billed revenue across all repair orders — primary top-line aftersales revenue KPI used in P&L and QBR reporting."
    - name: "total_labor_revenue"
      expr: SUM(CAST(labor_total_cost AS DOUBLE))
      comment: "Total labor revenue billed to customers — measures labor monetization and technician productivity contribution."
    - name: "total_parts_revenue"
      expr: SUM(CAST(parts_total_cost AS DOUBLE))
      comment: "Total parts revenue billed — measures parts sales contribution to aftersales gross profit."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied across repair orders — monitors discount leakage and promotional cost impact."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on repair orders — required for tax compliance and regulatory reporting."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net revenue after discounts — core profitability measure for aftersales operations."
    - name: "avg_repair_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average revenue per repair order — key efficiency KPI; declining ARO signals mix shift or pricing pressure."
    - name: "avg_labor_hours_per_ro"
      expr: AVG(CAST(labor_total_hours AS DOUBLE))
      comment: "Average labor hours consumed per repair order — measures job complexity and technician workload intensity."
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_total_hours AS DOUBLE))
      comment: "Total labor hours billed across all repair orders — used to compute technician utilization and capacity planning."
    - name: "avg_labor_rate_per_hour"
      expr: AVG(CAST(labor_rate_per_hour AS DOUBLE))
      comment: "Average effective labor rate per hour — monitors pricing consistency and rate card adherence across service centers."
    - name: "repair_order_count"
      expr: COUNT(1)
      comment: "Total number of repair orders — baseline volume KPI for throughput, capacity, and trend analysis."
    - name: "warranty_repair_order_count"
      expr: COUNT(CASE WHEN warranty_flag = TRUE THEN 1 END)
      comment: "Number of repair orders covered under warranty — measures warranty claim volume and associated cost exposure."
    - name: "telemetry_triggered_ro_count"
      expr: COUNT(CASE WHEN triggered_by_telemetry_flag = TRUE THEN 1 END)
      comment: "Number of repair orders triggered by connected vehicle telemetry — measures proactive service program effectiveness."
    - name: "distinct_vehicles_serviced"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of unique vehicles serviced — measures service reach and fleet penetration for aftersales programs."
    - name: "distinct_customers_served"
      expr: COUNT(DISTINCT primary_aftersales_customer_party_id)
      comment: "Number of unique customers served — measures customer base engagement and retention in aftersales."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_service_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service appointment KPIs covering booking volume, no-show rates, revenue estimation, self-service adoption, and customer satisfaction for aftersales scheduling operations."
  source: "`vibe_automotive_v1`.`aftersales`.`aftersales_service_appointment`"
  dimensions:
    - name: "aftersales_service_appointment_status"
      expr: aftersales_service_appointment_status
      comment: "Current status of the appointment (scheduled, completed, cancelled, no-show) — primary filter for appointment funnel analysis."
    - name: "service_type"
      expr: service_type
      comment: "Type of service requested at appointment — used to analyze service mix and demand planning."
    - name: "service_category"
      expr: service_category
      comment: "Broad category of service (e.g. routine maintenance, unscheduled repair) — supports capacity and resource planning."
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the appointment was booked (online, phone, walk-in) — measures digital adoption and channel mix."
    - name: "booked_via_self_service_flag"
      expr: booked_via_self_service_flag
      comment: "Indicates whether the appointment was booked through a self-service portal — tracks digital self-service adoption rate."
    - name: "no_show_flag"
      expr: no_show_flag
      comment: "Indicates whether the customer did not show up for the appointment — key operational efficiency and revenue leakage indicator."
    - name: "recall_flag"
      expr: recall_flag
      comment: "Indicates whether the appointment is related to a recall campaign — used to track recall completion velocity."
    - name: "warranty_flag"
      expr: warranty_flag
      comment: "Indicates whether the appointment involves a warranty claim — used for warranty cost forecasting."
    - name: "is_first_time_customer"
      expr: is_first_time_customer
      comment: "Indicates whether the customer is visiting the service center for the first time — measures new customer acquisition in aftersales."
    - name: "is_repeat_service"
      expr: is_repeat_service
      comment: "Indicates whether this is a repeat service visit — measures customer retention and loyalty in aftersales."
    - name: "service_priority"
      expr: service_priority
      comment: "Priority level of the appointment — used to assess urgency distribution and SLA adherence."
    - name: "transportation_option"
      expr: transportation_option
      comment: "Transportation option selected by the customer (loaner, shuttle, wait) — informs loaner fleet and shuttle capacity planning."
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_timestamp)
      comment: "Month the appointment was scheduled — used for demand forecasting and seasonal trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the appointment estimate is denominated — required for multi-currency revenue reporting."
  measures:
    - name: "appointment_count"
      expr: COUNT(1)
      comment: "Total number of service appointments — baseline volume KPI for scheduling throughput and demand planning."
    - name: "no_show_count"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "Number of appointments where the customer did not show — measures revenue leakage and scheduling inefficiency."
    - name: "self_service_booking_count"
      expr: COUNT(CASE WHEN booked_via_self_service_flag = TRUE THEN 1 END)
      comment: "Number of appointments booked via self-service portal — measures digital channel adoption and cost-to-serve reduction."
    - name: "recall_appointment_count"
      expr: COUNT(CASE WHEN recall_flag = TRUE THEN 1 END)
      comment: "Number of appointments related to recall campaigns — tracks recall completion velocity and regulatory compliance progress."
    - name: "first_time_customer_appointment_count"
      expr: COUNT(CASE WHEN is_first_time_customer = TRUE THEN 1 END)
      comment: "Number of appointments from first-time customers — measures new customer acquisition effectiveness in aftersales."
    - name: "total_estimated_gross_revenue"
      expr: SUM(CAST(estimated_gross_amount AS DOUBLE))
      comment: "Total estimated gross revenue from scheduled appointments — used for short-term revenue forecasting and capacity planning."
    - name: "total_estimated_net_revenue"
      expr: SUM(CAST(estimated_net_amount AS DOUBLE))
      comment: "Total estimated net revenue from scheduled appointments — net revenue forecast after estimated discounts."
    - name: "total_actual_revenue"
      expr: SUM(CAST(total_actual_amount AS DOUBLE))
      comment: "Total actual revenue realized from completed appointments — measures revenue realization vs. estimate."
    - name: "avg_actual_revenue_per_appointment"
      expr: AVG(CAST(total_actual_amount AS DOUBLE))
      comment: "Average actual revenue per appointment — key productivity KPI for service center revenue efficiency."
    - name: "total_parts_actual_revenue"
      expr: SUM(CAST(parts_actual_amount AS DOUBLE))
      comment: "Total actual parts revenue from appointments — measures parts attach rate and parts revenue contribution."
    - name: "distinct_vehicles_appointed"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of unique vehicles with service appointments — measures fleet service penetration and coverage."
    - name: "distinct_customers_appointed"
      expr: COUNT(DISTINCT primary_aftersales_customer_party_id)
      comment: "Number of unique customers with appointments — measures active customer base engagement in aftersales."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_repair_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Repair order line-level KPIs covering labor efficiency, parts usage, sublet costs, warranty line exposure, and technician productivity for granular aftersales cost management."
  source: "`vibe_automotive_v1`.`aftersales`.`repair_order_line`"
  dimensions:
    - name: "labor_category"
      expr: labor_category
      comment: "Category of labor performed on the line (e.g. diagnostic, mechanical, electrical) — used for labor mix and cost analysis."
    - name: "labor_skill_level"
      expr: labor_skill_level
      comment: "Skill level required for the labor operation — used to assess technician utilization by skill tier."
    - name: "line_status"
      expr: line_status
      comment: "Current status of the repair order line — used to filter active vs. completed line items."
    - name: "warranty_flag"
      expr: warranty_flag
      comment: "Indicates whether the line item is covered under warranty — used for warranty cost allocation at line level."
    - name: "parts_used_flag"
      expr: parts_used_flag
      comment: "Indicates whether parts were consumed on this line — measures parts attach rate at line level."
    - name: "sublet_flag"
      expr: sublet_flag
      comment: "Indicates whether the work was sublet to a third party — measures sublet cost exposure and make-vs-buy decisions."
    - name: "overtime_flag"
      expr: overtime_flag
      comment: "Indicates whether overtime was incurred on this line — used to monitor overtime cost and scheduling efficiency."
    - name: "operation_code"
      expr: operation_code
      comment: "Standard operation code for the repair procedure — enables benchmarking of labor time and cost by operation type."
    - name: "service_date_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month of service for the repair line — used for trend analysis of repair activity and cost over time."
    - name: "cause_complaint"
      expr: cause_complaint
      comment: "Customer complaint or cause code recorded on the line — used for quality and defect pattern analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the line item is denominated — required for multi-currency cost reporting."
  measures:
    - name: "repair_line_count"
      expr: COUNT(1)
      comment: "Total number of repair order lines — baseline volume KPI for work order complexity and throughput analysis."
    - name: "total_line_revenue"
      expr: SUM(CAST(line_total AS DOUBLE))
      comment: "Total revenue across all repair order lines — granular revenue measure for service mix and pricing analysis."
    - name: "total_actual_technician_hours"
      expr: SUM(CAST(actual_technician_hours AS DOUBLE))
      comment: "Total actual technician hours consumed across all lines — primary input for technician utilization and capacity planning."
    - name: "avg_actual_technician_hours_per_line"
      expr: AVG(CAST(actual_technician_hours AS DOUBLE))
      comment: "Average actual technician hours per repair line — measures job complexity and efficiency vs. standard time."
    - name: "total_standard_labor_time"
      expr: SUM(CAST(labor_time_standard AS DOUBLE))
      comment: "Total standard (flat-rate) labor time allocated — used to compute efficiency ratio against actual hours."
    - name: "total_parts_cost"
      expr: SUM(CAST(part_price AS DOUBLE))
      comment: "Total parts cost at line level — measures parts cost contribution to repair order profitability."
    - name: "total_parts_quantity"
      expr: SUM(CAST(part_quantity AS DOUBLE))
      comment: "Total quantity of parts consumed across repair lines — used for parts demand forecasting and inventory planning."
    - name: "total_sublet_cost"
      expr: SUM(CAST(sublet_cost AS DOUBLE))
      comment: "Total sublet cost incurred — measures third-party repair spend and informs make-vs-buy decisions."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied at line level — monitors discount leakage and promotional cost at granular level."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged at line level — required for tax compliance and audit reporting."
    - name: "warranty_line_count"
      expr: COUNT(CASE WHEN warranty_flag = TRUE THEN 1 END)
      comment: "Number of repair lines covered under warranty — measures warranty claim volume at line level for cost exposure analysis."
    - name: "sublet_line_count"
      expr: COUNT(CASE WHEN sublet_flag = TRUE THEN 1 END)
      comment: "Number of repair lines sublet to third parties — measures sublet frequency and dependency on external repair capacity."
    - name: "overtime_line_count"
      expr: COUNT(CASE WHEN overtime_flag = TRUE THEN 1 END)
      comment: "Number of repair lines incurring overtime — measures overtime frequency for labor cost and scheduling optimization."
    - name: "distinct_technicians_active"
      expr: COUNT(DISTINCT technician_id)
      comment: "Number of distinct technicians with active repair lines — measures workforce utilization breadth."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_warranty_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warranty claim KPIs covering claim volume, approved costs, rejection rates, goodwill exposure, and labor efficiency for warranty cost management and regulatory compliance."
  source: "`vibe_automotive_v1`.`aftersales`.`warranty_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the warranty claim (submitted, approved, rejected, pending) — primary filter for claim pipeline analysis."
    - name: "claim_category"
      expr: claim_category
      comment: "Category of the warranty claim (e.g. mechanical, electrical, body) — used for defect pattern and cost analysis."
    - name: "warranty_type"
      expr: warranty_type
      comment: "Type of warranty coverage under which the claim is filed — used for cost allocation by warranty program."
    - name: "adjudication_outcome"
      expr: adjudication_outcome
      comment: "Outcome of the claim adjudication process (approved, partially approved, rejected) — measures adjudication quality and dispute rates."
    - name: "goodwill_flag"
      expr: goodwill_flag
      comment: "Indicates whether the claim is a goodwill payment outside standard warranty — measures goodwill cost exposure and customer satisfaction investment."
    - name: "claim_adjusted_flag"
      expr: claim_adjusted_flag
      comment: "Indicates whether the claim amount was adjusted during adjudication — measures adjudication accuracy and rework rate."
    - name: "cause_code"
      expr: cause_code
      comment: "Root cause code assigned to the warranty failure — used for quality engineering feedback and defect trend analysis."
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Reason code for claim rejection — used to identify systemic submission errors and improve dealer claim quality."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the claim is denominated — required for multi-currency warranty cost reporting."
    - name: "repair_month"
      expr: DATE_TRUNC('MONTH', repair_date)
      comment: "Month of repair for the warranty claim — used for trend analysis of warranty activity and cost over time."
    - name: "failure_month"
      expr: DATE_TRUNC('MONTH', failure_date)
      comment: "Month of vehicle failure triggering the warranty claim — used for failure pattern and reliability trend analysis."
  measures:
    - name: "warranty_claim_count"
      expr: COUNT(1)
      comment: "Total number of warranty claims submitted — baseline volume KPI for warranty program scale and cost exposure."
    - name: "total_claim_amount"
      expr: SUM(CAST(total_claim_amount AS DOUBLE))
      comment: "Total warranty claim amount submitted — primary warranty cost exposure KPI used in financial provisioning and OEM cost reporting."
    - name: "total_approved_labor_cost"
      expr: SUM(CAST(approved_labor_cost AS DOUBLE))
      comment: "Total approved labor cost across warranty claims — measures warranty labor cost liability and adjudication outcomes."
    - name: "total_approved_parts_cost"
      expr: SUM(CAST(approved_parts_cost AS DOUBLE))
      comment: "Total approved parts cost across warranty claims — measures warranty parts cost liability and supply chain impact."
    - name: "total_adjusted_amount"
      expr: SUM(CAST(adjusted_amount AS DOUBLE))
      comment: "Total amount adjusted during claim adjudication — measures adjudication variance and dealer over-claim exposure."
    - name: "total_approved_labor_hours"
      expr: SUM(CAST(approved_labor_hours AS DOUBLE))
      comment: "Total approved labor hours across warranty claims — used to benchmark warranty repair efficiency and detect inflated claims."
    - name: "total_labor_hours_claimed"
      expr: SUM(CAST(labor_hours_claimed AS DOUBLE))
      comment: "Total labor hours claimed by dealers — compared against approved hours to measure claim accuracy and adjudication efficiency."
    - name: "avg_claim_amount"
      expr: AVG(CAST(total_claim_amount AS DOUBLE))
      comment: "Average warranty claim amount — measures claim severity and informs warranty reserve adequacy."
    - name: "goodwill_claim_count"
      expr: COUNT(CASE WHEN goodwill_flag = TRUE THEN 1 END)
      comment: "Number of goodwill warranty claims — measures customer satisfaction investment and out-of-warranty cost exposure."
    - name: "adjusted_claim_count"
      expr: COUNT(CASE WHEN claim_adjusted_flag = TRUE THEN 1 END)
      comment: "Number of claims that were adjusted during adjudication — measures adjudication rework rate and dealer submission quality."
    - name: "total_sublet_cost"
      expr: SUM(CAST(sublet_cost AS DOUBLE))
      comment: "Total sublet cost included in warranty claims — measures third-party repair cost within warranty program."
    - name: "total_parts_tax_amount"
      expr: SUM(CAST(parts_tax_amount AS DOUBLE))
      comment: "Total parts tax amount in warranty claims — required for tax compliance and warranty cost reconciliation."
    - name: "distinct_vehicles_with_claims"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of unique vehicles with warranty claims — measures fleet-level warranty exposure and reliability performance."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_vehicle_warranty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle warranty portfolio KPIs covering active coverage, claims history, extended warranty adoption, CPO program performance, and warranty cost exposure for aftersales revenue and risk management."
  source: "`vibe_automotive_v1`.`aftersales`.`vehicle_warranty`"
  dimensions:
    - name: "vehicle_warranty_status"
      expr: vehicle_warranty_status
      comment: "Current status of the vehicle warranty (active, expired, transferred, voided) — primary filter for active warranty portfolio analysis."
    - name: "warranty_type"
      expr: warranty_type
      comment: "Type of warranty coverage (bumper-to-bumper, powertrain, extended, CPO) — used for warranty mix and revenue analysis."
    - name: "extended_warranty_flag"
      expr: extended_warranty_flag
      comment: "Indicates whether the vehicle has an extended warranty — measures extended warranty penetration and associated revenue."
    - name: "cpo_warranty_flag"
      expr: cpo_warranty_flag
      comment: "Indicates whether the warranty is associated with a Certified Pre-Owned program — measures CPO program scale and cost exposure."
    - name: "eligible_for_recall"
      expr: eligible_for_recall
      comment: "Indicates whether the vehicle is eligible for a recall under this warranty — used for recall compliance tracking."
    - name: "renewal_flag"
      expr: renewal_flag
      comment: "Indicates whether the warranty has been renewed — measures warranty renewal rate and recurring revenue."
    - name: "transfer_allowed"
      expr: transfer_allowed
      comment: "Indicates whether the warranty is transferable to a new owner — used for used vehicle value and warranty portability analysis."
    - name: "program_category"
      expr: program_category
      comment: "Category of the warranty program — used for program-level performance and cost analysis."
    - name: "coverage_area"
      expr: coverage_area
      comment: "Geographic coverage area of the warranty — used for regional warranty exposure and compliance analysis."
    - name: "warranty_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the warranty coverage began — used for cohort analysis of warranty portfolios and claims timing."
    - name: "warranty_end_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month the warranty coverage expires — used for expiry pipeline analysis and renewal campaign targeting."
  measures:
    - name: "active_warranty_count"
      expr: COUNT(1)
      comment: "Total number of vehicle warranties in the portfolio — baseline KPI for warranty program scale and coverage breadth."
    - name: "total_warranty_claims_amount"
      expr: SUM(CAST(warranty_claims_amount AS DOUBLE))
      comment: "Total cumulative warranty claims amount across the portfolio — primary warranty cost liability KPI for financial provisioning."
    - name: "avg_warranty_claims_amount_per_vehicle"
      expr: AVG(CAST(warranty_claims_amount AS DOUBLE))
      comment: "Average warranty claims amount per vehicle — measures per-vehicle warranty cost intensity and reserve adequacy."
    - name: "total_last_claim_amount"
      expr: SUM(CAST(claims_last_amount AS DOUBLE))
      comment: "Total amount of the most recent warranty claim per vehicle — used for recent claims trend and reserve refresh analysis."
    - name: "total_transfer_fee_revenue"
      expr: SUM(CAST(transfer_fee AS DOUBLE))
      comment: "Total revenue from warranty transfer fees — measures warranty transfer program revenue contribution."
    - name: "extended_warranty_count"
      expr: COUNT(CASE WHEN extended_warranty_flag = TRUE THEN 1 END)
      comment: "Number of vehicles with extended warranty coverage — measures extended warranty penetration rate and associated revenue base."
    - name: "cpo_warranty_count"
      expr: COUNT(CASE WHEN cpo_warranty_flag = TRUE THEN 1 END)
      comment: "Number of vehicles under CPO warranty — measures CPO program scale and associated cost and revenue exposure."
    - name: "recall_eligible_warranty_count"
      expr: COUNT(CASE WHEN eligible_for_recall = TRUE THEN 1 END)
      comment: "Number of warranties on vehicles eligible for recall — measures recall exposure within the active warranty portfolio."
    - name: "renewed_warranty_count"
      expr: COUNT(CASE WHEN renewal_flag = TRUE THEN 1 END)
      comment: "Number of warranties that have been renewed — measures warranty renewal rate and recurring aftersales revenue."
    - name: "distinct_vehicles_under_warranty"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of unique vehicles with active warranty coverage — measures fleet warranty penetration and coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_parts_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Parts order KPIs covering procurement spend, backorder rates, freight costs, order fulfillment efficiency, and supply chain performance for aftersales parts operations."
  source: "`vibe_automotive_v1`.`aftersales`.`parts_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the parts order (open, fulfilled, cancelled, backordered) — primary filter for order pipeline analysis."
    - name: "order_type"
      expr: order_type
      comment: "Type of parts order (emergency, standard, campaign) — used for order mix and urgency analysis."
    - name: "backorder_flag"
      expr: backorder_flag
      comment: "Indicates whether the order is on backorder — key supply chain risk indicator affecting service center throughput."
    - name: "priority_flag"
      expr: priority_flag
      comment: "Indicates whether the order has been flagged as priority — used to measure urgent parts demand and expedite costs."
    - name: "self_service_order_flag"
      expr: self_service_order_flag
      comment: "Indicates whether the order was placed via self-service portal — measures digital procurement adoption."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method used for the parts order — used for freight cost analysis and delivery performance benchmarking."
    - name: "freight_terms"
      expr: freight_terms
      comment: "Freight terms for the order (prepaid, collect, etc.) — used for freight cost allocation and supplier negotiation analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for the parts order — used for working capital and cash flow analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the parts order is denominated — required for multi-currency procurement reporting."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_timestamp)
      comment: "Month the parts order was placed — used for procurement trend analysis and demand forecasting."
    - name: "requested_delivery_month"
      expr: DATE_TRUNC('MONTH', requested_delivery_date)
      comment: "Month the parts delivery was requested — used for supply chain lead time and fulfillment analysis."
  measures:
    - name: "parts_order_count"
      expr: COUNT(1)
      comment: "Total number of parts orders placed — baseline volume KPI for parts procurement activity and demand planning."
    - name: "total_parts_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total value of parts orders placed — primary procurement spend KPI for aftersales parts cost management."
    - name: "total_net_parts_spend"
      expr: SUM(CAST(net_total AS DOUBLE))
      comment: "Total net parts spend after discounts — measures effective procurement cost for aftersales parts."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost incurred on parts orders — measures logistics cost and informs shipping method optimization."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts received on parts orders — measures supplier discount capture and procurement efficiency."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on parts orders — required for tax compliance and procurement cost reconciliation."
    - name: "avg_order_value"
      expr: AVG(CAST(total_order_value AS DOUBLE))
      comment: "Average parts order value — measures order size trends and informs bulk purchasing strategy."
    - name: "backorder_count"
      expr: COUNT(CASE WHEN backorder_flag = TRUE THEN 1 END)
      comment: "Number of parts orders on backorder — measures supply chain disruption impact on service center operations."
    - name: "priority_order_count"
      expr: COUNT(CASE WHEN priority_flag = TRUE THEN 1 END)
      comment: "Number of priority parts orders — measures urgent demand frequency and associated expedite cost exposure."
    - name: "distinct_service_centers_ordering"
      expr: COUNT(DISTINCT service_center_id)
      comment: "Number of distinct service centers placing parts orders — measures parts procurement network breadth and activity."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_service_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service campaign KPIs covering recall and TSB campaign scale, affected vehicle population, cost estimates, compliance status, and regulatory reporting for aftersales campaign management."
  source: "`vibe_automotive_v1`.`aftersales`.`service_campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the service campaign (active, closed, planned) — primary filter for campaign pipeline analysis."
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (recall, TSB, customer satisfaction, field action) — used for campaign mix and regulatory exposure analysis."
    - name: "campaign_priority"
      expr: campaign_priority
      comment: "Priority level of the campaign — used to assess urgency and resource allocation for campaign execution."
    - name: "campaign_region"
      expr: campaign_region
      comment: "Geographic region of the campaign — used for regional compliance and campaign execution analysis."
    - name: "safety_recall_flag"
      expr: safety_recall_flag
      comment: "Indicates whether the campaign is a safety recall — highest priority regulatory compliance indicator."
    - name: "emissions_recall_flag"
      expr: emissions_recall_flag
      comment: "Indicates whether the campaign is an emissions recall — critical for environmental regulatory compliance reporting."
    - name: "nhtsa_compliance_flag"
      expr: nhtsa_compliance_flag
      comment: "Indicates NHTSA compliance status for the campaign — required for US regulatory reporting and enforcement tracking."
    - name: "unece_compliance_flag"
      expr: unece_compliance_flag
      comment: "Indicates UNECE compliance status for the campaign — required for European regulatory reporting."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status of the campaign — used for regulatory audit and enforcement risk assessment."
    - name: "technical_service_bulletin_flag"
      expr: technical_service_bulletin_flag
      comment: "Indicates whether the campaign is associated with a Technical Service Bulletin — used for TSB-driven campaign analysis."
    - name: "warranty_impact_flag"
      expr: warranty_impact_flag
      comment: "Indicates whether the campaign has warranty cost implications — used for warranty reserve and cost impact analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the campaign became effective — used for campaign launch trend and regulatory timeline analysis."
    - name: "regulatory_reporting_month"
      expr: DATE_TRUNC('MONTH', regulatory_reporting_date)
      comment: "Month of regulatory reporting for the campaign — used for compliance reporting cadence and deadline tracking."
  measures:
    - name: "campaign_count"
      expr: COUNT(1)
      comment: "Total number of service campaigns — baseline volume KPI for campaign program scale and regulatory exposure."
    - name: "total_affected_vin_population"
      expr: SUM(CAST(affected_vin_population AS DOUBLE))
      comment: "Total number of vehicles affected across all campaigns — primary scale KPI for recall and campaign exposure management."
    - name: "avg_affected_vin_population"
      expr: AVG(CAST(affected_vin_population AS DOUBLE))
      comment: "Average number of vehicles affected per campaign — measures campaign scope and informs resource planning."
    - name: "total_campaign_cost_estimate"
      expr: SUM(CAST(campaign_cost_estimate AS DOUBLE))
      comment: "Total estimated cost across all service campaigns — primary financial exposure KPI for campaign budget and reserve planning."
    - name: "total_parts_cost_estimate"
      expr: SUM(CAST(parts_cost_estimate AS DOUBLE))
      comment: "Total estimated parts cost across campaigns — measures parts supply chain demand and procurement planning requirements."
    - name: "safety_recall_campaign_count"
      expr: COUNT(CASE WHEN safety_recall_flag = TRUE THEN 1 END)
      comment: "Number of active safety recall campaigns — highest-priority regulatory compliance KPI for executive and board reporting."
    - name: "emissions_recall_campaign_count"
      expr: COUNT(CASE WHEN emissions_recall_flag = TRUE THEN 1 END)
      comment: "Number of emissions recall campaigns — measures environmental regulatory exposure and compliance program scale."
    - name: "warranty_impact_campaign_count"
      expr: COUNT(CASE WHEN warranty_impact_flag = TRUE THEN 1 END)
      comment: "Number of campaigns with warranty cost impact — measures warranty reserve exposure from active campaigns."
    - name: "nhtsa_compliant_campaign_count"
      expr: COUNT(CASE WHEN nhtsa_compliance_flag = TRUE THEN 1 END)
      comment: "Number of campaigns meeting NHTSA compliance requirements — measures US regulatory compliance program effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_technician`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technician workforce KPIs covering headcount, certification status, efficiency ratings, overtime eligibility, and specialization mix for aftersales workforce planning and productivity management."
  source: "`vibe_automotive_v1`.`aftersales`.`technician`"
  dimensions:
    - name: "technician_status"
      expr: technician_status
      comment: "Current employment status of the technician (active, on-leave, terminated) — primary filter for active workforce analysis."
    - name: "availability_status"
      expr: availability_status
      comment: "Current availability status of the technician — used for real-time capacity planning and scheduling."
    - name: "certification_level"
      expr: certification_level
      comment: "Certification level of the technician (e.g. master, senior, junior) — used for skill tier distribution and workforce quality analysis."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification held by the technician — used for specialization mix and compliance analysis."
    - name: "skill_level"
      expr: skill_level
      comment: "Skill level of the technician — used for workforce capability assessment and job assignment optimization."
    - name: "specialization"
      expr: specialization
      comment: "Technical specialization of the technician (e.g. EV, ADAS, powertrain) — used for capability gap and hiring analysis."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type assigned to the technician (day, evening, night) — used for shift coverage and labor cost analysis."
    - name: "overtime_eligible"
      expr: overtime_eligible
      comment: "Indicates whether the technician is eligible for overtime — used for overtime cost planning and labor compliance."
    - name: "field_services_eligible_flag"
      expr: field_services_eligible_flag
      comment: "Indicates whether the technician is certified for field service operations — measures mobile service capacity."
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month the technician was hired — used for workforce tenure cohort analysis and attrition tracking."
    - name: "certification_expiry_month"
      expr: DATE_TRUNC('MONTH', certification_expiry_date)
      comment: "Month the technician certification expires — used for proactive recertification planning and compliance risk management."
  measures:
    - name: "technician_count"
      expr: COUNT(1)
      comment: "Total number of technicians in the workforce — baseline headcount KPI for capacity planning and hiring decisions."
    - name: "avg_flat_rate_efficiency_rating"
      expr: AVG(CAST(flat_rate_efficiency_rating AS DOUBLE))
      comment: "Average flat-rate efficiency rating across technicians — primary technician productivity KPI; below-target values trigger training or staffing interventions."
    - name: "total_flat_rate_efficiency"
      expr: SUM(CAST(flat_rate_efficiency_rating AS DOUBLE))
      comment: "Sum of flat-rate efficiency ratings — used to compute service center-level aggregate productivity scores."
    - name: "avg_overtime_rate_multiplier"
      expr: AVG(CAST(overtime_rate_multiplier AS DOUBLE))
      comment: "Average overtime rate multiplier across eligible technicians — used for overtime cost modeling and labor budget planning."
    - name: "overtime_eligible_technician_count"
      expr: COUNT(CASE WHEN overtime_eligible = TRUE THEN 1 END)
      comment: "Number of technicians eligible for overtime — measures flexible capacity available for peak demand periods."
    - name: "field_service_eligible_technician_count"
      expr: COUNT(CASE WHEN field_services_eligible_flag = TRUE THEN 1 END)
      comment: "Number of technicians certified for field service — measures mobile service capacity and program scalability."
    - name: "distinct_service_centers_staffed"
      expr: COUNT(DISTINCT service_center_id)
      comment: "Number of distinct service centers with active technicians — measures workforce distribution across the service network."
$$;