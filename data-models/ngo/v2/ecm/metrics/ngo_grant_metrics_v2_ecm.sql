-- Metric views for domain: grant | Business: Ngo | Version: 2 | Generated on: 2026-06-23 01:23:48

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_award`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the award master table. Tracks portfolio size, financial commitments, cost-share obligations, indirect cost ceilings, and amendment activity. Used by grants management leadership to steer portfolio health, donor compliance, and funding mix decisions. Supports IPSAS and US GAAP (ASC 958) dual-framework reporting as well as SAP VISION and eTools programme management integration."
  source: "`vibe_ngo_v1`.`grant`.`award`"
  dimensions:
    - name: "award_status"
      expr: award_status
      comment: "Lifecycle status of the award (e.g. Active, Closed, Suspended). Primary filter for portfolio health dashboards."
    - name: "award_type"
      expr: award_type
      comment: "Classification of the award instrument (e.g. Grant, Cooperative Agreement, Contract). Drives compliance and reporting requirements."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Donor-imposed restriction class (Unrestricted, Temporarily Restricted, Permanently Restricted / IPSAS net-asset equivalent). Critical for ASC 958 / IPSAS net-asset release analysis."
    - name: "fund_restriction_class"
      expr: fund_restriction_class
      comment: "Broader restriction class grouping used for balance-sheet net-asset classification under US GAAP ASC 958 and IPSAS."
    - name: "currency"
      expr: currency
      comment: "Award transaction currency. Enables multi-currency portfolio analysis alongside functional_currency."
    - name: "functional_currency"
      expr: functional_currency
      comment: "Functional reporting currency for the award. Used for IPSAS/IFRS and SAP VISION ledger reconciliation."
    - name: "award_type_direction"
      expr: direction
      comment: "Indicates whether the award is inbound (received) or outbound (grantmaking-out). Separates fundraising from grantmaking portfolios."
    - name: "thematic_sector"
      expr: thematic_sector
      comment: "Humanitarian or development sector (e.g. WASH, Protection, Food Security). Enables sector-level portfolio analysis."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code for ODA-eligible awards. Required for IATI publication and donor statistical reporting."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "UN Sustainable Development Goal alignment tag. Used for impact reporting and donor stewardship."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Applicable regulatory framework (e.g. US 2 CFR 200, IPSAS, EU PRAG). Determines compliance obligations and audit thresholds."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Donor-required reporting cadence (Monthly, Quarterly, Annual). Drives workload planning for grants reporting teams."
    - name: "funding_mechanism"
      expr: funding_mechanism
      comment: "Mechanism type (e.g. Direct Grant, Sub-award, Loan). Affects financial accounting treatment."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic coverage of the award. Used for country-level portfolio and risk analysis."
    - name: "cost_share_required"
      expr: cost_share_required
      comment: "Boolean flag indicating whether the donor requires a cost-share contribution. Filters awards with matching obligations."
    - name: "audit_required"
      expr: audit_required
      comment: "Boolean flag indicating whether an independent audit is required. Used for audit planning and compliance tracking."
    - name: "is_endowment_funded"
      expr: is_endowment_funded
      comment: "Flags awards funded from endowment draws. Enables endowment-funded vs. grant-funded portfolio split."
    - name: "is_grant_made_out"
      expr: is_grant_made_out
      comment: "Flags outbound grantmaking awards. Separates grantmaking-out flows for foundation/grantmaking program analysis."
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Award start year. Used for cohort and vintage analysis of the grant portfolio."
    - name: "end_year"
      expr: YEAR(end_date)
      comment: "Award end year. Used to identify awards expiring within a planning horizon."
    - name: "net_asset_classification"
      expr: net_asset_classification
      comment: "Net asset class under ASC 958 / IPSAS (Without Donor Restriction, With Donor Restriction). Required for financial statement presentation."
    - name: "grantmaking_program_area"
      expr: grantmaking_program_area
      comment: "Program area for outbound grantmaking awards. Used by foundation program officers to track grant portfolio by focus area."
  measures:
    - name: "total_awards"
      expr: COUNT(1)
      comment: "Total number of awards in the portfolio. Baseline measure for portfolio size tracking on executive dashboards."
    - name: "total_obligated_amount_usd"
      expr: SUM(CAST(total_obligated_amount AS DOUBLE))
      comment: "Sum of total obligated award amounts in award currency. Primary financial KPI for portfolio value; used in board reporting and donor stewardship."
    - name: "total_obligated_amount_functional"
      expr: SUM(CAST(total_obligated_amount_functional AS DOUBLE))
      comment: "Sum of total obligated amounts converted to functional currency. Used for IPSAS/SAP VISION ledger reconciliation and multi-currency portfolio roll-up."
    - name: "total_authorized_amount"
      expr: SUM(CAST(authorized_amount AS DOUBLE))
      comment: "Sum of authorized award amounts. Compared against obligated amounts to identify authorization gaps or over-obligation risk."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share committed across the portfolio. Tracks matching obligation exposure for compliance and financial planning."
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost-share percentage across awards. Benchmarks matching burden relative to portfolio norms and donor requirements."
    - name: "total_indirect_cost_ceiling"
      expr: SUM(CAST(indirect_cost_ceiling AS DOUBLE))
      comment: "Sum of donor-imposed indirect cost ceilings. Measures the cap on overhead recovery across the portfolio; critical for NICRA/ICR rate negotiation."
    - name: "avg_nicra_icr_rate"
      expr: AVG(CAST(nicra_icr_rate AS DOUBLE))
      comment: "Average NICRA/ICR indirect cost rate applied across awards. Used by finance leadership to assess overhead recovery efficiency."
    - name: "total_endowment_draw_amount"
      expr: SUM(CAST(endowment_draw_amount AS DOUBLE))
      comment: "Total endowment draw amounts across endowment-funded awards. Tracks spending policy compliance and endowment corpus sustainability."
    - name: "avg_endowment_spending_policy_rate"
      expr: AVG(CAST(endowment_spending_policy_rate AS DOUBLE))
      comment: "Average endowment spending policy rate across endowment-funded awards. Monitors adherence to board-approved spending policy (typically 4-5%)."
    - name: "amendment_count_total"
      expr: COUNT(DISTINCT award_id)
      comment: "Count of distinct awards. Used as denominator for amendment rate calculations and portfolio breadth analysis."
    - name: "awards_requiring_audit"
      expr: COUNT(CASE WHEN audit_required = TRUE THEN award_id END)
      comment: "Number of awards requiring independent audit. Drives audit planning workload and compliance risk exposure assessment."
    - name: "awards_with_cost_share"
      expr: COUNT(CASE WHEN cost_share_required = TRUE THEN award_id END)
      comment: "Number of awards with mandatory cost-share requirements. Quantifies matching obligation exposure across the portfolio."
    - name: "outbound_grantmaking_awards"
      expr: COUNT(CASE WHEN is_grant_made_out = TRUE THEN award_id END)
      comment: "Number of outbound grantmaking awards. Tracks foundation grantmaking-out activity separately from inbound grant receipts."
    - name: "endowment_funded_awards"
      expr: COUNT(CASE WHEN is_endowment_funded = TRUE THEN award_id END)
      comment: "Number of awards funded from endowment draws. Monitors endowment utilization and spending policy compliance."
    - name: "avg_exchange_rate_to_functional"
      expr: AVG(CAST(exchange_rate_to_functional AS DOUBLE))
      comment: "Average exchange rate applied to convert award currency to functional currency. Used to assess FX exposure and translation risk across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Business development pipeline KPI layer over the proposal table. Tracks win rates, pipeline value, proposal conversion, and cost-share commitments at the proposal stage. Used by business development directors and senior leadership to steer capture strategy, resource allocation, and go/no-go decisions. Supports both inbound grant-seeking and outbound grantmaking proposal flows."
  source: "`vibe_ngo_v1`.`grant`.`proposal`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current stage of the proposal (e.g. Draft, Submitted, Won, Lost, Withdrawn). Primary pipeline stage dimension."
    - name: "proposal_type"
      expr: proposal_type
      comment: "Type of proposal (e.g. Concept Note, Full Application, Unsolicited). Drives pipeline stage analysis."
    - name: "win_loss_outcome"
      expr: win_loss_outcome
      comment: "Final outcome of the proposal (Won, Lost, No Decision). Core dimension for win-rate analysis."
    - name: "go_no_go_decision"
      expr: go_no_go_decision
      comment: "Internal go/no-go decision (Go, No-Go, Conditional). Tracks capture discipline and pipeline qualification rigor."
    - name: "direction"
      expr: direction
      comment: "Inbound (grant-seeking) vs. outbound (grantmaking) proposal direction. Separates fundraising from grantmaking pipelines."
    - name: "grantmaking_direction"
      expr: grantmaking_direction
      comment: "Specific grantmaking direction for outbound proposals. Used by foundation program officers."
    - name: "lead_technical_sector"
      expr: lead_technical_sector
      comment: "Primary technical sector of the proposal (e.g. Health, WASH, Education). Enables sector-level pipeline analysis."
    - name: "grantmaking_program_area"
      expr: grantmaking_program_area
      comment: "Program area for outbound grantmaking proposals. Used by foundation program officers to track pipeline by focus area."
    - name: "geographic_focus"
      expr: geographic_focus
      comment: "Geographic focus of the proposal. Used for country/region-level pipeline analysis."
    - name: "partnership_model"
      expr: partnership_model
      comment: "Partnership structure (e.g. Lead, Consortium Member, Sub-recipient). Informs partnership strategy decisions."
    - name: "requested_currency"
      expr: requested_currency
      comment: "Currency of the requested amount. Used for multi-currency pipeline valuation."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year of proposal submission. Used for year-over-year pipeline trend analysis."
    - name: "proposed_start_year"
      expr: YEAR(proposed_start_date)
      comment: "Proposed program start year. Used for forward-looking pipeline and workload planning."
    - name: "board_approval_status"
      expr: board_approval_status
      comment: "Board approval status for proposals requiring board authorization. Tracks governance compliance in the pipeline."
    - name: "is_outbound_grant_application"
      expr: is_outbound_grant_application
      comment: "Flags outbound grant applications (grantmaking-out). Separates foundation grantmaking pipeline from fundraising pipeline."
  measures:
    - name: "total_proposals"
      expr: COUNT(1)
      comment: "Total number of proposals in the pipeline. Baseline measure for business development activity volume."
    - name: "total_requested_amount"
      expr: SUM(CAST(requested_amount AS DOUBLE))
      comment: "Total value of proposals in transaction currency. Primary pipeline value KPI for business development dashboards."
    - name: "total_requested_amount_usd"
      expr: SUM(CAST(requested_amount_usd AS DOUBLE))
      comment: "Total pipeline value in USD. Enables cross-currency portfolio comparison and executive pipeline reporting."
    - name: "total_cost_share_proposed"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share amounts proposed across the pipeline. Tracks matching commitment exposure before award."
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost-share percentage across proposals. Benchmarks matching burden in the pipeline against portfolio norms."
    - name: "avg_indirect_cost_rate_proposed"
      expr: AVG(CAST(indirect_cost_rate_proposed AS DOUBLE))
      comment: "Average indirect cost rate proposed across submissions. Monitors overhead recovery strategy and NICRA negotiation positioning."
    - name: "won_proposals"
      expr: COUNT(CASE WHEN win_loss_outcome = 'Won' THEN proposal_id END)
      comment: "Number of proposals with a Won outcome. Numerator for win-rate calculation; core business development KPI."
    - name: "lost_proposals"
      expr: COUNT(CASE WHEN win_loss_outcome = 'Lost' THEN proposal_id END)
      comment: "Number of proposals with a Lost outcome. Used to analyze loss patterns and improve capture strategy."
    - name: "submitted_proposals"
      expr: COUNT(CASE WHEN proposal_status = 'Submitted' THEN proposal_id END)
      comment: "Number of proposals submitted to donors. Tracks business development throughput and submission velocity."
    - name: "avg_requested_amount_usd"
      expr: AVG(CAST(requested_amount_usd AS DOUBLE))
      comment: "Average proposal size in USD. Used to assess deal size trends and resource allocation per proposal."
    - name: "total_cost_proposal_summary"
      expr: SUM(CAST(cost_proposal_summary AS DOUBLE))
      comment: "Sum of cost proposal summary amounts. Provides a budget-level view of the pipeline for financial planning."
    - name: "go_decisions"
      expr: COUNT(CASE WHEN go_no_go_decision = 'Go' THEN proposal_id END)
      comment: "Number of proposals that received a Go decision. Measures capture discipline and pipeline qualification rate."
    - name: "board_review_required_count"
      expr: COUNT(CASE WHEN board_review_required = TRUE THEN proposal_id END)
      comment: "Number of proposals requiring board review. Tracks governance workload and board authorization pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_award_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial budget KPI layer over the award budget table. Tracks approved budget totals, cost category breakdowns, indirect cost recovery, and cost-share obligations at the award budget level. Used by finance directors and grants managers to monitor budget utilization, NICRA compliance, and budget amendment activity. Supports IPSAS and US GAAP ASC 958 dual-framework reporting."
  source: "`vibe_ngo_v1`.`grant`.`award_budget`"
  dimensions:
    - name: "budget_version_number"
      expr: budget_version_number
      comment: "Version identifier for the award budget. Enables tracking of budget revisions and amendment history."
    - name: "award_currency"
      expr: award_currency
      comment: "Currency of the award budget. Used for multi-currency budget analysis."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Donor restriction type applied to this budget. Required for ASC 958 / IPSAS net-asset classification."
    - name: "net_asset_classification"
      expr: net_asset_classification
      comment: "Net asset class for this budget version. Used for financial statement presentation under ASC 958 / IPSAS."
    - name: "cost_share_required"
      expr: cost_share_required
      comment: "Boolean flag indicating whether cost-share is required for this budget. Filters budgets with matching obligations."
    - name: "is_amendment"
      expr: is_amendment
      comment: "Flags whether this budget is an amendment to a prior version. Used to track budget modification frequency."
    - name: "budget_period_start_year"
      expr: YEAR(budget_period_start_date)
      comment: "Budget period start year. Used for annual budget planning and fiscal year analysis."
    - name: "budget_submission_year"
      expr: YEAR(budget_submission_date)
      comment: "Year the budget was submitted to the donor. Used for submission timeliness analysis."
    - name: "donor_approval_year"
      expr: YEAR(donor_approval_date)
      comment: "Year of donor budget approval. Used to track approval cycle times."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_budget AS DOUBLE))
      comment: "Sum of total approved award budgets. Primary financial KPI for budget portfolio size; used in board and donor reporting."
    - name: "total_direct_costs"
      expr: SUM(CAST(total_direct_costs AS DOUBLE))
      comment: "Sum of total direct costs across award budgets. Tracks direct program expenditure capacity."
    - name: "total_indirect_costs"
      expr: SUM(CAST(total_indirect_costs AS DOUBLE))
      comment: "Sum of total indirect costs (overhead) across award budgets. Monitors overhead recovery against NICRA/ICR rates."
    - name: "total_personnel_costs"
      expr: SUM(CAST(personnel_costs AS DOUBLE))
      comment: "Sum of personnel costs across award budgets. Largest cost category; used for workforce planning and budget allocation decisions."
    - name: "total_travel_costs"
      expr: SUM(CAST(travel_costs AS DOUBLE))
      comment: "Sum of travel costs across award budgets. Tracks field travel expenditure and donor allowability compliance."
    - name: "total_equipment_costs"
      expr: SUM(CAST(equipment_costs AS DOUBLE))
      comment: "Sum of equipment costs across award budgets. Monitors capital expenditure and donor prior-approval thresholds."
    - name: "total_contractual_costs"
      expr: SUM(CAST(contractual_costs AS DOUBLE))
      comment: "Sum of contractual/sub-award costs across award budgets. Tracks sub-award financial exposure."
    - name: "total_supplies_costs"
      expr: SUM(CAST(supplies_costs AS DOUBLE))
      comment: "Sum of supplies costs across award budgets. Monitors commodity and supply expenditure against budget."
    - name: "total_other_direct_costs"
      expr: SUM(CAST(other_direct_costs AS DOUBLE))
      comment: "Sum of other direct costs across award budgets. Tracks miscellaneous direct expenditure categories."
    - name: "total_fringe_benefits_costs"
      expr: SUM(CAST(fringe_benefits_costs AS DOUBLE))
      comment: "Sum of fringe benefits costs across award budgets. Monitors benefits burden rate and workforce cost compliance."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Sum of cost-share amounts across award budgets. Tracks total matching obligation committed in approved budgets."
    - name: "avg_nicra_rate_applied"
      expr: AVG(CAST(nicra_rate_applied AS DOUBLE))
      comment: "Average NICRA indirect cost rate applied across award budgets. Benchmarks overhead recovery rate against negotiated agreement."
    - name: "total_indirect_cost_base"
      expr: SUM(CAST(indirect_cost_base AS DOUBLE))
      comment: "Sum of indirect cost bases across award budgets. Used to calculate effective overhead recovery and NICRA compliance."
    - name: "total_endowment_draw_amount"
      expr: SUM(CAST(endowment_draw_amount AS DOUBLE))
      comment: "Sum of endowment draw amounts budgeted across award budgets. Monitors endowment spending policy compliance."
    - name: "amendment_budgets"
      expr: COUNT(CASE WHEN is_amendment = TRUE THEN award_budget_id END)
      comment: "Number of award budgets that are amendments. Tracks budget modification frequency as a proxy for award complexity and donor relationship management burden."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_award_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level budget KPI layer over the award budget line table. Tracks approved vs. revised amounts, cumulative expenditure, variance, and indirect cost recovery at the budget line level. Used by finance and grants teams to monitor burn rates, variance, and allowability compliance. Supports SAP VISION cost center integration and NICRA rate application tracking."
  source: "`vibe_ngo_v1`.`grant`.`award_budget_line`"
  dimensions:
    - name: "donor_reporting_category"
      expr: donor_reporting_category
      comment: "Donor-defined reporting category for this budget line. Used to aggregate expenditure for donor financial reports."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Donor restriction type for this budget line. Required for ASC 958 / IPSAS net-asset release analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the budget line. Used for period-level burn rate and variance analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget line. Used for annual budget vs. actuals analysis."
    - name: "line_item_code"
      expr: line_item_code
      comment: "Budget line item code. Used to group expenditure by standardized cost category codes."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the budget line quantity. Used for unit cost analysis and procurement planning."
    - name: "allocability_flag"
      expr: allocability_flag
      comment: "Boolean flag indicating whether the cost is allocable to the award. Tracks compliance with donor allocability standards."
    - name: "allowability_flag"
      expr: allowability_flag
      comment: "Boolean flag indicating whether the cost is allowable under the award. Tracks compliance with donor allowability standards (2 CFR 200, IPSAS)."
    - name: "cost_share_required_flag"
      expr: cost_share_required_flag
      comment: "Flags budget lines with cost-share requirements. Used to isolate matching obligation lines."
    - name: "reasonableness_flag"
      expr: reasonableness_flag
      comment: "Boolean flag indicating whether the cost has been assessed as reasonable. Tracks compliance with donor reasonableness standards."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the budget line was approved. Used for approval cycle time analysis."
    - name: "revision_year"
      expr: YEAR(revision_date)
      comment: "Year of the most recent budget line revision. Used to track amendment frequency."
  measures:
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Sum of approved budget line amounts in award currency. Primary budget baseline measure for variance analysis."
    - name: "total_approved_amount_usd"
      expr: SUM(CAST(approved_amount_usd AS DOUBLE))
      comment: "Sum of approved budget line amounts in USD. Enables cross-currency budget comparison and executive reporting."
    - name: "total_revised_amount"
      expr: SUM(CAST(revised_amount AS DOUBLE))
      comment: "Sum of revised budget line amounts. Tracks budget modifications and amendment impact on line-level allocations."
    - name: "total_revised_amount_usd"
      expr: SUM(CAST(revised_amount_usd AS DOUBLE))
      comment: "Sum of revised budget line amounts in USD. Used for cross-currency revised budget analysis."
    - name: "total_cumulative_expenditure"
      expr: SUM(CAST(cumulative_expenditure AS DOUBLE))
      comment: "Sum of cumulative expenditure against budget lines. Core burn-rate KPI for grants financial management."
    - name: "total_cumulative_expenditure_usd"
      expr: SUM(CAST(cumulative_expenditure_usd AS DOUBLE))
      comment: "Sum of cumulative expenditure in USD. Used for cross-currency burn-rate analysis and donor financial reporting."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Sum of budget variance amounts (approved minus expended). Identifies under- or over-spending risk across the portfolio."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage across budget lines. Benchmarks budget execution efficiency and flags lines at risk of lapsing."
    - name: "total_indirect_cost_amount"
      expr: SUM(CAST(indirect_cost_amount AS DOUBLE))
      comment: "Sum of indirect cost amounts across budget lines. Tracks overhead recovery at line level against NICRA/ICR rates."
    - name: "avg_nicra_rate_applied"
      expr: AVG(CAST(nicra_rate_applied AS DOUBLE))
      comment: "Average NICRA rate applied across budget lines. Monitors consistency of indirect cost rate application."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Sum of cost-share amounts at budget line level. Tracks matching obligation fulfillment at granular cost category level."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Sum of quantities across budget lines. Used for unit cost analysis and procurement volume planning."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across budget lines. Benchmarks cost efficiency and identifies outliers for reasonableness review."
    - name: "non_allowable_lines"
      expr: COUNT(CASE WHEN allowability_flag = FALSE THEN award_budget_line_id END)
      comment: "Number of budget lines flagged as non-allowable. Critical compliance KPI; non-allowable costs must be removed or justified before donor reporting."
    - name: "non_allocable_lines"
      expr: COUNT(CASE WHEN allocability_flag = FALSE THEN award_budget_line_id END)
      comment: "Number of budget lines flagged as non-allocable. Tracks cost allocation compliance risk across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_sub_award_disbursement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash flow and disbursement KPI layer over the sub-award disbursement table. Tracks disbursement volumes, liquidation status, advance balances, and withholding amounts. Used by grants finance teams and sub-award managers to monitor cash flow, advance liquidation compliance, and FFATA/FSRS reporting obligations. Supports SAP VISION payment integration and eTools sub-award tracking."
  source: "`vibe_ngo_v1`.`grant`.`sub_award_disbursement`"
  dimensions:
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the disbursement. Used for period-level cash flow analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the disbursement. Used for annual disbursement trend analysis."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Donor restriction type for this disbursement. Required for ASC 958 / IPSAS net-asset release tracking."
    - name: "donor_reporting_category"
      expr: donor_reporting_category
      comment: "Donor-defined reporting category for the disbursement. Used to aggregate disbursements for donor financial reports."
    - name: "liquidation_status"
      expr: liquidation_status
      comment: "Status of advance liquidation (e.g. Pending, Partial, Liquidated). Core compliance dimension for advance management."
    - name: "is_emergency_disbursement"
      expr: is_emergency_disbursement
      comment: "Flags emergency disbursements. Used to track expedited payments and associated compliance risk."
    - name: "is_grantmaking_disbursement"
      expr: is_grantmaking_disbursement
      comment: "Flags outbound grantmaking disbursements. Separates grantmaking-out cash flows from sub-award payments."
    - name: "tranche_number"
      expr: tranche_number
      comment: "Disbursement tranche identifier. Used to track multi-tranche payment schedules."
    - name: "disbursement_year"
      expr: YEAR(disbursement_date)
      comment: "Year of disbursement. Used for annual cash flow trend analysis."
    - name: "liquidation_deadline_year"
      expr: YEAR(liquidation_deadline)
      comment: "Year of advance liquidation deadline. Used to identify advances at risk of non-compliance."
  measures:
    - name: "total_disbursement_amount"
      expr: SUM(CAST(disbursement_amount AS DOUBLE))
      comment: "Sum of disbursement amounts in transaction currency. Primary cash flow KPI for sub-award financial management."
    - name: "total_disbursement_amount_usd"
      expr: SUM(CAST(disbursement_amount_usd AS DOUBLE))
      comment: "Sum of disbursement amounts in USD. Enables cross-currency cash flow analysis and executive reporting."
    - name: "total_net_disbursement_amount"
      expr: SUM(CAST(net_disbursement_amount AS DOUBLE))
      comment: "Sum of net disbursement amounts (after withholding). Tracks actual cash transferred to sub-awardees."
    - name: "total_liquidated_amount"
      expr: SUM(CAST(liquidated_amount AS DOUBLE))
      comment: "Sum of liquidated advance amounts. Tracks advance recovery and compliance with liquidation schedules."
    - name: "total_advance_balance_outstanding"
      expr: SUM(CAST(advance_balance_outstanding AS DOUBLE))
      comment: "Sum of outstanding advance balances. Critical compliance KPI; high outstanding balances indicate liquidation risk and potential audit findings."
    - name: "total_withholding_amount"
      expr: SUM(CAST(withholding_amount AS DOUBLE))
      comment: "Sum of withholding amounts across disbursements. Tracks performance-based withholding and compliance holds."
    - name: "total_indirect_cost_amount"
      expr: SUM(CAST(indirect_cost_amount AS DOUBLE))
      comment: "Sum of indirect cost amounts included in disbursements. Monitors overhead recovery in sub-award payments."
    - name: "total_net_asset_release_amount"
      expr: SUM(CAST(net_asset_release_amount AS DOUBLE))
      comment: "Sum of net asset release amounts triggered by disbursements. Tracks restriction release events for ASC 958 / IPSAS financial reporting."
    - name: "avg_nicra_rate_applied"
      expr: AVG(CAST(nicra_rate_applied AS DOUBLE))
      comment: "Average NICRA rate applied across disbursements. Monitors consistency of indirect cost rate application in sub-award payments."
    - name: "total_disbursements"
      expr: COUNT(1)
      comment: "Total number of disbursement transactions. Baseline measure for payment volume and processing workload."
    - name: "emergency_disbursements"
      expr: COUNT(CASE WHEN is_emergency_disbursement = TRUE THEN 1 END)
      comment: "Number of emergency disbursements. Tracks expedited payment frequency as a proxy for operational stress and compliance risk."
    - name: "avg_disbursement_amount_usd"
      expr: AVG(CAST(disbursement_amount_usd AS DOUBLE))
      comment: "Average disbursement amount in USD. Benchmarks payment size and identifies outliers for review."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_subaward`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sub-award portfolio KPI layer over the subaward table. Tracks sub-award financial exposure, disbursement progress, risk ratings, and compliance obligations (FFATA, expenditure responsibility, single audit). Used by sub-award managers and compliance officers to monitor partner financial performance and regulatory compliance. Supports SAP VISION and eTools sub-award management integration."
  source: "`vibe_ngo_v1`.`grant`.`award`"
  dimensions:
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Required reporting frequency for the sub-award. Used for reporting workload planning."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Donor restriction type flowing down to the sub-award. Required for ASC 958 / IPSAS net-asset release tracking."
    - name: "fund_restriction_class"
      expr: fund_restriction_class
      comment: "Broader restriction class for the sub-award. Used for balance-sheet net-asset classification."
    - name: "currency"
      expr: currency
      comment: "Transaction currency of the sub-award. Used for multi-currency portfolio analysis."
  measures:
    - name: "total_subawards"
      expr: COUNT(1)
      comment: "Total number of sub-awards in the portfolio. Baseline measure for sub-award portfolio size."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Sum of cost-share amounts across sub-awards. Tracks matching obligation exposure at sub-award level."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_donor_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor reporting compliance KPI layer over the donor report table. Tracks submission timeliness, overdue reports, budget variance, KPI achievement, and financial reporting accuracy. Used by grants compliance officers and program directors to monitor reporting obligations and donor relationship health. Supports IATI publication workflows and regulatory filing integration."
  source: "`vibe_ngo_v1`.`grant`.`donor_report`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of donor report (e.g. Financial, Narrative, Final, Interim). Primary classification for reporting workload analysis."
    - name: "report_status"
      expr: report_status
      comment: "Current status of the report (e.g. Draft, Submitted, Accepted, Rejected). Used for pipeline and compliance tracking."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Reporting cadence (Monthly, Quarterly, Annual). Used for workload planning and compliance scheduling."
    - name: "financial_currency"
      expr: financial_currency
      comment: "Currency of the financial amounts reported. Used for multi-currency reporting analysis."
    - name: "submission_method"
      expr: submission_method
      comment: "Method of report submission (e.g. Portal, Email, Post). Used for process efficiency analysis."
    - name: "is_overdue"
      expr: is_overdue
      comment: "Boolean flag indicating whether the report is overdue. Primary compliance risk filter."
    - name: "is_final_version"
      expr: is_final_version
      comment: "Flags final report versions. Used to distinguish final from interim submissions."
    - name: "board_reported_flag"
      expr: board_reported_flag
      comment: "Flags reports that have been presented to the board. Tracks governance reporting compliance."
    - name: "compliance_certification_flag"
      expr: compliance_certification_flag
      comment: "Flags reports with compliance certifications. Tracks regulatory certification completion."
    - name: "reporting_period_start_year"
      expr: YEAR(reporting_period_start_date)
      comment: "Reporting period start year. Used for annual reporting trend analysis."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year of report submission. Used for year-over-year submission volume analysis."
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total number of donor reports. Baseline measure for reporting workload volume."
    - name: "overdue_reports"
      expr: COUNT(CASE WHEN is_overdue = TRUE THEN donor_report_id END)
      comment: "Number of overdue donor reports. Critical compliance KPI; overdue reports risk donor relationship damage and award suspension."
    - name: "total_financial_amount_reported"
      expr: SUM(CAST(financial_amount_reported AS DOUBLE))
      comment: "Sum of financial amounts reported to donors. Tracks total expenditure reported across the portfolio."
    - name: "total_financial_amount_reported_usd"
      expr: SUM(CAST(financial_amount_reported_usd AS DOUBLE))
      comment: "Sum of financial amounts reported in USD. Enables cross-currency reporting analysis and executive dashboard."
    - name: "total_cumulative_expenditure_to_date"
      expr: SUM(CAST(cumulative_expenditure_to_date AS DOUBLE))
      comment: "Sum of cumulative expenditure reported to date across all reports. Tracks total program spend reported to donors."
    - name: "total_budget_variance_amount"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Sum of budget variance amounts across reports. Identifies systematic over- or under-spending patterns requiring donor notification."
    - name: "avg_budget_variance_percentage"
      expr: AVG(CAST(budget_variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage across reports. Benchmarks budget execution accuracy and flags reports requiring donor explanation."
    - name: "total_net_asset_release_amount"
      expr: SUM(CAST(net_asset_release_amount AS DOUBLE))
      comment: "Sum of net asset release amounts reported. Tracks restriction release events for ASC 958 / IPSAS financial statement reporting."
    - name: "total_grantmaking_disbursed_amount"
      expr: SUM(CAST(grantmaking_disbursed_amount AS DOUBLE))
      comment: "Sum of grantmaking disbursed amounts reported. Tracks outbound grantmaking cash flows reported to donors and boards."
    - name: "total_endowment_draw_reported"
      expr: SUM(CAST(endowment_draw_reported_amount AS DOUBLE))
      comment: "Sum of endowment draw amounts reported. Monitors endowment spending policy compliance as reported to donors and boards."
    - name: "reports_with_audit_findings"
      expr: COUNT(CASE WHEN compliance_certification_flag = FALSE THEN donor_report_id END)
      comment: "Number of reports without compliance certification. Proxy for reports with unresolved compliance issues requiring escalation."
    - name: "avg_key_performance_indicators_total"
      expr: AVG(CAST(key_performance_indicators_total AS DOUBLE))
      comment: "Average number of KPIs tracked per donor report. Benchmarks reporting complexity and MEL integration depth."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Award amendment KPI layer over the grant amendment table. Tracks amendment frequency, funding changes, no-cost extensions, and scope modifications. Used by grants managers and program directors to monitor award stability, donor relationship complexity, and compliance with prior approval requirements. Supports SAP VISION change management and eTools programme amendment workflows."
  source: "`vibe_ngo_v1`.`grant`.`grant_amendment`"
  dimensions:
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (e.g. No-Cost Extension, Budget Modification, Scope Change). Primary classification for amendment analysis."
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the amendment (e.g. Pending, Approved, Rejected). Used for pipeline and compliance tracking."
    - name: "is_no_cost_extension"
      expr: is_no_cost_extension
      comment: "Flags no-cost extension amendments. Tracks program timeline extensions without additional funding."
    - name: "donor_prior_approval_required"
      expr: donor_prior_approval_required
      comment: "Flags amendments requiring donor prior approval. Tracks compliance with prior approval requirements."
    - name: "board_approval_required"
      expr: board_approval_required
      comment: "Flags amendments requiring board approval. Tracks governance compliance for significant award changes."
    - name: "endowment_reclassification_flag"
      expr: endowment_reclassification_flag
      comment: "Flags amendments involving endowment reclassification. Tracks net-asset reclassification events for ASC 958 / IPSAS reporting."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the amendment became effective. Used for annual amendment trend analysis."
    - name: "request_year"
      expr: YEAR(request_date)
      comment: "Year the amendment was requested. Used for amendment processing cycle time analysis."
  measures:
    - name: "total_amendments"
      expr: COUNT(1)
      comment: "Total number of grant amendments. Baseline measure for amendment volume and award complexity."
    - name: "total_funding_change"
      expr: SUM(CAST(funding_change AS DOUBLE))
      comment: "Sum of funding changes across amendments. Tracks net increase or decrease in award funding due to amendments."
    - name: "total_original_obligation"
      expr: SUM(CAST(original_total_obligation AS DOUBLE))
      comment: "Sum of original total obligations before amendment. Used as baseline for amendment impact analysis."
    - name: "total_revised_obligation"
      expr: SUM(CAST(revised_total_obligation AS DOUBLE))
      comment: "Sum of revised total obligations after amendment. Tracks portfolio value changes due to amendments."
    - name: "no_cost_extensions"
      expr: COUNT(CASE WHEN is_no_cost_extension = TRUE THEN grant_amendment_id END)
      comment: "Number of no-cost extension amendments. Tracks program timeline extensions as a proxy for implementation challenges."
    - name: "amendments_requiring_donor_approval"
      expr: COUNT(CASE WHEN donor_prior_approval_required = TRUE THEN grant_amendment_id END)
      comment: "Number of amendments requiring donor prior approval. Tracks compliance workload and donor relationship management burden."
    - name: "amendments_requiring_board_approval"
      expr: COUNT(CASE WHEN board_approval_required = TRUE THEN grant_amendment_id END)
      comment: "Number of amendments requiring board approval. Tracks governance workload for significant award changes."
    - name: "avg_period_extension_days"
      expr: AVG(CAST(period_extension_days AS DOUBLE))
      comment: "Average number of days added by no-cost extensions. Benchmarks implementation delay patterns across the portfolio."
    - name: "endowment_reclassification_amendments"
      expr: COUNT(CASE WHEN endowment_reclassification_flag = TRUE THEN grant_amendment_id END)
      comment: "Number of amendments involving endowment reclassification. Tracks net-asset reclassification events for financial reporting."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_closeout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Award closeout KPI layer over the grant closeout table. Tracks closeout completion rates, unliquidated obligations, unobligated balances, final audit status, and compliance certification. Used by grants compliance officers and finance directors to monitor closeout pipeline, return of funds, and regulatory compliance. Supports SAP VISION period-end close and 2 CFR 200 / IPSAS closeout requirements."
  source: "`vibe_ngo_v1`.`grant`.`grant_closeout`"
  dimensions:
    - name: "closeout_status"
      expr: closeout_status
      comment: "Current status of the closeout process (e.g. Initiated, In Progress, Complete). Primary filter for closeout pipeline dashboards."
    - name: "closeout_type"
      expr: closeout_type
      comment: "Type of closeout (e.g. Planned, Early Termination, Mutual Agreement). Drives compliance and financial treatment."
    - name: "final_audit_status"
      expr: final_audit_status
      comment: "Status of the final audit (e.g. Not Required, Pending, Complete, Finding). Tracks audit compliance at closeout."
    - name: "equipment_disposition_status"
      expr: equipment_disposition_status
      comment: "Status of equipment disposition at closeout. Tracks compliance with donor equipment disposition requirements."
    - name: "outstanding_issues_flag"
      expr: outstanding_issues_flag
      comment: "Flags closeouts with outstanding issues. Used to prioritize resolution of unresolved compliance matters."
    - name: "intellectual_property_disposition"
      expr: intellectual_property_disposition
      comment: "Disposition of intellectual property at closeout. Tracks IP compliance with donor requirements."
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year of closeout completion. Used for annual closeout trend analysis."
    - name: "initiation_year"
      expr: YEAR(initiation_date)
      comment: "Year closeout was initiated. Used for closeout cycle time analysis."
  measures:
    - name: "total_closeouts"
      expr: COUNT(1)
      comment: "Total number of grant closeouts. Baseline measure for closeout pipeline volume."
    - name: "total_unliquidated_obligations"
      expr: SUM(CAST(unliquidated_obligations_amount AS DOUBLE))
      comment: "Sum of unliquidated obligation amounts at closeout. Critical financial KPI; unliquidated obligations must be resolved or returned to donors."
    - name: "total_unobligated_balance"
      expr: SUM(CAST(unobligated_balance_amount AS DOUBLE))
      comment: "Sum of unobligated balance amounts at closeout. Tracks funds to be returned to donors; impacts future award negotiations."
    - name: "closeouts_with_outstanding_issues"
      expr: COUNT(CASE WHEN outstanding_issues_flag = TRUE THEN grant_closeout_id END)
      comment: "Number of closeouts with outstanding issues. Tracks unresolved compliance matters requiring escalation."
    - name: "closeouts_with_audit_findings"
      expr: COUNT(CASE WHEN final_audit_status = 'Finding' THEN grant_closeout_id END)
      comment: "Number of closeouts with audit findings. Tracks compliance risk and corrective action requirements."
    - name: "completed_closeouts"
      expr: COUNT(CASE WHEN closeout_status = 'Complete' THEN grant_closeout_id END)
      comment: "Number of fully completed closeouts. Tracks closeout pipeline throughput and compliance completion rate."
    - name: "avg_unliquidated_obligations"
      expr: AVG(CAST(unliquidated_obligations_amount AS DOUBLE))
      comment: "Average unliquidated obligation amount per closeout. Benchmarks financial resolution efficiency at closeout."
    - name: "avg_unobligated_balance"
      expr: AVG(CAST(unobligated_balance_amount AS DOUBLE))
      comment: "Average unobligated balance per closeout. Benchmarks budget execution efficiency and identifies systematic under-spending patterns."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_cost_share_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost-share compliance KPI layer over the cost share commitment table. Tracks committed vs. verified cost-share amounts, variance, volunteer hour valuations, and in-kind contributions. Used by grants compliance officers and finance directors to monitor matching obligation fulfillment and donor compliance. Supports ASC 958 / IPSAS cost-share accounting and 2 CFR 200 matching requirements."
  source: "`vibe_ngo_v1`.`grant`.`cost_share_commitment`"
  dimensions:
    - name: "commitment_status"
      expr: commitment_status
      comment: "Status of the cost-share commitment (e.g. Pending, Verified, Rejected). Primary filter for compliance tracking."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the cost-share commitment. Tracks whether matching obligations are being met."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Flags mandatory cost-share commitments. Separates required matching from voluntary contributions."
    - name: "is_restricted_fund"
      expr: is_restricted_fund
      comment: "Flags cost-share funded from restricted sources. Tracks restriction compliance in matching contributions."
    - name: "is_endowment_match"
      expr: is_endowment_match
      comment: "Flags cost-share funded from endowment draws. Tracks endowment utilization for matching purposes."
    - name: "membership_contribution_flag"
      expr: membership_contribution_flag
      comment: "Flags cost-share contributions from membership dues. Tracks membership revenue applied as matching."
    - name: "in_kind_valuation_method"
      expr: in_kind_valuation_method
      comment: "Method used to value in-kind contributions. Tracks valuation methodology compliance with donor requirements."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify cost-share contributions. Tracks audit trail quality for compliance reviews."
    - name: "net_asset_classification"
      expr: net_asset_classification
      comment: "Net asset class of the cost-share contribution. Required for ASC 958 / IPSAS financial statement presentation."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the cost-share commitment. Used for annual matching obligation analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the cost-share commitment. Used for period-level matching compliance tracking."
    - name: "commitment_year"
      expr: YEAR(commitment_date)
      comment: "Year the cost-share was committed. Used for annual commitment trend analysis."
  measures:
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Sum of committed cost-share amounts. Primary financial KPI for matching obligation exposure."
    - name: "total_required_cost_share_amount"
      expr: SUM(CAST(required_cost_share_amount AS DOUBLE))
      comment: "Sum of required cost-share amounts per donor agreement. Baseline for compliance gap analysis."
    - name: "total_verified_amount"
      expr: SUM(CAST(verified_amount AS DOUBLE))
      comment: "Sum of verified cost-share amounts. Tracks actual matching fulfillment against commitments."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Sum of cost-share variance amounts (required minus verified). Identifies matching shortfalls requiring corrective action."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average cost-share variance percentage. Benchmarks matching compliance rate across the portfolio."
    - name: "total_volunteer_hours"
      expr: SUM(CAST(volunteer_hours AS DOUBLE))
      comment: "Sum of volunteer hours contributed as cost-share. Tracks in-kind volunteer contribution volume."
    - name: "total_volunteer_hour_value"
      expr: SUM(CAST(volunteer_hours AS DOUBLE) * CAST(volunteer_hourly_rate AS DOUBLE))
      comment: "Total monetary value of volunteer hours contributed as cost-share. Tracks in-kind volunteer contribution value for matching compliance."
    - name: "avg_required_cost_share_percentage"
      expr: AVG(CAST(required_cost_share_percentage AS DOUBLE))
      comment: "Average required cost-share percentage across commitments. Benchmarks matching burden relative to portfolio norms."
    - name: "non_compliant_commitments"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN cost_share_commitment_id END)
      comment: "Number of non-compliant cost-share commitments. Critical compliance KPI; non-compliance risks award suspension and audit findings."
    - name: "mandatory_commitments"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN cost_share_commitment_id END)
      comment: "Number of mandatory cost-share commitments. Tracks required matching obligation exposure."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_donor_condition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor condition compliance KPI layer over the donor condition table. Tracks condition fulfillment, overdue conditions, financial thresholds, and escalation risk. Used by grants compliance officers and program directors to monitor special award conditions and prior approval requirements. Supports compliance risk management and donor relationship health monitoring."
  source: "`vibe_ngo_v1`.`grant`.`donor_condition`"
  dimensions:
    - name: "condition_type"
      expr: condition_type
      comment: "Type of donor condition (e.g. Financial, Programmatic, Governance, Reporting). Primary classification for compliance analysis."
    - name: "condition_category"
      expr: condition_category
      comment: "Category of the donor condition. Used for grouping conditions by compliance domain."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the condition (e.g. Compliant, Non-Compliant, Pending). Primary filter for compliance risk dashboards."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the condition (e.g. Critical, High, Medium, Low). Used to prioritize compliance workload."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the condition. Drives escalation and monitoring decisions."
    - name: "monitoring_frequency"
      expr: monitoring_frequency
      comment: "Required monitoring frequency for the condition. Used for compliance workload planning."
    - name: "is_special_award_condition"
      expr: is_special_award_condition
      comment: "Flags special award conditions. Tracks high-priority compliance obligations."
    - name: "is_board_governance_condition"
      expr: is_board_governance_condition
      comment: "Flags conditions related to board governance. Tracks governance compliance obligations."
    - name: "is_membership_condition"
      expr: is_membership_condition
      comment: "Flags conditions related to membership obligations. Tracks membership compliance requirements."
    - name: "endowment_restriction_flag"
      expr: endowment_restriction_flag
      comment: "Flags conditions related to endowment restrictions. Tracks endowment compliance obligations."
    - name: "requires_board_action_flag"
      expr: requires_board_action_flag
      comment: "Flags conditions requiring board action. Tracks governance escalation requirements."
    - name: "recurrence_frequency"
      expr: recurrence_frequency
      comment: "Frequency of recurring conditions. Used for compliance scheduling and workload planning."
    - name: "due_year"
      expr: YEAR(due_date)
      comment: "Year the condition is due. Used for annual compliance planning."
  measures:
    - name: "total_conditions"
      expr: COUNT(1)
      comment: "Total number of donor conditions. Baseline measure for compliance obligation volume."
    - name: "non_compliant_conditions"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN donor_condition_id END)
      comment: "Number of non-compliant donor conditions. Critical compliance KPI; non-compliance risks award suspension and donor relationship damage."
    - name: "high_risk_conditions"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN donor_condition_id END)
      comment: "Number of high-risk donor conditions. Drives escalation and enhanced monitoring decisions."
    - name: "conditions_requiring_board_action"
      expr: COUNT(CASE WHEN requires_board_action_flag = TRUE THEN donor_condition_id END)
      comment: "Number of conditions requiring board action. Tracks governance escalation workload."
    - name: "total_financial_threshold_amount"
      expr: SUM(CAST(financial_threshold_amount AS DOUBLE))
      comment: "Sum of financial threshold amounts across conditions. Tracks total financial exposure subject to donor conditions."
    - name: "avg_financial_threshold_amount"
      expr: AVG(CAST(financial_threshold_amount AS DOUBLE))
      comment: "Average financial threshold amount per condition. Benchmarks financial condition complexity."
    - name: "special_award_conditions"
      expr: COUNT(CASE WHEN is_special_award_condition = TRUE THEN donor_condition_id END)
      comment: "Number of special award conditions. Tracks high-priority compliance obligations requiring dedicated management."
    - name: "board_governance_conditions"
      expr: COUNT(CASE WHEN is_board_governance_condition = TRUE THEN donor_condition_id END)
      comment: "Number of board governance conditions. Tracks governance compliance obligations for board reporting."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_prior_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior approval compliance KPI layer over the prior approval table. Tracks approval request volumes, approval rates, response times, emergency approvals, and retroactive requests. Used by grants compliance officers to monitor donor prior approval compliance and identify process bottlenecks. Supports 2 CFR 200 prior approval requirements and IPSAS programme change management."
  source: "`vibe_ngo_v1`.`grant`.`prior_approval`"
  dimensions:
    - name: "approval_type"
      expr: approval_type
      comment: "Type of prior approval requested (e.g. Budget Reallocation, Key Personnel Change, No-Cost Extension). Primary classification for compliance analysis."
    - name: "approval_subtype"
      expr: approval_subtype
      comment: "Sub-type of the prior approval. Provides granular classification for compliance tracking."
    - name: "request_status"
      expr: request_status
      comment: "Current status of the prior approval request (e.g. Pending, Approved, Denied, Withdrawn). Primary filter for pipeline dashboards."
    - name: "approval_decision"
      expr: approval_decision
      comment: "Final decision on the prior approval (Approved, Denied, Conditional). Used for approval rate analysis."
    - name: "is_emergency"
      expr: is_emergency
      comment: "Flags emergency prior approval requests. Tracks expedited approval frequency as a proxy for operational stress."
    - name: "is_retroactive"
      expr: is_retroactive
      comment: "Flags retroactive prior approval requests. Retroactive requests indicate compliance process failures requiring corrective action."
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Flags requests requiring follow-up. Used for compliance workload planning."
    - name: "request_year"
      expr: YEAR(request_date)
      comment: "Year the prior approval was requested. Used for annual trend analysis."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the approval became effective. Used for approval cycle time analysis."
  measures:
    - name: "total_prior_approvals"
      expr: COUNT(1)
      comment: "Total number of prior approval requests. Baseline measure for compliance workload volume."
    - name: "approved_requests"
      expr: COUNT(CASE WHEN approval_decision = 'Approved' THEN prior_approval_id END)
      comment: "Number of approved prior approval requests. Numerator for approval rate calculation."
    - name: "denied_requests"
      expr: COUNT(CASE WHEN approval_decision = 'Denied' THEN prior_approval_id END)
      comment: "Number of denied prior approval requests. Tracks donor rejection rate and identifies compliance risk patterns."
    - name: "retroactive_requests"
      expr: COUNT(CASE WHEN is_retroactive = TRUE THEN prior_approval_id END)
      comment: "Number of retroactive prior approval requests. Critical compliance KPI; retroactive requests indicate process failures and audit risk."
    - name: "emergency_requests"
      expr: COUNT(CASE WHEN is_emergency = TRUE THEN prior_approval_id END)
      comment: "Number of emergency prior approval requests. Tracks expedited approval frequency as a proxy for operational stress."
    - name: "total_requested_amount"
      expr: SUM(CAST(requested_amount AS DOUBLE))
      comment: "Sum of requested amounts across prior approval requests. Tracks total financial value subject to donor prior approval."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Sum of approved amounts across prior approval requests. Tracks total financial value approved by donors."
    - name: "avg_requested_amount"
      expr: AVG(CAST(requested_amount AS DOUBLE))
      comment: "Average requested amount per prior approval. Benchmarks request size and identifies outliers for enhanced review."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_award_site_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Geographic site allocation KPI layer over the award site allocation table. Tracks budget allocation by project site, actual spend vs. budget, variance, and beneficiary reach by site. Used by program directors and field managers to monitor geographic distribution of award resources and site-level execution performance. Supports field operations integration with eTools and DHIS2."
  source: "`vibe_ngo_v1`.`grant`.`award_site_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of the site allocation (e.g. Active, Inactive, Suspended). Primary filter for active site portfolio."
    - name: "site_status"
      expr: site_status
      comment: "Operational status of the project site. Used to filter active vs. closed sites."
    - name: "allocation_priority"
      expr: allocation_priority
      comment: "Priority level of the site allocation. Used to identify high-priority sites for resource allocation decisions."
    - name: "site_role_in_award"
      expr: site_role_in_award
      comment: "Role of the site in the award (e.g. Primary, Secondary, Sub-office). Used for site portfolio analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the site allocation. Drives enhanced monitoring and compliance oversight decisions."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Required reporting frequency for the site. Used for reporting workload planning."
    - name: "is_primary_site"
      expr: is_primary_site
      comment: "Flags primary project sites. Used to distinguish primary from secondary site allocations."
    - name: "is_conflict_affected"
      expr: is_conflict_affected
      comment: "Flags conflict-affected sites. Used for humanitarian access and security risk analysis."
    - name: "geographic_admin1_name"
      expr: geographic_admin1_name
      comment: "Administrative level 1 (e.g. Province/State) of the site. Used for regional portfolio analysis."
    - name: "geographic_admin2_name"
      expr: geographic_admin2_name
      comment: "Administrative level 2 (e.g. District) of the site. Used for district-level portfolio analysis."
    - name: "site_activation_year"
      expr: YEAR(site_activation_date)
      comment: "Year the site was activated. Used for site portfolio vintage analysis."
  measures:
    - name: "total_site_allocations"
      expr: COUNT(1)
      comment: "Total number of award site allocations. Baseline measure for geographic portfolio breadth."
    - name: "total_site_budget_allocation"
      expr: SUM(CAST(site_budget_allocation AS DOUBLE))
      comment: "Sum of budget allocations across project sites. Tracks total financial resources allocated geographically."
    - name: "total_actual_spend_to_date"
      expr: SUM(CAST(actual_spend_to_date AS DOUBLE))
      comment: "Sum of actual spend to date across project sites. Tracks geographic burn rate and execution progress."
    - name: "total_site_disbursed_amount"
      expr: SUM(CAST(site_disbursed_amount AS DOUBLE))
      comment: "Sum of disbursed amounts across project sites. Tracks cash flow execution at site level."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Sum of budget variance amounts across sites. Identifies sites with significant under- or over-spending."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage across sites. Benchmarks site-level budget execution efficiency."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average budget allocation percentage per site. Benchmarks geographic resource distribution."
    - name: "total_site_indirect_cost_amount"
      expr: SUM(CAST(site_indirect_cost_amount AS DOUBLE))
      comment: "Sum of indirect cost amounts allocated to sites. Tracks overhead recovery at geographic level."
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost-share percentage across site allocations. Benchmarks matching burden at site level."
    - name: "conflict_affected_sites"
      expr: COUNT(CASE WHEN is_conflict_affected = TRUE THEN award_site_allocation_id END)
      comment: "Number of conflict-affected site allocations. Tracks humanitarian access risk and security exposure in the portfolio."
    - name: "high_risk_sites"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN award_site_allocation_id END)
      comment: "Number of high-risk site allocations. Drives enhanced monitoring and security risk management decisions."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_funding_source`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Funding source portfolio KPI layer over the funding source table. Tracks available funding, endowment corpus values, cost-share requirements, and compliance framework diversity. Used by resource mobilization directors and finance leadership to monitor funding pipeline, endowment health, and donor compliance requirements. Supports multi-framework reporting (IPSAS, ASC 958, EU PRAG)."
  source: "`vibe_ngo_v1`.`grant`.`funding_source`"
  dimensions:
    - name: "funding_source_category"
      expr: funding_source_category
      comment: "Category of the funding source (e.g. Bilateral, Multilateral, Foundation, Corporate). Primary classification for funding mix analysis."
    - name: "funding_mechanism_type"
      expr: funding_mechanism_type
      comment: "Mechanism type of the funding source (e.g. Grant, Contract, Cooperative Agreement). Drives compliance requirements."
    - name: "funding_source_status"
      expr: funding_source_status
      comment: "Status of the funding source (e.g. Active, Inactive, Prospect). Used for active pipeline analysis."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Restriction type of the funding source. Required for ASC 958 / IPSAS net-asset classification."
    - name: "net_asset_classification"
      expr: net_asset_classification
      comment: "Net asset class of the funding source. Used for balance-sheet presentation under ASC 958 / IPSAS."
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Applicable compliance framework (e.g. 2 CFR 200, IPSAS, EU PRAG, UK DFID). Tracks regulatory diversity in the funding portfolio."
    - name: "cost_share_required"
      expr: cost_share_required
      comment: "Boolean flag indicating whether cost-share is required. Filters funding sources with matching obligations."
    - name: "endowment_fund_flag"
      expr: endowment_fund_flag
      comment: "Flags endowment funding sources. Enables endowment vs. grant funding portfolio split."
    - name: "is_endowment_source"
      expr: is_endowment_source
      comment: "Flags funding sources that are endowment-based. Used for endowment portfolio analysis."
    - name: "is_membership_dues_source"
      expr: is_membership_dues_source
      comment: "Flags membership dues funding sources. Tracks membership revenue as a funding stream."
    - name: "subaward_allowed"
      expr: subaward_allowed
      comment: "Flags funding sources that allow sub-awards. Used for partnership and sub-award planning."
    - name: "advance_payment_allowed"
      expr: advance_payment_allowed
      comment: "Flags funding sources that allow advance payments. Used for cash flow planning."
    - name: "oda_dac_classification"
      expr: oda_dac_classification
      comment: "OECD DAC ODA classification. Required for IATI publication and donor statistical reporting."
    - name: "funding_start_year"
      expr: YEAR(funding_start_date)
      comment: "Year funding becomes available. Used for pipeline timing analysis."
  measures:
    - name: "total_funding_sources"
      expr: COUNT(1)
      comment: "Total number of funding sources. Baseline measure for funding portfolio diversity."
    - name: "total_funding_available"
      expr: SUM(CAST(total_funding_available AS DOUBLE))
      comment: "Sum of total funding available across all sources. Primary pipeline value KPI for resource mobilization leadership."
    - name: "total_endowment_corpus_amount"
      expr: SUM(CAST(endowment_corpus_amount AS DOUBLE))
      comment: "Sum of endowment corpus amounts. Tracks total endowment asset base for financial sustainability analysis."
    - name: "total_endowment_market_value"
      expr: SUM(CAST(endowment_market_value AS DOUBLE))
      comment: "Sum of endowment market values. Tracks current endowment portfolio value for board reporting and spending policy compliance."
    - name: "avg_endowment_spending_policy_rate"
      expr: AVG(CAST(endowment_spending_policy_rate AS DOUBLE))
      comment: "Average endowment spending policy rate across endowment sources. Monitors adherence to board-approved spending policy."
    - name: "avg_endowment_spending_rate"
      expr: AVG(CAST(endowment_spending_rate AS DOUBLE))
      comment: "Average actual endowment spending rate. Compared against policy rate to identify over- or under-spending of endowment."
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost-share percentage across funding sources. Benchmarks matching burden in the funding portfolio."
    - name: "avg_nicra_rate"
      expr: AVG(CAST(nicra_rate AS DOUBLE))
      comment: "Average NICRA/ICR rate across funding sources. Benchmarks overhead recovery rate against negotiated agreement."
    - name: "endowment_funding_sources"
      expr: COUNT(CASE WHEN endowment_fund_flag = TRUE THEN funding_source_id END)
      comment: "Number of endowment funding sources. Tracks endowment portfolio breadth."
    - name: "membership_dues_sources"
      expr: COUNT(CASE WHEN is_membership_dues_source = TRUE THEN funding_source_id END)
      comment: "Number of membership dues funding sources. Tracks membership revenue stream diversity."
    - name: "avg_budget_revision_threshold"
      expr: AVG(CAST(budget_revision_threshold AS DOUBLE))
      comment: "Average budget revision threshold across funding sources. Benchmarks donor flexibility in budget management."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_award_position_funding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Position-level grant funding KPI layer over the award position funding table. Tracks effort allocation, cost allocation amounts, and funding status for staff positions charged to awards. Used by grants finance and HR teams to monitor labor cost compliance, effort reporting, and NICRA base calculations. Supports SAP VISION HR-to-grants integration and 2 CFR 200 effort reporting requirements."
  source: "`vibe_ngo_v1`.`grant`.`award_position_funding`"
  dimensions:
    - name: "funding_status"
      expr: funding_status
      comment: "Status of the position funding (e.g. Active, Ended, Pending). Primary filter for active position funding analysis."
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the position funding started. Used for annual effort allocation trend analysis."
    - name: "end_year"
      expr: YEAR(end_date)
      comment: "Year the position funding ends. Used to identify positions with expiring grant funding."
  measures:
    - name: "total_position_fundings"
      expr: COUNT(1)
      comment: "Total number of position-award funding records. Baseline measure for grant-funded workforce size."
    - name: "total_cost_allocation_amount"
      expr: SUM(CAST(cost_allocation_amount AS DOUBLE))
      comment: "Sum of cost allocation amounts across position fundings. Tracks total labor costs charged to awards; primary input for NICRA base calculations."
    - name: "avg_effort_percent"
      expr: AVG(CAST(effort_percent AS DOUBLE))
      comment: "Average effort percentage across position fundings. Benchmarks staff effort allocation and identifies over-allocation risk."
    - name: "total_effort_percent"
      expr: SUM(CAST(effort_percent AS DOUBLE))
      comment: "Sum of effort percentages across position fundings. Used to identify positions with total effort exceeding 100% (compliance risk)."
    - name: "distinct_funded_positions"
      expr: COUNT(DISTINCT position_id)
      comment: "Number of distinct positions funded by grants. Tracks grant-funded workforce breadth for workforce planning."
    - name: "distinct_funded_awards"
      expr: COUNT(DISTINCT award_id)
      comment: "Number of distinct awards funding positions. Tracks award portfolio breadth for labor cost distribution analysis."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_solicitation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Business development pipeline KPI layer over the solicitation table. Tracks funding opportunity identification, pipeline value, go/no-go decisions, and competitive intelligence. Used by business development directors to monitor opportunity pipeline, prioritize capture efforts, and allocate proposal development resources. Supports both inbound grant-seeking and outbound grantmaking RFP workflows."
  source: "`vibe_ngo_v1`.`grant`.`solicitation`"
  dimensions:
    - name: "solicitation_type"
      expr: solicitation_type
      comment: "Type of solicitation (e.g. RFP, RFA, NOFO, Unsolicited). Primary classification for opportunity pipeline analysis."
    - name: "solicitation_status"
      expr: solicitation_status
      comment: "Current status of the solicitation (e.g. Open, Closed, Awarded, Cancelled). Primary filter for active pipeline."
    - name: "thematic_focus_area"
      expr: thematic_focus_area
      comment: "Thematic focus area of the solicitation (e.g. Health, WASH, Protection). Used for sector-level pipeline analysis."
    - name: "grantmaking_focus_area"
      expr: grantmaking_focus_area
      comment: "Focus area for outbound grantmaking solicitations. Used by foundation program officers."
    - name: "funding_currency"
      expr: funding_currency
      comment: "Currency of the solicitation funding. Used for multi-currency pipeline valuation."
    - name: "cost_share_required"
      expr: cost_share_required
      comment: "Boolean flag indicating whether cost-share is required. Filters opportunities with matching obligations."
    - name: "indirect_cost_rate_allowed"
      expr: indirect_cost_rate_allowed
      comment: "Flags solicitations that allow indirect cost recovery. Used to assess overhead recovery potential."
    - name: "consortium_allowed"
      expr: consortium_allowed
      comment: "Flags solicitations that allow consortium applications. Used for partnership strategy decisions."
    - name: "is_grantmaking_rfp"
      expr: is_grantmaking_rfp
      comment: "Flags outbound grantmaking RFPs. Separates foundation grantmaking solicitations from fundraising opportunities."
    - name: "is_outbound_grantmaking_flag"
      expr: is_outbound_grantmaking_flag
      comment: "Flags outbound grantmaking solicitations. Used for foundation grantmaking pipeline analysis."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the solicitation. Used for impact reporting and strategic alignment analysis."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code. Required for IATI publication and donor statistical reporting."
    - name: "publication_year"
      expr: YEAR(publication_date)
      comment: "Year the solicitation was published. Used for annual opportunity pipeline trend analysis."
    - name: "anticipated_award_year"
      expr: YEAR(anticipated_award_date)
      comment: "Anticipated year of award. Used for forward-looking pipeline and workload planning."
  measures:
    - name: "total_solicitations"
      expr: COUNT(1)
      comment: "Total number of solicitations tracked. Baseline measure for business development opportunity pipeline volume."
    - name: "total_estimated_funding_amount"
      expr: SUM(CAST(estimated_funding_amount AS DOUBLE))
      comment: "Sum of estimated funding amounts across solicitations. Primary pipeline value KPI for business development leadership."
    - name: "avg_estimated_funding_amount"
      expr: AVG(CAST(estimated_funding_amount AS DOUBLE))
      comment: "Average estimated funding amount per solicitation. Benchmarks opportunity size and informs resource allocation per bid."
    - name: "total_board_authorized_funding_pool"
      expr: SUM(CAST(board_authorized_funding_pool AS DOUBLE))
      comment: "Sum of board-authorized funding pools across solicitations. Tracks total grantmaking budget authorized by the board for outbound grants."
    - name: "avg_indirect_cost_rate_cap"
      expr: AVG(CAST(indirect_cost_rate_cap AS DOUBLE))
      comment: "Average indirect cost rate cap across solicitations. Benchmarks overhead recovery constraints in the opportunity pipeline."
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost-share percentage required across solicitations. Benchmarks matching burden in the opportunity pipeline."
    - name: "open_solicitations"
      expr: COUNT(CASE WHEN solicitation_status = 'Open' THEN solicitation_id END)
      comment: "Number of currently open solicitations. Tracks active business development pipeline requiring immediate action."
    - name: "grantmaking_solicitations"
      expr: COUNT(CASE WHEN is_grantmaking_rfp = TRUE THEN solicitation_id END)
      comment: "Number of outbound grantmaking solicitations. Tracks foundation grantmaking pipeline activity."
    - name: "consortium_eligible_solicitations"
      expr: COUNT(CASE WHEN consortium_allowed = TRUE THEN solicitation_id END)
      comment: "Number of solicitations allowing consortium applications. Informs partnership strategy and consortium formation decisions."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_asset_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IT asset cost allocation KPI layer over the asset allocation table. Tracks allocated costs, depreciation, and donor approval status for IT assets charged to awards. Used by grants finance and IT teams to monitor asset cost compliance, donor prior approval requirements, and asset utilization across the grant portfolio. Supports SAP VISION fixed asset management integration."
  source: "`vibe_ngo_v1`.`grant`.`asset_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of the asset allocation (e.g. Active, Ended, Pending). Primary filter for active asset allocation analysis."
    - name: "donor_approval_required"
      expr: donor_approval_required
      comment: "Flags asset allocations requiring donor prior approval. Tracks compliance with donor equipment approval requirements."
    - name: "allocation_justification"
      expr: allocation_justification
      comment: "Justification for the asset allocation. Used for compliance review and audit trail."
    - name: "allocation_start_year"
      expr: YEAR(allocation_start_date)
      comment: "Year the asset allocation started. Used for annual asset cost trend analysis."
    - name: "purchase_year"
      expr: YEAR(purchase_date)
      comment: "Year the asset was purchased. Used for asset vintage and depreciation analysis."
    - name: "donor_approval_year"
      expr: YEAR(donor_approval_date)
      comment: "Year of donor approval for the asset allocation. Used for approval cycle time analysis."
  measures:
    - name: "total_asset_allocations"
      expr: COUNT(1)
      comment: "Total number of asset allocations to awards. Baseline measure for asset utilization across the grant portfolio."
    - name: "total_cost_allocated"
      expr: SUM(CAST(cost_allocated AS DOUBLE))
      comment: "Sum of costs allocated to awards for IT assets. Tracks total asset cost charged to grants for compliance and audit purposes."
    - name: "total_depreciation_allocation"
      expr: SUM(CAST(depreciation_allocation AS DOUBLE))
      comment: "Sum of depreciation amounts allocated to awards. Tracks depreciation cost recovery across the grant portfolio."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage across asset-award allocations. Benchmarks asset utilization and identifies over-allocation risk."
    - name: "assets_requiring_donor_approval"
      expr: COUNT(CASE WHEN donor_approval_required = TRUE THEN asset_allocation_id END)
      comment: "Number of asset allocations requiring donor prior approval. Tracks compliance workload for equipment approval requirements."
    - name: "distinct_awards_with_assets"
      expr: COUNT(DISTINCT award_id)
      comment: "Number of distinct awards with IT asset allocations. Tracks breadth of asset cost recovery across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_staff_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant staff assignment KPI layer over the grant staff assignment table. Tracks staff effort allocation, FTE budgeting, and assignment status across awards. Used by grants managers and HR teams to monitor labor cost compliance, effort reporting, and key personnel requirements. Supports 2 CFR 200 effort reporting and SAP VISION HR-to-grants integration."
  source: "`vibe_ngo_v1`.`grant`.`grant_staff_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Status of the staff assignment (e.g. Active, Ended, Pending). Primary filter for active assignment analysis."
    - name: "role"
      expr: role
      comment: "Role of the staff member on the award (e.g. Principal Investigator, Program Manager, Finance Officer). Used for role-level effort analysis."
    - name: "assignment_start_year"
      expr: YEAR(assignment_start_date)
      comment: "Year the assignment started. Used for annual staffing trend analysis."
    - name: "assignment_end_year"
      expr: YEAR(assignment_end_date)
      comment: "Year the assignment ends. Used to identify expiring assignments requiring renewal."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the assignment was approved. Used for approval cycle time analysis."
  measures:
    - name: "total_staff_assignments"
      expr: COUNT(1)
      comment: "Total number of grant staff assignments. Baseline measure for grant-funded workforce size."
    - name: "total_budgeted_fte"
      expr: SUM(CAST(budgeted_fte AS DOUBLE))
      comment: "Sum of budgeted FTEs across grant staff assignments. Tracks total grant-funded workforce capacity."
    - name: "avg_effort_percent"
      expr: AVG(CAST(effort_percent AS DOUBLE))
      comment: "Average effort percentage across grant staff assignments. Benchmarks staff effort allocation and identifies over-allocation risk."
    - name: "total_effort_percent"
      expr: SUM(CAST(effort_percent AS DOUBLE))
      comment: "Sum of effort percentages across assignments. Used to identify staff with total effort exceeding 100% (compliance risk under 2 CFR 200)."
    - name: "distinct_assigned_awards"
      expr: COUNT(DISTINCT award_id)
      comment: "Number of distinct awards with staff assignments. Tracks award portfolio breadth for labor cost distribution analysis."
    - name: "active_assignments"
      expr: COUNT(CASE WHEN assignment_status = 'Active' THEN grant_staff_assignment_id END)
      comment: "Number of currently active grant staff assignments. Tracks current grant-funded workforce size for capacity planning."
$$;