-- Metric views for domain: supply | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic procurement metrics for purchase order management including spend analysis, compliance rates, and delivery performance tracking for supply chain leadership."
  source: "`healthcare_ecm_v1`.`supply`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order (open, closed, cancelled, partially received)"
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (standard, blanket, contract, emergency)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for procurement governance"
    - name: "is_emergency_order"
      expr: is_emergency_order
      comment: "Flag indicating emergency/stat orders that bypass normal procurement workflows"
    - name: "is_capital_expenditure"
      expr: is_capital_expenditure
      comment: "Capital vs operating expense classification for financial planning"
    - name: "is_contract_compliant"
      expr: is_contract_compliant
      comment: "Whether the PO adheres to GPO/vendor contract terms"
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Order fulfillment status for supply chain tracking"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "PO-receipt-invoice three-way match status for AP compliance"
    - name: "order_year_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Order date truncated to month for trend analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency spend analysis"
  measures:
    - name: "total_purchase_orders"
      expr: COUNT(1)
      comment: "Total number of purchase orders for volume tracking"
    - name: "total_gross_spend"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross procurement spend before discounts and adjustments"
    - name: "total_net_spend"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net procurement spend after discounts - primary spend metric for budgeting"
    - name: "total_discount_savings"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount savings captured through contract compliance and negotiation"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight/shipping costs for logistics cost management"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax liability on procurement for financial reporting"
    - name: "avg_order_value"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average purchase order value indicating procurement consolidation effectiveness"
    - name: "emergency_order_count"
      expr: SUM(CASE WHEN is_emergency_order = TRUE THEN 1 ELSE 0 END)
      comment: "Count of emergency orders - high counts indicate supply planning failures"
    - name: "contract_compliant_count"
      expr: SUM(CASE WHEN is_contract_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of contract-compliant POs for GPO compliance rate calculation"
    - name: "capital_expenditure_total"
      expr: SUM(CASE WHEN is_capital_expenditure = TRUE THEN CAST(net_amount AS DOUBLE) ELSE 0 END)
      comment: "Total capital expenditure spend for CapEx budget tracking"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`supply_inventory_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory health and optimization metrics for supply chain management including stockout risk, par level compliance, and inventory valuation for materials management leadership."
  source: "`healthcare_ecm_v1`.`supply`.`inventory_balance`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current inventory status (active, quarantined, expired, recalled)"
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification for inventory prioritization (A=high value, B=medium, C=low)"
    - name: "item_category"
      expr: item_category
      comment: "Material category for spend category analysis"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (owned, consignment, loaner) for working capital analysis"
    - name: "replenishment_method"
      expr: replenishment_method
      comment: "How inventory is replenished (par, kanban, demand-driven, min-max)"
    - name: "below_reorder_flag"
      expr: below_reorder_flag
      comment: "Flag indicating inventory has fallen below reorder point"
    - name: "stockout_flag"
      expr: stockout_flag
      comment: "Flag indicating zero on-hand quantity - critical patient safety risk"
    - name: "recall_flag"
      expr: recall_flag
      comment: "Flag indicating item is under active recall requiring quarantine"
    - name: "formulary_flag"
      expr: formulary_flag
      comment: "Whether item is on approved formulary for compliance tracking"
  measures:
    - name: "total_items_tracked"
      expr: COUNT(1)
      comment: "Total inventory line items under management"
    - name: "total_inventory_value"
      expr: SUM(CAST(qty_on_hand AS DOUBLE) * CAST(unit_cost AS DOUBLE))
      comment: "Total on-hand inventory valuation for balance sheet and working capital reporting"
    - name: "total_qty_on_hand"
      expr: SUM(CAST(qty_on_hand AS DOUBLE))
      comment: "Total quantity on hand across all locations"
    - name: "total_qty_on_order"
      expr: SUM(CAST(qty_on_order AS DOUBLE))
      comment: "Total quantity on order for pipeline visibility"
    - name: "total_qty_in_transit"
      expr: SUM(CAST(qty_in_transit AS DOUBLE))
      comment: "Total quantity in transit for supply chain visibility"
    - name: "total_qty_quarantined"
      expr: SUM(CAST(qty_quarantine AS DOUBLE))
      comment: "Total quarantined quantity - indicates recall or quality issues"
    - name: "stockout_item_count"
      expr: SUM(CASE WHEN stockout_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of items currently stocked out - critical patient safety and operational metric"
    - name: "below_reorder_count"
      expr: SUM(CASE WHEN below_reorder_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of items below reorder point requiring immediate replenishment action"
    - name: "recall_affected_count"
      expr: SUM(CASE WHEN recall_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of items under active recall requiring quarantine and patient notification"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across inventory for cost trend monitoring"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`supply_inventory_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory movement and consumption metrics tracking material flow, waste, and cost allocation for operational efficiency and clinical supply utilization analysis."
  source: "`healthcare_ecm_v1`.`supply`.`inventory_transaction`"
  dimensions:
    - name: "movement_type_code"
      expr: movement_type_code
      comment: "SAP-style movement type code classifying the transaction (issue, receipt, transfer, return, adjustment)"
    - name: "movement_category"
      expr: movement_category
      comment: "High-level movement category for summary reporting"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Transaction processing status"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the movement - critical for waste and variance analysis"
    - name: "is_reversal"
      expr: is_reversal
      comment: "Whether this transaction reverses a prior posting"
    - name: "recall_flag"
      expr: recall_flag
      comment: "Whether transaction is related to a product recall"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Posting date truncated to month for period-over-period analysis"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center consuming the material for departmental cost allocation"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity normalization"
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total inventory transactions for volume and velocity tracking"
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total cost of all inventory movements - primary supply expense metric"
    - name: "total_quantity_moved"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved across all transaction types"
    - name: "total_count_variance_value"
      expr: SUM(CAST(count_variance_value AS DOUBLE))
      comment: "Total dollar value of count variances indicating shrinkage, theft, or process failures"
    - name: "total_count_variance_quantity"
      expr: SUM(CAST(count_variance_quantity AS DOUBLE))
      comment: "Total quantity variance from physical counts vs system"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per transaction for cost trend monitoring"
    - name: "reversal_count"
      expr: SUM(CASE WHEN is_reversal = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reversed transactions indicating errors or corrections in supply chain processes"
    - name: "recall_transaction_count"
      expr: SUM(CASE WHEN recall_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of recall-related transactions for recall response effectiveness tracking"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Receiving and quality metrics for goods receipt processing including receipt accuracy, vendor delivery performance, and three-way match compliance for procurement operations."
  source: "`healthcare_ecm_v1`.`supply`.`goods_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Current status of the goods receipt (posted, pending, rejected)"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "PO-receipt-invoice match status for AP compliance and payment release"
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Whether a quantity or quality discrepancy was found on receipt"
    - name: "discrepancy_type"
      expr: discrepancy_type
      comment: "Type of discrepancy (over-shipment, under-shipment, damage, wrong item)"
    - name: "movement_type"
      expr: movement_type
      comment: "Type of goods movement for receipt classification"
    - name: "condition_on_receipt"
      expr: condition_on_receipt
      comment: "Condition of goods when received for vendor quality tracking"
    - name: "temperature_excursion_flag"
      expr: temperature_excursion_flag
      comment: "Whether a temperature excursion occurred during shipping - critical for pharmaceuticals and biologics"
    - name: "implantable_device_flag"
      expr: implantable_device_flag
      comment: "Whether receipt contains implantable devices requiring UDI tracking"
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Receipt date truncated to month for trend analysis"
    - name: "recall_flag"
      expr: recall_flag
      comment: "Whether received items are under active recall"
  measures:
    - name: "total_receipts"
      expr: COUNT(1)
      comment: "Total goods receipts processed for receiving throughput measurement"
    - name: "total_receipt_value"
      expr: SUM(CAST(total_receipt_value AS DOUBLE))
      comment: "Total value of goods received for spend accrual and AP matching"
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity received across all receipts"
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered for fill rate calculation"
    - name: "discrepancy_count"
      expr: SUM(CASE WHEN discrepancy_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of receipts with discrepancies - indicates vendor quality or logistics issues"
    - name: "temperature_excursion_count"
      expr: SUM(CASE WHEN temperature_excursion_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of temperature excursions - critical for cold chain compliance and patient safety"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost on receipt for price variance monitoring against contract prices"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`supply_case_cart`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Surgical supply chain metrics for case cart assembly, delivery performance, and waste tracking to optimize OR supply utilization and reduce surgical delays."
  source: "`healthcare_ecm_v1`.`supply`.`case_cart`"
  dimensions:
    - name: "cart_status"
      expr: cart_status
      comment: "Current case cart status (assembled, delivered, returned, in-progress)"
    - name: "assembly_status"
      expr: assembly_status
      comment: "Assembly workflow status for pick/pack tracking"
    - name: "case_cart_type"
      expr: case_cart_type
      comment: "Type of case cart (standard, custom, emergency, implant)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for cart assembly scheduling"
    - name: "procedure_type"
      expr: procedure_type
      comment: "Surgical procedure type driving supply requirements"
    - name: "missing_item_flag"
      expr: missing_item_flag
      comment: "Whether cart had missing items at delivery - impacts OR efficiency"
    - name: "substitution_flag"
      expr: substitution_flag
      comment: "Whether item substitutions were required - indicates supply availability issues"
    - name: "recall_flag"
      expr: recall_flag
      comment: "Whether cart contained recalled items requiring intervention"
    - name: "implant_flag"
      expr: implant_flag
      comment: "Whether cart contains implantable devices requiring UDI tracking"
    - name: "scheduled_procedure_month"
      expr: DATE_TRUNC('MONTH', scheduled_procedure_date)
      comment: "Scheduled procedure month for demand planning"
  measures:
    - name: "total_case_carts"
      expr: COUNT(1)
      comment: "Total case carts assembled for surgical volume tracking"
    - name: "total_supply_cost"
      expr: SUM(CAST(total_supply_cost AS DOUBLE))
      comment: "Total supply cost across all case carts - primary surgical supply spend metric"
    - name: "total_waste_cost"
      expr: SUM(CAST(waste_cost AS DOUBLE))
      comment: "Total waste cost from opened/unused supplies - key efficiency improvement target"
    - name: "missing_item_cart_count"
      expr: SUM(CASE WHEN missing_item_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of carts with missing items - directly impacts OR delays and patient safety"
    - name: "substitution_cart_count"
      expr: SUM(CASE WHEN substitution_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of carts requiring substitutions - indicates preference card or supply chain issues"
    - name: "avg_supply_cost_per_cart"
      expr: AVG(CAST(total_supply_cost AS DOUBLE))
      comment: "Average supply cost per case cart for surgical cost benchmarking"
    - name: "avg_waste_cost_per_cart"
      expr: AVG(CAST(waste_cost AS DOUBLE))
      comment: "Average waste cost per cart for waste reduction program effectiveness tracking"
    - name: "delivery_confirmed_count"
      expr: SUM(CASE WHEN delivery_confirmation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of carts with confirmed delivery for on-time delivery rate calculation"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`supply_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance and compliance metrics for strategic sourcing decisions including delivery reliability, diversity spend tracking, and regulatory compliance monitoring."
  source: "`healthcare_ecm_v1`.`supply`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current vendor status (active, inactive, suspended, probation)"
    - name: "vendor_type"
      expr: vendor_type
      comment: "Vendor classification (manufacturer, distributor, GPO, local)"
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Whether vendor is preferred/contracted for compliance tracking"
    - name: "diversity_classification"
      expr: diversity_classification
      comment: "Diversity classification (MBE, WBE, SDVOB, HUBZone) for diversity spend reporting"
    - name: "gpo_affiliation"
      expr: gpo_affiliation
      comment: "Group purchasing organization affiliation for contract compliance"
    - name: "oig_excluded_flag"
      expr: oig_excluded_flag
      comment: "Whether vendor is on OIG exclusion list - critical compliance risk"
    - name: "edi_capable_flag"
      expr: edi_capable_flag
      comment: "Whether vendor supports EDI for supply chain automation maturity"
    - name: "recall_notification_flag"
      expr: recall_notification_flag
      comment: "Whether vendor participates in recall notification program"
    - name: "state_code"
      expr: state_code
      comment: "Vendor state for geographic sourcing analysis"
  measures:
    - name: "total_vendors"
      expr: COUNT(1)
      comment: "Total vendor count for supplier base management"
    - name: "avg_fill_rate"
      expr: AVG(CAST(fill_rate AS DOUBLE))
      comment: "Average vendor fill rate - key reliability metric for supply continuity"
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate across vendors for logistics performance"
    - name: "avg_performance_rating"
      expr: AVG(CAST(performance_rating AS DOUBLE))
      comment: "Average vendor performance rating for strategic sourcing decisions"
    - name: "preferred_vendor_count"
      expr: SUM(CASE WHEN preferred_vendor_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of preferred vendors for contract utilization analysis"
    - name: "oig_excluded_count"
      expr: SUM(CASE WHEN oig_excluded_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of OIG-excluded vendors - must be zero for compliance; any non-zero triggers immediate action"
    - name: "diversity_vendor_count"
      expr: SUM(CASE WHEN diversity_classification IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of diversity-classified vendors for supplier diversity program reporting"
    - name: "avg_minimum_order_amount"
      expr: AVG(CAST(minimum_order_amount AS DOUBLE))
      comment: "Average minimum order threshold for procurement consolidation planning"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`supply_vendor_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract management and compliance metrics for vendor agreements including spend commitment tracking, pricing governance, and contract lifecycle management."
  source: "`healthcare_ecm_v1`.`supply`.`vendor_contract`"
  dimensions:
    - name: "facility_contract_status"
      expr: facility_contract_status
      comment: "Current contract status (active, expired, pending renewal, terminated)"
    - name: "facility_contract_type"
      expr: facility_contract_type
      comment: "Contract type (GPO, local, sole source, emergency)"
    - name: "gpo_affiliation"
      expr: gpo_affiliation
      comment: "GPO affiliation for contract tier analysis"
    - name: "renewal_type"
      expr: renewal_type
      comment: "Contract renewal type (auto-renew, manual, evergreen)"
    - name: "is_sole_source_justified"
      expr: is_sole_source_justified
      comment: "Whether sole source justification exists for compliance audit"
    - name: "is_diversity_spend"
      expr: is_diversity_spend
      comment: "Whether contract qualifies as diversity spend"
    - name: "product_category"
      expr: product_category
      comment: "Product category covered by contract for category management"
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total vendor contracts under management"
    - name: "total_contract_value"
      expr: SUM(CAST(facility_contract_value AS DOUBLE))
      comment: "Total value of all vendor contracts for spend under management reporting"
    - name: "total_annual_commitment"
      expr: SUM(CAST(annual_commitment_amount AS DOUBLE))
      comment: "Total annual commitment across all contracts for budget planning"
    - name: "avg_base_unit_price"
      expr: AVG(CAST(base_unit_price AS DOUBLE))
      comment: "Average base unit price across contracts for pricing benchmark analysis"
    - name: "avg_rebate_pct"
      expr: AVG(CAST(rebate_pct AS DOUBLE))
      comment: "Average rebate percentage for contract value optimization"
    - name: "avg_compliance_threshold_pct"
      expr: AVG(CAST(compliance_threshold_pct AS DOUBLE))
      comment: "Average compliance threshold for contract adherence monitoring"
    - name: "sole_source_count"
      expr: SUM(CASE WHEN is_sole_source_justified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of sole-source contracts requiring justification for audit readiness"
    - name: "diversity_contract_count"
      expr: SUM(CASE WHEN is_diversity_spend = TRUE THEN 1 ELSE 0 END)
      comment: "Count of diversity spend contracts for supplier diversity program goals"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`supply_recall_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product recall management metrics for patient safety and regulatory compliance including recall response timeliness, patient impact assessment, and financial exposure tracking."
  source: "`healthcare_ecm_v1`.`supply`.`recall_notice`"
  dimensions:
    - name: "recall_status"
      expr: recall_status
      comment: "Current recall status (active, resolved, monitoring, closed)"
    - name: "recall_class"
      expr: recall_class
      comment: "FDA recall classification (Class I=most serious, Class II, Class III)"
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall (voluntary, mandatory, market withdrawal)"
    - name: "recall_initiation_source"
      expr: recall_initiation_source
      comment: "Who initiated the recall (FDA, manufacturer, facility)"
    - name: "patient_notification_required"
      expr: patient_notification_required
      comment: "Whether patient notification is required - triggers urgent workflow"
    - name: "patient_impact_assessment_status"
      expr: patient_impact_assessment_status
      comment: "Status of patient impact assessment for clinical risk management"
    - name: "implantable_device_flag"
      expr: implantable_device_flag
      comment: "Whether recall involves implantable devices requiring patient tracking"
    - name: "regulatory_report_submitted"
      expr: regulatory_report_submitted
      comment: "Whether required regulatory report has been submitted"
  measures:
    - name: "total_recall_notices"
      expr: COUNT(1)
      comment: "Total recall notices for recall volume and trend monitoring"
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total financial credit expected from vendors for recalled products"
    - name: "patient_notification_required_count"
      expr: SUM(CASE WHEN patient_notification_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of recalls requiring patient notification - highest urgency for clinical risk"
    - name: "implantable_recall_count"
      expr: SUM(CASE WHEN implantable_device_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of implantable device recalls requiring individual patient tracking and follow-up"
    - name: "pending_regulatory_report_count"
      expr: SUM(CASE WHEN regulatory_report_submitted = FALSE THEN 1 ELSE 0 END)
      comment: "Count of recalls with pending regulatory reports - compliance risk indicator"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`supply_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Requisition workflow metrics for demand management including approval cycle times, fulfillment rates, and clinical urgency tracking for supply chain responsiveness."
  source: "`healthcare_ecm_v1`.`supply`.`requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current requisition status (submitted, approved, fulfilled, rejected, cancelled)"
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of requisition (standard, emergency, par replenishment, recall replacement)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for procurement governance"
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency level (routine, urgent, stat, emergency) for prioritization"
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "How the requisition will be fulfilled (stock, purchase, transfer, consignment)"
    - name: "is_par_triggered"
      expr: is_par_triggered
      comment: "Whether requisition was auto-triggered by PAR level system"
    - name: "is_recall_related"
      expr: is_recall_related
      comment: "Whether requisition is related to a product recall replacement"
    - name: "is_capital_expense"
      expr: is_capital_expense
      comment: "Capital vs operating expense classification"
    - name: "submitted_month"
      expr: DATE_TRUNC('MONTH', submitted_timestamp)
      comment: "Submission month for demand trend analysis"
  measures:
    - name: "total_requisitions"
      expr: COUNT(1)
      comment: "Total requisitions for demand volume tracking"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_total_cost AS DOUBLE))
      comment: "Total estimated cost of all requisitions for budget forecasting"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_total_cost AS DOUBLE))
      comment: "Total actual fulfilled cost for spend tracking"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_total_cost AS DOUBLE))
      comment: "Average requisition estimated cost for demand planning"
    - name: "par_triggered_count"
      expr: SUM(CASE WHEN is_par_triggered = TRUE THEN 1 ELSE 0 END)
      comment: "Count of PAR-triggered requisitions indicating automated replenishment effectiveness"
    - name: "recall_related_count"
      expr: SUM(CASE WHEN is_recall_related = TRUE THEN 1 ELSE 0 END)
      comment: "Count of recall-related requisitions for recall response cost tracking"
    - name: "rejected_count"
      expr: SUM(CASE WHEN approval_status = 'rejected' THEN 1 ELSE 0 END)
      comment: "Count of rejected requisitions for process improvement and training needs identification"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`supply_sterile_processing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sterile processing department (SPD) quality and throughput metrics for instrument reprocessing compliance, sterilization effectiveness, and surgical supply readiness."
  source: "`healthcare_ecm_v1`.`supply`.`sterile_processing_record`"
  dimensions:
    - name: "sterilization_method"
      expr: sterilization_method
      comment: "Method of sterilization (steam, EtO, hydrogen peroxide, peracetic acid)"
    - name: "cycle_type"
      expr: cycle_type
      comment: "Sterilization cycle type (gravity, prevacuum, flash/IUSS, low temp)"
    - name: "release_status"
      expr: release_status
      comment: "Release status of processed instruments (released, held, failed)"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Instrument lifecycle status for asset management"
    - name: "biological_indicator_result"
      expr: biological_indicator_result
      comment: "Biological indicator test result (pass/fail) - gold standard for sterilization verification"
    - name: "chemical_indicator_result"
      expr: chemical_indicator_result
      comment: "Chemical indicator result for process monitoring"
    - name: "immediate_use_flag"
      expr: immediate_use_flag
      comment: "Whether immediate-use steam sterilization (IUSS) was performed - should be minimized"
    - name: "recall_flag"
      expr: recall_flag
      comment: "Whether processing involves recalled instruments"
    - name: "quality_assurance_reviewed_flag"
      expr: quality_assurance_reviewed_flag
      comment: "Whether QA review was completed for compliance documentation"
  measures:
    - name: "total_processing_records"
      expr: COUNT(1)
      comment: "Total sterile processing records for throughput measurement"
    - name: "avg_exposure_time_minutes"
      expr: AVG(CAST(exposure_time_minutes AS DOUBLE))
      comment: "Average sterilization exposure time for cycle optimization"
    - name: "avg_exposure_temperature"
      expr: AVG(CAST(exposure_temperature_c AS DOUBLE))
      comment: "Average exposure temperature for process control monitoring"
    - name: "avg_tray_weight"
      expr: AVG(CAST(tray_weight_kg AS DOUBLE))
      comment: "Average tray weight for load optimization and ergonomic safety"
    - name: "iuss_count"
      expr: SUM(CASE WHEN immediate_use_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of immediate-use sterilization events - high counts indicate scheduling or inventory failures"
    - name: "qa_reviewed_count"
      expr: SUM(CASE WHEN quality_assurance_reviewed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of QA-reviewed records for compliance rate calculation"
    - name: "recall_affected_count"
      expr: SUM(CASE WHEN recall_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of processing records involving recalled instruments for recall response tracking"
$$;