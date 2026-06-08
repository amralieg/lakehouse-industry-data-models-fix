-- Metric views for domain: contract | Business: Construction | Version: 1 | Generated on: 2026-05-07 09:21:54

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`contract_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the contract agreement entity. Tracks contract portfolio value, financial exposure from liquidated damages and performance bonds, retention obligations, and contract lifecycle distribution. Used by commercial directors and CFOs to steer contract risk and revenue recognition."
  source: "`construction_ecm`.`contract`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current lifecycle status of the agreement (e.g. Active, Closed, Terminated). Enables portfolio segmentation by contract health."
    - name: "contract_type"
      expr: contract_type
      comment: "Classification of the contract (e.g. Lump Sum, Reimbursable, Unit Rate). Drives risk and commercial strategy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the contract is denominated. Required for multi-currency portfolio reporting."
    - name: "geographic_location"
      expr: geographic_location
      comment: "Geographic location of the contracted work. Enables regional portfolio analysis."
    - name: "governing_law"
      expr: governing_law
      comment: "Jurisdiction governing the contract. Relevant for legal risk segmentation."
    - name: "award_year"
      expr: YEAR(award_date)
      comment: "Year the contract was awarded. Enables year-over-year contract award trend analysis."
    - name: "award_month"
      expr: DATE_TRUNC('MONTH', award_date)
      comment: "Month the contract was awarded. Supports monthly award pipeline reporting."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the contract became effective. Used for cohort and vintage analysis of the contract portfolio."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total original contract value across the portfolio. Primary revenue backlog indicator used by CFOs and commercial directors."
    - name: "total_revised_contract_value"
      expr: SUM(CAST(revised_contract_value AS DOUBLE))
      comment: "Total revised contract value reflecting approved amendments and change orders. Tracks portfolio growth or erosion from scope changes."
    - name: "total_contract_value_variance"
      expr: SUM((CAST(revised_contract_value AS DOUBLE)) - (CAST(contract_value AS DOUBLE)))
      comment: "Aggregate variance between revised and original contract values. Quantifies the financial impact of scope changes and amendments across the portfolio."
    - name: "total_liquidated_damages_exposure"
      expr: SUM(CAST(liquidated_damages_amount AS DOUBLE))
      comment: "Total liquidated damages exposure across all contracts. Critical risk metric for commercial and legal teams to monitor penalty liability."
    - name: "total_performance_bond_amount"
      expr: SUM(CAST(performance_bond_amount AS DOUBLE))
      comment: "Total performance bond value held across the contract portfolio. Indicates financial security coverage for contract performance obligations."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across contracts. Informs cash flow planning and subcontractor payment strategy."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN agreement_id END)
      comment: "Number of currently active contracts. Core portfolio size indicator for executive dashboards."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average contract value across the portfolio. Benchmarks deal size and informs bidding strategy."
    - name: "contract_value_revision_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(revised_contract_value AS DOUBLE)) / NULLIF(SUM(CAST(contract_value AS DOUBLE)), 0), 2)
      comment: "Ratio of total revised contract value to total original contract value expressed as a percentage. Values above 100% indicate net scope growth; below 100% indicate scope reduction. Key commercial performance indicator."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`contract_change_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over contract change orders (variations). Tracks financial impact, approval cycle efficiency, and critical change exposure. Used by project controls, commercial managers, and PMO to manage scope creep and cost growth."
  source: "`construction_ecm`.`contract`.`contract_change_order`"
  dimensions:
    - name: "contract_change_order_status"
      expr: contract_change_order_status
      comment: "Current status of the change order (e.g. Submitted, Approved, Rejected). Enables pipeline and backlog analysis of pending variations."
    - name: "change_order_type"
      expr: change_order_type
      comment: "Type/category of the change order (e.g. Scope, Time, Compensation). Supports root-cause analysis of contract variations."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the change order. Enables systemic analysis of variation drivers."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the change order financial impact. Required for multi-currency reporting."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the change order is on the critical path. Enables prioritisation of high-impact variations."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the change order became effective. Supports trend analysis of variation activity over time."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the change order became effective. Supports monthly variation volume and cost reporting."
  measures:
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total cost impact of all change orders. Primary measure of contract cost growth driven by variations. Directly informs budget forecasting."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net financial value of change orders after adjustments. Represents the net commercial exposure from all variations."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of change orders before deductions. Used to assess the full scale of variation activity."
    - name: "total_ld_provision_amount"
      expr: SUM(CAST(ld_provision_amount AS DOUBLE))
      comment: "Total liquidated damages provisions embedded in change orders. Quantifies penalty risk arising from variation-driven delays."
    - name: "critical_change_order_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN contract_change_order_id END)
      comment: "Number of change orders flagged as critical path impacting. Executives use this to assess schedule and delivery risk."
    - name: "avg_cost_impact_per_change_order"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per change order. Benchmarks variation size and helps identify outlier high-cost changes."
    - name: "approved_change_order_count"
      expr: COUNT(CASE WHEN contract_change_order_status = 'Approved' THEN contract_change_order_id END)
      comment: "Number of approved change orders. Tracks the volume of formally sanctioned scope changes in the contract."
    - name: "pending_change_order_count"
      expr: COUNT(CASE WHEN contract_change_order_status = 'Submitted' THEN contract_change_order_id END)
      comment: "Number of change orders awaiting approval. Indicates backlog of unresolved commercial decisions requiring management attention."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`contract_payment_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over payment certificates. Tracks certified payment volumes, deductions (retention, LD, advance recovery), and payment status. Used by finance, commercial, and project teams to manage cash flow, payment compliance, and contractor payment health."
  source: "`construction_ecm`.`contract`.`payment_certificate`"
  dimensions:
    - name: "payment_certificate_status"
      expr: payment_certificate_status
      comment: "Approval/processing status of the payment certificate. Enables tracking of certificates in the approval pipeline."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment execution status (e.g. Paid, Overdue, Pending). Core dimension for cash flow and payment compliance analysis."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g. Progress, Final, Advance). Enables segmentation of payment activity by commercial milestone."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment certificate. Required for multi-currency cash flow reporting."
    - name: "is_ld_applied"
      expr: is_ld_applied
      comment: "Flag indicating whether liquidated damages were deducted on this certificate. Enables analysis of LD deduction frequency."
    - name: "is_retention_applied"
      expr: is_retention_applied
      comment: "Flag indicating whether retention was withheld on this certificate. Supports retention cash flow analysis."
    - name: "payment_due_month"
      expr: DATE_TRUNC('MONTH', payment_due_date)
      comment: "Month the payment is due. Enables monthly cash flow forecasting and overdue payment tracking."
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year of the invoice. Supports year-over-year payment volume analysis."
  measures:
    - name: "total_certified_amount"
      expr: SUM(CAST(certified_amount AS DOUBLE))
      comment: "Total value certified for payment across all certificates. Primary revenue recognition and cash flow indicator for the contract portfolio."
    - name: "total_net_amount_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due to contractors after all deductions. Represents actual cash outflow obligation."
    - name: "total_retention_withheld"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention amounts withheld across payment certificates. Tracks the cumulative retention liability owed to contractors."
    - name: "total_ld_deductions"
      expr: SUM(CAST(ld_deduction_amount AS DOUBLE))
      comment: "Total liquidated damages deducted from payment certificates. Quantifies the financial penalties applied for contractor delays."
    - name: "total_advance_recovery"
      expr: SUM(CAST(advance_recovery_amount AS DOUBLE))
      comment: "Total advance payment amounts recovered through payment certificates. Tracks progress in recouping mobilisation advances."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts on payment certificates. Required for tax compliance reporting and cash flow planning."
    - name: "avg_certified_amount"
      expr: AVG(CAST(certified_amount AS DOUBLE))
      comment: "Average certified amount per payment certificate. Benchmarks payment cycle size and identifies anomalous certificates."
    - name: "ld_deduction_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(ld_deduction_amount AS DOUBLE)) / NULLIF(SUM(CAST(certified_amount AS DOUBLE)), 0), 2)
      comment: "Liquidated damages deductions as a percentage of total certified amount. Measures the financial penalty burden relative to contract progress payments."
    - name: "retention_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(retention_amount AS DOUBLE)) / NULLIF(SUM(CAST(certified_amount AS DOUBLE)), 0), 2)
      comment: "Retention withheld as a percentage of total certified amount. Monitors whether retention is being applied at the contractually agreed rate."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`contract_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over contract amendments. Tracks financial and schedule impacts of contract modifications, approval cycle performance, and amendment risk ratings. Used by commercial managers and legal teams to govern contract change exposure."
  source: "`construction_ecm`.`contract`.`amendment`"
  dimensions:
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the amendment (e.g. Draft, Approved, Executed). Enables pipeline tracking of pending contract modifications."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (e.g. Scope, Time, Financial). Supports root-cause analysis of contract modification drivers."
    - name: "amendment_category"
      expr: amendment_category
      comment: "Business category of the amendment. Enables segmentation of amendments by commercial significance."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the amendment. Enables prioritisation of high-risk contract modifications for management review."
    - name: "legal_review_status"
      expr: legal_review_status
      comment: "Status of legal review for the amendment. Tracks compliance with legal governance requirements for contract changes."
    - name: "execution_status"
      expr: execution_status
      comment: "Execution status of the amendment document. Monitors whether amendments have been formally signed and executed."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the amendment was approved. Supports year-over-year amendment activity trend analysis."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the amendment became effective. Enables monthly amendment volume and financial impact reporting."
  measures:
    - name: "total_financial_impact"
      expr: SUM(CAST(impact_financial AS DOUBLE))
      comment: "Total financial impact of all amendments. Quantifies the cumulative cost of contract modifications — a primary commercial risk indicator."
    - name: "total_payment_adjustment"
      expr: SUM(CAST(payment_adjustment_amount AS DOUBLE))
      comment: "Total payment adjustments arising from amendments. Tracks the cash flow impact of contract modifications on payment schedules."
    - name: "total_revised_contract_value"
      expr: SUM(CAST(revised_contract_value AS DOUBLE))
      comment: "Total revised contract value as recorded in amendments. Tracks the cumulative contracted value after all modifications."
    - name: "avg_financial_impact_per_amendment"
      expr: AVG(CAST(impact_financial AS DOUBLE))
      comment: "Average financial impact per amendment. Benchmarks the typical cost of contract changes and identifies high-impact outliers."
    - name: "high_risk_amendment_count"
      expr: COUNT(CASE WHEN risk_rating IN ('High', 'Critical') THEN amendment_id END)
      comment: "Number of amendments rated high or critical risk. Executives use this to prioritise legal and commercial intervention."
    - name: "unsigned_amendment_count"
      expr: COUNT(CASE WHEN document_signed_flag = FALSE THEN amendment_id END)
      comment: "Number of amendments not yet formally signed. Tracks governance compliance risk from unsigned contract modifications."
    - name: "confidential_amendment_count"
      expr: COUNT(CASE WHEN is_confidential = TRUE THEN amendment_id END)
      comment: "Number of amendments marked confidential. Supports information governance and access control reporting."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`contract_eot_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over Extension of Time (EOT) claims. Tracks claim volumes, financial exposure, resolution rates, and liquidated damages impact. Used by project directors, commercial managers, and legal teams to manage delay risk and claim resolution performance."
  source: "`construction_ecm`.`contract`.`eot_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the EOT claim (e.g. Submitted, Under Review, Approved, Rejected). Core dimension for claim pipeline management."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of EOT claim (e.g. Employer Risk, Force Majeure, Neutral Event). Enables root-cause analysis of delay events."
    - name: "determination_outcome"
      expr: determination_outcome
      comment: "Final determination outcome of the claim (e.g. Granted, Partially Granted, Rejected). Tracks claim success rates and entitlement patterns."
    - name: "entitlement_basis"
      expr: entitlement_basis
      comment: "Legal or contractual basis for the EOT entitlement. Supports analysis of claim grounds and legal risk."
    - name: "claim_priority"
      expr: claim_priority
      comment: "Priority level assigned to the claim. Enables triage and escalation of high-priority delay claims."
    - name: "claim_is_critical"
      expr: claim_is_critical
      comment: "Flag indicating whether the claim is on the critical path. Critical claims have direct schedule and LD implications."
    - name: "claim_submission_year"
      expr: YEAR(claim_submission_timestamp)
      comment: "Year the claim was submitted. Supports year-over-year EOT claim trend analysis."
    - name: "claim_decision_month"
      expr: DATE_TRUNC('MONTH', claim_decision_date)
      comment: "Month the claim decision was issued. Enables monthly resolution throughput reporting."
  measures:
    - name: "total_claim_amount"
      expr: SUM(CAST(claim_amount AS DOUBLE))
      comment: "Total financial value of all EOT claims submitted. Primary measure of delay-related financial exposure in the contract portfolio."
    - name: "total_claim_final_amount"
      expr: SUM(CAST(claim_final_amount AS DOUBLE))
      comment: "Total final settled amount across all EOT claims. Represents the actual financial cost of delay claims after determination."
    - name: "total_ld_impact"
      expr: SUM(CAST(liquidated_damages_impact AS DOUBLE))
      comment: "Total liquidated damages impact arising from EOT claims. Quantifies the penalty exposure linked to unresolved or rejected delay claims."
    - name: "claim_settlement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(claim_final_amount AS DOUBLE)) / NULLIF(SUM(CAST(claim_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of final settled amount to originally claimed amount expressed as a percentage. Measures the commercial outcome of EOT claim negotiations — values below 100% indicate successful pushback."
    - name: "critical_claim_count"
      expr: COUNT(CASE WHEN claim_is_critical = TRUE THEN eot_claim_id END)
      comment: "Number of EOT claims flagged as critical path impacting. Executives use this to assess schedule delivery risk from unresolved claims."
    - name: "avg_claim_amount"
      expr: AVG(CAST(claim_amount AS DOUBLE))
      comment: "Average EOT claim amount. Benchmarks typical claim size and helps identify disproportionately large claims requiring escalation."
    - name: "open_claim_count"
      expr: COUNT(CASE WHEN claim_status NOT IN ('Closed', 'Withdrawn', 'Rejected') THEN eot_claim_id END)
      comment: "Number of EOT claims currently open and unresolved. Tracks the active claim backlog requiring commercial and legal attention."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`contract_retention_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over the retention ledger. Tracks retention balances, release activity, bond substitutions, and hold flags. Used by finance and commercial teams to manage contractor retention obligations, cash flow, and release compliance."
  source: "`construction_ecm`.`contract`.`retention_ledger`"
  dimensions:
    - name: "contract_retention_ledger_status"
      expr: contract_retention_ledger_status
      comment: "Current status of the retention ledger entry. Enables segmentation of active, released, and held retention balances."
    - name: "retention_release_type"
      expr: retention_release_type
      comment: "Type of retention release (e.g. Practical Completion, DLP Expiry). Tracks the trigger events driving retention releases."
    - name: "retention_source"
      expr: retention_source
      comment: "Source of the retention deduction (e.g. Progress Payment, Final Account). Enables traceability of retention origins."
    - name: "retention_hold_flag"
      expr: retention_hold_flag
      comment: "Flag indicating whether retention is currently on hold. Identifies retention balances blocked from release."
    - name: "retention_bond_substituted_flag"
      expr: retention_bond_substituted_flag
      comment: "Flag indicating whether a retention bond has been substituted for cash retention. Tracks bond substitution activity across the portfolio."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the retention ledger entry. Required for multi-currency retention balance reporting."
    - name: "release_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month of retention release. Enables monthly cash outflow forecasting for retention releases."
  measures:
    - name: "total_retention_balance"
      expr: SUM(CAST(cumulative_retention_balance AS DOUBLE))
      comment: "Total cumulative retention balance outstanding. Primary measure of the contractor cash liability held by the organisation."
    - name: "total_retention_withheld"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention amounts withheld across all ledger entries. Tracks the gross retention deducted from contractor payments."
    - name: "total_retention_released"
      expr: SUM(CAST(release_amount AS DOUBLE))
      comment: "Total retention amounts released to contractors. Tracks cash outflows from retention release events."
    - name: "total_retention_bond_amount"
      expr: SUM(CAST(retention_bond_amount AS DOUBLE))
      comment: "Total value of retention bonds substituted for cash retention. Quantifies the bond-backed portion of the retention portfolio."
    - name: "total_retention_adjustment"
      expr: SUM(CAST(retention_adjustment_amount AS DOUBLE))
      comment: "Total adjustments made to retention balances. Tracks corrections and reconciliation activity in the retention ledger."
    - name: "retention_release_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(release_amount AS DOUBLE)) / NULLIF(SUM(CAST(retention_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of withheld retention that has been released. Measures the pace of retention release relative to amounts held — low rates may indicate delayed release obligations."
    - name: "held_retention_count"
      expr: COUNT(CASE WHEN retention_hold_flag = TRUE THEN retention_ledger_id END)
      comment: "Number of retention ledger entries currently on hold. Identifies blocked retention releases requiring management resolution."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`contract_ld_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over liquidated damages assessments. Tracks LD amounts assessed, waiver activity, and net deductions. Used by commercial directors and project managers to monitor penalty exposure and waiver governance."
  source: "`construction_ecm`.`contract`.`ld_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the LD assessment (e.g. Draft, Finalised, Waived). Enables pipeline tracking of LD determinations."
    - name: "ld_waiver_flag"
      expr: ld_waiver_flag
      comment: "Flag indicating whether the LD was waived. Enables analysis of waiver frequency and financial impact."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the LD assessment. Required for multi-currency LD exposure reporting."
    - name: "milestone_name"
      expr: milestone_name
      comment: "Name of the milestone against which the LD is assessed. Enables analysis of which milestones are driving the most LD exposure."
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of the LD assessment. Supports year-over-year LD trend analysis."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of the LD assessment. Enables monthly LD exposure and deduction reporting."
  measures:
    - name: "total_ld_assessed"
      expr: SUM(CAST(total_ld_amount AS DOUBLE))
      comment: "Total liquidated damages assessed across all assessments. Primary measure of contractor penalty exposure in the portfolio."
    - name: "total_net_ld_deducted"
      expr: SUM(CAST(net_ld_deducted AS DOUBLE))
      comment: "Total net liquidated damages actually deducted after waivers. Represents the realised financial penalty applied to contractors."
    - name: "total_ld_waiver_amount"
      expr: SUM(CAST(waiver_amount AS DOUBLE))
      comment: "Total value of LD waivers granted. Quantifies the commercial concessions made on penalty deductions — requires governance oversight."
    - name: "avg_ld_rate_per_day"
      expr: AVG(CAST(ld_rate_per_day AS DOUBLE))
      comment: "Average daily LD rate across assessments. Benchmarks the contractual penalty intensity and informs risk pricing."
    - name: "ld_waiver_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(waiver_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_ld_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of assessed LDs that were waived. High waiver rates may indicate governance issues or commercial pressure — a key risk indicator for audit and compliance."
    - name: "ld_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(net_ld_deducted AS DOUBLE)) / NULLIF(SUM(CAST(total_ld_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of assessed LDs that were actually deducted (net of waivers). Measures the effectiveness of LD enforcement in the contract portfolio."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`contract_closeout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over contract closeout records. Tracks final account values, variance from original contract, warranty and DLP timelines, and closeout completion status. Used by project directors and commercial teams to govern contract completion and final account settlement."
  source: "`construction_ecm`.`contract`.`closeout`"
  dimensions:
    - name: "closeout_status"
      expr: closeout_status
      comment: "Current status of the contract closeout (e.g. In Progress, Finalised). Tracks the completion of contract closure activities."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status at closeout. Ensures regulatory and contractual obligations have been met before final settlement."
    - name: "checklist_status"
      expr: checklist_status
      comment: "Status of the closeout checklist. Tracks completeness of administrative closure activities."
    - name: "is_finalized"
      expr: is_finalized
      comment: "Flag indicating whether the closeout has been formally finalised. Enables segmentation of completed vs in-progress closeouts."
    - name: "eot_claims_settled_flag"
      expr: eot_claims_settled_flag
      comment: "Flag indicating whether all EOT claims have been settled at closeout. Tracks resolution of delay claims as a prerequisite for final account."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the closeout financial values. Required for multi-currency final account reporting."
    - name: "closeout_year"
      expr: YEAR(closeout_date)
      comment: "Year of contract closeout. Supports year-over-year closeout activity and final account settlement analysis."
  measures:
    - name: "total_final_contract_value"
      expr: SUM(CAST(final_contract_value AS DOUBLE))
      comment: "Total final contract value at closeout. The definitive measure of contract outturn value used for financial reporting and benchmarking."
    - name: "total_final_account_gross"
      expr: SUM(CAST(final_account_gross_amount AS DOUBLE))
      comment: "Total gross final account amount across closed contracts. Represents the full commercial settlement value before deductions."
    - name: "total_variance_from_original"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between final and original contract values. Measures the aggregate cost overrun or underrun across the closed contract portfolio."
    - name: "total_net_closeout_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount at closeout after all adjustments. Represents the actual cash settlement obligation at contract completion."
    - name: "avg_final_vs_original_variance"
      expr: AVG(CAST(variance_amount AS DOUBLE))
      comment: "Average variance between final and original contract value per closeout. Benchmarks typical cost growth and informs future contract pricing strategy."
    - name: "finalized_closeout_count"
      expr: COUNT(CASE WHEN is_finalized = TRUE THEN closeout_id END)
      comment: "Number of contracts formally finalised at closeout. Tracks the pace of contract closure and final account settlement."
    - name: "unsettled_eot_closeout_count"
      expr: COUNT(CASE WHEN eot_claims_settled_flag = FALSE THEN closeout_id END)
      comment: "Number of closeouts where EOT claims remain unsettled. Identifies contracts at risk of delayed final account due to unresolved delay claims."
    - name: "cost_overrun_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(original_contract_value AS DOUBLE)), 0), 2)
      comment: "Total variance as a percentage of original contract value. Measures the average cost overrun rate across the closed portfolio — a key project delivery performance indicator."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`contract_subcontract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over subcontracts. Tracks subcontract portfolio value, risk ratings, compliance status, and LD exposure. Used by procurement, commercial, and project teams to govern subcontractor performance and financial exposure."
  source: "`construction_ecm`.`contract`.`subcontract`"
  dimensions:
    - name: "subcontract_status"
      expr: subcontract_status
      comment: "Current status of the subcontract (e.g. Active, Completed, Terminated). Enables portfolio segmentation by subcontract lifecycle stage."
    - name: "subcontract_type"
      expr: subcontract_type
      comment: "Type of subcontract (e.g. Labour, Supply, Design-Build). Supports analysis of subcontract portfolio composition."
    - name: "contract_category"
      expr: contract_category
      comment: "Business category of the subcontract. Enables spend analysis by trade or work category."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the subcontract. Enables prioritisation of high-risk subcontractors for management oversight."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the subcontract. Tracks whether subcontractors are meeting regulatory and contractual obligations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the subcontract value. Required for multi-currency subcontract portfolio reporting."
    - name: "effective_from_year"
      expr: YEAR(effective_from)
      comment: "Year the subcontract became effective. Supports year-over-year subcontract award trend analysis."
  measures:
    - name: "total_subcontract_value"
      expr: SUM(CAST(value_amount AS DOUBLE))
      comment: "Total value of all subcontracts. Primary measure of subcontracted spend in the project portfolio — used by procurement and commercial directors."
    - name: "total_ld_exposure"
      expr: SUM(CAST(liquidated_damages_amount AS DOUBLE))
      comment: "Total liquidated damages exposure across subcontracts. Quantifies the penalty risk embedded in the subcontract portfolio."
    - name: "avg_subcontract_value"
      expr: AVG(CAST(value_amount AS DOUBLE))
      comment: "Average subcontract value. Benchmarks typical subcontract deal size and informs procurement strategy."
    - name: "high_risk_subcontract_count"
      expr: COUNT(CASE WHEN risk_rating IN ('High', 'Critical') THEN subcontract_id END)
      comment: "Number of subcontracts rated high or critical risk. Executives use this to prioritise subcontractor oversight and intervention."
    - name: "non_compliant_subcontract_count"
      expr: COUNT(CASE WHEN compliance_status NOT IN ('Compliant', 'Closed') THEN subcontract_id END)
      comment: "Number of subcontracts with non-compliant status. Tracks regulatory and contractual compliance risk in the subcontractor base."
    - name: "active_subcontract_count"
      expr: COUNT(CASE WHEN subcontract_status = 'Active' THEN subcontract_id END)
      comment: "Number of currently active subcontracts. Core portfolio size indicator for procurement and project management dashboards."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`contract_bond_guarantee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over bonds and guarantees. Tracks bond portfolio value, expiry risk, and call activity. Used by treasury, legal, and commercial teams to manage financial security obligations and bond expiry compliance."
  source: "`construction_ecm`.`contract`.`bond_guarantee`"
  dimensions:
    - name: "bond_guarantee_status"
      expr: bond_guarantee_status
      comment: "Current status of the bond or guarantee (e.g. Active, Expired, Called, Released). Enables portfolio segmentation by bond lifecycle stage."
    - name: "bond_type"
      expr: bond_type
      comment: "Type of bond or guarantee (e.g. Performance Bond, Advance Payment Guarantee, Retention Bond). Supports analysis of financial security portfolio composition."
    - name: "guarantee_purpose"
      expr: guarantee_purpose
      comment: "Purpose of the guarantee. Provides business context for the financial security instrument."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the bond or guarantee. Relevant for legal risk and regulatory compliance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the bond amount. Required for multi-currency bond portfolio reporting."
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the bond was issued. Supports year-over-year bond issuance trend analysis."
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the bond expires. Critical for proactive bond renewal management and expiry risk monitoring."
  measures:
    - name: "total_bond_amount"
      expr: SUM(CAST(bond_amount AS DOUBLE))
      comment: "Total value of all bonds and guarantees in the portfolio. Primary measure of financial security coverage held against contract obligations."
    - name: "avg_bond_amount"
      expr: AVG(CAST(bond_amount AS DOUBLE))
      comment: "Average bond amount. Benchmarks typical bond size and informs treasury planning for new contract awards."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage associated with bond guarantees. Monitors alignment between bond coverage and contractual retention rates."
    - name: "active_bond_count"
      expr: COUNT(CASE WHEN bond_guarantee_status = 'Active' THEN bond_guarantee_id END)
      comment: "Number of currently active bonds and guarantees. Core portfolio size indicator for treasury and legal dashboards."
    - name: "called_bond_count"
      expr: COUNT(CASE WHEN bond_guarantee_status = 'Called' THEN bond_guarantee_id END)
      comment: "Number of bonds that have been called. Tracks contractor default events and associated financial security enforcement activity."
    - name: "expiring_within_90_days_count"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN bond_guarantee_id END)
      comment: "Number of bonds expiring within the next 90 days. Proactive risk indicator for treasury teams to initiate bond renewal before expiry."
$$;