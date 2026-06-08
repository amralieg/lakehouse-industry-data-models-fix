-- Metric views for domain: delta_tblproperties | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`delta_tblproperties_liquid_clustering_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for monitoring Delta table liquid clustering configurations, tracking cardinality distribution and clustering justification patterns to optimize query performance across the healthcare lakehouse."
  source: "`healthcare_ecm_v1`.`delta_tblproperties`.`delta_tblproperties_liquid_clustering_config`"
  dimensions:
    - name: "query_pattern_justification"
      expr: query_pattern_justification
      comment: "The documented business justification for the liquid clustering configuration, used to categorize clustering decisions by access pattern rationale."
    - name: "creation_year_month"
      expr: DATE_TRUNC('MONTH', created_at)
      comment: "Month in which the liquid clustering configuration was created, for tracking governance adoption over time."
    - name: "cardinality_tier"
      expr: CASE WHEN estimated_cardinality < 100 THEN 'Low (<100)' WHEN estimated_cardinality BETWEEN 100 AND 10000 THEN 'Medium (100-10K)' WHEN estimated_cardinality BETWEEN 10001 AND 1000000 THEN 'High (10K-1M)' ELSE 'Very High (>1M)' END
      comment: "Tiered classification of estimated column cardinality to assess whether liquid clustering keys are appropriately chosen for data distribution."
  measures:
    - name: "total_clustering_configs"
      expr: COUNT(1)
      comment: "Total number of liquid clustering configurations registered, indicating breadth of governance coverage across Delta tables."
    - name: "avg_estimated_cardinality"
      expr: AVG(CAST(estimated_cardinality AS DOUBLE))
      comment: "Average estimated cardinality across clustering key columns, used to assess whether clustering decisions align with query selectivity best practices."
    - name: "max_estimated_cardinality"
      expr: MAX(estimated_cardinality)
      comment: "Maximum estimated cardinality among clustering configurations, identifying potential over-partitioning risks that could degrade write performance."
    - name: "distinct_governance_policies_referenced"
      expr: COUNT(DISTINCT databricks_governance_delta_tblproperties_id)
      comment: "Number of distinct Delta TBLPROPERTIES governance policies linked to clustering configs, measuring policy reuse and standardization across the lakehouse."
    - name: "distinct_clustering_definitions"
      expr: COUNT(DISTINCT liquid_clustering_config_id)
      comment: "Number of distinct liquid clustering definitions referenced, tracking how many unique clustering strategies are deployed across healthcare tables."
$$;