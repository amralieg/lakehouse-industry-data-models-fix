-- Metric views for domain: talent | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-23 04:34:26

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over talent contracts — tracks compensation commitments, exclusivity exposure, residual obligations, and contract portfolio health for executive and legal oversight."
  source: "`vibe_media_broadcasting_v1`.`talent`.`contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of talent contract (e.g., series regular, recurring guest, pilot) used to segment compensation and obligation analysis."
    - name: "contract_status"
      expr: contract_status
      comment: "Current lifecycle status of the contract (e.g., active, expired, terminated) for portfolio health monitoring."
    - name: "engagement_role"
      expr: engagement_role
      comment: "Role or function the talent is engaged for under this contract, enabling role-based cost analysis."
    - name: "compensation_currency"
      expr: compensation_currency
      comment: "Currency in which base compensation is denominated, supporting multi-currency financial reporting."
    - name: "governing_cba"
      expr: governing_cba
      comment: "Collective Bargaining Agreement governing this contract, critical for guild compliance and residual obligation tracking."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Indicates whether the contract carries an exclusivity clause, used to assess talent availability risk."
    - name: "residual_eligibility_flag"
      expr: residual_eligibility_flag
      comment: "Indicates whether the talent is eligible for residual payments under this contract, driving future liability estimates."
    - name: "pay_or_play_flag"
      expr: pay_or_play_flag
      comment: "Indicates pay-or-play obligation, representing guaranteed compensation regardless of production proceeding."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the contract became effective, used for cohort and vintage analysis of the contract portfolio."
    - name: "effective_end_year"
      expr: YEAR(effective_end_date)
      comment: "Year the contract expires, used to forecast upcoming contract renewals and renegotiations."
    - name: "compensation_structure"
      expr: compensation_structure
      comment: "Describes the compensation structure type (e.g., flat fee, episodic, weekly guarantee) for cost modeling."
  measures:
    - name: "total_base_compensation"
      expr: SUM(CAST(base_compensation_amount AS DOUBLE))
      comment: "Total committed base compensation across all contracts. A primary cost-of-talent metric used in budget planning and financial forecasting."
    - name: "avg_base_compensation_per_contract"
      expr: AVG(CAST(base_compensation_amount AS DOUBLE))
      comment: "Average base compensation per contract. Benchmarks talent cost levels and informs rate negotiation strategy."
    - name: "total_backend_participation"
      expr: SUM(CAST(backend_participation_percentage AS DOUBLE))
      comment: "Sum of backend participation percentages committed across contracts. Tracks total back-end profit exposure to talent."
    - name: "avg_backend_participation_pct"
      expr: AVG(CAST(backend_participation_percentage AS DOUBLE))
      comment: "Average backend participation percentage per contract. Indicates the typical profit-sharing obligation per deal."
    - name: "total_step_up_amount"
      expr: SUM(CAST(step_up_amount AS DOUBLE))
      comment: "Total contractual step-up amounts committed. Represents future compensation escalation obligations embedded in the contract portfolio."
    - name: "total_credit_size_pct"
      expr: SUM(CAST(credit_size_percentage AS DOUBLE))
      comment: "Aggregate credit size percentage across contracts. Used to assess on-screen credit commitments and compliance with billing obligations."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'active' THEN contract_id END)
      comment: "Number of currently active contracts. Core portfolio health KPI for talent management and legal teams."
    - name: "exclusive_contract_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN contract_id END)
      comment: "Number of contracts with exclusivity clauses. Measures talent lock-in and competitive availability risk."
    - name: "residual_eligible_contract_count"
      expr: COUNT(CASE WHEN residual_eligibility_flag = TRUE THEN contract_id END)
      comment: "Number of contracts carrying residual payment eligibility. Drives future residual liability forecasting."
    - name: "pay_or_play_contract_count"
      expr: COUNT(CASE WHEN pay_or_play_flag = TRUE THEN contract_id END)
      comment: "Number of pay-or-play contracts. Quantifies guaranteed compensation exposure regardless of production outcomes."
    - name: "distinct_talent_count"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique talent profiles under contract. Measures the breadth of the contracted talent roster."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_residual_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial KPIs for talent residual payments — tracks gross and net payment volumes, withholding, pension/health contributions, and agent commission obligations across exhibition windows and payment statuses."
  source: "`vibe_media_broadcasting_v1`.`talent`.`residual_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the residual payment (e.g., pending, paid, disputed) for cash flow and compliance tracking."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to disburse the residual payment (e.g., ACH, check, wire), used for treasury and reconciliation analysis."
    - name: "payment_currency_code"
      expr: payment_currency_code
      comment: "Currency in which the residual payment is made, supporting multi-currency financial reporting."
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year the residual payment was made, used for annual financial reporting and trend analysis."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month the residual payment was made, used for monthly cash flow and accrual reporting."
    - name: "exhibition_start_year"
      expr: YEAR(exhibition_start_date)
      comment: "Year the exhibition window began, used to correlate residual obligations with content exploitation periods."
    - name: "audit_report_flag"
      expr: audit_report_flag
      comment: "Indicates whether an audit report is associated with this payment, used to flag payments under scrutiny."
    - name: "remittance_advice_sent_flag"
      expr: remittance_advice_sent_flag
      comment: "Indicates whether remittance advice has been sent to the talent or their representative, tracking compliance with notification obligations."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source system originating the residual payment record, used for data lineage and reconciliation."
  measures:
    - name: "total_gross_residual_amount"
      expr: SUM(CAST(gross_residual_amount AS DOUBLE))
      comment: "Total gross residual amount owed to talent before deductions. Primary financial liability metric for residual obligations."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net residual payments disbursed after withholding and deductions. Represents actual cash outflow to talent."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total tax withheld from residual payments. Critical for tax compliance reporting and regulatory filings."
    - name: "total_pension_health_amount"
      expr: SUM(CAST(pension_health_amount AS DOUBLE))
      comment: "Total pension and health contributions embedded in residual payments. Tracks guild-mandated benefit obligations."
    - name: "total_agent_commission_amount"
      expr: SUM(CAST(agent_commission_amount AS DOUBLE))
      comment: "Total agent commissions paid out of residual payments. Measures the cost of talent representation on residual income."
    - name: "avg_net_payment_per_residual"
      expr: AVG(CAST(net_payment_amount AS DOUBLE))
      comment: "Average net residual payment per transaction. Benchmarks typical residual payment size for budgeting and forecasting."
    - name: "paid_residual_count"
      expr: COUNT(CASE WHEN payment_status = 'paid' THEN residual_payment_id END)
      comment: "Number of residual payments with paid status. Tracks disbursement completion rate for operational compliance."
    - name: "pending_residual_count"
      expr: COUNT(CASE WHEN payment_status = 'pending' THEN residual_payment_id END)
      comment: "Number of residual payments still pending. Identifies backlog and potential compliance risk with guild payment deadlines."
    - name: "distinct_talent_paid_count"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique talent profiles receiving residual payments. Measures the breadth of residual payment obligations."
    - name: "audit_flagged_payment_count"
      expr: COUNT(CASE WHEN audit_report_flag = TRUE THEN residual_payment_id END)
      comment: "Number of residual payments flagged for audit. Tracks financial control risk and compliance exposure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_compensation_structure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over talent compensation structures — tracks episodic fees, daily rates, weekly guarantees, deferred compensation, step-up obligations, and pension/health rates to support cost modeling and deal benchmarking."
  source: "`vibe_media_broadcasting_v1`.`talent`.`compensation_structure`"
  dimensions:
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation arrangement (e.g., flat fee, episodic, daily rate) used to segment cost analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the compensation structure is denominated, supporting multi-currency financial reporting."
    - name: "exclusivity_clause_flag"
      expr: exclusivity_clause_flag
      comment: "Indicates whether the compensation structure includes an exclusivity clause, used to assess talent availability cost."
    - name: "pay_or_play_flag"
      expr: pay_or_play_flag
      comment: "Indicates pay-or-play obligation within the compensation structure, representing guaranteed cost exposure."
    - name: "residual_eligibility_flag"
      expr: residual_eligibility_flag
      comment: "Indicates whether this compensation structure carries residual eligibility, driving future liability estimates."
    - name: "deferred_payment_trigger"
      expr: deferred_payment_trigger
      comment: "Event or condition that triggers deferred compensation payment, used for cash flow planning."
    - name: "step_up_trigger"
      expr: step_up_trigger
      comment: "Condition that triggers a compensation step-up, used to model future cost escalation scenarios."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the compensation structure became effective, used for vintage and cohort cost analysis."
    - name: "structure_name"
      expr: structure_name
      comment: "Named compensation structure template, used to identify and compare standard deal structures."
  measures:
    - name: "total_base_episode_fee"
      expr: SUM(CAST(base_episode_fee AS DOUBLE))
      comment: "Total base episode fees across all compensation structures. Primary episodic cost commitment metric for production budgeting."
    - name: "avg_base_episode_fee"
      expr: AVG(CAST(base_episode_fee AS DOUBLE))
      comment: "Average base episode fee per compensation structure. Benchmarks episodic talent cost for deal negotiation."
    - name: "total_weekly_guarantee"
      expr: SUM(CAST(weekly_guarantee AS DOUBLE))
      comment: "Total weekly guarantee commitments across all structures. Measures guaranteed weekly cost exposure in the talent portfolio."
    - name: "avg_daily_rate"
      expr: AVG(CAST(daily_rate AS DOUBLE))
      comment: "Average daily rate across compensation structures. Used to benchmark day-player and short-term engagement costs."
    - name: "total_deferred_compensation"
      expr: SUM(CAST(deferred_compensation_amount AS DOUBLE))
      comment: "Total deferred compensation obligations across all structures. Tracks future cash outflow commitments for financial planning."
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus amounts committed across compensation structures. Measures performance-linked cost exposure."
    - name: "total_step_up_amount"
      expr: SUM(CAST(step_up_amount AS DOUBLE))
      comment: "Total step-up amounts embedded in compensation structures. Quantifies future contractual cost escalation obligations."
    - name: "avg_pension_health_rate"
      expr: AVG(CAST(pension_health_rate AS DOUBLE))
      comment: "Average pension and health contribution rate across structures. Tracks guild-mandated benefit cost burden per deal."
    - name: "avg_overtime_multiplier"
      expr: AVG(CAST(overtime_multiplier AS DOUBLE))
      comment: "Average overtime multiplier across compensation structures. Informs production scheduling cost risk for overtime scenarios."
    - name: "avg_backend_gross_participation_pct"
      expr: AVG(CAST(backend_gross_participation_pct AS DOUBLE))
      comment: "Average backend gross participation percentage across structures. Measures typical back-end profit-sharing obligation per deal."
    - name: "pay_or_play_structure_count"
      expr: COUNT(CASE WHEN pay_or_play_flag = TRUE THEN compensation_structure_id END)
      comment: "Number of compensation structures with pay-or-play obligations. Quantifies guaranteed cost exposure in the portfolio."
    - name: "residual_eligible_structure_count"
      expr: COUNT(CASE WHEN residual_eligibility_flag = TRUE THEN compensation_structure_id END)
      comment: "Number of compensation structures carrying residual eligibility. Drives future residual liability forecasting."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_deal_memo`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over talent deal memos — tracks deal velocity, compensation commitments at the memo stage, deal status distribution, and residual exposure before long-form contracts are executed."
  source: "`vibe_media_broadcasting_v1`.`talent`.`deal_memo`"
  dimensions:
    - name: "deal_memo_status"
      expr: deal_memo_status
      comment: "Current status of the deal memo (e.g., draft, countersigned, superseded) for pipeline and conversion tracking."
    - name: "role_function"
      expr: role_function
      comment: "Functional role the talent is engaged for under this deal memo, enabling role-based cost analysis."
    - name: "compensation_currency"
      expr: compensation_currency
      comment: "Currency in which deal memo compensation is denominated, supporting multi-currency financial reporting."
    - name: "residual_eligibility_flag"
      expr: residual_eligibility_flag
      comment: "Indicates whether the deal memo carries residual eligibility, used to estimate future residual obligations at the deal stage."
    - name: "credit_position"
      expr: credit_position
      comment: "On-screen credit position committed in the deal memo, used to track billing and credit obligations."
    - name: "deal_year"
      expr: YEAR(deal_date)
      comment: "Year the deal memo was executed, used for annual deal volume and cost trend analysis."
    - name: "deal_month"
      expr: DATE_TRUNC('MONTH', deal_date)
      comment: "Month the deal memo was executed, used for monthly deal pipeline and compensation commitment reporting."
    - name: "engagement_start_year"
      expr: YEAR(engagement_start_date)
      comment: "Year the talent engagement is scheduled to begin, used for production workforce planning."
  measures:
    - name: "total_deal_compensation_amount"
      expr: SUM(CAST(compensation_amount AS DOUBLE))
      comment: "Total compensation committed across all deal memos. Tracks early-stage talent cost commitments before long-form contracts are finalized."
    - name: "avg_deal_compensation_amount"
      expr: AVG(CAST(compensation_amount AS DOUBLE))
      comment: "Average compensation per deal memo. Benchmarks deal-stage talent rates for negotiation and budget planning."
    - name: "countersigned_deal_count"
      expr: COUNT(CASE WHEN deal_memo_status = 'countersigned' THEN deal_memo_id END)
      comment: "Number of countersigned deal memos. Measures deal closure rate and committed talent pipeline."
    - name: "active_deal_memo_count"
      expr: COUNT(CASE WHEN deal_memo_status NOT IN ('superseded', 'cancelled', 'expired') THEN deal_memo_id END)
      comment: "Number of active (non-superseded, non-cancelled) deal memos. Tracks the live deal pipeline for production planning."
    - name: "residual_eligible_deal_count"
      expr: COUNT(CASE WHEN residual_eligibility_flag = TRUE THEN deal_memo_id END)
      comment: "Number of deal memos with residual eligibility. Provides early-stage visibility into future residual payment obligations."
    - name: "distinct_talent_in_deals"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique talent profiles with active deal memos. Measures the breadth of the deal-stage talent pipeline."
    - name: "total_compensation_on_residual_eligible_deals"
      expr: SUM(CASE WHEN residual_eligibility_flag = TRUE THEN CAST(compensation_amount AS DOUBLE) ELSE 0 END)
      comment: "Total compensation on residual-eligible deal memos. Quantifies the compensation base that will generate future residual obligations."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_representation_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over talent representation agreements — tracks commission rates, exclusivity, residual routing, and agency relationship health to support talent management and cost-of-representation analysis."
  source: "`vibe_media_broadcasting_v1`.`talent`.`representation_agreement`"
  dimensions:
    - name: "representation_agreement_status"
      expr: representation_agreement_status
      comment: "Current status of the representation agreement (e.g., active, terminated, expired) for portfolio health monitoring."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Indicates whether the representation agreement is exclusive, used to assess agency lock-in and talent availability."
    - name: "guild_franchise_flag"
      expr: guild_franchise_flag
      comment: "Indicates whether the representing agency holds a guild franchise, critical for guild compliance and residual routing."
    - name: "residual_routing_flag"
      expr: residual_routing_flag
      comment: "Indicates whether residual payments are routed through the agency, used for payment workflow and compliance tracking."
    - name: "renewal_option_flag"
      expr: renewal_option_flag
      comment: "Indicates whether the agreement includes a renewal option, used for contract lifecycle and retention planning."
    - name: "territory_scope"
      expr: territory_scope
      comment: "Geographic territory covered by the representation agreement, used for international talent management analysis."
    - name: "scope_of_services"
      expr: scope_of_services
      comment: "Services covered by the representation agreement (e.g., theatrical, commercial, literary), used for agency specialization analysis."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the representation agreement became effective, used for cohort and vintage analysis."
  measures:
    - name: "avg_commission_percentage"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average agency commission rate across representation agreements. Benchmarks cost-of-representation and informs agency negotiation strategy."
    - name: "total_commission_cap_amount"
      expr: SUM(CAST(commission_cap_amount AS DOUBLE))
      comment: "Total commission cap amounts across all agreements. Measures the maximum agency commission exposure in the talent portfolio."
    - name: "avg_commission_cap_amount"
      expr: AVG(CAST(commission_cap_amount AS DOUBLE))
      comment: "Average commission cap per agreement. Benchmarks typical agency commission ceiling for deal structuring."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN representation_agreement_status = 'active' THEN representation_agreement_id END)
      comment: "Number of currently active representation agreements. Core portfolio health KPI for talent management."
    - name: "exclusive_agreement_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN representation_agreement_id END)
      comment: "Number of exclusive representation agreements. Measures agency lock-in and talent availability constraints."
    - name: "guild_franchised_agreement_count"
      expr: COUNT(CASE WHEN guild_franchise_flag = TRUE THEN representation_agreement_id END)
      comment: "Number of agreements with guild-franchised agencies. Tracks compliance with guild requirements for talent representation."
    - name: "residual_routing_agreement_count"
      expr: COUNT(CASE WHEN residual_routing_flag = TRUE THEN representation_agreement_id END)
      comment: "Number of agreements where residuals are routed through the agency. Ensures correct residual payment workflow coverage."
    - name: "distinct_talent_represented"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique talent profiles under representation agreements. Measures the breadth of the represented talent roster."
    - name: "distinct_agencies_count"
      expr: COUNT(DISTINCT talent_agency_id)
      comment: "Number of distinct talent agencies in the representation portfolio. Tracks agency diversification and concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_guild_affiliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over talent guild affiliations — tracks membership status, dues compliance, pension and health eligibility, and CBA coverage to support guild compliance and residual obligation management."
  source: "`vibe_media_broadcasting_v1`.`talent`.`guild_affiliation`"
  dimensions:
    - name: "guild_code"
      expr: guild_code
      comment: "Code identifying the guild (e.g., SAG-AFTRA, WGA, DGA) used to segment compliance and obligation analysis by union."
    - name: "guild_name"
      expr: guild_name
      comment: "Full name of the guild, used for reporting and compliance dashboards."
    - name: "membership_status"
      expr: membership_status
      comment: "Current membership status (e.g., active, suspended, resigned) used to track guild compliance and eligibility."
    - name: "dues_payment_status"
      expr: dues_payment_status
      comment: "Current dues payment status, used to identify talent at risk of membership suspension due to non-payment."
    - name: "health_benefits_eligible_flag"
      expr: health_benefits_eligible_flag
      comment: "Indicates whether the talent is eligible for guild health benefits, used for benefits cost and compliance tracking."
    - name: "pension_eligible_flag"
      expr: pension_eligible_flag
      comment: "Indicates whether the talent is eligible for guild pension benefits, used for pension obligation forecasting."
    - name: "residual_eligibility_flag"
      expr: residual_eligibility_flag
      comment: "Indicates whether the guild affiliation confers residual eligibility, driving residual payment obligation estimates."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction under which the guild affiliation is registered, used for geographic compliance analysis."
    - name: "cba_version"
      expr: cba_version
      comment: "Version of the Collective Bargaining Agreement applicable to this affiliation, used for CBA compliance tracking."
    - name: "join_year"
      expr: YEAR(join_date)
      comment: "Year the talent joined the guild, used for membership tenure and cohort analysis."
  measures:
    - name: "active_guild_member_count"
      expr: COUNT(CASE WHEN membership_status = 'active' THEN guild_affiliation_id END)
      comment: "Number of talent with active guild memberships. Core compliance KPI ensuring production can legally engage guild talent."
    - name: "dues_delinquent_count"
      expr: COUNT(CASE WHEN dues_payment_status = 'delinquent' THEN guild_affiliation_id END)
      comment: "Number of talent with delinquent dues payments. Identifies compliance risk — delinquent members may be ineligible for guild productions."
    - name: "pension_eligible_count"
      expr: COUNT(CASE WHEN pension_eligible_flag = TRUE THEN guild_affiliation_id END)
      comment: "Number of talent eligible for guild pension benefits. Drives pension contribution obligation forecasting."
    - name: "health_benefits_eligible_count"
      expr: COUNT(CASE WHEN health_benefits_eligible_flag = TRUE THEN guild_affiliation_id END)
      comment: "Number of talent eligible for guild health benefits. Tracks health benefit cost obligations and compliance."
    - name: "residual_eligible_member_count"
      expr: COUNT(CASE WHEN residual_eligibility_flag = TRUE THEN guild_affiliation_id END)
      comment: "Number of guild affiliations conferring residual eligibility. Provides the denominator for residual obligation scope analysis."
    - name: "distinct_guilds_represented"
      expr: COUNT(DISTINCT guild_code)
      comment: "Number of distinct guilds represented in the talent roster. Measures the breadth of guild compliance obligations."
    - name: "distinct_guild_affiliated_talent"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique talent profiles with guild affiliations. Measures the scope of the guild-affiliated talent pool."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`talent_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over the talent profile master — tracks roster composition, compliance status (work authorization, clearance, insurance), exclusivity exposure, and privacy consent coverage across the talent pool."
  source: "`vibe_media_broadcasting_v1`.`talent`.`profile`"
  dimensions:
    - name: "talent_type"
      expr: talent_type
      comment: "Type of talent (e.g., actor, director, writer, crew) used to segment roster and cost analysis."
    - name: "talent_tier"
      expr: talent_tier
      comment: "Tier classification of the talent (e.g., A-list, mid-tier, emerging) used for strategic talent investment analysis."
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the talent profile (e.g., active, inactive, blacklisted) for roster management."
    - name: "work_authorization_status"
      expr: work_authorization_status
      comment: "Work authorization status of the talent, critical for legal compliance before engagement."
    - name: "clearance_status"
      expr: clearance_status
      comment: "Security or background clearance status, used for productions requiring cleared talent."
    - name: "nationality"
      expr: nationality
      comment: "Nationality of the talent, used for international co-production compliance and visa planning."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of the talent, used for casting and localization planning."
    - name: "exclusivity_clause_flag"
      expr: exclusivity_clause_flag
      comment: "Indicates whether the talent profile carries an exclusivity clause, used to assess availability constraints."
    - name: "residual_eligibility_flag"
      expr: residual_eligibility_flag
      comment: "Indicates whether the talent is eligible for residuals, used to scope future residual payment obligations."
    - name: "insurance_coverage_flag"
      expr: insurance_coverage_flag
      comment: "Indicates whether the talent has active insurance coverage, used for production risk management."
    - name: "gdpr_consent_status"
      expr: gdpr_consent_status
      comment: "GDPR consent status for the talent profile, used for privacy compliance monitoring."
    - name: "gender_identity"
      expr: gender_identity
      comment: "Gender identity of the talent, used for diversity, equity, and inclusion reporting."
    - name: "union_affiliation"
      expr: union_affiliation
      comment: "Union affiliation of the talent, used for guild compliance and CBA obligation analysis."
  measures:
    - name: "active_talent_count"
      expr: COUNT(CASE WHEN profile_status = 'active' THEN profile_id END)
      comment: "Number of active talent profiles. Core roster size KPI for talent management and production planning."
    - name: "work_authorized_talent_count"
      expr: COUNT(CASE WHEN work_authorization_status = 'authorized' THEN profile_id END)
      comment: "Number of talent with valid work authorization. Critical compliance KPI — only authorized talent can be legally engaged."
    - name: "work_authorization_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN work_authorization_status = 'authorized' THEN profile_id END) / NULLIF(COUNT(profile_id), 0), 2)
      comment: "Percentage of talent profiles with valid work authorization. Tracks legal compliance risk across the talent roster."
    - name: "insured_talent_count"
      expr: COUNT(CASE WHEN insurance_coverage_flag = TRUE THEN profile_id END)
      comment: "Number of talent with active insurance coverage. Tracks production risk management compliance."
    - name: "exclusive_talent_count"
      expr: COUNT(CASE WHEN exclusivity_clause_flag = TRUE THEN profile_id END)
      comment: "Number of talent profiles with exclusivity clauses. Measures talent availability constraints across the roster."
    - name: "residual_eligible_talent_count"
      expr: COUNT(CASE WHEN residual_eligibility_flag = TRUE THEN profile_id END)
      comment: "Number of talent eligible for residual payments. Provides the population base for residual obligation forecasting."
    - name: "ccpa_opt_out_count"
      expr: COUNT(CASE WHEN ccpa_opt_out_flag = TRUE THEN profile_id END)
      comment: "Number of talent who have opted out under CCPA. Tracks privacy compliance obligations and data handling restrictions."
    - name: "biometric_consent_count"
      expr: COUNT(CASE WHEN biometric_consent_flag = TRUE THEN profile_id END)
      comment: "Number of talent who have provided biometric consent. Tracks compliance with biometric data regulations (e.g., BIPA)."
    - name: "distinct_agencies_on_roster"
      expr: COUNT(DISTINCT talent_agency_id)
      comment: "Number of distinct talent agencies representing the active roster. Measures agency diversification and concentration risk."
$$;