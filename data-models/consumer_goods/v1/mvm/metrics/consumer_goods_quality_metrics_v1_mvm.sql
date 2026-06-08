-- Metric views for domain: quality | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 10:59:38

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`quality_batch_release`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Batch release quality metrics tracking release decisions, rejection rates, GMP compliance, and regulatory hold exposure across manufacturing sites and SKUs. Supports QA leadership in monitoring release throughput, batch rejection trends, and compliance posture."
  source: "`consumer_goods_ecm`.`quality`.`batch_release`"
  dimensions:
    - name: "manufacturing_site_code"
      expr: manufacturing_site_code
      comment: "Manufacturing site where the batch was produced — enables site-level quality benchmarking."
    - name: "release_decision"
      expr: release_decision
      comment: "Final release decision (e.g., Released, Rejected, Conditional) — primary quality outcome dimension."
    - name: "qc_inspection_status"
      expr: qc_inspection_status
      comment: "QC inspection status at time of release — used to segment batches by inspection outcome."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "Indicates whether the batch met GMP compliance requirements — critical for regulatory risk segmentation."
    - name: "regulatory_hold_status"
      expr: regulatory_hold_status
      comment: "Current regulatory hold status of the batch — flags batches under regulatory scrutiny."
    - name: "capa_required_flag"
      expr: capa_required_flag
      comment: "Indicates whether a CAPA was required for this batch release — signals quality deviation severity."
    - name: "batch_size_uom"
      expr: batch_size_uom
      comment: "Unit of measure for batch size — needed for cross-site quantity comparisons."
    - name: "release_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month of batch release — enables trend analysis of release throughput over time."
    - name: "production_month"
      expr: DATE_TRUNC('MONTH', production_date)
      comment: "Month of batch production — supports cycle time analysis from production to release."
  measures:
    - name: "total_batches_released"
      expr: COUNT(1)
      comment: "Total number of batch release records — baseline volume metric for release throughput monitoring."
    - name: "total_released_quantity"
      expr: SUM(CAST(released_quantity AS DOUBLE))
      comment: "Total quantity released to distribution — measures productive output volume cleared by QA."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected during batch release — directly measures material waste and quality failure cost."
    - name: "total_batch_size"
      expr: SUM(CAST(batch_size_quantity AS DOUBLE))
      comment: "Sum of all batch sizes processed through release — denominator for yield and rejection rate calculations."
    - name: "avg_batch_size"
      expr: AVG(CAST(batch_size_quantity AS DOUBLE))
      comment: "Average batch size across release records — used to detect batch size anomalies that may correlate with quality failures."
    - name: "batches_with_capa_required"
      expr: COUNT(CASE WHEN capa_required_flag = TRUE THEN 1 END)
      comment: "Number of batches requiring a CAPA — indicates systemic quality issues demanding corrective action investment."
    - name: "batches_on_regulatory_hold"
      expr: COUNT(CASE WHEN regulatory_hold_status IS NOT NULL AND regulatory_hold_status <> '' THEN 1 END)
      comment: "Number of batches currently under regulatory hold — a leading indicator of regulatory risk and potential supply disruption."
    - name: "gmp_non_compliant_batches"
      expr: COUNT(CASE WHEN gmp_compliance_flag = FALSE THEN 1 END)
      comment: "Count of batches failing GMP compliance — critical metric for regulatory audit readiness and site quality standing."
    - name: "rejected_batches_count"
      expr: COUNT(CASE WHEN release_decision = 'Rejected' THEN 1 END)
      comment: "Number of batches with a rejected release decision — key quality KPI for manufacturing site performance."
    - name: "avg_rejected_quantity_per_batch"
      expr: AVG(CAST(rejected_quantity AS DOUBLE))
      comment: "Average rejected quantity per batch release record — helps identify whether rejections are isolated or systemic across batch sizes."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`quality_capa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CAPA (Corrective and Preventive Action) performance metrics tracking closure rates, overdue actions, cost impact, regulatory reportability, and severity distribution. Enables quality leadership to manage systemic risk and compliance obligations."
  source: "`consumer_goods_ecm`.`quality`.`capa`"
  dimensions:
    - name: "capa_status"
      expr: capa_status
      comment: "Current status of the CAPA (e.g., Open, Closed, In Progress) — primary lifecycle dimension for workload management."
    - name: "capa_type"
      expr: capa_type
      comment: "Type of CAPA (Corrective vs. Preventive) — distinguishes reactive from proactive quality actions."
    - name: "severity"
      expr: severity
      comment: "Severity classification of the CAPA — enables risk-tiered prioritization of quality actions."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the CAPA — used to track high-priority action completion rates."
    - name: "source_type"
      expr: source_type
      comment: "Origin source of the CAPA (e.g., audit, complaint, deviation) — identifies which quality processes generate the most corrective actions."
    - name: "process_area"
      expr: process_area
      comment: "Business process area associated with the CAPA — enables process-level quality performance benchmarking."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for executing the CAPA — supports accountability tracking and resource allocation."
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Indicates whether the CAPA must be reported to a regulatory authority — critical for compliance risk management."
    - name: "gmp_deviation_flag"
      expr: gmp_deviation_flag
      comment: "Flags CAPAs arising from GMP deviations — used to monitor GMP compliance health."
    - name: "customer_impact_flag"
      expr: customer_impact_flag
      comment: "Indicates whether the quality issue had customer-facing impact — links quality performance to customer satisfaction."
    - name: "initiated_month"
      expr: DATE_TRUNC('MONTH', initiated_date)
      comment: "Month the CAPA was initiated — enables trend analysis of quality event frequency over time."
    - name: "cost_impact_currency_code"
      expr: cost_impact_currency_code
      comment: "Currency of the CAPA cost impact — required for multi-currency financial analysis."
  measures:
    - name: "total_capas"
      expr: COUNT(1)
      comment: "Total number of CAPA records — baseline volume metric for quality event load monitoring."
    - name: "open_capas"
      expr: COUNT(CASE WHEN capa_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Number of currently open CAPAs — measures outstanding quality action backlog requiring management attention."
    - name: "closed_capas"
      expr: COUNT(CASE WHEN capa_status = 'Closed' THEN 1 END)
      comment: "Number of closed CAPAs — measures quality action resolution throughput."
    - name: "overdue_capas"
      expr: COUNT(CASE WHEN target_completion_date < CURRENT_DATE AND capa_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Number of CAPAs past their target completion date and still open — a critical KPI for quality governance and audit readiness."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total financial cost impact of all CAPAs — quantifies the monetary burden of quality failures for executive decision-making."
    - name: "avg_cost_impact_per_capa"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per CAPA — benchmarks the financial severity of quality events and supports cost-of-quality analysis."
    - name: "regulatory_reportable_capas"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Number of CAPAs requiring regulatory reporting — directly measures regulatory compliance exposure."
    - name: "customer_impacting_capas"
      expr: COUNT(CASE WHEN customer_impact_flag = TRUE THEN 1 END)
      comment: "Number of CAPAs with confirmed customer impact — links internal quality failures to external customer experience risk."
    - name: "gmp_deviation_capas"
      expr: COUNT(CASE WHEN gmp_deviation_flag = TRUE THEN 1 END)
      comment: "Number of CAPAs originating from GMP deviations — key indicator of manufacturing compliance health."
    - name: "avg_days_to_close"
      expr: AVG(CAST(DATEDIFF(closure_date, initiated_date) AS DOUBLE))
      comment: "Average calendar days from CAPA initiation to closure — measures quality action resolution speed and process efficiency."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`quality_inspection_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection lot quality metrics covering inspection outcomes, disposition decisions, defect rates, regulatory holds, and lot quantity throughput. Supports QA and supply chain teams in monitoring incoming and in-process inspection performance."
  source: "`consumer_goods_ecm`.`quality`.`inspection_lot`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection lot (e.g., In Progress, Completed, Rejected) — primary lifecycle dimension."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed (e.g., Incoming, In-Process, Final) — enables performance benchmarking by inspection stage."
    - name: "disposition_outcome"
      expr: disposition_outcome
      comment: "Final disposition of the lot (e.g., Accept, Reject, Rework) — key quality outcome dimension."
    - name: "usage_decision"
      expr: usage_decision
      comment: "Usage decision applied to the lot — determines downstream supply chain action."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "Indicates GMP compliance status of the inspection lot — critical for regulatory risk segmentation."
    - name: "regulatory_hold_flag"
      expr: regulatory_hold_flag
      comment: "Flags lots under regulatory hold — identifies supply at risk of regulatory action."
    - name: "inspection_priority"
      expr: inspection_priority
      comment: "Priority level of the inspection — used to monitor high-priority inspection completion rates."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where the inspection was performed — enables site-level quality benchmarking."
    - name: "lot_origin_type"
      expr: lot_origin_type
      comment: "Origin type of the lot (e.g., Purchased, Manufactured) — distinguishes supplier vs. internal quality performance."
    - name: "inspection_start_month"
      expr: DATE_TRUNC('MONTH', inspection_start_date)
      comment: "Month inspection started — enables trend analysis of inspection volume and outcomes over time."
    - name: "lot_quantity_uom"
      expr: lot_quantity_uom
      comment: "Unit of measure for lot quantity — required for cross-site quantity comparisons."
  measures:
    - name: "total_inspection_lots"
      expr: COUNT(1)
      comment: "Total number of inspection lots — baseline volume metric for inspection throughput monitoring."
    - name: "total_lot_quantity"
      expr: SUM(CAST(lot_quantity AS DOUBLE))
      comment: "Total quantity across all inspection lots — measures the volume of material flowing through quality inspection."
    - name: "total_sample_quantity"
      expr: SUM(CAST(sample_quantity AS DOUBLE))
      comment: "Total sample quantity drawn across inspection lots — monitors sampling coverage and resource consumption."
    - name: "avg_lot_quantity"
      expr: AVG(CAST(lot_quantity AS DOUBLE))
      comment: "Average lot quantity per inspection — used to detect lot size anomalies that may affect inspection adequacy."
    - name: "lots_on_regulatory_hold"
      expr: COUNT(CASE WHEN regulatory_hold_flag = TRUE THEN 1 END)
      comment: "Number of lots currently under regulatory hold — measures supply at risk due to regulatory compliance issues."
    - name: "lots_rejected"
      expr: COUNT(CASE WHEN disposition_outcome = 'Reject' THEN 1 END)
      comment: "Number of lots with a rejection disposition — primary quality failure rate indicator for incoming and in-process inspection."
    - name: "gmp_non_compliant_lots"
      expr: COUNT(CASE WHEN gmp_compliance_flag = FALSE THEN 1 END)
      comment: "Number of inspection lots failing GMP compliance — critical for regulatory audit readiness."
    - name: "avg_inspection_cycle_days"
      expr: AVG(CAST(DATEDIFF(inspection_end_date, inspection_start_date) AS DOUBLE))
      comment: "Average calendar days to complete an inspection — measures inspection process efficiency and identifies bottlenecks."
    - name: "avg_days_to_decision"
      expr: AVG(CAST(DATEDIFF(decision_date, inspection_start_date) AS DOUBLE))
      comment: "Average days from inspection start to usage decision — measures end-to-end quality decision speed impacting supply availability."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`quality_nonconformance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nonconformance event metrics tracking defect volumes, financial impact, severity distribution, regulatory reportability, and resolution cycle times. Enables quality and operations leadership to manage product quality risk and cost of poor quality."
  source: "`consumer_goods_ecm`.`quality`.`nonconformance`"
  dimensions:
    - name: "nonconformance_status"
      expr: nonconformance_status
      comment: "Current status of the nonconformance event (e.g., Open, Closed, Under Investigation) — primary lifecycle dimension."
    - name: "event_type"
      expr: event_type
      comment: "Type of nonconformance event — categorizes quality failures for root cause trend analysis."
    - name: "defect_classification"
      expr: defect_classification
      comment: "Classification of the defect (e.g., Critical, Major, Minor) — enables risk-tiered quality management."
    - name: "severity"
      expr: severity
      comment: "Severity level of the nonconformance — used to prioritize investigation and containment resources."
    - name: "detection_source"
      expr: detection_source
      comment: "Where the nonconformance was detected (e.g., Incoming Inspection, Customer Return) — identifies quality control effectiveness by stage."
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Disposition applied to the nonconforming material (e.g., Scrap, Rework, Return to Supplier) — measures material recovery vs. write-off rates."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for the nonconformance — supports accountability and resource allocation decisions."
    - name: "responsible_plant_code"
      expr: responsible_plant_code
      comment: "Plant code responsible for the nonconformance — enables site-level quality benchmarking."
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Indicates whether the nonconformance must be reported to regulators — critical compliance risk dimension."
    - name: "priority"
      expr: priority
      comment: "Priority level of the nonconformance — used to track high-priority event resolution rates."
    - name: "detected_month"
      expr: DATE_TRUNC('MONTH', detected_timestamp)
      comment: "Month the nonconformance was detected — enables trend analysis of quality event frequency."
    - name: "financial_impact_currency"
      expr: financial_impact_currency
      comment: "Currency of the financial impact amount — required for multi-currency cost-of-quality analysis."
  measures:
    - name: "total_nonconformances"
      expr: COUNT(1)
      comment: "Total number of nonconformance events — baseline volume metric for quality event load monitoring."
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS DOUBLE))
      comment: "Total quantity of material affected by nonconformances — measures the scale of quality failures impacting supply."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial cost of nonconformance events — the primary cost-of-poor-quality metric for executive decision-making."
    - name: "avg_financial_impact_per_event"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per nonconformance event — benchmarks the monetary severity of quality failures."
    - name: "open_nonconformances"
      expr: COUNT(CASE WHEN nonconformance_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Number of currently open nonconformance events — measures outstanding quality risk backlog."
    - name: "regulatory_reportable_events"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Number of nonconformances requiring regulatory reporting — directly measures regulatory compliance exposure."
    - name: "critical_nonconformances"
      expr: COUNT(CASE WHEN defect_classification = 'Critical' THEN 1 END)
      comment: "Number of critical-severity nonconformances — highest-priority quality events requiring immediate executive attention."
    - name: "avg_days_to_close"
      expr: AVG(CAST(DATEDIFF(closed_timestamp, detected_timestamp) AS DOUBLE))
      comment: "Average days from detection to closure of nonconformance events — measures quality resolution speed and process efficiency."
    - name: "avg_days_to_containment"
      expr: AVG(CAST(DATEDIFF(containment_timestamp, detected_timestamp) AS DOUBLE))
      comment: "Average days from detection to containment action — measures how quickly quality teams stop the spread of defective material."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`quality_product_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer product complaint metrics tracking complaint volumes, severity, regulatory reportability, investigation cycle times, and resolution outcomes. Enables quality, regulatory, and brand teams to manage consumer safety risk and brand reputation."
  source: "`consumer_goods_ecm`.`quality`.`product_complaint`"
  dimensions:
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current status of the complaint (e.g., Open, Closed, Under Investigation) — primary lifecycle dimension."
    - name: "complaint_category"
      expr: complaint_category
      comment: "Category of the complaint (e.g., Foreign Object, Labeling, Efficacy) — identifies the most common consumer quality issues."
    - name: "complaint_subcategory"
      expr: complaint_subcategory
      comment: "Subcategory providing granular complaint classification — enables detailed root cause trend analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the complaint (e.g., Critical, Serious, Minor) — used to prioritize investigation resources and regulatory reporting."
    - name: "complaint_source"
      expr: complaint_source
      comment: "Channel through which the complaint was received (e.g., Consumer Hotline, Retailer, Social Media) — identifies high-risk complaint intake channels."
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Indicates whether the complaint must be reported to a regulatory authority — critical for compliance risk management."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the complaint investigation — monitors investigation backlog and completion rates."
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Final resolution of the complaint — measures complaint resolution quality and consumer satisfaction outcomes."
    - name: "complainant_country_code"
      expr: complainant_country_code
      comment: "Country of the complainant — enables geographic analysis of complaint patterns and market-specific quality risks."
    - name: "sample_returned_flag"
      expr: sample_returned_flag
      comment: "Indicates whether a product sample was returned for lab analysis — measures investigation evidence quality."
    - name: "complaint_received_month"
      expr: DATE_TRUNC('MONTH', complaint_received_timestamp)
      comment: "Month the complaint was received — enables trend analysis of complaint volumes over time."
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total number of product complaints received — baseline volume metric for consumer quality risk monitoring."
    - name: "open_complaints"
      expr: COUNT(CASE WHEN complaint_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Number of currently open complaints — measures outstanding consumer quality risk backlog."
    - name: "regulatory_reportable_complaints"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Number of complaints requiring regulatory reporting — directly measures regulatory compliance exposure from consumer feedback."
    - name: "complaints_with_sample_returned"
      expr: COUNT(CASE WHEN sample_returned_flag = TRUE THEN 1 END)
      comment: "Number of complaints where a product sample was returned — measures the proportion of complaints with physical evidence for investigation."
    - name: "avg_days_to_investigation_completion"
      expr: AVG(CAST(DATEDIFF(investigation_completion_date, investigation_start_date) AS DOUBLE))
      comment: "Average days to complete a complaint investigation — measures investigation process efficiency and regulatory compliance with response timelines."
    - name: "avg_days_to_resolution"
      expr: AVG(CAST(DATEDIFF(resolution_date, incident_date) AS DOUBLE))
      comment: "Average days from incident date to complaint resolution — end-to-end complaint handling speed metric impacting consumer satisfaction and regulatory standing."
    - name: "critical_complaints"
      expr: COUNT(CASE WHEN severity_level = 'Critical' THEN 1 END)
      comment: "Number of critical-severity complaints — highest-priority consumer safety events requiring immediate executive escalation."
    - name: "complaints_pending_investigation"
      expr: COUNT(CASE WHEN investigation_status NOT IN ('Completed', 'Closed') AND investigation_status IS NOT NULL THEN 1 END)
      comment: "Number of complaints with an incomplete investigation — measures investigation backlog and resource adequacy."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`quality_inspection_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection result metrics tracking test pass/fail rates, out-of-specification findings, control chart violations, and measurement quality. Enables QA teams to monitor product specification compliance and laboratory performance."
  source: "`consumer_goods_ecm`.`quality`.`inspection_result`"
  dimensions:
    - name: "result_status"
      expr: result_status
      comment: "Pass/Fail/Pending status of the inspection result — primary quality outcome dimension."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the inspection result — indicates whether the result has been reviewed and approved by QA."
    - name: "inspection_characteristic_name"
      expr: inspection_characteristic_name
      comment: "Name of the quality characteristic being tested — enables analysis of which characteristics drive the most failures."
    - name: "defect_severity"
      expr: defect_severity
      comment: "Severity of the defect identified in the result — used to prioritize quality investigations."
    - name: "defect_code"
      expr: defect_code
      comment: "Standardized defect code — enables Pareto analysis of defect types driving quality failures."
    - name: "laboratory_code"
      expr: laboratory_code
      comment: "Laboratory where the test was performed — enables lab-level performance benchmarking."
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Indicates whether the result must be reported to regulators — critical compliance risk dimension."
    - name: "control_chart_violation_flag"
      expr: control_chart_violation_flag
      comment: "Flags results that violated statistical process control rules — identifies out-of-control manufacturing processes."
    - name: "retest_indicator"
      expr: retest_indicator
      comment: "Indicates whether this result is from a retest — measures retest frequency as a quality process efficiency indicator."
    - name: "coa_inclusion_flag"
      expr: coa_inclusion_flag
      comment: "Indicates whether this result is included on the Certificate of Analysis — identifies customer-facing quality data."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_timestamp)
      comment: "Month the inspection was performed — enables trend analysis of test volumes and failure rates over time."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the measured value — required for cross-characteristic comparisons."
  measures:
    - name: "total_inspection_results"
      expr: COUNT(1)
      comment: "Total number of inspection results — baseline volume metric for laboratory and inspection throughput."
    - name: "failed_results"
      expr: COUNT(CASE WHEN result_status = 'Fail' THEN 1 END)
      comment: "Number of failed inspection results — primary quality failure rate numerator for specification compliance monitoring."
    - name: "control_chart_violations"
      expr: COUNT(CASE WHEN control_chart_violation_flag = TRUE THEN 1 END)
      comment: "Number of results violating statistical process control rules — identifies out-of-control manufacturing processes requiring immediate intervention."
    - name: "retest_results"
      expr: COUNT(CASE WHEN retest_indicator = TRUE THEN 1 END)
      comment: "Number of retest results — measures rework burden on the laboratory and signals potential specification or process instability."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across inspection results — used to monitor process centering relative to target specifications."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target specification value — provides the benchmark for comparing measured values against intended quality targets."
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty across results — monitors laboratory measurement system capability and reliability."
    - name: "regulatory_reportable_results"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Number of inspection results requiring regulatory reporting — measures regulatory compliance exposure from test findings."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`quality_usage_decision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Usage decision metrics tracking accepted, rejected, and rework quantities, decision cycle times, regulatory holds, and GMP compliance outcomes. Enables supply chain and QA leadership to monitor material disposition efficiency and quality gate performance."
  source: "`consumer_goods_ecm`.`quality`.`usage_decision`"
  dimensions:
    - name: "decision_code"
      expr: decision_code
      comment: "Standardized decision code applied to the lot (e.g., Accept, Reject, Rework) — primary quality gate outcome dimension."
    - name: "disposition_status"
      expr: disposition_status
      comment: "Current disposition status of the material — tracks whether disposition actions have been completed."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection that led to this usage decision — enables performance analysis by inspection stage."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "GMP compliance status at time of usage decision — critical for regulatory audit readiness."
    - name: "regulatory_hold_flag"
      expr: regulatory_hold_flag
      comment: "Indicates whether the lot is under regulatory hold — identifies supply at risk of regulatory action."
    - name: "capa_required_flag"
      expr: capa_required_flag
      comment: "Indicates whether a CAPA was required as part of the usage decision — signals quality deviation severity."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Indicates whether formal approval was required for the decision — used to monitor approval workflow compliance."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where the usage decision was made — enables site-level quality gate performance benchmarking."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month the usage decision was made — enables trend analysis of disposition outcomes over time."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for accepted/rejected/rework quantities — required for cross-site quantity comparisons."
  measures:
    - name: "total_usage_decisions"
      expr: COUNT(1)
      comment: "Total number of usage decisions made — baseline volume metric for quality gate throughput monitoring."
    - name: "total_quantity_accepted"
      expr: SUM(CAST(quantity_accepted AS DOUBLE))
      comment: "Total quantity accepted through quality gates — measures productive material flow cleared for use or distribution."
    - name: "total_quantity_rejected"
      expr: SUM(CAST(quantity_rejected AS DOUBLE))
      comment: "Total quantity rejected at quality gates — directly measures material waste and quality failure cost."
    - name: "total_quantity_rework"
      expr: SUM(CAST(quantity_rework AS DOUBLE))
      comment: "Total quantity sent for rework — measures the volume of material requiring additional processing due to quality failures."
    - name: "avg_quantity_accepted"
      expr: AVG(CAST(quantity_accepted AS DOUBLE))
      comment: "Average accepted quantity per usage decision — used to benchmark acceptance rates across sites and inspection types."
    - name: "avg_quantity_rejected"
      expr: AVG(CAST(quantity_rejected AS DOUBLE))
      comment: "Average rejected quantity per usage decision — identifies whether rejections are concentrated in specific lots or systemic."
    - name: "lots_on_regulatory_hold"
      expr: COUNT(CASE WHEN regulatory_hold_flag = TRUE THEN 1 END)
      comment: "Number of lots under regulatory hold at time of usage decision — measures supply at risk due to regulatory compliance issues."
    - name: "decisions_requiring_capa"
      expr: COUNT(CASE WHEN capa_required_flag = TRUE THEN 1 END)
      comment: "Number of usage decisions that triggered a CAPA requirement — measures the frequency of quality failures requiring systemic corrective action."
    - name: "avg_days_to_decision"
      expr: AVG(CAST(DATEDIFF(decision_date, record_created_timestamp) AS DOUBLE))
      comment: "Average days from record creation to usage decision — measures quality gate decision speed impacting supply availability."
$$;