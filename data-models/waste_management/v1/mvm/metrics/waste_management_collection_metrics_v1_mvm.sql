-- Metric views for domain: collection | Business: Waste Management | Version: 1 | Generated on: 2026-05-07 22:39:52

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`collection_route_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for daily route execution performance, covering tonnage throughput, stop completion rates, fuel efficiency, and service reliability. Used by operations managers and VPs to steer fleet deployment, driver productivity, and route planning decisions."
  source: "`waste_management_ecm`.`collection`.`route_execution`"
  dimensions:
    - name: "service_date"
      expr: service_date
      comment: "Date the route was executed — primary time dimension for daily and weekly operational trending."
    - name: "route_type"
      expr: route_type
      comment: "Type of collection route (e.g., residential, commercial, rolloff) — enables performance segmentation by service line."
    - name: "execution_status"
      expr: execution_status
      comment: "Completion status of the route execution (e.g., completed, partial, cancelled) — critical for service reliability reporting."
    - name: "service_frequency"
      expr: service_frequency
      comment: "Frequency of service on this route (e.g., weekly, bi-weekly) — supports capacity planning analysis."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions during route execution — used to correlate operational disruptions with environmental factors."
    - name: "overtime_flag"
      expr: overtime_flag
      comment: "Indicates whether the route execution incurred overtime — used to monitor labor cost overruns."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Indicates whether a safety incident occurred during this route execution — key safety KPI dimension."
    - name: "customer_complaint_flag"
      expr: customer_complaint_flag
      comment: "Indicates whether a customer complaint was associated with this route execution — service quality signal."
  measures:
    - name: "total_routes_executed"
      expr: COUNT(1)
      comment: "Total number of route executions in the period. Baseline volume metric for operational throughput reporting."
    - name: "total_tonnage_collected"
      expr: SUM(CAST(total_tonnage_collected AS DOUBLE))
      comment: "Total waste tonnage collected across all route executions. Core throughput KPI used to assess collection capacity utilization and landfill/transfer station demand."
    - name: "avg_tonnage_per_route"
      expr: AVG(CAST(total_tonnage_collected AS DOUBLE))
      comment: "Average tonnage collected per route execution. Indicates route loading efficiency — low values may signal under-utilized routes or missed stops."
    - name: "total_volume_collected_cubic_yards"
      expr: SUM(CAST(total_volume_collected_cubic_yards AS DOUBLE))
      comment: "Total volumetric collection across all routes. Complements tonnage for routes where volume (not weight) drives billing or capacity constraints."
    - name: "total_fuel_consumed_gallons"
      expr: SUM(CAST(fuel_consumed_gallons AS DOUBLE))
      comment: "Total fuel consumed across all route executions. Directly tied to fleet operating cost and GHG emissions reporting."
    - name: "avg_fuel_consumed_per_route_gallons"
      expr: AVG(CAST(fuel_consumed_gallons AS DOUBLE))
      comment: "Average fuel consumption per route execution. Used to benchmark fuel efficiency and identify outlier routes for optimization."
    - name: "total_distance_traveled_miles"
      expr: SUM(CAST(distance_traveled_miles AS DOUBLE))
      comment: "Total miles driven across all route executions. Key input for fleet cost modeling, maintenance scheduling, and route optimization ROI."
    - name: "avg_distance_per_route_miles"
      expr: AVG(CAST(distance_traveled_miles AS DOUBLE))
      comment: "Average miles driven per route execution. Benchmarks route compactness — high values may indicate optimization opportunities."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average percentage of planned stops completed per route execution. Primary service delivery KPI — low values trigger operational investigation and customer escalation."
    - name: "routes_with_safety_incidents"
      expr: SUM(CASE WHEN safety_incident_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of route executions with at least one safety incident. Safety KPI tracked at executive level — any upward trend triggers immediate intervention."
    - name: "routes_with_overtime"
      expr: SUM(CASE WHEN overtime_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of route executions that incurred overtime. Labor cost control KPI — high overtime rates signal route imbalance or staffing gaps."
    - name: "routes_with_customer_complaints"
      expr: SUM(CASE WHEN customer_complaint_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of route executions associated with a customer complaint. Service quality KPI used in customer satisfaction and contract compliance reviews."
    - name: "unique_routes_executed"
      expr: COUNT(DISTINCT route_id)
      comment: "Number of distinct routes that were executed in the period. Used to assess route coverage and identify routes with no execution activity."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`collection_pickup_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stop-level pickup performance KPIs capturing service outcomes, contamination rates, weight estimates, and exception patterns. Used by operations and customer service leadership to monitor service quality at the most granular level."
  source: "`waste_management_ecm`.`collection`.`pickup_event`"
  dimensions:
    - name: "service_outcome"
      expr: service_outcome
      comment: "Outcome of the pickup event (e.g., completed, missed, contaminated, refused) — primary dimension for service quality analysis."
    - name: "contamination_flag"
      expr: contamination_flag
      comment: "Indicates whether contamination was detected at this pickup — drives recycling diversion rate and contamination cost analysis."
    - name: "contamination_type"
      expr: contamination_type
      comment: "Type of contamination detected — used to identify systemic contamination patterns by material or customer segment."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Indicates whether the pickup event is billable — used to reconcile service delivery against revenue recognition."
    - name: "truck_loader_type"
      expr: truck_loader_type
      comment: "Type of truck loader used (e.g., rear-load, side-load, front-load) — supports equipment utilization and cost analysis."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions at time of pickup — used to correlate service exceptions and missed pickups with weather events."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Indicates whether a safety incident occurred at this pickup stop — safety performance dimension."
    - name: "exception_code"
      expr: exception_code
      comment: "Exception code recorded at the pickup stop (e.g., blocked access, no container, overweight) — root cause analysis dimension."
  measures:
    - name: "total_pickup_events"
      expr: COUNT(1)
      comment: "Total number of pickup events recorded. Baseline volume metric for service delivery throughput."
    - name: "total_estimated_weight_lbs"
      expr: SUM(CAST(estimated_weight_lbs AS DOUBLE))
      comment: "Total estimated waste weight collected across all pickup events. Used for tonnage forecasting and transfer station capacity planning."
    - name: "avg_estimated_weight_per_pickup_lbs"
      expr: AVG(CAST(estimated_weight_lbs AS DOUBLE))
      comment: "Average estimated weight per pickup event. Benchmarks container fill rates — low averages may indicate over-servicing or route inefficiency."
    - name: "contaminated_pickup_count"
      expr: SUM(CASE WHEN contamination_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of pickup events with contamination detected. Directly impacts recycling diversion rates and MRF processing costs — tracked at executive level."
    - name: "billable_pickup_count"
      expr: SUM(CASE WHEN billable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of billable pickup events. Used to reconcile service delivery volume against invoiced services and identify revenue leakage."
    - name: "total_service_charge_amount"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges generated from pickup events. Revenue KPI at the stop level — used to assess per-route and per-customer revenue contribution."
    - name: "total_overage_charge_amount"
      expr: SUM(CAST(overage_charge_amount AS DOUBLE))
      comment: "Total overage charges collected from overweight or over-volume pickups. Ancillary revenue KPI and signal for container right-sizing opportunities."
    - name: "avg_compaction_ratio"
      expr: AVG(CAST(compaction_ratio AS DOUBLE))
      comment: "Average compaction ratio across pickup events. Operational efficiency KPI — higher compaction means more waste per truck load, reducing haul frequency and cost."
    - name: "safety_incident_count"
      expr: SUM(CASE WHEN safety_incident_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of pickup events with a safety incident. Safety KPI monitored at VP and C-level — any increase triggers immediate safety review."
    - name: "photo_captured_count"
      expr: SUM(CASE WHEN photo_captured_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of pickup events where a photo was captured. Proxy for driver compliance with documentation requirements — used in quality audits."
    - name: "unique_customers_served"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customer accounts served in the period. Used to measure service reach and identify customers with missed or incomplete service."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`collection_service_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service exception and failure KPIs tracking exception volumes, resolution performance, SLA breach rates, and credit issuance. Used by operations, customer service, and compliance leadership to manage service quality and contractual obligations."
  source: "`waste_management_ecm`.`collection`.`service_exception`"
  dimensions:
    - name: "exception_type_code"
      expr: exception_type_code
      comment: "Categorical code for the type of service exception (e.g., missed pickup, contamination, access blocked) — primary dimension for root cause analysis."
    - name: "exception_status"
      expr: exception_status
      comment: "Current resolution status of the exception (e.g., open, resolved, escalated) — used to monitor backlog and resolution velocity."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level root cause category for the exception — enables systemic issue identification and corrective action prioritization."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the exception — used to assess whether high-priority exceptions are being resolved within SLA."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates whether the exception resulted in an SLA breach — critical for contract compliance and penalty exposure tracking."
    - name: "preventable_flag"
      expr: preventable_flag
      comment: "Indicates whether the exception was preventable — used to distinguish systemic operational failures from unavoidable events."
    - name: "repeat_exception_flag"
      expr: repeat_exception_flag
      comment: "Indicates whether this is a repeat exception for the same location or customer — signals chronic service failures requiring escalation."
    - name: "contamination_severity"
      expr: contamination_severity
      comment: "Severity level of contamination associated with the exception — used to prioritize remediation and customer education efforts."
  measures:
    - name: "total_service_exceptions"
      expr: COUNT(1)
      comment: "Total number of service exceptions recorded. Baseline volume KPI for service quality monitoring — tracked weekly and monthly by operations leadership."
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of exceptions that resulted in an SLA breach. Contract compliance KPI — high breach counts expose the business to financial penalties and contract termination risk."
    - name: "preventable_exception_count"
      expr: SUM(CASE WHEN preventable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of exceptions classified as preventable. Operational quality KPI — high preventable counts indicate systemic process failures that leadership must address."
    - name: "repeat_exception_count"
      expr: SUM(CASE WHEN repeat_exception_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of repeat exceptions at the same location or customer. Chronic failure KPI — repeat exceptions drive customer churn and regulatory scrutiny."
    - name: "credit_issued_count"
      expr: SUM(CASE WHEN credit_issued_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of exceptions where a service credit was issued to the customer. Revenue impact KPI — tracks financial exposure from service failures."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total dollar value of credits issued due to service exceptions. Direct revenue leakage KPI — monitored by finance and operations to quantify the cost of service failures."
    - name: "avg_credit_amount_per_exception"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average credit amount issued per exception. Used to benchmark the financial severity of exceptions and assess whether credit policies are appropriately calibrated."
    - name: "exceptions_requiring_follow_up"
      expr: SUM(CASE WHEN requires_follow_up_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of exceptions requiring follow-up action. Operational backlog KPI — high open follow-up counts indicate resolution capacity constraints."
    - name: "exceptions_requiring_reschedule"
      expr: SUM(CASE WHEN reschedule_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of exceptions requiring a service reschedule. Directly impacts route planning and customer satisfaction — used to quantify missed-service recovery workload."
    - name: "unique_customers_with_exceptions"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers who experienced a service exception. Customer impact breadth KPI — used in customer satisfaction and churn risk analysis."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`collection_outbound_haul`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound haul performance and cost KPIs covering tonnage throughput, tipping fees, fuel consumption, and rejection rates. Used by operations and finance leadership to manage disposal costs, haul efficiency, and regulatory compliance."
  source: "`waste_management_ecm`.`collection`.`outbound_haul`"
  dimensions:
    - name: "haul_status"
      expr: haul_status
      comment: "Current status of the outbound haul (e.g., dispatched, completed, rejected) — primary operational status dimension."
    - name: "destination_facility_type"
      expr: destination_facility_type
      comment: "Type of destination facility (e.g., landfill, MRF, WTE) — used to analyze disposal cost and diversion by facility type."
    - name: "contamination_flag"
      expr: contamination_flag
      comment: "Indicates whether the haul load was contaminated — contaminated loads incur rejection costs and regulatory risk."
    - name: "contamination_type"
      expr: contamination_type
      comment: "Type of contamination in the haul load — used to identify contamination sources and implement corrective actions."
    - name: "load_rejection_flag"
      expr: load_rejection_flag
      comment: "Indicates whether the haul load was rejected at the destination facility — rejection events drive significant cost and operational disruption."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Indicates whether a safety incident occurred during the haul — safety performance dimension for fleet operations."
  measures:
    - name: "total_hauls"
      expr: COUNT(1)
      comment: "Total number of outbound hauls executed. Baseline throughput metric for disposal operations."
    - name: "total_actual_tonnage"
      expr: SUM(CAST(actual_tonnage AS DOUBLE))
      comment: "Total actual waste tonnage hauled to disposal facilities. Primary disposal throughput KPI — used to track landfill airspace consumption and disposal cost accrual."
    - name: "avg_actual_tonnage_per_haul"
      expr: AVG(CAST(actual_tonnage AS DOUBLE))
      comment: "Average tonnage per outbound haul. Truck utilization KPI — low averages indicate under-loaded hauls and excess disposal trips."
    - name: "total_tipping_fee_amount"
      expr: SUM(CAST(tipping_fee_amount AS DOUBLE))
      comment: "Total tipping fees paid to disposal facilities. Major disposal cost KPI — directly impacts operating margin and is tracked by finance and operations leadership."
    - name: "avg_tipping_fee_per_haul"
      expr: AVG(CAST(tipping_fee_amount AS DOUBLE))
      comment: "Average tipping fee per outbound haul. Cost efficiency KPI — used to benchmark disposal costs across facilities and identify high-cost disposal routes."
    - name: "total_environmental_fee_amount"
      expr: SUM(CAST(environmental_fee_amount AS DOUBLE))
      comment: "Total environmental fees incurred on outbound hauls. Regulatory cost KPI — tracked for environmental compliance cost reporting and budget forecasting."
    - name: "total_estimated_fuel_consumption_gallons"
      expr: SUM(CAST(estimated_fuel_consumption_gallons AS DOUBLE))
      comment: "Total estimated fuel consumed on outbound hauls. Fleet operating cost and GHG emissions input — used in sustainability and cost reporting."
    - name: "total_route_distance_miles"
      expr: SUM(CAST(route_distance_miles AS DOUBLE))
      comment: "Total miles driven on outbound hauls. Used to calculate per-mile disposal cost and assess haul route optimization opportunities."
    - name: "rejected_haul_count"
      expr: SUM(CASE WHEN load_rejection_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of haul loads rejected at the destination facility. Quality and compliance KPI — rejections incur re-haul costs and may indicate contamination or permit issues."
    - name: "contaminated_haul_count"
      expr: SUM(CASE WHEN contamination_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of outbound hauls with contaminated loads. Waste quality KPI — high contamination rates increase disposal costs and risk facility permit violations."
    - name: "safety_incident_count"
      expr: SUM(CASE WHEN safety_incident_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of outbound hauls with a safety incident. Fleet safety KPI — monitored at VP level with zero-tolerance targets."
    - name: "unique_destination_facilities"
      expr: COUNT(DISTINCT destination_facility_id)
      comment: "Number of distinct destination facilities used for disposal. Disposal network diversity KPI — used to assess single-facility dependency risk."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`collection_load_ticket`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Scale house and load acceptance KPIs covering inbound tonnage, tipping fee revenue, contamination rates, and rejection decisions. Used by facility managers and finance to manage gate operations, revenue capture, and regulatory compliance."
  source: "`waste_management_ecm`.`collection`.`load_ticket`"
  dimensions:
    - name: "ticket_status"
      expr: ticket_status
      comment: "Status of the load ticket (e.g., accepted, rejected, pending) — primary gate operations status dimension."
    - name: "acceptance_decision"
      expr: acceptance_decision
      comment: "Final acceptance or rejection decision for the incoming load — used to analyze rejection rates and root causes."
    - name: "contamination_level"
      expr: contamination_level
      comment: "Level of contamination detected in the incoming load — used to assess load quality and inform tipping fee adjustments."
    - name: "contamination_type"
      expr: contamination_type
      comment: "Type of contamination detected — used to identify contamination patterns by hauler, customer, or waste stream."
    - name: "hauler_type"
      expr: hauler_type
      comment: "Type of hauler delivering the load (e.g., municipal, commercial, self-haul) — used to segment revenue and contamination rates by hauler category."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Indicates whether the load ticket is billable — used to reconcile gate activity against invoiced revenue."
    - name: "waste_origin_jurisdiction"
      expr: waste_origin_jurisdiction
      comment: "Jurisdiction of origin for the waste load — used for regulatory reporting and out-of-jurisdiction waste tracking."
  measures:
    - name: "total_load_tickets"
      expr: COUNT(1)
      comment: "Total number of load tickets processed at the scale house. Baseline inbound volume metric for facility throughput reporting."
    - name: "total_net_weight_tons"
      expr: SUM(CAST(net_weight_tons AS DOUBLE))
      comment: "Total net weight of waste received across all load tickets. Primary inbound tonnage KPI — used for capacity utilization, permit compliance, and disposal cost accrual."
    - name: "avg_net_weight_per_ticket_tons"
      expr: AVG(CAST(net_weight_tons AS DOUBLE))
      comment: "Average net weight per load ticket. Load efficiency KPI — low averages may indicate small, uneconomical loads that should be consolidated."
    - name: "total_tipping_fee_revenue"
      expr: SUM(CAST(tipping_fee_amount AS DOUBLE))
      comment: "Total tipping fee revenue collected from inbound loads. Primary facility revenue KPI — tracked by finance and facility management against budget targets."
    - name: "total_environmental_fee_revenue"
      expr: SUM(CAST(environmental_fee_amount AS DOUBLE))
      comment: "Total environmental fees collected on inbound loads. Regulatory fee revenue KPI — tracked separately from tipping fees for compliance reporting."
    - name: "total_charge_revenue"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total charges collected across all load tickets including tipping fees, environmental fees, and surcharges. Comprehensive facility revenue KPI."
    - name: "rejected_load_count"
      expr: SUM(CASE WHEN acceptance_decision = 'REJECTED' THEN 1 ELSE 0 END)
      comment: "Number of loads rejected at the gate. Quality control KPI — high rejection rates signal hauler compliance issues and increase operational costs."
    - name: "billable_ticket_count"
      expr: SUM(CASE WHEN billable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of billable load tickets. Revenue capture KPI — gap between total tickets and billable tickets indicates potential revenue leakage."
    - name: "unique_customers_served"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers delivering loads in the period. Facility customer reach KPI — used in commercial development and capacity planning."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`collection_facility_capacity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transfer station and facility capacity utilization KPIs covering tonnage throughput, diversion rates, permit compliance, and peak throughput. Used by operations and compliance leadership to manage facility capacity, regulatory permit adherence, and waste diversion performance."
  source: "`waste_management_ecm`.`collection`.`facility_capacity`"
  dimensions:
    - name: "record_date"
      expr: record_date
      comment: "Date of the capacity record — primary time dimension for daily and monthly capacity trend analysis."
    - name: "record_period"
      expr: record_period
      comment: "Reporting period for the capacity record (e.g., daily, monthly) — used to align metrics with regulatory reporting cycles."
    - name: "capacity_status"
      expr: capacity_status
      comment: "Operational capacity status of the facility (e.g., normal, near-capacity, over-capacity) — primary alert dimension for capacity management."
    - name: "permit_exceedance_flag"
      expr: permit_exceedance_flag
      comment: "Indicates whether the facility exceeded its permitted daily capacity — critical regulatory compliance dimension."
    - name: "record_status"
      expr: record_status
      comment: "Validation status of the capacity record — used to filter for confirmed vs. provisional data in reporting."
  measures:
    - name: "total_actual_inbound_tonnage"
      expr: SUM(CAST(actual_inbound_tonnage AS DOUBLE))
      comment: "Total actual inbound tonnage received at the facility. Primary throughput KPI — used to assess capacity utilization against permitted limits."
    - name: "total_actual_outbound_tonnage"
      expr: SUM(CAST(actual_outbound_tonnage AS DOUBLE))
      comment: "Total actual outbound tonnage dispatched from the facility. Used to verify mass balance and assess haul-out efficiency."
    - name: "avg_capacity_utilization_percentage"
      expr: AVG(CAST(capacity_utilization_percentage AS DOUBLE))
      comment: "Average facility capacity utilization as a percentage of permitted daily capacity. Core operational KPI — sustained high utilization signals need for capacity expansion or demand management."
    - name: "avg_diversion_rate_percentage"
      expr: AVG(CAST(diversion_rate_percentage AS DOUBLE))
      comment: "Average waste diversion rate at the facility. Sustainability KPI — tracked against regulatory diversion targets and reported to environmental agencies."
    - name: "total_inbound_recyclable_tonnage"
      expr: SUM(CAST(inbound_recyclable_tonnage AS DOUBLE))
      comment: "Total recyclable tonnage received. Diversion program performance KPI — used to measure recycling program effectiveness and MRF throughput planning."
    - name: "total_inbound_organics_tonnage"
      expr: SUM(CAST(inbound_organics_tonnage AS DOUBLE))
      comment: "Total organics tonnage received. Organics diversion KPI — tracked against composting program targets and regulatory organics diversion mandates."
    - name: "total_outbound_landfill_tonnage"
      expr: SUM(CAST(outbound_landfill_tonnage AS DOUBLE))
      comment: "Total tonnage sent to landfill from the facility. Landfill dependency KPI — reducing this metric is a core sustainability objective."
    - name: "total_outbound_mrf_tonnage"
      expr: SUM(CAST(outbound_mrf_tonnage AS DOUBLE))
      comment: "Total tonnage sent to MRF (Materials Recovery Facility). Recycling throughput KPI — used to assess MRF capacity demand and diversion performance."
    - name: "total_outbound_wte_tonnage"
      expr: SUM(CAST(outbound_wte_tonnage AS DOUBLE))
      comment: "Total tonnage sent to waste-to-energy facilities. WTE utilization KPI — used in energy recovery reporting and sustainability disclosures."
    - name: "permit_exceedance_days"
      expr: SUM(CASE WHEN permit_exceedance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of days the facility exceeded its permitted daily capacity. Regulatory compliance KPI — exceedances must be reported to regulators and can result in fines or permit revocation."
    - name: "total_exceedance_tonnage"
      expr: SUM(CAST(exceedance_tonnage AS DOUBLE))
      comment: "Total tonnage received in excess of permitted daily capacity. Quantifies the magnitude of permit violations — used in regulatory corrective action reporting."
    - name: "avg_peak_hour_throughput_tons"
      expr: AVG(CAST(peak_hour_throughput_tons AS DOUBLE))
      comment: "Average peak-hour throughput in tons. Operational bottleneck KPI — used to size scale house staffing, equipment, and queuing capacity."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`collection_on_demand_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "On-demand and special collection request KPIs covering request volumes, SLA compliance, revenue, and fulfillment performance. Used by customer service and operations leadership to manage responsive service delivery and ancillary revenue."
  source: "`waste_management_ecm`.`collection`.`on_demand_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Current status of the on-demand request (e.g., pending, scheduled, completed, cancelled) — primary fulfillment status dimension."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the request — used to assess whether high-priority requests are being fulfilled within SLA windows."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the request was submitted (e.g., web, phone, mobile app) — used to analyze channel mix and digital adoption."
    - name: "sla_met_flag"
      expr: sla_met_flag
      comment: "Indicates whether the on-demand request was fulfilled within the contracted SLA window — primary service level compliance dimension."
    - name: "requested_service_date"
      expr: requested_service_date
      comment: "Date the customer requested service — used to analyze demand patterns and lead time between request and fulfillment."
  measures:
    - name: "total_on_demand_requests"
      expr: COUNT(1)
      comment: "Total number of on-demand service requests received. Baseline demand volume KPI — used for capacity planning and staffing of responsive service operations."
    - name: "sla_met_count"
      expr: SUM(CASE WHEN sla_met_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of on-demand requests fulfilled within SLA. Service level compliance KPI — directly tied to contract performance and customer satisfaction scores."
    - name: "total_service_charge_revenue"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges collected from on-demand requests. Ancillary revenue KPI — on-demand services typically carry premium pricing and are a key revenue growth lever."
    - name: "total_disposal_fee_revenue"
      expr: SUM(CAST(disposal_fee_amount AS DOUBLE))
      comment: "Total disposal fees collected from on-demand requests. Disposal revenue component — used to assess full revenue yield per on-demand service event."
    - name: "total_charge_revenue"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total charges collected across all on-demand requests. Comprehensive on-demand revenue KPI — tracked against budget and prior period for growth analysis."
    - name: "avg_actual_weight_tons"
      expr: AVG(CAST(actual_weight_tons AS DOUBLE))
      comment: "Average actual waste weight per on-demand request. Used to benchmark disposal cost per request and validate estimated weight accuracy."
    - name: "total_actual_weight_tons"
      expr: SUM(CAST(actual_weight_tons AS DOUBLE))
      comment: "Total actual waste tonnage collected via on-demand requests. Throughput KPI for responsive service operations — used in disposal cost accrual."
    - name: "unique_customers_requesting"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers submitting on-demand requests. Customer engagement KPI — high repeat usage indicates strong service adoption and potential for upsell."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`collection_rolloff_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Roll-off container order KPIs covering order volumes, revenue, weight performance, and rental economics. Used by commercial sales, operations, and finance to manage the roll-off service line profitability and customer demand."
  source: "`waste_management_ecm`.`collection`.`rolloff_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the roll-off order (e.g., pending, active, completed, cancelled) — primary order lifecycle dimension."
    - name: "container_size_yards"
      expr: container_size_yards
      comment: "Size of the roll-off container in cubic yards — used to analyze revenue and utilization by container size tier."
    - name: "permit_required_flag"
      expr: permit_required_flag
      comment: "Indicates whether a permit is required for the placement — used to track permit compliance and associated administrative overhead."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for the roll-off order — used in accounts receivable and cash flow analysis."
  measures:
    - name: "total_rolloff_orders"
      expr: COUNT(1)
      comment: "Total number of roll-off orders placed. Baseline demand volume KPI for the roll-off service line."
    - name: "total_charge_revenue"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total revenue collected from roll-off orders including base rental, disposal, and overage charges. Primary roll-off service line revenue KPI."
    - name: "total_disposal_charge"
      expr: SUM(CAST(disposal_charge AS DOUBLE))
      comment: "Total disposal charges collected from roll-off orders. Disposal revenue component — used to assess disposal cost recovery and margin."
    - name: "total_base_rental_charge"
      expr: SUM(CAST(base_rental_charge AS DOUBLE))
      comment: "Total base rental revenue from roll-off containers. Rental revenue KPI — used to assess container fleet utilization and rental pricing effectiveness."
    - name: "total_overage_charge_revenue"
      expr: SUM(CAST(overage_charge_amount AS DOUBLE))
      comment: "Total overage charges collected from overweight roll-off loads. Ancillary revenue KPI and signal for weight limit calibration opportunities."
    - name: "total_environmental_fee_revenue"
      expr: SUM(CAST(environmental_fee AS DOUBLE))
      comment: "Total environmental fees collected on roll-off orders. Regulatory fee revenue component — tracked for compliance cost recovery reporting."
    - name: "total_actual_weight_tons"
      expr: SUM(CAST(actual_weight_tons AS DOUBLE))
      comment: "Total actual waste weight collected via roll-off orders. Disposal throughput KPI — used for landfill capacity planning and disposal cost accrual."
    - name: "avg_actual_weight_per_order_tons"
      expr: AVG(CAST(actual_weight_tons AS DOUBLE))
      comment: "Average actual weight per roll-off order. Container utilization KPI — used to right-size container offerings and identify over/under-utilized container sizes."
    - name: "total_overage_weight_tons"
      expr: SUM(CAST(overage_weight_tons AS DOUBLE))
      comment: "Total weight exceeding the contracted weight limit across roll-off orders. Revenue recovery and compliance KPI — high overage volumes indicate need for weight limit renegotiation."
    - name: "unique_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers placing roll-off orders. Customer base KPI for the roll-off service line — used in commercial sales pipeline and retention analysis."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`collection_route_optimization_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Route optimization run performance KPIs covering optimization quality, mileage savings, and acceptance rates. Used by operations engineering and fleet management to evaluate the ROI of route optimization investments and algorithm performance."
  source: "`waste_management_ecm`.`collection`.`route_optimization_run`"
  dimensions:
    - name: "optimization_status"
      expr: optimization_status
      comment: "Status of the optimization run (e.g., completed, failed, in-progress) — used to filter for successful runs in performance analysis."
    - name: "acceptance_decision"
      expr: acceptance_decision
      comment: "Whether the optimized routes were accepted or rejected by operations — used to measure optimization adoption rate."
    - name: "optimization_scenario_type"
      expr: optimization_scenario_type
      comment: "Type of optimization scenario run (e.g., daily, weekly, seasonal) — used to compare performance across planning horizons."
    - name: "primary_optimization_objective"
      expr: primary_optimization_objective
      comment: "Primary objective of the optimization run (e.g., minimize miles, minimize time, minimize cost) — used to assess objective-specific performance."
    - name: "execution_mode"
      expr: execution_mode
      comment: "Mode of execution (e.g., automated, manual, simulation) — used to compare automated vs. manual optimization outcomes."
    - name: "algorithm_version"
      expr: algorithm_version
      comment: "Version of the optimization algorithm used — used to track performance improvements across algorithm releases."
    - name: "effective_date"
      expr: effective_date
      comment: "Date the optimized routes are effective — primary time dimension for optimization run trending."
  measures:
    - name: "total_optimization_runs"
      expr: COUNT(1)
      comment: "Total number of route optimization runs executed. Baseline activity metric for the optimization program."
    - name: "accepted_optimization_runs"
      expr: SUM(CASE WHEN acceptance_decision = 'ACCEPTED' THEN 1 ELSE 0 END)
      comment: "Number of optimization runs whose results were accepted and implemented. Adoption rate numerator — low acceptance rates indicate a gap between algorithmic recommendations and operational reality."
    - name: "avg_miles_improvement_percentage"
      expr: AVG(CAST(miles_improvement_percentage AS DOUBLE))
      comment: "Average percentage improvement in total route miles versus the baseline. Core optimization ROI KPI — directly translates to fuel cost savings and GHG emission reductions."
    - name: "total_baseline_miles"
      expr: SUM(CAST(baseline_total_miles AS DOUBLE))
      comment: "Total baseline route miles before optimization. Used as the denominator for savings calculations and to quantify the optimization opportunity pool."
    - name: "total_optimized_route_miles"
      expr: SUM(CAST(output_total_route_miles AS DOUBLE))
      comment: "Total optimized route miles output by the algorithm. Used with baseline miles to calculate absolute mileage savings from optimization."
    - name: "total_optimized_route_hours"
      expr: SUM(CAST(output_total_route_hours AS DOUBLE))
      comment: "Total optimized route hours output by the algorithm. Labor efficiency KPI — reduced route hours translate directly to driver cost savings."
    - name: "avg_optimization_quality_score"
      expr: AVG(CAST(optimization_quality_score AS DOUBLE))
      comment: "Average quality score of optimization runs. Algorithm performance KPI — used to track optimization solution quality over time and across algorithm versions."
    - name: "avg_stops_per_route"
      expr: AVG(CAST(output_average_stops_per_route AS DOUBLE))
      comment: "Average number of stops per optimized route. Route density KPI — used to assess whether routes are appropriately loaded and balanced."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`collection_weight_ticket`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Weight ticket KPIs for inbound waste weighing operations covering tonnage, tipping fee revenue, contamination, and rejection rates. Used by facility managers and finance to manage scale house revenue, compliance, and load quality."
  source: "`waste_management_ecm`.`collection`.`weight_ticket`"
  dimensions:
    - name: "ticket_status"
      expr: ticket_status
      comment: "Status of the weight ticket (e.g., valid, rejected, voided) — primary data quality and compliance dimension."
    - name: "load_type"
      expr: load_type
      comment: "Type of load being weighed (e.g., MSW, recyclables, C&D, organics) — used to segment tonnage and revenue by waste stream."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility where the weight ticket was issued — used to compare scale operations across facility types."
    - name: "contamination_flag"
      expr: contamination_flag
      comment: "Indicates whether contamination was detected in the weighed load — used to track contamination rates by load type and origin."
    - name: "rejection_flag"
      expr: rejection_flag
      comment: "Indicates whether the load was rejected at the scale — used to monitor rejection rates and associated cost impacts."
    - name: "origin_type"
      expr: origin_type
      comment: "Origin type of the waste load (e.g., residential, commercial, self-haul) — used to segment tonnage and revenue by customer category."
    - name: "billing_date"
      expr: billing_date
      comment: "Date the weight ticket was billed — primary time dimension for revenue recognition and billing cycle analysis."
  measures:
    - name: "total_weight_tickets"
      expr: COUNT(1)
      comment: "Total number of weight tickets processed. Baseline scale house throughput metric."
    - name: "total_net_weight_tons"
      expr: SUM(CAST(net_weight_tons AS DOUBLE))
      comment: "Total net waste weight processed across all weight tickets. Primary inbound tonnage KPI — used for permit compliance, disposal cost accrual, and capacity planning."
    - name: "avg_net_weight_per_ticket_tons"
      expr: AVG(CAST(net_weight_tons AS DOUBLE))
      comment: "Average net weight per weight ticket. Load efficiency KPI — used to assess average load size and identify opportunities for load consolidation."
    - name: "total_tipping_fee_revenue"
      expr: SUM(CAST(tipping_fee_amount AS DOUBLE))
      comment: "Total tipping fee revenue collected via weight tickets. Primary scale house revenue KPI — tracked against budget and prior period by finance and facility management."
    - name: "rejected_ticket_count"
      expr: SUM(CASE WHEN rejection_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of weight tickets with rejected loads. Quality control KPI — high rejection rates signal hauler compliance issues and increase operational costs."
    - name: "contaminated_load_count"
      expr: SUM(CASE WHEN contamination_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of weight tickets with contaminated loads. Waste quality KPI — contamination rates directly impact recycling diversion and MRF processing costs."
    - name: "unique_customers_weighed"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers with weight tickets in the period. Customer activity KPI for scale house operations — used in commercial account management."
$$;