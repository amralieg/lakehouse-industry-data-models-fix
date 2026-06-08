-- Metric views for domain: reference | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 18:58:55

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`reference_code_set_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Governance and lifecycle metrics for medical code set versions. Tracks validation health, HIPAA compliance posture, and load pipeline reliability across all reference code sets managed in the system."
  source: "`healthcare_ecm`.`reference`.`code_set_version`"
  dimensions:
    - name: "code_set_name"
      expr: code_set_name
      comment: "Name of the medical code set (e.g., ICD-10-CM, CPT, SNOMED CT) — primary grouping for version governance reporting."
    - name: "code_set_type"
      expr: code_set_type
      comment: "Classification of the code set type (diagnosis, procedure, drug, lab, etc.) for cross-type governance analysis."
    - name: "version_status"
      expr: version_status
      comment: "Current lifecycle status of the version (active, superseded, retired) — critical for compliance and data currency tracking."
    - name: "validation_status"
      expr: validation_status
      comment: "Outcome of the validation pipeline for this version (passed, failed, pending) — drives data quality governance decisions."
    - name: "load_status"
      expr: load_status
      comment: "ETL load status for this code set version — used to monitor pipeline reliability and identify failed ingestions."
    - name: "is_hipaa_compliant"
      expr: is_hipaa_compliant
      comment: "Boolean flag indicating whether this code set version meets HIPAA compliance requirements — essential for regulatory reporting."
    - name: "source_authority"
      expr: source_authority
      comment: "Issuing authority for the code set (e.g., CMS, AMA, NLM) — used to segment governance metrics by authoritative source."
    - name: "compliance_year"
      expr: compliance_year
      comment: "Regulatory compliance year associated with this version — enables year-over-year compliance posture analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country for which this code set version applies — supports multi-national reference data governance."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of the version effective date — used to track cadence of code set updates and activation timelines."
    - name: "publication_date"
      expr: DATE_TRUNC('month', publication_date)
      comment: "Month the version was published by the source authority — used to measure lag between publication and activation."
  measures:
    - name: "total_code_set_versions"
      expr: COUNT(1)
      comment: "Total number of code set versions tracked in the system. Baseline measure for version inventory and governance coverage."
    - name: "hipaa_compliant_version_count"
      expr: COUNT(CASE WHEN is_hipaa_compliant = TRUE THEN 1 END)
      comment: "Number of code set versions that are HIPAA compliant. Directly informs regulatory compliance posture and audit readiness."
    - name: "non_compliant_version_count"
      expr: COUNT(CASE WHEN is_hipaa_compliant = FALSE THEN 1 END)
      comment: "Number of code set versions that are NOT HIPAA compliant. A non-zero value is an immediate compliance risk requiring remediation."
    - name: "validated_version_count"
      expr: COUNT(CASE WHEN validation_status = 'passed' THEN 1 END)
      comment: "Number of versions that have successfully passed validation. Measures data quality pipeline effectiveness."
    - name: "failed_validation_version_count"
      expr: COUNT(CASE WHEN validation_status = 'failed' THEN 1 END)
      comment: "Number of versions that failed validation. Triggers investigation and remediation by the data governance team."
    - name: "active_version_count"
      expr: COUNT(CASE WHEN version_status = 'active' THEN 1 END)
      comment: "Number of currently active code set versions. Measures breadth of live reference data available for clinical and billing operations."
    - name: "superseded_version_count"
      expr: COUNT(CASE WHEN version_status = 'superseded' THEN 1 END)
      comment: "Number of versions that have been superseded. High counts may indicate stale reference data still in use downstream."
    - name: "total_records_loaded"
      expr: SUM(CAST(record_count AS BIGINT))
      comment: "Total number of individual codes loaded across all versions. Measures the scale of reference data under management."
    - name: "avg_records_per_version"
      expr: AVG(CAST(record_count AS DOUBLE))
      comment: "Average number of codes per code set version. Helps identify unusually sparse or dense versions that may indicate load issues."
    - name: "distinct_code_set_names"
      expr: COUNT(DISTINCT code_set_name)
      comment: "Number of distinct medical code sets managed. Measures breadth of reference data coverage across the enterprise."
    - name: "distinct_source_authorities"
      expr: COUNT(DISTINCT source_authority)
      comment: "Number of distinct issuing authorities represented. Measures diversity of reference data sourcing and associated governance complexity."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`reference_cpt_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical and financial metrics for CPT procedure codes. Supports RVU-based physician compensation analysis, reimbursement benchmarking, telemedicine eligibility tracking, and procedure code lifecycle governance."
  source: "`healthcare_ecm`.`reference`.`cpt_code`"
  dimensions:
    - name: "cpt_code_category"
      expr: cpt_code_category
      comment: "High-level category of the CPT code (e.g., Evaluation & Management, Surgery, Radiology) — primary grouping for RVU and payment analysis."
    - name: "cpt_code_status"
      expr: cpt_code_status
      comment: "Lifecycle status of the CPT code (active, deleted, revised) — used to filter analyses to current, billable codes."
    - name: "section"
      expr: section
      comment: "CPT codebook section — enables section-level RVU and payment benchmarking."
    - name: "clinical_family"
      expr: clinical_family
      comment: "Clinical family grouping for the procedure — supports service-line level financial and utilization analysis."
    - name: "telemedicine_eligible"
      expr: telemedicine_eligible
      comment: "Boolean flag indicating telemedicine eligibility — critical for telehealth strategy and reimbursement planning."
    - name: "facility_indicator"
      expr: facility_indicator
      comment: "Indicates whether the code applies to facility or non-facility settings — affects payment rate calculations."
    - name: "gender_specific"
      expr: gender_specific
      comment: "Gender restriction for the procedure code — used in clinical appropriateness and equity analyses."
    - name: "global_period"
      expr: global_period
      comment: "Global surgery period (0, 10, 90 days, or MMM) — essential for bundled payment and post-operative care analysis."
    - name: "ncci_edit_indicator"
      expr: ncci_edit_indicator
      comment: "Boolean flag for NCCI (National Correct Coding Initiative) edit applicability — used in claims editing and compliance analysis."
    - name: "effective_date"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the CPT code became effective — used to track code set evolution and adoption of new procedures over time."
  measures:
    - name: "total_cpt_codes"
      expr: COUNT(1)
      comment: "Total number of CPT codes in the reference set. Baseline measure for code set completeness and coverage."
    - name: "active_cpt_code_count"
      expr: COUNT(CASE WHEN cpt_code_status = 'active' THEN 1 END)
      comment: "Number of currently active CPT codes. Measures the breadth of billable procedures available for clinical documentation and claims."
    - name: "telemedicine_eligible_code_count"
      expr: COUNT(CASE WHEN telemedicine_eligible = TRUE THEN 1 END)
      comment: "Number of CPT codes eligible for telemedicine billing. Directly informs telehealth program scope and reimbursement strategy."
    - name: "total_work_rvu"
      expr: SUM(CAST(work_rvu AS DOUBLE))
      comment: "Sum of physician work RVUs across all CPT codes. Foundation for physician compensation modeling and service-line workload analysis."
    - name: "avg_work_rvu"
      expr: AVG(CAST(work_rvu AS DOUBLE))
      comment: "Average physician work RVU per CPT code. Benchmarks procedure complexity and informs compensation equity analysis."
    - name: "total_practice_expense_rvu"
      expr: SUM(CAST(practice_expense_rvu AS DOUBLE))
      comment: "Sum of practice expense RVUs. Measures total overhead cost burden embedded in the CPT code set for financial planning."
    - name: "total_malpractice_rvu"
      expr: SUM(CAST(malpractice_rvu AS DOUBLE))
      comment: "Sum of malpractice RVUs across all CPT codes. Informs risk-adjusted compensation and malpractice insurance cost modeling."
    - name: "total_rvu_sum"
      expr: SUM(CAST(total_rvu AS DOUBLE))
      comment: "Sum of total RVUs (work + practice expense + malpractice) across all CPT codes. Primary driver of Medicare physician payment calculations."
    - name: "avg_total_rvu"
      expr: AVG(CAST(total_rvu AS DOUBLE))
      comment: "Average total RVU per CPT code. Used to benchmark procedure intensity and identify high-complexity service lines."
    - name: "total_national_payment_amount"
      expr: SUM(CAST(national_payment_amount AS DOUBLE))
      comment: "Sum of national payment amounts across CPT codes. Provides a macro view of total reimbursement potential in the code set."
    - name: "avg_national_payment_amount"
      expr: AVG(CAST(national_payment_amount AS DOUBLE))
      comment: "Average national payment amount per CPT code. Benchmarks reimbursement rates and supports contract negotiation analysis."
    - name: "avg_anesthesia_base_units"
      expr: AVG(CAST(anesthesia_base_units AS DOUBLE))
      comment: "Average anesthesia base units per CPT code. Used in anesthesia billing and OR scheduling resource planning."
    - name: "ncci_edit_code_count"
      expr: COUNT(CASE WHEN ncci_edit_indicator = TRUE THEN 1 END)
      comment: "Number of CPT codes subject to NCCI edits. High counts indicate claims editing complexity and compliance risk exposure."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`reference_drg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inpatient payment and case-mix metrics for Diagnosis Related Groups (DRGs). Supports hospital financial planning, readmission penalty risk assessment, bundled payment strategy, and length-of-stay benchmarking."
  source: "`healthcare_ecm`.`reference`.`drg`"
  dimensions:
    - name: "drg_type"
      expr: drg_type
      comment: "Type of DRG (medical, surgical, etc.) — primary grouping for inpatient case-mix and payment analysis."
    - name: "clinical_family"
      expr: clinical_family
      comment: "Clinical family or MDC (Major Diagnostic Category) for the DRG — enables service-line level financial benchmarking."
    - name: "complication_level"
      expr: complication_level
      comment: "Complication/comorbidity level (MCC, CC, no CC) — critical for case-mix index and severity-adjusted payment analysis."
    - name: "grouper_system"
      expr: grouper_system
      comment: "DRG grouper system (MS-DRG, APR-DRG, etc.) — used to segment metrics by payment methodology."
    - name: "readmission_penalty_flag"
      expr: readmission_penalty_flag
      comment: "Boolean flag indicating DRGs subject to CMS readmission penalties — directly informs quality improvement prioritization."
    - name: "bundled_payment_flag"
      expr: bundled_payment_flag
      comment: "Boolean flag for DRGs included in bundled payment programs — used to scope alternative payment model analysis."
    - name: "operating_room_procedure_flag"
      expr: operating_room_procedure_flag
      comment: "Boolean flag indicating whether the DRG requires an OR procedure — used in surgical volume and OR capacity planning."
    - name: "post_acute_transfer_flag"
      expr: post_acute_transfer_flag
      comment: "Boolean flag for DRGs subject to post-acute transfer payment rules — informs care transition and SNF/IRF strategy."
    - name: "quality_measure_flag"
      expr: quality_measure_flag
      comment: "Boolean flag indicating DRGs tied to quality measures — used to prioritize quality improvement investments."
    - name: "effective_date"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the DRG definition became effective — used to track DRG evolution and year-over-year payment rate changes."
  measures:
    - name: "total_drg_codes"
      expr: COUNT(1)
      comment: "Total number of DRG codes in the reference set. Baseline measure for inpatient payment classification coverage."
    - name: "readmission_penalty_drg_count"
      expr: COUNT(CASE WHEN readmission_penalty_flag = TRUE THEN 1 END)
      comment: "Number of DRGs subject to CMS readmission penalties. Directly quantifies the scope of readmission penalty risk exposure for hospital leadership."
    - name: "bundled_payment_drg_count"
      expr: COUNT(CASE WHEN bundled_payment_flag = TRUE THEN 1 END)
      comment: "Number of DRGs included in bundled payment programs. Measures the scope of alternative payment model exposure and opportunity."
    - name: "avg_relative_weight"
      expr: AVG(CAST(relative_weight AS DOUBLE))
      comment: "Average DRG relative weight. The primary driver of inpatient payment — higher values indicate more resource-intensive cases and higher reimbursement."
    - name: "total_relative_weight"
      expr: SUM(CAST(relative_weight AS DOUBLE))
      comment: "Sum of DRG relative weights. Represents the aggregate case-mix weight of the DRG portfolio — used to compute case-mix index."
    - name: "avg_arithmetic_mean_los"
      expr: AVG(CAST(arithmetic_mean_los AS DOUBLE))
      comment: "Average arithmetic mean length of stay across DRGs. Benchmarks expected inpatient duration for capacity planning and efficiency analysis."
    - name: "avg_geometric_mean_los"
      expr: AVG(CAST(geometric_mean_los AS DOUBLE))
      comment: "Average geometric mean length of stay across DRGs. CMS uses geometric mean LOS for outlier payment thresholds — critical for financial risk modeling."
    - name: "avg_national_average_payment"
      expr: AVG(CAST(national_average_payment AS DOUBLE))
      comment: "Average national payment amount per DRG. Benchmarks reimbursement rates against national norms for contract and payer strategy."
    - name: "total_national_average_payment"
      expr: SUM(CAST(national_average_payment AS DOUBLE))
      comment: "Sum of national average payments across all DRGs. Provides a macro view of total inpatient reimbursement potential in the reference set."
    - name: "avg_cost_outlier_threshold"
      expr: AVG(CAST(cost_outlier_threshold AS DOUBLE))
      comment: "Average cost outlier threshold across DRGs. Informs financial risk management — cases exceeding this threshold qualify for additional outlier payments."
    - name: "or_procedure_drg_count"
      expr: COUNT(CASE WHEN operating_room_procedure_flag = TRUE THEN 1 END)
      comment: "Number of DRGs requiring OR procedures. Used in surgical volume forecasting and OR capacity planning."
    - name: "quality_measure_drg_count"
      expr: COUNT(CASE WHEN quality_measure_flag = TRUE THEN 1 END)
      comment: "Number of DRGs tied to quality measures. Scopes the quality improvement investment required to protect value-based payment performance."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`reference_icd_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical coding quality and compliance metrics for ICD diagnosis and procedure codes. Supports coding completeness governance, HAC/MCC/CC risk stratification, and code set lifecycle management."
  source: "`healthcare_ecm`.`reference`.`icd_code`"
  dimensions:
    - name: "code_type"
      expr: code_type
      comment: "ICD code type (ICD-10-CM diagnosis, ICD-10-PCS procedure, ICD-9, etc.) — primary grouping for coding governance analysis."
    - name: "icd_code_category"
      expr: icd_code_category
      comment: "High-level ICD category — used to segment coding metrics by clinical domain (e.g., neoplasms, circulatory, respiratory)."
    - name: "chapter"
      expr: chapter
      comment: "ICD codebook chapter — enables chapter-level analysis of code set composition and clinical coverage."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Boolean flag indicating whether the code is billable (leaf-level, valid for claims submission) — critical for coding compliance."
    - name: "valid_for_coding_flag"
      expr: valid_for_coding_flag
      comment: "Boolean flag indicating the code is valid for current coding use — used to filter analyses to actionable codes."
    - name: "mcc_flag"
      expr: mcc_flag
      comment: "Boolean flag for Major Complication or Comorbidity designation — directly impacts DRG assignment and inpatient payment."
    - name: "cc_flag"
      expr: cc_flag
      comment: "Boolean flag for Complication or Comorbidity designation — impacts DRG severity level and reimbursement."
    - name: "hac_flag"
      expr: hac_flag
      comment: "Boolean flag for Hospital-Acquired Condition designation — critical for quality and payment penalty risk management."
    - name: "poa_exempt_flag"
      expr: poa_exempt_flag
      comment: "Boolean flag for Present on Admission exemption — used in HAC payment adjustment and quality reporting analysis."
    - name: "gender_specific_flag"
      expr: gender_specific_flag
      comment: "Gender restriction for the ICD code — used in clinical appropriateness audits and equity analyses."
    - name: "effective_date"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the ICD code became effective — tracks code set evolution and adoption of new clinical concepts."
  measures:
    - name: "total_icd_codes"
      expr: COUNT(1)
      comment: "Total number of ICD codes in the reference set. Baseline measure for clinical coding coverage and code set completeness."
    - name: "billable_code_count"
      expr: COUNT(CASE WHEN billable_flag = TRUE THEN 1 END)
      comment: "Number of billable ICD codes. Measures the scope of codes valid for claims submission — directly impacts revenue cycle completeness."
    - name: "valid_for_coding_count"
      expr: COUNT(CASE WHEN valid_for_coding_flag = TRUE THEN 1 END)
      comment: "Number of ICD codes currently valid for coding. Ensures coding staff and systems are working from a current, compliant code set."
    - name: "mcc_code_count"
      expr: COUNT(CASE WHEN mcc_flag = TRUE THEN 1 END)
      comment: "Number of ICD codes designated as Major Complications or Comorbidities. Scopes the MCC capture opportunity for DRG optimization and accurate severity reporting."
    - name: "cc_code_count"
      expr: COUNT(CASE WHEN cc_flag = TRUE THEN 1 END)
      comment: "Number of ICD codes designated as Complications or Comorbidities. Measures CC capture opportunity for DRG severity and payment accuracy."
    - name: "hac_code_count"
      expr: COUNT(CASE WHEN hac_flag = TRUE THEN 1 END)
      comment: "Number of ICD codes designated as Hospital-Acquired Conditions. Quantifies HAC risk exposure — a key quality and payment penalty metric."
    - name: "poa_exempt_code_count"
      expr: COUNT(CASE WHEN poa_exempt_flag = TRUE THEN 1 END)
      comment: "Number of ICD codes exempt from Present on Admission reporting. Used in HAC payment adjustment analysis and compliance planning."
    - name: "distinct_chapters"
      expr: COUNT(DISTINCT chapter)
      comment: "Number of distinct ICD chapters represented. Measures clinical breadth of the code set and completeness of coverage across disease domains."
    - name: "codes_with_snomed_mapping_count"
      expr: COUNT(CASE WHEN snomed_ct_mapping IS NOT NULL THEN 1 END)
      comment: "Number of ICD codes with a SNOMED CT mapping. Measures interoperability readiness for FHIR-based and clinical terminology exchange use cases."
    - name: "replacement_code_count"
      expr: COUNT(CASE WHEN replacement_code IS NOT NULL THEN 1 END)
      comment: "Number of ICD codes that have a designated replacement code. Identifies deprecated codes requiring migration — critical for coding system upgrade planning."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`reference_ndc_drug`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug formulary, safety, and regulatory metrics for NDC drug codes. Supports pharmacy formulary management, controlled substance oversight, high-alert medication safety governance, and drug lifecycle tracking."
  source: "`healthcare_ecm`.`reference`.`ndc_drug`"
  dimensions:
    - name: "therapeutic_class"
      expr: therapeutic_class
      comment: "Therapeutic class of the drug — primary grouping for formulary analysis, utilization management, and cost benchmarking."
    - name: "dosage_form"
      expr: dosage_form
      comment: "Drug dosage form (tablet, injection, solution, etc.) — used in pharmacy operations and formulary design analysis."
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration (oral, IV, topical, etc.) — used in clinical safety and formulary management analysis."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA controlled substance schedule (I-V) — critical for controlled substance compliance and diversion risk management."
    - name: "marketing_category"
      expr: marketing_category
      comment: "FDA marketing category (NDA, ANDA, BLA, OTC, etc.) — used to segment drug portfolio by regulatory approval pathway."
    - name: "formulary_status"
      expr: formulary_status
      comment: "Formulary tier or status of the drug — directly informs pharmacy benefit design and cost management decisions."
    - name: "vaccine_flag"
      expr: vaccine_flag
      comment: "Boolean flag identifying vaccine products — used to scope immunization program analytics and supply planning."
    - name: "black_box_warning_flag"
      expr: black_box_warning_flag
      comment: "Boolean flag for FDA black box warning — critical for medication safety governance and prescribing oversight."
    - name: "high_alert_medication_flag"
      expr: high_alert_medication_flag
      comment: "Boolean flag for high-alert medications (ISMP designation) — used in patient safety program scoping and error prevention initiatives."
    - name: "over_the_counter_flag"
      expr: over_the_counter_flag
      comment: "Boolean flag for OTC drugs — used to segment prescription vs. OTC formulary and benefit design analysis."
    - name: "biosimilar_flag"
      expr: biosimilar_flag
      comment: "Boolean flag for biosimilar products — used in specialty pharmacy cost management and biosimilar substitution strategy."
    - name: "effective_date"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the NDC drug record became effective — used to track drug portfolio evolution and new product introductions."
  measures:
    - name: "total_ndc_drugs"
      expr: COUNT(1)
      comment: "Total number of NDC drug records in the reference set. Baseline measure for drug formulary and reference data coverage."
    - name: "black_box_warning_drug_count"
      expr: COUNT(CASE WHEN black_box_warning_flag = TRUE THEN 1 END)
      comment: "Number of drugs with FDA black box warnings. Quantifies high-risk drug exposure in the formulary — a key patient safety governance metric."
    - name: "high_alert_medication_count"
      expr: COUNT(CASE WHEN high_alert_medication_flag = TRUE THEN 1 END)
      comment: "Number of high-alert medications (ISMP list). Scopes the patient safety program investment required for medication error prevention."
    - name: "controlled_substance_count"
      expr: COUNT(CASE WHEN dea_schedule IS NOT NULL THEN 1 END)
      comment: "Number of controlled substances in the drug reference. Measures the scope of DEA compliance and diversion monitoring requirements."
    - name: "biosimilar_drug_count"
      expr: COUNT(CASE WHEN biosimilar_flag = TRUE THEN 1 END)
      comment: "Number of biosimilar products in the reference set. Informs specialty pharmacy cost reduction strategy and biosimilar substitution program scope."
    - name: "vaccine_count"
      expr: COUNT(CASE WHEN vaccine_flag = TRUE THEN 1 END)
      comment: "Number of vaccine products in the reference set. Used to scope immunization program coverage and supply chain planning."
    - name: "refrigeration_required_drug_count"
      expr: COUNT(CASE WHEN refrigeration_required_flag = TRUE THEN 1 END)
      comment: "Number of drugs requiring refrigeration. Directly informs cold chain logistics investment and pharmacy storage capacity planning."
    - name: "distinct_therapeutic_classes"
      expr: COUNT(DISTINCT therapeutic_class)
      comment: "Number of distinct therapeutic classes in the drug reference. Measures formulary breadth and clinical coverage across disease states."
    - name: "avg_package_quantity"
      expr: AVG(CAST(package_quantity AS DOUBLE))
      comment: "Average package quantity per NDC drug record. Used in pharmacy dispensing operations and unit-of-use cost analysis."
    - name: "distinct_labelers"
      expr: COUNT(DISTINCT labeler_name)
      comment: "Number of distinct drug manufacturers/labelers in the reference set. Measures supplier diversity and informs pharmaceutical supply chain risk management."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`reference_npi_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider network and credentialing metrics derived from the NPI Registry. Supports provider network adequacy analysis, credentialing governance, taxonomy-based specialty mix reporting, and provider directory accuracy management."
  source: "`healthcare_ecm`.`reference`.`npi_registry`"
  dimensions:
    - name: "entity_type_code"
      expr: entity_type_code
      comment: "NPI entity type (1=Individual provider, 2=Organization) — primary grouping for provider network analysis."
    - name: "primary_taxonomy_code"
      expr: primary_taxonomy_code
      comment: "Provider primary taxonomy/specialty code — used for specialty mix, network adequacy, and credentialing analysis."
    - name: "mailing_address_state"
      expr: mailing_address_state
      comment: "State of the provider mailing address — used for geographic network adequacy and state-level regulatory reporting."
    - name: "provider_gender_code"
      expr: provider_gender_code
      comment: "Provider gender code — used in workforce diversity and equity reporting."
    - name: "enumeration_date"
      expr: DATE_TRUNC('year', enumeration_date)
      comment: "Year the NPI was enumerated (assigned) — used to track provider network growth and credentialing pipeline trends."
    - name: "deactivation_date"
      expr: DATE_TRUNC('year', deactivation_date)
      comment: "Year the NPI was deactivated — used to monitor provider attrition and network shrinkage trends."
    - name: "last_update_date"
      expr: DATE_TRUNC('month', last_update_date)
      comment: "Month of the most recent NPI record update — used to assess provider directory data currency and staleness."
  measures:
    - name: "total_npi_records"
      expr: COUNT(1)
      comment: "Total number of NPI registry records. Baseline measure for provider network size and directory coverage."
    - name: "individual_provider_count"
      expr: COUNT(CASE WHEN entity_type_code = '1' THEN 1 END)
      comment: "Number of individual (Type 1) NPI providers. Measures the size of the individual clinician network — key for network adequacy reporting."
    - name: "organization_provider_count"
      expr: COUNT(CASE WHEN entity_type_code = '2' THEN 1 END)
      comment: "Number of organizational (Type 2) NPI providers. Measures the scope of facility and group practice network coverage."
    - name: "deactivated_npi_count"
      expr: COUNT(CASE WHEN deactivation_date IS NOT NULL THEN 1 END)
      comment: "Number of deactivated NPI records. Measures provider attrition and identifies stale directory records requiring cleanup."
    - name: "active_npi_count"
      expr: COUNT(CASE WHEN deactivation_date IS NULL THEN 1 END)
      comment: "Number of active (non-deactivated) NPI records. Measures the current active provider network size for adequacy and access analysis."
    - name: "distinct_taxonomy_codes"
      expr: COUNT(DISTINCT primary_taxonomy_code)
      comment: "Number of distinct provider taxonomy/specialty codes represented. Measures specialty breadth and network diversity for adequacy assessment."
    - name: "distinct_states_covered"
      expr: COUNT(DISTINCT mailing_address_state)
      comment: "Number of distinct states with NPI-registered providers. Measures geographic network coverage and identifies potential access gaps."
    - name: "reactivated_provider_count"
      expr: COUNT(CASE WHEN reactivation_date IS NOT NULL THEN 1 END)
      comment: "Number of providers who have been reactivated after deactivation. Monitors provider re-credentialing activity and network recovery trends."
    - name: "distinct_npi_count"
      expr: COUNT(DISTINCT npi)
      comment: "Count of distinct NPI numbers. Validates uniqueness of the provider registry and detects potential duplicate NPI records."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`reference_crosswalk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Code mapping quality and interoperability metrics for clinical terminology crosswalks. Supports mapping coverage governance, translation quality assurance, and cross-terminology interoperability program management."
  source: "`healthcare_ecm`.`reference`.`crosswalk`"
  dimensions:
    - name: "mapping_type"
      expr: mapping_type
      comment: "Type of code mapping (e.g., ICD-10 to SNOMED, CPT to HCPCS) — primary grouping for interoperability coverage analysis."
    - name: "source_code_system"
      expr: source_code_system
      comment: "Source terminology system for the mapping — used to analyze mapping coverage by originating code system."
    - name: "target_code_system"
      expr: target_code_system
      comment: "Target terminology system for the mapping — used to analyze translation completeness by destination system."
    - name: "mapping_quality"
      expr: mapping_quality
      comment: "Quality rating of the mapping (exact, broad, narrow, related) — critical for assessing translation fidelity and clinical safety."
    - name: "mapping_authority"
      expr: mapping_authority
      comment: "Organization responsible for the mapping (e.g., NLM, CMS, WHO) — used to segment mappings by authoritative source."
    - name: "directionality"
      expr: directionality
      comment: "Mapping directionality (unidirectional, bidirectional) — used in interoperability design and translation pipeline planning."
    - name: "no_map_flag"
      expr: no_map_flag
      comment: "Boolean flag indicating no valid mapping exists for the source code — identifies gaps in cross-terminology coverage."
    - name: "approximate_flag"
      expr: approximate_flag
      comment: "Boolean flag indicating the mapping is approximate rather than exact — used to quantify translation fidelity risk."
    - name: "combination_flag"
      expr: combination_flag
      comment: "Boolean flag indicating the mapping requires a combination of target codes — used in complex translation scenario analysis."
    - name: "effective_date"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the crosswalk mapping became effective — used to track mapping set evolution and update cadence."
  measures:
    - name: "total_crosswalk_mappings"
      expr: COUNT(1)
      comment: "Total number of crosswalk mapping records. Baseline measure for cross-terminology translation coverage."
    - name: "no_map_count"
      expr: COUNT(CASE WHEN no_map_flag = TRUE THEN 1 END)
      comment: "Number of source codes with no valid mapping to the target system. Quantifies interoperability gaps — a key metric for terminology governance and FHIR readiness."
    - name: "approximate_mapping_count"
      expr: COUNT(CASE WHEN approximate_flag = TRUE THEN 1 END)
      comment: "Number of approximate (non-exact) mappings. Measures translation fidelity risk — high counts indicate potential clinical data quality issues in cross-system exchanges."
    - name: "combination_mapping_count"
      expr: COUNT(CASE WHEN combination_flag = TRUE THEN 1 END)
      comment: "Number of mappings requiring a combination of target codes. Measures translation complexity and implementation effort for interoperability pipelines."
    - name: "total_usage_count"
      expr: SUM(CAST(usage_count AS BIGINT))
      comment: "Sum of usage counts across all crosswalk mappings. Measures the operational volume of cross-terminology translations — identifies high-traffic mappings requiring quality prioritization."
    - name: "avg_usage_count"
      expr: AVG(CAST(usage_count AS DOUBLE))
      comment: "Average usage count per crosswalk mapping. Identifies underutilized mappings that may be candidates for retirement or consolidation."
    - name: "distinct_source_code_systems"
      expr: COUNT(DISTINCT source_code_system)
      comment: "Number of distinct source terminology systems covered by crosswalks. Measures the breadth of interoperability coverage across the enterprise."
    - name: "distinct_target_code_systems"
      expr: COUNT(DISTINCT target_code_system)
      comment: "Number of distinct target terminology systems supported. Measures the reach of the translation layer and downstream system integration coverage."
    - name: "validated_mapping_count"
      expr: COUNT(CASE WHEN validated_by IS NOT NULL THEN 1 END)
      comment: "Number of mappings that have been formally validated. Measures the proportion of the crosswalk set with quality assurance sign-off — critical for clinical safety governance."
    - name: "distinct_mapping_types"
      expr: COUNT(DISTINCT mapping_type)
      comment: "Number of distinct mapping type pairs supported. Measures the diversity of cross-terminology translation capabilities available in the enterprise."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`reference_snomed_concept`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical ontology health and interoperability metrics for SNOMED CT concepts. Supports clinical terminology governance, EHR integration readiness, cross-terminology mapping coverage, and ontology quality management."
  source: "`healthcare_ecm`.`reference`.`snomed_concept`"
  dimensions:
    - name: "concept_class"
      expr: concept_class
      comment: "SNOMED CT concept class (Clinical Finding, Procedure, Observable Entity, etc.) — primary grouping for ontology coverage analysis."
    - name: "concept_status"
      expr: concept_status
      comment: "Lifecycle status of the SNOMED concept (active, inactive, retired) — used to filter analyses to current, usable concepts."
    - name: "top_level_hierarchy"
      expr: top_level_hierarchy
      comment: "Top-level SNOMED hierarchy (e.g., Clinical Finding, Body Structure, Substance) — used for domain-level ontology coverage reporting."
    - name: "semantic_tag"
      expr: semantic_tag
      comment: "SNOMED semantic tag indicating the concept type — used for fine-grained ontology composition analysis."
    - name: "is_ehr_preferred"
      expr: is_ehr_preferred
      comment: "Boolean flag indicating EHR-preferred concepts — used to scope clinical documentation and interface terminology governance."
    - name: "is_reportable"
      expr: is_reportable
      comment: "Boolean flag for reportable concepts — used to scope public health reporting and quality measure analysis."
    - name: "is_primitive"
      expr: is_primitive
      comment: "Boolean flag for primitive (vs. fully defined) concepts — used in ontology quality and completeness analysis."
    - name: "is_leaf_concept"
      expr: is_leaf_concept
      comment: "Boolean flag for leaf-level concepts (no children) — used in coding specificity and granularity analysis."
    - name: "effective_time"
      expr: DATE_TRUNC('year', effective_time)
      comment: "Year the SNOMED concept became effective — used to track ontology evolution and new concept introduction rates."
  measures:
    - name: "total_snomed_concepts"
      expr: COUNT(1)
      comment: "Total number of SNOMED CT concepts in the reference set. Baseline measure for clinical ontology coverage and terminology completeness."
    - name: "ehr_preferred_concept_count"
      expr: COUNT(CASE WHEN is_ehr_preferred = TRUE THEN 1 END)
      comment: "Number of EHR-preferred SNOMED concepts. Scopes the interface terminology layer — directly informs clinical documentation standardization and EHR configuration."
    - name: "reportable_concept_count"
      expr: COUNT(CASE WHEN is_reportable = TRUE THEN 1 END)
      comment: "Number of reportable SNOMED concepts. Measures the scope of public health and quality measure reporting coverage in the terminology."
    - name: "concepts_with_icd10_mapping_count"
      expr: COUNT(CASE WHEN icd10_map_target IS NOT NULL THEN 1 END)
      comment: "Number of SNOMED concepts with an ICD-10 mapping. Measures cross-terminology translation coverage — critical for billing, reporting, and FHIR interoperability."
    - name: "concepts_with_loinc_mapping_count"
      expr: COUNT(CASE WHEN loinc_map_target IS NOT NULL THEN 1 END)
      comment: "Number of SNOMED concepts with a LOINC mapping. Measures lab and observation interoperability coverage between clinical and diagnostic terminologies."
    - name: "concepts_with_rxnorm_mapping_count"
      expr: COUNT(CASE WHEN rxnorm_map_target IS NOT NULL THEN 1 END)
      comment: "Number of SNOMED concepts with an RxNorm mapping. Measures medication terminology interoperability coverage for pharmacy and prescribing workflows."
    - name: "concepts_with_cpt_mapping_count"
      expr: COUNT(CASE WHEN cpt_map_target IS NOT NULL THEN 1 END)
      comment: "Number of SNOMED concepts with a CPT mapping. Measures procedure terminology interoperability coverage for clinical-to-billing translation."
    - name: "leaf_concept_count"
      expr: COUNT(CASE WHEN is_leaf_concept = TRUE THEN 1 END)
      comment: "Number of leaf-level SNOMED concepts. Measures coding specificity available in the ontology — higher leaf counts indicate greater clinical granularity."
    - name: "distinct_top_level_hierarchies"
      expr: COUNT(DISTINCT top_level_hierarchy)
      comment: "Number of distinct top-level SNOMED hierarchies represented. Measures the clinical domain breadth of the terminology coverage."
    - name: "distinct_concept_classes"
      expr: COUNT(DISTINCT concept_class)
      comment: "Number of distinct SNOMED concept classes. Measures ontology diversity and completeness across clinical concept types."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`reference_loinc_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory and clinical observation metrics for LOINC codes. Supports lab test catalog governance, order/observation coverage analysis, panel completeness tracking, and clinical interoperability readiness assessment."
  source: "`healthcare_ecm`.`reference`.`loinc_code`"
  dimensions:
    - name: "loinc_class"
      expr: class
      comment: "LOINC class (e.g., CHEM, HEM/BC, MICRO, SERO) — primary grouping for lab test catalog analysis by clinical discipline."
    - name: "order_observation_flag"
      expr: order_observation_flag
      comment: "Indicates whether the LOINC is an order, observation, or both — used to segment the catalog for LIS/EHR integration analysis."
    - name: "scale_type"
      expr: scale_type
      comment: "LOINC scale type (Quantitative, Ordinal, Nominal, Narrative) — used in result type analysis and interface design."
    - name: "method_type"
      expr: method_type
      comment: "Measurement method for the LOINC observation — used in lab standardization and method harmonization analysis."
    - name: "panel_type"
      expr: panel_type
      comment: "Panel type designation — used to identify and analyze LOINC panels vs. individual test codes."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag for active LOINC codes — used to filter analyses to current, usable codes."
    - name: "time_aspect"
      expr: time_aspect
      comment: "LOINC time aspect (point in time, 24-hour, etc.) — used in clinical observation design and result interpretation analysis."
    - name: "effective_date"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the LOINC code became effective — used to track catalog evolution and new test introduction rates."
  measures:
    - name: "total_loinc_codes"
      expr: COUNT(1)
      comment: "Total number of LOINC codes in the reference set. Baseline measure for lab and clinical observation catalog coverage."
    - name: "active_loinc_code_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of active LOINC codes. Measures the operational scope of the lab and observation catalog available for LIS/EHR integration."
    - name: "deprecated_loinc_code_count"
      expr: COUNT(CASE WHEN deprecated_date IS NOT NULL THEN 1 END)
      comment: "Number of deprecated LOINC codes. Identifies stale codes that may still be in use in downstream systems — a key data quality governance metric."
    - name: "distinct_loinc_classes"
      expr: COUNT(DISTINCT class)
      comment: "Number of distinct LOINC classes represented. Measures the clinical breadth of the lab and observation catalog."
    - name: "distinct_method_types"
      expr: COUNT(DISTINCT method_type)
      comment: "Number of distinct measurement methods in the LOINC catalog. Measures method diversity and informs lab standardization program scope."
    - name: "codes_with_consumer_name_count"
      expr: COUNT(CASE WHEN consumer_name IS NOT NULL THEN 1 END)
      comment: "Number of LOINC codes with a patient-friendly consumer name. Measures patient engagement readiness — critical for patient portal and health literacy initiatives."
    - name: "codes_with_example_units_count"
      expr: COUNT(CASE WHEN example_ucum_units IS NOT NULL THEN 1 END)
      comment: "Number of LOINC codes with UCUM unit examples. Measures result standardization coverage — essential for interoperability and clinical decision support."
    - name: "distinct_scale_types"
      expr: COUNT(DISTINCT scale_type)
      comment: "Number of distinct LOINC scale types in the catalog. Measures result type diversity and informs interface engine and CDS configuration complexity."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`reference_hcpcs_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outpatient and ancillary service payment metrics for HCPCS codes. Supports DME coverage governance, drug billing compliance, prior authorization burden analysis, and outpatient payment policy management."
  source: "`healthcare_ecm`.`reference`.`hcpcs_code`"
  dimensions:
    - name: "hcpcs_code_category"
      expr: hcpcs_code_category
      comment: "HCPCS code category (Level I CPT, Level II A-V series) — primary grouping for outpatient payment analysis."
    - name: "code_type"
      expr: code_type
      comment: "HCPCS code type classification — used to segment the code set by service type for payment and coverage analysis."
    - name: "dme_indicator"
      expr: dme_indicator
      comment: "Boolean flag for Durable Medical Equipment codes — used to scope DME benefit and coverage analysis."
    - name: "drug_indicator"
      expr: drug_indicator
      comment: "Boolean flag for drug-related HCPCS codes — used in Part B drug billing and reimbursement analysis."
    - name: "prior_authorization_indicator"
      expr: prior_authorization_indicator
      comment: "Boolean flag for codes requiring prior authorization — used to quantify PA burden and inform utilization management policy."
    - name: "coverage_indicator"
      expr: coverage_indicator
      comment: "Medicare coverage indicator for the HCPCS code — used in coverage policy and claims editing analysis."
    - name: "global_period"
      expr: global_period
      comment: "Global surgery period for the HCPCS code — used in bundled payment and post-operative care analysis."
    - name: "ndc_crosswalk_indicator"
      expr: ndc_crosswalk_indicator
      comment: "Boolean flag indicating an NDC crosswalk exists for this HCPCS code — used in drug billing compliance and crosswalk coverage analysis."
    - name: "effective_date"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the HCPCS code became effective — used to track code set evolution and new service introduction rates."
  measures:
    - name: "total_hcpcs_codes"
      expr: COUNT(1)
      comment: "Total number of HCPCS codes in the reference set. Baseline measure for outpatient and ancillary service code coverage."
    - name: "dme_code_count"
      expr: COUNT(CASE WHEN dme_indicator = TRUE THEN 1 END)
      comment: "Number of DME HCPCS codes. Measures the scope of durable medical equipment coverage — informs DME benefit design and supplier contracting."
    - name: "drug_code_count"
      expr: COUNT(CASE WHEN drug_indicator = TRUE THEN 1 END)
      comment: "Number of drug-related HCPCS codes. Measures Part B drug billing scope — critical for outpatient pharmacy and infusion center financial planning."
    - name: "prior_auth_required_count"
      expr: COUNT(CASE WHEN prior_authorization_indicator = TRUE THEN 1 END)
      comment: "Number of HCPCS codes requiring prior authorization. Quantifies PA administrative burden — informs utilization management staffing and policy decisions."
    - name: "ndc_crosswalk_available_count"
      expr: COUNT(CASE WHEN ndc_crosswalk_indicator = TRUE THEN 1 END)
      comment: "Number of HCPCS codes with an NDC crosswalk. Measures drug billing compliance readiness — CMS requires NDC reporting for many Part B drugs."
    - name: "modifier_required_count"
      expr: COUNT(CASE WHEN modifier_required_indicator = TRUE THEN 1 END)
      comment: "Number of HCPCS codes requiring a modifier for billing. Measures claims complexity and coding compliance risk in outpatient billing operations."
    - name: "avg_intraoperative_percentage"
      expr: AVG(CAST(intraoperative_percentage AS DOUBLE))
      comment: "Average intraoperative work percentage across HCPCS codes. Used in surgical service line payment analysis and global period policy review."
    - name: "avg_preoperative_percentage"
      expr: AVG(CAST(preoperative_percentage AS DOUBLE))
      comment: "Average preoperative work percentage across HCPCS codes. Used in surgical payment policy analysis and care coordination planning."
    - name: "avg_postoperative_percentage"
      expr: AVG(CAST(postoperative_percentage AS DOUBLE))
      comment: "Average postoperative work percentage across HCPCS codes. Used in post-surgical care planning and global period payment analysis."
    - name: "distinct_code_types"
      expr: COUNT(DISTINCT code_type)
      comment: "Number of distinct HCPCS code types in the reference set. Measures the diversity of outpatient service classifications under management."
$$;