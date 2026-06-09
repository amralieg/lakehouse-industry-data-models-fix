-- Metric views for domain: gaming | Business: Sports Entertainment | Version: 1 | Generated on: 2026-05-09 01:35:39

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`gaming_wager`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core wagering KPIs: handle, GGR, hold percentage, parlay mix, and responsible gaming flags by jurisdiction, sport, and channel"
  source: "`sports_entertainment_ecm`.`gaming`.`wager`"
  dimensions:
    - name: "wager_date"
      expr: DATE(placement_timestamp)
      comment: "Date the wager was placed"
    - name: "wager_type"
      expr: wager_type
      comment: "Wager type: straight, parlay, teaser, etc."
    - name: "wager_status"
      expr: wager_status
      comment: "Wager status: pending, won, lost, void, cashed_out"
    - name: "is_live_bet"
      expr: is_live_bet
      comment: "Whether wager was placed in-play"
    - name: "is_parlay"
      expr: CASE WHEN wager_type = 'parlay' THEN TRUE ELSE FALSE END
      comment: "Whether wager is a parlay"
    - name: "responsible_gaming_flag"
      expr: responsible_gaming_flag
      comment: "Responsible gaming flag indicator"
    - name: "geolocation_state"
      expr: geolocation_state
      comment: "State/province where wager was placed"
  measures:
    - name: "total_wagers"
      expr: COUNT(1)
      comment: "Total number of wagers placed"
    - name: "total_handle"
      expr: SUM(CAST(stake_amount AS DOUBLE))
      comment: "Total wagered amount (handle) — primary revenue driver"
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total amount paid out to bettors"
    - name: "gross_gaming_revenue"
      expr: SUM((CAST(stake_amount AS DOUBLE)) - (CAST(settlement_amount AS DOUBLE)))
      comment: "Gross Gaming Revenue (GGR): handle minus payouts — key profitability metric"
    - name: "total_potential_payout"
      expr: SUM(CAST(potential_payout AS DOUBLE))
      comment: "Total potential liability if all wagers win"
    - name: "avg_stake_per_wager"
      expr: AVG(CAST(stake_amount AS DOUBLE))
      comment: "Average stake amount per wager"
    - name: "avg_odds_at_placement"
      expr: AVG(CAST(odds_at_placement AS DOUBLE))
      comment: "Average odds at time of wager placement"
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus funds used in wagers"
    - name: "total_cashout_amount"
      expr: SUM(CAST(cashout_amount AS DOUBLE))
      comment: "Total amount cashed out early"
    - name: "distinct_bettors"
      expr: COUNT(DISTINCT bettor_account_id)
      comment: "Number of unique bettor accounts placing wagers"
    - name: "parlay_wagers"
      expr: SUM(CASE WHEN wager_type = 'parlay' THEN 1 ELSE 0 END)
      comment: "Count of parlay wagers"
    - name: "live_wagers"
      expr: SUM(CASE WHEN is_live_bet = TRUE THEN 1 ELSE 0 END)
      comment: "Count of in-play live wagers"
    - name: "free_bet_wagers"
      expr: SUM(CASE WHEN is_free_bet = TRUE THEN 1 ELSE 0 END)
      comment: "Count of free bet wagers"
    - name: "rg_flagged_wagers"
      expr: SUM(CASE WHEN responsible_gaming_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of wagers flagged for responsible gaming review"
    - name: "integrity_flagged_wagers"
      expr: SUM(CASE WHEN integrity_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of wagers flagged for integrity review"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`gaming_bettor_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bettor account lifecycle KPIs: acquisition, KYC completion, account status, responsible gaming limits, and lifetime value indicators"
  source: "`sports_entertainment_ecm`.`gaming`.`bettor_account`"
  dimensions:
    - name: "registration_date"
      expr: open_date
      comment: "Date bettor account was opened"
    - name: "account_status"
      expr: account_status
      comment: "Current account status: active, suspended, closed, etc."
    - name: "account_tier"
      expr: account_tier
      comment: "Account tier or VIP level"
    - name: "kyc_status"
      expr: kyc_status
      comment: "KYC verification status"
    - name: "registration_jurisdiction"
      expr: registration_jurisdiction
      comment: "Jurisdiction where account was registered"
    - name: "registration_state_code"
      expr: registration_state_code
      comment: "State/province of registration"
    - name: "source_channel"
      expr: source_channel
      comment: "Acquisition channel: organic, affiliate, paid, etc."
    - name: "affiliate_code"
      expr: affiliate_code
      comment: "Affiliate code used at registration"
    - name: "age_verified"
      expr: age_verified
      comment: "Whether age verification is complete"
    - name: "responsible_gaming_flag"
      expr: responsible_gaming_flag
      comment: "Responsible gaming flag indicator"
    - name: "self_exclusion_status"
      expr: self_exclusion_status
      comment: "Self-exclusion status"
  measures:
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total number of bettor accounts"
    - name: "active_accounts"
      expr: SUM(CASE WHEN account_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active bettor accounts"
    - name: "kyc_verified_accounts"
      expr: SUM(CASE WHEN kyc_status = 'verified' THEN 1 ELSE 0 END)
      comment: "Count of KYC-verified accounts — regulatory compliance metric"
    - name: "age_verified_accounts"
      expr: SUM(CASE WHEN age_verified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of age-verified accounts"
    - name: "total_balance"
      expr: SUM(CAST(balance AS DOUBLE))
      comment: "Total account balance across all bettors"
    - name: "total_bonus_balance"
      expr: SUM(CAST(bonus_balance AS DOUBLE))
      comment: "Total bonus balance held by bettors"
    - name: "avg_balance_per_account"
      expr: AVG(CAST(balance AS DOUBLE))
      comment: "Average account balance per bettor"
    - name: "accounts_with_deposit_limits"
      expr: SUM(CASE WHEN deposit_limit_daily IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of accounts with daily deposit limits set"
    - name: "accounts_with_wager_limits"
      expr: SUM(CASE WHEN wager_limit_daily IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of accounts with daily wager limits set"
    - name: "rg_flagged_accounts"
      expr: SUM(CASE WHEN responsible_gaming_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts flagged for responsible gaming intervention"
    - name: "self_excluded_accounts"
      expr: SUM(CASE WHEN self_exclusion_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of self-excluded accounts — key responsible gaming metric"
    - name: "marketing_opt_in_accounts"
      expr: SUM(CASE WHEN marketing_opt_in = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts opted in to marketing"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`gaming_deposit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deposit transaction KPIs: volume, success rate, payment method mix, fraud detection, and AML compliance"
  source: "`sports_entertainment_ecm`.`gaming`.`deposit`"
  dimensions:
    - name: "deposit_date"
      expr: DATE(deposit_timestamp)
      comment: "Date of deposit transaction"
    - name: "deposit_status"
      expr: deposit_status
      comment: "Deposit status: completed, pending, failed, reversed"
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Payment method: credit card, ACH, e-wallet, etc."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Payment channel: web, mobile, retail"
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction where deposit was made"
    - name: "aml_check_status"
      expr: aml_check_status
      comment: "AML screening status"
    - name: "fraud_review_required"
      expr: fraud_review_required
      comment: "Whether fraud review was triggered"
    - name: "bonus_eligible"
      expr: bonus_eligible
      comment: "Whether deposit is eligible for bonus"
  measures:
    - name: "total_deposits"
      expr: COUNT(1)
      comment: "Total number of deposit transactions"
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amount — primary funding metric"
    - name: "total_net_deposit_amount"
      expr: SUM(CAST(net_deposit_amount AS DOUBLE))
      comment: "Total net deposit amount after fees"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fees charged on deposits"
    - name: "avg_deposit_amount"
      expr: AVG(CAST(deposit_amount AS DOUBLE))
      comment: "Average deposit amount per transaction"
    - name: "completed_deposits"
      expr: SUM(CASE WHEN deposit_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of successfully completed deposits"
    - name: "failed_deposits"
      expr: SUM(CASE WHEN deposit_status = 'failed' THEN 1 ELSE 0 END)
      comment: "Count of failed deposit attempts"
    - name: "reversed_deposits"
      expr: SUM(CASE WHEN deposit_status = 'reversed' THEN 1 ELSE 0 END)
      comment: "Count of reversed deposits"
    - name: "fraud_flagged_deposits"
      expr: SUM(CASE WHEN fraud_review_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of deposits flagged for fraud review — risk management metric"
    - name: "aml_flagged_deposits"
      expr: SUM(CASE WHEN aml_check_status = 'flagged' THEN 1 ELSE 0 END)
      comment: "Count of deposits flagged by AML screening — compliance metric"
    - name: "bonus_eligible_deposits"
      expr: SUM(CASE WHEN bonus_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of deposits eligible for bonus offers"
    - name: "distinct_depositors"
      expr: COUNT(DISTINCT bettor_account_id)
      comment: "Number of unique bettor accounts making deposits"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`gaming_payout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payout transaction KPIs: volume, tax withholding, W-2G reporting, approval rates, and regulatory compliance"
  source: "`sports_entertainment_ecm`.`gaming`.`payout`"
  dimensions:
    - name: "payout_date"
      expr: DATE(payout_timestamp)
      comment: "Date of payout transaction"
    - name: "payout_status"
      expr: payout_status
      comment: "Payout status: completed, pending, failed, reversed"
    - name: "payout_type"
      expr: payout_type
      comment: "Payout type: wager_win, contest_prize, bonus_conversion, etc."
    - name: "payout_method"
      expr: payout_method
      comment: "Payout method: ACH, check, e-wallet, etc."
    - name: "jurisdiction_code"
      expr: COALESCE(operator_code, 'Unknown')
      comment: "Operator code for jurisdiction mapping"
    - name: "w2g_reportable"
      expr: w2g_reportable
      comment: "Whether payout is W-2G reportable (IRS threshold)"
    - name: "ctr_reportable"
      expr: ctr_reportable
      comment: "Whether payout triggers CTR reporting (AML)"
    - name: "approval_required"
      expr: approval_required
      comment: "Whether payout required manual approval"
    - name: "responsible_gaming_flag"
      expr: responsible_gaming_flag
      comment: "Responsible gaming flag indicator"
  measures:
    - name: "total_payouts"
      expr: COUNT(1)
      comment: "Total number of payout transactions"
    - name: "total_gross_payout_amount"
      expr: SUM(CAST(gross_payout_amount AS DOUBLE))
      comment: "Total gross payout amount before tax withholding"
    - name: "total_net_payout_amount"
      expr: SUM(CAST(net_payout_amount AS DOUBLE))
      comment: "Total net payout amount after tax withholding — cash outflow metric"
    - name: "total_tax_withheld"
      expr: SUM(CAST(tax_withheld_amount AS DOUBLE))
      comment: "Total tax withheld on payouts — regulatory compliance metric"
    - name: "total_stake_amount"
      expr: SUM(CAST(stake_amount AS DOUBLE))
      comment: "Total original stake amount for winning wagers"
    - name: "avg_gross_payout"
      expr: AVG(CAST(gross_payout_amount AS DOUBLE))
      comment: "Average gross payout amount per transaction"
    - name: "completed_payouts"
      expr: SUM(CASE WHEN payout_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of successfully completed payouts"
    - name: "failed_payouts"
      expr: SUM(CASE WHEN payout_status = 'failed' THEN 1 ELSE 0 END)
      comment: "Count of failed payout attempts"
    - name: "w2g_reportable_payouts"
      expr: SUM(CASE WHEN w2g_reportable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of W-2G reportable payouts — IRS compliance metric"
    - name: "ctr_reportable_payouts"
      expr: SUM(CASE WHEN ctr_reportable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of CTR-reportable payouts — AML compliance metric"
    - name: "approval_required_payouts"
      expr: SUM(CASE WHEN approval_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of payouts requiring manual approval"
    - name: "distinct_payout_recipients"
      expr: COUNT(DISTINCT bettor_account_id)
      comment: "Number of unique bettor accounts receiving payouts"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`gaming_contest_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Daily fantasy sports contest entry KPIs: volume, entry fees, prize distribution, lineup performance, and tax reporting"
  source: "`sports_entertainment_ecm`.`gaming`.`contest_entry`"
  dimensions:
    - name: "entry_date"
      expr: DATE(entry_timestamp)
      comment: "Date contest entry was submitted"
    - name: "entry_status"
      expr: entry_status
      comment: "Entry status: active, settled, void, etc."
    - name: "entry_type"
      expr: entry_type
      comment: "Entry type: single, multi, rebuy, etc."
    - name: "sport_type"
      expr: sport_type
      comment: "Sport type for contest"
    - name: "contest_slate_date"
      expr: contest_slate_date
      comment: "Date of contest slate"
    - name: "payout_status"
      expr: payout_status
      comment: "Payout status: pending, paid, forfeited"
    - name: "w2g_reportable"
      expr: w2g_reportable
      comment: "Whether prize is W-2G reportable"
    - name: "geolocation_state"
      expr: geolocation_state
      comment: "State where entry was submitted"
    - name: "is_autopick"
      expr: is_autopick
      comment: "Whether lineup was auto-generated"
  measures:
    - name: "total_entries"
      expr: COUNT(1)
      comment: "Total number of contest entries"
    - name: "total_entry_fees"
      expr: SUM(CAST(entry_fee_amount AS DOUBLE))
      comment: "Total entry fees collected — primary DFS revenue metric"
    - name: "total_net_entry_fees"
      expr: SUM(CAST(net_entry_fee_amount AS DOUBLE))
      comment: "Total net entry fees after bonus deductions"
    - name: "total_prize_amount"
      expr: SUM(CAST(prize_amount AS DOUBLE))
      comment: "Total prize money awarded"
    - name: "total_bonus_applied"
      expr: SUM(CAST(bonus_amount_applied AS DOUBLE))
      comment: "Total bonus funds used for entry fees"
    - name: "total_tax_withheld"
      expr: SUM(CAST(tax_withheld_amount AS DOUBLE))
      comment: "Total tax withheld on prizes"
    - name: "avg_entry_fee"
      expr: AVG(CAST(entry_fee_amount AS DOUBLE))
      comment: "Average entry fee per contest entry"
    - name: "avg_actual_points"
      expr: AVG(CAST(actual_points AS DOUBLE))
      comment: "Average actual fantasy points scored"
    - name: "avg_projected_points"
      expr: AVG(CAST(projected_points AS DOUBLE))
      comment: "Average projected fantasy points"
    - name: "distinct_contestants"
      expr: COUNT(DISTINCT bettor_account_id)
      comment: "Number of unique bettor accounts entering contests"
    - name: "winning_entries"
      expr: SUM(CASE WHEN prize_amount > 0 THEN 1 ELSE 0 END)
      comment: "Count of entries that won a prize"
    - name: "w2g_reportable_entries"
      expr: SUM(CASE WHEN w2g_reportable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of entries with W-2G reportable prizes"
    - name: "autopick_entries"
      expr: SUM(CASE WHEN is_autopick = TRUE THEN 1 ELSE 0 END)
      comment: "Count of auto-generated lineup entries"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`gaming_bonus_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bonus redemption KPIs: volume, conversion rates, wagering requirement progress, forfeiture, and promotional ROI"
  source: "`sports_entertainment_ecm`.`gaming`.`bonus_redemption`"
  dimensions:
    - name: "redemption_date"
      expr: DATE(redemption_timestamp)
      comment: "Date bonus was redeemed"
    - name: "bonus_status"
      expr: bonus_status
      comment: "Bonus status: active, completed, forfeited, expired"
    - name: "bonus_type_code"
      expr: bonus_type_code
      comment: "Bonus type code"
    - name: "final_outcome"
      expr: final_outcome
      comment: "Final outcome: converted, forfeited, expired"
    - name: "kyc_status"
      expr: kyc_status
      comment: "KYC status at redemption"
    - name: "age_verification_status"
      expr: age_verification_status
      comment: "Age verification status"
    - name: "responsible_gaming_flag"
      expr: responsible_gaming_flag
      comment: "Responsible gaming flag indicator"
  measures:
    - name: "total_redemptions"
      expr: COUNT(1)
      comment: "Total number of bonus redemptions"
    - name: "total_bonus_credited"
      expr: SUM(CAST(bonus_amount_credited AS DOUBLE))
      comment: "Total bonus amount credited to bettors — promotional cost metric"
    - name: "total_converted_amount"
      expr: SUM(CAST(converted_amount AS DOUBLE))
      comment: "Total bonus amount converted to real money"
    - name: "total_forfeited_amount"
      expr: SUM(CAST(forfeited_amount AS DOUBLE))
      comment: "Total bonus amount forfeited"
    - name: "total_wagering_requirement"
      expr: SUM(CAST(wagering_requirement_amount AS DOUBLE))
      comment: "Total wagering requirement amount"
    - name: "total_wagering_remaining"
      expr: SUM(CAST(wagering_requirement_remaining AS DOUBLE))
      comment: "Total wagering requirement remaining"
    - name: "avg_bonus_credited"
      expr: AVG(CAST(bonus_amount_credited AS DOUBLE))
      comment: "Average bonus amount per redemption"
    - name: "avg_wagering_multiplier"
      expr: AVG(CAST(wagering_requirement_multiplier AS DOUBLE))
      comment: "Average wagering requirement multiplier"
    - name: "completed_redemptions"
      expr: SUM(CASE WHEN bonus_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of completed bonus redemptions"
    - name: "forfeited_redemptions"
      expr: SUM(CASE WHEN final_outcome = 'forfeited' THEN 1 ELSE 0 END)
      comment: "Count of forfeited bonuses"
    - name: "converted_redemptions"
      expr: SUM(CASE WHEN final_outcome = 'converted' THEN 1 ELSE 0 END)
      comment: "Count of bonuses converted to real money — promotional effectiveness metric"
    - name: "distinct_redeemers"
      expr: COUNT(DISTINCT bettor_account_id)
      comment: "Number of unique bettor accounts redeeming bonuses"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`gaming_regulatory_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory reporting KPIs: filing volume, GGR, tax remittance, compliance metrics, and responsible gaming interventions"
  source: "`sports_entertainment_ecm`.`gaming`.`regulatory_report`"
  dimensions:
    - name: "reporting_period_start"
      expr: reporting_period_start_date
      comment: "Start date of reporting period"
    - name: "reporting_period_end"
      expr: reporting_period_end_date
      comment: "End date of reporting period"
    - name: "report_type"
      expr: report_type
      comment: "Report type: GGR, tax, AML, responsible gaming, etc."
    - name: "report_status"
      expr: report_status
      comment: "Report status: draft, submitted, accepted, rejected"
    - name: "report_frequency"
      expr: report_frequency
      comment: "Reporting frequency: daily, weekly, monthly, quarterly"
    - name: "regulatory_body_name"
      expr: regulatory_body_name
      comment: "Name of regulatory body"
    - name: "sport_category"
      expr: sport_category
      comment: "Sport category for report"
    - name: "is_late_filing"
      expr: is_late_filing
      comment: "Whether report was filed late"
    - name: "is_amended"
      expr: is_amended
      comment: "Whether report is an amendment"
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total number of regulatory reports"
    - name: "total_ggr_reported"
      expr: SUM(CAST(ggr_amount AS DOUBLE))
      comment: "Total Gross Gaming Revenue reported — key regulatory metric"
    - name: "total_tax_reported"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount reported"
    - name: "total_wagers_reported"
      expr: SUM(CAST(total_wagers_amount AS DOUBLE))
      comment: "Total wagers amount reported"
    - name: "total_winnings_paid_reported"
      expr: SUM(CAST(total_winnings_paid_amount AS DOUBLE))
      comment: "Total winnings paid amount reported"
    - name: "avg_ggr_per_report"
      expr: AVG(CAST(ggr_amount AS DOUBLE))
      comment: "Average GGR per regulatory report"
    - name: "submitted_reports"
      expr: SUM(CASE WHEN report_status = 'submitted' THEN 1 ELSE 0 END)
      comment: "Count of submitted reports"
    - name: "accepted_reports"
      expr: SUM(CASE WHEN report_status = 'accepted' THEN 1 ELSE 0 END)
      comment: "Count of accepted reports"
    - name: "rejected_reports"
      expr: SUM(CASE WHEN report_status = 'rejected' THEN 1 ELSE 0 END)
      comment: "Count of rejected reports — compliance risk metric"
    - name: "late_filings"
      expr: SUM(CASE WHEN is_late_filing = TRUE THEN 1 ELSE 0 END)
      comment: "Count of late filings — compliance risk metric"
    - name: "amended_reports"
      expr: SUM(CASE WHEN is_amended = TRUE THEN 1 ELSE 0 END)
      comment: "Count of amended reports"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`gaming_self_exclusion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Self-exclusion program KPIs: volume, duration, reinstatement rates, and responsible gaming compliance"
  source: "`sports_entertainment_ecm`.`gaming`.`self_exclusion`"
  dimensions:
    - name: "exclusion_start_date"
      expr: exclusion_start_date
      comment: "Date self-exclusion began"
    - name: "exclusion_status"
      expr: exclusion_status
      comment: "Exclusion status: active, expired, reinstated"
    - name: "exclusion_type"
      expr: exclusion_type
      comment: "Exclusion type: self, operator, regulatory"
    - name: "exclusion_scope"
      expr: exclusion_scope
      comment: "Exclusion scope: single operator, state-wide, national"
    - name: "initiated_by"
      expr: initiated_by
      comment: "Who initiated exclusion: player, operator, regulator"
    - name: "is_permanent"
      expr: is_permanent
      comment: "Whether exclusion is permanent"
    - name: "election_channel"
      expr: election_channel
      comment: "Channel used to elect exclusion: web, mobile, phone, in-person"
    - name: "responsible_gaming_counseling_required"
      expr: responsible_gaming_counseling_required
      comment: "Whether counseling is required for reinstatement"
  measures:
    - name: "total_exclusions"
      expr: COUNT(1)
      comment: "Total number of self-exclusion records"
    - name: "active_exclusions"
      expr: SUM(CASE WHEN exclusion_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active self-exclusions — key responsible gaming metric"
    - name: "permanent_exclusions"
      expr: SUM(CASE WHEN is_permanent = TRUE THEN 1 ELSE 0 END)
      comment: "Count of permanent self-exclusions"
    - name: "reinstated_exclusions"
      expr: SUM(CASE WHEN exclusion_status = 'reinstated' THEN 1 ELSE 0 END)
      comment: "Count of reinstated accounts"
    - name: "expired_exclusions"
      expr: SUM(CASE WHEN exclusion_status = 'expired' THEN 1 ELSE 0 END)
      comment: "Count of expired exclusions"
    - name: "total_pending_balance"
      expr: SUM(CAST(pending_balance_amount AS DOUBLE))
      comment: "Total pending balance for excluded accounts"
    - name: "avg_pending_balance"
      expr: AVG(CAST(pending_balance_amount AS DOUBLE))
      comment: "Average pending balance per excluded account"
    - name: "counseling_required_exclusions"
      expr: SUM(CASE WHEN responsible_gaming_counseling_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of exclusions requiring counseling for reinstatement"
    - name: "distinct_excluded_accounts"
      expr: COUNT(DISTINCT bettor_account_id)
      comment: "Number of unique bettor accounts with self-exclusion records"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`gaming_integrity_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Integrity monitoring KPIs: alert volume, severity distribution, resolution rates, and governing body referrals"
  source: "`sports_entertainment_ecm`.`gaming`.`integrity_alert`"
  dimensions:
    - name: "detection_date"
      expr: DATE(detection_timestamp)
      comment: "Date integrity alert was detected"
    - name: "alert_type"
      expr: alert_type
      comment: "Alert type: unusual betting pattern, insider trading, match fixing, etc."
    - name: "alert_category"
      expr: alert_category
      comment: "Alert category"
    - name: "alert_status"
      expr: alert_status
      comment: "Alert status: open, investigating, resolved, escalated"
    - name: "severity"
      expr: severity
      comment: "Alert severity: low, medium, high, critical"
    - name: "sport_code"
      expr: sport_code
      comment: "Sport code for alert"
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction where alert was triggered"
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Resolution outcome: false positive, confirmed, inconclusive"
    - name: "governing_body_referral_flag"
      expr: governing_body_referral_flag
      comment: "Whether alert was referred to governing body"
    - name: "market_suspension_flag"
      expr: market_suspension_flag
      comment: "Whether market was suspended due to alert"
  measures:
    - name: "total_alerts"
      expr: COUNT(1)
      comment: "Total number of integrity alerts"
    - name: "open_alerts"
      expr: SUM(CASE WHEN alert_status = 'open' THEN 1 ELSE 0 END)
      comment: "Count of open integrity alerts"
    - name: "resolved_alerts"
      expr: SUM(CASE WHEN alert_status = 'resolved' THEN 1 ELSE 0 END)
      comment: "Count of resolved integrity alerts"
    - name: "escalated_alerts"
      expr: SUM(CASE WHEN alert_status = 'escalated' THEN 1 ELSE 0 END)
      comment: "Count of escalated integrity alerts"
    - name: "critical_severity_alerts"
      expr: SUM(CASE WHEN severity = 'critical' THEN 1 ELSE 0 END)
      comment: "Count of critical severity alerts — highest risk metric"
    - name: "high_severity_alerts"
      expr: SUM(CASE WHEN severity = 'high' THEN 1 ELSE 0 END)
      comment: "Count of high severity alerts"
    - name: "governing_body_referrals"
      expr: SUM(CASE WHEN governing_body_referral_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of alerts referred to governing body — regulatory escalation metric"
    - name: "market_suspensions_triggered"
      expr: SUM(CASE WHEN market_suspension_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of alerts that triggered market suspension"
    - name: "confirmed_integrity_violations"
      expr: SUM(CASE WHEN resolution_outcome = 'confirmed' THEN 1 ELSE 0 END)
      comment: "Count of confirmed integrity violations — key risk metric"
    - name: "false_positive_alerts"
      expr: SUM(CASE WHEN resolution_outcome = 'false positive' THEN 1 ELSE 0 END)
      comment: "Count of false positive alerts"
    - name: "avg_priority_score"
      expr: AVG(CAST(priority_score AS DOUBLE))
      comment: "Average priority score across alerts"
    - name: "total_triggering_volume"
      expr: SUM(CAST(triggering_volume_amount AS DOUBLE))
      comment: "Total wagering volume that triggered alerts"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`gaming_kyc_verification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KYC verification KPIs: volume, approval rates, rejection reasons, AML screening, and compliance turnaround time"
  source: "`sports_entertainment_ecm`.`gaming`.`kyc_verification`"
  dimensions:
    - name: "submission_date"
      expr: DATE(submission_timestamp)
      comment: "Date KYC verification was submitted"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status: pending, approved, rejected, escalated"
    - name: "verification_type"
      expr: verification_type
      comment: "Verification type: initial, reverification, enhanced"
    - name: "verification_method"
      expr: verification_method
      comment: "Verification method: automated, manual, hybrid"
    - name: "document_type"
      expr: document_type
      comment: "Document type: passport, driver license, national ID, etc."
    - name: "aml_screening_status"
      expr: aml_screening_status
      comment: "AML screening status"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating: low, medium, high"
    - name: "pep_flag"
      expr: pep_flag
      comment: "Politically Exposed Person flag"
    - name: "sanctions_hit_flag"
      expr: sanctions_hit_flag
      comment: "Sanctions list hit flag"
  measures:
    - name: "total_verifications"
      expr: COUNT(1)
      comment: "Total number of KYC verification attempts"
    - name: "approved_verifications"
      expr: SUM(CASE WHEN verification_status = 'approved' THEN 1 ELSE 0 END)
      comment: "Count of approved KYC verifications"
    - name: "rejected_verifications"
      expr: SUM(CASE WHEN verification_status = 'rejected' THEN 1 ELSE 0 END)
      comment: "Count of rejected KYC verifications"
    - name: "pending_verifications"
      expr: SUM(CASE WHEN verification_status = 'pending' THEN 1 ELSE 0 END)
      comment: "Count of pending KYC verifications"
    - name: "escalated_verifications"
      expr: SUM(CASE WHEN verification_status = 'escalated' THEN 1 ELSE 0 END)
      comment: "Count of escalated KYC verifications"
    - name: "initial_verifications"
      expr: SUM(CASE WHEN verification_type = 'initial' THEN 1 ELSE 0 END)
      comment: "Count of initial KYC verifications"
    - name: "reverifications"
      expr: SUM(CASE WHEN verification_type = 'reverification' THEN 1 ELSE 0 END)
      comment: "Count of reverifications"
    - name: "pep_flagged_verifications"
      expr: SUM(CASE WHEN pep_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of PEP-flagged verifications — enhanced due diligence metric"
    - name: "sanctions_hit_verifications"
      expr: SUM(CASE WHEN sanctions_hit_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of sanctions-hit verifications — AML compliance metric"
    - name: "high_risk_verifications"
      expr: SUM(CASE WHEN risk_rating = 'high' THEN 1 ELSE 0 END)
      comment: "Count of high-risk verifications"
    - name: "avg_document_authenticity_score"
      expr: AVG(CAST(document_authenticity_score AS DOUBLE))
      comment: "Average document authenticity score"
    - name: "avg_biometric_match_score"
      expr: AVG(CAST(biometric_match_score AS DOUBLE))
      comment: "Average biometric match score"
    - name: "distinct_accounts_verified"
      expr: COUNT(DISTINCT bettor_account_id)
      comment: "Number of unique bettor accounts verified"
$$;