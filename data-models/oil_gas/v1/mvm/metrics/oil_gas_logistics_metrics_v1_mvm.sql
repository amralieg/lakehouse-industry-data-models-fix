-- Metric views for domain: logistics | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 09:27:20

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`logistics_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key shipment performance indicators for executive and operational review"
  source: "`oil_gas_ecm`.`logistics`.`shipment`"
  dimensions:
    - name: "carrier_id"
      expr: carrier_id
      comment: "Identifier of the carrier responsible for the shipment"
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (e.g., In-Transit, Delivered)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used for the shipment (e.g., Vessel, Rail)"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center associated with the shipment"
    - name: "scheduled_arrival_date"
      expr: DATE_TRUNC('day', scheduled_arrival_timestamp)
      comment: "Scheduled arrival date (day bucket)"
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipment records"
    - name: "total_shipped_volume"
      expr: SUM(CAST(actual_volume AS DOUBLE))
      comment: "Sum of actual shipped volume (bbl) across all shipments"
    - name: "average_freight_cost"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per shipment in native currency"
    - name: "on_time_deliveries"
      expr: SUM(CASE WHEN actual_arrival_timestamp <= scheduled_arrival_timestamp THEN 1 ELSE 0 END)
      comment: "Count of shipments that arrived on or before the scheduled arrival time"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`logistics_lifting_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic view of planned liftings to monitor volume commitments and product quality"
  source: "`oil_gas_ecm`.`logistics`.`logistics_lifting_schedule`"
  dimensions:
    - name: "lifting_status"
      expr: lifting_status
      comment: "Current status of the lifting schedule (e.g., Planned, Executed)"
    - name: "lifting_month"
      expr: lifting_month
      comment: "Month identifier for the lifting schedule"
    - name: "schedule_status"
      expr: schedule_status
      comment: "Overall schedule status (e.g., Approved, Draft)"
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month when the lifting schedule record was created"
  measures:
    - name: "total_liftings"
      expr: COUNT(1)
      comment: "Total number of lifting schedule records"
    - name: "total_nominated_volume_bbl"
      expr: SUM(CAST(nominated_volume_bbl AS DOUBLE))
      comment: "Sum of nominated lift volume in barrels"
    - name: "average_api_gravity"
      expr: AVG(CAST(api_gravity AS DOUBLE))
      comment: "Average API gravity of the product scheduled for lift"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`logistics_pipeline_throughput`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPI for pipeline efficiency and loss monitoring"
  source: "`oil_gas_ecm`.`logistics`.`pipeline_throughput`"
  dimensions:
    - name: "pipeline_segment_id"
      expr: pipeline_segment_id
      comment: "Identifier of the pipeline segment"
    - name: "throughput_date"
      expr: throughput_date
      comment: "Date of the throughput measurement"
    - name: "product_type"
      expr: product_type
      comment: "Type of product transported (e.g., Crude, Natural Gas)"
  measures:
    - name: "total_throughput_records"
      expr: COUNT(1)
      comment: "Total number of pipeline throughput records"
    - name: "total_metered_delivery_volume"
      expr: SUM(CAST(metered_delivery_volume AS DOUBLE))
      comment: "Sum of metered delivery volume across pipelines"
    - name: "total_line_loss_volume"
      expr: SUM(CAST(line_loss_volume AS DOUBLE))
      comment: "Sum of line loss volume (bbl) observed in pipeline operations"
    - name: "total_shrinkage_volume"
      expr: SUM(CAST(shrinkage_volume AS DOUBLE))
      comment: "Sum of shrinkage volume (bbl) for the reporting period"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`logistics_storage_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and operational view of storage inventory levels and valuation"
  source: "`oil_gas_ecm`.`logistics`.`storage_inventory`"
  dimensions:
    - name: "terminal_id"
      expr: terminal_id
      comment: "Terminal where inventory is stored"
    - name: "inventory_date"
      expr: inventory_date
      comment: "Date of the inventory snapshot"
  measures:
    - name: "total_inventory_records"
      expr: COUNT(1)
      comment: "Total number of storage inventory snapshots"
    - name: "average_opening_inventory_bbl"
      expr: AVG(CAST(opening_inventory_bbl AS DOUBLE))
      comment: "Average opening inventory level in barrels"
    - name: "average_closing_inventory_bbl"
      expr: AVG(CAST(closing_inventory_bbl AS DOUBLE))
      comment: "Average closing inventory level in barrels"
    - name: "total_valuation_usd"
      expr: SUM(valuation_price_per_bbl * closing_inventory_bbl)
      comment: "Total USD valuation of closing inventory based on per‑barrel price"
$$;