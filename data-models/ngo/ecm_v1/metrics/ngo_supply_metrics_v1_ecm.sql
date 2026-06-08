-- Metric views for domain: supply | Business: Ngo | Version: 1 | Generated on: 2026-05-07 01:23:35

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order procurement performance metrics tracking order value, cycle time, emergency procurement, and approval efficiency"
  source: "`ngo_ecm`.`supply`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order"
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order"
    - name: "procurement_method"
      expr: procurement_method
      comment: "Method used for procurement (competitive, sole source, framework, etc.)"
    - name: "commodity_category"
      expr: commodity_category
      comment: "Category of commodities being procured"
    - name: "emergency_flag"
      expr: emergency_flag
      comment: "Whether this is an emergency procurement"
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Whether donor has visibility into this procurement"
    - name: "po_year"
      expr: YEAR(po_date)
      comment: "Year of purchase order"
    - name: "po_month"
      expr: DATE_TRUNC('MONTH', po_date)
      comment: "Month of purchase order"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the purchase order"
    - name: "approval_workflow_status"
      expr: approval_workflow_status
      comment: "Current approval workflow status"
  measures:
    - name: "total_po_value"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total value of all purchase orders"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight costs across all purchase orders"
    - name: "avg_po_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average purchase order value"
    - name: "po_count"
      expr: COUNT(DISTINCT po_number)
      comment: "Number of distinct purchase orders"
    - name: "emergency_po_count"
      expr: COUNT(DISTINCT CASE WHEN emergency_flag = TRUE THEN po_number END)
      comment: "Number of emergency purchase orders"
    - name: "avg_procurement_cycle_days"
      expr: AVG(CAST(DATEDIFF(approved_timestamp, po_date) AS DOUBLE))
      comment: "Average days from PO creation to approval"
    - name: "avg_delivery_lead_time_days"
      expr: AVG(CAST(DATEDIFF(actual_delivery_date, po_date) AS DOUBLE))
      comment: "Average days from PO creation to actual delivery"
    - name: "on_time_delivery_count"
      expr: COUNT(DISTINCT CASE WHEN actual_delivery_date <= expected_delivery_date THEN po_number END)
      comment: "Number of purchase orders delivered on or before expected date"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`supply_inventory_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory management metrics tracking stock levels, valuation, expiry risk, and stock availability across warehouses"
  source: "`ngo_ecm`.`supply`.`inventory_balance`"
  dimensions:
    - name: "warehouse_location"
      expr: warehouse_location
      comment: "Warehouse location where inventory is held"
    - name: "country_code"
      expr: country_code
      comment: "Country where inventory is located"
    - name: "pipeline_status"
      expr: pipeline_status
      comment: "Status of inventory in the supply pipeline"
    - name: "donor_restriction_flag"
      expr: donor_restriction_flag
      comment: "Whether inventory has donor restrictions"
    - name: "in_kind_donation_flag"
      expr: in_kind_donation_flag
      comment: "Whether inventory originated from in-kind donation"
    - name: "storage_condition"
      expr: storage_condition
      comment: "Storage condition requirements for inventory"
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_date)
      comment: "Month of inventory snapshot"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of inventory valuation"
  measures:
    - name: "total_inventory_value"
      expr: SUM(CAST(total_valuation AS DOUBLE))
      comment: "Total value of inventory on hand"
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity of inventory on hand"
    - name: "total_quantity_available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total quantity available for distribution (not reserved or quarantined)"
    - name: "total_quantity_reserved"
      expr: SUM(CAST(quantity_reserved AS DOUBLE))
      comment: "Total quantity reserved for planned distributions"
    - name: "total_quantity_in_transit"
      expr: SUM(CAST(quantity_in_transit AS DOUBLE))
      comment: "Total quantity currently in transit"
    - name: "total_quantity_quarantined"
      expr: SUM(CAST(quantity_quarantined AS DOUBLE))
      comment: "Total quantity quarantined pending inspection or quality issues"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of inventory items"
    - name: "inventory_line_count"
      expr: COUNT(DISTINCT inventory_balance_id)
      comment: "Number of distinct inventory line items"
    - name: "stockout_risk_count"
      expr: COUNT(DISTINCT CASE WHEN quantity_available <= reorder_level THEN inventory_balance_id END)
      comment: "Number of inventory items at or below reorder level"
    - name: "overstock_count"
      expr: COUNT(DISTINCT CASE WHEN quantity_on_hand > maximum_stock_level THEN inventory_balance_id END)
      comment: "Number of inventory items exceeding maximum stock level"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`supply_distribution_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution order execution metrics tracking delivery performance, beneficiary reach, transport efficiency, and emergency response"
  source: "`ngo_ecm`.`supply`.`distribution_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the distribution order"
    - name: "distribution_type"
      expr: distribution_type
      comment: "Type of distribution (direct, partner, mobile, etc.)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the distribution"
    - name: "emergency_response_flag"
      expr: emergency_response_flag
      comment: "Whether this is an emergency response distribution"
    - name: "cold_chain_required_flag"
      expr: cold_chain_required_flag
      comment: "Whether cold chain is required for this distribution"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used for distribution"
    - name: "in_kind_donation_flag"
      expr: in_kind_donation_flag
      comment: "Whether distribution includes in-kind donations"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month of distribution order"
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', actual_delivery_date)
      comment: "Month of actual delivery"
  measures:
    - name: "total_distribution_value"
      expr: SUM(CAST(estimated_value_usd AS DOUBLE))
      comment: "Total estimated value of distributions in USD"
    - name: "total_transport_cost"
      expr: SUM(CAST(transport_cost_usd AS DOUBLE))
      comment: "Total transport costs for distributions in USD"
    - name: "total_quantity_distributed"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total quantity of commodities distributed"
    - name: "total_weight_distributed_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight distributed in kilograms"
    - name: "total_volume_distributed_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volume distributed in cubic meters"
    - name: "distribution_order_count"
      expr: COUNT(DISTINCT order_number)
      comment: "Number of distinct distribution orders"
    - name: "avg_delivery_lead_time_days"
      expr: AVG(CAST(DATEDIFF(actual_delivery_date, order_date) AS DOUBLE))
      comment: "Average days from order to actual delivery"
    - name: "on_time_delivery_count"
      expr: COUNT(DISTINCT CASE WHEN actual_delivery_date <= scheduled_delivery_date THEN order_number END)
      comment: "Number of distributions delivered on or before scheduled date"
    - name: "avg_transport_cost_per_kg"
      expr: AVG(CAST(transport_cost_usd AS DOUBLE) / NULLIF(CAST(total_weight_kg AS DOUBLE), 0))
      comment: "Average transport cost per kilogram distributed"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt quality and accuracy metrics tracking receipt discrepancies, inspection results, customs clearance, and procurement fulfillment"
  source: "`ngo_ecm`.`supply`.`goods_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of the goods receipt"
    - name: "condition_on_arrival"
      expr: condition_on_arrival
      comment: "Condition of goods upon arrival"
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Whether there was a discrepancy between ordered and received"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Status of quality inspection"
    - name: "inspection_required"
      expr: inspection_required
      comment: "Whether inspection was required"
    - name: "customs_cleared"
      expr: customs_cleared
      comment: "Whether customs clearance was completed"
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Whether donor has visibility into this receipt"
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month of goods receipt"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of receipt valuation"
  measures:
    - name: "total_receipt_value"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total value of goods received"
    - name: "total_freight_charges"
      expr: SUM(CAST(freight_charges AS DOUBLE))
      comment: "Total freight charges for goods received"
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered across all receipts"
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity actually received"
    - name: "total_quantity_rejected"
      expr: SUM(CAST(quantity_rejected AS DOUBLE))
      comment: "Total quantity rejected due to quality or other issues"
    - name: "receipt_count"
      expr: COUNT(DISTINCT receipt_document_number)
      comment: "Number of distinct goods receipts"
    - name: "discrepancy_count"
      expr: COUNT(DISTINCT CASE WHEN discrepancy_flag = TRUE THEN goods_receipt_id END)
      comment: "Number of receipts with discrepancies"
    - name: "avg_receipt_accuracy_pct"
      expr: AVG(100.0 * CAST(quantity_received AS DOUBLE) / NULLIF(CAST(quantity_ordered AS DOUBLE), 0))
      comment: "Average receipt accuracy as percentage of ordered quantity"
    - name: "avg_customs_clearance_days"
      expr: AVG(CAST(DATEDIFF(customs_clearance_date, receipt_date) AS DOUBLE))
      comment: "Average days from receipt to customs clearance"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`supply_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance and qualification metrics tracking prequalification status, performance ratings, compliance, and vendor capacity"
  source: "`ngo_ecm`.`supply`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current status of the vendor"
    - name: "vendor_type"
      expr: vendor_type
      comment: "Type of vendor (supplier, transporter, service provider, etc.)"
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Vendor prequalification status"
    - name: "performance_tier"
      expr: performance_tier
      comment: "Performance tier classification of vendor"
    - name: "blacklist_flag"
      expr: blacklist_flag
      comment: "Whether vendor is blacklisted"
    - name: "country_of_operation"
      expr: country_of_operation
      comment: "Primary country of vendor operations"
    - name: "gmp_certification_flag"
      expr: gmp_certification_flag
      comment: "Whether vendor has Good Manufacturing Practice certification"
    - name: "iso_certification"
      expr: iso_certification
      comment: "ISO certification held by vendor"
    - name: "humanitarian_network_membership"
      expr: humanitarian_network_membership
      comment: "Humanitarian network memberships"
  measures:
    - name: "vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors"
    - name: "active_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN vendor_status = 'Active' THEN vendor_id END)
      comment: "Number of active vendors"
    - name: "prequalified_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN prequalification_status = 'Approved' THEN vendor_id END)
      comment: "Number of prequalified vendors"
    - name: "blacklisted_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN blacklist_flag = TRUE THEN vendor_id END)
      comment: "Number of blacklisted vendors"
    - name: "avg_performance_score"
      expr: AVG(CAST(last_performance_score AS DOUBLE))
      comment: "Average vendor performance score"
    - name: "total_warehouse_capacity_sqm"
      expr: SUM(CAST(warehouse_capacity_sqm AS DOUBLE))
      comment: "Total warehouse capacity across all vendors in square meters"
    - name: "avg_warehouse_capacity_sqm"
      expr: AVG(CAST(warehouse_capacity_sqm AS DOUBLE))
      comment: "Average warehouse capacity per vendor in square meters"
    - name: "certified_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN gmp_certification_flag = TRUE OR iso_certification IS NOT NULL THEN vendor_id END)
      comment: "Number of vendors with quality certifications"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`supply_rfq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Request for Quotation competitive bidding metrics tracking bid participation, responsiveness, award efficiency, and procurement transparency"
  source: "`ngo_ecm`.`supply`.`rfq`"
  dimensions:
    - name: "rfq_status"
      expr: rfq_status
      comment: "Current status of the RFQ"
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method used"
    - name: "procurement_type"
      expr: procurement_type
      comment: "Type of procurement"
    - name: "commodity_category"
      expr: commodity_category
      comment: "Category of commodity being procured"
    - name: "emergency_procurement"
      expr: emergency_procurement
      comment: "Whether this is emergency procurement"
    - name: "donor_visibility"
      expr: donor_visibility
      comment: "Whether donor has visibility into this RFQ"
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month RFQ was issued"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of RFQ budget and award"
  measures:
    - name: "rfq_count"
      expr: COUNT(DISTINCT rfq_number)
      comment: "Number of distinct RFQs issued"
    - name: "total_estimated_budget"
      expr: SUM(CAST(estimated_budget_amount AS DOUBLE))
      comment: "Total estimated budget across all RFQs"
    - name: "total_awarded_amount"
      expr: SUM(CAST(awarded_amount AS DOUBLE))
      comment: "Total amount awarded through RFQs"
    - name: "avg_bid_participation_rate"
      expr: AVG(CAST(received_bid_count AS DOUBLE) / NULLIF(CAST(invited_vendor_count AS DOUBLE), 0))
      comment: "Average ratio of received bids to invited vendors"
    - name: "avg_responsive_bid_rate"
      expr: AVG(CAST(responsive_bid_count AS DOUBLE) / NULLIF(CAST(received_bid_count AS DOUBLE), 0))
      comment: "Average ratio of responsive bids to total bids received"
    - name: "avg_rfq_cycle_days"
      expr: AVG(CAST(DATEDIFF(award_date, issue_date) AS DOUBLE))
      comment: "Average days from RFQ issue to award"
    - name: "avg_evaluation_days"
      expr: AVG(CAST(DATEDIFF(evaluation_completion_date, bid_opening_date) AS DOUBLE))
      comment: "Average days from bid opening to evaluation completion"
    - name: "awarded_rfq_count"
      expr: COUNT(DISTINCT CASE WHEN award_date IS NOT NULL THEN rfq_number END)
      comment: "Number of RFQs that resulted in an award"
    - name: "avg_savings_pct"
      expr: AVG(100.0 * (CAST(estimated_budget_amount AS DOUBLE) - CAST(awarded_amount AS DOUBLE)) / NULLIF(CAST(estimated_budget_amount AS DOUBLE), 0))
      comment: "Average percentage savings from estimated budget to awarded amount"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`supply_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment logistics performance metrics tracking on-time delivery, freight costs, customs clearance, and cold chain compliance"
  source: "`ngo_ecm`.`supply`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment"
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of shipment"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used"
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Status of customs clearance"
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Whether shipment requires temperature control"
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country code of shipment origin"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Country code of shipment destination"
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms for shipment"
    - name: "departure_month"
      expr: DATE_TRUNC('MONTH', actual_departure_date)
      comment: "Month of actual departure"
  measures:
    - name: "shipment_count"
      expr: COUNT(DISTINCT reference_number)
      comment: "Number of distinct shipments"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_usd AS DOUBLE))
      comment: "Total freight costs in USD"
    - name: "total_insured_value"
      expr: SUM(CAST(insured_value_usd AS DOUBLE))
      comment: "Total insured value of shipments in USD"
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(total_cargo_weight_kg AS DOUBLE))
      comment: "Total cargo weight in kilograms"
    - name: "total_cargo_volume_m3"
      expr: SUM(CAST(total_cargo_volume_m3 AS DOUBLE))
      comment: "Total cargo volume in cubic meters"
    - name: "avg_freight_cost_per_kg"
      expr: AVG(CAST(freight_cost_usd AS DOUBLE) / NULLIF(CAST(total_cargo_weight_kg AS DOUBLE), 0))
      comment: "Average freight cost per kilogram"
    - name: "avg_transit_days"
      expr: AVG(CAST(DATEDIFF(actual_arrival_date, actual_departure_date) AS DOUBLE))
      comment: "Average transit days from departure to arrival"
    - name: "on_time_arrival_count"
      expr: COUNT(DISTINCT CASE WHEN actual_arrival_date <= estimated_arrival_date THEN reference_number END)
      comment: "Number of shipments arriving on or before estimated date"
    - name: "cold_chain_shipment_count"
      expr: COUNT(DISTINCT CASE WHEN temperature_controlled = TRUE THEN reference_number END)
      comment: "Number of temperature-controlled shipments"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`supply_warehouse`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse capacity and operational readiness metrics tracking storage capacity, utilization, compliance certifications, and operational status"
  source: "`ngo_ecm`.`supply`.`warehouse`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the warehouse"
    - name: "facility_type"
      expr: facility_type
      comment: "Type of warehouse facility"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type of the warehouse"
    - name: "country_code"
      expr: country_code
      comment: "Country where warehouse is located"
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "First administrative level location"
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Whether warehouse has temperature control"
    - name: "hazmat_certified"
      expr: hazmat_certified
      comment: "Whether warehouse is certified for hazardous materials"
    - name: "customs_bonded"
      expr: customs_bonded
      comment: "Whether warehouse is customs bonded"
    - name: "emergency_access_24_7"
      expr: emergency_access_24_7
      comment: "Whether warehouse has 24/7 emergency access"
    - name: "security_level"
      expr: security_level
      comment: "Security level classification of warehouse"
  measures:
    - name: "warehouse_count"
      expr: COUNT(DISTINCT warehouse_id)
      comment: "Number of distinct warehouses"
    - name: "operational_warehouse_count"
      expr: COUNT(DISTINCT CASE WHEN operational_status = 'Operational' THEN warehouse_id END)
      comment: "Number of operational warehouses"
    - name: "total_storage_capacity_m3"
      expr: SUM(CAST(storage_capacity_m3 AS DOUBLE))
      comment: "Total storage capacity in cubic meters"
    - name: "avg_storage_capacity_m3"
      expr: AVG(CAST(storage_capacity_m3 AS DOUBLE))
      comment: "Average storage capacity per warehouse in cubic meters"
    - name: "cold_storage_warehouse_count"
      expr: COUNT(DISTINCT CASE WHEN temperature_controlled = TRUE THEN warehouse_id END)
      comment: "Number of temperature-controlled warehouses"
    - name: "hazmat_certified_warehouse_count"
      expr: COUNT(DISTINCT CASE WHEN hazmat_certified = TRUE THEN warehouse_id END)
      comment: "Number of hazmat-certified warehouses"
    - name: "customs_bonded_warehouse_count"
      expr: COUNT(DISTINCT CASE WHEN customs_bonded = TRUE THEN warehouse_id END)
      comment: "Number of customs bonded warehouses"
    - name: "emergency_ready_warehouse_count"
      expr: COUNT(DISTINCT CASE WHEN emergency_access_24_7 = TRUE THEN warehouse_id END)
      comment: "Number of warehouses with 24/7 emergency access"
    - name: "avg_gis_accuracy_meters"
      expr: AVG(CAST(gis_accuracy_meters AS DOUBLE))
      comment: "Average GIS location accuracy in meters"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`supply_bid`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bid evaluation and award metrics tracking bid competitiveness, technical and financial scoring, award rates, and vendor performance"
  source: "`ngo_ecm`.`supply`.`bid`"
  dimensions:
    - name: "bid_status"
      expr: bid_status
      comment: "Current status of the bid"
    - name: "awarded_flag"
      expr: awarded_flag
      comment: "Whether the bid was awarded"
    - name: "rank"
      expr: rank
      comment: "Rank of the bid in evaluation"
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason for bid rejection if applicable"
    - name: "currency"
      expr: currency
      comment: "Currency of the bid amount"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of bid submission"
  measures:
    - name: "bid_count"
      expr: COUNT(DISTINCT bid_id)
      comment: "Number of distinct bids submitted"
    - name: "awarded_bid_count"
      expr: COUNT(DISTINCT CASE WHEN awarded_flag = TRUE THEN bid_id END)
      comment: "Number of bids that were awarded"
    - name: "total_bid_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total value of all bids submitted"
    - name: "total_awarded_amount"
      expr: SUM(CASE WHEN awarded_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of awarded bids"
    - name: "avg_bid_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average bid amount"
    - name: "avg_technical_score"
      expr: AVG(CAST(technical_score AS DOUBLE))
      comment: "Average technical evaluation score"
    - name: "avg_financial_score"
      expr: AVG(CAST(financial_score AS DOUBLE))
      comment: "Average financial evaluation score"
    - name: "avg_total_score"
      expr: AVG(CAST(total_score AS DOUBLE))
      comment: "Average total evaluation score"
    - name: "avg_awarded_technical_score"
      expr: AVG(CASE WHEN awarded_flag = TRUE THEN CAST(technical_score AS DOUBLE) END)
      comment: "Average technical score of awarded bids"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`supply_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock movement and inventory transaction metrics tracking movement types, quantities, costs, quality inspection, and donor restrictions"
  source: "`ngo_ecm`.`supply`.`stock_movement`"
  dimensions:
    - name: "movement_type"
      expr: movement_type
      comment: "Type of stock movement (receipt, issue, transfer, adjustment, etc.)"
    - name: "movement_status"
      expr: movement_status
      comment: "Status of the stock movement"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the movement"
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection status"
    - name: "in_kind_donation_flag"
      expr: in_kind_donation_flag
      comment: "Whether movement involves in-kind donation"
    - name: "donor_restriction_code"
      expr: donor_restriction_code
      comment: "Donor restriction code if applicable"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for the movement"
    - name: "movement_month"
      expr: DATE_TRUNC('MONTH', movement_date)
      comment: "Month of stock movement"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of movement valuation"
  measures:
    - name: "movement_count"
      expr: COUNT(DISTINCT movement_number)
      comment: "Number of distinct stock movements"
    - name: "total_movement_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved across all movements"
    - name: "total_movement_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all stock movements"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across movements"
    - name: "receipt_movement_count"
      expr: COUNT(DISTINCT CASE WHEN movement_type = 'Receipt' THEN movement_number END)
      comment: "Number of receipt movements"
    - name: "issue_movement_count"
      expr: COUNT(DISTINCT CASE WHEN movement_type = 'Issue' THEN movement_number END)
      comment: "Number of issue movements"
    - name: "transfer_movement_count"
      expr: COUNT(DISTINCT CASE WHEN movement_type = 'Transfer' THEN movement_number END)
      comment: "Number of transfer movements"
    - name: "adjustment_movement_count"
      expr: COUNT(DISTINCT CASE WHEN movement_type = 'Adjustment' THEN movement_number END)
      comment: "Number of adjustment movements"
    - name: "in_kind_movement_count"
      expr: COUNT(DISTINCT CASE WHEN in_kind_donation_flag = TRUE THEN movement_number END)
      comment: "Number of movements involving in-kind donations"
$$;