-- Metric views for domain: quality | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 21:06:11

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`quality_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Governance and inspection quality metrics derived from audit records. Tracks audit outcomes, finding severity distribution, regulatory escalation rates, and CAPA linkage — key indicators for quality system health and regulatory readiness."
  source: "`pharmaceuticals_ecm`.`quality`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., internal, supplier, regulatory) used to segment audit performance by program."
    - name: "audit_status"
      expr: audit_status
      comment: "Current lifecycle status of the audit (e.g., planned, in-progress, closed) for pipeline and backlog analysis."
    - name: "overall_audit_outcome"
      expr: overall_audit_outcome
      comment: "Final outcome classification of the audit (e.g., satisfactory, unsatisfactory) for trend and benchmarking analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk tier assigned to the audited entity, enabling prioritization of follow-up actions."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Distinguishes regulatory inspections from internal audits for compliance reporting."
    - name: "capa_required"
      expr: capa_required
      comment: "Boolean flag indicating whether a CAPA was mandated as a result of the audit."
    - name: "form_483_issued"
      expr: form_483_issued
      comment: "Boolean flag indicating FDA Form 483 was issued, a critical regulatory escalation signal."
    - name: "warning_letter_issued"
      expr: warning_letter_issued
      comment: "Boolean flag indicating a regulatory warning letter was issued — highest severity regulatory outcome."
    - name: "planned_audit_year_month"
      expr: DATE_TRUNC('MONTH', planned_audit_date)
      comment: "Month bucket of the planned audit date for scheduling and trend analysis."
    - name: "closure_verification_status"
      expr: closure_verification_status
      comment: "Status of the audit closure verification step, indicating whether corrective actions have been confirmed effective."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audit records. Baseline volume metric for audit program throughput."
    - name: "audits_with_critical_findings"
      expr: COUNT(CASE WHEN critical_findings_count IS NOT NULL AND critical_findings_count != '0' THEN 1 END)
      comment: "Number of audits that recorded at least one critical finding. Directly informs regulatory risk posture and escalation decisions."
    - name: "audits_with_warning_letter"
      expr: COUNT(CASE WHEN warning_letter_issued = TRUE THEN 1 END)
      comment: "Count of audits resulting in a regulatory warning letter. A key executive risk indicator requiring immediate leadership response."
    - name: "audits_with_form_483"
      expr: COUNT(CASE WHEN form_483_issued = TRUE THEN 1 END)
      comment: "Count of audits where FDA Form 483 was issued. Tracks regulatory inspection findings that require formal written response."
    - name: "capa_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN capa_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring a CAPA. High rates signal systemic quality gaps; used in QMS steering reviews."
    - name: "unsatisfactory_outcome_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_audit_outcome = 'Unsatisfactory' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits with an unsatisfactory outcome. A leading indicator of quality system deterioration and regulatory risk."
    - name: "overdue_response_audits"
      expr: COUNT(CASE WHEN response_due_date < CURRENT_DATE AND (response_submitted_date IS NULL OR response_submitted_date > response_due_date) THEN 1 END)
      comment: "Number of audits where the response deadline was missed. Tracks compliance with regulatory response commitments."
    - name: "open_audits"
      expr: COUNT(CASE WHEN audit_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Count of audits not yet closed. Operational backlog metric for quality management resource planning."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`quality_capa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and Preventive Action (CAPA) effectiveness and cycle-time metrics. Tracks CAPA closure rates, overdue actions, effectiveness verification outcomes, and regulatory commitment fulfillment — core KPIs for quality system maturity."
  source: "`pharmaceuticals_ecm`.`quality`.`capa`"
  dimensions:
    - name: "capa_type"
      expr: capa_type
      comment: "Distinguishes corrective actions from preventive actions for separate trend analysis."
    - name: "capa_status"
      expr: capa_status
      comment: "Current lifecycle status of the CAPA (e.g., open, in-progress, closed, overdue)."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk classification of the CAPA, used to prioritize resources and escalation."
    - name: "severity"
      expr: severity
      comment: "Severity rating of the originating quality event, informing urgency and resource allocation."
    - name: "originating_event_type"
      expr: originating_event_type
      comment: "Source event type that triggered the CAPA (e.g., deviation, complaint, audit finding) for root-cause trend analysis."
    - name: "effectiveness_check_required_flag"
      expr: effectiveness_check_required_flag
      comment: "Boolean indicating whether an effectiveness check is mandated for this CAPA."
    - name: "effectiveness_check_result"
      expr: effectiveness_check_result
      comment: "Outcome of the effectiveness verification (e.g., effective, not effective) — key quality system maturity indicator."
    - name: "regulatory_commitment_flag"
      expr: regulatory_commitment_flag
      comment: "Boolean indicating the CAPA is tied to a regulatory commitment, requiring heightened tracking."
    - name: "initiated_year_month"
      expr: DATE_TRUNC('MONTH', initiated_date)
      comment: "Month bucket of CAPA initiation date for trend and aging analysis."
    - name: "root_cause_analysis_method"
      expr: root_cause_analysis_method
      comment: "Method used for root cause analysis (e.g., fishbone, 5-why) to assess investigation rigor."
  measures:
    - name: "total_capas"
      expr: COUNT(1)
      comment: "Total number of CAPA records. Baseline volume metric for quality event burden."
    - name: "open_capas"
      expr: COUNT(CASE WHEN capa_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Count of CAPAs not yet closed. Operational backlog metric for quality team capacity planning."
    - name: "overdue_capas"
      expr: COUNT(CASE WHEN target_completion_date < CURRENT_DATE AND capa_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Number of CAPAs past their target completion date without closure. A critical quality system health indicator reviewed at steering meetings."
    - name: "capa_on_time_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN capa_status = 'Closed' AND actual_completion_date <= target_completion_date THEN 1 END) / NULLIF(COUNT(CASE WHEN capa_status = 'Closed' THEN 1 END), 0), 2)
      comment: "Percentage of closed CAPAs completed on or before the target date. Measures quality team execution discipline and regulatory commitment adherence."
    - name: "effectiveness_check_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN effectiveness_check_result = 'Effective' THEN 1 END) / NULLIF(COUNT(CASE WHEN effectiveness_check_required_flag = TRUE AND effectiveness_check_result IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of completed effectiveness checks that confirmed the CAPA was effective. Core quality system maturity KPI — low rates indicate recurring quality failures."
    - name: "regulatory_commitment_capas"
      expr: COUNT(CASE WHEN regulatory_commitment_flag = TRUE THEN 1 END)
      comment: "Count of CAPAs tied to regulatory commitments. Tracks the volume of quality actions with direct regulatory consequence."
    - name: "avg_capa_cycle_days"
      expr: AVG(DATEDIFF(actual_completion_date, initiated_date))
      comment: "Average number of days from CAPA initiation to actual completion. Measures quality system responsiveness; benchmarked against industry standards."
    - name: "recurrence_risk_capas"
      expr: COUNT(CASE WHEN effectiveness_check_result = 'Not Effective' THEN 1 END)
      comment: "Count of CAPAs where the effectiveness check determined the action was not effective, indicating recurrence risk requiring re-investigation."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`quality_deviation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality deviation tracking metrics covering GMP impact, regulatory reportability, root cause distribution, and closure timeliness. Enables quality leadership to monitor deviation burden, systemic failure patterns, and compliance risk."
  source: "`pharmaceuticals_ecm`.`quality`.`quality_deviation`"
  dimensions:
    - name: "deviation_type"
      expr: deviation_type
      comment: "Classification of the deviation type (e.g., process, equipment, material) for systemic trend analysis."
    - name: "deviation_category"
      expr: deviation_category
      comment: "Business category of the deviation for grouping and benchmarking across product lines and sites."
    - name: "deviation_status"
      expr: deviation_status
      comment: "Current lifecycle status of the deviation record for backlog and aging analysis."
    - name: "gmp_impact_classification"
      expr: gmp_impact_classification
      comment: "GMP impact level (e.g., critical, major, minor) — primary risk stratification dimension for regulatory reporting."
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Boolean indicating the deviation must be reported to a regulatory authority."
    - name: "audit_finding_flag"
      expr: audit_finding_flag
      comment: "Boolean indicating the deviation originated from an audit finding, linking quality events to inspection outcomes."
    - name: "customer_complaint_flag"
      expr: customer_complaint_flag
      comment: "Boolean indicating the deviation is linked to a customer complaint, connecting internal quality to external impact."
    - name: "process_step"
      expr: process_step
      comment: "Manufacturing process step where the deviation occurred, enabling process-level failure hotspot identification."
    - name: "detected_year_month"
      expr: DATE_TRUNC('MONTH', detected_date)
      comment: "Month bucket of deviation detection date for trend and seasonality analysis."
    - name: "final_disposition"
      expr: final_disposition
      comment: "Final batch/material disposition resulting from the deviation (e.g., released, rejected, reworked)."
  measures:
    - name: "total_deviations"
      expr: COUNT(1)
      comment: "Total number of quality deviations. Baseline volume metric for quality event burden tracking."
    - name: "critical_gmp_deviations"
      expr: COUNT(CASE WHEN gmp_impact_classification = 'Critical' THEN 1 END)
      comment: "Count of deviations classified as critical GMP impact. Highest-priority quality risk indicator requiring executive visibility."
    - name: "regulatory_reportable_deviations"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Count of deviations requiring regulatory notification. Tracks compliance obligation volume and associated regulatory risk."
    - name: "regulatory_reportable_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deviations that are regulatory reportable. Trend in this rate signals systemic quality deterioration."
    - name: "open_deviations"
      expr: COUNT(CASE WHEN deviation_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Count of deviations not yet closed. Operational backlog metric for quality team workload management."
    - name: "overdue_investigations"
      expr: COUNT(CASE WHEN investigation_due_date < CURRENT_DATE AND deviation_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Number of deviations where the investigation deadline has passed without closure. Tracks compliance with internal investigation SLAs."
    - name: "avg_investigation_cycle_days"
      expr: AVG(DATEDIFF(investigation_completed_date, detected_date))
      comment: "Average days from deviation detection to investigation completion. Measures quality system responsiveness and investigation efficiency."
    - name: "customer_complaint_linked_deviations"
      expr: COUNT(CASE WHEN customer_complaint_flag = TRUE THEN 1 END)
      comment: "Count of deviations linked to customer complaints. Connects internal quality failures to external customer impact for executive reporting."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`quality_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product complaint management metrics tracking complaint volume, regulatory reportability, patient impact, investigation timeliness, and root cause distribution. Critical for pharmacovigilance linkage, regulatory compliance, and customer quality perception."
  source: "`pharmaceuticals_ecm`.`quality`.`complaint`"
  dimensions:
    - name: "complaint_category"
      expr: complaint_category
      comment: "Primary category of the complaint (e.g., product quality, packaging, labeling) for trend and root cause analysis."
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current lifecycle status of the complaint for backlog and SLA monitoring."
    - name: "complaint_source"
      expr: complaint_source
      comment: "Origin of the complaint (e.g., healthcare professional, patient, distributor) for source-based trend analysis."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Categorized root cause of the complaint for systemic failure pattern identification."
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Boolean indicating the complaint must be reported to a regulatory authority."
    - name: "patient_impact_flag"
      expr: patient_impact_flag
      comment: "Boolean indicating the complaint had a direct patient impact — highest severity classification."
    - name: "investigation_required_flag"
      expr: investigation_required_flag
      comment: "Boolean indicating a formal investigation was required for this complaint."
    - name: "trend_flag"
      expr: trend_flag
      comment: "Boolean indicating the complaint has been flagged as part of a recurring trend, triggering systemic review."
    - name: "received_year_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Month bucket of complaint receipt date for volume trend and seasonality analysis."
    - name: "subcategory"
      expr: subcategory
      comment: "Granular sub-classification of the complaint for detailed root cause drill-down."
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total number of product complaints received. Baseline volume metric for quality and customer satisfaction monitoring."
    - name: "patient_impact_complaints"
      expr: COUNT(CASE WHEN patient_impact_flag = TRUE THEN 1 END)
      comment: "Count of complaints with confirmed patient impact. Highest-priority safety metric requiring immediate executive and regulatory attention."
    - name: "patient_impact_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN patient_impact_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of complaints with patient impact. A rising rate is a critical patient safety signal requiring leadership intervention."
    - name: "regulatory_reportable_complaints"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Count of complaints requiring regulatory reporting. Tracks compliance obligation volume and associated regulatory risk exposure."
    - name: "trending_complaints"
      expr: COUNT(CASE WHEN trend_flag = TRUE THEN 1 END)
      comment: "Count of complaints flagged as part of a recurring trend. Signals systemic product or process failures requiring strategic intervention."
    - name: "open_complaints"
      expr: COUNT(CASE WHEN complaint_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Count of complaints not yet resolved. Operational backlog metric for quality team capacity and SLA management."
    - name: "avg_complaint_response_days"
      expr: AVG(DATEDIFF(response_date, received_date))
      comment: "Average days from complaint receipt to response communication. Measures customer responsiveness and regulatory response SLA adherence."
    - name: "avg_complaint_closure_days"
      expr: AVG(DATEDIFF(closure_date, received_date))
      comment: "Average days from complaint receipt to full closure. End-to-end cycle time KPI for complaint management process efficiency."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`quality_batch_disposition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Batch release and disposition quality metrics tracking release rates, rejection volumes, regulatory holds, and quarantine status. Directly informs supply continuity, manufacturing yield, and regulatory compliance decisions."
  source: "`pharmaceuticals_ecm`.`quality`.`batch_disposition`"
  dimensions:
    - name: "disposition_type"
      expr: disposition_type
      comment: "Type of disposition decision (e.g., release, reject, quarantine, rework) for yield and quality analysis."
    - name: "disposition_status"
      expr: disposition_status
      comment: "Current status of the disposition decision for pipeline and backlog monitoring."
    - name: "quarantine_status"
      expr: quarantine_status
      comment: "Quarantine classification of the batch, indicating hold status and supply risk."
    - name: "regulatory_hold_flag"
      expr: regulatory_hold_flag
      comment: "Boolean indicating the batch is under a regulatory hold — direct supply and compliance risk indicator."
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Boolean indicating the disposition event must be reported to a regulatory authority."
    - name: "market_applicability"
      expr: market_applicability
      comment: "Market or region for which the batch is intended, enabling geographic supply risk analysis."
    - name: "disposition_year_month"
      expr: DATE_TRUNC('MONTH', disposition_date)
      comment: "Month bucket of the disposition date for release trend and supply planning analysis."
    - name: "batch_size_uom"
      expr: batch_size_uom
      comment: "Unit of measure for batch size, required for normalized yield calculations across product types."
  measures:
    - name: "total_batches_dispositioned"
      expr: COUNT(1)
      comment: "Total number of batch disposition records. Baseline throughput metric for manufacturing and quality release operations."
    - name: "total_released_quantity"
      expr: SUM(CAST(released_quantity AS DOUBLE))
      comment: "Total quantity of product released to market. Core supply output metric directly linked to revenue availability."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity of product rejected. Measures manufacturing waste and quality failure impact on supply."
    - name: "batch_rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(rejected_quantity AS DOUBLE)) / NULLIF(SUM(CAST(batch_size AS DOUBLE)), 0), 2)
      comment: "Percentage of total batch quantity rejected. Key manufacturing quality yield KPI — rising rates signal process or material failures."
    - name: "regulatory_hold_batches"
      expr: COUNT(CASE WHEN regulatory_hold_flag = TRUE THEN 1 END)
      comment: "Count of batches under regulatory hold. Tracks supply risk from regulatory compliance issues requiring executive escalation."
    - name: "avg_batch_size"
      expr: AVG(CAST(batch_size AS DOUBLE))
      comment: "Average batch size across dispositioned batches. Used for capacity planning and yield normalization."
    - name: "total_batch_quantity"
      expr: SUM(CAST(batch_size AS DOUBLE))
      comment: "Total batch quantity processed through disposition. Denominator for yield and rejection rate calculations."
    - name: "regulatory_reportable_dispositions"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Count of disposition events requiring regulatory reporting. Tracks compliance obligation volume from batch quality failures."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`quality_oos_investigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Out-of-Specification (OOS) investigation metrics tracking investigation phase completion, root cause identification rates, laboratory error attribution, regulatory reporting obligations, and cycle times. Critical for analytical quality assurance and regulatory compliance."
  source: "`pharmaceuticals_ecm`.`quality`.`oos_investigation`"
  dimensions:
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the OOS investigation (e.g., open, phase I, phase II, closed) for pipeline monitoring."
    - name: "investigation_conclusion"
      expr: investigation_conclusion
      comment: "Final conclusion of the OOS investigation (e.g., assignable cause found, inconclusive) for quality trend analysis."
    - name: "assignability_determination"
      expr: assignability_determination
      comment: "Determination of whether the OOS result is assignable to a specific cause — key regulatory decision point."
    - name: "laboratory_error_identified"
      expr: laboratory_error_identified
      comment: "Boolean indicating a laboratory error was identified as the root cause, distinguishing lab errors from true product failures."
    - name: "root_cause_identified"
      expr: root_cause_identified
      comment: "Boolean indicating whether a definitive root cause was identified for the OOS result."
    - name: "phase_ii_required"
      expr: phase_ii_required
      comment: "Boolean indicating Phase II (full-scale) investigation was required, signaling more complex quality failures."
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required
      comment: "Boolean indicating the OOS investigation outcome must be reported to a regulatory authority."
    - name: "retest_authorized"
      expr: retest_authorized
      comment: "Boolean indicating retesting was authorized as part of the investigation protocol."
    - name: "initiated_year_month"
      expr: DATE_TRUNC('MONTH', initiated_date)
      comment: "Month bucket of OOS investigation initiation for trend and volume analysis."
    - name: "test_parameter"
      expr: test_parameter
      comment: "Analytical test parameter that generated the OOS result, enabling parameter-level failure hotspot identification."
  measures:
    - name: "total_oos_investigations"
      expr: COUNT(1)
      comment: "Total number of OOS investigations initiated. Baseline metric for analytical quality failure burden."
    - name: "open_oos_investigations"
      expr: COUNT(CASE WHEN investigation_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Count of OOS investigations not yet closed. Operational backlog metric for laboratory quality team management."
    - name: "root_cause_identification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN root_cause_identified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OOS investigations where a definitive root cause was identified. Measures investigation quality and analytical rigor."
    - name: "laboratory_error_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN laboratory_error_identified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OOS results attributable to laboratory error. High rates indicate analytical method or analyst training issues."
    - name: "phase_ii_escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN phase_ii_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OOS investigations requiring Phase II full-scale investigation. Indicates severity and complexity of quality failures."
    - name: "regulatory_reportable_oos"
      expr: COUNT(CASE WHEN regulatory_reporting_required = TRUE THEN 1 END)
      comment: "Count of OOS investigations requiring regulatory reporting. Tracks compliance obligation volume from analytical failures."
    - name: "avg_oos_investigation_cycle_days"
      expr: AVG(DATEDIFF(investigation_closed_date, initiated_date))
      comment: "Average days from OOS initiation to investigation closure. Measures investigation efficiency against regulatory and internal SLA benchmarks."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`quality_lab_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory testing quality metrics tracking OOS/OOT rates, pass/fail ratios, retest frequency, and analytical result distributions. Provides the foundational data quality layer for batch release decisions and stability program oversight."
  source: "`pharmaceuticals_ecm`.`quality`.`lab_test_result`"
  dimensions:
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail outcome of the individual lab test — primary quality gate dimension."
    - name: "sample_type"
      expr: sample_type
      comment: "Type of sample tested (e.g., in-process, finished product, stability) for test category analysis."
    - name: "test_parameter"
      expr: test_parameter
      comment: "Analytical parameter being tested (e.g., assay, dissolution, sterility) for parameter-level quality trend analysis."
    - name: "oos_flag"
      expr: oos_flag
      comment: "Boolean indicating the result is Out-of-Specification — primary analytical quality failure indicator."
    - name: "oot_flag"
      expr: oot_flag
      comment: "Boolean indicating the result is Out-of-Trend — early warning signal for stability and process drift."
    - name: "retest_flag"
      expr: retest_flag
      comment: "Boolean indicating this result is from a retest, enabling retest rate analysis."
    - name: "approved_flag"
      expr: approved_flag
      comment: "Boolean indicating the result has been QA-approved for use in batch disposition decisions."
    - name: "storage_condition"
      expr: storage_condition
      comment: "Storage condition under which the sample was tested, relevant for stability study analysis."
    - name: "stability_timepoint"
      expr: stability_timepoint
      comment: "Stability study timepoint (e.g., 3M, 6M, 12M) for shelf-life trend analysis."
    - name: "test_year_month"
      expr: DATE_TRUNC('MONTH', test_date)
      comment: "Month bucket of the test date for volume and quality trend analysis."
  measures:
    - name: "total_test_results"
      expr: COUNT(1)
      comment: "Total number of lab test results. Baseline analytical throughput metric."
    - name: "oos_result_count"
      expr: COUNT(CASE WHEN oos_flag = TRUE THEN 1 END)
      comment: "Count of Out-of-Specification results. Primary analytical quality failure volume metric."
    - name: "oos_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN oos_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of test results that are Out-of-Specification. Key analytical quality KPI — rising rates trigger investigation and process review."
    - name: "oot_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN oot_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of test results that are Out-of-Trend. Early warning indicator for stability failures and process drift before OOS threshold is breached."
    - name: "retest_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN retest_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of test results that are retests. High retest rates indicate analytical method reliability issues or laboratory error patterns."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of test results with a passing outcome. Overall analytical quality yield metric for batch release readiness."
    - name: "avg_result_value"
      expr: AVG(CAST(result_value AS DOUBLE))
      comment: "Average numeric result value across test records. Used for statistical process control and specification limit trend analysis."
    - name: "pending_approval_results"
      expr: COUNT(CASE WHEN approved_flag = FALSE OR approved_flag IS NULL THEN 1 END)
      comment: "Count of test results not yet QA-approved. Tracks analytical review backlog impacting batch release timelines."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`quality_supplier_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier qualification and performance metrics tracking qualification status, GMP compliance, audit outcomes, performance scores, and requalification timeliness. Enables procurement and quality leadership to manage supply chain quality risk."
  source: "`pharmaceuticals_ecm`.`quality`.`supplier_qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status of the supplier (e.g., qualified, suspended, disqualified) — primary supply risk dimension."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (e.g., initial, requalification, conditional) for lifecycle stage analysis."
    - name: "supplier_type"
      expr: supplier_type
      comment: "Category of supplier (e.g., API manufacturer, excipient supplier, CMO) for supply chain risk segmentation."
    - name: "gmp_compliance_status"
      expr: gmp_compliance_status
      comment: "GMP compliance classification of the supplier — critical regulatory risk dimension."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier assigned to the supplier (e.g., critical, high, medium, low) for prioritized oversight."
    - name: "last_audit_outcome"
      expr: last_audit_outcome
      comment: "Outcome of the most recent supplier audit for current performance assessment."
    - name: "approval_workflow_status"
      expr: approval_workflow_status
      comment: "Status of the supplier approval workflow for pipeline and governance tracking."
    - name: "regulatory_inspection_status"
      expr: regulatory_inspection_status
      comment: "Status of the most recent regulatory inspection of the supplier facility."
    - name: "quality_agreement_type"
      expr: quality_agreement_type
      comment: "Type of quality agreement in place with the supplier, indicating contractual quality governance level."
  measures:
    - name: "total_supplier_qualifications"
      expr: COUNT(1)
      comment: "Total number of supplier qualification records. Baseline metric for supply chain quality governance scope."
    - name: "qualified_suppliers"
      expr: COUNT(CASE WHEN qualification_status = 'Qualified' THEN 1 END)
      comment: "Count of currently qualified suppliers. Tracks the active approved supplier base for supply continuity planning."
    - name: "suspended_or_disqualified_suppliers"
      expr: COUNT(CASE WHEN qualification_status IN ('Suspended', 'Disqualified') THEN 1 END)
      comment: "Count of suspended or disqualified suppliers. Critical supply risk metric requiring immediate procurement and quality leadership action."
    - name: "gmp_non_compliant_suppliers"
      expr: COUNT(CASE WHEN gmp_compliance_status NOT IN ('Compliant', 'Satisfactory') THEN 1 END)
      comment: "Count of suppliers with non-compliant GMP status. Tracks regulatory risk in the supply chain requiring escalation."
    - name: "avg_supplier_performance_score"
      expr: AVG(CAST(performance_score AS DOUBLE))
      comment: "Average supplier performance score across the qualified supplier base. Composite quality KPI for supplier relationship management and sourcing decisions."
    - name: "overdue_requalification_suppliers"
      expr: COUNT(CASE WHEN next_requalification_due_date < CURRENT_DATE AND qualification_status = 'Qualified' THEN 1 END)
      comment: "Count of qualified suppliers past their requalification due date. Tracks compliance with supplier oversight program requirements."
    - name: "overdue_audit_suppliers"
      expr: COUNT(CASE WHEN next_audit_due_date < CURRENT_DATE THEN 1 END)
      comment: "Count of suppliers past their next scheduled audit date. Measures audit program execution discipline and supply chain oversight gaps."
    - name: "critical_risk_tier_suppliers"
      expr: COUNT(CASE WHEN risk_tier = 'Critical' THEN 1 END)
      comment: "Count of suppliers classified in the critical risk tier. Enables focused resource allocation for highest-risk supply chain oversight."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`quality_change_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Change control management metrics tracking change implementation timeliness, regulatory notification compliance, validation requirements, and effectiveness verification. Ensures controlled change processes meet GMP and regulatory standards."
  source: "`pharmaceuticals_ecm`.`quality`.`change_control`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of change (e.g., process, equipment, specification, supplier) for change program analysis."
    - name: "change_category"
      expr: change_category
      comment: "Business category of the change for grouping and regulatory impact assessment."
    - name: "change_status"
      expr: change_status
      comment: "Current lifecycle status of the change control record for pipeline and backlog monitoring."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk classification of the change for prioritization and regulatory impact assessment."
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Boolean indicating regulatory notification is required for this change — compliance obligation flag."
    - name: "validation_required"
      expr: validation_required
      comment: "Boolean indicating validation activities are required before change implementation."
    - name: "effectiveness_verified"
      expr: effectiveness_verified
      comment: "Boolean indicating the change effectiveness has been verified post-implementation."
    - name: "training_required"
      expr: training_required
      comment: "Boolean indicating training is required as part of the change implementation."
    - name: "initiated_year_month"
      expr: DATE_TRUNC('MONTH', initiated_date)
      comment: "Month bucket of change initiation date for volume trend and backlog analysis."
  measures:
    - name: "total_change_controls"
      expr: COUNT(1)
      comment: "Total number of change control records. Baseline metric for change management program volume."
    - name: "open_change_controls"
      expr: COUNT(CASE WHEN change_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Count of change controls not yet closed. Operational backlog metric for quality and regulatory affairs resource planning."
    - name: "overdue_implementations"
      expr: COUNT(CASE WHEN target_implementation_date < CURRENT_DATE AND change_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Count of change controls past their target implementation date without closure. Tracks execution discipline and schedule risk."
    - name: "on_time_implementation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN change_status = 'Closed' AND actual_implementation_date <= target_implementation_date THEN 1 END) / NULLIF(COUNT(CASE WHEN change_status = 'Closed' THEN 1 END), 0), 2)
      comment: "Percentage of closed change controls implemented on or before the target date. Measures change management execution efficiency."
    - name: "regulatory_notification_required_changes"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END)
      comment: "Count of changes requiring regulatory notification. Tracks regulatory affairs workload and compliance obligation volume."
    - name: "effectiveness_verification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN effectiveness_verified = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN change_status = 'Closed' THEN 1 END), 0), 2)
      comment: "Percentage of closed changes with confirmed effectiveness verification. Measures post-implementation quality assurance rigor."
    - name: "avg_change_cycle_days"
      expr: AVG(DATEDIFF(closure_date, initiated_date))
      comment: "Average days from change initiation to closure. Measures change management process efficiency and cycle time benchmarking."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`quality_stability_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stability program metrics tracking study completion rates, OOT flags, shelf-life commitments, and regulatory commitment fulfillment. Directly informs product shelf-life claims, expiry dating, and regulatory submission readiness."
  source: "`pharmaceuticals_ecm`.`quality`.`stability_study`"
  dimensions:
    - name: "study_type"
      expr: study_type
      comment: "Type of stability study (e.g., long-term, accelerated, stress) for program-level analysis."
    - name: "study_status"
      expr: study_status
      comment: "Current status of the stability study (e.g., ongoing, completed, discontinued) for pipeline monitoring."
    - name: "storage_condition"
      expr: storage_condition
      comment: "Storage condition under which the study is conducted (e.g., 25°C/60%RH, 40°C/75%RH) for condition-level analysis."
    - name: "overall_pass_fail_status"
      expr: overall_pass_fail_status
      comment: "Overall pass/fail outcome of the stability study — primary quality gate for shelf-life confirmation."
    - name: "oot_flag"
      expr: oot_flag
      comment: "Boolean indicating an Out-of-Trend result was observed in the study — early warning for shelf-life risk."
    - name: "regulatory_commitment_flag"
      expr: regulatory_commitment_flag
      comment: "Boolean indicating the study is tied to a regulatory commitment, requiring heightened tracking and on-time completion."
    - name: "container_closure_system"
      expr: container_closure_system
      comment: "Container closure system used in the study, enabling packaging-level stability comparison."
    - name: "study_start_year_month"
      expr: DATE_TRUNC('MONTH', study_start_date)
      comment: "Month bucket of study start date for cohort and trend analysis."
  measures:
    - name: "total_stability_studies"
      expr: COUNT(1)
      comment: "Total number of stability studies. Baseline metric for stability program scope and resource planning."
    - name: "active_stability_studies"
      expr: COUNT(CASE WHEN study_status = 'Ongoing' THEN 1 END)
      comment: "Count of currently active stability studies. Tracks ongoing program workload for laboratory resource planning."
    - name: "oot_study_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN oot_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stability studies with an Out-of-Trend observation. Rising rates signal potential shelf-life risk requiring regulatory and formulation review."
    - name: "study_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_pass_fail_status = 'Pass' THEN 1 END) / NULLIF(COUNT(CASE WHEN overall_pass_fail_status IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of completed stability studies with a passing outcome. Measures product stability program success rate and shelf-life claim supportability."
    - name: "regulatory_commitment_studies"
      expr: COUNT(CASE WHEN regulatory_commitment_flag = TRUE THEN 1 END)
      comment: "Count of stability studies tied to regulatory commitments. Tracks the volume of studies with direct regulatory consequence if delayed or failed."
    - name: "overdue_completion_studies"
      expr: COUNT(CASE WHEN planned_completion_date < CURRENT_DATE AND study_status NOT IN ('Completed', 'Discontinued') THEN 1 END)
      comment: "Count of stability studies past their planned completion date. Tracks schedule risk for regulatory submission timelines and shelf-life claim renewals."
    - name: "avg_study_duration_days"
      expr: AVG(DATEDIFF(actual_completion_date, study_start_date))
      comment: "Average duration of completed stability studies in days. Benchmarks study execution efficiency and resource planning for future programs."
$$;