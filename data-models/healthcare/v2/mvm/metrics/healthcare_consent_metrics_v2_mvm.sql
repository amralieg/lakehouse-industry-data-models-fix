-- Metric views for domain: consent | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 16:05:56

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the consent record fact table. Tracks consent lifecycle health, revocation rates, expiration exposure, and sensitive-data consent coverage — core metrics for compliance officers, privacy teams, and executive risk dashboards."
  source: "`vibe_healthcare_v1`.`consent`.`record`"
  dimensions:
    - name: "consent_category"
      expr: consent_category
      comment: "High-level category of the consent record (e.g., Treatment, Research, Marketing) — primary grouping for consent portfolio analysis."
    - name: "consent_type"
      expr: consent_type
      comment: "Specific type of consent within the category, enabling granular drill-down for compliance reporting."
    - name: "consent_direction"
      expr: consent_direction
      comment: "Whether consent was granted or withheld — critical for understanding patient autonomy trends."
    - name: "consent_record_status"
      expr: consent_record_status
      comment: "Current lifecycle status of the consent record (e.g., Active, Expired, Revoked, Superseded) — used to filter operational dashboards."
    - name: "purpose_of_use"
      expr: purpose_of_use
      comment: "Declared purpose for which consent was obtained (e.g., Treatment, Payment, Operations) — maps to HIPAA TPO categories."
    - name: "signature_method"
      expr: signature_method
      comment: "How the consent was signed (e.g., Electronic, Wet Ink, Verbal) — informs digital adoption and audit risk."
    - name: "language_code"
      expr: language_code
      comment: "Language in which consent was obtained — used to assess health equity and interpreter utilization."
    - name: "verification_status"
      expr: verification_status
      comment: "Whether the consent record has been verified — flags records requiring follow-up."
    - name: "includes_sensitive_data_flag"
      expr: includes_sensitive_data
      comment: "Boolean flag indicating whether the consent covers sensitive PHI categories (e.g., mental health, substance use) — drives heightened compliance scrutiny."
    - name: "applies_to_minor_flag"
      expr: applies_to_minor
      comment: "Boolean flag indicating consent applies to a minor patient — triggers legal representative requirements."
    - name: "is_legally_authorized_representative_flag"
      expr: is_legally_authorized_representative
      comment: "Boolean flag indicating a legal representative signed on behalf of the patient — relevant for capacity and guardianship audits."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the consent became effective — used for trend analysis of consent intake volume."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month the consent is set to expire — used to forecast upcoming expiration workload."
    - name: "signed_date_month"
      expr: DATE_TRUNC('MONTH', signed_date)
      comment: "Month the consent was signed — used for intake trend reporting."
    - name: "withdrawal_method"
      expr: withdrawal_method
      comment: "Method used to withdraw consent — informs process improvement for revocation workflows."
  measures:
    - name: "total_consent_records"
      expr: COUNT(1)
      comment: "Total number of consent records. Baseline volume metric used to track consent intake throughput and operational capacity."
    - name: "active_consent_records"
      expr: COUNT(CASE WHEN consent_record_status = 'Active' THEN 1 END)
      comment: "Count of currently active consent records. Executives use this to understand the live consent portfolio size and coverage."
    - name: "revoked_consent_records"
      expr: COUNT(CASE WHEN consent_record_status = 'Revoked' THEN 1 END)
      comment: "Count of revoked consent records. A rising revocation count signals patient trust issues or process failures requiring leadership intervention."
    - name: "revocation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_record_status = 'Revoked' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records that have been revoked. A key patient trust and compliance KPI — elevated rates trigger privacy officer review."
    - name: "expired_consent_records"
      expr: COUNT(CASE WHEN consent_record_status = 'Expired' THEN 1 END)
      comment: "Count of expired consent records. Tracks the backlog of consents requiring renewal — directly impacts care delivery risk."
    - name: "expiration_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_record_status = 'Expired' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records that have expired without renewal. High rates indicate gaps in consent lifecycle management."
    - name: "sensitive_data_consent_records"
      expr: COUNT(CASE WHEN includes_sensitive_data = TRUE THEN 1 END)
      comment: "Count of consent records covering sensitive PHI categories. Used by compliance teams to ensure heightened protections are applied."
    - name: "sensitive_data_consent_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN includes_sensitive_data = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records that cover sensitive data. Informs risk exposure and regulatory audit readiness."
    - name: "electronic_signature_consent_records"
      expr: COUNT(CASE WHEN signature_method = 'Electronic' THEN 1 END)
      comment: "Count of consents signed electronically. Tracks digital adoption progress — a strategic operational efficiency KPI."
    - name: "electronic_signature_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN signature_method = 'Electronic' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consents obtained via electronic signature. Directly tied to digital transformation investment outcomes."
    - name: "unverified_consent_records"
      expr: COUNT(CASE WHEN verification_status != 'Verified' OR verification_status IS NULL THEN 1 END)
      comment: "Count of consent records that have not been verified. Unverified consents represent compliance and legal risk — a key audit metric."
    - name: "minor_patient_consent_records"
      expr: COUNT(CASE WHEN applies_to_minor = TRUE THEN 1 END)
      comment: "Count of consent records for minor patients. Ensures legal representative requirements are being met — a regulatory compliance KPI."
    - name: "lar_signed_consent_records"
      expr: COUNT(CASE WHEN is_legally_authorized_representative = TRUE THEN 1 END)
      comment: "Count of consents signed by a legally authorized representative. Tracks capacity-related consent volume for risk and legal review."
    - name: "withdrawn_consent_records"
      expr: COUNT(CASE WHEN withdrawal_date IS NOT NULL THEN 1 END)
      comment: "Count of consent records with a recorded withdrawal date. Tracks the volume of active withdrawals requiring operational follow-through."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_disclosure_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and compliance KPI layer over the PHI disclosure log. Tracks disclosure volume, TPO vs. non-TPO patterns, minimum-necessary compliance, and accounting-of-disclosures obligations — essential for HIPAA Privacy Rule reporting and executive risk oversight."
  source: "`vibe_healthcare_v1`.`consent`.`disclosure_log`"
  dimensions:
    - name: "disclosure_purpose_category"
      expr: disclosure_purpose_category
      comment: "High-level category of the disclosure purpose (e.g., Treatment, Payment, Operations, Research) — primary grouping for HIPAA TPO analysis."
    - name: "disclosure_purpose"
      expr: disclosure_purpose
      comment: "Specific purpose of the PHI disclosure — enables granular compliance drill-down."
    - name: "disclosure_method"
      expr: disclosure_method
      comment: "Channel through which PHI was disclosed (e.g., Fax, Electronic, Mail) — informs security risk and process improvement."
    - name: "disclosure_status"
      expr: disclosure_status
      comment: "Current status of the disclosure record (e.g., Completed, Pending, Rejected) — used to track operational backlogs."
    - name: "recipient_type"
      expr: recipient_type
      comment: "Type of entity receiving the PHI (e.g., Insurer, Law Enforcement, Patient, Provider) — critical for HIPAA accounting and risk stratification."
    - name: "is_tpo_disclosure_flag"
      expr: is_tpo_disclosure
      comment: "Boolean flag indicating whether the disclosure falls under HIPAA Treatment, Payment, or Operations — TPO disclosures are exempt from accounting requirements."
    - name: "is_accounting_required_flag"
      expr: is_accounting_required
      comment: "Boolean flag indicating whether this disclosure must appear in the patient's accounting of disclosures — directly drives HIPAA compliance workload."
    - name: "minimum_necessary_applied_flag"
      expr: minimum_necessary_applied
      comment: "Boolean flag indicating whether the minimum-necessary standard was applied — a core HIPAA Privacy Rule compliance indicator."
    - name: "legal_basis"
      expr: legal_basis
      comment: "Legal authority under which the disclosure was made (e.g., Patient Authorization, Court Order, Public Health) — used for regulatory reporting."
    - name: "disclosure_initiated_by_role"
      expr: disclosure_initiated_by_role
      comment: "Role of the person who initiated the disclosure — used to identify training gaps and accountability."
    - name: "department_code"
      expr: department_code
      comment: "Department responsible for the disclosure — enables departmental compliance benchmarking."
    - name: "disclosure_date_month"
      expr: DATE_TRUNC('MONTH', disclosure_date)
      comment: "Month of the disclosure — used for trend analysis of disclosure volume and compliance posture over time."
    - name: "patient_notification_required_flag"
      expr: patient_notification_required
      comment: "Boolean flag indicating whether the patient must be notified of this disclosure — tracks notification obligation fulfillment."
  measures:
    - name: "total_disclosures"
      expr: COUNT(1)
      comment: "Total number of PHI disclosures logged. Baseline volume metric for HIPAA accounting and operational capacity planning."
    - name: "non_tpo_disclosures"
      expr: COUNT(CASE WHEN is_tpo_disclosure = FALSE OR is_tpo_disclosure IS NULL THEN 1 END)
      comment: "Count of disclosures that are NOT Treatment, Payment, or Operations — these require patient authorization and accounting. A key HIPAA risk metric."
    - name: "non_tpo_disclosure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_tpo_disclosure = FALSE OR is_tpo_disclosure IS NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disclosures outside TPO scope. Elevated rates signal increased authorization and accounting burden — a strategic compliance KPI."
    - name: "accounting_required_disclosures"
      expr: COUNT(CASE WHEN is_accounting_required = TRUE THEN 1 END)
      comment: "Count of disclosures that must be included in the patient's accounting of disclosures. Directly drives HIPAA compliance workload and patient rights fulfillment."
    - name: "minimum_necessary_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN minimum_necessary_applied = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disclosures where the minimum-necessary standard was applied. A direct HIPAA Privacy Rule compliance KPI — low rates trigger regulatory risk."
    - name: "minimum_necessary_non_compliant_disclosures"
      expr: COUNT(CASE WHEN minimum_necessary_applied = FALSE OR minimum_necessary_applied IS NULL THEN 1 END)
      comment: "Count of disclosures where minimum-necessary was NOT applied. Each instance represents a potential HIPAA violation — a critical risk metric for privacy officers."
    - name: "patient_notification_required_disclosures"
      expr: COUNT(CASE WHEN patient_notification_required = TRUE THEN 1 END)
      comment: "Count of disclosures requiring patient notification. Tracks the notification obligation backlog — a patient rights and compliance KPI."
    - name: "patient_notification_fulfilled_disclosures"
      expr: COUNT(CASE WHEN patient_notification_required = TRUE AND patient_notification_date IS NOT NULL THEN 1 END)
      comment: "Count of disclosures where patient notification was required AND a notification date was recorded. Measures fulfillment of patient notification obligations."
    - name: "patient_notification_fulfillment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN patient_notification_required = TRUE AND patient_notification_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN patient_notification_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of required patient notifications that were fulfilled. A direct patient rights compliance KPI — low rates trigger regulatory intervention."
    - name: "distinct_patients_with_disclosures"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Count of distinct patients who had PHI disclosed. Measures the breadth of disclosure exposure across the patient population."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_hipaa_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance KPI layer over HIPAA authorizations for non-TPO PHI disclosures. Tracks authorization completeness, signature capture rates, personal representative usage, and compensation disclosure compliance — essential for HIPAA Privacy Rule audit readiness."
  source: "`vibe_healthcare_v1`.`consent`.`hipaa_authorization`"
  dimensions:
    - name: "authorization_purpose"
      expr: authorization_purpose
      comment: "Purpose for which the HIPAA authorization was obtained (e.g., Research, Marketing, Life Insurance) — primary grouping for authorization portfolio analysis."
    - name: "phi_category"
      expr: phi_category
      comment: "Category of PHI covered by the authorization (e.g., Mental Health, Substance Use, HIV) — used to assess sensitive data authorization coverage."
    - name: "signature_method"
      expr: signature_method
      comment: "Method used to capture the authorization signature (e.g., Electronic, Wet Ink) — tracks digital adoption and audit trail quality."
    - name: "language_code"
      expr: language_code
      comment: "Language in which the authorization was presented — used for health equity and interpreter compliance analysis."
    - name: "personal_representative_flag"
      expr: personal_representative_flag
      comment: "Boolean flag indicating a personal representative signed the authorization — triggers additional documentation requirements."
    - name: "compensation_disclosure_flag"
      expr: compensation_disclosure_flag
      comment: "Boolean flag indicating whether compensation was disclosed to the patient — a specific HIPAA authorization requirement for research/marketing uses."
    - name: "signature_obtained_flag"
      expr: signature_obtained_flag
      comment: "Boolean flag indicating whether a valid signature was captured — incomplete authorizations are legally invalid."
    - name: "signature_date_month"
      expr: DATE_TRUNC('MONTH', signature_date)
      comment: "Month the authorization was signed — used for intake trend analysis."
  measures:
    - name: "total_hipaa_authorizations"
      expr: COUNT(1)
      comment: "Total number of HIPAA authorizations on record. Baseline volume metric for authorization portfolio management."
    - name: "signed_authorizations"
      expr: COUNT(CASE WHEN signature_obtained_flag = TRUE THEN 1 END)
      comment: "Count of HIPAA authorizations with a valid signature captured. Unsigned authorizations are legally invalid — this KPI tracks compliance completeness."
    - name: "signature_capture_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN signature_obtained_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of HIPAA authorizations with a valid signature. A critical legal validity KPI — rates below 100% represent regulatory exposure."
    - name: "unsigned_authorizations"
      expr: COUNT(CASE WHEN signature_obtained_flag = FALSE OR signature_obtained_flag IS NULL THEN 1 END)
      comment: "Count of HIPAA authorizations missing a valid signature. Each unsigned authorization is a potential HIPAA violation — a key risk metric for compliance officers."
    - name: "personal_representative_authorizations"
      expr: COUNT(CASE WHEN personal_representative_flag = TRUE THEN 1 END)
      comment: "Count of authorizations signed by a personal representative. Tracks the volume of capacity-related authorizations requiring additional documentation review."
    - name: "personal_representative_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN personal_representative_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of HIPAA authorizations signed by a personal representative. Informs resource planning for legal representative documentation workflows."
    - name: "compensation_disclosed_authorizations"
      expr: COUNT(CASE WHEN compensation_disclosure_flag = TRUE THEN 1 END)
      comment: "Count of authorizations where compensation disclosure was made. Required for research and marketing authorizations — tracks HIPAA-specific compliance requirement fulfillment."
    - name: "distinct_patients_authorized"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Count of distinct patients with at least one HIPAA authorization on file. Measures the breadth of the authorized PHI disclosure population."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_npp_acknowledgment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient rights KPI layer over Notice of Privacy Practices acknowledgments. Tracks acknowledgment rates, good-faith effort documentation, first-service compliance, and material change acknowledgment coverage — core HIPAA Notice Rule compliance metrics."
  source: "`vibe_healthcare_v1`.`consent`.`npp_acknowledgment`"
  dimensions:
    - name: "acknowledgment_status"
      expr: acknowledgment_status
      comment: "Current status of the NPP acknowledgment (e.g., Acknowledged, Declined, Good Faith Effort) — primary grouping for compliance reporting."
    - name: "acknowledgment_method"
      expr: acknowledgment_method
      comment: "How the acknowledgment was obtained (e.g., Electronic, Paper, Verbal) — tracks digital adoption and process efficiency."
    - name: "delivery_method"
      expr: delivery_method
      comment: "How the NPP was delivered to the patient (e.g., In-Person, Portal, Mail) — informs channel effectiveness analysis."
    - name: "language_code"
      expr: language_code
      comment: "Language in which the NPP was presented — used for health equity and interpreter compliance analysis."
    - name: "is_first_service_acknowledgment_flag"
      expr: is_first_service_acknowledgment
      comment: "Boolean flag indicating this is the patient's first-service NPP acknowledgment — HIPAA requires NPP delivery at first service."
    - name: "material_change_acknowledgment_flag"
      expr: material_change_acknowledgment
      comment: "Boolean flag indicating the acknowledgment covers a material change to the NPP — tracks re-acknowledgment compliance after policy updates."
    - name: "interpreter_used_flag"
      expr: interpreter_used
      comment: "Boolean flag indicating an interpreter was used — used for health equity and language access compliance reporting."
    - name: "signature_captured_flag"
      expr: signature_captured
      comment: "Boolean flag indicating a signature was captured for the acknowledgment — tracks documentation completeness."
    - name: "acknowledgment_date_month"
      expr: DATE_TRUNC('MONTH', acknowledgment_date)
      comment: "Month the acknowledgment was obtained — used for trend analysis of NPP compliance intake volume."
    - name: "device_type"
      expr: device_type
      comment: "Device used to capture the acknowledgment (e.g., Tablet, Kiosk, Desktop) — informs digital channel investment decisions."
  measures:
    - name: "total_npp_acknowledgments"
      expr: COUNT(1)
      comment: "Total number of NPP acknowledgment records. Baseline volume metric for HIPAA Notice Rule compliance tracking."
    - name: "acknowledged_npp_records"
      expr: COUNT(CASE WHEN acknowledgment_status = 'Acknowledged' THEN 1 END)
      comment: "Count of NPP acknowledgments with a confirmed acknowledged status. Core HIPAA Notice Rule compliance KPI."
    - name: "npp_acknowledgment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN acknowledgment_status = 'Acknowledged' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NPP interactions resulting in a confirmed acknowledgment. A primary HIPAA Notice Rule compliance KPI — rates below target trigger process intervention."
    - name: "good_faith_effort_records"
      expr: COUNT(CASE WHEN good_faith_effort_reason IS NOT NULL AND good_faith_effort_reason != '' THEN 1 END)
      comment: "Count of NPP records where a good-faith effort was documented (patient declined or was unable to acknowledge). HIPAA requires documentation of good-faith efforts — this tracks compliance with that requirement."
    - name: "first_service_acknowledgments"
      expr: COUNT(CASE WHEN is_first_service_acknowledgment = TRUE THEN 1 END)
      comment: "Count of first-service NPP acknowledgments. HIPAA mandates NPP delivery at first service — this KPI tracks fulfillment of that obligation."
    - name: "material_change_acknowledgments"
      expr: COUNT(CASE WHEN material_change_acknowledgment = TRUE THEN 1 END)
      comment: "Count of acknowledgments triggered by a material change to the NPP. Tracks re-acknowledgment compliance after privacy policy updates — a regulatory requirement."
    - name: "signature_captured_acknowledgments"
      expr: COUNT(CASE WHEN signature_captured = TRUE THEN 1 END)
      comment: "Count of NPP acknowledgments with a captured signature. Measures documentation completeness — unsigned acknowledgments are weaker evidence of compliance."
    - name: "signature_capture_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN signature_captured = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NPP acknowledgments with a captured signature. Tracks documentation quality — a key audit readiness KPI."
    - name: "interpreter_assisted_acknowledgments"
      expr: COUNT(CASE WHEN interpreter_used = TRUE THEN 1 END)
      comment: "Count of NPP acknowledgments where an interpreter was used. Tracks language access service utilization — a health equity and compliance KPI."
    - name: "distinct_patients_acknowledged"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Count of distinct patients with at least one NPP acknowledgment on file. Measures the breadth of HIPAA Notice Rule compliance across the patient population."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_restriction_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient rights KPI layer over PHI restriction requests. Tracks request volume, organizational decision rates, out-of-pocket payment verification, system enforcement, and restriction lifecycle compliance — essential for HIPAA patient rights and operational risk management."
  source: "`vibe_healthcare_v1`.`consent`.`restriction_request`"
  dimensions:
    - name: "restriction_status"
      expr: restriction_status
      comment: "Current status of the restriction request (e.g., Pending, Approved, Denied, Terminated) — primary grouping for operational workload management."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of restriction requested (e.g., Insurer Restriction, Specific Provider, Specific Purpose) — used to categorize restriction portfolio risk."
    - name: "organization_decision"
      expr: organization_decision
      comment: "The organization's decision on the restriction request (e.g., Approved, Denied, Partially Approved) — tracks patient rights fulfillment outcomes."
    - name: "restricted_phi_category"
      expr: restricted_phi_category
      comment: "Category of PHI subject to the restriction — used to assess sensitive data restriction coverage."
    - name: "restricted_recipient_type"
      expr: restricted_recipient_type
      comment: "Type of recipient from whom PHI is being restricted — informs the operational complexity of enforcing restrictions."
    - name: "request_method"
      expr: request_method
      comment: "How the restriction request was submitted (e.g., Portal, In-Person, Mail) — tracks channel adoption and process efficiency."
    - name: "out_of_pocket_payment_verified_flag"
      expr: out_of_pocket_payment_verified
      comment: "Boolean flag indicating whether out-of-pocket payment was verified — HIPAA mandates honoring restrictions when patient pays out-of-pocket."
    - name: "system_enforcement_flag"
      expr: system_enforcement_flag
      comment: "Boolean flag indicating whether the restriction is enforced at the system level — tracks technical compliance implementation."
    - name: "request_date_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month the restriction request was submitted — used for trend analysis of patient rights request volume."
    - name: "decision_date_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month the organization made a decision on the restriction — used to track decision cycle time trends."
  measures:
    - name: "total_restriction_requests"
      expr: COUNT(1)
      comment: "Total number of PHI restriction requests received. Baseline volume metric for patient rights workload planning."
    - name: "approved_restriction_requests"
      expr: COUNT(CASE WHEN organization_decision = 'Approved' THEN 1 END)
      comment: "Count of restriction requests approved by the organization. Tracks the volume of active restrictions requiring operational enforcement."
    - name: "denied_restriction_requests"
      expr: COUNT(CASE WHEN organization_decision = 'Denied' THEN 1 END)
      comment: "Count of restriction requests denied by the organization. Elevated denial rates may signal patient rights compliance risk."
    - name: "restriction_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN organization_decision = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of restriction requests that were approved. A patient rights fulfillment KPI — used by privacy officers to assess organizational responsiveness."
    - name: "out_of_pocket_verified_restrictions"
      expr: COUNT(CASE WHEN out_of_pocket_payment_verified = TRUE THEN 1 END)
      comment: "Count of restrictions where out-of-pocket payment was verified. HIPAA mandates honoring these restrictions — this KPI tracks a mandatory compliance obligation."
    - name: "system_enforced_restrictions"
      expr: COUNT(CASE WHEN system_enforcement_flag = TRUE THEN 1 END)
      comment: "Count of restrictions with confirmed system-level enforcement. Tracks technical compliance implementation — unenforced restrictions represent active regulatory risk."
    - name: "system_enforcement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN system_enforcement_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN organization_decision = 'Approved' THEN 1 END), 0), 2)
      comment: "Percentage of approved restrictions that have been enforced at the system level. A critical technical compliance KPI — gaps between approvals and enforcement represent active HIPAA risk."
    - name: "pending_restriction_requests"
      expr: COUNT(CASE WHEN restriction_status = 'Pending' THEN 1 END)
      comment: "Count of restriction requests awaiting a decision. Tracks the open patient rights workload — a key operational capacity metric."
    - name: "distinct_patients_requesting_restrictions"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Count of distinct patients who have submitted restriction requests. Measures the breadth of patient rights engagement across the population."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_revocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance and risk KPI layer over consent revocations. Tracks revocation volume, legal review completion, data access restriction enforcement, disclosure halting compliance, and patient notification fulfillment — critical for HIPAA Privacy Rule and consent lifecycle governance."
  source: "`vibe_healthcare_v1`.`consent`.`revocation`"
  dimensions:
    - name: "revocation_status"
      expr: revocation_status
      comment: "Current status of the revocation (e.g., Pending, Completed, Rejected) — primary grouping for revocation workload management."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the revocation — used to identify patterns in patient consent withdrawal behavior."
    - name: "scope"
      expr: scope
      comment: "Scope of the revocation (e.g., Full, Partial) — partial revocations require more complex operational follow-through."
    - name: "method"
      expr: method
      comment: "Method used to submit the revocation (e.g., Written, Electronic, Verbal) — tracks channel adoption and documentation quality."
    - name: "data_access_restricted_flag"
      expr: data_access_restricted_flag
      comment: "Boolean flag indicating whether data access was restricted following the revocation — tracks technical enforcement compliance."
    - name: "disclosures_halted_flag"
      expr: disclosures_halted_flag
      comment: "Boolean flag indicating whether ongoing disclosures were halted following the revocation — a critical HIPAA compliance enforcement indicator."
    - name: "legal_review_required_flag"
      expr: legal_review_required_flag
      comment: "Boolean flag indicating whether legal review was required for this revocation — used to track legal workload and risk exposure."
    - name: "legal_review_completed_flag"
      expr: legal_review_completed_flag
      comment: "Boolean flag indicating whether required legal review was completed — incomplete legal reviews represent unresolved compliance risk."
    - name: "notification_sent_flag"
      expr: notification_sent_flag
      comment: "Boolean flag indicating whether a notification was sent following the revocation — tracks downstream communication compliance."
    - name: "patient_notification_sent_flag"
      expr: patient_notification_sent_flag
      comment: "Boolean flag indicating whether the patient was notified of the revocation outcome — a patient rights fulfillment indicator."
    - name: "revocation_date_month"
      expr: DATE_TRUNC('MONTH', revocation_date)
      comment: "Month the revocation was submitted — used for trend analysis of consent withdrawal patterns."
    - name: "witness_signature_flag"
      expr: witness_signature_flag
      comment: "Boolean flag indicating whether a witness signature was captured — tracks documentation completeness for high-risk revocations."
  measures:
    - name: "total_revocations"
      expr: COUNT(1)
      comment: "Total number of consent revocations processed. Baseline volume metric — rising revocation trends signal patient trust or process issues requiring executive attention."
    - name: "completed_revocations"
      expr: COUNT(CASE WHEN revocation_status = 'Completed' THEN 1 END)
      comment: "Count of fully processed revocations. Tracks operational throughput of the revocation workflow."
    - name: "pending_revocations"
      expr: COUNT(CASE WHEN revocation_status = 'Pending' THEN 1 END)
      comment: "Count of revocations awaiting processing. An open revocation backlog represents active compliance risk — a key operational KPI."
    - name: "data_access_restricted_revocations"
      expr: COUNT(CASE WHEN data_access_restricted_flag = TRUE THEN 1 END)
      comment: "Count of revocations where data access was successfully restricted. Tracks technical enforcement of revocations — a direct HIPAA compliance KPI."
    - name: "data_access_restriction_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN data_access_restricted_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN revocation_status = 'Completed' THEN 1 END), 0), 2)
      comment: "Percentage of completed revocations where data access was restricted. Gaps indicate technical enforcement failures — a critical risk metric for CISOs and privacy officers."
    - name: "disclosures_halted_revocations"
      expr: COUNT(CASE WHEN disclosures_halted_flag = TRUE THEN 1 END)
      comment: "Count of revocations where ongoing disclosures were halted. Tracks the most critical enforcement action following a revocation — a primary HIPAA compliance KPI."
    - name: "disclosure_halt_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN disclosures_halted_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN revocation_status = 'Completed' THEN 1 END), 0), 2)
      comment: "Percentage of completed revocations where disclosures were halted. A critical HIPAA enforcement KPI — rates below 100% represent active regulatory exposure."
    - name: "legal_review_required_revocations"
      expr: COUNT(CASE WHEN legal_review_required_flag = TRUE THEN 1 END)
      comment: "Count of revocations requiring legal review. Tracks legal team workload and identifies high-risk revocations requiring escalation."
    - name: "legal_review_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN legal_review_completed_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN legal_review_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of required legal reviews that were completed. Incomplete legal reviews on revocations represent unresolved compliance risk — a key governance KPI."
    - name: "patient_notification_sent_revocations"
      expr: COUNT(CASE WHEN patient_notification_sent_flag = TRUE THEN 1 END)
      comment: "Count of revocations where the patient was notified of the outcome. Tracks patient rights communication fulfillment following consent withdrawal."
    - name: "distinct_patients_revoking"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Count of distinct patients who have revoked consent. Measures the breadth of consent withdrawal across the patient population — a strategic patient trust KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_treatment_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical quality and compliance KPI layer over treatment consent records. Tracks informed consent completeness, interpreter utilization, emergency exception rates, legal representative involvement, and documentation quality — essential for clinical risk management and Joint Commission compliance."
  source: "`vibe_healthcare_v1`.`consent`.`treatment_consent`"
  dimensions:
    - name: "consent_method"
      expr: consent_method
      comment: "Method used to obtain treatment consent (e.g., Written, Verbal, Electronic) — primary grouping for documentation quality analysis."
    - name: "capacity_determination"
      expr: capacity_determination
      comment: "Assessment of the patient's decision-making capacity (e.g., Capable, Incapable, Questionable) — critical for legal representative and guardian involvement decisions."
    - name: "interpreter_required_flag"
      expr: interpreter_required_flag
      comment: "Boolean flag indicating an interpreter was required for the consent process — tracks language access compliance."
    - name: "legal_representative_required_flag"
      expr: legal_representative_required_flag
      comment: "Boolean flag indicating a legal representative was required — tracks capacity-related consent complexity."
    - name: "emergency_exception_flag"
      expr: emergency_exception_flag
      comment: "Boolean flag indicating consent was obtained under an emergency exception — tracks the volume of emergency-basis treatments."
    - name: "witness_required_flag"
      expr: witness_required_flag
      comment: "Boolean flag indicating a witness was required for the consent — tracks high-risk procedure documentation requirements."
    - name: "patient_questions_addressed_flag"
      expr: patient_questions_addressed_flag
      comment: "Boolean flag indicating patient questions were addressed during the consent process — a key informed consent quality indicator."
    - name: "created_datetime_month"
      expr: DATE_TRUNC('MONTH', created_datetime)
      comment: "Month the treatment consent was created — used for trend analysis of consent intake volume by service line."
  measures:
    - name: "total_treatment_consents"
      expr: COUNT(1)
      comment: "Total number of treatment consent records. Baseline volume metric for clinical consent workflow capacity planning."
    - name: "emergency_exception_consents"
      expr: COUNT(CASE WHEN emergency_exception_flag = TRUE THEN 1 END)
      comment: "Count of treatment consents obtained under an emergency exception. Tracks the volume of treatments performed without standard informed consent — a clinical risk and quality KPI."
    - name: "emergency_exception_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN emergency_exception_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of treatment consents obtained under emergency exception. Elevated rates may indicate process gaps or documentation issues — a Joint Commission compliance KPI."
    - name: "informed_consent_complete_records"
      expr: COUNT(CASE WHEN alternatives_documented IS NOT NULL AND benefits_documented IS NOT NULL AND risks_documented IS NOT NULL THEN 1 END)
      comment: "Count of treatment consents where alternatives, benefits, and risks were all documented. Measures full informed consent documentation completeness — a clinical quality and legal risk KPI."
    - name: "informed_consent_completeness_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN alternatives_documented IS NOT NULL AND benefits_documented IS NOT NULL AND risks_documented IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of treatment consents with complete informed consent documentation (alternatives, benefits, and risks all documented). A primary clinical quality and malpractice risk KPI."
    - name: "interpreter_required_consents"
      expr: COUNT(CASE WHEN interpreter_required_flag = TRUE THEN 1 END)
      comment: "Count of treatment consents requiring an interpreter. Tracks language access service demand — a health equity and compliance KPI."
    - name: "legal_representative_consents"
      expr: COUNT(CASE WHEN legal_representative_required_flag = TRUE THEN 1 END)
      comment: "Count of treatment consents requiring a legal representative. Tracks the volume of capacity-related consents — informs guardianship and legal resource planning."
    - name: "patient_questions_addressed_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN patient_questions_addressed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of treatment consents where patient questions were documented as addressed. A direct informed consent quality KPI — low rates signal patient engagement and malpractice risk."
    - name: "witness_required_consents"
      expr: COUNT(CASE WHEN witness_required_flag = TRUE THEN 1 END)
      comment: "Count of treatment consents requiring a witness. Tracks high-risk procedure documentation volume — used for staffing and compliance planning."
    - name: "distinct_patients_with_treatment_consent"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Count of distinct patients with at least one treatment consent on file. Measures the breadth of treatment consent coverage across the patient population."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`consent_form_template`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Governance KPI layer over consent form templates. Tracks template portfolio health, electronic signature enablement, IRB approval coverage, active vs. superseded template ratios, and multi-language availability — essential for consent governance, regulatory compliance, and form lifecycle management."
  source: "`vibe_healthcare_v1`.`consent`.`form_template`"
  dimensions:
    - name: "consent_category"
      expr: consent_category
      comment: "High-level category of the consent form (e.g., Treatment, Research, HIPAA Authorization) — primary grouping for template portfolio analysis."
    - name: "consent_subcategory"
      expr: consent_subcategory
      comment: "Subcategory of the consent form — enables granular drill-down within the template portfolio."
    - name: "form_status"
      expr: form_status
      comment: "Current lifecycle status of the form template (e.g., Active, Superseded, Draft, Retired) — used to track the active template portfolio."
    - name: "language_code"
      expr: language_code
      comment: "Language of the form template — used to assess multi-language availability for health equity compliance."
    - name: "electronic_signature_enabled_flag"
      expr: electronic_signature_enabled_flag
      comment: "Boolean flag indicating whether the form supports electronic signatures — tracks digital transformation progress in consent workflows."
    - name: "interpreter_required_flag"
      expr: interpreter_required_flag
      comment: "Boolean flag indicating the form requires an interpreter — used for language access planning."
    - name: "witness_required_flag"
      expr: witness_required_flag
      comment: "Boolean flag indicating the form requires a witness — used for high-risk procedure documentation planning."
    - name: "revocation_allowed_flag"
      expr: revocation_allowed_flag
      comment: "Boolean flag indicating whether the consent captured by this form can be revoked — a patient rights governance indicator."
    - name: "minor_assent_required_flag"
      expr: minor_assent_required_flag
      comment: "Boolean flag indicating minor assent is required — tracks pediatric consent governance compliance."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the form template became effective — used for template lifecycle trend analysis."
    - name: "regulatory_basis"
      expr: regulatory_basis
      comment: "Regulatory framework underpinning the form (e.g., HIPAA, 45 CFR 46, State Law) — used for regulatory coverage analysis."
  measures:
    - name: "total_form_templates"
      expr: COUNT(1)
      comment: "Total number of consent form templates in the library. Baseline metric for template portfolio governance."
    - name: "active_form_templates"
      expr: COUNT(CASE WHEN form_status = 'Active' THEN 1 END)
      comment: "Count of currently active consent form templates. Tracks the live template portfolio size — used for governance and maintenance planning."
    - name: "superseded_form_templates"
      expr: COUNT(CASE WHEN form_status = 'Superseded' THEN 1 END)
      comment: "Count of superseded form templates. A high superseded count relative to active templates may indicate rapid policy change or poor version management."
    - name: "electronic_signature_enabled_templates"
      expr: COUNT(CASE WHEN electronic_signature_enabled_flag = TRUE THEN 1 END)
      comment: "Count of form templates with electronic signature capability. Tracks digital transformation progress in the consent form portfolio."
    - name: "electronic_signature_enablement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN electronic_signature_enabled_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN form_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active form templates with electronic signature enabled. A digital transformation KPI — low rates indicate investment gaps in consent digitization."
    - name: "irb_approved_templates"
      expr: COUNT(CASE WHEN irb_approval_number IS NOT NULL AND irb_approval_number != '' THEN 1 END)
      comment: "Count of form templates with an IRB approval number on file. Tracks research consent regulatory compliance — templates without IRB approval cannot be used for research."
    - name: "multi_language_template_coverage"
      expr: COUNT(DISTINCT form_code)
      comment: "Count of distinct form codes in the template library. Used as a proxy for the breadth of consent form coverage — combined with language_code dimension to assess multi-language availability."
    - name: "revocation_allowed_templates"
      expr: COUNT(CASE WHEN revocation_allowed_flag = TRUE THEN 1 END)
      comment: "Count of form templates that allow consent revocation. Tracks patient rights enablement in the form portfolio — a governance and regulatory compliance KPI."
$$;