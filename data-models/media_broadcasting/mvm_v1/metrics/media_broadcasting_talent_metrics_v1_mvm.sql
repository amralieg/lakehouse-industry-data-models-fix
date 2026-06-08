-- Metric views for domain: talent | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 19:19:28

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`talent_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core talent contract metrics tracking deal value, backend participation, and contract lifecycle for production and series engagements."
  source: "`media_broadcasting_ecm`.`talent`.`contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of talent contract (e.g., series regular, guest star, producer deal)"
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract (active, expired, terminated, pending)"
    - name: "engagement_role"
      expr: engagement_role
      comment: "Role or function the talent is engaged for under this contract"
    - name: "backend_participation_type"
      expr: backend_participation_type
      comment: "Type of backend participation (gross, net, adjusted gross)"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the contract includes exclusivity provisions"
    - name: "pay_or_play_flag"
      expr: pay_or_play_flag
      comment: "Whether the contract is pay-or-play (guaranteed compensation regardless of production)"
    - name: "residual_eligibility_flag"
      expr: residual_eligibility_flag
      comment: "Whether the talent is eligible for residual payments under this contract"
    - name: "option_exercise_status"
      expr: option_exercise_status
      comment: "Status of option exercise (exercised, pending, expired, declined)"
    - name: "contract_year"
      expr: YEAR(effective_start_date)
      comment: "Year the contract became effective"
    - name: "contract_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the contract became effective"
  measures:
    - name: "total_base_compensation"
      expr: SUM(CAST(base_compensation_amount AS DOUBLE))
      comment: "Total base compensation amount across all contracts"
    - name: "avg_base_compensation"
      expr: AVG(CAST(base_compensation_amount AS DOUBLE))
      comment: "Average base compensation per contract"
    - name: "total_backend_participation_value"
      expr: SUM(CAST(backend_participation_percentage AS DOUBLE))
      comment: "Sum of backend participation percentages across contracts (for portfolio analysis)"
    - name: "avg_backend_participation_pct"
      expr: AVG(CAST(backend_participation_percentage AS DOUBLE))
      comment: "Average backend participation percentage per contract"
    - name: "total_step_up_value"
      expr: SUM(CAST(step_up_amount AS DOUBLE))
      comment: "Total step-up compensation amounts across contracts"
    - name: "contract_count"
      expr: COUNT(DISTINCT contract_id)
      comment: "Number of unique talent contracts"
    - name: "pay_or_play_contract_count"
      expr: COUNT(DISTINCT CASE WHEN pay_or_play_flag = TRUE THEN contract_id END)
      comment: "Number of pay-or-play contracts (guaranteed compensation risk exposure)"
    - name: "exclusive_contract_count"
      expr: COUNT(DISTINCT CASE WHEN exclusivity_flag = TRUE THEN contract_id END)
      comment: "Number of contracts with exclusivity clauses"
    - name: "residual_eligible_contract_count"
      expr: COUNT(DISTINCT CASE WHEN residual_eligibility_flag = TRUE THEN contract_id END)
      comment: "Number of contracts eligible for residual payments (ongoing cost exposure)"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`talent_residual_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Residual payment metrics tracking ongoing talent compensation from content reuse, syndication, and distribution across channels and windows."
  source: "`media_broadcasting_ecm`.`talent`.`residual_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the residual payment (paid, pending, disputed, cancelled)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (ACH, wire, check)"
    - name: "use_type"
      expr: use_type
      comment: "Type of content use triggering the residual (broadcast, streaming, syndication, home video)"
    - name: "distribution_window"
      expr: distribution_window
      comment: "Distribution window for the content use (first run, rerun, foreign, supplemental)"
    - name: "payment_currency_code"
      expr: payment_currency_code
      comment: "Currency code for the residual payment"
    - name: "audit_report_flag"
      expr: audit_report_flag
      comment: "Whether this payment was subject to audit reporting"
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year the residual payment was made"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month the residual payment was made"
    - name: "exhibition_year"
      expr: YEAR(exhibition_start_date)
      comment: "Year the content exhibition began that triggered the residual"
  measures:
    - name: "total_gross_residual_amount"
      expr: SUM(CAST(gross_residual_amount AS DOUBLE))
      comment: "Total gross residual payments before deductions"
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net residual payments after all deductions (actual cash out)"
    - name: "total_agent_commission"
      expr: SUM(CAST(agent_commission_amount AS DOUBLE))
      comment: "Total agent commission deducted from residual payments"
    - name: "total_pension_health_contribution"
      expr: SUM(CAST(pension_health_amount AS DOUBLE))
      comment: "Total pension and health contributions deducted from residuals"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from residual payments"
    - name: "avg_gross_residual_per_payment"
      expr: AVG(CAST(gross_residual_amount AS DOUBLE))
      comment: "Average gross residual amount per payment transaction"
    - name: "avg_net_payment_per_transaction"
      expr: AVG(CAST(net_payment_amount AS DOUBLE))
      comment: "Average net payment amount per transaction"
    - name: "residual_payment_count"
      expr: COUNT(DISTINCT residual_payment_id)
      comment: "Number of unique residual payment transactions"
    - name: "unique_talent_paid"
      expr: COUNT(DISTINCT talent_profile_id)
      comment: "Number of unique talent profiles receiving residual payments"
    - name: "unique_titles_generating_residuals"
      expr: COUNT(DISTINCT title_id)
      comment: "Number of unique titles generating residual payments (content portfolio monetization)"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`talent_compensation_structure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation structure metrics tracking talent pay models, rates, and terms across contracts and guild affiliations."
  source: "`media_broadcasting_ecm`.`talent`.`compensation_structure`"
  dimensions:
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation structure (episodic, weekly, daily, flat fee, backend)"
    - name: "structure_status"
      expr: structure_status
      comment: "Status of the compensation structure (active, expired, superseded)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for compensation amounts"
    - name: "pay_or_play_flag"
      expr: pay_or_play_flag
      comment: "Whether this compensation structure is pay-or-play"
    - name: "residual_eligibility_flag"
      expr: residual_eligibility_flag
      comment: "Whether this compensation structure includes residual eligibility"
    - name: "exclusivity_clause_flag"
      expr: exclusivity_clause_flag
      comment: "Whether this compensation structure includes exclusivity provisions"
    - name: "structure_year"
      expr: YEAR(effective_start_date)
      comment: "Year the compensation structure became effective"
  measures:
    - name: "total_base_episode_fees"
      expr: SUM(CAST(base_episode_fee AS DOUBLE))
      comment: "Total base episode fees across all compensation structures"
    - name: "avg_base_episode_fee"
      expr: AVG(CAST(base_episode_fee AS DOUBLE))
      comment: "Average base episode fee per compensation structure"
    - name: "total_daily_rate_value"
      expr: SUM(CAST(daily_rate AS DOUBLE))
      comment: "Total daily rate compensation across structures"
    - name: "avg_daily_rate"
      expr: AVG(CAST(daily_rate AS DOUBLE))
      comment: "Average daily rate per compensation structure"
    - name: "total_weekly_guarantee"
      expr: SUM(CAST(weekly_guarantee AS DOUBLE))
      comment: "Total weekly guarantee amounts across structures"
    - name: "avg_backend_gross_participation_pct"
      expr: AVG(CAST(backend_gross_participation_pct AS DOUBLE))
      comment: "Average backend gross participation percentage"
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus amounts across compensation structures"
    - name: "total_deferred_compensation"
      expr: SUM(CAST(deferred_compensation_amount AS DOUBLE))
      comment: "Total deferred compensation amounts (future cash flow obligation)"
    - name: "avg_overtime_multiplier"
      expr: AVG(CAST(overtime_multiplier AS DOUBLE))
      comment: "Average overtime multiplier across compensation structures"
    - name: "compensation_structure_count"
      expr: COUNT(DISTINCT compensation_structure_id)
      comment: "Number of unique compensation structures"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`talent_role`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent role metrics tracking character assignments, screen time, compensation, and usage rights across productions."
  source: "`media_broadcasting_ecm`.`talent`.`role`"
  dimensions:
    - name: "role_category"
      expr: role_category
      comment: "Category of the role (lead, supporting, guest, recurring, background)"
    - name: "role_status"
      expr: role_status
      comment: "Status of the role assignment (active, completed, cancelled)"
    - name: "credit_type"
      expr: credit_type
      comment: "Type of credit given (main title, end title, special guest)"
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation for the role (episodic, flat fee, backend)"
    - name: "above_the_line_flag"
      expr: above_the_line_flag
      comment: "Whether the role is above-the-line (principal talent)"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the role includes exclusivity provisions"
    - name: "residual_eligible_flag"
      expr: residual_eligible_flag
      comment: "Whether the role is eligible for residual payments"
    - name: "voice_only_flag"
      expr: voice_only_flag
      comment: "Whether the role is voice-only (animation, ADR)"
    - name: "stunt_double_flag"
      expr: stunt_double_flag
      comment: "Whether the role is a stunt double assignment"
    - name: "role_start_year"
      expr: YEAR(start_date)
      comment: "Year the role assignment started"
  measures:
    - name: "total_role_compensation"
      expr: SUM(CAST(compensation_amount AS DOUBLE))
      comment: "Total compensation across all role assignments"
    - name: "avg_role_compensation"
      expr: AVG(CAST(compensation_amount AS DOUBLE))
      comment: "Average compensation per role assignment"
    - name: "total_screen_time_minutes"
      expr: SUM(CAST(screen_time_minutes AS DOUBLE))
      comment: "Total screen time in minutes across all roles"
    - name: "avg_screen_time_per_role"
      expr: AVG(CAST(screen_time_minutes AS DOUBLE))
      comment: "Average screen time per role assignment"
    - name: "role_count"
      expr: COUNT(DISTINCT role_id)
      comment: "Number of unique role assignments"
    - name: "unique_talent_count"
      expr: COUNT(DISTINCT talent_profile_id)
      comment: "Number of unique talent profiles with role assignments"
    - name: "above_the_line_role_count"
      expr: COUNT(DISTINCT CASE WHEN above_the_line_flag = TRUE THEN role_id END)
      comment: "Number of above-the-line role assignments (principal talent cost driver)"
    - name: "residual_eligible_role_count"
      expr: COUNT(DISTINCT CASE WHEN residual_eligible_flag = TRUE THEN role_id END)
      comment: "Number of roles eligible for residuals (ongoing cost exposure)"
    - name: "exclusive_role_count"
      expr: COUNT(DISTINCT CASE WHEN exclusivity_flag = TRUE THEN role_id END)
      comment: "Number of roles with exclusivity provisions"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`talent_appearance_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent appearance scheduling metrics tracking bookings, call times, actual vs estimated duration, and scheduling efficiency."
  source: "`media_broadcasting_ecm`.`talent`.`appearance_schedule`"
  dimensions:
    - name: "appearance_type"
      expr: appearance_type
      comment: "Type of appearance (on-camera, voice-over, rehearsal, fitting, promo)"
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Confirmation status of the appearance (confirmed, tentative, cancelled)"
    - name: "hold_level"
      expr: hold_level
      comment: "Hold level for the appearance (first refusal, second refusal, pencil)"
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the scheduled appearance (morning, afternoon, evening, overnight)"
    - name: "guild_notification_required"
      expr: guild_notification_required
      comment: "Whether guild notification is required for this appearance"
    - name: "exclusivity_conflict_flag"
      expr: exclusivity_conflict_flag
      comment: "Whether this appearance has an exclusivity conflict"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for cancellation if the appearance was cancelled"
    - name: "call_year"
      expr: YEAR(call_date)
      comment: "Year of the scheduled call date"
    - name: "call_month"
      expr: DATE_TRUNC('MONTH', call_date)
      comment: "Month of the scheduled call date"
  measures:
    - name: "total_estimated_duration_hours"
      expr: SUM(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Total estimated duration hours across all scheduled appearances"
    - name: "total_actual_duration_hours"
      expr: SUM(CAST(actual_duration_hours AS DOUBLE))
      comment: "Total actual duration hours across all completed appearances"
    - name: "avg_estimated_duration_hours"
      expr: AVG(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average estimated duration per appearance"
    - name: "avg_actual_duration_hours"
      expr: AVG(CAST(actual_duration_hours AS DOUBLE))
      comment: "Average actual duration per appearance"
    - name: "appearance_count"
      expr: COUNT(DISTINCT appearance_schedule_id)
      comment: "Number of unique scheduled appearances"
    - name: "confirmed_appearance_count"
      expr: COUNT(DISTINCT CASE WHEN confirmation_status = 'confirmed' THEN appearance_schedule_id END)
      comment: "Number of confirmed appearances"
    - name: "cancelled_appearance_count"
      expr: COUNT(DISTINCT CASE WHEN cancellation_reason IS NOT NULL THEN appearance_schedule_id END)
      comment: "Number of cancelled appearances (scheduling efficiency indicator)"
    - name: "rescheduled_appearance_count"
      expr: COUNT(DISTINCT CASE WHEN rescheduled_from_appearance_schedule_id IS NOT NULL THEN appearance_schedule_id END)
      comment: "Number of rescheduled appearances (scheduling stability indicator)"
    - name: "exclusivity_conflict_count"
      expr: COUNT(DISTINCT CASE WHEN exclusivity_conflict_flag = TRUE THEN appearance_schedule_id END)
      comment: "Number of appearances with exclusivity conflicts (compliance risk)"
    - name: "unique_talent_scheduled"
      expr: COUNT(DISTINCT talent_profile_id)
      comment: "Number of unique talent profiles scheduled for appearances"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`talent_guild_affiliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guild affiliation metrics tracking union membership, dues status, and benefit eligibility for talent workforce compliance."
  source: "`media_broadcasting_ecm`.`talent`.`guild_affiliation`"
  dimensions:
    - name: "guild_name"
      expr: guild_name
      comment: "Name of the guild or union (SAG-AFTRA, DGA, WGA, IATSE, etc.)"
    - name: "guild_code"
      expr: guild_code
      comment: "Standard code for the guild"
    - name: "membership_status"
      expr: membership_status
      comment: "Status of guild membership (active, inactive, suspended, honorary)"
    - name: "membership_tier"
      expr: membership_tier
      comment: "Tier or level of guild membership"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction of the guild affiliation (US, Canada, UK, etc.)"
    - name: "local_chapter"
      expr: local_chapter
      comment: "Local chapter of the guild"
    - name: "dues_payment_status"
      expr: dues_payment_status
      comment: "Status of dues payment (current, overdue, exempt)"
    - name: "pension_eligible_flag"
      expr: pension_eligible_flag
      comment: "Whether the member is eligible for pension benefits"
    - name: "health_benefits_eligible_flag"
      expr: health_benefits_eligible_flag
      comment: "Whether the member is eligible for health benefits"
    - name: "residual_eligibility_flag"
      expr: residual_eligibility_flag
      comment: "Whether the member is eligible for residual payments"
    - name: "join_year"
      expr: YEAR(join_date)
      comment: "Year the talent joined the guild"
  measures:
    - name: "guild_affiliation_count"
      expr: COUNT(DISTINCT guild_affiliation_id)
      comment: "Number of unique guild affiliations"
    - name: "unique_talent_with_guild"
      expr: COUNT(DISTINCT talent_profile_id)
      comment: "Number of unique talent profiles with guild affiliation"
    - name: "active_membership_count"
      expr: COUNT(DISTINCT CASE WHEN membership_status = 'active' THEN guild_affiliation_id END)
      comment: "Number of active guild memberships (compliance coverage)"
    - name: "pension_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN pension_eligible_flag = TRUE THEN guild_affiliation_id END)
      comment: "Number of guild affiliations with pension eligibility"
    - name: "health_benefits_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN health_benefits_eligible_flag = TRUE THEN guild_affiliation_id END)
      comment: "Number of guild affiliations with health benefits eligibility"
    - name: "residual_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN residual_eligibility_flag = TRUE THEN guild_affiliation_id END)
      comment: "Number of guild affiliations with residual eligibility (ongoing cost exposure)"
    - name: "overdue_dues_count"
      expr: COUNT(DISTINCT CASE WHEN dues_payment_status = 'overdue' THEN guild_affiliation_id END)
      comment: "Number of guild affiliations with overdue dues (compliance risk)"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`talent_cba_rate_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collective bargaining agreement rate card metrics tracking union scale rates, overtime rules, and residual formulas for production budgeting and compliance."
  source: "`media_broadcasting_ecm`.`talent`.`cba_rate_card`"
  dimensions:
    - name: "guild_code"
      expr: guild_code
      comment: "Guild code for the CBA rate card"
    - name: "cba_name"
      expr: cba_name
      comment: "Name of the collective bargaining agreement"
    - name: "cba_version"
      expr: cba_version
      comment: "Version of the CBA"
    - name: "job_classification"
      expr: job_classification
      comment: "Job classification covered by this rate card"
    - name: "performer_category"
      expr: performer_category
      comment: "Category of performer (principal, day player, background, stunt)"
    - name: "production_type"
      expr: production_type
      comment: "Type of production covered (theatrical, television, new media, commercial)"
    - name: "rate_type"
      expr: rate_type
      comment: "Type of rate (daily, weekly, session, per-episode)"
    - name: "rate_status"
      expr: rate_status
      comment: "Status of the rate card (active, expired, superseded)"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction for the rate card"
    - name: "residual_eligibility_flag"
      expr: residual_eligibility_flag
      comment: "Whether this rate card includes residual eligibility"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the rate card became effective"
  measures:
    - name: "avg_minimum_scale_rate"
      expr: AVG(CAST(minimum_scale_rate AS DOUBLE))
      comment: "Average minimum scale rate across rate cards"
    - name: "avg_overtime_multiplier"
      expr: AVG(CAST(overtime_multiplier AS DOUBLE))
      comment: "Average overtime multiplier across rate cards"
    - name: "avg_golden_time_multiplier"
      expr: AVG(CAST(golden_time_multiplier AS DOUBLE))
      comment: "Average golden time multiplier (premium overtime rate)"
    - name: "avg_forced_call_penalty_multiplier"
      expr: AVG(CAST(forced_call_penalty_multiplier AS DOUBLE))
      comment: "Average forced call penalty multiplier"
    - name: "avg_meal_penalty_amount"
      expr: AVG(CAST(meal_penalty_amount AS DOUBLE))
      comment: "Average meal penalty amount per rate card"
    - name: "avg_pension_health_contribution_rate"
      expr: AVG(CAST(pension_health_contribution_rate AS DOUBLE))
      comment: "Average pension and health contribution rate"
    - name: "avg_overtime_threshold_hours"
      expr: AVG(CAST(overtime_threshold_hours AS DOUBLE))
      comment: "Average overtime threshold in hours"
    - name: "avg_turnaround_hours"
      expr: AVG(CAST(turnaround_hours AS DOUBLE))
      comment: "Average turnaround hours required between calls"
    - name: "rate_card_count"
      expr: COUNT(DISTINCT cba_rate_card_id)
      comment: "Number of unique CBA rate cards"
    - name: "active_rate_card_count"
      expr: COUNT(DISTINCT CASE WHEN rate_status = 'active' THEN cba_rate_card_id END)
      comment: "Number of active CBA rate cards (current compliance baseline)"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`talent_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent profile metrics tracking workforce composition, clearance status, union affiliation, and compliance flags for the talent roster."
  source: "`media_broadcasting_ecm`.`talent`.`talent_profile`"
  dimensions:
    - name: "talent_type"
      expr: talent_type
      comment: "Type of talent (actor, director, writer, producer, crew, host)"
    - name: "talent_tier"
      expr: talent_tier
      comment: "Tier or level of talent (A-list, B-list, emerging, established)"
    - name: "profile_status"
      expr: profile_status
      comment: "Status of the talent profile (active, inactive, archived)"
    - name: "clearance_status"
      expr: clearance_status
      comment: "Clearance status for the talent (cleared, pending, expired, denied)"
    - name: "union_affiliation"
      expr: union_affiliation
      comment: "Union affiliation of the talent"
    - name: "work_authorization_status"
      expr: work_authorization_status
      comment: "Work authorization status (citizen, permanent resident, visa holder)"
    - name: "gender_identity"
      expr: gender_identity
      comment: "Gender identity of the talent"
    - name: "nationality"
      expr: nationality
      comment: "Nationality of the talent"
    - name: "residual_eligibility_flag"
      expr: residual_eligibility_flag
      comment: "Whether the talent is eligible for residual payments"
    - name: "insurance_coverage_flag"
      expr: insurance_coverage_flag
      comment: "Whether the talent has insurance coverage"
    - name: "exclusivity_clause_flag"
      expr: exclusivity_clause_flag
      comment: "Whether the talent has exclusivity clauses in effect"
    - name: "gdpr_consent_status"
      expr: gdpr_consent_status
      comment: "GDPR consent status for the talent"
    - name: "ccpa_opt_out_flag"
      expr: ccpa_opt_out_flag
      comment: "Whether the talent has opted out under CCPA"
  measures:
    - name: "talent_profile_count"
      expr: COUNT(DISTINCT talent_profile_id)
      comment: "Number of unique talent profiles in the roster"
    - name: "active_talent_count"
      expr: COUNT(DISTINCT CASE WHEN profile_status = 'active' THEN talent_profile_id END)
      comment: "Number of active talent profiles (available workforce)"
    - name: "cleared_talent_count"
      expr: COUNT(DISTINCT CASE WHEN clearance_status = 'cleared' THEN talent_profile_id END)
      comment: "Number of talent profiles with current clearance (production-ready workforce)"
    - name: "union_affiliated_count"
      expr: COUNT(DISTINCT CASE WHEN union_affiliation IS NOT NULL THEN talent_profile_id END)
      comment: "Number of talent profiles with union affiliation"
    - name: "residual_eligible_talent_count"
      expr: COUNT(DISTINCT CASE WHEN residual_eligibility_flag = TRUE THEN talent_profile_id END)
      comment: "Number of talent profiles eligible for residuals (ongoing cost exposure)"
    - name: "insured_talent_count"
      expr: COUNT(DISTINCT CASE WHEN insurance_coverage_flag = TRUE THEN talent_profile_id END)
      comment: "Number of talent profiles with insurance coverage"
    - name: "exclusive_talent_count"
      expr: COUNT(DISTINCT CASE WHEN exclusivity_clause_flag = TRUE THEN talent_profile_id END)
      comment: "Number of talent profiles with exclusivity clauses"
    - name: "visa_holder_count"
      expr: COUNT(DISTINCT CASE WHEN work_authorization_status = 'visa holder' THEN talent_profile_id END)
      comment: "Number of talent profiles requiring work visa (immigration compliance tracking)"
$$;