-- Metric views for domain: supply | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 15:25:46

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order performance and spend metrics for procurement analysis"
  source: "`genomics_biotech_ecm`.`supply`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order (open, closed, approved, etc.)"
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (standard, blanket, contract, etc.)"
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization responsible for the order"
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Purchasing group handling the order"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for order value"
    - name: "gmp_relevant_flag"
      expr: gmp_relevant_flag
      comment: "Indicates if order is GMP-relevant for regulatory compliance"
    - name: "quality_inspection_required_flag"
      expr: quality_inspection_required_flag
      comment: "Indicates if quality inspection is required upon receipt"
    - name: "po_year"
      expr: YEAR(po_date)
      comment: "Year the purchase order was created"
    - name: "po_month"
      expr: DATE_TRUNC('MONTH', po_date)
      comment: "Month the purchase order was created"
    - name: "delivery_year"
      expr: YEAR(delivery_date)
      comment: "Year of expected delivery"
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month of expected delivery"
  measures:
    - name: "total_po_count"
      expr: COUNT(DISTINCT purchase_order_id)
      comment: "Total number of unique purchase orders"
    - name: "total_po_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total value of all purchase orders"
    - name: "total_net_value"
      expr: SUM(CAST(net_value AS DOUBLE))
      comment: "Total net value of purchase orders before tax"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all purchase orders"
    - name: "avg_po_value"
      expr: AVG(CAST(total_value AS DOUBLE))
      comment: "Average purchase order value"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all purchase orders"
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed by suppliers"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received to date"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across purchase orders"
    - name: "po_fulfillment_rate"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that has been received"
    - name: "po_confirmation_rate"
      expr: ROUND(100.0 * SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity confirmed by suppliers"
    - name: "gmp_po_count"
      expr: COUNT(DISTINCT CASE WHEN gmp_relevant_flag = TRUE THEN purchase_order_id END)
      comment: "Count of GMP-relevant purchase orders for regulatory tracking"
    - name: "quality_inspection_po_count"
      expr: COUNT(DISTINCT CASE WHEN quality_inspection_required_flag = TRUE THEN purchase_order_id END)
      comment: "Count of purchase orders requiring quality inspection"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`supply_inventory_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory stock levels, valuation, and utilization metrics for supply chain optimization"
  source: "`genomics_biotech_ecm`.`supply`.`inventory_stock`"
  dimensions:
    - name: "stock_status"
      expr: stock_status
      comment: "Current status of the inventory stock"
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock (unrestricted, blocked, quality inspection, etc.)"
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation type for inventory accounting"
    - name: "abc_indicator"
      expr: abc_indicator
      comment: "ABC classification for inventory prioritization (A=high value, B=medium, C=low)"
    - name: "gmp_controlled_flag"
      expr: gmp_controlled_flag
      comment: "Indicates if inventory is GMP-controlled for regulatory compliance"
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates if inventory contains hazardous materials"
    - name: "serialized_flag"
      expr: serialized_flag
      comment: "Indicates if inventory is serialized for traceability"
    - name: "cold_chain_storage_zone"
      expr: cold_chain_storage_zone
      comment: "Cold chain storage zone for temperature-sensitive materials"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for stock valuation"
    - name: "snapshot_year"
      expr: YEAR(snapshot_timestamp)
      comment: "Year of inventory snapshot"
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_timestamp)
      comment: "Month of inventory snapshot"
  measures:
    - name: "total_unrestricted_stock"
      expr: SUM(CAST(unrestricted_stock_quantity AS DOUBLE))
      comment: "Total unrestricted stock quantity available for use"
    - name: "total_blocked_stock"
      expr: SUM(CAST(blocked_stock_quantity AS DOUBLE))
      comment: "Total blocked stock quantity not available for use"
    - name: "total_quality_inspection_stock"
      expr: SUM(CAST(quality_inspection_stock_quantity AS DOUBLE))
      comment: "Total stock quantity in quality inspection"
    - name: "total_reserved_stock"
      expr: SUM(CAST(reserved_stock_quantity AS DOUBLE))
      comment: "Total stock quantity reserved for specific orders or projects"
    - name: "total_in_transit_stock"
      expr: SUM(CAST(in_transit_stock_quantity AS DOUBLE))
      comment: "Total stock quantity in transit between locations"
    - name: "total_available_stock"
      expr: SUM(CAST(available_stock_quantity AS DOUBLE))
      comment: "Total available stock quantity for immediate use"
    - name: "total_consignment_stock"
      expr: SUM(CAST(consignment_stock_quantity AS DOUBLE))
      comment: "Total consignment stock held on behalf of suppliers"
    - name: "total_stock_value"
      expr: SUM(CAST(stock_value_amount AS DOUBLE))
      comment: "Total monetary value of inventory stock"
    - name: "avg_valuation_price_per_unit"
      expr: AVG(CAST(valuation_price_per_unit AS DOUBLE))
      comment: "Average valuation price per unit across inventory"
    - name: "total_safety_stock"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity maintained as buffer"
    - name: "total_maximum_stock"
      expr: SUM(CAST(maximum_stock_quantity AS DOUBLE))
      comment: "Total maximum stock quantity threshold"
    - name: "inventory_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(available_stock_quantity AS DOUBLE)) / NULLIF(SUM(CAST(maximum_stock_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of maximum stock capacity currently utilized"
    - name: "stock_availability_rate"
      expr: ROUND(100.0 * SUM(CAST(unrestricted_stock_quantity AS DOUBLE)) / NULLIF(SUM(CAST(unrestricted_stock_quantity AS DOUBLE)) + SUM(CAST(blocked_stock_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of stock that is unrestricted and available"
    - name: "unique_material_count"
      expr: COUNT(DISTINCT material_id)
      comment: "Number of unique materials in inventory"
    - name: "unique_batch_count"
      expr: COUNT(DISTINCT batch_id)
      comment: "Number of unique batches in inventory"
    - name: "gmp_controlled_stock_value"
      expr: SUM(CASE WHEN gmp_controlled_flag = TRUE THEN CAST(stock_value_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of GMP-controlled inventory for regulatory compliance tracking"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`supply_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier performance, compliance, and risk metrics for vendor management"
  source: "`genomics_biotech_ecm`.`supply`.`supplier`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the supplier"
    - name: "supplier_type"
      expr: supplier_type
      comment: "Type of supplier (manufacturer, distributor, service provider, etc.)"
    - name: "classification"
      expr: classification
      comment: "Supplier classification category"
    - name: "quality_rating"
      expr: quality_rating
      comment: "Quality rating assigned to the supplier"
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier classification (high, medium, low)"
    - name: "gmp_certified"
      expr: gmp_certified
      comment: "Indicates if supplier is GMP certified"
    - name: "iso_13485_certified"
      expr: iso_13485_certified
      comment: "Indicates if supplier is ISO 13485 certified for medical devices"
    - name: "iso_9001_certified"
      expr: iso_9001_certified
      comment: "Indicates if supplier is ISO 9001 certified for quality management"
    - name: "cold_chain_capable"
      expr: cold_chain_capable
      comment: "Indicates if supplier has cold chain capabilities"
    - name: "single_source_flag"
      expr: single_source_flag
      comment: "Indicates if supplier is a single source (no alternatives)"
    - name: "blocked_for_purchasing"
      expr: blocked_for_purchasing
      comment: "Indicates if supplier is blocked from new purchases"
    - name: "headquarters_country_code"
      expr: headquarters_country_code
      comment: "Country code of supplier headquarters"
    - name: "diversity_classification"
      expr: diversity_classification
      comment: "Diversity classification for supplier diversity programs"
    - name: "approved_year"
      expr: YEAR(approved_date)
      comment: "Year the supplier was approved"
    - name: "last_audit_year"
      expr: YEAR(last_audit_date)
      comment: "Year of last supplier audit"
  measures:
    - name: "total_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Total number of unique suppliers"
    - name: "active_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN lifecycle_status = 'Active' THEN supplier_id END)
      comment: "Number of active suppliers"
    - name: "avg_on_time_delivery_pct"
      expr: AVG(CAST(on_time_delivery_percentage AS DOUBLE))
      comment: "Average on-time delivery percentage across suppliers"
    - name: "avg_minimum_order_value"
      expr: AVG(CAST(minimum_order_value AS DOUBLE))
      comment: "Average minimum order value across suppliers"
    - name: "gmp_certified_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN gmp_certified = TRUE THEN supplier_id END)
      comment: "Number of GMP-certified suppliers for regulatory compliance"
    - name: "iso_13485_certified_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN iso_13485_certified = TRUE THEN supplier_id END)
      comment: "Number of ISO 13485 certified suppliers"
    - name: "iso_9001_certified_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN iso_9001_certified = TRUE THEN supplier_id END)
      comment: "Number of ISO 9001 certified suppliers"
    - name: "cold_chain_capable_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN cold_chain_capable = TRUE THEN supplier_id END)
      comment: "Number of suppliers with cold chain capabilities"
    - name: "single_source_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN single_source_flag = TRUE THEN supplier_id END)
      comment: "Number of single-source suppliers representing supply chain risk"
    - name: "blocked_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN blocked_for_purchasing = TRUE THEN supplier_id END)
      comment: "Number of suppliers blocked from purchasing"
    - name: "high_risk_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN risk_tier = 'High' THEN supplier_id END)
      comment: "Number of high-risk suppliers requiring enhanced monitoring"
    - name: "supplier_certification_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN gmp_certified = TRUE OR iso_13485_certified = TRUE OR iso_9001_certified = TRUE THEN supplier_id END) / NULLIF(COUNT(DISTINCT supplier_id), 0), 2)
      comment: "Percentage of suppliers with at least one quality certification"
    - name: "supplier_diversification_index"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN single_source_flag = FALSE THEN supplier_id END) / NULLIF(COUNT(DISTINCT supplier_id), 0), 2)
      comment: "Percentage of suppliers with alternative sources available"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt transaction metrics for inbound logistics and receiving operations"
  source: "`genomics_biotech_ecm`.`supply`.`goods_receipt`"
  dimensions:
    - name: "movement_type"
      expr: movement_type
      comment: "Type of goods movement (receipt, return, transfer, etc.)"
    - name: "movement_type_description"
      expr: movement_type_description
      comment: "Description of the movement type"
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation type for goods receipt accounting"
    - name: "special_stock_indicator"
      expr: special_stock_indicator
      comment: "Indicator for special stock types (consignment, project, etc.)"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates if this is a reversal transaction"
    - name: "company_currency_code"
      expr: company_currency_code
      comment: "Company currency code for valuation"
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Local currency code for valuation"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the goods movement"
    - name: "posting_year"
      expr: YEAR(posting_date)
      comment: "Year of goods receipt posting"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of goods receipt posting"
    - name: "document_year"
      expr: YEAR(document_date)
      comment: "Year of goods receipt document"
  measures:
    - name: "total_goods_receipt_count"
      expr: COUNT(DISTINCT goods_receipt_id)
      comment: "Total number of goods receipt transactions"
    - name: "total_received_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity received across all transactions"
    - name: "total_movement_value_company_currency"
      expr: SUM(CAST(movement_value_company_currency AS DOUBLE))
      comment: "Total movement value in company currency"
    - name: "total_movement_value_local_currency"
      expr: SUM(CAST(movement_value_local_currency AS DOUBLE))
      comment: "Total movement value in local currency"
    - name: "avg_movement_value_company_currency"
      expr: AVG(CAST(movement_value_company_currency AS DOUBLE))
      comment: "Average movement value per transaction in company currency"
    - name: "avg_received_quantity"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average quantity received per transaction"
    - name: "reversal_transaction_count"
      expr: COUNT(DISTINCT CASE WHEN reversal_indicator = TRUE THEN goods_receipt_id END)
      comment: "Number of reversal transactions indicating receipt errors or returns"
    - name: "reversal_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN reversal_indicator = TRUE THEN goods_receipt_id END) / NULLIF(COUNT(DISTINCT goods_receipt_id), 0), 2)
      comment: "Percentage of goods receipts that are reversals, indicating quality or process issues"
    - name: "unique_material_received_count"
      expr: COUNT(DISTINCT material_id)
      comment: "Number of unique materials received"
    - name: "unique_supplier_received_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers from which goods were received"
    - name: "unique_po_received_count"
      expr: COUNT(DISTINCT purchase_order_id)
      comment: "Number of unique purchase orders fulfilled through goods receipts"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`supply_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Batch quality, compliance, and lifecycle metrics for lot traceability and regulatory control"
  source: "`genomics_biotech_ecm`.`supply`.`batch`"
  dimensions:
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the batch (released, quarantine, blocked, etc.)"
    - name: "qc_status"
      expr: qc_status
      comment: "Quality control status of the batch"
    - name: "gmp_classification"
      expr: gmp_classification
      comment: "GMP classification for regulatory compliance"
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the batch"
    - name: "storage_condition"
      expr: storage_condition
      comment: "Required storage conditions for the batch"
    - name: "cold_chain_compliant_flag"
      expr: cold_chain_compliant_flag
      comment: "Indicates if batch is cold chain compliant"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates if batch contains hazardous materials"
    - name: "recall_flag"
      expr: recall_flag
      comment: "Indicates if batch is under recall"
    - name: "sterilization_method"
      expr: sterilization_method
      comment: "Sterilization method applied to the batch"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the batch"
    - name: "manufacturing_year"
      expr: YEAR(manufacturing_date)
      comment: "Year the batch was manufactured"
    - name: "manufacturing_month"
      expr: DATE_TRUNC('MONTH', manufacturing_date)
      comment: "Month the batch was manufactured"
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the batch expires"
    - name: "qc_release_year"
      expr: YEAR(qc_release_date)
      comment: "Year the batch was released by QC"
  measures:
    - name: "total_batch_count"
      expr: COUNT(DISTINCT batch_id)
      comment: "Total number of unique batches"
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total available quantity across all batches"
    - name: "total_blocked_quantity"
      expr: SUM(CAST(blocked_quantity AS DOUBLE))
      comment: "Total blocked quantity not available for use"
    - name: "total_quarantine_quantity"
      expr: SUM(CAST(quarantine_quantity AS DOUBLE))
      comment: "Total quantity in quarantine pending quality release"
    - name: "total_size_quantity"
      expr: SUM(CAST(size_quantity AS DOUBLE))
      comment: "Total size quantity across all batches"
    - name: "avg_storage_temperature_max"
      expr: AVG(CAST(storage_temperature_max_c AS DOUBLE))
      comment: "Average maximum storage temperature in Celsius"
    - name: "avg_storage_temperature_min"
      expr: AVG(CAST(storage_temperature_min_c AS DOUBLE))
      comment: "Average minimum storage temperature in Celsius"
    - name: "batch_availability_rate"
      expr: ROUND(100.0 * SUM(CAST(available_quantity AS DOUBLE)) / NULLIF(SUM(CAST(available_quantity AS DOUBLE)) + SUM(CAST(blocked_quantity AS DOUBLE)) + SUM(CAST(quarantine_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of batch quantity that is available for use"
    - name: "quarantine_rate"
      expr: ROUND(100.0 * SUM(CAST(quarantine_quantity AS DOUBLE)) / NULLIF(SUM(CAST(available_quantity AS DOUBLE)) + SUM(CAST(blocked_quantity AS DOUBLE)) + SUM(CAST(quarantine_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of batch quantity in quarantine, indicating quality hold rate"
    - name: "recall_batch_count"
      expr: COUNT(DISTINCT CASE WHEN recall_flag = TRUE THEN batch_id END)
      comment: "Number of batches under recall for regulatory and quality tracking"
    - name: "cold_chain_compliant_batch_count"
      expr: COUNT(DISTINCT CASE WHEN cold_chain_compliant_flag = TRUE THEN batch_id END)
      comment: "Number of cold chain compliant batches"
    - name: "hazmat_batch_count"
      expr: COUNT(DISTINCT CASE WHEN hazmat_flag = TRUE THEN batch_id END)
      comment: "Number of batches containing hazardous materials"
    - name: "unique_material_batch_count"
      expr: COUNT(DISTINCT material_id)
      comment: "Number of unique materials with batches"
    - name: "unique_supplier_batch_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers providing batches"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`supply_supplier_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier qualification, audit, and compliance metrics for vendor quality management"
  source: "`genomics_biotech_ecm`.`supply`.`supplier_qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status of the supplier"
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of supplier qualification (initial, re-qualification, etc.)"
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit conducted (on-site, remote, document review, etc.)"
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier assigned based on qualification assessment"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Indicates if corrective action is required"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of required corrective actions"
    - name: "iso_13485_certified"
      expr: iso_13485_certified
      comment: "Indicates if supplier is ISO 13485 certified"
    - name: "iso_9001_certified"
      expr: iso_9001_certified
      comment: "Indicates if supplier is ISO 9001 certified"
    - name: "fda_registered"
      expr: fda_registered
      comment: "Indicates if supplier is FDA registered"
    - name: "gmp_scope"
      expr: gmp_scope
      comment: "Scope of GMP qualification"
    - name: "regulatory_body_alignment"
      expr: regulatory_body_alignment
      comment: "Regulatory body alignment for compliance"
    - name: "qualification_year"
      expr: YEAR(qualification_date)
      comment: "Year of supplier qualification"
    - name: "audit_year"
      expr: YEAR(audit_date)
      comment: "Year of supplier audit"
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the qualification expires"
  measures:
    - name: "total_qualification_count"
      expr: COUNT(DISTINCT supplier_qualification_id)
      comment: "Total number of supplier qualification records"
    - name: "avg_qualification_score"
      expr: AVG(CAST(qualification_score AS DOUBLE))
      comment: "Average qualification score across suppliers"
    - name: "avg_critical_findings"
      expr: AVG(CAST(critical_findings_count AS DOUBLE))
      comment: "Average number of critical findings per qualification"
    - name: "avg_major_findings"
      expr: AVG(CAST(major_findings_count AS DOUBLE))
      comment: "Average number of major findings per qualification"
    - name: "avg_minor_findings"
      expr: AVG(CAST(minor_findings_count AS DOUBLE))
      comment: "Average number of minor findings per qualification"
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS DOUBLE))
      comment: "Total critical findings across all qualifications"
    - name: "total_major_findings"
      expr: SUM(CAST(major_findings_count AS DOUBLE))
      comment: "Total major findings across all qualifications"
    - name: "corrective_action_required_count"
      expr: COUNT(DISTINCT CASE WHEN corrective_action_required = TRUE THEN supplier_qualification_id END)
      comment: "Number of qualifications requiring corrective action"
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN corrective_action_required = TRUE THEN supplier_qualification_id END) / NULLIF(COUNT(DISTINCT supplier_qualification_id), 0), 2)
      comment: "Percentage of qualifications requiring corrective action, indicating supplier quality issues"
    - name: "iso_13485_certified_count"
      expr: COUNT(DISTINCT CASE WHEN iso_13485_certified = TRUE THEN supplier_qualification_id END)
      comment: "Number of qualifications with ISO 13485 certification"
    - name: "iso_9001_certified_count"
      expr: COUNT(DISTINCT CASE WHEN iso_9001_certified = TRUE THEN supplier_qualification_id END)
      comment: "Number of qualifications with ISO 9001 certification"
    - name: "fda_registered_count"
      expr: COUNT(DISTINCT CASE WHEN fda_registered = TRUE THEN supplier_qualification_id END)
      comment: "Number of qualifications with FDA registration"
    - name: "high_risk_qualification_count"
      expr: COUNT(DISTINCT CASE WHEN risk_tier = 'High' THEN supplier_qualification_id END)
      comment: "Number of high-risk supplier qualifications requiring enhanced oversight"
    - name: "unique_supplier_qualified_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers with qualification records"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`supply_inbound_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound delivery performance, compliance, and logistics metrics for receiving operations"
  source: "`genomics_biotech_ecm`.`supply`.`inbound_delivery`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the inbound delivery"
    - name: "delivery_priority"
      expr: delivery_priority
      comment: "Priority level of the delivery"
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Status of customs clearance for international shipments"
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of the carrier handling the delivery"
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms code defining delivery terms"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates if delivery contains hazardous materials"
    - name: "quality_inspection_required_flag"
      expr: quality_inspection_required_flag
      comment: "Indicates if quality inspection is required upon receipt"
    - name: "temperature_excursion_flag"
      expr: temperature_excursion_flag
      comment: "Indicates if temperature excursion occurred during transit"
    - name: "freight_cost_currency_code"
      expr: freight_cost_currency_code
      comment: "Currency code for freight costs"
    - name: "expected_arrival_year"
      expr: YEAR(expected_arrival_date)
      comment: "Year of expected arrival"
    - name: "expected_arrival_month"
      expr: DATE_TRUNC('MONTH', expected_arrival_date)
      comment: "Month of expected arrival"
    - name: "goods_receipt_year"
      expr: YEAR(goods_receipt_date)
      comment: "Year goods were received"
    - name: "customs_clearance_year"
      expr: YEAR(customs_clearance_date)
      comment: "Year of customs clearance"
  measures:
    - name: "total_inbound_delivery_count"
      expr: COUNT(DISTINCT inbound_delivery_id)
      comment: "Total number of inbound deliveries"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight cost across all deliveries"
    - name: "avg_freight_cost"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per delivery"
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight in kilograms across all deliveries"
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volume in cubic meters across all deliveries"
    - name: "avg_weight_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average weight per delivery in kilograms"
    - name: "avg_volume_m3"
      expr: AVG(CAST(total_volume_m3 AS DOUBLE))
      comment: "Average volume per delivery in cubic meters"
    - name: "avg_max_temperature_celsius"
      expr: AVG(CAST(max_temperature_celsius AS DOUBLE))
      comment: "Average maximum temperature during transit in Celsius"
    - name: "avg_min_temperature_celsius"
      expr: AVG(CAST(min_temperature_celsius AS DOUBLE))
      comment: "Average minimum temperature during transit in Celsius"
    - name: "temperature_excursion_count"
      expr: COUNT(DISTINCT CASE WHEN temperature_excursion_flag = TRUE THEN inbound_delivery_id END)
      comment: "Number of deliveries with temperature excursions, indicating cold chain failures"
    - name: "temperature_excursion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN temperature_excursion_flag = TRUE THEN inbound_delivery_id END) / NULLIF(COUNT(DISTINCT inbound_delivery_id), 0), 2)
      comment: "Percentage of deliveries with temperature excursions, critical for cold chain compliance"
    - name: "hazmat_delivery_count"
      expr: COUNT(DISTINCT CASE WHEN hazmat_flag = TRUE THEN inbound_delivery_id END)
      comment: "Number of deliveries containing hazardous materials"
    - name: "quality_inspection_required_count"
      expr: COUNT(DISTINCT CASE WHEN quality_inspection_required_flag = TRUE THEN inbound_delivery_id END)
      comment: "Number of deliveries requiring quality inspection"
    - name: "unique_supplier_delivery_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers with inbound deliveries"
    - name: "unique_carrier_count"
      expr: COUNT(DISTINCT carrier_name)
      comment: "Number of unique carriers used for deliveries"
$$;