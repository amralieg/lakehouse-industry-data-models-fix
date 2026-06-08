-- Metric views for domain: employer | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 21:24:43

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`employer_broker`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Broker business metrics"
  source: "`health_insurance_ecm`.`employer`.`broker`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Agreement End Date"
      expr: agreement_end_date
    - name: "Agreement Start Date"
      expr: agreement_start_date
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Terms"
      expr: agreement_terms
    - name: "Broker Name"
      expr: broker_name
    - name: "Broker Status"
      expr: broker_status
    - name: "Broker Type"
      expr: broker_type
    - name: "City"
      expr: city
    - name: "Commission Currency"
      expr: commission_currency
    - name: "Commission End Date"
      expr: commission_end_date
    - name: "Commission Start Date"
      expr: commission_start_date
    - name: "Country"
      expr: country
    - name: "Email"
      expr: email
    - name: "End Date"
      expr: end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Broker"
      expr: COUNT(DISTINCT broker_id)
    - name: "Total Commission Amount"
      expr: SUM(commission_amount)
    - name: "Average Commission Amount"
      expr: AVG(commission_amount)
    - name: "Total Commission Rate"
      expr: SUM(commission_rate)
    - name: "Average Commission Rate"
      expr: AVG(commission_rate)
    - name: "Total Rating"
      expr: SUM(rating)
    - name: "Average Rating"
      expr: AVG(rating)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`employer_broker_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Broker Assignment business metrics"
  source: "`health_insurance_ecm`.`employer`.`broker_assignment`"
  dimensions:
    - name: "Agency Name"
      expr: agency_name
    - name: "Broker Assignment Status"
      expr: broker_assignment_status
    - name: "Commission Basis"
      expr: commission_basis
    - name: "Commission Type"
      expr: commission_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Is Primary"
      expr: is_primary
    - name: "Notes"
      expr: notes
    - name: "Source System"
      expr: source_system
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Broker Assignment"
      expr: COUNT(DISTINCT broker_assignment_id)
    - name: "Total Commission Rate"
      expr: SUM(commission_rate)
    - name: "Average Commission Rate"
      expr: AVG(commission_rate)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`employer_contribution_strategy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contribution Strategy business metrics"
  source: "`health_insurance_ecm`.`employer`.`contribution_strategy`"
  dimensions:
    - name: "Affordability Test Flag"
      expr: affordability_test_flag
    - name: "Contribution Code"
      expr: contribution_code
    - name: "Contribution Frequency"
      expr: contribution_frequency
    - name: "Contribution Rule Name"
      expr: contribution_rule_name
    - name: "Contribution Strategy Status"
      expr: contribution_strategy_status
    - name: "Contribution Type"
      expr: contribution_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Eligibility Criteria"
      expr: eligibility_criteria
    - name: "Is Post Tax"
      expr: is_post_tax
    - name: "Is Pre Tax"
      expr: is_pre_tax
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Notes"
      expr: notes
    - name: "Review Status"
      expr: review_status
    - name: "Tax Credit Eligible"
      expr: tax_credit_eligible
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Contribution Strategy"
      expr: COUNT(DISTINCT contribution_strategy_id)
    - name: "Total Contribution Amount"
      expr: SUM(contribution_amount)
    - name: "Average Contribution Amount"
      expr: AVG(contribution_amount)
    - name: "Total Contribution Percentage"
      expr: SUM(contribution_percentage)
    - name: "Average Contribution Percentage"
      expr: AVG(contribution_percentage)
    - name: "Total Employer Contribution Cap"
      expr: SUM(employer_contribution_cap)
    - name: "Average Employer Contribution Cap"
      expr: AVG(employer_contribution_cap)
    - name: "Total Hra Employer Seed Amount"
      expr: SUM(hra_employer_seed_amount)
    - name: "Average Hra Employer Seed Amount"
      expr: AVG(hra_employer_seed_amount)
    - name: "Total Hsa Employer Seed Amount"
      expr: SUM(hsa_employer_seed_amount)
    - name: "Average Hsa Employer Seed Amount"
      expr: AVG(hsa_employer_seed_amount)
    - name: "Total Maximum Employee Contribution"
      expr: SUM(maximum_employee_contribution)
    - name: "Average Maximum Employee Contribution"
      expr: AVG(maximum_employee_contribution)
    - name: "Total Minimum Employee Contribution"
      expr: SUM(minimum_employee_contribution)
    - name: "Average Minimum Employee Contribution"
      expr: AVG(minimum_employee_contribution)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`employer_employer_underwriting_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employer Underwriting Case business metrics"
  source: "`health_insurance_ecm`.`employer`.`employer_underwriting_case`"
  dimensions:
    - name: "Actuarial Basis Document"
      expr: actuarial_basis_document
    - name: "Case Number"
      expr: case_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Group Census Size"
      expr: group_census_size
    - name: "Industry Risk Factor"
      expr: industry_risk_factor
    - name: "Manual Rate Basis"
      expr: manual_rate_basis
    - name: "Prior Carrier Loss Experience"
      expr: prior_carrier_loss_experience
    - name: "Quote Expiration Timestamp"
      expr: quote_expiration_timestamp
    - name: "Quote Generated Timestamp"
      expr: quote_generated_timestamp
    - name: "Quote Status"
      expr: quote_status
    - name: "Rating Area Code"
      expr: rating_area_code
    - name: "Rating Methodology"
      expr: rating_methodology
    - name: "Risk Tier"
      expr: risk_tier
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Employer Underwriting Case"
      expr: COUNT(DISTINCT employer_underwriting_case_id)
    - name: "Total Aca Adjustment Factor"
      expr: SUM(aca_adjustment_factor)
    - name: "Average Aca Adjustment Factor"
      expr: AVG(aca_adjustment_factor)
    - name: "Total Age Gender Composite Factor"
      expr: SUM(age_gender_composite_factor)
    - name: "Average Age Gender Composite Factor"
      expr: AVG(age_gender_composite_factor)
    - name: "Total Experience Rating Factor"
      expr: SUM(experience_rating_factor)
    - name: "Average Experience Rating Factor"
      expr: AVG(experience_rating_factor)
    - name: "Total Geographic Factor"
      expr: SUM(geographic_factor)
    - name: "Average Geographic Factor"
      expr: AVG(geographic_factor)
    - name: "Total Group Average Age"
      expr: SUM(group_average_age)
    - name: "Average Group Average Age"
      expr: AVG(group_average_age)
    - name: "Total Group Female Percentage"
      expr: SUM(group_female_percentage)
    - name: "Average Group Female Percentage"
      expr: AVG(group_female_percentage)
    - name: "Total Pmpm Estimate"
      expr: SUM(pmpm_estimate)
    - name: "Average Pmpm Estimate"
      expr: AVG(pmpm_estimate)
    - name: "Total Total Premium Estimate"
      expr: SUM(total_premium_estimate)
    - name: "Average Total Premium Estimate"
      expr: AVG(total_premium_estimate)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`employer_group`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group business metrics"
  source: "`health_insurance_ecm`.`employer`.`group`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "City"
      expr: city
    - name: "Contribution Strategy"
      expr: contribution_strategy
    - name: "Country"
      expr: country
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dba Name"
      expr: dba_name
    - name: "Domicile State"
      expr: domicile_state
    - name: "Effective Date"
      expr: effective_date
    - name: "Email Address"
      expr: email_address
    - name: "Enrollment Count Ec"
      expr: enrollment_count_ec
    - name: "Enrollment Count Ef"
      expr: enrollment_count_ef
    - name: "Enrollment Count Eo"
      expr: enrollment_count_eo
    - name: "Enrollment Count Es"
      expr: enrollment_count_es
    - name: "Erisa Status"
      expr: erisa_status
    - name: "Funding Arrangement"
      expr: funding_arrangement
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Group"
      expr: COUNT(DISTINCT group_id)
    - name: "Total Average Claim Cost"
      expr: SUM(average_claim_cost)
    - name: "Average Average Claim Cost"
      expr: AVG(average_claim_cost)
    - name: "Total Gfc Code"
      expr: SUM(gfc_code)
    - name: "Average Gfc Code"
      expr: AVG(gfc_code)
    - name: "Total Risk Adjustment Factor"
      expr: SUM(risk_adjustment_factor)
    - name: "Average Risk Adjustment Factor"
      expr: AVG(risk_adjustment_factor)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`employer_group_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group Contact business metrics"
  source: "`health_insurance_ecm`.`employer`.`group_contact`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Authorization Level"
      expr: authorization_level
    - name: "Can Bill"
      expr: can_bill
    - name: "Can Enroll"
      expr: can_enroll
    - name: "City"
      expr: city
    - name: "Contact Type"
      expr: contact_type
    - name: "Country"
      expr: country
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Department"
      expr: department
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Email"
      expr: email
    - name: "First Name"
      expr: first_name
    - name: "Full Name"
      expr: full_name
    - name: "Group Contact Status"
      expr: group_contact_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Group Contact"
      expr: COUNT(DISTINCT group_contact_id)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`employer_group_division`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group Division business metrics"
  source: "`health_insurance_ecm`.`employer`.`group_division`"
  dimensions:
    - name: "Billing Entity Flag"
      expr: billing_entity_flag
    - name: "Classification"
      expr: classification
    - name: "Contribution Strategy"
      expr: contribution_strategy
    - name: "Covered Member Count"
      expr: covered_member_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Division Code"
      expr: division_code
    - name: "Division Name"
      expr: division_name
    - name: "Division Type"
      expr: division_type
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Eligibility Rule Set"
      expr: eligibility_rule_set
    - name: "Employee Count"
      expr: employee_count
    - name: "Group Division Status"
      expr: group_division_status
    - name: "Is Eligible For Flex Spending"
      expr: is_eligible_for_flex_spending
    - name: "Is Eligible For Fsa"
      expr: is_eligible_for_fsa
    - name: "Is Eligible For Hsa"
      expr: is_eligible_for_hsa
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Group Division"
      expr: COUNT(DISTINCT group_division_id)
    - name: "Total Contribution Amount"
      expr: SUM(contribution_amount)
    - name: "Average Contribution Amount"
      expr: AVG(contribution_amount)
    - name: "Total Contribution Percent"
      expr: SUM(contribution_percent)
    - name: "Average Contribution Percent"
      expr: AVG(contribution_percent)
    - name: "Total Flex Spending Amount"
      expr: SUM(flex_spending_amount)
    - name: "Average Flex Spending Amount"
      expr: AVG(flex_spending_amount)
    - name: "Total Fsa Contribution Amount"
      expr: SUM(fsa_contribution_amount)
    - name: "Average Fsa Contribution Amount"
      expr: AVG(fsa_contribution_amount)
    - name: "Total Hsa Contribution Amount"
      expr: SUM(hsa_contribution_amount)
    - name: "Average Hsa Contribution Amount"
      expr: AVG(hsa_contribution_amount)
    - name: "Total Subsidy Amount"
      expr: SUM(subsidy_amount)
    - name: "Average Subsidy Amount"
      expr: AVG(subsidy_amount)
    - name: "Total Subsidy Percent"
      expr: SUM(subsidy_percent)
    - name: "Average Subsidy Percent"
      expr: AVG(subsidy_percent)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`employer_group_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group Location business metrics"
  source: "`health_insurance_ecm`.`employer`.`group_location`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Address Type"
      expr: address_type
    - name: "City"
      expr: city
    - name: "Country Code"
      expr: country_code
    - name: "County Fips"
      expr: county_fips
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Geocode Accuracy"
      expr: geocode_accuracy
    - name: "Group Location Status"
      expr: group_location_status
    - name: "Is Primary"
      expr: is_primary
    - name: "Location Code"
      expr: location_code
    - name: "Location Name"
      expr: location_name
    - name: "Notes"
      expr: notes
    - name: "Rating Area"
      expr: rating_area
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Group Location"
      expr: COUNT(DISTINCT group_location_id)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`employer_group_plan_offering`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group Plan Offering business metrics"
  source: "`health_insurance_ecm`.`employer`.`group_plan_offering`"
  dimensions:
    - name: "Contribution Effective End Date"
      expr: contribution_effective_end_date
    - name: "Contribution Effective Start Date"
      expr: contribution_effective_start_date
    - name: "Contribution Strategy Description"
      expr: contribution_strategy_description
    - name: "Contribution Tier"
      expr: contribution_tier
    - name: "Contribution Type"
      expr: contribution_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Group Plan Offering Status"
      expr: group_plan_offering_status
    - name: "Is Affordable"
      expr: is_affordable
    - name: "Measurement Period End"
      expr: measurement_period_end
    - name: "Measurement Period Start"
      expr: measurement_period_start
    - name: "Minimum Enrolled Headcount"
      expr: minimum_enrolled_headcount
    - name: "Offering Code"
      expr: offering_code
    - name: "Offering Description"
      expr: offering_description
    - name: "Offering Name"
      expr: offering_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Group Plan Offering"
      expr: COUNT(DISTINCT group_plan_offering_id)
    - name: "Total Contribution Amount"
      expr: SUM(contribution_amount)
    - name: "Average Contribution Amount"
      expr: AVG(contribution_amount)
    - name: "Total Contribution Percent"
      expr: SUM(contribution_percent)
    - name: "Average Contribution Percent"
      expr: AVG(contribution_percent)
    - name: "Total Employee Contribution Amount"
      expr: SUM(employee_contribution_amount)
    - name: "Average Employee Contribution Amount"
      expr: AVG(employee_contribution_amount)
    - name: "Total Family Contribution Amount"
      expr: SUM(family_contribution_amount)
    - name: "Average Family Contribution Amount"
      expr: AVG(family_contribution_amount)
    - name: "Total Hra Seed Amount"
      expr: SUM(hra_seed_amount)
    - name: "Average Hra Seed Amount"
      expr: AVG(hra_seed_amount)
    - name: "Total Hsa Seed Amount"
      expr: SUM(hsa_seed_amount)
    - name: "Average Hsa Seed Amount"
      expr: AVG(hsa_seed_amount)
    - name: "Total Minimum Participation Percent"
      expr: SUM(minimum_participation_percent)
    - name: "Average Minimum Participation Percent"
      expr: AVG(minimum_participation_percent)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`employer_group_renewal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group Renewal business metrics"
  source: "`health_insurance_ecm`.`employer`.`group_renewal`"
  dimensions:
    - name: "Amendment Count"
      expr: amendment_count
    - name: "Amendment Flag"
      expr: amendment_flag
    - name: "Audit Created Timestamp"
      expr: audit_created_timestamp
    - name: "Audit Updated Timestamp"
      expr: audit_updated_timestamp
    - name: "Benefit Plan Ids"
      expr: benefit_plan_ids
    - name: "Compliance Check Date"
      expr: compliance_check_date
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Contribution Strategy"
      expr: contribution_strategy
    - name: "Erisa Status"
      expr: erisa_status
    - name: "Funding Arrangement"
      expr: funding_arrangement
    - name: "Group Size"
      expr: group_size
    - name: "Latest Amendment Approval Status"
      expr: latest_amendment_approval_status
    - name: "Latest Amendment Effective Date"
      expr: latest_amendment_effective_date
    - name: "Latest Amendment Reason Code"
      expr: latest_amendment_reason_code
    - name: "Latest Amendment Type"
      expr: latest_amendment_type
    - name: "Participation Requirement Met"
      expr: participation_requirement_met
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Group Renewal"
      expr: COUNT(DISTINCT group_renewal_id)
    - name: "Total Latest Amendment After Value"
      expr: SUM(latest_amendment_after_value)
    - name: "Average Latest Amendment After Value"
      expr: AVG(latest_amendment_after_value)
    - name: "Total Latest Amendment Before Value"
      expr: SUM(latest_amendment_before_value)
    - name: "Average Latest Amendment Before Value"
      expr: AVG(latest_amendment_before_value)
    - name: "Total Premium Rate Prior Year"
      expr: SUM(premium_rate_prior_year)
    - name: "Average Premium Rate Prior Year"
      expr: AVG(premium_rate_prior_year)
    - name: "Total Premium Rate Renewal Year"
      expr: SUM(premium_rate_renewal_year)
    - name: "Average Premium Rate Renewal Year"
      expr: AVG(premium_rate_renewal_year)
    - name: "Total Rate Change Percentage"
      expr: SUM(rate_change_percentage)
    - name: "Average Rate Change Percentage"
      expr: AVG(rate_change_percentage)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`employer_open_enrollment_window`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Open Enrollment Window business metrics"
  source: "`health_insurance_ecm`.`employer`.`open_enrollment_window`"
  dimensions:
    - name: "Change Deadline"
      expr: change_deadline
    - name: "Coverage Type"
      expr: coverage_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Eligible Employee Count"
      expr: eligible_employee_count
    - name: "End Date"
      expr: end_date
    - name: "Enrollment Method"
      expr: enrollment_method
    - name: "Enrollment Window Status"
      expr: enrollment_window_status
    - name: "Enrollment Window Type"
      expr: enrollment_window_type
    - name: "Notes"
      expr: notes
    - name: "Plan Selection Method"
      expr: plan_selection_method
    - name: "Source System"
      expr: source_system
    - name: "Start Date"
      expr: start_date
    - name: "Submission Deadline"
      expr: submission_deadline
    - name: "Total Employee Count"
      expr: total_employee_count
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Waiver Allowed"
      expr: waiver_allowed
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Open Enrollment Window"
      expr: COUNT(DISTINCT open_enrollment_window_id)
    - name: "Total Participation Rate"
      expr: SUM(participation_rate)
    - name: "Average Participation Rate"
      expr: AVG(participation_rate)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`employer_participation_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Participation Requirement business metrics"
  source: "`health_insurance_ecm`.`employer`.`participation_requirement`"
  dimensions:
    - name: "Compliance Review Due Date"
      expr: compliance_review_due_date
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Contribution Strategy"
      expr: contribution_strategy
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Enrolled Headcount"
      expr: enrolled_headcount
    - name: "Erisa Status"
      expr: erisa_status
    - name: "Funding Arrangement"
      expr: funding_arrangement
    - name: "Group Size"
      expr: group_size
    - name: "Last Evaluated Date"
      expr: last_evaluated_date
    - name: "Measurement Period"
      expr: measurement_period
    - name: "Minimum Enrolled Headcount"
      expr: minimum_enrolled_headcount
    - name: "Notes"
      expr: notes
    - name: "Participation Requirement Description"
      expr: participation_requirement_description
    - name: "Participation Requirement Status"
      expr: participation_requirement_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Participation Requirement"
      expr: COUNT(DISTINCT participation_requirement_id)
    - name: "Total Participation Percentage"
      expr: SUM(participation_percentage)
    - name: "Average Participation Percentage"
      expr: AVG(participation_percentage)
    - name: "Total Waiver Percentage Allowed"
      expr: SUM(waiver_percentage_allowed)
    - name: "Average Waiver Percentage Allowed"
      expr: AVG(waiver_percentage_allowed)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`employer_rate_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate Quote business metrics"
  source: "`health_insurance_ecm`.`employer`.`rate_quote`"
  dimensions:
    - name: "Contribution Strategy"
      expr: contribution_strategy
    - name: "Coverage Tier"
      expr: coverage_tier
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Erisa Status"
      expr: erisa_status
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Group Sic Code"
      expr: group_sic_code
    - name: "Group Size"
      expr: group_size
    - name: "Group Type"
      expr: group_type
    - name: "Issue Timestamp"
      expr: issue_timestamp
    - name: "Member Count"
      expr: member_count
    - name: "Notes"
      expr: notes
    - name: "Plan Year"
      expr: plan_year
    - name: "Quote Number"
      expr: quote_number
    - name: "Quote Version"
      expr: quote_version
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rate Quote"
      expr: COUNT(DISTINCT rate_quote_id)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Gross Premium Amount"
      expr: SUM(gross_premium_amount)
    - name: "Average Gross Premium Amount"
      expr: AVG(gross_premium_amount)
    - name: "Total Net Premium Amount"
      expr: SUM(net_premium_amount)
    - name: "Average Net Premium Amount"
      expr: AVG(net_premium_amount)
    - name: "Total Pmpm Rate"
      expr: SUM(pmpm_rate)
    - name: "Average Pmpm Rate"
      expr: AVG(pmpm_rate)
    - name: "Total Total Group Premium Estimate"
      expr: SUM(total_group_premium_estimate)
    - name: "Average Total Group Premium Estimate"
      expr: AVG(total_group_premium_estimate)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`employer_tpa_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tpa Arrangement business metrics"
  source: "`health_insurance_ecm`.`employer`.`tpa_arrangement`"
  dimensions:
    - name: "Arrangement Name"
      expr: arrangement_name
    - name: "Arrangement Number"
      expr: arrangement_number
    - name: "Arrangement Type"
      expr: arrangement_type
    - name: "Contribution Strategy"
      expr: contribution_strategy
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Erisa Status"
      expr: erisa_status
    - name: "Fee Schedule Type"
      expr: fee_schedule_type
    - name: "Gfc Control Flag"
      expr: gfc_control_flag
    - name: "Group Size Max"
      expr: group_size_max
    - name: "Group Size Min"
      expr: group_size_min
    - name: "Notes"
      expr: notes
    - name: "Renewal Date"
      expr: renewal_date
    - name: "Source System"
      expr: source_system
    - name: "Stop Loss Coverage Scope"
      expr: stop_loss_coverage_scope
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tpa Arrangement"
      expr: COUNT(DISTINCT tpa_arrangement_id)
    - name: "Total Contribution Rate Pmpm"
      expr: SUM(contribution_rate_pmpm)
    - name: "Average Contribution Rate Pmpm"
      expr: AVG(contribution_rate_pmpm)
    - name: "Total Fee Schedule Cap Amount"
      expr: SUM(fee_schedule_cap_amount)
    - name: "Average Fee Schedule Cap Amount"
      expr: AVG(fee_schedule_cap_amount)
    - name: "Total Fee Schedule Rate Pmpm"
      expr: SUM(fee_schedule_rate_pmpm)
    - name: "Average Fee Schedule Rate Pmpm"
      expr: AVG(fee_schedule_rate_pmpm)
$$;