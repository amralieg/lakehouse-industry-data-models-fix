-- Metric views for domain: compliance | Business: Gaming | Version: 1 | Generated on: 2026-05-08 09:42:21

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`compliance_age_rating_cert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Age rating certification metrics tracking approval velocity, certificate lifecycle, content descriptor prevalence, and interactive element disclosure rates for regulatory compliance monitoring"
  source: "`gaming_ecm`.`compliance`.`age_rating_cert`"
  dimensions:
    - name: "jurisdiction_id"
      expr: jurisdiction_id
      comment: "Foreign key to jurisdiction for regional compliance analysis"
    - name: "certificate_status"
      expr: certificate_status
      comment: "Current status of the age rating certificate (e.g., active, expired, revoked)"
    - name: "rating_category"
      expr: rating_category
      comment: "Age rating category assigned (e.g., E, T, M, AO)"
    - name: "platform_code"
      expr: platform_code
      comment: "Platform for which the certificate was issued"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the certificate was approved"
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the certificate was approved for time-series analysis"
    - name: "has_violence_descriptor"
      expr: content_descriptor_violence
      comment: "Flag indicating violence content descriptor present"
    - name: "has_gambling_descriptor"
      expr: content_descriptor_gambling
      comment: "Flag indicating gambling content descriptor present"
    - name: "has_loot_box_disclosure"
      expr: loot_box_disclosure_required
      comment: "Flag indicating loot box disclosure is required"
    - name: "has_online_interaction"
      expr: interactive_element_online
      comment: "Flag indicating online interactive elements present"
    - name: "has_in_game_purchases"
      expr: interactive_element_purchases
      comment: "Flag indicating in-game purchase interactive elements present"
  measures:
    - name: "total_certificates"
      expr: COUNT(1)
      comment: "Total number of age rating certificates issued"
    - name: "unique_games_certified"
      expr: COUNT(DISTINCT game_title_id)
      comment: "Distinct count of game titles with age rating certificates"
    - name: "avg_approval_cycle_days"
      expr: AVG(CAST(DATEDIFF(approval_date, submission_date) AS DOUBLE))
      comment: "Average days from submission to approval, measuring regulatory processing efficiency"
    - name: "violence_descriptor_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN content_descriptor_violence = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certificates with violence content descriptor"
    - name: "gambling_descriptor_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN content_descriptor_gambling = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certificates with gambling content descriptor"
    - name: "loot_box_disclosure_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN loot_box_disclosure_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certificates requiring loot box disclosure, key monetization compliance metric"
    - name: "online_interaction_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN interactive_element_online = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certificates with online interactive elements"
    - name: "revoked_certificate_count"
      expr: SUM(CASE WHEN certificate_status = 'revoked' THEN 1 ELSE 0 END)
      comment: "Count of revoked certificates, indicating compliance failures requiring executive attention"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`compliance_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance incident metrics tracking breach frequency, financial impact, remediation velocity, and regulatory notification rates for risk management and executive oversight"
  source: "`gaming_ecm`.`compliance`.`compliance_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of compliance incident (e.g., data breach, age verification failure, loot box violation)"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident (e.g., open, investigating, resolved, closed)"
    - name: "severity_rating"
      expr: severity_rating
      comment: "Severity classification of the incident (e.g., critical, high, medium, low)"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level indicating management attention required"
    - name: "discovery_channel"
      expr: discovery_channel
      comment: "Channel through which the incident was discovered (e.g., internal audit, player report, regulator)"
    - name: "discovery_year"
      expr: YEAR(discovery_date)
      comment: "Year the incident was discovered"
    - name: "discovery_month"
      expr: DATE_TRUNC('MONTH', discovery_date)
      comment: "Month the incident was discovered for trend analysis"
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required_flag
      comment: "Flag indicating whether regulatory notification is required"
    - name: "player_notification_required"
      expr: player_notification_required_flag
      comment: "Flag indicating whether player notification is required"
    - name: "external_counsel_engaged"
      expr: external_counsel_engaged_flag
      comment: "Flag indicating external legal counsel was engaged"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of compliance incidents recorded"
    - name: "critical_incidents"
      expr: SUM(CASE WHEN severity_rating = 'critical' THEN 1 ELSE 0 END)
      comment: "Count of critical severity incidents requiring immediate executive action"
    - name: "total_actual_financial_impact"
      expr: SUM(CAST(actual_financial_impact AS DOUBLE))
      comment: "Total actual financial impact from all incidents, key risk exposure metric"
    - name: "total_estimated_financial_impact"
      expr: SUM(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Total estimated financial impact from all incidents"
    - name: "avg_actual_financial_impact"
      expr: AVG(CAST(actual_financial_impact AS DOUBLE))
      comment: "Average actual financial impact per incident"
    - name: "total_affected_players"
      expr: SUM(CAST(affected_player_count AS DOUBLE))
      comment: "Total number of players affected across all incidents, measuring compliance risk exposure"
    - name: "avg_remediation_days"
      expr: AVG(CAST(DATEDIFF(remediation_completion_date, discovery_date) AS DOUBLE))
      comment: "Average days from discovery to remediation completion, measuring response efficiency"
    - name: "regulatory_notification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_notification_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents requiring regulatory notification, indicating severity distribution"
    - name: "external_counsel_engagement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN external_counsel_engaged_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents requiring external legal counsel, indicating complexity and risk"
    - name: "unresolved_incidents"
      expr: SUM(CASE WHEN incident_status NOT IN ('resolved', 'closed') THEN 1 ELSE 0 END)
      comment: "Count of incidents not yet resolved, measuring current compliance risk exposure"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`compliance_data_subject_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data subject request metrics tracking GDPR/CCPA request volume, fulfillment velocity, rejection rates, and identity verification success for privacy compliance monitoring"
  source: "`gaming_ecm`.`compliance`.`data_subject_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of data subject request (e.g., access, erasure, portability, rectification)"
    - name: "request_status"
      expr: request_status
      comment: "Current status of the request (e.g., pending, in_progress, completed, rejected)"
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the request was submitted (e.g., web form, email, phone)"
    - name: "applicable_regulation"
      expr: applicable_regulation
      comment: "Regulation under which the request was made (e.g., GDPR, CCPA, COPPA)"
    - name: "submission_year"
      expr: YEAR(submission_timestamp)
      comment: "Year the request was submitted"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month the request was submitted for trend analysis"
    - name: "identity_verified"
      expr: identity_verified_flag
      comment: "Flag indicating whether identity verification was successful"
    - name: "extension_granted"
      expr: extension_granted_flag
      comment: "Flag indicating whether deadline extension was granted"
    - name: "is_minor"
      expr: minor_flag
      comment: "Flag indicating request involves a minor"
  measures:
    - name: "total_requests"
      expr: COUNT(1)
      comment: "Total number of data subject requests received"
    - name: "unique_requestors"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Distinct count of player accounts making data subject requests"
    - name: "erasure_requests"
      expr: SUM(CASE WHEN request_type = 'erasure' THEN 1 ELSE 0 END)
      comment: "Count of erasure requests, measuring right-to-be-forgotten exercise"
    - name: "avg_fulfillment_days"
      expr: AVG(CAST(DATEDIFF(completion_timestamp, submission_timestamp) AS DOUBLE))
      comment: "Average days from submission to completion, measuring privacy response efficiency"
    - name: "rejection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN request_status = 'rejected' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requests rejected, indicating potential compliance friction"
    - name: "identity_verification_success_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN identity_verified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requests with successful identity verification"
    - name: "extension_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN extension_granted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requests requiring deadline extension, indicating processing complexity"
    - name: "minor_request_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN minor_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requests involving minors, requiring special handling"
    - name: "overdue_requests"
      expr: SUM(CASE WHEN request_status NOT IN ('completed', 'rejected') AND due_date < CURRENT_DATE THEN 1 ELSE 0 END)
      comment: "Count of requests past due date, measuring compliance risk exposure"
    - name: "total_fee_charged"
      expr: SUM(CAST(fee_charged_amount AS DOUBLE))
      comment: "Total fees charged for data subject requests"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`compliance_loot_box_disclosure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loot box disclosure metrics tracking regulatory compliance status, odds disclosure accuracy, enforcement actions, and player complaint rates for monetization transparency oversight"
  source: "`gaming_ecm`.`compliance`.`loot_box_disclosure`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the loot box disclosure (e.g., compliant, non_compliant, under_review)"
    - name: "platform_code"
      expr: platform_code
      comment: "Platform for which the disclosure applies"
    - name: "disclosure_language"
      expr: disclosure_language
      comment: "Language in which the disclosure is provided"
    - name: "monetization_model"
      expr: monetization_model
      comment: "Monetization model associated with the loot box (e.g., premium, freemium)"
    - name: "disclosure_year"
      expr: YEAR(disclosure_effective_date)
      comment: "Year the disclosure became effective"
    - name: "disclosure_month"
      expr: DATE_TRUNC('MONTH', disclosure_effective_date)
      comment: "Month the disclosure became effective for trend analysis"
    - name: "odds_match"
      expr: odds_match_flag
      comment: "Flag indicating whether disclosed odds match actual drop rates"
    - name: "enforcement_action_taken"
      expr: enforcement_action_flag
      comment: "Flag indicating enforcement action was taken for non-compliance"
    - name: "pity_system_disclosed"
      expr: pity_system_disclosed_flag
      comment: "Flag indicating pity system mechanics are disclosed"
  measures:
    - name: "total_disclosures"
      expr: COUNT(1)
      comment: "Total number of loot box disclosures tracked"
    - name: "unique_games_with_disclosures"
      expr: COUNT(DISTINCT game_title_id)
      comment: "Distinct count of game titles with loot box disclosures"
    - name: "non_compliant_disclosures"
      expr: SUM(CASE WHEN compliance_status = 'non_compliant' THEN 1 ELSE 0 END)
      comment: "Count of non-compliant loot box disclosures requiring immediate remediation"
    - name: "compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of loot box disclosures in compliant status, key regulatory health metric"
    - name: "odds_accuracy_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN odds_match_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disclosures where odds match actual rates, measuring transparency integrity"
    - name: "enforcement_action_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN enforcement_action_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disclosures with enforcement actions, indicating regulatory scrutiny"
    - name: "pity_system_disclosure_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pity_system_disclosed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disclosures including pity system mechanics"
    - name: "total_player_complaints"
      expr: SUM(CAST(player_complaint_count AS DOUBLE))
      comment: "Total player complaints related to loot box disclosures, measuring player trust impact"
    - name: "avg_player_complaints_per_disclosure"
      expr: AVG(CAST(player_complaint_count AS DOUBLE))
      comment: "Average player complaints per disclosure"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`compliance_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance policy metrics tracking policy lifecycle, implementation status, audit cadence, training requirements, and estimated implementation costs for governance oversight"
  source: "`gaming_ecm`.`compliance`.`policy`"
  dimensions:
    - name: "policy_category"
      expr: policy_category
      comment: "Category of the compliance policy (e.g., data privacy, age verification, content moderation)"
    - name: "policy_status"
      expr: policy_status
      comment: "Current status of the policy (e.g., draft, active, superseded, retired)"
    - name: "implementation_status"
      expr: implementation_status
      comment: "Implementation status of the policy (e.g., not_started, in_progress, completed)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the policy (e.g., critical, high, medium, low)"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the policy became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the policy became effective for trend analysis"
    - name: "requires_training"
      expr: training_required
      comment: "Flag indicating whether training is required for this policy"
    - name: "requires_player_consent"
      expr: requires_player_consent
      comment: "Flag indicating whether player consent is required"
    - name: "requires_age_verification"
      expr: requires_age_verification
      comment: "Flag indicating whether age verification is required"
  measures:
    - name: "total_policies"
      expr: COUNT(1)
      comment: "Total number of compliance policies in the system"
    - name: "active_policies"
      expr: SUM(CASE WHEN policy_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active policies currently in force"
    - name: "critical_risk_policies"
      expr: SUM(CASE WHEN risk_level = 'critical' THEN 1 ELSE 0 END)
      comment: "Count of critical risk policies requiring executive oversight"
    - name: "total_estimated_implementation_cost"
      expr: SUM(CAST(estimated_implementation_cost AS DOUBLE))
      comment: "Total estimated cost to implement all policies, key budgeting metric"
    - name: "avg_estimated_implementation_cost"
      expr: AVG(CAST(estimated_implementation_cost AS DOUBLE))
      comment: "Average estimated implementation cost per policy"
    - name: "implementation_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN implementation_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of policies fully implemented, measuring governance maturity"
    - name: "overdue_implementation_count"
      expr: SUM(CASE WHEN implementation_status != 'completed' AND implementation_deadline < CURRENT_DATE THEN 1 ELSE 0 END)
      comment: "Count of policies past implementation deadline, indicating compliance risk"
    - name: "policies_requiring_training"
      expr: SUM(CASE WHEN training_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of policies requiring training programs"
    - name: "avg_audit_frequency_months"
      expr: AVG(CAST(audit_frequency_months AS DOUBLE))
      comment: "Average audit frequency in months across all policies"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`compliance_regulatory_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory obligation metrics tracking obligation volume, implementation status, maximum penalty exposure, audit cadence, and compliance ownership for regulatory risk management"
  source: "`gaming_ecm`.`compliance`.`regulatory_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory obligation (e.g., reporting, disclosure, certification, audit)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the obligation (e.g., compliant, non_compliant, in_progress)"
    - name: "implementation_status"
      expr: implementation_status
      comment: "Implementation status of the obligation (e.g., not_started, in_progress, completed)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the obligation (e.g., critical, high, medium, low)"
    - name: "governing_body"
      expr: governing_body
      comment: "Regulatory body governing this obligation (e.g., ESRB, PEGI, FTC, ICO)"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the obligation became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the obligation became effective for trend analysis"
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the obligation is currently active"
    - name: "requires_player_consent"
      expr: requires_player_consent
      comment: "Flag indicating whether player consent is required"
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of regulatory obligations tracked"
    - name: "active_obligations"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of active regulatory obligations currently in force"
    - name: "critical_risk_obligations"
      expr: SUM(CASE WHEN risk_level = 'critical' THEN 1 ELSE 0 END)
      comment: "Count of critical risk obligations requiring immediate executive attention"
    - name: "non_compliant_obligations"
      expr: SUM(CASE WHEN compliance_status = 'non_compliant' THEN 1 ELSE 0 END)
      comment: "Count of non-compliant obligations, measuring current regulatory risk exposure"
    - name: "compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of obligations in compliant status, key regulatory health metric"
    - name: "total_maximum_penalty_exposure"
      expr: SUM(CAST(maximum_penalty_amount AS DOUBLE))
      comment: "Total maximum penalty exposure across all obligations, critical risk metric for executive oversight"
    - name: "avg_maximum_penalty"
      expr: AVG(CAST(maximum_penalty_amount AS DOUBLE))
      comment: "Average maximum penalty per obligation"
    - name: "total_estimated_implementation_cost"
      expr: SUM(CAST(estimated_implementation_cost AS DOUBLE))
      comment: "Total estimated cost to implement all obligations, key budgeting metric"
    - name: "implementation_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN implementation_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of obligations fully implemented, measuring compliance maturity"
    - name: "overdue_implementation_count"
      expr: SUM(CASE WHEN implementation_status != 'completed' AND implementation_deadline < CURRENT_DATE THEN 1 ELSE 0 END)
      comment: "Count of obligations past implementation deadline, indicating compliance risk"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`compliance_remediation_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Remediation action metrics tracking action completion velocity, cost variance, escalation rates, and risk reduction effectiveness for compliance incident response management"
  source: "`gaming_ecm`.`compliance`.`remediation_action`"
  dimensions:
    - name: "remediation_type"
      expr: remediation_type
      comment: "Type of remediation action (e.g., process_change, system_update, training, policy_revision)"
    - name: "remediation_action_status"
      expr: remediation_action_status
      comment: "Current status of the remediation action (e.g., planned, in_progress, completed, cancelled)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the remediation action (e.g., critical, high, medium, low)"
    - name: "risk_level_before"
      expr: risk_level_before
      comment: "Risk level before remediation action"
    - name: "risk_level_after"
      expr: risk_level_after
      comment: "Risk level after remediation action"
    - name: "assigned_department"
      expr: assigned_department
      comment: "Department assigned to execute the remediation action"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework driving the remediation (e.g., GDPR, COPPA, CCPA)"
    - name: "escalation_required"
      expr: escalation_required
      comment: "Flag indicating whether escalation is required"
    - name: "external_consultant_engaged"
      expr: external_consultant_engaged
      comment: "Flag indicating external consultant was engaged"
    - name: "target_completion_year"
      expr: YEAR(target_completion_date)
      comment: "Year the action is targeted for completion"
    - name: "target_completion_month"
      expr: DATE_TRUNC('MONTH', target_completion_date)
      comment: "Month the action is targeted for completion"
  measures:
    - name: "total_remediation_actions"
      expr: COUNT(1)
      comment: "Total number of remediation actions tracked"
    - name: "completed_actions"
      expr: SUM(CASE WHEN remediation_action_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of completed remediation actions"
    - name: "critical_priority_actions"
      expr: SUM(CASE WHEN priority = 'critical' THEN 1 ELSE 0 END)
      comment: "Count of critical priority remediation actions requiring immediate attention"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all remediation actions, key budgeting metric"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of all remediation actions"
    - name: "avg_cost_variance_pct"
      expr: AVG(CASE WHEN estimated_cost > 0 THEN ROUND(100.0 * (CAST(actual_cost AS DOUBLE) - CAST(estimated_cost AS DOUBLE)) / CAST(estimated_cost AS DOUBLE), 2) ELSE NULL END)
      comment: "Average cost variance percentage (actual vs estimated), measuring budget accuracy"
    - name: "avg_completion_days"
      expr: AVG(CAST(DATEDIFF(actual_completion_date, created_timestamp) AS DOUBLE))
      comment: "Average days from creation to completion, measuring remediation velocity"
    - name: "completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN remediation_action_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of remediation actions completed, measuring execution effectiveness"
    - name: "escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of actions requiring escalation, indicating complexity and risk"
    - name: "overdue_actions"
      expr: SUM(CASE WHEN remediation_action_status NOT IN ('completed', 'cancelled') AND target_completion_date < CURRENT_DATE THEN 1 ELSE 0 END)
      comment: "Count of actions past target completion date, measuring compliance risk exposure"
    - name: "external_consultant_engagement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN external_consultant_engaged = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of actions requiring external consultants, indicating complexity"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`compliance_spend_limit_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spend limit control metrics tracking limit enforcement, breach frequency, player acknowledgment rates, and current period spend for responsible monetization oversight"
  source: "`gaming_ecm`.`compliance`.`spend_limit_control`"
  dimensions:
    - name: "control_type"
      expr: control_type
      comment: "Type of spend limit control (e.g., daily, weekly, monthly, lifetime)"
    - name: "control_source"
      expr: control_source
      comment: "Source of the control (e.g., player_set, regulatory_mandate, platform_default)"
    - name: "enforcement_status"
      expr: enforcement_status
      comment: "Current enforcement status of the control (e.g., active, suspended, expired)"
    - name: "limit_period"
      expr: limit_period
      comment: "Period over which the limit applies (e.g., daily, weekly, monthly)"
    - name: "limit_currency_code"
      expr: limit_currency_code
      comment: "Currency code for the spend limit"
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the control is currently active"
    - name: "player_acknowledgment_required"
      expr: player_acknowledgment_required
      comment: "Flag indicating whether player acknowledgment is required"
    - name: "notification_sent"
      expr: notification_sent
      comment: "Flag indicating whether notification was sent to player"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the control became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the control became effective for trend analysis"
  measures:
    - name: "total_spend_controls"
      expr: COUNT(1)
      comment: "Total number of spend limit controls in place"
    - name: "active_controls"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of active spend limit controls currently enforced"
    - name: "unique_players_with_controls"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Distinct count of players with spend limit controls"
    - name: "total_limit_amount"
      expr: SUM(CAST(limit_amount AS DOUBLE))
      comment: "Total spend limit amount across all controls"
    - name: "avg_limit_amount"
      expr: AVG(CAST(limit_amount AS DOUBLE))
      comment: "Average spend limit amount per control"
    - name: "total_current_period_spend"
      expr: SUM(CAST(current_period_spend AS DOUBLE))
      comment: "Total current period spend across all controls, measuring monetization activity"
    - name: "avg_current_period_spend"
      expr: AVG(CAST(current_period_spend AS DOUBLE))
      comment: "Average current period spend per control"
    - name: "total_breach_count"
      expr: SUM(CAST(breach_count AS DOUBLE))
      comment: "Total number of spend limit breaches, measuring control effectiveness"
    - name: "controls_with_breaches"
      expr: SUM(CASE WHEN CAST(breach_count AS DOUBLE) > 0 THEN 1 ELSE 0 END)
      comment: "Count of controls that have experienced breaches"
    - name: "breach_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN CAST(breach_count AS DOUBLE) > 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of controls with at least one breach, indicating enforcement challenges"
    - name: "player_acknowledgment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN player_acknowledgment_required = TRUE AND player_acknowledgment_timestamp IS NOT NULL THEN 1 WHEN player_acknowledgment_required = FALSE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of controls with player acknowledgment completed where required"
    - name: "notification_sent_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN notification_sent = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of controls where notification was sent to player"
$$;