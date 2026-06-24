-- Metric views for domain: beneficiary | Business: Ngo | Version: 2 | Generated on: 2026-06-23 02:03:19

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_registrant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core beneficiary registrant metrics tracking population size, vulnerability profile, demographic composition, and data quality — essential for program targeting, resource allocation, and protection prioritisation."
  source: "`vibe_ngo_v1`.`beneficiary`.`registrant`"
  dimensions:
    - name: "sex"
      expr: sex
      comment: "Biological sex of the registrant (Male/Female/Other) — primary demographic disaggregation required by most donor reporting frameworks."
    - name: "vulnerability_category"
      expr: vulnerability_category
      comment: "Categorical vulnerability tier assigned to the registrant (e.g. Extreme, High, Medium, Low) — drives targeting and prioritisation decisions."
    - name: "poc_category"
      expr: poc_category
      comment: "Person of Concern category (e.g. Refugee, IDP, Stateless, Returnee) — required for UNHCR and donor disaggregation."
    - name: "deduplication_status"
      expr: deduplication_status
      comment: "Deduplication resolution status (e.g. Unique, Duplicate, Pending) — critical for data integrity and accurate headcount reporting."
    - name: "disability_type"
      expr: disability_type
      comment: "Type of disability recorded for the registrant — required for inclusion and protection programme targeting."
    - name: "registration_date_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Month of initial registration — enables trend analysis of registration intake over time."
    - name: "country_office_id"
      expr: country_office_id
      comment: "Country office responsible for the registrant — enables geographic disaggregation of beneficiary population."
    - name: "project_site_id"
      expr: project_site_id
      comment: "Project site where the registrant was registered — enables site-level operational analysis."
  measures:
    - name: "total_unique_registrants"
      expr: COUNT(DISTINCT registrant_id)
      comment: "Total count of unique registered beneficiaries — the primary headcount KPI for programme reach and donor reporting."
    - name: "registrants_with_disability"
      expr: COUNT(DISTINCT CASE WHEN has_disability = TRUE THEN registrant_id END)
      comment: "Number of registrants with a recorded disability — tracks inclusion of persons with disabilities (PWD) as a strategic protection KPI."
    - name: "gbv_survivor_count"
      expr: COUNT(DISTINCT CASE WHEN is_gbv_survivor = TRUE THEN registrant_id END)
      comment: "Number of registrants identified as GBV survivors — critical protection metric for GBV programme sizing and resource allocation."
    - name: "unaccompanied_minor_count"
      expr: COUNT(DISTINCT CASE WHEN is_unaccompanied_minor = TRUE THEN registrant_id END)
      comment: "Number of unaccompanied and separated children (UASC) — high-priority protection caseload requiring dedicated case management resources."
    - name: "pregnant_or_lactating_count"
      expr: COUNT(DISTINCT CASE WHEN is_pregnant_or_lactating = TRUE THEN registrant_id END)
      comment: "Number of pregnant or lactating women — drives nutrition and health programme targeting and supply planning."
    - name: "avg_vulnerability_score"
      expr: AVG(CAST(vulnerability_score AS DOUBLE))
      comment: "Average composite vulnerability score across all registrants — tracks overall population vulnerability level and informs targeting thresholds."
    - name: "avg_data_completeness_score"
      expr: AVG(CAST(completeness_score AS DOUBLE))
      comment: "Average data completeness score across registrant records — measures registration data quality, which directly affects programme eligibility decisions."
    - name: "avg_muac_cm"
      expr: AVG(CAST(muac_cm AS DOUBLE))
      comment: "Average mid-upper arm circumference (MUAC) in centimetres — key nutrition screening indicator used to identify acute malnutrition at population level."
    - name: "consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN consent_given = TRUE THEN registrant_id END) / NULLIF(COUNT(DISTINCT registrant_id), 0), 2)
      comment: "Percentage of registrants with valid consent recorded — compliance KPI for data protection obligations (GDPR, CHS) and ethical programme delivery."
    - name: "re_registration_registrant_count"
      expr: COUNT(DISTINCT CASE WHEN deduplication_status = 'Duplicate' THEN registrant_id END)
      comment: "Number of registrants flagged as duplicates — measures deduplication backlog and risk of double-counting in beneficiary headcounts."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Programme enrollment metrics tracking participation rates, completion, and service delivery modality — essential for measuring programme reach, retention, and effectiveness."
  source: "`vibe_ngo_v1`.`beneficiary`.`enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the enrollment (e.g. Active, Completed, Dropped Out, Suspended) — primary operational dimension for caseload management."
    - name: "service_delivery_modality"
      expr: service_delivery_modality
      comment: "Modality through which services are delivered (e.g. In-Person, Remote, Cash, In-Kind) — informs operational planning and cost efficiency analysis."
    - name: "exit_reason"
      expr: exit_reason
      comment: "Reason for exiting the programme (e.g. Completed, Dropped Out, Transferred, Deceased) — critical for understanding attrition and programme quality."
    - name: "referral_source"
      expr: referral_source
      comment: "Source channel through which the beneficiary was referred into the programme — informs outreach and referral pathway effectiveness."
    - name: "enrollment_date_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment — enables trend analysis of intake volume over time."
    - name: "component_id"
      expr: component_id
      comment: "Programme component the beneficiary is enrolled in — enables component-level performance disaggregation."
    - name: "country_office_id"
      expr: country_office_id
      comment: "Country office managing the enrollment — enables geographic performance comparison."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Implementing partner organisation responsible for the enrollment — enables partner performance benchmarking."
  measures:
    - name: "total_enrollments"
      expr: COUNT(DISTINCT enrollment_id)
      comment: "Total number of enrollment records — primary programme reach KPI used in donor reporting and programme reviews."
    - name: "active_enrollments"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'Active' THEN enrollment_id END)
      comment: "Number of currently active enrollments — real-time caseload size for operational resource planning."
    - name: "completed_enrollments"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'Completed' THEN enrollment_id END)
      comment: "Number of enrollments that reached successful completion — measures programme throughput and graduation rates."
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN enrollment_status = 'Completed' THEN enrollment_id END) / NULLIF(COUNT(DISTINCT enrollment_id), 0), 2)
      comment: "Percentage of enrollments that completed the programme — key effectiveness KPI for donor reporting and programme quality reviews."
    - name: "avg_attendance_rate"
      expr: AVG(CAST(attendance_rate AS DOUBLE))
      comment: "Average attendance rate across all enrollments — measures beneficiary engagement and programme retention, a leading indicator of completion."
    - name: "consent_for_component_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN consent_for_component = TRUE THEN enrollment_id END) / NULLIF(COUNT(DISTINCT enrollment_id), 0), 2)
      comment: "Percentage of enrollments with component-specific consent recorded — compliance metric for ethical programme delivery standards."
    - name: "dropout_count"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'Dropped Out' THEN enrollment_id END)
      comment: "Number of beneficiaries who dropped out of the programme — triggers investigation into barriers to participation and programme design issues."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_case_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Protection and social case management metrics tracking caseload volume, case types, resolution rates, and follow-up compliance — essential for protection programme oversight and resource allocation."
  source: "`vibe_ngo_v1`.`beneficiary`.`case_record`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the case (e.g. Open, Closed, On Hold, Referred) — primary operational dimension for caseload management."
    - name: "case_type"
      expr: case_type
      comment: "Type of case (e.g. Protection, GBV, Child Protection, Legal Aid) — enables sector-specific caseload analysis."
    - name: "case_stage"
      expr: case_stage
      comment: "Current stage in the case management workflow — tracks pipeline distribution and identifies bottlenecks."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the case (e.g. Critical, High, Medium, Low) — drives resource allocation and supervisor oversight decisions."
    - name: "protection_risk_level"
      expr: protection_risk_level
      comment: "Protection risk level assigned to the case — critical for safeguarding and escalation decisions."
    - name: "outcome_classification"
      expr: outcome_classification
      comment: "Final outcome classification of closed cases — measures case resolution quality and programme effectiveness."
    - name: "service_modality"
      expr: service_modality
      comment: "Modality through which case services are delivered — informs operational planning and cost analysis."
    - name: "open_date_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the case was opened — enables trend analysis of case intake over time."
    - name: "is_gbv_case"
      expr: is_gbv_case
      comment: "Flag indicating whether the case is a GBV case — enables GBV-specific caseload reporting required by protection clusters."
    - name: "country_office_id"
      expr: country_office_id
      comment: "Country office managing the case — enables geographic caseload comparison."
  measures:
    - name: "total_cases"
      expr: COUNT(DISTINCT case_record_id)
      comment: "Total number of case records — primary caseload volume KPI for protection programme oversight and staffing decisions."
    - name: "open_cases"
      expr: COUNT(DISTINCT CASE WHEN case_status = 'Open' THEN case_record_id END)
      comment: "Number of currently open cases — real-time active caseload for case worker capacity planning."
    - name: "gbv_case_count"
      expr: COUNT(DISTINCT CASE WHEN is_gbv_case = TRUE THEN case_record_id END)
      comment: "Number of GBV cases — critical protection KPI for GBV programme sizing, survivor support resource allocation, and cluster reporting."
    - name: "case_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN case_status = 'Closed' THEN case_record_id END) / NULLIF(COUNT(DISTINCT case_record_id), 0), 2)
      comment: "Percentage of cases that have been closed — measures case resolution throughput and case management efficiency."
    - name: "case_plan_developed_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN case_plan_developed = TRUE THEN case_record_id END) / NULLIF(COUNT(DISTINCT case_record_id), 0), 2)
      comment: "Percentage of cases with a case plan developed — quality compliance metric; low rates indicate gaps in case management standards."
    - name: "safety_plan_in_place_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN safety_plan_in_place = TRUE THEN case_record_id END) / NULLIF(COUNT(DISTINCT case_record_id), 0), 2)
      comment: "Percentage of cases with a safety plan in place — critical protection quality indicator, especially for GBV and high-risk cases."
    - name: "avg_muac_cm"
      expr: AVG(CAST(muac_cm AS DOUBLE))
      comment: "Average MUAC measurement across cases — nutrition screening indicator used to assess acute malnutrition prevalence in the caseload."
    - name: "supervisor_review_pending_count"
      expr: COUNT(DISTINCT CASE WHEN supervisor_review_required = TRUE AND case_status = 'Open' THEN case_record_id END)
      comment: "Number of open cases requiring supervisor review — operational quality control metric that triggers supervisory action when elevated."
    - name: "legal_aid_required_count"
      expr: COUNT(DISTINCT CASE WHEN legal_aid_required = TRUE THEN case_record_id END)
      comment: "Number of cases requiring legal aid — drives legal aid resource planning and partner referral capacity decisions."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Beneficiary entitlement and transfer metrics tracking the value, volume, and distribution of assistance — essential for supply planning, budget management, and donor accountability."
  source: "`vibe_ngo_v1`.`beneficiary`.`entitlement`"
  dimensions:
    - name: "entitlement_status"
      expr: entitlement_status
      comment: "Current status of the entitlement (e.g. Active, Suspended, Completed, Cancelled) — primary operational dimension for entitlement management."
    - name: "transfer_modality"
      expr: transfer_modality
      comment: "Modality of the transfer (e.g. Cash, Voucher, In-Kind, Mobile Money) — critical for cost efficiency analysis and modality mix decisions."
    - name: "vulnerability_category"
      expr: vulnerability_category
      comment: "Vulnerability category of the entitled beneficiary — enables equity analysis of assistance distribution across vulnerability tiers."
    - name: "frequency"
      expr: frequency
      comment: "Frequency of entitlement distribution (e.g. Monthly, Quarterly, One-Time) — informs supply chain scheduling and cash flow planning."
    - name: "transfer_currency_code"
      expr: transfer_currency_code
      comment: "Currency of the cash or voucher transfer — required for multi-currency financial reporting and budget reconciliation."
    - name: "special_dietary_requirement"
      expr: special_dietary_requirement
      comment: "Special dietary requirement associated with the entitlement — drives commodity procurement and ration customisation decisions."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the entitlement period starts — enables trend analysis of assistance distribution over time."
    - name: "country_office_id"
      expr: country_office_id
      comment: "Country office managing the entitlement — enables geographic disaggregation of assistance value."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Implementing partner responsible for the entitlement — enables partner-level accountability and performance comparison."
  measures:
    - name: "total_entitlements"
      expr: COUNT(DISTINCT entitlement_id)
      comment: "Total number of entitlement records — primary volume KPI for assistance programme reach and donor reporting."
    - name: "total_transfer_value"
      expr: SUM(CAST(transfer_value_amount AS DOUBLE))
      comment: "Total monetary value of all transfers — primary financial accountability KPI for donor reporting and budget utilisation tracking."
    - name: "avg_transfer_value_per_entitlement"
      expr: AVG(CAST(transfer_value_amount AS DOUBLE))
      comment: "Average transfer value per entitlement record — benchmarks assistance adequacy against minimum expenditure baskets (MEB) and cost norms."
    - name: "total_quantity_distributed"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of commodities or units distributed — drives supply chain replenishment planning and warehouse management."
    - name: "total_vulnerability_adjustment"
      expr: SUM(CAST(vulnerability_based_adjustment AS DOUBLE))
      comment: "Total value of vulnerability-based adjustments applied to entitlements — measures the equity premium invested in the most vulnerable beneficiaries."
    - name: "active_entitlement_count"
      expr: COUNT(DISTINCT CASE WHEN entitlement_status = 'Active' THEN entitlement_id END)
      comment: "Number of currently active entitlements — real-time active caseload for supply and cash distribution planning."
    - name: "unique_beneficiaries_entitled"
      expr: COUNT(DISTINCT registrant_id)
      comment: "Number of unique registrants with at least one entitlement — measures unduplicated programme reach for donor headcount reporting."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level metrics tracking population demographics, vulnerability, displacement status, and food security — essential for targeting, ration planning, and protection programme design."
  source: "`vibe_ngo_v1`.`beneficiary`.`household`"
  dimensions:
    - name: "displacement_status"
      expr: displacement_status
      comment: "Displacement status of the household (e.g. IDP, Refugee, Returnee, Host Community) — primary targeting dimension for humanitarian response."
    - name: "vulnerability_category"
      expr: vulnerability_category
      comment: "Vulnerability category assigned to the household — drives prioritisation and targeting decisions."
    - name: "food_security_status"
      expr: food_security_status
      comment: "Food security classification of the household (e.g. Food Secure, Moderately Food Insecure, Severely Food Insecure) — key indicator for food assistance targeting."
    - name: "is_female_headed"
      expr: is_female_headed
      comment: "Flag indicating female-headed household — required disaggregation for gender-sensitive programming and protection targeting."
    - name: "shelter_type"
      expr: shelter_type
      comment: "Type of shelter the household occupies — informs shelter programme targeting and NFI distribution planning."
    - name: "water_source_type"
      expr: water_source_type
      comment: "Primary water source type — WASH sector indicator for water access programming."
    - name: "registration_date_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Month of household registration — enables trend analysis of household intake over time."
    - name: "country_office_id"
      expr: country_office_id
      comment: "Country office responsible for the household — enables geographic disaggregation."
    - name: "admin1_name"
      expr: admin1_name
      comment: "Administrative level 1 area (e.g. province/state) — enables sub-national geographic analysis."
    - name: "admin2_name"
      expr: admin2_name
      comment: "Administrative level 2 area (e.g. district) — enables district-level targeting and operational planning."
  measures:
    - name: "total_households"
      expr: COUNT(DISTINCT household_id)
      comment: "Total number of registered households — primary household reach KPI for programme planning and donor reporting."
    - name: "female_headed_household_count"
      expr: COUNT(DISTINCT CASE WHEN is_female_headed = TRUE THEN household_id END)
      comment: "Number of female-headed households — gender equity KPI required by most donor frameworks and protection cluster reporting."
    - name: "gbv_risk_household_count"
      expr: COUNT(DISTINCT CASE WHEN gbv_risk_flag = TRUE THEN household_id END)
      comment: "Number of households with a GBV risk flag — protection targeting KPI that drives GBV prevention and response resource allocation."
    - name: "households_with_pregnant_lactating"
      expr: COUNT(DISTINCT CASE WHEN has_pregnant_lactating = TRUE THEN household_id END)
      comment: "Number of households with pregnant or lactating women — drives nutrition programme targeting and specialised ration planning."
    - name: "households_with_unaccompanied_minor"
      expr: COUNT(DISTINCT CASE WHEN has_unaccompanied_minor = TRUE THEN household_id END)
      comment: "Number of households containing unaccompanied or separated children — critical child protection caseload indicator."
    - name: "avg_vulnerability_score"
      expr: AVG(CAST(vulnerability_score AS DOUBLE))
      comment: "Average household vulnerability score — tracks overall population vulnerability level and informs targeting threshold calibration."
    - name: "consent_obtained_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN consent_obtained = TRUE THEN household_id END) / NULLIF(COUNT(DISTINCT household_id), 0), 2)
      comment: "Percentage of households with consent obtained — data protection compliance KPI required for ethical data collection and CHS adherence."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_needs_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Needs assessment metrics tracking multi-sector vulnerability scores, assessment coverage, and referral rates — essential for evidence-based programme design and resource allocation across sectors."
  source: "`vibe_ngo_v1`.`beneficiary`.`needs_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of needs assessment conducted (e.g. Household, Individual, Community) — enables comparison across assessment methodologies."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (e.g. Completed, Pending Validation, Rejected) — tracks assessment pipeline and data quality."
    - name: "vulnerability_category"
      expr: vulnerability_category
      comment: "Vulnerability category assigned based on assessment results — primary targeting output of the assessment process."
    - name: "displacement_status"
      expr: displacement_status
      comment: "Displacement status of the assessed population — enables disaggregation of needs by population type."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment — enables trend analysis of assessment coverage and vulnerability score changes over time."
    - name: "admin1_name"
      expr: admin1_name
      comment: "Administrative level 1 area — enables geographic disaggregation of assessed needs."
    - name: "admin2_name"
      expr: admin2_name
      comment: "Administrative level 2 area — enables district-level needs mapping."
    - name: "assessment_level"
      expr: assessment_level
      comment: "Level at which the assessment was conducted (e.g. Household, Individual, Community) — contextualises score interpretation."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Partner organisation that conducted the assessment — enables partner-level data quality and coverage comparison."
  measures:
    - name: "total_assessments"
      expr: COUNT(DISTINCT needs_assessment_id)
      comment: "Total number of needs assessments conducted — measures assessment coverage and evidence base for programme design."
    - name: "avg_overall_vulnerability_score"
      expr: AVG(CAST(overall_vulnerability_score AS DOUBLE))
      comment: "Average composite vulnerability score across all assessed households — headline indicator of population need severity used in situation reports and donor briefings."
    - name: "avg_nutrition_score"
      expr: AVG(CAST(nutrition_score AS DOUBLE))
      comment: "Average nutrition sector score — drives food and nutrition programme targeting and resource allocation decisions."
    - name: "avg_protection_score"
      expr: AVG(CAST(protection_score AS DOUBLE))
      comment: "Average protection sector score — informs protection programme design and resource prioritisation."
    - name: "avg_wash_score"
      expr: AVG(CAST(wash_score AS DOUBLE))
      comment: "Average WASH sector score — drives water, sanitation, and hygiene programme targeting and infrastructure investment decisions."
    - name: "avg_shelter_score"
      expr: AVG(CAST(shelter_score AS DOUBLE))
      comment: "Average shelter sector score — informs shelter programme targeting and NFI distribution planning."
    - name: "avg_livelihoods_score"
      expr: AVG(CAST(livelihoods_score AS DOUBLE))
      comment: "Average livelihoods sector score — drives economic recovery and livelihoods programme design."
    - name: "avg_education_score"
      expr: AVG(CAST(education_score AS DOUBLE))
      comment: "Average education sector score — informs education programme targeting and school-in-a-box distribution planning."
    - name: "referral_recommended_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN referral_recommended = TRUE THEN needs_assessment_id END) / NULLIF(COUNT(DISTINCT needs_assessment_id), 0), 2)
      comment: "Percentage of assessments resulting in a referral recommendation — measures the severity of unmet needs and referral pathway demand."
    - name: "gbv_risk_assessment_count"
      expr: COUNT(DISTINCT CASE WHEN gbv_risk_flag = TRUE THEN needs_assessment_id END)
      comment: "Number of assessments identifying GBV risk — drives GBV prevention programme targeting and safe space resource allocation."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_referral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Referral pathway metrics tracking referral volume, completion rates, response timeliness, and outcome quality — essential for service coordination, protection network management, and partner accountability."
  source: "`vibe_ngo_v1`.`beneficiary`.`referral`"
  dimensions:
    - name: "referral_status"
      expr: referral_status
      comment: "Current status of the referral (e.g. Pending, Accepted, Completed, Declined, Cancelled) — primary operational dimension for referral pipeline management."
    - name: "referral_type"
      expr: referral_type
      comment: "Type of referral (e.g. Internal, External, Emergency) — informs service coordination and partner network capacity planning."
    - name: "category"
      expr: category
      comment: "Sector category of the referral (e.g. Health, Legal, Psychosocial, Shelter) — enables sector-specific referral pathway analysis."
    - name: "outcome_category"
      expr: outcome_category
      comment: "Outcome category of the completed referral — measures referral quality and service delivery effectiveness."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the referral (e.g. Emergency, High, Standard) — drives triage and response time standards."
    - name: "receiving_service_type"
      expr: receiving_service_type
      comment: "Type of service provided by the receiving organisation — enables service gap analysis and network mapping."
    - name: "referral_date_month"
      expr: DATE_TRUNC('MONTH', referral_date)
      comment: "Month the referral was made — enables trend analysis of referral demand over time."
    - name: "gbv_case_flag"
      expr: gbv_case_flag
      comment: "Flag indicating the referral is for a GBV case — enables GBV-specific referral pathway monitoring."
    - name: "country_office_id"
      expr: country_office_id
      comment: "Country office managing the referral — enables geographic comparison of referral pathway performance."
  measures:
    - name: "total_referrals"
      expr: COUNT(DISTINCT referral_id)
      comment: "Total number of referrals made — primary volume KPI for service coordination and referral network utilisation."
    - name: "referral_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN referral_status = 'Completed' THEN referral_id END) / NULLIF(COUNT(DISTINCT referral_id), 0), 2)
      comment: "Percentage of referrals that reached completion — measures referral pathway effectiveness and service delivery follow-through."
    - name: "referral_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN acceptance_date IS NOT NULL THEN referral_id END) / NULLIF(COUNT(DISTINCT referral_id), 0), 2)
      comment: "Percentage of referrals accepted by receiving organisations — measures referral network responsiveness and partner capacity."
    - name: "follow_up_completed_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN follow_up_completed_flag = TRUE THEN referral_id END) / NULLIF(COUNT(DISTINCT referral_id), 0), 2)
      comment: "Percentage of referrals with follow-up completed — quality assurance KPI ensuring beneficiaries receive referred services."
    - name: "gbv_referral_count"
      expr: COUNT(DISTINCT CASE WHEN gbv_case_flag = TRUE THEN referral_id END)
      comment: "Number of GBV-related referrals — critical protection metric for GBV survivor service coordination and pathway monitoring."
    - name: "feedback_received_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN feedback_received_flag = TRUE THEN referral_id END) / NULLIF(COUNT(DISTINCT referral_id), 0), 2)
      comment: "Percentage of referrals with beneficiary feedback received — accountability to affected populations (AAP) metric required by CHS and donor frameworks."
    - name: "protection_concern_referral_count"
      expr: COUNT(DISTINCT CASE WHEN protection_concern_flag = TRUE THEN referral_id END)
      comment: "Number of referrals flagged with a protection concern — drives protection cluster escalation and inter-agency coordination decisions."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_vulnerability_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vulnerability profiling metrics tracking composite vulnerability scores, protection risk levels, and multi-dimensional vulnerability indicators — essential for targeting, programme design, and longitudinal vulnerability trend analysis."
  source: "`vibe_ngo_v1`.`beneficiary`.`vulnerability_profile`"
  dimensions:
    - name: "vulnerability_tier"
      expr: vulnerability_tier
      comment: "Vulnerability tier assigned to the profile (e.g. Extreme, High, Medium, Low) — primary targeting dimension for programme prioritisation."
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the vulnerability profile (e.g. Active, Superseded, Archived) — ensures analysis uses current profiles only."
    - name: "protection_risk_level"
      expr: protection_risk_level
      comment: "Protection risk level assigned in the profile — drives protection programme targeting and case escalation decisions."
    - name: "ipc_phase"
      expr: ipc_phase
      comment: "IPC (Integrated Food Security Phase Classification) phase — internationally recognised food security indicator used in humanitarian situation reports."
    - name: "displacement_category"
      expr: displacement_category
      comment: "Displacement category of the profiled household — enables disaggregation of vulnerability by population type."
    - name: "livelihood_status"
      expr: livelihood_status
      comment: "Livelihood status recorded in the profile — informs economic recovery and livelihoods programme targeting."
    - name: "nutritional_status"
      expr: nutritional_status
      comment: "Nutritional status classification — drives food and nutrition programme targeting."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of vulnerability assessment — enables longitudinal tracking of vulnerability score trends."
    - name: "country_office_id"
      expr: country_office_id
      comment: "Country office responsible for the profile — enables geographic disaggregation of vulnerability distribution."
    - name: "female_headed_household_flag"
      expr: female_headed_household_flag
      comment: "Flag for female-headed households — required gender disaggregation for equity analysis."
  measures:
    - name: "total_vulnerability_profiles"
      expr: COUNT(DISTINCT vulnerability_profile_id)
      comment: "Total number of vulnerability profiles — measures assessment coverage of the beneficiary population."
    - name: "avg_composite_vulnerability_score"
      expr: AVG(CAST(composite_vulnerability_score AS DOUBLE))
      comment: "Average composite vulnerability score across all profiles — headline population vulnerability indicator used in situation reports, donor briefings, and targeting threshold calibration."
    - name: "extreme_vulnerability_count"
      expr: COUNT(DISTINCT CASE WHEN vulnerability_tier = 'Extreme' THEN vulnerability_profile_id END)
      comment: "Number of profiles in the extreme vulnerability tier — identifies the most critical caseload requiring immediate and intensive programme response."
    - name: "gbv_exposure_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN gbv_exposure_flag = TRUE THEN vulnerability_profile_id END) / NULLIF(COUNT(DISTINCT vulnerability_profile_id), 0), 2)
      comment: "Percentage of profiles with GBV exposure flagged — measures GBV prevalence in the assessed population, driving GBV programme scale and resource allocation."
    - name: "chronic_illness_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN chronic_illness_flag = TRUE THEN vulnerability_profile_id END) / NULLIF(COUNT(DISTINCT vulnerability_profile_id), 0), 2)
      comment: "Percentage of profiles with chronic illness — informs health programme targeting and specialised nutrition/medical support planning."
    - name: "pss_need_count"
      expr: COUNT(DISTINCT CASE WHEN pss_need_flag = TRUE THEN vulnerability_profile_id END)
      comment: "Number of profiles with identified psychosocial support (PSS) need — drives PSS programme capacity planning and mental health resource allocation."
    - name: "avg_muac_mm"
      expr: AVG(CAST(muac_mm AS DOUBLE))
      comment: "Average MUAC measurement in millimetres from vulnerability profiles — population-level acute malnutrition indicator used in nutrition cluster reporting."
    - name: "wash_access_gap_count"
      expr: COUNT(DISTINCT CASE WHEN wash_access_flag = FALSE THEN vulnerability_profile_id END)
      comment: "Number of profiles where WASH access is absent — measures WASH service gap and drives water and sanitation infrastructure investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_registration_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Registration event metrics tracking registration throughput, data quality, deduplication performance, and biometric capture rates — essential for registration programme management and data integrity governance."
  source: "`vibe_ngo_v1`.`beneficiary`.`registration_event`"
  dimensions:
    - name: "registration_date_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Month of registration event — enables trend analysis of registration throughput over time."
    - name: "biometric_type"
      expr: biometric_type
      comment: "Type of biometric data captured (e.g. Fingerprint, Iris, Photo) — informs biometric system coverage and deduplication capability."
    - name: "deduplication_method"
      expr: deduplication_method
      comment: "Method used for deduplication check — enables comparison of deduplication approach effectiveness."
    - name: "duplicate_resolution_status"
      expr: duplicate_resolution_status
      comment: "Status of duplicate resolution for flagged records — tracks deduplication backlog and data integrity risk."
    - name: "country_office_id"
      expr: country_office_id
      comment: "Country office where the registration event occurred — enables geographic performance comparison."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Partner organisation conducting the registration — enables partner-level data quality benchmarking."
    - name: "household_registration"
      expr: household_registration
      comment: "Flag indicating whether the event was a household-level registration — distinguishes household vs individual registration events."
  measures:
    - name: "total_registration_events"
      expr: COUNT(DISTINCT registration_event_id)
      comment: "Total number of registration events — measures registration programme throughput and operational tempo."
    - name: "biometric_capture_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN biometric_captured = TRUE THEN registration_event_id END) / NULLIF(COUNT(DISTINCT registration_event_id), 0), 2)
      comment: "Percentage of registration events with biometric data captured — measures biometric enrolment coverage, which directly affects deduplication accuracy and fraud prevention."
    - name: "deduplication_check_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN deduplication_check_performed = TRUE THEN registration_event_id END) / NULLIF(COUNT(DISTINCT registration_event_id), 0), 2)
      comment: "Percentage of registration events where a deduplication check was performed — data integrity compliance KPI; low rates indicate risk of double registration."
    - name: "duplicate_detection_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN duplicate_found = TRUE THEN registration_event_id END) / NULLIF(COUNT(DISTINCT CASE WHEN deduplication_check_performed = TRUE THEN registration_event_id END), 0), 2)
      comment: "Percentage of deduplication-checked registrations where a duplicate was found — measures duplicate registration prevalence and risk of inflated beneficiary counts."
    - name: "avg_registration_completeness_score"
      expr: AVG(CAST(registration_completeness_score AS DOUBLE))
      comment: "Average registration data completeness score — measures registration data quality, which affects eligibility determination and programme targeting accuracy."
    - name: "data_quality_flag_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN data_quality_flag = TRUE THEN registration_event_id END) / NULLIF(COUNT(DISTINCT registration_event_id), 0), 2)
      comment: "Percentage of registration events flagged for data quality issues — operational quality control KPI that triggers data cleaning and re-registration workflows."
    - name: "vulnerability_assessment_conducted_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN vulnerability_assessment_conducted = TRUE THEN registration_event_id END) / NULLIF(COUNT(DISTINCT registration_event_id), 0), 2)
      comment: "Percentage of registration events where a vulnerability assessment was conducted — measures integration of vulnerability screening into the registration process."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`beneficiary_consent_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent management metrics tracking consent coverage, compliance with data protection standards, and consent validity — essential for CHS compliance, GDPR obligations, and ethical data governance."
  source: "`vibe_ngo_v1`.`beneficiary`.`consent_record`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent record (e.g. Active, Withdrawn, Expired) — primary dimension for consent compliance monitoring."
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent obtained (e.g. Data Collection, Photography, Sharing, Biometric) — enables disaggregation of consent coverage by purpose."
    - name: "consent_method"
      expr: consent_method
      comment: "Method used to obtain consent (e.g. Written, Verbal, Digital) — informs consent quality and legal defensibility."
    - name: "consent_language"
      expr: consent_language
      comment: "Language in which consent was obtained — measures informed consent quality and language accessibility."
    - name: "gdpr_applicable"
      expr: gdpr_applicable
      comment: "Flag indicating GDPR applicability — enables GDPR-specific compliance reporting."
    - name: "consent_date_month"
      expr: DATE_TRUNC('MONTH', consent_date)
      comment: "Month consent was obtained — enables trend analysis of consent collection over time."
    - name: "country_office_id"
      expr: country_office_id
      comment: "Country office where consent was collected — enables geographic compliance comparison."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Partner organisation that collected consent — enables partner-level compliance benchmarking."
  measures:
    - name: "total_consent_records"
      expr: COUNT(DISTINCT consent_record_id)
      comment: "Total number of consent records — baseline measure of consent documentation coverage across the beneficiary population."
    - name: "active_consent_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN consent_status = 'Active' THEN consent_record_id END) / NULLIF(COUNT(DISTINCT consent_record_id), 0), 2)
      comment: "Percentage of consent records currently active — primary data protection compliance KPI; low rates indicate risk of processing data without valid consent."
    - name: "informed_consent_verified_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN informed_consent_verified = TRUE THEN consent_record_id END) / NULLIF(COUNT(DISTINCT consent_record_id), 0), 2)
      comment: "Percentage of consent records where informed consent was verified — CHS and GDPR compliance quality metric ensuring beneficiaries understood what they consented to."
    - name: "proxy_consent_count"
      expr: COUNT(DISTINCT CASE WHEN is_proxy_consent = TRUE THEN consent_record_id END)
      comment: "Number of consent records obtained via proxy — measures the volume of vulnerable beneficiaries (e.g. children, persons with disabilities) requiring proxy consent, informing safeguarding protocols."
    - name: "withdrawal_count"
      expr: COUNT(DISTINCT CASE WHEN withdrawal_date IS NOT NULL THEN consent_record_id END)
      comment: "Number of consent withdrawals — tracks beneficiary opt-out volume; significant increases trigger data deletion and programme exit workflows."
    - name: "photography_permitted_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN photography_permitted = TRUE THEN consent_record_id END) / NULLIF(COUNT(DISTINCT consent_record_id), 0), 2)
      comment: "Percentage of beneficiaries permitting photography — informs communications and visibility activities; prevents unauthorised use of beneficiary images."
    - name: "data_sharing_permitted_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN sharing_permitted = TRUE THEN consent_record_id END) / NULLIF(COUNT(DISTINCT consent_record_id), 0), 2)
      comment: "Percentage of beneficiaries permitting data sharing — governs inter-agency data sharing agreements and determines which records can be included in shared databases."
$$;