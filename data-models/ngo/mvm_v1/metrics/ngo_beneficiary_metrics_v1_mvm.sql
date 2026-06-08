-- Metric views for domain: beneficiary | Business: Ngo | Version: 1 | Generated on: 2026-05-07 03:19:07

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`beneficiary_registrant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for beneficiary registrant population — tracks registration pipeline health, vulnerability composition, deduplication quality, and protection risk exposure across the beneficiary caseload."
  source: "`ngo_ecm`.`beneficiary`.`registrant`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current registration status of the beneficiary (e.g., Active, Pending, Deregistered) — used to segment pipeline and active caseload."
    - name: "registration_type"
      expr: registration_type
      comment: "Type of registration (e.g., New, Re-registration, Transfer) — distinguishes first-time registrations from repeat or transferred cases."
    - name: "sex"
      expr: sex
      comment: "Biological sex of the registrant — essential for gender-disaggregated reporting required by donors and humanitarian standards."
    - name: "vulnerability_category"
      expr: vulnerability_category
      comment: "Categorical vulnerability classification (e.g., Extreme, High, Medium, Low) — drives prioritization of service delivery."
    - name: "poc_category"
      expr: poc_category
      comment: "Person of Concern category (e.g., Refugee, IDP, Stateless, Asylum Seeker) — required for UNHCR and donor disaggregated reporting."
    - name: "nationality_code"
      expr: nationality_code
      comment: "ISO nationality code of the registrant — used for country-of-origin analysis and protection mandate tracking."
    - name: "deduplication_status"
      expr: deduplication_status
      comment: "Deduplication verification status (e.g., Unique, Duplicate, Pending) — critical for data quality and accurate beneficiary counts."
    - name: "registration_modality"
      expr: registration_modality
      comment: "Channel through which registration was conducted (e.g., In-person, Mobile, Online) — informs operational reach and digital inclusion."
    - name: "registration_date_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Month of registration — enables trend analysis of registration intake over time."
    - name: "country_of_origin_code"
      expr: country_of_origin_code
      comment: "Country of origin of the registrant — used for displacement and protection analysis."
  measures:
    - name: "total_registered_beneficiaries"
      expr: COUNT(DISTINCT registrant_id)
      comment: "Total unique registered beneficiaries — the primary headcount KPI for program scale and donor reporting."
    - name: "active_beneficiaries"
      expr: COUNT(DISTINCT CASE WHEN registration_status = 'Active' THEN registrant_id END)
      comment: "Count of beneficiaries with active registration status — reflects current active caseload for resource planning."
    - name: "female_beneficiaries"
      expr: COUNT(DISTINCT CASE WHEN sex = 'Female' THEN registrant_id END)
      comment: "Count of female-identified beneficiaries — mandatory gender disaggregation metric for donor compliance and equity tracking."
    - name: "beneficiaries_with_disability"
      expr: COUNT(DISTINCT CASE WHEN has_disability = TRUE THEN registrant_id END)
      comment: "Count of beneficiaries with a recorded disability — tracks inclusion of persons with disabilities (PWD) per humanitarian inclusion standards."
    - name: "unaccompanied_minors"
      expr: COUNT(DISTINCT CASE WHEN is_unaccompanied_minor = TRUE THEN registrant_id END)
      comment: "Count of unaccompanied and separated children (UASC) — a critical child protection KPI requiring immediate case management response."
    - name: "gbv_survivors"
      expr: COUNT(DISTINCT CASE WHEN is_gbv_survivor = TRUE THEN registrant_id END)
      comment: "Count of registered GBV survivors — drives allocation of specialized GBV case management and psychosocial support resources."
    - name: "pregnant_or_lactating_beneficiaries"
      expr: COUNT(DISTINCT CASE WHEN is_pregnant_or_lactating = TRUE THEN registrant_id END)
      comment: "Count of pregnant or lactating women — informs nutrition and maternal health program targeting."
    - name: "high_vulnerability_beneficiaries"
      expr: COUNT(DISTINCT CASE WHEN vulnerability_category IN ('Extreme', 'High') THEN registrant_id END)
      comment: "Count of beneficiaries in extreme or high vulnerability categories — used to prioritize targeting and resource allocation."
    - name: "avg_vulnerability_score"
      expr: AVG(CAST(vulnerability_score AS DOUBLE))
      comment: "Average composite vulnerability score across the registrant population — tracks overall population vulnerability trend over time."
    - name: "avg_data_completeness_score"
      expr: AVG(CAST(completeness_score AS DOUBLE))
      comment: "Average data completeness score across registrant records — measures data quality and registration process effectiveness."
    - name: "duplicate_registrants"
      expr: COUNT(DISTINCT CASE WHEN deduplication_status = 'Duplicate' THEN registrant_id END)
      comment: "Count of registrants flagged as duplicates — a data integrity KPI that directly affects accurate beneficiary counting and aid distribution fairness."
    - name: "protection_flagged_beneficiaries"
      expr: COUNT(DISTINCT CASE WHEN protection_flag = TRUE THEN registrant_id END)
      comment: "Count of beneficiaries with an active protection flag — indicates the scale of protection risk exposure requiring case management intervention."
    - name: "avg_muac_cm"
      expr: AVG(CAST(muac_cm AS DOUBLE))
      comment: "Average mid-upper arm circumference (MUAC) in centimeters across registrants — a key nutrition screening indicator for acute malnutrition prevalence."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`beneficiary_case_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Case management performance KPIs — tracks case pipeline, resolution rates, protection risk, and service delivery quality across the active caseload."
  source: "`ngo_ecm`.`beneficiary`.`case_record`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the case (e.g., Open, Closed, On Hold, Referred) — primary dimension for pipeline and workload analysis."
    - name: "case_type"
      expr: case_type
      comment: "Type of case (e.g., Protection, GBV, Child Protection, Nutrition) — used to segment caseload by service domain."
    - name: "case_stage"
      expr: case_stage
      comment: "Current stage in the case management workflow (e.g., Assessment, Planning, Implementation, Closure) — tracks case progression."
    - name: "priority_level"
      expr: priority_level
      comment: "Case priority classification (e.g., Critical, High, Medium, Low) — drives triage and resource allocation decisions."
    - name: "protection_risk_level"
      expr: protection_risk_level
      comment: "Assessed protection risk level for the case — used to escalate high-risk cases and allocate protection officers."
    - name: "outcome_classification"
      expr: outcome_classification
      comment: "Final outcome classification upon case closure (e.g., Resolved, Referred, Unresolved) — measures case management effectiveness."
    - name: "service_modality"
      expr: service_modality
      comment: "Modality through which services are delivered (e.g., In-person, Remote, Community-based) — informs operational delivery model."
    - name: "open_date_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the case was opened — enables intake trend analysis and seasonal caseload planning."
    - name: "close_date_month"
      expr: DATE_TRUNC('MONTH', close_date)
      comment: "Month the case was closed — used to track case resolution throughput over time."
    - name: "nutrition_status"
      expr: nutrition_status
      comment: "Nutrition status recorded at case level (e.g., SAM, MAM, Normal) — used for nutrition program targeting and outcome tracking."
  measures:
    - name: "total_cases"
      expr: COUNT(DISTINCT case_record_id)
      comment: "Total number of case records — primary caseload volume KPI for capacity planning and donor reporting."
    - name: "open_cases"
      expr: COUNT(DISTINCT CASE WHEN case_status = 'Open' THEN case_record_id END)
      comment: "Count of currently open cases — active workload indicator for case management staffing and resource allocation."
    - name: "closed_cases"
      expr: COUNT(DISTINCT CASE WHEN case_status = 'Closed' THEN case_record_id END)
      comment: "Count of closed cases — measures case resolution throughput and program completion rate."
    - name: "gbv_cases"
      expr: COUNT(DISTINCT CASE WHEN is_gbv_case = TRUE THEN case_record_id END)
      comment: "Count of GBV-related cases — a critical protection KPI for GBV program scale, donor reporting, and survivor support resource allocation."
    - name: "child_cases"
      expr: COUNT(DISTINCT CASE WHEN is_child_case = TRUE THEN case_record_id END)
      comment: "Count of child protection cases — tracks child protection caseload for specialized case management and safeguarding compliance."
    - name: "cases_with_safety_plan"
      expr: COUNT(DISTINCT CASE WHEN safety_plan_in_place = TRUE THEN case_record_id END)
      comment: "Count of cases where a safety plan has been developed — measures quality of protection case management and risk mitigation coverage."
    - name: "cases_requiring_legal_aid"
      expr: COUNT(DISTINCT CASE WHEN legal_aid_required = TRUE THEN case_record_id END)
      comment: "Count of cases requiring legal aid — informs legal assistance program demand and partner referral planning."
    - name: "cases_with_case_plan"
      expr: COUNT(DISTINCT CASE WHEN case_plan_developed = TRUE THEN case_record_id END)
      comment: "Count of cases with a developed case plan — measures adherence to case management standards and quality of individualized service planning."
    - name: "high_risk_protection_cases"
      expr: COUNT(DISTINCT CASE WHEN protection_risk_level IN ('High', 'Critical', 'Extreme') THEN case_record_id END)
      comment: "Count of cases with high or critical protection risk — drives immediate escalation, resource prioritization, and protection officer deployment."
    - name: "cases_pending_supervisor_review"
      expr: COUNT(DISTINCT CASE WHEN supervisor_review_required = TRUE THEN case_record_id END)
      comment: "Count of cases flagged for supervisor review — measures quality assurance backlog and supervisory oversight compliance."
    - name: "avg_muac_cm"
      expr: AVG(CAST(muac_cm AS DOUBLE))
      comment: "Average MUAC measurement (cm) across cases — tracks nutritional status of the case population and informs nutrition program targeting."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`beneficiary_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level KPIs for population profiling, vulnerability targeting, and food/shelter/WASH program planning across registered households."
  source: "`ngo_ecm`.`beneficiary`.`household`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current registration status of the household (e.g., Active, Deregistered, Pending) — primary filter for active program targeting."
    - name: "displacement_status"
      expr: displacement_status
      comment: "Displacement status of the household (e.g., IDP, Refugee, Host Community, Returnee) — required for displacement-disaggregated reporting."
    - name: "vulnerability_category"
      expr: vulnerability_category
      comment: "Vulnerability classification of the household — drives prioritization for food, cash, and shelter assistance."
    - name: "food_security_status"
      expr: food_security_status
      comment: "Food security classification (e.g., Food Secure, Moderately Food Insecure, Severely Food Insecure) — key targeting criterion for food assistance programs."
    - name: "shelter_type"
      expr: shelter_type
      comment: "Type of shelter occupied by the household (e.g., Tent, Makeshift, Permanent) — informs shelter program needs and NFI distribution planning."
    - name: "water_source_type"
      expr: water_source_type
      comment: "Primary water source type (e.g., Borehole, River, Piped) — used for WASH program targeting and water access gap analysis."
    - name: "current_country"
      expr: current_country
      comment: "Country where the household is currently located — enables geographic disaggregation for country-level program planning."
    - name: "registration_date_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Month of household registration — tracks registration intake trends and program enrollment velocity."
    - name: "admin1_name"
      expr: admin1_name
      comment: "Administrative level 1 area name (e.g., Province, State) — geographic dimension for sub-national program planning."
    - name: "admin2_name"
      expr: admin2_name
      comment: "Administrative level 2 area name (e.g., District, County) — finer geographic disaggregation for field operations."
  measures:
    - name: "total_households"
      expr: COUNT(DISTINCT household_id)
      comment: "Total registered households — primary household caseload KPI for program scale and beneficiary reach reporting."
    - name: "female_headed_households"
      expr: COUNT(DISTINCT CASE WHEN is_female_headed = TRUE THEN household_id END)
      comment: "Count of female-headed households — mandatory gender equity metric for targeting and donor disaggregated reporting."
    - name: "households_with_unaccompanied_minor"
      expr: COUNT(DISTINCT CASE WHEN has_unaccompanied_minor = TRUE THEN household_id END)
      comment: "Count of households containing unaccompanied or separated children — triggers child protection case management and specialized support."
    - name: "households_with_pregnant_lactating"
      expr: COUNT(DISTINCT CASE WHEN has_pregnant_lactating = TRUE THEN household_id END)
      comment: "Count of households with pregnant or lactating women — informs maternal nutrition and health program targeting."
    - name: "gbv_risk_households"
      expr: COUNT(DISTINCT CASE WHEN gbv_risk_flag = TRUE THEN household_id END)
      comment: "Count of households with a GBV risk flag — drives GBV prevention programming and protection monitoring at community level."
    - name: "avg_vulnerability_score"
      expr: AVG(CAST(vulnerability_score AS DOUBLE))
      comment: "Average vulnerability score across registered households — tracks population-level vulnerability trend for program targeting and donor reporting."
    - name: "avg_household_gps_latitude"
      expr: AVG(CAST(gps_latitude AS DOUBLE))
      comment: "Average GPS latitude of registered households — used for geographic centroid analysis and field team deployment planning."
    - name: "deregistered_households"
      expr: COUNT(DISTINCT CASE WHEN registration_status = 'Deregistered' THEN household_id END)
      comment: "Count of deregistered households — tracks program exit and attrition rate, informing caseload management and exit strategy effectiveness."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`beneficiary_needs_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Multi-sector needs assessment KPIs — tracks assessment coverage, sectoral vulnerability scores, and population needs profiles to drive program design and resource allocation."
  source: "`ngo_ecm`.`beneficiary`.`needs_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of needs assessment conducted (e.g., Rapid, Comprehensive, Sectoral) — used to segment assessment quality and depth."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (e.g., Completed, Pending Validation, Draft) — tracks assessment pipeline and data readiness."
    - name: "vulnerability_category"
      expr: vulnerability_category
      comment: "Vulnerability category assigned by the assessment — used to segment population by assessed need level."
    - name: "displacement_status"
      expr: displacement_status
      comment: "Displacement status of the assessed population — required for displacement-disaggregated needs analysis."
    - name: "assessment_level"
      expr: assessment_level
      comment: "Level at which the assessment was conducted (e.g., Individual, Household, Community) — determines unit of analysis for aggregation."
    - name: "country_code"
      expr: country_code
      comment: "Country where the assessment was conducted — enables country-level needs comparison and resource allocation."
    - name: "admin1_name"
      expr: admin1_name
      comment: "Administrative level 1 area of the assessment — geographic disaggregation for sub-national program planning."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment — tracks assessment coverage trends and seasonal needs patterns."
  measures:
    - name: "total_assessments_conducted"
      expr: COUNT(DISTINCT needs_assessment_id)
      comment: "Total needs assessments conducted — measures assessment coverage and data collection reach across the target population."
    - name: "assessments_with_referral_recommended"
      expr: COUNT(DISTINCT CASE WHEN referral_recommended = TRUE THEN needs_assessment_id END)
      comment: "Count of assessments where a referral was recommended — indicates the volume of cases requiring immediate service linkage."
    - name: "gbv_risk_assessments"
      expr: COUNT(DISTINCT CASE WHEN gbv_risk_flag = TRUE THEN needs_assessment_id END)
      comment: "Count of assessments identifying GBV risk — measures GBV exposure prevalence in the assessed population for protection program planning."
    - name: "avg_overall_vulnerability_score"
      expr: AVG(CAST(overall_vulnerability_score AS DOUBLE))
      comment: "Average composite vulnerability score across all assessments — the headline needs severity indicator for program design and donor reporting."
    - name: "avg_nutrition_score"
      expr: AVG(CAST(nutrition_score AS DOUBLE))
      comment: "Average nutrition sector score — tracks nutritional needs severity across the assessed population for nutrition program targeting."
    - name: "avg_protection_score"
      expr: AVG(CAST(protection_score AS DOUBLE))
      comment: "Average protection sector score — measures protection needs intensity to guide protection program investment and staffing."
    - name: "avg_wash_score"
      expr: AVG(CAST(wash_score AS DOUBLE))
      comment: "Average WASH (Water, Sanitation, Hygiene) sector score — informs WASH infrastructure investment and hygiene promotion program targeting."
    - name: "avg_shelter_score"
      expr: AVG(CAST(shelter_score AS DOUBLE))
      comment: "Average shelter sector score — tracks shelter needs severity for NFI and shelter program planning."
    - name: "avg_livelihoods_score"
      expr: AVG(CAST(livelihoods_score AS DOUBLE))
      comment: "Average livelihoods sector score — measures economic vulnerability for cash transfer and livelihood recovery program targeting."
    - name: "avg_education_score"
      expr: AVG(CAST(education_score AS DOUBLE))
      comment: "Average education sector score — tracks education access gaps for education in emergencies program design."
    - name: "avg_muac_mm"
      expr: AVG(CAST(muac_mm AS DOUBLE))
      comment: "Average MUAC measurement (mm) from assessments — a direct acute malnutrition screening indicator for nutrition emergency response."
    - name: "female_headed_household_assessments"
      expr: COUNT(DISTINCT CASE WHEN female_headed_household = TRUE THEN needs_assessment_id END)
      comment: "Count of assessments of female-headed households — tracks gender-disaggregated needs coverage for equity-focused program targeting."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`beneficiary_vulnerability_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vulnerability profiling KPIs — tracks composite vulnerability scores, multi-dimensional risk factors, and profile coverage to drive targeting, prioritization, and program eligibility decisions."
  source: "`ngo_ecm`.`beneficiary`.`vulnerability_profile`"
  dimensions:
    - name: "vulnerability_tier"
      expr: vulnerability_tier
      comment: "Vulnerability tier classification (e.g., Tier 1 Extreme, Tier 2 High, Tier 3 Medium) — primary targeting dimension for program eligibility and prioritization."
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the vulnerability profile (e.g., Active, Expired, Superseded) — used to filter to current, valid profiles."
    - name: "displacement_category"
      expr: displacement_category
      comment: "Displacement category of the profiled individual/household — required for displacement-disaggregated vulnerability analysis."
    - name: "ipc_phase"
      expr: ipc_phase
      comment: "IPC food security phase assigned in the profile — critical for food assistance targeting and emergency response prioritization."
    - name: "protection_risk_level"
      expr: protection_risk_level
      comment: "Protection risk level from the vulnerability profile — drives protection case management prioritization."
    - name: "nutritional_status"
      expr: nutritional_status
      comment: "Nutritional status classification (e.g., SAM, MAM, Normal) — used for nutrition program targeting and outcome monitoring."
    - name: "country_code"
      expr: country_code
      comment: "Country where the vulnerability profile was assessed — enables country-level vulnerability comparison."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of vulnerability assessment — tracks profiling coverage trends and reassessment cycle compliance."
    - name: "livelihood_status"
      expr: livelihood_status
      comment: "Livelihood status of the profiled individual/household — informs economic vulnerability and cash/livelihood program targeting."
  measures:
    - name: "total_vulnerability_profiles"
      expr: COUNT(DISTINCT vulnerability_profile_id)
      comment: "Total vulnerability profiles created — measures profiling coverage across the beneficiary population."
    - name: "active_vulnerability_profiles"
      expr: COUNT(DISTINCT CASE WHEN profile_status = 'Active' THEN vulnerability_profile_id END)
      comment: "Count of currently active vulnerability profiles — reflects the population with current, valid vulnerability assessments for targeting."
    - name: "extreme_vulnerability_profiles"
      expr: COUNT(DISTINCT CASE WHEN vulnerability_tier IN ('Tier 1', 'Extreme') THEN vulnerability_profile_id END)
      comment: "Count of profiles in the most extreme vulnerability tier — the highest-priority targeting group for emergency and life-saving assistance."
    - name: "avg_composite_vulnerability_score"
      expr: AVG(CAST(composite_vulnerability_score AS DOUBLE))
      comment: "Average composite vulnerability score across all profiles — headline population vulnerability indicator for strategic program design and donor reporting."
    - name: "profiles_with_gbv_exposure"
      expr: COUNT(DISTINCT CASE WHEN gbv_exposure_flag = TRUE THEN vulnerability_profile_id END)
      comment: "Count of profiles with GBV exposure flag — measures GBV prevalence in the profiled population for protection program investment decisions."
    - name: "profiles_with_chronic_illness"
      expr: COUNT(DISTINCT CASE WHEN chronic_illness_flag = TRUE THEN vulnerability_profile_id END)
      comment: "Count of profiles with chronic illness — informs health program targeting and medical supply planning for chronically ill beneficiaries."
    - name: "profiles_with_pss_need"
      expr: COUNT(DISTINCT CASE WHEN pss_need_flag = TRUE THEN vulnerability_profile_id END)
      comment: "Count of profiles with identified psychosocial support (PSS) need — drives PSS program capacity planning and mental health resource allocation."
    - name: "profiles_without_wash_access"
      expr: COUNT(DISTINCT CASE WHEN wash_access_flag = FALSE THEN vulnerability_profile_id END)
      comment: "Count of profiles lacking WASH access — quantifies the WASH gap in the profiled population for infrastructure investment prioritization."
    - name: "elderly_member_profiles"
      expr: COUNT(DISTINCT CASE WHEN elderly_member_flag = TRUE THEN vulnerability_profile_id END)
      comment: "Count of profiles with elderly household members — tracks inclusion of elderly persons for age-sensitive programming and protection monitoring."
    - name: "avg_muac_mm"
      expr: AVG(CAST(muac_mm AS DOUBLE))
      comment: "Average MUAC (mm) from vulnerability profiles — tracks nutritional status trend across the profiled population for nutrition emergency response."
    - name: "profiles_due_for_reassessment"
      expr: COUNT(DISTINCT CASE WHEN next_reassessment_date <= CURRENT_DATE() THEN vulnerability_profile_id END)
      comment: "Count of profiles where the next reassessment date has passed — measures reassessment compliance and data currency for targeting accuracy."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`beneficiary_protection_flag`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Protection monitoring KPIs — tracks protection flag volume, severity, escalation rates, and resolution performance to steer protection program response and safeguarding compliance."
  source: "`ngo_ecm`.`beneficiary`.`protection_flag`"
  dimensions:
    - name: "flag_type"
      expr: flag_type
      comment: "Type of protection concern flagged (e.g., GBV, Child Protection, Trafficking, Forced Displacement) — primary dimension for protection caseload analysis."
    - name: "flag_severity"
      expr: flag_severity
      comment: "Severity level of the protection flag (e.g., Critical, High, Medium, Low) — drives escalation and response prioritization."
    - name: "flag_status"
      expr: flag_status
      comment: "Current status of the protection flag (e.g., Open, Resolved, Escalated, Closed) — tracks protection response pipeline."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the flag (e.g., Strictly Confidential, Confidential) — ensures appropriate data access controls in reporting."
    - name: "flagging_source"
      expr: flagging_source
      comment: "Source that identified the protection concern (e.g., Community Referral, Staff Observation, Hotline) — informs community feedback mechanism effectiveness."
    - name: "flag_date_month"
      expr: DATE_TRUNC('MONTH', flag_date)
      comment: "Month the protection flag was raised — enables trend analysis of protection incident reporting over time."
    - name: "identification_method"
      expr: identification_method
      comment: "Method used to identify the protection concern — informs which identification channels are most effective."
  measures:
    - name: "total_protection_flags"
      expr: COUNT(DISTINCT protection_flag_id)
      comment: "Total protection flags raised — primary protection monitoring KPI measuring the scale of identified protection concerns."
    - name: "active_protection_flags"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN protection_flag_id END)
      comment: "Count of currently active (unresolved) protection flags — measures open protection caseload requiring active response."
    - name: "critical_high_severity_flags"
      expr: COUNT(DISTINCT CASE WHEN flag_severity IN ('Critical', 'High') THEN protection_flag_id END)
      comment: "Count of critical and high severity protection flags — the highest-priority protection concerns requiring immediate intervention and resource deployment."
    - name: "flags_requiring_escalation"
      expr: COUNT(DISTINCT CASE WHEN escalation_required = TRUE THEN protection_flag_id END)
      comment: "Count of flags requiring escalation — measures the volume of cases exceeding frontline response capacity and requiring senior management attention."
    - name: "flags_with_referral_made"
      expr: COUNT(DISTINCT CASE WHEN referral_made = TRUE THEN protection_flag_id END)
      comment: "Count of flags where a referral was made to a specialized service — measures protection response quality and service linkage rate."
    - name: "flags_requiring_legal_action"
      expr: COUNT(DISTINCT CASE WHEN legal_action_required = TRUE THEN protection_flag_id END)
      comment: "Count of flags requiring legal action — informs legal aid program demand and accountability/justice mechanism engagement."
    - name: "resolved_protection_flags"
      expr: COUNT(DISTINCT CASE WHEN flag_status = 'Resolved' THEN protection_flag_id END)
      comment: "Count of resolved protection flags — measures protection case resolution throughput and response effectiveness."
    - name: "flags_with_pss_provided"
      expr: COUNT(DISTINCT CASE WHEN pss_provided = TRUE THEN protection_flag_id END)
      comment: "Count of flags where psychosocial support was provided — tracks PSS service delivery coverage for protection cases."
    - name: "flags_pending_follow_up"
      expr: COUNT(DISTINCT CASE WHEN follow_up_required = TRUE AND flag_status != 'Resolved' THEN protection_flag_id END)
      comment: "Count of open flags with pending follow-up actions — measures protection monitoring backlog and case management compliance."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`beneficiary_referral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Referral pathway KPIs — tracks referral volume, acceptance rates, service linkage quality, and outcome effectiveness to optimize inter-agency coordination and service delivery continuity."
  source: "`ngo_ecm`.`beneficiary`.`referral`"
  dimensions:
    - name: "referral_status"
      expr: referral_status
      comment: "Current status of the referral (e.g., Pending, Accepted, Declined, Completed) — primary dimension for referral pipeline management."
    - name: "referral_type"
      expr: referral_type
      comment: "Type of referral (e.g., Internal, External, Emergency) — distinguishes in-house service linkages from inter-agency referrals."
    - name: "referral_category"
      expr: referral_category
      comment: "Category of service being referred to (e.g., Health, Legal, Shelter, Nutrition) — used to analyze referral demand by service sector."
    - name: "outcome_category"
      expr: outcome_category
      comment: "Outcome category of the referral (e.g., Service Received, No Show, Declined by Beneficiary) — measures referral effectiveness and service uptake."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the referral (e.g., Emergency, High, Routine) — used to track response timeliness for high-priority cases."
    - name: "receiving_service_type"
      expr: receiving_service_type
      comment: "Type of service provided by the receiving organization — informs service gap analysis and partner capacity planning."
    - name: "referral_date_month"
      expr: DATE_TRUNC('MONTH', referral_date)
      comment: "Month the referral was made — tracks referral volume trends and seasonal service demand patterns."
    - name: "gbv_case_flag"
      expr: gbv_case_flag
      comment: "Indicates whether the referral is for a GBV case — enables GBV-specific referral pathway analysis and survivor service tracking."
    - name: "protection_concern_flag"
      expr: protection_concern_flag
      comment: "Indicates whether the referral involves a protection concern — used to track protection-sensitive referral pathways."
  measures:
    - name: "total_referrals"
      expr: COUNT(DISTINCT referral_id)
      comment: "Total referrals made — primary service linkage volume KPI measuring inter-agency coordination scale."
    - name: "completed_referrals"
      expr: COUNT(DISTINCT CASE WHEN referral_status = 'Completed' THEN referral_id END)
      comment: "Count of successfully completed referrals — measures service delivery completion rate and referral pathway effectiveness."
    - name: "declined_referrals"
      expr: COUNT(DISTINCT CASE WHEN referral_status = 'Declined' THEN referral_id END)
      comment: "Count of declined referrals — identifies service access barriers and partner capacity gaps requiring corrective action."
    - name: "gbv_referrals"
      expr: COUNT(DISTINCT CASE WHEN gbv_case_flag = TRUE THEN referral_id END)
      comment: "Count of GBV-related referrals — tracks GBV survivor service linkage volume for specialized program monitoring and donor reporting."
    - name: "referrals_with_feedback_received"
      expr: COUNT(DISTINCT CASE WHEN feedback_received_flag = TRUE THEN referral_id END)
      comment: "Count of referrals where beneficiary feedback was received — measures accountability to affected populations (AAP) compliance in referral pathways."
    - name: "referrals_with_follow_up_completed"
      expr: COUNT(DISTINCT CASE WHEN follow_up_completed_flag = TRUE THEN referral_id END)
      comment: "Count of referrals with completed follow-up — measures case management quality and continuity of care compliance."
    - name: "referrals_with_consent"
      expr: COUNT(DISTINCT CASE WHEN consent_obtained_flag = TRUE THEN referral_id END)
      comment: "Count of referrals made with documented beneficiary consent — measures informed consent compliance in referral processes, a core protection standard."
    - name: "emergency_priority_referrals"
      expr: COUNT(DISTINCT CASE WHEN priority_level = 'Emergency' THEN referral_id END)
      comment: "Count of emergency priority referrals — tracks life-threatening or urgent cases requiring immediate service linkage and response monitoring."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`beneficiary_consent_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent management compliance KPIs — tracks informed consent coverage, GDPR applicability, data sharing permissions, and consent expiry to ensure data protection and humanitarian accountability standards."
  source: "`ngo_ecm`.`beneficiary`.`consent_record`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent record (e.g., Active, Withdrawn, Expired) — primary dimension for consent compliance monitoring."
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent granted (e.g., Data Collection, Photography, Data Sharing, Biometric) — used to track consent coverage by data use category."
    - name: "consent_method"
      expr: consent_method
      comment: "Method used to obtain consent (e.g., Written, Verbal, Digital) — informs consent process quality and legal defensibility."
    - name: "collection_country_code"
      expr: collection_country_code
      comment: "Country where data was collected — used for jurisdiction-specific data protection compliance analysis (e.g., GDPR applicability)."
    - name: "consent_date_month"
      expr: DATE_TRUNC('MONTH', consent_date)
      comment: "Month consent was obtained — tracks consent collection trends and program enrollment compliance over time."
    - name: "gdpr_applicable"
      expr: gdpr_applicable
      comment: "Indicates whether GDPR applies to this consent record — used to segment GDPR-regulated data for compliance reporting."
  measures:
    - name: "total_consent_records"
      expr: COUNT(DISTINCT consent_record_id)
      comment: "Total consent records on file — measures consent documentation coverage across the beneficiary population."
    - name: "active_consents"
      expr: COUNT(DISTINCT CASE WHEN consent_status = 'Active' THEN consent_record_id END)
      comment: "Count of currently active consent records — measures the proportion of beneficiaries with valid, current consent for data use."
    - name: "withdrawn_consents"
      expr: COUNT(DISTINCT CASE WHEN consent_status = 'Withdrawn' THEN consent_record_id END)
      comment: "Count of withdrawn consent records — tracks consent withdrawal rate, a key accountability and data rights compliance indicator."
    - name: "proxy_consents"
      expr: COUNT(DISTINCT CASE WHEN is_proxy_consent = TRUE THEN consent_record_id END)
      comment: "Count of proxy consent records — tracks cases where consent was given by a representative, requiring additional safeguarding oversight."
    - name: "informed_consent_verified_records"
      expr: COUNT(DISTINCT CASE WHEN informed_consent_verified = TRUE THEN consent_record_id END)
      comment: "Count of records with verified informed consent — measures compliance with Core Humanitarian Standard (CHS) informed consent requirements."
    - name: "sharing_permitted_records"
      expr: COUNT(DISTINCT CASE WHEN sharing_permitted = TRUE THEN consent_record_id END)
      comment: "Count of records where data sharing is permitted — informs the eligible data pool for inter-agency data sharing and reporting."
    - name: "biometric_enrollment_permitted_records"
      expr: COUNT(DISTINCT CASE WHEN biometric_enrollment_permitted = TRUE THEN consent_record_id END)
      comment: "Count of records permitting biometric enrollment — tracks biometric data collection consent coverage for digital ID and deduplication programs."
    - name: "expired_consents"
      expr: COUNT(DISTINCT CASE WHEN expiry_date < CURRENT_DATE() AND consent_status = 'Active' THEN consent_record_id END)
      comment: "Count of consent records that have passed their expiry date but remain marked active — a critical data governance compliance gap requiring immediate remediation."
    - name: "chs_compliant_consents"
      expr: COUNT(DISTINCT CASE WHEN chs_compliance_flag = TRUE THEN consent_record_id END)
      comment: "Count of consent records meeting Core Humanitarian Standard (CHS) compliance requirements — measures organizational adherence to humanitarian accountability standards."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`beneficiary_case_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Case action and service delivery KPIs — tracks service delivery volume, quality, follow-up compliance, and nutrition screening outcomes across all case management interactions."
  source: "`ngo_ecm`.`beneficiary`.`case_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of case action performed (e.g., Home Visit, PSS Session, Distribution, Referral) — primary dimension for service delivery analysis."
    - name: "action_category"
      expr: action_category
      comment: "Category grouping of the action (e.g., Protection, Nutrition, WASH, Livelihoods) — used for sector-level service delivery reporting."
    - name: "action_status"
      expr: action_status
      comment: "Current status of the action (e.g., Completed, Pending, Cancelled) — tracks service delivery completion rate."
    - name: "action_outcome"
      expr: action_outcome
      comment: "Outcome of the case action (e.g., Successful, Partial, Failed) — measures service delivery quality and effectiveness."
    - name: "nutrition_status"
      expr: nutrition_status
      comment: "Nutrition status recorded at the time of the action (e.g., SAM, MAM, Normal) — used for nutrition screening outcome tracking."
    - name: "country_code"
      expr: country_code
      comment: "Country where the action was performed — geographic dimension for country-level service delivery analysis."
    - name: "action_date_month"
      expr: DATE_TRUNC('MONTH', action_date)
      comment: "Month the action was performed — tracks service delivery volume trends over time."
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Method used to collect data for this action (e.g., Paper, Mobile, ODK) — informs digital data collection adoption and quality."
  measures:
    - name: "total_case_actions"
      expr: COUNT(DISTINCT case_action_id)
      comment: "Total case actions performed — primary service delivery volume KPI measuring operational throughput of case management activities."
    - name: "completed_actions"
      expr: COUNT(DISTINCT CASE WHEN action_status = 'Completed' THEN case_action_id END)
      comment: "Count of completed case actions — measures service delivery completion rate and operational effectiveness."
    - name: "actions_requiring_follow_up"
      expr: COUNT(DISTINCT CASE WHEN follow_up_required = TRUE THEN case_action_id END)
      comment: "Count of actions flagged for follow-up — measures pending follow-up workload and case management continuity compliance."
    - name: "actions_requiring_escalation"
      expr: COUNT(DISTINCT CASE WHEN escalation_required = TRUE THEN case_action_id END)
      comment: "Count of actions requiring escalation — identifies cases exceeding frontline capacity and requiring senior management or specialist intervention."
    - name: "sensitive_case_actions"
      expr: COUNT(DISTINCT CASE WHEN is_sensitive_case = TRUE THEN case_action_id END)
      comment: "Count of actions on sensitive cases — tracks the volume of high-confidentiality case interactions requiring enhanced data protection protocols."
    - name: "supervisor_reviewed_actions"
      expr: COUNT(DISTINCT CASE WHEN supervisor_reviewed = TRUE THEN case_action_id END)
      comment: "Count of actions that have been supervisor-reviewed — measures quality assurance coverage and supervisory oversight compliance."
    - name: "actions_with_consent_obtained"
      expr: COUNT(DISTINCT CASE WHEN consent_obtained = TRUE THEN case_action_id END)
      comment: "Count of actions where beneficiary consent was documented — measures informed consent compliance at the point of service delivery."
    - name: "avg_muac_measurement_mm"
      expr: AVG(CAST(muac_measurement_mm AS DOUBLE))
      comment: "Average MUAC measurement (mm) recorded during case actions — tracks nutritional status trend across service delivery touchpoints for nutrition program monitoring."
$$;