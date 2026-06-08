-- Metric views for domain: provider | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 16:32:35

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`provider_board_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Board certification coverage by status and privilege requirement"
  source: "`healthcare_ecm`.`provider`.`board_certification`"
  filter: certification_status = 'Active'
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification"
    - name: "is_active_privileges_required"
      expr: is_active_privileges_required
      comment: "Whether active privileges are required for the certification"
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the certification became effective"
  measures:
    - name: "certified_clinician_count"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Number of clinicians with active board certification"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`provider_location_access`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Access availability of provider locations"
  source: "`healthcare_ecm`.`provider`.`provider_location`"
  filter: is_accepting_new_patients = true
  dimensions:
    - name: "state_code"
      expr: state_code
      comment: "State code of the location"
    - name: "location_type"
      expr: location_type
      comment: "Type of location (e.g., clinic, hospital)"
    - name: "is_telehealth_enabled"
      expr: is_telehealth_enabled
      comment: "Whether telehealth services are enabled at the location"
  measures:
    - name: "accepting_location_count"
      expr: COUNT(1)
      comment: "Count of provider locations currently accepting new patients"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`provider_network_affiliation_active`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Active participation in provider networks"
  source: "`healthcare_ecm`.`provider`.`network_affiliation`"
  dimensions:
    - name: "network_tier"
      expr: network_tier
      comment: "Tier level of the network participation"
    - name: "provider_network_id"
      expr: provider_network_id
      comment: "Identifier of the provider network"
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year of affiliation effectiveness"
  measures:
    - name: "active_network_affiliation_count"
      expr: COUNT(1)
      comment: "Count of active network affiliations"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`provider_reappointment_pending`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pending reappointments by specialty"
  source: "`healthcare_ecm`.`provider`.`reappointment`"
  filter: reappointment_status = 'Pending'
  dimensions:
    - name: "specialty_id"
      expr: specialty_id
      comment: "Specialty associated with the reappointment"
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year of the reappointment record"
  measures:
    - name: "pending_reappointment_count"
      expr: COUNT(1)
      comment: "Number of pending reappointments"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`provider_active_sanctions`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Active sanctions impacting providers"
  source: "`healthcare_ecm`.`provider`.`sanction`"
  filter: sanction_status = 'Active'
  dimensions:
    - name: "sanction_type"
      expr: sanction_type
      comment: "Type/category of the sanction"
    - name: "sanction_status"
      expr: sanction_status
      comment: "Current status of the sanction"
    - name: "effective_year"
      expr: DATE_TRUNC('year', sanction_date)
      comment: "Year the sanction was recorded"
  measures:
    - name: "active_sanction_count"
      expr: COUNT(1)
      comment: "Count of sanctions currently active"
$$;