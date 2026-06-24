-- Metric views for domain: supply | Business: Ngo | Version: 2 | Generated on: 2026-06-23 01:23:48

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic procurement spend and cycle-time KPIs over purchase orders. Supports procurement efficiency reviews, donor visibility reporting, and ERP (SAP/VISION, ICON) reconciliation for UN agencies and INGOs. Tracks total committed spend, emergency procurement rates, and approval workflow health."
  source: "`vibe_ngo_v1`.`supply`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current lifecycle status of the purchase order (e.g. Draft, Approved, Closed, Cancelled) — primary filter for pipeline vs. completed spend analysis."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g. Standard, Emergency, Framework Call-Off) — used to segment procurement modality."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method applied (e.g. Competitive Bidding, Sole Source, Framework Agreement) — critical for donor compliance and audit reporting."
    - name: "commodity_category"
      expr: commodity_category
      comment: "High-level commodity category of the order — enables spend analysis by supply category (NFI, Medical, Food, WASH)."
    - name: "emergency_flag"
      expr: emergency_flag
      comment: "Indicates whether the PO was raised under emergency procurement procedures — used to track emergency vs. planned procurement ratio."
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms governing delivery responsibility — affects logistics cost attribution."
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of goods receipt against this PO — used to identify open/undelivered orders and pipeline risk."
    - name: "approval_workflow_status"
      expr: approval_workflow_status
      comment: "Current approval workflow state — identifies bottlenecks in the procurement authorization pipeline."
    - name: "po_date_month"
      expr: DATE_TRUNC('month', po_date)
      comment: "Month of PO issuance — enables monthly procurement spend trend analysis."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Whether this PO is visible to the donor for reporting purposes — used in donor compliance dashboards."
  measures:
    - name: "total_po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders — baseline volume metric for procurement throughput monitoring."
    - name: "total_committed_spend_usd"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total committed procurement spend in transaction currency — primary financial KPI for procurement budget utilization and donor spend reporting."
    - name: "total_freight_cost_usd"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight charges across all purchase orders — used to monitor logistics cost as a share of total procurement spend."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charges on purchase orders — relevant for duty exemption tracking and cost recovery analysis."
    - name: "avg_po_value_usd"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average value per purchase order — used to benchmark procurement scale and identify outlier orders requiring additional scrutiny."
    - name: "emergency_po_count"
      expr: COUNT(CASE WHEN emergency_flag = TRUE THEN 1 END)
      comment: "Number of purchase orders raised under emergency procurement — high emergency rates signal supply chain fragility or planning gaps."
    - name: "emergency_po_spend_usd"
      expr: SUM(CASE WHEN emergency_flag = TRUE THEN total_amount ELSE 0 END)
      comment: "Total spend on emergency purchase orders — emergency procurement typically carries higher unit costs and reduced competition; executives use this to assess procurement risk exposure."
    - name: "donor_visible_po_spend_usd"
      expr: SUM(CASE WHEN donor_visibility_flag = TRUE THEN total_amount ELSE 0 END)
      comment: "Total spend on donor-visible purchase orders — used to prepare donor financial reports and ensure traceability of restricted funds."
    - name: "subtotal_spend_usd"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of pre-tax, pre-freight subtotals — used to isolate commodity cost from logistics and tax components in spend analysis."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors used — measures supplier diversification; low counts may indicate over-reliance on single suppliers, a procurement risk."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt quality, discrepancy, and cold-chain compliance KPIs. Supports warehouse receiving operations, quality assurance, and donor accountability reporting. Relevant to SAP/VISION goods receipt workflows and UNICEF/WFP supply chain audit requirements."
  source: "`vibe_ngo_v1`.`supply`.`goods_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Current status of the goods receipt (e.g. Pending, Accepted, Rejected, Partial) — primary filter for open receiving pipeline."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection outcome — used to track inspection pass/fail rates and identify quality issues by commodity or vendor."
    - name: "condition_on_arrival"
      expr: condition_on_arrival
      comment: "Physical condition of goods on arrival — used to identify transit damage patterns and hold vendors accountable."
    - name: "cold_chain_breach_flag"
      expr: cold_chain_breach_flag
      comment: "Indicates whether a cold chain breach occurred during transit — critical for vaccine and pharmaceutical supply integrity monitoring."
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Indicates a quantity or quality discrepancy between ordered and received goods — used to trigger vendor claims and audit processes."
    - name: "customs_cleared"
      expr: customs_cleared
      comment: "Whether customs clearance has been completed — used to track import pipeline and identify clearance bottlenecks."
    - name: "receipt_date_month"
      expr: DATE_TRUNC('month', receipt_date)
      comment: "Month of goods receipt — enables monthly receiving volume and quality trend analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for received goods — used to normalize quantity metrics across commodity types."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Whether this receipt is reportable to the donor — used in donor supply chain accountability reports."
    - name: "vvm_stage_on_receipt"
      expr: vvm_stage_on_receipt
      comment: "Vaccine Vial Monitor stage recorded at receipt — critical for vaccine cold chain quality assurance and WHO/GAVI compliance."
  measures:
    - name: "total_receipts"
      expr: COUNT(1)
      comment: "Total number of goods receipt transactions — baseline throughput metric for warehouse receiving operations."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of goods received — primary volume KPI for supply pipeline monitoring and inventory replenishment tracking."
    - name: "total_quantity_rejected"
      expr: SUM(CAST(quantity_rejected AS DOUBLE))
      comment: "Total quantity of goods rejected at receipt — high rejection volumes indicate vendor quality issues or transit damage requiring corrective action."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered across receipts — used as denominator for fill-rate and receipt-completeness calculations."
    - name: "total_receipt_cost_usd"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of goods received — used for inventory valuation, budget utilization, and donor financial reporting."
    - name: "total_freight_charges"
      expr: SUM(CAST(freight_charges AS DOUBLE))
      comment: "Total freight charges on received shipments — used to monitor logistics cost burden on supply operations."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of received goods — used to benchmark procurement pricing and detect cost anomalies by commodity or vendor."
    - name: "discrepancy_receipt_count"
      expr: COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END)
      comment: "Number of receipts with quantity or quality discrepancies — used to measure vendor reliability and trigger claims processes."
    - name: "cold_chain_breach_count"
      expr: COUNT(CASE WHEN cold_chain_breach_flag = TRUE THEN 1 END)
      comment: "Number of receipts with cold chain breaches — directly impacts vaccine and pharmaceutical usability; executives use this to assess cold chain integrity risk."
    - name: "distinct_vendor_receipts"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors from whom goods were received — used to assess supplier diversification in the receiving pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_inventory_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse inventory position, stock health, and valuation KPIs. Supports supply planning, stockout prevention, and donor asset reporting. Relevant to WMS systems, UNICEF Supply Division dashboards, and WFP LESS/LESS2 inventory management. Tracks available, reserved, quarantined, and in-transit stock positions."
  source: "`vibe_ngo_v1`.`supply`.`inventory_balance`"
  dimensions:
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for inventory quantities — required for normalizing stock levels across commodity types."
    - name: "pipeline_status"
      expr: pipeline_status
      comment: "Pipeline status of the inventory (e.g. In Stock, In Transit, On Order) — used to assess supply pipeline health."
    - name: "storage_condition"
      expr: storage_condition
      comment: "Storage condition requirement (e.g. Ambient, Cold Chain, Frozen) — used to monitor cold chain capacity utilization."
    - name: "donor_restriction_flag"
      expr: donor_restriction_flag
      comment: "Whether inventory is restricted to specific donor-funded programs — critical for donor compliance and fund traceability."
    - name: "in_kind_donation_flag"
      expr: in_kind_donation_flag
      comment: "Whether inventory originated from an in-kind donation — used for separate valuation and reporting of donated goods."
    - name: "snapshot_date_month"
      expr: DATE_TRUNC('month', snapshot_date)
      comment: "Month of inventory snapshot — enables month-over-month stock level trend analysis."
    - name: "warehouse_location"
      expr: warehouse_location
      comment: "Physical location within the warehouse — used for bin-level stock analysis and space utilization."
    - name: "last_movement_date_month"
      expr: DATE_TRUNC('month', last_movement_date)
      comment: "Month of last stock movement — used to identify slow-moving or stagnant inventory."
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total physical stock on hand across all inventory records — primary stock position KPI for supply planning and replenishment decisions."
    - name: "total_quantity_available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total quantity available for allocation (on hand minus reserved and quarantined) — the actionable stock figure for distribution planning."
    - name: "total_quantity_reserved"
      expr: SUM(CAST(quantity_reserved AS DOUBLE))
      comment: "Total quantity reserved for pending distribution orders — used to assess committed stock and remaining free stock."
    - name: "total_quantity_quarantined"
      expr: SUM(CAST(quantity_quarantined AS DOUBLE))
      comment: "Total quantity held in quarantine pending quality inspection — high quarantine levels signal quality or cold chain issues requiring urgent resolution."
    - name: "total_quantity_in_transit"
      expr: SUM(CAST(quantity_in_transit AS DOUBLE))
      comment: "Total quantity currently in transit between warehouses or to distribution points — used to project near-term stock availability."
    - name: "total_inventory_valuation_usd"
      expr: SUM(CAST(total_valuation AS DOUBLE))
      comment: "Total monetary value of inventory on hand — used for balance sheet reporting, donor asset accountability, and insurance coverage assessment."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of inventory — used to benchmark procurement pricing and detect valuation anomalies."
    - name: "below_reorder_level_count"
      expr: COUNT(CASE WHEN quantity_on_hand < reorder_level THEN 1 END)
      comment: "Number of inventory records where stock is below the reorder threshold — directly triggers procurement action; stockouts in humanitarian supply chains can cost lives."
    - name: "max_stock_level_total"
      expr: SUM(CAST(maximum_stock_level AS DOUBLE))
      comment: "Sum of maximum stock levels across all inventory records — used as denominator for stock utilization rate calculations."
    - name: "distinct_commodity_count"
      expr: COUNT(DISTINCT commodity_id)
      comment: "Number of distinct commodities held in inventory — used to assess portfolio breadth and identify gaps in stock coverage."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock movement velocity, cost, and quality KPIs. Supports real-time supply chain visibility, loss tracking, and donor accountability. Relevant to SAP MM, WFP LESS, and UNICEF Supply Division movement reporting. Tracks inflows, outflows, adjustments, and in-kind donation movements."
  source: "`vibe_ngo_v1`.`supply`.`stock_movement`"
  dimensions:
    - name: "movement_type"
      expr: movement_type
      comment: "Type of stock movement (e.g. Receipt, Issue, Transfer, Adjustment, Loss, Return) — primary dimension for classifying supply chain flows."
    - name: "movement_status"
      expr: movement_status
      comment: "Current status of the movement transaction — used to identify pending, confirmed, or cancelled movements."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the movement (e.g. Expiry, Damage, Distribution, Transfer) — used to analyze loss causes and operational efficiency."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used for the movement — used to analyze logistics cost and lead time by transport type."
    - name: "in_kind_donation_flag"
      expr: in_kind_donation_flag
      comment: "Whether the movement relates to in-kind donated goods — used for separate tracking and reporting of donated commodity flows."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection outcome for the movement — used to track quality-related losses and rejections."
    - name: "movement_date_month"
      expr: DATE_TRUNC('month', movement_date)
      comment: "Month of stock movement — enables monthly throughput and loss trend analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the movement quantity — required for cross-commodity volume comparisons."
  measures:
    - name: "total_movement_count"
      expr: COUNT(1)
      comment: "Total number of stock movement transactions — baseline throughput metric for supply chain activity monitoring."
    - name: "total_quantity_moved"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved across all movement types — primary volume KPI for supply chain throughput analysis."
    - name: "total_movement_cost_usd"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of stock movements — used for inventory valuation, cost-of-goods-distributed reporting, and donor financial accountability."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across movements — used to detect pricing anomalies and benchmark commodity costs over time."
    - name: "loss_adjustment_count"
      expr: COUNT(CASE WHEN movement_type IN ('Loss', 'Adjustment', 'Write-Off', 'Expiry') THEN 1 END)
      comment: "Number of loss or adjustment movements — high counts indicate quality, storage, or handling issues requiring management intervention."
    - name: "loss_adjustment_cost_usd"
      expr: SUM(CASE WHEN movement_type IN ('Loss', 'Adjustment', 'Write-Off', 'Expiry') THEN total_cost ELSE 0 END)
      comment: "Total cost of stock losses and adjustments — a key accountability metric for donors and auditors; unexplained losses trigger compliance investigations."
    - name: "in_kind_quantity_moved"
      expr: SUM(CASE WHEN in_kind_donation_flag = TRUE THEN quantity ELSE 0 END)
      comment: "Total quantity of in-kind donated goods moved — used for donor acknowledgment reporting and IATI transaction reporting."
    - name: "distinct_commodity_movements"
      expr: COUNT(DISTINCT commodity_id)
      comment: "Number of distinct commodities with movement activity — used to assess supply chain breadth and identify inactive commodity lines."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_distribution_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Last-mile distribution execution KPIs including delivery performance, beneficiary reach, and transport cost. Supports field operations dashboards, cluster coordination reporting, and donor last-mile accountability. Relevant to UNICEF/WFP distribution tracking, Kobo Toolbox post-distribution monitoring, and SAP logistics modules."
  source: "`vibe_ngo_v1`.`supply`.`distribution_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the distribution order (e.g. Planned, Dispatched, Delivered, Cancelled) — primary filter for delivery pipeline monitoring."
    - name: "distribution_type"
      expr: distribution_type
      comment: "Type of distribution (e.g. Direct, Partner-Led, Mobile, Fixed Point) — used to analyze delivery modality effectiveness."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used for delivery — used to analyze logistics cost and lead time by transport type."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the distribution order — used to ensure high-priority emergency distributions are tracked separately."
    - name: "emergency_response_flag"
      expr: emergency_response_flag
      comment: "Whether this order is part of an emergency response — used to separate emergency from development programming in performance reporting."
    - name: "cold_chain_required_flag"
      expr: cold_chain_required_flag
      comment: "Whether cold chain is required for this distribution — used to plan cold chain logistics and monitor compliance."
    - name: "in_kind_donation_flag"
      expr: in_kind_donation_flag
      comment: "Whether the distribution involves in-kind donated goods — used for donor acknowledgment and IATI reporting."
    - name: "order_date_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month of order creation — enables monthly distribution volume trend analysis."
    - name: "nfi_flag"
      expr: nfi_flag
      comment: "Whether the order contains Non-Food Items — used to segment distribution reporting by commodity type."
    - name: "medical_supplies_flag"
      expr: medical_supplies_flag
      comment: "Whether the order contains medical supplies — used to track health supply distribution separately for health cluster reporting."
  measures:
    - name: "total_distribution_orders"
      expr: COUNT(1)
      comment: "Total number of distribution orders — baseline throughput metric for last-mile delivery operations."
    - name: "total_quantity_distributed"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total quantity of commodities distributed — primary volume KPI for supply chain output and program reach reporting."
    - name: "total_estimated_value_usd"
      expr: SUM(CAST(estimated_value_usd AS DOUBLE))
      comment: "Total estimated value of goods distributed — used for donor financial reporting and cost-per-beneficiary calculations."
    - name: "total_transport_cost_usd"
      expr: SUM(CAST(transport_cost_usd AS DOUBLE))
      comment: "Total transport cost for distribution orders — used to monitor last-mile logistics cost efficiency and benchmark against program budgets."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of goods distributed in kilograms — used for logistics planning, vehicle load optimization, and freight cost analysis."
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volume of goods distributed in cubic meters — used for warehouse space planning and container/vehicle capacity optimization."
    - name: "emergency_order_count"
      expr: COUNT(CASE WHEN emergency_response_flag = TRUE THEN 1 END)
      comment: "Number of emergency distribution orders — used to track emergency response scale and resource mobilization speed."
    - name: "emergency_order_value_usd"
      expr: SUM(CASE WHEN emergency_response_flag = TRUE THEN estimated_value_usd ELSE 0 END)
      comment: "Total value of emergency distribution orders — used to report emergency response investment to donors and cluster coordinators."
    - name: "avg_transport_cost_per_order"
      expr: AVG(CAST(transport_cost_usd AS DOUBLE))
      comment: "Average transport cost per distribution order — used to benchmark last-mile delivery efficiency and identify high-cost routes."
    - name: "distinct_project_sites_served"
      expr: COUNT(DISTINCT project_site_id)
      comment: "Number of distinct project sites receiving distributions — measures geographic reach of supply operations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_procurement_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement pipeline, approval cycle, and spend authorization KPIs. Supports procurement planning, budget control, and compliance monitoring. Relevant to SAP SRM/MM, ICON procurement system, and donor prior-approval tracking for USAID, EU, and UN-funded programs."
  source: "`vibe_ngo_v1`.`supply`.`procurement_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Current status of the procurement request (e.g. Draft, Submitted, Approved, Rejected, Cancelled) — primary filter for pipeline monitoring."
    - name: "request_type"
      expr: request_type
      comment: "Type of procurement request (e.g. Goods, Services, Works) — used to segment procurement pipeline by category."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency classification of the request — used to prioritize processing and identify emergency procurement patterns."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Commodity category of the requested items — used for spend analysis and category management."
    - name: "approval_level_required"
      expr: approval_level_required
      comment: "Required approval authority level — used to analyze approval bottlenecks by authorization tier."
    - name: "local_procurement_preference"
      expr: local_procurement_preference
      comment: "Whether local procurement is preferred — used to track localization of supply chains, a key OECD/DAC and Grand Bargain commitment."
    - name: "compliance_check_required"
      expr: compliance_check_required
      comment: "Whether a compliance check is required before approval — used to monitor compliance gate adherence."
    - name: "request_date_month"
      expr: DATE_TRUNC('month', request_date)
      comment: "Month of request submission — enables monthly procurement pipeline trend analysis."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Whether this request is visible to the donor — used in donor procurement compliance reporting."
  measures:
    - name: "total_requests"
      expr: COUNT(1)
      comment: "Total number of procurement requests — baseline pipeline volume metric for procurement workload management."
    - name: "total_estimated_cost_usd"
      expr: SUM(CAST(estimated_total_cost AS DOUBLE))
      comment: "Total estimated cost of all procurement requests — used for budget commitment forecasting and procurement pipeline valuation."
    - name: "avg_estimated_unit_cost"
      expr: AVG(CAST(estimated_unit_cost AS DOUBLE))
      comment: "Average estimated unit cost across requests — used to benchmark pricing expectations and detect cost escalation trends."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total quantity requested across all procurement requests — used for demand aggregation and framework agreement utilization planning."
    - name: "approved_request_count"
      expr: COUNT(CASE WHEN request_status = 'Approved' THEN 1 END)
      comment: "Number of approved procurement requests — used to measure approval throughput and identify processing bottlenecks."
    - name: "approved_spend_usd"
      expr: SUM(CASE WHEN request_status = 'Approved' THEN estimated_total_cost ELSE 0 END)
      comment: "Total estimated spend on approved requests — used for committed budget tracking and cash flow forecasting."
    - name: "rejected_request_count"
      expr: COUNT(CASE WHEN request_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected procurement requests — high rejection rates indicate poor request quality or budget constraint issues requiring management attention."
    - name: "local_procurement_request_count"
      expr: COUNT(CASE WHEN local_procurement_preference = TRUE THEN 1 END)
      comment: "Number of requests with local procurement preference — used to track progress against Grand Bargain localization commitments."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_rfq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Request for Quotation competition quality, bid responsiveness, and procurement efficiency KPIs. Supports procurement transparency reporting, competition analysis, and value-for-money assessments. Relevant to ICON, SAP SRM, and UN procurement portal reporting requirements."
  source: "`vibe_ngo_v1`.`supply`.`rfq`"
  dimensions:
    - name: "rfq_status"
      expr: rfq_status
      comment: "Current status of the RFQ (e.g. Draft, Published, Closed, Awarded, Cancelled) — primary filter for active vs. completed procurement competitions."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method applied (e.g. Open Tender, Restricted Tender, Direct Procurement) — used for competition analysis and compliance reporting."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Type of procurement (e.g. Goods, Services, Works) — used to segment RFQ pipeline by category."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Commodity category of the RFQ — used for category-level competition and pricing analysis."
    - name: "emergency_procurement"
      expr: emergency_procurement
      comment: "Whether this is an emergency procurement — used to track emergency vs. planned procurement competition rates."
    - name: "incoterm"
      expr: incoterm
      comment: "Delivery terms specified in the RFQ — affects total cost of ownership analysis."
    - name: "issue_date_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month of RFQ issuance — enables monthly procurement activity trend analysis."
    - name: "donor_visibility"
      expr: donor_visibility
      comment: "Whether the RFQ is visible to donors — used in donor procurement transparency reporting."
  measures:
    - name: "total_rfq_count"
      expr: COUNT(1)
      comment: "Total number of RFQs issued — baseline procurement activity metric."
    - name: "total_estimated_budget_usd"
      expr: SUM(CAST(estimated_budget_amount AS DOUBLE))
      comment: "Total estimated budget across all RFQs — used for procurement pipeline valuation and budget commitment forecasting."
    - name: "total_awarded_amount_usd"
      expr: SUM(CAST(awarded_amount AS DOUBLE))
      comment: "Total value awarded through RFQ competitions — primary financial outcome metric for procurement value-for-money analysis."
    - name: "avg_awarded_amount_usd"
      expr: AVG(CAST(awarded_amount AS DOUBLE))
      comment: "Average award value per RFQ — used to benchmark procurement scale and identify outlier contracts."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total quantity requested across all RFQs — used for demand aggregation and supplier capacity planning."
    - name: "emergency_rfq_count"
      expr: COUNT(CASE WHEN emergency_procurement = TRUE THEN 1 END)
      comment: "Number of emergency procurement RFQs — high rates indicate reactive rather than planned procurement, typically resulting in higher costs."
    - name: "avg_evaluation_criteria_score"
      expr: AVG(CAST(evaluation_criteria AS DOUBLE))
      comment: "Average evaluation criteria weighting — used to monitor consistency of technical vs. financial evaluation balance across procurements."
    - name: "avg_payment_terms"
      expr: AVG(CAST(payment_terms AS DOUBLE))
      comment: "Average payment terms specified in RFQs — used to assess cash flow implications of procurement contracts."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_bid`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor bid competition quality, scoring, and award KPIs. Supports procurement transparency, value-for-money analysis, and vendor performance benchmarking. Relevant to UN procurement portal, ICON, and SAP SRM bid evaluation workflows."
  source: "`vibe_ngo_v1`.`supply`.`bid`"
  dimensions:
    - name: "bid_status"
      expr: bid_status
      comment: "Current status of the bid (e.g. Submitted, Under Evaluation, Awarded, Rejected) — primary filter for bid pipeline analysis."
    - name: "awarded_flag"
      expr: awarded_flag
      comment: "Whether this bid was awarded the contract — used to calculate award rates and analyze winning bid characteristics."
    - name: "currency"
      expr: currency
      comment: "Currency of the bid amount — used for multi-currency procurement analysis and exchange rate risk assessment."
    - name: "submission_date_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month of bid submission — enables monthly bid activity trend analysis."
  measures:
    - name: "total_bids_received"
      expr: COUNT(1)
      comment: "Total number of bids received — baseline competition metric; low bid counts may indicate market access barriers or restrictive specifications."
    - name: "total_bid_amount_usd"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total value of all bids received — used to assess market pricing range and competition depth."
    - name: "avg_bid_amount_usd"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average bid amount — used to benchmark market pricing and assess value-for-money of awarded contracts."
    - name: "avg_technical_score"
      expr: AVG(CAST(technical_score AS DOUBLE))
      comment: "Average technical evaluation score across bids — used to assess vendor technical capability and specification compliance."
    - name: "avg_financial_score"
      expr: AVG(CAST(financial_score AS DOUBLE))
      comment: "Average financial evaluation score — used to assess price competitiveness across the vendor pool."
    - name: "avg_total_score"
      expr: AVG(CAST(total_score AS DOUBLE))
      comment: "Average combined evaluation score — used to benchmark overall bid quality and identify consistently high-performing vendors."
    - name: "awarded_bid_count"
      expr: COUNT(CASE WHEN awarded_flag = TRUE THEN 1 END)
      comment: "Number of bids that were awarded — used as numerator for award rate calculations."
    - name: "awarded_bid_value_usd"
      expr: SUM(CASE WHEN awarded_flag = TRUE THEN amount ELSE 0 END)
      comment: "Total value of awarded bids — primary financial outcome metric for procurement competition results."
    - name: "distinct_vendors_bidding"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors submitting bids — measures market competition depth; low counts may indicate procurement market concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_framework_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Framework agreement utilization, performance, and value KPIs. Supports strategic sourcing management, vendor relationship oversight, and procurement efficiency reporting. Framework agreements are a primary cost-reduction mechanism for UN agencies and large INGOs, enabling pre-negotiated pricing and rapid procurement."
  source: "`vibe_ngo_v1`.`supply`.`framework_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the framework agreement (e.g. Active, Expired, Suspended, Terminated) — primary filter for active vs. inactive agreements."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of framework agreement (e.g. Long-Term Agreement, Standing Offer, Blanket Purchase Agreement) — used to segment by procurement instrument type."
    - name: "commodity_categories"
      expr: commodity_categories
      comment: "Commodity categories covered by the agreement — used for category management and spend coverage analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the agreement — used to assess coverage of operational areas and identify sourcing gaps."
    - name: "incoterm"
      expr: incoterm
      comment: "Delivery terms in the agreement — affects total cost of ownership and logistics planning."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Whether the agreement is reportable to donors — used in donor procurement transparency reporting."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the agreement became effective — used for agreement portfolio lifecycle analysis."
    - name: "performance_rating"
      expr: performance_rating
      comment: "Vendor performance rating under the agreement — used to segment agreements by vendor performance tier."
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total number of framework agreements — baseline metric for strategic sourcing portfolio size."
    - name: "total_value_utilized_usd"
      expr: SUM(CAST(total_value_utilized AS DOUBLE))
      comment: "Total value of orders placed against framework agreements — primary utilization KPI; low utilization indicates agreements are not being leveraged for cost savings."
    - name: "total_maximum_order_value_usd"
      expr: SUM(CAST(maximum_order_value AS DOUBLE))
      comment: "Total maximum order value capacity across agreements — used as denominator for framework utilization rate calculations."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage negotiated in framework agreements — measures procurement cost savings achieved through strategic sourcing."
    - name: "avg_payment_terms_days"
      expr: AVG(CAST(payment_terms AS DOUBLE))
      comment: "Average payment terms in days across agreements — used to assess cash flow implications of the framework agreement portfolio."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN 1 END)
      comment: "Number of currently active framework agreements — used to assess active sourcing coverage and identify gaps."
    - name: "expiring_agreement_count"
      expr: COUNT(CASE WHEN effective_end_date <= DATE_ADD(CURRENT_DATE(), 90) AND agreement_status = 'Active' THEN 1 END)
      comment: "Number of agreements expiring within 90 days — used to trigger renewal actions and prevent sourcing coverage gaps."
    - name: "distinct_vendors_under_agreement"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with active framework agreements — measures strategic supplier base breadth."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "International and domestic shipment performance, cold chain integrity, and logistics cost KPIs. Supports supply chain visibility, customs clearance monitoring, and donor logistics reporting. Relevant to UNICEF Supply Division, WFP logistics cluster, and freight forwarder management."
  source: "`vibe_ngo_v1`.`supply`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (e.g. In Transit, Delivered, Delayed, Customs Hold) — primary filter for active shipment pipeline monitoring."
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of shipment (e.g. Air, Sea, Road, Multi-Modal) — used to analyze logistics modality mix and cost."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport — used to segment shipment performance and cost by logistics channel."
    - name: "cold_chain_shipment_flag"
      expr: cold_chain_shipment_flag
      comment: "Whether the shipment requires cold chain — used to monitor cold chain logistics performance separately."
    - name: "temperature_excursion_flag"
      expr: temperature_excursion_flag
      comment: "Whether a temperature excursion occurred during shipment — critical for vaccine and pharmaceutical supply integrity."
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Status of customs clearance — used to identify shipments held at customs and quantify clearance delays."
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Whether the shipment is temperature-controlled — used to segment cold chain vs. ambient logistics."
    - name: "estimated_departure_date_month"
      expr: DATE_TRUNC('month', estimated_departure_date)
      comment: "Month of estimated departure — enables monthly shipment volume trend analysis."
    - name: "incoterm"
      expr: incoterm
      comment: "Delivery terms for the shipment — affects cost attribution between sender and receiver."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments — baseline logistics throughput metric."
    - name: "total_freight_cost_usd"
      expr: SUM(CAST(freight_cost_usd AS DOUBLE))
      comment: "Total freight cost across all shipments — primary logistics cost KPI for budget monitoring and cost-per-unit-delivered calculations."
    - name: "total_insured_value_usd"
      expr: SUM(CAST(insured_value_usd AS DOUBLE))
      comment: "Total insured value of shipments — used for insurance coverage adequacy assessment and risk management."
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(total_cargo_weight_kg AS DOUBLE))
      comment: "Total cargo weight shipped in kilograms — used for logistics capacity planning and freight cost benchmarking."
    - name: "total_cargo_volume_m3"
      expr: SUM(CAST(total_cargo_volume_m3 AS DOUBLE))
      comment: "Total cargo volume shipped in cubic meters — used for container utilization and warehouse receiving capacity planning."
    - name: "avg_freight_cost_usd"
      expr: AVG(CAST(freight_cost_usd AS DOUBLE))
      comment: "Average freight cost per shipment — used to benchmark logistics efficiency and identify high-cost routes."
    - name: "cold_chain_shipment_count"
      expr: COUNT(CASE WHEN cold_chain_shipment_flag = TRUE THEN 1 END)
      comment: "Number of cold chain shipments — used to plan cold chain logistics capacity and monitor vaccine supply chain scale."
    - name: "temperature_excursion_count"
      expr: COUNT(CASE WHEN temperature_excursion_flag = TRUE THEN 1 END)
      comment: "Number of shipments with temperature excursions — directly impacts vaccine and pharmaceutical usability; high counts trigger cold chain system reviews."
    - name: "cold_chain_excursion_freight_cost"
      expr: SUM(CASE WHEN temperature_excursion_flag = TRUE THEN freight_cost_usd ELSE 0 END)
      comment: "Total freight cost of shipments that experienced temperature excursions — used to quantify the financial exposure of cold chain failures."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor qualification, performance, and risk KPIs. Supports strategic sourcing, vendor management, and procurement compliance. Relevant to UN vendor registration systems, SAP vendor master, and UNGM (UN Global Marketplace) prequalification tracking. Monitors blacklisted vendors, performance tiers, and prequalification status."
  source: "`vibe_ngo_v1`.`supply`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current status of the vendor (e.g. Active, Suspended, Blacklisted, Pending) — primary filter for eligible vs. ineligible suppliers."
    - name: "vendor_type"
      expr: vendor_type
      comment: "Type of vendor (e.g. Manufacturer, Distributor, Service Provider, Transporter) — used to segment vendor base by supply chain role."
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Vendor prequalification status — used to track qualified supplier pool size and identify gaps in prequalified vendor coverage."
    - name: "performance_tier"
      expr: performance_tier
      comment: "Performance tier classification (e.g. Preferred, Approved, Conditional, Suspended) — used for strategic sourcing decisions and vendor development prioritization."
    - name: "blacklist_flag"
      expr: blacklist_flag
      comment: "Whether the vendor is blacklisted — critical compliance dimension; blacklisted vendors must not receive contracts."
    - name: "gmp_certification_flag"
      expr: gmp_certification_flag
      comment: "Whether the vendor holds Good Manufacturing Practice certification — required for pharmaceutical and medical supply procurement."
    - name: "registration_date_year"
      expr: DATE_TRUNC('year', registration_date)
      comment: "Year of vendor registration — used to analyze vendor base growth and tenure distribution."
  measures:
    - name: "total_vendor_count"
      expr: COUNT(1)
      comment: "Total number of vendors in the registry — baseline metric for supplier base size."
    - name: "active_vendor_count"
      expr: COUNT(CASE WHEN vendor_status = 'Active' THEN 1 END)
      comment: "Number of active vendors — measures available supplier pool for procurement operations."
    - name: "blacklisted_vendor_count"
      expr: COUNT(CASE WHEN blacklist_flag = TRUE THEN 1 END)
      comment: "Number of blacklisted vendors — used for compliance monitoring; any procurement from blacklisted vendors is a critical audit finding."
    - name: "prequalified_vendor_count"
      expr: COUNT(CASE WHEN prequalification_status = 'Prequalified' THEN 1 END)
      comment: "Number of prequalified vendors — measures the qualified supplier pool available for competitive procurement."
    - name: "avg_performance_score"
      expr: AVG(CAST(last_performance_score AS DOUBLE))
      comment: "Average vendor performance score — used to monitor overall supplier base quality and identify underperforming vendors requiring development or replacement."
    - name: "avg_payment_terms_days"
      expr: AVG(CAST(payment_terms_days AS DOUBLE))
      comment: "Average payment terms in days across vendors — used to assess cash flow implications of the vendor portfolio."
    - name: "avg_warehouse_capacity_sqm"
      expr: AVG(CAST(warehouse_capacity_sqm AS DOUBLE))
      comment: "Average warehouse capacity of vendors — used to assess vendor storage capability for large-volume procurement."
    - name: "gmp_certified_vendor_count"
      expr: COUNT(CASE WHEN gmp_certification_flag = TRUE THEN 1 END)
      comment: "Number of GMP-certified vendors — measures qualified pharmaceutical/medical supply vendor pool for health program procurement."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_warehouse`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse capacity, cold chain capability, and operational status KPIs. Supports logistics network planning, cold chain infrastructure assessment, and humanitarian response preparedness. Relevant to UNICEF cold chain equipment management, WFP warehouse management, and cluster logistics coordination."
  source: "`vibe_ngo_v1`.`supply`.`warehouse`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of warehouse facility (e.g. Central, Regional, Field, Partner) — used to segment warehouse network by tier."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (e.g. Owned, Leased, Partner, Government) — used for asset management and cost analysis."
    - name: "cold_chain_capable_flag"
      expr: cold_chain_capable_flag
      comment: "Whether the warehouse has cold chain capability — critical for vaccine and pharmaceutical storage network planning."
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Whether the warehouse is temperature-controlled — used to segment storage capacity by temperature requirement."
    - name: "vaccine_storage_certified_flag"
      expr: vaccine_storage_certified_flag
      comment: "Whether the warehouse is certified for vaccine storage — required for immunization supply chain compliance with WHO/GAVI standards."
    - name: "hazmat_certified"
      expr: hazmat_certified
      comment: "Whether the warehouse is certified for hazardous materials — used for chemical and pharmaceutical supply chain planning."
    - name: "customs_bonded"
      expr: customs_bonded
      comment: "Whether the warehouse is customs-bonded — relevant for import/export logistics and duty deferral planning."
    - name: "security_level"
      expr: security_level
      comment: "Security classification of the warehouse — used for risk assessment and high-value commodity storage planning."
    - name: "cluster_affiliation"
      expr: cluster_affiliation
      comment: "Humanitarian cluster the warehouse supports — used for cluster logistics coordination and shared service planning."
  measures:
    - name: "total_warehouse_count"
      expr: COUNT(1)
      comment: "Total number of warehouses in the network — baseline metric for logistics infrastructure scale."
    - name: "total_storage_capacity_m3"
      expr: SUM(CAST(storage_capacity_m3 AS DOUBLE))
      comment: "Total storage capacity in cubic meters across the warehouse network — primary capacity planning KPI for supply chain infrastructure."
    - name: "total_cold_chain_capacity_liters"
      expr: SUM(CAST(cold_chain_capacity_liters AS DOUBLE))
      comment: "Total cold chain storage capacity in liters — critical for vaccine supply chain planning and GAVI/WHO cold chain adequacy assessments."
    - name: "cold_chain_warehouse_count"
      expr: COUNT(CASE WHEN cold_chain_capable_flag = TRUE THEN 1 END)
      comment: "Number of warehouses with cold chain capability — used to assess cold chain network coverage and identify geographic gaps."
    - name: "vaccine_certified_warehouse_count"
      expr: COUNT(CASE WHEN vaccine_storage_certified_flag = TRUE THEN 1 END)
      comment: "Number of vaccine-storage-certified warehouses — measures compliance with WHO/GAVI immunization supply chain standards."
    - name: "avg_storage_capacity_m3"
      expr: AVG(CAST(storage_capacity_m3 AS DOUBLE))
      comment: "Average storage capacity per warehouse — used to benchmark facility size and identify under-capacity locations."
    - name: "avg_gis_accuracy_meters"
      expr: AVG(CAST(gis_accuracy_meters AS DOUBLE))
      comment: "Average GIS coordinate accuracy in meters — used to assess location data quality for logistics routing and mapping."
    - name: "emergency_access_warehouse_count"
      expr: COUNT(CASE WHEN emergency_access_24_7 = TRUE THEN 1 END)
      comment: "Number of warehouses with 24/7 emergency access — measures humanitarian response readiness of the logistics network."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_distribution_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution planning coverage, budget, and readiness KPIs. Supports program planning, cluster coordination, and donor reporting on planned vs. actual distribution. Relevant to eTools programme management, UNICEF supply planning, and WFP distribution planning systems."
  source: "`vibe_ngo_v1`.`supply`.`distribution_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the distribution plan (e.g. Draft, Approved, Active, Completed, Cancelled) — primary filter for active planning pipeline."
    - name: "distribution_modality"
      expr: distribution_modality
      comment: "Distribution modality (e.g. Direct, Cash-Based, Partner-Led, Mobile) — used to analyze modality mix and cost-effectiveness."
    - name: "distribution_type"
      expr: distribution_type
      comment: "Type of distribution (e.g. Emergency, Routine, Seasonal) — used to segment planning by response type."
    - name: "distribution_frequency"
      expr: distribution_frequency
      comment: "Frequency of distribution (e.g. Monthly, Quarterly, One-Time) — used for logistics scheduling and resource planning."
    - name: "beneficiary_category"
      expr: beneficiary_category
      comment: "Target beneficiary category (e.g. IDPs, Refugees, Host Community) — used to analyze distribution coverage by population group."
    - name: "coordination_cluster"
      expr: coordination_cluster
      comment: "Humanitarian cluster coordinating the distribution — used for cluster-level reporting and inter-agency coordination."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the distribution plan — used to prioritize risk mitigation and contingency planning."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Whether donor or management approval is required — used to track approval pipeline and identify bottlenecks."
    - name: "planned_start_date_month"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month of planned distribution start — enables monthly distribution pipeline trend analysis."
    - name: "security_clearance_required"
      expr: security_clearance_required
      comment: "Whether security clearance is required for the distribution — used to identify access-constrained distributions requiring additional planning."
  measures:
    - name: "total_plans"
      expr: COUNT(1)
      comment: "Total number of distribution plans — baseline planning pipeline metric."
    - name: "total_estimated_budget_usd"
      expr: SUM(CAST(estimated_budget_amount AS DOUBLE))
      comment: "Total estimated budget across all distribution plans — primary financial planning KPI for distribution program budgeting."
    - name: "avg_estimated_budget_usd"
      expr: AVG(CAST(estimated_budget_amount AS DOUBLE))
      comment: "Average estimated budget per distribution plan — used to benchmark distribution cost and identify outlier plans."
    - name: "total_estimated_weight_kg"
      expr: SUM(CAST(estimated_total_weight_kg AS DOUBLE))
      comment: "Total estimated cargo weight across all plans — used for logistics capacity planning and transport procurement."
    - name: "total_estimated_volume_m3"
      expr: SUM(CAST(estimated_total_volume_m3 AS DOUBLE))
      comment: "Total estimated cargo volume across all plans — used for warehouse space and vehicle capacity planning."
    - name: "approved_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'Approved' THEN 1 END)
      comment: "Number of approved distribution plans — measures planning readiness and approval throughput."
    - name: "security_clearance_required_count"
      expr: COUNT(CASE WHEN security_clearance_required = TRUE THEN 1 END)
      comment: "Number of plans requiring security clearance — used to assess access constraints and plan humanitarian access strategies."
    - name: "distinct_project_sites_planned"
      expr: COUNT(DISTINCT project_site_id)
      comment: "Number of distinct project sites covered by distribution plans — measures geographic planning coverage."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_inkind_donation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "In-kind donation valuation, quality, and compliance KPIs. Supports donor acknowledgment, IATI reporting, and ASC 958 / IPSAS 23 non-cash contribution accounting. Tracks fair market value, quality inspection outcomes, and restricted use compliance for donated goods."
  source: "`vibe_ngo_v1`.`supply`.`inkind_donation`"
  dimensions:
    - name: "acknowledgment_status"
      expr: acknowledgment_status
      comment: "Status of donor acknowledgment for the in-kind donation — used to ensure timely donor recognition and compliance with gift acknowledgment requirements."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Whether the donated goods have been allocated to a program — used to track utilization of donated inventory."
    - name: "condition_status"
      expr: condition_status
      comment: "Physical condition of donated goods — used to assess usability and inform valuation."
    - name: "quality_inspection_flag"
      expr: quality_inspection_flag
      comment: "Whether a quality inspection was conducted — used to monitor inspection compliance for donated goods."
    - name: "quality_inspection_result"
      expr: quality_inspection_result
      comment: "Outcome of quality inspection — used to track acceptance/rejection rates for donated goods."
    - name: "restricted_use_flag"
      expr: restricted_use_flag
      comment: "Whether the donation has restricted use conditions — used to ensure compliance with donor restrictions."
    - name: "iati_reporting_flag"
      expr: iati_reporting_flag
      comment: "Whether this donation must be reported in IATI — used to ensure IATI transparency compliance."
    - name: "donor_type"
      expr: donor_type
      comment: "Type of donor (e.g. Corporate, Government, Individual, Foundation) — used to segment in-kind donation portfolio by source."
    - name: "valuation_method"
      expr: valuation_method
      comment: "Method used to value the donation (e.g. Fair Market Value, Replacement Cost, Donor-Stated) — used for accounting consistency and audit compliance."
    - name: "receipt_date_month"
      expr: DATE_TRUNC('month', receipt_date)
      comment: "Month of donation receipt — enables monthly in-kind donation trend analysis."
  measures:
    - name: "total_inkind_donations"
      expr: COUNT(1)
      comment: "Total number of in-kind donation records — baseline metric for donation volume tracking."
    - name: "total_fair_market_value_usd"
      expr: SUM(CAST(estimated_fair_market_value AS DOUBLE))
      comment: "Total estimated fair market value of in-kind donations — primary financial KPI for non-cash contribution reporting under ASC 958 and IPSAS 23."
    - name: "avg_fair_market_value_usd"
      expr: AVG(CAST(estimated_fair_market_value AS DOUBLE))
      comment: "Average fair market value per in-kind donation — used to benchmark donation size and identify major in-kind contributors."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of in-kind donated goods received — used for inventory planning and program supply coverage analysis."
    - name: "restricted_donation_value_usd"
      expr: SUM(CASE WHEN restricted_use_flag = TRUE THEN estimated_fair_market_value ELSE 0 END)
      comment: "Total value of restricted in-kind donations — used to track compliance with donor use restrictions and ensure proper allocation."
    - name: "iati_reportable_value_usd"
      expr: SUM(CASE WHEN iati_reporting_flag = TRUE THEN estimated_fair_market_value ELSE 0 END)
      comment: "Total value of in-kind donations requiring IATI reporting — used to ensure transparency compliance with IATI publishing standards."
    - name: "quality_inspected_count"
      expr: COUNT(CASE WHEN quality_inspection_flag = TRUE THEN 1 END)
      comment: "Number of in-kind donations that underwent quality inspection — used to monitor inspection compliance rates."
    - name: "distinct_donor_count"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of distinct donors providing in-kind donations — measures breadth of in-kind donor base."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_temperature_excursion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cold chain temperature excursion frequency, severity, and resolution KPIs. Supports vaccine supply chain quality assurance, WHO/GAVI cold chain compliance, and corrective action tracking. Temperature excursions directly threaten vaccine potency and can result in program failure and donor accountability issues."
  source: "`vibe_ngo_v1`.`supply`.`temperature_excursion`"
  dimensions:
    - name: "temperature_excursion_status"
      expr: temperature_excursion_status
      comment: "Current status of the excursion (e.g. Open, Under Investigation, Resolved, Escalated) — primary filter for active vs. resolved cold chain incidents."
    - name: "excursion_start_month"
      expr: DATE_TRUNC('month', excursion_start_timestamp)
      comment: "Month the temperature excursion began — enables monthly cold chain incident trend analysis."
  measures:
    - name: "total_excursion_count"
      expr: COUNT(1)
      comment: "Total number of temperature excursions recorded — primary cold chain quality KPI; high counts indicate systemic cold chain infrastructure failures."
    - name: "open_excursion_count"
      expr: COUNT(CASE WHEN temperature_excursion_status = 'Open' THEN 1 END)
      comment: "Number of unresolved temperature excursions — used to monitor active cold chain risk exposure requiring immediate corrective action."
    - name: "distinct_warehouses_affected"
      expr: COUNT(DISTINCT warehouse_id)
      comment: "Number of distinct warehouses experiencing temperature excursions — used to identify systemic vs. isolated cold chain failures."
    - name: "distinct_equipment_affected"
      expr: COUNT(DISTINCT cold_chain_equipment_id)
      comment: "Number of distinct cold chain equipment units involved in excursions — used to prioritize equipment maintenance and replacement."
    - name: "distinct_batch_lots_affected"
      expr: COUNT(DISTINCT batch_lot_id)
      comment: "Number of distinct batch lots exposed to temperature excursions — used to quantify the scope of potential product compromise requiring quarantine or disposal decisions."
$$;