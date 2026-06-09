-- Metric views for domain: care | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 21:18:32

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`care_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care management enrollment metrics tracking member participation, risk stratification, and program engagement across care management programs"
  source: "`health_insurance_ecm`.`care`.`care_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of care enrollment (active, pending, disenrolled)"
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of care enrollment (voluntary, auto-assigned, provider-referred)"
    - name: "acuity_level"
      expr: acuity_level
      comment: "Clinical acuity level of enrolled member (low, medium, high, critical)"
    - name: "program_tier"
      expr: program_tier
      comment: "Program tier assignment based on member needs and risk"
    - name: "consent_status"
      expr: consent_status
      comment: "Member consent status for care management participation"
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source system or channel that initiated the enrollment"
    - name: "enrollment_year"
      expr: YEAR(effective_start_date)
      comment: "Year of enrollment start date"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month of enrollment start date"
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total number of care management enrollments"
    - name: "unique_members_enrolled"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Distinct count of members enrolled in care management programs"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average member risk score across enrollments, indicating population health complexity"
    - name: "avg_hcc_score"
      expr: AVG(CAST(hcc_score AS DOUBLE))
      comment: "Average Hierarchical Condition Category score, key driver of risk-adjusted payments"
    - name: "high_risk_enrollment_count"
      expr: COUNT(CASE WHEN CAST(risk_score AS DOUBLE) >= 2.0 THEN 1 END)
      comment: "Count of enrollments with risk score >= 2.0, indicating high-cost, high-need members"
    - name: "active_enrollment_count"
      expr: COUNT(CASE WHEN enrollment_status = 'active' THEN 1 END)
      comment: "Count of currently active care management enrollments"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`care_gap`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care gap closure metrics tracking quality measure gaps, HEDIS compliance, and Star Ratings performance critical to CMS reimbursement and accreditation"
  source: "`health_insurance_ecm`.`care`.`gap`"
  dimensions:
    - name: "gap_status"
      expr: gap_status
      comment: "Current status of care gap (open, closed, in-progress, expired)"
    - name: "gap_type"
      expr: gap_type
      comment: "Type of care gap (HEDIS, Star Rating, clinical quality, preventive care)"
    - name: "clinical_category"
      expr: clinical_category
      comment: "Clinical category of the gap (diabetes, cardiovascular, cancer screening, etc.)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for gap closure (critical, high, medium, low)"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether gap is critical for Star Ratings or regulatory compliance"
    - name: "documentation_status"
      expr: documentation_status
      comment: "Status of clinical documentation supporting gap closure"
    - name: "closure_method"
      expr: closure_method
      comment: "Method used to close the gap (office visit, telehealth, chart review, pharmacy data)"
    - name: "gap_open_year"
      expr: YEAR(open_date)
      comment: "Year the care gap was identified and opened"
    - name: "gap_open_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the care gap was identified and opened"
  measures:
    - name: "total_gaps"
      expr: COUNT(1)
      comment: "Total number of care gaps identified across all members and measures"
    - name: "open_gaps"
      expr: COUNT(CASE WHEN gap_status = 'open' THEN 1 END)
      comment: "Count of currently open care gaps requiring intervention"
    - name: "closed_gaps"
      expr: COUNT(CASE WHEN gap_status = 'closed' THEN 1 END)
      comment: "Count of successfully closed care gaps"
    - name: "critical_gaps"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Count of critical gaps impacting Star Ratings or regulatory compliance"
    - name: "gap_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gap_status = 'closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of gaps closed, key performance indicator for quality improvement and Star Ratings"
    - name: "avg_days_to_close"
      expr: AVG(DATEDIFF(actual_resolution_date, open_date))
      comment: "Average number of days from gap identification to closure, measuring care coordination efficiency"
    - name: "unique_members_with_gaps"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Distinct count of members with identified care gaps"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`care_hedis_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HEDIS quality measure performance metrics tracking NCQA accreditation compliance and Star Ratings, directly impacting Medicare Advantage bonus payments and market competitiveness"
  source: "`health_insurance_ecm`.`care`.`hedis_result`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status for the HEDIS measure (compliant, non-compliant, pending)"
    - name: "measure_category"
      expr: measure_category
      comment: "HEDIS measure category (effectiveness of care, access/availability, experience of care)"
    - name: "measure_type"
      expr: measure_type
      comment: "Type of HEDIS measure (administrative, hybrid, survey)"
    - name: "collection_method"
      expr: collection_method
      comment: "Data collection method used (administrative, chart review, survey)"
    - name: "is_excluded"
      expr: is_excluded
      comment: "Flag indicating whether member was excluded from measure denominator"
    - name: "exclusion_reason"
      expr: exclusion_reason
      comment: "Reason for exclusion from measure denominator if applicable"
    - name: "numerator_criteria_met"
      expr: numerator_criteria_met
      comment: "Flag indicating whether numerator criteria were met (measure passed)"
    - name: "denominator_criteria_met"
      expr: denominator_criteria_met
      comment: "Flag indicating whether denominator criteria were met (member eligible)"
    - name: "result_year"
      expr: YEAR(result_timestamp)
      comment: "Year of HEDIS result measurement"
    - name: "result_month"
      expr: DATE_TRUNC('MONTH', result_timestamp)
      comment: "Month of HEDIS result measurement"
  measures:
    - name: "total_hedis_results"
      expr: COUNT(1)
      comment: "Total number of HEDIS measure results recorded"
    - name: "eligible_population"
      expr: COUNT(CASE WHEN denominator_criteria_met = TRUE AND is_excluded = FALSE THEN 1 END)
      comment: "Count of members eligible for HEDIS measure (denominator), basis for rate calculation"
    - name: "numerator_compliant"
      expr: COUNT(CASE WHEN numerator_criteria_met = TRUE THEN 1 END)
      comment: "Count of members meeting HEDIS measure numerator criteria (compliant)"
    - name: "hedis_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN numerator_criteria_met = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN denominator_criteria_met = TRUE AND is_excluded = FALSE THEN 1 END), 0), 2)
      comment: "HEDIS measure rate (numerator/denominator), primary metric for NCQA accreditation and Star Ratings performance"
    - name: "avg_measure_score"
      expr: AVG(CAST(measure_score AS DOUBLE))
      comment: "Average measure score across all HEDIS results"
    - name: "unique_members_measured"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct count of members included in HEDIS measurement"
    - name: "exclusion_count"
      expr: COUNT(CASE WHEN is_excluded = TRUE THEN 1 END)
      comment: "Count of members excluded from HEDIS measure denominator"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`care_cahps_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CAHPS member experience survey metrics tracking patient satisfaction and Star Ratings performance, critical for Medicare Advantage quality bonus payments and member retention"
  source: "`health_insurance_ecm`.`care`.`cahps_survey`"
  dimensions:
    - name: "survey_status"
      expr: survey_status
      comment: "Status of CAHPS survey (completed, pending, non-response, invalid)"
    - name: "survey_type"
      expr: survey_type
      comment: "Type of CAHPS survey (Medicare, Medicaid, Commercial)"
    - name: "administration_method"
      expr: administration_method
      comment: "Method of survey administration (mail, phone, web, mixed-mode)"
    - name: "survey_language"
      expr: survey_language
      comment: "Language in which survey was administered"
    - name: "survey_mode"
      expr: survey_mode
      comment: "Mode of survey delivery (paper, electronic, telephonic)"
    - name: "member_age"
      expr: member_age
      comment: "Age group of survey respondent"
    - name: "member_gender"
      expr: member_gender
      comment: "Gender of survey respondent"
    - name: "member_state"
      expr: member_state
      comment: "State of residence of survey respondent"
    - name: "composite_score_flag"
      expr: composite_score_flag
      comment: "Flag indicating whether result is a composite score"
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Flag indicating whether survey is used for regulatory reporting"
    - name: "survey_year"
      expr: YEAR(survey_start_date)
      comment: "Year of survey administration"
  measures:
    - name: "total_surveys"
      expr: COUNT(1)
      comment: "Total number of CAHPS surveys administered"
    - name: "completed_surveys"
      expr: COUNT(CASE WHEN survey_status = 'completed' THEN 1 END)
      comment: "Count of completed CAHPS surveys"
    - name: "avg_response_rate"
      expr: AVG(CAST(response_rate AS DOUBLE))
      comment: "Average survey response rate, critical for CAHPS validity and CMS reporting requirements"
    - name: "avg_overall_satisfaction"
      expr: AVG(CAST(overall_satisfaction_score AS DOUBLE))
      comment: "Average overall member satisfaction score, key driver of Star Ratings and member retention"
    - name: "avg_doctor_communication"
      expr: AVG(CAST(doctor_communication_score AS DOUBLE))
      comment: "Average doctor communication score, CAHPS composite measure impacting Star Ratings"
    - name: "avg_customer_service"
      expr: AVG(CAST(customer_service_score AS DOUBLE))
      comment: "Average customer service score, CAHPS composite measure impacting Star Ratings"
    - name: "avg_getting_care_quickly"
      expr: AVG(CAST(getting_care_quickly_score AS DOUBLE))
      comment: "Average getting care quickly score, CAHPS composite measure impacting Star Ratings and access to care"
    - name: "avg_getting_needed_care"
      expr: AVG(CAST(getting_needed_care_score AS DOUBLE))
      comment: "Average getting needed care score, CAHPS composite measure impacting Star Ratings and care access"
    - name: "avg_star_rating_impact"
      expr: AVG(CAST(star_rating_impact_score AS DOUBLE))
      comment: "Average Star Rating impact score, measuring contribution to overall Medicare Advantage Star Rating"
    - name: "unique_members_surveyed"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Distinct count of members who received CAHPS surveys"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`care_hra`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health Risk Assessment metrics tracking member health status, risk stratification, and social determinants of health for population health management and care coordination"
  source: "`health_insurance_ecm`.`care`.`hra`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Status of HRA completion (completed, partial, not started, expired)"
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of health risk assessment (initial, annual, post-discharge, condition-specific)"
    - name: "completion_channel"
      expr: completion_channel
      comment: "Channel through which HRA was completed (phone, web, mail, in-person)"
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier assignment based on HRA results (low, moderate, high, very high)"
    - name: "screening_tool"
      expr: screening_tool
      comment: "Screening tool or instrument used for assessment"
    - name: "sdoh_food_insecurity"
      expr: sdoh_food_insecurity
      comment: "Flag indicating food insecurity identified in assessment"
    - name: "sdoh_housing_instability"
      expr: sdoh_housing_instability
      comment: "Flag indicating housing instability identified in assessment"
    - name: "sdoh_transportation"
      expr: sdoh_transportation
      comment: "Flag indicating transportation barriers identified in assessment"
    - name: "sdoh_social_isolation"
      expr: sdoh_social_isolation
      comment: "Flag indicating social isolation identified in assessment"
    - name: "sdoh_financial_strain"
      expr: sdoh_financial_strain
      comment: "Flag indicating financial strain identified in assessment"
    - name: "compliance_cms_required"
      expr: compliance_cms_required
      comment: "Flag indicating whether HRA is CMS-required for Medicare Advantage"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of HRA completion"
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of HRA completion"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of health risk assessments conducted"
    - name: "completed_assessments"
      expr: COUNT(CASE WHEN assessment_status = 'completed' THEN 1 END)
      comment: "Count of completed HRAs, key metric for CMS compliance and care management engagement"
    - name: "hra_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN assessment_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of HRAs completed, critical for Medicare Advantage Star Ratings and member engagement"
    - name: "avg_risk_score_percentile"
      expr: AVG(CAST(risk_score_percentile AS DOUBLE))
      comment: "Average risk score percentile across completed HRAs, indicating population health complexity"
    - name: "sdoh_food_insecurity_count"
      expr: COUNT(CASE WHEN sdoh_food_insecurity = TRUE THEN 1 END)
      comment: "Count of members with identified food insecurity, critical for social care interventions"
    - name: "sdoh_housing_instability_count"
      expr: COUNT(CASE WHEN sdoh_housing_instability = TRUE THEN 1 END)
      comment: "Count of members with identified housing instability, critical for social care interventions"
    - name: "sdoh_transportation_barriers_count"
      expr: COUNT(CASE WHEN sdoh_transportation = TRUE THEN 1 END)
      comment: "Count of members with transportation barriers, impacting care access and adherence"
    - name: "any_sdoh_barrier_count"
      expr: COUNT(CASE WHEN (sdoh_food_insecurity = TRUE OR sdoh_housing_instability = TRUE OR sdoh_transportation = TRUE OR sdoh_social_isolation = TRUE OR sdoh_financial_strain = TRUE) THEN 1 END)
      comment: "Count of members with any identified social determinant of health barrier, driving whole-person care strategies"
    - name: "unique_members_assessed"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct count of members who completed health risk assessments"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`care_member_outreach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member outreach and engagement metrics tracking care coordination touchpoints, gap closure interventions, and member communication effectiveness"
  source: "`health_insurance_ecm`.`care`.`member_outreach`"
  dimensions:
    - name: "member_outreach_status"
      expr: member_outreach_status
      comment: "Status of outreach attempt (successful, unsuccessful, pending, scheduled)"
    - name: "channel"
      expr: channel
      comment: "Communication channel used for outreach (phone, email, SMS, mail, portal)"
    - name: "purpose"
      expr: purpose
      comment: "Purpose of member outreach (gap closure, care coordination, wellness, education)"
    - name: "outcome"
      expr: outcome
      comment: "Outcome of outreach attempt (contacted, left message, no answer, wrong number, completed)"
    - name: "is_automated"
      expr: is_automated
      comment: "Flag indicating whether outreach was automated or manual"
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Flag indicating whether follow-up outreach is required"
    - name: "compliance_consent_obtained"
      expr: compliance_consent_obtained
      comment: "Flag indicating whether member consent was obtained for outreach"
    - name: "language_preference"
      expr: language_preference
      comment: "Member language preference for outreach"
    - name: "outreach_year"
      expr: YEAR(outreach_timestamp)
      comment: "Year of outreach attempt"
    - name: "outreach_month"
      expr: DATE_TRUNC('MONTH', outreach_timestamp)
      comment: "Month of outreach attempt"
  measures:
    - name: "total_outreach_attempts"
      expr: COUNT(1)
      comment: "Total number of member outreach attempts across all channels and purposes"
    - name: "successful_outreach_count"
      expr: COUNT(CASE WHEN member_outreach_status = 'successful' THEN 1 END)
      comment: "Count of successful member outreach contacts"
    - name: "outreach_success_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN member_outreach_status = 'successful' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of successful outreach attempts, measuring care coordination effectiveness and member engagement"
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_required = TRUE THEN 1 END)
      comment: "Count of outreach attempts requiring follow-up, indicating unresolved member needs"
    - name: "unique_members_contacted"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct count of members contacted through outreach efforts"
    - name: "automated_outreach_count"
      expr: COUNT(CASE WHEN is_automated = TRUE THEN 1 END)
      comment: "Count of automated outreach attempts"
    - name: "manual_outreach_count"
      expr: COUNT(CASE WHEN is_automated = FALSE THEN 1 END)
      comment: "Count of manual outreach attempts requiring care coordinator time"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`care_condition_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chronic condition registry metrics tracking disease prevalence, risk adjustment factor impact, and condition management for population health and revenue optimization"
  source: "`health_insurance_ecm`.`care`.`condition_registry`"
  dimensions:
    - name: "condition_category"
      expr: condition_category
      comment: "Category of chronic condition (cardiovascular, diabetes, respiratory, oncology, etc.)"
    - name: "condition_code"
      expr: condition_code
      comment: "Standardized condition code (ICD-10, SNOMED, HCC)"
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Status of condition confirmation (confirmed, suspected, ruled out, pending)"
    - name: "severity"
      expr: severity
      comment: "Severity level of condition (mild, moderate, severe, critical)"
    - name: "is_chronic"
      expr: is_chronic
      comment: "Flag indicating whether condition is chronic (long-term management required)"
    - name: "active_flag"
      expr: active_flag
      comment: "Flag indicating whether condition is currently active"
    - name: "risk_adjustment_flag"
      expr: risk_adjustment_flag
      comment: "Flag indicating whether condition impacts risk adjustment and CMS payments"
    - name: "population_segment"
      expr: population_segment
      comment: "Population segment for condition (Medicare, Medicaid, Commercial)"
    - name: "identification_method"
      expr: identification_method
      comment: "Method used to identify condition (claims, chart review, lab, provider report)"
    - name: "data_quality_status"
      expr: data_quality_status
      comment: "Data quality status of condition record (validated, pending review, incomplete)"
    - name: "identification_year"
      expr: YEAR(identification_date)
      comment: "Year condition was identified"
  measures:
    - name: "total_conditions"
      expr: COUNT(1)
      comment: "Total number of conditions recorded in registry"
    - name: "active_conditions"
      expr: COUNT(CASE WHEN active_flag = TRUE THEN 1 END)
      comment: "Count of currently active conditions requiring ongoing management"
    - name: "chronic_conditions"
      expr: COUNT(CASE WHEN is_chronic = TRUE THEN 1 END)
      comment: "Count of chronic conditions, key driver of care management program eligibility"
    - name: "risk_adjustment_conditions"
      expr: COUNT(CASE WHEN risk_adjustment_flag = TRUE THEN 1 END)
      comment: "Count of conditions impacting risk adjustment, directly affecting CMS revenue"
    - name: "avg_raf_score"
      expr: AVG(CAST(raf_score AS DOUBLE))
      comment: "Average Risk Adjustment Factor score, primary driver of Medicare Advantage capitation payments"
    - name: "total_raf_impact"
      expr: SUM(CAST(raf_score AS DOUBLE))
      comment: "Total RAF score impact across all conditions, measuring revenue optimization opportunity"
    - name: "unique_members_with_conditions"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct count of members with registered conditions"
    - name: "confirmed_conditions"
      expr: COUNT(CASE WHEN confirmation_status = 'confirmed' THEN 1 END)
      comment: "Count of confirmed conditions with clinical validation"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`care_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care management program metrics tracking program performance, enrollment capacity, evidence-based outcomes, and value-based care alignment"
  source: "`health_insurance_ecm`.`care`.`program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current status of care management program (active, inactive, pilot, sunset)"
    - name: "program_type"
      expr: program_type
      comment: "Type of care management program (disease management, case management, wellness, transition of care)"
    - name: "program_category"
      expr: program_category
      comment: "Category of program (chronic care, preventive, behavioral health, maternity)"
    - name: "target_population"
      expr: target_population
      comment: "Target population for program (high-risk, chronic condition, post-discharge, preventive)"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for program (Medicare, Medicaid, Commercial, Dual Eligible)"
    - name: "is_evidence_based"
      expr: is_evidence_based
      comment: "Flag indicating whether program is evidence-based (required for NCQA accreditation)"
    - name: "hcc_included"
      expr: hcc_included
      comment: "HCC categories included in program eligibility"
    - name: "program_year"
      expr: YEAR(start_date)
      comment: "Year program was launched"
  measures:
    - name: "total_programs"
      expr: COUNT(1)
      comment: "Total number of care management programs"
    - name: "active_programs"
      expr: COUNT(CASE WHEN program_status = 'active' THEN 1 END)
      comment: "Count of currently active care management programs"
    - name: "total_enrollment_capacity"
      expr: SUM(CAST(enrollment_cap AS DOUBLE))
      comment: "Total enrollment capacity across all programs"
    - name: "total_current_enrollment"
      expr: SUM(CAST(enrollment_current AS DOUBLE))
      comment: "Total current enrollment across all programs"
    - name: "avg_enrollment_utilization"
      expr: ROUND(100.0 * SUM(CAST(enrollment_current AS DOUBLE)) / NULLIF(SUM(CAST(enrollment_cap AS DOUBLE)), 0), 2)
      comment: "Average enrollment utilization rate across programs, measuring capacity management and demand"
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor across programs, indicating program complexity and revenue impact"
    - name: "evidence_based_program_count"
      expr: COUNT(CASE WHEN is_evidence_based = TRUE THEN 1 END)
      comment: "Count of evidence-based programs, required for NCQA accreditation and quality reporting"
$$;