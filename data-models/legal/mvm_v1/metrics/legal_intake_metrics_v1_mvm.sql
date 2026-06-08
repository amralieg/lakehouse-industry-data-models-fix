-- Metric views for domain: intake | Business: Legal | Version: 1 | Generated on: 2026-05-07 14:29:57

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`intake_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the intake request lifecycle. Tracks intake volume, approval throughput, conflict resolution rates, risk distribution, and estimated fee pipeline — core metrics for managing the front-door of legal service delivery."
  source: "`legal_ecm`.`intake`.`request`"
  dimensions:
    - name: "intake_status"
      expr: intake_status
      comment: "Current status of the intake request (e.g. Pending, Approved, Rejected, Withdrawn) — primary grouping for funnel analysis."
    - name: "matter_type"
      expr: matter_type
      comment: "Type of legal matter being requested (e.g. Litigation, Corporate, IP) — enables practice-area level intake analysis."
    - name: "conflict_check_status"
      expr: conflict_check_status
      comment: "Status of the conflict-of-interest check on the request — used to monitor compliance gate throughput."
    - name: "kyc_status"
      expr: kyc_status
      comment: "Know-Your-Client screening status on the request — critical compliance dimension for regulatory reporting."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the intake request — enables risk-tiered pipeline analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval decision on the request (Approved / Rejected / Pending) — key dimension for governance reporting."
    - name: "office_code"
      expr: office_code
      comment: "Office location code where the request was submitted — supports geographic intake distribution analysis."
    - name: "proposed_fee_arrangement_type"
      expr: proposed_fee_arrangement_type
      comment: "Proposed fee arrangement type (e.g. Fixed Fee, Hourly, Contingency) — informs revenue mix planning."
    - name: "urgency_flag"
      expr: urgency_flag
      comment: "Boolean flag indicating whether the request was marked urgent — used to prioritise SLA monitoring."
    - name: "loe_status"
      expr: loe_status
      comment: "Status of the Letter of Engagement associated with the request — tracks formalisation progress."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Calendar month the request was submitted — primary time dimension for trend analysis."
    - name: "submission_quarter"
      expr: DATE_TRUNC('QUARTER', submission_timestamp)
      comment: "Calendar quarter the request was submitted — supports quarterly business review reporting."
    - name: "matter_opened_flag"
      expr: matter_opened_flag
      comment: "Boolean flag indicating whether the request resulted in a matter being opened — key conversion indicator."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the estimated fee is denominated — required for multi-currency pipeline reporting."
  measures:
    - name: "total_intake_requests"
      expr: COUNT(1)
      comment: "Total number of intake requests submitted. Baseline volume metric for capacity planning and intake funnel analysis."
    - name: "approved_requests"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of intake requests that received approval. Tracks throughput of the governance gate."
    - name: "rejected_requests"
      expr: COUNT(CASE WHEN approval_status = 'Rejected' THEN 1 END)
      comment: "Number of intake requests rejected. Elevated rejection rates signal intake quality or conflict issues."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submitted intake requests that were approved. Core governance efficiency KPI for executive dashboards."
    - name: "matter_conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN matter_opened_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of intake requests that converted to an opened matter. Directly measures intake-to-revenue conversion efficiency."
    - name: "conflict_clear_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN conflict_check_status = 'Clear' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requests where the conflict check returned clear. Low rates indicate elevated conflict exposure or process bottlenecks."
    - name: "kyc_passed_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN kyc_status = 'Passed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requests where KYC screening passed. Regulatory compliance KPI monitored by Risk and Compliance leadership."
    - name: "total_estimated_fee_pipeline"
      expr: SUM(CAST(estimated_fee_amount AS DOUBLE))
      comment: "Total estimated fee value across all intake requests. Represents the gross revenue pipeline entering the firm through intake."
    - name: "avg_estimated_fee_per_request"
      expr: AVG(CAST(estimated_fee_amount AS DOUBLE))
      comment: "Average estimated fee amount per intake request. Tracks deal size trends and informs resource allocation decisions."
    - name: "urgent_requests"
      expr: COUNT(CASE WHEN urgency_flag = TRUE THEN 1 END)
      comment: "Number of intake requests flagged as urgent. Drives SLA prioritisation and staffing decisions."
    - name: "loe_required_not_executed_requests"
      expr: COUNT(CASE WHEN loe_required = TRUE AND loe_status != 'Executed' THEN 1 END)
      comment: "Number of requests where a Letter of Engagement is required but not yet executed. Identifies formalisation risk in the pipeline."
    - name: "high_risk_requests"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN 1 END)
      comment: "Number of intake requests rated as high risk. Escalation trigger for risk committee review and enhanced due diligence."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`intake_engagement_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Business development and pipeline KPI layer over engagement opportunities. Tracks pipeline value, win probability, stage progression, conflict and KYC compliance gates, and fee arrangement mix — essential for BD leadership and practice group heads."
  source: "`legal_ecm`.`intake`.`engagement_opportunity`"
  dimensions:
    - name: "opportunity_stage"
      expr: opportunity_stage
      comment: "Current stage of the engagement opportunity in the BD pipeline (e.g. Qualification, Proposal, Negotiation, Closed Won/Lost)."
    - name: "matter_type"
      expr: matter_type
      comment: "Type of legal matter associated with the opportunity — enables practice-area pipeline analysis."
    - name: "industry_sector"
      expr: industry_sector
      comment: "Industry sector of the prospective client — supports sector-based BD strategy and targeting."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction relevant to the engagement opportunity — informs geographic revenue planning."
    - name: "afa_type"
      expr: afa_type
      comment: "Alternative Fee Arrangement type proposed for the opportunity — tracks pricing strategy mix."
    - name: "conflict_check_status"
      expr: conflict_check_status
      comment: "Status of the conflict-of-interest check on the opportunity — compliance gate dimension."
    - name: "kyc_status"
      expr: kyc_status
      comment: "KYC screening status on the opportunity — regulatory compliance dimension."
    - name: "lead_source"
      expr: lead_source
      comment: "Source channel that generated the opportunity (e.g. Referral, RFP, Direct) — informs BD channel effectiveness."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the opportunity is currently active — used to filter live pipeline."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the estimated matter value is denominated."
    - name: "expected_close_month"
      expr: DATE_TRUNC('MONTH', expected_close_date)
      comment: "Month the opportunity is expected to close — primary time dimension for pipeline forecasting."
    - name: "expected_close_quarter"
      expr: DATE_TRUNC('QUARTER', expected_close_date)
      comment: "Quarter the opportunity is expected to close — supports quarterly revenue forecasting."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the opportunity was created — tracks new pipeline generation velocity."
    - name: "matter_opened_in_elite_flag"
      expr: matter_opened_in_elite_flag
      comment: "Boolean flag indicating whether the matter was opened in the Elite practice management system — tracks conversion to active matter."
  measures:
    - name: "total_opportunities"
      expr: COUNT(1)
      comment: "Total number of engagement opportunities in the pipeline. Baseline BD volume metric."
    - name: "active_opportunities"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active engagement opportunities. Represents the live BD pipeline."
    - name: "won_opportunities"
      expr: COUNT(CASE WHEN opportunity_stage = 'Closed Won' THEN 1 END)
      comment: "Number of opportunities closed as won. Core BD performance KPI."
    - name: "lost_opportunities"
      expr: COUNT(CASE WHEN opportunity_stage = 'Closed Lost' THEN 1 END)
      comment: "Number of opportunities closed as lost. Elevated loss rates trigger competitive strategy review."
    - name: "win_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN opportunity_stage = 'Closed Won' THEN 1 END) / NULLIF(COUNT(CASE WHEN opportunity_stage IN ('Closed Won', 'Closed Lost') THEN 1 END), 0), 2)
      comment: "Win rate as a percentage of closed opportunities. Primary BD effectiveness KPI for executive and practice group reporting."
    - name: "total_estimated_pipeline_value"
      expr: SUM(CAST(estimated_matter_value AS DOUBLE))
      comment: "Total estimated matter value across all opportunities. Gross revenue pipeline metric for financial forecasting."
    - name: "weighted_pipeline_value"
      expr: SUM(CAST(estimated_matter_value AS DOUBLE) * CAST(probability_percent AS DOUBLE) / 100.0)
      comment: "Probability-weighted pipeline value (estimated_matter_value × probability_percent). The most accurate forward revenue forecast metric for BD leadership."
    - name: "avg_estimated_matter_value"
      expr: AVG(CAST(estimated_matter_value AS DOUBLE))
      comment: "Average estimated matter value per opportunity. Tracks deal size trends and informs partner compensation and resource planning."
    - name: "avg_win_probability_pct"
      expr: AVG(CAST(probability_percent AS DOUBLE))
      comment: "Average win probability across active opportunities. Indicates overall pipeline quality and confidence level."
    - name: "conflict_check_pending_opportunities"
      expr: COUNT(CASE WHEN conflict_check_status = 'Pending' THEN 1 END)
      comment: "Number of opportunities with a pending conflict check. Unresolved conflicts block matter opening — a key operational risk metric."
    - name: "kyc_incomplete_opportunities"
      expr: COUNT(CASE WHEN kyc_status NOT IN ('Passed', 'Completed') THEN 1 END)
      comment: "Number of opportunities where KYC has not been completed. Regulatory compliance risk indicator for the BD pipeline."
    - name: "converted_to_matter_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN matter_opened_in_elite_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of opportunities that resulted in a matter being opened in Elite. Measures end-to-end BD-to-revenue conversion."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`intake_pitch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "BD pitch performance KPI layer. Tracks pitch win/loss rates, preparation investment, estimated deal value, and competitive outcomes — enabling practice group heads and BD directors to optimise pitch strategy and resource allocation."
  source: "`legal_ecm`.`intake`.`pitch`"
  dimensions:
    - name: "pitch_status"
      expr: pitch_status
      comment: "Current status of the pitch (e.g. Scheduled, Delivered, Won, Lost, Withdrawn)."
    - name: "pitch_type"
      expr: pitch_type
      comment: "Type of pitch (e.g. RFP Response, Speculative, Panel Review) — informs channel-specific win rate analysis."
    - name: "matter_type"
      expr: matter_type
      comment: "Type of legal matter being pitched — enables practice-area win rate benchmarking."
    - name: "outcome"
      expr: outcome
      comment: "Final outcome of the pitch (Won / Lost / Pending) — primary dimension for win/loss analysis."
    - name: "win_reason_code"
      expr: win_reason_code
      comment: "Coded reason for winning the pitch — identifies competitive differentiators."
    - name: "loss_reason_code"
      expr: loss_reason_code
      comment: "Coded reason for losing the pitch — identifies systemic weaknesses in pitch strategy."
    - name: "proposed_fee_arrangement"
      expr: proposed_fee_arrangement
      comment: "Fee arrangement proposed in the pitch — tracks pricing strategy effectiveness by outcome."
    - name: "conflict_check_status"
      expr: conflict_check_status
      comment: "Conflict check status at time of pitch — compliance dimension."
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Boolean flag indicating whether follow-up action is required after the pitch."
    - name: "pitch_month"
      expr: DATE_TRUNC('MONTH', pitch_date)
      comment: "Month the pitch was delivered — primary time dimension for pitch activity trending."
    - name: "pitch_quarter"
      expr: DATE_TRUNC('QUARTER', pitch_date)
      comment: "Quarter the pitch was delivered — supports quarterly BD performance reviews."
  measures:
    - name: "total_pitches"
      expr: COUNT(1)
      comment: "Total number of pitches delivered. Baseline BD activity volume metric."
    - name: "won_pitches"
      expr: COUNT(CASE WHEN outcome = 'Won' THEN 1 END)
      comment: "Number of pitches with a Won outcome. Core BD performance KPI."
    - name: "lost_pitches"
      expr: COUNT(CASE WHEN outcome = 'Lost' THEN 1 END)
      comment: "Number of pitches with a Lost outcome. Drives competitive strategy and pitch quality improvement."
    - name: "pitch_win_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN outcome = 'Won' THEN 1 END) / NULLIF(COUNT(CASE WHEN outcome IN ('Won', 'Lost') THEN 1 END), 0), 2)
      comment: "Win rate as a percentage of decided pitches. Primary pitch effectiveness KPI for BD directors and practice group heads."
    - name: "total_estimated_pitch_value"
      expr: SUM(CAST(estimated_matter_value AS DOUBLE))
      comment: "Total estimated matter value across all pitches. Represents the gross value of business being competed for."
    - name: "won_pitch_value"
      expr: SUM(CASE WHEN outcome = 'Won' THEN CAST(estimated_matter_value AS DOUBLE) ELSE 0 END)
      comment: "Total estimated matter value of won pitches. Measures the revenue captured through the pitch process."
    - name: "avg_preparation_hours"
      expr: AVG(CAST(preparation_hours AS DOUBLE))
      comment: "Average hours invested in pitch preparation. Informs ROI analysis of pitch effort relative to win rates and deal value."
    - name: "total_preparation_hours"
      expr: SUM(CAST(preparation_hours AS DOUBLE))
      comment: "Total hours invested in pitch preparation across all pitches. Tracks BD resource consumption for capacity planning."
    - name: "avg_pitch_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average pitch quality score. Tracks pitch quality trends and correlates with win rates."
    - name: "avg_cost_estimate"
      expr: AVG(CAST(cost_estimate AS DOUBLE))
      comment: "Average cost estimate submitted in pitches. Informs pricing competitiveness analysis."
    - name: "pitches_pending_follow_up"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END)
      comment: "Number of pitches requiring follow-up action. Operational metric to ensure BD pipeline momentum is maintained."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`intake_rfp_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFP response performance KPI layer. Tracks submission volumes, win rates, pipeline value, response timeliness, and competitive positioning — enabling BD and practice leadership to optimise RFP strategy and resource allocation."
  source: "`legal_ecm`.`intake`.`rfp_submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the RFP submission (e.g. Draft, Submitted, Won, Lost, Declined)."
    - name: "decision_outcome"
      expr: decision_outcome
      comment: "Final decision outcome of the RFP (Won / Lost / No Decision) — primary dimension for win/loss analysis."
    - name: "matter_type"
      expr: matter_type
      comment: "Type of legal matter covered by the RFP — enables practice-area RFP performance analysis."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction relevant to the RFP — supports geographic BD strategy."
    - name: "fee_arrangement_type"
      expr: fee_arrangement_type
      comment: "Fee arrangement type proposed in the RFP response — tracks pricing strategy effectiveness."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the RFP (e.g. High, Medium, Low) — informs resource allocation decisions."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the RFP was received (e.g. Direct, Panel, Referral) — informs channel effectiveness analysis."
    - name: "conflict_check_status"
      expr: conflict_check_status
      comment: "Status of the conflict check on the RFP — compliance gate dimension."
    - name: "is_existing_client"
      expr: is_existing_client
      comment: "Boolean flag indicating whether the RFP issuer is an existing client — enables new vs. existing client win rate comparison."
    - name: "requires_panel_approval"
      expr: requires_panel_approval
      comment: "Boolean flag indicating whether panel approval is required — tracks governance complexity."
    - name: "estimated_value_currency"
      expr: estimated_value_currency
      comment: "Currency of the estimated RFP value — required for multi-currency pipeline reporting."
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Month the RFP was received — primary time dimension for RFP volume trending."
    - name: "received_quarter"
      expr: DATE_TRUNC('QUARTER', received_date)
      comment: "Quarter the RFP was received — supports quarterly BD pipeline reviews."
  measures:
    - name: "total_rfp_submissions"
      expr: COUNT(1)
      comment: "Total number of RFP submissions. Baseline BD activity volume metric."
    - name: "won_rfps"
      expr: COUNT(CASE WHEN decision_outcome = 'Won' THEN 1 END)
      comment: "Number of RFPs with a Won outcome. Core BD performance KPI."
    - name: "lost_rfps"
      expr: COUNT(CASE WHEN decision_outcome = 'Lost' THEN 1 END)
      comment: "Number of RFPs with a Lost outcome. Drives competitive strategy review."
    - name: "declined_rfps"
      expr: COUNT(CASE WHEN submission_status = 'Declined' THEN 1 END)
      comment: "Number of RFPs declined by the firm. Tracks strategic selectivity in RFP participation."
    - name: "rfp_win_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN decision_outcome = 'Won' THEN 1 END) / NULLIF(COUNT(CASE WHEN decision_outcome IN ('Won', 'Lost') THEN 1 END), 0), 2)
      comment: "Win rate as a percentage of decided RFPs. Primary RFP effectiveness KPI for BD and practice leadership."
    - name: "total_estimated_rfp_pipeline_value"
      expr: SUM(CAST(estimated_value_amount AS DOUBLE))
      comment: "Total estimated value across all RFP submissions. Represents the gross revenue opportunity from the RFP channel."
    - name: "won_rfp_value"
      expr: SUM(CASE WHEN decision_outcome = 'Won' THEN CAST(estimated_value_amount AS DOUBLE) ELSE 0 END)
      comment: "Total estimated value of won RFPs. Measures revenue captured through the RFP channel."
    - name: "avg_win_probability_pct"
      expr: AVG(CAST(win_probability_percentage AS DOUBLE))
      comment: "Average win probability assigned to RFP submissions. Indicates overall pipeline quality and BD confidence."
    - name: "weighted_rfp_pipeline_value"
      expr: SUM(CAST(estimated_value_amount AS DOUBLE) * CAST(win_probability_percentage AS DOUBLE) / 100.0)
      comment: "Probability-weighted RFP pipeline value. Most accurate forward revenue forecast from the RFP channel."
    - name: "existing_client_rfp_win_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_existing_client = TRUE AND decision_outcome = 'Won' THEN 1 END) / NULLIF(COUNT(CASE WHEN is_existing_client = TRUE AND decision_outcome IN ('Won', 'Lost') THEN 1 END), 0), 2)
      comment: "Win rate for RFPs from existing clients. Measures client retention effectiveness through competitive re-pitching."
    - name: "new_client_rfp_win_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_existing_client = FALSE AND decision_outcome = 'Won' THEN 1 END) / NULLIF(COUNT(CASE WHEN is_existing_client = FALSE AND decision_outcome IN ('Won', 'Lost') THEN 1 END), 0), 2)
      comment: "Win rate for RFPs from new/prospective clients. Measures new client acquisition effectiveness."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`intake_kyc_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KYC and AML compliance screening KPI layer. Tracks screening outcomes, risk ratings, sanctions and PEP hit rates, EDD requirements, SAR filings, and screening cost — essential for compliance officers, risk committees, and regulatory reporting."
  source: "`legal_ecm`.`intake`.`kyc_screening`"
  dimensions:
    - name: "screening_status"
      expr: screening_status
      comment: "Current status of the KYC screening (e.g. Pending, In Progress, Completed, Failed)."
    - name: "screening_outcome"
      expr: screening_outcome
      comment: "Final outcome of the KYC screening (e.g. Pass, Fail, Refer) — primary compliance result dimension."
    - name: "screening_type"
      expr: screening_type
      comment: "Type of screening performed (e.g. Standard, Enhanced Due Diligence, Re-screening)."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned following screening (e.g. Low, Medium, High) — key dimension for risk-tiered reporting."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the screening review (e.g. Approved, Rejected, Escalated)."
    - name: "jurisdiction_risk_level"
      expr: jurisdiction_risk_level
      comment: "Risk level of the jurisdiction associated with the screening — informs geographic risk concentration analysis."
    - name: "screening_provider"
      expr: screening_provider
      comment: "Third-party provider used for the screening — enables vendor performance and cost analysis."
    - name: "data_classification"
      expr: data_classification
      comment: "Data classification level of the screening record — supports data governance reporting."
    - name: "edd_required_flag"
      expr: edd_required_flag
      comment: "Boolean flag indicating whether Enhanced Due Diligence was required — tracks EDD workload."
    - name: "re_screening_required_flag"
      expr: re_screening_required_flag
      comment: "Boolean flag indicating whether re-screening is required — tracks ongoing compliance obligations."
    - name: "regulatory_filing_required_flag"
      expr: regulatory_filing_required_flag
      comment: "Boolean flag indicating whether a regulatory filing is required — critical compliance dimension."
    - name: "screening_month"
      expr: DATE_TRUNC('MONTH', screening_date)
      comment: "Month the screening was performed — primary time dimension for compliance activity trending."
    - name: "screening_quarter"
      expr: DATE_TRUNC('QUARTER', screening_date)
      comment: "Quarter the screening was performed — supports quarterly compliance reporting."
    - name: "screening_cost_currency"
      expr: screening_cost_currency
      comment: "Currency of the screening cost — required for multi-currency compliance cost reporting."
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total number of KYC screenings performed. Baseline compliance activity volume metric."
    - name: "passed_screenings"
      expr: COUNT(CASE WHEN screening_outcome = 'Pass' THEN 1 END)
      comment: "Number of screenings with a Pass outcome. Tracks compliance throughput."
    - name: "failed_screenings"
      expr: COUNT(CASE WHEN screening_outcome = 'Fail' THEN 1 END)
      comment: "Number of screenings with a Fail outcome. Elevated failures trigger enhanced due diligence and potential client rejection."
    - name: "screening_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN screening_outcome = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings that passed. Core compliance quality KPI for risk committee reporting."
    - name: "sanctions_hit_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sanctions_hit_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings with a sanctions match. Critical regulatory risk KPI — any non-zero rate requires immediate escalation."
    - name: "pep_hit_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pep_hit_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings with a Politically Exposed Person hit. Elevated PEP rates indicate higher-risk client portfolio composition."
    - name: "adverse_media_hit_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN adverse_media_hit_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings with an adverse media hit. Reputational risk indicator for client acceptance decisions."
    - name: "edd_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN edd_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings requiring Enhanced Due Diligence. Tracks EDD workload intensity and compliance resource demand."
    - name: "sar_filings"
      expr: COUNT(CASE WHEN sar_reference_number IS NOT NULL THEN 1 END)
      comment: "Number of Suspicious Activity Reports filed. Regulatory reporting KPI monitored by MLRO and compliance leadership."
    - name: "total_screening_cost"
      expr: SUM(CAST(screening_cost_amount AS DOUBLE))
      comment: "Total cost of KYC screenings. Compliance cost management KPI for budget planning and vendor negotiation."
    - name: "avg_screening_cost"
      expr: AVG(CAST(screening_cost_amount AS DOUBLE))
      comment: "Average cost per KYC screening. Benchmarks vendor pricing and tracks cost efficiency over time."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across all screenings. Tracks overall portfolio risk level and trends for risk committee oversight."
    - name: "high_risk_screenings"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN 1 END)
      comment: "Number of screenings resulting in a High risk rating. Drives enhanced monitoring and escalation decisions."
    - name: "source_of_funds_verified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN source_of_funds_verified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings where source of funds was verified. AML compliance completeness KPI."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`intake_conflict_search`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Conflict-of-interest search KPI layer. Tracks search volumes, escalation rates, risk hit distributions, automated vs. manual search mix, and search execution performance — enabling risk and compliance teams to manage conflict clearance throughput and quality."
  source: "`legal_ecm`.`intake`.`conflict_search`"
  dimensions:
    - name: "search_status"
      expr: search_status
      comment: "Current status of the conflict search (e.g. Pending, Completed, Escalated, Failed)."
    - name: "search_scope"
      expr: search_scope
      comment: "Scope of the conflict search (e.g. Matter, Client, Party) — informs search coverage analysis."
    - name: "search_priority"
      expr: search_priority
      comment: "Priority level assigned to the conflict search — used to monitor SLA compliance by priority tier."
    - name: "party_type"
      expr: party_type
      comment: "Type of party being searched (e.g. Individual, Corporate, Government) — enables party-type risk analysis."
    - name: "party_role"
      expr: party_role
      comment: "Role of the party in the matter (e.g. Client, Adverse Party, Witness) — informs conflict pattern analysis."
    - name: "search_algorithm_type"
      expr: search_algorithm_type
      comment: "Algorithm used for the conflict search — enables search methodology effectiveness comparison."
    - name: "automated_search_flag"
      expr: automated_search_flag
      comment: "Boolean flag indicating whether the search was automated — tracks automation adoption rate."
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Boolean flag indicating whether the search result required escalation — key risk signal dimension."
    - name: "office_location_code"
      expr: office_location_code
      comment: "Office location where the conflict search was initiated — supports geographic conflict pattern analysis."
    - name: "practice_group_code"
      expr: practice_group_code
      comment: "Practice group associated with the conflict search — enables practice-level conflict rate analysis."
    - name: "search_month"
      expr: DATE_TRUNC('MONTH', search_executed_timestamp)
      comment: "Month the conflict search was executed — primary time dimension for search volume trending."
    - name: "search_quarter"
      expr: DATE_TRUNC('QUARTER', search_executed_timestamp)
      comment: "Quarter the conflict search was executed — supports quarterly compliance reporting."
  measures:
    - name: "total_conflict_searches"
      expr: COUNT(1)
      comment: "Total number of conflict searches performed. Baseline compliance activity volume metric."
    - name: "escalated_searches"
      expr: COUNT(CASE WHEN escalation_required_flag = TRUE THEN 1 END)
      comment: "Number of conflict searches requiring escalation. Elevated escalation rates indicate systemic conflict exposure."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of conflict searches that required escalation. Core conflict risk KPI for risk committee and managing partners."
    - name: "automated_search_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN automated_search_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of conflict searches performed via automated systems. Tracks technology adoption and operational efficiency in conflict clearance."
    - name: "avg_match_threshold_percentage"
      expr: AVG(CAST(match_threshold_percentage AS DOUBLE))
      comment: "Average match threshold percentage applied across conflict searches. Informs calibration of search sensitivity vs. false positive rates."
    - name: "searches_with_results_exported"
      expr: COUNT(CASE WHEN results_exported_flag = TRUE THEN 1 END)
      comment: "Number of conflict searches where results were exported for review. Tracks documentation compliance in the conflict clearance process."
    - name: "unique_parties_searched"
      expr: COUNT(DISTINCT party_name_searched)
      comment: "Number of distinct party names searched across all conflict searches. Measures breadth of conflict screening coverage."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`intake_letter_of_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Letter of Engagement (LOE) lifecycle KPI layer. Tracks LOE issuance volumes, acceptance rates, estimated fee commitments, retainer values, and compliance completeness — enabling finance, risk, and practice leadership to monitor client formalisation and revenue commitment."
  source: "`legal_ecm`.`intake`.`letter_of_engagement`"
  dimensions:
    - name: "loe_status"
      expr: loe_status
      comment: "Current status of the Letter of Engagement (e.g. Draft, Issued, Accepted, Rejected, Superseded)."
    - name: "loe_type"
      expr: loe_type
      comment: "Type of LOE (e.g. New Matter, Retainer, Amendment) — enables LOE mix analysis."
    - name: "matter_type"
      expr: matter_type
      comment: "Type of legal matter covered by the LOE — enables practice-area fee commitment analysis."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency specified in the LOE (e.g. Monthly, Quarterly, On Completion) — informs cash flow planning."
    - name: "governing_law_jurisdiction"
      expr: governing_law_jurisdiction
      comment: "Jurisdiction governing the LOE — supports geographic revenue commitment analysis."
    - name: "dispute_resolution_method"
      expr: dispute_resolution_method
      comment: "Dispute resolution method specified in the LOE (e.g. Arbitration, Litigation, Mediation)."
    - name: "kyc_aml_completed_flag"
      expr: kyc_aml_completed_flag
      comment: "Boolean flag indicating whether KYC/AML was completed before LOE issuance — compliance gate dimension."
    - name: "gdpr_consent_flag"
      expr: gdpr_consent_flag
      comment: "Boolean flag indicating whether GDPR consent was obtained — data protection compliance dimension."
    - name: "lpp_acknowledgment_flag"
      expr: lpp_acknowledgment_flag
      comment: "Boolean flag indicating whether Legal Professional Privilege acknowledgment was obtained."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the LOE was issued — primary time dimension for LOE volume and fee commitment trending."
    - name: "issue_quarter"
      expr: DATE_TRUNC('QUARTER', issue_date)
      comment: "Quarter the LOE was issued — supports quarterly revenue commitment reporting."
    - name: "data_protection_jurisdiction"
      expr: data_protection_jurisdiction
      comment: "Jurisdiction under which data protection obligations apply — supports regulatory compliance reporting."
  measures:
    - name: "total_loes_issued"
      expr: COUNT(1)
      comment: "Total number of Letters of Engagement issued. Baseline client formalisation volume metric."
    - name: "accepted_loes"
      expr: COUNT(CASE WHEN loe_status = 'Accepted' THEN 1 END)
      comment: "Number of LOEs accepted by clients. Measures successful client onboarding formalisation."
    - name: "loe_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN loe_status = 'Accepted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of issued LOEs that were accepted. Tracks client commitment conversion rate — a leading indicator of matter opening."
    - name: "total_estimated_fee_committed"
      expr: SUM(CAST(estimated_fee_amount AS DOUBLE))
      comment: "Total estimated fee value across all LOEs. Represents the gross fee revenue formally committed through engagement letters."
    - name: "total_retainer_value"
      expr: SUM(CAST(retainer_amount AS DOUBLE))
      comment: "Total retainer amount across all LOEs. Tracks upfront revenue secured and trust account funding requirements."
    - name: "avg_estimated_fee_per_loe"
      expr: AVG(CAST(estimated_fee_amount AS DOUBLE))
      comment: "Average estimated fee per LOE. Tracks deal size trends in formalised engagements."
    - name: "kyc_aml_incomplete_loes"
      expr: COUNT(CASE WHEN kyc_aml_completed_flag = FALSE OR kyc_aml_completed_flag IS NULL THEN 1 END)
      comment: "Number of LOEs issued without completed KYC/AML. Regulatory compliance risk indicator — these engagements carry elevated regulatory exposure."
    - name: "loes_missing_gdpr_consent"
      expr: COUNT(CASE WHEN gdpr_consent_flag = FALSE OR gdpr_consent_flag IS NULL THEN 1 END)
      comment: "Number of LOEs without GDPR consent recorded. Data protection compliance gap metric for DPO reporting."
    - name: "superseded_loes"
      expr: COUNT(CASE WHEN loe_status = 'Superseded' THEN 1 END)
      comment: "Number of LOEs that were superseded by a revised version. Tracks amendment frequency and scope change activity."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`intake_matter_opening_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Matter opening request KPI layer. Tracks request volumes, approval throughput, rejection rates, estimated fee and disbursement pipeline, and compliance requirements — enabling operations, finance, and practice leadership to manage the matter activation process."
  source: "`legal_ecm`.`intake`.`request`"
  dimensions:
    - name: "office_code"
      expr: office_code
      comment: "Office where the matter will be managed — supports geographic matter opening analysis."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month the matter opening request was submitted — primary time dimension for volume trending."
    - name: "submission_quarter"
      expr: DATE_TRUNC('QUARTER', submission_timestamp)
      comment: "Quarter the matter opening request was submitted — supports quarterly operational reporting."
  measures:
    - name: "total_matter_opening_requests"
      expr: COUNT(1)
      comment: "Total number of matter opening requests submitted. Baseline operational volume metric for matter activation throughput."
    - name: "total_estimated_fee_pipeline"
      expr: SUM(CAST(estimated_fee_amount AS DOUBLE))
      comment: "Total estimated fee value across all matter opening requests. Represents the revenue pipeline entering active matter management."
    - name: "avg_estimated_fee_per_request"
      expr: AVG(CAST(estimated_fee_amount AS DOUBLE))
      comment: "Average estimated fee per matter opening request. Tracks deal size trends in matter activation."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`intake_origination_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Origination credit allocation KPI layer. Tracks credit amounts, allocation rates, cross-border activity, strategic client origination, and fee arrangement mix — enabling firm leadership and compensation committees to govern partner origination credit and business development incentives."
  source: "`legal_ecm`.`intake`.`origination_credit`"
  dimensions:
    - name: "credit_type"
      expr: credit_type
      comment: "Type of origination credit (e.g. Origination, Responsible Attorney, Billing) — primary dimension for credit mix analysis."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of the credit allocation (e.g. Pending, Approved, Locked) — tracks credit governance workflow."
    - name: "matter_type"
      expr: matter_type
      comment: "Type of matter generating the origination credit — enables practice-area credit distribution analysis."
    - name: "industry_sector"
      expr: industry_sector
      comment: "Industry sector of the client generating the credit — supports sector-based BD performance analysis."
    - name: "primary_jurisdiction"
      expr: primary_jurisdiction
      comment: "Primary jurisdiction of the matter — informs geographic origination credit distribution."
    - name: "credited_office"
      expr: credited_office
      comment: "Office receiving the origination credit — supports office-level BD performance reporting."
    - name: "fee_arrangement_type"
      expr: fee_arrangement_type
      comment: "Fee arrangement type associated with the credited matter — tracks pricing strategy by origination source."
    - name: "origination_source"
      expr: origination_source
      comment: "Source of the origination (e.g. Referral, Direct, Cross-sell) — informs BD channel effectiveness."
    - name: "is_cross_border"
      expr: is_cross_border
      comment: "Boolean flag indicating whether the matter is cross-border — tracks international BD activity."
    - name: "is_strategic_client"
      expr: is_strategic_client
      comment: "Boolean flag indicating whether the client is classified as strategic — enables strategic account origination analysis."
    - name: "compensation_year"
      expr: compensation_year
      comment: "Compensation year to which the credit applies — primary time dimension for annual partner compensation reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the credit amount is denominated."
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month the origination credit was allocated — supports monthly credit accrual reporting."
  measures:
    - name: "total_origination_credits"
      expr: COUNT(1)
      comment: "Total number of origination credit records. Baseline BD activity volume metric."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total origination credit amount allocated. Core partner compensation KPI — directly drives partner remuneration decisions."
    - name: "avg_credit_amount"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average origination credit amount per record. Tracks deal size trends in credited originations."
    - name: "total_expected_engagement_value"
      expr: SUM(CAST(expected_engagement_value AS DOUBLE))
      comment: "Total expected engagement value across all origination credits. Represents the gross revenue pipeline attributed to originating partners."
    - name: "avg_credit_percentage"
      expr: AVG(CAST(credit_percentage AS DOUBLE))
      comment: "Average credit percentage allocated per origination record. Tracks credit allocation generosity and split patterns."
    - name: "cross_border_credit_amount"
      expr: SUM(CASE WHEN is_cross_border = TRUE THEN CAST(credit_amount AS DOUBLE) ELSE 0 END)
      comment: "Total origination credit amount from cross-border matters. Measures international BD contribution to firm revenue."
    - name: "strategic_client_credit_amount"
      expr: SUM(CASE WHEN is_strategic_client = TRUE THEN CAST(credit_amount AS DOUBLE) ELSE 0 END)
      comment: "Total origination credit amount from strategic clients. Tracks BD investment returns on priority client relationships."
    - name: "strategic_client_credit_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_strategic_client = TRUE THEN CAST(credit_amount AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(credit_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total origination credit attributable to strategic clients. Measures concentration of BD success on priority accounts."
    - name: "approved_credit_amount"
      expr: SUM(CASE WHEN allocation_status = 'Approved' THEN CAST(credit_amount AS DOUBLE) ELSE 0 END)
      comment: "Total origination credit amount with approved allocation status. Represents confirmed partner compensation commitments."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`intake_prospect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prospect pipeline KPI layer. Tracks prospect volumes, pipeline stage distribution, estimated matter value, win probability, conversion rates, and referral source effectiveness — enabling BD directors and practice group heads to manage the pre-engagement pipeline."
  source: "`legal_ecm`.`intake`.`prospect`"
  dimensions:
    - name: "pipeline_stage"
      expr: pipeline_stage
      comment: "Current stage of the prospect in the BD pipeline (e.g. Identified, Qualified, Proposal, Negotiation, Converted, Lost)."
    - name: "prospect_type"
      expr: prospect_type
      comment: "Type of prospect (e.g. New Client, Existing Client Expansion, Referral) — informs pipeline composition analysis."
    - name: "industry_sector"
      expr: industry_sector
      comment: "Industry sector of the prospect — supports sector-based BD targeting strategy."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction relevant to the prospect — informs geographic pipeline distribution."
    - name: "conflict_check_status"
      expr: conflict_check_status
      comment: "Conflict check status for the prospect — compliance gate dimension."
    - name: "kyc_status"
      expr: kyc_status
      comment: "KYC screening status for the prospect — regulatory compliance dimension."
    - name: "aml_screening_status"
      expr: aml_screening_status
      comment: "AML screening status for the prospect — anti-money laundering compliance dimension."
    - name: "source_type"
      expr: source_type
      comment: "Source type that generated the prospect (e.g. Referral, Direct, Event, Digital) — informs channel effectiveness analysis."
    - name: "referral_source_type"
      expr: referral_source_type
      comment: "Type of referral source (e.g. Client, Intermediary, Alumni) — enables referral channel performance analysis."
    - name: "proposed_fee_arrangement_type"
      expr: proposed_fee_arrangement_type
      comment: "Proposed fee arrangement type for the prospect — tracks pricing strategy in the pipeline."
    - name: "estimated_value_currency"
      expr: estimated_value_currency
      comment: "Currency of the estimated matter value — required for multi-currency pipeline reporting."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the prospect was created — primary time dimension for new pipeline generation trending."
    - name: "created_quarter"
      expr: DATE_TRUNC('QUARTER', created_timestamp)
      comment: "Quarter the prospect was created — supports quarterly pipeline generation reporting."
  measures:
    - name: "total_prospects"
      expr: COUNT(1)
      comment: "Total number of prospects in the pipeline. Baseline BD pipeline volume metric."
    - name: "converted_prospects"
      expr: COUNT(CASE WHEN converted_to_client_date IS NOT NULL THEN 1 END)
      comment: "Number of prospects that converted to clients. Core BD conversion KPI."
    - name: "prospect_conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN converted_to_client_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prospects that converted to clients. Primary BD pipeline effectiveness KPI for executive reporting."
    - name: "total_estimated_pipeline_value"
      expr: SUM(CAST(estimated_matter_value AS DOUBLE))
      comment: "Total estimated matter value across all prospects. Represents the gross revenue opportunity in the pre-engagement pipeline."
    - name: "weighted_pipeline_value"
      expr: SUM(CAST(estimated_matter_value AS DOUBLE) * CAST(win_probability_percent AS DOUBLE) / 100.0)
      comment: "Probability-weighted prospect pipeline value. Most accurate forward revenue forecast from the prospect pipeline."
    - name: "avg_estimated_matter_value"
      expr: AVG(CAST(estimated_matter_value AS DOUBLE))
      comment: "Average estimated matter value per prospect. Tracks deal size trends in the pre-engagement pipeline."
    - name: "avg_win_probability_pct"
      expr: AVG(CAST(win_probability_percent AS DOUBLE))
      comment: "Average win probability across all prospects. Indicates overall pipeline quality and BD confidence."
    - name: "conflict_check_pending_prospects"
      expr: COUNT(CASE WHEN conflict_check_status = 'Pending' THEN 1 END)
      comment: "Number of prospects with a pending conflict check. Unresolved conflicts block engagement — operational risk metric."
    - name: "kyc_incomplete_prospects"
      expr: COUNT(CASE WHEN kyc_status NOT IN ('Passed', 'Completed') THEN 1 END)
      comment: "Number of prospects where KYC has not been completed. Regulatory compliance risk indicator for the prospect pipeline."
    - name: "referral_sourced_prospects"
      expr: COUNT(CASE WHEN source_type = 'Referral' THEN 1 END)
      comment: "Number of prospects sourced through referrals. Tracks referral channel contribution to pipeline generation."
    - name: "referral_conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN source_type = 'Referral' AND converted_to_client_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN source_type = 'Referral' THEN 1 END), 0), 2)
      comment: "Conversion rate for referral-sourced prospects. Measures referral channel quality relative to other BD channels."
$$;