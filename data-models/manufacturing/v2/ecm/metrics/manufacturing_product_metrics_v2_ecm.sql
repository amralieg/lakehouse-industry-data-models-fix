-- Metric views for domain: product | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 08:28:29

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_sku_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the SKU master catalog — tracks portfolio composition, cost structure, lifecycle health, and compliance posture across all active products."
  source: "`vibe_manufacturing_v1`.`product`.`sku_master`"
  dimensions:
    - name: "product_type"
      expr: product_type
      comment: "Classifies SKUs by product type (finished good, raw material, semi-finished, etc.) for portfolio segmentation."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle phase of the SKU (active, phase-out, obsolete) — critical for portfolio health monitoring."
    - name: "make_or_buy_code"
      expr: make_or_buy_code
      comment: "Indicates whether the SKU is manufactured in-house or sourced externally — drives sourcing strategy analysis."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC inventory classification (A=high value, B=medium, C=low) for prioritization and resource allocation."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the product is manufactured — relevant for trade compliance and tariff analysis."
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Flags SKUs classified as hazardous materials, driving compliance and logistics decisions."
    - name: "lot_control_required"
      expr: lot_control_required
      comment: "Indicates whether lot/batch traceability is required for this SKU — impacts quality and regulatory compliance."
    - name: "serial_control_required"
      expr: serial_control_required
      comment: "Indicates whether serialized unit tracking is required — relevant for high-value or regulated products."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the SKU was introduced into the catalog — used for new product introduction trend analysis."
  measures:
    - name: "total_active_skus"
      expr: COUNT(CASE WHEN lifecycle_status = 'active' THEN 1 END)
      comment: "Count of SKUs currently in active lifecycle status — baseline measure of the active product portfolio size."
    - name: "total_skus"
      expr: COUNT(1)
      comment: "Total number of SKUs in the master catalog — measures overall portfolio breadth."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Sum of standard costs across all SKUs — used to assess total portfolio cost exposure and cost structure."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per SKU — benchmarks cost levels across product types and families."
    - name: "total_gross_weight"
      expr: SUM(CAST(gross_weight AS DOUBLE))
      comment: "Aggregate gross weight across SKUs — informs logistics capacity planning and freight cost estimation."
    - name: "avg_net_weight"
      expr: AVG(CAST(net_weight AS DOUBLE))
      comment: "Average net weight per SKU — used in packaging design and shipping cost benchmarking."
    - name: "hazmat_sku_count"
      expr: COUNT(CASE WHEN hazmat_indicator = TRUE THEN 1 END)
      comment: "Number of SKUs classified as hazardous materials — drives compliance program scope and logistics risk assessment."
    - name: "phase_out_sku_count"
      expr: COUNT(CASE WHEN lifecycle_status IN ('phase-out', 'phaseout', 'end-of-life') THEN 1 END)
      comment: "Count of SKUs in phase-out or end-of-life status — signals portfolio rationalization opportunities and supply chain wind-down needs."
    - name: "make_sku_count"
      expr: COUNT(CASE WHEN make_or_buy_code = 'make' THEN 1 END)
      comment: "Number of SKUs manufactured in-house — informs capacity planning and vertical integration strategy."
    - name: "buy_sku_count"
      expr: COUNT(CASE WHEN make_or_buy_code = 'buy' THEN 1 END)
      comment: "Number of SKUs sourced externally — informs supplier dependency and procurement strategy."
    - name: "lot_controlled_sku_count"
      expr: COUNT(CASE WHEN lot_control_required = TRUE THEN 1 END)
      comment: "Count of SKUs requiring lot/batch traceability — scopes quality and regulatory compliance program effort."
    - name: "serialized_sku_count"
      expr: COUNT(CASE WHEN serial_control_required = TRUE THEN 1 END)
      comment: "Count of SKUs requiring serialized tracking — relevant for warranty, field service, and regulatory reporting."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and fulfillment KPIs at the order line level — tracks order value, discount impact, delivery performance, and backorder exposure across the product portfolio."
  source: "`vibe_manufacturing_v1`.`product`.`order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the order line (open, confirmed, shipped, cancelled) — used to filter and segment fulfillment performance."
    - name: "line_type"
      expr: line_type
      comment: "Type of order line (standard, return, service, etc.) — enables analysis by transaction type."
    - name: "item_category_code"
      expr: item_category_code
      comment: "SAP/ERP item category code classifying the line item — used for revenue and margin segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for the order line — required for multi-currency revenue analysis."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery fulfillment status of the line — tracks on-time delivery and open order exposure."
    - name: "backorder_flag"
      expr: backorder_flag
      comment: "Indicates whether the line is in backorder status — critical for customer service and supply chain escalation."
    - name: "is_cancelled"
      expr: is_cancelled
      comment: "Flags cancelled order lines — used to measure cancellation rates and revenue leakage."
    - name: "requested_delivery_date"
      expr: DATE_TRUNC('month', requested_delivery_date)
      comment: "Month of the customer-requested delivery date — used for demand timing and fulfillment trend analysis."
    - name: "confirmed_delivery_date"
      expr: DATE_TRUNC('month', confirmed_delivery_date)
      comment: "Month of the confirmed delivery date — used to track committed delivery schedules."
  measures:
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net revenue across all order lines — primary revenue KPI for the product domain."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross order value before discounts — used to measure gross revenue and discount impact."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across order lines — required for tax reporting and compliance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value granted across order lines — measures pricing concession exposure and margin erosion."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage across order lines — benchmarks pricing discipline and discount policy adherence."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total units ordered across all lines — measures demand volume for capacity and supply planning."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total units shipped — measures actual fulfillment output against demand."
    - name: "total_open_quantity"
      expr: SUM(CAST(open_quantity AS DOUBLE))
      comment: "Total unfulfilled quantity across open order lines — measures backlog and supply chain exposure."
    - name: "total_backorder_quantity"
      expr: SUM(CAST(backorder_quantity AS DOUBLE))
      comment: "Total quantity in backorder status — critical KPI for customer service and supply chain escalation."
    - name: "avg_unit_net_price"
      expr: AVG(CAST(unit_net_price AS DOUBLE))
      comment: "Average net selling price per unit — used to track price realization and pricing strategy effectiveness."
    - name: "cancelled_line_count"
      expr: COUNT(CASE WHEN is_cancelled = TRUE THEN 1 END)
      comment: "Number of cancelled order lines — measures order cancellation rate and associated revenue risk."
    - name: "backorder_line_count"
      expr: COUNT(CASE WHEN backorder_flag = TRUE THEN 1 END)
      comment: "Number of order lines in backorder — tracks supply shortfall impact on customer commitments."
    - name: "total_line_count"
      expr: COUNT(1)
      comment: "Total number of order lines — baseline volume measure for order activity analysis."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_revision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering change and revision management KPIs — tracks revision velocity, approval cycle times, regulatory impact, and change effectivity across the product portfolio."
  source: "`vibe_manufacturing_v1`.`product`.`product_revision`"
  dimensions:
    - name: "revision_status"
      expr: revision_status
      comment: "Current status of the product revision (draft, approved, released, obsolete) — used to track revision pipeline health."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the revision — measures engineering change governance compliance."
    - name: "change_reason_code"
      expr: change_reason_code
      comment: "Reason code driving the revision (quality, regulatory, cost, customer request) — enables root cause analysis of change volume."
    - name: "change_impact_level"
      expr: change_impact_level
      comment: "Assessed impact level of the revision (minor, major, critical) — used to prioritize change management resources."
    - name: "effectivity_type"
      expr: effectivity_type
      comment: "How the revision becomes effective (date-based, serial-based) — informs production scheduling and inventory management."
    - name: "bom_affected_flag"
      expr: bom_affected_flag
      comment: "Indicates whether the revision impacts the bill of materials — triggers BOM update workflows."
    - name: "regulatory_approval_required_flag"
      expr: regulatory_approval_required_flag
      comment: "Flags revisions requiring regulatory body approval — scopes compliance program workload."
    - name: "ppap_required_flag"
      expr: ppap_required_flag
      comment: "Indicates whether PPAP re-submission is required — critical for automotive and regulated industry customers."
    - name: "release_month"
      expr: DATE_TRUNC('month', release_date)
      comment: "Month the revision was released — used for engineering change velocity trending."
  measures:
    - name: "total_revisions"
      expr: COUNT(1)
      comment: "Total number of product revisions — baseline measure of engineering change activity volume."
    - name: "approved_revision_count"
      expr: COUNT(CASE WHEN approval_status = 'approved' THEN 1 END)
      comment: "Number of revisions that have received formal approval — measures change governance throughput."
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN approval_status IN ('pending', 'in-review', 'submitted') THEN 1 END)
      comment: "Number of revisions awaiting approval — measures engineering change backlog and governance bottleneck."
    - name: "regulatory_impact_revision_count"
      expr: COUNT(CASE WHEN regulatory_approval_required_flag = TRUE THEN 1 END)
      comment: "Count of revisions requiring regulatory approval — scopes compliance workload and risk exposure."
    - name: "bom_impacting_revision_count"
      expr: COUNT(CASE WHEN bom_affected_flag = TRUE THEN 1 END)
      comment: "Number of revisions that impact the BOM — drives BOM maintenance workload and production change management."
    - name: "ppap_required_revision_count"
      expr: COUNT(CASE WHEN ppap_required_flag = TRUE THEN 1 END)
      comment: "Count of revisions requiring PPAP re-submission — measures customer-facing quality compliance burden."
    - name: "drawing_impacting_revision_count"
      expr: COUNT(CASE WHEN drawing_affected_flag = TRUE THEN 1 END)
      comment: "Number of revisions affecting engineering drawings — scopes documentation update workload."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_change_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineering change order (ECO/ECN) management KPIs — tracks change order cycle times, approval status, cost impact, regulatory burden, and implementation progress."
  source: "`vibe_manufacturing_v1`.`product`.`change_order`"
  dimensions:
    - name: "change_status"
      expr: change_status
      comment: "Current status of the change order (open, approved, implemented, closed) — primary dimension for change pipeline analysis."
    - name: "change_type"
      expr: change_type
      comment: "Type of engineering change (design, process, material, regulatory) — enables change category analysis."
    - name: "change_reason_code"
      expr: change_reason_code
      comment: "Root cause code for the change — used to identify systemic quality or design issues driving change volume."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status — measures governance compliance and approval cycle efficiency."
    - name: "priority"
      expr: priority
      comment: "Priority level of the change order (critical, high, medium, low) — used to triage and resource change management."
    - name: "regulatory_impact_flag"
      expr: regulatory_impact_flag
      comment: "Flags change orders with regulatory compliance implications — scopes compliance review workload."
    - name: "urgency_flag"
      expr: urgency_flag
      comment: "Indicates urgent change orders requiring expedited processing — used for escalation management."
    - name: "implementation_status"
      expr: implementation_status
      comment: "Status of change implementation (not started, in progress, complete) — tracks execution progress."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the change order was created — used for change volume trending and workload forecasting."
  measures:
    - name: "total_change_orders"
      expr: COUNT(1)
      comment: "Total number of change orders — baseline measure of engineering change activity and organizational change burden."
    - name: "open_change_order_count"
      expr: COUNT(CASE WHEN change_status IN ('open', 'in-progress', 'pending') THEN 1 END)
      comment: "Number of open change orders — measures current change management backlog and resource demand."
    - name: "total_impact_assessment_cost"
      expr: SUM(CAST(impact_assessment_cost AS DOUBLE))
      comment: "Total assessed cost impact of all change orders — measures financial exposure from engineering changes."
    - name: "avg_impact_assessment_cost"
      expr: AVG(CAST(impact_assessment_cost AS DOUBLE))
      comment: "Average cost impact per change order — benchmarks change complexity and cost efficiency of the change process."
    - name: "regulatory_change_order_count"
      expr: COUNT(CASE WHEN regulatory_impact_flag = TRUE THEN 1 END)
      comment: "Number of change orders with regulatory impact — scopes compliance review workload and regulatory risk."
    - name: "urgent_change_order_count"
      expr: COUNT(CASE WHEN urgency_flag = TRUE THEN 1 END)
      comment: "Count of urgent change orders — measures reactive change pressure and potential quality/safety escalations."
    - name: "customer_notification_required_count"
      expr: COUNT(CASE WHEN customer_notification_required = TRUE THEN 1 END)
      comment: "Number of change orders requiring customer notification — measures customer-facing change communication workload."
    - name: "validation_required_count"
      expr: COUNT(CASE WHEN validation_required = TRUE THEN 1 END)
      comment: "Count of change orders requiring formal validation — scopes testing and qualification workload."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product certification portfolio KPIs — tracks certification coverage, expiry risk, compliance posture, and regulatory market access across the product portfolio."
  source: "`vibe_manufacturing_v1`.`product`.`product_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the product certification (active, expired, pending, revoked) — primary dimension for compliance posture analysis."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (safety, environmental, quality, regulatory) — enables compliance program segmentation."
    - name: "certifying_body"
      expr: certifying_body
      comment: "Organization that issued the certification (UL, CE, ISO, etc.) — used to track certification authority relationships."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance flag — critical for EU market access and environmental compliance reporting."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH compliance flag — required for chemical substance compliance in EU markets."
    - name: "weee_compliant"
      expr: weee_compliant
      comment: "WEEE compliance flag — required for electrical/electronic equipment waste compliance in EU."
    - name: "is_customer_facing"
      expr: is_customer_facing
      comment: "Indicates whether the certification is visible/required by customers — used to prioritize renewal efforts."
    - name: "expiry_month"
      expr: DATE_TRUNC('month', expiry_date)
      comment: "Month the certification expires — used for renewal pipeline planning and compliance risk forecasting."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of product certifications — measures overall certification portfolio breadth."
    - name: "active_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'active' THEN 1 END)
      comment: "Number of currently active certifications — measures current compliance coverage across the product portfolio."
    - name: "expired_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'expired' THEN 1 END)
      comment: "Number of expired certifications — measures compliance gap and market access risk."
    - name: "expiring_within_90_days_count"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Certifications expiring within 90 days — critical leading indicator for compliance renewal workload and market access risk."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost invested in product certifications — measures compliance program investment and budget planning."
    - name: "avg_certification_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per certification — benchmarks certification investment efficiency across certification types."
    - name: "rohs_compliant_count"
      expr: COUNT(CASE WHEN rohs_compliant = TRUE THEN 1 END)
      comment: "Number of certifications confirming RoHS compliance — measures EU environmental compliance coverage."
    - name: "customer_facing_certification_count"
      expr: COUNT(CASE WHEN is_customer_facing = TRUE THEN 1 END)
      comment: "Count of customer-facing certifications — measures the compliance credentials visible to customers and required for sales."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_bom_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of Materials (BOM) portfolio KPIs — tracks BOM coverage, configurability, compliance posture, and engineering change activity across the product portfolio."
  source: "`vibe_manufacturing_v1`.`product`.`bom_header`"
  dimensions:
    - name: "bom_status"
      expr: bom_status
      comment: "Current status of the BOM (active, inactive, under-review) — used to assess BOM portfolio health."
    - name: "bom_type"
      expr: bom_type
      comment: "Type of BOM (production, engineering, sales, costing) — enables analysis by BOM usage context."
    - name: "bom_usage"
      expr: bom_usage
      comment: "Intended usage of the BOM (production, costing, engineering) — used to segment BOM portfolio by business function."
    - name: "is_configurable"
      expr: is_configurable
      comment: "Indicates whether the BOM supports product configuration — relevant for configure-to-order business models."
    - name: "is_phantom"
      expr: is_phantom
      comment: "Flags phantom BOMs (assembly nodes that are not physically stocked) — impacts production planning logic."
    - name: "is_critical"
      expr: is_critical
      comment: "Flags BOMs for critical products — used to prioritize BOM maintenance and change management resources."
    - name: "environmental_compliance_flag"
      expr: environmental_compliance_flag
      comment: "Indicates whether the BOM has been reviewed for environmental compliance — tracks regulatory coverage."
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the BOM became effective — used for BOM introduction and change velocity trending."
  measures:
    - name: "total_boms"
      expr: COUNT(1)
      comment: "Total number of BOM headers — measures overall BOM portfolio size and maintenance scope."
    - name: "active_bom_count"
      expr: COUNT(CASE WHEN bom_status = 'active' THEN 1 END)
      comment: "Number of active BOMs — measures the current production-ready BOM portfolio."
    - name: "configurable_bom_count"
      expr: COUNT(CASE WHEN is_configurable = TRUE THEN 1 END)
      comment: "Number of configurable BOMs — measures configure-to-order product portfolio breadth."
    - name: "critical_bom_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of BOMs flagged as critical — scopes high-priority BOM maintenance and change management workload."
    - name: "avg_base_quantity"
      expr: AVG(CAST(base_quantity AS DOUBLE))
      comment: "Average base quantity per BOM — used to understand standard production batch sizing across the portfolio."
    - name: "avg_lot_size"
      expr: AVG(CAST(lot_size AS DOUBLE))
      comment: "Average lot size across BOMs — informs production planning and inventory sizing decisions."
    - name: "environmentally_compliant_bom_count"
      expr: COUNT(CASE WHEN environmental_compliance_flag = TRUE THEN 1 END)
      comment: "Number of BOMs with confirmed environmental compliance — measures regulatory coverage of the production BOM portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_supply_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply agreement portfolio KPIs — tracks contracted supply coverage, pricing commitments, volume obligations, and agreement lifecycle health across the supplier base."
  source: "`vibe_manufacturing_v1`.`product`.`supply_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the supply agreement (active, expired, pending, terminated) — primary dimension for supply coverage analysis."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of supply agreement (blanket, spot, consignment, long-term) — enables sourcing strategy segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the supply agreement — required for multi-currency spend and commitment analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms governing the supply agreement — impacts landed cost and logistics responsibility analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms of the agreement — used for cash flow and working capital analysis."
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Indicates whether the agreement auto-renews — used to identify agreements requiring proactive renegotiation."
    - name: "agreement_start_month"
      expr: DATE_TRUNC('month', agreement_start_date)
      comment: "Month the supply agreement became effective — used for agreement portfolio vintage analysis."
    - name: "agreement_end_month"
      expr: DATE_TRUNC('month', agreement_end_date)
      comment: "Month the supply agreement expires — used for renewal pipeline planning and supply continuity risk management."
  measures:
    - name: "total_supply_agreements"
      expr: COUNT(1)
      comment: "Total number of supply agreements — measures contracted supply coverage breadth."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'active' THEN 1 END)
      comment: "Number of currently active supply agreements — measures current contracted supply coverage."
    - name: "expiring_within_90_days_count"
      expr: COUNT(CASE WHEN agreement_end_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Supply agreements expiring within 90 days — critical leading indicator for supply continuity risk and renegotiation workload."
    - name: "total_agreed_price"
      expr: SUM(CAST(agreed_price_amount AS DOUBLE))
      comment: "Total contracted price value across all supply agreements — measures total supply cost commitment."
    - name: "avg_agreed_price"
      expr: AVG(CAST(agreed_price_amount AS DOUBLE))
      comment: "Average contracted unit price across supply agreements — benchmarks pricing competitiveness and negotiation outcomes."
    - name: "total_annual_volume_commitment"
      expr: SUM(CAST(annual_volume_commitment AS DOUBLE))
      comment: "Total annual volume committed across all supply agreements — measures supply capacity secured and take-or-pay obligations."
    - name: "total_committed_volume"
      expr: SUM(CAST(committed_volume AS DOUBLE))
      comment: "Total committed purchase volume across agreements — measures contractual purchase obligations and supply chain dependency."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across supply agreements — informs inventory and procurement planning constraints."
    - name: "auto_renew_agreement_count"
      expr: COUNT(CASE WHEN auto_renew_flag = TRUE THEN 1 END)
      comment: "Number of agreements set to auto-renew — identifies agreements requiring proactive review before automatic commitment."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_lifecycle_stage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product lifecycle management KPIs — tracks portfolio lifecycle distribution, end-of-life planning, customer notification compliance, and service support continuity."
  source: "`vibe_manufacturing_v1`.`product`.`lifecycle_stage`"
  dimensions:
    - name: "lifecycle_stage_code"
      expr: lifecycle_stage_code
      comment: "Current lifecycle stage code (introduction, growth, maturity, decline, end-of-life) — primary dimension for portfolio lifecycle analysis."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the lifecycle stage record is currently active — used to filter current vs. historical lifecycle data."
    - name: "market_demand_trend"
      expr: market_demand_trend
      comment: "Assessed market demand trend (growing, stable, declining) — informs portfolio investment and rationalization decisions."
    - name: "stage_entry_month"
      expr: DATE_TRUNC('month', stage_entry_date)
      comment: "Month the product entered the current lifecycle stage — used for stage duration and transition velocity analysis."
    - name: "planned_eol_month"
      expr: DATE_TRUNC('month', planned_eol_date)
      comment: "Month the product is planned for end-of-life — used for EOL pipeline planning and customer communication scheduling."
  measures:
    - name: "total_lifecycle_records"
      expr: COUNT(1)
      comment: "Total number of lifecycle stage records — baseline measure of products tracked in lifecycle management."
    - name: "active_lifecycle_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active lifecycle stage records — measures the active managed product portfolio."
    - name: "eol_within_12_months_count"
      expr: COUNT(CASE WHEN planned_eol_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 365) THEN 1 END)
      comment: "Products reaching planned end-of-life within 12 months — critical for customer communication, inventory wind-down, and service continuity planning."
    - name: "customer_notified_count"
      expr: COUNT(CASE WHEN customer_notification_date IS NOT NULL THEN 1 END)
      comment: "Number of lifecycle events where customer notification has been issued — measures EOL communication compliance."
    - name: "last_time_buy_within_90_days_count"
      expr: COUNT(CASE WHEN last_time_buy_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Products with last-time-buy dates within 90 days — critical for procurement and inventory teams to place final orders."
    - name: "service_support_ending_within_12_months_count"
      expr: COUNT(CASE WHEN service_support_end_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 365) THEN 1 END)
      comment: "Products losing service support within 12 months — measures field service and spare parts continuity risk."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_bom_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "BOM component-level KPIs — tracks component usage, scrap rates, critical component exposure, and BOM complexity across the product portfolio."
  source: "`vibe_manufacturing_v1`.`product`.`product_bom_line`"
  dimensions:
    - name: "item_category"
      expr: item_category
      comment: "Category of the BOM line item (raw material, sub-assembly, purchased part) — used for component portfolio segmentation."
    - name: "product_bom_line_status"
      expr: product_bom_line_status
      comment: "Current status of the BOM line (active, inactive, obsolete) — used to filter active vs. historical BOM structures."
    - name: "critical_component_flag"
      expr: critical_component_flag
      comment: "Flags BOM lines for critical components — used to prioritize supply chain risk management and dual-sourcing decisions."
    - name: "bulk_material_indicator"
      expr: bulk_material_indicator
      comment: "Indicates bulk materials not individually tracked in BOM explosions — impacts costing and inventory accuracy."
    - name: "backflush_indicator"
      expr: backflush_indicator
      comment: "Indicates components consumed via backflushing — impacts production reporting and inventory accuracy."
    - name: "spare_part_indicator"
      expr: spare_part_indicator
      comment: "Flags components also sold as spare parts — used to align service parts planning with production BOM."
    - name: "component_origin"
      expr: component_origin
      comment: "Origin of the component (domestic, imported, in-house) — used for supply chain risk and trade compliance analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the BOM line became effective — used for component introduction and change velocity analysis."
  measures:
    - name: "total_bom_lines"
      expr: COUNT(1)
      comment: "Total number of BOM lines — measures overall BOM complexity and component portfolio breadth."
    - name: "critical_component_line_count"
      expr: COUNT(CASE WHEN critical_component_flag = TRUE THEN 1 END)
      comment: "Number of BOM lines for critical components — measures supply chain risk exposure from single-source or long-lead components."
    - name: "total_quantity_per_assembly"
      expr: SUM(CAST(quantity_per_assembly AS DOUBLE))
      comment: "Total component quantity consumed per assembly across all BOM lines — used for material requirements planning."
    - name: "avg_scrap_factor_percent"
      expr: AVG(CAST(scrap_factor_percent AS DOUBLE))
      comment: "Average scrap factor percentage across BOM lines — measures material waste in production and drives cost reduction initiatives."
    - name: "total_component_weight_kg"
      expr: SUM(CAST(component_weight_kg AS DOUBLE))
      comment: "Total component weight across BOM lines — used for product weight analysis, packaging design, and logistics planning."
    - name: "avg_component_weight_kg"
      expr: AVG(CAST(component_weight_kg AS DOUBLE))
      comment: "Average component weight per BOM line — benchmarks component sizing and informs design-for-manufacturability decisions."
    - name: "spare_part_component_count"
      expr: COUNT(CASE WHEN spare_part_indicator = TRUE THEN 1 END)
      comment: "Number of BOM components also designated as spare parts — aligns service parts catalog with production BOM."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_plant_data`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plant-level material master KPIs — tracks procurement strategy, inventory policy, production planning parameters, and quality inspection requirements across plants."
  source: "`vibe_manufacturing_v1`.`product`.`plant_data`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Plant identifier — primary dimension for plant-level material planning and inventory analysis."
    - name: "plant_status"
      expr: plant_status
      comment: "Status of the material at the plant (active, blocked, discontinued) — used to filter active plant-material combinations."
    - name: "mrp_type"
      expr: mrp_type
      comment: "MRP planning type (MRP, reorder point, consumption-based) — used to segment materials by planning strategy."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type (in-house production, external procurement, both) — drives make-vs-buy analysis at plant level."
    - name: "batch_management_required"
      expr: batch_management_required
      comment: "Indicates whether batch management is required at this plant — impacts quality and traceability program scope."
    - name: "inspection_setup_required"
      expr: inspection_setup_required
      comment: "Flags materials requiring quality inspection setup at this plant — scopes quality control workload."
    - name: "backflush_indicator"
      expr: backflush_indicator
      comment: "Indicates backflushing is used for this material at this plant — impacts production reporting accuracy."
    - name: "abc_indicator"
      expr: abc_indicator
      comment: "ABC classification indicator at plant level — used for inventory prioritization and cycle counting frequency."
  measures:
    - name: "total_plant_material_records"
      expr: COUNT(1)
      comment: "Total number of plant-material master records — measures the scope of materials managed across plants."
    - name: "avg_safety_stock_quantity"
      expr: AVG(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Average safety stock quantity across plant-material records — benchmarks inventory buffer policy and working capital investment."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity across all plant-material records — measures total inventory buffer investment."
    - name: "avg_reorder_point"
      expr: AVG(CAST(reorder_point AS DOUBLE))
      comment: "Average reorder point quantity — benchmarks replenishment trigger levels and inventory policy consistency."
    - name: "avg_minimum_lot_size"
      expr: AVG(CAST(minimum_lot_size AS DOUBLE))
      comment: "Average minimum lot size across plant-material records — informs production scheduling and procurement order sizing."
    - name: "avg_maximum_lot_size"
      expr: AVG(CAST(maximum_lot_size AS DOUBLE))
      comment: "Average maximum lot size — used to assess production batch size constraints and inventory peak exposure."
    - name: "inspection_required_count"
      expr: COUNT(CASE WHEN inspection_setup_required = TRUE THEN 1 END)
      comment: "Number of plant-material records requiring quality inspection — scopes quality control resource requirements."
    - name: "avg_shelf_life_expiration_days"
      expr: AVG(CAST(shelf_life_expiration_days AS DOUBLE))
      comment: "Average shelf life in days across plant-material records — used to manage perishable inventory and FEFO planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_bundle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing, weight, and volume KPIs for product bundles"
  source: "`vibe_manufacturing_v1`.`product`.`bundle`"
  dimensions:
    - name: "bundle_status"
      expr: bundle_status
      comment: "Current status of the bundle"
    - name: "bundle_type"
      expr: bundle_type
      comment: "Classification of the bundle (e.g., standard, custom)"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the bundle is manufactured"
    - name: "availability_month"
      expr: DATE_TRUNC('month', availability_start_date)
      comment: "Month when the bundle became available"
  measures:
    - name: "total_list_price"
      expr: SUM(CAST(list_price AS DOUBLE))
      comment: "Total list price of all bundles"
    - name: "avg_list_price"
      expr: AVG(CAST(list_price AS DOUBLE))
      comment: "Average list price per bundle"
    - name: "total_weight"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight (kg) of all bundles"
    - name: "avg_weight"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average weight (kg) per bundle"
    - name: "total_volume"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total volume (m³) of all bundles"
    - name: "avg_volume"
      expr: AVG(CAST(volume_m3 AS DOUBLE))
      comment: "Average volume (m³) per bundle"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied to bundles"
$$;