-- Metric views for domain: pharmacy | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`pharmacy_dispense_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core pharmacy dispensing metrics tracking volume, cost, substitution rates, and payer mix for operational and financial steering of pharmacy operations."
  source: "`healthcare_ecm_v1`.`pharmacy`.`dispense_event`"
  dimensions:
    - name: "dispense_status"
      expr: dispense_status
      comment: "Current status of the dispense event (completed, pending, cancelled) for workflow analysis"
    - name: "dispense_type"
      expr: dispense_type
      comment: "Type of dispensing (new, refill, partial) for volume segmentation"
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA controlled substance schedule for regulatory compliance monitoring"
    - name: "substitution_made"
      expr: substitution_made_flag
      comment: "Whether generic substitution was made - key cost management indicator"
    - name: "patient_counseling_completed"
      expr: patient_counseling_completed_flag
      comment: "Whether patient counseling was completed - regulatory compliance metric"
    - name: "dispense_month"
      expr: DATE_TRUNC('month', dispense_timestamp)
      comment: "Month of dispensing for trend analysis"
    - name: "dispense_year"
      expr: YEAR(dispense_timestamp)
      comment: "Year of dispensing for annual comparisons"
    - name: "fill_number"
      expr: fill_number
      comment: "Fill number indicating new vs refill for adherence analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for financial reporting segmentation"
  measures:
    - name: "total_dispense_events"
      expr: COUNT(1)
      comment: "Total number of dispense events - baseline volume metric for pharmacy throughput"
    - name: "total_medication_cost"
      expr: SUM(CAST(medication_cost_amount AS DOUBLE))
      comment: "Total medication acquisition cost - key driver of pharmacy P&L"
    - name: "total_dispensing_fees"
      expr: SUM(CAST(dispensing_fee_amount AS DOUBLE))
      comment: "Total dispensing fee revenue - professional service revenue component"
    - name: "total_insurance_paid"
      expr: SUM(CAST(insurance_paid_amount AS DOUBLE))
      comment: "Total amount paid by insurance - payer mix and reimbursement analysis"
    - name: "total_patient_pay"
      expr: SUM(CAST(patient_pay_amount AS DOUBLE))
      comment: "Total patient out-of-pocket cost - patient financial burden indicator"
    - name: "total_dispensed_quantity"
      expr: SUM(CAST(dispensed_quantity AS DOUBLE))
      comment: "Total units dispensed - operational volume metric"
    - name: "avg_medication_cost_per_dispense"
      expr: AVG(CAST(medication_cost_amount AS DOUBLE))
      comment: "Average cost per dispense event - cost efficiency benchmark"
    - name: "generic_substitution_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN substitution_made_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dispenses where generic substitution occurred - formulary compliance and cost management KPI"
    - name: "patient_counseling_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN patient_counseling_completed_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dispenses with completed patient counseling - regulatory compliance rate"
    - name: "unique_patients_served"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct patients served - market reach and panel size indicator"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`pharmacy_prescription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prescription lifecycle metrics covering volume, e-prescribing adoption, controlled substance patterns, and prior authorization burden for pharmacy operations management."
  source: "`healthcare_ecm_v1`.`pharmacy`.`prescription`"
  dimensions:
    - name: "prescription_status"
      expr: prescription_status
      comment: "Current prescription status for workflow pipeline analysis"
    - name: "prescription_type"
      expr: prescription_type
      comment: "Type of prescription (new, renewal, transfer) for volume segmentation"
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA schedule classification for controlled substance monitoring"
    - name: "formulary_status"
      expr: formulary_status
      comment: "Formulary tier status for cost management analysis"
    - name: "epcs_flag"
      expr: epcs_flag
      comment: "Electronic prescribing for controlled substances flag - regulatory compliance indicator"
    - name: "prior_auth_required"
      expr: prior_authorization_required_flag
      comment: "Whether prior authorization is required - administrative burden indicator"
    - name: "substitution_allowed"
      expr: substitution_allowed_flag
      comment: "Whether generic substitution is permitted by prescriber"
    - name: "prescription_month"
      expr: DATE_TRUNC('month', prescription_timestamp)
      comment: "Month of prescription for trend analysis"
    - name: "dosage_form"
      expr: dosage_form
      comment: "Dosage form for product mix analysis"
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration for clinical pattern analysis"
  measures:
    - name: "total_prescriptions"
      expr: COUNT(1)
      comment: "Total prescription volume - primary workload and demand metric"
    - name: "total_quantity_prescribed"
      expr: SUM(CAST(quantity_prescribed AS DOUBLE))
      comment: "Total units prescribed - demand forecasting input"
    - name: "epcs_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN epcs_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "E-prescribing adoption rate for controlled substances - DEA compliance and modernization KPI"
    - name: "prior_auth_burden_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN prior_authorization_required_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prescriptions requiring prior authorization - administrative burden and patient access barrier metric"
    - name: "controlled_substance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN dea_schedule IS NOT NULL AND dea_schedule != '' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prescriptions that are controlled substances - risk and compliance monitoring"
    - name: "unique_prescribers"
      expr: COUNT(DISTINCT primary_prescription_clinician_id)
      comment: "Distinct prescribing providers - network breadth indicator"
    - name: "unique_patients"
      expr: COUNT(DISTINCT primary_mpi_record_id)
      comment: "Distinct patients with prescriptions - patient panel size"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`pharmacy_adverse_drug_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adverse drug event safety metrics tracking severity, preventability, detection methods, and regulatory reporting compliance for patient safety and quality improvement."
  source: "`healthcare_ecm_v1`.`pharmacy`.`adverse_drug_event`"
  dimensions:
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the adverse event for risk stratification"
    - name: "harm_category"
      expr: harm_category
      comment: "Category of harm caused for root cause analysis"
    - name: "detection_method"
      expr: detection_method
      comment: "How the ADE was detected - surveillance effectiveness indicator"
    - name: "preventability_assessment"
      expr: preventability_assessment
      comment: "Whether the event was preventable - quality improvement targeting"
    - name: "adverse_drug_event_status"
      expr: adverse_drug_event_status
      comment: "Current status of the ADE investigation"
    - name: "outcome"
      expr: outcome
      comment: "Patient outcome from the adverse event"
    - name: "intervention_required"
      expr: intervention_required
      comment: "Whether clinical intervention was needed - severity proxy"
    - name: "reported_to_fda"
      expr: reported_to_fda
      comment: "FDA reporting status for regulatory compliance tracking"
    - name: "event_month"
      expr: DATE_TRUNC('month', consent_event_timestamp)
      comment: "Month of event for trend analysis"
    - name: "reporter_role"
      expr: reporter_role
      comment: "Role of the person who reported the event - reporting culture indicator"
  measures:
    - name: "total_adverse_drug_events"
      expr: COUNT(1)
      comment: "Total ADE count - primary patient safety volume metric"
    - name: "preventable_ade_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN preventability_assessment = 'Preventable' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ADEs assessed as preventable - key quality improvement target metric"
    - name: "intervention_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN intervention_required = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ADEs requiring clinical intervention - severity indicator for resource planning"
    - name: "fda_reporting_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reported_to_fda = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "FDA reporting compliance rate - regulatory compliance KPI"
    - name: "root_cause_analysis_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN root_cause_analysis_performed = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ADEs with completed root cause analysis - quality investigation thoroughness"
    - name: "unique_causative_drugs"
      expr: COUNT(DISTINCT causative_drug_master_id)
      comment: "Distinct drugs causing adverse events - formulary risk identification"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`pharmacy_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy inventory management metrics covering stock levels, shortage indicators, expiration risk, and cost for supply chain optimization and patient safety."
  source: "`healthcare_ecm_v1`.`pharmacy`.`inventory`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current inventory status for stock management"
    - name: "formulary_status"
      expr: formulary_status
      comment: "Formulary tier for strategic inventory prioritization"
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA schedule for controlled substance inventory segregation"
    - name: "high_alert_medication"
      expr: high_alert_medication
      comment: "ISMP high-alert medication flag for safety-critical inventory focus"
    - name: "shortage_indicator"
      expr: shortage_indicator
      comment: "Whether item is in shortage - supply chain risk indicator"
    - name: "snapshot_month"
      expr: DATE_TRUNC('month', snapshot_timestamp)
      comment: "Inventory snapshot month for trend analysis"
  measures:
    - name: "total_inventory_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total dollar value of pharmacy inventory - working capital metric"
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total units on hand across all items"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across inventory - cost benchmarking"
    - name: "shortage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN shortage_indicator = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inventory items in shortage - supply chain risk KPI"
    - name: "high_alert_medication_count"
      expr: SUM(CASE WHEN high_alert_medication = true THEN 1 ELSE 0 END)
      comment: "Count of high-alert medication inventory items - safety oversight metric"
    - name: "avg_days_supply_coverage"
      expr: AVG(CAST(average_daily_usage AS DOUBLE))
      comment: "Average daily usage rate across items - demand planning input"
    - name: "total_cycle_count_variance"
      expr: SUM(CAST(cycle_count_variance AS DOUBLE))
      comment: "Total cycle count variance - inventory accuracy and shrinkage indicator"
    - name: "unique_items_in_stock"
      expr: COUNT(DISTINCT drug_master_id)
      comment: "Distinct drug products in inventory - formulary breadth metric"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`pharmacy_controlled_substance_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Controlled substance tracking metrics for DEA compliance, diversion detection, and waste monitoring across pharmacy operations."
  source: "`healthcare_ecm_v1`.`pharmacy`.`controlled_substance_log`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of controlled substance transaction (receipt, dispense, waste, transfer)"
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA schedule classification for regulatory reporting segmentation"
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Whether a count discrepancy was identified - diversion risk indicator"
    - name: "override_flag"
      expr: override_flag
      comment: "Whether an override was used - potential diversion signal"
    - name: "pdmp_reported_flag"
      expr: pdmp_reported_flag
      comment: "Whether reported to PDMP - state compliance indicator"
    - name: "transaction_month"
      expr: DATE_TRUNC('month', transaction_timestamp)
      comment: "Month of transaction for trend analysis"
    - name: "storage_location"
      expr: storage_location
      comment: "Storage location for physical security analysis"
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total controlled substance transactions - volume baseline"
    - name: "total_quantity_transacted"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of controlled substances transacted"
    - name: "discrepancy_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN discrepancy_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions with discrepancies - primary diversion detection KPI"
    - name: "override_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN override_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions using overrides - security compliance metric"
    - name: "pdmp_reporting_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pdmp_reported_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "PDMP reporting compliance rate - state regulatory compliance KPI"
    - name: "avg_running_balance"
      expr: AVG(CAST(running_balance AS DOUBLE))
      comment: "Average running balance of controlled substances - perpetual inventory health"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`pharmacy_rx_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy claims financial metrics tracking reimbursement, rejection rates, and payer performance for revenue cycle optimization."
  source: "`healthcare_ecm_v1`.`pharmacy`.`rx_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Claim adjudication status for revenue cycle pipeline analysis"
    - name: "transaction_response_status"
      expr: transaction_response_status
      comment: "Real-time transaction response for rejection analysis"
    - name: "daw_code"
      expr: daw_code
      comment: "Dispense as written code for generic utilization analysis"
    - name: "compound_indicator"
      expr: compound_indicator
      comment: "Whether claim is for a compound medication"
    - name: "cob_indicator"
      expr: cob_indicator
      comment: "Coordination of benefits flag for multi-payer analysis"
    - name: "claim_month"
      expr: DATE_TRUNC('month', claim_date)
      comment: "Claim month for financial trend analysis"
    - name: "adjudication_month"
      expr: DATE_TRUNC('month', adjudication_date)
      comment: "Adjudication month for cash flow timing analysis"
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total pharmacy claims submitted - volume metric"
    - name: "total_plan_paid"
      expr: SUM(CAST(plan_paid_amount AS DOUBLE))
      comment: "Total amount paid by health plans - primary revenue metric"
    - name: "total_patient_copay"
      expr: SUM(CAST(patient_copay AS DOUBLE))
      comment: "Total patient copay collected - patient revenue component"
    - name: "total_ingredient_cost"
      expr: SUM(CAST(ingredient_cost AS DOUBLE))
      comment: "Total ingredient cost - COGS for pharmacy margin analysis"
    - name: "total_dispensing_fee"
      expr: SUM(CAST(dispensing_fee AS DOUBLE))
      comment: "Total dispensing fees earned - professional service revenue"
    - name: "total_amount_paid"
      expr: SUM(CAST(total_amount_paid AS DOUBLE))
      comment: "Total reimbursement received across all payers"
    - name: "avg_reimbursement_per_claim"
      expr: AVG(CAST(total_amount_paid AS DOUBLE))
      comment: "Average reimbursement per claim - rate adequacy benchmark"
    - name: "rejection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reject_code IS NOT NULL AND reject_code != '' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Claim rejection rate - revenue cycle efficiency and clean claim rate inverse"
    - name: "avg_quantity_dispensed"
      expr: AVG(CAST(quantity_dispensed AS DOUBLE))
      comment: "Average quantity per claim - utilization pattern indicator"
    - name: "total_sales_tax"
      expr: SUM(CAST(sales_tax AS DOUBLE))
      comment: "Total sales tax collected - tax compliance metric"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`pharmacy_medication_therapy_mgmt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medication Therapy Management program metrics tracking clinical interventions, cost avoidance, and quality measure compliance for value-based pharmacy services."
  source: "`healthcare_ecm_v1`.`pharmacy`.`medication_therapy_mgmt`"
  dimensions:
    - name: "facility_service_type"
      expr: facility_service_type
      comment: "Type of MTM service provided for program analysis"
    - name: "intervention_type"
      expr: intervention_type
      comment: "Category of pharmacist intervention for clinical impact analysis"
    - name: "outcome_status"
      expr: outcome_status
      comment: "Outcome of the MTM encounter for effectiveness measurement"
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status for revenue capture analysis"
    - name: "drug_therapy_problem_identified"
      expr: drug_therapy_problem_identified
      comment: "Whether a drug therapy problem was found - clinical value indicator"
    - name: "quality_measure_reported"
      expr: quality_measure_reported
      comment: "Whether encounter was reported to quality program"
    - name: "cms_part_d_compliant"
      expr: cms_part_d_compliant
      comment: "CMS Part D compliance flag for Medicare program adherence"
    - name: "service_month"
      expr: DATE_TRUNC('month', facility_service_date)
      comment: "Service month for program trend analysis"
  measures:
    - name: "total_mtm_encounters"
      expr: COUNT(1)
      comment: "Total MTM encounters - program volume and reach metric"
    - name: "total_cost_avoidance"
      expr: SUM(CAST(estimated_cost_avoidance_amount AS DOUBLE))
      comment: "Total estimated cost avoidance from MTM interventions - program ROI metric"
    - name: "avg_cost_avoidance_per_encounter"
      expr: AVG(CAST(estimated_cost_avoidance_amount AS DOUBLE))
      comment: "Average cost avoidance per MTM encounter - efficiency benchmark"
    - name: "drug_therapy_problem_identification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN drug_therapy_problem_identified = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of encounters identifying drug therapy problems - clinical value demonstration"
    - name: "quality_measure_reporting_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN quality_measure_reported = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of encounters reported to quality programs - VBC compliance"
    - name: "cms_part_d_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cms_part_d_compliant = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "CMS Part D program compliance rate - Medicare regulatory adherence"
    - name: "follow_up_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_required = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of encounters requiring follow-up - care continuity indicator"
    - name: "unique_patients_served"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct patients receiving MTM services - program reach"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`pharmacy_compounding_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sterile and non-sterile compounding metrics tracking production volume, quality testing compliance, USP chapter adherence, and hazardous drug handling for pharmacy safety and regulatory compliance."
  source: "`healthcare_ecm_v1`.`pharmacy`.`compounding_record`"
  dimensions:
    - name: "compounding_type"
      expr: compounding_type
      comment: "Sterile vs non-sterile compounding classification"
    - name: "compounding_status"
      expr: compounding_status
      comment: "Current status of the compounding batch"
    - name: "usp_chapter_compliance"
      expr: usp_chapter_compliance
      comment: "USP 795/797/800 compliance status - regulatory adherence indicator"
    - name: "hazardous_drug_flag"
      expr: hazardous_drug_flag
      comment: "Whether compound contains hazardous drugs - USP 800 applicability"
    - name: "regulatory_compliance_status"
      expr: regulatory_compliance_status
      comment: "Overall regulatory compliance status of the batch"
    - name: "preparation_month"
      expr: DATE_TRUNC('month', preparation_date)
      comment: "Preparation month for production trend analysis"
  measures:
    - name: "total_compounds_prepared"
      expr: COUNT(1)
      comment: "Total compounding batches prepared - production volume metric"
    - name: "total_volume_produced_ml"
      expr: SUM(CAST(total_volume_ml AS DOUBLE))
      comment: "Total volume produced in milliliters - production output metric"
    - name: "sterility_testing_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sterility_test_performed = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches with sterility testing - USP 797 compliance KPI"
    - name: "endotoxin_testing_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN endotoxin_test_performed = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches with endotoxin testing - patient safety compliance"
    - name: "hazardous_drug_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN hazardous_drug_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compounds involving hazardous drugs - USP 800 workload indicator"
    - name: "avg_batch_size"
      expr: AVG(CAST(batch_size AS DOUBLE))
      comment: "Average batch size - production efficiency metric"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`pharmacy_medication_pa_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization request metrics tracking approval rates, turnaround times, appeal outcomes, and financial impact for patient access and administrative burden analysis."
  source: "`healthcare_ecm_v1`.`pharmacy`.`medication_pa_request`"
  dimensions:
    - name: "pa_status"
      expr: pa_status
      comment: "Current PA request status for pipeline analysis"
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency classification for prioritization analysis"
    - name: "formulary_status"
      expr: formulary_status
      comment: "Formulary status of requested drug for coverage pattern analysis"
    - name: "specialty_medication_flag"
      expr: specialty_medication_flag
      comment: "Whether request is for specialty medication - high-cost drug indicator"
    - name: "step_therapy_required_flag"
      expr: step_therapy_required_flag
      comment: "Whether step therapy is required - treatment access barrier"
    - name: "claim_appeal_submitted_flag"
      expr: claim_appeal_submitted_flag
      comment: "Whether an appeal was filed - denial challenge indicator"
    - name: "request_month"
      expr: DATE_TRUNC('month', pa_request_date)
      comment: "Request month for volume trend analysis"
  measures:
    - name: "total_pa_requests"
      expr: COUNT(1)
      comment: "Total prior authorization requests - administrative burden volume"
    - name: "total_estimated_medication_cost"
      expr: SUM(CAST(estimated_medication_cost AS DOUBLE))
      comment: "Total estimated cost of medications requiring PA - financial exposure metric"
    - name: "total_approved_quantity"
      expr: SUM(CAST(approved_quantity AS DOUBLE))
      comment: "Total quantity approved through PA process"
    - name: "specialty_medication_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN specialty_medication_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PA requests for specialty medications - high-cost drug burden"
    - name: "appeal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN claim_appeal_submitted_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PA requests that resulted in appeals - denial challenge rate"
    - name: "step_therapy_burden_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN step_therapy_required_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requests requiring step therapy - treatment access barrier metric"
    - name: "avg_estimated_cost_per_request"
      expr: AVG(CAST(estimated_medication_cost AS DOUBLE))
      comment: "Average estimated medication cost per PA request - financial impact per case"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`pharmacy_drug_recall`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug recall management metrics tracking recall volume, patient impact, financial exposure, and notification compliance for supply chain risk management."
  source: "`healthcare_ecm_v1`.`pharmacy`.`drug_recall`"
  dimensions:
    - name: "recall_status"
      expr: recall_status
      comment: "Current recall status for pipeline management"
    - name: "recall_classification"
      expr: recall_classification
      comment: "FDA recall classification (Class I/II/III) for severity analysis"
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall for categorization"
    - name: "recall_scope"
      expr: recall_scope
      comment: "Scope of the recall for impact assessment"
    - name: "patient_notification_status"
      expr: patient_notification_status
      comment: "Patient notification completion status - compliance tracking"
    - name: "disposition_method"
      expr: disposition_method
      comment: "How recalled product was disposed - regulatory compliance"
    - name: "recall_initiation_month"
      expr: DATE_TRUNC('month', recall_initiation_date)
      comment: "Month recall was initiated for trend analysis"
  measures:
    - name: "total_recalls"
      expr: COUNT(1)
      comment: "Total drug recalls managed - supply chain disruption volume"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of recalls - cost of quality metric"
    - name: "total_quantity_quarantined"
      expr: SUM(CAST(quantity_quarantined AS DOUBLE))
      comment: "Total units quarantined - supply disruption magnitude"
    - name: "total_quantity_returned"
      expr: SUM(CAST(quantity_returned AS DOUBLE))
      comment: "Total units returned to manufacturer - recovery metric"
    - name: "total_quantity_dispensed_affected"
      expr: SUM(CAST(quantity_dispensed AS DOUBLE))
      comment: "Total quantity already dispensed from recalled lots - patient exposure metric"
    - name: "adverse_event_reported_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN adverse_event_reported = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recalls with associated adverse events - safety signal indicator"
    - name: "avg_financial_impact_per_recall"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per recall event - cost planning metric"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`pharmacy_rems_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "REMS (Risk Evaluation and Mitigation Strategy) program compliance metrics for FDA-mandated drug safety programs, tracking enrollment, certification, and monitoring adherence."
  source: "`healthcare_ecm_v1`.`pharmacy`.`rems_compliance`"
  dimensions:
    - name: "overall_compliance_status"
      expr: overall_compliance_status
      comment: "Overall REMS compliance status for program health assessment"
    - name: "program_name"
      expr: program_name
      comment: "Specific REMS program name for program-level analysis"
    - name: "program_type"
      expr: program_type
      comment: "Type of REMS program for categorization"
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category classification for severity-based monitoring"
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Patient enrollment status in REMS program"
    - name: "prescriber_certification_status"
      expr: prescriber_certification_status
      comment: "Prescriber certification status for provider compliance"
    - name: "pharmacy_certification_status"
      expr: pharmacy_certification_status
      comment: "Pharmacy certification status for dispensing compliance"
  measures:
    - name: "total_rems_enrollments"
      expr: COUNT(1)
      comment: "Total REMS program enrollments managed - program scope metric"
    - name: "lab_monitoring_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN lab_monitoring_status = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN lab_monitoring_required = true THEN 1 ELSE 0 END), 0), 2)
      comment: "Lab monitoring compliance rate among those requiring it - patient safety KPI"
    - name: "fda_reporting_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN fda_reporting_status = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN fda_reporting_required = true THEN 1 ELSE 0 END), 0), 2)
      comment: "FDA reporting compliance rate - regulatory adherence KPI"
    - name: "patient_enrollment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN patient_enrollment_status = 'Enrolled' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN patient_enrollment_required = true THEN 1 ELSE 0 END), 0), 2)
      comment: "Patient enrollment completion rate for required REMS programs"
    - name: "unique_patients_in_rems"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients enrolled in REMS programs - program reach"
    - name: "unique_programs_managed"
      expr: COUNT(DISTINCT program_name)
      comment: "Distinct REMS programs being managed - operational complexity indicator"
$$;