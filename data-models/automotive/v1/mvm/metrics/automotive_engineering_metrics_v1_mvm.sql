-- Metric views for domain: engineering | Business: Automotive | Version: 1 | Generated on: 2026-05-07 02:15:05

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`engineering_vehicle_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic vehicle program performance metrics tracking budget utilization, target achievement, and program health across platforms and powertrains"
  source: "`automotive_ecm`.`engineering`.`vehicle_program`"
  dimensions:
    - name: "program_code"
      expr: program_code
      comment: "Unique identifier code for the vehicle program"
    - name: "program_name"
      expr: program_name
      comment: "Business name of the vehicle program"
    - name: "vehicle_program_status"
      expr: vehicle_program_status
      comment: "Current lifecycle status of the vehicle program"
    - name: "program_type"
      expr: program_type
      comment: "Classification of program type"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Type of powertrain (ICE, hybrid, electric, etc.)"
    - name: "platform_architecture"
      expr: platform_architecture
      comment: "Underlying platform architecture for the vehicle"
    - name: "segment"
      expr: segment
      comment: "Market segment classification"
    - name: "target_market"
      expr: target_market
      comment: "Geographic or demographic target market"
    - name: "vehicle_class"
      expr: vehicle_class
      comment: "Vehicle class categorization"
    - name: "model_year_start"
      expr: model_year_start
      comment: "Starting model year for the program"
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Status of regulatory approvals"
    - name: "launch_year"
      expr: YEAR(launch_date)
      comment: "Year of program launch"
    - name: "launch_quarter"
      expr: CONCAT('Q', QUARTER(launch_date), '-', YEAR(launch_date))
      comment: "Quarter and year of program launch"
  measures:
    - name: "total_program_count"
      expr: COUNT(1)
      comment: "Total number of vehicle programs"
    - name: "total_budget_allocation"
      expr: SUM(CAST(budget_allocation AS DOUBLE))
      comment: "Total budget allocated across programs in local currency"
    - name: "avg_budget_per_program"
      expr: AVG(CAST(budget_allocation AS DOUBLE))
      comment: "Average budget allocation per vehicle program"
    - name: "total_target_production_volume"
      expr: SUM(CAST(target_production_volume AS DOUBLE))
      comment: "Sum of target production volumes across programs"
    - name: "avg_target_cost_per_vehicle"
      expr: AVG(CAST(target_cost_per_vehicle AS DOUBLE))
      comment: "Average target cost per vehicle across programs"
    - name: "avg_target_emissions"
      expr: AVG(CAST(target_emissions_g_per_km AS DOUBLE))
      comment: "Average target emissions in grams per kilometer"
    - name: "avg_target_fuel_efficiency"
      expr: AVG(CAST(target_fuel_efficiency_mpg AS DOUBLE))
      comment: "Average target fuel efficiency in miles per gallon"
    - name: "avg_target_weight"
      expr: AVG(CAST(target_weight_kg AS DOUBLE))
      comment: "Average target vehicle weight in kilograms"
    - name: "digital_twin_enabled_count"
      expr: SUM(CASE WHEN digital_twin_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of programs with digital twin capability enabled"
    - name: "ota_capable_program_count"
      expr: SUM(CASE WHEN ota_update_capability = TRUE THEN 1 ELSE 0 END)
      comment: "Count of programs with over-the-air update capability"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`engineering_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering change order performance metrics tracking cost impact, cycle time, compliance, and change effectiveness"
  source: "`automotive_ecm`.`engineering`.`change`"
  dimensions:
    - name: "change_number"
      expr: change_number
      comment: "Unique engineering change order number"
    - name: "change_status"
      expr: change_status
      comment: "Current status of the change order"
    - name: "change_type"
      expr: change_type
      comment: "Classification of change type"
    - name: "priority"
      expr: priority
      comment: "Priority level of the change"
    - name: "risk_level"
      expr: risk_level
      comment: "Assessed risk level of the change"
    - name: "reason_category"
      expr: reason_category
      comment: "Category of reason for the change"
    - name: "change_scope"
      expr: change_scope
      comment: "Scope classification of the change"
    - name: "origin"
      expr: origin
      comment: "Origin or source of the change request"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the change is compliance-driven"
    - name: "request_year"
      expr: YEAR(request_timestamp)
      comment: "Year the change was requested"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month the change was requested"
    - name: "approval_year"
      expr: YEAR(approval_timestamp)
      comment: "Year the change was approved"
  measures:
    - name: "total_change_count"
      expr: COUNT(1)
      comment: "Total number of engineering change orders"
    - name: "total_cost_estimate_gross"
      expr: SUM(CAST(cost_estimate_gross AS DOUBLE))
      comment: "Total gross cost estimate across all changes"
    - name: "total_cost_net"
      expr: SUM(CAST(cost_net AS DOUBLE))
      comment: "Total net cost impact across all changes"
    - name: "total_cost_adjustments"
      expr: SUM(CAST(cost_adjustments AS DOUBLE))
      comment: "Total cost adjustments applied to changes"
    - name: "avg_cost_per_change"
      expr: AVG(CAST(cost_net AS DOUBLE))
      comment: "Average net cost per engineering change order"
    - name: "high_risk_change_count"
      expr: SUM(CASE WHEN risk_level = 'High' THEN 1 ELSE 0 END)
      comment: "Count of high-risk engineering changes"
    - name: "compliance_driven_change_count"
      expr: SUM(CASE WHEN compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of compliance-driven changes"
    - name: "approved_change_count"
      expr: SUM(CASE WHEN change_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Count of approved engineering changes"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`engineering_validation_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Validation test performance metrics tracking test outcomes, compliance, quality yield, and emissions/noise performance against targets"
  source: "`automotive_ecm`.`engineering`.`validation_test`"
  dimensions:
    - name: "test_name"
      expr: test_name
      comment: "Name of the validation test"
    - name: "test_status"
      expr: test_status
      comment: "Current status of the test"
    - name: "test_type"
      expr: test_type
      comment: "Type classification of the test"
    - name: "test_category"
      expr: test_category
      comment: "Category of the validation test"
    - name: "test_phase"
      expr: test_phase
      comment: "Development phase in which test is conducted"
    - name: "test_result"
      expr: test_result
      comment: "Outcome result of the test"
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the test"
    - name: "test_approval_status"
      expr: test_approval_status
      comment: "Approval status of the test"
    - name: "test_facility"
      expr: test_facility
      comment: "Facility where test was conducted"
    - name: "test_location"
      expr: test_location
      comment: "Geographic location of the test"
    - name: "compliance_standard"
      expr: compliance_standard
      comment: "Compliance standard being validated"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether test is for regulatory compliance"
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the test is critical to program success"
    - name: "test_year"
      expr: YEAR(test_timestamp)
      comment: "Year the test was conducted"
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', test_timestamp)
      comment: "Month the test was conducted"
  measures:
    - name: "total_test_count"
      expr: COUNT(1)
      comment: "Total number of validation tests conducted"
    - name: "passed_test_count"
      expr: SUM(CASE WHEN test_result = 'Pass' THEN 1 ELSE 0 END)
      comment: "Count of tests with passing results"
    - name: "failed_test_count"
      expr: SUM(CASE WHEN test_result = 'Fail' THEN 1 ELSE 0 END)
      comment: "Count of tests with failing results"
    - name: "critical_test_count"
      expr: SUM(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END)
      comment: "Count of critical validation tests"
    - name: "avg_emission_co2"
      expr: AVG(CAST(emission_co2_g_per_km AS DOUBLE))
      comment: "Average CO2 emissions measured in grams per kilometer"
    - name: "avg_target_emission_co2"
      expr: AVG(CAST(target_emission_co2 AS DOUBLE))
      comment: "Average target CO2 emissions in grams per kilometer"
    - name: "avg_noise_db"
      expr: AVG(CAST(noise_db AS DOUBLE))
      comment: "Average noise level measured in decibels"
    - name: "avg_target_noise_db"
      expr: AVG(CAST(target_noise_db AS DOUBLE))
      comment: "Average target noise level in decibels"
    - name: "avg_torque_nm"
      expr: AVG(CAST(torque_nm AS DOUBLE))
      comment: "Average torque measured in Newton-meters"
    - name: "avg_target_torque_nm"
      expr: AVG(CAST(target_torque_nm AS DOUBLE))
      comment: "Average target torque in Newton-meters"
    - name: "avg_variance_percent"
      expr: AVG(CAST(variance_percent AS DOUBLE))
      comment: "Average variance percentage from target specifications"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`engineering_part_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Part master performance metrics tracking part cost, lead time, quality, compliance, and lifecycle health across part families and suppliers"
  source: "`automotive_ecm`.`engineering`.`part_master`"
  dimensions:
    - name: "part_number"
      expr: part_number
      comment: "Unique part number identifier"
    - name: "part_type"
      expr: part_type
      comment: "Type classification of the part"
    - name: "part_family"
      expr: part_family
      comment: "Family grouping of the part"
    - name: "part_classification"
      expr: part_classification
      comment: "Classification category of the part"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the part"
    - name: "criticality"
      expr: criticality
      comment: "Criticality level of the part"
    - name: "quality_rating"
      expr: quality_rating
      comment: "Quality rating assigned to the part"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current inspection status"
    - name: "material"
      expr: material
      comment: "Material composition of the part"
    - name: "is_active"
      expr: is_active
      comment: "Whether the part is currently active"
    - name: "rohs_compliance"
      expr: rohs_compliance
      comment: "RoHS compliance status"
    - name: "reach_compliance"
      expr: reach_compliance
      comment: "REACH compliance status"
    - name: "obsolescence_notice"
      expr: obsolescence_notice
      comment: "Whether part has obsolescence notice"
  measures:
    - name: "total_part_count"
      expr: COUNT(1)
      comment: "Total number of parts in master catalog"
    - name: "active_part_count"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of active parts"
    - name: "total_part_cost_usd"
      expr: SUM(CAST(cost_usd AS DOUBLE))
      comment: "Total cost of parts in USD"
    - name: "avg_part_cost_usd"
      expr: AVG(CAST(cost_usd AS DOUBLE))
      comment: "Average cost per part in USD"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days across parts"
    - name: "avg_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average part weight in kilograms"
    - name: "avg_volume_cm3"
      expr: AVG(CAST(volume_cm3 AS DOUBLE))
      comment: "Average part volume in cubic centimeters"
    - name: "critical_part_count"
      expr: SUM(CASE WHEN criticality = 'Critical' THEN 1 ELSE 0 END)
      comment: "Count of critical parts"
    - name: "rohs_compliant_count"
      expr: SUM(CASE WHEN rohs_compliance = TRUE THEN 1 ELSE 0 END)
      comment: "Count of RoHS compliant parts"
    - name: "reach_compliant_count"
      expr: SUM(CASE WHEN reach_compliance = TRUE THEN 1 ELSE 0 END)
      comment: "Count of REACH compliant parts"
    - name: "obsolescence_notice_count"
      expr: SUM(CASE WHEN obsolescence_notice = TRUE THEN 1 ELSE 0 END)
      comment: "Count of parts with obsolescence notice"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`engineering_dvp_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design Verification Plan performance metrics tracking plan completion, cost, test coverage, and regulatory approval status"
  source: "`automotive_ecm`.`engineering`.`dvp_plan`"
  dimensions:
    - name: "plan_code"
      expr: plan_code
      comment: "Unique code for the DVP plan"
    - name: "plan_title"
      expr: plan_title
      comment: "Title of the DVP plan"
    - name: "dvp_plan_status"
      expr: dvp_plan_status
      comment: "Current status of the DVP plan"
    - name: "plan_type"
      expr: plan_type
      comment: "Type classification of the plan"
    - name: "test_phase"
      expr: test_phase
      comment: "Testing phase of the plan"
    - name: "test_type"
      expr: test_type
      comment: "Type of testing covered"
    - name: "test_environment"
      expr: test_environment
      comment: "Environment in which tests are conducted"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the plan"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the plan"
    - name: "priority"
      expr: priority
      comment: "Priority level of the plan"
    - name: "regulatory_approval_required"
      expr: regulatory_approval_required
      comment: "Whether regulatory approval is required"
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Status of regulatory approval"
    - name: "is_automated"
      expr: is_automated
      comment: "Whether the plan includes automated testing"
    - name: "is_locked"
      expr: is_locked
      comment: "Whether the plan is locked from changes"
    - name: "model_year"
      expr: model_year
      comment: "Model year associated with the plan"
  measures:
    - name: "total_dvp_plan_count"
      expr: COUNT(1)
      comment: "Total number of DVP plans"
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across DVP plans"
    - name: "total_cost_estimate_usd"
      expr: SUM(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Total estimated cost of DVP plans in USD"
    - name: "avg_cost_estimate_usd"
      expr: AVG(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Average cost estimate per DVP plan in USD"
    - name: "total_test_count"
      expr: SUM(CAST(total_test_count AS DOUBLE))
      comment: "Total number of tests planned across all DVP plans"
    - name: "total_completed_test_count"
      expr: SUM(CAST(completed_test_count AS DOUBLE))
      comment: "Total number of completed tests across all DVP plans"
    - name: "regulatory_approval_required_count"
      expr: SUM(CASE WHEN regulatory_approval_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of plans requiring regulatory approval"
    - name: "automated_plan_count"
      expr: SUM(CASE WHEN is_automated = TRUE THEN 1 ELSE 0 END)
      comment: "Count of plans with automated testing"
    - name: "locked_plan_count"
      expr: SUM(CASE WHEN is_locked = TRUE THEN 1 ELSE 0 END)
      comment: "Count of locked DVP plans"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`engineering_fmea_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Failure Mode and Effects Analysis performance metrics tracking risk priority, severity, detection, occurrence ratings, and mitigation effectiveness"
  source: "`automotive_ecm`.`engineering`.`fmea_record`"
  dimensions:
    - name: "fmea_number"
      expr: fmea_number
      comment: "Unique FMEA record number"
    - name: "fmea_type"
      expr: fmea_type
      comment: "Type of FMEA analysis"
    - name: "fmea_record_status"
      expr: fmea_record_status
      comment: "Current status of the FMEA record"
    - name: "failure_mode"
      expr: failure_mode
      comment: "Description of the failure mode"
    - name: "failure_effect"
      expr: failure_effect
      comment: "Effect of the failure"
    - name: "risk_category"
      expr: risk_category
      comment: "Category of risk"
    - name: "severity_rating"
      expr: severity_rating
      comment: "Severity rating of the failure"
    - name: "occurrence_rating"
      expr: occurrence_rating
      comment: "Occurrence rating of the failure"
    - name: "detection_rating"
      expr: detection_rating
      comment: "Detection rating for the failure"
    - name: "analysis_team"
      expr: analysis_team
      comment: "Team responsible for the FMEA analysis"
  measures:
    - name: "total_fmea_record_count"
      expr: COUNT(1)
      comment: "Total number of FMEA records"
    - name: "avg_rpn"
      expr: AVG(CAST(rpn AS DOUBLE))
      comment: "Average Risk Priority Number across FMEA records"
    - name: "high_severity_count"
      expr: SUM(CASE WHEN CAST(severity_rating AS INT) >= 8 THEN 1 ELSE 0 END)
      comment: "Count of FMEA records with high severity rating (8+)"
    - name: "high_rpn_count"
      expr: SUM(CASE WHEN CAST(rpn AS INT) >= 100 THEN 1 ELSE 0 END)
      comment: "Count of FMEA records with high RPN (100+)"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`engineering_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program milestone performance metrics tracking on-time delivery, critical milestone achievement, and gate review outcomes"
  source: "`automotive_ecm`.`engineering`.`milestone`"
  dimensions:
    - name: "milestone_code"
      expr: milestone_code
      comment: "Unique code for the milestone"
    - name: "milestone_name"
      expr: milestone_name
      comment: "Name of the milestone"
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone"
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type classification of the milestone"
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the milestone is critical to program success"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the milestone"
    - name: "gate_review_outcome"
      expr: gate_review_outcome
      comment: "Outcome of the gate review"
    - name: "compliance_standard"
      expr: compliance_standard
      comment: "Compliance standard associated with the milestone"
    - name: "plant_location"
      expr: plant_location
      comment: "Plant location for the milestone"
    - name: "planned_year"
      expr: YEAR(planned_date)
      comment: "Year the milestone was planned"
    - name: "planned_quarter"
      expr: CONCAT('Q', QUARTER(planned_date), '-', YEAR(planned_date))
      comment: "Quarter and year the milestone was planned"
    - name: "actual_year"
      expr: YEAR(actual_date)
      comment: "Year the milestone was actually achieved"
  measures:
    - name: "total_milestone_count"
      expr: COUNT(1)
      comment: "Total number of program milestones"
    - name: "critical_milestone_count"
      expr: SUM(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END)
      comment: "Count of critical milestones"
    - name: "completed_milestone_count"
      expr: SUM(CASE WHEN milestone_status = 'Completed' THEN 1 ELSE 0 END)
      comment: "Count of completed milestones"
    - name: "delayed_milestone_count"
      expr: SUM(CASE WHEN actual_date > planned_date THEN 1 ELSE 0 END)
      comment: "Count of milestones completed after planned date"
    - name: "on_time_milestone_count"
      expr: SUM(CASE WHEN actual_date <= planned_date THEN 1 ELSE 0 END)
      comment: "Count of milestones completed on or before planned date"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`engineering_powertrain_spec`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Powertrain specification performance metrics tracking power output, emissions compliance, cost, and technology adoption across powertrain types"
  source: "`automotive_ecm`.`engineering`.`powertrain_spec`"
  dimensions:
    - name: "spec_code"
      expr: spec_code
      comment: "Unique specification code"
    - name: "spec_name"
      expr: spec_name
      comment: "Name of the powertrain specification"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Type of powertrain (ICE, hybrid, electric, etc.)"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Type of fuel used"
    - name: "architecture_type"
      expr: architecture_type
      comment: "Architecture type of the powertrain"
    - name: "transmission_type"
      expr: transmission_type
      comment: "Type of transmission"
    - name: "emissions_standard"
      expr: emissions_standard
      comment: "Emissions standard compliance target"
    - name: "emission_control_technology"
      expr: emission_control_technology
      comment: "Technology used for emission control"
    - name: "powertrain_spec_status"
      expr: powertrain_spec_status
      comment: "Current status of the specification"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the specification"
    - name: "model_year"
      expr: model_year
      comment: "Model year for the specification"
    - name: "is_locked"
      expr: is_locked
      comment: "Whether the specification is locked"
  measures:
    - name: "total_powertrain_spec_count"
      expr: COUNT(1)
      comment: "Total number of powertrain specifications"
    - name: "avg_power_output_kw"
      expr: AVG(CAST(power_output_kw AS DOUBLE))
      comment: "Average power output in kilowatts"
    - name: "avg_torque_nm"
      expr: AVG(CAST(torque_nm AS DOUBLE))
      comment: "Average torque in Newton-meters"
    - name: "avg_battery_capacity_kwh"
      expr: AVG(CAST(battery_capacity_kwh AS DOUBLE))
      comment: "Average battery capacity in kilowatt-hours for electric powertrains"
    - name: "avg_cost_estimate_usd"
      expr: AVG(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Average cost estimate per powertrain specification in USD"
    - name: "total_cost_estimate_usd"
      expr: SUM(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Total cost estimate across powertrain specifications in USD"
    - name: "avg_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average powertrain weight in kilograms"
    - name: "electric_powertrain_count"
      expr: SUM(CASE WHEN powertrain_type = 'Electric' THEN 1 ELSE 0 END)
      comment: "Count of electric powertrain specifications"
    - name: "hybrid_powertrain_count"
      expr: SUM(CASE WHEN powertrain_type = 'Hybrid' THEN 1 ELSE 0 END)
      comment: "Count of hybrid powertrain specifications"
$$;