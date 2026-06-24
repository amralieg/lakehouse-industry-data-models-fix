-- Metric views for domain: reference | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 16:05:56

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_code_set_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Governance and lifecycle metrics for medical code set versions. Tracks validation health, HIPAA compliance coverage, and load pipeline performance across all reference code sets used in clinical and administrative workflows."
  source: "`vibe_healthcare_v1`.`reference`.`code_set_version`"
  dimensions:
    - name: "code_set_name"
      expr: code_set_name
      comment: "Name of the medical code set (e.g., ICD-10, CPT, SNOMED) for grouping version metrics by code set family."
    - name: "code_set_type"
      expr: code_set_type
      comment: "Type classification of the code set (diagnosis, procedure, drug, etc.) enabling cross-type governance analysis."
    - name: "validation_status"
      expr: validation_status
      comment: "Current validation status of the code set version, used to identify unvalidated or failed versions in production."
    - name: "load_status"
      expr: load_status
      comment: "Pipeline load status for the code set version, enabling monitoring of ingestion success and failure rates."
    - name: "version_status"
      expr: version_status
      comment: "Lifecycle status of the version (active, superseded, retired) for tracking currency of reference data."
    - name: "is_hipaa_compliant"
      expr: is_hipaa_compliant
      comment: "Boolean flag indicating whether the code set version meets HIPAA compliance requirements."
    - name: "source_authority"
      expr: source_authority
      comment: "Issuing authority for the code set (e.g., AMA, CMS, NLM) for provenance and governance reporting."
    - name: "compliance_year"
      expr: compliance_year
      comment: "Regulatory compliance year associated with the code set version, enabling year-over-year governance tracking."
    - name: "country_code"
      expr: country_code
      comment: "Country for which the code set version applies, supporting multi-jurisdictional reference data governance."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of the code set version effective date for trend analysis of version activations over time."
  measures:
    - name: "total_code_set_versions"
      expr: COUNT(1)
      comment: "Total number of code set versions loaded. Baseline measure for tracking reference data inventory size and growth."
    - name: "validated_version_count"
      expr: COUNT(CASE WHEN validation_status = 'VALIDATED' THEN 1 END)
      comment: "Number of code set versions that have passed validation. Indicates readiness of reference data for clinical use."
    - name: "hipaa_compliant_version_count"
      expr: COUNT(CASE WHEN is_hipaa_compliant = TRUE THEN 1 END)
      comment: "Count of code set versions confirmed as HIPAA compliant. Critical for regulatory audit and risk management."
    - name: "active_version_count"
      expr: COUNT(CASE WHEN version_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active code set versions in production. Tracks the live reference data footprint."
    - name: "failed_load_version_count"
      expr: COUNT(CASE WHEN load_status = 'FAILED' THEN 1 END)
      comment: "Number of code set versions that failed the load pipeline. Drives immediate operational intervention to restore reference data integrity."
    - name: "total_records_loaded"
      expr: SUM(CAST(record_count AS BIGINT))
      comment: "Total number of individual codes loaded across all code set versions. Measures the scale of the reference data estate."
    - name: "avg_records_per_version"
      expr: AVG(CAST(record_count AS DOUBLE))
      comment: "Average number of records per code set version. Helps identify unusually sparse or oversized versions that may indicate data quality issues."
    - name: "superseded_version_count"
      expr: COUNT(CASE WHEN superseded_by_version_code_set_version_id IS NOT NULL THEN 1 END)
      comment: "Number of code set versions that have been superseded by a newer version. Tracks version churn and upgrade velocity."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_cpt_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical and financial metrics for CPT procedure codes. Supports RVU-based reimbursement analysis, telemedicine eligibility tracking, and procedure cost benchmarking for strategic contracting and care delivery decisions."
  source: "`vibe_healthcare_v1`.`reference`.`cpt_code`"
  dimensions:
    - name: "category"
      expr: category
      comment: "CPT code category (e.g., Category I, II, III) for stratifying procedure metrics by clinical classification."
    - name: "section"
      expr: section
      comment: "CPT section (e.g., Surgery, Radiology, E&M) enabling departmental and service-line performance analysis."
    - name: "clinical_family"
      expr: clinical_family
      comment: "Clinical family grouping for the CPT code, supporting specialty-level RVU and payment benchmarking."
    - name: "cpt_code_status"
      expr: cpt_code_status
      comment: "Active/inactive status of the CPT code, used to filter analyses to currently billable procedures."
    - name: "telemedicine_eligible"
      expr: telemedicine_eligible
      comment: "Boolean flag indicating telemedicine eligibility, enabling strategic analysis of virtual care service coverage."
    - name: "facility_indicator"
      expr: facility_indicator
      comment: "Indicates whether the code applies to facility or non-facility settings, relevant for site-of-care cost analysis."
    - name: "gender_specific"
      expr: gender_specific
      comment: "Gender restriction for the CPT code, used in equity and access analyses."
    - name: "global_period"
      expr: global_period
      comment: "Global surgical period designation (0, 10, 90 days) for bundled payment and care coordination analysis."
    - name: "effective_date_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the CPT code became effective, enabling year-over-year analysis of code set evolution and reimbursement changes."
  measures:
    - name: "total_active_cpt_codes"
      expr: COUNT(CASE WHEN cpt_code_status = 'ACTIVE' THEN 1 END)
      comment: "Count of currently active CPT codes. Baseline measure for tracking the billable procedure code inventory."
    - name: "telemedicine_eligible_code_count"
      expr: COUNT(CASE WHEN telemedicine_eligible = TRUE THEN 1 END)
      comment: "Number of CPT codes eligible for telemedicine billing. Directly informs virtual care strategy and network design decisions."
    - name: "avg_total_rvu"
      expr: AVG(CAST(total_rvu AS DOUBLE))
      comment: "Average total Relative Value Unit across CPT codes. Benchmark for procedure complexity and reimbursement potential by category or specialty."
    - name: "avg_work_rvu"
      expr: AVG(CAST(work_rvu AS DOUBLE))
      comment: "Average physician work RVU. Key input for physician compensation modeling and productivity benchmarking."
    - name: "avg_practice_expense_rvu"
      expr: AVG(CAST(practice_expense_rvu AS DOUBLE))
      comment: "Average practice expense RVU. Informs overhead cost allocation and facility investment decisions."
    - name: "avg_national_payment_amount"
      expr: AVG(CAST(national_payment_amount AS DOUBLE))
      comment: "Average national Medicare payment amount per CPT code. Used for contract benchmarking and payer rate negotiation."
    - name: "total_national_payment_amount"
      expr: SUM(CAST(national_payment_amount AS DOUBLE))
      comment: "Sum of national payment amounts across CPT codes in scope. Measures total reimbursement exposure for a given procedure set or service line."
    - name: "avg_anesthesia_base_units"
      expr: AVG(CAST(anesthesia_base_units AS DOUBLE))
      comment: "Average anesthesia base units for CPT codes with anesthesia components. Supports anesthesia billing accuracy and cost modeling."
    - name: "avg_conversion_factor"
      expr: AVG(CAST(conversion_factor AS DOUBLE))
      comment: "Average conversion factor applied to RVUs for payment calculation. Tracks CMS fee schedule changes and their financial impact."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_drg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inpatient payment and utilization metrics for Diagnosis Related Groups. Supports bundled payment strategy, length-of-stay benchmarking, readmission risk management, and case-mix complexity analysis for hospital financial planning."
  source: "`vibe_healthcare_v1`.`reference`.`drg`"
  dimensions:
    - name: "drg_type"
      expr: drg_type
      comment: "DRG classification type (e.g., MS-DRG, APR-DRG) for grouper-specific financial benchmarking."
    - name: "clinical_family"
      expr: clinical_family
      comment: "Clinical family grouping for the DRG, enabling service-line level payment and utilization analysis."
    - name: "complication_level"
      expr: complication_level
      comment: "Complication/comorbidity severity level (MCC, CC, no CC) — key driver of DRG payment and case-mix index."
    - name: "grouper_system"
      expr: grouper_system
      comment: "Grouper system used to assign the DRG (e.g., CMS, 3M APR), enabling cross-system payment comparisons."
    - name: "readmission_penalty_flag"
      expr: readmission_penalty_flag
      comment: "Boolean flag indicating DRGs subject to CMS readmission reduction penalties. Critical for quality and financial risk management."
    - name: "bundled_payment_flag"
      expr: bundled_payment_flag
      comment: "Indicates DRGs included in bundled payment programs. Supports alternative payment model strategy and contracting."
    - name: "operating_room_procedure_flag"
      expr: operating_room_procedure_flag
      comment: "Flags DRGs requiring an operating room procedure, relevant for surgical volume and capacity planning."
    - name: "post_acute_transfer_flag"
      expr: post_acute_transfer_flag
      comment: "Indicates DRGs subject to post-acute transfer payment adjustments, impacting discharge planning and revenue."
    - name: "effective_date_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the DRG definition became effective, enabling year-over-year tracking of payment weight and policy changes."
  measures:
    - name: "total_drg_codes"
      expr: COUNT(1)
      comment: "Total number of DRG codes in the reference set. Baseline for tracking case-mix breadth and grouper coverage."
    - name: "avg_relative_weight"
      expr: AVG(CAST(relative_weight AS DOUBLE))
      comment: "Average DRG relative weight (case-mix index proxy). Higher values indicate more complex, resource-intensive cases and higher expected reimbursement."
    - name: "avg_geometric_mean_los"
      expr: AVG(CAST(geometric_mean_los AS DOUBLE))
      comment: "Average geometric mean length of stay across DRGs. Benchmark for inpatient utilization efficiency and discharge planning performance."
    - name: "avg_arithmetic_mean_los"
      expr: AVG(CAST(arithmetic_mean_los AS DOUBLE))
      comment: "Average arithmetic mean length of stay. Used alongside geometric mean to identify outlier-driven LOS patterns."
    - name: "avg_national_average_payment"
      expr: AVG(CAST(national_average_payment AS DOUBLE))
      comment: "Average national Medicare payment per DRG. Benchmark for payer contract negotiations and hospital rate adequacy assessment."
    - name: "avg_national_average_charges"
      expr: AVG(CAST(national_average_charges AS DOUBLE))
      comment: "Average national billed charges per DRG. Used to compute charge-to-payment ratios and assess pricing strategy."
    - name: "avg_cost_outlier_threshold"
      expr: AVG(CAST(cost_outlier_threshold AS DOUBLE))
      comment: "Average cost outlier threshold across DRGs. Informs risk management for high-cost cases that may trigger outlier payment adjustments."
    - name: "readmission_penalty_drg_count"
      expr: COUNT(CASE WHEN readmission_penalty_flag = TRUE THEN 1 END)
      comment: "Number of DRGs subject to CMS readmission reduction penalties. Quantifies the scope of readmission risk exposure for quality program management."
    - name: "bundled_payment_drg_count"
      expr: COUNT(CASE WHEN bundled_payment_flag = TRUE THEN 1 END)
      comment: "Number of DRGs included in bundled payment programs. Measures the organization's alternative payment model footprint."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_icd_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical coding quality and coverage metrics for ICD diagnosis codes. Supports coding compliance, complication/comorbidity (CC/MCC) capture rate analysis, and diagnosis code lifecycle governance for revenue integrity and quality reporting."
  source: "`vibe_healthcare_v1`.`reference`.`icd_code`"
  dimensions:
    - name: "code_type"
      expr: code_type
      comment: "ICD version type (ICD-10-CM, ICD-9-CM, etc.) for version-specific coding analysis and migration tracking."
    - name: "chapter"
      expr: chapter
      comment: "ICD chapter grouping (e.g., Diseases of the Circulatory System) for clinical domain-level coding coverage analysis."
    - name: "category"
      expr: category
      comment: "ICD category within a chapter, enabling granular clinical coding quality and completeness assessment."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Indicates whether the ICD code is billable (leaf-level). Filters analyses to codes that can be submitted on claims."
    - name: "cc_flag"
      expr: cc_flag
      comment: "Complication/Comorbidity flag. CC codes increase DRG weight and reimbursement — tracking coverage is critical for revenue integrity."
    - name: "mcc_flag"
      expr: mcc_flag
      comment: "Major Complication/Comorbidity flag. MCC codes have the highest DRG payment impact and are a top revenue integrity focus."
    - name: "hac_flag"
      expr: hac_flag
      comment: "Hospital-Acquired Condition flag. HAC codes trigger payment penalties and quality reporting obligations."
    - name: "gender_specific_flag"
      expr: gender_specific_flag
      comment: "Indicates gender-specific diagnosis codes, used in coding accuracy and equity audits."
    - name: "valid_for_coding_flag"
      expr: valid_for_coding_flag
      comment: "Indicates whether the code is currently valid for use in coding. Ensures analyses exclude retired or invalid codes."
    - name: "effective_date_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the ICD code became effective, enabling tracking of code set expansion and annual update impact."
  measures:
    - name: "total_billable_codes"
      expr: COUNT(CASE WHEN billable_flag = TRUE THEN 1 END)
      comment: "Total number of billable ICD codes. Baseline for coding coverage and completeness assessments."
    - name: "mcc_code_count"
      expr: COUNT(CASE WHEN mcc_flag = TRUE THEN 1 END)
      comment: "Number of Major Complication/Comorbidity codes. Quantifies the MCC capture opportunity for DRG optimization and revenue integrity programs."
    - name: "cc_code_count"
      expr: COUNT(CASE WHEN cc_flag = TRUE THEN 1 END)
      comment: "Number of Complication/Comorbidity codes. Measures CC capture opportunity for DRG weight improvement and reimbursement optimization."
    - name: "hac_code_count"
      expr: COUNT(CASE WHEN hac_flag = TRUE THEN 1 END)
      comment: "Number of Hospital-Acquired Condition codes. Quantifies the HAC risk exposure requiring quality improvement and payment penalty mitigation."
    - name: "poa_exempt_code_count"
      expr: COUNT(CASE WHEN poa_exempt_flag = TRUE THEN 1 END)
      comment: "Number of codes exempt from Present-on-Admission reporting. Relevant for HAC payment adjustment compliance and coding workflow design."
    - name: "valid_for_coding_count"
      expr: COUNT(CASE WHEN valid_for_coding_flag = TRUE THEN 1 END)
      comment: "Number of ICD codes currently valid for coding. Tracks the active coding vocabulary size and annual update adoption."
    - name: "unacceptable_principal_dx_count"
      expr: COUNT(CASE WHEN unacceptable_principal_dx_flag = TRUE THEN 1 END)
      comment: "Number of codes flagged as unacceptable as a principal diagnosis. Informs coding edits and claim denial prevention programs."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_ndc_drug`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug formulary, safety, and regulatory metrics for NDC drug codes. Supports formulary management, high-alert medication safety programs, controlled substance oversight, and biosimilar adoption strategy."
  source: "`vibe_healthcare_v1`.`reference`.`ndc_drug`"
  dimensions:
    - name: "therapeutic_class"
      expr: therapeutic_class
      comment: "Therapeutic drug class for grouping drug metrics by clinical indication and formulary tier analysis."
    - name: "dosage_form"
      expr: dosage_form
      comment: "Drug dosage form (tablet, injection, etc.) for supply chain and formulary standardization analysis."
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration (oral, IV, etc.) for care setting and medication safety analysis."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA controlled substance schedule (I-V) for regulatory compliance and controlled substance program oversight."
    - name: "marketing_category"
      expr: marketing_category
      comment: "FDA marketing category (NDA, ANDA, BLA, etc.) for regulatory status and biosimilar/generic substitution analysis."
    - name: "formulary_status"
      expr: formulary_status
      comment: "Current formulary status of the drug. Drives formulary management, prior authorization, and cost containment decisions."
    - name: "vaccine_flag"
      expr: vaccine_flag
      comment: "Indicates vaccine products for immunization program coverage and public health reporting."
    - name: "biosimilar_flag"
      expr: biosimilar_flag
      comment: "Indicates biosimilar drugs. Tracks biosimilar adoption opportunity for specialty drug cost reduction programs."
    - name: "over_the_counter_flag"
      expr: over_the_counter_flag
      comment: "Indicates OTC drugs for formulary scope and benefit design analysis."
    - name: "effective_date_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the NDC drug record became effective, enabling tracking of formulary additions and drug lifecycle trends."
  measures:
    - name: "total_active_drugs"
      expr: COUNT(CASE WHEN expiration_date IS NULL OR expiration_date > CURRENT_DATE() THEN 1 END)
      comment: "Total number of currently active NDC drug records. Baseline for formulary size and drug inventory management."
    - name: "high_alert_medication_count"
      expr: COUNT(CASE WHEN high_alert_medication_flag = TRUE THEN 1 END)
      comment: "Number of high-alert medications in the formulary. Directly informs medication safety program scope and error prevention investment."
    - name: "black_box_warning_count"
      expr: COUNT(CASE WHEN black_box_warning_flag = TRUE THEN 1 END)
      comment: "Number of drugs with FDA black box warnings. Quantifies the high-risk drug exposure requiring enhanced prescribing controls and monitoring."
    - name: "controlled_substance_count"
      expr: COUNT(CASE WHEN dea_schedule IS NOT NULL AND dea_schedule != '' THEN 1 END)
      comment: "Number of controlled substances in the drug reference. Measures the scope of DEA compliance and controlled substance monitoring obligations."
    - name: "biosimilar_drug_count"
      expr: COUNT(CASE WHEN biosimilar_flag = TRUE THEN 1 END)
      comment: "Number of biosimilar drugs available. Quantifies the biosimilar substitution opportunity for specialty drug cost reduction."
    - name: "refrigeration_required_count"
      expr: COUNT(CASE WHEN refrigeration_required_flag = TRUE THEN 1 END)
      comment: "Number of drugs requiring refrigerated storage. Informs cold chain logistics investment and pharmacy infrastructure planning."
    - name: "avg_package_quantity"
      expr: AVG(CAST(package_quantity AS DOUBLE))
      comment: "Average package quantity per NDC drug record. Supports dispensing standardization and unit-of-use formulary optimization."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_npi_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider network and credentialing metrics derived from the NPI registry. Supports network adequacy analysis, provider directory accuracy, and workforce planning by taxonomy, geography, and entity type."
  source: "`vibe_healthcare_v1`.`reference`.`npi_registry`"
  dimensions:
    - name: "entity_type_code"
      expr: entity_type_code
      comment: "NPI entity type (1=Individual, 2=Organization). Fundamental dimension for separating provider and facility network metrics."
    - name: "primary_taxonomy_code"
      expr: primary_taxonomy_code
      comment: "Provider primary specialty taxonomy code. Enables network adequacy analysis by specialty and access gap identification."
    - name: "mailing_address_state"
      expr: mailing_address_state
      comment: "Provider state for geographic network adequacy and access analysis."
    - name: "mailing_address_city"
      expr: mailing_address_city
      comment: "Provider city for local market network density and access analysis."
    - name: "provider_gender_code"
      expr: provider_gender_code
      comment: "Provider gender for workforce diversity and patient preference matching analysis."
    - name: "enumeration_date_year"
      expr: DATE_TRUNC('YEAR', enumeration_date)
      comment: "Year the NPI was enumerated. Tracks provider network growth and new entrant trends over time."
    - name: "deactivation_date_year"
      expr: DATE_TRUNC('YEAR', deactivation_date)
      comment: "Year of NPI deactivation. Enables analysis of provider attrition trends and network shrinkage."
  measures:
    - name: "total_active_providers"
      expr: COUNT(CASE WHEN deactivation_date IS NULL THEN 1 END)
      comment: "Total number of active (non-deactivated) NPI registrants. Primary measure for network size and adequacy assessment."
    - name: "individual_provider_count"
      expr: COUNT(CASE WHEN entity_type_code = '1' THEN 1 END)
      comment: "Count of individual (Type 1) NPI providers. Measures the physician and clinician workforce available in the network."
    - name: "organization_provider_count"
      expr: COUNT(CASE WHEN entity_type_code = '2' THEN 1 END)
      comment: "Count of organizational (Type 2) NPI entities. Measures the facility and group practice network footprint."
    - name: "deactivated_provider_count"
      expr: COUNT(CASE WHEN deactivation_date IS NOT NULL THEN 1 END)
      comment: "Number of deactivated NPI records. Tracks provider attrition and the need for network directory cleanup and re-credentialing."
    - name: "distinct_taxonomy_count"
      expr: COUNT(DISTINCT primary_taxonomy_code)
      comment: "Number of distinct provider specialty taxonomies represented. Measures specialty breadth and network comprehensiveness for access adequacy."
    - name: "distinct_state_count"
      expr: COUNT(DISTINCT mailing_address_state)
      comment: "Number of distinct states with active providers. Measures geographic network coverage for multi-state plan and regulatory reporting."
    - name: "reactivated_provider_count"
      expr: COUNT(CASE WHEN reactivation_date IS NOT NULL THEN 1 END)
      comment: "Number of providers who have been reactivated after deactivation. Tracks provider re-engagement and directory accuracy restoration efforts."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_crosswalk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Code mapping quality and coverage metrics for clinical terminology crosswalks. Supports interoperability governance, mapping accuracy assessment, and translation completeness tracking across code systems (ICD, SNOMED, CPT, LOINC, etc.)."
  source: "`vibe_healthcare_v1`.`reference`.`crosswalk`"
  dimensions:
    - name: "source_code_system"
      expr: source_code_system
      comment: "Source code system for the mapping (e.g., ICD-10-CM, CPT). Enables analysis of mapping coverage by originating terminology."
    - name: "target_code_system"
      expr: target_code_system
      comment: "Target code system for the mapping (e.g., SNOMED CT, LOINC). Measures translation completeness to destination terminologies."
    - name: "mapping_type"
      expr: mapping_type
      comment: "Type of mapping relationship (e.g., exact, broad, narrow) for assessing translation fidelity and clinical risk."
    - name: "mapping_quality"
      expr: mapping_quality
      comment: "Quality rating of the mapping. Drives prioritization of mapping improvement efforts for high-risk clinical translations."
    - name: "mapping_authority"
      expr: mapping_authority
      comment: "Organization or body that produced the mapping (e.g., NLM, CMS). Supports provenance and trust assessment for interoperability."
    - name: "directionality"
      expr: directionality
      comment: "Mapping directionality (unidirectional, bidirectional). Relevant for round-trip translation and data exchange design."
    - name: "no_map_flag"
      expr: no_map_flag
      comment: "Indicates source codes with no valid target mapping. Quantifies unmapped code gaps that create interoperability failures."
    - name: "approximate_flag"
      expr: approximate_flag
      comment: "Indicates approximate (non-exact) mappings. Tracks clinical translation risk from imprecise code equivalences."
    - name: "effective_date_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the crosswalk mapping became effective, enabling tracking of mapping currency and annual update adoption."
  measures:
    - name: "total_mappings"
      expr: COUNT(1)
      comment: "Total number of crosswalk mappings. Baseline measure for interoperability coverage and translation library size."
    - name: "no_map_count"
      expr: COUNT(CASE WHEN no_map_flag = TRUE THEN 1 END)
      comment: "Number of source codes with no valid target mapping. Quantifies interoperability gaps that cause data loss in clinical system translations."
    - name: "approximate_mapping_count"
      expr: COUNT(CASE WHEN approximate_flag = TRUE THEN 1 END)
      comment: "Number of approximate (non-exact) mappings. Measures clinical translation risk from imprecise code equivalences requiring human review."
    - name: "combination_mapping_count"
      expr: COUNT(CASE WHEN combination_flag = TRUE THEN 1 END)
      comment: "Number of combination mappings (one source maps to multiple targets). Identifies complex translations requiring special handling in data pipelines."
    - name: "total_usage_count"
      expr: SUM(CAST(usage_count AS BIGINT))
      comment: "Total usage count across all crosswalk mappings. Identifies the most operationally critical mappings for prioritized quality assurance."
    - name: "avg_usage_count"
      expr: AVG(CAST(usage_count AS DOUBLE))
      comment: "Average usage count per crosswalk mapping. Benchmarks mapping utilization to identify underused or overloaded translation paths."
    - name: "distinct_source_code_count"
      expr: COUNT(DISTINCT source_code)
      comment: "Number of distinct source codes with at least one mapping. Measures the breadth of translation coverage from the source terminology."
    - name: "distinct_target_code_count"
      expr: COUNT(DISTINCT target_code)
      comment: "Number of distinct target codes reached by mappings. Measures the coverage depth of the destination terminology achieved through crosswalks."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_snomed_concept`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical terminology coverage and quality metrics for SNOMED CT concepts. Supports ontology governance, EHR terminology adoption, quality measure inclusion tracking, and clinical documentation completeness for value-based care programs."
  source: "`vibe_healthcare_v1`.`reference`.`snomed_concept`"
  dimensions:
    - name: "concept_class"
      expr: concept_class
      comment: "SNOMED concept class (e.g., Clinical Finding, Procedure, Observable Entity) for ontology coverage analysis by clinical domain."
    - name: "concept_status"
      expr: concept_status
      comment: "Current status of the SNOMED concept (active, inactive, retired). Ensures analyses focus on clinically current terminology."
    - name: "top_level_hierarchy"
      expr: top_level_hierarchy
      comment: "Top-level SNOMED hierarchy (e.g., Clinical Finding, Body Structure) for high-level ontology coverage and gap analysis."
    - name: "semantic_tag"
      expr: semantic_tag
      comment: "SNOMED semantic tag indicating the concept type. Supports fine-grained terminology governance and EHR value set management."
    - name: "is_ehr_preferred"
      expr: is_ehr_preferred
      comment: "Indicates concepts preferred for EHR clinical documentation. Tracks EHR terminology standardization and adoption progress."
    - name: "is_reportable"
      expr: is_reportable
      comment: "Indicates concepts included in regulatory or quality reporting. Measures the reportable concept footprint for compliance programs."
    - name: "definition_status"
      expr: definition_status
      comment: "Whether the concept is fully defined or primitive in the SNOMED ontology. Impacts reasoning and inference quality in clinical decision support."
    - name: "effective_time_year"
      expr: DATE_TRUNC('YEAR', effective_time)
      comment: "Year the SNOMED concept became effective, enabling tracking of ontology growth and annual release adoption."
  measures:
    - name: "total_active_concepts"
      expr: COUNT(CASE WHEN concept_status = 'ACTIVE' THEN 1 END)
      comment: "Total number of active SNOMED concepts. Baseline for ontology coverage and clinical terminology completeness assessment."
    - name: "ehr_preferred_concept_count"
      expr: COUNT(CASE WHEN is_ehr_preferred = TRUE THEN 1 END)
      comment: "Number of concepts designated as EHR-preferred. Measures the standardized clinical vocabulary available for structured EHR documentation."
    - name: "reportable_concept_count"
      expr: COUNT(CASE WHEN is_reportable = TRUE THEN 1 END)
      comment: "Number of reportable SNOMED concepts. Quantifies the terminology scope required for regulatory and quality measure reporting obligations."
    - name: "quality_measure_concept_count"
      expr: COUNT(CASE WHEN quality_measure_inclusion IS NOT NULL AND quality_measure_inclusion != '' THEN 1 END)
      comment: "Number of SNOMED concepts included in quality measures. Directly informs value-based care program terminology governance and measure stewardship."
    - name: "leaf_concept_count"
      expr: COUNT(CASE WHEN is_leaf_concept = TRUE THEN 1 END)
      comment: "Number of leaf-level (most specific) SNOMED concepts. Measures the granularity of clinical coding available for precise documentation and analytics."
    - name: "icd10_mapped_concept_count"
      expr: COUNT(CASE WHEN icd10_map_target IS NOT NULL AND icd10_map_target != '' THEN 1 END)
      comment: "Number of SNOMED concepts with an ICD-10 mapping. Measures the cross-terminology translation coverage critical for claims and regulatory reporting."
    - name: "rxnorm_mapped_concept_count"
      expr: COUNT(CASE WHEN rxnorm_map_target IS NOT NULL AND rxnorm_map_target != '' THEN 1 END)
      comment: "Number of SNOMED concepts mapped to RxNorm drug codes. Tracks medication terminology interoperability coverage for clinical decision support and e-prescribing."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_loinc_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory and clinical observation metrics for LOINC codes. Supports lab test standardization, order/result catalog governance, and interoperability coverage for clinical data exchange and quality measurement programs."
  source: "`vibe_healthcare_v1`.`reference`.`loinc_code`"
  dimensions:
    - name: "class"
      expr: class
      comment: "LOINC class (e.g., CHEM, HEM/BC, MICRO) for grouping lab and clinical observation metrics by discipline."
    - name: "scale_type"
      expr: scale_type
      comment: "LOINC scale type (Quantitative, Ordinal, Nominal, Narrative) for result type analysis and interface design."
    - name: "method_type"
      expr: method_type
      comment: "Measurement method for the LOINC observation. Supports standardization of lab methodologies and result comparability."
    - name: "panel_type"
      expr: panel_type
      comment: "Indicates whether the LOINC code is a panel or individual test. Relevant for order set design and utilization management."
    - name: "is_active"
      expr: is_active
      comment: "Active/inactive status of the LOINC code. Ensures analyses focus on currently valid observation codes."
    - name: "order_observation_flag"
      expr: order_observation_flag
      comment: "Indicates whether the LOINC code is used for ordering, observation, or both. Supports order catalog and result mapping governance."
    - name: "time_aspect"
      expr: time_aspect
      comment: "LOINC time aspect (point-in-time vs. duration) for temporal analysis design in clinical data pipelines."
    - name: "effective_date_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the LOINC code became effective, enabling tracking of catalog growth and annual release adoption."
  measures:
    - name: "total_active_loinc_codes"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Total number of active LOINC codes. Baseline for lab and clinical observation catalog size and standardization coverage."
    - name: "deprecated_code_count"
      expr: COUNT(CASE WHEN deprecated_date IS NOT NULL THEN 1 END)
      comment: "Number of deprecated LOINC codes. Tracks technical debt in lab interfaces and the scope of code migration required for interoperability maintenance."
    - name: "order_eligible_code_count"
      expr: COUNT(CASE WHEN order_observation_flag = TRUE THEN 1 END)
      comment: "Number of LOINC codes eligible for ordering. Measures the standardized order catalog coverage available for CPOE and lab system integration."
    - name: "distinct_class_count"
      expr: COUNT(DISTINCT class)
      comment: "Number of distinct LOINC classes represented. Measures the breadth of clinical observation domains covered by the active code set."
    - name: "panel_code_count"
      expr: COUNT(CASE WHEN panel_type IS NOT NULL AND panel_type != '' THEN 1 END)
      comment: "Number of LOINC panel codes. Quantifies the structured order set vocabulary available for clinical workflow standardization."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_hcpcs_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outpatient and ancillary service payment metrics for HCPCS codes. Supports DME coverage analysis, drug billing governance, prior authorization burden assessment, and outpatient payment policy tracking for revenue cycle and contracting decisions."
  source: "`vibe_healthcare_v1`.`reference`.`hcpcs_code`"
  dimensions:
    - name: "code_type"
      expr: code_type
      comment: "HCPCS code type (Level I CPT, Level II) for stratifying metrics by billing code classification."
    - name: "category"
      expr: category
      comment: "HCPCS category for grouping codes by service type (DME, drugs, transportation, etc.) in coverage and payment analysis."
    - name: "dme_indicator"
      expr: dme_indicator
      comment: "Indicates Durable Medical Equipment codes. Enables DME-specific coverage, utilization, and payment analysis."
    - name: "drug_indicator"
      expr: drug_indicator
      comment: "Indicates drug-related HCPCS codes. Supports drug billing governance and specialty pharmacy cost analysis."
    - name: "prior_authorization_indicator"
      expr: prior_authorization_indicator
      comment: "Indicates codes requiring prior authorization. Measures the prior auth administrative burden and denial risk scope."
    - name: "coverage_indicator"
      expr: coverage_indicator
      comment: "Medicare/Medicaid coverage status for the HCPCS code. Drives benefit design and network coverage decisions."
    - name: "pricing_indicator"
      expr: pricing_indicator
      comment: "Pricing methodology indicator for the HCPCS code. Supports payment policy analysis and fee schedule management."
    - name: "effective_date_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the HCPCS code became effective, enabling tracking of code set additions and annual policy update impact."
  measures:
    - name: "total_active_hcpcs_codes"
      expr: COUNT(CASE WHEN termination_date IS NULL OR termination_date > CURRENT_DATE() THEN 1 END)
      comment: "Total number of currently active HCPCS codes. Baseline for outpatient and ancillary service billing vocabulary coverage."
    - name: "prior_auth_required_count"
      expr: COUNT(CASE WHEN prior_authorization_indicator = TRUE THEN 1 END)
      comment: "Number of HCPCS codes requiring prior authorization. Quantifies the prior auth administrative burden and patient access friction for outpatient services."
    - name: "dme_code_count"
      expr: COUNT(CASE WHEN dme_indicator = TRUE THEN 1 END)
      comment: "Number of DME HCPCS codes. Measures the DME billing vocabulary scope for post-acute and home health program management."
    - name: "drug_billing_code_count"
      expr: COUNT(CASE WHEN drug_indicator = TRUE THEN 1 END)
      comment: "Number of drug-related HCPCS codes. Quantifies the drug billing code coverage for specialty pharmacy and infusion program governance."
    - name: "avg_intraoperative_percentage"
      expr: AVG(CAST(intraoperative_percentage AS DOUBLE))
      comment: "Average intraoperative work percentage for HCPCS codes with surgical components. Supports surgical billing accuracy and global period compliance."
    - name: "avg_quantity_limit"
      expr: AVG(CAST(quantity_limit AS DOUBLE))
      comment: "Average quantity limit across HCPCS codes with quantity restrictions. Informs utilization management policy design and claims editing rules."
    - name: "modifier_required_count"
      expr: COUNT(CASE WHEN modifier_required_indicator = TRUE THEN 1 END)
      comment: "Number of HCPCS codes requiring a modifier for billing. Measures the coding complexity burden and claim edit risk in revenue cycle operations."
$$;