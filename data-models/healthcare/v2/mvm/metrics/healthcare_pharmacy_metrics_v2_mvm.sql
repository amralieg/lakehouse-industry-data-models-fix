-- Metric views for domain: pharmacy | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 16:05:56

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_dispense_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core pharmacy dispensing KPIs tracking volume, cost, patient financial burden, and operational efficiency of medication dispensing events. Used by pharmacy directors and CFOs to monitor drug spend, patient cost-sharing, and fill patterns."
  source: "`vibe_healthcare_v1`.`pharmacy`.`dispense_event`"
  dimensions:
    - name: "dispense_date"
      expr: dispense_date
      comment: "Date the medication was dispensed; used for daily/monthly trend analysis."
    - name: "dispense_month"
      expr: DATE_TRUNC('MONTH', dispense_date)
      comment: "Calendar month of dispense event for monthly trend reporting."
    - name: "dispense_type"
      expr: dispense_type
      comment: "Type of dispense (e.g., new, refill, partial fill); drives fill-mix analysis."
    - name: "dispense_status"
      expr: dispense_status
      comment: "Current status of the dispense event (e.g., dispensed, cancelled, on-hold)."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA controlled substance schedule classification for the dispensed drug."
    - name: "ndc_code"
      expr: ndc_code
      comment: "National Drug Code of the dispensed medication for drug-level analysis."
    - name: "substitution_made_flag"
      expr: substitution_made_flag
      comment: "Indicates whether a generic or therapeutic substitution was made at dispense."
    - name: "patient_counseling_completed_flag"
      expr: patient_counseling_completed_flag
      comment: "Indicates whether patient counseling was completed at time of dispense."
    - name: "fill_number"
      expr: fill_number
      comment: "Fill sequence number (original fill vs. refill number) for adherence analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which financial amounts are denominated."
  measures:
    - name: "total_dispense_events"
      expr: COUNT(1)
      comment: "Total number of dispense events; baseline volume KPI for pharmacy throughput."
    - name: "total_medication_cost"
      expr: SUM(CAST(medication_cost_amount AS DOUBLE))
      comment: "Total drug acquisition cost across all dispense events; key pharmacy spend KPI for formulary and procurement decisions."
    - name: "total_insurance_paid_amount"
      expr: SUM(CAST(insurance_paid_amount AS DOUBLE))
      comment: "Total amount paid by insurance/payer across dispense events; used to evaluate payer mix and reimbursement performance."
    - name: "total_patient_pay_amount"
      expr: SUM(CAST(patient_pay_amount AS DOUBLE))
      comment: "Total out-of-pocket cost borne by patients; critical for patient affordability and access analysis."
    - name: "total_dispensing_fee_revenue"
      expr: SUM(CAST(dispensing_fee_amount AS DOUBLE))
      comment: "Total dispensing fee revenue collected; used to assess pharmacy operational revenue."
    - name: "avg_medication_cost_per_dispense"
      expr: AVG(CAST(medication_cost_amount AS DOUBLE))
      comment: "Average drug cost per dispense event; benchmarks drug spend efficiency and formulary tier management."
    - name: "avg_patient_pay_per_dispense"
      expr: AVG(CAST(patient_pay_amount AS DOUBLE))
      comment: "Average patient out-of-pocket cost per dispense; monitors patient financial burden trends."
    - name: "total_quantity_dispensed"
      expr: SUM(CAST(quantity_dispensed AS DOUBLE))
      comment: "Total quantity of medication units dispensed; used for inventory planning and utilization management."
    - name: "distinct_patients_dispensed"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients who received a dispense; measures pharmacy reach and patient population served."
    - name: "distinct_drugs_dispensed"
      expr: COUNT(DISTINCT ndc_drug_id)
      comment: "Number of unique drug NDCs dispensed; indicates formulary utilization breadth."
    - name: "substitution_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN substitution_made_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dispense events where a generic or therapeutic substitution was made; drives formulary generic substitution strategy and cost savings tracking."
    - name: "patient_counseling_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN patient_counseling_completed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dispenses where patient counseling was completed; regulatory compliance and patient safety KPI."
    - name: "controlled_substance_dispense_count"
      expr: COUNT(CASE WHEN dea_schedule IS NOT NULL AND dea_schedule != '' THEN 1 END)
      comment: "Number of controlled substance dispense events; used for DEA compliance monitoring and controlled substance utilization oversight."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_prescription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prescription lifecycle and prescribing pattern KPIs covering volume, authorization rates, electronic prescribing adoption, and medication adherence indicators. Used by pharmacy leadership, compliance officers, and clinical pharmacists."
  source: "`vibe_healthcare_v1`.`pharmacy`.`prescription`"
  dimensions:
    - name: "prescription_date"
      expr: prescription_date
      comment: "Date the prescription was written; used for prescribing trend analysis."
    - name: "prescription_month"
      expr: DATE_TRUNC('MONTH', prescription_date)
      comment: "Calendar month of prescription for monthly volume and trend reporting."
    - name: "prescription_status"
      expr: prescription_status
      comment: "Current status of the prescription (e.g., active, filled, cancelled, expired)."
    - name: "prescription_type"
      expr: prescription_type
      comment: "Type of prescription (e.g., new, renewal, refill authorization)."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA controlled substance schedule for the prescribed drug."
    - name: "dosage_form"
      expr: dosage_form
      comment: "Dosage form of the prescribed medication (e.g., tablet, capsule, liquid)."
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route by which the medication is administered (e.g., oral, IV, topical)."
    - name: "epcs_flag"
      expr: epcs_flag
      comment: "Indicates whether the prescription was transmitted via Electronic Prescribing for Controlled Substances (EPCS)."
    - name: "prior_authorization_required_flag"
      expr: prior_authorization_required_flag
      comment: "Indicates whether prior authorization was required for this prescription."
    - name: "substitution_allowed_flag"
      expr: substitution_allowed_flag
      comment: "Indicates whether the prescriber authorized generic substitution."
    - name: "erx_transmission_status"
      expr: erx_transmission_status
      comment: "Status of electronic prescription transmission to the pharmacy."
  measures:
    - name: "total_prescriptions"
      expr: COUNT(1)
      comment: "Total number of prescriptions written; baseline prescribing volume KPI."
    - name: "distinct_patients_prescribed"
      expr: COUNT(DISTINCT prescription_mpi_record_id)
      comment: "Number of unique patients with at least one prescription; measures medication therapy reach."
    - name: "distinct_drugs_prescribed"
      expr: COUNT(DISTINCT ndc_drug_id)
      comment: "Number of unique drug NDCs prescribed; indicates prescribing breadth and formulary utilization."
    - name: "total_quantity_prescribed"
      expr: SUM(CAST(quantity_prescribed AS DOUBLE))
      comment: "Total quantity of medication prescribed across all prescriptions; used for demand forecasting and inventory planning."
    - name: "avg_quantity_per_prescription"
      expr: AVG(CAST(quantity_prescribed AS DOUBLE))
      comment: "Average quantity prescribed per prescription; benchmarks prescribing patterns against clinical guidelines."
    - name: "prior_auth_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN prior_authorization_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prescriptions requiring prior authorization; measures administrative burden and formulary friction impacting patient access."
    - name: "epcs_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN epcs_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of controlled substance prescriptions transmitted electronically via EPCS; regulatory compliance and safety KPI."
    - name: "generic_substitution_allowed_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN substitution_allowed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prescriptions where the prescriber authorized generic substitution; drives generic utilization and cost savings strategy."
    - name: "controlled_substance_prescription_count"
      expr: COUNT(CASE WHEN dea_schedule IS NOT NULL AND dea_schedule != '' THEN 1 END)
      comment: "Number of controlled substance prescriptions; used for DEA compliance monitoring and opioid stewardship programs."
    - name: "active_prescription_count"
      expr: COUNT(CASE WHEN prescription_status = 'active' THEN 1 END)
      comment: "Number of currently active prescriptions; used for medication management and refill planning."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_adverse_drug_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient safety and pharmacovigilance KPIs tracking adverse drug event volume, severity distribution, regulatory reporting compliance, and root cause analysis rates. Used by patient safety officers, pharmacy directors, and compliance teams."
  source: "`vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event`"
  dimensions:
    - name: "event_date"
      expr: event_date
      comment: "Date the adverse drug event occurred; used for temporal trend and seasonality analysis."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Calendar month of adverse drug event for monthly safety reporting."
    - name: "event_type"
      expr: event_type
      comment: "Classification of the adverse drug event type (e.g., allergic reaction, overdose, interaction)."
    - name: "severity"
      expr: severity
      comment: "Severity classification of the adverse drug event (e.g., mild, moderate, severe, fatal)."
    - name: "severity_level"
      expr: severity_level
      comment: "Granular severity level for stratified safety analysis and benchmarking."
    - name: "harm_category"
      expr: harm_category
      comment: "NCC MERP or equivalent harm category for standardized adverse event classification."
    - name: "adverse_drug_event_status"
      expr: adverse_drug_event_status
      comment: "Current workflow status of the adverse drug event report (e.g., open, under review, closed)."
    - name: "outcome"
      expr: outcome
      comment: "Clinical outcome of the adverse drug event (e.g., recovered, hospitalized, death)."
    - name: "reported_to_fda"
      expr: reported_to_fda
      comment: "Indicates whether the event was reported to the FDA MedWatch program."
    - name: "reported_to_ismp"
      expr: reported_to_ismp
      comment: "Indicates whether the event was reported to ISMP for national safety learning."
    - name: "intervention_required"
      expr: intervention_required
      comment: "Indicates whether a clinical intervention was required as a result of the adverse event."
    - name: "preventability_assessment"
      expr: preventability_assessment
      comment: "Assessment of whether the adverse drug event was preventable; drives quality improvement initiatives."
    - name: "detection_method"
      expr: detection_method
      comment: "Method by which the adverse drug event was detected (e.g., pharmacist review, patient report, lab alert)."
  measures:
    - name: "total_adverse_drug_events"
      expr: COUNT(1)
      comment: "Total number of adverse drug events reported; primary patient safety volume KPI."
    - name: "distinct_patients_affected"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients who experienced an adverse drug event; measures patient safety exposure breadth."
    - name: "distinct_causative_drugs"
      expr: COUNT(DISTINCT causative_drug_master_id)
      comment: "Number of unique drugs implicated in adverse events; identifies high-risk drug candidates for formulary review."
    - name: "severe_event_count"
      expr: COUNT(CASE WHEN severity IN ('severe', 'Severe', 'SEVERE') THEN 1 END)
      comment: "Number of severe adverse drug events; critical patient safety KPI triggering immediate clinical and executive review."
    - name: "intervention_required_count"
      expr: COUNT(CASE WHEN intervention_required = TRUE THEN 1 END)
      comment: "Number of adverse drug events requiring clinical intervention; measures clinical impact and resource utilization from drug safety failures."
    - name: "fda_reporting_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reported_to_fda = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adverse drug events reported to the FDA; regulatory compliance KPI with direct legal and accreditation implications."
    - name: "root_cause_analysis_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN root_cause_analysis_performed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adverse drug events for which a root cause analysis was completed; quality improvement and accreditation compliance KPI."
    - name: "preventable_event_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN preventability_assessment IN ('preventable', 'Preventable', 'PREVENTABLE') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adverse drug events assessed as preventable; key quality and safety improvement metric driving formulary, process, and training interventions."
    - name: "ismp_reporting_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reported_to_ismp = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adverse drug events reported to ISMP; measures participation in national medication safety learning systems."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_controlled_substance_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Controlled substance accountability and DEA compliance KPIs tracking transaction volumes, discrepancy rates, waste patterns, and PDMP reporting. Used by pharmacy compliance officers, DEA auditors, and pharmacy directors."
  source: "`vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log`"
  dimensions:
    - name: "transaction_timestamp_date"
      expr: DATE_TRUNC('DAY', transaction_timestamp)
      comment: "Date of the controlled substance transaction for daily accountability tracking."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Calendar month of controlled substance transaction for monthly DEA compliance reporting."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of controlled substance transaction (e.g., dispense, waste, return, transfer, receipt)."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA schedule of the controlled substance (Schedule II through V)."
    - name: "department_code"
      expr: department_code
      comment: "Department or cost center where the controlled substance transaction occurred."
    - name: "storage_location"
      expr: storage_location
      comment: "Physical storage location of the controlled substance for inventory accountability."
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Indicates whether a discrepancy was identified in the controlled substance transaction."
    - name: "override_flag"
      expr: override_flag
      comment: "Indicates whether an ADC or system override was used to access the controlled substance."
    - name: "pdmp_reported_flag"
      expr: pdmp_reported_flag
      comment: "Indicates whether the transaction was reported to the state Prescription Drug Monitoring Program."
    - name: "drug_ndc"
      expr: drug_ndc
      comment: "NDC code of the controlled substance for drug-level accountability analysis."
  measures:
    - name: "total_controlled_substance_transactions"
      expr: COUNT(1)
      comment: "Total number of controlled substance log transactions; baseline DEA accountability volume KPI."
    - name: "total_quantity_transacted"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of controlled substances transacted; used for DEA Form 222 reconciliation and inventory accountability."
    - name: "avg_running_balance"
      expr: AVG(CAST(running_balance AS DOUBLE))
      comment: "Average running inventory balance of controlled substances; monitors stock levels and identifies unusual depletion patterns."
    - name: "discrepancy_count"
      expr: COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END)
      comment: "Number of controlled substance transactions with identified discrepancies; critical DEA compliance and diversion detection KPI."
    - name: "discrepancy_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN discrepancy_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of controlled substance transactions with discrepancies; key diversion risk and DEA compliance metric requiring executive attention when elevated."
    - name: "override_transaction_count"
      expr: COUNT(CASE WHEN override_flag = TRUE THEN 1 END)
      comment: "Number of controlled substance transactions accessed via system override; monitors policy compliance and potential diversion risk."
    - name: "override_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN override_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of controlled substance transactions using override access; elevated rates signal workflow or diversion risk requiring investigation."
    - name: "pdmp_reporting_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pdmp_reported_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of controlled substance transactions reported to the state PDMP; mandatory regulatory compliance KPI with state licensing implications."
    - name: "distinct_patients_receiving_controlled_substances"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients receiving controlled substances; used for opioid stewardship and PDMP cross-referencing."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_mar_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medication administration KPIs tracking administration accuracy, timing compliance, waste rates, and high-alert medication safety. Used by nursing leadership, pharmacy directors, and patient safety officers to monitor medication administration quality."
  source: "`vibe_healthcare_v1`.`pharmacy`.`mar_record`"
  dimensions:
    - name: "administration_date"
      expr: DATE_TRUNC('DAY', actual_administration_timestamp)
      comment: "Date of medication administration for daily administration volume and compliance tracking."
    - name: "administration_month"
      expr: DATE_TRUNC('MONTH', actual_administration_timestamp)
      comment: "Calendar month of medication administration for monthly trend reporting."
    - name: "administration_status"
      expr: administration_status
      comment: "Status of the medication administration (e.g., given, held, refused, not available)."
    - name: "administration_method"
      expr: administration_method
      comment: "Method used to administer the medication (e.g., IV push, infusion, oral)."
    - name: "route"
      expr: route
      comment: "Route of medication administration (e.g., IV, PO, IM, SQ)."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA schedule of the administered medication for controlled substance administration tracking."
    - name: "is_stat_order"
      expr: is_stat_order
      comment: "Indicates whether the medication was administered as a STAT (urgent) order."
    - name: "is_first_dose"
      expr: is_first_dose
      comment: "Indicates whether this was the first dose of the medication for the patient."
    - name: "mar_record_status"
      expr: mar_record_status
      comment: "Overall status of the MAR record (e.g., active, completed, discontinued)."
    - name: "administration_site"
      expr: administration_site
      comment: "Anatomical site of medication administration for route-specific safety monitoring."
  measures:
    - name: "total_administration_events"
      expr: COUNT(1)
      comment: "Total number of medication administration events; baseline MAR volume KPI."
    - name: "total_dose_given"
      expr: SUM(CAST(dose_given AS DOUBLE))
      comment: "Total dose quantity administered across all MAR events; used for drug utilization and formulary management."
    - name: "avg_dose_given"
      expr: AVG(CAST(dose_given AS DOUBLE))
      comment: "Average dose administered per MAR event; benchmarks dosing patterns against clinical guidelines."
    - name: "total_waste_amount"
      expr: SUM(CAST(waste_amount AS DOUBLE))
      comment: "Total quantity of medication wasted during administration; drives cost reduction and controlled substance accountability programs."
    - name: "avg_waste_per_administration"
      expr: AVG(CAST(waste_amount AS DOUBLE))
      comment: "Average medication waste per administration event; identifies high-waste drugs or units for targeted intervention."
    - name: "total_infusion_rate"
      expr: SUM(CAST(infusion_rate AS DOUBLE))
      comment: "Sum of infusion rates across IV administration events; used for IV medication utilization analysis."
    - name: "stat_order_administration_count"
      expr: COUNT(CASE WHEN is_stat_order = TRUE THEN 1 END)
      comment: "Number of STAT medication administrations; measures urgent medication demand and pharmacy responsiveness."
    - name: "stat_order_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_stat_order = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of medication administrations that are STAT orders; elevated rates indicate clinical acuity or workflow inefficiency."
    - name: "distinct_patients_administered"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients who received medication administration; measures inpatient medication therapy reach."
    - name: "controlled_substance_administration_count"
      expr: COUNT(CASE WHEN dea_schedule IS NOT NULL AND dea_schedule != '' THEN 1 END)
      comment: "Number of controlled substance administration events; used for DEA compliance and opioid stewardship monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy inventory management KPIs tracking stock levels, valuation, shortage risk, and cycle count accuracy. Used by pharmacy directors, supply chain managers, and CFOs to optimize drug inventory investment and prevent stockouts."
  source: "`vibe_healthcare_v1`.`pharmacy`.`inventory`"
  dimensions:
    - name: "snapshot_date"
      expr: DATE_TRUNC('DAY', snapshot_timestamp)
      comment: "Date of the inventory snapshot for point-in-time stock level analysis."
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_timestamp)
      comment: "Calendar month of inventory snapshot for monthly inventory trend reporting."
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of the inventory record (e.g., active, quarantined, recalled, expired)."
    - name: "formulary_status"
      expr: formulary_status
      comment: "Formulary status of the drug in inventory (e.g., formulary, non-formulary, restricted)."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA schedule classification for controlled substance inventory tracking."
    - name: "shortage_indicator"
      expr: shortage_indicator
      comment: "Indicates whether the drug is currently on shortage; critical supply chain risk flag."
    - name: "high_alert_medication"
      expr: high_alert_medication
      comment: "Indicates whether the drug is classified as a high-alert medication requiring enhanced safety controls."
    - name: "storage_requirements"
      expr: storage_requirements
      comment: "Storage condition requirements (e.g., refrigerated, room temperature, controlled) for inventory management."
    - name: "expiration_date"
      expr: expiration_date
      comment: "Expiration date of the inventory lot; used for expiry management and waste reduction."
  measures:
    - name: "total_inventory_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total dollar value of pharmacy inventory on hand; primary financial KPI for pharmacy asset management and balance sheet reporting."
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity of all medications on hand; used for supply adequacy and days-supply calculations."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across inventory items; benchmarks procurement pricing and identifies cost outliers."
    - name: "total_average_daily_usage"
      expr: SUM(CAST(average_daily_usage AS DOUBLE))
      comment: "Sum of average daily usage across all inventory items; used for demand forecasting and reorder planning."
    - name: "total_cycle_count_variance"
      expr: SUM(CAST(cycle_count_variance AS DOUBLE))
      comment: "Total cycle count variance across inventory; measures inventory accuracy and potential diversion or shrinkage."
    - name: "shortage_drug_count"
      expr: COUNT(CASE WHEN shortage_indicator = TRUE THEN 1 END)
      comment: "Number of drugs currently on shortage; critical supply chain risk KPI requiring executive escalation and procurement action."
    - name: "below_par_level_count"
      expr: COUNT(CASE WHEN quantity_on_hand < par_level THEN 1 END)
      comment: "Number of inventory items where quantity on hand is below the established PAR level; drives reorder decisions and prevents stockouts."
    - name: "below_reorder_point_count"
      expr: COUNT(CASE WHEN quantity_on_hand < reorder_point THEN 1 END)
      comment: "Number of inventory items at or below the reorder point; triggers procurement action to prevent medication unavailability."
    - name: "distinct_drugs_in_inventory"
      expr: COUNT(DISTINCT drug_master_id)
      comment: "Number of unique drugs maintained in inventory; measures formulary breadth and inventory complexity."
    - name: "high_alert_medication_count"
      expr: COUNT(CASE WHEN high_alert_medication = TRUE THEN 1 END)
      comment: "Number of high-alert medication inventory records; used for safety oversight and enhanced storage/handling compliance."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`pharmacy_drug_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug formulary and safety attribute KPIs tracking high-alert drug prevalence, REMS requirements, controlled substance composition, and formulary status. Used by pharmacy and therapeutics committees, clinical pharmacists, and compliance officers."
  source: "`vibe_healthcare_v1`.`pharmacy`.`drug_master`"
  dimensions:
    - name: "drug_class"
      expr: drug_class
      comment: "Pharmacological drug class for therapeutic category analysis."
    - name: "therapeutic_category"
      expr: therapeutic_category
      comment: "Therapeutic category of the drug for formulary management and utilization analysis."
    - name: "formulary_status"
      expr: formulary_status
      comment: "Current formulary status of the drug (e.g., formulary, non-formulary, restricted, preferred)."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA controlled substance schedule classification."
    - name: "dosage_form"
      expr: dosage_form
      comment: "Dosage form of the drug (e.g., tablet, capsule, injection, patch)."
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration for the drug."
    - name: "active_status"
      expr: active_status
      comment: "Active/inactive status of the drug in the master drug catalog."
    - name: "pregnancy_category"
      expr: pregnancy_category
      comment: "FDA pregnancy risk category for the drug; used for clinical decision support and prescribing safety."
    - name: "manufacturer_name"
      expr: manufacturer_name
      comment: "Name of the drug manufacturer for supply chain and procurement analysis."
    - name: "fda_approval_date"
      expr: fda_approval_date
      comment: "Date of FDA approval for the drug; used for formulary lifecycle management."
  measures:
    - name: "total_active_drugs"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Total number of active drugs in the drug master catalog; measures formulary size and scope."
    - name: "high_alert_drug_count"
      expr: COUNT(CASE WHEN ismp_high_alert_flag = TRUE THEN 1 END)
      comment: "Number of ISMP high-alert medications in the formulary; drives enhanced safety protocols and staff education priorities."
    - name: "rems_required_drug_count"
      expr: COUNT(CASE WHEN rems_required_flag = TRUE THEN 1 END)
      comment: "Number of drugs requiring FDA Risk Evaluation and Mitigation Strategy (REMS) programs; measures regulatory compliance burden and patient safety program scope."
    - name: "controlled_substance_drug_count"
      expr: COUNT(CASE WHEN controlled_substance_indicator = TRUE THEN 1 END)
      comment: "Number of controlled substances in the drug master; used for DEA compliance planning and controlled substance program scope."
    - name: "black_box_warning_drug_count"
      expr: COUNT(CASE WHEN black_box_warning_flag = TRUE THEN 1 END)
      comment: "Number of drugs with FDA black box warnings; critical patient safety metric for prescribing oversight and clinical decision support configuration."
    - name: "hazardous_drug_count"
      expr: COUNT(CASE WHEN hazardous_drug_flag = TRUE THEN 1 END)
      comment: "Number of hazardous drugs (NIOSH list) in the formulary; drives occupational safety compliance and handling protocol requirements."
    - name: "lasa_drug_count"
      expr: COUNT(CASE WHEN lasa_indicator = TRUE THEN 1 END)
      comment: "Number of Look-Alike/Sound-Alike (LASA) drugs in the formulary; measures medication error risk exposure requiring tall-man lettering and alert configuration."
    - name: "refrigeration_required_drug_count"
      expr: COUNT(CASE WHEN refrigeration_required_flag = TRUE THEN 1 END)
      comment: "Number of drugs requiring refrigerated storage; used for cold chain infrastructure planning and compliance."
    - name: "high_alert_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN ismp_high_alert_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active formulary drugs classified as ISMP high-alert medications; benchmarks formulary safety risk profile against industry standards."
$$;