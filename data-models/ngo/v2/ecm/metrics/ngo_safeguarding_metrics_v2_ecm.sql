-- Metric views for domain: safeguarding | Business: Ngo | Version: 2 | Generated on: 2026-06-23 01:23:48

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPI layer over safeguarding incidents. Tracks incident volume, severity distribution, investigation initiation rates, survivor-centred response rates, and donor notification compliance. Used by the PSEA Coordinator, Country Director, and Board Risk Committee to steer safeguarding performance and demonstrate accountability to donors. Aligns with CHS Commitment 6 and IASC PSEA standards."
  source: "`vibe_ngo_v1`.`safeguarding`.`safeguarding_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Category of safeguarding incident (e.g. SEA, child safeguarding, harassment) — primary grouping for trend analysis."
    - name: "incident_severity_level"
      expr: severity_level
      comment: "Severity classification (Critical / High / Medium / Low) — used to prioritise response and escalation."
    - name: "incident_status"
      expr: incident_status
      comment: "Current lifecycle status of the incident (Open, Under Investigation, Closed, etc.)."
    - name: "incident_subtype"
      expr: subtype
      comment: "Sub-classification within the incident type for granular pattern analysis."
    - name: "incident_location_country"
      expr: location_country
      comment: "Country where the incident occurred — enables geographic risk profiling."
    - name: "incident_location_region"
      expr: location_region
      comment: "Region within the country for sub-national hotspot identification."
    - name: "incident_reporter_type"
      expr: reporter_type
      comment: "Who reported the incident (staff, beneficiary, community member, anonymous) — informs reporting culture assessment."
    - name: "incident_reporting_channel"
      expr: reporting_channel
      comment: "Channel through which the incident was reported — used to evaluate channel effectiveness."
    - name: "incident_alleged_perpetrator_type"
      expr: alleged_perpetrator_type
      comment: "Type of alleged perpetrator (staff, partner, volunteer, unknown) — critical for accountability tracking."
    - name: "incident_survivor_gender"
      expr: survivor_gender
      comment: "Gender of the survivor (pii_beneficiary_protected) — required for disaggregated donor and cluster reporting."
    - name: "incident_survivor_age_group"
      expr: survivor_age_group
      comment: "Age group of the survivor (pii_beneficiary_protected) — required for child safeguarding disaggregation."
    - name: "incident_date_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of incident occurrence — used for trend analysis and periodic reporting."
    - name: "incident_date_year"
      expr: YEAR(incident_date)
      comment: "Year of incident occurrence — used for annual reporting and year-over-year comparison."
    - name: "incident_safeguarding_status"
      expr: safeguarding_incident_status
      comment: "Safeguarding-specific status field providing additional lifecycle granularity beyond incident_status."
  measures:
    - name: "total_incidents_reported"
      expr: COUNT(1)
      comment: "Total number of safeguarding incidents reported. Baseline KPI for incident volume tracking; a rising trend triggers immediate leadership review and resource reallocation."
    - name: "critical_and_high_severity_incidents"
      expr: COUNT(CASE WHEN severity_level IN ('Critical', 'High') THEN 1 END)
      comment: "Count of Critical or High severity incidents. Executives use this to assess acute organisational risk and determine whether emergency response protocols are required."
    - name: "investigation_initiation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN investigation_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents where an investigation was required. Low rates may indicate under-reporting or inadequate triage; high rates signal systemic issues requiring structural intervention."
    - name: "survivor_centred_response_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN survivor_centered_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN survivor_involved_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of survivor-involved incidents where a survivor-centred approach was applied. Core accountability metric for CHS and donor audits; below-target rates trigger case management review."
    - name: "survivor_support_provision_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN survivor_support_provided_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN survivor_involved_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of survivor-involved incidents where support was provided. Directly measures duty-of-care fulfilment; gaps trigger immediate case management escalation."
    - name: "donor_notification_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN donor_notified_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN donor_notification_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of incidents requiring donor notification where notification was completed. Non-compliance risks grant suspension; tracked in every donor audit."
    - name: "law_enforcement_referral_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN law_enforcement_notified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents referred to law enforcement. Informs legal risk exposure and compliance with mandatory reporting obligations."
    - name: "open_incidents_count"
      expr: COUNT(CASE WHEN incident_status NOT IN ('Closed', 'Resolved') THEN 1 END)
      comment: "Number of currently open incidents. A growing backlog signals capacity constraints in the safeguarding function and triggers staffing decisions."
    - name: "incidents_with_referral_made"
      expr: COUNT(CASE WHEN referral_made_flag = TRUE THEN 1 END)
      comment: "Count of incidents where a referral to external services was made. Measures the organisation's ability to connect survivors with appropriate support services."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_investigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over safeguarding investigations. Tracks investigation throughput, substantiation rates, timeliness, cost, and external reporting compliance. Used by the Head of Safeguarding, Legal Counsel, and Audit Committee to manage investigation quality and organisational accountability. Relevant to USAID, FCDO, and UN donor audit requirements."
  source: "`vibe_ngo_v1`.`safeguarding`.`investigation`"
  dimensions:
    - name: "investigation_type"
      expr: investigation_type
      comment: "Type of investigation (internal, external, joint) — determines resource requirements and governance oversight."
    - name: "investigation_category"
      expr: investigation_category
      comment: "Category of misconduct under investigation — used for pattern analysis and policy gap identification."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the investigation (Open, In Progress, Closed, Suspended) — operational pipeline view."
    - name: "investigation_final_determination"
      expr: final_determination
      comment: "Final determination of the investigation (Substantiated, Unsubstantiated, Inconclusive) — outcome classification for accountability reporting."
    - name: "investigation_confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification — governs data access and sharing with donors or authorities."
    - name: "investigation_opened_year"
      expr: YEAR(opened_date)
      comment: "Year investigation was opened — used for cohort analysis and annual reporting."
    - name: "investigation_opened_month"
      expr: DATE_TRUNC('MONTH', opened_date)
      comment: "Month investigation was opened — used for trend and capacity planning."
  measures:
    - name: "total_investigations"
      expr: COUNT(1)
      comment: "Total number of investigations. Baseline volume metric; growth signals either improved reporting culture or systemic conduct issues requiring leadership attention."
    - name: "substantiation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN substantiated_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN investigation_status = 'Closed' THEN 1 END), 0), 2)
      comment: "Percentage of closed investigations that were substantiated. Key accountability metric; high rates indicate systemic conduct problems; very low rates may indicate barriers to evidence collection."
    - name: "external_reporting_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN external_reporting_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN external_reporting_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of investigations requiring external reporting where reporting was completed. Non-compliance risks donor sanctions and regulatory penalties."
    - name: "law_enforcement_referral_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN law_enforcement_referral_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigations referred to law enforcement. Informs legal risk posture and mandatory reporting compliance."
    - name: "avg_investigation_cost_usd"
      expr: AVG(CAST(cost_usd AS DOUBLE))
      comment: "Average cost per investigation in USD. Used for budget planning and cost-efficiency benchmarking of the safeguarding function."
    - name: "total_investigation_cost_usd"
      expr: SUM(CAST(cost_usd AS DOUBLE))
      comment: "Total investigation expenditure in USD. Informs safeguarding budget adequacy and cost allocation to grants."
    - name: "open_investigations_count"
      expr: COUNT(CASE WHEN investigation_status NOT IN ('Closed', 'Resolved') THEN 1 END)
      comment: "Number of currently open investigations. A growing backlog signals investigative capacity constraints requiring immediate staffing or outsourcing decisions."
    - name: "survivor_support_provision_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN survivor_support_provided IS NOT NULL AND survivor_support_provided != '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigations where survivor support was documented as provided. Measures duty-of-care compliance throughout the investigation process."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_alleged_perpetrator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over alleged perpetrator records. Tracks case outcomes, disciplinary action rates, criminal referral rates, and misconduct database reporting compliance. Used by HR leadership, Legal Counsel, and the Board to assess accountability and prevent recurrence. Supports inter-agency misconduct database obligations (e.g. SCTI, UN ClearCheck)."
  source: "`vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator`"
  dimensions:
    - name: "perpetrator_allegation_type"
      expr: allegation_type
      comment: "Type of allegation (SEA, harassment, fraud, abuse of authority) — primary classification for pattern analysis."
    - name: "perpetrator_allegation_severity"
      expr: allegation_severity
      comment: "Severity of the allegation — used to prioritise case management resources."
    - name: "perpetrator_investigation_status"
      expr: investigation_status
      comment: "Current investigation status for this perpetrator record — pipeline management view."
    - name: "perpetrator_investigation_outcome"
      expr: investigation_outcome
      comment: "Outcome of the investigation (Substantiated, Unsubstantiated, Inconclusive) — accountability classification."
    - name: "perpetrator_case_outcome"
      expr: case_outcome
      comment: "Final case outcome (Dismissed, Resigned, Terminated, Warning, etc.) — used for accountability trend analysis."
    - name: "perpetrator_affiliation_type"
      expr: affiliation_type
      comment: "Affiliation of the alleged perpetrator (staff, partner, volunteer, contractor) — informs which accountability pathway applies."
    - name: "perpetrator_employment_status_at_incident"
      expr: employment_status_at_incident
      comment: "Employment status at time of incident — used to assess whether employment controls were adequate."
    - name: "perpetrator_rehire_eligibility"
      expr: rehire_eligibility
      comment: "Whether the individual is eligible for rehire — critical for preventing recurrence across the sector."
    - name: "perpetrator_allegation_year"
      expr: YEAR(allegation_date)
      comment: "Year of allegation — used for annual trend reporting."
  measures:
    - name: "total_alleged_perpetrator_cases"
      expr: COUNT(1)
      comment: "Total number of alleged perpetrator cases. Volume baseline; growth may indicate improved reporting culture or systemic conduct failures requiring structural intervention."
    - name: "criminal_referral_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN criminal_referral_made = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases where a criminal referral was made. Measures fulfilment of mandatory reporting obligations to law enforcement."
    - name: "misconduct_database_reporting_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN misconduct_database_reported = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases reported to the inter-agency misconduct database. Non-compliance enables perpetrators to move between organisations; tracked in donor audits and UN ClearCheck reviews."
    - name: "substantiated_case_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN investigation_outcome IN ('Substantiated', 'Founded') THEN 1 END) / NULLIF(COUNT(CASE WHEN investigation_status = 'Closed' THEN 1 END), 0), 2)
      comment: "Percentage of closed cases with a substantiated outcome. Informs the effectiveness of the investigation process and the severity of the conduct environment."
    - name: "cases_with_suspension_applied"
      expr: COUNT(CASE WHEN suspension_start_date IS NOT NULL THEN 1 END)
      comment: "Number of cases where interim suspension was applied. Measures the organisation's use of protective interim measures during investigations."
    - name: "cases_resulting_in_termination"
      expr: COUNT(CASE WHEN termination_date IS NOT NULL THEN 1 END)
      comment: "Number of cases resulting in termination. Key accountability outcome metric reviewed by the Board and donors."
    - name: "ineligible_for_rehire_count"
      expr: COUNT(CASE WHEN rehire_eligibility IN ('Ineligible', 'Permanently Ineligible', 'No') THEN 1 END)
      comment: "Number of individuals marked ineligible for rehire. Measures the organisation's commitment to preventing recurrence and sector-wide accountability."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over safeguarding training completion records. Tracks mandatory training compliance rates, pass rates, overdue training, and cost efficiency. Used by the PSEA Coordinator, HR Director, and donors to verify that all staff and partners have completed required safeguarding training. Directly supports CHS Commitment 6 and donor pre-award compliance checks."
  source: "`vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion`"
  dimensions:
    - name: "training_completion_status"
      expr: completion_status
      comment: "Completion status (Completed, In Progress, Not Started, Waived) — primary filter for compliance dashboards."
    - name: "training_pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/Fail outcome of the training assessment — used to identify staff requiring remedial training."
    - name: "training_participant_type"
      expr: participant_type
      comment: "Type of participant (staff, partner, volunteer, contractor) — enables disaggregated compliance reporting."
    - name: "training_mandatory_flag"
      expr: mandatory_training_flag
      comment: "Whether the training was mandatory — used to focus compliance tracking on required completions."
    - name: "training_overdue_flag"
      expr: overdue_flag
      comment: "Whether the training is overdue — operational flag for immediate follow-up actions."
    - name: "training_completion_channel"
      expr: completion_channel
      comment: "Delivery channel (online, in-person, blended) — used to assess channel effectiveness and cost."
    - name: "training_language"
      expr: language
      comment: "Language in which training was delivered — used to assess language accessibility and localisation gaps."
    - name: "training_completion_year"
      expr: YEAR(completion_date)
      comment: "Year of training completion — used for annual compliance reporting."
    - name: "training_completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month of training completion — used for trend analysis and compliance deadline tracking."
    - name: "training_refresher_required_flag"
      expr: refresher_required_flag
      comment: "Whether a refresher is required — used to forecast future training demand."
  measures:
    - name: "mandatory_training_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mandatory_training_flag = TRUE AND completion_status = 'Completed' THEN 1 END) / NULLIF(COUNT(CASE WHEN mandatory_training_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of mandatory safeguarding training completions. Core donor compliance KPI; below-target rates trigger immediate HR escalation and may block grant disbursements."
    - name: "training_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END) / NULLIF(COUNT(CASE WHEN pass_fail_status IN ('Pass', 'Fail') THEN 1 END), 0), 2)
      comment: "Percentage of assessed training completions that resulted in a pass. Low pass rates indicate training quality or comprehension issues requiring curriculum review."
    - name: "overdue_mandatory_training_count"
      expr: COUNT(CASE WHEN overdue_flag = TRUE AND mandatory_training_flag = TRUE THEN 1 END)
      comment: "Number of overdue mandatory safeguarding training records. A non-zero value is a compliance risk that must be resolved before donor audits or programme launches."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across all completed training. Tracks knowledge retention quality; declining scores trigger curriculum or delivery method review."
    - name: "total_training_cost_usd"
      expr: SUM(CAST(cost_usd AS DOUBLE))
      comment: "Total expenditure on safeguarding training in USD. Used for budget planning and cost allocation to grants and programmes."
    - name: "avg_training_cost_per_completion_usd"
      expr: AVG(CAST(cost_usd AS DOUBLE))
      comment: "Average cost per training completion in USD. Used for cost-efficiency benchmarking across delivery channels and providers."
    - name: "total_training_hours_delivered"
      expr: SUM(CAST(training_duration_hours AS DOUBLE))
      comment: "Total safeguarding training hours delivered. Measures the scale of the training programme and supports donor reporting on capacity building investment."
    - name: "waiver_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN waiver_granted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training records where a waiver was granted. High waiver rates may indicate policy circumvention and require governance review."
    - name: "certificate_issuance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN certificate_issued_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN completion_status = 'Completed' THEN 1 END), 0), 2)
      comment: "Percentage of completed trainings where a certificate was issued. Supports verification of training credentials for partner due diligence and staff deployment."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_partner_psea_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over partner PSEA assessments. Tracks partner safeguarding capacity scores, critical gap rates, capacity building trigger rates, and assessment currency. Used by the Partnership Manager, PSEA Coordinator, and donors to make partner approval decisions and monitor safeguarding risk in the implementing partner portfolio. Required for USAID, FCDO, and UN sub-award compliance."
  source: "`vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of PSEA assessment (initial, periodic, triggered) — determines the assessment context and required follow-up."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (Planned, In Progress, Completed, Expired) — pipeline management view."
    - name: "overall_capacity_rating"
      expr: overall_capacity_rating
      comment: "Overall PSEA capacity rating (Strong, Adequate, Needs Improvement, Critical Gap) — primary risk classification for partner portfolio management."
    - name: "partnership_approval_status"
      expr: partnership_approval_status
      comment: "Whether the partner was approved for partnership based on the assessment — decision outcome tracking."
    - name: "critical_gap_flag"
      expr: critical_gap_flag
      comment: "Whether a critical safeguarding gap was identified — triggers mandatory capacity building and enhanced monitoring."
    - name: "capacity_building_plan_triggered_flag"
      expr: capacity_building_plan_triggered_flag
      comment: "Whether a capacity building plan was triggered by the assessment — measures follow-through on identified gaps."
    - name: "reassessment_required_flag"
      expr: reassessment_required_flag
      comment: "Whether a reassessment is required — used to manage the reassessment pipeline."
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of assessment — used for annual portfolio review and trend analysis."
    - name: "investigation_capacity_rating"
      expr: investigation_capacity_rating
      comment: "Partner's rated capacity to investigate safeguarding incidents — critical sub-dimension for risk-based partner monitoring."
    - name: "survivor_support_rating"
      expr: survivor_support_rating
      comment: "Partner's rated capacity to provide survivor support — key sub-dimension for duty-of-care assessment."
  measures:
    - name: "total_partner_assessments"
      expr: COUNT(1)
      comment: "Total number of partner PSEA assessments conducted. Baseline volume metric for the partner due diligence programme."
    - name: "critical_gap_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_gap_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partner assessments identifying a critical safeguarding gap. High rates signal systemic partner portfolio risk requiring immediate capacity building investment or partner replacement."
    - name: "avg_partner_capacity_score"
      expr: AVG(CAST(capacity_score AS DOUBLE))
      comment: "Average PSEA capacity score across assessed partners. Portfolio-level benchmark; declining scores trigger programme-wide partner support interventions."
    - name: "capacity_building_trigger_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN capacity_building_plan_triggered_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments that triggered a capacity building plan. Measures the organisation's follow-through on identified partner gaps."
    - name: "partnership_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN partnership_approval_status IN ('Approved', 'Conditionally Approved') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessed partners approved for partnership. Informs partner pipeline quality and due diligence rigour."
    - name: "expired_assessments_count"
      expr: COUNT(CASE WHEN assessment_expiry_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of partner assessments that have expired. Expired assessments represent unmanaged safeguarding risk in the active partner portfolio; triggers reassessment scheduling."
    - name: "avg_score_utilisation_pct"
      expr: ROUND(100.0 * AVG(CAST(capacity_score AS DOUBLE)) / NULLIF(AVG(CAST(maximum_possible_score AS DOUBLE)), 0), 2)
      comment: "Average partner capacity score as a percentage of the maximum possible score. Normalised benchmark enabling comparison across assessment frameworks and partner cohorts."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over safeguarding audits. Tracks audit completion rates, compliance scores, critical findings, corrective action plan requirements, and follow-up audit rates. Used by the Internal Audit function, Country Director, and Audit Committee to assess safeguarding system maturity and drive continuous improvement. Relevant to IPSAS, US GAAP ASC 958, and donor audit requirements."
  source: "`vibe_ngo_v1`.`safeguarding`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (internal, external, donor-commissioned, joint) — determines governance oversight and reporting requirements."
    - name: "audit_category"
      expr: audit_category
      comment: "Category of audit (safeguarding systems, PSEA, child protection, GBV) — used for thematic analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Current audit status (Planned, In Progress, Completed, Cancelled) — pipeline management view."
    - name: "overall_safeguarding_maturity_rating"
      expr: overall_safeguarding_maturity_rating
      comment: "Overall safeguarding maturity rating assigned by the audit — primary outcome classification for portfolio benchmarking."
    - name: "corrective_action_plan_required_flag"
      expr: corrective_action_plan_required_flag
      comment: "Whether a corrective action plan was required — used to track remediation obligations."
    - name: "follow_up_audit_required_flag"
      expr: follow_up_audit_required_flag
      comment: "Whether a follow-up audit was required — indicates unresolved systemic issues."
    - name: "audit_start_year"
      expr: YEAR(start_date)
      comment: "Year the audit commenced — used for annual audit programme tracking."
    - name: "audit_commissioning_organization"
      expr: commissioning_organization
      comment: "Organisation that commissioned the audit (internal, donor name, UN agency) — used for accountability attribution."
  measures:
    - name: "total_audits_conducted"
      expr: COUNT(1)
      comment: "Total number of safeguarding audits conducted. Baseline metric for audit programme coverage."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average safeguarding compliance score across all audits. Portfolio-level maturity benchmark; declining scores trigger programme-wide remediation investment."
    - name: "corrective_action_plan_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_plan_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN audit_status = 'Completed' THEN 1 END), 0), 2)
      comment: "Percentage of completed audits requiring a corrective action plan. High rates indicate systemic safeguarding weaknesses requiring strategic investment."
    - name: "management_response_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN management_response_received_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN audit_status = 'Completed' THEN 1 END), 0), 2)
      comment: "Percentage of completed audits where management provided a formal response. Low rates indicate accountability gaps in the management response process."
    - name: "total_audit_cost_usd"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total expenditure on safeguarding audits in USD. Used for budget planning and cost allocation to grants and programmes."
    - name: "avg_audit_cost_usd"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per safeguarding audit in USD. Used for cost-efficiency benchmarking and budget forecasting."
    - name: "external_reporting_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN external_reporting_required_flag = TRUE AND external_reporting_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN external_reporting_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of audits requiring external reporting where reporting was completed. Non-compliance risks donor sanctions and regulatory penalties."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_audit_recommendation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over audit recommendations. Tracks implementation progress, overdue rates, cost of remediation, and donor reporting compliance. Used by the Internal Audit function and Country Management Teams to drive accountability for audit findings and demonstrate continuous improvement to donors and the Board."
  source: "`vibe_ngo_v1`.`safeguarding`.`audit_recommendation`"
  dimensions:
    - name: "recommendation_priority_level"
      expr: priority_level
      comment: "Priority level of the recommendation (Critical, High, Medium, Low) — used to focus management attention on highest-risk gaps."
    - name: "recommendation_category"
      expr: recommendation_category
      comment: "Category of the recommendation (policy, training, reporting, investigation, survivor support) — used for thematic gap analysis."
    - name: "recommendation_implementation_status"
      expr: implementation_status
      comment: "Current implementation status (Not Started, In Progress, Completed, Deferred, Cancelled) — operational pipeline view."
    - name: "recommendation_management_acceptance_status"
      expr: management_acceptance_status
      comment: "Whether management accepted the recommendation — tracks accountability for audit findings."
    - name: "recommendation_risk_level"
      expr: risk_level
      comment: "Risk level associated with non-implementation — used to prioritise remediation resources."
    - name: "recommendation_donor_reporting_required_flag"
      expr: donor_reporting_required_flag
      comment: "Whether the recommendation must be reported to a donor — flags high-stakes accountability items."
    - name: "recommendation_target_year"
      expr: YEAR(target_completion_date)
      comment: "Year the recommendation is targeted for completion — used for annual workplan tracking."
  measures:
    - name: "total_recommendations"
      expr: COUNT(1)
      comment: "Total number of audit recommendations. Baseline volume metric for the remediation pipeline."
    - name: "implementation_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN implementation_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recommendations fully implemented. Core accountability KPI reviewed by the Audit Committee and donors; below-target rates trigger escalation."
    - name: "critical_high_recommendations_open"
      expr: COUNT(CASE WHEN priority_level IN ('Critical', 'High') AND implementation_status NOT IN ('Completed', 'Cancelled') THEN 1 END)
      comment: "Number of open Critical or High priority recommendations. Non-zero values represent acute organisational risk requiring immediate management action."
    - name: "avg_implementation_progress_pct"
      expr: AVG(CAST(implementation_progress_percentage AS DOUBLE))
      comment: "Average implementation progress percentage across all open recommendations. Portfolio-level remediation velocity indicator."
    - name: "total_implementation_cost_usd"
      expr: SUM(CAST(implementation_cost_usd AS DOUBLE))
      comment: "Total cost of implementing audit recommendations in USD. Used for budget planning and cost-benefit analysis of the audit programme."
    - name: "donor_reporting_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN donor_reporting_required_flag = TRUE AND donor_reported_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN donor_reporting_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of donor-reportable recommendations where reporting was completed. Non-compliance risks grant suspension and reputational damage."
    - name: "budget_allocated_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN budget_allocated_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recommendations with budget allocated for implementation. Low rates indicate under-resourcing of the remediation programme."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over safeguarding risk assessments. Tracks risk score distribution, mitigation plan status, beneficiary consultation rates, and reassessment currency. Used by the PSEA Coordinator, Country Director, and Risk Committee to proactively manage safeguarding risk across programmes and geographies. Supports CHS Commitment 6 and donor risk management requirements."
  source: "`vibe_ngo_v1`.`safeguarding`.`risk_assessment`"
  dimensions:
    - name: "risk_assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment (programme, partner, context, operational) — determines scope and methodology."
    - name: "risk_assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (Planned, In Progress, Completed, Expired) — pipeline management view."
    - name: "overall_safeguarding_risk_level"
      expr: overall_safeguarding_risk_level
      comment: "Overall safeguarding risk level (Critical, High, Medium, Low) — primary risk classification for portfolio management."
    - name: "mitigation_plan_status"
      expr: mitigation_plan_status
      comment: "Status of the mitigation plan (Not Started, In Progress, Completed) — tracks follow-through on identified risks."
    - name: "beneficiary_consultation_conducted"
      expr: beneficiary_consultation_conducted
      comment: "Whether beneficiaries were consulted in the assessment — measures accountability and participation standards."
    - name: "risk_assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of assessment — used for annual risk portfolio review."
    - name: "risk_assessment_methodology"
      expr: assessment_methodology
      comment: "Methodology used for the assessment — used for quality assurance and comparability analysis."
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(1)
      comment: "Total number of safeguarding risk assessments conducted. Baseline metric for risk management programme coverage."
    - name: "high_critical_risk_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_safeguarding_risk_level IN ('Critical', 'High') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments rated High or Critical risk. Rising rates signal deteriorating operating environment or programme design weaknesses requiring strategic response."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average safeguarding risk score across all assessments. Portfolio-level risk benchmark; used to track risk trajectory over time and allocate mitigation resources."
    - name: "mitigation_plan_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mitigation_plan_status = 'Completed' THEN 1 END) / NULLIF(COUNT(CASE WHEN assessment_status = 'Completed' THEN 1 END), 0), 2)
      comment: "Percentage of completed assessments with a completed mitigation plan. Low rates indicate unmanaged residual risk requiring immediate management attention."
    - name: "beneficiary_consultation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN beneficiary_consultation_conducted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of risk assessments where beneficiaries were consulted. Measures accountability and participation standards; low rates indicate CHS compliance gaps."
    - name: "avg_estimated_mitigation_cost_usd"
      expr: AVG(CAST(estimated_mitigation_cost_usd AS DOUBLE))
      comment: "Average estimated cost of safeguarding risk mitigation per assessment. Used for budget planning and cost-benefit analysis of the risk management programme."
    - name: "total_estimated_mitigation_cost_usd"
      expr: SUM(CAST(estimated_mitigation_cost_usd AS DOUBLE))
      comment: "Total estimated mitigation cost across all assessed risks. Informs safeguarding budget adequacy and investment prioritisation."
    - name: "expired_assessments_count"
      expr: COUNT(CASE WHEN reassessment_due_date < CURRENT_DATE() AND assessment_status = 'Completed' THEN 1 END)
      comment: "Number of risk assessments past their reassessment due date. Expired assessments represent unmanaged risk; triggers reassessment scheduling and resource allocation."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_survivor_support_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over survivor support plans. Tracks plan coverage, service provision rates, review compliance, and plan closure. Used by the Case Management Coordinator and PSEA Focal Point to ensure survivors receive comprehensive, timely, and survivor-centred support. Directly measures duty-of-care fulfilment and supports donor reporting on survivor assistance."
  source: "`vibe_ngo_v1`.`safeguarding`.`survivor_support_plan`"
  dimensions:
    - name: "support_plan_status"
      expr: plan_status
      comment: "Current status of the support plan (Active, Under Review, Closed, Suspended) — operational pipeline view."
    - name: "support_plan_type"
      expr: plan_type
      comment: "Type of support plan (emergency, comprehensive, follow-up) — used for resource planning and service mapping."
    - name: "support_plan_confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the plan (pii_beneficiary_protected) — governs data access and sharing."
    - name: "support_plan_survivor_centered_approach"
      expr: survivor_centered_approach
      comment: "Whether a survivor-centred approach was applied — core accountability dimension for CHS and donor reporting."
    - name: "support_plan_medical_referral_required"
      expr: medical_referral_required
      comment: "Whether medical referral was required — used to track medical service provision gaps."
    - name: "support_plan_psychosocial_support_required"
      expr: psychosocial_support_required
      comment: "Whether psychosocial support was required — used to track PSS service provision gaps."
    - name: "support_plan_legal_aid_required"
      expr: legal_aid_required
      comment: "Whether legal aid was required — used to track legal service provision gaps."
    - name: "support_plan_start_year"
      expr: YEAR(plan_start_date)
      comment: "Year the support plan commenced — used for cohort analysis and annual reporting."
  measures:
    - name: "total_survivor_support_plans"
      expr: COUNT(1)
      comment: "Total number of survivor support plans created. Baseline metric for survivor assistance programme coverage."
    - name: "active_support_plans_count"
      expr: COUNT(CASE WHEN plan_status = 'Active' THEN 1 END)
      comment: "Number of currently active survivor support plans. Operational caseload metric used for case management staffing decisions."
    - name: "survivor_consent_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN survivor_consent_obtained = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of support plans where survivor consent was obtained. Non-negotiable ethical standard; below 100% triggers immediate case management review."
    - name: "survivor_centred_approach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN survivor_centered_approach = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of support plans applying a survivor-centred approach. Core CHS accountability metric; below-target rates trigger case management quality review."
    - name: "safety_plan_inclusion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN safety_plan_included = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of support plans that include a safety plan. Measures protection of survivors from further harm; low rates indicate case management quality gaps."
    - name: "multi_service_plan_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN (CASE WHEN medical_referral_required = TRUE THEN 1 ELSE 0 END + CASE WHEN psychosocial_support_required = TRUE THEN 1 ELSE 0 END + CASE WHEN legal_aid_required = TRUE THEN 1 ELSE 0 END + CASE WHEN livelihood_support_required = TRUE THEN 1 ELSE 0 END) >= 2 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of support plans addressing two or more service domains. Measures comprehensiveness of survivor support; low rates indicate fragmented case management."
    - name: "overdue_review_plans_count"
      expr: COUNT(CASE WHEN next_review_date < CURRENT_DATE() AND plan_status = 'Active' THEN 1 END)
      comment: "Number of active support plans past their scheduled review date. Overdue reviews represent gaps in ongoing survivor monitoring; triggers case management follow-up."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_community_awareness_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over community safeguarding awareness sessions. Tracks reach, participation demographics, incident reporting rates, and follow-up completion. Used by the PSEA Coordinator and Programme Manager to measure community engagement effectiveness and demonstrate accountability to donors. Supports CHS Commitment 4 (community participation) and PSEA network reporting."
  source: "`vibe_ngo_v1`.`safeguarding`.`community_awareness_session`"
  dimensions:
    - name: "session_type"
      expr: session_type
      comment: "Type of awareness session (PSEA, child protection, GBV, general safeguarding) — used for thematic coverage analysis."
    - name: "session_status"
      expr: session_status
      comment: "Current status of the session (Planned, Completed, Cancelled, Postponed) — pipeline management view."
    - name: "session_topic"
      expr: topic
      comment: "Topic covered in the session — used for content coverage analysis and gap identification."
    - name: "session_language_used"
      expr: language_used
      comment: "Language in which the session was delivered — used to assess language accessibility and localisation."
    - name: "session_location_district"
      expr: location_district
      comment: "District where the session was held — used for geographic coverage analysis."
    - name: "session_location_region"
      expr: location_region
      comment: "Region where the session was held — used for sub-national coverage tracking."
    - name: "session_translation_provided_flag"
      expr: translation_provided_flag
      comment: "Whether translation was provided — measures accessibility for non-primary-language communities."
    - name: "session_incident_reported_flag"
      expr: incident_reported_flag
      comment: "Whether an incident was reported during or following the session — measures session effectiveness in enabling reporting."
    - name: "session_referral_made_flag"
      expr: referral_made_flag
      comment: "Whether a referral was made following the session — measures the session's role in connecting community members to services."
    - name: "session_date_month"
      expr: DATE_TRUNC('MONTH', session_date)
      comment: "Month of session — used for trend analysis and programme planning."
    - name: "session_date_year"
      expr: YEAR(session_date)
      comment: "Year of session — used for annual reporting and donor compliance."
  measures:
    - name: "total_sessions_conducted"
      expr: COUNT(CASE WHEN session_status = 'Completed' THEN 1 END)
      comment: "Total number of completed community awareness sessions. Baseline output metric for the community engagement programme."
    - name: "total_feedback_received"
      expr: SUM(CAST(feedback_received AS DOUBLE))
      comment: "Total feedback score received across all sessions. Aggregate measure of community engagement quality and session effectiveness."
    - name: "avg_feedback_score"
      expr: AVG(CAST(feedback_received AS DOUBLE))
      comment: "Average feedback score per session. Tracks session quality over time; declining scores trigger content or facilitation review."
    - name: "incident_reporting_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN incident_reported_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN session_status = 'Completed' THEN 1 END), 0), 2)
      comment: "Percentage of completed sessions where an incident was reported. Measures the effectiveness of sessions in enabling community members to report safeguarding concerns."
    - name: "referral_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN referral_made_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN session_status = 'Completed' THEN 1 END), 0), 2)
      comment: "Percentage of completed sessions resulting in a referral. Measures the session's role in connecting community members to support services."
    - name: "translation_provision_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN translation_provided_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN session_status = 'Completed' THEN 1 END), 0), 2)
      comment: "Percentage of sessions where translation was provided. Measures language accessibility of the community engagement programme."
    - name: "follow_up_required_sessions_count"
      expr: COUNT(CASE WHEN follow_up_actions_required IS NOT NULL AND follow_up_actions_required != '' THEN 1 END)
      comment: "Number of sessions with outstanding follow-up actions. Tracks the follow-up pipeline and ensures community commitments are honoured."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_psea_network_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over PSEA network memberships. Tracks membership status, meeting attendance, protocol adoption rates, and fee compliance. Used by the PSEA Coordinator and Country Director to manage inter-agency coordination commitments and demonstrate engagement with the humanitarian PSEA architecture. Supports IASC PSEA network reporting requirements."
  source: "`vibe_ngo_v1`.`safeguarding`.`psea_network_membership`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current membership status (Active, Suspended, Withdrawn, Pending) — primary filter for active network engagement analysis."
    - name: "membership_region"
      expr: region
      comment: "Geographic region of the network membership — used for regional coordination coverage analysis."
    - name: "membership_meeting_attendance_frequency"
      expr: meeting_attendance_frequency
      comment: "Frequency of meeting attendance (Regular, Occasional, Rare, None) — measures engagement quality."
    - name: "membership_incident_reporting_protocol_adopted_flag"
      expr: incident_reporting_protocol_adopted_flag
      comment: "Whether the incident reporting protocol was adopted — measures commitment to inter-agency accountability standards."
    - name: "membership_survivor_referral_pathway_adopted_flag"
      expr: survivor_referral_pathway_adopted_flag
      comment: "Whether the survivor referral pathway was adopted — measures commitment to survivor-centred inter-agency coordination."
    - name: "membership_joint_training_participation_flag"
      expr: joint_training_participation_flag
      comment: "Whether joint training was participated in — measures investment in inter-agency capacity building."
    - name: "membership_start_year"
      expr: YEAR(membership_start_date)
      comment: "Year membership commenced — used for cohort analysis and network growth tracking."
  measures:
    - name: "total_network_memberships"
      expr: COUNT(1)
      comment: "Total number of PSEA network memberships. Baseline metric for inter-agency coordination footprint."
    - name: "active_memberships_count"
      expr: COUNT(CASE WHEN membership_status = 'Active' THEN 1 END)
      comment: "Number of currently active PSEA network memberships. Measures the breadth of active inter-agency coordination engagement."
    - name: "protocol_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN incident_reporting_protocol_adopted_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN membership_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active memberships where the incident reporting protocol was adopted. Measures alignment with inter-agency accountability standards."
    - name: "survivor_referral_pathway_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN survivor_referral_pathway_adopted_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN membership_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active memberships where the survivor referral pathway was adopted. Measures commitment to survivor-centred inter-agency coordination."
    - name: "total_membership_fees_paid_usd"
      expr: SUM(CAST(membership_fee_amount AS DOUBLE))
      comment: "Total membership fees paid across all network memberships in USD. Used for budget planning and financial accountability for inter-agency coordination."
    - name: "terms_of_reference_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN terms_of_reference_accepted_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN membership_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active memberships where the terms of reference were formally accepted. Measures governance compliance with network membership obligations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_donor_safeguarding_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over donor safeguarding requirements. Tracks compliance status, overdue requirements, waiver rates, and non-compliance risk levels. Used by the Grants Manager, PSEA Coordinator, and Finance Director to ensure all donor safeguarding conditions are met and to prevent grant suspension. Directly supports USAID, FCDO, EU, and UN donor audit readiness."
  source: "`vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement`"
  dimensions:
    - name: "requirement_type"
      expr: requirement_type
      comment: "Type of donor safeguarding requirement (policy, training, reporting, investigation, screening) — used for thematic compliance analysis."
    - name: "requirement_status"
      expr: requirement_status
      comment: "Current status of the requirement (Compliant, Non-Compliant, Pending, Waived) — primary compliance filter."
    - name: "requirement_compliance_status"
      expr: compliance_status
      comment: "Detailed compliance status — used for granular compliance tracking and escalation."
    - name: "requirement_mandatory_flag"
      expr: mandatory_flag
      comment: "Whether the requirement is mandatory — used to focus compliance tracking on non-negotiable conditions."
    - name: "requirement_non_compliance_risk_level"
      expr: non_compliance_risk_level
      comment: "Risk level of non-compliance (Critical, High, Medium, Low) — used to prioritise remediation resources."
    - name: "requirement_frequency"
      expr: frequency
      comment: "Reporting or compliance frequency (annual, quarterly, ad hoc) — used for compliance calendar management."
    - name: "requirement_waiver_granted_flag"
      expr: waiver_granted_flag
      comment: "Whether a waiver was granted — used to track exceptions and assess waiver management governance."
    - name: "requirement_due_year"
      expr: YEAR(due_date)
      comment: "Year the requirement is due — used for annual compliance planning."
  measures:
    - name: "total_donor_requirements"
      expr: COUNT(1)
      comment: "Total number of donor safeguarding requirements tracked. Baseline metric for compliance portfolio scope."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status IN ('Compliant', 'Met') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of donor safeguarding requirements in compliance. Core grant management KPI; below-target rates trigger immediate escalation to prevent grant suspension."
    - name: "overdue_mandatory_requirements_count"
      expr: COUNT(CASE WHEN mandatory_flag = TRUE AND due_date < CURRENT_DATE() AND compliance_status NOT IN ('Compliant', 'Met', 'Waived') THEN 1 END)
      comment: "Number of overdue mandatory donor safeguarding requirements. Non-zero values represent acute grant compliance risk requiring immediate management action."
    - name: "critical_non_compliance_count"
      expr: COUNT(CASE WHEN non_compliance_risk_level = 'Critical' AND compliance_status NOT IN ('Compliant', 'Met', 'Waived') THEN 1 END)
      comment: "Number of requirements with critical non-compliance risk that are not yet met. Highest-priority compliance risk indicator; triggers Board-level escalation."
    - name: "waiver_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN waiver_granted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requirements where a waiver was granted. High waiver rates may indicate systemic compliance capacity gaps or governance concerns."
    - name: "upcoming_due_requirements_30_days"
      expr: COUNT(CASE WHEN due_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 30) AND compliance_status NOT IN ('Compliant', 'Met', 'Waived') THEN 1 END)
      comment: "Number of non-compliant requirements due within the next 30 days. Forward-looking compliance risk indicator used for weekly grant management reviews."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_policy_acknowledgment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over safeguarding policy acknowledgments. Tracks acknowledgment completion rates, renewal compliance, and overdue acknowledgments by acknowledger type. Used by HR, the PSEA Coordinator, and donors to verify that all staff, partners, and volunteers have formally acknowledged safeguarding policies. Required for CHS compliance and donor pre-award checks."
  source: "`vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment`"
  dimensions:
    - name: "acknowledgment_status"
      expr: acknowledgment_status
      comment: "Current acknowledgment status (Acknowledged, Pending, Overdue, Expired) — primary compliance filter."
    - name: "acknowledger_type"
      expr: acknowledger_type
      comment: "Type of acknowledger (staff, partner, volunteer, contractor) — enables disaggregated compliance reporting."
    - name: "acknowledgment_method"
      expr: acknowledgment_method
      comment: "Method of acknowledgment (digital, paper, LMS) — used to assess accessibility and audit trail quality."
    - name: "acknowledgment_language"
      expr: acknowledgment_language
      comment: "Language of acknowledgment — used to assess language accessibility and localisation."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Whether renewal is required — used to manage the renewal pipeline."
    - name: "training_completion_required_flag"
      expr: training_completion_required_flag
      comment: "Whether training completion was required alongside acknowledgment — used to track combined compliance."
    - name: "acknowledgment_year"
      expr: YEAR(acknowledgment_date)
      comment: "Year of acknowledgment — used for annual compliance reporting."
  measures:
    - name: "total_acknowledgments"
      expr: COUNT(1)
      comment: "Total number of safeguarding policy acknowledgments recorded. Baseline metric for policy acknowledgment programme coverage."
    - name: "acknowledgment_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN acknowledgment_status = 'Acknowledged' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of required acknowledgments completed. Core HR and donor compliance KPI; below-target rates trigger immediate follow-up and may block programme launches."
    - name: "overdue_acknowledgments_count"
      expr: COUNT(CASE WHEN acknowledgment_valid_until_date < CURRENT_DATE() AND acknowledgment_status != 'Acknowledged' THEN 1 END)
      comment: "Number of overdue safeguarding policy acknowledgments. Non-zero values represent compliance risk; triggers HR follow-up and escalation."
    - name: "renewal_due_within_30_days_count"
      expr: COUNT(CASE WHEN next_renewal_due_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 30) AND renewal_required_flag = TRUE THEN 1 END)
      comment: "Number of acknowledgments due for renewal within 30 days. Forward-looking compliance indicator used for proactive HR outreach."
    - name: "digital_acknowledgment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN acknowledgment_method IN ('Digital', 'Online', 'LMS', 'Electronic') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of acknowledgments completed digitally. Measures the maturity of the digital compliance infrastructure and audit trail quality."
    - name: "combined_training_and_acknowledgment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN training_completion_required_flag = TRUE AND training_completion_date IS NOT NULL AND acknowledgment_status = 'Acknowledged' THEN 1 END) / NULLIF(COUNT(CASE WHEN training_completion_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of records requiring both training and acknowledgment where both were completed. Measures full compliance with combined training-and-acknowledgment requirements."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_survivor_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Survivor support metrics tracking survivor demographics, support provision, case management, and confidentiality compliance for survivor-centered response"
  source: "`vibe_ngo_v1`.`safeguarding`.`survivor_record`"
  dimensions:
    - name: "survivor_type"
      expr: survivor_type
      comment: "Type of survivor (direct, indirect, witness, etc.)"
    - name: "gender"
      expr: gender
      comment: "Gender of the survivor"
    - name: "age_group"
      expr: age_group
      comment: "Age group of the survivor"
    - name: "support_status"
      expr: support_status
      comment: "Current status of support provision (active, completed, declined, etc.)"
    - name: "consent_status"
      expr: consent_status
      comment: "Status of survivor consent for support and data processing"
    - name: "referral_source"
      expr: referral_source
      comment: "Source of the survivor referral"
    - name: "access_restriction_level"
      expr: access_restriction_level
      comment: "Access restriction level for survivor data"
    - name: "case_closure_reason"
      expr: case_closure_reason
      comment: "Reason for case closure"
    - name: "support_start_year"
      expr: YEAR(support_start_date)
      comment: "Year when support started"
    - name: "support_start_month"
      expr: DATE_TRUNC('MONTH', support_start_date)
      comment: "Month when support started"
  measures:
    - name: "total_survivors"
      expr: COUNT(1)
      comment: "Total number of survivor records"
    - name: "survivors_receiving_medical_support"
      expr: SUM(CASE WHEN medical_support_provided = TRUE THEN 1 ELSE 0 END)
      comment: "Number of survivors who received medical support"
    - name: "survivors_receiving_psychosocial_support"
      expr: SUM(CASE WHEN psychosocial_support_provided = TRUE THEN 1 ELSE 0 END)
      comment: "Number of survivors who received psychosocial support"
    - name: "survivors_receiving_legal_support"
      expr: SUM(CASE WHEN legal_support_provided = TRUE THEN 1 ELSE 0 END)
      comment: "Number of survivors who received legal support"
    - name: "survivors_receiving_economic_support"
      expr: SUM(CASE WHEN economic_support_provided = TRUE THEN 1 ELSE 0 END)
      comment: "Number of survivors who received economic support"
    - name: "survivors_with_external_referrals"
      expr: SUM(CASE WHEN external_referral_made = TRUE THEN 1 ELSE 0 END)
      comment: "Number of survivors referred to external support services"
    - name: "survivors_with_safety_plans"
      expr: SUM(CASE WHEN safety_plan_in_place = TRUE THEN 1 ELSE 0 END)
      comment: "Number of survivors with documented safety plans"
    - name: "survivors_with_confidentiality_breaches"
      expr: SUM(CASE WHEN confidentiality_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of survivor records with documented confidentiality breaches - critical compliance metric"
    - name: "pct_survivors_with_psychosocial_support"
      expr: ROUND(100.0 * SUM(CASE WHEN psychosocial_support_provided = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of survivors receiving psychosocial support - key quality indicator"
    - name: "pct_survivors_with_safety_plans"
      expr: ROUND(100.0 * SUM(CASE WHEN safety_plan_in_place = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of survivors with safety plans - key protection indicator"
$$;