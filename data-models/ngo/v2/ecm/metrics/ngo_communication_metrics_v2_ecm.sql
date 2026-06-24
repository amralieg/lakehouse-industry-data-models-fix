-- Metric views for domain: communication | Business: Ngo | Version: 2 | Generated on: 2026-06-23 01:23:48

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`communication_advocacy_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for advocacy campaigns tracking fundraising performance, budget efficiency, and reach vs. target attainment. Supports executive decisions on campaign investment, channel mix, and SDG-aligned advocacy spend. Relevant for NGO communications directors, fundraising VPs, and program leads using tools such as Salesforce Nonprofit Cloud, Raisers Edge NXT, or SAP-integrated CRM layers."
  source: "`vibe_ngo_v1`.`communication`.`advocacy_campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current lifecycle status of the advocacy campaign (e.g. Active, Closed, Draft). Used to filter live vs. historical performance."
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of advocacy campaign (e.g. Digital, Field, Media). Enables channel-level performance comparison."
    - name: "geographic_focus"
      expr: geographic_focus
      comment: "Geographic region or country focus of the campaign. Supports regional performance analysis."
    - name: "theme"
      expr: theme
      comment: "Thematic area of the campaign (e.g. Protection, WASH, Education). Links campaign activity to programmatic priorities."
    - name: "sdg_alignment_tags"
      expr: sdg_alignment_tags
      comment: "SDG goals the campaign is aligned to. Enables donor reporting and impact attribution by SDG."
    - name: "language_primary"
      expr: language_primary
      comment: "Primary language of campaign materials. Supports localization and inclusion analysis."
    - name: "is_donor_restricted"
      expr: is_donor_restricted
      comment: "Whether the campaign is subject to donor restrictions. Critical for compliance and spend eligibility reporting."
    - name: "launch_year_month"
      expr: DATE_TRUNC('MONTH', launch_date)
      comment: "Month the campaign launched. Enables trend analysis of campaign activity over time."
    - name: "compliance_review_status"
      expr: compliance_review_status
      comment: "Status of compliance review for the campaign. Flags campaigns pending or failing compliance checks."
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of advocacy campaigns. Baseline volume metric for portfolio sizing and trend tracking."
    - name: "total_actual_fundraising_amount_usd"
      expr: SUM(CAST(actual_fundraising_amount AS DOUBLE))
      comment: "Total funds raised across all advocacy campaigns. Primary revenue KPI for fundraising leadership."
    - name: "total_target_fundraising_amount_usd"
      expr: SUM(CAST(target_fundraising_amount AS DOUBLE))
      comment: "Total fundraising target across campaigns. Used as denominator for fundraising attainment rate."
    - name: "fundraising_attainment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_fundraising_amount AS DOUBLE)) / NULLIF(SUM(CAST(target_fundraising_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of fundraising target achieved. Core KPI for campaign effectiveness — drives investment reallocation decisions."
    - name: "total_actual_spend_amount_usd"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend across advocacy campaigns. Used for budget variance and cost efficiency analysis."
    - name: "total_budget_allocated_amount_usd"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated to advocacy campaigns. Paired with actual spend to compute utilization."
    - name: "budget_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_allocated_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated budget spent. Signals under- or over-spend requiring management action."
    - name: "avg_fundraising_per_campaign_usd"
      expr: AVG(CAST(actual_fundraising_amount AS DOUBLE))
      comment: "Average funds raised per campaign. Benchmarks campaign productivity and informs portfolio planning."
    - name: "avg_cost_per_campaign_usd"
      expr: AVG(CAST(actual_spend_amount AS DOUBLE))
      comment: "Average spend per campaign. Supports cost-efficiency benchmarking across campaign types and geographies."
    - name: "return_on_campaign_spend"
      expr: ROUND(SUM(CAST(actual_fundraising_amount AS DOUBLE)) / NULLIF(SUM(CAST(actual_spend_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of funds raised to spend. Key efficiency metric — campaigns below 1.0 cost more than they raise."
    - name: "donor_restricted_campaign_count"
      expr: COUNT(CASE WHEN is_donor_restricted = TRUE THEN 1 END)
      comment: "Number of campaigns with donor restrictions. Compliance risk indicator for restricted-fund management."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`communication_campaign_touchpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engagement and conversion analytics for individual campaign touchpoints. Enables channel effectiveness, cost-per-conversion, and audience sentiment analysis. Used by communications and fundraising teams to optimize multi-channel outreach strategies. Relevant to tools such as Salesforce Marketing Cloud, Mailchimp, and integrated CRM platforms."
  source: "`vibe_ngo_v1`.`communication`.`campaign_touchpoint`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Communication channel used for the touchpoint (e.g. Email, SMS, Social Media). Core dimension for channel mix analysis."
    - name: "touchpoint_type"
      expr: touchpoint_type
      comment: "Type of touchpoint interaction (e.g. Outreach, Follow-up, Event). Supports funnel stage analysis."
    - name: "conversion_flag"
      expr: conversion_flag
      comment: "Whether the touchpoint resulted in a conversion. Used to segment converted vs. non-converted touchpoints."
    - name: "conversion_type"
      expr: conversion_type
      comment: "Type of conversion achieved (e.g. Donation, Pledge, Signup). Enables conversion quality analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device used by the recipient (e.g. Mobile, Desktop). Informs digital channel optimization."
    - name: "language_preference"
      expr: language_preference
      comment: "Recipient language preference. Supports localization effectiveness analysis."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the touchpoint message. Enables impact attribution by SDG goal."
    - name: "opt_out_flag"
      expr: opt_out_flag
      comment: "Whether the recipient opted out after this touchpoint. Critical for consent and list health monitoring."
    - name: "response_month"
      expr: DATE_TRUNC('MONTH', response_date)
      comment: "Month of touchpoint response. Enables time-series analysis of engagement trends."
  measures:
    - name: "total_touchpoints"
      expr: COUNT(1)
      comment: "Total number of campaign touchpoints delivered. Baseline volume metric for outreach scale."
    - name: "total_conversions"
      expr: COUNT(CASE WHEN conversion_flag = TRUE THEN 1 END)
      comment: "Total touchpoints that resulted in a conversion. Primary effectiveness KPI for campaign outreach."
    - name: "conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN conversion_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of touchpoints that converted. Core campaign ROI metric — drives channel investment decisions."
    - name: "total_conversion_value_usd"
      expr: SUM(CAST(conversion_value_usd AS DOUBLE))
      comment: "Total monetary value of all conversions. Revenue attribution metric for campaign financial reporting."
    - name: "total_cost_usd"
      expr: SUM(CAST(cost_per_touchpoint_usd AS DOUBLE))
      comment: "Total cost of all touchpoints. Used to compute cost-per-conversion and campaign ROI."
    - name: "avg_cost_per_touchpoint_usd"
      expr: AVG(CAST(cost_per_touchpoint_usd AS DOUBLE))
      comment: "Average cost per touchpoint. Benchmarks channel efficiency and informs budget allocation."
    - name: "cost_per_conversion_usd"
      expr: ROUND(SUM(CAST(cost_per_touchpoint_usd AS DOUBLE)) / NULLIF(COUNT(CASE WHEN conversion_flag = TRUE THEN 1 END), 0), 2)
      comment: "Average cost to achieve one conversion. Key efficiency metric — high values signal channel underperformance."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across touchpoints. Tracks audience perception trends and flags negative sentiment spikes."
    - name: "opt_out_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN opt_out_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of touchpoints resulting in opt-out. High values signal messaging fatigue or relevance issues requiring immediate action."
    - name: "unique_constituents_reached"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of distinct constituents reached. Measures actual audience breadth vs. touchpoint volume."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`communication_email_broadcast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Email broadcast performance metrics covering deliverability, engagement, and compliance. Supports communications teams in optimizing email strategy, managing list health, and ensuring consent compliance. Relevant to ESP platforms (Mailchimp, Salesforce Marketing Cloud, Brevo) and integrated NGO CRM stacks."
  source: "`vibe_ngo_v1`.`communication`.`email_broadcast`"
  dimensions:
    - name: "broadcast_status"
      expr: broadcast_status
      comment: "Current status of the email broadcast (e.g. Sent, Draft, Scheduled). Filters active vs. historical broadcasts."
    - name: "broadcast_type"
      expr: broadcast_type
      comment: "Type of broadcast (e.g. Newsletter, Appeal, Stewardship). Enables performance comparison by communication purpose."
    - name: "esp_platform"
      expr: esp_platform
      comment: "Email service provider platform used. Supports platform benchmarking and migration decisions."
    - name: "language_code"
      expr: language_code
      comment: "Language of the broadcast. Supports localization performance analysis."
    - name: "is_ab_test"
      expr: is_ab_test
      comment: "Whether the broadcast was an A/B test. Enables comparison of test vs. standard broadcast performance."
    - name: "consent_verified"
      expr: consent_verified
      comment: "Whether consent was verified before sending. Critical compliance dimension for GDPR and donor audit readiness."
    - name: "compliance_check_status"
      expr: compliance_check_status
      comment: "Status of pre-send compliance check. Flags broadcasts sent without passing compliance review."
    - name: "send_month"
      expr: DATE_TRUNC('MONTH', send_date)
      comment: "Month the broadcast was sent. Enables time-series analysis of email volume and performance trends."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the broadcast content. Supports impact communication reporting by SDG goal."
  measures:
    - name: "total_broadcasts"
      expr: COUNT(1)
      comment: "Total number of email broadcasts sent. Baseline volume metric for communications activity tracking."
    - name: "broadcasts_with_consent_verified"
      expr: COUNT(CASE WHEN consent_verified = TRUE THEN 1 END)
      comment: "Number of broadcasts where consent was verified. Compliance KPI — low values signal GDPR/data protection risk."
    - name: "consent_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_verified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of broadcasts sent with verified consent. Critical compliance metric for donor audits and regulatory reporting."
    - name: "ab_test_broadcast_count"
      expr: COUNT(CASE WHEN is_ab_test = TRUE THEN 1 END)
      comment: "Number of A/B test broadcasts. Tracks investment in evidence-based email optimization."
    - name: "broadcasts_passing_compliance_check"
      expr: COUNT(CASE WHEN compliance_check_status = 'Passed' THEN 1 END)
      comment: "Number of broadcasts that passed compliance review. Operational quality metric for communications governance."
    - name: "compliance_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_check_status = 'Passed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of broadcasts passing compliance check. Drives process improvement in pre-send review workflows."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`communication_feedback_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accountability and feedback mechanism (AAP) KPIs tracking case volume, resolution performance, SLA compliance, and escalation rates. Core to CHS Commitment 5 (complaints and feedback) and donor accountability reporting. Used by MEAL teams, country directors, and protection leads. Relevant to KoboToolbox, Commcare, and Primero integrations."
  source: "`vibe_ngo_v1`.`communication`.`feedback_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the feedback case (e.g. Open, Closed, Escalated). Primary operational dimension for case management."
    - name: "case_type"
      expr: case_type
      comment: "Type of feedback case (e.g. Complaint, Suggestion, Inquiry). Enables categorization of feedback by nature."
    - name: "case_category"
      expr: case_category
      comment: "Category of the feedback case. Supports thematic analysis of feedback trends."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the case. Enables SLA monitoring by priority tier."
    - name: "escalation_tier"
      expr: escalation_tier
      comment: "Escalation level reached by the case. Tracks severity of unresolved or complex cases."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which feedback was submitted (e.g. Hotline, In-person, Digital). Informs channel accessibility analysis."
    - name: "is_anonymous"
      expr: is_anonymous
      comment: "Whether the case was submitted anonymously. Tracks safe reporting channel utilization."
    - name: "is_sensitive"
      expr: is_sensitive
      comment: "Whether the case is flagged as sensitive. Drives data protection and handling protocol decisions."
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Month the feedback case was received. Enables trend analysis of feedback volume over time."
    - name: "language_of_submission"
      expr: language_of_submission
      comment: "Language in which feedback was submitted. Supports inclusion and language accessibility analysis."
  measures:
    - name: "total_feedback_cases"
      expr: COUNT(1)
      comment: "Total number of feedback cases received. Baseline AAP volume metric for accountability reporting."
    - name: "total_closed_cases"
      expr: COUNT(CASE WHEN case_status = 'Closed' THEN 1 END)
      comment: "Total cases closed. Used to compute resolution rate and track case management throughput."
    - name: "case_resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN case_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of feedback cases resolved. Core CHS accountability KPI — low rates trigger management escalation."
    - name: "total_escalated_cases"
      expr: COUNT(CASE WHEN escalation_tier IS NOT NULL AND escalation_tier != '' THEN 1 END)
      comment: "Total cases that were escalated. Tracks severity and complexity of feedback requiring senior intervention."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_tier IS NOT NULL AND escalation_tier != '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases escalated. High rates signal systemic service delivery issues requiring leadership action."
    - name: "sensitive_case_count"
      expr: COUNT(CASE WHEN is_sensitive = TRUE THEN 1 END)
      comment: "Number of sensitive feedback cases. Drives data protection protocol activation and safeguarding referral decisions."
    - name: "anonymous_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_anonymous = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases submitted anonymously. High rates may indicate fear of reprisal — a key protection and trust indicator."
    - name: "unique_project_sites_with_cases"
      expr: COUNT(DISTINCT project_site_id)
      comment: "Number of distinct project sites generating feedback cases. Measures geographic breadth of accountability mechanism reach."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`communication_feedback_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational metrics for individual feedback submissions tracking volume, escalation, resolution, and geographic distribution. Supports field accountability teams, MEAL officers, and country directors in monitoring community feedback channels. Relevant to KoboToolbox, Commcare, and DHIS2 integrations."
  source: "`vibe_ngo_v1`.`communication`.`feedback_submission`"
  dimensions:
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of the feedback submission. Primary operational dimension for case management dashboards."
    - name: "channel"
      expr: channel
      comment: "Submission channel (e.g. Hotline, In-person, SMS). Enables channel accessibility and reach analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the feedback submission. Drives prioritization and escalation decisions."
    - name: "is_anonymous"
      expr: is_anonymous
      comment: "Whether the submission was anonymous. Tracks safe reporting channel utilization."
    - name: "is_sensitive"
      expr: is_sensitive
      comment: "Whether the submission is flagged as sensitive. Drives data protection handling protocols."
    - name: "requires_escalation"
      expr: requires_escalation
      comment: "Whether the submission requires escalation. Operational flag for case management prioritization."
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Whether follow-up action is required. Tracks open action items in the feedback pipeline."
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "Administrative level 1 (e.g. province/state) of submission origin. Enables geographic hotspot analysis."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of submission. Enables time-series trend analysis of feedback volume."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total feedback submissions received. Baseline AAP volume metric."
    - name: "total_resolved_submissions"
      expr: COUNT(CASE WHEN resolution_status = 'Resolved' THEN 1 END)
      comment: "Total submissions resolved. Used to compute resolution rate and track accountability pipeline throughput."
    - name: "submission_resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN resolution_status = 'Resolved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions resolved. Core AAP performance KPI for CHS compliance and donor reporting."
    - name: "escalation_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN requires_escalation = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions requiring escalation. High rates signal systemic issues in service delivery or protection."
    - name: "sensitive_submission_count"
      expr: COUNT(CASE WHEN is_sensitive = TRUE THEN 1 END)
      comment: "Number of sensitive submissions. Drives data protection protocol activation and safeguarding referral decisions."
    - name: "anonymous_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_anonymous = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of anonymous submissions. Indicator of community trust and safety in reporting mechanisms."
    - name: "unique_communities_submitting"
      expr: COUNT(DISTINCT community_name)
      comment: "Number of distinct communities submitting feedback. Measures geographic reach of accountability mechanisms."
    - name: "unique_project_sites_with_submissions"
      expr: COUNT(DISTINCT project_site_id)
      comment: "Number of distinct project sites with feedback submissions. Tracks AAP coverage across field operations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`communication_constituent_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent management KPIs tracking consent coverage, channel opt-in rates, expiry risk, and compliance posture. Critical for GDPR, PECR, and donor data protection compliance. Used by data protection officers, compliance teams, and CRM administrators. Relevant to Salesforce Nonprofit Cloud, Raisers Edge NXT, and custom consent management systems."
  source: "`vibe_ngo_v1`.`communication`.`constituent_consent`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent record (e.g. Active, Withdrawn, Expired). Primary compliance dimension."
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent (e.g. Marketing, Data Processing, Research). Enables compliance analysis by consent category."
    - name: "consent_method"
      expr: consent_method
      comment: "Method by which consent was obtained (e.g. Online Form, In-person, Double Opt-in). Supports audit trail analysis."
    - name: "consent_basis"
      expr: consent_basis
      comment: "Legal basis for consent (e.g. Explicit, Legitimate Interest). Critical for GDPR compliance reporting."
    - name: "consent_language"
      expr: consent_language
      comment: "Language in which consent was obtained. Supports inclusion and localization compliance analysis."
    - name: "is_minor"
      expr: is_minor
      comment: "Whether the constituent is a minor. Drives parental consent requirement tracking and child protection compliance."
    - name: "double_opt_in_confirmed"
      expr: double_opt_in_confirmed
      comment: "Whether double opt-in was confirmed. Tracks email list quality and compliance with best-practice consent standards."
    - name: "consent_granted_month"
      expr: DATE_TRUNC('MONTH', consent_granted_date)
      comment: "Month consent was granted. Enables trend analysis of consent acquisition over time."
  measures:
    - name: "total_consent_records"
      expr: COUNT(1)
      comment: "Total consent records. Baseline metric for consent database size and coverage."
    - name: "active_consent_count"
      expr: COUNT(CASE WHEN consent_status = 'Active' THEN 1 END)
      comment: "Number of active consent records. Defines the legally contactable audience size."
    - name: "consent_active_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records that are active. Low rates signal list decay and reduced contactable audience."
    - name: "withdrawn_consent_count"
      expr: COUNT(CASE WHEN consent_status = 'Withdrawn' THEN 1 END)
      comment: "Number of withdrawn consent records. Tracks opt-out volume — spikes require immediate communications strategy review."
    - name: "consent_withdrawal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_status = 'Withdrawn' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consents withdrawn. Rising rates signal audience disengagement or trust issues."
    - name: "minor_consent_records_count"
      expr: COUNT(CASE WHEN is_minor = TRUE THEN 1 END)
      comment: "Number of consent records for minors. Drives parental consent verification and child protection compliance monitoring."
    - name: "parental_consent_obtained_count"
      expr: COUNT(CASE WHEN parental_consent_obtained = TRUE THEN 1 END)
      comment: "Number of minor records with parental consent obtained. Compliance KPI for child data protection requirements."
    - name: "double_opt_in_confirmation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN double_opt_in_confirmed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consents confirmed via double opt-in. Higher rates indicate stronger list quality and compliance posture."
    - name: "unique_constituents_with_consent"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of distinct constituents with at least one consent record. Measures consent database coverage."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`communication_constituent_message`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Constituent messaging performance KPIs covering delivery rates, engagement (open, click, reply), opt-out trends, and sentiment. Used by communications managers and CRM teams to optimize outreach quality and monitor list health. Relevant to Salesforce Marketing Cloud, Mailchimp, and integrated NGO CRM platforms."
  source: "`vibe_ngo_v1`.`communication`.`constituent_message`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Communication channel used (e.g. Email, SMS, WhatsApp). Core dimension for channel performance analysis."
    - name: "message_type"
      expr: message_type
      comment: "Type of message (e.g. Appeal, Stewardship, Notification). Enables performance comparison by message purpose."
    - name: "message_direction"
      expr: message_direction
      comment: "Direction of message (Inbound/Outbound). Separates sent communications from received responses."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the message (e.g. Delivered, Bounced, Failed). Primary deliverability dimension."
    - name: "language_code"
      expr: language_code
      comment: "Language of the message. Supports localization and inclusion analysis."
    - name: "opt_out_flag"
      expr: opt_out_flag
      comment: "Whether the recipient opted out. Critical for consent compliance and list health monitoring."
    - name: "priority"
      expr: priority
      comment: "Message priority level. Enables SLA monitoring for high-priority constituent communications."
    - name: "sent_month"
      expr: DATE_TRUNC('MONTH', sent_timestamp)
      comment: "Month the message was sent. Enables time-series analysis of messaging volume and engagement trends."
  measures:
    - name: "total_messages"
      expr: COUNT(1)
      comment: "Total constituent messages. Baseline volume metric for communications activity."
    - name: "total_opened_messages"
      expr: COUNT(CASE WHEN opened_flag = TRUE THEN 1 END)
      comment: "Total messages opened by recipients. Core engagement metric for outreach effectiveness."
    - name: "message_open_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN opened_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of messages opened. Key engagement KPI — low rates trigger subject line and timing optimization."
    - name: "total_clicked_messages"
      expr: COUNT(CASE WHEN clicked_flag = TRUE THEN 1 END)
      comment: "Total messages where a link was clicked. Measures deeper engagement beyond open."
    - name: "click_through_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN clicked_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN opened_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of opened messages where a link was clicked. Measures content relevance and call-to-action effectiveness."
    - name: "total_replied_messages"
      expr: COUNT(CASE WHEN replied_flag = TRUE THEN 1 END)
      comment: "Total messages that received a reply. Tracks two-way engagement and constituent responsiveness."
    - name: "opt_out_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN opt_out_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of messages resulting in opt-out. Rising rates signal messaging fatigue requiring immediate strategy review."
    - name: "complaint_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN complaint_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of messages generating complaints. High rates risk ESP blacklisting and donor relationship damage."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score of constituent messages. Tracks audience perception trends and flags negative sentiment spikes."
    - name: "unique_constituents_messaged"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of distinct constituents messaged. Measures actual audience reach vs. message volume."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`communication_crisis_communication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crisis communication management KPIs tracking activation volume, response speed, media engagement, and post-crisis review completion. Used by communications directors, country representatives, and executive leadership to manage organizational reputation and stakeholder trust during emergencies. Relevant to UN OCHA coordination, SAP-integrated operations, and eTools programme management."
  source: "`vibe_ngo_v1`.`communication`.`crisis_communication`"
  dimensions:
    - name: "crisis_communication_status"
      expr: crisis_communication_status
      comment: "Current status of the crisis communication (e.g. Active, Resolved, Under Review). Primary operational dimension."
    - name: "crisis_type"
      expr: crisis_type
      comment: "Type of crisis (e.g. Natural Disaster, Security Incident, Reputational). Enables crisis category analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the crisis. Drives resource allocation and escalation decisions."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the crisis. Enables regional impact analysis."
    - name: "donor_notification_required_flag"
      expr: donor_notification_required_flag
      comment: "Whether donor notification is required. Tracks compliance with donor reporting obligations during crises."
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Whether regulatory reporting is required. Drives compliance action tracking during crisis events."
    - name: "post_crisis_review_status"
      expr: post_crisis_review_status
      comment: "Status of post-crisis review. Tracks organizational learning and accountability follow-through."
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', activation_date)
      comment: "Month of crisis activation. Enables trend analysis of crisis frequency over time."
  measures:
    - name: "total_crisis_events"
      expr: COUNT(1)
      comment: "Total crisis communication events activated. Baseline metric for organizational crisis exposure."
    - name: "active_crisis_count"
      expr: COUNT(CASE WHEN crisis_communication_status = 'Active' THEN 1 END)
      comment: "Number of currently active crisis communications. Real-time operational load metric for crisis management teams."
    - name: "donor_notification_required_count"
      expr: COUNT(CASE WHEN donor_notification_required_flag = TRUE THEN 1 END)
      comment: "Number of crises requiring donor notification. Tracks compliance obligation volume during crisis periods."
    - name: "donor_notification_sent_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN donor_notification_sent_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN donor_notification_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of required donor notifications actually sent. Compliance KPI — gaps risk donor relationship and grant compliance breaches."
    - name: "post_crisis_review_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN post_crisis_review_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of crisis events with completed post-crisis reviews. Organizational learning KPI — low rates indicate accountability gaps."
    - name: "key_messages_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN key_messages_approved IS NOT NULL AND key_messages_approved != '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of crisis events with approved key messages. Tracks communications governance and message control quality."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`communication_digital_content`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital content performance KPIs covering reach, engagement, and brand/accessibility compliance. Used by digital communications teams to optimize content strategy, platform mix, and audience engagement. Relevant to social media management platforms, CMS systems, and NGO digital communications stacks."
  source: "`vibe_ngo_v1`.`communication`.`digital_content`"
  dimensions:
    - name: "content_type"
      expr: content_type
      comment: "Type of digital content (e.g. Blog, Video, Social Post, Infographic). Core dimension for content format analysis."
    - name: "content_status"
      expr: content_status
      comment: "Publication status of the content (e.g. Published, Draft, Archived). Filters active vs. historical content."
    - name: "platform"
      expr: platform
      comment: "Digital platform where content is published (e.g. Facebook, Website, YouTube). Enables platform performance comparison."
    - name: "language_code"
      expr: language_code
      comment: "Language of the content. Supports localization and multilingual reach analysis."
    - name: "is_brand_compliant"
      expr: is_brand_compliant
      comment: "Whether content meets brand guidelines. Tracks brand governance compliance across digital channels."
    - name: "is_accessibility_compliant"
      expr: is_accessibility_compliant
      comment: "Whether content meets accessibility standards. Tracks inclusion compliance for digital communications."
    - name: "target_audience"
      expr: target_audience
      comment: "Intended audience for the content. Enables audience-segment performance analysis."
    - name: "publish_month"
      expr: DATE_TRUNC('MONTH', actual_publish_timestamp)
      comment: "Month content was published. Enables time-series analysis of content volume and performance trends."
  measures:
    - name: "total_content_pieces"
      expr: COUNT(1)
      comment: "Total digital content pieces. Baseline volume metric for content production tracking."
    - name: "total_impressions"
      expr: SUM(CAST(impressions_count AS DOUBLE))
      comment: "Total impressions across all digital content. Measures overall content visibility and audience exposure."
    - name: "total_reach"
      expr: SUM(CAST(reach_count AS DOUBLE))
      comment: "Total unique audience reach across content. Measures actual audience breadth vs. impression volume."
    - name: "total_engagement_likes"
      expr: SUM(CAST(engagement_likes_count AS DOUBLE))
      comment: "Total likes across digital content. Component of overall engagement score."
    - name: "total_engagement_shares"
      expr: SUM(CAST(engagement_shares_count AS DOUBLE))
      comment: "Total shares across digital content. Shares indicate high-value content amplification."
    - name: "total_engagement_comments"
      expr: SUM(CAST(engagement_comments_count AS DOUBLE))
      comment: "Total comments across digital content. Measures audience dialogue and content resonance."
    - name: "total_video_views"
      expr: SUM(CAST(video_views_count AS DOUBLE))
      comment: "Total video views across video content. Key metric for video content strategy effectiveness."
    - name: "total_click_throughs"
      expr: SUM(CAST(click_through_count AS DOUBLE))
      comment: "Total click-throughs across digital content. Measures call-to-action effectiveness and traffic generation."
    - name: "avg_impressions_per_content"
      expr: AVG(CAST(impressions_count AS DOUBLE))
      comment: "Average impressions per content piece. Benchmarks content visibility performance across formats and platforms."
    - name: "brand_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_brand_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of content pieces meeting brand guidelines. Governance KPI for communications quality control."
    - name: "accessibility_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_accessibility_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of content meeting accessibility standards. Inclusion KPI — low rates risk excluding persons with disabilities."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`communication_donor_stewardship_touchpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor stewardship performance KPIs tracking touchpoint volume, cost efficiency, sentiment, and follow-up compliance. Used by major gifts officers, stewardship teams, and fundraising directors to manage donor relationships and retention. Relevant to Salesforce Nonprofit Cloud, Raisers Edge NXT, and SAP-integrated donor management systems."
  source: "`vibe_ngo_v1`.`communication`.`donor_stewardship_touchpoint`"
  dimensions:
    - name: "touchpoint_type"
      expr: touchpoint_type
      comment: "Type of stewardship touchpoint (e.g. Impact Report, Site Visit, Thank You Call). Core dimension for stewardship activity analysis."
    - name: "touchpoint_status"
      expr: touchpoint_status
      comment: "Status of the touchpoint (e.g. Completed, Planned, Overdue). Tracks stewardship pipeline health."
    - name: "channel"
      expr: channel
      comment: "Communication channel used (e.g. Email, In-person, Phone). Enables channel effectiveness analysis."
    - name: "donor_tier"
      expr: donor_tier
      comment: "Tier of the donor (e.g. Major, Mid-level, Mass). Enables stewardship investment analysis by donor segment."
    - name: "is_restricted_communication"
      expr: is_restricted_communication
      comment: "Whether the touchpoint involves restricted fund communication. Compliance dimension for donor-restricted reporting."
    - name: "compliance_review_status"
      expr: compliance_review_status
      comment: "Status of compliance review for the touchpoint. Tracks governance of donor communications."
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Whether follow-up action is required. Tracks open stewardship action items."
    - name: "touchpoint_month"
      expr: DATE_TRUNC('MONTH', touchpoint_date)
      comment: "Month of the stewardship touchpoint. Enables trend analysis of stewardship activity over time."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the stewardship communication. Supports impact reporting by SDG goal."
  measures:
    - name: "total_stewardship_touchpoints"
      expr: COUNT(1)
      comment: "Total donor stewardship touchpoints. Baseline metric for stewardship activity volume."
    - name: "total_stewardship_cost_usd"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of stewardship activities. Used to compute cost-per-touchpoint and stewardship ROI."
    - name: "avg_cost_per_touchpoint_usd"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per stewardship touchpoint. Benchmarks stewardship efficiency across channels and donor tiers."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average donor sentiment score across stewardship touchpoints. Tracks donor satisfaction trends — declining scores trigger relationship intervention."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score of stewardship records. Tracks CRM data integrity for donor management."
    - name: "follow_up_pending_count"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE AND touchpoint_status != 'Completed' THEN 1 END)
      comment: "Number of touchpoints with pending follow-up actions. Operational metric for stewardship pipeline management."
    - name: "restricted_communication_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_restricted_communication = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stewardship touchpoints involving restricted fund communications. Compliance risk indicator."
    - name: "unique_donors_stewarded"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of distinct donors receiving stewardship touchpoints. Measures stewardship program coverage across the donor portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`communication_impact_story`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Impact storytelling KPIs tracking story production, consent compliance, publication readiness, and donor visibility. Used by communications directors, fundraising teams, and program leads to manage the impact narrative pipeline. Critical for donor reporting, grant compliance, and public engagement. Relevant to CMS platforms, Salesforce, and SAP-integrated reporting systems."
  source: "`vibe_ngo_v1`.`communication`.`impact_story`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the impact story (e.g. Approved, Pending, Rejected). Tracks publication readiness."
    - name: "story_type"
      expr: story_type
      comment: "Type of impact story (e.g. Beneficiary Story, Program Update, Photo Essay). Enables content format analysis."
    - name: "consent_status"
      expr: consent_status
      comment: "Consent status for the story subject. Critical compliance dimension — stories without consent cannot be published."
    - name: "sensitivity_level"
      expr: sensitivity_level
      comment: "Sensitivity classification of the story. Drives data protection and publication restriction decisions."
    - name: "donor_visibility"
      expr: donor_visibility
      comment: "Donor visibility level for the story (e.g. Public, Restricted, Confidential). Enables donor reporting segmentation."
    - name: "anonymization_required"
      expr: anonymization_required
      comment: "Whether anonymization is required before publication. Tracks protection compliance for beneficiary stories."
    - name: "language_code"
      expr: language_code
      comment: "Language of the impact story. Supports multilingual content pipeline analysis."
    - name: "publication_month"
      expr: DATE_TRUNC('MONTH', publication_date)
      comment: "Month of story publication. Enables trend analysis of impact story output over time."
    - name: "thematic_area"
      expr: thematic_area
      comment: "Thematic area of the story (e.g. Protection, WASH, Education). Links stories to programmatic priorities."
  measures:
    - name: "total_impact_stories"
      expr: COUNT(1)
      comment: "Total impact stories in the pipeline. Baseline metric for communications content production."
    - name: "approved_stories_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of approved impact stories. Measures publication-ready content available for donor and public communications."
    - name: "story_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stories approved for publication. Tracks content pipeline efficiency and quality gate performance."
    - name: "consent_obtained_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stories with active consent. Critical protection compliance KPI — stories without consent must not be published."
    - name: "anonymization_required_count"
      expr: COUNT(CASE WHEN anonymization_required = TRUE THEN 1 END)
      comment: "Number of stories requiring anonymization. Tracks protection workload and compliance risk in the content pipeline."
    - name: "embargo_active_count"
      expr: COUNT(CASE WHEN embargo_flag = TRUE THEN 1 END)
      comment: "Number of stories under embargo. Tracks publication timing constraints for donor and media management."
    - name: "translation_available_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN translation_available = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stories with translations available. Measures multilingual content accessibility for diverse audiences."
    - name: "unique_countries_covered"
      expr: COUNT(DISTINCT country_id)
      comment: "Number of distinct countries represented in impact stories. Measures geographic breadth of impact narrative coverage."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`communication_community_engagement_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Community engagement event KPIs tracking participation volume, demographic inclusion, geographic reach, and event quality. Used by field teams, community engagement officers, and program managers to monitor accountability and participation mechanisms. Relevant to KoboToolbox, Commcare, and DHIS2 field data collection systems."
  source: "`vibe_ngo_v1`.`communication`.`community_engagement_event`"
  dimensions:
    - name: "event_status"
      expr: event_status
      comment: "Status of the community engagement event (e.g. Completed, Planned, Cancelled). Primary operational dimension."
    - name: "event_type"
      expr: event_type
      comment: "Type of engagement event (e.g. Community Meeting, Focus Group, Awareness Session). Enables activity type analysis."
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "Administrative level 1 (e.g. province/state) of the event. Enables geographic coverage analysis."
    - name: "community_name"
      expr: community_name
      comment: "Name of the community where the event was held. Enables community-level engagement tracking."
    - name: "translation_provided"
      expr: translation_provided
      comment: "Whether translation was provided at the event. Tracks language inclusion in community engagement."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language used at the event. Supports language accessibility analysis."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month the event was held. Enables time-series analysis of community engagement activity."
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total community engagement events held. Baseline metric for community outreach activity volume."
    - name: "total_feedback_received"
      expr: SUM(CAST(feedback_received AS DOUBLE))
      comment: "Total feedback items received across community engagement events. Measures accountability mechanism responsiveness."
    - name: "avg_feedback_per_event"
      expr: AVG(CAST(feedback_received AS DOUBLE))
      comment: "Average feedback items received per event. Benchmarks community engagement quality and participation depth."
    - name: "events_with_translation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN translation_provided = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events where translation was provided. Inclusion KPI — low rates signal language barriers in community engagement."
    - name: "unique_communities_engaged"
      expr: COUNT(DISTINCT community_name)
      comment: "Number of distinct communities engaged. Measures geographic breadth of community outreach."
    - name: "unique_project_sites_engaged"
      expr: COUNT(DISTINCT project_site_id)
      comment: "Number of distinct project sites with community engagement events. Tracks field coverage of accountability mechanisms."
    - name: "total_latitude_coverage"
      expr: COUNT(CASE WHEN latitude IS NOT NULL THEN 1 END)
      comment: "Number of events with GPS coordinates recorded. Tracks geospatial data quality for field mapping and coverage analysis."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`communication_media_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media relations and earned media KPIs tracking coverage volume, reach, media value, and sentiment. Used by communications directors and media relations teams to evaluate press strategy effectiveness and manage organizational reputation. Relevant to media monitoring platforms and NGO communications management systems."
  source: "`vibe_ngo_v1`.`communication`.`media_activity`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of media activity (e.g. Press Release, Interview, Media Briefing). Core dimension for media relations analysis."
    - name: "media_activity_status"
      expr: media_activity_status
      comment: "Status of the media activity (e.g. Published, Pending, Cancelled). Tracks media pipeline health."
    - name: "outlet_type"
      expr: outlet_type
      comment: "Type of media outlet (e.g. Print, Online, Broadcast). Enables media channel mix analysis."
    - name: "sentiment"
      expr: sentiment
      comment: "Sentiment of media coverage (e.g. Positive, Neutral, Negative). Tracks organizational reputation in media."
    - name: "language"
      expr: language
      comment: "Language of the media activity. Supports multilingual media strategy analysis."
    - name: "geographic_market"
      expr: geographic_market
      comment: "Geographic market of the media activity. Enables regional media coverage analysis."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the media activity. Supports impact communication reporting by SDG goal."
    - name: "publication_month"
      expr: DATE_TRUNC('MONTH', publication_date)
      comment: "Month of media publication. Enables trend analysis of media coverage over time."
    - name: "beneficiary_feedback_flag"
      expr: beneficiary_feedback_flag
      comment: "Whether the media activity includes beneficiary feedback. Tracks accountability and community voice in media."
  measures:
    - name: "total_media_activities"
      expr: COUNT(1)
      comment: "Total media activities. Baseline metric for media relations activity volume."
    - name: "total_media_value_usd"
      expr: SUM(CAST(media_value_usd AS DOUBLE))
      comment: "Total estimated media value of coverage. Measures earned media ROI for communications investment decisions."
    - name: "avg_media_value_per_activity_usd"
      expr: AVG(CAST(media_value_usd AS DOUBLE))
      comment: "Average media value per activity. Benchmarks media relations efficiency across activity types and outlets."
    - name: "total_reach_estimate"
      expr: SUM(CAST(reach_estimate AS DOUBLE))
      comment: "Total estimated audience reach across media activities. Measures overall communications visibility."
    - name: "total_circulation_estimate"
      expr: SUM(CAST(circulation_estimate AS DOUBLE))
      comment: "Total circulation estimate across media activities. Measures print and broadcast audience exposure."
    - name: "positive_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sentiment = 'Positive' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of media activities with positive sentiment. Reputation management KPI — declining rates trigger communications strategy review."
    - name: "negative_coverage_count"
      expr: COUNT(CASE WHEN sentiment = 'Negative' THEN 1 END)
      comment: "Number of media activities with negative sentiment. Reputation risk indicator requiring immediate communications response."
    - name: "unique_outlets_engaged"
      expr: COUNT(DISTINCT outlet_name)
      comment: "Number of distinct media outlets engaged. Measures breadth of media relations network."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`communication_message_thread`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Message thread management KPIs tracking resolution rates, response timeliness, escalation, and complaint handling. Used by constituent services teams, country offices, and communications managers to monitor two-way communication quality and SLA compliance. Relevant to CRM platforms, helpdesk systems, and integrated NGO communications stacks."
  source: "`vibe_ngo_v1`.`communication`.`message_thread`"
  dimensions:
    - name: "thread_status"
      expr: thread_status
      comment: "Current status of the message thread (e.g. Open, Closed, Escalated). Primary operational dimension."
    - name: "thread_type"
      expr: thread_type
      comment: "Type of message thread (e.g. Inquiry, Complaint, Support). Enables categorization of communication types."
    - name: "communication_channel"
      expr: communication_channel
      comment: "Channel used for the thread (e.g. Email, WhatsApp, Phone). Enables channel performance analysis."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of the thread. Tracks severity of unresolved or complex communications."
    - name: "is_complaint"
      expr: is_complaint
      comment: "Whether the thread is a complaint. Enables complaint-specific performance analysis."
    - name: "is_confidential"
      expr: is_confidential
      comment: "Whether the thread is confidential. Drives data protection and access control decisions."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the thread. Enables SLA monitoring by priority tier."
    - name: "language_code"
      expr: language_code
      comment: "Language of the thread. Supports language accessibility and inclusion analysis."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the thread was created. Enables time-series analysis of communication volume trends."
  measures:
    - name: "total_message_threads"
      expr: COUNT(1)
      comment: "Total message threads. Baseline metric for constituent communication volume."
    - name: "total_resolved_threads"
      expr: COUNT(CASE WHEN thread_status = 'Closed' THEN 1 END)
      comment: "Total resolved message threads. Used to compute resolution rate and track communication pipeline throughput."
    - name: "thread_resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN thread_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of message threads resolved. Core constituent services KPI — low rates signal backlog and service quality issues."
    - name: "complaint_thread_count"
      expr: COUNT(CASE WHEN is_complaint = TRUE THEN 1 END)
      comment: "Number of complaint threads. Tracks complaint volume as a constituent satisfaction and accountability indicator."
    - name: "complaint_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_complaint = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of threads that are complaints. Rising rates signal service delivery or communications quality issues."
    - name: "escalated_thread_count"
      expr: COUNT(CASE WHEN escalation_level IS NOT NULL AND escalation_level != '' THEN 1 END)
      comment: "Number of escalated threads. Tracks severity of unresolved communications requiring senior intervention."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across message threads. Tracks constituent satisfaction trends and flags negative sentiment spikes."
    - name: "confidential_thread_count"
      expr: COUNT(CASE WHEN is_confidential = TRUE THEN 1 END)
      comment: "Number of confidential threads. Tracks sensitive communication volume requiring data protection controls."
    - name: "unique_constituents_in_threads"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of distinct constituents engaged in message threads. Measures actual audience reach of two-way communications."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`communication_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Communication plan portfolio KPIs tracking budget utilization, approval compliance, and plan coverage. Used by communications directors and country office managers to oversee the communications planning pipeline and ensure strategic alignment. Relevant to SAP, eTools programme management, and integrated NGO planning systems."
  source: "`vibe_ngo_v1`.`communication`.`plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the communication plan (e.g. Active, Draft, Closed). Primary operational dimension."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of communication plan (e.g. Campaign, Crisis, Advocacy). Enables plan category analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the plan. Tracks governance compliance in communications planning."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the plan. Enables regional planning coverage analysis."
    - name: "compliance_review_required"
      expr: compliance_review_required
      comment: "Whether compliance review is required for the plan. Tracks compliance obligation coverage."
    - name: "compliance_review_status"
      expr: compliance_review_status
      comment: "Status of compliance review for the plan. Flags plans pending or failing compliance checks."
    - name: "language_primary"
      expr: language_primary
      comment: "Primary language of the plan. Supports localization and multilingual planning analysis."
    - name: "plan_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the plan starts. Enables time-series analysis of communications planning activity."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the communication plan. Supports strategic alignment reporting by SDG goal."
  measures:
    - name: "total_plans"
      expr: COUNT(1)
      comment: "Total communication plans. Baseline metric for communications planning portfolio size."
    - name: "total_budget_allocated_usd"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated across communication plans. Used for portfolio-level budget planning and variance analysis."
    - name: "total_actual_spend_usd"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend across communication plans. Used to compute budget utilization and variance."
    - name: "budget_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_allocated_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated budget spent across plans. Portfolio-level efficiency KPI for communications investment management."
    - name: "approved_plan_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of plans with approved status. Governance KPI — low rates signal bottlenecks in communications approval workflows."
    - name: "compliance_review_pending_count"
      expr: COUNT(CASE WHEN compliance_review_required = TRUE AND compliance_review_status != 'Completed' THEN 1 END)
      comment: "Number of plans requiring compliance review that have not yet completed it. Compliance risk indicator for communications governance."
    - name: "avg_budget_per_plan_usd"
      expr: AVG(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Average budget allocated per communication plan. Benchmarks planning investment levels across plan types and geographies."
$$;