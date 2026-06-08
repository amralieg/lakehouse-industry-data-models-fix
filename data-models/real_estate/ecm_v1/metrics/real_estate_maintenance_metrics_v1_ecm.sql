-- Metric views for domain: maintenance | Business: Real Estate | Version: 1 | Generated on: 2026-05-02 01:37:58

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`maintenance_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core work order execution and cost metrics for maintenance operations, tracking labor efficiency, cost performance, and SLA compliance"
  source: "`real_estate_ecm`.`maintenance`.`work_order`"
  dimensions:
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order (open, in progress, completed, cancelled)"
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order (corrective, preventive, emergency, project)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification (critical, high, medium, low)"
    - name: "trade_category"
      expr: trade_category
      comment: "Trade or skill category required (HVAC, electrical, plumbing, etc.)"
    - name: "capex_opex_classification"
      expr: capex_opex_classification
      comment: "Capital vs operational expense classification for financial reporting"
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_date)
      comment: "Month when work was scheduled to start"
    - name: "actual_completion_month"
      expr: DATE_TRUNC('MONTH', CAST(actual_completion_timestamp AS DATE))
      comment: "Month when work was actually completed"
    - name: "sla_breached_flag"
      expr: sla_breached
      comment: "Whether the work order breached SLA targets"
    - name: "tenant_billable_flag"
      expr: tenant_billable
      comment: "Whether costs can be billed back to tenant"
    - name: "osha_safety_flag"
      expr: osha_safety_flag
      comment: "Whether work involves OSHA safety considerations"
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_total_cost AS DOUBLE))
      comment: "Total actual cost incurred across all work orders"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost for all work orders"
    - name: "total_labor_cost"
      expr: SUM(CAST(actual_labor_cost AS DOUBLE))
      comment: "Total labor cost component across work orders"
    - name: "total_material_cost"
      expr: SUM(CAST(actual_material_cost AS DOUBLE))
      comment: "Total material cost component across work orders"
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labor hours consumed across all work orders"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked across work orders"
    - name: "avg_actual_cost_per_wo"
      expr: AVG(CAST(actual_total_cost AS DOUBLE))
      comment: "Average actual cost per work order"
    - name: "avg_labor_hours_per_wo"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labor hours per work order"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breached = TRUE THEN 1 ELSE 0 END)
      comment: "Count of work orders that breached SLA targets"
    - name: "tenant_billable_count"
      expr: SUM(CASE WHEN tenant_billable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of work orders billable to tenants"
    - name: "emergency_wo_count"
      expr: SUM(CASE WHEN priority_level = 'critical' OR priority_level = 'emergency' THEN 1 ELSE 0 END)
      comment: "Count of emergency or critical priority work orders"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`maintenance_service_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tenant service request performance metrics tracking response times, resolution efficiency, and tenant satisfaction"
  source: "`real_estate_ecm`.`maintenance`.`service_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Current status of the service request"
    - name: "request_category"
      expr: request_category
      comment: "Category of service request (HVAC, plumbing, electrical, etc.)"
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency classification of the request"
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which request was submitted (portal, phone, email, mobile app)"
    - name: "submitted_month"
      expr: DATE_TRUNC('MONTH', CAST(submitted_timestamp AS DATE))
      comment: "Month when request was submitted"
    - name: "sla_response_breached_flag"
      expr: sla_response_breached
      comment: "Whether response SLA was breached"
    - name: "sla_resolution_breached_flag"
      expr: sla_resolution_breached
      comment: "Whether resolution SLA was breached"
    - name: "cam_chargeable_flag"
      expr: cam_chargeable
      comment: "Whether request is chargeable to CAM"
    - name: "capex_opex_classification"
      expr: capex_opex_classification
      comment: "Capital vs operational expense classification"
  measures:
    - name: "total_service_requests"
      expr: COUNT(1)
      comment: "Total number of service requests"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of service requests"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of service requests"
    - name: "avg_tenant_satisfaction_score"
      expr: AVG(CAST(tenant_satisfaction_score AS DOUBLE))
      comment: "Average tenant satisfaction score across resolved requests"
    - name: "avg_sla_response_target_hours"
      expr: AVG(CAST(sla_response_target_hours AS DOUBLE))
      comment: "Average SLA response target in hours"
    - name: "avg_sla_resolution_target_hours"
      expr: AVG(CAST(sla_resolution_target_hours AS DOUBLE))
      comment: "Average SLA resolution target in hours"
    - name: "sla_response_breach_count"
      expr: SUM(CASE WHEN sla_response_breached = TRUE THEN 1 ELSE 0 END)
      comment: "Count of requests that breached response SLA"
    - name: "sla_resolution_breach_count"
      expr: SUM(CASE WHEN sla_resolution_breached = TRUE THEN 1 ELSE 0 END)
      comment: "Count of requests that breached resolution SLA"
    - name: "recurring_request_count"
      expr: SUM(CASE WHEN recurrence_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of recurring service requests indicating systemic issues"
    - name: "cam_chargeable_count"
      expr: SUM(CASE WHEN cam_chargeable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of requests chargeable to CAM"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`maintenance_pm_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance execution metrics tracking compliance, efficiency, and asset condition management"
  source: "`real_estate_ecm`.`maintenance`.`pm_execution`"
  dimensions:
    - name: "execution_status"
      expr: execution_status
      comment: "Status of PM execution (completed, in progress, skipped, cancelled)"
    - name: "overall_result"
      expr: overall_result
      comment: "Overall result of PM execution (pass, fail, conditional)"
    - name: "pm_type"
      expr: pm_type
      comment: "Type of preventive maintenance performed"
    - name: "equipment_category"
      expr: equipment_category
      comment: "Category of equipment maintained"
    - name: "execution_month"
      expr: DATE_TRUNC('MONTH', execution_date)
      comment: "Month when PM was executed"
    - name: "asset_condition_after"
      expr: asset_condition_after
      comment: "Asset condition rating after PM execution"
    - name: "corrective_wo_spawned_flag"
      expr: corrective_wo_spawned
      comment: "Whether PM execution spawned corrective work orders"
    - name: "regulatory_inspection_flag"
      expr: regulatory_inspection_flag
      comment: "Whether PM was a regulatory inspection"
    - name: "safety_hazard_identified_flag"
      expr: safety_hazard_identified
      comment: "Whether safety hazards were identified during PM"
    - name: "supervisor_approved_flag"
      expr: supervisor_approved
      comment: "Whether PM execution was supervisor approved"
  measures:
    - name: "total_pm_executions"
      expr: COUNT(1)
      comment: "Total number of PM executions"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost for PM executions"
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total parts cost for PM executions"
    - name: "avg_checklist_completion_pct"
      expr: AVG(CAST(checklist_completion_pct AS DOUBLE))
      comment: "Average checklist completion percentage across PM executions"
    - name: "avg_meter_reading_value"
      expr: AVG(CAST(meter_reading_value AS DOUBLE))
      comment: "Average meter reading value captured during PM"
    - name: "pm_pass_count"
      expr: SUM(CASE WHEN overall_result = 'pass' THEN 1 ELSE 0 END)
      comment: "Count of PM executions that passed inspection"
    - name: "pm_fail_count"
      expr: SUM(CASE WHEN overall_result = 'fail' THEN 1 ELSE 0 END)
      comment: "Count of PM executions that failed inspection"
    - name: "corrective_wo_spawn_count"
      expr: SUM(CASE WHEN corrective_wo_spawned = TRUE THEN 1 ELSE 0 END)
      comment: "Count of PM executions that spawned corrective work orders"
    - name: "safety_hazard_count"
      expr: SUM(CASE WHEN safety_hazard_identified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of PM executions where safety hazards were identified"
    - name: "regulatory_inspection_count"
      expr: SUM(CASE WHEN regulatory_inspection_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of regulatory inspections performed"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`maintenance_service_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service contract financial and compliance metrics tracking vendor performance, contract value, and renewal management"
  source: "`real_estate_ecm`.`maintenance`.`service_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the service contract"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of service contract (full service, PM only, on-call, etc.)"
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Payment frequency (monthly, quarterly, annual)"
    - name: "capex_opex_classification"
      expr: capex_opex_classification
      comment: "Capital vs operational expense classification"
    - name: "commencement_month"
      expr: DATE_TRUNC('MONTH', commencement_date)
      comment: "Month when contract commenced"
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month when contract expires"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether contract has auto-renewal clause"
    - name: "insurance_required_flag"
      expr: insurance_required_flag
      comment: "Whether vendor insurance is required"
    - name: "osha_compliance_required_flag"
      expr: osha_compliance_required_flag
      comment: "Whether OSHA compliance is required"
    - name: "esg_sustainability_flag"
      expr: esg_sustainability_flag
      comment: "Whether contract supports ESG/sustainability initiatives"
  measures:
    - name: "total_service_contracts"
      expr: COUNT(1)
      comment: "Total number of service contracts"
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total value of all service contracts"
    - name: "total_annual_contract_value"
      expr: SUM(CAST(annual_contract_value AS DOUBLE))
      comment: "Total annual contract value across all contracts"
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average total contract value"
    - name: "avg_annual_contract_value"
      expr: AVG(CAST(annual_contract_value AS DOUBLE))
      comment: "Average annual contract value"
    - name: "avg_sla_response_time_hours"
      expr: AVG(CAST(sla_response_time_hours AS DOUBLE))
      comment: "Average SLA response time in hours across contracts"
    - name: "avg_sla_resolution_time_hours"
      expr: AVG(CAST(sla_resolution_time_hours AS DOUBLE))
      comment: "Average SLA resolution time in hours across contracts"
    - name: "avg_insurance_liability_limit"
      expr: AVG(CAST(insurance_liability_limit AS DOUBLE))
      comment: "Average insurance liability limit required"
    - name: "auto_renewal_count"
      expr: SUM(CASE WHEN auto_renewal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of contracts with auto-renewal clauses"
    - name: "multi_property_contract_count"
      expr: SUM(CASE WHEN multi_property_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of contracts covering multiple properties"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`maintenance_capex_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital project financial performance and execution metrics tracking budget variance, schedule adherence, and ROI"
  source: "`real_estate_ecm`.`maintenance`.`capex_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the capital project"
    - name: "project_type"
      expr: project_type
      comment: "Type of capital project (renovation, upgrade, expansion, etc.)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the project"
    - name: "asset_category"
      expr: asset_category
      comment: "Category of asset being improved or replaced"
    - name: "funding_source"
      expr: funding_source
      comment: "Source of project funding"
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month when project was planned to start"
    - name: "actual_completion_month"
      expr: DATE_TRUNC('MONTH', actual_completion_date)
      comment: "Month when project was actually completed"
    - name: "is_esg_initiative_flag"
      expr: is_esg_initiative
      comment: "Whether project is an ESG/sustainability initiative"
    - name: "is_tenant_improvement_flag"
      expr: is_tenant_improvement
      comment: "Whether project is a tenant improvement"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method for capitalized assets"
  measures:
    - name: "total_capex_projects"
      expr: COUNT(1)
      comment: "Total number of capital projects"
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved budget across all projects"
    - name: "total_revised_budget"
      expr: SUM(CAST(revised_budget_amount AS DOUBLE))
      comment: "Total revised budget across all projects"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_to_date AS DOUBLE))
      comment: "Total actual spend to date across all projects"
    - name: "total_committed_cost"
      expr: SUM(CAST(committed_cost_amount AS DOUBLE))
      comment: "Total committed costs across all projects"
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value_amount AS DOUBLE))
      comment: "Total contract value across all projects"
    - name: "total_change_order_amount"
      expr: SUM(CAST(change_order_amount AS DOUBLE))
      comment: "Total change order amounts across all projects"
    - name: "avg_approved_budget"
      expr: AVG(CAST(approved_budget_amount AS DOUBLE))
      comment: "Average approved budget per project"
    - name: "avg_actual_spend"
      expr: AVG(CAST(actual_spend_to_date AS DOUBLE))
      comment: "Average actual spend per project"
    - name: "esg_initiative_count"
      expr: SUM(CASE WHEN is_esg_initiative = TRUE THEN 1 ELSE 0 END)
      comment: "Count of projects that are ESG initiatives"
    - name: "tenant_improvement_count"
      expr: SUM(CASE WHEN is_tenant_improvement = TRUE THEN 1 ELSE 0 END)
      comment: "Count of tenant improvement projects"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`maintenance_billable_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billable charge revenue and recovery metrics tracking tenant cost allocation, CAM reconciliation, and invoice performance"
  source: "`real_estate_ecm`.`maintenance`.`billable_charge`"
  dimensions:
    - name: "charge_status"
      expr: charge_status
      comment: "Current status of the billable charge"
    - name: "charge_type"
      expr: charge_type
      comment: "Type of billable charge (maintenance, repair, service, etc.)"
    - name: "charge_category"
      expr: charge_category
      comment: "Category of charge for classification"
    - name: "cost_classification"
      expr: cost_classification
      comment: "Cost classification (operating, capital, etc.)"
    - name: "cam_allocation_method"
      expr: cam_allocation_method
      comment: "Method used for CAM allocation"
    - name: "charge_month"
      expr: DATE_TRUNC('MONTH', charge_date)
      comment: "Month when charge was incurred"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month when charge was invoiced"
    - name: "is_cam_reconciliation_charge_flag"
      expr: is_cam_reconciliation_charge
      comment: "Whether charge is part of CAM reconciliation"
    - name: "lease_structure_type"
      expr: lease_structure_type
      comment: "Type of lease structure (gross, net, modified gross)"
  measures:
    - name: "total_billable_charges"
      expr: COUNT(1)
      comment: "Total number of billable charges"
    - name: "total_gross_charge_amount"
      expr: SUM(CAST(gross_charge_amount AS DOUBLE))
      comment: "Total gross charge amount before adjustments"
    - name: "total_tenant_allocated_amount"
      expr: SUM(CAST(tenant_allocated_amount AS DOUBLE))
      comment: "Total amount allocated to tenants"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on billable charges"
    - name: "total_invoiced_amount"
      expr: SUM(CAST(total_invoiced_amount AS DOUBLE))
      comment: "Total invoiced amount including taxes and adjustments"
    - name: "total_estimated_cam_paid"
      expr: SUM(CAST(estimated_cam_paid AS DOUBLE))
      comment: "Total estimated CAM payments received"
    - name: "avg_gross_charge_amount"
      expr: AVG(CAST(gross_charge_amount AS DOUBLE))
      comment: "Average gross charge amount per charge"
    - name: "avg_tenant_pro_rata_share"
      expr: AVG(CAST(tenant_pro_rata_share AS DOUBLE))
      comment: "Average tenant pro-rata share percentage"
    - name: "cam_reconciliation_charge_count"
      expr: SUM(CASE WHEN is_cam_reconciliation_charge = TRUE THEN 1 ELSE 0 END)
      comment: "Count of charges that are CAM reconciliation items"
    - name: "disputed_charge_count"
      expr: SUM(CASE WHEN dispute_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of charges that have been disputed by tenants"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`maintenance_building_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Building asset lifecycle and condition metrics tracking depreciation, replacement planning, and maintenance readiness"
  source: "`real_estate_ecm`.`maintenance`.`building_asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Current operational status of the asset"
    - name: "asset_type"
      expr: asset_type
      comment: "Type of building asset (HVAC, elevator, boiler, etc.)"
    - name: "asset_category"
      expr: asset_category
      comment: "Category classification of the asset"
    - name: "asset_criticality"
      expr: asset_criticality
      comment: "Criticality rating (critical, high, medium, low)"
    - name: "condition_rating"
      expr: condition_rating
      comment: "Current condition rating of the asset"
    - name: "capex_opex_classification"
      expr: capex_opex_classification
      comment: "Capital vs operational expense classification"
    - name: "installation_year"
      expr: YEAR(installation_date)
      comment: "Year when asset was installed"
    - name: "energy_rated_flag"
      expr: energy_rated
      comment: "Whether asset has energy efficiency rating"
    - name: "regulatory_inspection_required_flag"
      expr: regulatory_inspection_required
      comment: "Whether asset requires regulatory inspection"
    - name: "is_tenant_owned_flag"
      expr: is_tenant_owned
      comment: "Whether asset is tenant-owned"
  measures:
    - name: "total_building_assets"
      expr: COUNT(1)
      comment: "Total number of building assets"
    - name: "total_purchase_cost"
      expr: SUM(CAST(purchase_cost AS DOUBLE))
      comment: "Total purchase cost of all assets"
    - name: "total_replacement_cost"
      expr: SUM(CAST(replacement_cost AS DOUBLE))
      comment: "Total replacement cost of all assets"
    - name: "avg_purchase_cost"
      expr: AVG(CAST(purchase_cost AS DOUBLE))
      comment: "Average purchase cost per asset"
    - name: "avg_replacement_cost"
      expr: AVG(CAST(replacement_cost AS DOUBLE))
      comment: "Average replacement cost per asset"
    - name: "avg_remaining_useful_life_years"
      expr: AVG(CAST(remaining_useful_life_years AS DOUBLE))
      comment: "Average remaining useful life in years across assets"
    - name: "critical_asset_count"
      expr: SUM(CASE WHEN asset_criticality = 'critical' THEN 1 ELSE 0 END)
      comment: "Count of assets classified as critical"
    - name: "energy_rated_asset_count"
      expr: SUM(CASE WHEN energy_rated = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assets with energy efficiency ratings"
    - name: "regulatory_inspection_required_count"
      expr: SUM(CASE WHEN regulatory_inspection_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assets requiring regulatory inspection"
    - name: "warranty_active_count"
      expr: SUM(CASE WHEN manufacturer_warranty_expiry >= CURRENT_DATE THEN 1 ELSE 0 END)
      comment: "Count of assets with active manufacturer warranty"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`maintenance_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety incident tracking and compliance metrics for OSHA recordability, severity analysis, and corrective action management"
  source: "`real_estate_ecm`.`maintenance`.`safety_incident`"
  dimensions:
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the safety incident"
    - name: "incident_type"
      expr: incident_type
      comment: "Type of safety incident"
    - name: "incident_category"
      expr: incident_category
      comment: "Category classification of the incident"
    - name: "injury_nature"
      expr: injury_nature
      comment: "Nature of injury sustained"
    - name: "injured_party_type"
      expr: injured_party_type
      comment: "Type of injured party (employee, contractor, tenant, visitor)"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', CAST(incident_timestamp AS DATE))
      comment: "Month when incident occurred"
    - name: "is_osha_recordable_flag"
      expr: is_osha_recordable
      comment: "Whether incident is OSHA recordable"
    - name: "is_environmental_release_flag"
      expr: is_environmental_release
      comment: "Whether incident involved environmental release"
    - name: "esg_reportable_flag"
      expr: esg_reportable
      comment: "Whether incident is reportable for ESG purposes"
    - name: "capex_opex_classification"
      expr: capex_opex_classification
      comment: "Capital vs operational expense classification for remediation"
  measures:
    - name: "total_safety_incidents"
      expr: COUNT(1)
      comment: "Total number of safety incidents"
    - name: "total_estimated_remediation_cost"
      expr: SUM(CAST(estimated_remediation_cost AS DOUBLE))
      comment: "Total estimated cost to remediate all incidents"
    - name: "avg_estimated_remediation_cost"
      expr: AVG(CAST(estimated_remediation_cost AS DOUBLE))
      comment: "Average estimated remediation cost per incident"
    - name: "osha_recordable_count"
      expr: SUM(CASE WHEN is_osha_recordable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of OSHA recordable incidents"
    - name: "environmental_release_count"
      expr: SUM(CASE WHEN is_environmental_release = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents involving environmental release"
    - name: "esg_reportable_count"
      expr: SUM(CASE WHEN esg_reportable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents reportable for ESG purposes"
    - name: "employee_injury_count"
      expr: SUM(CASE WHEN injured_party_type = 'employee' THEN 1 ELSE 0 END)
      comment: "Count of incidents involving employee injuries"
    - name: "contractor_injury_count"
      expr: SUM(CASE WHEN injured_party_type = 'contractor' THEN 1 ELSE 0 END)
      comment: "Count of incidents involving contractor injuries"
    - name: "corrective_action_overdue_count"
      expr: SUM(CASE WHEN corrective_action_due_date < CURRENT_DATE AND corrective_action_completed_date IS NULL THEN 1 ELSE 0 END)
      comment: "Count of incidents with overdue corrective actions"
    - name: "investigation_pending_count"
      expr: SUM(CASE WHEN investigation_completed_date IS NULL THEN 1 ELSE 0 END)
      comment: "Count of incidents with pending investigations"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`maintenance_vendor_dispatch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor dispatch performance metrics tracking response times, cost efficiency, and SLA compliance for external service providers"
  source: "`real_estate_ecm`.`maintenance`.`vendor_dispatch`"
  dimensions:
    - name: "dispatch_status"
      expr: dispatch_status
      comment: "Current status of the vendor dispatch"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the dispatch"
    - name: "service_category"
      expr: service_category
      comment: "Category of service being dispatched"
    - name: "trade_type"
      expr: trade_type
      comment: "Trade or skill type required"
    - name: "capex_opex_classification"
      expr: capex_opex_classification
      comment: "Capital vs operational expense classification"
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month when dispatch was scheduled"
    - name: "sla_response_met_flag"
      expr: sla_response_met
      comment: "Whether SLA response time was met"
    - name: "sla_resolution_met_flag"
      expr: sla_resolution_met
      comment: "Whether SLA resolution time was met"
    - name: "is_cam_billable_flag"
      expr: is_cam_billable
      comment: "Whether dispatch is billable to CAM"
    - name: "is_return_visit_flag"
      expr: is_return_visit
      comment: "Whether dispatch is a return visit for same issue"
  measures:
    - name: "total_vendor_dispatches"
      expr: COUNT(1)
      comment: "Total number of vendor dispatches"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated cost for all dispatches"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost for all dispatches"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Average estimated cost per dispatch"
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost_amount AS DOUBLE))
      comment: "Average actual cost per dispatch"
    - name: "avg_sla_response_target_hours"
      expr: AVG(CAST(sla_response_target_hours AS DOUBLE))
      comment: "Average SLA response target in hours"
    - name: "avg_sla_resolution_target_hours"
      expr: AVG(CAST(sla_resolution_target_hours AS DOUBLE))
      comment: "Average SLA resolution target in hours"
    - name: "sla_response_met_count"
      expr: SUM(CASE WHEN sla_response_met = TRUE THEN 1 ELSE 0 END)
      comment: "Count of dispatches that met SLA response time"
    - name: "sla_resolution_met_count"
      expr: SUM(CASE WHEN sla_resolution_met = TRUE THEN 1 ELSE 0 END)
      comment: "Count of dispatches that met SLA resolution time"
    - name: "return_visit_count"
      expr: SUM(CASE WHEN is_return_visit = TRUE THEN 1 ELSE 0 END)
      comment: "Count of dispatches that are return visits indicating incomplete initial resolution"
    - name: "cam_billable_count"
      expr: SUM(CASE WHEN is_cam_billable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of dispatches billable to CAM"
$$;