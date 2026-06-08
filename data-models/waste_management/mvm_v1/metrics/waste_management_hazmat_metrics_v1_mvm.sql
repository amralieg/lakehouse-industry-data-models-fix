-- Metric views for domain: hazmat | Business: Waste Management | Version: 1 | Generated on: 2026-05-07 22:39:52

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`hazmat_manifest`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazardous waste manifest operational metrics tracking shipment volumes, compliance status, discrepancies, and rejection rates. Manifests are the primary regulatory document for hazardous waste transport and are central to EPA/DOT compliance reporting."
  source: "`waste_management_ecm`.`hazmat`.`manifest`"
  dimensions:
    - name: "manifest_status"
      expr: manifest_status
      comment: "Current status of the manifest (e.g., pending, completed, rejected) used to segment compliance and operational performance."
    - name: "manifest_type"
      expr: manifest_type
      comment: "Type of manifest (e.g., uniform hazardous waste manifest, state-specific) for regulatory classification."
    - name: "dot_hazard_class"
      expr: dot_hazard_class
      comment: "DOT hazard class of the primary waste on the manifest, used to analyze risk profile of shipments."
    - name: "generator_state"
      expr: generator_state
      comment: "US state where the waste generator is located, enabling geographic compliance and volume analysis."
    - name: "shipment_month"
      expr: DATE_TRUNC('MONTH', shipment_date)
      comment: "Month of shipment date for trend analysis of manifest volumes over time."
    - name: "shipment_year"
      expr: YEAR(shipment_date)
      comment: "Year of shipment for annual regulatory reporting and year-over-year comparisons."
    - name: "discrepancy_indication"
      expr: discrepancy_indication
      comment: "Boolean flag indicating whether a discrepancy was noted on the manifest, used to filter compliance exception analysis."
    - name: "rejection_indication"
      expr: rejection_indication
      comment: "Boolean flag indicating whether the manifest was rejected by the TSDF, a key compliance risk indicator."
    - name: "quantity_unit"
      expr: quantity_unit
      comment: "Unit of measure for waste quantity (e.g., gallons, pounds, tons) for normalized volume reporting."
  measures:
    - name: "total_manifests"
      expr: COUNT(1)
      comment: "Total number of hazardous waste manifests. Baseline KPI for regulatory workload and shipment throughput."
    - name: "total_waste_quantity"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total quantity of hazardous waste shipped across all manifests. Core volume metric for regulatory reporting and capacity planning."
    - name: "avg_waste_quantity_per_manifest"
      expr: AVG(CAST(total_quantity AS DOUBLE))
      comment: "Average waste quantity per manifest. Indicates typical shipment size and helps identify anomalous over- or under-loaded manifests."
    - name: "discrepancy_manifest_count"
      expr: COUNT(CASE WHEN discrepancy_indication = TRUE THEN 1 END)
      comment: "Number of manifests with a recorded discrepancy. High values signal compliance risk and potential regulatory violations."
    - name: "rejection_manifest_count"
      expr: COUNT(CASE WHEN rejection_indication = TRUE THEN 1 END)
      comment: "Number of manifests rejected by the TSDF. Rejections trigger re-routing costs and regulatory scrutiny."
    - name: "distinct_generators"
      expr: COUNT(DISTINCT manifest_generator_epa_id_registration_id)
      comment: "Number of distinct waste generators represented in manifests. Measures breadth of generator customer base served."
    - name: "distinct_tsdf_destinations"
      expr: COUNT(DISTINCT tsdf_facility_id)
      comment: "Number of distinct TSDF destinations used. Indicates disposal network diversity and concentration risk."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`hazmat_disposal_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazardous waste disposal performance and cost metrics. Tracks disposal volumes, costs, LDR compliance, regulatory reporting, and emergency response events. Critical for environmental liability management and cost control."
  source: "`waste_management_ecm`.`hazmat`.`disposal_record`"
  dimensions:
    - name: "disposal_status"
      expr: disposal_status
      comment: "Current status of the disposal record (e.g., completed, pending, rejected) for operational pipeline monitoring."
    - name: "disposal_method_code"
      expr: disposal_method_code
      comment: "Code identifying the disposal method (e.g., incineration, landfill, neutralization) for method-level cost and compliance analysis."
    - name: "disposal_month"
      expr: DATE_TRUNC('MONTH', disposal_date)
      comment: "Month of disposal for trend analysis of disposal volumes and costs."
    - name: "disposal_year"
      expr: YEAR(disposal_date)
      comment: "Year of disposal for annual regulatory reporting and year-over-year cost comparisons."
    - name: "ldr_compliance_certified"
      expr: ldr_compliance_certified
      comment: "Boolean indicating whether Land Disposal Restrictions (LDR) certification was completed. Non-certified disposals represent regulatory violations."
    - name: "regulatory_report_submitted"
      expr: regulatory_report_submitted
      comment: "Boolean indicating whether the required regulatory report was submitted for this disposal event."
    - name: "emergency_response_required"
      expr: emergency_response_required
      comment: "Boolean flag for disposals requiring emergency response, used to track high-risk disposal events."
    - name: "disposal_cost_currency"
      expr: disposal_cost_currency
      comment: "Currency of disposal cost for multi-currency cost normalization."
    - name: "waste_code_primary"
      expr: waste_code_primary
      comment: "Primary EPA waste code for the disposed waste, enabling cost and volume analysis by waste type."
  measures:
    - name: "total_disposal_records"
      expr: COUNT(1)
      comment: "Total number of disposal records. Baseline measure for disposal throughput and regulatory workload."
    - name: "total_disposal_cost"
      expr: SUM(CAST(disposal_cost_amount AS DOUBLE))
      comment: "Total disposal cost across all records. Primary cost KPI for hazardous waste disposal budget management."
    - name: "avg_disposal_cost_per_record"
      expr: AVG(CAST(disposal_cost_amount AS DOUBLE))
      comment: "Average disposal cost per disposal event. Benchmarks cost efficiency and identifies outlier disposal events."
    - name: "total_waste_quantity_lbs"
      expr: SUM(CAST(waste_quantity_lbs AS DOUBLE))
      comment: "Total weight of hazardous waste disposed in pounds. Core volume metric for regulatory reporting and capacity planning."
    - name: "total_waste_quantity_tons"
      expr: SUM(CAST(waste_quantity_tons AS DOUBLE))
      comment: "Total weight of hazardous waste disposed in tons. Used for RCRA biennial reporting and disposal contract benchmarking."
    - name: "total_waste_volume_gallons"
      expr: SUM(CAST(waste_volume_gallons AS DOUBLE))
      comment: "Total volume of liquid hazardous waste disposed in gallons. Critical for liquid waste stream capacity and cost analysis."
    - name: "ldr_non_compliant_count"
      expr: COUNT(CASE WHEN ldr_compliance_certified = FALSE THEN 1 END)
      comment: "Number of disposal records where LDR certification was NOT completed. Each represents a potential regulatory violation with significant penalty exposure."
    - name: "regulatory_report_pending_count"
      expr: COUNT(CASE WHEN regulatory_report_submitted = FALSE THEN 1 END)
      comment: "Number of disposal records where the regulatory report has not yet been submitted. Tracks compliance reporting backlog."
    - name: "emergency_response_event_count"
      expr: COUNT(CASE WHEN emergency_response_required = TRUE THEN 1 END)
      comment: "Number of disposal events requiring emergency response. High-severity safety and liability indicator."
    - name: "avg_cost_per_ton"
      expr: SUM(CAST(disposal_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(waste_quantity_tons AS DOUBLE)), 0)
      comment: "Average disposal cost per ton of hazardous waste. Key efficiency ratio for benchmarking disposal contracts and methods."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`hazmat_waste_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazardous waste shipment logistics and compliance metrics. Tracks shipment weights, transit performance, chain-of-custody verification, route deviations, and temperature control compliance. Supports fleet operations and DOT compliance oversight."
  source: "`waste_management_ecm`.`hazmat`.`waste_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the waste shipment (e.g., in-transit, delivered, exception) for real-time operational monitoring."
    - name: "shipment_month"
      expr: DATE_TRUNC('MONTH', shipment_date)
      comment: "Month of shipment for trend analysis of hazardous waste transport volumes."
    - name: "shipment_year"
      expr: YEAR(shipment_date)
      comment: "Year of shipment for annual volume and compliance reporting."
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Boolean indicating whether the shipment required temperature-controlled transport, used to segment specialized handling costs."
    - name: "dot_placard_required"
      expr: dot_placard_required
      comment: "Boolean indicating whether DOT placarding was required for the shipment, a key DOT compliance dimension."
    - name: "chain_of_custody_verified"
      expr: chain_of_custody_verified
      comment: "Boolean indicating whether chain of custody was verified for the shipment. Non-verified shipments represent regulatory risk."
    - name: "route_deviation_detected"
      expr: route_deviation_detected
      comment: "Boolean indicating whether a GPS route deviation was detected during transport. Route deviations may violate permit conditions."
    - name: "gps_tracking_enabled"
      expr: gps_tracking_enabled
      comment: "Boolean indicating whether GPS tracking was active on the shipment, used to assess fleet visibility coverage."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of hazardous waste shipments. Baseline throughput KPI for logistics operations."
    - name: "total_billing_weight_lbs"
      expr: SUM(CAST(billing_weight_lbs AS DOUBLE))
      comment: "Total billed weight of hazardous waste shipments in pounds. Drives revenue recognition and contract utilization tracking."
    - name: "total_gross_weight_lbs"
      expr: SUM(CAST(total_weight_lbs AS DOUBLE))
      comment: "Total gross weight of all hazardous waste shipments in pounds. Used for fleet load planning and DOT weight compliance."
    - name: "avg_actual_transit_hours"
      expr: AVG(CAST(actual_transit_hours AS DOUBLE))
      comment: "Average actual transit time in hours. Measures logistics efficiency and identifies routes with excessive transit times."
    - name: "avg_estimated_transit_hours"
      expr: AVG(CAST(estimated_transit_hours AS DOUBLE))
      comment: "Average estimated transit time in hours. Used as the baseline for transit performance variance analysis."
    - name: "transit_variance_hours"
      expr: AVG(CAST(actual_transit_hours AS DOUBLE) - CAST(estimated_transit_hours AS DOUBLE))
      comment: "Average variance between actual and estimated transit hours. Positive values indicate chronic delays; negative values indicate over-estimation. Key logistics performance indicator."
    - name: "route_deviation_count"
      expr: COUNT(CASE WHEN route_deviation_detected = TRUE THEN 1 END)
      comment: "Number of shipments with detected route deviations. Route deviations may violate hazmat transport permits and trigger regulatory reporting."
    - name: "chain_of_custody_unverified_count"
      expr: COUNT(CASE WHEN chain_of_custody_verified = FALSE THEN 1 END)
      comment: "Number of shipments where chain of custody was not verified. Unverified custody is a critical compliance gap under RCRA."
    - name: "distinct_transporters"
      expr: COUNT(DISTINCT transporter_registration_id)
      comment: "Number of distinct registered transporters used. Measures transporter network breadth and concentration risk."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`hazmat_treatment_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazardous waste treatment performance, efficiency, and cost metrics. Tracks treatment throughput, efficiency rates, LDR compliance, TCLP testing, and treatment costs. Supports TSDF operational performance management and regulatory compliance."
  source: "`waste_management_ecm`.`hazmat`.`treatment_record`"
  dimensions:
    - name: "treatment_status"
      expr: treatment_status
      comment: "Current status of the treatment record (e.g., completed, in-progress, failed) for operational pipeline monitoring."
    - name: "treatment_technology_code"
      expr: treatment_technology_code
      comment: "Code identifying the treatment technology applied (e.g., incineration, stabilization, neutralization) for technology-level performance analysis."
    - name: "treatment_month"
      expr: DATE_TRUNC('MONTH', treatment_date)
      comment: "Month of treatment for trend analysis of treatment volumes and costs."
    - name: "treatment_year"
      expr: YEAR(treatment_date)
      comment: "Year of treatment for annual regulatory reporting and year-over-year performance comparisons."
    - name: "ldr_compliance_status"
      expr: ldr_compliance_status
      comment: "LDR compliance status for the treatment record. Non-compliant records represent regulatory violations."
    - name: "tclp_test_performed"
      expr: tclp_test_performed
      comment: "Boolean indicating whether a TCLP (Toxicity Characteristic Leaching Procedure) test was performed, required for certain waste codes."
    - name: "quality_assurance_review_status"
      expr: quality_assurance_review_status
      comment: "QA review status of the treatment record, used to track quality control pipeline and identify records pending review."
    - name: "emergency_response_flag"
      expr: emergency_response_flag
      comment: "Boolean flag for treatment events requiring emergency response, used to track high-risk treatment incidents."
  measures:
    - name: "total_treatment_records"
      expr: COUNT(1)
      comment: "Total number of treatment records. Baseline throughput KPI for TSDF treatment operations."
    - name: "total_treatment_cost_usd"
      expr: SUM(CAST(treatment_cost_usd AS DOUBLE))
      comment: "Total treatment cost in USD. Primary cost KPI for hazardous waste treatment budget management and contract benchmarking."
    - name: "avg_treatment_cost_usd"
      expr: AVG(CAST(treatment_cost_usd AS DOUBLE))
      comment: "Average treatment cost per record in USD. Benchmarks treatment cost efficiency across technologies and facilities."
    - name: "total_input_waste_quantity"
      expr: SUM(CAST(input_waste_quantity AS DOUBLE))
      comment: "Total quantity of hazardous waste input into treatment processes. Core volume metric for treatment capacity utilization."
    - name: "total_output_residual_quantity"
      expr: SUM(CAST(output_residual_quantity AS DOUBLE))
      comment: "Total residual waste quantity after treatment. Lower residuals indicate higher treatment effectiveness."
    - name: "avg_treatment_efficiency_pct"
      expr: AVG(CAST(treatment_efficiency_percent AS DOUBLE))
      comment: "Average treatment efficiency percentage across all treatment records. Key operational KPI for TSDF performance management."
    - name: "avg_residence_time_minutes"
      expr: AVG(CAST(residence_time_minutes AS DOUBLE))
      comment: "Average residence time in treatment units in minutes. Deviations from standard residence times may indicate process control issues."
    - name: "tclp_test_performed_count"
      expr: COUNT(CASE WHEN tclp_test_performed = TRUE THEN 1 END)
      comment: "Number of treatment records where TCLP testing was performed. Tracks compliance with toxicity characteristic testing requirements."
    - name: "emergency_response_treatment_count"
      expr: COUNT(CASE WHEN emergency_response_flag = TRUE THEN 1 END)
      comment: "Number of treatment events requiring emergency response. High-severity safety and liability indicator for treatment operations."
    - name: "avg_treatment_temperature_celsius"
      expr: AVG(CAST(treatment_temperature_celsius AS DOUBLE))
      comment: "Average treatment temperature in Celsius. Critical process control metric for thermal treatment technologies (e.g., incineration)."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`hazmat_hazardous_waste_generator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazardous waste generator compliance and portfolio metrics. Tracks generator classification distribution, compliance status, biennial reporting obligations, and inspection currency. Supports regulatory account management and compliance risk prioritization."
  source: "`waste_management_ecm`.`hazmat`.`hazardous_waste_generator`"
  dimensions:
    - name: "generator_category"
      expr: generator_category
      comment: "EPA generator category (e.g., LQG, SQG, VSQG) determining regulatory requirements and reporting obligations."
    - name: "generator_status"
      expr: generator_status
      comment: "Current operational status of the generator (e.g., active, inactive, closed) for portfolio management."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the generator. Non-compliant generators represent regulatory and reputational risk."
    - name: "site_state"
      expr: site_state
      comment: "US state where the generator site is located for geographic compliance portfolio analysis."
    - name: "biennial_report_required_flag"
      expr: biennial_report_required_flag
      comment: "Boolean indicating whether the generator is required to submit a RCRA biennial report."
    - name: "waste_minimization_plan_flag"
      expr: waste_minimization_plan_flag
      comment: "Boolean indicating whether the generator has an active waste minimization plan, a regulatory best practice indicator."
    - name: "federal_facility_flag"
      expr: federal_facility_flag
      comment: "Boolean indicating whether the generator is a federal facility, which has distinct regulatory oversight requirements."
  measures:
    - name: "total_generators"
      expr: COUNT(1)
      comment: "Total number of hazardous waste generators in the portfolio. Baseline KPI for regulatory account management scope."
    - name: "non_compliant_generator_count"
      expr: COUNT(CASE WHEN compliance_status != 'compliant' THEN 1 END)
      comment: "Number of generators not in compliant status. Each non-compliant generator represents regulatory risk and potential enforcement action."
    - name: "biennial_report_required_count"
      expr: COUNT(CASE WHEN biennial_report_required_flag = TRUE THEN 1 END)
      comment: "Number of generators required to submit RCRA biennial reports. Drives regulatory reporting workload planning."
    - name: "waste_minimization_plan_count"
      expr: COUNT(CASE WHEN waste_minimization_plan_flag = TRUE THEN 1 END)
      comment: "Number of generators with active waste minimization plans. Tracks adoption of EPA-encouraged waste reduction practices."
    - name: "avg_enforcement_action_count"
      expr: AVG(CAST(enforcement_action_count AS DOUBLE))
      comment: "Average number of enforcement actions per generator. Elevated averages signal systemic compliance issues in the generator portfolio."
    - name: "distinct_states_served"
      expr: COUNT(DISTINCT site_state)
      comment: "Number of distinct US states where generators are located. Measures geographic regulatory footprint and multi-state compliance complexity."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`hazmat_chain_of_custody`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazardous waste chain-of-custody transfer metrics. Tracks transfer events, discrepancy rates, waste quantities transferred, and geographic transfer patterns. Critical for RCRA cradle-to-grave tracking and regulatory audit readiness."
  source: "`waste_management_ecm`.`hazmat`.`chain_of_custody`"
  dimensions:
    - name: "transfer_event_type"
      expr: transfer_event_type
      comment: "Type of transfer event (e.g., generator-to-transporter, transporter-to-TSDF) for custody chain stage analysis."
    - name: "dot_hazard_class"
      expr: dot_hazard_class
      comment: "DOT hazard class of the waste being transferred, used to analyze risk profile of custody transfers."
    - name: "transfer_location_state"
      expr: transfer_location_state
      comment: "US state where the custody transfer occurred for geographic compliance analysis."
    - name: "discrepancy_indicator"
      expr: discrepancy_indicator
      comment: "Boolean flag indicating a discrepancy was recorded at this custody transfer point. Discrepancies trigger regulatory investigation."
    - name: "discrepancy_type"
      expr: discrepancy_type
      comment: "Type of discrepancy recorded (e.g., quantity mismatch, container damage) for root cause analysis."
    - name: "transfer_month"
      expr: DATE_TRUNC('MONTH', transfer_timestamp)
      comment: "Month of the custody transfer event for trend analysis of transfer volumes and discrepancy rates."
    - name: "packing_group"
      expr: packing_group
      comment: "DOT packing group of the transferred waste, indicating hazard severity level (I=greatest, III=least)."
  measures:
    - name: "total_transfer_events"
      expr: COUNT(1)
      comment: "Total number of chain-of-custody transfer events. Baseline KPI for custody tracking throughput and regulatory audit scope."
    - name: "total_quantity_transferred"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total quantity of hazardous waste transferred across all custody events. Core volume metric for RCRA cradle-to-grave tracking."
    - name: "avg_quantity_per_transfer"
      expr: AVG(CAST(total_quantity AS DOUBLE))
      comment: "Average waste quantity per custody transfer event. Identifies anomalously large or small transfers for audit targeting."
    - name: "discrepancy_event_count"
      expr: COUNT(CASE WHEN discrepancy_indicator = TRUE THEN 1 END)
      comment: "Number of custody transfer events with a recorded discrepancy. Each discrepancy is a potential RCRA violation requiring investigation."
    - name: "distinct_manifests_tracked"
      expr: COUNT(DISTINCT manifest_id)
      comment: "Number of distinct manifests with custody transfer records. Measures completeness of cradle-to-grave tracking coverage."
    - name: "distinct_transfer_locations"
      expr: COUNT(DISTINCT transfer_location_name)
      comment: "Number of distinct transfer locations in the custody chain. Measures geographic complexity of the hazmat transport network."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`hazmat_transporter_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazardous waste transporter compliance and risk metrics. Tracks registration status, insurance coverage, safety ratings, training compliance, and vendor performance. Supports transporter qualification management and supply chain risk oversight."
  source: "`waste_management_ecm`.`hazmat`.`transporter_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current registration status of the transporter (e.g., active, expired, suspended). Expired registrations create regulatory exposure."
    - name: "safety_rating"
      expr: safety_rating
      comment: "DOT safety rating of the transporter (e.g., satisfactory, conditional, unsatisfactory). Unsatisfactory-rated transporters should not be used."
    - name: "hazmat_employee_training_compliance_status"
      expr: hazmat_employee_training_compliance_status
      comment: "Status of hazmat employee training compliance. Non-compliant training status is a DOT violation."
    - name: "state_code"
      expr: state_code
      comment: "State where the transporter is registered for geographic network analysis."
    - name: "approved_for_manifest_use"
      expr: approved_for_manifest_use
      comment: "Boolean indicating whether the transporter is approved for use on hazardous waste manifests."
  measures:
    - name: "total_registered_transporters"
      expr: COUNT(1)
      comment: "Total number of registered hazardous waste transporters. Baseline KPI for transporter network size."
    - name: "active_transporter_count"
      expr: COUNT(CASE WHEN registration_status = 'active' THEN 1 END)
      comment: "Number of transporters with active registration status. Measures available qualified transporter capacity."
    - name: "expired_registration_count"
      expr: COUNT(CASE WHEN registration_status = 'expired' THEN 1 END)
      comment: "Number of transporters with expired registrations. Using expired transporters creates regulatory violations and liability."
    - name: "avg_vendor_performance_score"
      expr: AVG(CAST(vendor_performance_score AS DOUBLE))
      comment: "Average vendor performance score across all transporters. Key supplier management KPI for transporter qualification decisions."
    - name: "avg_cargo_insurance_coverage"
      expr: AVG(CAST(cargo_insurance_coverage_amount AS DOUBLE))
      comment: "Average cargo insurance coverage amount across transporters. Measures adequacy of insurance coverage in the transporter network."
    - name: "avg_liability_insurance_coverage"
      expr: AVG(CAST(liability_insurance_coverage_amount AS DOUBLE))
      comment: "Average liability insurance coverage amount. Tracks financial protection adequacy for hazmat transport incidents."
    - name: "training_non_compliant_count"
      expr: COUNT(CASE WHEN hazmat_employee_training_compliance_status != 'compliant' THEN 1 END)
      comment: "Number of transporters with non-compliant hazmat employee training status. DOT requires current hazmat training for all employees handling hazardous materials."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`hazmat_storage_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazardous waste storage unit capacity, utilization, and compliance metrics. Tracks inventory levels, capacity utilization, inspection currency, and temperature control compliance. Supports accumulation time limit management and storage permit compliance."
  source: "`waste_management_ecm`.`hazmat`.`storage_unit`"
  dimensions:
    - name: "unit_status"
      expr: unit_status
      comment: "Current operational status of the storage unit (e.g., active, closed, out-of-service) for capacity planning."
    - name: "unit_type"
      expr: unit_type
      comment: "Type of storage unit (e.g., tank, container, drip pad, containment building) for unit-type-level compliance analysis."
    - name: "temperature_control_required"
      expr: temperature_control_required
      comment: "Boolean indicating whether temperature control is required for the storage unit, used to segment specialized storage costs."
    - name: "inventory_unit_of_measure"
      expr: inventory_unit_of_measure
      comment: "Unit of measure for inventory quantity (e.g., gallons, pounds) for normalized capacity utilization reporting."
  measures:
    - name: "total_storage_units"
      expr: COUNT(1)
      comment: "Total number of hazardous waste storage units. Baseline KPI for storage infrastructure scope."
    - name: "total_current_inventory"
      expr: SUM(CAST(current_inventory_quantity AS DOUBLE))
      comment: "Total current inventory quantity across all storage units. Critical for accumulation time limit monitoring and capacity management."
    - name: "total_capacity_gallons"
      expr: SUM(CAST(maximum_capacity_gallons AS DOUBLE))
      comment: "Total maximum storage capacity in gallons across all units. Used for network-level capacity planning."
    - name: "total_capacity_pounds"
      expr: SUM(CAST(maximum_capacity_pounds AS DOUBLE))
      comment: "Total maximum storage capacity in pounds across all units. Used for solid/semi-solid waste storage capacity planning."
    - name: "overdue_inspection_count"
      expr: COUNT(CASE WHEN next_inspection_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of storage units with overdue inspections. Overdue inspections are a regulatory violation under RCRA storage unit requirements."
    - name: "distinct_facilities_with_storage"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities with active hazardous waste storage units. Measures geographic scope of storage operations."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`hazmat_rcra_biennial_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RCRA biennial report submission and waste generation metrics. Tracks waste generation volumes, offsite shipment quantities, onsite management activities, and waste minimization achievements. Directly supports EPA biennial reporting obligations and environmental performance disclosure."
  source: "`waste_management_ecm`.`hazmat`.`rcra_biennial_report`"
  dimensions:
    - name: "reporting_year"
      expr: reporting_year
      comment: "Biennial reporting year (e.g., 2022, 2024) for period-over-period regulatory reporting comparisons."
    - name: "generator_status"
      expr: generator_status
      comment: "Generator status at time of reporting (e.g., LQG, SQG) determining reporting requirements and thresholds."
    - name: "primary_treatment_method"
      expr: primary_treatment_method
      comment: "Primary treatment method applied to the reported waste stream for treatment method distribution analysis."
    - name: "offsite_shipment_flag"
      expr: offsite_shipment_flag
      comment: "Boolean indicating whether waste was shipped offsite for disposal or treatment."
    - name: "onsite_treatment_flag"
      expr: onsite_treatment_flag
      comment: "Boolean indicating whether waste was treated onsite, used to analyze self-management vs. third-party disposal split."
    - name: "waste_minimization_achieved_flag"
      expr: waste_minimization_achieved_flag
      comment: "Boolean indicating whether waste minimization was achieved in the reporting period. Tracks environmental performance improvement."
    - name: "state_agency_code"
      expr: state_agency_code
      comment: "State agency code for the reporting jurisdiction, enabling state-level regulatory reporting analysis."
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total number of RCRA biennial report records. Baseline KPI for regulatory reporting portfolio scope."
    - name: "total_waste_generated_lbs"
      expr: SUM(CAST(total_waste_generated_lbs AS DOUBLE))
      comment: "Total hazardous waste generated in pounds as reported in biennial reports. Primary environmental performance KPI for regulatory disclosure."
    - name: "total_waste_shipped_offsite_lbs"
      expr: SUM(CAST(total_waste_shipped_offsite_lbs AS DOUBLE))
      comment: "Total hazardous waste shipped offsite for disposal or treatment in pounds. Measures reliance on third-party disposal and associated liability."
    - name: "total_waste_managed_onsite_lbs"
      expr: SUM(CAST(total_waste_managed_onsite_lbs AS DOUBLE))
      comment: "Total hazardous waste managed onsite in pounds. Measures self-management capacity and associated permit obligations."
    - name: "waste_minimization_achievement_rate"
      expr: COUNT(CASE WHEN waste_minimization_achieved_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Proportion of reporting generators that achieved waste minimization. Key environmental performance indicator for sustainability reporting."
    - name: "distinct_generators_reporting"
      expr: COUNT(DISTINCT hazardous_waste_generator_id)
      comment: "Number of distinct generators represented in biennial reports. Measures regulatory reporting coverage of the generator portfolio."
    - name: "avg_waste_generated_per_generator_lbs"
      expr: AVG(CAST(total_waste_generated_lbs AS DOUBLE))
      comment: "Average waste generated per generator per reporting period in pounds. Benchmarks generator waste intensity and identifies high-volume generators."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`hazmat_waste_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazardous waste profile approval and characterization metrics. Tracks profile approval status, land disposal restrictions, physical and chemical hazard properties, and annual quantity estimates. Supports waste acceptance decisions and LDR compliance management."
  source: "`waste_management_ecm`.`hazmat`.`waste_profile`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the waste profile (e.g., approved, pending, rejected, expired). Only approved profiles may be used for waste acceptance."
    - name: "physical_state"
      expr: physical_state
      comment: "Physical state of the waste (e.g., solid, liquid, sludge, gas) for handling and treatment method classification."
    - name: "dot_hazard_class"
      expr: dot_hazard_class
      comment: "DOT hazard class of the profiled waste for risk-based portfolio analysis."
    - name: "land_disposal_restricted"
      expr: land_disposal_restricted
      comment: "Boolean indicating whether the waste is subject to Land Disposal Restrictions, requiring treatment before disposal."
    - name: "is_ignitable"
      expr: is_ignitable
      comment: "Boolean indicating ignitable waste characteristic (D001), a key hazard property for storage and treatment planning."
    - name: "is_corrosive"
      expr: is_corrosive
      comment: "Boolean indicating corrosive waste characteristic (D002), affecting container material and handling requirements."
    - name: "is_reactive"
      expr: is_reactive
      comment: "Boolean indicating reactive waste characteristic (D003), the highest-risk hazard property requiring special handling."
    - name: "is_toxic"
      expr: is_toxic
      comment: "Boolean indicating toxic waste characteristic (D004-D043), requiring TCLP testing and specific treatment standards."
  measures:
    - name: "total_waste_profiles"
      expr: COUNT(1)
      comment: "Total number of waste profiles. Baseline KPI for waste acceptance portfolio scope."
    - name: "approved_profile_count"
      expr: COUNT(CASE WHEN approval_status = 'approved' THEN 1 END)
      comment: "Number of currently approved waste profiles. Measures active waste acceptance capacity."
    - name: "expired_profile_count"
      expr: COUNT(CASE WHEN approval_status = 'expired' THEN 1 END)
      comment: "Number of expired waste profiles. Expired profiles must be renewed before waste can be accepted, creating operational risk."
    - name: "ldr_restricted_profile_count"
      expr: COUNT(CASE WHEN land_disposal_restricted = TRUE THEN 1 END)
      comment: "Number of waste profiles subject to Land Disposal Restrictions. LDR-restricted wastes require treatment before disposal, increasing cost and complexity."
    - name: "total_annual_quantity_estimate_tons"
      expr: SUM(CAST(annual_quantity_estimate_tons AS DOUBLE))
      comment: "Total estimated annual waste quantity across all approved profiles in tons. Drives capacity planning and disposal contract sizing."
    - name: "avg_annual_quantity_estimate_tons"
      expr: AVG(CAST(annual_quantity_estimate_tons AS DOUBLE))
      comment: "Average annual quantity estimate per waste profile in tons. Identifies high-volume waste streams for prioritized management."
    - name: "reactive_waste_profile_count"
      expr: COUNT(CASE WHEN is_reactive = TRUE THEN 1 END)
      comment: "Number of waste profiles with reactive characteristics. Reactive wastes represent the highest safety risk and require specialized handling infrastructure."
$$;