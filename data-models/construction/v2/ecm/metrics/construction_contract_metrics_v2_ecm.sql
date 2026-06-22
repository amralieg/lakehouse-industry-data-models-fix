-- Metric views for domain: contract | Business: Construction | Version: 2 | Generated on: 2026-06-22 15:07:26

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the contract agreement portfolio — contract value, retention exposure, liquidated damages risk, and amendment activity. Used by contract managers and CFOs to steer portfolio risk and financial exposure."
  source: "`vibe_construction_v1`.`contract`.`agreement`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g. lump-sum, unit-rate, cost-plus) for portfolio segmentation."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current lifecycle status of the agreement (e.g. active, closed, disputed)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the contract is denominated, for multi-currency portfolio analysis."
    - name: "award_year"
      expr: YEAR(award_date)
      comment: "Year the contract was awarded, enabling year-over-year portfolio trend analysis."
    - name: "award_month"
      expr: DATE_TRUNC('MONTH', award_date)
      comment: "Month the contract was awarded, for monthly pipeline and award-volume tracking."
    - name: "governing_law"
      expr: governing_law
      comment: "Jurisdiction governing the contract, relevant for legal risk segmentation."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of most recent amendment applied to the agreement."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total original contract value across the portfolio. Core financial KPI for executive portfolio reporting."
    - name: "total_revised_contract_value"
      expr: SUM(CAST(revised_contract_value AS DOUBLE))
      comment: "Total revised (post-amendment) contract value. Compared against original to measure scope growth."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average contract value, used to benchmark deal size and identify outliers."
    - name: "total_liquidated_damages_exposure"
      expr: SUM(CAST(liquidated_damages_amount AS DOUBLE))
      comment: "Total liquidated damages exposure across all agreements. Critical risk KPI for legal and finance leadership."
    - name: "total_performance_bond_amount"
      expr: SUM(CAST(performance_bond_amount AS DOUBLE))
      comment: "Total performance bond value held across the portfolio, indicating contractor security coverage."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across contracts. Informs cash-flow planning and subcontractor negotiations."
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of agreements in the portfolio. Baseline volume KPI for workload and pipeline management."
    - name: "scope_growth_amount"
      expr: SUM(CAST(revised_contract_value AS DOUBLE) - CAST(contract_value AS DOUBLE))
      comment: "Total scope growth (revised minus original contract value) across the portfolio. Measures change-order inflation and scope creep risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_change_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for contract change orders — cost impact, schedule impact, and approval velocity. Used by project controls and contract managers to manage scope creep and change-order risk."
  source: "`vibe_construction_v1`.`contract`.`contract_change_order`"
  dimensions:
    - name: "change_order_type"
      expr: change_order_type
      comment: "Type of change order (e.g. scope addition, scope reduction, variation) for root-cause analysis."
    - name: "contract_change_order_status"
      expr: contract_change_order_status
      comment: "Current approval/execution status of the change order."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the change order financial impact."
    - name: "reason_code"
      expr: reason_code
      comment: "Root-cause reason code for the change order, enabling Pareto analysis of change drivers."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the change order is on the critical path, for prioritisation."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the change order became effective, for trend analysis of change-order volume over time."
  measures:
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total financial cost impact of all change orders. Core KPI for budget variance and contingency management."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of change orders issued, representing cumulative scope additions."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net value of change orders after adjustments, reflecting true financial exposure."
    - name: "total_ld_provision"
      expr: SUM(CAST(ld_provision_amount AS DOUBLE))
      comment: "Total liquidated damages provisions embedded in change orders. Risk KPI for delay cost exposure."
    - name: "change_order_count"
      expr: COUNT(1)
      comment: "Total number of change orders issued. Volume KPI indicating scope instability and contract management workload."
    - name: "avg_cost_impact_per_change_order"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per change order. Benchmarks change-order magnitude and flags unusually large variations."
    - name: "critical_change_order_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of change orders flagged as critical. Directly informs executive risk escalation decisions."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_payment_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for payment certification — certified amounts, retention deductions, LD deductions, and advance recovery. Used by finance and contract teams to manage cash flow and payment compliance."
  source: "`vibe_construction_v1`.`contract`.`payment_certificate`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment certificate for multi-currency cash-flow analysis."
    - name: "is_ld_applied"
      expr: is_ld_applied
      comment: "Flag indicating whether liquidated damages were deducted on this certificate."
    - name: "is_retention_applied"
      expr: is_retention_applied
      comment: "Flag indicating whether retention was withheld on this certificate."
    - name: "is_advance_recovered"
      expr: is_advance_recovered
      comment: "Flag indicating whether advance payment recovery was applied on this certificate."
    - name: "certification_month"
      expr: DATE_TRUNC('MONTH', certification_date)
      comment: "Month of certification, for monthly cash-flow and billing-cycle trend analysis."
    - name: "milestone_code"
      expr: milestone_code
      comment: "Milestone code associated with the payment certificate, linking payment to project progress."
  measures:
    - name: "total_certified_amount"
      expr: SUM(CAST(certified_amount AS DOUBLE))
      comment: "Total value certified for payment across all certificates. Primary cash-flow KPI for finance leadership."
    - name: "total_net_amount_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due after all deductions. Represents actual cash outflow obligation."
    - name: "total_retention_withheld"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld across all certificates. Tracks cumulative retention liability owed to contractors."
    - name: "total_ld_deducted"
      expr: SUM(CAST(ld_deduction_amount AS DOUBLE))
      comment: "Total liquidated damages deducted from payment certificates. Measures delay penalty enforcement."
    - name: "total_advance_recovered"
      expr: SUM(CAST(advance_recovery_amount AS DOUBLE))
      comment: "Total advance payment recovered through payment certificates. Tracks advance repayment progress."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts on payment certificates, required for VAT/GST compliance reporting."
    - name: "avg_work_progress_percent"
      expr: AVG(CAST(work_progress_percent AS DOUBLE))
      comment: "Average work progress percentage at time of certification. Indicates overall portfolio completion rate."
    - name: "certificate_count"
      expr: COUNT(1)
      comment: "Total number of payment certificates issued. Volume KPI for billing cycle activity."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_retention_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for contract retention management — retention balances, releases, and bond substitutions. Used by finance and contract teams to manage retention cash flow and contractor obligations."
  source: "`vibe_construction_v1`.`contract`.`contract_retention_ledger`"
  dimensions:
    - name: "contract_retention_ledger_status"
      expr: contract_retention_ledger_status
      comment: "Current status of the retention ledger entry (e.g. held, partially released, fully released)."
    - name: "retention_release_type"
      expr: retention_release_type
      comment: "Type of retention release (e.g. practical completion, DLP expiry) for release-trigger analysis."
    - name: "retention_source"
      expr: retention_source
      comment: "Source of the retention (e.g. main contract, subcontract) for portfolio segmentation."
    - name: "retention_bond_substituted_flag"
      expr: retention_bond_substituted_flag
      comment: "Flag indicating whether a retention bond has been substituted for cash retention."
    - name: "retention_hold_flag"
      expr: retention_hold_flag
      comment: "Flag indicating whether retention is currently on hold due to a dispute or defect."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the retention ledger entry."
    - name: "release_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month of retention release, for cash-flow forecasting of upcoming retention payments."
  measures:
    - name: "total_retention_held"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention currently held across all ledger entries. Core liability KPI for finance and contract teams."
    - name: "total_cumulative_retention_balance"
      expr: SUM(CAST(cumulative_retention_balance AS DOUBLE))
      comment: "Sum of cumulative retention balances, representing total outstanding retention liability."
    - name: "total_retention_released"
      expr: SUM(CAST(release_amount AS DOUBLE))
      comment: "Total retention released to contractors. Tracks cash outflow from retention release events."
    - name: "total_retention_bond_amount"
      expr: SUM(CAST(retention_bond_amount AS DOUBLE))
      comment: "Total value of retention bonds substituted for cash. Measures bond-substitution exposure."
    - name: "total_retention_adjustment"
      expr: SUM(CAST(retention_adjustment_amount AS DOUBLE))
      comment: "Total adjustments made to retention balances, flagging corrections and disputes."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across ledger entries. Benchmarks retention policy application."
    - name: "retention_on_hold_count"
      expr: COUNT(CASE WHEN retention_hold_flag = TRUE THEN 1 END)
      comment: "Number of retention entries currently on hold. Risk KPI for disputed or blocked retention releases."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_ld_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for liquidated damages assessments — total LD exposure, waivers, and net deductions. Used by contract and legal teams to manage delay penalty enforcement and waiver decisions."
  source: "`vibe_construction_v1`.`contract`.`ld_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the LD assessment (e.g. draft, approved, waived)."
    - name: "ld_waiver_flag"
      expr: ld_waiver_flag
      comment: "Flag indicating whether the LD was waived, for waiver-rate analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the LD assessment."
    - name: "milestone_name"
      expr: milestone_name
      comment: "Name of the milestone against which LD is assessed, for milestone-level delay analysis."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment, for trend analysis of LD enforcement activity."
  measures:
    - name: "total_ld_amount"
      expr: SUM(CAST(total_ld_amount AS DOUBLE))
      comment: "Total liquidated damages assessed across all records. Primary delay-penalty KPI for contract and legal leadership."
    - name: "total_net_ld_deducted"
      expr: SUM(CAST(net_ld_deducted AS DOUBLE))
      comment: "Total net LD actually deducted after waivers. Represents realized delay penalty cash flow."
    - name: "total_waiver_amount"
      expr: SUM(CAST(waiver_amount AS DOUBLE))
      comment: "Total LD waived across assessments. Measures commercial concessions granted to contractors."
    - name: "avg_ld_rate_per_day"
      expr: AVG(CAST(ld_rate_per_day AS DOUBLE))
      comment: "Average daily LD rate across assessments. Benchmarks penalty severity across contracts."
    - name: "ld_assessment_count"
      expr: COUNT(1)
      comment: "Total number of LD assessments raised. Volume KPI for delay enforcement activity."
    - name: "waived_assessment_count"
      expr: COUNT(CASE WHEN ld_waiver_flag = TRUE THEN 1 END)
      comment: "Number of LD assessments where the penalty was waived. Informs waiver-rate benchmarking and policy review."
    - name: "ld_waiver_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ld_waiver_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of LD assessments that were waived. Strategic KPI for contract enforcement discipline."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_eot_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for extension-of-time claims — claim volumes, financial exposure, and resolution rates. Used by project controls and legal teams to manage schedule risk and claim resolution."
  source: "`vibe_construction_v1`.`contract`.`contract_eot_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the EOT claim (e.g. submitted, under review, approved, rejected)."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of EOT claim (e.g. weather, employer risk, force majeure) for root-cause analysis."
    - name: "determination_outcome"
      expr: determination_outcome
      comment: "Final determination outcome (e.g. fully granted, partially granted, rejected)."
    - name: "claim_currency"
      expr: claim_currency
      comment: "Currency of the claim amount."
    - name: "claim_is_critical"
      expr: claim_is_critical
      comment: "Flag indicating whether the claim is on the critical path."
    - name: "claim_submission_month"
      expr: DATE_TRUNC('MONTH', claim_submission_timestamp)
      comment: "Month the claim was submitted, for trend analysis of claim filing activity."
  measures:
    - name: "total_claim_amount"
      expr: SUM(CAST(claim_amount AS DOUBLE))
      comment: "Total financial value of all EOT claims submitted. Core risk KPI for contract and legal leadership."
    - name: "total_final_claim_amount"
      expr: SUM(CAST(claim_final_amount AS DOUBLE))
      comment: "Total final settled claim amount. Compared against submitted amount to measure negotiation outcomes."
    - name: "total_ld_impact"
      expr: SUM(CAST(liquidated_damages_impact AS DOUBLE))
      comment: "Total liquidated damages impact associated with EOT claims. Quantifies delay penalty exposure linked to claims."
    - name: "eot_claim_count"
      expr: COUNT(1)
      comment: "Total number of EOT claims raised. Volume KPI for schedule dispute activity."
    - name: "avg_claim_amount"
      expr: AVG(CAST(claim_amount AS DOUBLE))
      comment: "Average EOT claim value. Benchmarks claim magnitude and flags unusually large claims."
    - name: "critical_claim_count"
      expr: COUNT(CASE WHEN claim_is_critical = TRUE THEN 1 END)
      comment: "Number of EOT claims on the critical path. Directly informs executive schedule risk decisions."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for contract disputes — financial exposure, resolution rates, and legal costs. Used by legal, contract, and executive teams to manage dispute risk and resolution performance."
  source: "`vibe_construction_v1`.`contract`.`dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (e.g. open, in arbitration, settled, closed)."
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of dispute (e.g. payment, scope, delay) for root-cause and trend analysis."
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Final resolution outcome (e.g. settled, arbitration award, court judgment)."
    - name: "claim_currency"
      expr: claim_currency
      comment: "Currency of the dispute claim amount."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the dispute is classified as critical."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month the dispute was submitted, for trend analysis of dispute filing activity."
  measures:
    - name: "total_claim_amount"
      expr: SUM(CAST(claim_amount AS DOUBLE))
      comment: "Total value of all dispute claims. Primary financial risk KPI for legal and executive leadership."
    - name: "total_resolution_amount"
      expr: SUM(CAST(resolution_amount AS DOUBLE))
      comment: "Total amount settled or awarded in dispute resolutions. Measures actual financial outcome of disputes."
    - name: "total_net_settlement_amount"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Total net settlement amount across all disputes. Represents realized financial impact after resolution."
    - name: "total_legal_cost"
      expr: SUM(CAST(legal_cost_amount AS DOUBLE))
      comment: "Total legal costs incurred across all disputes. Tracks dispute management overhead for cost control."
    - name: "dispute_count"
      expr: COUNT(1)
      comment: "Total number of disputes raised. Volume KPI for contract relationship health and legal workload."
    - name: "avg_claim_amount"
      expr: AVG(CAST(claim_amount AS DOUBLE))
      comment: "Average dispute claim value. Benchmarks dispute magnitude and identifies high-value outliers."
    - name: "recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(net_settlement_amount AS DOUBLE)) / NULLIF(SUM(CAST(claim_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of claimed amount recovered through settlement. Strategic KPI for dispute resolution effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_advance_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for advance payment management — outstanding balances, recovery progress, and interest accrual. Used by finance and contract teams to manage advance payment risk and recovery."
  source: "`vibe_construction_v1`.`contract`.`advance_payment`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the advance payment."
    - name: "guarantee_type"
      expr: guarantee_type
      comment: "Type of guarantee securing the advance payment (e.g. bank guarantee, insurance bond)."
    - name: "is_guarantee_required"
      expr: is_guarantee_required
      comment: "Flag indicating whether a guarantee is required for this advance."
    - name: "is_recovered"
      expr: is_recovered
      comment: "Flag indicating whether the advance has been fully recovered."
    - name: "is_interest_applicable"
      expr: is_interest_applicable
      comment: "Flag indicating whether interest is charged on this advance."
    - name: "recovery_method"
      expr: recovery_method
      comment: "Method used to recover the advance (e.g. deduction from progress payments, lump sum)."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the advance was issued, for cash-flow and advance-issuance trend analysis."
  measures:
    - name: "total_gross_advance_amount"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross advance payments issued. Core cash-flow KPI for finance leadership."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding advance balance yet to be recovered. Primary risk KPI for advance payment exposure."
    - name: "total_cumulative_recovered"
      expr: SUM(CAST(cumulative_recovered_amount AS DOUBLE))
      comment: "Total advance amounts recovered to date. Tracks recovery progress against issued advances."
    - name: "total_interest_accrued"
      expr: SUM(CAST(interest_accrued_amount AS DOUBLE))
      comment: "Total interest accrued on advances. Measures financing cost of advance payment arrangements."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on advance payments, required for tax compliance reporting."
    - name: "advance_count"
      expr: COUNT(1)
      comment: "Total number of advance payments issued. Volume KPI for advance payment activity."
    - name: "recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(cumulative_recovered_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount_gross AS DOUBLE)), 0), 2)
      comment: "Percentage of total advance amounts recovered. Strategic KPI for advance payment risk management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_closeout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for contract closeout — final account values, variance analysis, and closeout completion rates. Used by contract managers and finance to ensure clean contract closure and final account settlement."
  source: "`vibe_construction_v1`.`contract`.`closeout`"
  dimensions:
    - name: "closeout_status"
      expr: closeout_status
      comment: "Current status of the closeout process (e.g. in progress, finalized, disputed)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the closeout financial amounts."
    - name: "is_finalized"
      expr: is_finalized
      comment: "Flag indicating whether the closeout has been fully finalized."
    - name: "retention_release_flag"
      expr: retention_release_flag
      comment: "Flag indicating whether retention has been released at closeout."
    - name: "eot_claims_settled_flag"
      expr: eot_claims_settled_flag
      comment: "Flag indicating whether all EOT claims have been settled at closeout."
    - name: "closeout_month"
      expr: DATE_TRUNC('MONTH', closeout_date)
      comment: "Month of contract closeout, for trend analysis of closeout activity."
  measures:
    - name: "total_final_contract_value"
      expr: SUM(CAST(final_contract_value AS DOUBLE))
      comment: "Total final contract value at closeout. Core financial KPI for portfolio final account reporting."
    - name: "total_original_contract_value"
      expr: SUM(CAST(original_contract_value AS DOUBLE))
      comment: "Total original contract value at closeout, for variance analysis against final account."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between original and final contract values. Measures scope growth and change-order impact at closeout."
    - name: "total_final_account_gross"
      expr: SUM(CAST(final_account_gross_amount AS DOUBLE))
      comment: "Total gross final account amount across all closeouts."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount at closeout after all adjustments."
    - name: "closeout_count"
      expr: COUNT(1)
      comment: "Total number of contract closeouts processed. Volume KPI for contract lifecycle management."
    - name: "finalized_closeout_count"
      expr: COUNT(CASE WHEN is_finalized = TRUE THEN 1 END)
      comment: "Number of closeouts fully finalized. Tracks closeout completion rate for contract management efficiency."
    - name: "finalization_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_finalized = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of closeouts that have been fully finalized. Strategic KPI for contract closure efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_subcontract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for subcontract portfolio management — subcontract values, risk ratings, and compliance status. Used by procurement and contract managers to oversee subcontractor financial exposure and compliance."
  source: "`vibe_construction_v1`.`contract`.`subcontract`"
  dimensions:
    - name: "subcontract_status"
      expr: subcontract_status
      comment: "Current lifecycle status of the subcontract (e.g. active, completed, terminated)."
    - name: "subcontract_type"
      expr: subcontract_type
      comment: "Type of subcontract (e.g. labour-only, supply-and-install, design-and-build)."
    - name: "contract_category"
      expr: contract_category
      comment: "Category of the subcontract for portfolio segmentation."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the subcontract, for risk-weighted portfolio analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the subcontract (e.g. compliant, non-compliant, under review)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the subcontract value."
  measures:
    - name: "total_subcontract_value"
      expr: SUM(CAST(value_amount AS DOUBLE))
      comment: "Total value of all subcontracts in the portfolio. Core financial KPI for subcontractor spend management."
    - name: "avg_subcontract_value"
      expr: AVG(CAST(value_amount AS DOUBLE))
      comment: "Average subcontract value. Benchmarks deal size and identifies outlier subcontracts."
    - name: "total_ld_exposure"
      expr: SUM(CAST(liquidated_damages_amount AS DOUBLE))
      comment: "Total liquidated damages exposure across subcontracts. Risk KPI for delay penalty management."
    - name: "subcontract_count"
      expr: COUNT(1)
      comment: "Total number of subcontracts in the portfolio. Volume KPI for subcontractor management workload."
    - name: "non_compliant_subcontract_count"
      expr: COUNT(CASE WHEN compliance_status = 'non-compliant' THEN 1 END)
      comment: "Number of subcontracts with non-compliant status. Risk KPI for regulatory and contractual compliance management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_dlp_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for defects liability period management — retention balances, outstanding defects, and DLP closure rates. Used by contract managers to ensure defect rectification and timely retention release."
  source: "`vibe_construction_v1`.`contract`.`dlp_register`"
  dimensions:
    - name: "dlp_status"
      expr: dlp_status
      comment: "Current status of the DLP (e.g. active, expired, closed)."
    - name: "dlp_type"
      expr: dlp_type
      comment: "Type of DLP (e.g. standard, extended) for portfolio segmentation."
    - name: "dlp_compliance_status"
      expr: dlp_compliance_status
      comment: "Compliance status of the DLP, indicating whether all obligations have been met."
    - name: "dlp_certification_issued"
      expr: dlp_certification_issued
      comment: "Flag indicating whether the DLP completion certificate has been issued."
    - name: "dlp_extension_granted"
      expr: dlp_extension_granted
      comment: "Flag indicating whether a DLP extension has been granted."
    - name: "is_liquidated_damages_applicable"
      expr: is_liquidated_damages_applicable
      comment: "Flag indicating whether liquidated damages apply during the DLP."
    - name: "dlp_end_month"
      expr: DATE_TRUNC('MONTH', dlp_end_date)
      comment: "Month the DLP ends, for forecasting upcoming retention releases and certificate issuances."
  measures:
    - name: "total_dlp_retention_held"
      expr: SUM(CAST(dlp_retention_amount AS DOUBLE))
      comment: "Total retention held during DLP periods. Core cash-flow KPI for finance and contract teams."
    - name: "total_ld_amount"
      expr: SUM(CAST(liquidated_damages_amount AS DOUBLE))
      comment: "Total liquidated damages applicable during DLP periods. Risk KPI for delay penalty exposure."
    - name: "dlp_record_count"
      expr: COUNT(1)
      comment: "Total number of DLP register entries. Volume KPI for post-completion contract management workload."
    - name: "certified_dlp_count"
      expr: COUNT(CASE WHEN dlp_certification_issued = TRUE THEN 1 END)
      comment: "Number of DLPs where the completion certificate has been issued. Tracks DLP closure progress."
    - name: "dlp_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dlp_certification_issued = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DLPs where the completion certificate has been issued. Strategic KPI for post-completion contract closure efficiency."
    - name: "extended_dlp_count"
      expr: COUNT(CASE WHEN dlp_extension_granted = TRUE THEN 1 END)
      comment: "Number of DLPs where an extension has been granted. Indicates defect rectification delays and contractor performance issues."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_change_order_activity_impact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for change order activity impacts — cost variances, schedule impacts, and critical path effects. Used by project controls to quantify the downstream schedule and cost consequences of change orders."
  source: "`vibe_construction_v1`.`contract`.`change_order_activity_impact`"
  dimensions:
    - name: "impact_type"
      expr: impact_type
      comment: "Type of impact (e.g. cost, schedule, scope) for impact categorisation."
    - name: "impact_status"
      expr: impact_status
      comment: "Current status of the impact assessment."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the impact record."
    - name: "is_critical_path_affected"
      expr: is_critical_path_affected
      comment: "Flag indicating whether the change order impacts the critical path."
    - name: "is_approved"
      expr: is_approved
      comment: "Flag indicating whether the impact has been formally approved."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost impact amounts."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of impact assessment, for trend analysis of change-order impact activity."
  measures:
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total cost impact of change orders on schedule activities. Core KPI for budget variance management."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Total cost variance between original and revised activity costs due to change orders."
    - name: "total_original_cost"
      expr: SUM(CAST(original_cost AS DOUBLE))
      comment: "Total original cost of impacted activities before change orders."
    - name: "total_revised_cost"
      expr: SUM(CAST(revised_cost AS DOUBLE))
      comment: "Total revised cost of impacted activities after change orders."
    - name: "total_quantity_impact"
      expr: SUM(CAST(quantity_impact AS DOUBLE))
      comment: "Total quantity impact across all change order activity impacts. Measures scope volume changes."
    - name: "impact_record_count"
      expr: COUNT(1)
      comment: "Total number of change order activity impact records. Volume KPI for change management workload."
    - name: "critical_path_impact_count"
      expr: COUNT(CASE WHEN is_critical_path_affected = TRUE THEN 1 END)
      comment: "Number of change order impacts affecting the critical path. Directly informs schedule risk escalation decisions."
$$;