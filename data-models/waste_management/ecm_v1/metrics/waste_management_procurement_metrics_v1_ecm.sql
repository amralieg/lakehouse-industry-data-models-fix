-- Metric views for domain: procurement | Business: Waste Management | Version: 1 | Generated on: 2026-05-07 19:57:14

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core procurement KPIs tracking purchase order value, approval cycle time, and order fulfillment status for strategic sourcing decisions"
  source: "`waste_management_ecm`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Purchase order status (e.g., approved, pending, closed) for tracking order lifecycle"
    - name: "po_type"
      expr: po_type
      comment: "Purchase order type (e.g., standard, blanket, contract) for procurement strategy analysis"
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization responsible for the order, enabling org-level spend analysis"
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Purchasing group managing the order for buyer performance tracking"
    - name: "company_code"
      expr: company_code
      comment: "Company code for multi-entity financial consolidation"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for tracking approval bottlenecks and compliance"
    - name: "order_year"
      expr: YEAR(document_date)
      comment: "Year of purchase order document date for trend analysis"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', document_date)
      comment: "Month of purchase order document date for seasonality analysis"
    - name: "approval_year_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month of approval date for approval velocity tracking"
  measures:
    - name: "total_po_value"
      expr: SUM(CAST(total_po_value AS DOUBLE))
      comment: "Total purchase order value including tax - primary spend metric for procurement budget tracking"
    - name: "net_po_value"
      expr: SUM(CAST(net_po_value AS DOUBLE))
      comment: "Net purchase order value excluding tax - core spend metric for vendor payment forecasting"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across purchase orders for tax liability tracking"
    - name: "po_count"
      expr: COUNT(DISTINCT purchase_order_id)
      comment: "Distinct count of purchase orders for order volume tracking and workload analysis"
    - name: "avg_po_value"
      expr: AVG(CAST(total_po_value AS DOUBLE))
      comment: "Average purchase order value for spend pattern analysis and small-order consolidation opportunities"
    - name: "approval_cycle_time_days"
      expr: AVG(DATEDIFF(approval_date, document_date))
      comment: "Average days from PO creation to approval - critical KPI for procurement efficiency and bottleneck identification"
    - name: "vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Distinct vendor count for supplier concentration risk analysis and vendor rationalization"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`procurement_vendor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable KPIs tracking invoice processing efficiency, payment timing, and three-way match performance for working capital optimization"
  source: "`waste_management_ecm`.`procurement`.`vendor_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Invoice status (e.g., pending, approved, paid, blocked) for AP workflow tracking"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Invoice type (e.g., standard, credit memo, debit memo) for invoice mix analysis"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status for cash flow forecasting and vendor relationship management"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match status (PO-GR-Invoice) for internal control effectiveness tracking"
    - name: "company_code"
      expr: company_code
      comment: "Company code for multi-entity AP consolidation"
    - name: "payment_block_flag"
      expr: payment_block_flag
      comment: "Payment block indicator for identifying invoices requiring resolution"
    - name: "invoice_year_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date for accrual and aging analysis"
    - name: "posting_year_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of GL posting date for financial period close tracking"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for period-over-period financial analysis"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual budget vs actual tracking"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount including discounts and tax - primary AP liability metric"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts before tax - core payment obligation metric"
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured - key working capital efficiency KPI"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount for tax reconciliation and compliance reporting"
    - name: "invoice_count"
      expr: COUNT(DISTINCT vendor_invoice_id)
      comment: "Distinct invoice count for AP workload and automation opportunity analysis"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average invoice amount for small-invoice automation targeting"
    - name: "invoice_processing_time_days"
      expr: AVG(DATEDIFF(posting_date, receipt_date))
      comment: "Average days from invoice receipt to GL posting - critical AP efficiency KPI for process improvement"
    - name: "payment_cycle_time_days"
      expr: AVG(DATEDIFF(due_date, invoice_date))
      comment: "Average days from invoice date to due date - payment terms effectiveness metric for cash flow optimization"
    - name: "blocked_invoice_count"
      expr: SUM(CASE WHEN payment_block_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of invoices blocked for payment - exception management KPI for vendor relationship risk"
    - name: "discount_capture_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of potential discounts captured - strategic working capital KPI for CFO dashboard"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`procurement_vendor_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor scorecard KPIs tracking on-time delivery, quality, compliance, and overall vendor performance for strategic sourcing and supplier development"
  source: "`waste_management_ecm`.`procurement`.`vendor_performance`"
  dimensions:
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Evaluation status (e.g., completed, in-progress, overdue) for scorecard governance tracking"
    - name: "vendor_tier"
      expr: vendor_tier
      comment: "Vendor tier classification (e.g., strategic, preferred, approved) for supplier segmentation"
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Corrective action required indicator for vendor improvement program tracking"
    - name: "evaluation_year_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month of evaluation date for trend analysis and quarterly business reviews"
    - name: "evaluation_period_start_month"
      expr: DATE_TRUNC('MONTH', evaluation_period_start_date)
      comment: "Start month of evaluation period for period-over-period comparison"
  measures:
    - name: "total_evaluated_spend"
      expr: SUM(CAST(total_spend_amount AS DOUBLE))
      comment: "Total spend amount under evaluation - spend under management metric for sourcing strategy"
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate_percent AS DOUBLE))
      comment: "Average on-time delivery rate percentage - critical supply chain reliability KPI for operations planning"
    - name: "avg_quality_defect_rate"
      expr: AVG(CAST(quality_defect_rate_percent AS DOUBLE))
      comment: "Average quality defect rate percentage - product quality KPI for vendor selection and development"
    - name: "avg_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate_percent AS DOUBLE))
      comment: "Average invoice accuracy rate percentage - AP efficiency KPI for vendor onboarding and training"
    - name: "avg_contract_compliance_rate"
      expr: AVG(CAST(contract_compliance_rate_percent AS DOUBLE))
      comment: "Average contract compliance rate percentage - contract management effectiveness KPI"
    - name: "avg_fill_rate"
      expr: AVG(CAST(fill_rate_percent AS DOUBLE))
      comment: "Average order fill rate percentage - inventory availability KPI for service level management"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days_avg AS DOUBLE))
      comment: "Average lead time in days - supply chain planning KPI for inventory optimization"
    - name: "avg_response_time_days"
      expr: AVG(CAST(response_time_days_avg AS DOUBLE))
      comment: "Average response time in days - vendor responsiveness KPI for relationship quality"
    - name: "avg_overall_scorecard_rating"
      expr: AVG(CAST(overall_scorecard_rating AS DOUBLE))
      comment: "Average overall vendor scorecard rating - composite performance KPI for executive reporting and vendor awards"
    - name: "total_safety_incidents"
      expr: SUM(CAST(safety_incident_count AS BIGINT))
      comment: "Total safety incident count - EHS compliance KPI for risk management and vendor qualification"
    - name: "total_environmental_violations"
      expr: SUM(CAST(environmental_compliance_violation_count AS BIGINT))
      comment: "Total environmental compliance violation count - sustainability and regulatory risk KPI"
    - name: "vendor_evaluation_count"
      expr: COUNT(DISTINCT vendor_performance_id)
      comment: "Distinct vendor evaluation count for scorecard program coverage tracking"
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT vendor_performance_id), 0), 2)
      comment: "Percentage of evaluations requiring corrective action - vendor quality management KPI for supplier development prioritization"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`procurement_sourcing_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract management KPIs tracking contract value, utilization, compliance, and renewal pipeline for strategic sourcing and spend under contract optimization"
  source: "`waste_management_ecm`.`procurement`.`sourcing_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Contract status (e.g., active, expired, pending approval) for contract lifecycle management"
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type (e.g., master agreement, blanket PO, framework) for contract portfolio analysis"
    - name: "company_code"
      expr: company_code
      comment: "Company code for multi-entity contract governance"
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization for org-level contract coverage tracking"
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Purchasing group for buyer-level contract management performance"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Auto-renewal indicator for contract renewal risk management"
    - name: "confidentiality_flag"
      expr: confidentiality_flag
      comment: "Confidentiality indicator for sensitive contract tracking"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year of contract effective start date for vintage analysis"
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month of contract effective start date for contract activation tracking"
    - name: "expiration_year_month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
      comment: "Month of contract expiration for renewal pipeline management"
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value_total AS DOUBLE))
      comment: "Total contract value - primary spend under contract metric for sourcing strategy effectiveness"
    - name: "total_minimum_commitment"
      expr: SUM(CAST(minimum_quantity_commitment AS DOUBLE))
      comment: "Total minimum quantity commitment - contract obligation metric for financial planning"
    - name: "total_maximum_commitment"
      expr: SUM(CAST(maximum_quantity_commitment AS DOUBLE))
      comment: "Total maximum quantity commitment - contract capacity metric for demand planning"
    - name: "contract_count"
      expr: COUNT(DISTINCT sourcing_contract_id)
      comment: "Distinct contract count for contract portfolio size and complexity tracking"
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value_total AS DOUBLE))
      comment: "Average contract value for contract size distribution analysis and small-contract consolidation"
    - name: "vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Distinct vendor count under contract for supplier concentration and diversification analysis"
    - name: "avg_contract_duration_days"
      expr: AVG(DATEDIFF(effective_end_date, effective_start_date))
      comment: "Average contract duration in days - contract term strategy KPI for flexibility vs stability tradeoff"
    - name: "expiring_contracts_90_days"
      expr: SUM(CASE WHEN DATEDIFF(effective_end_date, CURRENT_DATE()) <= 90 AND DATEDIFF(effective_end_date, CURRENT_DATE()) >= 0 THEN 1 ELSE 0 END)
      comment: "Count of contracts expiring within 90 days - renewal pipeline KPI for proactive contract management"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`procurement_approval_workflow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement approval process KPIs tracking approval cycle time, SLA compliance, escalations, and bottlenecks for process efficiency and compliance"
  source: "`waste_management_ecm`.`procurement`.`approval_workflow`"
  dimensions:
    - name: "workflow_status"
      expr: workflow_status
      comment: "Workflow status (e.g., pending, approved, rejected, escalated) for approval pipeline tracking"
    - name: "document_type"
      expr: document_type
      comment: "Document type (e.g., purchase requisition, PO, contract) for approval workload segmentation"
    - name: "approval_action"
      expr: approval_action
      comment: "Approval action taken (e.g., approved, rejected, delegated) for decision pattern analysis"
    - name: "approver_role"
      expr: approver_role
      comment: "Approver role for role-based approval performance tracking"
    - name: "spend_threshold_tier"
      expr: spend_threshold_tier
      comment: "Spend threshold tier for approval authority analysis and delegation optimization"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for urgent approval tracking and SLA management"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Escalation indicator for bottleneck identification and process improvement"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "SLA breach indicator for compliance tracking and approver accountability"
    - name: "sox_compliance_flag"
      expr: sox_compliance_flag
      comment: "SOX compliance indicator for internal control effectiveness tracking"
    - name: "budget_check_status"
      expr: budget_check_status
      comment: "Budget check status for budget control effectiveness analysis"
    - name: "segregation_of_duties_check_status"
      expr: segregation_of_duties_check_status
      comment: "Segregation of duties check status for fraud prevention control monitoring"
    - name: "initiated_year_month"
      expr: DATE_TRUNC('MONTH', workflow_initiated_timestamp)
      comment: "Month of workflow initiation for approval volume trend analysis"
  measures:
    - name: "total_spend_amount"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total spend amount under approval - spend governance coverage metric"
    - name: "workflow_count"
      expr: COUNT(DISTINCT approval_workflow_id)
      comment: "Distinct workflow count for approval workload and automation opportunity analysis"
    - name: "avg_approval_cycle_time_hours"
      expr: AVG(CAST(sla_actual_hours AS DOUBLE))
      comment: "Average approval cycle time in hours - critical procurement efficiency KPI for process optimization"
    - name: "avg_spend_per_approval"
      expr: AVG(CAST(spend_amount AS DOUBLE))
      comment: "Average spend amount per approval for approval threshold calibration"
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT approval_workflow_id), 0), 2)
      comment: "Percentage of approvals breaching SLA - approval process health KPI for management escalation"
    - name: "escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT approval_workflow_id), 0), 2)
      comment: "Percentage of approvals requiring escalation - bottleneck KPI for approval authority redesign"
    - name: "approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN approval_action = 'Approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT approval_workflow_id), 0), 2)
      comment: "Percentage of approvals granted - approval pattern KPI for policy effectiveness"
    - name: "rejection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN approval_action = 'Rejected' THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT approval_workflow_id), 0), 2)
      comment: "Percentage of approvals rejected - quality control KPI for requester training needs"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Receiving and inventory KPIs tracking goods receipt volume, valuation, quality inspection, and three-way match enablement for supply chain and inventory management"
  source: "`waste_management_ecm`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "movement_type"
      expr: movement_type
      comment: "Movement type (e.g., GR for PO, return to vendor, transfer) for inventory transaction classification"
    - name: "stock_type"
      expr: stock_type
      comment: "Stock type (e.g., unrestricted, quality inspection, blocked) for inventory availability tracking"
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection status for quality control process tracking"
    - name: "quality_inspection_required_flag"
      expr: quality_inspection_required_flag
      comment: "Quality inspection required indicator for QC workload planning"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Reversal indicator for goods receipt error rate tracking"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code for site-level receiving performance analysis"
    - name: "storage_location"
      expr: storage_location
      comment: "Storage location for warehouse-level receiving tracking"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for period-over-period inventory movement analysis"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual inventory trend analysis"
    - name: "posting_year_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of posting date for receiving volume trend tracking"
    - name: "document_year_month"
      expr: DATE_TRUNC('MONTH', document_date)
      comment: "Month of document date for goods receipt timing analysis"
  measures:
    - name: "total_valuation_amount"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total valuation amount of goods received - inventory value addition metric for working capital tracking"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received - receiving volume metric for warehouse capacity planning"
    - name: "goods_receipt_count"
      expr: COUNT(DISTINCT goods_receipt_id)
      comment: "Distinct goods receipt count for receiving transaction volume and workload analysis"
    - name: "avg_receipt_value"
      expr: AVG(CAST(valuation_amount AS DOUBLE))
      comment: "Average valuation per goods receipt for receipt size distribution analysis"
    - name: "avg_receipt_quantity"
      expr: AVG(CAST(received_quantity AS DOUBLE))
      comment: "Average quantity per goods receipt for receiving efficiency analysis"
    - name: "reversal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reversal_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT goods_receipt_id), 0), 2)
      comment: "Percentage of goods receipts reversed - receiving accuracy KPI for process quality and training needs"
    - name: "quality_inspection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN quality_inspection_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT goods_receipt_id), 0), 2)
      comment: "Percentage of receipts requiring quality inspection - QC coverage metric for quality assurance strategy"
    - name: "receiving_cycle_time_days"
      expr: AVG(DATEDIFF(posting_date, document_date))
      comment: "Average days from goods receipt document to GL posting - receiving efficiency KPI for inventory accuracy and financial close speed"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`procurement_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor master data KPIs tracking vendor portfolio composition, diversity, onboarding status, and compliance for supplier relationship management and diversity reporting"
  source: "`waste_management_ecm`.`procurement`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Vendor status (e.g., active, blocked, inactive) for vendor portfolio health tracking"
    - name: "vendor_type"
      expr: vendor_type
      comment: "Vendor type (e.g., goods, services, both) for vendor segmentation analysis"
    - name: "classification"
      expr: classification
      comment: "Vendor classification for strategic sourcing category alignment"
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Onboarding status for vendor activation pipeline tracking"
    - name: "performance_rating"
      expr: performance_rating
      comment: "Performance rating for vendor quality segmentation"
    - name: "minority_owned_flag"
      expr: minority_owned_flag
      comment: "Minority-owned business indicator for diversity spend tracking"
    - name: "woman_owned_flag"
      expr: woman_owned_flag
      comment: "Woman-owned business indicator for diversity spend tracking"
    - name: "veteran_owned_flag"
      expr: veteran_owned_flag
      comment: "Veteran-owned business indicator for diversity spend tracking"
    - name: "small_business_flag"
      expr: small_business_flag
      comment: "Small business indicator for small business spend tracking"
    - name: "country_code"
      expr: country_code
      comment: "Country code for geographic vendor distribution and local sourcing analysis"
    - name: "state_province"
      expr: state_province
      comment: "State or province for regional vendor distribution analysis"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for payment process optimization"
    - name: "insurance_certificate_on_file_flag"
      expr: insurance_certificate_on_file_flag
      comment: "Insurance certificate on file indicator for vendor compliance tracking"
    - name: "w9_on_file_flag"
      expr: w9_on_file_flag
      comment: "W9 on file indicator for tax compliance tracking"
    - name: "approved_year_month"
      expr: DATE_TRUNC('MONTH', approved_date)
      comment: "Month of vendor approval for onboarding velocity tracking"
  measures:
    - name: "vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Distinct vendor count - vendor portfolio size metric for supplier rationalization and complexity management"
    - name: "active_vendor_count"
      expr: SUM(CASE WHEN vendor_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of active vendors - active supplier base metric for vendor management workload"
    - name: "diversity_vendor_count"
      expr: SUM(CASE WHEN minority_owned_flag = TRUE OR woman_owned_flag = TRUE OR veteran_owned_flag = TRUE OR small_business_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of diversity vendors - diversity supplier base metric for corporate social responsibility and regulatory compliance"
    - name: "minority_owned_vendor_count"
      expr: SUM(CASE WHEN minority_owned_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of minority-owned vendors for diversity reporting"
    - name: "woman_owned_vendor_count"
      expr: SUM(CASE WHEN woman_owned_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of woman-owned vendors for diversity reporting"
    - name: "veteran_owned_vendor_count"
      expr: SUM(CASE WHEN veteran_owned_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of veteran-owned vendors for diversity reporting"
    - name: "small_business_vendor_count"
      expr: SUM(CASE WHEN small_business_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of small business vendors for small business spend reporting"
    - name: "insurance_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN insurance_certificate_on_file_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT vendor_id), 0), 2)
      comment: "Percentage of vendors with insurance certificate on file - vendor compliance KPI for risk management"
    - name: "tax_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN w9_on_file_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT vendor_id), 0), 2)
      comment: "Percentage of vendors with W9 on file - tax compliance KPI for audit readiness"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`procurement_invoice_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice exception management KPIs tracking three-way match failures, price and quantity variances, and resolution performance for AP process quality and vendor relationship management"
  source: "`waste_management_ecm`.`procurement`.`invoice_exception`"
  dimensions:
    - name: "exception_type"
      expr: exception_type
      comment: "Exception type (e.g., price variance, quantity variance, no PO match) for root cause analysis"
    - name: "exception_status"
      expr: exception_status
      comment: "Exception status (e.g., open, resolved, escalated) for exception pipeline tracking"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level for exception severity and management attention tracking"
    - name: "final_disposition"
      expr: final_disposition
      comment: "Final disposition (e.g., approved, rejected, adjusted) for exception outcome analysis"
    - name: "tolerance_breached_flag"
      expr: tolerance_breached_flag
      comment: "Tolerance breach indicator for policy compliance tracking"
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "SOX control indicator for internal control effectiveness monitoring"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code for department-level exception analysis"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code for site-level exception tracking"
    - name: "detected_year_month"
      expr: DATE_TRUNC('MONTH', exception_detected_timestamp)
      comment: "Month of exception detection for exception volume trend analysis"
    - name: "resolution_year_month"
      expr: DATE_TRUNC('MONTH', resolution_date)
      comment: "Month of exception resolution for resolution velocity tracking"
  measures:
    - name: "total_exception_amount"
      expr: SUM(CAST(exception_amount AS DOUBLE))
      comment: "Total exception amount - financial impact of invoice exceptions for process cost-benefit analysis"
    - name: "total_price_variance"
      expr: SUM(CAST(price_variance_amount AS DOUBLE))
      comment: "Total price variance amount - pricing accuracy metric for contract compliance and vendor negotiation"
    - name: "total_quantity_variance"
      expr: SUM(CAST(quantity_variance AS DOUBLE))
      comment: "Total quantity variance - receiving accuracy metric for warehouse process improvement"
    - name: "exception_count"
      expr: COUNT(DISTINCT invoice_exception_id)
      comment: "Distinct exception count - exception volume metric for AP process quality and automation ROI"
    - name: "avg_exception_amount"
      expr: AVG(CAST(exception_amount AS DOUBLE))
      comment: "Average exception amount for exception materiality analysis"
    - name: "exception_resolution_time_days"
      expr: AVG(DATEDIFF(resolution_date, exception_detected_timestamp))
      comment: "Average days from exception detection to resolution - exception management efficiency KPI for AP performance"
    - name: "tolerance_breach_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN tolerance_breached_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT invoice_exception_id), 0), 2)
      comment: "Percentage of exceptions breaching tolerance - policy effectiveness KPI for tolerance threshold calibration"
    - name: "exception_rate_per_invoice"
      expr: COUNT(DISTINCT invoice_exception_id)
      comment: "Exception count for exception rate calculation - three-way match quality KPI (denominator provided by invoice metrics)"
$$;