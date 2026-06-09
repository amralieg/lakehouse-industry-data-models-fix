-- Metric views for domain: pharmacy | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 18:36:19

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`pharmacy_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core pharmacy claims metrics covering cost, utilization, member cost-sharing, and operational KPIs for pharmacy benefit management."
  source: "`health_insurance_ecm`.`pharmacy`.`pharmacy_claim`"
  dimensions:
    - name: "fill_date"
      expr: fill_date
      comment: "Date the prescription was filled/dispensed."
    - name: "fill_month"
      expr: DATE_TRUNC('month', fill_date)
      comment: "Month in which the prescription was filled, for trend analysis."
    - name: "fill_year"
      expr: YEAR(fill_date)
      comment: "Year in which the prescription was filled."
    - name: "claim_status"
      expr: claim_status
      comment: "Current adjudication status of the pharmacy claim (paid, reversed, rejected, etc.)."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (Commercial, Medicare, Medicaid, Exchange) for segment analysis."
    - name: "pharmacy_channel"
      expr: pharmacy_channel
      comment: "Dispensing channel — retail, mail order, or specialty pharmacy."
    - name: "formulary_tier"
      expr: formulary_tier
      comment: "Formulary tier of the dispensed drug (generic, preferred brand, non-preferred, specialty)."
    - name: "daw_code"
      expr: daw_code
      comment: "Dispense As Written code indicating substitution behavior."
    - name: "is_compound_claim"
      expr: is_compound_claim
      comment: "Whether the claim is for a compounded medication."
    - name: "is_340b_claim"
      expr: is_340b_claim
      comment: "Whether the claim was processed under the 340B drug pricing program."
    - name: "cob_indicator"
      expr: cob_indicator
      comment: "Coordination of Benefits indicator — whether another payer is involved."
    - name: "dur_outcome_code"
      expr: dur_outcome_code
      comment: "Drug Utilization Review outcome code from adjudication."
    - name: "reject_code"
      expr: reject_code
      comment: "NCPDP reject code if the claim was rejected."
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of pharmacy claims submitted — baseline volume metric."
    - name: "total_ingredient_cost"
      expr: SUM(CAST(ingredient_cost AS DOUBLE))
      comment: "Total ingredient cost across all claims — primary drug spend measure."
    - name: "total_plan_paid_amount"
      expr: SUM(CAST(plan_paid_amount AS DOUBLE))
      comment: "Total amount paid by the health plan — key financial liability metric."
    - name: "total_member_copay"
      expr: SUM(CAST(member_copay AS DOUBLE))
      comment: "Total member copayment amounts — member cost-sharing burden."
    - name: "total_member_coinsurance"
      expr: SUM(CAST(member_coinsurance AS DOUBLE))
      comment: "Total member coinsurance amounts — additional member cost-sharing."
    - name: "total_deductible_applied"
      expr: SUM(CAST(deductible_applied AS DOUBLE))
      comment: "Total deductible amounts applied to pharmacy claims."
    - name: "total_dispensing_fee"
      expr: SUM(CAST(dispensing_fee AS DOUBLE))
      comment: "Total dispensing fees paid to pharmacies."
    - name: "total_other_payer_amount"
      expr: SUM(CAST(other_payer_amount AS DOUBLE))
      comment: "Total amounts paid by other payers under coordination of benefits."
    - name: "total_sales_tax"
      expr: SUM(CAST(sales_tax AS DOUBLE))
      comment: "Total sales tax on pharmacy claims."
    - name: "total_quantity_dispensed"
      expr: SUM(CAST(quantity_dispensed AS DOUBLE))
      comment: "Total units/quantity of medication dispensed across all claims."
    - name: "avg_ingredient_cost_per_claim"
      expr: AVG(CAST(ingredient_cost AS DOUBLE))
      comment: "Average ingredient cost per claim — unit cost efficiency indicator."
    - name: "avg_plan_paid_per_claim"
      expr: AVG(CAST(plan_paid_amount AS DOUBLE))
      comment: "Average plan paid amount per claim — plan cost efficiency KPI."
    - name: "avg_member_copay_per_claim"
      expr: AVG(CAST(member_copay AS DOUBLE))
      comment: "Average member copay per claim — member affordability indicator."
    - name: "avg_days_supply_per_claim"
      expr: AVG(CAST(days_supply AS DOUBLE))
      comment: "Average days supply per claim — adherence and fill pattern indicator."
    - name: "unique_members"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct members with pharmacy claims — pharmacy utilization reach."
    - name: "unique_prescribers"
      expr: COUNT(DISTINCT prescriber_npi)
      comment: "Distinct prescribers generating pharmacy claims — prescriber network breadth."
    - name: "unique_pharmacies"
      expr: COUNT(DISTINCT dispensing_pharmacy_id)
      comment: "Distinct dispensing pharmacies used — pharmacy network utilization."
    - name: "unique_drugs"
      expr: COUNT(DISTINCT ndc)
      comment: "Distinct NDC codes dispensed — formulary breadth utilization."
    - name: "compound_claim_count"
      expr: SUM(CASE WHEN is_compound_claim = TRUE THEN 1 ELSE 0 END)
      comment: "Count of compound claims — monitors high-cost compound utilization."
    - name: "claims_340b_count"
      expr: SUM(CASE WHEN is_340b_claim = TRUE THEN 1 ELSE 0 END)
      comment: "Count of 340B program claims — tracks 340B utilization and savings opportunity."
    - name: "cob_claim_count"
      expr: SUM(CASE WHEN cob_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of claims with coordination of benefits — COB recovery opportunity."
    - name: "avg_quantity_dispensed"
      expr: AVG(CAST(quantity_dispensed AS DOUBLE))
      comment: "Average quantity dispensed per claim — utilization intensity measure."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`pharmacy_claim_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim line-level pharmacy metrics for granular drug cost analysis, generic dispensing, specialty utilization, and Part D reporting."
  source: "`health_insurance_ecm`.`pharmacy`.`claim_line`"
  dimensions:
    - name: "dispensed_date"
      expr: dispensed_date
      comment: "Date the medication was dispensed."
    - name: "dispensed_month"
      expr: DATE_TRUNC('month', dispensed_date)
      comment: "Month of dispensing for trend analysis."
    - name: "line_status"
      expr: line_status
      comment: "Status of the claim line (paid, denied, reversed)."
    - name: "line_type"
      expr: line_type
      comment: "Type of claim line (ingredient, dispensing fee, etc.)."
    - name: "pharmacy_channel"
      expr: pharmacy_channel
      comment: "Dispensing channel — retail, mail order, specialty."
    - name: "formulary_tier"
      expr: formulary_tier
      comment: "Formulary tier assigned to the dispensed drug."
    - name: "generic_indicator"
      expr: generic_indicator
      comment: "Whether the dispensed drug is a generic — key for GDR tracking."
    - name: "specialty_drug_indicator"
      expr: specialty_drug_indicator
      comment: "Whether the dispensed drug is a specialty drug."
    - name: "compound_indicator"
      expr: compound_indicator
      comment: "Whether the claim line is for a compounded medication."
    - name: "dispense_as_written_code"
      expr: dispense_as_written_code
      comment: "DAW code indicating brand vs generic substitution."
    - name: "drug_coverage_status"
      expr: drug_coverage_status
      comment: "Coverage determination status for the drug."
    - name: "catastrophic_coverage_indicator"
      expr: catastrophic_coverage_indicator
      comment: "Whether the claim falls in the catastrophic coverage phase (Part D)."
    - name: "coverage_gap_indicator"
      expr: coverage_gap_indicator
      comment: "Whether the claim falls in the coverage gap / donut hole (Part D)."
    - name: "low_income_subsidy_indicator"
      expr: low_income_subsidy_indicator
      comment: "Whether the member receives Low Income Subsidy benefits."
    - name: "ndc_code"
      expr: ndc_code
      comment: "National Drug Code of the dispensed medication."
  measures:
    - name: "total_claim_lines"
      expr: COUNT(1)
      comment: "Total claim lines processed — granular volume metric."
    - name: "total_gross_drug_cost"
      expr: SUM(CAST(gross_drug_cost_amount AS DOUBLE))
      comment: "Total gross drug cost — comprehensive cost before adjustments."
    - name: "total_ingredient_cost"
      expr: SUM(CAST(ingredient_cost_amount AS DOUBLE))
      comment: "Total ingredient cost at the claim line level."
    - name: "total_plan_paid"
      expr: SUM(CAST(plan_paid_amount AS DOUBLE))
      comment: "Total plan paid amount at claim line level."
    - name: "total_patient_pay"
      expr: SUM(CAST(patient_pay_amount AS DOUBLE))
      comment: "Total patient out-of-pocket payments."
    - name: "total_dispensing_fee"
      expr: SUM(CAST(dispensing_fee_amount AS DOUBLE))
      comment: "Total dispensing fees at claim line level."
    - name: "total_manufacturer_discount"
      expr: SUM(CAST(manufacturer_discount_amount AS DOUBLE))
      comment: "Total manufacturer discounts applied — Part D coverage gap discount tracking."
    - name: "total_true_oop"
      expr: SUM(CAST(true_oop_amount AS DOUBLE))
      comment: "Total True Out-of-Pocket (TrOOP) amounts — critical for Part D benefit phase tracking."
    - name: "total_other_payer"
      expr: SUM(CAST(other_payer_amount AS DOUBLE))
      comment: "Total amounts from other payers under COB."
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive amounts applied to claim lines."
    - name: "total_quantity_dispensed"
      expr: SUM(CAST(quantity_dispensed AS DOUBLE))
      comment: "Total quantity of medication dispensed."
    - name: "avg_gross_drug_cost"
      expr: AVG(CAST(gross_drug_cost_amount AS DOUBLE))
      comment: "Average gross drug cost per claim line — unit economics."
    - name: "avg_patient_pay"
      expr: AVG(CAST(patient_pay_amount AS DOUBLE))
      comment: "Average patient pay per claim line — member affordability KPI."
    - name: "generic_claim_line_count"
      expr: SUM(CASE WHEN generic_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of generic drug claim lines — numerator for Generic Dispensing Rate."
    - name: "specialty_claim_line_count"
      expr: SUM(CASE WHEN specialty_drug_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of specialty drug claim lines — specialty spend monitoring."
    - name: "catastrophic_phase_count"
      expr: SUM(CASE WHEN catastrophic_coverage_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Claims in catastrophic coverage phase — Part D reinsurance exposure."
    - name: "coverage_gap_count"
      expr: SUM(CASE WHEN coverage_gap_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Claims in coverage gap phase — donut hole impact tracking."
    - name: "lis_claim_count"
      expr: SUM(CASE WHEN low_income_subsidy_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Low Income Subsidy claim count — LIS population utilization."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`pharmacy_drug_rebate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug rebate financial metrics tracking manufacturer rebate performance, pass-through amounts, and reconciliation status for pharmacy benefit optimization."
  source: "`health_insurance_ecm`.`pharmacy`.`drug_rebate`"
  dimensions:
    - name: "rebate_period_start_date"
      expr: rebate_period_start_date
      comment: "Start date of the rebate accrual period."
    - name: "rebate_period_end_date"
      expr: rebate_period_end_date
      comment: "End date of the rebate accrual period."
    - name: "rebate_type"
      expr: rebate_type
      comment: "Type of rebate (base, market share, admin fee, etc.)."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for rebate segmentation."
    - name: "manufacturer_name"
      expr: manufacturer_name
      comment: "Drug manufacturer name for rebate attribution."
    - name: "therapeutic_class_code"
      expr: therapeutic_class_code
      comment: "Therapeutic class for clinical category rebate analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Rebate reconciliation status (pending, reconciled, disputed)."
    - name: "drug_tier"
      expr: drug_tier
      comment: "Formulary tier of the rebated drug."
    - name: "rebate_rate_basis"
      expr: rebate_rate_basis
      comment: "Basis for rebate rate calculation (WAC, AWP, etc.)."
    - name: "specialty_drug_indicator"
      expr: specialty_drug_indicator
      comment: "Whether the rebate is for a specialty drug."
    - name: "part_d_indicator"
      expr: part_d_indicator
      comment: "Whether the rebate applies to Part D drugs."
    - name: "mlr_rebate_category"
      expr: mlr_rebate_category
      comment: "Medical Loss Ratio rebate classification for regulatory reporting."
    - name: "dispute_reason"
      expr: dispute_reason
      comment: "Reason for rebate dispute if applicable."
  measures:
    - name: "total_rebate_records"
      expr: COUNT(1)
      comment: "Total rebate line items — volume of rebate activity."
    - name: "total_calculated_rebate"
      expr: SUM(CAST(calculated_rebate_amount AS DOUBLE))
      comment: "Total calculated rebate amount — expected rebate revenue."
    - name: "total_invoiced_amount"
      expr: SUM(CAST(invoiced_amount AS DOUBLE))
      comment: "Total invoiced rebate amount — billed to manufacturers."
    - name: "total_received_amount"
      expr: SUM(CAST(received_amount AS DOUBLE))
      comment: "Total rebate amount actually received — cash collected."
    - name: "total_pass_through_amount"
      expr: SUM(CAST(pass_through_amount AS DOUBLE))
      comment: "Total rebate pass-through to plan sponsors — contractual obligation."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between calculated and received rebates — leakage indicator."
    - name: "total_utilization_units"
      expr: SUM(CAST(utilization_units AS DOUBLE))
      comment: "Total utilization units driving rebate calculations."
    - name: "avg_contracted_rebate_rate"
      expr: AVG(CAST(contracted_rebate_rate AS DOUBLE))
      comment: "Average contracted rebate rate — negotiation effectiveness."
    - name: "avg_market_share_pct"
      expr: AVG(CAST(market_share_pct AS DOUBLE))
      comment: "Average market share percentage — formulary positioning effectiveness."
    - name: "performance_target_met_count"
      expr: SUM(CASE WHEN performance_target_met_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of rebate lines where performance targets were met."
    - name: "unique_manufacturers"
      expr: COUNT(DISTINCT manufacturer_name)
      comment: "Distinct manufacturers with rebate agreements — rebate portfolio breadth."
    - name: "unique_drugs"
      expr: COUNT(DISTINCT ndc_code)
      comment: "Distinct NDCs with rebate activity."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`pharmacy_prior_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization metrics tracking approval rates, turnaround times, and utilization management effectiveness for pharmacy benefits."
  source: "`health_insurance_ecm`.`pharmacy`.`prior_authorization`"
  dimensions:
    - name: "request_date"
      expr: request_date
      comment: "Date the prior authorization request was submitted."
    - name: "request_month"
      expr: DATE_TRUNC('month', request_date)
      comment: "Month of PA request for trend analysis."
    - name: "pa_status"
      expr: pa_status
      comment: "Current status of the prior authorization (approved, denied, pending, expired)."
    - name: "pa_type"
      expr: pa_type
      comment: "Type of prior authorization (standard, expedited, exception)."
    - name: "request_type"
      expr: request_type
      comment: "Type of request (initial, renewal, appeal)."
    - name: "review_level"
      expr: review_level
      comment: "Level of clinical review (first-level, peer-to-peer, etc.)."
    - name: "lob"
      expr: lob
      comment: "Line of business for the PA request."
    - name: "drug_tier"
      expr: drug_tier
      comment: "Formulary tier of the requested drug."
    - name: "dispensing_channel"
      expr: dispensing_channel
      comment: "Intended dispensing channel (retail, mail, specialty)."
    - name: "specialty_drug_flag"
      expr: specialty_drug_flag
      comment: "Whether the PA is for a specialty drug."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code for PA denial — root cause analysis."
    - name: "cms_part_d_reportable"
      expr: cms_part_d_reportable
      comment: "Whether the PA is reportable to CMS under Part D."
    - name: "step_therapy_required"
      expr: step_therapy_required
      comment: "Whether step therapy was required before approval."
    - name: "appeal_indicator"
      expr: appeal_indicator
      comment: "Whether the PA was appealed."
  measures:
    - name: "total_pa_requests"
      expr: COUNT(1)
      comment: "Total prior authorization requests — UM workload volume."
    - name: "approved_pa_count"
      expr: SUM(CASE WHEN pa_status = 'approved' THEN 1 ELSE 0 END)
      comment: "Count of approved PAs — numerator for approval rate."
    - name: "denied_pa_count"
      expr: SUM(CASE WHEN pa_status = 'denied' THEN 1 ELSE 0 END)
      comment: "Count of denied PAs — denial burden metric."
    - name: "pending_pa_count"
      expr: SUM(CASE WHEN pa_status = 'pending' THEN 1 ELSE 0 END)
      comment: "Count of pending PAs — operational backlog indicator."
    - name: "appealed_pa_count"
      expr: SUM(CASE WHEN appeal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of appealed PAs — member friction indicator."
    - name: "criteria_met_count"
      expr: SUM(CASE WHEN criteria_met = TRUE THEN 1 ELSE 0 END)
      comment: "Count of PAs where clinical criteria were met."
    - name: "step_therapy_required_count"
      expr: SUM(CASE WHEN step_therapy_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of PAs requiring step therapy — formulary management impact."
    - name: "specialty_pa_count"
      expr: SUM(CASE WHEN specialty_drug_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of specialty drug PAs — high-cost drug management volume."
    - name: "total_approved_quantity"
      expr: SUM(CAST(approved_quantity AS DOUBLE))
      comment: "Total approved quantity across all PAs."
    - name: "unique_members"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Distinct members with PA requests — member impact scope."
    - name: "unique_drugs"
      expr: COUNT(DISTINCT drug_ndc)
      comment: "Distinct drugs requiring PA — formulary restriction breadth."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`pharmacy_benefit_accumulator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit accumulator metrics tracking member progress toward deductibles, out-of-pocket maximums, and Part D benefit phases — critical for cost projection and member experience."
  source: "`health_insurance_ecm`.`pharmacy`.`benefit_accumulator`"
  dimensions:
    - name: "benefit_period_start_date"
      expr: benefit_period_start_date
      comment: "Start of the benefit accumulation period."
    - name: "benefit_period_end_date"
      expr: benefit_period_end_date
      comment: "End of the benefit accumulation period."
    - name: "accumulator_status"
      expr: accumulator_status
      comment: "Current status of the accumulator record."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for accumulator segmentation."
    - name: "part_d_benefit_phase"
      expr: part_d_benefit_phase
      comment: "Current Part D benefit phase (deductible, initial coverage, gap, catastrophic)."
    - name: "is_deductible_met"
      expr: is_deductible_met
      comment: "Whether the member has met their deductible."
    - name: "is_moop_met"
      expr: is_moop_met
      comment: "Whether the member has met their maximum out-of-pocket."
    - name: "coordination_of_benefits_type"
      expr: coordination_of_benefits_type
      comment: "Type of coordination of benefits applicable."
    - name: "formulary_tier_applied"
      expr: formulary_tier_applied
      comment: "Formulary tier applied in accumulator calculations."
    - name: "lis_level"
      expr: lis_level
      comment: "Low Income Subsidy level for the member."
    - name: "cms_reconciliation_status"
      expr: cms_reconciliation_status
      comment: "CMS reconciliation status for Part D accumulators."
  measures:
    - name: "total_accumulator_records"
      expr: COUNT(1)
      comment: "Total accumulator records — member benefit tracking volume."
    - name: "total_deductible_applied"
      expr: SUM(CAST(deductible_applied_amt AS DOUBLE))
      comment: "Total deductible amounts applied across all members."
    - name: "total_oop_applied"
      expr: SUM(CAST(oop_applied_amt AS DOUBLE))
      comment: "Total out-of-pocket amounts applied — member cost burden."
    - name: "total_family_deductible_applied"
      expr: SUM(CAST(family_deductible_applied_amt AS DOUBLE))
      comment: "Total family-level deductible amounts applied."
    - name: "total_family_oop_applied"
      expr: SUM(CAST(family_oop_applied_amt AS DOUBLE))
      comment: "Total family-level out-of-pocket amounts applied."
    - name: "total_troop_applied"
      expr: SUM(CAST(troop_applied_amt AS DOUBLE))
      comment: "Total True Out-of-Pocket (TrOOP) amounts applied — Part D benefit phase driver."
    - name: "total_icl_applied"
      expr: SUM(CAST(icl_applied_amt AS DOUBLE))
      comment: "Total Initial Coverage Limit amounts applied — Part D phase tracking."
    - name: "total_catastrophic_applied"
      expr: SUM(CAST(catastrophic_applied_amt AS DOUBLE))
      comment: "Total catastrophic phase amounts applied — reinsurance exposure."
    - name: "total_coverage_gap_discount_applied"
      expr: SUM(CAST(coverage_gap_discount_applied_amt AS DOUBLE))
      comment: "Total coverage gap discounts applied — manufacturer discount program tracking."
    - name: "total_specialty_drug_applied"
      expr: SUM(CAST(specialty_drug_applied_amt AS DOUBLE))
      comment: "Total specialty drug amounts applied to accumulators."
    - name: "total_hsa_eligible_applied"
      expr: SUM(CAST(hsa_eligible_applied_amt AS DOUBLE))
      comment: "Total HSA-eligible amounts applied — consumer-directed health plan tracking."
    - name: "deductible_met_count"
      expr: SUM(CASE WHEN is_deductible_met = TRUE THEN 1 ELSE 0 END)
      comment: "Count of members who have met their deductible — cost acceleration indicator."
    - name: "moop_met_count"
      expr: SUM(CASE WHEN is_moop_met = TRUE THEN 1 ELSE 0 END)
      comment: "Count of members who have met MOOP — plan bears 100% cost."
    - name: "unique_members"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Distinct members with accumulator records."
    - name: "avg_deductible_applied"
      expr: AVG(CAST(deductible_applied_amt AS DOUBLE))
      comment: "Average deductible applied per accumulator — member cost progression."
    - name: "avg_oop_applied"
      expr: AVG(CAST(oop_applied_amt AS DOUBLE))
      comment: "Average out-of-pocket applied per accumulator — member financial exposure."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`pharmacy_formulary_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Formulary exception metrics tracking coverage determination requests, approval patterns, and member access to non-formulary drugs — critical for CMS compliance and member satisfaction."
  source: "`health_insurance_ecm`.`pharmacy`.`formulary_exception`"
  dimensions:
    - name: "request_date"
      expr: request_date
      comment: "Date the formulary exception was requested."
    - name: "request_month"
      expr: DATE_TRUNC('month', request_date)
      comment: "Month of exception request for trend analysis."
    - name: "exception_type"
      expr: exception_type
      comment: "Type of formulary exception (tier, formulary, quantity limit, step therapy)."
    - name: "exception_status"
      expr: exception_status
      comment: "Current status of the exception request."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for the exception."
    - name: "cms_coverage_determination_type"
      expr: cms_coverage_determination_type
      comment: "CMS coverage determination type — regulatory classification."
    - name: "is_expedited"
      expr: is_expedited
      comment: "Whether the exception request was expedited."
    - name: "review_level"
      expr: review_level
      comment: "Level of review for the exception."
    - name: "requestor_type"
      expr: requestor_type
      comment: "Who submitted the exception (member, prescriber, representative)."
    - name: "request_channel"
      expr: request_channel
      comment: "Channel through which the exception was submitted."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code for exception denial."
    - name: "current_drug_tier"
      expr: current_drug_tier
      comment: "Current formulary tier of the requested drug."
    - name: "requested_drug_tier"
      expr: requested_drug_tier
      comment: "Requested formulary tier for tier exception."
  measures:
    - name: "total_exception_requests"
      expr: COUNT(1)
      comment: "Total formulary exception requests — member access demand."
    - name: "approved_exception_count"
      expr: SUM(CASE WHEN exception_status = 'approved' THEN 1 ELSE 0 END)
      comment: "Count of approved exceptions — access granted."
    - name: "denied_exception_count"
      expr: SUM(CASE WHEN exception_status = 'denied' THEN 1 ELSE 0 END)
      comment: "Count of denied exceptions — potential member friction."
    - name: "expedited_request_count"
      expr: SUM(CASE WHEN is_expedited = TRUE THEN 1 ELSE 0 END)
      comment: "Count of expedited exception requests — urgency indicator."
    - name: "appeal_notified_count"
      expr: SUM(CASE WHEN appeal_rights_notified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of members notified of appeal rights — compliance tracking."
    - name: "supporting_doc_received_count"
      expr: SUM(CASE WHEN supporting_doc_received = TRUE THEN 1 ELSE 0 END)
      comment: "Count of requests with supporting documentation received."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total quantity requested across all exceptions."
    - name: "unique_members"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct members requesting formulary exceptions."
    - name: "unique_drugs"
      expr: COUNT(DISTINCT drug_ndc)
      comment: "Distinct drugs for which exceptions were requested — formulary gap indicator."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`pharmacy_dur_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug Utilization Review alert metrics tracking clinical safety interventions, alert volumes, severity patterns, and override rates for patient safety and quality management."
  source: "`health_insurance_ecm`.`pharmacy`.`dur_alert`"
  dimensions:
    - name: "dispensing_date"
      expr: dispensing_date
      comment: "Date of dispensing that triggered the DUR alert."
    - name: "dispensing_month"
      expr: DATE_TRUNC('month', dispensing_date)
      comment: "Month of dispensing for DUR trend analysis."
    - name: "alert_type_code"
      expr: alert_type_code
      comment: "Type of DUR alert (drug-drug interaction, therapeutic duplication, etc.)."
    - name: "alert_type_description"
      expr: alert_type_description
      comment: "Description of the DUR alert type."
    - name: "alert_status"
      expr: alert_status
      comment: "Current status of the DUR alert."
    - name: "severity_level_code"
      expr: severity_level_code
      comment: "Severity level of the clinical alert."
    - name: "severity_level_description"
      expr: severity_level_description
      comment: "Description of the severity level."
    - name: "adjudication_outcome"
      expr: adjudication_outcome
      comment: "Outcome of adjudication after DUR alert."
    - name: "clinical_significance_code"
      expr: clinical_significance_code
      comment: "Clinical significance classification of the alert."
    - name: "reason_for_service_code"
      expr: reason_for_service_code
      comment: "NCPDP reason for service code."
    - name: "result_of_service_code"
      expr: result_of_service_code
      comment: "NCPDP result of service code — intervention outcome."
    - name: "professional_service_code"
      expr: professional_service_code
      comment: "Professional service code for pharmacist intervention."
    - name: "dur_program_type"
      expr: dur_program_type
      comment: "Type of DUR program (prospective, retrospective, concurrent)."
    - name: "pa_required_flag"
      expr: pa_required_flag
      comment: "Whether the alert triggered a PA requirement."
    - name: "quantity_limit_flag"
      expr: quantity_limit_flag
      comment: "Whether the alert was related to quantity limits."
  measures:
    - name: "total_dur_alerts"
      expr: COUNT(1)
      comment: "Total DUR alerts generated — clinical safety intervention volume."
    - name: "unique_members_alerted"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct members with DUR alerts — patient safety reach."
    - name: "pa_triggered_count"
      expr: SUM(CASE WHEN pa_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of alerts that triggered prior authorization requirements."
    - name: "quantity_limit_alert_count"
      expr: SUM(CASE WHEN quantity_limit_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of quantity limit-related alerts."
    - name: "step_therapy_alert_count"
      expr: SUM(CASE WHEN step_therapy_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of step therapy-related alerts."
    - name: "total_quantity_dispensed"
      expr: SUM(CAST(quantity_dispensed AS DOUBLE))
      comment: "Total quantity dispensed on claims with DUR alerts."
    - name: "avg_prescribed_quantity"
      expr: AVG(CAST(prescribed_quantity AS DOUBLE))
      comment: "Average prescribed quantity on alerted claims."
    - name: "unique_drugs_alerted"
      expr: COUNT(DISTINCT drug_ndc)
      comment: "Distinct drugs triggering DUR alerts — drug safety profile breadth."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`pharmacy_part_d_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medicare Part D submission metrics tracking PDE filing volumes, acceptance rates, timeliness, and financial reconciliation for CMS regulatory compliance."
  source: "`health_insurance_ecm`.`pharmacy`.`part_d_submission`"
  dimensions:
    - name: "submission_date"
      expr: DATE_TRUNC('day', submission_date)
      comment: "Date of submission to CMS."
    - name: "submission_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month of submission for trend analysis."
    - name: "benefit_year"
      expr: benefit_year
      comment: "Benefit year for the submission."
    - name: "submission_type"
      expr: submission_type
      comment: "Type of submission (original, adjustment, deletion)."
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the submission batch."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status with CMS."
    - name: "cms_contract_number"
      expr: cms_contract_number
      comment: "CMS contract number for the submission."
    - name: "cms_response_code"
      expr: cms_response_code
      comment: "CMS response code for the submission."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (Medicare Part D)."
    - name: "is_resubmission"
      expr: is_resubmission
      comment: "Whether this is a resubmission of a prior batch."
    - name: "is_timely_submission"
      expr: is_timely_submission
      comment: "Whether the submission met CMS timeliness requirements."
    - name: "submission_format"
      expr: submission_format
      comment: "Format of the submission file."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total Part D submission batches — filing volume."
    - name: "total_dir_amount"
      expr: SUM(CAST(dir_amount AS DOUBLE))
      comment: "Total Direct and Indirect Remuneration amounts — Part D DIR reporting."
    - name: "total_cgdp_invoice_amount"
      expr: SUM(CAST(cgdp_invoice_amount AS DOUBLE))
      comment: "Total Coverage Gap Discount Program invoice amounts."
    - name: "total_raf_impact_amount"
      expr: SUM(CAST(raf_impact_amount AS DOUBLE))
      comment: "Total Risk Adjustment Factor impact amounts — revenue adjustment."
    - name: "timely_submission_count"
      expr: SUM(CASE WHEN is_timely_submission = TRUE THEN 1 ELSE 0 END)
      comment: "Count of timely submissions — CMS compliance rate numerator."
    - name: "resubmission_count"
      expr: SUM(CASE WHEN is_resubmission = TRUE THEN 1 ELSE 0 END)
      comment: "Count of resubmissions — data quality and rework indicator."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`pharmacy_drug_pricing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug pricing metrics tracking AWP, WAC, MAC pricing benchmarks and dispensing fees for pharmacy reimbursement management and cost containment."
  source: "`health_insurance_ecm`.`pharmacy`.`drug_pricing`"
  dimensions:
    - name: "effective_date"
      expr: effective_date
      comment: "Effective date of the drug price."
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of price effective date for trend analysis."
    - name: "price_type"
      expr: price_type
      comment: "Type of pricing (AWP, WAC, MAC, etc.)."
    - name: "pricing_source"
      expr: pricing_source
      comment: "Source of the pricing data (Medi-Span, First Databank, etc.)."
    - name: "pricing_status"
      expr: pricing_status
      comment: "Status of the pricing record (active, expired, pending)."
    - name: "dispensing_channel"
      expr: dispensing_channel
      comment: "Dispensing channel for channel-specific pricing."
    - name: "formulary_tier"
      expr: formulary_tier
      comment: "Formulary tier associated with the pricing."
    - name: "multi_source_code"
      expr: multi_source_code
      comment: "Multi-source code indicating brand/generic/single-source status."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the pricing."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the drug price."
  measures:
    - name: "total_pricing_records"
      expr: COUNT(1)
      comment: "Total drug pricing records — pricing file coverage."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across all drugs — overall price level indicator."
    - name: "avg_awp_price"
      expr: AVG(CAST(awp_price AS DOUBLE))
      comment: "Average AWP price — benchmark pricing level."
    - name: "avg_wac_price"
      expr: AVG(CAST(wac_price AS DOUBLE))
      comment: "Average WAC price — manufacturer list price level."
    - name: "avg_mac_price"
      expr: AVG(CAST(mac_price AS DOUBLE))
      comment: "Average MAC price — maximum allowable cost level."
    - name: "avg_dispensing_fee"
      expr: AVG(CAST(dispensing_fee AS DOUBLE))
      comment: "Average dispensing fee — pharmacy reimbursement component."
    - name: "avg_awp_discount_pct"
      expr: AVG(CAST(awp_discount_pct AS DOUBLE))
      comment: "Average AWP discount percentage — discount depth indicator."
    - name: "avg_price_change_pct"
      expr: AVG(CAST(price_change_pct AS DOUBLE))
      comment: "Average price change percentage — drug inflation/deflation trend."
    - name: "unique_drugs_priced"
      expr: COUNT(DISTINCT drug_master_id)
      comment: "Distinct drugs with pricing records — pricing file completeness."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`pharmacy_mtm_service`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medication Therapy Management service metrics tracking CMR completion, member engagement, and clinical intervention outcomes — critical for CMS Star Ratings and quality measures."
  source: "`health_insurance_ecm`.`pharmacy`.`mtm_service`"
  dimensions:
    - name: "service_date"
      expr: service_date
      comment: "Date the MTM service was provided."
    - name: "service_month"
      expr: DATE_TRUNC('month', service_date)
      comment: "Month of MTM service for trend analysis."
    - name: "service_type"
      expr: service_type
      comment: "Type of MTM service (CMR, TMR, intervention)."
    - name: "service_status"
      expr: service_status
      comment: "Status of the MTM service."
    - name: "service_delivery_channel"
      expr: service_delivery_channel
      comment: "Channel of service delivery (phone, in-person, telehealth)."
    - name: "drug_therapy_problem_type"
      expr: drug_therapy_problem_type
      comment: "Type of drug therapy problem identified."
    - name: "follow_up_status"
      expr: follow_up_status
      comment: "Status of follow-up after MTM service."
    - name: "opt_out_flag"
      expr: opt_out_flag
      comment: "Whether the member opted out of MTM."
    - name: "opt_out_reason"
      expr: opt_out_reason
      comment: "Reason for member opt-out."
    - name: "star_measure_eligible_flag"
      expr: star_measure_eligible_flag
      comment: "Whether the service counts toward CMS Star Ratings."
    - name: "cms_reporting_period"
      expr: cms_reporting_period
      comment: "CMS reporting period for the MTM service."
    - name: "member_consent_flag"
      expr: member_consent_flag
      comment: "Whether the member consented to MTM services."
  measures:
    - name: "total_mtm_services"
      expr: COUNT(1)
      comment: "Total MTM services delivered — program activity volume."
    - name: "unique_members_served"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Distinct members receiving MTM services — program reach."
    - name: "cmr_completed_count"
      expr: SUM(CASE WHEN cmr_completion_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of completed Comprehensive Medication Reviews — Star Rating numerator."
    - name: "map_provided_count"
      expr: SUM(CASE WHEN map_provided_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of Medication Action Plans provided — quality measure."
    - name: "pml_provided_count"
      expr: SUM(CASE WHEN personal_medication_list_provided_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of Personal Medication Lists provided."
    - name: "follow_up_required_count"
      expr: SUM(CASE WHEN follow_up_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of services requiring follow-up — care continuity."
    - name: "opt_out_count"
      expr: SUM(CASE WHEN opt_out_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of member opt-outs — engagement barrier indicator."
    - name: "star_eligible_count"
      expr: SUM(CASE WHEN star_measure_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of Star Rating eligible services — quality program impact."
    - name: "prescriber_notified_count"
      expr: SUM(CASE WHEN prescriber_notification_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of services where prescriber was notified — care coordination."
    - name: "total_estimated_annual_drug_cost"
      expr: SUM(CAST(estimated_annual_drug_cost AS DOUBLE))
      comment: "Total estimated annual drug cost for MTM-eligible members — cost exposure."
    - name: "avg_estimated_annual_drug_cost"
      expr: AVG(CAST(estimated_annual_drug_cost AS DOUBLE))
      comment: "Average estimated annual drug cost per MTM member — high-cost member identification."
    - name: "member_consent_count"
      expr: SUM(CASE WHEN member_consent_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of members who consented to MTM — engagement rate numerator."
$$;