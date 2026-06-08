-- Metric views for domain: risk | Business: Legal | Version: 1 | Generated on: 2026-05-07 11:54:14

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`risk_appetite`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk appetite threshold metrics tracking organizational risk tolerance levels, financial exposure limits, and governance compliance across practice groups and risk categories"
  source: "`legal_ecm`.`risk`.`appetite`"
  dimensions:
    - name: "organizational_level"
      expr: organizational_level
      comment: "Level at which risk appetite is defined (firm-wide, practice group, office, matter-type)"
    - name: "risk_tolerance_band"
      expr: risk_tolerance_band
      comment: "Categorical band defining acceptable risk tolerance (low, medium, high, critical)"
    - name: "threshold_status"
      expr: threshold_status
      comment: "Current status of the risk appetite threshold (active, under review, superseded, expired)"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing this risk appetite (SRA, GDPR, AML, ISO 27001)"
    - name: "approving_governance_body"
      expr: approving_governance_body
      comment: "Governance body that approved this risk appetite (Board, Risk Committee, Executive Committee)"
    - name: "review_frequency"
      expr: review_frequency
      comment: "Frequency at which risk appetite is reviewed (quarterly, semi-annually, annually)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which financial exposure limits are denominated"
    - name: "risk_subcategory"
      expr: risk_subcategory
      comment: "Subcategory of risk for granular appetite definition"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the risk appetite was approved"
    - name: "approval_quarter"
      expr: CONCAT('Q', QUARTER(approval_date), '-', YEAR(approval_date))
      comment: "Quarter and year the risk appetite was approved"
    - name: "effective_year"
      expr: YEAR(effective_from_date)
      comment: "Year the risk appetite became effective"
    - name: "is_currently_effective"
      expr: CASE WHEN CURRENT_DATE() BETWEEN effective_from_date AND COALESCE(effective_to_date, '9999-12-31') THEN 'Yes' ELSE 'No' END
      comment: "Whether the risk appetite is currently in effect"
    - name: "automatic_escalation_flag"
      expr: automatic_escalation_flag
      comment: "Whether breaches automatically escalate to governance"
    - name: "mandatory_mitigation_required_flag"
      expr: mandatory_mitigation_required_flag
      comment: "Whether mandatory mitigation is required when appetite is breached"
    - name: "insurance_coverage_required_flag"
      expr: insurance_coverage_required_flag
      comment: "Whether insurance coverage is required for risks in this appetite"
  measures:
    - name: "total_risk_appetites"
      expr: COUNT(1)
      comment: "Total number of defined risk appetite thresholds"
    - name: "total_financial_exposure_limit"
      expr: SUM(CAST(financial_exposure_limit AS DOUBLE))
      comment: "Total financial exposure limit across all risk appetites"
    - name: "avg_financial_exposure_limit"
      expr: AVG(CAST(financial_exposure_limit AS DOUBLE))
      comment: "Average financial exposure limit per risk appetite"
    - name: "max_financial_exposure_limit"
      expr: MAX(CAST(financial_exposure_limit AS DOUBLE))
      comment: "Maximum financial exposure limit defined in any risk appetite"
    - name: "avg_maximum_tolerable_risk_score"
      expr: AVG(CAST(maximum_tolerable_risk_score AS DOUBLE))
      comment: "Average maximum tolerable risk score across appetites"
    - name: "avg_escalation_trigger_score"
      expr: AVG(CAST(escalation_trigger_score AS DOUBLE))
      comment: "Average risk score that triggers automatic escalation"
    - name: "distinct_organizational_levels"
      expr: COUNT(DISTINCT organizational_level)
      comment: "Number of distinct organizational levels with defined risk appetites"
    - name: "distinct_regulatory_frameworks"
      expr: COUNT(DISTINCT regulatory_framework)
      comment: "Number of distinct regulatory frameworks governing risk appetites"
    - name: "appetites_requiring_insurance"
      expr: SUM(CASE WHEN insurance_coverage_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of risk appetites requiring insurance coverage"
    - name: "appetites_with_auto_escalation"
      expr: SUM(CASE WHEN automatic_escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of risk appetites with automatic escalation enabled"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk assessment metrics tracking inherent and residual risk scores, control effectiveness, financial exposure, and treatment status across matters and clients"
  source: "`legal_ecm`.`risk`.`assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the risk assessment (draft, under review, approved, closed)"
    - name: "risk_domain"
      expr: risk_domain
      comment: "Domain of risk being assessed (operational, financial, compliance, reputational, cyber)"
    - name: "inherent_impact_rating"
      expr: inherent_impact_rating
      comment: "Rating of inherent impact before controls (low, medium, high, critical)"
    - name: "inherent_likelihood_rating"
      expr: inherent_likelihood_rating
      comment: "Rating of inherent likelihood before controls (rare, unlikely, possible, likely, almost certain)"
    - name: "residual_impact_rating"
      expr: residual_impact_rating
      comment: "Rating of residual impact after controls applied"
    - name: "residual_likelihood_rating"
      expr: residual_likelihood_rating
      comment: "Rating of residual likelihood after controls applied"
    - name: "control_effectiveness_rating"
      expr: control_effectiveness_rating
      comment: "Rating of control effectiveness (ineffective, partially effective, effective, highly effective)"
    - name: "risk_treatment_option"
      expr: risk_treatment_option
      comment: "Selected treatment option (accept, mitigate, transfer, avoid)"
    - name: "within_appetite"
      expr: within_appetite
      comment: "Whether the residual risk is within organizational risk appetite"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Level to which risk has been escalated (none, practice group, executive, board)"
    - name: "methodology"
      expr: methodology
      comment: "Risk assessment methodology used (ISO 31000, NIST, FAIR, qualitative)"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework applicable to this assessment"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for financial exposure estimates"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year the risk assessment was conducted"
    - name: "assessment_quarter"
      expr: CONCAT('Q', QUARTER(assessment_date), '-', YEAR(assessment_date))
      comment: "Quarter and year of risk assessment"
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of risk assessment"
    - name: "is_dpia_required"
      expr: is_dpia_required
      comment: "Whether a Data Protection Impact Assessment is required"
    - name: "pii_data_involved"
      expr: pii_data_involved
      comment: "Whether personally identifiable information is involved"
    - name: "is_lpp_sensitive"
      expr: is_lpp_sensitive
      comment: "Whether legal professional privilege applies"
    - name: "sanctions_flag"
      expr: sanctions_flag
      comment: "Whether sanctions-related risks are present"
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(1)
      comment: "Total number of risk assessments conducted"
    - name: "avg_inherent_risk_score"
      expr: AVG(CAST(inherent_risk_score AS DOUBLE))
      comment: "Average inherent risk score before controls"
    - name: "avg_residual_risk_score"
      expr: AVG(CAST(residual_risk_score AS DOUBLE))
      comment: "Average residual risk score after controls"
    - name: "total_estimated_financial_exposure"
      expr: SUM(CAST(estimated_financial_exposure AS DOUBLE))
      comment: "Total estimated financial exposure across all assessments"
    - name: "avg_estimated_financial_exposure"
      expr: AVG(CAST(estimated_financial_exposure AS DOUBLE))
      comment: "Average estimated financial exposure per assessment"
    - name: "max_inherent_risk_score"
      expr: MAX(CAST(inherent_risk_score AS DOUBLE))
      comment: "Maximum inherent risk score observed"
    - name: "max_residual_risk_score"
      expr: MAX(CAST(residual_risk_score AS DOUBLE))
      comment: "Maximum residual risk score observed"
    - name: "assessments_within_appetite"
      expr: SUM(CASE WHEN within_appetite = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assessments where residual risk is within appetite"
    - name: "assessments_requiring_dpia"
      expr: SUM(CASE WHEN is_dpia_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assessments requiring Data Protection Impact Assessment"
    - name: "assessments_with_pii"
      expr: SUM(CASE WHEN pii_data_involved = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assessments involving personally identifiable information"
    - name: "assessments_with_sanctions_risk"
      expr: SUM(CASE WHEN sanctions_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assessments flagged for sanctions-related risks"
    - name: "distinct_risk_domains"
      expr: COUNT(DISTINCT risk_domain)
      comment: "Number of distinct risk domains assessed"
    - name: "distinct_matters_assessed"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of distinct matters with risk assessments"
    - name: "distinct_clients_assessed"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct clients with risk assessments"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`risk_escalation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk escalation metrics tracking governance escalations, decision outcomes, regulatory notifications, and financial impact of escalated risks"
  source: "`legal_ecm`.`risk`.`escalation`"
  dimensions:
    - name: "escalation_status"
      expr: escalation_status
      comment: "Current status of the escalation (open, under review, decision made, closed)"
    - name: "risk_severity_level"
      expr: risk_severity_level
      comment: "Severity level of the escalated risk (low, medium, high, critical)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the escalation (low, medium, high, urgent)"
    - name: "receiving_governance_body"
      expr: receiving_governance_body
      comment: "Governance body receiving the escalation (Risk Committee, Executive Committee, Board)"
    - name: "decision_outcome"
      expr: decision_outcome
      comment: "Outcome of the escalation decision (approved, rejected, conditional approval, deferred)"
    - name: "trigger"
      expr: trigger
      comment: "Event or condition that triggered the escalation"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework relevant to the escalation"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body to be notified (SRA, ICO, FCA, none)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for estimated financial impact"
    - name: "escalation_year"
      expr: YEAR(escalation_date)
      comment: "Year the risk was escalated"
    - name: "escalation_quarter"
      expr: CONCAT('Q', QUARTER(escalation_date), '-', YEAR(escalation_date))
      comment: "Quarter and year of escalation"
    - name: "escalation_month"
      expr: DATE_TRUNC('MONTH', escalation_date)
      comment: "Month of escalation"
    - name: "decision_year"
      expr: YEAR(decision_date)
      comment: "Year the escalation decision was made"
    - name: "board_notification_required_flag"
      expr: board_notification_required_flag
      comment: "Whether board notification is required"
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Whether regulatory reporting is required"
    - name: "insurance_notification_required_flag"
      expr: insurance_notification_required_flag
      comment: "Whether insurance notification is required"
    - name: "follow_up_action_required_flag"
      expr: follow_up_action_required_flag
      comment: "Whether follow-up action is required"
    - name: "lpp_applies_flag"
      expr: lpp_applies_flag
      comment: "Whether legal professional privilege applies"
    - name: "pii_involved_flag"
      expr: pii_involved_flag
      comment: "Whether personally identifiable information is involved"
  measures:
    - name: "total_escalations"
      expr: COUNT(1)
      comment: "Total number of risk escalations"
    - name: "total_estimated_financial_impact"
      expr: SUM(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Total estimated financial impact of all escalations"
    - name: "avg_estimated_financial_impact"
      expr: AVG(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Average estimated financial impact per escalation"
    - name: "max_estimated_financial_impact"
      expr: MAX(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Maximum estimated financial impact of any single escalation"
    - name: "escalations_requiring_board_notification"
      expr: SUM(CASE WHEN board_notification_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of escalations requiring board notification"
    - name: "escalations_requiring_regulatory_reporting"
      expr: SUM(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of escalations requiring regulatory reporting"
    - name: "escalations_requiring_insurance_notification"
      expr: SUM(CASE WHEN insurance_notification_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of escalations requiring insurance notification"
    - name: "escalations_with_pii"
      expr: SUM(CASE WHEN pii_involved_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of escalations involving personally identifiable information"
    - name: "escalations_with_lpp"
      expr: SUM(CASE WHEN lpp_applies_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of escalations where legal professional privilege applies"
    - name: "distinct_governance_bodies"
      expr: COUNT(DISTINCT receiving_governance_body)
      comment: "Number of distinct governance bodies receiving escalations"
    - name: "distinct_regulatory_bodies"
      expr: COUNT(DISTINCT regulatory_body)
      comment: "Number of distinct regulatory bodies involved in escalations"
    - name: "distinct_matters_escalated"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of distinct matters with escalations"
    - name: "distinct_clients_escalated"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct clients with escalations"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`risk_pi_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Professional indemnity claim metrics tracking claim amounts, settlement outcomes, defence costs, and insurance coverage for legal malpractice and negligence claims"
  source: "`legal_ecm`.`risk`.`pi_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the PI claim (open, under investigation, settled, closed, denied)"
    - name: "claim_outcome"
      expr: claim_outcome
      comment: "Final outcome of the claim (settled, dismissed, judgment for claimant, judgment for firm)"
    - name: "claimant_type"
      expr: claimant_type
      comment: "Type of claimant (client, third party, regulator, other)"
    - name: "practice_area"
      expr: practice_area
      comment: "Practice area where the alleged breach occurred"
    - name: "claim_currency"
      expr: claim_currency
      comment: "Currency in which the claim is denominated"
    - name: "insurer_name"
      expr: insurer_name
      comment: "Name of the professional indemnity insurer"
    - name: "policy_year"
      expr: policy_year
      comment: "Policy year under which the claim is covered"
    - name: "coverage_confirmed"
      expr: coverage_confirmed
      comment: "Whether insurance coverage has been confirmed"
    - name: "adr_method"
      expr: adr_method
      comment: "Alternative dispute resolution method used (mediation, arbitration, none)"
    - name: "claimant_jurisdiction"
      expr: claimant_jurisdiction
      comment: "Jurisdiction where the claimant is located"
    - name: "claim_year"
      expr: YEAR(claim_date)
      comment: "Year the claim was filed"
    - name: "claim_quarter"
      expr: CONCAT('Q', QUARTER(claim_date), '-', YEAR(claim_date))
      comment: "Quarter and year the claim was filed"
    - name: "claim_month"
      expr: DATE_TRUNC('MONTH', claim_date)
      comment: "Month the claim was filed"
    - name: "alleged_breach_year"
      expr: YEAR(alleged_breach_date)
      comment: "Year the alleged breach occurred"
    - name: "settlement_year"
      expr: YEAR(settlement_date)
      comment: "Year the claim was settled"
    - name: "lpp_applies"
      expr: lpp_applies
      comment: "Whether legal professional privilege applies to claim materials"
    - name: "pii_data_involved"
      expr: pii_data_involved
      comment: "Whether personally identifiable information is involved in the claim"
    - name: "regulatory_report_required"
      expr: regulatory_report_required
      comment: "Whether regulatory reporting is required"
    - name: "ethical_wall_required"
      expr: ethical_wall_required
      comment: "Whether an ethical wall is required for conflict management"
  measures:
    - name: "total_pi_claims"
      expr: COUNT(1)
      comment: "Total number of professional indemnity claims"
    - name: "total_claim_amount"
      expr: SUM(CAST(claim_amount AS DOUBLE))
      comment: "Total amount claimed across all PI claims"
    - name: "avg_claim_amount"
      expr: AVG(CAST(claim_amount AS DOUBLE))
      comment: "Average claim amount per PI claim"
    - name: "max_claim_amount"
      expr: MAX(CAST(claim_amount AS DOUBLE))
      comment: "Maximum claim amount in any single PI claim"
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amount paid across all claims"
    - name: "avg_settlement_amount"
      expr: AVG(CAST(settlement_amount AS DOUBLE))
      comment: "Average settlement amount per claim"
    - name: "total_defence_costs"
      expr: SUM(CAST(defence_costs_incurred AS DOUBLE))
      comment: "Total defence costs incurred across all claims"
    - name: "avg_defence_costs"
      expr: AVG(CAST(defence_costs_incurred AS DOUBLE))
      comment: "Average defence costs per claim"
    - name: "total_reserve_amount"
      expr: SUM(CAST(reserve_amount AS DOUBLE))
      comment: "Total reserve amount set aside for all claims"
    - name: "avg_reserve_amount"
      expr: AVG(CAST(reserve_amount AS DOUBLE))
      comment: "Average reserve amount per claim"
    - name: "total_deductible_amount"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductible amount across all claims"
    - name: "claims_with_coverage_confirmed"
      expr: SUM(CASE WHEN coverage_confirmed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of claims with confirmed insurance coverage"
    - name: "claims_requiring_regulatory_report"
      expr: SUM(CASE WHEN regulatory_report_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of claims requiring regulatory reporting"
    - name: "claims_with_pii_involved"
      expr: SUM(CASE WHEN pii_data_involved = TRUE THEN 1 ELSE 0 END)
      comment: "Count of claims involving personally identifiable information"
    - name: "distinct_practice_areas"
      expr: COUNT(DISTINCT practice_area)
      comment: "Number of distinct practice areas with PI claims"
    - name: "distinct_insurers"
      expr: COUNT(DISTINCT insurer_name)
      comment: "Number of distinct insurers handling claims"
    - name: "distinct_matters_with_claims"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of distinct matters with PI claims"
    - name: "distinct_clients_with_claims"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct clients with PI claims"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`risk_cyber_risk_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cybersecurity incident metrics tracking data breaches, system compromises, financial losses, downtime, and regulatory notifications for cyber risk events"
  source: "`legal_ecm`.`risk`.`cyber_risk_event`"
  dimensions:
    - name: "event_status"
      expr: event_status
      comment: "Current status of the cyber risk event (open, contained, remediated, closed)"
    - name: "event_type"
      expr: event_type
      comment: "Type of cyber risk event (malware, phishing, ransomware, data breach, DDoS, unauthorized access)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the cyber event (low, medium, high, critical)"
    - name: "detection_source"
      expr: detection_source
      comment: "Source that detected the cyber event (SIEM, user report, audit, external notification)"
    - name: "affected_system"
      expr: affected_system
      comment: "System or application affected by the cyber event"
    - name: "loss_currency_code"
      expr: loss_currency_code
      comment: "Currency for financial loss amounts"
    - name: "is_near_miss"
      expr: is_near_miss
      comment: "Whether the event was a near miss (detected before impact)"
    - name: "is_reportable_breach"
      expr: is_reportable_breach
      comment: "Whether the event constitutes a reportable data breach"
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Whether regulatory notification is required"
    - name: "insurance_claim_filed"
      expr: insurance_claim_filed
      comment: "Whether an insurance claim has been filed"
    - name: "event_year"
      expr: YEAR(event_date)
      comment: "Year the cyber event occurred"
    - name: "event_quarter"
      expr: CONCAT('Q', QUARTER(event_date), '-', YEAR(event_date))
      comment: "Quarter and year of the cyber event"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month of the cyber event"
    - name: "detection_year"
      expr: YEAR(detection_date)
      comment: "Year the cyber event was detected"
    - name: "resolution_year"
      expr: YEAR(resolution_date)
      comment: "Year the cyber event was resolved"
    - name: "external_party_involved"
      expr: external_party_involved
      comment: "External party involved in the incident (vendor, attacker, law enforcement)"
  measures:
    - name: "total_cyber_events"
      expr: COUNT(1)
      comment: "Total number of cyber risk events"
    - name: "total_actual_loss"
      expr: SUM(CAST(actual_loss_amount AS DOUBLE))
      comment: "Total actual financial loss from cyber events"
    - name: "avg_actual_loss"
      expr: AVG(CAST(actual_loss_amount AS DOUBLE))
      comment: "Average actual financial loss per cyber event"
    - name: "max_actual_loss"
      expr: MAX(CAST(actual_loss_amount AS DOUBLE))
      comment: "Maximum actual financial loss from any single cyber event"
    - name: "total_estimated_loss"
      expr: SUM(CAST(estimated_loss_amount AS DOUBLE))
      comment: "Total estimated financial loss from cyber events"
    - name: "total_recovery_cost"
      expr: SUM(CAST(recovery_cost_amount AS DOUBLE))
      comment: "Total recovery and remediation costs"
    - name: "avg_recovery_cost"
      expr: AVG(CAST(recovery_cost_amount AS DOUBLE))
      comment: "Average recovery cost per cyber event"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total system downtime hours across all cyber events"
    - name: "avg_downtime_hours"
      expr: AVG(CAST(downtime_hours AS DOUBLE))
      comment: "Average downtime hours per cyber event"
    - name: "max_downtime_hours"
      expr: MAX(CAST(downtime_hours AS DOUBLE))
      comment: "Maximum downtime hours from any single cyber event"
    - name: "reportable_breaches"
      expr: SUM(CASE WHEN is_reportable_breach = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cyber events that are reportable data breaches"
    - name: "near_miss_events"
      expr: SUM(CASE WHEN is_near_miss = TRUE THEN 1 ELSE 0 END)
      comment: "Count of near-miss cyber events (detected before impact)"
    - name: "events_requiring_regulatory_notification"
      expr: SUM(CASE WHEN regulatory_notification_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of events requiring regulatory notification"
    - name: "events_with_insurance_claim"
      expr: SUM(CASE WHEN insurance_claim_filed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of events with insurance claims filed"
    - name: "distinct_affected_systems"
      expr: COUNT(DISTINCT affected_system)
      comment: "Number of distinct systems affected by cyber events"
    - name: "distinct_event_types"
      expr: COUNT(DISTINCT event_type)
      comment: "Number of distinct types of cyber events"
    - name: "distinct_matters_affected"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of distinct matters affected by cyber events"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`risk_data_breach_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data breach incident metrics tracking GDPR compliance, data subject notifications, ICO reporting, financial impact, and remediation for personal data breaches"
  source: "`legal_ecm`.`risk`.`data_breach_incident`"
  dimensions:
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the data breach incident (open, under investigation, contained, remediated, closed)"
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity level of the data breach (low, medium, high, critical)"
    - name: "breach_source"
      expr: breach_source
      comment: "Source or cause of the data breach (internal error, external attack, third party, system failure)"
    - name: "affected_system"
      expr: affected_system
      comment: "System or application where the breach occurred"
    - name: "ico_notification_status"
      expr: ico_notification_status
      comment: "Status of ICO notification (not required, pending, submitted, acknowledged)"
    - name: "notification_required_flag"
      expr: notification_required_flag
      comment: "Whether regulatory notification is required under GDPR"
    - name: "data_subject_notification_required_flag"
      expr: data_subject_notification_required_flag
      comment: "Whether data subjects must be notified under GDPR"
    - name: "data_subject_notification_method"
      expr: data_subject_notification_method
      comment: "Method used to notify data subjects (email, letter, public notice, none)"
    - name: "client_data_flag"
      expr: client_data_flag
      comment: "Whether client data was compromised"
    - name: "pii_compromised_flag"
      expr: pii_compromised_flag
      comment: "Whether personally identifiable information was compromised"
    - name: "special_category_data_flag"
      expr: special_category_data_flag
      comment: "Whether special category data (sensitive personal data) was compromised"
    - name: "lpp_protected_data_flag"
      expr: lpp_protected_data_flag
      comment: "Whether legally privileged data was compromised"
    - name: "forensic_investigation_flag"
      expr: forensic_investigation_flag
      comment: "Whether a forensic investigation was conducted"
    - name: "external_counsel_engaged_flag"
      expr: external_counsel_engaged_flag
      comment: "Whether external legal counsel was engaged"
    - name: "law_enforcement_notified_flag"
      expr: law_enforcement_notified_flag
      comment: "Whether law enforcement was notified"
    - name: "insurance_claim_filed_flag"
      expr: insurance_claim_filed_flag
      comment: "Whether an insurance claim was filed"
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year the data breach incident occurred"
    - name: "incident_quarter"
      expr: CONCAT('Q', QUARTER(incident_date), '-', YEAR(incident_date))
      comment: "Quarter and year of the data breach incident"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of the data breach incident"
    - name: "discovery_year"
      expr: YEAR(discovery_date)
      comment: "Year the data breach was discovered"
  measures:
    - name: "total_data_breach_incidents"
      expr: COUNT(1)
      comment: "Total number of data breach incidents"
    - name: "total_estimated_financial_impact"
      expr: SUM(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Total estimated financial impact of all data breaches"
    - name: "avg_estimated_financial_impact"
      expr: AVG(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Average estimated financial impact per data breach"
    - name: "max_estimated_financial_impact"
      expr: MAX(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Maximum estimated financial impact from any single data breach"
    - name: "breaches_requiring_ico_notification"
      expr: SUM(CASE WHEN notification_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of breaches requiring ICO notification under GDPR"
    - name: "breaches_requiring_data_subject_notification"
      expr: SUM(CASE WHEN data_subject_notification_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of breaches requiring data subject notification"
    - name: "breaches_with_pii_compromised"
      expr: SUM(CASE WHEN pii_compromised_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of breaches where personally identifiable information was compromised"
    - name: "breaches_with_special_category_data"
      expr: SUM(CASE WHEN special_category_data_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of breaches involving special category (sensitive) personal data"
    - name: "breaches_with_lpp_data"
      expr: SUM(CASE WHEN lpp_protected_data_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of breaches involving legally privileged data"
    - name: "breaches_with_client_data"
      expr: SUM(CASE WHEN client_data_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of breaches involving client data"
    - name: "breaches_with_forensic_investigation"
      expr: SUM(CASE WHEN forensic_investigation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of breaches requiring forensic investigation"
    - name: "breaches_with_external_counsel"
      expr: SUM(CASE WHEN external_counsel_engaged_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of breaches where external legal counsel was engaged"
    - name: "breaches_with_law_enforcement"
      expr: SUM(CASE WHEN law_enforcement_notified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of breaches where law enforcement was notified"
    - name: "breaches_with_insurance_claim"
      expr: SUM(CASE WHEN insurance_claim_filed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of breaches with insurance claims filed"
    - name: "distinct_affected_systems"
      expr: COUNT(DISTINCT affected_system)
      comment: "Number of distinct systems affected by data breaches"
    - name: "distinct_breach_sources"
      expr: COUNT(DISTINCT breach_source)
      comment: "Number of distinct sources or causes of data breaches"
    - name: "distinct_matters_affected"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of distinct matters affected by data breaches"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`risk_sanctions_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sanctions and AML screening metrics tracking politically exposed persons, adverse media, match rates, clearance decisions, and enhanced due diligence for compliance risk management"
  source: "`legal_ecm`.`risk`.`sanctions_screening`"
  dimensions:
    - name: "screening_status"
      expr: screening_status
      comment: "Current status of the sanctions screening (pending, cleared, escalated, rejected)"
    - name: "clearance_decision"
      expr: clearance_decision
      comment: "Final clearance decision (approved, conditional approval, rejected, pending)"
    - name: "review_outcome"
      expr: review_outcome
      comment: "Outcome of the screening review (no match, false positive, true positive, requires investigation)"
    - name: "aml_risk_rating"
      expr: aml_risk_rating
      comment: "Anti-money laundering risk rating (low, medium, high, prohibited)"
    - name: "screened_entity_type"
      expr: screened_entity_type
      comment: "Type of entity screened (individual, organization, trust, beneficial owner)"
    - name: "screened_entity_country_of_residence"
      expr: screened_entity_country_of_residence
      comment: "Country of residence of the screened entity"
    - name: "pep_flag"
      expr: pep_flag
      comment: "Whether the entity is a politically exposed person"
    - name: "pep_category"
      expr: pep_category
      comment: "Category of politically exposed person (domestic, foreign, international organization, RCA)"
    - name: "adverse_media_flag"
      expr: adverse_media_flag
      comment: "Whether adverse media was found during screening"
    - name: "false_positive_flag"
      expr: false_positive_flag
      comment: "Whether the screening match was determined to be a false positive"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the screening result was escalated for review"
    - name: "enhanced_due_diligence_required_flag"
      expr: enhanced_due_diligence_required_flag
      comment: "Whether enhanced due diligence is required"
    - name: "match_type"
      expr: match_type
      comment: "Type of screening match (exact, fuzzy, phonetic, alias)"
    - name: "screening_list_checked"
      expr: screening_list_checked
      comment: "Sanctions or watchlist checked (OFAC, UN, EU, HMT, PEP, adverse media)"
    - name: "screening_trigger_event"
      expr: screening_trigger_event
      comment: "Event that triggered the screening (onboarding, periodic review, transaction, name change)"
    - name: "screening_system_name"
      expr: screening_system_name
      comment: "Name of the screening system or vendor used"
    - name: "screening_year"
      expr: YEAR(screening_date)
      comment: "Year the screening was conducted"
    - name: "screening_quarter"
      expr: CONCAT('Q', QUARTER(screening_date), '-', YEAR(screening_date))
      comment: "Quarter and year of the screening"
    - name: "screening_month"
      expr: DATE_TRUNC('MONTH', screening_date)
      comment: "Month of the screening"
    - name: "clearance_year"
      expr: YEAR(clearance_date)
      comment: "Year the clearance decision was made"
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total number of sanctions screenings conducted"
    - name: "avg_match_score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average match score across all screenings"
    - name: "max_match_score"
      expr: MAX(CAST(match_score AS DOUBLE))
      comment: "Maximum match score observed in any screening"
    - name: "screenings_with_pep"
      expr: SUM(CASE WHEN pep_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of screenings identifying politically exposed persons"
    - name: "screenings_with_adverse_media"
      expr: SUM(CASE WHEN adverse_media_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of screenings with adverse media findings"
    - name: "false_positive_screenings"
      expr: SUM(CASE WHEN false_positive_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of screenings determined to be false positives"
    - name: "escalated_screenings"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of screenings escalated for further review"
    - name: "screenings_requiring_edd"
      expr: SUM(CASE WHEN enhanced_due_diligence_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of screenings requiring enhanced due diligence"
    - name: "distinct_screened_entities"
      expr: COUNT(DISTINCT screened_entity_name)
      comment: "Number of distinct entities screened"
    - name: "distinct_countries"
      expr: COUNT(DISTINCT screened_entity_country_of_residence)
      comment: "Number of distinct countries of residence for screened entities"
    - name: "distinct_screening_lists"
      expr: COUNT(DISTINCT screening_list_checked)
      comment: "Number of distinct sanctions or watchlists checked"
    - name: "distinct_matters_screened"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of distinct matters with sanctions screenings"
    - name: "distinct_clients_screened"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct clients screened for sanctions"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`risk_third_party_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Third-party vendor risk metrics tracking due diligence, cybersecurity certifications, data protection compliance, inherent and residual risk scores, and ongoing monitoring for supply chain risk management"
  source: "`legal_ecm`.`risk`.`third_party_risk`"
  dimensions:
    - name: "risk_status"
      expr: risk_status
      comment: "Current risk status of the third party (active, under review, suspended, terminated)"
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier classification (low, medium, high, critical)"
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current status of the vendor relationship (active, onboarding, suspended, terminated)"
    - name: "service_category"
      expr: service_category
      comment: "Category of service provided by the third party (IT, legal, consulting, facilities, HR)"
    - name: "due_diligence_status"
      expr: due_diligence_status
      comment: "Status of due diligence process (not started, in progress, completed, expired)"
    - name: "monitoring_status"
      expr: monitoring_status
      comment: "Status of ongoing monitoring (active, paused, not required)"
    - name: "sanctions_screening_status"
      expr: sanctions_screening_status
      comment: "Status of sanctions screening (cleared, pending, flagged, not required)"
    - name: "assessment_frequency"
      expr: assessment_frequency
      comment: "Frequency of risk reassessment (quarterly, semi-annually, annually, ad-hoc)"
    - name: "data_access_level"
      expr: data_access_level
      comment: "Level of data access granted to the third party (none, limited, moderate, extensive)"
    - name: "iso_27001_certified_flag"
      expr: iso_27001_certified_flag
      comment: "Whether the vendor holds ISO 27001 certification"
    - name: "soc2_certified_flag"
      expr: soc2_certified_flag
      comment: "Whether the vendor holds SOC 2 certification"
    - name: "gdpr_compliant_flag"
      expr: gdpr_compliant_flag
      comment: "Whether the vendor is GDPR compliant"
    - name: "dpa_signed_flag"
      expr: dpa_signed_flag
      comment: "Whether a Data Processing Agreement has been signed"
    - name: "client_data_flag"
      expr: client_data_flag
      comment: "Whether the vendor has access to client data"
    - name: "pii_access_flag"
      expr: pii_access_flag
      comment: "Whether the vendor has access to personally identifiable information"
    - name: "lpp_access_flag"
      expr: lpp_access_flag
      comment: "Whether the vendor has access to legally privileged information"
    - name: "reputational_risk_flag"
      expr: reputational_risk_flag
      comment: "Whether the vendor poses reputational risk"
    - name: "onboarding_year"
      expr: YEAR(onboarding_date)
      comment: "Year the vendor was onboarded"
    - name: "last_assessment_year"
      expr: YEAR(last_assessment_date)
      comment: "Year of the most recent risk assessment"
    - name: "iso_expiry_year"
      expr: YEAR(iso_27001_expiry_date)
      comment: "Year the ISO 27001 certification expires"
  measures:
    - name: "total_third_party_risks"
      expr: COUNT(1)
      comment: "Total number of third-party vendor risk assessments"
    - name: "avg_inherent_risk_score"
      expr: AVG(CAST(inherent_risk_score AS DOUBLE))
      comment: "Average inherent risk score before controls"
    - name: "avg_residual_risk_score"
      expr: AVG(CAST(residual_risk_score AS DOUBLE))
      comment: "Average residual risk score after controls"
    - name: "max_inherent_risk_score"
      expr: MAX(CAST(inherent_risk_score AS DOUBLE))
      comment: "Maximum inherent risk score among all vendors"
    - name: "max_residual_risk_score"
      expr: MAX(CAST(residual_risk_score AS DOUBLE))
      comment: "Maximum residual risk score among all vendors"
    - name: "vendors_with_iso27001"
      expr: SUM(CASE WHEN iso_27001_certified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of vendors with ISO 27001 certification"
    - name: "vendors_with_soc2"
      expr: SUM(CASE WHEN soc2_certified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of vendors with SOC 2 certification"
    - name: "vendors_gdpr_compliant"
      expr: SUM(CASE WHEN gdpr_compliant_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of vendors that are GDPR compliant"
    - name: "vendors_with_dpa_signed"
      expr: SUM(CASE WHEN dpa_signed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of vendors with signed Data Processing Agreements"
    - name: "vendors_with_client_data_access"
      expr: SUM(CASE WHEN client_data_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of vendors with access to client data"
    - name: "vendors_with_pii_access"
      expr: SUM(CASE WHEN pii_access_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of vendors with access to personally identifiable information"
    - name: "vendors_with_lpp_access"
      expr: SUM(CASE WHEN lpp_access_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of vendors with access to legally privileged information"
    - name: "vendors_with_reputational_risk"
      expr: SUM(CASE WHEN reputational_risk_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of vendors flagged for reputational risk"
    - name: "distinct_service_categories"
      expr: COUNT(DISTINCT service_category)
      comment: "Number of distinct service categories provided by vendors"
    - name: "distinct_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors assessed"
$$;