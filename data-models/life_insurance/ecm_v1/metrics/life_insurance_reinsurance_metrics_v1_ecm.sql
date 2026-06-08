-- Metric views for domain: reinsurance | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 03:35:10

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`reinsurance_cession`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core reinsurance cession metrics tracking ceded face amounts, NAR, premiums, and recapture activity across treaties and reinsurers"
  source: "`life_insurance_ecm`.`reinsurance`.`reinsurance_cession`"
  dimensions:
    - name: "cession_status"
      expr: cession_status
      comment: "Current status of the reinsurance cession (active, terminated, recaptured)"
    - name: "cession_type"
      expr: cession_type
      comment: "Type of cession arrangement (automatic, facultative, coinsurance, YRT)"
    - name: "insured_gender"
      expr: insured_gender
      comment: "Gender of the insured life"
    - name: "insured_risk_class"
      expr: insured_risk_class
      comment: "Underwriting risk classification of the insured"
    - name: "smoker_status"
      expr: smoker_status
      comment: "Smoking status of the insured"
    - name: "policy_year"
      expr: policy_year
      comment: "Policy year for experience tracking"
    - name: "premium_mode"
      expr: premium_mode
      comment: "Premium payment frequency (annual, semi-annual, quarterly, monthly)"
    - name: "recapture_flag"
      expr: recapture_flag
      comment: "Indicator whether cession has been recaptured"
    - name: "recapture_trigger"
      expr: recapture_trigger
      comment: "Business reason triggering recapture event"
    - name: "cession_year"
      expr: YEAR(cession_date)
      comment: "Year when cession was established"
    - name: "cession_quarter"
      expr: CONCAT('Q', QUARTER(cession_date), '-', YEAR(cession_date))
      comment: "Quarter when cession was established"
    - name: "bordereaux_period"
      expr: bordereaux_period
      comment: "Reporting period for bordereaux submission"
  measures:
    - name: "total_ceded_face_amount"
      expr: SUM(CAST(ceded_face_amount AS DOUBLE))
      comment: "Total face amount ceded to reinsurers - primary measure of reinsurance capacity utilization"
    - name: "total_nar_amount"
      expr: SUM(CAST(nar_amount AS DOUBLE))
      comment: "Total Net Amount at Risk ceded - key measure of mortality risk transferred"
    - name: "total_reinsurance_premium"
      expr: SUM(CAST(reinsurance_premium_amount AS DOUBLE))
      comment: "Total reinsurance premiums paid - primary cost of reinsurance protection"
    - name: "total_retained_amount"
      expr: SUM(CAST(retained_amount AS DOUBLE))
      comment: "Total face amount retained by ceding company after reinsurance"
    - name: "total_recaptured_amount"
      expr: SUM(CAST(recaptured_amount AS DOUBLE))
      comment: "Total face amount recaptured from reinsurers - measures capacity reclamation"
    - name: "total_recapture_penalty"
      expr: SUM(CAST(recapture_penalty_amount AS DOUBLE))
      comment: "Total penalties paid for early recapture - cost of reclaiming capacity"
    - name: "avg_cession_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average percentage of risk ceded per policy"
    - name: "avg_automatic_binding_limit"
      expr: AVG(CAST(automatic_binding_limit AS DOUBLE))
      comment: "Average automatic binding limit across cessions - measures treaty efficiency"
    - name: "cession_count"
      expr: COUNT(DISTINCT reinsurance_cession_id)
      comment: "Number of distinct reinsurance cessions - volume measure"
    - name: "recaptured_cession_count"
      expr: COUNT(DISTINCT CASE WHEN recapture_flag = TRUE THEN reinsurance_cession_id END)
      comment: "Number of cessions that have been recaptured"
    - name: "cession_recapture_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN recapture_flag = TRUE THEN reinsurance_cession_id END) / NULLIF(COUNT(DISTINCT reinsurance_cession_id), 0), 2)
      comment: "Percentage of cessions recaptured - strategic measure of capacity management"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`reinsurance_claim_recoverable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reinsurance claim recovery metrics tracking ceded claims, recoverables, disputes, and collection efficiency"
  source: "`life_insurance_ecm`.`reinsurance`.`claim_recoverable`"
  dimensions:
    - name: "recoverable_status"
      expr: recoverable_status
      comment: "Current status of the recoverable (pending, submitted, paid, disputed)"
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim (death, disability, surrender, maturity)"
    - name: "is_disputed"
      expr: is_disputed
      comment: "Flag indicating whether recoverable is under dispute"
    - name: "dispute_status"
      expr: dispute_status
      comment: "Status of dispute resolution process"
    - name: "dispute_type"
      expr: dispute_type
      comment: "Category of dispute (coverage, amount, documentation)"
    - name: "is_facultative"
      expr: is_facultative
      comment: "Indicator whether recoverable is from facultative reinsurance"
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Age category of outstanding recoverable (0-30, 31-60, 61-90, 90+ days)"
    - name: "bordereaux_period"
      expr: bordereaux_period
      comment: "Reporting period for bordereaux submission"
    - name: "claim_event_year"
      expr: YEAR(claim_event_date)
      comment: "Year when claim event occurred"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year when recoverable was submitted to reinsurer"
  measures:
    - name: "total_recoverable_amount"
      expr: SUM(CAST(recoverable_amount AS DOUBLE))
      comment: "Total amount recoverable from reinsurers - primary measure of reinsurance asset value"
    - name: "total_ceded_claim_amount"
      expr: SUM(CAST(ceded_claim_amount AS DOUBLE))
      comment: "Total claim amount ceded to reinsurers"
    - name: "total_amount_received"
      expr: SUM(CAST(amount_received AS DOUBLE))
      comment: "Total cash received from reinsurers - measures collection effectiveness"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total uncollected recoverable balance - key liquidity and credit risk measure"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount under dispute with reinsurers - measures relationship friction"
    - name: "total_allowance_for_doubtful_recovery"
      expr: SUM(CAST(allowance_for_doubtful_recovery AS DOUBLE))
      comment: "Total allowance for uncollectible recoverables - credit risk reserve"
    - name: "avg_recoverable_percentage"
      expr: AVG(CAST(recoverable_percentage AS DOUBLE))
      comment: "Average percentage of claim recovered from reinsurers"
    - name: "recoverable_count"
      expr: COUNT(DISTINCT claim_recoverable_id)
      comment: "Number of distinct recoverables - volume measure"
    - name: "disputed_recoverable_count"
      expr: COUNT(DISTINCT CASE WHEN is_disputed = TRUE THEN claim_recoverable_id END)
      comment: "Number of recoverables under dispute"
    - name: "collection_rate"
      expr: ROUND(100.0 * SUM(CAST(amount_received AS DOUBLE)) / NULLIF(SUM(CAST(recoverable_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of recoverables collected - key efficiency and credit quality metric"
    - name: "dispute_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_disputed = TRUE THEN claim_recoverable_id END) / NULLIF(COUNT(DISTINCT claim_recoverable_id), 0), 2)
      comment: "Percentage of recoverables disputed - measures reinsurer relationship quality"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`reinsurance_treaty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reinsurance treaty metrics tracking treaty capacity, terms, and strategic treaty portfolio management"
  source: "`life_insurance_ecm`.`reinsurance`.`reinsurance_treaty`"
  dimensions:
    - name: "treaty_status"
      expr: treaty_status
      comment: "Current status of the treaty (active, expired, terminated, pending)"
    - name: "treaty_type"
      expr: treaty_type
      comment: "Type of reinsurance treaty (YRT, coinsurance, modified coinsurance, excess)"
    - name: "cession_basis"
      expr: cession_basis
      comment: "Basis for cession calculation (automatic, facultative, quota share)"
    - name: "experience_refund_flag"
      expr: experience_refund_flag
      comment: "Indicator whether treaty includes experience refund provisions"
    - name: "funds_withheld_flag"
      expr: funds_withheld_flag
      comment: "Indicator whether treaty uses funds withheld arrangement"
    - name: "rbc_credit_eligible_flag"
      expr: rbc_credit_eligible_flag
      comment: "Indicator whether treaty qualifies for RBC credit - regulatory capital relief measure"
    - name: "retrocession_flag"
      expr: retrocession_flag
      comment: "Indicator whether treaty involves retrocession"
    - name: "collateral_type"
      expr: collateral_type
      comment: "Type of collateral securing the treaty"
    - name: "governing_law_state"
      expr: governing_law_state
      comment: "State law governing the treaty"
    - name: "product_lines_covered"
      expr: product_lines_covered
      comment: "Product lines covered by the treaty"
    - name: "treaty_effective_year"
      expr: YEAR(effective_date)
      comment: "Year when treaty became effective"
  measures:
    - name: "total_capacity_limit"
      expr: SUM(CAST(capacity_limit AS DOUBLE))
      comment: "Total reinsurance capacity across all treaties - primary measure of risk transfer capability"
    - name: "total_automatic_binding_limit"
      expr: SUM(CAST(automatic_binding_limit AS DOUBLE))
      comment: "Total automatic binding capacity - measures operational efficiency of treaty portfolio"
    - name: "total_retention_limit"
      expr: SUM(CAST(retention_limit_amount AS DOUBLE))
      comment: "Total retention limits across treaties - measures risk retained by ceding company"
    - name: "total_max_cession_amount"
      expr: SUM(CAST(max_cession_amount AS DOUBLE))
      comment: "Total maximum cession amounts - upper bound of reinsurance protection"
    - name: "avg_cession_percentage"
      expr: AVG(CAST(cession_percentage AS DOUBLE))
      comment: "Average cession percentage across treaties"
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate paid by reinsurers - measures treaty profitability"
    - name: "avg_allowance_percentage"
      expr: AVG(CAST(allowance_percentage AS DOUBLE))
      comment: "Average expense allowance percentage - measures treaty economics"
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage - measures risk sharing balance"
    - name: "treaty_count"
      expr: COUNT(DISTINCT reinsurance_treaty_id)
      comment: "Number of distinct reinsurance treaties - portfolio diversification measure"
    - name: "active_treaty_count"
      expr: COUNT(DISTINCT CASE WHEN treaty_status = 'active' THEN reinsurance_treaty_id END)
      comment: "Number of currently active treaties"
    - name: "rbc_eligible_treaty_count"
      expr: COUNT(DISTINCT CASE WHEN rbc_credit_eligible_flag = TRUE THEN reinsurance_treaty_id END)
      comment: "Number of treaties eligible for RBC credit - regulatory capital efficiency measure"
    - name: "experience_refund_treaty_count"
      expr: COUNT(DISTINCT CASE WHEN experience_refund_flag = TRUE THEN reinsurance_treaty_id END)
      comment: "Number of treaties with experience refund provisions - profit sharing measure"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`reinsurance_reinsurer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reinsurer counterparty metrics tracking credit quality, relationship status, and counterparty risk management"
  source: "`life_insurance_ecm`.`reinsurance`.`reinsurer`"
  dimensions:
    - name: "relationship_status"
      expr: relationship_status
      comment: "Current status of reinsurer relationship (active, inactive, terminated, watch list)"
    - name: "reinsurer_type"
      expr: reinsurer_type
      comment: "Type of reinsurer (professional, captive, pool)"
    - name: "am_best_rating"
      expr: am_best_rating
      comment: "AM Best credit rating - primary credit quality indicator"
    - name: "am_best_outlook"
      expr: am_best_outlook
      comment: "AM Best rating outlook (stable, positive, negative)"
    - name: "sp_rating"
      expr: sp_rating
      comment: "S&P credit rating"
    - name: "moodys_rating"
      expr: moodys_rating
      comment: "Moody's credit rating"
    - name: "internal_credit_grade"
      expr: internal_credit_grade
      comment: "Internal credit grade assigned by ceding company"
    - name: "watch_list_flag"
      expr: watch_list_flag
      comment: "Indicator whether reinsurer is on credit watch list - early warning signal"
    - name: "collateral_required"
      expr: collateral_required
      comment: "Indicator whether collateral is required from reinsurer"
    - name: "collateral_type"
      expr: collateral_type
      comment: "Type of collateral held"
    - name: "domicile_country"
      expr: domicile_country
      comment: "Country of domicile"
    - name: "domicile_state"
      expr: domicile_state
      comment: "State of domicile for US reinsurers"
    - name: "aml_kyc_status"
      expr: aml_kyc_status
      comment: "AML/KYC compliance status"
    - name: "ofac_screened"
      expr: ofac_screened
      comment: "Indicator whether reinsurer has been OFAC screened"
  measures:
    - name: "total_credit_exposure_limit"
      expr: SUM(CAST(credit_exposure_limit AS DOUBLE))
      comment: "Total credit exposure limits across all reinsurers - aggregate counterparty risk measure"
    - name: "avg_rbc_counterparty_factor"
      expr: AVG(CAST(rbc_counterparty_factor AS DOUBLE))
      comment: "Average RBC counterparty risk factor - regulatory capital impact measure"
    - name: "reinsurer_count"
      expr: COUNT(DISTINCT reinsurer_id)
      comment: "Number of distinct reinsurers - portfolio diversification measure"
    - name: "active_reinsurer_count"
      expr: COUNT(DISTINCT CASE WHEN relationship_status = 'active' THEN reinsurer_id END)
      comment: "Number of active reinsurer relationships"
    - name: "watch_list_reinsurer_count"
      expr: COUNT(DISTINCT CASE WHEN watch_list_flag = TRUE THEN reinsurer_id END)
      comment: "Number of reinsurers on credit watch list - early warning indicator"
    - name: "collateral_required_count"
      expr: COUNT(DISTINCT CASE WHEN collateral_required = TRUE THEN reinsurer_id END)
      comment: "Number of reinsurers requiring collateral - credit risk mitigation measure"
    - name: "watch_list_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN watch_list_flag = TRUE THEN reinsurer_id END) / NULLIF(COUNT(DISTINCT reinsurer_id), 0), 2)
      comment: "Percentage of reinsurers on watch list - portfolio credit risk indicator"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`reinsurance_experience_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Experience refund metrics tracking profit sharing, mortality experience, and treaty profitability"
  source: "`life_insurance_ecm`.`reinsurance`.`experience_refund`"
  dimensions:
    - name: "refund_status"
      expr: refund_status
      comment: "Current status of experience refund (pending, approved, paid, disputed)"
    - name: "refund_type"
      expr: refund_type
      comment: "Type of experience refund (mortality, lapse, expense)"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of refund"
    - name: "profit_share_eligible"
      expr: profit_share_eligible
      comment: "Indicator whether refund qualifies for profit sharing"
    - name: "ibnr_included"
      expr: ibnr_included
      comment: "Indicator whether IBNR reserves are included in calculation"
    - name: "experience_rating_basis"
      expr: experience_rating_basis
      comment: "Basis for experience rating calculation"
    - name: "treaty_year"
      expr: treaty_year
      comment: "Treaty year for experience period"
    - name: "bordereaux_period"
      expr: bordereaux_period
      comment: "Reporting period for bordereaux"
    - name: "calculation_year"
      expr: YEAR(calculation_date)
      comment: "Year when experience refund was calculated"
  measures:
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total experience refund amount - primary measure of treaty profitability returned to ceding company"
    - name: "total_reinsurance_premium_earned"
      expr: SUM(CAST(reinsurance_premium_earned AS DOUBLE))
      comment: "Total reinsurance premiums earned during experience period"
    - name: "total_actual_claims_incurred"
      expr: SUM(CAST(actual_claims_incurred AS DOUBLE))
      comment: "Total actual claims incurred during experience period"
    - name: "total_expected_claims"
      expr: SUM(CAST(expected_claims_per_treaty AS DOUBLE))
      comment: "Total expected claims per treaty terms"
    - name: "total_expense_allowance"
      expr: SUM(CAST(expense_allowance AS DOUBLE))
      comment: "Total expense allowance in experience calculation"
    - name: "total_risk_charge"
      expr: SUM(CAST(risk_charge AS DOUBLE))
      comment: "Total risk charge deducted from experience refund"
    - name: "total_deficit_carryforward"
      expr: SUM(CAST(deficit_carryforward AS DOUBLE))
      comment: "Total deficit carried forward from prior periods"
    - name: "total_ceded_nar"
      expr: SUM(CAST(ceded_nar AS DOUBLE))
      comment: "Total ceded NAR in experience period"
    - name: "avg_mortality_ratio"
      expr: AVG(CAST(mortality_ratio AS DOUBLE))
      comment: "Average actual-to-expected mortality ratio - key profitability driver"
    - name: "avg_refund_percentage"
      expr: AVG(CAST(refund_percentage AS DOUBLE))
      comment: "Average refund as percentage of premium - measures treaty profit sharing generosity"
    - name: "avg_experience_margin"
      expr: AVG(CAST(experience_margin AS DOUBLE))
      comment: "Average experience margin - measures treaty profitability"
    - name: "refund_count"
      expr: COUNT(DISTINCT experience_refund_id)
      comment: "Number of distinct experience refunds"
    - name: "profit_share_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN profit_share_eligible = TRUE THEN experience_refund_id END)
      comment: "Number of refunds eligible for profit sharing"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`reinsurance_bordereaux`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bordereaux reporting metrics tracking reinsurance reporting completeness, settlement activity, and operational efficiency"
  source: "`life_insurance_ecm`.`reinsurance`.`bordereaux`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of bordereaux submission (draft, submitted, acknowledged, disputed)"
    - name: "bordereaux_type"
      expr: bordereaux_type
      comment: "Type of bordereaux report (new business, inforce, claims, settlement)"
    - name: "cession_type"
      expr: cession_type
      comment: "Type of cession reported"
    - name: "is_retrocession"
      expr: is_retrocession
      comment: "Indicator whether bordereaux covers retrocession"
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of bordereaux reporting (monthly, quarterly, annual)"
    - name: "submission_method"
      expr: submission_method
      comment: "Method of bordereaux submission (electronic, paper, portal)"
    - name: "submission_format"
      expr: submission_format
      comment: "Format of bordereaux submission (XML, CSV, PDF)"
    - name: "product_line"
      expr: product_line
      comment: "Product line covered by bordereaux"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year when bordereaux was submitted"
    - name: "reporting_period_year"
      expr: YEAR(reporting_period_end_date)
      comment: "Year of reporting period end"
  measures:
    - name: "total_ceded_face_amount"
      expr: SUM(CAST(total_ceded_face_amount AS DOUBLE))
      comment: "Total face amount ceded reported in bordereaux"
    - name: "total_reinsurance_premium"
      expr: SUM(CAST(total_reinsurance_premium AS DOUBLE))
      comment: "Total reinsurance premium reported in bordereaux"
    - name: "total_ceded_reserve"
      expr: SUM(CAST(total_ceded_reserve AS DOUBLE))
      comment: "Total ceded reserves reported in bordereaux"
    - name: "total_recoverables"
      expr: SUM(CAST(total_recoverables AS DOUBLE))
      comment: "Total claim recoverables reported in bordereaux"
    - name: "total_allowance_amount"
      expr: SUM(CAST(total_allowance_amount AS DOUBLE))
      comment: "Total expense allowance reported in bordereaux"
    - name: "total_net_settlement_amount"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Total net settlement amount - measures cash flow impact of bordereaux period"
    - name: "bordereaux_count"
      expr: COUNT(DISTINCT bordereaux_id)
      comment: "Number of distinct bordereaux submissions - operational volume measure"
    - name: "acknowledged_bordereaux_count"
      expr: COUNT(DISTINCT CASE WHEN reinsurer_acknowledgment_date IS NOT NULL THEN bordereaux_id END)
      comment: "Number of bordereaux acknowledged by reinsurers - measures reporting acceptance rate"
    - name: "disputed_bordereaux_count"
      expr: COUNT(DISTINCT CASE WHEN reinsurance_dispute_id IS NOT NULL THEN bordereaux_id END)
      comment: "Number of bordereaux under dispute - quality and relationship indicator"
    - name: "bordereaux_acknowledgment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN reinsurer_acknowledgment_date IS NOT NULL THEN bordereaux_id END) / NULLIF(COUNT(DISTINCT bordereaux_id), 0), 2)
      comment: "Percentage of bordereaux acknowledged by reinsurers - operational efficiency metric"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`reinsurance_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reinsurance dispute metrics tracking dispute volume, resolution effectiveness, and relationship quality indicators"
  source: "`life_insurance_ecm`.`reinsurance`.`reinsurance_dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of dispute (open, under review, escalated, resolved, closed)"
    - name: "dispute_type"
      expr: dispute_type
      comment: "Category of dispute (coverage, amount, documentation, interpretation)"
    - name: "resolution_method"
      expr: resolution_method
      comment: "Method used to resolve dispute (negotiation, arbitration, litigation, mediation)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of dispute (low, medium, high, critical)"
    - name: "arbitration_clause_invoked"
      expr: arbitration_clause_invoked
      comment: "Indicator whether arbitration clause was invoked"
    - name: "legal_counsel_assigned"
      expr: legal_counsel_assigned
      comment: "Indicator whether legal counsel is involved"
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Indicator whether regulatory notification is required"
    - name: "rbc_credit_impact"
      expr: rbc_credit_impact
      comment: "Indicator whether dispute impacts RBC credit"
    - name: "credit_for_reinsurance_at_risk"
      expr: credit_for_reinsurance_at_risk
      comment: "Indicator whether credit for reinsurance is at risk"
    - name: "bordereaux_period"
      expr: bordereaux_period
      comment: "Bordereaux period related to dispute"
    - name: "open_year"
      expr: YEAR(open_date)
      comment: "Year when dispute was opened"
    - name: "resolution_year"
      expr: YEAR(resolution_date)
      comment: "Year when dispute was resolved"
  measures:
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount under dispute - primary measure of relationship friction and financial exposure"
    - name: "total_settled_amount"
      expr: SUM(CAST(settled_amount AS DOUBLE))
      comment: "Total amount settled - measures dispute resolution outcomes"
    - name: "total_life_insurance_position"
      expr: SUM(CAST(life_insurance_position_amount AS DOUBLE))
      comment: "Total amount claimed by ceding company"
    - name: "total_reinsurer_position"
      expr: SUM(CAST(reinsurer_position_amount AS DOUBLE))
      comment: "Total amount acknowledged by reinsurer"
    - name: "total_ibnr_reserve_impact"
      expr: SUM(CAST(ibnr_reserve_impact_amount AS DOUBLE))
      comment: "Total IBNR reserve impact from disputes"
    - name: "dispute_count"
      expr: COUNT(DISTINCT reinsurance_dispute_id)
      comment: "Number of distinct disputes - volume measure of relationship quality"
    - name: "open_dispute_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_status IN ('open', 'under review', 'escalated') THEN reinsurance_dispute_id END)
      comment: "Number of currently open disputes - active risk measure"
    - name: "resolved_dispute_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_status = 'resolved' THEN reinsurance_dispute_id END)
      comment: "Number of resolved disputes"
    - name: "arbitration_dispute_count"
      expr: COUNT(DISTINCT CASE WHEN arbitration_clause_invoked = TRUE THEN reinsurance_dispute_id END)
      comment: "Number of disputes requiring arbitration - escalation indicator"
    - name: "legal_counsel_dispute_count"
      expr: COUNT(DISTINCT CASE WHEN legal_counsel_assigned = TRUE THEN reinsurance_dispute_id END)
      comment: "Number of disputes with legal counsel - severity indicator"
    - name: "dispute_resolution_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN dispute_status = 'resolved' THEN reinsurance_dispute_id END) / NULLIF(COUNT(DISTINCT reinsurance_dispute_id), 0), 2)
      comment: "Percentage of disputes resolved - effectiveness measure"
    - name: "avg_settlement_recovery_rate"
      expr: ROUND(100.0 * AVG(CAST(settled_amount AS DOUBLE) / NULLIF(CAST(disputed_amount AS DOUBLE), 0)), 2)
      comment: "Average percentage of disputed amount recovered - negotiation effectiveness metric"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`reinsurance_reserve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reinsurance reserve metrics tracking ceded reserves, funds withheld, RBC credit, and reserve movements"
  source: "`life_insurance_ecm`.`reinsurance`.`reserve`"
  dimensions:
    - name: "reserve_type"
      expr: reserve_type
      comment: "Type of reserve (policy, claim, IBNR, unearned premium)"
    - name: "basis"
      expr: basis
      comment: "Accounting basis for reserve (statutory, GAAP, IFRS17)"
    - name: "reserve_method"
      expr: reserve_method
      comment: "Actuarial method used for reserve calculation"
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status of reserve"
    - name: "is_authorized_reinsurer"
      expr: is_authorized_reinsurer
      comment: "Indicator whether reinsurer is authorized - impacts RBC credit eligibility"
    - name: "is_retrocession"
      expr: is_retrocession
      comment: "Indicator whether reserve is for retrocession"
    - name: "collateral_type"
      expr: collateral_type
      comment: "Type of collateral securing reserve"
    - name: "bordereaux_period"
      expr: bordereaux_period
      comment: "Bordereaux reporting period"
    - name: "reporting_period"
      expr: reporting_period
      comment: "Financial reporting period"
    - name: "valuation_year"
      expr: YEAR(valuation_date)
      comment: "Year of reserve valuation"
  measures:
    - name: "total_ceded_reserve_amount"
      expr: SUM(CAST(ceded_reserve_amount AS DOUBLE))
      comment: "Total ceded reserve amount - primary measure of reinsurance liability transfer"
    - name: "total_net_ceded_reserve"
      expr: SUM(CAST(net_ceded_reserve_amount AS DOUBLE))
      comment: "Total net ceded reserve after adjustments"
    - name: "total_funds_withheld_balance"
      expr: SUM(CAST(funds_withheld_balance AS DOUBLE))
      comment: "Total funds withheld balance - measures modified coinsurance arrangements"
    - name: "total_rbc_credit_amount"
      expr: SUM(CAST(rbc_credit_amount AS DOUBLE))
      comment: "Total RBC credit from reinsurance - key regulatory capital relief measure"
    - name: "total_collateral_amount"
      expr: SUM(CAST(collateral_amount AS DOUBLE))
      comment: "Total collateral held - credit risk mitigation measure"
    - name: "total_modco_reserve_adjustment"
      expr: SUM(CAST(modco_reserve_adjustment AS DOUBLE))
      comment: "Total modified coinsurance reserve adjustments"
    - name: "total_dac_ceded_amount"
      expr: SUM(CAST(dac_ceded_amount AS DOUBLE))
      comment: "Total deferred acquisition costs ceded"
    - name: "total_ifrs17_csg_amount"
      expr: SUM(CAST(ifrs17_csg_amount AS DOUBLE))
      comment: "Total IFRS17 contractual service margin ceded"
    - name: "total_ifrs17_ra_ceded"
      expr: SUM(CAST(ifrs17_ra_ceded_amount AS DOUBLE))
      comment: "Total IFRS17 risk adjustment ceded"
    - name: "total_reserve_movement"
      expr: SUM(CAST(movement_amount AS DOUBLE))
      comment: "Total reserve movement during period - measures reserve volatility"
    - name: "total_interest_credited"
      expr: SUM(CAST(interest_credited_amount AS DOUBLE))
      comment: "Total interest credited on funds withheld"
    - name: "avg_reinsurer_share_percentage"
      expr: AVG(CAST(reinsurer_share_percentage AS DOUBLE))
      comment: "Average reinsurer share percentage"
    - name: "avg_credited_interest_rate"
      expr: AVG(CAST(credited_interest_rate AS DOUBLE))
      comment: "Average interest rate credited on funds withheld"
    - name: "reserve_count"
      expr: COUNT(DISTINCT reserve_id)
      comment: "Number of distinct reserve records"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`reinsurance_facultative_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facultative reinsurance submission metrics tracking underwriting decisions, approval rates, and facultative capacity utilization"
  source: "`life_insurance_ecm`.`reinsurance`.`facultative_submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of facultative submission (pending, approved, declined, withdrawn)"
    - name: "underwriting_decision"
      expr: underwriting_decision
      comment: "Reinsurer underwriting decision (approved, declined, counter-offer, refer)"
    - name: "final_disposition"
      expr: final_disposition
      comment: "Final outcome of submission"
    - name: "cession_type"
      expr: cession_type
      comment: "Type of facultative cession requested"
    - name: "risk_classification"
      expr: risk_classification
      comment: "Underwriting risk classification"
    - name: "table_rating"
      expr: table_rating
      comment: "Table rating applied"
    - name: "aps_required"
      expr: aps_required
      comment: "Indicator whether attending physician statement is required"
    - name: "mib_checked"
      expr: mib_checked
      comment: "Indicator whether MIB check was performed"
    - name: "priority_flag"
      expr: priority_flag
      comment: "Indicator whether submission is high priority"
    - name: "retrocession_flag"
      expr: retrocession_flag
      comment: "Indicator whether submission involves retrocession"
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel used for submission (portal, email, fax)"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year when submission was made"
    - name: "decision_year"
      expr: YEAR(decision_date)
      comment: "Year when decision was made"
  measures:
    - name: "total_requested_cession_amount"
      expr: SUM(CAST(requested_cession_amount AS DOUBLE))
      comment: "Total facultative capacity requested - measures demand for facultative reinsurance"
    - name: "total_approved_cession_amount"
      expr: SUM(CAST(approved_cession_amount AS DOUBLE))
      comment: "Total facultative capacity approved - measures supply of facultative reinsurance"
    - name: "total_face_amount"
      expr: SUM(CAST(face_amount AS DOUBLE))
      comment: "Total face amount of policies submitted"
    - name: "total_nar_amount"
      expr: SUM(CAST(nar_amount AS DOUBLE))
      comment: "Total NAR submitted for facultative reinsurance"
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total amount retained by ceding company"
    - name: "total_reinsurance_premium"
      expr: SUM(CAST(reinsurance_premium_amount AS DOUBLE))
      comment: "Total facultative reinsurance premium"
    - name: "total_flat_extra_premium"
      expr: SUM(CAST(flat_extra_premium AS DOUBLE))
      comment: "Total flat extra premium charged"
    - name: "avg_requested_cession_percentage"
      expr: AVG(CAST(requested_cession_percentage AS DOUBLE))
      comment: "Average percentage of risk requested to be ceded"
    - name: "avg_reinsurance_premium_rate"
      expr: AVG(CAST(reinsurance_premium_rate AS DOUBLE))
      comment: "Average facultative reinsurance premium rate"
    - name: "submission_count"
      expr: COUNT(DISTINCT facultative_submission_id)
      comment: "Number of distinct facultative submissions - volume measure"
    - name: "approved_submission_count"
      expr: COUNT(DISTINCT CASE WHEN underwriting_decision = 'approved' THEN facultative_submission_id END)
      comment: "Number of approved submissions"
    - name: "declined_submission_count"
      expr: COUNT(DISTINCT CASE WHEN underwriting_decision = 'declined' THEN facultative_submission_id END)
      comment: "Number of declined submissions"
    - name: "approval_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN underwriting_decision = 'approved' THEN facultative_submission_id END) / NULLIF(COUNT(DISTINCT facultative_submission_id), 0), 2)
      comment: "Percentage of submissions approved - key measure of facultative market access and underwriting alignment"
    - name: "capacity_fulfillment_rate"
      expr: ROUND(100.0 * SUM(CAST(approved_cession_amount AS DOUBLE)) / NULLIF(SUM(CAST(requested_cession_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of requested capacity approved - measures facultative market capacity availability"
$$;