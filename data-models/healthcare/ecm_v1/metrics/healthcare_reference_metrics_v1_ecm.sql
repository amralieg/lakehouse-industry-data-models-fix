-- Metric views for domain: reference | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 16:32:35

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`reference_cpt_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and workload KPIs for CPT codes"
  source: "`healthcare_ecm`.`reference`.`cpt_code`"
  dimensions:
    - name: "cpt_code_category"
      expr: cpt_code_category
      comment: "Category grouping of CPT codes (e.g., surgery, radiology)"
    - name: "clinical_family"
      expr: clinical_family
      comment: "Clinical family classification for CPT codes"
    - name: "facility_indicator"
      expr: facility_indicator
      comment: "Indicates if the CPT code is facility-based"
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the CPT code became effective"
  measures:
    - name: "total_national_payment_amount"
      expr: SUM(CAST(national_payment_amount AS DOUBLE))
      comment: "Total national payment amount across all CPT codes"
    - name: "average_total_rvu"
      expr: AVG(CAST(total_rvu AS DOUBLE))
      comment: "Average total RVU per CPT code, indicating workload intensity"
    - name: "cpt_code_count"
      expr: COUNT(1)
      comment: "Number of distinct CPT code records"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`reference_drg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reimbursement and intensity metrics for Diagnosis Related Groups"
  source: "`healthcare_ecm`.`reference`.`drg`"
  dimensions:
    - name: "drg_code"
      expr: drg_code
      comment: "DRG identifier code"
    - name: "clinical_family"
      expr: clinical_family
      comment: "Clinical family of the DRG"
    - name: "drg_type"
      expr: drg_type
      comment: "Type classification of the DRG"
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the DRG became effective"
  measures:
    - name: "total_national_average_payment"
      expr: SUM(CAST(national_average_payment AS DOUBLE))
      comment: "Total national average payment for DRGs"
    - name: "average_relative_weight"
      expr: AVG(CAST(relative_weight AS DOUBLE))
      comment: "Average relative weight, reflecting resource intensity"
    - name: "drg_count"
      expr: COUNT(1)
      comment: "Number of DRG records"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`reference_geographic_region`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Public health and socioeconomic KPIs by geographic region"
  source: "`healthcare_ecm`.`reference`.`geographic_region`"
  dimensions:
    - name: "state_abbreviation"
      expr: state_abbreviation
      comment: "US state abbreviation for the region"
    - name: "region_type"
      expr: region_type
      comment: "Classification of region (e.g., state, county, HRR)"
    - name: "is_active"
      expr: is_active
      comment: "Indicates if the region record is currently active"
  measures:
    - name: "total_population_estimate"
      expr: SUM(CAST(population_estimate AS DOUBLE))
      comment: "Aggregate population estimate for the region set"
    - name: "average_median_household_income"
      expr: AVG(CAST(median_household_income AS DOUBLE))
      comment: "Average median household income across regions"
    - name: "average_uninsured_rate_percent"
      expr: AVG(CAST(uninsured_rate_percent AS DOUBLE))
      comment: "Average uninsured rate percent across regions"
    - name: "region_count"
      expr: COUNT(1)
      comment: "Number of geographic region records"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`reference_ndc_drug`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug safety and packaging KPIs for NDC drugs"
  source: "`healthcare_ecm`.`reference`.`ndc_drug`"
  dimensions:
    - name: "dosage_form"
      expr: dosage_form
      comment: "Dosage form of the drug (e.g., tablet, injection)"
    - name: "therapeutic_class"
      expr: therapeutic_class
      comment: "Therapeutic class grouping"
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the drug record became effective"
  measures:
    - name: "ndc_drug_count"
      expr: COUNT(1)
      comment: "Total number of NDC drug records"
    - name: "high_alert_drug_count"
      expr: SUM(CASE WHEN high_alert_medication_flag THEN 1 ELSE 0 END)
      comment: "Count of drugs flagged as high-alert medications"
    - name: "average_package_quantity"
      expr: AVG(CAST(package_quantity AS DOUBLE))
      comment: "Average package quantity per drug"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`reference_npi_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider workforce metrics from NPI registry"
  source: "`healthcare_ecm`.`reference`.`npi_registry`"
  dimensions:
    - name: "provider_gender_code"
      expr: provider_gender_code
      comment: "Gender code of the provider"
    - name: "primary_taxonomy_code"
      expr: primary_taxonomy_code
      comment: "Primary taxonomy classification of the provider"
  measures:
    - name: "provider_count"
      expr: COUNT(1)
      comment: "Total number of provider registry entries"
    - name: "active_provider_count"
      expr: SUM(CASE WHEN deactivation_date IS NULL THEN 1 ELSE 0 END)
      comment: "Count of currently active providers (no deactivation date)"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`reference_condition_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical coding and AMA indicator metrics for condition codes"
  source: "`healthcare_ecm`.`reference`.`condition_code`"
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