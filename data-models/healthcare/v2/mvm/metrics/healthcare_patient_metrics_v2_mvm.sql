-- Metric views for domain: patient | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 16:05:56

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_mpi_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Master Patient Index (MPI) quality and population health metrics. Tracks patient identity integrity, duplicate/overlay risk, deceased population, and digital engagement across the enterprise patient registry."
  source: "`vibe_healthcare_v1`.`patient`.`mpi_record`"
  dimensions:
    - name: "mpi_record_status"
      expr: mpi_record_status
      comment: "Current status of the MPI record (e.g., active, merged, inactive). Used to segment active vs. resolved patient identities."
    - name: "identity_resolution_status"
      expr: identity_resolution_status
      comment: "Status of the identity resolution process (e.g., resolved, pending, flagged). Indicates data quality posture of the patient record."
    - name: "identity_confidence_tier"
      expr: identity_confidence_tier
      comment: "Tiered confidence level assigned by the identity matching algorithm. Drives downstream data trust and clinical safety decisions."
    - name: "patient_class"
      expr: patient_class
      comment: "Classification of the patient (e.g., inpatient, outpatient, emergency). Enables population segmentation for utilization analysis."
    - name: "sex_at_birth"
      expr: sex_at_birth
      comment: "Biological sex recorded at birth. Used for clinical and epidemiological population stratification."
    - name: "race_code"
      expr: race_code
      comment: "Standardized race code for the patient. Supports health equity and disparity reporting."
    - name: "ethnicity_code"
      expr: ethnicity_code
      comment: "Standardized ethnicity code. Supports health equity and disparity reporting."
    - name: "primary_language_code"
      expr: primary_language_code
      comment: "Patient's primary spoken language. Drives interpreter service demand planning and communication equity."
    - name: "deceased_flag"
      expr: deceased_flag
      comment: "Boolean indicating whether the patient is deceased. Critical for excluding deceased patients from active care programs."
    - name: "digital_health_opt_in"
      expr: digital_health_opt_in
      comment: "Whether the patient has opted into digital health services. Tracks digital engagement adoption."
    - name: "restricted_access_flag"
      expr: restricted_access_flag
      comment: "Indicates whether the patient record has restricted access (e.g., VIP, sensitive). Supports compliance and privacy governance."
    - name: "vip_flag"
      expr: vip_flag
      comment: "Indicates VIP patient status. Used for service-level differentiation and privacy controls."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source system that originated the MPI record. Enables data lineage and source quality analysis."
  measures:
    - name: "total_active_patients"
      expr: COUNT(CASE WHEN mpi_record_status = 'active' THEN mpi_record_id END)
      comment: "Total count of active MPI records. Represents the live enterprise patient population size — a foundational KPI for capacity planning and population health management."
    - name: "duplicate_patient_record_count"
      expr: COUNT(CASE WHEN is_duplicate_flag = TRUE THEN mpi_record_id END)
      comment: "Number of MPI records flagged as duplicates. High duplicate rates signal identity resolution failures that create patient safety risks and inflate population counts."
    - name: "duplicate_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_duplicate_flag = TRUE THEN mpi_record_id END) / NULLIF(COUNT(mpi_record_id), 0), 2)
      comment: "Percentage of MPI records flagged as duplicates. A key data quality KPI — industry benchmark is below 2%. Elevated rates trigger identity governance remediation."
    - name: "overlay_risk_patient_count"
      expr: COUNT(CASE WHEN is_overlay_flag = TRUE THEN mpi_record_id END)
      comment: "Number of MPI records flagged as overlay risk (wrong patient data merged). Overlays are a critical patient safety event tracked by health system leadership."
    - name: "deceased_patient_count"
      expr: COUNT(CASE WHEN deceased_flag = TRUE THEN mpi_record_id END)
      comment: "Total count of deceased patients in the MPI. Used to maintain accurate active population denominators and to trigger care program disenrollment workflows."
    - name: "interpreter_required_patient_count"
      expr: COUNT(CASE WHEN interpreter_required_flag = TRUE THEN mpi_record_id END)
      comment: "Number of patients requiring interpreter services. Drives interpreter resource allocation and health equity program planning."
    - name: "digital_health_opt_in_count"
      expr: COUNT(CASE WHEN digital_health_opt_in = TRUE THEN mpi_record_id END)
      comment: "Number of patients opted into digital health services. Tracks digital engagement adoption — a strategic KPI for telehealth and patient portal investment decisions."
    - name: "avg_match_confidence_score"
      expr: ROUND(AVG(CAST(match_confidence_score AS DOUBLE)), 4)
      comment: "Average identity match confidence score across all MPI records. A low average signals systemic identity resolution quality issues requiring algorithm tuning or data remediation."
    - name: "low_confidence_match_count"
      expr: COUNT(CASE WHEN match_confidence_score < 0.80 THEN mpi_record_id END)
      comment: "Number of MPI records with match confidence score below 80%. These records carry elevated patient safety risk and require manual review or algorithm improvement."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_demographics`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient demographic completeness, social determinants of health (SDOH), and digital engagement metrics. Supports population health management, health equity reporting, and patient outreach program effectiveness."
  source: "`vibe_healthcare_v1`.`patient`.`demographics`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current registration status of the patient demographic record. Segments active vs. inactive patient populations."
    - name: "sex_at_birth"
      expr: sex_at_birth
      comment: "Biological sex recorded at birth. Used for clinical population stratification and equity reporting."
    - name: "race_code"
      expr: race_code
      comment: "Standardized race code. Supports health equity and disparity analysis."
    - name: "ethnicity_code"
      expr: ethnicity_code
      comment: "Standardized ethnicity code. Supports health equity and disparity analysis."
    - name: "preferred_language_code"
      expr: preferred_language_code
      comment: "Patient's preferred language. Drives interpreter demand and multilingual communication planning."
    - name: "marital_status"
      expr: marital_status
      comment: "Patient marital status. Used in social risk stratification and care coordination models."
    - name: "home_state"
      expr: home_state
      comment: "State of the patient's home address. Enables geographic population analysis and regional health program targeting."
    - name: "deceased_indicator"
      expr: deceased_indicator
      comment: "Boolean flag indicating patient is deceased. Used to exclude deceased patients from active population metrics."
    - name: "sdoh_housing_status"
      expr: sdoh_housing_status
      comment: "Social determinant of health — housing status. Identifies patients at risk for housing instability, a key driver of avoidable utilization."
    - name: "gender_identity"
      expr: gender_identity
      comment: "Patient's self-reported gender identity. Supports inclusive care and LGBTQ+ health equity reporting."
  measures:
    - name: "total_patient_demographics"
      expr: COUNT(demographics_id)
      comment: "Total count of patient demographic records. Baseline population denominator for all demographic-based KPIs."
    - name: "sdoh_food_insecurity_count"
      expr: COUNT(CASE WHEN sdoh_food_insecurity = TRUE THEN demographics_id END)
      comment: "Number of patients flagged for food insecurity. A critical SDOH KPI that drives community health worker deployment and food assistance program enrollment."
    - name: "sdoh_food_insecurity_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sdoh_food_insecurity = TRUE THEN demographics_id END) / NULLIF(COUNT(demographics_id), 0), 2)
      comment: "Percentage of patients with food insecurity. Benchmarked against community prevalence rates to assess program reach and unmet need."
    - name: "interpreter_required_count"
      expr: COUNT(CASE WHEN interpreter_required = TRUE THEN demographics_id END)
      comment: "Number of patients requiring interpreter services. Drives interpreter staffing and language access compliance reporting."
    - name: "patient_portal_enrolled_count"
      expr: COUNT(CASE WHEN patient_portal_enrolled = TRUE THEN demographics_id END)
      comment: "Number of patients enrolled in the patient portal. A strategic digital engagement KPI tied to patient activation, satisfaction, and care plan adherence."
    - name: "patient_portal_enrollment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN patient_portal_enrolled = TRUE THEN demographics_id END) / NULLIF(COUNT(demographics_id), 0), 2)
      comment: "Percentage of patients enrolled in the patient portal. Tracks digital health adoption — a key metric for health system digital transformation strategy."
    - name: "advance_directive_on_file_count"
      expr: COUNT(CASE WHEN advance_directive_on_file = TRUE THEN demographics_id END)
      comment: "Number of patients with an advance directive on file. Tracks compliance with care planning best practices and regulatory requirements for end-of-life care documentation."
    - name: "rpm_opt_in_count"
      expr: COUNT(CASE WHEN rpm_opt_in_flag = TRUE THEN demographics_id END)
      comment: "Number of patients opted into Remote Patient Monitoring (RPM). Tracks RPM program enrollment — a key metric for chronic disease management and value-based care performance."
    - name: "digital_health_opt_in_count"
      expr: COUNT(CASE WHEN digital_health_opt_in = TRUE THEN demographics_id END)
      comment: "Number of patients opted into digital health services. Tracks digital engagement adoption across the patient population."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_insurance_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient insurance coverage financial metrics including deductible utilization, out-of-pocket exposure, and eligibility verification quality. Supports revenue cycle management, financial counseling, and payer contract performance analysis."
  source: "`vibe_healthcare_v1`.`patient`.`insurance_coverage`"
  dimensions:
    - name: "coverage_status"
      expr: coverage_status
      comment: "Current status of the insurance coverage (e.g., active, terminated, pending). Primary segmentation dimension for coverage analysis."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of insurance plan (e.g., HMO, PPO, EPO, Medicare, Medicaid). Drives payer mix analysis and contract strategy."
    - name: "plan_name"
      expr: plan_name
      comment: "Name of the insurance plan. Enables plan-level financial performance benchmarking."
    - name: "network_status"
      expr: network_status
      comment: "In-network vs. out-of-network status. Directly impacts reimbursement rates and patient financial liability."
    - name: "cob_priority"
      expr: cob_priority
      comment: "Coordination of Benefits priority (primary, secondary, tertiary). Used to sequence claim submission and calculate patient liability."
    - name: "eligibility_verification_status"
      expr: eligibility_verification_status
      comment: "Status of the eligibility verification (e.g., verified, pending, failed). Tracks revenue cycle front-end quality."
    - name: "subscriber_relationship"
      expr: subscriber_relationship
      comment: "Relationship of the patient to the insurance subscriber (e.g., self, spouse, dependent). Used for coverage and billing analysis."
    - name: "medicare_part"
      expr: medicare_part
      comment: "Medicare part designation (A, B, C, D). Enables Medicare-specific utilization and reimbursement analysis."
    - name: "medicaid_state_code"
      expr: medicaid_state_code
      comment: "State code for Medicaid coverage. Supports state-level Medicaid program performance and compliance reporting."
    - name: "prior_auth_required"
      expr: prior_auth_required
      comment: "Whether prior authorization is required for services under this coverage. Drives prior auth workflow volume forecasting."
  measures:
    - name: "total_active_coverages"
      expr: COUNT(CASE WHEN coverage_status = 'active' THEN insurance_coverage_id END)
      comment: "Total count of active insurance coverages. Baseline denominator for payer mix and coverage analysis."
    - name: "avg_deductible_amount"
      expr: ROUND(AVG(CAST(deductible_amount AS DOUBLE)), 2)
      comment: "Average deductible amount across active coverages. Tracks patient financial exposure and informs financial counseling program design."
    - name: "avg_deductible_met_amount"
      expr: ROUND(AVG(CAST(deductible_met_amount AS DOUBLE)), 2)
      comment: "Average deductible amount met by patients. Combined with avg_deductible_amount, reveals how much patient financial liability remains — critical for collections forecasting."
    - name: "total_deductible_remaining"
      expr: ROUND(SUM(CAST(deductible_amount AS DOUBLE) - CAST(deductible_met_amount AS DOUBLE)), 2)
      comment: "Total remaining deductible liability across all coverages. Represents the aggregate patient financial exposure that drives collections strategy and financial assistance program sizing."
    - name: "avg_out_of_pocket_max"
      expr: ROUND(AVG(CAST(out_of_pocket_max AS DOUBLE)), 2)
      comment: "Average out-of-pocket maximum across coverages. Benchmarks patient financial risk exposure by plan type and payer."
    - name: "total_out_of_pocket_remaining"
      expr: ROUND(SUM(CAST(out_of_pocket_max AS DOUBLE) - CAST(out_of_pocket_met_amount AS DOUBLE)), 2)
      comment: "Total remaining out-of-pocket liability across all coverages. A key revenue cycle KPI for estimating collectible patient balances before service delivery."
    - name: "avg_coinsurance_rate"
      expr: ROUND(AVG(CAST(coinsurance_rate AS DOUBLE)), 4)
      comment: "Average coinsurance rate across coverages. Informs patient cost-sharing burden analysis and financial counseling targeting."
    - name: "avg_copay_amount"
      expr: ROUND(AVG(CAST(copay_amount AS DOUBLE)), 2)
      comment: "Average copay amount across coverages. Tracks patient point-of-service financial liability — used in access and affordability analysis."
    - name: "eligibility_verified_count"
      expr: COUNT(CASE WHEN eligibility_verification_status = 'verified' THEN insurance_coverage_id END)
      comment: "Number of coverages with confirmed eligibility verification. A revenue cycle quality KPI — unverified eligibility is a leading cause of claim denials."
    - name: "eligibility_verification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN eligibility_verification_status = 'verified' THEN insurance_coverage_id END) / NULLIF(COUNT(insurance_coverage_id), 0), 2)
      comment: "Percentage of coverages with verified eligibility. Industry benchmark is 95%+. Below-benchmark rates directly increase claim denial rates and revenue leakage."
    - name: "prior_auth_required_coverage_count"
      expr: COUNT(CASE WHEN prior_auth_required = TRUE THEN insurance_coverage_id END)
      comment: "Number of coverages requiring prior authorization. Drives prior auth staffing demand and workflow automation investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_eligibility_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time insurance eligibility verification performance metrics. Tracks verification success rates, financial liability exposure, and prior authorization demand. A critical revenue cycle front-end quality domain."
  source: "`vibe_healthcare_v1`.`patient`.`eligibility_check`"
  dimensions:
    - name: "verification_status"
      expr: verification_status
      comment: "Outcome status of the eligibility check (e.g., verified, failed, pending). Primary dimension for eligibility quality analysis."
    - name: "verification_type"
      expr: verification_type
      comment: "Type of eligibility verification performed (e.g., real-time, batch, manual). Tracks automation vs. manual verification mix."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used for eligibility verification (e.g., EDI 270/271, portal, phone). Drives process efficiency and cost-per-verification analysis."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage being verified (e.g., medical, dental, vision, pharmacy). Enables coverage-type-specific denial and verification analysis."
    - name: "network_status"
      expr: network_status
      comment: "In-network vs. out-of-network determination from the eligibility check. Impacts reimbursement and patient liability calculations."
    - name: "prior_auth_required"
      expr: prior_auth_required
      comment: "Whether prior authorization is required per the eligibility response. Drives prior auth workflow volume."
    - name: "referral_required"
      expr: referral_required
      comment: "Whether a referral is required per the eligibility response. Impacts care coordination and access workflows."
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Standardized rejection reason code from the payer. Used to identify systemic eligibility failure patterns and drive root cause remediation."
    - name: "clearinghouse_name"
      expr: clearinghouse_name
      comment: "Name of the clearinghouse used for eligibility transactions. Enables clearinghouse performance benchmarking."
    - name: "is_override"
      expr: is_override
      comment: "Whether the eligibility check result was manually overridden. High override rates signal systemic eligibility process failures."
  measures:
    - name: "total_eligibility_checks"
      expr: COUNT(eligibility_check_id)
      comment: "Total number of eligibility checks performed. Baseline volume KPI for revenue cycle front-end throughput measurement."
    - name: "eligibility_verified_count"
      expr: COUNT(CASE WHEN verification_status = 'verified' THEN eligibility_check_id END)
      comment: "Number of eligibility checks that returned a verified result. Numerator for eligibility verification rate — a leading indicator of claim denial risk."
    - name: "eligibility_verification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'verified' THEN eligibility_check_id END) / NULLIF(COUNT(eligibility_check_id), 0), 2)
      comment: "Percentage of eligibility checks resulting in verified status. Industry benchmark is 95%+. Below-benchmark rates are a leading indicator of downstream claim denials."
    - name: "eligibility_rejection_count"
      expr: COUNT(CASE WHEN verification_status = 'rejected' THEN eligibility_check_id END)
      comment: "Number of eligibility checks rejected by the payer. Drives denial prevention and root cause analysis workflows."
    - name: "override_count"
      expr: COUNT(CASE WHEN is_override = TRUE THEN eligibility_check_id END)
      comment: "Number of eligibility checks with manual overrides. High override rates indicate systemic eligibility process failures requiring automation or payer contract remediation."
    - name: "override_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_override = TRUE THEN eligibility_check_id END) / NULLIF(COUNT(eligibility_check_id), 0), 2)
      comment: "Percentage of eligibility checks that were manually overridden. A quality KPI — high rates signal process breakdowns and increase compliance risk."
    - name: "prior_auth_required_count"
      expr: COUNT(CASE WHEN prior_auth_required = TRUE THEN eligibility_check_id END)
      comment: "Number of eligibility checks indicating prior authorization is required. Drives prior auth staffing demand forecasting and automation investment decisions."
    - name: "avg_individual_deductible_amount"
      expr: ROUND(AVG(CAST(individual_deductible_amount AS DOUBLE)), 2)
      comment: "Average individual deductible amount from eligibility responses. Tracks patient financial exposure trends across the verified population."
    - name: "avg_individual_deductible_met_amount"
      expr: ROUND(AVG(CAST(individual_deductible_met_amount AS DOUBLE)), 2)
      comment: "Average individual deductible amount already met. Combined with avg_individual_deductible_amount, reveals remaining patient liability — critical for point-of-service collections strategy."
    - name: "avg_copay_amount"
      expr: ROUND(AVG(CAST(copay_amount AS DOUBLE)), 2)
      comment: "Average copay amount from eligibility responses. Tracks patient point-of-service cost-sharing burden across payer and plan segments."
    - name: "avg_out_of_pocket_max"
      expr: ROUND(AVG(CAST(individual_out_of_pocket_max AS DOUBLE)), 2)
      comment: "Average individual out-of-pocket maximum from eligibility responses. Benchmarks patient financial risk exposure by payer and coverage type."
    - name: "avg_out_of_pocket_met"
      expr: ROUND(AVG(CAST(individual_out_of_pocket_met AS DOUBLE)), 2)
      comment: "Average individual out-of-pocket amount already met. Used with avg_out_of_pocket_max to estimate remaining collectible patient balance."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_pcp_attribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Primary Care Provider (PCP) attribution metrics for value-based care performance. Tracks panel size, attribution quality, risk stratification, care management enrollment, and HEDIS/MIPS eligibility. A core domain for ACO, VBC, and population health program management."
  source: "`vibe_healthcare_v1`.`patient`.`pcp_attribution`"
  dimensions:
    - name: "attribution_status"
      expr: attribution_status
      comment: "Current status of the PCP attribution (e.g., active, disenrolled, pending). Primary segmentation for active panel analysis."
    - name: "attribution_method"
      expr: attribution_method
      comment: "Method used to attribute the patient to the PCP (e.g., claims-based, voluntary, algorithmic). Tracks attribution methodology mix and quality."
    - name: "attribution_source"
      expr: attribution_source
      comment: "Source of the attribution (e.g., payer, health system, patient choice). Enables attribution source quality and completeness analysis."
    - name: "risk_stratification_tier"
      expr: risk_stratification_tier
      comment: "Patient risk tier (e.g., low, medium, high, rising). Drives care management resource allocation and intervention prioritization."
    - name: "plan_type"
      expr: plan_type
      comment: "Insurance plan type associated with the attribution. Enables payer-specific VBC performance analysis."
    - name: "payer_name"
      expr: payer_name
      comment: "Name of the payer associated with the attribution. Supports payer-level VBC contract performance reporting."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the attributed patient. Enables regional panel distribution and access equity analysis."
    - name: "attribution_segment"
      expr: attribution_segment
      comment: "Business segment of the attribution (e.g., commercial, Medicare Advantage, Medicaid). Drives segment-specific VBC performance reporting."
    - name: "measurement_year"
      expr: measurement_year
      comment: "Measurement year for the attribution record. Enables year-over-year VBC performance trending."
    - name: "is_primary_attribution"
      expr: is_primary_attribution
      comment: "Whether this is the patient's primary PCP attribution. Used to deduplicate panel counts to primary relationships."
    - name: "hedis_eligible"
      expr: hedis_eligible
      comment: "Whether the patient is eligible for HEDIS quality measure reporting. Drives HEDIS denominator population identification."
    - name: "mips_eligible"
      expr: mips_eligible
      comment: "Whether the patient is eligible for MIPS quality reporting. Drives MIPS performance program population management."
    - name: "sdoh_flag"
      expr: sdoh_flag
      comment: "Whether the patient has identified social determinants of health risk factors. Drives SDOH-targeted care management program enrollment."
  measures:
    - name: "total_attributed_patients"
      expr: COUNT(CASE WHEN attribution_status = 'active' THEN pcp_attribution_id END)
      comment: "Total number of actively attributed patients. The foundational panel size KPI for VBC program management and PCP capacity planning."
    - name: "high_risk_attributed_patient_count"
      expr: COUNT(CASE WHEN risk_stratification_tier = 'high' AND attribution_status = 'active' THEN pcp_attribution_id END)
      comment: "Number of actively attributed high-risk patients. Drives care management staffing, intervention program sizing, and VBC cost of care forecasting."
    - name: "high_risk_patient_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_stratification_tier = 'high' AND attribution_status = 'active' THEN pcp_attribution_id END) / NULLIF(COUNT(CASE WHEN attribution_status = 'active' THEN pcp_attribution_id END), 0), 2)
      comment: "Percentage of actively attributed patients classified as high risk. A key VBC performance indicator — high rates signal elevated cost of care and intervention opportunity."
    - name: "care_management_enrolled_count"
      expr: COUNT(CASE WHEN care_management_enrolled = TRUE THEN pcp_attribution_id END)
      comment: "Number of attributed patients enrolled in care management programs. Tracks care management program reach — a key VBC quality and cost reduction lever."
    - name: "care_management_enrollment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN care_management_enrolled = TRUE THEN pcp_attribution_id END) / NULLIF(COUNT(CASE WHEN attribution_status = 'active' THEN pcp_attribution_id END), 0), 2)
      comment: "Percentage of active attributed patients enrolled in care management. Benchmarked against program targets — low rates indicate unmet high-risk patient needs."
    - name: "avg_hcc_risk_score"
      expr: ROUND(AVG(CAST(hcc_risk_score AS DOUBLE)), 4)
      comment: "Average HCC (Hierarchical Condition Category) risk score across attributed patients. The primary actuarial KPI for VBC contract performance — directly tied to capitation payment rates."
    - name: "avg_attribution_confidence_score"
      expr: ROUND(AVG(CAST(attribution_confidence_score AS DOUBLE)), 4)
      comment: "Average attribution confidence score. Low scores indicate attribution quality issues that can lead to incorrect panel assignments and VBC performance misattribution."
    - name: "sdoh_flagged_patient_count"
      expr: COUNT(CASE WHEN sdoh_flag = TRUE THEN pcp_attribution_id END)
      comment: "Number of attributed patients with SDOH risk flags. Drives SDOH-targeted intervention program sizing and community health worker deployment."
    - name: "hedis_eligible_patient_count"
      expr: COUNT(CASE WHEN hedis_eligible = TRUE THEN pcp_attribution_id END)
      comment: "Number of attributed patients eligible for HEDIS quality measures. Defines the HEDIS reporting denominator — critical for quality score calculation and payer contract performance."
    - name: "consent_on_file_count"
      expr: COUNT(CASE WHEN consent_on_file = TRUE THEN pcp_attribution_id END)
      comment: "Number of attributed patients with consent on file for data sharing. Tracks consent compliance — required for HIE participation and care coordination data exchange."
    - name: "consent_on_file_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_on_file = TRUE THEN pcp_attribution_id END) / NULLIF(COUNT(CASE WHEN attribution_status = 'active' THEN pcp_attribution_id END), 0), 2)
      comment: "Percentage of active attributed patients with consent on file. A compliance KPI — low rates create barriers to care coordination and HIE data sharing."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_registration_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient registration process quality and throughput metrics. Tracks registration completeness, eligibility verification at point of registration, consent capture, and identity matching quality. A critical revenue cycle and patient access domain."
  source: "`vibe_healthcare_v1`.`patient`.`registration_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of registration event (e.g., admit, discharge, transfer, pre-registration). Segments registration volume by event category."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the registration event (e.g., complete, pending, cancelled). Tracks registration workflow completion."
    - name: "patient_class"
      expr: patient_class
      comment: "Patient class at registration (e.g., inpatient, outpatient, emergency). Drives capacity planning and resource allocation."
    - name: "admission_type"
      expr: admission_type
      comment: "Type of admission (e.g., elective, emergency, urgent). Supports utilization management and capacity planning."
    - name: "financial_class"
      expr: financial_class
      comment: "Financial class of the patient at registration (e.g., commercial, Medicare, Medicaid, self-pay). Primary payer mix dimension for revenue cycle analysis."
    - name: "registration_source"
      expr: registration_source
      comment: "Source channel of the registration (e.g., ED, scheduled, online, transfer). Tracks registration channel mix and access pathway analysis."
    - name: "mpi_match_status"
      expr: mpi_match_status
      comment: "Status of the MPI identity match at registration (e.g., matched, new, review). Tracks identity resolution quality at the point of registration."
    - name: "discharge_disposition"
      expr: discharge_disposition
      comment: "Discharge disposition code (e.g., home, SNF, expired). Used for post-acute care planning and readmission risk analysis."
    - name: "eligibility_verified_flag"
      expr: eligibility_verified_flag
      comment: "Whether insurance eligibility was verified at registration. A key revenue cycle quality flag — unverified eligibility is a leading cause of claim denials."
    - name: "consent_obtained_flag"
      expr: consent_obtained_flag
      comment: "Whether patient consent was obtained at registration. Tracks consent capture compliance — required for HIPAA and care coordination."
    - name: "duplicate_flag"
      expr: duplicate_flag
      comment: "Whether the registration event was flagged as a duplicate. Tracks registration data quality and MPI integrity at point of entry."
  measures:
    - name: "total_registration_events"
      expr: COUNT(registration_event_id)
      comment: "Total number of registration events. Baseline throughput KPI for patient access and registration operations."
    - name: "eligibility_verified_at_registration_count"
      expr: COUNT(CASE WHEN eligibility_verified_flag = TRUE THEN registration_event_id END)
      comment: "Number of registrations with insurance eligibility verified at point of registration. A leading revenue cycle quality indicator — unverified registrations drive downstream claim denials."
    - name: "eligibility_verification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN eligibility_verified_flag = TRUE THEN registration_event_id END) / NULLIF(COUNT(registration_event_id), 0), 2)
      comment: "Percentage of registrations with eligibility verified at point of service. Industry benchmark is 95%+. Below-benchmark rates are a primary driver of claim denial rates."
    - name: "consent_obtained_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_obtained_flag = TRUE THEN registration_event_id END) / NULLIF(COUNT(registration_event_id), 0), 2)
      comment: "Percentage of registrations with patient consent obtained. A compliance KPI — low rates create HIPAA exposure and care coordination barriers."
    - name: "avg_registration_completeness_score"
      expr: ROUND(AVG(CAST(completeness_score AS DOUBLE)), 4)
      comment: "Average registration data completeness score. A data quality KPI — low scores indicate missing demographic or insurance data that drives claim rejections and care coordination failures."
    - name: "avg_mpi_match_score"
      expr: ROUND(AVG(CAST(mpi_match_score AS DOUBLE)), 4)
      comment: "Average MPI identity match confidence score at registration. Low scores indicate identity resolution quality issues that create patient safety risk (wrong patient events)."
    - name: "duplicate_registration_count"
      expr: COUNT(CASE WHEN duplicate_flag = TRUE THEN registration_event_id END)
      comment: "Number of registration events flagged as duplicates. Duplicate registrations inflate utilization counts, create billing errors, and signal MPI integrity failures."
    - name: "duplicate_registration_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN duplicate_flag = TRUE THEN registration_event_id END) / NULLIF(COUNT(registration_event_id), 0), 2)
      comment: "Percentage of registration events flagged as duplicates. A data quality KPI — high rates indicate systemic MPI or registration workflow failures requiring remediation."
    - name: "hipaa_notice_delivered_count"
      expr: COUNT(CASE WHEN hipaa_notice_delivered_flag = TRUE THEN registration_event_id END)
      comment: "Number of registrations where HIPAA notice was delivered to the patient. Tracks regulatory compliance — failure to deliver HIPAA notice is a reportable compliance violation."
    - name: "hipaa_notice_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hipaa_notice_delivered_flag = TRUE THEN registration_event_id END) / NULLIF(COUNT(registration_event_id), 0), 2)
      comment: "Percentage of registrations with HIPAA notice delivered. A regulatory compliance KPI — below 100% rates require immediate investigation and remediation."
    - name: "avg_expected_los_days"
      expr: ROUND(AVG(CAST(expected_los_days AS DOUBLE)), 2)
      comment: "Average expected length of stay at registration. Used for capacity planning, bed management, and utilization management benchmarking against actual LOS."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_portal_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient portal digital engagement metrics. Tracks portal activation, active usage, proxy access, security posture, and feature adoption. A strategic KPI domain for digital health transformation, patient activation, and consumer experience programs."
  source: "`vibe_healthcare_v1`.`patient`.`portal_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the portal account (e.g., active, inactive, deactivated). Primary segmentation for active digital engagement analysis."
    - name: "account_type"
      expr: account_type
      comment: "Type of portal account (e.g., patient, proxy, caregiver). Enables patient vs. proxy engagement analysis."
    - name: "portal_platform"
      expr: portal_platform
      comment: "Portal platform used (e.g., MyChart, FollowMyHealth, athenahealth). Tracks platform adoption and informs technology investment decisions."
    - name: "activation_method"
      expr: activation_method
      comment: "Method used to activate the portal account (e.g., in-person, email, SMS). Tracks activation channel effectiveness for digital onboarding optimization."
    - name: "notification_preference"
      expr: notification_preference
      comment: "Patient's preferred notification channel (e.g., email, SMS, push). Drives communication channel strategy and patient outreach effectiveness."
    - name: "identity_verification_method"
      expr: identity_verification_method
      comment: "Method used to verify patient identity for portal access (e.g., in-person, knowledge-based, biometric). Tracks identity verification security posture."
    - name: "two_factor_auth_enrolled"
      expr: two_factor_auth_enrolled
      comment: "Whether the account has two-factor authentication enrolled. Tracks security posture of the patient portal — a cybersecurity and compliance KPI."
    - name: "proxy_access_flag"
      expr: proxy_access_flag
      comment: "Whether proxy access is enabled on the account. Tracks caregiver and guardian portal access adoption."
    - name: "messaging_opt_in"
      expr: messaging_opt_in
      comment: "Whether the patient has opted into portal messaging. Tracks secure messaging adoption — a key patient engagement and care coordination feature."
  measures:
    - name: "total_active_portal_accounts"
      expr: COUNT(CASE WHEN account_status = 'active' THEN portal_account_id END)
      comment: "Total number of active patient portal accounts. The foundational digital engagement KPI — directly tied to patient activation scores and digital health strategy ROI."
    - name: "identity_verified_account_count"
      expr: COUNT(CASE WHEN identity_verified_flag = TRUE THEN portal_account_id END)
      comment: "Number of portal accounts with verified patient identity. Tracks identity verification compliance — unverified accounts create PHI exposure risk."
    - name: "identity_verification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN identity_verified_flag = TRUE THEN portal_account_id END) / NULLIF(COUNT(CASE WHEN account_status = 'active' THEN portal_account_id END), 0), 2)
      comment: "Percentage of active portal accounts with verified identity. A security and compliance KPI — low rates indicate PHI access risk and regulatory exposure."
    - name: "two_factor_auth_enrollment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN two_factor_auth_enrolled = TRUE THEN portal_account_id END) / NULLIF(COUNT(CASE WHEN account_status = 'active' THEN portal_account_id END), 0), 2)
      comment: "Percentage of active portal accounts enrolled in two-factor authentication. A cybersecurity KPI — low rates indicate elevated PHI breach risk and may trigger compliance findings."
    - name: "proxy_access_enabled_count"
      expr: COUNT(CASE WHEN proxy_access_flag = TRUE THEN portal_account_id END)
      comment: "Number of portal accounts with proxy access enabled. Tracks caregiver engagement — proxy access is a key driver of pediatric and elderly patient portal adoption."
    - name: "messaging_opt_in_count"
      expr: COUNT(CASE WHEN messaging_opt_in = TRUE THEN portal_account_id END)
      comment: "Number of portal accounts opted into secure messaging. Tracks secure messaging adoption — a key patient engagement feature that reduces phone call volume and improves care coordination."
    - name: "messaging_opt_in_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN messaging_opt_in = TRUE THEN portal_account_id END) / NULLIF(COUNT(CASE WHEN account_status = 'active' THEN portal_account_id END), 0), 2)
      comment: "Percentage of active portal accounts opted into secure messaging. Benchmarks patient communication channel adoption for digital engagement strategy."
    - name: "terms_accepted_count"
      expr: COUNT(CASE WHEN terms_accepted_flag = TRUE THEN portal_account_id END)
      comment: "Number of portal accounts with terms of service accepted. Tracks legal compliance — accounts without accepted terms may have unauthorized PHI access."
    - name: "digital_health_app_linked_count"
      expr: COUNT(CASE WHEN digital_health_app_linked = TRUE THEN portal_account_id END)
      comment: "Number of portal accounts with a digital health app linked. Tracks health app integration adoption — a strategic KPI for remote monitoring and patient-generated health data programs."
    - name: "digital_health_app_link_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN digital_health_app_linked = TRUE THEN portal_account_id END) / NULLIF(COUNT(CASE WHEN account_status = 'active' THEN portal_account_id END), 0), 2)
      comment: "Percentage of active portal accounts with a digital health app linked. A digital transformation KPI — tracks patient adoption of connected health devices and apps."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_consent_reference`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient consent management metrics. Tracks consent capture rates, consent type distribution, HIE participation, research enrollment, and marketing opt-in compliance. A critical regulatory compliance and patient rights domain."
  source: "`vibe_healthcare_v1`.`patient`.`consent_reference`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent record (e.g., active, revoked, expired). Primary dimension for consent compliance analysis."
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent captured (e.g., treatment, research, HIE, marketing). Enables consent type-specific compliance and program analysis."
    - name: "consent_scope"
      expr: consent_scope
      comment: "Scope of the consent (e.g., general, specific procedure, data sharing). Tracks granularity of consent capture."
    - name: "consent_method"
      expr: consent_method
      comment: "Method used to obtain consent (e.g., written, verbal, electronic). Tracks consent capture channel compliance."
    - name: "language_of_consent"
      expr: language_of_consent
      comment: "Language in which consent was obtained. Tracks language access compliance — consent must be obtained in the patient's preferred language."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the consent record. Tracks consent documentation quality and completeness."
    - name: "hie_participation_flag"
      expr: hie_participation_flag
      comment: "Whether the patient has consented to HIE participation. Tracks HIE opt-in rates — a key care coordination and interoperability enablement metric."
    - name: "research_participation_flag"
      expr: research_participation_flag
      comment: "Whether the patient has consented to research participation. Tracks research cohort eligibility and IRB compliance."
    - name: "legal_guardian_flag"
      expr: legal_guardian_flag
      comment: "Whether consent was obtained from a legal guardian. Tracks guardian consent compliance for pediatric and incapacitated patients."
    - name: "phi_disclosure_authorized_flag"
      expr: phi_disclosure_authorized_flag
      comment: "Whether PHI disclosure is authorized under this consent. Tracks PHI sharing authorization compliance."
  measures:
    - name: "total_active_consents"
      expr: COUNT(CASE WHEN consent_status = 'active' THEN consent_reference_id END)
      comment: "Total number of active consent records. Baseline compliance KPI — the denominator for all consent rate calculations."
    - name: "consent_revocation_count"
      expr: COUNT(CASE WHEN consent_status = 'revoked' THEN consent_reference_id END)
      comment: "Number of consents that have been revoked by patients. High revocation rates signal patient trust issues or consent process failures requiring investigation."
    - name: "hie_participation_consent_count"
      expr: COUNT(CASE WHEN hie_participation_flag = TRUE THEN consent_reference_id END)
      comment: "Number of patients consented for HIE participation. Tracks HIE opt-in volume — a key enabler of care coordination and interoperability program effectiveness."
    - name: "hie_participation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hie_participation_flag = TRUE THEN consent_reference_id END) / NULLIF(COUNT(CASE WHEN consent_status = 'active' THEN consent_reference_id END), 0), 2)
      comment: "Percentage of active consents with HIE participation authorized. Low rates limit care coordination effectiveness and interoperability program ROI."
    - name: "research_participation_consent_count"
      expr: COUNT(CASE WHEN research_participation_flag = TRUE THEN consent_reference_id END)
      comment: "Number of patients consented for research participation. Tracks research cohort size — a strategic KPI for clinical research program capacity and grant compliance."
    - name: "marketing_opt_in_count"
      expr: COUNT(CASE WHEN marketing_opt_in_flag = TRUE THEN consent_reference_id END)
      comment: "Number of patients opted into marketing communications. Tracks marketing consent compliance — required under HIPAA and CAN-SPAM for patient outreach programs."
    - name: "interpreter_used_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN interpreter_used_flag = TRUE THEN consent_reference_id END) / NULLIF(COUNT(consent_reference_id), 0), 2)
      comment: "Percentage of consent encounters where an interpreter was used. Tracks language access compliance — required for LEP patients under Title VI and CMS conditions of participation."
    - name: "phi_disclosure_authorized_count"
      expr: COUNT(CASE WHEN phi_disclosure_authorized_flag = TRUE THEN consent_reference_id END)
      comment: "Number of consents authorizing PHI disclosure. Tracks PHI sharing authorization volume — a compliance KPI for HIPAA authorization management."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`patient_guarantor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient financial responsibility and guarantor account metrics. Tracks account balances, financial assistance utilization, payment plan adoption, and bad debt risk. A critical revenue cycle and patient financial services domain."
  source: "`vibe_healthcare_v1`.`patient`.`guarantor`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the guarantor account (e.g., active, collections, closed). Primary segmentation for financial account analysis."
    - name: "guarantor_type"
      expr: guarantor_type
      comment: "Type of guarantor (e.g., self, parent, spouse, organization). Enables guarantor relationship analysis for billing and collections strategy."
    - name: "financial_assistance_status"
      expr: financial_assistance_status
      comment: "Status of financial assistance application (e.g., approved, pending, denied). Tracks charity care and financial assistance program utilization."
    - name: "financial_assistance_type"
      expr: financial_assistance_type
      comment: "Type of financial assistance granted (e.g., charity care, sliding scale, payment plan). Enables financial assistance program mix analysis."
    - name: "employment_status"
      expr: employment_status
      comment: "Guarantor employment status. Used in financial risk stratification and financial assistance eligibility assessment."
    - name: "relationship_to_patient"
      expr: relationship_to_patient
      comment: "Guarantor's relationship to the patient. Used for billing and collections workflow routing."
    - name: "bad_debt_flag"
      expr: bad_debt_flag
      comment: "Whether the account has been written off as bad debt. Tracks bad debt exposure — a key revenue cycle financial performance indicator."
    - name: "payment_plan_flag"
      expr: payment_plan_flag
      comment: "Whether the guarantor is on a payment plan. Tracks payment plan adoption — a key patient financial services KPI."
    - name: "collection_agency_flag"
      expr: collection_agency_flag
      comment: "Whether the account has been referred to a collection agency. Tracks collections escalation rate — a revenue cycle quality and patient experience KPI."
  measures:
    - name: "total_account_balance"
      expr: ROUND(SUM(CAST(account_balance AS DOUBLE)), 2)
      comment: "Total outstanding account balance across all guarantor accounts. The primary patient financial liability KPI — drives collections strategy and financial assistance program sizing."
    - name: "avg_account_balance"
      expr: ROUND(AVG(CAST(account_balance AS DOUBLE)), 2)
      comment: "Average outstanding account balance per guarantor. Benchmarks patient financial liability levels and informs payment plan design."
    - name: "bad_debt_account_count"
      expr: COUNT(CASE WHEN bad_debt_flag = TRUE THEN guarantor_id END)
      comment: "Number of guarantor accounts written off as bad debt. A critical revenue cycle KPI — high bad debt counts signal collections process failures or financial assistance program gaps."
    - name: "total_bad_debt_balance"
      expr: ROUND(SUM(CASE WHEN bad_debt_flag = TRUE THEN CAST(account_balance AS DOUBLE) ELSE 0 END), 2)
      comment: "Total account balance associated with bad debt accounts. Quantifies bad debt financial exposure — a key metric for revenue cycle leadership and CFO reporting."
    - name: "payment_plan_account_count"
      expr: COUNT(CASE WHEN payment_plan_flag = TRUE THEN guarantor_id END)
      comment: "Number of guarantor accounts on payment plans. Tracks payment plan adoption — a key patient financial services program KPI."
    - name: "total_payment_plan_amount"
      expr: ROUND(SUM(CASE WHEN payment_plan_flag = TRUE THEN CAST(payment_plan_amount AS DOUBLE) ELSE 0 END), 2)
      comment: "Total monthly payment plan amount across all active payment plans. Tracks expected monthly collections from payment plan arrangements — a cash flow forecasting KPI."
    - name: "collection_agency_referral_count"
      expr: COUNT(CASE WHEN collection_agency_flag = TRUE THEN guarantor_id END)
      comment: "Number of accounts referred to collection agencies. Tracks collections escalation volume — high rates signal patient financial hardship and may trigger financial assistance outreach."
    - name: "avg_federal_poverty_level_pct"
      expr: ROUND(AVG(CAST(federal_poverty_level_pct AS DOUBLE)), 2)
      comment: "Average federal poverty level percentage across guarantors. Tracks the financial vulnerability of the patient population — drives financial assistance program eligibility thresholds and charity care budget planning."
    - name: "financial_assistance_approved_count"
      expr: COUNT(CASE WHEN financial_assistance_status = 'approved' THEN guarantor_id END)
      comment: "Number of guarantors with approved financial assistance. Tracks charity care and financial assistance program utilization — a community benefit and regulatory compliance KPI."
    - name: "last_payment_total"
      expr: ROUND(SUM(CAST(last_payment_amount AS DOUBLE)), 2)
      comment: "Sum of last payment amounts across all guarantor accounts. Tracks recent patient payment activity — a leading indicator of collections performance and cash flow."
$$;