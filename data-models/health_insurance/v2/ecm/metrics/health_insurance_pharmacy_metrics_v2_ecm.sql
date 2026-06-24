-- Metric views for domain: pharmacy | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 00:30:14

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_benefit_accumulator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit Accumulator business metrics"
  source: "`vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator`"
  dimensions:
    - name: "Accumulator Reset Date"
      expr: accumulator_reset_date
    - name: "Accumulator Source System"
      expr: accumulator_source_system
    - name: "Accumulator Status"
      expr: accumulator_status
    - name: "Accumulator Version"
      expr: accumulator_version
    - name: "Benefit Period End Date"
      expr: benefit_period_end_date
    - name: "Benefit Period Start Date"
      expr: benefit_period_start_date
    - name: "Cms Reconciliation Status"
      expr: cms_reconciliation_status
    - name: "Coordination Of Benefits Type"
      expr: coordination_of_benefits_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Eob Generated Flag"
      expr: eob_generated_flag
    - name: "Formulary Tier Applied"
      expr: formulary_tier_applied
    - name: "Is Deductible Met"
      expr: is_deductible_met
    - name: "Is Moop Met"
      expr: is_moop_met
    - name: "Last Adjudication Timestamp"
      expr: last_adjudication_timestamp
    - name: "Line Of Business"
      expr: line_of_business
    - name: "Lis Level"
      expr: lis_level
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Benefit Accumulator"
      expr: COUNT(DISTINCT benefit_accumulator_id)
    - name: "Total Catastrophic Applied Amt"
      expr: SUM(catastrophic_applied_amt)
    - name: "Average Catastrophic Applied Amt"
      expr: AVG(catastrophic_applied_amt)
    - name: "Total Catastrophic Limit Amt"
      expr: SUM(catastrophic_limit_amt)
    - name: "Average Catastrophic Limit Amt"
      expr: AVG(catastrophic_limit_amt)
    - name: "Total Coverage Gap Discount Applied Amt"
      expr: SUM(coverage_gap_discount_applied_amt)
    - name: "Average Coverage Gap Discount Applied Amt"
      expr: AVG(coverage_gap_discount_applied_amt)
    - name: "Total Deductible Applied Amt"
      expr: SUM(deductible_applied_amt)
    - name: "Average Deductible Applied Amt"
      expr: AVG(deductible_applied_amt)
    - name: "Total Deductible Limit Amt"
      expr: SUM(deductible_limit_amt)
    - name: "Average Deductible Limit Amt"
      expr: AVG(deductible_limit_amt)
    - name: "Total Family Deductible Applied Amt"
      expr: SUM(family_deductible_applied_amt)
    - name: "Average Family Deductible Applied Amt"
      expr: AVG(family_deductible_applied_amt)
    - name: "Total Family Oop Applied Amt"
      expr: SUM(family_oop_applied_amt)
    - name: "Average Family Oop Applied Amt"
      expr: AVG(family_oop_applied_amt)
    - name: "Total Hsa Eligible Applied Amt"
      expr: SUM(hsa_eligible_applied_amt)
    - name: "Average Hsa Eligible Applied Amt"
      expr: AVG(hsa_eligible_applied_amt)
    - name: "Total Icl Applied Amt"
      expr: SUM(icl_applied_amt)
    - name: "Average Icl Applied Amt"
      expr: AVG(icl_applied_amt)
    - name: "Total Icl Limit Amt"
      expr: SUM(icl_limit_amt)
    - name: "Average Icl Limit Amt"
      expr: AVG(icl_limit_amt)
    - name: "Total Lis Copay Tier"
      expr: SUM(lis_copay_tier)
    - name: "Average Lis Copay Tier"
      expr: AVG(lis_copay_tier)
    - name: "Total Mail Order Applied Amt"
      expr: SUM(mail_order_applied_amt)
    - name: "Average Mail Order Applied Amt"
      expr: AVG(mail_order_applied_amt)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_claim_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim Line business metrics"
  source: "`vibe_health_insurance_v1`.`pharmacy`.`claim_line`"
  dimensions:
    - name: "Adjudication Timestamp"
      expr: adjudication_timestamp
    - name: "Catastrophic Coverage Indicator"
      expr: catastrophic_coverage_indicator
    - name: "Cob Sequence"
      expr: cob_sequence
    - name: "Compound Indicator"
      expr: compound_indicator
    - name: "Coverage Gap Indicator"
      expr: coverage_gap_indicator
    - name: "Days Supply"
      expr: days_supply
    - name: "Dispense As Written Code"
      expr: dispense_as_written_code
    - name: "Dispensed Date"
      expr: dispensed_date
    - name: "Drug Coverage Status"
      expr: drug_coverage_status
    - name: "Dur Conflict Code"
      expr: dur_conflict_code
    - name: "Dur Outcome Code"
      expr: dur_outcome_code
    - name: "Fill Number"
      expr: fill_number
    - name: "Formulary Tier"
      expr: formulary_tier
    - name: "Generic Indicator"
      expr: generic_indicator
    - name: "Line Sequence Number"
      expr: line_sequence_number
    - name: "Line Status"
      expr: line_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Claim Line"
      expr: COUNT(DISTINCT claim_line_id)
    - name: "Total Basis Of Cost Determination"
      expr: SUM(basis_of_cost_determination)
    - name: "Average Basis Of Cost Determination"
      expr: AVG(basis_of_cost_determination)
    - name: "Total Dispensing Fee Amount"
      expr: SUM(dispensing_fee_amount)
    - name: "Average Dispensing Fee Amount"
      expr: AVG(dispensing_fee_amount)
    - name: "Total Gross Drug Cost Amount"
      expr: SUM(gross_drug_cost_amount)
    - name: "Average Gross Drug Cost Amount"
      expr: AVG(gross_drug_cost_amount)
    - name: "Total Incentive Amount"
      expr: SUM(incentive_amount)
    - name: "Average Incentive Amount"
      expr: AVG(incentive_amount)
    - name: "Total Ingredient Cost Amount"
      expr: SUM(ingredient_cost_amount)
    - name: "Average Ingredient Cost Amount"
      expr: AVG(ingredient_cost_amount)
    - name: "Total Low Income Subsidy Indicator"
      expr: SUM(low_income_subsidy_indicator)
    - name: "Average Low Income Subsidy Indicator"
      expr: AVG(low_income_subsidy_indicator)
    - name: "Total Manufacturer Discount Amount"
      expr: SUM(manufacturer_discount_amount)
    - name: "Average Manufacturer Discount Amount"
      expr: AVG(manufacturer_discount_amount)
    - name: "Total Other Payer Amount"
      expr: SUM(other_payer_amount)
    - name: "Average Other Payer Amount"
      expr: AVG(other_payer_amount)
    - name: "Total Patient Pay Amount"
      expr: SUM(patient_pay_amount)
    - name: "Average Patient Pay Amount"
      expr: AVG(patient_pay_amount)
    - name: "Total Plan Paid Amount"
      expr: SUM(plan_paid_amount)
    - name: "Average Plan Paid Amount"
      expr: AVG(plan_paid_amount)
    - name: "Total Quantity Dispensed"
      expr: SUM(quantity_dispensed)
    - name: "Average Quantity Dispensed"
      expr: AVG(quantity_dispensed)
    - name: "Total Sales Tax Amount"
      expr: SUM(sales_tax_amount)
    - name: "Average Sales Tax Amount"
      expr: AVG(sales_tax_amount)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_dispensing_pharmacy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dispensing Pharmacy business metrics"
  source: "`vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy`"
  dimensions:
    - name: "Accepts Electronic Prescriptions"
      expr: accepts_electronic_prescriptions
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Chain Independent Flag"
      expr: chain_independent_flag
    - name: "Chain Organization Name"
      expr: chain_organization_name
    - name: "City"
      expr: city
    - name: "Cold Chain Certified"
      expr: cold_chain_certified
    - name: "Contract Effective Date"
      expr: contract_effective_date
    - name: "Contract Termination Date"
      expr: contract_termination_date
    - name: "Contract Type"
      expr: contract_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dispensing State Code"
      expr: dispensing_state_code
    - name: "Doing Business As Name"
      expr: doing_business_as_name
    - name: "Fax Number"
      expr: fax_number
    - name: "Line Of Business"
      expr: line_of_business
    - name: "Mail Order Capable"
      expr: mail_order_capable
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dispensing Pharmacy"
      expr: COUNT(DISTINCT dispensing_pharmacy_id)
    - name: "Total Awp Discount Percent"
      expr: SUM(awp_discount_percent)
    - name: "Average Awp Discount Percent"
      expr: AVG(awp_discount_percent)
    - name: "Total Dispensing Fee Amount"
      expr: SUM(dispensing_fee_amount)
    - name: "Average Dispensing Fee Amount"
      expr: AVG(dispensing_fee_amount)
    - name: "Total Ingredient Cost Basis"
      expr: SUM(ingredient_cost_basis)
    - name: "Average Ingredient Cost Basis"
      expr: AVG(ingredient_cost_basis)
    - name: "Total Ncpdp Provider Number"
      expr: SUM(ncpdp_provider_number)
    - name: "Average Ncpdp Provider Number"
      expr: AVG(ncpdp_provider_number)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_drug_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug Master business metrics"
  source: "`vibe_health_insurance_v1`.`pharmacy`.`drug_master`"
  dimensions:
    - name: "Atc Code"
      expr: atc_code
    - name: "Awp Effective Date"
      expr: awp_effective_date
    - name: "Brand Name"
      expr: brand_name
    - name: "Controlled Substance Schedule"
      expr: controlled_substance_schedule
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dea Number Required"
      expr: dea_number_required
    - name: "Dosage Form"
      expr: dosage_form
    - name: "Drug Class Code"
      expr: drug_class_code
    - name: "Drug Class Name"
      expr: drug_class_name
    - name: "Drug Name"
      expr: drug_name
    - name: "Drug Status"
      expr: drug_status
    - name: "Drug Type"
      expr: drug_type
    - name: "Effective Date"
      expr: effective_date
    - name: "Fda Approval Status"
      expr: fda_approval_status
    - name: "Generic Name"
      expr: generic_name
    - name: "Gpi Code"
      expr: gpi_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Drug Master"
      expr: COUNT(DISTINCT drug_master_id)
    - name: "Total Awp Unit Price"
      expr: SUM(awp_unit_price)
    - name: "Average Awp Unit Price"
      expr: AVG(awp_unit_price)
    - name: "Total Package Size"
      expr: SUM(package_size)
    - name: "Average Package Size"
      expr: AVG(package_size)
    - name: "Total Route Of Administration"
      expr: SUM(route_of_administration)
    - name: "Average Route Of Administration"
      expr: AVG(route_of_administration)
    - name: "Total Wac Unit Price"
      expr: SUM(wac_unit_price)
    - name: "Average Wac Unit Price"
      expr: AVG(wac_unit_price)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_drug_pricing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug Pricing business metrics"
  source: "`vibe_health_insurance_v1`.`pharmacy`.`drug_pricing`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Days Supply"
      expr: days_supply
    - name: "Dea Schedule"
      expr: dea_schedule
    - name: "Dispensing Channel"
      expr: dispensing_channel
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Formulary Tier"
      expr: formulary_tier
    - name: "Mac List Version"
      expr: mac_list_version
    - name: "Mac Methodology"
      expr: mac_methodology
    - name: "Multi Source Code"
      expr: multi_source_code
    - name: "Package Size Uom"
      expr: package_size_uom
    - name: "Pricing File Date"
      expr: pricing_file_date
    - name: "Pricing File Name"
      expr: pricing_file_name
    - name: "Pricing Source"
      expr: pricing_source
    - name: "Pricing Status"
      expr: pricing_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Drug Pricing"
      expr: COUNT(DISTINCT drug_pricing_id)
    - name: "Total Awp Discount Pct"
      expr: SUM(awp_discount_pct)
    - name: "Average Awp Discount Pct"
      expr: AVG(awp_discount_pct)
    - name: "Total Awp Price"
      expr: SUM(awp_price)
    - name: "Average Awp Price"
      expr: AVG(awp_price)
    - name: "Total Dispensing Fee"
      expr: SUM(dispensing_fee)
    - name: "Average Dispensing Fee"
      expr: AVG(dispensing_fee)
    - name: "Total Mac Price"
      expr: SUM(mac_price)
    - name: "Average Mac Price"
      expr: AVG(mac_price)
    - name: "Total Package Size"
      expr: SUM(package_size)
    - name: "Average Package Size"
      expr: AVG(package_size)
    - name: "Total Price Change Pct"
      expr: SUM(price_change_pct)
    - name: "Average Price Change Pct"
      expr: AVG(price_change_pct)
    - name: "Total Price Type"
      expr: SUM(price_type)
    - name: "Average Price Type"
      expr: AVG(price_type)
    - name: "Total Prior Unit Price"
      expr: SUM(prior_unit_price)
    - name: "Average Prior Unit Price"
      expr: AVG(prior_unit_price)
    - name: "Total Rbp Price"
      expr: SUM(rbp_price)
    - name: "Average Rbp Price"
      expr: AVG(rbp_price)
    - name: "Total Unit Price"
      expr: SUM(unit_price)
    - name: "Average Unit Price"
      expr: AVG(unit_price)
    - name: "Total Wac Price"
      expr: SUM(wac_price)
    - name: "Average Wac Price"
      expr: AVG(wac_price)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_drug_rebate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug Rebate business metrics"
  source: "`vibe_health_insurance_v1`.`pharmacy`.`drug_rebate`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Reason"
      expr: dispute_reason
    - name: "Dispute Resolution Date"
      expr: dispute_resolution_date
    - name: "Drug Tier"
      expr: drug_tier
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Invoice Date"
      expr: invoice_date
    - name: "Line Of Business"
      expr: line_of_business
    - name: "Manufacturer Name"
      expr: manufacturer_name
    - name: "Ndc Code"
      expr: ndc_code
    - name: "Part D Indicator"
      expr: part_d_indicator
    - name: "Performance Target Met Indicator"
      expr: performance_target_met_indicator
    - name: "Prior Auth Required Indicator"
      expr: prior_auth_required_indicator
    - name: "Reconciliation Status"
      expr: reconciliation_status
    - name: "Source System Code"
      expr: source_system_code
    - name: "Specialty Drug Indicator"
      expr: specialty_drug_indicator
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Drug Rebate"
      expr: COUNT(DISTINCT drug_rebate_id)
    - name: "Total Awp Unit Price"
      expr: SUM(awp_unit_price)
    - name: "Average Awp Unit Price"
      expr: AVG(awp_unit_price)
    - name: "Total Calculated Rebate Amount"
      expr: SUM(calculated_rebate_amount)
    - name: "Average Calculated Rebate Amount"
      expr: AVG(calculated_rebate_amount)
    - name: "Total Contracted Rebate Rate"
      expr: SUM(contracted_rebate_rate)
    - name: "Average Contracted Rebate Rate"
      expr: AVG(contracted_rebate_rate)
    - name: "Total Invoiced Amount"
      expr: SUM(invoiced_amount)
    - name: "Average Invoiced Amount"
      expr: AVG(invoiced_amount)
    - name: "Total Market Share Pct"
      expr: SUM(market_share_pct)
    - name: "Average Market Share Pct"
      expr: AVG(market_share_pct)
    - name: "Total Mlr Rebate Category"
      expr: SUM(mlr_rebate_category)
    - name: "Average Mlr Rebate Category"
      expr: AVG(mlr_rebate_category)
    - name: "Total Pass Through Amount"
      expr: SUM(pass_through_amount)
    - name: "Average Pass Through Amount"
      expr: AVG(pass_through_amount)
    - name: "Total Payment Due Date"
      expr: SUM(payment_due_date)
    - name: "Average Payment Due Date"
      expr: AVG(payment_due_date)
    - name: "Total Payment Received Date"
      expr: SUM(payment_received_date)
    - name: "Average Payment Received Date"
      expr: AVG(payment_received_date)
    - name: "Total Rebate Invoice Number"
      expr: SUM(rebate_invoice_number)
    - name: "Average Rebate Invoice Number"
      expr: AVG(rebate_invoice_number)
    - name: "Total Rebate Period End Date"
      expr: SUM(rebate_period_end_date)
    - name: "Average Rebate Period End Date"
      expr: AVG(rebate_period_end_date)
    - name: "Total Rebate Period Start Date"
      expr: SUM(rebate_period_start_date)
    - name: "Average Rebate Period Start Date"
      expr: AVG(rebate_period_start_date)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_dur_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dur Alert business metrics"
  source: "`vibe_health_insurance_v1`.`pharmacy`.`dur_alert`"
  dimensions:
    - name: "Adjudication Outcome"
      expr: adjudication_outcome
    - name: "Alert Generated Timestamp"
      expr: alert_generated_timestamp
    - name: "Alert Status"
      expr: alert_status
    - name: "Alert Type Code"
      expr: alert_type_code
    - name: "Alert Type Description"
      expr: alert_type_description
    - name: "Clinical Significance Code"
      expr: clinical_significance_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Days Since Last Fill"
      expr: days_since_last_fill
    - name: "Days Supply"
      expr: days_supply
    - name: "Dispensing Date"
      expr: dispensing_date
    - name: "Dispensing Pharmacy Npi"
      expr: dispensing_pharmacy_npi
    - name: "Drug Database Source"
      expr: drug_database_source
    - name: "Drug Database Version"
      expr: drug_database_version
    - name: "Drug Name"
      expr: drug_name
    - name: "Drug Ndc"
      expr: drug_ndc
    - name: "Dur Program Type"
      expr: dur_program_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dur Alert"
      expr: COUNT(DISTINCT dur_alert_id)
    - name: "Total Prescribed Quantity"
      expr: SUM(prescribed_quantity)
    - name: "Average Prescribed Quantity"
      expr: AVG(prescribed_quantity)
    - name: "Total Quantity Dispensed"
      expr: SUM(quantity_dispensed)
    - name: "Average Quantity Dispensed"
      expr: AVG(quantity_dispensed)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_formulary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Formulary business metrics"
  source: "`vibe_health_insurance_v1`.`pharmacy`.`formulary`"
  dimensions:
    - name: "Formulary Category"
      expr: formulary_category
    - name: "Change Notification Date"
      expr: change_notification_date
    - name: "Cms Formulary Code"
      expr: cms_formulary_code
    - name: "Formulary Code"
      expr: formulary_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Formulary Description"
      expr: formulary_description
    - name: "Drug Count"
      expr: drug_count
    - name: "Drug Utilization Review Ind"
      expr: drug_utilization_review_ind
    - name: "Effective Date"
      expr: effective_date
    - name: "Formulary Status"
      expr: formulary_status
    - name: "Formulary Type"
      expr: formulary_type
    - name: "Generic Substitution Policy"
      expr: generic_substitution_policy
    - name: "Is Aca Compliant"
      expr: is_aca_compliant
    - name: "Is Cms Part D"
      expr: is_cms_part_d
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Lob Code"
      expr: lob_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Formulary"
      expr: COUNT(DISTINCT formulary_id)
    - name: "Total Low Income Subsidy Ind"
      expr: SUM(low_income_subsidy_ind)
    - name: "Average Low Income Subsidy Ind"
      expr: AVG(low_income_subsidy_ind)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_formulary_drug_tier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Formulary Drug Tier business metrics"
  source: "`vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier`"
  dimensions:
    - name: "Benefit Year"
      expr: benefit_year
    - name: "Coverage Status"
      expr: coverage_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dispensing Channel"
      expr: dispensing_channel
    - name: "Drug Tier Change Reason"
      expr: drug_tier_change_reason
    - name: "Dur Alert Type"
      expr: dur_alert_type
    - name: "Effective Date"
      expr: effective_date
    - name: "Formulary Status Code"
      expr: formulary_status_code
    - name: "Lob Code"
      expr: lob_code
    - name: "Mac Pricing Applicable"
      expr: mac_pricing_applicable
    - name: "Ndc Code"
      expr: ndc_code
    - name: "Pa Criteria Description"
      expr: pa_criteria_description
    - name: "Pa Type"
      expr: pa_type
    - name: "Pbm Formulary Code"
      expr: pbm_formulary_code
    - name: "Prior Auth Required"
      expr: prior_auth_required
    - name: "Ql Clinical Basis"
      expr: ql_clinical_basis
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Formulary Drug Tier"
      expr: COUNT(DISTINCT formulary_drug_tier_id)
    - name: "Total Coinsurance Rate"
      expr: SUM(coinsurance_rate)
    - name: "Average Coinsurance Rate"
      expr: AVG(coinsurance_rate)
    - name: "Total Copay Mail Order"
      expr: SUM(copay_mail_order)
    - name: "Average Copay Mail Order"
      expr: AVG(copay_mail_order)
    - name: "Total Copay Retail 30"
      expr: SUM(copay_retail_30)
    - name: "Average Copay Retail 30"
      expr: AVG(copay_retail_30)
    - name: "Total Copay Retail 90"
      expr: SUM(copay_retail_90)
    - name: "Average Copay Retail 90"
      expr: AVG(copay_retail_90)
    - name: "Total Deductible Applies"
      expr: SUM(deductible_applies)
    - name: "Average Deductible Applies"
      expr: AVG(deductible_applies)
    - name: "Total Ql Max Quantity"
      expr: SUM(ql_max_quantity)
    - name: "Average Ql Max Quantity"
      expr: AVG(ql_max_quantity)
    - name: "Total St Clinical Rationale"
      expr: SUM(st_clinical_rationale)
    - name: "Average St Clinical Rationale"
      expr: AVG(st_clinical_rationale)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_formulary_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Formulary Exception business metrics"
  source: "`vibe_health_insurance_v1`.`pharmacy`.`formulary_exception`"
  dimensions:
    - name: "Appeal Rights Notification Date"
      expr: appeal_rights_notification_date
    - name: "Appeal Rights Notified"
      expr: appeal_rights_notified
    - name: "Clinical Justification"
      expr: clinical_justification
    - name: "Cms Coverage Determination Type"
      expr: cms_coverage_determination_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Current Drug Tier"
      expr: current_drug_tier
    - name: "Days Supply Requested"
      expr: days_supply_requested
    - name: "Decision Date"
      expr: decision_date
    - name: "Decision Timestamp"
      expr: decision_timestamp
    - name: "Denial Reason Code"
      expr: denial_reason_code
    - name: "Denial Reason Description"
      expr: denial_reason_description
    - name: "Diagnosis Code"
      expr: diagnosis_code
    - name: "Drug Name"
      expr: drug_name
    - name: "Drug Ndc"
      expr: drug_ndc
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Formulary Exception"
      expr: COUNT(DISTINCT formulary_exception_id)
    - name: "Total Quantity Requested"
      expr: SUM(quantity_requested)
    - name: "Average Quantity Requested"
      expr: AVG(quantity_requested)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_mac_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mac List business metrics"
  source: "`vibe_health_insurance_v1`.`pharmacy`.`mac_list`"
  dimensions:
    - name: "Brand Name"
      expr: brand_name
    - name: "Dosage Form"
      expr: dosage_form
    - name: "Dosage Strength Unit"
      expr: dosage_strength_unit
    - name: "Drug Category"
      expr: drug_category
    - name: "Drug Class"
      expr: drug_class
    - name: "Drug Code"
      expr: drug_code
    - name: "Drug Code Description"
      expr: drug_code_description
    - name: "Drug Code Type"
      expr: drug_code_type
    - name: "Drug Description"
      expr: drug_description
    - name: "Drug Form Code"
      expr: drug_form_code
    - name: "Drug Form Description"
      expr: drug_form_description
    - name: "Drug Name"
      expr: drug_name
    - name: "Drug Status"
      expr: drug_status
    - name: "Drug Strength Code"
      expr: drug_strength_code
    - name: "Drug Strength Description"
      expr: drug_strength_description
    - name: "Drug Therapeutic Class Code"
      expr: drug_therapeutic_class_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Mac List"
      expr: COUNT(DISTINCT mac_list_id)
    - name: "Total Dosage Strength Value"
      expr: SUM(dosage_strength_value)
    - name: "Average Dosage Strength Value"
      expr: AVG(dosage_strength_value)
    - name: "Total Mac Price"
      expr: SUM(mac_price)
    - name: "Average Mac Price"
      expr: AVG(mac_price)
    - name: "Total Mac Unit Price"
      expr: SUM(mac_unit_price)
    - name: "Average Mac Unit Price"
      expr: AVG(mac_unit_price)
    - name: "Total Mac Value"
      expr: SUM(mac_value)
    - name: "Average Mac Value"
      expr: AVG(mac_value)
    - name: "Total Package Size Value"
      expr: SUM(package_size_value)
    - name: "Average Package Size Value"
      expr: AVG(package_size_value)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_mtm_service`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mtm Service business metrics"
  source: "`vibe_health_insurance_v1`.`pharmacy`.`mtm_service`"
  dimensions:
    - name: "Chronic Condition Count"
      expr: chronic_condition_count
    - name: "Cmr Completion Date"
      expr: cmr_completion_date
    - name: "Cms Reporting Period"
      expr: cms_reporting_period
    - name: "Contact Attempt Count"
      expr: contact_attempt_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Disenrollment Date"
      expr: disenrollment_date
    - name: "Drug Therapy Problem Type"
      expr: drug_therapy_problem_type
    - name: "Dur Outcome Code"
      expr: dur_outcome_code
    - name: "Eligibility Determination Date"
      expr: eligibility_determination_date
    - name: "Enrollment Date"
      expr: enrollment_date
    - name: "Follow Up Date"
      expr: follow_up_date
    - name: "Follow Up Required Flag"
      expr: follow_up_required_flag
    - name: "Follow Up Status"
      expr: follow_up_status
    - name: "Intervention Count"
      expr: intervention_count
    - name: "Last Contact Attempt Date"
      expr: last_contact_attempt_date
    - name: "Map Item Count"
      expr: map_item_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Mtm Service"
      expr: COUNT(DISTINCT mtm_service_id)
    - name: "Total Estimated Annual Drug Cost"
      expr: SUM(estimated_annual_drug_cost)
    - name: "Average Estimated Annual Drug Cost"
      expr: AVG(estimated_annual_drug_cost)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_part_d_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Part D Submission business metrics"
  source: "`vibe_health_insurance_v1`.`pharmacy`.`part_d_submission`"
  dimensions:
    - name: "Accepted Record Count"
      expr: accepted_record_count
    - name: "Batch Number"
      expr: batch_number
    - name: "Benefit Year"
      expr: benefit_year
    - name: "Clearinghouse Tracking Number"
      expr: clearinghouse_tracking_number
    - name: "Cms Contract Number"
      expr: cms_contract_number
    - name: "Cms Region Code"
      expr: cms_region_code
    - name: "Cms Response Code"
      expr: cms_response_code
    - name: "Cms Response Date"
      expr: cms_response_date
    - name: "Cms Response Description"
      expr: cms_response_description
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Edi Interchange Control Number"
      expr: edi_interchange_control_number
    - name: "Error Detail"
      expr: error_detail
    - name: "Hcc Record Count"
      expr: hcc_record_count
    - name: "Is Resubmission"
      expr: is_resubmission
    - name: "Is Timely Submission"
      expr: is_timely_submission
    - name: "Line Of Business"
      expr: line_of_business
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Part D Submission"
      expr: COUNT(DISTINCT part_d_submission_id)
    - name: "Total Cgdp Invoice Amount"
      expr: SUM(cgdp_invoice_amount)
    - name: "Average Cgdp Invoice Amount"
      expr: AVG(cgdp_invoice_amount)
    - name: "Total Dir Amount"
      expr: SUM(dir_amount)
    - name: "Average Dir Amount"
      expr: AVG(dir_amount)
    - name: "Total Raf Impact Amount"
      expr: SUM(raf_impact_amount)
    - name: "Average Raf Impact Amount"
      expr: AVG(raf_impact_amount)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_pbm_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pbm Contract business metrics"
  source: "`vibe_health_insurance_v1`.`pharmacy`.`pbm_contract`"
  dimensions:
    - name: "Amendment Date"
      expr: amendment_date
    - name: "Audit Frequency"
      expr: audit_frequency
    - name: "Audit Rights Flag"
      expr: audit_rights_flag
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Cms Contract Number"
      expr: cms_contract_number
    - name: "Contract Name"
      expr: contract_name
    - name: "Contract Number"
      expr: contract_number
    - name: "Contract Owner Name"
      expr: contract_owner_name
    - name: "Contract Status"
      expr: contract_status
    - name: "Contract Type"
      expr: contract_type
    - name: "Contract Version"
      expr: contract_version
    - name: "Dur Program Flag"
      expr: dur_program_flag
    - name: "Effective Date"
      expr: effective_date
    - name: "Governing State Code"
      expr: governing_state_code
    - name: "Lob Scope"
      expr: lob_scope
    - name: "Mac List Reference"
      expr: mac_list_reference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pbm Contract"
      expr: COUNT(DISTINCT pbm_contract_id)
    - name: "Total Awp Discount Mail Pct"
      expr: SUM(awp_discount_mail_pct)
    - name: "Average Awp Discount Mail Pct"
      expr: AVG(awp_discount_mail_pct)
    - name: "Total Awp Discount Retail Pct"
      expr: SUM(awp_discount_retail_pct)
    - name: "Average Awp Discount Retail Pct"
      expr: AVG(awp_discount_retail_pct)
    - name: "Total Dispensing Fee Mail Order"
      expr: SUM(dispensing_fee_mail_order)
    - name: "Average Dispensing Fee Mail Order"
      expr: AVG(dispensing_fee_mail_order)
    - name: "Total Dispensing Fee Retail"
      expr: SUM(dispensing_fee_retail)
    - name: "Average Dispensing Fee Retail"
      expr: AVG(dispensing_fee_retail)
    - name: "Total Dispensing Fee Specialty"
      expr: SUM(dispensing_fee_specialty)
    - name: "Average Dispensing Fee Specialty"
      expr: AVG(dispensing_fee_specialty)
    - name: "Total Generic Dispensing Rate Guarantee"
      expr: SUM(generic_dispensing_rate_guarantee)
    - name: "Average Generic Dispensing Rate Guarantee"
      expr: AVG(generic_dispensing_rate_guarantee)
    - name: "Total Ingredient Cost Basis"
      expr: SUM(ingredient_cost_basis)
    - name: "Average Ingredient Cost Basis"
      expr: AVG(ingredient_cost_basis)
    - name: "Total Mail Order Penetration Guarantee"
      expr: SUM(mail_order_penetration_guarantee)
    - name: "Average Mail Order Penetration Guarantee"
      expr: AVG(mail_order_penetration_guarantee)
    - name: "Total Rebate Guarantee Pmpm"
      expr: SUM(rebate_guarantee_pmpm)
    - name: "Average Rebate Guarantee Pmpm"
      expr: AVG(rebate_guarantee_pmpm)
    - name: "Total Rebate Pass Through Pct"
      expr: SUM(rebate_pass_through_pct)
    - name: "Average Rebate Pass Through Pct"
      expr: AVG(rebate_pass_through_pct)
    - name: "Total Rebate Reconciliation Lag Days"
      expr: SUM(rebate_reconciliation_lag_days)
    - name: "Average Rebate Reconciliation Lag Days"
      expr: AVG(rebate_reconciliation_lag_days)
    - name: "Total Rebate Settlement Frequency"
      expr: SUM(rebate_settlement_frequency)
    - name: "Average Rebate Settlement Frequency"
      expr: AVG(rebate_settlement_frequency)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_pharmacy_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy Claim business metrics"
  source: "`vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim`"
  dimensions:
    - name: "Adjudication Timestamp"
      expr: adjudication_timestamp
    - name: "Claim Number"
      expr: claim_number
    - name: "Claim Status"
      expr: claim_status
    - name: "Cob Indicator"
      expr: cob_indicator
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Daw Code"
      expr: daw_code
    - name: "Days Supply"
      expr: days_supply
    - name: "Dispensing Pharmacy Npi"
      expr: dispensing_pharmacy_npi
    - name: "Dur Outcome Code"
      expr: dur_outcome_code
    - name: "Fhir Medication"
      expr: fhir_medication
    - name: "Fhir Quantity"
      expr: fhir_quantity
    - name: "Fhir Status"
      expr: fhir_status
    - name: "Fhir Subject"
      expr: fhir_subject
    - name: "Fill Date"
      expr: fill_date
    - name: "Formulary Tier"
      expr: formulary_tier
    - name: "Is 340b Claim"
      expr: is_340b_claim
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pharmacy Claim"
      expr: COUNT(DISTINCT pharmacy_claim_id)
    - name: "Total Basis Of Cost Determination"
      expr: SUM(basis_of_cost_determination)
    - name: "Average Basis Of Cost Determination"
      expr: AVG(basis_of_cost_determination)
    - name: "Total Deductible Applied"
      expr: SUM(deductible_applied)
    - name: "Average Deductible Applied"
      expr: AVG(deductible_applied)
    - name: "Total Dispensing Fee"
      expr: SUM(dispensing_fee)
    - name: "Average Dispensing Fee"
      expr: AVG(dispensing_fee)
    - name: "Total Ingredient Cost"
      expr: SUM(ingredient_cost)
    - name: "Average Ingredient Cost"
      expr: AVG(ingredient_cost)
    - name: "Total Member Coinsurance"
      expr: SUM(member_coinsurance)
    - name: "Average Member Coinsurance"
      expr: AVG(member_coinsurance)
    - name: "Total Member Copay"
      expr: SUM(member_copay)
    - name: "Average Member Copay"
      expr: AVG(member_copay)
    - name: "Total Other Payer Amount"
      expr: SUM(other_payer_amount)
    - name: "Average Other Payer Amount"
      expr: AVG(other_payer_amount)
    - name: "Total Plan Paid Amount"
      expr: SUM(plan_paid_amount)
    - name: "Average Plan Paid Amount"
      expr: AVG(plan_paid_amount)
    - name: "Total Quantity Dispensed"
      expr: SUM(quantity_dispensed)
    - name: "Average Quantity Dispensed"
      expr: AVG(quantity_dispensed)
    - name: "Total Sales Tax"
      expr: SUM(sales_tax)
    - name: "Average Sales Tax"
      expr: AVG(sales_tax)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_pharmacy_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy Contract business metrics"
  source: "`vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract`"
  dimensions:
    - name: "Accreditation Type"
      expr: accreditation_type
    - name: "Audit Frequency"
      expr: audit_frequency
    - name: "Audit Rights Indicator"
      expr: audit_rights_indicator
    - name: "Auto Renewal Indicator"
      expr: auto_renewal_indicator
    - name: "Contract Number"
      expr: contract_number
    - name: "Contract Status"
      expr: contract_status
    - name: "Contract Type"
      expr: contract_type
    - name: "Credentialing Required Indicator"
      expr: credentialing_required_indicator
    - name: "Days Supply Mail Max"
      expr: days_supply_mail_max
    - name: "Days Supply Retail Max"
      expr: days_supply_retail_max
    - name: "Dispensing Channel"
      expr: dispensing_channel
    - name: "Effective Date"
      expr: effective_date
    - name: "Executed Date"
      expr: executed_date
    - name: "Last Amended Date"
      expr: last_amended_date
    - name: "Line Of Business"
      expr: line_of_business
    - name: "Mail Order Indicator"
      expr: mail_order_indicator
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pharmacy Contract"
      expr: COUNT(DISTINCT pharmacy_contract_id)
    - name: "Total Awp Discount Pct"
      expr: SUM(awp_discount_pct)
    - name: "Average Awp Discount Pct"
      expr: AVG(awp_discount_pct)
    - name: "Total Dispensing Fee Mail Order"
      expr: SUM(dispensing_fee_mail_order)
    - name: "Average Dispensing Fee Mail Order"
      expr: AVG(dispensing_fee_mail_order)
    - name: "Total Dispensing Fee Retail"
      expr: SUM(dispensing_fee_retail)
    - name: "Average Dispensing Fee Retail"
      expr: AVG(dispensing_fee_retail)
    - name: "Total Dispensing Fee Specialty"
      expr: SUM(dispensing_fee_specialty)
    - name: "Average Dispensing Fee Specialty"
      expr: AVG(dispensing_fee_specialty)
    - name: "Total Generic Awp Discount Pct"
      expr: SUM(generic_awp_discount_pct)
    - name: "Average Generic Awp Discount Pct"
      expr: AVG(generic_awp_discount_pct)
    - name: "Total Generic Dispensing Rate Target"
      expr: SUM(generic_dispensing_rate_target)
    - name: "Average Generic Dispensing Rate Target"
      expr: AVG(generic_dispensing_rate_target)
    - name: "Total Ingredient Cost Basis"
      expr: SUM(ingredient_cost_basis)
    - name: "Average Ingredient Cost Basis"
      expr: AVG(ingredient_cost_basis)
    - name: "Total Ncpdp Provider Number"
      expr: SUM(ncpdp_provider_number)
    - name: "Average Ncpdp Provider Number"
      expr: AVG(ncpdp_provider_number)
    - name: "Total Wac Discount Pct"
      expr: SUM(wac_discount_pct)
    - name: "Average Wac Discount Pct"
      expr: AVG(wac_discount_pct)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_prior_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior Authorization business metrics"
  source: "`vibe_health_insurance_v1`.`pharmacy`.`prior_authorization`"
  dimensions:
    - name: "Appeal Indicator"
      expr: appeal_indicator
    - name: "Approved Days Supply"
      expr: approved_days_supply
    - name: "Approved Refills"
      expr: approved_refills
    - name: "Clinical Criteria Code"
      expr: clinical_criteria_code
    - name: "Clinical Criteria Version"
      expr: clinical_criteria_version
    - name: "Cms Part D Reportable"
      expr: cms_part_d_reportable
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Criteria Met"
      expr: criteria_met
    - name: "Decision Timestamp"
      expr: decision_timestamp
    - name: "Denial Reason Code"
      expr: denial_reason_code
    - name: "Denial Reason Description"
      expr: denial_reason_description
    - name: "Dispensing Channel"
      expr: dispensing_channel
    - name: "Drug Ndc"
      expr: drug_ndc
    - name: "Drug Tier"
      expr: drug_tier
    - name: "Dur Outcome Code"
      expr: dur_outcome_code
    - name: "Effective End Date"
      expr: effective_end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Prior Authorization"
      expr: COUNT(DISTINCT prior_authorization_id)
    - name: "Total Approved Quantity"
      expr: SUM(approved_quantity)
    - name: "Average Approved Quantity"
      expr: AVG(approved_quantity)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_specialty_drug_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Specialty Drug Program business metrics"
  source: "`vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program`"
  dimensions:
    - name: "Accumulator Adjustment Flag"
      expr: accumulator_adjustment_flag
    - name: "Clinical Management Required Flag"
      expr: clinical_management_required_flag
    - name: "Cms Part D Specialty Tier Flag"
      expr: cms_part_d_specialty_tier_flag
    - name: "Cold Chain Required Flag"
      expr: cold_chain_required_flag
    - name: "Copay Assistance Flag"
      expr: copay_assistance_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Drug Utilization Review Type"
      expr: drug_utilization_review_type
    - name: "Effective Date"
      expr: effective_date
    - name: "Foundation Grant Flag"
      expr: foundation_grant_flag
    - name: "Hub Services Enrollment Flag"
      expr: hub_services_enrollment_flag
    - name: "Icd Condition Codes"
      expr: icd_condition_codes
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Limited Distribution Flag"
      expr: limited_distribution_flag
    - name: "Line Of Business"
      expr: line_of_business
    - name: "Mail Order Allowed Flag"
      expr: mail_order_allowed_flag
    - name: "Max Days Supply"
      expr: max_days_supply
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Specialty Drug Program"
      expr: COUNT(DISTINCT specialty_drug_program_id)
    - name: "Total Awp Discount Pct"
      expr: SUM(awp_discount_pct)
    - name: "Average Awp Discount Pct"
      expr: AVG(awp_discount_pct)
    - name: "Total Copay Assistance Max Benefit Amount"
      expr: SUM(copay_assistance_max_benefit_amount)
    - name: "Average Copay Assistance Max Benefit Amount"
      expr: AVG(copay_assistance_max_benefit_amount)
    - name: "Total Copay Assistance Program Name"
      expr: SUM(copay_assistance_program_name)
    - name: "Average Copay Assistance Program Name"
      expr: AVG(copay_assistance_program_name)
    - name: "Total Dispensing Fee Amount"
      expr: SUM(dispensing_fee_amount)
    - name: "Average Dispensing Fee Amount"
      expr: AVG(dispensing_fee_amount)
    - name: "Total Wac Discount Pct"
      expr: SUM(wac_discount_pct)
    - name: "Average Wac Discount Pct"
      expr: AVG(wac_discount_pct)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`pharmacy_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core pharmacy claims metrics covering cost, utilization, member cost-sharing, and operational KPIs for pharmacy benefit management."
  source: "`vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim`"
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