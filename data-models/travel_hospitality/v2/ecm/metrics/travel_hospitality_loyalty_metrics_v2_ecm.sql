-- Metric views for domain: loyalty | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-22 18:44:46

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core loyalty member health and value metrics. Tracks active membership base, lifetime revenue, points economics, and tier distribution to steer program investment and retention strategy."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`member`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current status of the loyalty membership account (active, suspended, closed, etc.)."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the member enrolled (web, mobile, front-desk, call-center, etc.)."
    - name: "vip_flag"
      expr: vip_flag
      comment: "Indicates whether the member holds VIP designation, enabling VIP-vs-standard segmentation."
    - name: "communication_opt_in"
      expr: communication_opt_in
      comment: "Whether the member has opted into marketing communications — critical for reachable audience sizing."
    - name: "currency_preference"
      expr: currency_preference
      comment: "Member's preferred currency, useful for regional program analysis."
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year of enrollment for cohort-based retention and LTV trend analysis."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment for cohort growth tracking."
    - name: "last_stay_year"
      expr: YEAR(last_stay_date)
      comment: "Year of most recent stay, used to identify dormant vs. active members."
    - name: "tier_expiration_year"
      expr: YEAR(tier_expiration_date)
      comment: "Year the current tier expires, enabling proactive tier-retention campaigns."
    - name: "email_opt_in"
      expr: email_opt_in
      comment: "Email marketing opt-in flag for reachable audience segmentation."
    - name: "sms_opt_in"
      expr: sms_opt_in
      comment: "SMS marketing opt-in flag for mobile channel audience sizing."
    - name: "language_preference"
      expr: language_preference
      comment: "Member's preferred language for localization and regional analysis."
  measures:
    - name: "total_active_members"
      expr: COUNT(CASE WHEN membership_status = 'ACTIVE' THEN member_id END)
      comment: "Count of currently active loyalty members. Core program health KPI used in executive dashboards."
    - name: "total_members"
      expr: COUNT(1)
      comment: "Total loyalty member records regardless of status. Used as denominator for activation and churn rate calculations."
    - name: "total_lifetime_revenue"
      expr: SUM(CAST(lifetime_revenue AS DOUBLE))
      comment: "Sum of lifetime revenue attributed to loyalty members. Directly measures program's contribution to total hotel revenue."
    - name: "avg_lifetime_revenue_per_member"
      expr: AVG(CAST(lifetime_revenue AS DOUBLE))
      comment: "Average lifetime revenue per loyalty member. Key LTV metric used to justify program investment and tier benefit costs."
    - name: "total_current_points_balance"
      expr: SUM(CAST(current_points_balance AS DOUBLE))
      comment: "Total unredeemed points balance across all members. Represents program liability and drives breakage/redemption forecasting."
    - name: "avg_points_balance_per_member"
      expr: AVG(CAST(current_points_balance AS DOUBLE))
      comment: "Average unredeemed points balance per member. Indicates engagement depth and pending redemption pressure."
    - name: "total_lifetime_points_earned"
      expr: SUM(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Total points ever earned across all members. Measures program accrual volume and engagement scale."
    - name: "total_points_redeemed"
      expr: SUM(CAST(points_redeemed AS DOUBLE))
      comment: "Total points redeemed by members. Measures redemption activity and program engagement depth."
    - name: "total_points_expired"
      expr: SUM(CAST(points_expired AS DOUBLE))
      comment: "Total points expired without redemption. Drives breakage revenue recognition and informs expiry policy decisions."
    - name: "total_ytd_revenue"
      expr: SUM(CAST(ytd_revenue AS DOUBLE))
      comment: "Year-to-date revenue from loyalty members. Used in quarterly business reviews to track in-year program performance."
    - name: "avg_salt_score"
      expr: AVG(CAST(salt_score AS DOUBLE))
      comment: "Average SALT (satisfaction) score across members. Tracks member satisfaction trend and informs service recovery prioritization."
    - name: "vip_member_count"
      expr: COUNT(CASE WHEN vip_flag = TRUE THEN member_id END)
      comment: "Count of VIP-designated members. Used to size VIP benefit cost and ensure VIP service capacity."
    - name: "opted_in_member_count"
      expr: COUNT(CASE WHEN communication_opt_in = TRUE THEN member_id END)
      comment: "Count of members opted into communications. Defines the reachable audience for loyalty marketing campaigns."
    - name: "redemption_rate"
      expr: ROUND(100.0 * SUM(CAST(points_redeemed AS DOUBLE)) / NULLIF(SUM(CAST(lifetime_points_earned AS DOUBLE)), 0), 2)
      comment: "Percentage of lifetime earned points that have been redeemed. Measures program engagement and redemption health; low rates signal disengagement or friction."
    - name: "points_expiry_rate"
      expr: ROUND(100.0 * SUM(CAST(points_expired AS DOUBLE)) / NULLIF(SUM(CAST(lifetime_points_earned AS DOUBLE)), 0), 2)
      comment: "Percentage of lifetime earned points that expired unredeemed. High rates indicate member disengagement or overly aggressive expiry policy."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_points_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Points transaction economics and accrual/redemption flow metrics. Enables program liability management, fraud detection, and channel-level points attribution."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`points_ledger`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of points transaction (accrual, redemption, adjustment, transfer, expiry, etc.)."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the points transaction (posted, pending, reversed, cancelled)."
    - name: "source_activity_type"
      expr: source_activity_type
      comment: "Business activity that triggered the points transaction (stay, dining, spa, partner, etc.)."
    - name: "tier_at_transaction"
      expr: tier_at_transaction
      comment: "Member tier at the time of the transaction, enabling tier-level economics analysis."
    - name: "transfer_direction"
      expr: transfer_direction
      comment: "Direction of points transfer (IN or OUT) for partner transfer analysis."
    - name: "is_qualifying"
      expr: is_qualifying
      comment: "Whether the transaction counts toward tier qualification. Separates qualifying from bonus/non-qualifying activity."
    - name: "base_currency_code"
      expr: base_currency_code
      comment: "Currency of the underlying transaction, enabling multi-currency program analysis."
    - name: "activity_date_month"
      expr: DATE_TRUNC('MONTH', activity_date)
      comment: "Month of points activity for trend and seasonality analysis."
    - name: "activity_date_year"
      expr: YEAR(activity_date)
      comment: "Year of points activity for annual program performance reporting."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month points were posted to the ledger, used for liability period-end reporting."
    - name: "partner_program_code"
      expr: partner_program_code
      comment: "Partner program associated with the transaction, enabling partner-level contribution analysis."
  measures:
    - name: "total_points_transacted"
      expr: SUM(CAST(points_amount AS DOUBLE))
      comment: "Total points volume across all ledger transactions. Core program activity volume metric."
    - name: "total_points_accrued"
      expr: SUM(CASE WHEN transaction_type = 'ACCRUAL' THEN points_amount ELSE 0 END)
      comment: "Total points earned by members. Measures program engagement and accrual engine effectiveness."
    - name: "total_points_redeemed"
      expr: SUM(CASE WHEN transaction_type = 'REDEMPTION' THEN points_amount ELSE 0 END)
      comment: "Total points redeemed. Measures redemption activity and program liability drawdown."
    - name: "total_base_amount"
      expr: SUM(CAST(base_amount AS DOUBLE))
      comment: "Total monetary base amount underlying points transactions. Links points economics to revenue."
    - name: "avg_points_per_transaction"
      expr: AVG(CAST(points_amount AS DOUBLE))
      comment: "Average points per ledger transaction. Tracks accrual generosity and redemption efficiency over time."
    - name: "total_transfer_fees"
      expr: SUM(CAST(transfer_fee_amount AS DOUBLE))
      comment: "Total fees collected on points transfers. Measures partner transfer revenue and cost recovery."
    - name: "avg_balance_after_transaction"
      expr: AVG(CAST(balance_after_transaction AS DOUBLE))
      comment: "Average member balance after transactions. Proxy for program liability depth and member engagement level."
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total number of points ledger transactions. Measures program activity volume and processing scale."
    - name: "distinct_active_members"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of unique members with points activity. Measures engaged member base size."
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average currency-to-points conversion rate applied at transaction time. Monitors rate consistency and partner exchange economics."
    - name: "points_per_currency_unit"
      expr: ROUND(SUM(CAST(points_amount AS DOUBLE)) / NULLIF(SUM(CAST(base_amount AS DOUBLE)), 0), 4)
      comment: "Effective points earned per unit of base currency spent. Measures accrual generosity and program cost efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Redemption activity metrics covering points burned, monetary value delivered, and fulfillment performance. Drives reward catalog optimization and member satisfaction management."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`redemption`"
  dimensions:
    - name: "redemption_type"
      expr: redemption_type
      comment: "Type of redemption (free night, upgrade, dining, spa, partner, merchandise, etc.)."
    - name: "redemption_status"
      expr: redemption_status
      comment: "Current status of the redemption (confirmed, pending, cancelled, fulfilled, refunded)."
    - name: "fulfillment_channel"
      expr: fulfillment_channel
      comment: "Channel through which the reward was fulfilled (property, mail, digital, partner, etc.)."
    - name: "tier_at_redemption"
      expr: tier_at_redemption
      comment: "Member tier at time of redemption, enabling tier-level redemption behavior analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the redemption transaction for multi-currency program analysis."
    - name: "request_date_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month redemption was requested, for trend and seasonality analysis."
    - name: "request_date_year"
      expr: YEAR(request_date)
      comment: "Year redemption was requested, for annual program performance reporting."
    - name: "fulfillment_date_month"
      expr: DATE_TRUNC('MONTH', fulfillment_date)
      comment: "Month redemption was fulfilled, for fulfillment lag and SLA analysis."
    - name: "partner_code"
      expr: partner_code
      comment: "Partner associated with the redemption, enabling partner-level redemption volume analysis."
    - name: "property_code"
      expr: property_code
      comment: "Property where redemption occurred, for property-level redemption performance analysis."
  measures:
    - name: "total_redemptions"
      expr: COUNT(1)
      comment: "Total number of redemption transactions. Core program engagement volume metric."
    - name: "total_points_redeemed"
      expr: SUM(CAST(points_redeemed AS DOUBLE))
      comment: "Total points burned through redemptions. Measures program liability drawdown and member engagement depth."
    - name: "total_monetary_equivalent_value"
      expr: SUM(CAST(monetary_equivalent_value AS DOUBLE))
      comment: "Total monetary value of rewards delivered to members. Measures program benefit cost and member value delivered."
    - name: "total_cash_amount"
      expr: SUM(CAST(cash_amount AS DOUBLE))
      comment: "Total cash component of cash-plus-points redemptions. Tracks hybrid redemption revenue contribution."
    - name: "total_points_refunded"
      expr: SUM(CAST(points_refunded AS DOUBLE))
      comment: "Total points refunded due to cancellations or disputes. Measures redemption reversal volume and operational friction."
    - name: "avg_points_per_redemption"
      expr: AVG(CAST(points_redeemed AS DOUBLE))
      comment: "Average points burned per redemption transaction. Tracks redemption efficiency and reward catalog pricing calibration."
    - name: "avg_monetary_value_per_redemption"
      expr: AVG(CAST(monetary_equivalent_value AS DOUBLE))
      comment: "Average monetary value delivered per redemption. Measures reward generosity and member perceived value."
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN redemption_status = 'CANCELLED' THEN redemption_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of redemptions that were cancelled. High rates indicate friction in the redemption process or catalog relevance issues."
    - name: "distinct_redeeming_members"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of unique members who redeemed rewards. Measures breadth of redemption engagement across the member base."
    - name: "cost_per_redemption"
      expr: ROUND(SUM(CAST(monetary_equivalent_value AS DOUBLE)) / NULLIF(COUNT(1), 0), 2)
      comment: "Average cost per redemption transaction. Key program cost management metric for budget planning."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_tier_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tier movement analytics tracking upgrades, downgrades, and qualification performance. Enables tier strategy optimization and proactive retention of high-value members."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`tier_history`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of tier change (upgrade, downgrade, renewal, status_match, override, expiry)."
    - name: "change_reason_code"
      expr: change_reason_code
      comment: "Reason code for the tier change, enabling root-cause analysis of tier movement patterns."
    - name: "previous_tier_code"
      expr: previous_tier_code
      comment: "Tier the member held before the change, enabling from-to tier flow analysis."
    - name: "qualification_basis"
      expr: qualification_basis
      comment: "Basis on which tier was qualified (nights, stays, spend, points, status_match)."
    - name: "is_current_tier_flag"
      expr: is_current_tier_flag
      comment: "Whether this record represents the member's current active tier."
    - name: "tier_extension_granted_flag"
      expr: tier_extension_granted_flag
      comment: "Whether a tier extension was granted, used to measure retention intervention frequency."
    - name: "notification_sent_flag"
      expr: notification_sent_flag
      comment: "Whether the member was notified of the tier change, for communication compliance tracking."
    - name: "change_year"
      expr: YEAR(effective_date)
      comment: "Year of tier change for annual tier movement trend analysis."
    - name: "change_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of tier change for seasonal tier movement pattern analysis."
    - name: "qualifying_period_start_year"
      expr: YEAR(qualifying_period_start_date)
      comment: "Year the qualifying period started, for cohort-based qualification analysis."
  measures:
    - name: "total_tier_changes"
      expr: COUNT(1)
      comment: "Total number of tier change events. Measures program tier mobility and qualification engine activity."
    - name: "total_upgrades"
      expr: COUNT(CASE WHEN change_type = 'UPGRADE' THEN tier_history_id END)
      comment: "Total tier upgrades. Measures program aspiration and member progression toward higher tiers."
    - name: "total_downgrades"
      expr: COUNT(CASE WHEN change_type = 'DOWNGRADE' THEN tier_history_id END)
      comment: "Total tier downgrades. High downgrade counts signal member disengagement or overly aggressive qualification thresholds."
    - name: "total_status_matches"
      expr: COUNT(CASE WHEN change_type = 'STATUS_MATCH' THEN tier_history_id END)
      comment: "Total status match grants. Measures competitive acquisition effectiveness and status match program utilization."
    - name: "total_tier_extensions"
      expr: COUNT(CASE WHEN tier_extension_granted_flag = TRUE THEN tier_history_id END)
      comment: "Total tier extensions granted. Measures retention intervention frequency and cost of tier protection programs."
    - name: "total_bonus_points_awarded"
      expr: SUM(CAST(bonus_points_awarded AS DOUBLE))
      comment: "Total bonus points awarded on tier changes. Measures tier-change incentive cost and welcome/upgrade bonus generosity."
    - name: "avg_qualifying_points_achieved"
      expr: AVG(CAST(qualifying_points_achieved AS DOUBLE))
      comment: "Average qualifying points achieved at time of tier change. Benchmarks member engagement depth relative to tier thresholds."
    - name: "avg_qualifying_spend_amount"
      expr: AVG(CAST(qualifying_spend_amount AS DOUBLE))
      comment: "Average qualifying spend at time of tier change. Measures revenue contribution of members achieving tier milestones."
    - name: "upgrade_to_downgrade_ratio"
      expr: ROUND(COUNT(CASE WHEN change_type = 'UPGRADE' THEN tier_history_id END) / NULLIF(COUNT(CASE WHEN change_type = 'DOWNGRADE' THEN tier_history_id END), 0), 2)
      comment: "Ratio of upgrades to downgrades. A ratio above 1 indicates a healthy, growing program; below 1 signals member attrition risk."
    - name: "distinct_members_with_tier_change"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of unique members who experienced a tier change. Measures breadth of tier mobility across the program."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_promotion_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion enrollment and completion metrics. Measures campaign effectiveness, bonus award economics, and member engagement with targeted loyalty promotions."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`promotion_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the promotion enrollment (enrolled, completed, cancelled, expired, opted_out)."
    - name: "enrollment_method"
      expr: enrollment_method
      comment: "How the member enrolled in the promotion (auto, self-service, agent, campaign)."
    - name: "qualifying_activity_type"
      expr: qualifying_activity_type
      comment: "Type of activity required to qualify for the promotion (stay, spend, dining, etc.)."
    - name: "tier_at_enrollment"
      expr: tier_at_enrollment
      comment: "Member tier at time of enrollment, enabling tier-level promotion uptake analysis."
    - name: "bonus_awarded_flag"
      expr: bonus_awarded_flag
      comment: "Whether the promotion bonus was awarded, for completion and award rate analysis."
    - name: "communication_sent_flag"
      expr: communication_sent_flag
      comment: "Whether a communication was sent to the member about the promotion."
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year of enrollment for annual promotion performance analysis."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment for promotion uptake trend analysis."
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month promotion was completed, for completion timing and seasonality analysis."
    - name: "qualifying_threshold_unit"
      expr: qualifying_threshold_unit
      comment: "Unit of the qualifying threshold (nights, stays, spend, points) for promotion design analysis."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total promotion enrollments. Core measure of promotion reach and member engagement."
    - name: "total_completions"
      expr: COUNT(CASE WHEN enrollment_status = 'COMPLETED' THEN promotion_enrollment_id END)
      comment: "Total promotions completed by members. Measures promotion effectiveness and member follow-through."
    - name: "completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN enrollment_status = 'COMPLETED' THEN promotion_enrollment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments that resulted in completion. Key promotion ROI metric — low rates indicate threshold calibration issues."
    - name: "total_bonus_points_awarded"
      expr: SUM(CAST(bonus_points AS DOUBLE))
      comment: "Total bonus points awarded through promotions. Measures promotion liability cost and member incentive volume."
    - name: "total_bonus_amount_awarded"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total monetary bonus amount awarded through promotions. Measures direct promotion cost to the program."
    - name: "avg_progress_percentage"
      expr: AVG(CAST(progress_percentage AS DOUBLE))
      comment: "Average completion progress across active enrollments. Identifies promotions where members are close to qualifying, enabling timely nudge campaigns."
    - name: "avg_qualifying_threshold"
      expr: AVG(CAST(qualifying_threshold AS DOUBLE))
      comment: "Average qualifying threshold across promotions. Benchmarks promotion difficulty and informs threshold calibration."
    - name: "distinct_enrolled_members"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of unique members enrolled in promotions. Measures promotion reach breadth across the member base."
    - name: "bonus_award_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN bonus_awarded_flag = TRUE THEN promotion_enrollment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments where a bonus was awarded. Measures promotion payout rate and budget consumption pace."
    - name: "opt_out_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN enrollment_status = 'OPT_OUT' THEN promotion_enrollment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments that resulted in opt-out. High rates signal promotion relevance or communication frequency issues."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program enrollment funnel and acquisition metrics. Tracks new member acquisition volume, channel mix, consent rates, and status match activity to optimize enrollment strategy."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`loyalty_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Status of the enrollment record (active, pending, rejected, cancelled)."
    - name: "initial_tier"
      expr: initial_tier
      comment: "Tier granted at enrollment, for status match and tier-entry analysis."
    - name: "status_match_flag"
      expr: status_match_flag
      comment: "Whether the enrollment included a status match from a competitor program."
    - name: "country_code"
      expr: country_code
      comment: "Country of enrollment for geographic acquisition analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device used for enrollment (mobile, desktop, tablet, kiosk) for digital channel optimization."
    - name: "email_consent_flag"
      expr: email_consent_flag
      comment: "Whether the member consented to email marketing at enrollment."
    - name: "sms_consent_flag"
      expr: sms_consent_flag
      comment: "Whether the member consented to SMS marketing at enrollment."
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year of enrollment for annual acquisition trend analysis."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment for acquisition funnel trend and seasonality analysis."
    - name: "language_code"
      expr: language_code
      comment: "Language preference at enrollment for localization and regional analysis."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total loyalty program enrollments. Core acquisition volume metric for program growth tracking."
    - name: "total_active_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'ACTIVE' THEN loyalty_enrollment_id END)
      comment: "Count of enrollments with active status. Measures net active member acquisition."
    - name: "total_status_matches"
      expr: COUNT(CASE WHEN status_match_flag = TRUE THEN loyalty_enrollment_id END)
      comment: "Total enrollments via status match. Measures competitive acquisition program effectiveness."
    - name: "total_welcome_bonus_points"
      expr: SUM(CAST(welcome_bonus_points AS DOUBLE))
      comment: "Total welcome bonus points awarded at enrollment. Measures acquisition incentive cost and enrollment promotion generosity."
    - name: "avg_welcome_bonus_points"
      expr: AVG(CAST(welcome_bonus_points AS DOUBLE))
      comment: "Average welcome bonus points per enrollment. Benchmarks acquisition incentive level across channels and campaigns."
    - name: "email_consent_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN email_consent_flag = TRUE THEN loyalty_enrollment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of new enrollments with email marketing consent. Measures reachable audience quality from new acquisitions."
    - name: "sms_consent_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sms_consent_flag = TRUE THEN loyalty_enrollment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of new enrollments with SMS marketing consent. Measures mobile channel reachability of new members."
    - name: "status_match_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN status_match_flag = TRUE THEN loyalty_enrollment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments that included a status match. Measures competitive acquisition program utilization rate."
    - name: "distinct_properties_enrolling"
      expr: COUNT(DISTINCT property_id)
      comment: "Count of distinct properties generating enrollments. Measures property-level enrollment program participation breadth."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_fraud_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty fraud risk and investigation metrics. Tracks fraud detection volume, financial exposure, resolution effectiveness, and risk score trends to protect program integrity."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`fraud_alert`"
  dimensions:
    - name: "alert_type"
      expr: alert_type
      comment: "Type of fraud alert (account_takeover, points_abuse, identity_theft, suspicious_transfer, etc.)."
    - name: "alert_severity"
      expr: alert_severity
      comment: "Severity level of the fraud alert (critical, high, medium, low)."
    - name: "alert_status"
      expr: alert_status
      comment: "Current status of the fraud alert (open, under_investigation, resolved, false_positive, escalated)."
    - name: "detection_method"
      expr: detection_method
      comment: "Method used to detect the fraud (ML_model, rule_engine, manual_review, member_report)."
    - name: "resolution_action"
      expr: resolution_action
      comment: "Action taken to resolve the alert (points_reversed, account_frozen, no_action, law_enforcement)."
    - name: "account_frozen_flag"
      expr: account_frozen_flag
      comment: "Whether the member account was frozen as a result of the alert."
    - name: "law_enforcement_notified_flag"
      expr: law_enforcement_notified_flag
      comment: "Whether law enforcement was notified, for regulatory and compliance reporting."
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Whether regulatory reporting was required for this fraud event."
    - name: "detection_year"
      expr: YEAR(detection_timestamp)
      comment: "Year of fraud detection for annual fraud trend analysis."
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_timestamp)
      comment: "Month of fraud detection for trend and seasonality analysis."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the fraudulent activity originated (web, mobile, call-center, partner)."
    - name: "geolocation_country_code"
      expr: geolocation_country_code
      comment: "Country of origin for the fraudulent activity, enabling geographic fraud pattern analysis."
  measures:
    - name: "total_fraud_alerts"
      expr: COUNT(1)
      comment: "Total fraud alerts generated. Core fraud detection volume metric for program security monitoring."
    - name: "total_open_alerts"
      expr: COUNT(CASE WHEN alert_status = 'OPEN' THEN fraud_alert_id END)
      comment: "Count of unresolved fraud alerts. Measures investigation backlog and operational risk exposure."
    - name: "total_monetary_value_at_risk"
      expr: SUM(CAST(monetary_value_involved AS DOUBLE))
      comment: "Total monetary value involved in fraud alerts. Measures financial exposure from loyalty fraud activity."
    - name: "total_points_at_risk"
      expr: SUM(CAST(points_amount_involved AS DOUBLE))
      comment: "Total points involved in fraud alerts. Measures program liability at risk from fraudulent activity."
    - name: "total_points_reversed"
      expr: SUM(CAST(points_reversed_amount AS DOUBLE))
      comment: "Total points reversed as fraud remediation. Measures recovery effectiveness and program liability protection."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average fraud risk score across alerts. Tracks model-assigned risk level and detection threshold calibration."
    - name: "false_positive_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN alert_status = 'FALSE_POSITIVE' THEN fraud_alert_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of fraud alerts that were false positives. High rates indicate over-sensitive detection models causing member friction."
    - name: "account_freeze_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN account_frozen_flag = TRUE THEN fraud_alert_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of fraud alerts resulting in account freeze. Measures severity of fraud response and member impact."
    - name: "points_recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(points_reversed_amount AS DOUBLE)) / NULLIF(SUM(CAST(points_amount_involved AS DOUBLE)), 0), 2)
      comment: "Percentage of at-risk points successfully reversed. Measures fraud remediation effectiveness and program liability protection."
    - name: "distinct_members_flagged"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of unique members with fraud alerts. Measures breadth of fraud exposure across the member base."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_points_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner points transfer economics and operational performance metrics. Tracks transfer volume, conversion efficiency, fee revenue, and processing reliability for partner program management."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`points_transfer`"
  dimensions:
    - name: "transfer_status"
      expr: transfer_status
      comment: "Status of the points transfer (completed, pending, failed, reversed)."
    - name: "transfer_direction"
      expr: transfer_direction
      comment: "Direction of the transfer (hotel_to_partner or partner_to_hotel)."
    - name: "request_channel"
      expr: request_channel
      comment: "Channel through which the transfer was requested (web, mobile, call-center)."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether the transfer was reversed, for reversal rate and dispute analysis."
    - name: "tax_reporting_flag"
      expr: tax_reporting_flag
      comment: "Whether the transfer requires tax reporting, for compliance monitoring."
    - name: "member_tier_at_transfer"
      expr: member_tier_at_transfer
      comment: "Member tier at time of transfer, enabling tier-level transfer behavior analysis."
    - name: "request_year"
      expr: YEAR(request_timestamp)
      comment: "Year of transfer request for annual partner transfer volume analysis."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month of transfer request for trend and seasonality analysis."
  measures:
    - name: "total_transfers"
      expr: COUNT(1)
      comment: "Total points transfer transactions. Measures partner program utilization and member engagement with transfer feature."
    - name: "total_hotel_points_transferred"
      expr: SUM(CAST(hotel_points_amount AS DOUBLE))
      comment: "Total hotel loyalty points transferred to/from partner programs. Measures partner program points flow volume."
    - name: "total_partner_currency_transferred"
      expr: SUM(CAST(partner_currency_amount AS DOUBLE))
      comment: "Total partner currency amount received/sent in transfers. Measures partner program exchange volume."
    - name: "total_promotional_bonus_points"
      expr: SUM(CAST(promotional_bonus_points AS DOUBLE))
      comment: "Total bonus points awarded on transfers through promotions. Measures transfer promotion cost and incentive effectiveness."
    - name: "total_transfer_fees"
      expr: SUM(CAST(transfer_fee_amount AS DOUBLE))
      comment: "Total fees collected on points transfers. Measures fee revenue from partner transfer program."
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average hotel-to-partner points conversion rate. Monitors exchange rate consistency and partner economics."
    - name: "transfer_success_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN transfer_status = 'COMPLETED' THEN points_transfer_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transfer requests successfully completed. Measures API reliability and partner integration quality."
    - name: "reversal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_flag = TRUE THEN points_transfer_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transfers that were reversed. High rates indicate partner integration issues or member disputes."
    - name: "distinct_transferring_members"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of unique members using the points transfer feature. Measures partner program engagement breadth."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_accrual_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accrual rule configuration and economics metrics. Tracks rule portfolio composition, earning generosity, and tier/segment multiplier structure to optimize program cost and member engagement."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`accrual_rule`"
  dimensions:
    - name: "rule_type"
      expr: rule_type
      comment: "Type of accrual rule (base_earn, bonus_earn, partner_earn, promotion_earn)."
    - name: "rule_status"
      expr: rule_status
      comment: "Current status of the accrual rule (active, inactive, pending, expired)."
    - name: "earning_basis"
      expr: earning_basis
      comment: "Basis on which points are earned (revenue, nights, stays, transactions)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the rule (approved, pending_approval, rejected)."
    - name: "is_stackable"
      expr: is_stackable
      comment: "Whether this rule can stack with other accrual rules, affecting total earn potential."
    - name: "property_applicability"
      expr: property_applicability
      comment: "Scope of property applicability (all, specific, brand, region)."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the rule became effective, for rule vintage analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the minimum transaction amount is denominated."
  measures:
    - name: "total_active_rules"
      expr: COUNT(CASE WHEN rule_status = 'ACTIVE' THEN accrual_rule_id END)
      comment: "Count of currently active accrual rules. Measures rule portfolio complexity and active earning configuration."
    - name: "total_rules"
      expr: COUNT(1)
      comment: "Total accrual rules in the system. Measures rule portfolio size and configuration management scope."
    - name: "avg_points_per_currency_unit"
      expr: AVG(CAST(points_per_currency_unit AS DOUBLE))
      comment: "Average points earned per currency unit across all active rules. Benchmarks program earning generosity."
    - name: "avg_tier_multiplier"
      expr: AVG(CAST(tier_multiplier AS DOUBLE))
      comment: "Average tier multiplier across accrual rules. Measures tier benefit generosity and differentiation."
    - name: "avg_segment_multiplier"
      expr: AVG(CAST(segment_multiplier AS DOUBLE))
      comment: "Average segment multiplier across accrual rules. Measures segment-targeted earning incentive level."
    - name: "avg_minimum_transaction_amount"
      expr: AVG(CAST(minimum_transaction_amount AS DOUBLE))
      comment: "Average minimum transaction amount required to earn points. Measures earning accessibility and threshold calibration."
    - name: "total_estimated_annual_points_volume"
      expr: SUM(CAST(estimated_annual_points_volume AS DOUBLE))
      comment: "Total estimated annual points volume across all active rules. Key program liability forecasting input for finance."
    - name: "stackable_rule_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_stackable = TRUE THEN accrual_rule_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accrual rules that are stackable. High rates increase earn complexity and potential liability exposure."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_benefit_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit fulfillment performance and cost metrics. Tracks benefit delivery quality, SLA compliance, and cost-to-property to optimize benefit program design and operational execution."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`redemption`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the benefit monetary value."
  measures:
    - name: "total_benefit_redemptions"
      expr: COUNT(1)
      comment: "Total benefit redemption events. Measures benefit program utilization volume."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion portfolio performance and budget management metrics. Tracks promotion economics, budget utilization, and completion rates to optimize loyalty marketing investment."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`promotion`"
  dimensions:
    - name: "promotion_type"
      expr: promotion_type
      comment: "Type of promotion (bonus_points, tier_accelerator, free_night, discount, partner_bonus)."
    - name: "promotion_status"
      expr: promotion_status
      comment: "Current status of the promotion (active, expired, cancelled, draft, pending_approval)."
    - name: "marketing_channel"
      expr: marketing_channel
      comment: "Marketing channel used to distribute the promotion (email, push, web, in-stay, partner)."
    - name: "registration_required_flag"
      expr: registration_required_flag
      comment: "Whether members must register to participate, affecting enrollment friction and uptake."
    - name: "stackable_flag"
      expr: stackable_flag
      comment: "Whether the promotion can stack with other offers, affecting total liability exposure."
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the promotion started for annual promotion portfolio analysis."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the promotion started for seasonal promotion planning analysis."
  measures:
    - name: "total_promotions"
      expr: COUNT(1)
      comment: "Total promotions in the portfolio. Measures promotion program scale and complexity."
    - name: "total_active_promotions"
      expr: COUNT(CASE WHEN promotion_status = 'ACTIVE' THEN promotion_id END)
      comment: "Count of currently active promotions. Measures live promotion exposure and concurrent offer complexity."
    - name: "total_budget_cap"
      expr: SUM(CAST(budget_cap_amount AS DOUBLE))
      comment: "Total budget allocated across all promotions. Measures total loyalty promotion investment commitment."
    - name: "total_budget_consumed"
      expr: SUM(CAST(budget_consumed_amount AS DOUBLE))
      comment: "Total budget consumed across all promotions. Measures actual promotion spend vs. allocation."
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(budget_consumed_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_cap_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of promotion budget consumed. Measures promotion investment efficiency and pacing vs. plan."
    - name: "total_bonus_points_issued"
      expr: SUM(CAST(bonus_points_amount AS DOUBLE))
      comment: "Total bonus points issued through promotions. Measures promotion liability cost and member incentive volume."
    - name: "avg_bonus_points_multiplier"
      expr: AVG(CAST(bonus_points_multiplier AS DOUBLE))
      comment: "Average bonus points multiplier across promotions. Benchmarks promotion earning generosity."
    - name: "avg_minimum_spend"
      expr: AVG(CAST(minimum_spend_amount AS DOUBLE))
      comment: "Average minimum spend required to qualify for promotions. Measures promotion accessibility and revenue threshold calibration."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Certificate issuance, redemption, and expiry metrics. Tracks certificate program economics, redemption rates, and breakage to optimize certificate-based reward strategies."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`certificate`"
  dimensions:
    - name: "certificate_type"
      expr: certificate_type
      comment: "Type of certificate (free_night, upgrade, dining_credit, spa_credit, discount)."
    - name: "certificate_status"
      expr: certificate_status
      comment: "Current status of the certificate (issued, redeemed, expired, voided, pending)."
    - name: "issue_channel"
      expr: issue_channel
      comment: "Channel through which the certificate was issued (web, mobile, property, call-center)."
    - name: "redemption_channel"
      expr: redemption_channel
      comment: "Channel through which the certificate was redeemed."
    - name: "tier_at_issue"
      expr: tier_at_issue
      comment: "Member tier when the certificate was issued, for tier-level certificate economics analysis."
    - name: "tier_at_redemption"
      expr: tier_at_redemption
      comment: "Member tier when the certificate was redeemed."
    - name: "complimentary_flag"
      expr: complimentary_flag
      comment: "Whether the certificate was issued complimentarily (vs. purchased with points)."
    - name: "transferable_flag"
      expr: transferable_flag
      comment: "Whether the certificate is transferable to another member."
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year of certificate issuance for annual certificate program analysis."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month of certificate issuance for trend analysis."
  measures:
    - name: "total_certificates_issued"
      expr: COUNT(1)
      comment: "Total certificates issued. Measures certificate program volume and issuance activity."
    - name: "total_certificates_redeemed"
      expr: COUNT(CASE WHEN certificate_status = 'REDEEMED' THEN certificate_id END)
      comment: "Total certificates redeemed. Measures certificate program engagement and member utilization."
    - name: "total_certificates_expired"
      expr: COUNT(CASE WHEN certificate_status = 'EXPIRED' THEN certificate_id END)
      comment: "Total certificates expired without redemption. Measures breakage volume and program liability release."
    - name: "certificate_redemption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN certificate_status = 'REDEEMED' THEN certificate_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of issued certificates that were redeemed. Key program engagement metric — low rates indicate certificate relevance or awareness issues."
    - name: "certificate_expiry_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN certificate_status = 'EXPIRED' THEN certificate_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of issued certificates that expired unredeemed. Measures breakage rate and member engagement with certificate rewards."
    - name: "total_face_value_issued"
      expr: SUM(CAST(face_value AS DOUBLE))
      comment: "Total face value of certificates issued. Measures total certificate liability and program benefit cost."
    - name: "total_points_cost"
      expr: SUM(CAST(points_cost AS DOUBLE))
      comment: "Total points spent to acquire certificates. Measures points-to-certificate conversion volume."
    - name: "avg_face_value_per_certificate"
      expr: AVG(CAST(face_value AS DOUBLE))
      comment: "Average face value per certificate. Benchmarks certificate generosity and reward value calibration."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_benefit_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit Entitlement business metrics"
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`benefit_entitlement`"
  dimensions:
    - name: "Advance Booking Required Days"
      expr: advance_booking_required_days
    - name: "Auto Apply Flag"
      expr: auto_apply_flag
    - name: "Benefit Description"
      expr: benefit_description
    - name: "Benefit Name"
      expr: benefit_name
    - name: "Benefit Type Code"
      expr: benefit_type_code
    - name: "Blackout Dates"
      expr: blackout_dates
    - name: "Brand Restriction"
      expr: brand_restriction
    - name: "Combinable Flag"
      expr: combinable_flag
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Eligible Property List"
      expr: eligible_property_list
    - name: "Entitlement Source"
      expr: entitlement_source
    - name: "Entitlement Status"
      expr: entitlement_status
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Granted Timestamp"
      expr: granted_timestamp
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Benefit Entitlement"
      expr: COUNT(DISTINCT benefit_entitlement_id)
    - name: "Total Monetary Value"
      expr: SUM(monetary_value)
    - name: "Average Monetary Value"
      expr: AVG(monetary_value)
    - name: "Total Points Multiplier"
      expr: SUM(points_multiplier)
    - name: "Average Points Multiplier"
      expr: AVG(points_multiplier)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_loyalty_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty Enrollment business metrics"
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`loyalty_enrollment`"
  dimensions:
    - name: "Campaign Code"
      expr: campaign_code
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Device Type"
      expr: device_type
    - name: "Documentation Submitted Flag"
      expr: documentation_submitted_flag
    - name: "Email Consent Flag"
      expr: email_consent_flag
    - name: "Enrollment Date"
      expr: enrollment_date
    - name: "Enrollment Number"
      expr: enrollment_number
    - name: "Enrollment Status"
      expr: enrollment_status
    - name: "Enrollment Timestamp"
      expr: enrollment_timestamp
    - name: "Initial Tier"
      expr: initial_tier
    - name: "Ip Address"
      expr: ip_address
    - name: "Language Code"
      expr: language_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Match Expiry Date"
      expr: match_expiry_date
    - name: "Match Tier Granted"
      expr: match_tier_granted
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Loyalty Enrollment"
      expr: COUNT(DISTINCT loyalty_enrollment_id)
    - name: "Total Welcome Bonus Points"
      expr: SUM(welcome_bonus_points)
    - name: "Average Welcome Bonus Points"
      expr: AVG(welcome_bonus_points)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_member_preference`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member Preference business metrics"
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`member_preference`"
  dimensions:
    - name: "Brand Restriction"
      expr: brand_restriction
    - name: "Confidence Level"
      expr: confidence_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Last Confirmed Date"
      expr: last_confirmed_date
    - name: "Last Observed Date"
      expr: last_observed_date
    - name: "Last Updated Date"
      expr: last_updated_date
    - name: "Notes"
      expr: notes
    - name: "Observation Count"
      expr: observation_count
    - name: "Override Flag"
      expr: override_flag
    - name: "Preference Category"
      expr: preference_category
    - name: "Preference Source"
      expr: preference_source
    - name: "Preference Status"
      expr: preference_status
    - name: "Priority Rank"
      expr: priority_rank
    - name: "Property Restriction"
      expr: property_restriction
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Member Preference"
      expr: COUNT(DISTINCT member_preference_id)
    - name: "Total Preference Value"
      expr: SUM(preference_value)
    - name: "Average Preference Value"
      expr: AVG(preference_value)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_member_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member Segment business metrics"
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`member_segment`"
  dimensions:
    - name: "Allow Overlap Flag"
      expr: allow_overlap_flag
    - name: "Brand Restriction"
      expr: brand_restriction
    - name: "Campaign Eligible Flag"
      expr: campaign_eligible_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Current Member Count"
      expr: current_member_count
    - name: "Effective Date"
      expr: effective_date
    - name: "Exclusion Criteria"
      expr: exclusion_criteria
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Geographic Restriction"
      expr: geographic_restriction
    - name: "Inclusion Criteria"
      expr: inclusion_criteria
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Refresh Timestamp"
      expr: last_refresh_timestamp
    - name: "Maximum Nights"
      expr: maximum_nights
    - name: "Minimum Nights"
      expr: minimum_nights
    - name: "Minimum Stays"
      expr: minimum_stays
    - name: "Model Version"
      expr: model_version
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Member Segment"
      expr: COUNT(DISTINCT member_segment_id)
    - name: "Total Confidence Threshold"
      expr: SUM(confidence_threshold)
    - name: "Average Confidence Threshold"
      expr: AVG(confidence_threshold)
    - name: "Total Engagement Score Threshold"
      expr: SUM(engagement_score_threshold)
    - name: "Average Engagement Score Threshold"
      expr: AVG(engagement_score_threshold)
    - name: "Total Maximum Ltv"
      expr: SUM(maximum_ltv)
    - name: "Average Maximum Ltv"
      expr: AVG(maximum_ltv)
    - name: "Total Minimum Ltv"
      expr: SUM(minimum_ltv)
    - name: "Average Minimum Ltv"
      expr: AVG(minimum_ltv)
    - name: "Total Salt Score Threshold"
      expr: SUM(salt_score_threshold)
    - name: "Average Salt Score Threshold"
      expr: AVG(salt_score_threshold)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_package_purchase`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Package Purchase business metrics"
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`package_purchase`"
  dimensions:
    - name: "Confirmation Number"
      expr: confirmation_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Package Status"
      expr: package_status
    - name: "Points Redeemed"
      expr: points_redeemed
    - name: "Purchase Channel"
      expr: purchase_channel
    - name: "Purchase Date"
      expr: purchase_date
    - name: "Sessions Included"
      expr: sessions_included
    - name: "Sessions Used"
      expr: sessions_used
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Expiry Date Month"
      expr: DATE_TRUNC('MONTH', expiry_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Package Purchase"
      expr: COUNT(DISTINCT package_purchase_id)
    - name: "Total Purchase Price"
      expr: SUM(purchase_price)
    - name: "Average Purchase Price"
      expr: AVG(purchase_price)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_partner_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner Program business metrics"
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`partner_program`"
  dimensions:
    - name: "Api Authentication Method"
      expr: api_authentication_method
    - name: "Api Integration Endpoint"
      expr: api_integration_endpoint
    - name: "Contract Effective Date"
      expr: contract_effective_date
    - name: "Contract Expiration Date"
      expr: contract_expiration_date
    - name: "Contract Reference Number"
      expr: contract_reference_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Sharing Consent Flag"
      expr: data_sharing_consent_flag
    - name: "Earn Eligibility Flag"
      expr: earn_eligibility_flag
    - name: "Last Sync Timestamp"
      expr: last_sync_timestamp
    - name: "Marketing Consent Flag"
      expr: marketing_consent_flag
    - name: "Maximum Transfer Amount"
      expr: maximum_transfer_amount
    - name: "Minimum Transfer Amount"
      expr: minimum_transfer_amount
    - name: "Partner Code"
      expr: partner_code
    - name: "Partner Contact Email"
      expr: partner_contact_email
    - name: "Partner Contact Name"
      expr: partner_contact_name
    - name: "Partner Contact Phone"
      expr: partner_contact_phone
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partner Program"
      expr: COUNT(DISTINCT partner_program_id)
    - name: "Total Hotel To Partner Ratio"
      expr: SUM(hotel_to_partner_ratio)
    - name: "Average Hotel To Partner Ratio"
      expr: AVG(hotel_to_partner_ratio)
    - name: "Total Partner To Hotel Ratio"
      expr: SUM(partner_to_hotel_ratio)
    - name: "Average Partner To Hotel Ratio"
      expr: AVG(partner_to_hotel_ratio)
    - name: "Total Revenue Share Percentage"
      expr: SUM(revenue_share_percentage)
    - name: "Average Revenue Share Percentage"
      expr: AVG(revenue_share_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_program_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program Config business metrics"
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`program_config`"
  dimensions:
    - name: "Api Integration Enabled Flag"
      expr: api_integration_enabled_flag
    - name: "Cash Plus Points Enabled Flag"
      expr: cash_plus_points_enabled_flag
    - name: "Ccpa Compliant Flag"
      expr: ccpa_compliant_flag
    - name: "Configuration Effective Date"
      expr: configuration_effective_date
    - name: "Configuration Expiry Date"
      expr: configuration_expiry_date
    - name: "Contact Center Email"
      expr: contact_center_email
    - name: "Contact Center Phone"
      expr: contact_center_phone
    - name: "Conversion Currency Code"
      expr: conversion_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Name"
      expr: currency_name
    - name: "Data Retention Policy Months"
      expr: data_retention_policy_months
    - name: "Family Pooling Enabled Flag"
      expr: family_pooling_enabled_flag
    - name: "Gdpr Compliant Flag"
      expr: gdpr_compliant_flag
    - name: "Gifting Enabled Flag"
      expr: gifting_enabled_flag
    - name: "Inactivity Period Months"
      expr: inactivity_period_months
    - name: "Liability Estimation Method"
      expr: liability_estimation_method
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Program Config"
      expr: COUNT(DISTINCT program_config_id)
    - name: "Total Breakage Assumption Rate"
      expr: SUM(breakage_assumption_rate)
    - name: "Average Breakage Assumption Rate"
      expr: AVG(breakage_assumption_rate)
    - name: "Total Points To Currency Conversion Rate"
      expr: SUM(points_to_currency_conversion_rate)
    - name: "Average Points To Currency Conversion Rate"
      expr: AVG(points_to_currency_conversion_rate)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_promotion_distribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion Distribution business metrics"
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`promotion_distribution`"
  dimensions:
    - name: "Actual Bookings"
      expr: actual_bookings
    - name: "Channel Priority Rank"
      expr: channel_priority_rank
    - name: "Created Date"
      expr: created_date
    - name: "Distribution Status"
      expr: distribution_status
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Performance Target Bookings"
      expr: performance_target_bookings
    - name: "Created Date Month"
      expr: DATE_TRUNC('MONTH', created_date)
    - name: "Effective Date Month"
      expr: DATE_TRUNC('MONTH', effective_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promotion Distribution"
      expr: COUNT(DISTINCT promotion_distribution_id)
    - name: "Total Budget Allocation Amount"
      expr: SUM(budget_allocation_amount)
    - name: "Average Budget Allocation Amount"
      expr: AVG(budget_allocation_amount)
    - name: "Total Budget Consumed Amount"
      expr: SUM(budget_consumed_amount)
    - name: "Average Budget Consumed Amount"
      expr: AVG(budget_consumed_amount)
    - name: "Total Promotion Rate Multiplier"
      expr: SUM(promotion_rate_multiplier)
    - name: "Average Promotion Rate Multiplier"
      expr: AVG(promotion_rate_multiplier)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_promotion_treatment_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion Treatment Rule business metrics"
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`promotion_treatment_rule`"
  dimensions:
    - name: "Created Date"
      expr: created_date
    - name: "Current Redemptions"
      expr: current_redemptions
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Maximum Redemptions"
      expr: maximum_redemptions
    - name: "Rule Status"
      expr: rule_status
    - name: "Created Date Month"
      expr: DATE_TRUNC('MONTH', created_date)
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promotion Treatment Rule"
      expr: COUNT(DISTINCT promotion_treatment_rule_id)
    - name: "Total Bonus Points Multiplier"
      expr: SUM(bonus_points_multiplier)
    - name: "Average Bonus Points Multiplier"
      expr: AVG(bonus_points_multiplier)
    - name: "Total Discount Percentage"
      expr: SUM(discount_percentage)
    - name: "Average Discount Percentage"
      expr: AVG(discount_percentage)
    - name: "Total Minimum Spend"
      expr: SUM(minimum_spend)
    - name: "Average Minimum Spend"
      expr: AVG(minimum_spend)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_redemption_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Redemption Rule business metrics"
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`redemption_rule`"
  dimensions:
    - name: "Advance Booking Days"
      expr: advance_booking_days
    - name: "Blackout Dates"
      expr: blackout_dates
    - name: "Calculation Basis"
      expr: calculation_basis
    - name: "Combinable With Promotions"
      expr: combinable_with_promotions
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Eligible Property Codes"
      expr: eligible_property_codes
    - name: "Eligible Rate Codes"
      expr: eligible_rate_codes
    - name: "Excluded Property Codes"
      expr: excluded_property_codes
    - name: "Excluded Rate Codes"
      expr: excluded_rate_codes
    - name: "Lra Applicable"
      expr: lra_applicable
    - name: "Maximum Los"
      expr: maximum_los
    - name: "Minimum Los"
      expr: minimum_los
    - name: "Modified By"
      expr: modified_by
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Redemption Rule"
      expr: COUNT(DISTINCT redemption_rule_id)
    - name: "Total Maximum Earn Per Stay"
      expr: SUM(maximum_earn_per_stay)
    - name: "Average Maximum Earn Per Stay"
      expr: AVG(maximum_earn_per_stay)
    - name: "Total Maximum Redemption Per Transaction"
      expr: SUM(maximum_redemption_per_transaction)
    - name: "Average Maximum Redemption Per Transaction"
      expr: AVG(maximum_redemption_per_transaction)
    - name: "Total Minimum Points Balance"
      expr: SUM(minimum_points_balance)
    - name: "Average Minimum Points Balance"
      expr: AVG(minimum_points_balance)
    - name: "Total Points Rate"
      expr: SUM(points_rate)
    - name: "Average Points Rate"
      expr: AVG(points_rate)
    - name: "Total Tier Multiplier Base"
      expr: SUM(tier_multiplier_base)
    - name: "Average Tier Multiplier Base"
      expr: AVG(tier_multiplier_base)
    - name: "Total Tier Multiplier Gold"
      expr: SUM(tier_multiplier_gold)
    - name: "Average Tier Multiplier Gold"
      expr: AVG(tier_multiplier_gold)
    - name: "Total Tier Multiplier Platinum"
      expr: SUM(tier_multiplier_platinum)
    - name: "Average Tier Multiplier Platinum"
      expr: AVG(tier_multiplier_platinum)
    - name: "Total Tier Multiplier Silver"
      expr: SUM(tier_multiplier_silver)
    - name: "Average Tier Multiplier Silver"
      expr: AVG(tier_multiplier_silver)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_reward_catalog`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reward Catalog business metrics"
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`reward_catalog`"
  dimensions:
    - name: "Availability Type"
      expr: availability_type
    - name: "Blackout Dates"
      expr: blackout_dates
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Display Order"
      expr: display_order
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Eligible Tier Base"
      expr: eligible_tier_base
    - name: "Eligible Tier Gold"
      expr: eligible_tier_gold
    - name: "Eligible Tier Platinum"
      expr: eligible_tier_platinum
    - name: "Eligible Tier Silver"
      expr: eligible_tier_silver
    - name: "Featured Flag"
      expr: featured_flag
    - name: "Geographic Restriction"
      expr: geographic_restriction
    - name: "Image Url"
      expr: image_url
    - name: "Inventory Count"
      expr: inventory_count
    - name: "Inventory Threshold"
      expr: inventory_threshold
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Reward Catalog"
      expr: COUNT(DISTINCT reward_catalog_id)
    - name: "Total Monetary Value"
      expr: SUM(monetary_value)
    - name: "Average Monetary Value"
      expr: AVG(monetary_value)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_tier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tier business metrics"
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`tier`"
  dimensions:
    - name: "Bonus Points On Enrollment"
      expr: bonus_points_on_enrollment
    - name: "Breakfast Benefit Flag"
      expr: breakfast_benefit_flag
    - name: "Color Code"
      expr: color_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dedicated Support Flag"
      expr: dedicated_support_flag
    - name: "Display Order"
      expr: display_order
    - name: "Downgrade Grace Period Months"
      expr: downgrade_grace_period_months
    - name: "Early Checkin Hours"
      expr: early_checkin_hours
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Guaranteed Availability Flag"
      expr: guaranteed_availability_flag
    - name: "Icon Url"
      expr: icon_url
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Late Checkout Hours"
      expr: late_checkout_hours
    - name: "Lounge Access Flag"
      expr: lounge_access_flag
    - name: "Priority Reservation Flag"
      expr: priority_reservation_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tier"
      expr: COUNT(DISTINCT tier_id)
    - name: "Total Points Earning Multiplier"
      expr: SUM(points_earning_multiplier)
    - name: "Average Points Earning Multiplier"
      expr: AVG(points_earning_multiplier)
    - name: "Total Qualification Spend Threshold"
      expr: SUM(qualification_spend_threshold)
    - name: "Average Qualification Spend Threshold"
      expr: AVG(qualification_spend_threshold)
$$;