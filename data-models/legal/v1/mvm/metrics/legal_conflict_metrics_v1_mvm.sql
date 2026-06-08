-- Metric views for domain: conflict | Business: Legal | Version: 1 | Generated on: 2026-05-07 14:29:57

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`conflict_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for conflict-of-interest checks: turnaround performance, SLA compliance, clearance outcomes, and waiver rates. Used by General Counsel and Risk leadership to monitor intake quality and ethical-review throughput."
  source: "`legal_ecm`.`conflict`.`check`"
  dimensions:
    - name: "check_type"
      expr: check_type
      comment: "Category of conflict check (e.g., new matter, lateral hire, prospective client) enabling performance segmentation by check category."
    - name: "clearance_status"
      expr: clearance_status
      comment: "Current clearance outcome of the check (e.g., Cleared, Pending, Rejected) for pipeline and backlog analysis."
    - name: "conflict_severity"
      expr: conflict_severity
      comment: "Severity classification of the identified conflict (e.g., High, Medium, Low) to prioritise escalation and resource allocation."
    - name: "priority_level"
      expr: priority_level
      comment: "Operational priority assigned to the check, enabling triage and SLA management by urgency tier."
    - name: "ethics_partner_name"
      expr: ethics_partner_name
      comment: "Name of the ethics partner responsible for final disposition, supporting workload and quality analysis by reviewer."
    - name: "primary_reviewer_disposition"
      expr: primary_reviewer_disposition
      comment: "Disposition recorded by the primary reviewer (e.g., Approved, Escalated, Rejected) for reviewer-level quality tracking."
    - name: "ethical_wall_required"
      expr: ethical_wall_required
      comment: "Flag indicating whether an ethical wall was required as a mitigation measure, used to track structural conflict controls."
    - name: "client_waiver_required"
      expr: client_waiver_required
      comment: "Flag indicating whether a client waiver was required, enabling waiver-demand trend analysis."
    - name: "submitted_month"
      expr: DATE_TRUNC('MONTH', submitted_timestamp)
      comment: "Month in which the conflict check was submitted, enabling trend analysis of check volume over time."
    - name: "check_number"
      expr: check_number
      comment: "Unique business reference number for the conflict check, used for operational traceability."
  measures:
    - name: "total_conflict_checks"
      expr: COUNT(1)
      comment: "Total number of conflict checks submitted. Baseline volume metric for capacity planning and trend monitoring."
    - name: "sla_compliant_checks"
      expr: COUNT(CASE WHEN sla_met_flag = TRUE THEN 1 END)
      comment: "Number of conflict checks completed within the agreed SLA turnaround time. Directly measures ethical-review service quality."
    - name: "sla_breach_checks"
      expr: COUNT(CASE WHEN sla_met_flag = FALSE THEN 1 END)
      comment: "Number of conflict checks that breached the SLA target. Triggers operational intervention and resource reallocation."
    - name: "avg_actual_turnaround_hours"
      expr: AVG(CAST(actual_turnaround_hours AS DOUBLE))
      comment: "Average actual turnaround time in hours across all conflict checks. Key efficiency KPI for the conflicts review function."
    - name: "total_turnaround_hours"
      expr: SUM(CAST(actual_turnaround_hours AS DOUBLE))
      comment: "Total hours consumed across all conflict checks. Used to assess aggregate capacity consumption and staffing needs."
    - name: "cleared_checks"
      expr: COUNT(CASE WHEN clearance_status = 'Cleared' THEN 1 END)
      comment: "Number of checks that achieved a cleared status, indicating matters approved to proceed without conflict impediment."
    - name: "rejected_checks"
      expr: COUNT(CASE WHEN clearance_status = 'Rejected' THEN 1 END)
      comment: "Number of checks rejected due to unresolvable conflicts. High rejection rates signal systemic intake or screening issues."
    - name: "waiver_required_checks"
      expr: COUNT(CASE WHEN client_waiver_required = TRUE THEN 1 END)
      comment: "Number of checks where a client waiver was required. Tracks the frequency of conflict situations requiring client consent."
    - name: "waiver_obtained_checks"
      expr: COUNT(CASE WHEN client_waiver_obtained = TRUE THEN 1 END)
      comment: "Number of checks where a client waiver was successfully obtained. Measures waiver conversion effectiveness."
    - name: "ethical_wall_required_checks"
      expr: COUNT(CASE WHEN ethical_wall_required = TRUE THEN 1 END)
      comment: "Number of checks requiring an ethical wall as a mitigation measure. Informs ethical wall provisioning demand."
    - name: "high_severity_checks"
      expr: COUNT(CASE WHEN conflict_severity = 'High' THEN 1 END)
      comment: "Number of checks classified as high-severity conflicts. Executives monitor this to assess firm-wide ethical risk exposure."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`conflict_clearance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for conflict clearance decisions: approval rates, condition fulfilment, waiver outcomes, ethical wall provisioning, and periodic review compliance. Used by General Counsel, Risk, and Compliance leadership to govern matter-opening integrity."
  source: "`legal_ecm`.`conflict`.`clearance`"
  dimensions:
    - name: "clearance_status"
      expr: clearance_status
      comment: "Current status of the clearance decision (e.g., Approved, Denied, Conditional) for pipeline and outcome analysis."
    - name: "outcome"
      expr: outcome
      comment: "Final outcome of the clearance process, enabling trend analysis of approval vs. denial rates."
    - name: "condition_fulfillment_status"
      expr: condition_fulfillment_status
      comment: "Status of any conditions imposed on the clearance (e.g., Fulfilled, Pending, Overdue) for compliance tracking."
    - name: "ethical_wall_required_flag"
      expr: ethical_wall_required_flag
      comment: "Indicates whether an ethical wall was required as part of the clearance, used to track structural conflict controls."
    - name: "adverse_party_identified_flag"
      expr: adverse_party_identified_flag
      comment: "Indicates whether an adverse party was identified during clearance, a key risk signal for matter acceptance decisions."
    - name: "imputed_conflict_flag"
      expr: imputed_conflict_flag
      comment: "Indicates whether the conflict was imputed (e.g., from a lateral hire or firm-wide relationship), enabling imputed-conflict trend analysis."
    - name: "lateral_hire_screening_flag"
      expr: lateral_hire_screening_flag
      comment: "Indicates whether the clearance was triggered by a lateral hire screening, supporting lateral integration risk monitoring."
    - name: "periodic_review_required_flag"
      expr: periodic_review_required_flag
      comment: "Indicates whether the clearance requires periodic re-review, enabling ongoing compliance obligation tracking."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month of the clearance decision, enabling monthly trend analysis of clearance throughput and outcomes."
    - name: "clearance_number"
      expr: clearance_number
      comment: "Unique business reference number for the clearance record, used for operational traceability."
  measures:
    - name: "total_clearances"
      expr: COUNT(1)
      comment: "Total number of conflict clearance decisions processed. Baseline volume metric for matter-opening governance."
    - name: "matters_opened"
      expr: COUNT(CASE WHEN matter_opened_flag = TRUE THEN 1 END)
      comment: "Number of clearances that resulted in a matter being opened. Directly measures the conversion of cleared conflicts to active engagements."
    - name: "denied_clearances"
      expr: COUNT(CASE WHEN outcome = 'Denied' THEN 1 END)
      comment: "Number of clearances denied due to unresolvable conflicts. Tracks firm-wide conflict rejection rate and risk posture."
    - name: "conditional_clearances"
      expr: COUNT(CASE WHEN conditions_imposed_flag = TRUE THEN 1 END)
      comment: "Number of clearances approved with conditions imposed. High conditional rates indicate complex conflict landscapes requiring active management."
    - name: "conditions_overdue"
      expr: COUNT(CASE WHEN condition_fulfillment_status = 'Overdue' THEN 1 END)
      comment: "Number of clearances with overdue condition fulfilment. A compliance risk indicator requiring immediate escalation."
    - name: "waivers_obtained"
      expr: COUNT(CASE WHEN client_waiver_obtained_flag = TRUE THEN 1 END)
      comment: "Number of clearances where a client waiver was successfully obtained. Measures the firm's ability to resolve conflicts through consent."
    - name: "adverse_party_clearances"
      expr: COUNT(CASE WHEN adverse_party_identified_flag = TRUE THEN 1 END)
      comment: "Number of clearances where an adverse party was identified. Tracks the volume of high-risk conflict scenarios entering the clearance pipeline."
    - name: "ethical_wall_required_clearances"
      expr: COUNT(CASE WHEN ethical_wall_required_flag = TRUE THEN 1 END)
      comment: "Number of clearances requiring an ethical wall. Drives ethical wall provisioning demand forecasting."
    - name: "imputed_conflict_clearances"
      expr: COUNT(CASE WHEN imputed_conflict_flag = TRUE THEN 1 END)
      comment: "Number of clearances involving imputed conflicts. Monitors lateral hire and firm-wide relationship risk exposure."
    - name: "periodic_review_required_clearances"
      expr: COUNT(CASE WHEN periodic_review_required_flag = TRUE THEN 1 END)
      comment: "Number of clearances requiring periodic re-review. Informs the ongoing compliance review workload pipeline."
    - name: "client_notification_required_clearances"
      expr: COUNT(CASE WHEN client_notification_required_flag = TRUE THEN 1 END)
      comment: "Number of clearances triggering a client notification obligation. Tracks regulatory disclosure compliance demand."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`conflict_search_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Search quality and throughput KPIs for conflict search executions: hit rates, fuzzy match usage, search accuracy, and screening coverage. Used by Conflicts Operations and Technology leadership to optimise search algorithms and ensure comprehensive screening."
  source: "`legal_ecm`.`conflict`.`search_execution`"
  dimensions:
    - name: "search_type"
      expr: search_type
      comment: "Type of conflict search performed (e.g., New Matter, Lateral Hire, Prospective Client) for segmented performance analysis."
    - name: "search_status"
      expr: search_status
      comment: "Execution status of the search (e.g., Completed, Failed, Pending) for operational monitoring."
    - name: "search_scope"
      expr: search_scope
      comment: "Scope of the search (e.g., Firm-Wide, Practice Area, Jurisdiction) enabling coverage analysis."
    - name: "fuzzy_match_applied"
      expr: fuzzy_match_applied
      comment: "Indicates whether fuzzy matching was applied, enabling comparison of exact vs. fuzzy search result quality."
    - name: "phonetic_variant_applied"
      expr: phonetic_variant_applied
      comment: "Indicates whether phonetic variant matching was applied, supporting analysis of name-variant screening coverage."
    - name: "lateral_hire_screen_flag"
      expr: lateral_hire_screen_flag
      comment: "Indicates whether the search was part of a lateral hire screening, enabling lateral integration risk monitoring."
    - name: "ethical_wall_consideration_flag"
      expr: ethical_wall_consideration_flag
      comment: "Indicates whether ethical wall considerations were factored into the search, tracking structural conflict control integration."
    - name: "search_algorithm_version"
      expr: search_algorithm_version
      comment: "Version of the search algorithm used, enabling A/B comparison of algorithm performance and accuracy over time."
    - name: "execution_month"
      expr: DATE_TRUNC('MONTH', search_execution_timestamp)
      comment: "Month of search execution, enabling monthly trend analysis of search volume and quality."
    - name: "jurisdiction_filter"
      expr: jurisdiction_filter
      comment: "Jurisdiction filter applied to the search, enabling geographic segmentation of conflict screening activity."
  measures:
    - name: "total_search_executions"
      expr: COUNT(1)
      comment: "Total number of conflict search executions. Baseline volume metric for screening throughput and capacity planning."
    - name: "failed_searches"
      expr: COUNT(CASE WHEN search_status = 'Failed' THEN 1 END)
      comment: "Number of search executions that failed. System reliability KPI — high failure rates indicate technology or data quality issues requiring immediate remediation."
    - name: "avg_fuzzy_match_threshold"
      expr: AVG(CAST(fuzzy_match_threshold AS DOUBLE))
      comment: "Average fuzzy match threshold applied across searches. Monitors algorithm sensitivity calibration — thresholds that are too low increase false positives; too high risks missed conflicts."
    - name: "total_fuzzy_match_threshold"
      expr: SUM(CAST(fuzzy_match_threshold AS DOUBLE))
      comment: "Sum of fuzzy match thresholds across all executions. Used alongside count to derive average threshold and detect configuration drift."
    - name: "fuzzy_match_searches"
      expr: COUNT(CASE WHEN fuzzy_match_applied = TRUE THEN 1 END)
      comment: "Number of searches where fuzzy matching was applied. Tracks adoption of enhanced name-matching techniques across the screening programme."
    - name: "phonetic_match_searches"
      expr: COUNT(CASE WHEN phonetic_variant_applied = TRUE THEN 1 END)
      comment: "Number of searches where phonetic variant matching was applied. Measures coverage of name-variant screening for transliterated or alias names."
    - name: "lateral_hire_screens"
      expr: COUNT(CASE WHEN lateral_hire_screen_flag = TRUE THEN 1 END)
      comment: "Number of searches conducted as part of lateral hire screening. Tracks the volume of lateral integration conflict checks."
    - name: "ethical_wall_consideration_searches"
      expr: COUNT(CASE WHEN ethical_wall_consideration_flag = TRUE THEN 1 END)
      comment: "Number of searches where ethical wall considerations were incorporated. Measures integration of structural conflict controls into the search process."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`conflict_search_hit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hit quality and resolution KPIs for conflict search hits: false positive rates, escalation rates, waiver conversion, match confidence, and LPP risk exposure. Used by Conflicts Partners and Risk leadership to assess screening accuracy and conflict resolution effectiveness."
  source: "`legal_ecm`.`conflict`.`search_hit`"
  dimensions:
    - name: "conflict_severity"
      expr: conflict_severity
      comment: "Severity of the conflict identified in the search hit (e.g., High, Medium, Low) for risk-tiered analysis."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the search hit (e.g., Resolved, Pending, Escalated) for pipeline management."
    - name: "match_method"
      expr: match_method
      comment: "Method used to generate the match (e.g., Exact, Fuzzy, Phonetic) enabling accuracy analysis by matching technique."
    - name: "relationship_type"
      expr: relationship_type
      comment: "Type of relationship identified in the hit (e.g., Adverse Party, Former Client, Affiliate) for conflict categorisation."
    - name: "matter_status"
      expr: matter_status
      comment: "Status of the matched matter (e.g., Open, Closed) enabling analysis of conflicts arising from active vs. historical matters."
    - name: "is_false_positive"
      expr: is_false_positive
      comment: "Indicates whether the hit was determined to be a false positive, used to measure search algorithm precision."
    - name: "escalated_to_partner"
      expr: escalated_to_partner
      comment: "Indicates whether the hit was escalated to a partner for review, tracking escalation rates and partner workload."
    - name: "lpp_risk_flag"
      expr: lpp_risk_flag
      comment: "Indicates whether the hit carries a legal professional privilege risk, a critical compliance and ethical risk signal."
    - name: "substantially_related_matter"
      expr: substantially_related_matter
      comment: "Indicates whether the matched matter is substantially related to the current engagement, a key legal standard for conflict determination."
    - name: "hit_created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the search hit was created, enabling monthly trend analysis of conflict hit volumes and resolution rates."
  measures:
    - name: "total_search_hits"
      expr: COUNT(1)
      comment: "Total number of conflict search hits generated. Baseline volume metric for conflict screening output and workload assessment."
    - name: "false_positive_hits"
      expr: COUNT(CASE WHEN is_false_positive = TRUE THEN 1 END)
      comment: "Number of hits determined to be false positives. High false positive rates indicate search algorithm over-sensitivity, wasting reviewer time and increasing costs."
    - name: "true_conflict_hits"
      expr: COUNT(CASE WHEN is_false_positive = FALSE THEN 1 END)
      comment: "Number of hits confirmed as genuine conflicts. Measures the true conflict burden on the firm's matter intake pipeline."
    - name: "escalated_hits"
      expr: COUNT(CASE WHEN escalated_to_partner = TRUE THEN 1 END)
      comment: "Number of hits escalated to a partner for review. Tracks partner-level conflict review workload and escalation rate."
    - name: "lpp_risk_hits"
      expr: COUNT(CASE WHEN lpp_risk_flag = TRUE THEN 1 END)
      comment: "Number of hits flagged with legal professional privilege risk. A critical compliance metric — LPP breaches carry severe regulatory and reputational consequences."
    - name: "substantially_related_hits"
      expr: COUNT(CASE WHEN substantially_related_matter = TRUE THEN 1 END)
      comment: "Number of hits involving substantially related matters. Directly informs conflict determination under professional conduct rules."
    - name: "waiver_required_hits"
      expr: COUNT(CASE WHEN requires_waiver = TRUE THEN 1 END)
      comment: "Number of hits requiring a client waiver to proceed. Tracks the volume of conflict situations requiring client consent management."
    - name: "waiver_obtained_hits"
      expr: COUNT(CASE WHEN waiver_obtained = TRUE THEN 1 END)
      comment: "Number of hits where a waiver was successfully obtained. Measures waiver conversion effectiveness for conflict resolution."
    - name: "avg_match_confidence_score"
      expr: AVG(CAST(match_confidence_score AS DOUBLE))
      comment: "Average match confidence score across all search hits. Monitors search algorithm calibration — low average confidence may indicate poor data quality or algorithm drift."
    - name: "high_severity_hits"
      expr: COUNT(CASE WHEN conflict_severity = 'High' THEN 1 END)
      comment: "Number of high-severity conflict hits. Executives monitor this to assess the firm's exposure to serious conflict-of-interest situations."
    - name: "ethical_wall_required_hits"
      expr: COUNT(CASE WHEN ethical_wall_required = TRUE THEN 1 END)
      comment: "Number of hits requiring an ethical wall as a mitigation measure. Drives ethical wall provisioning demand from the screening pipeline."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`conflict_waiver`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waiver lifecycle KPIs: execution rates, expiry management, scope limitations, revocation tracking, and LPP protection coverage. Used by General Counsel and Compliance leadership to govern client consent integrity and regulatory waiver obligations."
  source: "`legal_ecm`.`conflict`.`waiver`"
  dimensions:
    - name: "waiver_status"
      expr: waiver_status
      comment: "Current status of the waiver (e.g., Active, Expired, Revoked) for lifecycle pipeline management."
    - name: "conflict_type"
      expr: conflict_type
      comment: "Type of conflict the waiver addresses (e.g., Concurrent, Former Client, Imputed) for conflict categorisation."
    - name: "consent_form_type"
      expr: consent_form_type
      comment: "Type of consent form used for the waiver, enabling analysis of consent documentation standards across conflict types."
    - name: "is_scope_limited"
      expr: is_scope_limited
      comment: "Indicates whether the waiver is scope-limited, tracking the prevalence of partial vs. full conflict waivers."
    - name: "lpp_protected"
      expr: lpp_protected
      comment: "Indicates whether the waiver is protected by legal professional privilege, a critical compliance and confidentiality flag."
    - name: "ethical_wall_required"
      expr: ethical_wall_required
      comment: "Indicates whether an ethical wall was required alongside the waiver, tracking combined mitigation measure usage."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction governing the waiver, enabling geographic analysis of waiver requirements and regulatory obligations."
    - name: "execution_month"
      expr: DATE_TRUNC('MONTH', execution_date)
      comment: "Month the waiver was executed, enabling monthly trend analysis of waiver activity."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body governing the waiver obligation, enabling compliance analysis by regulatory authority."
  measures:
    - name: "total_waivers"
      expr: COUNT(1)
      comment: "Total number of conflict waivers issued. Baseline volume metric for client consent management and regulatory compliance tracking."
    - name: "active_waivers"
      expr: COUNT(CASE WHEN waiver_status = 'Active' THEN 1 END)
      comment: "Number of currently active waivers. Tracks the firm's live conflict consent obligations requiring ongoing management."
    - name: "expired_waivers"
      expr: COUNT(CASE WHEN waiver_status = 'Expired' THEN 1 END)
      comment: "Number of expired waivers. Expired waivers without renewal may expose the firm to unmanaged conflict risk."
    - name: "revoked_waivers"
      expr: COUNT(CASE WHEN waiver_status = 'Revoked' THEN 1 END)
      comment: "Number of revoked waivers. Revocations signal deteriorating client relationships or changed conflict circumstances requiring immediate matter review."
    - name: "scope_limited_waivers"
      expr: COUNT(CASE WHEN is_scope_limited = TRUE THEN 1 END)
      comment: "Number of scope-limited waivers. Tracks the prevalence of partial consent arrangements that carry residual conflict risk."
    - name: "lpp_protected_waivers"
      expr: COUNT(CASE WHEN lpp_protected = TRUE THEN 1 END)
      comment: "Number of waivers protected by legal professional privilege. Ensures LPP coverage is maintained across the waiver portfolio."
    - name: "ethical_wall_required_waivers"
      expr: COUNT(CASE WHEN ethical_wall_required = TRUE THEN 1 END)
      comment: "Number of waivers requiring an ethical wall as a supplementary control. Tracks combined mitigation measure demand."
    - name: "distinct_conflict_parties_waived"
      expr: COUNT(DISTINCT conflict_party_id)
      comment: "Number of distinct conflict parties covered by waivers. Measures the breadth of the firm's conflict consent portfolio across unique parties."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`conflict_ethical_wall`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ethical wall governance KPIs: active wall coverage, acknowledgment compliance, breach incident tracking, enforcement mechanism adoption, and review cycle adherence. Used by General Counsel, Risk, and IT leadership to govern information barrier integrity."
  source: "`legal_ecm`.`conflict`.`ethical_wall`"
  dimensions:
    - name: "wall_status"
      expr: wall_status
      comment: "Current status of the ethical wall (e.g., Active, Dissolved, Pending) for lifecycle pipeline management."
    - name: "triggering_reason"
      expr: triggering_reason
      comment: "Reason the ethical wall was triggered (e.g., Conflict of Interest, Lateral Hire, Regulatory Requirement) for root cause analysis."
    - name: "enforcement_mechanism"
      expr: enforcement_mechanism
      comment: "Mechanism used to enforce the wall (e.g., System, Manual, Hybrid) enabling analysis of enforcement technology adoption."
    - name: "system_enforcement_flag"
      expr: system_enforcement_flag
      comment: "Indicates whether system-level enforcement is active, tracking technology-enforced vs. manual information barriers."
    - name: "acknowledgment_required_flag"
      expr: acknowledgment_required_flag
      comment: "Indicates whether acknowledgment is required from wall members, tracking compliance obligation coverage."
    - name: "notification_sent_flag"
      expr: notification_sent_flag
      comment: "Indicates whether notification was sent to relevant parties, tracking communication compliance for wall establishment."
    - name: "review_frequency"
      expr: review_frequency
      comment: "Frequency at which the ethical wall is reviewed (e.g., Monthly, Quarterly, Annual) for review cycle compliance analysis."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the ethical wall became effective, enabling trend analysis of wall establishment activity."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority associated with the ethical wall obligation, enabling compliance analysis by regulator."
  measures:
    - name: "total_ethical_walls"
      expr: COUNT(1)
      comment: "Total number of ethical walls established. Baseline volume metric for information barrier governance and capacity planning."
    - name: "active_ethical_walls"
      expr: COUNT(CASE WHEN wall_status = 'Active' THEN 1 END)
      comment: "Number of currently active ethical walls. Tracks the firm's live information barrier obligations requiring ongoing enforcement and monitoring."
    - name: "dissolved_ethical_walls"
      expr: COUNT(CASE WHEN wall_status = 'Dissolved' THEN 1 END)
      comment: "Number of dissolved ethical walls. Tracks the lifecycle completion rate and dissolution governance of information barriers."
    - name: "avg_acknowledgment_completion_rate"
      expr: AVG(CAST(acknowledgment_completion_rate AS DOUBLE))
      comment: "Average acknowledgment completion rate across ethical walls. Measures compliance with wall notification obligations — low rates indicate governance gaps requiring escalation."
    - name: "system_enforced_walls"
      expr: COUNT(CASE WHEN system_enforcement_flag = TRUE THEN 1 END)
      comment: "Number of ethical walls with active system-level enforcement. Tracks technology adoption for information barrier controls, a key risk reduction indicator."
    - name: "walls_pending_notification"
      expr: COUNT(CASE WHEN notification_sent_flag = FALSE THEN 1 END)
      comment: "Number of ethical walls where notification has not yet been sent. Unnotified walls represent a compliance gap requiring immediate remediation."
    - name: "walls_requiring_acknowledgment"
      expr: COUNT(CASE WHEN acknowledgment_required_flag = TRUE THEN 1 END)
      comment: "Number of ethical walls requiring member acknowledgment. Drives acknowledgment compliance workload planning."
    - name: "total_acknowledgment_completion_rate"
      expr: SUM(CAST(acknowledgment_completion_rate AS DOUBLE))
      comment: "Sum of acknowledgment completion rates across all walls. Used alongside count to derive average and identify walls with low compliance."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`conflict_party`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Conflict party registry KPIs: sanctions screening coverage, PEP exposure, adverse media flags, KYC completion rates, and data residency compliance. Used by Compliance, AML, and Risk leadership to govern third-party risk and regulatory screening obligations."
  source: "`legal_ecm`.`conflict`.`conflict_party`"
  dimensions:
    - name: "entity_type"
      expr: entity_type
      comment: "Type of conflict party entity (e.g., Individual, Organisation, Government Body) for segmented risk analysis."
    - name: "party_status"
      expr: party_status
      comment: "Current status of the conflict party record (e.g., Active, Inactive, Archived) for registry hygiene monitoring."
    - name: "sanctions_screening_status"
      expr: sanctions_screening_status
      comment: "Current sanctions screening status (e.g., Clear, Hit, Pending) for regulatory compliance monitoring."
    - name: "pep_status"
      expr: pep_status
      comment: "Indicates whether the party is a Politically Exposed Person (PEP), a critical AML and enhanced due diligence flag."
    - name: "adverse_media_flag"
      expr: adverse_media_flag
      comment: "Indicates whether adverse media has been identified for the party, a key reputational and AML risk signal."
    - name: "gdpr_subject_flag"
      expr: gdpr_subject_flag
      comment: "Indicates whether the party is subject to GDPR data protection obligations, enabling data residency compliance tracking."
    - name: "ccpa_subject_flag"
      expr: ccpa_subject_flag
      comment: "Indicates whether the party is subject to CCPA data protection obligations, enabling US privacy compliance tracking."
    - name: "industry_sector"
      expr: industry_sector
      comment: "Industry sector of the conflict party, enabling sector-level conflict risk analysis."
    - name: "jurisdiction_of_incorporation"
      expr: jurisdiction_of_incorporation
      comment: "Jurisdiction of incorporation for the conflict party, enabling geographic risk segmentation."
    - name: "kyc_completion_month"
      expr: DATE_TRUNC('MONTH', kyc_completion_date)
      comment: "Month KYC was completed for the party, enabling trend analysis of KYC throughput and backlog."
  measures:
    - name: "total_conflict_parties"
      expr: COUNT(1)
      comment: "Total number of conflict party records in the registry. Baseline metric for registry size and screening programme scope."
    - name: "pep_parties"
      expr: COUNT(CASE WHEN pep_status = TRUE THEN 1 END)
      comment: "Number of conflict parties identified as Politically Exposed Persons. PEP exposure drives enhanced due diligence obligations and is a key AML risk indicator."
    - name: "adverse_media_parties"
      expr: COUNT(CASE WHEN adverse_media_flag = TRUE THEN 1 END)
      comment: "Number of conflict parties with adverse media flags. Tracks reputational risk exposure in the firm's client and counterparty universe."
    - name: "sanctions_hit_parties"
      expr: COUNT(CASE WHEN sanctions_screening_status = 'Hit' THEN 1 END)
      comment: "Number of conflict parties with a sanctions screening hit. A critical compliance metric — sanctions hits require immediate escalation and matter suspension."
    - name: "pending_sanctions_screening_parties"
      expr: COUNT(CASE WHEN sanctions_screening_status = 'Pending' THEN 1 END)
      comment: "Number of conflict parties with pending sanctions screening. Tracks the unscreened backlog representing unquantified regulatory risk."
    - name: "conflict_search_indexed_parties"
      expr: COUNT(CASE WHEN conflict_search_indexed_flag = TRUE THEN 1 END)
      comment: "Number of conflict parties indexed for conflict search. Measures the coverage of the conflict search index — unindexed parties represent screening blind spots."
    - name: "gdpr_subject_parties"
      expr: COUNT(CASE WHEN gdpr_subject_flag = TRUE THEN 1 END)
      comment: "Number of conflict parties subject to GDPR obligations. Drives data residency and privacy compliance workload planning."
    - name: "distinct_jurisdictions_represented"
      expr: COUNT(DISTINCT jurisdiction_of_incorporation)
      comment: "Number of distinct jurisdictions of incorporation across conflict parties. Measures the geographic complexity of the firm's conflict party universe and multi-jurisdictional compliance obligations."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`conflict_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Conflict rule governance KPIs: active rule coverage, waivability rates, automated check adoption, ethical wall requirements, and lateral hire applicability. Used by General Counsel and Compliance leadership to govern the firm's conflict rule framework and ensure regulatory alignment."
  source: "`legal_ecm`.`conflict`.`rule`"
  dimensions:
    - name: "rule_status"
      expr: rule_status
      comment: "Current status of the conflict rule (e.g., Active, Inactive, Superseded) for rule portfolio governance."
    - name: "conflict_type"
      expr: conflict_type
      comment: "Type of conflict the rule governs (e.g., Concurrent, Former Client, Imputed) for rule categorisation."
    - name: "rule_category"
      expr: rule_category
      comment: "Category of the conflict rule (e.g., Ethical, Regulatory, Contractual) enabling analysis by rule governance framework."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction to which the rule applies, enabling geographic analysis of conflict rule coverage and regulatory alignment."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the conflict rule (e.g., High, Medium, Low) for risk-tiered rule management."
    - name: "is_waivable"
      expr: is_waivable
      comment: "Indicates whether the conflict identified under this rule can be waived, enabling analysis of waivable vs. non-waivable conflict exposure."
    - name: "automated_check_enabled"
      expr: automated_check_enabled
      comment: "Indicates whether automated conflict checking is enabled for this rule, tracking technology adoption in the conflict screening programme."
    - name: "requires_ethical_wall"
      expr: requires_ethical_wall
      comment: "Indicates whether the rule mandates an ethical wall, enabling analysis of structural control requirements across the rule framework."
    - name: "applies_to_lateral_hires"
      expr: applies_to_lateral_hires
      comment: "Indicates whether the rule applies to lateral hire scenarios, tracking lateral integration conflict governance coverage."
    - name: "governing_body"
      expr: governing_body
      comment: "Regulatory or professional body governing the rule, enabling compliance analysis by regulatory authority."
  measures:
    - name: "total_conflict_rules"
      expr: COUNT(1)
      comment: "Total number of conflict rules in the rule framework. Baseline metric for rule portfolio size and governance complexity."
    - name: "active_conflict_rules"
      expr: COUNT(CASE WHEN rule_status = 'Active' THEN 1 END)
      comment: "Number of currently active conflict rules. Tracks the live rule framework governing the firm's conflict screening programme."
    - name: "waivable_rules"
      expr: COUNT(CASE WHEN is_waivable = TRUE THEN 1 END)
      comment: "Number of conflict rules where the identified conflict can be waived. Informs the firm's waiver programme scope and client consent strategy."
    - name: "automated_check_rules"
      expr: COUNT(CASE WHEN automated_check_enabled = TRUE THEN 1 END)
      comment: "Number of rules with automated conflict checking enabled. Measures technology adoption in the conflict screening programme — low automation rates indicate manual process risk."
    - name: "ethical_wall_mandatory_rules"
      expr: COUNT(CASE WHEN requires_ethical_wall = TRUE THEN 1 END)
      comment: "Number of rules mandating an ethical wall. Drives ethical wall provisioning requirements from the rule framework."
    - name: "lateral_hire_applicable_rules"
      expr: COUNT(CASE WHEN applies_to_lateral_hires = TRUE THEN 1 END)
      comment: "Number of rules applicable to lateral hire scenarios. Measures the governance coverage for lateral integration conflict risk."
    - name: "distinct_jurisdictions_covered"
      expr: COUNT(DISTINCT jurisdiction)
      comment: "Number of distinct jurisdictions covered by the conflict rule framework. Measures the geographic breadth of the firm's conflict governance and multi-jurisdictional regulatory alignment."
$$;