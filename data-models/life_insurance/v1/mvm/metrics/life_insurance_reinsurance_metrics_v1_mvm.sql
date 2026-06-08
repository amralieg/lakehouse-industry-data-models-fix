-- Metric views for domain: reinsurance | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 06:54:29

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`reinsurance_treaty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for reinsurance treaty portfolio management — capacity utilization, retention economics, and treaty lifecycle health used by reinsurance executives to steer cession strategy and counterparty risk."
  source: "`life_insurance_ecm`.`reinsurance`.`treaty`"
  dimensions:
    - name: "treaty_type"
      expr: treaty_type
      comment: "Type of reinsurance treaty (e.g., YRT, Coinsurance, ModCo) — primary segmentation for treaty portfolio analysis."
    - name: "treaty_status"
      expr: treaty_status
      comment: "Current lifecycle status of the treaty (Active, Terminated, Pending) — used to filter in-force vs. run-off treaties."
    - name: "cession_basis"
      expr: cession_basis
      comment: "Basis on which risk is ceded (e.g., automatic, facultative) — drives operational workflow segmentation."
    - name: "currency"
      expr: currency
      comment: "Settlement currency of the treaty — required for multi-currency portfolio reporting."
    - name: "retrocession_flag"
      expr: retrocession_flag
      comment: "Indicates whether the treaty is a retrocession arrangement — separates primary reinsurance from retrocession exposure."
    - name: "rbc_credit_eligible_flag"
      expr: rbc_credit_eligible_flag
      comment: "Whether the treaty qualifies for RBC credit — critical for capital management and regulatory reporting."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the treaty became effective — used for cohort and vintage analysis of treaty portfolio."
    - name: "termination_date_year"
      expr: YEAR(termination_date)
      comment: "Year the treaty terminates — used to project run-off exposure and capacity expiry."
    - name: "preferred_cession_basis"
      expr: preferred_cession_basis
      comment: "Preferred cession basis specified in the treaty — used to assess alignment between treaty design and actual cession activity."
    - name: "product_lines_covered"
      expr: product_lines_covered
      comment: "Product lines covered under the treaty — enables treaty performance analysis by line of business."
  measures:
    - name: "active_treaty_count"
      expr: COUNT(CASE WHEN treaty_status = 'Active' THEN treaty_id END)
      comment: "Number of currently active reinsurance treaties — baseline measure of treaty portfolio breadth."
    - name: "total_capacity_limit"
      expr: SUM(CAST(capacity_limit AS DOUBLE))
      comment: "Total reinsurance capacity available across all treaties — key indicator of maximum cession headroom for the portfolio."
    - name: "total_retention_limit_amount"
      expr: SUM(CAST(retention_limit_amount AS DOUBLE))
      comment: "Aggregate retention limit across treaties — measures the total risk the company retains before ceding to reinsurers."
    - name: "total_automatic_binding_limit"
      expr: SUM(CAST(automatic_binding_limit AS DOUBLE))
      comment: "Total automatic binding capacity across treaties — indicates the volume of risk that can be ceded without facultative review."
    - name: "avg_cession_percentage"
      expr: AVG(CAST(cession_percentage AS DOUBLE))
      comment: "Average cession percentage across treaties — measures the typical proportion of risk transferred to reinsurers, informing retention strategy."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across treaties — counterpart to cession percentage; tracks how much risk the company keeps on average."
    - name: "avg_allowance_percentage"
      expr: AVG(CAST(allowance_percentage AS DOUBLE))
      comment: "Average reinsurance allowance (expense reimbursement) percentage across treaties — used to assess the cost-effectiveness of reinsurance arrangements."
    - name: "total_max_cession_amount"
      expr: SUM(CAST(max_cession_amount AS DOUBLE))
      comment: "Total maximum cession amount across all treaties — represents the upper bound of risk transfer capacity in the portfolio."
    - name: "rbc_eligible_treaty_count"
      expr: COUNT(CASE WHEN rbc_credit_eligible_flag = TRUE THEN treaty_id END)
      comment: "Number of treaties qualifying for RBC credit — directly impacts regulatory capital requirements and solvency ratios."
    - name: "retrocession_treaty_count"
      expr: COUNT(CASE WHEN retrocession_flag = TRUE THEN treaty_id END)
      comment: "Number of retrocession treaties — measures the depth of the reinsurance chain and counterparty concentration risk."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across treaties — used to benchmark reinsurance cost and negotiate treaty renewals."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`reinsurance_cession`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for individual risk cessions — tracks ceded face amount, NAR exposure, premium economics, and recapture activity to support cession management and reinsurer settlement."
  source: "`life_insurance_ecm`.`reinsurance`.`cession`"
  dimensions:
    - name: "cession_status"
      expr: cession_status
      comment: "Current status of the cession (Active, Terminated, Recaptured) — primary filter for in-force cession analysis."
    - name: "cession_type"
      expr: cession_type
      comment: "Type of cession (Automatic, Facultative) — distinguishes binding-limit cessions from individually underwritten ones."
    - name: "insured_gender"
      expr: insured_gender
      comment: "Gender of the insured — used for mortality experience and pricing adequacy analysis by demographic."
    - name: "smoker_status"
      expr: smoker_status
      comment: "Smoker/non-smoker classification of the insured — key risk segmentation variable for mortality and premium rate analysis."
    - name: "insured_risk_class"
      expr: insured_risk_class
      comment: "Underwriting risk class of the insured — used to assess cession mix by risk quality."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cession — required for multi-currency exposure reporting."
    - name: "cession_date_month"
      expr: DATE_TRUNC('MONTH', cession_date)
      comment: "Month the cession was established — used for new business cession volume trending."
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for cession termination (Death, Lapse, Recapture, Expiry) — used to analyze run-off drivers."
    - name: "nar_calculation_method"
      expr: nar_calculation_method
      comment: "Method used to calculate net amount at risk — used to validate consistency of NAR methodology across the cession portfolio."
    - name: "recapture_flag"
      expr: recapture_flag
      comment: "Indicates whether the cession has been recaptured — used to track recapture activity and its impact on retained exposure."
    - name: "policy_year"
      expr: policy_year
      comment: "Policy year of the cession — used for duration-based experience analysis and lapse/mortality studies."
  measures:
    - name: "active_cession_count"
      expr: COUNT(CASE WHEN cession_status = 'Active' THEN cession_id END)
      comment: "Number of active cessions in force — baseline measure of reinsurance portfolio size."
    - name: "total_ceded_face_amount"
      expr: SUM(CAST(ceded_face_amount AS DOUBLE))
      comment: "Total face amount ceded to reinsurers — primary measure of risk transfer volume and reinsurer exposure."
    - name: "total_nar_amount"
      expr: SUM(CAST(nar_amount AS DOUBLE))
      comment: "Total net amount at risk across all cessions — the actual mortality exposure ceded, used for reserve and capital calculations."
    - name: "total_reinsurance_premium_amount"
      expr: SUM(CAST(reinsurance_premium_amount AS DOUBLE))
      comment: "Total reinsurance premium ceded — measures the cost of reinsurance protection and is a key P&L driver."
    - name: "total_retained_amount"
      expr: SUM(CAST(retained_amount AS DOUBLE))
      comment: "Total amount retained by the company after cession — measures the net retained risk exposure."
    - name: "total_recaptured_amount"
      expr: SUM(CAST(recaptured_amount AS DOUBLE))
      comment: "Total face amount recaptured from reinsurers — tracks the volume of risk brought back in-house, impacting retained exposure and premium savings."
    - name: "total_recapture_penalty_amount"
      expr: SUM(CAST(recapture_penalty_amount AS DOUBLE))
      comment: "Total penalties incurred on recaptured cessions — measures the financial cost of recapture decisions."
    - name: "avg_cession_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average cession percentage across individual cessions — used to assess whether cession levels align with treaty terms."
    - name: "total_nar_account_value"
      expr: SUM(CAST(nar_account_value AS DOUBLE))
      comment: "Total account value component used in NAR calculations — relevant for variable and universal life products where NAR = death benefit minus account value."
    - name: "total_nar_death_benefit"
      expr: SUM(CAST(nar_death_benefit AS DOUBLE))
      comment: "Total death benefit component of NAR across cessions — used to validate NAR calculations and assess gross mortality exposure."
    - name: "recaptured_cession_count"
      expr: COUNT(CASE WHEN recapture_flag = TRUE THEN cession_id END)
      comment: "Number of cessions that have been recaptured — tracks recapture activity volume for treaty management and counterparty relationship monitoring."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`reinsurance_premium`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reinsurance premium financial KPIs — tracks gross, net, and ceded premium flows, allowances, experience refunds, and payment performance to support P&L management and reinsurer settlement reconciliation."
  source: "`life_insurance_ecm`.`reinsurance`.`premium`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the premium (Paid, Due, Overdue) — used to monitor settlement timeliness and identify outstanding receivables."
    - name: "billing_mode"
      expr: billing_mode
      comment: "Billing frequency (Monthly, Quarterly, Annual) — used to analyze premium cash flow patterns."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the premium — required for multi-currency premium reporting and FX exposure analysis."
    - name: "is_retrocession"
      expr: is_retrocession
      comment: "Indicates whether the premium relates to a retrocession arrangement — separates primary reinsurance cost from retrocession cost."
    - name: "risk_class"
      expr: risk_class
      comment: "Risk class of the insured — used to analyze premium adequacy by underwriting segment."
    - name: "insured_gender"
      expr: insured_gender
      comment: "Gender of the insured — used for demographic premium analysis and pricing adequacy review."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Month the billing period starts — used for premium trend analysis and period-over-period comparisons."
    - name: "policy_year"
      expr: policy_year
      comment: "Policy year of the premium — used for duration-based premium experience analysis."
    - name: "reinsurance_year"
      expr: reinsurance_year
      comment: "Reinsurance year of the premium — used for treaty-year experience and rate adequacy studies."
  measures:
    - name: "total_gross_premium_amount"
      expr: SUM(CAST(gross_premium_amount AS DOUBLE))
      comment: "Total gross reinsurance premium before allowances and adjustments — primary measure of reinsurance cost before offsets."
    - name: "total_net_premium_amount"
      expr: SUM(CAST(net_premium_amount AS DOUBLE))
      comment: "Total net reinsurance premium after allowances — the actual cash outflow to reinsurers, a key P&L line item."
    - name: "total_allowance_amount"
      expr: SUM(CAST(allowance_amount AS DOUBLE))
      comment: "Total reinsurance allowances received — measures the expense reimbursement from reinsurers, offsetting acquisition and maintenance costs."
    - name: "total_experience_refund_amount"
      expr: SUM(CAST(experience_refund_amount AS DOUBLE))
      comment: "Total experience refunds earned — measures profit-sharing returns from reinsurers based on favorable mortality experience."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total premium adjustments (corrections, retroactive changes) — used to monitor billing accuracy and identify systematic errors."
    - name: "total_ceded_nar"
      expr: SUM(CAST(ceded_nar AS DOUBLE))
      comment: "Total net amount at risk ceded — used to validate that premium levels are commensurate with the risk transferred."
    - name: "total_ceded_face_amount"
      expr: SUM(CAST(ceded_face_amount AS DOUBLE))
      comment: "Total face amount ceded in premium records — cross-validates cession face amount totals and supports bordereaux reconciliation."
    - name: "total_tax_withholding_amount"
      expr: SUM(CAST(tax_withholding_amount AS DOUBLE))
      comment: "Total tax withheld on reinsurance premiums — required for tax compliance reporting and net settlement calculations."
    - name: "avg_yrt_rate"
      expr: AVG(CAST(yrt_rate AS DOUBLE))
      comment: "Average YRT (Yearly Renewable Term) rate across premium records — used to benchmark reinsurance pricing competitiveness and rate adequacy."
    - name: "avg_coinsurance_percentage"
      expr: AVG(CAST(coinsurance_percentage AS DOUBLE))
      comment: "Average coinsurance percentage across premium records — measures the typical proportion of risk shared under coinsurance treaties."
    - name: "overdue_premium_count"
      expr: COUNT(CASE WHEN payment_status = 'Overdue' THEN premium_id END)
      comment: "Number of overdue reinsurance premium payments — operational KPI for settlement timeliness and counterparty credit risk monitoring."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`reinsurance_claim_recoverable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reinsurance claim recoverable KPIs — tracks gross and ceded claim amounts, recovery rates, dispute activity, and outstanding balances to support claims management, counterparty credit risk, and financial reporting."
  source: "`life_insurance_ecm`.`reinsurance`.`claim_recoverable`"
  dimensions:
    - name: "recoverable_status"
      expr: recoverable_status
      comment: "Current status of the recoverable (Submitted, Paid, Disputed, Outstanding) — primary filter for claims recovery pipeline management."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim (Death, Disability, Waiver) — used to analyze recovery patterns by claim cause."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Status of any dispute on the recoverable — used to track disputed amounts and resolution progress."
    - name: "is_disputed"
      expr: is_disputed
      comment: "Flag indicating whether the recoverable is under dispute — used to segment clean vs. disputed recovery pipeline."
    - name: "is_facultative"
      expr: is_facultative
      comment: "Indicates whether the recoverable relates to a facultative cession — used to separate automatic vs. facultative recovery performance."
    - name: "is_retrocession"
      expr: is_retrocession
      comment: "Indicates whether the recoverable is from a retrocession arrangement — used to track multi-layer recovery chains."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the recoverable — required for multi-currency claims reporting."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket of the outstanding recoverable (e.g., 0-30, 31-60, 61-90 days) — used for counterparty credit risk and collections prioritization."
    - name: "claim_event_date_month"
      expr: DATE_TRUNC('MONTH', claim_event_date)
      comment: "Month of the claim event — used for claims incidence trending and IBNR analysis."
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of dispute raised on the recoverable — used to identify systemic issues in claims submission or treaty interpretation."
  measures:
    - name: "total_recoverable_amount"
      expr: SUM(CAST(recoverable_amount AS DOUBLE))
      comment: "Total reinsurance recoverable amount — the primary asset measure representing amounts owed by reinsurers for ceded claims."
    - name: "total_ceded_claim_amount"
      expr: SUM(CAST(ceded_claim_amount AS DOUBLE))
      comment: "Total claim amount ceded to reinsurers — measures the gross risk transfer on claims, a key driver of reinsurance asset valuation."
    - name: "total_gross_claim_amount"
      expr: SUM(CAST(gross_claim_amount AS DOUBLE))
      comment: "Total gross claim amount before reinsurance — used to calculate the net retained loss and assess reinsurance effectiveness."
    - name: "total_amount_received"
      expr: SUM(CAST(amount_received AS DOUBLE))
      comment: "Total cash received from reinsurers on claims — measures actual recovery collections vs. amounts billed."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding recoverable balance not yet collected — key counterparty credit risk exposure metric."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount under dispute with reinsurers — measures the volume of contested recoverables requiring resolution."
    - name: "total_allowance_for_doubtful_recovery"
      expr: SUM(CAST(allowance_for_doubtful_recovery AS DOUBLE))
      comment: "Total allowance for doubtful recoverables — measures the credit loss provision on reinsurance assets, impacting net balance sheet value."
    - name: "avg_recoverable_percentage"
      expr: AVG(CAST(recoverable_percentage AS DOUBLE))
      comment: "Average recovery percentage across claim recoverables — measures the typical proportion of gross claims recovered from reinsurers."
    - name: "total_nar_at_cession"
      expr: SUM(CAST(nar_at_cession AS DOUBLE))
      comment: "Total net amount at risk at the time of cession for claims — used to validate that recoverable amounts are consistent with the risk originally ceded."
    - name: "disputed_recoverable_count"
      expr: COUNT(CASE WHEN is_disputed = TRUE THEN claim_recoverable_id END)
      comment: "Number of recoverables currently under dispute — operational KPI for reinsurer relationship management and legal exposure tracking."
    - name: "total_reinsurance_premium_paid"
      expr: SUM(CAST(reinsurance_premium_paid AS DOUBLE))
      comment: "Total reinsurance premium paid associated with claim recoverables — used to compute loss ratios and assess whether premium adequately covered claims."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`reinsurance_bordereaux`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bordereaux submission and settlement KPIs — tracks reporting compliance, cession volumes, premium and reserve totals, and settlement performance to support reinsurer reporting obligations and treaty administration."
  source: "`life_insurance_ecm`.`reinsurance`.`bordereaux`"
  dimensions:
    - name: "bordereaux_type"
      expr: bordereaux_type
      comment: "Type of bordereaux (Premium, Claims, Reserve) — used to segment reporting activity by function."
    - name: "submission_status"
      expr: submission_status
      comment: "Status of the bordereaux submission (Submitted, Acknowledged, Rejected) — used to monitor reporting compliance."
    - name: "cession_type"
      expr: cession_type
      comment: "Type of cession reported in the bordereaux — used to segment reporting by automatic vs. facultative business."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of bordereaux reporting (Monthly, Quarterly) — used to track reporting cadence compliance."
    - name: "is_retrocession"
      expr: is_retrocession
      comment: "Indicates whether the bordereaux covers retrocession business — separates primary and retrocession reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the bordereaux — required for multi-currency settlement reporting."
    - name: "product_line"
      expr: product_line
      comment: "Product line covered by the bordereaux — used for line-of-business reporting and treaty performance analysis."
    - name: "reporting_period_end_month"
      expr: DATE_TRUNC('MONTH', reporting_period_end_date)
      comment: "Month the reporting period ends — used for period-over-period bordereaux volume and settlement trending."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the bordereaux (Electronic, Manual) — used to track digitization progress and submission efficiency."
  measures:
    - name: "total_reinsurance_premium"
      expr: SUM(CAST(total_reinsurance_premium AS DOUBLE))
      comment: "Total reinsurance premium reported across all bordereaux — primary revenue/cost measure for reinsurance reporting periods."
    - name: "total_ceded_face_amount"
      expr: SUM(CAST(total_ceded_face_amount AS DOUBLE))
      comment: "Total face amount ceded as reported in bordereaux — measures the volume of risk transferred per reporting period."
    - name: "total_ceded_reserve"
      expr: SUM(CAST(total_ceded_reserve AS DOUBLE))
      comment: "Total ceded reserve reported in bordereaux — key balance sheet metric for reinsurance asset valuation."
    - name: "total_recoverables"
      expr: SUM(CAST(total_recoverables AS DOUBLE))
      comment: "Total recoverables reported in bordereaux — measures the aggregate claims recovery asset reported to reinsurers."
    - name: "total_allowance_amount"
      expr: SUM(CAST(total_allowance_amount AS DOUBLE))
      comment: "Total allowances reported in bordereaux — measures expense reimbursements from reinsurers across reporting periods."
    - name: "total_net_settlement_amount"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Total net settlement amount across bordereaux — the actual cash flow between cedant and reinsurer, a key treasury and liquidity metric."
    - name: "bordereaux_submission_count"
      expr: COUNT(bordereaux_id)
      comment: "Total number of bordereaux submitted — measures reporting activity volume and compliance with treaty reporting obligations."
    - name: "acknowledged_bordereaux_count"
      expr: COUNT(CASE WHEN submission_status = 'Acknowledged' THEN bordereaux_id END)
      comment: "Number of bordereaux acknowledged by reinsurers — measures reinsurer confirmation rate and identifies unacknowledged submissions requiring follow-up."
    - name: "avg_net_settlement_amount"
      expr: AVG(CAST(net_settlement_amount AS DOUBLE))
      comment: "Average net settlement amount per bordereaux — used to benchmark settlement size and detect anomalies in individual submissions."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`reinsurance_reserve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reinsurance reserve KPIs — tracks ceded reserve levels, RBC credit, IFRS 17 impacts, and reserve movements to support actuarial valuation, regulatory capital reporting, and financial close processes."
  source: "`life_insurance_ecm`.`reinsurance`.`reserve`"
  dimensions:
    - name: "reserve_type"
      expr: reserve_type
      comment: "Type of reserve (GAAP, Statutory, IFRS 17) — primary segmentation for reserve reporting by accounting basis."
    - name: "reserve_method"
      expr: reserve_method
      comment: "Actuarial method used to calculate the reserve — used to assess methodology consistency and regulatory compliance."
    - name: "basis"
      expr: basis
      comment: "Accounting basis of the reserve (GAAP, Statutory, Tax) — used to reconcile reserves across reporting frameworks."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the reserve — required for multi-currency reserve reporting."
    - name: "is_retrocession"
      expr: is_retrocession
      comment: "Indicates whether the reserve relates to a retrocession arrangement — used to separate primary and retrocession reserve layers."
    - name: "is_authorized_reinsurer"
      expr: is_authorized_reinsurer
      comment: "Indicates whether the reinsurer is authorized — authorized reinsurer status affects statutory credit for reinsurance."
    - name: "collateral_type"
      expr: collateral_type
      comment: "Type of collateral held against the reserve (LOC, Trust, Funds Withheld) — used to assess collateral adequacy for unauthorized reinsurer credit."
    - name: "valuation_date_quarter"
      expr: DATE_TRUNC('QUARTER', valuation_date)
      comment: "Quarter of the valuation date — used for quarterly reserve trend analysis and period-over-period comparisons."
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period label for the reserve — used to align reserve data with financial reporting cycles."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status of the reserve — used to track whether reserve-related settlements have been completed."
  measures:
    - name: "total_ceded_reserve_amount"
      expr: SUM(CAST(ceded_reserve_amount AS DOUBLE))
      comment: "Total ceded reserve amount — the primary reinsurance asset on the balance sheet representing reserves transferred to reinsurers."
    - name: "total_net_ceded_reserve_amount"
      expr: SUM(CAST(net_ceded_reserve_amount AS DOUBLE))
      comment: "Total net ceded reserve after adjustments — the net reinsurance reserve asset used in financial reporting."
    - name: "total_rbc_credit_amount"
      expr: SUM(CAST(rbc_credit_amount AS DOUBLE))
      comment: "Total RBC credit from reinsurance — measures the regulatory capital relief provided by reinsurance arrangements, a key solvency metric."
    - name: "total_ceded_nar_amount"
      expr: SUM(CAST(ceded_nar_amount AS DOUBLE))
      comment: "Total net amount at risk ceded in reserve records — used to validate reserve adequacy relative to the mortality exposure transferred."
    - name: "total_ceded_face_amount"
      expr: SUM(CAST(ceded_face_amount AS DOUBLE))
      comment: "Total face amount ceded in reserve records — cross-validates cession volumes against reserve levels."
    - name: "total_movement_amount"
      expr: SUM(CAST(movement_amount AS DOUBLE))
      comment: "Total reserve movement (change) in the period — measures the net change in ceded reserves, a key actuarial and financial close metric."
    - name: "total_collateral_amount"
      expr: SUM(CAST(collateral_amount AS DOUBLE))
      comment: "Total collateral held against ceded reserves — measures the security backing for unauthorized reinsurer credit, critical for statutory compliance."
    - name: "total_funds_withheld_balance"
      expr: SUM(CAST(funds_withheld_balance AS DOUBLE))
      comment: "Total funds withheld balance — measures the reserve assets retained by the cedant under funds-withheld treaty arrangements."
    - name: "total_ifrs17_csg_amount"
      expr: SUM(CAST(ifrs17_csg_amount AS DOUBLE))
      comment: "Total IFRS 17 contract service margin amount for ceded reserves — required for IFRS 17 reinsurance held reporting."
    - name: "total_ifrs17_ra_ceded_amount"
      expr: SUM(CAST(ifrs17_ra_ceded_amount AS DOUBLE))
      comment: "Total IFRS 17 risk adjustment ceded amount — measures the risk adjustment component of reinsurance held under IFRS 17."
    - name: "total_dac_ceded_amount"
      expr: SUM(CAST(dac_ceded_amount AS DOUBLE))
      comment: "Total deferred acquisition cost ceded to reinsurers — measures the DAC offset from reinsurance allowances, impacting GAAP earnings."
    - name: "avg_reinsurer_share_percentage"
      expr: AVG(CAST(reinsurer_share_percentage AS DOUBLE))
      comment: "Average reinsurer share percentage across reserve records — measures the typical proportion of reserve risk transferred, used to assess concentration."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`reinsurance_reinsurer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reinsurer counterparty KPIs — tracks credit quality, exposure limits, collateral requirements, and relationship health to support counterparty risk management and regulatory compliance."
  source: "`life_insurance_ecm`.`reinsurance`.`reinsurer`"
  dimensions:
    - name: "reinsurer_type"
      expr: reinsurer_type
      comment: "Type of reinsurer (Professional Reinsurer, Captive, Lloyd's Syndicate) — used to segment counterparty risk by reinsurer category."
    - name: "relationship_status"
      expr: relationship_status
      comment: "Current status of the reinsurer relationship (Active, Inactive, Watch) — primary filter for active counterparty monitoring."
    - name: "am_best_rating"
      expr: am_best_rating
      comment: "AM Best financial strength rating — primary credit quality indicator used for counterparty risk assessment and treaty approval."
    - name: "domicile_country"
      expr: domicile_country
      comment: "Country where the reinsurer is domiciled — used for geographic concentration and regulatory jurisdiction analysis."
    - name: "domicile_state"
      expr: domicile_state
      comment: "State of domicile for US reinsurers — used for authorized vs. unauthorized reinsurer classification and credit for reinsurance."
    - name: "collateral_required"
      expr: collateral_required
      comment: "Indicates whether collateral is required from the reinsurer — used to identify unauthorized reinsurers requiring collateral for statutory credit."
    - name: "watch_list_flag"
      expr: watch_list_flag
      comment: "Indicates whether the reinsurer is on the internal watch list — used to flag elevated counterparty credit risk for management attention."
    - name: "aml_kyc_status"
      expr: aml_kyc_status
      comment: "AML/KYC compliance status of the reinsurer — required for regulatory compliance and counterparty onboarding monitoring."
    - name: "reinsurance_agreement_type"
      expr: reinsurance_agreement_type
      comment: "Type of reinsurance agreement (Treaty, Facultative) — used to segment counterparty relationships by agreement structure."
    - name: "relationship_inception_date_year"
      expr: YEAR(relationship_inception_date)
      comment: "Year the reinsurer relationship began — used for relationship tenure analysis and counterparty diversification tracking."
  measures:
    - name: "active_reinsurer_count"
      expr: COUNT(CASE WHEN relationship_status = 'Active' THEN reinsurer_id END)
      comment: "Number of active reinsurer relationships — measures counterparty diversification and concentration risk."
    - name: "total_credit_exposure_limit"
      expr: SUM(CAST(credit_exposure_limit AS DOUBLE))
      comment: "Total credit exposure limit across all reinsurers — measures the maximum counterparty credit risk the company has approved."
    - name: "avg_rbc_counterparty_factor"
      expr: AVG(CAST(rbc_counterparty_factor AS DOUBLE))
      comment: "Average RBC counterparty default factor across reinsurers — measures the weighted credit quality of the reinsurer panel for capital modeling."
    - name: "watch_list_reinsurer_count"
      expr: COUNT(CASE WHEN watch_list_flag = TRUE THEN reinsurer_id END)
      comment: "Number of reinsurers on the internal watch list — key risk management KPI for elevated counterparty credit risk monitoring."
    - name: "collateral_required_reinsurer_count"
      expr: COUNT(CASE WHEN collateral_required = TRUE THEN reinsurer_id END)
      comment: "Number of reinsurers from whom collateral is required — measures the volume of unauthorized reinsurer relationships requiring collateral management."
    - name: "aml_kyc_non_compliant_count"
      expr: COUNT(CASE WHEN aml_kyc_status != 'Compliant' THEN reinsurer_id END)
      comment: "Number of reinsurers with non-compliant AML/KYC status — regulatory compliance KPI requiring immediate remediation action."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`reinsurance_reinsurer_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reinsurer settlement financial KPIs — tracks net settlement flows, premium and recoverable amounts, reconciliation status, and funds withheld balances to support treasury management and reinsurer accounting."
  source: "`life_insurance_ecm`.`reinsurance`.`reinsurer_settlement`"
  dimensions:
    - name: "settlement_status"
      expr: settlement_status
      comment: "Current status of the settlement (Pending, Completed, Disputed) — primary filter for settlement pipeline management."
    - name: "settlement_direction"
      expr: settlement_direction
      comment: "Direction of the settlement (Payable, Receivable) — used to separate cash outflows to reinsurers from recoveries received."
    - name: "settlement_frequency"
      expr: settlement_frequency
      comment: "Frequency of settlement (Monthly, Quarterly, Annual) — used to analyze cash flow timing and liquidity planning."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of the settlement reconciliation — used to identify unreconciled items requiring investigation."
    - name: "retrocession_indicator"
      expr: retrocession_indicator
      comment: "Indicates whether the settlement relates to a retrocession — separates primary reinsurance settlements from retrocession cash flows."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the settlement — required for multi-currency cash flow and FX exposure reporting."
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period of the settlement — used to align settlement data with financial close and period-end reporting."
    - name: "settlement_date_month"
      expr: DATE_TRUNC('MONTH', settlement_date)
      comment: "Month of settlement — used for cash flow trending and settlement timeliness analysis."
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account code for the settlement — used to reconcile reinsurance settlements to the general ledger."
  measures:
    - name: "total_net_settlement_amount"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Total net settlement amount — the primary cash flow measure for reinsurer settlements, used for treasury and liquidity management."
    - name: "total_gross_premium_amount"
      expr: SUM(CAST(gross_premium_amount AS DOUBLE))
      comment: "Total gross premium component of settlements — measures the premium cash flows included in reinsurer settlements."
    - name: "total_gross_recoverable_amount"
      expr: SUM(CAST(gross_recoverable_amount AS DOUBLE))
      comment: "Total gross recoverable amount in settlements — measures the claims recovery component of reinsurer settlements."
    - name: "total_allowance_amount"
      expr: SUM(CAST(allowance_amount AS DOUBLE))
      comment: "Total allowance amount in settlements — measures expense reimbursements included in settlement cash flows."
    - name: "total_experience_refund_amount"
      expr: SUM(CAST(experience_refund_amount AS DOUBLE))
      comment: "Total experience refunds in settlements — measures profit-sharing cash flows from favorable mortality experience."
    - name: "total_ibnr_recoverable_amount"
      expr: SUM(CAST(ibnr_recoverable_amount AS DOUBLE))
      comment: "Total IBNR recoverable amount in settlements — measures the incurred-but-not-reported claims component, important for reserve adequacy assessment."
    - name: "total_funds_withheld_balance"
      expr: SUM(CAST(funds_withheld_balance AS DOUBLE))
      comment: "Total funds withheld balance across settlements — measures assets retained by the cedant under funds-withheld arrangements, impacting investment income."
    - name: "total_reserve_adjustment_amount"
      expr: SUM(CAST(reserve_adjustment_amount AS DOUBLE))
      comment: "Total reserve adjustments in settlements — measures retroactive reserve corrections included in settlement cash flows."
    - name: "total_interest_adjustment_amount"
      expr: SUM(CAST(interest_adjustment_amount AS DOUBLE))
      comment: "Total interest adjustments in settlements — measures late payment interest charges or credits, used to monitor settlement timeliness costs."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied in settlements — used to monitor FX rate consistency and identify potential FX exposure in multi-currency settlements."
    - name: "pending_settlement_count"
      expr: COUNT(CASE WHEN settlement_status = 'Pending' THEN reinsurer_settlement_id END)
      comment: "Number of pending settlements — operational KPI for settlement pipeline management and cash flow forecasting."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`reinsurance_recapture_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reinsurance recapture event KPIs — tracks recaptured face amounts, NAR, premiums, penalties, and RBC impacts to support recapture strategy decisions and treaty management."
  source: "`life_insurance_ecm`.`reinsurance`.`recapture_event`"
  dimensions:
    - name: "recapture_status"
      expr: recapture_status
      comment: "Current status of the recapture event (Initiated, Completed, Withdrawn) — used to track recapture pipeline progress."
    - name: "recapture_trigger_type"
      expr: recapture_trigger_type
      comment: "Trigger that initiated the recapture (Rate Increase, Credit Downgrade, Eligibility) — used to analyze recapture drivers and inform treaty negotiation strategy."
    - name: "partial_recapture_flag"
      expr: partial_recapture_flag
      comment: "Indicates whether the recapture is partial or full — used to distinguish partial risk retrieval from full treaty recapture."
    - name: "penalty_waived_flag"
      expr: penalty_waived_flag
      comment: "Indicates whether the recapture penalty was waived — used to track negotiated concessions and their financial impact."
    - name: "retrocession_flag"
      expr: retrocession_flag
      comment: "Indicates whether the recapture involves a retrocession arrangement — used to track multi-layer recapture complexity."
    - name: "reinsurer_credit_rating"
      expr: reinsurer_credit_rating
      comment: "Credit rating of the reinsurer at time of recapture — used to analyze whether credit deterioration is a primary recapture driver."
    - name: "recapture_date_year"
      expr: YEAR(recapture_date)
      comment: "Year of recapture — used for annual recapture volume trending and treaty anniversary analysis."
    - name: "treaty_anniversary_year"
      expr: treaty_anniversary_year
      comment: "Treaty anniversary year at time of recapture — used to assess whether recaptures cluster around eligibility windows."
  measures:
    - name: "total_recaptured_face_amount"
      expr: SUM(CAST(recaptured_face_amount AS DOUBLE))
      comment: "Total face amount recaptured from reinsurers — primary measure of risk retrieval volume, directly increasing retained exposure."
    - name: "total_recaptured_nar_amount"
      expr: SUM(CAST(recaptured_nar_amount AS DOUBLE))
      comment: "Total net amount at risk recaptured — measures the actual mortality exposure retrieved, impacting reserve and capital requirements."
    - name: "total_recaptured_premium_amount"
      expr: SUM(CAST(recaptured_premium_amount AS DOUBLE))
      comment: "Total premium recaptured — measures the premium savings from recapture, a key financial benefit of recapture decisions."
    - name: "total_recaptured_reserve_amount"
      expr: SUM(CAST(recaptured_reserve_amount AS DOUBLE))
      comment: "Total reserve recaptured — measures the reserve liability retrieved from reinsurers, impacting balance sheet and capital."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total recapture penalties incurred — measures the financial cost of recapture decisions, used in recapture ROI analysis."
    - name: "total_rbc_impact_amount"
      expr: SUM(CAST(rbc_impact_amount AS DOUBLE))
      comment: "Total RBC capital impact from recapture events — measures the regulatory capital consequence of recapturing risk, critical for solvency planning."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amount paid or received on recapture — measures the net cash flow impact of recapture transactions."
    - name: "avg_recapture_percentage"
      expr: AVG(CAST(recapture_percentage AS DOUBLE))
      comment: "Average percentage of cession recaptured — measures the typical scale of recapture transactions relative to original cession size."
    - name: "avg_mortality_experience_ratio"
      expr: AVG(CAST(mortality_experience_ratio AS DOUBLE))
      comment: "Average mortality experience ratio at time of recapture — measures whether adverse mortality experience is driving recapture decisions."
    - name: "recapture_event_count"
      expr: COUNT(recapture_event_id)
      comment: "Total number of recapture events — baseline volume measure for recapture activity monitoring and treaty stability assessment."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`reinsurance_facultative_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facultative underwriting submission KPIs — tracks submission volumes, approval rates, cession amounts, and premium economics to support facultative underwriting performance and reinsurer relationship management."
  source: "`life_insurance_ecm`.`reinsurance`.`facultative_submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the facultative submission (Pending, Approved, Declined, Expired) — primary filter for submission pipeline management."
    - name: "underwriting_decision"
      expr: underwriting_decision
      comment: "Reinsurer underwriting decision (Approved, Declined, Modified) — used to analyze facultative acceptance rates by reinsurer and risk type."
    - name: "cession_type"
      expr: cession_type
      comment: "Type of cession in the facultative submission — used to segment submission activity by risk transfer structure."
    - name: "final_disposition"
      expr: final_disposition
      comment: "Final outcome of the facultative submission — used to track placement success rates and identify placement challenges."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel used to submit the facultative request (Direct, Broker) — used to analyze submission efficiency by channel."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the facultative submission — required for multi-currency facultative volume reporting."
    - name: "aps_required"
      expr: aps_required
      comment: "Indicates whether an Attending Physician Statement was required — used to analyze underwriting complexity and turnaround time drivers."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of submission — used for facultative volume trending and pipeline aging analysis."
    - name: "table_rating"
      expr: table_rating
      comment: "Table rating applied to the submission — used to analyze the risk quality mix of facultative submissions."
  measures:
    - name: "total_submission_count"
      expr: COUNT(facultative_submission_id)
      comment: "Total number of facultative submissions — baseline volume measure for facultative underwriting activity."
    - name: "approved_submission_count"
      expr: COUNT(CASE WHEN underwriting_decision = 'Approved' THEN facultative_submission_id END)
      comment: "Number of approved facultative submissions — used to calculate approval rates and assess reinsurer appetite for facultative risks."
    - name: "total_requested_cession_amount"
      expr: SUM(CAST(requested_cession_amount AS DOUBLE))
      comment: "Total cession amount requested in facultative submissions — measures the volume of risk seeking facultative placement."
    - name: "total_approved_cession_amount"
      expr: SUM(CAST(approved_cession_amount AS DOUBLE))
      comment: "Total cession amount approved by reinsurers — measures the volume of risk successfully placed facultatively."
    - name: "total_face_amount"
      expr: SUM(CAST(face_amount AS DOUBLE))
      comment: "Total face amount of policies submitted facultatively — measures the gross mortality exposure seeking reinsurance placement."
    - name: "total_nar_amount"
      expr: SUM(CAST(nar_amount AS DOUBLE))
      comment: "Total net amount at risk in facultative submissions — measures the actual mortality exposure submitted for facultative coverage."
    - name: "total_reinsurance_premium_amount"
      expr: SUM(CAST(reinsurance_premium_amount AS DOUBLE))
      comment: "Total reinsurance premium on approved facultative submissions — measures the cost of facultative reinsurance placement."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total amount retained by the company after facultative placement — measures the net retained exposure after facultative cession."
    - name: "avg_reinsurance_premium_rate"
      expr: AVG(CAST(reinsurance_premium_rate AS DOUBLE))
      comment: "Average reinsurance premium rate on facultative submissions — used to benchmark facultative pricing and assess rate competitiveness."
    - name: "avg_requested_cession_percentage"
      expr: AVG(CAST(requested_cession_percentage AS DOUBLE))
      comment: "Average cession percentage requested in facultative submissions — measures the typical proportion of risk sought for facultative placement."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`reinsurance_nar_calculation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Net Amount at Risk (NAR) calculation KPIs — tracks NAR levels, death benefit exposure, reinsurance premium adequacy, and reserve relationships to support actuarial valuation, pricing adequacy, and capital management."
  source: "`life_insurance_ecm`.`reinsurance`.`nar_calculation`"
  dimensions:
    - name: "calculation_status"
      expr: calculation_status
      comment: "Status of the NAR calculation (Final, Preliminary, Revised) — used to filter to authoritative calculation results."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate NAR (e.g., Death Benefit minus Account Value) — used to ensure methodology consistency across the portfolio."
    - name: "reinsurance_treaty_type"
      expr: reinsurance_treaty_type
      comment: "Type of reinsurance treaty underlying the NAR calculation — used to segment NAR exposure by treaty structure."
    - name: "insured_gender"
      expr: insured_gender
      comment: "Gender of the insured — used for demographic NAR analysis and mortality experience studies."
    - name: "smoker_status"
      expr: smoker_status
      comment: "Smoker/non-smoker status — key risk variable for NAR and premium rate adequacy analysis."
    - name: "risk_class"
      expr: risk_class
      comment: "Underwriting risk class — used to analyze NAR distribution by risk quality."
    - name: "is_retrocession"
      expr: is_retrocession
      comment: "Indicates whether the NAR calculation relates to a retrocession — used to separate primary and retrocession NAR exposure."
    - name: "rbc_credit_eligible"
      expr: rbc_credit_eligible
      comment: "Indicates whether the NAR qualifies for RBC credit — used to identify NAR contributing to regulatory capital relief."
    - name: "calculation_date_quarter"
      expr: DATE_TRUNC('QUARTER', calculation_date)
      comment: "Quarter of the NAR calculation — used for quarterly NAR trend analysis and period-over-period comparisons."
    - name: "product_type_code"
      expr: product_type_code
      comment: "Product type code (e.g., Term, UL, VUL) — used to analyze NAR exposure by product line."
    - name: "policy_year"
      expr: policy_year
      comment: "Policy year of the NAR calculation — used for duration-based NAR analysis and lapse/mortality experience studies."
  measures:
    - name: "total_nar_amount"
      expr: SUM(CAST(nar_amount AS DOUBLE))
      comment: "Total net amount at risk — the primary mortality exposure measure, representing the maximum loss the reinsurer would pay on ceded policies."
    - name: "total_ceded_death_benefit_amount"
      expr: SUM(CAST(ceded_death_benefit_amount AS DOUBLE))
      comment: "Total ceded death benefit amount — measures the gross death benefit exposure transferred to reinsurers."
    - name: "total_death_benefit_amount"
      expr: SUM(CAST(death_benefit_amount AS DOUBLE))
      comment: "Total gross death benefit amount — used to calculate the proportion of death benefit ceded and assess reinsurance coverage depth."
    - name: "total_reinsurance_premium_amount"
      expr: SUM(CAST(reinsurance_premium_amount AS DOUBLE))
      comment: "Total reinsurance premium associated with NAR calculations — used to assess premium adequacy relative to NAR exposure."
    - name: "total_policy_reserve_amount"
      expr: SUM(CAST(policy_reserve_amount AS DOUBLE))
      comment: "Total policy reserve amount in NAR calculations — used to validate NAR calculations (NAR = Death Benefit minus Reserve for some methods)."
    - name: "avg_coi_rate_per_thousand"
      expr: AVG(CAST(coi_rate_per_thousand AS DOUBLE))
      comment: "Average cost of insurance rate per thousand of NAR — used to benchmark reinsurance pricing adequacy and rate competitiveness."
    - name: "nar_calculation_count"
      expr: COUNT(nar_calculation_id)
      comment: "Total number of NAR calculations — measures the volume of NAR computation activity, used to validate completeness of actuarial runs."
$$;