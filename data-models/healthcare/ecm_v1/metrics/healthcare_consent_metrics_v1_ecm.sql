-- Metric views for domain: consent | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 16:32:35

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`consent_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent session activity metrics capturing consent collection performance."
  source: "`healthcare_ecm`.`consent`.`consent_session`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Identifier of the care site where the consent session occurred."
    - name: "session_type"
      expr: session_type
      comment: "Type of consent session (e.g., in-person, remote)."
    - name: "consent_collection_method"
      expr: consent_collection_method
      comment: "Method used to collect consent (e.g., electronic, paper)."
    - name: "session_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date of the consent session."
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total number of consent sessions."
    - name: "consents_obtained"
      expr: SUM(CASE WHEN all_consents_obtained_flag THEN 1 ELSE 0 END)
      comment: "Number of sessions where all required consents were obtained."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`consent_expiration_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics on consent expiration alerts to monitor upcoming consent expirations and escalation."
  source: "`healthcare_ecm`.`consent`.`expiration_alert`"
  dimensions:
    - name: "alert_type"
      expr: alert_type
      comment: "Type of expiration alert (e.g., renewal, lapse)."
    - name: "alert_priority"
      expr: alert_priority
      comment: "Priority level of the alert."
    - name: "alert_status"
      expr: alert_status
      comment: "Current status of the alert."
    - name: "alert_generation_date"
      expr: DATE_TRUNC('day', alert_generation_timestamp)
      comment: "Date the alert was generated."
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent the alert pertains to."
    - name: "consent_scope"
      expr: consent_scope
      comment: "Scope of the consent (e.g., research, treatment)."
  measures:
    - name: "total_alerts"
      expr: COUNT(1)
      comment: "Total number of consent expiration alerts generated."
    - name: "high_priority_alerts"
      expr: SUM(CASE WHEN alert_priority = 'High' THEN 1 ELSE 0 END)
      comment: "Count of alerts marked as high priority."
    - name: "escalated_alerts"
      expr: SUM(CASE WHEN escalation_flag THEN 1 ELSE 0 END)
      comment: "Number of alerts that have been escalated."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`consent_amendment_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Amendment request activity to track changes to consent records and their outcomes."
  source: "`healthcare_ecm`.`consent`.`amendment_request`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where the amendment request originated."
    - name: "request_channel"
      expr: request_channel
      comment: "Channel through which the request was made (e.g., portal, phone)."
    - name: "request_method"
      expr: request_method
      comment: "Method used for the request (e.g., electronic, paper)."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment requested."
    - name: "amendment_scope"
      expr: amendment_scope
      comment: "Scope of the amendment (e.g., data sharing, treatment)."
    - name: "request_date"
      expr: DATE_TRUNC('day', request_timestamp)
      comment: "Date the amendment request was submitted."
    - name: "request_status"
      expr: request_status
      comment: "Current status of the amendment request."
  measures:
    - name: "total_requests"
      expr: COUNT(1)
      comment: "Total amendment requests submitted."
    - name: "denied_requests"
      expr: SUM(CASE WHEN request_status = 'Denied' THEN 1 ELSE 0 END)
      comment: "Number of amendment requests that were denied."
    - name: "approved_requests"
      expr: SUM(CASE WHEN request_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Number of amendment requests that were approved."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`consent_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy inventory metrics to monitor consent policy lifecycle and governance."
  source: "`healthcare_ecm`.`consent`.`consent_policy`"
  dimensions:
    - name: "policy_status"
      expr: policy_status
      comment: "Current status of the policy (e.g., Active, Inactive)."
    - name: "consent_category"
      expr: consent_category
      comment: "High‑level category of the consent (e.g., Treatment, Research)."
    - name: "effective_date"
      expr: DATE_TRUNC('day', effective_date)
      comment: "Date the policy became effective."
    - name: "expiration_date"
      expr: DATE_TRUNC('day', expiration_date)
      comment: "Date the policy expires."
    - name: "applicable_facility_types"
      expr: applicable_facility_types
      comment: "Facility types to which the policy applies."
  measures:
    - name: "total_policies"
      expr: COUNT(1)
      comment: "Total number of consent policies defined."
    - name: "active_policies"
      expr: SUM(CASE WHEN policy_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of policies currently active."
    - name: "revocation_allowed_policies"
      expr: SUM(CASE WHEN revocation_allowed_flag THEN 1 ELSE 0 END)
      comment: "Policies that allow revocation by the patient."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`consent_research_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research consent participation metrics to gauge patient enrollment in studies."
  source: "`healthcare_ecm`.`consent`.`research_consent`"
  dimensions:
    - name: "research_study_id"
      expr: research_study_id
      comment: "Identifier of the research study associated with the consent."
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the research consent was recorded."
  measures:
    - name: "total_research_consents"
      expr: COUNT(1)
      comment: "Total research consent records captured."
    - name: "patients_with_consent"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients who have provided research consent."
$$;