-- Metric views for domain: talent | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-22 23:42:33

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Executive KPIs for talent contract portfolio management: tracks active deal value, compensation commitments, option exercise rates, and residual eligibility exposure across the talent roster."
  source: "`vibe_media_broadcasting_v1`.`talent`.`contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of talent contract (series regular, recurring guest, pilot, feature, etc.) for portfolio segmentation."
    - name: "contract_status"
      expr: contract_status
      comment: "Current lifecycle status of the contract (active, expired, terminated, pending) for pipeline analysis."
    - name: "guild_affiliation"
      expr: guild_affiliation
      comment: "Guild or union affiliation (SAG-AFTRA, WGA, DGA, etc.) driving residual and pension obligations."
    - name: "compensation_currency"
      expr: compensation_currency
      comment: "Currency of the contract compensation for multi-currency portfolio reporting."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the contract carries an exclusivity clause, indicating competitive risk exposure."
    - name: "residual_eligibility_flag"
      expr: residual_eligibility_flag
      comment: "Whether talent on this contract is eligible for residual payments, driving future liability estimates."
    - name: "pay_or_play_flag"
      expr: pay_or_play_flag
      comment: "Whether the contract is pay-or-play, indicating guaranteed compensation regardless of production outcome."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the contract became effective, for cohort and vintage analysis."
    - name: "effective_end_date"
      expr: DATE_TRUNC('quarter', effective_end_date)
      comment: "Quarter the contract expires, for renewal pipeline forecasting."
  measures:
    - name: "total_active_contracts"
      expr: COUNT(1)
      comment: "Total number of talent contracts in the portfolio. Baseline headcount of contractual commitments."
    - name: "total_base_compensation"
      expr: SUM(CAST(base_compensation_amount AS DOUBLE))
      comment: "Total committed base compensation across all contracts. Core talent cost exposure for budget planning."
    - name: "avg_base_compensation"
      expr: AVG(CAST(base_compensation_amount AS DOUBLE))
      comment: "Average base compensation per contract. Benchmarks deal size against industry norms and tier expectations."
    - name: "total_step_up_commitment"
      expr: SUM(CAST(step_up_amount AS DOUBLE))
      comment: "Total contractual step-up amounts across the portfolio. Quantifies future compensation escalation obligations."
    - name: "total_backend_participation_pct_avg"
      expr: AVG(CAST(backend_participation_percentage AS DOUBLE))
      comment: "Average backend participation percentage across contracts. Indicates profit-sharing exposure on content exploitation."
    - name: "pay_or_play_contract_count"
      expr: COUNT(CASE WHEN pay_or_play_flag = TRUE THEN 1 END)
      comment: "Number of pay-or-play contracts. Represents guaranteed spend regardless of production go/no-go decisions."
    - name: "residual_eligible_contract_count"
      expr: COUNT(CASE WHEN residual_eligibility_flag = TRUE THEN 1 END)
      comment: "Number of contracts with residual eligibility. Drives future residual payment liability forecasting."
    - name: "exclusive_contract_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END)
      comment: "Number of exclusive talent contracts. Measures competitive lock-in and talent availability constraints."
    - name: "amended_contract_count"
      expr: COUNT(CASE WHEN last_amendment_date IS NOT NULL THEN 1 END)
      comment: "Number of contracts that have been amended. High amendment rates signal deal instability or renegotiation pressure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_residual_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial KPIs for talent residual payment operations: tracks gross and net residual disbursements, pension/health contributions, withholding tax, and payment cycle efficiency for guild compliance."
  source: "`vibe_media_broadcasting_v1`.`talent`.`residual_payment`"
  dimensions:
    - name: "guild_affiliation"
      expr: guild_affiliation
      comment: "Guild or union (SAG-AFTRA, WGA, DGA) associated with the residual payment for compliance reporting."
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the residual payment (pending, paid, failed, disputed) for cash flow management."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (ACH, wire, check) for treasury and reconciliation analysis."
    - name: "distribution_window"
      expr: distribution_window
      comment: "Distribution window (theatrical, home video, streaming, broadcast) that triggered the residual."
    - name: "payment_currency_code"
      expr: payment_currency_code
      comment: "Currency of the residual payment for multi-currency treasury reporting."
    - name: "payment_date_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of payment for trend analysis and guild remittance cycle tracking."
    - name: "audit_report_flag"
      expr: audit_report_flag
      comment: "Whether an audit report was generated for this payment, indicating compliance scrutiny."
    - name: "remittance_advice_sent_flag"
      expr: remittance_advice_sent_flag
      comment: "Whether remittance advice was sent to the talent/guild, for operational completeness tracking."
  measures:
    - name: "total_gross_residual_amount"
      expr: SUM(CAST(gross_residual_amount AS DOUBLE))
      comment: "Total gross residual payments disbursed. Primary financial metric for guild compliance and talent cost reporting."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net residual payments after deductions. Actual cash outflow for treasury and accounts payable."
    - name: "total_pension_health_amount"
      expr: SUM(CAST(pension_health_amount AS DOUBLE))
      comment: "Total pension and health fund contributions embedded in residual payments. Guild compliance obligation tracking."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from residual payments. Tax liability reporting for finance and compliance."
    - name: "total_agent_commission_amount"
      expr: SUM(CAST(agent_commission_amount AS DOUBLE))
      comment: "Total agent commissions deducted from residual payments. Measures agency cost burden on talent disbursements."
    - name: "total_other_deductions_amount"
      expr: SUM(CAST(other_deductions_amount AS DOUBLE))
      comment: "Total miscellaneous deductions from residual payments. Identifies non-standard cost items for audit review."
    - name: "residual_payment_count"
      expr: COUNT(1)
      comment: "Total number of residual payment transactions. Volume metric for operational throughput and guild reporting."
    - name: "avg_net_payment_amount"
      expr: AVG(CAST(net_payment_amount AS DOUBLE))
      comment: "Average net residual payment per transaction. Benchmarks payment size by distribution window and guild."
    - name: "pending_payment_count"
      expr: COUNT(CASE WHEN payment_status = 'pending' THEN 1 END)
      comment: "Number of residual payments still pending. Operational backlog metric for accounts payable prioritization."
    - name: "remittance_advice_pending_count"
      expr: COUNT(CASE WHEN remittance_advice_sent_flag = FALSE THEN 1 END)
      comment: "Number of paid residuals where remittance advice has not yet been sent. Guild compliance gap indicator."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_compensation_structure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for talent compensation design: tracks compensation commitments, deferred pay obligations, backend participation exposure, and guild pension rates across the talent portfolio."
  source: "`vibe_media_broadcasting_v1`.`talent`.`compensation_structure`"
  dimensions:
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation structure (episodic, weekly, flat deal, daily) for cost modeling."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the compensation structure for multi-currency financial planning."
    - name: "guild_affiliation"
      expr: guild_affiliation
      comment: "Guild affiliation driving minimum scale rates and pension/health obligations."
    - name: "residual_eligibility_flag"
      expr: residual_eligibility_flag
      comment: "Whether this compensation structure carries residual eligibility, impacting future liability."
    - name: "pay_or_play_flag"
      expr: pay_or_play_flag
      comment: "Whether the structure is pay-or-play, representing guaranteed spend commitments."
    - name: "exclusivity_clause_flag"
      expr: exclusivity_clause_flag
      comment: "Whether an exclusivity clause is attached, indicating competitive restriction costs."
    - name: "effective_start_date_quarter"
      expr: DATE_TRUNC('quarter', effective_start_date)
      comment: "Quarter the compensation structure became effective, for budget vintage analysis."
  measures:
    - name: "total_base_episode_fee"
      expr: SUM(CAST(base_episode_fee AS DOUBLE))
      comment: "Total episodic fee commitments across all compensation structures. Core production cost driver."
    - name: "avg_base_episode_fee"
      expr: AVG(CAST(base_episode_fee AS DOUBLE))
      comment: "Average episodic fee per compensation structure. Benchmarks talent cost per episode for budget planning."
    - name: "total_weekly_guarantee"
      expr: SUM(CAST(weekly_guarantee AS DOUBLE))
      comment: "Total weekly guaranteed compensation commitments. Represents minimum cash outflow for weekly-deal talent."
    - name: "total_deferred_compensation"
      expr: SUM(CAST(deferred_compensation_amount AS DOUBLE))
      comment: "Total deferred compensation obligations across the portfolio. Future liability for finance planning."
    - name: "avg_backend_gross_participation_pct"
      expr: AVG(CAST(backend_gross_participation_pct AS DOUBLE))
      comment: "Average backend gross participation percentage. Measures profit-sharing exposure on content exploitation."
    - name: "avg_pension_health_rate"
      expr: AVG(CAST(pension_health_rate AS DOUBLE))
      comment: "Average pension and health contribution rate across structures. Guild compliance cost benchmarking."
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus commitments across compensation structures. Incentive cost exposure for budget management."
    - name: "total_step_up_amount"
      expr: SUM(CAST(step_up_amount AS DOUBLE))
      comment: "Total contractual step-up amounts. Quantifies future compensation escalation built into current deals."
    - name: "avg_overtime_multiplier"
      expr: AVG(CAST(overtime_multiplier AS DOUBLE))
      comment: "Average overtime multiplier across structures. Indicates overtime cost exposure relative to base rates."
    - name: "pay_or_play_structure_count"
      expr: COUNT(CASE WHEN pay_or_play_flag = TRUE THEN 1 END)
      comment: "Number of pay-or-play compensation structures. Guaranteed spend regardless of production decisions."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_cba_rate_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guild rate card compliance KPIs: monitors minimum scale rates, overtime multipliers, pension contribution rates, and meal penalty obligations across collective bargaining agreements."
  source: "`vibe_media_broadcasting_v1`.`talent`.`cba_rate_card`"
  dimensions:
    - name: "guild_code"
      expr: guild_code
      comment: "Guild or union code (SAG-AFTRA, WGA, DGA, IATSE) for rate card segmentation."
    - name: "cba_name"
      expr: cba_name
      comment: "Name of the collective bargaining agreement governing this rate card."
    - name: "rate_type"
      expr: rate_type
      comment: "Type of rate (scale, above-scale, low-budget, new media) for compliance classification."
    - name: "rate_status"
      expr: rate_status
      comment: "Current status of the rate card (active, superseded, expired) for compliance currency."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Geographic jurisdiction of the CBA for multi-territory production cost planning."
    - name: "budget_tier"
      expr: budget_tier
      comment: "Production budget tier (low-budget, standard, high-budget) determining applicable rate schedule."
    - name: "residual_eligibility_flag"
      expr: residual_eligibility_flag
      comment: "Whether this rate card carries residual eligibility, impacting future payment obligations."
    - name: "effective_date_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the rate card became effective, for CBA vintage and escalation tracking."
  measures:
    - name: "avg_minimum_scale_rate"
      expr: AVG(CAST(minimum_scale_rate AS DOUBLE))
      comment: "Average minimum scale rate across active CBA rate cards. Baseline for production budget compliance."
    - name: "max_minimum_scale_rate"
      expr: MAX(CAST(minimum_scale_rate AS DOUBLE))
      comment: "Highest minimum scale rate in the portfolio. Identifies most expensive guild obligations for budget risk."
    - name: "avg_overtime_multiplier"
      expr: AVG(CAST(overtime_multiplier AS DOUBLE))
      comment: "Average overtime multiplier across rate cards. Benchmarks overtime cost exposure by guild and jurisdiction."
    - name: "avg_pension_health_contribution_rate"
      expr: AVG(CAST(pension_health_contribution_rate AS DOUBLE))
      comment: "Average pension and health contribution rate. Measures guild benefit cost burden on production budgets."
    - name: "avg_meal_penalty_amount"
      expr: AVG(CAST(meal_penalty_amount AS DOUBLE))
      comment: "Average meal penalty amount per rate card. Operational compliance cost for production scheduling."
    - name: "avg_golden_time_multiplier"
      expr: AVG(CAST(golden_time_multiplier AS DOUBLE))
      comment: "Average golden time multiplier. Extreme overtime cost indicator for production schedule risk management."
    - name: "active_rate_card_count"
      expr: COUNT(CASE WHEN rate_status = 'active' THEN 1 END)
      comment: "Number of currently active CBA rate cards. Scope of active guild compliance obligations."
    - name: "avg_overtime_threshold_hours"
      expr: AVG(CAST(overtime_threshold_hours AS DOUBLE))
      comment: "Average daily/weekly hours before overtime kicks in. Informs production scheduling to minimize overtime costs."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_pension_health_contribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guild pension and health fund contribution KPIs: tracks employer and employee contribution amounts, remittance compliance, late payment penalties, and fund allocation across guilds."
  source: "`vibe_media_broadcasting_v1`.`talent`.`pension_health_contribution`"
  dimensions:
    - name: "contribution_type"
      expr: contribution_type
      comment: "Type of contribution (pension, health, vacation, training) for fund-level reporting."
    - name: "guild_fund_name"
      expr: guild_fund_name
      comment: "Name of the guild fund receiving contributions (SAG-AFTRA Health Plan, IATSE Pension, etc.)."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the contribution is in compliance with CBA requirements. Flags non-compliant remittances."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to remit contributions (ACH, wire, check) for treasury reconciliation."
    - name: "contribution_period_start_month"
      expr: DATE_TRUNC('month', contribution_period_start_date)
      comment: "Month of the contribution period for trend and seasonality analysis."
    - name: "remittance_due_date_month"
      expr: DATE_TRUNC('month', remittance_due_date)
      comment: "Month contributions are due, for cash flow planning and late payment risk identification."
  measures:
    - name: "total_employer_contribution_amount"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer pension and health contributions. Primary guild compliance cost for production finance."
    - name: "total_employee_contribution_amount"
      expr: SUM(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Total employee-side contributions withheld and remitted. Payroll compliance metric."
    - name: "total_contribution_amount"
      expr: SUM(CAST(total_contribution_amount AS DOUBLE))
      comment: "Total combined pension and health contributions. Aggregate guild fund obligation for period reporting."
    - name: "total_late_payment_penalty_amount"
      expr: SUM(CAST(late_payment_penalty_amount AS DOUBLE))
      comment: "Total late payment penalties incurred. Operational efficiency metric — high penalties indicate remittance process failures."
    - name: "total_gross_compensation_base"
      expr: SUM(CAST(gross_compensation_base AS DOUBLE))
      comment: "Total gross compensation base used to calculate contributions. Validates contribution rate application."
    - name: "avg_employer_contribution_rate"
      expr: AVG(CAST(employer_contribution_rate AS DOUBLE))
      comment: "Average employer contribution rate across all remittances. Benchmarks against CBA-mandated rates for compliance."
    - name: "contribution_record_count"
      expr: COUNT(1)
      comment: "Total number of contribution records. Volume metric for remittance processing throughput."
    - name: "non_compliant_contribution_count"
      expr: COUNT(CASE WHEN compliance_flag = FALSE THEN 1 END)
      comment: "Number of non-compliant contribution records. Critical guild compliance risk indicator requiring immediate remediation."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total contribution adjustments (corrections, true-ups). High adjustment volumes indicate upstream payroll data quality issues."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_appearance_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent scheduling and availability KPIs: tracks booking confirmation rates, scheduling conflicts, guild notification compliance, and estimated vs actual appearance durations for production planning."
  source: "`vibe_media_broadcasting_v1`.`talent`.`appearance_schedule`"
  dimensions:
    - name: "appearance_type"
      expr: appearance_type
      comment: "Type of appearance (principal, guest, cameo, voice, stunt) for scheduling capacity analysis."
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Booking confirmation status (confirmed, tentative, cancelled, hold) for production planning."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the appearance for scheduling density and studio utilization analysis."
    - name: "exclusivity_conflict_flag"
      expr: exclusivity_conflict_flag
      comment: "Whether an exclusivity conflict was detected for this appearance. Risk indicator for legal review."
    - name: "guild_notification_required"
      expr: guild_notification_required
      comment: "Whether guild notification is required for this appearance. Compliance obligation tracking."
    - name: "call_date_month"
      expr: DATE_TRUNC('month', call_date)
      comment: "Month of the scheduled call date for production calendar and resource planning."
  measures:
    - name: "total_appearances_scheduled"
      expr: COUNT(1)
      comment: "Total number of talent appearances scheduled. Production capacity and talent utilization baseline."
    - name: "confirmed_appearance_count"
      expr: COUNT(CASE WHEN confirmation_status = 'confirmed' THEN 1 END)
      comment: "Number of confirmed talent appearances. Locked production schedule metric for resource allocation."
    - name: "cancelled_appearance_count"
      expr: COUNT(CASE WHEN cancellation_reason IS NOT NULL THEN 1 END)
      comment: "Number of cancelled appearances. High cancellation rates signal scheduling instability and production cost risk."
    - name: "total_estimated_duration_hours"
      expr: SUM(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Total estimated appearance hours scheduled. Studio and crew resource planning metric."
    - name: "total_actual_duration_hours"
      expr: SUM(CAST(actual_duration_hours AS DOUBLE))
      comment: "Total actual appearance hours recorded. Compared against estimates to identify scheduling overruns."
    - name: "avg_actual_duration_hours"
      expr: AVG(CAST(actual_duration_hours AS DOUBLE))
      comment: "Average actual appearance duration in hours. Benchmarks against estimated duration for scheduling accuracy."
    - name: "exclusivity_conflict_count"
      expr: COUNT(CASE WHEN exclusivity_conflict_flag = TRUE THEN 1 END)
      comment: "Number of appearances with detected exclusivity conflicts. Legal and business affairs risk exposure."
    - name: "guild_notification_pending_count"
      expr: COUNT(CASE WHEN guild_notification_required = TRUE AND guild_notification_sent_timestamp IS NULL THEN 1 END)
      comment: "Appearances requiring guild notification that have not yet been sent. CBA compliance gap requiring urgent action."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_participation_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Backend participation financial KPIs: tracks gross receipts, net proceeds, participation amounts due, breakeven achievement, and audit status for talent profit participation accounting."
  source: "`vibe_media_broadcasting_v1`.`talent`.`participation_statement`"
  dimensions:
    - name: "statement_status"
      expr: statement_status
      comment: "Status of the participation statement (draft, issued, disputed, settled) for accounting workflow."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the participation statement for multi-currency financial reporting."
    - name: "breakeven_reached_flag"
      expr: breakeven_reached_flag
      comment: "Whether breakeven has been reached on this title, triggering participation payment obligations."
    - name: "audited_flag"
      expr: audited_flag
      comment: "Whether the statement has been audited. Indicates financial scrutiny level and dispute risk."
    - name: "statement_period_start_quarter"
      expr: DATE_TRUNC('quarter', statement_period_start)
      comment: "Quarter of the statement period for trend analysis of participation flows."
    - name: "issued_date_year"
      expr: DATE_TRUNC('year', issued_date)
      comment: "Year the statement was issued for annual participation accounting review."
  measures:
    - name: "total_gross_receipts"
      expr: SUM(CAST(gross_receipts_amount AS DOUBLE))
      comment: "Total gross receipts reported across participation statements. Top-line revenue basis for participation calculations."
    - name: "total_adjusted_gross_amount"
      expr: SUM(CAST(adjusted_gross_amount AS DOUBLE))
      comment: "Total adjusted gross after allowable deductions. Basis for adjusted-gross participation calculations."
    - name: "total_net_proceeds"
      expr: SUM(CAST(net_proceeds_amount AS DOUBLE))
      comment: "Total net proceeds after all deductions. Basis for net profit participation calculations."
    - name: "total_participation_amount_due"
      expr: SUM(CAST(participation_amount_due AS DOUBLE))
      comment: "Total participation amounts owed to talent. Primary liability metric for talent backend accounting."
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total participation amounts already paid. Cash outflow metric for accounts payable reconciliation."
    - name: "total_balance_amount"
      expr: SUM(CAST(balance_amount AS DOUBLE))
      comment: "Total outstanding participation balance (due minus paid). Unpaid liability exposure for finance reporting."
    - name: "total_deductible_costs"
      expr: SUM(CAST(deductible_costs_amount AS DOUBLE))
      comment: "Total deductible costs applied against gross receipts. Validates cost deduction methodology for audit purposes."
    - name: "total_distribution_fee_amount"
      expr: SUM(CAST(distribution_fee_amount AS DOUBLE))
      comment: "Total distribution fees deducted from gross receipts. Key deduction category in participation accounting disputes."
    - name: "statement_count"
      expr: COUNT(1)
      comment: "Total number of participation statements issued. Volume metric for backend accounting workload."
    - name: "breakeven_reached_title_count"
      expr: COUNT(DISTINCT CASE WHEN breakeven_reached_flag = TRUE THEN title_id END)
      comment: "Number of distinct titles where breakeven has been reached. Triggers active participation payment obligations."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_bonus_trigger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent bonus trigger KPIs: monitors bonus threshold achievement, triggered vs pending bonuses, total bonus exposure, and payment status for incentive compensation management."
  source: "`vibe_media_broadcasting_v1`.`talent`.`bonus_trigger`"
  dimensions:
    - name: "trigger_type"
      expr: trigger_type
      comment: "Type of bonus trigger (box-office, viewership, award, streaming milestone) for incentive program analysis."
    - name: "trigger_metric"
      expr: trigger_metric
      comment: "Specific metric being measured (e.g., opening weekend gross, Nielsen rating, Emmy nomination) for trigger tracking."
    - name: "threshold_unit"
      expr: threshold_unit
      comment: "Unit of the threshold measurement (USD, viewers, rating points) for cross-trigger comparability."
    - name: "is_triggered_flag"
      expr: is_triggered_flag
      comment: "Whether the bonus trigger condition has been met. Separates earned from contingent bonus obligations."
    - name: "paid_flag"
      expr: paid_flag
      comment: "Whether the triggered bonus has been paid. Identifies earned but unpaid bonus liabilities."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the bonus for multi-currency incentive compensation reporting."
    - name: "triggered_date_quarter"
      expr: DATE_TRUNC('quarter', triggered_date)
      comment: "Quarter the bonus was triggered for incentive cost timing and accrual analysis."
  measures:
    - name: "total_bonus_amount_committed"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus amounts committed across all triggers. Full incentive compensation exposure for budget planning."
    - name: "total_triggered_bonus_amount"
      expr: SUM(CASE WHEN is_triggered_flag = TRUE THEN CAST(bonus_amount AS DOUBLE) ELSE 0 END)
      comment: "Total bonus amounts where trigger conditions have been met. Earned incentive liability requiring payment."
    - name: "total_unpaid_triggered_bonus"
      expr: SUM(CASE WHEN is_triggered_flag = TRUE AND paid_flag = FALSE THEN CAST(bonus_amount AS DOUBLE) ELSE 0 END)
      comment: "Total earned but unpaid bonus amounts. Outstanding incentive liability for accounts payable prioritization."
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average bonus threshold value. Benchmarks incentive trigger difficulty across the talent portfolio."
    - name: "avg_bonus_percentage"
      expr: AVG(CAST(bonus_percentage AS DOUBLE))
      comment: "Average bonus percentage across triggers. Measures incentive generosity relative to base compensation."
    - name: "triggered_bonus_count"
      expr: COUNT(CASE WHEN is_triggered_flag = TRUE THEN 1 END)
      comment: "Number of bonus triggers that have been activated. Measures incentive program effectiveness."
    - name: "total_bonus_triggers"
      expr: COUNT(1)
      comment: "Total number of bonus trigger records. Scope of incentive compensation commitments in the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_deferred_compensation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deferred compensation liability KPIs: tracks total deferred amounts, vested obligations, outstanding balances, and payout schedules for talent deferred pay management and financial planning."
  source: "`vibe_media_broadcasting_v1`.`talent`.`deferred_compensation`"
  dimensions:
    - name: "deferral_type"
      expr: deferral_type
      comment: "Type of deferral (contractual, elective, performance-based) for liability classification."
    - name: "deferral_trigger"
      expr: deferral_trigger
      comment: "Event or condition that triggered the deferral (deal close, production start, distribution) for timing analysis."
    - name: "deferred_compensation_status"
      expr: deferred_compensation_status
      comment: "Current status of the deferred compensation (accruing, vested, paid, forfeited) for liability management."
    - name: "is_fully_paid"
      expr: is_fully_paid
      comment: "Whether the deferred compensation has been fully paid out. Separates open from closed obligations."
    - name: "is_payable_flag"
      expr: is_payable_flag
      comment: "Whether the deferred compensation is currently payable. Identifies near-term cash obligations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the deferred compensation for multi-currency liability reporting."
    - name: "payout_date_quarter"
      expr: DATE_TRUNC('quarter', payout_date)
      comment: "Quarter of scheduled payout for cash flow forecasting and treasury planning."
  measures:
    - name: "total_deferred_amount"
      expr: SUM(CAST(deferred_amount AS DOUBLE))
      comment: "Total deferred compensation obligations. Full future liability for talent deferred pay on the balance sheet."
    - name: "total_vested_amount"
      expr: SUM(CAST(vested_amount AS DOUBLE))
      comment: "Total vested deferred compensation. Earned but unpaid obligations that cannot be forfeited."
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total outstanding deferred compensation balance. Net unpaid liability for financial statement reporting."
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total deferred compensation already paid out. Cash outflow metric for treasury reconciliation."
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average interest rate applied to deferred compensation. Cost of carry metric for finance planning."
    - name: "payable_deferred_count"
      expr: COUNT(CASE WHEN is_payable_flag = TRUE AND is_fully_paid = FALSE THEN 1 END)
      comment: "Number of deferred compensation records currently payable but not yet paid. Immediate cash obligation count."
    - name: "total_deferred_records"
      expr: COUNT(1)
      comment: "Total number of deferred compensation records. Scope of deferred pay obligations in the talent portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_grievance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent grievance and labor dispute KPIs: tracks open grievances, disputed amounts, settlement costs, resolution rates, and arbitration activity for guild relations and legal risk management."
  source: "`vibe_media_broadcasting_v1`.`talent`.`talent_grievance`"
  dimensions:
    - name: "grievance_type"
      expr: grievance_type_id
      comment: "Type of grievance (residual underpayment, credit dispute, working conditions, safety) for root cause analysis."
    - name: "resolution_status"
      expr: resolution_status_id
      comment: "Current resolution status (open, in-arbitration, settled, withdrawn) for case management."
    - name: "confidentiality_flag"
      expr: confidentiality_flag
      comment: "Whether the grievance is confidential. Affects public reporting and disclosure obligations."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Whether an appeal has been filed. Indicates escalated disputes requiring senior legal attention."
    - name: "filing_date_quarter"
      expr: DATE_TRUNC('quarter', filing_date)
      comment: "Quarter the grievance was filed for trend analysis and guild relations monitoring."
    - name: "resolution_date_quarter"
      expr: DATE_TRUNC('quarter', resolution_date)
      comment: "Quarter the grievance was resolved for cycle time and backlog analysis."
  measures:
    - name: "total_grievances_filed"
      expr: COUNT(1)
      comment: "Total number of talent grievances filed. Baseline metric for guild relations health and legal risk exposure."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total monetary amount in dispute across all grievances. Financial risk exposure for legal and finance teams."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amounts paid to resolve grievances. Actual cost of labor disputes for budget tracking."
    - name: "avg_settlement_amount"
      expr: AVG(CAST(settlement_amount AS DOUBLE))
      comment: "Average settlement amount per resolved grievance. Benchmarks dispute resolution cost for negotiation strategy."
    - name: "open_grievance_count"
      expr: COUNT(CASE WHEN resolution_date IS NULL THEN 1 END)
      comment: "Number of unresolved grievances. Active legal risk exposure requiring business affairs attention."
    - name: "arbitration_case_count"
      expr: COUNT(CASE WHEN arbitration_reference_number IS NOT NULL THEN 1 END)
      comment: "Number of grievances escalated to arbitration. High arbitration rates signal deteriorating guild relations."
    - name: "appeal_filed_count"
      expr: COUNT(CASE WHEN appeal_filed_flag = TRUE THEN 1 END)
      comment: "Number of grievances with appeals filed. Indicates contested resolutions and prolonged dispute exposure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_endorsement_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent endorsement deal KPIs: tracks deal value, commission rates, exclusivity periods, renewal pipeline, and morals clause exposure across the talent endorsement portfolio."
  source: "`vibe_media_broadcasting_v1`.`talent`.`endorsement_deal`"
  dimensions:
    - name: "deal_status"
      expr: deal_status
      comment: "Current status of the endorsement deal (active, expired, terminated, pending) for portfolio management."
    - name: "brand_name"
      expr: brand_name
      comment: "Brand or advertiser associated with the endorsement for category and conflict analysis."
    - name: "usage_territory"
      expr: usage_territory
      comment: "Geographic territory of the endorsement usage for rights and exclusivity management."
    - name: "morals_clause_flag"
      expr: morals_clause_flag
      comment: "Whether the deal includes a morals clause. Risk management indicator for brand safety."
    - name: "renewal_option_flag"
      expr: renewal_option_flag
      comment: "Whether the deal has a renewal option. Pipeline indicator for future endorsement revenue."
    - name: "contract_start_date_year"
      expr: DATE_TRUNC('year', contract_start_date)
      comment: "Year the endorsement deal commenced for vintage and portfolio age analysis."
  measures:
    - name: "total_deal_value"
      expr: SUM(CAST(deal_value_amount AS DOUBLE))
      comment: "Total endorsement deal value across the portfolio. Revenue and talent monetization metric."
    - name: "avg_deal_value"
      expr: AVG(CAST(deal_value_amount AS DOUBLE))
      comment: "Average endorsement deal value. Benchmarks talent commercial appeal and negotiating leverage."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average agency commission rate on endorsement deals. Agency cost burden on talent endorsement revenue."
    - name: "active_deal_count"
      expr: COUNT(CASE WHEN deal_status = 'active' THEN 1 END)
      comment: "Number of currently active endorsement deals. Active commercial partnership portfolio size."
    - name: "renewal_pipeline_count"
      expr: COUNT(CASE WHEN renewal_option_flag = TRUE AND deal_status = 'active' THEN 1 END)
      comment: "Number of active deals with renewal options. Forward pipeline for endorsement revenue continuity."
    - name: "morals_clause_deal_count"
      expr: COUNT(CASE WHEN morals_clause_flag = TRUE THEN 1 END)
      comment: "Number of deals with morals clauses. Brand safety risk management scope across the endorsement portfolio."
    - name: "total_endorsement_deals"
      expr: COUNT(1)
      comment: "Total number of endorsement deals. Scope of talent commercial activity for portfolio management."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_representation_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent representation agreement KPIs: tracks agency relationships, commission rates, exclusivity, residual routing, and agreement renewal pipeline for talent management operations."
  source: "`vibe_media_broadcasting_v1`.`talent`.`representation_agreement`"
  dimensions:
    - name: "representation_agreement_status"
      expr: representation_agreement_status
      comment: "Current status of the representation agreement (active, terminated, expired) for agency relationship management."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the representation is exclusive. Indicates single-agency commitment and competitive restriction."
    - name: "guild_franchise_flag"
      expr: guild_franchise_flag
      comment: "Whether the agency is guild-franchised. Required for guild-covered talent representation compliance."
    - name: "residual_routing_flag"
      expr: residual_routing_flag
      comment: "Whether residual payments are routed through the agency. Affects residual payment workflow and commission deductions."
    - name: "renewal_option_flag"
      expr: renewal_option_flag
      comment: "Whether the agreement has a renewal option. Pipeline indicator for ongoing agency relationships."
    - name: "effective_start_date_year"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the representation agreement commenced for portfolio vintage analysis."
  measures:
    - name: "total_representation_agreements"
      expr: COUNT(1)
      comment: "Total number of representation agreements. Scope of agency relationships across the talent roster."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN representation_agreement_status = 'active' THEN 1 END)
      comment: "Number of currently active representation agreements. Active agency relationship portfolio size."
    - name: "avg_commission_percentage"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average agency commission percentage. Benchmarks agency cost burden on talent compensation."
    - name: "avg_commission_cap_amount"
      expr: AVG(CAST(commission_cap_amount AS DOUBLE))
      comment: "Average commission cap amount. Measures negotiated limits on agency commission exposure."
    - name: "exclusive_agreement_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END)
      comment: "Number of exclusive representation agreements. Indicates single-agency commitments limiting talent flexibility."
    - name: "guild_franchised_agency_count"
      expr: COUNT(DISTINCT CASE WHEN guild_franchise_flag = TRUE THEN talent_agency_id END)
      comment: "Number of distinct guild-franchised agencies in the representation portfolio. Guild compliance coverage metric."
    - name: "residual_routing_agreement_count"
      expr: COUNT(CASE WHEN residual_routing_flag = TRUE THEN 1 END)
      comment: "Number of agreements where residuals are routed through the agency. Affects residual payment processing workflow."
$$;