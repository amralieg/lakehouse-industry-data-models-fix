-- Metric views for domain: technology | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-22 23:42:33

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_broadcast_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and capacity metrics for broadcast facilities — supports infrastructure investment decisions, redundancy planning, and facility utilisation reviews."
  source: "`vibe_media_broadcasting_v1`.`technology`.`broadcast_facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of broadcast facility (e.g. master control, transmitter site, studio hub) for segmenting capacity and cost analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the facility (active, decommissioned, under maintenance) for availability reporting."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Whether the facility is owned, leased, or co-located — drives capex vs opex classification."
    - name: "redundancy_tier"
      expr: redundancy_tier
      comment: "Redundancy tier (N, N+1, 2N) indicating resilience level for risk and compliance dashboards."
    - name: "country_code"
      expr: country_code
      comment: "Country where the facility is located for geographic distribution analysis."
    - name: "commissioning_date"
      expr: DATE_TRUNC('year', commissioning_date)
      comment: "Year the facility was commissioned, used to track fleet age and refresh cycles."
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of broadcast facilities — baseline fleet size KPI for infrastructure planning."
    - name: "total_power_capacity_kva"
      expr: SUM(CAST(power_capacity_kva AS DOUBLE))
      comment: "Aggregate power capacity in KVA across all facilities — critical for energy planning and redundancy assessments."
    - name: "avg_power_capacity_kva"
      expr: AVG(CAST(power_capacity_kva AS DOUBLE))
      comment: "Average power capacity per facility — benchmarks facility sizing against industry norms."
    - name: "total_transmission_power_kw"
      expr: SUM(CAST(transmission_power_kw AS DOUBLE))
      comment: "Total transmission power output in KW — indicates broadcast reach and regulatory compliance with licensed power limits."
    - name: "total_floor_area_sqm"
      expr: SUM(CAST(total_floor_area_sqm AS DOUBLE))
      comment: "Total physical footprint in square metres — informs real estate cost allocation and expansion planning."
    - name: "avg_network_connectivity_gbps"
      expr: AVG(CAST(network_connectivity_gbps AS DOUBLE))
      comment: "Average network connectivity capacity per facility in Gbps — flags facilities at risk of bandwidth bottlenecks."
    - name: "total_backup_power_duration_hours"
      expr: SUM(CAST(backup_power_duration_hours AS DOUBLE))
      comment: "Aggregate backup power duration across facilities — resilience metric for disaster recovery planning."
    - name: "avg_antenna_height_meters"
      expr: AVG(CAST(antenna_height_meters AS DOUBLE))
      comment: "Average antenna height in metres — proxy for signal coverage capability and regulatory compliance."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_outage_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Broadcast infrastructure outage analytics — the primary operational reliability KPI view used by NOC leadership, engineering VPs, and the CTO to track uptime, revenue impact, and SLA compliance."
  source: "`vibe_media_broadcasting_v1`.`technology`.`outage_record`"
  dimensions:
    - name: "outage_type"
      expr: outage_type_id
      comment: "Category of outage (planned, unplanned, partial) for root-cause trend analysis."
    - name: "impact_severity"
      expr: impact_severity
      comment: "Severity classification of the outage (critical, major, minor) for prioritisation and escalation reporting."
    - name: "affected_service_name"
      expr: affected_service_name
      comment: "Name of the affected broadcast service — identifies which channels or platforms were impacted."
    - name: "affected_geographic_region"
      expr: affected_geographic_region
      comment: "Geographic region affected — supports regional reliability benchmarking and regulatory reporting."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the outage breached the SLA target — key compliance and vendor accountability dimension."
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Whether the outage requires regulatory reporting (e.g. FCC/Ofcom) — compliance tracking dimension."
    - name: "detection_month"
      expr: DATE_TRUNC('month', detection_timestamp)
      comment: "Month the outage was detected — enables trend analysis of outage frequency over time."
  measures:
    - name: "total_outages"
      expr: COUNT(1)
      comment: "Total number of outage events — primary reliability frequency KPI for NOC and engineering leadership."
    - name: "total_outage_duration_minutes"
      expr: SUM(CAST(outage_duration_minutes AS DOUBLE))
      comment: "Total cumulative outage duration in minutes — directly measures broadcast downtime and SLA exposure."
    - name: "avg_outage_duration_minutes"
      expr: AVG(CAST(outage_duration_minutes AS DOUBLE))
      comment: "Average outage duration per incident — benchmarks mean time to restore (MTTR) against SLA targets."
    - name: "total_estimated_revenue_impact"
      expr: SUM(CAST(estimated_revenue_impact_amount AS DOUBLE))
      comment: "Total estimated revenue impact from outages in reporting currency — quantifies financial risk of infrastructure failures for CFO and CTO review."
    - name: "avg_estimated_revenue_impact"
      expr: AVG(CAST(estimated_revenue_impact_amount AS DOUBLE))
      comment: "Average revenue impact per outage event — helps prioritise investment in redundancy for highest-value services."
    - name: "total_sla_breach_outages"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of outages that breached SLA targets — vendor accountability and contract penalty trigger metric."
    - name: "total_regulatory_reportable_outages"
      expr: COUNT(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 END)
      comment: "Number of outages requiring regulatory reporting — compliance risk KPI for legal and regulatory affairs teams."
    - name: "total_affected_viewers_estimate"
      expr: SUM(CAST(affected_viewer_count_estimate AS DOUBLE))
      comment: "Total estimated viewer impact across all outages — audience disruption metric used in subscriber churn and brand risk analysis."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_maintenance_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance operations efficiency metrics — tracks work order throughput, cost, labour utilisation, and SLA compliance for broadcast infrastructure maintenance programmes."
  source: "`vibe_media_broadcasting_v1`.`technology`.`maintenance_work_order`"
  dimensions:
    - name: "work_order_type"
      expr: work_order_type_id
      comment: "Type of maintenance work order (preventive, corrective, emergency) for maintenance strategy analysis."
    - name: "priority"
      expr: priority
      comment: "Work order priority level — used to assess whether high-priority maintenance is being completed on time."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Whether the work order was completed within SLA — key maintenance quality dimension."
    - name: "outage_required_flag"
      expr: outage_required_flag
      comment: "Whether the maintenance required a service outage — impacts scheduling and viewer experience planning."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Whether a safety incident occurred during maintenance — workforce safety and liability tracking."
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Whether a warranty claim was filed — tracks vendor accountability and cost recovery."
    - name: "scheduled_month"
      expr: DATE_TRUNC('month', scheduled_start_datetime)
      comment: "Month the work order was scheduled — enables maintenance volume trend analysis."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of maintenance work orders — baseline throughput KPI for maintenance operations management."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labour cost across all work orders — primary maintenance cost driver for budget management."
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost_amount AS DOUBLE))
      comment: "Total parts and materials cost — tracks consumable spend and informs spare parts inventory strategy."
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_cost_amount AS DOUBLE))
      comment: "Total all-in maintenance cost (labour + parts) — comprehensive cost KPI for maintenance budget vs actuals reporting."
    - name: "avg_maintenance_cost_per_order"
      expr: AVG(CAST(total_cost_amount AS DOUBLE))
      comment: "Average cost per work order — benchmarks maintenance efficiency and identifies cost outliers."
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labour hours expended on maintenance — workforce utilisation and capacity planning metric."
    - name: "avg_labor_hours_per_order"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labour hours per work order — efficiency benchmark for maintenance crew sizing."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Total broadcast downtime caused by maintenance activities — balances planned maintenance against availability targets."
    - name: "total_sla_compliant_orders"
      expr: COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END)
      comment: "Number of work orders completed within SLA — maintenance quality and vendor performance KPI."
    - name: "total_safety_incidents"
      expr: COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END)
      comment: "Number of work orders with associated safety incidents — workforce safety KPI with direct legal and regulatory implications."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_tech_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technology incident management KPIs — tracks incident volume, resolution speed, SLA compliance, and escalation patterns to drive ITSM maturity and broadcast reliability improvements."
  source: "`vibe_media_broadcasting_v1`.`technology`.`tech_incident`"
  dimensions:
    - name: "incident_category"
      expr: incident_category_id
      comment: "Category of the technology incident (network, hardware, software, broadcast signal) for root-cause trend analysis."
    - name: "severity"
      expr: severity
      comment: "Incident severity level (P1-P4) — primary triage dimension for executive escalation and SLA tracking."
    - name: "priority"
      expr: priority
      comment: "Incident priority classification — used to assess whether critical incidents receive appropriate response speed."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the incident breached its SLA target — key ITSM quality and vendor accountability dimension."
    - name: "post_incident_review_flag"
      expr: post_incident_review_flag
      comment: "Whether a post-incident review was conducted — quality assurance dimension for major incident management."
    - name: "workaround_applied"
      expr: workaround_applied
      comment: "Whether a workaround was applied rather than a permanent fix — technical debt and problem management indicator."
    - name: "reported_month"
      expr: DATE_TRUNC('month', reported_timestamp)
      comment: "Month the incident was reported — enables incident volume trend analysis over time."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of technology incidents — primary ITSM volume KPI for NOC and engineering leadership."
    - name: "total_sla_breached_incidents"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of incidents that breached SLA — vendor accountability and service quality KPI directly tied to contract penalties."
    - name: "total_p1_incidents"
      expr: COUNT(CASE WHEN severity = 'P1' THEN 1 END)
      comment: "Number of critical (P1) incidents — highest-priority reliability metric reviewed at executive level."
    - name: "total_post_incident_reviews_conducted"
      expr: COUNT(CASE WHEN post_incident_review_flag = TRUE THEN 1 END)
      comment: "Number of incidents with completed post-incident reviews — measures ITSM process maturity and continuous improvement discipline."
    - name: "total_workaround_only_resolutions"
      expr: COUNT(CASE WHEN workaround_applied = TRUE THEN 1 END)
      comment: "Number of incidents resolved only via workaround — technical debt indicator flagging unresolved root causes that may recur."
    - name: "distinct_affected_channels"
      expr: COUNT(DISTINCT affected_channel_id)
      comment: "Number of distinct broadcast channels affected by incidents — measures breadth of service disruption for scheduling and distribution impact assessment."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_sla_performance_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technology SLA performance analytics — the definitive view for measuring infrastructure service level attainment, breach frequency, downtime, and remediation effectiveness used in vendor reviews and executive reporting."
  source: "`vibe_media_broadcasting_v1`.`technology`.`sla_performance_record`"
  dimensions:
    - name: "breach_flag"
      expr: breach_flag
      comment: "Whether the measurement period recorded an SLA breach — primary compliance dimension for vendor and internal SLA reviews."
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity of the SLA breach — used to prioritise remediation and assess financial penalty exposure."
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required
      comment: "Whether the SLA performance record requires regulatory reporting — compliance tracking dimension."
    - name: "service_credit_applicable"
      expr: service_credit_applicable
      comment: "Whether a service credit is applicable for the breach — financial recovery and vendor accountability dimension."
    - name: "measurement_period_month"
      expr: DATE_TRUNC('month', measurement_period_start)
      comment: "Month of the SLA measurement period — enables trend analysis of service level attainment over time."
    - name: "tech_sla_id"
      expr: tech_sla_id
      comment: "Reference to the specific SLA being measured — enables per-SLA performance benchmarking."
  measures:
    - name: "total_sla_measurement_periods"
      expr: COUNT(1)
      comment: "Total number of SLA measurement periods evaluated — baseline coverage KPI for SLA governance completeness."
    - name: "total_sla_breaches"
      expr: COUNT(CASE WHEN breach_flag = TRUE THEN 1 END)
      comment: "Total number of SLA breach events — primary vendor accountability and contract management KPI."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(total_downtime_minutes AS DOUBLE))
      comment: "Total cumulative downtime in minutes across all SLA measurement periods — quantifies infrastructure unavailability for executive and regulatory reporting."
    - name: "avg_measured_availability_pct"
      expr: AVG(CAST(measured_availability_percentage AS DOUBLE))
      comment: "Average measured availability percentage across all SLA periods — headline uptime KPI for CTO and board reporting."
    - name: "avg_actual_mttr_minutes"
      expr: AVG(CAST(actual_mttr_minutes AS DOUBLE))
      comment: "Average actual mean time to restore in minutes — operational efficiency KPI benchmarked against SLA MTTR targets."
    - name: "total_breach_duration_minutes"
      expr: SUM(CAST(breach_duration_minutes AS DOUBLE))
      comment: "Total duration of SLA breaches in minutes — quantifies the magnitude of service level failures for penalty calculation."
    - name: "total_service_credit_amount"
      expr: SUM(CAST(service_credit_amount AS DOUBLE))
      comment: "Total service credits earned from SLA breaches — financial recovery KPI for vendor contract management and P&L impact."
    - name: "avg_target_availability_pct"
      expr: AVG(CAST(target_availability_percentage AS DOUBLE))
      comment: "Average SLA target availability percentage — baseline for gap analysis against measured availability."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_tech_change_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IT change management analytics — tracks change request volume, approval rates, implementation outcomes, and risk distribution to support CAB governance and change-induced incident reduction."
  source: "`vibe_media_broadcasting_v1`.`technology`.`tech_change_request`"
  dimensions:
    - name: "change_category"
      expr: change_category_id
      comment: "Category of the change request (infrastructure, software, network, broadcast) for change portfolio analysis."
    - name: "change_status"
      expr: change_status_id
      comment: "Current status of the change request (submitted, approved, implemented, rolled back) for pipeline visibility."
    - name: "cab_approval_status"
      expr: cab_approval_status_id
      comment: "CAB (Change Advisory Board) approval status — governance quality dimension for change management maturity."
    - name: "priority"
      expr: priority
      comment: "Priority of the change request — used to assess whether high-priority changes are being expedited appropriately."
    - name: "downtime_required"
      expr: downtime_required
      comment: "Whether the change requires a service outage — impacts scheduling and viewer experience planning."
    - name: "submitted_month"
      expr: DATE_TRUNC('month', submitted_timestamp)
      comment: "Month the change request was submitted — enables change volume trend analysis."
  measures:
    - name: "total_change_requests"
      expr: COUNT(1)
      comment: "Total number of change requests submitted — baseline change management throughput KPI."
    - name: "total_actual_effort_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE))
      comment: "Total actual effort hours expended on change implementation — workforce utilisation and project cost tracking."
    - name: "total_estimated_effort_hours"
      expr: SUM(CAST(estimated_effort_hours AS DOUBLE))
      comment: "Total estimated effort hours for planned changes — capacity planning and resource allocation KPI."
    - name: "avg_actual_effort_hours"
      expr: AVG(CAST(actual_effort_hours AS DOUBLE))
      comment: "Average actual effort per change request — efficiency benchmark for change implementation planning."
    - name: "total_downtime_required_changes"
      expr: COUNT(CASE WHEN downtime_required = TRUE THEN 1 END)
      comment: "Number of changes requiring service downtime — scheduling risk KPI for broadcast continuity planning."
    - name: "distinct_facilities_with_changes"
      expr: COUNT(DISTINCT broadcast_facility_id)
      comment: "Number of distinct broadcast facilities with active change requests — measures change activity breadth across the infrastructure estate."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_equipment_procurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technology equipment procurement analytics — tracks spend, delivery performance, and procurement pipeline to support capex governance, vendor management, and asset refresh planning."
  source: "`vibe_media_broadcasting_v1`.`technology`.`equipment_procurement`"
  dimensions:
    - name: "procurement_type"
      expr: procurement_type_id
      comment: "Type of procurement (purchase, lease, rental) — drives capex vs opex classification for financial reporting."
    - name: "procurement_status"
      expr: procurement_status_id
      comment: "Current status of the procurement (requisitioned, ordered, delivered, cancelled) for pipeline visibility."
    - name: "approval_status"
      expr: approval_status_id
      comment: "Approval status of the procurement request — governance and budget control dimension."
    - name: "goods_receipt_confirmed"
      expr: goods_receipt_confirmed
      comment: "Whether goods have been received and confirmed — delivery completion dimension for accounts payable and asset activation."
    - name: "order_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month the purchase order was placed — enables procurement spend trend analysis."
    - name: "equipment_category"
      expr: equipment_category_id
      comment: "Category of equipment being procured (transmission, IT, studio) for spend-by-category analysis."
  measures:
    - name: "total_procurement_orders"
      expr: COUNT(1)
      comment: "Total number of equipment procurement orders — baseline procurement activity KPI."
    - name: "total_procurement_spend"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total procurement spend across all orders — primary capex/opex KPI for technology budget management and board reporting."
    - name: "total_unit_cost"
      expr: SUM(CAST(unit_cost AS DOUBLE))
      comment: "Sum of unit costs across all procurement lines — supports average unit cost benchmarking and vendor price analysis."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per procurement order — vendor price benchmarking and cost efficiency KPI."
    - name: "total_shipping_cost"
      expr: SUM(CAST(shipping_cost AS DOUBLE))
      comment: "Total shipping and logistics cost — identifies logistics spend optimisation opportunities."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax paid on equipment procurement — tax liability tracking for finance and compliance reporting."
    - name: "total_pending_delivery_orders"
      expr: COUNT(CASE WHEN goods_receipt_confirmed = FALSE THEN 1 END)
      comment: "Number of orders awaiting goods receipt confirmation — open procurement pipeline KPI for asset activation planning."
    - name: "distinct_vendor_partners"
      expr: COUNT(DISTINCT partner_id)
      comment: "Number of distinct vendors used for equipment procurement — vendor concentration risk and diversification metric."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_vendor_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technology vendor contract portfolio analytics — tracks contract value, renewal exposure, SLA commitments, and auto-renewal risk to support vendor management and procurement governance."
  source: "`vibe_media_broadcasting_v1`.`technology`.`vendor_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type_id
      comment: "Type of vendor contract (maintenance, SaaS, managed service, hardware support) for portfolio segmentation."
    - name: "contract_status"
      expr: contract_status_id
      comment: "Current contract status (active, expired, under negotiation) for contract lifecycle management."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the contract auto-renews — risk dimension for contracts that may renew without explicit approval."
    - name: "sla_tier"
      expr: sla_tier_id
      comment: "SLA tier of the vendor contract — used to segment contracts by service level commitment for performance benchmarking."
    - name: "contract_start_year"
      expr: DATE_TRUNC('year', start_date)
      comment: "Year the contract commenced — enables contract vintage analysis and renewal wave planning."
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of active vendor contracts — baseline vendor portfolio size KPI for procurement governance."
    - name: "total_annual_contract_value"
      expr: SUM(CAST(annual_value AS DOUBLE))
      comment: "Total annual value of all vendor contracts — primary technology vendor spend KPI for CFO and CTO budget reviews."
    - name: "avg_annual_contract_value"
      expr: AVG(CAST(annual_value AS DOUBLE))
      comment: "Average annual contract value — benchmarks vendor deal size and identifies outlier contracts for renegotiation."
    - name: "total_auto_renewal_contracts"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Number of contracts set to auto-renew — procurement governance KPI flagging contracts requiring proactive review before renewal."
    - name: "avg_uptime_guarantee_pct"
      expr: AVG(CAST(uptime_guarantee_percent AS DOUBLE))
      comment: "Average uptime guarantee percentage across vendor contracts — benchmarks vendor SLA commitments against actual performance."
    - name: "avg_response_time_hours"
      expr: AVG(CAST(response_time_hours AS DOUBLE))
      comment: "Average contractual response time in hours — vendor SLA quality benchmark for incident management planning."
    - name: "distinct_vendors"
      expr: COUNT(DISTINCT partner_id)
      comment: "Number of distinct vendors under contract — vendor concentration risk metric for supply chain resilience analysis."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_capacity_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Infrastructure capacity planning analytics — tracks utilisation levels, growth projections, and investment requirements to support proactive capacity management and capex planning."
  source: "`vibe_media_broadcasting_v1`.`technology`.`capacity_plan`"
  dimensions:
    - name: "infrastructure_domain"
      expr: infrastructure_domain
      comment: "Infrastructure domain being planned (network, storage, compute, power) for domain-specific capacity analysis."
    - name: "implementation_priority"
      expr: implementation_priority
      comment: "Priority of the capacity expansion action — used to sequence investments and manage budget allocation."
    - name: "approval_status"
      expr: approval_status_id
      comment: "Approval status of the capacity plan — governance dimension for capex approval tracking."
    - name: "planning_period_type"
      expr: planning_period_type_id
      comment: "Planning horizon type (quarterly, annual, 3-year) for aligning capacity plans with budget cycles."
    - name: "plan_year"
      expr: DATE_TRUNC('year', planning_start_date)
      comment: "Year the capacity planning period begins — enables multi-year capacity investment trend analysis."
  measures:
    - name: "total_capacity_plans"
      expr: COUNT(1)
      comment: "Total number of active capacity plans — baseline infrastructure planning coverage KPI."
    - name: "avg_current_utilization_pct"
      expr: AVG(CAST(current_utilization_percentage AS DOUBLE))
      comment: "Average current infrastructure utilisation percentage — headline capacity health KPI; values above threshold trigger investment decisions."
    - name: "avg_projected_growth_rate_pct"
      expr: AVG(CAST(projected_growth_rate_percentage AS DOUBLE))
      comment: "Average projected demand growth rate — forward-looking capacity pressure indicator for investment prioritisation."
    - name: "total_estimated_capex"
      expr: SUM(CAST(estimated_capex_amount AS DOUBLE))
      comment: "Total estimated capital expenditure required across all capacity plans — primary capex pipeline KPI for CFO and technology investment committee."
    - name: "total_estimated_annual_opex"
      expr: SUM(CAST(estimated_opex_annual_amount AS DOUBLE))
      comment: "Total estimated annual operating expenditure for capacity expansions — opex impact KPI for budget planning."
    - name: "avg_capacity_threshold_pct"
      expr: AVG(CAST(capacity_threshold_percentage AS DOUBLE))
      comment: "Average capacity threshold percentage at which action is triggered — governance benchmark for capacity management policy consistency."
    - name: "total_plans_above_threshold"
      expr: COUNT(CASE WHEN current_utilization_percentage >= capacity_threshold_percentage THEN 1 END)
      comment: "Number of capacity plans where current utilisation has breached the action threshold — urgent investment trigger KPI for CTO and infrastructure leadership."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_satellite_transponder`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Satellite transponder fleet analytics — tracks leased capacity, cost, and operational status to support satellite distribution cost management and capacity planning for broadcast operations."
  source: "`vibe_media_broadcasting_v1`.`technology`.`satellite_transponder`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the transponder (active, standby, decommissioned) for fleet availability analysis."
    - name: "frequency_band"
      expr: frequency_band
      comment: "Frequency band (Ku, Ka, C) — technical segmentation for regulatory compliance and interference management."
    - name: "ownership_type"
      expr: ownership_type_id
      comment: "Whether the transponder capacity is owned or leased — drives capex vs opex classification."
    - name: "satellite_name"
      expr: satellite_name
      comment: "Name of the satellite carrying the transponder — enables per-satellite cost and capacity analysis."
    - name: "lease_start_year"
      expr: DATE_TRUNC('year', lease_start_date)
      comment: "Year the transponder lease commenced — supports lease portfolio vintage and renewal planning."
  measures:
    - name: "total_transponders"
      expr: COUNT(1)
      comment: "Total number of satellite transponders in the fleet — baseline satellite distribution capacity KPI."
    - name: "total_monthly_lease_cost"
      expr: SUM(CAST(monthly_lease_cost AS DOUBLE))
      comment: "Total monthly satellite transponder lease cost — primary satellite distribution cost KPI for CFO and distribution budget reviews."
    - name: "avg_monthly_lease_cost"
      expr: AVG(CAST(monthly_lease_cost AS DOUBLE))
      comment: "Average monthly lease cost per transponder — benchmarks transponder pricing for contract renegotiation."
    - name: "total_leased_capacity_mbps"
      expr: SUM(CAST(leased_capacity_mbps AS DOUBLE))
      comment: "Total leased satellite bandwidth in Mbps — distribution capacity KPI for channel carriage and OTT delivery planning."
    - name: "avg_sla_uptime_pct"
      expr: AVG(CAST(sla_uptime_percentage AS DOUBLE))
      comment: "Average SLA uptime percentage across transponders — satellite reliability benchmark for distribution continuity planning."
    - name: "total_bandwidth_mhz"
      expr: SUM(CAST(bandwidth_mhz AS DOUBLE))
      comment: "Total transponder bandwidth in MHz — raw spectrum capacity metric for frequency planning and regulatory reporting."
    - name: "avg_eirp_dbw"
      expr: AVG(CAST(eirp_dbw AS DOUBLE))
      comment: "Average effective isotropic radiated power in dBW — signal strength benchmark for coverage quality and regulatory compliance."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_software_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Software license portfolio analytics — tracks license spend, compliance posture, and renewal exposure to support IT asset management, audit readiness, and software cost optimisation."
  source: "`vibe_media_broadcasting_v1`.`technology`.`software_license`"
  dimensions:
    - name: "license_type"
      expr: license_type_id
      comment: "Type of software license (perpetual, subscription, concurrent, named user) for cost model analysis."
    - name: "license_status"
      expr: license_status_id
      comment: "Current license status (active, expired, pending renewal) for compliance and renewal pipeline management."
    - name: "compliance_status"
      expr: compliance_status_id
      comment: "Compliance status of the license (compliant, over-deployed, under-licensed) — audit risk dimension."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the license auto-renews — governance dimension for licenses requiring proactive review."
    - name: "maintenance_included_flag"
      expr: maintenance_included_flag
      comment: "Whether maintenance and support is included in the license — total cost of ownership analysis dimension."
    - name: "primary_usage_category"
      expr: primary_usage_category_id
      comment: "Primary usage category of the software (broadcast, IT, security, analytics) for spend-by-category analysis."
    - name: "renewal_year"
      expr: DATE_TRUNC('year', renewal_date)
      comment: "Year the license is due for renewal — enables renewal wave planning and budget forecasting."
  measures:
    - name: "total_software_licenses"
      expr: COUNT(1)
      comment: "Total number of software licenses in the portfolio — baseline IT asset management KPI."
    - name: "total_license_cost"
      expr: SUM(CAST(license_cost_usd AS DOUBLE))
      comment: "Total software license acquisition cost — primary software spend KPI for IT budget management."
    - name: "total_annual_maintenance_cost"
      expr: SUM(CAST(annual_maintenance_cost_usd AS DOUBLE))
      comment: "Total annual software maintenance and support cost — recurring opex KPI for IT budget planning."
    - name: "avg_annual_maintenance_cost"
      expr: AVG(CAST(annual_maintenance_cost_usd AS DOUBLE))
      comment: "Average annual maintenance cost per license — benchmarks software support spend efficiency."
    - name: "total_auto_renewal_licenses"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Number of licenses set to auto-renew — procurement governance KPI for licenses requiring proactive review."
    - name: "distinct_software_products"
      expr: COUNT(DISTINCT software_product_name)
      comment: "Number of distinct software products licensed — application portfolio breadth metric for rationalisation and consolidation analysis."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_tech_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technology project portfolio analytics — tracks budget performance, schedule adherence, and delivery health to support CTO investment governance and technology transformation programme management."
  source: "`vibe_media_broadcasting_v1`.`technology`.`tech_project`"
  dimensions:
    - name: "project_type"
      expr: project_type_id
      comment: "Type of technology project (infrastructure refresh, digital transformation, compliance, security) for portfolio segmentation."
    - name: "project_status"
      expr: project_status_id
      comment: "Current project status (planning, in-flight, completed, on-hold) for portfolio health monitoring."
    - name: "risk_status"
      expr: risk_status_id
      comment: "Risk status of the project (on-track, at-risk, off-track) — primary project health dimension for executive steering."
    - name: "health_indicator"
      expr: health_indicator
      comment: "RAG (Red/Amber/Green) health indicator — executive dashboard dimension for portfolio risk visibility."
    - name: "compliance_requirement_flag"
      expr: compliance_requirement_flag
      comment: "Whether the project has a regulatory compliance driver — prioritisation dimension for mandatory vs discretionary investment."
    - name: "change_management_required_flag"
      expr: change_management_required_flag
      comment: "Whether the project requires formal change management — complexity and risk indicator."
    - name: "planned_start_year"
      expr: DATE_TRUNC('year', planned_start_date)
      comment: "Year the project was planned to start — enables investment vintage and delivery pipeline analysis."
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of technology projects in the portfolio — baseline portfolio size KPI for CTO governance."
    - name: "total_budget"
      expr: SUM(CAST(total_budget_usd AS DOUBLE))
      comment: "Total approved technology project budget in USD — primary capex/opex investment KPI for board and investment committee reporting."
    - name: "total_spend_to_date"
      expr: SUM(CAST(spend_to_date_usd AS DOUBLE))
      comment: "Total actual spend to date across all projects — budget consumption KPI for financial control and forecasting."
    - name: "total_budget_variance"
      expr: SUM(CAST(budget_variance_usd AS DOUBLE))
      comment: "Total budget variance (actual vs planned) across all projects — financial performance KPI; negative values indicate overspend requiring executive intervention."
    - name: "total_forecast_cost"
      expr: SUM(CAST(forecast_total_cost_usd AS DOUBLE))
      comment: "Total forecast-at-completion cost across all projects — forward-looking financial exposure KPI for budget reforecasting."
    - name: "total_capex"
      expr: SUM(CAST(capital_expenditure_usd AS DOUBLE))
      comment: "Total capital expenditure component of technology projects — capex classification KPI for balance sheet and depreciation planning."
    - name: "total_opex"
      expr: SUM(CAST(operational_expenditure_usd AS DOUBLE))
      comment: "Total operational expenditure component of technology projects — opex classification KPI for P&L impact analysis."
    - name: "total_at_risk_projects"
      expr: COUNT(CASE WHEN health_indicator = 'RED' THEN 1 END)
      comment: "Number of projects with RED health indicator — critical portfolio risk KPI triggering executive intervention and resource reallocation."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`technology_noc_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NOC alert analytics — tracks alert volume, severity distribution, SLA breach rates, and resolution performance to drive NOC operational efficiency and broadcast reliability improvements."
  source: "`vibe_media_broadcasting_v1`.`technology`.`noc_alert`"
  dimensions:
    - name: "alert_severity"
      expr: alert_severity
      comment: "Severity of the NOC alert (critical, major, minor, informational) — primary triage and escalation dimension."
    - name: "alert_status"
      expr: alert_status_id
      comment: "Current status of the alert (open, acknowledged, resolved, suppressed) for alert pipeline management."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the alert breached its SLA resolution target — NOC performance quality dimension."
    - name: "auto_resolution_flag"
      expr: auto_resolution_flag
      comment: "Whether the alert was resolved automatically — automation effectiveness dimension for NOC efficiency analysis."
    - name: "notification_sent_flag"
      expr: notification_sent_flag
      comment: "Whether stakeholder notifications were sent — communication process compliance dimension."
    - name: "alert_month"
      expr: DATE_TRUNC('month', alert_timestamp)
      comment: "Month the alert was triggered — enables alert volume trend analysis over time."
  measures:
    - name: "total_alerts"
      expr: COUNT(1)
      comment: "Total number of NOC alerts generated — baseline operational noise and reliability KPI."
    - name: "total_sla_breached_alerts"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of alerts that breached SLA resolution targets — NOC performance and vendor accountability KPI."
    - name: "total_auto_resolved_alerts"
      expr: COUNT(CASE WHEN auto_resolution_flag = TRUE THEN 1 END)
      comment: "Number of alerts resolved automatically — NOC automation effectiveness KPI; higher rates reduce manual intervention cost."
    - name: "total_critical_alerts"
      expr: COUNT(CASE WHEN alert_severity = 'CRITICAL' THEN 1 END)
      comment: "Number of critical severity alerts — highest-priority reliability metric reviewed at NOC and engineering leadership level."
    - name: "distinct_affected_channels"
      expr: COUNT(DISTINCT affected_channel_id)
      comment: "Number of distinct broadcast channels affected by NOC alerts — breadth of service disruption metric for scheduling and distribution impact."
    - name: "distinct_signal_paths_alerted"
      expr: COUNT(DISTINCT signal_path_id)
      comment: "Number of distinct signal paths that triggered alerts — infrastructure vulnerability breadth metric for network resilience planning."
$$;