-- Metric views for domain: beneficiary | Business: Ngo | Version: 1 | Generated on: 2026-05-07 01:23:35

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`beneficiary_registrant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core beneficiary registration metrics tracking enrollment, verification, and vulnerability profiles for program planning and resource allocation"
  source: "`ngo_ecm`.`beneficiary`.`registrant`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current status of beneficiary registration (active, pending, verified, suspended)"
    - name: "registration_type"
      expr: registration_type
      comment: "Type of registration process (new, re-registration, update)"
    - name: "registration_modality"
      expr: registration_modality
      comment: "Method of registration (in-person, mobile, remote, community-based)"
    - name: "vulnerability_category"
      expr: vulnerability_category
      comment: "Vulnerability classification for targeting and prioritization"
    - name: "poc_category"
      expr: poc_category
      comment: "Person of Concern category (refugee, IDP, returnee, host community)"
    - name: "sex"
      expr: sex
      comment: "Biological sex of registrant"
    - name: "nationality_code"
      expr: nationality_code
      comment: "ISO country code of registrant nationality"
    - name: "country_of_origin_code"
      expr: country_of_origin_code
      comment: "ISO country code of origin for displaced persons"
    - name: "deduplication_status"
      expr: deduplication_status
      comment: "Status of deduplication check (unique, duplicate, master, merged)"
    - name: "registration_year"
      expr: YEAR(registration_date)
      comment: "Year of initial registration"
    - name: "registration_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Month of initial registration"
    - name: "has_disability"
      expr: has_disability
      comment: "Flag indicating if registrant has a disability"
    - name: "is_gbv_survivor"
      expr: is_gbv_survivor
      comment: "Flag indicating gender-based violence survivor status"
    - name: "is_unaccompanied_minor"
      expr: is_unaccompanied_minor
      comment: "Flag indicating unaccompanied minor status"
    - name: "protection_flag"
      expr: protection_flag
      comment: "Flag indicating protection concerns requiring special attention"
  measures:
    - name: "total_registrants"
      expr: COUNT(DISTINCT registrant_id)
      comment: "Total unique beneficiaries registered in the system"
    - name: "avg_vulnerability_score"
      expr: AVG(CAST(vulnerability_score AS DOUBLE))
      comment: "Average vulnerability score across registrants for targeting effectiveness"
    - name: "high_vulnerability_registrants"
      expr: COUNT(DISTINCT CASE WHEN CAST(vulnerability_score AS DOUBLE) >= 70 THEN registrant_id END)
      comment: "Count of registrants with high vulnerability scores requiring priority assistance"
    - name: "avg_data_completeness_score"
      expr: AVG(CAST(completeness_score AS DOUBLE))
      comment: "Average data completeness score indicating registration data quality"
    - name: "verified_registrants"
      expr: COUNT(DISTINCT CASE WHEN last_verification_date IS NOT NULL THEN registrant_id END)
      comment: "Count of registrants with completed verification for program integrity"
    - name: "protection_concern_registrants"
      expr: COUNT(DISTINCT CASE WHEN protection_flag = TRUE THEN registrant_id END)
      comment: "Count of registrants flagged with protection concerns requiring specialized services"
    - name: "gbv_survivor_registrants"
      expr: COUNT(DISTINCT CASE WHEN is_gbv_survivor = TRUE THEN registrant_id END)
      comment: "Count of gender-based violence survivors requiring specialized protection services"
    - name: "unaccompanied_minor_registrants"
      expr: COUNT(DISTINCT CASE WHEN is_unaccompanied_minor = TRUE THEN registrant_id END)
      comment: "Count of unaccompanied minors requiring child protection services"
    - name: "disability_registrants"
      expr: COUNT(DISTINCT CASE WHEN has_disability = TRUE THEN registrant_id END)
      comment: "Count of registrants with disabilities for accessibility planning"
    - name: "pregnant_lactating_registrants"
      expr: COUNT(DISTINCT CASE WHEN is_pregnant_or_lactating = TRUE THEN registrant_id END)
      comment: "Count of pregnant or lactating women for maternal health and nutrition programs"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`beneficiary_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level metrics for family assistance planning, vulnerability assessment, and resource allocation at household unit"
  source: "`ngo_ecm`.`beneficiary`.`household`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current household registration status"
    - name: "displacement_status"
      expr: displacement_status
      comment: "Displacement category (refugee, IDP, returnee, host)"
    - name: "vulnerability_category"
      expr: vulnerability_category
      comment: "Household vulnerability classification"
    - name: "is_female_headed"
      expr: is_female_headed
      comment: "Flag indicating female-headed household"
    - name: "shelter_type"
      expr: shelter_type
      comment: "Type of shelter occupied by household"
    - name: "food_security_status"
      expr: food_security_status
      comment: "Food security classification (secure, moderately insecure, severely insecure)"
    - name: "registration_year"
      expr: YEAR(registration_date)
      comment: "Year household was registered"
    - name: "registration_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Month household was registered"
    - name: "current_country"
      expr: current_country
      comment: "Country where household currently resides"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for displaced households"
    - name: "gbv_risk_flag"
      expr: gbv_risk_flag
      comment: "Flag indicating household at risk of gender-based violence"
    - name: "has_pregnant_lactating"
      expr: has_pregnant_lactating
      comment: "Flag indicating presence of pregnant or lactating women"
    - name: "has_unaccompanied_minor"
      expr: has_unaccompanied_minor
      comment: "Flag indicating presence of unaccompanied minors"
  measures:
    - name: "total_households"
      expr: COUNT(DISTINCT household_id)
      comment: "Total unique households registered for program coverage analysis"
    - name: "avg_household_size"
      expr: AVG(CAST(size AS DOUBLE))
      comment: "Average household size for resource planning and distribution calculations"
    - name: "avg_vulnerability_score"
      expr: AVG(CAST(vulnerability_score AS DOUBLE))
      comment: "Average household vulnerability score for targeting and prioritization"
    - name: "total_household_members"
      expr: SUM(CAST(size AS DOUBLE))
      comment: "Total individuals across all households for population coverage metrics"
    - name: "female_headed_households"
      expr: COUNT(DISTINCT CASE WHEN is_female_headed = TRUE THEN household_id END)
      comment: "Count of female-headed households for gender-responsive programming"
    - name: "high_vulnerability_households"
      expr: COUNT(DISTINCT CASE WHEN CAST(vulnerability_score AS DOUBLE) >= 70 THEN household_id END)
      comment: "Count of high-vulnerability households requiring priority assistance"
    - name: "gbv_risk_households"
      expr: COUNT(DISTINCT CASE WHEN gbv_risk_flag = TRUE THEN household_id END)
      comment: "Count of households at GBV risk requiring protection interventions"
    - name: "total_children_under5"
      expr: SUM(CAST(children_under5_count AS DOUBLE))
      comment: "Total children under 5 years for nutrition and health program planning"
    - name: "total_elderly_members"
      expr: SUM(CAST(elderly_count AS DOUBLE))
      comment: "Total elderly household members for specialized care planning"
    - name: "total_pwd_members"
      expr: SUM(CAST(pwd_count AS DOUBLE))
      comment: "Total persons with disabilities for accessibility and specialized services"
    - name: "households_with_pregnant_lactating"
      expr: COUNT(DISTINCT CASE WHEN has_pregnant_lactating = TRUE THEN household_id END)
      comment: "Count of households with pregnant or lactating women for maternal health programs"
    - name: "households_with_unaccompanied_minors"
      expr: COUNT(DISTINCT CASE WHEN has_unaccompanied_minor = TRUE THEN household_id END)
      comment: "Count of households with unaccompanied minors for child protection services"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`beneficiary_case_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Case management metrics tracking protection cases, psychosocial support, and service delivery outcomes for vulnerable beneficiaries"
  source: "`ngo_ecm`.`beneficiary`.`case_record`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of case (open, closed, on-hold, transferred)"
    - name: "case_type"
      expr: case_type
      comment: "Type of case (protection, GBV, child protection, legal aid, psychosocial)"
    - name: "case_stage"
      expr: case_stage
      comment: "Current stage in case management workflow"
    - name: "priority_level"
      expr: priority_level
      comment: "Case priority level (urgent, high, medium, low)"
    - name: "protection_risk_level"
      expr: protection_risk_level
      comment: "Protection risk assessment level"
    - name: "is_gbv_case"
      expr: is_gbv_case
      comment: "Flag indicating gender-based violence case"
    - name: "is_child_case"
      expr: is_child_case
      comment: "Flag indicating child protection case"
    - name: "outcome_classification"
      expr: outcome_classification
      comment: "Final outcome classification of closed cases"
    - name: "service_modality"
      expr: service_modality
      comment: "Service delivery modality (in-person, remote, mobile, community)"
    - name: "open_year"
      expr: YEAR(open_date)
      comment: "Year case was opened"
    - name: "open_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month case was opened"
    - name: "legal_aid_required"
      expr: legal_aid_required
      comment: "Flag indicating legal aid requirement"
    - name: "safety_plan_in_place"
      expr: safety_plan_in_place
      comment: "Flag indicating safety plan established"
  measures:
    - name: "total_cases"
      expr: COUNT(DISTINCT case_record_id)
      comment: "Total case records for caseload management and capacity planning"
    - name: "open_cases"
      expr: COUNT(DISTINCT CASE WHEN case_status = 'open' THEN case_record_id END)
      comment: "Count of currently open cases for active caseload monitoring"
    - name: "closed_cases"
      expr: COUNT(DISTINCT CASE WHEN case_status = 'closed' THEN case_record_id END)
      comment: "Count of closed cases for outcome analysis and completion rates"
    - name: "gbv_cases"
      expr: COUNT(DISTINCT CASE WHEN is_gbv_case = TRUE THEN case_record_id END)
      comment: "Count of gender-based violence cases for specialized GBV programming"
    - name: "child_protection_cases"
      expr: COUNT(DISTINCT CASE WHEN is_child_case = TRUE THEN case_record_id END)
      comment: "Count of child protection cases for child safeguarding monitoring"
    - name: "urgent_priority_cases"
      expr: COUNT(DISTINCT CASE WHEN priority_level = 'urgent' THEN case_record_id END)
      comment: "Count of urgent cases requiring immediate response"
    - name: "cases_with_safety_plan"
      expr: COUNT(DISTINCT CASE WHEN safety_plan_in_place = TRUE THEN case_record_id END)
      comment: "Count of cases with established safety plans for protection effectiveness"
    - name: "legal_aid_cases"
      expr: COUNT(DISTINCT CASE WHEN legal_aid_required = TRUE THEN case_record_id END)
      comment: "Count of cases requiring legal aid for legal services planning"
    - name: "avg_pss_sessions"
      expr: AVG(CAST(pss_session_count AS DOUBLE))
      comment: "Average psychosocial support sessions per case for service intensity analysis"
    - name: "cases_with_plan_developed"
      expr: COUNT(DISTINCT CASE WHEN case_plan_developed = TRUE THEN case_record_id END)
      comment: "Count of cases with developed case plans for case management quality"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`beneficiary_referral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Referral pathway metrics tracking inter-agency coordination, service linkages, and referral completion rates for integrated service delivery"
  source: "`ngo_ecm`.`beneficiary`.`referral`"
  dimensions:
    - name: "referral_status"
      expr: referral_status
      comment: "Current status of referral (pending, accepted, declined, completed, cancelled)"
    - name: "referral_type"
      expr: referral_type
      comment: "Type of referral (internal, external, emergency, routine)"
    - name: "referral_category"
      expr: referral_category
      comment: "Service category of referral (health, protection, legal, psychosocial, livelihood)"
    - name: "priority_level"
      expr: priority_level
      comment: "Referral priority level (urgent, high, medium, low)"
    - name: "outcome"
      expr: outcome
      comment: "Referral outcome (successful, partially successful, unsuccessful)"
    - name: "outcome_category"
      expr: outcome_category
      comment: "Categorized outcome for analysis"
    - name: "receiving_service_type"
      expr: receiving_service_type
      comment: "Type of service at receiving organization"
    - name: "gbv_case_flag"
      expr: gbv_case_flag
      comment: "Flag indicating GBV-related referral"
    - name: "protection_concern_flag"
      expr: protection_concern_flag
      comment: "Flag indicating protection concern referral"
    - name: "referral_year"
      expr: YEAR(referral_date)
      comment: "Year referral was made"
    - name: "referral_month"
      expr: DATE_TRUNC('MONTH', referral_date)
      comment: "Month referral was made"
    - name: "consent_obtained_flag"
      expr: consent_obtained_flag
      comment: "Flag indicating beneficiary consent obtained"
    - name: "follow_up_completed_flag"
      expr: follow_up_completed_flag
      comment: "Flag indicating follow-up completed"
  measures:
    - name: "total_referrals"
      expr: COUNT(DISTINCT referral_id)
      comment: "Total referrals made for inter-agency coordination monitoring"
    - name: "completed_referrals"
      expr: COUNT(DISTINCT CASE WHEN referral_status = 'completed' THEN referral_id END)
      comment: "Count of completed referrals for service delivery effectiveness"
    - name: "accepted_referrals"
      expr: COUNT(DISTINCT CASE WHEN referral_status = 'accepted' THEN referral_id END)
      comment: "Count of accepted referrals for pathway effectiveness analysis"
    - name: "declined_referrals"
      expr: COUNT(DISTINCT CASE WHEN referral_status = 'declined' THEN referral_id END)
      comment: "Count of declined referrals for service gap identification"
    - name: "gbv_referrals"
      expr: COUNT(DISTINCT CASE WHEN gbv_case_flag = TRUE THEN referral_id END)
      comment: "Count of GBV-related referrals for specialized GBV pathway monitoring"
    - name: "protection_referrals"
      expr: COUNT(DISTINCT CASE WHEN protection_concern_flag = TRUE THEN referral_id END)
      comment: "Count of protection concern referrals for protection coordination"
    - name: "urgent_referrals"
      expr: COUNT(DISTINCT CASE WHEN priority_level = 'urgent' THEN referral_id END)
      comment: "Count of urgent referrals for emergency response capacity"
    - name: "referrals_with_consent"
      expr: COUNT(DISTINCT CASE WHEN consent_obtained_flag = TRUE THEN referral_id END)
      comment: "Count of referrals with beneficiary consent for ethical compliance"
    - name: "referrals_with_followup"
      expr: COUNT(DISTINCT CASE WHEN follow_up_completed_flag = TRUE THEN referral_id END)
      comment: "Count of referrals with completed follow-up for quality assurance"
    - name: "successful_outcome_referrals"
      expr: COUNT(DISTINCT CASE WHEN outcome = 'successful' THEN referral_id END)
      comment: "Count of referrals with successful outcomes for pathway effectiveness"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`beneficiary_needs_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Multi-sectoral needs assessment metrics tracking vulnerability, sectoral needs scores, and assessment coverage for evidence-based program design"
  source: "`ngo_ecm`.`beneficiary`.`beneficiary_needs_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of needs assessment (draft, validated, approved, rejected)"
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of assessment (initial, follow-up, rapid, comprehensive)"
    - name: "assessment_level"
      expr: assessment_level
      comment: "Level of assessment (individual, household, community)"
    - name: "vulnerability_category"
      expr: vulnerability_category
      comment: "Vulnerability classification from assessment"
    - name: "displacement_status"
      expr: displacement_status
      comment: "Displacement status of assessed population"
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Method used for data collection (face-to-face, phone, mobile app)"
    - name: "country_code"
      expr: country_code
      comment: "Country where assessment was conducted"
    - name: "admin1_name"
      expr: admin1_name
      comment: "First-level administrative division"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year assessment was conducted"
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month assessment was conducted"
    - name: "female_headed_household"
      expr: female_headed_household
      comment: "Flag indicating female-headed household assessed"
    - name: "gbv_risk_flag"
      expr: gbv_risk_flag
      comment: "Flag indicating GBV risk identified"
    - name: "referral_recommended"
      expr: referral_recommended
      comment: "Flag indicating referral recommended from assessment"
    - name: "consent_obtained"
      expr: consent_obtained
      comment: "Flag indicating consent obtained for assessment"
  measures:
    - name: "total_assessments"
      expr: COUNT(DISTINCT beneficiary_needs_assessment_id)
      comment: "Total needs assessments conducted for coverage monitoring"
    - name: "avg_overall_vulnerability_score"
      expr: AVG(CAST(overall_vulnerability_score AS DOUBLE))
      comment: "Average overall vulnerability score for population-level vulnerability analysis"
    - name: "avg_nutrition_score"
      expr: AVG(CAST(nutrition_score AS DOUBLE))
      comment: "Average nutrition needs score for food security and nutrition programming"
    - name: "avg_wash_score"
      expr: AVG(CAST(wash_score AS DOUBLE))
      comment: "Average WASH needs score for water, sanitation, and hygiene interventions"
    - name: "avg_shelter_score"
      expr: AVG(CAST(shelter_score AS DOUBLE))
      comment: "Average shelter needs score for shelter and NFI programming"
    - name: "avg_protection_score"
      expr: AVG(CAST(protection_score AS DOUBLE))
      comment: "Average protection needs score for protection programming prioritization"
    - name: "avg_education_score"
      expr: AVG(CAST(education_score AS DOUBLE))
      comment: "Average education needs score for education programming"
    - name: "avg_livelihoods_score"
      expr: AVG(CAST(livelihoods_score AS DOUBLE))
      comment: "Average livelihoods needs score for economic recovery programming"
    - name: "high_vulnerability_assessments"
      expr: COUNT(DISTINCT CASE WHEN CAST(overall_vulnerability_score AS DOUBLE) >= 70 THEN beneficiary_needs_assessment_id END)
      comment: "Count of assessments identifying high vulnerability for targeting"
    - name: "gbv_risk_assessments"
      expr: COUNT(DISTINCT CASE WHEN gbv_risk_flag = TRUE THEN beneficiary_needs_assessment_id END)
      comment: "Count of assessments identifying GBV risk for protection response"
    - name: "assessments_with_referral"
      expr: COUNT(DISTINCT CASE WHEN referral_recommended = TRUE THEN beneficiary_needs_assessment_id END)
      comment: "Count of assessments recommending referrals for service linkage effectiveness"
    - name: "validated_assessments"
      expr: COUNT(DISTINCT CASE WHEN assessment_status = 'validated' THEN beneficiary_needs_assessment_id END)
      comment: "Count of validated assessments for data quality monitoring"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`beneficiary_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program enrollment and participation metrics tracking beneficiary engagement, completion rates, and service delivery effectiveness"
  source: "`ngo_ecm`.`beneficiary`.`enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (active, completed, withdrawn, suspended)"
    - name: "service_delivery_modality"
      expr: service_delivery_modality
      comment: "Modality of service delivery (in-person, remote, hybrid, mobile)"
    - name: "referral_source"
      expr: referral_source
      comment: "Source of referral to program"
    - name: "exit_reason"
      expr: exit_reason
      comment: "Reason for program exit or withdrawal"
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year of enrollment"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment"
    - name: "consent_for_component"
      expr: consent_for_component
      comment: "Flag indicating consent obtained for program component"
  measures:
    - name: "total_enrollments"
      expr: COUNT(DISTINCT enrollment_id)
      comment: "Total program enrollments for program reach and coverage analysis"
    - name: "active_enrollments"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'active' THEN enrollment_id END)
      comment: "Count of currently active enrollments for active caseload monitoring"
    - name: "completed_enrollments"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'completed' THEN enrollment_id END)
      comment: "Count of completed enrollments for program completion rate analysis"
    - name: "withdrawn_enrollments"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'withdrawn' THEN enrollment_id END)
      comment: "Count of withdrawn enrollments for attrition analysis and program improvement"
    - name: "avg_attendance_rate"
      expr: AVG(CAST(attendance_rate AS DOUBLE))
      comment: "Average attendance rate across enrollments for engagement effectiveness"
    - name: "unique_beneficiaries_enrolled"
      expr: COUNT(DISTINCT registrant_id)
      comment: "Unique beneficiaries enrolled for unduplicated reach metrics"
    - name: "enrollments_with_consent"
      expr: COUNT(DISTINCT CASE WHEN consent_for_component = TRUE THEN enrollment_id END)
      comment: "Count of enrollments with documented consent for ethical compliance"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`beneficiary_vulnerability_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Comprehensive vulnerability profiling metrics tracking multi-dimensional vulnerability factors for evidence-based targeting and prioritization"
  source: "`ngo_ecm`.`beneficiary`.`vulnerability_profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of vulnerability profile (active, expired, under_review)"
    - name: "vulnerability_tier"
      expr: vulnerability_tier
      comment: "Vulnerability tier classification (tier1_critical, tier2_high, tier3_moderate, tier4_low)"
    - name: "displacement_category"
      expr: displacement_category
      comment: "Displacement category of profiled individual or household"
    - name: "protection_risk_level"
      expr: protection_risk_level
      comment: "Protection risk level assessment"
    - name: "ipc_phase"
      expr: ipc_phase
      comment: "Integrated Food Security Phase Classification"
    - name: "nutritional_status"
      expr: nutritional_status
      comment: "Nutritional status classification"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year vulnerability assessment was conducted"
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month vulnerability assessment was conducted"
    - name: "female_headed_household_flag"
      expr: female_headed_household_flag
      comment: "Flag indicating female-headed household"
    - name: "gbv_exposure_flag"
      expr: gbv_exposure_flag
      comment: "Flag indicating GBV exposure"
    - name: "chronic_illness_flag"
      expr: chronic_illness_flag
      comment: "Flag indicating chronic illness present"
    - name: "elderly_member_flag"
      expr: elderly_member_flag
      comment: "Flag indicating elderly household member"
    - name: "unaccompanied_minor_flag"
      expr: unaccompanied_minor_flag
      comment: "Flag indicating unaccompanied minor"
    - name: "pregnant_lactating_flag"
      expr: pregnant_lactating_flag
      comment: "Flag indicating pregnant or lactating woman"
    - name: "pss_need_flag"
      expr: pss_need_flag
      comment: "Flag indicating psychosocial support need"
  measures:
    - name: "total_vulnerability_profiles"
      expr: COUNT(DISTINCT vulnerability_profile_id)
      comment: "Total vulnerability profiles for vulnerability assessment coverage"
    - name: "avg_composite_vulnerability_score"
      expr: AVG(CAST(composite_vulnerability_score AS DOUBLE))
      comment: "Average composite vulnerability score for population-level vulnerability trends"
    - name: "critical_vulnerability_profiles"
      expr: COUNT(DISTINCT CASE WHEN vulnerability_tier = 'tier1_critical' THEN vulnerability_profile_id END)
      comment: "Count of critical vulnerability profiles requiring immediate priority assistance"
    - name: "high_vulnerability_profiles"
      expr: COUNT(DISTINCT CASE WHEN vulnerability_tier = 'tier2_high' THEN vulnerability_profile_id END)
      comment: "Count of high vulnerability profiles for priority targeting"
    - name: "gbv_exposure_profiles"
      expr: COUNT(DISTINCT CASE WHEN gbv_exposure_flag = TRUE THEN vulnerability_profile_id END)
      comment: "Count of profiles with GBV exposure for specialized GBV response"
    - name: "chronic_illness_profiles"
      expr: COUNT(DISTINCT CASE WHEN chronic_illness_flag = TRUE THEN vulnerability_profile_id END)
      comment: "Count of profiles with chronic illness for health service planning"
    - name: "pss_need_profiles"
      expr: COUNT(DISTINCT CASE WHEN pss_need_flag = TRUE THEN vulnerability_profile_id END)
      comment: "Count of profiles requiring psychosocial support for mental health programming"
    - name: "female_headed_profiles"
      expr: COUNT(DISTINCT CASE WHEN female_headed_household_flag = TRUE THEN vulnerability_profile_id END)
      comment: "Count of female-headed household profiles for gender-responsive programming"
    - name: "unaccompanied_minor_profiles"
      expr: COUNT(DISTINCT CASE WHEN unaccompanied_minor_flag = TRUE THEN vulnerability_profile_id END)
      comment: "Count of unaccompanied minor profiles for child protection prioritization"
    - name: "pregnant_lactating_profiles"
      expr: COUNT(DISTINCT CASE WHEN pregnant_lactating_flag = TRUE THEN vulnerability_profile_id END)
      comment: "Count of pregnant or lactating profiles for maternal and child health programs"
    - name: "ipc_phase_4_5_profiles"
      expr: COUNT(DISTINCT CASE WHEN ipc_phase IN ('4', '5') THEN vulnerability_profile_id END)
      comment: "Count of profiles in IPC phase 4 or 5 for emergency food security response"
$$;