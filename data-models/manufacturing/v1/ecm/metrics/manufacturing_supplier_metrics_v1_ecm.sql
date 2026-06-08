-- Metric views for domain: supplier | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 08:25:38

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supplier_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key agreement financial and renewal metrics for supplier contracts."
  source: "`manufacturing_ecm`.`supplier`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the agreement"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type/category of the agreement"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the agreement value"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the agreement became effective"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Identifier of the supplier"
  measures:
    - name: "total_agreement_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total monetary value of agreements"
    - name: "avg_agreement_value"
      expr: AVG(CAST(total_value AS DOUBLE))
      comment: "Average agreement value"
    - name: "agreement_count"
      expr: COUNT(1)
      comment: "Number of agreements"
    - name: "auto_renewal_agreements"
      expr: SUM(CASE WHEN auto_renewal_flag THEN 1 ELSE 0 END)
      comment: "Count of agreements with auto renewal enabled"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supplier_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier performance scorecard metrics."
  source: "`manufacturing_ecm`.`supplier`.`scorecard`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Identifier of the supplier"
    - name: "rating_tier"
      expr: rating_tier
      comment: "Overall rating tier assigned to the supplier"
    - name: "period_type"
      expr: period_type
      comment: "Period type of the scorecard (e.g., Quarterly, Annual)"
    - name: "evaluation_year"
      expr: YEAR(evaluation_period_start_date)
      comment: "Year of the evaluation period"
  measures:
    - name: "total_purchase_value"
      expr: SUM(CAST(total_purchase_value AS DOUBLE))
      comment: "Total purchase value across all scorecards"
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall performance score"
    - name: "avg_cost_score"
      expr: AVG(CAST(cost_score AS DOUBLE))
      comment: "Average cost performance score"
    - name: "avg_delivery_score"
      expr: AVG(CAST(delivery_score AS DOUBLE))
      comment: "Average delivery performance score"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality performance score"
    - name: "avg_responsiveness_score"
      expr: AVG(CAST(responsiveness_score AS DOUBLE))
      comment: "Average responsiveness score"
    - name: "scorecard_count"
      expr: COUNT(1)
      comment: "Number of scorecards"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supplier_risk_rating`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated risk assessment metrics for suppliers."
  source: "`manufacturing_ecm`.`supplier`.`risk_rating`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Identifier of the supplier"
    - name: "overall_risk_tier"
      expr: overall_risk_tier
      comment: "Overall risk tier classification"
    - name: "country_risk_rating"
      expr: country_risk_rating
      comment: "Country-level risk rating"
    - name: "assessment_year"
      expr: YEAR(assessment_period_start_date)
      comment: "Year of the risk assessment period"
  measures:
    - name: "avg_overall_risk_score"
      expr: AVG(CAST(overall_risk_score AS DOUBLE))
      comment: "Average overall risk score"
    - name: "avg_financial_risk_score"
      expr: AVG(CAST(financial_risk_score AS DOUBLE))
      comment: "Average financial risk score"
    - name: "avg_operational_risk_score"
      expr: AVG(CAST(operational_risk_score AS DOUBLE))
      comment: "Average operational risk score"
    - name: "risk_rating_count"
      expr: COUNT(1)
      comment: "Number of risk rating records"
    - name: "high_overall_risk_count"
      expr: SUM(CASE WHEN overall_risk_score > 80 THEN 1 ELSE 0 END)
      comment: "Count of high overall risk scores (>80)"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supplier_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site-level capacity and quality performance metrics."
  source: "`manufacturing_ecm`.`supplier`.`site`"
  dimensions:
    - name: "site_status"
      expr: site_status
      comment: "Current operational status of the site"
    - name: "site_type"
      expr: site_type
      comment: "Type/category of the site"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the site"
    - name: "country_code"
      expr: country_code
      comment: "Country code where the site is located"
    - name: "site_name"
      expr: site_name
      comment: "Descriptive name of the site"
    - name: "active_year"
      expr: YEAR(active_from_date)
      comment: "Year the site became active"
  measures:
    - name: "avg_delivery_performance_score"
      expr: AVG(CAST(delivery_performance_score AS DOUBLE))
      comment: "Average delivery performance score across sites"
    - name: "total_production_capacity_annual"
      expr: SUM(CAST(production_capacity_annual AS DOUBLE))
      comment: "Total annual production capacity across all sites"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across sites"
    - name: "site_count"
      expr: COUNT(1)
      comment: "Number of supplier sites"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`supplier_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Certification coverage and status metrics for suppliers."
  source: "`manufacturing_ecm`.`supplier`.`supplier_certification`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Identifier of the supplier"
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g., ISO, IEC)"
    - name: "accreditation_body"
      expr: accreditation_body
      comment: "Accrediting organization for the certification"
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification"
    - name: "certification_year"
      expr: YEAR(effective_date)
      comment: "Year the certification became effective"
  measures:
    - name: "certification_count"
      expr: COUNT(1)
      comment: "Total number of certifications recorded"
    - name: "active_certification_count"
      expr: SUM(CASE WHEN expiry_date >= CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Number of certifications that are currently active"
$$;