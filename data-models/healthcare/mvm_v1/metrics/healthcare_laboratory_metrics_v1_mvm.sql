-- Metric views for domain: laboratory | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 18:58:55

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`laboratory_lab_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for laboratory order management covering order volume, turnaround performance, send-out utilization, cancellation rates, and priority distribution. Supports lab operations leadership in capacity planning, workflow optimization, and quality oversight."
  source: "`healthcare_ecm`.`laboratory`.`lab_order`"
  dimensions:
    - name: "order_date"
      expr: order_date
      comment: "Calendar date the lab order was placed, used for trend analysis and daily/weekly/monthly volume reporting."
    - name: "order_priority"
      expr: order_priority
      comment: "Clinical urgency classification of the order (e.g., STAT, Routine, ASAP), used to segment turnaround performance and resource allocation."
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the lab order (e.g., Pending, In Progress, Resulted, Cancelled), used for workflow monitoring."
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of biological specimen required for the test (e.g., Blood, Urine, Tissue), used for pre-analytical workflow analysis."
    - name: "collection_method"
      expr: collection_method
      comment: "Method used to collect the specimen (e.g., Venipuncture, Swab), used for collection quality and efficiency analysis."
    - name: "is_send_out"
      expr: is_send_out
      comment: "Indicates whether the order was sent to a reference laboratory rather than performed in-house. Key driver of reference lab cost and turnaround variability."
    - name: "point_of_care_test"
      expr: point_of_care_test
      comment: "Indicates whether the test was performed at the point of care (bedside/clinic) rather than in the central lab, used for POC program utilization analysis."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month-level bucketing of order date for trend and seasonality analysis."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason the lab order was cancelled, used to identify systemic ordering issues and reduce unnecessary cancellations."
    - name: "result_integration_status"
      expr: result_integration_status
      comment: "Status of result integration back into the EHR/LIS, used to identify result delivery failures and integration gaps."
  measures:
    - name: "total_lab_orders"
      expr: COUNT(1)
      comment: "Total number of lab orders placed. Baseline volume metric for capacity planning and demand forecasting."
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN order_status = 'Cancelled' THEN 1 END)
      comment: "Number of lab orders that were cancelled. High cancellation rates indicate ordering workflow inefficiencies or clinical decision support gaps."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN order_status = 'Cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lab orders that were cancelled. A key quality metric — elevated rates signal over-ordering, specimen issues, or patient no-shows."
    - name: "send_out_order_count"
      expr: COUNT(CASE WHEN is_send_out = TRUE THEN 1 END)
      comment: "Number of orders sent to reference laboratories. Drives reference lab cost and turnaround time variability analysis."
    - name: "send_out_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_send_out = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lab orders sent to reference labs. High rates may indicate in-house test menu gaps or capacity constraints."
    - name: "stat_order_count"
      expr: COUNT(CASE WHEN order_priority = 'STAT' THEN 1 END)
      comment: "Number of STAT (urgent) lab orders. Elevated STAT volumes strain lab throughput and increase operational costs."
    - name: "stat_order_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN order_priority = 'STAT' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders classified as STAT. Benchmarked against industry norms (~15-25%) to identify over-prioritization patterns."
    - name: "point_of_care_order_count"
      expr: COUNT(CASE WHEN point_of_care_test = TRUE THEN 1 END)
      comment: "Number of point-of-care tests ordered. Tracks POC program utilization and its impact on central lab volume."
    - name: "fasting_required_order_count"
      expr: COUNT(CASE WHEN fasting_required = TRUE THEN 1 END)
      comment: "Number of orders requiring patient fasting. Used to coordinate patient scheduling and reduce pre-analytical errors from non-compliance."
    - name: "orders_pending_authorization"
      expr: COUNT(CASE WHEN authorization_required = TRUE AND order_status NOT IN ('Resulted', 'Cancelled') THEN 1 END)
      comment: "Number of active orders requiring prior authorization that have not yet been resulted or cancelled. Tracks authorization bottlenecks affecting care delivery."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`laboratory_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High-value KPIs for laboratory test result quality, critical value management, turnaround performance, and result amendment rates. Directly informs patient safety, regulatory compliance, and lab quality programs."
  source: "`healthcare_ecm`.`laboratory`.`test_result`"
  dimensions:
    - name: "result_status"
      expr: result_status
      comment: "Current status of the test result (e.g., Final, Preliminary, Amended, Corrected), used to track result lifecycle and amendment rates."
    - name: "abnormal_flag"
      expr: abnormal_flag
      comment: "Indicates whether the result is abnormal (e.g., High, Low, Critical), used for clinical alert and follow-up analysis."
    - name: "is_critical_value"
      expr: is_critical_value
      comment: "Boolean flag indicating the result triggered a critical value alert requiring immediate clinician notification. Core patient safety KPI dimension."
    - name: "is_amended"
      expr: is_amended
      comment: "Indicates whether the result was amended after initial release. Amendment rates are a key lab quality indicator."
    - name: "performing_lab_section"
      expr: performing_lab_section
      comment: "Laboratory section that performed the test (e.g., Chemistry, Hematology, Microbiology), used for section-level performance benchmarking."
    - name: "result_interpretation"
      expr: result_interpretation
      comment: "Clinical interpretation of the result (e.g., Normal, Abnormal, Indeterminate), used for outcome and quality analysis."
    - name: "critical_value_notification_method"
      expr: critical_value_notification_method
      comment: "Method used to notify the clinician of a critical value (e.g., Phone, Secure Message), used for notification compliance analysis."
    - name: "result_month"
      expr: DATE_TRUNC('MONTH', result_datetime)
      comment: "Month-level bucketing of result datetime for trend analysis of result volumes and quality metrics."
    - name: "result_unit"
      expr: result_unit
      comment: "Unit of measure for the numeric result value, used for cross-test comparability and reference range alignment."
  measures:
    - name: "total_test_results"
      expr: COUNT(1)
      comment: "Total number of test results produced. Baseline throughput metric for lab productivity and capacity management."
    - name: "critical_value_count"
      expr: COUNT(CASE WHEN is_critical_value = TRUE THEN 1 END)
      comment: "Number of results flagged as critical values. Tracks patient safety event volume requiring immediate clinical action."
    - name: "critical_value_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_critical_value = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of results that are critical values. Benchmarked against lab quality standards to detect analytical or pre-analytical issues."
    - name: "amended_result_count"
      expr: COUNT(CASE WHEN is_amended = TRUE THEN 1 END)
      comment: "Number of results that were amended after initial release. High amendment rates indicate analytical errors or transcription issues."
    - name: "amendment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_amended = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of results requiring amendment. A key lab quality and accreditation metric tracked by CAP and CLIA programs."
    - name: "abnormal_result_count"
      expr: COUNT(CASE WHEN abnormal_flag IS NOT NULL AND abnormal_flag NOT IN ('Normal', 'N') THEN 1 END)
      comment: "Number of results flagged as abnormal. Used to monitor disease burden and clinical alert volumes across the patient population."
    - name: "abnormal_result_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN abnormal_flag IS NOT NULL AND abnormal_flag NOT IN ('Normal', 'N') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of results that are abnormal. Elevated rates may indicate population health trends or analytical drift."
    - name: "avg_result_value_numeric"
      expr: AVG(CAST(result_value_numeric AS DOUBLE))
      comment: "Average numeric result value across all results in the selected dimension slice. Used for population-level analyte trending and reference range validation."
    - name: "critical_value_notification_lag_minutes"
      expr: AVG(CAST((unix_timestamp(critical_value_notification_datetime) - unix_timestamp(result_datetime)) / 60.0 AS DOUBLE))
      comment: "Average minutes between result availability and critical value notification to the clinician. Regulatory and accreditation bodies (CAP, TJC) require timely notification — this KPI directly measures compliance."
    - name: "critical_value_acknowledgment_lag_minutes"
      expr: AVG(CAST((unix_timestamp(critical_value_acknowledgment_datetime) - unix_timestamp(critical_value_notification_datetime)) / 60.0 AS DOUBLE))
      comment: "Average minutes between critical value notification and clinician acknowledgment. Measures clinician responsiveness to life-threatening results — a Joint Commission patient safety standard."
    - name: "result_release_lag_minutes"
      expr: AVG(CAST((unix_timestamp(result_released_datetime) - unix_timestamp(specimen_received_datetime)) / 60.0 AS DOUBLE))
      comment: "Average turnaround time in minutes from specimen receipt to result release. Core lab performance KPI used in SLA management and accreditation reporting."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`laboratory_specimen`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for specimen management covering collection quality, rejection rates, storage compliance, and pre-analytical performance. Supports lab quality programs and pre-analytical error reduction initiatives."
  source: "`healthcare_ecm`.`laboratory`.`specimen`"
  dimensions:
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of biological specimen (e.g., Whole Blood, Serum, Urine), used to segment rejection and quality metrics by specimen category."
    - name: "specimen_source"
      expr: specimen_source
      comment: "Anatomical or clinical source of the specimen (e.g., Peripheral Blood, CSF, Wound), used for pre-analytical quality analysis."
    - name: "accession_status"
      expr: accession_status
      comment: "Current accession status of the specimen (e.g., Received, Rejected, In Process, Disposed), used for workflow monitoring."
    - name: "collection_method"
      expr: collection_method
      comment: "Method used to collect the specimen, used to correlate collection technique with rejection and quality outcomes."
    - name: "condition_at_receipt"
      expr: condition_at_receipt
      comment: "Physical condition of the specimen upon receipt (e.g., Acceptable, Hemolyzed, Lipemic, Clotted), used to identify pre-analytical error sources."
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason the specimen was rejected (e.g., Insufficient Volume, Mislabeled, Hemolyzed), used to drive pre-analytical quality improvement."
    - name: "priority"
      expr: priority
      comment: "Processing priority of the specimen (e.g., STAT, Routine), used to segment turnaround performance by urgency."
    - name: "biohazard_level"
      expr: biohazard_level
      comment: "Biohazard classification of the specimen, used for safety compliance monitoring and handling protocol adherence."
    - name: "collection_month"
      expr: DATE_TRUNC('MONTH', collection_datetime)
      comment: "Month-level bucketing of specimen collection datetime for trend analysis."
    - name: "fasting_status"
      expr: fasting_status
      comment: "Patient fasting status at time of collection (e.g., Fasting, Non-Fasting, Unknown), used to assess pre-analytical compliance for fasting-sensitive tests."
  measures:
    - name: "total_specimens"
      expr: COUNT(1)
      comment: "Total number of specimens accessioned. Baseline volume metric for pre-analytical workload and capacity planning."
    - name: "rejected_specimen_count"
      expr: COUNT(CASE WHEN accession_status = 'Rejected' THEN 1 END)
      comment: "Number of specimens rejected upon receipt. Rejection events directly delay patient care and increase recollection costs."
    - name: "specimen_rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN accession_status = 'Rejected' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of specimens rejected. Industry benchmark is <1%; elevated rates indicate systemic pre-analytical quality failures requiring intervention."
    - name: "avg_volume_collected_ml"
      expr: AVG(CAST(volume_collected_ml AS DOUBLE))
      comment: "Average specimen volume collected in milliliters. Used to monitor collection adequacy and identify insufficient volume trends by test type."
    - name: "total_volume_collected_ml"
      expr: SUM(CAST(volume_collected_ml AS DOUBLE))
      comment: "Total specimen volume collected in milliliters. Used for reagent consumption planning and phlebotomy workload analysis."
    - name: "avg_transport_temperature_c"
      expr: AVG(CAST(transport_temperature_c AS DOUBLE))
      comment: "Average specimen transport temperature in Celsius. Deviations from required ranges indicate cold chain failures that compromise specimen integrity."
    - name: "avg_storage_temperature_c"
      expr: AVG(CAST(storage_temperature_c AS DOUBLE))
      comment: "Average specimen storage temperature in Celsius. Monitored for compliance with stability requirements and regulatory standards."
    - name: "hemolyzed_specimen_count"
      expr: COUNT(CASE WHEN condition_at_receipt = 'Hemolyzed' THEN 1 END)
      comment: "Number of specimens received in hemolyzed condition. Hemolysis is the leading cause of specimen rejection and interferes with multiple analytes."
    - name: "hemolysis_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN condition_at_receipt = 'Hemolyzed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of specimens that are hemolyzed. A key pre-analytical quality indicator tracked in CAP Q-Probes programs."
    - name: "distinct_patients_with_specimens"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients with specimens collected. Used for population coverage analysis and patient access to diagnostic services."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`laboratory_microbiology_culture`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Infection control and antimicrobial stewardship KPIs derived from microbiology culture results. Tracks MDRO prevalence, HAI-associated cultures, critical value notification compliance, and culture turnaround performance. Essential for infection preventionists, antimicrobial stewardship teams, and public health reporting."
  source: "`healthcare_ecm`.`laboratory`.`microbiology_culture`"
  dimensions:
    - name: "culture_type"
      expr: culture_type
      comment: "Type of culture performed (e.g., Blood, Urine, Wound, Respiratory), used to segment infection rates and organism prevalence by specimen source."
    - name: "culture_status"
      expr: culture_status
      comment: "Current status of the culture (e.g., Preliminary, Final, No Growth), used for workflow monitoring and result completeness tracking."
    - name: "growth_result"
      expr: growth_result
      comment: "Qualitative growth result of the culture (e.g., No Growth, Rare, Moderate, Heavy), used for clinical significance stratification."
    - name: "gram_stain_result"
      expr: gram_stain_result
      comment: "Gram stain result of the culture (e.g., Gram Positive Cocci, Gram Negative Rods), used for early empiric therapy guidance analysis."
    - name: "mdro_flag"
      expr: mdro_flag
      comment: "Indicates whether the culture identified a multi-drug resistant organism (MDRO). Core infection control and patient safety metric."
    - name: "mdro_type"
      expr: mdro_type
      comment: "Specific MDRO type identified (e.g., MRSA, VRE, CRE, ESBL), used for targeted infection control interventions and public health reporting."
    - name: "hai_associated_flag"
      expr: hai_associated_flag
      comment: "Indicates whether the culture is associated with a healthcare-acquired infection (HAI). HAI rates are a CMS quality measure and regulatory reporting requirement."
    - name: "hai_event_type"
      expr: hai_event_type
      comment: "Type of HAI event (e.g., CLABSI, CAUTI, SSI, VAP), used for targeted prevention program evaluation."
    - name: "antibiotic_stewardship_flag"
      expr: antibiotic_stewardship_flag
      comment: "Indicates the culture triggered an antimicrobial stewardship intervention. Used to measure stewardship program reach and impact."
    - name: "specimen_source_code"
      expr: specimen_source_code
      comment: "Coded specimen source for the culture, used for standardized infection site analysis and NHSN reporting."
    - name: "result_month"
      expr: DATE_TRUNC('MONTH', result_datetime)
      comment: "Month-level bucketing of culture result datetime for infection trend and outbreak detection analysis."
    - name: "public_health_reportable_flag"
      expr: public_health_reportable_flag
      comment: "Indicates whether the culture result is reportable to public health authorities. Used for regulatory compliance monitoring."
  measures:
    - name: "total_cultures"
      expr: COUNT(1)
      comment: "Total number of microbiology cultures performed. Baseline volume metric for microbiology workload and infection surveillance."
    - name: "positive_culture_count"
      expr: COUNT(CASE WHEN growth_result NOT IN ('No Growth', 'Negative') AND growth_result IS NOT NULL THEN 1 END)
      comment: "Number of cultures with organism growth detected. Used to calculate positivity rates and monitor infection burden."
    - name: "culture_positivity_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN growth_result NOT IN ('No Growth', 'Negative') AND growth_result IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cultures with positive growth. Elevated rates may indicate increased infection prevalence or inappropriate test ordering."
    - name: "mdro_culture_count"
      expr: COUNT(CASE WHEN mdro_flag = TRUE THEN 1 END)
      comment: "Number of cultures identifying multi-drug resistant organisms. A critical infection control metric tracked by infection preventionists and reported to public health agencies."
    - name: "mdro_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mdro_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN growth_result NOT IN ('No Growth', 'Negative') AND growth_result IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of positive cultures that are MDROs. Tracks antimicrobial resistance burden and effectiveness of stewardship interventions."
    - name: "hai_associated_culture_count"
      expr: COUNT(CASE WHEN hai_associated_flag = TRUE THEN 1 END)
      comment: "Number of cultures associated with healthcare-acquired infections. HAI counts are a CMS value-based purchasing metric and regulatory reporting requirement."
    - name: "hai_rate_per_100_cultures"
      expr: ROUND(100.0 * COUNT(CASE WHEN hai_associated_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "HAI-associated culture rate per 100 cultures performed. Used for benchmarking against NHSN national baselines and tracking prevention program effectiveness."
    - name: "critical_value_culture_count"
      expr: COUNT(CASE WHEN critical_value_flag = TRUE THEN 1 END)
      comment: "Number of cultures generating critical value alerts. Tracks patient safety event volume requiring immediate clinical notification."
    - name: "avg_turnaround_time_hours"
      expr: AVG(CAST(turnaround_time_hours AS DOUBLE))
      comment: "Average culture turnaround time in hours from collection to final result. A key operational KPI — prolonged TAT delays appropriate antimicrobial therapy and increases length of stay."
    - name: "stewardship_intervention_count"
      expr: COUNT(CASE WHEN antibiotic_stewardship_flag = TRUE THEN 1 END)
      comment: "Number of cultures triggering antimicrobial stewardship interventions. Measures stewardship program reach and is a CMS Antibiotic Stewardship Program reporting metric."
    - name: "stewardship_intervention_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN antibiotic_stewardship_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN growth_result NOT IN ('No Growth', 'Negative') AND growth_result IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of positive cultures receiving a stewardship intervention. Measures the effectiveness and coverage of the antimicrobial stewardship program."
    - name: "avg_colony_count"
      expr: AVG(CAST(colony_count AS DOUBLE))
      comment: "Average colony count across cultures with quantitative results. Used for infection severity trending and threshold-based clinical decision support validation."
    - name: "public_health_reportable_culture_count"
      expr: COUNT(CASE WHEN public_health_reportable_flag = TRUE THEN 1 END)
      comment: "Number of cultures with results reportable to public health authorities. Tracks regulatory reporting compliance obligations."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`laboratory_susceptibility_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Antimicrobial resistance and stewardship KPIs derived from susceptibility testing results. Tracks resistance rates by antibiotic class, MIC distributions, and stewardship alert volumes. Essential for antimicrobial stewardship programs, infection control, and public health surveillance."
  source: "`healthcare_ecm`.`laboratory`.`susceptibility_result`"
  dimensions:
    - name: "antibiotic_agent_name"
      expr: antibiotic_agent_name
      comment: "Name of the antibiotic agent tested, used to track resistance rates by specific drug for formulary and stewardship decisions."
    - name: "antibiotic_class"
      expr: antibiotic_class
      comment: "Pharmacological class of the antibiotic (e.g., Beta-lactam, Fluoroquinolone, Carbapenem), used for class-level resistance surveillance."
    - name: "susceptibility_interpretation"
      expr: susceptibility_interpretation
      comment: "CLSI/EUCAST interpretation of susceptibility (Susceptible, Intermediate, Resistant), the primary clinical decision variable for antibiotic selection."
    - name: "testing_method"
      expr: testing_method
      comment: "Method used for susceptibility testing (e.g., Broth Microdilution, Disk Diffusion, E-test), used for methodology quality and standardization analysis."
    - name: "resistance_mechanism"
      expr: resistance_mechanism
      comment: "Molecular or phenotypic resistance mechanism identified (e.g., ESBL, KPC, mecA), used for targeted infection control and epidemiological surveillance."
    - name: "antibiotic_stewardship_flag"
      expr: antibiotic_stewardship_flag
      comment: "Indicates the result triggered an antimicrobial stewardship alert or intervention."
    - name: "result_status"
      expr: result_status
      comment: "Status of the susceptibility result (e.g., Final, Preliminary, Corrected), used for result completeness monitoring."
    - name: "infection_control_alert_flag"
      expr: infection_control_alert_flag
      comment: "Indicates the result triggered an infection control alert (e.g., for contact precautions), used for alert compliance monitoring."
    - name: "result_month"
      expr: DATE_TRUNC('MONTH', result_timestamp)
      comment: "Month-level bucketing of result timestamp for resistance trend analysis and outbreak detection."
    - name: "clsi_breakpoint_version"
      expr: clsi_breakpoint_version
      comment: "Version of CLSI breakpoint standards applied to the interpretation, used for standardization and longitudinal comparability of resistance data."
  measures:
    - name: "total_susceptibility_tests"
      expr: COUNT(1)
      comment: "Total number of susceptibility tests performed. Baseline volume metric for antimicrobial stewardship program scope."
    - name: "resistant_result_count"
      expr: COUNT(CASE WHEN susceptibility_interpretation = 'Resistant' THEN 1 END)
      comment: "Number of susceptibility results classified as Resistant. Core antimicrobial resistance surveillance metric reported to CDC NHSN and public health agencies."
    - name: "resistance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN susceptibility_interpretation = 'Resistant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of susceptibility tests resulting in a Resistant interpretation. Tracks antimicrobial resistance burden and guides formulary management decisions."
    - name: "susceptible_result_count"
      expr: COUNT(CASE WHEN susceptibility_interpretation = 'Susceptible' THEN 1 END)
      comment: "Number of susceptibility results classified as Susceptible. Used to calculate susceptibility rates for antibiogram reporting and empiric therapy guideline development."
    - name: "susceptibility_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN susceptibility_interpretation = 'Susceptible' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of susceptibility tests resulting in a Susceptible interpretation. Published in institutional antibiograms to guide empiric antibiotic selection."
    - name: "avg_mic_value"
      expr: AVG(CAST(mic_value AS DOUBLE))
      comment: "Average minimum inhibitory concentration (MIC) value across tested isolates. MIC trends indicate emerging resistance before categorical breakpoint changes occur."
    - name: "avg_disk_diffusion_zone_mm"
      expr: AVG(CAST(disk_diffusion_zone_diameter_mm AS DOUBLE))
      comment: "Average disk diffusion zone diameter in millimeters. Used for quality control monitoring and correlation with MIC-based interpretations."
    - name: "stewardship_alert_count"
      expr: COUNT(CASE WHEN antibiotic_stewardship_flag = TRUE THEN 1 END)
      comment: "Number of susceptibility results triggering antimicrobial stewardship alerts. Measures stewardship program intervention volume and reach."
    - name: "infection_control_alert_count"
      expr: COUNT(CASE WHEN infection_control_alert_flag = TRUE THEN 1 END)
      comment: "Number of susceptibility results triggering infection control alerts (e.g., for contact precautions). Tracks infection control response burden."
    - name: "inducible_resistance_count"
      expr: COUNT(CASE WHEN inducible_resistance_flag = TRUE THEN 1 END)
      comment: "Number of results with inducible resistance detected (e.g., D-zone positive). Inducible resistance can cause treatment failure if not identified — a critical clinical safety metric."
    - name: "distinct_organisms_tested"
      expr: COUNT(DISTINCT organism_id)
      comment: "Number of distinct organisms for which susceptibility testing was performed. Used to assess breadth of resistance surveillance coverage."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`laboratory_transfusion_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient safety and hemovigilance KPIs for blood transfusion events. Tracks transfusion reaction rates, consent compliance, crossmatch performance, and volume metrics. Supports blood bank medical directors, patient safety officers, and hemovigilance program reporting."
  source: "`healthcare_ecm`.`laboratory`.`transfusion_event`"
  dimensions:
    - name: "transfusion_status"
      expr: transfusion_status
      comment: "Current status of the transfusion event (e.g., Completed, In Progress, Stopped, Cancelled), used for workflow and safety monitoring."
    - name: "transfusion_reaction_type"
      expr: transfusion_reaction_type
      comment: "Type of transfusion reaction that occurred (e.g., Febrile, Allergic, Hemolytic, TRALI), used for hemovigilance classification and root cause analysis."
    - name: "reaction_severity"
      expr: reaction_severity
      comment: "Severity classification of the transfusion reaction (e.g., Mild, Moderate, Severe, Life-threatening), used for patient safety risk stratification."
    - name: "crossmatch_type"
      expr: crossmatch_type
      comment: "Type of crossmatch performed (e.g., Electronic, Serologic, Immediate Spin), used for blood bank safety protocol compliance analysis."
    - name: "crossmatch_result"
      expr: crossmatch_result
      comment: "Result of the crossmatch (e.g., Compatible, Incompatible), used to track incompatible crossmatch rates as a patient safety metric."
    - name: "clinical_indication"
      expr: clinical_indication
      comment: "Clinical reason for the transfusion (e.g., Anemia, Surgical Blood Loss, Thrombocytopenia), used for appropriateness review and utilization management."
    - name: "transfusion_site"
      expr: transfusion_site
      comment: "Clinical location where the transfusion was administered (e.g., ICU, OR, ED), used for site-level utilization and safety analysis."
    - name: "hemovigilance_reported"
      expr: hemovigilance_reported
      comment: "Indicates whether the transfusion event was reported to the hemovigilance program. Used for regulatory reporting compliance monitoring."
    - name: "transfusion_month"
      expr: DATE_TRUNC('MONTH', transfusion_start_datetime)
      comment: "Month-level bucketing of transfusion start datetime for trend analysis of transfusion volumes and reaction rates."
    - name: "consent_obtained"
      expr: consent_obtained
      comment: "Indicates whether informed consent was obtained prior to transfusion. Consent compliance is a regulatory and accreditation requirement."
  measures:
    - name: "total_transfusion_events"
      expr: COUNT(1)
      comment: "Total number of transfusion events administered. Baseline volume metric for blood utilization management and blood bank capacity planning."
    - name: "transfusion_reaction_count"
      expr: COUNT(CASE WHEN transfusion_reaction_occurred = TRUE THEN 1 END)
      comment: "Number of transfusion events resulting in an adverse reaction. A critical patient safety metric tracked by hemovigilance programs and reported to FDA FAERS."
    - name: "transfusion_reaction_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN transfusion_reaction_occurred = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transfusions resulting in an adverse reaction. Benchmarked against national hemovigilance data — elevated rates trigger immediate blood bank safety review."
    - name: "incompatible_crossmatch_count"
      expr: COUNT(CASE WHEN crossmatch_result = 'Incompatible' THEN 1 END)
      comment: "Number of transfusion events with an incompatible crossmatch result. Incompatible transfusions are a sentinel patient safety event requiring root cause analysis."
    - name: "consent_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_obtained = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transfusions with documented informed consent. Consent compliance is a Joint Commission and CMS Conditions of Participation requirement."
    - name: "hemovigilance_reporting_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hemovigilance_reported = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN transfusion_reaction_occurred = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of transfusion reactions that were reported to the hemovigilance program. Measures regulatory reporting compliance for adverse transfusion events."
    - name: "avg_transfusion_rate_ml_per_hr"
      expr: AVG(CAST(transfusion_rate AS DOUBLE))
      comment: "Average transfusion infusion rate in mL/hour. Deviations from protocol-specified rates are associated with increased reaction risk and are monitored for nursing compliance."
    - name: "avg_pre_transfusion_temperature"
      expr: AVG(CAST(pre_transfusion_temperature AS DOUBLE))
      comment: "Average pre-transfusion patient temperature in Celsius. Baseline vital sign monitoring metric used to detect febrile reactions and assess pre-transfusion patient stability."
    - name: "avg_post_transfusion_temperature"
      expr: AVG(CAST(post_transfusion_temperature AS DOUBLE))
      comment: "Average post-transfusion patient temperature in Celsius. Temperature elevation post-transfusion is a key indicator of febrile non-hemolytic transfusion reactions."
    - name: "distinct_patients_transfused"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Number of unique patients who received a transfusion. Used for blood utilization per-patient analysis and identifying high-utilization patient cohorts."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`laboratory_blood_bank_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Blood inventory management and utilization KPIs covering unit status, wastage, infectious disease testing compliance, and financial metrics. Supports blood bank directors in inventory optimization, cost management, and regulatory compliance."
  source: "`healthcare_ecm`.`laboratory`.`blood_bank_unit`"
  dimensions:
    - name: "product_type"
      expr: product_type
      comment: "Type of blood product (e.g., Packed Red Blood Cells, Fresh Frozen Plasma, Platelets, Cryoprecipitate), used for product-level inventory and utilization analysis."
    - name: "unit_status"
      expr: unit_status
      comment: "Current status of the blood unit (e.g., Available, Issued, Transfused, Discarded, Quarantined), used for inventory management and wastage tracking."
    - name: "abo_blood_group"
      expr: abo_blood_group
      comment: "ABO blood group of the unit (e.g., A, B, AB, O), used for inventory balance analysis and shortage risk management by blood type."
    - name: "rh_type"
      expr: rh_type
      comment: "Rh type of the blood unit (Positive/Negative), used with ABO group for complete blood type inventory management."
    - name: "irradiation_status"
      expr: irradiation_status
      comment: "Irradiation status of the blood unit, used to track availability of irradiated products for immunocompromised patients."
    - name: "leukoreduction_status"
      expr: leukoreduction_status
      comment: "Leukoreduction processing status of the unit, used to track availability of leukoreduced products and compliance with institutional policies."
    - name: "infectious_disease_testing_status"
      expr: infectious_disease_testing_status
      comment: "Status of infectious disease testing on the unit (e.g., Passed, Failed, Pending), used for regulatory compliance and patient safety monitoring."
    - name: "discard_reason"
      expr: discard_reason
      comment: "Reason a blood unit was discarded (e.g., Expired, Contaminated, Damaged), used for wastage root cause analysis and inventory management improvement."
    - name: "donation_month"
      expr: DATE_TRUNC('MONTH', donation_date)
      comment: "Month-level bucketing of donation date for supply trend analysis and seasonal inventory planning."
    - name: "temperature_alarm_flag"
      expr: temperature_alarm_flag
      comment: "Indicates whether a temperature alarm was triggered during storage of this unit. Temperature excursions compromise unit safety and are a regulatory compliance issue."
  measures:
    - name: "total_blood_units"
      expr: COUNT(1)
      comment: "Total number of blood bank units in inventory. Baseline metric for blood supply management and shortage risk assessment."
    - name: "discarded_unit_count"
      expr: COUNT(CASE WHEN unit_status = 'Discarded' THEN 1 END)
      comment: "Number of blood units discarded. Blood product wastage represents significant financial loss and supply chain inefficiency."
    - name: "wastage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN unit_status = 'Discarded' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of blood units discarded. Industry benchmark is <2% for RBCs; elevated rates indicate inventory management failures or ordering inefficiencies."
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charges associated with blood bank units. Used for revenue cycle analysis and blood product billing compliance."
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of blood bank units. Used for blood product cost management, margin analysis, and supply chain optimization."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per blood unit. Used for vendor benchmarking, contract negotiation, and cost-per-unit trend analysis."
    - name: "total_volume_ml"
      expr: SUM(CAST(volume_ml AS DOUBLE))
      comment: "Total volume of blood products in milliliters. Used for transfusion medicine capacity planning and clinical utilization analysis."
    - name: "quarantined_unit_count"
      expr: COUNT(CASE WHEN unit_status = 'Quarantined' THEN 1 END)
      comment: "Number of blood units currently in quarantine. Elevated quarantine counts indicate infectious disease testing failures or supply chain quality issues."
    - name: "infectious_disease_test_failure_count"
      expr: COUNT(CASE WHEN infectious_disease_testing_status = 'Failed' THEN 1 END)
      comment: "Number of units that failed infectious disease testing. A critical patient safety and regulatory compliance metric — failed units must be quarantined and traced."
    - name: "temperature_alarm_unit_count"
      expr: COUNT(CASE WHEN temperature_alarm_flag = TRUE THEN 1 END)
      comment: "Number of blood units that experienced a temperature alarm during storage. Temperature excursions compromise unit viability and are a AABB accreditation compliance issue."
    - name: "crossmatch_required_unit_count"
      expr: COUNT(CASE WHEN crossmatch_required_flag = TRUE THEN 1 END)
      comment: "Number of blood units requiring a crossmatch before issue. Used for blood bank workflow planning and crossmatch-to-transfusion ratio analysis."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`laboratory_pathology_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Surgical pathology and cytology KPIs covering report turnaround, cancer registry compliance, critical value management, and tumor staging completeness. Supports pathology department leadership, cancer program administrators, and quality officers."
  source: "`healthcare_ecm`.`laboratory`.`pathology_report`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of pathology report (e.g., Surgical Pathology, Cytology, Autopsy, Bone Marrow), used for workload and quality analysis by report category."
    - name: "report_status"
      expr: report_status
      comment: "Current status of the pathology report (e.g., Preliminary, Final, Amended, Addendum), used for report completeness and amendment rate tracking."
    - name: "histologic_type"
      expr: histologic_type
      comment: "Histologic classification of the tissue diagnosis (e.g., Adenocarcinoma, Squamous Cell Carcinoma), used for cancer type distribution analysis."
    - name: "histologic_grade"
      expr: histologic_grade
      comment: "Histologic grade of the tumor (e.g., Grade 1, Grade 2, Grade 3), used for cancer severity distribution and outcome correlation."
    - name: "tnm_stage"
      expr: tnm_stage
      comment: "TNM staging classification of the tumor, used for cancer stage distribution analysis and treatment planning quality metrics."
    - name: "tumor_site"
      expr: tumor_site
      comment: "Anatomical site of the tumor, used for cancer site distribution analysis and cancer registry reporting."
    - name: "margin_status"
      expr: margin_status
      comment: "Surgical margin status (e.g., Negative, Positive, Close), used for surgical quality analysis and re-excision rate tracking."
    - name: "cancer_registry_reportable_flag"
      expr: cancer_registry_reportable_flag
      comment: "Indicates whether the case is reportable to the cancer registry. Used for cancer registry compliance monitoring."
    - name: "critical_value_flag"
      expr: critical_value_flag
      comment: "Indicates whether the pathology report contains a critical value requiring immediate clinician notification."
    - name: "report_month"
      expr: DATE_TRUNC('MONTH', sign_out_timestamp)
      comment: "Month-level bucketing of report sign-out timestamp for trend analysis of pathology volume and turnaround performance."
    - name: "tumor_board_reviewed_flag"
      expr: tumor_board_reviewed_flag
      comment: "Indicates whether the case was reviewed at a multidisciplinary tumor board. Tumor board review rates are a CoC cancer program accreditation standard."
  measures:
    - name: "total_pathology_reports"
      expr: COUNT(1)
      comment: "Total number of pathology reports generated. Baseline volume metric for pathology department workload and capacity planning."
    - name: "cancer_registry_reportable_count"
      expr: COUNT(CASE WHEN cancer_registry_reportable_flag = TRUE THEN 1 END)
      comment: "Number of cases reportable to the cancer registry. Used to monitor cancer registry case capture completeness — a CoC accreditation requirement."
    - name: "positive_margin_count"
      expr: COUNT(CASE WHEN margin_status = 'Positive' THEN 1 END)
      comment: "Number of surgical cases with positive resection margins. Positive margin rates are a surgical quality indicator associated with cancer recurrence risk."
    - name: "positive_margin_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN margin_status = 'Positive' THEN 1 END) / NULLIF(COUNT(CASE WHEN margin_status IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of resection cases with positive surgical margins. Benchmarked by tumor site against national surgical quality standards."
    - name: "critical_value_report_count"
      expr: COUNT(CASE WHEN critical_value_flag = TRUE THEN 1 END)
      comment: "Number of pathology reports containing critical values requiring immediate clinician notification. Tracks patient safety event volume in pathology."
    - name: "tumor_board_review_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN tumor_board_reviewed_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN cancer_registry_reportable_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of cancer registry reportable cases reviewed at tumor board. A Commission on Cancer (CoC) accreditation standard requiring ≥75% of eligible cases."
    - name: "avg_tumor_size_cm"
      expr: AVG(CAST(tumor_size_cm AS DOUBLE))
      comment: "Average tumor size in centimeters at time of diagnosis. Used for cancer stage distribution analysis and early detection program effectiveness evaluation."
    - name: "amended_report_count"
      expr: COUNT(CASE WHEN report_status = 'Amended' THEN 1 END)
      comment: "Number of pathology reports that were amended after initial sign-out. Amendment rates are a pathology quality indicator tracked by CAP accreditation programs."
    - name: "amendment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN report_status = 'Amended' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pathology reports requiring amendment. Elevated rates indicate diagnostic discordance or transcription errors requiring quality review."
    - name: "avg_sign_out_lag_hours"
      expr: AVG(CAST((unix_timestamp(sign_out_timestamp) - unix_timestamp(preliminary_report_timestamp)) / 3600.0 AS DOUBLE))
      comment: "Average hours from preliminary report to final sign-out. Pathology turnaround time is a key quality metric — CAP Q-Tracks benchmarks surgical pathology TAT at ≤2 days."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`laboratory_instrument`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory instrument operational performance and maintenance compliance KPIs. Tracks instrument uptime, calibration compliance, quality control pass rates, and maintenance adherence. Supports lab directors and biomedical engineering in equipment lifecycle management and regulatory compliance."
  source: "`healthcare_ecm`.`laboratory`.`instrument`"
  dimensions:
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type of laboratory instrument (e.g., Analyzer, Centrifuge, Incubator), used for equipment category-level performance analysis."
    - name: "lab_section"
      expr: lab_section
      comment: "Laboratory section where the instrument is deployed (e.g., Chemistry, Hematology, Microbiology), used for section-level equipment performance benchmarking."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the instrument (e.g., Active, Down, Decommissioned, Under Maintenance), used for real-time availability monitoring."
    - name: "manufacturer"
      expr: manufacturer
      comment: "Instrument manufacturer name, used for vendor performance analysis and service contract management."
    - name: "last_calibration_result"
      expr: last_calibration_result
      comment: "Result of the most recent calibration (e.g., Pass, Fail), used for analytical quality compliance monitoring."
    - name: "last_quality_control_result"
      expr: last_quality_control_result
      comment: "Result of the most recent quality control run (e.g., Pass, Fail, Warning), used for analytical quality monitoring and CLIA compliance."
    - name: "lis_connectivity_status"
      expr: lis_connectivity_status
      comment: "Status of the instrument's LIS interface connection (e.g., Connected, Disconnected, Error), used for result integration reliability monitoring."
    - name: "calibration_frequency"
      expr: calibration_frequency
      comment: "Required calibration frequency for the instrument (e.g., Daily, Weekly, Monthly), used for maintenance schedule compliance analysis."
  measures:
    - name: "total_instruments"
      expr: COUNT(1)
      comment: "Total number of laboratory instruments in the asset inventory. Baseline metric for equipment portfolio management."
    - name: "active_instrument_count"
      expr: COUNT(CASE WHEN operational_status = 'Active' THEN 1 END)
      comment: "Number of instruments currently in active operational status. Used to calculate instrument availability rates for capacity planning."
    - name: "instrument_availability_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN operational_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of instruments in active operational status. Instrument downtime directly impacts lab throughput and patient care delivery."
    - name: "total_downtime_hours"
      expr: SUM(CAST(total_downtime_hours AS DOUBLE))
      comment: "Total accumulated instrument downtime hours across the fleet. A key operational KPI — excessive downtime triggers service contract reviews and capital replacement planning."
    - name: "avg_downtime_hours_per_instrument"
      expr: AVG(CAST(total_downtime_hours AS DOUBLE))
      comment: "Average downtime hours per instrument. Used to identify chronically underperforming instruments requiring replacement or enhanced service contracts."
    - name: "calibration_failure_count"
      expr: COUNT(CASE WHEN last_calibration_result = 'Fail' THEN 1 END)
      comment: "Number of instruments with a failed most recent calibration. Calibration failures require immediate corrective action under CLIA and CAP regulations."
    - name: "qc_failure_count"
      expr: COUNT(CASE WHEN last_quality_control_result = 'Fail' THEN 1 END)
      comment: "Number of instruments with a failed most recent QC run. QC failures require result hold and corrective action — a CLIA compliance requirement."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of laboratory instruments. Used for capital asset management, depreciation analysis, and replacement budget planning."
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per instrument. Used for capital budgeting benchmarks and vendor pricing analysis."
    - name: "lis_disconnected_instrument_count"
      expr: COUNT(CASE WHEN lis_connectivity_status = 'Disconnected' THEN 1 END)
      comment: "Number of instruments with disconnected LIS interfaces. LIS disconnections cause manual result entry, increasing transcription error risk and turnaround time."
$$;