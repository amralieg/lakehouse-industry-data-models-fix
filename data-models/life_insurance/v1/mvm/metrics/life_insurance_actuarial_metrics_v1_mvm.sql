-- Metric views for domain: actuarial | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 06:54:29

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`actuarial_reserve_calculation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core reserve adequacy and liability metrics derived from individual reserve calculations. Supports statutory, GAAP, and LDTI reserve monitoring, PBR compliance tracking, and experience variance analysis for actuarial steering and regulatory reporting."
  source: "`life_insurance_ecm`.`actuarial`.`reserve_calculation`"
  dimensions:
    - name: "valuation_date"
      expr: valuation_date
      comment: "Valuation date for the reserve calculation, used to track reserve balances over time and align with reporting periods."
    - name: "reserve_type"
      expr: reserve_type
      comment: "Type of reserve (e.g., Net Premium Reserve, GAAP, Statutory, LDTI LFPB) enabling segmentation by accounting basis."
    - name: "reporting_basis"
      expr: reporting_basis
      comment: "Reporting framework under which the reserve is calculated (e.g., GAAP, SAP, IFRS17), critical for regulatory and financial reporting."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Actuarial method used (e.g., PBR, Commissioner Reserve Method, Net Premium), enabling method-level performance comparison."
    - name: "calculation_status"
      expr: calculation_status
      comment: "Status of the reserve calculation (e.g., Approved, Pending, Rejected), used to filter production-quality results."
    - name: "pbr_floor_applied_flag"
      expr: pbr_floor_applied_flag
      comment: "Indicates whether the PBR floor was applied, a key regulatory compliance indicator under VM-20."
    - name: "model_version"
      expr: model_version
      comment: "Version of the actuarial model used, enabling model change impact tracking across valuation runs."
    - name: "reserve_currency_code"
      expr: reserve_currency_code
      comment: "Currency in which reserves are denominated, supporting multi-currency reserve reporting."
  measures:
    - name: "total_reserve_amount"
      expr: SUM(CAST(reserve_amount AS DOUBLE))
      comment: "Total gross reserve liability across all policies in scope. Primary balance sheet liability metric monitored by CFO and Chief Actuary."
    - name: "total_net_premium_reserve"
      expr: SUM(CAST(net_premium_reserve_amount AS DOUBLE))
      comment: "Aggregate net premium reserve, the statutory floor reserve under PBR (VM-20). Compared against stochastic and deterministic reserves to determine binding constraint."
    - name: "total_deterministic_reserve"
      expr: SUM(CAST(deterministic_reserve_amount AS DOUBLE))
      comment: "Sum of deterministic reserves across all model segments. Used to assess the deterministic scenario binding constraint under PBR."
    - name: "total_stochastic_reserve"
      expr: SUM(CAST(stochastic_reserve_amount AS DOUBLE))
      comment: "Aggregate stochastic reserve (CTE-based) across all segments. Reflects tail-risk capital requirement under adverse scenarios."
    - name: "total_reinsurance_ceded_reserve"
      expr: SUM(CAST(reinsurance_ceded_reserve AS DOUBLE))
      comment: "Total reserve ceded to reinsurers, representing the reinsurance credit reducing net reserve liability on the balance sheet."
    - name: "total_reinsurance_recoverable"
      expr: SUM(CAST(reinsurance_recoverable_amount AS DOUBLE))
      comment: "Total reinsurance recoverables recognized as an asset offsetting gross reserve liabilities."
    - name: "net_reserve_after_reinsurance"
      expr: SUM(CAST(reserve_amount AS DOUBLE) - CAST(reinsurance_ceded_reserve AS DOUBLE))
      comment: "Net reserve liability after deducting reinsurance ceded reserves. The true retained liability on the insurer's balance sheet."
    - name: "total_experience_variance"
      expr: SUM(CAST(experience_variance_amount AS DOUBLE))
      comment: "Aggregate experience variance (actual vs. expected) driving reserve movements. Negative variance indicates favorable experience; positive indicates adverse. Key actuarial steering metric."
    - name: "total_model_change_impact"
      expr: SUM(CAST(model_change_amount AS DOUBLE))
      comment: "Total reserve impact attributable to model changes in the current period. Quantifies model risk and supports model governance reporting."
    - name: "total_assumption_unlock_impact"
      expr: SUM(CAST(assumption_unlock_amount AS DOUBLE))
      comment: "Aggregate reserve impact from assumption unlocking events. Critical for LDTI and IFRS17 earnings attribution and assumption change governance."
    - name: "total_net_amount_at_risk"
      expr: SUM(CAST(net_amount_at_risk AS DOUBLE))
      comment: "Total net amount at risk (face amount minus account value) across all policies. Drives mortality risk exposure and reinsurance need assessment."
    - name: "avg_reserve_per_unit"
      expr: AVG(CAST(reserve_per_unit AS DOUBLE))
      comment: "Average reserve per unit of coverage. Benchmarks reserve adequacy per unit and detects anomalies in reserve density across product segments."
    - name: "avg_lapse_assumption_rate"
      expr: AVG(CAST(lapse_assumption_rate AS DOUBLE))
      comment: "Average lapse rate assumption used in reserve calculations. Monitors assumption consistency and flags potential assumption drift across cohorts."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate applied in reserve calculations. Tracks interest rate assumption levels and their impact on present value of liabilities."
    - name: "total_boy_reserve"
      expr: SUM(CAST(boy_reserve_amount AS DOUBLE))
      comment: "Total beginning-of-year reserve balance. Used as the opening balance in reserve roll-forward analysis to explain reserve movements."
    - name: "total_eoy_reserve"
      expr: SUM(CAST(eoy_reserve_amount AS DOUBLE))
      comment: "Total end-of-year reserve balance. Closing balance in reserve roll-forward; compared to BOY reserve to quantify net reserve change."
    - name: "reserve_count"
      expr: COUNT(1)
      comment: "Number of reserve calculation records in scope. Used to validate completeness of the valuation run and detect missing policy segments."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`actuarial_valuation_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Valuation run performance, completeness, and reserve summary metrics. Supports actuarial operations monitoring, model governance, and regulatory compliance tracking across valuation cycles."
  source: "`life_insurance_ecm`.`actuarial`.`valuation_run`"
  dimensions:
    - name: "valuation_date"
      expr: valuation_date
      comment: "Valuation date of the run, the primary time dimension for tracking reserve levels and run quality across reporting periods."
    - name: "valuation_period_type"
      expr: valuation_period_type
      comment: "Period type (e.g., Monthly, Quarterly, Annual) enabling period-over-period reserve trend analysis."
    - name: "valuation_basis"
      expr: valuation_basis
      comment: "Accounting basis of the valuation (e.g., GAAP, Statutory, IFRS17), critical for multi-basis reserve reporting."
    - name: "run_type"
      expr: run_type
      comment: "Type of valuation run (e.g., Production, Test, Restatement), used to filter to production-quality results."
    - name: "run_status"
      expr: run_status
      comment: "Completion status of the valuation run (e.g., Completed, Failed, In Progress), used to monitor actuarial operations health."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of the reserve reconciliation process, indicating whether the run has been validated against prior period and source systems."
    - name: "pbr_compliant_flag"
      expr: pbr_compliant_flag
      comment: "Indicates whether the valuation run meets PBR (VM-20/VM-21) compliance requirements, a key regulatory indicator."
    - name: "ldti_compliant_flag"
      expr: ldti_compliant_flag
      comment: "Indicates LDTI (ASC 944) compliance of the valuation run, required for GAAP financial reporting under the updated standard."
    - name: "model_version"
      expr: model_version
      comment: "Actuarial model version used in the run, enabling model change impact tracking and governance."
    - name: "data_source_system"
      expr: data_source_system
      comment: "Source system providing policy data for the valuation run, used to trace data lineage and reconciliation issues."
  measures:
    - name: "total_reserve_amount"
      expr: SUM(CAST(total_reserve_amount AS DOUBLE))
      comment: "Total reserve liability across all valuation runs in scope. Primary actuarial balance sheet metric reported to CFO and regulators."
    - name: "total_account_value"
      expr: SUM(CAST(total_account_value AS DOUBLE))
      comment: "Total policyholder account value across all in-force policies in the valuation run. Key metric for separate account and universal life product monitoring."
    - name: "total_face_amount"
      expr: SUM(CAST(total_face_amount AS DOUBLE))
      comment: "Total face amount (death benefit exposure) across all in-force policies. Measures gross mortality risk exposure in the portfolio."
    - name: "total_dac_balance"
      expr: SUM(CAST(dac_balance AS DOUBLE))
      comment: "Total Deferred Acquisition Cost (DAC) balance across valuation runs. A key GAAP asset that amortizes against earned premiums and impacts earnings."
    - name: "total_voba_balance"
      expr: SUM(CAST(voba_balance AS DOUBLE))
      comment: "Total Value of Business Acquired (VOBA) balance. Represents the present value of future profits from acquired blocks, monitored for amortization adequacy."
    - name: "total_in_force_policy_count"
      expr: SUM(CAST(in_force_policy_count AS BIGINT))
      comment: "Total number of in-force policies across valuation runs. Tracks portfolio size and growth, a fundamental business volume metric."
    - name: "avg_variance_from_prior_period"
      expr: AVG(CAST(variance_from_prior_period AS DOUBLE))
      comment: "Average reserve variance from the prior period across runs. Monitors reserve volatility and flags unusual movements requiring actuarial investigation."
    - name: "total_variance_from_prior_period"
      expr: SUM(CAST(variance_from_prior_period AS DOUBLE))
      comment: "Total reserve change versus prior period across all runs. Quantifies the net reserve movement for earnings attribution and management reporting."
    - name: "completed_run_count"
      expr: COUNT(CASE WHEN run_status = 'Completed' THEN 1 END)
      comment: "Number of successfully completed valuation runs. Measures actuarial operations throughput and run reliability."
    - name: "pbr_compliant_run_count"
      expr: COUNT(CASE WHEN pbr_compliant_flag = TRUE THEN 1 END)
      comment: "Number of valuation runs meeting PBR compliance requirements. Tracks regulatory compliance posture across the valuation cycle."
    - name: "ldti_compliant_run_count"
      expr: COUNT(CASE WHEN ldti_compliant_flag = TRUE THEN 1 END)
      comment: "Number of valuation runs meeting LDTI compliance requirements. Tracks GAAP compliance readiness for financial close."
    - name: "total_run_count"
      expr: COUNT(1)
      comment: "Total number of valuation runs executed. Used to assess actuarial operations volume and run frequency."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`actuarial_cash_flow_projection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash flow projection metrics supporting asset-liability management, reserve adequacy testing, and profitability analysis. Covers premium inflows, benefit outflows, investment income, and duration/convexity risk metrics."
  source: "`life_insurance_ecm`.`actuarial`.`cash_flow_projection`"
  dimensions:
    - name: "valuation_date"
      expr: valuation_date
      comment: "Valuation date of the cash flow projection, the primary time anchor for ALM and reserve analysis."
    - name: "projection_date"
      expr: projection_date
      comment: "Future date to which cash flows are projected, enabling term structure analysis of liability cash flows."
    - name: "projection_period"
      expr: projection_period
      comment: "Projection period label (e.g., Year 1, Year 5, Year 10), used to analyze cash flow patterns over the policy lifecycle."
    - name: "projection_basis"
      expr: projection_basis
      comment: "Basis of projection (e.g., Best Estimate, Adverse, Stochastic), enabling scenario comparison for stress testing."
    - name: "scenario_type"
      expr: scenario_type
      comment: "Economic scenario type (e.g., Base, Stress, Tail), critical for ALM and capital adequacy analysis."
    - name: "product_segment_code"
      expr: product_segment_code
      comment: "Product segment driving the cash flows, enabling profitability and liability analysis by product line."
    - name: "cte_level"
      expr: cte_level
      comment: "Conditional Tail Expectation level (e.g., CTE70, CTE90) associated with the projection, used for PBR and capital reporting."
    - name: "model_version"
      expr: model_version
      comment: "Actuarial model version used for the projection, supporting model change impact analysis."
  measures:
    - name: "total_premium_inflow"
      expr: SUM(CAST(premium_inflow_amount AS DOUBLE))
      comment: "Total projected premium inflows. Primary revenue driver in cash flow projections, used in profitability and ALM analysis."
    - name: "total_benefit_outflow"
      expr: SUM(CAST(benefit_outflow_amount AS DOUBLE))
      comment: "Total projected benefit outflows (death benefits, surrenders, maturities). The largest liability cash flow component, critical for reserve adequacy and ALM."
    - name: "total_expense_outflow"
      expr: SUM(CAST(expense_outflow_amount AS DOUBLE))
      comment: "Total projected expense outflows including maintenance and acquisition costs. Impacts profitability and pricing adequacy assessments."
    - name: "total_commission_outflow"
      expr: SUM(CAST(commission_outflow_amount AS DOUBLE))
      comment: "Total projected commission outflows. Monitors distribution cost efficiency and its impact on product profitability."
    - name: "total_investment_income"
      expr: SUM(CAST(investment_income_amount AS DOUBLE))
      comment: "Total projected investment income. Key asset-side cash flow supporting liability funding and spread income analysis."
    - name: "total_net_cash_flow"
      expr: SUM(CAST(net_cash_flow_amount AS DOUBLE))
      comment: "Total net cash flow (inflows minus outflows) across all projection periods. The primary ALM metric indicating whether assets are sufficient to fund liabilities."
    - name: "total_present_value"
      expr: SUM(CAST(present_value_amount AS DOUBLE))
      comment: "Total present value of projected cash flows. The discounted liability measure used in reserve calculations and economic capital assessment."
    - name: "total_reserve_amount"
      expr: SUM(CAST(reserve_amount AS DOUBLE))
      comment: "Total reserve amount from cash flow projections. Validates reserve levels against projection-based estimates."
    - name: "total_reinsurance_ceded_premium"
      expr: SUM(CAST(reinsurance_ceded_premium_amount AS DOUBLE))
      comment: "Total reinsurance premiums ceded in projections. Quantifies the cost of reinsurance protection and its impact on net cash flows."
    - name: "total_reinsurance_recoverable"
      expr: SUM(CAST(reinsurance_recoverable_amount AS DOUBLE))
      comment: "Total projected reinsurance recoverables. Measures the benefit of reinsurance in offsetting projected benefit outflows."
    - name: "total_nar_amount"
      expr: SUM(CAST(nar_amount AS DOUBLE))
      comment: "Total Net Amount at Risk (NAR) across projections. Measures mortality risk exposure net of account value, driving COI charges and reinsurance needs."
    - name: "total_risk_adjustment"
      expr: SUM(CAST(risk_adjustment_amount AS DOUBLE))
      comment: "Total risk adjustment applied to projected cash flows. Required under IFRS17 to reflect uncertainty in non-financial risk, impacting reported profit."
    - name: "total_csm_balance"
      expr: SUM(CAST(csm_balance_amount AS DOUBLE))
      comment: "Total Contractual Service Margin (CSM) balance from projections. The unearned profit liability under IFRS17, released to income as services are provided."
    - name: "avg_liability_duration"
      expr: AVG(CAST(liability_duration AS DOUBLE))
      comment: "Average liability duration across projections. Core ALM metric measuring interest rate sensitivity of liabilities; compared to asset duration to manage duration gap."
    - name: "avg_asset_duration"
      expr: AVG(CAST(asset_duration AS DOUBLE))
      comment: "Average asset duration across projections. Paired with liability duration to assess and manage the asset-liability duration gap."
    - name: "avg_duration_gap"
      expr: AVG(CAST(duration_gap AS DOUBLE))
      comment: "Average duration gap (asset duration minus liability duration). A positive gap indicates interest rate risk; monitored by the ALM committee to guide hedging strategy."
    - name: "avg_lapse_rate"
      expr: AVG(CAST(lapse_rate AS DOUBLE))
      comment: "Average projected lapse rate across cash flow scenarios. Monitors policyholder behavior assumptions and their impact on liability run-off."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate applied in cash flow projections. Tracks the interest rate environment's impact on present value of liabilities."
    - name: "projection_record_count"
      expr: COUNT(1)
      comment: "Total number of cash flow projection records. Used to validate projection completeness and coverage across policy cohorts and scenarios."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`actuarial_experience_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Experience study metrics measuring actual-to-expected performance across mortality, lapse, and other decrements. Drives assumption updates, reserve adequacy assessments, and regulatory credibility evaluations."
  source: "`life_insurance_ecm`.`actuarial`.`experience_study`"
  dimensions:
    - name: "study_type"
      expr: study_type
      comment: "Type of experience study (e.g., Mortality, Lapse, Morbidity), the primary segmentation for assumption governance."
    - name: "study_status"
      expr: study_status
      comment: "Current status of the study (e.g., In Progress, Approved, Superseded), used to filter to production-quality studies."
    - name: "product_segment"
      expr: product_segment
      comment: "Product segment covered by the study, enabling experience analysis by product line for targeted assumption updates."
    - name: "study_methodology"
      expr: study_methodology
      comment: "Actuarial methodology used (e.g., Intercompany, Company-Specific, Blended), affecting credibility weighting and regulatory acceptance."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the study (e.g., NAIC, SOA, ASOP), critical for compliance and assumption governance."
    - name: "valuation_date"
      expr: valuation_date
      comment: "Valuation date associated with the experience study, used to align study results with reserve valuation cycles."
    - name: "study_period_start_date"
      expr: study_period_start_date
      comment: "Start date of the experience study observation period, defining the data window for credibility assessment."
    - name: "study_period_end_date"
      expr: study_period_end_date
      comment: "End date of the experience study observation period, used to assess recency and relevance of study findings."
    - name: "materiality_threshold_met_flag"
      expr: materiality_threshold_met_flag
      comment: "Indicates whether the experience deviation meets the materiality threshold requiring assumption update, a key governance trigger."
    - name: "assumption_locked_flag"
      expr: assumption_locked_flag
      comment: "Indicates whether assumptions have been locked based on this study, preventing further updates until the next review cycle."
  measures:
    - name: "total_actual_events"
      expr: SUM(CAST(actual_events AS BIGINT))
      comment: "Total number of actual decrements (deaths, lapses, claims) observed in the study period. The numerator of the A/E ratio."
    - name: "total_expected_events"
      expr: SUM(CAST(expected_events AS DOUBLE))
      comment: "Total expected decrements based on current assumptions. The denominator of the A/E ratio; compared to actuals to assess assumption adequacy."
    - name: "total_exposure_amount"
      expr: SUM(CAST(exposure_amount AS DOUBLE))
      comment: "Total exposure (policy-years or face amount at risk) underlying the study. Drives credibility weighting and statistical significance assessment."
    - name: "avg_ae_ratio"
      expr: AVG(CAST(ae_ratio AS DOUBLE))
      comment: "Average Actual-to-Expected (A/E) ratio across studies. The primary experience study KPI — values above 1.0 indicate adverse experience requiring assumption strengthening."
    - name: "total_impact_on_reserves"
      expr: SUM(CAST(impact_on_reserves_amount AS DOUBLE))
      comment: "Total estimated reserve impact if assumptions are updated based on study findings. Quantifies the financial materiality of experience deviations."
    - name: "total_impact_on_capital"
      expr: SUM(CAST(impact_on_capital_amount AS DOUBLE))
      comment: "Total estimated capital impact from experience deviations. Informs capital planning and risk-based capital adequacy assessments."
    - name: "avg_recommended_adjustment_factor"
      expr: AVG(CAST(recommended_adjustment_factor AS DOUBLE))
      comment: "Average recommended assumption adjustment factor from study findings. Directly informs the magnitude of assumption updates in the next valuation cycle."
    - name: "avg_recommended_assumption_change_pct"
      expr: AVG(CAST(recommended_assumption_change_pct AS DOUBLE))
      comment: "Average recommended percentage change to current assumptions. Quantifies the direction and magnitude of assumption updates needed."
    - name: "avg_credibility_weight"
      expr: AVG(CAST(credibility_weight AS DOUBLE))
      comment: "Average credibility weight assigned to study results. Determines how much weight company experience receives versus industry tables in blended assumptions."
    - name: "avg_variance_from_expected"
      expr: AVG(CAST(variance_from_expected AS DOUBLE))
      comment: "Average variance between actual and expected experience. Tracks assumption accuracy over time and identifies systematic biases requiring correction."
    - name: "total_policy_count"
      expr: SUM(CAST(policy_count AS BIGINT))
      comment: "Total number of policies included in experience studies. Measures the breadth of experience data supporting assumption credibility."
    - name: "materiality_threshold_met_count"
      expr: COUNT(CASE WHEN materiality_threshold_met_flag = TRUE THEN 1 END)
      comment: "Number of studies where experience deviation meets the materiality threshold. Triggers mandatory assumption review and governance escalation."
    - name: "study_count"
      expr: COUNT(1)
      comment: "Total number of experience studies. Tracks actuarial assumption governance activity and study pipeline completeness."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`actuarial_experience_study_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular experience study result metrics at the segment level (age band, gender, smoker status, product). Enables detailed A/E analysis, credibility assessment, and assumption refinement at the most granular level used in pricing and reserving."
  source: "`life_insurance_ecm`.`actuarial`.`experience_study_result`"
  dimensions:
    - name: "experience_type"
      expr: experience_type
      comment: "Type of experience being measured (e.g., Mortality, Lapse, Disability), the primary classification for assumption governance."
    - name: "gender"
      expr: gender
      comment: "Gender of the insured population in the study segment, a key rating variable in mortality and morbidity experience analysis."
    - name: "smoker_status"
      expr: smoker_status
      comment: "Smoker/non-smoker classification, a critical mortality risk factor affecting A/E ratios and assumption differentiation."
    - name: "age_band"
      expr: age_band
      comment: "Age band of the study segment, enabling age-graded experience analysis for mortality and lapse assumption development."
    - name: "attained_age"
      expr: attained_age
      comment: "Attained age of the insured, providing granular age-specific experience for mortality table construction."
    - name: "product_segment"
      expr: product_segment
      comment: "Product segment of the study result, enabling product-level experience comparison and assumption differentiation."
    - name: "product_code"
      expr: product_code
      comment: "Specific product code for the study result, enabling product-level experience monitoring."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel associated with the study segment, used to detect channel-specific experience differences."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the study segment, enabling regional experience analysis for geographic risk differentiation."
    - name: "policy_duration_band"
      expr: policy_duration_band
      comment: "Policy duration band (select vs. ultimate period), critical for select-and-ultimate mortality table construction."
    - name: "result_status"
      expr: result_status
      comment: "Status of the study result (e.g., Approved, Preliminary), used to filter to finalized results for assumption updates."
    - name: "accounting_standard"
      expr: accounting_standard
      comment: "Accounting standard applicable to the result (e.g., GAAP, IFRS17, SAP), enabling multi-basis experience reporting."
  measures:
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual claim or decrement amount observed. The numerator in amount-based A/E analysis, used alongside expected amounts to assess assumption adequacy."
    - name: "total_expected_amount"
      expr: SUM(CAST(expected_amount AS DOUBLE))
      comment: "Total expected claim or decrement amount based on current assumptions. Compared to actual amounts to compute amount-based A/E ratios."
    - name: "total_expected_count"
      expr: SUM(CAST(expected_count AS DOUBLE))
      comment: "Total expected number of decrements based on current assumptions. Used in count-based A/E analysis alongside actual counts."
    - name: "total_exposure_amount"
      expr: SUM(CAST(exposure_amount AS DOUBLE))
      comment: "Total exposure underlying the study results. Drives credibility weighting — higher exposure yields more credible company-specific experience."
    - name: "avg_ae_ratio_amount"
      expr: AVG(CAST(ae_ratio_amount AS DOUBLE))
      comment: "Average amount-based A/E ratio across study result segments. Values above 1.0 indicate adverse experience; below 1.0 indicate favorable. Primary assumption adequacy KPI."
    - name: "avg_ae_ratio_count"
      expr: AVG(CAST(ae_ratio_count AS DOUBLE))
      comment: "Average count-based A/E ratio across study result segments. Complements amount-based A/E to detect anti-selection or size effects in experience."
    - name: "avg_credibility_factor"
      expr: AVG(CAST(credibility_factor AS DOUBLE))
      comment: "Average credibility factor assigned to study result segments. Determines the blend between company experience and industry tables in assumption development."
    - name: "avg_variance"
      expr: AVG(CAST(variance AS DOUBLE))
      comment: "Average statistical variance of experience results. Measures the reliability of experience estimates and informs confidence intervals around A/E ratios."
    - name: "avg_statistical_confidence_level"
      expr: AVG(CAST(statistical_confidence_level AS DOUBLE))
      comment: "Average statistical confidence level of study results. Validates whether experience deviations are statistically significant before triggering assumption updates."
    - name: "result_segment_count"
      expr: COUNT(1)
      comment: "Total number of experience study result segments. Measures the granularity and completeness of experience analysis across rating cells."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`actuarial_reserve_snapshot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Point-in-time reserve snapshot metrics for balance sheet reporting, reserve adequacy monitoring, and period-over-period reserve movement analysis. Supports statutory, GAAP, and IFRS17 reporting."
  source: "`life_insurance_ecm`.`actuarial`.`reserve_snapshot`"
  dimensions:
    - name: "snapshot_date"
      expr: snapshot_date
      comment: "Date of the reserve snapshot, the primary time dimension for tracking reserve balances across reporting periods."
    - name: "reserve_type"
      expr: reserve_type
      comment: "Type of reserve captured in the snapshot (e.g., GAAP, Statutory, IFRS17 BEL), enabling multi-basis reserve reporting."
    - name: "valuation_basis"
      expr: valuation_basis
      comment: "Accounting basis of the snapshot valuation, used to segment reserves by reporting framework."
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period label (e.g., Q1 2024, FY2023), used to align snapshots with financial reporting cycles."
    - name: "reserve_adequacy_status"
      expr: reserve_adequacy_status
      comment: "Actuarial assessment of reserve adequacy (e.g., Adequate, Deficient, Redundant), a critical governance and regulatory indicator."
    - name: "product_code"
      expr: product_code
      comment: "Product code associated with the reserve snapshot, enabling product-level reserve monitoring."
  measures:
    - name: "total_reserve_balance"
      expr: SUM(CAST(reserve_balance AS DOUBLE))
      comment: "Total gross reserve balance at snapshot date. The primary balance sheet liability metric for actuarial and financial reporting."
    - name: "total_net_reserve"
      expr: SUM(CAST(net_reserve AS DOUBLE))
      comment: "Total net reserve after reinsurance ceded. The retained liability on the insurer's balance sheet, used in solvency and capital adequacy assessments."
    - name: "total_reinsurance_ceded_reserve"
      expr: SUM(CAST(reinsurance_ceded_reserve AS DOUBLE))
      comment: "Total reserve ceded to reinsurers at snapshot date. Quantifies reinsurance credit and counterparty exposure."
    - name: "total_pbr_deterministic_reserve"
      expr: SUM(CAST(pbr_deterministic_reserve AS DOUBLE))
      comment: "Total PBR deterministic reserve across all snapshots. Tracks the deterministic scenario binding constraint under VM-20 for regulatory capital purposes."
    - name: "total_pbr_stochastic_reserve"
      expr: SUM(CAST(pbr_stochastic_reserve AS DOUBLE))
      comment: "Total PBR stochastic reserve (CTE-based) across snapshots. Measures tail-risk capital requirement under adverse stochastic scenarios."
    - name: "total_pbr_net_premium_reserve"
      expr: SUM(CAST(pbr_net_premium_reserve AS DOUBLE))
      comment: "Total PBR net premium reserve (statutory floor) across snapshots. The minimum reserve floor under VM-20 that cannot be released regardless of stochastic results."
    - name: "total_account_value"
      expr: SUM(CAST(av AS DOUBLE))
      comment: "Total policyholder account value at snapshot date. Measures the policyholder-owned asset base for universal life and annuity products."
    - name: "total_cash_surrender_value"
      expr: SUM(CAST(csv AS DOUBLE))
      comment: "Total cash surrender value across all policies in the snapshot. Represents the maximum policyholder liquidity demand and a key lapse risk metric."
    - name: "total_nar"
      expr: SUM(CAST(nar AS DOUBLE))
      comment: "Total Net Amount at Risk (NAR) at snapshot date. Measures gross mortality exposure net of account value, driving COI charges and reinsurance cession decisions."
    - name: "total_dac_balance"
      expr: SUM(CAST(dac_balance AS DOUBLE))
      comment: "Total DAC balance at snapshot date. Tracks the unamortized acquisition cost asset and its adequacy relative to expected future profits."
    - name: "total_ldti_transition_adjustment"
      expr: SUM(CAST(ldti_transition_adjustment AS DOUBLE))
      comment: "Total LDTI transition adjustment recorded at snapshot date. Quantifies the cumulative impact of adopting ASC 944 (LDTI) on the balance sheet."
    - name: "avg_lapse_rate_assumption"
      expr: AVG(CAST(lapse_rate_assumption AS DOUBLE))
      comment: "Average lapse rate assumption used in reserve snapshots. Monitors assumption consistency and detects drift that could signal reserve inadequacy."
    - name: "avg_interest_rate_assumption"
      expr: AVG(CAST(interest_rate_assumption AS DOUBLE))
      comment: "Average interest rate assumption in reserve snapshots. Tracks the discount rate environment and its impact on present value of liabilities."
    - name: "reserve_deficiency_count"
      expr: COUNT(CASE WHEN reserve_adequacy_status = 'Deficient' THEN 1 END)
      comment: "Number of reserve snapshots flagged as deficient. A critical risk indicator requiring immediate actuarial investigation and potential reserve strengthening."
    - name: "snapshot_count"
      expr: COUNT(1)
      comment: "Total number of reserve snapshots. Used to validate completeness of reserve reporting coverage across all policy segments."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`actuarial_pricing_basis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing basis metrics supporting product profitability monitoring, pricing assumption governance, and competitive positioning analysis. Tracks target ROI, NBV, profit margins, and expense loading across product lines."
  source: "`life_insurance_ecm`.`actuarial`.`pricing_basis`"
  dimensions:
    - name: "basis_type"
      expr: basis_type
      comment: "Type of pricing basis (e.g., Initial, Revised, Regulatory), enabling tracking of pricing changes over the product lifecycle."
    - name: "pricing_basis_status"
      expr: pricing_basis_status
      comment: "Status of the pricing basis (e.g., Active, Superseded, Pending Approval), used to filter to current production pricing."
    - name: "effective_date"
      expr: effective_date
      comment: "Date from which the pricing basis is effective, used to track pricing changes and their impact on new business profitability."
    - name: "filing_jurisdiction"
      expr: filing_jurisdiction
      comment: "State or jurisdiction where the pricing basis is filed, enabling jurisdiction-level pricing compliance monitoring."
    - name: "reserve_basis"
      expr: reserve_basis
      comment: "Reserve basis underlying the pricing (e.g., GAAP, Statutory), affecting profit margin calculations and regulatory compliance."
    - name: "expense_loading_method"
      expr: expense_loading_method
      comment: "Method used to load expenses into pricing (e.g., Percent of Premium, Per Policy), affecting pricing competitiveness and adequacy."
    - name: "gender_distinct_pricing_flag"
      expr: gender_distinct_pricing_flag
      comment: "Indicates whether gender-distinct pricing is applied, relevant for regulatory compliance in jurisdictions with unisex pricing requirements."
    - name: "smoker_status_pricing_flag"
      expr: smoker_status_pricing_flag
      comment: "Indicates whether smoker/non-smoker distinction is used in pricing, a key mortality risk differentiation factor."
    - name: "mortality_improvement_scale"
      expr: mortality_improvement_scale
      comment: "Mortality improvement scale applied in pricing (e.g., MP-2021), affecting long-term mortality cost projections."
  measures:
    - name: "avg_target_roi"
      expr: AVG(CAST(target_roi AS DOUBLE))
      comment: "Average target Return on Investment across pricing bases. The primary profitability target metric used by product management and the CFO to evaluate pricing adequacy."
    - name: "avg_profit_margin_target_pct"
      expr: AVG(CAST(profit_margin_target_pct AS DOUBLE))
      comment: "Average target profit margin percentage across pricing bases. Tracks whether pricing is set to achieve required profitability thresholds."
    - name: "total_target_nbv"
      expr: SUM(CAST(target_nbv AS DOUBLE))
      comment: "Total target New Business Value (NBV) across pricing bases. Measures the expected value creation from new business written under current pricing."
    - name: "avg_investment_return_assumption"
      expr: AVG(CAST(investment_return_assumption AS DOUBLE))
      comment: "Average investment return assumption used in pricing. Monitors the interest rate environment embedded in pricing and its adequacy relative to current market conditions."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate applied in pricing bases. Tracks the cost of capital assumption embedded in pricing and its impact on profitability metrics."
    - name: "avg_acquisition_expense_rate"
      expr: AVG(CAST(acquisition_expense_rate AS DOUBLE))
      comment: "Average acquisition expense rate loaded into pricing. Monitors distribution cost efficiency and its impact on pricing competitiveness."
    - name: "avg_maintenance_expense_rate"
      expr: AVG(CAST(maintenance_expense_rate AS DOUBLE))
      comment: "Average maintenance expense rate in pricing. Tracks ongoing expense efficiency and its impact on long-term product profitability."
    - name: "avg_reinsurance_cession_rate"
      expr: AVG(CAST(reinsurance_cession_rate AS DOUBLE))
      comment: "Average reinsurance cession rate in pricing. Quantifies the cost of reinsurance protection embedded in product pricing."
    - name: "total_maximum_face_amount"
      expr: SUM(CAST(maximum_face_amount AS DOUBLE))
      comment: "Total maximum face amount capacity across pricing bases. Measures the aggregate mortality risk capacity authorized under current pricing."
    - name: "total_minimum_face_amount"
      expr: SUM(CAST(minimum_face_amount AS DOUBLE))
      comment: "Total minimum face amount threshold across pricing bases. Tracks the minimum coverage floor ensuring pricing adequacy at small face amounts."
    - name: "active_pricing_basis_count"
      expr: COUNT(CASE WHEN pricing_basis_status = 'Active' THEN 1 END)
      comment: "Number of currently active pricing bases. Tracks the breadth of active product pricing and identifies products requiring pricing review."
    - name: "pricing_basis_count"
      expr: COUNT(1)
      comment: "Total number of pricing bases. Measures the scope of pricing governance activity across the product portfolio."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`actuarial_assumption_set`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assumption set governance metrics tracking the quality, completeness, and financial impact of actuarial assumptions used in valuation and pricing. Supports assumption change management, peer review compliance, and profitability target monitoring."
  source: "`life_insurance_ecm`.`actuarial`.`assumption_set`"
  dimensions:
    - name: "assumption_basis"
      expr: assumption_basis
      comment: "Basis of the assumption set (e.g., Best Estimate, Prudent, Regulatory), the primary classification for assumption governance."
    - name: "assumption_set_status"
      expr: assumption_set_status
      comment: "Status of the assumption set (e.g., Active, Superseded, Draft), used to filter to production-quality assumptions."
    - name: "regulatory_basis"
      expr: regulatory_basis
      comment: "Regulatory framework governing the assumption set (e.g., NAIC, IFRS17, GAAP), enabling multi-basis assumption tracking."
    - name: "model_platform"
      expr: model_platform
      comment: "Actuarial modeling platform used with this assumption set (e.g., MG-ALFA, Prophet, AXIS), supporting model governance."
    - name: "valuation_date"
      expr: valuation_date
      comment: "Valuation date for which the assumption set is applicable, aligning assumptions with reporting periods."
    - name: "effective_date"
      expr: effective_date
      comment: "Date from which the assumption set is effective, used to track assumption change history."
    - name: "peer_review_completed_flag"
      expr: peer_review_completed_flag
      comment: "Indicates whether peer review has been completed for the assumption set, a mandatory governance control under actuarial standards."
    - name: "reinsurance_assumption_flag"
      expr: reinsurance_assumption_flag
      comment: "Indicates whether reinsurance assumptions are included in the set, affecting net reserve and cash flow projections."
    - name: "interest_rate_scenario"
      expr: interest_rate_scenario
      comment: "Interest rate scenario underlying the assumption set (e.g., Level, Rising, Falling), used for scenario-based assumption analysis."
  measures:
    - name: "avg_investment_return_assumption_pct"
      expr: AVG(CAST(investment_return_assumption_pct AS DOUBLE))
      comment: "Average investment return assumption across assumption sets. Monitors the interest rate environment embedded in assumptions and its adequacy relative to market conditions."
    - name: "avg_expense_loading_pct"
      expr: AVG(CAST(expense_loading_pct AS DOUBLE))
      comment: "Average expense loading percentage across assumption sets. Tracks expense assumption levels and their impact on reserve and pricing adequacy."
    - name: "avg_credibility_factor"
      expr: AVG(CAST(credibility_factor AS DOUBLE))
      comment: "Average credibility factor applied across assumption sets. Measures the weight given to company-specific experience versus industry tables."
    - name: "avg_profit_margin_target_pct"
      expr: AVG(CAST(profit_margin_target_pct AS DOUBLE))
      comment: "Average profit margin target embedded in assumption sets. Tracks whether assumptions are calibrated to achieve required profitability thresholds."
    - name: "avg_roi_target_pct"
      expr: AVG(CAST(roi_target_pct AS DOUBLE))
      comment: "Average ROI target across assumption sets. Monitors whether actuarial assumptions are aligned with the company's return on investment objectives."
    - name: "total_nbv_target_amount"
      expr: SUM(CAST(nbv_target_amount AS DOUBLE))
      comment: "Total New Business Value target across assumption sets. Measures the aggregate expected value creation embedded in current actuarial assumptions."
    - name: "peer_reviewed_count"
      expr: COUNT(CASE WHEN peer_review_completed_flag = TRUE THEN 1 END)
      comment: "Number of assumption sets with completed peer review. Tracks compliance with actuarial peer review requirements under ASOP and regulatory standards."
    - name: "active_assumption_set_count"
      expr: COUNT(CASE WHEN assumption_set_status = 'Active' THEN 1 END)
      comment: "Number of currently active assumption sets. Monitors the breadth of active assumptions in use and identifies sets requiring review or update."
    - name: "assumption_set_count"
      expr: COUNT(1)
      comment: "Total number of assumption sets. Measures the scope of assumption governance activity across valuation and pricing processes."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`actuarial_stochastic_scenario`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stochastic scenario metrics supporting capital adequacy assessment, stress testing, and regulatory reporting (ORSA, RBC). Tracks scenario severity, reserve stress impacts, and capital adequacy conclusions across economic scenario sets."
  source: "`life_insurance_ecm`.`actuarial`.`stochastic_scenario`"
  dimensions:
    - name: "scenario_status"
      expr: scenario_status
      comment: "Status of the scenario (e.g., Active, Superseded, Pending Validation), used to filter to production-quality scenarios."
    - name: "scenario_purpose"
      expr: scenario_purpose
      comment: "Purpose of the scenario (e.g., PBR, ORSA, ALM, Capital), enabling scenario usage tracking across regulatory and internal frameworks."
    - name: "stress_type"
      expr: stress_type
      comment: "Type of stress applied (e.g., Interest Rate Shock, Equity Crash, Pandemic), used to categorize capital stress scenarios."
    - name: "stress_severity"
      expr: stress_severity
      comment: "Severity level of the stress scenario (e.g., Mild, Moderate, Severe), enabling tiered capital adequacy analysis."
    - name: "capital_adequacy_conclusion"
      expr: capital_adequacy_conclusion
      comment: "Actuarial conclusion on capital adequacy under the scenario (e.g., Adequate, Marginal, Deficient), a key board and regulatory reporting metric."
    - name: "board_approval_status"
      expr: board_approval_status
      comment: "Board approval status of the scenario set, required for ORSA and regulatory capital submissions."
    - name: "valuation_date"
      expr: valuation_date
      comment: "Valuation date of the stochastic scenario, aligning capital stress results with reporting periods."
  measures:
    - name: "total_stressed_reserve_impact"
      expr: SUM(CAST(stressed_reserve_impact_amount AS DOUBLE))
      comment: "Total reserve impact under stress scenarios. Quantifies the capital at risk under adverse economic conditions, the primary metric for capital adequacy assessment."
    - name: "avg_stressed_reserve_impact"
      expr: AVG(CAST(stressed_reserve_impact_amount AS DOUBLE))
      comment: "Average reserve impact per stress scenario. Benchmarks the typical capital cost of adverse scenarios and informs capital buffer sizing."
    - name: "avg_rbc_ratio_under_stress"
      expr: AVG(CAST(rbc_ratio_under_stress AS DOUBLE))
      comment: "Average Risk-Based Capital (RBC) ratio under stress scenarios. The primary regulatory capital adequacy metric — values below 200% trigger regulatory action."
    - name: "avg_cte_level"
      expr: AVG(CAST(cte_level AS DOUBLE))
      comment: "Average CTE level across stochastic scenarios. Tracks the tail risk percentile used in capital calculations, ensuring consistency with PBR and ORSA requirements."
    - name: "avg_scenario_weight"
      expr: AVG(CAST(scenario_weight AS DOUBLE))
      comment: "Average probability weight assigned to stochastic scenarios. Validates that scenario weights sum correctly and that tail scenarios receive appropriate probability mass."
    - name: "capital_deficiency_scenario_count"
      expr: COUNT(CASE WHEN capital_adequacy_conclusion = 'Deficient' THEN 1 END)
      comment: "Number of scenarios resulting in a capital deficiency conclusion. A critical risk indicator — any deficiency triggers immediate capital remediation planning."
    - name: "board_approved_scenario_count"
      expr: COUNT(CASE WHEN board_approval_status = 'Approved' THEN 1 END)
      comment: "Number of scenarios with board approval. Tracks governance compliance for ORSA and regulatory capital submissions requiring board sign-off."
    - name: "total_scenario_count"
      expr: COUNT(1)
      comment: "Total number of stochastic scenarios. Validates scenario set completeness against regulatory requirements (e.g., NAIC minimum scenario counts for PBR)."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`actuarial_cohort_definition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cohort-level metrics for LDTI and IFRS17 liability grouping, profitability classification, and assumption monitoring. Supports long-duration contract accounting, cohort-level reserve adequacy, and DAC amortization governance."
  source: "`life_insurance_ecm`.`actuarial`.`cohort_definition`"
  dimensions:
    - name: "cohort_type"
      expr: cohort_type
      comment: "Type of cohort (e.g., LDTI, IFRS17, PBR), the primary classification for long-duration contract accounting groupings."
    - name: "cohort_status"
      expr: cohort_status
      comment: "Status of the cohort (e.g., Active, Closed, Run-off), used to filter to active cohorts for ongoing reserve monitoring."
    - name: "accounting_standard"
      expr: accounting_standard
      comment: "Accounting standard governing the cohort (e.g., LDTI/ASC944, IFRS17), enabling multi-basis cohort reporting."
    - name: "profitability_classification"
      expr: profitability_classification
      comment: "IFRS17 profitability classification (Profitable, Onerous, Neutral), a mandatory grouping for IFRS17 contract boundary and CSM recognition."
    - name: "issue_year"
      expr: issue_year
      comment: "Issue year of the cohort, the primary time dimension for cohort-based reserve development and experience analysis."
    - name: "issue_quarter"
      expr: issue_quarter
      comment: "Issue quarter of the cohort, enabling quarterly cohort-level reserve and profitability tracking."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel of the cohort, enabling channel-level profitability and reserve analysis."
    - name: "geographic_market"
      expr: geographic_market
      comment: "Geographic market of the cohort, supporting regional reserve and profitability analysis."
    - name: "dac_amortization_method"
      expr: dac_amortization_method
      comment: "DAC amortization method applied to the cohort (e.g., Gross Premium, EGP), affecting earnings pattern and DAC adequacy."
    - name: "reinsurance_treaty_applicable"
      expr: reinsurance_treaty_applicable
      comment: "Indicates whether a reinsurance treaty applies to the cohort, affecting net reserve and cash flow projections."
  measures:
    - name: "total_initial_csm_amount"
      expr: SUM(CAST(initial_csm_amount AS DOUBLE))
      comment: "Total initial Contractual Service Margin (CSM) recognized at cohort inception. Represents the unearned profit from new business, a key IFRS17 value creation metric."
    - name: "total_initial_lfpb_amount"
      expr: SUM(CAST(initial_lfpb_amount AS DOUBLE))
      comment: "Total initial Liability for Future Policy Benefits (LFPB) at cohort inception. The primary LDTI reserve liability recognized at contract issue."
    - name: "total_account_value"
      expr: SUM(CAST(total_account_value AS DOUBLE))
      comment: "Total policyholder account value across cohorts. Measures the aggregate policyholder-owned asset base for investment-linked products."
    - name: "total_face_amount"
      expr: SUM(CAST(total_face_amount AS DOUBLE))
      comment: "Total face amount (death benefit exposure) across cohorts. Measures gross mortality risk in the cohort portfolio."
    - name: "avg_current_discount_rate"
      expr: AVG(CAST(current_discount_rate AS DOUBLE))
      comment: "Average current discount rate across cohorts. Tracks the OCI discount rate used in LDTI LFPB remeasurement, impacting other comprehensive income."
    - name: "avg_locked_in_discount_rate"
      expr: AVG(CAST(locked_in_discount_rate AS DOUBLE))
      comment: "Average locked-in discount rate across cohorts. The original issue-date discount rate used in LDTI net premium ratio calculations, affecting earnings recognition."
    - name: "avg_lapse_assumption_rate"
      expr: AVG(CAST(lapse_assumption_rate AS DOUBLE))
      comment: "Average lapse assumption rate across cohorts. Monitors assumption consistency and detects drift that could signal reserve inadequacy or assumption update needs."
    - name: "avg_expense_assumption_rate"
      expr: AVG(CAST(expense_assumption_rate AS DOUBLE))
      comment: "Average expense assumption rate across cohorts. Tracks expense loading adequacy relative to actual expense experience."
    - name: "avg_expected_contract_life_years"
      expr: AVG(CAST(expected_contract_life_years AS DOUBLE))
      comment: "Average expected contract life in years across cohorts. Drives DAC amortization period and long-term liability projection horizon."
    - name: "onerous_cohort_count"
      expr: COUNT(CASE WHEN profitability_classification = 'Onerous' THEN 1 END)
      comment: "Number of cohorts classified as onerous under IFRS17. Onerous cohorts require immediate loss recognition — a critical profitability and capital adequacy indicator."
    - name: "active_cohort_count"
      expr: COUNT(CASE WHEN cohort_status = 'Active' THEN 1 END)
      comment: "Number of active cohorts in the portfolio. Tracks the breadth of in-force business under long-duration contract accounting."
    - name: "cohort_count"
      expr: COUNT(1)
      comment: "Total number of cohort definitions. Validates completeness of cohort groupings for LDTI and IFRS17 reporting."
$$;