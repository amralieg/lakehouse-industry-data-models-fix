-- Metric views for domain: compliance | Business: Construction | Version: 2 | Generated on: 2026-06-22 15:07:26

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for compliance assessments across projects — tracks compliance health, penalty exposure, and assessment cadence to steer risk mitigation investment."
  source: "`vibe_construction_v1`.`compliance`.`assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of compliance assessment (internal, external, regulatory) for segmenting compliance posture."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance domain category (environmental, safety, financial, etc.) for portfolio-level risk analysis."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current lifecycle status of the assessment (open, in-progress, closed) for pipeline tracking."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk severity level assigned to the assessment — critical input for executive risk dashboards."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction governing the assessment — enables geographic compliance risk segmentation."
    - name: "is_external_audit"
      expr: is_external_audit
      comment: "Flag indicating whether the assessment was conducted by an external auditor."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment for trend analysis of compliance activity over time."
    - name: "compliance_status_overall"
      expr: compliance_status_overall
      comment: "Overall compliance status outcome of the assessment — key executive summary dimension."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of compliance assessments conducted — baseline volume KPI for compliance program activity."
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total monetary penalty exposure identified across all assessments — direct financial risk measure for CFO and legal leadership."
    - name: "avg_penalty_per_assessment"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per assessment — indicates severity trend and whether compliance posture is improving."
    - name: "avg_compliance_rating_score"
      expr: AVG(CAST(rating_score AS DOUBLE))
      comment: "Average compliance rating score across assessments — executive KPI for overall compliance health index."
    - name: "critical_assessment_count"
      expr: SUM(CAST(is_critical AS INT))
      comment: "Count of assessments flagged as critical — triggers executive escalation and resource reallocation decisions."
    - name: "external_audit_count"
      expr: SUM(CAST(is_external_audit AS INT))
      comment: "Number of externally conducted audits — measures regulatory scrutiny intensity and third-party oversight exposure."
    - name: "max_penalty_amount"
      expr: MAX(penalty_amount)
      comment: "Maximum single penalty exposure identified — highlights worst-case financial risk scenario for risk committees."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_audit_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit report quality and findings KPIs — enables leadership to track audit outcomes, remediation urgency, and compliance score trends across the portfolio."
  source: "`vibe_construction_v1`.`compliance`.`audit_report`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of audit report (internal, external, regulatory) for segmenting audit program coverage."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status outcome of the audit report — primary executive summary dimension."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the audit report — drives prioritization of remediation resources."
    - name: "audit_report_status"
      expr: audit_report_status
      comment: "Lifecycle status of the audit report (draft, issued, closed) for pipeline management."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the report — governs distribution and access control decisions."
    - name: "audit_period_start_month"
      expr: DATE_TRUNC('MONTH', audit_period_start)
      comment: "Month the audit period started — enables time-series analysis of audit coverage."
  measures:
    - name: "total_audit_reports"
      expr: COUNT(1)
      comment: "Total number of audit reports issued — baseline measure of audit program throughput."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average audit overall score across all reports — primary compliance health index for executive dashboards."
    - name: "min_overall_score"
      expr: MIN(overall_score)
      comment: "Lowest audit score recorded — identifies the most at-risk compliance area requiring immediate intervention."
    - name: "total_findings_sum"
      expr: COUNT(1)
      comment: "Count of audit reports as proxy for findings volume — used to track audit workload and remediation pipeline size."
    - name: "reports_pending_remediation"
      expr: COUNT(CASE WHEN audit_report_status = 'Open' THEN 1 END)
      comment: "Number of audit reports still open/pending remediation — operational KPI for compliance closure rate management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_authority_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory authority notice KPIs — tracks penalty exposure, response compliance, and violation severity to manage regulatory relationship risk."
  source: "`vibe_construction_v1`.`compliance`.`authority_notice`"
  dimensions:
    - name: "notice_type"
      expr: notice_type
      comment: "Type of authority notice (infringement, stop-work, improvement) — classifies regulatory enforcement action."
    - name: "authority_notice_status"
      expr: authority_notice_status
      comment: "Current status of the notice (open, responded, resolved) — tracks regulatory response pipeline."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the regulatory notice — drives escalation and resource prioritization decisions."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance domain category of the violation — identifies systemic compliance weaknesses."
    - name: "authority_type"
      expr: authority_type
      comment: "Type of issuing authority (environmental, safety, financial) — segments regulatory exposure by domain."
    - name: "notice_month"
      expr: DATE_TRUNC('MONTH', CAST(notice_date AS DATE))
      comment: "Month the notice was issued — enables trend analysis of regulatory enforcement activity."
    - name: "appeal_lodged_flag"
      expr: appeal_lodged_flag
      comment: "Whether an appeal was lodged against the notice — tracks legal challenge rate."
    - name: "response_submitted_flag"
      expr: response_submitted_flag
      comment: "Whether a formal response was submitted — measures regulatory responsiveness compliance."
  measures:
    - name: "total_authority_notices"
      expr: COUNT(1)
      comment: "Total number of authority notices received — baseline KPI for regulatory enforcement exposure volume."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalty exposure from authority notices — direct P&L risk measure for CFO and legal leadership."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty per notice — indicates severity trend and effectiveness of compliance controls."
    - name: "notices_with_appeal"
      expr: SUM(CAST(appeal_lodged_flag AS INT))
      comment: "Count of notices where an appeal was lodged — measures legal challenge rate and regulatory dispute exposure."
    - name: "notices_responded"
      expr: SUM(CAST(response_submitted_flag AS INT))
      comment: "Count of notices with a formal response submitted — measures regulatory responsiveness and compliance with response obligations."
    - name: "max_penalty_amount"
      expr: MAX(penalty_amount)
      comment: "Maximum single penalty amount — highlights worst-case regulatory financial exposure for risk committees."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance action execution KPIs — tracks cost of remediation, action closure rates, and repeat-action patterns to drive continuous compliance improvement."
  source: "`vibe_construction_v1`.`compliance`.`compliance_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of compliance action (corrective, preventive, monitoring) — classifies remediation strategy."
    - name: "compliance_action_status"
      expr: compliance_action_status
      comment: "Current lifecycle status of the action — tracks remediation pipeline health."
    - name: "compliance_area"
      expr: compliance_area
      comment: "Compliance domain area (environmental, safety, financial) — identifies where remediation effort is concentrated."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the compliance action — prioritizes resource allocation for high-risk remediation."
    - name: "priority"
      expr: priority
      comment: "Action priority (critical, high, medium, low) — drives scheduling and resource assignment decisions."
    - name: "is_external"
      expr: is_external
      comment: "Whether the action involves an external authority or party — distinguishes internal vs. regulatory-driven remediation."
    - name: "is_repeat_action"
      expr: is_repeat_action
      comment: "Whether this is a repeat compliance action — key indicator of systemic compliance failure."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the action is due — enables forward-looking compliance workload planning."
  measures:
    - name: "total_compliance_actions"
      expr: COUNT(1)
      comment: "Total number of compliance actions — baseline measure of remediation workload and compliance program activity."
    - name: "total_actual_cost"
      expr: SUM(CAST(cost_actual AS DOUBLE))
      comment: "Total actual cost incurred for compliance remediation — direct cost-of-compliance measure for CFO reporting."
    - name: "total_estimated_cost"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of compliance actions — forward-looking budget exposure for compliance program planning."
    - name: "avg_actual_cost_per_action"
      expr: AVG(CAST(cost_actual AS DOUBLE))
      comment: "Average actual cost per compliance action — benchmarks remediation efficiency and cost-per-finding trends."
    - name: "repeat_action_count"
      expr: SUM(CAST(is_repeat_action AS INT))
      comment: "Count of repeat compliance actions — critical KPI indicating systemic control failures requiring root-cause investment."
    - name: "external_action_count"
      expr: SUM(CAST(is_external AS INT))
      comment: "Count of externally driven compliance actions — measures regulatory enforcement pressure on the organization."
    - name: "monitoring_required_count"
      expr: SUM(CAST(monitoring_required AS INT))
      comment: "Count of actions requiring ongoing monitoring — drives compliance monitoring resource planning."
    - name: "cost_variance_total"
      expr: SUM(CAST(cost_actual AS DOUBLE) - CAST(cost_estimate AS DOUBLE))
      comment: "Total cost variance (actual minus estimate) across all compliance actions — measures budget accuracy and cost overrun risk in compliance remediation."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Permit portfolio KPIs — tracks permit status, fee exposure, and renewal risk to ensure uninterrupted project operations and regulatory compliance."
  source: "`vibe_construction_v1`.`compliance`.`compliance_permit`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of permit (environmental, building, operating) — classifies regulatory authorization portfolio."
    - name: "permit_category"
      expr: permit_category
      comment: "Category of the permit — enables segmentation of permit portfolio by regulatory domain."
    - name: "compliance_permit_status"
      expr: compliance_permit_status
      comment: "Current lifecycle status of the permit (active, expired, suspended) — critical for operational continuity monitoring."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the permit conditions — indicates whether permit obligations are being met."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the permit — prioritizes permit management attention."
    - name: "is_active"
      expr: is_active
      comment: "Whether the permit is currently active — primary filter for operational permit portfolio."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Whether the permit requires renewal — drives proactive renewal pipeline management."
    - name: "suspension_flag"
      expr: suspension_flag
      comment: "Whether the permit is currently suspended — critical operational risk indicator."
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the permit expires — enables forward-looking renewal risk planning."
  measures:
    - name: "total_permits"
      expr: COUNT(1)
      comment: "Total number of permits in the portfolio — baseline measure of regulatory authorization scope."
    - name: "active_permit_count"
      expr: SUM(CAST(is_active AS INT))
      comment: "Count of currently active permits — measures operational authorization coverage."
    - name: "suspended_permit_count"
      expr: SUM(CAST(suspension_flag AS INT))
      comment: "Count of suspended permits — critical operational risk KPI; suspended permits can halt project work."
    - name: "permits_requiring_renewal"
      expr: SUM(CAST(renewal_required_flag AS INT))
      comment: "Count of permits requiring renewal — drives proactive compliance calendar management to avoid lapses."
    - name: "distinct_permit_types"
      expr: COUNT(DISTINCT permit_type)
      comment: "Number of distinct permit types held — measures breadth of regulatory authorization portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance finding KPIs — tracks finding severity, financial impact, and resolution rates to drive risk-based remediation prioritization."
  source: "`vibe_construction_v1`.`compliance`.`finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Type of compliance finding (non-conformance, observation, major) — classifies severity and response requirements."
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the finding (open, in-progress, closed) — tracks remediation pipeline."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the finding — primary dimension for executive risk prioritization."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status associated with the finding — indicates whether the underlying obligation is met."
    - name: "is_financial_related"
      expr: is_financial_related
      comment: "Whether the finding has financial implications — segments findings with direct P&L impact."
    - name: "is_privacy_related"
      expr: is_privacy_related
      comment: "Whether the finding relates to privacy/data protection — critical for GDPR and data governance reporting."
    - name: "reported_month"
      expr: DATE_TRUNC('MONTH', reported_date)
      comment: "Month the finding was reported — enables trend analysis of compliance finding rates."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of compliance findings — baseline KPI for compliance program health and audit effectiveness."
    - name: "total_financial_impact"
      expr: SUM(CAST(impact_amount AS DOUBLE))
      comment: "Total financial impact of compliance findings — direct measure of compliance failure cost for CFO and board reporting."
    - name: "avg_severity_score"
      expr: AVG(CAST(severity_score AS DOUBLE))
      comment: "Average severity score across findings — tracks whether compliance posture is improving or deteriorating over time."
    - name: "max_severity_score"
      expr: MAX(severity_score)
      comment: "Maximum severity score recorded — identifies the most critical compliance finding requiring immediate executive attention."
    - name: "open_findings_count"
      expr: COUNT(CASE WHEN finding_status = 'Open' THEN 1 END)
      comment: "Count of open (unresolved) findings — operational KPI for compliance closure rate and remediation backlog."
    - name: "financial_related_findings_count"
      expr: SUM(CAST(is_financial_related AS INT))
      comment: "Count of findings with direct financial implications — measures financial compliance risk exposure."
    - name: "privacy_related_findings_count"
      expr: SUM(CAST(is_privacy_related AS INT))
      comment: "Count of privacy-related findings — critical KPI for GDPR/data protection compliance program management."
    - name: "avg_financial_impact"
      expr: AVG(CAST(impact_amount AS DOUBLE))
      comment: "Average financial impact per finding — benchmarks cost-per-finding and informs compliance investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_iso_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ISO audit performance KPIs — tracks audit scores, non-conformance rates, and corrective action requirements to manage ISO certification health."
  source: "`vibe_construction_v1`.`compliance`.`iso_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of ISO audit (surveillance, recertification, internal) — classifies audit scope and regulatory significance."
    - name: "standard_audited"
      expr: standard_audited
      comment: "ISO standard being audited (ISO 9001, ISO 14001, ISO 45001) — segments performance by certification standard."
    - name: "audit_outcome"
      expr: audit_outcome
      comment: "Outcome of the ISO audit (pass, conditional pass, fail) — primary executive KPI for certification status."
    - name: "iso_audit_status"
      expr: iso_audit_status
      comment: "Current lifecycle status of the audit — tracks audit pipeline and follow-up requirements."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the audit — drives prioritization of corrective action resources."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether corrective action is required following the audit — key trigger for remediation planning."
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', audit_date)
      comment: "Month the audit was conducted — enables trend analysis of ISO audit program activity."
  measures:
    - name: "total_iso_audits"
      expr: COUNT(1)
      comment: "Total number of ISO audits conducted — baseline measure of ISO compliance program activity."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average ISO audit score — primary KPI for ISO compliance health trend analysis at executive level."
    - name: "min_audit_score"
      expr: MIN(audit_score)
      comment: "Minimum ISO audit score recorded — identifies the weakest compliance area requiring targeted investment."
    - name: "total_audit_duration_hours"
      expr: SUM(CAST(audit_duration_hours AS DOUBLE))
      comment: "Total hours invested in ISO audits — measures compliance program resource consumption."
    - name: "avg_audit_duration_hours"
      expr: AVG(CAST(audit_duration_hours AS DOUBLE))
      comment: "Average audit duration in hours — benchmarks audit efficiency and resource planning for future audits."
    - name: "audits_requiring_corrective_action"
      expr: SUM(CAST(corrective_action_required_flag AS INT))
      comment: "Count of audits requiring corrective action — measures ISO non-conformance rate and remediation workload."
    - name: "follow_up_audits_scheduled"
      expr: SUM(CAST(follow_up_audit_scheduled_flag AS INT))
      comment: "Count of audits with follow-up audits scheduled — indicates unresolved compliance issues requiring re-verification."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_leed_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "LEED certification portfolio KPIs — tracks green building certification progress, points achievement, and certification level attainment to support ESG and sustainability reporting."
  source: "`vibe_construction_v1`.`compliance`.`leed_certification`"
  dimensions:
    - name: "certification_level_target"
      expr: certification_level_target
      comment: "Target LEED certification level (Certified, Silver, Gold, Platinum) — measures ambition of sustainability program."
    - name: "certification_level_awarded"
      expr: certification_level_awarded
      comment: "Actual LEED certification level awarded — primary outcome KPI for ESG and sustainability reporting."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of LEED certification (BD+C, O+M, ID+C) — segments certification portfolio by building type."
    - name: "leed_certification_status"
      expr: leed_certification_status
      comment: "Current status of the LEED certification (registered, submitted, awarded) — tracks certification pipeline."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the LEED certification — indicates whether certification obligations are being met."
    - name: "project_phase"
      expr: project_phase
      comment: "Project phase during which LEED certification is being pursued — aligns sustainability milestones with project lifecycle."
    - name: "award_year"
      expr: DATE_TRUNC('YEAR', award_date)
      comment: "Year the LEED certification was awarded — enables annual ESG performance trend analysis."
  measures:
    - name: "total_leed_certifications"
      expr: COUNT(1)
      comment: "Total number of LEED certifications in the portfolio — baseline measure of green building program scope."
    - name: "total_points_awarded_sum"
      expr: SUM(CAST(total_points_awarded AS DOUBLE))
      comment: "Total LEED points awarded across all certifications — aggregate measure of sustainability achievement for ESG reporting."
    - name: "total_points_targeted_sum"
      expr: SUM(CAST(total_points_targeted AS DOUBLE))
      comment: "Total LEED points targeted across all certifications — measures ambition of sustainability program."
    - name: "total_points_available_sum"
      expr: SUM(CAST(total_points_available AS DOUBLE))
      comment: "Total LEED points available across all certifications — denominator for portfolio-level achievement rate."
    - name: "avg_points_awarded"
      expr: AVG(CAST(total_points_awarded AS DOUBLE))
      comment: "Average LEED points awarded per certification — benchmarks sustainability performance across projects."
    - name: "avg_points_achievement_rate"
      expr: AVG(ROUND(100.0 * total_points_awarded / NULLIF(total_points_available, 0), 2))
      comment: "Average LEED points achievement rate (awarded/available) — primary sustainability performance ratio for ESG dashboards."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_leed_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "LEED credit achievement KPIs — tracks credit category performance, points yield, and eligibility conversion to optimize green building certification strategy."
  source: "`vibe_construction_v1`.`compliance`.`leed_credit`"
  dimensions:
    - name: "credit_category"
      expr: credit_category
      comment: "LEED credit category (Energy, Water, Materials, etc.) — identifies which sustainability domains are performing best."
    - name: "leed_credit_status"
      expr: leed_credit_status
      comment: "Current status of the credit (submitted, awarded, denied) — tracks credit pipeline and award rate."
    - name: "review_status"
      expr: review_status
      comment: "Review status of the credit submission — tracks reviewer pipeline and approval bottlenecks."
    - name: "is_eligible"
      expr: is_eligible
      comment: "Whether the credit is eligible for the project — segments achievable vs. ineligible credits."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit credit evidence — identifies process efficiency opportunities."
  measures:
    - name: "total_credits"
      expr: COUNT(1)
      comment: "Total number of LEED credits tracked — baseline measure of green certification effort scope."
    - name: "total_points_awarded"
      expr: SUM(CAST(points_awarded AS DOUBLE))
      comment: "Total LEED points awarded across all credits — primary sustainability achievement measure for ESG reporting."
    - name: "total_points_targeted"
      expr: SUM(CAST(points_targeted AS DOUBLE))
      comment: "Total LEED points targeted — measures sustainability ambition and gap to certification level thresholds."
    - name: "total_points_available"
      expr: SUM(CAST(points_available AS DOUBLE))
      comment: "Total LEED points available — denominator for credit achievement rate calculation."
    - name: "avg_points_awarded_per_credit"
      expr: AVG(CAST(points_awarded AS DOUBLE))
      comment: "Average points awarded per credit — benchmarks credit yield efficiency across categories."
    - name: "eligible_credit_count"
      expr: SUM(CAST(is_eligible AS INT))
      comment: "Count of eligible credits — measures the achievable certification point pool for strategic planning."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_env_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental monitoring KPIs — tracks exceedance rates, measurement compliance, and corrective action status to manage environmental regulatory risk."
  source: "`vibe_construction_v1`.`compliance`.`env_monitoring`"
  dimensions:
    - name: "monitoring_type"
      expr: monitoring_type
      comment: "Type of environmental monitoring (air, water, noise, soil) — segments environmental compliance by medium."
    - name: "parameter"
      expr: parameter
      comment: "Environmental parameter being measured (PM2.5, NOx, pH, etc.) — enables parameter-level compliance analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the monitoring reading — primary regulatory compliance indicator."
    - name: "exceedance_flag"
      expr: exceedance_flag
      comment: "Whether the measured value exceeded the regulatory threshold — critical trigger for regulatory notification."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action taken for exceedances — tracks remediation response effectiveness."
    - name: "env_monitoring_status"
      expr: env_monitoring_status
      comment: "Lifecycle status of the monitoring record — tracks data completeness and review pipeline."
    - name: "monitoring_month"
      expr: DATE_TRUNC('MONTH', CAST(monitoring_timestamp AS DATE))
      comment: "Month of monitoring — enables trend analysis of environmental compliance over time."
  measures:
    - name: "total_monitoring_readings"
      expr: COUNT(1)
      comment: "Total number of environmental monitoring readings — baseline measure of monitoring program coverage."
    - name: "exceedance_count"
      expr: SUM(CAST(exceedance_flag AS INT))
      comment: "Count of readings that exceeded regulatory thresholds — primary environmental compliance risk KPI for regulatory reporting."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured environmental parameter value — tracks environmental condition trends against regulatory limits."
    - name: "max_measured_value"
      expr: MAX(measured_value)
      comment: "Maximum measured value recorded — identifies peak environmental impact events for regulatory disclosure."
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average regulatory threshold value — provides context for interpreting measured value trends."
    - name: "data_quality_issue_count"
      expr: SUM(CAST(data_quality_flag AS INT))
      comment: "Count of readings with data quality issues — measures monitoring data reliability for regulatory submissions."
    - name: "distinct_monitoring_locations"
      expr: COUNT(DISTINCT location_description)
      comment: "Number of distinct monitoring locations — measures spatial coverage of environmental monitoring program."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_regulatory_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory obligation portfolio KPIs — tracks obligation compliance status, penalty exposure, and review cadence to ensure all regulatory requirements are met."
  source: "`vibe_construction_v1`.`compliance`.`regulatory_obligation`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the obligation — primary executive KPI for regulatory obligation health."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the obligation — drives prioritization of compliance resources."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the obligation — enables geographic compliance risk segmentation."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body enforcing the obligation — identifies key regulatory relationships."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the obligation is mandatory — distinguishes legally required vs. voluntary compliance commitments."
    - name: "is_active"
      expr: is_active
      comment: "Whether the obligation is currently active — filters active compliance portfolio."
    - name: "data_classification"
      expr: data_classification
      comment: "Data classification of the obligation — supports data governance and privacy compliance reporting."
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of regulatory obligations — baseline measure of compliance obligation portfolio size."
    - name: "active_obligation_count"
      expr: SUM(CAST(is_active AS INT))
      comment: "Count of currently active regulatory obligations — measures active compliance burden on the organization."
    - name: "mandatory_obligation_count"
      expr: SUM(CAST(is_mandatory AS INT))
      comment: "Count of mandatory regulatory obligations — measures legally required compliance scope."
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total potential penalty exposure across all obligations — direct financial risk measure for CFO and legal leadership."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per obligation — benchmarks financial risk per regulatory requirement."
    - name: "distinct_regulatory_bodies"
      expr: COUNT(DISTINCT regulatory_body)
      comment: "Number of distinct regulatory bodies with obligations — measures breadth of regulatory relationship portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory submission KPIs — tracks submission volumes, fee expenditure, and acknowledgement rates to manage regulatory reporting obligations and costs."
  source: "`vibe_construction_v1`.`compliance`.`regulatory_submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission (annual report, incident notification, permit application) — classifies submission portfolio."
    - name: "regulatory_submission_status"
      expr: regulatory_submission_status
      comment: "Current status of the submission (submitted, acknowledged, rejected) — tracks regulatory response pipeline."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance domain category of the submission — segments regulatory reporting by domain."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit (online portal, paper, email) — identifies process efficiency opportunities."
    - name: "acknowledgement_received"
      expr: acknowledgement_received
      comment: "Whether acknowledgement was received from the authority — measures submission completion rate."
    - name: "is_confidential"
      expr: is_confidential
      comment: "Whether the submission is confidential — governs access control and distribution decisions."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', CAST(submission_date AS DATE))
      comment: "Month of submission — enables trend analysis of regulatory reporting activity."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of regulatory submissions — baseline measure of regulatory reporting program activity."
    - name: "total_submission_fees"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fees paid for regulatory submissions — measures direct cost of regulatory compliance reporting."
    - name: "avg_submission_fee"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average fee per regulatory submission — benchmarks submission cost efficiency."
    - name: "acknowledged_submission_count"
      expr: SUM(CAST(acknowledgement_received AS INT))
      comment: "Count of submissions with acknowledgement received — measures regulatory submission completion rate."
    - name: "distinct_submission_types"
      expr: COUNT(DISTINCT submission_type)
      comment: "Number of distinct submission types — measures breadth of regulatory reporting obligations being fulfilled."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_privacy_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Privacy incident KPIs — tracks breach severity, financial exposure, notification compliance, and remediation status to manage GDPR and data protection risk."
  source: "`vibe_construction_v1`.`compliance`.`privacy_incident`"
  dimensions:
    - name: "breach_type"
      expr: breach_type
      comment: "Type of privacy breach (unauthorized access, data loss, disclosure) — classifies incident for regulatory reporting."
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity of the privacy breach — primary dimension for executive risk prioritization and regulatory notification decisions."
    - name: "privacy_incident_status"
      expr: privacy_incident_status
      comment: "Current status of the privacy incident (open, investigating, closed) — tracks incident response pipeline."
    - name: "data_category"
      expr: data_category
      comment: "Category of personal data involved (health, financial, identity) — determines regulatory notification obligations."
    - name: "notification_obligation_triggered"
      expr: notification_obligation_triggered
      comment: "Whether regulatory notification obligation was triggered — critical GDPR compliance indicator."
    - name: "regulatory_report_submitted"
      expr: regulatory_report_submitted
      comment: "Whether the regulatory report was submitted — measures GDPR notification compliance rate."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Whether a legal hold is in place — indicates incidents with active litigation or regulatory investigation."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', CAST(incident_timestamp AS DATE))
      comment: "Month the incident occurred — enables trend analysis of privacy incident frequency."
  measures:
    - name: "total_privacy_incidents"
      expr: COUNT(1)
      comment: "Total number of privacy incidents — baseline KPI for data protection program health and breach frequency."
    - name: "total_estimated_fines"
      expr: SUM(CAST(estimated_fine_amount AS DOUBLE))
      comment: "Total estimated regulatory fine exposure from privacy incidents — direct financial risk measure for CFO and DPO reporting."
    - name: "avg_estimated_fine"
      expr: AVG(CAST(estimated_fine_amount AS DOUBLE))
      comment: "Average estimated fine per privacy incident — benchmarks financial severity of data protection failures."
    - name: "total_data_volume_records"
      expr: SUM(CAST(data_volume_records AS DOUBLE))
      comment: "Total number of data subject records affected by privacy incidents — measures scale of data protection failures."
    - name: "notification_obligation_triggered_count"
      expr: SUM(CAST(notification_obligation_triggered AS INT))
      comment: "Count of incidents triggering regulatory notification obligations — measures GDPR Article 33 notification exposure."
    - name: "regulatory_reports_submitted_count"
      expr: SUM(CAST(regulatory_report_submitted AS INT))
      comment: "Count of incidents where regulatory report was submitted — measures GDPR notification compliance rate."
    - name: "legal_hold_incident_count"
      expr: SUM(CAST(legal_hold_flag AS INT))
      comment: "Count of incidents under legal hold — measures active litigation and regulatory investigation exposure."
    - name: "max_estimated_fine"
      expr: MAX(estimated_fine_amount)
      comment: "Maximum estimated fine from a single privacy incident — highlights worst-case GDPR financial exposure for board reporting."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_waiver_exemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waiver and exemption portfolio KPIs — tracks financial impact of regulatory relief, renewal risk, and monitoring compliance to manage exemption portfolio health."
  source: "`vibe_construction_v1`.`compliance`.`waiver_exemption`"
  dimensions:
    - name: "waiver_type"
      expr: waiver_type
      comment: "Type of waiver or exemption (temporary, permanent, conditional) — classifies regulatory relief portfolio."
    - name: "waiver_category"
      expr: waiver_category
      comment: "Category of the waiver (environmental, safety, financial) — segments exemption portfolio by domain."
    - name: "waiver_exemption_status"
      expr: waiver_exemption_status
      comment: "Current status of the waiver/exemption (active, expired, pending) — tracks exemption portfolio health."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the waiver — identifies high-risk exemptions requiring enhanced monitoring."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Whether the waiver requires renewal — drives proactive renewal management to avoid compliance gaps."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the waiver — enables geographic compliance risk segmentation."
    - name: "effective_from_year"
      expr: DATE_TRUNC('YEAR', effective_from)
      comment: "Year the waiver became effective — enables portfolio vintage analysis."
  measures:
    - name: "total_waivers"
      expr: COUNT(1)
      comment: "Total number of waivers and exemptions — baseline measure of regulatory relief portfolio size."
    - name: "total_financial_impact_estimate"
      expr: SUM(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Total estimated financial impact of waivers and exemptions — measures value of regulatory relief obtained."
    - name: "avg_financial_impact_estimate"
      expr: AVG(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Average financial impact per waiver — benchmarks value of individual regulatory relief instruments."
    - name: "waivers_requiring_renewal"
      expr: SUM(CAST(renewal_required_flag AS INT))
      comment: "Count of waivers requiring renewal — drives proactive compliance calendar management to avoid exemption lapses."
    - name: "distinct_jurisdictions"
      expr: COUNT(DISTINCT jurisdiction)
      comment: "Number of distinct jurisdictions with active waivers — measures geographic breadth of regulatory relief portfolio."
$$;