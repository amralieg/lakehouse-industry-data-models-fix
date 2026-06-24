-- Metric views for domain: facility | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 14:47:42

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_bed_status_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bed turnover and status-transition KPIs supporting patient flow, throughput, and discharge-to-clean cycle efficiency."
  source: "`vibe_healthcare_v1`.`facility`.`bed_status_event`"
  dimensions:
    - name: "new_status_code"
      expr: new_status_code
      comment: "Resulting bed status after the event, used to analyze transition patterns."
    - name: "prior_status_code"
      expr: prior_status_code
      comment: "Bed status before the event, enabling transition-pair flow analysis."
    - name: "adt_event_type"
      expr: adt_event_type
      comment: "Admission/discharge/transfer event type driving the status change."
    - name: "bed_assignment_method"
      expr: bed_assignment_method
      comment: "How the bed was assigned (manual vs system), relevant for workflow automation analysis."
    - name: "acuity_level"
      expr: acuity_level
      comment: "Patient acuity at the time of the event for case-mix-adjusted flow analysis."
    - name: "is_emergency_flag"
      expr: is_emergency_flag
      comment: "Whether the event was emergency-driven, separating urgent from elective flow."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of the status event for throughput trending."
  measures:
    - name: "Total Status Events"
      expr: COUNT(1)
      comment: "Total bed status transitions; baseline measure of bed activity and turnover volume."
    - name: "Avg Event Duration Minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration a bed spends in a status; long durations signal flow bottlenecks."
    - name: "Total Event Duration Minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total time across status events, used for aggregate bed-time utilization analysis."
    - name: "Emergency Event Count"
      expr: COUNT(DISTINCT CASE WHEN is_emergency_flag = TRUE THEN bed_status_event_id END)
      comment: "Emergency-driven transitions that stress capacity and inform ED surge planning."
    - name: "Priority Event Count"
      expr: COUNT(DISTINCT CASE WHEN priority_flag = TRUE THEN bed_status_event_id END)
      comment: "High-priority transitions requiring expedited bed turnaround."
    - name: "Distinct Beds Transitioned"
      expr: COUNT(DISTINCT bed_id)
      comment: "Unique beds with status changes, indicating breadth of bed activity in the period."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_environmental_service_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental services (EVS) turnaround KPIs measuring discharge-to-clean efficiency that directly impacts bed availability and patient throughput."
  source: "`vibe_healthcare_v1`.`facility`.`environmental_service_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Current status of the cleaning request used to monitor open vs completed workload."
    - name: "request_type"
      expr: request_type
      comment: "Type of cleaning request (terminal, daily, isolation) for workload segmentation."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority of the request driving SLA expectations and resource allocation."
    - name: "cleaning_protocol_used"
      expr: cleaning_protocol_used
      comment: "Cleaning protocol applied, relevant for infection control compliance analysis."
    - name: "isolation_precaution_type"
      expr: isolation_precaution_type
      comment: "Isolation precaution category affecting cycle time and PPE usage."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month the cleaning request was created for trending EVS demand."
  measures:
    - name: "Total Service Requests"
      expr: COUNT(1)
      comment: "Total EVS requests; baseline of cleaning workload volume."
    - name: "Avg Discharge To Clean Minutes"
      expr: AVG(CAST(discharge_to_clean_cycle_time_minutes AS DOUBLE))
      comment: "Average discharge-to-clean cycle time, a core throughput KPI gating bed availability."
    - name: "Avg Request To Start Minutes"
      expr: AVG(CAST(request_to_start_time_minutes AS DOUBLE))
      comment: "Average time from request to EVS start, indicating responsiveness and staffing adequacy."
    - name: "Avg Work Duration Minutes"
      expr: AVG(CAST(work_duration_minutes AS DOUBLE))
      comment: "Average cleaning work duration informing labor productivity and staffing models."
    - name: "Quality Inspection Pass Count"
      expr: COUNT(DISTINCT CASE WHEN quality_inspection_result = 'Pass' THEN environmental_service_request_id END)
      comment: "Cleanings passing quality inspection, a quality-of-service indicator tied to HAI prevention."
    - name: "Infection Prevention Alert Count"
      expr: COUNT(DISTINCT CASE WHEN infection_prevention_alert_flag = TRUE THEN environmental_service_request_id END)
      comment: "Requests flagged for infection prevention; elevated counts trigger IP intervention."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_maintenance_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facilities and biomedical maintenance KPIs covering cost, downtime, and completion performance that drive asset reliability and capital decisions."
  source: "`vibe_healthcare_v1`.`facility`.`maintenance_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the maintenance order for backlog and completion monitoring."
    - name: "order_type"
      expr: order_type
      comment: "Type of maintenance (corrective, preventive, emergency) for workload mix analysis."
    - name: "priority"
      expr: priority
      comment: "Order priority driving SLA expectations and resource prioritization."
    - name: "trade_type"
      expr: trade_type
      comment: "Trade skill required, used for workforce and vendor planning."
    - name: "regulatory_driver"
      expr: regulatory_driver
      comment: "Whether the order is regulatory-driven, prioritizing compliance-critical maintenance."
    - name: "requested_month"
      expr: DATE_TRUNC('MONTH', request_datetime)
      comment: "Month the maintenance was requested for cost and volume trending."
  measures:
    - name: "Total Maintenance Orders"
      expr: COUNT(1)
      comment: "Total maintenance orders; baseline of facilities workload."
    - name: "Total Maintenance Cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total maintenance spend, a key cost line for facilities budgeting and capital planning."
    - name: "Total Labor Cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost component, informing in-house vs outsourced trade decisions."
    - name: "Total Parts Cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total parts cost, used to assess equipment reliability and replacement timing."
    - name: "Avg Labor Hours"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labor hours per order, a productivity and resource-planning metric."
    - name: "Avg Maintenance Cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per maintenance order to benchmark cost efficiency."
    - name: "Safety Incident Order Count"
      expr: COUNT(DISTINCT CASE WHEN safety_incident_flag = TRUE THEN maintenance_order_id END)
      comment: "Maintenance orders linked to safety incidents, flagging asset reliability risk."
    - name: "Warranty Claim Count"
      expr: COUNT(DISTINCT CASE WHEN warranty_claim_flag = TRUE THEN maintenance_order_id END)
      comment: "Orders eligible for warranty recovery, an avoidable-cost lever for finance."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_equipment_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical and capital equipment portfolio KPIs covering asset value, PM compliance, and recall exposure for capital planning and patient-safety governance."
  source: "`vibe_healthcare_v1`.`facility`.`equipment_asset`"
  dimensions:
    - name: "equipment_category"
      expr: equipment_category
      comment: "Equipment category for portfolio segmentation and capital prioritization."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Specific equipment type for granular asset-class analysis."
    - name: "pm_compliance_status"
      expr: pm_compliance_status
      comment: "Preventive-maintenance compliance status driving safety and regulatory risk."
    - name: "recall_status"
      expr: recall_status
      comment: "Recall status of the asset, a patient-safety governance flag."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category of the equipment used to prioritize maintenance and replacement."
    - name: "fda_device_class"
      expr: fda_device_class
      comment: "FDA device class used for regulatory tracking and risk stratification."
    - name: "acquisition_year"
      expr: DATE_TRUNC('YEAR', acquisition_date)
      comment: "Year the asset was acquired for age and lifecycle analysis."
  measures:
    - name: "Total Equipment Assets"
      expr: COUNT(1)
      comment: "Total tracked equipment assets; baseline for the capital portfolio."
    - name: "Total Acquisition Cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total capitalized acquisition value, a key fixed-asset balance for finance."
    - name: "Avg Acquisition Cost"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average asset cost informing standardization and procurement strategy."
    - name: "PM Compliant Asset Count"
      expr: COUNT(DISTINCT CASE WHEN pm_compliance_status = 'Compliant' THEN equipment_asset_id END)
      comment: "Assets compliant with preventive maintenance; numerator for PM compliance rate."
    - name: "PM Compliance Pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN pm_compliance_status = 'Compliant' THEN equipment_asset_id END) / NULLIF(COUNT(DISTINCT equipment_asset_id), 0), 2)
      comment: "Share of assets meeting PM requirements; core regulatory and patient-safety KPI."
    - name: "Active Recall Asset Count"
      expr: COUNT(DISTINCT CASE WHEN recall_status = 'Open' THEN equipment_asset_id END)
      comment: "Assets under open recall requiring remediation; direct patient-safety risk indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_capacity_snapshot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time capacity and occupancy KPIs supporting throughput command-center decisions, diversion management, and surge planning."
  source: "`vibe_healthcare_v1`.`facility`.`capacity_snapshot`"
  dimensions:
    - name: "snapshot_type"
      expr: snapshot_type
      comment: "Type of capacity snapshot (hourly, daily) for time-grain selection."
    - name: "ambulance_diversion_status"
      expr: ambulance_diversion_status
      comment: "Ambulance diversion status, a critical patient-flow and revenue-loss indicator."
    - name: "ed_bypass_status"
      expr: ed_bypass_status
      comment: "ED bypass status used to monitor emergency department saturation."
    - name: "icu_bypass_status"
      expr: icu_bypass_status
      comment: "ICU bypass status indicating critical-care capacity constraints."
    - name: "snapshot_hour"
      expr: DATE_TRUNC('HOUR', snapshot_timestamp)
      comment: "Hour of the capacity snapshot for intraday occupancy trending."
  measures:
    - name: "Snapshot Count"
      expr: COUNT(1)
      comment: "Number of capacity snapshots; baseline for time-series occupancy analysis."
    - name: "Avg Occupancy Pct"
      expr: AVG(CAST(occupancy_percentage AS DOUBLE))
      comment: "Average occupancy percentage, the headline capacity-management KPI for command centers."
    - name: "Peak Occupancy Pct"
      expr: MAX(CAST(occupancy_percentage AS DOUBLE))
      comment: "Peak observed occupancy, used for surge and diversion threshold planning."
    - name: "Avg OR Utilization Pct"
      expr: AVG(CAST(or_utilization_percentage AS DOUBLE))
      comment: "Average operating-room utilization, a major revenue and efficiency lever."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility safety and OSHA incident KPIs supporting risk management, regulatory reporting, and patient/staff safety governance."
  source: "`vibe_healthcare_v1`.`facility`.`safety_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of safety incident for trend and root-cause analysis."
    - name: "incident_category"
      expr: incident_category
      comment: "Category of incident (patient, staff, visitor) for stakeholder-specific reporting."
    - name: "severity"
      expr: severity
      comment: "Severity classification driving escalation and regulatory reporting thresholds."
    - name: "harm_level"
      expr: harm_level
      comment: "Level of harm caused, central to patient-safety event grading."
    - name: "incident_status"
      expr: incident_status
      comment: "Current investigation/resolution status for open-case management."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of the incident for safety-trend monitoring."
  measures:
    - name: "Total Safety Incidents"
      expr: COUNT(1)
      comment: "Total reported safety incidents; baseline safety-performance metric for boards."
    - name: "OSHA Recordable Count"
      expr: COUNT(DISTINCT CASE WHEN osha_recordable_flag = TRUE THEN safety_incident_id END)
      comment: "OSHA-recordable incidents, a mandated regulatory metric and staff-safety KPI."
    - name: "Near Miss Count"
      expr: COUNT(DISTINCT CASE WHEN near_miss_flag = TRUE THEN safety_incident_id END)
      comment: "Near-miss events; a leading indicator used to prevent future harm."
    - name: "Patient Involved Incident Count"
      expr: COUNT(DISTINCT CASE WHEN patient_involved_flag = TRUE THEN safety_incident_id END)
      comment: "Incidents involving patients, directly tied to patient-safety scores and liability."
    - name: "Total Property Damage Amount"
      expr: SUM(CAST(property_damage_amount AS DOUBLE))
      comment: "Total property damage cost, a financial risk-management metric."
    - name: "Total Days Away From Work"
      expr: SUM(CAST(days_away_from_work AS DOUBLE))
      comment: "Total lost work days, an OSHA severity metric and workforce-cost driver."
    - name: "Workers Comp Claim Count"
      expr: COUNT(DISTINCT CASE WHEN workers_comp_claim_flag = TRUE THEN safety_incident_id END)
      comment: "Incidents generating workers comp claims, a key cost and safety-culture indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory inspection and accreditation survey KPIs supporting Joint Commission/CMS readiness and compliance-risk governance."
  source: "`vibe_healthcare_v1`.`facility`.`inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (TJC, CMS, fire) for regulatory-body segmentation."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection for readiness and follow-up tracking."
    - name: "overall_disposition"
      expr: overall_disposition
      comment: "Overall outcome of the inspection, the headline compliance result."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Authority conducting the inspection for accountability and reporting."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of inspection for compliance-trend analysis."
  measures:
    - name: "Total Inspections"
      expr: COUNT(1)
      comment: "Total inspections conducted; baseline regulatory-activity metric."
    - name: "Total Findings Count"
      expr: SUM(CAST(findings_count AS DOUBLE))
      comment: "Total findings across inspections, the core compliance-deficiency volume metric."
    - name: "Total Immediate Jeopardy Count"
      expr: SUM(CAST(immediate_jeopardy_count AS DOUBLE))
      comment: "Immediate-jeopardy citations, the highest-severity compliance risk requiring executive action."
    - name: "Total Inspection Cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total inspection-related cost for compliance-budget oversight."
    - name: "Follow Up Required Count"
      expr: COUNT(DISTINCT CASE WHEN follow_up_survey_required_flag = TRUE THEN inspection_id END)
      comment: "Inspections requiring follow-up surveys, indicating remediation workload."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_inspection_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection finding remediation KPIs tracking corrective-action progress, penalties, and recurrence for compliance risk reduction."
  source: "`vibe_healthcare_v1`.`facility`.`inspection_finding`"
  dimensions:
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the finding for thematic compliance analysis."
    - name: "severity"
      expr: severity
      comment: "Severity of the finding driving remediation prioritization."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of the finding for open-corrective-action management."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body associated with the finding for accountability."
    - name: "finding_month"
      expr: DATE_TRUNC('MONTH', finding_date)
      comment: "Month the finding was issued for remediation-trend tracking."
  measures:
    - name: "Total Findings"
      expr: COUNT(1)
      comment: "Total inspection findings; baseline of compliance deficiencies."
    - name: "Total Financial Penalty Amount"
      expr: SUM(CAST(financial_penalty_amount AS DOUBLE))
      comment: "Total monetary penalties, a direct financial-risk and compliance KPI."
    - name: "Patient Safety Impact Count"
      expr: COUNT(DISTINCT CASE WHEN patient_safety_impact_flag = TRUE THEN inspection_finding_id END)
      comment: "Findings with patient-safety impact, escalated for clinical-leadership action."
    - name: "Recurrence Count"
      expr: COUNT(DISTINCT CASE WHEN recurrence_flag = TRUE THEN inspection_finding_id END)
      comment: "Recurring findings signaling ineffective prior corrective actions."
    - name: "Medicare Certification Impact Count"
      expr: COUNT(DISTINCT CASE WHEN medicare_certification_impact_flag = TRUE THEN inspection_finding_id END)
      comment: "Findings threatening Medicare certification, a top financial-continuity risk."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_license_accreditation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "License and accreditation portfolio KPIs supporting credential-currency monitoring and payer/regulatory compliance."
  source: "`vibe_healthcare_v1`.`facility`.`license_accreditation`"
  dimensions:
    - name: "credential_type"
      expr: credential_type
      comment: "Type of credential (license, accreditation) for portfolio segmentation."
    - name: "license_accreditation_status"
      expr: license_accreditation_status
      comment: "Current status of the credential for currency and lapse monitoring."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the credential for accountability."
    - name: "deemed_status_flag"
      expr: deemed_status_flag
      comment: "Whether deemed status applies, relevant for CMS participation."
    - name: "issue_year"
      expr: DATE_TRUNC('YEAR', issue_date)
      comment: "Year the credential was issued for lifecycle analysis."
  measures:
    - name: "Total Credentials"
      expr: COUNT(1)
      comment: "Total licenses and accreditations tracked; baseline credential portfolio."
    - name: "Total Deficiency Count"
      expr: SUM(CAST(deficiency_count AS DOUBLE))
      comment: "Total deficiencies across credentials, a compliance-risk volume metric."
    - name: "Payer Contract Required Count"
      expr: COUNT(DISTINCT CASE WHEN payer_contract_requirement_flag = TRUE THEN license_accreditation_id END)
      comment: "Credentials required by payer contracts, where lapse directly threatens revenue."
    - name: "Deemed Status Count"
      expr: COUNT(DISTINCT CASE WHEN deemed_status_flag = TRUE THEN license_accreditation_id END)
      comment: "Credentials carrying deemed status critical to CMS participation."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_block_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operating-room block utilization KPIs supporting surgical capacity optimization, block release governance, and surgeon scheduling decisions."
  source: "`vibe_healthcare_v1`.`facility`.`block_assignment`"
  dimensions:
    - name: "block_type"
      expr: block_type
      comment: "Type of OR block for utilization analysis by block program."
    - name: "block_status"
      expr: block_status
      comment: "Status of the block (active, released) for governance tracking."
    - name: "service_line"
      expr: service_line
      comment: "Surgical service line owning the block for service-level utilization analysis."
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week of the block for scheduling-pattern analysis."
    - name: "block_month"
      expr: DATE_TRUNC('MONTH', block_date)
      comment: "Month of the block for utilization trending."
  measures:
    - name: "Total Block Assignments"
      expr: COUNT(1)
      comment: "Total OR block assignments; baseline of surgical capacity allocation."
    - name: "Avg Block Utilization Pct"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average block utilization, the headline OR-efficiency KPI driving block reallocation."
    - name: "Total Block Minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total allocated block minutes, used to quantify surgical capacity supply."
    - name: "Underutilized Block Count"
      expr: COUNT(DISTINCT CASE WHEN utilization_percentage < minimum_utilization_threshold THEN block_assignment_id END)
      comment: "Blocks below their utilization threshold, candidates for release and reallocation."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_space_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Space allocation and real-estate cost KPIs supporting facilities cost management, space optimization, and chargeback to service lines."
  source: "`vibe_healthcare_v1`.`facility`.`space_allocation`"
  dimensions:
    - name: "space_type"
      expr: space_type
      comment: "Type of space for portfolio segmentation and cost benchmarking."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation for chargeback and occupancy analysis."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of the space allocation for active-portfolio tracking."
    - name: "service_line"
      expr: service_line
      comment: "Service line occupying the space for cost-attribution analysis."
    - name: "allocation_start_month"
      expr: DATE_TRUNC('MONTH', allocation_start_date)
      comment: "Month the allocation began for cost-trend analysis."
  measures:
    - name: "Total Space Allocations"
      expr: COUNT(1)
      comment: "Total space allocations; baseline of the real-estate portfolio."
    - name: "Total Allocated Square Footage"
      expr: SUM(CAST(allocated_square_footage AS DOUBLE))
      comment: "Total allocated square footage, the core space-supply metric for facilities planning."
    - name: "Total Annual Space Cost"
      expr: SUM(CAST(annual_space_cost AS DOUBLE))
      comment: "Total annual occupancy cost, a major facilities expense for budgeting and chargeback."
    - name: "Avg Cost Per Square Foot"
      expr: AVG(CAST(cost_per_square_foot AS DOUBLE))
      comment: "Average cost per square foot to benchmark space efficiency across sites."
    - name: "Avg Occupancy Pct"
      expr: AVG(CAST(occupancy_percentage AS DOUBLE))
      comment: "Average space occupancy, identifying underutilized space for consolidation."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility vendor-contract KPIs supporting spend management, SLA performance oversight, and renewal governance."
  source: "`vibe_healthcare_v1`.`facility`.`contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current contract status for active/expiring portfolio monitoring."
    - name: "service_type"
      expr: service_type
      comment: "Type of service contracted for category-spend analysis."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the contract auto-renews, relevant for renewal-governance review."
    - name: "start_year"
      expr: DATE_TRUNC('YEAR', start_date)
      comment: "Year the contract started for spend and renewal trending."
  measures:
    - name: "Total Contracts"
      expr: COUNT(1)
      comment: "Total facility vendor contracts; baseline of the contract portfolio."
    - name: "Total Annual Spend Amount"
      expr: SUM(CAST(annual_spend_amount AS DOUBLE))
      comment: "Total annual contracted spend, a key facilities cost lever for finance."
    - name: "Total Contract Value Amount"
      expr: SUM(CAST(value_amount AS DOUBLE))
      comment: "Total lifetime contract value for commitment and exposure analysis."
    - name: "Avg SLA Uptime Pct"
      expr: AVG(CAST(sla_uptime_percentage AS DOUBLE))
      comment: "Average SLA uptime delivered by vendors, a service-performance KPI driving renewals."
    - name: "Avg SLA Response Time Hours"
      expr: AVG(CAST(sla_response_time_hours AS DOUBLE))
      comment: "Average SLA response time, a vendor-performance indicator informing contract decisions."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_bed_status_events`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational view of bed status changes to monitor utilization and flow"
  source: "`vibe_healthcare_v1`.`facility`.`bed_status_event`"
  dimensions:
    - name: "bed_id"
      expr: bed_id
      comment: "Unique identifier for the bed"
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where the bed is located"
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of the bed status event"
    - name: "new_status_code"
      expr: new_status_code
      comment: "Resulting status code after the event"
  measures:
    - name: "total_status_events"
      expr: COUNT(1)
      comment: "Total number of bed status events recorded"
    - name: "elective_event_count"
      expr: SUM(CASE WHEN is_elective_flag THEN 1 ELSE 0 END)
      comment: "Count of elective bed status events"
    - name: "emergency_event_count"
      expr: SUM(CASE WHEN is_emergency_flag THEN 1 ELSE 0 END)
      comment: "Count of emergency bed status events"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_bed_occupancy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks bed occupancy trends using periodic capacity snapshots"
  source: "`vibe_healthcare_v1`.`facility`.`capacity_snapshot`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Identifier of the care site (hospital/clinic)"
    - name: "building_id"
      expr: building_id
      comment: "Identifier of the building containing the care site"
    - name: "snapshot_date"
      expr: DATE_TRUNC('day', snapshot_timestamp)
      comment: "Date of the capacity snapshot"
  measures:
    - name: "avg_occupancy_pct"
      expr: AVG(CAST(occupancy_percentage AS DOUBLE))
      comment: "Average occupancy percentage across snapshots for the selected period"
    - name: "snapshot_count"
      expr: COUNT(1)
      comment: "Number of capacity snapshot records"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_inspection_findings`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and compliance view of inspection findings to drive improvement initiatives"
  source: "`vibe_healthcare_v1`.`facility`.`inspection_finding`"
  dimensions:
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the finding"
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the finding (e.g., safety, clinical)"
    - name: "finding_date"
      expr: DATE_TRUNC('day', finding_date)
      comment: "Date the finding was recorded"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of inspection findings recorded"
    - name: "high_severity_findings"
      expr: SUM(CASE WHEN severity_level = 'High' THEN 1 ELSE 0 END)
      comment: "Count of findings classified as high severity"
    - name: "distinct_inspections"
      expr: COUNT(DISTINCT inspection_id)
      comment: "Number of unique inspections that generated findings"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_maintenance_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial view of maintenance activities to support cost control"
  source: "`vibe_healthcare_v1`.`facility`.`maintenance_order`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where maintenance was performed"
    - name: "order_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of the maintenance order creation"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the maintenance order"
  measures:
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost incurred for maintenance orders"
    - name: "avg_maintenance_cost"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average cost per maintenance order"
    - name: "maintenance_order_count"
      expr: COUNT(1)
      comment: "Number of maintenance orders"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`facility_safety_incidents`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety performance view to monitor incident trends and financial impact"
  source: "`vibe_healthcare_v1`.`facility`.`safety_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Classification of the safety incident"
    - name: "incident_date"
      expr: DATE_TRUNC('day', incident_date)
      comment: "Date the incident occurred"
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where the incident was reported"
  measures:
    - name: "incident_count"
      expr: COUNT(1)
      comment: "Total number of safety incidents reported"
    - name: "property_damage_total"
      expr: SUM(CAST(property_damage_amount AS DOUBLE))
      comment: "Aggregate monetary value of property damage from incidents"
$$;