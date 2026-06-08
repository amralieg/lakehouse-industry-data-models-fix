-- Metric views for domain: facility | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 16:32:35

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`facility_bed_occupancy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks bed occupancy trends using periodic capacity snapshots"
  source: "`healthcare_ecm`.`facility`.`capacity_snapshot`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Identifier of the care site (hospital/clinic)"
    - name: "building_id"
      expr: building_id
      comment: "Identifier of the building containing the care site"
    - name: "snapshot_date"
      expr: DATE_TRUNC('day', snapshot_timestamp)
      comment: "Date of the capacity snapshot"
  measures:
    - name: "avg_occupancy_pct"
      expr: AVG(CAST(occupancy_percentage AS DOUBLE))
      comment: "Average occupancy percentage across snapshots for the selected period"
    - name: "snapshot_count"
      expr: COUNT(1)
      comment: "Number of capacity snapshot records"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`facility_bed_status_events`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational view of bed status changes to monitor utilization and flow"
  source: "`healthcare_ecm`.`facility`.`bed_status_event`"
  dimensions:
    - name: "bed_id"
      expr: bed_id
      comment: "Unique identifier for the bed"
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where the bed is located"
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of the bed status event"
    - name: "new_status_code"
      expr: new_status_code
      comment: "Resulting status code after the event"
  measures:
    - name: "total_status_events"
      expr: COUNT(1)
      comment: "Total number of bed status events recorded"
    - name: "elective_event_count"
      expr: SUM(CASE WHEN is_elective_flag THEN 1 ELSE 0 END)
      comment: "Count of elective bed status events"
    - name: "emergency_event_count"
      expr: SUM(CASE WHEN is_emergency_flag THEN 1 ELSE 0 END)
      comment: "Count of emergency bed status events"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`facility_maintenance_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial view of maintenance activities to support cost control"
  source: "`healthcare_ecm`.`facility`.`maintenance_order`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where maintenance was performed"
    - name: "order_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of the maintenance order creation"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the maintenance order"
  measures:
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost incurred for maintenance orders"
    - name: "avg_maintenance_cost"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average cost per maintenance order"
    - name: "maintenance_order_count"
      expr: COUNT(1)
      comment: "Number of maintenance orders"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`facility_inspection_findings`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and compliance view of inspection findings to drive improvement initiatives"
  source: "`healthcare_ecm`.`facility`.`inspection_finding`"
  dimensions:
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the finding"
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the finding (e.g., safety, clinical)"
    - name: "finding_date"
      expr: DATE_TRUNC('day', finding_date)
      comment: "Date the finding was recorded"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of inspection findings recorded"
    - name: "high_severity_findings"
      expr: SUM(CASE WHEN severity_level = 'High' THEN 1 ELSE 0 END)
      comment: "Count of findings classified as high severity"
    - name: "distinct_inspections"
      expr: COUNT(DISTINCT inspection_id)
      comment: "Number of unique inspections that generated findings"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`facility_safety_incidents`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety performance view to monitor incident trends and financial impact"
  source: "`healthcare_ecm`.`facility`.`safety_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Classification of the safety incident"
    - name: "incident_date"
      expr: DATE_TRUNC('day', incident_date)
      comment: "Date the incident occurred"
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where the incident was reported"
  measures:
    - name: "incident_count"
      expr: COUNT(1)
      comment: "Total number of safety incidents reported"
    - name: "injury_incident_count"
      expr: SUM(CASE WHEN injuries_sustained_flag THEN 1 ELSE 0 END)
      comment: "Count of incidents where injuries were sustained"
    - name: "property_damage_total"
      expr: SUM(CAST(property_damage_amount AS DOUBLE))
      comment: "Aggregate monetary value of property damage from incidents"
$$;