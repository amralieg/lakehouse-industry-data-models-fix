-- Metric views for domain: laboratory | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`laboratory_lab_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key laboratory order metrics tracking order volumes, turnaround performance, cancellation rates, and operational efficiency for lab operations management."
  source: "`healthcare_ecm_v1`.`laboratory`.`lab_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the lab order (ordered, collected, in-process, resulted, cancelled)"
    - name: "order_priority"
      expr: order_priority
      comment: "Priority level of the order (routine, stat, urgent, ASAP)"
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of specimen required for the test"
    - name: "is_send_out"
      expr: CAST(is_send_out AS STRING)
      comment: "Whether the order is sent to a reference laboratory"
    - name: "point_of_care_test"
      expr: CAST(point_of_care_test AS STRING)
      comment: "Whether this is a point-of-care test"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_timestamp)
      comment: "Month the order was placed for trend analysis"
    - name: "collection_method"
      expr: collection_method
      comment: "Method used for specimen collection"
    - name: "performing_lab_location"
      expr: performing_lab_location
      comment: "Location of the performing laboratory"
    - name: "fasting_required"
      expr: CAST(fasting_required AS STRING)
      comment: "Whether fasting is required for the test"
    - name: "standing_order"
      expr: CAST(standing_order AS STRING)
      comment: "Whether this is a standing/recurring order"
  measures:
    - name: "total_lab_orders"
      expr: COUNT(1)
      comment: "Total number of laboratory orders placed"
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN order_status = 'cancelled' THEN 1 END)
      comment: "Number of cancelled lab orders - high cancellation rates indicate ordering workflow issues"
    - name: "stat_order_count"
      expr: COUNT(CASE WHEN order_priority = 'stat' THEN 1 END)
      comment: "Number of stat priority orders - monitors emergency lab utilization and staffing needs"
    - name: "send_out_order_count"
      expr: COUNT(CASE WHEN is_send_out = TRUE THEN 1 END)
      comment: "Number of orders sent to reference labs - impacts cost and turnaround time"
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN order_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lab orders that are cancelled - key quality and efficiency indicator"
    - name: "stat_order_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN order_priority = 'stat' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders that are stat priority - overuse indicates workflow or clinical culture issues"
    - name: "send_out_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_send_out = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders sent to reference labs - impacts cost management and service capability planning"
    - name: "distinct_patients_ordered"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct patients with lab orders - measures lab service reach and utilization"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`laboratory_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory test result metrics covering critical value management, result turnaround, amendment rates, and quality indicators essential for patient safety and CLIA compliance."
  source: "`healthcare_ecm_v1`.`laboratory`.`laboratory_test_result`"
  dimensions:
    - name: "result_status"
      expr: result_status
      comment: "Status of the test result (preliminary, final, corrected, amended)"
    - name: "abnormal_flag"
      expr: abnormal_flag
      comment: "Abnormality indicator (normal, low, high, critical low, critical high)"
    - name: "is_critical_value"
      expr: CAST(is_critical_value AS STRING)
      comment: "Whether the result is a critical/panic value requiring immediate notification"
    - name: "is_amended"
      expr: CAST(is_amended AS STRING)
      comment: "Whether the result has been amended after initial release"
    - name: "performing_lab_section"
      expr: performing_lab_section
      comment: "Laboratory section that performed the test (chemistry, hematology, microbiology, etc.)"
    - name: "result_interpretation"
      expr: result_interpretation
      comment: "Clinical interpretation of the result"
    - name: "result_month"
      expr: DATE_TRUNC('MONTH', result_datetime)
      comment: "Month the result was finalized for trend analysis"
    - name: "performing_lab_facility"
      expr: performing_lab_facility
      comment: "Facility that performed the test for multi-site analysis"
  measures:
    - name: "total_test_results"
      expr: COUNT(1)
      comment: "Total number of test results produced"
    - name: "critical_value_count"
      expr: COUNT(CASE WHEN is_critical_value = TRUE THEN 1 END)
      comment: "Number of critical/panic values - requires immediate clinician notification per CLIA/Joint Commission"
    - name: "amended_result_count"
      expr: COUNT(CASE WHEN is_amended = TRUE THEN 1 END)
      comment: "Number of amended results - high amendment rates indicate pre-analytical or analytical quality issues"
    - name: "critical_value_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_critical_value = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of results that are critical values - monitors patient acuity and notification burden"
    - name: "amendment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_amended = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of results amended after release - key quality metric for CLIA compliance"
    - name: "abnormal_result_count"
      expr: COUNT(CASE WHEN abnormal_flag IS NOT NULL AND abnormal_flag != 'normal' THEN 1 END)
      comment: "Number of abnormal results - monitors clinical significance of testing"
    - name: "avg_result_value"
      expr: AVG(CAST(result_value_numeric AS DOUBLE))
      comment: "Average numeric result value - useful for population health trending by test type"
    - name: "distinct_patients_resulted"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct patients with test results - measures lab service utilization"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`laboratory_specimen`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Specimen management metrics tracking collection quality, rejection rates, and pre-analytical performance - critical for laboratory quality assurance and patient safety."
  source: "`healthcare_ecm_v1`.`laboratory`.`specimen`"
  dimensions:
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of specimen collected (blood, urine, tissue, etc.)"
    - name: "specimen_source"
      expr: specimen_source
      comment: "Anatomical source of the specimen"
    - name: "collection_method"
      expr: collection_method
      comment: "Method used for specimen collection (venipuncture, capillary, etc.)"
    - name: "accession_status"
      expr: accession_status
      comment: "Current accession status of the specimen"
    - name: "priority"
      expr: priority
      comment: "Priority level of the specimen (routine, stat, urgent)"
    - name: "container_type"
      expr: container_type
      comment: "Type of collection container used"
    - name: "fasting_status"
      expr: fasting_status
      comment: "Patient fasting status at time of collection"
    - name: "retention_status"
      expr: retention_status
      comment: "Specimen retention/storage status"
    - name: "collection_month"
      expr: DATE_TRUNC('MONTH', collection_datetime)
      comment: "Month of specimen collection for trend analysis"
  measures:
    - name: "total_specimens"
      expr: COUNT(1)
      comment: "Total number of specimens collected"
    - name: "rejected_specimen_count"
      expr: COUNT(CASE WHEN rejection_reason IS NOT NULL THEN 1 END)
      comment: "Number of rejected specimens - key pre-analytical quality indicator"
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rejection_reason IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Specimen rejection rate - primary pre-analytical quality metric; high rates indicate collection training needs"
    - name: "avg_volume_collected_ml"
      expr: AVG(CAST(volume_collected_ml AS DOUBLE))
      comment: "Average specimen volume collected - monitors adequacy of collection"
    - name: "distinct_patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with specimens collected"
    - name: "aliquot_specimen_count"
      expr: COUNT(CASE WHEN parent_specimen_id IS NOT NULL THEN 1 END)
      comment: "Number of aliquoted specimens - indicates workload from specimen splitting"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`laboratory_microbiology_culture`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Microbiology culture metrics for infection control, antimicrobial stewardship, and HAI surveillance - critical for patient safety and public health reporting."
  source: "`healthcare_ecm_v1`.`laboratory`.`microbiology_culture`"
  dimensions:
    - name: "culture_type"
      expr: culture_type
      comment: "Type of culture performed (blood, urine, wound, respiratory, etc.)"
    - name: "culture_status"
      expr: culture_status
      comment: "Current status of the culture (in-progress, final, preliminary)"
    - name: "growth_result"
      expr: growth_result
      comment: "Growth result classification (positive, negative, mixed flora)"
    - name: "mdro_flag"
      expr: CAST(mdro_flag AS STRING)
      comment: "Whether a multi-drug resistant organism was identified"
    - name: "mdro_type"
      expr: mdro_type
      comment: "Type of MDRO identified (MRSA, VRE, CRE, ESBL, etc.)"
    - name: "hai_associated_flag"
      expr: CAST(hai_associated_flag AS STRING)
      comment: "Whether the culture is associated with a healthcare-associated infection"
    - name: "hai_event_type"
      expr: hai_event_type
      comment: "Type of HAI event (CLABSI, CAUTI, SSI, VAP, CDI)"
    - name: "critical_value_flag"
      expr: CAST(critical_value_flag AS STRING)
      comment: "Whether the culture result is a critical value"
    - name: "specimen_source_code"
      expr: specimen_source_code
      comment: "Source of the specimen for the culture"
    - name: "result_month"
      expr: DATE_TRUNC('MONTH', result_datetime)
      comment: "Month of culture result for trend analysis"
  measures:
    - name: "total_cultures"
      expr: COUNT(1)
      comment: "Total number of microbiology cultures performed"
    - name: "positive_culture_count"
      expr: COUNT(CASE WHEN growth_result = 'positive' THEN 1 END)
      comment: "Number of cultures with positive growth - indicates infection burden"
    - name: "positivity_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN growth_result = 'positive' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Culture positivity rate - monitors appropriateness of culture ordering and infection prevalence"
    - name: "mdro_count"
      expr: COUNT(CASE WHEN mdro_flag = TRUE THEN 1 END)
      comment: "Number of multi-drug resistant organism isolates - critical for infection control surveillance"
    - name: "mdro_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mdro_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN growth_result = 'positive' THEN 1 END), 0), 2)
      comment: "MDRO rate among positive cultures - key antimicrobial stewardship metric"
    - name: "hai_associated_count"
      expr: COUNT(CASE WHEN hai_associated_flag = TRUE THEN 1 END)
      comment: "Number of healthcare-associated infections identified - CMS quality reporting requirement"
    - name: "avg_turnaround_time_hours"
      expr: AVG(CAST(turnaround_time_hours AS DOUBLE))
      comment: "Average culture turnaround time in hours - operational efficiency metric"
    - name: "antibiotic_stewardship_flagged_count"
      expr: COUNT(CASE WHEN antibiotic_stewardship_flag = TRUE THEN 1 END)
      comment: "Cultures flagged for antibiotic stewardship review - monitors stewardship program engagement"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`laboratory_blood_bank_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Blood bank inventory and utilization metrics for transfusion services management, waste reduction, and patient safety compliance."
  source: "`healthcare_ecm_v1`.`laboratory`.`blood_bank_unit`"
  dimensions:
    - name: "product_type"
      expr: product_type
      comment: "Type of blood product (RBC, platelets, FFP, cryoprecipitate)"
    - name: "unit_status"
      expr: unit_status
      comment: "Current status of the blood unit (available, reserved, issued, discarded, expired)"
    - name: "abo_blood_group"
      expr: abo_blood_group
      comment: "ABO blood group of the unit"
    - name: "rh_type"
      expr: rh_type
      comment: "Rh type of the unit (positive, negative)"
    - name: "irradiation_status"
      expr: irradiation_status
      comment: "Whether the unit has been irradiated"
    - name: "leukoreduction_status"
      expr: leukoreduction_status
      comment: "Leukoreduction processing status"
    - name: "discard_reason"
      expr: discard_reason
      comment: "Reason for unit discard (expired, contamination, outdated, etc.)"
    - name: "donation_month"
      expr: DATE_TRUNC('MONTH', donation_date)
      comment: "Month of blood donation for supply trend analysis"
  measures:
    - name: "total_units"
      expr: COUNT(1)
      comment: "Total blood bank units in inventory"
    - name: "discarded_unit_count"
      expr: COUNT(CASE WHEN unit_status = 'discarded' THEN 1 END)
      comment: "Number of discarded blood units - waste reduction target"
    - name: "discard_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN unit_status = 'discarded' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Blood product discard/waste rate - key financial and operational metric; AABB benchmark target <5%"
    - name: "issued_unit_count"
      expr: COUNT(CASE WHEN unit_status = 'issued' THEN 1 END)
      comment: "Number of units issued for transfusion"
    - name: "crossmatch_to_transfusion_ratio"
      expr: ROUND(CAST(COUNT(CASE WHEN crossmatch_required_flag = TRUE THEN 1 END) AS DOUBLE) / NULLIF(COUNT(CASE WHEN unit_status = 'issued' THEN 1 END), 0), 2)
      comment: "Crossmatch-to-transfusion ratio - measures blood ordering efficiency; target <2.0"
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charges for blood products - revenue tracking for transfusion services"
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of blood products - cost management for transfusion services"
    - name: "temperature_alarm_count"
      expr: COUNT(CASE WHEN temperature_alarm_flag = TRUE THEN 1 END)
      comment: "Number of temperature alarm events - patient safety and regulatory compliance indicator"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`laboratory_transfusion_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transfusion event metrics tracking reaction rates, safety outcomes, and hemovigilance reporting for patient safety and regulatory compliance."
  source: "`healthcare_ecm_v1`.`laboratory`.`transfusion_event`"
  dimensions:
    - name: "transfusion_status"
      expr: transfusion_status
      comment: "Status of the transfusion (in-progress, completed, stopped, reaction)"
    - name: "transfusion_reaction_occurred"
      expr: CAST(transfusion_reaction_occurred AS STRING)
      comment: "Whether a transfusion reaction occurred"
    - name: "transfusion_reaction_type"
      expr: transfusion_reaction_type
      comment: "Type of transfusion reaction (febrile, allergic, hemolytic, TRALI, TACO)"
    - name: "reaction_severity"
      expr: reaction_severity
      comment: "Severity of the transfusion reaction"
    - name: "crossmatch_type"
      expr: crossmatch_type
      comment: "Type of crossmatch performed (immediate spin, full, electronic)"
    - name: "clinical_indication"
      expr: clinical_indication
      comment: "Clinical indication for the transfusion"
    - name: "hemovigilance_reported"
      expr: CAST(hemovigilance_reported AS STRING)
      comment: "Whether the event was reported to hemovigilance system"
    - name: "transfusion_month"
      expr: DATE_TRUNC('MONTH', transfusion_start_datetime)
      comment: "Month of transfusion for trend analysis"
  measures:
    - name: "total_transfusions"
      expr: COUNT(1)
      comment: "Total number of transfusion events"
    - name: "reaction_count"
      expr: COUNT(CASE WHEN transfusion_reaction_occurred = TRUE THEN 1 END)
      comment: "Number of transfusion reactions - critical patient safety metric"
    - name: "reaction_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN transfusion_reaction_occurred = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Transfusion reaction rate - primary hemovigilance safety metric; benchmark <1%"
    - name: "consent_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_obtained = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of documented consent prior to transfusion - regulatory compliance metric"
    - name: "avg_volume_transfused_ml"
      expr: AVG(CAST(volume_transfused_ml AS DOUBLE))
      comment: "Average volume transfused per event"
    - name: "distinct_patients_transfused"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct patients receiving transfusions - utilization metric"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`laboratory_qc_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality control run metrics for laboratory analytical quality monitoring, CLIA compliance, and proficiency testing performance."
  source: "`healthcare_ecm_v1`.`laboratory`.`qc_run`"
  dimensions:
    - name: "qc_type"
      expr: qc_type
      comment: "Type of QC (internal QC, proficiency testing, linearity, calibration verification)"
    - name: "qc_level"
      expr: qc_level
      comment: "QC material level (low, normal, high)"
    - name: "pass_fail_indicator"
      expr: CAST(pass_fail_indicator AS STRING)
      comment: "Whether the QC run passed or failed"
    - name: "qc_run_status"
      expr: qc_run_status
      comment: "Status of the QC run (completed, reviewed, corrective action required)"
    - name: "westgard_rule_evaluation"
      expr: westgard_rule_evaluation
      comment: "Westgard multi-rule evaluation result for statistical QC"
    - name: "qc_run_month"
      expr: DATE_TRUNC('MONTH', qc_run_timestamp)
      comment: "Month of QC run for trend analysis"
    - name: "test_code"
      expr: test_code
      comment: "Test code for which QC was performed"
  measures:
    - name: "total_qc_runs"
      expr: COUNT(1)
      comment: "Total number of QC runs performed"
    - name: "failed_qc_count"
      expr: COUNT(CASE WHEN pass_fail_indicator = FALSE THEN 1 END)
      comment: "Number of failed QC runs - triggers corrective action and potential patient result review"
    - name: "qc_failure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_indicator = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "QC failure rate - primary analytical quality metric; high rates indicate instrument or reagent issues"
    - name: "avg_observed_result"
      expr: AVG(CAST(observed_result AS DOUBLE))
      comment: "Average observed QC result value for trending"
    - name: "avg_pt_z_score"
      expr: AVG(CAST(pt_z_score AS DOUBLE))
      comment: "Average proficiency testing Z-score - measures analytical accuracy vs peer group; target |Z| < 2.0"
    - name: "corrective_action_count"
      expr: COUNT(CASE WHEN corrective_action_taken IS NOT NULL THEN 1 END)
      comment: "Number of QC runs requiring corrective action - workload and quality indicator"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`laboratory_instrument`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory instrument management metrics for uptime, maintenance compliance, and capital asset utilization."
  source: "`healthcare_ecm_v1`.`laboratory`.`instrument`"
  dimensions:
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type/category of laboratory instrument"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status (active, down, maintenance, decommissioned)"
    - name: "lab_section"
      expr: lab_section
      comment: "Laboratory section where instrument is located"
    - name: "manufacturer"
      expr: manufacturer
      comment: "Instrument manufacturer for vendor performance analysis"
    - name: "lis_connectivity_status"
      expr: lis_connectivity_status
      comment: "LIS interface connectivity status"
    - name: "last_quality_control_result"
      expr: last_quality_control_result
      comment: "Most recent QC result for the instrument"
    - name: "calibration_frequency"
      expr: calibration_frequency
      comment: "Required calibration frequency"
  measures:
    - name: "total_instruments"
      expr: COUNT(1)
      comment: "Total number of laboratory instruments"
    - name: "active_instrument_count"
      expr: COUNT(CASE WHEN operational_status = 'active' THEN 1 END)
      comment: "Number of instruments currently active and operational"
    - name: "instrument_availability_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN operational_status = 'active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Instrument availability rate - operational readiness metric for capacity planning"
    - name: "avg_total_downtime_hours"
      expr: AVG(CAST(total_downtime_hours AS DOUBLE))
      comment: "Average total downtime hours per instrument - reliability and maintenance effectiveness metric"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total capital investment in laboratory instruments"
    - name: "decommissioned_count"
      expr: COUNT(CASE WHEN operational_status = 'decommissioned' THEN 1 END)
      comment: "Number of decommissioned instruments - capital planning indicator"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`laboratory_molecular_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Molecular and genetic testing metrics for precision medicine programs, companion diagnostics, and genomics laboratory operations."
  source: "`healthcare_ecm_v1`.`laboratory`.`molecular_test`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of molecular test (PCR, NGS, FISH, sequencing)"
    - name: "test_category"
      expr: test_category
      comment: "Category of molecular test (oncology, pharmacogenomics, infectious disease, hereditary)"
    - name: "test_status"
      expr: test_status
      comment: "Current status of the molecular test"
    - name: "variant_detected"
      expr: CAST(variant_detected AS STRING)
      comment: "Whether a clinically significant variant was detected"
    - name: "variant_classification"
      expr: variant_classification
      comment: "ACMG variant classification (pathogenic, likely pathogenic, VUS, likely benign, benign)"
    - name: "companion_diagnostic"
      expr: CAST(companion_diagnostic AS STRING)
      comment: "Whether this is a companion diagnostic test for targeted therapy"
    - name: "methodology"
      expr: methodology
      comment: "Testing methodology used"
    - name: "critical_value"
      expr: CAST(critical_value AS STRING)
      comment: "Whether the result is a critical value"
    - name: "result_month"
      expr: DATE_TRUNC('MONTH', result_reported_timestamp)
      comment: "Month result was reported for trend analysis"
  measures:
    - name: "total_molecular_tests"
      expr: COUNT(1)
      comment: "Total number of molecular tests performed"
    - name: "variant_detected_count"
      expr: COUNT(CASE WHEN variant_detected = TRUE THEN 1 END)
      comment: "Number of tests with variants detected - measures diagnostic yield"
    - name: "diagnostic_yield_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN variant_detected = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Diagnostic yield rate - percentage of tests detecting clinically significant variants"
    - name: "companion_diagnostic_count"
      expr: COUNT(CASE WHEN companion_diagnostic = TRUE THEN 1 END)
      comment: "Number of companion diagnostic tests - measures precision medicine program activity"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average sequencing/analytical quality score - monitors analytical performance"
    - name: "avg_coverage_percentage"
      expr: AVG(CAST(coverage_percentage AS DOUBLE))
      comment: "Average coverage percentage for sequencing tests - quality adequacy metric"
    - name: "pathogenic_variant_count"
      expr: COUNT(CASE WHEN variant_classification = 'pathogenic' OR variant_classification = 'likely_pathogenic' THEN 1 END)
      comment: "Number of pathogenic/likely pathogenic variants identified - actionable clinical findings"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`laboratory_lab_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory revenue cycle metrics tracking charge capture, billing performance, and financial operations for lab services."
  source: "`healthcare_ecm_v1`.`laboratory`.`lab_charge`"
  dimensions:
    - name: "charge_entry_method"
      expr: charge_entry_method
      comment: "Method of charge entry (auto, manual, interface)"
    - name: "performing_lab_section"
      expr: performing_lab_section
      comment: "Lab section that performed the test for cost center analysis"
    - name: "point_of_care_indicator"
      expr: CAST(point_of_care_indicator AS STRING)
      comment: "Whether this is a point-of-care charge"
    - name: "reference_lab_indicator"
      expr: CAST(reference_lab_indicator AS STRING)
      comment: "Whether this charge is for reference lab services"
    - name: "charge_month"
      expr: DATE_TRUNC('MONTH', charge_created_timestamp)
      comment: "Month charge was created for revenue trend analysis"
  measures:
    - name: "total_lab_charges"
      expr: COUNT(1)
      comment: "Total number of laboratory charges captured"
    - name: "total_stat_surcharge_amount"
      expr: SUM(CAST(stat_surcharge_amount AS DOUBLE))
      comment: "Total stat surcharge revenue - premium pricing for urgent testing"
    - name: "voided_charge_count"
      expr: COUNT(CASE WHEN charge_voided_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of voided charges - indicates charge capture accuracy issues"
    - name: "void_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN charge_voided_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Charge void rate - revenue integrity metric; high rates indicate workflow or coding issues"
    - name: "reference_lab_charge_count"
      expr: COUNT(CASE WHEN reference_lab_indicator = TRUE THEN 1 END)
      comment: "Number of reference lab charges - cost leakage monitoring for send-out testing"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`laboratory_reagent_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reagent inventory and supply chain metrics for laboratory operations cost management, waste reduction, and regulatory compliance."
  source: "`healthcare_ecm_v1`.`laboratory`.`reagent_lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the reagent lot (active, expired, quarantined, depleted)"
    - name: "qc_validation_status"
      expr: qc_validation_status
      comment: "QC validation status of the lot"
    - name: "hazardous_material_flag"
      expr: CAST(hazardous_material_flag AS STRING)
      comment: "Whether the reagent is classified as hazardous material"
    - name: "storage_temperature_requirement"
      expr: storage_temperature_requirement
      comment: "Required storage temperature for the reagent"
    - name: "test_method_name"
      expr: test_method_name
      comment: "Test method the reagent supports"
  measures:
    - name: "total_reagent_lots"
      expr: COUNT(1)
      comment: "Total number of reagent lots in inventory"
    - name: "expired_lot_count"
      expr: COUNT(CASE WHEN lot_status = 'expired' THEN 1 END)
      comment: "Number of expired reagent lots - waste indicator"
    - name: "quarantined_lot_count"
      expr: COUNT(CASE WHEN lot_status = 'quarantined' THEN 1 END)
      comment: "Number of quarantined lots - quality issue indicator"
    - name: "total_inventory_cost"
      expr: SUM(CAST(total_lot_cost AS DOUBLE))
      comment: "Total cost of reagent inventory - supply chain financial management"
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average reagent cost per unit - procurement efficiency metric"
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total reagent quantity on hand - inventory adequacy metric"
    - name: "waste_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN lot_status = 'expired' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Reagent waste rate from expiration - cost management and ordering optimization metric"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`laboratory_pathology_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pathology report metrics for surgical pathology operations, cancer program reporting, and turnaround time management."
  source: "`healthcare_ecm_v1`.`laboratory`.`pathology_report`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of pathology report (surgical, cytology, autopsy, dermatopathology)"
    - name: "report_status"
      expr: report_status
      comment: "Current status of the report (preliminary, final, amended, addendum)"
    - name: "critical_value_flag"
      expr: CAST(critical_value_flag AS STRING)
      comment: "Whether the report contains a critical value finding"
    - name: "cancer_registry_reportable_flag"
      expr: CAST(cancer_registry_reportable_flag AS STRING)
      comment: "Whether the case is reportable to cancer registry"
    - name: "tumor_board_reviewed_flag"
      expr: CAST(tumor_board_reviewed_flag AS STRING)
      comment: "Whether the case was reviewed at tumor board"
    - name: "margin_status"
      expr: margin_status
      comment: "Surgical margin status (positive, negative, close)"
    - name: "histologic_grade"
      expr: histologic_grade
      comment: "Histologic grade of the specimen"
    - name: "sign_out_month"
      expr: DATE_TRUNC('MONTH', sign_out_timestamp)
      comment: "Month of pathologist sign-out for workload analysis"
  measures:
    - name: "total_pathology_reports"
      expr: COUNT(1)
      comment: "Total number of pathology reports produced"
    - name: "cancer_reportable_count"
      expr: COUNT(CASE WHEN cancer_registry_reportable_flag = TRUE THEN 1 END)
      comment: "Number of cancer registry reportable cases - cancer program volume metric"
    - name: "amended_report_count"
      expr: COUNT(CASE WHEN amendment_reason IS NOT NULL THEN 1 END)
      comment: "Number of amended pathology reports - diagnostic quality indicator"
    - name: "amendment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN amendment_reason IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Pathology report amendment rate - quality metric; CAP benchmark <2%"
    - name: "positive_margin_count"
      expr: COUNT(CASE WHEN margin_status = 'positive' THEN 1 END)
      comment: "Number of cases with positive surgical margins - surgical quality indicator"
    - name: "avg_tumor_size_cm"
      expr: AVG(CAST(tumor_size_cm AS DOUBLE))
      comment: "Average tumor size in centimeters - cancer staging and screening effectiveness metric"
$$;