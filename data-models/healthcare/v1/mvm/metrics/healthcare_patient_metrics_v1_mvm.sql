-- Metric views for domain: patient | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 18:58:55

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`patient_mpi_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Master Patient Index (MPI) quality and population metrics. Tracks patient identity integrity, duplicate/overlay rates, and demographic completeness — critical for enterprise patient matching governance and population health management."
  source: "`healthcare_ecm`.`patient`.`mpi_record`"
  dimensions:
    - name: "mpi_record_status"
      expr: mpi_record_status
      comment: "Current status of the MPI record (e.g., active, merged, deceased) — primary segmentation axis for population analysis."
    - name: "identity_resolution_status"
      expr: identity_resolution_status
      comment: "Status of the identity resolution process — used to segment records by matching confidence and resolution completeness."
    - name: "identity_confidence_tier"
      expr: identity_confidence_tier
      comment: "Confidence tier assigned by the MPI matching algorithm — stratifies population by identity certainty level."
    - name: "patient_class"
      expr: patient_class
      comment: "Classification of the patient (e.g., inpatient, outpatient, emergency) — enables population segmentation by care setting."
    - name: "sex_at_birth"
      expr: sex_at_birth
      comment: "Biological sex recorded at birth — standard demographic dimension for clinical and population health reporting."
    - name: "race_code"
      expr: race_code
      comment: "Race code per standard classification — supports health equity and disparity analysis."
    - name: "ethnicity_code"
      expr: ethnicity_code
      comment: "Ethnicity code per standard classification — supports health equity and disparity analysis."
    - name: "primary_language_code"
      expr: primary_language_code
      comment: "Patient's primary language — used to assess interpreter needs and language access equity."
    - name: "first_registration_year"
      expr: DATE_TRUNC('YEAR', first_registration_date)
      comment: "Year of first patient registration — enables cohort analysis and new patient acquisition trending."
    - name: "deceased_flag"
      expr: deceased_flag
      comment: "Indicates whether the patient is deceased — critical filter for active population denominators."
    - name: "restricted_access_flag"
      expr: restricted_access_flag
      comment: "Indicates records with restricted access (e.g., VIP, sensitive) — used for compliance and access governance reporting."
    - name: "vip_flag"
      expr: vip_flag
      comment: "Indicates VIP patient designation — used for service-level and privacy compliance monitoring."
    - name: "national_health_id_type"
      expr: national_health_id_type
      comment: "Type of national health identifier on file (e.g., Medicare, Medicaid) — supports payer and program eligibility analysis."
  measures:
    - name: "total_active_patients"
      expr: COUNT(CASE WHEN mpi_record_status = 'active' AND (is_duplicate_flag = FALSE OR is_duplicate_flag IS NULL) THEN mpi_record_id END)
      comment: "Count of unique active, non-duplicate MPI records — the authoritative active patient population denominator for all enterprise KPIs."
    - name: "duplicate_record_count"
      expr: COUNT(CASE WHEN is_duplicate_flag = TRUE THEN mpi_record_id END)
      comment: "Number of MPI records flagged as duplicates — a direct measure of patient identity data quality; high values indicate MPI governance risk."
    - name: "duplicate_record_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_duplicate_flag = TRUE THEN mpi_record_id END) / NULLIF(COUNT(mpi_record_id), 0), 2)
      comment: "Percentage of MPI records flagged as duplicates — key data quality KPI tracked by HIM and CDO; drives MPI remediation investment decisions."
    - name: "overlay_record_count"
      expr: COUNT(CASE WHEN is_overlay_flag = TRUE THEN mpi_record_id END)
      comment: "Number of MPI overlay events — overlays represent patient safety incidents where records are incorrectly merged; tracked by patient safety and compliance teams."
    - name: "deceased_patient_count"
      expr: COUNT(CASE WHEN deceased_flag = TRUE THEN mpi_record_id END)
      comment: "Count of patients recorded as deceased — used to maintain accurate active population denominators and trigger downstream care program disenrollments."
    - name: "interpreter_required_patient_count"
      expr: COUNT(CASE WHEN interpreter_required_flag = TRUE THEN mpi_record_id END)
      comment: "Number of patients requiring interpreter services — informs language access resource planning and compliance with Title VI requirements."
    - name: "avg_match_confidence_score"
      expr: ROUND(AVG(CAST(match_confidence_score AS DOUBLE)), 4)
      comment: "Average MPI match confidence score across all records — monitors overall identity resolution quality; declining scores signal algorithm or data degradation."
    - name: "patients_with_medicare_number"
      expr: COUNT(CASE WHEN medicare_beneficiary_number IS NOT NULL AND medicare_beneficiary_number <> '' THEN mpi_record_id END)
      comment: "Count of patients with a Medicare Beneficiary Identifier on file — supports Medicare program eligibility and value-based care attribution reporting."
    - name: "patients_with_medicaid_number"
      expr: COUNT(CASE WHEN medicaid_number IS NOT NULL AND medicaid_number <> '' THEN mpi_record_id END)
      comment: "Count of patients with a Medicaid number on file — supports Medicaid managed care and state program reporting."
    - name: "restricted_access_patient_count"
      expr: COUNT(CASE WHEN restricted_access_flag = TRUE THEN mpi_record_id END)
      comment: "Number of patients with restricted access flags — used by compliance and privacy officers to monitor sensitive record volumes and access governance."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`patient_demographics`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient demographic completeness and social determinants of health (SDOH) metrics. Supports population health management, health equity reporting, and patient engagement program targeting."
  source: "`healthcare_ecm`.`patient`.`demographics`"
  dimensions:
    - name: "sex_at_birth"
      expr: sex_at_birth
      comment: "Biological sex at birth — standard demographic segmentation dimension for clinical and population health reporting."
    - name: "race_code"
      expr: race_code
      comment: "Race code — supports health equity analysis and disparity reporting required by CMS and accreditation bodies."
    - name: "ethnicity_code"
      expr: ethnicity_code
      comment: "Ethnicity code — supports health equity analysis and HEDIS demographic stratification."
    - name: "preferred_language_code"
      expr: preferred_language_code
      comment: "Patient's preferred language — drives language access resource allocation and compliance reporting."
    - name: "marital_status"
      expr: marital_status
      comment: "Marital status — used in social risk stratification and care coordination models."
    - name: "registration_status"
      expr: registration_status
      comment: "Current registration status of the demographic record — used to filter active vs. inactive patient populations."
    - name: "sdoh_housing_status"
      expr: sdoh_housing_status
      comment: "Social determinant: housing status — key SDOH dimension for care management targeting and value-based care risk stratification."
    - name: "birth_year"
      expr: DATE_TRUNC('YEAR', birth_date)
      comment: "Year of birth — enables age-cohort analysis for population health and actuarial reporting."
    - name: "deceased_indicator"
      expr: deceased_indicator
      comment: "Indicates patient is deceased — used to exclude deceased patients from active population denominators."
    - name: "patient_portal_enrolled"
      expr: patient_portal_enrolled
      comment: "Whether the patient is enrolled in the patient portal — segments population by digital engagement status."
    - name: "interpreter_required"
      expr: interpreter_required
      comment: "Whether the patient requires an interpreter — used for language access planning and compliance."
  measures:
    - name: "total_demographic_records"
      expr: COUNT(demographics_id)
      comment: "Total count of demographic records — baseline population denominator for all demographic completeness KPIs."
    - name: "portal_enrollment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN patient_portal_enrolled = TRUE THEN demographics_id END) / NULLIF(COUNT(demographics_id), 0), 2)
      comment: "Percentage of patients enrolled in the patient portal — strategic KPI for digital health engagement; directly tied to patient satisfaction and care coordination efficiency."
    - name: "sdoh_food_insecurity_count"
      expr: COUNT(CASE WHEN sdoh_food_insecurity = TRUE THEN demographics_id END)
      comment: "Number of patients with documented food insecurity — drives social care program targeting and community health investment decisions."
    - name: "sdoh_food_insecurity_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sdoh_food_insecurity = TRUE THEN demographics_id END) / NULLIF(COUNT(demographics_id), 0), 2)
      comment: "Percentage of patients with food insecurity — SDOH prevalence KPI used by population health and community benefit programs to allocate resources."
    - name: "interpreter_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN interpreter_required = TRUE THEN demographics_id END) / NULLIF(COUNT(demographics_id), 0), 2)
      comment: "Percentage of patients requiring interpreter services — informs language access staffing and compliance with federal language access mandates."
    - name: "deceased_patient_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN deceased_indicator = TRUE THEN demographics_id END) / NULLIF(COUNT(demographics_id), 0), 2)
      comment: "Percentage of demographic records marked deceased — used to assess active population accuracy and trigger downstream record lifecycle management."
    - name: "advance_directive_on_file_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN advance_directive_on_file = TRUE THEN demographics_id END) / NULLIF(COUNT(demographics_id), 0), 2)
      comment: "Percentage of patients with an advance directive on file — quality and compliance KPI tracked by palliative care, ethics, and accreditation programs."
    - name: "email_address_capture_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN email_address IS NOT NULL AND email_address <> '' THEN demographics_id END) / NULLIF(COUNT(demographics_id), 0), 2)
      comment: "Percentage of patients with a valid email address on file — measures digital contact data completeness; directly impacts portal enrollment and outreach campaign effectiveness."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`patient_care_program_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care program enrollment performance and outcomes metrics. Tracks enrollment volumes, active program participation, disenrollment patterns, and risk stratification — core KPIs for care management, population health, and value-based care program governance."
  source: "`healthcare_ecm`.`patient`.`care_program_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (e.g., active, disenrolled, pending) — primary segmentation axis for program participation analysis."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source channel that triggered enrollment (e.g., referral, self-referral, claims-based) — used to evaluate program intake channel effectiveness."
    - name: "disenrollment_reason"
      expr: disenrollment_reason
      comment: "Reason for disenrollment — identifies root causes of program attrition to drive retention improvement initiatives."
    - name: "program_outcome"
      expr: program_outcome
      comment: "Documented outcome of the care program episode — used to evaluate program clinical effectiveness and ROI."
    - name: "value_based_contract_type"
      expr: value_based_contract_type
      comment: "Type of value-based contract associated with the enrollment — segments program performance by contract model (e.g., ACO, PCMH, bundled payment)."
    - name: "risk_score_model_version"
      expr: risk_score_model_version
      comment: "Version of the risk scoring model used for stratification — enables model performance comparison across cohorts."
    - name: "enrollment_year"
      expr: DATE_TRUNC('YEAR', enrollment_date)
      comment: "Year of enrollment — enables year-over-year program growth and cohort trend analysis."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment — supports monthly enrollment trend monitoring and seasonal pattern detection."
    - name: "consent_obtained_flag"
      expr: consent_obtained_flag
      comment: "Whether consent was obtained at enrollment — compliance dimension; enrollments without consent may represent regulatory risk."
    - name: "source_system"
      expr: source_system
      comment: "Source system that originated the enrollment record — used for data lineage and system-level quality monitoring."
  measures:
    - name: "total_enrollments"
      expr: COUNT(care_program_enrollment_id)
      comment: "Total number of care program enrollment records — baseline volume KPI for program capacity and growth tracking."
    - name: "active_enrollment_count"
      expr: COUNT(CASE WHEN enrollment_status = 'active' THEN care_program_enrollment_id END)
      comment: "Number of currently active care program enrollments — primary operational KPI for care management capacity planning and program utilization."
    - name: "disenrollment_count"
      expr: COUNT(CASE WHEN disenrollment_date IS NOT NULL THEN care_program_enrollment_id END)
      comment: "Number of enrollments that have been disenrolled — measures program attrition volume; high values trigger retention intervention analysis."
    - name: "disenrollment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN disenrollment_date IS NOT NULL THEN care_program_enrollment_id END) / NULLIF(COUNT(care_program_enrollment_id), 0), 2)
      comment: "Percentage of enrollments that resulted in disenrollment — strategic KPI for program retention; directly tied to value-based care contract performance and per-member revenue."
    - name: "consent_obtained_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_obtained_flag = TRUE THEN care_program_enrollment_id END) / NULLIF(COUNT(care_program_enrollment_id), 0), 2)
      comment: "Percentage of enrollments with documented consent — compliance KPI; non-consented enrollments represent regulatory and legal risk under HIPAA and state privacy laws."
    - name: "distinct_patients_enrolled"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients enrolled in care programs — measures program reach across the patient population; key metric for population health program ROI assessment."
    - name: "avg_days_since_last_care_manager_contact"
      expr: ROUND(AVG(DATEDIFF(CURRENT_DATE(), last_care_manager_contact_date)), 1)
      comment: "Average number of days since the last care manager contact across active enrollments — operational KPI for care manager engagement frequency; high values indicate care gap risk."
    - name: "enrollments_never_contacted"
      expr: COUNT(CASE WHEN last_care_manager_contact_date IS NULL THEN care_program_enrollment_id END)
      comment: "Number of enrollments with no recorded care manager contact — identifies patients at risk of falling through care management gaps; directly actionable by care management operations."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`patient_insurance_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient insurance coverage financial exposure and eligibility metrics. Tracks deductible utilization, out-of-pocket exposure, coverage status, and benefit year performance — essential for revenue cycle, financial counseling, and payer contract management."
  source: "`healthcare_ecm`.`patient`.`insurance_coverage`"
  dimensions:
    - name: "coverage_status"
      expr: coverage_status
      comment: "Current status of the insurance coverage (e.g., active, terminated, pending) — primary filter for active coverage population analysis."
    - name: "cob_priority"
      expr: cob_priority
      comment: "Coordination of benefits priority (primary, secondary, tertiary) — used to segment coverage by payer responsibility order."
    - name: "medicare_part"
      expr: medicare_part
      comment: "Medicare part designation (A, B, C, D) — enables Medicare-specific benefit and cost analysis."
    - name: "medicaid_state_code"
      expr: medicaid_state_code
      comment: "State code for Medicaid coverage — supports state-level Medicaid program performance and compliance reporting."
    - name: "eligibility_verification_status"
      expr: eligibility_verification_status
      comment: "Status of the most recent eligibility verification — used to identify coverage records with unverified or failed eligibility checks."
    - name: "prior_auth_required"
      expr: prior_auth_required
      comment: "Whether prior authorization is required under this coverage — used to segment high-friction coverage types and assess prior auth burden."
    - name: "referral_required"
      expr: referral_required
      comment: "Whether a referral is required under this coverage — used to assess network management complexity and referral workflow burden."
    - name: "benefit_year_start"
      expr: DATE_TRUNC('YEAR', benefit_year_start)
      comment: "Benefit year start — enables benefit year cohort analysis for deductible and out-of-pocket accumulator tracking."
    - name: "subscriber_relationship"
      expr: subscriber_relationship
      comment: "Relationship of the patient to the subscriber (self, spouse, dependent) — used for member-level financial responsibility analysis."
  measures:
    - name: "active_coverage_count"
      expr: COUNT(CASE WHEN coverage_status = 'active' THEN insurance_coverage_id END)
      comment: "Number of active insurance coverage records — baseline KPI for covered population size; used in revenue cycle and payer mix reporting."
    - name: "avg_deductible_amount"
      expr: ROUND(AVG(CAST(deductible_amount AS DOUBLE)), 2)
      comment: "Average deductible amount across coverage records — measures patient financial exposure; informs financial counseling program targeting and charity care eligibility screening."
    - name: "avg_deductible_met_amount"
      expr: ROUND(AVG(CAST(deductible_met_amount AS DOUBLE)), 2)
      comment: "Average deductible amount met by patients — paired with avg_deductible_amount to assess patient financial burden progress within the benefit year."
    - name: "avg_out_of_pocket_max"
      expr: ROUND(AVG(CAST(out_of_pocket_max AS DOUBLE)), 2)
      comment: "Average out-of-pocket maximum across coverage records — measures maximum patient financial liability; used in financial risk stratification and charity care program design."
    - name: "avg_out_of_pocket_met_amount"
      expr: ROUND(AVG(CAST(out_of_pocket_met_amount AS DOUBLE)), 2)
      comment: "Average out-of-pocket amount met by patients — tracks patient financial burden accumulation; high values indicate patients approaching catastrophic cost thresholds."
    - name: "total_deductible_exposure"
      expr: ROUND(SUM(CAST(deductible_amount AS DOUBLE)), 2)
      comment: "Total deductible exposure across all active coverage records — aggregate patient financial liability metric used by revenue cycle leadership for bad debt forecasting."
    - name: "total_deductible_met"
      expr: ROUND(SUM(CAST(deductible_met_amount AS DOUBLE)), 2)
      comment: "Total deductible amount met across all coverage records — measures aggregate patient payment progress; used alongside total_deductible_exposure for collection rate analysis."
    - name: "avg_copay_amount"
      expr: ROUND(AVG(CAST(copay_amount AS DOUBLE)), 2)
      comment: "Average copay amount across coverage records — measures point-of-service patient cost burden; informs access and affordability analysis."
    - name: "avg_coinsurance_rate"
      expr: ROUND(AVG(CAST(coinsurance_rate AS DOUBLE)), 4)
      comment: "Average coinsurance rate across coverage records — measures patient cost-sharing percentage; used in payer contract analysis and patient financial counseling program design."
    - name: "prior_auth_required_coverage_count"
      expr: COUNT(CASE WHEN prior_auth_required = TRUE THEN insurance_coverage_id END)
      comment: "Number of coverage records requiring prior authorization — measures prior auth burden volume; high values drive investment in prior auth automation and payer negotiation."
    - name: "terminated_coverage_count"
      expr: COUNT(CASE WHEN coverage_status = 'terminated' OR (termination_date IS NOT NULL AND termination_date < CURRENT_DATE()) THEN insurance_coverage_id END)
      comment: "Number of terminated coverage records — tracks coverage loss events; sudden increases signal payer contract issues or economic hardship trends requiring financial assistance outreach."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`patient_eligibility_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time eligibility verification performance and financial exposure metrics. Tracks verification success rates, prior authorization burden, deductible accumulation, and network status — critical for revenue cycle efficiency and denial prevention."
  source: "`healthcare_ecm`.`patient`.`eligibility_check`"
  dimensions:
    - name: "verification_status"
      expr: verification_status
      comment: "Outcome status of the eligibility verification transaction (e.g., eligible, ineligible, pending) — primary dimension for eligibility workflow performance analysis."
    - name: "verification_type"
      expr: verification_type
      comment: "Type of eligibility verification performed (e.g., real-time, batch, manual) — used to assess verification channel efficiency and cost."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used for verification (e.g., 270/271 EDI, portal, phone) — enables channel-level performance benchmarking."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage being verified (e.g., medical, dental, vision, pharmacy) — segments eligibility checks by benefit type."
    - name: "network_status"
      expr: network_status
      comment: "In-network or out-of-network status returned by the eligibility check — critical for patient cost estimation and referral routing decisions."
    - name: "prior_auth_required"
      expr: prior_auth_required
      comment: "Whether prior authorization is required per the eligibility response — used to segment high-friction service requests."
    - name: "referral_required"
      expr: referral_required
      comment: "Whether a referral is required per the eligibility response — used to assess referral workflow burden by payer and service type."
    - name: "service_type_code"
      expr: service_type_code
      comment: "Service type code from the eligibility transaction — enables service-level eligibility performance analysis."
    - name: "service_date_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month of the service date — enables monthly eligibility check volume and success rate trending."
    - name: "is_override"
      expr: is_override
      comment: "Whether the eligibility result was manually overridden — used to monitor override frequency and compliance risk."
    - name: "clearinghouse_name"
      expr: clearinghouse_name
      comment: "Name of the clearinghouse used for the eligibility transaction — enables clearinghouse performance benchmarking."
  measures:
    - name: "total_eligibility_checks"
      expr: COUNT(eligibility_check_id)
      comment: "Total number of eligibility verification transactions — baseline volume KPI for revenue cycle throughput and clearinghouse capacity planning."
    - name: "eligibility_verified_count"
      expr: COUNT(CASE WHEN verification_status = 'verified' OR verification_status = 'eligible' THEN eligibility_check_id END)
      comment: "Number of eligibility checks that returned a verified/eligible result — measures successful verification throughput."
    - name: "eligibility_verification_success_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'verified' OR verification_status = 'eligible' THEN eligibility_check_id END) / NULLIF(COUNT(eligibility_check_id), 0), 2)
      comment: "Percentage of eligibility checks that returned a successful verification — primary revenue cycle quality KPI; low rates predict increased claim denials and rework costs."
    - name: "prior_auth_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN prior_auth_required = TRUE THEN eligibility_check_id END) / NULLIF(COUNT(eligibility_check_id), 0), 2)
      comment: "Percentage of eligibility checks indicating prior authorization is required — measures prior auth burden; high rates drive investment in PA automation and payer contract renegotiation."
    - name: "override_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_override = TRUE THEN eligibility_check_id END) / NULLIF(COUNT(eligibility_check_id), 0), 2)
      comment: "Percentage of eligibility checks that were manually overridden — compliance and audit KPI; high override rates indicate process control weaknesses and potential billing risk."
    - name: "avg_individual_deductible_amount"
      expr: ROUND(AVG(CAST(individual_deductible_amount AS DOUBLE)), 2)
      comment: "Average individual deductible amount returned by eligibility checks — measures patient financial exposure at point of service; informs financial counseling and upfront collection strategies."
    - name: "avg_individual_deductible_met"
      expr: ROUND(AVG(CAST(individual_deductible_met_amount AS DOUBLE)), 2)
      comment: "Average individual deductible amount already met — paired with avg_individual_deductible_amount to assess remaining patient liability at time of service."
    - name: "avg_individual_out_of_pocket_max"
      expr: ROUND(AVG(CAST(individual_out_of_pocket_max AS DOUBLE)), 2)
      comment: "Average individual out-of-pocket maximum — measures maximum patient financial liability; used in financial risk stratification and charity care eligibility screening."
    - name: "avg_copay_amount"
      expr: ROUND(AVG(CAST(copay_amount AS DOUBLE)), 2)
      comment: "Average copay amount returned by eligibility checks — measures point-of-service patient cost burden; used in patient cost estimation and financial counseling workflows."
    - name: "out_of_network_check_count"
      expr: COUNT(CASE WHEN network_status = 'out-of-network' OR network_status = 'OON' THEN eligibility_check_id END)
      comment: "Number of eligibility checks returning out-of-network status — measures out-of-network utilization risk; high volumes indicate network adequacy gaps or referral routing failures."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`patient_pcp_attribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Primary Care Provider (PCP) attribution quality and value-based care performance metrics. Tracks attribution confidence, panel composition, risk stratification, and HEDIS/MIPS eligibility — core KPIs for ACO, PCMH, and value-based contract governance."
  source: "`healthcare_ecm`.`patient`.`pcp_attribution`"
  dimensions:
    - name: "attribution_status"
      expr: attribution_status
      comment: "Current status of the PCP attribution (e.g., active, pending, disenrolled) — primary segmentation axis for attributed population analysis."
    - name: "attribution_method"
      expr: attribution_method
      comment: "Method used to attribute the patient to a PCP (e.g., claims-based, voluntary, algorithmic) — used to assess attribution methodology mix and confidence."
    - name: "attribution_source"
      expr: attribution_source
      comment: "Source of the attribution (e.g., payer, health system, ACO) — enables attribution source performance comparison."
    - name: "risk_stratification_tier"
      expr: risk_stratification_tier
      comment: "Risk tier assigned to the attributed patient (e.g., low, medium, high, rising) — primary dimension for care management resource allocation and value-based care performance analysis."
    - name: "attribution_segment"
      expr: attribution_segment
      comment: "Business segment of the attribution (e.g., Medicare, Medicaid, commercial) — enables payer-segment-level value-based care performance reporting."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the attributed patient — supports regional performance benchmarking and network adequacy analysis."
    - name: "measurement_year"
      expr: measurement_year
      comment: "Measurement year for the attribution — enables year-over-year value-based care performance comparison."
    - name: "is_primary_attribution"
      expr: is_primary_attribution
      comment: "Whether this is the primary attribution for the patient — used to deduplicate patients with multiple attribution records."
    - name: "hedis_eligible"
      expr: hedis_eligible
      comment: "Whether the patient is eligible for HEDIS measure reporting — segments the attributed population by quality measure eligibility."
    - name: "mips_eligible"
      expr: mips_eligible
      comment: "Whether the patient is eligible for MIPS reporting — segments the attributed population by Merit-based Incentive Payment System eligibility."
    - name: "care_management_enrolled"
      expr: care_management_enrolled
      comment: "Whether the attributed patient is enrolled in care management — used to assess care management penetration within the attributed panel."
    - name: "sdoh_flag"
      expr: sdoh_flag
      comment: "Whether the patient has documented social determinants of health risk — used to segment the attributed panel by social risk for targeted intervention."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the attribution became effective — enables attribution cohort and panel growth trend analysis."
  measures:
    - name: "total_attributed_patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Total number of unique patients attributed to a PCP — the authoritative attributed panel size KPI for value-based care contract performance and per-member-per-month revenue calculations."
    - name: "active_attribution_count"
      expr: COUNT(CASE WHEN attribution_status = 'active' THEN pcp_attribution_id END)
      comment: "Number of active PCP attribution records — measures current attributed panel volume; directly tied to capitation revenue and value-based care contract performance."
    - name: "avg_attribution_confidence_score"
      expr: ROUND(AVG(CAST(attribution_confidence_score AS DOUBLE)), 4)
      comment: "Average attribution confidence score across all attribution records — measures attribution algorithm quality; low scores indicate attribution instability risk that can affect contract performance."
    - name: "avg_hcc_risk_score"
      expr: ROUND(AVG(CAST(hcc_risk_score AS DOUBLE)), 4)
      comment: "Average HCC (Hierarchical Condition Category) risk score across the attributed panel — primary actuarial KPI for value-based care; directly determines capitation payment rates and risk adjustment revenue."
    - name: "high_risk_patient_count"
      expr: COUNT(CASE WHEN risk_stratification_tier = 'high' THEN pcp_attribution_id END)
      comment: "Number of patients in the high-risk stratification tier — measures high-acuity panel burden; drives care management staffing and intervention program investment decisions."
    - name: "high_risk_patient_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_stratification_tier = 'high' THEN pcp_attribution_id END) / NULLIF(COUNT(pcp_attribution_id), 0), 2)
      comment: "Percentage of attributed patients in the high-risk tier — strategic KPI for value-based care program design; high rates indicate need for intensive care management investment."
    - name: "care_management_penetration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN care_management_enrolled = TRUE THEN pcp_attribution_id END) / NULLIF(COUNT(pcp_attribution_id), 0), 2)
      comment: "Percentage of attributed patients enrolled in care management — measures care management program reach; low penetration in high-risk tiers indicates missed intervention opportunities and value-based care performance risk."
    - name: "sdoh_risk_patient_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sdoh_flag = TRUE THEN pcp_attribution_id END) / NULLIF(COUNT(pcp_attribution_id), 0), 2)
      comment: "Percentage of attributed patients with documented SDOH risk — measures social risk burden within the attributed panel; informs community health worker and social care program investment."
    - name: "hedis_eligible_patient_count"
      expr: COUNT(CASE WHEN hedis_eligible = TRUE THEN pcp_attribution_id END)
      comment: "Number of attributed patients eligible for HEDIS quality measure reporting — defines the quality measure denominator population; directly tied to health plan star ratings and quality bonus payments."
    - name: "consent_on_file_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_on_file = TRUE THEN pcp_attribution_id END) / NULLIF(COUNT(pcp_attribution_id), 0), 2)
      comment: "Percentage of attributed patients with consent on file — compliance KPI for data sharing and care coordination programs; low rates indicate consent capture process gaps."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`patient_registration_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient registration quality, throughput, and compliance metrics. Tracks registration completeness, eligibility verification rates, consent capture, and identity matching quality — critical for revenue cycle, compliance, and patient access operations."
  source: "`healthcare_ecm`.`patient`.`registration_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of registration event (e.g., admit, discharge, transfer, outpatient registration) — primary segmentation axis for registration workflow analysis."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the registration event — used to filter complete vs. incomplete registrations."
    - name: "admission_type"
      expr: admission_type
      comment: "Type of admission (e.g., elective, emergency, urgent) — enables acuity-based registration volume analysis."
    - name: "patient_class"
      expr: patient_class
      comment: "Patient class at registration (e.g., inpatient, outpatient, observation) — primary care setting dimension for registration volume and quality analysis."
    - name: "financial_class"
      expr: financial_class
      comment: "Financial class of the patient at registration (e.g., Medicare, Medicaid, commercial, self-pay) — critical payer mix dimension for revenue cycle and financial planning."
    - name: "registration_source"
      expr: registration_source
      comment: "Source channel of the registration (e.g., ED, scheduled, transfer) — used to analyze registration intake channel mix and efficiency."
    - name: "discharge_disposition"
      expr: discharge_disposition
      comment: "Discharge disposition code — used to analyze post-acute care transitions and readmission risk."
    - name: "mpi_match_status"
      expr: mpi_match_status
      comment: "Status of the MPI matching result at registration — used to assess identity resolution quality at point of registration."
    - name: "registration_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Month of registration — enables monthly registration volume trending and seasonal pattern analysis."
    - name: "registration_year"
      expr: DATE_TRUNC('YEAR', registration_date)
      comment: "Year of registration — enables year-over-year registration volume and quality trend analysis."
    - name: "source_system"
      expr: source_system
      comment: "Source system that originated the registration event — used for data lineage and system-level quality monitoring."
    - name: "vip_flag"
      expr: vip_flag
      comment: "VIP patient flag at registration — used for service-level compliance and privacy governance monitoring."
  measures:
    - name: "total_registration_events"
      expr: COUNT(registration_event_id)
      comment: "Total number of registration events — baseline patient access volume KPI for capacity planning and throughput analysis."
    - name: "eligibility_verified_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN eligibility_verified_flag = TRUE THEN registration_event_id END) / NULLIF(COUNT(registration_event_id), 0), 2)
      comment: "Percentage of registrations with verified eligibility — primary revenue cycle quality KPI; low rates predict increased claim denials and bad debt; directly actionable by patient access leadership."
    - name: "consent_obtained_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_obtained_flag = TRUE THEN registration_event_id END) / NULLIF(COUNT(registration_event_id), 0), 2)
      comment: "Percentage of registrations with documented consent obtained — HIPAA compliance KPI; registrations without consent represent regulatory risk and potential OCR audit findings."
    - name: "hipaa_notice_delivery_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hipaa_notice_delivered_flag = TRUE THEN registration_event_id END) / NULLIF(COUNT(registration_event_id), 0), 2)
      comment: "Percentage of registrations where HIPAA Notice of Privacy Practices was delivered — direct compliance KPI; failure to deliver is a HIPAA violation; tracked by privacy officers and compliance teams."
    - name: "duplicate_registration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN duplicate_flag = TRUE THEN registration_event_id END) / NULLIF(COUNT(registration_event_id), 0), 2)
      comment: "Percentage of registration events flagged as duplicates — data quality KPI for patient access; high rates indicate registration workflow failures and MPI integrity risk."
    - name: "avg_registration_completeness_score"
      expr: ROUND(AVG(CAST(completeness_score AS DOUBLE)), 4)
      comment: "Average registration data completeness score — measures overall registration data quality; low scores predict downstream revenue cycle failures including claim rejections and denials."
    - name: "avg_mpi_match_score"
      expr: ROUND(AVG(CAST(mpi_match_score AS DOUBLE)), 4)
      comment: "Average MPI match confidence score at registration — measures identity resolution quality at point of care; low scores indicate patient safety risk from potential record mismatches."
    - name: "avg_expected_los_days"
      expr: ROUND(AVG(CAST(expected_los_days AS DOUBLE)), 2)
      comment: "Average expected length of stay at registration — used by care management and utilization review to benchmark against actual LOS for efficiency and capacity planning."
    - name: "interpreter_required_registration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN interpreter_required_flag = TRUE THEN registration_event_id END) / NULLIF(COUNT(registration_event_id), 0), 2)
      comment: "Percentage of registrations requiring interpreter services — informs language access staffing and compliance with Title VI language access mandates."
    - name: "restricted_record_count"
      expr: COUNT(CASE WHEN restricted_record_flag = TRUE THEN registration_event_id END)
      comment: "Number of registration events with restricted record flags — privacy and compliance KPI; monitors sensitive record volume and access governance requirements."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`patient_portal_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient portal digital engagement and account health metrics. Tracks activation rates, login activity, feature adoption, and proxy access — strategic KPIs for digital health transformation, patient engagement, and consumer experience programs."
  source: "`healthcare_ecm`.`patient`.`portal_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the portal account (e.g., active, inactive, deactivated) — primary segmentation axis for portal engagement analysis."
    - name: "account_type"
      expr: account_type
      comment: "Type of portal account (e.g., patient, proxy, caregiver) — used to segment portal usage by account holder type."
    - name: "portal_platform"
      expr: portal_platform
      comment: "Portal platform or vendor (e.g., MyChart, FollowMyHealth) — enables platform-level engagement benchmarking."
    - name: "activation_method"
      expr: activation_method
      comment: "Method used to activate the portal account (e.g., in-person, email, SMS) — used to evaluate activation channel effectiveness and optimize enrollment workflows."
    - name: "notification_preference"
      expr: notification_preference
      comment: "Patient's preferred notification channel (e.g., email, SMS, push) — used to optimize outreach channel mix for engagement campaigns."
    - name: "identity_verification_method"
      expr: identity_verification_method
      comment: "Method used to verify patient identity during portal enrollment — used to assess identity proofing rigor and compliance with ONC patient access rules."
    - name: "activation_year"
      expr: DATE_TRUNC('YEAR', activation_date)
      comment: "Year of portal account activation — enables year-over-year portal adoption trend analysis."
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', activation_date)
      comment: "Month of portal account activation — supports monthly activation volume trending and campaign effectiveness measurement."
    - name: "two_factor_auth_enrolled"
      expr: two_factor_auth_enrolled
      comment: "Whether the account has two-factor authentication enrolled — security compliance dimension for portal account governance."
    - name: "proxy_access_flag"
      expr: proxy_access_flag
      comment: "Whether the account has proxy access enabled — used to segment caregiver-enabled accounts for proxy access program analysis."
  measures:
    - name: "total_portal_accounts"
      expr: COUNT(portal_account_id)
      comment: "Total number of portal accounts — baseline digital engagement KPI for patient portal program scale."
    - name: "active_portal_account_count"
      expr: COUNT(CASE WHEN account_status = 'active' THEN portal_account_id END)
      comment: "Number of active portal accounts — primary digital health KPI; directly tied to patient engagement scores, CAHPS results, and Meaningful Use/Promoting Interoperability compliance."
    - name: "portal_activation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN activation_date IS NOT NULL THEN portal_account_id END) / NULLIF(COUNT(portal_account_id), 0), 2)
      comment: "Percentage of portal accounts that have been activated — strategic digital health KPI; low rates indicate enrollment workflow friction; directly impacts patient satisfaction and ONC compliance metrics."
    - name: "identity_verified_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN identity_verified_flag = TRUE THEN portal_account_id END) / NULLIF(COUNT(portal_account_id), 0), 2)
      comment: "Percentage of portal accounts with verified patient identity — security and compliance KPI; unverified accounts represent PHI access risk and ONC patient access rule compliance gaps."
    - name: "two_factor_auth_adoption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN two_factor_auth_enrolled = TRUE THEN portal_account_id END) / NULLIF(COUNT(portal_account_id), 0), 2)
      comment: "Percentage of portal accounts with two-factor authentication enrolled — cybersecurity KPI; low rates indicate PHI breach risk; tracked by CISO and compliance teams."
    - name: "messaging_opt_in_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN messaging_opt_in = TRUE THEN portal_account_id END) / NULLIF(COUNT(portal_account_id), 0), 2)
      comment: "Percentage of portal accounts opted into secure messaging — measures patient communication channel adoption; directly tied to care coordination efficiency and patient satisfaction."
    - name: "digital_health_app_linked_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN digital_health_app_linked = TRUE THEN portal_account_id END) / NULLIF(COUNT(portal_account_id), 0), 2)
      comment: "Percentage of portal accounts with a linked digital health app — measures health app ecosystem adoption; strategic KPI for digital health transformation and remote patient monitoring program reach."
    - name: "proxy_access_enabled_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN proxy_access_flag = TRUE THEN portal_account_id END) / NULLIF(COUNT(portal_account_id), 0), 2)
      comment: "Percentage of portal accounts with proxy access enabled — measures caregiver engagement; important for pediatric, geriatric, and complex care populations where caregiver involvement drives outcomes."
    - name: "accounts_logged_in_last_90_days"
      expr: COUNT(CASE WHEN last_login_date >= DATE_ADD(CURRENT_DATE(), -90) THEN portal_account_id END)
      comment: "Number of portal accounts with a login in the last 90 days — measures active portal utilization; the most direct indicator of sustained patient engagement with the digital health platform."
    - name: "terms_acceptance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN terms_accepted_flag = TRUE THEN portal_account_id END) / NULLIF(COUNT(portal_account_id), 0), 2)
      comment: "Percentage of portal accounts with accepted terms of service — compliance KPI; accounts without accepted terms may represent legal and regulatory risk for the health system."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`patient_consent_reference`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient consent governance and compliance metrics. Tracks consent capture rates, HIE participation, research consent, marketing opt-in, and consent lifecycle management — critical for HIPAA compliance, research program governance, and patient privacy operations."
  source: "`healthcare_ecm`.`patient`.`consent_reference`"
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent captured (e.g., treatment, research, marketing, HIE) — primary segmentation axis for consent program analysis."
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent record (e.g., active, revoked, expired) — used to filter valid vs. invalid consent records."
    - name: "consent_scope"
      expr: consent_scope
      comment: "Scope of the consent (e.g., facility-wide, system-wide, specific program) — used to assess consent coverage breadth."
    - name: "consent_method"
      expr: consent_method
      comment: "Method by which consent was obtained (e.g., written, verbal, electronic) — used to assess consent capture channel mix and legal defensibility."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the consent record — used to identify unverified consent records that may represent compliance risk."
    - name: "language_of_consent"
      expr: language_of_consent
      comment: "Language in which consent was obtained — supports language access compliance and health equity reporting."
    - name: "consent_obtained_year"
      expr: DATE_TRUNC('YEAR', consent_obtained_date)
      comment: "Year consent was obtained — enables year-over-year consent capture trend analysis."
    - name: "legal_guardian_flag"
      expr: legal_guardian_flag
      comment: "Whether consent was obtained from a legal guardian — used to segment pediatric and incapacitated patient consent records."
    - name: "interpreter_used_flag"
      expr: interpreter_used_flag
      comment: "Whether an interpreter was used during consent — language access compliance dimension."
  measures:
    - name: "total_consent_records"
      expr: COUNT(consent_reference_id)
      comment: "Total number of consent records — baseline consent program volume KPI."
    - name: "active_consent_count"
      expr: COUNT(CASE WHEN consent_status = 'active' THEN consent_reference_id END)
      comment: "Number of currently active consent records — measures valid consent coverage across the patient population; directly tied to HIPAA compliance and program eligibility."
    - name: "consent_revocation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_revocation_date IS NOT NULL THEN consent_reference_id END) / NULLIF(COUNT(consent_reference_id), 0), 2)
      comment: "Percentage of consent records that have been revoked — measures patient trust and consent stability; high revocation rates in specific programs signal patient experience or communication issues."
    - name: "hie_participation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hie_participation_flag = TRUE THEN consent_reference_id END) / NULLIF(COUNT(consent_reference_id), 0), 2)
      comment: "Percentage of consent records with HIE participation authorized — measures health information exchange opt-in rate; directly impacts care coordination quality and interoperability program performance."
    - name: "research_participation_consent_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN research_participation_flag = TRUE THEN consent_reference_id END) / NULLIF(COUNT(consent_reference_id), 0), 2)
      comment: "Percentage of consent records authorizing research participation — measures research consent program reach; directly tied to clinical trial enrollment capacity and research revenue."
    - name: "phi_disclosure_authorized_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN phi_disclosure_authorized_flag = TRUE THEN consent_reference_id END) / NULLIF(COUNT(consent_reference_id), 0), 2)
      comment: "Percentage of consent records authorizing PHI disclosure — measures PHI sharing authorization coverage; critical for care coordination, referrals, and payer communications compliance."
    - name: "marketing_opt_in_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN marketing_opt_in_flag = TRUE THEN consent_reference_id END) / NULLIF(COUNT(consent_reference_id), 0), 2)
      comment: "Percentage of consent records with marketing opt-in — measures patient marketing consent coverage; directly determines the addressable audience for patient outreach and health education campaigns."
    - name: "interpreter_used_in_consent_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN interpreter_used_flag = TRUE THEN consent_reference_id END) / NULLIF(COUNT(consent_reference_id), 0), 2)
      comment: "Percentage of consent records where an interpreter was used — language access compliance KPI; low rates relative to interpreter_required population indicate consent process gaps for LEP patients."
$$;