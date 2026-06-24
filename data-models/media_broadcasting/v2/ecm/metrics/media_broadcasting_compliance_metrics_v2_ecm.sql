-- Metric views for domain: compliance | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-22 23:42:33

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_broadcast_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for broadcast license portfolio management — tracks license health, renewal pipeline, fee exposure, and transmitter power compliance across the station group."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`broadcast_license`"
  dimensions:
    - name: "license_class"
      expr: license_class
      comment: "FCC license class (e.g., Class A, Full Power, LPTV) for segmenting license portfolio by tier."
    - name: "frequency_band"
      expr: frequency_band
      comment: "Broadcast frequency band (AM/FM/TV/DTV) for spectrum-level analysis."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Issuing regulatory body (FCC, Ofcom, CRTC) for multi-jurisdiction portfolio views."
    - name: "community_of_license"
      expr: community_of_license
      comment: "Community of license for geographic distribution of the station portfolio."
    - name: "expiration_year"
      expr: DATE_TRUNC('year', expiration_date)
      comment: "License expiration year for renewal pipeline planning."
    - name: "closed_captioning_required"
      expr: closed_captioning_required
      comment: "Whether closed captioning is mandated on this license — used to track accessibility obligation coverage."
    - name: "eas_participation_required"
      expr: eas_participation_required
      comment: "Whether EAS participation is required — used to identify stations with emergency alert obligations."
  measures:
    - name: "total_active_licenses"
      expr: COUNT(1)
      comment: "Total number of broadcast licenses in the portfolio. Executives use this to understand the scale of the licensed station footprint."
    - name: "total_annual_fee_amount"
      expr: SUM(CAST(annual_fee_amount AS DOUBLE))
      comment: "Total annual regulatory fee obligation across all licenses. Directly informs regulatory cost budgeting and cash-flow planning."
    - name: "avg_annual_fee_per_license"
      expr: AVG(CAST(annual_fee_amount AS DOUBLE))
      comment: "Average annual fee per license. Benchmarks fee burden per station and flags outliers requiring renegotiation or appeal."
    - name: "avg_power_output_erp_watts"
      expr: AVG(CAST(power_output_erp_watts AS DOUBLE))
      comment: "Average effective radiated power across the license portfolio. Used by engineering and compliance teams to monitor transmitter compliance with licensed power limits."
    - name: "max_power_output_erp_watts"
      expr: MAX(power_output_erp_watts)
      comment: "Maximum ERP wattage in the portfolio. Identifies the highest-power stations requiring the most rigorous technical compliance oversight."
    - name: "licenses_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiration_date <= DATE_ADD(CURRENT_DATE(), 90) AND expiration_date >= CURRENT_DATE() THEN 1 END)
      comment: "Count of licenses expiring within 90 days. A critical renewal pipeline KPI — if this rises without corresponding renewal filings, the organization risks operating without a valid license."
    - name: "licenses_with_eas_obligation"
      expr: COUNT(CASE WHEN eas_participation_required = TRUE THEN 1 END)
      comment: "Number of licenses with mandatory EAS participation. Used to scope EAS compliance monitoring and testing programs."
    - name: "licenses_with_cc_obligation"
      expr: COUNT(CASE WHEN closed_captioning_required = TRUE THEN 1 END)
      comment: "Number of licenses with closed captioning mandates. Drives accessibility compliance program resourcing."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for regulatory filing operations — tracks filing volumes, fee spend, on-time submission rates, and amendment activity across all regulatory bodies and filing types."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body receiving the filing (FCC, Ofcom, CRTC, SEC) for body-level compliance tracking."
    - name: "market_designation"
      expr: market_designation
      comment: "Market designation (DMA/Nielsen market) for geographic filing analysis."
    - name: "filing_year"
      expr: DATE_TRUNC('year', filing_date)
      comment: "Year of filing for trend analysis of regulatory filing activity."
    - name: "filing_month"
      expr: DATE_TRUNC('month', filing_date)
      comment: "Month of filing for operational cadence monitoring."
    - name: "amendment_flag"
      expr: amendment_flag
      comment: "Whether the filing is an amendment — used to measure rework rates and first-time-right quality."
    - name: "gdpr_applicable"
      expr: gdpr_applicable
      comment: "Whether GDPR applies to this filing — segments privacy-related regulatory activity."
    - name: "sox_applicable"
      expr: sox_applicable
      comment: "Whether SOX applies — segments financial controls-related filings for audit purposes."
  measures:
    - name: "total_filings"
      expr: COUNT(1)
      comment: "Total regulatory filings submitted. Baseline volume KPI for compliance operations capacity planning."
    - name: "total_filing_fee_amount"
      expr: SUM(CAST(filing_fee_amount AS DOUBLE))
      comment: "Total regulatory filing fees paid. Directly informs compliance cost management and budget forecasting."
    - name: "avg_filing_fee_amount"
      expr: AVG(CAST(filing_fee_amount AS DOUBLE))
      comment: "Average filing fee per submission. Benchmarks cost per filing and identifies high-cost filing types."
    - name: "amendment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN amendment_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings that are amendments. High amendment rates signal first-time-right quality issues in the compliance filing process."
    - name: "on_time_filing_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN filing_date <= due_date THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings submitted on or before the due date. A primary compliance KPI — late filings expose the organization to regulatory penalties."
    - name: "overdue_filings"
      expr: COUNT(CASE WHEN filing_date > due_date THEN 1 END)
      comment: "Count of filings submitted after their due date. Directly triggers regulatory risk escalation and penalty exposure review."
    - name: "filings_with_public_inspection_required"
      expr: COUNT(CASE WHEN public_inspection_required = TRUE THEN 1 END)
      comment: "Number of filings requiring public inspection file entries. Used to ensure OPIF compliance obligations are tracked and fulfilled."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for audit finding management — tracks finding severity, penalty exposure, remediation velocity, and recurrence rates to drive compliance risk reduction."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the audit finding (e.g., technical, financial, operational) for risk-type segmentation."
    - name: "severity"
      expr: severity
      comment: "Severity level of the finding (Critical/High/Medium/Low) — primary dimension for risk prioritization."
    - name: "regulatory_domain"
      expr: regulatory_domain
      comment: "Regulatory domain (FCC, GDPR, SOX, COPPA) for cross-framework compliance analysis."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit that generated the finding (internal, external, regulatory) for audit program effectiveness analysis."
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the finding (Open/In Remediation/Closed/Verified) for pipeline management."
    - name: "recurrence_indicator"
      expr: recurrence_indicator
      comment: "Whether this is a repeat finding — recurrent findings signal systemic control failures."
    - name: "identified_year"
      expr: DATE_TRUNC('year', identified_date)
      comment: "Year the finding was identified for trend analysis of audit quality over time."
    - name: "identified_month"
      expr: DATE_TRUNC('month', identified_date)
      comment: "Month the finding was identified for operational cadence monitoring."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total audit findings. Baseline volume KPI for audit program scope and compliance risk exposure."
    - name: "total_potential_penalty_amount"
      expr: SUM(CAST(potential_penalty_amount AS DOUBLE))
      comment: "Total potential penalty exposure across all open findings. A critical financial risk KPI reviewed at board and executive level."
    - name: "avg_potential_penalty_per_finding"
      expr: AVG(CAST(potential_penalty_amount AS DOUBLE))
      comment: "Average potential penalty per finding. Benchmarks risk severity and prioritizes remediation investment."
    - name: "critical_finding_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN severity = 'Critical' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings rated Critical severity. Executives use this to assess whether the compliance program is catching the most serious risks."
    - name: "recurrence_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that are repeat occurrences. High recurrence rates indicate systemic control failures requiring root-cause investment."
    - name: "avg_days_to_resolution"
      expr: AVG(DATEDIFF(actual_resolution_date, identified_date))
      comment: "Average calendar days from finding identification to resolution. Measures remediation velocity — slow resolution increases regulatory penalty risk."
    - name: "open_findings_past_target_date"
      expr: COUNT(CASE WHEN actual_resolution_date IS NULL AND target_resolution_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of unresolved findings past their target resolution date. A leading indicator of compliance program execution risk."
    - name: "distinct_audits_with_findings"
      expr: COUNT(DISTINCT audit_id)
      comment: "Number of distinct audits that produced at least one finding. Measures audit program breadth and finding density."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for compliance incident management — tracks incident volumes, financial impact, regulatory notification compliance, and corrective action closure rates."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`incident`"
  dimensions:
    - name: "incident_description_category"
      expr: affected_regulation
      comment: "Regulation affected by the incident (FCC Part 73, GDPR Art. 33, etc.) for regulatory-domain incident analysis."
    - name: "impacted_service"
      expr: impacted_service
      comment: "Service impacted by the incident (broadcast, streaming, ad delivery) for operational impact segmentation."
    - name: "discovery_source"
      expr: discovery_source
      comment: "How the incident was discovered (internal audit, regulator, customer complaint) — informs detection program effectiveness."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body with jurisdiction over the incident for body-level incident tracking."
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Whether regulatory notification is required — segments incidents by mandatory disclosure obligation."
    - name: "incident_year"
      expr: DATE_TRUNC('year', incident_date)
      comment: "Year of incident for trend analysis of compliance incident frequency."
    - name: "incident_month"
      expr: DATE_TRUNC('month', incident_date)
      comment: "Month of incident for operational cadence and seasonality analysis."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total compliance incidents. Baseline KPI for compliance risk exposure and program effectiveness."
    - name: "total_financial_impact_amount"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of compliance incidents. Directly informs risk quantification for executive and board reporting."
    - name: "avg_financial_impact_per_incident"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per incident. Benchmarks incident cost and prioritizes prevention investment."
    - name: "regulatory_notification_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_notification_required = TRUE AND regulatory_notification_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of incidents requiring regulatory notification where notification was actually sent. Failure to notify regulators on time is a primary source of enforcement action."
    - name: "avg_days_to_corrective_action_completion"
      expr: AVG(DATEDIFF(corrective_action_completion_date, incident_date))
      comment: "Average days from incident date to corrective action completion. Measures remediation speed — a key operational risk KPI."
    - name: "open_incidents_past_corrective_action_due"
      expr: COUNT(CASE WHEN corrective_action_completion_date IS NULL AND corrective_action_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Incidents where corrective action is overdue. Directly triggers escalation and regulatory risk review."
    - name: "avg_days_to_notification"
      expr: AVG(DATEDIFF(regulatory_notification_date, incident_date))
      comment: "Average days from incident discovery to regulatory notification. Many regulations (GDPR Art. 33: 72 hours) impose strict notification windows — this KPI monitors compliance with those deadlines."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_sox_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for SOX internal control program — tracks control effectiveness, deficiency rates, key control coverage, and remediation status for financial reporting compliance."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`sox_control`"
  dimensions:
    - name: "process_area"
      expr: process_area
      comment: "Business process area covered by the control (Revenue Recognition, Accounts Payable, etc.) for process-level SOX coverage analysis."
    - name: "control_type"
      expr: control_type
      comment: "Control type (Preventive/Detective/Corrective) for control design effectiveness analysis."
    - name: "control_frequency"
      expr: control_frequency
      comment: "How often the control operates (Daily/Weekly/Monthly/Quarterly/Annual) for control cadence monitoring."
    - name: "deficiency_classification"
      expr: deficiency_classification
      comment: "SOX deficiency classification (Control Deficiency/Significant Deficiency/Material Weakness) — the most critical dimension for SOX reporting."
    - name: "key_control_flag"
      expr: key_control_flag
      comment: "Whether this is a key control — key controls receive the most rigorous testing and executive attention."
    - name: "automated_flag"
      expr: automated_flag
      comment: "Whether the control is automated — automated controls generally have lower failure rates and testing costs."
    - name: "system_name"
      expr: system_name
      comment: "System supporting the control (SAP, Oracle, Workday) for IT general controls dependency analysis."
  measures:
    - name: "total_controls"
      expr: COUNT(1)
      comment: "Total SOX controls in scope. Baseline KPI for SOX program scale and testing resource planning."
    - name: "key_control_count"
      expr: COUNT(CASE WHEN key_control_flag = TRUE THEN 1 END)
      comment: "Number of key controls. Key controls drive the majority of SOX audit effort and external auditor reliance."
    - name: "material_weakness_count"
      expr: COUNT(CASE WHEN deficiency_classification = 'Material Weakness' THEN 1 END)
      comment: "Number of material weaknesses. A material weakness requires disclosure in the annual report and is a critical board-level KPI."
    - name: "significant_deficiency_count"
      expr: COUNT(CASE WHEN deficiency_classification = 'Significant Deficiency' THEN 1 END)
      comment: "Number of significant deficiencies. Significant deficiencies must be communicated to the audit committee and are leading indicators of potential material weaknesses."
    - name: "control_deficiency_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN deficiency_classification IS NOT NULL AND deficiency_classification != '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of controls with any deficiency classification. Measures overall SOX control health — rising rates trigger audit committee escalation."
    - name: "automated_control_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN automated_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of controls that are automated. Higher automation rates reduce testing cost and improve control reliability."
    - name: "controls_past_remediation_target"
      expr: COUNT(CASE WHEN remediation_target_date < CURRENT_DATE() AND remediation_status NOT IN ('Completed', 'Closed') THEN 1 END)
      comment: "Controls with open deficiencies past their remediation target date. Overdue remediations increase the risk of deficiency escalation to material weakness."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_closed_caption_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for closed captioning compliance — tracks caption accuracy, synchronization quality, complaint rates, and regulatory filing compliance across all captioned content."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`closed_caption_record`"
  dimensions:
    - name: "daypart"
      expr: daypart
      comment: "Broadcast daypart (Prime/Daytime/Late Night) for captioning compliance analysis by time period — FCC rules vary by daypart."
    - name: "program_title"
      expr: program_title
      comment: "Program title for program-level captioning quality analysis."
    - name: "air_date_month"
      expr: DATE_TRUNC('month', air_date)
      comment: "Month of air date for trend analysis of captioning compliance over time."
    - name: "caption_placement_compliance"
      expr: caption_placement_compliance
      comment: "Whether caption placement met FCC standards — used to segment compliant vs. non-compliant airings."
    - name: "caption_synchronization_compliance"
      expr: caption_synchronization_compliance
      comment: "Whether caption synchronization met FCC standards — synchronization failures are a primary source of viewer complaints."
    - name: "regulatory_filing_required"
      expr: regulatory_filing_required
      comment: "Whether a regulatory filing is required for this caption record — used to track filing obligation fulfillment."
  measures:
    - name: "total_captioned_programs"
      expr: COUNT(1)
      comment: "Total captioned program records. Baseline KPI for accessibility compliance program scope."
    - name: "avg_caption_accuracy_score"
      expr: AVG(CAST(caption_accuracy_score AS DOUBLE))
      comment: "Average caption accuracy score across all programs. FCC requires high accuracy — this KPI directly measures compliance with accessibility standards."
    - name: "avg_caption_completeness_pct"
      expr: AVG(CAST(caption_completeness_percentage AS DOUBLE))
      comment: "Average caption completeness percentage. Incomplete captions are a primary FCC violation trigger and viewer complaint driver."
    - name: "avg_caption_latency_seconds"
      expr: AVG(CAST(caption_latency_seconds AS DOUBLE))
      comment: "Average caption latency in seconds. High latency degrades viewer experience and may violate synchronization standards."
    - name: "synchronization_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN caption_synchronization_compliance = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of programs meeting caption synchronization standards. A primary FCC compliance KPI for accessibility."
    - name: "placement_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN caption_placement_compliance = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of programs meeting caption placement standards. Placement violations are separately tracked by the FCC."
    - name: "programs_with_complaints"
      expr: COUNT(CASE WHEN complaint_received_date IS NOT NULL THEN 1 END)
      comment: "Number of programs that received a captioning complaint. Complaint volume is a leading indicator of FCC enforcement risk."
    - name: "regulatory_filing_fulfillment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_filing_required = TRUE AND regulatory_filing_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN regulatory_filing_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of required regulatory filings that were actually filed. Unfiled required reports are a direct FCC violation."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_eas_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for Emergency Alert System (EAS) compliance — tracks alert transmission completeness, test compliance, equipment reliability, and regulatory retention obligations."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`eas_log`"
  dimensions:
    - name: "originator_name"
      expr: originator_name
      comment: "EAS alert originator (NWS, FEMA, State Emergency Management) for alert-source analysis."
    - name: "equipment_used"
      expr: equipment_used
      comment: "EAS equipment used for transmission — used to identify equipment reliability issues."
    - name: "relay_chain_position"
      expr: relay_chain_position
      comment: "Position in the EAS relay chain — used to analyze relay network topology and failure points."
    - name: "alert_year"
      expr: DATE_TRUNC('year', alert_timestamp)
      comment: "Year of EAS alert for trend analysis of alert frequency and compliance."
    - name: "alert_month"
      expr: DATE_TRUNC('month', alert_timestamp)
      comment: "Month of EAS alert for operational cadence monitoring."
    - name: "attention_signal_transmitted"
      expr: attention_signal_transmitted
      comment: "Whether the attention signal was transmitted — a mandatory EAS component; failures are FCC violations."
    - name: "audio_message_transmitted"
      expr: audio_message_transmitted
      comment: "Whether the audio message was transmitted — required for full EAS compliance."
  measures:
    - name: "total_eas_events"
      expr: COUNT(1)
      comment: "Total EAS events logged. Baseline KPI for EAS system activity and compliance program scope."
    - name: "full_transmission_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN attention_signal_transmitted = TRUE AND audio_message_transmitted = TRUE AND end_of_message_transmitted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EAS events where all required components (attention signal, audio, EOM) were transmitted. Full transmission compliance is the primary FCC EAS KPI."
    - name: "cap_message_receipt_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cap_message_received = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EAS events where the CAP (Common Alerting Protocol) message was received. CAP receipt is required for modern EAS compliance."
    - name: "public_inspection_file_entry_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN public_inspection_file_entry = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EAS events logged in the public inspection file. FCC requires EAS logs to be maintained in the OPIF — this KPI measures that obligation."
    - name: "eas_events_with_failures"
      expr: COUNT(CASE WHEN failure_reason IS NOT NULL AND failure_reason != '' THEN 1 END)
      comment: "Number of EAS events with a recorded failure reason. EAS transmission failures are reportable to the FCC and trigger corrective action."
    - name: "records_approaching_retention_expiry"
      expr: COUNT(CASE WHEN retention_expiry_date <= DATE_ADD(CURRENT_DATE(), 30) AND retention_expiry_date >= CURRENT_DATE() THEN 1 END)
      comment: "EAS log records expiring from retention within 30 days. Ensures records are not prematurely purged before regulatory retention periods are met."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_political_ad_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for political advertising compliance — tracks political ad volumes, rate compliance, equal opportunities requests, and public file disclosure obligations under FCC rules."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`political_ad_record`"
  dimensions:
    - name: "office_sought"
      expr: office_sought
      comment: "Political office sought by the candidate — used to segment political ad activity by race type (Presidential, Senate, House, Local)."
    - name: "market_name"
      expr: market_name
      comment: "Market where the political ad aired — used for market-level political ad compliance analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the political ad — LUC (Lowest Unit Charge) rates vary by daypart."
    - name: "rate_class"
      expr: rate_class
      comment: "Rate class charged for the political ad — used to verify LUC compliance."
    - name: "luc_period_flag"
      expr: luc_period_flag
      comment: "Whether the ad aired during the LUC (Lowest Unit Charge) window — LUC compliance is a primary FCC political ad obligation."
    - name: "air_date_month"
      expr: DATE_TRUNC('month', air_date)
      comment: "Month of air date for election cycle political ad volume analysis."
    - name: "equal_opportunities_request_flag"
      expr: equal_opportunities_request_flag
      comment: "Whether an equal opportunities request was filed — tracks Section 315 equal time obligation triggers."
  measures:
    - name: "total_political_ad_spots"
      expr: COUNT(1)
      comment: "Total political ad spots aired. Baseline KPI for political advertising volume and FCC public file obligation scope."
    - name: "total_political_ad_revenue"
      expr: SUM(CAST(rate_charged AS DOUBLE))
      comment: "Total revenue from political advertising. A key financial KPI for election cycle revenue planning and FCC rate disclosure."
    - name: "avg_rate_charged"
      expr: AVG(CAST(rate_charged AS DOUBLE))
      comment: "Average rate charged per political ad spot. Used to verify LUC compliance — political candidates must receive the lowest unit charge during LUC windows."
    - name: "luc_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN luc_period_flag = TRUE AND luc_rate >= rate_charged THEN 1 END) / NULLIF(COUNT(CASE WHEN luc_period_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of LUC-period political ads where the rate charged did not exceed the LUC rate. LUC violations are a primary FCC enforcement area for political advertising."
    - name: "public_file_disclosure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN public_file_disclosure_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of political ad records with a public file disclosure date. FCC requires political ad contracts to be placed in the public inspection file within 2 business days."
    - name: "equal_opportunities_requests"
      expr: COUNT(CASE WHEN equal_opportunities_request_flag = TRUE THEN 1 END)
      comment: "Number of equal opportunities requests received. Rising counts during election cycles require rapid response to avoid Section 315 violations."
    - name: "affidavits_issued"
      expr: COUNT(CASE WHEN affidavit_issued_flag = TRUE THEN 1 END)
      comment: "Number of political ad affidavits issued. Affidavit issuance is a required documentation step for political advertising compliance."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_privacy_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for privacy request management (GDPR/CCPA/CPRA DSARs) — tracks request volumes, response timeliness, regulatory deadline compliance, and processing efficiency."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`privacy_request`"
  dimensions:
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the request (GDPR, CCPA, CPRA, LGPD) for framework-level compliance analysis."
    - name: "requestor_jurisdiction"
      expr: requestor_jurisdiction
      comment: "Jurisdiction of the requestor for geographic privacy compliance analysis."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the request was submitted (web portal, email, phone) for channel effectiveness analysis."
    - name: "extension_granted"
      expr: extension_granted
      comment: "Whether a response extension was granted — extensions indicate processing capacity constraints."
    - name: "request_year"
      expr: DATE_TRUNC('year', submission_timestamp)
      comment: "Year of request submission for trend analysis of privacy request volumes."
    - name: "request_month"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Month of request submission for operational capacity planning."
  measures:
    - name: "total_privacy_requests"
      expr: COUNT(1)
      comment: "Total privacy requests received. Baseline KPI for privacy operations capacity and regulatory obligation scope."
    - name: "regulatory_deadline_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN response_date <= regulatory_deadline THEN 1 END) / NULLIF(COUNT(CASE WHEN response_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of privacy requests responded to within the regulatory deadline. GDPR requires response within 30 days; CCPA within 45 days. Missing deadlines triggers regulatory enforcement."
    - name: "avg_processing_time_hours"
      expr: AVG(CAST(processing_time_hours AS DOUBLE))
      comment: "Average processing time in hours per privacy request. Measures operational efficiency of the privacy response program."
    - name: "avg_data_volume_processed"
      expr: AVG(CAST(data_volume_processed AS DOUBLE))
      comment: "Average data volume processed per privacy request. Informs data infrastructure investment for privacy operations."
    - name: "extension_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN extension_granted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requests requiring a response extension. High extension rates signal privacy operations capacity constraints."
    - name: "overdue_requests"
      expr: COUNT(CASE WHEN response_date IS NULL AND regulatory_deadline < CURRENT_DATE() THEN 1 END)
      comment: "Privacy requests past their regulatory deadline without a response. Each overdue request is a potential regulatory violation requiring immediate escalation."
    - name: "requests_with_rejection"
      expr: COUNT(CASE WHEN rejection_reason IS NOT NULL AND rejection_reason != '' THEN 1 END)
      comment: "Number of privacy requests rejected. Rejection rates and reasons inform privacy policy design and requestor communication strategy."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_content_rating`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for content rating compliance — tracks rating coverage, fee spend, COPPA compliance rates, and rating expiration management across the content portfolio."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`compliance_content_rating`"
  dimensions:
    - name: "rating_system"
      expr: rating_system
      comment: "Rating system applied (TV Parental Guidelines, MPAA, BBFC, FSK) for system-level compliance analysis."
    - name: "rating_authority"
      expr: rating_authority
      comment: "Authority that issued the rating for jurisdiction-level compliance tracking."
    - name: "rating_date_month"
      expr: DATE_TRUNC('month', rating_date)
      comment: "Month of rating for trend analysis of content rating activity."
    - name: "coppa_compliant"
      expr: coppa_compliant
      comment: "Whether the content is COPPA compliant — critical for children's programming regulatory compliance."
    - name: "parental_guidance_required"
      expr: parental_guidance_required
      comment: "Whether parental guidance is required — used to segment content by audience restriction level."
    - name: "violence_descriptor"
      expr: violence_descriptor
      comment: "Whether a violence content descriptor applies — used for content policy and advertiser suitability analysis."
  measures:
    - name: "total_content_ratings"
      expr: COUNT(1)
      comment: "Total content ratings issued. Baseline KPI for content rating program scope and compliance coverage."
    - name: "total_rating_fee_amount"
      expr: SUM(CAST(rating_fee_amount AS DOUBLE))
      comment: "Total fees paid for content ratings. Informs compliance cost budgeting for content rating programs."
    - name: "avg_rating_value"
      expr: AVG(CAST(rating_value AS DOUBLE))
      comment: "Average content rating value across the portfolio. Tracks content maturity profile for programming strategy and advertiser suitability."
    - name: "coppa_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN coppa_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rated content that is COPPA compliant. COPPA violations carry significant FTC penalties — this KPI is a primary children's programming compliance measure."
    - name: "ratings_expiring_within_90_days"
      expr: COUNT(CASE WHEN rating_expiration_date <= DATE_ADD(CURRENT_DATE(), 90) AND rating_expiration_date >= CURRENT_DATE() THEN 1 END)
      comment: "Content ratings expiring within 90 days. Expired ratings must be renewed before content can be distributed — this KPI drives renewal pipeline management."
    - name: "distinct_titles_rated"
      expr: COUNT(DISTINCT content_title_id)
      comment: "Number of distinct titles with compliance content ratings. Measures the breadth of content rating coverage across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_regulatory_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for regulatory obligation management — tracks obligation portfolio health, compliance rates, penalty exposure, and review cadence across all regulatory frameworks."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`regulatory_obligation`"
  dimensions:
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body imposing the obligation (FCC, FTC, SEC, GDPR supervisory authority) for body-level obligation tracking."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction of the obligation for geographic compliance analysis."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for the obligation — used for departmental compliance accountability reporting."
    - name: "compliance_frequency"
      expr: compliance_frequency
      comment: "How often compliance must be demonstrated (Daily/Monthly/Quarterly/Annual) for cadence-based obligation management."
    - name: "is_active"
      expr: is_active
      comment: "Whether the obligation is currently active — used to filter the active obligation portfolio."
    - name: "external_reporting_required"
      expr: external_reporting_required
      comment: "Whether external reporting to a regulator is required — segments obligations by public disclosure burden."
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the obligation became effective for obligation vintage analysis."
  measures:
    - name: "total_active_obligations"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Total active regulatory obligations. Baseline KPI for compliance program scope and resource planning."
    - name: "total_maximum_penalty_exposure"
      expr: SUM(CAST(maximum_penalty_amount AS DOUBLE))
      comment: "Total maximum penalty exposure across all active obligations. A critical financial risk KPI for executive and board reporting."
    - name: "avg_maximum_penalty_per_obligation"
      expr: AVG(CAST(maximum_penalty_amount AS DOUBLE))
      comment: "Average maximum penalty per obligation. Benchmarks risk severity and prioritizes compliance investment."
    - name: "obligations_overdue_for_review"
      expr: COUNT(CASE WHEN next_compliance_review_date < CURRENT_DATE() AND is_active = TRUE THEN 1 END)
      comment: "Active obligations past their next scheduled compliance review date. Overdue reviews increase the risk of undetected non-compliance."
    - name: "external_reporting_obligation_count"
      expr: COUNT(CASE WHEN external_reporting_required = TRUE AND is_active = TRUE THEN 1 END)
      comment: "Number of active obligations requiring external regulatory reporting. Scopes the external reporting program and associated resource requirements."
    - name: "obligations_expiring_within_180_days"
      expr: COUNT(CASE WHEN expiration_date <= DATE_ADD(CURRENT_DATE(), 180) AND expiration_date >= CURRENT_DATE() AND is_active = TRUE THEN 1 END)
      comment: "Active obligations expiring within 180 days. Drives obligation renewal and regulatory engagement planning."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_license_renewal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for broadcast license renewal management — tracks renewal pipeline, fee payments, petition activity, and on-time filing rates to prevent license lapses."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`license_renewal`"
  dimensions:
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body processing the renewal (FCC, Ofcom, CRTC) for body-level renewal tracking."
    - name: "fee_payment_status"
      expr: fee_payment_status
      comment: "Status of renewal fee payment — unpaid fees can result in renewal denial."
    - name: "final_disposition"
      expr: final_disposition
      comment: "Final outcome of the renewal (Granted/Denied/Pending/Withdrawn) for renewal outcome analysis."
    - name: "petition_to_deny_filed"
      expr: petition_to_deny_filed
      comment: "Whether a petition to deny was filed against the renewal — petitions significantly complicate and delay renewal processing."
    - name: "filing_deadline_year"
      expr: DATE_TRUNC('year', filing_deadline)
      comment: "Year of the renewal filing deadline for renewal pipeline planning."
  measures:
    - name: "total_renewals"
      expr: COUNT(1)
      comment: "Total license renewals in the pipeline. Baseline KPI for renewal program scope."
    - name: "total_renewal_fee_amount"
      expr: SUM(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Total renewal fees across the pipeline. Informs regulatory fee budgeting for the renewal cycle."
    - name: "on_time_filing_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN review_start_date <= filing_deadline THEN 1 END) / NULLIF(COUNT(CASE WHEN review_start_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of renewals where the review was initiated before the filing deadline. Late filings risk license lapse and are a primary FCC compliance concern."
    - name: "renewals_with_petitions"
      expr: COUNT(CASE WHEN petition_to_deny_filed = TRUE THEN 1 END)
      comment: "Number of renewals with petitions to deny filed. Petitions require significant legal resources and can delay renewal for years."
    - name: "avg_days_to_approval"
      expr: AVG(DATEDIFF(approval_date, review_start_date))
      comment: "Average days from review start to renewal approval. Measures regulatory processing efficiency and helps forecast renewal timelines."
    - name: "renewals_pending_public_inspection_update"
      expr: COUNT(CASE WHEN public_inspection_file_updated = FALSE OR public_inspection_file_updated IS NULL THEN 1 END)
      comment: "Renewals where the public inspection file has not been updated. FCC requires OPIF updates as part of the renewal process — unfulfilled updates are a compliance gap."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_coppa_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for COPPA compliance declarations — tracks children's content identification, verifiable consent rates, safe harbor program participation, and declaration review cadence."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`coppa_declaration`"
  dimensions:
    - name: "declaration_type"
      expr: declaration_type
      comment: "Type of COPPA declaration (Directed to Children/Mixed Audience/Not Directed to Children) for content classification analysis."
    - name: "declaration_status"
      expr: declaration_status
      comment: "Current status of the declaration (Active/Expired/Under Review) for declaration portfolio management."
    - name: "safe_harbor_program"
      expr: safe_harbor_program
      comment: "COPPA safe harbor program (CARU, kidSAFE) under which the declaration is made — safe harbor participation reduces FTC enforcement risk."
    - name: "parental_consent_mechanism"
      expr: parental_consent_mechanism
      comment: "Mechanism used to obtain verifiable parental consent (email plus, credit card, video conference) for consent method analysis."
    - name: "declaration_year"
      expr: DATE_TRUNC('year', declaration_date)
      comment: "Year of declaration for trend analysis of COPPA compliance activity."
  measures:
    - name: "total_coppa_declarations"
      expr: COUNT(1)
      comment: "Total COPPA declarations. Baseline KPI for children's content compliance program scope."
    - name: "verifiable_consent_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN verifiable_consent_obtained_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of COPPA declarations where verifiable parental consent was obtained. COPPA requires verifiable consent for data collection from children under 13 — this is the primary FTC compliance KPI."
    - name: "safe_harbor_participation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN safe_harbor_program IS NOT NULL AND safe_harbor_program != '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of declarations covered by a COPPA safe harbor program. Safe harbor participation provides FTC enforcement protection."
    - name: "declarations_with_actual_knowledge"
      expr: COUNT(CASE WHEN actual_knowledge_flag = TRUE THEN 1 END)
      comment: "Declarations where the operator has actual knowledge of collecting data from children. Actual knowledge triggers the full COPPA compliance obligation."
    - name: "declarations_due_for_review"
      expr: COUNT(CASE WHEN next_review_date < CURRENT_DATE() THEN 1 END)
      comment: "COPPA declarations past their next scheduled review date. Outdated declarations may not reflect current data practices, creating FTC enforcement risk."
    - name: "persistent_identifier_collection_count"
      expr: COUNT(CASE WHEN persistent_identifier_collection_flag = TRUE THEN 1 END)
      comment: "Declarations where persistent identifiers are collected from children. Persistent identifier collection from children requires heightened COPPA compliance controls."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_anti_piracy_takedown`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for anti-piracy takedown program — tracks takedown volumes, resolution rates, financial loss estimates, repeat infringer identification, and platform-level piracy exposure."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`anti_piracy_takedown`"
  dimensions:
    - name: "platform_name"
      expr: platform_name
      comment: "Platform where infringement was detected (YouTube, Telegram, cyberlocker) for platform-level piracy analysis."
    - name: "infringement_type"
      expr: infringement_type
      comment: "Type of infringement (full episode, clip, live stream) for piracy pattern analysis."
    - name: "notice_type"
      expr: notice_type
      comment: "Type of takedown notice sent (DMCA, court order, platform policy) for legal strategy analysis."
    - name: "takedown_status"
      expr: takedown_status
      comment: "Current status of the takedown (Pending/Resolved/Escalated/Rejected) for pipeline management."
    - name: "is_repeat_infringer_flag"
      expr: is_repeat_infringer_flag
      comment: "Whether the infringer is a repeat offender — repeat infringers may require escalated legal action."
    - name: "detected_year"
      expr: DATE_TRUNC('year', detected_date)
      comment: "Year of detection for trend analysis of piracy activity."
    - name: "detected_month"
      expr: DATE_TRUNC('month', detected_date)
      comment: "Month of detection for operational cadence monitoring of piracy activity."
  measures:
    - name: "total_takedown_notices"
      expr: COUNT(1)
      comment: "Total anti-piracy takedown notices issued. Baseline KPI for anti-piracy program scale and content protection activity."
    - name: "total_estimated_loss_amount"
      expr: SUM(CAST(estimated_loss_amount AS DOUBLE))
      comment: "Total estimated financial loss from piracy incidents. A primary financial risk KPI for content protection investment justification."
    - name: "avg_estimated_loss_per_incident"
      expr: AVG(CAST(estimated_loss_amount AS DOUBLE))
      comment: "Average estimated financial loss per piracy incident. Benchmarks piracy impact severity and prioritizes enforcement resources."
    - name: "takedown_resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN resolved_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of takedown notices that resulted in content removal. Measures anti-piracy program effectiveness — low resolution rates indicate platform non-cooperation."
    - name: "avg_days_to_resolution"
      expr: AVG(DATEDIFF(resolution_date, detected_date))
      comment: "Average days from detection to takedown resolution. Faster resolution reduces the window of unauthorized distribution and associated revenue loss."
    - name: "repeat_infringer_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_repeat_infringer_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of takedowns involving repeat infringers. High repeat rates indicate the need for escalated legal action or platform-level repeat infringer policy enforcement."
    - name: "avg_days_notice_to_submission"
      expr: AVG(DATEDIFF(submitted_date, notice_sent_date))
      comment: "Average days from notice sent to formal submission. Measures the efficiency of the takedown notice-to-submission workflow."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`compliance_regulatory_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for regulatory change management — tracks change pipeline, implementation costs, compliance deadline adherence, and sign-off velocity to manage regulatory change risk."
  source: "`vibe_media_broadcasting_v1`.`compliance`.`regulatory_change`"
  dimensions:
    - name: "issuing_body"
      expr: issuing_body
      comment: "Regulatory body issuing the change (FCC, FTC, EU Commission) for body-level change tracking."
    - name: "regulatory_domain"
      expr: regulatory_domain
      comment: "Regulatory domain of the change (Privacy, Broadcast, Financial) for domain-level impact analysis."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction of the regulatory change for geographic impact analysis."
    - name: "change_type"
      expr: change_type
      comment: "Type of regulatory change (New Rule/Amendment/Guidance/Repeal) for change classification analysis."
    - name: "implementation_status"
      expr: implementation_status
      comment: "Current implementation status (Not Started/In Progress/Completed) for change pipeline management."
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the regulatory change becomes effective for compliance deadline planning."
  measures:
    - name: "total_regulatory_changes"
      expr: COUNT(1)
      comment: "Total regulatory changes tracked. Baseline KPI for regulatory change management program scope."
    - name: "total_estimated_implementation_cost"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated cost to implement all tracked regulatory changes. A critical financial planning KPI for compliance budget forecasting."
    - name: "avg_estimated_implementation_cost"
      expr: AVG(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Average implementation cost per regulatory change. Benchmarks change complexity and informs resource allocation."
    - name: "total_maximum_penalty_exposure"
      expr: SUM(CAST(maximum_penalty_amount AS DOUBLE))
      comment: "Total maximum penalty exposure from unimplemented regulatory changes. Quantifies the financial risk of delayed implementation."
    - name: "changes_past_compliance_deadline"
      expr: COUNT(CASE WHEN compliance_deadline < CURRENT_DATE() AND implementation_status NOT IN ('Completed') THEN 1 END)
      comment: "Regulatory changes past their compliance deadline without completed implementation. Each overdue change represents active regulatory violation risk."
    - name: "implementation_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN implementation_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of regulatory changes with completed implementation. Measures the organization's ability to keep pace with the regulatory change environment."
    - name: "changes_with_comment_submitted"
      expr: COUNT(CASE WHEN organization_comment_submitted = TRUE THEN 1 END)
      comment: "Number of regulatory changes where the organization submitted public comments. Measures regulatory engagement and advocacy program activity."
$$;