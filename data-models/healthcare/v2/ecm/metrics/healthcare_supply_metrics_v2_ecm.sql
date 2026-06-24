-- Metric views for domain: supply | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 14:47:42

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement spend, contract compliance, and PO fulfillment KPIs for supply chain steering."
  source: "`vibe_healthcare_v1`.`supply`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Lifecycle status of the purchase order (open, closed, cancelled) for spend pipeline analysis."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (standard, blanket, capital) for category-level procurement analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status used to monitor procurement governance bottlenecks."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment progress of the PO used to track delivery performance."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the PO was placed for time-series spend trending."
    - name: "is_emergency_order"
      expr: is_emergency_order
      comment: "Flags rush/emergency orders, a driver of cost leakage and off-contract spend."
    - name: "is_contract_compliant"
      expr: is_contract_compliant
      comment: "Whether the PO complied with negotiated contract terms, central to savings governance."
    - name: "is_capital_expenditure"
      expr: is_capital_expenditure
      comment: "Distinguishes capital from operating procurement for budget alignment."
  measures:
    - name: "po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders, baseline procurement throughput volume."
    - name: "total_net_spend"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net procurement spend, the primary cost lever leadership manages."
    - name: "total_gross_spend"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross procurement spend before discounts and adjustments."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight cost, a controllable logistics expense for sourcing optimization."
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total negotiated discounts captured, measuring procurement savings effectiveness."
    - name: "avg_po_net_value"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average PO value, used to assess order consolidation and maverick-spend patterns."
    - name: "emergency_order_count"
      expr: COUNT(CASE WHEN is_emergency_order = TRUE THEN 1 END)
      comment: "Count of emergency orders, a leading indicator of supply disruption and premium cost."
    - name: "contract_compliant_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_contract_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of POs compliant with contract terms, a core savings-governance KPI."
    - name: "emergency_order_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_emergency_order = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of orders placed as emergencies, signaling planning and inventory health."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_purchase_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level procurement detail KPIs covering backorders, contract item adoption, and receiving fill rates."
  source: "`vibe_healthcare_v1`.`supply`.`purchase_order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the PO line used to monitor open vs received commitments."
    - name: "line_type"
      expr: line_type
      comment: "Type of line item for category-level procurement breakdown."
    - name: "item_category"
      expr: item_category
      comment: "Material category for spend-category analysis and rationalization."
    - name: "is_contract_item"
      expr: is_contract_item
      comment: "Whether the line is sourced from a contracted catalog item, central to on-contract spend."
    - name: "is_formulary_item"
      expr: is_formulary_item
      comment: "Whether the item is formulary-approved, supporting clinical standardization."
    - name: "is_recall_active"
      expr: is_recall_active
      comment: "Flags active recall on the item, a patient-safety and compliance signal."
  measures:
    - name: "line_count"
      expr: COUNT(1)
      comment: "Total number of PO lines, baseline procurement detail volume."
    - name: "total_line_extended_amount"
      expr: SUM(CAST(extended_amount AS DOUBLE))
      comment: "Total extended line value, the line-level spend driver."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across lines for demand and volume analysis."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received, used with ordered quantity to assess fill performance."
    - name: "total_backorder_quantity"
      expr: SUM(CAST(backorder_quantity AS DOUBLE))
      comment: "Total backordered quantity, a leading indicator of supply shortage risk."
    - name: "fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Received vs ordered fill rate, a key supplier service-level KPI."
    - name: "contract_item_line_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_contract_item = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of lines from contracted items, measuring on-contract spend adoption."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across lines for price benchmarking and variance detection."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Receiving and inbound quality KPIs covering discrepancies, recalls, cold-chain excursions, and three-way match."
  source: "`vibe_healthcare_v1`.`supply`.`goods_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of the goods receipt used to track receiving workflow completion."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match outcome critical to AP accuracy and invoice integrity."
    - name: "condition_on_receipt"
      expr: condition_on_receipt
      comment: "Physical condition of goods received for inbound quality monitoring."
    - name: "discrepancy_type"
      expr: discrepancy_type
      comment: "Category of receiving discrepancy used for root-cause and supplier scorecarding."
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Flags whether the receipt had a discrepancy, a core receiving quality signal."
    - name: "recall_flag"
      expr: recall_flag
      comment: "Flags receipts of recalled product, a patient-safety and compliance event."
    - name: "temperature_excursion_flag"
      expr: temperature_excursion_flag
      comment: "Flags cold-chain temperature excursions, a product-integrity risk indicator."
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month the goods were received for inbound volume and quality trending."
  measures:
    - name: "receipt_count"
      expr: COUNT(1)
      comment: "Total goods receipts, baseline inbound throughput volume."
    - name: "total_receipt_value"
      expr: SUM(CAST(total_receipt_value AS DOUBLE))
      comment: "Total value of goods received, central to inventory and AP reconciliation."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity received for inbound volume analysis."
    - name: "discrepancy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of receipts with discrepancies, the headline receiving-quality KPI."
    - name: "recall_receipt_count"
      expr: COUNT(CASE WHEN recall_flag = TRUE THEN 1 END)
      comment: "Count of recalled-product receipts requiring quarantine and patient-safety action."
    - name: "temperature_excursion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN temperature_excursion_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of receipts with cold-chain excursions, a product-integrity risk KPI."
    - name: "three_way_match_pass_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN three_way_match_status = 'matched' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of receipts passing three-way match, driving AP automation and accuracy."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor master performance and risk KPIs covering delivery reliability, fill rate, diversity, and OIG exclusion compliance."
  source: "`vibe_healthcare_v1`.`supply`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Active/inactive status of the vendor for supplier base management."
    - name: "vendor_type"
      expr: vendor_type
      comment: "Classification of vendor (distributor, manufacturer, GPO) for sourcing strategy."
    - name: "contract_tier"
      expr: contract_tier
      comment: "Negotiated contract tier used to segment strategic vs transactional suppliers."
    - name: "diversity_classification"
      expr: diversity_classification
      comment: "Supplier diversity classification supporting diversity spend targets."
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Whether the vendor is preferred, supporting sourcing consolidation strategy."
    - name: "oig_excluded_flag"
      expr: oig_excluded_flag
      comment: "Whether the vendor is OIG-excluded, a critical regulatory compliance gate."
  measures:
    - name: "vendor_count"
      expr: COUNT(1)
      comment: "Total vendors in the master, baseline supplier-base size."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average vendor on-time delivery rate, a core supplier service-level KPI."
    - name: "avg_fill_rate"
      expr: AVG(CAST(fill_rate AS DOUBLE))
      comment: "Average vendor fill rate, measuring order completeness performance."
    - name: "avg_performance_rating"
      expr: AVG(CAST(performance_rating AS DOUBLE))
      comment: "Average vendor performance rating used in supplier scorecards."
    - name: "oig_excluded_vendor_count"
      expr: COUNT(CASE WHEN oig_excluded_flag = TRUE THEN 1 END)
      comment: "Count of OIG-excluded vendors, a compliance risk requiring immediate remediation."
    - name: "preferred_vendor_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN preferred_vendor_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of vendors flagged preferred, indicating sourcing consolidation maturity."
    - name: "diversity_vendor_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN diversity_classification IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of vendors with a diversity classification, tracking diversity-spend goals."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_location_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory location audit KPIs covering count accuracy, variance value, expired/recalled item exposure, and corrective action compliance."
  source: "`vibe_healthcare_v1`.`supply`.`location_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of inventory audit (cycle count, physical, regulatory) for scope analysis."
    - name: "audit_result"
      expr: audit_result
      comment: "Outcome of the audit used to track location compliance posture."
    - name: "audit_status"
      expr: audit_status
      comment: "Workflow status of the audit for completion tracking."
    - name: "audit_pass_flag"
      expr: audit_pass_flag
      comment: "Whether the location passed the audit, the headline compliance signal."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether corrective action is required, driving remediation workload."
    - name: "controlled_substance_discrepancy_flag"
      expr: controlled_substance_discrepancy_flag
      comment: "Flags controlled-substance discrepancies, a DEA-reportable risk event."
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', audit_date)
      comment: "Month the audit occurred for compliance trend monitoring."
  measures:
    - name: "audit_count"
      expr: COUNT(1)
      comment: "Total location audits performed, baseline audit coverage volume."
    - name: "avg_accuracy_rate"
      expr: AVG(CAST(accuracy_rate AS DOUBLE))
      comment: "Average inventory count accuracy, the core inventory-integrity KPI."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average audit compliance score used in location scorecards."
    - name: "total_variance_value"
      expr: SUM(CAST(total_discrepancy_value AS DOUBLE))
      comment: "Total dollar value of discrepancies found, quantifying inventory loss exposure."
    - name: "total_expired_items_value"
      expr: SUM(CAST(expired_items_value AS DOUBLE))
      comment: "Total value of expired items found, a waste and patient-safety cost driver."
    - name: "total_recalled_items_value"
      expr: SUM(CAST(recalled_items_value AS DOUBLE))
      comment: "Total value of recalled items found at audit, a compliance and safety exposure."
    - name: "audit_pass_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN audit_pass_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of audits passed, the top-line location-compliance KPI for leadership."
    - name: "corrective_action_required_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of audits requiring corrective action, indicating remediation burden."
    - name: "controlled_substance_discrepancy_count"
      expr: COUNT(CASE WHEN controlled_substance_discrepancy_flag = TRUE THEN 1 END)
      comment: "Count of controlled-substance discrepancies, a DEA-reportable critical risk."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_material_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material catalog KPIs covering pricing variance, contract coverage, controlled/hazardous exposure, and recall status."
  source: "`vibe_healthcare_v1`.`supply`.`material_master`"
  dimensions:
    - name: "item_status"
      expr: item_status
      comment: "Active/discontinued status of the catalog item for SKU lifecycle management."
    - name: "item_category_name"
      expr: item_category_name
      comment: "Material category for spend-category and standardization analysis."
    - name: "item_type"
      expr: item_type
      comment: "Type of material (medical-surgical, pharmaceutical, capital) for portfolio analysis."
    - name: "formulary_status"
      expr: formulary_status
      comment: "Formulary approval status supporting clinical standardization."
    - name: "recall_status"
      expr: recall_status
      comment: "Current recall status of the material, a patient-safety signal."
    - name: "is_controlled_substance"
      expr: is_controlled_substance
      comment: "Whether the item is a controlled substance requiring DEA tracking."
    - name: "is_implantable"
      expr: is_implantable
      comment: "Whether the item is implantable, driving UDI and traceability requirements."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Whether the item is hazardous, driving storage and disposal compliance."
  measures:
    - name: "material_count"
      expr: COUNT(1)
      comment: "Total catalog items, baseline SKU portfolio size."
    - name: "avg_catalog_price"
      expr: AVG(CAST(catalog_price AS DOUBLE))
      comment: "Average catalog list price across items for price-benchmark context."
    - name: "avg_contract_price"
      expr: AVG(CAST(contract_price AS DOUBLE))
      comment: "Average contracted price across items, used against catalog price to gauge savings."
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average supplier lead time, a planning and stock-out risk input."
    - name: "controlled_substance_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_controlled_substance = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of catalog items that are controlled substances, sizing DEA compliance scope."
    - name: "active_recall_item_count"
      expr: COUNT(CASE WHEN recall_status = 'active' THEN 1 END)
      comment: "Count of items under active recall requiring removal from circulation."
    - name: "implantable_item_count"
      expr: COUNT(CASE WHEN is_implantable = TRUE THEN 1 END)
      comment: "Count of implantable items, the population requiring strict UDI traceability."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_inventory_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory location KPIs covering storage capacity, par management, cold-chain, and controlled-substance security coverage."
  source: "`vibe_healthcare_v1`.`supply`.`inventory_location`"
  dimensions:
    - name: "location_type"
      expr: location_type
      comment: "Type of storage location (stockroom, ADC, OR core) for network analysis."
    - name: "location_status"
      expr: location_status
      comment: "Active/inactive status of the location for footprint management."
    - name: "temperature_requirement"
      expr: temperature_requirement
      comment: "Temperature control requirement, driving cold-chain compliance scope."
    - name: "par_level_managed"
      expr: par_level_managed
      comment: "Whether par levels are managed, indicating replenishment automation maturity."
    - name: "secure_controlled_substance"
      expr: secure_controlled_substance
      comment: "Whether the location securely stores controlled substances, a DEA requirement."
    - name: "hazardous_material_storage"
      expr: hazardous_material_storage
      comment: "Whether hazardous materials are stored, driving EHS compliance scope."
  measures:
    - name: "location_count"
      expr: COUNT(1)
      comment: "Total inventory locations, baseline storage-network size."
    - name: "total_storage_capacity_cubic_ft"
      expr: SUM(CAST(storage_capacity_cubic_ft AS DOUBLE))
      comment: "Total storage capacity across locations for capacity-planning decisions."
    - name: "par_managed_location_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN par_level_managed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of locations under par management, an automation-maturity KPI."
    - name: "controlled_substance_location_count"
      expr: COUNT(CASE WHEN secure_controlled_substance = TRUE THEN 1 END)
      comment: "Count of secure controlled-substance locations, sizing DEA audit scope."
    - name: "cold_chain_location_count"
      expr: COUNT(CASE WHEN temperature_requirement IS NOT NULL THEN 1 END)
      comment: "Count of temperature-controlled locations requiring cold-chain monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_material_policy_governance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material governance KPIs covering value-analysis savings, compliance, exceptions, and overrides for VAC steering."
  source: "`vibe_healthcare_v1`.`supply`.`material_policy_governance`"
  dimensions:
    - name: "governance_category"
      expr: governance_category
      comment: "Category of governance policy applied to the material for VAC portfolio analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the material against policy, a governance posture signal."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the governance decision for workflow tracking."
    - name: "restriction_level"
      expr: restriction_level
      comment: "Restriction level applied, indicating standardization stringency."
    - name: "risk_level"
      expr: risk_level
      comment: "Assessed risk level of the material for prioritizing governance attention."
    - name: "exception_flag"
      expr: exception_flag
      comment: "Whether a policy exception was granted, a leakage and compliance signal."
    - name: "formulary_restricted_flag"
      expr: formulary_restricted_flag
      comment: "Whether the material is formulary-restricted, supporting standardization control."
  measures:
    - name: "governance_record_count"
      expr: COUNT(1)
      comment: "Total material governance records, baseline VAC coverage volume."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average policy compliance score across materials, a governance health KPI."
    - name: "avg_value_analysis_score"
      expr: AVG(CAST(value_analysis_score AS DOUBLE))
      comment: "Average value-analysis score, measuring clinical-economic review rigor."
    - name: "total_cost_comparison_savings"
      expr: SUM(CAST(cost_comparison_preferred_vs_restricted AS DOUBLE))
      comment: "Total preferred-vs-restricted cost differential, quantifying standardization savings."
    - name: "exception_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of materials with policy exceptions, a leakage-risk KPI for governance."
    - name: "corrective_action_required_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of governance records needing corrective action, indicating remediation load."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_case_cart_costs`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost and waste metrics for case carts, enabling cost management per care site and procedure."
  source: "`vibe_healthcare_v1`.`supply`.`case_cart`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "case_cart_count"
      expr: COUNT(1)
      comment: "Number of case cart records"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_purchase_order_financials`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial metrics for purchase orders to support spend analysis."
  source: "`vibe_healthcare_v1`.`supply`.`purchase_order`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site associated with the purchase order"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor supplying the goods"
    - name: "fiscal_period_id"
      expr: fiscal_period_id
      comment: "Fiscal period of the purchase order"
    - name: "order_date"
      expr: order_date
      comment: "Date the purchase order was created"
  measures:
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount of purchase orders"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of purchase orders"
    - name: "purchase_order_count"
      expr: COUNT(1)
      comment: "Number of purchase order records"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_purchase_order_line_pricing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing and quantity metrics for purchase order lines."
  source: "`vibe_healthcare_v1`.`supply`.`purchase_order_line`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site linked to the line item"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor for the line item"
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material master identifier for the item"
    - name: "line_status"
      expr: line_status
      comment: "Current status of the purchase order line"
  measures:
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across purchase order lines"
    - name: "total_line_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across lines"
    - name: "purchase_order_line_count"
      expr: COUNT(1)
      comment: "Number of purchase order line records"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_recall_incidents`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recall incident metrics to monitor product safety and compliance."
  source: "`vibe_healthcare_v1`.`supply`.`recall_notice`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "total_recalls"
      expr: COUNT(1)
      comment: "Total number of recall notices"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_surgical_bom_costs`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost estimation metrics for surgical bill of materials."
  source: "`vibe_healthcare_v1`.`supply`.`surgical_bom`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "bom_count"
      expr: COUNT(1)
      comment: "Number of surgical BOM records"
$$;