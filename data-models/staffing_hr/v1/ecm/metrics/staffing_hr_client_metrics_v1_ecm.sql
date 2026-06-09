-- Metric views for domain: client | Business: Staffing Hr | Version: 1 | Generated on: 2026-05-02 15:43:14

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`client_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core client account metrics tracking account health, credit exposure, and relationship status for strategic account management and risk monitoring."
  source: "`staffing_hr_ecm`.`client`.`client_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current operational status of the client account (active, on hold, inactive, etc.)"
    - name: "client_type"
      expr: client_type
      comment: "Classification of client account type (direct, MSP, VMS, etc.)"
    - name: "company_size_tier"
      expr: company_size_tier
      comment: "Segmentation tier based on company size (enterprise, mid-market, SMB)"
    - name: "payment_terms_days"
      expr: payment_terms_days
      comment: "Standard payment terms in days for the client account"
    - name: "sla_tier"
      expr: sla_tier
      comment: "Service level agreement tier assigned to the account"
    - name: "vms_platform"
      expr: vms_platform
      comment: "Vendor management system platform used by the client (Beeline, Fieldglass, etc.)"
    - name: "invoice_frequency"
      expr: invoice_frequency
      comment: "Billing frequency for the client account (weekly, bi-weekly, monthly)"
    - name: "currency_code"
      expr: currency_code
      comment: "Primary currency code for transactions with this client"
    - name: "msa_status"
      expr: CASE WHEN msa_effective_date IS NOT NULL AND (msa_expiration_date IS NULL OR msa_expiration_date >= CURRENT_DATE()) THEN 'Active' WHEN msa_expiration_date < CURRENT_DATE() THEN 'Expired' ELSE 'No MSA' END
      comment: "Master service agreement status derived from effective and expiration dates"
    - name: "nps_category"
      expr: CASE WHEN nps_score >= '9' THEN 'Promoter' WHEN nps_score >= '7' THEN 'Passive' WHEN nps_score IS NOT NULL THEN 'Detractor' ELSE 'Not Surveyed' END
      comment: "Net Promoter Score category classification (Promoter, Passive, Detractor)"
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year the client account was created"
    - name: "created_quarter"
      expr: CONCAT('Q', QUARTER(created_timestamp), '-', YEAR(created_timestamp))
      comment: "Quarter and year the client account was created"
  measures:
    - name: "total_client_accounts"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Total number of unique client accounts"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all client accounts"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per client account"
    - name: "accounts_with_msa"
      expr: COUNT(DISTINCT CASE WHEN msa_effective_date IS NOT NULL THEN client_account_id END)
      comment: "Number of client accounts with a master service agreement on file"
    - name: "accounts_with_nda"
      expr: COUNT(DISTINCT CASE WHEN nda_on_file = TRUE THEN client_account_id END)
      comment: "Number of client accounts with a non-disclosure agreement on file"
    - name: "accounts_requiring_po"
      expr: COUNT(DISTINCT CASE WHEN po_required = TRUE THEN client_account_id END)
      comment: "Number of client accounts requiring purchase orders for billing"
    - name: "msa_coverage_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN msa_effective_date IS NOT NULL THEN client_account_id END) / NULLIF(COUNT(DISTINCT client_account_id), 0), 2)
      comment: "Percentage of client accounts with active master service agreements"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`client_managed_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Managed staffing program performance metrics tracking program health, spend, compliance, and operational efficiency for MSP/VMS oversight."
  source: "`staffing_hr_ecm`.`client`.`managed_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current operational status of the managed program"
    - name: "program_type"
      expr: program_type
      comment: "Type of managed program (MSP, VMS, hybrid, etc.)"
    - name: "sla_tier"
      expr: sla_tier
      comment: "Service level agreement tier for the program"
    - name: "governance_model"
      expr: governance_model
      comment: "Governance model applied to the program (centralized, decentralized, hybrid)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for program financial transactions"
    - name: "program_age_months"
      expr: CAST(DATEDIFF(COALESCE(expiration_date, CURRENT_DATE()), effective_date) / 30 AS INT)
      comment: "Age of the program in months from effective date to expiration or current date"
    - name: "compliance_posture"
      expr: CASE WHEN bgc_required = TRUE AND drug_screen_required = TRUE AND everify_required = TRUE THEN 'High' WHEN bgc_required = TRUE OR drug_screen_required = TRUE THEN 'Medium' ELSE 'Standard' END
      comment: "Compliance posture based on background check, drug screen, and E-Verify requirements"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the managed program became effective"
  measures:
    - name: "total_managed_programs"
      expr: COUNT(DISTINCT managed_program_id)
      comment: "Total number of unique managed programs"
    - name: "active_managed_programs"
      expr: COUNT(DISTINCT CASE WHEN program_status = 'Active' THEN managed_program_id END)
      comment: "Number of currently active managed programs"
    - name: "total_annual_spend_estimate"
      expr: SUM(CAST(annual_spend_estimate AS DOUBLE))
      comment: "Total estimated annual spend across all managed programs"
    - name: "avg_annual_spend_estimate"
      expr: AVG(CAST(annual_spend_estimate AS DOUBLE))
      comment: "Average estimated annual spend per managed program"
    - name: "avg_conversion_fee_pct"
      expr: AVG(CAST(conversion_fee_pct AS DOUBLE))
      comment: "Average conversion fee percentage across managed programs"
    - name: "avg_direct_hire_fee_pct"
      expr: AVG(CAST(direct_hire_fee_pct AS DOUBLE))
      comment: "Average direct hire fee percentage across managed programs"
    - name: "avg_msp_fee_pct"
      expr: AVG(CAST(msp_fee_pct AS DOUBLE))
      comment: "Average MSP management fee percentage across programs"
    - name: "avg_target_fill_rate"
      expr: AVG(CAST(target_fill_rate AS DOUBLE))
      comment: "Average target fill rate percentage across managed programs"
    - name: "programs_with_bgc_required"
      expr: COUNT(DISTINCT CASE WHEN bgc_required = TRUE THEN managed_program_id END)
      comment: "Number of programs requiring background checks"
    - name: "programs_with_everify_required"
      expr: COUNT(DISTINCT CASE WHEN everify_required = TRUE THEN managed_program_id END)
      comment: "Number of programs requiring E-Verify compliance"
    - name: "programs_with_onsite_coordinator"
      expr: COUNT(DISTINCT CASE WHEN on_site_coordinator_required = TRUE THEN managed_program_id END)
      comment: "Number of programs requiring on-site coordinator presence"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`client_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales opportunity pipeline metrics tracking deal flow, conversion, revenue potential, and win/loss analysis for business development."
  source: "`staffing_hr_ecm`.`client`.`opportunity`"
  dimensions:
    - name: "opportunity_status"
      expr: opportunity_status
      comment: "Current status of the sales opportunity"
    - name: "stage"
      expr: stage
      comment: "Sales pipeline stage of the opportunity"
    - name: "opportunity_type"
      expr: opportunity_type
      comment: "Type of opportunity (new business, expansion, renewal, etc.)"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the opportunity"
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the opportunity was sourced"
    - name: "industry_sector"
      expr: industry_sector
      comment: "Industry sector of the opportunity"
    - name: "skill_category"
      expr: skill_category
      comment: "Primary skill category for the opportunity"
    - name: "rate_type"
      expr: rate_type
      comment: "Rate type for the opportunity (hourly, daily, project-based)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for opportunity financial values"
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Whether the opportunity is exclusive to the staffing firm"
    - name: "expected_close_quarter"
      expr: CONCAT('Q', QUARTER(expected_close_date), '-', YEAR(expected_close_date))
      comment: "Expected close quarter for the opportunity"
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year the opportunity was created"
  measures:
    - name: "total_opportunities"
      expr: COUNT(DISTINCT opportunity_id)
      comment: "Total number of unique sales opportunities"
    - name: "total_estimated_revenue"
      expr: SUM(CAST(estimated_revenue AS DOUBLE))
      comment: "Total estimated revenue across all opportunities"
    - name: "avg_estimated_revenue"
      expr: AVG(CAST(estimated_revenue AS DOUBLE))
      comment: "Average estimated revenue per opportunity"
    - name: "total_positions"
      expr: SUM(CAST(number_of_positions AS DOUBLE))
      comment: "Total number of positions across all opportunities"
    - name: "avg_positions_per_opportunity"
      expr: AVG(CAST(number_of_positions AS DOUBLE))
      comment: "Average number of positions per opportunity"
    - name: "total_positions_filled"
      expr: SUM(CAST(positions_filled AS DOUBLE))
      comment: "Total number of positions filled across opportunities"
    - name: "avg_bill_rate"
      expr: AVG(CAST(bill_rate AS DOUBLE))
      comment: "Average bill rate across opportunities"
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate across opportunities"
    - name: "closed_won_opportunities"
      expr: COUNT(DISTINCT CASE WHEN opportunity_status = 'Closed Won' THEN opportunity_id END)
      comment: "Number of opportunities closed and won"
    - name: "closed_lost_opportunities"
      expr: COUNT(DISTINCT CASE WHEN opportunity_status = 'Closed Lost' THEN opportunity_id END)
      comment: "Number of opportunities closed and lost"
    - name: "exclusive_opportunities"
      expr: COUNT(DISTINCT CASE WHEN is_exclusive = TRUE THEN opportunity_id END)
      comment: "Number of exclusive opportunities"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`client_sla_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service level agreement performance metrics tracking compliance, variance, penalties, and bonuses for client program governance and accountability."
  source: "`staffing_hr_ecm`.`client`.`sla_measurement`"
  dimensions:
    - name: "sla_metric_type"
      expr: sla_metric_type
      comment: "Type of SLA metric being measured (fill rate, time to fill, quality of service, etc.)"
    - name: "measurement_status"
      expr: measurement_status
      comment: "Current status of the SLA measurement (draft, finalized, disputed)"
    - name: "is_compliant"
      expr: is_compliant
      comment: "Whether the SLA measurement met compliance threshold"
    - name: "period_type"
      expr: period_type
      comment: "Type of measurement period (weekly, monthly, quarterly, annual)"
    - name: "compliance_direction"
      expr: compliance_direction
      comment: "Direction of compliance variance (above target, below target, on target)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for penalty and bonus amounts"
    - name: "qbr_period_flag"
      expr: qbr_period_flag
      comment: "Whether this measurement period is a quarterly business review period"
    - name: "penalty_triggered"
      expr: penalty_triggered
      comment: "Whether a penalty was triggered for non-compliance"
    - name: "bonus_triggered"
      expr: bonus_triggered
      comment: "Whether a bonus was triggered for exceeding targets"
    - name: "measurement_year"
      expr: YEAR(period_start_date)
      comment: "Year of the SLA measurement period"
    - name: "measurement_quarter"
      expr: CONCAT('Q', QUARTER(period_start_date), '-', YEAR(period_start_date))
      comment: "Quarter of the SLA measurement period"
  measures:
    - name: "total_sla_measurements"
      expr: COUNT(DISTINCT sla_measurement_id)
      comment: "Total number of unique SLA measurements"
    - name: "compliant_measurements"
      expr: COUNT(DISTINCT CASE WHEN is_compliant = TRUE THEN sla_measurement_id END)
      comment: "Number of SLA measurements that met compliance threshold"
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_compliant = TRUE THEN sla_measurement_id END) / NULLIF(COUNT(DISTINCT sla_measurement_id), 0), 2)
      comment: "Percentage of SLA measurements that met compliance threshold"
    - name: "avg_fill_rate_actual"
      expr: AVG(CAST(fill_rate_actual AS DOUBLE))
      comment: "Average actual fill rate percentage across measurements"
    - name: "avg_qos_actual_rate"
      expr: AVG(CAST(qos_actual_rate AS DOUBLE))
      comment: "Average actual quality of service rate across measurements"
    - name: "avg_ttf_actual_days"
      expr: AVG(CAST(ttf_actual_avg_days AS DOUBLE))
      comment: "Average actual time-to-fill in days across measurements"
    - name: "avg_tts_actual_days"
      expr: AVG(CAST(tts_actual_avg_days AS DOUBLE))
      comment: "Average actual time-to-submit in days across measurements"
    - name: "avg_retention_rate_actual"
      expr: AVG(CAST(retention_rate_actual AS DOUBLE))
      comment: "Average actual retention rate percentage across measurements"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount assessed for SLA non-compliance"
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus amount earned for exceeding SLA targets"
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_pct AS DOUBLE))
      comment: "Average variance percentage from target across measurements"
    - name: "measurements_with_penalty"
      expr: COUNT(DISTINCT CASE WHEN penalty_triggered = TRUE THEN sla_measurement_id END)
      comment: "Number of measurements that triggered a penalty"
    - name: "measurements_with_bonus"
      expr: COUNT(DISTINCT CASE WHEN bonus_triggered = TRUE THEN sla_measurement_id END)
      comment: "Number of measurements that triggered a bonus"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`client_nps_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Net Promoter Score feedback metrics tracking client satisfaction, loyalty trends, and retention risk for relationship health monitoring."
  source: "`staffing_hr_ecm`.`client`.`nps_response`"
  dimensions:
    - name: "nps_category"
      expr: nps_category
      comment: "Net Promoter Score category (Promoter, Passive, Detractor)"
    - name: "response_status"
      expr: response_status
      comment: "Status of the NPS response (completed, pending, declined)"
    - name: "survey_channel"
      expr: survey_channel
      comment: "Channel through which the survey was delivered (email, SMS, web, phone)"
    - name: "survey_trigger"
      expr: survey_trigger
      comment: "Event that triggered the NPS survey (placement end, milestone, scheduled)"
    - name: "service_line"
      expr: service_line
      comment: "Service line associated with the NPS response"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Status of follow-up resolution for the NPS response"
    - name: "escalated"
      expr: escalated
      comment: "Whether the NPS response was escalated for executive attention"
    - name: "retention_risk_flag"
      expr: retention_risk_flag
      comment: "Whether the response indicates retention risk"
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Whether follow-up action is required for the response"
    - name: "survey_year"
      expr: YEAR(survey_date)
      comment: "Year the NPS survey was conducted"
    - name: "survey_quarter"
      expr: CONCAT('Q', QUARTER(survey_date), '-', YEAR(survey_date))
      comment: "Quarter the NPS survey was conducted"
  measures:
    - name: "total_nps_responses"
      expr: COUNT(DISTINCT nps_response_id)
      comment: "Total number of unique NPS responses received"
    - name: "promoter_count"
      expr: COUNT(DISTINCT CASE WHEN nps_category = 'Promoter' THEN nps_response_id END)
      comment: "Number of promoter responses (NPS 9-10)"
    - name: "passive_count"
      expr: COUNT(DISTINCT CASE WHEN nps_category = 'Passive' THEN nps_response_id END)
      comment: "Number of passive responses (NPS 7-8)"
    - name: "detractor_count"
      expr: COUNT(DISTINCT CASE WHEN nps_category = 'Detractor' THEN nps_response_id END)
      comment: "Number of detractor responses (NPS 0-6)"
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score from text analysis of verbatim comments"
    - name: "escalated_responses"
      expr: COUNT(DISTINCT CASE WHEN escalated = TRUE THEN nps_response_id END)
      comment: "Number of NPS responses escalated for executive attention"
    - name: "retention_risk_responses"
      expr: COUNT(DISTINCT CASE WHEN retention_risk_flag = TRUE THEN nps_response_id END)
      comment: "Number of responses flagged as retention risk"
    - name: "responses_requiring_followup"
      expr: COUNT(DISTINCT CASE WHEN follow_up_required = TRUE THEN nps_response_id END)
      comment: "Number of responses requiring follow-up action"
    - name: "followup_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN follow_up_completed_date IS NOT NULL THEN nps_response_id END) / NULLIF(COUNT(DISTINCT CASE WHEN follow_up_required = TRUE THEN nps_response_id END), 0), 2)
      comment: "Percentage of required follow-ups that have been completed"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`client_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client credit risk metrics tracking credit limits, outstanding balances, aging, and risk tier for financial exposure management."
  source: "`staffing_hr_ecm`.`client`.`credit_profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the credit profile"
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier classification for the client (low, medium, high)"
    - name: "credit_decision"
      expr: credit_decision
      comment: "Credit decision outcome (approved, declined, conditional)"
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Whether the client account is on credit hold"
    - name: "bankruptcy_flag"
      expr: bankruptcy_flag
      comment: "Whether the client has a bankruptcy flag"
    - name: "litigation_flag"
      expr: litigation_flag
      comment: "Whether the client has active litigation"
    - name: "insurance_required_flag"
      expr: insurance_required_flag
      comment: "Whether insurance is required for the client"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for credit profile financial values"
    - name: "payment_terms_days"
      expr: payment_terms_days
      comment: "Payment terms in days for the client"
    - name: "decision_year"
      expr: YEAR(decision_date)
      comment: "Year of the credit decision"
  measures:
    - name: "total_credit_profiles"
      expr: COUNT(DISTINCT credit_profile_id)
      comment: "Total number of unique credit profiles"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all profiles"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per credit profile"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(total_outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance across all credit profiles"
    - name: "total_available_credit"
      expr: SUM(CAST(available_credit AS DOUBLE))
      comment: "Total available credit across all profiles"
    - name: "avg_dso_days"
      expr: AVG(CAST(dso_actual_days AS DOUBLE))
      comment: "Average days sales outstanding across credit profiles"
    - name: "total_aging_current"
      expr: SUM(CAST(aging_current_amount AS DOUBLE))
      comment: "Total current aging balance (not past due)"
    - name: "total_aging_30_days"
      expr: SUM(CAST(aging_30_days_amount AS DOUBLE))
      comment: "Total aging balance 1-30 days past due"
    - name: "total_aging_60_days"
      expr: SUM(CAST(aging_60_days_amount AS DOUBLE))
      comment: "Total aging balance 31-60 days past due"
    - name: "total_aging_90_plus_days"
      expr: SUM(CAST(aging_90_plus_days_amount AS DOUBLE))
      comment: "Total aging balance 90+ days past due"
    - name: "profiles_on_credit_hold"
      expr: COUNT(DISTINCT CASE WHEN credit_hold_flag = TRUE THEN credit_profile_id END)
      comment: "Number of credit profiles currently on credit hold"
    - name: "profiles_with_bankruptcy"
      expr: COUNT(DISTINCT CASE WHEN bankruptcy_flag = TRUE THEN credit_profile_id END)
      comment: "Number of credit profiles with bankruptcy flag"
    - name: "profiles_with_litigation"
      expr: COUNT(DISTINCT CASE WHEN litigation_flag = TRUE THEN credit_profile_id END)
      comment: "Number of credit profiles with active litigation"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`client_program_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier performance within managed programs tracking fill rates, compliance, spend, and tier status for vendor management optimization."
  source: "`staffing_hr_ecm`.`client`.`program_supplier`"
  dimensions:
    - name: "supplier_status"
      expr: supplier_status
      comment: "Current status of the supplier within the program"
    - name: "supplier_tier"
      expr: supplier_tier
      comment: "Tier classification of the supplier (tier 1, tier 2, tier 3)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the supplier within the program"
    - name: "diversity_certified"
      expr: diversity_certified
      comment: "Whether the supplier holds diversity certification"
    - name: "diversity_certification_type"
      expr: diversity_certification_type
      comment: "Type of diversity certification held by the supplier"
    - name: "msa_on_file"
      expr: msa_on_file
      comment: "Whether a master service agreement is on file for the supplier"
    - name: "nda_on_file"
      expr: nda_on_file
      comment: "Whether a non-disclosure agreement is on file for the supplier"
    - name: "insurance_verified"
      expr: insurance_verified
      comment: "Whether supplier insurance has been verified"
    - name: "onboarding_complete"
      expr: onboarding_complete
      comment: "Whether supplier onboarding is complete"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for supplier financial transactions"
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year the supplier was enrolled in the program"
  measures:
    - name: "total_program_suppliers"
      expr: COUNT(DISTINCT program_supplier_id)
      comment: "Total number of unique supplier enrollments in programs"
    - name: "active_program_suppliers"
      expr: COUNT(DISTINCT CASE WHEN supplier_status = 'Active' THEN program_supplier_id END)
      comment: "Number of active supplier enrollments in programs"
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_percent AS DOUBLE))
      comment: "Average fill rate percentage across program suppliers"
    - name: "avg_fall_off_rate_pct"
      expr: AVG(CAST(fall_off_rate_percent AS DOUBLE))
      comment: "Average fall-off rate percentage across program suppliers"
    - name: "avg_time_to_fill_days"
      expr: AVG(CAST(avg_time_to_fill_days AS DOUBLE))
      comment: "Average time-to-fill in days across program suppliers"
    - name: "avg_performance_score"
      expr: AVG(CAST(performance_score AS DOUBLE))
      comment: "Average performance score across program suppliers"
    - name: "diversity_certified_suppliers"
      expr: COUNT(DISTINCT CASE WHEN diversity_certified = TRUE THEN program_supplier_id END)
      comment: "Number of diversity-certified suppliers in programs"
    - name: "suppliers_with_msa"
      expr: COUNT(DISTINCT CASE WHEN msa_on_file = TRUE THEN program_supplier_id END)
      comment: "Number of suppliers with master service agreement on file"
    - name: "suppliers_with_insurance_verified"
      expr: COUNT(DISTINCT CASE WHEN insurance_verified = TRUE THEN program_supplier_id END)
      comment: "Number of suppliers with verified insurance"
    - name: "suppliers_onboarding_complete"
      expr: COUNT(DISTINCT CASE WHEN onboarding_complete = TRUE THEN program_supplier_id END)
      comment: "Number of suppliers with completed onboarding"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`client_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client location operational metrics tracking site status, headcount capacity, compliance requirements, and geographic distribution for workforce deployment."
  source: "`staffing_hr_ecm`.`client`.`location`"
  dimensions:
    - name: "location_status"
      expr: location_status
      comment: "Current operational status of the client location"
    - name: "location_type"
      expr: location_type
      comment: "Type of location (headquarters, branch, remote, etc.)"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the location"
    - name: "state_province"
      expr: state_province
      comment: "State or province of the location"
    - name: "city"
      expr: city
      comment: "City of the location"
    - name: "time_zone"
      expr: time_zone
      comment: "Time zone of the location"
    - name: "is_remote"
      expr: is_remote
      comment: "Whether the location is a remote work site"
    - name: "is_union_site"
      expr: is_union_site
      comment: "Whether the location is a union site"
    - name: "is_drug_free_workplace"
      expr: is_drug_free_workplace
      comment: "Whether the location is designated as a drug-free workplace"
    - name: "background_check_required"
      expr: background_check_required
      comment: "Whether background checks are required at this location"
    - name: "everify_required"
      expr: everify_required
      comment: "Whether E-Verify is required at this location"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the location became effective"
  measures:
    - name: "total_locations"
      expr: COUNT(DISTINCT location_id)
      comment: "Total number of unique client locations"
    - name: "active_locations"
      expr: COUNT(DISTINCT CASE WHEN location_status = 'Active' THEN location_id END)
      comment: "Number of currently active client locations"
    - name: "remote_locations"
      expr: COUNT(DISTINCT CASE WHEN is_remote = TRUE THEN location_id END)
      comment: "Number of remote work locations"
    - name: "union_sites"
      expr: COUNT(DISTINCT CASE WHEN is_union_site = TRUE THEN location_id END)
      comment: "Number of union sites"
    - name: "locations_requiring_bgc"
      expr: COUNT(DISTINCT CASE WHEN background_check_required = TRUE THEN location_id END)
      comment: "Number of locations requiring background checks"
    - name: "locations_requiring_everify"
      expr: COUNT(DISTINCT CASE WHEN everify_required = TRUE THEN location_id END)
      comment: "Number of locations requiring E-Verify"
    - name: "avg_latitude"
      expr: AVG(CAST(latitude AS DOUBLE))
      comment: "Average latitude coordinate across locations"
    - name: "avg_longitude"
      expr: AVG(CAST(longitude AS DOUBLE))
      comment: "Average longitude coordinate across locations"
$$;