-- Metric views for domain: bid | Business: Construction | Version: 1 | Generated on: 2026-05-07 09:21:54

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`bid_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the bid opportunity pipeline — win rates, estimated contract value, probability-weighted pipeline, and discount analysis. Used by BD leadership to steer pursuit investment and forecast revenue."
  source: "`construction_ecm`.`bid`.`bid_opportunity`"
  dimensions:
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment of the opportunity (e.g. infrastructure, commercial, energy) for pipeline segmentation."
    - name: "project_type"
      expr: project_type
      comment: "Type of construction project (e.g. highway, airport, residential) to analyse win rates by project category."
    - name: "stage"
      expr: stage
      comment: "Current pipeline stage of the opportunity (e.g. qualify, propose, negotiate) for funnel analysis."
    - name: "bid_decision"
      expr: bid_decision
      comment: "Go/No-Go decision recorded against the opportunity, enabling analysis of pursuit selectivity."
    - name: "win_loss_status"
      expr: win_loss_status
      comment: "Final win/loss outcome of the opportunity, used to compute win rates and analyse loss patterns."
    - name: "pipeline_forecast_category"
      expr: pipeline_forecast_category
      comment: "Forecast category (e.g. commit, best-case, pipeline) for revenue forecasting alignment."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the opportunity was sourced (e.g. direct, partner, framework) for channel effectiveness analysis."
    - name: "gmp_type"
      expr: gmp_type
      comment: "Guaranteed Maximum Price contract type indicator, relevant for margin risk profiling."
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Flag indicating whether the opportunity is pursued as a joint venture, for JV performance tracking."
    - name: "country_code"
      expr: country_code
      comment: "Country where the project is located, enabling geographic pipeline analysis."
    - name: "bid_due_date_month"
      expr: DATE_TRUNC('MONTH', bid_due_date)
      comment: "Month of bid due date for time-series pipeline and workload analysis."
  measures:
    - name: "total_opportunities"
      expr: COUNT(1)
      comment: "Total number of bid opportunities in the pipeline. Baseline volume metric for funnel analysis."
    - name: "total_estimated_contract_value"
      expr: SUM(CAST(estimated_contract_value AS DOUBLE))
      comment: "Sum of estimated contract values across all opportunities. Represents the gross pipeline value available to the business."
    - name: "probability_weighted_pipeline_value"
      expr: SUM(CAST(estimated_contract_value AS DOUBLE) * CAST(probability_of_win AS DOUBLE) / 100.0)
      comment: "Probability-weighted pipeline value (ECV × win probability). The primary revenue forecast metric used in QBRs and board decks."
    - name: "avg_probability_of_win"
      expr: AVG(CAST(probability_of_win AS DOUBLE))
      comment: "Average win probability across opportunities. Indicates overall pipeline quality and pursuit selectivity."
    - name: "avg_estimated_contract_value"
      expr: AVG(CAST(estimated_contract_value AS DOUBLE))
      comment: "Average estimated contract value per opportunity. Tracks deal size trends and strategic positioning."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted across opportunities. Monitors pricing discipline and margin erosion risk."
    - name: "total_net_estimated_value"
      expr: SUM(CAST(net_estimated_value AS DOUBLE))
      comment: "Sum of net estimated values (post-discount) across all opportunities. Represents the realistic revenue pipeline after commercial adjustments."
    - name: "win_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN win_loss_status = 'Won' THEN 1 END) / NULLIF(COUNT(CASE WHEN win_loss_status IN ('Won','Lost') THEN 1 END), 0), 2)
      comment: "Percentage of decided opportunities that were won. Core BD performance KPI tracked at every leadership review."
    - name: "bid_bond_exposure"
      expr: SUM(CAST(bid_bond_amount AS DOUBLE))
      comment: "Total bid bond exposure across active opportunities. Monitors bonding capacity utilisation and financial risk."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`bid_tender`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and strategic KPIs for the tender lifecycle — submission compliance, evaluation scores, award rates, and estimated value at risk. Used by bid managers and commercial directors to govern tender performance."
  source: "`construction_ecm`.`bid`.`tender`"
  dimensions:
    - name: "tender_type"
      expr: tender_type
      comment: "Type of tender (e.g. open, selective, negotiated) for procurement method analysis."
    - name: "bid_type"
      expr: bid_type
      comment: "Bid type (e.g. lump sum, unit rate, GMP) for commercial structure analysis."
    - name: "award_status"
      expr: award_status
      comment: "Current award status of the tender (e.g. awarded, pending, rejected) for pipeline conversion tracking."
    - name: "submission_status"
      expr: submission_status
      comment: "Submission status (e.g. submitted, withdrawn, disqualified) for compliance and process monitoring."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement route (e.g. competitive, framework, sole source) for strategic sourcing analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the tender for risk-adjusted portfolio management."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the tender for regional performance benchmarking."
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Prequalification outcome, indicating whether the company met client entry criteria."
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Indicates joint venture tenders for JV-specific performance tracking."
    - name: "submission_deadline_month"
      expr: DATE_TRUNC('MONTH', submission_deadline)
      comment: "Month of submission deadline for workload planning and deadline compliance analysis."
    - name: "regulatory_approval_required"
      expr: regulatory_approval_required
      comment: "Flag for tenders requiring regulatory approval, used to track compliance overhead."
  measures:
    - name: "total_tenders"
      expr: COUNT(1)
      comment: "Total number of tenders in scope. Baseline volume for tender pipeline management."
    - name: "total_estimated_tender_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Sum of estimated values across all tenders. Represents the total commercial opportunity under active pursuit."
    - name: "avg_estimated_tender_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average estimated value per tender. Tracks deal size and strategic positioning over time."
    - name: "avg_evaluation_score"
      expr: AVG(CAST(evaluation_score AS DOUBLE))
      comment: "Average evaluation score achieved across tenders. Indicates competitive positioning and bid quality."
    - name: "total_bid_bond_exposure"
      expr: SUM(CAST(bid_bond_amount AS DOUBLE))
      comment: "Total bid bond value committed across tenders. Monitors bonding capacity utilisation and financial exposure."
    - name: "award_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN award_status = 'Awarded' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tenders that resulted in an award. Primary conversion KPI for the tender pipeline."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_requirements_met = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tenders meeting all compliance requirements. Tracks regulatory and contractual compliance health."
    - name: "awarded_tender_value"
      expr: SUM(CASE WHEN award_status = 'Awarded' THEN CAST(estimated_value AS DOUBLE) ELSE 0 END)
      comment: "Total estimated value of awarded tenders. Represents secured revenue from the tender pipeline."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`bid_estimate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost estimation quality and margin KPIs — contingency levels, overhead loading, profit margins, and estimate accuracy. Used by estimating managers and CFOs to govern cost competitiveness and margin targets."
  source: "`construction_ecm`.`bid`.`estimate`"
  dimensions:
    - name: "estimate_type"
      expr: estimate_type
      comment: "Type of estimate (e.g. conceptual, detailed, definitive) for maturity and accuracy benchmarking."
    - name: "estimate_category"
      expr: estimate_category
      comment: "Category of estimate (e.g. civil, MEP, fit-out) for cost structure analysis."
    - name: "estimate_status"
      expr: estimate_status
      comment: "Current status of the estimate (e.g. draft, approved, superseded) for workflow governance."
    - name: "estimating_method"
      expr: estimating_method
      comment: "Method used to produce the estimate (e.g. parametric, bottom-up, analogous) for methodology benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the estimate for multi-currency portfolio analysis."
    - name: "is_gmp"
      expr: is_gmp
      comment: "Indicates whether the estimate is for a Guaranteed Maximum Price contract, relevant for risk and margin analysis."
    - name: "is_lump_sum"
      expr: is_lump_sum
      comment: "Indicates lump-sum pricing structure, which carries different risk profiles than unit-rate contracts."
    - name: "base_pricing_date_month"
      expr: DATE_TRUNC('MONTH', base_pricing_date)
      comment: "Month of base pricing date for escalation and inflation trend analysis."
  measures:
    - name: "total_estimates"
      expr: COUNT(1)
      comment: "Total number of estimates produced. Baseline volume for estimating capacity and throughput tracking."
    - name: "total_estimated_cost"
      expr: SUM(CAST(total_estimated_cost AS DOUBLE))
      comment: "Sum of total estimated costs across all estimates. Represents the aggregate cost base of the bid portfolio."
    - name: "avg_estimated_cost"
      expr: AVG(CAST(total_estimated_cost AS DOUBLE))
      comment: "Average estimated cost per estimate. Tracks project scale trends and estimating workload."
    - name: "avg_profit_margin_pct"
      expr: AVG(CAST(profit_margin_percentage AS DOUBLE))
      comment: "Average profit margin percentage across estimates. Core margin health KPI reviewed at every commercial gate."
    - name: "avg_contingency_pct"
      expr: AVG(CAST(contingency_percentage AS DOUBLE))
      comment: "Average contingency loading across estimates. Indicates risk appetite and estimate conservatism."
    - name: "avg_overhead_pct"
      expr: AVG(CAST(overhead_percentage AS DOUBLE))
      comment: "Average overhead percentage applied to estimates. Monitors overhead recovery rates and cost competitiveness."
    - name: "total_escalation_allowance"
      expr: SUM(CAST(escalation_allowance AS DOUBLE))
      comment: "Total escalation allowance provisioned across estimates. Tracks inflation exposure in the bid portfolio."
    - name: "avg_risk_factor"
      expr: AVG(CAST(risk_factor AS DOUBLE))
      comment: "Average risk factor applied across estimates. Indicates the aggregate risk loading in the cost base."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`bid_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bid governance and approval KPIs — approval rates, governance scores, margin at approval, and risk profiling. Used by governance committees and CFOs to ensure bids meet strategic and financial thresholds before submission."
  source: "`construction_ecm`.`bid`.`approval`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current status of the approval (e.g. pending, approved, rejected) for governance pipeline monitoring."
    - name: "decision_outcome"
      expr: decision_outcome
      comment: "Final decision outcome (e.g. approved, rejected, deferred) for approval effectiveness analysis."
    - name: "decision_stage"
      expr: decision_stage
      comment: "Stage at which the decision was made (e.g. pre-bid, post-tender) for governance process analysis."
    - name: "delegation_of_authority_level"
      expr: delegation_of_authority_level
      comment: "Authority level required for approval, used to track escalation patterns and governance compliance."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the bid at approval, for risk-adjusted approval analysis."
    - name: "is_conditional"
      expr: is_conditional
      comment: "Indicates whether the approval was granted with conditions, tracking governance quality."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the approved bid price for multi-currency portfolio analysis."
    - name: "decision_timestamp_month"
      expr: DATE_TRUNC('MONTH', decision_timestamp)
      comment: "Month of decision for time-series governance throughput analysis."
  measures:
    - name: "total_approvals"
      expr: COUNT(1)
      comment: "Total number of approval records. Baseline volume for governance throughput monitoring."
    - name: "total_approved_bid_price"
      expr: SUM(CAST(approved_bid_price AS DOUBLE))
      comment: "Sum of approved bid prices. Represents the total commercial value sanctioned through the governance process."
    - name: "avg_approved_margin_pct"
      expr: AVG(CAST(approved_margin_pct AS DOUBLE))
      comment: "Average margin percentage at the point of approval. Core profitability governance KPI reviewed at every approval committee."
    - name: "avg_total_governance_score"
      expr: AVG(CAST(total_governance_score AS DOUBLE))
      comment: "Average total governance score across approvals. Composite indicator of bid quality and strategic alignment at gate."
    - name: "avg_risk_profile_score"
      expr: AVG(CAST(risk_profile_score AS DOUBLE))
      comment: "Average risk profile score at approval. Tracks the risk quality of bids being sanctioned."
    - name: "avg_strategic_fit_score"
      expr: AVG(CAST(strategic_fit_score AS DOUBLE))
      comment: "Average strategic fit score at approval. Indicates alignment of pursued bids with corporate strategy."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN decision_outcome = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bids approved through the governance process. Tracks governance selectivity and bid quality."
    - name: "conditional_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_conditional = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN decision_outcome = 'Approved' THEN 1 END), 0), 2)
      comment: "Percentage of approved bids that carry conditions. High rates indicate governance concerns requiring remediation."
    - name: "avg_bonding_capacity_score"
      expr: AVG(CAST(bonding_capacity_score AS DOUBLE))
      comment: "Average bonding capacity score at approval. Monitors financial capacity constraints in the bid portfolio."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`bid_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bid submission performance KPIs — pricing competitiveness, technical and commercial scores, compliance rates, and late submission risk. Used by bid directors to evaluate submission quality and process discipline."
  source: "`construction_ecm`.`bid`.`submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Status of the submission (e.g. submitted, withdrawn, disqualified) for pipeline health monitoring."
    - name: "bid_type"
      expr: bid_type
      comment: "Type of bid submitted (e.g. lump sum, unit rate) for commercial structure analysis."
    - name: "evaluation_method"
      expr: evaluation_method
      comment: "Client evaluation method (e.g. lowest price, MEAT) for competitive strategy analysis."
    - name: "submission_method"
      expr: submission_method
      comment: "Method of submission (e.g. electronic, hard copy) for process efficiency tracking."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the submission for risk-adjusted performance analysis."
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Indicates joint venture submissions for JV-specific performance benchmarking."
    - name: "late_submission_flag"
      expr: late_submission_flag
      comment: "Flags submissions made after the deadline, used to monitor process discipline and compliance risk."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the submission for regional performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the bid price for multi-currency portfolio analysis."
    - name: "submission_timestamp_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of submission for time-series volume and performance trending."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of bid submissions. Baseline volume for submission pipeline management."
    - name: "total_bid_price"
      expr: SUM(CAST(bid_price AS DOUBLE))
      comment: "Sum of submitted bid prices. Represents the total commercial value tendered to clients."
    - name: "avg_bid_price"
      expr: AVG(CAST(bid_price AS DOUBLE))
      comment: "Average submitted bid price. Tracks deal size trends and pricing strategy over time."
    - name: "avg_technical_score"
      expr: AVG(CAST(technical_score AS DOUBLE))
      comment: "Average technical evaluation score achieved. Indicates technical bid quality and competitiveness."
    - name: "avg_commercial_score"
      expr: AVG(CAST(commercial_score AS DOUBLE))
      comment: "Average commercial evaluation score achieved. Tracks pricing competitiveness relative to client evaluation criteria."
    - name: "late_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN late_submission_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions made after the deadline. High rates signal process failures that risk disqualification."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_requirements_met = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions meeting all compliance requirements. Tracks regulatory and contractual compliance health."
    - name: "total_bid_price_adjustment"
      expr: SUM(CAST(bid_price_adjustment AS DOUBLE))
      comment: "Total price adjustments applied to submitted bids. Monitors post-submission commercial changes and their aggregate impact."
    - name: "total_bid_bond_exposure"
      expr: SUM(CAST(bid_bond_amount AS DOUBLE))
      comment: "Total bid bond value committed across submissions. Monitors bonding capacity utilisation and financial exposure."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`bid_boq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of Quantities (BOQ) portfolio KPIs — total BOQ value, revision activity, and pricing integrity. Used by quantity surveyors and commercial managers to govern scope definition and pricing completeness."
  source: "`construction_ecm`.`bid`.`boq`"
  dimensions:
    - name: "boq_status"
      expr: boq_status
      comment: "Current status of the BOQ (e.g. draft, issued, approved) for workflow governance."
    - name: "boq_type"
      expr: boq_type
      comment: "Type of BOQ (e.g. provisional, firm, remeasurement) for commercial structure analysis."
    - name: "currency"
      expr: currency
      comment: "Currency of the BOQ for multi-currency portfolio analysis."
    - name: "contains_confidential_pricing"
      expr: contains_confidential_pricing
      comment: "Flags BOQs with confidential pricing, relevant for information security and disclosure governance."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month of BOQ issue for time-series volume and revision trend analysis."
    - name: "approved_by"
      expr: approved_by
      comment: "Person who approved the BOQ, for accountability and governance tracking."
  measures:
    - name: "total_boqs"
      expr: COUNT(1)
      comment: "Total number of BOQs in scope. Baseline volume for BOQ portfolio management."
    - name: "total_boq_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Sum of total BOQ values. Represents the aggregate priced scope across all active BOQs."
    - name: "avg_boq_value"
      expr: AVG(CAST(total_value AS DOUBLE))
      comment: "Average BOQ value. Tracks scope size trends and estimating workload per BOQ."
    - name: "total_boq_quantity"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Sum of total quantities across all BOQs. Monitors aggregate scope volume for resource planning."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied across BOQs. Tracks currency exposure and FX risk in the BOQ portfolio."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`bid_boq_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level BOQ cost composition KPIs — labour, material, plant, subcontract, and overhead breakdown, margin analysis, and risk profiling. Used by quantity surveyors and cost managers to govern cost structure and competitiveness."
  source: "`construction_ecm`.`bid`.`bid_boq_line`"
  dimensions:
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category of the BOQ line (e.g. civil, structural, MEP) for cost structure analysis."
    - name: "bid_boq_line_status"
      expr: bid_boq_line_status
      comment: "Status of the BOQ line (e.g. active, revised, deleted) for scope change tracking."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the BOQ line for risk-weighted cost analysis."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flags BOQ lines on the critical path, enabling focused cost and schedule risk management."
    - name: "is_lump_sum"
      expr: is_lump_sum
      comment: "Indicates lump-sum pricing for the line, relevant for scope risk and change order exposure."
    - name: "is_gmp_applicable"
      expr: is_gmp_applicable
      comment: "Indicates whether GMP terms apply to the line, for GMP exposure analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the BOQ line quantity, for productivity and rate benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the BOQ line for multi-currency cost analysis."
    - name: "change_order_flag"
      expr: change_order_flag
      comment: "Flags lines associated with change orders, for scope change cost impact analysis."
  measures:
    - name: "total_boq_lines"
      expr: COUNT(1)
      comment: "Total number of BOQ lines. Baseline volume for scope complexity and estimating workload analysis."
    - name: "total_line_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Sum of total amounts across all BOQ lines. Represents the aggregate priced scope value."
    - name: "total_labour_cost"
      expr: SUM(CAST(labour_cost AS DOUBLE))
      comment: "Total labour cost across BOQ lines. Tracks workforce cost exposure in the bid."
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost AS DOUBLE))
      comment: "Total material cost across BOQ lines. Monitors material procurement exposure and supply chain risk."
    - name: "total_plant_cost"
      expr: SUM(CAST(plant_cost AS DOUBLE))
      comment: "Total plant and equipment cost across BOQ lines. Tracks equipment utilisation and hire cost exposure."
    - name: "total_subcontract_cost"
      expr: SUM(CAST(subcontract_cost AS DOUBLE))
      comment: "Total subcontract cost across BOQ lines. Monitors subcontractor dependency and supply chain cost risk."
    - name: "total_overhead_amount"
      expr: SUM(CAST(overhead_amount AS DOUBLE))
      comment: "Total overhead loaded across BOQ lines. Tracks overhead recovery and cost competitiveness."
    - name: "avg_profit_margin_pct"
      expr: AVG(CAST(profit_margin_percent AS DOUBLE))
      comment: "Average profit margin percentage across BOQ lines. Core margin health KPI for line-level commercial governance."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across BOQ lines. Monitors tax exposure and compliance in the bid cost base."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`bid_estimate_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Estimate line-level cost accuracy and variance KPIs — baseline vs revised cost, variance analysis, productivity, and waste factors. Used by estimating managers to identify cost drift and improve estimate accuracy."
  source: "`construction_ecm`.`bid`.`estimate_line`"
  dimensions:
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category of the estimate line (e.g. labour, material, plant) for cost structure decomposition."
    - name: "estimate_line_status"
      expr: estimate_line_status
      comment: "Status of the estimate line (e.g. active, revised, deleted) for scope change tracking."
    - name: "material_type"
      expr: material_type
      comment: "Type of material for the line, enabling material cost benchmarking and procurement analysis."
    - name: "labor_rate_type"
      expr: labor_rate_type
      comment: "Labour rate type (e.g. straight time, overtime, shift) for workforce cost analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the estimate line quantity, for productivity and rate benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the estimate line for multi-currency cost analysis."
    - name: "variance_reason"
      expr: variance_reason
      comment: "Reason for cost variance, enabling root cause analysis of estimate inaccuracies."
    - name: "is_deleted"
      expr: is_deleted
      comment: "Flags deleted estimate lines, used to track scope reductions and their cost impact."
  measures:
    - name: "total_estimate_lines"
      expr: COUNT(1)
      comment: "Total number of estimate lines. Baseline volume for estimating complexity and workload analysis."
    - name: "total_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Sum of total costs across all estimate lines. Represents the aggregate estimated cost base."
    - name: "total_baseline_cost"
      expr: SUM(CAST(baseline_cost AS DOUBLE))
      comment: "Sum of baseline costs across estimate lines. The original cost plan against which variances are measured."
    - name: "total_revised_cost"
      expr: SUM(CAST(revised_cost AS DOUBLE))
      comment: "Sum of revised costs across estimate lines. Reflects the current cost position after all revisions."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Sum of cost variances (revised minus baseline) across estimate lines. Tracks aggregate estimate drift and cost growth."
    - name: "avg_productivity_factor"
      expr: AVG(CAST(productivity_factor AS DOUBLE))
      comment: "Average productivity factor applied across estimate lines. Monitors productivity assumptions and their impact on labour cost competitiveness."
    - name: "avg_waste_factor"
      expr: AVG(CAST(waste_factor AS DOUBLE))
      comment: "Average waste factor applied across estimate lines. Tracks material waste assumptions and their cost impact."
    - name: "avg_risk_factor"
      expr: AVG(CAST(risk_factor AS DOUBLE))
      comment: "Average risk factor applied across estimate lines. Indicates the aggregate risk loading in the detailed cost estimate."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across estimate lines. Monitors tax exposure in the detailed cost base."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`bid_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bid risk portfolio KPIs — contingency exposure, residual risk scores, mitigation effectiveness, and key risk concentration. Used by risk managers and commercial directors to govern bid risk appetite and mitigation adequacy."
  source: "`construction_ecm`.`bid`.`risk`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Category of risk (e.g. commercial, technical, regulatory, environmental) for risk portfolio decomposition."
    - name: "bid_risk_status"
      expr: bid_risk_status
      comment: "Current status of the risk (e.g. open, mitigated, closed) for risk lifecycle management."
    - name: "priority"
      expr: priority
      comment: "Priority level of the risk (e.g. high, medium, low) for risk triage and resource allocation."
    - name: "probability_rating"
      expr: probability_rating
      comment: "Probability rating of the risk occurring, for risk-weighted exposure analysis."
    - name: "origin"
      expr: origin
      comment: "Origin of the risk (e.g. client, design, site, regulatory) for root cause and accountability analysis."
    - name: "is_key_risk"
      expr: is_key_risk
      comment: "Flags risks designated as key risks, enabling focused executive attention on material exposures."
    - name: "mitigation_strategy"
      expr: mitigation_strategy
      comment: "Mitigation approach adopted, for strategy effectiveness benchmarking."
    - name: "identified_date_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month risk was identified for trend analysis of risk emergence patterns."
  measures:
    - name: "total_risks"
      expr: COUNT(1)
      comment: "Total number of bid risks identified. Baseline volume for risk portfolio size monitoring."
    - name: "total_impact_cost"
      expr: SUM(CAST(impact_cost AS DOUBLE))
      comment: "Sum of gross risk impact costs. Represents the maximum financial exposure from identified bid risks."
    - name: "total_contingency_amount"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency provisioned against identified risks. Monitors adequacy of risk reserves in the bid."
    - name: "total_residual_impact_cost"
      expr: SUM(CAST(residual_impact_cost AS DOUBLE))
      comment: "Sum of residual risk impact costs after mitigation. Represents the net financial exposure remaining in the bid."
    - name: "avg_risk_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average risk score across all bid risks. Composite indicator of overall bid risk profile."
    - name: "avg_residual_risk_score"
      expr: AVG(CAST(residual_risk_score AS DOUBLE))
      comment: "Average residual risk score after mitigation. Tracks mitigation effectiveness and remaining risk exposure."
    - name: "avg_contingency_pct"
      expr: AVG(CAST(contingency_percentage AS DOUBLE))
      comment: "Average contingency percentage applied to risks. Monitors risk provisioning adequacy and consistency."
    - name: "key_risk_count"
      expr: COUNT(CASE WHEN is_key_risk = TRUE THEN 1 END)
      comment: "Number of risks designated as key risks. Tracks concentration of material risk exposures requiring executive attention."
    - name: "mitigation_effectiveness_pct"
      expr: ROUND(100.0 * (1.0 - SUM(CAST(residual_impact_cost AS DOUBLE)) / NULLIF(SUM(CAST(impact_cost AS DOUBLE)), 0)) * 100.0 / 100.0, 2)
      comment: "Percentage reduction in impact cost achieved through mitigation (1 - residual/gross). Measures how effectively risk mitigation strategies are reducing financial exposure."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`bid_bond`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bid bond portfolio KPIs — bond exposure, expiry risk, and compliance. Used by treasury and commercial managers to govern bonding capacity utilisation and financial guarantee obligations."
  source: "`construction_ecm`.`bid`.`bond`"
  dimensions:
    - name: "bond_type"
      expr: bond_type
      comment: "Type of bond (e.g. bid bond, performance bond, advance payment guarantee) for bond portfolio decomposition."
    - name: "bond_status"
      expr: bond_status
      comment: "Current status of the bond (e.g. active, expired, called, released) for bond lifecycle management."
    - name: "issuer_type"
      expr: issuer_type
      comment: "Type of issuing entity (e.g. bank, insurance company) for counterparty risk analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the bond for risk-adjusted exposure analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the bond for multi-currency exposure analysis."
    - name: "compliance_requirements_met"
      expr: compliance_requirements_met
      comment: "Indicates whether all compliance requirements for the bond are met, for compliance health monitoring."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of bond expiry for maturity profile and renewal planning."
  measures:
    - name: "total_bonds"
      expr: COUNT(1)
      comment: "Total number of bonds in the portfolio. Baseline volume for bonding capacity management."
    - name: "total_bond_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total face value of bonds issued. Represents aggregate financial guarantee exposure and bonding capacity utilisation."
    - name: "avg_bond_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average bond percentage (of contract value). Tracks bonding requirement levels across the portfolio."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_requirements_met = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bonds meeting all compliance requirements. Tracks regulatory and contractual compliance health of the bond portfolio."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`bid_trade_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade package procurement KPIs — awarded vs estimated value, bid competitiveness, retention exposure, and procurement cycle performance. Used by procurement managers and project directors to govern subcontract procurement outcomes."
  source: "`construction_ecm`.`bid`.`trade_package`"
  dimensions:
    - name: "package_status"
      expr: package_status
      comment: "Current status of the trade package (e.g. bidding, awarded, complete) for procurement pipeline management."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type for the trade package (e.g. lump sum, unit rate, cost-plus) for commercial structure analysis."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement route (e.g. competitive tender, negotiated, sole source) for sourcing strategy analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the trade package for risk-weighted procurement analysis."
    - name: "package_priority"
      expr: package_priority
      comment: "Priority of the trade package (e.g. critical, high, standard) for procurement scheduling."
    - name: "csi_masterformat_code"
      expr: csi_masterformat_code
      comment: "CSI MasterFormat code for the trade package, enabling industry-standard cost category benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the trade package for multi-currency procurement analysis."
    - name: "bonding_required"
      expr: bonding_required
      comment: "Indicates whether bonding is required for the trade package, for bonding capacity planning."
    - name: "award_date_month"
      expr: DATE_TRUNC('MONTH', award_date)
      comment: "Month of award for procurement cycle time and award volume trending."
  measures:
    - name: "total_trade_packages"
      expr: COUNT(1)
      comment: "Total number of trade packages. Baseline volume for procurement pipeline management."
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Sum of estimated values across trade packages. Represents the total subcontract procurement budget."
    - name: "total_awarded_value"
      expr: SUM(CAST(awarded_value AS DOUBLE))
      comment: "Sum of awarded values across trade packages. Represents the total subcontract cost committed."
    - name: "total_budget_allowance"
      expr: SUM(CAST(budget_allowance AS DOUBLE))
      comment: "Sum of budget allowances across trade packages. Represents the total budget set aside for subcontract procurement."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across awarded trade packages. Monitors retention policy consistency and cash flow impact on subcontractors."
    - name: "avg_liquidated_damages_rate"
      expr: AVG(CAST(liquidated_damages_rate AS DOUBLE))
      comment: "Average liquidated damages rate across trade packages. Tracks contractual penalty exposure and risk allocation to subcontractors."
    - name: "award_vs_estimate_variance"
      expr: SUM((CAST(awarded_value AS DOUBLE)) - (CAST(estimated_value AS DOUBLE)))
      comment: "Difference between total awarded value and total estimated value. Positive values indicate cost overrun at procurement; negative values indicate savings. Key procurement performance KPI."
    - name: "bid_competitiveness_ratio"
      expr: ROUND(SUM(CAST(awarded_value AS DOUBLE)) / NULLIF(SUM(CAST(estimated_value AS DOUBLE)), 0), 4)
      comment: "Ratio of awarded value to estimated value. Values below 1.0 indicate procurement savings; above 1.0 indicate cost growth. Used to benchmark estimating accuracy and procurement effectiveness."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`bid_clarification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tender clarification KPIs — volume, response compliance, scope/price/schedule impact rates, and critical clarification concentration. Used by bid managers to govern clarification management and identify high-impact tender issues."
  source: "`construction_ecm`.`bid`.`clarification`"
  dimensions:
    - name: "clarification_status"
      expr: clarification_status
      comment: "Current status of the clarification (e.g. open, responded, closed) for workflow management."
    - name: "communication_type"
      expr: communication_type
      comment: "Type of communication (e.g. RFI, addendum, query) for clarification channel analysis."
    - name: "direction"
      expr: direction
      comment: "Direction of the clarification (e.g. inbound from client, outbound to client) for accountability tracking."
    - name: "response_status"
      expr: response_status
      comment: "Status of the response to the clarification, for response compliance monitoring."
    - name: "is_critical"
      expr: is_critical
      comment: "Flags critical clarifications requiring urgent resolution, for priority management."
    - name: "impact_flag_price"
      expr: impact_flag_price
      comment: "Indicates clarifications with a price impact, for commercial risk monitoring."
    - name: "impact_flag_scope"
      expr: impact_flag_scope
      comment: "Indicates clarifications with a scope impact, for scope change management."
    - name: "impact_flag_schedule"
      expr: impact_flag_schedule
      comment: "Indicates clarifications with a schedule impact, for programme risk monitoring."
    - name: "bid_revision_triggered"
      expr: bid_revision_triggered
      comment: "Flags clarifications that triggered a bid revision, for rework and process efficiency analysis."
    - name: "event_timestamp_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of clarification event for time-series volume and impact trending."
  measures:
    - name: "total_clarifications"
      expr: COUNT(1)
      comment: "Total number of clarifications raised. Baseline volume for tender complexity and bid management workload analysis."
    - name: "total_impact_amount"
      expr: SUM(CAST(impact_amount AS DOUBLE))
      comment: "Sum of financial impact amounts across clarifications. Represents the aggregate commercial exposure from tender clarifications."
    - name: "critical_clarification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_critical = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of clarifications flagged as critical. High rates indicate complex or poorly defined tender scope."
    - name: "price_impact_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN impact_flag_price = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of clarifications with a price impact. Tracks commercial risk exposure from tender ambiguities."
    - name: "bid_revision_trigger_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN bid_revision_triggered = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of clarifications that triggered a bid revision. High rates indicate rework burden and process inefficiency."
    - name: "response_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN response_status = 'Responded' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of clarifications with a completed response. Tracks response discipline and client communication compliance."
$$;