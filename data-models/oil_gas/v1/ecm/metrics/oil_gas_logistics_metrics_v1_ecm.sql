-- Metric views for domain: logistics | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 05:05:28

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`logistics_cargo`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key cargo throughput and safety metrics"
  source: "`oil_gas_ecm`.`logistics`.`cargo`"
  dimensions:
    - name: "cargo_type"
      expr: cargo_type
      comment: "Type of cargo (e.g., crude, product)"
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of the carrier handling the cargo"
    - name: "scheduled_arrival_month"
      expr: DATE_TRUNC('month', scheduled_arrival_date)
      comment: "Month of scheduled arrival"
  measures:
    - name: "total_volume_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total cargo volume in cubic meters"
    - name: "total_weight_tons"
      expr: SUM(CAST(weight_tons AS DOUBLE))
      comment: "Total cargo weight in metric tons"
    - name: "hazardous_volume_m3"
      expr: SUM(CASE WHEN is_hazardous THEN volume_m3 ELSE 0 END)
      comment: "Volume of hazardous cargo (m3)"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`logistics_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial efficiency of shipments"
  source: "`oil_gas_ecm`.`logistics`.`shipment`"
  dimensions:
    - name: "carrier_id"
      expr: carrier_id
      comment: "Identifier of the carrier responsible for the shipment"
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment"
    - name: "shipment_month"
      expr: DATE_TRUNC('month', scheduled_arrival_timestamp)
      comment: "Month of scheduled shipment arrival"
  measures:
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across shipments"
    - name: "total_volume"
      expr: SUM(CAST(actual_volume AS DOUBLE))
      comment: "Total shipped volume (unit of measure as defined per record)"
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per shipment"
    - name: "avg_volume_per_shipment"
      expr: AVG(CAST(actual_volume AS DOUBLE))
      comment: "Average shipped volume per shipment"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`logistics_port_call`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Port call performance and cost metrics"
  source: "`oil_gas_ecm`.`logistics`.`port_call`"
  dimensions:
    - name: "terminal_id"
      expr: terminal_id
      comment: "Terminal where the port call occurred"
    - name: "vessel_id"
      expr: vessel_id
      comment: "Vessel involved in the port call"
    - name: "port_call_month"
      expr: DATE_TRUNC('month', actual_time_of_arrival)
      comment: "Month of actual arrival"
  measures:
    - name: "total_discharged_volume"
      expr: SUM(CAST(cargo_volume_discharged AS DOUBLE))
      comment: "Total volume discharged at the port (unit of measure as defined per record)"
    - name: "avg_laytime_used_hours"
      expr: AVG(CAST(laytime_used_hours AS DOUBLE))
      comment: "Average laytime actually used (hours)"
    - name: "total_demurrage_hours"
      expr: SUM(CAST(demurrage_incurred_hours AS DOUBLE))
      comment: "Total demurrage hours incurred"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`logistics_pipeline_throughput`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pipeline throughput and loss metrics"
  source: "`oil_gas_ecm`.`logistics`.`pipeline_throughput`"
  dimensions:
    - name: "product_type"
      expr: product_type
      comment: "Type of petroleum product transported"
    - name: "measurement_period_type"
      expr: measurement_period_type
      comment: "Period type for measurement (e.g., daily, monthly)"
    - name: "throughput_month"
      expr: DATE_TRUNC('month', throughput_date)
      comment: "Month of throughput measurement"
  measures:
    - name: "total_metered_delivery_volume"
      expr: SUM(CAST(metered_delivery_volume AS DOUBLE))
      comment: "Total metered delivery volume through the pipeline"
    - name: "total_line_loss_volume"
      expr: SUM(CAST(line_loss_volume AS DOUBLE))
      comment: "Total volume lost due to line loss"
    - name: "total_shrinkage_volume"
      expr: SUM(CAST(shrinkage_volume AS DOUBLE))
      comment: "Total shrinkage volume"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`logistics_storage_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage inventory balance and turnover"
  source: "`oil_gas_ecm`.`logistics`.`storage_inventory`"
  dimensions:
    - name: "terminal_id"
      expr: terminal_id
      comment: "Terminal where inventory is held"
    - name: "inventory_month"
      expr: DATE_TRUNC('month', inventory_date)
      comment: "Month of inventory snapshot"
  measures:
    - name: "average_inventory_bbl"
      expr: AVG((opening_inventory_bbl + closing_inventory_bbl) / 2)
      comment: "Average inventory level (bbl) for the period"
    - name: "total_receipts_bbl"
      expr: SUM(CAST(receipts_bbl AS DOUBLE))
      comment: "Total receipts into storage (bbl)"
    - name: "total_deliveries_bbl"
      expr: SUM(CAST(deliveries_bbl AS DOUBLE))
      comment: "Total deliveries out of storage (bbl)"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`logistics_freight_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and surcharge metrics from freight invoices"
  source: "`oil_gas_ecm`.`logistics`.`freight_invoice`"
  dimensions:
    - name: "carrier_id"
      expr: carrier_id
      comment: "Carrier billed on the invoice"
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of invoice issuance"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice"
  measures:
    - name: "total_invoice_amount_usd"
      expr: SUM(CAST(total_invoice_amount AS DOUBLE))
      comment: "Total invoiced amount in USD"
    - name: "total_freight_revenue"
      expr: SUM(freight_rate * shipped_volume)
      comment: "Total freight revenue (rate multiplied by shipped volume)"
    - name: "total_fuel_surcharge"
      expr: SUM(CAST(fuel_surcharge AS DOUBLE))
      comment: "Total fuel surcharge applied"
$$;