-- Metric views for domain: pharmacy | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 21:18:32

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`pharmacy_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core pharmacy claims metrics tracking prescription utilization, cost, and member financial responsibility across channels and lines of business"
  source: "`health_insurance_ecm`.`pharmacy`.`pharmacy_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current adjudication status of the pharmacy claim (paid, denied, pending, reversed)"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for the claim (Commercial, Medicare, Medicaid, Exchange)"
    - name: "pharmacy_channel"
      expr: pharmacy_channel
      comment: "Dispensing channel (retail, mail order, specialty pharmacy)"
    - name: "fill_date"
      expr: fill_date
      comment: "Date the prescription was filled at the pharmacy"
    - name: "fill_year"
      expr: YEAR(fill_date)
      comment: "Year the prescription was filled"
    - name: "fill_month"
      expr: DATE_TRUNC('MONTH', fill_date)
      comment: "Month the prescription was filled"
    - name: "is_340b_claim"
      expr: is_340b_claim
      comment: "Indicator whether claim qualifies for 340B drug pricing program"
    - name: "is_compound_claim"
      expr: is_compound_claim
      comment: "Indicator whether claim is for a compounded medication"
    - name: "daw_code"
      expr: daw_code
      comment: "Dispense As Written code indicating substitution allowance"
    - name: "basis_of_cost_determination"
      expr: basis_of_cost_determination
      comment: "Pricing methodology used for reimbursement (AWP, MAC, WAC, etc.)"
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of pharmacy claims submitted"
    - name: "total_plan_paid_amount"
      expr: SUM(CAST(plan_paid_amount AS DOUBLE))
      comment: "Total amount paid by the health plan for pharmacy claims"
    - name: "total_member_cost_share"
      expr: SUM(CAST(member_copay AS DOUBLE) + CAST(member_coinsurance AS DOUBLE))
      comment: "Total member out-of-pocket cost including copay and coinsurance"
    - name: "total_ingredient_cost"
      expr: SUM(CAST(ingredient_cost AS DOUBLE))
      comment: "Total ingredient cost for all pharmacy claims"
    - name: "total_dispensing_fee"
      expr: SUM(CAST(dispensing_fee AS DOUBLE))
      comment: "Total dispensing fees paid to pharmacies"
    - name: "total_deductible_applied"
      expr: SUM(CAST(deductible_applied AS DOUBLE))
      comment: "Total deductible amount applied to pharmacy claims"
    - name: "avg_plan_paid_per_claim"
      expr: AVG(CAST(plan_paid_amount AS DOUBLE))
      comment: "Average plan payment per pharmacy claim"
    - name: "avg_member_cost_share_per_claim"
      expr: AVG(CAST(member_copay AS DOUBLE) + CAST(member_coinsurance AS DOUBLE))
      comment: "Average member out-of-pocket cost per claim"
    - name: "total_quantity_dispensed"
      expr: SUM(CAST(quantity_dispensed AS DOUBLE))
      comment: "Total quantity of medication units dispensed across all claims"
    - name: "unique_members"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct count of members with pharmacy claims"
    - name: "unique_prescribers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct count of prescribing providers"
    - name: "unique_drugs"
      expr: COUNT(DISTINCT drug_master_id)
      comment: "Distinct count of unique drugs dispensed"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`pharmacy_claim_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed pharmacy claim line metrics for formulary compliance, specialty drug utilization, and cost component analysis"
  source: "`health_insurance_ecm`.`pharmacy`.`claim_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Adjudication status of the claim line"
    - name: "formulary_tier"
      expr: formulary_tier
      comment: "Formulary tier of the dispensed drug (Tier 1-5, specialty, etc.)"
    - name: "drug_coverage_status"
      expr: drug_coverage_status
      comment: "Coverage determination status for the drug"
    - name: "pharmacy_channel"
      expr: pharmacy_channel
      comment: "Dispensing channel for the claim line"
    - name: "generic_indicator"
      expr: generic_indicator
      comment: "Indicator whether drug dispensed is generic"
    - name: "specialty_drug_indicator"
      expr: specialty_drug_indicator
      comment: "Indicator whether drug is classified as specialty"
    - name: "compound_indicator"
      expr: compound_indicator
      comment: "Indicator whether claim line is for compounded medication"
    - name: "low_income_subsidy_indicator"
      expr: low_income_subsidy_indicator
      comment: "Indicator whether member qualifies for low-income subsidy (Medicare Part D)"
    - name: "catastrophic_coverage_indicator"
      expr: catastrophic_coverage_indicator
      comment: "Indicator whether claim is in catastrophic coverage phase (Medicare Part D)"
    - name: "coverage_gap_indicator"
      expr: coverage_gap_indicator
      comment: "Indicator whether claim is in coverage gap/donut hole (Medicare Part D)"
    - name: "step_therapy_indicator"
      expr: step_therapy_indicator
      comment: "Indicator whether step therapy protocol applies"
    - name: "quantity_limit_indicator"
      expr: quantity_limit_indicator
      comment: "Indicator whether quantity limit applies to the drug"
    - name: "dispensed_month"
      expr: DATE_TRUNC('MONTH', dispensed_date)
      comment: "Month the prescription was dispensed"
  measures:
    - name: "total_claim_lines"
      expr: COUNT(1)
      comment: "Total number of pharmacy claim lines"
    - name: "total_gross_drug_cost"
      expr: SUM(CAST(gross_drug_cost_amount AS DOUBLE))
      comment: "Total gross drug cost before discounts and rebates"
    - name: "total_ingredient_cost"
      expr: SUM(CAST(ingredient_cost_amount AS DOUBLE))
      comment: "Total ingredient cost component"
    - name: "total_dispensing_fee"
      expr: SUM(CAST(dispensing_fee_amount AS DOUBLE))
      comment: "Total dispensing fees paid to pharmacies"
    - name: "total_plan_paid"
      expr: SUM(CAST(plan_paid_amount AS DOUBLE))
      comment: "Total amount paid by health plan"
    - name: "total_patient_pay"
      expr: SUM(CAST(patient_pay_amount AS DOUBLE))
      comment: "Total patient out-of-pocket payment"
    - name: "total_manufacturer_discount"
      expr: SUM(CAST(manufacturer_discount_amount AS DOUBLE))
      comment: "Total manufacturer discounts applied (e.g., coverage gap discount)"
    - name: "total_true_oop"
      expr: SUM(CAST(true_oop_amount AS DOUBLE))
      comment: "Total true out-of-pocket costs counting toward member cost-sharing limits"
    - name: "total_quantity_dispensed"
      expr: SUM(CAST(quantity_dispensed AS DOUBLE))
      comment: "Total quantity of medication units dispensed"
    - name: "avg_gross_drug_cost_per_line"
      expr: AVG(CAST(gross_drug_cost_amount AS DOUBLE))
      comment: "Average gross drug cost per claim line"
    - name: "avg_patient_pay_per_line"
      expr: AVG(CAST(patient_pay_amount AS DOUBLE))
      comment: "Average patient payment per claim line"
    - name: "specialty_drug_lines"
      expr: SUM(CASE WHEN specialty_drug_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of claim lines for specialty drugs"
    - name: "generic_drug_lines"
      expr: SUM(CASE WHEN generic_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of claim lines for generic drugs"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`pharmacy_prior_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization performance metrics tracking approval rates, turnaround time, and clinical criteria compliance for pharmacy utilization management"
  source: "`health_insurance_ecm`.`pharmacy`.`prior_authorization`"
  dimensions:
    - name: "pa_status"
      expr: pa_status
      comment: "Current status of the prior authorization request (approved, denied, pending, expired)"
    - name: "pa_type"
      expr: pa_type
      comment: "Type of prior authorization (initial, reauthorization, appeal)"
    - name: "request_type"
      expr: request_type
      comment: "Request submission type (standard, expedited, urgent)"
    - name: "review_level"
      expr: review_level
      comment: "Level of clinical review (pharmacist, medical director, peer-to-peer)"
    - name: "lob"
      expr: lob
      comment: "Line of business for the prior authorization"
    - name: "specialty_drug_flag"
      expr: specialty_drug_flag
      comment: "Indicator whether PA is for a specialty drug"
    - name: "step_therapy_required"
      expr: step_therapy_required
      comment: "Indicator whether step therapy protocol is required"
    - name: "step_therapy_completed"
      expr: step_therapy_completed
      comment: "Indicator whether required step therapy has been completed"
    - name: "criteria_met"
      expr: criteria_met
      comment: "Indicator whether clinical criteria were met"
    - name: "appeal_indicator"
      expr: appeal_indicator
      comment: "Indicator whether PA is an appeal of a prior denial"
    - name: "cms_part_d_reportable"
      expr: cms_part_d_reportable
      comment: "Indicator whether PA must be reported to CMS for Part D compliance"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month the prior authorization was requested"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Standardized code for denial reason"
  measures:
    - name: "total_pa_requests"
      expr: COUNT(1)
      comment: "Total number of prior authorization requests"
    - name: "approved_pa_requests"
      expr: SUM(CASE WHEN pa_status = 'approved' THEN 1 ELSE 0 END)
      comment: "Count of approved prior authorization requests"
    - name: "denied_pa_requests"
      expr: SUM(CASE WHEN pa_status = 'denied' THEN 1 ELSE 0 END)
      comment: "Count of denied prior authorization requests"
    - name: "pending_pa_requests"
      expr: SUM(CASE WHEN pa_status = 'pending' THEN 1 ELSE 0 END)
      comment: "Count of pending prior authorization requests"
    - name: "total_approved_quantity"
      expr: SUM(CAST(approved_quantity AS DOUBLE))
      comment: "Total quantity of medication units approved across all PAs"
    - name: "avg_approved_quantity"
      expr: AVG(CAST(approved_quantity AS DOUBLE))
      comment: "Average quantity approved per prior authorization"
    - name: "unique_members_with_pa"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Distinct count of members with prior authorization requests"
    - name: "unique_prescribers"
      expr: COUNT(DISTINCT prescriber_provider_id)
      comment: "Distinct count of prescribers submitting PA requests"
    - name: "unique_drugs_requiring_pa"
      expr: COUNT(DISTINCT drug_master_id)
      comment: "Distinct count of drugs requiring prior authorization"
    - name: "specialty_pa_requests"
      expr: SUM(CASE WHEN specialty_drug_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of prior authorization requests for specialty drugs"
    - name: "step_therapy_required_count"
      expr: SUM(CASE WHEN step_therapy_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of PA requests requiring step therapy"
    - name: "criteria_met_count"
      expr: SUM(CASE WHEN criteria_met = TRUE THEN 1 ELSE 0 END)
      comment: "Count of PA requests where clinical criteria were met"
    - name: "appeal_requests"
      expr: SUM(CASE WHEN appeal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of prior authorization appeals"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`pharmacy_dur_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug utilization review alert metrics tracking clinical safety interventions, override patterns, and pharmacist intervention outcomes"
  source: "`health_insurance_ecm`.`pharmacy`.`dur_alert`"
  dimensions:
    - name: "alert_status"
      expr: alert_status
      comment: "Current status of the DUR alert (active, resolved, overridden, dismissed)"
    - name: "alert_type_code"
      expr: alert_type_code
      comment: "Standardized code for type of DUR alert"
    - name: "alert_type_description"
      expr: alert_type_description
      comment: "Human-readable description of the DUR alert type"
    - name: "severity_level_code"
      expr: severity_level_code
      comment: "Code indicating clinical severity of the alert"
    - name: "severity_level_description"
      expr: severity_level_description
      comment: "Description of the clinical severity level"
    - name: "clinical_significance_code"
      expr: clinical_significance_code
      comment: "Code indicating clinical significance of the interaction or issue"
    - name: "adjudication_outcome"
      expr: adjudication_outcome
      comment: "Final adjudication outcome after DUR alert (approved, denied, modified)"
    - name: "override_code"
      expr: override_code
      comment: "Code indicating reason for overriding the DUR alert"
    - name: "ncpdp_dur_code"
      expr: ncpdp_dur_code
      comment: "NCPDP standardized DUR conflict code"
    - name: "pa_required_flag"
      expr: pa_required_flag
      comment: "Indicator whether prior authorization is required due to DUR alert"
    - name: "quantity_limit_flag"
      expr: quantity_limit_flag
      comment: "Indicator whether quantity limit applies due to DUR alert"
    - name: "step_therapy_flag"
      expr: step_therapy_flag
      comment: "Indicator whether step therapy is required due to DUR alert"
    - name: "dispensing_month"
      expr: DATE_TRUNC('MONTH', dispensing_date)
      comment: "Month the prescription was dispensed"
    - name: "dur_program_type"
      expr: dur_program_type
      comment: "Type of DUR program generating the alert (prospective, retrospective, concurrent)"
  measures:
    - name: "total_dur_alerts"
      expr: COUNT(1)
      comment: "Total number of drug utilization review alerts generated"
    - name: "overridden_alerts"
      expr: SUM(CASE WHEN override_code IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of DUR alerts that were overridden by pharmacist or prescriber"
    - name: "high_severity_alerts"
      expr: SUM(CASE WHEN severity_level_code IN ('high', 'critical', 'severe') THEN 1 ELSE 0 END)
      comment: "Count of high-severity DUR alerts"
    - name: "alerts_requiring_pa"
      expr: SUM(CASE WHEN pa_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of DUR alerts requiring prior authorization"
    - name: "alerts_with_quantity_limit"
      expr: SUM(CASE WHEN quantity_limit_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of DUR alerts triggering quantity limits"
    - name: "alerts_with_step_therapy"
      expr: SUM(CASE WHEN step_therapy_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of DUR alerts requiring step therapy"
    - name: "total_prescribed_quantity"
      expr: SUM(CAST(prescribed_quantity AS DOUBLE))
      comment: "Total quantity prescribed across all DUR alerts"
    - name: "total_dispensed_quantity"
      expr: SUM(CAST(quantity_dispensed AS DOUBLE))
      comment: "Total quantity actually dispensed after DUR review"
    - name: "unique_members_with_alerts"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct count of members with DUR alerts"
    - name: "unique_prescribers_with_alerts"
      expr: COUNT(DISTINCT prescriber_provider_id)
      comment: "Distinct count of prescribers with DUR alerts on their prescriptions"
    - name: "unique_pharmacies_with_alerts"
      expr: COUNT(DISTINCT dispensing_pharmacy_id)
      comment: "Distinct count of pharmacies generating DUR alerts"
    - name: "unique_drugs_with_alerts"
      expr: COUNT(DISTINCT drug_master_id)
      comment: "Distinct count of drugs triggering DUR alerts"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`pharmacy_formulary_drug_tier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Formulary design and drug tier metrics tracking coverage decisions, utilization management requirements, and member cost-sharing structure"
  source: "`health_insurance_ecm`.`pharmacy`.`formulary_drug_tier`"
  dimensions:
    - name: "tier_name"
      expr: tier_name
      comment: "Name of the formulary tier (e.g., Preferred Generic, Non-Preferred Brand, Specialty)"
    - name: "tier_number"
      expr: tier_number
      comment: "Numeric tier level"
    - name: "coverage_status"
      expr: coverage_status
      comment: "Coverage determination status (covered, not covered, conditional)"
    - name: "formulary_status_code"
      expr: formulary_status_code
      comment: "Standardized formulary status code"
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code"
    - name: "benefit_year"
      expr: benefit_year
      comment: "Benefit year for the formulary tier assignment"
    - name: "prior_auth_required"
      expr: prior_auth_required
      comment: "Indicator whether prior authorization is required"
    - name: "quantity_limit_required"
      expr: quantity_limit_required
      comment: "Indicator whether quantity limits apply"
    - name: "step_therapy_required"
      expr: step_therapy_required
      comment: "Indicator whether step therapy is required"
    - name: "specialty_drug_flag"
      expr: specialty_drug_flag
      comment: "Indicator whether drug is classified as specialty"
    - name: "deductible_applies"
      expr: deductible_applies
      comment: "Indicator whether deductible applies to this tier"
    - name: "dispensing_channel"
      expr: dispensing_channel
      comment: "Allowed dispensing channel for the tier"
    - name: "pa_type"
      expr: pa_type
      comment: "Type of prior authorization required"
    - name: "record_status"
      expr: record_status
      comment: "Status of the formulary tier record (active, inactive, pending)"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the tier assignment became effective"
  measures:
    - name: "total_formulary_drugs"
      expr: COUNT(1)
      comment: "Total number of drugs on formulary with tier assignments"
    - name: "drugs_requiring_pa"
      expr: SUM(CASE WHEN prior_auth_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of formulary drugs requiring prior authorization"
    - name: "drugs_with_quantity_limits"
      expr: SUM(CASE WHEN quantity_limit_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of formulary drugs with quantity limits"
    - name: "drugs_with_step_therapy"
      expr: SUM(CASE WHEN step_therapy_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of formulary drugs requiring step therapy"
    - name: "specialty_drugs"
      expr: SUM(CASE WHEN specialty_drug_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of specialty drugs on formulary"
    - name: "avg_retail_30_copay"
      expr: AVG(CAST(copay_retail_30 AS DOUBLE))
      comment: "Average member copay for 30-day retail supply"
    - name: "avg_retail_90_copay"
      expr: AVG(CAST(copay_retail_90 AS DOUBLE))
      comment: "Average member copay for 90-day retail supply"
    - name: "avg_mail_order_copay"
      expr: AVG(CAST(copay_mail_order AS DOUBLE))
      comment: "Average member copay for mail order supply"
    - name: "avg_coinsurance_rate"
      expr: AVG(CAST(coinsurance_rate AS DOUBLE))
      comment: "Average coinsurance rate across formulary tiers"
    - name: "max_quantity_limit"
      expr: MAX(CAST(ql_max_quantity AS DOUBLE))
      comment: "Maximum quantity limit across all formulary drugs"
    - name: "unique_drugs"
      expr: COUNT(DISTINCT drug_master_id)
      comment: "Distinct count of unique drugs on formulary"
    - name: "unique_formularies"
      expr: COUNT(DISTINCT formulary_id)
      comment: "Distinct count of formularies"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`pharmacy_drug_pricing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug pricing and reimbursement metrics tracking AWP discounts, MAC pricing, dispensing fees, and price trend analysis for contract management"
  source: "`health_insurance_ecm`.`pharmacy`.`drug_pricing`"
  dimensions:
    - name: "pricing_status"
      expr: pricing_status
      comment: "Status of the pricing record (active, inactive, pending)"
    - name: "price_type"
      expr: price_type
      comment: "Type of price (AWP, MAC, WAC, RBP)"
    - name: "pricing_source"
      expr: pricing_source
      comment: "Source of pricing data (Medispan, First Databank, Medi-Span, etc.)"
    - name: "mac_methodology"
      expr: mac_methodology
      comment: "Methodology used for Maximum Allowable Cost calculation"
    - name: "mac_list_version"
      expr: mac_list_version
      comment: "Version of the MAC list used"
    - name: "multi_source_code"
      expr: multi_source_code
      comment: "Multi-source code indicating generic availability"
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA controlled substance schedule"
    - name: "dispensing_channel"
      expr: dispensing_channel
      comment: "Dispensing channel for the pricing (retail, mail, specialty)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for pricing"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the pricing became effective"
    - name: "pricing_file_month"
      expr: DATE_TRUNC('MONTH', pricing_file_date)
      comment: "Month of the pricing file"
  measures:
    - name: "total_pricing_records"
      expr: COUNT(1)
      comment: "Total number of drug pricing records"
    - name: "avg_awp_price"
      expr: AVG(CAST(awp_price AS DOUBLE))
      comment: "Average Average Wholesale Price across drugs"
    - name: "avg_wac_price"
      expr: AVG(CAST(wac_price AS DOUBLE))
      comment: "Average Wholesale Acquisition Cost across drugs"
    - name: "avg_mac_price"
      expr: AVG(CAST(mac_price AS DOUBLE))
      comment: "Average Maximum Allowable Cost across drugs"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across all pricing records"
    - name: "avg_dispensing_fee"
      expr: AVG(CAST(dispensing_fee AS DOUBLE))
      comment: "Average dispensing fee across pricing records"
    - name: "avg_awp_discount_pct"
      expr: AVG(CAST(awp_discount_pct AS DOUBLE))
      comment: "Average AWP discount percentage negotiated"
    - name: "avg_price_change_pct"
      expr: AVG(CAST(price_change_pct AS DOUBLE))
      comment: "Average price change percentage period-over-period"
    - name: "total_package_size"
      expr: SUM(CAST(package_size AS DOUBLE))
      comment: "Total package size across all pricing records"
    - name: "unique_drugs_priced"
      expr: COUNT(DISTINCT drug_master_id)
      comment: "Distinct count of drugs with pricing records"
    - name: "unique_fee_schedules"
      expr: COUNT(DISTINCT fee_schedule_id)
      comment: "Distinct count of fee schedules"
    - name: "unique_formularies"
      expr: COUNT(DISTINCT formulary_id)
      comment: "Distinct count of formularies with pricing"
$$;