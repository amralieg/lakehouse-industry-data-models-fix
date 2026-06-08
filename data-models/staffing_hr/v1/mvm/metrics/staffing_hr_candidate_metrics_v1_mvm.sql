-- Metric views for domain: candidate | Business: Staffing Hr | Version: 1 | Generated on: 2026-05-02 22:27:45

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`candidate_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the candidate profile master entity. Tracks pipeline composition, sourcing channel effectiveness, work authorization risk, and candidate lifecycle stage distribution — core inputs for recruiter capacity planning and talent acquisition strategy."
  source: "`staffing_hr_ecm_v1`.`candidate`.`profile`"
  dimensions:
    - name: "candidate_status"
      expr: candidate_status
      comment: "Current lifecycle status of the candidate (e.g. Active, Inactive, Placed, Do Not Place). Primary segmentation for pipeline health analysis."
    - name: "candidate_type"
      expr: candidate_type
      comment: "Classification of the candidate (e.g. Temp, Perm, Contract, Temp-to-Perm). Drives placement strategy and billing model."
    - name: "source_channel_type"
      expr: source_channel_type
      comment: "High-level category of the sourcing channel (e.g. Job Board, Referral, Direct, Social). Used to evaluate channel ROI."
    - name: "source_channel_name"
      expr: source_channel_name
      comment: "Specific sourcing channel name (e.g. Indeed, LinkedIn, Employee Referral). Granular channel attribution for spend optimization."
    - name: "work_authorization_status"
      expr: work_authorization_status
      comment: "Candidate's work authorization classification (e.g. US Citizen, H1B, OPT). Critical for compliance and placement eligibility screening."
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status of the candidate (e.g. Employed, Unemployed, Contractor). Informs urgency and negotiation posture."
    - name: "country_code"
      expr: country_code
      comment: "Country of the candidate's address. Supports geographic workforce distribution analysis."
    - name: "state_province"
      expr: state_province
      comment: "State or province of the candidate's address. Enables regional talent supply analysis."
    - name: "sourcing_month"
      expr: DATE_TRUNC('MONTH', sourcing_date)
      comment: "Month in which the candidate was sourced. Used to track pipeline intake velocity over time."
    - name: "do_not_contact_flag"
      expr: do_not_contact_flag
      comment: "Indicates whether the candidate has opted out of contact. Used to filter reachable pipeline."
    - name: "utm_campaign"
      expr: utm_campaign
      comment: "UTM campaign tag associated with the candidate's sourcing event. Enables digital marketing attribution."
  measures:
    - name: "total_active_candidates"
      expr: COUNT(CASE WHEN candidate_status = 'Active' THEN profile_id END)
      comment: "Count of candidates currently in Active status. Core pipeline size KPI used by leadership to assess talent supply capacity."
    - name: "total_do_not_contact_candidates"
      expr: COUNT(CASE WHEN do_not_contact_flag = TRUE THEN profile_id END)
      comment: "Count of candidates flagged as Do Not Contact. Tracks reachability risk in the pipeline — a rising count signals degrading outreach capacity."
    - name: "avg_cost_per_source"
      expr: AVG(CAST(cost_per_source AS DOUBLE))
      comment: "Average cost incurred to source a candidate across all sourcing channels. Key efficiency KPI for talent acquisition spend optimization."
    - name: "total_sourcing_cost"
      expr: SUM(CAST(cost_per_source AS DOUBLE))
      comment: "Total investment in candidate sourcing. Used to benchmark sourcing spend against placement revenue and calculate cost-per-hire."
    - name: "visa_expiry_risk_count"
      expr: COUNT(CASE WHEN visa_expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND visa_expiry_date >= CURRENT_DATE() THEN profile_id END)
      comment: "Count of candidates whose visa expires within 90 days. Operational risk KPI — triggers proactive compliance and re-authorization actions."
    - name: "gdpr_consent_rate_numerator"
      expr: COUNT(CASE WHEN gdpr_consent_flag = TRUE THEN profile_id END)
      comment: "Count of candidates with GDPR consent obtained. Numerator for GDPR consent rate — divide by total_candidates to compute compliance rate."
    - name: "total_candidates"
      expr: COUNT(profile_id)
      comment: "Total count of candidate profiles. Denominator for consent rates, do-not-contact rates, and other pipeline composition ratios."
    - name: "ccpa_consent_rate_numerator"
      expr: COUNT(CASE WHEN ccpa_consent_flag = TRUE THEN profile_id END)
      comment: "Count of candidates with CCPA consent obtained. Numerator for CCPA compliance rate — critical for US-based regulatory reporting."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`candidate_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and throughput KPIs for candidate assessments including skills tests, drug screens, and reference checks. Informs screening effectiveness, pass/fail rates, and assessment program ROI."
  source: "`staffing_hr_ecm_v1`.`candidate`.`assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of assessment administered (e.g. Skills Test, Drug Screen, Background Check, Reference Check). Primary segmentation for assessment program analysis."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (e.g. Pending, Completed, Expired, Adverse Action). Used to track assessment pipeline throughput."
    - name: "pass_fail_result"
      expr: pass_fail_result
      comment: "Binary outcome of the assessment (Pass/Fail). Core dimension for screening quality analysis."
    - name: "skill_category"
      expr: skill_category
      comment: "Skill category being assessed (e.g. Technical, Clinical, Administrative). Enables skill-specific pass rate benchmarking."
    - name: "delivery_channel"
      expr: delivery_channel
      comment: "Channel through which the assessment was delivered (e.g. Online, In-Person, Proctored). Informs channel effectiveness and cost analysis."
    - name: "provider_name"
      expr: provider_name
      comment: "Name of the assessment provider or vendor. Used to evaluate vendor performance and contract value."
    - name: "competency_level"
      expr: competency_level
      comment: "Competency level measured by the assessment (e.g. Entry, Intermediate, Expert). Supports workforce quality segmentation."
    - name: "administered_month"
      expr: DATE_TRUNC('MONTH', administered_date)
      comment: "Month the assessment was administered. Tracks assessment volume trends over time."
    - name: "adverse_action_flag"
      expr: adverse_action_flag
      comment: "Indicates whether an adverse action was triggered by this assessment result. Flags compliance-sensitive outcomes."
    - name: "is_proctored"
      expr: is_proctored
      comment: "Whether the assessment was proctored. Differentiates high-integrity assessments from self-administered ones."
  measures:
    - name: "avg_normalized_score"
      expr: AVG(CAST(normalized_score AS DOUBLE))
      comment: "Average normalized assessment score across candidates. Benchmarks overall candidate quality and screening bar effectiveness."
    - name: "avg_percentile_rank"
      expr: AVG(CAST(percentile_rank AS DOUBLE))
      comment: "Average percentile rank of assessed candidates. Indicates how the candidate pool compares to the broader assessment population."
    - name: "pass_count"
      expr: COUNT(CASE WHEN pass_fail_result = 'Pass' THEN assessment_id END)
      comment: "Count of assessments with a passing result. Numerator for pass rate calculation — tracks screening yield."
    - name: "total_assessments_completed"
      expr: COUNT(CASE WHEN assessment_status = 'Completed' THEN assessment_id END)
      comment: "Count of completed assessments. Denominator for pass rate and throughput KPIs — measures screening program volume."
    - name: "adverse_action_count"
      expr: COUNT(CASE WHEN adverse_action_flag = TRUE THEN assessment_id END)
      comment: "Count of assessments that triggered an adverse action. Compliance risk KPI — elevated counts require legal and HR review."
    - name: "avg_raw_score"
      expr: AVG(CAST(raw_score AS DOUBLE))
      comment: "Average raw score on assessments. Provides an unscaled view of candidate performance for provider benchmarking."
    - name: "consent_obtained_count"
      expr: COUNT(CASE WHEN consent_obtained = TRUE THEN assessment_id END)
      comment: "Count of assessments where candidate consent was properly obtained. Compliance completeness KPI — gaps expose legal risk."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`candidate_availability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent supply and redeployment readiness KPIs. Tracks available candidate pipeline depth, pay rate expectations, and redeployment opportunity — critical inputs for fulfillment capacity planning and bench management."
  source: "`staffing_hr_ecm_v1`.`candidate`.`availability`"
  dimensions:
    - name: "availability_status"
      expr: availability_status
      comment: "Current availability status of the candidate (e.g. Available, Placed, On Assignment, Unavailable). Primary dimension for supply pipeline segmentation."
    - name: "preferred_employment_type"
      expr: preferred_employment_type
      comment: "Candidate's preferred employment type (e.g. Full-Time, Part-Time, Contract, Temp). Aligns supply to demand by engagement type."
    - name: "preferred_work_arrangement"
      expr: preferred_work_arrangement
      comment: "Candidate's preferred work arrangement (e.g. Remote, Hybrid, On-Site). Critical for matching to client requirements in post-pandemic workforce."
    - name: "geo_state"
      expr: geo_state
      comment: "State where the candidate is available to work. Enables geographic supply-demand gap analysis."
    - name: "pay_rate_type"
      expr: pay_rate_type
      comment: "Type of pay rate the candidate expects (e.g. Hourly, Salary, Daily). Informs rate negotiation and margin modeling."
    - name: "redeployment_candidate"
      expr: redeployment_candidate
      comment: "Indicates whether the candidate is flagged for redeployment. Tracks bench pool size for proactive placement."
    - name: "do_not_place_flag"
      expr: do_not_place_flag
      comment: "Indicates whether the candidate is blocked from placement. Tracks compliance-restricted supply."
    - name: "sourcing_channel"
      expr: sourcing_channel
      comment: "Channel through which the candidate's availability was sourced. Supports channel effectiveness analysis."
    - name: "available_start_month"
      expr: DATE_TRUNC('MONTH', available_start_date)
      comment: "Month the candidate becomes available. Used to forecast near-term supply pipeline."
    - name: "willing_to_relocate"
      expr: willing_to_relocate
      comment: "Whether the candidate is willing to relocate. Expands effective geographic supply for hard-to-fill roles."
  measures:
    - name: "available_candidate_pipeline"
      expr: COUNT(CASE WHEN availability_status = 'Available' AND do_not_place_flag = FALSE THEN availability_id END)
      comment: "Count of candidates who are available and not blocked from placement. Core supply pipeline KPI for fulfillment capacity planning."
    - name: "redeployment_ready_count"
      expr: COUNT(CASE WHEN redeployment_candidate = TRUE AND availability_status = 'Available' THEN availability_id END)
      comment: "Count of candidates flagged for redeployment who are currently available. Measures bench pool depth — a key cost-avoidance and speed-to-fill lever."
    - name: "avg_desired_pay_rate_max"
      expr: AVG(CAST(desired_pay_rate_max AS DOUBLE))
      comment: "Average maximum desired pay rate across available candidates. Benchmarks candidate pay expectations against client bill rate budgets."
    - name: "avg_desired_pay_rate_min"
      expr: AVG(CAST(desired_pay_rate_min AS DOUBLE))
      comment: "Average minimum desired pay rate across available candidates. Establishes the floor for pay rate negotiations and margin modeling."
    - name: "do_not_place_count"
      expr: COUNT(CASE WHEN do_not_place_flag = TRUE THEN availability_id END)
      comment: "Count of candidates blocked from placement. Tracks compliance-restricted supply — a rising count signals pipeline quality degradation."
    - name: "open_to_temp_to_perm_count"
      expr: COUNT(CASE WHEN open_to_temp_to_perm = TRUE THEN availability_id END)
      comment: "Count of candidates open to temp-to-perm conversion. Quantifies conversion pipeline depth — directly tied to perm placement fee revenue."
    - name: "willing_to_relocate_count"
      expr: COUNT(CASE WHEN willing_to_relocate = TRUE THEN availability_id END)
      comment: "Count of candidates willing to relocate. Measures geographic flexibility of the supply pool for hard-to-fill or remote-market roles."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`candidate_skill`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce skill inventory and quality KPIs. Tracks verified skill depth, proficiency distribution, pay rate premiums, and market demand alignment — essential for talent matching, pricing strategy, and workforce capability planning."
  source: "`staffing_hr_ecm_v1`.`candidate`.`skill`"
  dimensions:
    - name: "skill_category"
      expr: skill_category
      comment: "High-level category of the skill (e.g. Technical, Clinical, Administrative, Trades). Primary segmentation for workforce capability analysis."
    - name: "skill_name"
      expr: skill_name
      comment: "Specific skill name. Enables granular skill supply analysis and matching to job order requirements."
    - name: "proficiency_level"
      expr: proficiency_level
      comment: "Self-reported or assessed proficiency level (e.g. Beginner, Intermediate, Expert). Informs candidate quality tiering."
    - name: "is_verified"
      expr: is_verified
      comment: "Whether the skill has been independently verified. Differentiates high-confidence skills from self-reported ones."
    - name: "is_primary"
      expr: is_primary
      comment: "Whether this is the candidate's primary skill. Focuses analysis on core competencies driving placement decisions."
    - name: "skill_status"
      expr: skill_status
      comment: "Current status of the skill record (e.g. Active, Expired, Superseded). Filters to current, actionable skill inventory."
    - name: "subcategory"
      expr: subcategory
      comment: "Sub-category of the skill for finer-grained capability segmentation."
    - name: "redeployment_eligible"
      expr: redeployment_eligible
      comment: "Whether this skill qualifies the candidate for redeployment. Links skill inventory to bench management strategy."
    - name: "taxonomy_source"
      expr: taxonomy_source
      comment: "Source taxonomy used to classify the skill (e.g. O*NET, ESCO, Proprietary). Ensures comparability across skill records."
  measures:
    - name: "verified_skill_count"
      expr: COUNT(CASE WHEN is_verified = TRUE THEN skill_id END)
      comment: "Count of independently verified skills across the candidate pool. Measures the depth of high-confidence, placeable talent inventory."
    - name: "unique_candidates_with_skill"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of distinct candidates possessing at least one skill record. Measures breadth of the skilled talent pool."
    - name: "avg_proficiency_score"
      expr: AVG(CAST(proficiency_score AS DOUBLE))
      comment: "Average proficiency score across all skill records. Benchmarks overall workforce quality and skill depth."
    - name: "avg_pay_rate_premium"
      expr: AVG(CAST(pay_rate_premium AS DOUBLE))
      comment: "Average pay rate premium associated with skills. Informs pricing strategy — high-premium skills command higher bill rates and margins."
    - name: "avg_billable_rate_premium"
      expr: AVG(CAST(billable_rate_premium AS DOUBLE))
      comment: "Average billable rate premium associated with skills. Directly informs client pricing and gross margin optimization."
    - name: "avg_demand_index"
      expr: AVG(CAST(demand_index AS DOUBLE))
      comment: "Average market demand index across skills in the candidate pool. Measures alignment of talent supply to market demand — a strategic workforce planning KPI."
    - name: "avg_years_of_experience"
      expr: AVG(CAST(years_of_experience AS DOUBLE))
      comment: "Average years of experience across skill records. Benchmarks seniority depth of the talent pool for role-level matching."
    - name: "total_pay_rate_premium"
      expr: SUM(CAST(pay_rate_premium AS DOUBLE))
      comment: "Total pay rate premium across all skill records. Aggregated premium exposure used in workforce cost modeling."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`candidate_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Candidate lifecycle velocity and pipeline conversion KPIs. Tracks status transitions, fall-off rates, DNP events, and pipeline stage throughput — the primary operational dashboard for recruiter performance and pipeline health management."
  source: "`staffing_hr_ecm_v1`.`candidate`.`status_history`"
  dimensions:
    - name: "new_status"
      expr: new_status
      comment: "The status the candidate transitioned into. Primary dimension for pipeline stage distribution analysis."
    - name: "prior_status"
      expr: prior_status
      comment: "The status the candidate transitioned from. Enables funnel conversion analysis between pipeline stages."
    - name: "placement_type"
      expr: placement_type
      comment: "Type of placement associated with the status event (e.g. Temp, Perm, Contract). Segments pipeline by engagement model."
    - name: "worker_type"
      expr: worker_type
      comment: "Classification of the worker (e.g. W2, 1099, Corp-to-Corp). Informs compliance and payroll routing."
    - name: "transition_reason_code"
      expr: transition_reason_code
      comment: "Coded reason for the status transition. Enables root-cause analysis of pipeline exits and fall-offs."
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason the candidate was rejected at this stage. Identifies systemic screening or matching issues."
    - name: "is_dnp"
      expr: is_dnp
      comment: "Whether this status event represents a Do Not Place designation. Tracks compliance-driven pipeline removals."
    - name: "is_fall_off"
      expr: is_fall_off
      comment: "Whether this status event represents a placement fall-off. Fall-offs are high-cost events requiring immediate management attention."
    - name: "division_code"
      expr: division_code
      comment: "Business division associated with the status event. Enables divisional pipeline performance benchmarking."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the status transition became effective. Tracks pipeline velocity trends over time."
    - name: "redeployment_eligible"
      expr: redeployment_eligible
      comment: "Whether the candidate is eligible for redeployment at this status point. Tracks bench pipeline creation from assignment completions."
  measures:
    - name: "total_status_transitions"
      expr: COUNT(status_history_id)
      comment: "Total count of candidate status transitions. Measures pipeline activity volume — a proxy for recruiter throughput and funnel velocity."
    - name: "fall_off_count"
      expr: COUNT(CASE WHEN is_fall_off = TRUE THEN status_history_id END)
      comment: "Count of placement fall-off events. Fall-offs represent lost revenue and client satisfaction risk — a critical operational KPI."
    - name: "dnp_designation_count"
      expr: COUNT(CASE WHEN is_dnp = TRUE THEN status_history_id END)
      comment: "Count of Do Not Place designations issued. Tracks compliance-driven pipeline attrition and workforce quality risk."
    - name: "compliance_hold_count"
      expr: COUNT(CASE WHEN compliance_hold = TRUE THEN status_history_id END)
      comment: "Count of status events where a compliance hold was applied. Measures compliance-driven placement delays — directly impacts time-to-fill and revenue."
    - name: "redeployment_eligible_exits"
      expr: COUNT(CASE WHEN redeployment_eligible = TRUE THEN status_history_id END)
      comment: "Count of status transitions where the candidate was flagged as redeployment eligible. Measures bench pool replenishment rate from assignment completions."
    - name: "unique_candidates_transitioned"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of distinct candidates who experienced a status transition. Measures active pipeline breadth and recruiter engagement coverage."
    - name: "correction_event_count"
      expr: COUNT(CASE WHEN is_correction = TRUE THEN status_history_id END)
      comment: "Count of status history records that are corrections to prior entries. Elevated correction rates signal data quality or process compliance issues."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`candidate_right_to_represent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Right-to-represent (RTR) compliance and exclusivity KPIs. Tracks RTR grant rates, expiration risk, revocation events, and exclusivity coverage — essential for legal compliance, vendor management, and candidate ownership governance."
  source: "`staffing_hr_ecm_v1`.`candidate`.`right_to_represent`"
  dimensions:
    - name: "rtr_status"
      expr: rtr_status
      comment: "Current status of the right-to-represent agreement (e.g. Active, Expired, Revoked, Pending). Primary dimension for RTR compliance monitoring."
    - name: "placement_type"
      expr: placement_type
      comment: "Type of placement the RTR covers (e.g. Temp, Perm, Contract). Segments RTR coverage by engagement model."
    - name: "grant_method"
      expr: grant_method
      comment: "Method by which the RTR was granted (e.g. Email, Verbal, Digital Signature). Informs consent quality and audit defensibility."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the RTR grants exclusive representation rights. Exclusivity is a competitive differentiator and revenue protection mechanism."
    - name: "is_revoked"
      expr: is_revoked
      comment: "Whether the RTR has been revoked. Revocations signal candidate or client relationship issues requiring management attention."
    - name: "rtr_scope"
      expr: rtr_scope
      comment: "Scope of the right-to-represent (e.g. Single Order, Client-Wide, Program-Wide). Determines breadth of candidate ownership."
    - name: "ofccp_audit_ready"
      expr: ofccp_audit_ready
      comment: "Whether the RTR record is flagged as OFCCP audit-ready. Tracks regulatory compliance readiness."
    - name: "grant_month"
      expr: DATE_TRUNC('MONTH', grant_timestamp)
      comment: "Month the RTR was granted. Tracks RTR issuance velocity and pipeline coverage trends."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the RTR is under dispute. Disputed RTRs represent legal and relationship risk requiring escalation."
  measures:
    - name: "active_rtr_count"
      expr: COUNT(CASE WHEN rtr_status = 'Active' AND is_revoked = FALSE THEN right_to_represent_id END)
      comment: "Count of currently active, non-revoked RTR agreements. Measures the breadth of legally protected candidate representation — a core compliance KPI."
    - name: "expiring_rtr_30_days"
      expr: COUNT(CASE WHEN expiration_date <= DATE_ADD(CURRENT_DATE(), 30) AND expiration_date >= CURRENT_DATE() AND is_revoked = FALSE THEN right_to_represent_id END)
      comment: "Count of RTR agreements expiring within 30 days. Proactive risk KPI — expired RTRs expose the firm to candidate poaching and legal disputes."
    - name: "revocation_count"
      expr: COUNT(CASE WHEN is_revoked = TRUE THEN right_to_represent_id END)
      comment: "Count of revoked RTR agreements. Elevated revocations signal candidate dissatisfaction or competitive displacement — requires strategic response."
    - name: "exclusive_rtr_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE AND is_revoked = FALSE THEN right_to_represent_id END)
      comment: "Count of active exclusive RTR agreements. Measures the firm's exclusive candidate ownership — directly protects placement revenue from competitor poaching."
    - name: "disputed_rtr_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN right_to_represent_id END)
      comment: "Count of RTR agreements currently under dispute. Legal risk KPI — each dispute represents potential revenue loss and client relationship damage."
    - name: "ofccp_audit_ready_count"
      expr: COUNT(CASE WHEN ofccp_audit_ready = TRUE THEN right_to_represent_id END)
      comment: "Count of RTR records flagged as OFCCP audit-ready. Measures regulatory compliance posture — gaps expose the firm to OFCCP enforcement risk."
    - name: "unique_candidates_represented"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of distinct candidates covered by at least one RTR agreement. Measures the breadth of the firm's legally represented talent pool."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`candidate_pay_rate_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pay rate agreement KPIs covering rate levels, negotiation outcomes, prevailing wage compliance, and agreement lifecycle. Directly informs margin management, pricing strategy, and wage compliance governance."
  source: "`staffing_hr_ecm_v1`.`candidate`.`pay_rate_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the pay rate agreement (e.g. Active, Expired, Pending Approval). Primary dimension for agreement lifecycle monitoring."
    - name: "engagement_type"
      expr: engagement_type
      comment: "Type of engagement covered by the agreement (e.g. Temp, Perm, Contract, SOW). Segments rate analysis by business model."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the agreement (e.g. Approved, Pending, Rejected). Tracks rate governance compliance."
    - name: "flsa_exemption_status"
      expr: flsa_exemption_status
      comment: "FLSA exemption classification (e.g. Exempt, Non-Exempt). Critical for overtime compliance and wage-hour risk management."
    - name: "prevailing_wage_flag"
      expr: prevailing_wage_flag
      comment: "Whether the agreement is subject to prevailing wage requirements. Flags government contract compliance obligations."
    - name: "work_state_code"
      expr: work_state_code
      comment: "State where the work is performed. Enables state-level wage compliance and rate benchmarking analysis."
    - name: "rate_change_reason"
      expr: rate_change_reason
      comment: "Reason for a rate change on the agreement. Tracks drivers of rate adjustments for pricing governance."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the pay rate agreement became effective. Tracks rate agreement issuance trends over time."
    - name: "is_rate_negotiable"
      expr: is_rate_negotiable
      comment: "Whether the rate is open to negotiation. Segments agreements by pricing flexibility for margin optimization analysis."
  measures:
    - name: "avg_prevailing_wage_rate"
      expr: AVG(CASE WHEN prevailing_wage_flag = TRUE THEN CAST(prevailing_wage_rate AS DOUBLE) END)
      comment: "Average prevailing wage rate on agreements subject to prevailing wage requirements. Compliance benchmarking KPI for government contract workforce."
    - name: "avg_burden_rate_pct"
      expr: AVG(CAST(burden_rate_pct AS DOUBLE))
      comment: "Average burden rate percentage across pay rate agreements. Directly impacts gross margin — a key input for pricing and profitability modeling."
    - name: "avg_ot_threshold_hours"
      expr: AVG(CAST(ot_threshold_hours AS DOUBLE))
      comment: "Average overtime threshold hours across agreements. Informs workforce scheduling and overtime cost exposure management."
    - name: "avg_min_guaranteed_hours"
      expr: AVG(CAST(min_guaranteed_hours AS DOUBLE))
      comment: "Average minimum guaranteed hours committed across agreements. Measures fixed labor cost exposure and capacity utilization floor."
    - name: "avg_max_weekly_hours"
      expr: AVG(CAST(max_weekly_hours AS DOUBLE))
      comment: "Average maximum weekly hours allowed under agreements. Informs workforce capacity planning and overtime risk modeling."
    - name: "prevailing_wage_agreement_count"
      expr: COUNT(CASE WHEN prevailing_wage_flag = TRUE THEN pay_rate_agreement_id END)
      comment: "Count of agreements subject to prevailing wage requirements. Measures government contract compliance exposure volume."
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN approval_status = 'Pending' THEN pay_rate_agreement_id END)
      comment: "Count of pay rate agreements awaiting approval. Operational bottleneck KPI — pending agreements delay placements and revenue recognition."
    - name: "total_active_agreements"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN pay_rate_agreement_id END)
      comment: "Count of currently active pay rate agreements. Measures the volume of live rate commitments under management."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`candidate_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Candidate engagement and recruiter outreach effectiveness KPIs. Tracks interaction volume, response rates, SLA compliance, NPS eligibility, and sentiment — core metrics for recruiter productivity and candidate experience management."
  source: "`staffing_hr_ecm_v1`.`candidate`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of interaction (e.g. Phone Call, Email, Interview, Text). Primary segmentation for engagement channel analysis."
    - name: "interaction_status"
      expr: interaction_status
      comment: "Current status of the interaction (e.g. Completed, Scheduled, No Response). Tracks engagement pipeline throughput."
    - name: "channel"
      expr: channel
      comment: "Communication channel used for the interaction (e.g. Phone, Email, SMS, Video). Informs channel effectiveness and preference analysis."
    - name: "direction"
      expr: direction
      comment: "Direction of the interaction (Inbound/Outbound). Differentiates recruiter-initiated outreach from candidate-initiated contact."
    - name: "candidate_lifecycle_stage"
      expr: candidate_lifecycle_stage
      comment: "Lifecycle stage of the candidate at the time of interaction. Enables stage-specific engagement analysis."
    - name: "sentiment_tag"
      expr: sentiment_tag
      comment: "Sentiment classification of the interaction (e.g. Positive, Neutral, Negative). Tracks candidate experience quality."
    - name: "is_automated"
      expr: is_automated
      comment: "Whether the interaction was automated (e.g. drip campaign, chatbot). Differentiates human-touch from automated engagement."
    - name: "sla_met"
      expr: sla_met
      comment: "Whether the interaction met the defined SLA response target. Tracks recruiter responsiveness compliance."
    - name: "interaction_month"
      expr: DATE_TRUNC('MONTH', interaction_timestamp)
      comment: "Month the interaction occurred. Tracks engagement volume and velocity trends over time."
    - name: "sourcing_channel"
      expr: sourcing_channel
      comment: "Sourcing channel associated with the interaction. Links engagement activity back to sourcing attribution."
  measures:
    - name: "total_interactions"
      expr: COUNT(interaction_id)
      comment: "Total count of candidate interactions. Measures recruiter engagement activity volume — a leading indicator of pipeline throughput."
    - name: "response_received_count"
      expr: COUNT(CASE WHEN response_received = TRUE THEN interaction_id END)
      comment: "Count of interactions where a response was received. Numerator for response rate — measures outreach effectiveness."
    - name: "sla_met_count"
      expr: COUNT(CASE WHEN sla_met = TRUE THEN interaction_id END)
      comment: "Count of interactions that met the SLA response target. Numerator for SLA compliance rate — tracks recruiter responsiveness quality."
    - name: "total_sla_eligible_interactions"
      expr: COUNT(CASE WHEN sla_met IS NOT NULL THEN interaction_id END)
      comment: "Count of interactions with a defined SLA target. Denominator for SLA compliance rate calculation."
    - name: "nps_survey_sent_count"
      expr: COUNT(CASE WHEN nps_survey_sent = TRUE THEN interaction_id END)
      comment: "Count of interactions where an NPS survey was sent. Tracks candidate experience measurement coverage."
    - name: "do_not_contact_breach_count"
      expr: COUNT(CASE WHEN do_not_contact = TRUE THEN interaction_id END)
      comment: "Count of interactions logged against candidates flagged as Do Not Contact. Compliance risk KPI — each breach represents a potential regulatory violation."
    - name: "unique_candidates_engaged"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of distinct candidates who received at least one interaction. Measures recruiter outreach breadth across the pipeline."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`candidate_talent_pool_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent pool health and engagement KPIs. Tracks membership composition, redeployment pipeline depth, engagement quality, and pay rate expectations within talent pools — critical for proactive fulfillment and bench management strategy."
  source: "`staffing_hr_ecm_v1`.`candidate`.`talent_pool_membership`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current status of the talent pool membership (e.g. Active, Exited, Pending). Primary dimension for pool health analysis."
    - name: "membership_type"
      expr: membership_type
      comment: "Type of membership in the talent pool (e.g. Redeployment, Proactive, Client-Specific). Segments pool by strategic purpose."
    - name: "primary_skill_category"
      expr: primary_skill_category
      comment: "Primary skill category of the pool member. Enables skill-based supply analysis within talent pools."
    - name: "worker_classification"
      expr: worker_classification
      comment: "Worker classification of the pool member (e.g. W2, 1099, Corp-to-Corp). Informs compliance and payroll routing for pool placements."
    - name: "preferred_work_type"
      expr: preferred_work_type
      comment: "Preferred work type of the pool member (e.g. Full-Time, Part-Time, Contract). Aligns pool supply to demand by engagement model."
    - name: "is_redeployment_candidate"
      expr: is_redeployment_candidate
      comment: "Whether the member is flagged for redeployment. Core dimension for bench pool management analysis."
    - name: "priority_tier"
      expr: priority_tier
      comment: "Priority tier of the pool member (e.g. Tier 1, Tier 2, Tier 3). Drives outreach sequencing and placement prioritization."
    - name: "exit_reason"
      expr: exit_reason
      comment: "Reason the candidate exited the talent pool. Identifies systemic pool attrition drivers."
    - name: "added_month"
      expr: DATE_TRUNC('MONTH', added_date)
      comment: "Month the candidate was added to the talent pool. Tracks pool intake velocity over time."
    - name: "i9_verified"
      expr: i9_verified
      comment: "Whether the pool member's I-9 has been verified. Tracks work authorization compliance readiness for immediate deployment."
  measures:
    - name: "active_pool_members"
      expr: COUNT(CASE WHEN membership_status = 'Active' THEN talent_pool_membership_id END)
      comment: "Count of active talent pool members. Core pool health KPI — measures deployable talent supply under active management."
    - name: "redeployment_pipeline_count"
      expr: COUNT(CASE WHEN is_redeployment_candidate = TRUE AND membership_status = 'Active' THEN talent_pool_membership_id END)
      comment: "Count of active pool members flagged for redeployment. Measures bench pipeline depth — directly impacts speed-to-fill and reduces sourcing cost."
    - name: "i9_verified_ready_count"
      expr: COUNT(CASE WHEN i9_verified = TRUE AND membership_status = 'Active' THEN talent_pool_membership_id END)
      comment: "Count of active pool members with verified I-9 documentation. Measures immediately deployable, compliance-cleared talent supply."
    - name: "avg_pay_rate_max"
      expr: AVG(CAST(pay_rate_max AS DOUBLE))
      comment: "Average maximum pay rate expectation across pool members. Benchmarks pool pay expectations against client bill rate budgets for margin planning."
    - name: "avg_pay_rate_min"
      expr: AVG(CAST(pay_rate_min AS DOUBLE))
      comment: "Average minimum pay rate expectation across pool members. Establishes the pay rate floor for pool-based placement negotiations."
    - name: "willing_to_relocate_count"
      expr: COUNT(CASE WHEN is_willing_to_relocate = TRUE AND membership_status = 'Active' THEN talent_pool_membership_id END)
      comment: "Count of active pool members willing to relocate. Measures geographic flexibility of the pool for cross-market fulfillment."
    - name: "unique_pools_with_active_members"
      expr: COUNT(DISTINCT CASE WHEN membership_status = 'Active' THEN talent_pool_id END)
      comment: "Count of distinct talent pools with at least one active member. Measures breadth of active talent pool coverage across the business."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`candidate_resume`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Resume quality, parsing effectiveness, and talent intelligence KPIs. Tracks parse success rates, quality scores, experience depth, and searchability — informs ATS data quality governance and candidate matching capability."
  source: "`staffing_hr_ecm_v1`.`candidate`.`resume`"
  dimensions:
    - name: "parse_status"
      expr: parse_status
      comment: "Status of the resume parsing process (e.g. Parsed, Failed, Pending). Primary dimension for ATS data quality analysis."
    - name: "file_format"
      expr: file_format
      comment: "File format of the resume (e.g. PDF, DOCX, TXT). Informs parsing success rate analysis by format."
    - name: "upload_source"
      expr: upload_source
      comment: "Source through which the resume was uploaded (e.g. Job Board, Direct Upload, Email). Tracks sourcing channel data quality."
    - name: "primary_skill_category"
      expr: primary_skill_category
      comment: "Primary skill category parsed from the resume. Enables skill-based talent pool analysis."
    - name: "highest_education_level"
      expr: highest_education_level
      comment: "Highest education level identified in the resume. Supports candidate qualification segmentation."
    - name: "is_active_version"
      expr: is_active_version
      comment: "Whether this is the current active version of the candidate's resume. Filters analysis to current, actionable resume records."
    - name: "is_searchable"
      expr: is_searchable
      comment: "Whether the resume is indexed and searchable in the ATS. Tracks talent discoverability — non-searchable resumes are invisible to recruiters."
    - name: "parsing_engine"
      expr: parsing_engine
      comment: "Resume parsing engine used (e.g. Sovren, Textkernel, Bullhorn). Enables vendor performance benchmarking."
    - name: "upload_month"
      expr: DATE_TRUNC('MONTH', upload_timestamp)
      comment: "Month the resume was uploaded. Tracks resume intake volume trends over time."
  measures:
    - name: "parsed_resume_count"
      expr: COUNT(CASE WHEN is_parsed = TRUE THEN resume_id END)
      comment: "Count of successfully parsed resumes. Numerator for parse success rate — measures ATS data enrichment coverage."
    - name: "total_active_resumes"
      expr: COUNT(CASE WHEN is_active_version = TRUE THEN resume_id END)
      comment: "Count of active resume versions. Measures the current, actionable talent intelligence inventory in the ATS."
    - name: "searchable_resume_count"
      expr: COUNT(CASE WHEN is_searchable = TRUE AND is_active_version = TRUE THEN resume_id END)
      comment: "Count of active resumes that are searchable in the ATS. Measures recruiter-accessible talent inventory — non-searchable resumes represent hidden supply."
    - name: "avg_parse_confidence_score"
      expr: AVG(CAST(parse_confidence_score AS DOUBLE))
      comment: "Average confidence score of the resume parsing engine. Benchmarks ATS data quality — low scores indicate unreliable talent intelligence."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average resume quality score. Measures overall talent intelligence richness — directly impacts matching accuracy and placement speed."
    - name: "avg_years_of_experience"
      expr: AVG(CAST(years_of_experience AS DOUBLE))
      comment: "Average years of experience parsed from resumes. Benchmarks seniority depth of the candidate pool for role-level matching."
    - name: "candidate_consent_rate_numerator"
      expr: COUNT(CASE WHEN candidate_consent_flag = TRUE THEN resume_id END)
      comment: "Count of resumes with candidate consent obtained for data processing. Numerator for consent compliance rate — gaps expose GDPR/CCPA risk."
$$;