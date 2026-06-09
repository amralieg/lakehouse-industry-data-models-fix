-- Metric views for domain: intake | Business: Legal | Version: 1 | Generated on: 2026-05-07 11:54:14

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`intake_engagement_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic engagement pipeline metrics tracking opportunity value, conversion probability, and stage progression for business development steering"
  source: "`legal_ecm`.`intake`.`engagement_opportunity`"
  dimensions:
    - name: "opportunity_stage"
      expr: opportunity_stage
      comment: "Current stage in the engagement pipeline (e.g., Qualified, Proposal, Negotiation, Won, Lost)"
    - name: "matter_type"
      expr: matter_type
      comment: "Type of legal matter for the engagement opportunity"
    - name: "industry_sector"
      expr: industry_sector
      comment: "Industry sector of the prospective client"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction for the engagement"
    - name: "lead_source"
      expr: lead_source
      comment: "Origin of the engagement opportunity (e.g., Referral, RFP, Direct, Marketing)"
    - name: "conflict_check_status"
      expr: conflict_check_status
      comment: "Status of conflict check process (e.g., Pending, Cleared, Issues Identified)"
    - name: "kyc_status"
      expr: kyc_status
      comment: "Know Your Client screening status"
    - name: "afa_type"
      expr: afa_type
      comment: "Alternative fee arrangement type if applicable"
    - name: "expected_close_year"
      expr: YEAR(expected_close_date)
      comment: "Year when opportunity is expected to close"
    - name: "expected_close_quarter"
      expr: CONCAT('Q', QUARTER(expected_close_date), '-', YEAR(expected_close_date))
      comment: "Quarter when opportunity is expected to close"
    - name: "expected_close_month"
      expr: DATE_TRUNC('MONTH', expected_close_date)
      comment: "Month when opportunity is expected to close"
    - name: "is_active_flag"
      expr: is_active
      comment: "Whether the opportunity is currently active"
  measures:
    - name: "total_opportunities"
      expr: COUNT(1)
      comment: "Total count of engagement opportunities"
    - name: "total_pipeline_value"
      expr: SUM(CAST(estimated_matter_value AS DOUBLE))
      comment: "Total estimated value of all opportunities in pipeline"
    - name: "weighted_pipeline_value"
      expr: SUM(CAST(estimated_matter_value AS DOUBLE) * CAST(probability_percent AS DOUBLE) / 100.0)
      comment: "Risk-adjusted pipeline value weighted by win probability"
    - name: "avg_opportunity_value"
      expr: AVG(CAST(estimated_matter_value AS DOUBLE))
      comment: "Average estimated value per opportunity"
    - name: "avg_win_probability"
      expr: AVG(CAST(probability_percent AS DOUBLE))
      comment: "Average win probability across opportunities"
    - name: "opportunities_with_conflict_cleared"
      expr: COUNT(CASE WHEN conflict_check_status = 'Cleared' THEN 1 END)
      comment: "Count of opportunities that have passed conflict checks"
    - name: "opportunities_with_kyc_complete"
      expr: COUNT(CASE WHEN kyc_status = 'Completed' THEN 1 END)
      comment: "Count of opportunities with completed KYC screening"
    - name: "opportunities_with_afa"
      expr: COUNT(CASE WHEN afa_type IS NOT NULL THEN 1 END)
      comment: "Count of opportunities using alternative fee arrangements"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`intake_conflict_search`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Conflict check operational efficiency and risk identification metrics for intake risk management"
  source: "`legal_ecm`.`intake`.`conflict_search`"
  dimensions:
    - name: "search_status"
      expr: search_status
      comment: "Status of the conflict search (e.g., Pending, In Progress, Completed, Failed)"
    - name: "search_priority"
      expr: search_priority
      comment: "Priority level of the conflict search"
    - name: "search_scope"
      expr: search_scope
      comment: "Scope of the conflict search (e.g., Full, Limited, Targeted)"
    - name: "party_type"
      expr: party_type
      comment: "Type of party being searched (e.g., Individual, Corporation, Government)"
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Whether the search results require escalation"
    - name: "automated_search_flag"
      expr: automated_search_flag
      comment: "Whether the search was automated or manual"
    - name: "search_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month when conflict search was initiated"
  measures:
    - name: "total_conflict_searches"
      expr: COUNT(1)
      comment: "Total number of conflict searches performed"
    - name: "avg_search_duration_seconds"
      expr: AVG(CAST(search_execution_duration_seconds AS DOUBLE))
      comment: "Average time to execute conflict search in seconds"
    - name: "total_high_risk_hits"
      expr: SUM(CAST(high_risk_hits_count AS DOUBLE))
      comment: "Total count of high-risk conflict hits identified"
    - name: "total_medium_risk_hits"
      expr: SUM(CAST(medium_risk_hits_count AS DOUBLE))
      comment: "Total count of medium-risk conflict hits identified"
    - name: "total_low_risk_hits"
      expr: SUM(CAST(low_risk_hits_count AS DOUBLE))
      comment: "Total count of low-risk conflict hits identified"
    - name: "searches_requiring_escalation"
      expr: COUNT(CASE WHEN escalation_required_flag = TRUE THEN 1 END)
      comment: "Count of searches requiring escalation to senior review"
    - name: "automated_searches"
      expr: COUNT(CASE WHEN automated_search_flag = TRUE THEN 1 END)
      comment: "Count of searches performed via automated process"
    - name: "avg_match_threshold"
      expr: AVG(CAST(match_threshold_percentage AS DOUBLE))
      comment: "Average match threshold percentage used in searches"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`intake_conflict_hit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Conflict hit resolution and risk disposition metrics for conflict management and ethical compliance"
  source: "`legal_ecm`.`intake`.`conflict_hit`"
  dimensions:
    - name: "hit_status"
      expr: hit_status
      comment: "Current status of the conflict hit (e.g., Open, Under Review, Resolved, Waived)"
    - name: "hit_severity"
      expr: hit_severity
      comment: "Severity level of the conflict hit (e.g., High, Medium, Low)"
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the conflict hit (e.g., Cleared, Declined, Waived)"
    - name: "match_type"
      expr: match_type
      comment: "Type of match that triggered the hit (e.g., Direct, Indirect, Related Party)"
    - name: "relationship_type"
      expr: relationship_type
      comment: "Type of relationship causing the conflict"
    - name: "practice_area"
      expr: practice_area
      comment: "Practice area associated with the conflict hit"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction relevant to the conflict"
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Whether the hit requires escalation"
    - name: "ethical_wall_required_flag"
      expr: ethical_wall_required_flag
      comment: "Whether an ethical wall is required to manage the conflict"
    - name: "waiver_required_flag"
      expr: waiver_required_flag
      comment: "Whether a waiver is required from affected parties"
    - name: "waiver_obtained_flag"
      expr: waiver_obtained_flag
      comment: "Whether required waiver has been obtained"
    - name: "review_priority"
      expr: review_priority
      comment: "Priority level for reviewing the conflict hit"
    - name: "hit_identified_month"
      expr: DATE_TRUNC('MONTH', hit_identified_timestamp)
      comment: "Month when conflict hit was identified"
  measures:
    - name: "total_conflict_hits"
      expr: COUNT(1)
      comment: "Total number of conflict hits identified"
    - name: "avg_match_score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average match score across conflict hits"
    - name: "hits_requiring_escalation"
      expr: COUNT(CASE WHEN escalation_required_flag = TRUE THEN 1 END)
      comment: "Count of hits requiring escalation to senior review"
    - name: "hits_requiring_ethical_wall"
      expr: COUNT(CASE WHEN ethical_wall_required_flag = TRUE THEN 1 END)
      comment: "Count of hits requiring ethical wall implementation"
    - name: "hits_requiring_waiver"
      expr: COUNT(CASE WHEN waiver_required_flag = TRUE THEN 1 END)
      comment: "Count of hits requiring client waiver"
    - name: "waivers_obtained"
      expr: COUNT(CASE WHEN waiver_obtained_flag = TRUE THEN 1 END)
      comment: "Count of hits where required waiver was obtained"
    - name: "hits_cleared"
      expr: COUNT(CASE WHEN disposition = 'Cleared' THEN 1 END)
      comment: "Count of conflict hits cleared for engagement"
    - name: "hits_declined"
      expr: COUNT(CASE WHEN disposition = 'Declined' THEN 1 END)
      comment: "Count of conflict hits resulting in engagement decline"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`intake_kyc_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KYC and AML screening compliance metrics for client onboarding risk management and regulatory adherence"
  source: "`legal_ecm`.`intake`.`kyc_screening`"
  dimensions:
    - name: "screening_status"
      expr: screening_status
      comment: "Current status of KYC screening (e.g., Pending, In Progress, Completed, Failed)"
    - name: "screening_outcome"
      expr: screening_outcome
      comment: "Outcome of the screening process (e.g., Approved, Rejected, Requires EDD)"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Overall risk rating assigned (e.g., Low, Medium, High, Prohibited)"
    - name: "screening_type"
      expr: screening_type
      comment: "Type of screening performed (e.g., Standard KYC, Enhanced Due Diligence, Sanctions)"
    - name: "screening_provider"
      expr: screening_provider
      comment: "Third-party provider used for screening"
    - name: "jurisdiction_risk_level"
      expr: jurisdiction_risk_level
      comment: "Risk level of the jurisdiction"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the screening (e.g., Approved, Pending, Rejected)"
    - name: "pep_hit_flag"
      expr: pep_hit_flag
      comment: "Whether a Politically Exposed Person hit was identified"
    - name: "sanctions_hit_flag"
      expr: sanctions_hit_flag
      comment: "Whether a sanctions list hit was identified"
    - name: "adverse_media_hit_flag"
      expr: adverse_media_hit_flag
      comment: "Whether adverse media was identified"
    - name: "edd_required_flag"
      expr: edd_required_flag
      comment: "Whether Enhanced Due Diligence is required"
    - name: "regulatory_filing_required_flag"
      expr: regulatory_filing_required_flag
      comment: "Whether regulatory filing (e.g., SAR) is required"
    - name: "screening_month"
      expr: DATE_TRUNC('MONTH', screening_timestamp)
      comment: "Month when screening was performed"
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total number of KYC screenings performed"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across all screenings"
    - name: "screenings_with_pep_hit"
      expr: COUNT(CASE WHEN pep_hit_flag = TRUE THEN 1 END)
      comment: "Count of screenings with PEP hits identified"
    - name: "screenings_with_sanctions_hit"
      expr: COUNT(CASE WHEN sanctions_hit_flag = TRUE THEN 1 END)
      comment: "Count of screenings with sanctions hits identified"
    - name: "screenings_with_adverse_media"
      expr: COUNT(CASE WHEN adverse_media_hit_flag = TRUE THEN 1 END)
      comment: "Count of screenings with adverse media identified"
    - name: "screenings_requiring_edd"
      expr: COUNT(CASE WHEN edd_required_flag = TRUE THEN 1 END)
      comment: "Count of screenings requiring Enhanced Due Diligence"
    - name: "screenings_requiring_sar"
      expr: COUNT(CASE WHEN regulatory_filing_required_flag = TRUE THEN 1 END)
      comment: "Count of screenings requiring Suspicious Activity Report filing"
    - name: "total_screening_cost"
      expr: SUM(CAST(screening_cost_amount AS DOUBLE))
      comment: "Total cost of all KYC screenings performed"
    - name: "avg_screening_cost"
      expr: AVG(CAST(screening_cost_amount AS DOUBLE))
      comment: "Average cost per KYC screening"
    - name: "screenings_approved"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Count of screenings approved for engagement"
    - name: "screenings_rejected"
      expr: COUNT(CASE WHEN approval_status = 'Rejected' THEN 1 END)
      comment: "Count of screenings rejected"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`intake_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intake request processing and conversion metrics for operational efficiency and matter opening velocity"
  source: "`legal_ecm`.`intake`.`request`"
  dimensions:
    - name: "intake_status"
      expr: intake_status
      comment: "Current status of the intake request (e.g., Submitted, Under Review, Approved, Rejected)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the request"
    - name: "conflict_check_status"
      expr: conflict_check_status
      comment: "Status of conflict check for the request"
    - name: "kyc_status"
      expr: kyc_status
      comment: "KYC screening status for the request"
    - name: "loe_status"
      expr: loe_status
      comment: "Letter of Engagement status"
    - name: "matter_type"
      expr: matter_type
      comment: "Type of legal matter requested"
    - name: "practice_area"
      expr: practice_area
      comment: "Practice area for the requested matter"
    - name: "office_code"
      expr: office_code
      comment: "Office handling the intake request"
    - name: "proposed_fee_arrangement_type"
      expr: proposed_fee_arrangement_type
      comment: "Proposed fee arrangement type (e.g., Hourly, Fixed Fee, Contingency)"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the request"
    - name: "urgency_flag"
      expr: urgency_flag
      comment: "Whether the request is marked as urgent"
    - name: "loe_required_flag"
      expr: loe_required
      comment: "Whether a Letter of Engagement is required"
    - name: "conflict_waiver_obtained_flag"
      expr: conflict_waiver_obtained
      comment: "Whether conflict waiver was obtained"
    - name: "matter_opened_flag"
      expr: matter_opened_flag
      comment: "Whether the matter has been opened in the system"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month when request was submitted"
  measures:
    - name: "total_requests"
      expr: COUNT(1)
      comment: "Total number of intake requests"
    - name: "total_estimated_fees"
      expr: SUM(CAST(estimated_fee_amount AS DOUBLE))
      comment: "Total estimated fee amount across all requests"
    - name: "avg_estimated_fee"
      expr: AVG(CAST(estimated_fee_amount AS DOUBLE))
      comment: "Average estimated fee per request"
    - name: "requests_approved"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Count of requests approved"
    - name: "requests_rejected"
      expr: COUNT(CASE WHEN approval_status = 'Rejected' THEN 1 END)
      comment: "Count of requests rejected"
    - name: "requests_with_conflict_cleared"
      expr: COUNT(CASE WHEN conflict_check_status = 'Cleared' THEN 1 END)
      comment: "Count of requests with conflicts cleared"
    - name: "requests_with_kyc_complete"
      expr: COUNT(CASE WHEN kyc_status = 'Completed' THEN 1 END)
      comment: "Count of requests with KYC completed"
    - name: "matters_opened"
      expr: COUNT(CASE WHEN matter_opened_flag = TRUE THEN 1 END)
      comment: "Count of requests that resulted in opened matters"
    - name: "urgent_requests"
      expr: COUNT(CASE WHEN urgency_flag = TRUE THEN 1 END)
      comment: "Count of requests marked as urgent"
    - name: "requests_requiring_loe"
      expr: COUNT(CASE WHEN loe_required = TRUE THEN 1 END)
      comment: "Count of requests requiring Letter of Engagement"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`intake_rfp_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFP response effectiveness and win rate metrics for business development strategy and competitive positioning"
  source: "`legal_ecm`.`intake`.`rfp_submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Status of the RFP submission (e.g., Draft, Submitted, Under Review, Decided)"
    - name: "decision_outcome"
      expr: decision_outcome
      comment: "Final decision outcome (e.g., Won, Lost, No Decision)"
    - name: "decline_reason"
      expr: decline_reason
      comment: "Reason for declining to respond to RFP"
    - name: "matter_type"
      expr: matter_type
      comment: "Type of legal matter in the RFP"
    - name: "practice_area"
      expr: practice_area
      comment: "Practice area for the RFP"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction for the RFP matter"
    - name: "fee_arrangement_type"
      expr: fee_arrangement_type
      comment: "Proposed fee arrangement type"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the RFP response"
    - name: "conflict_check_status"
      expr: conflict_check_status
      comment: "Status of conflict check for the RFP"
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which RFP was received"
    - name: "is_existing_client_flag"
      expr: is_existing_client
      comment: "Whether RFP is from an existing client"
    - name: "requires_panel_approval_flag"
      expr: requires_panel_approval
      comment: "Whether RFP requires panel approval"
    - name: "gdpr_compliant_flag"
      expr: gdpr_compliant
      comment: "Whether RFP response is GDPR compliant"
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Month when RFP was received"
  measures:
    - name: "total_rfp_submissions"
      expr: COUNT(1)
      comment: "Total number of RFP submissions"
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value_amount AS DOUBLE))
      comment: "Total estimated value of all RFP opportunities"
    - name: "avg_estimated_value"
      expr: AVG(CAST(estimated_value_amount AS DOUBLE))
      comment: "Average estimated value per RFP"
    - name: "avg_win_probability"
      expr: AVG(CAST(win_probability_percentage AS DOUBLE))
      comment: "Average win probability across RFPs"
    - name: "rfps_won"
      expr: COUNT(CASE WHEN decision_outcome = 'Won' THEN 1 END)
      comment: "Count of RFPs won"
    - name: "rfps_lost"
      expr: COUNT(CASE WHEN decision_outcome = 'Lost' THEN 1 END)
      comment: "Count of RFPs lost"
    - name: "rfps_declined"
      expr: COUNT(CASE WHEN decline_reason IS NOT NULL THEN 1 END)
      comment: "Count of RFPs declined (firm chose not to respond)"
    - name: "rfps_from_existing_clients"
      expr: COUNT(CASE WHEN is_existing_client = TRUE THEN 1 END)
      comment: "Count of RFPs from existing clients"
    - name: "rfps_requiring_panel_approval"
      expr: COUNT(CASE WHEN requires_panel_approval = TRUE THEN 1 END)
      comment: "Count of RFPs requiring panel approval"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`intake_pitch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pitch performance and win/loss analysis metrics for business development effectiveness and competitive intelligence"
  source: "`legal_ecm`.`intake`.`pitch`"
  dimensions:
    - name: "pitch_status"
      expr: pitch_status
      comment: "Current status of the pitch (e.g., Scheduled, Completed, Cancelled)"
    - name: "pitch_type"
      expr: pitch_type
      comment: "Type of pitch (e.g., Formal Presentation, Beauty Parade, Informal Meeting)"
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the pitch (e.g., Won, Lost, Pending)"
    - name: "win_reason_code"
      expr: win_reason_code
      comment: "Coded reason for winning the pitch"
    - name: "loss_reason_code"
      expr: loss_reason_code
      comment: "Coded reason for losing the pitch"
    - name: "matter_type"
      expr: matter_type
      comment: "Type of legal matter pitched"
    - name: "practice_area"
      expr: practice_area
      comment: "Practice area for the pitch"
    - name: "proposed_fee_arrangement"
      expr: proposed_fee_arrangement
      comment: "Fee arrangement proposed in the pitch"
    - name: "conflict_check_status"
      expr: conflict_check_status
      comment: "Status of conflict check for the pitch"
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Whether follow-up is required after the pitch"
    - name: "pitch_month"
      expr: DATE_TRUNC('MONTH', pitch_date)
      comment: "Month when pitch occurred"
  measures:
    - name: "total_pitches"
      expr: COUNT(1)
      comment: "Total number of pitches delivered"
    - name: "total_estimated_matter_value"
      expr: SUM(CAST(estimated_matter_value AS DOUBLE))
      comment: "Total estimated value of all pitched matters"
    - name: "avg_estimated_matter_value"
      expr: AVG(CAST(estimated_matter_value AS DOUBLE))
      comment: "Average estimated value per pitched matter"
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total cost estimate across all pitches"
    - name: "total_preparation_hours"
      expr: SUM(CAST(preparation_hours AS DOUBLE))
      comment: "Total hours spent preparing pitches"
    - name: "avg_preparation_hours"
      expr: AVG(CAST(preparation_hours AS DOUBLE))
      comment: "Average preparation hours per pitch"
    - name: "avg_pitch_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average pitch score (if scored)"
    - name: "pitches_won"
      expr: COUNT(CASE WHEN outcome = 'Won' THEN 1 END)
      comment: "Count of pitches won"
    - name: "pitches_lost"
      expr: COUNT(CASE WHEN outcome = 'Lost' THEN 1 END)
      comment: "Count of pitches lost"
    - name: "pitches_requiring_followup"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END)
      comment: "Count of pitches requiring follow-up action"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`intake_matter_opening_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Matter opening approval cycle time and compliance metrics for intake-to-matter conversion efficiency"
  source: "`legal_ecm`.`intake`.`request`"
  dimensions:
    - name: "office_code"
      expr: office_code
      comment: "Office code where matter will be opened"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month when matter opening request was submitted"
  measures:
    - name: "total_matter_opening_requests"
      expr: COUNT(1)
      comment: "Total number of matter opening requests"
    - name: "total_estimated_fees"
      expr: SUM(CAST(estimated_fee_amount AS DOUBLE))
      comment: "Total estimated fee amount for all matter opening requests"
    - name: "avg_estimated_fee"
      expr: AVG(CAST(estimated_fee_amount AS DOUBLE))
      comment: "Average estimated fee per matter opening request"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`intake_panel_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Panel appointment performance and retention metrics for strategic client relationship management and volume commitment tracking"
  source: "`legal_ecm`.`intake`.`panel_appointment`"
  dimensions:
    - name: "panel_status"
      expr: panel_status
      comment: "Current status of the panel appointment (e.g., Active, Inactive, Expired, Terminated)"
    - name: "panel_tier"
      expr: panel_tier
      comment: "Tier level of the panel appointment (e.g., Preferred, Approved, Specialist)"
    - name: "panel_category"
      expr: panel_category
      comment: "Category of the panel (e.g., Corporate, Litigation, IP)"
    - name: "practice_group"
      expr: practice_group
      comment: "Practice group for the panel appointment"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the panel appointment"
    - name: "matter_type_scope"
      expr: matter_type_scope
      comment: "Matter types covered by the panel appointment"
    - name: "kyc_status"
      expr: kyc_status
      comment: "KYC status for the panel appointment"
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of required reporting (e.g., Monthly, Quarterly, Annually)"
    - name: "conflict_check_required_flag"
      expr: conflict_check_required_flag
      comment: "Whether conflict check is required for panel matters"
    - name: "appointment_year"
      expr: YEAR(appointment_date)
      comment: "Year of panel appointment"
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year when panel appointment expires"
  measures:
    - name: "total_panel_appointments"
      expr: COUNT(1)
      comment: "Total number of panel appointments"
    - name: "total_volume_commitment"
      expr: SUM(CAST(volume_commitment_amount AS DOUBLE))
      comment: "Total volume commitment amount across all panel appointments"
    - name: "avg_volume_commitment"
      expr: AVG(CAST(volume_commitment_amount AS DOUBLE))
      comment: "Average volume commitment per panel appointment"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage offered on panel appointments"
    - name: "active_panels"
      expr: COUNT(CASE WHEN panel_status = 'Active' THEN 1 END)
      comment: "Count of currently active panel appointments"
    - name: "expired_panels"
      expr: COUNT(CASE WHEN panel_status = 'Expired' THEN 1 END)
      comment: "Count of expired panel appointments"
    - name: "terminated_panels"
      expr: COUNT(CASE WHEN panel_status = 'Terminated' THEN 1 END)
      comment: "Count of terminated panel appointments"
    - name: "panels_with_kyc_complete"
      expr: COUNT(CASE WHEN kyc_status = 'Completed' THEN 1 END)
      comment: "Count of panel appointments with completed KYC"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`intake_fee_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fee arrangement negotiation and approval metrics for pricing strategy and profitability management"
  source: "`legal_ecm`.`intake`.`intake_fee_arrangement`"
  dimensions:
    - name: "arrangement_status"
      expr: arrangement_status
      comment: "Status of the fee arrangement (e.g., Draft, Pending Approval, Approved, Rejected)"
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency for the arrangement"
    - name: "disbursement_handling"
      expr: disbursement_handling
      comment: "How disbursements are handled (e.g., Pass-through, Included, Capped)"
    - name: "is_ocg_compliant_flag"
      expr: is_outside_counsel_guideline_compliant
      comment: "Whether arrangement complies with outside counsel guidelines"
    - name: "ledes_format_required_flag"
      expr: ledes_format_required
      comment: "Whether LEDES format is required for billing"
    - name: "utbms_task_code_required_flag"
      expr: utbms_task_code_required
      comment: "Whether UTBMS task codes are required"
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month when fee arrangement was approved"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month when fee arrangement becomes effective"
  measures:
    - name: "total_fee_arrangements"
      expr: COUNT(1)
      comment: "Total number of intake fee arrangements"
    - name: "total_agreed_fees"
      expr: SUM(CAST(agreed_fee_amount AS DOUBLE))
      comment: "Total agreed fee amount across all arrangements"
    - name: "avg_agreed_fee"
      expr: AVG(CAST(agreed_fee_amount AS DOUBLE))
      comment: "Average agreed fee per arrangement"
    - name: "total_cap_amount"
      expr: SUM(CAST(cap_amount AS DOUBLE))
      comment: "Total cap amount across all capped arrangements"
    - name: "total_minimum_commitment"
      expr: SUM(CAST(minimum_fee_commitment AS DOUBLE))
      comment: "Total minimum fee commitment across all arrangements"
    - name: "total_success_fees"
      expr: SUM(CAST(success_fee_amount AS DOUBLE))
      comment: "Total success fee amount across all arrangements"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage offered"
    - name: "avg_contingency_percentage"
      expr: AVG(CAST(contingency_percentage AS DOUBLE))
      comment: "Average contingency percentage for contingency arrangements"
    - name: "avg_blended_rate"
      expr: AVG(CAST(blended_rate AS DOUBLE))
      comment: "Average blended rate across arrangements"
    - name: "arrangements_approved"
      expr: COUNT(CASE WHEN arrangement_status = 'Approved' THEN 1 END)
      comment: "Count of fee arrangements approved"
    - name: "arrangements_rejected"
      expr: COUNT(CASE WHEN arrangement_status = 'Rejected' THEN 1 END)
      comment: "Count of fee arrangements rejected"
    - name: "ocg_compliant_arrangements"
      expr: COUNT(CASE WHEN is_outside_counsel_guideline_compliant = TRUE THEN 1 END)
      comment: "Count of arrangements compliant with outside counsel guidelines"
$$;