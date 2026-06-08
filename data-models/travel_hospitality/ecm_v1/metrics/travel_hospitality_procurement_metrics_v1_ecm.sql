-- Metric views for domain: procurement | Business: Travel Hospitality | Version: 1 | Generated on: 2026-05-08 03:54:25

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order KPIs tracking procurement spend, cycle times, and fulfillment performance across properties and vendors"
  source: "`travel_hospitality_ecm`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order (open, closed, cancelled)"
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (standard, blanket, contract release)"
    - name: "property_id"
      expr: property_id
      comment: "Property where goods/services are delivered"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor fulfilling the purchase order"
    - name: "category_id"
      expr: category_id
      comment: "Procurement category for spend classification"
    - name: "po_year"
      expr: YEAR(po_date)
      comment: "Year the purchase order was created"
    - name: "po_month"
      expr: DATE_TRUNC('MONTH', po_date)
      comment: "Month the purchase order was created"
    - name: "goods_receipt_completed"
      expr: goods_receipt_completed_flag
      comment: "Whether goods receipt is complete"
    - name: "invoice_receipt_completed"
      expr: invoice_receipt_completed_flag
      comment: "Whether invoice receipt is complete"
  measures:
    - name: "total_po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders"
    - name: "total_po_value"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total purchase order value before tax"
    - name: "total_po_value_with_tax"
      expr: SUM(CAST(total_amount_with_tax AS DOUBLE))
      comment: "Total purchase order value including tax"
    - name: "avg_po_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average purchase order value"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all purchase orders"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with purchase orders"
    - name: "distinct_property_count"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of unique properties placing purchase orders"
    - name: "avg_delivery_lead_time_days"
      expr: AVG(CAST(DATEDIFF(actual_delivery_date, po_date) AS DOUBLE))
      comment: "Average days from PO creation to actual delivery"
    - name: "on_time_delivery_count"
      expr: SUM(CASE WHEN actual_delivery_date <= promised_delivery_date THEN 1 ELSE 0 END)
      comment: "Count of purchase orders delivered on or before promised date"
    - name: "late_delivery_count"
      expr: SUM(CASE WHEN actual_delivery_date > promised_delivery_date THEN 1 ELSE 0 END)
      comment: "Count of purchase orders delivered after promised date"
    - name: "goods_receipt_completed_count"
      expr: SUM(CASE WHEN goods_receipt_completed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of purchase orders with completed goods receipt"
    - name: "invoice_receipt_completed_count"
      expr: SUM(CASE WHEN invoice_receipt_completed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of purchase orders with completed invoice receipt"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`procurement_vendor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor invoice KPIs tracking accounts payable, payment performance, and invoice accuracy"
  source: "`travel_hospitality_ecm`.`procurement`.`vendor_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the vendor invoice"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (standard, credit memo, debit memo)"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor who issued the invoice"
    - name: "property_id"
      expr: property_id
      comment: "Property receiving the invoice"
    - name: "category_id"
      expr: category_id
      comment: "Procurement category for spend classification"
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year the invoice was issued"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month the invoice was issued"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the invoice is disputed"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of three-way match (PO, receipt, invoice)"
    - name: "early_payment_discount_eligible"
      expr: early_payment_discount_eligible_flag
      comment: "Whether invoice qualifies for early payment discount"
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of vendor invoices"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts and tax"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all invoices"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount captured"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice amount"
    - name: "disputed_invoice_count"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of invoices currently in dispute"
    - name: "total_disputed_amount"
      expr: SUM(CAST(CASE WHEN dispute_flag = TRUE THEN disputed_amount ELSE 0 END AS DOUBLE))
      comment: "Total amount under dispute"
    - name: "total_match_variance"
      expr: SUM(CAST(match_variance_amount AS DOUBLE))
      comment: "Total variance between invoice and PO/receipt"
    - name: "avg_payment_cycle_days"
      expr: AVG(CAST(DATEDIFF(payment_date, invoice_date) AS DOUBLE))
      comment: "Average days from invoice date to payment date"
    - name: "on_time_payment_count"
      expr: SUM(CASE WHEN payment_date <= payment_due_date THEN 1 ELSE 0 END)
      comment: "Count of invoices paid on or before due date"
    - name: "late_payment_count"
      expr: SUM(CASE WHEN payment_date > payment_due_date THEN 1 ELSE 0 END)
      comment: "Count of invoices paid after due date"
    - name: "early_discount_captured_count"
      expr: SUM(CASE WHEN early_payment_discount_eligible_flag = TRUE AND payment_date <= early_payment_discount_date THEN 1 ELSE 0 END)
      comment: "Count of invoices where early payment discount was captured"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with invoices"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`procurement_vendor_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance KPIs tracking quality, delivery, compliance, and overall vendor effectiveness"
  source: "`travel_hospitality_ecm`.`procurement`.`vendor_performance`"
  dimensions:
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor being evaluated"
    - name: "property_id"
      expr: property_id
      comment: "Property conducting the evaluation"
    - name: "category_id"
      expr: category_id
      comment: "Procurement category for the evaluation"
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Status of the performance evaluation"
    - name: "evaluation_year"
      expr: YEAR(evaluation_period_start_date)
      comment: "Year of the evaluation period"
    - name: "evaluation_quarter"
      expr: CONCAT('Q', CAST(QUARTER(evaluation_period_start_date) AS STRING), '-', CAST(YEAR(evaluation_period_start_date) AS STRING))
      comment: "Quarter of the evaluation period"
    - name: "preferred_vendor"
      expr: preferred_vendor_flag
      comment: "Whether vendor has preferred status"
    - name: "qualified_vendor"
      expr: qualified_vendor_flag
      comment: "Whether vendor is qualified"
    - name: "payment_terms_compliant"
      expr: payment_terms_compliance_flag
      comment: "Whether vendor complies with payment terms"
    - name: "sustainability_compliant"
      expr: sustainability_compliance_flag
      comment: "Whether vendor meets sustainability requirements"
  measures:
    - name: "total_evaluation_count"
      expr: COUNT(1)
      comment: "Total number of vendor performance evaluations"
    - name: "avg_overall_vendor_score"
      expr: AVG(CAST(overall_vendor_score AS DOUBLE))
      comment: "Average overall vendor performance score"
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate percentage"
    - name: "avg_quality_acceptance_rate"
      expr: AVG(CAST(quality_acceptance_rate AS DOUBLE))
      comment: "Average quality acceptance rate percentage"
    - name: "avg_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate AS DOUBLE))
      comment: "Average invoice accuracy rate percentage"
    - name: "avg_contract_compliance_score"
      expr: AVG(CAST(contract_compliance_score AS DOUBLE))
      comment: "Average contract compliance score"
    - name: "avg_responsiveness_rating"
      expr: AVG(CAST(responsiveness_rating AS DOUBLE))
      comment: "Average vendor responsiveness rating"
    - name: "avg_cost_competitiveness_rating"
      expr: AVG(CAST(cost_competitiveness_rating AS DOUBLE))
      comment: "Average cost competitiveness rating"
    - name: "avg_emergency_support_rating"
      expr: AVG(CAST(emergency_order_support_rating AS DOUBLE))
      comment: "Average emergency order support rating"
    - name: "total_spend_amount"
      expr: SUM(CAST(total_spend_amount AS DOUBLE))
      comment: "Total spend with vendors during evaluation period"
    - name: "avg_spend_per_vendor"
      expr: AVG(CAST(total_spend_amount AS DOUBLE))
      comment: "Average spend per vendor evaluation"
    - name: "total_late_deliveries"
      expr: SUM(CAST(late_deliveries_count AS BIGINT))
      comment: "Total count of late deliveries across all evaluations"
    - name: "total_quality_rejections"
      expr: SUM(CAST(quality_rejections_count AS BIGINT))
      comment: "Total count of quality rejections across all evaluations"
    - name: "total_invoice_discrepancies"
      expr: SUM(CAST(invoice_discrepancies_count AS BIGINT))
      comment: "Total count of invoice discrepancies across all evaluations"
    - name: "preferred_vendor_count"
      expr: SUM(CASE WHEN preferred_vendor_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of vendors with preferred status"
    - name: "qualified_vendor_count"
      expr: SUM(CASE WHEN qualified_vendor_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of qualified vendors"
    - name: "sustainability_compliant_count"
      expr: SUM(CASE WHEN sustainability_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of vendors meeting sustainability requirements"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors evaluated"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`procurement_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase requisition KPIs tracking procurement request volume, approval cycle times, and conversion efficiency"
  source: "`travel_hospitality_ecm`.`procurement`.`purchase_requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of the purchase requisition"
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of purchase requisition"
    - name: "property_id"
      expr: property_id
      comment: "Property originating the requisition"
    - name: "category_id"
      expr: category_id
      comment: "Procurement category for the requisition"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the requisition"
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year the requisition was created"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the requisition was created"
    - name: "converted_to_po"
      expr: converted_to_po_flag
      comment: "Whether requisition was converted to purchase order"
    - name: "budget_available"
      expr: budget_available_flag
      comment: "Whether budget was available for the requisition"
    - name: "sourcing_strategy"
      expr: sourcing_strategy
      comment: "Sourcing strategy for the requisition"
  measures:
    - name: "total_requisition_count"
      expr: COUNT(1)
      comment: "Total number of purchase requisitions"
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_total_amount AS DOUBLE))
      comment: "Total estimated value of all requisitions"
    - name: "avg_estimated_value"
      expr: AVG(CAST(estimated_total_amount AS DOUBLE))
      comment: "Average estimated value per requisition"
    - name: "avg_approval_cycle_days"
      expr: AVG(CAST(DATEDIFF(approval_date, created_timestamp) AS DOUBLE))
      comment: "Average days from requisition creation to approval"
    - name: "avg_submission_to_approval_days"
      expr: AVG(CAST(DATEDIFF(approval_date, submitted_timestamp) AS DOUBLE))
      comment: "Average days from submission to approval"
    - name: "converted_to_po_count"
      expr: SUM(CASE WHEN converted_to_po_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of requisitions converted to purchase orders"
    - name: "budget_available_count"
      expr: SUM(CASE WHEN budget_available_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of requisitions with available budget"
    - name: "budget_unavailable_count"
      expr: SUM(CASE WHEN budget_available_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Count of requisitions without available budget"
    - name: "avg_item_count_per_requisition"
      expr: AVG(CAST(item_count AS BIGINT))
      comment: "Average number of line items per requisition"
    - name: "distinct_requestor_count"
      expr: COUNT(DISTINCT primary_purchase_requestor_employee_id)
      comment: "Number of unique employees creating requisitions"
    - name: "distinct_property_count"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of unique properties with requisitions"
    - name: "distinct_category_count"
      expr: COUNT(DISTINCT category_id)
      comment: "Number of unique procurement categories requested"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`procurement_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll KPIs tracking labor costs, tax withholding, and payroll processing efficiency across properties"
  source: "`travel_hospitality_ecm`.`procurement`.`payroll_run`"
  dimensions:
    - name: "payroll_run_status"
      expr: payroll_run_status
      comment: "Current status of the payroll run"
    - name: "payroll_run_type"
      expr: payroll_run_type
      comment: "Type of payroll run (regular, off-cycle, adjustment)"
    - name: "property_id"
      expr: property_id
      comment: "Property for the payroll run"
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Frequency of payroll (weekly, bi-weekly, monthly)"
    - name: "pay_year"
      expr: YEAR(pay_date)
      comment: "Year of the pay date"
    - name: "pay_month"
      expr: DATE_TRUNC('MONTH', pay_date)
      comment: "Month of the pay date"
    - name: "gl_posting_status"
      expr: gl_posting_status
      comment: "General ledger posting status"
  measures:
    - name: "total_payroll_run_count"
      expr: COUNT(1)
      comment: "Total number of payroll runs"
    - name: "total_gross_pay"
      expr: SUM(CAST(total_gross_pay AS DOUBLE))
      comment: "Total gross pay across all payroll runs"
    - name: "total_net_pay"
      expr: SUM(CAST(total_net_pay AS DOUBLE))
      comment: "Total net pay distributed to employees"
    - name: "total_regular_pay"
      expr: SUM(CAST(total_regular_pay AS DOUBLE))
      comment: "Total regular pay (non-overtime)"
    - name: "total_overtime_pay"
      expr: SUM(CAST(total_overtime_pay AS DOUBLE))
      comment: "Total overtime pay"
    - name: "total_bonus_pay"
      expr: SUM(CAST(total_bonus_pay AS DOUBLE))
      comment: "Total bonus pay"
    - name: "total_commission_pay"
      expr: SUM(CAST(total_commission_pay AS DOUBLE))
      comment: "Total commission pay"
    - name: "total_service_charge"
      expr: SUM(CAST(total_service_charge AS DOUBLE))
      comment: "Total service charges distributed"
    - name: "total_tip_allocation"
      expr: SUM(CAST(total_tip_allocation AS DOUBLE))
      comment: "Total tip allocations"
    - name: "total_tax_withholding"
      expr: SUM(CAST(total_tax_withholding AS DOUBLE))
      comment: "Total tax withholding across all categories"
    - name: "total_federal_tax"
      expr: SUM(CAST(total_federal_tax AS DOUBLE))
      comment: "Total federal tax withheld"
    - name: "total_state_tax"
      expr: SUM(CAST(total_state_tax AS DOUBLE))
      comment: "Total state tax withheld"
    - name: "total_local_tax"
      expr: SUM(CAST(total_local_tax AS DOUBLE))
      comment: "Total local tax withheld"
    - name: "total_social_security_tax"
      expr: SUM(CAST(total_social_security_tax AS DOUBLE))
      comment: "Total social security tax withheld"
    - name: "total_medicare_tax"
      expr: SUM(CAST(total_medicare_tax AS DOUBLE))
      comment: "Total Medicare tax withheld"
    - name: "total_employer_taxes"
      expr: SUM(CAST(total_employer_taxes AS DOUBLE))
      comment: "Total employer tax burden"
    - name: "total_pre_tax_deductions"
      expr: SUM(CAST(total_pre_tax_deductions AS DOUBLE))
      comment: "Total pre-tax deductions (401k, health insurance)"
    - name: "total_post_tax_deductions"
      expr: SUM(CAST(total_post_tax_deductions AS DOUBLE))
      comment: "Total post-tax deductions"
    - name: "avg_gross_pay_per_employee"
      expr: AVG(CAST(total_gross_pay AS DOUBLE))
      comment: "Average gross pay per payroll run"
    - name: "avg_net_pay_per_employee"
      expr: AVG(CAST(total_net_pay AS DOUBLE))
      comment: "Average net pay per payroll run"
    - name: "total_employee_count"
      expr: SUM(CAST(employee_count AS BIGINT))
      comment: "Total number of employees paid across all runs"
    - name: "distinct_property_count"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of unique properties with payroll runs"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`procurement_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee workforce KPIs tracking headcount, turnover, tenure, and workforce composition"
  source: "`travel_hospitality_ecm`.`procurement`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (active, terminated, on leave)"
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment (full-time, part-time, contractor)"
    - name: "property_id"
      expr: property_id
      comment: "Property where employee works"
    - name: "position_id"
      expr: position_id
      comment: "Position held by employee"
    - name: "pay_type"
      expr: pay_type
      comment: "Pay type (hourly, salary)"
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade level"
    - name: "work_location_type"
      expr: work_location_type
      comment: "Work location type (on-site, remote, hybrid)"
    - name: "union_membership"
      expr: union_membership_flag
      comment: "Whether employee is union member"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year employee was hired"
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month employee was hired"
    - name: "termination_year"
      expr: YEAR(termination_date)
      comment: "Year employee was terminated"
  measures:
    - name: "total_employee_count"
      expr: COUNT(1)
      comment: "Total number of employee records"
    - name: "active_employee_count"
      expr: SUM(CASE WHEN employment_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of active employees"
    - name: "terminated_employee_count"
      expr: SUM(CASE WHEN termination_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of terminated employees"
    - name: "avg_fte_percentage"
      expr: AVG(CAST(fte_percentage AS DOUBLE))
      comment: "Average FTE percentage across employees"
    - name: "total_fte"
      expr: SUM(CAST(fte_percentage AS DOUBLE))
      comment: "Total FTE (sum of all FTE percentages divided by 100)"
    - name: "avg_standard_hours_per_week"
      expr: AVG(CAST(standard_hours_per_week AS DOUBLE))
      comment: "Average standard hours per week"
    - name: "union_member_count"
      expr: SUM(CASE WHEN union_membership_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of union members"
    - name: "ada_accommodation_count"
      expr: SUM(CASE WHEN ada_accommodation_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of employees requiring ADA accommodation"
    - name: "food_safety_certified_count"
      expr: SUM(CASE WHEN food_safety_certification_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of employees with food safety certification"
    - name: "osha_training_current_count"
      expr: SUM(CASE WHEN osha_training_current_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of employees with current OSHA training"
    - name: "distinct_property_count"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of unique properties with employees"
    - name: "distinct_position_count"
      expr: COUNT(DISTINCT position_id)
      comment: "Number of unique positions held"
    - name: "distinct_manager_count"
      expr: COUNT(DISTINCT manager_employee_id)
      comment: "Number of unique managers"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`procurement_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor time tracking KPIs measuring hours worked, overtime, labor costs, and time entry compliance"
  source: "`travel_hospitality_ecm`.`procurement`.`time_entry`"
  dimensions:
    - name: "entry_type"
      expr: entry_type
      comment: "Type of time entry (regular, overtime, double-time)"
    - name: "entry_source"
      expr: entry_source
      comment: "Source of time entry (clock, manual, import)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of time entry"
    - name: "property_id"
      expr: property_id
      comment: "Property where time was worked"
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit for the time entry"
    - name: "entry_year"
      expr: YEAR(entry_date)
      comment: "Year of the time entry"
    - name: "entry_month"
      expr: DATE_TRUNC('MONTH', entry_date)
      comment: "Month of the time entry"
    - name: "edited_flag"
      expr: edited_flag
      comment: "Whether time entry was edited after initial submission"
    - name: "payroll_processed"
      expr: payroll_processed_flag
      comment: "Whether time entry has been processed in payroll"
    - name: "exception_code"
      expr: exception_code
      comment: "Exception code if time entry has issues"
  measures:
    - name: "total_time_entry_count"
      expr: COUNT(1)
      comment: "Total number of time entries"
    - name: "total_hours_worked"
      expr: SUM(CAST(total_hours_worked AS DOUBLE))
      comment: "Total hours worked across all time entries"
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours worked"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked"
    - name: "total_double_time_hours"
      expr: SUM(CAST(double_time_hours AS DOUBLE))
      comment: "Total double-time hours worked"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost for all time entries"
    - name: "avg_labor_cost_per_hour"
      expr: AVG(CAST(labor_cost_amount AS DOUBLE))
      comment: "Average labor cost per time entry"
    - name: "total_tips_reported"
      expr: SUM(CAST(tips_reported_amount AS DOUBLE))
      comment: "Total tips reported across all time entries"
    - name: "avg_hours_per_entry"
      expr: AVG(CAST(total_hours_worked AS DOUBLE))
      comment: "Average hours worked per time entry"
    - name: "edited_entry_count"
      expr: SUM(CASE WHEN edited_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of time entries that were edited"
    - name: "exception_entry_count"
      expr: SUM(CASE WHEN exception_code IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of time entries with exceptions"
    - name: "payroll_processed_count"
      expr: SUM(CASE WHEN payroll_processed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of time entries processed in payroll"
    - name: "distinct_employee_count"
      expr: COUNT(DISTINCT primary_time_employee_id)
      comment: "Number of unique employees with time entries"
    - name: "distinct_property_count"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of unique properties with time entries"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`procurement_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor master KPIs tracking vendor portfolio composition, spend concentration, and vendor lifecycle"
  source: "`travel_hospitality_ecm`.`procurement`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current status of the vendor (active, inactive, suspended)"
    - name: "vendor_tier"
      expr: vendor_tier
      comment: "Vendor tier classification (strategic, preferred, approved)"
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

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt KPIs tracking receiving efficiency, quality acceptance, and three-way match performance"
  source: "`travel_hospitality_ecm`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "gr_status"
      expr: gr_status
      comment: "Status of the goods receipt"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection status"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match status (PO, receipt, invoice)"
    - name: "property_id"
      expr: property_id
      comment: "Property receiving the goods"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor supplying the goods"
    - name: "category_id"
      expr: category_id
      comment: "Procurement category of received goods"
    - name: "receipt_year"
      expr: YEAR(receipt_date)
      comment: "Year goods were received"
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month goods were received"
    - name: "quality_rejection"
      expr: quality_rejection_flag
      comment: "Whether goods were rejected for quality issues"
    - name: "return_delivery"
      expr: return_delivery_flag
      comment: "Whether this is a return delivery"
    - name: "temperature_controlled"
      expr: temperature_controlled_flag
      comment: "Whether goods require temperature control"
  measures:
    - name: "total_goods_receipt_count"
      expr: COUNT(1)
      comment: "Total number of goods receipts"
    - name: "total_quantity_received"
      expr: SUM(CAST(total_quantity_received AS DOUBLE))
      comment: "Total quantity of goods received"
    - name: "total_value_received"
      expr: SUM(CAST(total_value_amount AS DOUBLE))
      comment: "Total value of goods received"
    - name: "avg_value_per_receipt"
      expr: AVG(CAST(total_value_amount AS DOUBLE))
      comment: "Average value per goods receipt"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between expected and received"
    - name: "total_freight_charges"
      expr: SUM(CAST(freight_charges_amount AS DOUBLE))
      comment: "Total freight charges across all receipts"
    - name: "quality_rejection_count"
      expr: SUM(CASE WHEN quality_rejection_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of goods receipts with quality rejections"
    - name: "return_delivery_count"
      expr: SUM(CASE WHEN return_delivery_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of return deliveries"
    - name: "three_way_match_success_count"
      expr: SUM(CASE WHEN three_way_match_status = 'Matched' THEN 1 ELSE 0 END)
      comment: "Count of goods receipts with successful three-way match"
    - name: "three_way_match_exception_count"
      expr: SUM(CASE WHEN three_way_match_status IN ('Exception', 'Failed') THEN 1 ELSE 0 END)
      comment: "Count of goods receipts with three-way match exceptions"
    - name: "temperature_controlled_count"
      expr: SUM(CASE WHEN temperature_controlled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of temperature-controlled goods receipts"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with goods receipts"
    - name: "distinct_property_count"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of unique properties receiving goods"
$$;