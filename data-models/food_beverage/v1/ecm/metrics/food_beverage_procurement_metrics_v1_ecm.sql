-- Metric views for domain: procurement | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 21:55:54

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial KPIs for purchase orders"
  source: "`food_beverage_ecm`.`procurement`.`purchase_order`"
  dimensions:
    - name: "purchasing_org_code"
      expr: purchasing_org_code
      comment: "Purchasing organization code"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier identifier"
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order"
    - name: "order_date"
      expr: order_date
      comment: "Date the purchase order was created"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(po_gross_amount AS DOUBLE))
      comment: "Total gross amount of purchase orders"
    - name: "average_gross_amount"
      expr: AVG(CAST(po_gross_amount AS DOUBLE))
      comment: "Average gross amount per purchase order"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount of purchase orders"
    - name: "average_net_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net amount per purchase order"
    - name: "purchase_order_count"
      expr: COUNT(1)
      comment: "Number of purchase orders"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`procurement_supplier_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier performance scorecard metrics"
  source: "`food_beverage_ecm`.`procurement`.`supplier_scorecard`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier identifier"
    - name: "scorecard_date"
      expr: scorecard_date
      comment: "Date of the scorecard"
    - name: "supplier_category"
      expr: supplier_category
      comment: "Categorization of the supplier"
    - name: "sustainability_rating"
      expr: sustainability_rating
      comment: "Supplier sustainability rating"
  measures:
    - name: "overall_score_avg"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall supplier score"
    - name: "delivery_score_avg"
      expr: AVG(CAST(delivery_score AS DOUBLE))
      comment: "Average delivery performance score"
    - name: "quality_score_avg"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality performance score"
    - name: "otif_rate_avg"
      expr: AVG(CAST(otif_rate AS DOUBLE))
      comment: "Average On-Time-In-Full rate"
    - name: "scorecard_record_count"
      expr: COUNT(1)
      comment: "Number of supplier scorecard records"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`procurement_purchase_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic contract financial KPIs"
  source: "`food_beverage_ecm`.`procurement`.`purchase_contract`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier identifier"
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization responsible for the contract"
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract"
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Contract start date"
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Aggregate value of all purchase contracts"
    - name: "average_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value"
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Number of purchase contracts"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`procurement_sourcing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic sourcing performance metrics"
  source: "`food_beverage_ecm`.`procurement`.`sourcing_event`"
  dimensions:
    - name: "procurement_organization"
      expr: procurement_organization
      comment: "Organization responsible for the sourcing event"
    - name: "event_type"
      expr: event_type
      comment: "Type of sourcing event (e.g., RFP, auction)"
    - name: "award_date"
      expr: award_date
      comment: "Date the award was made"
  measures:
    - name: "total_awarded_spend"
      expr: SUM(CAST(awarded_spend_amount AS DOUBLE))
      comment: "Total spend awarded through sourcing events"
    - name: "average_awarded_spend"
      expr: AVG(CAST(awarded_spend_amount AS DOUBLE))
      comment: "Average awarded spend per event"
    - name: "total_savings_amount"
      expr: SUM(CAST(savings_amount AS DOUBLE))
      comment: "Total savings realized from sourcing events"
    - name: "average_savings_percentage"
      expr: AVG(CAST(savings_percentage AS DOUBLE))
      comment: "Average savings percentage across events"
    - name: "sourcing_event_count"
      expr: COUNT(1)
      comment: "Number of sourcing events"
$$;