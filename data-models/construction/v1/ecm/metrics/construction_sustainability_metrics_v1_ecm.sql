-- Metric views for domain: sustainability | Business: Construction | Version: 1 | Generated on: 2026-05-07 07:27:43

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`sustainability_carbon_emission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core carbon emission KPI view for tracking total emissions, activity volume and project participation"
  source: "`construction_ecm`.`sustainability`.`carbon_emission`"
  dimensions:
    - name: "reporting_year"
      expr: YEAR(reporting_period_start)
      comment: "Fiscal year of the reporting period"
    - name: "scope"
      expr: scope
      comment: "Emission scope (e.g., Scope 1, Scope 2, Scope 3)"
    - name: "source_type"
      expr: source_type
      comment: "Category of emission source (e.g., fuel, electricity)"
  measures:
    - name: "total_co2e_tonnes"
      expr: SUM(CAST(co2e_tonnes AS DOUBLE))
      comment: "Total CO2e emissions in tonnes for the selected period and scope"
    - name: "total_activity_quantity"
      expr: SUM(CAST(activity_quantity AS DOUBLE))
      comment: "Total activity quantity associated with emissions (e.g., units of work, material moved)"
    - name: "distinct_projects"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of construction projects contributing to emissions"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`sustainability_energy_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Energy consumption view linking energy use to carbon emissions for operational efficiency analysis"
  source: "`construction_ecm`.`sustainability`.`energy_consumption`"
  dimensions:
    - name: "energy_type"
      expr: energy_type
      comment: "Type of energy (e.g., electricity, diesel)"
    - name: "consumption_month"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Month of energy consumption"
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Associated construction project"
  measures:
    - name: "total_energy_consumed"
      expr: SUM(CAST(consumption_quantity AS DOUBLE))
      comment: "Total energy consumed (unit of measure as defined by energy_type)"
    - name: "total_carbon_emission_kg"
      expr: SUM(CAST(carbon_emission_kg AS DOUBLE))
      comment: "Total CO2 emissions from energy consumption in kilograms"
    - name: "average_energy_intensity"
      expr: AVG(CAST(energy_intensity AS DOUBLE))
      comment: "Average energy intensity metric for the period"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`sustainability_esg_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Executive ESG report view summarizing emissions and waste diversion performance"
  source: "`construction_ecm`.`sustainability`.`esg_report`"
  dimensions:
    - name: "reporting_year"
      expr: YEAR(reporting_period_start)
      comment: "Fiscal year of the ESG report"
    - name: "sustainability_goals_aligned"
      expr: sustainability_goals_aligned
      comment: "Indicates if the report aligns with corporate sustainability goals"
  measures:
    - name: "total_emissions_scope1"
      expr: SUM(CAST(total_emissions_scope1 AS DOUBLE))
      comment: "Total Scope 1 emissions (direct) in tonnes"
    - name: "total_emissions_scope2"
      expr: SUM(CAST(total_emissions_scope2 AS DOUBLE))
      comment: "Total Scope 2 emissions (indirect energy) in tonnes"
    - name: "total_emissions_scope3"
      expr: SUM(CAST(total_emissions_scope3 AS DOUBLE))
      comment: "Total Scope 3 emissions (value chain) in tonnes"
    - name: "total_emissions_all"
      expr: SUM(total_emissions_scope1 + total_emissions_scope2 + total_emissions_scope3)
      comment: "Aggregate emissions across all scopes"
    - name: "average_waste_diverted_percent"
      expr: AVG(CAST(waste_diverted_percentage AS DOUBLE))
      comment: "Average waste diversion rate across reporting periods"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`sustainability_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for tracking effectiveness and efficiency of sustainability initiatives"
  source: "`construction_ecm`.`sustainability`.`sustainability_action`"
  dimensions:
    - name: "action_category"
      expr: sustainability_action_category
      comment: "High‑level category of the sustainability action"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the action"
    - name: "responsible_role"
      expr: responsible_party_role
      comment: "Role responsible for execution"
    - name: "planned_start_month"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Planned start month of the action"
  measures:
    - name: "total_carbon_reduction_tonnes"
      expr: SUM(CAST(carbon_reduction_tonnes AS DOUBLE))
      comment: "Total carbon reduction achieved by sustainability actions (tonnes CO2e)"
    - name: "total_cost_saving_amount"
      expr: SUM(CAST(cost_saving_amount AS DOUBLE))
      comment: "Total monetary cost savings generated by actions"
    - name: "action_count"
      expr: COUNT(1)
      comment: "Number of sustainability actions recorded"
    - name: "average_completion_days"
      expr: AVG(DATEDIFF(actual_completion_date, planned_start_date))
      comment: "Average number of days taken to complete actions"
$$;