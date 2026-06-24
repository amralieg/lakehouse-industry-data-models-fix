-- Metric views for domain: consent | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 14:47:42

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core consent lifecycle KPIs measuring active consent coverage, sensitive-data consent volume, withdrawals, and minor/representative coverage. Used by privacy and compliance leadership to monitor consent integrity across the enterprise."
  source: "`vibe_healthcare_v1`.`consent`.`consent_record`"
  dimensions:
    - name: "consent_category"
      expr: consent_category
      comment: "Category grouping of consent (e.g. treatment, research, disclosure) for portfolio analysis."
    - name: "consent_type"
      expr: consent_type
      comment: "Specific consent type for drill-down into consent mix."
    - name: "consent_status"
      expr: consent_record_status
      comment: "Lifecycle status of the consent record (active, expired, withdrawn) for compliance steering."
    - name: "verification_status"
      expr: verification_status
      comment: "Whether the consent has been verified, used to track documentation quality."
    - name: "consent_direction"
      expr: consent_direction
      comment: "Direction of consent (inbound/outbound disclosure) for governance segmentation."
    - name: "language_code"
      expr: language_code
      comment: "Language of consent, used to monitor equitable access for non-English speakers."
    - name: "signed_month"
      expr: DATE_TRUNC('MONTH', signed_date)
      comment: "Month consent was signed, for trend analysis of consent capture volumes."
  measures:
    - name: "Total Consent Records"
      expr: COUNT(1)
      comment: "Total consent records captured; baseline volume KPI for consent operations."
    - name: "Distinct Patients With Consent"
      expr: COUNT(DISTINCT consent_record_id)
      comment: "Distinct consent records as a proxy for patients covered; measures consent reach for compliance."
    - name: "Sensitive Data Consent Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN includes_sensitive_data = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of consents covering sensitive data (e.g. 42 CFR Part 2, HIV, behavioral health); flags elevated privacy-risk exposure."
    - name: "Withdrawn Consent Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN withdrawal_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of consents that have been withdrawn; rising rates signal patient trust or workflow issues requiring intervention."
    - name: "Interpreter Used Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN interpreter_used = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of consents obtained with an interpreter; supports language-access compliance monitoring."
    - name: "Minor Consent Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN applies_to_minor = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of consents applying to minors; informs pediatric consent governance and parental-authority controls."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_deficiency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent documentation deficiency KPIs tracking open deficiencies, remediation rate, patient-safety and regulatory impact. Used by compliance leadership to steer remediation resourcing and reduce audit exposure."
  source: "`vibe_healthcare_v1`.`consent`.`deficiency`"
  dimensions:
    - name: "deficiency_category"
      expr: deficiency_category
      comment: "Category of deficiency for root-cause grouping."
    - name: "deficiency_status"
      expr: deficiency_status
      comment: "Open/closed status of the deficiency for backlog management."
    - name: "deficiency_type"
      expr: deficiency_type
      comment: "Type of deficiency for targeted process improvement."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification to prioritize remediation efforts."
    - name: "discovery_method"
      expr: discovery_method
      comment: "How the deficiency was discovered (audit, self-report) for detection-channel analysis."
    - name: "discovery_month"
      expr: DATE_TRUNC('MONTH', discovery_date)
      comment: "Month deficiency was discovered, for trend monitoring."
  measures:
    - name: "Total Deficiencies"
      expr: COUNT(1)
      comment: "Total consent deficiencies logged; baseline compliance-risk volume."
    - name: "Remediated Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN remediation_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of deficiencies remediated; core measure of remediation program effectiveness."
    - name: "Patient Safety Impact Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN patient_safety_impact_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of deficiencies with patient-safety impact; drives executive escalation and intervention."
    - name: "Regulatory Impact Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_impact_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of deficiencies with regulatory impact; quantifies audit and penalty exposure."
    - name: "Escalation Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of deficiencies requiring escalation; signals process breakdown severity."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_expiration_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent expiration alert KPIs tracking SLA breaches, notification delivery, escalations and renewal outcomes. Used by privacy operations to ensure continuity of care without lapsed consents."
  source: "`vibe_healthcare_v1`.`consent`.`expiration_alert`"
  dimensions:
    - name: "alert_status"
      expr: alert_status
      comment: "Status of the expiration alert for backlog tracking."
    - name: "alert_priority"
      expr: alert_priority
      comment: "Priority of the alert for triage."
    - name: "alert_type"
      expr: alert_type
      comment: "Type of expiration alert for categorization."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution outcome of the alert."
    - name: "alert_month"
      expr: DATE_TRUNC('MONTH', alert_generation_date)
      comment: "Month alert was generated, for trend analysis."
  measures:
    - name: "Total Expiration Alerts"
      expr: COUNT(1)
      comment: "Total consent expiration alerts; baseline operational volume."
    - name: "SLA Breach Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of alerts that breached resolution SLA; key operational performance KPI for privacy ops."
    - name: "Notification Sent Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN notification_sent_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of alerts where patient notification was sent; measures outreach completeness."
    - name: "Care Impact Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN care_impact_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of expiring consents that impact ongoing care; drives prioritized renewal action."
    - name: "Escalation Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of alerts escalated; signals unresolved expiration risk."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_disclosure_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PHI disclosure KPIs tracking accounting-of-disclosures obligations, minimum-necessary compliance, and TPO vs non-TPO disclosure mix. Used by privacy officers to monitor HIPAA disclosure compliance."
  source: "`vibe_healthcare_v1`.`consent`.`disclosure_log`"
  dimensions:
    - name: "disclosure_purpose_category"
      expr: disclosure_purpose_category
      comment: "Purpose category of disclosure for compliance segmentation."
    - name: "disclosure_status"
      expr: disclosure_status
      comment: "Status of the disclosure event."
    - name: "disclosure_method"
      expr: disclosure_method
      comment: "Method of disclosure (electronic, fax, mail) for channel analysis."
    - name: "recipient_type"
      expr: recipient_type
      comment: "Type of recipient receiving PHI for governance review."
    - name: "disclosure_month"
      expr: DATE_TRUNC('MONTH', disclosure_date)
      comment: "Month of disclosure, for trend monitoring."
  measures:
    - name: "Total Disclosures"
      expr: COUNT(1)
      comment: "Total PHI disclosure events logged; baseline disclosure volume."
    - name: "Accounting Required Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_accounting_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of disclosures requiring accounting-of-disclosures; quantifies HIPAA recordkeeping obligation volume."
    - name: "Non TPO Disclosure Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_tpo_disclosure = FALSE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of disclosures outside treatment/payment/operations; higher-risk disclosures requiring authorization scrutiny."
    - name: "Minimum Necessary Applied Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN minimum_necessary_applied = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Compliance rate with the HIPAA minimum-necessary standard; core privacy-compliance KPI."
    - name: "Patient Notification Required Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN patient_notification_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of disclosures requiring patient notification; informs notification workload and compliance."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_capacity_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Decision-making capacity assessment KPIs measuring average capacity scores, surrogate engagement, and reassessment needs. Used by clinical ethics and consent governance leadership."
  source: "`vibe_healthcare_v1`.`consent`.`capacity_assessment`"
  dimensions:
    - name: "capacity_determination"
      expr: capacity_determination
      comment: "Outcome of the capacity determination (has capacity / lacks capacity)."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Status of the capacity assessment."
    - name: "assessment_tool_used"
      expr: assessment_tool_used
      comment: "Standardized tool used for the assessment, for methodology consistency."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment, for trend monitoring."
  measures:
    - name: "Total Capacity Assessments"
      expr: COUNT(1)
      comment: "Total capacity assessments performed; baseline clinical-ethics volume."
    - name: "Avg Capacity Score"
      expr: ROUND(AVG(CAST(capacity_score AS DOUBLE)), 2)
      comment: "Average decision-making capacity score; tracks patient cohort capacity and informs surrogate-decision policy."
    - name: "Surrogate Engaged Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN surrogate_decision_maker_engaged_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of assessments where a surrogate decision-maker was engaged; reflects incapacity prevalence and process readiness."
    - name: "Reassessment Recommended Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reassessment_recommended_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of assessments recommending reassessment; drives follow-up scheduling workload."
    - name: "Ethics Consultation Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN ethics_consultation_obtained_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of assessments involving ethics consultation; indicates complexity and resource demand."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_substance_use_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "42 CFR Part 2 substance-use disclosure consent KPIs tracking redisclosure prohibition compliance, CARES Act alignment, and signature completeness. Critical for behavioral-health privacy compliance leadership."
  source: "`vibe_healthcare_v1`.`consent`.`substance_use_consent`"
  dimensions:
    - name: "disclosure_purpose_category"
      expr: disclosure_purpose_category
      comment: "Purpose category of the SUD disclosure."
    - name: "language_code"
      expr: language_code
      comment: "Consent language, for equitable access monitoring."
    - name: "sud_program_name"
      expr: sud_program_name
      comment: "Substance-use program associated with the consent."
    - name: "signature_month"
      expr: DATE_TRUNC('MONTH', signature_date)
      comment: "Month of signature, for trend analysis."
  measures:
    - name: "Total SUD Consents"
      expr: COUNT(1)
      comment: "Total 42 CFR Part 2 substance-use consents; baseline behavioral-health consent volume."
    - name: "Redisclosure Prohibition Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN redisclosure_prohibition_included_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of consents including the required redisclosure-prohibition notice; core 42 CFR Part 2 compliance KPI."
    - name: "CARES Act Compliant Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN cares_act_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of consents compliant with CARES Act Part 2 alignment; tracks regulatory modernization adherence."
    - name: "Signature Obtained Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN signature_obtained_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of SUD consents with a captured signature; measures documentation completeness."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent collection session KPIs measuring completion rate, regulatory-compliance rate, and interpreter usage across capture channels. Used by patient-access and digital-experience leadership."
  source: "`vibe_healthcare_v1`.`consent`.`consent_session`"
  dimensions:
    - name: "session_status"
      expr: session_status
      comment: "Status of the consent session."
    - name: "session_type"
      expr: session_type
      comment: "Type of consent session for workflow segmentation."
    - name: "consent_collection_channel"
      expr: consent_collection_channel
      comment: "Channel through which consent was collected (portal, kiosk, in-person)."
    - name: "device_type"
      expr: device_type
      comment: "Device type used, for digital-experience analysis."
    - name: "session_month"
      expr: DATE_TRUNC('MONTH', session_start_timestamp)
      comment: "Month of session start, for trend monitoring."
  measures:
    - name: "Total Consent Sessions"
      expr: COUNT(1)
      comment: "Total consent collection sessions; baseline operational volume."
    - name: "All Consents Obtained Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN all_consents_obtained_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Session completion rate where all required consents were obtained; primary efficiency KPI for consent capture."
    - name: "Regulatory Compliance Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of sessions meeting regulatory-compliance criteria; risk-monitoring KPI."
    - name: "Interpreter Required Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN interpreter_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of sessions requiring an interpreter; informs language-access staffing."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_revocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent revocation KPIs tracking enforcement timeliness (disclosures halted, data access restricted), legal-review needs, and patient notification completeness. Used by privacy leadership to ensure revocation rights are honored."
  source: "`vibe_healthcare_v1`.`consent`.`revocation`"
  dimensions:
    - name: "revocation_status"
      expr: revocation_status
      comment: "Status of the revocation request."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for revocation, for root-cause analysis."
    - name: "revocation_method"
      expr: method
      comment: "Method by which the revocation was submitted."
    - name: "revocation_month"
      expr: DATE_TRUNC('MONTH', revocation_date)
      comment: "Month of revocation, for trend monitoring."
  measures:
    - name: "Total Revocations"
      expr: COUNT(1)
      comment: "Total consent revocations; baseline volume and patient-rights indicator."
    - name: "Disclosures Halted Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN disclosures_halted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of revocations where downstream disclosures were halted; measures enforcement effectiveness."
    - name: "Data Access Restricted Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN data_access_restricted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of revocations where data access was restricted; core compliance-enforcement KPI."
    - name: "Patient Notification Sent Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN patient_notification_sent_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of revocations where the patient was notified of the outcome; measures closure completeness."
    - name: "Legal Review Required Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN legal_review_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of revocations requiring legal review; indicates complexity and resource demand."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_restriction_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HIPAA restriction-request KPIs tracking approval outcomes, out-of-pocket payment verification, and system enforcement. Used by privacy leadership to manage patient restriction rights and self-pay restriction obligations."
  source: "`vibe_healthcare_v1`.`consent`.`restriction_request`"
  dimensions:
    - name: "restriction_status"
      expr: restriction_status
      comment: "Status of the restriction request."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of restriction requested."
    - name: "organization_decision"
      expr: organization_decision
      comment: "Organization's decision (granted/denied) on the request."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month of request, for trend monitoring."
  measures:
    - name: "Total Restriction Requests"
      expr: COUNT(1)
      comment: "Total patient restriction requests; baseline patient-rights volume."
    - name: "System Enforced Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN system_enforcement_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of granted restrictions enforced in source systems; measures technical follow-through on patient rights."
    - name: "Out Of Pocket Payment Verified Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN out_of_pocket_payment_verified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of self-pay restrictions with verified out-of-pocket payment; mandatory HIPAA self-pay restriction compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_npp_acknowledgment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Notice of Privacy Practices acknowledgment KPIs tracking signature capture, good-faith-effort documentation, and first-service acknowledgment compliance. Used by patient-access compliance leadership."
  source: "`vibe_healthcare_v1`.`consent`.`npp_acknowledgment`"
  dimensions:
    - name: "acknowledgment_status"
      expr: acknowledgment_status
      comment: "Status of the NPP acknowledgment."
    - name: "acknowledgment_method"
      expr: acknowledgment_method
      comment: "Method of acknowledgment capture."
    - name: "delivery_method"
      expr: delivery_method
      comment: "How the NPP was delivered to the patient."
    - name: "acknowledgment_month"
      expr: DATE_TRUNC('MONTH', acknowledgment_date)
      comment: "Month of acknowledgment, for trend monitoring."
  measures:
    - name: "Total NPP Acknowledgments"
      expr: COUNT(1)
      comment: "Total NPP acknowledgments recorded; baseline compliance volume."
    - name: "Signature Captured Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN signature_captured = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of NPP acknowledgments with a captured signature; primary HIPAA acknowledgment compliance KPI."
    - name: "First Service Acknowledgment Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_first_service_acknowledgment = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share captured at first service of delivery; measures timeliness of NPP distribution obligation."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_amendment_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Amendment request activity to track changes to consent records and their outcomes."
  source: "`vibe_healthcare_v1`.`consent`.`amendment_request`"
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

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy inventory metrics to monitor consent policy lifecycle and governance."
  source: "`vibe_healthcare_v1`.`consent`.`consent_policy`"
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

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_research_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research consent participation metrics to gauge patient enrollment in studies."
  source: "`vibe_healthcare_v1`.`consent`.`research_consent`"
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