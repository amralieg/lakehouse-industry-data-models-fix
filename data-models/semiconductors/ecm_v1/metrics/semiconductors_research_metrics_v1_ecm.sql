-- Metric views for domain: research | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 18:21:54

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`research_budget_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial KPIs for research budgeting"
  source: "`semiconductors_ecm`.`research`.`budget_allocation`"
  dimensions:
    - name: "allocation_year"
      expr: DATE_TRUNC('year', allocation_date)
      comment: "Fiscal year of the allocation based on allocation_date"
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the allocation (e.g., approved, pending)"
    - name: "funding_source_type"
      expr: funding_source_type
      comment: "Type of funding source (e.g., grant, internal)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year string as recorded in the allocation"
  measures:
    - name: "total_award_amount"
      expr: SUM(CAST(award_amount AS DOUBLE))
      comment: "Total monetary award amount allocated across all budget allocations"
    - name: "average_award_amount"
      expr: AVG(CAST(award_amount AS DOUBLE))
      comment: "Average award amount per allocation, useful for assessing funding efficiency"
    - name: "allocation_count"
      expr: COUNT(1)
      comment: "Number of budget allocation records"
    - name: "total_budget_for_program"
      expr: SUM(CAST(budget_for_program AS DOUBLE))
      comment: "Sum of budget amounts earmarked for programs"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`research_experimental_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost and yield performance of experimental lots"
  source: "`semiconductors_ecm`.`research`.`experimental_lot`"
  dimensions:
    - name: "technology_node_nm"
      expr: technology_node_nm
      comment: "Technology node identifier for the lot"
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the lot (e.g., active, archived)"
    - name: "start_year"
      expr: DATE_TRUNC('year', actual_start_date)
      comment: "Year the lot started, derived from actual_start_date"
  measures:
    - name: "total_actual_cost_usd"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE))
      comment: "Total actual cost incurred for experimental lots"
    - name: "average_actual_yield_percent"
      expr: AVG(CAST(actual_yield_percent AS DOUBLE))
      comment: "Average yield percentage across lots, indicating production efficiency"
    - name: "lot_count"
      expr: COUNT(1)
      comment: "Number of experimental lots recorded"
    - name: "total_estimated_cost_usd"
      expr: SUM(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Sum of estimated costs for planning vs. actual comparison"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`research_ip_core_development`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and reuse efficiency metrics for IP core development"
  source: "`semiconductors_ecm`.`research`.`ip_core_development`"
  dimensions:
    - name: "research_program_id"
      expr: research_program_id
      comment: "Identifier of the research program sponsoring the IP core"
    - name: "lead_architect_employee_id"
      expr: lead_architect_employee_id
      comment: "Employee ID of the lead architect responsible"
    - name: "ip_category"
      expr: ip_category
      comment: "Category of the IP (e.g., logic, analog)"
    - name: "target_process_node"
      expr: target_process_node
      comment: "Target process node for the IP core"
  measures:
    - name: "total_estimated_nre_cost_usd"
      expr: SUM(CAST(estimated_nre_cost_usd AS DOUBLE))
      comment: "Total estimated non‑recurring engineering cost for IP core development"
    - name: "average_reuse_percentage"
      expr: AVG(CAST(reuse_percentage AS DOUBLE))
      comment: "Average percentage of reusable IP across developments"
    - name: "development_count"
      expr: COUNT(1)
      comment: "Number of IP core development projects"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`research_patent_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic IP protection and valuation KPIs"
  source: "`semiconductors_ecm`.`research`.`patent_filing`"
  dimensions:
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the patent filing"
    - name: "filing_year"
      expr: DATE_TRUNC('year', filing_date)
      comment: "Year the patent was filed"
    - name: "patent_type"
      expr: patent_type
      comment: "Type of patent (e.g., utility, design)"
  measures:
    - name: "patent_count"
      expr: COUNT(1)
      comment: "Total number of patent filings"
    - name: "total_business_value_score"
      expr: SUM(CAST(business_value_score AS DOUBLE))
      comment: "Aggregate business value score across patents"
    - name: "average_strategic_value"
      expr: AVG(CAST(strategic_value AS DOUBLE))
      comment: "Average strategic value rating of filed patents"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`research_competitive_benchmark`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance and efficiency comparison against competitors"
  source: "`semiconductors_ecm`.`research`.`competitive_benchmark`"
  dimensions:
    - name: "technology_node_nm"
      expr: technology_node_nm
      comment: "Technology node being benchmarked"
    - name: "benchmark_year"
      expr: DATE_TRUNC('year', benchmark_date)
      comment: "Year of the benchmark measurement"
    - name: "competitor_name"
      expr: competitor_name
      comment: "Name of the competitor organization"
  measures:
    - name: "average_transistor_density"
      expr: AVG(CAST(transistor_density_mtransistors_per_mm2 AS DOUBLE))
      comment: "Mean transistor density across benchmarks, indicating technology scaling"
    - name: "average_power_consumption_mw"
      expr: AVG(CAST(power_consumption_mw AS DOUBLE))
      comment: "Mean power consumption, a key efficiency metric"
    - name: "average_operating_frequency_ghz"
      expr: AVG(CAST(operating_frequency_ghz AS DOUBLE))
      comment: "Mean operating frequency, reflecting performance"
    - name: "benchmark_record_count"
      expr: COUNT(1)
      comment: "Number of competitive benchmark records"
$$;