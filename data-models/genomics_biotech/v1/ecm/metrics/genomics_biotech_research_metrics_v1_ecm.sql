-- Metric views for domain: research | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 12:58:41

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`research_spend`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated spend metrics for R&D and operational budgeting"
  source: "`genomics_biotech_ecm`.`research`.`spend`"
  dimensions:
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center associated with the spend"
    - name: "project_id"
      expr: project_id
      comment: "Research project linked to the spend"
    - name: "spend_month"
      expr: DATE_TRUNC('month', spend_date)
      comment: "Spend month for time‑based analysis"
    - name: "cost_category"
      expr: cost_category
      comment: "Category of the spend (e.g., labor, material)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code of the spend amount"
  measures:
    - name: "total_spend_usd"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total spend in USD across all spend records"
    - name: "total_local_spend"
      expr: SUM(CAST(amount_local AS DOUBLE))
      comment: "Total spend in local currency"
    - name: "spend_record_count"
      expr: COUNT(1)
      comment: "Number of spend records"
    - name: "average_spend_usd"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average spend amount in USD per record"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`research_grant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial metrics for research grants"
  source: "`genomics_biotech_ecm`.`research`.`grant`"
  dimensions:
    - name: "funding_agency"
      expr: funding_agency
      comment: "Agency providing the grant"
    - name: "grant_status"
      expr: grant_status
      comment: "Current status of the grant"
    - name: "award_type"
      expr: award_type
      comment: "Type of award (e.g., competitive, institutional)"
    - name: "award_year"
      expr: DATE_TRUNC('year', award_date)
      comment: "Year the grant was awarded"
    - name: "program_officer_name"
      expr: program_officer_name
      comment: "Program officer overseeing the grant"
  measures:
    - name: "total_awarded_usd"
      expr: SUM(CAST(total_award_amount_usd AS DOUBLE))
      comment: "Total grant award amount in USD"
    - name: "total_spent_usd"
      expr: SUM(CAST(actual_spend_usd AS DOUBLE))
      comment: "Total grant spend in USD"
    - name: "grant_count"
      expr: COUNT(1)
      comment: "Number of grants"
    - name: "average_award_usd"
      expr: AVG(CAST(total_award_amount_usd AS DOUBLE))
      comment: "Average award amount per grant"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`research_experiment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational performance of research experiments"
  source: "`genomics_biotech_ecm`.`research`.`experiment`"
  dimensions:
    - name: "project_id"
      expr: project_id
      comment: "Research project identifier"
    - name: "experiment_type"
      expr: experiment_type
      comment: "Type of experiment (e.g., validation, pilot)"
    - name: "experiment_status"
      expr: experiment_status
      comment: "Current status of the experiment"
    - name: "primary_result_metric"
      expr: primary_result_metric
      comment: "Metric used for primary result reporting"
    - name: "primary_result_unit"
      expr: primary_result_unit
      comment: "Unit of the primary result metric"
  measures:
    - name: "experiment_count"
      expr: COUNT(1)
      comment: "Total number of experiments"
    - name: "total_actual_cost_usd"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE))
      comment: "Sum of actual experiment costs in USD"
    - name: "average_actual_cost_usd"
      expr: AVG(CAST(actual_cost_usd AS DOUBLE))
      comment: "Average actual cost per experiment"
    - name: "average_result_value"
      expr: AVG(CAST(primary_result_value AS DOUBLE))
      comment: "Average primary result value across experiments"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`research_assay_development`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and status metrics for assay development pipelines"
  source: "`genomics_biotech_ecm`.`research`.`assay_development`"
  dimensions:
    - name: "assay_type"
      expr: assay_type
      comment: "Category of assay (e.g., sequencing, array)"
    - name: "development_phase"
      expr: development_phase
      comment: "Current development phase"
    - name: "technology_platform"
      expr: technology_platform
      comment: "Technology platform used for the assay"
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the assay"
    - name: "commercialization_year"
      expr: DATE_TRUNC('year', commercialization_date)
      comment: "Year the assay is expected to be commercialized"
    - name: "principal_investigator_name"
      expr: principal_investigator_name
      comment: "Lead investigator for the assay"
  measures:
    - name: "assay_count"
      expr: COUNT(1)
      comment: "Number of assay development records"
    - name: "total_estimated_cogs"
      expr: SUM(CAST(estimated_cogs AS DOUBLE))
      comment: "Total estimated cost of goods sold for assays"
    - name: "average_estimated_cogs"
      expr: AVG(CAST(estimated_cogs AS DOUBLE))
      comment: "Average estimated COGS per assay"
    - name: "total_rd_budget_allocated"
      expr: SUM(CAST(rd_budget_allocated AS DOUBLE))
      comment: "Total R&D budget allocated to assay development"
    - name: "average_rd_spend_to_date"
      expr: AVG(CAST(rd_spend_to_date AS DOUBLE))
      comment: "Average R&D spend to date per assay"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`research_publication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research output and impact metrics"
  source: "`genomics_biotech_ecm`.`research`.`publication`"
  dimensions:
    - name: "journal_name"
      expr: journal_name
      comment: "Name of the journal where published"
    - name: "publication_type"
      expr: publication_type
      comment: "Type of publication (e.g., article, conference)"
  measures:
    - name: "publication_count"
      expr: COUNT(1)
      comment: "Total number of publications"
    - name: "average_impact_factor"
      expr: AVG(CAST(impact_factor AS DOUBLE))
      comment: "Average journal impact factor"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`research_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Milestone tracking for R&D projects"
  source: "`genomics_biotech_ecm`.`research`.`milestone`"
  dimensions:
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone"
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type/category of milestone"
    - name: "planned_year"
      expr: DATE_TRUNC('year', planned_date)
      comment: "Planned year for the milestone"
    - name: "is_gxp_relevant"
      expr: is_gxp_relevant
      comment: "Whether the milestone is GxP relevant"
  measures:
    - name: "milestone_count"
      expr: COUNT(1)
      comment: "Total milestones recorded"
    - name: "completed_milestones"
      expr: SUM(CASE WHEN milestone_status = 'Completed' THEN 1 ELSE 0 END)
      comment: "Number of milestones marked as completed"
$$;