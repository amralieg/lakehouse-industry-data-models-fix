-- Metric views for domain: fleet | Business: Waste Management | Version: 1 | Generated on: 2026-05-07 19:57:14

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`fleet_vehicle_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fleet vehicle utilization and efficiency KPIs measuring operational performance, fuel efficiency, and asset productivity"
  source: "`waste_management_ecm`.`fleet`.`vehicle_utilization`"
  dimensions:
    - name: "utilization_date"
      expr: utilization_date
      comment: "Date of vehicle utilization record"
    - name: "utilization_month"
      expr: DATE_TRUNC('MONTH', utilization_date)
      comment: "Month of vehicle utilization for trend analysis"
    - name: "vehicle_type"
      expr: vehicle_type
      comment: "Type of vehicle (e.g., front-loader, rear-loader, roll-off)"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type used by vehicle (diesel, CNG, electric, hybrid)"
    - name: "route_completion_status"
      expr: route_completion_status
      comment: "Status of route completion (completed, partial, cancelled)"
    - name: "dot_compliance_status"
      expr: dot_compliance_status
      comment: "DOT compliance status for the utilization period"
    - name: "maintenance_flag"
      expr: maintenance_flag
      comment: "Whether vehicle required maintenance during period"
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Whether a safety incident occurred during utilization"
  measures:
    - name: "total_vehicles_utilized"
      expr: COUNT(DISTINCT vehicle_id)
      comment: "Distinct count of vehicles utilized in the period"
    - name: "total_miles_driven"
      expr: SUM(CAST(total_miles_driven AS DOUBLE))
      comment: "Total miles driven across all vehicles"
    - name: "total_revenue_miles"
      expr: SUM(CAST(revenue_miles AS DOUBLE))
      comment: "Total revenue-generating miles (excludes deadhead)"
    - name: "total_deadhead_miles"
      expr: SUM(CAST(deadhead_miles AS DOUBLE))
      comment: "Total non-revenue deadhead miles"
    - name: "avg_utilization_rate"
      expr: AVG(CAST(utilization_rate_percent AS DOUBLE))
      comment: "Average vehicle utilization rate as percentage of available hours"
    - name: "total_fuel_consumed_gallons"
      expr: SUM(CAST(fuel_consumed_gallons AS DOUBLE))
      comment: "Total fuel consumed in gallons across all vehicles"
    - name: "avg_fuel_efficiency_mpg"
      expr: AVG(CAST(fuel_efficiency_mpg AS DOUBLE))
      comment: "Average fuel efficiency in miles per gallon"
    - name: "total_payload_tons"
      expr: SUM(CAST(payload_tons_collected AS DOUBLE))
      comment: "Total tons of waste collected across all vehicles"
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total idle hours across all vehicles"
    - name: "total_driving_hours"
      expr: SUM(CAST(driving_hours AS DOUBLE))
      comment: "Total driving hours across all vehicles"
    - name: "total_pto_hours"
      expr: SUM(CAST(pto_hours AS DOUBLE))
      comment: "Total power take-off hours for compaction and lifting operations"
    - name: "avg_payload_per_vehicle"
      expr: AVG(CAST(payload_tons_collected AS DOUBLE))
      comment: "Average tons collected per vehicle utilization record"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`fleet_fuel_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fuel consumption and cost KPIs for fleet fuel management and carbon footprint analysis"
  source: "`waste_management_ecm`.`fleet`.`fuel_transaction`"
  dimensions:
    - name: "transaction_date"
      expr: DATE(transaction_timestamp)
      comment: "Date of fuel transaction"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of fuel transaction for trend analysis"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Type of fuel purchased (diesel, CNG, gasoline, DEF)"
    - name: "fuel_grade"
      expr: fuel_grade
      comment: "Grade of fuel purchased"
    - name: "station_type"
      expr: station_type
      comment: "Type of fueling station (company-owned, retail, cardlock)"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of fuel transaction (approved, pending, rejected)"
    - name: "is_emergency_fuel"
      expr: is_emergency_fuel
      comment: "Whether this was an emergency fuel purchase"
    - name: "ifta_jurisdiction"
      expr: ifta_jurisdiction
      comment: "IFTA jurisdiction for fuel tax reporting"
    - name: "cost_center"
      expr: cost_center
      comment: "Cost center charged for fuel transaction"
  measures:
    - name: "total_fuel_transactions"
      expr: COUNT(1)
      comment: "Total number of fuel transactions"
    - name: "total_vehicles_fueled"
      expr: COUNT(DISTINCT vehicle_id)
      comment: "Distinct count of vehicles that received fuel"
    - name: "total_fuel_gallons"
      expr: SUM(CAST(quantity_dispensed AS DOUBLE))
      comment: "Total gallons of fuel dispensed"
    - name: "total_fuel_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of fuel purchased including taxes"
    - name: "total_pre_tax_amount"
      expr: SUM(CAST(pre_tax_amount AS DOUBLE))
      comment: "Total pre-tax fuel cost"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total fuel tax paid"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average cost per gallon of fuel"
    - name: "total_def_gallons"
      expr: SUM(CAST(def_quantity_dispensed AS DOUBLE))
      comment: "Total gallons of diesel exhaust fluid dispensed"
    - name: "avg_transaction_size_gallons"
      expr: AVG(CAST(quantity_dispensed AS DOUBLE))
      comment: "Average gallons per fuel transaction"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`fleet_accident_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fleet safety and accident KPIs measuring incident frequency, severity, and preventability for risk management"
  source: "`waste_management_ecm`.`fleet`.`accident_report`"
  dimensions:
    - name: "incident_date"
      expr: incident_date
      comment: "Date of accident incident"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of incident for trend analysis"
    - name: "incident_type"
      expr: incident_type
      comment: "Type of incident (collision, rollover, backing, pedestrian, etc.)"
    - name: "incident_severity"
      expr: incident_severity
      comment: "Severity classification of incident (minor, moderate, severe, fatal)"
    - name: "preventable_flag"
      expr: preventable_flag
      comment: "Whether the accident was preventable by the driver"
    - name: "driver_at_fault_flag"
      expr: driver_at_fault_flag
      comment: "Whether the driver was determined at fault"
    - name: "dot_reportable_flag"
      expr: dot_reportable_flag
      comment: "Whether incident is reportable to DOT"
    - name: "csa_reportable_flag"
      expr: csa_reportable_flag
      comment: "Whether incident is reportable under CSA program"
    - name: "citation_issued_flag"
      expr: citation_issued_flag
      comment: "Whether a citation was issued"
    - name: "weather_conditions"
      expr: weather_conditions
      comment: "Weather conditions at time of incident"
    - name: "road_conditions"
      expr: road_conditions
      comment: "Road conditions at time of incident"
    - name: "light_conditions"
      expr: light_conditions
      comment: "Light conditions at time of incident"
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of accident investigation"
  measures:
    - name: "total_accidents"
      expr: COUNT(1)
      comment: "Total number of accident reports"
    - name: "total_vehicles_in_accidents"
      expr: COUNT(DISTINCT vehicle_id)
      comment: "Distinct count of vehicles involved in accidents"
    - name: "total_drivers_in_accidents"
      expr: COUNT(DISTINCT driver_id)
      comment: "Distinct count of drivers involved in accidents"
    - name: "total_preventable_accidents"
      expr: SUM(CASE WHEN preventable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of preventable accidents"
    - name: "total_dot_reportable_accidents"
      expr: SUM(CASE WHEN dot_reportable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of DOT-reportable accidents"
    - name: "total_property_damage_amount"
      expr: SUM(CAST(estimated_property_damage_amount AS DOUBLE))
      comment: "Total estimated property damage across all accidents"
    - name: "avg_property_damage_per_accident"
      expr: AVG(CAST(estimated_property_damage_amount AS DOUBLE))
      comment: "Average property damage per accident"
    - name: "total_at_fault_accidents"
      expr: SUM(CASE WHEN driver_at_fault_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accidents where driver was at fault"
    - name: "total_citations_issued"
      expr: SUM(CASE WHEN citation_issued_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accidents resulting in citations"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`fleet_maintenance_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fleet maintenance compliance and cost KPIs measuring preventive maintenance adherence and downtime"
  source: "`waste_management_ecm`.`fleet`.`maintenance_schedule`"
  dimensions:
    - name: "scheduled_date"
      expr: scheduled_date
      comment: "Scheduled date for maintenance"
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month of scheduled maintenance"
    - name: "actual_completion_date"
      expr: actual_completion_date
      comment: "Actual date maintenance was completed"
    - name: "pm_type"
      expr: pm_type
      comment: "Type of preventive maintenance (A-service, B-service, annual inspection, etc.)"
    - name: "schedule_status"
      expr: schedule_status
      comment: "Status of maintenance schedule (scheduled, completed, overdue, cancelled)"
    - name: "trigger_type"
      expr: trigger_type
      comment: "What triggered the maintenance (calendar, mileage, engine hours)"
    - name: "priority"
      expr: priority
      comment: "Priority level of maintenance"
    - name: "dot_inspection_flag"
      expr: dot_inspection_flag
      comment: "Whether this is a DOT-required inspection"
    - name: "fmcsa_required_flag"
      expr: fmcsa_required_flag
      comment: "Whether this maintenance is FMCSA-required"
    - name: "defects_found_flag"
      expr: defects_found_flag
      comment: "Whether defects were found during maintenance"
    - name: "out_of_service_flag"
      expr: out_of_service_flag
      comment: "Whether vehicle was placed out of service"
  measures:
    - name: "total_maintenance_schedules"
      expr: COUNT(1)
      comment: "Total number of maintenance schedules"
    - name: "total_vehicles_scheduled"
      expr: COUNT(DISTINCT vehicle_id)
      comment: "Distinct count of vehicles with scheduled maintenance"
    - name: "total_completed_maintenance"
      expr: SUM(CASE WHEN schedule_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of completed maintenance schedules"
    - name: "total_estimated_labor_cost"
      expr: SUM(CAST(estimated_labor_cost AS DOUBLE))
      comment: "Total estimated labor cost for scheduled maintenance"
    - name: "total_estimated_parts_cost"
      expr: SUM(CAST(estimated_parts_cost AS DOUBLE))
      comment: "Total estimated parts cost for scheduled maintenance"
    - name: "avg_estimated_duration_hours"
      expr: AVG(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average estimated duration of maintenance in hours"
    - name: "avg_actual_duration_hours"
      expr: AVG(CAST(actual_duration_hours AS DOUBLE))
      comment: "Average actual duration of completed maintenance in hours"
    - name: "total_defects_found"
      expr: SUM(CASE WHEN defects_found_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of maintenance events where defects were found"
    - name: "total_out_of_service_events"
      expr: SUM(CASE WHEN out_of_service_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of maintenance events resulting in out-of-service status"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`fleet_driver_behavior_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Driver safety and behavior KPIs measuring telematics events, coaching needs, and driver performance"
  source: "`waste_management_ecm`.`fleet`.`driver_behavior_event`"
  dimensions:
    - name: "event_date"
      expr: DATE(event_timestamp)
      comment: "Date of driver behavior event"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of behavior event for trend analysis"
    - name: "event_type"
      expr: event_type
      comment: "Type of behavior event (speeding, harsh braking, harsh acceleration, idling, etc.)"
    - name: "event_severity"
      expr: event_severity
      comment: "Severity classification of event (low, medium, high, critical)"
    - name: "coaching_required_flag"
      expr: coaching_required_flag
      comment: "Whether coaching is required for this event"
    - name: "coaching_completed_flag"
      expr: coaching_completed_flag
      comment: "Whether coaching has been completed"
    - name: "dot_reportable_flag"
      expr: dot_reportable_flag
      comment: "Whether event is DOT-reportable"
    - name: "incident_flag"
      expr: incident_flag
      comment: "Whether event resulted in an incident"
    - name: "reviewed_by_supervisor_flag"
      expr: reviewed_by_supervisor_flag
      comment: "Whether event has been reviewed by supervisor"
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions during event"
    - name: "road_type"
      expr: road_type
      comment: "Type of road where event occurred"
  measures:
    - name: "total_behavior_events"
      expr: COUNT(1)
      comment: "Total number of driver behavior events"
    - name: "total_drivers_with_events"
      expr: COUNT(DISTINCT driver_id)
      comment: "Distinct count of drivers with behavior events"
    - name: "total_vehicles_with_events"
      expr: COUNT(DISTINCT vehicle_id)
      comment: "Distinct count of vehicles with behavior events"
    - name: "total_coaching_required"
      expr: SUM(CASE WHEN coaching_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of events requiring coaching"
    - name: "total_coaching_completed"
      expr: SUM(CASE WHEN coaching_completed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of events where coaching was completed"
    - name: "avg_driver_score_impact"
      expr: AVG(CAST(driver_score_impact AS DOUBLE))
      comment: "Average impact on driver safety score per event"
    - name: "avg_actual_speed_mph"
      expr: AVG(CAST(actual_speed_mph AS DOUBLE))
      comment: "Average actual speed during speeding events"
    - name: "avg_speed_over_limit_mph"
      expr: AVG(CAST(speed_over_limit_mph AS DOUBLE))
      comment: "Average speed over posted limit during speeding events"
    - name: "avg_event_duration_seconds"
      expr: AVG(CAST(event_duration_seconds AS DOUBLE))
      comment: "Average duration of behavior events in seconds"
    - name: "total_incidents"
      expr: SUM(CASE WHEN incident_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of behavior events that resulted in incidents"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`fleet_dot_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DOT inspection and compliance KPIs measuring violation rates, out-of-service events, and CSA score impact"
  source: "`waste_management_ecm`.`fleet`.`fleet_dot_inspection`"
  dimensions:
    - name: "inspection_date"
      expr: inspection_date
      comment: "Date of DOT inspection"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of inspection for trend analysis"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of DOT inspection (Level I, II, III, etc.)"
    - name: "inspection_category"
      expr: inspection_category
      comment: "Category of inspection"
    - name: "inspection_result"
      expr: inspection_result
      comment: "Result of inspection (pass, fail, conditional)"
    - name: "out_of_service_flag"
      expr: out_of_service_flag
      comment: "Whether vehicle or driver was placed out of service"
    - name: "vehicle_oos_flag"
      expr: vehicle_oos_flag
      comment: "Whether vehicle was placed out of service"
    - name: "driver_oos_flag"
      expr: driver_oos_flag
      comment: "Whether driver was placed out of service"
    - name: "basic_category"
      expr: basic_category
      comment: "CSA BASIC category of violations"
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether corrective action is required"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action"
    - name: "inspection_state"
      expr: inspection_state
      comment: "State where inspection occurred"
    - name: "inspector_agency"
      expr: inspector_agency
      comment: "Agency that conducted inspection"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of DOT inspections"
    - name: "total_vehicles_inspected"
      expr: COUNT(DISTINCT vehicle_id)
      comment: "Distinct count of vehicles inspected"
    - name: "total_drivers_inspected"
      expr: COUNT(DISTINCT driver_id)
      comment: "Distinct count of drivers inspected"
    - name: "total_out_of_service"
      expr: SUM(CASE WHEN out_of_service_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of inspections resulting in out-of-service"
    - name: "total_vehicle_oos"
      expr: SUM(CASE WHEN vehicle_oos_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of vehicle out-of-service placements"
    - name: "total_driver_oos"
      expr: SUM(CASE WHEN driver_oos_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of driver out-of-service placements"
    - name: "avg_csa_score_impact"
      expr: AVG(CAST(csa_score_impact AS DOUBLE))
      comment: "Average CSA score impact per inspection"
    - name: "total_csa_score_impact"
      expr: SUM(CAST(csa_score_impact AS DOUBLE))
      comment: "Total CSA score impact from all inspections"
    - name: "total_corrective_actions_required"
      expr: SUM(CASE WHEN corrective_action_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of inspections requiring corrective action"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`fleet_vehicle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fleet asset inventory and configuration KPIs measuring vehicle composition, age, and operational readiness"
  source: "`waste_management_ecm`.`fleet`.`vehicle`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of vehicle (active, inactive, maintenance, disposed)"
    - name: "vehicle_type"
      expr: body_type
      comment: "Body type of vehicle (front-loader, rear-loader, roll-off, etc.)"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type of vehicle (diesel, CNG, electric, hybrid)"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (owned, leased, rental)"
    - name: "make"
      expr: make
      comment: "Vehicle manufacturer make"
    - name: "model_year"
      expr: model_year
      comment: "Model year of vehicle"
    - name: "compaction_type"
      expr: compaction_type
      comment: "Type of compaction system"
    - name: "cdl_required_flag"
      expr: cdl_required_flag
      comment: "Whether CDL is required to operate vehicle"
    - name: "emissions_certification"
      expr: emissions_certification
      comment: "Emissions certification standard"
    - name: "home_yard_location"
      expr: home_yard_location
      comment: "Home yard location for vehicle"
  measures:
    - name: "total_vehicles"
      expr: COUNT(1)
      comment: "Total count of vehicles in fleet"
    - name: "total_active_vehicles"
      expr: SUM(CASE WHEN operational_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of vehicles in active operational status"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of fleet"
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per vehicle"
    - name: "total_body_capacity_cubic_yards"
      expr: SUM(CAST(body_capacity_cubic_yards AS DOUBLE))
      comment: "Total body capacity across fleet in cubic yards"
    - name: "avg_body_capacity_cubic_yards"
      expr: AVG(CAST(body_capacity_cubic_yards AS DOUBLE))
      comment: "Average body capacity per vehicle in cubic yards"
    - name: "total_fuel_tank_capacity_gallons"
      expr: SUM(CAST(fuel_tank_capacity_gallons AS DOUBLE))
      comment: "Total fuel tank capacity across fleet in gallons"
    - name: "avg_fuel_tank_capacity_gallons"
      expr: AVG(CAST(fuel_tank_capacity_gallons AS DOUBLE))
      comment: "Average fuel tank capacity per vehicle in gallons"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`fleet_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fleet cost allocation and financial KPIs measuring cost distribution, fuel consumption, and operational expenses by vehicle and service line"
  source: "`waste_management_ecm`.`fleet`.`cost_allocation`"
  dimensions:
    - name: "allocation_period_start_date"
      expr: allocation_period_start_date
      comment: "Start date of cost allocation period"
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', allocation_period_start_date)
      comment: "Month of cost allocation for trend analysis"
    - name: "cost_category"
      expr: cost_category
      comment: "Category of cost (fuel, maintenance, labor, overhead, etc.)"
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used for cost allocation (direct, mileage-based, hours-based, tonnage-based)"
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of cost allocation (draft, approved, posted, reversed)"
    - name: "service_line"
      expr: service_line
      comment: "Service line charged (residential, commercial, roll-off, recycling)"
    - name: "vehicle_type"
      expr: vehicle_type
      comment: "Type of vehicle for cost allocation"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type for fuel cost allocations"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code for allocation"
    - name: "district_code"
      expr: district_code
      comment: "District code for allocation"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of allocation"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of allocation"
  measures:
    - name: "total_cost_allocations"
      expr: COUNT(1)
      comment: "Total number of cost allocation records"
    - name: "total_vehicles_allocated"
      expr: COUNT(DISTINCT vehicle_id)
      comment: "Distinct count of vehicles with cost allocations"
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost amount allocated"
    - name: "avg_cost_amount"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost amount per allocation"
    - name: "total_fuel_consumed_gallons"
      expr: SUM(CAST(fuel_consumed_gallons AS DOUBLE))
      comment: "Total fuel consumed in gallons"
    - name: "total_mileage_driven"
      expr: SUM(CAST(mileage_driven AS DOUBLE))
      comment: "Total mileage driven for allocations"
    - name: "total_operating_hours"
      expr: SUM(CAST(operating_hours AS DOUBLE))
      comment: "Total operating hours for allocations"
    - name: "total_tonnage_hauled"
      expr: SUM(CAST(tonnage_hauled AS DOUBLE))
      comment: "Total tonnage hauled for allocations"
    - name: "avg_allocation_rate"
      expr: AVG(CAST(allocation_rate AS DOUBLE))
      comment: "Average allocation rate per unit"
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage"
$$;