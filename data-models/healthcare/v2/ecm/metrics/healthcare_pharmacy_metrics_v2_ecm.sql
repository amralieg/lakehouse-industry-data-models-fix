-- Metric views for domain: pharmacy | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 14:47:42

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_dispense_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy dispensing KPIs covering volume, revenue, payer mix, patient cost burden, and counseling compliance. Used by pharmacy operations and finance leadership to steer dispensing throughput, margin, and patient-safety counseling rates."
  source: "`vibe_healthcare_v1`.`pharmacy`.`dispense_event`"
  dimensions:
    - name: "dispense_month"
      expr: DATE_TRUNC('MONTH', dispense_date)
      comment: "Month of dispense, for volume and revenue trending."
    - name: "dispense_status"
      expr: dispense_event_status
      comment: "Lifecycle status of the dispense event (e.g. completed, cancelled) for fulfillment analysis."
    - name: "dispense_type"
      expr: dispense_type
      comment: "Type of dispense (e.g. new, refill, mail-order) to compare channel performance."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA controlled-substance schedule for compliance-sensitive dispensing analysis."
    - name: "dispensing_location_name"
      expr: dispensing_location_name
      comment: "Pharmacy location name to compare dispensing volume across sites."
  measures:
    - name: "dispense_count"
      expr: COUNT(1)
      comment: "Total number of dispense events; baseline throughput metric for pharmacy operations."
    - name: "total_dispensed_quantity"
      expr: SUM(CAST(dispensed_quantity AS DOUBLE))
      comment: "Total quantity of medication dispensed; drives inventory and demand planning."
    - name: "total_medication_cost"
      expr: SUM(CAST(medication_cost_amount AS DOUBLE))
      comment: "Total drug acquisition cost dispensed; key driver of pharmacy spend management."
    - name: "total_insurance_paid"
      expr: SUM(CAST(insurance_paid_amount AS DOUBLE))
      comment: "Total reimbursed by insurance; informs payer reimbursement performance."
    - name: "total_patient_pay"
      expr: SUM(CAST(patient_pay_amount AS DOUBLE))
      comment: "Total patient out-of-pocket; signals affordability and abandonment risk."
    - name: "total_dispensing_fee"
      expr: SUM(CAST(dispensing_fee_amount AS DOUBLE))
      comment: "Total dispensing fee revenue; component of pharmacy service margin."
    - name: "avg_patient_pay"
      expr: AVG(CAST(patient_pay_amount AS DOUBLE))
      comment: "Average patient cost per fill; affordability KPI watched by leadership."
    - name: "counseling_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN patient_counseling_completed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of fills with completed patient counseling; patient-safety and OBRA-90 compliance KPI."
    - name: "substitution_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN substitution_made_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of fills with generic/therapeutic substitution; cost-savings effectiveness KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_rx_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy claim adjudication KPIs covering billed vs paid, copay, reject rates, and reimbursement leakage. Used by revenue cycle and PBM contract management to steer reimbursement performance."
  source: "`vibe_healthcare_v1`.`pharmacy`.`rx_claim`"
  dimensions:
    - name: "claim_month"
      expr: DATE_TRUNC('MONTH', claim_date)
      comment: "Month of claim submission for reimbursement trending."
    - name: "claim_status"
      expr: rx_claim_status
      comment: "Adjudication status of the claim for accept/reject analysis."
    - name: "transaction_response_status"
      expr: transaction_response_status
      comment: "Real-time transaction response status from the PBM switch."
    - name: "reject_code"
      expr: reject_code
      comment: "Reject reason code to identify top denial drivers."
    - name: "drug_name"
      expr: drug_name
      comment: "Dispensed drug name for high-cost drug reimbursement analysis."
  measures:
    - name: "claim_count"
      expr: COUNT(1)
      comment: "Total pharmacy claims processed; baseline volume metric."
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total amount billed to payers; top-line pharmacy revenue exposure."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount paid across claims; actual collected reimbursement."
    - name: "total_plan_paid"
      expr: SUM(CAST(plan_paid_amount AS DOUBLE))
      comment: "Total paid by the plan; informs payer mix and contract performance."
    - name: "total_patient_copay"
      expr: SUM(CAST(patient_copay AS DOUBLE))
      comment: "Total patient copay; affordability and collections KPI."
    - name: "total_ingredient_cost"
      expr: SUM(CAST(ingredient_cost AS DOUBLE))
      comment: "Total drug ingredient cost; margin denominator for pharmacy P&L."
    - name: "avg_paid_amount"
      expr: AVG(CAST(paid_amount AS DOUBLE))
      comment: "Average reimbursement per claim; unit-economics KPI for contract negotiation."
    - name: "reject_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reject_code IS NOT NULL AND reject_code <> '' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of claims rejected; revenue-cycle efficiency and rework KPI."
    - name: "distinct_payers"
      expr: COUNT(DISTINCT payer_id)
      comment: "Number of distinct payers billed; payer concentration / diversification metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_prescription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prescription lifecycle KPIs covering volume, e-prescribing transmission performance, prior-auth burden, and controlled-substance prescribing. Used by clinical and operations leadership to steer ePrescribing adoption and PA workflow."
  source: "`vibe_healthcare_v1`.`pharmacy`.`prescription`"
  dimensions:
    - name: "prescription_month"
      expr: DATE_TRUNC('MONTH', prescription_date)
      comment: "Month the prescription was written for volume trending."
    - name: "prescription_status"
      expr: prescription_status
      comment: "Status of the prescription for fulfillment and discontinuation analysis."
    - name: "prescription_type"
      expr: prescription_type
      comment: "Prescription type (e.g. new, refill) for mix analysis."
    - name: "erx_transmission_status"
      expr: erx_transmission_status
      comment: "E-prescribing transmission status to monitor electronic routing success."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA schedule for controlled-substance prescribing oversight."
  measures:
    - name: "prescription_count"
      expr: COUNT(1)
      comment: "Total prescriptions written; baseline prescribing volume metric."
    - name: "total_quantity_prescribed"
      expr: SUM(CAST(quantity_prescribed AS DOUBLE))
      comment: "Total quantity prescribed; demand-planning input for inventory."
    - name: "epcs_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN epcs_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of controlled prescriptions sent via EPCS; DEA e-prescribing compliance KPI."
    - name: "prior_auth_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN prior_authorization_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of prescriptions requiring prior authorization; PA administrative burden KPI."
    - name: "substitution_allowed_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN substitution_allowed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of prescriptions allowing substitution; generic-utilization opportunity KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_medication_pa_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medication prior authorization KPIs covering approval rates, turnaround, appeals, and specialty-drug burden. Used by pharmacy and revenue-cycle leadership to steer PA efficiency and patient access."
  source: "`vibe_healthcare_v1`.`pharmacy`.`medication_pa_request`"
  dimensions:
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', pa_request_date)
      comment: "Month the PA request was submitted for turnaround trending."
    - name: "pa_status"
      expr: pa_status
      comment: "Current status of the PA request for pipeline analysis."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency of the request to compare standard vs expedited handling."
    - name: "denial_reason"
      expr: denial_reason
      comment: "Denial reason for identifying top access barriers."
    - name: "specialty_medication_flag"
      expr: specialty_medication_flag
      comment: "Whether the drug is specialty; specialty PA burden is materially higher."
  measures:
    - name: "pa_request_count"
      expr: COUNT(1)
      comment: "Total PA requests; baseline administrative volume metric."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN approval_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of PA requests approved; patient-access and formulary alignment KPI."
    - name: "appeal_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN appeal_submitted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of PA requests appealed; signals denial friction and rework cost."
    - name: "total_estimated_medication_cost"
      expr: SUM(CAST(estimated_medication_cost AS DOUBLE))
      comment: "Total estimated cost of medications under PA; spend-at-risk metric."
    - name: "avg_estimated_medication_cost"
      expr: AVG(CAST(estimated_medication_cost AS DOUBLE))
      comment: "Average estimated medication cost per PA; high-cost drug access KPI."
    - name: "specialty_pa_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN specialty_medication_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of PA requests for specialty drugs; specialty-pharmacy workload KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_adverse_drug_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adverse drug event KPIs covering volume, harm severity, preventability, and regulatory reporting. Used by patient-safety and quality leadership to steer medication-safety interventions."
  source: "`vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event`"
  dimensions:
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month of the adverse drug event for safety-trend monitoring."
    - name: "severity"
      expr: severity
      comment: "Severity of the ADE for risk stratification."
    - name: "harm_category"
      expr: harm_category
      comment: "Category of patient harm for safety prioritization."
    - name: "event_type"
      expr: event_type
      comment: "Type of adverse drug event for root-cause grouping."
    - name: "detection_method"
      expr: detection_method
      comment: "How the event was detected; informs surveillance program effectiveness."
  measures:
    - name: "ade_count"
      expr: COUNT(1)
      comment: "Total adverse drug events; core patient-safety surveillance metric."
    - name: "intervention_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN intervention_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of ADEs requiring intervention; severity/burden KPI for safety teams."
    - name: "fda_reported_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reported_to_fda = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of ADEs reported to FDA; regulatory reporting compliance KPI."
    - name: "rca_performed_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN root_cause_analysis_performed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of ADEs with root-cause analysis; quality-improvement rigor KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy inventory KPIs covering on-hand value, days supply, shortages, and cycle-count variance. Used by supply-chain and pharmacy operations leadership to steer working capital and stockout risk."
  source: "`vibe_healthcare_v1`.`pharmacy`.`inventory`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Status of inventory line for active/quarantine analysis."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA schedule for controlled-substance inventory oversight."
    - name: "formulary_status"
      expr: formulary_status
      comment: "Formulary status to align inventory with covered products."
    - name: "storage_requirements"
      expr: storage_requirements
      comment: "Storage requirement (e.g. refrigerated) for cold-chain inventory planning."
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_timestamp)
      comment: "Snapshot month for inventory value trending."
  measures:
    - name: "inventory_line_count"
      expr: COUNT(1)
      comment: "Number of inventory positions tracked; baseline catalog-breadth metric."
    - name: "total_inventory_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total on-hand inventory value; working-capital KPI for pharmacy finance."
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total units on hand; demand-coverage input."
    - name: "avg_cycle_count_variance"
      expr: AVG(CAST(cycle_count_variance AS DOUBLE))
      comment: "Average cycle-count variance; inventory-accuracy and shrinkage KPI."
    - name: "shortage_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN shortage_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of inventory positions flagged in shortage; stockout-risk KPI."
    - name: "high_alert_med_count"
      expr: SUM(CASE WHEN high_alert_medication = TRUE THEN 1 ELSE 0 END)
      comment: "Count of high-alert medication positions; safety-stewardship metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_medication_therapy_mgmt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medication Therapy Management KPIs covering service volume, cost avoidance, drug therapy problems, and CMS Part D compliance. Used by clinical pharmacy and value-based-care leadership to steer MTM program ROI."
  source: "`vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt`"
  dimensions:
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month of MTM service for engagement trending."
    - name: "service_type"
      expr: service_type
      comment: "Type of MTM service for program mix analysis."
    - name: "outcome_status"
      expr: outcome_status
      comment: "Outcome status of the MTM intervention for effectiveness analysis."
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status to track MTM revenue capture."
  measures:
    - name: "mtm_service_count"
      expr: COUNT(1)
      comment: "Total MTM services delivered; baseline program throughput metric."
    - name: "total_cost_avoidance"
      expr: SUM(CAST(estimated_cost_avoidance_amount AS DOUBLE))
      comment: "Total estimated cost avoidance; core MTM program ROI KPI."
    - name: "avg_cost_avoidance"
      expr: AVG(CAST(estimated_cost_avoidance_amount AS DOUBLE))
      comment: "Average cost avoidance per service; per-intervention value KPI."
    - name: "dtp_identified_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN drug_therapy_problem_identified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of services identifying a drug therapy problem; clinical-impact KPI."
    - name: "part_d_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN cms_part_d_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of MTM services CMS Part D compliant; Star Ratings and compliance KPI."
    - name: "distinct_patients_served"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients receiving MTM; program reach KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_controlled_substance_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Controlled substance transaction KPIs covering discrepancies, overrides, PDMP reporting, and diversion-risk signals. Used by compliance and pharmacy leadership to steer diversion-prevention programs."
  source: "`vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log`"
  dimensions:
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of the controlled-substance transaction for diversion-trend monitoring."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of transaction (dispense, waste, transfer) for flow analysis."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA schedule of the controlled substance for risk stratification."
    - name: "storage_location"
      expr: storage_location
      comment: "Storage location for location-level diversion-risk analysis."
  measures:
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total controlled-substance transactions; baseline accountability metric."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity transacted; volume input for diversion analytics."
    - name: "discrepancy_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN discrepancy_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of transactions with discrepancies; diversion-risk and compliance KPI."
    - name: "override_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN override_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of transactions with overrides; ADC-override surveillance KPI."
    - name: "pdmp_reported_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pdmp_reported_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of transactions reported to PDMP; state-reporting compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_rems_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "REMS program compliance KPIs covering enrollment, certification, lab monitoring, and overall compliance status. Used by compliance and specialty-pharmacy leadership to steer REMS adherence and FDA reporting."
  source: "`vibe_healthcare_v1`.`pharmacy`.`rems_compliance`"
  dimensions:
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of REMS enrollment for program-onboarding trending."
    - name: "program_name"
      expr: program_name
      comment: "REMS program name for program-level compliance analysis."
    - name: "overall_compliance_status"
      expr: overall_compliance_status
      comment: "Overall compliance status for the REMS record."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category of the REMS drug for stratified oversight."
  measures:
    - name: "rems_record_count"
      expr: COUNT(1)
      comment: "Total REMS compliance records; baseline program-population metric."
    - name: "prescriber_certified_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN prescriber_certification_status = 'Certified' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of records with certified prescribers; REMS prescriber-compliance KPI."
    - name: "patient_enrolled_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN patient_enrollment_status = 'Enrolled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of records with enrolled patients; REMS patient-enrollment compliance KPI."
    - name: "lab_monitoring_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN lab_monitoring_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of REMS records requiring lab monitoring; monitoring-burden KPI."
    - name: "fda_reporting_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN fda_reporting_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of records requiring FDA reporting; regulatory-obligation KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_drug_recall`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug recall management KPIs covering recall volume, patient impact, notification completeness, and financial exposure. Used by pharmacy safety and compliance leadership to steer recall response."
  source: "`vibe_healthcare_v1`.`pharmacy`.`drug_recall`"
  dimensions:
    - name: "recall_month"
      expr: DATE_TRUNC('MONTH', recall_date)
      comment: "Month the recall was initiated for response-trend monitoring."
    - name: "recall_class"
      expr: recall_class
      comment: "FDA recall classification (Class I/II/III) for severity stratification."
    - name: "recall_status"
      expr: recall_status
      comment: "Current recall status for response-completion tracking."
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall for response-process analysis."
  measures:
    - name: "recall_count"
      expr: COUNT(1)
      comment: "Total drug recalls handled; baseline safety-response volume metric."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of recalls; cost-exposure KPI for finance."
    - name: "total_quantity_returned"
      expr: SUM(CAST(quantity_returned AS DOUBLE))
      comment: "Total quantity returned during recalls; recovery-effectiveness metric."
    - name: "total_quantity_quarantined"
      expr: SUM(CAST(quantity_quarantined AS DOUBLE))
      comment: "Total quantity quarantined; containment-effectiveness metric."
    - name: "adverse_event_reported_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN adverse_event_reported = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of recalls with associated adverse events; patient-harm signal KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_mar_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medication administration record KPIs covering administration volume, first-dose handling, STAT timeliness signals, and waste. Used by nursing and pharmacy leadership to steer safe medication administration."
  source: "`vibe_healthcare_v1`.`pharmacy`.`mar_record`"
  dimensions:
    - name: "administration_month"
      expr: DATE_TRUNC('MONTH', actual_administration_timestamp)
      comment: "Month of medication administration for volume trending."
    - name: "administration_status"
      expr: administration_status
      comment: "Administration status (given, held, refused) for adherence analysis."
    - name: "route"
      expr: route
      comment: "Route of administration for clinical mix analysis."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA schedule for controlled-substance administration oversight."
  measures:
    - name: "administration_count"
      expr: COUNT(1)
      comment: "Total medication administrations recorded; baseline clinical-throughput metric."
    - name: "total_dose_given"
      expr: SUM(CAST(dose_given AS DOUBLE))
      comment: "Total dose administered; medication-utilization input."
    - name: "total_waste_amount"
      expr: SUM(CAST(waste_amount AS DOUBLE))
      comment: "Total medication waste; cost and controlled-substance accountability KPI."
    - name: "first_dose_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_first_dose = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of administrations that are first doses; first-dose monitoring safety KPI."
    - name: "stat_order_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_stat_order = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of administrations from STAT orders; acuity and timeliness KPI."
$$;