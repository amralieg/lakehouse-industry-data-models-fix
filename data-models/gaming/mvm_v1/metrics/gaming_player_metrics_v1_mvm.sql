-- Metric views for domain: player | Business: Gaming | Version: 1 | Generated on: 2026-05-08 09:42:21

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`player_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core player account health and engagement metrics including account lifecycle, retention signals, and engagement depth"
  source: "`gaming_ecm`.`player`.`player_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the player account (active, suspended, banned, etc.)"
    - name: "account_tier"
      expr: account_tier
      comment: "Player account tier or VIP level"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the player"
    - name: "creation_source"
      expr: creation_source
      comment: "Source or channel through which the account was created"
    - name: "registration_year"
      expr: YEAR(registration_timestamp)
      comment: "Year the player account was registered"
    - name: "registration_month"
      expr: DATE_TRUNC('MONTH', registration_timestamp)
      comment: "Month the player account was registered"
    - name: "email_verified_flag"
      expr: email_verified_flag
      comment: "Whether the player has verified their email address"
    - name: "two_factor_auth_enabled_flag"
      expr: two_factor_auth_enabled_flag
      comment: "Whether two-factor authentication is enabled"
    - name: "marketing_opt_in_flag"
      expr: marketing_opt_in_flag
      comment: "Whether the player has opted in to marketing communications"
    - name: "gdpr_erasure_requested_flag"
      expr: gdpr_right_to_erasure_requested_flag
      comment: "Whether the player has requested GDPR right to erasure"
    - name: "age_verified_flag"
      expr: age_verified_flag
      comment: "Whether the player's age has been verified"
    - name: "parental_consent_flag"
      expr: parental_consent_flag
      comment: "Whether parental consent has been obtained (for minors)"
  measures:
    - name: "total_player_accounts"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Total number of unique player accounts"
    - name: "total_experience_points"
      expr: SUM(CAST(experience_points AS DOUBLE))
      comment: "Total experience points earned across all players"
    - name: "avg_experience_points_per_player"
      expr: AVG(CAST(experience_points AS DOUBLE))
      comment: "Average experience points per player account"
    - name: "total_playtime_hours"
      expr: SUM(CAST(total_playtime_minutes AS DOUBLE)) / 60.0
      comment: "Total playtime across all players in hours"
    - name: "avg_playtime_hours_per_player"
      expr: AVG(CAST(total_playtime_minutes AS DOUBLE)) / 60.0
      comment: "Average playtime per player in hours"
    - name: "email_verification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN email_verified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of players who have verified their email address"
    - name: "two_factor_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN two_factor_auth_enabled_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of players who have enabled two-factor authentication"
    - name: "marketing_opt_in_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN marketing_opt_in_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of players who have opted in to marketing communications"
    - name: "suspended_account_count"
      expr: SUM(CASE WHEN suspension_timestamp IS NOT NULL AND (suspension_expiry_timestamp IS NULL OR suspension_expiry_timestamp > CURRENT_TIMESTAMP()) THEN 1 ELSE 0 END)
      comment: "Number of currently suspended player accounts"
    - name: "gdpr_erasure_request_count"
      expr: SUM(CASE WHEN gdpr_right_to_erasure_requested_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of players who have requested GDPR right to erasure"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`player_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Player session engagement and quality metrics including session duration, performance, monetization, and retention signals"
  source: "`gaming_ecm`.`player`.`session`"
  dimensions:
    - name: "session_type"
      expr: session_type
      comment: "Type of session (e.g., tutorial, competitive, casual)"
    - name: "session_start_date"
      expr: DATE_TRUNC('DAY', start_timestamp)
      comment: "Date the session started"
    - name: "session_start_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month the session started"
    - name: "disconnect_reason"
      expr: disconnect_reason
      comment: "Reason the session was disconnected"
    - name: "is_first_session"
      expr: is_first_session
      comment: "Whether this is the player's first session"
    - name: "is_tutorial_completed"
      expr: is_tutorial_completed
      comment: "Whether the tutorial was completed during this session"
    - name: "is_cross_platform"
      expr: is_cross_platform
      comment: "Whether the session involved cross-platform play"
    - name: "ab_test_variant"
      expr: ab_test_variant
      comment: "A/B test variant the player was assigned to"
    - name: "attribution_source"
      expr: attribution_source
      comment: "Attribution source for the session"
    - name: "ccu_bucket"
      expr: ccu_bucket
      comment: "Concurrent user bucket for the session"
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total number of player sessions"
    - name: "unique_players"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Number of unique players who had sessions"
    - name: "total_session_revenue_usd"
      expr: SUM(CAST(revenue_usd AS DOUBLE))
      comment: "Total revenue generated during sessions in USD"
    - name: "avg_revenue_per_session_usd"
      expr: AVG(CAST(revenue_usd AS DOUBLE))
      comment: "Average revenue per session in USD"
    - name: "avg_session_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average session quality score (technical performance and player experience)"
    - name: "avg_fps"
      expr: AVG(CAST(average_fps AS DOUBLE))
      comment: "Average frames per second across all sessions"
    - name: "tutorial_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_tutorial_completed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions where the tutorial was completed"
    - name: "first_session_count"
      expr: SUM(CASE WHEN is_first_session = TRUE THEN 1 ELSE 0 END)
      comment: "Number of first-time player sessions (new player acquisition signal)"
    - name: "cross_platform_session_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_cross_platform = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions that involved cross-platform play"
    - name: "monetizing_session_count"
      expr: SUM(CASE WHEN CAST(revenue_usd AS DOUBLE) > 0 THEN 1 ELSE 0 END)
      comment: "Number of sessions that generated revenue"
    - name: "monetization_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN CAST(revenue_usd AS DOUBLE) > 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions that generated revenue"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`player_title_progress`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Player progression, retention, and monetization metrics by game title including churn risk, lifetime value signals, and engagement depth"
  source: "`gaming_ecm`.`player`.`title_progress`"
  dimensions:
    - name: "progress_status"
      expr: progress_status
      comment: "Current progress status of the player in the title"
    - name: "difficulty_setting"
      expr: difficulty_setting
      comment: "Difficulty setting chosen by the player"
    - name: "character_class"
      expr: character_class
      comment: "Character class or role chosen by the player"
    - name: "playstyle_classification"
      expr: playstyle_classification
      comment: "Classified playstyle of the player (e.g., casual, competitive, completionist)"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region code of the player"
    - name: "content_rating"
      expr: content_rating
      comment: "Content rating applicable to the player"
    - name: "d1_retention_flag"
      expr: d1_retention_flag
      comment: "Whether the player was retained on day 1"
    - name: "d7_retention_flag"
      expr: d7_retention_flag
      comment: "Whether the player was retained on day 7"
    - name: "d30_retention_flag"
      expr: d30_retention_flag
      comment: "Whether the player was retained on day 30"
    - name: "tutorial_completed_flag"
      expr: tutorial_completed_flag
      comment: "Whether the player completed the tutorial"
    - name: "parental_controls_enabled_flag"
      expr: parental_controls_enabled_flag
      comment: "Whether parental controls are enabled for the player"
    - name: "first_played_month"
      expr: DATE_TRUNC('MONTH', first_played_timestamp)
      comment: "Month the player first played the title"
  measures:
    - name: "total_players"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Total number of unique players with progress in the title"
    - name: "total_experience_points"
      expr: SUM(CAST(experience_points AS DOUBLE))
      comment: "Total experience points earned across all players"
    - name: "avg_experience_points_per_player"
      expr: AVG(CAST(experience_points AS DOUBLE))
      comment: "Average experience points per player"
    - name: "total_playtime_hours"
      expr: SUM(CAST(total_playtime_hours AS DOUBLE))
      comment: "Total playtime across all players in hours"
    - name: "avg_playtime_hours_per_player"
      expr: AVG(CAST(total_playtime_hours AS DOUBLE))
      comment: "Average playtime per player in hours"
    - name: "avg_session_length_minutes"
      expr: AVG(CAST(average_session_length_minutes AS DOUBLE))
      comment: "Average session length per player in minutes"
    - name: "total_mtx_spend_usd"
      expr: SUM(CAST(total_mtx_spend AS DOUBLE))
      comment: "Total microtransaction spend across all players in USD"
    - name: "avg_mtx_spend_per_player_usd"
      expr: AVG(CAST(total_mtx_spend AS DOUBLE))
      comment: "Average microtransaction spend per player in USD (ARPU)"
    - name: "paying_player_count"
      expr: SUM(CASE WHEN CAST(total_mtx_spend AS DOUBLE) > 0 THEN 1 ELSE 0 END)
      comment: "Number of players who have made at least one microtransaction purchase"
    - name: "payer_conversion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN CAST(total_mtx_spend AS DOUBLE) > 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of players who have made at least one purchase (conversion rate)"
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score across all players (predictive churn signal)"
    - name: "high_churn_risk_player_count"
      expr: SUM(CASE WHEN CAST(churn_risk_score AS DOUBLE) >= 70.0 THEN 1 ELSE 0 END)
      comment: "Number of players with high churn risk (score >= 70)"
    - name: "d1_retention_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN d1_retention_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Day 1 retention rate (percentage of players retained after 1 day)"
    - name: "d7_retention_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN d7_retention_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Day 7 retention rate (percentage of players retained after 7 days)"
    - name: "d30_retention_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN d30_retention_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Day 30 retention rate (percentage of players retained after 30 days)"
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average game completion percentage across all players"
    - name: "total_in_game_currency_balance"
      expr: SUM(CAST(in_game_currency_balance AS DOUBLE))
      comment: "Total in-game currency balance across all players"
    - name: "total_premium_currency_balance"
      expr: SUM(CAST(premium_currency_balance AS DOUBLE))
      comment: "Total premium currency balance across all players"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`player_ban_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Player moderation and ban enforcement metrics including ban rates, appeal outcomes, and policy compliance"
  source: "`gaming_ecm`.`player`.`ban_record`"
  dimensions:
    - name: "ban_status"
      expr: ban_status
      comment: "Current status of the ban (active, expired, appealed, overturned)"
    - name: "ban_type"
      expr: ban_type
      comment: "Type of ban (temporary, permanent, shadow ban, etc.)"
    - name: "ban_reason_category"
      expr: ban_reason_category
      comment: "High-level category of the ban reason (cheating, toxicity, fraud, etc.)"
    - name: "ban_reason_detail"
      expr: ban_reason_detail
      comment: "Detailed reason for the ban"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the offense"
    - name: "issuing_system"
      expr: issuing_system
      comment: "System that issued the ban (automated, manual, hybrid)"
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of the ban appeal (pending, approved, denied, not submitted)"
    - name: "appeal_submitted_flag"
      expr: appeal_submitted_flag
      comment: "Whether the player submitted an appeal"
    - name: "repeat_offender_flag"
      expr: repeat_offender_flag
      comment: "Whether the player is a repeat offender"
    - name: "notification_sent_flag"
      expr: notification_sent_flag
      comment: "Whether a ban notification was sent to the player"
    - name: "ban_start_month"
      expr: DATE_TRUNC('MONTH', ban_start_timestamp)
      comment: "Month the ban was issued"
  measures:
    - name: "total_ban_records"
      expr: COUNT(1)
      comment: "Total number of ban records issued"
    - name: "unique_banned_players"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Number of unique players who have been banned"
    - name: "avg_automated_detection_confidence"
      expr: AVG(CAST(automated_detection_confidence AS DOUBLE))
      comment: "Average confidence score of automated ban detection systems"
    - name: "repeat_offender_count"
      expr: SUM(CASE WHEN repeat_offender_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of bans issued to repeat offenders"
    - name: "repeat_offender_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN repeat_offender_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bans issued to repeat offenders"
    - name: "appeal_submission_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN appeal_submitted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bans that resulted in an appeal submission"
    - name: "appeal_count"
      expr: SUM(CASE WHEN appeal_submitted_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of ban appeals submitted"
    - name: "notification_delivery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN notification_sent_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bans where notification was successfully sent to the player"
    - name: "permanent_ban_count"
      expr: SUM(CASE WHEN ban_type = 'permanent' THEN 1 ELSE 0 END)
      comment: "Number of permanent bans issued"
    - name: "temporary_ban_count"
      expr: SUM(CASE WHEN ban_type = 'temporary' THEN 1 ELSE 0 END)
      comment: "Number of temporary bans issued"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`player_lifecycle_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Player lifecycle event tracking metrics including acquisition, activation, churn, and critical lifecycle transitions"
  source: "`gaming_ecm`.`player`.`lifecycle_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of lifecycle event (registration, first_purchase, churn, reactivation, etc.)"
    - name: "event_source_system"
      expr: event_source_system
      comment: "System that generated the lifecycle event"
    - name: "attribution_source"
      expr: attribution_source
      comment: "Attribution source for the lifecycle event"
    - name: "authentication_method"
      expr: authentication_method
      comment: "Authentication method used during the event"
    - name: "authentication_provider"
      expr: authentication_provider
      comment: "Authentication provider (e.g., Google, Facebook, Apple)"
    - name: "platform"
      expr: platform
      comment: "Platform on which the event occurred (iOS, Android, PC, console)"
    - name: "geolocation_country_code"
      expr: geolocation_country_code
      comment: "Country code where the event occurred"
    - name: "geolocation_region"
      expr: geolocation_region
      comment: "Geographic region where the event occurred"
    - name: "suspicious_activity_flag"
      expr: suspicious_activity_flag
      comment: "Whether suspicious activity was detected during the event"
    - name: "gdpr_consent_flag"
      expr: gdpr_consent_flag
      comment: "Whether GDPR consent was given"
    - name: "coppa_protected_flag"
      expr: coppa_protected_flag
      comment: "Whether the player is COPPA-protected (minor)"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month the lifecycle event occurred"
    - name: "triggering_context"
      expr: triggering_context
      comment: "Context that triggered the lifecycle event"
  measures:
    - name: "total_lifecycle_events"
      expr: COUNT(1)
      comment: "Total number of lifecycle events recorded"
    - name: "unique_players_with_events"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Number of unique players who triggered lifecycle events"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across all lifecycle events (fraud and abuse signal)"
    - name: "high_risk_event_count"
      expr: SUM(CASE WHEN CAST(risk_score AS DOUBLE) >= 70.0 THEN 1 ELSE 0 END)
      comment: "Number of lifecycle events with high risk score (>= 70)"
    - name: "suspicious_activity_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN suspicious_activity_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lifecycle events flagged as suspicious"
    - name: "gdpr_consent_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gdpr_consent_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lifecycle events where GDPR consent was given"
    - name: "coppa_protected_event_count"
      expr: SUM(CASE WHEN coppa_protected_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of lifecycle events involving COPPA-protected players (minors)"
    - name: "failed_event_count"
      expr: SUM(CASE WHEN failure_reason IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of lifecycle events that failed"
    - name: "event_failure_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN failure_reason IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lifecycle events that failed"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`player_platform_identity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cross-platform identity linking and account security metrics including link success rates, fraud risk, and platform engagement"
  source: "`gaming_ecm`.`player`.`platform_identity`"
  dimensions:
    - name: "platform_type"
      expr: platform_type
      comment: "Type of external platform (Steam, PlayStation, Xbox, Epic, etc.)"
    - name: "link_status"
      expr: link_status
      comment: "Status of the platform identity link (active, pending, failed, unlinked)"
    - name: "link_method"
      expr: link_method
      comment: "Method used to link the platform identity (OAuth, manual, etc.)"
    - name: "link_source"
      expr: link_source
      comment: "Source from which the link was initiated"
    - name: "primary_identity_flag"
      expr: primary_identity_flag
      comment: "Whether this is the player's primary platform identity"
    - name: "cross_platform_play_enabled_flag"
      expr: cross_platform_play_enabled_flag
      comment: "Whether cross-platform play is enabled for this identity"
    - name: "platform_email_verified_flag"
      expr: platform_email_verified_flag
      comment: "Whether the email is verified on the external platform"
    - name: "platform_age_verified_flag"
      expr: platform_age_verified_flag
      comment: "Whether age is verified on the external platform"
    - name: "platform_parental_control_flag"
      expr: platform_parental_control_flag
      comment: "Whether parental controls are enabled on the external platform"
    - name: "platform_account_tier"
      expr: platform_account_tier
      comment: "Account tier on the external platform (free, premium, etc.)"
    - name: "platform_region_code"
      expr: platform_region_code
      comment: "Region code of the external platform account"
    - name: "link_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the platform identity was linked"
  measures:
    - name: "total_platform_identities"
      expr: COUNT(1)
      comment: "Total number of platform identity links"
    - name: "unique_players_with_linked_identities"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Number of unique players who have linked at least one platform identity"
    - name: "avg_fraud_risk_score"
      expr: AVG(CAST(fraud_risk_score AS DOUBLE))
      comment: "Average fraud risk score across all platform identity links"
    - name: "high_fraud_risk_link_count"
      expr: SUM(CASE WHEN CAST(fraud_risk_score AS DOUBLE) >= 70.0 THEN 1 ELSE 0 END)
      comment: "Number of platform identity links with high fraud risk (>= 70)"
    - name: "cross_platform_play_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cross_platform_play_enabled_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of platform identities with cross-platform play enabled"
    - name: "primary_identity_count"
      expr: SUM(CASE WHEN primary_identity_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of platform identities marked as primary"
    - name: "active_link_count"
      expr: SUM(CASE WHEN link_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of active platform identity links"
    - name: "failed_link_count"
      expr: SUM(CASE WHEN link_status = 'failed' THEN 1 ELSE 0 END)
      comment: "Number of failed platform identity link attempts"
    - name: "link_success_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN link_status = 'active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of platform identity links that are active (link success rate)"
    - name: "avg_platform_total_playtime_hours"
      expr: AVG(CAST(platform_total_playtime_hours AS DOUBLE))
      comment: "Average total playtime on the external platform in hours"
    - name: "platform_email_verification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN platform_email_verified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of platform identities with verified email on the external platform"
$$;