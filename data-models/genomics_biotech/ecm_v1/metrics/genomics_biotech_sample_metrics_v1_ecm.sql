-- Metric views for domain: sample | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 12:58:41

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`sample_accession`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core accession KPIs: throughput, volume, GxP compliance, and processing speed"
  source: "`genomics_biotech_ecm`.`sample`.`accession`"
  dimensions:
    - name: "accession_status"
      expr: accession_status
      comment: "Current status of the accession (e.g., received, processing, completed)"
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of specimen (e.g., blood, tissue, saliva)"
    - name: "priority_level"
      expr: priority_level
      comment: "Business priority assigned to the sample"
    - name: "collection_site"
      expr: collection_site
      comment: "Site where the specimen was collected"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the accession record was created"
  measures:
    - name: "total_samples"
      expr: COUNT(1)
      comment: "Total number of accession records (samples) received"
    - name: "total_volume_received_ml"
      expr: SUM(CAST(volume_received_ml AS DOUBLE))
      comment: "Sum of volume received (ml) across all accessions"
    - name: "total_gxp_applicable"
      expr: SUM(CASE WHEN gxp_applicable_flag THEN 1 ELSE 0 END)
      comment: "Count of accessions flagged as GxP applicable"
    - name: "avg_turnaround_hours"
      expr: AVG(unix_timestamp(receipt_timestamp) - unix_timestamp(accessioning_timestamp)) / 3600
      comment: "Average turnaround time from accessioning to receipt in hours"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`sample_aliquot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aliquot quality and yield metrics for downstream assays"
  source: "`genomics_biotech_ecm`.`sample`.`aliquot`"
  dimensions:
    - name: "aliquot_type"
      expr: aliquot_type
      comment: "Classification of aliquot (e.g., DNA, RNA, plasma)"
    - name: "specimen_type"
      expr: specimen_type
      comment: "Original specimen type the aliquot derives from"
    - name: "container_status"
      expr: container_status
      comment: "Current status of the aliquot container"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle stage of the aliquot (e.g., active, archived, disposed)"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the aliquot record was created"
  measures:
    - name: "total_aliquots"
      expr: COUNT(1)
      comment: "Total number of aliquots created"
    - name: "avg_dna_integrity_number"
      expr: AVG(CAST(dna_integrity_number AS DOUBLE))
      comment: "Average DNA Integrity Number (DIN) across aliquots"
    - name: "avg_rin_score"
      expr: AVG(CAST(rin_score AS DOUBLE))
      comment: "Average RNA Integrity Number (RIN) across aliquots"
    - name: "avg_concentration_ng_ul"
      expr: AVG(CAST(concentration AS DOUBLE))
      comment: "Average nucleic acid concentration (ng/µL) across aliquots"
    - name: "total_volume_ul"
      expr: SUM(CAST(volume_ul AS DOUBLE))
      comment: "Total volume (µL) of all aliquots"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`sample_extraction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Extraction efficiency and quality control metrics"
  source: "`genomics_biotech_ecm`.`sample`.`extraction`"
  dimensions:
    - name: "extraction_method"
      expr: extraction_method
      comment: "Method used for nucleic acid extraction"
    - name: "nucleic_acid_type"
      expr: nucleic_acid_type
      comment: "Type of nucleic acid extracted (DNA, RNA, etc.)"
    - name: "qc_status"
      expr: qc_status
      comment: "Quality control status of the extraction"
    - name: "contamination_flag"
      expr: contamination_flag
      comment: "Boolean flag indicating contamination detected"
    - name: "extraction_date"
      expr: DATE_TRUNC('day', extraction_date)
      comment: "Date the extraction was performed"
  measures:
    - name: "total_extractions"
      expr: COUNT(1)
      comment: "Total number of extraction events performed"
    - name: "total_yield_ng"
      expr: SUM(CAST(total_yield_ng AS DOUBLE))
      comment: "Aggregate nucleic acid yield (ng) from all extractions"
    - name: "avg_input_mass_mg"
      expr: AVG(CAST(input_mass_mg AS DOUBLE))
      comment: "Average input material mass (mg) per extraction"
    - name: "contamination_count"
      expr: SUM(CASE WHEN contamination_flag THEN 1 ELSE 0 END)
      comment: "Number of extractions flagged with contamination"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`sample_shipment_manifest`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment logistics and temperature control KPIs"
  source: "`genomics_biotech_ecm`.`sample`.`shipment_manifest`"
  dimensions:
    - name: "shipment_type"
      expr: shipment_type
      comment: "Classification of shipment (e.g., inbound, outbound, internal)"
    - name: "carrier_name"
      expr: carrier_name
      comment: "Logistics carrier handling the shipment"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "ISO country code of shipment destination"
    - name: "phi_deidentified_flag"
      expr: phi_deidentified_flag
      comment: "Indicates if PHI was de‑identified for the shipment"
    - name: "shipped_date"
      expr: DATE_TRUNC('day', shipped_date)
      comment: "Date the shipment left the origin"
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipment manifests created"
    - name: "total_dry_ice_weight_kg"
      expr: SUM(CAST(dry_ice_weight_kg AS DOUBLE))
      comment: "Aggregate dry ice weight (kg) used for shipments"
    - name: "avg_temp_max_c"
      expr: AVG(CAST(temp_max_c AS DOUBLE))
      comment: "Average maximum temperature recorded during shipment (°C)"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`sample_storage_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage handling and temperature compliance metrics"
  source: "`genomics_biotech_ecm`.`sample`.`storage_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of storage event (e.g., move, freeze, thaw)"
    - name: "storage_condition_code"
      expr: storage_condition_code
      comment: "Code describing required storage condition"
    - name: "primary_storage_biobank_location_id"
      expr: primary_storage_biobank_location_id
      comment: "Identifier of the primary biobank location"
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date the storage event occurred"
  measures:
    - name: "total_storage_events"
      expr: COUNT(1)
      comment: "Total number of storage events recorded"
    - name: "total_specimen_volume_ul"
      expr: SUM(CAST(specimen_volume_ul AS DOUBLE))
      comment: "Cumulative specimen volume (µL) moved or stored"
    - name: "avg_temperature_at_event_c"
      expr: AVG(CAST(temperature_at_event_c AS DOUBLE))
      comment: "Average temperature (°C) at the time of storage events"
$$;