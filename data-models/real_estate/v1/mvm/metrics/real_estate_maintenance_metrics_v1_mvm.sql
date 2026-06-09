-- Metric views for domain: maintenance | Business: Real Estate | Version: 1 | Generated on: 2026-05-02 04:45:11

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`maintenance_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core operational KPIs for work order execution, cost management, SLA compliance, and labor efficiency across the maintenance portfolio. Used by Facilities VPs and Operations Directors to steer maintenance spend, workforce productivity, and service quality."
  source: "`real_estate_ecm`.`maintenance`.`work_order`"
  dimensions:
    - name: "work_order_type"
      expr: work_order_type
      comment: "Classifies the work order as preventive, corrective, emergency, or tenant-requested — drives resource allocation decisions."
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current lifecycle status of the work order (Open, In Progress, Completed, Cancelled) — used to monitor backlog and throughput."
    - name: "priority_level"
      expr: priority_level
      comment: "Urgency classification (Critical, High, Medium, Low) — enables triage and escalation analysis."
    - name: "trade_category"
      expr: trade_category
      comment: "Trade discipline (HVAC, Electrical, Plumbing, etc.) — supports workforce planning and vendor specialization decisions."
    - name: "capex_opex_classification"
      expr: capex_opex_classification
      comment: "Indicates whether the work order is capitalized or expensed — critical for financial reporting and budget governance."
    - name: "sla_breached_flag"
      expr: sla_breached
      comment: "Boolean flag indicating whether the work order breached its SLA completion target — key quality and contract compliance indicator."
    - name: "tenant_billable_flag"
      expr: tenant_billable
      comment: "Indicates whether the work order cost is recoverable from the tenant — affects net maintenance cost reporting."
    - name: "warranty_claim_flag"
      expr: warranty_claim
      comment: "Flags work orders that triggered a warranty claim — used to track warranty recovery and asset quality."
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_date)
      comment: "Month of scheduled start date — enables trend analysis of maintenance volume over time."
    - name: "actual_completion_month"
      expr: DATE_TRUNC('MONTH', CAST(actual_completion_timestamp AS DATE))
      comment: "Month of actual completion — used to track throughput and backlog clearance trends."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders — baseline volume metric for workload and capacity planning."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_total_cost AS DOUBLE))
      comment: "Total actual maintenance spend across all work orders — primary cost KPI for budget governance and variance analysis."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost at work order creation — used as the baseline for cost variance analysis against actuals."
    - name: "total_actual_labor_cost"
      expr: SUM(CAST(actual_labor_cost AS DOUBLE))
      comment: "Total actual labor spend — enables labor vs. materials cost mix analysis for workforce optimization."
    - name: "total_actual_material_cost"
      expr: SUM(CAST(actual_material_cost AS DOUBLE))
      comment: "Total actual materials spend — supports procurement and inventory cost management decisions."
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labor hours consumed — key input for workforce capacity planning and productivity benchmarking."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours — elevated overtime signals understaffing or emergency demand spikes requiring management action."
    - name: "avg_actual_cost_per_work_order"
      expr: AVG(CAST(actual_total_cost AS DOUBLE))
      comment: "Average actual cost per work order — benchmarking KPI for cost efficiency across buildings, trade categories, and periods."
    - name: "avg_labor_hours_per_work_order"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labor hours per work order — productivity benchmark used to identify inefficiencies by trade or building."
    - name: "sla_breached_count"
      expr: SUM(CASE WHEN sla_breached = TRUE THEN 1 ELSE 0 END)
      comment: "Count of work orders that breached their SLA completion target — numerator for SLA breach rate; drives vendor and staffing accountability."
    - name: "tenant_billable_cost"
      expr: SUM(CASE WHEN tenant_billable = TRUE THEN CAST(actual_total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total maintenance cost recoverable from tenants — directly impacts net operating income and CAM reconciliation accuracy."
    - name: "warranty_claim_count"
      expr: SUM(CASE WHEN warranty_claim = TRUE THEN 1 ELSE 0 END)
      comment: "Number of work orders resulting in warranty claims — tracks asset quality and warranty recovery value."
    - name: "cost_overrun_amount"
      expr: SUM(CAST(actual_total_cost AS DOUBLE) - CAST(estimated_cost AS DOUBLE))
      comment: "Aggregate cost overrun (actual minus estimated) — negative values indicate under-spend; positive values signal estimation or scope issues."
    - name: "follow_up_required_count"
      expr: SUM(CASE WHEN follow_up_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of work orders requiring follow-up — high values indicate first-time fix rate problems and recurring maintenance issues."
    - name: "osha_flagged_work_order_count"
      expr: SUM(CASE WHEN osha_safety_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of work orders with OSHA safety flags — critical risk and compliance KPI for regulatory reporting and liability management."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`maintenance_service_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tenant-facing service quality and responsiveness KPIs derived from service requests. Used by Property Managers and Customer Experience leaders to monitor tenant satisfaction, SLA performance, and request resolution efficiency."
  source: "`real_estate_ecm`.`maintenance`.`service_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Current status of the service request (Open, In Progress, Resolved, Closed) — tracks pipeline and backlog."
    - name: "request_category"
      expr: request_category
      comment: "High-level category of the service request (HVAC, Plumbing, Electrical, etc.) — identifies recurring issue types."
    - name: "request_subcategory"
      expr: request_subcategory
      comment: "Detailed sub-classification of the request — enables granular root-cause analysis of maintenance demand."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Tenant-reported urgency (Emergency, Urgent, Routine) — used to prioritize dispatch and measure response alignment."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the request was submitted (Portal, Phone, Email, App) — informs digital adoption and channel strategy."
    - name: "sla_response_breached_flag"
      expr: sla_response_breached
      comment: "Boolean indicating whether the initial response SLA was breached — key tenant satisfaction and contract compliance indicator."
    - name: "sla_resolution_breached_flag"
      expr: sla_resolution_breached
      comment: "Boolean indicating whether the resolution SLA was breached — directly tied to tenant retention risk."
    - name: "cam_chargeable_flag"
      expr: cam_chargeable
      comment: "Indicates whether the service request cost is CAM-chargeable — affects CAM pool allocation and tenant billing accuracy."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Flags recurring service requests — high recurrence rates signal unresolved root causes requiring capital intervention."
    - name: "submitted_month"
      expr: DATE_TRUNC('MONTH', CAST(submitted_timestamp AS DATE))
      comment: "Month of request submission — enables trend analysis of service demand volume over time."
  measures:
    - name: "total_service_requests"
      expr: COUNT(1)
      comment: "Total number of service requests — baseline volume metric for demand planning and staffing."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost to resolve service requests — key input for maintenance budget management and CAM reconciliation."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost at request creation — baseline for cost variance and estimation accuracy analysis."
    - name: "avg_tenant_satisfaction_score"
      expr: AVG(CAST(tenant_satisfaction_score AS DOUBLE))
      comment: "Average tenant satisfaction score post-resolution — leading indicator of tenant retention and lease renewal probability."
    - name: "sla_response_breached_count"
      expr: SUM(CASE WHEN sla_response_breached = TRUE THEN 1 ELSE 0 END)
      comment: "Count of requests where initial response SLA was breached — numerator for response SLA breach rate; drives staffing and dispatch decisions."
    - name: "sla_resolution_breached_count"
      expr: SUM(CASE WHEN sla_resolution_breached = TRUE THEN 1 ELSE 0 END)
      comment: "Count of requests where resolution SLA was breached — numerator for resolution SLA breach rate; key tenant experience KPI."
    - name: "avg_sla_resolution_target_hours"
      expr: AVG(CAST(sla_resolution_target_hours AS DOUBLE))
      comment: "Average contracted resolution target hours — used to benchmark actual resolution performance against commitments."
    - name: "recurring_request_count"
      expr: SUM(CASE WHEN recurrence_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of recurring service requests — high values indicate systemic asset or building issues requiring capital investment."
    - name: "cam_chargeable_cost"
      expr: SUM(CASE WHEN cam_chargeable = TRUE THEN CAST(actual_cost AS DOUBLE) ELSE 0 END)
      comment: "Total CAM-chargeable service request cost — directly feeds CAM pool calculations and tenant billing reconciliation."
    - name: "osha_flagged_request_count"
      expr: SUM(CASE WHEN osha_safety_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of service requests flagged for OSHA safety concerns — critical risk management KPI for regulatory compliance."
    - name: "distinct_buildings_with_requests"
      expr: COUNT(DISTINCT building_id)
      comment: "Number of distinct buildings generating service requests — identifies high-demand properties for targeted maintenance investment."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`maintenance_capex_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure project performance KPIs covering budget governance, schedule adherence, cost variance, and ESG initiative tracking. Used by CFOs, Asset Managers, and Development VPs to govern capital allocation and project delivery."
  source: "`real_estate_ecm`.`maintenance`.`capex_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current project lifecycle status (Planning, Active, On Hold, Completed, Cancelled) — drives portfolio health assessment."
    - name: "project_type"
      expr: project_type
      comment: "Classification of the capital project (Renovation, Replacement, New Construction, TI, etc.) — enables spend mix analysis."
    - name: "asset_category"
      expr: asset_category
      comment: "Asset category being improved or replaced — identifies which asset classes consume the most capital."
    - name: "priority_level"
      expr: priority_level
      comment: "Project priority (Critical, High, Medium, Low) — used to align capital deployment with strategic asset management plans."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of project funding (Owner Equity, Debt, Tenant Contribution, etc.) — critical for capital structure and return analysis."
    - name: "is_esg_initiative_flag"
      expr: is_esg_initiative
      comment: "Flags projects that are part of ESG or sustainability programs — enables ESG capital spend reporting for investors and regulators."
    - name: "is_tenant_improvement_flag"
      expr: is_tenant_improvement
      comment: "Identifies tenant improvement projects — TI spend is a key leasing cost metric affecting deal economics."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month of planned project start — used for capital deployment timing and cash flow forecasting."
    - name: "actual_completion_month"
      expr: DATE_TRUNC('MONTH', actual_completion_date)
      comment: "Month of actual project completion — enables schedule adherence trend analysis."
  measures:
    - name: "total_capex_projects"
      expr: COUNT(1)
      comment: "Total number of capital projects in the portfolio — baseline for pipeline volume and governance workload."
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved capital budget across all projects — primary capital allocation KPI for board and investment committee reporting."
    - name: "total_actual_spend_to_date"
      expr: SUM(CAST(actual_spend_to_date AS DOUBLE))
      comment: "Total capital spend incurred to date — tracks capital deployment pace against approved budgets."
    - name: "total_committed_cost"
      expr: SUM(CAST(committed_cost_amount AS DOUBLE))
      comment: "Total committed costs (contracted but not yet invoiced) — essential for cash flow forecasting and budget exposure management."
    - name: "total_revised_budget"
      expr: SUM(CAST(revised_budget_amount AS DOUBLE))
      comment: "Total revised budget after change orders — compared against approved budget to measure scope creep at portfolio level."
    - name: "total_change_order_amount"
      expr: SUM(CAST(change_order_amount AS DOUBLE))
      comment: "Total change order value across all projects — high values indicate poor scope definition or contractor performance issues."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value_amount AS DOUBLE))
      comment: "Total contracted value across all capital projects — measures vendor commitment exposure and procurement scale."
    - name: "avg_approved_budget_per_project"
      expr: AVG(CAST(approved_budget_amount AS DOUBLE))
      comment: "Average approved budget per project — benchmarks project scale and informs capital planning norms."
    - name: "budget_variance_amount"
      expr: SUM(CAST(actual_spend_to_date AS DOUBLE) - CAST(approved_budget_amount AS DOUBLE))
      comment: "Aggregate budget variance (actual spend minus approved budget) — negative = under-spend, positive = over-budget; primary capital governance KPI."
    - name: "esg_project_count"
      expr: SUM(CASE WHEN is_esg_initiative = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ESG-designated capital projects — tracks sustainability investment commitment for investor and regulatory ESG reporting."
    - name: "esg_approved_budget"
      expr: SUM(CASE WHEN is_esg_initiative = TRUE THEN CAST(approved_budget_amount AS DOUBLE) ELSE 0 END)
      comment: "Total approved budget allocated to ESG initiatives — key metric for sustainability investment reporting and green financing covenants."
    - name: "tenant_improvement_budget"
      expr: SUM(CASE WHEN is_tenant_improvement = TRUE THEN CAST(approved_budget_amount AS DOUBLE) ELSE 0 END)
      comment: "Total capital budget for tenant improvement projects — directly impacts leasing deal economics and net effective rent calculations."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`maintenance_vendor_dispatch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance and dispatch efficiency KPIs covering cost management, SLA compliance, and service quality. Used by Facilities Directors and Procurement teams to evaluate vendor performance, manage service contracts, and optimize dispatch operations."
  source: "`real_estate_ecm`.`maintenance`.`vendor_dispatch`"
  dimensions:
    - name: "dispatch_status"
      expr: dispatch_status
      comment: "Current status of the vendor dispatch (Dispatched, En Route, On Site, Completed, Cancelled) — tracks field operations in real time."
    - name: "trade_type"
      expr: trade_type
      comment: "Trade discipline of the dispatched vendor (HVAC, Electrical, Plumbing, etc.) — enables vendor specialization and cost analysis by trade."
    - name: "service_category"
      expr: service_category
      comment: "Category of service being performed — supports spend analysis and vendor category management."
    - name: "priority_level"
      expr: priority_level
      comment: "Dispatch priority level — used to assess whether high-priority dispatches receive appropriately fast response."
    - name: "sla_response_met_flag"
      expr: sla_response_met
      comment: "Boolean indicating whether the vendor met the response SLA — key vendor scorecard metric."
    - name: "sla_resolution_met_flag"
      expr: sla_resolution_met
      comment: "Boolean indicating whether the vendor met the resolution SLA — primary vendor performance KPI for contract renewal decisions."
    - name: "is_cam_billable_flag"
      expr: is_cam_billable
      comment: "Indicates whether the dispatch cost is billable to the CAM pool — affects tenant cost recovery and CAM reconciliation."
    - name: "is_return_visit_flag"
      expr: is_return_visit
      comment: "Flags return visits for the same issue — high return visit rates indicate poor first-time fix quality by the vendor."
    - name: "capex_opex_classification"
      expr: capex_opex_classification
      comment: "Financial classification of the dispatch cost — governs accounting treatment and budget impact."
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month of scheduled dispatch — enables trend analysis of vendor dispatch volume and seasonal demand patterns."
  measures:
    - name: "total_dispatches"
      expr: COUNT(1)
      comment: "Total number of vendor dispatches — baseline volume metric for vendor workload and contract utilization."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual vendor spend across all dispatches — primary cost KPI for vendor spend management and budget control."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated vendor cost — baseline for cost variance analysis and vendor estimation accuracy benchmarking."
    - name: "avg_actual_cost_per_dispatch"
      expr: AVG(CAST(actual_cost_amount AS DOUBLE))
      comment: "Average actual cost per vendor dispatch — benchmarks vendor cost efficiency and identifies outlier dispatches."
    - name: "sla_response_met_count"
      expr: SUM(CASE WHEN sla_response_met = TRUE THEN 1 ELSE 0 END)
      comment: "Count of dispatches where vendor met response SLA — numerator for vendor response SLA compliance rate."
    - name: "sla_resolution_met_count"
      expr: SUM(CASE WHEN sla_resolution_met = TRUE THEN 1 ELSE 0 END)
      comment: "Count of dispatches where vendor met resolution SLA — numerator for vendor resolution SLA compliance rate; drives contract renewal decisions."
    - name: "return_visit_count"
      expr: SUM(CASE WHEN is_return_visit = TRUE THEN 1 ELSE 0 END)
      comment: "Count of return visits — high return visit rates signal poor first-time fix quality, increasing total maintenance cost and tenant disruption."
    - name: "cam_billable_cost"
      expr: SUM(CASE WHEN is_cam_billable = TRUE THEN CAST(actual_cost_amount AS DOUBLE) ELSE 0 END)
      comment: "Total CAM-billable vendor dispatch cost — feeds directly into CAM pool calculations and tenant cost recovery."
    - name: "cost_variance_amount"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE) - CAST(estimated_cost_amount AS DOUBLE))
      comment: "Aggregate cost variance (actual minus estimated) across dispatches — measures vendor estimation accuracy and scope management."
    - name: "distinct_vendors_dispatched"
      expr: COUNT(DISTINCT vendor_name)
      comment: "Number of distinct vendors dispatched — tracks vendor diversification and dependency concentration risk."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`maintenance_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety incident frequency, severity, and regulatory compliance KPIs. Used by Risk Managers, Compliance Officers, and C-suite to monitor workplace safety performance, regulatory exposure, and corrective action effectiveness."
  source: "`real_estate_ecm`.`maintenance`.`safety_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of safety incident (Slip/Fall, Equipment Failure, Chemical Exposure, etc.) — enables root cause pattern analysis."
    - name: "incident_category"
      expr: incident_category
      comment: "Broader category grouping of incidents — used for regulatory classification and trend reporting."
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident (Open, Under Investigation, Closed) — tracks resolution pipeline and open liability exposure."
    - name: "injured_party_type"
      expr: injured_party_type
      comment: "Type of injured party (Employee, Contractor, Tenant, Visitor) — determines regulatory reporting obligations and liability exposure."
    - name: "is_osha_recordable_flag"
      expr: is_osha_recordable
      comment: "Boolean indicating OSHA recordable status — directly determines regulatory filing obligations and affects OSHA 300 log."
    - name: "is_riddor_reportable_flag"
      expr: is_riddor_reportable
      comment: "Boolean indicating UK RIDDOR reportable status — governs regulatory reporting obligations in UK-jurisdiction properties."
    - name: "esg_reportable_flag"
      expr: esg_reportable
      comment: "Flags incidents that must be disclosed in ESG reporting — affects sustainability ratings and investor disclosures."
    - name: "capex_opex_classification"
      expr: capex_opex_classification
      comment: "Financial classification of remediation costs — governs accounting treatment of incident-related expenditures."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', CAST(incident_timestamp AS DATE))
      comment: "Month of incident occurrence — enables trend analysis of incident frequency and seasonal safety risk patterns."
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction governing the incident — used to segment compliance obligations by geography."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of safety incidents — primary safety frequency KPI used in executive safety dashboards and regulatory filings."
    - name: "osha_recordable_count"
      expr: SUM(CASE WHEN is_osha_recordable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of OSHA-recordable incidents — directly determines OSHA 300 log entries and regulatory compliance exposure."
    - name: "total_estimated_remediation_cost"
      expr: SUM(CAST(estimated_remediation_cost AS DOUBLE))
      comment: "Total estimated cost to remediate safety incidents — key input for risk provisioning and insurance reserve calculations."
    - name: "open_incident_count"
      expr: SUM(CASE WHEN incident_status = 'Open' THEN 1 ELSE 0 END)
      comment: "Count of currently open incidents — measures unresolved liability exposure and corrective action backlog."
    - name: "esg_reportable_incident_count"
      expr: SUM(CASE WHEN esg_reportable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ESG-reportable incidents — feeds sustainability disclosures and affects ESG ratings used by institutional investors."
    - name: "environmental_release_count"
      expr: SUM(CASE WHEN is_environmental_release = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents involving environmental releases — highest-severity regulatory risk category requiring immediate executive attention."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`maintenance_service_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service contract portfolio KPIs covering contract value, SLA commitments, insurance compliance, and renewal risk. Used by Procurement Directors and Asset Managers to govern vendor relationships, manage contract exposure, and ensure compliance."
  source: "`real_estate_ecm`.`maintenance`.`service_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current contract lifecycle status (Active, Expired, Terminated, Pending Renewal) — tracks portfolio health and renewal pipeline."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of service contract (Full Service, Time & Materials, Preventive Maintenance, etc.) — enables spend mix and risk analysis."
    - name: "capex_opex_classification"
      expr: capex_opex_classification
      comment: "Financial classification of contract spend — governs accounting treatment and budget impact."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Payment cadence (Monthly, Quarterly, Annual) — used for cash flow forecasting and AP planning."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the contract auto-renews — flags contracts requiring proactive management to avoid unintended renewals."
    - name: "insurance_required_flag"
      expr: insurance_required_flag
      comment: "Indicates whether vendor insurance is required — used to track insurance compliance across the vendor portfolio."
    - name: "esg_sustainability_flag"
      expr: esg_sustainability_flag
      comment: "Flags contracts with ESG or sustainability scope — enables ESG procurement spend reporting."
    - name: "multi_property_flag"
      expr: multi_property_flag
      comment: "Indicates contracts covering multiple properties — identifies portfolio-level vendor relationships and consolidation opportunities."
    - name: "commencement_month"
      expr: DATE_TRUNC('MONTH', commencement_date)
      comment: "Month of contract commencement — used for contract vintage analysis and renewal wave planning."
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month of contract expiration — critical for renewal pipeline management and avoiding service gaps."
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of service contracts — baseline for vendor portfolio size and procurement governance workload."
    - name: "total_annual_contract_value"
      expr: SUM(CAST(annual_contract_value AS DOUBLE))
      comment: "Total annualized value of all service contracts — primary procurement spend KPI for budget governance and vendor consolidation analysis."
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total lifetime value of all service contracts — measures total vendor commitment exposure for financial risk management."
    - name: "avg_annual_contract_value"
      expr: AVG(CAST(annual_contract_value AS DOUBLE))
      comment: "Average annual contract value — benchmarks contract scale and identifies outlier vendor relationships."
    - name: "avg_sla_response_time_hours"
      expr: AVG(CAST(sla_response_time_hours AS DOUBLE))
      comment: "Average contracted SLA response time in hours — benchmarks vendor response commitments across the portfolio."
    - name: "avg_sla_resolution_time_hours"
      expr: AVG(CAST(sla_resolution_time_hours AS DOUBLE))
      comment: "Average contracted SLA resolution time in hours — used to assess whether contracted service levels meet operational requirements."
    - name: "total_insurance_liability_limit"
      expr: SUM(CAST(insurance_liability_limit AS DOUBLE))
      comment: "Total insurance liability coverage across all contracts — measures aggregate risk transfer to vendors for liability management."
    - name: "auto_renewal_contract_count"
      expr: SUM(CASE WHEN auto_renewal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of contracts with auto-renewal clauses — flags contracts requiring proactive review to prevent unintended spend commitments."
    - name: "esg_contract_count"
      expr: SUM(CASE WHEN esg_sustainability_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of contracts with ESG sustainability scope — tracks sustainable procurement progress for ESG reporting."
    - name: "esg_annual_contract_value"
      expr: SUM(CASE WHEN esg_sustainability_flag = TRUE THEN CAST(annual_contract_value AS DOUBLE) ELSE 0 END)
      comment: "Total annual spend on ESG-designated service contracts — measures sustainable procurement investment for investor and regulatory disclosure."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`maintenance_ops_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational inspection quality, deficiency management, and compliance KPIs. Used by Property Managers, Compliance Officers, and Asset Managers to track inspection outcomes, remediation costs, and regulatory compliance status."
  source: "`real_estate_ecm`.`maintenance`.`ops_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (Fire Safety, HVAC, Structural, Environmental, etc.) — enables compliance gap analysis by inspection category."
    - name: "inspection_subtype"
      expr: inspection_subtype
      comment: "Detailed sub-classification of the inspection — supports granular deficiency trend analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (Scheduled, In Progress, Completed, Failed) — tracks inspection pipeline and compliance posture."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Outcome of the inspection (Pass, Fail, Conditional Pass) — primary compliance quality indicator."
    - name: "inspecting_party_type"
      expr: inspecting_party_type
      comment: "Type of inspecting party (Internal, Third-Party, Regulatory Authority) — distinguishes self-assessments from regulatory findings."
    - name: "capex_opex_classification"
      expr: capex_opex_classification
      comment: "Financial classification of remediation costs — governs accounting treatment of inspection-driven expenditures."
    - name: "osha_reportable_flag"
      expr: osha_reportable_flag
      comment: "Flags inspections with OSHA-reportable findings — critical regulatory compliance indicator."
    - name: "esg_relevant_flag"
      expr: esg_relevant_flag
      comment: "Flags inspections relevant to ESG reporting — enables sustainability compliance tracking."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of inspection — enables trend analysis of inspection volume and compliance outcomes over time."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of operational inspections — baseline for compliance program activity and inspection coverage."
    - name: "total_estimated_remediation_cost"
      expr: SUM(CAST(estimated_remediation_cost AS DOUBLE))
      comment: "Total estimated cost to remediate inspection deficiencies — key input for capital planning and maintenance budget forecasting."
    - name: "total_actual_remediation_cost"
      expr: SUM(CAST(actual_remediation_cost AS DOUBLE))
      comment: "Total actual remediation spend driven by inspection findings — measures true cost of deferred maintenance and compliance gaps."
    - name: "avg_actual_remediation_cost"
      expr: AVG(CAST(actual_remediation_cost AS DOUBLE))
      comment: "Average remediation cost per inspection — benchmarks inspection severity and informs reserve adequacy for compliance programs."
    - name: "osha_reportable_inspection_count"
      expr: SUM(CASE WHEN osha_reportable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of inspections with OSHA-reportable findings — critical regulatory risk KPI requiring immediate executive attention."
    - name: "esg_relevant_inspection_count"
      expr: SUM(CASE WHEN esg_relevant_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ESG-relevant inspections — tracks sustainability compliance activity for ESG reporting and green certification programs."
    - name: "remediation_cost_variance"
      expr: SUM(CAST(actual_remediation_cost AS DOUBLE) - CAST(estimated_remediation_cost AS DOUBLE))
      comment: "Aggregate variance between actual and estimated remediation costs — measures cost estimation accuracy for inspection-driven work."
    - name: "distinct_buildings_inspected"
      expr: COUNT(DISTINCT building_id)
      comment: "Number of distinct buildings inspected — measures inspection coverage breadth across the property portfolio."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`maintenance_pm_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance program KPIs covering schedule coverage, cost planning, compliance requirements, and ESG alignment. Used by Facilities Managers and Asset Managers to govern PM program effectiveness and asset lifecycle management."
  source: "`real_estate_ecm`.`maintenance`.`pm_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the PM schedule (Active, Inactive, Suspended) — tracks program coverage and gaps."
    - name: "frequency_type"
      expr: frequency_type
      comment: "Frequency classification of the PM task (Daily, Weekly, Monthly, Annual, etc.) — enables workload distribution analysis."
    - name: "trade_category"
      expr: trade_category
      comment: "Trade discipline for the PM task (HVAC, Electrical, Plumbing, etc.) — supports workforce planning and vendor assignment."
    - name: "asset_system_type"
      expr: asset_system_type
      comment: "Building system type covered by the PM schedule — identifies which systems have the most intensive maintenance programs."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority of the PM task — used to ensure critical asset maintenance is adequately resourced."
    - name: "cost_classification"
      expr: cost_classification
      comment: "Financial classification of PM costs — governs accounting treatment and budget allocation."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the PM task is required for regulatory compliance — flags tasks where non-completion creates legal exposure."
    - name: "osha_required_flag"
      expr: osha_required
      comment: "Flags PM tasks required by OSHA regulations — non-completion of these tasks creates direct regulatory liability."
    - name: "leed_required_flag"
      expr: leed_required
      comment: "Flags PM tasks required to maintain LEED certification — non-completion risks loss of green certification and associated financial benefits."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the PM schedule became effective — used for program vintage analysis and coverage trend tracking."
  measures:
    - name: "total_pm_schedules"
      expr: COUNT(1)
      comment: "Total number of active PM schedules — measures breadth of the preventive maintenance program across the asset portfolio."
    - name: "total_estimated_labor_cost"
      expr: SUM(CAST(estimated_labor_cost AS DOUBLE))
      comment: "Total estimated annual labor cost for all PM schedules — primary input for maintenance budget planning and workforce sizing."
    - name: "total_estimated_parts_cost"
      expr: SUM(CAST(estimated_parts_cost AS DOUBLE))
      comment: "Total estimated parts and materials cost for all PM schedules — drives procurement planning and inventory management decisions."
    - name: "total_estimated_labor_hours"
      expr: SUM(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Total estimated labor hours across all PM schedules — key input for workforce capacity planning and contractor staffing."
    - name: "avg_estimated_labor_cost_per_schedule"
      expr: AVG(CAST(estimated_labor_cost AS DOUBLE))
      comment: "Average estimated labor cost per PM schedule — benchmarks PM program cost intensity by asset type and trade."
    - name: "compliance_required_schedule_count"
      expr: SUM(CASE WHEN compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of PM schedules required for regulatory compliance — measures the compliance-critical portion of the PM program."
    - name: "osha_required_schedule_count"
      expr: SUM(CASE WHEN osha_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of OSHA-mandated PM schedules — non-completion of these creates direct regulatory liability and potential citations."
    - name: "leed_required_schedule_count"
      expr: SUM(CASE WHEN leed_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of LEED-required PM schedules — tracks maintenance obligations tied to green certification retention."
    - name: "auto_generate_work_order_count"
      expr: SUM(CASE WHEN work_order_auto_generate = TRUE THEN 1 ELSE 0 END)
      comment: "Count of PM schedules configured for automatic work order generation — measures automation coverage and manual scheduling workload reduction."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`maintenance_billable_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance-related billable charge KPIs covering CAM recovery, tenant billing accuracy, dispute management, and charge reconciliation. Used by Property Accountants, Asset Managers, and Finance teams to govern tenant cost recovery and CAM reconciliation."
  source: "`real_estate_ecm`.`maintenance`.`billable_charge`"
  dimensions:
    - name: "charge_status"
      expr: charge_status
      comment: "Current status of the billable charge (Pending, Invoiced, Paid, Disputed, Written Off) — tracks billing pipeline and collection health."
    - name: "charge_type"
      expr: charge_type
      comment: "Type of charge (CAM, Utility, Maintenance, Insurance, etc.) — enables cost recovery analysis by charge category."
    - name: "charge_category"
      expr: charge_category
      comment: "Broader category grouping of the charge — supports CAM pool composition analysis and tenant billing transparency."
    - name: "is_cam_reconciliation_charge_flag"
      expr: is_cam_reconciliation_charge
      comment: "Flags charges that are part of the annual CAM reconciliation — critical for year-end tenant billing accuracy."
    - name: "cam_allocation_method"
      expr: cam_allocation_method
      comment: "Method used to allocate CAM costs to tenants (Pro Rata, Fixed, Actual) — affects billing fairness and dispute risk."
    - name: "lease_structure_type"
      expr: lease_structure_type
      comment: "Lease structure governing the charge (Gross, Net, Modified Gross) — determines tenant cost recovery obligations."
    - name: "cost_classification"
      expr: cost_classification
      comment: "Financial classification of the charge — governs accounting treatment and CAM pool inclusion/exclusion."
    - name: "charge_month"
      expr: DATE_TRUNC('MONTH', charge_date)
      comment: "Month of charge — enables trend analysis of billing volume and CAM accrual patterns."
    - name: "reconciliation_year"
      expr: reconciliation_year
      comment: "Year of CAM reconciliation — used to segment charges by reconciliation period for year-end true-up analysis."
  measures:
    - name: "total_gross_charge_amount"
      expr: SUM(CAST(gross_charge_amount AS DOUBLE))
      comment: "Total gross billable charge amount — primary revenue recovery KPI for maintenance cost pass-through management."
    - name: "total_tenant_allocated_amount"
      expr: SUM(CAST(tenant_allocated_amount AS DOUBLE))
      comment: "Total amount allocated to tenants — measures actual tenant cost recovery and CAM billing effectiveness."
    - name: "total_invoiced_amount"
      expr: SUM(CAST(total_invoiced_amount AS DOUBLE))
      comment: "Total amount invoiced to tenants — tracks billing execution and accounts receivable generation from maintenance charges."
    - name: "total_estimated_cam_paid"
      expr: SUM(CAST(estimated_cam_paid AS DOUBLE))
      comment: "Total estimated CAM payments collected from tenants — used in CAM reconciliation to calculate true-up amounts."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on billable charges — required for tax compliance reporting and tenant billing accuracy."
    - name: "avg_tenant_pro_rata_share"
      expr: AVG(CAST(tenant_pro_rata_share AS DOUBLE))
      comment: "Average tenant pro-rata share percentage — benchmarks allocation fairness and identifies outlier tenant cost burdens."
    - name: "cam_reconciliation_charge_amount"
      expr: SUM(CASE WHEN is_cam_reconciliation_charge = TRUE THEN CAST(gross_charge_amount AS DOUBLE) ELSE 0 END)
      comment: "Total gross amount of CAM reconciliation charges — primary KPI for annual CAM true-up magnitude and tenant billing impact."
    - name: "disputed_charge_count"
      expr: SUM(CASE WHEN charge_status = 'Disputed' THEN 1 ELSE 0 END)
      comment: "Count of disputed charges — high dispute volumes signal billing accuracy issues or tenant relationship problems requiring management attention."
    - name: "billing_recovery_variance"
      expr: SUM(CAST(total_invoiced_amount AS DOUBLE) - CAST(tenant_allocated_amount AS DOUBLE))
      comment: "Variance between invoiced amount and tenant-allocated amount — measures billing accuracy and identifies over/under-billing patterns."
$$;