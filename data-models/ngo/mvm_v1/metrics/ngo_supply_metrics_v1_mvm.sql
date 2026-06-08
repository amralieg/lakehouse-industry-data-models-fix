-- Metric views for domain: supply | Business: Ngo | Version: 1 | Generated on: 2026-05-07 03:19:07

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`supply_procurement_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for procurement request pipeline — tracks request volumes, estimated spend, urgency distribution, and approval cycle efficiency to steer procurement planning and donor compliance."
  source: "`ngo_ecm`.`supply`.`procurement_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Current workflow status of the procurement request (e.g., Draft, Submitted, Approved, Rejected) — used to segment pipeline health."
    - name: "request_type"
      expr: request_type
      comment: "Type of procurement request (e.g., Goods, Services, Works) — drives procurement method and compliance requirements."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency classification of the request — critical for emergency response prioritization."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Category of commodity being requested — enables spend analysis by commodity type."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the request is denominated — required for multi-currency spend analysis."
    - name: "local_procurement_preference"
      expr: local_procurement_preference
      comment: "Flag indicating whether local procurement is preferred — tracks localization strategy compliance."
    - name: "compliance_check_required"
      expr: compliance_check_required
      comment: "Flag indicating whether a compliance check is required — used to monitor regulatory adherence."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month of request submission — enables trend analysis of procurement demand over time."
    - name: "approval_level_required"
      expr: approval_level_required
      comment: "Required approval authority level — used to assess governance burden and bottlenecks."
  measures:
    - name: "total_estimated_spend_usd"
      expr: SUM(CAST(estimated_total_cost AS DOUBLE))
      comment: "Total estimated procurement spend across all requests — primary financial KPI for budget planning and donor reporting."
    - name: "avg_estimated_unit_cost_usd"
      expr: AVG(CAST(estimated_unit_cost AS DOUBLE))
      comment: "Average estimated unit cost across procurement requests — benchmarks unit pricing and flags cost anomalies."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total quantity of items requested — measures demand volume for supply planning."
    - name: "active_request_count"
      expr: COUNT(CASE WHEN request_status NOT IN ('Rejected', 'Cancelled', 'Closed') THEN procurement_request_id END)
      comment: "Number of procurement requests currently active in the pipeline — indicates workload and procurement backlog."
    - name: "emergency_request_count"
      expr: COUNT(CASE WHEN urgency_level = 'Emergency' THEN procurement_request_id END)
      comment: "Number of emergency-classified procurement requests — tracks humanitarian response procurement pressure."
    - name: "sole_source_request_count"
      expr: COUNT(CASE WHEN sole_source_justification IS NOT NULL AND sole_source_justification <> '' THEN procurement_request_id END)
      comment: "Number of requests with sole-source justification — monitors non-competitive procurement risk for donor audits."
    - name: "avg_days_to_approval"
      expr: AVG(CAST(DATEDIFF(approval_date, request_date) AS DOUBLE))
      comment: "Average number of days from request submission to approval — measures procurement cycle efficiency and identifies bottlenecks."
    - name: "local_procurement_request_count"
      expr: COUNT(CASE WHEN local_procurement_preference = TRUE THEN procurement_request_id END)
      comment: "Number of requests flagged for local procurement preference — tracks localization strategy execution."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Executive-level KPIs for purchase order management — tracks committed spend, delivery performance, procurement method mix, and order fulfillment status to govern vendor relationships and budget execution."
  source: "`ngo_ecm`.`supply`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order (e.g., Draft, Approved, Closed, Cancelled) — primary filter for active spend analysis."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g., Standard, Framework, Emergency) — used to segment procurement strategy."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method used (e.g., Competitive Bidding, Direct Procurement) — critical for donor compliance reporting."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Category of goods or services procured — enables spend analysis by commodity type."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the purchase order — required for multi-currency financial consolidation."
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of goods receipt against this PO — tracks fulfillment and delivery completion."
    - name: "emergency_flag"
      expr: emergency_flag
      comment: "Indicates whether the PO was raised under emergency conditions — used to track emergency procurement spend."
    - name: "po_month"
      expr: DATE_TRUNC('MONTH', po_date)
      comment: "Month the purchase order was issued — enables monthly spend trend analysis."
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms governing delivery responsibility — used for logistics cost attribution."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed with the vendor — used for cash flow planning and vendor management."
  measures:
    - name: "total_committed_spend_usd"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total committed spend across all purchase orders — primary financial KPI for budget execution monitoring."
    - name: "total_freight_cost_usd"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight costs across purchase orders — tracks logistics overhead as a component of total procurement cost."
    - name: "total_tax_amount_usd"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charges on purchase orders — monitors tax exposure and duty exemption effectiveness."
    - name: "avg_po_value_usd"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average value per purchase order — benchmarks order sizing and identifies outliers requiring additional scrutiny."
    - name: "emergency_po_spend_usd"
      expr: SUM(CASE WHEN emergency_flag = TRUE THEN CAST(total_amount AS DOUBLE) ELSE 0 END)
      comment: "Total spend on emergency purchase orders — measures the financial scale of emergency procurement, a key risk indicator."
    - name: "avg_delivery_lead_time_days"
      expr: AVG(CAST(DATEDIFF(actual_delivery_date, po_date) AS DOUBLE))
      comment: "Average days from PO issuance to actual delivery — measures vendor delivery performance and supply chain responsiveness."
    - name: "overdue_po_count"
      expr: COUNT(CASE WHEN actual_delivery_date IS NULL AND expected_delivery_date < CURRENT_DATE() AND po_status NOT IN ('Closed', 'Cancelled') THEN purchase_order_id END)
      comment: "Number of purchase orders past their expected delivery date without confirmed receipt — critical operational risk indicator."
    - name: "competitive_procurement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN procurement_method IN ('Competitive Bidding', 'Request for Quotation', 'Tender') THEN purchase_order_id END) / NULLIF(COUNT(purchase_order_id), 0), 2)
      comment: "Percentage of POs awarded through competitive procurement — key donor compliance and transparency KPI."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and fulfillment KPIs for goods receipt — tracks receipt accuracy, rejection rates, inspection compliance, and discrepancy rates to ensure supply quality and donor accountability."
  source: "`ngo_ecm`.`supply`.`goods_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of the goods receipt (e.g., Pending, Accepted, Rejected, Partial) — primary filter for receipt pipeline analysis."
    - name: "condition_on_arrival"
      expr: condition_on_arrival
      comment: "Physical condition of goods upon arrival — used to assess supplier quality and cold chain integrity."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Status of quality inspection for received goods — tracks compliance with quality assurance protocols."
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Indicates whether a quantity or quality discrepancy was recorded — used to flag supplier performance issues."
    - name: "customs_cleared"
      expr: customs_cleared
      comment: "Indicates whether customs clearance has been completed — tracks import compliance and clearance bottlenecks."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the goods receipt valuation — required for multi-currency cost consolidation."
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month goods were received — enables trend analysis of inbound supply volumes."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Indicates whether this receipt is visible to donors — used for donor reporting and transparency compliance."
  measures:
    - name: "total_received_value_usd"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total value of goods received — primary financial KPI for inventory valuation and budget execution tracking."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of goods received — measures inbound supply volume for inventory planning."
    - name: "total_quantity_rejected"
      expr: SUM(CAST(quantity_rejected AS DOUBLE))
      comment: "Total quantity of goods rejected on receipt — measures supplier quality failures and waste."
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_rejected AS DOUBLE)) / NULLIF(SUM(CAST(quantity_received AS DOUBLE)), 0), 2)
      comment: "Percentage of received goods rejected — key supplier quality KPI; high rates trigger vendor performance reviews."
    - name: "receipt_fulfillment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_received AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity actually received — measures PO fulfillment accuracy and supplier reliability."
    - name: "discrepancy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN discrepancy_flag = TRUE THEN goods_receipt_id END) / NULLIF(COUNT(goods_receipt_id), 0), 2)
      comment: "Percentage of receipts with recorded discrepancies — tracks supply chain integrity and documentation accuracy."
    - name: "total_freight_charges_usd"
      expr: SUM(CAST(freight_charges AS DOUBLE))
      comment: "Total freight charges incurred on goods receipts — tracks inbound logistics costs for cost efficiency analysis."
    - name: "avg_unit_cost_usd"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of received goods — benchmarks procurement pricing and identifies cost variances."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`supply_inventory_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory health and stock management KPIs — tracks stock levels, valuation, stockout risk, and pipeline status to ensure uninterrupted humanitarian aid delivery."
  source: "`ngo_ecm`.`supply`.`inventory_balance`"
  dimensions:
    - name: "pipeline_status"
      expr: pipeline_status
      comment: "Pipeline status of the inventory (e.g., In Pipeline, Available, Committed) — used to assess supply readiness."
    - name: "storage_condition"
      expr: storage_condition
      comment: "Storage condition requirements for the commodity — used to assess cold chain and special storage compliance."
    - name: "country_code"
      expr: country_code
      comment: "Country where the inventory is held — enables geographic stock distribution analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of inventory valuation — required for multi-currency financial consolidation."
    - name: "donor_restriction_flag"
      expr: donor_restriction_flag
      comment: "Indicates whether the inventory is donor-restricted — critical for compliance with donor earmarking requirements."
    - name: "in_kind_donation_flag"
      expr: in_kind_donation_flag
      comment: "Indicates whether the inventory was received as an in-kind donation — used for in-kind asset tracking and reporting."
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_date)
      comment: "Month of the inventory snapshot — enables month-over-month stock trend analysis."
    - name: "warehouse_location"
      expr: warehouse_location
      comment: "Physical location within the warehouse — used for bin-level stock analysis and space utilization."
  measures:
    - name: "total_stock_valuation_usd"
      expr: SUM(CAST(total_valuation AS DOUBLE))
      comment: "Total value of inventory on hand — primary financial KPI for asset management and donor reporting."
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total physical quantity of stock on hand — core supply availability metric for distribution planning."
    - name: "total_quantity_available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total quantity available for distribution (on hand minus reserved/quarantined) — operational readiness KPI."
    - name: "total_quantity_reserved"
      expr: SUM(CAST(quantity_reserved AS DOUBLE))
      comment: "Total quantity reserved for planned distributions — measures committed supply against available stock."
    - name: "total_quantity_quarantined"
      expr: SUM(CAST(quantity_quarantined AS DOUBLE))
      comment: "Total quantity held in quarantine — tracks quality holds that reduce effective supply availability."
    - name: "total_quantity_in_transit"
      expr: SUM(CAST(quantity_in_transit AS DOUBLE))
      comment: "Total quantity currently in transit — measures pipeline supply not yet available for distribution."
    - name: "stockout_risk_item_count"
      expr: COUNT(CASE WHEN quantity_available <= reorder_level THEN inventory_balance_id END)
      comment: "Number of inventory items at or below reorder level — critical early warning KPI for supply disruption risk."
    - name: "stock_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_reserved AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand stock reserved for distributions — measures how effectively stock is being committed to program delivery."
    - name: "avg_unit_cost_usd"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of inventory items — used for cost benchmarking and valuation accuracy checks."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`supply_distribution_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Humanitarian distribution execution KPIs — tracks order fulfillment, delivery performance, transport costs, and beneficiary reach to measure last-mile delivery effectiveness."
  source: "`ngo_ecm`.`supply`.`distribution_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the distribution order (e.g., Planned, Dispatched, Delivered, Cancelled) — primary filter for pipeline analysis."
    - name: "distribution_type"
      expr: distribution_type
      comment: "Type of distribution (e.g., Direct, Partner-Led, Cash-Based) — used to analyze modality effectiveness."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used for delivery (e.g., Road, Air, River) — used for logistics cost and risk analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the distribution order — used to track emergency vs. routine delivery performance."
    - name: "emergency_response_flag"
      expr: emergency_response_flag
      comment: "Indicates whether this order is part of an emergency response — used to segment emergency vs. development programming."
    - name: "cold_chain_required_flag"
      expr: cold_chain_required_flag
      comment: "Indicates whether cold chain logistics are required — used to assess cold chain compliance and cost."
    - name: "medical_supplies_flag"
      expr: medical_supplies_flag
      comment: "Indicates whether the order contains medical supplies — used for health program supply tracking."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the distribution order was created — enables monthly distribution trend analysis."
    - name: "in_kind_donation_flag"
      expr: in_kind_donation_flag
      comment: "Indicates whether the distribution involves in-kind donated goods — used for in-kind program reporting."
  measures:
    - name: "total_estimated_value_usd"
      expr: SUM(CAST(estimated_value_usd AS DOUBLE))
      comment: "Total estimated value of goods distributed — primary financial KPI for program expenditure and donor reporting."
    - name: "total_transport_cost_usd"
      expr: SUM(CAST(transport_cost_usd AS DOUBLE))
      comment: "Total transport costs for distribution orders — measures last-mile logistics expenditure."
    - name: "total_weight_distributed_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of goods distributed in kilograms — measures physical distribution throughput."
    - name: "total_volume_distributed_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volume of goods distributed in cubic meters — used for logistics capacity planning."
    - name: "avg_transport_cost_per_order_usd"
      expr: AVG(CAST(transport_cost_usd AS DOUBLE))
      comment: "Average transport cost per distribution order — benchmarks logistics efficiency across routes and modalities."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_delivery_date <= scheduled_delivery_date AND actual_delivery_date IS NOT NULL THEN distribution_order_id END) / NULLIF(COUNT(CASE WHEN scheduled_delivery_date IS NOT NULL THEN distribution_order_id END), 0), 2)
      comment: "Percentage of distribution orders delivered on or before the scheduled date — key last-mile performance KPI."
    - name: "avg_delivery_lead_time_days"
      expr: AVG(CAST(DATEDIFF(actual_delivery_date, order_date) AS DOUBLE))
      comment: "Average days from order creation to actual delivery — measures end-to-end distribution cycle time."
    - name: "emergency_order_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN emergency_response_flag = TRUE THEN distribution_order_id END) / NULLIF(COUNT(distribution_order_id), 0), 2)
      comment: "Percentage of distribution orders classified as emergency response — tracks humanitarian surge demand."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`supply_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply chain flow and stock movement KPIs — tracks commodity flows, loss rates, transport costs, and movement patterns to ensure supply chain integrity and accountability."
  source: "`ngo_ecm`.`supply`.`stock_movement`"
  dimensions:
    - name: "movement_type"
      expr: movement_type
      comment: "Type of stock movement (e.g., Receipt, Issue, Transfer, Adjustment, Loss) — primary dimension for supply chain flow analysis."
    - name: "movement_status"
      expr: movement_status
      comment: "Current status of the stock movement — used to filter confirmed vs. pending movements."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection outcome for the movement — tracks quality compliance across the supply chain."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the stock movement — used to categorize losses, adjustments, and transfers for root cause analysis."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used for the movement — used for logistics cost and risk analysis."
    - name: "in_kind_donation_flag"
      expr: in_kind_donation_flag
      comment: "Indicates whether the movement involves in-kind donated goods — used for in-kind asset tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the movement valuation — required for multi-currency financial consolidation."
    - name: "movement_month"
      expr: DATE_TRUNC('MONTH', movement_date)
      comment: "Month of the stock movement — enables monthly throughput and loss trend analysis."
  measures:
    - name: "total_movement_value_usd"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total value of all stock movements — measures the financial scale of supply chain activity."
    - name: "total_quantity_moved"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of goods moved across all movement types — measures supply chain throughput volume."
    - name: "total_loss_value_usd"
      expr: SUM(CASE WHEN movement_type IN ('Loss', 'Damage', 'Expiry', 'Write-Off') THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total value of stock losses, damage, and write-offs — critical KPI for supply chain integrity and donor accountability."
    - name: "loss_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN movement_type IN ('Loss', 'Damage', 'Expiry', 'Write-Off') THEN CAST(quantity AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of total moved quantity classified as loss or damage — key supply chain quality and accountability KPI."
    - name: "avg_unit_cost_usd"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across all stock movements — used for cost benchmarking and valuation consistency checks."
    - name: "distinct_commodities_moved"
      expr: COUNT(DISTINCT commodity_id)
      comment: "Number of distinct commodities with stock movements — measures supply chain breadth and commodity diversity."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`supply_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "International and domestic shipment performance KPIs — tracks freight costs, transit times, customs clearance, and cargo volumes to optimize logistics operations and donor compliance."
  source: "`ngo_ecm`.`supply`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (e.g., In Transit, Delivered, Delayed, Customs Hold) — primary filter for shipment pipeline analysis."
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of shipment (e.g., Air Freight, Sea Freight, Road) — used to analyze cost and speed trade-offs."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (e.g., Air, Sea, Road, Rail) — primary logistics cost driver dimension."
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Status of customs clearance — tracks import compliance and clearance bottlenecks affecting delivery."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country of the shipment — enables geographic analysis of logistics flows and costs."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Origin country of the shipment — used to analyze procurement source geography."
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Indicates whether the shipment requires temperature-controlled transport — used for cold chain compliance tracking."
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms governing delivery responsibility — used for cost attribution and risk analysis."
    - name: "shipment_month"
      expr: DATE_TRUNC('MONTH', estimated_departure_date)
      comment: "Month of estimated departure — enables monthly shipment volume and cost trend analysis."
  measures:
    - name: "total_freight_cost_usd"
      expr: SUM(CAST(freight_cost_usd AS DOUBLE))
      comment: "Total freight cost across all shipments — primary logistics cost KPI for budget management and cost efficiency analysis."
    - name: "total_insured_value_usd"
      expr: SUM(CAST(insured_value_usd AS DOUBLE))
      comment: "Total insured value of shipments — measures financial risk exposure in the logistics pipeline."
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(total_cargo_weight_kg AS DOUBLE))
      comment: "Total cargo weight shipped in kilograms — measures logistics throughput volume."
    - name: "total_cargo_volume_m3"
      expr: SUM(CAST(total_cargo_volume_m3 AS DOUBLE))
      comment: "Total cargo volume shipped in cubic meters — used for container utilization and capacity planning."
    - name: "avg_freight_cost_per_kg_usd"
      expr: ROUND(SUM(CAST(freight_cost_usd AS DOUBLE)) / NULLIF(SUM(CAST(total_cargo_weight_kg AS DOUBLE)), 0), 4)
      comment: "Average freight cost per kilogram — key logistics efficiency KPI for benchmarking transport costs across modes and routes."
    - name: "avg_transit_time_days"
      expr: AVG(CAST(DATEDIFF(actual_arrival_date, actual_departure_date) AS DOUBLE))
      comment: "Average transit time in days from departure to arrival — measures logistics speed and identifies route delays."
    - name: "customs_delay_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN customs_clearance_status IN ('Pending', 'On Hold', 'Delayed') THEN shipment_id END) / NULLIF(COUNT(shipment_id), 0), 2)
      comment: "Percentage of shipments experiencing customs delays — tracks import compliance risk and clearance efficiency."
    - name: "on_time_arrival_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_arrival_date <= estimated_arrival_date AND actual_arrival_date IS NOT NULL THEN shipment_id END) / NULLIF(COUNT(CASE WHEN estimated_arrival_date IS NOT NULL THEN shipment_id END), 0), 2)
      comment: "Percentage of shipments arriving on or before estimated arrival date — measures carrier and logistics reliability."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`supply_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor qualification and performance KPIs — tracks vendor prequalification status, performance scores, blacklist risk, and capacity to govern the supplier base for humanitarian procurement compliance."
  source: "`ngo_ecm`.`supply`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current status of the vendor (e.g., Active, Suspended, Blacklisted, Inactive) — primary filter for approved vendor base analysis."
    - name: "vendor_type"
      expr: vendor_type
      comment: "Type of vendor (e.g., Supplier, Transporter, Service Provider) — used to segment vendor base by category."
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Vendor prequalification status — tracks compliance with procurement eligibility requirements."
    - name: "performance_tier"
      expr: performance_tier
      comment: "Performance tier classification of the vendor — used for strategic sourcing and vendor development decisions."
    - name: "country_of_operation"
      expr: country_of_operation
      comment: "Country where the vendor primarily operates — enables geographic vendor base analysis."
    - name: "blacklist_flag"
      expr: blacklist_flag
      comment: "Indicates whether the vendor is blacklisted — critical compliance dimension for procurement risk management."
    - name: "gmp_certification_flag"
      expr: gmp_certification_flag
      comment: "Indicates whether the vendor holds Good Manufacturing Practice certification — used for pharmaceutical and medical supply sourcing."
  measures:
    - name: "active_vendor_count"
      expr: COUNT(CASE WHEN vendor_status = 'Active' THEN vendor_id END)
      comment: "Number of active vendors in the approved supplier base — measures supply market depth and sourcing options."
    - name: "prequalified_vendor_count"
      expr: COUNT(CASE WHEN prequalification_status = 'Approved' THEN vendor_id END)
      comment: "Number of prequalified vendors — tracks the size of the compliant, eligible supplier pool for competitive procurement."
    - name: "blacklisted_vendor_count"
      expr: COUNT(CASE WHEN blacklist_flag = TRUE THEN vendor_id END)
      comment: "Number of blacklisted vendors — critical compliance KPI; any increase triggers immediate procurement risk review."
    - name: "avg_performance_score"
      expr: AVG(CAST(last_performance_score AS DOUBLE))
      comment: "Average vendor performance score — measures overall supplier base quality and identifies underperforming vendors."
    - name: "avg_warehouse_capacity_sqm"
      expr: AVG(CAST(warehouse_capacity_sqm AS DOUBLE))
      comment: "Average warehouse capacity of vendors in square meters — assesses vendor storage capability for large-scale procurement."
    - name: "prequalification_expiry_risk_count"
      expr: COUNT(CASE WHEN prequalification_expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN vendor_id END)
      comment: "Number of vendors whose prequalification expires within 90 days — proactive compliance risk indicator to prevent procurement disruption."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`supply_waybill`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Last-mile delivery accountability KPIs — tracks waybill discrepancies, delivery confirmation, transport costs, and cold chain compliance to ensure humanitarian goods reach intended beneficiaries."
  source: "`ngo_ecm`.`supply`.`waybill`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the waybill shipment — primary filter for delivery pipeline analysis."
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of shipment on the waybill — used to segment delivery modalities."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the waybill delivery — used to track emergency vs. routine delivery performance."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates whether temperature-controlled transport was required — used for cold chain compliance tracking."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates whether the waybill covers hazardous materials — used for safety compliance monitoring."
    - name: "receipt_signature_captured_flag"
      expr: receipt_signature_captured_flag
      comment: "Indicates whether a delivery receipt signature was captured — measures last-mile accountability documentation."
    - name: "seal_intact_flag"
      expr: seal_intact_flag
      comment: "Indicates whether the shipment seal was intact on arrival — tracks cargo security and tamper evidence."
    - name: "dispatch_month"
      expr: DATE_TRUNC('MONTH', dispatch_date)
      comment: "Month of dispatch — enables monthly delivery volume and performance trend analysis."
  measures:
    - name: "total_transport_cost_usd"
      expr: SUM(CAST(transport_cost_amount AS DOUBLE))
      comment: "Total transport cost across all waybills — measures last-mile logistics expenditure."
    - name: "total_dispatched_quantity"
      expr: SUM(CAST(total_dispatched_quantity AS DOUBLE))
      comment: "Total quantity dispatched on waybills — measures outbound supply volume from warehouses."
    - name: "total_received_quantity"
      expr: SUM(CAST(total_received_quantity AS DOUBLE))
      comment: "Total quantity confirmed received at destination — measures actual delivery volume."
    - name: "total_discrepancy_quantity"
      expr: SUM(CAST(discrepancy_quantity AS DOUBLE))
      comment: "Total quantity discrepancy between dispatched and received — measures in-transit losses and accountability gaps."
    - name: "delivery_accuracy_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(total_dispatched_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of dispatched quantity confirmed received — key last-mile accountability KPI for donor reporting and loss prevention."
    - name: "signature_capture_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN receipt_signature_captured_flag = TRUE THEN waybill_id END) / NULLIF(COUNT(waybill_id), 0), 2)
      comment: "Percentage of deliveries with captured receipt signatures — measures last-mile documentation compliance and beneficiary accountability."
    - name: "avg_distance_km"
      expr: AVG(CAST(distance_km AS DOUBLE))
      comment: "Average delivery distance in kilometers — used for logistics cost modeling and route optimization."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_delivery_date <= estimated_delivery_date AND actual_delivery_date IS NOT NULL THEN waybill_id END) / NULLIF(COUNT(CASE WHEN estimated_delivery_date IS NOT NULL THEN waybill_id END), 0), 2)
      comment: "Percentage of waybills delivered on or before estimated delivery date — measures last-mile delivery reliability."
$$;