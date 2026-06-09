-- Metric views for domain: tenant | Business: Real Estate | Version: 1 | Generated on: 2026-05-02 01:37:58

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`tenant_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tenant application pipeline and conversion metrics for leasing operations"
  source: "`real_estate_ecm`.`tenant`.`application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the tenant application (e.g., submitted, under review, approved, declined)"
    - name: "applicant_type"
      expr: applicant_type
      comment: "Type of applicant (e.g., individual, corporate, guarantor-backed)"
    - name: "portfolio_type"
      expr: portfolio_type
      comment: "Portfolio classification (e.g., residential, commercial, mixed-use)"
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the application was received (e.g., online, broker, walk-in)"
    - name: "decline_reason_code"
      expr: decline_reason_code
      comment: "Reason code for declined applications"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month when the application was submitted"
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month when the application decision was made"
    - name: "credit_tier"
      expr: CASE WHEN CAST(credit_score AS INT) >= 750 THEN 'Excellent' WHEN CAST(credit_score AS INT) >= 700 THEN 'Good' WHEN CAST(credit_score AS INT) >= 650 THEN 'Fair' WHEN CAST(credit_score AS INT) >= 600 THEN 'Poor' ELSE 'Very Poor' END
      comment: "Credit tier classification based on credit score"
    - name: "guarantor_required_flag"
      expr: guarantor_required
      comment: "Whether a guarantor is required for this application"
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of tenant applications submitted"
    - name: "total_proposed_annual_rent"
      expr: SUM(CAST(proposed_base_rent_monthly AS DOUBLE) * 12)
      comment: "Total annualized proposed rent value across all applications"
    - name: "avg_proposed_rent_monthly"
      expr: AVG(CAST(proposed_base_rent_monthly AS DOUBLE))
      comment: "Average proposed monthly base rent per application"
    - name: "avg_proposed_rent_psf"
      expr: AVG(CAST(proposed_rent_psf AS DOUBLE))
      comment: "Average proposed rent per square foot"
    - name: "total_security_deposits"
      expr: SUM(CAST(security_deposit_amount AS DOUBLE))
      comment: "Total security deposit amounts across all applications"
    - name: "avg_dti_ratio"
      expr: AVG(CAST(dti_ratio AS DOUBLE))
      comment: "Average debt-to-income ratio across applicants"
    - name: "total_ti_allowance_requested"
      expr: SUM(CAST(ti_allowance_requested AS DOUBLE))
      comment: "Total tenant improvement allowance requested across applications"
    - name: "avg_lease_term_months"
      expr: AVG(CAST(proposed_lease_term_months AS INT))
      comment: "Average proposed lease term in months"
    - name: "application_approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN application_status = 'Approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications approved out of total applications"
    - name: "avg_days_to_decision"
      expr: AVG(DATEDIFF(decision_date, submission_date))
      comment: "Average number of days from application submission to decision"
    - name: "total_application_fees"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total application fee revenue collected"
    - name: "fee_payment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN fee_paid = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications where fees were paid"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`tenant_arrears_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tenant arrears and collections performance metrics for credit risk management"
  source: "`real_estate_ecm`.`tenant`.`arrears_event`"
  dimensions:
    - name: "arrears_stage"
      expr: arrears_stage
      comment: "Stage of arrears (e.g., early, moderate, severe, legal)"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the arrears event"
    - name: "portfolio_type"
      expr: portfolio_type
      comment: "Portfolio classification (e.g., residential, commercial)"
    - name: "charge_type"
      expr: charge_type
      comment: "Type of charge in arrears (e.g., rent, utilities, fees)"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month when the arrears event occurred"
    - name: "days_past_due_bucket"
      expr: CASE WHEN CAST(days_past_due AS INT) <= 30 THEN '0-30 days' WHEN CAST(days_past_due AS INT) <= 60 THEN '31-60 days' WHEN CAST(days_past_due AS INT) <= 90 THEN '61-90 days' ELSE '90+ days' END
      comment: "Bucketed days past due for aging analysis"
    - name: "payment_plan_active"
      expr: payment_plan_flag
      comment: "Whether a payment plan is active for this arrears event"
    - name: "security_deposit_applied_flag"
      expr: security_deposit_applied
      comment: "Whether security deposit was applied to resolve arrears"
    - name: "tenant_retention_risk"
      expr: tenant_retention_risk
      comment: "Risk level for tenant retention (e.g., low, medium, high)"
  measures:
    - name: "total_arrears_events"
      expr: COUNT(1)
      comment: "Total number of arrears events recorded"
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total amount overdue across all arrears events"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(total_outstanding AS DOUBLE))
      comment: "Total outstanding balance including interest and fees"
    - name: "total_late_fees"
      expr: SUM(CAST(late_fee_amount AS DOUBLE))
      comment: "Total late fees assessed across arrears events"
    - name: "total_interest_accrued"
      expr: SUM(CAST(interest_accrued AS DOUBLE))
      comment: "Total interest accrued on overdue amounts"
    - name: "total_partial_payments"
      expr: SUM(CAST(partial_payment_received AS DOUBLE))
      comment: "Total partial payments received toward arrears"
    - name: "total_write_offs"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as uncollectible"
    - name: "total_security_deposit_applied"
      expr: SUM(CAST(security_deposit_applied_amount AS DOUBLE))
      comment: "Total security deposit amounts applied to arrears"
    - name: "avg_days_past_due"
      expr: AVG(CAST(days_past_due AS INT))
      comment: "Average number of days past due across arrears events"
    - name: "cure_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cure_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of arrears events that were cured"
    - name: "eviction_filing_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN eviction_filing_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of arrears events that resulted in eviction filing"
    - name: "payment_plan_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN payment_plan_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of arrears events with active payment plans"
    - name: "avg_time_to_cure_days"
      expr: AVG(DATEDIFF(cure_date, event_date))
      comment: "Average number of days from arrears event to cure"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`tenant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core tenant portfolio and relationship metrics for tenant management"
  source: "`real_estate_ecm`.`tenant`.`tenant`"
  dimensions:
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Current lifecycle stage of the tenant (e.g., prospect, active, churned)"
    - name: "entity_type"
      expr: entity_type
      comment: "Type of tenant entity (e.g., individual, corporation, partnership)"
    - name: "credit_tier"
      expr: credit_tier
      comment: "Credit tier classification of the tenant"
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current onboarding status for new tenants"
    - name: "guarantor_required_flag"
      expr: guarantor_required
      comment: "Whether a guarantor is required for this tenant"
    - name: "portal_access_enabled_flag"
      expr: portal_access_enabled
      comment: "Whether tenant has portal access enabled"
    - name: "hoa_member_flag"
      expr: hoa_member
      comment: "Whether tenant is a homeowners association member"
    - name: "first_lease_year"
      expr: YEAR(first_lease_start_date)
      comment: "Year when tenant's first lease started"
    - name: "kyc_verified_flag"
      expr: kyc_verified
      comment: "Whether tenant has completed KYC verification"
    - name: "prospect_source"
      expr: prospect_source
      comment: "Original source channel that brought the tenant"
  measures:
    - name: "total_tenants"
      expr: COUNT(1)
      comment: "Total number of tenants in the portfolio"
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Total annual revenue across all tenant entities"
    - name: "avg_annual_revenue"
      expr: AVG(CAST(annual_revenue AS DOUBLE))
      comment: "Average annual revenue per tenant"
    - name: "total_security_deposits_held"
      expr: SUM(CAST(security_deposit_amount AS DOUBLE))
      comment: "Total security deposit amounts held across all tenants"
    - name: "avg_security_deposit"
      expr: AVG(CAST(security_deposit_amount AS DOUBLE))
      comment: "Average security deposit amount per tenant"
    - name: "avg_lease_count_per_tenant"
      expr: AVG(CAST(lease_count AS INT))
      comment: "Average number of leases per tenant"
    - name: "avg_employee_count"
      expr: AVG(CAST(employee_count AS INT))
      comment: "Average employee count for corporate tenants"
    - name: "kyc_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN kyc_verified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tenants who have completed KYC verification"
    - name: "portal_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN portal_access_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tenants with portal access enabled"
    - name: "guarantor_requirement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN guarantor_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tenants requiring a guarantor"
    - name: "avg_tenant_tenure_days"
      expr: AVG(DATEDIFF(CURRENT_DATE(), first_lease_start_date))
      comment: "Average number of days since first lease start (tenant tenure)"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`tenant_occupancy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tenant occupancy and space utilization metrics for portfolio management"
  source: "`real_estate_ecm`.`tenant`.`tenant_occupancy`"
  dimensions:
    - name: "occupancy_status"
      expr: occupancy_status
      comment: "Current occupancy status (e.g., occupied, vacant, notice given)"
    - name: "occupancy_type"
      expr: occupancy_type
      comment: "Type of occupancy arrangement"
    - name: "portfolio_type"
      expr: portfolio_type
      comment: "Portfolio classification (e.g., residential, commercial, industrial)"
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class of the occupied property"
    - name: "is_holdover_flag"
      expr: is_holdover
      comment: "Whether the occupancy is in holdover status"
    - name: "is_sublease_flag"
      expr: is_sublease
      comment: "Whether this is a sublease arrangement"
    - name: "move_in_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when tenant moved in"
    - name: "move_out_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month when tenant moved out or is scheduled to move out"
    - name: "vacate_reason_code"
      expr: vacate_reason_code
      comment: "Reason code for tenant vacating the space"
    - name: "ti_completed_flag"
      expr: ti_completed
      comment: "Whether tenant improvements have been completed"
  measures:
    - name: "total_occupancies"
      expr: COUNT(1)
      comment: "Total number of tenant occupancy records"
    - name: "total_occupied_area_sqf"
      expr: SUM(CAST(occupied_area_sqf AS DOUBLE))
      comment: "Total occupied area in square feet across all occupancies"
    - name: "total_occupied_area_sqm"
      expr: SUM(CAST(occupied_area_sqm AS DOUBLE))
      comment: "Total occupied area in square meters across all occupancies"
    - name: "avg_occupied_area_sqf"
      expr: AVG(CAST(occupied_area_sqf AS DOUBLE))
      comment: "Average occupied area in square feet per occupancy"
    - name: "avg_occupants_per_unit"
      expr: AVG(CAST(num_occupants AS INT))
      comment: "Average number of occupants per occupied unit"
    - name: "avg_parking_bays_allocated"
      expr: AVG(CAST(parking_bays_allocated AS INT))
      comment: "Average number of parking bays allocated per occupancy"
    - name: "holdover_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_holdover = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of occupancies in holdover status"
    - name: "sublease_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_sublease = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of occupancies that are subleases"
    - name: "ti_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN ti_completed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of occupancies where tenant improvements are completed"
    - name: "avg_occupancy_duration_days"
      expr: AVG(DATEDIFF(COALESCE(end_date, CURRENT_DATE()), start_date))
      comment: "Average duration of occupancy in days"
    - name: "avg_days_to_ti_completion"
      expr: AVG(DATEDIFF(ti_completion_date, start_date))
      comment: "Average number of days from move-in to tenant improvement completion"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`tenant_retention_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tenant retention campaign effectiveness and renewal pipeline metrics"
  source: "`real_estate_ecm`.`tenant`.`retention_action`"
  dimensions:
    - name: "action_status"
      expr: action_status
      comment: "Current status of the retention action (e.g., open, in progress, closed)"
    - name: "action_type"
      expr: action_type
      comment: "Type of retention action taken (e.g., renewal offer, incentive, negotiation)"
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the retention action (e.g., renewed, declined, pending)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the retention action"
    - name: "tenant_response"
      expr: tenant_response
      comment: "Tenant's response to the retention action"
    - name: "outreach_channel"
      expr: outreach_channel
      comment: "Channel used for retention outreach (e.g., email, phone, in-person)"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the retention action has been escalated"
    - name: "loi_issued_flag"
      expr: loi_issued
      comment: "Whether a letter of intent was issued"
    - name: "action_month"
      expr: DATE_TRUNC('MONTH', action_date)
      comment: "Month when the retention action was initiated"
    - name: "months_to_expiry_bucket"
      expr: CASE WHEN CAST(months_to_expiry AS INT) <= 3 THEN '0-3 months' WHEN CAST(months_to_expiry AS INT) <= 6 THEN '4-6 months' WHEN CAST(months_to_expiry AS INT) <= 12 THEN '7-12 months' ELSE '12+ months' END
      comment: "Bucketed months until lease expiry for retention timing analysis"
  measures:
    - name: "total_retention_actions"
      expr: COUNT(1)
      comment: "Total number of tenant retention actions initiated"
    - name: "total_proposed_rent_value"
      expr: SUM(CAST(proposed_rent_psf AS DOUBLE) * CAST(leased_area_sqft AS DOUBLE) * CAST(proposed_lease_term_months AS INT))
      comment: "Total proposed rent value across all retention actions"
    - name: "avg_proposed_rent_psf"
      expr: AVG(CAST(proposed_rent_psf AS DOUBLE))
      comment: "Average proposed rent per square foot in retention offers"
    - name: "avg_current_rent_psf"
      expr: AVG(CAST(current_rent_psf AS DOUBLE))
      comment: "Average current rent per square foot for tenants in retention pipeline"
    - name: "avg_market_rent_psf"
      expr: AVG(CAST(market_rent_psf AS DOUBLE))
      comment: "Average market rent per square foot for comparison"
    - name: "total_ti_allowance_offered"
      expr: SUM(CAST(ti_allowance_total AS DOUBLE))
      comment: "Total tenant improvement allowance offered in retention actions"
    - name: "avg_ti_allowance_psf"
      expr: AVG(CAST(ti_allowance_psf AS DOUBLE))
      comment: "Average tenant improvement allowance per square foot offered"
    - name: "total_rent_abatement_offered"
      expr: SUM(CAST(rent_abatement_amount AS DOUBLE))
      comment: "Total rent abatement amount offered across retention actions"
    - name: "avg_free_rent_months_offered"
      expr: AVG(CAST(free_rent_months_offered AS DOUBLE))
      comment: "Average number of free rent months offered in retention deals"
    - name: "avg_proposed_lease_term_months"
      expr: AVG(CAST(proposed_lease_term_months AS INT))
      comment: "Average proposed lease term in months for retention offers"
    - name: "retention_success_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN outcome = 'Renewed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of retention actions that resulted in successful renewal"
    - name: "loi_issuance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN loi_issued = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of retention actions where LOI was issued"
    - name: "avg_rent_escalation_rate_pct"
      expr: AVG(CAST(rent_escalation_rate_pct AS DOUBLE))
      comment: "Average rent escalation rate percentage in retention offers"
    - name: "avg_days_to_close"
      expr: AVG(DATEDIFF(action_closed_date, action_date))
      comment: "Average number of days from retention action initiation to closure"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`tenant_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tenant screening and qualification metrics for risk assessment and compliance"
  source: "`real_estate_ecm`.`tenant`.`screening`"
  dimensions:
    - name: "screening_status"
      expr: screening_status
      comment: "Current status of the screening process"
    - name: "overall_result"
      expr: overall_result
      comment: "Overall result of the tenant screening (e.g., approved, denied, conditional)"
    - name: "applicant_type"
      expr: applicant_type
      comment: "Type of applicant being screened"
    - name: "portfolio_type"
      expr: portfolio_type
      comment: "Portfolio type for the screening"
    - name: "vendor"
      expr: vendor
      comment: "Screening vendor used for background checks"
    - name: "credit_check_result"
      expr: credit_check_result
      comment: "Result of the credit check component"
    - name: "criminal_check_result"
      expr: criminal_check_result
      comment: "Result of the criminal background check"
    - name: "eviction_check_result"
      expr: eviction_check_result
      comment: "Result of the eviction history check"
    - name: "employment_verification_result"
      expr: employment_verification_result
      comment: "Result of employment verification"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month when screening was requested"
    - name: "fcra_compliant_flag"
      expr: fcra_compliant
      comment: "Whether the screening process was FCRA compliant"
    - name: "adverse_action_required_flag"
      expr: adverse_action_required
      comment: "Whether adverse action notice is required"
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total number of tenant screenings conducted"
    - name: "total_screening_fees"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total screening fee revenue collected"
    - name: "avg_screening_fee"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average screening fee per application"
    - name: "avg_income_to_rent_ratio"
      expr: AVG(CAST(income_to_rent_ratio AS DOUBLE))
      comment: "Average income-to-rent ratio across screened applicants"
    - name: "screening_approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN overall_result = 'Approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings that resulted in approval"
    - name: "credit_check_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN credit_check_result = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings where credit check passed"
    - name: "criminal_check_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN criminal_check_result = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings where criminal check passed"
    - name: "eviction_check_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN eviction_check_result = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings where eviction check passed"
    - name: "employment_verification_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN employment_verification_result = 'Verified' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings where employment was verified"
    - name: "fcra_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN fcra_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings that were FCRA compliant"
    - name: "adverse_action_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN adverse_action_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings requiring adverse action notice"
    - name: "avg_days_to_complete_screening"
      expr: AVG(DATEDIFF(completion_date, request_date))
      comment: "Average number of days to complete tenant screening"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`tenant_prospect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tenant prospect pipeline and lead conversion metrics for leasing operations"
  source: "`real_estate_ecm`.`tenant`.`tenant_prospect`"
  dimensions:
    - name: "pipeline_stage"
      expr: pipeline_stage
      comment: "Current stage in the leasing pipeline (e.g., inquiry, tour, application, lease)"
    - name: "pipeline_status"
      expr: pipeline_status
      comment: "Current status of the prospect (e.g., active, converted, lost)"
    - name: "prospect_type"
      expr: prospect_type
      comment: "Type of prospect (e.g., individual, corporate, investor)"
    - name: "lead_source"
      expr: lead_source
      comment: "Source channel that generated the lead"
    - name: "lead_source_detail"
      expr: lead_source_detail
      comment: "Detailed source information for the lead"
    - name: "segment"
      expr: segment
      comment: "Market segment classification of the prospect"
    - name: "lost_reason"
      expr: lost_reason
      comment: "Reason why prospect was lost (if applicable)"
    - name: "inquiry_month"
      expr: DATE_TRUNC('MONTH', inquiry_date)
      comment: "Month when initial inquiry was made"
    - name: "credit_check_status"
      expr: credit_check_status
      comment: "Status of credit check for the prospect"
    - name: "background_check_status"
      expr: background_check_status
      comment: "Status of background check for the prospect"
    - name: "tour_completed_flag"
      expr: CASE WHEN tour_completed_date IS NOT NULL THEN TRUE ELSE FALSE END
      comment: "Whether prospect has completed a property tour"
  measures:
    - name: "total_prospects"
      expr: COUNT(1)
      comment: "Total number of tenant prospects in the pipeline"
    - name: "total_expected_lease_value"
      expr: SUM(CAST(expected_lease_value AS DOUBLE))
      comment: "Total expected lease value across all prospects"
    - name: "avg_expected_lease_value"
      expr: AVG(CAST(expected_lease_value AS DOUBLE))
      comment: "Average expected lease value per prospect"
    - name: "avg_budget_max_monthly"
      expr: AVG(CAST(budget_max_monthly AS DOUBLE))
      comment: "Average maximum monthly budget across prospects"
    - name: "avg_budget_psf"
      expr: AVG(CAST(budget_psf AS DOUBLE))
      comment: "Average budget per square foot across prospects"
    - name: "avg_desired_size_sqft"
      expr: AVG((CAST(desired_size_min_sqft AS DOUBLE) + CAST(desired_size_max_sqft AS DOUBLE)) / 2)
      comment: "Average desired space size in square feet (midpoint of min and max)"
    - name: "avg_desired_lease_term_months"
      expr: AVG(CAST(desired_lease_term_months AS INT))
      comment: "Average desired lease term in months"
    - name: "avg_conversion_probability_pct"
      expr: AVG(CAST(conversion_probability_pct AS DOUBLE))
      comment: "Average conversion probability percentage across prospects"
    - name: "tour_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN tour_completed_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prospects who completed a property tour"
    - name: "application_submission_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN application_submitted_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prospects who submitted an application"
    - name: "lead_to_tour_conversion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN tour_completed_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of leads that converted to completed tours"
    - name: "tour_to_application_conversion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN application_submitted_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN tour_completed_date IS NOT NULL THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of tours that converted to applications"
    - name: "avg_days_inquiry_to_tour"
      expr: AVG(DATEDIFF(tour_scheduled_date, inquiry_date))
      comment: "Average number of days from inquiry to scheduled tour"
    - name: "avg_days_tour_to_application"
      expr: AVG(DATEDIFF(application_submitted_date, tour_completed_date))
      comment: "Average number of days from tour completion to application submission"
$$;