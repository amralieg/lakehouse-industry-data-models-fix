-- Metric views for domain: grant | Business: Ngo | Version: 1 | Generated on: 2026-05-07 03:19:07

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`grant_award`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over grant awards. Tracks portfolio size, funding obligations, cost-share commitments, and amendment activity to support executive grant portfolio management and donor stewardship decisions."
  source: "`ngo_ecm`.`grant`.`award`"
  dimensions:
    - name: "award_status"
      expr: award_status
      comment: "Lifecycle status of the award (e.g. Active, Closed, Pipeline) — primary filter for portfolio health dashboards."
    - name: "award_type"
      expr: award_type
      comment: "Classification of the award instrument (e.g. Grant, Cooperative Agreement, Contract) — drives compliance and reporting requirements."
    - name: "thematic_sector"
      expr: thematic_sector
      comment: "Humanitarian or development sector the award addresses (e.g. Health, WASH, Education) — used for sector-level portfolio analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic coverage of the award — supports regional portfolio distribution analysis."
    - name: "primary_country_code"
      expr: primary_country_code
      comment: "ISO country code of the primary implementation country — enables country-level funding analysis."
    - name: "currency"
      expr: currency
      comment: "Award currency code — used to segment multi-currency portfolio analysis."
    - name: "functional_currency"
      expr: functional_currency
      comment: "Functional reporting currency for the award — used for consolidated financial reporting."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Restriction classification of the award funds (e.g. Restricted, Unrestricted, Earmarked) — critical for fund utilization compliance."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code for ODA classification and donor reporting alignment."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "UN Sustainable Development Goal alignment codes — used for impact reporting to donors and boards."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Applicable regulatory framework (e.g. 2 CFR 200, FCDO Smart Rules) — drives compliance overhead analysis."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Donor-required reporting cadence (e.g. Monthly, Quarterly, Annual) — used to forecast reporting workload."
    - name: "payment_method"
      expr: payment_method
      comment: "Disbursement method (e.g. Advance, Reimbursement) — affects cash flow planning."
    - name: "cost_share_required"
      expr: cost_share_required
      comment: "Boolean flag indicating whether the award mandates cost-sharing — used to identify compliance obligations."
    - name: "audit_required"
      expr: audit_required
      comment: "Boolean flag indicating whether an audit is required for this award — used to plan audit workload."
    - name: "advance_payment_allowed"
      expr: advance_payment_allowed
      comment: "Boolean flag indicating whether advance payments are permitted — affects cash flow and risk management."
    - name: "agreement_signed_year"
      expr: DATE_TRUNC('YEAR', agreement_signed_date)
      comment: "Year the award agreement was signed — used for cohort and vintage analysis of the grant portfolio."
    - name: "start_year"
      expr: DATE_TRUNC('YEAR', start_date)
      comment: "Year the award period of performance begins — used for pipeline and active portfolio trending."
    - name: "end_year"
      expr: DATE_TRUNC('YEAR', end_date)
      comment: "Year the award period of performance ends — used for closeout planning and pipeline forecasting."
  measures:
    - name: "total_awards"
      expr: COUNT(1)
      comment: "Total number of grant awards in the portfolio. Baseline KPI for portfolio size tracking on executive dashboards."
    - name: "total_obligated_amount_usd"
      expr: SUM(CAST(total_obligated_amount_functional AS DOUBLE))
      comment: "Total obligated funding in functional currency across all awards. Primary financial KPI for grant portfolio value — drives resource allocation and donor stewardship decisions."
    - name: "avg_award_size_usd"
      expr: AVG(CAST(total_obligated_amount_functional AS DOUBLE))
      comment: "Average obligated amount per award in functional currency. Indicates portfolio concentration and typical award scale — used to benchmark new proposals."
    - name: "total_authorized_amount_usd"
      expr: SUM(CAST(authorized_amount AS DOUBLE))
      comment: "Total authorized (ceiling) funding across all awards. Compared against obligated amounts to assess funding headroom and pipeline capacity."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share (matching funds) committed across all awards. Critical compliance KPI — failure to meet cost-share requirements can trigger donor clawbacks."
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost-share percentage required across awards. Indicates the overall matching burden on the organization's own resources."
    - name: "total_indirect_cost_ceiling"
      expr: SUM(CAST(indirect_cost_ceiling AS DOUBLE))
      comment: "Total indirect cost ceiling (overhead recovery cap) across all awards. Used by finance leadership to assess indirect cost recovery potential vs. NICRA rate."
    - name: "avg_nicra_icr_rate"
      expr: AVG(CAST(nicra_icr_rate AS DOUBLE))
      comment: "Average NICRA indirect cost recovery rate applied across awards. Benchmarks overhead recovery efficiency against negotiated rates."
    - name: "awards_requiring_audit"
      expr: COUNT(CASE WHEN audit_required = TRUE THEN 1 END)
      comment: "Number of awards requiring an audit. Drives audit planning, resource allocation for compliance teams, and risk exposure assessment."
    - name: "awards_with_cost_share"
      expr: COUNT(CASE WHEN cost_share_required = TRUE THEN 1 END)
      comment: "Number of awards with mandatory cost-share requirements. Used to assess organizational matching fund obligations and compliance risk."
    - name: "awards_with_amendments"
      expr: COUNT(CASE WHEN amendment_count IS NOT NULL AND amendment_count <> '0' THEN 1 END)
      comment: "Number of awards that have been amended at least once. High amendment rates signal scope instability, donor relationship complexity, or implementation challenges."
    - name: "total_exchange_rate_to_functional_avg"
      expr: AVG(CAST(exchange_rate_to_functional AS DOUBLE))
      comment: "Average exchange rate applied to convert award currency to functional currency. Used by finance to monitor FX exposure across the portfolio."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`grant_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Business development and proposal pipeline KPI layer. Tracks proposal win rates, requested funding volumes, cost-share commitments, and pipeline conversion to inform fundraising strategy and resource allocation for proposal writing."
  source: "`ngo_ecm`.`grant`.`proposal`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current lifecycle status of the proposal (e.g. Draft, Submitted, Won, Lost) — primary dimension for pipeline stage analysis."
    - name: "proposal_type"
      expr: proposal_type
      comment: "Type of proposal (e.g. Concept Note, Full Proposal, Unsolicited) — used to analyze conversion rates by proposal format."
    - name: "win_loss_outcome"
      expr: win_loss_outcome
      comment: "Final outcome of the proposal (Won, Lost, Withdrawn, Pending) — core dimension for win-rate analysis."
    - name: "lead_technical_sector"
      expr: lead_technical_sector
      comment: "Primary technical sector of the proposal (e.g. Health, Nutrition, Shelter) — used to analyze win rates and funding by sector."
    - name: "geographic_focus"
      expr: geographic_focus
      comment: "Geographic focus area of the proposal — used for regional pipeline and win-rate analysis."
    - name: "partnership_model"
      expr: partnership_model
      comment: "Partnership structure (e.g. Prime, Consortium, Sub) — used to analyze how partnership models affect win rates."
    - name: "go_no_go_decision"
      expr: go_no_go_decision
      comment: "Go/No-Go decision outcome — used to analyze proposal qualification rigor and resource efficiency."
    - name: "requested_currency"
      expr: requested_currency
      comment: "Currency in which the proposal funding was requested — used for multi-currency pipeline analysis."
    - name: "compliance_review_completed"
      expr: compliance_review_completed
      comment: "Boolean flag indicating whether compliance review was completed before submission — used to assess proposal quality controls."
    - name: "submission_year"
      expr: DATE_TRUNC('YEAR', submission_date)
      comment: "Year the proposal was submitted — used for annual pipeline trend analysis and fundraising performance reviews."
    - name: "proposed_start_year"
      expr: DATE_TRUNC('YEAR', proposed_start_date)
      comment: "Year the proposed program would begin — used for forward pipeline planning."
  measures:
    - name: "total_proposals"
      expr: COUNT(1)
      comment: "Total number of proposals in the pipeline. Baseline KPI for business development activity volume."
    - name: "total_requested_amount_usd"
      expr: SUM(CAST(requested_amount_usd AS DOUBLE))
      comment: "Total funding requested across all proposals in USD. Primary pipeline value KPI — used by leadership to assess fundraising ambition vs. capacity."
    - name: "avg_requested_amount_usd"
      expr: AVG(CAST(requested_amount_usd AS DOUBLE))
      comment: "Average funding requested per proposal in USD. Benchmarks typical proposal size and informs resource planning for proposal development."
    - name: "total_won_proposals"
      expr: COUNT(CASE WHEN win_loss_outcome = 'Won' THEN 1 END)
      comment: "Number of proposals that were awarded. Numerator for win-rate calculation — core business development performance KPI."
    - name: "total_submitted_proposals"
      expr: COUNT(CASE WHEN proposal_status = 'Submitted' OR win_loss_outcome IN ('Won', 'Lost') THEN 1 END)
      comment: "Number of proposals that reached submission stage. Denominator for win-rate and conversion analysis."
    - name: "total_won_amount_usd"
      expr: SUM(CASE WHEN win_loss_outcome = 'Won' THEN CAST(requested_amount_usd AS DOUBLE) ELSE 0 END)
      comment: "Total funding value of won proposals in USD. Measures actual fundraising success — directly tied to program delivery capacity."
    - name: "total_cost_share_committed_usd"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share (matching funds) committed across all proposals. Indicates the organizational resource burden associated with the proposal pipeline."
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost-share percentage proposed across all proposals. Used to assess the matching fund burden being committed in the pipeline."
    - name: "avg_indirect_cost_rate_proposed"
      expr: AVG(CAST(indirect_cost_rate_proposed AS DOUBLE))
      comment: "Average indirect cost rate proposed across submissions. Benchmarks overhead recovery strategy against NICRA and donor norms."
    - name: "proposals_with_compliance_review"
      expr: COUNT(CASE WHEN compliance_review_completed = TRUE THEN 1 END)
      comment: "Number of proposals where compliance review was completed. Measures proposal quality control adherence — low rates signal submission risk."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`grant_award_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant budget management KPI layer. Tracks approved budget composition, cost category breakdowns, indirect cost recovery, and budget amendment activity to support financial oversight and donor compliance reporting."
  source: "`ngo_ecm`.`grant`.`award_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Approval status of the budget version (e.g. Draft, Approved, Superseded) — primary filter for active budget analysis."
    - name: "budget_period"
      expr: budget_period
      comment: "Budget period label (e.g. Year 1, Year 2) — used for multi-year budget trend analysis."
    - name: "award_currency"
      expr: award_currency
      comment: "Currency of the award budget — used for multi-currency budget portfolio analysis."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Fund restriction classification for the budget — used to segment restricted vs. unrestricted budget analysis."
    - name: "cost_share_required"
      expr: cost_share_required
      comment: "Boolean flag indicating whether cost-share is required for this budget — used to identify matching fund obligations."
    - name: "is_amendment"
      expr: is_amendment
      comment: "Boolean flag indicating whether this budget record is an amendment — used to track budget revision frequency."
    - name: "indirect_cost_base"
      expr: indirect_cost_base
      comment: "Base used to calculate indirect costs (e.g. MTDC, TDC) — used to analyze overhead recovery methodology across awards."
    - name: "budget_period_start_year"
      expr: DATE_TRUNC('YEAR', budget_period_start_date)
      comment: "Year the budget period begins — used for annual budget trend and planning analysis."
    - name: "donor_approval_year"
      expr: DATE_TRUNC('YEAR', donor_approval_date)
      comment: "Year donor approval was received — used to track approval cycle times and budget activation timelines."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_budget AS DOUBLE))
      comment: "Total approved budget across all award budget records. Primary financial scale KPI for grant portfolio budget management."
    - name: "total_direct_costs"
      expr: SUM(CAST(total_direct_costs AS DOUBLE))
      comment: "Total direct program costs across all budgets. Used to assess programmatic spend capacity and direct cost efficiency."
    - name: "total_indirect_costs"
      expr: SUM(CAST(total_indirect_costs AS DOUBLE))
      comment: "Total indirect costs (overhead) recovered across all budgets. Critical for assessing organizational cost recovery and financial sustainability."
    - name: "total_personnel_costs"
      expr: SUM(CAST(personnel_costs AS DOUBLE))
      comment: "Total personnel costs across all award budgets. Largest cost driver in most NGO budgets — used for workforce planning and salary cost analysis."
    - name: "total_travel_costs"
      expr: SUM(CAST(travel_costs AS DOUBLE))
      comment: "Total travel costs across all award budgets. Used to monitor travel spend compliance and identify cost reduction opportunities."
    - name: "total_equipment_costs"
      expr: SUM(CAST(equipment_costs AS DOUBLE))
      comment: "Total equipment costs across all award budgets. Used for asset procurement planning and donor prior-approval threshold monitoring."
    - name: "total_contractual_costs"
      expr: SUM(CAST(contractual_costs AS DOUBLE))
      comment: "Total contractual (subaward and vendor) costs across all budgets. Used to assess partner and vendor spend concentration."
    - name: "total_supplies_costs"
      expr: SUM(CAST(supplies_costs AS DOUBLE))
      comment: "Total supplies costs across all award budgets. Used for procurement planning and supply chain cost analysis."
    - name: "total_cost_share_budget"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share (matching funds) budgeted across all awards. Used to track matching fund obligations against commitments."
    - name: "avg_nicra_rate_applied"
      expr: AVG(CAST(nicra_rate_applied AS DOUBLE))
      comment: "Average NICRA indirect cost rate applied across award budgets. Benchmarks actual overhead recovery rates against negotiated NICRA agreements."
    - name: "amendment_budget_count"
      expr: COUNT(CASE WHEN is_amendment = TRUE THEN 1 END)
      comment: "Number of budget records that are amendments. High amendment counts signal scope instability or implementation challenges requiring leadership attention."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`grant_award_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular budget line KPI layer for grant financial management. Tracks approved vs. revised vs. expended amounts at the cost-category level to support burn rate monitoring, variance analysis, and donor financial reporting."
  source: "`ngo_ecm`.`grant`.`award_budget_line`"
  dimensions:
    - name: "cost_category"
      expr: cost_category
      comment: "High-level cost category (e.g. Personnel, Travel, Equipment) — primary grouping for budget analysis and donor reporting."
    - name: "cost_subcategory"
      expr: cost_subcategory
      comment: "Detailed cost subcategory — used for granular budget line analysis and donor reporting category mapping."
    - name: "donor_reporting_category"
      expr: donor_reporting_category
      comment: "Donor-specific reporting category label — used to align internal budget lines with donor financial report templates."
    - name: "budget_line_status"
      expr: budget_line_status
      comment: "Status of the budget line (e.g. Active, Closed, Pending Approval) — used to filter active vs. historical budget lines."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Fund restriction type for the budget line — used to segment restricted vs. unrestricted expenditure analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget line — used for multi-currency budget analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget line — used for annual budget and expenditure trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (e.g. Q1, Month 3) of the budget line — used for periodic burn rate and variance reporting."
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account code — used to reconcile budget lines with financial accounting records."
    - name: "allocability_flag"
      expr: allocability_flag
      comment: "Boolean flag indicating whether the cost is allocable to the award — used for compliance and audit analysis."
    - name: "allowability_flag"
      expr: allowability_flag
      comment: "Boolean flag indicating whether the cost is allowable under donor rules — critical compliance dimension."
    - name: "reasonableness_flag"
      expr: reasonableness_flag
      comment: "Boolean flag indicating whether the cost has been assessed as reasonable — used for audit readiness monitoring."
    - name: "approval_year"
      expr: DATE_TRUNC('YEAR', approval_date)
      comment: "Year the budget line was approved — used for approval cycle time analysis."
  measures:
    - name: "total_approved_amount_usd"
      expr: SUM(CAST(approved_amount_usd AS DOUBLE))
      comment: "Total approved budget line amounts in USD. Baseline financial KPI for grant budget portfolio size at line-item level."
    - name: "total_revised_amount_usd"
      expr: SUM(CAST(revised_amount_usd AS DOUBLE))
      comment: "Total revised budget amounts in USD after amendments. Compared against approved amounts to measure scope and budget change magnitude."
    - name: "total_cumulative_expenditure_usd"
      expr: SUM(CAST(cumulative_expenditure_usd AS DOUBLE))
      comment: "Total cumulative expenditure to date in USD across all budget lines. Primary burn rate KPI — used to assess financial execution pace against approved budgets."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (approved minus expended) across all lines. Negative variance signals overspend risk requiring immediate management action."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage across budget lines. Used to assess overall budget execution accuracy and identify systemic over/under-spending patterns."
    - name: "total_indirect_cost_amount"
      expr: SUM(CAST(indirect_cost_amount AS DOUBLE))
      comment: "Total indirect costs charged across all budget lines. Used to monitor overhead recovery against NICRA ceilings and donor-approved indirect cost rates."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share amounts recorded at budget line level. Used to verify cost-share commitments are being met at granular level for donor compliance."
    - name: "avg_nicra_rate_applied"
      expr: AVG(CAST(nicra_rate_applied AS DOUBLE))
      comment: "Average NICRA rate applied at budget line level. Used to verify consistent application of negotiated indirect cost rates across the portfolio."
    - name: "non_compliant_lines"
      expr: COUNT(CASE WHEN allowability_flag = FALSE OR allocability_flag = FALSE THEN 1 END)
      comment: "Number of budget lines flagged as non-allowable or non-allocable. Critical audit risk KPI — high counts signal potential donor disallowances and financial exposure."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of units budgeted across all budget lines. Used for unit-cost benchmarking and procurement volume planning."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across all budget lines. Used to benchmark cost reasonableness and identify outliers for audit review."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`grant_donor_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor reporting compliance and performance KPI layer. Tracks report submission timeliness, financial reporting accuracy, KPI achievement rates, and compliance certification to support donor relationship management and regulatory compliance."
  source: "`ngo_ecm`.`grant`.`donor_report`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Current status of the donor report (e.g. Draft, Submitted, Accepted, Overdue) — primary dimension for reporting compliance dashboards."
    - name: "report_type"
      expr: report_type
      comment: "Type of donor report (e.g. Financial, Narrative, Final, Interim) — used to analyze compliance by report category."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Reporting cadence (e.g. Monthly, Quarterly, Annual) — used to segment reporting workload and compliance by frequency."
    - name: "financial_currency"
      expr: financial_currency
      comment: "Currency used in the financial report — used for multi-currency financial reporting analysis."
    - name: "is_overdue"
      expr: is_overdue
      comment: "Boolean flag indicating whether the report is overdue — primary compliance risk indicator for donor relationship management."
    - name: "is_final_version"
      expr: is_final_version
      comment: "Boolean flag indicating whether this is the final accepted version — used to distinguish draft from finalized reporting records."
    - name: "compliance_certification_flag"
      expr: compliance_certification_flag
      comment: "Boolean flag indicating whether the compliance certification was included — used to track regulatory submission completeness."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the report (e.g. Portal, Email, Post) — used to analyze submission channel efficiency."
    - name: "submission_year"
      expr: DATE_TRUNC('YEAR', submission_date)
      comment: "Year the report was submitted — used for annual reporting compliance trend analysis."
    - name: "reporting_period_end_year"
      expr: DATE_TRUNC('YEAR', reporting_period_end_date)
      comment: "Year the reporting period ends — used for cohort-based compliance analysis."
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total number of donor reports. Baseline KPI for reporting workload volume — used to plan reporting team capacity."
    - name: "overdue_reports"
      expr: COUNT(CASE WHEN is_overdue = TRUE THEN 1 END)
      comment: "Number of overdue donor reports. Critical donor relationship risk KPI — overdue reports can trigger donor sanctions, funding holds, or reputational damage."
    - name: "total_financial_amount_reported_usd"
      expr: SUM(CAST(financial_amount_reported_usd AS DOUBLE))
      comment: "Total financial expenditure reported to donors in USD. Used to reconcile reported spend against internal financial records and assess reporting accuracy."
    - name: "total_cumulative_expenditure_to_date"
      expr: SUM(CAST(cumulative_expenditure_to_date AS DOUBLE))
      comment: "Total cumulative expenditure reported to date across all donor reports. Used to track overall financial execution pace reported externally."
    - name: "total_budget_variance_amount"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total budget variance reported to donors. Large variances trigger donor inquiries and may require prior approval — a key financial compliance KPI."
    - name: "avg_budget_variance_percentage"
      expr: AVG(CAST(budget_variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage across all donor reports. Used to assess systemic over/under-spending patterns reported to donors."
    - name: "reports_with_compliance_certification"
      expr: COUNT(CASE WHEN compliance_certification_flag = TRUE THEN 1 END)
      comment: "Number of reports with compliance certification included. Measures regulatory submission completeness — missing certifications can invalidate reports."
    - name: "avg_exchange_rate_used"
      expr: AVG(CAST(exchange_rate_used AS DOUBLE))
      comment: "Average exchange rate applied in donor financial reports. Used to monitor FX rate consistency and identify potential reporting discrepancies."
    - name: "final_version_reports"
      expr: COUNT(CASE WHEN is_final_version = TRUE THEN 1 END)
      comment: "Number of reports that are final accepted versions. Used to track reporting completion rate and distinguish finalized from in-progress submissions."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`grant_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant amendment tracking KPI layer. Monitors amendment frequency, funding changes, period extensions, and scope modifications to support portfolio stability analysis and donor relationship management."
  source: "`ngo_ecm`.`grant`.`grant_amendment`"
  dimensions:
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the amendment (e.g. Pending, Approved, Rejected) — primary filter for active amendment pipeline analysis."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (e.g. No-Cost Extension, Budget Modification, Scope Change) — used to analyze amendment drivers and patterns."
    - name: "is_no_cost_extension"
      expr: is_no_cost_extension
      comment: "Boolean flag indicating whether the amendment is a no-cost extension — used to track implementation timeline challenges."
    - name: "donor_prior_approval_required"
      expr: donor_prior_approval_required
      comment: "Boolean flag indicating whether donor prior approval was required — used to assess compliance process burden."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the amendment funding change — used for multi-currency amendment analysis."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the amendment became effective — used for annual amendment trend analysis."
    - name: "request_year"
      expr: DATE_TRUNC('YEAR', request_date)
      comment: "Year the amendment was requested — used to analyze amendment request lead times and approval cycle times."
  measures:
    - name: "total_amendments"
      expr: COUNT(1)
      comment: "Total number of grant amendments. Baseline KPI for portfolio stability — high amendment rates signal implementation challenges or donor relationship complexity."
    - name: "total_funding_change"
      expr: SUM(CAST(funding_change AS DOUBLE))
      comment: "Net total funding change across all amendments. Positive values indicate additional funding secured; negative values indicate deobligation — a key portfolio financial KPI."
    - name: "total_revised_obligation"
      expr: SUM(CAST(revised_total_obligation AS DOUBLE))
      comment: "Total revised award obligation amounts after amendments. Reflects the current financial commitment of the grant portfolio post-amendment."
    - name: "total_original_obligation"
      expr: SUM(CAST(original_total_obligation AS DOUBLE))
      comment: "Total original award obligation amounts before amendments. Used as baseline to calculate net funding change across the portfolio."
    - name: "no_cost_extensions_count"
      expr: COUNT(CASE WHEN is_no_cost_extension = TRUE THEN 1 END)
      comment: "Number of no-cost extension amendments. High NCE rates indicate systemic implementation delays — a key program performance risk indicator."
    - name: "donor_prior_approval_amendments"
      expr: COUNT(CASE WHEN donor_prior_approval_required = TRUE THEN 1 END)
      comment: "Number of amendments requiring donor prior approval. Measures compliance process burden and donor relationship management workload."
    - name: "avg_funding_change_per_amendment"
      expr: AVG(CAST(funding_change AS DOUBLE))
      comment: "Average funding change per amendment. Used to assess the typical financial magnitude of amendments and benchmark against portfolio norms."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`grant_subaward`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subaward portfolio management KPI layer. Tracks partner funding disbursements, obligation balances, risk ratings, and compliance requirements to support partner financial oversight and pass-through entity compliance."
  source: "`ngo_ecm`.`grant`.`award`"
  dimensions:
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Fund restriction type for the subaward — used to segment restricted vs. unrestricted partner funding analysis."
    - name: "currency"
      expr: currency
      comment: "Currency of the subaward — used for multi-currency partner portfolio analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for the subaward (e.g. Advance, Reimbursement) — used to analyze cash flow and partner payment risk."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Partner reporting cadence — used to plan subaward reporting oversight workload."
  measures:
    - name: "total_subawards"
      expr: COUNT(1)
      comment: "Total number of subawards in the portfolio. Baseline KPI for partner portfolio scale and pass-through entity compliance workload."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share amounts committed by partners. Used to verify partner matching fund contributions against award requirements."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`grant_cost_share_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost-share compliance and verification KPI layer. Tracks committed vs. required vs. verified matching fund amounts to support donor compliance reporting and audit readiness for cost-share obligations."
  source: "`ngo_ecm`.`grant`.`cost_share_commitment`"
  dimensions:
    - name: "commitment_status"
      expr: commitment_status
      comment: "Status of the cost-share commitment (e.g. Pending, Verified, Rejected) — primary filter for compliance monitoring dashboards."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the cost-share commitment — used to identify non-compliant commitments requiring remediation."
    - name: "cost_share_type"
      expr: cost_share_type
      comment: "Type of cost-share contribution (e.g. Cash, In-Kind, Volunteer) — used to analyze matching fund composition."
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category of the cost-share contribution — used for detailed matching fund analysis by cost type."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost-share commitment — used for multi-currency matching fund analysis."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Boolean flag indicating whether the cost-share is a mandatory donor requirement — used to prioritize compliance monitoring."
    - name: "is_restricted_fund"
      expr: is_restricted_fund
      comment: "Boolean flag indicating whether the cost-share source is a restricted fund — used to assess fund eligibility for matching purposes."
    - name: "in_kind_valuation_method"
      expr: in_kind_valuation_method
      comment: "Method used to value in-kind contributions — used to assess valuation consistency and audit defensibility."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify the cost-share contribution — used to assess verification rigor and audit readiness."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the cost-share commitment — used for annual compliance trend analysis."
    - name: "commitment_year"
      expr: DATE_TRUNC('YEAR', commitment_date)
      comment: "Year the cost-share commitment was made — used for cohort analysis of matching fund obligations."
  measures:
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total cost-share amount committed across all records. Primary KPI for matching fund obligation tracking — compared against required amounts for compliance."
    - name: "total_required_cost_share_amount"
      expr: SUM(CAST(required_cost_share_amount AS DOUBLE))
      comment: "Total cost-share amount required by donor agreements. Denominator for cost-share fulfillment rate — critical compliance baseline."
    - name: "total_verified_amount"
      expr: SUM(CAST(verified_amount AS DOUBLE))
      comment: "Total cost-share amount that has been verified and documented. Used to assess audit-ready matching fund documentation — unverified amounts are at risk of donor disallowance."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between committed and required cost-share amounts. Negative variance indicates a cost-share shortfall — a critical compliance risk requiring immediate action."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average cost-share variance percentage across all commitments. Used to assess systemic cost-share fulfillment performance across the portfolio."
    - name: "avg_required_cost_share_percentage"
      expr: AVG(CAST(required_cost_share_percentage AS DOUBLE))
      comment: "Average required cost-share percentage across all commitments. Used to benchmark the matching fund burden across the grant portfolio."
    - name: "total_volunteer_hours"
      expr: SUM(CAST(volunteer_hours AS DOUBLE))
      comment: "Total volunteer hours contributed as in-kind cost-share. Used to quantify volunteer contribution value and verify in-kind matching fund adequacy."
    - name: "non_compliant_commitments"
      expr: COUNT(CASE WHEN compliance_status <> 'Compliant' AND compliance_status IS NOT NULL THEN 1 END)
      comment: "Number of cost-share commitments with non-compliant status. Critical audit risk KPI — non-compliant commitments may result in donor disallowances and financial penalties."
    - name: "mandatory_commitments"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END)
      comment: "Number of mandatory cost-share commitments. Used to prioritize compliance monitoring resources on highest-risk obligations."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`grant_donor_condition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor condition compliance KPI layer. Tracks special award conditions, compliance status, overdue conditions, and risk ratings to support grant compliance management and donor relationship risk monitoring."
  source: "`ngo_ecm`.`grant`.`donor_condition`"
  dimensions:
    - name: "condition_type"
      expr: condition_type
      comment: "Type of donor condition (e.g. Prior Approval, Reporting, Financial) — used to categorize compliance obligations by type."
    - name: "condition_category"
      expr: condition_category
      comment: "Category of the donor condition — used for compliance workload analysis by condition domain."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the condition (e.g. Met, Pending, Non-Compliant) — primary filter for compliance risk dashboards."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the donor condition (e.g. Low, Medium, High, Critical) — used to prioritize compliance monitoring resources."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the condition — used to triage compliance workload and escalation decisions."
    - name: "is_special_award_condition"
      expr: is_special_award_condition
      comment: "Boolean flag indicating whether this is a Special Award Condition (SAC) — SACs carry heightened compliance risk and donor scrutiny."
    - name: "monitoring_frequency"
      expr: monitoring_frequency
      comment: "Frequency of condition monitoring (e.g. Monthly, Quarterly) — used to plan compliance monitoring workload."
    - name: "due_year"
      expr: DATE_TRUNC('YEAR', due_date)
      comment: "Year the condition is due — used for annual compliance deadline planning and workload forecasting."
    - name: "approval_year"
      expr: DATE_TRUNC('YEAR', approval_date)
      comment: "Year the condition was approved or waived — used for compliance resolution trend analysis."
  measures:
    - name: "total_conditions"
      expr: COUNT(1)
      comment: "Total number of donor conditions across all awards. Baseline KPI for compliance obligation volume — used to plan compliance team capacity."
    - name: "non_compliant_conditions"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of donor conditions with non-compliant status. Critical risk KPI — non-compliance can trigger donor sanctions, funding suspension, or award termination."
    - name: "special_award_conditions"
      expr: COUNT(CASE WHEN is_special_award_condition = TRUE THEN 1 END)
      comment: "Number of Special Award Conditions (SACs) across the portfolio. SACs represent the highest compliance risk — used to prioritize compliance monitoring resources."
    - name: "high_risk_conditions"
      expr: COUNT(CASE WHEN risk_rating = 'High' OR risk_rating = 'Critical' THEN 1 END)
      comment: "Number of conditions rated as high or critical risk. Used by compliance leadership to focus oversight on the most consequential obligations."
    - name: "total_financial_threshold_amount"
      expr: SUM(CAST(financial_threshold_amount AS DOUBLE))
      comment: "Total financial threshold amounts associated with donor conditions. Used to quantify the financial exposure linked to compliance conditions."
    - name: "conditions_with_waivers"
      expr: COUNT(CASE WHEN waiver_date IS NOT NULL THEN 1 END)
      comment: "Number of conditions for which a waiver has been granted. Used to track donor flexibility and assess waiver request success rates."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`grant_funding_source`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Funding source portfolio KPI layer. Tracks available funding capacity, cost-share requirements, indirect cost rates, and compliance frameworks across donor funding sources to support strategic fundraising and donor diversification analysis."
  source: "`ngo_ecm`.`grant`.`funding_source`"
  dimensions:
    - name: "funding_source_status"
      expr: funding_source_status
      comment: "Status of the funding source (e.g. Active, Inactive, Expired) — primary filter for active donor pipeline analysis."
    - name: "funding_mechanism_type"
      expr: funding_mechanism_type
      comment: "Type of funding mechanism (e.g. Grant, Contract, Cooperative Agreement) — used to analyze funding instrument mix."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Restriction type of the funding source (e.g. Restricted, Unrestricted) — used to analyze funding flexibility across the donor portfolio."
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Applicable compliance framework (e.g. 2 CFR 200, FCDO, UN Rules) — used to segment funding by regulatory burden."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the funding source — used for multi-currency donor portfolio analysis."
    - name: "cost_share_required"
      expr: cost_share_required
      comment: "Boolean flag indicating whether cost-share is required by this funding source — used to assess matching fund burden by donor."
    - name: "subaward_allowed"
      expr: subaward_allowed
      comment: "Boolean flag indicating whether subawards are permitted — used to assess partnership model flexibility by funding source."
    - name: "advance_payment_allowed"
      expr: advance_payment_allowed
      comment: "Boolean flag indicating whether advance payments are permitted — used for cash flow planning by funding source."
    - name: "indirect_cost_rate_type"
      expr: indirect_cost_rate_type
      comment: "Type of indirect cost rate applicable (e.g. NICRA, Fixed, Negotiated) — used to analyze overhead recovery methodology by donor."
    - name: "oda_dac_classification"
      expr: oda_dac_classification
      comment: "OECD DAC ODA classification — used for official development assistance reporting and donor alignment analysis."
    - name: "funding_start_year"
      expr: DATE_TRUNC('YEAR', funding_start_date)
      comment: "Year the funding source became available — used for donor relationship vintage analysis."
  measures:
    - name: "total_funding_sources"
      expr: COUNT(1)
      comment: "Total number of funding sources in the portfolio. Baseline KPI for donor diversification — low counts indicate funding concentration risk."
    - name: "total_funding_available"
      expr: SUM(CAST(total_funding_available AS DOUBLE))
      comment: "Total funding available across all active funding sources. Primary pipeline capacity KPI — used by leadership to assess fundraising headroom and strategic growth potential."
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost-share percentage required across all funding sources. Used to assess the overall matching fund burden imposed by the donor portfolio."
    - name: "avg_nicra_rate"
      expr: AVG(CAST(nicra_rate AS DOUBLE))
      comment: "Average NICRA indirect cost rate across all funding sources. Used to benchmark overhead recovery potential across the donor portfolio."
    - name: "avg_budget_revision_threshold"
      expr: AVG(CAST(budget_revision_threshold AS DOUBLE))
      comment: "Average budget revision threshold (percentage or amount) across funding sources. Used to assess the flexibility of donor budget management requirements."
    - name: "funding_sources_requiring_cost_share"
      expr: COUNT(CASE WHEN cost_share_required = TRUE THEN 1 END)
      comment: "Number of funding sources requiring cost-share. Used to quantify the matching fund burden across the donor portfolio and plan resource allocation."
    - name: "funding_sources_allowing_subawards"
      expr: COUNT(CASE WHEN subaward_allowed = TRUE THEN 1 END)
      comment: "Number of funding sources that permit subawards. Used to assess partnership model flexibility and partner engagement capacity across the donor portfolio."
$$;