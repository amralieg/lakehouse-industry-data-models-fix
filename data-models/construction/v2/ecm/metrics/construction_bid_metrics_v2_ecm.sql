-- Metric views for domain: bid | Business: Construction | Version: 2 | Generated on: 2026-06-22 15:07:26

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic pipeline metrics for bid opportunities — tracks estimated contract value, win probability, and pipeline composition to steer pursuit investment and revenue forecasting."
  source: "`vibe_construction_v1`.`bid`.`bid_opportunity`"
  dimensions:
    - name: "opportunity_stage"
      expr: stage
      comment: "Current pursuit stage (e.g. Qualify, Develop, Propose, Negotiate) for pipeline funnel analysis."
    - name: "opportunity_status"
      expr: bid_opportunity_status
      comment: "Lifecycle status of the bid opportunity (Active, Won, Lost, Withdrawn)."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment (e.g. Infrastructure, Commercial, Industrial) for portfolio mix analysis."
    - name: "project_type"
      expr: project_type
      comment: "Type of construction project (e.g. Greenfield, Renovation, EPC) for strategic segmentation."
    - name: "bid_decision"
      expr: bid_decision
      comment: "Go/No-Go decision outcome for the opportunity."
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Flag indicating whether the opportunity is pursued as a joint venture."
    - name: "pipeline_forecast_category"
      expr: pipeline_forecast_category
      comment: "Sales pipeline forecast category (Commit, Best Case, Pipeline) for revenue forecasting."
    - name: "country_code"
      expr: country_code
      comment: "Country where the opportunity is located for geographic portfolio analysis."
    - name: "gmp_type"
      expr: gmp_type
      comment: "Guaranteed Maximum Price contract type indicator for commercial risk segmentation."
    - name: "bid_due_date_month"
      expr: DATE_TRUNC('MONTH', bid_due_date)
      comment: "Month of bid due date for time-series pipeline analysis."
  measures:
    - name: "total_opportunities"
      expr: COUNT(1)
      comment: "Total number of bid opportunities in the pipeline. Baseline volume KPI for pipeline health."
    - name: "total_estimated_contract_value"
      expr: SUM(CAST(estimated_contract_value AS DOUBLE))
      comment: "Sum of estimated contract values across all opportunities. Core revenue pipeline metric for executive forecasting."
    - name: "avg_estimated_contract_value"
      expr: AVG(CAST(estimated_contract_value AS DOUBLE))
      comment: "Average estimated contract value per opportunity. Indicates deal size trends and portfolio mix shifts."
    - name: "total_weighted_pipeline_value"
      expr: SUM(CAST(estimated_contract_value AS DOUBLE) * CAST(probability_of_win AS DOUBLE) / 100.0)
      comment: "Probability-weighted pipeline value (ECValue × Win%). The primary revenue forecast metric used in executive pipeline reviews."
    - name: "avg_probability_of_win"
      expr: AVG(CAST(probability_of_win AS DOUBLE))
      comment: "Average win probability across active opportunities. Signals overall bid competitiveness and pursuit quality."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied across opportunities. Tracks commercial concessions that erode margin."
    - name: "total_net_estimated_value"
      expr: SUM(CAST(net_estimated_value AS DOUBLE))
      comment: "Sum of net estimated values after discounts. Represents the realistic revenue pipeline after commercial adjustments."
    - name: "total_bid_bond_amount"
      expr: SUM(CAST(bid_bond_amount AS DOUBLE))
      comment: "Total bid bond exposure across all opportunities. Tracks bonding capacity utilization and financial risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_tender`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tender pipeline and award metrics — tracks tender values, evaluation scores, and award outcomes to measure bid conversion effectiveness and commercial performance."
  source: "`vibe_construction_v1`.`bid`.`tender`"
  dimensions:
    - name: "tender_status"
      expr: tender_status
      comment: "Current status of the tender (Open, Submitted, Awarded, Lost, Cancelled)."
    - name: "tender_type"
      expr: tender_type
      comment: "Type of tender (Open, Selective, Negotiated) for procurement method analysis."
    - name: "award_status"
      expr: award_status
      comment: "Award decision status (Awarded, Pending, Not Awarded) for conversion tracking."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method used (e.g. Competitive, Sole Source, Framework) for strategic analysis."
    - name: "bid_type"
      expr: bid_type
      comment: "Type of bid submitted (Lump Sum, Unit Rate, Cost Plus) for commercial risk segmentation."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the tender for regional performance analysis."
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Flag indicating joint venture tender for partnership performance tracking."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of tender submission for time-series conversion analysis."
    - name: "evaluation_method"
      expr: evaluation_method
      comment: "Evaluation method applied (Lowest Price, Best Value, MEAT) for competitive intelligence."
  measures:
    - name: "total_tenders"
      expr: COUNT(1)
      comment: "Total number of tenders tracked. Baseline volume metric for bid activity."
    - name: "total_tender_value"
      expr: SUM(CAST(value AS DOUBLE))
      comment: "Total value of all tenders. Core revenue pipeline metric for executive reporting."
    - name: "total_estimated_tender_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Sum of estimated tender values. Used for pipeline forecasting before final pricing."
    - name: "avg_evaluation_score"
      expr: AVG(CAST(evaluation_score AS DOUBLE))
      comment: "Average evaluation score across tenders. Measures bid quality and competitiveness."
    - name: "total_bid_bond_exposure"
      expr: SUM(CAST(bid_bond_amount AS DOUBLE))
      comment: "Total bid bond financial exposure across all tenders. Tracks bonding capacity utilization."
    - name: "avg_estimated_duration_months"
      expr: AVG(CAST(estimated_duration_months AS DOUBLE))
      comment: "Average estimated project duration in months. Informs resource planning and backlog forecasting."
    - name: "tenders_with_regulatory_approval_required"
      expr: COUNT(CASE WHEN regulatory_approval_required = TRUE THEN 1 END)
      comment: "Count of tenders requiring regulatory approval. Tracks compliance risk exposure in the pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bid submission performance metrics — tracks submitted bid prices, technical and commercial scores, and compliance to evaluate bid quality and conversion effectiveness."
  source: "`vibe_construction_v1`.`bid`.`submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the submission (Submitted, Under Review, Evaluated, Awarded, Rejected)."
    - name: "bid_type"
      expr: bid_type
      comment: "Type of bid (Lump Sum, Unit Rate, Cost Plus) for commercial risk segmentation."
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Flag indicating joint venture submission for partnership performance tracking."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the submission for regional win-rate analysis."
    - name: "evaluation_method"
      expr: evaluation_method
      comment: "Evaluation method applied to the submission for competitive benchmarking."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the submission for portfolio risk management."
    - name: "late_submission_flag"
      expr: late_submission_flag
      comment: "Flag indicating whether the submission was submitted after the deadline."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of submission for time-series bid activity analysis."
    - name: "compliance_requirements_met"
      expr: compliance_requirements_met
      comment: "Flag indicating whether all compliance requirements were met at submission."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of bid submissions. Baseline bid activity volume metric."
    - name: "total_submitted_value"
      expr: SUM(CAST(submitted_value AS DOUBLE))
      comment: "Total value of all submitted bids. Core revenue pipeline metric for executive reporting."
    - name: "total_bid_price"
      expr: SUM(CAST(bid_price AS DOUBLE))
      comment: "Sum of all bid prices submitted. Tracks total commercial exposure in submitted bids."
    - name: "avg_bid_price"
      expr: AVG(CAST(bid_price AS DOUBLE))
      comment: "Average bid price per submission. Indicates deal size trends and pricing strategy effectiveness."
    - name: "avg_technical_score"
      expr: AVG(CAST(technical_score AS DOUBLE))
      comment: "Average technical evaluation score across submissions. Measures technical bid quality and competitiveness."
    - name: "avg_commercial_score"
      expr: AVG(CAST(commercial_score AS DOUBLE))
      comment: "Average commercial evaluation score across submissions. Measures pricing competitiveness."
    - name: "total_bid_bond_amount"
      expr: SUM(CAST(bid_bond_amount AS DOUBLE))
      comment: "Total bid bond financial exposure across submissions. Tracks bonding capacity utilization."
    - name: "late_submission_count"
      expr: COUNT(CASE WHEN late_submission_flag = TRUE THEN 1 END)
      comment: "Number of late submissions. Tracks bid process discipline and compliance risk."
    - name: "avg_estimated_duration_months"
      expr: AVG(CAST(estimated_duration_months AS DOUBLE))
      comment: "Average estimated project duration in months across submissions. Informs backlog and resource planning."
    - name: "total_bid_price_adjustment"
      expr: SUM(CAST(bid_price_adjustment AS DOUBLE))
      comment: "Total bid price adjustments applied. Tracks commercial concessions and pricing corrections."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_estimate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bid estimate accuracy and cost composition metrics — tracks total estimated costs, margin, contingency, and overhead to evaluate estimating quality and commercial risk."
  source: "`vibe_construction_v1`.`bid`.`estimate`"
  dimensions:
    - name: "estimate_status"
      expr: estimate_status
      comment: "Current status of the estimate (Draft, In Review, Approved, Superseded)."
    - name: "estimate_type"
      expr: estimate_type
      comment: "Type of estimate (Conceptual, Preliminary, Definitive, Bid) for accuracy benchmarking."
    - name: "estimate_category"
      expr: estimate_category
      comment: "Category of estimate (Civil, Mechanical, Electrical) for cost breakdown analysis."
    - name: "estimating_method"
      expr: estimating_method
      comment: "Estimating methodology used (Parametric, Bottom-Up, Analogous) for accuracy tracking."
    - name: "is_gmp"
      expr: is_gmp
      comment: "Flag indicating Guaranteed Maximum Price estimate for commercial risk segmentation."
    - name: "is_lump_sum"
      expr: is_lump_sum
      comment: "Flag indicating lump sum pricing for contract type analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the estimate for multi-currency portfolio analysis."
    - name: "revision_date_month"
      expr: DATE_TRUNC('MONTH', revision_date)
      comment: "Month of estimate revision for estimating cycle time analysis."
  measures:
    - name: "total_estimates"
      expr: COUNT(1)
      comment: "Total number of estimates produced. Baseline estimating activity metric."
    - name: "total_estimated_cost"
      expr: SUM(CAST(total_estimated_cost AS DOUBLE))
      comment: "Sum of all total estimated costs. Core cost pipeline metric for executive financial planning."
    - name: "avg_estimated_cost"
      expr: AVG(CAST(total_estimated_cost AS DOUBLE))
      comment: "Average estimated cost per estimate. Tracks deal size trends and estimating scope."
    - name: "avg_margin_percentage"
      expr: AVG(CAST(margin_percentage AS DOUBLE))
      comment: "Average margin percentage across estimates. Key profitability indicator for bid strategy decisions."
    - name: "avg_contingency_percentage"
      expr: AVG(CAST(contingency_percentage AS DOUBLE))
      comment: "Average contingency percentage applied. Measures risk provisioning discipline in estimating."
    - name: "avg_overhead_percentage"
      expr: AVG(CAST(overhead_percentage AS DOUBLE))
      comment: "Average overhead percentage applied. Tracks overhead allocation consistency across bids."
    - name: "avg_profit_margin_percentage"
      expr: AVG(CAST(profit_margin_percentage AS DOUBLE))
      comment: "Average profit margin percentage across estimates. Direct profitability KPI for bid portfolio management."
    - name: "total_escalation_allowance"
      expr: SUM(CAST(escalation_allowance AS DOUBLE))
      comment: "Total escalation allowance provisioned across estimates. Tracks inflation risk exposure in the bid portfolio."
    - name: "avg_risk_factor"
      expr: AVG(CAST(risk_factor AS DOUBLE))
      comment: "Average risk factor applied to estimates. Measures risk-adjusted pricing discipline."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_estimate_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Estimate line-level cost composition metrics — tracks cost by category, variance, and productivity to identify cost drivers and estimating accuracy at the work-package level."
  source: "`vibe_construction_v1`.`bid`.`estimate_line`"
  dimensions:
    - name: "estimate_line_status"
      expr: estimate_line_status
      comment: "Status of the estimate line (Active, Revised, Deleted) for cost tracking."
    - name: "material_type"
      expr: material_type
      comment: "Type of material for cost breakdown analysis by material category."
    - name: "labor_grade"
      expr: labor_grade
      comment: "Labor grade classification for workforce cost analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity-based cost analysis."
    - name: "wbs_element"
      expr: wbs_element
      comment: "WBS element code for cost breakdown by work package."
    - name: "location_code"
      expr: location_code
      comment: "Location code for geographic cost distribution analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the estimate line for multi-currency analysis."
    - name: "is_deleted"
      expr: is_deleted
      comment: "Flag indicating deleted lines for data quality and scope change tracking."
  measures:
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost across all lines. Core cost build-up metric for bid pricing."
    - name: "total_baseline_cost"
      expr: SUM(CAST(baseline_cost AS DOUBLE))
      comment: "Total baseline cost across all lines. Reference point for cost variance analysis."
    - name: "total_revised_cost"
      expr: SUM(CAST(revised_cost AS DOUBLE))
      comment: "Total revised cost after changes. Tracks scope and cost evolution during estimating."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total cost variance (revised vs baseline). Key estimating accuracy KPI for continuous improvement."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across estimate lines. Tracks tax exposure in bid pricing."
    - name: "avg_productivity_factor"
      expr: AVG(CAST(productivity_factor AS DOUBLE))
      comment: "Average productivity factor applied. Measures labor productivity assumptions in estimating."
    - name: "avg_waste_factor"
      expr: AVG(CAST(waste_factor AS DOUBLE))
      comment: "Average waste factor applied to material lines. Tracks material waste provisioning in bids."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity across estimate lines. Supports scope volume analysis and unit rate benchmarking."
    - name: "total_unit_cost"
      expr: SUM(CAST(unit_cost AS DOUBLE))
      comment: "Sum of unit costs across lines. Used for unit rate benchmarking and cost normalization."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_boq_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of Quantities line-level cost metrics — tracks material, labour, plant, and subcontract costs to support bid pricing analysis and cost category benchmarking."
  source: "`vibe_construction_v1`.`bid`.`bid_boq_line`"
  dimensions:
    - name: "bid_boq_line_status"
      expr: bid_boq_line_status
      comment: "Status of the BOQ line (Active, Revised, Deleted) for cost tracking."
    - name: "work_section"
      expr: work_section
      comment: "Work section classification for cost breakdown by trade or discipline."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity-based cost analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the BOQ line for risk-weighted cost analysis."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flag indicating critical path items for schedule-cost integration analysis."
    - name: "is_lump_sum"
      expr: is_lump_sum
      comment: "Flag indicating lump sum pricing for contract type analysis."
    - name: "is_gmp_applicable"
      expr: is_gmp_applicable
      comment: "Flag indicating GMP applicability for commercial risk segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the BOQ line for multi-currency portfolio analysis."
    - name: "change_order_flag"
      expr: change_order_flag
      comment: "Flag indicating change order impact on the BOQ line."
  measures:
    - name: "total_line_total"
      expr: SUM(CAST(line_total AS DOUBLE))
      comment: "Total value of all BOQ lines. Core bid pricing metric for executive cost review."
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost AS DOUBLE))
      comment: "Total material cost across BOQ lines. Tracks material cost composition in the bid."
    - name: "total_labour_cost"
      expr: SUM(CAST(labour_cost AS DOUBLE))
      comment: "Total labour cost across BOQ lines. Tracks workforce cost composition in the bid."
    - name: "total_plant_cost"
      expr: SUM(CAST(plant_cost AS DOUBLE))
      comment: "Total plant and equipment cost across BOQ lines. Tracks equipment cost composition."
    - name: "total_subcontract_cost"
      expr: SUM(CAST(subcontract_cost AS DOUBLE))
      comment: "Total subcontract cost across BOQ lines. Tracks subcontractor cost exposure in the bid."
    - name: "total_overhead_amount"
      expr: SUM(CAST(overhead_amount AS DOUBLE))
      comment: "Total overhead amount across BOQ lines. Tracks overhead allocation in bid pricing."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across BOQ lines. Tracks tax exposure in bid pricing."
    - name: "avg_profit_margin_percent"
      expr: AVG(CAST(profit_margin_percent AS DOUBLE))
      comment: "Average profit margin percentage across BOQ lines. Key profitability KPI for bid portfolio management."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity across BOQ lines. Supports scope volume analysis and unit rate benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_win_loss_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Win/loss performance metrics — tracks awarded contract values, evaluation scores, and loss reasons to drive bid strategy improvement and competitive intelligence."
  source: "`vibe_construction_v1`.`bid`.`win_loss_record`"
  dimensions:
    - name: "outcome_status"
      expr: outcome_status
      comment: "Win/loss outcome (Won, Lost, No Bid, Withdrawn) for conversion rate analysis."
    - name: "bid_type"
      expr: bid_type
      comment: "Type of bid (Lump Sum, Unit Rate, Cost Plus) for commercial strategy analysis."
    - name: "loss_reason_category"
      expr: loss_reason_category
      comment: "Category of loss reason (Price, Technical, Relationship, Scope) for root cause analysis."
    - name: "evaluation_method"
      expr: evaluation_method
      comment: "Evaluation method used (Lowest Price, Best Value) for competitive benchmarking."
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Flag indicating joint venture bid for partnership performance tracking."
    - name: "is_award_confirmed"
      expr: is_award_confirmed
      comment: "Flag indicating confirmed award for revenue recognition planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the bid for multi-currency portfolio analysis."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_timestamp)
      comment: "Month of award decision for time-series win rate analysis."
  measures:
    - name: "total_bids_tracked"
      expr: COUNT(1)
      comment: "Total number of win/loss records. Baseline bid activity volume metric."
    - name: "total_awarded_contract_value"
      expr: SUM(CAST(awarded_contract_value AS DOUBLE))
      comment: "Total value of awarded contracts. Core revenue conversion metric for executive reporting."
    - name: "total_winning_bid_price"
      expr: SUM(CAST(winning_bid_price AS DOUBLE))
      comment: "Total winning bid price across all records. Tracks competitive pricing benchmarks."
    - name: "avg_price_gap_to_winner"
      expr: AVG(CAST(price_gap_to_winner AS DOUBLE))
      comment: "Average price gap to the winning bid. Key competitive intelligence metric for pricing strategy calibration."
    - name: "avg_technical_evaluation_score"
      expr: AVG(CAST(evaluation_score_technical AS DOUBLE))
      comment: "Average technical evaluation score. Measures technical bid quality and competitiveness."
    - name: "avg_commercial_evaluation_score"
      expr: AVG(CAST(evaluation_score_commercial AS DOUBLE))
      comment: "Average commercial evaluation score. Measures pricing competitiveness across bids."
    - name: "avg_hsse_evaluation_score"
      expr: AVG(CAST(evaluation_score_hsse AS DOUBLE))
      comment: "Average HSSE evaluation score. Tracks safety performance as a bid differentiator."
    - name: "wins_count"
      expr: COUNT(CASE WHEN outcome_status = 'Won' THEN 1 END)
      comment: "Number of won bids. Numerator for win rate calculation and conversion tracking."
    - name: "total_bid_bond_amount"
      expr: SUM(CAST(bid_bond_amount AS DOUBLE))
      comment: "Total bid bond exposure across win/loss records. Tracks bonding capacity utilization."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bid governance and approval metrics — tracks approval scores, bid prices, and decision outcomes to evaluate governance quality and pursuit investment discipline."
  source: "`vibe_construction_v1`.`bid`.`approval`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current status of the approval (Pending, Approved, Rejected, Conditional)."
    - name: "decision_outcome"
      expr: decision_outcome
      comment: "Final decision outcome (Go, No-Go, Conditional Go) for pursuit decision analysis."
    - name: "decision_stage"
      expr: decision_stage
      comment: "Stage at which the approval decision was made (Gate 1, Gate 2, Final) for governance process analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned at approval for portfolio risk management."
    - name: "delegation_of_authority_level"
      expr: delegation_of_authority_level
      comment: "Delegation of authority level required for the approval decision."
    - name: "is_conditional"
      expr: is_conditional
      comment: "Flag indicating conditional approval for compliance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the approved bid price for multi-currency analysis."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_timestamp)
      comment: "Month of approval decision for governance cycle time analysis."
  measures:
    - name: "total_approvals"
      expr: COUNT(1)
      comment: "Total number of bid approvals processed. Baseline governance activity metric."
    - name: "total_approved_bid_price"
      expr: SUM(CAST(approved_bid_price AS DOUBLE))
      comment: "Total approved bid price across all approvals. Core revenue commitment metric for executive reporting."
    - name: "avg_approved_margin_pct"
      expr: AVG(CAST(approved_margin_pct AS DOUBLE))
      comment: "Average approved margin percentage. Key profitability governance KPI for bid portfolio management."
    - name: "avg_total_governance_score"
      expr: AVG(CAST(total_governance_score AS DOUBLE))
      comment: "Average total governance score across approvals. Measures overall bid quality and pursuit discipline."
    - name: "avg_strategic_fit_score"
      expr: AVG(CAST(strategic_fit_score AS DOUBLE))
      comment: "Average strategic fit score. Tracks alignment of pursued bids with corporate strategy."
    - name: "avg_risk_profile_score"
      expr: AVG(CAST(risk_profile_score AS DOUBLE))
      comment: "Average risk profile score at approval. Measures risk-adjusted pursuit quality."
    - name: "avg_bonding_capacity_score"
      expr: AVG(CAST(bonding_capacity_score AS DOUBLE))
      comment: "Average bonding capacity score. Tracks financial capacity utilization in bid approvals."
    - name: "conditional_approvals_count"
      expr: COUNT(CASE WHEN is_conditional = TRUE THEN 1 END)
      comment: "Number of conditional approvals. Tracks governance exceptions requiring follow-up actions."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bid risk exposure metrics — tracks contingency amounts, residual risk scores, and risk categories to support risk-adjusted pricing and pursuit decision-making."
  source: "`vibe_construction_v1`.`bid`.`bid_risk`"
  dimensions:
    - name: "bid_risk_status"
      expr: bid_risk_status
      comment: "Current status of the bid risk (Open, Mitigated, Closed, Transferred)."
    - name: "risk_category"
      expr: risk_category
      comment: "Category of risk (Commercial, Technical, Schedule, Regulatory) for risk portfolio analysis."
    - name: "probability_rating"
      expr: probability_rating
      comment: "Probability rating (High, Medium, Low) for risk prioritization."
    - name: "priority"
      expr: priority
      comment: "Risk priority level for management attention and mitigation resource allocation."
    - name: "origin"
      expr: origin
      comment: "Origin of the risk (Client, Design, Market, Regulatory) for root cause analysis."
    - name: "is_key_risk"
      expr: is_key_risk
      comment: "Flag indicating key risks requiring executive attention."
    - name: "identified_date_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month risk was identified for trend analysis."
  measures:
    - name: "total_bid_risks"
      expr: COUNT(1)
      comment: "Total number of bid risks identified. Baseline risk exposure volume metric."
    - name: "total_contingency_amount"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency amount provisioned across bid risks. Core risk-adjusted cost metric for bid pricing."
    - name: "total_impact_cost"
      expr: SUM(CAST(impact_cost AS DOUBLE))
      comment: "Total potential impact cost across all bid risks. Measures gross risk exposure in the bid portfolio."
    - name: "total_residual_impact_cost"
      expr: SUM(CAST(residual_impact_cost AS DOUBLE))
      comment: "Total residual impact cost after mitigation. Measures net risk exposure after risk treatment."
    - name: "avg_residual_risk_score"
      expr: AVG(CAST(residual_risk_score AS DOUBLE))
      comment: "Average residual risk score after mitigation. Key risk management KPI for bid portfolio oversight."
    - name: "avg_contingency_percentage"
      expr: AVG(CAST(contingency_percentage AS DOUBLE))
      comment: "Average contingency percentage applied. Tracks risk provisioning discipline across bids."
    - name: "key_risks_count"
      expr: COUNT(CASE WHEN is_key_risk = TRUE THEN 1 END)
      comment: "Number of key risks requiring executive attention. Tracks high-priority risk exposure."
    - name: "avg_risk_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average inherent risk score across bid risks. Measures overall risk profile of the bid portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_trade_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade package procurement metrics — tracks estimated vs awarded values, bidder participation, and package status to evaluate subcontractor procurement effectiveness."
  source: "`vibe_construction_v1`.`bid`.`trade_package`"
  dimensions:
    - name: "trade_package_status"
      expr: trade_package_status
      comment: "Current status of the trade package (Draft, Issued, Awarded, Closed)."
    - name: "trade_discipline"
      expr: trade_discipline
      comment: "Trade discipline (Civil, Structural, MEP, Finishing) for cost breakdown analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type (Lump Sum, Unit Rate, Cost Plus) for commercial risk segmentation."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method (Competitive, Selective, Negotiated) for procurement strategy analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the trade package for risk-weighted portfolio analysis."
    - name: "package_priority"
      expr: package_priority
      comment: "Priority of the trade package for procurement scheduling."
    - name: "bonding_required"
      expr: bonding_required
      comment: "Flag indicating bonding requirement for financial risk management."
    - name: "prequalification_required"
      expr: prequalification_required
      comment: "Flag indicating prequalification requirement for vendor qualification tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the trade package for multi-currency analysis."
    - name: "bid_closing_date_month"
      expr: DATE_TRUNC('MONTH', bid_closing_date)
      comment: "Month of bid closing date for procurement timeline analysis."
  measures:
    - name: "total_trade_packages"
      expr: COUNT(1)
      comment: "Total number of trade packages. Baseline procurement activity metric."
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of all trade packages. Core procurement budget metric."
    - name: "total_awarded_value"
      expr: SUM(CAST(awarded_value AS DOUBLE))
      comment: "Total awarded value across trade packages. Tracks actual procurement commitment vs budget."
    - name: "total_budget_allowance"
      expr: SUM(CAST(budget_allowance AS DOUBLE))
      comment: "Total budget allowance across trade packages. Reference for budget vs award variance analysis."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across trade packages. Tracks cash flow impact of retention policies."
    - name: "avg_payment_terms_days"
      expr: AVG(CAST(payment_terms_days AS DOUBLE))
      comment: "Average payment terms in days. Tracks cash flow management in subcontractor procurement."
    - name: "avg_duration_days"
      expr: AVG(CAST(duration_days AS DOUBLE))
      comment: "Average trade package duration in days. Informs schedule planning and resource allocation."
    - name: "avg_liquidated_damages_rate"
      expr: AVG(CAST(liquidated_damages_rate AS DOUBLE))
      comment: "Average liquidated damages rate. Tracks commercial risk exposure in trade package contracts."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_bond`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bid bond financial exposure metrics — tracks bond amounts, expiry, and status to manage bonding capacity utilization and financial risk."
  source: "`vibe_construction_v1`.`bid`.`bond`"
  dimensions:
    - name: "bond_status"
      expr: bond_status
      comment: "Current status of the bond (Active, Expired, Called, Released) for exposure management."
    - name: "bond_type"
      expr: bond_type
      comment: "Type of bond (Bid Bond, Performance Bond, Payment Bond) for risk categorization."
    - name: "issuer_type"
      expr: issuer_type
      comment: "Type of bond issuer (Bank, Insurance, Surety) for counterparty risk analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the bond for multi-currency exposure analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the bond for portfolio risk management."
    - name: "compliance_requirements_met"
      expr: compliance_requirements_met
      comment: "Flag indicating compliance requirements are met for regulatory risk tracking."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of bond expiry for maturity profile and renewal planning."
  measures:
    - name: "total_bonds"
      expr: COUNT(1)
      comment: "Total number of bonds issued. Baseline bonding activity metric."
    - name: "total_bond_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total bond amount across all bonds. Core bonding capacity utilization metric for financial risk management."
    - name: "avg_bond_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average bond percentage of contract value. Tracks bonding requirement levels across the portfolio."
    - name: "bonds_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND bond_status = 'Active' THEN 1 END)
      comment: "Number of active bonds expiring within 90 days. Critical risk management metric for bond renewal planning."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_subcontractor_bond`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subcontractor bond exposure and claim metrics — tracks bond amounts, premiums, claims, and expiry to manage subcontractor financial risk and bonding compliance."
  source: "`vibe_construction_v1`.`bid`.`subcontractor_bond`"
  dimensions:
    - name: "subcontractor_bond_status"
      expr: subcontractor_bond_status
      comment: "Current status of the subcontractor bond (Active, Expired, Called, Released)."
    - name: "bond_type"
      expr: bond_type
      comment: "Type of subcontractor bond (Performance, Payment, Maintenance) for risk categorization."
    - name: "bond_form"
      expr: bond_form
      comment: "Bond form (AIA, ConsensusDocs, Custom) for standardization analysis."
    - name: "surety_company_am_best_rating"
      expr: surety_company_am_best_rating
      comment: "AM Best rating of the surety company for counterparty credit risk analysis."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Flag indicating bond renewal is required for compliance tracking."
    - name: "bond_currency_code"
      expr: bond_currency_code
      comment: "Currency of the bond for multi-currency exposure analysis."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of bond expiry for maturity profile and renewal planning."
  measures:
    - name: "total_subcontractor_bonds"
      expr: COUNT(1)
      comment: "Total number of subcontractor bonds. Baseline bonding portfolio metric."
    - name: "total_bond_amount"
      expr: SUM(CAST(bond_amount AS DOUBLE))
      comment: "Total subcontractor bond amount. Core financial risk exposure metric for subcontractor management."
    - name: "total_bond_premium_amount"
      expr: SUM(CAST(bond_premium_amount AS DOUBLE))
      comment: "Total bond premium cost. Tracks bonding cost as a component of subcontractor procurement expense."
    - name: "total_claim_amount"
      expr: SUM(CAST(claim_amount AS DOUBLE))
      comment: "Total bond claim amount filed. Key risk realization metric for subcontractor performance management."
    - name: "total_claim_paid_amount"
      expr: SUM(CAST(claim_paid_amount AS DOUBLE))
      comment: "Total bond claim amount paid. Tracks actual financial loss from subcontractor bond calls."
    - name: "avg_bond_percentage"
      expr: AVG(CAST(bond_percentage AS DOUBLE))
      comment: "Average bond percentage of subcontract value. Tracks bonding requirement levels."
    - name: "avg_bond_premium_rate"
      expr: AVG(CAST(bond_premium_rate AS DOUBLE))
      comment: "Average bond premium rate. Tracks bonding cost efficiency across the subcontractor portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_firm_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contractor and firm qualification metrics — tracks safety performance, bonding capacity, and certification status to evaluate the quality of the prequalified contractor pool."
  source: "`vibe_construction_v1`.`bid`.`firm_profile`"
  dimensions:
    - name: "firm_status"
      expr: firm_status
      comment: "Current status of the firm (Active, Suspended, Debarred, Expired) for vendor pool management."
    - name: "firm_type"
      expr: firm_type
      comment: "Type of firm (General Contractor, Subcontractor, Specialty) for portfolio segmentation."
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Prequalification status (Approved, Conditional, Rejected) for vendor qualification tracking."
    - name: "primary_trade_classification"
      expr: primary_trade_classification
      comment: "Primary trade classification for market segment analysis."
    - name: "is_union_shop"
      expr: is_union_shop
      comment: "Flag indicating union shop status for labor relations analysis."
    - name: "dbe_certified"
      expr: dbe_certified
      comment: "Disadvantaged Business Enterprise certification flag for diversity compliance tracking."
    - name: "mbe_certified"
      expr: mbe_certified
      comment: "Minority Business Enterprise certification flag for diversity compliance tracking."
    - name: "wbe_certified"
      expr: wbe_certified
      comment: "Women Business Enterprise certification flag for diversity compliance tracking."
    - name: "iso_9001_certified"
      expr: iso_9001_certified
      comment: "ISO 9001 quality certification flag for quality management assessment."
    - name: "headquarters_country"
      expr: headquarters_country
      comment: "Country of headquarters for geographic market analysis."
  measures:
    - name: "total_firms"
      expr: COUNT(1)
      comment: "Total number of firm profiles. Baseline vendor pool size metric."
    - name: "total_bonding_capacity_usd"
      expr: SUM(CAST(bonding_capacity_usd AS DOUBLE))
      comment: "Total bonding capacity across all firms. Tracks available bonding capacity in the prequalified contractor pool."
    - name: "avg_emr"
      expr: AVG(CAST(emr AS DOUBLE))
      comment: "Average Experience Modification Rate (EMR) across firms. Key safety performance KPI for contractor prequalification."
    - name: "avg_trir"
      expr: AVG(CAST(trir AS DOUBLE))
      comment: "Average Total Recordable Incident Rate (TRIR) across firms. Core safety performance metric for contractor selection."
    - name: "avg_single_project_bond_limit_usd"
      expr: AVG(CAST(single_project_bond_limit_usd AS DOUBLE))
      comment: "Average single project bond limit. Tracks financial capacity of the contractor pool for large project pursuit."
    - name: "diversity_certified_firms_count"
      expr: COUNT(CASE WHEN dbe_certified = TRUE OR mbe_certified = TRUE OR wbe_certified = TRUE THEN 1 END)
      comment: "Number of diversity-certified firms. Tracks diversity supplier pool depth for compliance and ESG reporting."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_prequalification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bid prequalification metrics — tracks evaluation scores, financial capacity thresholds, and HSSE performance to evaluate prequalification quality and compliance."
  source: "`vibe_construction_v1`.`bid`.`bid_prequalification`"
  dimensions:
    - name: "bid_prequalification_status"
      expr: bid_prequalification_status
      comment: "Current status of the prequalification (Submitted, Under Review, Approved, Rejected)."
    - name: "prequalification_category"
      expr: prequalification_category
      comment: "Category of prequalification (Technical, Financial, HSSE) for evaluation analysis."
    - name: "procurement_category"
      expr: procurement_category
      comment: "Procurement category for market segment analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned at prequalification for portfolio risk management."
    - name: "regulatory_approval_required"
      expr: regulatory_approval_required
      comment: "Flag indicating regulatory approval requirement for compliance tracking."
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Flag indicating joint venture prequalification for partnership tracking."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of prequalification submission for cycle time analysis."
  measures:
    - name: "total_prequalifications"
      expr: COUNT(1)
      comment: "Total number of bid prequalifications. Baseline prequalification activity metric."
    - name: "avg_evaluation_score"
      expr: AVG(CAST(evaluation_score AS DOUBLE))
      comment: "Average prequalification evaluation score. Measures overall quality of prequalified bidder pool."
    - name: "avg_technical_capacity_score"
      expr: AVG(CAST(technical_capacity_score AS DOUBLE))
      comment: "Average technical capacity score. Tracks technical capability of prequalified bidders."
    - name: "avg_hsse_performance_score"
      expr: AVG(CAST(hsse_performance_score AS DOUBLE))
      comment: "Average HSSE performance score. Key safety qualification metric for contractor selection."
    - name: "total_financial_capacity_threshold"
      expr: SUM(CAST(financial_capacity_threshold AS DOUBLE))
      comment: "Total financial capacity threshold across prequalifications. Tracks financial qualification requirements in the bid pipeline."
    - name: "total_bid_bond_amount"
      expr: SUM(CAST(bid_bond_amount AS DOUBLE))
      comment: "Total bid bond amount required across prequalifications. Tracks bonding requirement exposure."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_subcontractor_prequalification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subcontractor prequalification quality metrics — tracks overall scores, financial capacity, safety records, and bonding limits to evaluate the depth and quality of the prequalified subcontractor pool."
  source: "`vibe_construction_v1`.`bid`.`bid_subcontractor_prequalification`"
  dimensions:
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Current prequalification status (Approved, Conditional, Rejected, Expired)."
    - name: "trade_category"
      expr: trade_category
      comment: "Trade category of the subcontractor for pool depth analysis by discipline."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the subcontractor for regional capacity analysis."
    - name: "certification_requirements_met"
      expr: certification_requirements_met
      comment: "Flag indicating certification requirements are met for compliance tracking."
    - name: "financial_statements_verified"
      expr: financial_statements_verified
      comment: "Flag indicating financial statements have been verified for financial due diligence tracking."
    - name: "reference_check_completed"
      expr: reference_check_completed
      comment: "Flag indicating reference checks are completed for qualification thoroughness tracking."
    - name: "evaluation_date_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month of evaluation for prequalification cycle time analysis."
  measures:
    - name: "total_subcontractor_prequalifications"
      expr: COUNT(1)
      comment: "Total number of subcontractor prequalifications. Baseline pool size metric."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall prequalification score. Key quality metric for subcontractor pool management."
    - name: "avg_financial_capacity_score"
      expr: AVG(CAST(financial_capacity_score AS DOUBLE))
      comment: "Average financial capacity score. Tracks financial health of the prequalified subcontractor pool."
    - name: "avg_safety_record_score"
      expr: AVG(CAST(safety_record_score AS DOUBLE))
      comment: "Average safety record score. Key HSSE qualification metric for subcontractor selection."
    - name: "avg_technical_capability_score"
      expr: AVG(CAST(technical_capability_score AS DOUBLE))
      comment: "Average technical capability score. Measures technical depth of the prequalified subcontractor pool."
    - name: "total_bonding_limit_amount"
      expr: SUM(CAST(bonding_limit_amount AS DOUBLE))
      comment: "Total bonding limit across prequalified subcontractors. Tracks available bonding capacity in the subcontractor pool."
    - name: "total_maximum_contract_value"
      expr: SUM(CAST(maximum_contract_value AS DOUBLE))
      comment: "Total maximum contract value capacity across prequalified subcontractors. Tracks subcontractor pool capacity for large packages."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_vendor_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor quote competitiveness metrics — tracks quoted amounts, evaluation scores, and delivery terms to support vendor selection and price benchmarking."
  source: "`vibe_construction_v1`.`bid`.`vendor_quote`"
  dimensions:
    - name: "vendor_quote_status"
      expr: vendor_quote_status
      comment: "Current status of the vendor quote (Received, Under Evaluation, Accepted, Rejected)."
    - name: "vendor_type"
      expr: vendor_type
      comment: "Type of vendor (Supplier, Subcontractor, Specialist) for market analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the quote for multi-currency price comparison."
    - name: "regulatory_approval_required"
      expr: regulatory_approval_required
      comment: "Flag indicating regulatory approval requirement for compliance tracking."
    - name: "confidentiality_flag"
      expr: confidentiality_flag
      comment: "Flag indicating confidential pricing for data governance."
    - name: "quote_received_month"
      expr: DATE_TRUNC('MONTH', quote_received_timestamp)
      comment: "Month quote was received for procurement timeline analysis."
  measures:
    - name: "total_vendor_quotes"
      expr: COUNT(1)
      comment: "Total number of vendor quotes received. Baseline procurement market engagement metric."
    - name: "total_quoted_amount"
      expr: SUM(CAST(quoted_amount AS DOUBLE))
      comment: "Total quoted amount across all vendor quotes. Core procurement cost metric for bid pricing."
    - name: "total_quoted_value"
      expr: SUM(CAST(total_quoted_value AS DOUBLE))
      comment: "Total quoted value across all vendor quotes. Tracks total procurement market pricing."
    - name: "avg_evaluation_score"
      expr: AVG(CAST(evaluation_score AS DOUBLE))
      comment: "Average vendor quote evaluation score. Measures vendor competitiveness and quote quality."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across vendor quotes. Supports unit rate benchmarking for bid pricing."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity quoted across vendor quotes. Supports volume analysis for procurement planning."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_team_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bid team resource utilization metrics — tracks planned vs actual hours, allocation percentages, and role coverage to optimize bid team deployment and pursuit investment."
  source: "`vibe_construction_v1`.`bid`.`bid_team_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the team assignment (Active, Released, Completed)."
    - name: "role"
      expr: role
      comment: "Role of the team member in the bid (Estimator, Proposal Manager, Technical Lead) for resource analysis."
    - name: "responsibility_area"
      expr: responsibility_area
      comment: "Area of responsibility (Commercial, Technical, Legal) for workload distribution analysis."
    - name: "is_lead"
      expr: is_lead
      comment: "Flag indicating lead role for leadership coverage analysis."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month of assignment start for resource planning timeline analysis."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of bid team assignments. Baseline resource deployment metric."
    - name: "total_planned_hours"
      expr: SUM(CAST(planned_hours AS DOUBLE))
      comment: "Total planned hours across bid team assignments. Core pursuit investment metric for bid cost management."
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual hours spent across bid team assignments. Tracks actual pursuit investment vs plan."
    - name: "total_estimated_hours"
      expr: SUM(CAST(estimated_hours AS DOUBLE))
      comment: "Total estimated hours across bid team assignments. Reference for resource planning accuracy."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage across team assignments. Tracks resource utilization intensity in bid pursuits."
    - name: "hours_variance"
      expr: SUM(CAST(actual_hours AS DOUBLE) - CAST(planned_hours AS DOUBLE))
      comment: "Total variance between actual and planned hours. Measures bid team resource planning accuracy and pursuit cost overrun."
$$;