-- Metric views for domain: grant | Business: Ngo | Version: 2 | Generated on: 2026-06-23 02:03:19

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_award`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for grant awards — tracks portfolio value, cost-share commitments, indirect cost ceilings, and endowment-funded award exposure to support executive grant portfolio management."
  source: "`vibe_ngo_v1`.`grant`.`award`"
  dimensions:
    - name: "award_status"
      expr: award_status
      comment: "Current lifecycle status of the award (e.g., Active, Closed, Suspended) — primary filter for portfolio health analysis."
    - name: "award_type"
      expr: award_type
      comment: "Classification of the award instrument (e.g., Grant, Cooperative Agreement, Contract) — drives compliance and reporting obligations."
    - name: "grant_direction"
      expr: grant_direction
      comment: "Indicates whether the award is inbound (received) or outbound (made) — critical for distinguishing revenue vs. grantmaking activity."
    - name: "currency"
      expr: currency
      comment: "Award currency code — used for multi-currency portfolio analysis."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Restriction classification of the award funds (e.g., Restricted, Unrestricted, Temporarily Restricted) — essential for net asset management."
    - name: "thematic_sector"
      expr: thematic_sector
      comment: "Thematic or programmatic sector of the award — enables portfolio analysis by strategic focus area."
    - name: "grantmaking_program_area"
      expr: grantmaking_program_area
      comment: "Program area for outbound grantmaking awards — supports grantmaking portfolio segmentation."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic coverage of the award — enables regional portfolio analysis."
    - name: "funding_mechanism"
      expr: funding_mechanism
      comment: "Mechanism through which funding is delivered (e.g., Fixed Obligation, Cost Reimbursable) — affects financial management approach."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code for ODA classification and donor reporting alignment."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "UN Sustainable Development Goal alignment — supports impact reporting and strategic positioning."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of donor reporting required — used to assess reporting burden across the portfolio."
    - name: "net_asset_classification"
      expr: net_asset_classification
      comment: "Net asset class of the award (e.g., With Donor Restrictions, Without Donor Restrictions) — required for GAAP financial statement presentation."
    - name: "is_endowment_funded"
      expr: is_endowment_funded
      comment: "Flag indicating whether the award is funded from endowment — distinguishes endowment-draw awards from operating grants."
    - name: "cost_share_required"
      expr: cost_share_required
      comment: "Indicates whether the award requires a cost-share or match commitment from the organization."
    - name: "audit_required"
      expr: audit_required
      comment: "Indicates whether the award triggers an audit requirement — used for compliance risk planning."
    - name: "agreement_signed_date_month"
      expr: DATE_TRUNC('MONTH', agreement_signed_date)
      comment: "Month the award agreement was signed — enables trend analysis of new award execution over time."
    - name: "start_date_year"
      expr: YEAR(start_date)
      comment: "Year the award period of performance begins — used for cohort and vintage analysis."
    - name: "end_date_year"
      expr: YEAR(end_date)
      comment: "Year the award period of performance ends — used to identify upcoming closeouts."
  measures:
    - name: "total_awards"
      expr: COUNT(1)
      comment: "Total number of award records — baseline portfolio count for executive dashboards."
    - name: "total_authorized_amount"
      expr: SUM(CAST(authorized_amount AS DOUBLE))
      comment: "Sum of all authorized award amounts in award currency — represents the total grant portfolio value authorized by donors."
    - name: "total_obligated_amount"
      expr: SUM(CAST(total_obligated_amount AS DOUBLE))
      comment: "Sum of total obligated amounts across all awards — measures the legally committed funding the organization must deliver against."
    - name: "total_obligated_amount_functional"
      expr: SUM(CAST(total_obligated_amount_functional AS DOUBLE))
      comment: "Sum of obligated amounts converted to functional currency — enables consolidated financial reporting across multi-currency awards."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share or match commitment across all awards — critical for tracking organizational co-investment obligations to donors."
    - name: "total_indirect_cost_ceiling"
      expr: SUM(CAST(indirect_cost_ceiling AS DOUBLE))
      comment: "Sum of indirect cost ceilings across awards — measures the maximum indirect cost recovery allowed by donors across the portfolio."
    - name: "total_endowment_draw_amount"
      expr: SUM(CAST(endowment_draw_amount AS DOUBLE))
      comment: "Total endowment draw amounts across awards — tracks how much endowment corpus is being utilized to fund programmatic activity."
    - name: "avg_authorized_amount"
      expr: AVG(CAST(authorized_amount AS DOUBLE))
      comment: "Average authorized amount per award — benchmarks typical award size for portfolio planning and business development targeting."
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost-share percentage required across awards — indicates the typical organizational match burden relative to donor funding."
    - name: "avg_nicra_icr_rate"
      expr: AVG(CAST(nicra_icr_rate AS DOUBLE))
      comment: "Average NICRA indirect cost recovery rate applied across awards — used to assess indirect cost recovery performance vs. negotiated rates."
    - name: "endowment_funded_award_count"
      expr: COUNT(CASE WHEN is_endowment_funded = TRUE THEN 1 END)
      comment: "Number of awards funded from endowment — tracks endowment utilization for board-level stewardship reporting."
    - name: "audit_required_award_count"
      expr: COUNT(CASE WHEN audit_required = TRUE THEN 1 END)
      comment: "Number of awards requiring an audit — used by finance and compliance teams to plan audit workload and budget."
    - name: "cost_share_required_award_count"
      expr: COUNT(CASE WHEN cost_share_required = TRUE THEN 1 END)
      comment: "Number of awards with a cost-share requirement — helps leadership assess the scale of match obligations across the portfolio."
    - name: "outbound_grant_count"
      expr: COUNT(CASE WHEN is_grant_made_out = TRUE THEN 1 END)
      comment: "Number of outbound grants made — tracks grantmaking activity volume for program officers and board reporting."
    - name: "avg_audit_threshold_amount"
      expr: AVG(CAST(audit_threshold_amount AS DOUBLE))
      comment: "Average audit threshold amount across awards — informs compliance planning for single audit and donor audit requirements."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_award_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget performance KPIs for grant awards — tracks approved budgets, direct vs. indirect cost composition, cost-share commitments, and budget amendment activity to support financial management and donor compliance."
  source: "`vibe_ngo_v1`.`grant`.`award_budget`"
  dimensions:
    - name: "budget_version_number"
      expr: budget_version_number
      comment: "Version number of the budget — used to track amendment history and identify the current approved budget."
    - name: "award_currency"
      expr: award_currency
      comment: "Currency of the award budget — enables multi-currency budget analysis."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Fund restriction classification of the budget — required for restricted vs. unrestricted budget analysis."
    - name: "net_asset_classification"
      expr: net_asset_classification
      comment: "Net asset classification of the budget — supports GAAP-compliant financial statement preparation."
    - name: "cost_share_required"
      expr: cost_share_required
      comment: "Indicates whether this budget version includes a cost-share requirement."
    - name: "is_amendment"
      expr: is_amendment
      comment: "Flag indicating whether this budget record is an amendment to a prior approved budget."
    - name: "approved_by"
      expr: approved_by
      comment: "Individual or role that approved the budget — used for governance and audit trail analysis."
    - name: "budget_period_start_month"
      expr: DATE_TRUNC('MONTH', budget_period_start_date)
      comment: "Month the budget period begins — enables time-series analysis of budget periods across the portfolio."
    - name: "budget_period_end_year"
      expr: YEAR(budget_period_end_date)
      comment: "Year the budget period ends — used for multi-year budget planning and closeout forecasting."
    - name: "donor_approval_date_month"
      expr: DATE_TRUNC('MONTH', donor_approval_date)
      comment: "Month donor approval was received — tracks approval cycle times and pipeline velocity."
  measures:
    - name: "total_budget_records"
      expr: COUNT(1)
      comment: "Total number of award budget records — baseline count for budget management tracking."
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_budget AS DOUBLE))
      comment: "Sum of all approved budget amounts — represents the total donor-approved funding envelope across the portfolio."
    - name: "total_direct_costs"
      expr: SUM(CAST(total_direct_costs AS DOUBLE))
      comment: "Sum of all approved direct costs — measures the programmatic cost base across the grant portfolio."
    - name: "total_indirect_costs"
      expr: SUM(CAST(total_indirect_costs AS DOUBLE))
      comment: "Sum of all approved indirect costs — tracks overhead recovery across the grant portfolio."
    - name: "total_personnel_costs"
      expr: SUM(CAST(personnel_costs AS DOUBLE))
      comment: "Sum of approved personnel costs — the largest cost category for most NGOs; critical for workforce planning and budget analysis."
    - name: "total_travel_costs"
      expr: SUM(CAST(travel_costs AS DOUBLE))
      comment: "Sum of approved travel costs — monitored for donor compliance and cost efficiency."
    - name: "total_equipment_costs"
      expr: SUM(CAST(equipment_costs AS DOUBLE))
      comment: "Sum of approved equipment costs — tracked for capital expenditure planning and donor prior-approval compliance."
    - name: "total_contractual_costs"
      expr: SUM(CAST(contractual_costs AS DOUBLE))
      comment: "Sum of approved contractual/subaward costs — measures the volume of pass-through funding to implementing partners."
    - name: "total_supplies_costs"
      expr: SUM(CAST(supplies_costs AS DOUBLE))
      comment: "Sum of approved supplies costs — tracked for procurement planning and donor compliance."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share amounts committed in approved budgets — tracks organizational match obligations to donors."
    - name: "total_endowment_draw_amount"
      expr: SUM(CAST(endowment_draw_amount AS DOUBLE))
      comment: "Total endowment draw amounts budgeted — tracks planned utilization of endowment funds for programmatic activity."
    - name: "avg_nicra_rate_applied"
      expr: AVG(CAST(nicra_rate_applied AS DOUBLE))
      comment: "Average NICRA indirect cost rate applied across budget records — benchmarks actual rate application vs. negotiated rates."
    - name: "amendment_budget_count"
      expr: COUNT(CASE WHEN is_amendment = TRUE THEN 1 END)
      comment: "Number of budget records that are amendments — high amendment rates signal scope instability or donor negotiation complexity."
    - name: "avg_approved_budget"
      expr: AVG(CAST(total_approved_budget AS DOUBLE))
      comment: "Average approved budget per award budget record — benchmarks typical award budget size for portfolio planning."
    - name: "indirect_cost_base_total"
      expr: SUM(CAST(indirect_cost_base AS DOUBLE))
      comment: "Total indirect cost base across all budgets — used to calculate effective indirect cost recovery rates and negotiate future NICRA rates."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_award_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-item budget execution KPIs — tracks approved vs. revised amounts, cumulative expenditure, variance, and indirect cost application at the budget line level to support financial monitoring and donor compliance."
  source: "`vibe_ngo_v1`.`grant`.`award_budget_line`"
  dimensions:
    - name: "line_item_code"
      expr: line_item_code
      comment: "Budget line item code — standard cost classification code used for donor reporting and financial tracking."
    - name: "line_description"
      expr: line_description
      comment: "Descriptive label for the budget line — provides human-readable context for financial analysis."
    - name: "donor_reporting_category"
      expr: donor_reporting_category
      comment: "Donor-defined reporting category for the budget line — maps internal cost categories to donor reporting requirements."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Fund restriction type at the budget line level — enables restricted vs. unrestricted expenditure analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget line — enables annual budget vs. actuals analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (e.g., quarter or month) of the budget line — supports periodic financial monitoring."
    - name: "allocability_flag"
      expr: allocability_flag
      comment: "Indicates whether the cost is allocable to the award — used for allowability and compliance review."
    - name: "allowability_flag"
      expr: allowability_flag
      comment: "Indicates whether the cost is allowable under the award terms — critical for audit and compliance monitoring."
    - name: "cost_share_required_flag"
      expr: cost_share_required_flag
      comment: "Indicates whether this budget line includes a cost-share requirement."
    - name: "revision_reason"
      expr: revision_reason
      comment: "Reason for budget line revision — used to analyze drivers of budget changes and amendment patterns."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the budget line quantity — supports unit cost analysis and procurement planning."
    - name: "approval_date_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the budget line was approved — tracks approval cycle times."
    - name: "fiscal_year_dim"
      expr: fiscal_year
      comment: "Fiscal year dimension for time-series budget analysis."
  measures:
    - name: "total_budget_lines"
      expr: COUNT(1)
      comment: "Total number of budget line records — baseline count for budget granularity analysis."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Sum of all approved budget line amounts in award currency — total approved budget at line-item granularity."
    - name: "total_approved_amount_usd"
      expr: SUM(CAST(approved_amount_usd AS DOUBLE))
      comment: "Sum of all approved budget line amounts in USD — enables cross-currency portfolio comparison."
    - name: "total_revised_amount"
      expr: SUM(CAST(revised_amount AS DOUBLE))
      comment: "Sum of all revised budget line amounts — reflects the current approved budget after amendments."
    - name: "total_revised_amount_usd"
      expr: SUM(CAST(revised_amount_usd AS DOUBLE))
      comment: "Sum of all revised budget line amounts in USD — current approved budget in functional currency."
    - name: "total_cumulative_expenditure"
      expr: SUM(CAST(cumulative_expenditure AS DOUBLE))
      comment: "Sum of cumulative expenditure across all budget lines — measures total spending against approved budgets."
    - name: "total_cumulative_expenditure_usd"
      expr: SUM(CAST(cumulative_expenditure_usd AS DOUBLE))
      comment: "Sum of cumulative expenditure in USD — enables consolidated spending analysis across multi-currency awards."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Sum of budget variance amounts (approved minus actual) — identifies over- or under-spending across the portfolio."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage across lines — benchmarks budget execution accuracy and forecasting quality."
    - name: "total_indirect_cost_amount"
      expr: SUM(CAST(indirect_cost_amount AS DOUBLE))
      comment: "Sum of indirect cost amounts applied at the budget line level — tracks overhead recovery at granular cost level."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share amounts at budget line level — tracks match commitment fulfillment at granular level."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across budget lines — used for cost benchmarking and value-for-money analysis."
    - name: "avg_nicra_rate_applied"
      expr: AVG(CAST(nicra_rate_applied AS DOUBLE))
      comment: "Average NICRA rate applied at budget line level — monitors consistency of indirect cost rate application."
    - name: "non_allowable_line_count"
      expr: COUNT(CASE WHEN allowability_flag = FALSE THEN 1 END)
      comment: "Number of budget lines flagged as non-allowable — critical compliance metric for audit risk management."
    - name: "non_allocable_line_count"
      expr: COUNT(CASE WHEN allocability_flag = FALSE THEN 1 END)
      comment: "Number of budget lines flagged as non-allocable — identifies costs that cannot be charged to the award."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_donor_condition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance and risk KPIs for donor-imposed award conditions — tracks condition fulfillment, overdue items, financial thresholds, and risk ratings to support compliance management and board governance."
  source: "`vibe_ngo_v1`.`grant`.`donor_condition`"
  dimensions:
    - name: "condition_type"
      expr: condition_type
      comment: "Type of donor condition (e.g., Precedent, Subsequent, Reporting) — drives compliance workflow and escalation logic."
    - name: "condition_category"
      expr: condition_category
      comment: "Category of the condition (e.g., Financial, Programmatic, Legal) — enables compliance analysis by domain."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the condition (e.g., Met, Pending, Overdue) — primary KPI driver for compliance dashboards."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the condition — used to prioritize compliance interventions."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the condition — used to triage compliance workload."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for fulfilling the condition — enables workload distribution analysis."
    - name: "monitoring_frequency"
      expr: monitoring_frequency
      comment: "Frequency at which the condition is monitored — used for compliance calendar planning."
    - name: "is_board_governance_condition"
      expr: is_board_governance_condition
      comment: "Indicates whether the condition requires board-level governance action — critical for board reporting."
    - name: "requires_board_action_flag"
      expr: requires_board_action_flag
      comment: "Flag indicating board action is required to fulfill the condition — used for board agenda planning."
    - name: "endowment_restriction_flag"
      expr: endowment_restriction_flag
      comment: "Indicates whether the condition relates to endowment restrictions — relevant for endowment stewardship reporting."
    - name: "approval_authority"
      expr: approval_authority
      comment: "Authority level required to approve condition fulfillment — used for governance and delegation analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the condition is due — enables forward-looking compliance calendar analysis."
    - name: "actual_completion_date_month"
      expr: DATE_TRUNC('MONTH', actual_completion_date)
      comment: "Month the condition was actually completed — used to measure compliance timeliness."
  measures:
    - name: "total_conditions"
      expr: COUNT(1)
      comment: "Total number of donor conditions — baseline count for compliance workload assessment."
    - name: "overdue_condition_count"
      expr: COUNT(CASE WHEN compliance_status = 'Overdue' THEN 1 END)
      comment: "Number of conditions currently overdue — leading indicator of compliance risk and potential donor relationship issues."
    - name: "met_condition_count"
      expr: COUNT(CASE WHEN compliance_status = 'Met' THEN 1 END)
      comment: "Number of conditions successfully met — measures compliance fulfillment performance."
    - name: "board_action_required_count"
      expr: COUNT(CASE WHEN requires_board_action_flag = TRUE THEN 1 END)
      comment: "Number of conditions requiring board action — used to populate board compliance agenda items."
    - name: "high_risk_condition_count"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN 1 END)
      comment: "Number of high-risk conditions — used by leadership to prioritize compliance interventions and resource allocation."
    - name: "total_financial_threshold_amount"
      expr: SUM(CAST(financial_threshold_amount AS DOUBLE))
      comment: "Sum of financial threshold amounts across conditions — quantifies the financial exposure associated with donor conditions."
    - name: "avg_financial_threshold_amount"
      expr: AVG(CAST(financial_threshold_amount AS DOUBLE))
      comment: "Average financial threshold per condition — benchmarks the typical financial stakes of compliance obligations."
    - name: "board_governance_condition_count"
      expr: COUNT(CASE WHEN is_board_governance_condition = TRUE THEN 1 END)
      comment: "Number of conditions classified as board governance conditions — informs board oversight workload and governance reporting."
    - name: "endowment_restriction_condition_count"
      expr: COUNT(CASE WHEN endowment_restriction_flag = TRUE THEN 1 END)
      comment: "Number of conditions related to endowment restrictions — supports endowment stewardship and donor intent compliance."
    - name: "unique_awards_with_conditions"
      expr: COUNT(DISTINCT award_id)
      comment: "Number of distinct awards with at least one donor condition — measures the breadth of compliance obligations across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_donor_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor reporting performance KPIs — tracks submission timeliness, financial reporting accuracy, budget variance, and KPI achievement to support compliance management and donor relationship stewardship."
  source: "`vibe_ngo_v1`.`grant`.`donor_report`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of donor report (e.g., Financial, Narrative, Final) — primary segmentation for reporting workload analysis."
    - name: "report_status"
      expr: report_status
      comment: "Current status of the report (e.g., Draft, Submitted, Accepted, Overdue) — drives compliance monitoring."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of reporting required (e.g., Quarterly, Annual) — used for reporting calendar planning."
    - name: "financial_currency"
      expr: financial_currency
      comment: "Currency in which financial amounts are reported — enables multi-currency reporting analysis."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the report (e.g., Online Portal, Email) — used for process efficiency analysis."
    - name: "is_overdue"
      expr: is_overdue
      comment: "Flag indicating whether the report is overdue — primary compliance risk indicator."
    - name: "is_final_version"
      expr: is_final_version
      comment: "Indicates whether this is the final accepted version of the report."
    - name: "compliance_certification_flag"
      expr: compliance_certification_flag
      comment: "Indicates whether the report includes a compliance certification — required for many institutional donors."
    - name: "board_reported_flag"
      expr: board_reported_flag
      comment: "Indicates whether this report was presented to the board — used for board governance tracking."
    - name: "reporting_period_end_year"
      expr: YEAR(reporting_period_end_date)
      comment: "Year the reporting period ends — enables annual reporting performance analysis."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the report was submitted — enables trend analysis of reporting timeliness."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the report was due — used for compliance calendar and workload planning."
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total number of donor reports — baseline count for reporting workload management."
    - name: "overdue_report_count"
      expr: COUNT(CASE WHEN is_overdue = TRUE THEN 1 END)
      comment: "Number of overdue donor reports — critical compliance risk metric that directly affects donor relationships and future funding."
    - name: "submitted_report_count"
      expr: COUNT(CASE WHEN report_status = 'Submitted' THEN 1 END)
      comment: "Number of reports successfully submitted — measures reporting throughput and compliance fulfillment."
    - name: "total_financial_amount_reported"
      expr: SUM(CAST(financial_amount_reported AS DOUBLE))
      comment: "Sum of financial amounts reported to donors — measures total financial accountability reported across the portfolio."
    - name: "total_financial_amount_reported_usd"
      expr: SUM(CAST(financial_amount_reported_usd AS DOUBLE))
      comment: "Sum of financial amounts reported in USD — enables consolidated financial reporting analysis across currencies."
    - name: "total_cumulative_expenditure_to_date"
      expr: SUM(CAST(cumulative_expenditure_to_date AS DOUBLE))
      comment: "Sum of cumulative expenditure reported to date across all reports — tracks total spending accountability to donors."
    - name: "total_budget_variance_amount"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Sum of budget variance amounts reported — measures total over/under-spending reported to donors across the portfolio."
    - name: "avg_budget_variance_percentage"
      expr: AVG(CAST(budget_variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage across reports — benchmarks financial execution accuracy as reported to donors."
    - name: "total_grantmaking_disbursed_amount"
      expr: SUM(CAST(grantmaking_disbursed_amount AS DOUBLE))
      comment: "Total grantmaking disbursements reported — tracks outbound grant payments reported to donors for pass-through accountability."
    - name: "total_net_asset_release_amount"
      expr: SUM(CAST(net_asset_release_amount AS DOUBLE))
      comment: "Total net asset releases reported — tracks the release of donor restrictions as programmatic milestones are achieved."
    - name: "total_endowment_draw_reported"
      expr: SUM(CAST(endowment_draw_reported_amount AS DOUBLE))
      comment: "Total endowment draw amounts reported to donors — tracks endowment utilization accountability."
    - name: "unique_awards_reported"
      expr: COUNT(DISTINCT award_id)
      comment: "Number of distinct awards with at least one donor report — measures reporting coverage across the grant portfolio."
    - name: "avg_exchange_rate_used"
      expr: AVG(CAST(exchange_rate_used AS DOUBLE))
      comment: "Average exchange rate used in donor reports — used to assess currency translation consistency and FX risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Business development pipeline KPIs — tracks proposal win rates, requested funding volumes, cost-share commitments, and pipeline conversion to support strategic resource allocation and fundraising performance management."
  source: "`vibe_ngo_v1`.`grant`.`proposal`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current status of the proposal (e.g., In Development, Submitted, Won, Lost) — primary pipeline stage indicator."
    - name: "proposal_type"
      expr: proposal_type
      comment: "Type of proposal (e.g., Unsolicited, Competitive, Sole Source) — used to analyze pipeline composition and win rate by type."
    - name: "win_loss_outcome"
      expr: win_loss_outcome
      comment: "Final outcome of the proposal (Won, Lost, Withdrawn) — drives win rate and pipeline conversion analysis."
    - name: "direction"
      expr: direction
      comment: "Direction of the proposal (Inbound/Outbound) — distinguishes fundraising proposals from grantmaking applications."
    - name: "grantmaking_direction"
      expr: grantmaking_direction
      comment: "Grantmaking direction for outbound proposals — used to segment grantmaking pipeline."
    - name: "grantmaking_program_area"
      expr: grantmaking_program_area
      comment: "Program area for grantmaking proposals — enables pipeline analysis by strategic program area."
    - name: "lead_technical_sector"
      expr: lead_technical_sector
      comment: "Primary technical sector of the proposal — used to analyze pipeline by sector and align with organizational capacity."
    - name: "geographic_focus"
      expr: geographic_focus
      comment: "Geographic focus of the proposal — enables regional pipeline analysis."
    - name: "go_no_go_decision"
      expr: go_no_go_decision
      comment: "Go/No-Go decision outcome — used to analyze proposal qualification rates and business development efficiency."
    - name: "board_approval_status"
      expr: board_approval_status
      comment: "Board approval status for proposals requiring board authorization — used for governance tracking."
    - name: "partnership_model"
      expr: partnership_model
      comment: "Partnership model for the proposal (e.g., Prime, Sub, Consortium) — used to analyze competitive positioning."
    - name: "requested_currency"
      expr: requested_currency
      comment: "Currency of the requested funding amount — enables multi-currency pipeline analysis."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the proposal was submitted — enables trend analysis of business development activity."
    - name: "proposed_start_date_year"
      expr: YEAR(proposed_start_date)
      comment: "Year the proposed program would start — used for pipeline timing and resource planning."
    - name: "go_no_go_decision_date_month"
      expr: DATE_TRUNC('MONTH', go_no_go_decision_date)
      comment: "Month the Go/No-Go decision was made — used to analyze decision cycle times."
  measures:
    - name: "total_proposals"
      expr: COUNT(1)
      comment: "Total number of proposals — baseline pipeline volume metric for business development management."
    - name: "total_requested_amount"
      expr: SUM(CAST(requested_amount AS DOUBLE))
      comment: "Sum of all requested funding amounts in proposal currency — measures total pipeline value for fundraising forecasting."
    - name: "total_requested_amount_usd"
      expr: SUM(CAST(requested_amount_usd AS DOUBLE))
      comment: "Sum of all requested funding amounts in USD — enables consolidated pipeline value analysis across currencies."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share amounts proposed — tracks organizational match commitments in the pipeline."
    - name: "avg_requested_amount_usd"
      expr: AVG(CAST(requested_amount_usd AS DOUBLE))
      comment: "Average requested amount per proposal in USD — benchmarks typical proposal size for portfolio planning."
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost-share percentage proposed — indicates the typical match burden being committed in the pipeline."
    - name: "won_proposal_count"
      expr: COUNT(CASE WHEN win_loss_outcome = 'Won' THEN 1 END)
      comment: "Number of proposals won — measures business development success and fundraising effectiveness."
    - name: "lost_proposal_count"
      expr: COUNT(CASE WHEN win_loss_outcome = 'Lost' THEN 1 END)
      comment: "Number of proposals lost — used with won count to calculate win rate and identify improvement areas."
    - name: "submitted_proposal_count"
      expr: COUNT(CASE WHEN proposal_status = 'Submitted' THEN 1 END)
      comment: "Number of proposals currently submitted and awaiting decision — measures active pipeline volume."
    - name: "go_decision_count"
      expr: COUNT(CASE WHEN go_no_go_decision = 'Go' THEN 1 END)
      comment: "Number of proposals that received a Go decision — measures pipeline qualification rate."
    - name: "outbound_grant_application_count"
      expr: COUNT(CASE WHEN is_outbound_grant_application = TRUE THEN 1 END)
      comment: "Number of outbound grant applications — tracks grantmaking pipeline volume separately from fundraising."
    - name: "avg_indirect_cost_rate_proposed"
      expr: AVG(CAST(indirect_cost_rate_proposed AS DOUBLE))
      comment: "Average indirect cost rate proposed across proposals — monitors consistency of overhead recovery in business development."
    - name: "won_requested_amount_usd"
      expr: SUM(CASE WHEN win_loss_outcome = 'Won' THEN CAST(requested_amount_usd AS DOUBLE) ELSE 0 END)
      comment: "Total requested amount for won proposals in USD — measures the dollar value of successful fundraising outcomes."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_solicitation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Funding opportunity pipeline KPIs — tracks solicitation identification, estimated funding volumes, competitive positioning, and go/no-go decision rates to support strategic business development planning."
  source: "`vibe_ngo_v1`.`grant`.`solicitation`"
  dimensions:
    - name: "solicitation_status"
      expr: solicitation_status
      comment: "Current status of the solicitation (e.g., Open, Closed, Awarded) — primary pipeline stage indicator."
    - name: "solicitation_type"
      expr: solicitation_type
      comment: "Type of solicitation (e.g., RFP, RFA, NOFO) — used to analyze opportunity pipeline by instrument type."
    - name: "thematic_focus_area"
      expr: thematic_focus_area
      comment: "Thematic focus area of the solicitation — enables pipeline analysis by strategic sector."
    - name: "grantmaking_focus_area"
      expr: grantmaking_focus_area
      comment: "Focus area for grantmaking solicitations — used to segment outbound grantmaking opportunities."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code — used for ODA classification and strategic alignment analysis."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the solicitation — supports impact-focused pipeline analysis."
    - name: "funding_currency"
      expr: funding_currency
      comment: "Currency of the solicitation funding — enables multi-currency pipeline analysis."
    - name: "submission_method"
      expr: submission_method
      comment: "Required submission method — used for process planning and resource allocation."
    - name: "is_grantmaking_rfp"
      expr: is_grantmaking_rfp
      comment: "Indicates whether this is an outbound grantmaking RFP — distinguishes grantmaking from fundraising opportunities."
    - name: "cost_share_required"
      expr: cost_share_required
      comment: "Indicates whether the solicitation requires cost-share — used to assess organizational match capacity."
    - name: "indirect_cost_rate_allowed"
      expr: indirect_cost_rate_allowed
      comment: "Indicates whether indirect costs are allowed — critical for financial viability assessment of opportunities."
    - name: "consortium_allowed"
      expr: consortium_allowed
      comment: "Indicates whether consortium applications are permitted — used for partnership strategy planning."
    - name: "identified_date_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the solicitation was identified — tracks pipeline identification velocity over time."
    - name: "publication_date_month"
      expr: DATE_TRUNC('MONTH', publication_date)
      comment: "Month the solicitation was published — used for pipeline timing analysis."
    - name: "anticipated_award_date_year"
      expr: YEAR(anticipated_award_date)
      comment: "Year the award is anticipated — used for revenue forecasting and resource planning."
  measures:
    - name: "total_solicitations"
      expr: COUNT(1)
      comment: "Total number of solicitations tracked — baseline pipeline volume for business development management."
    - name: "total_estimated_funding_amount"
      expr: SUM(CAST(estimated_funding_amount AS DOUBLE))
      comment: "Sum of estimated funding amounts across all solicitations — measures total addressable pipeline value for strategic planning."
    - name: "avg_estimated_funding_amount"
      expr: AVG(CAST(estimated_funding_amount AS DOUBLE))
      comment: "Average estimated funding amount per solicitation — benchmarks typical opportunity size for portfolio targeting."
    - name: "total_board_authorized_funding_pool"
      expr: SUM(CAST(board_authorized_funding_pool AS DOUBLE))
      comment: "Total board-authorized funding pool across solicitations — tracks board-approved grantmaking capacity."
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost-share percentage required across solicitations — assesses the typical match burden in the opportunity pipeline."
    - name: "avg_indirect_cost_rate_cap"
      expr: AVG(CAST(indirect_cost_rate_cap AS DOUBLE))
      comment: "Average indirect cost rate cap across solicitations — monitors overhead recovery constraints in the pipeline."
    - name: "grantmaking_rfp_count"
      expr: COUNT(CASE WHEN is_grantmaking_rfp = TRUE THEN 1 END)
      comment: "Number of outbound grantmaking RFPs — tracks grantmaking opportunity pipeline volume."
    - name: "cost_share_required_count"
      expr: COUNT(CASE WHEN cost_share_required = TRUE THEN 1 END)
      comment: "Number of solicitations requiring cost-share — used to assess organizational match capacity requirements."
    - name: "indirect_cost_not_allowed_count"
      expr: COUNT(CASE WHEN indirect_cost_rate_allowed = FALSE THEN 1 END)
      comment: "Number of solicitations that do not allow indirect costs — identifies financially constrained opportunities that may not be viable."
    - name: "unique_funding_sources_in_pipeline"
      expr: COUNT(DISTINCT funding_source_id)
      comment: "Number of distinct funding sources represented in the solicitation pipeline — measures donor diversification of the opportunity pipeline."
    - name: "go_no_go_rationale_avg"
      expr: AVG(CAST(go_no_go_rationale AS DOUBLE))
      comment: "Average go/no-go rationale score across solicitations — used to benchmark opportunity qualification standards."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_subaward`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subaward portfolio KPIs — tracks obligated amounts, disbursements, remaining balances, indirect cost recovery, and partner risk ratings to support subrecipient management and pass-through funding accountability."
  source: "`vibe_ngo_v1`.`grant`.`award`"
  dimensions:
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Fund restriction type of the subaward — required for restricted vs. unrestricted pass-through analysis."
    - name: "fund_restriction_class"
      expr: fund_restriction_class
      comment: "Fund restriction class — supports net asset management and GAAP reporting."
    - name: "currency"
      expr: currency
      comment: "Currency of the subaward — enables multi-currency portfolio analysis."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of subrecipient reporting — used for compliance calendar planning."
  measures:
    - name: "total_subawards"
      expr: COUNT(1)
      comment: "Total number of subawards — baseline portfolio count for subrecipient management."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share amounts in subawards — tracks partner match commitments across the subaward portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_sub_award_disbursement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subaward disbursement cash flow KPIs — tracks disbursement volumes, liquidation performance, advance balances, and withholding to support cash management, partner accountability, and donor financial reporting."
  source: "`vibe_ngo_v1`.`grant`.`sub_award_disbursement`"
  dimensions:
    - name: "liquidation_status"
      expr: liquidation_status
      comment: "Current liquidation status of the disbursement (e.g., Liquidated, Pending, Overdue) — primary accountability indicator for advance management."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Fund restriction type of the disbursement — required for restricted vs. unrestricted cash flow analysis."
    - name: "donor_reporting_category"
      expr: donor_reporting_category
      comment: "Donor reporting category for the disbursement — maps cash flows to donor reporting requirements."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the disbursement — enables annual cash flow analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the disbursement — supports periodic cash flow monitoring."
    - name: "is_emergency_disbursement"
      expr: is_emergency_disbursement
      comment: "Indicates whether this is an emergency disbursement — used to track unplanned cash flows and emergency response spending."
    - name: "is_grantmaking_disbursement"
      expr: is_grantmaking_disbursement
      comment: "Indicates whether this is a grantmaking disbursement — distinguishes charitable grant payments from contractual subaward payments."
    - name: "tranche_number"
      expr: tranche_number
      comment: "Tranche number of the disbursement — used to track multi-tranche payment schedules."
    - name: "disbursement_date_month"
      expr: DATE_TRUNC('MONTH', disbursement_date)
      comment: "Month the disbursement was made — enables monthly cash flow trend analysis."
    - name: "liquidation_deadline_month"
      expr: DATE_TRUNC('MONTH', liquidation_deadline)
      comment: "Month the liquidation is due — used for advance management and cash flow forecasting."
    - name: "fiscal_year_dim"
      expr: fiscal_year
      comment: "Fiscal year dimension for annual disbursement analysis."
  measures:
    - name: "total_disbursements"
      expr: COUNT(1)
      comment: "Total number of disbursement transactions — baseline count for cash flow management."
    - name: "total_disbursement_amount"
      expr: SUM(CAST(disbursement_amount AS DOUBLE))
      comment: "Sum of all disbursement amounts in disbursement currency — measures total cash transferred to subrecipients."
    - name: "total_disbursement_amount_usd"
      expr: SUM(CAST(disbursement_amount_usd AS DOUBLE))
      comment: "Sum of all disbursement amounts in USD — enables consolidated cash flow analysis across currencies."
    - name: "total_net_disbursement_amount"
      expr: SUM(CAST(net_disbursement_amount AS DOUBLE))
      comment: "Sum of net disbursement amounts (after withholding) — measures actual cash received by subrecipients."
    - name: "total_liquidated_amount"
      expr: SUM(CAST(liquidated_amount AS DOUBLE))
      comment: "Sum of liquidated amounts — measures how much of disbursed advances have been accounted for by subrecipients."
    - name: "total_advance_balance_outstanding"
      expr: SUM(CAST(advance_balance_outstanding AS DOUBLE))
      comment: "Sum of outstanding advance balances — measures unliquidated advances representing financial risk and accountability gaps."
    - name: "total_withholding_amount"
      expr: SUM(CAST(withholding_amount AS DOUBLE))
      comment: "Sum of withholding amounts across disbursements — tracks amounts withheld pending compliance or performance milestones."
    - name: "total_indirect_cost_amount"
      expr: SUM(CAST(indirect_cost_amount AS DOUBLE))
      comment: "Sum of indirect cost amounts in disbursements — tracks overhead recovery on pass-through cash flows."
    - name: "total_net_asset_release_amount"
      expr: SUM(CAST(net_asset_release_amount AS DOUBLE))
      comment: "Total net asset releases associated with disbursements — tracks restriction releases triggered by partner spending."
    - name: "emergency_disbursement_count"
      expr: COUNT(CASE WHEN is_emergency_disbursement = TRUE THEN 1 END)
      comment: "Number of emergency disbursements — tracks unplanned cash flows for emergency response financial management."
    - name: "grantmaking_disbursement_count"
      expr: COUNT(CASE WHEN is_grantmaking_disbursement = TRUE THEN 1 END)
      comment: "Number of grantmaking disbursements — tracks charitable grant payment volume for grantmaking program reporting."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to disbursements — used to assess FX risk and translation consistency."
    - name: "unique_subawards_disbursed"
      expr: COUNT(DISTINCT subaward_id)
      comment: "Number of distinct subawards with at least one disbursement — measures disbursement coverage across the subaward portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_funding_source`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Funding source portfolio KPIs — tracks total available funding, endowment corpus and market values, spending policy rates, and cost-share requirements to support donor relationship management and financial sustainability planning."
  source: "`vibe_ngo_v1`.`grant`.`funding_source`"
  dimensions:
    - name: "funding_source_status"
      expr: funding_source_status
      comment: "Current status of the funding source (e.g., Active, Inactive, Closed) — primary portfolio health indicator."
    - name: "category"
      expr: category
      comment: "Category of the funding source (e.g., Government, Foundation, Corporate) — enables donor portfolio segmentation."
    - name: "source_category"
      expr: source_category
      comment: "Source category classification — used for donor diversification analysis."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Restriction type of the funding source — required for restricted vs. unrestricted revenue analysis."
    - name: "net_asset_classification"
      expr: net_asset_classification
      comment: "Net asset classification — supports GAAP financial statement preparation."
    - name: "funding_mechanism_type"
      expr: funding_mechanism_type
      comment: "Mechanism type of the funding (e.g., Grant, Contract, Cooperative Agreement) — drives compliance requirements."
    - name: "endowment_fund_flag"
      expr: endowment_fund_flag
      comment: "Indicates whether this is an endowment funding source — distinguishes endowment from operating revenue sources."
    - name: "is_membership_dues_source"
      expr: is_membership_dues_source
      comment: "Indicates whether this source represents membership dues — used for membership revenue analysis."
    - name: "cost_share_required"
      expr: cost_share_required
      comment: "Indicates whether this funding source requires cost-share — used to assess match obligations."
    - name: "subaward_allowed"
      expr: subaward_allowed
      comment: "Indicates whether subawards are permitted under this funding source — used for partnership planning."
    - name: "oda_dac_classification"
      expr: oda_dac_classification
      comment: "ODA/DAC classification of the funding source — used for international development reporting."
    - name: "funding_start_date_year"
      expr: YEAR(funding_start_date)
      comment: "Year the funding source becomes active — used for portfolio vintage analysis."
    - name: "funding_end_date_year"
      expr: YEAR(funding_end_date)
      comment: "Year the funding source expires — used for revenue sustainability planning."
  measures:
    - name: "total_funding_sources"
      expr: COUNT(1)
      comment: "Total number of funding sources — baseline count for donor portfolio management."
    - name: "total_funding_available"
      expr: SUM(CAST(total_funding_available AS DOUBLE))
      comment: "Sum of total funding available across all sources — measures the total addressable funding pool for organizational planning."
    - name: "total_endowment_corpus_amount"
      expr: SUM(CAST(endowment_corpus_amount AS DOUBLE))
      comment: "Sum of endowment corpus amounts — measures total endowment principal under management for board stewardship reporting."
    - name: "total_endowment_market_value"
      expr: SUM(CAST(endowment_market_value AS DOUBLE))
      comment: "Sum of endowment market values — tracks total endowment portfolio value for investment committee reporting."
    - name: "avg_endowment_spending_policy_rate"
      expr: AVG(CAST(endowment_spending_policy_rate AS DOUBLE))
      comment: "Average endowment spending policy rate — benchmarks payout rates against industry standards for board governance."
    - name: "avg_endowment_spending_rate"
      expr: AVG(CAST(endowment_spending_rate AS DOUBLE))
      comment: "Average actual endowment spending rate — compared against policy rate to assess endowment utilization compliance."
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost-share percentage required across funding sources — assesses the typical match burden across the donor portfolio."
    - name: "avg_nicra_rate"
      expr: AVG(CAST(nicra_rate AS DOUBLE))
      comment: "Average NICRA indirect cost rate across funding sources — benchmarks overhead recovery rates across the donor portfolio."
    - name: "endowment_source_count"
      expr: COUNT(CASE WHEN endowment_fund_flag = TRUE THEN 1 END)
      comment: "Number of endowment funding sources — tracks the breadth of endowment relationships for investment committee reporting."
    - name: "membership_dues_source_count"
      expr: COUNT(CASE WHEN is_membership_dues_source = TRUE THEN 1 END)
      comment: "Number of membership dues funding sources — tracks membership revenue diversification."
    - name: "cost_share_required_source_count"
      expr: COUNT(CASE WHEN cost_share_required = TRUE THEN 1 END)
      comment: "Number of funding sources requiring cost-share — used to assess total match obligation exposure across the donor portfolio."
    - name: "active_funding_source_count"
      expr: COUNT(CASE WHEN funding_source_status = 'Active' THEN 1 END)
      comment: "Number of currently active funding sources — measures the active donor portfolio size for relationship management."
$$;