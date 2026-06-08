-- Metric views for domain: facility | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`facility_bed`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bed management metrics tracking capacity, availability, and capability distribution across the facility network for real-time census and capacity planning decisions."
  source: "`healthcare_ecm_v1`.`facility`.`bed`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site identifier for facility-level bed analysis"
    - name: "unit_id"
      expr: unit_id
      comment: "Unit identifier for department-level bed grouping"
    - name: "bed_status"
      expr: bed_status
      comment: "Current bed status (available, occupied, blocked, cleaning) for operational tracking"
    - name: "bed_type"
      expr: bed_type
      comment: "Bed type classification for capacity planning by acuity level"
    - name: "bed_category"
      expr: bed_category
      comment: "Bed category for strategic capacity segmentation"
    - name: "is_active"
      expr: CAST(is_active AS STRING)
      comment: "Active status flag for filtering operational vs decommissioned beds"
    - name: "is_staffed"
      expr: CAST(is_staffed AS STRING)
      comment: "Staffed status indicating whether bed is available for patient placement"
    - name: "is_isolation_capable"
      expr: CAST(is_isolation_capable AS STRING)
      comment: "Isolation capability for infection control capacity planning"
    - name: "is_telemetry_capable"
      expr: CAST(is_telemetry_capable AS STRING)
      comment: "Telemetry capability for cardiac monitoring capacity"
    - name: "is_licensed"
      expr: CAST(is_licensed AS STRING)
      comment: "Licensed status for regulatory compliance reporting"
    - name: "gender_restriction"
      expr: gender_restriction
      comment: "Gender restriction for placement optimization"
    - name: "blocked_reason"
      expr: blocked_reason
      comment: "Reason bed is blocked for root cause analysis of capacity constraints"
  measures:
    - name: "total_beds"
      expr: COUNT(1)
      comment: "Total bed count for capacity baseline measurement"
    - name: "active_licensed_beds"
      expr: COUNT(CASE WHEN is_active = TRUE AND is_licensed = TRUE THEN 1 END)
      comment: "Count of active licensed beds representing regulatory capacity ceiling"
    - name: "staffed_beds"
      expr: COUNT(CASE WHEN is_staffed = TRUE AND is_active = TRUE THEN 1 END)
      comment: "Count of staffed beds representing actual operational capacity available for patient placement"
    - name: "blocked_beds"
      expr: COUNT(CASE WHEN bed_status = 'blocked' THEN 1 END)
      comment: "Count of blocked beds indicating capacity lost to maintenance, staffing, or other constraints"
    - name: "isolation_capable_beds"
      expr: COUNT(CASE WHEN is_isolation_capable = TRUE AND is_active = TRUE THEN 1 END)
      comment: "Count of isolation-capable beds for infection control surge planning"
    - name: "telemetry_capable_beds"
      expr: COUNT(CASE WHEN is_telemetry_capable = TRUE AND is_active = TRUE THEN 1 END)
      comment: "Count of telemetry-capable beds for cardiac monitoring capacity assessment"
    - name: "bariatric_capable_beds"
      expr: COUNT(CASE WHEN is_bariatric_capable = TRUE AND is_active = TRUE THEN 1 END)
      comment: "Count of bariatric-capable beds for specialized patient population capacity"
    - name: "avg_weight_capacity_lbs"
      expr: AVG(CAST(weight_capacity_lbs AS DOUBLE))
      comment: "Average weight capacity across beds for equipment planning"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`facility_capacity_snapshot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time and historical capacity utilization metrics for hospital operations command center, diversion decisions, and surge planning."
  source: "`healthcare_ecm_v1`.`facility`.`capacity_snapshot`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site for facility-level capacity monitoring"
    - name: "unit_id"
      expr: unit_id
      comment: "Unit for department-level capacity drill-down"
    - name: "snapshot_type"
      expr: snapshot_type
      comment: "Snapshot type (scheduled, event-triggered, manual) for data quality assessment"
    - name: "ed_bypass_status"
      expr: ed_bypass_status
      comment: "ED bypass/diversion status for patient flow impact analysis"
    - name: "icu_bypass_status"
      expr: icu_bypass_status
      comment: "ICU bypass status for critical care capacity monitoring"
    - name: "ambulance_diversion_status"
      expr: ambulance_diversion_status
      comment: "Ambulance diversion status for EMS coordination"
    - name: "eoc_activation_status"
      expr: eoc_activation_status
      comment: "Emergency Operations Center activation for surge event tracking"
    - name: "snapshot_date"
      expr: DATE_TRUNC('day', snapshot_timestamp)
      comment: "Snapshot date for daily capacity trend analysis"
    - name: "snapshot_hour"
      expr: HOUR(snapshot_timestamp)
      comment: "Hour of day for intraday capacity pattern identification"
  measures:
    - name: "avg_occupancy_pct"
      expr: AVG(CAST(occupancy_percentage AS DOUBLE))
      comment: "Average occupancy percentage - primary KPI for capacity management; target typically 80-85%"
    - name: "avg_or_utilization_pct"
      expr: AVG(CAST(or_utilization_percentage AS DOUBLE))
      comment: "Average OR utilization percentage for surgical capacity optimization; target typically 75-85%"
    - name: "snapshot_count"
      expr: COUNT(1)
      comment: "Number of capacity snapshots for data completeness monitoring"
    - name: "high_occupancy_events"
      expr: COUNT(CASE WHEN occupancy_percentage >= 95.0 THEN 1 END)
      comment: "Count of snapshots at or above 95% occupancy indicating critical capacity strain"
    - name: "diversion_events"
      expr: COUNT(CASE WHEN ambulance_diversion_status IS NOT NULL AND ambulance_diversion_status != 'none' THEN 1 END)
      comment: "Count of ambulance diversion events indicating severe capacity constraints impacting community access"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`facility_environmental_service_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental services (EVS) performance metrics tracking bed turnaround time, cleaning efficiency, and patient flow impact for throughput optimization."
  source: "`healthcare_ecm_v1`.`facility`.`environmental_service_request`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site for facility-level EVS performance comparison"
    - name: "unit_id"
      expr: unit_id
      comment: "Unit for department-level cleaning workload analysis"
    - name: "request_type"
      expr: request_type
      comment: "Type of cleaning request (discharge, terminal, stat) for workload segmentation"
    - name: "request_status"
      expr: request_status
      comment: "Current request status for workflow bottleneck identification"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for response time SLA monitoring"
    - name: "cleaning_protocol_used"
      expr: cleaning_protocol_used
      comment: "Cleaning protocol for infection control compliance tracking"
    - name: "isolation_precaution_type"
      expr: isolation_precaution_type
      comment: "Isolation precaution type for enhanced cleaning workload analysis"
    - name: "quality_inspection_result"
      expr: quality_inspection_result
      comment: "Quality inspection outcome for cleaning quality monitoring"
    - name: "request_date"
      expr: DATE_TRUNC('day', request_timestamp)
      comment: "Request date for daily volume trending"
  measures:
    - name: "total_requests"
      expr: COUNT(1)
      comment: "Total EVS requests for workload volume tracking"
    - name: "avg_discharge_to_clean_minutes"
      expr: AVG(CAST(discharge_to_clean_cycle_time_minutes AS DOUBLE))
      comment: "Average discharge-to-clean cycle time in minutes - critical KPI for bed turnaround and patient throughput"
    - name: "avg_work_duration_minutes"
      expr: AVG(CAST(work_duration_minutes AS DOUBLE))
      comment: "Average cleaning work duration for labor efficiency and staffing model optimization"
    - name: "avg_request_to_start_minutes"
      expr: AVG(CAST(request_to_start_time_minutes AS DOUBLE))
      comment: "Average time from request to start of cleaning - measures EVS response time SLA compliance"
    - name: "quality_inspections_performed"
      expr: COUNT(CASE WHEN quality_inspection_performed_flag = TRUE THEN 1 END)
      comment: "Count of quality inspections performed for compliance rate calculation"
    - name: "quality_inspection_pass_count"
      expr: COUNT(CASE WHEN quality_inspection_result = 'pass' THEN 1 END)
      comment: "Count of passed quality inspections for cleanliness quality rate"
    - name: "infection_prevention_alerts"
      expr: COUNT(CASE WHEN infection_prevention_alert_flag = TRUE THEN 1 END)
      comment: "Count of infection prevention alerts for HAI risk monitoring"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`facility_maintenance_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility maintenance performance metrics tracking work order completion, costs, equipment downtime, and preventive maintenance compliance for asset management and regulatory readiness."
  source: "`healthcare_ecm_v1`.`facility`.`maintenance_order`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site for facility-level maintenance performance comparison"
    - name: "order_type"
      expr: order_type
      comment: "Order type (preventive, corrective, emergency) for maintenance strategy analysis"
    - name: "order_status"
      expr: order_status
      comment: "Order status for backlog and completion tracking"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for response time and resource allocation analysis"
    - name: "trade_type"
      expr: trade_type
      comment: "Trade type (electrical, plumbing, HVAC, biomedical) for workforce planning"
    - name: "vendor_service_flag"
      expr: CAST(vendor_service_flag AS STRING)
      comment: "Whether vendor performed service for insource vs outsource cost analysis"
    - name: "safety_incident_flag"
      expr: CAST(safety_incident_flag AS STRING)
      comment: "Safety incident association for risk-based maintenance prioritization"
    - name: "regulatory_driver"
      expr: regulatory_driver
      comment: "Regulatory requirement driving the maintenance for compliance tracking"
    - name: "request_month"
      expr: DATE_TRUNC('month', request_datetime)
      comment: "Request month for maintenance volume trending"
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total maintenance work orders for workload volume assessment"
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total maintenance cost (labor + parts) for budget management and cost-per-bed analysis"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost for workforce cost management"
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total parts cost for inventory and procurement planning"
    - name: "avg_labor_hours"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labor hours per work order for productivity benchmarking"
    - name: "emergency_work_orders"
      expr: COUNT(CASE WHEN order_type = 'emergency' THEN 1 END)
      comment: "Count of emergency work orders indicating reactive maintenance burden and potential safety risks"
    - name: "preventive_work_orders"
      expr: COUNT(CASE WHEN order_type = 'preventive' THEN 1 END)
      comment: "Count of preventive maintenance work orders for PM compliance rate calculation"
    - name: "safety_related_orders"
      expr: COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END)
      comment: "Count of safety-incident-related work orders for risk management reporting"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`facility_equipment_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical equipment asset management metrics tracking fleet value, maintenance compliance, recall status, and lifecycle for capital planning and patient safety."
  source: "`healthcare_ecm_v1`.`facility`.`equipment_asset`"
  dimensions:
    - name: "current_location_care_site_id"
      expr: current_location_care_site_id
      comment: "Current location care site for equipment distribution analysis"
    - name: "equipment_category"
      expr: equipment_category
      comment: "Equipment category for fleet composition analysis"
    - name: "equipment_type"
      expr: equipment_type
      comment: "Equipment type for detailed asset class management"
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status for availability and downtime tracking"
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category for risk-based maintenance prioritization per Joint Commission"
    - name: "fda_device_class"
      expr: fda_device_class
      comment: "FDA device class for regulatory compliance segmentation"
    - name: "pm_compliance_status"
      expr: pm_compliance_status
      comment: "Preventive maintenance compliance status for Joint Commission readiness"
    - name: "recall_status"
      expr: recall_status
      comment: "Recall status for patient safety and remediation tracking"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method for financial reporting alignment"
  measures:
    - name: "total_assets"
      expr: COUNT(1)
      comment: "Total equipment asset count for fleet size management"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost representing capital investment in medical equipment fleet"
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per asset for replacement budgeting"
    - name: "assets_in_recall"
      expr: COUNT(CASE WHEN recall_status IS NOT NULL AND recall_status != 'none' AND recall_status != 'resolved' THEN 1 END)
      comment: "Count of assets in active recall status requiring remediation for patient safety"
    - name: "pm_overdue_assets"
      expr: COUNT(CASE WHEN pm_compliance_status = 'overdue' THEN 1 END)
      comment: "Count of assets with overdue preventive maintenance - critical for Joint Commission compliance"
    - name: "calibration_required_assets"
      expr: COUNT(CASE WHEN calibration_required_flag = TRUE THEN 1 END)
      comment: "Count of assets requiring calibration for measurement accuracy compliance"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`facility_block_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operating room block utilization metrics for surgical capacity optimization, provider scheduling efficiency, and revenue maximization from OR time allocation."
  source: "`healthcare_ecm_v1`.`facility`.`block_assignment`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site for facility-level OR block analysis"
    - name: "or_suite_id"
      expr: or_suite_id
      comment: "OR suite for room-level utilization tracking"
    - name: "block_type"
      expr: block_type
      comment: "Block type (allocated, open, emergency reserve) for scheduling strategy analysis"
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week for scheduling pattern optimization"
    - name: "priority_level"
      expr: priority_level
      comment: "Block priority level for allocation governance"
    - name: "provider_assignment_status"
      expr: provider_assignment_status
      comment: "Provider assignment status for block release and reallocation decisions"
  measures:
    - name: "total_block_assignments"
      expr: COUNT(1)
      comment: "Total block assignments for OR scheduling volume assessment"
    - name: "avg_utilization_threshold_pct"
      expr: AVG(CAST(utilization_threshold_pct AS DOUBLE))
      comment: "Average utilization threshold percentage set for block governance - indicates how aggressively blocks are managed"
    - name: "unassigned_blocks"
      expr: COUNT(CASE WHEN provider_assignment_status = 'unassigned' OR provider_assignment_status IS NULL THEN 1 END)
      comment: "Count of unassigned blocks representing potential lost surgical revenue opportunity"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`facility_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory inspection and accreditation survey metrics for compliance readiness, deficiency trending, and survey outcome tracking critical for Medicare certification and Joint Commission accreditation."
  source: "`healthcare_ecm_v1`.`facility`.`facility_inspection`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site for facility-level inspection history"
    - name: "facility_inspection_type"
      expr: facility_inspection_type
      comment: "Inspection type (CMS survey, Joint Commission, state DOH, fire marshal) for regulatory body analysis"
    - name: "facility_inspection_status"
      expr: facility_inspection_status
      comment: "Inspection status for workflow tracking"
    - name: "overall_disposition"
      expr: overall_disposition
      comment: "Overall inspection disposition (pass, conditional, fail) for outcome trending"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority conducting inspection for compliance program management"
    - name: "accreditation_decision"
      expr: accreditation_decision
      comment: "Accreditation decision outcome for strategic accreditation management"
    - name: "complaint_based_flag"
      expr: CAST(complaint_based_flag AS STRING)
      comment: "Whether inspection was complaint-triggered for risk pattern identification"
    - name: "inspection_year"
      expr: YEAR(facility_inspection_date)
      comment: "Inspection year for annual compliance trending"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total inspection count for regulatory activity volume"
    - name: "total_findings"
      expr: SUM(CAST(findings_count AS INT))
      comment: "Total findings across inspections for deficiency burden assessment"
    - name: "total_immediate_jeopardy"
      expr: SUM(CAST(immediate_jeopardy_count AS INT))
      comment: "Total immediate jeopardy findings - most severe CMS citation threatening Medicare certification"
    - name: "total_condition_level"
      expr: SUM(CAST(condition_level_count AS INT))
      comment: "Total condition-level deficiencies requiring plan of correction for CMS compliance"
    - name: "complaint_based_inspections"
      expr: COUNT(CASE WHEN complaint_based_flag = TRUE THEN 1 END)
      comment: "Count of complaint-triggered inspections indicating potential systemic quality issues"
    - name: "total_inspection_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total inspection-related costs for compliance budget management"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`facility_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility safety incident metrics for workplace safety management, OSHA compliance, regulatory reporting, and risk reduction initiatives."
  source: "`healthcare_ecm_v1`.`facility`.`safety_incident`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site for facility-level safety performance comparison"
    - name: "unit_id"
      expr: unit_id
      comment: "Unit for department-level safety hotspot identification"
    - name: "incident_type"
      expr: incident_type
      comment: "Incident type (slip/fall, needlestick, chemical exposure, violence) for prevention targeting"
    - name: "incident_status"
      expr: incident_status
      comment: "Incident status for open investigation tracking"
    - name: "injury_severity"
      expr: injury_severity
      comment: "Injury severity for risk stratification and workers comp impact"
    - name: "osha_300_log_required_flag"
      expr: CAST(osha_300_log_required_flag AS STRING)
      comment: "OSHA 300 log requirement for regulatory reporting compliance"
    - name: "cms_immediate_jeopardy_flag"
      expr: CAST(cms_immediate_jeopardy_flag AS STRING)
      comment: "CMS immediate jeopardy flag for highest-severity regulatory events"
    - name: "incident_month"
      expr: DATE_TRUNC('month', incident_timestamp)
      comment: "Incident month for safety trending"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total safety incidents for overall safety performance KPI"
    - name: "incidents_with_injury"
      expr: COUNT(CASE WHEN injuries_sustained_flag = TRUE THEN 1 END)
      comment: "Count of incidents resulting in injury for severity-weighted safety analysis"
    - name: "osha_recordable_incidents"
      expr: COUNT(CASE WHEN osha_300_log_required_flag = TRUE THEN 1 END)
      comment: "OSHA recordable incidents for OSHA 300 log compliance and DART rate calculation"
    - name: "cms_immediate_jeopardy_incidents"
      expr: COUNT(CASE WHEN cms_immediate_jeopardy_flag = TRUE THEN 1 END)
      comment: "CMS immediate jeopardy incidents - most severe regulatory events threatening Medicare participation"
    - name: "total_property_damage"
      expr: SUM(CAST(property_damage_amount AS DOUBLE))
      comment: "Total property damage amount for financial impact of safety events"
    - name: "root_cause_completed"
      expr: COUNT(CASE WHEN root_cause_analysis_completed_flag = TRUE THEN 1 END)
      comment: "Count of incidents with completed root cause analysis for learning organization maturity assessment"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`facility_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility contract and vendor management metrics for spend optimization, SLA compliance, and contract lifecycle governance."
  source: "`healthcare_ecm_v1`.`facility`.`facility_contract`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site for facility-level contract portfolio analysis"
    - name: "facility_contract_status"
      expr: facility_contract_status
      comment: "Contract status for lifecycle management"
    - name: "facility_service_type"
      expr: facility_service_type
      comment: "Service type for spend category analysis"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for cash flow management"
    - name: "auto_renewal_flag"
      expr: CAST(auto_renewal_flag AS STRING)
      comment: "Auto-renewal flag for contract governance and renegotiation planning"
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total facility contracts for portfolio size management"
    - name: "total_contract_value"
      expr: SUM(CAST(value_amount AS DOUBLE))
      comment: "Total contract value for facility services spend management"
    - name: "total_annual_spend"
      expr: SUM(CAST(annual_spend_amount AS DOUBLE))
      comment: "Total annual spend across facility contracts for budget planning"
    - name: "avg_sla_uptime_pct"
      expr: AVG(CAST(sla_uptime_percentage AS DOUBLE))
      comment: "Average SLA uptime percentage for vendor performance management"
    - name: "avg_sla_response_hours"
      expr: AVG(CAST(sla_response_time_hours AS DOUBLE))
      comment: "Average SLA response time in hours for vendor responsiveness benchmarking"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`facility_bed_status_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bed status transition event metrics for patient flow optimization, turnaround time analysis, and real-time bed management operations."
  source: "`healthcare_ecm_v1`.`facility`.`bed_status_event`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site for facility-level bed flow analysis"
    - name: "primary_bed_unit_id"
      expr: primary_bed_unit_id
      comment: "Unit for department-level bed transition tracking"
    - name: "new_status_code"
      expr: new_status_code
      comment: "New bed status for transition pattern analysis"
    - name: "prior_status_code"
      expr: prior_status_code
      comment: "Prior bed status for transition flow mapping"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for status change root cause analysis"
    - name: "adt_event_type"
      expr: adt_event_type
      comment: "ADT event type (admit, discharge, transfer) driving the status change"
    - name: "acuity_level"
      expr: acuity_level
      comment: "Patient acuity level for capacity-by-acuity analysis"
    - name: "is_emergency_flag"
      expr: CAST(is_emergency_flag AS STRING)
      comment: "Emergency flag for urgent vs planned bed need segmentation"
    - name: "event_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Event date for daily bed transition volume trending"
  measures:
    - name: "total_status_events"
      expr: COUNT(1)
      comment: "Total bed status transition events for patient flow volume measurement"
    - name: "emergency_events"
      expr: COUNT(CASE WHEN is_emergency_flag = TRUE THEN 1 END)
      comment: "Count of emergency bed status events for unplanned demand quantification"
    - name: "priority_events"
      expr: COUNT(CASE WHEN priority_flag = TRUE THEN 1 END)
      comment: "Count of priority bed events for escalation frequency monitoring"
$$;