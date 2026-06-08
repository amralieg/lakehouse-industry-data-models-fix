-- Metric views for domain: procurement | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 23:12:43

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic procurement KPIs tracking purchase order value, volume, cycle time, and operational efficiency across suppliers and plants"
  source: "`food_beverage_ecm`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Purchase order status (e.g., approved, pending, closed) for filtering and segmentation"
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g., standard, blanket, contract) for procurement strategy analysis"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for tracking procurement governance and bottlenecks"
    - name: "purchasing_org_code"
      expr: purchasing_org_code
      comment: "Purchasing organization code for multi-org procurement performance comparison"
    - name: "purchasing_group_code"
      expr: purchasing_group_code
      comment: "Purchasing group code for buyer team performance and workload analysis"
    - name: "company_code"
      expr: company_code
      comment: "Company code for consolidated financial reporting and inter-company procurement analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency procurement spend analysis"
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "International commercial terms for logistics cost allocation and risk management"
    - name: "material_group_code"
      expr: material_group_code
      comment: "Material group classification for category spend analysis and sourcing strategy"
    - name: "order_year"
      expr: YEAR(order_date)
      comment: "Year of purchase order creation for year-over-year procurement trend analysis"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month of purchase order creation for seasonal procurement pattern analysis"
    - name: "food_safety_hold_indicator"
      expr: food_safety_hold_indicator
      comment: "Flag indicating food safety hold status for quality risk monitoring"
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Hazardous material indicator for regulatory compliance and safety tracking"
    - name: "tracegains_compliance_status"
      expr: tracegains_compliance_status
      comment: "TraceGains compliance status for supplier documentation and food safety compliance"
  measures:
    - name: "total_po_count"
      expr: COUNT(DISTINCT purchase_order_id)
      comment: "Total number of unique purchase orders for procurement volume tracking"
    - name: "total_po_gross_amount"
      expr: SUM(CAST(po_gross_amount AS DOUBLE))
      comment: "Total gross purchase order value for procurement spend analysis and budget tracking"
    - name: "total_po_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net purchase order value excluding taxes for true procurement cost analysis"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across purchase orders for tax liability and compliance reporting"
    - name: "avg_po_value"
      expr: AVG(CAST(po_gross_amount AS DOUBLE))
      comment: "Average purchase order value for procurement efficiency and order consolidation analysis"
    - name: "total_quantity_ordered"
      expr: SUM(CAST(total_quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered across all POs for demand volume and capacity planning"
    - name: "total_quantity_received"
      expr: SUM(CAST(total_quantity_received AS DOUBLE))
      comment: "Total quantity received for supplier delivery performance and inventory planning"
    - name: "fill_rate"
      expr: ROUND(100.0 * SUM(CAST(total_quantity_received AS DOUBLE)) / NULLIF(SUM(CAST(total_quantity_ordered AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity actually received for supplier reliability and service level measurement"
    - name: "avg_order_to_delivery_days"
      expr: AVG(DATEDIFF(actual_delivery_date, order_date))
      comment: "Average days from order to actual delivery for lead time performance and planning accuracy"
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_date <= requested_delivery_date THEN 1 END)
      comment: "Count of purchase orders delivered on or before requested date for supplier OTD performance"
    - name: "late_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_date > requested_delivery_date THEN 1 END)
      comment: "Count of purchase orders delivered late for supplier performance management and risk identification"
    - name: "food_safety_hold_count"
      expr: COUNT(CASE WHEN food_safety_hold_indicator = TRUE THEN 1 END)
      comment: "Count of purchase orders with food safety holds for quality risk monitoring and supplier audit triggers"
    - name: "hazmat_po_count"
      expr: COUNT(CASE WHEN hazmat_indicator = TRUE THEN 1 END)
      comment: "Count of purchase orders containing hazardous materials for regulatory compliance and safety tracking"
    - name: "blanket_po_value_limit_total"
      expr: SUM(CAST(blanket_po_value_limit AS DOUBLE))
      comment: "Total blanket PO value limits for contract utilization and spend commitment tracking"
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers used for supplier base consolidation and diversification strategy"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`procurement_supplier_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Executive supplier performance KPIs tracking quality, delivery, cost, compliance, and overall supplier value across evaluation periods"
  source: "`food_beverage_ecm`.`procurement`.`supplier_scorecard`"
  dimensions:
    - name: "scorecard_status"
      expr: scorecard_status
      comment: "Scorecard status (e.g., draft, approved, published) for governance and review workflow tracking"
    - name: "evaluation_period_type"
      expr: evaluation_period_type
      comment: "Type of evaluation period (e.g., monthly, quarterly, annual) for performance review cadence"
    - name: "supplier_category"
      expr: supplier_category
      comment: "Supplier category classification for strategic vs tactical supplier performance comparison"
    - name: "preferred_supplier_flag"
      expr: preferred_supplier_flag
      comment: "Preferred supplier designation for strategic sourcing and supplier relationship management"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating whether corrective action is required for supplier performance intervention tracking"
    - name: "avl_status"
      expr: avl_status
      comment: "Approved vendor list status for supplier qualification and sourcing eligibility"
    - name: "food_safety_audit_result"
      expr: food_safety_audit_result
      comment: "Food safety audit result for quality risk assessment and supplier certification tracking"
    - name: "food_safety_certification_scheme"
      expr: food_safety_certification_scheme
      comment: "Food safety certification scheme (e.g., SQF, BRC, FSSC) for compliance and quality assurance"
    - name: "sustainability_rating"
      expr: sustainability_rating
      comment: "Sustainability rating for ESG performance tracking and responsible sourcing initiatives"
    - name: "evaluation_year"
      expr: YEAR(evaluation_period_start_date)
      comment: "Year of evaluation period start for year-over-year supplier performance trending"
    - name: "evaluation_quarter"
      expr: DATE_TRUNC('QUARTER', evaluation_period_start_date)
      comment: "Quarter of evaluation period start for quarterly business review and supplier performance tracking"
    - name: "spend_currency_code"
      expr: spend_currency_code
      comment: "Currency code for spend reporting for multi-currency supplier spend analysis"
  measures:
    - name: "total_scorecard_count"
      expr: COUNT(DISTINCT supplier_scorecard_id)
      comment: "Total number of supplier scorecards for supplier evaluation coverage and governance tracking"
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall supplier score for supplier base performance benchmarking and strategic decisions"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score for supplier quality performance and defect reduction initiatives"
    - name: "avg_delivery_score"
      expr: AVG(CAST(delivery_score AS DOUBLE))
      comment: "Average delivery score for supplier reliability and on-time delivery performance"
    - name: "avg_cost_score"
      expr: AVG(CAST(cost_score AS DOUBLE))
      comment: "Average cost score for supplier pricing competitiveness and cost management effectiveness"
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score for regulatory adherence and food safety risk management"
    - name: "avg_service_score"
      expr: AVG(CAST(service_score AS DOUBLE))
      comment: "Average service score for supplier responsiveness and customer service quality"
    - name: "avg_responsiveness_score"
      expr: AVG(CAST(responsiveness_score AS DOUBLE))
      comment: "Average responsiveness score for supplier communication and issue resolution effectiveness"
    - name: "avg_otif_rate"
      expr: AVG(CAST(otif_rate AS DOUBLE))
      comment: "Average on-time in-full delivery rate for supplier delivery excellence and service level performance"
    - name: "avg_fill_rate"
      expr: AVG(CAST(fill_rate AS DOUBLE))
      comment: "Average fill rate for supplier order fulfillment capability and inventory planning reliability"
    - name: "avg_defect_rate_ppm"
      expr: AVG(CAST(defect_rate_ppm AS DOUBLE))
      comment: "Average defect rate in parts per million for supplier quality performance and Six Sigma tracking"
    - name: "avg_coa_compliance_rate"
      expr: AVG(CAST(coa_compliance_rate AS DOUBLE))
      comment: "Average certificate of analysis compliance rate for supplier documentation quality and regulatory compliance"
    - name: "avg_allergen_compliance_rate"
      expr: AVG(CAST(allergen_compliance_rate AS DOUBLE))
      comment: "Average allergen compliance rate for food safety risk management and consumer protection"
    - name: "avg_shelf_life_compliance_rate"
      expr: AVG(CAST(shelf_life_compliance_rate AS DOUBLE))
      comment: "Average shelf life compliance rate for product freshness and inventory waste reduction"
    - name: "avg_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate AS DOUBLE))
      comment: "Average invoice accuracy rate for accounts payable efficiency and financial reconciliation"
    - name: "avg_lead_time_performance_rate"
      expr: AVG(CAST(lead_time_performance_rate AS DOUBLE))
      comment: "Average lead time performance rate for supplier planning reliability and supply chain agility"
    - name: "avg_price_variance_rate"
      expr: AVG(CAST(price_variance_rate AS DOUBLE))
      comment: "Average price variance rate for supplier pricing stability and cost predictability"
    - name: "total_spend_amount"
      expr: SUM(CAST(total_spend_amount AS DOUBLE))
      comment: "Total supplier spend for strategic sourcing decisions and supplier relationship investment prioritization"
    - name: "avg_spend_per_supplier"
      expr: AVG(CAST(total_spend_amount AS DOUBLE))
      comment: "Average spend per supplier for supplier consolidation and volume leverage opportunities"
    - name: "total_nonconformance_count"
      expr: SUM(CAST(nonconformance_count AS DOUBLE))
      comment: "Total nonconformance count for supplier quality issue tracking and corrective action prioritization"
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of scorecards requiring corrective action for supplier performance intervention and resource allocation"
    - name: "preferred_supplier_count"
      expr: COUNT(CASE WHEN preferred_supplier_flag = TRUE THEN 1 END)
      comment: "Count of preferred suppliers for strategic sourcing and supplier relationship management effectiveness"
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers evaluated for supplier base management and performance coverage"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational procurement KPIs tracking goods receipt volume, value, quality compliance, and receiving efficiency for inventory and quality management"
  source: "`food_beverage_ecm`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Goods receipt status for receiving workflow tracking and exception management"
    - name: "movement_type"
      expr: movement_type
      comment: "SAP movement type for inventory transaction classification and financial posting"
    - name: "quality_inspection_required_flag"
      expr: quality_inspection_required_flag
      comment: "Flag indicating quality inspection requirement for quality control workload and compliance tracking"
    - name: "certificate_of_analysis_received_flag"
      expr: certificate_of_analysis_received_flag
      comment: "Flag indicating COA receipt for supplier documentation compliance and quality assurance"
    - name: "allergen_declaration_received_flag"
      expr: allergen_declaration_received_flag
      comment: "Flag indicating allergen declaration receipt for food safety compliance and consumer protection"
    - name: "cold_chain_compliant_flag"
      expr: cold_chain_compliant_flag
      comment: "Flag indicating cold chain compliance for temperature-sensitive product quality and safety"
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency receiving value analysis"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity normalization and cross-material comparison"
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation type for inventory accounting and cost allocation"
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code for tax liability calculation and compliance reporting"
    - name: "receipt_year"
      expr: YEAR(goods_receipt_date)
      comment: "Year of goods receipt for year-over-year receiving volume and value trending"
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', goods_receipt_date)
      comment: "Month of goods receipt for seasonal receiving pattern analysis and capacity planning"
    - name: "unloading_point"
      expr: unloading_point
      comment: "Unloading point for dock utilization and receiving resource allocation"
  measures:
    - name: "total_goods_receipt_count"
      expr: COUNT(DISTINCT goods_receipt_id)
      comment: "Total number of goods receipts for receiving volume tracking and operational workload analysis"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received for inventory inflow and supply chain throughput measurement"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered for demand planning and supplier commitment tracking"
    - name: "total_quantity_variance"
      expr: SUM(CAST(quantity_variance AS DOUBLE))
      comment: "Total quantity variance (received vs ordered) for supplier delivery accuracy and inventory reconciliation"
    - name: "avg_quantity_variance"
      expr: AVG(CAST(quantity_variance AS DOUBLE))
      comment: "Average quantity variance per receipt for supplier performance and receiving accuracy assessment"
    - name: "total_receipt_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total goods receipt value for inventory valuation and procurement spend tracking"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on goods receipts for tax liability and compliance reporting"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across receipts for price trend analysis and cost benchmarking"
    - name: "quality_inspection_required_count"
      expr: COUNT(CASE WHEN quality_inspection_required_flag = TRUE THEN 1 END)
      comment: "Count of receipts requiring quality inspection for QC workload planning and resource allocation"
    - name: "coa_received_count"
      expr: COUNT(CASE WHEN certificate_of_analysis_received_flag = TRUE THEN 1 END)
      comment: "Count of receipts with COA received for supplier documentation compliance tracking"
    - name: "coa_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN certificate_of_analysis_received_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipts with COA received for supplier quality documentation performance"
    - name: "allergen_declaration_received_count"
      expr: COUNT(CASE WHEN allergen_declaration_received_flag = TRUE THEN 1 END)
      comment: "Count of receipts with allergen declaration for food safety compliance and consumer protection"
    - name: "allergen_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN allergen_declaration_received_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipts with allergen declaration for food safety regulatory compliance"
    - name: "cold_chain_compliant_count"
      expr: COUNT(CASE WHEN cold_chain_compliant_flag = TRUE THEN 1 END)
      comment: "Count of cold chain compliant receipts for temperature-sensitive product quality assurance"
    - name: "cold_chain_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cold_chain_compliant_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipts meeting cold chain requirements for perishable product quality and safety"
    - name: "avg_temperature_at_receipt"
      expr: AVG(CAST(temperature_at_receipt_c AS DOUBLE))
      comment: "Average temperature at receipt for cold chain monitoring and quality control"
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers with goods receipts for supplier base activity and diversification tracking"
    - name: "distinct_material_count"
      expr: COUNT(DISTINCT raw_material_id)
      comment: "Number of unique materials received for SKU complexity and receiving operation scope"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`procurement_supplier_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier quality and compliance KPIs tracking audit scores, findings, CAPA effectiveness, and certification status for risk management and supplier qualification"
  source: "`food_beverage_ecm`.`procurement`.`supplier_audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Audit status (e.g., scheduled, in progress, completed, closed) for audit program management"
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., food safety, quality, regulatory) for audit program scope and resource allocation"
    - name: "audit_grade"
      expr: audit_grade
      comment: "Audit grade classification for supplier risk tiering and qualification decisions"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail audit outcome for supplier approval and disqualification decisions"
    - name: "certification_status"
      expr: certification_status
      comment: "Certification status for supplier qualification and approved vendor list management"
    - name: "fsma_compliance_flag"
      expr: fsma_compliance_flag
      comment: "FSMA compliance flag for regulatory adherence and food safety risk management"
    - name: "gfsi_recognized_flag"
      expr: gfsi_recognized_flag
      comment: "GFSI recognition flag for global food safety standard compliance and supplier qualification"
    - name: "capa_required_flag"
      expr: capa_required_flag
      comment: "Corrective and preventive action required flag for supplier performance intervention tracking"
    - name: "capa_verification_status"
      expr: capa_verification_status
      comment: "CAPA verification status for corrective action effectiveness and closure tracking"
    - name: "auditor_organization"
      expr: auditor_organization
      comment: "Auditor organization for third-party audit program management and cost allocation"
    - name: "auditor_certification"
      expr: auditor_certification
      comment: "Auditor certification for audit quality assurance and credibility"
    - name: "audit_scope"
      expr: audit_scope
      comment: "Audit scope description for audit program coverage and risk area focus"
    - name: "audit_year"
      expr: YEAR(audit_date)
      comment: "Year of audit for year-over-year supplier quality trending and audit program effectiveness"
    - name: "audit_quarter"
      expr: DATE_TRUNC('QUARTER', audit_date)
      comment: "Quarter of audit for quarterly audit program tracking and supplier performance review"
  measures:
    - name: "total_audit_count"
      expr: COUNT(DISTINCT supplier_audit_id)
      comment: "Total number of supplier audits for audit program coverage and resource utilization tracking"
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score for supplier quality performance benchmarking and risk assessment"
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS DOUBLE))
      comment: "Total critical findings across audits for high-risk issue identification and immediate intervention"
    - name: "total_major_findings"
      expr: SUM(CAST(major_findings_count AS DOUBLE))
      comment: "Total major findings for significant quality and compliance issue tracking"
    - name: "total_minor_findings"
      expr: SUM(CAST(minor_findings_count AS DOUBLE))
      comment: "Total minor findings for continuous improvement opportunity identification"
    - name: "total_observations"
      expr: SUM(CAST(observation_count AS DOUBLE))
      comment: "Total observations for supplier development and best practice sharing"
    - name: "avg_critical_findings_per_audit"
      expr: AVG(CAST(critical_findings_count AS DOUBLE))
      comment: "Average critical findings per audit for supplier risk severity assessment"
    - name: "avg_major_findings_per_audit"
      expr: AVG(CAST(major_findings_count AS DOUBLE))
      comment: "Average major findings per audit for supplier quality performance trending"
    - name: "pass_count"
      expr: COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END)
      comment: "Count of passed audits for supplier qualification success rate and audit program effectiveness"
    - name: "fail_count"
      expr: COUNT(CASE WHEN pass_fail_status = 'Fail' THEN 1 END)
      comment: "Count of failed audits for supplier disqualification and high-risk supplier identification"
    - name: "audit_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits passed for supplier base quality performance and audit program rigor"
    - name: "fsma_compliant_count"
      expr: COUNT(CASE WHEN fsma_compliance_flag = TRUE THEN 1 END)
      comment: "Count of FSMA compliant audits for regulatory compliance and food safety risk management"
    - name: "fsma_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fsma_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits meeting FSMA requirements for regulatory adherence and import compliance"
    - name: "gfsi_recognized_count"
      expr: COUNT(CASE WHEN gfsi_recognized_flag = TRUE THEN 1 END)
      comment: "Count of GFSI recognized audits for global food safety standard compliance"
    - name: "gfsi_recognition_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gfsi_recognized_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits with GFSI recognition for supplier quality benchmark and customer requirement compliance"
    - name: "capa_required_count"
      expr: COUNT(CASE WHEN capa_required_flag = TRUE THEN 1 END)
      comment: "Count of audits requiring CAPA for supplier corrective action workload and resource planning"
    - name: "capa_verified_count"
      expr: COUNT(CASE WHEN capa_verification_status = 'Verified' THEN 1 END)
      comment: "Count of verified CAPAs for corrective action effectiveness and closure rate tracking"
    - name: "capa_effectiveness_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN capa_verification_status = 'Verified' THEN 1 END) / NULLIF(COUNT(CASE WHEN capa_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of required CAPAs successfully verified for supplier corrective action program effectiveness"
    - name: "avg_audit_duration_days"
      expr: AVG(DATEDIFF(audit_end_timestamp, audit_start_timestamp))
      comment: "Average audit duration in days for audit program efficiency and resource planning"
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers audited for audit program coverage and supplier base risk assessment"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`procurement_purchase_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic contract management KPIs tracking contract value, volume commitments, pricing mechanisms, and contract lifecycle for sourcing strategy and supplier relationship management"
  source: "`food_beverage_ecm`.`procurement`.`purchase_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Contract status (e.g., active, expired, terminated) for contract portfolio management and renewal planning"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g., fixed price, cost plus, volume discount) for sourcing strategy and pricing model analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for multi-currency contract value analysis and FX risk management"
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization for multi-org contract governance and spend consolidation"
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Purchasing group for buyer team contract management and workload allocation"
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms for logistics cost allocation and risk transfer analysis"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for cash flow management and supplier financing strategy"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Auto-renewal flag for contract lifecycle automation and renewal risk management"
    - name: "exclusivity_clause_flag"
      expr: exclusivity_clause_flag
      comment: "Exclusivity clause flag for supplier relationship strategy and sourcing flexibility"
    - name: "rebate_agreement_flag"
      expr: rebate_agreement_flag
      comment: "Rebate agreement flag for volume incentive tracking and cost recovery opportunities"
    - name: "price_adjustment_mechanism"
      expr: price_adjustment_mechanism
      comment: "Price adjustment mechanism for inflation protection and cost volatility management"
    - name: "food_safety_certification_required"
      expr: food_safety_certification_required
      comment: "Food safety certification requirement for quality assurance and regulatory compliance"
    - name: "delivery_schedule_type"
      expr: delivery_schedule_type
      comment: "Delivery schedule type (e.g., JIT, scheduled, call-off) for supply chain planning and inventory optimization"
    - name: "contract_year"
      expr: YEAR(effective_start_date)
      comment: "Year of contract start for year-over-year contract portfolio analysis"
  measures:
    - name: "total_contract_count"
      expr: COUNT(DISTINCT purchase_contract_id)
      comment: "Total number of purchase contracts for contract portfolio size and management complexity tracking"
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total contract value for committed spend tracking and budget planning"
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value for contract size benchmarking and sourcing strategy optimization"
    - name: "total_volume_commitment"
      expr: SUM(CAST(volume_commitment_quantity AS DOUBLE))
      comment: "Total volume commitment across contracts for demand planning and supplier capacity allocation"
    - name: "avg_volume_commitment"
      expr: AVG(CAST(volume_commitment_quantity AS DOUBLE))
      comment: "Average volume commitment per contract for contract size and supplier relationship intensity"
    - name: "total_minimum_order_quantity"
      expr: SUM(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Total minimum order quantity for inventory planning and order consolidation opportunities"
    - name: "avg_rebate_percentage"
      expr: AVG(CAST(rebate_percentage AS DOUBLE))
      comment: "Average rebate percentage for volume incentive effectiveness and cost recovery potential"
    - name: "rebate_contract_count"
      expr: COUNT(CASE WHEN rebate_agreement_flag = TRUE THEN 1 END)
      comment: "Count of contracts with rebate agreements for volume incentive program coverage and savings opportunity"
    - name: "auto_renewal_contract_count"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Count of auto-renewal contracts for contract lifecycle automation and renewal risk exposure"
    - name: "exclusivity_contract_count"
      expr: COUNT(CASE WHEN exclusivity_clause_flag = TRUE THEN 1 END)
      comment: "Count of contracts with exclusivity clauses for supplier relationship commitment and sourcing flexibility risk"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time days across contracts for supply chain planning and inventory buffer sizing"
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN 1 END)
      comment: "Count of active contracts for current contract portfolio management and supplier relationship tracking"
    - name: "expired_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Expired' THEN 1 END)
      comment: "Count of expired contracts for renewal pipeline and contract lifecycle management"
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers with contracts for supplier base consolidation and relationship management"
    - name: "distinct_material_count"
      expr: COUNT(DISTINCT raw_material_id)
      comment: "Number of unique materials under contract for contract coverage and sourcing strategy scope"
$$;