-- Metric views for domain: aftersales | Business: Automotive | Version: 2 | Generated on: 2026-06-23 04:49:37

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_repair_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core aftersales repair order KPIs covering financial performance, warranty exposure, technician productivity, and service throughput — primary operational steering dashboard for the aftersales VP."
  source: "`vibe_automotive_v1`.`aftersales`.`aftersales_repair_order`"
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Type of service performed (e.g. warranty, maintenance, recall, goodwill) — primary segmentation axis for repair order analysis."
    - name: "service_priority"
      expr: service_priority
      comment: "Priority level assigned to the repair order, used to track SLA adherence and urgent work volumes."
    - name: "warranty_type"
      expr: warranty_type
      comment: "Warranty category (e.g. bumper-to-bumper, powertrain, extended) enabling cost allocation by warranty program."
    - name: "warranty_flag"
      expr: warranty_flag
      comment: "Boolean indicating whether the repair order is covered under warranty — key split for cost responsibility analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (cash, finance, warranty, insurance) for revenue mix analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the repair order — used to track outstanding receivables."
    - name: "aftersales_repair_order_status"
      expr: aftersales_repair_order_status
      comment: "Lifecycle status of the repair order (open, in-progress, closed, invoiced) for throughput and WIP analysis."
    - name: "service_center_region"
      expr: service_center_region
      comment: "Geographic region of the service center — enables regional performance benchmarking."
    - name: "triggered_by_telemetry_flag"
      expr: triggered_by_telemetry_flag
      comment: "Indicates whether the repair was proactively triggered by connected vehicle telemetry — measures telematics-driven service adoption."
    - name: "open_month"
      expr: DATE_TRUNC('MONTH', open_timestamp)
      comment: "Month the repair order was opened — time dimension for trend analysis."
    - name: "close_month"
      expr: DATE_TRUNC('MONTH', close_timestamp)
      comment: "Month the repair order was closed — used to measure throughput and cycle time trends."
  measures:
    - name: "total_repair_orders"
      expr: COUNT(1)
      comment: "Total number of repair orders — baseline volume KPI for service throughput steering."
    - name: "total_repair_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross revenue from all repair orders — primary financial KPI for aftersales P&L."
    - name: "total_labor_revenue"
      expr: SUM(CAST(labor_total_cost AS DOUBLE))
      comment: "Total labor revenue billed across repair orders — measures labor utilization and pricing effectiveness."
    - name: "total_parts_revenue"
      expr: SUM(CAST(parts_total_cost AS DOUBLE))
      comment: "Total parts revenue billed across repair orders — key input for parts margin and inventory planning."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts granted on repair orders — monitors discount leakage and goodwill spend."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on repair orders — required for tax compliance reporting."
    - name: "avg_repair_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average revenue per repair order — key productivity and pricing benchmark for service operations."
    - name: "avg_labor_hours_per_ro"
      expr: AVG(CAST(labor_total_hours AS DOUBLE))
      comment: "Average labor hours consumed per repair order — measures technician efficiency and job complexity."
    - name: "avg_labor_rate_per_hour"
      expr: AVG(CAST(labor_rate_per_hour AS DOUBLE))
      comment: "Average effective labor rate per hour — monitors pricing realization vs. standard rate card."
    - name: "warranty_ro_count"
      expr: COUNT(CASE WHEN warranty_flag = TRUE THEN 1 END)
      comment: "Number of repair orders covered under warranty — measures warranty claim volume and OEM cost exposure."
    - name: "telemetry_triggered_ro_count"
      expr: COUNT(CASE WHEN triggered_by_telemetry_flag = TRUE THEN 1 END)
      comment: "Number of repair orders proactively triggered by connected vehicle telemetry — measures ROI of telematics-driven service."
    - name: "telemetry_trigger_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN triggered_by_telemetry_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of repair orders triggered by telemetry — strategic KPI for connected services business case."
    - name: "warranty_ro_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN warranty_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of repair orders that are warranty-covered — monitors warranty burden on service operations."
    - name: "net_repair_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Net revenue after discounts and adjustments — true aftersales revenue contribution to P&L."
    - name: "distinct_vehicles_serviced"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of unique vehicles serviced — measures service network reach and vehicle parc penetration."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_warranty_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warranty claim financial and quality KPIs — critical for OEM warranty reserve management, supplier chargeback, and quality improvement steering."
  source: "`vibe_automotive_v1`.`aftersales`.`aftersales_warranty_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the warranty claim (submitted, approved, rejected, paid) — primary lifecycle dimension."
    - name: "claim_category"
      expr: claim_category
      comment: "Category of warranty claim (e.g. powertrain, electrical, body) — used for quality trend analysis."
    - name: "warranty_type"
      expr: warranty_type
      comment: "Type of warranty coverage (basic, powertrain, extended, goodwill) — cost allocation dimension."
    - name: "cause_code"
      expr: cause_code
      comment: "Root cause code assigned to the warranty failure — drives quality engineering investigations."
    - name: "goodwill_flag"
      expr: goodwill_flag
      comment: "Indicates goodwill claims not covered by standard warranty — monitors discretionary cost exposure."
    - name: "claim_adjusted_flag"
      expr: claim_adjusted_flag
      comment: "Indicates whether the claim amount was adjusted during adjudication — measures adjudication activity."
    - name: "adjudication_outcome"
      expr: adjudication_outcome
      comment: "Final adjudication decision (approved, partially approved, rejected) — key quality of claims processing KPI."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', claim_submission_timestamp)
      comment: "Month the warranty claim was submitted — time dimension for trend and seasonality analysis."
    - name: "failure_month"
      expr: DATE_TRUNC('MONTH', CAST(failure_date AS TIMESTAMP))
      comment: "Month of vehicle failure — used to correlate failure rates with production cohorts."
  measures:
    - name: "total_warranty_claims"
      expr: COUNT(1)
      comment: "Total number of warranty claims submitted — baseline volume KPI for warranty program management."
    - name: "total_claim_amount"
      expr: SUM(CAST(total_claim_amount AS DOUBLE))
      comment: "Total gross warranty claim amount — primary financial KPI for warranty reserve adequacy."
    - name: "total_approved_labor_cost"
      expr: SUM(CAST(approved_labor_cost AS DOUBLE))
      comment: "Total approved labor cost across warranty claims — measures labor warranty liability."
    - name: "total_approved_parts_cost"
      expr: SUM(CAST(approved_parts_cost AS DOUBLE))
      comment: "Total approved parts cost across warranty claims — measures parts warranty liability and supplier chargeback base."
    - name: "total_adjusted_amount"
      expr: SUM(CAST(adjusted_amount AS DOUBLE))
      comment: "Total amount after adjudication adjustments — measures net warranty payout vs. claimed amount."
    - name: "total_sublet_cost"
      expr: SUM(CAST(sublet_cost AS DOUBLE))
      comment: "Total sublet/third-party repair cost within warranty claims — monitors outsourced repair spend."
    - name: "avg_claim_amount"
      expr: AVG(CAST(total_claim_amount AS DOUBLE))
      comment: "Average warranty claim value — benchmark for claim complexity and cost per failure event."
    - name: "avg_approved_labor_hours"
      expr: AVG(CAST(approved_labor_hours AS DOUBLE))
      comment: "Average approved labor hours per warranty claim — measures repair complexity and labor standard adherence."
    - name: "goodwill_claim_count"
      expr: COUNT(CASE WHEN goodwill_flag = TRUE THEN 1 END)
      comment: "Number of goodwill warranty claims — measures discretionary customer satisfaction spend."
    - name: "goodwill_claim_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN goodwill_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims that are goodwill — strategic KPI for customer satisfaction investment vs. standard warranty."
    - name: "claim_rejection_count"
      expr: COUNT(CASE WHEN claim_status = 'REJECTED' THEN 1 END)
      comment: "Number of rejected warranty claims — measures claim quality and dealer submission accuracy."
    - name: "claim_rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN claim_status = 'REJECTED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of warranty claims rejected — key quality KPI for dealer claim submission process."
    - name: "distinct_vehicles_with_claims"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of unique vehicles with warranty claims — measures warranty incidence rate across the vehicle parc."
    - name: "total_parts_tax"
      expr: SUM(CAST(parts_tax_amount AS DOUBLE))
      comment: "Total parts tax amount on warranty claims — required for tax compliance and cost reporting."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_service_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service appointment scheduling, conversion, and customer experience KPIs — drives service capacity planning and customer retention strategy."
  source: "`vibe_automotive_v1`.`aftersales`.`aftersales_service_appointment`"
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Type of service booked (maintenance, repair, recall, PDI) — primary segmentation for appointment analysis."
    - name: "service_category"
      expr: service_category
      comment: "Service category grouping for capacity planning and revenue forecasting."
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the appointment was booked (online, phone, walk-in, app) — digital adoption KPI."
    - name: "aftersales_service_appointment_status"
      expr: aftersales_service_appointment_status
      comment: "Current status of the appointment (scheduled, confirmed, in-progress, completed, no-show, cancelled)."
    - name: "booked_via_self_service_flag"
      expr: booked_via_self_service_flag
      comment: "Indicates self-service digital booking — measures digital channel adoption rate."
    - name: "proactive_maintenance_trigger_flag"
      expr: proactive_maintenance_trigger_flag
      comment: "Indicates appointment triggered by predictive maintenance alert — measures connected services value."
    - name: "recall_flag"
      expr: recall_flag
      comment: "Indicates recall-related appointment — used to track recall completion rates."
    - name: "warranty_flag"
      expr: warranty_flag
      comment: "Indicates warranty-covered appointment — cost allocation dimension."
    - name: "is_first_time_customer"
      expr: is_first_time_customer
      comment: "Flags first-time service customers — measures new customer acquisition through service channel."
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_timestamp)
      comment: "Month the appointment was scheduled — time dimension for booking trend analysis."
  measures:
    - name: "total_appointments"
      expr: COUNT(1)
      comment: "Total number of service appointments — baseline volume KPI for service capacity planning."
    - name: "no_show_count"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "Number of no-show appointments — measures scheduling efficiency and capacity waste."
    - name: "no_show_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments that result in no-shows — critical KPI for service bay utilization."
    - name: "self_service_booking_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN booked_via_self_service_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments booked via self-service digital channels — digital transformation KPI."
    - name: "proactive_trigger_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN proactive_maintenance_trigger_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments triggered by predictive maintenance — measures connected vehicle service ROI."
    - name: "total_estimated_revenue"
      expr: SUM(CAST(estimated_gross_amount AS DOUBLE))
      comment: "Total estimated gross revenue from scheduled appointments — forward-looking revenue pipeline for service operations."
    - name: "total_actual_revenue"
      expr: SUM(CAST(total_actual_amount AS DOUBLE))
      comment: "Total actual revenue realized from completed appointments — measures revenue realization vs. estimate."
    - name: "avg_actual_revenue_per_appointment"
      expr: AVG(CAST(total_actual_amount AS DOUBLE))
      comment: "Average actual revenue per service appointment — key productivity benchmark for service advisors."
    - name: "total_parts_actual_amount"
      expr: SUM(CAST(parts_actual_amount AS DOUBLE))
      comment: "Total actual parts revenue from service appointments — measures parts attach rate and inventory pull-through."
    - name: "first_time_customer_count"
      expr: COUNT(CASE WHEN is_first_time_customer = TRUE THEN 1 END)
      comment: "Number of first-time service customers — measures service network growth and conquest rate."
    - name: "recall_appointment_count"
      expr: COUNT(CASE WHEN recall_flag = TRUE THEN 1 END)
      comment: "Number of recall-related appointments — tracks recall completion velocity for regulatory compliance."
    - name: "distinct_vehicles_scheduled"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of unique vehicles with scheduled appointments — measures active vehicle parc engagement."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_customer_satisfaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer satisfaction and NPS KPIs for aftersales service — primary voice-of-customer metric for dealer network management and service quality steering."
  source: "`vibe_automotive_v1`.`aftersales`.`customer_satisfaction_survey`"
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Type of service the survey relates to — enables satisfaction benchmarking by service category."
    - name: "survey_channel"
      expr: survey_channel
      comment: "Channel through which the survey was delivered (email, SMS, in-app, phone) — response rate analysis by channel."
    - name: "survey_method"
      expr: survey_method
      comment: "Survey methodology (CSAT, NPS, CES) — enables comparison across measurement frameworks."
    - name: "respondent_type"
      expr: respondent_type
      comment: "Type of respondent (retail customer, fleet, CPO) — segments satisfaction by customer type."
    - name: "customer_satisfaction_survey_status"
      expr: customer_satisfaction_survey_status
      comment: "Status of the survey (sent, responded, expired) — measures survey completion rates."
    - name: "warranty_flag"
      expr: warranty_flag
      comment: "Indicates whether the service visit was warranty-related — compares satisfaction for warranty vs. paid service."
    - name: "follow_up_action_flag"
      expr: follow_up_action_flag
      comment: "Indicates whether a follow-up action was triggered by the survey response — measures service recovery activity."
    - name: "survey_month"
      expr: DATE_TRUNC('MONTH', CAST(survey_date AS TIMESTAMP))
      comment: "Month the survey was conducted — time dimension for satisfaction trend analysis."
  measures:
    - name: "total_surveys_sent"
      expr: COUNT(1)
      comment: "Total number of surveys sent — baseline for response rate calculation."
    - name: "total_surveys_responded"
      expr: COUNT(CASE WHEN customer_satisfaction_survey_status = 'RESPONDED' THEN 1 END)
      comment: "Number of surveys with responses received — measures survey program effectiveness."
    - name: "survey_response_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN customer_satisfaction_survey_status = 'RESPONDED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of surveys that received a response — measures customer engagement with feedback program."
    - name: "follow_up_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_action_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of surveys triggering a follow-up action — measures service recovery activation rate."
    - name: "distinct_dealerships_surveyed"
      expr: COUNT(DISTINCT customer_dealership_id)
      comment: "Number of distinct dealerships covered by surveys — measures survey program breadth across dealer network."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_service_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service campaign and recall KPIs — critical for regulatory compliance, safety recall completion tracking, and campaign cost management."
  source: "`vibe_automotive_v1`.`aftersales`.`service_campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of service campaign (recall, TSB, customer satisfaction, emissions) — primary classification for regulatory reporting."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign (active, completed, cancelled) — lifecycle tracking dimension."
    - name: "campaign_priority"
      expr: campaign_priority
      comment: "Priority level of the campaign — used to prioritize resource allocation for high-urgency recalls."
    - name: "campaign_region"
      expr: campaign_region
      comment: "Geographic region scope of the campaign — enables regional compliance tracking."
    - name: "safety_recall_flag"
      expr: safety_recall_flag
      comment: "Indicates a safety-critical recall — highest priority regulatory compliance dimension."
    - name: "emissions_recall_flag"
      expr: emissions_recall_flag
      comment: "Indicates an emissions-related recall — regulatory compliance dimension for EPA/UNECE reporting."
    - name: "nhtsa_compliance_flag"
      expr: nhtsa_compliance_flag
      comment: "Indicates NHTSA regulatory compliance requirement — US market regulatory reporting dimension."
    - name: "unece_compliance_flag"
      expr: unece_compliance_flag
      comment: "Indicates UNECE regulatory compliance requirement — European market regulatory reporting dimension."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the campaign — key dimension for regulatory reporting dashboards."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', CAST(effective_start_date AS TIMESTAMP))
      comment: "Month the campaign became effective — time dimension for campaign launch trend analysis."
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of service campaigns — baseline volume KPI for campaign management."
    - name: "total_affected_vin_population"
      expr: SUM(CAST(affected_vin_population AS DOUBLE))
      comment: "Total number of vehicles affected across all campaigns — measures scale of recall/service exposure."
    - name: "total_campaign_cost_estimate"
      expr: SUM(CAST(campaign_cost_estimate AS DOUBLE))
      comment: "Total estimated cost across all service campaigns — primary financial KPI for warranty reserve planning."
    - name: "total_parts_cost_estimate"
      expr: SUM(CAST(parts_cost_estimate AS DOUBLE))
      comment: "Total estimated parts cost for campaigns — input for parts procurement and inventory planning."
    - name: "avg_campaign_cost_estimate"
      expr: AVG(CAST(campaign_cost_estimate AS DOUBLE))
      comment: "Average estimated cost per service campaign — benchmark for campaign complexity and cost management."
    - name: "avg_affected_vin_population"
      expr: AVG(CAST(affected_vin_population AS DOUBLE))
      comment: "Average number of vehicles affected per campaign — measures typical campaign scope."
    - name: "safety_recall_count"
      expr: COUNT(CASE WHEN safety_recall_flag = TRUE THEN 1 END)
      comment: "Number of safety-critical recall campaigns — primary regulatory compliance KPI reported to NHTSA/UNECE."
    - name: "emissions_recall_count"
      expr: COUNT(CASE WHEN emissions_recall_flag = TRUE THEN 1 END)
      comment: "Number of emissions-related recall campaigns — regulatory compliance KPI for EPA/UNECE reporting."
    - name: "safety_recall_vin_exposure"
      expr: SUM(CASE WHEN safety_recall_flag = TRUE THEN affected_vin_population ELSE 0 END)
      comment: "Total vehicles exposed to safety recalls — critical regulatory risk metric for executive and board reporting."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_campaign_vin_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recall and service campaign completion KPIs at the individual VIN level — measures remedy completion rates, cost per vehicle, and compliance deadline adherence."
  source: "`vibe_automotive_v1`.`aftersales`.`campaign_vin`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the individual VIN for the campaign (completed, pending, overdue) — primary regulatory tracking dimension."
    - name: "remedy_status"
      expr: remedy_status
      comment: "Status of the remedy applied to the vehicle — measures campaign execution progress."
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall (safety, emissions, customer satisfaction) — regulatory classification dimension."
    - name: "notification_status"
      expr: notification_status
      comment: "Status of owner notification (sent, delivered, acknowledged) — measures outreach effectiveness."
    - name: "warranty_covered"
      expr: warranty_covered
      comment: "Indicates whether the remedy is warranty-covered — cost allocation dimension."
    - name: "is_critical"
      expr: is_critical
      comment: "Flags critical safety campaigns requiring priority completion — regulatory urgency dimension."
    - name: "compliance_deadline_month"
      expr: DATE_TRUNC('MONTH', CAST(compliance_deadline AS TIMESTAMP))
      comment: "Month of the compliance deadline — time dimension for deadline adherence tracking."
  measures:
    - name: "total_campaign_vin_records"
      expr: COUNT(1)
      comment: "Total VIN-campaign records — baseline for completion rate calculation."
    - name: "completed_remedy_count"
      expr: COUNT(CASE WHEN remedy_status = 'COMPLETED' THEN 1 END)
      comment: "Number of VINs with completed remedies — primary recall completion KPI for regulatory reporting."
    - name: "remedy_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN remedy_status = 'COMPLETED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of affected VINs with completed remedies — critical regulatory compliance KPI reported to NHTSA/UNECE."
    - name: "total_labor_cost"
      expr: SUM(CAST(total_labor_cost_usd AS DOUBLE))
      comment: "Total labor cost incurred for campaign remedies — measures actual campaign labor spend vs. estimate."
    - name: "total_parts_cost"
      expr: SUM(CAST(total_parts_cost_usd AS DOUBLE))
      comment: "Total parts cost incurred for campaign remedies — measures actual parts spend vs. estimate."
    - name: "total_remedy_cost"
      expr: SUM(CAST(total_remedy_cost_usd AS DOUBLE))
      comment: "Total all-in remedy cost across campaign VINs — primary financial KPI for recall cost management."
    - name: "avg_remedy_cost_per_vin"
      expr: AVG(CAST(total_remedy_cost_usd AS DOUBLE))
      comment: "Average remedy cost per affected vehicle — benchmark for campaign cost efficiency and reserve adequacy."
    - name: "avg_labor_time_hours"
      expr: AVG(CAST(labor_time_hours AS DOUBLE))
      comment: "Average labor time per remedy — measures repair complexity and technician capacity requirements."
    - name: "distinct_campaigns"
      expr: COUNT(DISTINCT service_campaign_id)
      comment: "Number of distinct campaigns with VIN-level records — measures active campaign portfolio size."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_goodwill_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goodwill adjustment spend and approval KPIs — measures discretionary customer satisfaction investment, approval authority utilization, and NPS-driven spend."
  source: "`vibe_automotive_v1`.`aftersales`.`goodwill_adjustment`"
  dimensions:
    - name: "goodwill_type"
      expr: goodwill_type
      comment: "Type of goodwill adjustment (parts waiver, labor waiver, cash compensation, service voucher) — spend category dimension."
    - name: "goodwill_adjustment_status"
      expr: goodwill_adjustment_status
      comment: "Status of the goodwill adjustment (pending, approved, rejected, paid) — lifecycle tracking dimension."
    - name: "approval_authority_level"
      expr: approval_authority_level
      comment: "Authority level required to approve the adjustment — measures escalation frequency and spend governance."
    - name: "nps_impact_flag"
      expr: nps_impact_flag
      comment: "Indicates whether the adjustment was driven by NPS/customer satisfaction concern — links spend to customer retention."
    - name: "warranty_flag"
      expr: warranty_flag
      comment: "Indicates whether the goodwill is related to a warranty event — cost allocation dimension."
    - name: "adjustment_month"
      expr: DATE_TRUNC('MONTH', adjustment_timestamp)
      comment: "Month the goodwill adjustment was made — time dimension for spend trend analysis."
  measures:
    - name: "total_goodwill_adjustments"
      expr: COUNT(1)
      comment: "Total number of goodwill adjustments — baseline volume KPI for customer satisfaction spend management."
    - name: "total_approved_goodwill_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved goodwill spend — primary financial KPI for discretionary customer satisfaction investment."
    - name: "total_goodwill_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost component of goodwill adjustments — measures labor waiver spend."
    - name: "total_goodwill_parts_cost"
      expr: SUM(CAST(part_cost AS DOUBLE))
      comment: "Total parts cost component of goodwill adjustments — measures parts waiver spend."
    - name: "total_goodwill_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on goodwill adjustments — required for financial reporting accuracy."
    - name: "avg_goodwill_amount"
      expr: AVG(CAST(approved_amount AS DOUBLE))
      comment: "Average approved goodwill amount per adjustment — benchmark for spend per customer satisfaction event."
    - name: "nps_driven_goodwill_count"
      expr: COUNT(CASE WHEN nps_impact_flag = TRUE THEN 1 END)
      comment: "Number of goodwill adjustments driven by NPS concerns — measures customer retention investment volume."
    - name: "nps_driven_goodwill_spend"
      expr: SUM(CASE WHEN nps_impact_flag = TRUE THEN approved_amount ELSE 0 END)
      comment: "Total goodwill spend driven by NPS/satisfaction concerns — measures cost of customer retention through goodwill."
    - name: "distinct_dealerships_with_goodwill"
      expr: COUNT(DISTINCT goodwill_dealership_id)
      comment: "Number of distinct dealerships issuing goodwill adjustments — identifies high-goodwill locations for quality intervention."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_parts_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aftersales parts order financial and fulfillment KPIs — drives parts supply chain performance, backorder management, and service parts revenue."
  source: "`vibe_automotive_v1`.`aftersales`.`aftersales_parts_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the parts order (open, shipped, delivered, cancelled) — fulfillment lifecycle dimension."
    - name: "order_type"
      expr: order_type
      comment: "Type of parts order (emergency, standard, warranty, recall) — priority and cost classification."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method selected (standard, express, overnight) — logistics cost and speed dimension."
    - name: "backorder_flag"
      expr: backorder_flag
      comment: "Indicates whether any items are on backorder — measures supply availability and service disruption risk."
    - name: "priority_flag"
      expr: priority_flag
      comment: "Indicates high-priority parts orders — measures urgent supply demand."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for the parts order — financial terms dimension for cash flow analysis."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_timestamp)
      comment: "Month the parts order was placed — time dimension for demand trend analysis."
  measures:
    - name: "total_parts_orders"
      expr: COUNT(1)
      comment: "Total number of parts orders — baseline volume KPI for parts supply chain management."
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total gross value of parts orders — primary revenue KPI for parts business."
    - name: "total_net_order_value"
      expr: SUM(CAST(net_total AS DOUBLE))
      comment: "Total net value after discounts — true parts revenue contribution."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts granted on parts orders — monitors discount leakage in parts business."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost on parts orders — measures logistics cost burden on parts supply chain."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on parts orders — required for tax compliance reporting."
    - name: "avg_order_value"
      expr: AVG(CAST(total_order_value AS DOUBLE))
      comment: "Average parts order value — benchmark for order size and customer purchasing behavior."
    - name: "backorder_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN backorder_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of parts orders with backorder items — critical supply availability KPI for service operations."
    - name: "priority_order_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN priority_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of parts orders flagged as priority — measures urgent demand pressure on supply chain."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_service_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service contract portfolio value, renewal, and claims KPIs — measures extended service revenue, contract penetration, and financial risk management."
  source: "`vibe_automotive_v1`.`aftersales`.`service_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of service contract (maintenance, extended warranty, roadside, comprehensive) — product mix dimension."
    - name: "service_contract_status"
      expr: service_contract_status
      comment: "Current status of the service contract (active, expired, cancelled, transferred) — portfolio health dimension."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for the contract (upfront, financed, monthly) — revenue recognition dimension."
    - name: "is_transferable"
      expr: is_transferable
      comment: "Indicates whether the contract can be transferred to a new owner — used-vehicle value-add dimension."
    - name: "is_refundable"
      expr: is_refundable
      comment: "Indicates whether the contract is refundable — financial risk dimension for cancellation reserve."
    - name: "warranty_flag"
      expr: warranty_flag
      comment: "Indicates warranty-backed service contract — cost allocation dimension."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates regulatory compliance requirement for the contract — compliance monitoring dimension."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', CAST(effective_from AS TIMESTAMP))
      comment: "Month the service contract became effective — time dimension for contract inception trend analysis."
  measures:
    - name: "total_service_contracts"
      expr: COUNT(1)
      comment: "Total number of service contracts — baseline portfolio size KPI."
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total gross value of service contracts — primary revenue KPI for extended services business."
    - name: "total_net_contract_value"
      expr: SUM(CAST(net_contract_value AS DOUBLE))
      comment: "Total net contract value after discounts — true extended services revenue contribution."
    - name: "total_deductible_amount"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductible amounts across contracts — measures customer cost-sharing in service contracts."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on service contracts — required for tax compliance and revenue reporting."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average service contract value — benchmark for contract pricing and product mix effectiveness."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN service_contract_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active service contracts — measures live portfolio size for revenue forecasting."
    - name: "cancelled_contract_count"
      expr: COUNT(CASE WHEN service_contract_status = 'CANCELLED' THEN 1 END)
      comment: "Number of cancelled service contracts — measures churn and cancellation reserve adequacy."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN service_contract_status = 'CANCELLED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service contracts cancelled — key financial risk KPI for extended services profitability."
    - name: "distinct_vehicles_covered"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of unique vehicles covered by service contracts — measures service contract penetration rate."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_field_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field service visit KPIs — measures field technician productivity, visit outcomes, and follow-up rates for mobile and on-site service operations."
  source: "`vibe_automotive_v1`.`aftersales`.`field_visit`"
  dimensions:
    - name: "visit_type"
      expr: visit_type
      comment: "Type of field visit (inspection, repair, investigation, audit) — primary classification for field service analysis."
    - name: "visit_status"
      expr: visit_status
      comment: "Current status of the field visit (scheduled, in-progress, completed, cancelled) — lifecycle tracking dimension."
    - name: "purpose"
      expr: purpose
      comment: "Business purpose of the field visit — enables analysis by service objective."
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Indicates whether a follow-up visit is required — measures first-visit resolution rate."
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', CAST(scheduled_date AS TIMESTAMP))
      comment: "Month the field visit was scheduled — time dimension for field service demand trend analysis."
  measures:
    - name: "total_field_visits"
      expr: COUNT(1)
      comment: "Total number of field visits — baseline volume KPI for field service operations."
    - name: "total_mileage_km"
      expr: SUM(CAST(mileage_km AS DOUBLE))
      comment: "Total mileage driven for field visits — measures field service logistics cost and technician travel burden."
    - name: "avg_mileage_per_visit_km"
      expr: AVG(CAST(mileage_km AS DOUBLE))
      comment: "Average mileage per field visit — benchmark for field service territory efficiency."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END)
      comment: "Number of field visits requiring follow-up — measures first-visit resolution failure rate."
    - name: "first_visit_resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_required_flag = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of field visits resolved without follow-up — key field service quality and efficiency KPI."
    - name: "distinct_technicians_deployed"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct technicians deployed on field visits — measures field workforce utilization."
    - name: "distinct_vehicles_visited"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of unique vehicles receiving field visits — measures field service reach across vehicle parc."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_technician_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technician workforce KPIs — measures certification coverage, efficiency ratings, and field service eligibility across the service technician workforce."
  source: "`vibe_automotive_v1`.`aftersales`.`technician`"
  dimensions:
    - name: "skill_level"
      expr: skill_level
      comment: "Technician skill level (apprentice, journeyman, master, specialist) — workforce capability dimension."
    - name: "certification_level"
      expr: certification_level
      comment: "Certification level achieved — measures workforce qualification depth."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification held (OEM, ASE, EV, ADAS) — measures specialized capability coverage."
    - name: "technician_status"
      expr: technician_status
      comment: "Current employment/availability status of the technician — workforce planning dimension."
    - name: "availability_status"
      expr: availability_status
      comment: "Current availability status (available, assigned, on-leave) — real-time capacity dimension."
    - name: "field_services_eligible_flag"
      expr: field_services_eligible_flag
      comment: "Indicates eligibility for field/mobile service — measures mobile service workforce capacity."
    - name: "overtime_eligible"
      expr: overtime_eligible
      comment: "Indicates overtime eligibility — workforce flexibility dimension for peak demand planning."
    - name: "specialization"
      expr: specialization
      comment: "Technical specialization area (EV, ADAS, powertrain, body) — capability mix dimension."
  measures:
    - name: "total_technicians"
      expr: COUNT(1)
      comment: "Total number of technicians in the workforce — baseline headcount KPI for service capacity planning."
    - name: "avg_flat_rate_efficiency"
      expr: AVG(CAST(flat_rate_efficiency_rating AS DOUBLE))
      comment: "Average flat-rate efficiency rating across technicians — primary technician productivity KPI for service operations."
    - name: "avg_overtime_rate_multiplier"
      expr: AVG(CAST(overtime_rate_multiplier AS DOUBLE))
      comment: "Average overtime rate multiplier — measures labor cost premium for overtime utilization."
    - name: "field_eligible_technician_count"
      expr: COUNT(CASE WHEN field_services_eligible_flag = TRUE THEN 1 END)
      comment: "Number of technicians eligible for field/mobile service — measures mobile service workforce capacity."
    - name: "field_eligible_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN field_services_eligible_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of technicians eligible for field service — measures mobile service capability coverage."
    - name: "distinct_service_centers_covered"
      expr: COUNT(DISTINCT service_center_id)
      comment: "Number of distinct service centers with assigned technicians — measures workforce distribution across network."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_warranty_parts_return`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warranty parts return and supplier chargeback KPIs — measures parts return volumes, chargeback recovery, and failure analysis outcomes for quality and cost management."
  source: "`vibe_automotive_v1`.`aftersales`.`parts_return`"
  dimensions:
    - name: "return_status"
      expr: return_status
      comment: "Current status of the warranty parts return (pending, received, inspected, disposed) — lifecycle tracking dimension."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for the parts return — primary quality failure classification dimension."
  measures:
    - name: "total_warranty_parts_returns"
      expr: COUNT(1)
      comment: "Total number of warranty parts returns — baseline volume KPI for parts return program management."
    - name: "distinct_suppliers_charged"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of distinct suppliers receiving chargebacks — measures breadth of supplier accountability program."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_roadside_assistance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Roadside assistance event KPIs — measures breakdown frequency, response performance, and cost for connected mobility and customer experience management."
  source: "`vibe_automotive_v1`.`aftersales`.`roadside_assistance_event`"
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Type of roadside assistance service (tow, battery jump, tire change, fuel delivery, lockout) — incident classification dimension."
    - name: "roadside_assistance_event_status"
      expr: roadside_assistance_event_status
      comment: "Current status of the roadside assistance event (dispatched, en-route, resolved, cancelled) — operational tracking dimension."
    - name: "provider_name"
      expr: provider_name
      comment: "Name of the roadside assistance provider — enables provider performance benchmarking."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', CAST(request_at AS TIMESTAMP))
      comment: "Month the roadside assistance was requested — time dimension for incident trend analysis."
  measures:
    - name: "total_roadside_events"
      expr: COUNT(1)
      comment: "Total number of roadside assistance events — baseline volume KPI for breakdown frequency analysis."
    - name: "total_assistance_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of roadside assistance events — primary financial KPI for roadside program cost management."
    - name: "avg_assistance_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per roadside assistance event — benchmark for provider cost efficiency."
    - name: "distinct_vehicles_assisted"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of unique vehicles requiring roadside assistance — measures breakdown incidence rate across vehicle parc."
    - name: "distinct_providers_used"
      expr: COUNT(DISTINCT provider_name)
      comment: "Number of distinct roadside assistance providers used — measures provider network breadth."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_loaner_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loaner vehicle assignment KPIs — measures loaner fleet utilization, excess mileage recovery, and fuel cost management for service operations."
  source: "`vibe_automotive_v1`.`aftersales`.`loaner_assignment`"
  dimensions:
    - name: "loaner_assignment_status"
      expr: loaner_assignment_status
      comment: "Current status of the loaner assignment (active, returned, overdue, cancelled) — fleet utilization dimension."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of loaner assignment (warranty, recall, customer pay, goodwill) — cost allocation dimension."
    - name: "loaner_vehicle_type"
      expr: loaner_vehicle_type
      comment: "Type of loaner vehicle provided — fleet composition dimension for customer satisfaction analysis."
    - name: "loaner_category"
      expr: loaner_category
      comment: "Category of loaner (standard, premium, EV) — measures fleet tier utilization."
    - name: "damage_assessed_flag"
      expr: damage_assessed_flag
      comment: "Indicates whether damage was assessed at return — measures loaner fleet damage rate."
    - name: "fuel_refill_required"
      expr: fuel_refill_required
      comment: "Indicates whether fuel refill was required at return — measures fuel policy compliance."
    - name: "checkout_month"
      expr: DATE_TRUNC('MONTH', checkout_timestamp)
      comment: "Month the loaner was checked out — time dimension for loaner demand trend analysis."
  measures:
    - name: "total_loaner_assignments"
      expr: COUNT(1)
      comment: "Total number of loaner vehicle assignments — baseline volume KPI for loaner fleet demand."
    - name: "total_loaner_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charges collected for loaner assignments — measures loaner revenue recovery."
    - name: "total_excess_mileage_charge"
      expr: SUM(CAST(mileage_excess_charge AS DOUBLE))
      comment: "Total excess mileage charges collected — measures policy enforcement and cost recovery."
    - name: "total_fuel_refill_charge"
      expr: SUM(CAST(fuel_refill_charge AS DOUBLE))
      comment: "Total fuel refill charges collected — measures fuel policy compliance and cost recovery."
    - name: "avg_fuel_level_at_checkout"
      expr: AVG(CAST(fuel_level_checkout AS DOUBLE))
      comment: "Average fuel level at loaner checkout — measures fleet readiness and preparation standards."
    - name: "damage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN damage_assessed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of loaner assignments with damage assessed at return — measures loaner fleet damage exposure."
    - name: "distinct_vehicles_loaned"
      expr: COUNT(DISTINCT loaner_vehicle_id)
      comment: "Number of distinct loaner vehicles utilized — measures active loaner fleet utilization rate."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_pdi_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pre-delivery inspection (PDI) quality KPIs — measures inspection pass rates, defect discovery, and rework requirements before vehicle delivery to customers."
  source: "`vibe_automotive_v1`.`aftersales`.`aftersales_pdi_inspection`"
  dimensions:
    - name: "inspection_result"
      expr: inspection_result
      comment: "Overall result of the PDI inspection (pass, fail, conditional) — primary quality outcome dimension."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (scheduled, in-progress, completed, released) — lifecycle tracking dimension."
    - name: "pass_fail_flag"
      expr: pass_fail_flag
      comment: "Boolean pass/fail outcome of the PDI — primary quality gate dimension."
    - name: "rework_required_flag"
      expr: rework_required_flag
      comment: "Indicates whether rework was required after PDI — measures first-pass quality rate."
    - name: "ota_baseline_verified_flag"
      expr: ota_baseline_verified_flag
      comment: "Indicates whether OTA software baseline was verified during PDI — measures connected vehicle readiness."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', CAST(inspection_date AS TIMESTAMP))
      comment: "Month the PDI was conducted — time dimension for quality trend analysis."
  measures:
    - name: "total_pdi_inspections"
      expr: COUNT(1)
      comment: "Total number of PDI inspections conducted — baseline volume KPI for pre-delivery quality program."
    - name: "pass_count"
      expr: COUNT(CASE WHEN pass_fail_flag = TRUE THEN 1 END)
      comment: "Number of PDI inspections that passed — measures first-pass quality rate."
    - name: "fail_count"
      expr: COUNT(CASE WHEN pass_fail_flag = FALSE THEN 1 END)
      comment: "Number of PDI inspections that failed — measures quality defect discovery rate at delivery."
    - name: "pdi_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PDI inspections passing — primary pre-delivery quality KPI for dealer network management."
    - name: "rework_required_count"
      expr: COUNT(CASE WHEN rework_required_flag = TRUE THEN 1 END)
      comment: "Number of vehicles requiring rework after PDI — measures quality defect severity and rework cost exposure."
    - name: "rework_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rework_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PDI inspections requiring rework — key quality KPI for manufacturing and logistics handoff quality."
    - name: "ota_verified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ota_baseline_verified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PDI inspections with OTA baseline verified — measures connected vehicle delivery readiness."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`aftersales_dtc_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and compliance metrics derived from diagnostic trouble code events"
  source: "`vibe_automotive_v1`.`aftersales`.`aftersales_dtc_event`"
  dimensions:
    - name: "dtc_category"
      expr: dtc_category
      comment: "High‑level category of the DTC"
    - name: "dtc_code"
      expr: dtc_code
      comment: "Specific DTC code identifier"
    - name: "dtc_status"
      expr: dtc_status
      comment: "Current status of the DTC (e.g., active, pending)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity rating of the DTC"
    - name: "service_center_id"
      expr: service_center_id
      comment: "Service center where the DTC was recorded"
    - name: "event_type"
      expr: event_type
      comment: "Type of diagnostic event"
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date the DTC event occurred"
    - name: "warranty_covered_flag"
      expr: warranty_covered_flag
      comment: "Indicates if the DTC is covered under warranty"
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of DTC events captured"
    - name: "distinct_vehicles_affected"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of unique vehicles that generated DTC events"
    - name: "cleared_event_count"
      expr: SUM(CASE WHEN cleared_flag THEN 1 ELSE 0 END)
      comment: "Count of DTC events that have been cleared"
    - name: "emission_related_event_count"
      expr: SUM(CASE WHEN emission_related_flag THEN 1 ELSE 0 END)
      comment: "Count of DTC events related to emissions"
$$;