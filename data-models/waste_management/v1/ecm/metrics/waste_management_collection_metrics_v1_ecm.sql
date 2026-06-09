-- Metric views for domain: collection | Business: Waste Management | Version: 1 | Generated on: 2026-05-07 19:57:14

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`collection_route_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core operational KPIs for route execution performance, efficiency, and service quality. Tracks completed vs planned stops, tonnage collected, fuel efficiency, and on-time performance."
  source: "`waste_management_ecm`.`collection`.`route_execution`"
  dimensions:
    - name: "service_date"
      expr: service_date
      comment: "Date of route execution for daily trend analysis"
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month of service for monthly aggregation"
    - name: "execution_status"
      expr: execution_status
      comment: "Status of route execution (completed, in-progress, cancelled)"
    - name: "route_type"
      expr: route_type
      comment: "Type of route (residential, commercial, recycling, etc.)"
    - name: "service_frequency"
      expr: service_frequency
      comment: "Service frequency (daily, weekly, bi-weekly)"
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions during route execution"
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Whether a safety incident occurred during execution"
    - name: "customer_complaint_flag"
      expr: customer_complaint_flag
      comment: "Whether customer complaints were logged"
    - name: "overtime_flag"
      expr: overtime_flag
      comment: "Whether route required overtime"
  measures:
    - name: "total_routes_executed"
      expr: COUNT(1)
      comment: "Total number of route executions"
    - name: "total_tonnage_collected"
      expr: SUM(CAST(total_tonnage_collected AS DOUBLE))
      comment: "Total tonnage collected across all routes"
    - name: "avg_tonnage_per_route"
      expr: AVG(CAST(total_tonnage_collected AS DOUBLE))
      comment: "Average tonnage collected per route execution"
    - name: "total_volume_collected_cubic_yards"
      expr: SUM(CAST(total_volume_collected_cubic_yards AS DOUBLE))
      comment: "Total volume collected in cubic yards"
    - name: "route_completion_rate"
      expr: ROUND(100.0 * SUM(CAST(total_stops_completed AS DOUBLE)) / NULLIF(SUM(CAST(total_stops_planned AS DOUBLE)), 0), 2)
      comment: "Percentage of planned stops successfully completed"
    - name: "total_fuel_consumed_gallons"
      expr: SUM(CAST(fuel_consumed_gallons AS DOUBLE))
      comment: "Total fuel consumed across all routes"
    - name: "avg_fuel_per_route"
      expr: AVG(CAST(fuel_consumed_gallons AS DOUBLE))
      comment: "Average fuel consumption per route"
    - name: "fuel_efficiency_tons_per_gallon"
      expr: ROUND(SUM(CAST(total_tonnage_collected AS DOUBLE)) / NULLIF(SUM(CAST(fuel_consumed_gallons AS DOUBLE)), 0), 3)
      comment: "Tons collected per gallon of fuel consumed - key efficiency metric"
    - name: "total_distance_traveled_miles"
      expr: SUM(CAST(distance_traveled_miles AS DOUBLE))
      comment: "Total miles traveled across all routes"
    - name: "avg_distance_per_route"
      expr: AVG(CAST(distance_traveled_miles AS DOUBLE))
      comment: "Average distance traveled per route"
    - name: "total_stops_completed"
      expr: SUM(CAST(total_stops_completed AS DOUBLE))
      comment: "Total number of stops successfully completed"
    - name: "total_stops_missed"
      expr: SUM(CAST(total_stops_missed AS DOUBLE))
      comment: "Total number of stops missed"
    - name: "avg_stops_per_route"
      expr: AVG(CAST(total_stops_completed AS DOUBLE))
      comment: "Average stops completed per route"
    - name: "safety_incident_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of routes with safety incidents"
    - name: "customer_complaint_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN customer_complaint_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of routes with customer complaints"
    - name: "overtime_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN overtime_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of routes requiring overtime"
    - name: "avg_route_duration_minutes"
      expr: AVG(CAST(route_duration_minutes AS DOUBLE))
      comment: "Average duration of route execution in minutes"
    - name: "total_dumps"
      expr: SUM(CAST(number_of_dumps AS DOUBLE))
      comment: "Total number of dump events across all routes"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`collection_transfer_station`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transfer station capacity, utilization, and operational status metrics. Tracks permitted vs operational capacity, compliance status, and facility readiness."
  source: "`waste_management_ecm`.`collection`.`transfer_station`"
  dimensions:
    - name: "station_code"
      expr: station_code
      comment: "Unique station identifier"
    - name: "station_name"
      expr: station_name
      comment: "Transfer station name"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status (active, inactive, maintenance)"
    - name: "facility_type"
      expr: facility_type
      comment: "Type of transfer facility"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (owned, leased, contracted)"
    - name: "state_province"
      expr: state_province
      comment: "State or province location"
    - name: "city"
      expr: city
      comment: "City location"
    - name: "accepts_hazardous_waste"
      expr: accepts_hazardous_waste
      comment: "Whether station accepts hazardous waste"
    - name: "accepts_recyclables"
      expr: accepts_recyclables
      comment: "Whether station accepts recyclables"
    - name: "permit_status"
      expr: CASE WHEN permit_expiration_date < CURRENT_DATE THEN 'Expired' WHEN permit_expiration_date < DATE_ADD(CURRENT_DATE, 90) THEN 'Expiring Soon' ELSE 'Active' END
      comment: "Permit status based on expiration date"
  measures:
    - name: "total_stations"
      expr: COUNT(1)
      comment: "Total number of transfer stations"
    - name: "total_permitted_capacity_tpd"
      expr: SUM(CAST(permitted_capacity_tpd AS DOUBLE))
      comment: "Total permitted capacity in tons per day across all stations"
    - name: "total_operational_capacity_tpd"
      expr: SUM(CAST(operational_capacity_tpd AS DOUBLE))
      comment: "Total operational capacity in tons per day"
    - name: "avg_permitted_capacity_tpd"
      expr: AVG(CAST(permitted_capacity_tpd AS DOUBLE))
      comment: "Average permitted capacity per station"
    - name: "avg_operational_capacity_tpd"
      expr: AVG(CAST(operational_capacity_tpd AS DOUBLE))
      comment: "Average operational capacity per station"
    - name: "capacity_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(operational_capacity_tpd AS DOUBLE)) / NULLIF(SUM(CAST(permitted_capacity_tpd AS DOUBLE)), 0), 2)
      comment: "Percentage of permitted capacity currently operational - key capacity planning metric"
    - name: "total_tipping_floor_area_sqft"
      expr: SUM(CAST(tipping_floor_area_sqft AS DOUBLE))
      comment: "Total tipping floor area across all stations"
    - name: "avg_tipping_floor_area_sqft"
      expr: AVG(CAST(tipping_floor_area_sqft AS DOUBLE))
      comment: "Average tipping floor area per station"
    - name: "stations_with_expired_permits"
      expr: COUNT(CASE WHEN permit_expiration_date < CURRENT_DATE THEN 1 END)
      comment: "Number of stations with expired permits - compliance risk indicator"
    - name: "permit_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN permit_expiration_date >= CURRENT_DATE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stations with valid permits"
    - name: "stations_accepting_hazmat"
      expr: COUNT(CASE WHEN accepts_hazardous_waste = TRUE THEN 1 END)
      comment: "Number of stations authorized for hazardous waste"
    - name: "stations_accepting_recyclables"
      expr: COUNT(CASE WHEN accepts_recyclables = TRUE THEN 1 END)
      comment: "Number of stations accepting recyclables"
    - name: "avg_latitude"
      expr: AVG(CAST(latitude AS DOUBLE))
      comment: "Average latitude for geographic center calculation"
    - name: "avg_longitude"
      expr: AVG(CAST(longitude AS DOUBLE))
      comment: "Average longitude for geographic center calculation"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`collection_facility_capacity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Daily facility capacity utilization, throughput, and diversion performance. Tracks actual vs permitted tonnage, exceedances, and material flow by type."
  source: "`waste_management_ecm`.`collection`.`facility_capacity`"
  dimensions:
    - name: "record_date"
      expr: record_date
      comment: "Date of capacity record"
    - name: "record_month"
      expr: DATE_TRUNC('MONTH', record_date)
      comment: "Month of capacity record"
    - name: "record_period"
      expr: record_period
      comment: "Reporting period (daily, weekly, monthly)"
    - name: "capacity_status"
      expr: capacity_status
      comment: "Capacity status (normal, near-capacity, at-capacity, over-capacity)"
    - name: "record_status"
      expr: record_status
      comment: "Record validation status"
    - name: "permit_exceedance_flag"
      expr: permit_exceedance_flag
      comment: "Whether permitted capacity was exceeded"
  measures:
    - name: "total_capacity_records"
      expr: COUNT(1)
      comment: "Total number of capacity records"
    - name: "total_inbound_tonnage"
      expr: SUM(CAST(actual_inbound_tonnage AS DOUBLE))
      comment: "Total tonnage received at facilities"
    - name: "total_outbound_tonnage"
      expr: SUM(CAST(actual_outbound_tonnage AS DOUBLE))
      comment: "Total tonnage shipped from facilities"
    - name: "avg_daily_tonnage"
      expr: AVG(CAST(average_daily_tonnage AS DOUBLE))
      comment: "Average daily tonnage processed"
    - name: "total_permitted_capacity_tpd"
      expr: SUM(CAST(permitted_daily_capacity_tpd AS DOUBLE))
      comment: "Total permitted daily capacity"
    - name: "avg_capacity_utilization_pct"
      expr: AVG(CAST(capacity_utilization_percentage AS DOUBLE))
      comment: "Average capacity utilization percentage"
    - name: "capacity_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_inbound_tonnage AS DOUBLE)) / NULLIF(SUM(CAST(permitted_daily_capacity_tpd AS DOUBLE)), 0), 2)
      comment: "Overall capacity utilization rate - key operational efficiency metric"
    - name: "total_inbound_msw_tonnage"
      expr: SUM(CAST(inbound_msw_tonnage AS DOUBLE))
      comment: "Total municipal solid waste tonnage received"
    - name: "total_inbound_recyclable_tonnage"
      expr: SUM(CAST(inbound_recyclable_tonnage AS DOUBLE))
      comment: "Total recyclable material tonnage received"
    - name: "total_inbound_organics_tonnage"
      expr: SUM(CAST(inbound_organics_tonnage AS DOUBLE))
      comment: "Total organics tonnage received"
    - name: "total_inbound_cd_tonnage"
      expr: SUM(CAST(inbound_cd_tonnage AS DOUBLE))
      comment: "Total construction and demolition debris tonnage"
    - name: "avg_diversion_rate_pct"
      expr: AVG(CAST(diversion_rate_percentage AS DOUBLE))
      comment: "Average waste diversion rate percentage"
    - name: "overall_diversion_rate"
      expr: ROUND(100.0 * (SUM(CAST(inbound_recyclable_tonnage AS DOUBLE)) + SUM(CAST(inbound_organics_tonnage AS DOUBLE))) / NULLIF(SUM(CAST(actual_inbound_tonnage AS DOUBLE)), 0), 2)
      comment: "Overall diversion rate from landfill - key sustainability metric"
    - name: "total_outbound_landfill_tonnage"
      expr: SUM(CAST(outbound_landfill_tonnage AS DOUBLE))
      comment: "Total tonnage sent to landfill"
    - name: "total_outbound_mrf_tonnage"
      expr: SUM(CAST(outbound_mrf_tonnage AS DOUBLE))
      comment: "Total tonnage sent to material recovery facilities"
    - name: "total_outbound_wte_tonnage"
      expr: SUM(CAST(outbound_wte_tonnage AS DOUBLE))
      comment: "Total tonnage sent to waste-to-energy facilities"
    - name: "total_floor_storage_tonnage"
      expr: SUM(CAST(floor_storage_tonnage AS DOUBLE))
      comment: "Total tonnage in floor storage"
    - name: "total_inbound_loads"
      expr: SUM(CAST(inbound_load_count AS DOUBLE))
      comment: "Total number of inbound loads"
    - name: "total_outbound_hauls"
      expr: SUM(CAST(outbound_haul_count AS DOUBLE))
      comment: "Total number of outbound hauls"
    - name: "avg_peak_hour_throughput_tons"
      expr: AVG(CAST(peak_hour_throughput_tons AS DOUBLE))
      comment: "Average peak hour throughput"
    - name: "permit_exceedance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN permit_exceedance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of days with permit exceedances - compliance risk metric"
    - name: "total_exceedance_tonnage"
      expr: SUM(CAST(exceedance_tonnage AS DOUBLE))
      comment: "Total tonnage exceeding permitted capacity"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`collection_load_ticket`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Load ticket revenue, tonnage, and acceptance metrics. Tracks tipping fees, contamination, rejections, and waste characterization."
  source: "`waste_management_ecm`.`collection`.`load_ticket`"
  dimensions:
    - name: "weigh_in_date"
      expr: DATE(weigh_in_timestamp)
      comment: "Date of weigh-in for daily analysis"
    - name: "weigh_in_month"
      expr: DATE_TRUNC('MONTH', weigh_in_timestamp)
      comment: "Month of weigh-in"
    - name: "ticket_status"
      expr: ticket_status
      comment: "Status of load ticket (accepted, rejected, pending)"
    - name: "acceptance_decision"
      expr: acceptance_decision
      comment: "Final acceptance decision"
    - name: "hauler_type"
      expr: hauler_type
      comment: "Type of hauler (internal, third-party, municipal)"
    - name: "contamination_level"
      expr: contamination_level
      comment: "Level of contamination detected"
    - name: "contamination_type"
      expr: contamination_type
      comment: "Type of contamination found"
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Reason code for load rejection"
    - name: "waste_origin_jurisdiction"
      expr: waste_origin_jurisdiction
      comment: "Jurisdiction where waste originated"
    - name: "billable_flag"
      expr: billable_flag
      comment: "Whether load is billable"
  measures:
    - name: "total_load_tickets"
      expr: COUNT(1)
      comment: "Total number of load tickets processed"
    - name: "total_net_weight_tons"
      expr: SUM(CAST(net_weight_tons AS DOUBLE))
      comment: "Total net weight in tons across all loads"
    - name: "avg_net_weight_tons"
      expr: AVG(CAST(net_weight_tons AS DOUBLE))
      comment: "Average net weight per load"
    - name: "total_gross_weight_tons"
      expr: SUM(CAST(gross_weight_tons AS DOUBLE))
      comment: "Total gross weight in tons"
    - name: "total_tare_weight_tons"
      expr: SUM(CAST(tare_weight_tons AS DOUBLE))
      comment: "Total tare weight in tons"
    - name: "total_tipping_fee_revenue"
      expr: SUM(CAST(tipping_fee_amount AS DOUBLE))
      comment: "Total tipping fee revenue - key financial metric"
    - name: "total_environmental_fee_revenue"
      expr: SUM(CAST(environmental_fee_amount AS DOUBLE))
      comment: "Total environmental fee revenue"
    - name: "total_charge_amount"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total charges across all loads"
    - name: "avg_tipping_fee_rate"
      expr: AVG(CAST(tipping_fee_rate AS DOUBLE))
      comment: "Average tipping fee rate per ton"
    - name: "effective_tipping_fee_rate"
      expr: ROUND(SUM(CAST(tipping_fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_weight_tons AS DOUBLE)), 0), 2)
      comment: "Effective tipping fee per ton - key pricing metric"
    - name: "load_acceptance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN acceptance_decision = 'Accepted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of loads accepted - quality control metric"
    - name: "load_rejection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN acceptance_decision = 'Rejected' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of loads rejected"
    - name: "contamination_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN contamination_level IS NOT NULL AND contamination_level != 'None' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of loads with contamination detected"
    - name: "billable_loads"
      expr: COUNT(CASE WHEN billable_flag = TRUE THEN 1 END)
      comment: "Number of billable loads"
    - name: "billable_tonnage"
      expr: SUM(CASE WHEN billable_flag = TRUE THEN CAST(net_weight_tons AS DOUBLE) ELSE 0 END)
      comment: "Total tonnage from billable loads"
    - name: "billable_revenue"
      expr: SUM(CASE WHEN billable_flag = TRUE THEN CAST(total_charge_amount AS DOUBLE) ELSE 0 END)
      comment: "Total revenue from billable loads"
    - name: "revenue_per_ton"
      expr: ROUND(SUM(CAST(total_charge_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_weight_tons AS DOUBLE)), 0), 2)
      comment: "Average revenue per ton - key profitability metric"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`collection_outbound_haul`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound haul logistics, cost, and efficiency metrics. Tracks haul tonnage, tipping fees, fuel consumption, and on-time delivery performance."
  source: "`waste_management_ecm`.`collection`.`outbound_haul`"
  dimensions:
    - name: "departure_date"
      expr: DATE(actual_departure_timestamp)
      comment: "Date of haul departure"
    - name: "departure_month"
      expr: DATE_TRUNC('MONTH', actual_departure_timestamp)
      comment: "Month of haul departure"
    - name: "haul_status"
      expr: haul_status
      comment: "Status of haul (completed, in-transit, cancelled)"
    - name: "destination_facility_type"
      expr: destination_facility_type
      comment: "Type of destination facility (landfill, WTE, MRF)"
    - name: "waste_stream_type"
      expr: waste_stream_type
      comment: "Type of waste stream hauled"
    - name: "contamination_flag"
      expr: contamination_flag
      comment: "Whether contamination was detected"
    - name: "load_rejection_flag"
      expr: load_rejection_flag
      comment: "Whether load was rejected at destination"
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Whether safety incident occurred during haul"
    - name: "rcra_classification"
      expr: rcra_classification
      comment: "RCRA classification of waste"
  measures:
    - name: "total_outbound_hauls"
      expr: COUNT(1)
      comment: "Total number of outbound hauls"
    - name: "total_actual_tonnage"
      expr: SUM(CAST(actual_tonnage AS DOUBLE))
      comment: "Total tonnage hauled to disposal/processing"
    - name: "avg_tonnage_per_haul"
      expr: AVG(CAST(actual_tonnage AS DOUBLE))
      comment: "Average tonnage per haul"
    - name: "total_estimated_tonnage"
      expr: SUM(CAST(estimated_tonnage AS DOUBLE))
      comment: "Total estimated tonnage"
    - name: "tonnage_variance_rate"
      expr: ROUND(100.0 * (SUM(CAST(actual_tonnage AS DOUBLE)) - SUM(CAST(estimated_tonnage AS DOUBLE))) / NULLIF(SUM(CAST(estimated_tonnage AS DOUBLE)), 0), 2)
      comment: "Percentage variance between actual and estimated tonnage - forecasting accuracy metric"
    - name: "total_tipping_fee_cost"
      expr: SUM(CAST(tipping_fee_amount AS DOUBLE))
      comment: "Total tipping fee costs paid - key disposal cost metric"
    - name: "total_environmental_fee_cost"
      expr: SUM(CAST(environmental_fee_amount AS DOUBLE))
      comment: "Total environmental fee costs"
    - name: "avg_tipping_fee_rate"
      expr: AVG(CAST(tipping_fee_rate AS DOUBLE))
      comment: "Average tipping fee rate per ton"
    - name: "effective_tipping_fee_rate"
      expr: ROUND(SUM(CAST(tipping_fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(actual_tonnage AS DOUBLE)), 0), 2)
      comment: "Effective tipping fee per ton paid - cost efficiency metric"
    - name: "total_route_distance_miles"
      expr: SUM(CAST(route_distance_miles AS DOUBLE))
      comment: "Total miles traveled for outbound hauls"
    - name: "avg_route_distance_miles"
      expr: AVG(CAST(route_distance_miles AS DOUBLE))
      comment: "Average haul distance"
    - name: "total_estimated_fuel_gallons"
      expr: SUM(CAST(estimated_fuel_consumption_gallons AS DOUBLE))
      comment: "Total estimated fuel consumption"
    - name: "fuel_efficiency_tons_per_gallon"
      expr: ROUND(SUM(CAST(actual_tonnage AS DOUBLE)) / NULLIF(SUM(CAST(estimated_fuel_consumption_gallons AS DOUBLE)), 0), 3)
      comment: "Tons hauled per gallon of fuel - haul efficiency metric"
    - name: "load_rejection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN load_rejection_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of loads rejected at destination - quality metric"
    - name: "contamination_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN contamination_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of hauls with contamination"
    - name: "safety_incident_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of hauls with safety incidents"
    - name: "on_time_arrival_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_arrival_timestamp <= estimated_arrival_timestamp THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_arrival_timestamp IS NOT NULL AND estimated_arrival_timestamp IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of hauls arriving on time - logistics performance metric"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`collection_service_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service exception tracking and resolution performance. Monitors exception types, root causes, resolution times, and SLA compliance."
  source: "`waste_management_ecm`.`collection`.`service_exception`"
  dimensions:
    - name: "exception_date"
      expr: DATE(exception_timestamp)
      comment: "Date exception occurred"
    - name: "exception_month"
      expr: DATE_TRUNC('MONTH', exception_timestamp)
      comment: "Month of exception"
    - name: "exception_type_code"
      expr: exception_type_code
      comment: "Type of service exception"
    - name: "exception_status"
      expr: exception_status
      comment: "Current status of exception (open, resolved, escalated)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of exception"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category"
    - name: "contamination_type"
      expr: contamination_type
      comment: "Type of contamination if applicable"
    - name: "contamination_severity"
      expr: contamination_severity
      comment: "Severity of contamination"
    - name: "preventable_flag"
      expr: preventable_flag
      comment: "Whether exception was preventable"
    - name: "repeat_exception_flag"
      expr: repeat_exception_flag
      comment: "Whether this is a repeat exception"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether SLA was breached"
    - name: "customer_notified_flag"
      expr: customer_notified_flag
      comment: "Whether customer was notified"
    - name: "credit_issued_flag"
      expr: credit_issued_flag
      comment: "Whether credit was issued"
  measures:
    - name: "total_exceptions"
      expr: COUNT(1)
      comment: "Total number of service exceptions"
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of exceptions breaching SLA - service quality metric"
    - name: "preventable_exception_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN preventable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of preventable exceptions - process improvement opportunity metric"
    - name: "repeat_exception_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN repeat_exception_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of repeat exceptions - service reliability metric"
    - name: "customer_notification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN customer_notified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of exceptions where customer was notified"
    - name: "credit_issuance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN credit_issued_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of exceptions resulting in customer credit"
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount issued - financial impact of exceptions"
    - name: "avg_credit_amount"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average credit amount per exception"
    - name: "resolution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_status = 'Resolved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of exceptions resolved"
    - name: "open_exceptions"
      expr: COUNT(CASE WHEN exception_status = 'Open' THEN 1 END)
      comment: "Number of currently open exceptions"
    - name: "escalated_exceptions"
      expr: COUNT(CASE WHEN exception_status = 'Escalated' THEN 1 END)
      comment: "Number of escalated exceptions"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`collection_rolloff_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rolloff container order revenue, utilization, and service performance. Tracks rental charges, disposal fees, weight limits, and order cycle times."
  source: "`waste_management_ecm`.`collection`.`rolloff_order`"
  dimensions:
    - name: "order_placed_date"
      expr: DATE(order_placed_timestamp)
      comment: "Date order was placed"
    - name: "order_placed_month"
      expr: DATE_TRUNC('MONTH', order_placed_timestamp)
      comment: "Month order was placed"
    - name: "order_status"
      expr: order_status
      comment: "Current status of rolloff order"
    - name: "container_size_yards"
      expr: container_size_yards
      comment: "Container size in cubic yards"
    - name: "permit_required_flag"
      expr: permit_required_flag
      comment: "Whether permit is required"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for order cancellation if applicable"
  measures:
    - name: "total_rolloff_orders"
      expr: COUNT(1)
      comment: "Total number of rolloff orders"
    - name: "total_rental_revenue"
      expr: SUM(CAST(base_rental_charge AS DOUBLE))
      comment: "Total rental charge revenue"
    - name: "total_disposal_revenue"
      expr: SUM(CAST(disposal_charge AS DOUBLE))
      comment: "Total disposal charge revenue"
    - name: "total_environmental_fee_revenue"
      expr: SUM(CAST(environmental_fee AS DOUBLE))
      comment: "Total environmental fee revenue"
    - name: "total_overage_revenue"
      expr: SUM(CAST(overage_charge_amount AS DOUBLE))
      comment: "Total overage charge revenue"
    - name: "total_order_revenue"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total revenue from all rolloff orders - key revenue metric"
    - name: "avg_order_revenue"
      expr: AVG(CAST(total_charge_amount AS DOUBLE))
      comment: "Average revenue per rolloff order"
    - name: "total_actual_weight_tons"
      expr: SUM(CAST(actual_weight_tons AS DOUBLE))
      comment: "Total weight hauled in tons"
    - name: "avg_weight_per_order_tons"
      expr: AVG(CAST(actual_weight_tons AS DOUBLE))
      comment: "Average weight per order"
    - name: "total_overage_weight_tons"
      expr: SUM(CAST(overage_weight_tons AS DOUBLE))
      comment: "Total overage weight exceeding limits"
    - name: "overage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN overage_weight_tons > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders with weight overages - pricing accuracy metric"
    - name: "avg_rental_duration_days"
      expr: AVG(CAST(rental_duration_days AS DOUBLE))
      comment: "Average rental duration in days"
    - name: "total_swap_count"
      expr: SUM(CAST(swap_count AS DOUBLE))
      comment: "Total number of container swaps"
    - name: "avg_swaps_per_order"
      expr: AVG(CAST(swap_count AS DOUBLE))
      comment: "Average swaps per order"
    - name: "revenue_per_ton"
      expr: ROUND(SUM(CAST(total_charge_amount AS DOUBLE)) / NULLIF(SUM(CAST(actual_weight_tons AS DOUBLE)), 0), 2)
      comment: "Average revenue per ton - profitability metric"
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN order_status = 'Cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders cancelled"
    - name: "completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN order_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders completed successfully"
$$;