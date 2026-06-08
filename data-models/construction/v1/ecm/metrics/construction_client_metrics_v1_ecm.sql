-- Metric views for domain: client | Business: Construction | Version: 1 | Generated on: 2026-05-07 07:27:43

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`client_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core client account financial overview"
  source: "`construction_ecm`.`client`.`account`"
  dimensions:
    - name: "country_code"
      expr: country_code
      comment: "ISO country code of the account"
    - name: "account_type"
      expr: account_type
      comment: "Classification of the account (e.g., corporate, government)"
    - name: "account_status"
      expr: account_status
      comment: "Current operational status of the account"
    - name: "industry_sector"
      expr: industry_sector
      comment: "Industry sector the client belongs to"
    - name: "client_tier"
      expr: client_tier
      comment: "Strategic tier of the client"
  measures:
    - name: "account_count"
      expr: COUNT(1)
      comment: "Total number of client accounts"
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Sum of annual revenue across all accounts"
    - name: "avg_annual_revenue"
      expr: AVG(CAST(annual_revenue AS DOUBLE))
      comment: "Average annual revenue per account"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit allocated to accounts"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`client_account_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk and exposure metrics for client accounts"
  source: "`construction_ecm`.`client`.`account_credit_profile`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the credit profile"
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the credit profile"
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Indicates if the account is on credit hold"
    - name: "credit_insurance_flag"
      expr: credit_insurance_flag
      comment: "Indicates if credit insurance is in place"
  measures:
    - name: "credit_profile_count"
      expr: COUNT(1)
      comment: "Number of credit profiles"
    - name: "total_credit_limit_amount"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Aggregate credit limit amount across profiles"
    - name: "avg_dso_days"
      expr: AVG(CAST(dso_days AS DOUBLE))
      comment: "Average Days Sales Outstanding"
    - name: "total_current_exposure_amount"
      expr: SUM(CAST(current_exposure_amount AS DOUBLE))
      comment: "Total current exposure amount"
    - name: "credit_hold_count"
      expr: SUM(CASE WHEN credit_hold_flag THEN 1 ELSE 0 END)
      comment: "Count of credit holds"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`client_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Opportunity pipeline performance metrics"
  source: "`construction_ecm`.`client`.`client_opportunity`"
  dimensions:
    - name: "opportunity_status"
      expr: opportunity_status
      comment: "Current status of the opportunity"
    - name: "pipeline_stage"
      expr: pipeline_stage
      comment: "Stage of the opportunity in the sales pipeline"
    - name: "sector"
      expr: sector
      comment: "Industry sector of the opportunity"
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model associated with the opportunity"
  measures:
    - name: "opportunity_count"
      expr: COUNT(1)
      comment: "Total number of client opportunities"
    - name: "total_estimated_contract_value"
      expr: SUM(CAST(estimated_contract_value AS DOUBLE))
      comment: "Sum of estimated contract values for opportunities"
    - name: "avg_probability_of_win_pct"
      expr: AVG(CAST(probability_of_win_pct AS DOUBLE))
      comment: "Average win probability percentage"
    - name: "total_weighted_pipeline_value"
      expr: SUM(CAST(weighted_pipeline_value AS DOUBLE))
      comment: "Weighted pipeline value across opportunities"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`client_project_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and satisfaction metrics for project engagements"
  source: "`construction_ecm`.`client`.`project_engagement`"
  dimensions:
    - name: "engagement_status"
      expr: engagement_status
      comment: "Current status of the engagement"
    - name: "sector"
      expr: sector
      comment: "Sector of the project"
    - name: "contract_currency"
      expr: contract_currency
      comment: "Currency of the contract"
    - name: "engagement_type"
      expr: engagement_type
      comment: "Type of engagement (e.g., design, construction)"
  measures:
    - name: "engagement_count"
      expr: COUNT(1)
      comment: "Number of project engagements"
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contract value across engagements"
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage retained on contracts"
    - name: "avg_satisfaction_score"
      expr: AVG(CAST(satisfaction_score AS DOUBLE))
      comment: "Average client satisfaction score for engagements"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`client_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client satisfaction and experience metrics from surveys"
  source: "`construction_ecm`.`client`.`survey`"
  dimensions:
    - name: "survey_status"
      expr: survey_status
      comment: "Current processing status of the survey"
    - name: "survey_type"
      expr: survey_type
      comment: "Type/category of the survey"
    - name: "client_sector"
      expr: client_sector
      comment: "Sector of the client providing the survey"
    - name: "language_code"
      expr: language_code
      comment: "Language in which the survey was completed"
    - name: "nps_category"
      expr: nps_category
      comment: "Net Promoter Score category (Promoter, Passive, Detractor)"
  measures:
    - name: "survey_count"
      expr: COUNT(1)
      comment: "Total number of surveys collected"
    - name: "avg_overall_satisfaction_score"
      expr: AVG(CAST(overall_satisfaction_score AS DOUBLE))
      comment: "Average overall satisfaction score from surveys"
    - name: "avg_communication_score"
      expr: AVG(CAST(communication_score AS DOUBLE))
      comment: "Average communication effectiveness score"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average perceived quality score"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`client_rfp_issuance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key procurement and financial metrics for RFP issuances"
  source: "`construction_ecm`.`client`.`rfp_issuance`"
  dimensions:
    - name: "rfp_status"
      expr: rfp_status
      comment: "Current status of the RFP"
    - name: "country_code"
      expr: country_code
      comment: "Country where the RFP is issued"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract sought"
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model specified in the RFP"
  measures:
    - name: "rfp_count"
      expr: COUNT(1)
      comment: "Number of RFP issuances"
    - name: "total_estimated_contract_value"
      expr: SUM(CAST(estimated_contract_value AS DOUBLE))
      comment: "Sum of estimated contract values for RFPs"
    - name: "avg_bid_bond_percentage"
      expr: AVG(CAST(bid_bond_percentage AS DOUBLE))
      comment: "Average bid bond percentage required"
    - name: "avg_performance_bond_percentage"
      expr: AVG(CAST(performance_bond_percentage AS DOUBLE))
      comment: "Average performance bond percentage required"
$$;