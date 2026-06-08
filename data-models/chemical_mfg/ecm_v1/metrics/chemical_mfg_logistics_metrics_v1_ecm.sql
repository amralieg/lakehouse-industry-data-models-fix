-- Metric views for domain: logistics | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 13:07:02

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`logistics_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core shipment performance metrics for logistics operations"
  source: "`chemical_mfg_ecm`.`logistics`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment"
    - name: "shipment_type"
      expr: shipment_type
      comment: "Business type of the shipment (e.g., export, domestic)"
    - name: "carrier_id"
      expr: carrier_id
      comment: "Identifier of the carrier handling the shipment"
    - name: "scheduled_arrival_date"
      expr: DATE_TRUNC('DAY', scheduled_arrival_timestamp)
      comment: "Scheduled arrival date (day bucket)"
  measures:
    - name: "total_shipment_count"
      expr: COUNT(1)
      comment: "Total number of shipment records"
    - name: "total_shipment_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Sum of weight for all shipments (kg)"
    - name: "total_shipment_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Sum of volume for all shipments (cubic meters)"
    - name: "average_shipment_weight_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average weight per shipment (kg)"
    - name: "average_shipment_volume_m3"
      expr: AVG(CAST(total_volume_m3 AS DOUBLE))
      comment: "Average volume per shipment (cubic meters)"
    - name: "hazardous_shipment_count"
      expr: SUM(CASE WHEN hazardous_materials_indicator THEN 1 ELSE 0 END)
      comment: "Count of shipments flagged as hazardous"
    - name: "on_time_shipment_count"
      expr: SUM(CASE WHEN actual_arrival_timestamp <= scheduled_arrival_timestamp THEN 1 ELSE 0 END)
      comment: "Count of shipments that arrived on or before the scheduled arrival"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`logistics_freight_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and operational metrics for freight orders"
  source: "`chemical_mfg_ecm`.`logistics`.`freight_order`"
  dimensions:
    - name: "freight_order_status"
      expr: freight_order_status
      comment: "Current status of the freight order"
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier responsible for the freight order"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the freight order amount"
    - name: "order_created_date"
      expr: DATE_TRUNC('DAY', created_timestamp)
      comment: "Date the freight order was created"
  measures:
    - name: "total_freight_order_count"
      expr: COUNT(1)
      comment: "Total number of freight orders"
    - name: "total_freight_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Sum of freight order amounts"
    - name: "average_freight_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average freight order amount"
    - name: "completed_freight_order_count"
      expr: SUM(CASE WHEN freight_order_status = 'Completed' THEN 1 ELSE 0 END)
      comment: "Count of freight orders with status Completed"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`logistics_freight_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial metrics for freight invoicing"
  source: "`chemical_mfg_ecm`.`logistics`.`freight_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current payment status of the invoice"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., standard, credit)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice"
  measures:
    - name: "total_freight_invoice_count"
      expr: COUNT(1)
      comment: "Total number of freight invoices"
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_invoice_amount AS DOUBLE))
      comment: "Sum of all freight invoice amounts"
    - name: "average_invoice_amount"
      expr: AVG(CAST(total_invoice_amount AS DOUBLE))
      comment: "Average freight invoice amount"
    - name: "paid_invoice_count"
      expr: SUM(CASE WHEN invoice_status = 'Paid' THEN 1 ELSE 0 END)
      comment: "Count of invoices that have been paid"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`logistics_carrier_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated carrier performance and safety metrics"
  source: "`chemical_mfg_ecm`.`logistics`.`carrier`"
  dimensions:
    - name: "carrier_name"
      expr: carrier_name
      comment: "Human‑readable name of the carrier"
    - name: "carrier_type"
      expr: carrier_type
      comment: "Type/category of carrier (e.g., 3PL, carrier-owned)"
    - name: "tier_rating"
      expr: tier_rating
      comment: "Tier rating assigned to the carrier"
    - name: "scac_code"
      expr: scac_code
      comment: "Standard Carrier Alpha Code"
    - name: "contract_end_date"
      expr: DATE_TRUNC('DAY', contract_end_date)
      comment: "Contract end date (day bucket)"
  measures:
    - name: "total_carrier_count"
      expr: COUNT(1)
      comment: "Total number of carriers in the system"
    - name: "average_on_time_delivery_rate"
      expr: AVG(CAST(performance_on_time_delivery_rate AS DOUBLE))
      comment: "Average on‑time delivery performance across carriers"
    - name: "average_tender_acceptance_rate"
      expr: AVG(CAST(tender_acceptance_rate AS DOUBLE))
      comment: "Average tender acceptance rate across carriers"
    - name: "average_safety_rating_score"
      expr: AVG(CAST(safety_rating_score AS DOUBLE))
      comment: "Average safety rating score across carriers"
    - name: "carriers_with_corrective_action"
      expr: SUM(CASE WHEN corrective_action_flag THEN 1 ELSE 0 END)
      comment: "Count of carriers flagged for corrective action"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`logistics_advance_ship_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for advance ship notices, focusing on freight cost and hazmat handling"
  source: "`chemical_mfg_ecm`.`logistics`.`advance_ship_notice`"
  dimensions:
    - name: "asn_status"
      expr: advance_ship_notice_status
      comment: "Current status of the ASN"
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier associated with the ASN"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode used for the ASN"
    - name: "asn_created_date"
      expr: DATE_TRUNC('DAY', created_timestamp)
      comment: "Date the ASN record was created"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether the ASN involves hazardous material"
  measures:
    - name: "total_asn_count"
      expr: COUNT(1)
      comment: "Total number of advance ship notices (ASN) generated"
    - name: "total_freight_gross_amount"
      expr: SUM(CAST(freight_gross_amount AS DOUBLE))
      comment: "Sum of gross freight amounts across ASNs"
    - name: "average_freight_gross_amount"
      expr: AVG(CAST(freight_gross_amount AS DOUBLE))
      comment: "Average gross freight amount per ASN"
    - name: "hazmat_asn_count"
      expr: SUM(CASE WHEN hazmat_flag THEN 1 ELSE 0 END)
      comment: "Count of ASNs flagged as hazardous"
$$;