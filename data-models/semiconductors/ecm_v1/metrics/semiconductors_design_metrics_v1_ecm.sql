-- Metric views for domain: design | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 18:21:54

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`design_change_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key cost and compliance metrics for design change requests"
  source: "`semiconductors_ecm`.`design`.`change_request`"
  dimensions:
    - name: "change_category"
      expr: change_category
      comment: "Category of the change request"
    - name: "priority"
      expr: priority
      comment: "Priority level of the change request"
    - name: "status"
      expr: status
      comment: "Current status of the change request"
    - name: "request_date"
      expr: DATE_TRUNC('day', request_timestamp)
      comment: "Date the change request was submitted"
    - name: "approver_id"
      expr: approver_id
      comment: "Identifier of the approver"
  measures:
    - name: "total_actual_cost"
      expr: SUM(CAST(cost_actual AS DOUBLE))
      comment: "Sum of actual cost incurred for change requests"
    - name: "total_estimated_cost"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Sum of estimated cost for change requests"
    - name: "average_actual_cost"
      expr: AVG(CAST(cost_actual AS DOUBLE))
      comment: "Average actual cost per change request"
    - name: "count_change_requests"
      expr: COUNT(1)
      comment: "Total number of change requests"
    - name: "compliance_flag_true_count"
      expr: SUM(CASE WHEN compliance_flag THEN 1 ELSE 0 END)
      comment: "Number of change requests marked as compliance"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`design_ip_core`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance, cost, and size metrics for IP cores"
  source: "`semiconductors_ecm`.`design`.`design_ip_core`"
  dimensions:
    - name: "ip_type"
      expr: ip_type
      comment: "Type of IP core (e.g., analog, digital)"
    - name: "vendor_name"
      expr: vendor_name
      comment: "Vendor supplying the IP core"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the IP core"
    - name: "dfm_compliant"
      expr: dfm_compliant
      comment: "Design for manufacturability compliance flag"
    - name: "dft_compliant"
      expr: dft_compliant
      comment: "Design for test compliance flag"
    - name: "silicon_proven"
      expr: silicon_proven
      comment: "Silicon proven flag"
    - name: "license_type"
      expr: license_type
      comment: "License type for the IP core"
    - name: "release_year"
      expr: DATE_TRUNC('year', release_date)
      comment: "Year the IP core was released"
  measures:
    - name: "total_gate_count"
      expr: SUM(CAST(gate_count AS DOUBLE))
      comment: "Total gate count across IP cores"
    - name: "total_power_uw"
      expr: SUM(CAST(power_uw AS DOUBLE))
      comment: "Sum of power consumption (µW) for all IP cores"
    - name: "average_max_frequency_mhz"
      expr: AVG(CAST(max_frequency_mhz AS DOUBLE))
      comment: "Average maximum operating frequency (MHz)"
    - name: "total_license_fee_usd"
      expr: SUM(CAST(license_fee_usd AS DOUBLE))
      comment: "Total license fees paid for IP cores"
    - name: "average_area_um2"
      expr: AVG(CAST(area_um2 AS DOUBLE))
      comment: "Average silicon area (µm²) per IP core"
    - name: "count_ip_cores"
      expr: COUNT(1)
      comment: "Number of IP core records"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`design_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule and quality metrics for design milestones"
  source: "`semiconductors_ecm`.`design`.`design_milestone`"
  dimensions:
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (e.g., gate, tapeout)"
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone"
    - name: "milestone_code"
      expr: milestone_code
      comment: "Business code identifying the milestone"
    - name: "actual_month"
      expr: DATE_TRUNC('month', actual_date)
      comment: "Month of the actual milestone date"
  measures:
    - name: "total_die_area_mm2"
      expr: SUM(CAST(die_area_mm2 AS DOUBLE))
      comment: "Total die area (mm²) across milestones"
    - name: "average_power_budget_mw"
      expr: AVG(CAST(power_budget_mw AS DOUBLE))
      comment: "Average power budget (mW) per milestone"
    - name: "count_milestones"
      expr: COUNT(1)
      comment: "Number of design milestones recorded"
    - name: "tapeout_authorized_count"
      expr: SUM(CASE WHEN tapeout_authorized THEN 1 ELSE 0 END)
      comment: "Milestones where tapeout was authorized"
    - name: "dfm_sign_off_count"
      expr: SUM(CASE WHEN dfm_sign_off THEN 1 ELSE 0 END)
      comment: "Milestones with DFM sign‑off"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`design_revision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and resource metrics for design revisions"
  source: "`semiconductors_ecm`.`design`.`design_revision`"
  dimensions:
    - name: "design_stage"
      expr: design_stage
      comment: "Stage of the design (e.g., concept, detailed)"
    - name: "design_type"
      expr: design_type
      comment: "Type of design (e.g., ASIC, FPGA)"
    - name: "status"
      expr: status
      comment: "Current status of the revision"
    - name: "revision_type"
      expr: revision_type
      comment: "Classification of the revision (e.g., incremental, major)"
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the revision record was created"
  measures:
    - name: "total_power_mw"
      expr: SUM(CAST(power_mw AS DOUBLE))
      comment: "Total power (mW) across design revisions"
    - name: "average_gate_count"
      expr: AVG(CAST(gate_count AS DOUBLE))
      comment: "Average gate count per revision"
    - name: "total_area_um2"
      expr: SUM(CAST(area_um2 AS DOUBLE))
      comment: "Total silicon area (µm²) across revisions"
    - name: "critical_revision_count"
      expr: SUM(CASE WHEN is_critical THEN 1 ELSE 0 END)
      comment: "Number of revisions flagged as critical"
    - name: "count_revisions"
      expr: COUNT(1)
      comment: "Total number of design revisions"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`design_ip_core_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Utilization and performance metrics for IP core usage"
  source: "`semiconductors_ecm`.`design`.`ip_core_usage`"
  dimensions:
    - name: "design_ip_core_id"
      expr: design_ip_core_id
      comment: "Identifier of the IP core being used"
    - name: "license_type"
      expr: license_type
      comment: "License type associated with the usage"
    - name: "integration_month"
      expr: DATE_TRUNC('month', integration_start_date)
      comment: "Month when integration started"
  measures:
    - name: "total_area_consumed_um2"
      expr: SUM(CAST(area_consumed_um2 AS DOUBLE))
      comment: "Total silicon area (µm²) consumed by IP core usage"
    - name: "total_power_contribution_mw"
      expr: SUM(CAST(power_contribution_mw AS DOUBLE))
      comment: "Total power contribution (mW) from IP core usage"
    - name: "average_clock_frequency_mhz"
      expr: AVG(CAST(clock_frequency_mhz AS DOUBLE))
      comment: "Average clock frequency (MHz) of used IP cores"
    - name: "silicon_proven_usage_count"
      expr: SUM(CASE WHEN is_silicon_proven THEN 1 ELSE 0 END)
      comment: "Count of usage records where the IP core is silicon proven"
    - name: "count_ip_core_usage"
      expr: COUNT(1)
      comment: "Number of IP core usage records"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`design_tapeout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost, quality, and yield metrics for tapeout events"
  source: "`semiconductors_ecm`.`design`.`tapeout`"
  dimensions:
    - name: "process_node"
      expr: process_node
      comment: "Process node used for the tapeout"
    - name: "foundry_name"
      expr: foundry_name
      comment: "Foundry supplying the manufacturing service"
    - name: "tapeout_status"
      expr: tapeout_status
      comment: "Current status of the tapeout"
    - name: "target_market_segment"
      expr: target_market_segment
      comment: "Market segment targeted by the tapeout"
    - name: "tapeout_month"
      expr: DATE_TRUNC('month', tapeout_date)
      comment: "Month of the tapeout event"
  measures:
    - name: "total_die_size_mm2"
      expr: SUM(CAST(die_size_mm2 AS DOUBLE))
      comment: "Total die size (mm²) across tapeouts"
    - name: "average_expected_yield_pct"
      expr: AVG(CAST(expected_yield_pct AS DOUBLE))
      comment: "Average expected yield percentage"
    - name: "total_nre_cost_usd"
      expr: SUM(CAST(nre_cost_usd AS DOUBLE))
      comment: "Total non‑recurring engineering cost (USD) for tapeouts"
    - name: "drc_clean_count"
      expr: SUM(CASE WHEN drc_clean THEN 1 ELSE 0 END)
      comment: "Number of tapeouts that passed DRC clean check"
    - name: "count_tapeouts"
      expr: COUNT(1)
      comment: "Total number of tapeout records"
$$;