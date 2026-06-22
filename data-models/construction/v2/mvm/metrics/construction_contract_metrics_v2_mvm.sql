-- Metric views for domain: contract | Business: Construction | Version: 2 | Generated on: 2026-06-22 17:18:52

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the contract agreement portfolio — contract values, retention exposure, liquidated damages risk, and amendment activity. Used by commercial directors and CFOs to steer contract performance and financial exposure."
  source: "`vibe_construction_v1`.`contract`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Lifecycle status of the agreement (e.g. Active, Closed, Terminated) — primary filter for portfolio health analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Classification of the contract (e.g. Lump Sum, Cost-Plus, Unit Rate) — drives commercial strategy segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the contract is denominated — essential for multi-currency portfolio reporting."
    - name: "geographic_location"
      expr: geographic_location
      comment: "Geographic location of the contracted work — enables regional portfolio analysis."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment applied to the agreement — used to track scope, time, and value change patterns."
    - name: "award_year_month"
      expr: DATE_TRUNC('MONTH', award_date)
      comment: "Month in which the contract was awarded — supports trend analysis of new contract intake."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the contract became effective — used for cohort and duration analysis."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total original contract value across the portfolio. Core financial KPI for executive portfolio sizing and budget alignment."
    - name: "total_revised_contract_value"
      expr: SUM(CAST(revised_contract_value AS DOUBLE))
      comment: "Total revised (post-amendment) contract value. Compared against original value to quantify scope growth and commercial drift."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average original contract value per agreement. Benchmarks deal size and informs bidding strategy."
    - name: "total_liquidated_damages_exposure"
      expr: SUM(CAST(liquidated_damages_amount AS DOUBLE))
      comment: "Total liquidated damages amount stipulated across all contracts. Quantifies maximum penalty exposure for schedule overruns."
    - name: "total_performance_bond_amount"
      expr: SUM(CAST(performance_bond_amount AS DOUBLE))
      comment: "Total performance bond value secured across the portfolio. Indicates financial security coverage for contract delivery risk."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage held across contracts. Informs cash-flow planning and subcontractor payment strategy."
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of agreements in the portfolio. Baseline volume metric for workload and pipeline management."
    - name: "amended_contract_count"
      expr: COUNT(CASE WHEN amendment_number IS NOT NULL THEN 1 END)
      comment: "Number of contracts that have been amended. High amendment rates signal scope instability or poor initial definition."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_change_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs tracking change order volume, financial impact, and schedule disruption. Used by project controls and commercial managers to manage scope creep, cost overruns, and programme risk."
  source: "`vibe_construction_v1`.`contract`.`contract_change_order`"
  dimensions:
    - name: "contract_change_order_status"
      expr: contract_change_order_status
      comment: "Approval lifecycle status of the change order (e.g. Submitted, Approved, Rejected) — critical for pipeline and backlog analysis."
    - name: "change_order_type"
      expr: change_order_type
      comment: "Category of change (e.g. Scope Addition, Omission, Variation) — identifies the dominant drivers of contract change."
    - name: "reason_code"
      expr: reason_code
      comment: "Root-cause code for the change order — enables Pareto analysis of change drivers to target process improvement."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the change order amounts — required for multi-currency financial consolidation."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the change order is on the critical path — prioritises executive attention and escalation."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the change order became effective — supports trend analysis of change order activity over time."
    - name: "approved_by"
      expr: approved_by
      comment: "Approving authority for the change order — used for delegation-of-authority compliance reporting."
  measures:
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total cost impact of all change orders. Primary KPI for quantifying financial exposure from scope changes."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net value of approved change orders. Represents the actual contract value adjustment after all deductions."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of change orders before deductions. Used to assess the full scale of variation claims."
    - name: "total_ld_provision_amount"
      expr: SUM(CAST(ld_provision_amount AS DOUBLE))
      comment: "Total liquidated damages provisions embedded in change orders. Quantifies penalty risk arising from variation-driven delays."
    - name: "avg_cost_impact_per_change_order"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per change order. Benchmarks the materiality of individual changes and flags outliers."
    - name: "change_order_count"
      expr: COUNT(1)
      comment: "Total number of change orders raised. Volume indicator for scope instability and contract management workload."
    - name: "critical_change_order_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of change orders flagged as critical path. Directly informs programme risk and executive escalation decisions."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amounts across change orders. Captures net financial corrections applied to contract values."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring milestone delivery performance, liquidated damages exposure, and retention tied to contractual milestones. Used by project directors and commercial teams to track schedule compliance and financial consequences."
  source: "`vibe_construction_v1`.`contract`.`contract_milestone`"
  dimensions:
    - name: "contract_milestone_status"
      expr: contract_milestone_status
      comment: "Current status of the milestone (e.g. Pending, Achieved, Overdue) — primary lens for delivery performance reporting."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Classification of the milestone (e.g. Practical Completion, Sectional Completion, Payment) — enables type-specific performance analysis."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the milestone is on the critical path — prioritises management attention."
    - name: "ld_triggered"
      expr: ld_triggered
      comment: "Flag indicating whether liquidated damages have been triggered for this milestone — key risk indicator."
    - name: "liquidated_damages_applicable"
      expr: liquidated_damages_applicable
      comment: "Flag indicating whether LD provisions apply to this milestone — used to scope financial risk exposure."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory or contractual compliance status of the milestone — used for governance and audit reporting."
    - name: "planned_month"
      expr: DATE_TRUNC('MONTH', planned_date)
      comment: "Planned completion month — supports schedule adherence trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of milestone financial values — required for multi-currency consolidation."
  measures:
    - name: "total_milestone_value"
      expr: SUM(CAST(milestone_value AS DOUBLE))
      comment: "Total financial value tied to contractual milestones. Represents the payment-linked value at stake across the programme."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld at milestone level. Critical for cash-flow forecasting and subcontractor payment planning."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Total cost variance at milestone level. Quantifies financial overrun or saving against planned milestone budgets."
    - name: "total_ld_rate_exposure"
      expr: SUM(CAST(ld_rate_per_day AS DOUBLE))
      comment: "Sum of daily LD rates across all milestones. Indicates the daily financial penalty accrual rate if milestones are missed."
    - name: "milestone_count"
      expr: COUNT(1)
      comment: "Total number of contractual milestones. Baseline for schedule density and delivery complexity assessment."
    - name: "ld_triggered_milestone_count"
      expr: COUNT(CASE WHEN ld_triggered = TRUE THEN 1 END)
      comment: "Number of milestones where liquidated damages have been triggered. Direct indicator of schedule non-compliance and financial penalty exposure."
    - name: "critical_milestone_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical-path milestones. Used to assess programme risk concentration and prioritise recovery actions."
    - name: "outstanding_defects_milestone_count"
      expr: COUNT(CASE WHEN outstanding_defects_flag = TRUE THEN 1 END)
      comment: "Number of milestones with outstanding defects. Tracks quality close-out risk and potential retention release delays."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_eot_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for Extension of Time (EOT) claims — tracking claim volumes, financial impact, days claimed vs assessed, and resolution outcomes. Used by commercial and legal teams to manage programme risk and dispute exposure."
  source: "`vibe_construction_v1`.`contract`.`eot_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the EOT claim (e.g. Submitted, Under Review, Approved, Rejected) — primary pipeline view for claim management."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of EOT claim (e.g. Weather, Employer Risk, Force Majeure) — identifies dominant delay causes for root-cause analysis."
    - name: "determination_outcome"
      expr: determination_outcome
      comment: "Final determination result of the claim — used to assess adjudication success rates and entitlement patterns."
    - name: "entitlement_basis"
      expr: entitlement_basis
      comment: "Contractual basis for the EOT entitlement — informs legal strategy and contract drafting improvements."
    - name: "claim_priority"
      expr: claim_priority
      comment: "Priority level assigned to the claim — used to triage management attention and resource allocation."
    - name: "claim_is_critical"
      expr: claim_is_critical
      comment: "Flag indicating whether the claim is on the critical path — escalation trigger for executive intervention."
    - name: "claim_currency"
      expr: claim_currency
      comment: "Currency of the claim amounts — required for multi-currency financial consolidation."
    - name: "claim_decision_month"
      expr: DATE_TRUNC('MONTH', claim_decision_date)
      comment: "Month in which the claim decision was made — supports trend analysis of claim resolution velocity."
  measures:
    - name: "total_claim_amount"
      expr: SUM(CAST(claim_amount AS DOUBLE))
      comment: "Total financial value of all EOT claims submitted. Quantifies the full commercial exposure from delay claims."
    - name: "total_claim_final_amount"
      expr: SUM(CAST(claim_final_amount AS DOUBLE))
      comment: "Total final settled amount across resolved EOT claims. Compared against submitted amounts to measure negotiation outcomes."
    - name: "total_liquidated_damages_impact"
      expr: SUM(CAST(liquidated_damages_impact AS DOUBLE))
      comment: "Total LD financial impact associated with EOT claims. Directly links delay claims to penalty exposure for executive risk reporting."
    - name: "avg_claim_amount"
      expr: AVG(CAST(claim_amount AS DOUBLE))
      comment: "Average EOT claim value. Benchmarks claim materiality and informs settlement authority thresholds."
    - name: "eot_claim_count"
      expr: COUNT(1)
      comment: "Total number of EOT claims raised. Volume indicator for programme disruption and contract administration burden."
    - name: "critical_claim_count"
      expr: COUNT(CASE WHEN claim_is_critical = TRUE THEN 1 END)
      comment: "Number of EOT claims flagged as critical. Directly informs executive escalation and programme recovery prioritisation."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_payment_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for payment certification — tracking certified amounts, retention, LD deductions, and advance recovery. Used by finance directors and commercial managers to govern cash flow and payment compliance."
  source: "`vibe_construction_v1`.`contract`.`payment_certificate`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment certificate — required for multi-currency cash-flow consolidation."
    - name: "is_ld_applied"
      expr: is_ld_applied
      comment: "Flag indicating whether liquidated damages were deducted on this certificate — used to track penalty application frequency."
    - name: "is_retention_applied"
      expr: is_retention_applied
      comment: "Flag indicating whether retention was withheld on this certificate — used for retention liability tracking."
    - name: "is_advance_recovered"
      expr: is_advance_recovered
      comment: "Flag indicating whether advance payment recovery was applied — used to monitor advance repayment progress."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the certificate — used for tax compliance and VAT reporting."
    - name: "certification_month"
      expr: DATE_TRUNC('MONTH', certification_date)
      comment: "Month of certification — supports monthly cash-flow trend analysis and payment cycle monitoring."
  measures:
    - name: "total_certified_amount"
      expr: SUM(CAST(certified_amount AS DOUBLE))
      comment: "Total amount certified for payment across all certificates. Primary cash-flow KPI for finance and commercial leadership."
    - name: "total_net_amount_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due after all deductions. Represents actual cash outflow obligation and is the key payment liability metric."
    - name: "total_retention_withheld"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld across all payment certificates. Tracks the cumulative retention liability owed to contractors."
    - name: "total_ld_deductions"
      expr: SUM(CAST(ld_deduction_amount AS DOUBLE))
      comment: "Total liquidated damages deducted from payment certificates. Quantifies the financial penalties applied for schedule non-compliance."
    - name: "total_advance_recovery"
      expr: SUM(CAST(advance_recovery_amount AS DOUBLE))
      comment: "Total advance payment recovered across certificates. Tracks repayment progress against mobilisation advances."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on payment certificates. Required for VAT/GST compliance reporting and tax liability management."
    - name: "payment_certificate_count"
      expr: COUNT(1)
      comment: "Total number of payment certificates issued. Baseline volume metric for payment cycle management and administrative workload."
    - name: "avg_certified_amount"
      expr: AVG(CAST(certified_amount AS DOUBLE))
      comment: "Average certified amount per payment certificate. Benchmarks payment cycle size and informs cash-flow forecasting models."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_subcontract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for the subcontract portfolio — tracking subcontract values, liquidated damages exposure, and compliance. Used by procurement directors and project managers to govern supply chain financial risk and delivery performance."
  source: "`vibe_construction_v1`.`contract`.`subcontract`"
  dimensions:
    - name: "subcontract_status"
      expr: subcontract_status
      comment: "Lifecycle status of the subcontract (e.g. Active, Completed, Terminated) — primary filter for portfolio health analysis."
    - name: "subcontract_type"
      expr: subcontract_type
      comment: "Type of subcontract (e.g. Labour Only, Supply and Install, Design and Build) — enables commercial strategy segmentation."
    - name: "contract_category"
      expr: contract_category
      comment: "Business category of the subcontract — used for spend analysis and category management reporting."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the subcontract — used for regulatory and HSE governance reporting."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the subcontract — used to prioritise management oversight and mitigation actions."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the subcontract value — required for multi-currency spend consolidation."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the subcontract became effective — supports intake trend analysis and workload planning."
  measures:
    - name: "total_subcontract_value"
      expr: SUM(CAST(value_amount AS DOUBLE))
      comment: "Total value of all subcontracts in the portfolio. Primary KPI for supply chain spend management and budget control."
    - name: "avg_subcontract_value"
      expr: AVG(CAST(value_amount AS DOUBLE))
      comment: "Average subcontract value. Benchmarks deal size and informs procurement strategy and approval thresholds."
    - name: "total_ld_exposure"
      expr: SUM(CAST(liquidated_damages_amount AS DOUBLE))
      comment: "Total liquidated damages exposure across the subcontract portfolio. Quantifies maximum penalty risk from subcontractor non-performance."
    - name: "subcontract_count"
      expr: COUNT(1)
      comment: "Total number of subcontracts. Baseline volume metric for supply chain complexity and procurement workload."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors engaged via subcontracts. Measures supply chain diversity and concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_subcontract_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for subcontractor payment flows — tracking gross payments, net disbursements, retention, and LD deductions. Used by finance and commercial teams to manage subcontractor cash flow, compliance, and penalty application."
  source: "`vibe_construction_v1`.`contract`.`subcontract_payment`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the subcontract payment — required for multi-currency cash-flow consolidation."
    - name: "is_ld_deduction_applied"
      expr: is_ld_deduction_applied
      comment: "Flag indicating whether LD deductions were applied to this payment — tracks penalty enforcement frequency."
    - name: "is_retention_applied"
      expr: is_retention_applied
      comment: "Flag indicating whether retention was withheld — used for retention liability tracking across the supply chain."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the payment was due — supports cash-flow forecasting and payment cycle trend analysis."
  measures:
    - name: "total_gross_payment_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount paid to subcontractors. Primary KPI for supply chain cash outflow and spend management."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount disbursed after all deductions. Represents actual cash outflow to subcontractors and is the key payment liability metric."
    - name: "total_retention_withheld"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld from subcontractor payments. Tracks cumulative retention liability owed to the supply chain."
    - name: "total_ld_deductions"
      expr: SUM(CAST(ld_deduction_amount AS DOUBLE))
      comment: "Total liquidated damages deducted from subcontractor payments. Quantifies financial penalties enforced for subcontractor non-performance."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total payment adjustments applied. Tracks corrections and reconciliation items in the subcontractor payment cycle."
    - name: "subcontract_payment_count"
      expr: COUNT(1)
      comment: "Total number of subcontractor payment transactions. Baseline volume metric for payment cycle management and administrative workload."
    - name: "avg_net_payment_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net payment per subcontractor payment transaction. Benchmarks payment cycle size and informs cash-flow forecasting."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_bond_guarantee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for the bond and guarantee register — tracking bond values, retention exposure, and expiry risk. Used by commercial and legal teams to ensure adequate financial security coverage and proactive renewal management."
  source: "`vibe_construction_v1`.`contract`.`bond_guarantee`"
  dimensions:
    - name: "bond_guarantee_status"
      expr: bond_guarantee_status
      comment: "Current status of the bond or guarantee (e.g. Active, Called, Released, Expired) — primary filter for security coverage analysis."
    - name: "bond_type"
      expr: bond_type
      comment: "Type of bond or guarantee (e.g. Performance Bond, Advance Payment Guarantee, Retention Bond) — enables security type analysis."
    - name: "guarantee_purpose"
      expr: guarantee_purpose
      comment: "Business purpose of the guarantee — used to align security instruments with contractual obligations."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction governing the bond — used for regulatory compliance and cross-border risk reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the bond amount — required for multi-currency security portfolio consolidation."
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the bond or guarantee expires — critical for proactive renewal management and coverage gap prevention."
  measures:
    - name: "total_bond_amount"
      expr: SUM(CAST(bond_amount AS DOUBLE))
      comment: "Total value of all bonds and guarantees in the register. Primary KPI for financial security coverage assessment."
    - name: "avg_bond_amount"
      expr: AVG(CAST(bond_amount AS DOUBLE))
      comment: "Average bond or guarantee value. Benchmarks security instrument sizing relative to contract values."
    - name: "total_retention_percentage_avg"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across bond instruments. Used to assess whether retention bonds are adequately sized."
    - name: "bond_guarantee_count"
      expr: COUNT(1)
      comment: "Total number of bonds and guarantees in the register. Baseline for security portfolio management and renewal workload."
    - name: "distinct_agreement_count"
      expr: COUNT(DISTINCT agreement_id)
      comment: "Number of distinct agreements covered by bonds or guarantees. Measures security coverage breadth across the contract portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_insurance_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for the insurance register — tracking coverage amounts, premium costs, and compliance status. Used by risk managers and commercial directors to ensure adequate insurance coverage and regulatory compliance across the project portfolio."
  source: "`vibe_construction_v1`.`contract`.`insurance_register`"
  dimensions:
    - name: "insurance_register_status"
      expr: insurance_register_status
      comment: "Current status of the insurance policy (e.g. Active, Expired, Cancelled) — primary filter for coverage gap analysis."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of insurance coverage (e.g. Public Liability, Professional Indemnity, CAR) — enables coverage type analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the insurance policy — used for governance and audit reporting."
    - name: "risk_class"
      expr: risk_class
      comment: "Risk classification of the insured activity — used for risk-based insurance portfolio analysis."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the insurance policy — used for cross-border regulatory compliance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the coverage and premium amounts — required for multi-currency insurance portfolio consolidation."
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the insurance policy expires — critical for proactive renewal management and coverage continuity."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag indicating whether the policy meets regulatory requirements — used for compliance dashboard and audit reporting."
  measures:
    - name: "total_coverage_amount"
      expr: SUM(CAST(coverage_amount AS DOUBLE))
      comment: "Total insurance coverage amount across all policies. Primary KPI for assessing the adequacy of financial risk protection."
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total insurance premium cost across the portfolio. Key cost management KPI for risk financing decisions."
    - name: "total_deductible_amount"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductible exposure across all policies. Quantifies the self-insured risk retained by the organisation."
    - name: "avg_coverage_amount"
      expr: AVG(CAST(coverage_amount AS DOUBLE))
      comment: "Average coverage amount per policy. Benchmarks insurance sizing relative to project risk profiles."
    - name: "insurance_policy_count"
      expr: COUNT(1)
      comment: "Total number of insurance policies in the register. Baseline for insurance portfolio management and renewal workload."
    - name: "non_compliant_policy_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = FALSE THEN 1 END)
      comment: "Number of policies failing regulatory compliance. Critical risk indicator — non-compliant policies expose the organisation to regulatory penalties and uninsured losses."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_scope`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for contract scope management — tracking scope values, quantities, liquidated damages exposure, and change activity. Used by project controls and commercial managers to govern scope definition, change control, and financial performance."
  source: "`vibe_construction_v1`.`contract`.`scope`"
  dimensions:
    - name: "scope_status"
      expr: scope_status
      comment: "Current status of the scope item (e.g. Draft, Approved, Completed) — primary filter for scope portfolio health."
    - name: "scope_type"
      expr: scope_type
      comment: "Classification of the scope (e.g. Civil, Mechanical, Electrical) — enables discipline-level performance analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the scope item — used to prioritise management oversight and contingency planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the scope financial values — required for multi-currency consolidation."
    - name: "geographic_area"
      expr: geographic_area
      comment: "Geographic area of the scope — enables regional performance analysis."
    - name: "eot_entitlement_flag"
      expr: eot_entitlement_flag
      comment: "Flag indicating whether EOT entitlement applies to this scope — used to identify scope items with programme risk."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Planned start month of the scope — supports workload planning and schedule analysis."
  measures:
    - name: "total_scope_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total financial value of all scope items. Primary KPI for contract scope sizing and budget baseline management."
    - name: "total_scope_quantity"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total quantity across all scope items. Used for productivity benchmarking and unit-rate analysis."
    - name: "total_ld_exposure"
      expr: SUM(CAST(liquidated_damages_amount AS DOUBLE))
      comment: "Total liquidated damages exposure embedded in scope items. Quantifies maximum penalty risk from scope non-delivery."
    - name: "avg_scope_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average financial value per scope item. Benchmarks scope granularity and informs work packaging strategy."
    - name: "scope_item_count"
      expr: COUNT(1)
      comment: "Total number of scope items. Baseline for scope complexity and contract administration workload assessment."
    - name: "eot_entitled_scope_count"
      expr: COUNT(CASE WHEN eot_entitlement_flag = TRUE THEN 1 END)
      comment: "Number of scope items with EOT entitlement. Identifies the proportion of scope exposed to programme risk and delay claims."
$$;