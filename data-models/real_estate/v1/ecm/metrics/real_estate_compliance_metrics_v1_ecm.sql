-- Metric views for domain: compliance | Business: Real Estate | Version: 1 | Generated on: 2026-05-02 01:37:58

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`compliance_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance assessment KPIs tracking audit findings, risk ratings, and remediation costs across assets and programs"
  source: "`real_estate_ecm`.`compliance`.`assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of compliance assessment conducted"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the assessment"
    - name: "overall_risk_rating"
      expr: overall_risk_rating
      comment: "Overall risk rating assigned to the assessment"
    - name: "audit_opinion"
      expr: audit_opinion
      comment: "Auditor opinion on compliance"
    - name: "assessor_type"
      expr: assessor_type
      comment: "Type of assessor (internal, external, third-party)"
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation actions"
    - name: "assessment_year"
      expr: YEAR(report_issued_date)
      comment: "Year the assessment report was issued"
    - name: "assessment_quarter"
      expr: CONCAT('Q', QUARTER(report_issued_date))
      comment: "Quarter the assessment report was issued"
    - name: "material_weakness_flag"
      expr: material_weakness_identified
      comment: "Whether material weakness was identified"
    - name: "remediation_required_flag"
      expr: remediation_required
      comment: "Whether remediation is required"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of compliance assessments conducted"
    - name: "total_estimated_remediation_cost"
      expr: SUM(CAST(estimated_remediation_cost AS DOUBLE))
      comment: "Total estimated cost to remediate all findings across assessments"
    - name: "avg_esg_score"
      expr: AVG(CAST(esg_score AS DOUBLE))
      comment: "Average ESG score across assessments"
    - name: "assessments_with_material_weakness"
      expr: SUM(CASE WHEN material_weakness_identified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assessments where material weakness was identified"
    - name: "assessments_requiring_remediation"
      expr: SUM(CASE WHEN remediation_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assessments requiring remediation actions"
    - name: "material_weakness_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN material_weakness_identified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments with material weakness identified"
    - name: "remediation_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN remediation_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments requiring remediation"
    - name: "avg_remediation_cost_per_assessment"
      expr: AVG(CAST(estimated_remediation_cost AS DOUBLE))
      comment: "Average estimated remediation cost per assessment"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`compliance_audit_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit engagement KPIs tracking audit costs, findings, deficiencies, and engagement outcomes"
  source: "`real_estate_ecm`.`compliance`.`audit_engagement`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit engagement"
    - name: "audit_category"
      expr: audit_category
      comment: "Category of audit"
    - name: "engagement_status"
      expr: engagement_status
      comment: "Current status of the audit engagement"
    - name: "audit_opinion"
      expr: audit_opinion
      comment: "Auditor opinion on the engagement"
    - name: "auditing_entity_type"
      expr: auditing_entity_type
      comment: "Type of auditing entity (internal, external, regulatory)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the audit engagement"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the audit engagement"
    - name: "sox_audit_flag"
      expr: sox_audit_flag
      comment: "Whether this is a SOX audit"
    - name: "esg_audit_flag"
      expr: esg_audit_flag
      comment: "Whether this is an ESG audit"
    - name: "material_weakness_flag"
      expr: material_weakness_identified
      comment: "Whether material weakness was identified"
    - name: "significant_deficiency_flag"
      expr: significant_deficiency_identified
      comment: "Whether significant deficiency was identified"
  measures:
    - name: "total_audit_engagements"
      expr: COUNT(1)
      comment: "Total number of audit engagements"
    - name: "total_engagement_fees"
      expr: SUM(CAST(engagement_fee_amount AS DOUBLE))
      comment: "Total fees paid for audit engagements"
    - name: "avg_engagement_fee"
      expr: AVG(CAST(engagement_fee_amount AS DOUBLE))
      comment: "Average fee per audit engagement"
    - name: "engagements_with_material_weakness"
      expr: SUM(CASE WHEN material_weakness_identified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of engagements with material weakness identified"
    - name: "engagements_with_significant_deficiency"
      expr: SUM(CASE WHEN significant_deficiency_identified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of engagements with significant deficiency identified"
    - name: "material_weakness_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN material_weakness_identified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audit engagements with material weakness"
    - name: "significant_deficiency_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN significant_deficiency_identified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audit engagements with significant deficiency"
    - name: "sox_audit_count"
      expr: SUM(CASE WHEN sox_audit_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of SOX audit engagements"
    - name: "esg_audit_count"
      expr: SUM(CASE WHEN esg_audit_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ESG audit engagements"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`compliance_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance program KPIs tracking budget utilization, compliance scores, findings, and training completion"
  source: "`real_estate_ecm`.`compliance`.`compliance_program`"
  dimensions:
    - name: "program_type"
      expr: program_type
      comment: "Type of compliance program"
    - name: "program_status"
      expr: program_status
      comment: "Current status of the compliance program"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the compliance program"
    - name: "esg_category"
      expr: esg_category
      comment: "ESG category of the program"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the program"
    - name: "certification_standard"
      expr: certification_standard
      comment: "Certification standard the program adheres to"
    - name: "sox_applicable_flag"
      expr: sox_applicable
      comment: "Whether SOX is applicable to this program"
    - name: "training_required_flag"
      expr: training_required
      comment: "Whether training is required for this program"
  measures:
    - name: "total_compliance_programs"
      expr: COUNT(1)
      comment: "Total number of compliance programs"
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_usd AS DOUBLE))
      comment: "Total budget allocated across all compliance programs"
    - name: "total_budget_spent"
      expr: SUM(CAST(budget_spent_usd AS DOUBLE))
      comment: "Total budget spent across all compliance programs"
    - name: "avg_compliance_score"
      expr: AVG(CAST(overall_compliance_score AS DOUBLE))
      comment: "Average overall compliance score across programs"
    - name: "avg_training_completion_rate"
      expr: AVG(CAST(training_completion_rate AS DOUBLE))
      comment: "Average training completion rate across programs"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(budget_spent_usd AS DOUBLE)) / NULLIF(SUM(CAST(budget_allocated_usd AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated budget that has been spent"
    - name: "programs_with_sox"
      expr: SUM(CASE WHEN sox_applicable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of programs where SOX is applicable"
    - name: "programs_requiring_training"
      expr: SUM(CASE WHEN training_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of programs requiring training"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`compliance_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance violation KPIs tracking penalty amounts, violation severity, resolution outcomes, and repeat violations"
  source: "`real_estate_ecm`.`compliance`.`violation`"
  dimensions:
    - name: "violation_type"
      expr: violation_type
      comment: "Type of compliance violation"
    - name: "violation_status"
      expr: violation_status
      comment: "Current status of the violation"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the violation"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the violation"
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of the violation resolution"
    - name: "esg_category"
      expr: esg_category
      comment: "ESG category of the violation"
    - name: "violation_year"
      expr: YEAR(violation_date)
      comment: "Year the violation occurred"
    - name: "violation_quarter"
      expr: CONCAT('Q', QUARTER(violation_date))
      comment: "Quarter the violation occurred"
    - name: "is_repeat_violation"
      expr: is_repeat_violation
      comment: "Whether this is a repeat violation"
    - name: "is_contested"
      expr: is_contested
      comment: "Whether the violation is being contested"
    - name: "osha_recordable_flag"
      expr: osha_recordable
      comment: "Whether the violation is OSHA recordable"
  measures:
    - name: "total_violations"
      expr: COUNT(1)
      comment: "Total number of compliance violations"
    - name: "total_penalty_assessed"
      expr: SUM(CAST(penalty_amount_assessed AS DOUBLE))
      comment: "Total penalty amount assessed across all violations"
    - name: "total_penalty_settled"
      expr: SUM(CAST(penalty_amount_settled AS DOUBLE))
      comment: "Total penalty amount settled across all violations"
    - name: "avg_penalty_assessed"
      expr: AVG(CAST(penalty_amount_assessed AS DOUBLE))
      comment: "Average penalty amount assessed per violation"
    - name: "avg_penalty_settled"
      expr: AVG(CAST(penalty_amount_settled AS DOUBLE))
      comment: "Average penalty amount settled per violation"
    - name: "repeat_violations_count"
      expr: SUM(CASE WHEN is_repeat_violation = TRUE THEN 1 ELSE 0 END)
      comment: "Count of repeat violations"
    - name: "contested_violations_count"
      expr: SUM(CASE WHEN is_contested = TRUE THEN 1 ELSE 0 END)
      comment: "Count of violations being contested"
    - name: "repeat_violation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_repeat_violation = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of violations that are repeat violations"
    - name: "penalty_settlement_rate"
      expr: ROUND(100.0 * SUM(CAST(penalty_amount_settled AS DOUBLE)) / NULLIF(SUM(CAST(penalty_amount_assessed AS DOUBLE)), 0), 2)
      comment: "Percentage of assessed penalties that have been settled"
    - name: "osha_recordable_violations"
      expr: SUM(CASE WHEN osha_recordable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of OSHA recordable violations"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`compliance_remediation_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Remediation action KPIs tracking completion rates, cost variance, escalations, and on-time delivery"
  source: "`real_estate_ecm`.`compliance`.`remediation_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of remediation action"
    - name: "action_status"
      expr: action_status
      comment: "Current status of the remediation action"
    - name: "priority"
      expr: priority
      comment: "Priority level of the remediation action"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the issue being remediated"
    - name: "esg_category"
      expr: esg_category
      comment: "ESG category of the remediation action"
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the finding being remediated"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the action has been escalated"
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether this is a recurring issue"
  measures:
    - name: "total_remediation_actions"
      expr: COUNT(1)
      comment: "Total number of remediation actions"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all remediation actions"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of all remediation actions"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per remediation action"
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per remediation action"
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_exposure_amount AS DOUBLE))
      comment: "Total penalty exposure amount across all remediation actions"
    - name: "escalated_actions_count"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of remediation actions that have been escalated"
    - name: "recurring_issues_count"
      expr: SUM(CASE WHEN recurrence_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of remediation actions for recurring issues"
    - name: "escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of remediation actions that have been escalated"
    - name: "recurrence_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN recurrence_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of remediation actions addressing recurring issues"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`compliance_esg_metric`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ESG metric KPIs tracking environmental, social, and governance performance against targets and baselines"
  source: "`real_estate_ecm`.`compliance`.`esg_metric`"
  dimensions:
    - name: "esg_pillar"
      expr: esg_pillar
      comment: "ESG pillar (Environmental, Social, Governance)"
    - name: "metric_category"
      expr: metric_category
      comment: "Category of the ESG metric"
    - name: "metric_name"
      expr: metric_name
      comment: "Name of the ESG metric"
    - name: "reporting_framework"
      expr: reporting_framework
      comment: "ESG reporting framework used"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the metric"
    - name: "ghg_scope"
      expr: ghg_scope
      comment: "GHG emissions scope (Scope 1, 2, 3)"
    - name: "reporting_year"
      expr: YEAR(reporting_period_end)
      comment: "Year of the reporting period end"
    - name: "is_landlord_controlled"
      expr: is_landlord_controlled
      comment: "Whether the metric is landlord-controlled"
  measures:
    - name: "total_esg_metrics"
      expr: COUNT(1)
      comment: "Total number of ESG metrics tracked"
    - name: "avg_metric_value"
      expr: AVG(CAST(metric_value AS DOUBLE))
      comment: "Average metric value across all ESG metrics"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across all ESG metrics"
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline value across all ESG metrics"
    - name: "avg_renewable_energy_pct"
      expr: AVG(CAST(renewable_energy_pct AS DOUBLE))
      comment: "Average renewable energy percentage across properties"
    - name: "avg_waste_diversion_rate"
      expr: AVG(CAST(waste_diversion_rate AS DOUBLE))
      comment: "Average waste diversion rate across properties"
    - name: "avg_tenant_satisfaction_score"
      expr: AVG(CAST(tenant_satisfaction_score AS DOUBLE))
      comment: "Average tenant satisfaction score"
    - name: "total_community_investment"
      expr: SUM(CAST(community_investment_usd AS DOUBLE))
      comment: "Total community investment in USD"
    - name: "avg_board_diversity_pct"
      expr: AVG(CAST(board_diversity_pct AS DOUBLE))
      comment: "Average board diversity percentage"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`compliance_sox_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SOX control KPIs tracking control effectiveness, deficiencies, exceptions, and remediation status"
  source: "`real_estate_ecm`.`compliance`.`sox_control`"
  dimensions:
    - name: "control_type"
      expr: control_type
      comment: "Type of SOX control"
    - name: "control_status"
      expr: control_status
      comment: "Current status of the SOX control"
    - name: "control_category"
      expr: control_category
      comment: "Category of the SOX control"
    - name: "design_effectiveness"
      expr: design_effectiveness
      comment: "Design effectiveness rating of the control"
    - name: "operating_effectiveness"
      expr: operating_effectiveness
      comment: "Operating effectiveness rating of the control"
    - name: "deficiency_classification"
      expr: deficiency_classification
      comment: "Classification of any deficiency identified"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the control"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the control testing"
    - name: "is_key_control"
      expr: is_key_control
      comment: "Whether this is a key control"
    - name: "is_automated"
      expr: is_automated
      comment: "Whether the control is automated"
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation for any deficiencies"
  measures:
    - name: "total_sox_controls"
      expr: COUNT(1)
      comment: "Total number of SOX controls"
    - name: "key_controls_count"
      expr: SUM(CASE WHEN is_key_control = TRUE THEN 1 ELSE 0 END)
      comment: "Count of key SOX controls"
    - name: "automated_controls_count"
      expr: SUM(CASE WHEN is_automated = TRUE THEN 1 ELSE 0 END)
      comment: "Count of automated SOX controls"
    - name: "key_control_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_key_control = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of controls that are key controls"
    - name: "automation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_automated = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of controls that are automated"
    - name: "controls_with_exceptions"
      expr: SUM(CASE WHEN exception_count IS NOT NULL AND exception_count != '0' THEN 1 ELSE 0 END)
      comment: "Count of controls with exceptions identified"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory filing KPIs tracking filing timeliness, approval rates, penalty exposure, and amendment frequency"
  source: "`real_estate_ecm`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_type"
      expr: filing_type
      comment: "Type of regulatory filing"
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the filing"
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category of the filing"
    - name: "esg_category"
      expr: esg_category
      comment: "ESG category of the filing"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the filing"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the filing"
    - name: "is_amendment"
      expr: is_amendment
      comment: "Whether this filing is an amendment"
    - name: "is_material"
      expr: is_material
      comment: "Whether this filing is material"
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the filing"
  measures:
    - name: "total_regulatory_filings"
      expr: COUNT(1)
      comment: "Total number of regulatory filings"
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_exposure_amount AS DOUBLE))
      comment: "Total penalty exposure amount across all filings"
    - name: "avg_penalty_exposure"
      expr: AVG(CAST(penalty_exposure_amount AS DOUBLE))
      comment: "Average penalty exposure per filing"
    - name: "amendment_count"
      expr: SUM(CASE WHEN is_amendment = TRUE THEN 1 ELSE 0 END)
      comment: "Count of filings that are amendments"
    - name: "material_filings_count"
      expr: SUM(CASE WHEN is_material = TRUE THEN 1 ELSE 0 END)
      comment: "Count of material filings"
    - name: "amendment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_amendment = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings that are amendments"
    - name: "material_filing_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_material = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings that are material"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`compliance_osha_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OSHA incident KPIs tracking workplace safety, injury severity, lost time, and incident costs"
  source: "`real_estate_ecm`.`compliance`.`osha_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of OSHA incident"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident"
    - name: "osha_log_category"
      expr: osha_log_category
      comment: "OSHA log category of the incident"
    - name: "osha_recordability"
      expr: osha_recordability
      comment: "OSHA recordability classification"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the incident"
    - name: "incident_year"
      expr: incident_year
      comment: "Year the incident occurred"
    - name: "fatality_flag"
      expr: fatality_flag
      comment: "Whether the incident resulted in a fatality"
    - name: "hospitalization_flag"
      expr: hospitalization_flag
      comment: "Whether the incident resulted in hospitalization"
    - name: "amputation_flag"
      expr: amputation_flag
      comment: "Whether the incident resulted in amputation"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions"
  measures:
    - name: "total_osha_incidents"
      expr: COUNT(1)
      comment: "Total number of OSHA incidents"
    - name: "total_estimated_incident_cost"
      expr: SUM(CAST(estimated_incident_cost AS DOUBLE))
      comment: "Total estimated cost of all OSHA incidents"
    - name: "avg_estimated_incident_cost"
      expr: AVG(CAST(estimated_incident_cost AS DOUBLE))
      comment: "Average estimated cost per OSHA incident"
    - name: "fatality_count"
      expr: SUM(CASE WHEN fatality_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents resulting in fatality"
    - name: "hospitalization_count"
      expr: SUM(CASE WHEN hospitalization_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents resulting in hospitalization"
    - name: "amputation_count"
      expr: SUM(CASE WHEN amputation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents resulting in amputation"
    - name: "severe_incident_rate"
      expr: ROUND(100.0 * (SUM(CASE WHEN fatality_flag = TRUE THEN 1 ELSE 0 END) + SUM(CASE WHEN hospitalization_flag = TRUE THEN 1 ELSE 0 END) + SUM(CASE WHEN amputation_flag = TRUE THEN 1 ELSE 0 END)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that are severe (fatality, hospitalization, or amputation)"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`compliance_green_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Green certification KPIs tracking certification levels, scores, certified area, and renewal status"
  source: "`real_estate_ecm`.`compliance`.`green_certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of green certification"
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification"
    - name: "certification_level"
      expr: certification_level
      comment: "Level of certification achieved"
    - name: "certifying_body"
      expr: certifying_body
      comment: "Body that issued the certification"
    - name: "certification_year"
      expr: YEAR(certification_date)
      comment: "Year the certification was issued"
    - name: "renewal_in_progress_flag"
      expr: renewal_in_progress
      comment: "Whether renewal is currently in progress"
    - name: "esg_reportable_flag"
      expr: esg_reportable
      comment: "Whether the certification is ESG reportable"
    - name: "incentive_eligible_flag"
      expr: incentive_eligible
      comment: "Whether the certification is eligible for incentives"
  measures:
    - name: "total_green_certifications"
      expr: COUNT(1)
      comment: "Total number of green certifications"
    - name: "total_certified_area_sqft"
      expr: SUM(CAST(certified_area_sqft AS DOUBLE))
      comment: "Total certified area in square feet"
    - name: "avg_certified_area_sqft"
      expr: AVG(CAST(certified_area_sqft AS DOUBLE))
      comment: "Average certified area per certification in square feet"
    - name: "avg_points_scored"
      expr: AVG(CAST(points_scored AS DOUBLE))
      comment: "Average points scored across certifications"
    - name: "avg_score_percentage"
      expr: AVG(CAST(score_percentage AS DOUBLE))
      comment: "Average score percentage across certifications"
    - name: "certifications_with_renewal_in_progress"
      expr: SUM(CASE WHEN renewal_in_progress = TRUE THEN 1 ELSE 0 END)
      comment: "Count of certifications with renewal in progress"
    - name: "esg_reportable_certifications"
      expr: SUM(CASE WHEN esg_reportable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ESG reportable certifications"
    - name: "incentive_eligible_certifications"
      expr: SUM(CASE WHEN incentive_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of certifications eligible for incentives"
$$;