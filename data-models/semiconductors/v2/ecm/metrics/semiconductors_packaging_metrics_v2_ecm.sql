-- Metric views for domain: packaging | Business: Semiconductors | Version: 2 | Generated on: 2026-06-23 23:34:49

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_assembly_yield`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core packaging yield KPIs tracking step-level and cumulative assembly yield, fallout rates, and DPPM across assembly lots and process steps. Used by operations and quality leadership to steer yield improvement programs."
  source: "`vibe_semiconductors_v1`.`packaging`.`assembly_yield`"
  dimensions:
    - name: "process_step"
      expr: process_step
      comment: "Assembly process step name for yield breakdown by step (die attach, wire bond, mold, etc.)"
    - name: "step_sequence"
      expr: step_sequence
      comment: "Ordered sequence of the assembly step within the process flow for trend analysis"
    - name: "assembly_yield_status"
      expr: assembly_yield_status
      comment: "Current status of the yield record (pass, fail, under review) for filtering active vs. closed records"
    - name: "scrap_reason_code"
      expr: scrap_reason_code
      comment: "Reason code for scrapped units — key dimension for Pareto analysis of yield loss drivers"
    - name: "recorded_date"
      expr: DATE_TRUNC('day', recorded_timestamp)
      comment: "Day the yield record was captured — enables daily yield trend analysis"
    - name: "recorded_month"
      expr: DATE_TRUNC('month', recorded_timestamp)
      comment: "Month the yield record was captured — enables monthly yield trend and target tracking"
  measures:
    - name: "avg_step_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average step-level yield percentage across assembly lots. Primary KPI for monitoring packaging line health and identifying underperforming steps."
    - name: "avg_cumulative_yield_percent"
      expr: AVG(CAST(cumulative_yield_percent AS DOUBLE))
      comment: "Average cumulative yield through all completed steps. Reflects end-to-end assembly efficiency and directly impacts unit cost."
    - name: "avg_dppm"
      expr: AVG(CAST(dppm AS DOUBLE))
      comment: "Average defective parts per million at the step level. Key quality KPI used in customer scorecards and supplier negotiations."
    - name: "avg_fallout_rate"
      expr: AVG(CAST(fallout_rate AS DOUBLE))
      comment: "Average fallout rate per step. Drives scrap cost and rework decisions; monitored against SPC control limits."
    - name: "avg_yield_rate"
      expr: AVG(CAST(yield_rate AS DOUBLE))
      comment: "Average yield rate (ratio form) across all step records. Used for statistical process control and capability analysis."
    - name: "total_yield_records"
      expr: COUNT(1)
      comment: "Total number of yield records captured. Baseline volume metric for normalizing yield KPIs and assessing data completeness."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_assembly_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assembly order throughput, cost, and quality KPIs for packaging operations. Enables leadership to track order fulfillment efficiency, cost performance, and yield against plan."
  source: "`vibe_semiconductors_v1`.`packaging`.`assembly_order`"
  dimensions:
    - name: "assembly_order_status"
      expr: assembly_order_status
      comment: "Current status of the assembly order (open, in-progress, completed, on-hold) for pipeline and backlog analysis"
    - name: "assembly_site"
      expr: assembly_site
      comment: "Physical OSAT site where assembly is performed — key dimension for site-level performance benchmarking"
    - name: "priority"
      expr: priority
      comment: "Order priority level (critical, high, normal) for escalation and capacity allocation decisions"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of order cost amounts for multi-currency cost reporting"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Inspection outcome for the assembly order — used to track quality gate pass rates"
    - name: "order_source"
      expr: order_source
      comment: "Origin of the assembly order (customer pull, forecast, NPI) for demand-type analysis"
    - name: "hold_flag"
      expr: hold_flag
      comment: "Indicates whether the order is currently on hold — used to monitor blocked capacity"
    - name: "release_month"
      expr: DATE_TRUNC('month', release_date)
      comment: "Month the order was released to production — enables monthly order release trend analysis"
    - name: "completion_month"
      expr: DATE_TRUNC('month', completion_date)
      comment: "Month the order was completed — used for on-time delivery and cycle time analysis"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of assembly orders. Baseline throughput metric for capacity planning and operational load assessment."
    - name: "total_gross_cost_usd"
      expr: SUM(CAST(cost_gross_amount AS DOUBLE))
      comment: "Total gross assembly cost across all orders. Primary cost KPI for packaging P&L and OSAT spend management."
    - name: "total_net_cost_usd"
      expr: SUM(CAST(cost_net_amount AS DOUBLE))
      comment: "Total net assembly cost after adjustments. Used for actual cost reporting and margin analysis."
    - name: "total_cost_adjustment_usd"
      expr: SUM(CAST(cost_adjustment_amount AS DOUBLE))
      comment: "Total cost adjustments (credits, penalties, rework charges) applied to assembly orders. Monitors OSAT billing accuracy."
    - name: "avg_actual_yield_percent"
      expr: AVG(CAST(actual_yield_percent AS DOUBLE))
      comment: "Average actual yield percentage across assembly orders. Compared against expected yield to identify systematic yield gaps."
    - name: "avg_expected_yield_percent"
      expr: AVG(CAST(expected_yield_percent AS DOUBLE))
      comment: "Average expected yield percentage at order creation. Baseline for yield variance analysis."
    - name: "yield_gap_percent"
      expr: AVG(CAST(actual_yield_percent AS DOUBLE)) - AVG(CAST(expected_yield_percent AS DOUBLE))
      comment: "Average gap between actual and expected yield. Negative values indicate underperformance vs. plan — triggers OSAT review."
    - name: "orders_on_hold"
      expr: COUNT(CASE WHEN hold_flag = TRUE THEN 1 END)
      comment: "Number of assembly orders currently on hold. Monitors blocked capacity and supply chain disruption impact."
    - name: "avg_gross_cost_per_order"
      expr: AVG(CAST(cost_gross_amount AS DOUBLE))
      comment: "Average gross cost per assembly order. Used for unit economics benchmarking across OSAT partners and package types."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_assembly_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assembly lot-level WIP, yield, cost, and quality KPIs. Provides operations and supply chain leadership with real-time visibility into lot status, cumulative yield, and cost performance."
  source: "`vibe_semiconductors_v1`.`packaging`.`assembly_lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the assembly lot (in-process, completed, scrapped, on-hold) for WIP pipeline analysis"
    - name: "wip_status"
      expr: wip_status
      comment: "Detailed WIP stage of the lot within the assembly flow for granular in-process tracking"
    - name: "quality_status"
      expr: quality_status
      comment: "Quality disposition of the lot (pass, fail, conditional release) for quality gate monitoring"
    - name: "assembly_site"
      expr: assembly_site
      comment: "OSAT site where the lot is being assembled — enables site-level yield and cost benchmarking"
    - name: "hold_flag"
      expr: hold_flag
      comment: "Indicates whether the lot is on hold — used to track blocked inventory and capacity"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for cost reporting — supports multi-currency cost consolidation"
    - name: "start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the assembly lot was started — enables monthly WIP intake trend analysis"
    - name: "target_completion_month"
      expr: DATE_TRUNC('month', target_completion_date)
      comment: "Target completion month for the lot — used for delivery schedule adherence tracking"
  measures:
    - name: "total_lots"
      expr: COUNT(1)
      comment: "Total number of assembly lots. Baseline WIP volume metric for capacity and throughput management."
    - name: "lots_on_hold"
      expr: COUNT(CASE WHEN hold_flag = TRUE THEN 1 END)
      comment: "Number of assembly lots currently on hold. Monitors supply chain disruptions and quality escapes impacting WIP."
    - name: "avg_cumulative_yield_percent"
      expr: AVG(CAST(cumulative_yield_percent AS DOUBLE))
      comment: "Average cumulative yield across all assembly lots. Primary packaging yield KPI for executive dashboards and OSAT scorecards."
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density AS DOUBLE))
      comment: "Average defect density per lot. Tracks packaging quality trends and drives corrective action prioritization."
    - name: "total_cost_estimate_usd"
      expr: SUM(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Total estimated assembly cost across all lots. Used for WIP cost exposure and budget variance reporting."
    - name: "avg_cost_estimate_usd"
      expr: AVG(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Average estimated cost per assembly lot. Benchmarks OSAT cost efficiency and supports pricing decisions."
    - name: "distinct_active_lots"
      expr: COUNT(DISTINCT CASE WHEN lot_status NOT IN ('completed', 'scrapped') THEN assembly_lot_id END)
      comment: "Count of distinct lots currently active in the assembly pipeline. Key WIP inventory metric for capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_assembly_defect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assembly defect analysis KPIs for quality management. Tracks defect rates, DPPM, severity distribution, and disposition outcomes to drive root cause analysis and corrective action programs."
  source: "`vibe_semiconductors_v1`.`packaging`.`assembly_defect`"
  dimensions:
    - name: "defect_type"
      expr: defect_type
      comment: "Type of assembly defect (wire bond open, delamination, void, etc.) — primary Pareto dimension for defect analysis"
    - name: "defect_category"
      expr: defect_category
      comment: "Defect category grouping for higher-level quality trend analysis and reporting"
    - name: "defect_code"
      expr: defect_code
      comment: "Standardized defect code for cross-site and cross-period defect tracking"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the defect (critical, major, minor) — drives escalation and containment decisions"
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the defect (scrap, rework, use-as-is) — tracks quality cost and containment effectiveness"
    - name: "assembly_defect_status"
      expr: assembly_defect_status
      comment: "Current status of the defect record (open, closed, under investigation) for defect backlog management"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the defect is classified as critical — used to prioritize escalation and CAPA actions"
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause category of the defect — key dimension for systemic quality improvement programs"
    - name: "shift"
      expr: shift
      comment: "Production shift during which the defect was detected — used for shift-level quality performance analysis"
    - name: "detection_month"
      expr: DATE_TRUNC('month', detection_timestamp)
      comment: "Month the defect was detected — enables monthly defect trend and escape rate analysis"
  measures:
    - name: "total_defect_records"
      expr: COUNT(1)
      comment: "Total number of defect records. Baseline defect volume metric for trend analysis and quality reporting."
    - name: "critical_defect_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical defects. Directly impacts customer quality commitments and triggers mandatory CAPA escalation."
    - name: "avg_dppm"
      expr: AVG(CAST(dppm AS DOUBLE))
      comment: "Average DPPM (defective parts per million) across defect records. Primary customer-facing quality KPI for OSAT scorecards."
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measured defect parameter value (e.g., void size, bond pull strength). Used for SPC limit monitoring."
    - name: "hold_defect_count"
      expr: COUNT(CASE WHEN hold_flag = TRUE THEN 1 END)
      comment: "Number of defect records with an active hold. Monitors containment effectiveness and blocked inventory exposure."
    - name: "distinct_lots_with_defects"
      expr: COUNT(DISTINCT primary_assembly_lot_id)
      comment: "Number of distinct assembly lots with at least one defect record. Measures defect spread across the WIP population."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_assembly_step_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Step-level process performance KPIs for assembly operations. Tracks yield, cycle time, material consumption, and process parameter compliance at each assembly step to enable real-time process control."
  source: "`vibe_semiconductors_v1`.`packaging`.`assembly_step_record`"
  dimensions:
    - name: "step_name"
      expr: step_name
      comment: "Name of the assembly process step (die attach, wire bond, encapsulation, etc.) — primary grouping for step-level analysis"
    - name: "step_type"
      expr: step_type
      comment: "Type classification of the step for process flow analysis and benchmarking"
    - name: "step_status"
      expr: step_status
      comment: "Current status of the step record (completed, failed, rework) for WIP and quality gate tracking"
    - name: "is_pass"
      expr: is_pass
      comment: "Pass/fail outcome of the step — primary quality gate dimension for first-pass yield analysis"
    - name: "inspection_result"
      expr: inspection_result
      comment: "Inspection outcome at the step level — used for in-process quality monitoring"
    - name: "defect_type"
      expr: defect_type
      comment: "Type of defect detected at this step — enables step-specific defect Pareto analysis"
    - name: "safety_classification"
      expr: safety_classification
      comment: "Safety classification of the step — used for regulatory compliance and risk reporting"
    - name: "recorded_month"
      expr: DATE_TRUNC('month', recorded_timestamp)
      comment: "Month the step record was captured — enables monthly process performance trend analysis"
  measures:
    - name: "total_step_records"
      expr: COUNT(1)
      comment: "Total number of assembly step records. Baseline throughput metric for process volume and data completeness assessment."
    - name: "first_pass_step_count"
      expr: COUNT(CASE WHEN is_pass = TRUE THEN 1 END)
      comment: "Number of steps that passed on first attempt. Numerator for first-pass yield rate calculation."
    - name: "failed_step_count"
      expr: COUNT(CASE WHEN is_pass = FALSE THEN 1 END)
      comment: "Number of steps that failed. Drives rework cost and cycle time impact analysis."
    - name: "avg_process_yield_percent"
      expr: AVG(CAST(process_yield_percent AS DOUBLE))
      comment: "Average process yield at the step level. Key operational KPI for identifying yield loss hot spots in the assembly flow."
    - name: "avg_temperature_c"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average process temperature across step records. Monitors thermal process compliance and drift from specification."
    - name: "avg_pressure_pa"
      expr: AVG(CAST(pressure_pa AS DOUBLE))
      comment: "Average process pressure across step records. Monitors mechanical process parameter compliance."
    - name: "avg_force_n"
      expr: AVG(CAST(force_n AS DOUBLE))
      comment: "Average bonding or assembly force applied. Critical parameter for wire bond and flip-chip process control."
    - name: "total_material_quantity_used"
      expr: SUM(CAST(material_quantity AS DOUBLE))
      comment: "Total material quantity consumed across all step records. Drives material cost accounting and consumption variance analysis."
    - name: "avg_material_quantity_per_step"
      expr: AVG(CAST(material_quantity AS DOUBLE))
      comment: "Average material quantity consumed per step. Benchmarks material efficiency and identifies over-consumption outliers."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_package_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Package qualification program KPIs tracking qualification status, cost, yield, and cycle time. Used by engineering and product management to manage qualification pipeline and ensure on-time product readiness."
  source: "`vibe_semiconductors_v1`.`packaging`.`package_qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status (in-progress, passed, failed, pending) — primary pipeline health dimension"
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (new product, process change, reliability, customer-specific) for program categorization"
    - name: "qualification_method"
      expr: qualification_method
      comment: "Qualification methodology applied — used for process standardization and audit readiness"
    - name: "qualification_result"
      expr: qualification_result
      comment: "Final result of the qualification (pass, fail, conditional) — drives product release decisions"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk classification of the qualification program — used for resource prioritization and escalation"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the qualification meets all compliance requirements — critical for regulatory and customer approval"
    - name: "external_audit_required"
      expr: external_audit_required
      comment: "Flag indicating whether an external audit is required — impacts qualification timeline and cost planning"
    - name: "approval_month"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month of qualification approval — enables qualification throughput trend analysis"
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the qualification became effective — used for product readiness timeline tracking"
  measures:
    - name: "total_qualifications"
      expr: COUNT(1)
      comment: "Total number of package qualification records. Baseline pipeline volume metric for NPI and product readiness management."
    - name: "passed_qualifications"
      expr: COUNT(CASE WHEN qualification_result = 'pass' THEN 1 END)
      comment: "Number of qualifications that passed. Numerator for qualification pass rate — key NPI success metric."
    - name: "failed_qualifications"
      expr: COUNT(CASE WHEN qualification_result = 'fail' THEN 1 END)
      comment: "Number of failed qualifications. Drives rework cost, schedule impact, and root cause investigation."
    - name: "qualification_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN qualification_result = 'pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of qualifications that passed. Executive KPI for NPI quality and packaging engineering effectiveness."
    - name: "total_qualification_cost_usd"
      expr: SUM(CAST(qualification_cost_usd AS DOUBLE))
      comment: "Total cost incurred for package qualifications. Tracks NPI investment and qualification program spend against budget."
    - name: "avg_qualification_cost_usd"
      expr: AVG(CAST(qualification_cost_usd AS DOUBLE))
      comment: "Average cost per qualification. Benchmarks qualification efficiency across package types and OSAT partners."
    - name: "avg_test_duration_hours"
      expr: AVG(CAST(test_duration_hours AS DOUBLE))
      comment: "Average test duration in hours per qualification. Monitors qualification cycle time and identifies bottlenecks."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield achieved during qualification testing. Validates that qualified packages meet yield targets before production release."
    - name: "avg_test_temperature_c"
      expr: AVG(CAST(test_temperature_c AS DOUBLE))
      comment: "Average test temperature applied during qualification. Monitors stress test condition compliance with qualification standards."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_reliability_stress_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reliability stress test KPIs for packaging qualification and product lifetime assurance. Tracks pass rates, failure modes, MTTF, and stress conditions to support product reliability commitments to customers."
  source: "`vibe_semiconductors_v1`.`packaging`.`reliability_stress_test`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of reliability stress test (HTOL, HAST, TC, ESD, etc.) — primary dimension for reliability program analysis"
    - name: "test_standard"
      expr: test_standard
      comment: "Industry standard governing the test (JEDEC, AEC-Q100, MIL-STD) — used for compliance and customer reporting"
    - name: "reliability_stress_test_status"
      expr: reliability_stress_test_status
      comment: "Current status of the stress test (in-progress, passed, failed, pending review) for pipeline management"
    - name: "pass_flag"
      expr: pass_flag
      comment: "Pass/fail outcome of the stress test — primary quality gate for product reliability certification"
    - name: "failure_mode"
      expr: failure_mode
      comment: "Failure mode observed during the test — key dimension for reliability Pareto and FMEA updates"
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the test result (accept, reject, conditional) — drives product release decisions"
    - name: "test_location"
      expr: test_location
      comment: "Location where the stress test was conducted — enables site-level reliability performance comparison"
    - name: "test_start_month"
      expr: DATE_TRUNC('month', test_start_timestamp)
      comment: "Month the stress test was initiated — enables monthly reliability test throughput trend analysis"
  measures:
    - name: "total_stress_tests"
      expr: COUNT(1)
      comment: "Total number of reliability stress tests conducted. Baseline metric for reliability program throughput and qualification pipeline management."
    - name: "passed_tests"
      expr: COUNT(CASE WHEN pass_flag = TRUE THEN 1 END)
      comment: "Number of stress tests that passed. Numerator for reliability pass rate — key product certification KPI."
    - name: "failed_tests"
      expr: COUNT(CASE WHEN pass_flag = FALSE THEN 1 END)
      comment: "Number of stress tests that failed. Drives failure analysis, design review, and qualification re-run decisions."
    - name: "reliability_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reliability stress tests that passed. Executive KPI for product reliability program health and customer commitment fulfillment."
    - name: "avg_mttf_hours"
      expr: AVG(CAST(mttf_hours AS DOUBLE))
      comment: "Average mean time to failure across stress tests. Core reliability metric used in product lifetime guarantees and warranty cost modeling."
    - name: "avg_temperature_c"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average stress test temperature applied. Monitors test condition compliance with qualification standards."
    - name: "avg_humidity_percent"
      expr: AVG(CAST(humidity_percent AS DOUBLE))
      comment: "Average humidity level during stress testing. Monitors environmental stress condition compliance for moisture-sensitive packages."
    - name: "avg_voltage_v"
      expr: AVG(CAST(voltage_v AS DOUBLE))
      comment: "Average voltage applied during electrical stress tests. Monitors electrical overstress condition compliance."
    - name: "avg_result_value"
      expr: AVG(CAST(result_value AS DOUBLE))
      comment: "Average measured result value across stress tests. Tracks reliability metric trends against specification limits."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_material_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incoming material quality and cost KPIs for packaging materials management. Tracks inspection pass rates, quality scores, cost per unit, and compliance status to manage supplier material quality and supply risk."
  source: "`vibe_semiconductors_v1`.`packaging`.`material_lot`"
  dimensions:
    - name: "material_type"
      expr: material_type
      comment: "Type of packaging material (substrate, leadframe, mold compound, solder ball, etc.) — primary dimension for material quality analysis"
    - name: "material_lot_status"
      expr: material_lot_status
      comment: "Current status of the material lot (released, quarantined, rejected, consumed) for inventory and quality management"
    - name: "incoming_inspection_status"
      expr: incoming_inspection_status
      comment: "Result of incoming inspection (pass, fail, conditional) — key supplier quality gate metric"
    - name: "inspection_passed"
      expr: inspection_passed
      comment: "Boolean pass/fail flag for incoming inspection — used for supplier quality scorecard calculations"
    - name: "quarantine_flag"
      expr: quarantine_flag
      comment: "Indicates whether the material lot is under quarantine — monitors supply risk and blocked inventory"
    - name: "compliance_rohs_status"
      expr: compliance_rohs_status
      comment: "RoHS compliance status of the material lot — mandatory for customer and regulatory compliance reporting"
    - name: "compliance_reach_status"
      expr: compliance_reach_status
      comment: "REACH compliance status — required for EU market access and customer substance declarations"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for material cost reporting — supports multi-currency procurement cost analysis"
    - name: "received_month"
      expr: DATE_TRUNC('month', received_date)
      comment: "Month material was received — enables monthly incoming material volume and quality trend analysis"
  measures:
    - name: "total_material_lots"
      expr: COUNT(1)
      comment: "Total number of material lots received. Baseline incoming material volume metric for supply chain and quality management."
    - name: "lots_passed_inspection"
      expr: COUNT(CASE WHEN inspection_passed = TRUE THEN 1 END)
      comment: "Number of material lots that passed incoming inspection. Numerator for supplier incoming quality rate."
    - name: "lots_quarantined"
      expr: COUNT(CASE WHEN quarantine_flag = TRUE THEN 1 END)
      comment: "Number of material lots currently under quarantine. Monitors supply risk and potential production disruption."
    - name: "incoming_inspection_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_passed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of material lots passing incoming inspection. Key supplier quality KPI used in vendor scorecards and sourcing decisions."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of material received across all lots. Tracks incoming material volume for supply planning and inventory management."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average material cost per unit. Benchmarks supplier pricing and tracks material cost inflation trends."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across material lots. Composite supplier quality metric used in vendor performance reviews."
    - name: "total_material_cost_usd"
      expr: SUM(CAST(cost_per_unit AS DOUBLE) * CAST(quantity_received AS DOUBLE))
      comment: "Total estimated material cost (cost per unit × quantity received). Tracks packaging material spend for cost management."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_osat_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OSAT vendor quality and capability KPIs for supplier management. Tracks audit scores, DPPM rates, certification status, and partnership health to support vendor selection, qualification, and performance management decisions."
  source: "`vibe_semiconductors_v1`.`packaging`.`osat_vendor`"
  dimensions:
    - name: "vendor_country"
      expr: vendor_country
      comment: "Country where the OSAT vendor operates — used for geographic supply risk analysis and trade compliance"
    - name: "vendor_type"
      expr: vendor_type
      comment: "Type of OSAT vendor (full turnkey, assembly only, test only) — used for capability segmentation"
    - name: "partnership_status"
      expr: partnership_status
      comment: "Current partnership status (preferred, approved, probationary, disqualified) — primary vendor tier dimension"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the vendor relationship (active, inactive, under review) for vendor portfolio management"
    - name: "capacity_tier"
      expr: capacity_tier
      comment: "Capacity tier classification of the vendor — used for supply allocation and risk diversification decisions"
    - name: "iso_9001_certified"
      expr: iso_9001_certified
      comment: "ISO 9001 certification status — baseline quality management system requirement for vendor approval"
    - name: "aec_q100_certified"
      expr: aec_q100_certified
      comment: "AEC-Q100 automotive qualification status — required for automotive customer supply chain eligibility"
    - name: "iatf_16949_certified"
      expr: iatf_16949_certified
      comment: "IATF 16949 automotive quality certification — key requirement for Tier 1 automotive supply chain participation"
    - name: "last_audit_month"
      expr: DATE_TRUNC('month', last_audit_date)
      comment: "Month of the most recent vendor audit — used for audit recency monitoring and compliance scheduling"
  measures:
    - name: "total_osat_vendors"
      expr: COUNT(1)
      comment: "Total number of OSAT vendors in the portfolio. Baseline metric for supply base size and diversification analysis."
    - name: "preferred_vendor_count"
      expr: COUNT(CASE WHEN partnership_status = 'preferred' THEN 1 END)
      comment: "Number of preferred OSAT vendors. Monitors supply base concentration and preferred partner program health."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average vendor audit score across the OSAT supply base. Primary supplier quality KPI for vendor performance reviews and sourcing decisions."
    - name: "avg_dppm_rate"
      expr: AVG(CAST(dppm_rate AS DOUBLE))
      comment: "Average DPPM rate across OSAT vendors. Tracks outgoing quality performance and drives vendor improvement programs."
    - name: "iso_certified_vendor_count"
      expr: COUNT(CASE WHEN iso_9001_certified = TRUE THEN 1 END)
      comment: "Number of OSAT vendors with ISO 9001 certification. Monitors supply base quality management system compliance."
    - name: "automotive_qualified_vendor_count"
      expr: COUNT(CASE WHEN aec_q100_certified = TRUE THEN 1 END)
      comment: "Number of OSAT vendors qualified to AEC-Q100 automotive standard. Tracks automotive supply chain readiness."
    - name: "nda_protected_vendor_count"
      expr: COUNT(CASE WHEN nda_ip_protection = TRUE THEN 1 END)
      comment: "Number of OSAT vendors with active NDA/IP protection agreements. Monitors IP risk exposure in the supply base."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_inspection_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Packaging inspection quality KPIs tracking defect density, inspection outcomes, and SPC control status. Used by quality engineering and operations to monitor in-process and final inspection performance."
  source: "`vibe_semiconductors_v1`.`packaging`.`inspection_result`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (incoming, in-process, final, outgoing) — primary dimension for inspection stage analysis"
    - name: "inspection_method"
      expr: inspection_method
      comment: "Inspection method used (visual, AOI, X-ray, SEM) — used for method effectiveness analysis"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection record (pass, fail, pending) — primary quality gate dimension"
    - name: "result_status"
      expr: result_status
      comment: "Final result status of the inspection — used for quality disposition reporting"
    - name: "disposition"
      expr: disposition
      comment: "Disposition of inspected units (accept, reject, rework, scrap) — drives quality cost and containment analysis"
    - name: "defect_category"
      expr: defect_category
      comment: "Category of defects found during inspection — primary Pareto dimension for quality improvement programs"
    - name: "defect_severity"
      expr: defect_severity
      comment: "Severity of defects detected (critical, major, minor) — used for risk-based quality prioritization"
    - name: "is_spc_control"
      expr: is_spc_control
      comment: "Indicates whether the inspection is under SPC control — used to track SPC coverage and control plan compliance"
    - name: "inspection_step"
      expr: inspection_step
      comment: "Assembly process step at which inspection occurred — enables step-level quality performance analysis"
    - name: "inspected_month"
      expr: DATE_TRUNC('month', inspected_timestamp)
      comment: "Month of inspection — enables monthly inspection quality trend analysis"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspection records. Baseline inspection volume metric for quality coverage and throughput analysis."
    - name: "passed_inspections"
      expr: COUNT(CASE WHEN inspection_status = 'pass' THEN 1 END)
      comment: "Number of inspections that passed. Numerator for inspection pass rate — key in-process quality KPI."
    - name: "failed_inspections"
      expr: COUNT(CASE WHEN inspection_status = 'fail' THEN 1 END)
      comment: "Number of inspections that failed. Drives containment actions and root cause investigation prioritization."
    - name: "inspection_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_status = 'pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections passing. Executive quality KPI for packaging line health and customer quality commitment tracking."
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density AS DOUBLE))
      comment: "Average defect density per inspection record. Tracks packaging quality trends and drives SPC control limit reviews."
    - name: "spc_controlled_inspection_count"
      expr: COUNT(CASE WHEN is_spc_control = TRUE THEN 1 END)
      comment: "Number of inspections under SPC control. Monitors SPC coverage rate and control plan implementation completeness."
    - name: "distinct_lots_inspected"
      expr: COUNT(DISTINCT primary_assembly_lot_id)
      comment: "Number of distinct assembly lots that have been inspected. Tracks inspection coverage across the WIP population."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Packaging line capacity, yield, and reliability KPIs for operations management. Enables manufacturing leadership to benchmark line performance, track maintenance effectiveness, and optimize capacity utilization."
  source: "`vibe_semiconductors_v1`.`packaging`.`packaging_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current operational status of the packaging line (active, down, maintenance, idle) for capacity availability tracking"
    - name: "line_type"
      expr: line_type
      comment: "Type of packaging line (wire bond, flip chip, advanced packaging) — used for capability and capacity segmentation"
    - name: "classification"
      expr: classification
      comment: "Classification of the packaging line (standard, advanced, automotive) for portfolio analysis"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the line (qualified, in-qualification, suspended) — used for production eligibility tracking"
    - name: "osat_partner"
      expr: osat_partner
      comment: "OSAT partner operating the line — enables partner-level capacity and performance benchmarking"
    - name: "shift_pattern"
      expr: shift_pattern
      comment: "Shift pattern of the line (3-shift, 2-shift, day-only) — used for capacity planning and utilization analysis"
    - name: "safety_classification"
      expr: safety_classification
      comment: "Safety classification of the line — used for regulatory compliance and risk reporting"
  measures:
    - name: "total_packaging_lines"
      expr: COUNT(1)
      comment: "Total number of packaging lines in the portfolio. Baseline capacity asset metric for manufacturing footprint management."
    - name: "active_line_count"
      expr: COUNT(CASE WHEN line_status = 'active' THEN 1 END)
      comment: "Number of currently active packaging lines. Tracks available production capacity for demand fulfillment planning."
    - name: "avg_capacity_per_hour"
      expr: AVG(CAST(capacity_per_hour AS DOUBLE))
      comment: "Average throughput capacity per hour across packaging lines. Key capacity planning metric for production scheduling."
    - name: "total_capacity_per_hour"
      expr: SUM(CAST(capacity_per_hour AS DOUBLE))
      comment: "Total installed packaging capacity per hour. Used for aggregate capacity vs. demand gap analysis."
    - name: "avg_current_yield_percent"
      expr: AVG(CAST(current_yield_percent AS DOUBLE))
      comment: "Average current yield percentage across packaging lines. Monitors line-level yield health and identifies underperforming assets."
    - name: "avg_defect_rate_ppm"
      expr: AVG(CAST(defect_rate_ppm AS DOUBLE))
      comment: "Average defect rate in PPM across packaging lines. Key quality KPI for line performance benchmarking and customer commitments."
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average mean time between failures across packaging lines. Monitors equipment reliability and maintenance program effectiveness."
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average mean time to repair across packaging lines. Tracks maintenance responsiveness and downtime impact on capacity."
    - name: "avg_energy_consumption_kwh"
      expr: AVG(CAST(energy_consumption_kwh AS DOUBLE))
      comment: "Average energy consumption per packaging line. Monitors operational efficiency and supports sustainability reporting."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_assembly_change_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assembly change notice (ACN/PCN) management KPIs tracking change volume, compliance review status, customer notification requirements, and yield/DPPM impact. Used by product management and quality teams to govern packaging change control."
  source: "`vibe_semiconductors_v1`.`packaging`.`assembly_change_notice`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of assembly change (material, process, OSAT site transfer, package redesign) — primary dimension for change impact analysis"
    - name: "change_status"
      expr: change_status
      comment: "Current status of the change notice (draft, under review, approved, rejected, implemented) for change pipeline management"
    - name: "compliance_review_status"
      expr: compliance_review_status
      comment: "Status of the compliance review for the change — monitors regulatory and customer approval gate progress"
    - name: "customer_approval_status"
      expr: customer_approval_status
      comment: "Customer approval status for the change — critical for changes requiring customer notification under PCN agreements"
    - name: "customer_notification_required"
      expr: customer_notification_required
      comment: "Flag indicating whether customer notification is required — used to track PCN obligation fulfillment"
    - name: "qualification_required"
      expr: qualification_required
      comment: "Flag indicating whether re-qualification is required for the change — impacts NPI schedule and cost"
    - name: "regulatory_impact_flag"
      expr: regulatory_impact_flag
      comment: "Flag indicating regulatory impact of the change — triggers compliance review and filing requirements"
    - name: "change_submission_month"
      expr: DATE_TRUNC('month', change_submission_date)
      comment: "Month the change was submitted — enables monthly change volume trend analysis"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the change becomes effective — used for change implementation timeline tracking"
  measures:
    - name: "total_change_notices"
      expr: COUNT(1)
      comment: "Total number of assembly change notices. Baseline change control volume metric for process stability and change management governance."
    - name: "pending_customer_approval_count"
      expr: COUNT(CASE WHEN customer_approval_status NOT IN ('approved', 'not_required') THEN 1 END)
      comment: "Number of change notices awaiting customer approval. Monitors PCN backlog and customer relationship risk."
    - name: "regulatory_impact_count"
      expr: COUNT(CASE WHEN regulatory_impact_flag = TRUE THEN 1 END)
      comment: "Number of changes with regulatory impact. Tracks compliance exposure and regulatory filing workload."
    - name: "requalification_required_count"
      expr: COUNT(CASE WHEN qualification_required = TRUE THEN 1 END)
      comment: "Number of changes requiring re-qualification. Drives NPI resource planning and qualification program scheduling."
    - name: "avg_yield_impact_percent"
      expr: AVG(CAST(impact_on_yield_percent AS DOUBLE))
      comment: "Average yield impact of assembly changes. Quantifies the production risk of change implementation and informs go/no-go decisions."
    - name: "avg_dppm_impact"
      expr: AVG(CAST(impact_on_dppm AS DOUBLE))
      comment: "Average DPPM impact of assembly changes. Monitors quality risk of packaging changes against customer DPPM commitments."
    - name: "changes_with_attachment"
      expr: COUNT(CASE WHEN attachment_flag = TRUE THEN 1 END)
      comment: "Number of change notices with supporting documentation attached. Monitors change documentation completeness for audit readiness."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_customer_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer packaging requirement KPIs tracking specification compliance, cost commitments, and quality targets. Used by sales engineering and product management to ensure packaging solutions meet customer contractual obligations."
  source: "`vibe_semiconductors_v1`.`packaging`.`customer_requirement`"
  dimensions:
    - name: "requirement_type"
      expr: requirement_type
      comment: "Type of customer requirement (dimensional, electrical, thermal, reliability, compliance) — primary dimension for requirement analysis"
    - name: "customer_requirement_status"
      expr: customer_requirement_status
      comment: "Current status of the requirement (active, expired, under negotiation) for contract management"
    - name: "moisture_sensitivity_level"
      expr: moisture_sensitivity_level
      comment: "MSL classification required by the customer — used for packaging and storage compliance tracking"
    - name: "dry_pack_required"
      expr: dry_pack_required
      comment: "Flag indicating whether dry pack shipping is required — impacts packaging cost and logistics planning"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for cost requirement reporting — supports multi-currency contract management"
    - name: "contract_effective_month"
      expr: DATE_TRUNC('month', contract_effective_date)
      comment: "Month the customer requirement contract became effective — used for contract lifecycle management"
    - name: "contract_expiration_month"
      expr: DATE_TRUNC('month', contract_expiration_date)
      comment: "Month the customer requirement contract expires — used for renewal pipeline management"
  measures:
    - name: "total_customer_requirements"
      expr: COUNT(1)
      comment: "Total number of customer packaging requirements. Baseline metric for customer commitment portfolio size and complexity."
    - name: "avg_required_yield_percent"
      expr: AVG(CAST(required_yield_percent AS DOUBLE))
      comment: "Average yield percentage required by customers. Benchmarks customer quality expectations against current packaging capability."
    - name: "avg_packaging_cost_usd"
      expr: AVG(CAST(packaging_cost_usd AS DOUBLE))
      comment: "Average packaging cost committed to customers. Tracks cost commitment exposure and supports pricing strategy decisions."
    - name: "total_packaging_cost_usd"
      expr: SUM(CAST(packaging_cost_usd AS DOUBLE))
      comment: "Total packaging cost committed across all customer requirements. Measures aggregate cost obligation for financial planning."
    - name: "avg_required_mtbf_hours"
      expr: AVG(CAST(required_mtbf_hours AS DOUBLE))
      comment: "Average MTBF requirement across customer contracts. Tracks reliability commitment stringency and capability gap risk."
    - name: "avg_thermal_budget_c"
      expr: AVG(CAST(thermal_budget_c AS DOUBLE))
      comment: "Average thermal budget requirement from customers. Monitors thermal design constraint stringency across the customer portfolio."
    - name: "dry_pack_required_count"
      expr: COUNT(CASE WHEN dry_pack_required = TRUE THEN 1 END)
      comment: "Number of customer requirements mandating dry pack. Quantifies premium packaging obligation and associated cost impact."
    - name: "avg_package_weight_gram"
      expr: AVG(CAST(weight_gram AS DOUBLE))
      comment: "Average package weight requirement across customer specifications. Used for logistics cost modeling and material planning."
$$;