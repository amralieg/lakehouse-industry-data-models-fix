-- Metric views for domain: pricing | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 13:07:02

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`pricing_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key pricing approval KPIs to monitor approved pricing amounts and approval activity"
  source: "`chemical_mfg_ecm`.`pricing`.`approval`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current status of the approval (e.g., Approved, Pending, Rejected)"
    - name: "approval_level"
      expr: approval_level
      comment: "Hierarchical level of the approval"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region code associated with the approval"
    - name: "price_type"
      expr: price_type
      comment: "Type of price (e.g., List, Discounted, Promotional)"
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit responsible for the approval"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year of the price effectiveness start date"
  measures:
    - name: "total_approved_price"
      expr: SUM(CAST(approved_price AS DOUBLE))
      comment: "Total approved price amount across all approvals"
    - name: "average_approved_price"
      expr: AVG(CAST(approved_price AS DOUBLE))
      comment: "Average approved price per approval record"
    - name: "approval_count"
      expr: COUNT(1)
      comment: "Number of approval records"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`pricing_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic proposal performance metrics for revenue and margin evaluation"
  source: "`chemical_mfg_ecm`.`pricing`.`proposal`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current status of the proposal (e.g., Submitted, Approved, Rejected)"
    - name: "proposal_type"
      expr: proposal_type
      comment: "Classification of the proposal (e.g., New Business, Renewal, Upsell)"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the proposal"
    - name: "product_category_code"
      expr: product_category_code
      comment: "Product category associated with the proposal"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for the proposal amounts"
    - name: "effective_year"
      expr: YEAR(effective_from)
      comment: "Year when the proposal becomes effective"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Sum of gross amounts for all proposals"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net amounts for all proposals"
    - name: "average_margin_percent"
      expr: AVG(CAST(margin_actual_percent AS DOUBLE))
      comment: "Average actual margin percent across proposals"
    - name: "proposal_count"
      expr: COUNT(1)
      comment: "Number of proposal records"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`pricing_price_change_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price change event impact metrics to track adjustments and their drivers"
  source: "`chemical_mfg_ecm`.`pricing`.`price_change_event`"
  dimensions:
    - name: "price_change_type"
      expr: price_change_type
      comment: "Type of price change (e.g., Increase, Decrease, Correction)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the price change event"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the price change"
    - name: "effective_date"
      expr: effective_date
      comment: "Date when the price change becomes effective"
    - name: "is_manual_change"
      expr: is_manual_change
      comment: "Flag indicating if the change was made manually"
  measures:
    - name: "total_change_amount"
      expr: SUM(CAST(change_amount AS DOUBLE))
      comment: "Total monetary change amount across price change events"
    - name: "average_change_percent"
      expr: AVG(CAST(change_percent AS DOUBLE))
      comment: "Average percentage change across price change events"
    - name: "price_change_event_count"
      expr: COUNT(1)
      comment: "Number of price change events recorded"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`pricing_price_list_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core price list item KPIs for pricing strategy effectiveness and margin monitoring"
  source: "`chemical_mfg_ecm`.`pricing`.`price_list_item`"
  dimensions:
    - name: "price_type"
      expr: price_type
      comment: "Classification of the price (e.g., List, Discount, Promotional)"
    - name: "price_category"
      expr: price_category
      comment: "Category grouping for the price list item"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region associated with the price list item"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the price amount"
    - name: "effective_year"
      expr: YEAR(effective_from)
      comment: "Year when the price list item becomes effective"
    - name: "is_default_price"
      expr: is_default_price
      comment: "Flag indicating if this is the default price for the product"
  measures:
    - name: "total_price_amount"
      expr: SUM(CAST(price_amount AS DOUBLE))
      comment: "Total price amount across all price list items"
    - name: "average_margin_percent"
      expr: AVG(CAST(margin_percent AS DOUBLE))
      comment: "Average margin percent for price list items"
    - name: "price_list_item_count"
      expr: COUNT(1)
      comment: "Number of price list item records"
$$;