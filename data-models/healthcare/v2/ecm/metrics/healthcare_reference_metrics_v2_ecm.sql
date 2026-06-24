-- Metric views for domain: reference | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 14:47:42

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_code_set_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Governance KPIs over reference code set versions: load health, HIPAA compliance posture, and validation status across terminology releases. Used by data governance / reference data stewards to ensure code sets are current, validated, and compliant."
  source: "`vibe_healthcare_v1`.`reference`.`code_set_version`"
  dimensions:
    - name: "code_set_name"
      expr: code_set_name
      comment: "Name of the reference code set (e.g. ICD-10, CPT) for grouping governance metrics by terminology."
    - name: "code_set_type"
      expr: code_set_type
      comment: "Type/category of the code set, used to segment governance reporting by classification family."
    - name: "version_status"
      expr: version_status
      comment: "Lifecycle status of the version (active, retired, draft) to track release pipeline state."
    - name: "load_status"
      expr: load_status
      comment: "ETL load outcome status, used to monitor reference data ingestion reliability."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation outcome of the version, central to data quality steering."
    - name: "compliance_year"
      expr: compliance_year
      comment: "Compliance/reporting year the version applies to, for year-over-year reference currency tracking."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Effective month of the version for trending releases over time."
  measures:
    - name: "Version Count"
      expr: COUNT(1)
      comment: "Total number of code set versions tracked, baseline for governance coverage."
    - name: "Distinct Code Sets"
      expr: COUNT(DISTINCT code_set_name)
      comment: "Number of distinct reference code sets under management, indicating terminology breadth."
    - name: "HIPAA Compliant Versions"
      expr: SUM(CASE WHEN is_hipaa_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of HIPAA-compliant versions; leadership monitors this for regulatory exposure."
    - name: "Validated Versions"
      expr: SUM(CASE WHEN validation_status = 'validated' THEN 1 ELSE 0 END)
      comment: "Count of versions passing validation; gap vs total signals data quality risk."
    - name: "Failed Load Versions"
      expr: SUM(CASE WHEN load_status = 'failed' THEN 1 ELSE 0 END)
      comment: "Count of failed reference data loads; spikes trigger ingestion remediation."
    - name: "Total Record Volume"
      expr: SUM(CAST(record_count AS DOUBLE))
      comment: "Aggregate number of codes loaded across versions; sizes reference data footprint."
    - name: "Avg Records Per Version"
      expr: AVG(CAST(record_count AS DOUBLE))
      comment: "Average code count per version; abnormal averages flag truncated or bloated loads."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_icd_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Diagnosis code reference quality KPIs: billability, CC/MCC severity composition, and HAC/POA flags that drive coding accuracy and DRG reimbursement integrity."
  source: "`vibe_healthcare_v1`.`reference`.`icd_code`"
  dimensions:
    - name: "icd_code_category"
      expr: icd_code_category
      comment: "ICD code category for grouping diagnosis reference analysis."
    - name: "code_type"
      expr: code_type
      comment: "Code type (e.g. ICD-10-CM vs ICD-10-PCS) for segmenting reference composition."
    - name: "chapter"
      expr: chapter
      comment: "ICD chapter for body-system level reference reporting."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Effective year of the code for tracking annual code set refresh."
  measures:
    - name: "ICD Code Count"
      expr: COUNT(1)
      comment: "Total diagnosis codes in the reference set, baseline coverage measure."
    - name: "Billable Codes"
      expr: SUM(CASE WHEN billable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of billable codes; coding/revenue teams monitor billable coverage."
    - name: "CC Codes"
      expr: SUM(CASE WHEN cc_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of complication/comorbidity codes affecting DRG severity and reimbursement."
    - name: "MCC Codes"
      expr: SUM(CASE WHEN mcc_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of major complication/comorbidity codes critical to higher-weight DRG capture."
    - name: "HAC Codes"
      expr: SUM(CASE WHEN hac_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of hospital-acquired-condition codes used for penalty and quality monitoring."
    - name: "Coding Valid Codes"
      expr: SUM(CASE WHEN valid_for_coding_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of codes valid for coding; gap vs total signals deprecated-code risk in claims."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_cpt_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procedure code reference economics: RVU distribution and national payment benchmarks that underpin fee schedule, charge master, and provider compensation analytics."
  source: "`vibe_healthcare_v1`.`reference`.`cpt_code`"
  dimensions:
    - name: "cpt_code_category"
      expr: cpt_code_category
      comment: "CPT category for segmenting procedure reference economics."
    - name: "section"
      expr: section
      comment: "CPT section grouping for service-line level RVU/payment analysis."
    - name: "cpt_code_status"
      expr: cpt_code_status
      comment: "Lifecycle status of the CPT code for active-code currency tracking."
    - name: "clinical_family"
      expr: clinical_family
      comment: "Clinical family grouping for procedure economics reporting."
  measures:
    - name: "CPT Code Count"
      expr: COUNT(1)
      comment: "Total procedure codes in reference, baseline coverage measure."
    - name: "Avg Total RVU"
      expr: AVG(CAST(total_rvu AS DOUBLE))
      comment: "Average total RVU across procedures; informs compensation and productivity benchmarking."
    - name: "Avg Work RVU"
      expr: AVG(CAST(work_rvu AS DOUBLE))
      comment: "Average physician work RVU; key driver of provider compensation modeling."
    - name: "Avg National Payment"
      expr: AVG(CAST(national_payment_amount AS DOUBLE))
      comment: "Average Medicare national payment amount; benchmark for fee schedule and net revenue."
    - name: "Telemedicine Eligible Codes"
      expr: SUM(CASE WHEN telemedicine_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of telehealth-eligible procedure codes; supports virtual care strategy decisions."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_drg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DRG reference economics: relative weight, length-of-stay benchmarks, and payment/charge benchmarks that drive inpatient reimbursement, case-mix index, and outlier analysis."
  source: "`vibe_healthcare_v1`.`reference`.`drg`"
  dimensions:
    - name: "drg_type"
      expr: drg_type
      comment: "DRG type (medical/surgical) for case-mix segmentation."
    - name: "complication_level"
      expr: complication_level
      comment: "Complication/comorbidity tier for severity-adjusted reimbursement analysis."
    - name: "clinical_family"
      expr: clinical_family
      comment: "Clinical family grouping for service-line DRG reporting."
    - name: "grouper_system"
      expr: grouper_system
      comment: "DRG grouper system/version for benchmark consistency tracking."
  measures:
    - name: "DRG Count"
      expr: COUNT(1)
      comment: "Total DRGs in reference set, baseline coverage measure."
    - name: "Avg Relative Weight"
      expr: AVG(CAST(relative_weight AS DOUBLE))
      comment: "Average DRG relative weight; core input to case-mix index and reimbursement steering."
    - name: "Avg Geometric Mean LOS"
      expr: AVG(CAST(geometric_mean_los AS DOUBLE))
      comment: "Average geometric-mean length of stay benchmark; drives throughput and efficiency targets."
    - name: "Avg National Payment"
      expr: AVG(CAST(national_average_payment AS DOUBLE))
      comment: "Average national DRG payment; benchmark for inpatient net revenue planning."
    - name: "Readmission Penalty DRGs"
      expr: SUM(CASE WHEN readmission_penalty_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of readmission-penalty DRGs; leadership monitors penalty-exposed case categories."
    - name: "Bundled Payment DRGs"
      expr: SUM(CASE WHEN bundled_payment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of bundled-payment DRGs; informs value-based contract strategy."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_hcpcs_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HCPCS reference policy KPIs: DME/drug composition, prior-authorization burden, and coverage indicators that drive supply, pharmacy, and authorization workflow planning."
  source: "`vibe_healthcare_v1`.`reference`.`hcpcs_code`"
  dimensions:
    - name: "hcpcs_code_category"
      expr: hcpcs_code_category
      comment: "HCPCS category for segmenting supply/drug reference analysis."
    - name: "code_type"
      expr: code_type
      comment: "HCPCS code type for reference composition reporting."
    - name: "coverage_indicator"
      expr: coverage_indicator
      comment: "Coverage indicator used to assess payer coverage posture across codes."
    - name: "pricing_indicator"
      expr: pricing_indicator
      comment: "Pricing methodology indicator for reimbursement classification."
  measures:
    - name: "HCPCS Code Count"
      expr: COUNT(1)
      comment: "Total HCPCS codes in reference, baseline coverage measure."
    - name: "Prior Auth Required Codes"
      expr: SUM(CASE WHEN prior_authorization_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of codes requiring prior authorization; sizes authorization workload and access friction."
    - name: "DME Codes"
      expr: SUM(CASE WHEN dme_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of durable medical equipment codes; informs supply chain and billing strategy."
    - name: "Drug Codes"
      expr: SUM(CASE WHEN drug_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of drug-related HCPCS codes; supports pharmacy reimbursement planning."
    - name: "Modifier Required Codes"
      expr: SUM(CASE WHEN modifier_required_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of codes requiring modifiers; flags coding complexity and denial risk."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_ndc_drug`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug reference safety and formulary KPIs: high-alert/black-box composition, DEA scheduling, and biosimilar/vaccine indicators driving pharmacy safety and formulary strategy."
  source: "`vibe_healthcare_v1`.`reference`.`ndc_drug`"
  dimensions:
    - name: "therapeutic_class"
      expr: therapeutic_class
      comment: "Therapeutic class grouping for formulary and utilization analysis."
    - name: "dosage_form"
      expr: dosage_form
      comment: "Dosage form for drug reference composition reporting."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA controlled-substance schedule for diversion and compliance monitoring."
    - name: "formulary_status"
      expr: formulary_status
      comment: "Formulary status used to track formulary coverage breadth."
  measures:
    - name: "NDC Drug Count"
      expr: COUNT(1)
      comment: "Total drug products in reference, baseline coverage measure."
    - name: "Distinct Active Ingredients"
      expr: COUNT(DISTINCT active_ingredient)
      comment: "Distinct active ingredients; indicates therapeutic breadth of the drug reference."
    - name: "High Alert Medications"
      expr: SUM(CASE WHEN high_alert_medication_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of high-alert medications; central to medication-safety governance."
    - name: "Black Box Warning Drugs"
      expr: SUM(CASE WHEN black_box_warning_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of black-box-warning drugs; safety committees monitor exposure."
    - name: "Biosimilar Products"
      expr: SUM(CASE WHEN biosimilar_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of biosimilar products; supports cost-savings and substitution strategy."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_crosswalk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Terminology mapping quality KPIs: mapping completeness, quality, and usage that drive interoperability and code-translation reliability across systems."
  source: "`vibe_healthcare_v1`.`reference`.`crosswalk`"
  dimensions:
    - name: "mapping_type"
      expr: mapping_type
      comment: "Mapping type for segmenting crosswalk quality analysis."
    - name: "mapping_quality"
      expr: mapping_quality
      comment: "Quality classification of the mapping, central to translation reliability."
    - name: "source_code_system"
      expr: source_code_system
      comment: "Source coding system for mapping direction analysis."
    - name: "target_code_system"
      expr: target_code_system
      comment: "Target coding system for mapping direction analysis."
    - name: "mapping_purpose"
      expr: mapping_purpose
      comment: "Business purpose of the mapping for use-case segmentation."
  measures:
    - name: "Crosswalk Count"
      expr: COUNT(1)
      comment: "Total mappings maintained, baseline coverage measure."
    - name: "Approximate Mappings"
      expr: SUM(CASE WHEN approximate_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of approximate mappings; high share signals translation precision risk."
    - name: "No Map Entries"
      expr: SUM(CASE WHEN no_map_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of no-map entries; flags coverage gaps in code translation."
    - name: "Total Mapping Usage"
      expr: SUM(CAST(usage_count AS DOUBLE))
      comment: "Aggregate usage of mappings; identifies high-value crosswalk entries to prioritize for quality."
    - name: "Avg Mapping Usage"
      expr: AVG(CAST(usage_count AS DOUBLE))
      comment: "Average usage per mapping; helps prioritize maintenance of frequently used mappings."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_geographic_region`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Geographic reference KPIs: population, income, poverty, and uninsured benchmarks that drive market planning, ACO service area strategy, and SDOH analytics."
  source: "`vibe_healthcare_v1`.`reference`.`geographic_region`"
  dimensions:
    - name: "region_type"
      expr: region_type
      comment: "Region type (county, CBSA, HRR) for geographic segmentation."
    - name: "state_abbreviation"
      expr: state_abbreviation
      comment: "State for market and regulatory segmentation."
    - name: "urban_rural_classification"
      expr: urban_rural_classification
      comment: "Urban/rural classification for access and disparity analysis."
    - name: "census_region"
      expr: census_region
      comment: "Census region for national market comparison."
  measures:
    - name: "Region Count"
      expr: COUNT(1)
      comment: "Total geographic regions referenced, baseline coverage measure."
    - name: "Total Population"
      expr: SUM(CAST(population_estimate AS DOUBLE))
      comment: "Aggregate population across regions; sizes addressable market."
    - name: "Avg Median Household Income"
      expr: AVG(CAST(median_household_income AS DOUBLE))
      comment: "Average median household income; informs payer mix and market strategy."
    - name: "Avg Poverty Rate"
      expr: AVG(CAST(poverty_rate_percent AS DOUBLE))
      comment: "Average poverty rate; key SDOH and community-benefit planning input."
    - name: "Avg Uninsured Rate"
      expr: AVG(CAST(uninsured_rate_percent AS DOUBLE))
      comment: "Average uninsured rate; drives charity care and access strategy."
    - name: "ACO Service Area Regions"
      expr: SUM(CASE WHEN aco_service_area_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ACO service-area regions; supports value-based network footprint planning."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_snomed_concept`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SNOMED clinical terminology KPIs: concept status, mapping correlation, and quality-measure relevance driving EHR documentation and quality reporting reliability."
  source: "`vibe_healthcare_v1`.`reference`.`snomed_concept`"
  dimensions:
    - name: "semantic_tag"
      expr: semantic_tag
      comment: "Semantic tag for SNOMED concept-type segmentation."
    - name: "concept_status"
      expr: concept_status
      comment: "Concept lifecycle status for active-content currency tracking."
    - name: "top_level_hierarchy"
      expr: top_level_hierarchy
      comment: "Top-level hierarchy for clinical domain segmentation."
    - name: "concept_class"
      expr: concept_class
      comment: "Concept class grouping for terminology composition reporting."
  measures:
    - name: "Concept Count"
      expr: COUNT(1)
      comment: "Total SNOMED concepts referenced, baseline coverage measure."
    - name: "EHR Preferred Concepts"
      expr: SUM(CASE WHEN is_ehr_preferred = TRUE THEN 1 ELSE 0 END)
      comment: "Count of EHR-preferred concepts; supports documentation standardization decisions."
    - name: "Reportable Concepts"
      expr: SUM(CASE WHEN is_reportable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reportable concepts; drives public-health and quality reporting readiness."
    - name: "Leaf Concepts"
      expr: SUM(CASE WHEN is_leaf_concept = TRUE THEN 1 ELSE 0 END)
      comment: "Count of leaf-level concepts; informs granularity of clinical terminology."
    - name: "Distinct Hierarchies"
      expr: COUNT(DISTINCT top_level_hierarchy)
      comment: "Distinct top-level hierarchies covered; indicates clinical terminology breadth."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_loinc_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "LOINC lab/observation reference KPIs: active-code currency and order vs observation composition that drive lab interoperability and result mapping reliability."
  source: "`vibe_healthcare_v1`.`reference`.`loinc_code`"
  dimensions:
    - name: "class"
      expr: class
      comment: "LOINC class for lab domain segmentation."
    - name: "scale_type"
      expr: scale_type
      comment: "Scale type for result-representation analysis."
    - name: "method_type"
      expr: method_type
      comment: "Method type for lab methodology segmentation."
    - name: "panel_type"
      expr: panel_type
      comment: "Panel type for panel vs individual test analysis."
  measures:
    - name: "LOINC Code Count"
      expr: COUNT(1)
      comment: "Total LOINC codes referenced, baseline coverage measure."
    - name: "Active Codes"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of active LOINC codes; gap vs total flags deprecated-code interoperability risk."
    - name: "Order Observation Codes"
      expr: SUM(CASE WHEN order_observation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of orderable/observable codes; supports CPOE and result mapping coverage."
    - name: "Distinct Classes"
      expr: COUNT(DISTINCT class)
      comment: "Distinct LOINC classes covered; indicates lab terminology breadth."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_npi_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NPI registry reference KPIs: provider/organization entity composition and active-status tracking that underpin provider data integrity and credentialing reference quality."
  source: "`vibe_healthcare_v1`.`reference`.`npi_registry`"
  dimensions:
    - name: "entity_type_code"
      expr: entity_type_code
      comment: "NPI entity type (individual vs organization) for provider reference segmentation."
    - name: "primary_taxonomy_code"
      expr: primary_taxonomy_code
      comment: "Primary taxonomy code for specialty composition analysis."
    - name: "mailing_address_state"
      expr: mailing_address_state
      comment: "State of record for geographic provider distribution."
    - name: "enumeration_year"
      expr: YEAR(enumeration_date)
      comment: "Year the NPI was enumerated for cohort/onboarding trend analysis."
  measures:
    - name: "NPI Count"
      expr: COUNT(1)
      comment: "Total NPI records referenced, baseline coverage measure."
    - name: "Distinct NPIs"
      expr: COUNT(DISTINCT npi)
      comment: "Distinct NPI identifiers; validates uniqueness of provider reference."
    - name: "Deactivated NPIs"
      expr: SUM(CASE WHEN deactivation_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of deactivated NPIs; flags stale provider references that risk claim denials."
    - name: "Distinct Taxonomies"
      expr: COUNT(DISTINCT primary_taxonomy_code)
      comment: "Distinct primary taxonomies; indicates specialty breadth of the provider reference."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_fhir_value_set`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "FHIR value set governance KPIs: binding strength, experimental composition, and review currency driving interoperability conformance and terminology binding reliability."
  source: "`vibe_healthcare_v1`.`reference`.`fhir_value_set`"
  dimensions:
    - name: "binding_strength"
      expr: binding_strength
      comment: "FHIR binding strength for conformance segmentation."
    - name: "fhir_resource_type"
      expr: fhir_resource_type
      comment: "FHIR resource type the value set binds to, for interoperability analysis."
    - name: "publisher"
      expr: publisher
      comment: "Publisher of the value set for source-authority governance."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the value set was approved for currency tracking."
  measures:
    - name: "Value Set Count"
      expr: COUNT(1)
      comment: "Total FHIR value sets referenced, baseline coverage measure."
    - name: "Experimental Value Sets"
      expr: SUM(CASE WHEN experimental_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of experimental value sets; high share signals interoperability maturity risk."
    - name: "Immutable Value Sets"
      expr: SUM(CASE WHEN immutable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of immutable value sets; supports stability assurance for bound resources."
    - name: "Distinct Resource Types"
      expr: COUNT(DISTINCT fhir_resource_type)
      comment: "Distinct FHIR resource types covered; indicates interoperability breadth."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`reference_condition_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical coding and AMA indicator metrics for condition codes"
  source: "`vibe_healthcare_v1`.`reference`.`condition_code`"
  dimensions:
    - name: "condition_code_category"
      expr: condition_code_category
      comment: "Category of the condition code"
    - name: "code_type"
      expr: code_type
      comment: "Type of condition code (e.g., ICD-10, SNOMED)"
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the condition code became effective"
  measures:
    - name: "condition_code_count"
      expr: COUNT(1)
      comment: "Total number of condition code records"
    - name: "ama_indicator_count"
      expr: SUM(CASE WHEN ama_indicator THEN 1 ELSE 0 END)
      comment: "Count of condition codes with AMA indicator set"
$$;