-- Metric views for domain: compliance | Business: Waste Management | Version: 1 | Generated on: 2026-05-07 19:57:14

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`compliance_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core permit management KPIs tracking permit lifecycle, compliance status, and financial assurance obligations"
  source: "`waste_management_ecm`.`compliance`.`permit`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of environmental permit (air, water, waste, hazardous materials)"
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of permit (active, expired, pending renewal, suspended)"
    - name: "issuing_agency"
      expr: issuing_agency
      comment: "Regulatory agency that issued the permit (EPA, state DEP, local authority)"
    - name: "regulatory_program"
      expr: regulatory_program
      comment: "Regulatory program under which permit was issued (RCRA, CAA, CWA, TSCA)"
    - name: "permit_tier"
      expr: permit_tier
      comment: "Tier classification of permit indicating complexity and regulatory burden"
    - name: "renewal_status"
      expr: renewal_status
      comment: "Status of permit renewal process"
    - name: "financial_assurance_required_flag"
      expr: financial_assurance_required
      comment: "Whether financial assurance is required for this permit"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year when permit expires"
    - name: "expiration_quarter"
      expr: CONCAT('Q', QUARTER(expiration_date), '-', YEAR(expiration_date))
      comment: "Quarter and year when permit expires for renewal planning"
    - name: "days_until_expiration"
      expr: DATEDIFF(expiration_date, CURRENT_DATE())
      comment: "Days remaining until permit expiration"
  measures:
    - name: "total_permits"
      expr: COUNT(DISTINCT permit_id)
      comment: "Total number of unique permits under management"
    - name: "total_financial_assurance_amount"
      expr: SUM(CAST(financial_assurance_amount AS DOUBLE))
      comment: "Total financial assurance obligations across all permits requiring bonding"
    - name: "avg_financial_assurance_per_permit"
      expr: AVG(CAST(financial_assurance_amount AS DOUBLE))
      comment: "Average financial assurance amount per permit"
    - name: "permits_expiring_within_90_days"
      expr: COUNT(DISTINCT CASE WHEN DATEDIFF(expiration_date, CURRENT_DATE()) BETWEEN 0 AND 90 THEN permit_id END)
      comment: "Number of permits expiring in next 90 days requiring immediate renewal action"
    - name: "permits_with_violations"
      expr: COUNT(DISTINCT CASE WHEN CAST(violation_count AS INT) > 0 THEN permit_id END)
      comment: "Number of permits with one or more recorded violations"
    - name: "total_permitted_capacity"
      expr: SUM(CAST(permitted_capacity AS DOUBLE))
      comment: "Total permitted capacity across all permits (units vary by permit type)"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`compliance_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection performance and compliance findings KPIs for regulatory oversight and audit readiness"
  source: "`waste_management_ecm`.`compliance`.`compliance_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (routine, complaint-driven, follow-up, pre-operational)"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of inspection (scheduled, in-progress, completed, report pending)"
    - name: "inspection_result"
      expr: inspection_result
      comment: "Overall result of inspection (pass, fail, conditional pass, pending corrective action)"
    - name: "inspecting_authority"
      expr: inspecting_authority
      comment: "Authority conducting the inspection (EPA, state agency, third-party auditor)"
    - name: "regulatory_program"
      expr: regulatory_program
      comment: "Regulatory program under which inspection was conducted"
    - name: "corrective_action_required_flag"
      expr: corrective_action_required
      comment: "Whether corrective action is required based on inspection findings"
    - name: "notice_of_violation_issued_flag"
      expr: notice_of_violation_issued
      comment: "Whether a notice of violation was issued during inspection"
    - name: "iso_14001_audit_flag"
      expr: iso_14001_audit
      comment: "Whether inspection was part of ISO 14001 environmental management system audit"
    - name: "iso_45001_audit_flag"
      expr: iso_45001_audit
      comment: "Whether inspection was part of ISO 45001 occupational health and safety audit"
    - name: "inspection_year"
      expr: YEAR(actual_inspection_date)
      comment: "Year when inspection was conducted"
    - name: "inspection_quarter"
      expr: CONCAT('Q', QUARTER(actual_inspection_date), '-', YEAR(actual_inspection_date))
      comment: "Quarter when inspection was conducted"
  measures:
    - name: "total_inspections"
      expr: COUNT(DISTINCT compliance_inspection_id)
      comment: "Total number of compliance inspections conducted"
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS INT))
      comment: "Total number of critical findings across all inspections requiring immediate action"
    - name: "total_major_findings"
      expr: SUM(CAST(major_findings_count AS INT))
      comment: "Total number of major findings across all inspections"
    - name: "total_minor_findings"
      expr: SUM(CAST(minor_findings_count AS INT))
      comment: "Total number of minor findings across all inspections"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total monetary penalties assessed from inspections"
    - name: "avg_penalty_per_inspection"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per inspection"
    - name: "inspections_with_violations"
      expr: COUNT(DISTINCT CASE WHEN notice_of_violation_issued = TRUE THEN compliance_inspection_id END)
      comment: "Number of inspections resulting in notices of violation"
    - name: "avg_critical_findings_per_inspection"
      expr: AVG(CAST(critical_findings_count AS INT))
      comment: "Average number of critical findings per inspection"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`compliance_violation_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Violation management and penalty tracking KPIs for regulatory enforcement response and financial exposure"
  source: "`waste_management_ecm`.`compliance`.`violation_notice`"
  dimensions:
    - name: "violation_category"
      expr: violation_category
      comment: "Category of violation (air quality, water discharge, waste management, reporting)"
    - name: "violation_severity"
      expr: violation_severity
      comment: "Severity level of violation (critical, major, minor)"
    - name: "violation_status"
      expr: violation_status
      comment: "Current status of violation (open, under review, resolved, appealed)"
    - name: "notice_type"
      expr: notice_type
      comment: "Type of notice issued (NOV, consent order, administrative order, warning letter)"
    - name: "issuing_agency"
      expr: issuing_agency
      comment: "Agency that issued the violation notice"
    - name: "regulatory_program"
      expr: regulatory_program
      comment: "Regulatory program under which violation was cited"
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Whether an appeal has been filed for this violation"
    - name: "settlement_agreement_flag"
      expr: settlement_agreement_flag
      comment: "Whether violation was resolved through settlement agreement"
    - name: "public_disclosure_flag"
      expr: public_disclosure_flag
      comment: "Whether violation is subject to public disclosure requirements"
    - name: "violation_year"
      expr: YEAR(violation_date)
      comment: "Year when violation occurred"
    - name: "notice_issued_year"
      expr: YEAR(notice_issued_date)
      comment: "Year when notice was issued"
  measures:
    - name: "total_violations"
      expr: COUNT(DISTINCT violation_notice_id)
      comment: "Total number of violation notices received"
    - name: "total_penalty_assessed"
      expr: SUM(CAST(penalty_assessed_amount AS DOUBLE))
      comment: "Total monetary penalties assessed across all violations"
    - name: "total_penalty_paid"
      expr: SUM(CAST(penalty_paid_amount AS DOUBLE))
      comment: "Total monetary penalties actually paid"
    - name: "outstanding_penalty_amount"
      expr: SUM(CAST(penalty_assessed_amount AS DOUBLE) - CAST(penalty_paid_amount AS DOUBLE))
      comment: "Total outstanding penalty amount not yet paid"
    - name: "avg_penalty_per_violation"
      expr: AVG(CAST(penalty_assessed_amount AS DOUBLE))
      comment: "Average penalty amount per violation notice"
    - name: "violations_with_appeals"
      expr: COUNT(DISTINCT CASE WHEN appeal_filed_flag = TRUE THEN violation_notice_id END)
      comment: "Number of violations where appeals have been filed"
    - name: "violations_with_settlements"
      expr: COUNT(DISTINCT CASE WHEN settlement_agreement_flag = TRUE THEN violation_notice_id END)
      comment: "Number of violations resolved through settlement agreements"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`compliance_regulatory_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action effectiveness and closure KPIs for regulatory response and continuous improvement"
  source: "`waste_management_ecm`.`compliance`.`regulatory_corrective_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action (immediate, interim, permanent, preventive)"
    - name: "action_status"
      expr: action_status
      comment: "Current status of corrective action (planned, in-progress, completed, verified, closed)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of corrective action (critical, high, medium, low)"
    - name: "regulatory_agency"
      expr: regulatory_agency
      comment: "Regulatory agency requiring the corrective action"
    - name: "triggering_event_type"
      expr: triggering_event_type
      comment: "Type of event that triggered corrective action (inspection, incident, audit, self-disclosure)"
    - name: "environmental_impact_category"
      expr: environmental_impact_category
      comment: "Category of environmental impact addressed by corrective action"
    - name: "safety_impact_category"
      expr: safety_impact_category
      comment: "Category of safety impact addressed by corrective action"
    - name: "management_review_required_flag"
      expr: management_review_required
      comment: "Whether management review is required for this corrective action"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of completed corrective action"
    - name: "recurrence_risk"
      expr: recurrence_risk
      comment: "Risk level of issue recurrence after corrective action"
    - name: "target_completion_year"
      expr: YEAR(target_completion_date)
      comment: "Year when corrective action is targeted for completion"
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(DISTINCT regulatory_corrective_action_id)
      comment: "Total number of regulatory corrective actions"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all corrective actions"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred for corrective actions"
    - name: "cost_variance"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(estimated_cost AS DOUBLE))
      comment: "Total cost variance between actual and estimated corrective action costs"
    - name: "avg_cost_per_action"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per corrective action"
    - name: "completed_actions"
      expr: COUNT(DISTINCT CASE WHEN actual_completion_date IS NOT NULL THEN regulatory_corrective_action_id END)
      comment: "Number of corrective actions that have been completed"
    - name: "verified_actions"
      expr: COUNT(DISTINCT CASE WHEN verification_status = 'Verified' THEN regulatory_corrective_action_id END)
      comment: "Number of corrective actions that have been verified as effective"
    - name: "overdue_actions"
      expr: COUNT(DISTINCT CASE WHEN target_completion_date < CURRENT_DATE() AND actual_completion_date IS NULL THEN regulatory_corrective_action_id END)
      comment: "Number of corrective actions past their target completion date"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`compliance_regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory reporting timeliness and compliance KPIs for submission deadlines and agency response tracking"
  source: "`waste_management_ecm`.`compliance`.`regulatory_submission`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of regulatory report submitted (annual, quarterly, incident, permit renewal)"
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of submission (draft, submitted, accepted, rejected, under review)"
    - name: "filing_agency"
      expr: filing_agency
      comment: "Agency to which report was filed"
    - name: "regulatory_program"
      expr: regulatory_program
      comment: "Regulatory program under which report was submitted"
    - name: "agency_response_status"
      expr: agency_response_status
      comment: "Status of agency response to submission"
    - name: "late_submission_flag"
      expr: late_submission_flag
      comment: "Whether submission was filed after the due date"
    - name: "amendment_flag"
      expr: amendment_flag
      comment: "Whether submission is an amendment to a previous filing"
    - name: "submission_method"
      expr: submission_method
      comment: "Method used for submission (electronic portal, mail, hand delivery)"
    - name: "compliance_year"
      expr: compliance_year
      comment: "Compliance year covered by the submission"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year when submission was filed"
    - name: "submission_quarter"
      expr: CONCAT('Q', QUARTER(submission_date), '-', YEAR(submission_date))
      comment: "Quarter when submission was filed"
  measures:
    - name: "total_submissions"
      expr: COUNT(DISTINCT regulatory_submission_id)
      comment: "Total number of regulatory submissions filed"
    - name: "late_submissions"
      expr: COUNT(DISTINCT CASE WHEN late_submission_flag = TRUE THEN regulatory_submission_id END)
      comment: "Number of submissions filed after the due date"
    - name: "on_time_submissions"
      expr: COUNT(DISTINCT CASE WHEN late_submission_flag = FALSE THEN regulatory_submission_id END)
      comment: "Number of submissions filed on or before the due date"
    - name: "amended_submissions"
      expr: COUNT(DISTINCT CASE WHEN amendment_flag = TRUE THEN regulatory_submission_id END)
      comment: "Number of submissions that are amendments to previous filings"
    - name: "accepted_submissions"
      expr: COUNT(DISTINCT CASE WHEN agency_response_status = 'Accepted' THEN regulatory_submission_id END)
      comment: "Number of submissions accepted by regulatory agencies"
    - name: "rejected_submissions"
      expr: COUNT(DISTINCT CASE WHEN agency_response_status = 'Rejected' THEN regulatory_submission_id END)
      comment: "Number of submissions rejected by regulatory agencies"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`compliance_ehs_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental health and safety incident KPIs for OSHA recordability, lost time, and regulatory reporting"
  source: "`waste_management_ecm`.`compliance`.`ehs_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of EHS incident (injury, illness, environmental release, near miss, property damage)"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of incident (reported, under investigation, closed, pending corrective action)"
    - name: "injury_type"
      expr: injury_type
      comment: "Type of injury sustained (laceration, fracture, burn, strain, chemical exposure)"
    - name: "body_part_affected"
      expr: body_part_affected
      comment: "Body part affected by injury"
    - name: "osha_recordable_flag"
      expr: osha_recordable_flag
      comment: "Whether incident meets OSHA recordability criteria"
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Whether incident requires reporting to regulatory agencies"
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether corrective action is required based on incident investigation"
    - name: "ppe_in_use_flag"
      expr: ppe_in_use_flag
      comment: "Whether personal protective equipment was in use at time of incident"
    - name: "root_cause_classification"
      expr: root_cause_classification
      comment: "Classification of incident root cause (human error, equipment failure, process deficiency)"
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year when incident occurred"
    - name: "incident_quarter"
      expr: CONCAT('Q', QUARTER(incident_date), '-', YEAR(incident_date))
      comment: "Quarter when incident occurred"
  measures:
    - name: "total_incidents"
      expr: COUNT(DISTINCT ehs_incident_id)
      comment: "Total number of EHS incidents reported"
    - name: "osha_recordable_incidents"
      expr: COUNT(DISTINCT CASE WHEN osha_recordable_flag = TRUE THEN ehs_incident_id END)
      comment: "Number of incidents meeting OSHA recordability criteria"
    - name: "total_days_away_from_work"
      expr: SUM(CAST(days_away_from_work AS INT))
      comment: "Total days away from work due to incidents"
    - name: "total_days_restricted_work"
      expr: SUM(CAST(days_of_restricted_work AS INT))
      comment: "Total days of restricted work duty due to incidents"
    - name: "total_days_job_transfer"
      expr: SUM(CAST(days_of_job_transfer AS INT))
      comment: "Total days of job transfer due to incidents"
    - name: "total_property_damage"
      expr: SUM(CAST(property_damage_amount AS DOUBLE))
      comment: "Total property damage amount from incidents"
    - name: "avg_property_damage_per_incident"
      expr: AVG(CAST(property_damage_amount AS DOUBLE))
      comment: "Average property damage amount per incident"
    - name: "total_release_quantity"
      expr: SUM(CAST(release_quantity AS DOUBLE))
      comment: "Total quantity of materials released in environmental incidents"
    - name: "incidents_requiring_regulatory_reporting"
      expr: COUNT(DISTINCT CASE WHEN regulatory_reporting_required_flag = TRUE THEN ehs_incident_id END)
      comment: "Number of incidents requiring regulatory agency notification"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`compliance_air_emission_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Air emission event KPIs for permit exceedances, enforcement actions, and environmental impact"
  source: "`waste_management_ecm`.`compliance`.`air_emission_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of air emission event (upset, malfunction, startup, shutdown, maintenance)"
    - name: "air_emission_event_status"
      expr: air_emission_event_status
      comment: "Current status of emission event (reported, under investigation, closed)"
    - name: "pollutant_name"
      expr: pollutant_name
      comment: "Name of pollutant emitted during event"
    - name: "pollutant_code"
      expr: pollutant_code
      comment: "Regulatory code for pollutant"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of emission event (minor, moderate, major, critical)"
    - name: "deviation_flag"
      expr: deviation_flag
      comment: "Whether event represents a deviation from permit limits"
    - name: "enforcement_action_flag"
      expr: enforcement_action_flag
      comment: "Whether enforcement action was taken by regulatory agency"
    - name: "notification_required_flag"
      expr: notification_required_flag
      comment: "Whether regulatory notification was required for this event"
    - name: "community_impact_flag"
      expr: community_impact_flag
      comment: "Whether event had impact on surrounding community"
    - name: "agency_name"
      expr: agency_name
      comment: "Name of regulatory agency notified"
    - name: "event_year"
      expr: YEAR(event_start_timestamp)
      comment: "Year when emission event started"
  measures:
    - name: "total_emission_events"
      expr: COUNT(DISTINCT air_emission_event_id)
      comment: "Total number of air emission events"
    - name: "total_estimated_emissions"
      expr: SUM(CAST(estimated_emission_quantity AS DOUBLE))
      comment: "Total estimated quantity of emissions across all events"
    - name: "avg_emission_quantity_per_event"
      expr: AVG(CAST(estimated_emission_quantity AS DOUBLE))
      comment: "Average emission quantity per event"
    - name: "total_event_duration_hours"
      expr: SUM(CAST(event_duration_hours AS DOUBLE))
      comment: "Total duration of all emission events in hours"
    - name: "avg_event_duration_hours"
      expr: AVG(CAST(event_duration_hours AS DOUBLE))
      comment: "Average duration of emission events in hours"
    - name: "events_with_permit_deviations"
      expr: COUNT(DISTINCT CASE WHEN deviation_flag = TRUE THEN air_emission_event_id END)
      comment: "Number of events representing permit limit deviations"
    - name: "events_with_enforcement_action"
      expr: COUNT(DISTINCT CASE WHEN enforcement_action_flag = TRUE THEN air_emission_event_id END)
      comment: "Number of events resulting in enforcement action"
    - name: "total_penalties"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amounts assessed for emission events"
    - name: "events_with_community_impact"
      expr: COUNT(DISTINCT CASE WHEN community_impact_flag = TRUE THEN air_emission_event_id END)
      comment: "Number of events with documented community impact"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`compliance_spill_release`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spill and release incident KPIs for reportable quantities, cleanup costs, and regulatory response"
  source: "`waste_management_ecm`.`compliance`.`spill_release`"
  dimensions:
    - name: "release_type"
      expr: release_type
      comment: "Type of release (spill, leak, discharge, overflow, rupture)"
    - name: "spill_status"
      expr: spill_status
      comment: "Current status of spill response (active cleanup, contained, closed)"
    - name: "material_released"
      expr: material_released
      comment: "Material or substance released during incident"
    - name: "affected_media"
      expr: affected_media
      comment: "Environmental media affected (soil, groundwater, surface water, air)"
    - name: "cause_category"
      expr: cause_category
      comment: "Category of spill cause (equipment failure, human error, natural event, third party)"
    - name: "location_type"
      expr: location_type
      comment: "Type of location where spill occurred (facility, transport, storage, disposal)"
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Whether spill met regulatory reporting thresholds"
    - name: "reportable_quantity_exceeded_flag"
      expr: reportable_quantity_exceeded_flag
      comment: "Whether spill quantity exceeded CERCLA reportable quantity"
    - name: "agency_notified"
      expr: agency_notified
      comment: "Regulatory agency notified of spill"
    - name: "spill_year"
      expr: YEAR(spill_date)
      comment: "Year when spill occurred"
  measures:
    - name: "total_spills"
      expr: COUNT(DISTINCT spill_release_id)
      comment: "Total number of spill and release incidents"
    - name: "total_estimated_quantity_released"
      expr: SUM(CAST(estimated_quantity AS DOUBLE))
      comment: "Total estimated quantity of materials released"
    - name: "avg_quantity_per_spill"
      expr: AVG(CAST(estimated_quantity AS DOUBLE))
      comment: "Average quantity released per spill incident"
    - name: "total_cleanup_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of spill cleanup and remediation"
    - name: "avg_cleanup_cost_per_spill"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average cleanup cost per spill incident"
    - name: "total_waste_disposed"
      expr: SUM(CAST(waste_disposed_quantity AS DOUBLE))
      comment: "Total quantity of contaminated waste disposed from cleanup"
    - name: "reportable_spills"
      expr: COUNT(DISTINCT CASE WHEN regulatory_reportable_flag = TRUE THEN spill_release_id END)
      comment: "Number of spills meeting regulatory reporting thresholds"
    - name: "spills_exceeding_rq"
      expr: COUNT(DISTINCT CASE WHEN reportable_quantity_exceeded_flag = TRUE THEN spill_release_id END)
      comment: "Number of spills exceeding CERCLA reportable quantities"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`compliance_scheduled_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance obligation tracking KPIs for due dates, completion rates, and escalation management"
  source: "`waste_management_ecm`.`compliance`.`scheduled_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of compliance obligation (report, inspection, training, monitoring, permit renewal)"
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of obligation (pending, in-progress, completed, overdue, cancelled)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of obligation (critical, high, medium, low)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level if obligation is not met"
    - name: "regulatory_agency"
      expr: regulatory_agency
      comment: "Regulatory agency requiring the obligation"
    - name: "regulatory_driver"
      expr: regulatory_driver
      comment: "Regulatory driver for obligation (permit condition, statute, consent decree)"
    - name: "submission_required_flag"
      expr: submission_required_flag
      comment: "Whether obligation requires submission to regulatory agency"
    - name: "training_required_flag"
      expr: training_required_flag
      comment: "Whether obligation requires training completion"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether obligation has been escalated due to risk or delay"
    - name: "recurrence_frequency"
      expr: recurrence_frequency
      comment: "Frequency of recurring obligation (annual, quarterly, monthly, one-time)"
    - name: "due_year"
      expr: YEAR(due_date)
      comment: "Year when obligation is due"
    - name: "due_quarter"
      expr: CONCAT('Q', QUARTER(due_date), '-', YEAR(due_date))
      comment: "Quarter when obligation is due"
  measures:
    - name: "total_obligations"
      expr: COUNT(DISTINCT scheduled_obligation_id)
      comment: "Total number of scheduled compliance obligations"
    - name: "completed_obligations"
      expr: COUNT(DISTINCT CASE WHEN completion_date IS NOT NULL THEN scheduled_obligation_id END)
      comment: "Number of obligations that have been completed"
    - name: "overdue_obligations"
      expr: COUNT(DISTINCT CASE WHEN due_date < CURRENT_DATE() AND completion_date IS NULL THEN scheduled_obligation_id END)
      comment: "Number of obligations past their due date and not yet completed"
    - name: "escalated_obligations"
      expr: COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN scheduled_obligation_id END)
      comment: "Number of obligations that have been escalated"
    - name: "total_estimated_effort_hours"
      expr: SUM(CAST(estimated_effort_hours AS DOUBLE))
      comment: "Total estimated effort hours for all obligations"
    - name: "total_actual_effort_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE))
      comment: "Total actual effort hours spent on obligations"
    - name: "effort_variance_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE) - CAST(estimated_effort_hours AS DOUBLE))
      comment: "Total variance between actual and estimated effort hours"
    - name: "avg_effort_per_obligation"
      expr: AVG(CAST(actual_effort_hours AS DOUBLE))
      comment: "Average actual effort hours per obligation"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`compliance_training_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance training and certification KPIs for workforce competency, expiration tracking, and regulatory readiness"
  source: "`waste_management_ecm`.`compliance`.`training_certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (HAZWOPER, DOT, RCRA, confined space, forklift)"
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of certification (active, expired, pending renewal, suspended)"
    - name: "issuing_body"
      expr: issuing_body
      comment: "Organization that issued the certification"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority requiring the certification (OSHA, EPA, DOT, state agency)"
    - name: "compliance_requirement_flag"
      expr: compliance_requirement_flag
      comment: "Whether certification is required for regulatory compliance"
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Whether certification requires periodic renewal"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail status of certification exam or assessment"
    - name: "training_delivery_method"
      expr: training_delivery_method
      comment: "Method of training delivery (classroom, online, hands-on, blended)"
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year when training was completed"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year when certification expires"
  measures:
    - name: "total_certifications"
      expr: COUNT(DISTINCT training_certification_id)
      comment: "Total number of training certifications"
    - name: "active_certifications"
      expr: COUNT(DISTINCT CASE WHEN certification_status = 'Active' THEN training_certification_id END)
      comment: "Number of currently active certifications"
    - name: "expired_certifications"
      expr: COUNT(DISTINCT CASE WHEN certification_status = 'Expired' THEN training_certification_id END)
      comment: "Number of expired certifications requiring renewal"
    - name: "certifications_expiring_within_90_days"
      expr: COUNT(DISTINCT CASE WHEN DATEDIFF(expiration_date, CURRENT_DATE()) BETWEEN 0 AND 90 THEN training_certification_id END)
      comment: "Number of certifications expiring in next 90 days"
    - name: "total_training_hours"
      expr: SUM(CAST(training_hours AS DOUBLE))
      comment: "Total training hours completed across all certifications"
    - name: "avg_training_hours_per_certification"
      expr: AVG(CAST(training_hours AS DOUBLE))
      comment: "Average training hours per certification"
    - name: "total_training_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of training and certification programs"
    - name: "avg_cost_per_certification"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per certification"
    - name: "avg_certification_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average score achieved on certification exams"
$$;