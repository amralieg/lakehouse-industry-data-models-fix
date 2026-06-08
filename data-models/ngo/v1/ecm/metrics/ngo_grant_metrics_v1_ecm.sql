-- Metric views for domain: grant | Business: Ngo | Version: 1 | Generated on: 2026-05-07 01:23:35

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`grant_award`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core grant award financial and performance metrics tracking authorized funding, obligations, cost share, and award lifecycle status for donor-funded programs"
  source: "`ngo_ecm`.`grant`.`award`"
  dimensions:
    - name: "award_number"
      expr: award_number
      comment: "Unique identifier for the grant award"
    - name: "award_status"
      expr: award_status
      comment: "Current lifecycle status of the award (active, closed, suspended)"
    - name: "award_type"
      expr: award_type
      comment: "Classification of award mechanism (grant, cooperative agreement, contract)"
    - name: "funding_mechanism"
      expr: funding_mechanism
      comment: "Specific funding instrument type used by donor"
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Level of restriction on fund usage (unrestricted, temporarily restricted, permanently restricted)"
    - name: "currency"
      expr: currency
      comment: "Award currency code"
    - name: "functional_currency"
      expr: functional_currency
      comment: "Organization functional currency for reporting"
    - name: "thematic_sector"
      expr: thematic_sector
      comment: "Primary thematic area of the award (health, education, WASH, etc.)"
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector classification code"
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "Sustainable Development Goals alignment codes"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic coverage of the award (country, regional, global)"
    - name: "primary_country_code"
      expr: primary_country_code
      comment: "ISO country code for primary implementation country"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Governing regulatory framework (2 CFR 200, USAID ADS, etc.)"
    - name: "cost_share_required"
      expr: cost_share_required
      comment: "Whether cost sharing is mandatory for this award"
    - name: "audit_required"
      expr: audit_required
      comment: "Whether external audit is required"
    - name: "advance_payment_allowed"
      expr: advance_payment_allowed
      comment: "Whether advance payments are permitted"
    - name: "award_year"
      expr: YEAR(start_date)
      comment: "Calendar year of award start date"
    - name: "award_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month of award start for cohort analysis"
    - name: "closeout_year"
      expr: YEAR(closeout_date)
      comment: "Calendar year of award closeout"
  measures:
    - name: "total_authorized_amount"
      expr: SUM(CAST(authorized_amount AS DOUBLE))
      comment: "Total authorized funding amount across all awards in award currency"
    - name: "total_obligated_amount"
      expr: SUM(CAST(total_obligated_amount AS DOUBLE))
      comment: "Total obligated amount across all awards in award currency"
    - name: "total_obligated_amount_functional"
      expr: SUM(CAST(total_obligated_amount_functional AS DOUBLE))
      comment: "Total obligated amount in functional currency for consolidated reporting"
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost share commitment amount across awards"
    - name: "avg_authorized_amount"
      expr: AVG(CAST(authorized_amount AS DOUBLE))
      comment: "Average authorized amount per award"
    - name: "avg_obligation_rate"
      expr: AVG(CAST(total_obligated_amount AS DOUBLE) / NULLIF(CAST(authorized_amount AS DOUBLE), 0))
      comment: "Average obligation rate (obligated divided by authorized) across awards"
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost share percentage required across awards"
    - name: "avg_indirect_cost_ceiling"
      expr: AVG(CAST(indirect_cost_ceiling AS DOUBLE))
      comment: "Average indirect cost rate ceiling across awards"
    - name: "avg_nicra_icr_rate"
      expr: AVG(CAST(nicra_icr_rate AS DOUBLE))
      comment: "Average negotiated indirect cost rate (NICRA) applied across awards"
    - name: "total_audit_threshold_amount"
      expr: SUM(CAST(audit_threshold_amount AS DOUBLE))
      comment: "Total audit threshold amounts across awards requiring audits"
    - name: "award_count"
      expr: COUNT(DISTINCT award_id)
      comment: "Distinct count of grant awards"
    - name: "active_award_count"
      expr: COUNT(DISTINCT CASE WHEN award_status = 'Active' THEN award_id END)
      comment: "Count of awards currently in active status"
    - name: "closed_award_count"
      expr: COUNT(DISTINCT CASE WHEN award_status = 'Closed' THEN award_id END)
      comment: "Count of awards that have been closed out"
    - name: "cost_share_required_count"
      expr: COUNT(DISTINCT CASE WHEN cost_share_required = TRUE THEN award_id END)
      comment: "Count of awards requiring cost share contributions"
    - name: "audit_required_count"
      expr: COUNT(DISTINCT CASE WHEN audit_required = TRUE THEN award_id END)
      comment: "Count of awards requiring external audits"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`grant_award_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant award budget metrics tracking approved budgets, cost categories, indirect costs, and budget compliance across budget periods and amendments"
  source: "`ngo_ecm`.`grant`.`award_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current approval status of the budget (draft, submitted, approved, rejected)"
    - name: "budget_period"
      expr: budget_period
      comment: "Budget period identifier (Year 1, Year 2, etc.)"
    - name: "award_currency"
      expr: award_currency
      comment: "Currency in which the budget is denominated"
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Fund restriction classification for budget allocation"
    - name: "indirect_cost_base"
      expr: indirect_cost_base
      comment: "Base used for calculating indirect costs (MTDC, TDC, etc.)"
    - name: "cost_share_required"
      expr: cost_share_required
      comment: "Whether cost share is required for this budget period"
    - name: "is_amendment"
      expr: is_amendment
      comment: "Whether this budget is part of an amendment"
    - name: "budget_year"
      expr: YEAR(budget_period_start_date)
      comment: "Calendar year of budget period start"
    - name: "budget_period_month"
      expr: DATE_TRUNC('MONTH', budget_period_start_date)
      comment: "Month of budget period start for time-series analysis"
    - name: "approval_year"
      expr: YEAR(donor_approval_date)
      comment: "Calendar year of donor budget approval"
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_budget AS DOUBLE))
      comment: "Total approved budget amount across all budget periods"
    - name: "total_direct_costs"
      expr: SUM(CAST(total_direct_costs AS DOUBLE))
      comment: "Total direct costs across all budgets"
    - name: "total_indirect_costs"
      expr: SUM(CAST(total_indirect_costs AS DOUBLE))
      comment: "Total indirect costs across all budgets"
    - name: "total_personnel_costs"
      expr: SUM(CAST(personnel_costs AS DOUBLE))
      comment: "Total personnel/salary costs budgeted"
    - name: "total_fringe_benefits_costs"
      expr: SUM(CAST(fringe_benefits_costs AS DOUBLE))
      comment: "Total fringe benefits costs budgeted"
    - name: "total_travel_costs"
      expr: SUM(CAST(travel_costs AS DOUBLE))
      comment: "Total travel costs budgeted"
    - name: "total_equipment_costs"
      expr: SUM(CAST(equipment_costs AS DOUBLE))
      comment: "Total equipment costs budgeted"
    - name: "total_supplies_costs"
      expr: SUM(CAST(supplies_costs AS DOUBLE))
      comment: "Total supplies costs budgeted"
    - name: "total_contractual_costs"
      expr: SUM(CAST(contractual_costs AS DOUBLE))
      comment: "Total contractual/subaward costs budgeted"
    - name: "total_other_direct_costs"
      expr: SUM(CAST(other_direct_costs AS DOUBLE))
      comment: "Total other direct costs budgeted"
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost share amount committed in budgets"
    - name: "avg_nicra_rate_applied"
      expr: AVG(CAST(nicra_rate_applied AS DOUBLE))
      comment: "Average NICRA indirect cost rate applied across budgets"
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(total_indirect_costs AS DOUBLE) / NULLIF(CAST(total_direct_costs AS DOUBLE), 0))
      comment: "Average effective indirect cost rate (indirect divided by direct costs)"
    - name: "personnel_cost_ratio"
      expr: AVG(CAST(personnel_costs AS DOUBLE) / NULLIF(CAST(total_direct_costs AS DOUBLE), 0))
      comment: "Average personnel costs as percentage of total direct costs"
    - name: "budget_count"
      expr: COUNT(DISTINCT award_budget_id)
      comment: "Distinct count of award budgets"
    - name: "approved_budget_count"
      expr: COUNT(DISTINCT CASE WHEN budget_status = 'Approved' THEN award_budget_id END)
      comment: "Count of budgets in approved status"
    - name: "amendment_budget_count"
      expr: COUNT(DISTINCT CASE WHEN is_amendment = TRUE THEN award_budget_id END)
      comment: "Count of budgets that are amendments"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`grant_award_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed budget line item metrics tracking expenditures, variances, and compliance at the granular cost category level for grant financial management"
  source: "`ngo_ecm`.`grant`.`award_budget_line`"
  dimensions:
    - name: "budget_line_status"
      expr: budget_line_status
      comment: "Current status of the budget line item"
    - name: "cost_category"
      expr: cost_category
      comment: "Primary cost category classification (personnel, travel, equipment, etc.)"
    - name: "cost_subcategory"
      expr: cost_subcategory
      comment: "Detailed cost subcategory within primary category"
    - name: "donor_reporting_category"
      expr: donor_reporting_category
      comment: "Donor-specific reporting category for financial reports"
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Fund restriction type for this budget line"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for budget line amounts"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget line"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period within the year"
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account code for financial system integration"
    - name: "allowability_flag"
      expr: allowability_flag
      comment: "Whether the cost is allowable under grant terms"
    - name: "allocability_flag"
      expr: allocability_flag
      comment: "Whether the cost is allocable to the grant"
    - name: "reasonableness_flag"
      expr: reasonableness_flag
      comment: "Whether the cost is reasonable per regulatory standards"
    - name: "cost_share_required_flag"
      expr: cost_share_required_flag
      comment: "Whether cost share is required for this line item"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Calendar year of line item approval"
    - name: "revision_year"
      expr: YEAR(revision_date)
      comment: "Calendar year of line item revision"
  measures:
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved amount across all budget lines in local currency"
    - name: "total_approved_amount_usd"
      expr: SUM(CAST(approved_amount_usd AS DOUBLE))
      comment: "Total approved amount in USD for consolidated reporting"
    - name: "total_revised_amount"
      expr: SUM(CAST(revised_amount AS DOUBLE))
      comment: "Total revised amount after budget modifications"
    - name: "total_revised_amount_usd"
      expr: SUM(CAST(revised_amount_usd AS DOUBLE))
      comment: "Total revised amount in USD"
    - name: "total_cumulative_expenditure"
      expr: SUM(CAST(cumulative_expenditure AS DOUBLE))
      comment: "Total cumulative expenditure to date across all budget lines"
    - name: "total_cumulative_expenditure_usd"
      expr: SUM(CAST(cumulative_expenditure_usd AS DOUBLE))
      comment: "Total cumulative expenditure in USD"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between approved and actual expenditure"
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost share amount across budget lines"
    - name: "total_indirect_cost_amount"
      expr: SUM(CAST(indirect_cost_amount AS DOUBLE))
      comment: "Total indirect costs allocated to budget lines"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across budget lines"
    - name: "avg_nicra_rate_applied"
      expr: AVG(CAST(nicra_rate_applied AS DOUBLE))
      comment: "Average NICRA rate applied to budget lines"
    - name: "budget_utilization_rate"
      expr: AVG(CAST(cumulative_expenditure AS DOUBLE) / NULLIF(CAST(approved_amount AS DOUBLE), 0))
      comment: "Average budget utilization rate (expenditure divided by approved amount)"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across budget line items"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of units across budget lines"
    - name: "budget_line_count"
      expr: COUNT(DISTINCT award_budget_line_id)
      comment: "Distinct count of budget line items"
    - name: "allowable_line_count"
      expr: COUNT(DISTINCT CASE WHEN allowability_flag = TRUE THEN award_budget_line_id END)
      comment: "Count of budget lines flagged as allowable"
    - name: "allocable_line_count"
      expr: COUNT(DISTINCT CASE WHEN allocability_flag = TRUE THEN award_budget_line_id END)
      comment: "Count of budget lines flagged as allocable"
    - name: "reasonable_line_count"
      expr: COUNT(DISTINCT CASE WHEN reasonableness_flag = TRUE THEN award_budget_line_id END)
      comment: "Count of budget lines flagged as reasonable"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`grant_cost_share_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost share commitment and compliance metrics tracking committed, verified, and variance amounts for mandatory and voluntary cost sharing requirements"
  source: "`ngo_ecm`.`grant`.`cost_share_commitment`"
  dimensions:
    - name: "commitment_status"
      expr: commitment_status
      comment: "Current status of the cost share commitment"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the cost share commitment"
    - name: "cost_share_type"
      expr: cost_share_type
      comment: "Type of cost share (cash, in-kind, volunteer time, etc.)"
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category of the cost share contribution"
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the cost share is mandatory per award terms"
    - name: "is_restricted_fund"
      expr: is_restricted_fund
      comment: "Whether the cost share comes from restricted funds"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for cost share amounts"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the cost share commitment"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period within the year"
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify cost share contribution"
    - name: "in_kind_valuation_method"
      expr: in_kind_valuation_method
      comment: "Method used to value in-kind contributions"
    - name: "commitment_year"
      expr: YEAR(commitment_date)
      comment: "Calendar year of cost share commitment"
    - name: "verification_year"
      expr: YEAR(verification_date)
      comment: "Calendar year of cost share verification"
  measures:
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total cost share amount committed across all commitments"
    - name: "total_required_cost_share_amount"
      expr: SUM(CAST(required_cost_share_amount AS DOUBLE))
      comment: "Total required cost share amount per award terms"
    - name: "total_verified_amount"
      expr: SUM(CAST(verified_amount AS DOUBLE))
      comment: "Total cost share amount verified and documented"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between committed and verified cost share"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage between committed and verified amounts"
    - name: "avg_required_cost_share_percentage"
      expr: AVG(CAST(required_cost_share_percentage AS DOUBLE))
      comment: "Average required cost share percentage across commitments"
    - name: "cost_share_fulfillment_rate"
      expr: AVG(CAST(verified_amount AS DOUBLE) / NULLIF(CAST(committed_amount AS DOUBLE), 0))
      comment: "Average fulfillment rate of cost share commitments (verified divided by committed)"
    - name: "total_volunteer_hours"
      expr: SUM(CAST(volunteer_hours AS DOUBLE))
      comment: "Total volunteer hours contributed as cost share"
    - name: "avg_volunteer_hourly_rate"
      expr: AVG(CAST(volunteer_hourly_rate AS DOUBLE))
      comment: "Average hourly rate used to value volunteer time"
    - name: "commitment_count"
      expr: COUNT(DISTINCT cost_share_commitment_id)
      comment: "Distinct count of cost share commitments"
    - name: "mandatory_commitment_count"
      expr: COUNT(DISTINCT CASE WHEN is_mandatory = TRUE THEN cost_share_commitment_id END)
      comment: "Count of mandatory cost share commitments"
    - name: "verified_commitment_count"
      expr: COUNT(DISTINCT CASE WHEN verified_amount > 0 THEN cost_share_commitment_id END)
      comment: "Count of commitments with verified amounts"
    - name: "compliant_commitment_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_status = 'Compliant' THEN cost_share_commitment_id END)
      comment: "Count of commitments in compliant status"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`grant_donor_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor reporting metrics tracking submission timeliness, financial reporting, performance indicators, and compliance for grant accountability and transparency"
  source: "`ngo_ecm`.`grant`.`donor_report`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Current status of the donor report (draft, submitted, accepted, revision requested)"
    - name: "report_type"
      expr: report_type
      comment: "Type of donor report (financial, programmatic, combined, final)"
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Required reporting frequency (monthly, quarterly, annual)"
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the report (portal, email, mail)"
    - name: "financial_currency"
      expr: financial_currency
      comment: "Currency used for financial reporting"
    - name: "is_overdue"
      expr: is_overdue
      comment: "Whether the report submission is overdue"
    - name: "is_final_version"
      expr: is_final_version
      comment: "Whether this is the final version of the report"
    - name: "compliance_certification_flag"
      expr: compliance_certification_flag
      comment: "Whether compliance certification was provided"
    - name: "reporting_period_year"
      expr: YEAR(reporting_period_start_date)
      comment: "Calendar year of reporting period start"
    - name: "reporting_period_quarter"
      expr: QUARTER(reporting_period_start_date)
      comment: "Calendar quarter of reporting period start"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Calendar year of report submission"
    - name: "acceptance_year"
      expr: YEAR(donor_acceptance_date)
      comment: "Calendar year of donor acceptance"
  measures:
    - name: "total_financial_amount_reported"
      expr: SUM(CAST(financial_amount_reported AS DOUBLE))
      comment: "Total financial amount reported across all donor reports in local currency"
    - name: "total_financial_amount_reported_usd"
      expr: SUM(CAST(financial_amount_reported_usd AS DOUBLE))
      comment: "Total financial amount reported in USD for consolidated analysis"
    - name: "total_cumulative_expenditure_to_date"
      expr: SUM(CAST(cumulative_expenditure_to_date AS DOUBLE))
      comment: "Total cumulative expenditure reported to date"
    - name: "total_budget_variance_amount"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total budget variance amount reported"
    - name: "avg_budget_variance_percentage"
      expr: AVG(CAST(budget_variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage across reports"
    - name: "avg_days_overdue"
      expr: AVG(CAST(days_overdue AS DOUBLE))
      comment: "Average number of days reports are overdue"
    - name: "avg_kpi_achievement_rate"
      expr: AVG(CAST(key_performance_indicators_met AS DOUBLE) / NULLIF(CAST(key_performance_indicators_total AS DOUBLE), 0))
      comment: "Average KPI achievement rate (indicators met divided by total indicators)"
    - name: "total_audit_findings_count"
      expr: SUM(CAST(audit_findings_count AS DOUBLE))
      comment: "Total count of audit findings reported"
    - name: "avg_exchange_rate_used"
      expr: AVG(CAST(exchange_rate_used AS DOUBLE))
      comment: "Average exchange rate used for financial reporting"
    - name: "report_count"
      expr: COUNT(DISTINCT donor_report_id)
      comment: "Distinct count of donor reports"
    - name: "submitted_report_count"
      expr: COUNT(DISTINCT CASE WHEN report_status = 'Submitted' THEN donor_report_id END)
      comment: "Count of reports in submitted status"
    - name: "accepted_report_count"
      expr: COUNT(DISTINCT CASE WHEN donor_acceptance_date IS NOT NULL THEN donor_report_id END)
      comment: "Count of reports accepted by donor"
    - name: "overdue_report_count"
      expr: COUNT(DISTINCT CASE WHEN is_overdue = TRUE THEN donor_report_id END)
      comment: "Count of reports that are overdue"
    - name: "certified_report_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_certification_flag = TRUE THEN donor_report_id END)
      comment: "Count of reports with compliance certification"
    - name: "on_time_submission_rate"
      expr: AVG(CASE WHEN is_overdue = FALSE THEN 1.0 ELSE 0.0 END)
      comment: "Percentage of reports submitted on time"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`grant_subaward`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subaward financial and performance metrics tracking obligations, disbursements, remaining balances, and partner risk for subrecipient management and compliance"
  source: "`ngo_ecm`.`grant`.`award`"
  dimensions:
    - name: "currency"
      expr: currency
      comment: "Currency of the subaward"
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Fund restriction type for the subaward"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for disbursements (wire, check, ACH)"
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Required reporting frequency from subrecipient"
    - name: "closeout_year"
      expr: YEAR(closeout_date)
      comment: "Calendar year of subaward closeout"
  measures:
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost share amount required from subrecipients"
    - name: "avg_amendment_count"
      expr: AVG(CAST(amendment_count AS DOUBLE))
      comment: "Average number of amendments per subaward"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`grant_sub_award_disbursement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subaward disbursement transaction metrics tracking payment amounts, liquidation status, advance balances, and disbursement timeliness for cash management and compliance"
  source: "`ngo_ecm`.`grant`.`sub_award_disbursement`"
  dimensions:
    - name: "disbursement_status"
      expr: disbursement_status
      comment: "Current status of the disbursement (pending, approved, paid, cancelled)"
    - name: "disbursement_type"
      expr: disbursement_type
      comment: "Type of disbursement (advance, reimbursement, final payment)"
    - name: "disbursement_method"
      expr: disbursement_method
      comment: "Method used for disbursement (wire transfer, check, ACH)"
    - name: "disbursement_currency"
      expr: disbursement_currency
      comment: "Currency of the disbursement"
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category of the disbursement"
    - name: "donor_reporting_category"
      expr: donor_reporting_category
      comment: "Donor reporting category for the disbursement"
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Fund restriction type for the disbursement"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the disbursement"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period within the year"
    - name: "liquidation_status"
      expr: liquidation_status
      comment: "Status of advance liquidation (pending, partial, complete)"
    - name: "is_emergency_disbursement"
      expr: is_emergency_disbursement
      comment: "Whether this is an emergency disbursement"
    - name: "disbursement_year"
      expr: YEAR(disbursement_date)
      comment: "Calendar year of disbursement"
    - name: "disbursement_month"
      expr: DATE_TRUNC('MONTH', disbursement_date)
      comment: "Month of disbursement for time-series analysis"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Calendar year of disbursement approval"
  measures:
    - name: "total_disbursement_amount"
      expr: SUM(CAST(disbursement_amount AS DOUBLE))
      comment: "Total disbursement amount across all transactions in local currency"
    - name: "total_disbursement_amount_usd"
      expr: SUM(CAST(disbursement_amount_usd AS DOUBLE))
      comment: "Total disbursement amount in USD for consolidated reporting"
    - name: "total_net_disbursement_amount"
      expr: SUM(CAST(net_disbursement_amount AS DOUBLE))
      comment: "Total net disbursement amount after withholdings"
    - name: "total_withholding_amount"
      expr: SUM(CAST(withholding_amount AS DOUBLE))
      comment: "Total amount withheld from disbursements"
    - name: "total_liquidated_amount"
      expr: SUM(CAST(liquidated_amount AS DOUBLE))
      comment: "Total amount liquidated from advances"
    - name: "total_advance_balance_outstanding"
      expr: SUM(CAST(advance_balance_outstanding AS DOUBLE))
      comment: "Total outstanding advance balance across all disbursements"
    - name: "total_indirect_cost_amount"
      expr: SUM(CAST(indirect_cost_amount AS DOUBLE))
      comment: "Total indirect costs included in disbursements"
    - name: "avg_disbursement_amount"
      expr: AVG(CAST(disbursement_amount AS DOUBLE))
      comment: "Average disbursement amount per transaction"
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate used for disbursements"
    - name: "avg_nicra_rate_applied"
      expr: AVG(CAST(nicra_rate_applied AS DOUBLE))
      comment: "Average NICRA rate applied to disbursements"
    - name: "liquidation_rate"
      expr: AVG(CAST(liquidated_amount AS DOUBLE) / NULLIF(CAST(disbursement_amount AS DOUBLE), 0))
      comment: "Average liquidation rate for advance disbursements"
    - name: "withholding_rate"
      expr: AVG(CAST(withholding_amount AS DOUBLE) / NULLIF(CAST(disbursement_amount AS DOUBLE), 0))
      comment: "Average withholding rate as percentage of disbursement"
    - name: "disbursement_count"
      expr: COUNT(DISTINCT sub_award_disbursement_id)
      comment: "Distinct count of disbursement transactions"
    - name: "paid_disbursement_count"
      expr: COUNT(DISTINCT CASE WHEN disbursement_status = 'Paid' THEN sub_award_disbursement_id END)
      comment: "Count of disbursements in paid status"
    - name: "advance_disbursement_count"
      expr: COUNT(DISTINCT CASE WHEN disbursement_type = 'Advance' THEN sub_award_disbursement_id END)
      comment: "Count of advance-type disbursements"
    - name: "emergency_disbursement_count"
      expr: COUNT(DISTINCT CASE WHEN is_emergency_disbursement = TRUE THEN sub_award_disbursement_id END)
      comment: "Count of emergency disbursements"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`grant_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Proposal pipeline and win/loss metrics tracking requested funding, proposal outcomes, cost competitiveness, and business development performance for resource mobilization"
  source: "`ngo_ecm`.`grant`.`proposal`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current status of the proposal (draft, submitted, under review, awarded, rejected)"
    - name: "proposal_type"
      expr: proposal_type
      comment: "Type of proposal (solicited, unsolicited, concept note, full proposal)"
    - name: "win_loss_outcome"
      expr: win_loss_outcome
      comment: "Final outcome of the proposal (won, lost, withdrawn, pending)"
    - name: "go_no_go_decision"
      expr: go_no_go_decision
      comment: "Internal go/no-go decision for proposal pursuit"
    - name: "requested_currency"
      expr: requested_currency
      comment: "Currency of the requested amount"
    - name: "lead_technical_sector"
      expr: lead_technical_sector
      comment: "Primary technical sector of the proposal"
    - name: "geographic_focus"
      expr: geographic_focus
      comment: "Geographic focus area of the proposal"
    - name: "partnership_model"
      expr: partnership_model
      comment: "Partnership model (prime, sub, consortium)"
    - name: "compliance_review_completed"
      expr: compliance_review_completed
      comment: "Whether compliance review was completed"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Calendar year of proposal submission"
    - name: "submission_quarter"
      expr: QUARTER(submission_date)
      comment: "Calendar quarter of proposal submission"
    - name: "award_notification_year"
      expr: YEAR(award_notification_date)
      comment: "Calendar year of award notification"
  measures:
    - name: "total_requested_amount"
      expr: SUM(CAST(requested_amount AS DOUBLE))
      comment: "Total funding amount requested across all proposals in local currency"
    - name: "total_requested_amount_usd"
      expr: SUM(CAST(requested_amount_usd AS DOUBLE))
      comment: "Total funding amount requested in USD for consolidated pipeline analysis"
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost share amount proposed across all proposals"
    - name: "avg_requested_amount"
      expr: AVG(CAST(requested_amount AS DOUBLE))
      comment: "Average requested amount per proposal"
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost share percentage proposed"
    - name: "avg_indirect_cost_rate_proposed"
      expr: AVG(CAST(indirect_cost_rate_proposed AS DOUBLE))
      comment: "Average indirect cost rate proposed across proposals"
    - name: "avg_proposed_duration_months"
      expr: AVG(CAST(proposed_duration_months AS DOUBLE))
      comment: "Average proposed project duration in months"
    - name: "proposal_count"
      expr: COUNT(DISTINCT proposal_id)
      comment: "Distinct count of proposals"
    - name: "submitted_proposal_count"
      expr: COUNT(DISTINCT CASE WHEN proposal_status = 'Submitted' THEN proposal_id END)
      comment: "Count of proposals in submitted status"
    - name: "won_proposal_count"
      expr: COUNT(DISTINCT CASE WHEN win_loss_outcome = 'Won' THEN proposal_id END)
      comment: "Count of proposals that were won"
    - name: "lost_proposal_count"
      expr: COUNT(DISTINCT CASE WHEN win_loss_outcome = 'Lost' THEN proposal_id END)
      comment: "Count of proposals that were lost"
    - name: "go_decision_count"
      expr: COUNT(DISTINCT CASE WHEN go_no_go_decision = 'Go' THEN proposal_id END)
      comment: "Count of proposals with go decision"
    - name: "win_rate"
      expr: AVG(CASE WHEN win_loss_outcome = 'Won' THEN 1.0 ELSE 0.0 END)
      comment: "Win rate percentage (won proposals divided by total decided proposals)"
    - name: "compliance_review_completion_rate"
      expr: AVG(CASE WHEN compliance_review_completed = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Percentage of proposals with completed compliance review"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`grant_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant amendment metrics tracking funding changes, period extensions, scope modifications, and amendment approval cycles for adaptive grant management"
  source: "`ngo_ecm`.`grant`.`grant_amendment`"
  dimensions:
    - name: "amendment_number"
      expr: amendment_number
      comment: "Sequential amendment number for the award"
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the amendment (draft, submitted, approved, rejected)"
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (budget, scope, period, personnel, other)"
    - name: "is_no_cost_extension"
      expr: is_no_cost_extension
      comment: "Whether this is a no-cost extension amendment"
    - name: "donor_prior_approval_required"
      expr: donor_prior_approval_required
      comment: "Whether donor prior approval was required"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for amendment amounts"
    - name: "request_year"
      expr: YEAR(request_date)
      comment: "Calendar year of amendment request"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Calendar year of amendment approval"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Calendar year of amendment effective date"
  measures:
    - name: "total_funding_change"
      expr: SUM(CAST(funding_change AS DOUBLE))
      comment: "Total funding change amount across all amendments (positive or negative)"
    - name: "total_original_obligation"
      expr: SUM(CAST(original_total_obligation AS DOUBLE))
      comment: "Total original obligation amount before amendments"
    - name: "total_revised_obligation"
      expr: SUM(CAST(revised_total_obligation AS DOUBLE))
      comment: "Total revised obligation amount after amendments"
    - name: "avg_funding_change"
      expr: AVG(CAST(funding_change AS DOUBLE))
      comment: "Average funding change per amendment"
    - name: "avg_period_extension_days"
      expr: AVG(CAST(period_extension_days AS DOUBLE))
      comment: "Average number of days extended per amendment"
    - name: "total_period_extension_days"
      expr: SUM(CAST(period_extension_days AS DOUBLE))
      comment: "Total days extended across all amendments"
    - name: "amendment_count"
      expr: COUNT(DISTINCT grant_amendment_id)
      comment: "Distinct count of grant amendments"
    - name: "approved_amendment_count"
      expr: COUNT(DISTINCT CASE WHEN amendment_status = 'Approved' THEN grant_amendment_id END)
      comment: "Count of amendments in approved status"
    - name: "no_cost_extension_count"
      expr: COUNT(DISTINCT CASE WHEN is_no_cost_extension = TRUE THEN grant_amendment_id END)
      comment: "Count of no-cost extension amendments"
    - name: "prior_approval_required_count"
      expr: COUNT(DISTINCT CASE WHEN donor_prior_approval_required = TRUE THEN grant_amendment_id END)
      comment: "Count of amendments requiring donor prior approval"
    - name: "funding_increase_count"
      expr: COUNT(DISTINCT CASE WHEN funding_change > 0 THEN grant_amendment_id END)
      comment: "Count of amendments that increased funding"
    - name: "funding_decrease_count"
      expr: COUNT(DISTINCT CASE WHEN funding_change < 0 THEN grant_amendment_id END)
      comment: "Count of amendments that decreased funding"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`grant_donor_condition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor condition compliance metrics tracking special award conditions, deliverable completion, compliance status, and risk escalation for grant oversight and accountability"
  source: "`ngo_ecm`.`grant`.`donor_condition`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the donor condition (compliant, non-compliant, pending, waived)"
    - name: "condition_type"
      expr: condition_type
      comment: "Type of donor condition (financial, programmatic, reporting, administrative)"
    - name: "condition_category"
      expr: condition_category
      comment: "Category classification of the condition"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the condition (low, medium, high, critical)"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating associated with non-compliance"
    - name: "is_special_award_condition"
      expr: is_special_award_condition
      comment: "Whether this is a special award condition (SAC)"
    - name: "recurrence_frequency"
      expr: recurrence_frequency
      comment: "Frequency of recurring condition (one-time, monthly, quarterly, annual)"
    - name: "monitoring_frequency"
      expr: monitoring_frequency
      comment: "Required monitoring frequency for the condition"
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for condition compliance"
    - name: "due_year"
      expr: YEAR(due_date)
      comment: "Calendar year of condition due date"
    - name: "completion_year"
      expr: YEAR(actual_completion_date)
      comment: "Calendar year of actual completion"
  measures:
    - name: "total_financial_threshold_amount"
      expr: SUM(CAST(financial_threshold_amount AS DOUBLE))
      comment: "Total financial threshold amounts across conditions"
    - name: "avg_escalation_threshold_days"
      expr: AVG(CAST(escalation_threshold_days AS DOUBLE))
      comment: "Average escalation threshold in days for overdue conditions"
    - name: "condition_count"
      expr: COUNT(DISTINCT donor_condition_id)
      comment: "Distinct count of donor conditions"
    - name: "compliant_condition_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_status = 'Compliant' THEN donor_condition_id END)
      comment: "Count of conditions in compliant status"
    - name: "non_compliant_condition_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_status = 'Non-Compliant' THEN donor_condition_id END)
      comment: "Count of conditions in non-compliant status"
    - name: "special_award_condition_count"
      expr: COUNT(DISTINCT CASE WHEN is_special_award_condition = TRUE THEN donor_condition_id END)
      comment: "Count of special award conditions (SACs)"
    - name: "high_priority_condition_count"
      expr: COUNT(DISTINCT CASE WHEN priority_level = 'High' THEN donor_condition_id END)
      comment: "Count of high-priority conditions"
    - name: "critical_priority_condition_count"
      expr: COUNT(DISTINCT CASE WHEN priority_level = 'Critical' THEN donor_condition_id END)
      comment: "Count of critical-priority conditions"
    - name: "high_risk_condition_count"
      expr: COUNT(DISTINCT CASE WHEN risk_rating = 'High' THEN donor_condition_id END)
      comment: "Count of conditions with high risk rating"
    - name: "completed_condition_count"
      expr: COUNT(DISTINCT CASE WHEN actual_completion_date IS NOT NULL THEN donor_condition_id END)
      comment: "Count of conditions that have been completed"
    - name: "waived_condition_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_status = 'Waived' THEN donor_condition_id END)
      comment: "Count of conditions that have been waived"
    - name: "compliance_rate"
      expr: AVG(CASE WHEN compliance_status = 'Compliant' THEN 1.0 ELSE 0.0 END)
      comment: "Percentage of conditions in compliant status"
$$;