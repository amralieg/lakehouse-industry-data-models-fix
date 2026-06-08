-- Metric views for domain: databricks_governance | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`databricks_governance_universal_controls`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Governance control coverage and enforcement metrics for healthcare data platform oversight - tracks policy compliance posture across Unity Catalog"
  source: "`healthcare_ecm_v1`.`databricks_governance`.`universal_controls`"
  dimensions:
    - name: "control_type"
      expr: control_type
      comment: "Type of governance control (RLS, masking, retention, classification, etc.)"
    - name: "enforcement_mode"
      expr: enforcement_mode
      comment: "Whether control is enforced, audit-only, or disabled"
    - name: "control_status"
      expr: control_status
      comment: "Current lifecycle status of the control (active, draft, retired)"
    - name: "data_classification_level"
      expr: data_classification_level
      comment: "Data sensitivity classification (PHI, PII, confidential, internal, public)"
    - name: "domain_scope"
      expr: domain_scope
      comment: "Healthcare domain the control applies to (clinical, billing, patient, etc.)"
    - name: "scd_type"
      expr: scd_type
      comment: "SCD tracking type configured for the control (Type 1, Type 2)"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the control became effective for trend analysis"
  measures:
    - name: "total_controls"
      expr: COUNT(1)
      comment: "Total number of governance controls defined across the platform"
    - name: "active_controls"
      expr: COUNT(CASE WHEN control_status = 'active' THEN 1 END)
      comment: "Number of currently active governance controls - key indicator of governance maturity"
    - name: "enforced_controls"
      expr: COUNT(CASE WHEN enforcement_mode = 'enforced' THEN 1 END)
      comment: "Controls in full enforcement mode vs audit-only - measures actual protection posture"
    - name: "audit_only_controls"
      expr: COUNT(CASE WHEN enforcement_mode = 'audit' THEN 1 END)
      comment: "Controls in audit-only mode that are not yet blocking - indicates governance debt"
    - name: "phi_classified_controls"
      expr: COUNT(CASE WHEN data_classification_level = 'PHI' THEN 1 END)
      comment: "Controls specifically governing PHI data - critical for HIPAA compliance posture"
    - name: "controls_pending_review"
      expr: COUNT(CASE WHEN last_review_date < DATE_ADD(CURRENT_DATE(), -90) THEN 1 END)
      comment: "Controls not reviewed in 90+ days - flags stale governance policies needing attention"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`databricks_governance_rls_predicates`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Row-level security predicate coverage and health metrics - ensures multi-tenant healthcare data isolation is properly configured"
  source: "`healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_rls_predicates2`"
  dimensions:
    - name: "predicate_type"
      expr: predicate_type
      comment: "Type of RLS predicate (facility-scoped, department-scoped, role-based)"
    - name: "principal_type"
      expr: principal_type
      comment: "Type of security principal the predicate applies to (user, group, service principal)"
    - name: "rls_status"
      expr: rls_predicates_status
      comment: "Current status of the RLS predicate (active, draft, disabled)"
    - name: "enforcement_mode"
      expr: enforcement_mode
      comment: "Whether RLS is enforced or in audit mode"
    - name: "hipaa_category"
      expr: hipaa_category
      comment: "HIPAA data category the predicate protects (treatment, payment, operations)"
    - name: "data_domain"
      expr: data_domain
      comment: "Healthcare data domain the predicate governs"
    - name: "target_catalog"
      expr: target_catalog
      comment: "Unity Catalog catalog the predicate is applied to"
  measures:
    - name: "total_rls_predicates"
      expr: COUNT(1)
      comment: "Total RLS predicates defined - baseline for security coverage assessment"
    - name: "active_rls_predicates"
      expr: COUNT(CASE WHEN rls_predicates_status = 'active' THEN 1 END)
      comment: "Currently active RLS predicates protecting data access"
    - name: "default_predicates"
      expr: COUNT(CASE WHEN is_default_predicate = true THEN 1 END)
      comment: "Default deny predicates - ensures zero-trust baseline for PHI access"
    - name: "expired_predicates"
      expr: COUNT(CASE WHEN effective_end_date < CURRENT_DATE() THEN 1 END)
      comment: "Expired predicates that may leave data unprotected - critical security gap indicator"
    - name: "distinct_protected_tables"
      expr: COUNT(DISTINCT target_table)
      comment: "Number of distinct tables with RLS protection - measures coverage breadth"
    - name: "predicates_needing_review"
      expr: COUNT(CASE WHEN next_review_date <= CURRENT_DATE() THEN 1 END)
      comment: "RLS predicates past their review date - compliance risk indicator"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`databricks_governance_hipaa_retention`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HIPAA data retention compliance metrics - tracks adherence to 6-year minimum retention and state-specific requirements for healthcare records"
  source: "`healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention`"
  dimensions:
    - name: "phi_category"
      expr: phi_category
      comment: "Category of PHI data (medical records, billing, lab results, imaging)"
    - name: "policy_type"
      expr: policy_type
      comment: "Type of retention policy (federal minimum, state override, legal hold)"
    - name: "retention_status"
      expr: hipaa_retention_status
      comment: "Current status of the retention policy (active, expired, under review)"
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method of data disposal when retention expires (crypto-shred, purge, archive)"
    - name: "state_jurisdiction"
      expr: state_jurisdiction
      comment: "State jurisdiction for state-specific retention overrides"
    - name: "enforcement_mechanism"
      expr: enforcement_mechanism
      comment: "How retention is enforced (automated, manual review, lifecycle policy)"
    - name: "legal_hold_flag"
      expr: CASE WHEN legal_hold_flag = true THEN 'Under Legal Hold' ELSE 'Normal Retention' END
      comment: "Whether records are under legal hold preventing disposal"
  measures:
    - name: "total_retention_policies"
      expr: COUNT(1)
      comment: "Total retention policies defined across the healthcare data platform"
    - name: "active_retention_policies"
      expr: COUNT(CASE WHEN hipaa_retention_status = 'active' THEN 1 END)
      comment: "Currently active retention policies governing data lifecycle"
    - name: "records_under_legal_hold"
      expr: COUNT(CASE WHEN legal_hold_flag = true THEN 1 END)
      comment: "Records under legal hold that cannot be disposed - litigation risk indicator"
    - name: "policies_with_exceptions"
      expr: COUNT(CASE WHEN exception_flag = true THEN 1 END)
      comment: "Retention policies with approved exceptions - requires audit trail"
    - name: "records_eligible_for_disposal_total"
      expr: SUM(CAST(records_eligible_for_disposal AS DOUBLE))
      comment: "Total records eligible for disposal across all policies - data minimization opportunity"
    - name: "total_records_scanned"
      expr: SUM(CAST(record_count_at_last_scan AS DOUBLE))
      comment: "Total records under retention governance - scope of compliance obligation"
    - name: "disposal_certification_required_count"
      expr: COUNT(CASE WHEN disposal_certification_required = true THEN 1 END)
      comment: "Policies requiring formal disposal certification - high-compliance burden indicator"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`databricks_governance_uc_tag_definitions`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Unity Catalog tag governance metrics - tracks PHI/PII classification tag coverage and health for HIPAA-compliant data cataloging"
  source: "`healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_uc_tag_definitions2`"
  dimensions:
    - name: "tag_category"
      expr: tag_category
      comment: "Category of UC tag (privacy, classification, retention, ownership)"
    - name: "tag_scope"
      expr: tag_scope
      comment: "Scope of tag application (catalog, schema, table, column)"
    - name: "governance_domain"
      expr: governance_domain
      comment: "Healthcare domain the tag definition governs"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework driving the tag requirement (HIPAA, 42 CFR Part 2, state law)"
    - name: "is_required"
      expr: CASE WHEN is_required = true THEN 'Required' ELSE 'Optional' END
      comment: "Whether the tag is mandatory for compliance"
    - name: "is_inheritable"
      expr: CASE WHEN is_inheritable = true THEN 'Inheritable' ELSE 'Non-Inheritable' END
      comment: "Whether the tag propagates to child objects"
    - name: "uc_tag_status"
      expr: uc_tag_definitions_status
      comment: "Current status of the tag definition (active, deprecated, draft)"
  measures:
    - name: "total_tag_definitions"
      expr: COUNT(1)
      comment: "Total UC tag definitions available for data classification"
    - name: "required_tag_definitions"
      expr: COUNT(CASE WHEN is_required = true THEN 1 END)
      comment: "Mandatory tag definitions that must be applied - compliance baseline"
    - name: "system_managed_tags"
      expr: COUNT(CASE WHEN is_system_managed = true THEN 1 END)
      comment: "Tags managed automatically by governance automation vs manual application"
    - name: "tags_with_violation_alerts"
      expr: COUNT(CASE WHEN notification_on_violation = true THEN 1 END)
      comment: "Tag definitions that trigger alerts on violation - active monitoring coverage"
    - name: "inheritable_tags"
      expr: COUNT(CASE WHEN is_inheritable = true THEN 1 END)
      comment: "Tags that propagate to child objects - reduces manual tagging burden"
    - name: "distinct_governance_domains"
      expr: COUNT(DISTINCT governance_domain)
      comment: "Number of healthcare domains with tag governance - measures cross-domain coverage"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`databricks_governance_delta_tblproperties`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delta table properties governance metrics - tracks optimization, compliance, and performance configuration across healthcare lakehouse tables"
  source: "`healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties`"
  dimensions:
    - name: "property_category"
      expr: property_category
      comment: "Category of table property (performance, compliance, retention, security)"
    - name: "data_classification_level"
      expr: data_classification_level
      comment: "Data sensitivity level of the governed table"
    - name: "data_domain"
      expr: data_domain
      comment: "Healthcare domain the table belongs to"
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Regulatory framework driving the property requirement"
    - name: "scd_type"
      expr: scd_type
      comment: "SCD type configured for the table (Type 1, Type 2)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the property configuration"
    - name: "is_current"
      expr: CASE WHEN is_current = true THEN 'Current' ELSE 'Historical' END
      comment: "Whether this is the current active configuration"
    - name: "liquid_clustering_enabled"
      expr: CASE WHEN liquid_clustering_enabled = true THEN 'Enabled' ELSE 'Disabled' END
      comment: "Whether liquid clustering is configured for the table"
  measures:
    - name: "total_property_configs"
      expr: COUNT(1)
      comment: "Total table property configurations managed"
    - name: "current_configs"
      expr: COUNT(CASE WHEN is_current = true THEN 1 END)
      comment: "Currently active property configurations"
    - name: "phi_tables_configured"
      expr: COUNT(CASE WHEN contains_phi = true THEN 1 END)
      comment: "Tables containing PHI with governance properties applied - HIPAA coverage"
    - name: "pii_tables_configured"
      expr: COUNT(CASE WHEN contains_pii = true THEN 1 END)
      comment: "Tables containing PII with governance properties applied"
    - name: "liquid_clustering_enabled_count"
      expr: COUNT(CASE WHEN liquid_clustering_enabled = true THEN 1 END)
      comment: "Tables with liquid clustering enabled - performance optimization coverage"
    - name: "auto_compact_enabled_count"
      expr: COUNT(CASE WHEN auto_compact_enabled = true THEN 1 END)
      comment: "Tables with auto-compaction enabled - storage optimization indicator"
    - name: "change_data_feed_enabled_count"
      expr: COUNT(CASE WHEN change_data_feed_enabled = true THEN 1 END)
      comment: "Tables with CDF enabled - audit trail and CDC capability coverage"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`databricks_governance_uc_tags_applied`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Applied Unity Catalog tag metrics - measures actual tag deployment coverage across healthcare data assets for compliance verification"
  source: "`healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_uc_tags`"
  dimensions:
    - name: "tag_category"
      expr: tag_category
      comment: "Category of applied tag (privacy, classification, ownership)"
    - name: "tag_scope"
      expr: tag_scope
      comment: "Level at which tag is applied (catalog, schema, table, column)"
    - name: "asset_type"
      expr: asset_type
      comment: "Type of data asset tagged (table, view, column, schema)"
    - name: "data_classification_level"
      expr: data_classification_level
      comment: "Classification level assigned via tag"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework the tag supports"
    - name: "enforcement_mode"
      expr: enforcement_mode
      comment: "How the tag is enforced (block, warn, audit)"
    - name: "tag_status"
      expr: tag_status
      comment: "Current status of the applied tag"
    - name: "business_domain"
      expr: business_domain
      comment: "Healthcare business domain the tagged asset belongs to"
  measures:
    - name: "total_tags_applied"
      expr: COUNT(1)
      comment: "Total UC tags applied across all data assets - governance adoption metric"
    - name: "phi_tagged_assets"
      expr: COUNT(CASE WHEN phi_indicator = true THEN 1 END)
      comment: "Assets tagged as containing PHI - HIPAA compliance coverage"
    - name: "required_tags_applied"
      expr: COUNT(CASE WHEN is_required = true THEN 1 END)
      comment: "Mandatory compliance tags that have been applied"
    - name: "distinct_tagged_objects"
      expr: COUNT(DISTINCT object_name)
      comment: "Number of distinct data objects with at least one tag applied"
    - name: "tags_with_masking_policy"
      expr: COUNT(CASE WHEN masking_policy_name IS NOT NULL THEN 1 END)
      comment: "Tags linked to dynamic data masking policies - active PHI protection"
    - name: "tags_with_rls"
      expr: COUNT(CASE WHEN rls_predicate_expression IS NOT NULL THEN 1 END)
      comment: "Tags linked to row-level security predicates - access control coverage"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`databricks_governance_scd_configuration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SCD (Slowly Changing Dimension) configuration metrics - tracks temporal data management patterns critical for healthcare reference data versioning (ICD codes, formularies, fee schedules)"
  source: "`healthcare_ecm_v1`.`databricks_governance`.`scd_configuration`"
  dimensions:
    - name: "scd_type"
      expr: scd_type
      comment: "SCD type configured (Type 1 overwrite, Type 2 versioned history)"
    - name: "merge_strategy"
      expr: merge_strategy
      comment: "Merge strategy used for SCD processing (MERGE INTO, INSERT OVERWRITE)"
    - name: "hash_diff_enabled"
      expr: CASE WHEN hash_diff_enabled = true THEN 'Hash Diff Enabled' ELSE 'Column Compare' END
      comment: "Whether hash-based change detection is used for efficiency"
  measures:
    - name: "total_scd_configs"
      expr: COUNT(1)
      comment: "Total SCD configurations defined - scope of temporal data management"
    - name: "type2_configs"
      expr: COUNT(CASE WHEN scd_type = 'Type 2' THEN 1 END)
      comment: "Type 2 SCD configurations preserving full history - critical for regulatory audit trails"
    - name: "hash_diff_configs"
      expr: COUNT(CASE WHEN hash_diff_enabled = true THEN 1 END)
      comment: "Configurations using hash-based change detection - performance optimization indicator"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`databricks_governance_hipaa_retention_annotations`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HIPAA retention annotation policy metrics - governs record-type-specific retention rules including state jurisdiction overrides and minor patient extensions"
  source: "`healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention_annotations`"
  dimensions:
    - name: "phi_category"
      expr: phi_category
      comment: "PHI category the annotation applies to (medical records, billing, lab, imaging)"
    - name: "state_jurisdiction"
      expr: state_jurisdiction
      comment: "State jurisdiction for state-specific retention requirements"
    - name: "enforcement_mode"
      expr: enforcement_mode
      comment: "How the retention annotation is enforced"
    - name: "annotation_status"
      expr: hipaa_retention_annotations_status
      comment: "Current status of the retention annotation"
    - name: "applicable_domain"
      expr: applicable_domain
      comment: "Healthcare domain the annotation applies to"
    - name: "disposal_action"
      expr: disposal_action
      comment: "Action taken when retention period expires"
  measures:
    - name: "total_annotations"
      expr: COUNT(1)
      comment: "Total HIPAA retention annotations defined"
    - name: "minor_patient_annotations"
      expr: COUNT(CASE WHEN applies_to_minors = true THEN 1 END)
      comment: "Annotations with extended retention for minor patients - pediatric compliance"
    - name: "legal_hold_override_annotations"
      expr: COUNT(CASE WHEN legal_hold_override = true THEN 1 END)
      comment: "Annotations that can override legal holds - requires careful governance"
    - name: "exception_approval_required_count"
      expr: COUNT(CASE WHEN exception_approval_required = true THEN 1 END)
      comment: "Annotations requiring explicit approval for exceptions - high-governance items"
    - name: "distinct_state_jurisdictions"
      expr: COUNT(DISTINCT state_jurisdiction)
      comment: "Number of state jurisdictions with specific retention rules - multi-state compliance scope"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`databricks_governance_rls_examples`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RLS implementation pattern metrics - tracks row-level security rule deployment patterns for multi-tenant healthcare data isolation"
  source: "`healthcare_ecm_v1`.`databricks_governance`.`rls_examples`"
  dimensions:
    - name: "rule_type"
      expr: rule_type
      comment: "Type of RLS rule (facility-based, department-based, role-based, patient-consent)"
    - name: "rule_status"
      expr: rule_status
      comment: "Current status of the RLS rule"
    - name: "data_domain"
      expr: data_domain
      comment: "Healthcare domain the rule protects"
    - name: "data_classification"
      expr: data_classification
      comment: "Data classification level the rule applies to"
    - name: "enforcement_mode"
      expr: enforcement_mode
      comment: "Whether rule is enforced or in audit mode"
    - name: "applicable_regulation"
      expr: applicable_regulation
      comment: "Regulation driving the RLS requirement (HIPAA, 42 CFR Part 2, state law)"
  measures:
    - name: "total_rls_rules"
      expr: COUNT(1)
      comment: "Total RLS rules defined as implementation patterns"
    - name: "phi_protected_rules"
      expr: COUNT(CASE WHEN phi_indicator = true THEN 1 END)
      comment: "RLS rules specifically protecting PHI data"
    - name: "pii_protected_rules"
      expr: COUNT(CASE WHEN pii_indicator = true THEN 1 END)
      comment: "RLS rules specifically protecting PII data"
    - name: "approval_required_rules"
      expr: COUNT(CASE WHEN approval_required = true THEN 1 END)
      comment: "Rules requiring explicit approval before activation - governance rigor indicator"
    - name: "avg_row_reduction_pct"
      expr: AVG(CAST(expected_row_count_reduction_pct AS DOUBLE))
      comment: "Average expected row reduction from RLS predicates - measures data isolation effectiveness"
    - name: "distinct_protected_tables"
      expr: COUNT(DISTINCT target_table)
      comment: "Number of distinct tables with RLS rule patterns defined"
$$;