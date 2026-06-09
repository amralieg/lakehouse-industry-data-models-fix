-- Metric views for domain: agreement | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-06 23:23:25

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`agreement_study_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core financial and operational metrics for study contracts - the primary commercial agreements between CRO and sponsors governing clinical trial execution."
  source: "`clinical_trials_ecm`.`agreement`.`study_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current lifecycle status of the study contract (e.g., Active, Expired, Terminated, Under Negotiation)"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract arrangement (e.g., Full Service, Functional Service Provider, Hybrid)"
    - name: "phase"
      expr: phase
      comment: "Clinical trial phase covered by the contract (Phase I-IV)"
    - name: "currency_code"
      expr: currency_code
      comment: "Contract billing currency for financial segmentation"
    - name: "governing_law_country"
      expr: governing_law_country
      comment: "Jurisdiction governing the contract for regulatory and legal analysis"
    - name: "negotiation_status"
      expr: negotiation_status
      comment: "Current negotiation stage of the contract"
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "How often billing occurs under the contract"
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the contract became effective for cohort analysis"
  measures:
    - name: "total_contracted_value_sum"
      expr: SUM(CAST(total_contracted_value AS DOUBLE))
      comment: "Total sum of all contracted values representing the full financial commitment across study contracts"
    - name: "current_contracted_value_sum"
      expr: SUM(CAST(current_contracted_value AS DOUBLE))
      comment: "Sum of current contracted values reflecting the latest amended/adjusted contract amounts"
    - name: "service_fee_budget_sum"
      expr: SUM(CAST(service_fee_budget AS DOUBLE))
      comment: "Total service fee budget across contracts - represents CRO revenue potential from professional services"
    - name: "pass_through_budget_sum"
      expr: SUM(CAST(pass_through_budget AS DOUBLE))
      comment: "Total pass-through budget across contracts - costs reimbursed by sponsor (e.g., investigator payments, lab fees)"
    - name: "avg_contracted_value"
      expr: AVG(CAST(total_contracted_value AS DOUBLE))
      comment: "Average contract value indicating deal size and pricing trends"
    - name: "avg_indemnification_cap"
      expr: AVG(CAST(indemnification_cap AS DOUBLE))
      comment: "Average indemnification cap indicating risk exposure levels across the contract portfolio"
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN 1 END)
      comment: "Number of currently active study contracts representing ongoing revenue-generating engagements"
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of study contracts for portfolio sizing and trend analysis"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`agreement_change_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics tracking change orders to study contracts - critical for understanding scope creep, budget variance, and contract amendment velocity in clinical trials."
  source: "`clinical_trials_ecm`.`agreement`.`change_order`"
  dimensions:
    - name: "co_status"
      expr: co_status
      comment: "Current status of the change order (e.g., Draft, Pending Approval, Approved, Rejected)"
    - name: "change_type"
      expr: change_type
      comment: "Category of change (e.g., Scope Expansion, Timeline Extension, Budget Increase)"
    - name: "change_reason"
      expr: change_reason
      comment: "Root cause driving the change order (e.g., Protocol Amendment, Enrollment Challenges, Regulatory Requirement)"
    - name: "priority"
      expr: priority
      comment: "Urgency level of the change order"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the financial impact for the change order"
    - name: "regulatory_driven_flag"
      expr: regulatory_driven_flag
      comment: "Whether the change order was triggered by a regulatory requirement"
    - name: "initiation_year_month"
      expr: DATE_TRUNC('MONTH', initiation_date)
      comment: "Month of change order initiation for trend analysis"
  measures:
    - name: "total_delta_value"
      expr: SUM(CAST(delta_value AS DOUBLE))
      comment: "Net financial impact of all change orders - positive indicates budget increases, negative indicates reductions"
    - name: "total_service_fee_delta"
      expr: SUM(CAST(service_fee_delta AS DOUBLE))
      comment: "Total change in service fees from change orders - directly impacts CRO revenue"
    - name: "total_pass_through_delta"
      expr: SUM(CAST(pass_through_delta AS DOUBLE))
      comment: "Total change in pass-through costs from change orders"
    - name: "avg_delta_value"
      expr: AVG(CAST(delta_value AS DOUBLE))
      comment: "Average financial impact per change order indicating typical scope change magnitude"
    - name: "approved_change_order_count"
      expr: COUNT(CASE WHEN co_status = 'Approved' THEN 1 END)
      comment: "Number of approved change orders representing confirmed scope/budget changes"
    - name: "pending_change_order_count"
      expr: COUNT(CASE WHEN co_status IN ('Pending Approval', 'Under Review') THEN 1 END)
      comment: "Number of change orders awaiting approval - indicates decision backlog"
    - name: "regulatory_driven_count"
      expr: COUNT(CASE WHEN regulatory_driven_flag = TRUE THEN 1 END)
      comment: "Count of change orders driven by regulatory requirements - non-discretionary changes"
    - name: "change_order_count"
      expr: COUNT(1)
      comment: "Total number of change orders for volume and velocity tracking"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`agreement_billing_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing milestone metrics tracking revenue recognition triggers, payment collection, and milestone completion rates for clinical trial contracts."
  source: "`clinical_trials_ecm`.`agreement`.`agreement_billing_milestone`"
  dimensions:
    - name: "billing_status"
      expr: billing_status
      comment: "Current billing status of the milestone (e.g., Pending, Invoiced, Paid, Disputed)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the milestone achievement"
    - name: "milestone_type"
      expr: milestone_type
      comment: "Category of milestone (e.g., Enrollment, Database Lock, CSR Delivery)"
    - name: "functional_area"
      expr: functional_area
      comment: "Functional department responsible for the milestone (e.g., Clinical Operations, Data Management, Biostatistics)"
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency for the milestone"
    - name: "revenue_recognition_method"
      expr: revenue_recognition_method
      comment: "Method used for revenue recognition (e.g., Percentage of Completion, Milestone Method)"
    - name: "is_pass_through"
      expr: is_pass_through
      comment: "Whether the milestone represents a pass-through cost vs. service fee"
    - name: "planned_trigger_month"
      expr: DATE_TRUNC('MONTH', planned_trigger_date)
      comment: "Planned month for milestone trigger for forecasting"
  measures:
    - name: "total_milestone_amount"
      expr: SUM(CAST(milestone_amount AS DOUBLE))
      comment: "Total value of billing milestones representing contracted revenue pipeline"
    - name: "total_adjusted_amount"
      expr: SUM(CAST(adjusted_amount AS DOUBLE))
      comment: "Total adjusted milestone amounts after change orders or negotiations"
    - name: "avg_milestone_amount"
      expr: AVG(CAST(milestone_amount AS DOUBLE))
      comment: "Average milestone value for pricing and forecasting analysis"
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average completion percentage across milestones indicating overall contract execution progress"
    - name: "invoiced_milestone_count"
      expr: COUNT(CASE WHEN billing_status = 'Invoiced' THEN 1 END)
      comment: "Number of milestones that have been invoiced but not yet paid"
    - name: "paid_milestone_count"
      expr: COUNT(CASE WHEN billing_status = 'Paid' THEN 1 END)
      comment: "Number of milestones where payment has been received"
    - name: "disputed_milestone_count"
      expr: COUNT(CASE WHEN billing_status = 'Disputed' THEN 1 END)
      comment: "Number of milestones in dispute - indicates sponsor relationship friction and revenue risk"
    - name: "overdue_milestone_count"
      expr: COUNT(CASE WHEN actual_trigger_date IS NULL AND planned_trigger_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of milestones past their planned trigger date without achievement - indicates delivery risk"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`agreement_deliverable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deliverable performance metrics tracking on-time delivery, quality, and effort efficiency for contracted clinical trial outputs."
  source: "`clinical_trials_ecm`.`agreement`.`deliverable`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the deliverable (e.g., Not Started, In Progress, Delivered, Accepted, Rejected)"
    - name: "deliverable_type"
      expr: deliverable_type
      comment: "Type of deliverable (e.g., Report, Database, Submission Package)"
    - name: "deliverable_category"
      expr: deliverable_category
      comment: "Broader category grouping of deliverables"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the deliverable"
    - name: "responsible_functional_team"
      expr: responsible_functional_team
      comment: "Functional team responsible for producing the deliverable"
    - name: "qc_review_status"
      expr: qc_review_status
      comment: "Quality control review status of the deliverable"
    - name: "sla_met_flag"
      expr: sla_met_flag
      comment: "Whether the deliverable met its SLA target"
    - name: "planned_delivery_month"
      expr: DATE_TRUNC('MONTH', planned_delivery_date)
      comment: "Planned delivery month for workload and capacity planning"
  measures:
    - name: "total_contracted_value_usd"
      expr: SUM(CAST(contracted_value_usd AS DOUBLE))
      comment: "Total contracted value of deliverables in USD representing revenue tied to specific outputs"
    - name: "total_actual_effort_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE))
      comment: "Total actual effort hours spent on deliverables for resource utilization analysis"
    - name: "total_estimated_effort_hours"
      expr: SUM(CAST(estimated_effort_hours AS DOUBLE))
      comment: "Total estimated effort hours for deliverables - baseline for efficiency comparison"
    - name: "avg_actual_effort_hours"
      expr: AVG(CAST(actual_effort_hours AS DOUBLE))
      comment: "Average actual effort per deliverable for capacity planning and estimation improvement"
    - name: "sla_met_count"
      expr: COUNT(CASE WHEN sla_met_flag = TRUE THEN 1 END)
      comment: "Number of deliverables meeting SLA targets - key quality and performance indicator"
    - name: "rejected_deliverable_count"
      expr: COUNT(CASE WHEN delivery_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected deliverables indicating quality issues requiring rework"
    - name: "overdue_deliverable_count"
      expr: COUNT(CASE WHEN actual_delivery_date IS NULL AND planned_delivery_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of deliverables past their planned delivery date without completion"
    - name: "deliverable_count"
      expr: COUNT(1)
      comment: "Total number of deliverables for volume and workload analysis"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`agreement_investigator_grant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Investigator grant metrics tracking site-level financial commitments, fair market value compliance, and payment structures for clinical trial investigators."
  source: "`clinical_trials_ecm`.`agreement`.`investigator_grant`"
  dimensions:
    - name: "grant_type"
      expr: grant_type
      comment: "Type of investigator grant (e.g., Per-Patient, Fixed Fee, Milestone-Based)"
    - name: "negotiation_status"
      expr: negotiation_status
      comment: "Current negotiation status of the grant agreement"
    - name: "country_code"
      expr: country_code
      comment: "Country where the investigator site is located for geographic analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Payment currency for the grant"
    - name: "payment_schedule_type"
      expr: payment_schedule_type
      comment: "How payments are scheduled (e.g., Monthly, Per Visit, Milestone)"
    - name: "fair_market_value_verified"
      expr: fair_market_value_verified
      comment: "Whether the grant amount has been verified against fair market value benchmarks - critical for compliance"
    - name: "sunshine_act_reportable"
      expr: sunshine_act_reportable
      comment: "Whether the grant is reportable under Sunshine Act/transparency regulations"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the grant became effective for cohort and trend analysis"
  measures:
    - name: "total_grant_value_sum"
      expr: SUM(CAST(total_grant_value AS DOUBLE))
      comment: "Total financial commitment across all investigator grants"
    - name: "total_service_fee_budget"
      expr: SUM(CAST(service_fee_budget AS DOUBLE))
      comment: "Total service fee budget allocated to investigators for professional services"
    - name: "total_pass_through_budget"
      expr: SUM(CAST(pass_through_budget AS DOUBLE))
      comment: "Total pass-through budget for investigator-related costs (lab kits, shipping, etc.)"
    - name: "avg_grant_value"
      expr: AVG(CAST(total_grant_value AS DOUBLE))
      comment: "Average grant value per investigator for benchmarking and budgeting"
    - name: "avg_overhead_percentage"
      expr: AVG(CAST(overhead_percentage AS DOUBLE))
      comment: "Average overhead percentage charged by institutions - impacts total cost to sponsor"
    - name: "total_screen_failure_payment"
      expr: SUM(CAST(screen_failure_payment_amount AS DOUBLE))
      comment: "Total screen failure payments representing cost of unsuccessful patient screening"
    - name: "fmv_verified_grant_count"
      expr: COUNT(CASE WHEN fair_market_value_verified = TRUE THEN 1 END)
      comment: "Number of grants with verified fair market value - compliance readiness indicator"
    - name: "grant_count"
      expr: COUNT(1)
      comment: "Total number of investigator grants for portfolio sizing"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`agreement_scope_of_work`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Scope of work metrics tracking service scope, budget allocation, and geographic coverage for clinical trial service agreements."
  source: "`clinical_trials_ecm`.`agreement`.`scope_of_work`"
  dimensions:
    - name: "sow_type"
      expr: sow_type
      comment: "Type of scope of work (e.g., Full Service, Functional, Standalone)"
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the scope of work"
    - name: "payment_model"
      expr: payment_model
      comment: "Payment model governing the SOW (e.g., Unit-Based, Fixed Fee, Time & Materials)"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic coverage of the scope of work (e.g., Global, Regional, Single Country)"
    - name: "is_current_version"
      expr: is_current_version
      comment: "Whether this is the current active version of the SOW"
    - name: "monitoring_included"
      expr: monitoring_included
      comment: "Whether clinical monitoring services are included in scope"
    - name: "data_management_included"
      expr: data_management_included
      comment: "Whether data management services are included in scope"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the SOW became effective"
  measures:
    - name: "total_contract_value_sum"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total contracted value across all scopes of work"
    - name: "total_service_fee_budget"
      expr: SUM(CAST(service_fee_budget AS DOUBLE))
      comment: "Total service fee budget across SOWs representing CRO revenue from professional services"
    - name: "total_pass_through_budget"
      expr: SUM(CAST(pass_through_budget AS DOUBLE))
      comment: "Total pass-through budget across SOWs"
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average SOW contract value for deal sizing and pricing analysis"
    - name: "current_version_count"
      expr: COUNT(CASE WHEN is_current_version = TRUE THEN 1 END)
      comment: "Number of current/active SOW versions representing the live contract portfolio"
    - name: "sow_count"
      expr: COUNT(1)
      comment: "Total number of scope of work records"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`agreement_service_level_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA metrics tracking performance thresholds, penalty exposure, and compliance commitments across clinical trial service agreements."
  source: "`clinical_trials_ecm`.`agreement`.`service_level_agreement`"
  dimensions:
    - name: "sla_status"
      expr: sla_status
      comment: "Current status of the SLA (e.g., Active, Expired, Superseded)"
    - name: "sla_type"
      expr: sla_type
      comment: "Type of SLA (e.g., Turnaround Time, Quality, Enrollment Rate)"
    - name: "service_category"
      expr: service_category
      comment: "Service category the SLA applies to (e.g., Data Management, Monitoring, Safety)"
    - name: "measurement_frequency"
      expr: measurement_frequency
      comment: "How often the SLA is measured (e.g., Monthly, Quarterly, Per Deliverable)"
    - name: "penalty_applicable"
      expr: penalty_applicable
      comment: "Whether financial penalties apply for SLA breach"
    - name: "credit_applicable"
      expr: credit_applicable
      comment: "Whether service credits apply for SLA breach"
    - name: "regulatory_commitment_flag"
      expr: regulatory_commitment_flag
      comment: "Whether the SLA is tied to a regulatory commitment - higher risk if breached"
  measures:
    - name: "total_penalty_value"
      expr: SUM(CAST(penalty_value AS DOUBLE))
      comment: "Total potential penalty value across SLAs representing maximum financial exposure for non-performance"
    - name: "total_penalty_cap_value"
      expr: SUM(CAST(penalty_cap_value AS DOUBLE))
      comment: "Total penalty cap across SLAs - maximum aggregate penalty exposure"
    - name: "total_credit_value"
      expr: SUM(CAST(credit_value AS DOUBLE))
      comment: "Total service credit value across SLAs"
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average SLA threshold value for benchmarking performance targets"
    - name: "penalty_applicable_count"
      expr: COUNT(CASE WHEN penalty_applicable = TRUE THEN 1 END)
      comment: "Number of SLAs with financial penalties - indicates risk-bearing commitments"
    - name: "regulatory_sla_count"
      expr: COUNT(CASE WHEN regulatory_commitment_flag = TRUE THEN 1 END)
      comment: "Number of SLAs tied to regulatory commitments - highest priority for compliance"
    - name: "active_sla_count"
      expr: COUNT(CASE WHEN sla_status = 'Active' THEN 1 END)
      comment: "Number of currently active SLAs being monitored"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`agreement_contract_negotiation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract negotiation metrics tracking deal velocity, value, and escalation patterns to optimize the contracting process for clinical trials."
  source: "`clinical_trials_ecm`.`agreement`.`contract_negotiation`"
  dimensions:
    - name: "negotiation_status"
      expr: negotiation_status
      comment: "Current status of the negotiation (e.g., In Progress, Completed, Terminated)"
    - name: "negotiation_type"
      expr: negotiation_type
      comment: "Type of negotiation (e.g., New Contract, Amendment, Renewal)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the negotiation"
    - name: "negotiation_channel"
      expr: negotiation_channel
      comment: "Channel through which negotiation is conducted"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the negotiation has been escalated"
    - name: "payment_model"
      expr: payment_model
      comment: "Payment model being negotiated"
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the negotiation"
    - name: "negotiation_start_month"
      expr: DATE_TRUNC('MONTH', negotiation_start_date)
      comment: "Month negotiation started for pipeline and velocity analysis"
  measures:
    - name: "total_negotiated_contract_value"
      expr: SUM(CAST(negotiated_contract_value AS DOUBLE))
      comment: "Total value of contracts under negotiation representing revenue pipeline"
    - name: "total_service_fee_value"
      expr: SUM(CAST(service_fee_value AS DOUBLE))
      comment: "Total service fee value in negotiation pipeline"
    - name: "total_pass_through_value"
      expr: SUM(CAST(pass_through_value AS DOUBLE))
      comment: "Total pass-through value in negotiation pipeline"
    - name: "avg_negotiated_value"
      expr: AVG(CAST(negotiated_contract_value AS DOUBLE))
      comment: "Average negotiated contract value for deal sizing"
    - name: "escalated_negotiation_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of escalated negotiations indicating complexity or relationship friction"
    - name: "terminated_negotiation_count"
      expr: COUNT(CASE WHEN termination_flag = TRUE THEN 1 END)
      comment: "Number of terminated negotiations representing lost opportunities"
    - name: "negotiation_count"
      expr: COUNT(1)
      comment: "Total number of negotiations for pipeline volume tracking"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`agreement_subcontract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subcontract metrics tracking third-party vendor spend, compliance, and performance for outsourced clinical trial services."
  source: "`clinical_trials_ecm`.`agreement`.`subcontract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the subcontract"
    - name: "subcontract_type"
      expr: subcontract_type
      comment: "Type of subcontracted service (e.g., Central Lab, IVRS, Imaging)"
    - name: "payment_model"
      expr: payment_model
      comment: "Payment model for the subcontract"
    - name: "governing_law_country"
      expr: governing_law_country
      comment: "Jurisdiction governing the subcontract"
    - name: "sponsor_approval_status"
      expr: sponsor_approval_status
      comment: "Whether the sponsor has approved the subcontractor"
    - name: "gcp_compliance_required"
      expr: gcp_compliance_required
      comment: "Whether GCP compliance is required for the subcontractor"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic coverage of the subcontract"
  measures:
    - name: "total_subcontract_value"
      expr: SUM(CAST(subcontract_value AS DOUBLE))
      comment: "Total value of all subcontracts representing outsourced spend"
    - name: "total_service_fee_amount"
      expr: SUM(CAST(service_fee_amount AS DOUBLE))
      comment: "Total service fees paid to subcontractors"
    - name: "total_pass_through_amount"
      expr: SUM(CAST(pass_through_amount AS DOUBLE))
      comment: "Total pass-through amounts flowing through subcontracts"
    - name: "avg_subcontract_value"
      expr: AVG(CAST(subcontract_value AS DOUBLE))
      comment: "Average subcontract value for vendor spend benchmarking"
    - name: "avg_liability_cap"
      expr: AVG(CAST(liability_cap_amount AS DOUBLE))
      comment: "Average liability cap across subcontracts indicating risk transfer levels"
    - name: "active_subcontract_count"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN 1 END)
      comment: "Number of active subcontracts representing current vendor relationships"
    - name: "subcontract_count"
      expr: COUNT(1)
      comment: "Total number of subcontracts for vendor portfolio sizing"
$$;