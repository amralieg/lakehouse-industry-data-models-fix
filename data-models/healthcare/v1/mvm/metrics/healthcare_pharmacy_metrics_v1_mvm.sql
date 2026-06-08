-- Metric views for domain: pharmacy | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 18:58:55

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`pharmacy_dispense_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core dispensing operations metrics tracking medication fulfillment volume, financial performance, patient cost burden, substitution behavior, and counseling compliance. Primary KPI surface for pharmacy operations leadership."
  source: "`healthcare_ecm`.`pharmacy`.`dispense_event`"
  dimensions:
    - name: "dispense_status"
      expr: dispense_status
      comment: "Current status of the dispense event (e.g., Dispensed, Cancelled, Returned) — used to filter active vs. voided dispenses."
    - name: "dispense_type"
      expr: dispense_type
      comment: "Type of dispense (e.g., New, Refill, Emergency Supply) — key dimension for fill pattern analysis."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA controlled substance schedule (I–V) — critical for regulatory reporting and controlled substance volume monitoring."
    - name: "ndc_code"
      expr: ndc_code
      comment: "National Drug Code identifying the dispensed medication — enables drug-level dispensing analysis."
    - name: "dispense_date"
      expr: CAST(dispense_timestamp AS DATE)
      comment: "Calendar date of dispense derived from timestamp — primary time dimension for trend analysis."
    - name: "dispense_month"
      expr: DATE_TRUNC('MONTH', dispense_timestamp)
      comment: "Month-level time bucket for dispense volume and financial trending."
    - name: "substitution_made_flag"
      expr: substitution_made_flag
      comment: "Indicates whether a generic or therapeutic substitution was made — drives substitution rate analysis."
    - name: "substitution_reason"
      expr: substitution_reason
      comment: "Reason for substitution (e.g., formulary, cost, shortage) — supports root cause analysis of substitution patterns."
    - name: "patient_counseling_completed_flag"
      expr: patient_counseling_completed_flag
      comment: "Whether patient counseling was completed at point of dispense — regulatory and quality compliance dimension."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of financial amounts — required for multi-currency financial reporting."
    - name: "source_system"
      expr: source_system
      comment: "Source pharmacy system (e.g., Epic Willow, Cerner PharmNet) — used for data lineage and system-level benchmarking."
    - name: "fill_number"
      expr: fill_number
      comment: "Fill sequence number (0 = new, 1+ = refill) — supports refill adherence and fill pattern analysis."
  measures:
    - name: "total_dispense_events"
      expr: COUNT(1)
      comment: "Total number of dispense events — baseline volume KPI for pharmacy throughput and capacity planning."
    - name: "total_dispensed_quantity"
      expr: SUM(CAST(dispensed_quantity AS DOUBLE))
      comment: "Total units dispensed across all events — measures medication volume throughput and demand."
    - name: "total_medication_cost"
      expr: SUM(CAST(medication_cost_amount AS DOUBLE))
      comment: "Total acquisition cost of medications dispensed — primary cost driver for pharmacy budget management."
    - name: "total_patient_pay_amount"
      expr: SUM(CAST(patient_pay_amount AS DOUBLE))
      comment: "Total out-of-pocket cost borne by patients — key metric for patient financial burden and access equity analysis."
    - name: "total_insurance_paid_amount"
      expr: SUM(CAST(insurance_paid_amount AS DOUBLE))
      comment: "Total amount reimbursed by insurance — tracks payer mix contribution and reimbursement performance."
    - name: "total_dispensing_fee_revenue"
      expr: SUM(CAST(dispensing_fee_amount AS DOUBLE))
      comment: "Total dispensing fee revenue collected — direct pharmacy revenue line item for financial performance tracking."
    - name: "avg_medication_cost_per_dispense"
      expr: AVG(CAST(medication_cost_amount AS DOUBLE))
      comment: "Average medication cost per dispense event — benchmarks drug cost efficiency and identifies high-cost outliers."
    - name: "avg_patient_pay_per_dispense"
      expr: AVG(CAST(patient_pay_amount AS DOUBLE))
      comment: "Average patient out-of-pocket cost per dispense — monitors patient affordability trends over time."
    - name: "substitution_count"
      expr: SUM(CASE WHEN substitution_made_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of dispenses where a substitution was made — numerator for substitution rate calculation."
    - name: "counseling_completed_count"
      expr: SUM(CASE WHEN patient_counseling_completed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of dispenses where patient counseling was completed — numerator for counseling compliance rate."
    - name: "counseling_declined_count"
      expr: SUM(CASE WHEN patient_counseling_declined_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of dispenses where patient declined counseling — tracks patient engagement and refusal patterns."
    - name: "controlled_substance_dispense_count"
      expr: SUM(CASE WHEN dea_schedule IS NOT NULL AND dea_schedule != '' THEN 1 ELSE 0 END)
      comment: "Count of controlled substance dispenses — critical for DEA compliance monitoring and diversion risk management."
    - name: "unique_patients_dispensed"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Count of distinct patients who received a dispense — measures patient reach and population served."
    - name: "unique_drugs_dispensed"
      expr: COUNT(DISTINCT ndc_drug_id)
      comment: "Count of distinct drug NDCs dispensed — measures formulary utilization breadth."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`pharmacy_prescription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prescription lifecycle and prescribing pattern metrics covering volume, status, prior authorization burden, electronic prescribing adoption, and controlled substance prescribing. Supports pharmacy operations, compliance, and clinical governance."
  source: "`healthcare_ecm`.`pharmacy`.`prescription`"
  dimensions:
    - name: "prescription_status"
      expr: prescription_status
      comment: "Current status of the prescription (e.g., Active, Filled, Cancelled, Expired) — primary lifecycle dimension."
    - name: "prescription_type"
      expr: prescription_type
      comment: "Type of prescription (e.g., New, Renewal, Emergency) — supports prescribing pattern analysis."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA controlled substance schedule — critical for controlled substance prescribing compliance monitoring."
    - name: "dosage_form"
      expr: dosage_form
      comment: "Dosage form of the prescribed medication (e.g., tablet, capsule, injection) — supports formulary and clinical analysis."
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration (e.g., oral, IV, topical) — clinical dimension for prescribing pattern analysis."
    - name: "prescription_month"
      expr: DATE_TRUNC('MONTH', prescription_timestamp)
      comment: "Month-level time bucket for prescription volume trending."
    - name: "prescription_date"
      expr: prescription_date
      comment: "Date the prescription was written — primary time dimension for prescribing trend analysis."
    - name: "epcs_flag"
      expr: epcs_flag
      comment: "Electronic Prescribing for Controlled Substances flag — tracks EPCS adoption compliance."
    - name: "prior_authorization_required_flag"
      expr: prior_authorization_required_flag
      comment: "Whether prior authorization is required — key dimension for PA burden analysis."
    - name: "substitution_allowed_flag"
      expr: substitution_allowed_flag
      comment: "Whether the prescriber allows generic substitution — impacts formulary compliance and cost management."
    - name: "erx_transmission_status"
      expr: erx_transmission_status
      comment: "Electronic Rx transmission status (e.g., Sent, Failed, Pending) — monitors e-prescribing workflow reliability."
  measures:
    - name: "total_prescriptions"
      expr: COUNT(1)
      comment: "Total number of prescriptions written — baseline volume KPI for prescribing activity and demand forecasting."
    - name: "total_quantity_prescribed"
      expr: SUM(CAST(quantity_prescribed AS DOUBLE))
      comment: "Total medication quantity prescribed — measures prescribing volume for demand planning and drug utilization review."
    - name: "avg_quantity_prescribed"
      expr: AVG(CAST(quantity_prescribed AS DOUBLE))
      comment: "Average quantity prescribed per prescription — benchmarks prescribing patterns against clinical guidelines."
    - name: "prior_auth_required_count"
      expr: SUM(CASE WHEN prior_authorization_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of prescriptions requiring prior authorization — measures PA administrative burden on prescribers and patients."
    - name: "epcs_prescription_count"
      expr: SUM(CASE WHEN epcs_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of controlled substance prescriptions transmitted electronically via EPCS — tracks regulatory compliance adoption."
    - name: "controlled_substance_prescription_count"
      expr: SUM(CASE WHEN dea_schedule IS NOT NULL AND dea_schedule != '' THEN 1 ELSE 0 END)
      comment: "Count of controlled substance prescriptions — critical for DEA compliance and opioid stewardship programs."
    - name: "substitution_allowed_count"
      expr: SUM(CASE WHEN substitution_allowed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of prescriptions where generic substitution is permitted — measures formulary optimization opportunity."
    - name: "erx_failed_count"
      expr: SUM(CASE WHEN erx_transmission_status = 'Failed' THEN 1 ELSE 0 END)
      comment: "Count of e-prescriptions that failed transmission — operational quality metric for e-prescribing system reliability."
    - name: "unique_prescribers"
      expr: COUNT(DISTINCT prescription_prescriber_clinician_id)
      comment: "Count of distinct prescribers — measures prescriber network breadth and identifies high-volume prescribers."
    - name: "unique_patients_prescribed"
      expr: COUNT(DISTINCT prescription_patient_mpi_record_id)
      comment: "Count of distinct patients with prescriptions — measures patient population reach for medication therapy."
    - name: "unique_drugs_prescribed"
      expr: COUNT(DISTINCT ndc_drug_id)
      comment: "Count of distinct drug NDCs prescribed — measures formulary utilization and prescribing diversity."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`pharmacy_adverse_drug_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient safety and pharmacovigilance metrics tracking adverse drug event volume, severity distribution, regulatory reporting compliance, preventability, and root cause analysis completion. Essential for patient safety governance and regulatory obligations."
  source: "`healthcare_ecm`.`pharmacy`.`adverse_drug_event`"
  dimensions:
    - name: "adverse_drug_event_status"
      expr: adverse_drug_event_status
      comment: "Current status of the ADE report (e.g., Open, Under Review, Closed) — lifecycle dimension for case management."
    - name: "event_type"
      expr: event_type
      comment: "Type of adverse drug event (e.g., Allergic Reaction, Medication Error, Side Effect) — primary clinical classification."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the adverse event (e.g., Mild, Moderate, Severe, Life-Threatening) — critical patient safety dimension."
    - name: "harm_category"
      expr: harm_category
      comment: "NCC MERP harm category (A–I) — standardized harm classification for benchmarking and regulatory reporting."
    - name: "outcome"
      expr: outcome
      comment: "Patient outcome following the ADE (e.g., Recovered, Hospitalized, Death) — key safety and liability dimension."
    - name: "preventability_assessment"
      expr: preventability_assessment
      comment: "Assessment of whether the event was preventable — drives quality improvement and error reduction initiatives."
    - name: "detection_method"
      expr: detection_method
      comment: "How the ADE was detected (e.g., Clinical Review, Patient Report, Lab Result) — informs surveillance program effectiveness."
    - name: "reporter_role"
      expr: reporter_role
      comment: "Role of the person who reported the ADE (e.g., Pharmacist, Nurse, Physician) — supports reporting culture analysis."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month-level time bucket for ADE trend analysis and safety surveillance."
    - name: "reported_to_fda"
      expr: reported_to_fda
      comment: "Whether the event was reported to the FDA — regulatory compliance dimension for MedWatch reporting obligations."
    - name: "reported_to_ismp"
      expr: reported_to_ismp
      comment: "Whether the event was reported to ISMP — tracks voluntary safety reporting program participation."
    - name: "causative_drug_ndc"
      expr: causative_drug_ndc
      comment: "NDC of the drug identified as causative — enables drug-level safety signal detection."
  measures:
    - name: "total_adverse_drug_events"
      expr: COUNT(1)
      comment: "Total number of adverse drug events reported — primary patient safety volume KPI for safety governance dashboards."
    - name: "severe_event_count"
      expr: SUM(CASE WHEN severity_level IN ('Severe', 'Life-Threatening', 'Fatal') THEN 1 ELSE 0 END)
      comment: "Count of high-severity ADEs — critical safety KPI triggering immediate clinical and executive review."
    - name: "preventable_event_count"
      expr: SUM(CASE WHEN preventability_assessment IN ('Preventable', 'Probably Preventable') THEN 1 ELSE 0 END)
      comment: "Count of ADEs assessed as preventable — measures quality improvement opportunity and system failure rate."
    - name: "intervention_required_count"
      expr: SUM(CASE WHEN intervention_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ADEs requiring clinical intervention — measures patient safety impact and resource utilization from drug events."
    - name: "fda_reported_count"
      expr: SUM(CASE WHEN reported_to_fda = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ADEs reported to the FDA — tracks MedWatch regulatory reporting compliance."
    - name: "ismp_reported_count"
      expr: SUM(CASE WHEN reported_to_ismp = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ADEs reported to ISMP — tracks voluntary safety reporting program engagement."
    - name: "root_cause_analysis_completed_count"
      expr: SUM(CASE WHEN root_cause_analysis_performed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ADEs where root cause analysis was completed — measures safety investigation thoroughness and compliance."
    - name: "unique_patients_affected"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Count of distinct patients who experienced an ADE — measures patient safety population impact."
    - name: "unique_causative_drugs"
      expr: COUNT(DISTINCT causative_drug_master_id)
      comment: "Count of distinct drugs identified as causative — measures breadth of drug safety signals requiring monitoring."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`pharmacy_mar_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medication administration record metrics tracking administration compliance, waste, infusion performance, and STAT order responsiveness. Core KPI surface for inpatient medication safety and nursing/pharmacy operational quality."
  source: "`healthcare_ecm`.`pharmacy`.`mar_record`"
  dimensions:
    - name: "administration_status"
      expr: administration_status
      comment: "Status of the medication administration (e.g., Given, Held, Missed, Refused) — primary compliance dimension."
    - name: "administration_status_reason"
      expr: administration_status_reason
      comment: "Reason for the administration status (e.g., Patient Refused, Drug Unavailable) — supports root cause analysis of missed doses."
    - name: "route"
      expr: route
      comment: "Route of administration (e.g., IV, PO, IM) — clinical dimension for administration pattern analysis."
    - name: "administration_method"
      expr: administration_method
      comment: "Method of administration (e.g., Infusion, Bolus, Topical) — supports clinical workflow and safety analysis."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA schedule of administered medication — required for controlled substance administration monitoring."
    - name: "is_stat_order"
      expr: is_stat_order
      comment: "Whether the administration was for a STAT (urgent) order — key dimension for time-critical medication performance."
    - name: "is_first_dose"
      expr: is_first_dose
      comment: "Whether this was the first dose administered — supports first-dose timeliness analysis."
    - name: "administration_month"
      expr: DATE_TRUNC('MONTH', actual_administration_timestamp)
      comment: "Month-level time bucket for administration volume and compliance trending."
    - name: "medication_ndc"
      expr: medication_ndc
      comment: "NDC of the administered medication — enables drug-level administration analysis."
    - name: "dose_unit"
      expr: dose_unit
      comment: "Unit of measure for the dose given (e.g., mg, mL, units) — supports dose accuracy analysis."
  measures:
    - name: "total_administration_records"
      expr: COUNT(1)
      comment: "Total MAR records — baseline volume KPI for medication administration throughput and workload analysis."
    - name: "administered_count"
      expr: SUM(CASE WHEN administration_status = 'Given' THEN 1 ELSE 0 END)
      comment: "Count of medications successfully administered — numerator for medication administration compliance rate."
    - name: "missed_dose_count"
      expr: SUM(CASE WHEN administration_status IN ('Missed', 'Not Given') THEN 1 ELSE 0 END)
      comment: "Count of missed or not-given doses — critical patient safety KPI for medication adherence and care quality."
    - name: "refused_dose_count"
      expr: SUM(CASE WHEN administration_status = 'Refused' THEN 1 ELSE 0 END)
      comment: "Count of doses refused by patients — informs patient engagement and medication therapy management."
    - name: "stat_order_count"
      expr: SUM(CASE WHEN is_stat_order = TRUE THEN 1 ELSE 0 END)
      comment: "Count of STAT medication administrations — measures urgent medication demand and pharmacy responsiveness."
    - name: "total_dose_given"
      expr: SUM(CAST(dose_given AS DOUBLE))
      comment: "Total dose quantity administered — measures medication consumption volume for drug utilization review."
    - name: "total_waste_amount"
      expr: SUM(CAST(waste_amount AS DOUBLE))
      comment: "Total medication waste quantity — key metric for controlled substance diversion monitoring and cost reduction."
    - name: "avg_infusion_rate"
      expr: AVG(CAST(infusion_rate AS DOUBLE))
      comment: "Average infusion rate across IV administrations — supports clinical protocol compliance and safety monitoring."
    - name: "controlled_substance_admin_count"
      expr: SUM(CASE WHEN dea_schedule IS NOT NULL AND dea_schedule != '' THEN 1 ELSE 0 END)
      comment: "Count of controlled substance administrations — essential for DEA compliance and diversion prevention programs."
    - name: "unique_patients_administered"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Count of distinct patients who received medication administrations — measures inpatient medication therapy reach."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`pharmacy_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy inventory management metrics tracking stock levels, financial value, shortage risk, and cycle count accuracy. Supports supply chain, procurement, and pharmacy operations leadership in maintaining optimal drug availability."
  source: "`healthcare_ecm`.`pharmacy`.`inventory`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current inventory status (e.g., Active, Quarantined, Recalled, Expired) — primary stock health dimension."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA controlled substance schedule — required for controlled substance inventory compliance reporting."
    - name: "shortage_indicator"
      expr: shortage_indicator
      comment: "Whether the drug is currently in shortage — critical supply chain risk dimension for procurement prioritization."
    - name: "high_alert_medication"
      expr: high_alert_medication
      comment: "Whether the medication is classified as high-alert — safety dimension for inventory prioritization and oversight."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for inventory quantities — required for accurate quantity aggregation and comparison."
    - name: "storage_requirements"
      expr: storage_requirements
      comment: "Storage requirements (e.g., Refrigerated, Room Temperature, Frozen) — supports cold chain compliance monitoring."
    - name: "ndc"
      expr: ndc
      comment: "National Drug Code for the inventory item — enables drug-level inventory analysis."
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_timestamp)
      comment: "Month-level snapshot time bucket for inventory trend analysis."
    - name: "source_system"
      expr: source_system
      comment: "Source system for the inventory record — supports data lineage and multi-system inventory reconciliation."
  measures:
    - name: "total_inventory_records"
      expr: COUNT(1)
      comment: "Total inventory line records — baseline count for inventory breadth and SKU coverage analysis."
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total units on hand across all inventory locations — primary stock level KPI for supply adequacy assessment."
    - name: "total_inventory_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total financial value of pharmacy inventory — key asset management KPI for budget and capital allocation decisions."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across inventory items — benchmarks procurement efficiency and identifies cost outliers."
    - name: "total_par_level"
      expr: SUM(CAST(par_level AS DOUBLE))
      comment: "Sum of PAR levels across inventory — baseline for stock adequacy gap analysis against quantity on hand."
    - name: "total_reorder_point_quantity"
      expr: SUM(CAST(reorder_point AS DOUBLE))
      comment: "Sum of reorder point thresholds — supports procurement trigger analysis and supply chain planning."
    - name: "shortage_item_count"
      expr: SUM(CASE WHEN shortage_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of inventory items currently in shortage — critical supply chain risk KPI for executive and clinical leadership."
    - name: "high_alert_item_count"
      expr: SUM(CASE WHEN high_alert_medication = TRUE THEN 1 ELSE 0 END)
      comment: "Count of high-alert medication inventory items — safety oversight KPI for ISMP compliance and risk management."
    - name: "total_cycle_count_variance"
      expr: SUM(CAST(cycle_count_variance AS DOUBLE))
      comment: "Total cycle count variance (physical vs. system quantity) — measures inventory accuracy and diversion risk exposure."
    - name: "avg_daily_usage"
      expr: AVG(CAST(average_daily_usage AS DOUBLE))
      comment: "Average daily usage rate across inventory items — supports days-supply and reorder frequency optimization."
    - name: "unique_drugs_in_inventory"
      expr: COUNT(DISTINCT drug_master_id)
      comment: "Count of distinct drugs in inventory — measures formulary coverage and inventory breadth."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`pharmacy_drug_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug formulary and safety attribute metrics tracking high-alert drug prevalence, REMS requirements, controlled substance classification, and formulary composition. Supports pharmacy and therapeutics committee governance and regulatory compliance."
  source: "`healthcare_ecm`.`pharmacy`.`drug_master`"
  dimensions:
    - name: "active_status"
      expr: active_status
      comment: "Active/inactive status of the drug in the formulary — primary lifecycle dimension for formulary management."
    - name: "drug_class"
      expr: drug_class
      comment: "Pharmacological drug class (e.g., Antibiotic, Opioid, Antihypertensive) — primary clinical classification dimension."
    - name: "therapeutic_category"
      expr: therapeutic_category
      comment: "Therapeutic category of the drug — supports drug utilization review and formulary tier analysis."
    - name: "dosage_form"
      expr: dosage_form
      comment: "Dosage form (e.g., tablet, injection, patch) — clinical dimension for formulary composition analysis."
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration — supports clinical protocol and formulary design analysis."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA controlled substance schedule — regulatory classification dimension for compliance reporting."
    - name: "formulary_status"
      expr: formulary_status
      comment: "Formulary status (e.g., Preferred, Non-Preferred, Non-Formulary) — key dimension for formulary optimization."
    - name: "pregnancy_category"
      expr: pregnancy_category
      comment: "FDA pregnancy risk category — clinical safety dimension for prescribing appropriateness analysis."
    - name: "manufacturer_name"
      expr: manufacturer_name
      comment: "Drug manufacturer name — supports supply chain concentration risk and vendor diversity analysis."
  measures:
    - name: "total_drugs_in_formulary"
      expr: COUNT(1)
      comment: "Total number of drug records in the drug master — baseline formulary size KPI for P&T committee governance."
    - name: "active_drug_count"
      expr: SUM(CASE WHEN active_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of currently active drugs in the formulary — measures formulary breadth for clinical coverage assessment."
    - name: "high_alert_drug_count"
      expr: SUM(CASE WHEN ismp_high_alert_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ISMP high-alert medications in the formulary — safety governance KPI for risk stratification and oversight protocols."
    - name: "rems_required_drug_count"
      expr: SUM(CASE WHEN rems_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of drugs requiring REMS (Risk Evaluation and Mitigation Strategy) — regulatory compliance burden metric for pharmacy operations."
    - name: "controlled_substance_drug_count"
      expr: SUM(CASE WHEN controlled_substance_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of controlled substances in the formulary — DEA compliance and diversion risk management KPI."
    - name: "black_box_warning_drug_count"
      expr: SUM(CASE WHEN black_box_warning_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of drugs with FDA black box warnings — patient safety risk exposure metric for clinical governance."
    - name: "hazardous_drug_count"
      expr: SUM(CASE WHEN hazardous_drug_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of hazardous drugs (NIOSH list) — occupational safety and handling compliance KPI."
    - name: "lasa_drug_count"
      expr: SUM(CASE WHEN lasa_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of Look-Alike/Sound-Alike (LASA) drugs — medication error risk exposure metric for safety program prioritization."
    - name: "refrigeration_required_count"
      expr: SUM(CASE WHEN refrigeration_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of drugs requiring refrigeration — cold chain infrastructure planning and compliance KPI."
    - name: "unique_manufacturers"
      expr: COUNT(DISTINCT manufacturer_name)
      comment: "Count of distinct drug manufacturers — supply chain concentration risk metric for procurement strategy."
$$;