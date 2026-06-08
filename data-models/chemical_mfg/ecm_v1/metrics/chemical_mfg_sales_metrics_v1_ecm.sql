-- Metric views for domain: sales | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 13:07:02

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High‑level pipeline view of sales opportunities, supporting win‑rate and revenue forecasting"
  source: "`chemical_mfg_ecm`.`sales`.`opportunity`"
  dimensions:
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the opportunity"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Channel through which the opportunity originated"
    - name: "territory_id"
      expr: territory_id
      comment: "Territory identifier linked to the opportunity"
    - name: "opportunity_type"
      expr: opportunity_type
      comment: "Business type of the opportunity (e.g., new, expansion)"
    - name: "is_key_account"
      expr: is_key_account
      comment: "Flag indicating if the opportunity belongs to a key account"
    - name: "stage"
      expr: stage
      comment: "Current sales stage of the opportunity"
  measures:
    - name: "total_estimated_amount_usd"
      expr: SUM(CAST(estimated_amount AS DOUBLE))
      comment: "Sum of estimated opportunity amounts in USD"
    - name: "total_closed_amount_usd"
      expr: SUM(CAST(closed_amount AS DOUBLE))
      comment: "Sum of amounts for opportunities that have been closed"
    - name: "count_opportunities"
      expr: COUNT(1)
      comment: "Total number of opportunity records"
    - name: "count_won_opportunities"
      expr: COUNT(CASE WHEN is_won THEN 1 END)
      comment: "Number of opportunities marked as won"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`sales_opportunity_product`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed view of opportunity line items to monitor revenue, volume and discount performance"
  source: "`chemical_mfg_ecm`.`sales`.`opportunity_product`"
  dimensions:
    - name: "chemical_product_id"
      expr: chemical_product_id
      comment: "Identifier of the chemical product being sold"
    - name: "sales_stage"
      expr: sales_stage
      comment: "Sales stage for the line item"
    - name: "packaging_type"
      expr: packaging_type
      comment: "Packaging type of the product"
    - name: "product_grade"
      expr: product_grade
      comment: "Grade or quality level of the product"
  measures:
    - name: "total_estimated_revenue_usd"
      expr: SUM(CAST(estimated_revenue AS DOUBLE))
      comment: "Sum of estimated revenue for opportunity line items"
    - name: "total_estimated_quantity_kg"
      expr: SUM(CAST(estimated_quantity AS DOUBLE))
      comment: "Sum of estimated quantity (kg) for opportunity line items"
    - name: "average_discount_pct"
      expr: AVG(CAST(discount_pct AS DOUBLE))
      comment: "Average discount percentage applied across line items"
    - name: "count_line_items"
      expr: COUNT(1)
      comment: "Number of opportunity product line records"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`sales_price_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing contract view to track volume commitments, credit exposure and pricing levels"
  source: "`chemical_mfg_ecm`.`sales`.`price_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of price agreement (e.g., fixed, variable)"
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the agreement"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for the agreement"
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date of the agreement's effectiveness"
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel linked to the agreement"
  measures:
    - name: "total_annual_volume_commitment"
      expr: SUM(CAST(annual_volume_commitment AS DOUBLE))
      comment: "Total annual volume commitment across all price agreements"
    - name: "average_price_per_qty"
      expr: AVG(CAST(price_per_qty AS DOUBLE))
      comment: "Average price per quantity unit across agreements"
    - name: "count_price_agreements"
      expr: COUNT(1)
      comment: "Number of active price agreement records"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`sales_win_loss`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Win‑loss analysis to evaluate deal success, value and volume by competitor and territory"
  source: "`chemical_mfg_ecm`.`sales`.`win_loss`"
  dimensions:
    - name: "outcome"
      expr: outcome
      comment: "Result of the deal (Won, Lost, etc.)"
    - name: "primary_win_reason"
      expr: primary_win_reason
      comment: "Key reason for winning the deal"
    - name: "primary_loss_reason"
      expr: primary_loss_reason
      comment: "Key reason for losing the deal"
    - name: "competitor_id"
      expr: competitor_id
      comment: "Competing entity identifier"
    - name: "territory_id"
      expr: territory_id
      comment: "Territory where the deal took place"
    - name: "is_new_customer"
      expr: is_new_customer
      comment: "Flag indicating if the deal is with a new customer"
  measures:
    - name: "count_deals"
      expr: COUNT(1)
      comment: "Total number of win/loss records"
    - name: "total_deal_value_usd"
      expr: SUM(CAST(deal_value_usd AS DOUBLE))
      comment: "Aggregate monetary value of deals"
    - name: "average_deal_volume_kg"
      expr: AVG(CAST(deal_volume_kg AS DOUBLE))
      comment: "Average deal volume in kilograms"
    - name: "count_won_deals"
      expr: COUNT(CASE WHEN outcome = 'Won' THEN 1 END)
      comment: "Number of deals with a won outcome"
$$;