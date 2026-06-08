-- Metric views for domain: research | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 09:03:30

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`research_claim_substantiation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance of claim substantiation process, focusing on approval rates, cost and confidence"
  source: "`consumer_goods_ecm`.`research`.`claim_substantiation`"
  dimensions:
    - name: "claim_category"
      expr: claim_category
      comment: "Category of the claim being substantiated"
    - name: "claim_type"
      expr: claim_type
      comment: "Type of the claim (e.g., efficacy, safety)"
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status of the claim"
    - name: "product_formulation_id"
      expr: product_formulation_id
      comment: "Identifier of the product formulation linked to the claim"
    - name: "rd_project_id"
      expr: rd_project_id
      comment: "Research & Development project identifier"
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of claim substantiation records"
    - name: "approved_claims"
      expr: COUNT(CASE WHEN claim_approval_status = 'Approved' THEN 1 END)
      comment: "Number of claims with approval status = Approved"
    - name: "total_substantiation_cost"
      expr: SUM(CAST(substantiation_cost_amount AS DOUBLE))
      comment: "Sum of substantiation cost amounts across all claims"
    - name: "average_confidence_level_percent"
      expr: AVG(CAST(confidence_level_percent AS DOUBLE))
      comment: "Average confidence level percent for claim substantiations"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`research_consumer_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer test performance metrics to monitor study completion and satisfaction"
  source: "`consumer_goods_ecm`.`research`.`consumer_test`"
  dimensions:
    - name: "test_start_month"
      expr: DATE_TRUNC('month', test_start_date)
      comment: "Month of test start date for time‑based analysis"
  measures:
    - name: "total_tests"
      expr: COUNT(1)
      comment: "Total consumer tests conducted"
    - name: "average_overall_satisfaction_rating"
      expr: AVG(CAST(overall_satisfaction_rating AS DOUBLE))
      comment: "Average overall satisfaction rating from consumer tests"
    - name: "average_confidence_level"
      expr: AVG(CAST(confidence_level AS DOUBLE))
      comment: "Average confidence level reported in consumer tests"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`research_lab_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lab test quality and outcome metrics for R&D labs"
  source: "`consumer_goods_ecm`.`research`.`lab_test`"
  dimensions:
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/Fail outcome of the lab test"
    - name: "test_type"
      expr: test_type
      comment: "Lab test type (e.g., Stability, Compatibility)"
    - name: "test_date"
      expr: test_date
      comment: "Date the lab test was performed"
    - name: "product_formulation_id"
      expr: product_formulation_id
      comment: "Product formulation under test"
    - name: "rd_project_id"
      expr: rd_project_id
      comment: "R&D project linked to the lab test"
  measures:
    - name: "total_lab_tests"
      expr: COUNT(1)
      comment: "Total lab tests performed"
    - name: "passed_lab_tests"
      expr: COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END)
      comment: "Number of lab tests that passed"
    - name: "average_result_value"
      expr: AVG(CAST(result_value AS DOUBLE))
      comment: "Average numeric result value across lab tests"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`research_prototype`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prototype development efficiency and value metrics"
  source: "`consumer_goods_ecm`.`research`.`prototype`"
  dimensions:
    - name: "prototype_status"
      expr: prototype_status
      comment: "Current status of the prototype (e.g., Active, Closed)"
    - name: "target_launch_market"
      expr: target_launch_market
      comment: "Intended launch market for the prototype"
    - name: "product_formulation_id"
      expr: product_formulation_id
      comment: "Formulation linked to the prototype"
    - name: "rd_project_id"
      expr: rd_project_id
      comment: "R&D project driving the prototype"
  measures:
    - name: "total_prototypes"
      expr: COUNT(1)
      comment: "Total prototypes created"
    - name: "lead_time_days"
      expr: AVG(DATEDIFF(packaging_approval_date, DATE(created_timestamp)))
      comment: "Average days from prototype creation to packaging approval"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`research_scale_up_trial`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Scale‑up trial performance indicators for manufacturing readiness"
  source: "`consumer_goods_ecm`.`research`.`scale_up_trial`"
  dimensions:
    - name: "trial_status"
      expr: trial_status
      comment: "Current status of the trial (e.g., Completed, InProgress)"
    - name: "trial_type"
      expr: trial_type
      comment: "Type of scale‑up trial (e.g., Pilot, FullScale)"
    - name: "trial_month"
      expr: DATE_TRUNC('month', trial_date)
      comment: "Month when the trial took place"
    - name: "product_formulation_id"
      expr: product_formulation_id
      comment: "Formulation being scaled up"
    - name: "rd_project_id"
      expr: rd_project_id
      comment: "R&D project associated with the trial"
  measures:
    - name: "total_trials"
      expr: COUNT(1)
      comment: "Total scale‑up trials executed"
    - name: "completed_trials"
      expr: COUNT(CASE WHEN trial_status = 'Completed' THEN 1 END)
      comment: "Number of trials with status Completed"
    - name: "total_actual_output_kg"
      expr: SUM(CAST(actual_output_kg AS DOUBLE))
      comment: "Total actual output (kg) from all scale‑up trials"
    - name: "average_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across trials"
    - name: "total_trial_cost"
      expr: SUM(CAST(trial_cost_amount AS DOUBLE))
      comment: "Total cost incurred for scale‑up trials"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`research_safety_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety assessment KPIs to monitor product risk and compliance"
  source: "`consumer_goods_ecm`.`research`.`safety_assessment`"
  dimensions:
    - name: "safety_conclusion"
      expr: safety_conclusion
      comment: "Overall safety conclusion (e.g., Acceptable, Unacceptable)"
    - name: "regulatory_market_scope"
      expr: regulatory_market_scope
      comment: "Regulatory market scope covered by the assessment"
    - name: "assessment_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month of the safety assessment"
    - name: "product_formulation_id"
      expr: product_formulation_id
      comment: "Formulation linked to the safety assessment"
    - name: "rd_project_id"
      expr: rd_project_id
      comment: "R&D project tied to the safety assessment"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total safety assessments performed"
    - name: "average_margin_of_safety"
      expr: AVG(CAST(margin_of_safety AS DOUBLE))
      comment: "Average margin of safety across assessments"
    - name: "average_noael_value"
      expr: AVG(CAST(noael_value AS DOUBLE))
      comment: "Average NOAEL (No‑Observed‑Adverse‑Effect Level) value"
    - name: "high_risk_assessments"
      expr: COUNT(CASE WHEN safety_conclusion = 'Unacceptable' THEN 1 END)
      comment: "Number of assessments with an unacceptable safety conclusion"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`research_formulation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Formulation development metrics focusing on cost, sustainability and sensory performance"
  source: "`consumer_goods_ecm`.`research`.`research_formulation`"
  dimensions:
    - name: "formulation_type"
      expr: formulation_type
      comment: "Type of formulation (e.g., Shampoo, Lotion)"
    - name: "product_category"
      expr: product_category
      comment: "Product category of the formulation"
    - name: "development_status"
      expr: development_status
      comment: "Current development status (e.g., InDevelopment, Completed)"
    - name: "formulation_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the formulation record was created"
    - name: "rd_project_id"
      expr: rd_project_id
      comment: "R&D project associated with the formulation"
  measures:
    - name: "total_formulations"
      expr: COUNT(1)
      comment: "Total research formulations recorded"
    - name: "average_cost_target_per_unit"
      expr: AVG(CAST(cost_target_per_unit AS DOUBLE))
      comment: "Average target cost per unit for formulations"
    - name: "average_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score across formulations"
    - name: "average_sensory_evaluation_score"
      expr: AVG(CAST(sensory_evaluation_score AS DOUBLE))
      comment: "Average sensory evaluation score for formulations"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`research_innovation_brief`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic innovation brief KPIs to evaluate potential market impact and financial upside"
  source: "`consumer_goods_ecm`.`research`.`innovation_brief`"
  dimensions:
    - name: "brief_status"
      expr: brief_status
      comment: "Current status of the brief (e.g., Approved, Rejected)"
    - name: "brief_type"
      expr: brief_type
      comment: "Type of innovation brief (e.g., NewProduct, Enhancement)"
    - name: "target_consumer_segment"
      expr: target_consumer_segment
      comment: "Intended consumer segment for the innovation"
    - name: "brief_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the brief was created"
  measures:
    - name: "total_briefs"
      expr: COUNT(1)
      comment: "Total innovation briefs captured"
    - name: "average_estimated_roi_percent"
      expr: AVG(CAST(estimated_roi_percent AS DOUBLE))
      comment: "Average estimated ROI percent across briefs"
    - name: "average_estimated_npv"
      expr: AVG(CAST(estimated_npv AS DOUBLE))
      comment: "Average estimated Net Present Value"
    - name: "average_target_rsp"
      expr: AVG(CAST(target_rsp AS DOUBLE))
      comment: "Average target Retail Selling Price (RSP)"
$$;