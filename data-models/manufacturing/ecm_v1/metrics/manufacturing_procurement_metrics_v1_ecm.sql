-- Metric views for domain: procurement | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 08:25:38

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key spend metrics from purchase orders"
  source: "`manufacturing_ecm`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order"
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Group responsible for purchasing"
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Organization handling the purchase"
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g., standard, subcontract)"
    - name: "priority"
      expr: priority
      comment: "Priority classification of the PO"
    - name: "po_year"
      expr: YEAR(created_timestamp)
      comment: "Fiscal year of PO creation"
  measures:
    - name: "total_po_value"
      expr: SUM(CAST(total_po_value AS DOUBLE))
      comment: "Total purchase order value in base currency"
    - name: "avg_po_value"
      expr: AVG(CAST(total_po_value AS DOUBLE))
      comment: "Average purchase order value per record"
    - name: "po_count"
      expr: COUNT(1)
      comment: "Number of purchase orders"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`procurement_spend_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spend performance and compliance metrics"
  source: "`manufacturing_ecm`.`procurement`.`spend_record`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the spend"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (e.g., month) of the spend"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier associated with the spend"
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Purchasing group responsible for the spend"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center charged"
    - name: "spend_category"
      expr: spend_category
      comment: "Business category of the spend"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where the spend was incurred"
  measures:
    - name: "total_spend"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total spend amount in transaction currency"
    - name: "total_spend_usd"
      expr: SUM(CAST(spend_amount_usd AS DOUBLE))
      comment: "Total spend amount converted to USD"
    - name: "total_savings"
      expr: SUM(CAST(savings_amount AS DOUBLE))
      comment: "Total savings captured on spend records"
    - name: "maverick_spend_flag_count"
      expr: SUM(CASE WHEN maverick_spend_flag THEN 1 ELSE 0 END)
      comment: "Count of spend records flagged as maverick (non‑contracted) spend"
    - name: "spend_record_count"
      expr: COUNT(1)
      comment: "Number of spend records"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`procurement_contract_release_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract utilization and exposure metrics"
  source: "`manufacturing_ecm`.`procurement`.`contract_release_order`"
  dimensions:
    - name: "contract_status"
      expr: release_status
      comment: "Current status of the contract release order"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier linked to the contract"
  measures:
    - name: "total_released_value"
      expr: SUM(CAST(release_value AS DOUBLE))
      comment: "Total value of released contract quantities"
    - name: "total_remaining_value"
      expr: SUM(CAST(contract_remaining_value AS DOUBLE))
      comment: "Remaining contract value not yet released"
    - name: "cro_count"
      expr: COUNT(1)
      comment: "Number of contract release orders"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`procurement_approval_workflow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approval efficiency and bottleneck metrics"
  source: "`manufacturing_ecm`.`procurement`.`approval_workflow`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current status of the approval (e.g., Approved, Pending)"
    - name: "approval_action"
      expr: approval_action
      comment: "Action taken in the approval step"
    - name: "approval_level"
      expr: approval_level
      comment: "Hierarchical level of the approval"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier involved in the approval"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the approval request"
  measures:
    - name: "avg_approval_duration"
      expr: AVG(CAST(approval_duration_hours AS DOUBLE))
      comment: "Average time (hours) taken to approve requests"
    - name: "pending_approvals"
      expr: SUM(CASE WHEN approval_status = 'Pending' THEN 1 ELSE 0 END)
      comment: "Count of approvals currently pending"
    - name: "approval_count"
      expr: COUNT(1)
      comment: "Total number of approval workflow records"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`procurement_sourcing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic sourcing performance indicators"
  source: "`manufacturing_ecm`.`procurement`.`sourcing_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of sourcing event (e.g., RFQ, Auction)"
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Purchasing group that ran the event"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the event"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the sourcing event"
  measures:
    - name: "total_awarded_spend"
      expr: SUM(CAST(awarded_spend_amount AS DOUBLE))
      comment: "Total spend awarded through sourcing events"
    - name: "total_actual_savings"
      expr: SUM(CAST(actual_savings_amount AS DOUBLE))
      comment: "Actual savings realized from sourcing events"
    - name: "avg_savings_pct"
      expr: AVG(CAST(actual_savings_percentage AS DOUBLE))
      comment: "Average percentage savings achieved"
    - name: "avg_award_lead_days"
      expr: AVG(DATEDIFF(award_date, CAST(created_timestamp AS DATE)))
      comment: "Average days between event creation and award"
    - name: "sourcing_event_count"
      expr: COUNT(1)
      comment: "Number of sourcing events"
$$;