-- Metric views for domain: radiology | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 18:58:55

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`radiology_imaging_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and throughput KPIs for imaging orders — covers order volume, turnaround times, stat utilisation, cancellation rates, and contrast usage. Primary steering dashboard for radiology operations leadership."
  source: "`healthcare_ecm`.`radiology`.`imaging_order`"
  dimensions:
    - name: "modality_type"
      expr: modality_type
      comment: "Imaging modality (CT, MRI, X-Ray, US, PET, etc.) — primary slice for capacity planning and utilisation analysis."
    - name: "order_priority"
      expr: order_priority
      comment: "Clinical urgency tier of the order (STAT, ROUTINE, URGENT) — used to monitor SLA compliance by priority class."
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the imaging order (ORDERED, SCHEDULED, COMPLETED, CANCELLED) — used to track pipeline health."
    - name: "referring_department"
      expr: referring_department
      comment: "Hospital department that originated the imaging request — used to identify high-demand departments and allocate scanner capacity."
    - name: "order_source"
      expr: order_source
      comment: "Channel through which the order was placed (EHR, verbal, paper, external) — used to assess workflow standardisation."
    - name: "body_part"
      expr: body_part
      comment: "Anatomical region targeted by the imaging order — used for protocol and equipment utilisation analysis."
    - name: "contrast_required"
      expr: contrast_required
      comment: "Boolean flag indicating whether contrast agent is required — used to plan contrast inventory and staffing."
    - name: "is_portable"
      expr: is_portable
      comment: "Indicates whether the exam is performed at bedside (portable) — used to track portable exam demand and resource deployment."
    - name: "ordered_date"
      expr: DATE_TRUNC('day', ordered_timestamp)
      comment: "Calendar day the order was placed — used for daily volume trending and SLA monitoring."
    - name: "ordered_month"
      expr: DATE_TRUNC('month', ordered_timestamp)
      comment: "Calendar month the order was placed — used for monthly volume and trend reporting."
    - name: "report_status"
      expr: report_status
      comment: "Current status of the associated radiology report (PRELIMINARY, FINAL, ADDENDUM) — used to track reporting pipeline completeness."
  measures:
    - name: "total_imaging_orders"
      expr: COUNT(1)
      comment: "Total number of imaging orders placed. Baseline volume KPI used to assess demand, capacity needs, and growth trends."
    - name: "stat_order_count"
      expr: COUNT(CASE WHEN order_priority = 'STAT' THEN 1 END)
      comment: "Number of STAT-priority imaging orders. High STAT volume signals acute care demand spikes and drives staffing escalation decisions."
    - name: "stat_order_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN order_priority = 'STAT' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of imaging orders flagged as STAT. Elevated rates indicate emergency department pressure or over-triage; tracked against benchmarks."
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN order_status = 'CANCELLED' THEN 1 END)
      comment: "Number of imaging orders that were cancelled. High cancellation volume signals scheduling inefficiency, patient no-shows, or clinical workflow gaps."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN order_status = 'CANCELLED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of imaging orders cancelled. A key operational efficiency KPI — high rates drive investigation into scheduling, prep, and authorisation processes."
    - name: "contrast_order_count"
      expr: COUNT(CASE WHEN contrast_required = TRUE THEN 1 END)
      comment: "Number of imaging orders requiring contrast agent. Drives contrast inventory planning, pharmacy coordination, and allergy screening workload."
    - name: "contrast_order_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN contrast_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of imaging orders requiring contrast. Used to forecast contrast supply needs and staffing for contrast administration."
    - name: "critical_finding_order_count"
      expr: COUNT(CASE WHEN critical_finding_flag = TRUE THEN 1 END)
      comment: "Number of imaging orders that resulted in a critical finding. Tracks patient safety exposure and drives notification workflow compliance reviews."
    - name: "critical_finding_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_finding_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of imaging orders with a critical finding. A patient safety KPI monitored by CMO and quality leadership."
    - name: "avg_order_to_report_finalized_minutes"
      expr: ROUND(AVG(CAST(UNIX_TIMESTAMP(report_finalized_timestamp) - UNIX_TIMESTAMP(ordered_timestamp) AS DOUBLE) / 60.0), 2)
      comment: "Average elapsed minutes from order placement to final report. Core radiology TAT KPI used to assess end-to-end workflow efficiency and SLA adherence."
    - name: "avg_exam_duration_minutes"
      expr: ROUND(AVG(CAST(UNIX_TIMESTAMP(exam_end_timestamp) - UNIX_TIMESTAMP(exam_start_timestamp) AS DOUBLE) / 60.0), 2)
      comment: "Average duration of the imaging exam in minutes. Used to benchmark scanner throughput and identify modality-level bottlenecks."
    - name: "avg_order_to_scheduled_minutes"
      expr: ROUND(AVG(CAST(UNIX_TIMESTAMP(scheduled_timestamp) - UNIX_TIMESTAMP(ordered_timestamp) AS DOUBLE) / 60.0), 2)
      comment: "Average time from order placement to scheduling in minutes. Measures scheduling responsiveness — a key access and throughput metric."
    - name: "portable_exam_count"
      expr: COUNT(CASE WHEN is_portable = TRUE THEN 1 END)
      comment: "Number of portable imaging exams performed. Tracks bedside imaging demand, which drives mobile equipment investment and ICU/ED staffing decisions."
    - name: "avg_radiation_dose_ctdi"
      expr: ROUND(AVG(CAST(radiation_dose_ctdi AS DOUBLE)), 4)
      comment: "Average CT Dose Index (CTDIvol) across imaging orders. Radiation safety KPI monitored by medical physicists and compliance leadership against DRL benchmarks."
    - name: "avg_radiation_dose_dlp"
      expr: ROUND(AVG(CAST(radiation_dose_dlp AS DOUBLE)), 4)
      comment: "Average Dose-Length Product (DLP) across imaging orders. Companion radiation safety KPI to CTDIvol — used for cumulative patient dose tracking and regulatory reporting."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`radiology_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Study-level performance, quality, and throughput KPIs for radiology operations. Covers study volume, reporting turnaround, radiation dose, PACS status, and critical finding notification compliance. Used by radiology directors, CMOs, and quality teams."
  source: "`healthcare_ecm`.`radiology`.`study`"
  dimensions:
    - name: "modality_id"
      expr: modality_id
      comment: "Foreign key to the modality used for the study — used to slice KPIs by imaging equipment type."
    - name: "body_part_examined"
      expr: body_part_examined
      comment: "Anatomical region examined in the study — used for protocol compliance and volume analysis by body region."
    - name: "study_status"
      expr: study_status
      comment: "Current lifecycle status of the study (SCHEDULED, IN_PROGRESS, COMPLETED, CANCELLED) — used to monitor pipeline completeness."
    - name: "report_status"
      expr: report_status
      comment: "Reporting status of the study (PRELIMINARY, FINAL, ADDENDUM, PENDING) — used to track reporting backlog and SLA compliance."
    - name: "priority"
      expr: priority
      comment: "Clinical priority of the study (STAT, ROUTINE, URGENT) — used to stratify TAT analysis by urgency tier."
    - name: "referring_department"
      expr: referring_department
      comment: "Department that referred the patient for imaging — used to identify high-volume referral sources and allocate capacity."
    - name: "patient_sex"
      expr: patient_sex
      comment: "Patient sex at time of study — used for demographic stratification of imaging volume and dose metrics."
    - name: "contrast_administered"
      expr: contrast_administered
      comment: "Boolean indicating whether contrast was administered during the study — used to track contrast utilisation rates."
    - name: "pacs_status"
      expr: pacs_status
      comment: "PACS archival status of the study — used to monitor image availability and archival compliance."
    - name: "is_external_import"
      expr: is_external_import
      comment: "Indicates whether the study was imported from an external facility — used to track outside imaging volume and reconciliation workload."
    - name: "study_month"
      expr: DATE_TRUNC('month', study_date)
      comment: "Calendar month of the study — used for monthly volume trending and seasonal demand analysis."
    - name: "study_date_day"
      expr: DATE_TRUNC('day', study_date)
      comment: "Calendar day of the study — used for daily throughput monitoring and operational dashboards."
    - name: "critical_finding_flag"
      expr: critical_finding_flag
      comment: "Boolean flag indicating a critical finding was identified — used to filter and monitor patient safety events."
  measures:
    - name: "total_studies"
      expr: COUNT(1)
      comment: "Total number of imaging studies performed. Baseline volume KPI for capacity planning, revenue forecasting, and operational benchmarking."
    - name: "completed_study_count"
      expr: COUNT(CASE WHEN study_status = 'COMPLETED' THEN 1 END)
      comment: "Number of studies with a COMPLETED status. Measures actual throughput delivered — used to assess scanner and staff productivity."
    - name: "study_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN study_status = 'COMPLETED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of studies reaching COMPLETED status. Operational efficiency KPI — low rates signal scheduling, patient prep, or equipment issues."
    - name: "critical_finding_study_count"
      expr: COUNT(CASE WHEN critical_finding_flag = TRUE THEN 1 END)
      comment: "Number of studies with a critical finding. Patient safety KPI tracked by quality and compliance leadership."
    - name: "critical_finding_notification_compliance_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_finding_flag = TRUE AND critical_finding_notified_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN critical_finding_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of critical-finding studies where notification was completed. Regulatory and patient safety compliance KPI — directly tied to accreditation requirements."
    - name: "avg_report_finalization_minutes"
      expr: ROUND(AVG(CAST(UNIX_TIMESTAMP(report_finalized_timestamp) - UNIX_TIMESTAMP(start_timestamp) AS DOUBLE) / 60.0), 2)
      comment: "Average elapsed minutes from study start to final report. Core radiology TAT KPI used by operations and quality leadership to assess reporting efficiency."
    - name: "avg_critical_finding_notification_minutes"
      expr: ROUND(AVG(CASE WHEN critical_finding_flag = TRUE THEN CAST(UNIX_TIMESTAMP(critical_finding_notified_timestamp) - UNIX_TIMESTAMP(start_timestamp) AS DOUBLE) / 60.0 END), 2)
      comment: "Average minutes from study start to critical finding notification. Patient safety and regulatory compliance KPI — benchmarked against ACR and Joint Commission standards."
    - name: "avg_radiation_dose_ctdi_vol"
      expr: ROUND(AVG(CAST(radiation_dose_ctdi_vol AS DOUBLE)), 4)
      comment: "Average CTDIvol radiation dose across studies. Radiation safety KPI monitored against Diagnostic Reference Levels (DRLs) by medical physicists and compliance teams."
    - name: "avg_radiation_dose_dlp"
      expr: ROUND(AVG(CAST(radiation_dose_dlp AS DOUBLE)), 4)
      comment: "Average Dose-Length Product (DLP) across studies. Companion radiation dose KPI used for cumulative patient dose assessment and regulatory reporting."
    - name: "total_study_size_gb"
      expr: ROUND(SUM(CAST(size_mb AS DOUBLE)) / 1024.0, 2)
      comment: "Total PACS storage consumed by studies in gigabytes. Infrastructure and cost KPI used by IT and radiology leadership to plan storage capacity and archival strategy."
    - name: "avg_study_size_mb"
      expr: ROUND(AVG(CAST(size_mb AS DOUBLE)), 2)
      comment: "Average study size in megabytes. Used to benchmark storage consumption per modality and inform PACS infrastructure investment decisions."
    - name: "stat_read_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_stat_read_completed = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN priority = 'STAT' THEN 1 END), 0), 2)
      comment: "Percentage of STAT-priority studies where the STAT read was completed. Critical SLA compliance KPI for emergency and urgent care imaging workflows."
    - name: "external_import_study_count"
      expr: COUNT(CASE WHEN is_external_import = TRUE THEN 1 END)
      comment: "Number of studies imported from external facilities. Tracks outside imaging volume, which drives reconciliation workload and care coordination resource needs."
    - name: "contrast_administered_study_count"
      expr: COUNT(CASE WHEN contrast_administered = TRUE THEN 1 END)
      comment: "Number of studies where contrast was administered. Used to track contrast utilisation rates and plan pharmacy and supply chain inventory."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`radiology_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiology report quality, turnaround, and critical finding communication KPIs. Used by radiology medical directors, quality officers, and compliance teams to monitor reporting performance, addendum rates, and patient safety notification compliance."
  source: "`healthcare_ecm`.`radiology`.`report`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Current status of the radiology report (PRELIMINARY, FINAL, ADDENDUM) — used to monitor reporting pipeline and backlog."
    - name: "modality_code"
      expr: modality_code
      comment: "Imaging modality code associated with the report — used to stratify TAT and quality KPIs by modality."
    - name: "body_part"
      expr: body_part
      comment: "Anatomical region covered by the report — used for volume and quality analysis by body region."
    - name: "rads_category"
      expr: rads_category
      comment: "Standardised reporting category (e.g., RADS score) — used to track distribution of findings severity and follow-up recommendation rates."
    - name: "critical_finding_flag"
      expr: critical_finding_flag
      comment: "Boolean flag indicating a critical finding is documented in the report — used to filter patient safety KPIs."
    - name: "stat_priority_flag"
      expr: stat_priority_flag
      comment: "Boolean flag indicating the report was prioritised as STAT — used to stratify TAT analysis by urgency."
    - name: "contrast_administered_flag"
      expr: contrast_administered_flag
      comment: "Boolean indicating contrast was administered for this study — used to correlate contrast use with reporting patterns."
    - name: "laterality"
      expr: laterality
      comment: "Laterality of the study (LEFT, RIGHT, BILATERAL) — used for anatomical completeness and quality audits."
    - name: "study_month"
      expr: DATE_TRUNC('month', study_datetime)
      comment: "Calendar month of the study — used for monthly reporting volume and TAT trend analysis."
    - name: "addendum_type"
      expr: addendum_type
      comment: "Type of addendum appended to the report — used to categorise correction and clarification patterns for quality improvement."
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total number of radiology reports generated. Baseline reporting volume KPI used to assess radiologist productivity and reporting pipeline throughput."
    - name: "finalized_report_count"
      expr: COUNT(CASE WHEN report_status = 'FINAL' THEN 1 END)
      comment: "Number of reports in FINAL status. Measures completed reporting output — used to track radiologist productivity and billing readiness."
    - name: "report_finalization_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN report_status = 'FINAL' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports that have been finalised. Reporting pipeline health KPI — low rates indicate dictation or attestation bottlenecks."
    - name: "addendum_report_count"
      expr: COUNT(CASE WHEN addendum_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of reports that received an addendum. Quality KPI — high addendum rates may indicate initial reporting errors, incomplete studies, or clinical follow-up needs."
    - name: "addendum_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN addendum_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports requiring an addendum. Radiology quality KPI monitored by medical directors — elevated rates trigger peer review and quality improvement initiatives."
    - name: "critical_finding_report_count"
      expr: COUNT(CASE WHEN critical_finding_flag = TRUE THEN 1 END)
      comment: "Number of reports documenting a critical finding. Patient safety volume KPI used to size notification workflows and compliance monitoring programs."
    - name: "critical_finding_communication_compliance_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_finding_flag = TRUE AND critical_finding_communicated_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN critical_finding_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of critical-finding reports where communication to the ordering provider was completed. Regulatory compliance KPI — directly tied to Joint Commission and ACR accreditation standards."
    - name: "avg_dictation_to_final_minutes"
      expr: ROUND(AVG(CAST(UNIX_TIMESTAMP(attestation_timestamp) - UNIX_TIMESTAMP(dictation_timestamp) AS DOUBLE) / 60.0), 2)
      comment: "Average minutes from dictation to final attestation. Radiologist workflow efficiency KPI — used to identify attestation bottlenecks and optimise transcription/AI-assist workflows."
    - name: "avg_study_to_preliminary_minutes"
      expr: ROUND(AVG(CAST(UNIX_TIMESTAMP(preliminary_timestamp) - UNIX_TIMESTAMP(study_datetime) AS DOUBLE) / 60.0), 2)
      comment: "Average minutes from study acquisition to preliminary report. Measures initial read speed — a key SLA metric for STAT and urgent studies."
    - name: "avg_study_to_final_report_minutes"
      expr: ROUND(AVG(CAST(UNIX_TIMESTAMP(attestation_timestamp) - UNIX_TIMESTAMP(study_datetime) AS DOUBLE) / 60.0), 2)
      comment: "Average end-to-end turnaround time from study acquisition to final report in minutes. Primary radiology TAT KPI used in operational reviews and benchmarked against ACR standards."
    - name: "avg_critical_finding_communication_minutes"
      expr: ROUND(AVG(CASE WHEN critical_finding_flag = TRUE THEN CAST(UNIX_TIMESTAMP(critical_finding_communicated_timestamp) - UNIX_TIMESTAMP(study_datetime) AS DOUBLE) / 60.0 END), 2)
      comment: "Average minutes from study acquisition to critical finding communication. Patient safety SLA KPI — monitored against regulatory thresholds (typically 60 minutes for life-threatening findings)."
    - name: "avg_radiation_dose_ctdi"
      expr: ROUND(AVG(CAST(radiation_dose_ctdi AS DOUBLE)), 4)
      comment: "Average CTDIvol radiation dose documented in reports. Radiation safety KPI cross-referenced with dose records for compliance and DRL benchmarking."
    - name: "stat_report_count"
      expr: COUNT(CASE WHEN stat_priority_flag = TRUE THEN 1 END)
      comment: "Number of STAT-priority reports. Used to monitor urgent reporting workload and ensure radiologist capacity meets STAT SLA commitments."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`radiology_dose_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiation dose safety and compliance KPIs derived from structured dose records. Used by medical physicists, radiation safety officers, and compliance leadership to monitor dose levels against Diagnostic Reference Levels (DRLs), track dose alerts, and support regulatory dose registry submissions."
  source: "`healthcare_ecm`.`radiology`.`dose_record`"
  dimensions:
    - name: "modality_type"
      expr: modality_type
      comment: "Imaging modality type (CT, Fluoroscopy, X-Ray, etc.) — primary slice for dose benchmarking against modality-specific DRLs."
    - name: "body_part_examined"
      expr: body_part_examined
      comment: "Anatomical region examined — used to stratify dose metrics by body region for DRL comparison and protocol optimisation."
    - name: "dose_alert_flag"
      expr: dose_alert_flag
      comment: "Boolean flag indicating the dose exceeded an alert threshold — used to filter and monitor high-dose events."
    - name: "dose_alert_threshold_type"
      expr: dose_alert_threshold_type
      comment: "Type of dose alert threshold triggered (e.g., DRL, institutional, regulatory) — used to categorise alert severity."
    - name: "contrast_administered"
      expr: contrast_administered
      comment: "Boolean indicating whether contrast was administered — used to stratify dose metrics by contrast use."
    - name: "physicist_review_flag"
      expr: physicist_review_flag
      comment: "Boolean indicating whether a medical physicist reviewed the dose record — used to track review compliance for high-dose events."
    - name: "dose_registry_submission_status"
      expr: dose_registry_submission_status
      comment: "Status of dose registry submission (SUBMITTED, PENDING, FAILED) — used to monitor regulatory reporting compliance."
    - name: "dose_record_status"
      expr: dose_record_status
      comment: "Lifecycle status of the dose record — used to filter active vs. voided records in dose analysis."
    - name: "study_month"
      expr: DATE_TRUNC('month', study_date)
      comment: "Calendar month of the study — used for monthly dose trend analysis and regulatory period reporting."
    - name: "drl_comparison_result"
      expr: drl_comparison_result
      comment: "Result of comparison against the Diagnostic Reference Level (ABOVE, BELOW, AT) — used to monitor DRL exceedance rates."
  measures:
    - name: "total_dose_records"
      expr: COUNT(1)
      comment: "Total number of dose records. Baseline volume KPI for dose monitoring program coverage — used to assess completeness of dose capture across modalities."
    - name: "dose_alert_count"
      expr: COUNT(CASE WHEN dose_alert_flag = TRUE THEN 1 END)
      comment: "Number of studies where radiation dose exceeded an alert threshold. Patient safety KPI — high counts trigger immediate physicist review and protocol optimisation."
    - name: "dose_alert_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dose_alert_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dose records triggering a dose alert. Radiation safety KPI benchmarked against institutional and national DRL thresholds — monitored by radiation safety officers."
    - name: "drl_exceedance_count"
      expr: COUNT(CASE WHEN drl_comparison_result = 'ABOVE' THEN 1 END)
      comment: "Number of studies where dose exceeded the Diagnostic Reference Level. Regulatory compliance KPI — persistent exceedance triggers protocol review and equipment calibration audits."
    - name: "drl_exceedance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN drl_comparison_result = 'ABOVE' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of studies exceeding the DRL. Primary radiation safety compliance KPI reported to accreditation bodies and used to benchmark against national dose registries."
    - name: "physicist_review_pending_count"
      expr: COUNT(CASE WHEN dose_alert_flag = TRUE AND physicist_review_flag = FALSE THEN 1 END)
      comment: "Number of dose-alert studies awaiting physicist review. Operational safety KPI — unreviewed high-dose events represent open patient safety risks and compliance gaps."
    - name: "dose_registry_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dose_registry_submission_status = 'SUBMITTED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dose records successfully submitted to the dose registry. Regulatory compliance KPI — submission rates below 95% trigger corrective action under ACR DIR and state reporting mandates."
    - name: "avg_ctdivol_mgy"
      expr: ROUND(AVG(CAST(ctdivol_mgy AS DOUBLE)), 4)
      comment: "Average CT Volume Dose Index (CTDIvol) in mGy. Primary CT radiation dose KPI benchmarked against ACR and NCRP Diagnostic Reference Levels."
    - name: "avg_dlp_mgy_cm"
      expr: ROUND(AVG(CAST(dlp_mgy_cm AS DOUBLE)), 4)
      comment: "Average Dose-Length Product (DLP) in mGy·cm. Companion CT dose KPI to CTDIvol — used for effective dose estimation and cumulative patient dose tracking."
    - name: "avg_effective_dose_msv"
      expr: ROUND(AVG(CAST(effective_dose_msv AS DOUBLE)), 4)
      comment: "Average effective dose in millisieverts (mSv). Whole-body risk-equivalent dose KPI used for patient dose counselling, cumulative dose tracking, and population-level radiation risk assessment."
    - name: "avg_cumulative_dose_msv"
      expr: ROUND(AVG(CAST(cumulative_dose_msv AS DOUBLE)), 4)
      comment: "Average cumulative radiation dose in mSv per dose record. Used to identify patients with high cumulative exposure who may require dose management intervention."
    - name: "avg_fluoroscopy_time_sec"
      expr: ROUND(AVG(CAST(fluoroscopy_time_sec AS DOUBLE)), 2)
      comment: "Average fluoroscopy time in seconds. Interventional radiology dose proxy KPI — prolonged fluoroscopy times are associated with elevated skin dose and are monitored for radiation safety compliance."
    - name: "avg_ssde_mgy"
      expr: ROUND(AVG(CAST(ssde_mgy AS DOUBLE)), 4)
      comment: "Average Size-Specific Dose Estimate (SSDE) in mGy. Patient-size-adjusted CT dose KPI — more accurate than CTDIvol for individual patient dose assessment and paediatric dose monitoring."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`radiology_contrast_admin`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contrast agent administration safety, adverse reaction, and protocol compliance KPIs. Used by radiology safety officers, pharmacy leadership, and quality teams to monitor adverse reaction rates, extravasation events, consent compliance, and contrast dose optimisation."
  source: "`healthcare_ecm`.`radiology`.`contrast_admin`"
  dimensions:
    - name: "modality"
      expr: modality
      comment: "Imaging modality for which contrast was administered — used to stratify adverse reaction and dose metrics by modality."
    - name: "agent_class"
      expr: agent_class
      comment: "Class of contrast agent (iodinated, gadolinium, barium, etc.) — used to monitor adverse reaction rates by agent class."
    - name: "agent_osmolality_type"
      expr: agent_osmolality_type
      comment: "Osmolality type of the contrast agent (iso-osmolar, low-osmolar, high-osmolar) — used to correlate osmolality with adverse reaction rates."
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route by which contrast was administered (IV, oral, intrathecal) — used to stratify safety metrics by administration route."
    - name: "adverse_reaction_occurred"
      expr: adverse_reaction_occurred
      comment: "Boolean flag indicating an adverse reaction occurred — used to filter and monitor contrast safety events."
    - name: "adverse_reaction_severity"
      expr: adverse_reaction_severity
      comment: "Severity of the adverse reaction (MILD, MODERATE, SEVERE, LIFE_THREATENING) — used to stratify safety KPIs by clinical impact."
    - name: "extravasation_occurred"
      expr: extravasation_occurred
      comment: "Boolean flag indicating contrast extravasation occurred — used to monitor injection technique quality and equipment performance."
    - name: "body_region"
      expr: body_region
      comment: "Body region where contrast was administered — used for anatomical stratification of dose and safety metrics."
    - name: "premedication_given"
      expr: premedication_given
      comment: "Boolean indicating whether premedication was administered prior to contrast — used to assess premedication protocol compliance and effectiveness."
    - name: "administration_month"
      expr: DATE_TRUNC('month', administration_datetime)
      comment: "Calendar month of contrast administration — used for monthly safety trend analysis and adverse event reporting."
    - name: "pregnancy_status"
      expr: pregnancy_status
      comment: "Patient pregnancy status at time of contrast administration — used to monitor contrast safety protocol compliance for pregnant patients."
    - name: "administration_status"
      expr: administration_status
      comment: "Status of the contrast administration event (COMPLETED, ABORTED, PARTIAL) — used to track administration completion rates."
  measures:
    - name: "total_contrast_administrations"
      expr: COUNT(1)
      comment: "Total number of contrast administrations. Baseline volume KPI for contrast utilisation monitoring, inventory planning, and safety program sizing."
    - name: "adverse_reaction_count"
      expr: COUNT(CASE WHEN adverse_reaction_occurred = TRUE THEN 1 END)
      comment: "Number of contrast administrations resulting in an adverse reaction. Patient safety KPI — tracked by radiology safety officers and reported to pharmacy and therapeutics committees."
    - name: "adverse_reaction_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN adverse_reaction_occurred = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contrast administrations resulting in an adverse reaction. Primary contrast safety KPI — benchmarked against published literature rates (typically 0.5–3% for iodinated agents)."
    - name: "severe_adverse_reaction_count"
      expr: COUNT(CASE WHEN adverse_reaction_severity IN ('SEVERE', 'LIFE_THREATENING') THEN 1 END)
      comment: "Number of severe or life-threatening adverse reactions. Critical patient safety KPI — each event triggers mandatory incident review and may require regulatory reporting."
    - name: "extravasation_count"
      expr: COUNT(CASE WHEN extravasation_occurred = TRUE THEN 1 END)
      comment: "Number of contrast extravasation events. Quality and safety KPI — high rates indicate injection technique or equipment issues requiring corrective action."
    - name: "extravasation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN extravasation_occurred = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contrast administrations resulting in extravasation. Injection quality KPI monitored by radiology nursing leadership — benchmarked against institutional and published rates."
    - name: "avg_extravasation_volume_ml"
      expr: ROUND(AVG(CASE WHEN extravasation_occurred = TRUE THEN extravasation_volume_ml END), 2)
      comment: "Average volume of extravasated contrast in mL. Severity proxy for extravasation events — larger volumes are associated with greater tissue injury and drive escalation protocols."
    - name: "informed_consent_compliance_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN informed_consent_obtained = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contrast administrations where informed consent was documented. Regulatory and accreditation compliance KPI — non-compliance triggers corrective action under Joint Commission standards."
    - name: "premedication_compliance_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN premedication_given = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN prior_contrast_reaction_type IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of patients with a prior contrast reaction history who received premedication. Protocol compliance KPI — non-compliance with premedication protocols is a patient safety risk and accreditation finding."
    - name: "avg_dose_volume_ml"
      expr: ROUND(AVG(CAST(dose_volume_ml AS DOUBLE)), 2)
      comment: "Average contrast dose volume in mL. Dose optimisation KPI — used to benchmark actual doses against protocol targets and identify over-dosing patterns."
    - name: "avg_dose_amount_mg"
      expr: ROUND(AVG(CAST(dose_amount_mg AS DOUBLE)), 2)
      comment: "Average contrast dose amount in mg. Used alongside dose volume to assess weight-based dosing compliance and protocol adherence."
    - name: "avg_injection_rate_ml_per_sec"
      expr: ROUND(AVG(CAST(injection_rate_ml_per_sec AS DOUBLE)), 2)
      comment: "Average contrast injection rate in mL/sec. Technical quality KPI — deviations from protocol injection rates affect image quality and are monitored for protocol compliance."
    - name: "metformin_held_compliance_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN metformin_held = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN thyroid_disease_flag = FALSE THEN 1 END), 0), 2)
      comment: "Percentage of applicable contrast administrations where metformin was appropriately held. Medication safety compliance KPI — failure to hold metformin before iodinated contrast is a known risk for contrast-induced nephropathy."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`radiology_critical_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Critical finding notification timeliness, escalation, and communication compliance KPIs. Used by radiology medical directors, patient safety officers, and compliance teams to monitor adherence to critical result notification standards and identify systemic communication failures."
  source: "`healthcare_ecm`.`radiology`.`critical_result`"
  dimensions:
    - name: "modality"
      expr: modality
      comment: "Imaging modality associated with the critical result — used to stratify notification KPIs by modality."
    - name: "finding_category"
      expr: finding_category
      comment: "Clinical category of the critical finding (e.g., PULMONARY_EMBOLISM, INTRACRANIAL_HEMORRHAGE) — used to monitor notification compliance by finding type."
    - name: "finding_severity"
      expr: finding_severity
      comment: "Severity tier of the critical finding — used to stratify notification timeliness KPIs by clinical urgency."
    - name: "notification_status"
      expr: notification_status
      comment: "Current status of the critical result notification (NOTIFIED, PENDING, FAILED, ESCALATED) — used to monitor open notification obligations."
    - name: "notification_method"
      expr: notification_method
      comment: "Method used to communicate the critical result (phone, secure message, in-person) — used to assess communication channel effectiveness."
    - name: "acknowledgment_method"
      expr: acknowledgment_method
      comment: "Method by which the receiving provider acknowledged the critical result — used to verify read-back compliance."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Boolean indicating whether the notification required escalation — used to monitor escalation rates and identify systemic notification failures."
    - name: "patient_care_setting"
      expr: patient_care_setting
      comment: "Care setting of the patient at time of critical result (ICU, ED, INPATIENT, OUTPATIENT) — used to stratify notification KPIs by care context."
    - name: "read_back_performed"
      expr: read_back_performed
      comment: "Boolean indicating whether a read-back was performed to confirm the critical result communication — used to monitor read-back compliance."
    - name: "emtala_applicable"
      expr: emtala_applicable
      comment: "Boolean indicating EMTALA applicability — used to flag critical results with federal regulatory notification obligations."
    - name: "finding_month"
      expr: DATE_TRUNC('month', finding_datetime)
      comment: "Calendar month of the critical finding — used for monthly trend analysis of critical result volumes and notification compliance."
    - name: "patient_safety_event_flag"
      expr: patient_safety_event_flag
      comment: "Boolean indicating the critical result was associated with a patient safety event — used to monitor safety event rates linked to notification failures."
  measures:
    - name: "total_critical_results"
      expr: COUNT(1)
      comment: "Total number of critical results identified. Baseline volume KPI for patient safety program sizing and notification workflow capacity planning."
    - name: "notified_critical_result_count"
      expr: COUNT(CASE WHEN notification_status = 'NOTIFIED' THEN 1 END)
      comment: "Number of critical results where notification was successfully completed. Measures notification program effectiveness — used to track compliance with ACR and Joint Commission standards."
    - name: "notification_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN notification_status = 'NOTIFIED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of critical results with completed notification. Primary patient safety compliance KPI — rates below 95% trigger immediate corrective action and may affect accreditation status."
    - name: "escalation_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of critical results requiring escalation due to failed initial notification. Patient safety KPI — high escalation counts indicate systemic communication failures in the notification workflow."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of critical results requiring escalation. Notification workflow quality KPI — elevated rates drive investigation into provider availability, contact information accuracy, and escalation protocol design."
    - name: "read_back_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN read_back_performed = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN notification_status = 'NOTIFIED' THEN 1 END), 0), 2)
      comment: "Percentage of notified critical results where a read-back was performed. Joint Commission NPSG compliance KPI — read-back is a required element of critical result communication in accredited facilities."
    - name: "patient_safety_event_count"
      expr: COUNT(CASE WHEN patient_safety_event_flag = TRUE THEN 1 END)
      comment: "Number of critical results associated with a patient safety event. Highest-severity patient safety KPI — each event requires root cause analysis and may trigger regulatory reporting obligations."
    - name: "avg_notification_turnaround_minutes"
      expr: ROUND(AVG(CAST(notification_turnaround_minutes AS DOUBLE)), 2)
      comment: "Average minutes from critical finding identification to provider notification. Primary timeliness KPI for critical result programs — benchmarked against institutional and regulatory thresholds (typically 30–60 minutes)."
    - name: "avg_acknowledgment_turnaround_minutes"
      expr: ROUND(AVG(CAST(acknowledgment_turnaround_minutes AS DOUBLE)), 2)
      comment: "Average minutes from notification to provider acknowledgment. Measures provider responsiveness to critical results — prolonged acknowledgment times are a patient safety risk and compliance concern."
    - name: "avg_notification_attempt_count"
      expr: ROUND(AVG(CAST(notification_attempt_count AS DOUBLE)), 2)
      comment: "Average number of notification attempts required per critical result. Workflow efficiency KPI — high attempt counts indicate provider contact information gaps or availability issues requiring systemic remediation."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`radiology_modality`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiology equipment fleet health, maintenance compliance, and capacity KPIs. Used by radiology operations directors, biomedical engineering, and facilities leadership to monitor scanner availability, maintenance schedules, and equipment lifecycle management."
  source: "`healthcare_ecm`.`radiology`.`modality`"
  dimensions:
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of imaging equipment (CT, MRI, X-Ray, Ultrasound, PET, etc.) — primary slice for fleet analysis and capacity planning."
    - name: "manufacturer"
      expr: manufacturer
      comment: "Equipment manufacturer — used to stratify maintenance and downtime KPIs by vendor for contract performance management."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the modality (ACTIVE, INACTIVE, UNDER_MAINTENANCE, DECOMMISSIONED) — used to monitor fleet availability."
    - name: "is_mobile"
      expr: is_mobile
      comment: "Boolean indicating whether the modality is a mobile/portable unit — used to track mobile fleet size and deployment."
    - name: "radiation_emitting"
      expr: radiation_emitting
      comment: "Boolean indicating whether the modality emits ionising radiation — used to stratify fleet for radiation safety compliance monitoring."
    - name: "dose_tracking_enabled"
      expr: dose_tracking_enabled
      comment: "Boolean indicating whether automated dose tracking is enabled — used to monitor dose capture completeness across the fleet."
    - name: "contrast_capable"
      expr: contrast_capable
      comment: "Boolean indicating whether the modality supports contrast-enhanced imaging — used for contrast capacity planning."
    - name: "shared_service_indicator"
      expr: shared_service_indicator
      comment: "Boolean indicating whether the modality is shared across multiple service lines or facilities — used for utilisation and cost allocation analysis."
    - name: "installation_year"
      expr: DATE_TRUNC('year', installation_date)
      comment: "Year of equipment installation — used for fleet age analysis and capital replacement planning."
  measures:
    - name: "total_modalities"
      expr: COUNT(1)
      comment: "Total number of imaging modalities in the fleet. Baseline fleet size KPI used for capacity planning and capital investment benchmarking."
    - name: "active_modality_count"
      expr: COUNT(CASE WHEN operational_status = 'ACTIVE' THEN 1 END)
      comment: "Number of modalities currently in active operational status. Fleet availability KPI — directly drives imaging capacity and scheduling throughput."
    - name: "fleet_availability_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN operational_status = 'ACTIVE' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of the imaging fleet in active operational status. Equipment uptime KPI — low rates indicate maintenance backlogs or equipment reliability issues requiring capital or service contract intervention."
    - name: "dose_tracking_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dose_tracking_enabled = TRUE AND radiation_emitting = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN radiation_emitting = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of radiation-emitting modalities with dose tracking enabled. Radiation safety compliance KPI — gaps in dose tracking coverage create regulatory reporting blind spots and patient safety risks."
    - name: "overdue_calibration_count"
      expr: COUNT(CASE WHEN next_calibration_due_date < CURRENT_DATE AND operational_status = 'ACTIVE' THEN 1 END)
      comment: "Number of active modalities with overdue calibration. Regulatory compliance KPI — uncalibrated equipment produces inaccurate images and dose measurements, creating patient safety and accreditation risks."
    - name: "overdue_preventive_maintenance_count"
      expr: COUNT(CASE WHEN next_preventive_maintenance_date < CURRENT_DATE AND operational_status = 'ACTIVE' THEN 1 END)
      comment: "Number of active modalities with overdue preventive maintenance. Equipment reliability KPI — overdue PM is associated with increased unplanned downtime and service costs."
    - name: "avg_scheduled_hours_per_day"
      expr: ROUND(AVG(CAST(scheduled_hours_per_day AS DOUBLE)), 2)
      comment: "Average scheduled operating hours per day across the fleet. Capacity utilisation baseline KPI — used to benchmark against actual throughput and identify under-utilised or over-scheduled equipment."
    - name: "avg_bore_diameter_cm"
      expr: ROUND(AVG(CAST(bore_diameter_cm AS DOUBLE)), 2)
      comment: "Average bore diameter in cm across the fleet. Equipment capability KPI — used to assess fleet suitability for bariatric and claustrophobic patient populations."
    - name: "avg_max_patient_weight_kg"
      expr: ROUND(AVG(CAST(max_patient_weight_kg AS DOUBLE)), 2)
      comment: "Average maximum patient weight capacity across the fleet. Accessibility KPI — used to assess fleet capability to serve bariatric patients and inform capital replacement decisions."
    - name: "mobile_modality_count"
      expr: COUNT(CASE WHEN is_mobile = TRUE THEN 1 END)
      comment: "Number of mobile/portable imaging units in the fleet. Capacity planning KPI for bedside imaging programs — used to assess mobile fleet adequacy for ICU, ED, and inpatient demand."
$$;