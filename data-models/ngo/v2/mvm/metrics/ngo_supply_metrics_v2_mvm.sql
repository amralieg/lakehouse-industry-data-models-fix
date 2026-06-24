-- Metric views for domain: supply | Business: Ngo | Version: 2 | Generated on: 2026-06-23 02:03:19

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_procurement_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic procurement pipeline metrics tracking request volumes, estimated spend, urgency distribution, and approval efficiency across the NGO supply chain. Enables procurement officers and supply chain directors to monitor demand signals, budget exposure, and bottlenecks."
  source: "`vibe_ngo_v1`.`supply`.`procurement_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Current workflow status of the procurement request (e.g., Draft, Pending Approval, Approved, Rejected). Used to segment pipeline by stage."
    - name: "request_type"
      expr: request_type
      comment: "Type of procurement request (e.g., goods, services, works). Enables category-level pipeline analysis."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency classification of the request (e.g., Routine, Urgent, Emergency). Critical for prioritization and resource allocation."
    - name: "commodity_category"
      expr: commodity_category
      comment: "High-level commodity category of the requested item. Supports spend analysis by category."
    - name: "approval_level_required"
      expr: approval_level_required
      comment: "Required approval authority level for the request. Helps identify bottlenecks in the approval hierarchy."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month in which the procurement request was raised. Enables trend analysis of procurement demand over time."
    - name: "required_delivery_month"
      expr: DATE_TRUNC('MONTH', required_delivery_date)
      comment: "Month by which delivery is required. Used to forecast procurement workload and delivery commitments."
    - name: "local_procurement_preference"
      expr: local_procurement_preference
      comment: "Flag indicating whether local procurement is preferred. Supports localization strategy reporting."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Indicates whether the procurement request is visible to donors. Used for donor reporting and compliance segmentation."
  measures:
    - name: "total_procurement_requests"
      expr: COUNT(1)
      comment: "Total number of procurement requests submitted. Baseline volume metric for pipeline monitoring and capacity planning."
    - name: "total_estimated_spend_usd"
      expr: SUM(CAST(estimated_total_cost AS DOUBLE))
      comment: "Total estimated spend across all procurement requests in USD. Core financial exposure metric for budget oversight and donor reporting."
    - name: "avg_estimated_unit_cost_usd"
      expr: AVG(CAST(estimated_unit_cost AS DOUBLE))
      comment: "Average estimated unit cost across procurement requests. Benchmarks unit pricing trends and flags potential cost anomalies."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total quantity of commodities requested across all procurement requests. Measures demand volume for supply planning."
    - name: "emergency_request_count"
      expr: COUNT(CASE WHEN urgency_level = 'Emergency' THEN 1 END)
      comment: "Number of procurement requests flagged as emergency. High values signal supply chain stress and may trigger escalation protocols."
    - name: "pending_approval_request_count"
      expr: COUNT(CASE WHEN request_status = 'Pending Approval' THEN 1 END)
      comment: "Number of requests currently awaiting approval. A leading indicator of approval bottlenecks that delay procurement execution."
    - name: "rejected_request_count"
      expr: COUNT(CASE WHEN request_status = 'Rejected' THEN 1 END)
      comment: "Number of procurement requests that were rejected. Tracks rejection rates to identify systemic issues in request quality or compliance."
    - name: "estimated_spend_pending_approval_usd"
      expr: SUM(CASE WHEN request_status = 'Pending Approval' THEN CAST(estimated_total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total estimated spend value of requests currently pending approval. Quantifies financial exposure held up in the approval queue."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order execution and financial metrics for the NGO supply chain. Tracks order values, delivery performance, payment obligations, and procurement method distribution to support financial oversight and vendor management."
  source: "`vibe_ngo_v1`.`supply`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order (e.g., Draft, Issued, Partially Received, Closed). Core dimension for pipeline stage analysis."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g., Standard, Framework, Emergency). Enables analysis by procurement instrument type."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method used (e.g., Competitive Bidding, Direct Procurement, Framework Agreement). Critical for compliance and audit reporting."
    - name: "commodity_category"
      expr: commodity_category
      comment: "High-level commodity category covered by the purchase order. Supports spend analysis by category."
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of goods receipt against the purchase order. Tracks delivery completion and outstanding receipts."
    - name: "approval_workflow_status"
      expr: approval_workflow_status
      comment: "Status of the internal approval workflow for the PO. Identifies orders held in approval queues."
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms governing delivery responsibility. Used for logistics cost and risk analysis."
    - name: "emergency_flag"
      expr: emergency_flag
      comment: "Indicates whether the purchase order was raised as an emergency procurement. Tracks emergency spend for compliance and cost analysis."
    - name: "po_month"
      expr: DATE_TRUNC('MONTH', po_date)
      comment: "Month the purchase order was issued. Enables monthly spend trend analysis."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Indicates whether the PO is visible to donors. Used for donor reporting segmentation."
  measures:
    - name: "total_purchase_orders"
      expr: COUNT(1)
      comment: "Total number of purchase orders issued. Baseline volume metric for procurement activity monitoring."
    - name: "total_po_value_usd"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total committed spend across all purchase orders in USD. Primary financial commitment metric for budget and cash flow management."
    - name: "total_freight_cost_usd"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight costs across purchase orders. Tracks logistics spend as a component of total procurement cost."
    - name: "total_tax_amount_usd"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charges across purchase orders. Supports tax liability reporting and cost analysis."
    - name: "total_subtotal_amount_usd"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total pre-tax, pre-freight order value. Used to isolate commodity cost from logistics and tax components."
    - name: "avg_po_value_usd"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average purchase order value in USD. Benchmarks typical order size and identifies outliers requiring additional scrutiny."
    - name: "emergency_po_count"
      expr: COUNT(CASE WHEN emergency_flag = TRUE THEN 1 END)
      comment: "Number of purchase orders raised under emergency procurement. High values indicate supply chain stress and potential compliance risk."
    - name: "emergency_po_value_usd"
      expr: SUM(CASE WHEN emergency_flag = TRUE THEN CAST(total_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of emergency purchase orders. Quantifies financial exposure from non-competitive emergency procurement."
    - name: "open_po_value_usd"
      expr: SUM(CASE WHEN po_status NOT IN ('Closed', 'Cancelled') THEN CAST(total_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of purchase orders that are not yet closed or cancelled. Represents outstanding financial commitments in the procurement pipeline."
    - name: "distinct_vendors_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with active purchase orders. Measures vendor base diversity and concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt quality and delivery performance metrics for the NGO supply chain. Tracks receipt volumes, quantity discrepancies, rejection rates, cold chain breaches, and inspection outcomes to ensure supply quality and accountability."
  source: "`vibe_ngo_v1`.`supply`.`goods_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Current status of the goods receipt (e.g., Pending, Accepted, Rejected, Partial). Core dimension for receipt pipeline analysis."
    - name: "condition_on_arrival"
      expr: condition_on_arrival
      comment: "Physical condition of goods upon arrival (e.g., Good, Damaged, Partial). Key quality indicator for supply chain integrity."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Status of quality inspection for the received goods. Tracks inspection completion and outcomes."
    - name: "cold_chain_breach_flag"
      expr: cold_chain_breach_flag
      comment: "Indicates whether a cold chain breach occurred during transit. Critical for vaccine and temperature-sensitive commodity management."
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Indicates whether a quantity or quality discrepancy was recorded at receipt. Used to track vendor delivery accuracy."
    - name: "customs_cleared"
      expr: customs_cleared
      comment: "Indicates whether customs clearance was completed. Used to track import compliance and clearance delays."
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month goods were received. Enables trend analysis of inbound supply volumes over time."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for received goods. Supports volume analysis across different commodity types."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Indicates whether the receipt is visible to donors. Used for donor accountability and reporting segmentation."
  measures:
    - name: "total_goods_receipts"
      expr: COUNT(1)
      comment: "Total number of goods receipt transactions. Baseline inbound supply activity metric."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of goods received across all receipts. Core inbound supply volume metric for inventory planning."
    - name: "total_quantity_rejected"
      expr: SUM(CAST(quantity_rejected AS DOUBLE))
      comment: "Total quantity of goods rejected at receipt. High values indicate vendor quality issues or cold chain failures."
    - name: "total_receipt_cost_usd"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of goods received in USD. Tracks actual procurement spend materializing into inventory."
    - name: "total_freight_charges_usd"
      expr: SUM(CAST(freight_charges AS DOUBLE))
      comment: "Total freight charges incurred on goods receipts. Measures logistics cost component of inbound supply."
    - name: "avg_unit_cost_usd"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of received goods. Benchmarks actual unit pricing against contracted rates."
    - name: "receipts_with_discrepancy_count"
      expr: COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END)
      comment: "Number of receipts with recorded quantity or quality discrepancies. Tracks vendor delivery accuracy and supply chain reliability."
    - name: "cold_chain_breach_count"
      expr: COUNT(CASE WHEN cold_chain_breach_flag = TRUE THEN 1 END)
      comment: "Number of receipts where a cold chain breach was detected. Critical quality metric for vaccines and temperature-sensitive commodities."
    - name: "quantity_ordered_total"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered as recorded on goods receipts. Used alongside quantity received to compute fill rate and delivery completeness."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_inventory_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory position and stock health metrics across NGO warehouses. Tracks on-hand stock, availability, quarantine levels, transit quantities, and valuation to support stock replenishment decisions, donor reporting, and pipeline management."
  source: "`vibe_ngo_v1`.`supply`.`inventory_balance`"
  dimensions:
    - name: "pipeline_status"
      expr: pipeline_status
      comment: "Pipeline status of the inventory (e.g., In Pipeline, Available, Depleted). Used to segment stock by supply pipeline stage."
    - name: "storage_condition"
      expr: storage_condition
      comment: "Storage condition requirement for the commodity (e.g., Ambient, Cold Chain, Frozen). Critical for cold chain inventory management."
    - name: "donor_restriction_flag"
      expr: donor_restriction_flag
      comment: "Indicates whether the inventory is donor-restricted. Ensures restricted stock is tracked separately for compliance."
    - name: "in_kind_donation_flag"
      expr: in_kind_donation_flag
      comment: "Indicates whether the inventory was received as an in-kind donation. Supports in-kind contribution tracking and donor reporting."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the inventory balance. Enables volume analysis across commodity types."
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_date)
      comment: "Month of the inventory snapshot. Enables trend analysis of stock levels over time."
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month of commodity expiration. Used to identify near-expiry stock requiring urgent distribution."
    - name: "warehouse_location"
      expr: warehouse_location
      comment: "Physical location within the warehouse. Supports granular stock positioning analysis."
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity of stock physically on hand across all inventory records. Primary stock position metric for replenishment and distribution planning."
    - name: "total_quantity_available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total quantity available for distribution (on hand minus reserved and quarantined). Operational metric for distribution planning."
    - name: "total_quantity_reserved"
      expr: SUM(CAST(quantity_reserved AS DOUBLE))
      comment: "Total quantity reserved for planned distributions. Tracks committed stock to prevent over-allocation."
    - name: "total_quantity_quarantined"
      expr: SUM(CAST(quantity_quarantined AS DOUBLE))
      comment: "Total quantity held in quarantine pending quality clearance. High values signal quality issues impacting supply availability."
    - name: "total_quantity_in_transit"
      expr: SUM(CAST(quantity_in_transit AS DOUBLE))
      comment: "Total quantity currently in transit between warehouses or to distribution points. Tracks pipeline stock not yet available for use."
    - name: "total_inventory_valuation_usd"
      expr: SUM(CAST(total_valuation AS DOUBLE))
      comment: "Total monetary value of inventory on hand in USD. Core financial metric for asset reporting and donor accountability."
    - name: "avg_unit_cost_usd"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of inventory items. Used to benchmark stock valuation and identify cost variances."
    - name: "stock_below_reorder_level_count"
      expr: COUNT(CASE WHEN CAST(quantity_on_hand AS DOUBLE) < CAST(reorder_level AS DOUBLE) THEN 1 END)
      comment: "Number of inventory records where on-hand quantity is below the reorder level. Directly triggers replenishment action to prevent stockouts."
    - name: "stock_above_maximum_count"
      expr: COUNT(CASE WHEN CAST(quantity_on_hand AS DOUBLE) > CAST(maximum_stock_level AS DOUBLE) THEN 1 END)
      comment: "Number of inventory records where on-hand quantity exceeds the maximum stock level. Identifies overstock situations that risk expiry and waste."
    - name: "donor_restricted_valuation_usd"
      expr: SUM(CASE WHEN donor_restriction_flag = TRUE THEN CAST(total_valuation AS DOUBLE) ELSE 0 END)
      comment: "Total value of donor-restricted inventory. Critical for donor compliance reporting and restricted fund management."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock movement throughput and cost metrics tracking all inbound, outbound, and transfer transactions across NGO warehouses. Enables supply chain directors to monitor commodity flows, distribution efficiency, and logistics costs."
  source: "`vibe_ngo_v1`.`supply`.`stock_movement`"
  dimensions:
    - name: "movement_type"
      expr: movement_type
      comment: "Type of stock movement (e.g., Receipt, Issue, Transfer, Adjustment, Return). Primary dimension for classifying supply chain flows."
    - name: "movement_status"
      expr: movement_status
      comment: "Current status of the stock movement transaction. Used to identify pending, completed, or cancelled movements."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used for the movement (e.g., Road, Air, Sea). Supports logistics cost and lead time analysis by transport type."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection outcome for the stock movement. Tracks quality compliance across the supply chain."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the stock movement (e.g., Distribution, Damage, Expiry, Transfer). Enables root cause analysis of stock adjustments."
    - name: "in_kind_donation_flag"
      expr: in_kind_donation_flag
      comment: "Indicates whether the movement relates to an in-kind donation. Supports in-kind contribution tracking."
    - name: "movement_month"
      expr: DATE_TRUNC('MONTH', movement_date)
      comment: "Month of the stock movement. Enables trend analysis of supply chain throughput over time."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the moved stock. Supports volume analysis across commodity types."
  measures:
    - name: "total_stock_movements"
      expr: COUNT(1)
      comment: "Total number of stock movement transactions. Baseline throughput metric for supply chain activity monitoring."
    - name: "total_quantity_moved"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of stock moved across all movement types. Core throughput metric for supply chain volume analysis."
    - name: "total_movement_cost_usd"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all stock movements in USD. Tracks logistics and handling expenditure across the supply chain."
    - name: "avg_unit_cost_usd"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across stock movements. Benchmarks commodity cost consistency and identifies pricing anomalies."
    - name: "distinct_commodities_moved"
      expr: COUNT(DISTINCT commodity_id)
      comment: "Number of distinct commodities involved in stock movements. Measures breadth of supply chain activity and commodity diversity."
    - name: "distinct_warehouses_involved"
      expr: COUNT(DISTINCT primary_stock_warehouse_id)
      comment: "Number of distinct warehouses involved in stock movements. Tracks geographic spread of supply chain operations."
    - name: "issue_movement_quantity"
      expr: SUM(CASE WHEN movement_type = 'Issue' THEN CAST(quantity AS DOUBLE) ELSE 0 END)
      comment: "Total quantity issued (distributed) from stock. Measures actual commodity distribution throughput to beneficiaries."
    - name: "adjustment_movement_count"
      expr: COUNT(CASE WHEN movement_type = 'Adjustment' THEN 1 END)
      comment: "Number of stock adjustment transactions. High adjustment counts may indicate inventory management weaknesses or data quality issues."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_distribution_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution order execution metrics for the NGO supply chain. Tracks order volumes, delivery performance, transport costs, and emergency response activity to support last-mile distribution management and donor reporting."
  source: "`vibe_ngo_v1`.`supply`.`distribution_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the distribution order (e.g., Planned, Dispatched, Delivered, Cancelled). Core dimension for delivery pipeline analysis."
    - name: "distribution_type"
      expr: distribution_type
      comment: "Type of distribution (e.g., Direct, Indirect, Mobile). Enables analysis by distribution modality."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used for the distribution (e.g., Road, Air, Boat). Supports logistics cost and lead time analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the distribution order. Used to track high-priority and emergency distributions."
    - name: "emergency_response_flag"
      expr: emergency_response_flag
      comment: "Indicates whether the order is part of an emergency response. Critical for tracking emergency distribution performance."
    - name: "cold_chain_required_flag"
      expr: cold_chain_required_flag
      comment: "Indicates whether cold chain logistics are required. Used to segment cold chain distribution performance."
    - name: "in_kind_donation_flag"
      expr: in_kind_donation_flag
      comment: "Indicates whether the distribution involves in-kind donated goods. Supports in-kind contribution tracking."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the distribution order was created. Enables trend analysis of distribution activity over time."
    - name: "medical_supplies_flag"
      expr: medical_supplies_flag
      comment: "Indicates whether the order contains medical supplies. Enables segmentation of medical vs. non-food item distributions."
  measures:
    - name: "total_distribution_orders"
      expr: COUNT(1)
      comment: "Total number of distribution orders. Baseline metric for last-mile distribution activity volume."
    - name: "total_estimated_value_usd"
      expr: SUM(CAST(estimated_value_usd AS DOUBLE))
      comment: "Total estimated value of goods distributed in USD. Core financial metric for distribution program reporting and donor accountability."
    - name: "total_transport_cost_usd"
      expr: SUM(CAST(transport_cost_usd AS DOUBLE))
      comment: "Total transport cost across distribution orders. Tracks last-mile logistics expenditure as a key operational cost driver."
    - name: "total_quantity_distributed"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total quantity of commodities distributed. Core output metric for program delivery and beneficiary reach reporting."
    - name: "total_weight_distributed_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of goods distributed in kilograms. Used for logistics planning and transport cost benchmarking."
    - name: "total_volume_distributed_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volume of goods distributed in cubic meters. Supports warehouse and transport capacity planning."
    - name: "avg_transport_cost_per_order_usd"
      expr: AVG(CAST(transport_cost_usd AS DOUBLE))
      comment: "Average transport cost per distribution order. Benchmarks logistics efficiency and identifies high-cost distribution routes."
    - name: "emergency_response_order_count"
      expr: COUNT(CASE WHEN emergency_response_flag = TRUE THEN 1 END)
      comment: "Number of distribution orders classified as emergency response. Tracks emergency distribution capacity and response tempo."
    - name: "emergency_response_value_usd"
      expr: SUM(CASE WHEN emergency_response_flag = TRUE THEN CAST(estimated_value_usd AS DOUBLE) ELSE 0 END)
      comment: "Total estimated value of emergency response distributions. Quantifies financial scale of emergency humanitarian response."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance, qualification, and risk metrics for the NGO supply chain. Enables procurement directors to monitor vendor base health, prequalification status, performance tiers, and blacklist risk to ensure supply chain integrity and compliance."
  source: "`vibe_ngo_v1`.`supply`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current operational status of the vendor (e.g., Active, Inactive, Suspended). Core dimension for vendor base health analysis."
    - name: "vendor_type"
      expr: vendor_type
      comment: "Type of vendor (e.g., Manufacturer, Distributor, Transporter). Enables segmentation of vendor base by supply chain role."
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Vendor prequalification status (e.g., Prequalified, Pending, Expired). Critical for procurement compliance and vendor eligibility tracking."
    - name: "performance_tier"
      expr: performance_tier
      comment: "Performance tier classification of the vendor (e.g., Gold, Silver, Bronze). Supports strategic vendor segmentation and preferred supplier management."
    - name: "blacklist_flag"
      expr: blacklist_flag
      comment: "Indicates whether the vendor is blacklisted. Critical compliance dimension to prevent procurement from ineligible vendors."
    - name: "gmp_certification_flag"
      expr: gmp_certification_flag
      comment: "Indicates whether the vendor holds Good Manufacturing Practice certification. Used for pharmaceutical and medical supply vendor qualification."
    - name: "prequalification_expiry_month"
      expr: DATE_TRUNC('MONTH', prequalification_expiry_date)
      comment: "Month of prequalification expiry. Used to proactively identify vendors requiring requalification."
  measures:
    - name: "total_vendors"
      expr: COUNT(1)
      comment: "Total number of vendors in the vendor master. Baseline metric for vendor base size and diversity."
    - name: "active_vendor_count"
      expr: COUNT(CASE WHEN vendor_status = 'Active' THEN 1 END)
      comment: "Number of currently active vendors. Tracks the size of the eligible vendor pool for procurement."
    - name: "blacklisted_vendor_count"
      expr: COUNT(CASE WHEN blacklist_flag = TRUE THEN 1 END)
      comment: "Number of blacklisted vendors. Compliance metric to monitor and prevent procurement from ineligible suppliers."
    - name: "prequalified_vendor_count"
      expr: COUNT(CASE WHEN prequalification_status = 'Prequalified' THEN 1 END)
      comment: "Number of currently prequalified vendors. Tracks the qualified vendor pool available for competitive procurement."
    - name: "avg_last_performance_score"
      expr: AVG(CAST(last_performance_score AS DOUBLE))
      comment: "Average performance score across vendors. Tracks overall vendor base quality and identifies performance trends."
    - name: "avg_payment_terms_days"
      expr: AVG(CAST(payment_terms_days AS DOUBLE))
      comment: "Average payment terms in days across vendors. Informs cash flow planning and working capital management."
    - name: "total_warehouse_capacity_sqm"
      expr: SUM(CAST(warehouse_capacity_sqm AS DOUBLE))
      comment: "Total warehouse storage capacity offered by vendors in square meters. Assesses vendor logistics infrastructure available to the NGO."
    - name: "gmp_certified_vendor_count"
      expr: COUNT(CASE WHEN gmp_certification_flag = TRUE THEN 1 END)
      comment: "Number of vendors with GMP certification. Tracks qualified pharmaceutical and medical supply vendor availability."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_warehouse`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse network capacity and capability metrics for the NGO supply chain. Enables supply chain directors to assess storage infrastructure, cold chain capability, and geographic coverage to support network optimization and emergency preparedness."
  source: "`vibe_ngo_v1`.`supply`.`warehouse`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of warehouse facility (e.g., Central, Regional, Field). Enables analysis by warehouse tier in the distribution network."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type of the warehouse (e.g., Owned, Leased, Partner). Supports cost and risk analysis of the warehouse network."
    - name: "cold_chain_capable_flag"
      expr: cold_chain_capable_flag
      comment: "Indicates whether the warehouse has cold chain storage capability. Critical for vaccine and temperature-sensitive commodity network planning."
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Indicates whether the warehouse has temperature-controlled storage. Supports cold chain network capacity analysis."
    - name: "hazmat_certified"
      expr: hazmat_certified
      comment: "Indicates whether the warehouse is certified for hazardous materials storage. Tracks specialized storage capability."
    - name: "vaccine_storage_certified_flag"
      expr: vaccine_storage_certified_flag
      comment: "Indicates whether the warehouse is certified for vaccine storage. Critical for immunization supply chain network planning."
    - name: "security_level"
      expr: security_level
      comment: "Security classification of the warehouse. Used for risk assessment and high-value commodity storage planning."
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "Administrative level 1 (e.g., province/state) where the warehouse is located. Enables geographic distribution analysis of warehouse network."
    - name: "emergency_access_24_7"
      expr: emergency_access_24_7
      comment: "Indicates whether the warehouse has 24/7 emergency access. Tracks emergency response readiness of the warehouse network."
  measures:
    - name: "total_warehouses"
      expr: COUNT(1)
      comment: "Total number of warehouses in the network. Baseline metric for warehouse network size and geographic coverage."
    - name: "total_storage_capacity_m3"
      expr: SUM(CAST(storage_capacity_m3 AS DOUBLE))
      comment: "Total storage capacity across all warehouses in cubic meters. Core infrastructure metric for supply chain capacity planning."
    - name: "total_cold_chain_capacity_liters"
      expr: SUM(CAST(cold_chain_capacity_liters AS DOUBLE))
      comment: "Total cold chain storage capacity across all warehouses in liters. Critical metric for vaccine and cold chain commodity network planning."
    - name: "cold_chain_capable_warehouse_count"
      expr: COUNT(CASE WHEN cold_chain_capable_flag = TRUE THEN 1 END)
      comment: "Number of warehouses with cold chain capability. Tracks cold chain network coverage for temperature-sensitive commodity management."
    - name: "vaccine_certified_warehouse_count"
      expr: COUNT(CASE WHEN vaccine_storage_certified_flag = TRUE THEN 1 END)
      comment: "Number of warehouses certified for vaccine storage. Directly informs immunization supply chain network capacity."
    - name: "emergency_access_warehouse_count"
      expr: COUNT(CASE WHEN emergency_access_24_7 = TRUE THEN 1 END)
      comment: "Number of warehouses with 24/7 emergency access. Measures emergency response readiness of the warehouse network."
    - name: "avg_storage_capacity_m3"
      expr: AVG(CAST(storage_capacity_m3 AS DOUBLE))
      comment: "Average storage capacity per warehouse in cubic meters. Benchmarks warehouse size and identifies capacity imbalances in the network."
    - name: "avg_cold_chain_capacity_liters"
      expr: AVG(CAST(cold_chain_capacity_liters AS DOUBLE))
      comment: "Average cold chain capacity per warehouse in liters. Used to assess cold chain infrastructure adequacy across the network."
$$;