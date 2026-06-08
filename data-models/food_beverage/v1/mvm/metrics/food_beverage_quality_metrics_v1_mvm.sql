-- Metric views for domain: quality | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 23:12:43

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`quality_customer_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer complaint KPIs tracking complaint volume, severity distribution, resolution performance, and financial impact for quality and customer experience management."
  source: "`food_beverage_ecm`.`quality`.`customer_complaint`"
  dimensions:
    - name: "complaint_category"
      expr: complaint_category
      comment: "Category of customer complaint (e.g., product quality, packaging, contamination)"
    - name: "severity"
      expr: severity
      comment: "Severity level of the complaint (e.g., critical, high, medium, low)"
    - name: "customer_complaint_status"
      expr: customer_complaint_status
      comment: "Current status of the complaint (e.g., open, investigating, resolved, closed)"
    - name: "complainant_type"
      expr: complainant_type
      comment: "Type of complainant (e.g., consumer, retailer, distributor)"
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which complaint was received (e.g., phone, email, social media)"
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Whether complaint requires regulatory reporting"
    - name: "complaint_month"
      expr: DATE_TRUNC('MONTH', complaint_timestamp)
      comment: "Month when complaint was received"
    - name: "complaint_year"
      expr: YEAR(complaint_timestamp)
      comment: "Year when complaint was received"
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total number of customer complaints received"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact amount from all complaints"
    - name: "avg_financial_impact_per_complaint"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per complaint"
    - name: "regulatory_reportable_complaints"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Count of complaints requiring regulatory reporting"
    - name: "closed_complaints"
      expr: COUNT(CASE WHEN customer_complaint_status = 'Closed' THEN 1 END)
      comment: "Count of complaints that have been closed"
    - name: "complaints_with_resolution"
      expr: COUNT(CASE WHEN resolution_action IS NOT NULL THEN 1 END)
      comment: "Count of complaints with documented resolution action"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`quality_non_conformance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Non-conformance KPIs tracking defect rates, quality incidents, cost impact, and corrective action effectiveness for quality management and continuous improvement."
  source: "`food_beverage_ecm`.`quality`.`non_conformance`"
  dimensions:
    - name: "severity_classification"
      expr: severity_classification
      comment: "Severity classification of the non-conformance (e.g., critical, major, minor)"
    - name: "defect_type"
      expr: defect_type
      comment: "Type of defect identified"
    - name: "source_type"
      expr: source_type
      comment: "Source where non-conformance was detected (e.g., production, receiving, customer)"
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Disposition decision for non-conforming material (e.g., rework, scrap, use-as-is)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the non-conformance"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action implementation"
    - name: "regulatory_reportable"
      expr: regulatory_reportable
      comment: "Whether non-conformance requires regulatory reporting"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month when non-conformance event occurred"
    - name: "event_year"
      expr: YEAR(event_timestamp)
      comment: "Year when non-conformance event occurred"
  measures:
    - name: "total_non_conformances"
      expr: COUNT(1)
      comment: "Total number of non-conformance events"
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total cost impact from all non-conformances"
    - name: "avg_cost_per_non_conformance"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per non-conformance event"
    - name: "critical_non_conformances"
      expr: COUNT(CASE WHEN severity_classification = 'Critical' THEN 1 END)
      comment: "Count of critical severity non-conformances"
    - name: "regulatory_reportable_ncrs"
      expr: COUNT(CASE WHEN regulatory_reportable = TRUE THEN 1 END)
      comment: "Count of non-conformances requiring regulatory reporting"
    - name: "ncrs_with_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_plan IS NOT NULL THEN 1 END)
      comment: "Count of non-conformances with documented corrective action plan"
    - name: "avg_quality_metric_value"
      expr: AVG(CAST(quality_metric_value AS DOUBLE))
      comment: "Average quality metric value across non-conformances"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`quality_inspection_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection lot KPIs tracking inspection pass rates, process capability, quality disposition, and regulatory compliance for quality assurance and process control."
  source: "`food_beverage_ecm`.`quality`.`inspection_lot`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection lot"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed (e.g., receiving, in-process, final)"
    - name: "overall_result"
      expr: overall_result
      comment: "Overall inspection result (e.g., pass, fail, conditional)"
    - name: "lot_disposition"
      expr: lot_disposition
      comment: "Disposition decision for the inspected lot (e.g., accept, reject, rework)"
    - name: "usage_decision"
      expr: usage_decision
      comment: "Usage decision for the lot (e.g., unrestricted, restricted, blocked)"
    - name: "regulatory_compliance_status"
      expr: regulatory_compliance_status
      comment: "Regulatory compliance status of the inspection"
    - name: "gfs_i_certified"
      expr: gfs_i_certified
      comment: "Whether lot is GFSI certified"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month when inspection was performed"
    - name: "inspection_year"
      expr: YEAR(inspection_date)
      comment: "Year when inspection was performed"
  measures:
    - name: "total_inspection_lots"
      expr: COUNT(1)
      comment: "Total number of inspection lots"
    - name: "total_quantity_inspected"
      expr: SUM(CAST(quantity_inspected AS DOUBLE))
      comment: "Total quantity inspected across all lots"
    - name: "avg_quantity_per_lot"
      expr: AVG(CAST(quantity_inspected AS DOUBLE))
      comment: "Average quantity inspected per lot"
    - name: "passed_lots"
      expr: COUNT(CASE WHEN overall_result = 'Pass' THEN 1 END)
      comment: "Count of inspection lots that passed"
    - name: "failed_lots"
      expr: COUNT(CASE WHEN overall_result = 'Fail' THEN 1 END)
      comment: "Count of inspection lots that failed"
    - name: "avg_cpk_value"
      expr: AVG(CAST(cpk_value AS DOUBLE))
      comment: "Average process capability index (Cpk) across inspection lots"
    - name: "avg_cp_value"
      expr: AVG(CAST(cp_value AS DOUBLE))
      comment: "Average process capability (Cp) across inspection lots"
    - name: "compliant_lots"
      expr: COUNT(CASE WHEN regulatory_compliance_status = 'Compliant' THEN 1 END)
      comment: "Count of lots meeting regulatory compliance"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`quality_product_recall`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product recall KPIs tracking recall volume, classification, scope, recovery effectiveness, and financial impact for crisis management and regulatory compliance."
  source: "`food_beverage_ecm`.`quality`.`product_recall`"
  dimensions:
    - name: "recall_status"
      expr: recall_status
      comment: "Current status of the product recall"
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall (e.g., voluntary, mandatory)"
    - name: "recall_classification"
      expr: recall_classification
      comment: "FDA/regulatory classification of recall (e.g., Class I, II, III)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the recall"
    - name: "is_voluntary"
      expr: is_voluntary
      comment: "Whether recall is voluntary or mandated"
    - name: "distribution_scope"
      expr: distribution_scope
      comment: "Geographic scope of product distribution (e.g., national, regional, local)"
    - name: "press_release_issued"
      expr: press_release_issued
      comment: "Whether press release was issued for the recall"
    - name: "initiation_month"
      expr: DATE_TRUNC('MONTH', recall_initiation_timestamp)
      comment: "Month when recall was initiated"
    - name: "initiation_year"
      expr: YEAR(recall_initiation_timestamp)
      comment: "Year when recall was initiated"
  measures:
    - name: "total_recalls"
      expr: COUNT(1)
      comment: "Total number of product recalls"
    - name: "total_quantity_affected"
      expr: SUM(CAST(quantity_affected AS DOUBLE))
      comment: "Total quantity of product units affected by recalls"
    - name: "total_quantity_recovered"
      expr: SUM(CAST(product_recovery_quantity AS DOUBLE))
      comment: "Total quantity of product units recovered"
    - name: "total_monetary_loss"
      expr: SUM(CAST(monetary_loss_amount AS DOUBLE))
      comment: "Total monetary loss from all recalls"
    - name: "avg_monetary_loss_per_recall"
      expr: AVG(CAST(monetary_loss_amount AS DOUBLE))
      comment: "Average monetary loss per recall event"
    - name: "class_i_recalls"
      expr: COUNT(CASE WHEN recall_classification = 'Class I' THEN 1 END)
      comment: "Count of Class I (most serious) recalls"
    - name: "voluntary_recalls"
      expr: COUNT(CASE WHEN is_voluntary = TRUE THEN 1 END)
      comment: "Count of voluntary recalls"
    - name: "closed_recalls"
      expr: COUNT(CASE WHEN recall_status = 'Closed' THEN 1 END)
      comment: "Count of recalls that have been closed"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`quality_food_safety_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Food safety audit KPIs tracking audit performance, certification status, non-conformance trends, and corrective action effectiveness for food safety management and compliance."
  source: "`food_beverage_ecm`.`quality`.`food_safety_audit`"
  dimensions:
    - name: "food_safety_audit_status"
      expr: food_safety_audit_status
      comment: "Current status of the food safety audit"
    - name: "audit_type"
      expr: audit_type
      comment: "Type of food safety audit (e.g., internal, third-party, regulatory)"
    - name: "certification_scheme"
      expr: certification_scheme
      comment: "Certification scheme used (e.g., SQF, BRC, FSSC 22000)"
    - name: "certification_outcome"
      expr: certification_outcome
      comment: "Outcome of certification audit (e.g., certified, conditional, failed)"
    - name: "overall_grade"
      expr: overall_grade
      comment: "Overall grade assigned to the audit"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level identified during audit"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required"
    - name: "closure_status"
      expr: closure_status
      comment: "Closure status of audit findings"
    - name: "audit_start_month"
      expr: DATE_TRUNC('MONTH', audit_start_date)
      comment: "Month when audit started"
    - name: "audit_start_year"
      expr: YEAR(audit_start_date)
      comment: "Year when audit started"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of food safety audits conducted"
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall audit score"
    - name: "certified_audits"
      expr: COUNT(CASE WHEN certification_outcome = 'Certified' THEN 1 END)
      comment: "Count of audits resulting in certification"
    - name: "audits_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of audits requiring corrective action"
    - name: "total_major_non_conformances"
      expr: SUM(CAST(major_non_conformance_count AS DOUBLE))
      comment: "Total count of major non-conformances identified"
    - name: "total_minor_non_conformances"
      expr: SUM(CAST(minor_non_conformance_count AS DOUBLE))
      comment: "Total count of minor non-conformances identified"
    - name: "avg_major_nc_per_audit"
      expr: AVG(CAST(major_non_conformance_count AS DOUBLE))
      comment: "Average major non-conformances per audit"
    - name: "avg_minor_nc_per_audit"
      expr: AVG(CAST(minor_non_conformance_count AS DOUBLE))
      comment: "Average minor non-conformances per audit"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`quality_capa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and Preventive Action (CAPA) KPIs tracking action effectiveness, closure rates, risk mitigation, and continuous improvement for quality management systems."
  source: "`food_beverage_ecm`.`quality`.`capa`"
  dimensions:
    - name: "capa_status"
      expr: capa_status
      comment: "Current status of the CAPA (e.g., open, in progress, closed)"
    - name: "capa_type"
      expr: capa_type
      comment: "Type of CAPA (e.g., corrective, preventive, both)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the CAPA"
    - name: "severity"
      expr: severity
      comment: "Severity level of the issue addressed by CAPA"
    - name: "root_cause_method"
      expr: root_cause_method
      comment: "Method used for root cause analysis (e.g., 5 Whys, Fishbone, FMEA)"
    - name: "is_effective"
      expr: is_effective
      comment: "Whether CAPA was verified as effective"
    - name: "is_closed"
      expr: is_closed
      comment: "Whether CAPA is closed"
    - name: "effectiveness_verification_result"
      expr: effectiveness_verification_result
      comment: "Result of effectiveness verification"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month when CAPA was created"
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year when CAPA was created"
  measures:
    - name: "total_capas"
      expr: COUNT(1)
      comment: "Total number of CAPA records"
    - name: "closed_capas"
      expr: COUNT(CASE WHEN is_closed = TRUE THEN 1 END)
      comment: "Count of closed CAPAs"
    - name: "effective_capas"
      expr: COUNT(CASE WHEN is_effective = TRUE THEN 1 END)
      comment: "Count of CAPAs verified as effective"
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score across CAPAs"
    - name: "high_priority_capas"
      expr: COUNT(CASE WHEN priority = 'High' THEN 1 END)
      comment: "Count of high priority CAPAs"
    - name: "critical_severity_capas"
      expr: COUNT(CASE WHEN severity = 'Critical' THEN 1 END)
      comment: "Count of critical severity CAPAs"
    - name: "capas_with_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_description IS NOT NULL THEN 1 END)
      comment: "Count of CAPAs with documented corrective action"
    - name: "capas_with_preventive_action"
      expr: COUNT(CASE WHEN preventive_action_description IS NOT NULL THEN 1 END)
      comment: "Count of CAPAs with documented preventive action"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`quality_micro_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Microbiological test result KPIs tracking pathogen detection, test pass rates, regulatory compliance, and food safety performance for quality assurance and risk management."
  source: "`food_beverage_ecm`.`quality`.`micro_test_result`"
  dimensions:
    - name: "test_status"
      expr: test_status
      comment: "Current status of the microbiological test"
    - name: "pass_fail"
      expr: pass_fail
      comment: "Pass or fail result of the test"
    - name: "target_organism"
      expr: target_organism
      comment: "Target organism being tested (e.g., Salmonella, Listeria, E. coli)"
    - name: "test_method"
      expr: test_method
      comment: "Method used for microbiological testing"
    - name: "sample_type"
      expr: sample_type
      comment: "Type of sample tested (e.g., finished product, raw material, environmental)"
    - name: "sample_source"
      expr: sample_source
      comment: "Source of the sample"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether test result meets regulatory compliance"
    - name: "is_control_sample"
      expr: is_control_sample
      comment: "Whether sample is a control sample"
    - name: "analysis_month"
      expr: DATE_TRUNC('MONTH', analysis_date)
      comment: "Month when analysis was performed"
    - name: "analysis_year"
      expr: YEAR(analysis_date)
      comment: "Year when analysis was performed"
  measures:
    - name: "total_micro_tests"
      expr: COUNT(1)
      comment: "Total number of microbiological tests performed"
    - name: "passed_tests"
      expr: COUNT(CASE WHEN pass_fail = 'Pass' THEN 1 END)
      comment: "Count of tests that passed"
    - name: "failed_tests"
      expr: COUNT(CASE WHEN pass_fail = 'Fail' THEN 1 END)
      comment: "Count of tests that failed"
    - name: "compliant_tests"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Count of tests meeting regulatory compliance"
    - name: "avg_result_value"
      expr: AVG(CAST(result_value AS DOUBLE))
      comment: "Average result value across all tests"
    - name: "avg_incubation_temperature"
      expr: AVG(CAST(incubation_temperature_c AS DOUBLE))
      comment: "Average incubation temperature in Celsius"
    - name: "avg_incubation_time"
      expr: AVG(CAST(incubation_time_hours AS DOUBLE))
      comment: "Average incubation time in hours"
    - name: "avg_detection_limit"
      expr: AVG(CAST(detection_limit AS DOUBLE))
      comment: "Average detection limit across tests"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`quality_supplier_quality_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier quality assessment KPIs tracking supplier performance, certification status, quality scores, and risk tier for supplier management and procurement decisions."
  source: "`food_beverage_ecm`.`quality`.`supplier_quality_assessment`"
  dimensions:
    - name: "supplier_quality_assessment_status"
      expr: supplier_quality_assessment_status
      comment: "Current status of the supplier quality assessment"
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of assessment performed (e.g., initial, periodic, re-assessment)"
    - name: "assessment_outcome"
      expr: assessment_outcome
      comment: "Outcome of the assessment (e.g., approved, conditional, rejected)"
    - name: "supplier_rating"
      expr: supplier_rating
      comment: "Overall supplier rating (e.g., A, B, C, D)"
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier assigned to supplier (e.g., high, medium, low)"
    - name: "approved_supplier_list_status"
      expr: approved_supplier_list_status
      comment: "Status on approved supplier list"
    - name: "brc_certified"
      expr: brc_certified
      comment: "Whether supplier is BRC certified"
    - name: "fssc_certified"
      expr: fssc_certified
      comment: "Whether supplier is FSSC 22000 certified"
    - name: "sqf_certified"
      expr: sqf_certified
      comment: "Whether supplier is SQF certified"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required from supplier"
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month when assessment was performed"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year when assessment was performed"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of supplier quality assessments"
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall assessment score"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score"
    - name: "avg_food_safety_score"
      expr: AVG(CAST(food_safety_score AS DOUBLE))
      comment: "Average food safety score"
    - name: "approved_suppliers"
      expr: COUNT(CASE WHEN assessment_outcome = 'Approved' THEN 1 END)
      comment: "Count of suppliers approved in assessment"
    - name: "assessments_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of assessments requiring corrective action"
    - name: "brc_certified_suppliers"
      expr: COUNT(CASE WHEN brc_certified = TRUE THEN 1 END)
      comment: "Count of BRC certified suppliers"
    - name: "fssc_certified_suppliers"
      expr: COUNT(CASE WHEN fssc_certified = TRUE THEN 1 END)
      comment: "Count of FSSC 22000 certified suppliers"
    - name: "sqf_certified_suppliers"
      expr: COUNT(CASE WHEN sqf_certified = TRUE THEN 1 END)
      comment: "Count of SQF certified suppliers"
    - name: "avg_brix_value"
      expr: AVG(CAST(brix_value AS DOUBLE))
      comment: "Average Brix value from supplier assessments"
    - name: "avg_ph_value"
      expr: AVG(CAST(ph_value AS DOUBLE))
      comment: "Average pH value from supplier assessments"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`quality_hold_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hold record KPIs tracking inventory holds, disposition decisions, hold duration, and compliance for quality control and inventory management."
  source: "`food_beverage_ecm`.`quality`.`hold_record`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the hold (e.g., active, released, expired)"
    - name: "hold_type"
      expr: hold_type
      comment: "Type of hold (e.g., quality, regulatory, customer)"
    - name: "hold_reason"
      expr: hold_reason
      comment: "Reason for placing the hold"
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Disposition decision for held material (e.g., release, scrap, rework)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the hold"
    - name: "is_fifo_compliant"
      expr: is_fifo_compliant
      comment: "Whether hold is FIFO compliant"
    - name: "is_fefo_compliant"
      expr: is_fefo_compliant
      comment: "Whether hold is FEFO compliant"
    - name: "hold_initiation_month"
      expr: DATE_TRUNC('MONTH', hold_initiation_timestamp)
      comment: "Month when hold was initiated"
    - name: "hold_initiation_year"
      expr: YEAR(hold_initiation_timestamp)
      comment: "Year when hold was initiated"
  measures:
    - name: "total_holds"
      expr: COUNT(1)
      comment: "Total number of hold records"
    - name: "total_quantity_held"
      expr: SUM(CAST(quantity_held AS DOUBLE))
      comment: "Total quantity of material under hold"
    - name: "avg_quantity_per_hold"
      expr: AVG(CAST(quantity_held AS DOUBLE))
      comment: "Average quantity per hold record"
    - name: "active_holds"
      expr: COUNT(CASE WHEN hold_status = 'Active' THEN 1 END)
      comment: "Count of currently active holds"
    - name: "released_holds"
      expr: COUNT(CASE WHEN hold_status = 'Released' THEN 1 END)
      comment: "Count of holds that have been released"
    - name: "fifo_compliant_holds"
      expr: COUNT(CASE WHEN is_fifo_compliant = TRUE THEN 1 END)
      comment: "Count of FIFO compliant holds"
    - name: "fefo_compliant_holds"
      expr: COUNT(CASE WHEN is_fefo_compliant = TRUE THEN 1 END)
      comment: "Count of FEFO compliant holds"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`quality_critical_control_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Critical Control Point (CCP) KPIs tracking HACCP compliance, deviation frequency, control limit adherence, and monitoring effectiveness for food safety management."
  source: "`food_beverage_ecm`.`quality`.`critical_control_point`"
  dimensions:
    - name: "critical_control_point_status"
      expr: critical_control_point_status
      comment: "Current status of the critical control point"
    - name: "control_point_category"
      expr: control_point_category
      comment: "Category of the control point (e.g., biological, chemical, physical)"
    - name: "hazard_type"
      expr: hazard_type
      comment: "Type of hazard controlled at this CCP"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with this CCP"
    - name: "is_critical"
      expr: is_critical
      comment: "Whether this is a critical control point"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the CCP"
    - name: "last_measurement_status"
      expr: last_measurement_status
      comment: "Status of the last measurement (e.g., in spec, out of spec)"
    - name: "process_step"
      expr: process_step
      comment: "Process step where CCP is monitored"
    - name: "monitoring_method"
      expr: monitoring_method
      comment: "Method used for monitoring the CCP"
  measures:
    - name: "total_ccps"
      expr: COUNT(1)
      comment: "Total number of critical control points"
    - name: "critical_ccps"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Count of critical control points"
    - name: "compliant_ccps"
      expr: COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END)
      comment: "Count of CCPs in compliance"
    - name: "avg_critical_limit_value"
      expr: AVG(CAST(critical_limit_value AS DOUBLE))
      comment: "Average critical limit value across CCPs"
    - name: "avg_last_measured_value"
      expr: AVG(CAST(last_measured_value AS DOUBLE))
      comment: "Average of last measured values across CCPs"
    - name: "avg_tolerance_lower"
      expr: AVG(CAST(tolerance_lower AS DOUBLE))
      comment: "Average lower tolerance limit"
    - name: "avg_tolerance_upper"
      expr: AVG(CAST(tolerance_upper AS DOUBLE))
      comment: "Average upper tolerance limit"
    - name: "out_of_spec_ccps"
      expr: COUNT(CASE WHEN last_measurement_status = 'Out of Spec' THEN 1 END)
      comment: "Count of CCPs with out-of-spec measurements"
$$;