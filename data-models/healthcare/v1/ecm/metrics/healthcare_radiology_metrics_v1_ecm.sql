-- Metric views for domain: radiology | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 16:32:35

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`radiology_imaging_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for imaging orders, covering volume, contrast usage, and radiation dose."
  source: "`healthcare_ecm`.`radiology`.`imaging_order`"
  dimensions:
    - name: "modality_type"
      expr: modality_type
      comment: "Imaging modality (e.g., CT, MRI)."
    - name: "body_part"
      expr: body_part
      comment: "Anatomical body part examined."
    - name: "order_status"
      expr: order_status
      comment: "Current status of the imaging order."
    - name: "order_priority"
      expr: order_priority
      comment: "Priority level of the order (e.g., routine, stat)."
    - name: "order_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the order was created."
    - name: "care_site_id"
      expr: care_site_id
      comment: "Identifier of the care site where order originated."
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of imaging orders."
    - name: "contrast_orders"
      expr: COUNT(CASE WHEN contrast_required THEN 1 END)
      comment: "Number of orders requiring contrast."
    - name: "contrast_required_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN contrast_required THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percentage of orders that require contrast."
    - name: "avg_ctdi"
      expr: AVG(CAST(radiation_dose_ctdi AS DOUBLE))
      comment: "Average CTDI radiation dose per order."
    - name: "avg_dlp"
      expr: AVG(CAST(radiation_dose_dlp AS DOUBLE))
      comment: "Average DLP radiation dose per order."
    - name: "total_ctdi"
      expr: SUM(CAST(radiation_dose_ctdi AS DOUBLE))
      comment: "Total CTDI radiation dose across orders."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`radiology_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Study-level metrics focusing on volume, critical findings, and radiation exposure."
  source: "`healthcare_ecm`.`radiology`.`radiology_study`"
  dimensions:
    - name: "modality_id"
      expr: modality_id
      comment: "Identifier of the imaging modality used."
    - name: "body_part_examined"
      expr: body_part_examined
      comment: "Body part examined in the study."
    - name: "study_date"
      expr: DATE_TRUNC('day', study_date)
      comment: "Date of the study."
    - name: "critical_finding_flag"
      expr: critical_finding_flag
      comment: "Indicates if the study contains a critical finding."
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where the study was performed."
  measures:
    - name: "total_studies"
      expr: COUNT(1)
      comment: "Total number of radiology studies."
    - name: "critical_finding_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_finding_flag THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percentage of studies with critical findings."
    - name: "avg_ctdi_vol"
      expr: AVG(CAST(radiation_dose_ctdi_vol AS DOUBLE))
      comment: "Average CTDI volume dose per study."
    - name: "total_ctdi_vol"
      expr: SUM(CAST(radiation_dose_ctdi_vol AS DOUBLE))
      comment: "Total CTDI volume dose across studies."
    - name: "avg_study_size_mb"
      expr: AVG(CAST(size_mb AS DOUBLE))
      comment: "Average size of study files in megabytes."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`radiology_dose_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiation dose record metrics for monitoring patient exposure and safety alerts."
  source: "`healthcare_ecm`.`radiology`.`dose_record`"
  dimensions:
    - name: "modality_type"
      expr: modality_type
      comment: "Modality type associated with the dose record."
    - name: "dose_record_status"
      expr: dose_record_status
      comment: "Status of the dose record (e.g., finalized, pending)."
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where dose was recorded."
    - name: "record_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the dose record was created."
  measures:
    - name: "total_dose_records"
      expr: COUNT(1)
      comment: "Total number of dose records captured."
    - name: "total_effective_dose_msv"
      expr: SUM(CAST(effective_dose_msv AS DOUBLE))
      comment: "Cumulative effective dose (mSv) across all records."
    - name: "avg_effective_dose_msv"
      expr: AVG(CAST(effective_dose_msv AS DOUBLE))
      comment: "Average effective dose per record."
    - name: "dose_alert_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dose_alert_flag THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percentage of dose records that triggered an alert."
    - name: "total_dap_gy_cm2"
      expr: SUM(CAST(dap_gy_cm2 AS DOUBLE))
      comment: "Total DAP (dose-area product) across records."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`radiology_contrast_admin`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics on contrast administration events, safety incidents, and dosing."
  source: "`healthcare_ecm`.`radiology`.`contrast_admin`"
  dimensions:
    - name: "modality"
      expr: modality
      comment: "Modality used for the contrast administration."
    - name: "contrast_protocol_name"
      expr: contrast_protocol_name
      comment: "Name of the contrast protocol applied."
    - name: "administration_status"
      expr: administration_status
      comment: "Status of the contrast administration (e.g., completed)."
    - name: "adverse_reaction_occurred"
      expr: adverse_reaction_occurred
      comment: "Indicates if an adverse reaction occurred."
    - name: "admin_date"
      expr: DATE_TRUNC('day', administration_datetime)
      comment: "Date of contrast administration."
  measures:
    - name: "total_contrast_admins"
      expr: COUNT(1)
      comment: "Total number of contrast administrations performed."
    - name: "adverse_reaction_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN adverse_reaction_occurred THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percentage of administrations with adverse reactions."
    - name: "avg_dose_amount_mg"
      expr: AVG(CAST(dose_amount_mg AS DOUBLE))
      comment: "Average contrast dose amount in mg."
    - name: "avg_injection_rate_ml_per_sec"
      expr: AVG(CAST(injection_rate_ml_per_sec AS DOUBLE))
      comment: "Average injection rate for contrast administrations."
    - name: "extravasation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN extravasation_occurred THEN 1 END) / NULLIF(COUNT(1),0),2)
      comment: "Percentage of administrations with extravasation events."
$$;