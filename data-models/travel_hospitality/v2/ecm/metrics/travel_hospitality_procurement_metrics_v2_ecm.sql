-- Metric views for domain: procurement | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-22 18:44:46

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_vendor_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance scorecard KPIs measuring delivery reliability, quality acceptance, invoice accuracy, and overall vendor score to drive supplier relationship management decisions."
  source: "`vibe_travel_hospitality_v1`.`procurement`.`vendor_performance`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where vendor performance was evaluated, enabling property-level supplier benchmarking."
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current status of the vendor evaluation (e.g., Completed, In Progress, Pending)."
    - name: "evaluation_period_start_date"
      expr: DATE_TRUNC('month', evaluation_period_start_date)
      comment: "Month bucket of evaluation period start for trend analysis."
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Indicates whether the vendor holds preferred status, enabling preferred vs. non-preferred comparison."
    - name: "qualified_vendor_flag"
      expr: qualified_vendor_flag
      comment: "Indicates whether the vendor is qualified, supporting vendor tier analysis."
    - name: "sustainability_compliance_flag"
      expr: sustainability_compliance_flag
      comment: "Whether the vendor meets sustainability compliance requirements."
  measures:
    - name: "avg_overall_vendor_score"
      expr: AVG(CAST(overall_vendor_score AS DOUBLE))
      comment: "Average overall vendor performance score across evaluations. Executives use this to rank and tier suppliers and make contract renewal decisions."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate (%) across vendor evaluations. A drop triggers supplier escalation or sourcing strategy review."
    - name: "avg_quality_acceptance_rate"
      expr: AVG(CAST(quality_acceptance_rate AS DOUBLE))
      comment: "Average quality acceptance rate (%) measuring the proportion of goods accepted without rejection. Directly tied to operational quality and waste cost."
    - name: "avg_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate AS DOUBLE))
      comment: "Average invoice accuracy rate (%) across vendors. Low accuracy drives AP processing cost and dispute resolution overhead."
    - name: "avg_contract_compliance_score"
      expr: AVG(CAST(contract_compliance_score AS DOUBLE))
      comment: "Average contract compliance score measuring adherence to agreed terms. Informs contract renewal and penalty clause activation."
    - name: "avg_cost_competitiveness_rating"
      expr: AVG(CAST(cost_competitiveness_rating AS DOUBLE))
      comment: "Average cost competitiveness rating across vendors. Used in sourcing strategy reviews to identify overpriced suppliers."
    - name: "total_spend_amount"
      expr: SUM(CAST(total_spend_amount AS DOUBLE))
      comment: "Total procurement spend across evaluated vendors. Core financial KPI for spend management and budget adherence."
    - name: "vendor_evaluation_count"
      expr: COUNT(1)
      comment: "Number of vendor performance evaluations completed. Indicates coverage of the vendor base and evaluation program health."
    - name: "avg_responsiveness_rating"
      expr: AVG(CAST(responsiveness_rating AS DOUBLE))
      comment: "Average vendor responsiveness rating. Low responsiveness is an early warning indicator for supply chain disruption risk."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order financial and operational KPIs covering spend commitment, delivery performance, and PO lifecycle management for procurement governance."
  source: "`vibe_travel_hospitality_v1`.`procurement`.`purchase_order`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the purchase order for property-level spend analysis."
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order (e.g., Open, Closed, Cancelled) for pipeline analysis."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g., Standard, Blanket, Service) for spend categorization."
    - name: "po_date_month"
      expr: DATE_TRUNC('month', po_date)
      comment: "Month of PO creation for spend trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the purchase order for multi-currency spend reporting."
    - name: "goods_receipt_completed_flag"
      expr: goods_receipt_completed_flag
      comment: "Whether goods receipt has been completed, enabling open PO liability tracking."
    - name: "invoice_receipt_completed_flag"
      expr: invoice_receipt_completed_flag
      comment: "Whether invoice receipt is completed, supporting 3-way match status analysis."
  measures:
    - name: "total_po_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total committed spend across all purchase orders. Core procurement spend KPI used in budget vs. actuals reporting."
    - name: "total_po_amount_with_tax"
      expr: SUM(CAST(total_amount_with_tax AS DOUBLE))
      comment: "Total PO value including tax. Used for cash flow forecasting and tax liability reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across purchase orders. Supports tax compliance and reclaim analysis."
    - name: "total_commitment_released_amount"
      expr: SUM(CAST(commitment_released_amount AS DOUBLE))
      comment: "Total budget commitment released from closed or cancelled POs. Indicates freed budget available for reallocation."
    - name: "purchase_order_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders issued. Baseline volume metric for procurement workload and process efficiency."
    - name: "avg_po_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average purchase order value. Tracks order size trends and informs procurement consolidation opportunities."
    - name: "open_po_count"
      expr: COUNT(CASE WHEN po_status = 'Open' THEN 1 END)
      comment: "Number of open purchase orders representing outstanding financial commitments. Used in cash flow and liability management."
    - name: "goods_receipt_pending_count"
      expr: COUNT(CASE WHEN goods_receipt_completed_flag = FALSE THEN 1 END)
      comment: "Number of POs awaiting goods receipt. Indicates supply chain pipeline and potential delivery delays."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_vendor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable and invoice processing KPIs measuring invoice accuracy, dispute rates, payment performance, and three-way match compliance for financial control."
  source: "`vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the vendor invoice for property-level AP analysis."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current invoice processing status (e.g., Approved, Disputed, Paid) for AP pipeline management."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., Standard, Credit Memo, Recurring) for spend categorization."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of invoice date for AP trend and aging analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency AP reporting."
    - name: "three_way_match_flag"
      expr: three_way_match_flag
      comment: "Whether the invoice passed three-way match (PO/GR/Invoice), a key financial control indicator."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the invoice is under dispute, enabling dispute rate and resolution tracking."
    - name: "early_payment_discount_eligible_flag"
      expr: early_payment_discount_eligible_flag
      comment: "Whether the invoice qualifies for early payment discount, supporting cash management decisions."
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount across all vendor invoices. Core AP liability KPI for cash flow management."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts. Used for actual AP liability and payment run planning."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on vendor invoices. Supports tax compliance and input tax reclaim reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount captured on vendor invoices. Measures procurement savings from negotiated terms."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total value of invoices under dispute. High disputed amounts signal vendor billing quality issues or contract non-compliance."
    - name: "total_match_variance_amount"
      expr: SUM(CAST(match_variance_amount AS DOUBLE))
      comment: "Total three-way match variance amount. Large variances indicate pricing discrepancies between PO, GR, and invoice."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of vendor invoices processed. Baseline AP volume metric for workload and automation benchmarking."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of invoices under dispute. Elevated dispute counts trigger vendor quality reviews and contract renegotiation."
    - name: "three_way_match_pass_count"
      expr: COUNT(CASE WHEN three_way_match_flag = TRUE THEN 1 END)
      comment: "Number of invoices that passed three-way match. Measures financial control effectiveness and AP automation readiness."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice amount. Tracks invoice size trends and informs payment run batching strategy."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt quality and quantity KPIs measuring acceptance rates, rejection rates, variance, and receiving efficiency to manage supply chain quality and vendor compliance."
  source: "`vibe_travel_hospitality_v1`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where goods were received for property-level receiving performance analysis."
    - name: "gr_status"
      expr: gr_status
      comment: "Status of the goods receipt (e.g., Posted, Cancelled, Pending) for pipeline management."
    - name: "receipt_date_month"
      expr: DATE_TRUNC('month', receipt_date)
      comment: "Month of goods receipt for trend analysis of receiving volumes and quality."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection outcome (e.g., Passed, Failed, Pending) for quality control reporting."
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Whether a quantity or quality discrepancy was recorded at receipt."
    - name: "quality_rejection_flag"
      expr: quality_rejection_flag
      comment: "Whether goods were rejected on quality grounds, enabling rejection rate analysis."
    - name: "capex_opex_indicator"
      expr: capex_opex_indicator
      comment: "CapEx vs. OpEx classification of received goods for financial reporting."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match status at goods receipt level for AP control analysis."
  measures:
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity of goods received. Core supply chain volume KPI for inventory replenishment tracking."
    - name: "total_accepted_quantity"
      expr: SUM(CAST(accepted_quantity AS DOUBLE))
      comment: "Total quantity accepted after inspection. Measures effective supply inflow net of rejections."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected at goods receipt. High rejection volumes trigger vendor quality escalation and sourcing review."
    - name: "total_receipt_value"
      expr: SUM(CAST(total_value_amount AS DOUBLE))
      comment: "Total value of goods received. Used for inventory valuation, CapEx tracking, and budget consumption reporting."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total financial variance between ordered and received quantities. Large variances indicate supply reliability issues."
    - name: "total_freight_charges"
      expr: SUM(CAST(freight_charges_amount AS DOUBLE))
      comment: "Total freight charges incurred on goods receipts. Supports logistics cost management and vendor freight term negotiations."
    - name: "goods_receipt_count"
      expr: COUNT(1)
      comment: "Total number of goods receipts processed. Baseline receiving volume metric for warehouse staffing and dock scheduling."
    - name: "discrepancy_receipt_count"
      expr: COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END)
      comment: "Number of receipts with discrepancies. Elevated counts signal vendor packing/shipping quality issues."
    - name: "avg_receipt_value"
      expr: AVG(CAST(total_value_amount AS DOUBLE))
      comment: "Average value per goods receipt. Tracks order size trends and informs receiving resource planning."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement contract portfolio KPIs measuring contract value, compliance, renewal risk, and savings to support strategic sourcing governance and vendor relationship management."
  source: "`vibe_travel_hospitality_v1`.`procurement`.`procurement_contract`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the contract for property-level contract portfolio analysis."
    - name: "contract_status"
      expr: contract_status
      comment: "Current contract status (e.g., Active, Expired, Pending Renewal) for contract lifecycle management."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of procurement contract (e.g., Master, Blanket, Service) for portfolio segmentation."
    - name: "effective_date_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year contract became effective for cohort and vintage analysis."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the contract auto-renews, enabling proactive renewal management."
    - name: "capex_designation_flag"
      expr: capex_designation_flag
      comment: "Whether the contract is designated as CapEx for capital expenditure tracking."
    - name: "pip_project_flag"
      expr: pip_project_flag
      comment: "Whether the contract is associated with a Property Improvement Plan project."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for multi-currency portfolio reporting."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total value of all procurement contracts. Core spend commitment KPI for financial planning and vendor dependency analysis."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value. Tracks deal size trends and informs negotiation benchmarking."
    - name: "total_negotiated_discount_pct"
      expr: AVG(CAST(negotiated_discount_percent AS DOUBLE))
      comment: "Average negotiated discount percentage across contracts. Measures procurement savings effectiveness and negotiation performance."
    - name: "avg_sla_on_time_delivery_pct"
      expr: AVG(CAST(sla_on_time_delivery_percent AS DOUBLE))
      comment: "Average contracted SLA for on-time delivery. Baseline for vendor performance measurement against contractual commitments."
    - name: "avg_sla_quality_acceptance_pct"
      expr: AVG(CAST(sla_quality_acceptance_percent AS DOUBLE))
      comment: "Average contracted SLA for quality acceptance. Used to set vendor quality expectations and measure compliance."
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of procurement contracts. Measures contract portfolio size and procurement governance coverage."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN 1 END)
      comment: "Number of currently active contracts. Indicates live vendor commitments and active spend obligations."
    - name: "expiring_contract_count"
      expr: COUNT(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND contract_status = 'Active' THEN 1 END)
      comment: "Number of active contracts expiring within 90 days. Critical renewal risk indicator for procurement leadership."
    - name: "total_minimum_order_quantity"
      expr: SUM(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Total minimum order quantity commitments across contracts. Informs inventory planning and committed volume obligations."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll financial KPIs measuring gross pay, net pay, tax withholding, overtime costs, and payroll composition to support workforce cost management and labor budget governance."
  source: "`vibe_travel_hospitality_v1`.`procurement`.`payroll_run`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the payroll run for property-level labor cost analysis."
    - name: "payroll_run_status"
      expr: payroll_run_status
      comment: "Status of the payroll run (e.g., Completed, In Progress, Failed) for payroll cycle management."
    - name: "payroll_run_type"
      expr: payroll_run_type
      comment: "Type of payroll run (e.g., Regular, Off-Cycle, Adjustment) for payroll cost categorization."
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Pay frequency (e.g., Weekly, Bi-Weekly, Monthly) for payroll cycle analysis."
    - name: "pay_date_month"
      expr: DATE_TRUNC('month', pay_date)
      comment: "Month of pay date for labor cost trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payroll run for multi-currency labor cost reporting."
    - name: "gl_posting_status"
      expr: gl_posting_status
      comment: "GL posting status of the payroll run for financial close management."
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(total_gross_pay AS DOUBLE))
      comment: "Total gross payroll cost across all runs. Primary labor cost KPI for budget vs. actuals and workforce cost management."
    - name: "total_net_pay"
      expr: SUM(CAST(total_net_pay AS DOUBLE))
      comment: "Total net pay disbursed to employees. Cash flow KPI for treasury and payroll funding management."
    - name: "total_overtime_pay"
      expr: SUM(CAST(total_overtime_pay AS DOUBLE))
      comment: "Total overtime pay cost. Elevated overtime signals understaffing or scheduling inefficiency requiring management action."
    - name: "total_bonus_pay"
      expr: SUM(CAST(total_bonus_pay AS DOUBLE))
      comment: "Total bonus pay disbursed. Tracks incentive compensation spend against budget and performance targets."
    - name: "total_employer_taxes"
      expr: SUM(CAST(total_employer_taxes AS DOUBLE))
      comment: "Total employer tax burden across payroll runs. Used for total employment cost modeling and budget planning."
    - name: "total_pre_tax_deductions"
      expr: SUM(CAST(total_pre_tax_deductions AS DOUBLE))
      comment: "Total pre-tax deductions (e.g., 401k, health insurance). Measures benefits utilization and tax-advantaged compensation cost."
    - name: "total_service_charge"
      expr: SUM(CAST(total_service_charge AS DOUBLE))
      comment: "Total service charge distributed through payroll. Hospitality-specific KPI for service charge program management."
    - name: "total_tip_allocation"
      expr: SUM(CAST(total_tip_allocation AS DOUBLE))
      comment: "Total tip allocation processed through payroll. Tracks tip income reporting compliance and employee earnings."
    - name: "avg_gross_pay_per_run"
      expr: AVG(CAST(total_gross_pay AS DOUBLE))
      comment: "Average gross pay per payroll run. Tracks payroll size trends and informs headcount and compensation planning."
    - name: "payroll_run_count"
      expr: COUNT(1)
      comment: "Total number of payroll runs processed. Baseline metric for payroll operations volume and cycle compliance."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor time and cost KPIs measuring regular hours, overtime, labor cost, and scheduling compliance to support workforce productivity and labor budget management."
  source: "`vibe_travel_hospitality_v1`.`procurement`.`time_entry`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where time was worked for property-level labor analysis."
    - name: "entry_date_week"
      expr: DATE_TRUNC('week', entry_date)
      comment: "Week of time entry for weekly labor cost and hours trend analysis."
    - name: "entry_type"
      expr: entry_type
      comment: "Type of time entry (e.g., Regular, Overtime, Holiday) for labor cost categorization."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the time entry for payroll readiness and compliance tracking."
    - name: "payroll_processed_flag"
      expr: payroll_processed_flag
      comment: "Whether the time entry has been processed in payroll, enabling unprocessed hours tracking."
    - name: "edited_flag"
      expr: edited_flag
      comment: "Whether the time entry was manually edited, supporting audit and compliance monitoring."
    - name: "entry_source"
      expr: entry_source
      comment: "Source system of the time entry (e.g., Biometric, Manual, Mobile) for data quality analysis."
  measures:
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours worked. Core labor volume KPI for staffing level analysis and productivity benchmarking."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked. Elevated overtime triggers scheduling review and potential headcount adjustment."
    - name: "total_double_time_hours"
      expr: SUM(CAST(double_time_hours AS DOUBLE))
      comment: "Total double-time hours worked. High double-time indicates critical understaffing or emergency coverage situations."
    - name: "total_hours_worked"
      expr: SUM(CAST(total_hours_worked AS DOUBLE))
      comment: "Total hours worked across all entry types. Baseline labor input metric for productivity and cost-per-hour analysis."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost from time entries. Primary workforce cost KPI for budget vs. actuals and CPOR (cost per occupied room) analysis."
    - name: "total_tips_reported"
      expr: SUM(CAST(tips_reported_amount AS DOUBLE))
      comment: "Total tips reported through time entries. Supports tip income compliance and employee earnings reporting."
    - name: "time_entry_count"
      expr: COUNT(1)
      comment: "Total number of time entries. Baseline metric for time capture volume and payroll processing workload."
    - name: "edited_entry_count"
      expr: COUNT(CASE WHEN edited_flag = TRUE THEN 1 END)
      comment: "Number of manually edited time entries. High edit rates signal time capture system issues or potential compliance risk."
    - name: "avg_labor_cost_per_entry"
      expr: AVG(CAST(labor_cost_amount AS DOUBLE))
      comment: "Average labor cost per time entry. Tracks per-shift cost trends and informs compensation benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor scheduling efficiency KPIs measuring scheduled vs. actual hours, labor cost variance, and forecast accuracy to optimize workforce deployment and control labor costs."
  source: "`vibe_travel_hospitality_v1`.`procurement`.`procurement_schedule`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the schedule for property-level labor planning analysis."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the schedule (e.g., Draft, Published, Finalized) for schedule lifecycle management."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of schedule (e.g., Weekly, Event-Based) for scheduling pattern analysis."
    - name: "period_start_date_month"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Month of schedule period for labor cost trend analysis."
    - name: "is_overtime_approved"
      expr: is_overtime_approved
      comment: "Whether overtime was pre-approved in the schedule, enabling overtime budget compliance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of labor cost figures for multi-currency reporting."
  measures:
    - name: "total_scheduled_hours"
      expr: SUM(CAST(total_scheduled_hours AS DOUBLE))
      comment: "Total hours scheduled across all schedules. Core labor planning KPI for staffing level and coverage analysis."
    - name: "total_actual_hours"
      expr: SUM(CAST(total_actual_hours AS DOUBLE))
      comment: "Total actual hours worked against schedules. Compared to scheduled hours to measure schedule adherence."
    - name: "total_labor_variance_hours"
      expr: SUM(CAST(labor_variance_hours AS DOUBLE))
      comment: "Total variance between scheduled and actual labor hours. Large variances indicate scheduling accuracy issues or demand forecast errors."
    - name: "total_estimated_labor_cost"
      expr: SUM(CAST(estimated_labor_cost AS DOUBLE))
      comment: "Total estimated labor cost from schedules. Used for labor budget planning and pre-period cost forecasting."
    - name: "total_actual_labor_cost"
      expr: SUM(CAST(actual_labor_cost AS DOUBLE))
      comment: "Total actual labor cost incurred. Core labor expense KPI for budget vs. actuals reporting."
    - name: "total_scheduled_fte"
      expr: SUM(CAST(total_scheduled_fte AS DOUBLE))
      comment: "Total scheduled FTE across all schedules. Measures workforce deployment level against budgeted headcount."
    - name: "avg_labor_cost_percentage"
      expr: AVG(CAST(labor_cost_percentage AS DOUBLE))
      comment: "Average labor cost as a percentage of revenue. Key hospitality efficiency ratio used in USALI departmental reporting."
    - name: "avg_forecast_occupancy_rate"
      expr: AVG(CAST(forecast_occupancy_rate AS DOUBLE))
      comment: "Average forecasted occupancy rate used in schedule planning. Measures alignment between demand forecast and labor deployment."
    - name: "avg_cpor_labor"
      expr: AVG(CAST(cpor_labor AS DOUBLE))
      comment: "Average cost per occupied room for labor. Core hospitality labor efficiency KPI used in property benchmarking."
    - name: "schedule_count"
      expr: COUNT(1)
      comment: "Total number of schedules created. Baseline metric for scheduling program coverage and operational planning activity."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase requisition pipeline KPIs measuring requisition volume, approval cycle efficiency, budget utilization, and conversion to PO to manage procurement demand and process performance."
  source: "`vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property originating the requisition for property-level demand analysis."
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of the requisition (e.g., Submitted, Approved, Converted) for pipeline management."
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of requisition (e.g., Standard, Emergency, CapEx) for spend categorization."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the requisition for urgency-based processing analysis."
    - name: "approval_date_month"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month of requisition approval for demand trend analysis."
    - name: "converted_to_po_flag"
      expr: converted_to_po_flag
      comment: "Whether the requisition was converted to a purchase order, enabling conversion rate analysis."
    - name: "budget_available_flag"
      expr: budget_available_flag
      comment: "Whether budget was available at time of requisition, supporting budget utilization analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the requisition for multi-currency spend analysis."
  measures:
    - name: "total_estimated_amount"
      expr: SUM(CAST(estimated_total_amount AS DOUBLE))
      comment: "Total estimated spend value of all requisitions. Measures procurement demand pipeline and budget consumption forecast."
    - name: "requisition_count"
      expr: COUNT(1)
      comment: "Total number of purchase requisitions submitted. Baseline procurement demand volume metric."
    - name: "converted_to_po_count"
      expr: COUNT(CASE WHEN converted_to_po_flag = TRUE THEN 1 END)
      comment: "Number of requisitions converted to purchase orders. Measures procurement pipeline conversion effectiveness."
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN requisition_status = 'Submitted' THEN 1 END)
      comment: "Number of requisitions pending approval. Indicates approval bottlenecks and process cycle time risk."
    - name: "avg_estimated_amount"
      expr: AVG(CAST(estimated_total_amount AS DOUBLE))
      comment: "Average estimated requisition value. Tracks demand size trends and informs category spend planning."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_vendor_quotation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sourcing and competitive bidding KPIs measuring quotation competitiveness, award rates, and pricing to support strategic sourcing decisions and vendor selection governance."
  source: "`vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the quotation for property-level sourcing analysis."
    - name: "quotation_status"
      expr: quotation_status
      comment: "Current status of the quotation (e.g., Received, Evaluated, Awarded, Rejected) for sourcing pipeline management."
    - name: "quotation_date_month"
      expr: DATE_TRUNC('month', quotation_date)
      comment: "Month of quotation receipt for sourcing activity trend analysis."
    - name: "is_awarded"
      expr: is_awarded
      comment: "Whether the quotation was awarded, enabling win rate and competitive analysis."
    - name: "specification_compliance_flag"
      expr: specification_compliance_flag
      comment: "Whether the quotation met technical specifications, supporting quality-based vendor selection."
    - name: "sustainability_compliance_flag"
      expr: sustainability_compliance_flag
      comment: "Whether the quotation meets sustainability requirements, supporting ESG sourcing objectives."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the quotation for multi-currency sourcing analysis."
  measures:
    - name: "total_quoted_amount"
      expr: SUM(CAST(total_quoted_amount AS DOUBLE))
      comment: "Total value of all vendor quotations received. Measures sourcing market response and competitive bid pool value."
    - name: "total_awarded_value"
      expr: SUM(CASE WHEN is_awarded = TRUE THEN quoted_total_amount ELSE 0 END)
      comment: "Total value of awarded quotations. Measures sourcing decision outcomes and contracted spend commitments."
    - name: "avg_evaluation_score"
      expr: AVG(CAST(evaluation_score AS DOUBLE))
      comment: "Average vendor evaluation score across quotations. Tracks overall vendor bid quality and sourcing market competitiveness."
    - name: "avg_price_competitiveness_rating"
      expr: AVG(CAST(price_competitiveness_rating AS DOUBLE))
      comment: "Average price competitiveness rating. Measures whether market pricing is favorable and informs negotiation strategy."
    - name: "avg_vendor_score"
      expr: AVG(CAST(vendor_score AS DOUBLE))
      comment: "Average composite vendor score across quotations. Used in vendor selection decisions and preferred vendor program management."
    - name: "avg_quoted_unit_price"
      expr: AVG(CAST(quoted_unit_price AS DOUBLE))
      comment: "Average quoted unit price across all quotations. Benchmarks market pricing for category management and negotiation."
    - name: "quotation_count"
      expr: COUNT(1)
      comment: "Total number of vendor quotations received. Measures sourcing market engagement and competitive bid coverage."
    - name: "awarded_quotation_count"
      expr: COUNT(CASE WHEN is_awarded = TRUE THEN 1 END)
      comment: "Number of quotations awarded. Baseline for award rate calculation and sourcing decision volume."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across quotations. Informs inventory planning and vendor consolidation decisions."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_workforce_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce safety KPIs measuring incident frequency, severity, OSHA recordability, and investigation completion to drive safety culture improvement and regulatory compliance."
  source: "`vibe_travel_hospitality_v1`.`procurement`.`workforce_safety_incident`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the safety incident occurred for property-level safety benchmarking."
    - name: "incident_type"
      expr: incident_type
      comment: "Type of safety incident (e.g., Slip/Fall, Chemical Exposure, Equipment) for root cause categorization."
    - name: "injury_severity"
      expr: injury_severity
      comment: "Severity of injury (e.g., Minor, Moderate, Severe) for risk prioritization."
    - name: "incident_date_month"
      expr: DATE_TRUNC('month', incident_date)
      comment: "Month of incident for safety trend analysis and seasonal pattern identification."
    - name: "osha_recordable_flag"
      expr: osha_recordable_flag
      comment: "Whether the incident is OSHA recordable, enabling regulatory compliance rate tracking."
    - name: "preventable_flag"
      expr: preventable_flag
      comment: "Whether the incident was preventable, supporting safety program effectiveness measurement."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the incident investigation for compliance and corrective action tracking."
  measures:
    - name: "total_incident_count"
      expr: COUNT(1)
      comment: "Total number of workforce safety incidents. Primary safety KPI used in executive safety dashboards and regulatory reporting."
    - name: "osha_recordable_incident_count"
      expr: COUNT(CASE WHEN osha_recordable_flag = TRUE THEN 1 END)
      comment: "Number of OSHA recordable incidents. Directly impacts OSHA 300 log compliance and regulatory filing requirements."
    - name: "preventable_incident_count"
      expr: COUNT(CASE WHEN preventable_flag = TRUE THEN 1 END)
      comment: "Number of preventable incidents. Measures safety program effectiveness and drives targeted intervention investments."
    - name: "total_estimated_incident_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated financial cost of safety incidents. Quantifies safety risk exposure for insurance and risk management decisions."
    - name: "avg_estimated_incident_cost"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average cost per safety incident. Benchmarks incident severity and informs safety investment ROI calculations."
    - name: "open_investigation_count"
      expr: COUNT(CASE WHEN investigation_status != 'Completed' THEN 1 END)
      comment: "Number of incidents with open investigations. Measures investigation backlog and regulatory compliance risk."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee performance management KPIs measuring review completion, rating distributions, promotion readiness, and merit eligibility to support talent management and succession planning."
  source: "`vibe_travel_hospitality_v1`.`procurement`.`performance_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of performance review (e.g., Annual, Mid-Year, Probationary) for review program analysis."
    - name: "review_status"
      expr: review_status
      comment: "Current status of the review (e.g., Completed, In Progress, Overdue) for completion tracking."
    - name: "review_period_end_date_year"
      expr: DATE_TRUNC('year', review_period_end_date)
      comment: "Year of review period for annual performance cycle analysis."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating category for rating distribution analysis."
    - name: "merit_increase_eligible_flag"
      expr: merit_increase_eligible_flag
      comment: "Whether the employee is eligible for merit increase, enabling compensation planning analysis."
    - name: "promotion_recommended_flag"
      expr: promotion_recommended_flag
      comment: "Whether promotion was recommended, supporting succession planning and talent pipeline analysis."
    - name: "performance_improvement_plan_flag"
      expr: performance_improvement_plan_flag
      comment: "Whether the employee is on a performance improvement plan, indicating at-risk talent."
    - name: "succession_planning_flag"
      expr: succession_planning_flag
      comment: "Whether the employee is identified for succession planning, measuring leadership pipeline depth."
  measures:
    - name: "review_count"
      expr: COUNT(1)
      comment: "Total number of performance reviews. Baseline metric for review program coverage and HR process compliance."
    - name: "avg_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average overall performance rating score. Tracks workforce performance trends and informs talent investment decisions."
    - name: "merit_eligible_count"
      expr: COUNT(CASE WHEN merit_increase_eligible_flag = TRUE THEN 1 END)
      comment: "Number of employees eligible for merit increase. Drives compensation budget planning and equity analysis."
    - name: "promotion_recommended_count"
      expr: COUNT(CASE WHEN promotion_recommended_flag = TRUE THEN 1 END)
      comment: "Number of employees recommended for promotion. Measures talent pipeline strength and internal mobility rate."
    - name: "pip_count"
      expr: COUNT(CASE WHEN performance_improvement_plan_flag = TRUE THEN 1 END)
      comment: "Number of employees on performance improvement plans. Elevated PIP counts signal workforce quality or management issues."
    - name: "completed_review_count"
      expr: COUNT(CASE WHEN review_status = 'Completed' THEN 1 END)
      comment: "Number of completed performance reviews. Measures HR compliance with review cycle requirements."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital and procurement project KPIs measuring budget utilization, cost variance, completion progress, and PIP project performance to support CapEx governance and property improvement planning."
  source: "`vibe_travel_hospitality_v1`.`procurement`.`project`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the project for property-level CapEx and project portfolio analysis."
    - name: "project_status"
      expr: project_status
      comment: "Current project status (e.g., Active, Completed, On Hold) for portfolio health monitoring."
    - name: "project_type"
      expr: project_type
      comment: "Type of project (e.g., CapEx, PIP, Maintenance) for investment category analysis."
    - name: "project_category"
      expr: project_category
      comment: "Business category of the project for spend classification and portfolio segmentation."
    - name: "capex_opex_flag"
      expr: capex_opex_flag
      comment: "Whether the project is CapEx or OpEx for financial reporting and budget classification."
    - name: "is_pip_project"
      expr: is_pip_project
      comment: "Whether the project is a Property Improvement Plan project, enabling PIP portfolio tracking."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the project for risk-weighted portfolio management."
    - name: "planned_end_date_quarter"
      expr: DATE_TRUNC('quarter', planned_end_date)
      comment: "Quarter of planned project completion for delivery timeline analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of project financials for multi-currency CapEx reporting."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget AS DOUBLE))
      comment: "Total approved budget across all projects. Core CapEx authorization KPI for financial governance and board reporting."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across projects. Measures CapEx spend against approved budgets."
    - name: "total_committed_cost"
      expr: SUM(CAST(committed_cost AS DOUBLE))
      comment: "Total committed cost (POs and contracts) across projects. Measures financial exposure beyond actual spend."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total project budget amount. Used for portfolio-level budget planning and CapEx program sizing."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average project completion percentage. Tracks portfolio delivery progress and identifies at-risk projects."
    - name: "project_count"
      expr: COUNT(1)
      comment: "Total number of projects in the portfolio. Baseline metric for project management capacity and governance coverage."
    - name: "active_project_count"
      expr: COUNT(CASE WHEN project_status = 'Active' THEN 1 END)
      comment: "Number of currently active projects. Measures active CapEx pipeline and resource demand."
    - name: "pip_project_count"
      expr: COUNT(CASE WHEN is_pip_project = TRUE THEN 1 END)
      comment: "Number of Property Improvement Plan projects. Tracks brand standard compliance investment activity."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_vendor_category_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor category qualification KPIs measuring qualification scores, spend allocation, and preferred vendor coverage to support category management and strategic sourcing decisions."
  source: "`vibe_travel_hospitality_v1`.`procurement`.`vendor_category_qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status of the vendor for the category (e.g., Qualified, Suspended, Under Review)."
    - name: "is_preferred"
      expr: is_preferred
      comment: "Whether the vendor holds preferred status in the category, enabling preferred vs. non-preferred spend analysis."
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Preferred vendor designation flag for category-level preferred vendor program tracking."
    - name: "certification_required"
      expr: certification_required
      comment: "Whether certification is required for this category qualification, supporting compliance gate management."
    - name: "qualification_date_year"
      expr: DATE_TRUNC('year', qualification_date)
      comment: "Year of vendor qualification for cohort and renewal cycle analysis."
  measures:
    - name: "avg_qualification_score"
      expr: AVG(CAST(qualification_score AS DOUBLE))
      comment: "Average vendor qualification score by category. Measures overall vendor base quality and informs preferred vendor selection."
    - name: "avg_category_performance_score"
      expr: AVG(CAST(category_performance_score AS DOUBLE))
      comment: "Average category-specific performance score. Tracks vendor performance within specific spend categories for category management."
    - name: "total_annual_spend_actual"
      expr: SUM(CAST(annual_spend_actual AS DOUBLE))
      comment: "Total actual annual spend through qualified vendors by category. Core category spend KPI for sourcing strategy and budget planning."
    - name: "avg_spend_allocation_percentage"
      expr: AVG(CAST(spend_allocation_percentage AS DOUBLE))
      comment: "Average spend allocation percentage across qualified vendors. Measures spend concentration and vendor diversification."
    - name: "qualification_count"
      expr: COUNT(1)
      comment: "Total number of vendor-category qualifications. Measures qualified vendor base breadth for each category."
    - name: "preferred_vendor_count"
      expr: COUNT(CASE WHEN is_preferred = TRUE THEN 1 END)
      comment: "Number of preferred vendor qualifications. Tracks preferred vendor program coverage across categories."
    - name: "avg_minimum_order_value"
      expr: AVG(CAST(minimum_order_value AS DOUBLE))
      comment: "Average minimum order value across vendor-category qualifications. Informs procurement consolidation and order batching strategy."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_supply_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply agreement portfolio KPIs measuring committed spend, volume commitments, pricing, and rebate capture to manage vendor supply relationships and procurement savings."
  source: "`vibe_travel_hospitality_v1`.`procurement`.`procurement_supply_agreement`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the supply agreement for property-level supply chain analysis."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the supply agreement (e.g., Active, Expired, Pending) for portfolio management."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of supply agreement (e.g., Blanket, Spot, Long-Term) for sourcing strategy analysis."
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Whether the agreement is with a preferred vendor, enabling preferred vs. spot sourcing analysis."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the agreement auto-renews, supporting proactive renewal management."
    - name: "agreement_start_date_year"
      expr: DATE_TRUNC('year', agreement_start_date)
      comment: "Year the supply agreement started for cohort and vintage analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the supply agreement for multi-currency portfolio reporting."
  measures:
    - name: "total_committed_spend"
      expr: SUM(CAST(committed_spend_amount AS DOUBLE))
      comment: "Total committed spend across all supply agreements. Measures procurement spend obligations and vendor dependency."
    - name: "total_committed_volume"
      expr: SUM(CAST(committed_volume AS DOUBLE))
      comment: "Total committed volume across supply agreements. Informs inventory planning and vendor capacity allocation."
    - name: "avg_negotiated_unit_price"
      expr: AVG(CAST(negotiated_unit_price AS DOUBLE))
      comment: "Average negotiated unit price across supply agreements. Benchmarks procurement pricing effectiveness and savings vs. market."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage negotiated in supply agreements. Measures procurement savings capture from volume commitments."
    - name: "avg_rebate_percentage"
      expr: AVG(CAST(rebate_percentage AS DOUBLE))
      comment: "Average rebate percentage across supply agreements. Tracks rebate program value and incentive alignment with vendors."
    - name: "supply_agreement_count"
      expr: COUNT(1)
      comment: "Total number of supply agreements. Measures supply chain coverage and vendor relationship formalization."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN 1 END)
      comment: "Number of currently active supply agreements. Indicates live supply commitments and active vendor relationships."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor master KPIs tracking vendor portfolio composition, spend concentration, and vendor lifecycle"
  source: "`vibe_travel_hospitality_v1`.`procurement`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current status of the vendor (active, inactive, suspended)"
    - name: "classification"
      expr: classification
      comment: "Vendor classification category"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to vendor"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of vendor"
    - name: "diversity_certification"
      expr: diversity_certification
      comment: "Diversity certification type (MBE, WBE, etc.)"
    - name: "payment_method"
      expr: payment_method
      comment: "Preferred payment method"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Standard payment terms"
    - name: "country_code"
      expr: country_code
      comment: "Country where vendor is located"
    - name: "onboarding_year"
      expr: YEAR(onboarding_date)
      comment: "Year vendor was onboarded"
  measures:
    - name: "total_vendor_count"
      expr: COUNT(1)
      comment: "Total number of vendors"
    - name: "active_vendor_count"
      expr: SUM(CASE WHEN vendor_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of active vendors"
    - name: "total_annual_spend"
      expr: SUM(CAST(annual_spend_amount AS DOUBLE))
      comment: "Total annual spend across all vendors"
    - name: "avg_annual_spend_per_vendor"
      expr: AVG(CAST(annual_spend_amount AS DOUBLE))
      comment: "Average annual spend per vendor"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS BIGINT))
      comment: "Average lead time in days across vendors"
    - name: "avg_minimum_order_amount"
      expr: AVG(CAST(minimum_order_amount AS DOUBLE))
      comment: "Average minimum order amount across vendors"
    - name: "diversity_certified_count"
      expr: SUM(CASE WHEN diversity_certification IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of vendors with diversity certification"
    - name: "insurance_expired_count"
      expr: SUM(CASE WHEN insurance_certificate_expiry_date < CURRENT_DATE THEN 1 ELSE 0 END)
      comment: "Count of vendors with expired insurance certificates"
    - name: "contract_active_count"
      expr: SUM(CASE WHEN contract_end_date >= CURRENT_DATE THEN 1 ELSE 0 END)
      comment: "Count of vendors with active contracts"
    - name: "contract_expiring_soon_count"
      expr: SUM(CASE WHEN contract_end_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 ELSE 0 END)
      comment: "Count of vendors with contracts expiring within 90 days"
    - name: "distinct_country_count"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of unique countries where vendors are located"
$$;