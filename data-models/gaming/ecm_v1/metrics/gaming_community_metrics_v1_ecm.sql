-- Metric views for domain: community | Business: Gaming | Version: 1 | Generated on: 2026-05-08 07:57:15

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`community_ban`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ban business metrics"
  source: "`gaming_ecm`.`community`.`ban`"
  dimensions:
    - name: "Appeal Notes"
      expr: appeal_notes
    - name: "Appeal Outcome"
      expr: appeal_outcome
    - name: "Appeal Resolved Timestamp"
      expr: appeal_resolved_timestamp
    - name: "Appeal Status"
      expr: appeal_status
    - name: "Appeal Submitted Timestamp"
      expr: appeal_submitted_timestamp
    - name: "Ban Number"
      expr: ban_number
    - name: "Ban Scope"
      expr: ban_scope
    - name: "Ban Status"
      expr: ban_status
    - name: "Ban Type"
      expr: ban_type
    - name: "Content Rating Concern"
      expr: content_rating_concern
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Duration Hours"
      expr: duration_hours
    - name: "End Timestamp"
      expr: end_timestamp
    - name: "Evidence Attachment Count"
      expr: evidence_attachment_count
    - name: "Gdpr Consent Flag"
      expr: gdpr_consent_flag
    - name: "Internal Notes"
      expr: internal_notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ban"
      expr: COUNT(DISTINCT ban_id)
    - name: "Total Auto Moderation Score"
      expr: SUM(auto_moderation_score)
    - name: "Average Auto Moderation Score"
      expr: AVG(auto_moderation_score)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`community_chat_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chat Session business metrics"
  source: "`gaming_ecm`.`community`.`chat_session`"
  dimensions:
    - name: "Agent Team"
      expr: agent_team
    - name: "Channel"
      expr: channel
    - name: "Coppa Minor Flag"
      expr: coppa_minor_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Csat Comment"
      expr: csat_comment
    - name: "Csat Score"
      expr: csat_score
    - name: "Csat Survey Sent"
      expr: csat_survey_sent
    - name: "Escalation Reason"
      expr: escalation_reason
    - name: "First Response Time Seconds"
      expr: first_response_time_seconds
    - name: "Gdpr Data Subject Request"
      expr: gdpr_data_subject_request
    - name: "Handle Time Seconds"
      expr: handle_time_seconds
    - name: "Is Bot Handled"
      expr: is_bot_handled
    - name: "Is Escalated To Human"
      expr: is_escalated_to_human
    - name: "Is First Contact"
      expr: is_first_contact
    - name: "Is Repeat Contact"
      expr: is_repeat_contact
    - name: "Issue Category"
      expr: issue_category
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Chat Session"
      expr: COUNT(DISTINCT chat_session_id)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`community_community_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Community Event business metrics"
  source: "`gaming_ecm`.`community`.`community_event`"
  dimensions:
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Eligibility Criteria"
      expr: eligibility_criteria
    - name: "End Timestamp"
      expr: end_timestamp
    - name: "Event Code"
      expr: event_code
    - name: "Event Description"
      expr: event_description
    - name: "Event Name"
      expr: event_name
    - name: "Event Status"
      expr: event_status
    - name: "Event Type"
      expr: event_type
    - name: "External Url"
      expr: external_url
    - name: "Geographic Restriction"
      expr: geographic_restriction
    - name: "Is Age Restricted"
      expr: is_age_restricted
    - name: "Is Featured"
      expr: is_featured
    - name: "Is Recurring"
      expr: is_recurring
    - name: "K Factor Tracking Enabled"
      expr: k_factor_tracking_enabled
    - name: "Max Registrations"
      expr: max_registrations
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Community Event"
      expr: COUNT(DISTINCT community_event_id)
    - name: "Total Csat Score"
      expr: SUM(csat_score)
    - name: "Average Csat Score"
      expr: AVG(csat_score)
    - name: "Total Nps Score"
      expr: SUM(nps_score)
    - name: "Average Nps Score"
      expr: AVG(nps_score)
    - name: "Total Prize Value Usd"
      expr: SUM(prize_value_usd)
    - name: "Average Prize Value Usd"
      expr: AVG(prize_value_usd)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`community_forum`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Forum business metrics"
  source: "`gaming_ecm`.`community`.`forum`"
  dimensions:
    - name: "Allows Attachments"
      expr: allows_attachments
    - name: "Allows Ugc Submissions"
      expr: allows_ugc_submissions
    - name: "Archived Timestamp"
      expr: archived_timestamp
    - name: "Auto Lock Days Inactive"
      expr: auto_lock_days_inactive
    - name: "Banner Image Url"
      expr: banner_image_url
    - name: "Content Rating"
      expr: content_rating
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dau"
      expr: dau
    - name: "Depth Level"
      expr: depth_level
    - name: "Forum Category"
      expr: forum_category
    - name: "Forum Description"
      expr: forum_description
    - name: "Forum Name"
      expr: forum_name
    - name: "Forum Status"
      expr: forum_status
    - name: "Forum Type"
      expr: forum_type
    - name: "Icon Image Url"
      expr: icon_image_url
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Forum"
      expr: COUNT(DISTINCT forum_id)
    - name: "Total Csat Score"
      expr: SUM(csat_score)
    - name: "Average Csat Score"
      expr: AVG(csat_score)
    - name: "Total Nps Score"
      expr: SUM(nps_score)
    - name: "Average Nps Score"
      expr: AVG(nps_score)
    - name: "Total Post Count"
      expr: SUM(post_count)
    - name: "Average Post Count"
      expr: AVG(post_count)
    - name: "Total Subscriber Count"
      expr: SUM(subscriber_count)
    - name: "Average Subscriber Count"
      expr: AVG(subscriber_count)
    - name: "Total Thread Count"
      expr: SUM(thread_count)
    - name: "Average Thread Count"
      expr: AVG(thread_count)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`community_forum_post`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Forum Post business metrics"
  source: "`gaming_ecm`.`community`.`forum_post`"
  dimensions:
    - name: "Author Display Name"
      expr: author_display_name
    - name: "Char Count"
      expr: char_count
    - name: "Contains Spoiler"
      expr: contains_spoiler
    - name: "Content Warning Flag"
      expr: content_warning_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deleted Timestamp"
      expr: deleted_timestamp
    - name: "Downvote Count"
      expr: downvote_count
    - name: "Edit Count"
      expr: edit_count
    - name: "Ip Address"
      expr: ip_address
    - name: "Is Anonymous"
      expr: is_anonymous
    - name: "Is Edited"
      expr: is_edited
    - name: "Is Pinned"
      expr: is_pinned
    - name: "Is Reported"
      expr: is_reported
    - name: "Is Solution"
      expr: is_solution
    - name: "Is Staff Post"
      expr: is_staff_post
    - name: "Language Code"
      expr: language_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Forum Post"
      expr: COUNT(DISTINCT forum_post_id)
    - name: "Total Sentiment Score"
      expr: SUM(sentiment_score)
    - name: "Average Sentiment Score"
      expr: AVG(sentiment_score)
    - name: "Total Toxicity Score"
      expr: SUM(toxicity_score)
    - name: "Average Toxicity Score"
      expr: AVG(toxicity_score)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`community_forum_thread`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Forum Thread business metrics"
  source: "`gaming_ecm`.`community`.`forum_thread`"
  dimensions:
    - name: "Author Display Name"
      expr: author_display_name
    - name: "Author Post Count At Time"
      expr: author_post_count_at_time
    - name: "Body Content"
      expr: body_content
    - name: "Content Language Code"
      expr: content_language_code
    - name: "Content Rating Category"
      expr: content_rating_category
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Csat Score"
      expr: csat_score
    - name: "Downvote Count"
      expr: downvote_count
    - name: "Edit Count"
      expr: edit_count
    - name: "Flair Label"
      expr: flair_label
    - name: "Is Deleted"
      expr: is_deleted
    - name: "Is Edited"
      expr: is_edited
    - name: "Is Featured"
      expr: is_featured
    - name: "Is Locked"
      expr: is_locked
    - name: "Is Pinned"
      expr: is_pinned
    - name: "Is Reported"
      expr: is_reported
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Forum Thread"
      expr: COUNT(DISTINCT forum_thread_id)
    - name: "Total View Count"
      expr: SUM(view_count)
    - name: "Average View Count"
      expr: AVG(view_count)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`community_guild`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guild business metrics"
  source: "`gaming_ecm`.`community`.`guild`"
  dimensions:
    - name: "Age Restricted"
      expr: age_restricted
    - name: "Banner Asset Ref"
      expr: banner_asset_ref
    - name: "Content Rating"
      expr: content_rating
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Disbanded Date"
      expr: disbanded_date
    - name: "Discord Server Code"
      expr: discord_server_code
    - name: "Emblem Asset Ref"
      expr: emblem_asset_ref
    - name: "External Website Url"
      expr: external_website_url
    - name: "Founded Date"
      expr: founded_date
    - name: "Guild Description"
      expr: guild_description
    - name: "Guild Name"
      expr: guild_name
    - name: "Guild Status"
      expr: guild_status
    - name: "Guild Type"
      expr: guild_type
    - name: "Is Esports Org"
      expr: is_esports_org
    - name: "Is Verified"
      expr: is_verified
    - name: "Language Code"
      expr: language_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Guild"
      expr: COUNT(DISTINCT guild_id)
    - name: "Total Nps Score"
      expr: SUM(nps_score)
    - name: "Average Nps Score"
      expr: AVG(nps_score)
    - name: "Total Xp Total"
      expr: SUM(xp_total)
    - name: "Average Xp Total"
      expr: AVG(xp_total)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`community_guild_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guild Membership business metrics"
  source: "`gaming_ecm`.`community`.`guild_membership`"
  dimensions:
    - name: "Activity Status"
      expr: activity_status
    - name: "Consent Timestamp"
      expr: consent_timestamp
    - name: "Contribution Score"
      expr: contribution_score
    - name: "Csat Score"
      expr: csat_score
    - name: "Current Role Since Date"
      expr: current_role_since_date
    - name: "Data Processing Consent"
      expr: data_processing_consent
    - name: "Departure Date"
      expr: departure_date
    - name: "Departure Reason"
      expr: departure_reason
    - name: "Guild Chat Messages Sent"
      expr: guild_chat_messages_sent
    - name: "Guild Events Participated"
      expr: guild_events_participated
    - name: "Has Promotion History"
      expr: has_promotion_history
    - name: "Invite Source"
      expr: invite_source
    - name: "Is Age Verified"
      expr: is_age_verified
    - name: "Is Founder"
      expr: is_founder
    - name: "Is Muted"
      expr: is_muted
    - name: "Join Date"
      expr: join_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Guild Membership"
      expr: COUNT(DISTINCT guild_membership_id)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`community_kb_article`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Kb Article business metrics"
  source: "`gaming_ecm`.`community`.`kb_article`"
  dimensions:
    - name: "Archived At"
      expr: archived_at
    - name: "Article Type"
      expr: article_type
    - name: "Comment Count"
      expr: comment_count
    - name: "Content Body"
      expr: content_body
    - name: "Content Format"
      expr: content_format
    - name: "Content Version"
      expr: content_version
    - name: "Coppa Restricted"
      expr: coppa_restricted
    - name: "Esrb Content Flag"
      expr: esrb_content_flag
    - name: "Gdpr Data Flag"
      expr: gdpr_data_flag
    - name: "Helpful Vote Count"
      expr: helpful_vote_count
    - name: "Is Comments Enabled"
      expr: is_comments_enabled
    - name: "Is Promoted"
      expr: is_promoted
    - name: "Label Names"
      expr: label_names
    - name: "Last Accuracy Review Date"
      expr: last_accuracy_review_date
    - name: "Last Updated At"
      expr: last_updated_at
    - name: "Locale"
      expr: locale
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Kb Article"
      expr: COUNT(DISTINCT kb_article_id)
    - name: "Total Deflection Rate"
      expr: SUM(deflection_rate)
    - name: "Average Deflection Rate"
      expr: AVG(deflection_rate)
    - name: "Total Search Rank Score"
      expr: SUM(search_rank_score)
    - name: "Average Search Rank Score"
      expr: AVG(search_rank_score)
    - name: "Total View Count"
      expr: SUM(view_count)
    - name: "Average View Count"
      expr: AVG(view_count)
    - name: "Total Zendesk Article Code"
      expr: SUM(zendesk_article_code)
    - name: "Average Zendesk Article Code"
      expr: AVG(zendesk_article_code)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`community_kb_section`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Kb Section business metrics"
  source: "`gaming_ecm`.`community`.`kb_section`"
  dimensions:
    - name: "Archived Timestamp"
      expr: archived_timestamp
    - name: "Canonical Url"
      expr: canonical_url
    - name: "Content Body"
      expr: content_body
    - name: "Content Format"
      expr: content_format
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deprecation Reason"
      expr: deprecation_reason
    - name: "Difficulty Level"
      expr: difficulty_level
    - name: "Display Order"
      expr: display_order
    - name: "Estimated Read Time Minutes"
      expr: estimated_read_time_minutes
    - name: "Feedback Comment Count"
      expr: feedback_comment_count
    - name: "Helpful Vote Count"
      expr: helpful_vote_count
    - name: "Is Deprecated"
      expr: is_deprecated
    - name: "Is Featured"
      expr: is_featured
    - name: "Language Code"
      expr: language_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Reviewed Timestamp"
      expr: last_reviewed_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Kb Section"
      expr: COUNT(DISTINCT kb_section_id)
    - name: "Total Average Rating"
      expr: SUM(average_rating)
    - name: "Average Average Rating"
      expr: AVG(average_rating)
    - name: "Total View Count"
      expr: SUM(view_count)
    - name: "Average View Count"
      expr: AVG(view_count)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`community_moderation_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Moderation Action business metrics"
  source: "`gaming_ecm`.`community`.`moderation_action`"
  dimensions:
    - name: "Action Reference Number"
      expr: action_reference_number
    - name: "Action Status"
      expr: action_status
    - name: "Action Timestamp"
      expr: action_timestamp
    - name: "Action Type"
      expr: action_type
    - name: "Appeal Eligible"
      expr: appeal_eligible
    - name: "Appeal Outcome"
      expr: appeal_outcome
    - name: "Appeal Resolved Timestamp"
      expr: appeal_resolved_timestamp
    - name: "Appeal Status"
      expr: appeal_status
    - name: "Appeal Submitted Timestamp"
      expr: appeal_submitted_timestamp
    - name: "Ban Duration Hours"
      expr: ban_duration_hours
    - name: "Ban End Timestamp"
      expr: ban_end_timestamp
    - name: "Ban Scope"
      expr: ban_scope
    - name: "Content Category"
      expr: content_category
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Escalation Tier"
      expr: escalation_tier
    - name: "Evidence Reference"
      expr: evidence_reference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Moderation Action"
      expr: COUNT(DISTINCT moderation_action_id)
    - name: "Total Automation Confidence Score"
      expr: SUM(automation_confidence_score)
    - name: "Average Automation Confidence Score"
      expr: AVG(automation_confidence_score)
    - name: "Total Reported Content Reference"
      expr: SUM(reported_content_reference)
    - name: "Average Reported Content Reference"
      expr: AVG(reported_content_reference)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`community_player_feedback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Player Feedback business metrics"
  source: "`gaming_ecm`.`community`.`player_feedback`"
  dimensions:
    - name: "Content Reference"
      expr: content_reference
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Device Type"
      expr: device_type
    - name: "Esrb Content Flag"
      expr: esrb_content_flag
    - name: "Feedback Body"
      expr: feedback_body
    - name: "Feedback Category"
      expr: feedback_category
    - name: "Feedback Reference Number"
      expr: feedback_reference_number
    - name: "Feedback Status"
      expr: feedback_status
    - name: "Feedback Subcategory"
      expr: feedback_subcategory
    - name: "Feedback Title"
      expr: feedback_title
    - name: "Game Mode"
      expr: game_mode
    - name: "Game Version"
      expr: game_version
    - name: "Is Beta Participant"
      expr: is_beta_participant
    - name: "Is Moderated"
      expr: is_moderated
    - name: "Is Paying Player"
      expr: is_paying_player
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Player Feedback"
      expr: COUNT(DISTINCT player_feedback_id)
    - name: "Total Sentiment Confidence Score"
      expr: SUM(sentiment_confidence_score)
    - name: "Average Sentiment Confidence Score"
      expr: AVG(sentiment_confidence_score)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`community_player_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Player Report business metrics"
  source: "`gaming_ecm`.`community`.`player_report`"
  dimensions:
    - name: "Appeal Resolved Timestamp"
      expr: appeal_resolved_timestamp
    - name: "Appeal Status"
      expr: appeal_status
    - name: "Content Rating Concern"
      expr: content_rating_concern
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Evidence Attachment Count"
      expr: evidence_attachment_count
    - name: "Evidence Attachment Urls"
      expr: evidence_attachment_urls
    - name: "Incident Timestamp"
      expr: incident_timestamp
    - name: "Is Automated Flag"
      expr: is_automated_flag
    - name: "Is Minor Involved"
      expr: is_minor_involved
    - name: "Is Repeat Report"
      expr: is_repeat_report
    - name: "Moderation Queue"
      expr: moderation_queue
    - name: "Regulatory Jurisdiction"
      expr: regulatory_jurisdiction
    - name: "Report Description"
      expr: report_description
    - name: "Report Number"
      expr: report_number
    - name: "Report Source Channel"
      expr: report_source_channel
    - name: "Report Status"
      expr: report_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Player Report"
      expr: COUNT(DISTINCT player_report_id)
    - name: "Total Auto Moderation Score"
      expr: SUM(auto_moderation_score)
    - name: "Average Auto Moderation Score"
      expr: AVG(auto_moderation_score)
    - name: "Total Reported Entity Reference"
      expr: SUM(reported_entity_reference)
    - name: "Average Reported Entity Reference"
      expr: AVG(reported_entity_reference)
    - name: "Total Resolution Time Hours"
      expr: SUM(resolution_time_hours)
    - name: "Average Resolution Time Hours"
      expr: AVG(resolution_time_hours)
    - name: "Total Sla Target Hours"
      expr: SUM(sla_target_hours)
    - name: "Average Sla Target Hours"
      expr: AVG(sla_target_hours)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`community_player_reputation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Player Reputation business metrics"
  source: "`gaming_ecm`.`community`.`player_reputation`"
  dimensions:
    - name: "Can Invite"
      expr: can_invite
    - name: "Can Moderate"
      expr: can_moderate
    - name: "Can Post"
      expr: can_post
    - name: "Can Upload Ugc"
      expr: can_upload_ugc
    - name: "Can Vote"
      expr: can_vote
    - name: "Consent Timestamp"
      expr: consent_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Csat Score"
      expr: csat_score
    - name: "Endorsement Count"
      expr: endorsement_count
    - name: "Gdpr Consent Flag"
      expr: gdpr_consent_flag
    - name: "Helpful Contribution Count"
      expr: helpful_contribution_count
    - name: "Is Age Verified"
      expr: is_age_verified
    - name: "Is Verified Contributor"
      expr: is_verified_contributor
    - name: "Last Activity Date"
      expr: last_activity_date
    - name: "Moderation Threshold Level"
      expr: moderation_threshold_level
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Player Reputation"
      expr: COUNT(DISTINCT player_reputation_id)
    - name: "Total Auto Moderation Score"
      expr: SUM(auto_moderation_score)
    - name: "Average Auto Moderation Score"
      expr: AVG(auto_moderation_score)
    - name: "Total K Factor Contribution"
      expr: SUM(k_factor_contribution)
    - name: "Average K Factor Contribution"
      expr: AVG(k_factor_contribution)
    - name: "Total Reputation Decay Rate"
      expr: SUM(reputation_decay_rate)
    - name: "Average Reputation Decay Rate"
      expr: AVG(reputation_decay_rate)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`community_social_connection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Social Connection business metrics"
  source: "`gaming_ecm`.`community`.`social_connection`"
  dimensions:
    - name: "Block Reason Code"
      expr: block_reason_code
    - name: "Co Play Session Count"
      expr: co_play_session_count
    - name: "Connection Direction"
      expr: connection_direction
    - name: "Connection Label"
      expr: connection_label
    - name: "Connection Number"
      expr: connection_number
    - name: "Connection Source"
      expr: connection_source
    - name: "Connection Status"
      expr: connection_status
    - name: "Connection Tier"
      expr: connection_tier
    - name: "Connection Type"
      expr: connection_type
    - name: "Connection Version"
      expr: connection_version
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Established Timestamp"
      expr: established_timestamp
    - name: "Gdpr Consent Flag"
      expr: gdpr_consent_flag
    - name: "Interaction Count"
      expr: interaction_count
    - name: "Is Cross Game"
      expr: is_cross_game
    - name: "Is Favorite"
      expr: is_favorite
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Social Connection"
      expr: COUNT(DISTINCT social_connection_id)
    - name: "Total Connection Strength Score"
      expr: SUM(connection_strength_score)
    - name: "Average Connection Strength Score"
      expr: AVG(connection_strength_score)
    - name: "Total K Factor Contribution"
      expr: SUM(k_factor_contribution)
    - name: "Average K Factor Contribution"
      expr: AVG(k_factor_contribution)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`community_support_ticket`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Support Ticket business metrics"
  source: "`gaming_ecm`.`community`.`support_ticket`"
  dimensions:
    - name: "Bot Handled Flag"
      expr: bot_handled_flag
    - name: "Channel"
      expr: channel
    - name: "Closed At"
      expr: closed_at
    - name: "Comment Count"
      expr: comment_count
    - name: "Coppa Minor Flag"
      expr: coppa_minor_flag
    - name: "Csat Comment"
      expr: csat_comment
    - name: "Csat Score"
      expr: csat_score
    - name: "Due At"
      expr: due_at
    - name: "Escalation Tier"
      expr: escalation_tier
    - name: "First Response At"
      expr: first_response_at
    - name: "First Response Time Seconds"
      expr: first_response_time_seconds
    - name: "Game Version"
      expr: game_version
    - name: "Gdpr Data Request Flag"
      expr: gdpr_data_request_flag
    - name: "Group Name"
      expr: group_name
    - name: "Is First Contact Resolved"
      expr: is_first_contact_resolved
    - name: "Issue Category"
      expr: issue_category
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Support Ticket"
      expr: COUNT(DISTINCT support_ticket_id)
    - name: "Total Organization Code"
      expr: SUM(organization_code)
    - name: "Average Organization Code"
      expr: AVG(organization_code)
    - name: "Total Zendesk Ticket Code"
      expr: SUM(zendesk_ticket_code)
    - name: "Average Zendesk Ticket Code"
      expr: AVG(zendesk_ticket_code)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`community_survey_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Survey Response business metrics"
  source: "`gaming_ecm`.`community`.`survey_response`"
  dimensions:
    - name: "Answered Question Count"
      expr: answered_question_count
    - name: "Ces Score"
      expr: ces_score
    - name: "Collection Channel"
      expr: collection_channel
    - name: "Coppa Verified Age"
      expr: coppa_verified_age
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Csat Score"
      expr: csat_score
    - name: "Data Source System"
      expr: data_source_system
    - name: "Device Type"
      expr: device_type
    - name: "Esrb Rating Context"
      expr: esrb_rating_context
    - name: "Followup Status"
      expr: followup_status
    - name: "Game Version"
      expr: game_version
    - name: "Gdpr Consent Recorded"
      expr: gdpr_consent_recorded
    - name: "Is Anonymous"
      expr: is_anonymous
    - name: "Is Opted In Followup"
      expr: is_opted_in_followup
    - name: "K Factor Referral Code"
      expr: k_factor_referral_code
    - name: "Moderation Flag"
      expr: moderation_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Survey Response"
      expr: COUNT(DISTINCT survey_response_id)
    - name: "Total Custom Score"
      expr: SUM(custom_score)
    - name: "Average Custom Score"
      expr: AVG(custom_score)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`community_ticket_comment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ticket Comment business metrics"
  source: "`gaming_ecm`.`community`.`ticket_comment`"
  dimensions:
    - name: "Agent Display Name"
      expr: agent_display_name
    - name: "Attachment Count"
      expr: attachment_count
    - name: "Author Type"
      expr: author_type
    - name: "Channel Source"
      expr: channel_source
    - name: "Comment Body"
      expr: comment_body
    - name: "Comment Body Html"
      expr: comment_body_html
    - name: "Comment Sequence"
      expr: comment_sequence
    - name: "Comment Type"
      expr: comment_type
    - name: "Coppa Restricted Flag"
      expr: coppa_restricted_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source System"
      expr: data_source_system
    - name: "Edit Timestamp"
      expr: edit_timestamp
    - name: "Escalation Flag"
      expr: escalation_flag
    - name: "Gdpr Erasure Flag"
      expr: gdpr_erasure_flag
    - name: "Ingested Timestamp"
      expr: ingested_timestamp
    - name: "Is Automated"
      expr: is_automated
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ticket Comment"
      expr: COUNT(DISTINCT ticket_comment_id)
    - name: "Total Macro Code"
      expr: SUM(macro_code)
    - name: "Average Macro Code"
      expr: AVG(macro_code)
    - name: "Total Sentiment Score"
      expr: SUM(sentiment_score)
    - name: "Average Sentiment Score"
      expr: AVG(sentiment_score)
    - name: "Total Zendesk Comment Code"
      expr: SUM(zendesk_comment_code)
    - name: "Average Zendesk Comment Code"
      expr: AVG(zendesk_comment_code)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`community_ugc_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ugc Review business metrics"
  source: "`gaming_ecm`.`community`.`ugc_review`"
  dimensions:
    - name: "Content Rating Compliance Flag"
      expr: content_rating_compliance_flag
    - name: "Coppa Restricted"
      expr: coppa_restricted
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deleted Timestamp"
      expr: deleted_timestamp
    - name: "Deletion Reason"
      expr: deletion_reason
    - name: "Gdpr Consent Flag"
      expr: gdpr_consent_flag
    - name: "Helpful Vote Count"
      expr: helpful_vote_count
    - name: "Is Deleted"
      expr: is_deleted
    - name: "Is Edited"
      expr: is_edited
    - name: "Is Featured"
      expr: is_featured
    - name: "Is Spoiler"
      expr: is_spoiler
    - name: "Is Verified Download"
      expr: is_verified_download
    - name: "Is Verified Playtime"
      expr: is_verified_playtime
    - name: "Last Edited Timestamp"
      expr: last_edited_timestamp
    - name: "Moderation Action Type"
      expr: moderation_action_type
    - name: "Moderation Reason Code"
      expr: moderation_reason_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ugc Review"
      expr: COUNT(DISTINCT ugc_review_id)
    - name: "Total Sentiment Score"
      expr: SUM(sentiment_score)
    - name: "Average Sentiment Score"
      expr: AVG(sentiment_score)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`community_ugc_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ugc Submission business metrics"
  source: "`gaming_ecm`.`community`.`ugc_submission`"
  dimensions:
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Asset Url"
      expr: asset_url
    - name: "Comment Count"
      expr: comment_count
    - name: "External Submission Code"
      expr: external_submission_code
    - name: "Favorite Count"
      expr: favorite_count
    - name: "Game Engine Version"
      expr: game_engine_version
    - name: "Ip Clearance Status"
      expr: ip_clearance_status
    - name: "Is Age Restricted"
      expr: is_age_restricted
    - name: "Is Cross Platform Compatible"
      expr: is_cross_platform_compatible
    - name: "Is Featured"
      expr: is_featured
    - name: "Is Monetization Eligible"
      expr: is_monetization_eligible
    - name: "Language Code"
      expr: language_code
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "License Type"
      expr: license_type
    - name: "Moderation Flag"
      expr: moderation_flag
    - name: "Nps Score"
      expr: nps_score
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ugc Submission"
      expr: COUNT(DISTINCT ugc_submission_id)
    - name: "Total Creator Revenue Share Pct"
      expr: SUM(creator_revenue_share_pct)
    - name: "Average Creator Revenue Share Pct"
      expr: AVG(creator_revenue_share_pct)
    - name: "Total Download Count"
      expr: SUM(download_count)
    - name: "Average Download Count"
      expr: AVG(download_count)
    - name: "Total File Size Bytes"
      expr: SUM(file_size_bytes)
    - name: "Average File Size Bytes"
      expr: AVG(file_size_bytes)
    - name: "Total Price Virtual Currency"
      expr: SUM(price_virtual_currency)
    - name: "Average Price Virtual Currency"
      expr: AVG(price_virtual_currency)
    - name: "Total Rating Score"
      expr: SUM(rating_score)
    - name: "Average Rating Score"
      expr: AVG(rating_score)
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`community_viral_referral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Viral Referral business metrics"
  source: "`gaming_ecm`.`community`.`viral_referral`"
  dimensions:
    - name: "Attribution Provider"
      expr: attribution_provider
    - name: "Clicked Timestamp"
      expr: clicked_timestamp
    - name: "Converted Timestamp"
      expr: converted_timestamp
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Days To Conversion"
      expr: days_to_conversion
    - name: "Device Type"
      expr: device_type
    - name: "First Iap Flag"
      expr: first_iap_flag
    - name: "Fraud Flag"
      expr: fraud_flag
    - name: "Fraud Reason"
      expr: fraud_reason
    - name: "Ftue Completed Flag"
      expr: ftue_completed_flag
    - name: "Installed Timestamp"
      expr: installed_timestamp
    - name: "Notes"
      expr: notes
    - name: "Platform"
      expr: platform
    - name: "Referral Channel"
      expr: referral_channel
    - name: "Referral Code"
      expr: referral_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Viral Referral"
      expr: COUNT(DISTINCT viral_referral_id)
    - name: "Total Attribution Confidence Score"
      expr: SUM(attribution_confidence_score)
    - name: "Average Attribution Confidence Score"
      expr: AVG(attribution_confidence_score)
    - name: "Total K Factor Contribution"
      expr: SUM(k_factor_contribution)
    - name: "Average K Factor Contribution"
      expr: AVG(k_factor_contribution)
    - name: "Total Reward Value"
      expr: SUM(reward_value)
    - name: "Average Reward Value"
      expr: AVG(reward_value)
$$;