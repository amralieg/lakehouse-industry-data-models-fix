-- Metric views for domain: implementation | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`implementation_hipaa_retention_annotations`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic metrics for HIPAA retention annotation governance - tracks compliance coverage, policy currency, and regulatory alignment across the healthcare data model's retention framework"
  source: "`healthcare_ecm_v1`.`implementation`.`implementation_hipaa_retention_annotations`"
  dimensions:
    - name: "data_domain"
      expr: data_domain
      comment: "Healthcare data domain the retention annotation applies to (e.g., clinical, billing, patient) - enables domain-level compliance gap analysis"
    - name: "phi_classification"
      expr: phi_classification
      comment: "PHI classification level (phi, pii, sensitive, de-identified) - critical for HIPAA governance tier analysis"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Governing regulatory body (CMS, OCR, Joint Commission, state) - enables authority-specific compliance reporting"
    - name: "scd_type"
      expr: scd_type
      comment: "Slowly changing dimension type applied (Type 1, Type 2, Type 3) - tracks data historization strategy across the model"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the retention annotation - enables risk-based remediation planning"
    - name: "disposal_method"
      expr: disposal_method
      comment: "Data disposal method (purge, archive, anonymize) - critical for retention lifecycle management"
    - name: "annotation_status"
      expr: implementation_hipaa_retention_annotations_status
      comment: "Current status of the retention annotation (active, draft, expired, under_review) - tracks policy lifecycle"
    - name: "state_jurisdiction"
      expr: state_jurisdiction
      comment: "State-level jurisdiction for state-specific retention requirements that exceed federal HIPAA minimums"
    - name: "patient_age_group"
      expr: patient_age_group
      comment: "Patient age group classification - pediatric records have extended retention requirements under state laws"
    - name: "de_identification_method"
      expr: de_identification_method
      comment: "De-identification methodology (Safe Harbor, Expert Determination) - tracks HIPAA de-identification compliance approach"
    - name: "encryption_at_rest_required"
      expr: CAST(encryption_at_rest_required AS STRING)
      comment: "Whether encryption at rest is mandated - key security control indicator for PHI storage"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the retention annotation was approved - enables temporal analysis of governance maturity"
    - name: "review_frequency_months"
      expr: review_frequency_months
      comment: "Required review frequency in months - identifies annotations requiring more frequent compliance attention"
  measures:
    - name: "total_retention_annotations"
      expr: COUNT(1)
      comment: "Total number of HIPAA retention annotations defined across the data model - baseline governance coverage metric"
    - name: "annotations_requiring_encryption"
      expr: SUM(CASE WHEN encryption_at_rest_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of annotations mandating encryption at rest - measures security control coverage for PHI data products"
    - name: "annotations_with_breach_notification"
      expr: SUM(CASE WHEN breach_notification_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of annotations requiring breach notification - identifies high-risk data products subject to OCR notification rules"
    - name: "annotations_with_audit_trail"
      expr: SUM(CASE WHEN audit_trail_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of annotations requiring audit trail - measures access logging coverage for compliance"
    - name: "legal_hold_eligible_count"
      expr: SUM(CASE WHEN legal_hold_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of annotations eligible for legal hold - identifies data products that may be subject to litigation preservation"
    - name: "minimum_necessary_applicable_count"
      expr: SUM(CASE WHEN minimum_necessary_applies = TRUE THEN 1 ELSE 0 END)
      comment: "Count of annotations where HIPAA minimum necessary standard applies - tracks access restriction governance scope"
    - name: "annotations_applies_to_historical"
      expr: SUM(CASE WHEN applies_to_historical_data = TRUE THEN 1 ELSE 0 END)
      comment: "Count of annotations applying retroactively to historical data - measures scope of backward-looking compliance obligations"
    - name: "avg_unity_catalog_tag_value"
      expr: AVG(CAST(unity_catalog_tag_value AS DOUBLE))
      comment: "Average Unity Catalog tag numeric value across annotations - tracks governance metadata completeness scoring"
    - name: "distinct_data_domains_covered"
      expr: COUNT(DISTINCT data_domain)
      comment: "Number of distinct data domains with retention annotations - measures breadth of governance coverage across the 22 healthcare domains"
    - name: "distinct_data_products_covered"
      expr: COUNT(DISTINCT data_product_name)
      comment: "Number of distinct data products with retention annotations - measures granular table-level governance coverage"
    - name: "overdue_review_count"
      expr: SUM(CASE WHEN next_review_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of annotations past their next review date - critical compliance risk indicator requiring immediate remediation"
    - name: "expired_annotations_count"
      expr: SUM(CASE WHEN expiration_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of annotations that have expired - identifies governance gaps where retention policies are no longer active"
$$;