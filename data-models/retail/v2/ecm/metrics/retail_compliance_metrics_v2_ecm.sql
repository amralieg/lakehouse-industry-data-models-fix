-- Metric views for domain: compliance | Business: Retail | Version: 2 | Generated on: 2026-06-23 23:42:36

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`compliance_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic overview of compliance programs — tracks program risk exposure, penalty ceilings, and certification currency to steer enterprise compliance investment and prioritization."
  source: "`vibe_retail_v1`.`compliance`.`compliance_program`"
  dimensions:
    - name: "program_type"
      expr: program_type
      comment: "Category of compliance program (e.g., regulatory, internal, contractual) for portfolio segmentation."
    - name: "program_status"
      expr: program_status
      comment: "Current lifecycle status of the program (active, suspended, closed) for operational filtering."
    - name: "risk_level"
      expr: risk_level
      comment: "Assessed risk level of the program (high, medium, low) for risk-tiered reporting."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Governing regulatory framework (e.g., FSMA, OSHA, PCI-DSS) for framework-level compliance tracking."
    - name: "owning_business_unit"
      expr: owning_business_unit
      comment: "Business unit accountable for the program, enabling accountability reporting by org unit."
    - name: "certification_status"
      expr: certification_status
      comment: "Current certification status of the program to identify programs at risk of lapsing."
    - name: "program_scope"
      expr: program_scope
      comment: "Geographic or operational scope of the program for jurisdiction-level analysis."
  measures:
    - name: "active_program_count"
      expr: COUNT(CASE WHEN program_status = 'active' THEN compliance_program_id END)
      comment: "Number of currently active compliance programs. Executives use this to gauge the breadth of the compliance portfolio and resource requirements."
    - name: "total_max_penalty_exposure"
      expr: SUM(CAST(penalty_amount_max AS DOUBLE))
      comment: "Sum of maximum penalty amounts across all programs. Directly quantifies the financial risk ceiling of non-compliance for CFO and General Counsel review."
    - name: "avg_max_penalty_per_program"
      expr: AVG(CAST(penalty_amount_max AS DOUBLE))
      comment: "Average maximum penalty per compliance program. Helps prioritize remediation investment toward highest-exposure programs."
    - name: "high_risk_program_count"
      expr: COUNT(CASE WHEN risk_level = 'high' THEN compliance_program_id END)
      comment: "Number of programs rated high risk. A rising count signals escalating compliance exposure requiring executive intervention."
    - name: "programs_requiring_training_count"
      expr: COUNT(CASE WHEN training_required = TRUE THEN compliance_program_id END)
      comment: "Number of programs with mandatory training requirements. Drives workforce training budget and scheduling decisions."
    - name: "expiring_programs_count"
      expr: COUNT(CASE WHEN expiration_date <= DATE_ADD(CURRENT_DATE(), 90) AND expiration_date >= CURRENT_DATE() THEN compliance_program_id END)
      comment: "Programs expiring within 90 days. Triggers renewal workflows and prevents lapses in regulatory coverage."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`compliance_audit_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and strategic audit performance metrics — tracks audit scores, findings severity, duration efficiency, and follow-up rates to drive continuous improvement in the audit program."
  source: "`vibe_retail_v1`.`compliance`.`audit_event`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (internal, external, regulatory, supplier) for segmented performance analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (planned, in-progress, completed, closed) for pipeline visibility."
    - name: "audit_result"
      expr: audit_result
      comment: "Overall audit outcome (pass, fail, conditional) for pass-rate trending."
    - name: "audit_method"
      expr: audit_method
      comment: "Method used (on-site, remote, hybrid) to analyze effectiveness by delivery mode."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework under which the audit was conducted for framework-level compliance tracking."
    - name: "audit_scope"
      expr: audit_scope
      comment: "Scope of the audit (full, targeted, follow-up) for coverage analysis."
    - name: "audit_date_month"
      expr: DATE_TRUNC('MONTH', audit_date)
      comment: "Month of audit date for time-series trending of audit volume and scores."
  measures:
    - name: "total_audits_conducted"
      expr: COUNT(1)
      comment: "Total number of audit events conducted. Baseline volume metric for audit program capacity planning."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score across all completed audits. Primary KPI for overall compliance health; declining scores trigger remediation programs."
    - name: "avg_audit_duration_hours"
      expr: AVG(CAST(audit_duration_hours AS DOUBLE))
      comment: "Average time spent per audit in hours. Efficiency metric for audit resource planning and benchmarking."
    - name: "total_audit_hours"
      expr: SUM(CAST(audit_duration_hours AS DOUBLE))
      comment: "Total audit hours consumed across all events. Drives audit team capacity and budget planning."
    - name: "audits_requiring_corrective_action_count"
      expr: COUNT(CASE WHEN corrective_action_plan_required_flag = TRUE THEN audit_event_id END)
      comment: "Number of audits that identified issues requiring a corrective action plan. High counts signal systemic compliance gaps."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_plan_required_flag = TRUE THEN audit_event_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits resulting in a corrective action plan. Key quality indicator; rising rate signals deteriorating compliance posture."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN audit_event_id END)
      comment: "Number of audits requiring follow-up. Tracks unresolved compliance issues that need management attention."
    - name: "regulatory_notification_required_count"
      expr: COUNT(CASE WHEN regulatory_notification_required_flag = TRUE THEN audit_event_id END)
      comment: "Number of audits triggering mandatory regulatory notification. High-severity indicator with direct legal and reputational consequences."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding severity, financial impact, and resolution metrics — enables leadership to prioritize remediation investment and track recurrence patterns that indicate systemic compliance failures."
  source: "`vibe_retail_v1`.`compliance`.`audit_finding`"
  dimensions:
    - name: "audit_finding_category"
      expr: audit_finding_category
      comment: "Category of the finding (safety, regulatory, operational, financial) for thematic analysis."
    - name: "audit_finding_status"
      expr: audit_finding_status
      comment: "Current resolution status (open, in-progress, closed, verified) for remediation pipeline tracking."
    - name: "regulatory_standard"
      expr: regulatory_standard
      comment: "Regulatory standard violated, enabling standard-level compliance gap analysis."
    - name: "affected_area"
      expr: affected_area
      comment: "Operational area affected by the finding for targeted remediation prioritization."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether the finding is a recurrence of a prior issue — recurrent findings indicate systemic root causes."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether a corrective action is required, for filtering findings that demand active remediation."
    - name: "identified_date_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month findings were identified for trend analysis of compliance deterioration or improvement."
  measures:
    - name: "total_findings_count"
      expr: COUNT(1)
      comment: "Total number of audit findings. Baseline volume metric for compliance health trending."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total estimated financial impact of all audit findings. Directly quantifies the cost of non-compliance for CFO and board reporting."
    - name: "avg_financial_impact_per_finding"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per finding. Helps prioritize remediation by expected cost avoidance."
    - name: "open_findings_count"
      expr: COUNT(CASE WHEN audit_finding_status = 'open' THEN audit_finding_id END)
      comment: "Number of unresolved open findings. A growing backlog signals under-resourced remediation and escalating risk."
    - name: "recurrent_findings_count"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN audit_finding_id END)
      comment: "Number of findings that are recurrences of prior issues. Recurrence rate is a leading indicator of systemic compliance failure."
    - name: "recurrence_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_flag = TRUE THEN audit_finding_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that are recurrences. High recurrence rate signals root causes are not being addressed, requiring escalation."
    - name: "findings_requiring_regulatory_report_count"
      expr: COUNT(CASE WHEN regulatory_reporting_required_flag = TRUE THEN audit_finding_id END)
      comment: "Number of findings requiring regulatory reporting. Each represents a mandatory disclosure obligation with legal consequences if missed."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`compliance_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action program effectiveness metrics — tracks resolution timeliness, cost of remediation, and escalation rates to ensure compliance gaps are closed before they become regulatory violations."
  source: "`vibe_retail_v1`.`compliance`.`corrective_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action (preventive, corrective, systemic) for program effectiveness analysis."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Current status (open, in-progress, verified, closed) for remediation pipeline management."
    - name: "priority"
      expr: priority
      comment: "Priority level of the corrective action (critical, high, medium, low) for resource allocation."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance domain the action addresses (food safety, environmental, PCI, OSHA) for category-level tracking."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework driving the corrective action for framework-level remediation tracking."
    - name: "escalation_required"
      expr: escalation_required
      comment: "Whether the action has been escalated, indicating items that exceeded normal resolution channels."
    - name: "target_completion_month"
      expr: DATE_TRUNC('MONTH', target_completion_date)
      comment: "Month the corrective action is targeted for completion, for workload forecasting."
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total corrective actions in the program. Volume baseline for remediation capacity planning."
    - name: "total_actual_remediation_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred for corrective actions. Quantifies the financial burden of compliance remediation for budget owners."
    - name: "total_estimated_remediation_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all open corrective actions. Enables forward-looking budget planning for compliance remediation."
    - name: "avg_actual_remediation_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per corrective action. Benchmarks remediation efficiency and identifies outlier cost events."
    - name: "open_corrective_actions_count"
      expr: COUNT(CASE WHEN corrective_action_status = 'open' THEN corrective_action_id END)
      comment: "Number of open corrective actions. A growing backlog is a leading risk indicator requiring management escalation."
    - name: "escalated_actions_count"
      expr: COUNT(CASE WHEN escalation_required = TRUE THEN corrective_action_id END)
      comment: "Number of corrective actions that required escalation. Escalation rate signals systemic remediation failures."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_required = TRUE THEN corrective_action_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions escalated. High escalation rate indicates the standard remediation process is insufficient."
    - name: "external_reporting_required_count"
      expr: COUNT(CASE WHEN external_reporting_required = TRUE THEN corrective_action_id END)
      comment: "Number of corrective actions requiring external regulatory reporting. Each represents a mandatory disclosure with legal consequences."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`compliance_violation_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory violation financial exposure and resolution metrics — tracks penalty amounts, settlement outcomes, and recurrence patterns to quantify regulatory risk and drive enforcement response strategy."
  source: "`vibe_retail_v1`.`compliance`.`violation_notice`"
  dimensions:
    - name: "violation_type"
      expr: violation_type
      comment: "Type of violation (safety, environmental, food, financial) for category-level risk analysis."
    - name: "violation_status"
      expr: violation_status
      comment: "Current status (open, appealed, settled, closed) for active liability tracking."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the violation (critical, major, minor) for risk-tiered executive reporting."
    - name: "regulatory_standard_violated"
      expr: regulatory_standard_violated
      comment: "Specific regulatory standard violated for standard-level compliance gap analysis."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether this is a repeat violation — recurrence triggers enhanced regulatory scrutiny and higher penalties."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Whether an appeal was filed, for tracking contested violations and legal cost exposure."
    - name: "violation_date_month"
      expr: DATE_TRUNC('MONTH', violation_date)
      comment: "Month of violation for time-series trending of regulatory enforcement activity."
  measures:
    - name: "total_violations_count"
      expr: COUNT(1)
      comment: "Total number of violation notices received. Primary volume metric for regulatory enforcement exposure."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total assessed penalty amounts across all violations. Direct financial liability metric for CFO and legal counsel."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amounts paid. Quantifies actual cash outflow from regulatory enforcement for financial planning."
    - name: "avg_penalty_per_violation"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty per violation. Benchmarks enforcement severity and informs risk-adjusted compliance investment decisions."
    - name: "open_violations_count"
      expr: COUNT(CASE WHEN violation_status = 'open' THEN violation_notice_id END)
      comment: "Number of unresolved open violations. Represents active regulatory liability requiring immediate management attention."
    - name: "recurrent_violations_count"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN violation_notice_id END)
      comment: "Number of repeat violations. Recurrence signals systemic non-compliance and triggers heightened regulatory scrutiny."
    - name: "settlement_negotiated_count"
      expr: COUNT(CASE WHEN settlement_negotiated_flag = TRUE THEN violation_notice_id END)
      comment: "Number of violations resolved through negotiated settlement. Tracks legal strategy effectiveness in reducing penalty exposure."
    - name: "penalty_to_settlement_ratio"
      expr: ROUND(SUM(CAST(settlement_amount AS DOUBLE)) / NULLIF(SUM(CAST(penalty_amount AS DOUBLE)), 0), 4)
      comment: "Ratio of total settlement paid to total penalty assessed. Values below 1.0 indicate successful negotiation; tracks legal team effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`compliance_osha_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workplace safety incident metrics — tracks OSHA recordable rates, severity, and cost to drive safety program investment and meet regulatory reporting obligations."
  source: "`vibe_retail_v1`.`compliance`.`osha_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of OSHA incident (injury, illness, near-miss, fatality) for severity-based safety analysis."
    - name: "osha_incident_status"
      expr: osha_incident_status
      comment: "Current status of the incident (open, under-investigation, closed) for case management tracking."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the incident for risk-tiered safety reporting."
    - name: "injury_type"
      expr: injury_type
      comment: "Nature of injury or illness for targeted safety intervention program design."
    - name: "osha_recordable_flag"
      expr: osha_recordable_flag
      comment: "Whether the incident meets OSHA recordability criteria — directly impacts OSHA 300 log and regulatory reporting."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether this is a repeat incident type — recurrence signals inadequate corrective action."
    - name: "incident_date_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of incident for time-series safety trend analysis and seasonal pattern detection."
  measures:
    - name: "total_incidents_count"
      expr: COUNT(1)
      comment: "Total number of OSHA incidents. Primary safety volume metric for executive safety dashboards."
    - name: "osha_recordable_incidents_count"
      expr: COUNT(CASE WHEN osha_recordable_flag = TRUE THEN osha_incident_id END)
      comment: "Number of OSHA-recordable incidents. Directly feeds OSHA 300 log compliance and regulatory reporting obligations."
    - name: "osha_recordable_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN osha_recordable_flag = TRUE THEN osha_incident_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that are OSHA recordable. Key safety KPI benchmarked against industry rates; rising rate triggers safety program review."
    - name: "total_estimated_incident_cost"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated financial cost of all incidents (medical, workers comp, lost productivity). Quantifies the business case for safety investment."
    - name: "avg_estimated_incident_cost"
      expr: AVG(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Average cost per incident. Benchmarks incident severity and informs safety program ROI calculations."
    - name: "regulatory_reporting_required_count"
      expr: COUNT(CASE WHEN regulatory_reporting_required_flag = TRUE THEN osha_incident_id END)
      comment: "Number of incidents requiring mandatory regulatory reporting. Each represents a legal obligation with penalties for non-compliance."
    - name: "recurrent_incidents_count"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN osha_incident_id END)
      comment: "Number of repeat incident types. Recurrence signals root causes are unaddressed, requiring escalated safety intervention."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`compliance_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance training completion and effectiveness metrics — tracks pass rates, assessment scores, and cost per learner to ensure workforce compliance readiness and optimize training program investment."
  source: "`vibe_retail_v1`.`compliance`.`training_completion`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the training completion (compliant, non-compliant, waived) for workforce readiness reporting."
    - name: "pass_fail_result"
      expr: pass_fail_result
      comment: "Pass or fail outcome of the training assessment for program effectiveness analysis."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Training delivery method (online, classroom, on-the-job) for channel effectiveness comparison."
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Whether the training was mandatory — mandatory completions are regulatory obligations, not optional development."
    - name: "job_role_category"
      expr: job_role_category
      comment: "Job role category of the trainee for role-based compliance gap analysis."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework the training supports for framework-level compliance coverage tracking."
    - name: "completion_date_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month of training completion for time-series compliance readiness trending."
  measures:
    - name: "total_completions"
      expr: COUNT(1)
      comment: "Total training completions. Baseline volume metric for compliance training program throughput."
    - name: "pass_count"
      expr: COUNT(CASE WHEN pass_fail_result = 'pass' THEN training_completion_id END)
      comment: "Number of training completions with a passing result. Measures workforce compliance readiness."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_result = 'pass' THEN training_completion_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training completions that passed. Primary training effectiveness KPI; low pass rates trigger curriculum review."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across all completions. Measures depth of compliance knowledge acquisition beyond binary pass/fail."
    - name: "total_training_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of compliance training completions. Drives training budget planning and cost-per-compliant-associate calculations."
    - name: "avg_cost_per_completion"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per training completion. Benchmarks training delivery efficiency and informs make-vs-buy decisions."
    - name: "total_training_hours_delivered"
      expr: SUM(CAST(training_duration_hours AS DOUBLE))
      comment: "Total compliance training hours delivered. Measures the scale of the compliance training investment across the workforce."
    - name: "mandatory_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mandatory_flag = TRUE AND pass_fail_result = 'pass' THEN training_completion_id END) / NULLIF(COUNT(CASE WHEN mandatory_flag = TRUE THEN training_completion_id END), 0), 2)
      comment: "Pass rate for mandatory compliance training only. Regulatory compliance readiness KPI — below 100% represents active compliance risk."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`compliance_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Certification portfolio health metrics — tracks certification currency, renewal pipeline, and cost to ensure the organization maintains required regulatory and industry certifications without lapse."
  source: "`vibe_retail_v1`.`compliance`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (food safety, environmental, quality, security) for portfolio segmentation."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status (active, expired, suspended, withdrawn) for currency monitoring."
    - name: "certifying_body"
      expr: certifying_body
      comment: "Organization that issued the certification for body-level portfolio analysis."
    - name: "coverage_level"
      expr: coverage_level
      comment: "Scope of coverage (enterprise, facility, product line) for coverage gap analysis."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework the certification satisfies for framework-level compliance coverage."
    - name: "renewal_workflow_status"
      expr: renewal_workflow_status
      comment: "Status of the renewal process for certifications approaching expiration."
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year of certification expiration for renewal pipeline planning."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total certifications in the portfolio. Baseline for certification coverage analysis."
    - name: "active_certifications_count"
      expr: COUNT(CASE WHEN certification_status = 'active' THEN certification_id END)
      comment: "Number of currently active certifications. Measures the organization's current certified compliance coverage."
    - name: "expired_certifications_count"
      expr: COUNT(CASE WHEN certification_status = 'expired' THEN certification_id END)
      comment: "Number of expired certifications. Each expired certification represents a potential regulatory gap requiring immediate remediation."
    - name: "expiring_within_90_days_count"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN certification_id END)
      comment: "Certifications expiring within 90 days. Drives renewal prioritization to prevent compliance lapses."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of maintaining the certification portfolio. Informs compliance budget planning and cost optimization."
    - name: "avg_certification_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per certification. Benchmarks certification investment and identifies cost outliers."
    - name: "certification_active_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_status = 'active' THEN certification_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications that are currently active. Portfolio health KPI; declining rate signals renewal process failures."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`compliance_environmental_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental compliance event metrics — tracks incident frequency, financial penalties, remediation costs, and regulatory reporting obligations to manage environmental liability and ESG performance."
  source: "`vibe_retail_v1`.`compliance`.`environmental_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of environmental event (spill, emission, waste, contamination) for category-level ESG analysis."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the environmental event (open, contained, remediated, closed) for active liability tracking."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Environmental regulatory framework applicable to the event (EPA, RCRA, CERCLA) for framework-level compliance."
    - name: "material_type"
      expr: material_type
      comment: "Type of material involved (hazardous waste, chemical, petroleum) for substance-level risk analysis."
    - name: "penalty_assessed"
      expr: penalty_assessed
      comment: "Whether a regulatory penalty was assessed — penalized events represent confirmed regulatory violations."
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required
      comment: "Whether regulatory reporting is required — mandatory disclosures with legal consequences if missed."
    - name: "event_date_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month of environmental event for time-series ESG trend analysis."
  measures:
    - name: "total_environmental_events"
      expr: COUNT(1)
      comment: "Total environmental events recorded. Primary ESG volume metric for sustainability and compliance reporting."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total environmental penalties assessed. Direct financial liability metric for CFO and ESG reporting."
    - name: "total_remediation_cost"
      expr: SUM(CAST(remediation_cost AS DOUBLE))
      comment: "Total remediation costs incurred. Quantifies the full financial burden of environmental non-compliance."
    - name: "avg_remediation_cost_per_event"
      expr: AVG(CAST(remediation_cost AS DOUBLE))
      comment: "Average remediation cost per environmental event. Benchmarks environmental incident severity and informs prevention investment ROI."
    - name: "penalized_events_count"
      expr: COUNT(CASE WHEN penalty_assessed = TRUE THEN environmental_event_id END)
      comment: "Number of events that resulted in regulatory penalties. Measures enforcement exposure and regulatory relationship health."
    - name: "regulatory_reporting_required_count"
      expr: COUNT(CASE WHEN regulatory_reporting_required = TRUE THEN environmental_event_id END)
      comment: "Number of events requiring mandatory regulatory reporting. Each represents a legal disclosure obligation."
    - name: "total_spill_volume"
      expr: SUM(CAST(spill_volume AS DOUBLE))
      comment: "Total volume of spills across all events. Environmental impact metric for ESG reporting and regulatory disclosure."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`compliance_pci_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PCI DSS compliance assessment metrics — tracks assessment outcomes, transaction volume in scope, and remediation requirements to manage payment card security compliance and reduce breach risk."
  source: "`vibe_retail_v1`.`compliance`.`pci_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of PCI assessment (QSA, SAQ, internal) for assessment methodology analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall PCI compliance status (compliant, non-compliant, in-remediation) for executive risk reporting."
    - name: "merchant_level"
      expr: merchant_level
      comment: "PCI merchant level (1-4) which determines assessment requirements and regulatory scrutiny."
    - name: "pci_dss_version"
      expr: pci_dss_version
      comment: "PCI DSS version assessed against for version-level compliance tracking."
    - name: "remediation_plan_required_flag"
      expr: remediation_plan_required_flag
      comment: "Whether a remediation plan is required — indicates assessments with identified compliance gaps."
    - name: "assessment_date_year"
      expr: YEAR(assessment_date)
      comment: "Year of assessment for annual compliance cycle tracking."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total PCI assessments conducted. Baseline for assessment program coverage analysis."
    - name: "compliant_assessments_count"
      expr: COUNT(CASE WHEN compliance_status = 'compliant' THEN pci_assessment_id END)
      comment: "Number of assessments achieving full PCI compliance. Primary PCI program success metric."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'compliant' THEN pci_assessment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PCI assessments achieving compliance. Board-level security KPI; non-compliance triggers card brand penalties and breach liability."
    - name: "total_annual_transaction_volume"
      expr: SUM(CAST(annual_transaction_volume AS DOUBLE))
      comment: "Total annual card transaction volume in scope across all assessments. Quantifies the payment data at risk and determines merchant level obligations."
    - name: "avg_annual_transaction_volume"
      expr: AVG(CAST(annual_transaction_volume AS DOUBLE))
      comment: "Average annual transaction volume per assessment scope. Benchmarks cardholder data environment scale."
    - name: "assessments_requiring_remediation_count"
      expr: COUNT(CASE WHEN remediation_plan_required_flag = TRUE THEN pci_assessment_id END)
      comment: "Number of assessments requiring a remediation plan. Each represents active PCI non-compliance with card brand penalty exposure."
    - name: "penetration_test_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN penetration_test_pass_flag = TRUE THEN pci_assessment_id END) / NULLIF(COUNT(CASE WHEN penetration_test_date IS NOT NULL THEN pci_assessment_id END), 0), 2)
      comment: "Percentage of penetration tests that passed. Security effectiveness KPI; failures indicate exploitable vulnerabilities in the cardholder data environment."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`compliance_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enterprise compliance risk portfolio metrics — tracks financial exposure, risk distribution by category and rating, and escalation patterns to enable risk-informed resource allocation and mitigation investment."
  source: "`vibe_retail_v1`.`compliance`.`risk_register`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Category of compliance risk (regulatory, operational, financial, reputational) for portfolio segmentation."
    - name: "risk_register_status"
      expr: risk_register_status
      comment: "Current status of the risk (open, mitigated, accepted, closed) for active risk portfolio management."
    - name: "impact_rating"
      expr: impact_rating
      comment: "Impact rating of the risk (critical, high, medium, low) for severity-tiered executive reporting."
    - name: "likelihood_rating"
      expr: likelihood_rating
      comment: "Likelihood rating of the risk materializing for probability-weighted risk analysis."
    - name: "risk_response_type"
      expr: risk_response_type
      comment: "Risk response strategy (mitigate, accept, transfer, avoid) for strategy effectiveness analysis."
    - name: "escalation_required"
      expr: escalation_required
      comment: "Whether the risk has been escalated to senior management for executive attention tracking."
    - name: "identified_date_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month risk was identified for trend analysis of emerging compliance risk patterns."
  measures:
    - name: "total_risks_count"
      expr: COUNT(1)
      comment: "Total risks in the compliance risk register. Baseline for risk portfolio size and trend analysis."
    - name: "open_risks_count"
      expr: COUNT(CASE WHEN risk_register_status = 'open' THEN risk_register_id END)
      comment: "Number of open, unmitigated risks. Active risk exposure count for executive risk dashboards."
    - name: "total_financial_impact_estimate"
      expr: SUM(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Total estimated financial impact of all risks in the register. Quantifies the aggregate compliance risk exposure for CFO and board reporting."
    - name: "avg_financial_impact_per_risk"
      expr: AVG(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Average estimated financial impact per risk. Benchmarks risk severity and prioritizes mitigation investment."
    - name: "escalated_risks_count"
      expr: COUNT(CASE WHEN escalation_required = TRUE THEN risk_register_id END)
      comment: "Number of risks requiring executive escalation. Tracks the volume of high-severity risks demanding senior management attention."
    - name: "regulatory_reporting_required_count"
      expr: COUNT(CASE WHEN regulatory_reporting_required = TRUE THEN risk_register_id END)
      comment: "Number of risks with mandatory regulatory reporting obligations. Each represents a legal disclosure requirement."
    - name: "open_risk_financial_exposure"
      expr: SUM(CASE WHEN risk_register_status = 'open' THEN financial_impact_estimate ELSE 0 END)
      comment: "Total financial exposure from open, unmitigated risks only. The most actionable risk exposure metric for resource allocation decisions."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`compliance_safety_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workplace safety inspection performance metrics — tracks compliance scores, violation rates, and follow-up requirements to drive safety program effectiveness and reduce OSHA exposure."
  source: "`vibe_retail_v1`.`compliance`.`safety_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of safety inspection (routine, follow-up, regulatory, incident-triggered) for inspection program analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (scheduled, in-progress, completed, closed) for pipeline management."
    - name: "overall_result"
      expr: overall_result
      comment: "Overall inspection result (pass, fail, conditional) for pass-rate trending."
    - name: "inspection_scope"
      expr: inspection_scope
      comment: "Scope of the inspection (full facility, department, equipment) for coverage analysis."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action was required — indicates inspections that identified actionable safety gaps."
    - name: "inspection_date_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of inspection for time-series safety compliance trending."
  measures:
    - name: "total_inspections_count"
      expr: COUNT(1)
      comment: "Total safety inspections conducted. Baseline for inspection program coverage and frequency analysis."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average safety compliance score across all inspections. Primary safety program health KPI; declining scores trigger program intervention."
    - name: "failed_inspections_count"
      expr: COUNT(CASE WHEN overall_result = 'fail' THEN safety_inspection_id END)
      comment: "Number of inspections with a failing result. Each failure represents an active safety risk requiring immediate remediation."
    - name: "inspection_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_result = 'pass' THEN safety_inspection_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections passing. Safety program effectiveness KPI benchmarked against industry standards."
    - name: "inspections_requiring_corrective_action_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN safety_inspection_id END)
      comment: "Number of inspections requiring corrective action. Drives remediation workload planning and safety investment prioritization."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN safety_inspection_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections resulting in corrective action requirements. Rising rate signals deteriorating safety compliance posture."
    - name: "followup_inspection_required_count"
      expr: COUNT(CASE WHEN followup_inspection_required = TRUE THEN safety_inspection_id END)
      comment: "Number of inspections requiring a follow-up visit. Tracks unresolved safety issues that need re-verification."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory filing timeliness and cost metrics — tracks filing status, fee expenditure, and resubmission rates to ensure on-time regulatory compliance and minimize penalty exposure from late or rejected filings."
  source: "`vibe_retail_v1`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_type"
      expr: filing_type
      comment: "Type of regulatory filing (annual report, license renewal, incident report) for category-level compliance tracking."
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the filing (draft, submitted, accepted, rejected) for pipeline management."
    - name: "filing_jurisdiction"
      expr: filing_jurisdiction
      comment: "Jurisdiction of the filing for geographic compliance coverage analysis."
    - name: "submission_method"
      expr: submission_method
      comment: "Method of submission (electronic, paper, portal) for process efficiency analysis."
    - name: "resubmission_required_flag"
      expr: resubmission_required_flag
      comment: "Whether resubmission was required — indicates rejected filings that create compliance gaps."
    - name: "filing_date_month"
      expr: DATE_TRUNC('MONTH', filing_date)
      comment: "Month of filing for time-series regulatory activity trending."
  measures:
    - name: "total_filings_count"
      expr: COUNT(1)
      comment: "Total regulatory filings submitted. Baseline for regulatory compliance activity volume."
    - name: "accepted_filings_count"
      expr: COUNT(CASE WHEN filing_status = 'accepted' THEN regulatory_filing_id END)
      comment: "Number of filings accepted by regulatory authorities. Measures filing quality and regulatory relationship health."
    - name: "filing_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN filing_status = 'accepted' THEN regulatory_filing_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings accepted on first submission. High rejection rates signal process quality issues and create compliance gaps."
    - name: "total_filing_fees"
      expr: SUM(CAST(filing_fee_amount AS DOUBLE))
      comment: "Total regulatory filing fees paid. Compliance cost metric for budget planning and cost optimization."
    - name: "avg_filing_fee"
      expr: AVG(CAST(filing_fee_amount AS DOUBLE))
      comment: "Average filing fee per submission. Benchmarks regulatory cost burden by jurisdiction and filing type."
    - name: "resubmission_required_count"
      expr: COUNT(CASE WHEN resubmission_required_flag = TRUE THEN regulatory_filing_id END)
      comment: "Number of filings requiring resubmission. Each resubmission represents a compliance gap and additional cost."
    - name: "rejected_filings_count"
      expr: COUNT(CASE WHEN filing_status = 'rejected' THEN regulatory_filing_id END)
      comment: "Number of rejected filings. Rejected filings create active compliance gaps and may trigger regulatory penalties."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`compliance_food_safety_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Food safety monitoring and HACCP compliance metrics — tracks critical limit deviations, corrective action rates, and monitoring coverage to ensure food safety program effectiveness and regulatory compliance."
  source: "`vibe_retail_v1`.`compliance`.`food_safety_log`"
  dimensions:
    - name: "control_point_type"
      expr: control_point_type
      comment: "Type of HACCP control point (CCP, prerequisite program) for critical control coverage analysis."
    - name: "limit_status"
      expr: limit_status
      comment: "Whether the measured value was within, at, or outside critical limits — the primary food safety compliance indicator."
    - name: "deviation_severity"
      expr: deviation_severity
      comment: "Severity of any critical limit deviation (critical, major, minor) for risk-tiered food safety reporting."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether a corrective action was required — indicates monitoring events with identified food safety failures."
    - name: "health_department_reportable"
      expr: health_department_reportable
      comment: "Whether the event is reportable to the health department — mandatory disclosures with public health consequences."
    - name: "monitoring_timestamp_date"
      expr: DATE_TRUNC('DAY', monitoring_timestamp)
      comment: "Date of monitoring for daily food safety compliance trending and gap detection."
  measures:
    - name: "total_monitoring_events"
      expr: COUNT(1)
      comment: "Total food safety monitoring events recorded. Measures HACCP monitoring program coverage and frequency."
    - name: "critical_limit_deviations_count"
      expr: COUNT(CASE WHEN limit_status = 'deviation' THEN food_safety_log_id END)
      comment: "Number of critical limit deviations. Each deviation represents a potential food safety failure requiring immediate corrective action."
    - name: "deviation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN limit_status = 'deviation' THEN food_safety_log_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of monitoring events with critical limit deviations. Primary HACCP program health KPI; rising rate triggers food safety program review."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across all monitoring events. Tracks process control trends and early warning of drift toward critical limits."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN food_safety_log_id END)
      comment: "Number of monitoring events requiring corrective action. Measures the frequency of food safety process failures."
    - name: "health_department_reportable_count"
      expr: COUNT(CASE WHEN health_department_reportable = TRUE THEN food_safety_log_id END)
      comment: "Number of events requiring health department reporting. Each represents a mandatory public health disclosure obligation."
    - name: "supervisor_verified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN supervisor_verified = TRUE THEN food_safety_log_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of monitoring events verified by a supervisor. Measures HACCP verification program compliance — low rates indicate control gaps."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`compliance_third_party_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Third-party vendor and partner compliance assessment metrics — tracks assessment scores, findings severity, and remediation status to manage supply chain compliance risk and contractual obligations."
  source: "`vibe_retail_v1`.`compliance`.`third_party_assessment`"
  dimensions:
    - name: "third_party_type"
      expr: third_party_type
      comment: "Type of third party assessed (supplier, service provider, processor, carrier) for category-level risk analysis."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (scheduled, in-progress, completed, closed) for pipeline management."
    - name: "assessment_result"
      expr: assessment_result
      comment: "Overall assessment outcome (pass, fail, conditional) for vendor compliance health tracking."
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Compliance framework assessed (SOC2, ISO27001, FSMA) for framework-level third-party coverage."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the third party (high, medium, low) for risk-tiered vendor management."
    - name: "remediation_required_flag"
      expr: remediation_required_flag
      comment: "Whether remediation is required — indicates assessments with identified compliance gaps in the supply chain."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment for time-series third-party compliance trending."
  measures:
    - name: "total_assessments_count"
      expr: COUNT(1)
      comment: "Total third-party assessments conducted. Baseline for supply chain compliance program coverage."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average compliance score across all third-party assessments. Primary supply chain compliance health KPI."
    - name: "high_risk_third_parties_count"
      expr: COUNT(CASE WHEN risk_rating = 'high' THEN third_party_assessment_id END)
      comment: "Number of third parties rated high risk. High-risk vendors require enhanced monitoring and contractual remediation obligations."
    - name: "assessments_requiring_remediation_count"
      expr: COUNT(CASE WHEN remediation_required_flag = TRUE THEN third_party_assessment_id END)
      comment: "Number of assessments requiring vendor remediation. Each represents an active supply chain compliance gap."
    - name: "remediation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN remediation_required_flag = TRUE THEN third_party_assessment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of third-party assessments requiring remediation. Rising rate signals deteriorating supply chain compliance quality."
    - name: "regulatory_reporting_required_count"
      expr: COUNT(CASE WHEN regulatory_reporting_required_flag = TRUE THEN third_party_assessment_id END)
      comment: "Number of third-party assessments triggering mandatory regulatory reporting. Tracks supply chain compliance disclosure obligations."
    - name: "distinct_third_parties_assessed"
      expr: COUNT(DISTINCT third_party_name)
      comment: "Number of distinct third parties assessed. Measures the breadth of supply chain compliance coverage."
$$;