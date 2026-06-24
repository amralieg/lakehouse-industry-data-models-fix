-- Metric views for domain: compliance | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 08:28:29

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_audit_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks audit program health, coverage, and effectiveness across the compliance audit portfolio. Enables compliance leadership to assess audit maturity, risk exposure, and corrective action velocity."
  source: "`vibe_manufacturing_v1`.`compliance`.`audit_plan`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (internal, external, regulatory, supplier) for segmenting audit portfolio."
    - name: "audit_plan_status"
      expr: audit_plan_status
      comment: "Current lifecycle status of the audit plan (draft, active, closed) for pipeline visibility."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the audit plan, used to prioritize high-risk audit coverage."
    - name: "audit_frequency"
      expr: audit_frequency
      comment: "Frequency at which audits are scheduled (monthly, quarterly, annual) for cadence analysis."
    - name: "audit_methodology"
      expr: audit_methodology
      comment: "Methodology applied in the audit (document review, on-site, remote) for quality benchmarking."
    - name: "scheduled_start_year"
      expr: YEAR(scheduled_start_date)
      comment: "Year the audit is scheduled to start, for annual trend analysis."
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_date)
      comment: "Month the audit is scheduled to start, for monthly pipeline tracking."
  measures:
    - name: "total_audit_plans"
      expr: COUNT(1)
      comment: "Total number of audit plans in the portfolio. Baseline measure for audit program scale."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across all audit plans. A declining score signals systemic compliance degradation requiring executive intervention."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit quality/performance score. Tracks audit execution effectiveness across the program."
    - name: "high_risk_audit_plan_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Number of audit plans classified as high risk. Drives prioritization of audit resources and executive escalation."
    - name: "overdue_corrective_action_plan_count"
      expr: COUNT(CASE WHEN corrective_action_due_date < CURRENT_DATE() AND audit_plan_status != 'Closed' THEN 1 END)
      comment: "Number of audit plans with overdue corrective actions. A leading indicator of compliance program failure risk."
    - name: "active_audit_plan_count"
      expr: COUNT(CASE WHEN audit_plan_status = 'Active' THEN 1 END)
      comment: "Number of currently active audit plans. Measures live audit workload and program throughput."
    - name: "closed_audit_plan_count"
      expr: COUNT(CASE WHEN audit_plan_status = 'Closed' THEN 1 END)
      comment: "Number of closed audit plans. Used to compute audit completion rate against total plans."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_audit_findings`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures the volume, severity, and resolution velocity of compliance audit findings. Critical for tracking regulatory exposure, repeat findings, and corrective action effectiveness."
  source: "`vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Classification of the finding (major non-conformance, minor, observation) for severity-based prioritization."
    - name: "severity"
      expr: severity
      comment: "Severity level of the finding, used to escalate critical compliance gaps to leadership."
    - name: "compliance_audit_finding_status"
      expr: compliance_audit_finding_status
      comment: "Current resolution status of the finding (open, in-progress, closed) for pipeline management."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the finding, used to prioritize remediation investment."
    - name: "impact_area"
      expr: impact_area
      comment: "Business area impacted by the finding (safety, quality, environmental) for cross-functional accountability."
    - name: "is_repeat_finding"
      expr: is_repeat_finding
      comment: "Flag indicating whether this is a repeat finding, a key indicator of systemic compliance failure."
    - name: "discovery_year"
      expr: YEAR(discovery_date)
      comment: "Year the finding was discovered, for annual trend analysis."
    - name: "discovery_month"
      expr: DATE_TRUNC('MONTH', discovery_date)
      comment: "Month the finding was discovered, for monthly trend and seasonality analysis."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings. Baseline measure for compliance exposure volume."
    - name: "open_findings_count"
      expr: COUNT(CASE WHEN compliance_audit_finding_status = 'Open' THEN 1 END)
      comment: "Number of unresolved open findings. A high open count signals unmitigated compliance risk requiring executive action."
    - name: "repeat_finding_count"
      expr: COUNT(CASE WHEN is_repeat_finding = TRUE THEN 1 END)
      comment: "Number of repeat findings. Repeat findings indicate systemic process failures and drive audit program redesign decisions."
    - name: "repeat_finding_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_repeat_finding = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that are repeats. A rising rate is a leading indicator of ineffective corrective actions and systemic non-compliance."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of findings requiring corrective action. Drives CAPA workload planning and resource allocation."
    - name: "overdue_resolution_count"
      expr: COUNT(CASE WHEN target_resolution_date < CURRENT_DATE() AND compliance_audit_finding_status != 'Closed' THEN 1 END)
      comment: "Number of findings past their target resolution date. Overdue findings represent unmitigated regulatory and operational risk."
    - name: "avg_days_to_resolution"
      expr: AVG(DATEDIFF(actual_resolution_date, discovery_date))
      comment: "Average calendar days from finding discovery to resolution. Measures corrective action velocity and compliance program responsiveness."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_capa_effectiveness`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks corrective and preventive action (CAPA) performance for compliance violations. Enables leadership to assess remediation speed, penalty exposure, and systemic risk reduction effectiveness."
  source: "`vibe_manufacturing_v1`.`compliance`.`compliance_capa_record`"
  dimensions:
    - name: "compliance_capa_record_status"
      expr: compliance_capa_record_status
      comment: "Current status of the CAPA record (open, in-progress, closed, verified) for pipeline tracking."
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Regulatory or standards framework driving the CAPA (ISO 14001, OSHA, FDA) for framework-level performance analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the compliance issue driving the CAPA, for prioritization and resource allocation."
    - name: "severity"
      expr: severity
      comment: "Severity of the underlying compliance violation, used to escalate high-severity CAPAs."
    - name: "priority"
      expr: priority
      comment: "Priority assigned to the CAPA for workload management and SLA tracking."
    - name: "is_external_citation"
      expr: is_external_citation
      comment: "Whether the CAPA was triggered by an external regulatory citation, indicating regulatory agency involvement."
    - name: "issuing_agency"
      expr: issuing_agency
      comment: "Regulatory agency that issued the citation, for agency-level compliance performance tracking."
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year the CAPA was created, for annual trend analysis."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the CAPA was created, for monthly workload and trend analysis."
  measures:
    - name: "total_capa_records"
      expr: COUNT(1)
      comment: "Total number of compliance CAPA records. Baseline measure for compliance remediation workload."
    - name: "open_capa_count"
      expr: COUNT(CASE WHEN compliance_capa_record_status = 'Open' THEN 1 END)
      comment: "Number of open CAPAs. High open counts signal unresolved compliance risk and potential regulatory penalty exposure."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalties associated with compliance CAPAs. Direct measure of regulatory financial exposure for CFO and compliance leadership."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per CAPA record. Benchmarks the cost of compliance failures and informs risk investment decisions."
    - name: "avg_effectiveness_score"
      expr: AVG(CAST(effectiveness_score AS DOUBLE))
      comment: "Average effectiveness score of closed CAPAs. Measures whether corrective actions are actually resolving root causes."
    - name: "external_citation_count"
      expr: COUNT(CASE WHEN is_external_citation = TRUE THEN 1 END)
      comment: "Number of CAPAs triggered by external regulatory citations. A rising count signals deteriorating regulatory relationships."
    - name: "overdue_capa_count"
      expr: COUNT(CASE WHEN target_completion_date < CURRENT_DATE() AND compliance_capa_record_status != 'Closed' THEN 1 END)
      comment: "Number of CAPAs past their target completion date. Overdue CAPAs represent unmitigated regulatory risk and potential escalation."
    - name: "closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_capa_record_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CAPAs that have been closed. Key KPI for compliance program effectiveness and regulatory audit readiness."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_safety_incidents`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks workplace safety incident frequency, severity, and regulatory reportability. Enables EHS leadership to monitor OSHA compliance, lost-time injury rates, and safety program effectiveness."
  source: "`vibe_manufacturing_v1`.`compliance`.`safety_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of safety incident (near-miss, first-aid, recordable, lost-time) for severity-based analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the incident, used to prioritize investigation and corrective action resources."
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident investigation (open, under investigation, closed) for pipeline management."
    - name: "injury_type"
      expr: injury_type
      comment: "Type of injury sustained, used to identify patterns and target safety training investments."
    - name: "osha_300_log_classification"
      expr: osha_300_log_classification
      comment: "OSHA 300 log classification for regulatory reporting compliance and benchmarking."
    - name: "reportable_to_osha_flag"
      expr: reportable_to_osha_flag
      comment: "Whether the incident must be reported to OSHA, critical for regulatory compliance tracking."
    - name: "lost_time_flag"
      expr: lost_time_flag
      comment: "Whether the incident resulted in lost work time, a key metric for OSHA DART rate calculations."
    - name: "incident_year"
      expr: YEAR(incident_timestamp)
      comment: "Year of the incident for annual safety performance trending."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_timestamp)
      comment: "Month of the incident for monthly safety performance monitoring."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant or facility code where the incident occurred, for site-level safety benchmarking."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of safety incidents. Baseline measure for overall safety performance and OSHA recordable rate calculations."
    - name: "osha_reportable_incident_count"
      expr: COUNT(CASE WHEN reportable_to_osha_flag = TRUE THEN 1 END)
      comment: "Number of OSHA-reportable incidents. Directly drives regulatory filing obligations and OSHA inspection risk."
    - name: "lost_time_incident_count"
      expr: COUNT(CASE WHEN lost_time_flag = TRUE THEN 1 END)
      comment: "Number of lost-time incidents. Core input to OSHA DART rate and a primary EHS executive KPI."
    - name: "medical_treatment_incident_count"
      expr: COUNT(CASE WHEN medical_treatment_required = TRUE THEN 1 END)
      comment: "Number of incidents requiring medical treatment beyond first aid. Measures severity of safety program gaps."
    - name: "repeat_incident_count"
      expr: COUNT(CASE WHEN is_repeat_incident = TRUE THEN 1 END)
      comment: "Number of repeat incidents. Repeat incidents signal systemic safety failures and drive program redesign decisions."
    - name: "open_investigation_count"
      expr: COUNT(CASE WHEN investigation_status != 'Completed' AND investigation_status IS NOT NULL THEN 1 END)
      comment: "Number of incidents with open investigations. Unresolved investigations delay corrective actions and increase regulatory risk."
    - name: "lost_time_incident_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN lost_time_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents resulting in lost time. A rising rate triggers safety program investment and leadership intervention."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_emissions_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors environmental emissions performance, regulatory exceedances, and reporting compliance. Enables sustainability and EHS leadership to track carbon footprint, regulatory risk, and environmental program effectiveness."
  source: "`vibe_manufacturing_v1`.`compliance`.`emissions_record`"
  dimensions:
    - name: "pollutant_type"
      expr: pollutant_type
      comment: "Type of pollutant measured (CO2, NOx, SOx, particulates) for substance-level environmental performance tracking."
    - name: "source_category"
      expr: source_category
      comment: "Category of emission source (stationary, mobile, fugitive) for source-level analysis and regulatory reporting."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to measure emissions (CEMS, manual sampling, calculation) for data quality assessment."
    - name: "report_status"
      expr: report_status
      comment: "Status of the regulatory emissions report (submitted, pending, overdue) for compliance deadline tracking."
    - name: "exceedance_flag"
      expr: exceedance_flag
      comment: "Whether the measured emission exceeded the regulatory limit. Exceedances trigger immediate regulatory notification obligations."
    - name: "measurement_status"
      expr: measurement_status
      comment: "Quality status of the measurement (valid, invalid, estimated) for data integrity governance."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year for the emissions record, used for annual environmental performance benchmarking."
    - name: "reporting_quarter"
      expr: reporting_quarter
      comment: "Reporting quarter for quarterly emissions trend analysis and regulatory filing cadence."
    - name: "reporting_period_start_month"
      expr: DATE_TRUNC('MONTH', reporting_period_start)
      comment: "Start month of the reporting period for time-series emissions trend analysis."
  measures:
    - name: "total_emissions_records"
      expr: COUNT(1)
      comment: "Total number of emissions measurement records. Baseline measure for monitoring program coverage."
    - name: "total_measured_value"
      expr: SUM(CAST(measured_value AS DOUBLE))
      comment: "Total measured emissions quantity across all records. Primary metric for environmental footprint reporting and regulatory compliance."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average emissions measurement per record. Used to benchmark against regulatory limits and identify trend deviations."
    - name: "total_greenhouse_gas_equivalent"
      expr: SUM(CAST(greenhouse_gas_equivalent AS DOUBLE))
      comment: "Total greenhouse gas equivalent emissions (CO2e). Core sustainability KPI for executive ESG reporting and carbon reduction targets."
    - name: "avg_carbon_intensity"
      expr: AVG(CAST(carbon_intensity AS DOUBLE))
      comment: "Average carbon intensity per emissions record. Tracks efficiency of emissions relative to production output for decarbonization strategy."
    - name: "exceedance_count"
      expr: COUNT(CASE WHEN exceedance_flag = TRUE THEN 1 END)
      comment: "Number of regulatory limit exceedances. Each exceedance triggers mandatory regulatory notification and potential penalty exposure."
    - name: "exceedance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exceedance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurements exceeding regulatory limits. A rising rate signals deteriorating environmental compliance and escalating penalty risk."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score for emissions measurements. Low data quality undermines regulatory reporting credibility and audit defensibility."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_regulatory_obligations`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks the status, risk, and compliance posture of regulatory obligations across the enterprise. Enables compliance leadership to identify overdue obligations, high-risk gaps, and jurisdiction-level exposure."
  source: "`vibe_manufacturing_v1`.`compliance`.`obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory obligation (reporting, permit, training, inspection) for obligation portfolio segmentation."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category (environmental, safety, financial, data privacy) for cross-functional accountability."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the obligation (compliant, non-compliant, at-risk) for executive dashboard reporting."
    - name: "obligation_status"
      expr: obligation_status
      comment: "Lifecycle status of the obligation (active, expired, pending) for portfolio management."
    - name: "risk_severity"
      expr: risk_severity
      comment: "Severity of risk if the obligation is not met, used to prioritize compliance investment."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction governing the obligation (federal, state, EU, local) for geographic compliance risk mapping."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the obligation is legally mandatory, distinguishing regulatory requirements from voluntary commitments."
    - name: "due_year"
      expr: YEAR(due_date)
      comment: "Year the obligation is due, for annual compliance calendar planning."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the obligation is due, for monthly compliance workload forecasting."
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of regulatory obligations. Baseline measure for compliance portfolio scope."
    - name: "non_compliant_obligation_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of obligations currently in non-compliant status. Direct measure of active regulatory risk requiring executive escalation."
    - name: "overdue_obligation_count"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE() AND obligation_status = 'Active' THEN 1 END)
      comment: "Number of active obligations past their due date. Overdue obligations represent immediate regulatory penalty and enforcement risk."
    - name: "mandatory_obligation_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END)
      comment: "Number of legally mandatory obligations. Mandatory obligations carry the highest penalty risk if unmet."
    - name: "avg_risk_rating"
      expr: AVG(CAST(risk_rating AS DOUBLE))
      comment: "Average risk rating across all obligations. Tracks overall regulatory risk posture and informs compliance investment prioritization."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of obligations in compliant status. Primary KPI for compliance program effectiveness reported to board and regulators."
    - name: "at_risk_obligation_count"
      expr: COUNT(CASE WHEN compliance_status = 'At-Risk' THEN 1 END)
      comment: "Number of obligations flagged as at-risk. Leading indicator of future non-compliance requiring proactive intervention."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_cybersecurity_posture`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures cybersecurity risk posture, assessment coverage, and remediation progress across industrial control systems and critical assets. Enables CISO and compliance leadership to track ICS/OT security compliance."
  source: "`vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the cybersecurity assessment (planned, in-progress, completed) for coverage tracking."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Overall risk rating from the assessment (critical, high, medium, low) for risk-based prioritization."
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Cybersecurity framework assessed against (IEC 62443, NIST CSF, ISO 27001) for framework-level compliance tracking."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation actions (not started, in-progress, completed) for remediation pipeline management."
    - name: "is_critical_asset"
      expr: is_critical_asset
      comment: "Whether the assessed asset is classified as critical infrastructure, driving priority remediation investment."
    - name: "is_external_assessment"
      expr: is_external_assessment
      comment: "Whether the assessment was conducted by an external auditor, for independence and credibility tracking."
    - name: "assessed_zone"
      expr: assessed_zone
      comment: "Network or operational zone assessed (OT, IT, DMZ) for zone-level security posture analysis."
    - name: "assessment_year"
      expr: YEAR(last_reviewed_date)
      comment: "Year of the last assessment review, for annual cybersecurity program coverage analysis."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of cybersecurity assessments conducted. Baseline measure for assessment program coverage."
    - name: "avg_overall_risk_score"
      expr: AVG(CAST(overall_risk_score AS DOUBLE))
      comment: "Average cybersecurity risk score across all assessments. Primary CISO KPI for tracking enterprise OT/IT security posture."
    - name: "critical_asset_assessment_count"
      expr: COUNT(CASE WHEN is_critical_asset = TRUE THEN 1 END)
      comment: "Number of assessments covering critical assets. Ensures critical infrastructure receives adequate security scrutiny."
    - name: "high_risk_assessment_count"
      expr: COUNT(CASE WHEN risk_rating = 'High' OR risk_rating = 'Critical' THEN 1 END)
      comment: "Number of assessments with high or critical risk ratings. Drives immediate remediation investment and board-level security reporting."
    - name: "overdue_remediation_count"
      expr: COUNT(CASE WHEN remediation_due_date < CURRENT_DATE() AND remediation_status != 'Completed' THEN 1 END)
      comment: "Number of assessments with overdue remediation actions. Unresolved remediations represent active cybersecurity vulnerabilities."
    - name: "remediation_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN remediation_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments with completed remediation. Measures cybersecurity program execution effectiveness."
    - name: "evidence_attached_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN evidence_attached = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments with supporting evidence attached. Measures audit readiness and documentation compliance."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_permit_management`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks environmental and operational permit status, expiry risk, and compliance posture. Enables EHS and legal leadership to prevent permit lapses that could halt operations or trigger regulatory enforcement."
  source: "`vibe_manufacturing_v1`.`compliance`.`permit`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of permit (air, water, waste, operating) for permit portfolio segmentation and regulatory tracking."
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the permit (active, expired, pending renewal) for compliance posture monitoring."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status against permit conditions (compliant, non-compliant, at-risk) for regulatory risk assessment."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Regulatory authority that issued the permit (EPA, state agency) for agency-level relationship management."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Status of permit renewal process (not started, in-progress, submitted, approved) for renewal pipeline management."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the permit expires, for annual permit renewal planning and budget forecasting."
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the permit expires, for monthly renewal workload planning."
  measures:
    - name: "total_permits"
      expr: COUNT(1)
      comment: "Total number of permits in the portfolio. Baseline measure for permit management scope."
    - name: "active_permit_count"
      expr: COUNT(CASE WHEN permit_status = 'Active' THEN 1 END)
      comment: "Number of currently active permits. Ensures operational continuity and regulatory authorization coverage."
    - name: "expired_permit_count"
      expr: COUNT(CASE WHEN permit_status = 'Expired' OR expiry_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of expired permits. Operating without a valid permit is a critical regulatory violation requiring immediate executive action."
    - name: "expiring_within_90_days_count"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) AND permit_status = 'Active' THEN 1 END)
      comment: "Number of permits expiring within 90 days. Leading indicator for renewal workload and operational continuity risk."
    - name: "non_compliant_permit_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of permits with non-compliant conditions. Non-compliance with permit conditions triggers enforcement actions and potential permit revocation."
    - name: "total_permit_fees"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total permit fee expenditure. Tracks regulatory compliance cost for budget planning and cost optimization."
    - name: "permit_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of permits in compliant status. Primary KPI for permit management program effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_product_certifications`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks product certification status, expiry risk, and compliance coverage across the product portfolio. Enables compliance and product leadership to prevent certification lapses that block market access."
  source: "`vibe_manufacturing_v1`.`compliance`.`compliance_product_certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of product certification (CE, UL, FCC, RoHS) for certification portfolio segmentation."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (active, expired, pending, suspended) for compliance posture monitoring."
    - name: "compliance_region"
      expr: compliance_region
      comment: "Geographic region for which the certification applies (EU, US, APAC) for market access compliance tracking."
    - name: "certifying_body"
      expr: certifying_body
      comment: "Organization that issued the certification (TÜV, UL, BSI) for certifying body performance analysis."
    - name: "compliance_risk_level"
      expr: compliance_risk_level
      comment: "Risk level if certification lapses (critical, high, medium) for prioritizing renewal investments."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the certification is legally mandatory for market access, distinguishing regulatory from voluntary certifications."
    - name: "is_export_controlled"
      expr: is_export_controlled
      comment: "Whether the product is subject to export control regulations, for trade compliance risk management."
    - name: "renewal_required"
      expr: renewal_required
      comment: "Whether the certification requires periodic renewal, for renewal pipeline planning."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the certification expires, for annual renewal planning and budget forecasting."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of product certifications. Baseline measure for certification portfolio scope."
    - name: "active_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN 1 END)
      comment: "Number of currently active certifications. Ensures products maintain market access authorization."
    - name: "expired_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Expired' OR expiry_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of expired certifications. Expired mandatory certifications block product sales and trigger regulatory enforcement."
    - name: "expiring_within_90_days_count"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) AND certification_status = 'Active' THEN 1 END)
      comment: "Number of certifications expiring within 90 days. Leading indicator for renewal workload and market access continuity risk."
    - name: "total_certification_cost"
      expr: SUM(CAST(certification_cost AS DOUBLE))
      comment: "Total cost of product certifications. Tracks regulatory compliance investment for budget planning and cost optimization."
    - name: "avg_certification_cost"
      expr: AVG(CAST(certification_cost AS DOUBLE))
      comment: "Average cost per product certification. Benchmarks certification investment efficiency and informs make-vs-buy decisions."
    - name: "mandatory_certification_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_mandatory = TRUE AND certification_status = 'Active' THEN 1 END) / NULLIF(COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of mandatory certifications that are currently active. Critical KPI for market access compliance — any gap blocks product sales."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_facility_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assesses facility-level compliance risk, environmental footprint, and inspection status. Enables EHS and operations leadership to prioritize facility investments and manage regulatory exposure across the manufacturing network."
  source: "`vibe_manufacturing_v1`.`compliance`.`facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (manufacturing plant, warehouse, R&D center) for facility portfolio segmentation."
    - name: "facility_status"
      expr: facility_status
      comment: "Operational status of the facility (active, inactive, decommissioned) for active portfolio management."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Overall compliance risk rating of the facility, used to prioritize inspection and investment resources."
    - name: "audit_status"
      expr: audit_status
      comment: "Current audit status of the facility (pending, in-progress, completed) for audit coverage tracking."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current inspection status of the facility for regulatory inspection compliance tracking."
    - name: "country_code"
      expr: country_code
      comment: "Country where the facility is located, for geographic compliance risk mapping and jurisdiction analysis."
    - name: "hazardous_material_storage"
      expr: hazardous_material_storage
      comment: "Whether the facility stores hazardous materials, a key risk factor for environmental and safety compliance."
    - name: "compliance_iso_14001_certified"
      expr: compliance_iso_14001_certified
      comment: "Whether the facility holds ISO 14001 environmental management certification."
    - name: "compliance_iso_45001_certified"
      expr: compliance_iso_45001_certified
      comment: "Whether the facility holds ISO 45001 occupational health and safety certification."
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of facilities in the compliance portfolio. Baseline measure for facility management scope."
    - name: "high_risk_facility_count"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN 1 END)
      comment: "Number of facilities with high compliance risk ratings. Drives prioritization of audit, inspection, and remediation resources."
    - name: "total_co2_emissions_tons"
      expr: SUM(CAST(emissions_co2_tons AS DOUBLE))
      comment: "Total CO2 emissions across all facilities in tons. Primary sustainability KPI for ESG reporting and carbon reduction target tracking."
    - name: "avg_co2_emissions_per_facility"
      expr: AVG(CAST(emissions_co2_tons AS DOUBLE))
      comment: "Average CO2 emissions per facility. Benchmarks facility-level environmental performance and identifies high-emitting sites for decarbonization investment."
    - name: "total_energy_consumption_mwh"
      expr: SUM(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Total energy consumption across all facilities in MWh. Core sustainability and operational efficiency KPI for energy reduction programs."
    - name: "total_waste_generated_tons"
      expr: SUM(CAST(waste_generated_tons AS DOUBLE))
      comment: "Total waste generated across all facilities. Tracks waste reduction program effectiveness and regulatory reporting obligations."
    - name: "iso_14001_certified_facility_count"
      expr: COUNT(CASE WHEN compliance_iso_14001_certified = TRUE THEN 1 END)
      comment: "Number of facilities with ISO 14001 certification. Measures environmental management system maturity across the manufacturing network."
    - name: "overdue_inspection_facility_count"
      expr: COUNT(CASE WHEN next_inspection_due < CURRENT_DATE() AND facility_status = 'Active' THEN 1 END)
      comment: "Number of active facilities with overdue inspections. Overdue inspections represent regulatory compliance gaps and potential enforcement risk."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_hazardous_substance_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks hazardous substance inventory, regulatory thresholds, and reporting obligations. Enables EHS leadership to manage chemical compliance, prevent threshold exceedances, and ensure OSHA/EPA reporting accuracy."
  source: "`vibe_manufacturing_v1`.`compliance`.`hazardous_substance`"
  dimensions:
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "GHS or regulatory hazard classification of the substance for risk-based inventory management."
    - name: "hazardous_substance_status"
      expr: hazardous_substance_status
      comment: "Current status of the substance record (active, expired, disposed) for inventory lifecycle management."
    - name: "chemical_family"
      expr: chemical_family
      comment: "Chemical family of the substance for grouped risk analysis and substitution planning."
    - name: "is_controlled_substance"
      expr: is_controlled_substance
      comment: "Whether the substance is a controlled substance requiring special regulatory authorization."
    - name: "is_reportable"
      expr: is_reportable
      comment: "Whether the substance must be reported to regulatory agencies (EPA Tier II, OSHA PSM) when threshold quantities are exceeded."
    - name: "reporting_threshold_exceeded"
      expr: reporting_threshold_exceeded
      comment: "Whether the current quantity on hand exceeds the regulatory reporting threshold, triggering mandatory disclosure."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method used for substance disposal (incineration, landfill, recycling) for waste compliance tracking."
  measures:
    - name: "total_hazardous_substances"
      expr: COUNT(1)
      comment: "Total number of hazardous substances in inventory. Baseline measure for chemical compliance portfolio scope."
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity of hazardous substances on hand. Tracks inventory levels against regulatory threshold quantities for reporting obligations."
    - name: "threshold_exceeded_count"
      expr: COUNT(CASE WHEN reporting_threshold_exceeded = TRUE THEN 1 END)
      comment: "Number of substances exceeding regulatory reporting thresholds. Each exceedance triggers mandatory EPA/OSHA reporting obligations."
    - name: "controlled_substance_count"
      expr: COUNT(CASE WHEN is_controlled_substance = TRUE THEN 1 END)
      comment: "Number of controlled substances in inventory. Controlled substances require special authorization and carry elevated regulatory risk."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across all hazardous substances. Tracks overall chemical risk profile of the facility for EHS investment prioritization."
    - name: "avg_molecular_weight"
      expr: AVG(CAST(molecular_weight AS DOUBLE))
      comment: "Average molecular weight of substances in inventory. Used in chemical risk modeling and exposure limit calculations."
    - name: "substances_near_expiry_count"
      expr: COUNT(CASE WHEN next_review_date <= DATE_ADD(CURRENT_DATE(), 30) THEN 1 END)
      comment: "Number of substances due for review within 30 days. Prevents compliance gaps from outdated safety data sheets and handling procedures."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_waste_management`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks waste generation, disposal compliance, and environmental liability across the manufacturing network. Enables EHS leadership to monitor waste reduction programs, hazardous waste compliance, and disposal contractor performance."
  source: "`vibe_manufacturing_v1`.`compliance`.`waste_record`"
  dimensions:
    - name: "waste_type"
      expr: waste_type
      comment: "Type of waste generated (hazardous, non-hazardous, universal, medical) for waste stream segmentation."
    - name: "waste_category"
      expr: waste_category
      comment: "Category of waste (solid, liquid, gaseous) for regulatory classification and disposal routing."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method used for waste disposal (incineration, landfill, recycling, treatment) for environmental impact analysis."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Whether the waste is classified as hazardous, triggering stricter regulatory requirements and manifest tracking."
    - name: "waste_record_status"
      expr: waste_record_status
      comment: "Current status of the waste record (pending, disposed, verified) for compliance documentation tracking."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the waste disposal (compliant, non-compliant) for regulatory risk assessment."
    - name: "disposal_contractor"
      expr: disposal_contractor
      comment: "Contractor responsible for waste disposal, for contractor performance and compliance monitoring."
    - name: "disposal_year"
      expr: YEAR(disposal_date)
      comment: "Year of waste disposal for annual waste generation trend analysis and regulatory reporting."
    - name: "disposal_month"
      expr: DATE_TRUNC('MONTH', disposal_date)
      comment: "Month of waste disposal for monthly waste management performance tracking."
  measures:
    - name: "total_waste_records"
      expr: COUNT(1)
      comment: "Total number of waste disposal records. Baseline measure for waste management program scope."
    - name: "total_waste_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of waste generated and disposed. Primary metric for waste reduction program tracking and regulatory reporting."
    - name: "hazardous_waste_quantity"
      expr: SUM(CASE WHEN is_hazardous = TRUE THEN quantity ELSE 0 END)
      comment: "Total quantity of hazardous waste disposed. Hazardous waste volumes drive regulatory reporting obligations and disposal cost management."
    - name: "total_transport_emissions_kg_co2"
      expr: SUM(CAST(transport_emission_kg_co2 AS DOUBLE))
      comment: "Total CO2 emissions from waste transport. Tracks Scope 3 emissions from waste logistics for ESG reporting and carbon reduction programs."
    - name: "avg_transport_distance_km"
      expr: AVG(CAST(transport_distance_km AS DOUBLE))
      comment: "Average transport distance for waste disposal. Longer distances increase cost and emissions; drives disposal site optimization decisions."
    - name: "non_compliant_disposal_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of waste disposal records with non-compliant status. Non-compliant disposals represent EPA/regulatory violation risk and potential Superfund liability."
    - name: "hazardous_waste_record_count"
      expr: COUNT(CASE WHEN is_hazardous = TRUE THEN 1 END)
      comment: "Number of hazardous waste disposal records. Tracks hazardous waste management workload and regulatory manifest compliance."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_audit_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key audit event KPIs for compliance monitoring"
  source: "`vibe_manufacturing_v1`.`compliance`.`audit_event`"
  dimensions:
    - name: "audit_event_status"
      expr: audit_event_status
      comment: "Current status of the audit event"
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of assessment performed"
    - name: "department"
      expr: department
      comment: "Department responsible for the audit"
    - name: "location"
      expr: location
      comment: "Physical location of the audit event"
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of the audit event"
  measures:
    - name: "total_audit_events"
      expr: COUNT(1)
      comment: "Total number of audit events recorded"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across audit events"
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required THEN 1 END)
      comment: "Count of audit events where corrective action is required"
    - name: "high_severity_event_count"
      expr: COUNT(CASE WHEN severity_rating = 'High' THEN 1 END)
      comment: "Number of audit events flagged with high severity"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_audit_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic view of audit planning performance"
  source: "`vibe_manufacturing_v1`.`compliance`.`audit_plan`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., internal, external)"
    - name: "audit_plan_status"
      expr: audit_plan_status
      comment: "Current status of the audit plan"
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('month', scheduled_start_date)
      comment: "Month when the audit plan is scheduled to start"
  measures:
    - name: "total_audit_plans"
      expr: COUNT(1)
      comment: "Total number of audit plans created"
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score across all plans"
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across all plans"
    - name: "overdue_plans_count"
      expr: COUNT(CASE WHEN scheduled_end_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of audit plans whose scheduled end date is past due"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core compliance audit finding metrics"
  source: "`vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Classification of the finding"
    - name: "severity"
      expr: severity
      comment: "Severity rating of the finding"
    - name: "audit_finding_status"
      expr: compliance_audit_finding_status
      comment: "Current status of the audit finding"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of compliance audit findings"
    - name: "repeat_findings_count"
      expr: COUNT(CASE WHEN is_repeat_finding THEN 1 END)
      comment: "Count of findings that are repeats of prior findings"
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required THEN 1 END)
      comment: "Number of findings that require corrective action"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_emissions_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental emissions performance metrics"
  source: "`vibe_manufacturing_v1`.`compliance`.`emissions_record`"
  dimensions:
    - name: "facility_name"
      expr: facility_name
      comment: "Name of the facility reporting emissions"
    - name: "pollutant_type"
      expr: pollutant_type
      comment: "Type of pollutant measured"
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year as provided"
    - name: "reporting_month"
      expr: DATE_TRUNC('month', reporting_period_start)
      comment: "Month of the reporting period"
  measures:
    - name: "total_ghg_emissions"
      expr: SUM(CAST(greenhouse_gas_equivalent AS DOUBLE))
      comment: "Total greenhouse gas emissions reported"
    - name: "avg_carbon_intensity"
      expr: AVG(CAST(carbon_intensity AS DOUBLE))
      comment: "Average carbon intensity across records"
    - name: "exceedance_count"
      expr: COUNT(CASE WHEN exceedance_flag THEN 1 END)
      comment: "Number of records where emissions exceeded thresholds"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility-level environmental and operational KPIs"
  source: "`vibe_manufacturing_v1`.`compliance`.`facility`"
  dimensions:
    - name: "country_code"
      expr: country_code
      comment: "Country where the facility is located"
    - name: "state_province"
      expr: state_province
      comment: "State or province of the facility"
    - name: "facility_type"
      expr: facility_type
      comment: "Classification of facility (e.g., plant, warehouse)"
    - name: "compliance_iso_14001_certified"
      expr: compliance_iso_14001_certified
      comment: "ISO 14001 certification status"
  measures:
    - name: "facility_count"
      expr: COUNT(1)
      comment: "Total number of facilities in scope"
    - name: "avg_emissions_co2_tons"
      expr: AVG(CAST(emissions_co2_tons AS DOUBLE))
      comment: "Average CO2 emissions per facility"
    - name: "avg_energy_consumption_mwh"
      expr: AVG(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Average energy consumption per facility"
    - name: "total_waste_generated_tons"
      expr: SUM(CAST(waste_generated_tons AS DOUBLE))
      comment: "Total waste generated across all facilities"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_hazardous_substance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazardous substance risk and inventory metrics"
  source: "`vibe_manufacturing_v1`.`compliance`.`hazardous_substance`"
  dimensions:
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "Regulatory hazard classification"
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flag indicating if the substance is hazardous"
    - name: "storage_location"
      expr: storage_location
      comment: "Physical storage location of the substance"
  measures:
    - name: "total_substances"
      expr: COUNT(1)
      comment: "Total number of hazardous substances tracked"
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Aggregate quantity on hand for all hazardous substances"
    - name: "high_risk_substance_count"
      expr: COUNT(CASE WHEN risk_score > 7.5 THEN 1 END)
      comment: "Count of substances with risk score above 7.5"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety incident occurrence and severity metrics"
  source: "`vibe_manufacturing_v1`.`compliance`.`safety_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Category of safety incident"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the incident"
    - name: "incident_month"
      expr: DATE_TRUNC('month', incident_timestamp)
      comment: "Month when the incident occurred"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total safety incidents recorded"
    - name: "lost_time_incidents"
      expr: COUNT(CASE WHEN lost_time_flag THEN 1 END)
      comment: "Incidents resulting in lost work time"
    - name: "high_severity_incidents"
      expr: COUNT(CASE WHEN severity_level = 'High' THEN 1 END)
      comment: "Incidents classified as high severity"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_safety_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety inspection effectiveness and compliance metrics"
  source: "`vibe_manufacturing_v1`.`compliance`.`safety_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of safety inspection"
    - name: "inspection_status"
      expr: safety_inspection_status
      comment: "Current status of the inspection"
    - name: "inspection_month"
      expr: DATE_TRUNC('month', inspection_timestamp)
      comment: "Month of the inspection"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of safety inspections performed"
    - name: "avg_safety_score"
      expr: AVG(CAST(safety_score AS DOUBLE))
      comment: "Average safety score across inspections"
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required THEN 1 END)
      comment: "Inspections that identified required corrective actions"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_waste_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waste management and environmental impact metrics"
  source: "`vibe_manufacturing_v1`.`compliance`.`waste_record`"
  dimensions:
    - name: "waste_type"
      expr: waste_type
      comment: "Classification of waste (e.g., hazardous, non-hazardous)"
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method used to dispose of the waste"
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flag indicating if the waste is hazardous"
  measures:
    - name: "total_waste_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of waste recorded"
    - name: "total_transport_emission_kg_co2"
      expr: SUM(CAST(transport_emission_kg_co2 AS DOUBLE))
      comment: "Total CO2 emissions from waste transport"
    - name: "hazardous_waste_count"
      expr: COUNT(CASE WHEN is_hazardous THEN 1 END)
      comment: "Count of waste records flagged as hazardous"
$$;