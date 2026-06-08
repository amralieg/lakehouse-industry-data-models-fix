-- Metric views for domain: uc_tags | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`uc_tags_industry_outcome_plugin_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks the health and adoption of industry outcome plugins installed into the healthcare data model ecosystem. These plugins (e.g., readmission_forecast, sepsis_score) attach to the base model and deliver AI/ML outcomes. This metric view monitors plugin portfolio health, activation rates, and version currency to ensure the plugin ecosystem is well-governed."
  source: "`healthcare_ecm_v1`.`uc_tags`.`industry_outcome_plugin_registry`"
  dimensions:
    - name: "plugin_active_status"
      expr: CASE WHEN is_active = TRUE THEN 'Active' ELSE 'Inactive' END
      comment: "Whether the industry outcome plugin registration is currently active and delivering results"
    - name: "plugin_version"
      expr: plugin_version
      comment: "Version identifier of the installed plugin for tracking currency and upgrade needs"
    - name: "installation_year"
      expr: YEAR(installed_date)
      comment: "Year the plugin was installed, for tracking adoption velocity over time"
    - name: "installation_quarter"
      expr: CONCAT('Q', QUARTER(installed_date), ' ', YEAR(installed_date))
      comment: "Quarter and year of plugin installation for adoption trend analysis"
    - name: "has_mlflow_model"
      expr: CASE WHEN mlflow_model_uri IS NOT NULL AND mlflow_model_uri != '' THEN 'MLflow Linked' ELSE 'No MLflow Link' END
      comment: "Whether the plugin has a registered MLflow model URI, indicating proper ML governance and lineage tracking"
  measures:
    - name: "total_plugin_registrations"
      expr: COUNT(1)
      comment: "Total number of industry outcome plugin registrations across the healthcare model ecosystem. Used to assess plugin portfolio breadth and adoption scale."
    - name: "active_plugin_count"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of currently active plugin registrations delivering outcomes. A declining count signals governance or maintenance issues requiring leadership intervention."
    - name: "inactive_plugin_count"
      expr: SUM(CASE WHEN is_active = FALSE THEN 1 ELSE 0 END)
      comment: "Count of inactive/decommissioned plugin registrations. Rising inactive counts may indicate technical debt or failed plugin deployments requiring review."
    - name: "plugin_activation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of all registered plugins that are currently active. A key health indicator for the plugin ecosystem — low rates suggest abandoned or failed deployments requiring remediation."
    - name: "mlflow_governed_plugin_count"
      expr: SUM(CASE WHEN mlflow_model_uri IS NOT NULL AND mlflow_model_uri != '' THEN 1 ELSE 0 END)
      comment: "Count of plugins with proper MLflow model URI linkage, indicating governed ML lifecycle. Critical for clinical AI governance and FDA SaMD compliance tracking."
    - name: "mlflow_governance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN mlflow_model_uri IS NOT NULL AND mlflow_model_uri != '' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of registered plugins with MLflow model governance linkage. Low rates indicate clinical AI governance gaps that could create regulatory risk for healthcare AI deployments."
    - name: "distinct_plugin_versions"
      expr: COUNT(DISTINCT plugin_version)
      comment: "Number of distinct plugin versions deployed across the ecosystem. High version fragmentation may indicate upgrade coordination issues requiring platform team attention."
$$;