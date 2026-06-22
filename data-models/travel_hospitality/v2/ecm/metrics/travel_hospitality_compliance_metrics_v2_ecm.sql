-- Metric views for domain: compliance | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-22 18:44:46

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit performance and cost metrics tracking compliance audit outcomes, findings severity, and associated costs across properties and audit types. Enables leadership to assess audit program effectiveness and regulatory risk exposure."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of compliance audit (e.g., internal, external, regulatory) for segmenting audit performance."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (e.g., planned, in-progress, completed, closed)."
    - name: "overall_audit_result"
      expr: overall_audit_result
      comment: "Final result of the audit (e.g., pass, fail, conditional pass) for outcome analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the audit (e.g., low, medium, high, critical)."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework under which the audit was conducted (e.g., ISO, HACCP, PCI-DSS)."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction in which the audit applies, enabling geographic compliance analysis."
    - name: "certification_awarded"
      expr: certification_awarded
      comment: "Whether a certification was awarded as a result of the audit."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action was required following the audit."
    - name: "scheduled_date_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month the audit was scheduled, for trend analysis over time."
    - name: "actual_start_date_month"
      expr: DATE_TRUNC('MONTH', actual_start_date)
      comment: "Month the audit actually started, for scheduling adherence analysis."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audits conducted. Baseline KPI for audit program volume and coverage."
    - name: "total_audit_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total monetary cost of all audits. Drives budget planning and cost-per-audit benchmarking."
    - name: "avg_audit_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per audit. Enables cost efficiency benchmarking across audit types and jurisdictions."
    - name: "avg_overall_audit_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average compliance score across all audits. Key indicator of overall compliance health and regulatory standing."
    - name: "audits_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of audits that required corrective action. Signals systemic compliance gaps requiring management intervention."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring corrective action. High rates indicate systemic compliance risk and drive remediation investment decisions."
    - name: "certification_award_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_awarded = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits resulting in certification award. Measures compliance program maturity and regulatory credibility."
    - name: "follow_up_audit_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_audit_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring a follow-up audit. Elevated rates indicate persistent non-compliance issues."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding severity, resolution, and financial impact metrics. Enables compliance leadership to prioritize remediation, track repeat findings, and quantify regulatory exposure."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the audit finding (e.g., open, in-remediation, closed, verified)."
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the finding (e.g., safety, data privacy, financial controls) for thematic analysis."
    - name: "compliance_domain"
      expr: compliance_domain
      comment: "Compliance domain the finding belongs to (e.g., food safety, fire safety, data protection)."
    - name: "repeat_finding_flag"
      expr: repeat_finding_flag
      comment: "Whether this finding is a repeat of a prior finding, indicating systemic non-compliance."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the finding has been escalated, indicating severity or urgency."
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Whether the finding requires regulatory reporting, indicating external compliance obligations."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether corrective action is required for this finding."
    - name: "guest_impact_flag"
      expr: guest_impact_flag
      comment: "Whether the finding has a direct guest impact, linking compliance to guest experience outcomes."
    - name: "identified_date_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the finding was identified, for trend and aging analysis."
    - name: "root_cause_classification"
      expr: root_cause_classification
      comment: "Root cause classification of the finding for systemic issue analysis."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings. Baseline measure of compliance gap volume."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Total estimated financial impact of all audit findings. Quantifies monetary risk exposure from compliance gaps."
    - name: "avg_financial_impact_per_finding"
      expr: AVG(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Average estimated financial impact per finding. Enables prioritization of high-cost remediation efforts."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across all findings. Key indicator of overall compliance risk posture."
    - name: "repeat_finding_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN repeat_finding_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that are repeats of prior findings. High rates signal systemic control failures requiring structural intervention."
    - name: "open_findings_count"
      expr: COUNT(CASE WHEN finding_status = 'open' THEN 1 END)
      comment: "Number of currently open findings. Drives remediation workload planning and regulatory risk assessment."
    - name: "escalated_findings_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of escalated findings requiring senior management attention."
    - name: "regulatory_reportable_findings_count"
      expr: COUNT(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 END)
      comment: "Number of findings requiring regulatory reporting. Directly informs regulatory disclosure obligations and legal risk."
    - name: "guest_impact_findings_count"
      expr: COUNT(CASE WHEN guest_impact_flag = TRUE THEN 1 END)
      comment: "Number of findings with direct guest impact. Links compliance performance to guest satisfaction and brand risk."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and preventive action (CAPA) effectiveness, cost, and timeliness metrics. Enables compliance and operations leadership to track remediation performance and prevent recurrence of compliance failures."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`corrective_action`"
  dimensions:
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Current status of the corrective action (e.g., open, in-progress, completed, verified)."
    - name: "capa_type"
      expr: capa_type
      comment: "Type of CAPA (corrective vs. preventive) for categorizing remediation activities."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category the corrective action addresses (e.g., safety, privacy, financial)."
    - name: "priority"
      expr: priority
      comment: "Priority level of the corrective action (e.g., critical, high, medium, low)."
    - name: "recurrence_detected"
      expr: recurrence_detected
      comment: "Whether the underlying issue recurred after a prior corrective action, indicating control failure."
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Whether regulatory notification is required for this corrective action."
    - name: "assigned_department"
      expr: assigned_department
      comment: "Department responsible for executing the corrective action, for accountability tracking."
    - name: "target_completion_date_month"
      expr: DATE_TRUNC('MONTH', target_completion_date)
      comment: "Month the corrective action is targeted for completion, for workload forecasting."
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total number of corrective actions. Baseline measure of remediation workload."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred for corrective actions. Drives compliance remediation budget management."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of corrective actions. Enables budget forecasting for compliance remediation programs."
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per corrective action. Benchmarks remediation efficiency across compliance categories."
    - name: "cost_overrun_amount"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(estimated_cost AS DOUBLE))
      comment: "Total cost overrun (actual minus estimated) across corrective actions. Signals budget planning accuracy and project management effectiveness."
    - name: "recurrence_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_detected = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions where the issue recurred. High rates indicate ineffective root cause analysis or control design."
    - name: "completed_actions_count"
      expr: COUNT(CASE WHEN corrective_action_status = 'completed' THEN 1 END)
      comment: "Number of corrective actions completed. Measures remediation throughput and program execution velocity."
    - name: "regulatory_notification_required_count"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END)
      comment: "Number of corrective actions requiring regulatory notification. Informs legal and compliance disclosure obligations."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_health_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health and safety incident frequency, severity, and regulatory reporting metrics. Critical for executive safety governance, OSHA compliance, and insurance risk management."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of health and safety incident (e.g., slip/fall, chemical exposure, equipment injury)."
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident (e.g., reported, under investigation, closed)."
    - name: "injury_severity"
      expr: injury_severity
      comment: "Severity of injury resulting from the incident (e.g., minor, moderate, severe, fatality)."
    - name: "person_type_involved"
      expr: person_type_involved
      comment: "Type of person involved (e.g., employee, guest, contractor) for targeted safety program design."
    - name: "osha_recordable_flag"
      expr: osha_recordable_flag
      comment: "Whether the incident is OSHA-recordable, directly impacting regulatory compliance reporting."
    - name: "regulatory_notification_required_flag"
      expr: regulatory_notification_required_flag
      comment: "Whether regulatory notification is required for this incident."
    - name: "workers_compensation_claim_flag"
      expr: workers_compensation_claim_flag
      comment: "Whether a workers compensation claim was filed, linking safety to financial liability."
    - name: "liability_claim_filed_flag"
      expr: liability_claim_filed_flag
      comment: "Whether a liability claim was filed, indicating legal and financial exposure."
    - name: "incident_date_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of the incident for trend analysis and seasonal safety pattern identification."
    - name: "location_within_property"
      expr: location_within_property
      comment: "Location within the property where the incident occurred, for hotspot identification."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of health and safety incidents. Primary safety KPI for executive safety governance."
    - name: "osha_recordable_incidents"
      expr: COUNT(CASE WHEN osha_recordable_flag = TRUE THEN 1 END)
      comment: "Number of OSHA-recordable incidents. Directly drives regulatory compliance reporting and penalty risk."
    - name: "osha_recordable_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN osha_recordable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that are OSHA-recordable. Key safety compliance KPI for regulatory benchmarking."
    - name: "workers_comp_claims_count"
      expr: COUNT(CASE WHEN workers_compensation_claim_flag = TRUE THEN 1 END)
      comment: "Number of incidents resulting in workers compensation claims. Drives insurance cost and workforce safety investment decisions."
    - name: "liability_claims_count"
      expr: COUNT(CASE WHEN liability_claim_filed_flag = TRUE THEN 1 END)
      comment: "Number of incidents resulting in liability claims. Quantifies legal and financial exposure from safety failures."
    - name: "regulatory_notification_required_count"
      expr: COUNT(CASE WHEN regulatory_notification_required_flag = TRUE THEN 1 END)
      comment: "Number of incidents requiring regulatory notification. Informs compliance disclosure obligations and regulatory relationship management."
    - name: "medical_treatment_incidents_count"
      expr: COUNT(CASE WHEN medical_treatment_provided_flag = TRUE THEN 1 END)
      comment: "Number of incidents requiring medical treatment. Indicates severity distribution and drives first-aid resource planning."
    - name: "guest_incidents_count"
      expr: COUNT(CASE WHEN person_type_involved = 'guest' THEN 1 END)
      comment: "Number of incidents involving guests. Directly links safety performance to guest experience and brand reputation risk."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enterprise compliance risk profile metrics tracking inherent and residual risk scores, financial exposure, and mitigation effectiveness. Enables board-level risk governance and compliance investment prioritization."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`risk_register`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Category of compliance risk (e.g., regulatory, operational, financial, reputational)."
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk (e.g., open, mitigated, accepted, closed)."
    - name: "risk_subcategory"
      expr: risk_subcategory
      comment: "Subcategory of risk for granular risk portfolio analysis."
    - name: "likelihood_rating"
      expr: likelihood_rating
      comment: "Likelihood rating of the risk materializing (e.g., rare, unlikely, possible, likely, almost certain)."
    - name: "impact_rating"
      expr: impact_rating
      comment: "Impact rating if the risk materializes (e.g., negligible, minor, moderate, major, catastrophic)."
    - name: "control_effectiveness"
      expr: control_effectiveness
      comment: "Effectiveness of existing controls in mitigating the risk (e.g., strong, adequate, weak, none)."
    - name: "scope_level"
      expr: scope_level
      comment: "Scope level of the risk (e.g., property, regional, enterprise) for escalation decisions."
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Whether the risk requires escalation to senior leadership."
    - name: "identification_date_month"
      expr: DATE_TRUNC('MONTH', identification_date)
      comment: "Month the risk was identified, for risk emergence trend analysis."
  measures:
    - name: "total_risks"
      expr: COUNT(1)
      comment: "Total number of risks in the register. Baseline measure of compliance risk portfolio size."
    - name: "avg_inherent_risk_score"
      expr: AVG(CAST(inherent_risk_score AS DOUBLE))
      comment: "Average inherent risk score before controls. Measures gross compliance risk exposure across the portfolio."
    - name: "avg_residual_risk_score"
      expr: AVG(CAST(residual_risk_score AS DOUBLE))
      comment: "Average residual risk score after controls. Key indicator of net compliance risk posture after mitigation investment."
    - name: "risk_reduction_score"
      expr: AVG(CAST(inherent_risk_score AS DOUBLE) - CAST(residual_risk_score AS DOUBLE))
      comment: "Average risk score reduction achieved by controls (inherent minus residual). Measures the effectiveness of the compliance control framework."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total estimated financial impact of all risks in the register. Quantifies aggregate monetary exposure for board-level risk governance."
    - name: "total_mitigation_cost_estimate"
      expr: SUM(CAST(mitigation_cost_estimate AS DOUBLE))
      comment: "Total estimated cost to mitigate all risks. Drives compliance investment budget planning."
    - name: "avg_mitigation_cost"
      expr: AVG(CAST(mitigation_cost_estimate AS DOUBLE))
      comment: "Average mitigation cost per risk. Enables cost-benefit analysis of compliance control investments."
    - name: "escalated_risks_count"
      expr: COUNT(CASE WHEN escalation_required_flag = TRUE THEN 1 END)
      comment: "Number of risks requiring escalation to senior leadership. Drives executive risk governance agenda."
    - name: "open_risks_count"
      expr: COUNT(CASE WHEN risk_status = 'open' THEN 1 END)
      comment: "Number of currently open risks. Measures unresolved compliance risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Permit portfolio health, cost, and compliance status metrics. Enables property operations and legal teams to manage permit renewals, avoid lapses, and control permit-related costs."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`permit`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of permit (e.g., liquor license, food service, building, fire safety) for portfolio segmentation."
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the permit (e.g., active, expired, suspended, revoked, pending renewal)."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction issuing the permit, for geographic compliance portfolio management."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the permit, for regulatory relationship management."
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Whether the permit requires periodic inspections."
    - name: "holder_type"
      expr: holder_type
      comment: "Type of permit holder (e.g., property, entity, individual) for portfolio analysis."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month the permit expires, for renewal pipeline planning."
  measures:
    - name: "total_permits"
      expr: COUNT(1)
      comment: "Total number of permits in the portfolio. Baseline measure of regulatory licensing scope."
    - name: "total_permit_fees"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total permit fees paid. Drives regulatory cost management and budget planning."
    - name: "avg_permit_fee"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average permit fee. Enables benchmarking of regulatory costs across jurisdictions and permit types."
    - name: "total_renewal_fees"
      expr: SUM(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Total renewal fees across all permits. Informs annual compliance budget forecasting."
    - name: "active_permits_count"
      expr: COUNT(CASE WHEN permit_status = 'active' THEN 1 END)
      comment: "Number of currently active permits. Measures regulatory coverage and licensing compliance."
    - name: "expired_permits_count"
      expr: COUNT(CASE WHEN permit_status = 'expired' THEN 1 END)
      comment: "Number of expired permits. Directly indicates regulatory non-compliance risk and potential operational shutdown exposure."
    - name: "suspended_or_revoked_permits_count"
      expr: COUNT(CASE WHEN permit_status IN ('suspended', 'revoked') THEN 1 END)
      comment: "Number of suspended or revoked permits. Critical indicator of severe regulatory non-compliance requiring immediate executive action."
    - name: "permit_lapse_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN permit_status IN ('expired', 'suspended', 'revoked') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of permits that have lapsed (expired, suspended, or revoked). Key compliance health KPI for property operations leadership."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_privacy_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data privacy incident severity, regulatory exposure, and notification compliance metrics. Critical for GDPR/CCPA compliance governance, DPO reporting, and executive privacy risk management."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`privacy_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of privacy incident (e.g., unauthorized access, data breach, accidental disclosure)."
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the privacy incident (e.g., reported, under investigation, resolved, closed)."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the privacy incident (e.g., low, medium, high, critical)."
    - name: "breach_notification_required_flag"
      expr: breach_notification_required_flag
      comment: "Whether breach notification to regulators or subjects is required."
    - name: "regulatory_penalty_imposed_flag"
      expr: regulatory_penalty_imposed_flag
      comment: "Whether a regulatory penalty was imposed, indicating enforcement action."
    - name: "dpo_notified_flag"
      expr: dpo_notified_flag
      comment: "Whether the Data Protection Officer was notified, indicating proper governance process adherence."
    - name: "legal_counsel_engaged_flag"
      expr: legal_counsel_engaged_flag
      comment: "Whether legal counsel was engaged, indicating elevated legal risk."
    - name: "discovery_date_month"
      expr: DATE_TRUNC('MONTH', discovery_date)
      comment: "Month the privacy incident was discovered, for trend analysis."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the privacy incident investigation."
  measures:
    - name: "total_privacy_incidents"
      expr: COUNT(1)
      comment: "Total number of privacy incidents. Primary KPI for data protection governance and regulatory risk monitoring."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total regulatory penalties imposed for privacy incidents. Directly quantifies financial cost of privacy non-compliance."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average regulatory penalty per incident. Benchmarks privacy enforcement severity and informs compliance investment decisions."
    - name: "breach_notification_required_count"
      expr: COUNT(CASE WHEN breach_notification_required_flag = TRUE THEN 1 END)
      comment: "Number of incidents requiring breach notification. Drives regulatory disclosure workload and legal risk management."
    - name: "regulatory_penalty_incidents_count"
      expr: COUNT(CASE WHEN regulatory_penalty_imposed_flag = TRUE THEN 1 END)
      comment: "Number of incidents resulting in regulatory penalties. Key indicator of enforcement exposure and compliance program effectiveness."
    - name: "penalty_incident_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_penalty_imposed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of privacy incidents resulting in regulatory penalties. Measures regulatory enforcement risk and compliance program maturity."
    - name: "open_investigations_count"
      expr: COUNT(CASE WHEN investigation_status NOT IN ('completed', 'closed') THEN 1 END)
      comment: "Number of privacy incidents with open investigations. Measures investigation backlog and resource requirements."
    - name: "litigation_filed_count"
      expr: COUNT(CASE WHEN litigation_filed_flag = TRUE THEN 1 END)
      comment: "Number of privacy incidents resulting in litigation. Quantifies legal liability exposure from data protection failures."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance training completion rates, pass rates, and cost metrics. Enables HR and compliance leadership to ensure regulatory training obligations are met and measure training program effectiveness."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the training completion record (e.g., compliant, non-compliant, expired)."
    - name: "pass_fail_result"
      expr: pass_fail_result
      comment: "Pass or fail result of the training assessment."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Training delivery method (e.g., online, classroom, blended) for program design optimization."
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Whether the training is mandatory for regulatory compliance."
    - name: "regulatory_category"
      expr: regulatory_category
      comment: "Regulatory category the training addresses (e.g., food safety, fire safety, data privacy)."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Whether the training certification requires periodic renewal."
    - name: "waiver_granted_flag"
      expr: waiver_granted_flag
      comment: "Whether a training waiver was granted, for exception tracking."
    - name: "department_code"
      expr: department_code
      comment: "Department of the employee completing training, for departmental compliance rate analysis."
    - name: "completion_date_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month training was completed, for compliance deadline tracking."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction for which the training satisfies regulatory requirements."
  measures:
    - name: "total_training_completions"
      expr: COUNT(1)
      comment: "Total number of training completion records. Baseline measure of compliance training program volume."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_result = 'pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training completions resulting in a pass. Measures training program effectiveness and employee competency."
    - name: "avg_score_achieved"
      expr: AVG(CAST(score_achieved AS DOUBLE))
      comment: "Average assessment score achieved across all training completions. Indicates overall workforce compliance knowledge level."
    - name: "avg_passing_score_threshold"
      expr: AVG(CAST(passing_score_threshold AS DOUBLE))
      comment: "Average passing score threshold across training programs. Provides context for interpreting pass rates."
    - name: "total_training_cost"
      expr: SUM(CAST(training_cost_amount AS DOUBLE))
      comment: "Total cost of compliance training. Drives training budget management and cost-per-completion benchmarking."
    - name: "avg_training_cost"
      expr: AVG(CAST(training_cost_amount AS DOUBLE))
      comment: "Average cost per training completion. Enables cost efficiency comparison across delivery methods and providers."
    - name: "total_training_hours"
      expr: SUM(CAST(training_duration_hours AS DOUBLE))
      comment: "Total hours invested in compliance training. Measures workforce compliance training investment."
    - name: "waiver_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN waiver_granted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training completions where a waiver was granted. High rates may indicate training accessibility issues or policy gaps."
    - name: "mandatory_training_completions"
      expr: COUNT(CASE WHEN mandatory_flag = TRUE THEN 1 END)
      comment: "Number of mandatory compliance training completions. Directly measures fulfillment of regulatory training obligations."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_environmental_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental compliance performance metrics including energy consumption, carbon emissions, water usage, waste diversion, and penalty exposure. Enables ESG reporting and sustainability governance."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current environmental compliance status (e.g., compliant, non-compliant, under review)."
    - name: "certification_status"
      expr: certification_status
      comment: "Status of environmental certification (e.g., certified, pending, expired)."
    - name: "sustainability_certification"
      expr: sustainability_certification
      comment: "Type of sustainability certification held (e.g., LEED, Green Key, ISO 14001)."
    - name: "violation_flag"
      expr: violation_flag
      comment: "Whether an environmental violation was recorded, indicating regulatory non-compliance."
    - name: "violation_severity"
      expr: violation_severity
      comment: "Severity of the environmental violation (e.g., minor, major, critical)."
    - name: "esg_reporting_flag"
      expr: esg_reporting_flag
      comment: "Whether this record is included in ESG reporting, for sustainability disclosure tracking."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction for environmental compliance requirements."
    - name: "reporting_period_start_month"
      expr: DATE_TRUNC('MONTH', reporting_period_start)
      comment: "Start month of the environmental reporting period for trend analysis."
    - name: "carbon_emissions_framework"
      expr: carbon_emissions_framework
      comment: "Carbon accounting framework used (e.g., GHG Protocol, CDP) for ESG comparability."
  measures:
    - name: "total_carbon_emissions_tonnes"
      expr: SUM(CAST(carbon_emissions_tonnes AS DOUBLE))
      comment: "Total carbon emissions in tonnes. Primary ESG KPI for climate commitment tracking and regulatory reporting."
    - name: "avg_carbon_emissions_tonnes"
      expr: AVG(CAST(carbon_emissions_tonnes AS DOUBLE))
      comment: "Average carbon emissions per property/period. Enables benchmarking and target-setting for decarbonization programs."
    - name: "total_energy_consumption_kwh"
      expr: SUM(CAST(energy_consumption_kwh AS DOUBLE))
      comment: "Total energy consumption in kWh. Drives energy efficiency investment decisions and utility cost management."
    - name: "avg_energy_intensity_ratio"
      expr: AVG(CAST(energy_intensity_ratio AS DOUBLE))
      comment: "Average energy intensity ratio (energy per unit of output). Key efficiency KPI for sustainability benchmarking."
    - name: "total_water_consumption_cubic_meters"
      expr: SUM(CAST(water_consumption_cubic_meters AS DOUBLE))
      comment: "Total water consumption in cubic meters. Drives water conservation program investment and regulatory compliance."
    - name: "total_waste_diverted_tonnes"
      expr: SUM(CAST(waste_diverted_tonnes AS DOUBLE))
      comment: "Total waste diverted from landfill in tonnes. Measures circular economy and waste reduction program effectiveness."
    - name: "avg_recycling_rate_pct"
      expr: AVG(CAST(recycling_rate_percentage AS DOUBLE))
      comment: "Average recycling rate percentage. Key sustainability KPI for waste management program performance."
    - name: "avg_renewable_energy_pct"
      expr: AVG(CAST(renewable_energy_percentage AS DOUBLE))
      comment: "Average percentage of energy from renewable sources. Measures progress toward clean energy commitments."
    - name: "total_environmental_penalties"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total monetary penalties for environmental violations. Quantifies financial cost of environmental non-compliance."
    - name: "violation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN violation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of environmental compliance records with violations. Measures environmental compliance program effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory obligation compliance status, penalty exposure, and certification metrics. Enables compliance leadership to track obligation fulfillment, manage regulatory risk, and prioritize remediation."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`obligation`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the obligation (e.g., compliant, non-compliant, in-progress, overdue)."
    - name: "obligation_status"
      expr: obligation_status
      comment: "Lifecycle status of the obligation (e.g., active, expired, superseded)."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the obligation (e.g., low, medium, high, critical)."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction in which the obligation applies."
    - name: "certification_required_flag"
      expr: certification_required_flag
      comment: "Whether the obligation requires a certification."
    - name: "waiver_granted_flag"
      expr: waiver_granted_flag
      comment: "Whether a waiver has been granted for this obligation."
    - name: "applicable_department"
      expr: applicable_department
      comment: "Department responsible for fulfilling the obligation."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the obligation is due, for compliance deadline management."
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of regulatory obligations. Baseline measure of compliance obligation portfolio scope."
    - name: "non_compliant_obligations_count"
      expr: COUNT(CASE WHEN compliance_status = 'non-compliant' THEN 1 END)
      comment: "Number of obligations currently in non-compliant status. Primary indicator of regulatory exposure requiring immediate action."
    - name: "non_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'non-compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of obligations in non-compliant status. Key compliance health KPI for executive and board reporting."
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total potential penalty amount across all non-compliant obligations. Quantifies aggregate regulatory financial risk."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per obligation. Enables risk-weighted prioritization of compliance remediation efforts."
    - name: "high_risk_obligations_count"
      expr: COUNT(CASE WHEN risk_level IN ('high', 'critical') THEN 1 END)
      comment: "Number of high or critical risk obligations. Drives compliance resource allocation and executive escalation decisions."
    - name: "waiver_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN waiver_granted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of obligations with waivers granted. Monitors exception management and regulatory accommodation patterns."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_sanction_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sanctions screening match rates, risk levels, and resolution metrics. Critical for AML/KYC compliance, regulatory reporting, and financial crime risk management."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`sanction_screening`"
  dimensions:
    - name: "screening_status"
      expr: screening_status
      comment: "Current status of the screening (e.g., pending, completed, escalated)."
    - name: "match_found_flag"
      expr: match_found_flag
      comment: "Whether a sanctions list match was found during screening."
    - name: "match_disposition"
      expr: match_disposition
      comment: "Disposition of the match (e.g., true positive, false positive, under review)."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the screened entity (e.g., low, medium, high)."
    - name: "screened_entity_type"
      expr: screened_entity_type
      comment: "Type of entity screened (e.g., guest, vendor, corporate account) for AML program segmentation."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the screening result was escalated for further review."
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Whether the screening result requires regulatory reporting."
    - name: "screening_date_month"
      expr: DATE_TRUNC('MONTH', screening_date)
      comment: "Month of screening for trend analysis and compliance program monitoring."
    - name: "screening_provider"
      expr: screening_provider
      comment: "Sanctions screening provider used, for vendor performance evaluation."
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total number of sanctions screenings conducted. Baseline measure of AML/KYC program coverage."
    - name: "match_found_count"
      expr: COUNT(CASE WHEN match_found_flag = TRUE THEN 1 END)
      comment: "Number of screenings with a sanctions list match found. Primary AML risk indicator requiring investigation."
    - name: "match_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN match_found_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings resulting in a match. Measures AML risk exposure in the customer and vendor portfolio."
    - name: "avg_match_confidence_score"
      expr: AVG(CAST(match_confidence_score AS DOUBLE))
      comment: "Average confidence score of sanctions matches. Informs false positive rate and screening algorithm quality."
    - name: "avg_match_score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average match score across all screenings. Enables calibration of screening thresholds and false positive management."
    - name: "escalated_screenings_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of screenings escalated for senior review. Measures high-risk case volume requiring compliance officer attention."
    - name: "regulatory_reportable_screenings_count"
      expr: COUNT(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 END)
      comment: "Number of screenings requiring regulatory reporting. Drives AML disclosure obligations and regulatory relationship management."
    - name: "unresolved_screenings_count"
      expr: COUNT(CASE WHEN resolution_status NOT IN ('resolved', 'cleared', 'closed') THEN 1 END)
      comment: "Number of screenings without a final resolution. Measures AML investigation backlog and compliance program timeliness."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_whistleblower_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Whistleblower report volume, substantiation rates, and investigation timeliness metrics. Enables ethics and compliance leadership to assess speak-up culture health and investigation program effectiveness."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the whistleblower case (e.g., open, under investigation, closed, substantiated)."
    - name: "allegation_category"
      expr: allegation_category
      comment: "Category of allegation (e.g., fraud, harassment, safety violation, financial misconduct)."
    - name: "allegation_subcategory"
      expr: allegation_subcategory
      comment: "Subcategory of allegation for granular ethics program analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the report (e.g., critical, high, medium, low)."
    - name: "anonymous_flag"
      expr: anonymous_flag
      comment: "Whether the report was submitted anonymously, for speak-up culture analysis."
    - name: "substantiated_flag"
      expr: substantiated_flag
      comment: "Whether the allegation was substantiated following investigation."
    - name: "retaliation_reported_flag"
      expr: retaliation_reported_flag
      comment: "Whether retaliation against the reporter was reported, indicating speak-up culture risk."
    - name: "regulatory_escalation_required_flag"
      expr: regulatory_escalation_required_flag
      comment: "Whether the report requires regulatory escalation."
    - name: "intake_channel"
      expr: intake_channel
      comment: "Channel through which the report was submitted (e.g., hotline, email, in-person)."
    - name: "report_date_month"
      expr: DATE_TRUNC('MONTH', report_date)
      comment: "Month the report was submitted, for trend analysis."
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total number of whistleblower reports. Baseline measure of ethics program utilization and speak-up culture health."
    - name: "substantiation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN substantiated_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports that were substantiated. Measures the quality of reports received and seriousness of ethics issues."
    - name: "anonymous_report_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN anonymous_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports submitted anonymously. High rates may indicate fear of retaliation and speak-up culture concerns."
    - name: "retaliation_reported_count"
      expr: COUNT(CASE WHEN retaliation_reported_flag = TRUE THEN 1 END)
      comment: "Number of reports where retaliation was reported. Critical indicator of speak-up culture health and legal liability."
    - name: "open_cases_count"
      expr: COUNT(CASE WHEN case_status NOT IN ('closed', 'resolved') THEN 1 END)
      comment: "Number of currently open whistleblower cases. Measures investigation backlog and program responsiveness."
    - name: "regulatory_escalation_count"
      expr: COUNT(CASE WHEN regulatory_escalation_required_flag = TRUE THEN 1 END)
      comment: "Number of reports requiring regulatory escalation. Indicates severity of ethics violations with external compliance implications."
    - name: "audit_committee_notified_count"
      expr: COUNT(CASE WHEN audit_committee_notified_flag = TRUE THEN 1 END)
      comment: "Number of reports escalated to the audit committee. Measures governance escalation of serious ethics matters."
    - name: "legal_hold_cases_count"
      expr: COUNT(CASE WHEN legal_hold_flag = TRUE THEN 1 END)
      comment: "Number of whistleblower cases under legal hold. Indicates active litigation risk from ethics violations."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory filing timeliness, penalty exposure, and submission compliance metrics. Enables compliance and legal teams to manage filing deadlines, avoid penalties, and maintain regulatory standing."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the regulatory filing (e.g., pending, submitted, accepted, rejected)."
    - name: "filing_type"
      expr: filing_type
      comment: "Type of regulatory filing (e.g., tax, environmental, safety, financial) for portfolio segmentation."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction to which the filing is submitted."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body receiving the filing, for relationship management."
    - name: "penalty_assessed_flag"
      expr: penalty_assessed_flag
      comment: "Whether a penalty was assessed for this filing (e.g., late filing, non-compliance)."
    - name: "penalty_paid_flag"
      expr: penalty_paid_flag
      comment: "Whether the assessed penalty has been paid."
    - name: "regulatory_response_received_flag"
      expr: regulatory_response_received_flag
      comment: "Whether a regulatory response has been received for the filing."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the filing is due, for deadline management and workload planning."
    - name: "filing_method"
      expr: filing_method
      comment: "Method used to submit the filing (e.g., electronic, paper, portal)."
  measures:
    - name: "total_filings"
      expr: COUNT(1)
      comment: "Total number of regulatory filings. Baseline measure of regulatory reporting obligation volume."
    - name: "total_penalties"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalties assessed for regulatory filings. Quantifies financial cost of filing non-compliance."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty per filing. Benchmarks penalty severity across jurisdictions and filing types."
    - name: "penalty_assessed_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN penalty_assessed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings resulting in a penalty. Key indicator of filing compliance program effectiveness."
    - name: "rejected_filings_count"
      expr: COUNT(CASE WHEN filing_status = 'rejected' THEN 1 END)
      comment: "Number of rejected regulatory filings. Indicates filing quality issues requiring process improvement."
    - name: "pending_filings_count"
      expr: COUNT(CASE WHEN filing_status = 'pending' THEN 1 END)
      comment: "Number of filings still pending submission. Measures compliance deadline risk and workload backlog."
    - name: "unpaid_penalties_count"
      expr: COUNT(CASE WHEN penalty_assessed_flag = TRUE AND penalty_paid_flag = FALSE THEN 1 END)
      comment: "Number of assessed penalties not yet paid. Indicates outstanding financial liabilities to regulatory authorities."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_policy_acknowledgment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy acknowledgment completion, timeliness, and waiver metrics for policy compliance tracking"
  source: "`vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment`"
  dimensions:
    - name: "acknowledgment_status"
      expr: acknowledgment_status
      comment: "Status of the policy acknowledgment (pending, completed, overdue, waived)"
    - name: "acknowledgment_method"
      expr: acknowledgment_method
      comment: "Method used to acknowledge the policy (electronic signature, click-through, paper, verbal)"
    - name: "acknowledgment_channel"
      expr: acknowledgment_channel
      comment: "Channel through which acknowledgment was captured (portal, email, mobile app, in-person)"
    - name: "re_acknowledgment_required_flag"
      expr: re_acknowledgment_required_flag
      comment: "Whether periodic re-acknowledgment is required"
    - name: "waiver_granted_flag"
      expr: waiver_granted_flag
      comment: "Whether a waiver was granted for this acknowledgment"
    - name: "department_code"
      expr: department_code
      comment: "Department code of the acknowledging employee"
    - name: "job_role_code"
      expr: job_role_code
      comment: "Job role code of the acknowledging employee"
    - name: "acknowledgment_year"
      expr: YEAR(acknowledgment_date)
      comment: "Year the policy was acknowledged"
  measures:
    - name: "total_acknowledgments"
      expr: COUNT(1)
      comment: "Total number of policy acknowledgments recorded"
    - name: "total_reminders_sent"
      expr: SUM(CAST(reminder_sent_count AS BIGINT))
      comment: "Total number of reminder notifications sent"
    - name: "avg_reminders_per_acknowledgment"
      expr: AVG(CAST(reminder_sent_count AS DOUBLE))
      comment: "Average number of reminders sent per acknowledgment"
    - name: "waiver_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN waiver_granted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of acknowledgments where a waiver was granted"
    - name: "re_acknowledgment_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN re_acknowledgment_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of acknowledgments requiring periodic re-acknowledgment"
$$;