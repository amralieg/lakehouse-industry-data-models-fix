-- Metric views for domain: supply | Business: Automotive | Version: 1 | Generated on: 2026-05-07 00:10:14

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`supply_ckd_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for CKD shipments, supporting logistics and cost efficiency decisions."
  source: "`automotive_ecm`.`supply`.`ckd_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: ckd_shipment_status
      comment: "Current status of the CKD shipment (e.g., In-Transit, Delivered)."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used for the shipment (e.g., Sea, Air, Road)."
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms governing the shipment."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates if the shipment contains hazardous material."
    - name: "origin_plant_code"
      expr: origin_plant_code
      comment: "Code of the plant where the shipment originated."
    - name: "destination_plant_code"
      expr: destination_plant_code
      comment: "Code of the destination plant."
    - name: "departure_month"
      expr: DATE_TRUNC('month', departure_date)
      comment: "Month of shipment departure, used for time‑based analysis."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of CKD shipments recorded."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Sum of freight cost for all shipments (USD)."
    - name: "avg_freight_cost"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per shipment (USD)."
    - name: "on_time_shipment_count"
      expr: SUM(CASE WHEN actual_arrival_date <= estimated_arrival_date THEN 1 ELSE 0 END)
      comment: "Count of shipments that arrived on or before the estimated arrival date."
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`supply_price_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and compliance metrics for supplier price agreements, enabling strategic sourcing decisions."
  source: "`automotive_ecm`.`supply`.`price_agreement`"
  dimensions:
    - name: "supplier_id"
      expr: supply_supplier_id
      comment: "Identifier of the supplier linked to the price agreement."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of price agreement (e.g., Fixed, Variable)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for the agreement pricing."
    - name: "agreement_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month when the agreement became effective."
  measures:
    - name: "total_annual_volume"
      expr: SUM(CAST(total_annual_volume AS DOUBLE))
      comment: "Aggregated annual volume committed in price agreements."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across all active price agreements (USD)."
    - name: "count_agreements"
      expr: COUNT(1)
      comment: "Number of price agreement records."
    - name: "approved_agreement_count"
      expr: SUM(CASE WHEN compliance_approval_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Count of price agreements that have received compliance approval."
    - name: "avg_actual_otd_percent"
      expr: AVG(CAST(actual_otd_percent AS DOUBLE))
      comment: "Average actual on‑time delivery percentage across agreements."
    - name: "avg_target_otd_percent"
      expr: AVG(CAST(target_otd_percent AS DOUBLE))
      comment: "Average target on‑time delivery percentage set in agreements."
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`supply_supplier_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic supplier performance metrics used by procurement leadership to drive supplier improvement initiatives."
  source: "`automotive_ecm`.`supply`.`supplier_scorecard`"
  dimensions:
    - name: "supplier_id"
      expr: supply_supplier_id
      comment: "Supplier identifier linked to the scorecard."
    - name: "performance_tier"
      expr: performance_tier
      comment: "Tier classification of supplier performance (e.g., Gold, Silver, Bronze)."
    - name: "evaluation_month"
      expr: DATE_TRUNC('month', evaluation_date)
      comment: "Month of the scorecard evaluation."
  measures:
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall supplier score across all scorecards."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score for suppliers."
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score reflecting environmental performance."
    - name: "avg_otd_percentage"
      expr: AVG(CAST(otd_percentage AS DOUBLE))
      comment: "Average on‑time delivery percentage from scorecards."
    - name: "scorecard_count"
      expr: COUNT(1)
      comment: "Total number of supplier scorecard records evaluated."
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`supply_inbound_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality control metrics for inbound parts inspections, supporting early defect detection and supplier quality management."
  source: "`automotive_ecm`.`supply`.`inbound_inspection`"
  dimensions:
    - name: "inspection_result"
      expr: inspection_result
      comment: "Result of the inspection (e.g., Pass, Fail)."
    - name: "inspection_method"
      expr: inspection_method
      comment: "Methodology used for the inspection (e.g., Visual, X‑Ray)."
    - name: "inspection_month"
      expr: DATE_TRUNC('month', inspection_timestamp)
      comment: "Month when the inspection was performed."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inbound inspections performed."
    - name: "avg_defect_rate_ppm"
      expr: AVG(CAST(defect_rate_ppm AS DOUBLE))
      comment: "Average defect rate (parts per million) observed during inspections."
    - name: "defect_inspection_count"
      expr: SUM(CASE WHEN defect_rate_ppm > 0 THEN 1 ELSE 0 END)
      comment: "Count of inspections that reported any defects."
$$;