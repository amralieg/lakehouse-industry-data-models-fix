-- Metric views for domain: beneficiary | Business: Ngo | Version: 2 | Generated on: 2026-06-23 01:23:48

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_registrant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the registrant master — the core beneficiary identity record. Tracks registration pipeline health, deduplication quality, vulnerability distribution, and consent compliance. Aligns with UNHCR proGres v4, Primero, and KoboToolbox registration workflows. Contains PII (pii_beneficiary_protected): given_name, family_name, date_of_birth, sex — apply Unity Catalog dynamic masking policy mask_beneficiary_pii before exposing to non-privileged roles."
  source: "`vibe_ngo_v1`.`beneficiary`.`registrant`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Numeric code representing registration status (active, pending, deregistered). DIMENSION_ONLY — use for grouping/filtering."
    - name: "vulnerability_category"
      expr: vulnerability_category
      comment: "Vulnerability tier assigned at registration (e.g. extreme, high, moderate, low). Key segmentation dimension for targeting and prioritisation."
    - name: "sex"
      expr: sex
      comment: "Sex of the registrant. PII (pii_beneficiary_protected). Used for gender disaggregation required by IASC and donor reporting."
    - name: "poc_category"
      expr: poc_category
      comment: "UNHCR population-of-concern category (refugee, IDP, stateless, returnee, asylum-seeker). Critical for mandate and cluster reporting."
    - name: "deduplication_status"
      expr: deduplication_status
      comment: "Deduplication outcome (unique, duplicate, pending review). Drives data quality governance."
    - name: "has_disability"
      expr: has_disability
      comment: "Boolean flag indicating disability. Used for inclusion and protection mainstreaming disaggregation."
    - name: "is_unaccompanied_minor"
      expr: is_unaccompanied_minor
      comment: "Boolean flag for unaccompanied and separated children (UASC). High-priority protection caseload."
    - name: "is_gbv_survivor"
      expr: is_gbv_survivor
      comment: "Boolean flag for GBV survivor status. Highly sensitive PII (pii_beneficiary_protected) — restrict to protection officers only."
    - name: "consent_given"
      expr: consent_given
      comment: "Whether informed consent was obtained at registration. Required for GDPR, CHS, and donor compliance."
    - name: "registration_date_month"
      expr: DATE_TRUNC('month', registration_date)
      comment: "Month of registration. Used for trend analysis and pipeline monitoring."
  measures:
    - name: "total_registered_beneficiaries"
      expr: COUNT(1)
      comment: "Total number of registrant records. Baseline headcount KPI for programme reach and donor reporting. Executives use this to assess scale and coverage."
    - name: "unique_registered_beneficiaries"
      expr: COUNT(DISTINCT registrant_id)
      comment: "Deduplicated count of unique registrants. Corrects for re-registrations; the authoritative reach figure for donor reports and cluster 5Ws."
    - name: "avg_vulnerability_score"
      expr: AVG(CAST(vulnerability_score AS DOUBLE))
      comment: "Average composite vulnerability score across registrants. Tracks whether the programme is reaching the most vulnerable populations over time."
    - name: "pct_with_disability"
      expr: ROUND(100.0 * SUM(CASE WHEN has_disability = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of registrants with a reported disability. Inclusion KPI required by CRPD-aligned donor frameworks and IASC disability inclusion guidelines."
    - name: "pct_consent_obtained"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_given = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of registrants with valid consent on file. Compliance KPI for GDPR, CHS Standard 7, and donor data-protection requirements. A drop triggers immediate remediation."
    - name: "pct_deduplicated"
      expr: ROUND(100.0 * SUM(CASE WHEN deduplication_status = 'unique' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of registrants confirmed as unique after deduplication. Data quality KPI — low scores indicate double-counting risk in beneficiary reach figures."
    - name: "avg_data_completeness_score"
      expr: AVG(CAST(completeness_score AS DOUBLE))
      comment: "Average data completeness score across registrant profiles. Drives data quality improvement cycles and flags gaps before donor reporting deadlines."
    - name: "pct_unaccompanied_minors"
      expr: ROUND(100.0 * SUM(CASE WHEN is_unaccompanied_minor = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of registrants who are unaccompanied or separated children. High-priority protection caseload indicator monitored by child protection clusters."
    - name: "pct_gbv_survivors"
      expr: ROUND(100.0 * SUM(CASE WHEN is_gbv_survivor = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of registrants identified as GBV survivors. Sensitive protection KPI (pii_beneficiary_protected) — restricted dashboard. Informs GBV sub-cluster resource allocation."
    - name: "pct_pregnant_or_lactating"
      expr: ROUND(100.0 * SUM(CASE WHEN is_pregnant_or_lactating = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of registrants who are pregnant or lactating. Nutrition and health targeting KPI used to size specialised ration and health service caseloads."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level KPIs covering registration pipeline, vulnerability distribution, food security, and shelter conditions. The household is the primary unit of assistance in most humanitarian programmes. Aligns with UNHCR proGres v4, WFP SCOPE, and KoboToolbox household survey workflows. Contains PII (pii_beneficiary_protected) — apply mask_beneficiary_pii policy."
  source: "`vibe_ngo_v1`.`beneficiary`.`household`"
  dimensions:
    - name: "vulnerability_category"
      expr: vulnerability_category
      comment: "Household vulnerability tier. Primary targeting dimension for assistance prioritisation."
    - name: "displacement_status"
      expr: displacement_status
      comment: "Displacement status of the household (IDP, refugee, returnee, host community). Required for cluster and donor disaggregation."
    - name: "food_security_status"
      expr: food_security_status
      comment: "IPC/FEWS NET food security classification. Drives food assistance targeting decisions."
    - name: "shelter_type"
      expr: shelter_type
      comment: "Type of shelter occupied (tent, transitional, permanent, host family). Informs shelter cluster planning."
    - name: "is_female_headed"
      expr: is_female_headed
      comment: "Boolean flag for female-headed households. Gender disaggregation required by most donors and IASC gender marker."
    - name: "gbv_risk_flag"
      expr: gbv_risk_flag
      comment: "Boolean flag indicating elevated GBV risk. Sensitive PII (pii_beneficiary_protected). Drives protection referral prioritisation."
    - name: "registration_date_month"
      expr: DATE_TRUNC('month', registration_date)
      comment: "Month of household registration. Used for pipeline trend analysis."
    - name: "water_source_type"
      expr: water_source_type
      comment: "Primary water source type. WASH sector planning dimension."
    - name: "sanitation_facility_type"
      expr: sanitation_facility_type
      comment: "Sanitation facility type. WASH sector planning dimension."
  measures:
    - name: "total_households"
      expr: COUNT(DISTINCT household_id)
      comment: "Total unique households registered. Primary reach denominator for household-level programmes. Used in donor reports and cluster 5Ws."
    - name: "avg_vulnerability_score"
      expr: AVG(CAST(vulnerability_score AS DOUBLE))
      comment: "Average household vulnerability score. Tracks whether assistance is reaching the most vulnerable over time; a rising average signals improved targeting."
    - name: "pct_female_headed_households"
      expr: ROUND(100.0 * SUM(CASE WHEN is_female_headed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of female-headed households in the caseload. Gender inclusion KPI required by IASC gender marker and most bilateral donors."
    - name: "pct_gbv_risk_households"
      expr: ROUND(100.0 * SUM(CASE WHEN gbv_risk_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of households flagged with elevated GBV risk. Protection prioritisation KPI — triggers referral pipeline review when above threshold."
    - name: "pct_consent_obtained"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_obtained = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of households with valid data-sharing consent. CHS and GDPR compliance KPI. A drop below 95% triggers data governance escalation."
    - name: "pct_has_pregnant_lactating"
      expr: ROUND(100.0 * SUM(CASE WHEN has_pregnant_lactating = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of households with a pregnant or lactating member. Nutrition programme targeting KPI used to size specialised ration caseloads."
    - name: "pct_has_unaccompanied_minor"
      expr: ROUND(100.0 * SUM(CASE WHEN has_unaccompanied_minor = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of households containing an unaccompanied or separated child. Child protection caseload sizing KPI."
    - name: "avg_gps_latitude"
      expr: AVG(CAST(gps_latitude AS DOUBLE))
      comment: "Average GPS latitude of registered households. Used for geographic coverage analysis and mapping of programme footprint."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_vulnerability_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vulnerability profiling KPIs tracking composite scores, protection risk levels, and special needs prevalence across the beneficiary caseload. Used by programme teams to prioritise targeting, adjust entitlements, and report on vulnerability trends. Aligns with UNHCR VAF, WFP VAM, and OCHA HNO methodologies. Contains PII (pii_beneficiary_protected) — apply mask_beneficiary_pii policy."
  source: "`vibe_ngo_v1`.`beneficiary`.`vulnerability_profile`"
  dimensions:
    - name: "vulnerability_tier"
      expr: vulnerability_tier
      comment: "Vulnerability tier classification (extreme, high, moderate, low). Primary targeting segmentation dimension."
    - name: "profile_status"
      expr: profile_status
      comment: "Status of the vulnerability profile (active, superseded, archived). Filters to current profiles."
    - name: "displacement_category"
      expr: displacement_category
      comment: "Displacement category (IDP, refugee, returnee, host community). Required for cluster disaggregation."
    - name: "ipc_phase"
      expr: ipc_phase
      comment: "IPC food security phase assigned to the household. Drives food assistance prioritisation."
    - name: "protection_risk_level"
      expr: protection_risk_level
      comment: "Protection risk level (critical, high, medium, low). Drives protection case prioritisation."
    - name: "female_headed_household_flag"
      expr: female_headed_household_flag
      comment: "Boolean flag for female-headed households. Gender disaggregation dimension."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month of vulnerability assessment. Used for trend analysis and reassessment cycle monitoring."
    - name: "consent_obtained_flag"
      expr: consent_obtained_flag
      comment: "Whether consent was obtained for this vulnerability profile. Compliance dimension."
  measures:
    - name: "total_vulnerability_profiles"
      expr: COUNT(DISTINCT vulnerability_profile_id)
      comment: "Total active vulnerability profiles. Baseline for understanding assessed caseload size and coverage gaps."
    - name: "avg_composite_vulnerability_score"
      expr: AVG(CAST(composite_vulnerability_score AS DOUBLE))
      comment: "Average composite vulnerability score across all profiles. The primary targeting quality KPI — executives use this to assess whether the programme is reaching the most vulnerable."
    - name: "avg_muac_mm"
      expr: AVG(CAST(muac_mm AS DOUBLE))
      comment: "Average mid-upper arm circumference in mm. Nutrition status KPI — values below 125mm indicate acute malnutrition requiring immediate intervention."
    - name: "pct_gbv_exposure"
      expr: ROUND(100.0 * SUM(CASE WHEN gbv_exposure_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of profiles with GBV exposure flag. Sensitive protection KPI (pii_beneficiary_protected). Informs GBV sub-cluster resource allocation and referral pathway capacity."
    - name: "pct_chronic_illness"
      expr: ROUND(100.0 * SUM(CASE WHEN chronic_illness_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of profiles with chronic illness. Health programme targeting KPI used to size medical assistance caseloads."
    - name: "pct_pss_need"
      expr: ROUND(100.0 * SUM(CASE WHEN pss_need_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of profiles with identified psychosocial support need. PSS programme sizing KPI — drives staffing and session planning decisions."
    - name: "pct_wash_access"
      expr: ROUND(100.0 * SUM(CASE WHEN wash_access_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of profiles with adequate WASH access. WASH sector coverage KPI — the inverse (1 - this) represents the unmet WASH need gap."
    - name: "pct_elderly_member"
      expr: ROUND(100.0 * SUM(CASE WHEN elderly_member_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of profiles with an elderly household member. Inclusion and protection targeting KPI for age-sensitive programming."
    - name: "pct_consent_obtained"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_obtained_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vulnerability profiles with valid consent. CHS and GDPR compliance KPI for data governance audits."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_needs_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over beneficiary needs assessments — the primary evidence base for programme design and targeting. Tracks assessment coverage, sectoral vulnerability scores, GBV risk prevalence, and data quality. Aligns with OCHA HNO, UNHCR VAF, WFP VAM, and KoboToolbox/ODK data collection workflows. Contains PII (pii_beneficiary_protected) — apply mask_beneficiary_pii policy."
  source: "`vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of needs assessment (household, community, rapid, in-depth). Segmentation for analysis by assessment methodology."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Status of the assessment (draft, validated, submitted, rejected). Filters to quality-assured assessments."
    - name: "vulnerability_category"
      expr: vulnerability_category
      comment: "Vulnerability category assigned by the assessment. Primary targeting segmentation."
    - name: "displacement_status"
      expr: displacement_status
      comment: "Displacement status of the assessed household. Required for cluster disaggregation."
    - name: "female_headed_household"
      expr: female_headed_household
      comment: "Boolean flag for female-headed households. Gender disaggregation required by IASC gender marker."
    - name: "gbv_risk_flag"
      expr: gbv_risk_flag
      comment: "Boolean flag for elevated GBV risk identified during assessment. Sensitive PII (pii_beneficiary_protected)."
    - name: "referral_recommended"
      expr: referral_recommended
      comment: "Whether a referral was recommended at assessment. Drives referral pipeline monitoring."
    - name: "consent_obtained"
      expr: consent_obtained
      comment: "Whether informed consent was obtained before assessment. CHS compliance dimension."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month of assessment. Used for trend analysis and assessment cycle monitoring."
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Data collection method (face-to-face, remote, phone). Quality and coverage analysis dimension."
  measures:
    - name: "total_assessments"
      expr: COUNT(DISTINCT beneficiary_needs_assessment_id)
      comment: "Total needs assessments conducted. Baseline coverage KPI — executives use this to assess whether assessment targets are being met ahead of programme design deadlines."
    - name: "avg_overall_vulnerability_score"
      expr: AVG(CAST(overall_vulnerability_score AS DOUBLE))
      comment: "Average composite vulnerability score across all assessments. The headline targeting quality metric — tracks whether the programme is reaching the most vulnerable populations."
    - name: "avg_nutrition_score"
      expr: AVG(CAST(nutrition_score AS DOUBLE))
      comment: "Average nutrition vulnerability score. Nutrition cluster KPI used to size food and nutrition assistance caseloads."
    - name: "avg_protection_score"
      expr: AVG(CAST(protection_score AS DOUBLE))
      comment: "Average protection vulnerability score. Protection cluster KPI used to prioritise case management and referral resources."
    - name: "avg_wash_score"
      expr: AVG(CAST(wash_score AS DOUBLE))
      comment: "Average WASH vulnerability score. WASH cluster KPI used to prioritise water, sanitation, and hygiene interventions."
    - name: "avg_shelter_score"
      expr: AVG(CAST(shelter_score AS DOUBLE))
      comment: "Average shelter vulnerability score. Shelter cluster KPI used to prioritise shelter assistance."
    - name: "avg_livelihoods_score"
      expr: AVG(CAST(livelihoods_score AS DOUBLE))
      comment: "Average livelihoods vulnerability score. Economic recovery cluster KPI."
    - name: "avg_education_score"
      expr: AVG(CAST(education_score AS DOUBLE))
      comment: "Average education vulnerability score. Education cluster KPI used to size learning programme caseloads."
    - name: "avg_muac_mm"
      expr: AVG(CAST(muac_mm AS DOUBLE))
      comment: "Average MUAC measurement in mm across assessed individuals. Acute malnutrition screening KPI — values below 125mm trigger emergency nutrition response."
    - name: "pct_gbv_risk"
      expr: ROUND(100.0 * SUM(CASE WHEN gbv_risk_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments flagging elevated GBV risk. Sensitive protection KPI (pii_beneficiary_protected). Informs GBV sub-cluster resource allocation."
    - name: "pct_referral_recommended"
      expr: ROUND(100.0 * SUM(CASE WHEN referral_recommended = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments resulting in a referral recommendation. Referral pipeline demand KPI — a high rate signals need to expand referral pathway capacity."
    - name: "pct_consent_obtained"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_obtained = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments with valid consent on file. CHS Standard 7 and GDPR compliance KPI. A drop triggers immediate data governance escalation."
    - name: "avg_gps_accuracy_meters"
      expr: AVG(CAST(gps_accuracy_meters AS DOUBLE))
      comment: "Average GPS accuracy of assessment locations in metres. Data quality KPI — high values indicate poor location data that undermines geographic targeting analysis."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_case_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Case management KPIs tracking caseload volume, case type distribution, resolution rates, and protection risk levels. Used by protection, GBV, and child protection teams to manage caseloads and report to donors. Aligns with Primero/CPIMS+, CommCare, and UNHCR proGres v4 case management workflows. Contains highly sensitive PII (pii_beneficiary_protected) — apply strictest masking policy; restrict to case workers and above."
  source: "`vibe_ngo_v1`.`beneficiary`.`case_record`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Type of case (GBV, child protection, legal aid, PSS, general protection). Primary caseload segmentation dimension."
    - name: "case_status"
      expr: case_status
      comment: "Current status of the case (open, closed, on hold, referred). Operational pipeline dimension."
    - name: "case_stage"
      expr: case_stage
      comment: "Stage in the case management cycle (intake, assessment, planning, implementation, closure). Workflow monitoring dimension."
    - name: "priority_level"
      expr: priority_level
      comment: "Case priority level (critical, high, medium, low). Drives workload prioritisation."
    - name: "protection_risk_level"
      expr: protection_risk_level
      comment: "Protection risk level assigned to the case. Drives escalation and resource allocation decisions."
    - name: "is_gbv_case"
      expr: is_gbv_case
      comment: "Boolean flag for GBV cases. Sensitive PII (pii_beneficiary_protected). GBV sub-cluster reporting dimension."
    - name: "is_child_case"
      expr: is_child_case
      comment: "Boolean flag for child protection cases. Child protection cluster reporting dimension."
    - name: "outcome_classification"
      expr: outcome_classification
      comment: "Case outcome classification (resolved, referred, lost to follow-up, deceased). Quality and effectiveness dimension."
    - name: "open_date_month"
      expr: DATE_TRUNC('month', open_date)
      comment: "Month the case was opened. Used for caseload trend analysis and pipeline monitoring."
    - name: "service_modality"
      expr: service_modality
      comment: "Service delivery modality (in-person, remote, outreach). Operational planning dimension."
  measures:
    - name: "total_cases"
      expr: COUNT(DISTINCT case_record_id)
      comment: "Total case records. Baseline caseload volume KPI used by protection coordinators and donors to assess programme scale."
    - name: "open_cases"
      expr: SUM(CASE WHEN case_status = 'open' THEN 1 ELSE 0 END)
      comment: "Number of currently open cases. Active caseload KPI — drives staffing and resource allocation decisions."
    - name: "closed_cases"
      expr: SUM(CASE WHEN case_status = 'closed' THEN 1 ELSE 0 END)
      comment: "Number of closed cases. Throughput KPI used alongside open cases to assess case resolution velocity."
    - name: "case_closure_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN case_status = 'closed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases that have been closed. Case resolution effectiveness KPI — a low rate signals caseload backlog requiring management intervention."
    - name: "pct_with_case_plan"
      expr: ROUND(100.0 * SUM(CASE WHEN case_plan_developed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases with a developed case plan. Quality of care KPI — UNHCR and UNICEF minimum standards require case plans for all active cases."
    - name: "pct_safety_plan_in_place"
      expr: ROUND(100.0 * SUM(CASE WHEN safety_plan_in_place = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases with a safety plan in place. Critical protection quality KPI — required for all high-risk GBV and child protection cases."
    - name: "pct_gbv_cases"
      expr: ROUND(100.0 * SUM(CASE WHEN is_gbv_case = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of caseload that are GBV cases. Sensitive PII (pii_beneficiary_protected). GBV sub-cluster caseload composition KPI."
    - name: "pct_child_cases"
      expr: ROUND(100.0 * SUM(CASE WHEN is_child_case = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of caseload that are child protection cases. Child protection cluster caseload composition KPI."
    - name: "avg_muac_cm"
      expr: AVG(CAST(muac_cm AS DOUBLE))
      comment: "Average MUAC measurement in cm for case beneficiaries. Nutrition status monitoring KPI within the case management caseload."
    - name: "pct_legal_aid_required"
      expr: ROUND(100.0 * SUM(CASE WHEN legal_aid_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases requiring legal aid. Legal assistance demand KPI used to size legal aid programme capacity."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_case_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Case action KPIs tracking service delivery activity, follow-up compliance, escalation rates, and supervisor review quality within the case management cycle. Used by case management supervisors and protection coordinators. Aligns with Primero/CPIMS+ and CommCare action logging. Contains PII (pii_beneficiary_protected) — apply mask_beneficiary_pii policy."
  source: "`vibe_ngo_v1`.`beneficiary`.`case_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of case action (home visit, PSS session, referral, legal consultation, distribution). Activity segmentation dimension."
    - name: "action_category"
      expr: action_category
      comment: "Category of action (direct service, coordination, administrative). Operational classification dimension."
    - name: "action_status"
      expr: action_status
      comment: "Status of the action (completed, pending, cancelled). Pipeline monitoring dimension."
    - name: "action_outcome"
      expr: action_outcome
      comment: "Outcome of the action (successful, partial, unsuccessful). Quality and effectiveness dimension."
    - name: "escalation_required"
      expr: escalation_required
      comment: "Boolean flag indicating escalation was required. Risk monitoring dimension."
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Boolean flag indicating follow-up is required. Workload planning dimension."
    - name: "supervisor_reviewed"
      expr: supervisor_reviewed
      comment: "Boolean flag indicating supervisor review was completed. Quality assurance dimension."
    - name: "action_date_month"
      expr: DATE_TRUNC('month', action_date)
      comment: "Month of case action. Used for activity trend analysis and workload monitoring."
    - name: "nutrition_status"
      expr: nutrition_status
      comment: "Nutrition status recorded at action (SAM, MAM, normal). Nutrition monitoring dimension."
  measures:
    - name: "total_case_actions"
      expr: COUNT(DISTINCT case_action_id)
      comment: "Total case actions recorded. Service delivery activity volume KPI — used to assess case worker productivity and programme throughput."
    - name: "pct_escalation_required"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of case actions requiring escalation. Risk and quality KPI — a rising rate signals deteriorating case complexity or capacity gaps requiring management response."
    - name: "pct_supervisor_reviewed"
      expr: ROUND(100.0 * SUM(CASE WHEN supervisor_reviewed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of case actions that received supervisor review. Quality assurance KPI — minimum standards typically require 100% review for high-risk cases."
    - name: "pct_follow_up_required"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of case actions generating a follow-up requirement. Workload pipeline KPI — drives staffing and scheduling decisions."
    - name: "pct_consent_obtained"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_obtained = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of case actions with valid consent documented. CHS and GDPR compliance KPI at the action level."
    - name: "avg_muac_measurement_mm"
      expr: AVG(CAST(muac_measurement_mm AS DOUBLE))
      comment: "Average MUAC measurement in mm recorded during case actions. Nutrition status trend KPI within the active caseload."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_referral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Referral pathway KPIs tracking referral volume, acceptance rates, completion rates, and response timeliness. Used by protection coordinators and case management supervisors to monitor inter-agency referral pathway performance. Aligns with GBV IMS, Primero, and UNHCR referral pathway standards. Contains PII (pii_beneficiary_protected) — apply mask_beneficiary_pii policy."
  source: "`vibe_ngo_v1`.`beneficiary`.`referral`"
  dimensions:
    - name: "referral_type"
      expr: referral_type
      comment: "Type of referral (internal, external, inter-agency). Pathway segmentation dimension."
    - name: "referral_status"
      expr: referral_status
      comment: "Current status of the referral (pending, accepted, declined, completed, lost to follow-up). Pipeline monitoring dimension."
    - name: "referral_category"
      expr: referral_category
      comment: "Referral category (GBV, child protection, legal, health, livelihoods). Sector segmentation dimension."
    - name: "receiving_service_type"
      expr: receiving_service_type
      comment: "Type of service the referral is directed to. Service pathway analysis dimension."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the referral (urgent, high, standard). Drives response time monitoring."
    - name: "gbv_case_flag"
      expr: gbv_case_flag
      comment: "Boolean flag for GBV referrals. Sensitive PII (pii_beneficiary_protected). GBV sub-cluster reporting dimension."
    - name: "referral_date_month"
      expr: DATE_TRUNC('month', referral_date)
      comment: "Month of referral. Used for referral volume trend analysis."
    - name: "outcome_category"
      expr: outcome_category
      comment: "Outcome category of the referral (service received, declined, not found, lost to follow-up). Effectiveness dimension."
  measures:
    - name: "total_referrals"
      expr: COUNT(DISTINCT referral_id)
      comment: "Total referrals made. Baseline referral pathway volume KPI used by protection coordinators and donors."
    - name: "referral_acceptance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN referral_status = 'accepted' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of referrals accepted by receiving organisations. Referral pathway effectiveness KPI — a low rate signals capacity or coordination gaps in the referral network."
    - name: "referral_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN referral_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of referrals completed (service delivered). End-to-end referral effectiveness KPI — the primary quality metric for referral pathway performance."
    - name: "pct_feedback_received"
      expr: ROUND(100.0 * SUM(CASE WHEN feedback_received_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of referrals with beneficiary feedback received. Accountability to affected populations (AAP) KPI required by CHS Standard 4."
    - name: "pct_follow_up_completed"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_completed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of referrals with follow-up completed. Case management quality KPI — incomplete follow-up is a key risk indicator for protection case management."
    - name: "pct_consent_obtained"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_obtained_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of referrals with documented consent. CHS and GDPR compliance KPI at the referral level."
    - name: "pct_gbv_referrals"
      expr: ROUND(100.0 * SUM(CASE WHEN gbv_case_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of referrals that are GBV cases. Sensitive PII (pii_beneficiary_protected). GBV sub-cluster caseload composition KPI."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Programme enrollment KPIs tracking enrollment volume, completion rates, attendance, and exit patterns across programme components. Used by programme managers to monitor participation and report on output indicators. Aligns with WFP SCOPE, UNHCR proGres v4, and CommCare enrollment tracking."
  source: "`vibe_ngo_v1`.`beneficiary`.`enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (active, completed, dropped out, transferred). Pipeline monitoring dimension."
    - name: "exit_reason"
      expr: exit_reason
      comment: "Reason for enrollment exit (completed, dropped out, relocated, deceased). Attrition analysis dimension."
    - name: "service_delivery_modality"
      expr: service_delivery_modality
      comment: "Service delivery modality (in-person, remote, hybrid). Operational planning dimension."
    - name: "referral_source"
      expr: referral_source
      comment: "Source of referral into the programme component. Intake pathway analysis dimension."
    - name: "consent_for_component"
      expr: consent_for_component
      comment: "Whether consent was obtained for this specific component enrollment. CHS compliance dimension."
    - name: "enrollment_date_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of enrollment. Used for enrollment trend analysis and pipeline monitoring."
  measures:
    - name: "total_enrollments"
      expr: COUNT(DISTINCT enrollment_id)
      comment: "Total programme enrollments. Baseline output indicator for programme reach — used in donor reports and logframe output tracking."
    - name: "active_enrollments"
      expr: SUM(CASE WHEN enrollment_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of currently active enrollments. Active caseload KPI used for capacity planning and resource allocation."
    - name: "enrollment_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN enrollment_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments completed. Programme effectiveness KPI — a key output indicator in most logframes and donor reports."
    - name: "avg_attendance_rate"
      expr: AVG(CAST(attendance_rate AS DOUBLE))
      comment: "Average attendance rate across enrollments. Programme engagement quality KPI — low attendance rates signal barriers to participation requiring programme adaptation."
    - name: "dropout_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN enrollment_status = 'dropped out' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments that resulted in dropout. Programme retention KPI — a high dropout rate triggers investigation into barriers and programme design issues."
    - name: "pct_consent_for_component"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_for_component = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments with component-specific consent documented. CHS Standard 7 compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Entitlement KPIs tracking transfer values, modality distribution, and vulnerability-based adjustments across the beneficiary caseload. Used by programme managers and finance teams to monitor assistance levels and report on transfer value adequacy. Aligns with WFP SCOPE, UNHCR CashAssist, and CALP cash and voucher assistance standards."
  source: "`vibe_ngo_v1`.`beneficiary`.`entitlement`"
  dimensions:
    - name: "entitlement_status"
      expr: entitlement_status
      comment: "Status of the entitlement (active, suspended, closed, pending). Pipeline monitoring dimension."
    - name: "transfer_modality"
      expr: transfer_modality
      comment: "Transfer modality (cash, voucher, in-kind, mobile money). CALP modality analysis dimension."
    - name: "vulnerability_category"
      expr: vulnerability_category
      comment: "Vulnerability category of the entitled beneficiary. Targeting quality analysis dimension."
    - name: "frequency"
      expr: frequency
      comment: "Transfer frequency (monthly, bi-monthly, quarterly, one-off). Programme design dimension."
    - name: "transfer_currency_code"
      expr: transfer_currency_code
      comment: "Currency of the transfer. Multi-currency programme management dimension."
    - name: "start_date_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month entitlement started. Used for entitlement pipeline trend analysis."
  measures:
    - name: "total_entitlements"
      expr: COUNT(DISTINCT entitlement_id)
      comment: "Total entitlement records. Baseline caseload KPI for assistance programmes — used in donor reports and cluster 5Ws."
    - name: "active_entitlements"
      expr: SUM(CASE WHEN entitlement_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of currently active entitlements. Active assistance caseload KPI used for budget forecasting and supply planning."
    - name: "total_transfer_value"
      expr: SUM(CAST(transfer_value_amount AS DOUBLE))
      comment: "Total transfer value across all entitlements. Financial exposure KPI used by finance and programme teams for budget monitoring and donor reporting."
    - name: "avg_transfer_value"
      expr: AVG(CAST(transfer_value_amount AS DOUBLE))
      comment: "Average transfer value per entitlement. Transfer adequacy KPI — compared against MEB to assess whether assistance covers minimum needs."
    - name: "total_vulnerability_adjustment"
      expr: SUM(CAST(vulnerability_based_adjustment AS DOUBLE))
      comment: "Total vulnerability-based adjustment applied across entitlements. Targeting equity KPI — measures the additional resources directed to the most vulnerable."
    - name: "avg_quantity"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average quantity per entitlement. In-kind ration adequacy KPI used alongside MEB to assess assistance coverage."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_cva_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash and voucher assistance (CVA) transfer KPIs tracking transfer volumes, values, and verification outcomes. Used by CVA programme managers and finance teams to monitor disbursement performance and reconciliation. Aligns with CALP CVA standards, WFP SCOPE, and UNHCR CashAssist. Contains PII (pii_beneficiary_protected) — apply mask_beneficiary_pii policy."
  source: "`vibe_ngo_v1`.`beneficiary`.`cva_transfer`"
  dimensions:
    - name: "cva_transfer_status"
      expr: cva_transfer_status
      comment: "Status of the CVA transfer (pending, disbursed, failed, reversed, reconciled). Pipeline monitoring dimension."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the transfer (verified, unverified, disputed). Compliance and reconciliation dimension."
    - name: "transfer_date_month"
      expr: DATE_TRUNC('month', transfer_date)
      comment: "Month of transfer. Used for disbursement trend analysis and cash flow monitoring."
  measures:
    - name: "total_transfers"
      expr: COUNT(DISTINCT cva_transfer_id)
      comment: "Total CVA transfers processed. Baseline disbursement volume KPI used by CVA programme managers and donors."
    - name: "total_transfer_amount"
      expr: SUM(CAST(transfer_amount AS DOUBLE))
      comment: "Total value of CVA transfers disbursed. Financial throughput KPI — the primary CVA programme expenditure metric for donor reporting and budget monitoring."
    - name: "avg_transfer_amount"
      expr: AVG(CAST(transfer_amount AS DOUBLE))
      comment: "Average transfer amount per transaction. Transfer adequacy KPI — compared against MEB to assess whether individual transfers cover minimum needs."
    - name: "pct_verified_transfers"
      expr: ROUND(100.0 * SUM(CASE WHEN verification_status = 'verified' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transfers that have been verified. Financial compliance KPI — unverified transfers represent audit risk and potential double-payment exposure."
    - name: "pct_disbursed_transfers"
      expr: ROUND(100.0 * SUM(CASE WHEN cva_transfer_status = 'disbursed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transfers successfully disbursed. Disbursement effectiveness KPI — a low rate signals FSP performance issues or beneficiary access barriers."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_end_user_verification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Post-distribution monitoring (PDM) and end-user verification KPIs tracking receipt confirmation, discrepancy rates, and transfer adequacy. Used by programme quality teams and donors to verify that assistance reached intended beneficiaries. Aligns with CALP PDM standards, WFP PDM protocols, and UNHCR post-distribution monitoring frameworks. Contains PII (pii_beneficiary_protected) — apply mask_beneficiary_pii policy."
  source: "`vibe_ngo_v1`.`beneficiary`.`end_user_verification`"
  dimensions:
    - name: "verification_status"
      expr: verification_status
      comment: "Verification outcome status (verified, disputed, unverified). PDM quality dimension."
    - name: "transfer_modality"
      expr: transfer_modality
      comment: "Transfer modality verified (cash, voucher, in-kind, mobile money). CALP modality analysis dimension."
    - name: "receipt_confirmed"
      expr: receipt_confirmed
      comment: "Boolean flag for confirmed receipt by beneficiary. Primary PDM outcome dimension."
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Boolean flag indicating a discrepancy between disbursed and received amounts. Financial integrity monitoring dimension."
    - name: "complaint_raised_flag"
      expr: complaint_raised_flag
      comment: "Boolean flag indicating a complaint was raised during verification. AAP and accountability dimension."
    - name: "verification_date_month"
      expr: DATE_TRUNC('month', verification_date)
      comment: "Month of verification. Used for PDM trend analysis."
  measures:
    - name: "total_verifications"
      expr: COUNT(DISTINCT end_user_verification_id)
      comment: "Total end-user verifications conducted. PDM coverage KPI — used to assess whether PDM sample targets are being met."
    - name: "pct_receipt_confirmed"
      expr: ROUND(100.0 * SUM(CASE WHEN receipt_confirmed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of verifications confirming receipt by the beneficiary. The primary PDM effectiveness KPI — a drop below threshold triggers immediate programme investigation."
    - name: "pct_received_full_amount"
      expr: ROUND(100.0 * SUM(CASE WHEN received_full_amount_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of beneficiaries who received the full entitled amount. Transfer integrity KPI — shortfalls indicate FSP deductions, leakage, or targeting errors."
    - name: "pct_discrepancy"
      expr: ROUND(100.0 * SUM(CASE WHEN discrepancy_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of verifications with a discrepancy between disbursed and received amounts. Financial integrity KPI — a high rate triggers audit and FSP contract review."
    - name: "pct_complaint_raised"
      expr: ROUND(100.0 * SUM(CASE WHEN complaint_raised_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of verifications where a complaint was raised. AAP and accountability KPI required by CHS Standard 4 and most donor PDM frameworks."
    - name: "total_amount_disbursed"
      expr: SUM(CAST(amount_disbursed AS DOUBLE))
      comment: "Total amount disbursed as recorded in verification records. Financial reconciliation KPI — compared against FSP disbursement records to identify leakage."
    - name: "total_amount_received"
      expr: SUM(CAST(amount_received AS DOUBLE))
      comment: "Total amount confirmed received by beneficiaries. Financial integrity KPI — the gap between disbursed and received amounts quantifies leakage or deductions."
    - name: "avg_transfer_value"
      expr: AVG(CAST(transfer_value AS DOUBLE))
      comment: "Average transfer value per verification record. Transfer adequacy KPI — compared against MEB to assess whether assistance covers minimum needs."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_protection_flag`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Protection flag KPIs tracking active protection concerns, escalation rates, referral compliance, and resolution performance. Used by protection officers and coordinators to manage protection caseloads and report to donors. Aligns with UNHCR protection monitoring frameworks and Primero/CPIMS+ protection case management. Contains highly sensitive PII (pii_beneficiary_protected) — apply strictest masking policy."
  source: "`vibe_ngo_v1`.`beneficiary`.`protection_flag`"
  dimensions:
    - name: "flag_type"
      expr: flag_type
      comment: "Type of protection flag (GBV, child protection, SGBV, trafficking, detention, statelessness). Primary caseload segmentation dimension."
    - name: "flag_severity"
      expr: flag_severity
      comment: "Severity of the protection flag (critical, high, medium, low). Drives prioritisation and escalation decisions."
    - name: "flag_status"
      expr: flag_status
      comment: "Current status of the flag (active, resolved, referred, closed). Pipeline monitoring dimension."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag for currently active protection concerns. Filters to live caseload."
    - name: "escalation_required"
      expr: escalation_required
      comment: "Boolean flag indicating escalation is required. Risk monitoring dimension."
    - name: "referral_made"
      expr: referral_made
      comment: "Boolean flag indicating a referral was made. Referral compliance dimension."
    - name: "flag_date_month"
      expr: DATE_TRUNC('month', flag_date)
      comment: "Month the protection flag was raised. Used for trend analysis and early warning monitoring."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality level of the flag (public, restricted, confidential, strictly confidential). Data access governance dimension."
  measures:
    - name: "total_protection_flags"
      expr: COUNT(DISTINCT protection_flag_id)
      comment: "Total protection flags raised. Baseline protection caseload volume KPI used by protection coordinators and donors."
    - name: "active_protection_flags"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Number of currently active protection flags. Live protection caseload KPI — drives staffing and resource allocation decisions."
    - name: "pct_escalation_required"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of protection flags requiring escalation. Risk intensity KPI — a rising rate signals deteriorating protection environment requiring management response."
    - name: "pct_referral_made"
      expr: ROUND(100.0 * SUM(CASE WHEN referral_made = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of protection flags where a referral was made. Referral compliance KPI — UNHCR and UNICEF minimum standards require referrals for all high-severity flags."
    - name: "pct_resolved"
      expr: ROUND(100.0 * SUM(CASE WHEN flag_status = 'resolved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of protection flags resolved. Case resolution effectiveness KPI — a low rate signals caseload backlog or inadequate response capacity."
    - name: "pct_legal_action_required"
      expr: ROUND(100.0 * SUM(CASE WHEN legal_action_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of protection flags requiring legal action. Legal aid demand KPI used to size legal assistance programme capacity."
    - name: "pct_pss_provided"
      expr: ROUND(100.0 * SUM(CASE WHEN pss_provided = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of protection flags where PSS was provided. Psychosocial support coverage KPI — measures whether PSS is reaching flagged beneficiaries."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_biometric_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Biometric enrollment and deduplication KPIs tracking enrollment quality, deduplication match rates, and consent compliance. Used by registration teams and data protection officers to monitor biometric system performance and compliance. Aligns with UNHCR BIMS, WFP SCOPE biometric module, and ICRC Restoring Family Links. Contains highest-sensitivity PII (pii_beneficiary_protected) — biometric data requires strictest masking and access controls under GDPR Article 9 and humanitarian data protection principles."
  source: "`vibe_ngo_v1`.`beneficiary`.`biometric_record`"
  dimensions:
    - name: "biometric_modality"
      expr: biometric_modality
      comment: "Biometric modality (fingerprint, iris, face, palm). Technology and quality analysis dimension."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the biometric record (verified, pending, failed). Quality monitoring dimension."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag for active biometric records. Filters to current enrollment records."
    - name: "consent_obtained"
      expr: consent_obtained
      comment: "Whether informed consent was obtained for biometric enrollment. GDPR Article 9 and CHS compliance dimension."
    - name: "deduplication_performed"
      expr: deduplication_performed
      comment: "Boolean flag indicating deduplication was performed. Data quality governance dimension."
    - name: "deduplication_match_found"
      expr: deduplication_match_found
      comment: "Boolean flag indicating a duplicate match was found. Deduplication outcome dimension."
    - name: "quality_threshold_met"
      expr: quality_threshold_met
      comment: "Boolean flag indicating the biometric sample met quality threshold. Enrollment quality dimension."
    - name: "enrollment_date_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of biometric enrollment. Used for enrollment trend analysis."
  measures:
    - name: "total_biometric_enrollments"
      expr: COUNT(DISTINCT biometric_record_id)
      comment: "Total biometric enrollment records. Baseline biometric coverage KPI — used to assess what proportion of the caseload has been biometrically enrolled."
    - name: "pct_quality_threshold_met"
      expr: ROUND(100.0 * SUM(CASE WHEN quality_threshold_met = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of biometric records meeting quality threshold. Enrollment quality KPI — low quality rates increase false non-match rates and undermine deduplication reliability."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average biometric sample quality score. Technical quality KPI used by biometric system administrators to monitor device and operator performance."
    - name: "deduplication_match_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN deduplication_match_found = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN deduplication_performed = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of deduplication checks that found a match. Duplicate detection rate KPI — a high rate indicates significant double-registration in the caseload requiring data cleaning."
    - name: "pct_consent_obtained"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_obtained = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of biometric records with valid consent documented. GDPR Article 9 and CHS compliance KPI — biometric data without consent is a critical legal and ethical violation."
    - name: "avg_deduplication_match_score"
      expr: AVG(CAST(deduplication_match_score AS DOUBLE))
      comment: "Average deduplication match score for records where a match was found. Deduplication confidence KPI — low scores indicate borderline matches requiring manual review."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_consent_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent management KPIs tracking consent coverage, expiry, withdrawal rates, and compliance with data protection frameworks. Used by data protection officers and programme compliance teams. Critical for GDPR, CHS Standard 7, and donor data protection audits. Contains PII (pii_beneficiary_protected) — apply mask_beneficiary_pii policy."
  source: "`vibe_ngo_v1`.`beneficiary`.`consent_record`"
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent (data processing, photography, biometric, sharing, research). Consent scope segmentation dimension."
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent record (active, withdrawn, expired, pending). Compliance monitoring dimension."
    - name: "consent_method"
      expr: consent_method
      comment: "Method of consent collection (verbal, written, digital). Data quality and legal validity dimension."
    - name: "gdpr_applicable"
      expr: gdpr_applicable
      comment: "Boolean flag indicating GDPR applicability. Regulatory compliance segmentation dimension."
    - name: "is_proxy_consent"
      expr: is_proxy_consent
      comment: "Boolean flag for proxy consent (e.g. for children or incapacitated adults). Legal validity monitoring dimension."
    - name: "photography_permitted"
      expr: photography_permitted
      comment: "Boolean flag for photography permission. Communications and media use compliance dimension."
    - name: "sharing_permitted"
      expr: sharing_permitted
      comment: "Boolean flag for data sharing permission. Inter-agency data sharing compliance dimension."
    - name: "consent_date_month"
      expr: DATE_TRUNC('month', consent_date)
      comment: "Month consent was obtained. Used for consent pipeline trend analysis."
  measures:
    - name: "total_consent_records"
      expr: COUNT(DISTINCT consent_record_id)
      comment: "Total consent records on file. Baseline consent coverage KPI used by data protection officers and compliance teams."
    - name: "active_consent_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_status = 'active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records currently active. The primary consent compliance KPI — a drop below 95% triggers immediate data governance escalation and potential programme suspension."
    - name: "consent_withdrawal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_status = 'withdrawn' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records that have been withdrawn. Beneficiary trust and programme quality KPI — a rising withdrawal rate signals accountability or trust issues."
    - name: "pct_informed_consent_verified"
      expr: ROUND(100.0 * SUM(CASE WHEN informed_consent_verified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records where informed consent was independently verified. CHS Standard 7 quality KPI — unverified consent is a compliance risk in donor audits."
    - name: "pct_biometric_enrollment_permitted"
      expr: ROUND(100.0 * SUM(CASE WHEN biometric_enrollment_permitted = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records permitting biometric enrollment. Biometric programme eligibility KPI — determines the maximum biometric enrollment caseload."
    - name: "pct_sharing_permitted"
      expr: ROUND(100.0 * SUM(CASE WHEN sharing_permitted = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records permitting data sharing. Inter-agency data sharing eligibility KPI — determines the pool of beneficiaries whose data can be shared with partner organisations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_community_intervention`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Community-level intervention KPIs tracking implementation progress, budget utilisation, beneficiary reach, and satisfaction scores. Used by programme managers and field coordinators to monitor community-level programme performance. Aligns with VREQ-031 requirement to expand this previously thin product. Contains community-level data (not individual PII) but community leader contact information should be treated as pii_de_identified."
  source: "`vibe_ngo_v1`.`beneficiary`.`community_intervention`"
  dimensions:
    - name: "implementation_status"
      expr: implementation_status
      comment: "Implementation status of the community intervention (planned, in progress, completed, suspended). Pipeline monitoring dimension."
    - name: "intervention_type"
      expr: intervention_type
      comment: "Type of community intervention (WASH, nutrition, protection, livelihoods, shelter). Sector analysis dimension."
    - name: "sector"
      expr: sector
      comment: "Humanitarian sector of the intervention. Cluster reporting dimension."
    - name: "intervention_modality"
      expr: intervention_modality
      comment: "Delivery modality (direct implementation, partner-led, community-led). Operational model dimension."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag for currently active interventions. Filters to live programme activities."
    - name: "protection_mainstreaming_flag"
      expr: protection_mainstreaming_flag
      comment: "Boolean flag indicating protection mainstreaming is applied. IASC protection mainstreaming compliance dimension."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the intervention (pending, approved, rejected). Governance dimension."
    - name: "start_date_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the intervention started. Used for programme pipeline trend analysis."
  measures:
    - name: "total_community_interventions"
      expr: COUNT(DISTINCT community_intervention_id)
      comment: "Total community interventions. Baseline programme footprint KPI used in cluster 5Ws and donor reports."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average implementation completion percentage across community interventions. Programme delivery progress KPI used in steering meetings and donor progress reports."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated AS DOUBLE))
      comment: "Total budget allocated across community interventions. Financial planning KPI used for budget monitoring and donor reporting."
    - name: "total_budget_spent"
      expr: SUM(CAST(budget_spent AS DOUBLE))
      comment: "Total budget spent across community interventions. Financial execution KPI — compared against allocated budget to assess absorption rate."
    - name: "budget_utilisation_rate"
      expr: ROUND(100.0 * SUM(CAST(budget_spent AS DOUBLE)) / NULLIF(SUM(CAST(budget_allocated AS DOUBLE)), 0), 2)
      comment: "Budget utilisation rate (spent / allocated). Financial efficiency KPI — low utilisation signals implementation delays; high utilisation signals potential over-run risk."
    - name: "avg_beneficiary_satisfaction_score"
      expr: AVG(CAST(beneficiary_satisfaction_score AS DOUBLE))
      comment: "Average beneficiary satisfaction score across community interventions. AAP and programme quality KPI required by CHS Standard 4 and most donor accountability frameworks."
    - name: "avg_beneficiary_feedback_score"
      expr: AVG(CAST(beneficiary_feedback_score AS DOUBLE))
      comment: "Average beneficiary feedback score. Complements satisfaction score for a fuller picture of community-level programme quality."
    - name: "pct_protection_mainstreamed"
      expr: ROUND(100.0 * SUM(CASE WHEN protection_mainstreaming_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of community interventions with protection mainstreaming applied. IASC protection mainstreaming compliance KPI — required by most humanitarian donors."
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Total actual expenditure across community interventions. Financial accountability KPI used for donor financial reporting and audit."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_displacement_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Displacement history KPIs tracking displacement patterns, cross-border movements, protracted displacement, and return intentions across the beneficiary caseload. Used by protection and durable solutions teams to monitor displacement trends and plan durable solutions programming. Aligns with UNHCR displacement tracking, IOM DTM, and OCHA displacement monitoring frameworks. Contains PII (pii_beneficiary_protected) — apply mask_beneficiary_pii policy."
  source: "`vibe_ngo_v1`.`beneficiary`.`displacement_history`"
  dimensions:
    - name: "displacement_status"
      expr: displacement_status
      comment: "Current displacement status (displaced, returned, resettled, locally integrated). Durable solutions segmentation dimension."
    - name: "displacement_trigger"
      expr: displacement_trigger
      comment: "Cause of displacement (conflict, natural disaster, persecution, climate). Root cause analysis dimension."
    - name: "poc_category"
      expr: poc_category
      comment: "UNHCR population-of-concern category. Mandate and cluster reporting dimension."
    - name: "is_cross_border"
      expr: is_cross_border
      comment: "Boolean flag for cross-border displacement. Refugee vs IDP segmentation dimension."
    - name: "is_protracted"
      expr: is_protracted
      comment: "Boolean flag for protracted displacement (5+ years). Durable solutions prioritisation dimension."
    - name: "return_intention"
      expr: return_intention
      comment: "Stated return intention (willing to return, not willing, undecided). Durable solutions planning dimension."
    - name: "displacement_date_month"
      expr: DATE_TRUNC('month', displacement_date)
      comment: "Month of displacement. Used for displacement trend analysis and early warning monitoring."
    - name: "current_settlement_type"
      expr: current_settlement_type
      comment: "Type of current settlement (camp, urban, rural, transit). Operational planning dimension."
  measures:
    - name: "total_displacement_records"
      expr: COUNT(DISTINCT displacement_history_id)
      comment: "Total displacement history records. Baseline displacement tracking KPI used by UNHCR, IOM, and OCHA for population movement monitoring."
    - name: "pct_cross_border_displacement"
      expr: ROUND(100.0 * SUM(CASE WHEN is_cross_border = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of displacement records involving cross-border movement. Refugee vs IDP caseload composition KPI — drives mandate and funding decisions."
    - name: "pct_protracted_displacement"
      expr: ROUND(100.0 * SUM(CASE WHEN is_protracted = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of displacement records classified as protracted. Durable solutions urgency KPI — a high rate signals need for long-term solutions programming investment."
    - name: "avg_current_latitude"
      expr: AVG(CAST(current_latitude AS DOUBLE))
      comment: "Average current latitude of displaced populations. Geographic distribution KPI used for mapping and operational planning."
    - name: "pct_active_displacement"
      expr: ROUND(100.0 * SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of displacement records currently active. Active displacement caseload proportion KPI used for programme sizing."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_exit_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Programme exit KPIs tracking exit volumes, reasons, post-exit follow-up compliance, and data retention governance. Used by programme managers and data protection officers to monitor programme closure quality and compliance. Aligns with UNHCR durable solutions frameworks, CHS exit standards, and GDPR data retention requirements. Contains PII (pii_beneficiary_protected) — apply mask_beneficiary_pii policy."
  source: "`vibe_ngo_v1`.`beneficiary`.`exit_record`"
  dimensions:
    - name: "exit_reason_category"
      expr: exit_reason_category
      comment: "Category of exit reason (programme completion, relocation, death, voluntary withdrawal, ineligibility). Exit pattern analysis dimension."
    - name: "exit_status"
      expr: exit_status
      comment: "Status of the exit record (confirmed, pending, disputed). Data quality dimension."
    - name: "reactivation_eligible"
      expr: reactivation_eligible
      comment: "Boolean flag indicating eligibility for programme re-entry. Durable solutions and re-targeting dimension."
    - name: "post_exit_followup_required"
      expr: post_exit_followup_required
      comment: "Boolean flag indicating post-exit follow-up is required. Case management quality dimension."
    - name: "exit_consent_obtained"
      expr: exit_consent_obtained
      comment: "Whether consent was obtained at exit. CHS and GDPR compliance dimension."
    - name: "is_duplicate_merge"
      expr: is_duplicate_merge
      comment: "Boolean flag indicating exit was due to duplicate record merge. Data quality governance dimension."
    - name: "exit_date_month"
      expr: DATE_TRUNC('month', exit_date)
      comment: "Month of exit. Used for exit trend analysis and programme closure monitoring."
    - name: "data_retention_classification"
      expr: data_retention_classification
      comment: "Data retention classification (retain, anonymise, delete). GDPR and data governance dimension."
  measures:
    - name: "total_exits"
      expr: COUNT(DISTINCT exit_record_id)
      comment: "Total programme exits. Baseline exit volume KPI used to monitor programme attrition and closure rates."
    - name: "pct_exit_assessment_conducted"
      expr: ROUND(100.0 * SUM(CASE WHEN exit_assessment_conducted = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of exits with an exit assessment conducted. Programme closure quality KPI — CHS minimum standards require exit assessments for all planned exits."
    - name: "pct_referral_provided_at_exit"
      expr: ROUND(100.0 * SUM(CASE WHEN referral_provided = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of exits where a referral was provided. Continuity of care KPI — ensures beneficiaries are connected to other services upon programme exit."
    - name: "pct_post_exit_followup_required"
      expr: ROUND(100.0 * SUM(CASE WHEN post_exit_followup_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of exits requiring post-exit follow-up. Ongoing care obligation KPI — drives post-exit monitoring workload planning."
    - name: "pct_exit_consent_obtained"
      expr: ROUND(100.0 * SUM(CASE WHEN exit_consent_obtained = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of exits with consent documented. GDPR and CHS compliance KPI at the exit stage."
    - name: "pct_duplicate_merges"
      expr: ROUND(100.0 * SUM(CASE WHEN is_duplicate_merge = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of exits due to duplicate record merges. Data quality KPI — a high rate indicates systemic registration duplication issues requiring process improvement."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_minimum_expenditure_basket`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Minimum Expenditure Basket (MEB) KPIs tracking basket values, food/non-food component ratios, and transfer value adequacy. Used by CVA programme managers and economists to set transfer values and assess assistance adequacy. Aligns with CALP MEB methodology, WFP VAM, and UNHCR CVA standards. Critical for ensuring cash transfer values cover minimum needs."
  source: "`vibe_ngo_v1`.`beneficiary`.`minimum_expenditure_basket`"
  dimensions:
    - name: "basket_type"
      expr: basket_type
      comment: "Type of MEB (full MEB, food MEB, survival MEB, recovery MEB). Methodology segmentation dimension."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the MEB (draft, approved, superseded). Filters to approved baskets for transfer value setting."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag for currently active MEB. Filters to current baskets."
    - name: "valuation_method"
      expr: valuation_method
      comment: "Valuation methodology (market price survey, secondary data, hybrid). Methodology quality dimension."
    - name: "effective_from_date_month"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the MEB became effective. Used for MEB revision trend analysis."
  measures:
    - name: "avg_total_basket_value"
      expr: AVG(CAST(total_basket_value AS DOUBLE))
      comment: "Average total MEB value. The primary transfer value adequacy benchmark — CVA transfer values are set as a percentage of this figure."
    - name: "avg_food_component_value"
      expr: AVG(CAST(food_component_value AS DOUBLE))
      comment: "Average food component value of the MEB. Food assistance adequacy KPI — compared against WFP food ration values to assess equivalence."
    - name: "avg_non_food_component_value"
      expr: AVG(CAST(non_food_component_value AS DOUBLE))
      comment: "Average non-food component value of the MEB. NFI assistance adequacy KPI used for shelter and NFI programme sizing."
    - name: "avg_transfer_value_per_household"
      expr: AVG(CAST(transfer_value_per_household AS DOUBLE))
      comment: "Average recommended transfer value per household. The operational CVA transfer value KPI — directly used to set entitlement amounts in SCOPE and CashAssist."
    - name: "avg_per_capita_value"
      expr: AVG(CAST(per_capita_value AS DOUBLE))
      comment: "Average per capita MEB value. Per-person assistance adequacy KPI used for individual-level transfer value calculations."
    - name: "avg_transfer_value_percent"
      expr: AVG(CAST(transfer_value_percent AS DOUBLE))
      comment: "Average transfer value as a percentage of the full MEB. Transfer coverage ratio KPI — measures what proportion of minimum needs the transfer covers; below 80% triggers programme review."
$$;