-- Metric views for domain: bid | Business: Construction | Version: 1 | Generated on: 2026-05-07 07:27:43

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`bid_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Opportunity pipeline and win metrics."
  source: "`construction_ecm`.`bid`.`bid_opportunity`"
  dimensions:
    - name: "win_loss_status"
      expr: win_loss_status
      comment: "Current win/loss status of the opportunity."
    - name: "stage"
      expr: stage
      comment: "Current stage in the opportunity lifecycle."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment of the opportunity."
    - name: "country_code"
      expr: country_code
      comment: "Country where the opportunity resides."
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Flag indicating if the opportunity is a joint venture."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for financial fields."
    - name: "opportunity_year"
      expr: DATE_TRUNC('year', created_timestamp)
      comment: "Year the opportunity was created."
  measures:
    - name: "total_estimated_contract_value"
      expr: SUM(CAST(estimated_contract_value AS DOUBLE))
      comment: "Total estimated contract value across opportunities."
    - name: "avg_probability_of_win"
      expr: AVG(CAST(probability_of_win AS DOUBLE))
      comment: "Average probability of win for opportunities."
    - name: "won_opportunity_count"
      expr: COUNT(CASE WHEN win_loss_status = 'Won' THEN 1 END)
      comment: "Count of opportunities that were won."
    - name: "total_opportunity_count"
      expr: COUNT(1)
      comment: "Total number of opportunities."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`bid_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Submission level financial and scoring metrics."
  source: "`construction_ecm`.`bid`.`submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the submission (e.g., Submitted, Reviewed)."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the bid."
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Flag indicating joint venture submission."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the submission."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the submission."
    - name: "bid_type"
      expr: bid_type
      comment: "Type of bid (e.g., Lump Sum, GMP)."
    - name: "submission_year"
      expr: DATE_TRUNC('year', created_timestamp)
      comment: "Year the submission was created."
  measures:
    - name: "total_bid_price"
      expr: SUM(CAST(bid_price AS DOUBLE))
      comment: "Total bid price submitted."
    - name: "avg_technical_score"
      expr: AVG(CAST(technical_score AS DOUBLE))
      comment: "Average technical score across submissions."
    - name: "avg_commercial_score"
      expr: AVG(CAST(commercial_score AS DOUBLE))
      comment: "Average commercial score across submissions."
    - name: "submission_count"
      expr: COUNT(1)
      comment: "Number of bid submissions."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`bid_tender`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tender level bond and evaluation metrics."
  source: "`construction_ecm`.`bid`.`tender`"
  dimensions:
    - name: "tender_type"
      expr: tender_type
      comment: "Classification of the tender (e.g., Open, Select)."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method used."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the tender."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating for the tender."
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Flag indicating joint venture tender."
    - name: "submission_status"
      expr: submission_status
      comment: "Current submission status of the tender."
    - name: "tender_year"
      expr: DATE_TRUNC('year', created_timestamp)
      comment: "Year the tender was created."
  measures:
    - name: "total_bid_bond_amount"
      expr: SUM(CAST(bid_bond_amount AS DOUBLE))
      comment: "Total bid bond amount across tenders."
    - name: "avg_evaluation_score"
      expr: AVG(CAST(evaluation_score AS DOUBLE))
      comment: "Average evaluation score for tenders."
    - name: "tender_count"
      expr: COUNT(1)
      comment: "Number of tenders."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`bid_performance_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated performance scorecard metrics."
  source: "`construction_ecm`.`bid`.`performance_scorecard`"
  dimensions:
    - name: "evaluator_role"
      expr: evaluator_role
      comment: "Role of the evaluator (e.g., Manager, Director)."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall rating category."
    - name: "evaluation_year"
      expr: DATE_TRUNC('year', evaluation_date)
      comment: "Year of the evaluation."
  measures:
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall performance score."
    - name: "avg_hse_score"
      expr: AVG(CAST(hse_score AS DOUBLE))
      comment: "Average health, safety, and environment score."
    - name: "avg_schedule_score"
      expr: AVG(CAST(schedule_score AS DOUBLE))
      comment: "Average schedule adherence score."
    - name: "scorecard_count"
      expr: COUNT(1)
      comment: "Number of performance scorecards recorded."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`bid_win_loss_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial outcomes and win/loss statistics."
  source: "`construction_ecm`.`bid`.`win_loss_record`"
  dimensions:
    - name: "outcome_status"
      expr: outcome_status
      comment: "Outcome of the bid (e.g., Won, Lost)."
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Flag indicating joint venture involvement."
    - name: "win_loss_number"
      expr: win_loss_number
      comment: "Unique identifier for the win/loss record."
    - name: "evaluation_method"
      expr: evaluation_method
      comment: "Method used to evaluate the bid."
    - name: "win_loss_year"
      expr: DATE_TRUNC('year', created_timestamp)
      comment: "Year the win/loss record was created."
  measures:
    - name: "total_awarded_contract_value"
      expr: SUM(CAST(awarded_contract_value AS DOUBLE))
      comment: "Total value of awarded contracts."
    - name: "avg_price_gap_to_winner"
      expr: AVG(CAST(price_gap_to_winner AS DOUBLE))
      comment: "Average price gap to the winning bid."
    - name: "win_record_count"
      expr: COUNT(1)
      comment: "Number of win/loss records."
    - name: "win_count"
      expr: COUNT(CASE WHEN outcome_status = 'Won' THEN 1 END)
      comment: "Count of records where the outcome was a win."
$$;