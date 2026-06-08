-- Metric views for domain: research | Business: Education | Version: 1 | Generated on: 2026-05-06 15:08:33

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`research_award`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for research awards — tracks portfolio size, funding volume, cost-sharing commitments, and award lifecycle health. Used by VPs of Research and department chairs to steer grant strategy and resource allocation."
  source: "`education_ecm`.`research`.`research_award`"
  dimensions:
    - name: "award_status"
      expr: award_status
      comment: "Current lifecycle status of the award (e.g., Active, Closed, Pending) — primary filter for portfolio health dashboards."
    - name: "award_type"
      expr: award_type
      comment: "Classification of the award instrument (e.g., Grant, Contract, Cooperative Agreement) — used to segment funding portfolio by mechanism."
    - name: "activity_type"
      expr: activity_type
      comment: "Research activity category (e.g., Research, Training, Fellowship) — enables analysis of funding mix by activity."
    - name: "payment_method"
      expr: payment_method
      comment: "Sponsor payment mechanism (e.g., Letter of Credit, Reimbursement) — relevant for cash-flow planning."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "How often financial/progress reports are due to the sponsor — used to manage compliance workload."
    - name: "cfda_number"
      expr: cfda_number
      comment: "Catalog of Federal Domestic Assistance number — identifies the federal program funding the award for regulatory reporting."
    - name: "no_cost_extension_flag"
      expr: no_cost_extension_flag
      comment: "Indicates whether a no-cost extension has been granted — used to track awards requiring timeline adjustments."
    - name: "cost_sharing_required_flag"
      expr: cost_sharing_required_flag
      comment: "Whether the sponsor requires institutional cost sharing — drives cost-sharing commitment tracking."
    - name: "human_subjects_approval_required_flag"
      expr: human_subjects_approval_required_flag
      comment: "Whether IRB approval is required — used to flag compliance-sensitive awards."
    - name: "project_start_year"
      expr: YEAR(project_start_date)
      comment: "Year the award project period begins — enables cohort analysis of award vintages."
    - name: "project_end_year"
      expr: YEAR(project_end_date)
      comment: "Year the award project period ends — used to identify awards approaching closeout."
    - name: "budget_start_year"
      expr: YEAR(budget_start_date)
      comment: "Fiscal year the current budget period begins — used for annual funding trend analysis."
  measures:
    - name: "total_awards"
      expr: COUNT(1)
      comment: "Total number of research awards in the portfolio — baseline KPI for portfolio size used in executive dashboards."
    - name: "active_awards"
      expr: COUNT(CASE WHEN award_status = 'Active' THEN 1 END)
      comment: "Number of currently active awards — primary indicator of research portfolio health and capacity."
    - name: "total_award_funding"
      expr: SUM(CAST(total_award_amount AS DOUBLE))
      comment: "Total dollar value of all awards — top-line research revenue metric used in board and VPR reporting."
    - name: "total_direct_costs"
      expr: SUM(CAST(direct_cost_amount AS DOUBLE))
      comment: "Sum of direct costs across all awards — measures programmatic research spending excluding overhead."
    - name: "total_indirect_costs"
      expr: SUM(CAST(indirect_cost_amount AS DOUBLE))
      comment: "Sum of indirect (F&A) cost recoveries across all awards — critical revenue stream for institutional operations."
    - name: "total_cost_sharing_committed"
      expr: SUM(CAST(cost_sharing_amount AS DOUBLE))
      comment: "Total institutional cost-sharing commitments across awards — tracks unfunded obligations that consume institutional resources."
    - name: "avg_award_amount"
      expr: AVG(CAST(total_award_amount AS DOUBLE))
      comment: "Average award size — used to benchmark award scale and identify shifts in sponsor funding levels."
    - name: "awards_with_no_cost_extension"
      expr: COUNT(CASE WHEN no_cost_extension_flag = TRUE THEN 1 END)
      comment: "Number of awards that have received a no-cost extension — indicator of project execution challenges or scope complexity."
    - name: "awards_requiring_human_subjects_approval"
      expr: COUNT(CASE WHEN human_subjects_approval_required_flag = TRUE THEN 1 END)
      comment: "Count of awards requiring IRB approval — used to size compliance review workload and risk exposure."
    - name: "awards_with_cost_sharing"
      expr: COUNT(CASE WHEN cost_sharing_required_flag = TRUE THEN 1 END)
      comment: "Number of awards with mandatory cost-sharing requirements — tracks institutional financial obligation exposure."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`research_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pre-award pipeline KPIs tracking proposal submissions, funding requests, win rates, and budget composition. Used by VPs of Research and department chairs to evaluate proposal strategy, sponsor targeting, and pipeline conversion."
  source: "`education_ecm`.`research`.`proposal`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current status of the proposal (e.g., Submitted, Awarded, Not Funded, Withdrawn) — primary dimension for pipeline funnel analysis."
    - name: "proposal_type"
      expr: proposal_type
      comment: "Type of proposal (e.g., New, Renewal, Supplement, Continuation) — used to distinguish new business from renewals."
    - name: "activity_type"
      expr: activity_type
      comment: "Research activity category of the proposed work — enables funding mix analysis by activity type."
    - name: "human_subjects_flag"
      expr: human_subjects_flag
      comment: "Whether the proposal involves human subjects research — used to assess IRB compliance pipeline."
    - name: "cost_sharing_required_flag"
      expr: cost_sharing_required_flag
      comment: "Whether the sponsor requires cost sharing — used to track proposals with institutional financial obligations."
    - name: "irb_approval_status"
      expr: irb_approval_status
      comment: "IRB approval status at time of proposal — used to monitor compliance readiness in the pre-award pipeline."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the proposal was submitted — enables year-over-year pipeline trend analysis."
    - name: "decision_year"
      expr: YEAR(decision_date)
      comment: "Year the sponsor made a funding decision — used to measure award cycle time and cohort win rates."
    - name: "budget_currency_code"
      expr: budget_currency_code
      comment: "Currency of the proposed budget — relevant for international sponsor proposals and multi-currency reporting."
  measures:
    - name: "total_proposals_submitted"
      expr: COUNT(1)
      comment: "Total number of proposals in the system — baseline pipeline volume metric for pre-award dashboards."
    - name: "proposals_awarded"
      expr: COUNT(CASE WHEN proposal_status = 'Awarded' THEN 1 END)
      comment: "Number of proposals that resulted in an award — numerator for win-rate calculation and pipeline conversion tracking."
    - name: "proposals_not_funded"
      expr: COUNT(CASE WHEN proposal_status = 'Not Funded' THEN 1 END)
      comment: "Number of proposals that were declined — used to analyze rejection patterns and refine sponsor targeting strategy."
    - name: "total_requested_budget"
      expr: SUM(CAST(requested_budget_amount AS DOUBLE))
      comment: "Total funding requested across all proposals — measures the gross value of the pre-award pipeline."
    - name: "total_direct_costs_requested"
      expr: SUM(CAST(direct_cost_amount AS DOUBLE))
      comment: "Sum of direct costs requested across proposals — used to assess programmatic funding demand."
    - name: "total_indirect_costs_requested"
      expr: SUM(CAST(indirect_cost_amount AS DOUBLE))
      comment: "Sum of indirect (F&A) costs requested across proposals — used to project potential overhead recovery from the pipeline."
    - name: "total_cost_sharing_requested"
      expr: SUM(CAST(cost_sharing_amount AS DOUBLE))
      comment: "Total cost-sharing amounts proposed — tracks potential institutional financial commitments in the pipeline."
    - name: "avg_requested_budget"
      expr: AVG(CAST(requested_budget_amount AS DOUBLE))
      comment: "Average proposal budget size — benchmarks proposal scale and identifies shifts in funding ask strategy."
    - name: "proposals_with_human_subjects"
      expr: COUNT(CASE WHEN human_subjects_flag = TRUE THEN 1 END)
      comment: "Number of proposals involving human subjects — used to forecast IRB review workload and compliance resource needs."
    - name: "proposals_with_cost_sharing"
      expr: COUNT(CASE WHEN cost_sharing_required_flag = TRUE THEN 1 END)
      comment: "Number of proposals requiring institutional cost sharing — tracks potential unfunded obligation exposure in the pipeline."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`research_expenditure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Post-award financial execution KPIs tracking research spending, IDC recovery, budget burn, and compliance flags. Used by research finance officers, VPs of Research, and sponsored programs offices to monitor award financial health."
  source: "`education_ecm`.`research`.`expenditure`"
  dimensions:
    - name: "expenditure_category"
      expr: expenditure_category
      comment: "Category of the expenditure (e.g., Personnel, Supplies, Travel, Equipment) — primary dimension for cost composition analysis."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Processing status of the transaction (e.g., Posted, Pending, Reversed) — used to filter to finalized expenditures."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the expenditure — enables year-over-year spending trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month) of the expenditure — used for monthly burn-rate monitoring."
    - name: "direct_cost_flag"
      expr: direct_cost_flag
      comment: "Whether the expenditure is a direct cost — used to separate direct vs. indirect cost analysis."
    - name: "cost_share_flag"
      expr: cost_share_flag
      comment: "Whether the expenditure is a cost-share transaction — used to track institutional cost-sharing fulfillment."
    - name: "allowable_flag"
      expr: allowable_flag
      comment: "Whether the expenditure is allowable under the award terms — key compliance dimension for audit risk analysis."
    - name: "allocable_flag"
      expr: allocable_flag
      comment: "Whether the expenditure is allocable to the award — used in compliance reviews and audit preparation."
    - name: "audit_flag"
      expr: audit_flag
      comment: "Whether the transaction has been flagged for audit review — used to monitor audit exposure."
    - name: "closeout_flag"
      expr: closeout_flag
      comment: "Whether the expenditure is part of award closeout processing — used to track closeout financial activity."
    - name: "transaction_date_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of the transaction date — enables monthly spending trend and burn-rate analysis."
    - name: "object_code"
      expr: object_code
      comment: "Chart-of-accounts object code for the expenditure — used for detailed cost category analysis aligned to financial reporting."
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total dollar amount of research expenditures — primary financial execution metric for award burn-rate monitoring."
    - name: "total_idc_amount"
      expr: SUM(CAST(idc_amount AS DOUBLE))
      comment: "Total indirect cost (F&A) charges generated — measures overhead recovery from research activity, a key institutional revenue metric."
    - name: "total_encumbrances"
      expr: SUM(CAST(encumbrance_amount AS DOUBLE))
      comment: "Total encumbered (committed but not yet spent) amounts — used to project future cash outflows and available balance."
    - name: "total_cumulative_expenditure"
      expr: SUM(CAST(cumulative_expenditure_to_date AS DOUBLE))
      comment: "Sum of cumulative expenditures to date across awards — used to assess overall award burn relative to total authorized budgets."
    - name: "total_available_balance"
      expr: SUM(CAST(available_balance AS DOUBLE))
      comment: "Total remaining available balance across award accounts — critical for identifying awards at risk of over-expenditure."
    - name: "avg_idc_rate"
      expr: AVG(CAST(idc_rate AS DOUBLE))
      comment: "Average IDC rate applied across expenditures — used to monitor effective overhead recovery rate vs. negotiated rates."
    - name: "flagged_expenditure_count"
      expr: COUNT(CASE WHEN audit_flag = TRUE THEN 1 END)
      comment: "Number of expenditures flagged for audit review — key compliance risk indicator for sponsored programs offices."
    - name: "unallowable_expenditure_count"
      expr: COUNT(CASE WHEN allowable_flag = FALSE THEN 1 END)
      comment: "Number of expenditures deemed unallowable under award terms — drives corrective action and sponsor disallowance risk."
    - name: "cost_share_expenditure_amount"
      expr: SUM(CASE WHEN cost_share_flag = TRUE THEN CAST(transaction_amount AS DOUBLE) ELSE 0 END)
      comment: "Total cost-sharing expenditures — measures fulfillment of institutional cost-sharing commitments to sponsors."
    - name: "direct_cost_expenditure_amount"
      expr: SUM(CASE WHEN direct_cost_flag = TRUE THEN CAST(transaction_amount AS DOUBLE) ELSE 0 END)
      comment: "Total direct cost expenditures — used to track programmatic spending separate from overhead charges."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`research_award_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget planning and variance KPIs for research awards — tracks authorized budgets, cost composition, and modification activity. Used by research finance and sponsored programs to monitor budget health and sponsor-approved funding levels."
  source: "`education_ecm`.`research`.`award_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget record (e.g., Approved, Pending, Revised) — primary filter for active budget analysis."
    - name: "budget_type"
      expr: budget_type
      comment: "Classification of the budget (e.g., Original, Revised, Supplement) — used to track budget modification history."
    - name: "budget_period_number"
      expr: budget_period_number
      comment: "Budget period identifier — enables multi-year award budget period comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget — relevant for international awards and multi-currency portfolio reporting."
    - name: "period_start_year"
      expr: YEAR(period_start_date)
      comment: "Year the budget period begins — used for annual budget trend analysis."
    - name: "approved_date_month"
      expr: DATE_TRUNC('MONTH', approved_date)
      comment: "Month the budget was approved — used to track budget approval cycle times."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total authorized budget across all award budget records — top-line budget portfolio metric for research finance reporting."
    - name: "total_sponsor_approved_amount"
      expr: SUM(CAST(sponsor_approved_amount AS DOUBLE))
      comment: "Total sponsor-approved funding — measures confirmed external funding commitments, the authoritative revenue ceiling."
    - name: "total_direct_costs_budgeted"
      expr: SUM(CAST(total_direct_costs AS DOUBLE))
      comment: "Total direct costs budgeted across awards — used to assess programmatic resource allocation."
    - name: "total_fa_costs_budgeted"
      expr: SUM(CAST(total_fa_costs AS DOUBLE))
      comment: "Total F&A (indirect) costs budgeted — measures projected overhead recovery from the award portfolio."
    - name: "total_personnel_costs_budgeted"
      expr: SUM(CAST(personnel_costs AS DOUBLE))
      comment: "Total personnel costs budgeted — largest cost category in research; used for workforce planning and effort certification."
    - name: "total_equipment_costs_budgeted"
      expr: SUM(CAST(equipment_costs AS DOUBLE))
      comment: "Total equipment costs budgeted — used for capital planning and MTDC base exclusion analysis."
    - name: "total_subcontract_costs_budgeted"
      expr: SUM(CAST(subcontract_costs AS DOUBLE))
      comment: "Total subcontract costs budgeted — used to track subaward financial exposure and MTDC exclusion thresholds."
    - name: "total_cost_sharing_budgeted"
      expr: SUM(CAST(cost_sharing_amount AS DOUBLE))
      comment: "Total cost-sharing amounts budgeted — tracks institutional financial commitments embedded in award budgets."
    - name: "total_unrecovered_fa"
      expr: SUM(CAST(unrecovered_fa_amount AS DOUBLE))
      comment: "Total unrecovered F&A amounts — measures foregone overhead recovery due to sponsor rate caps or waivers; a strategic cost metric."
    - name: "avg_budget_amount"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average award budget size — used to benchmark budget scale and identify outliers in the portfolio."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`research_award_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Award account financial health KPIs tracking balances, encumbrances, expenditures, and compliance flags at the account level. Used by sponsored programs officers and research finance to monitor account-level financial risk and closeout readiness."
  source: "`education_ecm`.`research`.`award_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the award account (e.g., Open, Closed, Suspended) — primary dimension for active portfolio monitoring."
    - name: "award_type"
      expr: award_type
      comment: "Type of award associated with the account — used to segment financial health by award mechanism."
    - name: "activity_type"
      expr: activity_type
      comment: "Research activity type for the account — enables cost analysis by activity category."
    - name: "export_control_flag"
      expr: export_control_flag
      comment: "Whether the account is subject to export control regulations — used to identify high-compliance-risk accounts."
    - name: "human_subjects_flag"
      expr: human_subjects_flag
      comment: "Whether the account involves human subjects research — used to flag accounts requiring IRB compliance monitoring."
    - name: "cost_sharing_account_flag"
      expr: cost_sharing_account_flag
      comment: "Whether this is a cost-sharing account — used to separate cost-share from direct award financial analysis."
    - name: "budget_currency_code"
      expr: budget_currency_code
      comment: "Currency of the account budget — relevant for multi-currency award portfolio reporting."
    - name: "account_open_year"
      expr: YEAR(account_open_date)
      comment: "Year the account was opened — used for cohort analysis of account vintages and lifecycle duration."
    - name: "project_end_year"
      expr: YEAR(project_end_date)
      comment: "Year the project period ends — used to identify accounts approaching closeout deadlines."
  measures:
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total number of award accounts — baseline portfolio size metric for sponsored programs management."
    - name: "total_authorized_budget"
      expr: SUM(CAST(total_authorized_budget AS DOUBLE))
      comment: "Total authorized budget across all award accounts — top-line funding authorization metric for the research portfolio."
    - name: "total_expenditures_to_date"
      expr: SUM(CAST(total_expenditures_to_date AS DOUBLE))
      comment: "Total cumulative expenditures across award accounts — measures overall research spending execution."
    - name: "total_available_balance"
      expr: SUM(CAST(available_balance AS DOUBLE))
      comment: "Total remaining available balance across accounts — critical for identifying accounts at risk of over-expenditure or with unspent funds at closeout."
    - name: "total_encumbrances"
      expr: SUM(CAST(total_encumbrances AS DOUBLE))
      comment: "Total encumbered amounts across award accounts — measures committed future spending for cash-flow and budget management."
    - name: "total_unrecovered_fa"
      expr: SUM(CAST(unrecovered_fa_amount AS DOUBLE))
      comment: "Total unrecovered F&A amounts across accounts — measures foregone overhead revenue due to sponsor rate caps or waivers."
    - name: "total_cost_sharing_amount"
      expr: SUM(CAST(cost_sharing_amount AS DOUBLE))
      comment: "Total cost-sharing amounts committed at the account level — tracks institutional financial obligations to sponsors."
    - name: "total_mtdc_base"
      expr: SUM(CAST(mtdc_base AS DOUBLE))
      comment: "Total Modified Total Direct Cost base across accounts — used to validate IDC recovery calculations and rate agreement compliance."
    - name: "export_control_account_count"
      expr: COUNT(CASE WHEN export_control_flag = TRUE THEN 1 END)
      comment: "Number of accounts subject to export control regulations — used to size compliance monitoring workload and risk exposure."
    - name: "accounts_with_human_subjects"
      expr: COUNT(CASE WHEN human_subjects_flag = TRUE THEN 1 END)
      comment: "Number of accounts involving human subjects research — used to forecast IRB compliance oversight requirements."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`research_subaward`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subaward portfolio KPIs tracking subrecipient financial commitments, monitoring risk, and compliance obligations. Used by sponsored programs and research compliance offices to manage pass-through funding and subrecipient monitoring requirements."
  source: "`education_ecm`.`research`.`subaward`"
  dimensions:
    - name: "subaward_status"
      expr: subaward_status
      comment: "Current status of the subaward (e.g., Active, Closed, Terminated) — primary dimension for active subaward portfolio monitoring."
    - name: "subaward_type"
      expr: subaward_type
      comment: "Type of subaward instrument (e.g., Subcontract, Subaward, Consulting Agreement) — used to segment pass-through portfolio by mechanism."
    - name: "monitoring_risk_level"
      expr: monitoring_risk_level
      comment: "Risk level assigned to the subrecipient (e.g., Low, Medium, High) — primary dimension for risk-based monitoring prioritization."
    - name: "single_audit_required"
      expr: single_audit_required
      comment: "Whether the subrecipient is subject to Single Audit requirements — used to identify high-compliance-obligation subawards."
    - name: "federal_flow_down_clauses_applicable"
      expr: federal_flow_down_clauses_applicable
      comment: "Whether federal flow-down clauses apply — used to identify subawards with heightened regulatory compliance requirements."
    - name: "cost_sharing_required"
      expr: cost_sharing_required
      comment: "Whether cost sharing is required from the subrecipient — used to track subrecipient cost-sharing obligations."
    - name: "invoicing_frequency"
      expr: invoicing_frequency
      comment: "How often the subrecipient invoices (e.g., Monthly, Quarterly) — used for cash-flow planning and invoice monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the subaward — relevant for international subrecipient agreements."
    - name: "period_of_performance_end_year"
      expr: YEAR(period_of_performance_end_date)
      comment: "Year the subaward period of performance ends — used to identify subawards approaching closeout."
    - name: "execution_year"
      expr: YEAR(execution_date)
      comment: "Year the subaward was executed — enables cohort analysis of subaward vintage and lifecycle."
  measures:
    - name: "total_subawards"
      expr: COUNT(1)
      comment: "Total number of subawards — baseline portfolio size metric for pass-through funding management."
    - name: "active_subawards"
      expr: COUNT(CASE WHEN subaward_status = 'Active' THEN 1 END)
      comment: "Number of currently active subawards — primary indicator of active subrecipient monitoring workload."
    - name: "total_subaward_amount"
      expr: SUM(CAST(total_subaward_amount AS DOUBLE))
      comment: "Total value of all subawards — measures total pass-through funding obligations, a key financial risk metric."
    - name: "total_executed_amount"
      expr: SUM(CAST(executed_amount AS DOUBLE))
      comment: "Total executed (contracted) subaward amounts — measures confirmed financial commitments to subrecipients."
    - name: "total_cost_sharing_amount"
      expr: SUM(CAST(cost_sharing_amount AS DOUBLE))
      comment: "Total cost-sharing amounts required from subrecipients — tracks pass-through cost-sharing obligations."
    - name: "high_risk_subaward_count"
      expr: COUNT(CASE WHEN monitoring_risk_level = 'High' THEN 1 END)
      comment: "Number of subawards classified as high monitoring risk — drives prioritization of subrecipient monitoring resources."
    - name: "single_audit_required_count"
      expr: COUNT(CASE WHEN single_audit_required = TRUE THEN 1 END)
      comment: "Number of subawards requiring Single Audit compliance — used to assess federal audit obligation exposure in the subaward portfolio."
    - name: "avg_subaward_amount"
      expr: AVG(CAST(total_subaward_amount AS DOUBLE))
      comment: "Average subaward value — benchmarks subrecipient engagement scale and identifies outlier commitments."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`research_compliance_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research compliance risk KPIs tracking event severity, financial impact, corrective action status, and systemic issues. Used by research compliance officers, VPs of Research, and audit committees to monitor regulatory risk and remediation effectiveness."
  source: "`education_ecm`.`research`.`compliance_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of compliance event (e.g., Audit Finding, Protocol Deviation, Export Control Violation) — primary dimension for compliance risk categorization."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the compliance event (e.g., Open, Closed, Under Review) — used to track open compliance obligations."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the compliance event (e.g., Critical, Major, Minor) — primary risk stratification dimension."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of the corrective action plan (e.g., In Progress, Completed, Overdue) — used to monitor remediation progress."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Final resolution status of the event — used to track closure rates and outstanding compliance obligations."
    - name: "audit_finding_flag"
      expr: audit_finding_flag
      comment: "Whether the event resulted from a formal audit finding — used to distinguish audit-driven vs. self-identified compliance issues."
    - name: "repeat_finding_flag"
      expr: repeat_finding_flag
      comment: "Whether this is a repeat compliance finding — critical indicator of systemic control weaknesses."
    - name: "systemic_issue_flag"
      expr: systemic_issue_flag
      comment: "Whether the event represents a systemic institutional issue — used to escalate findings requiring policy-level remediation."
    - name: "sponsor_notified_flag"
      expr: sponsor_notified_flag
      comment: "Whether the sponsor was notified of the compliance event — used to track regulatory notification obligations."
    - name: "event_year"
      expr: YEAR(event_date)
      comment: "Year the compliance event occurred — enables year-over-year compliance trend analysis."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month the compliance event occurred — used for monthly compliance incident monitoring."
  measures:
    - name: "total_compliance_events"
      expr: COUNT(1)
      comment: "Total number of compliance events — baseline compliance incident volume metric for risk dashboards."
    - name: "open_compliance_events"
      expr: COUNT(CASE WHEN event_status = 'Open' THEN 1 END)
      comment: "Number of currently open compliance events — primary indicator of unresolved compliance risk exposure."
    - name: "repeat_findings_count"
      expr: COUNT(CASE WHEN repeat_finding_flag = TRUE THEN 1 END)
      comment: "Number of repeat compliance findings — critical metric for identifying systemic control failures requiring institutional intervention."
    - name: "systemic_issue_count"
      expr: COUNT(CASE WHEN systemic_issue_flag = TRUE THEN 1 END)
      comment: "Number of events classified as systemic issues — used to prioritize policy-level remediation and board-level risk reporting."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of compliance events — quantifies monetary risk exposure from compliance failures for executive reporting."
    - name: "audit_finding_count"
      expr: COUNT(CASE WHEN audit_finding_flag = TRUE THEN 1 END)
      comment: "Number of events resulting from formal audit findings — used to track audit-driven compliance risk and remediation workload."
    - name: "overdue_corrective_actions"
      expr: COUNT(CASE WHEN corrective_action_status = 'Overdue' THEN 1 END)
      comment: "Number of compliance events with overdue corrective action plans — critical operational metric for compliance program effectiveness."
    - name: "sponsor_notified_count"
      expr: COUNT(CASE WHEN sponsor_notified_flag = TRUE THEN 1 END)
      comment: "Number of events where the sponsor was formally notified — used to track regulatory notification compliance obligations."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`research_principal_investigator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Principal investigator portfolio and eligibility KPIs tracking active funding, award counts, and compliance status. Used by VPs of Research and department chairs to evaluate PI productivity, eligibility, and conflict-of-interest compliance."
  source: "`education_ecm`.`research`.`principal_investigator`"
  dimensions:
    - name: "pi_status"
      expr: pi_status
      comment: "Current status of the PI (e.g., Active, Inactive, Emeritus) — primary dimension for active investigator portfolio analysis."
    - name: "pi_eligibility_status"
      expr: pi_eligibility_status
      comment: "Whether the PI is currently eligible to serve as PI on awards — used to monitor eligibility compliance."
    - name: "academic_rank"
      expr: academic_rank
      comment: "Academic rank of the PI (e.g., Assistant Professor, Associate Professor, Full Professor) — used to analyze funding productivity by career stage."
    - name: "appointment_type"
      expr: appointment_type
      comment: "Type of faculty appointment (e.g., Tenure-Track, Research, Clinical) — used to segment PI portfolio by appointment category."
    - name: "tenure_status"
      expr: tenure_status
      comment: "Tenure status of the PI — used to analyze research productivity and funding patterns by tenure track."
    - name: "college_school_name"
      expr: college_school_name
      comment: "College or school the PI is affiliated with — primary organizational dimension for research portfolio analysis."
    - name: "primary_research_area"
      expr: primary_research_area
      comment: "Primary research discipline of the PI — used to analyze funding distribution across research areas."
    - name: "conflict_of_interest_disclosure_status"
      expr: conflict_of_interest_disclosure_status
      comment: "Status of the PI's conflict-of-interest disclosure — used to monitor COI compliance across the investigator population."
    - name: "federal_debarment_check_status"
      expr: federal_debarment_check_status
      comment: "Status of the federal debarment check — used to ensure all PIs are cleared for federal award eligibility."
    - name: "effort_certification_eligible_flag"
      expr: effort_certification_eligible_flag
      comment: "Whether the PI is eligible for effort certification — used to manage effort reporting compliance obligations."
  measures:
    - name: "total_principal_investigators"
      expr: COUNT(1)
      comment: "Total number of principal investigators in the system — baseline workforce metric for research capacity planning."
    - name: "eligible_principal_investigators"
      expr: COUNT(CASE WHEN pi_eligibility_status = 'Eligible' THEN 1 END)
      comment: "Number of PIs currently eligible to serve as PI — measures available research leadership capacity."
    - name: "total_active_funding"
      expr: SUM(CAST(total_active_funding_amount AS DOUBLE))
      comment: "Total active funding amount across all PIs — measures aggregate research portfolio value by investigator population."
    - name: "avg_active_funding_per_pi"
      expr: AVG(CAST(total_active_funding_amount AS DOUBLE))
      comment: "Average active funding per PI — benchmarks investigator productivity and identifies funding concentration risk."
    - name: "pis_with_coi_disclosure_pending"
      expr: COUNT(CASE WHEN conflict_of_interest_disclosure_status = 'Pending' THEN 1 END)
      comment: "Number of PIs with outstanding COI disclosures — critical compliance metric for federal award eligibility and institutional policy."
    - name: "pis_with_debarment_check_pending"
      expr: COUNT(CASE WHEN federal_debarment_check_status = 'Pending' THEN 1 END)
      comment: "Number of PIs with outstanding federal debarment checks — used to ensure all investigators are cleared for federal funding."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`research_irb_protocol`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IRB protocol portfolio KPIs tracking human subjects research approvals, risk levels, enrollment, and compliance status. Used by IRB administrators, research compliance officers, and VPs of Research to manage human subjects research oversight."
  source: "`education_ecm`.`research`.`irb_protocol`"
  dimensions:
    - name: "protocol_status"
      expr: protocol_status
      comment: "Current status of the IRB protocol (e.g., Approved, Expired, Closed, Suspended) — primary dimension for active protocol portfolio monitoring."
    - name: "review_category"
      expr: review_category
      comment: "IRB review category (e.g., Exempt, Expedited, Full Board) — used to segment protocols by regulatory review burden."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the protocol (e.g., Minimal Risk, Greater Than Minimal Risk) — primary risk stratification dimension for IRB oversight."
    - name: "study_type"
      expr: study_type
      comment: "Type of study (e.g., Interventional, Observational, Survey) — used to analyze protocol portfolio by research methodology."
    - name: "clinical_trial_flag"
      expr: clinical_trial_flag
      comment: "Whether the protocol is a clinical trial — used to identify protocols subject to ClinicalTrials.gov registration requirements."
    - name: "fda_regulated_flag"
      expr: fda_regulated_flag
      comment: "Whether the protocol involves FDA-regulated research — used to identify protocols with heightened regulatory compliance requirements."
    - name: "vulnerable_population_flag"
      expr: vulnerable_population_flag
      comment: "Whether the protocol involves vulnerable populations — used to flag protocols requiring enhanced protections and oversight."
    - name: "multi_site_flag"
      expr: multi_site_flag
      comment: "Whether the protocol is a multi-site study — used to identify protocols with complex coordination and oversight requirements."
    - name: "funding_source_type"
      expr: funding_source_type
      comment: "Type of funding source for the protocol (e.g., Federal, Industry, Internal) — used to analyze IRB workload by sponsor category."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the protocol was approved — enables year-over-year IRB approval volume trend analysis."
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the protocol expires — used to identify protocols requiring continuing review renewal."
  measures:
    - name: "total_irb_protocols"
      expr: COUNT(1)
      comment: "Total number of IRB protocols — baseline metric for human subjects research portfolio size and IRB workload."
    - name: "active_protocols"
      expr: COUNT(CASE WHEN protocol_status = 'Approved' THEN 1 END)
      comment: "Number of currently approved and active IRB protocols — primary indicator of active human subjects research oversight workload."
    - name: "clinical_trial_count"
      expr: COUNT(CASE WHEN clinical_trial_flag = TRUE THEN 1 END)
      comment: "Number of protocols classified as clinical trials — used to track clinical research portfolio size and ClinicalTrials.gov compliance obligations."
    - name: "fda_regulated_protocol_count"
      expr: COUNT(CASE WHEN fda_regulated_flag = TRUE THEN 1 END)
      comment: "Number of FDA-regulated protocols — measures high-compliance-burden research volume requiring enhanced regulatory oversight."
    - name: "vulnerable_population_protocol_count"
      expr: COUNT(CASE WHEN vulnerable_population_flag = TRUE THEN 1 END)
      comment: "Number of protocols involving vulnerable populations — used to size enhanced protection oversight requirements."
    - name: "multi_site_protocol_count"
      expr: COUNT(CASE WHEN multi_site_flag = TRUE THEN 1 END)
      comment: "Number of multi-site protocols — used to assess coordination complexity and reliance agreement workload."
    - name: "protocols_expiring_soon"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Number of protocols expiring within 90 days — critical operational metric for IRB continuing review workload management."
$$;