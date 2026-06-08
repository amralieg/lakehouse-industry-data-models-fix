-- Metric views for domain: player | Business: Gaming | Version: 1 | Generated on: 2026-05-08 07:57:15

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`player_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core player account metrics tracking registration, engagement, and account health for strategic player base management and growth analysis"
  source: "`gaming_ecm`.`player`.`player_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the player account (active, suspended, banned, etc.)"
    - name: "account_tier"
      expr: account_tier
      comment: "Player account tier or VIP level"
    - name: "platform_of_origin"
      expr: platform_of_origin
      comment: "Platform where the player originally registered"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the player"
    - name: "registration_year"
      expr: YEAR(registration_timestamp)
      comment: "Year the player account was registered"
    - name: "registration_month"
      expr: DATE_TRUNC('MONTH', registration_timestamp)
      comment: "Month the player account was registered for cohort analysis"
    - name: "age_verified_flag"
      expr: age_verified_flag
      comment: "Whether the player has completed age verification"
    - name: "two_factor_auth_enabled_flag"
      expr: two_factor_auth_enabled_flag
      comment: "Whether two-factor authentication is enabled for security analysis"
    - name: "marketing_opt_in_flag"
      expr: marketing_opt_in_flag
      comment: "Whether player has opted in to marketing communications"
    - name: "gdpr_erasure_requested_flag"
      expr: gdpr_right_to_erasure_requested_flag
      comment: "Whether player has requested GDPR right to erasure"
  measures:
    - name: "total_player_accounts"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Total number of unique player accounts for player base sizing"
    - name: "total_experience_points"
      expr: SUM(CAST(experience_points AS DOUBLE))
      comment: "Total experience points earned across all players for engagement assessment"
    - name: "avg_experience_points_per_player"
      expr: AVG(CAST(experience_points AS DOUBLE))
      comment: "Average experience points per player account indicating typical progression depth"
    - name: "total_playtime_hours"
      expr: SUM(CAST(total_playtime_minutes AS DOUBLE)) / 60.0
      comment: "Total playtime across all players in hours for engagement volume analysis"
    - name: "avg_playtime_hours_per_player"
      expr: AVG(CAST(total_playtime_minutes AS DOUBLE)) / 60.0
      comment: "Average playtime per player in hours indicating typical engagement intensity"
    - name: "email_verified_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN email_verified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of players with verified email addresses for account security and communication reach"
    - name: "two_factor_auth_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN two_factor_auth_enabled_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of players with two-factor authentication enabled for security posture assessment"
    - name: "marketing_opt_in_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN marketing_opt_in_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of players opted in to marketing communications for addressable audience sizing"
    - name: "gdpr_erasure_request_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gdpr_right_to_erasure_requested_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of players requesting GDPR erasure for privacy compliance monitoring"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`player_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Player session metrics tracking engagement intensity, session quality, and monetization for operational performance and player experience optimization"
  source: "`gaming_ecm`.`player`.`session`"
  dimensions:
    - name: "session_type"
      expr: session_type
      comment: "Type of session (PvP, PvE, tutorial, etc.)"
    - name: "session_date"
      expr: DATE_TRUNC('DAY', start_timestamp)
      comment: "Date of session start for daily trend analysis"
    - name: "session_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month of session start for monthly trend analysis"
    - name: "disconnect_reason"
      expr: disconnect_reason
      comment: "Reason for session disconnect for quality and stability analysis"
    - name: "is_first_session"
      expr: is_first_session
      comment: "Whether this is the player's first session for new user experience analysis"
    - name: "is_tutorial_completed"
      expr: is_tutorial_completed
      comment: "Whether the tutorial was completed during this session"
    - name: "is_cross_platform"
      expr: is_cross_platform
      comment: "Whether the session involved cross-platform play"
    - name: "ab_test_variant"
      expr: ab_test_variant
      comment: "A/B test variant for experimentation analysis"
    - name: "ccu_bucket"
      expr: ccu_bucket
      comment: "Concurrent user bucket for load and capacity analysis"
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total number of player sessions for engagement volume tracking"
    - name: "unique_players"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Number of unique players with sessions for active user base sizing"
    - name: "total_session_hours"
      expr: SUM(CAST(duration_seconds AS DOUBLE)) / 3600.0
      comment: "Total session time in hours for engagement volume analysis"
    - name: "avg_session_duration_minutes"
      expr: AVG(CAST(duration_seconds AS DOUBLE)) / 60.0
      comment: "Average session duration in minutes indicating typical engagement length"
    - name: "avg_fps"
      expr: AVG(CAST(average_fps AS DOUBLE))
      comment: "Average frames per second across sessions for technical performance assessment"
    - name: "avg_latency_ms"
      expr: AVG(CAST(average_latency_ms AS DOUBLE))
      comment: "Average network latency in milliseconds for connection quality assessment"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average session quality score for player experience assessment"
    - name: "total_session_revenue_usd"
      expr: SUM(CAST(revenue_usd AS DOUBLE))
      comment: "Total revenue generated during sessions in USD for monetization tracking"
    - name: "avg_revenue_per_session_usd"
      expr: AVG(CAST(revenue_usd AS DOUBLE))
      comment: "Average revenue per session in USD for session monetization efficiency"
    - name: "total_mtx_transactions"
      expr: SUM(CAST(mtx_transaction_count AS DOUBLE))
      comment: "Total microtransaction count across sessions for monetization activity volume"
    - name: "tutorial_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_tutorial_completed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions where tutorial was completed for onboarding effectiveness"
    - name: "cross_platform_session_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_cross_platform = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions involving cross-platform play for feature adoption tracking"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`player_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Player engagement and retention metrics tracking DAU/MAU, retention cohorts, and lifecycle stages for strategic growth and retention management"
  source: "`gaming_ecm`.`player`.`engagement_metric`"
  dimensions:
    - name: "metric_date"
      expr: metric_date
      comment: "Date of the engagement metric snapshot"
    - name: "metric_month"
      expr: DATE_TRUNC('MONTH', metric_date)
      comment: "Month of the engagement metric for monthly trend analysis"
    - name: "engagement_tier"
      expr: engagement_tier
      comment: "Player engagement tier (high, medium, low) for segmentation"
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Player lifecycle stage (new, active, at-risk, churned) for lifecycle management"
    - name: "cohort_identifier"
      expr: cohort_identifier
      comment: "Cohort identifier for cohort-based retention analysis"
    - name: "primary_platform"
      expr: primary_platform
      comment: "Primary platform the player engages on"
    - name: "ftue_completed"
      expr: ftue_completed
      comment: "Whether first-time user experience was completed"
    - name: "is_dau"
      expr: is_dau
      comment: "Whether player was a daily active user on this date"
    - name: "is_wau"
      expr: is_wau
      comment: "Whether player was a weekly active user on this date"
    - name: "is_mau"
      expr: is_mau
      comment: "Whether player was a monthly active user on this date"
  measures:
    - name: "total_players_tracked"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Total unique players tracked in engagement metrics for player base sizing"
    - name: "daily_active_users"
      expr: SUM(CASE WHEN is_dau = TRUE THEN 1 ELSE 0 END)
      comment: "Count of daily active users for DAU tracking"
    - name: "weekly_active_users"
      expr: SUM(CASE WHEN is_wau = TRUE THEN 1 ELSE 0 END)
      comment: "Count of weekly active users for WAU tracking"
    - name: "monthly_active_users"
      expr: SUM(CASE WHEN is_mau = TRUE THEN 1 ELSE 0 END)
      comment: "Count of monthly active users for MAU tracking"
    - name: "avg_engagement_score"
      expr: AVG(CAST(engagement_score AS DOUBLE))
      comment: "Average engagement score across players for overall engagement health"
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score for retention risk assessment"
    - name: "total_playtime_hours"
      expr: SUM(CAST(total_playtime_minutes AS DOUBLE)) / 60.0
      comment: "Total playtime in hours for engagement volume tracking"
    - name: "avg_playtime_hours_per_player"
      expr: AVG(CAST(total_playtime_minutes AS DOUBLE)) / 60.0
      comment: "Average playtime per player in hours for typical engagement intensity"
    - name: "avg_session_length_minutes"
      expr: AVG(CAST(average_session_length_minutes AS DOUBLE))
      comment: "Average session length in minutes for session depth analysis"
    - name: "d1_retention_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_d1_retained = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Day 1 retention rate for new player stickiness assessment"
    - name: "d7_retention_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_d7_retained = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Day 7 retention rate for early retention health"
    - name: "d30_retention_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_d30_retained = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Day 30 retention rate for long-term retention health"
    - name: "ftue_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN ftue_completed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "First-time user experience completion rate for onboarding effectiveness"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`player_ltv`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Player lifetime value metrics tracking realized and predicted LTV, ARPU, and payer segmentation for monetization strategy and player value optimization"
  source: "`gaming_ecm`.`player`.`ltv_record`"
  dimensions:
    - name: "calculation_date"
      expr: calculation_date
      comment: "Date of LTV calculation"
    - name: "calculation_month"
      expr: DATE_TRUNC('MONTH', calculation_date)
      comment: "Month of LTV calculation for monthly trend analysis"
    - name: "cohort_month"
      expr: cohort_month
      comment: "Cohort month for cohort-based LTV analysis"
    - name: "ltv_segment"
      expr: ltv_segment
      comment: "LTV segment (whale, dolphin, minnow, non-payer) for value-based segmentation"
    - name: "payer_tier"
      expr: payer_tier
      comment: "Payer tier classification for monetization segmentation"
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Player acquisition channel for channel ROI analysis"
    - name: "platform"
      expr: platform
      comment: "Platform for platform-specific LTV analysis"
    - name: "is_paying_user"
      expr: is_paying_user
      comment: "Whether the player has made any purchase"
    - name: "is_active"
      expr: is_active
      comment: "Whether the player is currently active"
  measures:
    - name: "total_players_in_ltv"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Total unique players with LTV records for player base sizing"
    - name: "total_realized_ltv"
      expr: SUM(CAST(realized_ltv AS DOUBLE))
      comment: "Total realized lifetime value across all players for revenue tracking"
    - name: "avg_realized_ltv"
      expr: AVG(CAST(realized_ltv AS DOUBLE))
      comment: "Average realized LTV per player for typical player value assessment"
    - name: "avg_predicted_ltv_90d"
      expr: AVG(CAST(predicted_ltv_90d AS DOUBLE))
      comment: "Average predicted 90-day LTV for short-term value forecasting"
    - name: "avg_predicted_ltv_180d"
      expr: AVG(CAST(predicted_ltv_180d AS DOUBLE))
      comment: "Average predicted 180-day LTV for medium-term value forecasting"
    - name: "avg_predicted_ltv_365d"
      expr: AVG(CAST(predicted_ltv_365d AS DOUBLE))
      comment: "Average predicted 365-day LTV for annual value forecasting"
    - name: "avg_arpu"
      expr: AVG(CAST(arpu_contribution AS DOUBLE))
      comment: "Average revenue per user for monetization efficiency assessment"
    - name: "total_iap_spend"
      expr: SUM(CAST(total_iap_spend AS DOUBLE))
      comment: "Total in-app purchase spend for IAP revenue tracking"
    - name: "avg_iap_spend_per_player"
      expr: AVG(CAST(total_iap_spend AS DOUBLE))
      comment: "Average IAP spend per player for typical monetization intensity"
    - name: "avg_transaction_value"
      expr: AVG(CAST(average_transaction_value AS DOUBLE))
      comment: "Average transaction value for basket size analysis"
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score for high-value player retention risk"
    - name: "payer_conversion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_paying_user = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of players who have made at least one purchase for monetization conversion"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`player_title_progress`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Player game title progression metrics tracking completion, retention, and monetization per title for title performance and player journey optimization"
  source: "`gaming_ecm`.`player`.`title_progress`"
  dimensions:
    - name: "progress_status"
      expr: progress_status
      comment: "Current progress status in the game title"
    - name: "difficulty_setting"
      expr: difficulty_setting
      comment: "Difficulty setting chosen by the player"
    - name: "character_class"
      expr: character_class
      comment: "Character class or role chosen by the player"
    - name: "playstyle_classification"
      expr: playstyle_classification
      comment: "Playstyle classification (casual, competitive, completionist, etc.)"
    - name: "battle_pass_tier"
      expr: battle_pass_tier
      comment: "Current battle pass tier for monetization analysis"
    - name: "region_code"
      expr: region_code
      comment: "Region code for geographic analysis"
    - name: "tutorial_completed_flag"
      expr: tutorial_completed_flag
      comment: "Whether the player completed the tutorial"
    - name: "d1_retention_flag"
      expr: d1_retention_flag
      comment: "Whether the player was retained on day 1"
    - name: "d7_retention_flag"
      expr: d7_retention_flag
      comment: "Whether the player was retained on day 7"
    - name: "d30_retention_flag"
      expr: d30_retention_flag
      comment: "Whether the player was retained on day 30"
  measures:
    - name: "total_player_title_records"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Total unique players with title progress records for title player base sizing"
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across players for title engagement depth"
    - name: "avg_playtime_hours"
      expr: AVG(CAST(total_playtime_hours AS DOUBLE))
      comment: "Average playtime per player in hours for typical title engagement"
    - name: "total_playtime_hours"
      expr: SUM(CAST(total_playtime_hours AS DOUBLE))
      comment: "Total playtime across all players in hours for title engagement volume"
    - name: "avg_session_length_minutes"
      expr: AVG(CAST(average_session_length_minutes AS DOUBLE))
      comment: "Average session length in minutes for session depth analysis"
    - name: "total_experience_points"
      expr: SUM(CAST(experience_points AS DOUBLE))
      comment: "Total experience points earned across all players for progression volume"
    - name: "avg_experience_points"
      expr: AVG(CAST(experience_points AS DOUBLE))
      comment: "Average experience points per player for typical progression depth"
    - name: "total_mtx_spend"
      expr: SUM(CAST(total_mtx_spend AS DOUBLE))
      comment: "Total microtransaction spend for title monetization tracking"
    - name: "avg_mtx_spend_per_player"
      expr: AVG(CAST(total_mtx_spend AS DOUBLE))
      comment: "Average microtransaction spend per player for title ARPU"
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score for title retention risk assessment"
    - name: "win_rate"
      expr: ROUND(100.0 * SUM(CAST(total_wins AS DOUBLE)) / NULLIF(SUM(CAST(total_wins AS DOUBLE)) + SUM(CAST(total_losses AS DOUBLE)), 0), 2)
      comment: "Win rate percentage for competitive balance and player skill assessment"
    - name: "tutorial_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN tutorial_completed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Tutorial completion rate for onboarding effectiveness"
    - name: "d1_retention_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN d1_retention_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Day 1 retention rate for title new player stickiness"
    - name: "d7_retention_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN d7_retention_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Day 7 retention rate for title early retention health"
    - name: "d30_retention_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN d30_retention_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Day 30 retention rate for title long-term retention health"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`player_ban_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Player ban and moderation metrics tracking ban volume, appeal rates, and repeat offenders for trust and safety operations and policy effectiveness"
  source: "`gaming_ecm`.`player`.`ban_record`"
  dimensions:
    - name: "ban_status"
      expr: ban_status
      comment: "Current status of the ban (active, expired, appealed, overturned)"
    - name: "ban_type"
      expr: ban_type
      comment: "Type of ban (temporary, permanent, shadow, etc.)"
    - name: "ban_reason_category"
      expr: ban_reason_category
      comment: "High-level category of ban reason (cheating, toxicity, fraud, etc.)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the offense"
    - name: "platform_code"
      expr: platform_code
      comment: "Platform where the ban was issued"
    - name: "issuing_system"
      expr: issuing_system
      comment: "System that issued the ban (automated, manual, hybrid)"
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any appeal submitted"
    - name: "repeat_offender_flag"
      expr: repeat_offender_flag
      comment: "Whether the player is a repeat offender"
    - name: "ban_month"
      expr: DATE_TRUNC('MONTH', ban_start_timestamp)
      comment: "Month the ban was issued for trend analysis"
  measures:
    - name: "total_bans_issued"
      expr: COUNT(1)
      comment: "Total number of bans issued for moderation volume tracking"
    - name: "unique_players_banned"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Number of unique players banned for player impact assessment"
    - name: "avg_automated_detection_confidence"
      expr: AVG(CAST(automated_detection_confidence AS DOUBLE))
      comment: "Average confidence score of automated detection for system accuracy assessment"
    - name: "appeal_submission_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN appeal_submitted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bans that resulted in an appeal for policy fairness assessment"
    - name: "repeat_offender_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN repeat_offender_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bans issued to repeat offenders for recidivism tracking"
    - name: "notification_sent_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN notification_sent_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bans where notification was successfully sent for communication effectiveness"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`player_consent_snapshot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Player consent and privacy metrics tracking consent rates, GDPR compliance, and data rights requests for regulatory compliance and privacy operations"
  source: "`gaming_ecm`.`player`.`consent_snapshot`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent record"
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent (marketing, analytics, data sharing, etc.)"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction for compliance analysis"
    - name: "legal_basis"
      expr: legal_basis
      comment: "Legal basis for data processing (consent, contract, legitimate interest, etc.)"
    - name: "collection_platform"
      expr: collection_platform
      comment: "Platform where consent was collected"
    - name: "age_verification_status"
      expr: age_verification_status
      comment: "Status of age verification for COPPA compliance"
    - name: "parental_consent_required"
      expr: parental_consent_required
      comment: "Whether parental consent is required"
    - name: "is_active"
      expr: is_active
      comment: "Whether the consent record is currently active"
    - name: "consent_month"
      expr: DATE_TRUNC('MONTH', consent_granted_timestamp)
      comment: "Month consent was granted for trend analysis"
  measures:
    - name: "total_consent_records"
      expr: COUNT(1)
      comment: "Total number of consent records for compliance tracking volume"
    - name: "unique_players_with_consent"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Number of unique players with consent records for coverage assessment"
    - name: "marketing_opt_in_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN marketing_opt_in = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of players opted in to marketing for addressable audience sizing"
    - name: "analytics_tracking_consent_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN analytics_tracking_allowed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of players allowing analytics tracking for data collection scope"
    - name: "third_party_sharing_consent_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN third_party_sharing_allowed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of players allowing third-party data sharing for partnership data scope"
    - name: "cookie_consent_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cookie_consent_granted = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of players granting cookie consent for web tracking compliance"
    - name: "parental_consent_verified_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN parental_consent_verified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of required parental consents that are verified for COPPA compliance"
    - name: "erasure_request_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN right_to_erasure_requested = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of players requesting right to erasure for GDPR compliance monitoring"
    - name: "data_portability_request_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN data_portability_requested = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of players requesting data portability for GDPR compliance monitoring"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`player_segment_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Player segment membership metrics tracking segment assignment, LTV distribution, and engagement by segment for targeted marketing and personalization effectiveness"
  source: "`gaming_ecm`.`player`.`segment_membership`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current status of the segment membership"
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign the player to the segment (rule-based, ML, manual)"
    - name: "assignment_source"
      expr: assignment_source
      comment: "Source system that assigned the segment"
    - name: "geo_region"
      expr: geo_region
      comment: "Geographic region for regional segmentation"
    - name: "target_platform"
      expr: target_platform
      comment: "Target platform for platform-specific segmentation"
    - name: "is_current"
      expr: is_current
      comment: "Whether this is the current active segment membership"
    - name: "exclusion_flag"
      expr: exclusion_flag
      comment: "Whether the player is excluded from this segment"
    - name: "assignment_month"
      expr: DATE_TRUNC('MONTH', assignment_timestamp)
      comment: "Month of segment assignment for trend analysis"
  measures:
    - name: "total_segment_memberships"
      expr: COUNT(1)
      comment: "Total number of segment membership records for segmentation coverage"
    - name: "unique_players_in_segments"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Number of unique players with segment memberships for segmented player base sizing"
    - name: "avg_ltv_estimate"
      expr: AVG(CAST(ltv_estimate AS DOUBLE))
      comment: "Average LTV estimate across segment members for segment value assessment"
    - name: "total_ltv_estimate"
      expr: SUM(CAST(ltv_estimate AS DOUBLE))
      comment: "Total LTV estimate across segment members for segment portfolio value"
    - name: "avg_engagement_score"
      expr: AVG(CAST(engagement_score AS DOUBLE))
      comment: "Average engagement score across segment members for segment engagement health"
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score across segment members for segment retention risk"
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average confidence score of segment assignments for assignment quality"
    - name: "total_spend_to_date"
      expr: SUM(CAST(total_spend_to_date AS DOUBLE))
      comment: "Total spend across segment members for segment revenue contribution"
    - name: "avg_spend_per_player"
      expr: AVG(CAST(total_spend_to_date AS DOUBLE))
      comment: "Average spend per player in segment for segment ARPU"
    - name: "exclusion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN exclusion_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of segment memberships that are exclusions for targeting precision"
$$;