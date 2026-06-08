-- Metric views for domain: quality | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 18:41:06

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`quality_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for quality audit performance, certification outcomes, and corrective action closure rates across facilities, commodities, and auditing bodies. Supports executive oversight of food safety compliance posture."
  source: "`agriculture_ecm`.`quality`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit conducted (e.g., GAP, GFSI, internal, regulatory) — primary segmentation for audit portfolio analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Current lifecycle status of the audit (e.g., scheduled, in-progress, closed) — used to filter active vs. completed audits."
    - name: "certification_standard"
      expr: certification_standard
      comment: "Certification standard under which the audit was conducted (e.g., SQF, BRC, GlobalG.A.P.) — key dimension for compliance benchmarking."
    - name: "certification_outcome"
      expr: certification_outcome
      comment: "Outcome of the certification process (e.g., certified, conditionally certified, failed) — drives strategic certification portfolio decisions."
    - name: "auditing_body"
      expr: auditing_body
      comment: "Organization that conducted the audit — used to evaluate third-party auditor performance and consistency."
    - name: "audit_method"
      expr: audit_method
      comment: "Method used for the audit (e.g., on-site, remote, hybrid) — relevant for resource planning and audit program design."
    - name: "announced"
      expr: announced
      comment: "Whether the audit was announced (True) or unannounced (False) — unannounced audits typically yield more representative compliance data."
    - name: "gap_certified"
      expr: gap_certified
      comment: "Whether the audited entity achieved GAP certification — key indicator for produce safety program effectiveness."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating whether a corrective action was required as a result of the audit — drives CAPA workload forecasting."
    - name: "fsma_rule"
      expr: fsma_rule
      comment: "FSMA rule applicable to the audit (e.g., FSMA 204, Produce Safety Rule) — regulatory segmentation for compliance reporting."
    - name: "scheduled_year_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month in which the audit was scheduled — enables trend analysis of audit volume and outcomes over time."
    - name: "certificate_expiry_year"
      expr: YEAR(certificate_expiry_date)
      comment: "Year in which the audit certificate expires — used to prioritize renewal activities and manage certification risk."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audits conducted. Baseline volume metric for audit program capacity and throughput tracking."
    - name: "avg_audit_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall audit score across all audits. Tracks aggregate compliance quality; a declining trend signals systemic food safety risk."
    - name: "certified_audit_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_outcome = 'Certified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits resulting in a certified outcome. Core KPI for certification program effectiveness — directly tied to market access and customer requirements."
    - name: "corrective_action_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits that triggered a corrective action requirement. High rates indicate systemic compliance gaps requiring executive intervention."
    - name: "corrective_action_closed_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE AND corrective_action_closed_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of audits requiring corrective action where the action has been closed. Measures CAPA closure effectiveness — a lagging indicator of compliance resolution."
    - name: "gap_certification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gap_certified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits resulting in GAP certification. Tracks produce safety program success rate across the farm portfolio."
    - name: "verified_audit_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN verified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits that have been independently verified. Indicates audit program integrity and third-party validation coverage."
    - name: "expiring_certificates_next_90_days"
      expr: COUNT(CASE WHEN certificate_expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Number of audit certificates expiring within the next 90 days. Operational risk metric — drives renewal prioritization to prevent certification lapses."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`quality_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and strategic KPIs for field and facility inspections, including GAP module scores, nonconformance rates, and reinspection demand. Supports food safety program management and regulatory compliance oversight."
  source: "`agriculture_ecm`.`quality`.`inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (e.g., pre-harvest, post-harvest, facility, regulatory) — primary segmentation for inspection program analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (e.g., scheduled, completed, cancelled) — used to filter active pipeline vs. completed inspections."
    - name: "outcome"
      expr: outcome
      comment: "Final outcome of the inspection (e.g., pass, fail, conditional pass) — key result dimension for compliance performance tracking."
    - name: "certification_standard"
      expr: certification_standard
      comment: "Certification standard applicable to the inspection — enables benchmarking across different food safety schemes."
    - name: "certification_eligible"
      expr: certification_eligible
      comment: "Whether the inspected entity is eligible for certification — used to segment inspections by certification pathway."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether a corrective action was required as a result of the inspection — drives CAPA workload and compliance risk assessment."
    - name: "reinspection_required"
      expr: reinspection_required
      comment: "Whether a reinspection was required — high reinspection rates signal persistent compliance issues at specific locations or operations."
    - name: "inspector_organization"
      expr: inspector_organization
      comment: "Organization that conducted the inspection — used to evaluate third-party inspector performance and consistency."
    - name: "inspection_scope"
      expr: inspection_scope
      comment: "Scope of the inspection (e.g., full, partial, targeted) — relevant for understanding inspection depth and coverage."
    - name: "actual_inspection_month"
      expr: DATE_TRUNC('MONTH', actual_date)
      comment: "Month in which the inspection was conducted — enables seasonal trend analysis of inspection outcomes and volumes."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspections conducted. Baseline volume metric for inspection program capacity and throughput."
    - name: "avg_overall_inspection_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall inspection score. Tracks aggregate compliance quality across all inspections — a declining trend signals systemic food safety risk."
    - name: "pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN outcome = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections with a passing outcome. Primary KPI for food safety compliance effectiveness — directly tied to certification eligibility and market access."
    - name: "reinspection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reinspection_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring a reinspection. Elevated rates indicate persistent compliance failures and drive resource reallocation decisions."
    - name: "corrective_action_trigger_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections that triggered a corrective action. Measures compliance gap frequency — a leading indicator of systemic food safety risk."
    - name: "avg_gap_ag_water_score"
      expr: AVG(CAST(gap_module_ag_water_score AS DOUBLE))
      comment: "Average GAP module score for agricultural water management. Tracks compliance with one of the highest-risk FSMA Produce Safety Rule requirements."
    - name: "avg_gap_worker_health_score"
      expr: AVG(CAST(gap_module_worker_health_score AS DOUBLE))
      comment: "Average GAP module score for worker health and hygiene. Tracks compliance with a critical food safety and labor welfare requirement."
    - name: "avg_gap_traceability_score"
      expr: AVG(CAST(gap_module_traceability_score AS DOUBLE))
      comment: "Average GAP module score for traceability. Tracks readiness for FSMA 204 traceability requirements — directly linked to recall response capability."
    - name: "avg_gap_field_sanitation_score"
      expr: AVG(CAST(gap_module_field_sanitation_score AS DOUBLE))
      comment: "Average GAP module score for field sanitation. Tracks compliance with produce safety sanitation requirements across field operations."
    - name: "avg_gap_soil_amendments_score"
      expr: AVG(CAST(gap_module_soil_amendments_score AS DOUBLE))
      comment: "Average GAP module score for soil amendments. Tracks compliance with biological hazard controls related to compost and manure application."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`quality_nonconformance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Executive and operational KPIs for nonconformance events, including financial impact, severity distribution, regulatory notification rates, and closure performance. Supports food safety risk management and regulatory compliance reporting."
  source: "`agriculture_ecm`.`quality`.`nonconformance`"
  dimensions:
    - name: "nonconformance_type"
      expr: nonconformance_type
      comment: "Type of nonconformance (e.g., food safety, quality, regulatory, environmental) — primary segmentation for risk categorization."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the nonconformance (e.g., critical, major, minor) — drives prioritization and escalation decisions."
    - name: "nc_status"
      expr: nc_status
      comment: "Current lifecycle status of the nonconformance (e.g., open, under investigation, closed) — used to track resolution pipeline."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level category of the root cause (e.g., process failure, supplier, human error) — essential for systemic improvement programs."
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "Classification of the food safety hazard (e.g., biological, chemical, physical) — regulatory and risk management segmentation."
    - name: "detection_source"
      expr: detection_source
      comment: "Source that detected the nonconformance (e.g., internal audit, customer complaint, lab result) — informs detection program effectiveness."
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Whether regulatory notification is required for this nonconformance — critical flag for compliance and legal risk management."
    - name: "recall_class"
      expr: recall_class
      comment: "FDA/USDA recall class if applicable (e.g., Class I, II, III) — highest-severity dimension for food safety risk reporting."
    - name: "gfsi_scheme"
      expr: gfsi_scheme
      comment: "GFSI certification scheme associated with the nonconformance — enables scheme-level compliance performance benchmarking."
    - name: "incident_closure_status"
      expr: incident_closure_status
      comment: "Closure status of the nonconformance incident — used to track open vs. resolved compliance issues."
    - name: "detection_year_month"
      expr: DATE_TRUNC('MONTH', detection_date)
      comment: "Month in which the nonconformance was detected — enables trend analysis of nonconformance frequency and severity over time."
  measures:
    - name: "total_nonconformances"
      expr: COUNT(1)
      comment: "Total number of nonconformance events. Baseline volume metric for food safety and quality risk exposure."
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS DOUBLE))
      comment: "Total quantity of product affected by nonconformances. Measures the operational scale of quality failures — directly linked to waste, rework, and recall exposure."
    - name: "total_affected_value_usd"
      expr: SUM(CAST(affected_value_usd AS DOUBLE))
      comment: "Total financial value of product affected by nonconformances in USD. Primary financial impact KPI for quality cost management and insurance/risk reporting."
    - name: "avg_affected_value_usd"
      expr: AVG(CAST(affected_value_usd AS DOUBLE))
      comment: "Average financial value per nonconformance event. Tracks the typical cost impact of quality failures — used to prioritize prevention investments."
    - name: "critical_nonconformance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN severity_level = 'Critical' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of nonconformances classified as critical severity. Tracks the proportion of highest-risk events — a key food safety risk indicator for executive reporting."
    - name: "regulatory_notification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of nonconformances requiring regulatory notification. Measures regulatory exposure — high rates signal systemic compliance risk and potential enforcement action."
    - name: "mock_recall_event_count"
      expr: COUNT(CASE WHEN mock_recall_flag = TRUE THEN 1 END)
      comment: "Number of nonconformances associated with mock recall exercises. Tracks recall preparedness program activity — required by GFSI schemes and FSMA."
    - name: "open_nonconformance_count"
      expr: COUNT(CASE WHEN nc_status != 'Closed' THEN 1 END)
      comment: "Number of nonconformances that are not yet closed. Measures the open compliance risk backlog — a leading indicator of unresolved food safety exposure."
    - name: "avg_detected_residue_level"
      expr: AVG(CAST(detected_residue_level AS DOUBLE))
      comment: "Average detected pesticide or chemical residue level across nonconformances. Tracks chemical contamination severity — directly linked to MRL compliance and market access risk."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`quality_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for corrective and preventive action (CAPA) program performance, including closure rates, overdue actions, recurrence rates, and effectiveness review outcomes. Supports continuous improvement and regulatory compliance management."
  source: "`agriculture_ecm`.`quality`.`corrective_action`"
  dimensions:
    - name: "capa_type"
      expr: capa_type
      comment: "Type of corrective/preventive action (e.g., corrective, preventive, improvement) — primary segmentation for CAPA program analysis."
    - name: "capa_status"
      expr: capa_status
      comment: "Current lifecycle status of the CAPA (e.g., open, in-progress, closed, overdue) — used to track resolution pipeline and overdue backlog."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level root cause category (e.g., process, supplier, training, equipment) — essential for systemic improvement program targeting."
    - name: "root_cause_method"
      expr: root_cause_method
      comment: "Root cause analysis method used (e.g., 5-Why, fishbone, fault tree) — tracks rigor of investigation methodology."
    - name: "priority"
      expr: priority
      comment: "Priority level of the CAPA (e.g., high, medium, low) — used to segment workload and ensure critical actions receive timely attention."
    - name: "source_type"
      expr: source_type
      comment: "Source that triggered the CAPA (e.g., audit, inspection, customer complaint, lab result) — informs which detection channels drive the most corrective work."
    - name: "effectiveness_review_outcome"
      expr: effectiveness_review_outcome
      comment: "Outcome of the CAPA effectiveness review (e.g., effective, partially effective, ineffective) — measures whether corrective actions actually resolved the root cause."
    - name: "department"
      expr: department
      comment: "Department responsible for the CAPA — enables accountability tracking and workload distribution analysis across the organization."
    - name: "fsma_reportable_flag"
      expr: fsma_reportable_flag
      comment: "Whether the CAPA is reportable under FSMA — critical flag for regulatory compliance and enforcement risk management."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether this CAPA represents a recurrence of a previously closed issue — recurrence indicates ineffective prior corrective actions."
    - name: "opened_year_month"
      expr: DATE_TRUNC('MONTH', opened_timestamp)
      comment: "Month in which the CAPA was opened — enables trend analysis of corrective action volume and aging over time."
  measures:
    - name: "total_capas"
      expr: COUNT(1)
      comment: "Total number of corrective and preventive actions. Baseline volume metric for CAPA program workload and compliance activity."
    - name: "capa_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN capa_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CAPAs that have been closed. Primary KPI for CAPA program effectiveness — low closure rates indicate systemic resolution bottlenecks."
    - name: "overdue_capa_count"
      expr: COUNT(CASE WHEN capa_status != 'Closed' AND target_completion_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of open CAPAs that have passed their target completion date. Measures compliance risk from unresolved corrective actions — drives escalation and resource reallocation."
    - name: "overdue_capa_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN capa_status != 'Closed' AND target_completion_date < CURRENT_DATE() THEN 1 END) / NULLIF(COUNT(CASE WHEN capa_status != 'Closed' THEN 1 END), 0), 2)
      comment: "Percentage of open CAPAs that are overdue. Tracks CAPA program timeliness — a leading indicator of regulatory non-compliance risk."
    - name: "recurrence_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CAPAs that represent a recurrence of a previously closed issue. Measures root cause analysis effectiveness — high recurrence rates indicate systemic failure to address underlying causes."
    - name: "effective_capa_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN effectiveness_review_outcome = 'Effective' THEN 1 END) / NULLIF(COUNT(CASE WHEN effectiveness_review_outcome IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of reviewed CAPAs rated as effective. Measures the quality of corrective actions — directly linked to continuous improvement program ROI."
    - name: "fsma_reportable_capa_count"
      expr: COUNT(CASE WHEN fsma_reportable_flag = TRUE THEN 1 END)
      comment: "Number of CAPAs flagged as FSMA-reportable. Tracks regulatory reporting obligations — directly linked to FDA enforcement risk and compliance posture."
    - name: "gap_gmp_violation_capa_count"
      expr: COUNT(CASE WHEN gap_gmp_violation_flag = TRUE THEN 1 END)
      comment: "Number of CAPAs associated with GAP or GMP violations. Tracks the volume of produce safety and good manufacturing practice failures requiring corrective action."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`quality_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory test result KPIs including pass/fail rates, measured value distributions, MRL compliance, and HACCP CCP performance. Supports food safety risk management, regulatory compliance, and supplier quality decisions."
  source: "`agriculture_ecm`.`quality`.`test_result`"
  dimensions:
    - name: "parameter_category"
      expr: parameter_category
      comment: "Category of the test parameter (e.g., pesticide residue, microbial, heavy metal, mycotoxin) — primary segmentation for food safety risk analysis."
    - name: "parameter_name"
      expr: parameter_name
      comment: "Specific parameter tested (e.g., Chlorpyrifos, E. coli, Lead) — granular dimension for targeted compliance and risk monitoring."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail outcome of the test — primary result dimension for compliance rate calculations."
    - name: "result_status"
      expr: result_status
      comment: "Administrative status of the result (e.g., preliminary, final, amended) — used to filter confirmed vs. provisional results."
    - name: "result_type"
      expr: result_type
      comment: "Type of result (e.g., quantitative, qualitative, screening) — relevant for understanding analytical method and result confidence."
    - name: "test_method_code"
      expr: test_method_code
      comment: "Analytical method code used for the test — enables method-level performance benchmarking and regulatory method compliance tracking."
    - name: "sample_matrix"
      expr: sample_matrix
      comment: "Matrix of the sample tested (e.g., fresh produce, soil, water, grain) — used to segment results by commodity type and risk profile."
    - name: "haccp_ccp_flag"
      expr: haccp_ccp_flag
      comment: "Whether the test is associated with a HACCP Critical Control Point — CCP results require heightened monitoring and immediate action on failures."
    - name: "regulatory_submission_required"
      expr: regulatory_submission_required
      comment: "Whether the test result must be submitted to a regulatory agency — tracks regulatory reporting obligations."
    - name: "regulatory_program_code"
      expr: regulatory_program_code
      comment: "Regulatory program under which the test was conducted (e.g., USDA PDP, FDA CFSAN) — enables program-level compliance reporting."
    - name: "test_performed_month"
      expr: DATE_TRUNC('MONTH', test_performed_timestamp)
      comment: "Month in which the test was performed — enables trend analysis of test volumes, pass rates, and contamination levels over time."
  measures:
    - name: "total_test_results"
      expr: COUNT(1)
      comment: "Total number of test results. Baseline volume metric for laboratory testing program throughput and coverage."
    - name: "pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of test results with a passing outcome. Primary KPI for product quality and food safety compliance — directly linked to release decisions and market access."
    - name: "fail_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_status = 'Fail' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of test results with a failing outcome. Tracks food safety and quality failure frequency — a leading indicator of nonconformance and recall risk."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across test results. Tracks central tendency of contamination or quality parameter levels — used to assess proximity to regulatory limits."
    - name: "avg_recovery_percent"
      expr: AVG(CAST(recovery_percent AS DOUBLE))
      comment: "Average analytical recovery percentage. Measures laboratory method performance — recovery outside 70-120% range indicates analytical quality issues requiring investigation."
    - name: "haccp_ccp_fail_count"
      expr: COUNT(CASE WHEN haccp_ccp_flag = TRUE AND pass_fail_status = 'Fail' THEN 1 END)
      comment: "Number of failed test results at HACCP Critical Control Points. Highest-priority food safety KPI — any CCP failure requires immediate corrective action and potential product hold."
    - name: "haccp_ccp_fail_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN haccp_ccp_flag = TRUE AND pass_fail_status = 'Fail' THEN 1 END) / NULLIF(COUNT(CASE WHEN haccp_ccp_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of HACCP CCP tests that failed. Tracks the most critical food safety control point failure rate — directly linked to product safety and regulatory compliance."
    - name: "regulatory_submission_required_count"
      expr: COUNT(CASE WHEN regulatory_submission_required = TRUE THEN 1 END)
      comment: "Number of test results requiring regulatory submission. Tracks regulatory reporting workload and ensures no submissions are missed — a compliance obligation metric."
    - name: "avg_action_limit"
      expr: AVG(CAST(action_limit AS DOUBLE))
      comment: "Average action limit across test parameters. Provides context for interpreting measured values relative to intervention thresholds — used in risk-based monitoring program design."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`quality_lab_sample`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for laboratory sample management, including MRL exceedance rates, PHI compliance, sample throughput, and turnaround performance. Supports food safety monitoring program effectiveness and regulatory compliance."
  source: "`agriculture_ecm`.`quality`.`lab_sample`"
  dimensions:
    - name: "sample_type"
      expr: sample_type
      comment: "Type of sample collected (e.g., produce, water, soil, environmental swab) — primary segmentation for food safety monitoring program analysis."
    - name: "sample_status"
      expr: sample_status
      comment: "Current status of the sample (e.g., received, in-analysis, results-released, rejected) — used to track sample pipeline and identify bottlenecks."
    - name: "overall_result"
      expr: overall_result
      comment: "Overall pass/fail result for the sample — primary outcome dimension for compliance rate calculations."
    - name: "collection_point_type"
      expr: collection_point_type
      comment: "Type of collection point (e.g., field, packinghouse, storage, distribution) — enables risk-based monitoring program analysis by supply chain stage."
    - name: "mrl_exceedance_flag"
      expr: mrl_exceedance_flag
      comment: "Whether the sample exceeded Maximum Residue Limits — critical food safety and market access flag requiring immediate action."
    - name: "phi_compliance_flag"
      expr: phi_compliance_flag
      comment: "Whether the sample was collected in compliance with Pre-Harvest Interval requirements — PHI violations are a primary cause of MRL exceedances."
    - name: "haccp_ccp_flag"
      expr: haccp_ccp_flag
      comment: "Whether the sample is associated with a HACCP Critical Control Point — CCP samples require priority processing and immediate action on failures."
    - name: "gfsi_scheme_code"
      expr: gfsi_scheme_code
      comment: "GFSI certification scheme associated with the sample — enables scheme-level monitoring program compliance tracking."
    - name: "sampling_frequency_code"
      expr: sampling_frequency_code
      comment: "Code indicating the sampling frequency plan (e.g., routine, intensified, triggered) — used to evaluate monitoring program design and risk-based sampling effectiveness."
    - name: "collection_year_month"
      expr: DATE_TRUNC('MONTH', collection_timestamp)
      comment: "Month in which the sample was collected — enables seasonal trend analysis of contamination rates and monitoring program activity."
  measures:
    - name: "total_samples"
      expr: COUNT(1)
      comment: "Total number of lab samples collected. Baseline volume metric for food safety monitoring program coverage and throughput."
    - name: "mrl_exceedance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN mrl_exceedance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of samples with MRL exceedances. Primary food safety and market access KPI — MRL exceedances trigger product holds, recalls, and export bans."
    - name: "phi_non_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN phi_compliance_flag = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of samples collected outside PHI compliance. Tracks agrochemical application discipline — PHI violations are a leading cause of MRL exceedances and regulatory action."
    - name: "sample_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_result = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of samples with an overall passing result. Tracks food safety monitoring program compliance rate — directly linked to product release and market access decisions."
    - name: "avg_sample_quantity"
      expr: AVG(CAST(sample_quantity AS DOUBLE))
      comment: "Average quantity per sample collected. Monitors sampling protocol adherence — insufficient sample quantities can invalidate analytical results."
    - name: "avg_storage_temperature_c"
      expr: AVG(CAST(storage_temperature_c AS DOUBLE))
      comment: "Average storage temperature of samples in Celsius. Tracks cold chain integrity for sample handling — temperature excursions can compromise analytical validity and food safety conclusions."
    - name: "haccp_ccp_sample_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN haccp_ccp_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of samples associated with HACCP Critical Control Points. Tracks the proportion of highest-priority food safety monitoring samples in the overall program."
    - name: "overdue_sample_count"
      expr: COUNT(CASE WHEN sample_status != 'Results Released' AND required_completion_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of samples that have not been completed by their required completion date. Tracks laboratory turnaround performance — overdue samples delay product release and create compliance risk."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`quality_certificate_of_analysis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for Certificate of Analysis (CoA) quality outcomes, including MRL compliance rates, microbial and mycotoxin contamination levels, moisture and protein quality parameters, and HACCP CCP compliance. Supports product release decisions and customer quality assurance."
  source: "`agriculture_ecm`.`quality`.`certificate_of_analysis`"
  dimensions:
    - name: "coa_status"
      expr: coa_status
      comment: "Current status of the CoA (e.g., draft, issued, approved, expired) — used to filter active vs. historical quality records."
    - name: "overall_result"
      expr: overall_result
      comment: "Overall pass/fail result of the CoA — primary outcome dimension for product release and compliance rate analysis."
    - name: "release_status"
      expr: release_status
      comment: "Product release status based on CoA results (e.g., released, on-hold, rejected) — directly drives inventory disposition and customer delivery decisions."
    - name: "mrl_compliant"
      expr: mrl_compliant
      comment: "Whether the product is compliant with Maximum Residue Limits — critical food safety and market access dimension."
    - name: "phi_compliant"
      expr: phi_compliant
      comment: "Whether the product was produced in compliance with Pre-Harvest Interval requirements — PHI compliance is a prerequisite for MRL compliance."
    - name: "haccp_ccp_compliant"
      expr: haccp_ccp_compliant
      comment: "Whether the product passed all HACCP Critical Control Point requirements — mandatory for food safety certification and product release."
    - name: "gmo_status"
      expr: gmo_status
      comment: "GMO status of the product (e.g., GMO-free, contains GMO, not tested) — critical for export market compliance and customer labeling requirements."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin of the product — used for trade compliance, import/export regulatory analysis, and customer country-of-origin labeling requirements."
    - name: "gfsi_scheme"
      expr: gfsi_scheme
      comment: "GFSI certification scheme applicable to the CoA — enables scheme-level quality performance benchmarking."
    - name: "microbial_test_type"
      expr: microbial_test_type
      comment: "Type of microbial test performed (e.g., Total Plate Count, Salmonella, E. coli O157:H7) — granular dimension for pathogen risk monitoring."
    - name: "mycotoxin_type"
      expr: mycotoxin_type
      comment: "Type of mycotoxin tested (e.g., Aflatoxin, Deoxynivalenol, Ochratoxin) — used for commodity-specific mycotoxin risk management."
    - name: "issue_year_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month in which the CoA was issued — enables trend analysis of product quality outcomes and compliance rates over time."
  measures:
    - name: "total_coas"
      expr: COUNT(1)
      comment: "Total number of Certificates of Analysis issued. Baseline volume metric for product quality documentation throughput."
    - name: "mrl_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN mrl_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CoAs with MRL-compliant results. Primary food safety and market access KPI — MRL non-compliance triggers product holds, recalls, and export bans."
    - name: "product_release_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN release_status = 'Released' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CoAs resulting in product release. Tracks overall product quality acceptance rate — directly linked to supply chain throughput and customer service levels."
    - name: "avg_moisture_pct"
      expr: AVG(CAST(moisture_pct AS DOUBLE))
      comment: "Average moisture percentage across CoAs. Tracks a critical grain and commodity quality parameter — moisture out of specification drives storage losses, mold risk, and price discounts."
    - name: "avg_protein_pct"
      expr: AVG(CAST(protein_pct AS DOUBLE))
      comment: "Average protein percentage across CoAs. Tracks a key nutritional quality parameter for grain and feed commodities — protein content directly affects commodity pricing and customer specifications."
    - name: "avg_mycotoxin_result_ppb"
      expr: AVG(CAST(mycotoxin_result_ppb AS DOUBLE))
      comment: "Average mycotoxin contamination level in parts per billion. Tracks chemical food safety risk — mycotoxin levels above regulatory limits trigger product rejection and market access loss."
    - name: "avg_pesticide_residue_ppm"
      expr: AVG(CAST(pesticide_residue_result_ppm AS DOUBLE))
      comment: "Average pesticide residue level in parts per million. Tracks chemical contamination relative to MRL thresholds — a primary food safety and export compliance KPI."
    - name: "avg_heavy_metals_ppm"
      expr: AVG(CAST(heavy_metals_result_ppm AS DOUBLE))
      comment: "Average heavy metals contamination level in parts per million. Tracks inorganic chemical food safety risk — heavy metal exceedances trigger regulatory action and market access restrictions."
    - name: "haccp_ccp_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN haccp_ccp_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CoAs with full HACCP CCP compliance. Tracks the most critical food safety control point compliance rate — mandatory for GFSI certification maintenance."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`quality_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for quality certification portfolio management, including active certification rates, expiry risk, nonconformance counts, and multi-site coverage. Supports certification program governance and market access strategy."
  source: "`agriculture_ecm`.`quality`.`quality_certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of quality certification (e.g., organic, GAP, GFSI, ISO) — primary segmentation for certification portfolio analysis."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (e.g., active, suspended, withdrawn, expired) — used to track portfolio health and compliance risk."
    - name: "scheme_name"
      expr: scheme_name
      comment: "Name of the certification scheme (e.g., SQF, BRC, GlobalG.A.P., USDA Organic) — enables scheme-level portfolio benchmarking."
    - name: "accreditation_body"
      expr: accreditation_body
      comment: "Body that accredited the certification — used to evaluate certifier performance and manage third-party relationships."
    - name: "country_code"
      expr: country_code
      comment: "Country associated with the certification — enables geographic analysis of certification coverage and market access compliance."
    - name: "gfsi_scheme_flag"
      expr: gfsi_scheme_flag
      comment: "Whether the certification is a GFSI-recognized scheme — GFSI certifications are required by major food retailers and manufacturers."
    - name: "multi_site_flag"
      expr: multi_site_flag
      comment: "Whether the certification covers multiple sites — multi-site certifications require more complex management and have higher renewal risk."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit associated with the certification (e.g., initial, surveillance, recertification) — tracks certification lifecycle stage."
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year in which the certification was issued — enables cohort analysis of certification program growth and renewal patterns."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year in which the certification expires — used to plan renewal activities and manage certification lapse risk."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of quality certifications in the portfolio. Baseline metric for certification program scope and market access coverage."
    - name: "active_certification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications with active status. Primary KPI for certification portfolio health — declining rates signal market access risk and customer compliance failures."
    - name: "expiring_certifications_next_90_days"
      expr: COUNT(CASE WHEN certification_status = 'Active' AND expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Number of active certifications expiring within the next 90 days. Operational risk metric — drives renewal prioritization to prevent certification lapses that could disrupt market access."
    - name: "suspended_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Suspended' THEN 1 END)
      comment: "Number of certifications currently suspended. Tracks active compliance failures — suspended certifications directly impact market access and customer contract compliance."
    - name: "gfsi_certification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gfsi_scheme_flag = TRUE AND certification_status = 'Active' THEN 1 END) / NULLIF(COUNT(CASE WHEN certification_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active certifications that are GFSI-recognized schemes. Tracks the proportion of certifications meeting major retailer and food manufacturer requirements."
    - name: "multi_site_certification_count"
      expr: COUNT(CASE WHEN multi_site_flag = TRUE AND certification_status = 'Active' THEN 1 END)
      comment: "Number of active multi-site certifications. Tracks the scope of certification coverage across the farm and facility network — relevant for portfolio efficiency analysis."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`quality_haccp_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for HACCP plan portfolio management, including active plan coverage, deviation rates, hazard identification completeness, and FSMA preventive controls applicability. Supports food safety program governance and regulatory compliance."
  source: "`agriculture_ecm`.`quality`.`haccp_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the HACCP plan (e.g., active, draft, expired, under review) — used to track plan portfolio health and compliance coverage."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework applicable to the HACCP plan (e.g., FSMA, Codex Alimentarius, EU 852/2004) — enables regulatory-specific compliance analysis."
    - name: "gfsi_scheme"
      expr: gfsi_scheme
      comment: "GFSI certification scheme associated with the HACCP plan — enables scheme-level food safety program benchmarking."
    - name: "fsma_preventive_controls_applicable"
      expr: fsma_preventive_controls_applicable
      comment: "Whether FSMA Preventive Controls requirements apply to this plan — FSMA-applicable plans require additional documentation and verification activities."
    - name: "deviation_flag"
      expr: deviation_flag
      comment: "Whether a deviation from the HACCP plan has been recorded — deviations require immediate corrective action and documentation."
    - name: "biological_hazards_identified"
      expr: biological_hazards_identified
      comment: "Whether biological hazards were identified in the hazard analysis — biological hazards (e.g., pathogens) represent the highest food safety risk category."
    - name: "chemical_hazards_identified"
      expr: chemical_hazards_identified
      comment: "Whether chemical hazards were identified in the hazard analysis — chemical hazards include pesticide residues, mycotoxins, and allergens."
    - name: "physical_hazards_identified"
      expr: physical_hazards_identified
      comment: "Whether physical hazards were identified in the hazard analysis — physical hazards include foreign material contamination."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year in which the HACCP plan became effective — used to track plan age and identify plans due for review or update."
  measures:
    - name: "total_haccp_plans"
      expr: COUNT(1)
      comment: "Total number of HACCP plans in the portfolio. Baseline metric for food safety program scope and coverage."
    - name: "active_plan_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN plan_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of HACCP plans with active status. Tracks food safety program coverage — inactive or expired plans represent uncontrolled food safety risk."
    - name: "deviation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN deviation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of HACCP plans with recorded deviations. Tracks CCP control failure frequency — a leading indicator of food safety incidents and regulatory non-compliance."
    - name: "fsma_applicable_plan_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fsma_preventive_controls_applicable = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of HACCP plans subject to FSMA Preventive Controls requirements. Tracks the proportion of the food safety program under the most stringent US regulatory framework."
    - name: "biological_hazard_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN biological_hazards_identified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of HACCP plans that identified biological hazards. Tracks the thoroughness of hazard analysis for the highest-risk food safety category — low rates may indicate incomplete hazard analysis."
    - name: "expiring_plans_next_90_days"
      expr: COUNT(CASE WHEN plan_status = 'Active' AND expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Number of active HACCP plans expiring within the next 90 days. Operational risk metric — expired HACCP plans represent a critical food safety program gap and regulatory non-compliance."
$$;