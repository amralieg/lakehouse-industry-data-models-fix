-- Metric views for domain: reference | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`reference_code_set_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for tracking code set version lifecycle, compliance readiness, and currency across the enterprise terminology infrastructure. Critical for ensuring clinical and billing systems use current, validated code sets."
  source: "`healthcare_ecm_v1`.`reference`.`code_set_version`"
  dimensions:
    - name: "code_set_name"
      expr: code_set_name
      comment: "Name of the code set (ICD-10, CPT, SNOMED, LOINC, etc.) for grouping version metrics by terminology system"
    - name: "code_set_type"
      expr: code_set_type
      comment: "Classification type of the code set (diagnosis, procedure, laboratory, etc.)"
    - name: "version_status"
      expr: version_status
      comment: "Current lifecycle status of the version (active, retired, draft, superseded)"
    - name: "load_status"
      expr: load_status
      comment: "ETL load status indicating whether the version was successfully ingested"
    - name: "validation_status"
      expr: validation_status
      comment: "Whether the code set version passed integrity validation checks"
    - name: "is_hipaa_compliant"
      expr: CAST(is_hipaa_compliant AS STRING)
      comment: "Whether the code set version meets HIPAA transaction set requirements"
    - name: "compliance_year"
      expr: compliance_year
      comment: "Regulatory compliance year the version applies to (e.g., FY2024)"
    - name: "country_code"
      expr: country_code
      comment: "Country jurisdiction for the code set version"
    - name: "source_authority"
      expr: source_authority
      comment: "Authoritative body publishing the code set (CMS, AMA, WHO, Regenstrief, etc.)"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the code set version became effective for time-based trending"
  measures:
    - name: "total_code_set_versions"
      expr: COUNT(1)
      comment: "Total number of code set versions loaded into the reference data layer"
    - name: "avg_record_count_per_version"
      expr: AVG(CAST(consent_record_count AS DOUBLE))
      comment: "Average number of codes/records per code set version, indicating terminology complexity"
    - name: "total_records_across_versions"
      expr: SUM(CAST(consent_record_count AS BIGINT))
      comment: "Total code records across all versions for capacity planning and storage estimation"
    - name: "hipaa_compliant_version_count"
      expr: COUNT(CASE WHEN is_hipaa_compliant = TRUE THEN 1 END)
      comment: "Number of code set versions that are HIPAA-compliant, critical for regulatory audit readiness"
    - name: "non_validated_version_count"
      expr: COUNT(CASE WHEN validation_status != 'validated' OR validation_status IS NULL THEN 1 END)
      comment: "Count of code set versions not yet validated — flags governance risk for clinical systems relying on unvalidated terminologies"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`reference_icd_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for ICD diagnosis and procedure code catalog health, billability coverage, and risk adjustment readiness. Essential for revenue cycle integrity and clinical documentation improvement programs."
  source: "`healthcare_ecm_v1`.`reference`.`icd_code`"
  dimensions:
    - name: "code_type"
      expr: code_type
      comment: "ICD code type (ICD-10-CM diagnosis, ICD-10-PCS procedure)"
    - name: "chapter"
      expr: chapter
      comment: "ICD chapter grouping for body system or condition category analysis"
    - name: "icd_code_category"
      expr: icd_code_category
      comment: "Hierarchical category within the ICD classification"
    - name: "billable_flag"
      expr: CAST(billable_flag AS STRING)
      comment: "Whether the code is billable (leaf-level) — non-billable codes cannot appear on claims"
    - name: "cc_flag"
      expr: CAST(cc_flag AS STRING)
      comment: "Complication/Comorbidity flag for risk adjustment and DRG assignment"
    - name: "mcc_flag"
      expr: CAST(mcc_flag AS STRING)
      comment: "Major Complication/Comorbidity flag — highest severity for DRG weight uplift"
    - name: "hac_flag"
      expr: CAST(hac_flag AS STRING)
      comment: "Hospital-Acquired Condition flag — CMS payment reduction indicator"
    - name: "gender_specific_flag"
      expr: gender_specific_flag
      comment: "Gender specificity for clinical edit validation"
  measures:
    - name: "total_icd_codes"
      expr: COUNT(1)
      comment: "Total ICD codes in the reference catalog — baseline for terminology completeness assessment"
    - name: "billable_code_count"
      expr: COUNT(CASE WHEN billable_flag = TRUE THEN 1 END)
      comment: "Number of billable (leaf-level) ICD codes available for claims submission"
    - name: "cc_mcc_code_count"
      expr: COUNT(CASE WHEN cc_flag = TRUE OR mcc_flag = TRUE THEN 1 END)
      comment: "Count of codes that qualify as CC or MCC — drives risk adjustment and DRG optimization opportunities"
    - name: "hac_code_count"
      expr: COUNT(CASE WHEN hac_flag = TRUE THEN 1 END)
      comment: "Count of Hospital-Acquired Condition codes — critical for patient safety and CMS penalty avoidance"
    - name: "expired_code_count"
      expr: COUNT(CASE WHEN expiration_date IS NOT NULL AND expiration_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of expired ICD codes — monitors terminology currency and flags potential claim denial risk from outdated codes"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`reference_cpt_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for CPT procedure code catalog covering RVU analysis, reimbursement benchmarking, and telehealth readiness. Directly informs physician compensation models and fee schedule negotiations."
  source: "`healthcare_ecm_v1`.`reference`.`cpt_code`"
  dimensions:
    - name: "cpt_code_category"
      expr: cpt_code_category
      comment: "CPT category (Category I, II, III) indicating code maturity and tracking purpose"
    - name: "section"
      expr: section
      comment: "CPT section (Surgery, Medicine, Radiology, etc.) for service line analysis"
    - name: "subsection"
      expr: subsection
      comment: "CPT subsection for granular specialty-level grouping"
    - name: "cpt_code_status"
      expr: cpt_code_status
      comment: "Active/inactive status of the CPT code"
    - name: "global_period"
      expr: global_period
      comment: "Global surgery period (0, 10, 90 days, XXX) — determines bundled payment windows"
    - name: "telemedicine_eligible"
      expr: CAST(telemedicine_eligible AS STRING)
      comment: "Whether the code is eligible for telehealth delivery — critical for virtual care program planning"
    - name: "clinical_family"
      expr: clinical_family
      comment: "Clinical family grouping for related procedure analysis"
  measures:
    - name: "total_cpt_codes"
      expr: COUNT(1)
      comment: "Total CPT codes in the reference catalog"
    - name: "avg_total_rvu"
      expr: AVG(CAST(total_rvu AS DOUBLE))
      comment: "Average total RVU across CPT codes — benchmark for physician productivity and compensation modeling"
    - name: "avg_work_rvu"
      expr: AVG(CAST(work_rvu AS DOUBLE))
      comment: "Average work RVU component — reflects physician effort intensity for workforce planning"
    - name: "avg_national_payment"
      expr: AVG(CAST(national_payment_amount AS DOUBLE))
      comment: "Average national Medicare payment amount — baseline for payer contract negotiations"
    - name: "total_national_payment_capacity"
      expr: SUM(CAST(national_payment_amount AS DOUBLE))
      comment: "Sum of national payment amounts across all codes — theoretical maximum reimbursement capacity"
    - name: "telehealth_eligible_code_count"
      expr: COUNT(CASE WHEN telemedicine_eligible = TRUE THEN 1 END)
      comment: "Number of telehealth-eligible CPT codes — measures virtual care service breadth"
    - name: "avg_practice_expense_rvu"
      expr: AVG(CAST(practice_expense_rvu AS DOUBLE))
      comment: "Average practice expense RVU — informs overhead allocation and facility cost modeling"
    - name: "avg_malpractice_rvu"
      expr: AVG(CAST(malpractice_rvu AS DOUBLE))
      comment: "Average malpractice RVU — informs risk-based insurance cost allocation by specialty"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`reference_drg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for DRG (Diagnosis Related Group) analysis covering case mix index, length of stay benchmarks, and payment adequacy. Core to inpatient revenue management and operational efficiency."
  source: "`healthcare_ecm_v1`.`reference`.`drg`"
  dimensions:
    - name: "drg_type"
      expr: drg_type
      comment: "DRG classification system (MS-DRG, APR-DRG, AP-DRG) for grouper comparison"
    - name: "complication_level"
      expr: complication_level
      comment: "Severity/complication level (with CC, with MCC, without CC/MCC) — primary driver of payment variation"
    - name: "grouper_system"
      expr: grouper_system
      comment: "Grouper system version used for DRG assignment"
    - name: "clinical_family"
      expr: clinical_family
      comment: "Clinical family grouping for service line performance analysis"
    - name: "operating_room_procedure_flag"
      expr: CAST(operating_room_procedure_flag AS STRING)
      comment: "Whether the DRG involves OR procedures — distinguishes surgical from medical DRGs"
    - name: "quality_measure_flag"
      expr: CAST(quality_measure_flag AS STRING)
      comment: "Whether the DRG is subject to quality measurement programs"
    - name: "readmission_penalty_flag"
      expr: CAST(readmission_penalty_flag AS STRING)
      comment: "Whether the DRG is subject to CMS Hospital Readmissions Reduction Program penalties"
  measures:
    - name: "total_drg_codes"
      expr: COUNT(1)
      comment: "Total DRGs in the reference catalog"
    - name: "avg_relative_weight"
      expr: AVG(CAST(relative_weight AS DOUBLE))
      comment: "Average DRG relative weight — proxy for case mix index (CMI) which directly determines inpatient revenue"
    - name: "avg_geometric_mean_los"
      expr: AVG(CAST(geometric_mean_los AS DOUBLE))
      comment: "Average geometric mean length of stay — benchmark for operational efficiency and discharge planning"
    - name: "avg_arithmetic_mean_los"
      expr: AVG(CAST(arithmetic_mean_los AS DOUBLE))
      comment: "Average arithmetic mean LOS — includes outliers for capacity planning"
    - name: "avg_national_payment"
      expr: AVG(CAST(national_average_payment AS DOUBLE))
      comment: "Average national DRG payment — benchmark for contract adequacy assessment"
    - name: "avg_national_charges"
      expr: AVG(CAST(national_average_charges AS DOUBLE))
      comment: "Average national charges — informs charge-to-cost ratio and pricing strategy"
    - name: "readmission_penalty_drg_count"
      expr: COUNT(CASE WHEN readmission_penalty_flag = TRUE THEN 1 END)
      comment: "Count of DRGs subject to readmission penalties — quantifies financial risk exposure from CMS HRRP"
    - name: "avg_cost_outlier_threshold"
      expr: AVG(CAST(cost_outlier_threshold AS DOUBLE))
      comment: "Average cost outlier threshold — identifies high-cost case financial exposure"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`reference_crosswalk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for terminology crosswalk/mapping quality and coverage. Critical for interoperability, claims translation, and ensuring accurate code conversions between systems (e.g., ICD-9 to ICD-10, SNOMED to ICD)."
  source: "`healthcare_ecm_v1`.`reference`.`crosswalk`"
  dimensions:
    - name: "source_code_system"
      expr: source_code_system
      comment: "Source terminology system being mapped from"
    - name: "target_code_system"
      expr: target_code_system
      comment: "Target terminology system being mapped to"
    - name: "mapping_type"
      expr: mapping_type
      comment: "Type of mapping relationship (equivalent, broader, narrower, related)"
    - name: "mapping_quality"
      expr: mapping_quality
      comment: "Quality grade of the mapping (exact, approximate, partial)"
    - name: "directionality"
      expr: directionality
      comment: "Whether the mapping is unidirectional or bidirectional"
    - name: "mapping_authority"
      expr: mapping_authority
      comment: "Organization that authored/validated the mapping (NLM, CMS, WHO)"
    - name: "approximate_flag"
      expr: CAST(approximate_flag AS STRING)
      comment: "Whether the mapping is approximate — flags potential accuracy risk in automated translation"
    - name: "no_map_flag"
      expr: CAST(no_map_flag AS STRING)
      comment: "Whether the source code has no valid target — identifies terminology gaps"
  measures:
    - name: "total_crosswalk_mappings"
      expr: COUNT(1)
      comment: "Total terminology mappings available — measures interoperability infrastructure completeness"
    - name: "approximate_mapping_count"
      expr: COUNT(CASE WHEN approximate_flag = TRUE THEN 1 END)
      comment: "Count of approximate (non-exact) mappings — quantifies translation accuracy risk"
    - name: "no_map_count"
      expr: COUNT(CASE WHEN no_map_flag = TRUE THEN 1 END)
      comment: "Count of unmappable codes — identifies terminology gaps requiring manual review or clinical decision"
    - name: "total_usage_count"
      expr: SUM(CAST(usage_count AS BIGINT))
      comment: "Total usage frequency across all mappings — identifies high-traffic crosswalks requiring priority validation"
    - name: "avg_usage_count"
      expr: AVG(CAST(usage_count AS DOUBLE))
      comment: "Average usage per mapping — helps prioritize validation efforts on frequently-used translations"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`reference_ndc_drug`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for NDC drug catalog coverage, safety classification, and formulary readiness. Supports pharmacy operations, medication safety programs, and drug spend analytics."
  source: "`healthcare_ecm_v1`.`reference`.`ndc_drug`"
  dimensions:
    - name: "dosage_form"
      expr: dosage_form
      comment: "Drug dosage form (tablet, injection, solution, etc.) for administration route analysis"
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration for clinical pathway and cost analysis"
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA controlled substance schedule (I-V) — drives security, monitoring, and compliance requirements"
    - name: "therapeutic_class"
      expr: therapeutic_class
      comment: "Therapeutic classification for drug utilization review and formulary management"
    - name: "marketing_category"
      expr: marketing_category
      comment: "FDA marketing category (NDA, ANDA, BLA, OTC) indicating approval pathway"
    - name: "formulary_status"
      expr: formulary_status
      comment: "Current formulary inclusion status — drives prescribing behavior and cost management"
    - name: "pregnancy_category"
      expr: pregnancy_category
      comment: "FDA pregnancy risk category for patient safety screening"
    - name: "labeler_name"
      expr: labeler_name
      comment: "Drug manufacturer/labeler for supply chain and contract analysis"
  measures:
    - name: "total_ndc_drugs"
      expr: COUNT(1)
      comment: "Total NDC drug products in the reference catalog — measures formulary breadth"
    - name: "controlled_substance_count"
      expr: COUNT(CASE WHEN dea_schedule IS NOT NULL AND dea_schedule != '' THEN 1 END)
      comment: "Count of controlled substances — quantifies PDMP monitoring and vault storage requirements"
    - name: "black_box_warning_count"
      expr: COUNT(CASE WHEN black_box_warning_flag = TRUE THEN 1 END)
      comment: "Count of drugs with FDA black box warnings — measures high-risk medication exposure requiring enhanced monitoring"
    - name: "high_alert_medication_count"
      expr: COUNT(CASE WHEN high_alert_medication_flag = TRUE THEN 1 END)
      comment: "Count of ISMP high-alert medications — drives patient safety protocol requirements"
    - name: "biosimilar_count"
      expr: COUNT(CASE WHEN biosimilar_flag = TRUE THEN 1 END)
      comment: "Count of biosimilar products — measures cost-saving substitution opportunities for specialty drugs"
    - name: "vaccine_count"
      expr: COUNT(CASE WHEN vaccine_flag = TRUE THEN 1 END)
      comment: "Count of vaccine products — supports immunization program planning and inventory management"
    - name: "avg_package_quantity"
      expr: AVG(CAST(package_quantity AS DOUBLE))
      comment: "Average package quantity — informs inventory par level and dispensing workflow design"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`reference_geographic_region`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for geographic service area analysis covering population health indicators, socioeconomic factors, and network adequacy. Supports strategic planning, health equity initiatives, and regulatory compliance."
  source: "`healthcare_ecm_v1`.`reference`.`geographic_region`"
  dimensions:
    - name: "region_type"
      expr: region_type
      comment: "Geographic hierarchy level (state, county, ZIP, MSA, HRR, HSA) for multi-level analysis"
    - name: "urban_rural_classification"
      expr: urban_rural_classification
      comment: "Urban/rural designation — drives access-to-care analysis and telehealth strategy"
    - name: "census_region"
      expr: census_region
      comment: "US Census region for macro-level geographic trending"
    - name: "census_division"
      expr: census_division
      comment: "US Census division for regional benchmarking"
    - name: "state_abbreviation"
      expr: state_abbreviation
      comment: "State for regulatory jurisdiction and Medicaid program analysis"
    - name: "is_active"
      expr: CAST(is_active AS STRING)
      comment: "Whether the geographic region definition is currently active"
    - name: "aco_service_area_flag"
      expr: CAST(aco_service_area_flag AS STRING)
      comment: "Whether the region is designated as an ACO service area — relevant for value-based care attribution"
  measures:
    - name: "total_geographic_regions"
      expr: COUNT(1)
      comment: "Total geographic regions defined — measures service area coverage completeness"
    - name: "total_population_estimate"
      expr: SUM(CAST(population_estimate AS BIGINT))
      comment: "Total population across defined regions — baseline for market sizing and network adequacy"
    - name: "avg_median_household_income"
      expr: AVG(CAST(median_household_income AS DOUBLE))
      comment: "Average median household income — proxy for payer mix and financial assistance program demand"
    - name: "avg_poverty_rate"
      expr: AVG(CAST(poverty_rate_percent AS DOUBLE))
      comment: "Average poverty rate — drives health equity strategy and SDOH intervention targeting"
    - name: "avg_uninsured_rate"
      expr: AVG(CAST(uninsured_rate_percent AS DOUBLE))
      comment: "Average uninsured rate — informs charity care budgeting and Medicaid expansion impact analysis"
    - name: "aco_service_area_count"
      expr: COUNT(CASE WHEN aco_service_area_flag = TRUE THEN 1 END)
      comment: "Count of ACO-designated service areas — measures value-based care geographic footprint"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`reference_snomed_concept`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for SNOMED CT clinical terminology coverage, hierarchy depth, and EHR integration readiness. Supports clinical documentation quality, interoperability, and quality measure reporting."
  source: "`healthcare_ecm_v1`.`reference`.`snomed_concept`"
  dimensions:
    - name: "concept_class"
      expr: concept_class
      comment: "SNOMED concept class for semantic categorization"
    - name: "top_level_hierarchy"
      expr: top_level_hierarchy
      comment: "Top-level SNOMED hierarchy (Clinical Finding, Procedure, Body Structure, etc.)"
    - name: "semantic_tag"
      expr: semantic_tag
      comment: "Semantic tag indicating concept type (disorder, finding, procedure, substance)"
    - name: "concept_status"
      expr: concept_status
      comment: "Active/inactive status of the SNOMED concept"
    - name: "definition_status"
      expr: definition_status
      comment: "Whether the concept is fully defined or primitive — affects reasoning capability"
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Depth in the SNOMED hierarchy — deeper levels indicate more specific clinical concepts"
    - name: "is_ehr_preferred"
      expr: CAST(is_ehr_preferred AS STRING)
      comment: "Whether the concept is preferred for EHR pick-lists — drives clinical documentation usability"
  measures:
    - name: "total_snomed_concepts"
      expr: COUNT(1)
      comment: "Total SNOMED concepts in the reference catalog — measures clinical terminology breadth"
    - name: "ehr_preferred_concept_count"
      expr: COUNT(CASE WHEN is_ehr_preferred = TRUE THEN 1 END)
      comment: "Count of EHR-preferred concepts — measures clinical documentation pick-list coverage"
    - name: "leaf_concept_count"
      expr: COUNT(CASE WHEN is_leaf_concept = TRUE THEN 1 END)
      comment: "Count of leaf (most specific) concepts — indicates granularity available for precise clinical coding"
    - name: "reportable_concept_count"
      expr: COUNT(CASE WHEN is_reportable = TRUE THEN 1 END)
      comment: "Count of reportable concepts — measures public health surveillance and quality reporting readiness"
    - name: "active_concept_count"
      expr: COUNT(CASE WHEN concept_status = 'active' THEN 1 END)
      comment: "Count of active SNOMED concepts — monitors terminology currency for clinical systems"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`reference_hipaa_retention_annotations`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for HIPAA data retention policy coverage and governance compliance. Tracks annotation completeness across data domains to ensure regulatory retention requirements are properly configured for all PHI-containing tables."
  source: "`healthcare_ecm_v1`.`reference`.`reference_hipaa_retention_annotations`"
  dimensions:
    - name: "data_domain"
      expr: data_domain
      comment: "Healthcare data domain the retention annotation applies to"
    - name: "data_classification_level"
      expr: data_classification_level
      comment: "Data sensitivity classification (PHI, PII, de-identified, public)"
    - name: "annotation_status"
      expr: annotation_status
      comment: "Status of the retention annotation (active, draft, expired, under review)"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory body mandating the retention requirement (HHS, CMS, state)"
    - name: "phi_indicator"
      expr: CAST(phi_indicator AS STRING)
      comment: "Whether the annotated data contains Protected Health Information"
    - name: "purge_method"
      expr: purge_method
      comment: "Method for data purging at retention expiry (delete, anonymize, archive)"
    - name: "scd_type"
      expr: scd_type
      comment: "Slowly Changing Dimension type applied (Type 1, Type 2) — Databricks governance pattern"
    - name: "liquid_clustering_enabled"
      expr: CAST(liquid_clustering_enabled AS STRING)
      comment: "Whether liquid clustering is enabled — Databricks Delta optimization pattern"
  measures:
    - name: "total_retention_annotations"
      expr: COUNT(1)
      comment: "Total HIPAA retention annotations defined — measures governance policy coverage"
    - name: "phi_annotated_count"
      expr: COUNT(CASE WHEN phi_indicator = TRUE THEN 1 END)
      comment: "Count of annotations flagging PHI data — measures PHI governance coverage"
    - name: "pii_annotated_count"
      expr: COUNT(CASE WHEN pii_indicator = TRUE THEN 1 END)
      comment: "Count of annotations flagging PII data — measures identity data governance coverage"
    - name: "legal_hold_eligible_count"
      expr: COUNT(CASE WHEN legal_hold_eligible = TRUE THEN 1 END)
      comment: "Count of data categories eligible for legal hold — quantifies litigation risk exposure"
    - name: "encryption_required_count"
      expr: COUNT(CASE WHEN encryption_at_rest_required = TRUE THEN 1 END)
      comment: "Count of annotations requiring encryption at rest — measures security control coverage"
$$;