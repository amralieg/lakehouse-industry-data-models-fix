-- Metric views for domain: conflict | Business: Legal | Version: 1 | Generated on: 2026-05-07 11:54:14

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`conflict_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core conflict check performance and clearance metrics tracking turnaround time, SLA compliance, and clearance outcomes for new matter intake and lateral hire screening"
  source: "`legal_ecm`.`conflict`.`check`"
  dimensions:
    - name: "check_type"
      expr: check_type
      comment: "Type of conflict check performed (new matter, lateral hire, prospective client, etc.)"
    - name: "clearance_status"
      expr: clearance_status
      comment: "Current clearance status (cleared, pending, rejected, conditional)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the conflict check"
    - name: "conflict_severity"
      expr: conflict_severity
      comment: "Severity level of identified conflicts (high, medium, low, none)"
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the conflict check"
    - name: "ethical_wall_required"
      expr: ethical_wall_required
      comment: "Whether an ethical wall is required to mitigate conflicts"
    - name: "client_waiver_required"
      expr: client_waiver_required
      comment: "Whether client waiver is required for clearance"
    - name: "sla_met_flag"
      expr: sla_met_flag
      comment: "Whether the check met the SLA target turnaround time"
    - name: "submitted_year"
      expr: YEAR(submitted_timestamp)
      comment: "Year the conflict check was submitted"
    - name: "submitted_month"
      expr: DATE_TRUNC('MONTH', submitted_timestamp)
      comment: "Month the conflict check was submitted"
    - name: "submitted_quarter"
      expr: DATE_TRUNC('QUARTER', submitted_timestamp)
      comment: "Quarter the conflict check was submitted"
  measures:
    - name: "total_conflict_checks"
      expr: COUNT(1)
      comment: "Total number of conflict checks performed"
    - name: "avg_turnaround_hours"
      expr: AVG(CAST(actual_turnaround_hours AS DOUBLE))
      comment: "Average turnaround time in hours from submission to clearance decision"
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_met_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of conflict checks that met SLA turnaround targets"
    - name: "clearance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN clearance_status = 'cleared' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of conflict checks that resulted in clearance"
    - name: "ethical_wall_requirement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ethical_wall_required = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checks requiring ethical wall implementation"
    - name: "waiver_requirement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN client_waiver_required = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checks requiring client waiver for clearance"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`conflict_clearance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Conflict clearance decision metrics tracking approval rates, conditional clearances, ethical wall requirements, and matter opening outcomes"
  source: "`legal_ecm`.`conflict`.`clearance`"
  dimensions:
    - name: "clearance_status"
      expr: clearance_status
      comment: "Current status of the conflict clearance (approved, denied, conditional, deferred)"
    - name: "outcome"
      expr: outcome
      comment: "Final outcome of the clearance decision"
    - name: "conditions_imposed_flag"
      expr: conditions_imposed_flag
      comment: "Whether conditions were imposed on the clearance"
    - name: "ethical_wall_required_flag"
      expr: ethical_wall_required_flag
      comment: "Whether an ethical wall is required as part of clearance"
    - name: "client_waiver_obtained_flag"
      expr: client_waiver_obtained_flag
      comment: "Whether client waiver was obtained"
    - name: "matter_opened_flag"
      expr: matter_opened_flag
      comment: "Whether the matter was opened following clearance"
    - name: "adverse_party_identified_flag"
      expr: adverse_party_identified_flag
      comment: "Whether an adverse party was identified during clearance"
    - name: "periodic_review_required_flag"
      expr: periodic_review_required_flag
      comment: "Whether periodic review is required for this clearance"
    - name: "decision_year"
      expr: YEAR(decision_date)
      comment: "Year the clearance decision was made"
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month the clearance decision was made"
  measures:
    - name: "total_clearances"
      expr: COUNT(1)
      comment: "Total number of conflict clearances processed"
    - name: "approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN outcome = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of clearances that were approved"
    - name: "conditional_clearance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN conditions_imposed_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of clearances approved with conditions"
    - name: "denial_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN outcome = 'denied' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of clearances that were denied"
    - name: "matter_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN matter_opened_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of clearances that resulted in matter opening"
    - name: "ethical_wall_deployment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ethical_wall_required_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of clearances requiring ethical wall deployment"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`conflict_ethical_wall`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ethical wall effectiveness and compliance metrics tracking wall status, enforcement, breach incidents, and acknowledgment completion"
  source: "`legal_ecm`.`conflict`.`ethical_wall`"
  dimensions:
    - name: "wall_status"
      expr: wall_status
      comment: "Current status of the ethical wall (active, dissolved, pending)"
    - name: "triggering_reason"
      expr: triggering_reason
      comment: "Reason the ethical wall was established"
    - name: "system_enforcement_flag"
      expr: system_enforcement_flag
      comment: "Whether the wall is enforced at the system level"
    - name: "acknowledgment_required_flag"
      expr: acknowledgment_required_flag
      comment: "Whether acknowledgment is required from screened timekeepers"
    - name: "elite_enforcement_flag"
      expr: elite_enforcement_flag
      comment: "Whether the wall is enforced in Elite practice management system"
    - name: "imanage_enforcement_flag"
      expr: imanage_enforcement_flag
      comment: "Whether the wall is enforced in iManage document management system"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the ethical wall became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the ethical wall became effective"
  measures:
    - name: "total_ethical_walls"
      expr: COUNT(1)
      comment: "Total number of ethical walls established"
    - name: "active_walls"
      expr: COUNT(CASE WHEN wall_status = 'active' THEN 1 END)
      comment: "Number of currently active ethical walls"
    - name: "system_enforcement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN system_enforcement_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of walls with system-level enforcement enabled"
    - name: "avg_acknowledgment_completion_rate"
      expr: AVG(CAST(acknowledgment_completion_rate AS DOUBLE))
      comment: "Average acknowledgment completion rate across all ethical walls"
    - name: "total_breach_incidents"
      expr: SUM(CAST(breach_incident_count AS BIGINT))
      comment: "Total number of breach incidents across all ethical walls"
    - name: "avg_screened_timekeepers"
      expr: AVG(CAST(screened_timekeeper_count AS BIGINT))
      comment: "Average number of timekeepers screened per ethical wall"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`conflict_lateral_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lateral hire conflict screening metrics tracking clearance decisions, conflict identification rates, ethical wall requirements, and screening turnaround"
  source: "`legal_ecm`.`conflict`.`lateral_screening`"
  dimensions:
    - name: "screening_status"
      expr: screening_status
      comment: "Current status of the lateral screening (pending, cleared, rejected, in review)"
    - name: "clearance_decision"
      expr: clearance_decision
      comment: "Final clearance decision for the lateral candidate"
    - name: "conflict_severity_level"
      expr: conflict_severity_level
      comment: "Severity level of conflicts identified (high, medium, low, none)"
    - name: "ethical_wall_required_flag"
      expr: ethical_wall_required_flag
      comment: "Whether an ethical wall is required for the lateral hire"
    - name: "conflicts_committee_review_flag"
      expr: conflicts_committee_review_flag
      comment: "Whether the screening required conflicts committee review"
    - name: "client_consent_required_flag"
      expr: client_consent_required_flag
      comment: "Whether client consent is required for the lateral hire"
    - name: "proposed_practice_group"
      expr: proposed_practice_group
      comment: "Practice group the candidate is proposed to join"
    - name: "prior_firm_jurisdiction"
      expr: prior_firm_jurisdiction
      comment: "Jurisdiction of the candidate's prior firm"
    - name: "screening_year"
      expr: YEAR(created_timestamp)
      comment: "Year the lateral screening was initiated"
    - name: "screening_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the lateral screening was initiated"
  measures:
    - name: "total_lateral_screenings"
      expr: COUNT(1)
      comment: "Total number of lateral hire screenings performed"
    - name: "clearance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN clearance_decision = 'cleared' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lateral candidates cleared for hire"
    - name: "avg_conflicts_identified"
      expr: AVG(CAST(conflicts_identified_count AS BIGINT))
      comment: "Average number of conflicts identified per lateral screening"
    - name: "ethical_wall_requirement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ethical_wall_required_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lateral hires requiring ethical wall implementation"
    - name: "committee_escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN conflicts_committee_review_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings escalated to conflicts committee"
    - name: "avg_matters_disclosed"
      expr: AVG(CAST(matters_disclosed_count AS BIGINT))
      comment: "Average number of matters disclosed per lateral candidate"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`conflict_search_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Conflict search performance and effectiveness metrics tracking hit rates, search types, match methods, and search execution efficiency"
  source: "`legal_ecm`.`conflict`.`search_execution`"
  dimensions:
    - name: "search_status"
      expr: search_status
      comment: "Status of the search execution (completed, failed, in progress)"
    - name: "search_type"
      expr: search_type
      comment: "Type of conflict search performed (party, matter, relationship, etc.)"
    - name: "search_scope"
      expr: search_scope
      comment: "Scope of the search (current matters, all matters, parties, etc.)"
    - name: "fuzzy_match_applied"
      expr: fuzzy_match_applied
      comment: "Whether fuzzy matching was applied in the search"
    - name: "phonetic_variant_applied"
      expr: phonetic_variant_applied
      comment: "Whether phonetic variant matching was applied"
    - name: "lateral_hire_screen_flag"
      expr: lateral_hire_screen_flag
      comment: "Whether this search was part of lateral hire screening"
    - name: "relationship_depth"
      expr: relationship_depth
      comment: "Depth of relationship mapping in the search"
    - name: "execution_year"
      expr: YEAR(search_execution_timestamp)
      comment: "Year the search was executed"
    - name: "execution_month"
      expr: DATE_TRUNC('MONTH', search_execution_timestamp)
      comment: "Month the search was executed"
  measures:
    - name: "total_searches"
      expr: COUNT(1)
      comment: "Total number of conflict searches executed"
    - name: "avg_search_duration_ms"
      expr: AVG(CAST(search_duration_milliseconds AS BIGINT))
      comment: "Average search execution duration in milliseconds"
    - name: "avg_hit_count"
      expr: AVG(CAST(hit_count AS BIGINT))
      comment: "Average number of hits per search execution"
    - name: "avg_exact_matches"
      expr: AVG(CAST(exact_match_count AS BIGINT))
      comment: "Average number of exact matches per search"
    - name: "avg_fuzzy_matches"
      expr: AVG(CAST(fuzzy_match_count AS BIGINT))
      comment: "Average number of fuzzy matches per search"
    - name: "fuzzy_match_usage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fuzzy_match_applied = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of searches utilizing fuzzy matching"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`conflict_search_hit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Conflict search hit analysis metrics tracking match quality, false positive rates, conflict severity, waiver requirements, and resolution outcomes"
  source: "`legal_ecm`.`conflict`.`search_hit`"
  dimensions:
    - name: "conflict_severity"
      expr: conflict_severity
      comment: "Severity level of the conflict identified (high, medium, low)"
    - name: "initial_assessment"
      expr: initial_assessment
      comment: "Initial assessment of the conflict hit"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the conflict hit"
    - name: "is_false_positive"
      expr: is_false_positive
      comment: "Whether the hit was determined to be a false positive"
    - name: "match_method"
      expr: match_method
      comment: "Method used to match the conflict (exact, fuzzy, phonetic, relationship)"
    - name: "relationship_type"
      expr: relationship_type
      comment: "Type of relationship identified in the hit"
    - name: "ethical_wall_required"
      expr: ethical_wall_required
      comment: "Whether an ethical wall is required to mitigate the conflict"
    - name: "requires_waiver"
      expr: requires_waiver
      comment: "Whether a client waiver is required"
    - name: "substantially_related_matter"
      expr: substantially_related_matter
      comment: "Whether the hit involves a substantially related matter"
    - name: "escalated_to_partner"
      expr: escalated_to_partner
      comment: "Whether the hit was escalated to partner review"
    - name: "hit_year"
      expr: YEAR(created_timestamp)
      comment: "Year the search hit was created"
    - name: "hit_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the search hit was created"
  measures:
    - name: "total_search_hits"
      expr: COUNT(1)
      comment: "Total number of conflict search hits identified"
    - name: "false_positive_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_false_positive = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of search hits that were false positives"
    - name: "avg_match_confidence"
      expr: AVG(CAST(match_confidence_score AS DOUBLE))
      comment: "Average match confidence score across all hits"
    - name: "waiver_requirement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN requires_waiver = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of hits requiring client waiver"
    - name: "waiver_obtained_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN waiver_obtained = true THEN 1 END) / NULLIF(COUNT(CASE WHEN requires_waiver = true THEN 1 END), 0), 2)
      comment: "Percentage of required waivers that were successfully obtained"
    - name: "partner_escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalated_to_partner = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of hits escalated to partner review"
    - name: "substantially_related_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN substantially_related_matter = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of hits involving substantially related matters"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`conflict_waiver`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Conflict waiver management metrics tracking waiver approval rates, execution status, revocation rates, and ethical wall requirements"
  source: "`legal_ecm`.`conflict`.`waiver`"
  dimensions:
    - name: "waiver_status"
      expr: waiver_status
      comment: "Current status of the conflict waiver (active, expired, revoked, pending)"
    - name: "conflict_type"
      expr: conflict_type
      comment: "Type of conflict being waived"
    - name: "consent_form_type"
      expr: consent_form_type
      comment: "Type of consent form used for the waiver"
    - name: "ethical_wall_required"
      expr: ethical_wall_required
      comment: "Whether an ethical wall is required in addition to the waiver"
    - name: "is_scope_limited"
      expr: is_scope_limited
      comment: "Whether the waiver has scope limitations"
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction code governing the waiver"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the waiver was approved"
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the waiver was approved"
    - name: "execution_year"
      expr: YEAR(execution_date)
      comment: "Year the waiver was executed"
  measures:
    - name: "total_waivers"
      expr: COUNT(1)
      comment: "Total number of conflict waivers processed"
    - name: "active_waivers"
      expr: COUNT(CASE WHEN waiver_status = 'active' THEN 1 END)
      comment: "Number of currently active conflict waivers"
    - name: "revocation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN waiver_status = 'revoked' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of waivers that have been revoked"
    - name: "scope_limitation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_scope_limited = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of waivers with scope limitations"
    - name: "ethical_wall_pairing_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ethical_wall_required = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of waivers requiring ethical wall in addition to waiver"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`conflict_audit_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Conflict audit session metrics tracking session outcomes, conflict detection rates, escalation patterns, and screening efficiency"
  source: "`legal_ecm`.`conflict`.`audit_session`"
  dimensions:
    - name: "session_status"
      expr: session_status
      comment: "Current status of the audit session (active, completed, escalated, cancelled)"
    - name: "session_type"
      expr: session_type
      comment: "Type of audit session (new matter, lateral hire, periodic review, etc.)"
    - name: "clearance_decision"
      expr: clearance_decision
      comment: "Final clearance decision from the audit session"
    - name: "conflict_detected_flag"
      expr: conflict_detected_flag
      comment: "Whether conflicts were detected during the session"
    - name: "conflict_severity"
      expr: conflict_severity
      comment: "Severity level of conflicts detected (high, medium, low, none)"
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Whether escalation was required during the session"
    - name: "ethical_wall_required_flag"
      expr: ethical_wall_required_flag
      comment: "Whether an ethical wall is required as outcome of the session"
    - name: "screening_scope"
      expr: screening_scope
      comment: "Scope of screening performed in the session"
    - name: "practice_area"
      expr: practice_area
      comment: "Practice area associated with the audit session"
    - name: "initiated_year"
      expr: YEAR(initiated_timestamp)
      comment: "Year the audit session was initiated"
    - name: "initiated_month"
      expr: DATE_TRUNC('MONTH', initiated_timestamp)
      comment: "Month the audit session was initiated"
  measures:
    - name: "total_audit_sessions"
      expr: COUNT(1)
      comment: "Total number of conflict audit sessions conducted"
    - name: "conflict_detection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN conflict_detected_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audit sessions that detected conflicts"
    - name: "avg_entities_screened"
      expr: AVG(CAST(entities_screened_count AS BIGINT))
      comment: "Average number of entities screened per audit session"
    - name: "avg_conflicts_identified"
      expr: AVG(CAST(conflicts_identified_count AS BIGINT))
      comment: "Average number of conflicts identified per session"
    - name: "avg_session_duration_seconds"
      expr: AVG(CAST(duration_seconds AS BIGINT))
      comment: "Average duration of audit sessions in seconds"
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_required_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions requiring escalation"
    - name: "clearance_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN clearance_decision = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions resulting in clearance approval"
$$;