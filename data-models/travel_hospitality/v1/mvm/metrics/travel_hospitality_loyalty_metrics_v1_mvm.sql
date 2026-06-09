-- Metric views for domain: loyalty | Business: Travel Hospitality | Version: 1 | Generated on: 2026-05-08 05:56:59

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core loyalty member KPIs covering portfolio health, engagement depth, points economics, and revenue contribution. Used by loyalty program leadership to steer acquisition, retention, and tier strategy."
  source: "`travel_hospitality_ecm`.`loyalty`.`member`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current status of the loyalty membership account (e.g., Active, Suspended, Closed). Primary filter for active-base analysis."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the member originally enrolled (e.g., Web, Mobile, Front Desk). Used to evaluate channel acquisition effectiveness."
    - name: "tier_id"
      expr: tier_id
      comment: "Foreign key to the loyalty tier. Used to segment KPIs by tier level (Base, Silver, Gold, Platinum)."
    - name: "vip_flag"
      expr: vip_flag
      comment: "Indicates whether the member holds VIP designation. Enables VIP-vs-standard cohort comparisons."
    - name: "currency_preference"
      expr: currency_preference
      comment: "Member's preferred currency. Useful for regional and currency-based segmentation."
    - name: "enrollment_date_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment date. Enables cohort and vintage analysis of member acquisition trends."
    - name: "last_stay_date_month"
      expr: DATE_TRUNC('MONTH', last_stay_date)
      comment: "Month of the member's most recent stay. Used to identify recency cohorts and at-risk members."
    - name: "tier_expiration_date_month"
      expr: DATE_TRUNC('MONTH', tier_expiration_date)
      comment: "Month when the member's current tier expires. Supports proactive retention and re-qualification campaigns."
    - name: "communication_opt_in"
      expr: communication_opt_in
      comment: "Whether the member has opted into general communications. Governs reachable audience size for campaigns."
    - name: "email_opt_in"
      expr: email_opt_in
      comment: "Whether the member has opted into email communications. Used to size email-reachable audience."
  measures:
    - name: "total_active_members"
      expr: COUNT(CASE WHEN membership_status = 'Active' THEN member_id END)
      comment: "Count of members with Active status. Core program health KPI used by loyalty leadership to track enrolled active base size."
    - name: "total_members"
      expr: COUNT(member_id)
      comment: "Total count of all loyalty members regardless of status. Baseline denominator for penetration and conversion rate calculations."
    - name: "total_lifetime_points_earned"
      expr: SUM(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Sum of all lifetime points earned across the member base. Reflects total program engagement and liability generation volume."
    - name: "total_points_redeemed"
      expr: SUM(CAST(points_redeemed AS DOUBLE))
      comment: "Sum of all points redeemed by members. Measures redemption activity and program value delivery to members."
    - name: "total_points_expired"
      expr: SUM(CAST(points_expired AS DOUBLE))
      comment: "Sum of all points that have expired without redemption. Indicates breakage volume and potential member dissatisfaction risk."
    - name: "total_current_points_balance"
      expr: SUM(CAST(current_points_balance AS DOUBLE))
      comment: "Sum of current unredeemed points balances across all members. Represents total outstanding loyalty liability exposure."
    - name: "avg_current_points_balance"
      expr: AVG(CAST(current_points_balance AS DOUBLE))
      comment: "Average current points balance per member. Indicates typical member engagement depth and unredeemed value per member."
    - name: "total_lifetime_revenue"
      expr: SUM(CAST(lifetime_revenue AS DOUBLE))
      comment: "Sum of lifetime revenue attributed to loyalty members. Core financial KPI linking program membership to revenue generation."
    - name: "avg_lifetime_revenue_per_member"
      expr: AVG(CAST(lifetime_revenue AS DOUBLE))
      comment: "Average lifetime revenue per loyalty member. Used to benchmark member value and justify program investment."
    - name: "total_ytd_revenue"
      expr: SUM(CAST(ytd_revenue AS DOUBLE))
      comment: "Sum of year-to-date revenue across all loyalty members. Tracks in-year revenue contribution of the loyalty base."
    - name: "avg_salt_score"
      expr: AVG(CAST(salt_score AS DOUBLE))
      comment: "Average SALT (Satisfaction and Loyalty Tracking) score across members. Proxy for member satisfaction and loyalty health."
    - name: "vip_member_count"
      expr: COUNT(CASE WHEN vip_flag = True THEN member_id END)
      comment: "Count of members with VIP designation. Tracks the size of the highest-value member cohort."
    - name: "email_opt_in_member_count"
      expr: COUNT(CASE WHEN email_opt_in = True THEN member_id END)
      comment: "Count of members opted into email communications. Determines the reachable audience for email-based loyalty campaigns."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_points_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transactional points economics KPIs covering earning, redemption, adjustment, and transfer activity. Used by loyalty finance and program operations to monitor points liability, breakage, and member engagement velocity."
  source: "`travel_hospitality_ecm`.`loyalty`.`points_ledger`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of points ledger transaction (e.g., Earn, Redeem, Adjust, Transfer, Expire). Primary dimension for points flow analysis."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the points transaction (e.g., Posted, Pending, Reversed). Used to filter to confirmed vs. in-flight transactions."
    - name: "source_activity_type"
      expr: source_activity_type
      comment: "Business activity that generated the points transaction (e.g., Room Stay, F&B, Spa). Enables revenue-stream attribution of points earning."
    - name: "is_qualifying"
      expr: is_qualifying
      comment: "Whether the transaction counts toward tier qualification. Separates qualifying from non-qualifying earning activity."
    - name: "tier_at_transaction"
      expr: tier_at_transaction
      comment: "Member's tier at the time of the transaction. Enables tier-level analysis of points economics."
    - name: "transfer_direction"
      expr: transfer_direction
      comment: "Direction of a points transfer (Inbound/Outbound). Used to analyze partner transfer flows."
    - name: "base_currency_code"
      expr: base_currency_code
      comment: "Currency of the base transaction amount. Supports multi-currency points economics analysis."
    - name: "activity_date_month"
      expr: DATE_TRUNC('MONTH', activity_date)
      comment: "Month of the points activity date. Enables monthly trend analysis of points earning and redemption volumes."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month the transaction was posted to the ledger. Used for financial period-aligned points liability reporting."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month when the points are scheduled to expire. Supports proactive expiry management and member re-engagement targeting."
    - name: "partner_program_code"
      expr: partner_program_code
      comment: "Partner loyalty program code for transfer transactions. Used to analyze partner program exchange volumes."
  measures:
    - name: "total_points_earned"
      expr: SUM(CASE WHEN transaction_type = 'Earn' THEN points_amount ELSE 0 END)
      comment: "Total points earned across all earning transactions. Core program engagement volume metric used to track accrual activity."
    - name: "total_points_redeemed"
      expr: SUM(CASE WHEN transaction_type = 'Redeem' THEN points_amount ELSE 0 END)
      comment: "Total points redeemed across all redemption transactions. Measures value delivery to members and drives liability reduction."
    - name: "total_points_adjusted"
      expr: SUM(CASE WHEN transaction_type = 'Adjust' THEN points_amount ELSE 0 END)
      comment: "Total points adjusted (positive or negative) via manual or system adjustments. Tracks operational correction volume and potential fraud exposure."
    - name: "total_points_transferred"
      expr: SUM(CASE WHEN transaction_type = 'Transfer' THEN points_amount ELSE 0 END)
      comment: "Total points transferred to or from partner programs. Measures partner program engagement and cross-program flow."
    - name: "total_base_amount"
      expr: SUM(CAST(base_amount AS DOUBLE))
      comment: "Sum of the base transaction amounts that generated points. Represents the revenue base underlying points accrual activity."
    - name: "avg_points_per_transaction"
      expr: AVG(CAST(points_amount AS DOUBLE))
      comment: "Average points amount per ledger transaction. Indicates typical earning or redemption magnitude per event."
    - name: "total_transfer_fees"
      expr: SUM(CAST(transfer_fee_amount AS DOUBLE))
      comment: "Total fees collected on points transfer transactions. Tracks ancillary revenue from partner transfer activity."
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average currency conversion rate applied to points transactions. Used to monitor FX impact on points economics."
    - name: "qualifying_transaction_count"
      expr: COUNT(CASE WHEN is_qualifying = True THEN points_ledger_id END)
      comment: "Count of transactions that qualify toward tier status. Measures the volume of tier-building activity across the member base."
    - name: "distinct_active_members"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of distinct members with at least one points ledger transaction. Measures active engagement breadth of the loyalty program."
    - name: "total_ledger_transactions"
      expr: COUNT(points_ledger_id)
      comment: "Total count of points ledger transactions. Baseline volume metric for operational throughput and system load monitoring."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty program enrollment KPIs tracking acquisition volume, channel mix, consent rates, and status-match activity. Used by loyalty marketing and program management to optimize member acquisition strategy."
  source: "`travel_hospitality_ecm`.`loyalty`.`enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the enrollment record (e.g., Active, Pending, Cancelled). Primary filter for valid enrollment analysis."
    - name: "channel_id"
      expr: channel_id
      comment: "Channel through which the enrollment was completed. Used to evaluate acquisition channel performance and cost-per-enrollment."
    - name: "country_code"
      expr: country_code
      comment: "Country of enrollment. Enables geographic analysis of member acquisition patterns."
    - name: "device_type"
      expr: device_type
      comment: "Device type used during enrollment (e.g., Mobile, Desktop, Kiosk). Informs digital channel optimization."
    - name: "status_match_flag"
      expr: status_match_flag
      comment: "Indicates whether the enrollment included a status match from a competing program. Tracks competitive acquisition activity."
    - name: "language_code"
      expr: language_code
      comment: "Language preference selected at enrollment. Used for localization and regional segmentation."
    - name: "enrollment_date_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment. Enables monthly acquisition trend analysis and seasonality assessment."
    - name: "initial_tier_id"
      expr: initial_tier_id
      comment: "Tier assigned at enrollment. Used to analyze status-match and tier-grant enrollment patterns."
    - name: "email_consent_flag"
      expr: email_consent_flag
      comment: "Whether the member consented to email marketing at enrollment. Tracks consent rate trends for compliance and campaign planning."
    - name: "privacy_policy_accepted_flag"
      expr: privacy_policy_accepted_flag
      comment: "Whether the member accepted the privacy policy at enrollment. Required for regulatory compliance monitoring."
  measures:
    - name: "total_enrollments"
      expr: COUNT(enrollment_id)
      comment: "Total count of loyalty program enrollments. Primary acquisition volume KPI used to track program growth."
    - name: "active_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'Active' THEN enrollment_id END)
      comment: "Count of enrollments with Active status. Measures the net active enrolled base excluding cancelled or pending records."
    - name: "status_match_enrollments"
      expr: COUNT(CASE WHEN status_match_flag = True THEN enrollment_id END)
      comment: "Count of enrollments that included a competitive status match. Tracks competitive acquisition volume and associated tier liability."
    - name: "total_welcome_bonus_points"
      expr: SUM(CAST(welcome_bonus_points AS DOUBLE))
      comment: "Sum of welcome bonus points awarded at enrollment. Measures the points liability and investment associated with new member acquisition."
    - name: "avg_welcome_bonus_points"
      expr: AVG(CAST(welcome_bonus_points AS DOUBLE))
      comment: "Average welcome bonus points per enrollment. Used to benchmark acquisition incentive levels and compare across channels or campaigns."
    - name: "email_consent_rate_numerator"
      expr: COUNT(CASE WHEN email_consent_flag = True THEN enrollment_id END)
      comment: "Count of enrollments with email consent granted. Numerator for email consent rate calculation (divide by total_enrollments). Tracks reachable audience growth."
    - name: "documentation_submitted_count"
      expr: COUNT(CASE WHEN documentation_submitted_flag = True THEN enrollment_id END)
      comment: "Count of enrollments where required documentation was submitted. Monitors compliance completeness for regulated markets."
    - name: "distinct_properties_enrolling"
      expr: COUNT(DISTINCT property_id)
      comment: "Count of distinct properties generating enrollments. Measures property-level participation in loyalty acquisition."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty redemption KPIs covering points consumption, monetary value delivered, fulfillment performance, and redemption type mix. Used by loyalty operations and finance to manage redemption liability, member value delivery, and fulfillment SLAs."
  source: "`travel_hospitality_ecm`.`loyalty`.`redemption`"
  dimensions:
    - name: "redemption_type"
      expr: redemption_type
      comment: "Type of redemption (e.g., Free Night, Upgrade, Partner, Cash+Points). Enables analysis of redemption mix and reward category preferences."
    - name: "redemption_status"
      expr: redemption_status
      comment: "Current status of the redemption (e.g., Confirmed, Pending, Cancelled, Fulfilled). Used to filter to completed vs. in-flight redemptions."
    - name: "fulfillment_channel"
      expr: fulfillment_channel
      comment: "Channel through which the redemption was fulfilled. Tracks operational fulfillment channel mix."
    - name: "tier_at_redemption"
      expr: tier_at_redemption
      comment: "Member's tier at the time of redemption. Enables tier-level analysis of redemption behavior and value delivery."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the redemption transaction. Supports multi-currency redemption analysis."
    - name: "partner_code"
      expr: partner_code
      comment: "Partner code for partner-program redemptions. Used to analyze partner redemption volumes and settlement obligations."
    - name: "request_date_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month the redemption was requested. Enables monthly redemption trend and seasonality analysis."
    - name: "fulfillment_date_month"
      expr: DATE_TRUNC('MONTH', fulfillment_date)
      comment: "Month the redemption was fulfilled. Used for financial period-aligned liability release reporting."
    - name: "channel_id"
      expr: channel_id
      comment: "Channel through which the redemption was initiated. Tracks digital vs. assisted redemption channel mix."
  measures:
    - name: "total_redemptions"
      expr: COUNT(redemption_id)
      comment: "Total count of redemption transactions. Baseline volume KPI for redemption activity and operational throughput."
    - name: "confirmed_redemptions"
      expr: COUNT(CASE WHEN redemption_status = 'Confirmed' THEN redemption_id END)
      comment: "Count of confirmed redemptions. Measures successfully processed redemption volume excluding cancellations and pending records."
    - name: "total_points_redeemed"
      expr: SUM(CAST(points_redeemed AS DOUBLE))
      comment: "Total points consumed across all redemptions. Core liability reduction metric used by loyalty finance to track points burn rate."
    - name: "total_points_refunded"
      expr: SUM(CAST(points_refunded AS DOUBLE))
      comment: "Total points refunded due to cancellations or disputes. Tracks reversal volume and associated re-liability impact."
    - name: "total_monetary_equivalent_value"
      expr: SUM(CAST(monetary_equivalent_value AS DOUBLE))
      comment: "Sum of monetary equivalent value of all redemptions. Quantifies the total financial value delivered to members through redemptions."
    - name: "avg_monetary_equivalent_value"
      expr: AVG(CAST(monetary_equivalent_value AS DOUBLE))
      comment: "Average monetary equivalent value per redemption. Benchmarks the typical value delivered per redemption event."
    - name: "total_cash_amount"
      expr: SUM(CAST(cash_amount AS DOUBLE))
      comment: "Total cash component of Cash+Points redemptions. Tracks the revenue contribution from hybrid redemption transactions."
    - name: "cancellation_count"
      expr: COUNT(CASE WHEN redemption_status = 'Cancelled' THEN redemption_id END)
      comment: "Count of cancelled redemptions. Monitors redemption cancellation rate as an indicator of member friction and operational issues."
    - name: "distinct_redeeming_members"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of distinct members who have made at least one redemption. Measures redemption participation breadth across the member base."
    - name: "avg_points_per_redemption"
      expr: AVG(CAST(points_redeemed AS DOUBLE))
      comment: "Average points consumed per redemption transaction. Indicates typical redemption size and helps forecast liability burn velocity."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_tier_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty tier movement KPIs tracking upgrade, downgrade, and retention dynamics across the member base. Used by loyalty program management to monitor tier health, qualification trends, and status-match activity."
  source: "`travel_hospitality_ecm`.`loyalty`.`tier_history`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of tier change event (e.g., Upgrade, Downgrade, Renewal, Status Match, Override). Primary dimension for tier movement analysis."
    - name: "change_reason_code"
      expr: change_reason_code
      comment: "Coded reason for the tier change. Used to distinguish earned upgrades from administrative overrides and status matches."
    - name: "previous_tier_code"
      expr: previous_tier_code
      comment: "Tier code before the change. Enables from-tier analysis of upgrade and downgrade flows."
    - name: "qualification_basis"
      expr: qualification_basis
      comment: "Basis on which tier qualification was achieved (e.g., Nights, Spend, Points, Status Match). Tracks which qualification pathway members use."
    - name: "is_current_tier_flag"
      expr: is_current_tier_flag
      comment: "Whether this record represents the member's current active tier. Used to filter to current-state tier distribution."
    - name: "tier_extension_granted_flag"
      expr: tier_extension_granted_flag
      comment: "Whether a tier extension was granted. Tracks retention intervention volume."
    - name: "notification_sent_flag"
      expr: notification_sent_flag
      comment: "Whether a tier change notification was sent to the member. Monitors communication compliance for tier events."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the tier change became effective. Enables monthly trend analysis of tier movement velocity."
    - name: "qualifying_period_start_date_month"
      expr: DATE_TRUNC('MONTH', qualifying_period_start_date)
      comment: "Month the qualifying period started. Used to align tier qualification analysis to program year cycles."
    - name: "status_match_source_program"
      expr: status_match_source_program
      comment: "Source loyalty program for status-match tier grants. Tracks competitive program origins of status-matched members."
  measures:
    - name: "total_tier_changes"
      expr: COUNT(tier_history_id)
      comment: "Total count of tier change events. Baseline volume metric for tier movement activity across the program."
    - name: "tier_upgrades"
      expr: COUNT(CASE WHEN change_type = 'Upgrade' THEN tier_history_id END)
      comment: "Count of tier upgrade events. Measures upward tier mobility and program engagement success."
    - name: "tier_downgrades"
      expr: COUNT(CASE WHEN change_type = 'Downgrade' THEN tier_history_id END)
      comment: "Count of tier downgrade events. Tracks member attrition from higher tiers and re-qualification failure rates."
    - name: "status_match_grants"
      expr: COUNT(CASE WHEN change_type = 'Status Match' THEN tier_history_id END)
      comment: "Count of tier grants via competitive status match. Measures competitive acquisition volume and associated tier liability."
    - name: "tier_extensions_granted"
      expr: COUNT(CASE WHEN tier_extension_granted_flag = True THEN tier_history_id END)
      comment: "Count of tier extension grants. Tracks retention intervention volume and associated program cost."
    - name: "total_bonus_points_awarded_on_tier_change"
      expr: SUM(CAST(bonus_points_awarded AS DOUBLE))
      comment: "Sum of bonus points awarded in connection with tier change events. Quantifies the points liability generated by tier upgrade incentives."
    - name: "avg_qualifying_spend_at_tier_change"
      expr: AVG(CAST(qualifying_spend_amount AS DOUBLE))
      comment: "Average qualifying spend amount at the time of tier change. Benchmarks the spend threshold members achieve to earn tier changes."
    - name: "avg_qualifying_points_at_tier_change"
      expr: AVG(CAST(qualifying_points_achieved AS DOUBLE))
      comment: "Average qualifying points achieved at the time of tier change. Indicates typical points accumulation required for tier movement."
    - name: "distinct_members_with_tier_change"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of distinct members who experienced a tier change. Measures the breadth of tier mobility across the active member base."
    - name: "notification_sent_count"
      expr: COUNT(CASE WHEN notification_sent_flag = True THEN tier_history_id END)
      comment: "Count of tier change events where a notification was sent. Monitors communication compliance and member outreach coverage for tier events."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_promotion_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty promotion participation and completion KPIs covering enrollment volume, bonus award delivery, and campaign effectiveness. Used by loyalty marketing to evaluate promotion ROI and member engagement with targeted offers."
  source: "`travel_hospitality_ecm`.`loyalty`.`enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Status of the promotion enrollment (e.g., Enrolled, Completed, Cancelled, Expired). Primary filter for active vs. completed promotion participation."
    - name: "enrollment_date_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of promotion enrollment. Enables monthly promotion uptake trend analysis."
  measures:
    - name: "Row Count"
      expr: COUNT(1)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_benefit_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty benefit redemption KPIs covering benefit delivery volume, cost-to-property, SLA compliance, and exception rates. Used by loyalty operations and property management to monitor benefit fulfillment quality and cost impact."
  source: "`travel_hospitality_ecm`.`loyalty`.`redemption`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the benefit monetary value. Supports multi-currency benefit cost analysis."
  measures:
    - name: "Row Count"
      expr: COUNT(1)
$$;