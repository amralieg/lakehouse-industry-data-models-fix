-- Metric views for domain: laboratory | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 16:05:56

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_lab_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for laboratory order management — covering order volume, turnaround expectations, cancellation rates, send-out utilization, and priority distribution. Drives lab operations, capacity planning, and quality oversight."
  source: "`vibe_healthcare_v1`.`laboratory`.`lab_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the lab order (e.g., pending, resulted, cancelled). Used to segment order pipeline and identify bottlenecks."
    - name: "order_priority"
      expr: order_priority
      comment: "Priority level of the order (e.g., STAT, routine). Critical for workload triage and turnaround time analysis."
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of specimen collected (e.g., blood, urine). Supports specimen handling and workflow analysis."
    - name: "collection_method"
      expr: collection_method
      comment: "Method used to collect the specimen. Informs pre-analytical quality and collection protocol adherence."
    - name: "is_send_out"
      expr: is_send_out
      comment: "Indicates whether the order was sent to a reference laboratory. Drives make-vs-buy and reference lab cost analysis."
    - name: "point_of_care_test"
      expr: point_of_care_test
      comment: "Indicates whether the test was performed at the point of care. Supports POC program utilization tracking."
    - name: "order_date"
      expr: order_date
      comment: "Calendar date the order was placed. Used for time-series trending of order volumes."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_timestamp)
      comment: "Month the order was placed, derived from order timestamp. Supports monthly volume trending."
    - name: "fasting_required"
      expr: fasting_required
      comment: "Indicates whether fasting was required for the test. Supports patient preparation compliance analysis."
    - name: "result_integration_status"
      expr: result_integration_status
      comment: "Status of result integration back into the EHR/LIS. Identifies integration failures impacting clinical workflow."
  measures:
    - name: "total_lab_orders"
      expr: COUNT(1)
      comment: "Total number of lab orders placed. Baseline volume KPI for capacity planning and demand forecasting."
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN order_status = 'cancelled' THEN 1 END)
      comment: "Number of cancelled lab orders. High cancellation rates signal ordering workflow issues or patient no-shows."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN order_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lab orders that were cancelled. A key quality and efficiency indicator for lab operations leadership."
    - name: "send_out_order_count"
      expr: COUNT(CASE WHEN is_send_out = TRUE THEN 1 END)
      comment: "Number of orders sent to reference laboratories. Drives reference lab cost management and in-house test expansion decisions."
    - name: "send_out_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_send_out = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders sent out to reference labs. Executives use this to evaluate build-vs-buy decisions for test capabilities."
    - name: "stat_order_count"
      expr: COUNT(CASE WHEN order_priority = 'STAT' THEN 1 END)
      comment: "Number of STAT (urgent) lab orders. Elevated STAT volumes indicate patient acuity and drive staffing decisions."
    - name: "stat_order_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN order_priority = 'STAT' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders flagged as STAT. High STAT rates stress lab capacity and are a key operational risk indicator."
    - name: "point_of_care_order_count"
      expr: COUNT(CASE WHEN point_of_care_test = TRUE THEN 1 END)
      comment: "Number of point-of-care test orders. Tracks POC program utilization and its impact on central lab volume."
    - name: "authorization_required_order_count"
      expr: COUNT(CASE WHEN authorization_required = TRUE THEN 1 END)
      comment: "Number of orders requiring prior authorization. Drives revenue cycle and denial management focus areas."
    - name: "result_integration_failure_count"
      expr: COUNT(CASE WHEN result_integration_status = 'failed' THEN 1 END)
      comment: "Number of orders where result integration back to EHR/LIS failed. Directly impacts patient safety and clinical decision-making."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High-value KPIs for laboratory test result quality, critical value management, and turnaround performance. Supports patient safety, regulatory compliance, and lab quality programs."
  source: "`vibe_healthcare_v1`.`laboratory`.`test_result`"
  dimensions:
    - name: "result_status"
      expr: result_status
      comment: "Status of the test result (e.g., final, preliminary, amended). Used to track result lifecycle and amendment rates."
    - name: "result_interpretation"
      expr: result_interpretation
      comment: "Clinical interpretation of the result (e.g., normal, abnormal, critical). Supports quality and clinical outcome analysis."
    - name: "performing_lab_section"
      expr: performing_lab_section
      comment: "Lab section that performed the test (e.g., chemistry, hematology). Enables section-level performance benchmarking."
    - name: "abnormal_flag"
      expr: abnormal_flag
      comment: "Indicates whether the result was flagged as abnormal. Used to track abnormal result rates by test and section."
    - name: "is_critical_value"
      expr: is_critical_value
      comment: "Indicates whether the result triggered a critical value alert. Central to patient safety monitoring."
    - name: "is_amended"
      expr: is_amended
      comment: "Indicates whether the result was amended after initial release. Amendment rates reflect result quality and accuracy."
    - name: "critical_value_notification_method"
      expr: critical_value_notification_method
      comment: "Method used to notify clinicians of critical values (e.g., phone, EHR alert). Supports notification protocol compliance."
    - name: "result_month"
      expr: DATE_TRUNC('MONTH', result_datetime)
      comment: "Month the result was finalized. Enables monthly trending of result volumes and quality metrics."
    - name: "result_unit"
      expr: result_unit
      comment: "Unit of measure for the result value. Supports standardization and unit-level quality analysis."
  measures:
    - name: "total_test_results"
      expr: COUNT(1)
      comment: "Total number of test results produced. Baseline throughput KPI for lab productivity and capacity management."
    - name: "critical_value_count"
      expr: COUNT(CASE WHEN is_critical_value = TRUE THEN 1 END)
      comment: "Number of results flagged as critical values. Directly tied to patient safety — executives monitor this for risk management."
    - name: "critical_value_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_critical_value = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of results that are critical values. A key patient safety and regulatory compliance KPI."
    - name: "abnormal_result_count"
      expr: COUNT(CASE WHEN abnormal_flag = TRUE THEN 1 END)
      comment: "Number of abnormal test results. Elevated abnormal rates may signal population health trends or pre-analytical issues."
    - name: "abnormal_result_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN abnormal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of results flagged as abnormal. Used by medical directors to assess test utility and population health."
    - name: "amended_result_count"
      expr: COUNT(CASE WHEN is_amended = TRUE THEN 1 END)
      comment: "Number of results that were amended after initial release. High amendment rates indicate quality or transcription issues."
    - name: "amendment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_amended = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of results that required amendment. A direct quality indicator tracked by lab directors and accreditation bodies."
    - name: "avg_result_value_numeric"
      expr: AVG(CAST(result_value_numeric AS DOUBLE))
      comment: "Average numeric result value across all results in the selected dimension slice. Supports population-level clinical trend analysis."
    - name: "critical_value_acknowledged_count"
      expr: COUNT(CASE WHEN critical_value_acknowledgment_datetime IS NOT NULL THEN 1 END)
      comment: "Number of critical values that received clinician acknowledgment. Measures compliance with critical value notification protocols."
    - name: "critical_value_acknowledgment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_value_acknowledgment_datetime IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN is_critical_value = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of critical values acknowledged by a clinician. A regulatory and patient safety KPI required by CAP/TJC accreditation."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_specimen`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for specimen management — covering rejection rates, collection quality, transport integrity, and storage compliance. Drives pre-analytical quality improvement and specimen handling protocols."
  source: "`vibe_healthcare_v1`.`laboratory`.`specimen`"
  dimensions:
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of specimen (e.g., blood, urine, tissue). Enables rejection and quality analysis by specimen type."
    - name: "accession_status"
      expr: accession_status
      comment: "Current accession status of the specimen (e.g., received, rejected, processed). Tracks specimen pipeline."
    - name: "collection_method"
      expr: collection_method
      comment: "Method used to collect the specimen. Supports pre-analytical quality analysis by collection technique."
    - name: "condition_at_receipt"
      expr: condition_at_receipt
      comment: "Condition of the specimen when received by the lab (e.g., hemolyzed, lipemic, clotted). Key pre-analytical quality indicator."
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason the specimen was rejected. Drives root cause analysis for pre-analytical error reduction programs."
    - name: "biohazard_level"
      expr: biohazard_level
      comment: "Biohazard classification of the specimen. Supports safety compliance and handling protocol adherence."
    - name: "receiving_lab_location"
      expr: receiving_lab_location
      comment: "Lab location that received the specimen. Enables location-level performance benchmarking."
    - name: "priority"
      expr: priority
      comment: "Priority of the specimen (e.g., STAT, routine). Used to analyze turnaround time by priority tier."
    - name: "collection_month"
      expr: DATE_TRUNC('MONTH', collection_datetime)
      comment: "Month the specimen was collected. Supports monthly volume and quality trending."
    - name: "fasting_status"
      expr: fasting_status
      comment: "Fasting status of the patient at time of collection. Supports pre-analytical compliance and result validity analysis."
  measures:
    - name: "total_specimens"
      expr: COUNT(1)
      comment: "Total number of specimens accessioned. Baseline volume KPI for lab throughput and capacity planning."
    - name: "rejected_specimen_count"
      expr: COUNT(CASE WHEN rejection_reason IS NOT NULL THEN 1 END)
      comment: "Number of specimens rejected due to quality issues. High rejection rates increase costs and delay patient care."
    - name: "specimen_rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rejection_reason IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of specimens rejected. A primary pre-analytical quality KPI tracked by lab directors and accreditation bodies (CAP target <2%)."
    - name: "avg_collection_duration_minutes"
      expr: AVG(CAST(collection_duration_minutes AS DOUBLE))
      comment: "Average time in minutes to collect a specimen. Drives phlebotomy efficiency and patient experience improvements."
    - name: "avg_transport_duration_minutes"
      expr: AVG(CAST(transport_duration_minutes AS DOUBLE))
      comment: "Average specimen transport time in minutes. Prolonged transport impacts specimen integrity and result accuracy."
    - name: "avg_volume_collected_ml"
      expr: AVG(CAST(volume_collected_ml AS DOUBLE))
      comment: "Average volume of specimen collected in milliliters. Supports adequacy monitoring and minimum volume compliance."
    - name: "total_volume_collected_ml"
      expr: SUM(CAST(volume_collected_ml AS DOUBLE))
      comment: "Total specimen volume collected in milliliters. Supports blood management and patient safety (pediatric/oncology draw limits)."
    - name: "avg_storage_temperature_c"
      expr: AVG(CAST(storage_temperature_c AS DOUBLE))
      comment: "Average storage temperature in Celsius. Deviations from required storage temperatures compromise specimen integrity."
    - name: "avg_transport_temperature_c"
      expr: AVG(CAST(transport_temperature_c AS DOUBLE))
      comment: "Average transport temperature in Celsius. Cold-chain compliance is critical for specimen stability and result validity."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_microbiology_culture`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Infection control and antimicrobial stewardship KPIs derived from microbiology culture results — covering MDRO rates, HAI detection, critical value notification, and culture turnaround. Supports infection prevention programs and public health reporting."
  source: "`vibe_healthcare_v1`.`laboratory`.`microbiology_culture`"
  dimensions:
    - name: "culture_type"
      expr: culture_type
      comment: "Type of culture performed (e.g., blood, urine, wound). Enables infection type-specific analysis."
    - name: "culture_status"
      expr: culture_status
      comment: "Current status of the culture (e.g., preliminary, final, no growth). Tracks culture pipeline and result availability."
    - name: "growth_result"
      expr: growth_result
      comment: "Outcome of the culture growth (e.g., no growth, growth detected). Supports infection prevalence analysis."
    - name: "gram_stain_result"
      expr: gram_stain_result
      comment: "Result of the gram stain (e.g., gram positive cocci, gram negative rods). Supports early empiric therapy decisions."
    - name: "mdro_type"
      expr: mdro_type
      comment: "Type of multi-drug resistant organism identified (e.g., MRSA, VRE, CRE). Critical for infection control program targeting."
    - name: "hai_event_type"
      expr: hai_event_type
      comment: "Type of healthcare-associated infection event (e.g., CLABSI, CAUTI). Drives HAI prevention program prioritization."
    - name: "specimen_source_code"
      expr: specimen_source_code
      comment: "Coded source of the specimen. Enables infection site-specific analysis and HAI attribution."
    - name: "result_interpretation"
      expr: result_interpretation
      comment: "Clinical interpretation of the culture result. Supports outcome and treatment response analysis."
    - name: "culture_month"
      expr: DATE_TRUNC('MONTH', collection_datetime)
      comment: "Month the culture specimen was collected. Supports monthly infection trend and seasonality analysis."
  measures:
    - name: "total_cultures"
      expr: COUNT(1)
      comment: "Total number of microbiology cultures performed. Baseline volume KPI for microbiology lab capacity and infection surveillance."
    - name: "positive_culture_count"
      expr: COUNT(CASE WHEN growth_result IS NOT NULL AND growth_result != 'No Growth' THEN 1 END)
      comment: "Number of cultures with organism growth detected. Tracks infection burden and drives antimicrobial stewardship interventions."
    - name: "positive_culture_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN growth_result IS NOT NULL AND growth_result != 'No Growth' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cultures with positive growth. A key infection surveillance KPI used by infection control and epidemiology teams."
    - name: "mdro_positive_count"
      expr: COUNT(CASE WHEN mdro_flag = TRUE THEN 1 END)
      comment: "Number of cultures positive for multi-drug resistant organisms. Directly drives infection control isolation and decolonization programs."
    - name: "mdro_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mdro_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cultures positive for MDROs. A critical patient safety and regulatory KPI reported to CMS and public health agencies."
    - name: "hai_associated_culture_count"
      expr: COUNT(CASE WHEN hai_associated_flag = TRUE THEN 1 END)
      comment: "Number of cultures associated with healthcare-acquired infections. HAI rates are publicly reported and tied to CMS reimbursement penalties."
    - name: "critical_value_culture_count"
      expr: COUNT(CASE WHEN critical_value_flag = TRUE THEN 1 END)
      comment: "Number of cultures that triggered a critical value alert. Drives patient safety and notification protocol compliance monitoring."
    - name: "infection_control_notification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN infection_control_notified_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN mdro_flag = TRUE OR hai_associated_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of MDRO/HAI-associated cultures where infection control was notified. Measures compliance with mandatory notification protocols."
    - name: "avg_culture_turnaround_hours"
      expr: AVG(CAST(turnaround_time_hours AS DOUBLE))
      comment: "Average culture turnaround time in hours. Prolonged TAT delays appropriate antimicrobial therapy and worsens patient outcomes."
    - name: "susceptibility_panel_performed_count"
      expr: COUNT(CASE WHEN susceptibility_panel_performed = TRUE THEN 1 END)
      comment: "Number of cultures where a susceptibility panel was performed. Supports antimicrobial stewardship program coverage analysis."
    - name: "public_health_reportable_count"
      expr: COUNT(CASE WHEN public_health_reportable_flag = TRUE THEN 1 END)
      comment: "Number of cultures with public health reportable organisms. Drives mandatory public health reporting compliance and outbreak surveillance."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_pathology_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for anatomic pathology operations — covering cancer registry reporting, critical value management, report turnaround, amendment rates, and tumor board review compliance. Supports oncology program quality and regulatory compliance."
  source: "`vibe_healthcare_v1`.`laboratory`.`pathology_report`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Current status of the pathology report (e.g., preliminary, final, amended). Tracks report lifecycle and completion rates."
    - name: "report_type"
      expr: report_type
      comment: "Type of pathology report (e.g., surgical, cytology, autopsy). Enables workload analysis by report category."
    - name: "histologic_type"
      expr: histologic_type
      comment: "Histologic classification of the tissue (e.g., adenocarcinoma, squamous cell). Supports oncology program case mix analysis."
    - name: "histologic_grade"
      expr: histologic_grade
      comment: "Histologic grade of the tumor. Used in cancer registry reporting and oncology outcome analysis."
    - name: "tnm_stage"
      expr: tnm_stage
      comment: "TNM staging of the tumor. Critical for cancer registry, treatment planning, and outcomes benchmarking."
    - name: "tumor_site"
      expr: tumor_site
      comment: "Anatomic site of the tumor. Enables cancer program volume and outcome analysis by tumor site."
    - name: "margin_status"
      expr: margin_status
      comment: "Surgical margin status (e.g., positive, negative, close). Directly impacts surgical re-excision decisions and outcome tracking."
    - name: "is_amended"
      expr: is_amended
      comment: "Indicates whether the report was amended after sign-out. Amendment rates are a pathology quality indicator."
    - name: "cancer_registry_reportable_flag"
      expr: cancer_registry_reportable_flag
      comment: "Indicates whether the case must be reported to the cancer registry. Drives regulatory compliance monitoring."
    - name: "sign_out_month"
      expr: DATE_TRUNC('MONTH', sign_out_timestamp)
      comment: "Month the report was signed out. Supports monthly volume and turnaround time trending."
  measures:
    - name: "total_pathology_reports"
      expr: COUNT(1)
      comment: "Total number of pathology reports generated. Baseline volume KPI for anatomic pathology workload and capacity planning."
    - name: "cancer_registry_reportable_count"
      expr: COUNT(CASE WHEN cancer_registry_reportable_flag = TRUE THEN 1 END)
      comment: "Number of cases requiring cancer registry reporting. Drives compliance with mandatory state and national cancer registry reporting obligations."
    - name: "cancer_registry_reporting_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cancer_registry_reportable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pathology cases that are cancer registry reportable. Supports cancer program accreditation (CoC) compliance monitoring."
    - name: "critical_value_pathology_count"
      expr: COUNT(CASE WHEN critical_value_flag = TRUE THEN 1 END)
      comment: "Number of pathology reports with critical values requiring urgent clinician notification. A patient safety KPI."
    - name: "amended_report_count"
      expr: COUNT(CASE WHEN is_amended = TRUE THEN 1 END)
      comment: "Number of pathology reports amended after sign-out. Amendment rates are a key quality indicator for pathology accreditation."
    - name: "amendment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_amended = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pathology reports that were amended. Tracked by pathology directors and CAP accreditation reviewers."
    - name: "tumor_board_reviewed_count"
      expr: COUNT(CASE WHEN tumor_board_reviewed_flag = TRUE THEN 1 END)
      comment: "Number of cases reviewed by the tumor board. Tumor board review rates are a CoC cancer program accreditation requirement."
    - name: "tumor_board_review_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN tumor_board_reviewed_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN cancer_registry_reportable_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of cancer registry reportable cases reviewed by the tumor board. A direct CoC accreditation compliance KPI."
    - name: "avg_tumor_size_cm"
      expr: AVG(CAST(tumor_size_cm AS DOUBLE))
      comment: "Average tumor size in centimeters across pathology cases. Supports oncology program case mix severity and staging analysis."
    - name: "positive_margin_count"
      expr: COUNT(CASE WHEN margin_status = 'positive' THEN 1 END)
      comment: "Number of cases with positive surgical margins. Positive margins drive re-excision decisions and are a surgical quality indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_instrument`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset management and operational reliability KPIs for laboratory instruments — covering downtime, maintenance compliance, calibration status, and service contract coverage. Drives capital planning and equipment reliability programs."
  source: "`vibe_healthcare_v1`.`laboratory`.`instrument`"
  dimensions:
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type of laboratory instrument (e.g., analyzer, centrifuge, microscope). Enables asset analysis by equipment category."
    - name: "lab_section"
      expr: lab_section
      comment: "Laboratory section where the instrument is located (e.g., chemistry, hematology). Supports section-level asset management."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the instrument (e.g., active, down, decommissioned). Tracks fleet availability."
    - name: "manufacturer"
      expr: manufacturer
      comment: "Instrument manufacturer. Supports vendor performance analysis and contract negotiation."
    - name: "lis_connectivity_status"
      expr: lis_connectivity_status
      comment: "Status of the instrument's LIS interface connection. Connectivity failures impact result reporting and workflow automation."
    - name: "last_calibration_result"
      expr: last_calibration_result
      comment: "Result of the most recent calibration (e.g., pass, fail). Calibration failures require immediate remediation to ensure result accuracy."
    - name: "last_quality_control_result"
      expr: last_quality_control_result
      comment: "Result of the most recent quality control run. QC failures halt testing and are a key regulatory compliance indicator."
    - name: "calibration_frequency"
      expr: calibration_frequency
      comment: "Required calibration frequency for the instrument. Supports maintenance scheduling and compliance monitoring."
  measures:
    - name: "total_instruments"
      expr: COUNT(1)
      comment: "Total number of laboratory instruments in the fleet. Baseline asset count for capital planning and fleet management."
    - name: "active_instrument_count"
      expr: COUNT(CASE WHEN operational_status = 'active' THEN 1 END)
      comment: "Number of instruments currently in active operational status. Drives capacity availability and test menu planning."
    - name: "instrument_availability_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN operational_status = 'active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of instruments currently active and available. A key operational reliability KPI for lab directors and facilities management."
    - name: "total_downtime_hours"
      expr: SUM(CAST(total_downtime_hours AS DOUBLE))
      comment: "Total accumulated downtime hours across all instruments. Downtime directly impacts lab throughput and patient care delivery."
    - name: "avg_downtime_hours_per_instrument"
      expr: AVG(CAST(total_downtime_hours AS DOUBLE))
      comment: "Average downtime hours per instrument. Identifies chronic reliability issues requiring capital replacement or service contract escalation."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of all instruments in the fleet. Supports capital asset valuation and depreciation planning."
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per instrument. Benchmarks investment levels by instrument type and informs future capital requests."
    - name: "calibration_failure_count"
      expr: COUNT(CASE WHEN last_calibration_result = 'fail' THEN 1 END)
      comment: "Number of instruments with a failed most recent calibration. Calibration failures require immediate corrective action per CLIA regulations."
    - name: "qc_failure_count"
      expr: COUNT(CASE WHEN last_quality_control_result = 'fail' THEN 1 END)
      comment: "Number of instruments with a failed most recent QC run. QC failures halt testing and are a primary CLIA compliance risk."
    - name: "service_contract_expiring_count"
      expr: COUNT(CASE WHEN service_contract_expiration_date <= DATE_ADD(CURRENT_DATE(), 90) AND service_contract_expiration_date >= CURRENT_DATE() THEN 1 END)
      comment: "Number of instruments with service contracts expiring within 90 days. Drives proactive contract renewal to avoid coverage gaps."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`laboratory_test_catalog`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test menu governance and utilization KPIs — covering orderable test availability, CLIA complexity distribution, reference lab dependency, and test catalog lifecycle management. Supports lab medical director oversight and test menu strategy."
  source: "`vibe_healthcare_v1`.`laboratory`.`test_catalog`"
  dimensions:
    - name: "test_category"
      expr: test_category
      comment: "Category of the test (e.g., chemistry, hematology, microbiology). Enables test menu analysis by clinical category."
    - name: "test_type"
      expr: test_type
      comment: "Type of test (e.g., quantitative, qualitative, semi-quantitative). Supports test menu composition analysis."
    - name: "clia_complexity"
      expr: clia_complexity
      comment: "CLIA complexity classification (waived, moderate, high). Drives regulatory compliance and personnel qualification requirements."
    - name: "orderable_status"
      expr: orderable_status
      comment: "Current orderability status of the test (e.g., active, inactive, restricted). Tracks test menu availability."
    - name: "performing_lab_location"
      expr: performing_lab_location
      comment: "Lab location that performs the test. Supports test menu distribution and location-level capability analysis."
    - name: "methodology"
      expr: methodology
      comment: "Analytical methodology used for the test. Supports method standardization and harmonization initiatives."
    - name: "specimen_type"
      expr: specimen_type
      comment: "Required specimen type for the test. Supports specimen collection protocol standardization."
  measures:
    - name: "total_catalog_tests"
      expr: COUNT(1)
      comment: "Total number of tests in the laboratory test catalog. Baseline KPI for test menu breadth and catalog governance."
    - name: "orderable_test_count"
      expr: COUNT(CASE WHEN orderable_flag = TRUE THEN 1 END)
      comment: "Number of tests currently available for ordering. Tracks active test menu size and availability for clinical use."
    - name: "orderable_test_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN orderable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of catalog tests that are currently orderable. Measures test menu activation and catalog hygiene."
    - name: "reference_lab_test_count"
      expr: COUNT(CASE WHEN reference_lab_name IS NOT NULL AND reference_lab_name != '' THEN 1 END)
      comment: "Number of tests sent to reference laboratories. Drives make-vs-buy analysis and reference lab cost management strategy."
    - name: "reference_lab_dependency_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reference_lab_name IS NOT NULL AND reference_lab_name != '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of catalog tests dependent on reference laboratories. High dependency rates signal opportunities for in-house test development."
    - name: "consent_required_test_count"
      expr: COUNT(CASE WHEN consent_required_flag = TRUE THEN 1 END)
      comment: "Number of tests requiring patient consent. Drives consent workflow design and compliance monitoring for sensitive testing."
    - name: "authorization_required_test_count"
      expr: COUNT(CASE WHEN authorization_required_flag = TRUE THEN 1 END)
      comment: "Number of tests requiring prior authorization. Supports revenue cycle management and denial prevention program scoping."
    - name: "high_complexity_test_count"
      expr: COUNT(CASE WHEN clia_complexity = 'high' THEN 1 END)
      comment: "Number of high-complexity CLIA tests in the catalog. High-complexity tests require specific personnel qualifications and drive training investment decisions."
$$;