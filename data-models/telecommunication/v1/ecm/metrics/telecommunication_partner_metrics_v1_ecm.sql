-- Metric views for domain: partner | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 05:01:11

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`partner_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and status metrics for partner agreements"
  source: "`telecommunication_ecm`.`partner`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the agreement"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type/category of the agreement"
    - name: "partner_id"
      expr: partner_id
      comment: "Identifier of the partner linked to the agreement"
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the agreement became effective"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for the agreement"
  measures:
    - name: "total_fixed_fee_amount"
      expr: SUM(CAST(fixed_fee_amount AS DOUBLE))
      comment: "Total fixed fee amount across agreements"
    - name: "avg_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage across agreements"
    - name: "agreement_count"
      expr: COUNT(1)
      comment: "Number of agreement records"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`partner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic overview of partner financial exposure and revenue share"
  source: "`telecommunication_ecm`.`partner`.`partner`"
  dimensions:
    - name: "partner_tier"
      expr: partner_tier
      comment: "Tier classification of the partner"
    - name: "partner_type"
      expr: partner_type
      comment: "Business type of the partner"
    - name: "headquarters_country_code"
      expr: headquarters_country_code
      comment: "Country where partner headquarters are located"
    - name: "partner_status"
      expr: partner_status
      comment: "Current operational status of the partner"
  measures:
    - name: "total_credit_limit_amount"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit allocated to partners"
    - name: "avg_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage across partners"
    - name: "partner_count"
      expr: COUNT(1)
      comment: "Number of partner records"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`partner_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance and revenue impact metrics from partner scorecards"
  source: "`telecommunication_ecm`.`partner`.`scorecard`"
  dimensions:
    - name: "partner_id"
      expr: partner_id
      comment: "Partner associated with the scorecard"
    - name: "evaluation_year"
      expr: YEAR(evaluation_period_start_date)
      comment: "Year of the evaluation period"
    - name: "scorecard_status"
      expr: scorecard_status
      comment: "Current status of the scorecard"
  measures:
    - name: "avg_composite_score"
      expr: AVG(CAST(composite_score AS DOUBLE))
      comment: "Average composite performance score across scorecards"
    - name: "total_revenue_contribution_amount"
      expr: SUM(CAST(revenue_contribution_amount AS DOUBLE))
      comment: "Total revenue contribution amount from scorecards"
    - name: "avg_revenue_growth_percentage"
      expr: AVG(CAST(revenue_growth_percentage AS DOUBLE))
      comment: "Average revenue growth percentage across scorecards"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`partner_settlement_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial settlement line aggregates for partner settlements"
  source: "`telecommunication_ecm`.`partner`.`settlement_line`"
  dimensions:
    - name: "partner_id"
      expr: partner_id
      comment: "Partner linked to the settlement line"
    - name: "settlement_year"
      expr: YEAR(settlement_period_start_date)
      comment: "Fiscal year of the settlement period"
    - name: "service_type"
      expr: service_type
      comment: "Type of service associated with the settlement line"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount for settlement lines"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after discounts and adjustments"
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount applied per settlement line"
    - name: "settlement_line_count"
      expr: COUNT(1)
      comment: "Number of settlement line records"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`partner_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key dispute management metrics for partner relationships"
  source: "`telecommunication_ecm`.`partner`.`partner_dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute"
    - name: "partner_id"
      expr: partner_id
      comment: "Partner involved in the dispute"
    - name: "dispute_category"
      expr: dispute_category
      comment: "Category or type of dispute"
    - name: "raised_year"
      expr: YEAR(raised_date)
      comment: "Year the dispute was raised"
  measures:
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total monetary amount under dispute"
    - name: "dispute_count"
      expr: COUNT(1)
      comment: "Number of dispute records"
    - name: "avg_resolution_days"
      expr: AVG(CAST(DATEDIFF(resolved_date, raised_date) AS DOUBLE))
      comment: "Average number of days to resolve disputes"
$$;