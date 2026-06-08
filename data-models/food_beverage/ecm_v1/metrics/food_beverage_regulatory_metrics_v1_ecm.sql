-- Metric views for domain: regulatory | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 21:55:54

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`regulatory_agency_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for regulatory agency submissions"
  source: "`food_beverage_ecm`.`regulatory`.`agency_submission`"
  dimensions:
    - name: "agency_code"
      expr: agency_code
      comment: "Code of the regulatory agency"
    - name: "agency_name"
      expr: agency_name
      comment: "Name of the regulatory agency"
    - name: "region"
      expr: region
      comment: "Geographic region of the submission"
    - name: "regulatory_section"
      expr: regulatory_section
      comment: "Regulatory section referenced"
    - name: "submission_type"
      expr: submission_type
      comment: "Type of submission (e.g., new, amendment)"
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the submission"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the submission"
    - name: "submission_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month of submission"
    - name: "submission_year"
      expr: DATE_TRUNC('year', submission_date)
      comment: "Year of submission"
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of agency submissions"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Sum of fee amounts across submissions"
    - name: "avg_fee_amount"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average fee amount per submission"
    - name: "fee_paid_count"
      expr: SUM(CASE WHEN fee_paid THEN 1 ELSE 0 END)
      comment: "Count of submissions where the fee was paid"
    - name: "distinct_outcome_count"
      expr: COUNT(DISTINCT outcome)
      comment: "Number of unique outcomes reported"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`regulatory_compliance_evidence`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics tracking compliance evidence health and confidentiality"
  source: "`food_beverage_ecm`.`regulatory`.`compliance_evidence`"
  dimensions:
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body that issued the requirement"
    - name: "evidence_type"
      expr: evidence_type
      comment: "Type/category of the evidence"
    - name: "is_confidential"
      expr: is_confidential
      comment: "Whether the evidence is confidential"
    - name: "expiration_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month when evidence expires"
  measures:
    - name: "total_evidence"
      expr: COUNT(1)
      comment: "Total number of compliance evidence records"
    - name: "confidential_evidence_count"
      expr: SUM(CASE WHEN is_confidential THEN 1 ELSE 0 END)
      comment: "Count of evidence marked as confidential"
    - name: "avg_file_size_bytes"
      expr: AVG(CAST(file_size_bytes AS DOUBLE))
      comment: "Average file size of evidence documents in bytes"
    - name: "expired_evidence_count"
      expr: SUM(CASE WHEN expiration_date < CURRENT_DATE THEN 1 ELSE 0 END)
      comment: "Count of evidence records that have expired"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`regulatory_establishment_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance indicators for establishment registrations and upcoming inspections"
  source: "`food_beverage_ecm`.`regulatory`.`establishment_registration`"
  dimensions:
    - name: "state"
      expr: state
      comment: "State where the establishment is located"
    - name: "country"
      expr: country
      comment: "Country of the establishment"
    - name: "registration_program"
      expr: registration_program
      comment: "Regulatory program under which the registration occurs"
    - name: "registration_status"
      expr: registration_status
      comment: "Current status of the registration"
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the registration became effective"
  measures:
    - name: "total_registrations"
      expr: COUNT(1)
      comment: "Total number of establishment registrations"
    - name: "active_registrations"
      expr: SUM(CASE WHEN registration_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of registrations currently active"
    - name: "expiring_soon_count"
      expr: SUM(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 30) THEN 1 ELSE 0 END)
      comment: "Registrations expiring within the next 30 days"
    - name: "avg_days_to_next_inspection"
      expr: AVG(CAST(DATEDIFF(next_inspection_due, CURRENT_DATE) AS DOUBLE))
      comment: "Average days remaining until the next scheduled inspection"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`regulatory_facility_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key metrics for facility inspection effectiveness and timeliness"
  source: "`food_beverage_ecm`.`regulatory`.`facility_inspection`"
  dimensions:
    - name: "facility_name"
      expr: facility_name
      comment: "Name of the inspected facility"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (e.g., routine, special)"
    - name: "inspection_status"
      expr: facility_inspection_status
      comment: "Overall status/result of the inspection"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of findings"
    - name: "inspection_year"
      expr: DATE_TRUNC('year', inspection_timestamp)
      comment: "Year the inspection took place"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of facility inspections performed"
    - name: "follow_up_required_count"
      expr: SUM(CASE WHEN follow_up_required THEN 1 ELSE 0 END)
      comment: "Inspections that require follow‑up actions"
    - name: "avg_days_to_corrective_deadline"
      expr: AVG(CAST(DATEDIFF(corrective_action_deadline, inspection_timestamp) AS DOUBLE))
      comment: "Average number of days between inspection and corrective‑action deadline"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`regulatory_recall_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic recall performance indicators for risk and impact management"
  source: "`food_beverage_ecm`.`regulatory`.`recall_event`"
  dimensions:
    - name: "recall_class"
      expr: recall_class
      comment: "Class of recall (e.g., Class I, II, III)"
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall (e.g., voluntary, mandatory)"
    - name: "recall_status"
      expr: recall_event_status
      comment: "Current status of the recall event"
    - name: "product_category"
      expr: product_category
      comment: "Product category involved in the recall"
    - name: "recall_year"
      expr: DATE_TRUNC('year', recall_date)
      comment: "Year the recall was initiated"
  measures:
    - name: "total_recalls"
      expr: COUNT(1)
      comment: "Total number of recall events recorded"
    - name: "total_units_affected"
      expr: SUM(CAST(total_units_affected AS DOUBLE))
      comment: "Sum of units affected across all recalls"
    - name: "total_units_disposed"
      expr: SUM(CAST(total_units_disposed AS DOUBLE))
      comment: "Sum of units disposed as part of recalls"
    - name: "high_priority_recalls"
      expr: SUM(CASE WHEN recall_priority = 'High' THEN 1 ELSE 0 END)
      comment: "Count of recalls flagged as high priority"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`regulatory_product_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core product registration health and market readiness metrics"
  source: "`food_beverage_ecm`.`regulatory`.`product_registration`"
  dimensions:
    - name: "market_name"
      expr: market_name
      comment: "Market where the product is registered"
    - name: "product_category"
      expr: product_category
      comment: "Category of the product"
    - name: "regulatory_section"
      expr: regulatory_section
      comment: "Regulatory section governing the product"
    - name: "registration_status"
      expr: registration_status
      comment: "Current status of the registration"
    - name: "registration_type"
      expr: registration_type
      comment: "Type of registration (e.g., new, amendment)"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the registration"
  measures:
    - name: "total_registrations"
      expr: COUNT(1)
      comment: "Total number of product registrations"
    - name: "compliant_product_count"
      expr: SUM(CASE WHEN is_compliant THEN 1 ELSE 0 END)
      comment: "Count of products marked as compliant"
    - name: "export_allowed_count"
      expr: SUM(CASE WHEN is_export_allowed THEN 1 ELSE 0 END)
      comment: "Count of products approved for export"
    - name: "nutrition_facts_available_count"
      expr: SUM(CASE WHEN nutrition_facts_available THEN 1 ELSE 0 END)
      comment: "Count of products with nutrition facts available"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`regulatory_nutrition_label`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nutritional profile averages for product labeling compliance"
  source: "`food_beverage_ecm`.`regulatory`.`nutrition_label`"
  dimensions:
    - name: "country"
      expr: country
      comment: "Country of the nutrition label"
    - name: "label_name"
      expr: label_name
      comment: "Name of the nutrition label"
    - name: "is_organic"
      expr: is_organic
      comment: "Whether the product is certified organic"
    - name: "is_vegan"
      expr: is_vegan
      comment: "Whether the product is certified vegan"
    - name: "is_gluten_free"
      expr: is_gluten_free
      comment: "Whether the product is gluten‑free"
  measures:
    - name: "total_labels"
      expr: COUNT(1)
      comment: "Total number of nutrition labels recorded"
    - name: "avg_added_sugars_g"
      expr: AVG(CAST(added_sugars_g AS DOUBLE))
      comment: "Average added sugars per label (grams)"
    - name: "avg_protein_g"
      expr: AVG(CAST(protein_g AS DOUBLE))
      comment: "Average protein content per label (grams)"
    - name: "avg_total_fat_g"
      expr: AVG(CAST(total_fat_g AS DOUBLE))
      comment: "Average total fat per label (grams)"
$$;