-- Metric views for domain: enrollment | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 21:18:32

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`enrollment_eligibility_span`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core enrollment eligibility metrics tracking member coverage spans, benefit utilization, and financial exposure across health plans and employer groups"
  source: "`health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span`"
  dimensions:
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Current eligibility status of the member (active, terminated, pending, etc.)"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage (medical, dental, vision, etc.)"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (commercial, Medicare, Medicaid, exchange)"
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source system or channel through which enrollment was initiated"
    - name: "coverage_category"
      expr: coverage_category
      comment: "Category of coverage (individual, family, employee+spouse, etc.)"
    - name: "is_primary_coverage"
      expr: is_primary_coverage
      comment: "Flag indicating whether this is the member's primary coverage"
    - name: "is_waiver_applied"
      expr: is_waiver_applied
      comment: "Flag indicating whether a coverage waiver was applied"
    - name: "enrollment_event_type"
      expr: enrollment_event_type
      comment: "Type of enrollment event (new enrollment, renewal, change, termination)"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year when the eligibility span became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month when the eligibility span became effective"
    - name: "benefit_period_year"
      expr: YEAR(benefit_period_start)
      comment: "Year of the benefit period start"
  measures:
    - name: "total_eligibility_spans"
      expr: COUNT(1)
      comment: "Total number of eligibility spans (baseline volume metric)"
    - name: "unique_members"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Distinct count of members with eligibility spans"
    - name: "unique_health_plans"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Distinct count of health plans represented in eligibility spans"
    - name: "unique_employer_groups"
      expr: COUNT(DISTINCT group_id)
      comment: "Distinct count of employer groups with active eligibility"
    - name: "total_deductible_amount"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductible amounts across all eligibility spans (financial exposure)"
    - name: "total_oop_maximum"
      expr: SUM(CAST(oop_maximum AS DOUBLE))
      comment: "Total out-of-pocket maximum amounts (member financial risk ceiling)"
    - name: "total_moop_threshold"
      expr: SUM(CAST(moop_threshold AS DOUBLE))
      comment: "Total maximum out-of-pocket thresholds (regulatory compliance metric)"
    - name: "avg_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average deductible amount per eligibility span (benefit design indicator)"
    - name: "avg_oop_maximum"
      expr: AVG(CAST(oop_maximum AS DOUBLE))
      comment: "Average out-of-pocket maximum per span (member cost exposure)"
    - name: "primary_coverage_count"
      expr: SUM(CASE WHEN is_primary_coverage = TRUE THEN 1 ELSE 0 END)
      comment: "Count of eligibility spans marked as primary coverage (coordination of benefits metric)"
    - name: "waiver_applied_count"
      expr: SUM(CASE WHEN is_waiver_applied = TRUE THEN 1 ELSE 0 END)
      comment: "Count of eligibility spans with coverage waivers (opt-out tracking)"
    - name: "retroactive_adjustment_count"
      expr: SUM(CASE WHEN retroactive_adjustment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of eligibility spans with retroactive adjustments (claims reprocessing driver)"
    - name: "prior_coverage_count"
      expr: SUM(CASE WHEN prior_coverage_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of members with prior coverage indicator (continuity of coverage metric)"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`enrollment_plan_election`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan election and premium contribution metrics tracking member plan selections, employer/employee cost sharing, and enrollment decisions across benefit periods"
  source: "`health_insurance_ecm`.`enrollment`.`plan_election`"
  dimensions:
    - name: "plan_election_status"
      expr: plan_election_status
      comment: "Current status of the plan election (active, pending, terminated, cancelled)"
    - name: "election_type"
      expr: election_type
      comment: "Type of election (new, change, renewal, COBRA, etc.)"
    - name: "enrollment_event_type"
      expr: enrollment_event_type
      comment: "Type of enrollment event triggering the election"
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source or channel of the enrollment (online, broker, call center, etc.)"
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier elected (employee only, employee+spouse, family, etc.)"
    - name: "premium_frequency"
      expr: premium_frequency
      comment: "Frequency of premium payments (monthly, biweekly, etc.)"
    - name: "is_cobra_eligible"
      expr: is_cobra_eligible
      comment: "Flag indicating COBRA eligibility status"
    - name: "hsa_election_flag"
      expr: hsa_election_flag
      comment: "Flag indicating HSA election"
    - name: "hra_election_flag"
      expr: hra_election_flag
      comment: "Flag indicating HRA election"
    - name: "fsa_election_flag"
      expr: fsa_election_flag
      comment: "Flag indicating FSA election"
    - name: "dental_rider_flag"
      expr: dental_rider_flag
      comment: "Flag indicating dental rider election"
    - name: "vision_rider_flag"
      expr: vision_rider_flag
      comment: "Flag indicating vision rider election"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year when the plan election became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month when the plan election became effective"
  measures:
    - name: "total_plan_elections"
      expr: COUNT(1)
      comment: "Total number of plan elections (baseline enrollment volume)"
    - name: "unique_members_elected"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Distinct count of members who made plan elections"
    - name: "unique_health_plans_elected"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Distinct count of health plans elected by members"
    - name: "unique_employer_groups"
      expr: COUNT(DISTINCT group_id)
      comment: "Distinct count of employer groups with plan elections"
    - name: "total_premium_revenue"
      expr: SUM(CAST(total_premium AS DOUBLE))
      comment: "Total premium revenue across all plan elections (top-line revenue metric)"
    - name: "total_employer_contribution"
      expr: SUM(CAST(premium_contribution_employer AS DOUBLE))
      comment: "Total employer premium contributions (employer cost metric)"
    - name: "total_employee_contribution"
      expr: SUM(CAST(premium_contribution_employee AS DOUBLE))
      comment: "Total employee premium contributions (member cost burden)"
    - name: "avg_total_premium"
      expr: AVG(CAST(total_premium AS DOUBLE))
      comment: "Average total premium per plan election (pricing indicator)"
    - name: "avg_employer_contribution"
      expr: AVG(CAST(premium_contribution_employer AS DOUBLE))
      comment: "Average employer contribution per election (employer generosity metric)"
    - name: "avg_employee_contribution"
      expr: AVG(CAST(premium_contribution_employee AS DOUBLE))
      comment: "Average employee contribution per election (affordability indicator)"
    - name: "cobra_eligible_count"
      expr: SUM(CASE WHEN is_cobra_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of COBRA-eligible plan elections (continuation coverage tracking)"
    - name: "hsa_election_count"
      expr: SUM(CASE WHEN hsa_election_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of HSA elections (consumer-directed healthcare adoption)"
    - name: "hra_election_count"
      expr: SUM(CASE WHEN hra_election_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of HRA elections (employer-funded account adoption)"
    - name: "fsa_election_count"
      expr: SUM(CASE WHEN fsa_election_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of FSA elections (flexible spending account adoption)"
    - name: "dental_rider_count"
      expr: SUM(CASE WHEN dental_rider_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of dental rider elections (supplemental coverage adoption)"
    - name: "vision_rider_count"
      expr: SUM(CASE WHEN vision_rider_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of vision rider elections (supplemental coverage adoption)"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`enrollment_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enrollment transaction metrics tracking enrollment events, financial impacts, retroactive adjustments, and processing status across the enrollment lifecycle"
  source: "`health_insurance_ecm`.`enrollment`.`transaction`"
  dimensions:
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current processing status of the enrollment transaction"
    - name: "processing_status"
      expr: processing_status
      comment: "Detailed processing status (pending, completed, failed, etc.)"
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment (new, change, termination, reinstatement)"
    - name: "transaction_source"
      expr: transaction_source
      comment: "Source system or channel of the transaction"
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for enrollment termination (if applicable)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the transaction (compliant, non-compliant, pending review)"
    - name: "health_plan_type"
      expr: health_plan_type
      comment: "Type of health plan involved in the transaction"
    - name: "coverage_period_type"
      expr: coverage_period_type
      comment: "Type of coverage period (annual, monthly, etc.)"
    - name: "retroactive_adjustment_flag"
      expr: retroactive_adjustment_flag
      comment: "Flag indicating whether transaction is a retroactive adjustment"
    - name: "financial_impact_flag"
      expr: financial_impact_flag
      comment: "Flag indicating whether transaction has financial impact"
    - name: "claims_reprocess_flag"
      expr: claims_reprocess_flag
      comment: "Flag indicating whether claims reprocessing is required"
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Flag indicating whether transaction requires regulatory reporting"
    - name: "is_grace_period"
      expr: is_grace_period
      comment: "Flag indicating whether transaction is within grace period"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year when the transaction became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month when the transaction became effective"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month when the transaction event occurred"
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total number of enrollment transactions (baseline activity volume)"
    - name: "unique_members_transacted"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Distinct count of members with enrollment transactions"
    - name: "unique_employer_groups"
      expr: COUNT(DISTINCT member_group_id)
      comment: "Distinct count of employer groups with transactions"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross transaction amounts (pre-adjustment revenue impact)"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net transaction amounts (post-adjustment revenue impact)"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amounts applied to transactions (financial correction magnitude)"
    - name: "avg_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross transaction amount (typical transaction size)"
    - name: "avg_net_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net transaction amount (typical post-adjustment value)"
    - name: "retroactive_adjustment_count"
      expr: SUM(CASE WHEN retroactive_adjustment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of retroactive adjustments (data quality and process efficiency indicator)"
    - name: "financial_impact_count"
      expr: SUM(CASE WHEN financial_impact_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of transactions with financial impact (revenue-affecting events)"
    - name: "claims_reprocess_count"
      expr: SUM(CASE WHEN claims_reprocess_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of transactions requiring claims reprocessing (operational burden metric)"
    - name: "regulatory_reporting_count"
      expr: SUM(CASE WHEN regulatory_reporting_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of transactions requiring regulatory reporting (compliance workload)"
    - name: "grace_period_count"
      expr: SUM(CASE WHEN is_grace_period = TRUE THEN 1 ELSE 0 END)
      comment: "Count of transactions within grace period (payment risk indicator)"
    - name: "prior_authorization_required_count"
      expr: SUM(CASE WHEN prior_authorization_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of transactions requiring prior authorization (utilization management metric)"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`enrollment_medicare_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medicare entitlement and dual-eligibility metrics tracking Part A/B/D coverage, LIS/IRMAA status, and CMS compliance for Medicare Advantage and Part D plans"
  source: "`health_insurance_ecm`.`enrollment`.`medicare_entitlement`"
  dimensions:
    - name: "entitlement_status"
      expr: entitlement_status
      comment: "Current Medicare entitlement status (active, terminated, pending)"
    - name: "entitlement_type"
      expr: entitlement_type
      comment: "Type of Medicare entitlement (Part A, Part B, Part D, MA)"
    - name: "is_dual_eligible"
      expr: is_dual_eligible
      comment: "Flag indicating dual Medicare-Medicaid eligibility"
    - name: "lis_status"
      expr: lis_status
      comment: "Low Income Subsidy (LIS) status"
    - name: "extra_help_status"
      expr: extra_help_status
      comment: "Extra Help (Part D subsidy) status"
    - name: "irmaa_status"
      expr: irmaa_status
      comment: "Income-Related Monthly Adjustment Amount (IRMAA) status"
    - name: "irmaa_income_bracket"
      expr: irmaa_income_bracket
      comment: "IRMAA income bracket for premium adjustment"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of Medicare entitlement"
    - name: "cms_contract_number"
      expr: cms_contract_number
      comment: "CMS contract number for the Medicare plan"
    - name: "pbp_assignment"
      expr: pbp_assignment
      comment: "Plan Benefit Package (PBP) assignment"
    - name: "is_retired"
      expr: is_retired
      comment: "Flag indicating retirement status"
    - name: "entitlement_year"
      expr: YEAR(eligibility_span_start)
      comment: "Year when Medicare entitlement began"
    - name: "entitlement_month"
      expr: DATE_TRUNC('MONTH', eligibility_span_start)
      comment: "Month when Medicare entitlement began"
  measures:
    - name: "total_medicare_entitlements"
      expr: COUNT(1)
      comment: "Total number of Medicare entitlement records (baseline Medicare population)"
    - name: "unique_medicare_members"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Distinct count of members with Medicare entitlement"
    - name: "unique_health_plans"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Distinct count of Medicare health plans"
    - name: "dual_eligible_count"
      expr: SUM(CASE WHEN is_dual_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of dual-eligible Medicare-Medicaid members (high-cost population)"
    - name: "lis_eligible_count"
      expr: SUM(CASE WHEN lis_status IS NOT NULL AND lis_status != 'Not Eligible' THEN 1 ELSE 0 END)
      comment: "Count of members eligible for Low Income Subsidy (affordability metric)"
    - name: "extra_help_count"
      expr: SUM(CASE WHEN extra_help_status IS NOT NULL AND extra_help_status != 'Not Eligible' THEN 1 ELSE 0 END)
      comment: "Count of members receiving Extra Help subsidy (Part D affordability)"
    - name: "irmaa_affected_count"
      expr: SUM(CASE WHEN irmaa_status IS NOT NULL AND irmaa_status != 'Not Applicable' THEN 1 ELSE 0 END)
      comment: "Count of members subject to IRMAA premium adjustment (high-income population)"
    - name: "retired_member_count"
      expr: SUM(CASE WHEN is_retired = TRUE THEN 1 ELSE 0 END)
      comment: "Count of retired Medicare members (retiree benefit tracking)"
    - name: "part_a_active_count"
      expr: SUM(CASE WHEN part_a_entitlement_date IS NOT NULL AND (part_a_termination_date IS NULL OR part_a_termination_date > CURRENT_DATE) THEN 1 ELSE 0 END)
      comment: "Count of members with active Part A coverage (hospital insurance)"
    - name: "part_b_active_count"
      expr: SUM(CASE WHEN part_b_entitlement_date IS NOT NULL AND (part_b_termination_date IS NULL OR part_b_termination_date > CURRENT_DATE) THEN 1 ELSE 0 END)
      comment: "Count of members with active Part B coverage (medical insurance)"
    - name: "part_d_enrolled_count"
      expr: SUM(CASE WHEN part_d_enrollment_effective_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of members enrolled in Part D (prescription drug coverage)"
    - name: "ma_enrolled_count"
      expr: SUM(CASE WHEN ma_enrollment_effective_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of members enrolled in Medicare Advantage (MA plan penetration)"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`enrollment_medicaid_eligibility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medicaid eligibility and enrollment metrics tracking income-based eligibility, dual-eligible status, program types, and redetermination cycles for managed Medicaid populations"
  source: "`health_insurance_ecm`.`enrollment`.`medicaid_eligibility`"
  dimensions:
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Current Medicaid eligibility status (active, pending, terminated)"
    - name: "eligibility_category"
      expr: eligibility_category
      comment: "Medicaid eligibility category (TANF, SSI, expansion, etc.)"
    - name: "medicaid_program_type"
      expr: medicaid_program_type
      comment: "Type of Medicaid program (managed care, fee-for-service, etc.)"
    - name: "dual_eligible_flag"
      expr: dual_eligible_flag
      comment: "Flag indicating dual Medicare-Medicaid eligibility"
    - name: "federal_program_indicator"
      expr: federal_program_indicator
      comment: "Flag indicating federal program participation"
    - name: "special_program_indicator"
      expr: special_program_indicator
      comment: "Indicator for special Medicaid programs (CHIP, waiver programs, etc.)"
    - name: "medical_need_flag"
      expr: medical_need_flag
      comment: "Flag indicating medical need-based eligibility"
    - name: "income_verification_status"
      expr: income_verification_status
      comment: "Status of income verification for eligibility determination"
    - name: "eligibility_verification_method"
      expr: eligibility_verification_method
      comment: "Method used to verify Medicaid eligibility"
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source of Medicaid enrollment (state exchange, direct, etc.)"
    - name: "state_agency"
      expr: state_agency
      comment: "State agency administering Medicaid eligibility"
    - name: "coverage_year"
      expr: YEAR(coverage_start_date)
      comment: "Year when Medicaid coverage started"
    - name: "coverage_month"
      expr: DATE_TRUNC('MONTH', coverage_start_date)
      comment: "Month when Medicaid coverage started"
  measures:
    - name: "total_medicaid_eligibility_records"
      expr: COUNT(1)
      comment: "Total number of Medicaid eligibility records (baseline Medicaid population)"
    - name: "unique_medicaid_members"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Distinct count of members with Medicaid eligibility"
    - name: "unique_health_plans"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Distinct count of Medicaid managed care plans"
    - name: "dual_eligible_count"
      expr: SUM(CASE WHEN dual_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of dual-eligible Medicare-Medicaid members (complex care population)"
    - name: "medical_need_count"
      expr: SUM(CASE WHEN medical_need_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of members with medical need-based eligibility (high-acuity population)"
    - name: "federal_program_count"
      expr: SUM(CASE WHEN federal_program_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of members in federal Medicaid programs (program mix metric)"
    - name: "total_income_amount"
      expr: SUM(CAST(income_amount AS DOUBLE))
      comment: "Total income amounts reported for eligibility determination (socioeconomic indicator)"
    - name: "avg_income_amount"
      expr: AVG(CAST(income_amount AS DOUBLE))
      comment: "Average income amount per member (affordability and need indicator)"
    - name: "total_assets_amount"
      expr: SUM(CAST(assets_amount AS DOUBLE))
      comment: "Total assets amounts reported for eligibility (resource test metric)"
    - name: "avg_assets_amount"
      expr: AVG(CAST(assets_amount AS DOUBLE))
      comment: "Average assets amount per member (financial need indicator)"
    - name: "avg_fpl_percentage"
      expr: AVG(CAST(fpl_percentage AS DOUBLE))
      comment: "Average Federal Poverty Level percentage (eligibility threshold metric)"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`enrollment_exchange_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health insurance exchange enrollment metrics tracking marketplace enrollments, premium tax credits (APTC), cost-sharing reductions (CSR), effectuation, and 1095-A reporting for ACA-compliant plans"
  source: "`health_insurance_ecm`.`enrollment`.`exchange_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of exchange enrollment (active, pending, terminated)"
    - name: "effectuation_status"
      expr: effectuation_status
      comment: "Effectuation status (effectuated, pending payment, not effectuated)"
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of exchange enrollment (new, renewal, SEP, open enrollment)"
    - name: "marketplace_source"
      expr: marketplace_source
      comment: "Source marketplace (federal exchange, state-based marketplace)"
    - name: "marketplace_state"
      expr: marketplace_state
      comment: "State where the exchange enrollment occurred"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage (individual, family, etc.)"
    - name: "csr_variant"
      expr: csr_variant
      comment: "Cost-sharing reduction variant (silver plan actuarial value adjustment)"
    - name: "subsidy_type"
      expr: subsidy_type
      comment: "Type of subsidy (APTC, CSR, none)"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status (paid, pending, delinquent)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of premium payment"
    - name: "enrollment_renewal_indicator"
      expr: enrollment_renewal_indicator
      comment: "Flag indicating whether enrollment is a renewal"
    - name: "reporting_1095a_flag"
      expr: reporting_1095a_flag
      comment: "Flag indicating 1095-A tax form reporting requirement"
    - name: "tax_credit_reconciliation_status"
      expr: tax_credit_reconciliation_status
      comment: "Status of premium tax credit reconciliation"
    - name: "enrollment_termination_type"
      expr: enrollment_termination_type
      comment: "Type of enrollment termination (voluntary, involuntary, etc.)"
    - name: "enrollment_termination_initiator"
      expr: enrollment_termination_initiator
      comment: "Party who initiated termination (member, plan, exchange)"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year when exchange enrollment became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month when exchange enrollment became effective"
  measures:
    - name: "total_exchange_enrollments"
      expr: COUNT(1)
      comment: "Total number of exchange enrollments (baseline marketplace volume)"
    - name: "unique_exchange_members"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Distinct count of members enrolled through exchanges"
    - name: "unique_health_plans"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Distinct count of health plans offered on exchanges"
    - name: "total_premium_revenue"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium revenue from exchange enrollments (top-line exchange revenue)"
    - name: "total_aptc_subsidy"
      expr: SUM(CAST(aptc_amount AS DOUBLE))
      comment: "Total Advance Premium Tax Credit (APTC) subsidy amounts (federal subsidy exposure)"
    - name: "total_subsidy_amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy amounts (all subsidy types combined)"
    - name: "avg_premium_amount"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium per exchange enrollment (pricing indicator)"
    - name: "avg_aptc_subsidy"
      expr: AVG(CAST(aptc_amount AS DOUBLE))
      comment: "Average APTC subsidy per enrollment (affordability support level)"
    - name: "avg_subsidy_amount"
      expr: AVG(CAST(subsidy_amount AS DOUBLE))
      comment: "Average subsidy amount per enrollment (member financial assistance)"
    - name: "effectuated_enrollment_count"
      expr: SUM(CASE WHEN effectuation_status = 'Effectuated' THEN 1 ELSE 0 END)
      comment: "Count of effectuated enrollments (paid and active coverage)"
    - name: "renewal_enrollment_count"
      expr: SUM(CASE WHEN enrollment_renewal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of renewal enrollments (retention metric)"
    - name: "form_1095a_required_count"
      expr: SUM(CASE WHEN reporting_1095a_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of enrollments requiring 1095-A tax form (compliance workload)"
    - name: "csr_eligible_count"
      expr: SUM(CASE WHEN csr_variant IS NOT NULL AND csr_variant != 'None' THEN 1 ELSE 0 END)
      comment: "Count of enrollments eligible for cost-sharing reductions (affordability program reach)"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`enrollment_cobra_election`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "COBRA continuation coverage metrics tracking elections, premium payments, subsidy eligibility, and early terminations for post-employment health coverage"
  source: "`health_insurance_ecm`.`enrollment`.`cobra_election`"
  dimensions:
    - name: "election_status"
      expr: election_status
      comment: "Current status of COBRA election (active, pending, terminated, declined)"
    - name: "election_decision"
      expr: election_decision
      comment: "Member decision on COBRA election (elected, declined, pending)"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of COBRA coverage"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of COBRA coverage (medical, dental, vision)"
    - name: "qualifying_event_type"
      expr: qualifying_event_type
      comment: "Type of qualifying event triggering COBRA eligibility"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of COBRA premiums (current, delinquent, grace period)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of COBRA premium payment"
    - name: "premium_frequency"
      expr: premium_frequency
      comment: "Frequency of COBRA premium payments"
    - name: "subsidy_eligibility_flag"
      expr: subsidy_eligibility_flag
      comment: "Flag indicating eligibility for COBRA premium subsidy"
    - name: "subsidy_type"
      expr: subsidy_type
      comment: "Type of COBRA subsidy (federal, state, employer)"
    - name: "early_termination_flag"
      expr: early_termination_flag
      comment: "Flag indicating early termination of COBRA coverage"
    - name: "election_notice_sent_flag"
      expr: election_notice_sent_flag
      comment: "Flag indicating whether election notice was sent"
    - name: "early_termination_notice_sent_flag"
      expr: early_termination_notice_sent_flag
      comment: "Flag indicating whether early termination notice was sent"
    - name: "coverage_year"
      expr: YEAR(coverage_start_date)
      comment: "Year when COBRA coverage started"
    - name: "coverage_month"
      expr: DATE_TRUNC('MONTH', coverage_start_date)
      comment: "Month when COBRA coverage started"
    - name: "qualifying_event_year"
      expr: YEAR(qualifying_event_date)
      comment: "Year when qualifying event occurred"
  measures:
    - name: "total_cobra_elections"
      expr: COUNT(1)
      comment: "Total number of COBRA elections (baseline continuation coverage volume)"
    - name: "unique_cobra_members"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Distinct count of members with COBRA elections"
    - name: "unique_employer_groups"
      expr: COUNT(DISTINCT group_id)
      comment: "Distinct count of employer groups with COBRA elections"
    - name: "total_cobra_premium_revenue"
      expr: SUM(CAST(cobra_premium_amount AS DOUBLE))
      comment: "Total COBRA premium revenue (continuation coverage revenue)"
    - name: "total_subsidy_amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total COBRA subsidy amounts (federal/state subsidy exposure)"
    - name: "avg_cobra_premium"
      expr: AVG(CAST(cobra_premium_amount AS DOUBLE))
      comment: "Average COBRA premium per election (pricing indicator)"
    - name: "avg_subsidy_amount"
      expr: AVG(CAST(subsidy_amount AS DOUBLE))
      comment: "Average subsidy amount per election (affordability support level)"
    - name: "elected_count"
      expr: SUM(CASE WHEN election_decision = 'Elected' THEN 1 ELSE 0 END)
      comment: "Count of COBRA elections accepted by members (take-up rate numerator)"
    - name: "declined_count"
      expr: SUM(CASE WHEN election_decision = 'Declined' THEN 1 ELSE 0 END)
      comment: "Count of COBRA elections declined by members (opt-out tracking)"
    - name: "subsidy_eligible_count"
      expr: SUM(CASE WHEN subsidy_eligibility_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of COBRA elections eligible for subsidy (affordability program reach)"
    - name: "early_termination_count"
      expr: SUM(CASE WHEN early_termination_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of early COBRA terminations (retention challenge indicator)"
    - name: "election_notice_sent_count"
      expr: SUM(CASE WHEN election_notice_sent_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of election notices sent (compliance tracking)"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`enrollment_qualifying_life_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Qualifying Life Event (QLE) and Special Enrollment Period (SEP) metrics tracking event types, verification status, SEP windows, and CMS outcomes for mid-year enrollment changes"
  source: "`health_insurance_ecm`.`enrollment`.`event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of qualifying life event (marriage, birth, loss of coverage, etc.)"
  measures:
    - name: "total_qualifying_life_events"
      expr: COUNT(1)
      comment: "Total number of qualifying life events reported (baseline QLE volume)"
    - name: "unique_members_with_qle"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Distinct count of members reporting qualifying life events"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`enrollment_open_enrollment_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Open Enrollment Period (OEP) metrics tracking enrollment windows, volume targets, compliance status, and regulatory filing requirements across lines of business and eligibility segments"
  source: "`health_insurance_ecm`.`enrollment`.`open_enrollment_period`"
  dimensions:
    - name: "open_enrollment_period_status"
      expr: open_enrollment_period_status
      comment: "Current status of the open enrollment period (active, closed, pending)"
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment period (annual, special, initial)"
    - name: "lob"
      expr: lob
      comment: "Line of business (commercial, Medicare, Medicaid, exchange)"
    - name: "eligibility_segment"
      expr: eligibility_segment
      comment: "Eligibility segment for the enrollment period"
    - name: "exchange_type"
      expr: exchange_type
      comment: "Type of exchange (federal, state-based)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the enrollment period"
    - name: "is_annual"
      expr: is_annual
      comment: "Flag indicating whether this is an annual enrollment period"
    - name: "is_retrospective_allowed"
      expr: is_retrospective_allowed
      comment: "Flag indicating whether retrospective enrollment is allowed"
    - name: "regulatory_filing_required"
      expr: regulatory_filing_required
      comment: "Flag indicating whether regulatory filing is required"
    - name: "volume_target_met"
      expr: volume_target_met
      comment: "Flag indicating whether enrollment volume target was met"
    - name: "period_year"
      expr: YEAR(start_date)
      comment: "Year when the open enrollment period started"
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when the open enrollment period started"
  measures:
    - name: "total_open_enrollment_periods"
      expr: COUNT(1)
      comment: "Total number of open enrollment periods (baseline OEP volume)"
    - name: "active_oep_count"
      expr: SUM(CASE WHEN open_enrollment_period_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of currently active open enrollment periods (operational workload)"
    - name: "annual_oep_count"
      expr: SUM(CASE WHEN is_annual = TRUE THEN 1 ELSE 0 END)
      comment: "Count of annual open enrollment periods (standard enrollment cycles)"
    - name: "regulatory_filing_required_count"
      expr: SUM(CASE WHEN regulatory_filing_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of OEPs requiring regulatory filing (compliance workload)"
    - name: "volume_target_met_count"
      expr: SUM(CASE WHEN volume_target_met = TRUE THEN 1 ELSE 0 END)
      comment: "Count of OEPs that met enrollment volume targets (performance metric)"
    - name: "retrospective_allowed_count"
      expr: SUM(CASE WHEN is_retrospective_allowed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of OEPs allowing retrospective enrollment (flexibility indicator)"
$$;