-- Metric views for domain: engineering | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 08:25:38

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`engineering_bom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key cost and volume metrics for Bills of Materials"
  source: "`manufacturing_ecm`.`engineering`.`bom`"
  dimensions:
    - name: "bom_status"
      expr: bom_status
      comment: "Current status of the BOM (e.g., Active, Inactive)"
  measures:
    - name: "bom_count"
      expr: COUNT(1)
      comment: "Number of BOM records"
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate_total AS DOUBLE))
      comment: "Total estimated cost across all BOMs"
    - name: "average_lot_size"
      expr: AVG(CAST(lot_size AS DOUBLE))
      comment: "Average lot size defined in BOMs"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`engineering_component_quality`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and cost metrics for engineering components"
  source: "`manufacturing_ecm`.`engineering`.`component`"
  dimensions:
    - name: "component_type"
      expr: component_type
      comment: "Classification of component (e.g., Mechanical, Electrical)"
    - name: "material_specification"
      expr: material_specification
      comment: "Material specification code for the component"
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates if component contains hazardous material"
    - name: "reach_compliant_flag"
      expr: reach_compliant_flag
      comment: "Indicates REACH compliance"
    - name: "rohs_compliant_flag"
      expr: rohs_compliant_flag
      comment: "Indicates RoHS compliance"
  measures:
    - name: "component_count"
      expr: COUNT(1)
      comment: "Number of component records"
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Sum of standard cost for all components"
    - name: "average_dfm_score"
      expr: AVG(CAST(dfm_score AS DOUBLE))
      comment: "Average Design for Manufacturability (DFM) score"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`engineering_project_financials`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial health of engineering projects"
  source: "`manufacturing_ecm`.`engineering`.`engineering_project`"
  dimensions:
    - name: "project_type"
      expr: project_type
      comment: "Type of engineering project (e.g., New Product, Upgrade)"
    - name: "priority_level"
      expr: priority_level
      comment: "Business priority assigned to the project"
    - name: "program_phase"
      expr: program_phase
      comment: "Current phase of the program (e.g., Concept, Development)"
  measures:
    - name: "project_count"
      expr: COUNT(1)
      comment: "Number of engineering projects"
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total allocated budget for projects"
    - name: "total_budget_spent"
      expr: SUM(CAST(budget_spent_amount AS DOUBLE))
      comment: "Total amount spent across projects"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`engineering_test_result_quality`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality outcomes from engineering test results"
  source: "`manufacturing_ecm`.`engineering`.`test_result`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of test performed (e.g., Functional, Stress)"
    - name: "test_outcome"
      expr: test_outcome
      comment: "Result of the test (Pass/Fail)"
    - name: "test_date"
      expr: test_date
      comment: "Date the test was executed"
  measures:
    - name: "test_count"
      expr: COUNT(1)
      comment: "Total number of test result records"
    - name: "average_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across tests"
    - name: "pass_count"
      expr: COUNT(CASE WHEN test_outcome = 'Pass' THEN 1 END)
      comment: "Number of tests that passed"
$$;