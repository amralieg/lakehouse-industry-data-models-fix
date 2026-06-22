-- Metric views for domain: loyalty | Business: Restaurants | Version: 2 | Generated on: 2026-06-22 15:12:58

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core loyalty membership KPIs tracking program health, engagement, and member value. Used by CMO and VP Loyalty to steer acquisition, retention, and tier strategy."
  source: "`vibe_restaurants_v1`.`loyalty`.`member`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current membership status (active, suspended, closed) for cohort segmentation."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the member enrolled (app, web, in-store, kiosk) for acquisition analysis."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment for cohort and trend analysis."
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year of enrollment for annual cohort comparisons."
    - name: "birthday_month"
      expr: birthday_month
      comment: "Member birth month for birthday campaign targeting and seasonal analysis."
    - name: "preferred_language"
      expr: preferred_language
      comment: "Member preferred language for localization and communication strategy."
    - name: "last_activity_month"
      expr: DATE_TRUNC('MONTH', last_activity_date)
      comment: "Month of last member activity for recency segmentation and churn risk analysis."
    - name: "last_transaction_month"
      expr: DATE_TRUNC('MONTH', last_transaction_date)
      comment: "Month of last transaction for purchase recency analysis."
  measures:
    - name: "total_active_members"
      expr: COUNT(DISTINCT CASE WHEN program_status = 'active' THEN member_id END)
      comment: "Count of active loyalty members. Core KPI for program size and health tracked in every executive review."
    - name: "total_members"
      expr: COUNT(DISTINCT member_id)
      comment: "Total enrolled members across all statuses. Baseline for program reach and penetration rate."
    - name: "total_lifetime_points_earned"
      expr: SUM(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Sum of all points ever earned across members. Indicates program engagement volume and liability exposure."
    - name: "total_lifetime_points_redeemed"
      expr: SUM(CAST(lifetime_points_redeemed AS DOUBLE))
      comment: "Sum of all points ever redeemed. Measures redemption activity and program value delivery to members."
    - name: "avg_current_points_balance"
      expr: AVG(CAST(current_points_balance AS DOUBLE))
      comment: "Average unredeemed points balance per member. High balances signal redemption friction or disengagement risk."
    - name: "total_current_points_balance"
      expr: SUM(CAST(current_points_balance AS DOUBLE))
      comment: "Total outstanding points balance across all members. Represents program financial liability on the balance sheet."
    - name: "total_points_expiring_soon"
      expr: SUM(CAST(points_expiring_soon AS DOUBLE))
      comment: "Total points at risk of expiration. Drives urgency campaigns to re-engage members before points lapse."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score across loyalty members. Key satisfaction KPI used in QBRs to assess program advocacy."
    - name: "avg_total_visits"
      expr: AVG(CAST(total_visits AS DOUBLE))
      comment: "Average visit count per member. Measures program-driven frequency and behavioral engagement."
    - name: "email_opt_in_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN email_opt_in = TRUE THEN member_id END) / NULLIF(COUNT(DISTINCT member_id), 0), 2)
      comment: "Percentage of members opted into email communications. Drives reachable audience sizing for campaigns."
    - name: "sms_opt_in_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN sms_opt_in = TRUE THEN member_id END) / NULLIF(COUNT(DISTINCT member_id), 0), 2)
      comment: "Percentage of members opted into SMS. Determines SMS channel reach for time-sensitive promotions."
    - name: "push_notification_opt_in_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN push_notification_opt_in = TRUE THEN member_id END) / NULLIF(COUNT(DISTINCT member_id), 0), 2)
      comment: "Percentage of members opted into push notifications. Critical for mobile engagement strategy decisions."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_points_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Points economy KPIs tracking earn, burn, and balance dynamics across the loyalty program. Used by Finance and Loyalty Operations to manage program liability and engagement."
  source: "`vibe_restaurants_v1`.`loyalty`.`points_ledger`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of points transaction (earn, redeem, adjust, expire) for points flow analysis."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel where the points transaction originated (POS, app, web, delivery) for channel attribution."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of the points transaction for trend and seasonality analysis."
    - name: "transaction_year"
      expr: YEAR(transaction_timestamp)
      comment: "Year of the points transaction for annual program performance review."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for financial reporting alignment of points liability."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual financial reporting of points program costs."
    - name: "is_voided"
      expr: is_voided
      comment: "Whether the transaction was voided, used to filter clean vs. voided transactions."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source system that generated the points transaction for data lineage and reconciliation."
  measures:
    - name: "total_points_transactions"
      expr: COUNT(1)
      comment: "Total number of points ledger transactions. Baseline volume metric for program activity."
    - name: "total_order_amount"
      expr: SUM(CAST(order_total_amount AS DOUBLE))
      comment: "Total order value associated with points transactions. Links loyalty activity to revenue generation."
    - name: "avg_order_amount"
      expr: AVG(CAST(order_total_amount AS DOUBLE))
      comment: "Average order value per points transaction. Measures whether loyalty members spend more per visit."
    - name: "total_points_balance_after"
      expr: SUM(CAST(points_balance_after AS DOUBLE))
      comment: "Sum of post-transaction point balances. Proxy for total outstanding program liability at a point in time."
    - name: "avg_points_earn_rate"
      expr: AVG(CAST(points_earn_rate AS DOUBLE))
      comment: "Average points earn rate per transaction. Monitors consistency of earn mechanics across channels."
    - name: "voided_transaction_count"
      expr: COUNT(DISTINCT CASE WHEN is_voided = TRUE THEN points_ledger_id END)
      comment: "Count of voided points transactions. High void rates signal POS integration issues or fraud."
    - name: "distinct_members_transacting"
      expr: COUNT(DISTINCT loyalty_member_id)
      comment: "Count of unique members with points activity. Measures active engagement breadth across the member base."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Redemption performance KPIs measuring how members exchange points for rewards. Used by VP Loyalty and Finance to assess program value delivery, discount liability, and fraud risk."
  source: "`vibe_restaurants_v1`.`loyalty`.`redemption`"
  dimensions:
    - name: "redemption_status"
      expr: redemption_status
      comment: "Status of the redemption (completed, voided, pending) for pipeline and success rate analysis."
    - name: "reward_type"
      expr: reward_type
      comment: "Type of reward redeemed (free item, discount, points multiplier) for reward mix analysis."
    - name: "channel"
      expr: channel
      comment: "Channel where redemption occurred (app, POS, web, drive-thru) for channel effectiveness analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of redemption (breakfast, lunch, dinner) for time-of-day redemption pattern analysis."
    - name: "member_tier"
      expr: member_tier
      comment: "Member tier at time of redemption for tier-based redemption behavior analysis."
    - name: "redemption_month"
      expr: DATE_TRUNC('MONTH', redemption_timestamp)
      comment: "Month of redemption for trend and seasonality analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the redemption transaction for multi-market financial reporting."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Whether the redemption was flagged as fraudulent. Used to filter clean vs. suspect transactions."
  measures:
    - name: "total_redemptions"
      expr: COUNT(1)
      comment: "Total number of redemption events. Core volume KPI for program engagement and reward utilization."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total monetary value of discounts granted through redemptions. Directly impacts margin and program cost."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per redemption. Benchmarks reward generosity and cost per redemption event."
    - name: "total_order_value_before_discount"
      expr: SUM(CAST(order_total_before_discount AS DOUBLE))
      comment: "Total order value before loyalty discount applied. Measures gross revenue associated with loyalty redemptions."
    - name: "total_order_value_after_discount"
      expr: SUM(CAST(order_total_after_discount AS DOUBLE))
      comment: "Total net order value after loyalty discount. Measures net revenue retained after program cost."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud score across redemptions. Rising scores trigger fraud investigation and rule tightening."
    - name: "fraudulent_redemption_count"
      expr: COUNT(DISTINCT CASE WHEN fraud_flag = TRUE THEN redemption_id END)
      comment: "Count of redemptions flagged as fraudulent. Key risk KPI for loyalty program integrity."
    - name: "distinct_redeeming_members"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of unique members who redeemed. Measures redemption breadth and program value delivery reach."
    - name: "avg_points_balance_before_redemption"
      expr: AVG(CAST(points_balance_before AS DOUBLE))
      comment: "Average points balance before redemption. Indicates at what balance threshold members choose to redeem."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_offer_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Offer redemption effectiveness KPIs measuring campaign offer performance, discount impact, and member engagement. Used by Marketing and Loyalty teams to optimize offer strategy."
  source: "`vibe_restaurants_v1`.`loyalty`.`redemption`"
  dimensions:
    - name: "redemption_status"
      expr: redemption_status
      comment: "Status of the offer redemption (completed, voided, duplicate) for success rate analysis."
    - name: "member_tier"
      expr: member_tier
      comment: "Member tier at time of offer redemption for tier-based offer performance analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of offer redemption for time-of-day offer effectiveness analysis."
    - name: "redemption_month"
      expr: DATE_TRUNC('MONTH', redemption_timestamp)
      comment: "Month of offer redemption for trend analysis and campaign performance tracking."
  measures:
    - name: "total_offer_redemptions"
      expr: COUNT(1)
      comment: "Total offer redemption events. Core volume KPI for offer campaign performance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value granted through offer redemptions. Measures campaign cost and margin impact."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per offer redemption. Benchmarks offer generosity and cost efficiency."
    - name: "distinct_members_redeeming_offers"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of unique members who redeemed an offer. Measures offer reach and engagement breadth."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_tier_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tier movement KPIs tracking upgrades, downgrades, and qualification dynamics. Used by VP Loyalty to assess tier program health, member progression, and retention strategy."
  source: "`vibe_restaurants_v1`.`loyalty`.`tier_history`"
  dimensions:
    - name: "tier_change_type"
      expr: tier_change_type
      comment: "Type of tier change (upgrade, downgrade, maintain, initial) for tier movement analysis."
    - name: "tier_change_reason_code"
      expr: tier_change_reason_code
      comment: "Reason code for the tier change for root cause analysis of tier movements."
    - name: "new_tier_code"
      expr: new_tier_code
      comment: "The tier the member moved into. Used to measure tier distribution and upgrade rates."
    - name: "previous_tier_code"
      expr: previous_tier_code
      comment: "The tier the member moved from. Used to analyze downgrade patterns and retention risk."
    - name: "is_manual_override"
      expr: is_manual_override
      comment: "Whether the tier change was a manual override. High manual rates signal qualification rule issues."
    - name: "is_promotional_tier"
      expr: is_promotional_tier
      comment: "Whether the tier was granted as a promotional tier. Used to separate earned vs. gifted tier status."
    - name: "tier_change_month"
      expr: DATE_TRUNC('MONTH', tier_change_timestamp)
      comment: "Month of tier change for trend analysis of tier movement velocity."
    - name: "notification_channel"
      expr: notification_channel
      comment: "Channel used to notify member of tier change for communication effectiveness analysis."
  measures:
    - name: "total_tier_changes"
      expr: COUNT(1)
      comment: "Total tier change events. Baseline volume for tier program activity and member progression."
    - name: "upgrade_count"
      expr: COUNT(DISTINCT CASE WHEN tier_change_type = 'upgrade' THEN tier_history_id END)
      comment: "Count of tier upgrades. Measures program success in driving members to higher engagement tiers."
    - name: "downgrade_count"
      expr: COUNT(DISTINCT CASE WHEN tier_change_type = 'downgrade' THEN tier_history_id END)
      comment: "Count of tier downgrades. High downgrade rates signal retention risk and disengagement."
    - name: "avg_qualifying_spend_amount"
      expr: AVG(CAST(qualifying_spend_amount AS DOUBLE))
      comment: "Average spend amount that qualified the tier change. Benchmarks spend thresholds against tier qualification criteria."
    - name: "avg_qualifying_points_balance"
      expr: AVG(CAST(qualifying_points_balance AS DOUBLE))
      comment: "Average points balance at time of tier qualification. Informs tier threshold calibration decisions."
    - name: "avg_tier_duration_days"
      expr: AVG(CAST(tier_duration_days AS DOUBLE))
      comment: "Average number of days a member held a tier before changing. Measures tier stability and member tenure."
    - name: "notification_sent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN notification_sent_flag = TRUE THEN tier_history_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tier changes where notification was sent. Measures communication execution completeness."
    - name: "manual_override_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_manual_override = TRUE THEN tier_history_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tier changes that were manual overrides. High rates indicate qualification rule gaps."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_challenge_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Challenge participation and completion KPIs measuring gamification effectiveness. Used by Loyalty and Marketing teams to evaluate challenge ROI and member engagement depth."
  source: "`vibe_restaurants_v1`.`loyalty`.`challenge_enrollment`"
  dimensions:
    - name: "challenge_enrollment_status"
      expr: challenge_enrollment_status
      comment: "Current status of the enrollment (active, completed, cancelled, disqualified) for funnel analysis."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the member enrolled in the challenge for acquisition channel analysis."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source that drove challenge enrollment (push notification, email, in-app) for attribution."
    - name: "reward_type"
      expr: reward_type
      comment: "Type of reward offered for challenge completion for reward mix effectiveness analysis."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of challenge enrollment for trend and seasonality analysis."
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month of challenge completion for completion velocity analysis."
    - name: "opt_in_flag"
      expr: opt_in_flag
      comment: "Whether the member explicitly opted into the challenge. Distinguishes voluntary vs. auto-enrolled participants."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total challenge enrollments. Core volume KPI for gamification program reach."
    - name: "completed_enrollments"
      expr: COUNT(DISTINCT CASE WHEN challenge_enrollment_status = 'completed' THEN challenge_enrollment_id END)
      comment: "Count of successfully completed challenge enrollments. Measures challenge effectiveness and member follow-through."
    - name: "challenge_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN challenge_enrollment_status = 'completed' THEN challenge_enrollment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments that resulted in completion. Key KPI for challenge design effectiveness."
    - name: "reward_issued_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN reward_issued_flag = TRUE THEN challenge_enrollment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments where reward was issued. Measures reward fulfillment execution quality."
    - name: "avg_progress_percentage"
      expr: AVG(CAST(progress_percentage AS DOUBLE))
      comment: "Average completion progress across active enrollments. Identifies challenges where members stall."
    - name: "avg_reward_value"
      expr: AVG(CAST(reward_value AS DOUBLE))
      comment: "Average reward value per challenge enrollment. Benchmarks incentive generosity against completion rates."
    - name: "total_reward_value_issued"
      expr: SUM(CASE WHEN reward_issued_flag = TRUE THEN reward_value ELSE 0 END)
      comment: "Total reward value issued for completed challenges. Measures total gamification program cost."
    - name: "distinct_participating_members"
      expr: COUNT(DISTINCT loyalty_member_id)
      comment: "Count of unique members participating in challenges. Measures gamification reach across the member base."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_offer_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Offer assignment and delivery KPIs measuring personalization effectiveness and offer funnel performance. Used by Marketing and CRM teams to optimize offer targeting and delivery."
  source: "`vibe_restaurants_v1`.`loyalty`.`offer_assignment`"
  dimensions:
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of offer assignment (targeted, broadcast, triggered) for personalization strategy analysis."
    - name: "assignment_channel"
      expr: assignment_channel
      comment: "Channel used to assign/deliver the offer (email, push, in-app) for channel effectiveness analysis."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the offer (delivered, failed, pending) for delivery quality monitoring."
    - name: "redemption_status"
      expr: redemption_status
      comment: "Redemption status of the assigned offer (redeemed, expired, active) for conversion funnel analysis."
    - name: "ab_test_variant"
      expr: ab_test_variant
      comment: "A/B test variant for the offer assignment. Enables controlled experiment analysis of offer performance."
    - name: "assignment_month"
      expr: DATE_TRUNC('MONTH', assignment_timestamp)
      comment: "Month of offer assignment for trend and campaign timing analysis."
    - name: "assignment_reason_code"
      expr: assignment_reason_code
      comment: "Reason code for the assignment (segment match, birthday, win-back) for targeting logic analysis."
  measures:
    - name: "total_offer_assignments"
      expr: COUNT(1)
      comment: "Total offer assignments issued. Baseline volume for offer distribution reach."
    - name: "delivered_offer_count"
      expr: COUNT(DISTINCT CASE WHEN delivery_status = 'delivered' THEN offer_assignment_id END)
      comment: "Count of successfully delivered offers. Measures distribution execution quality."
    - name: "redeemed_offer_count"
      expr: COUNT(DISTINCT CASE WHEN redemption_status = 'redeemed' THEN offer_assignment_id END)
      comment: "Count of assigned offers that were redeemed. Core conversion KPI for offer campaign effectiveness."
    - name: "offer_redemption_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN redemption_status = 'redeemed' THEN offer_assignment_id END) / NULLIF(COUNT(DISTINCT CASE WHEN delivery_status = 'delivered' THEN offer_assignment_id END), 0), 2)
      comment: "Percentage of delivered offers that were redeemed. Primary KPI for offer campaign ROI and targeting quality."
    - name: "avg_personalization_score"
      expr: AVG(CAST(personalization_score AS DOUBLE))
      comment: "Average personalization relevance score for offer assignments. Higher scores should correlate with better redemption rates."
    - name: "distinct_members_assigned"
      expr: COUNT(DISTINCT loyalty_member_id)
      comment: "Count of unique members who received an offer assignment. Measures campaign reach breadth."
    - name: "wallet_visible_offer_count"
      expr: COUNT(DISTINCT CASE WHEN is_wallet_visible = TRUE THEN offer_assignment_id END)
      comment: "Count of offers visible in member wallet. Measures active offer inventory available to members."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty visit KPIs measuring member visit behavior, spend patterns, and channel engagement. Used by Operations and Loyalty teams to track frequency, spend, and qualifying visit rates."
  source: "`vibe_restaurants_v1`.`loyalty`.`loyalty_visit`"
  dimensions:
    - name: "visit_channel"
      expr: visit_channel
      comment: "Channel of the loyalty visit (dine-in, drive-thru, delivery, app) for channel mix analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the visit (breakfast, lunch, dinner, late night) for time-of-day visit pattern analysis."
    - name: "is_qualifying_visit"
      expr: is_qualifying_visit
      comment: "Whether the visit qualified for loyalty points. Used to measure program participation rate."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the visit transaction for multi-market financial reporting."
    - name: "visit_month"
      expr: DATE_TRUNC('MONTH', visit_date)
      comment: "Month of the loyalty visit for trend and seasonality analysis."
    - name: "visit_year"
      expr: YEAR(visit_date)
      comment: "Year of the loyalty visit for annual performance comparison."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source system that recorded the visit for data lineage and reconciliation."
  measures:
    - name: "total_loyalty_visits"
      expr: COUNT(1)
      comment: "Total loyalty-tracked visits. Core frequency KPI for program engagement and visit behavior."
    - name: "qualifying_visit_count"
      expr: COUNT(DISTINCT CASE WHEN is_qualifying_visit = TRUE THEN loyalty_visit_id END)
      comment: "Count of visits that qualified for loyalty points. Measures program participation and earn activity."
    - name: "qualifying_visit_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_qualifying_visit = TRUE THEN loyalty_visit_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of loyalty visits that were qualifying. Measures program rule effectiveness and member compliance."
    - name: "total_spend_amount"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total spend across all loyalty visits. Measures revenue directly attributable to loyalty member visits."
    - name: "avg_spend_per_visit"
      expr: AVG(CAST(spend_amount AS DOUBLE))
      comment: "Average spend per loyalty visit. Key KPI for measuring loyalty program impact on check size."
    - name: "total_check_amount"
      expr: SUM(CAST(check_amount AS DOUBLE))
      comment: "Total check amount across loyalty visits. Alternative revenue measure for cross-validation with POS data."
    - name: "distinct_visiting_members"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of unique members with recorded visits. Measures active member base size and engagement breadth."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_program_campaign_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program budget allocation KPIs measuring how loyalty program funds are distributed across campaigns. Used by Finance and Loyalty leadership to govern program spend and ROI accountability."
  source: "`vibe_restaurants_v1`.`loyalty`.`program_campaign_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of the allocation (active, expired, pending) for budget pipeline management."
    - name: "allocation_basis"
      expr: allocation_basis
      comment: "Basis for the allocation (percentage, fixed amount, per-member) for allocation methodology analysis."
    - name: "allocation_period"
      expr: allocation_period
      comment: "Period covered by the allocation (monthly, quarterly, annual) for budget cycle alignment."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the allocation for multi-market budget reporting."
    - name: "is_active"
      expr: is_active
      comment: "Whether the allocation is currently active. Used to filter live vs. historical allocations."
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month of the allocation for budget trend analysis."
    - name: "program_campaign_allocation_status"
      expr: program_campaign_allocation_status
      comment: "Detailed status of the program-campaign allocation for workflow tracking."
  measures:
    - name: "total_allocated_budget"
      expr: SUM(CAST(allocated_budget AS DOUBLE))
      comment: "Total budget allocated to campaigns from loyalty programs. Core financial KPI for program spend governance."
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total monetary amount allocated across all program-campaign pairings. Measures total program investment."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_pct AS DOUBLE))
      comment: "Average allocation percentage per program-campaign pairing. Monitors budget concentration risk."
    - name: "total_allocation_amount"
      expr: SUM(CAST(allocation_amount AS DOUBLE))
      comment: "Total allocation amount across all active allocations. Used for budget vs. actual reconciliation."
    - name: "active_allocation_count"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN program_campaign_allocation_id END)
      comment: "Count of currently active program-campaign allocations. Measures portfolio breadth of active campaigns."
    - name: "avg_rate_percent"
      expr: AVG(CAST(rate_percent AS DOUBLE))
      comment: "Average allocation rate percentage. Benchmarks program contribution rates across campaigns."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_referral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Referral program KPIs measuring member acquisition through word-of-mouth and referral mechanics. Used by Growth and Loyalty teams to evaluate referral program ROI and conversion."
  source: "`vibe_restaurants_v1`.`loyalty`.`referral`"
  dimensions:
    - name: "referral_status"
      expr: referral_status
      comment: "Status of the referral (pending, converted, expired, fraudulent) for funnel analysis."
    - name: "channel"
      expr: channel
      comment: "Channel through which the referral was made (app, social, email) for channel attribution."
    - name: "source_platform"
      expr: source_platform
      comment: "Platform where the referral originated (iOS, Android, web) for platform performance analysis."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Whether the referral was flagged as fraudulent. Used to filter clean vs. suspect referrals."
    - name: "referral_month"
      expr: DATE_TRUNC('MONTH', referral_date)
      comment: "Month of referral for trend and campaign timing analysis."
    - name: "conversion_month"
      expr: DATE_TRUNC('MONTH', conversion_date)
      comment: "Month of referral conversion for conversion velocity analysis."
  measures:
    - name: "total_referrals"
      expr: COUNT(1)
      comment: "Total referral events initiated. Core volume KPI for referral program reach."
    - name: "converted_referrals"
      expr: COUNT(DISTINCT CASE WHEN referral_status = 'converted' THEN referral_id END)
      comment: "Count of referrals that converted to new members. Measures referral program acquisition effectiveness."
    - name: "referral_conversion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN referral_status = 'converted' THEN referral_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of referrals that converted. Primary KPI for referral program ROI and quality."
    - name: "avg_first_transaction_amount"
      expr: AVG(CAST(first_transaction_amount AS DOUBLE))
      comment: "Average first transaction value of referred members. Measures quality of referred member acquisition."
    - name: "total_first_transaction_amount"
      expr: SUM(CAST(first_transaction_amount AS DOUBLE))
      comment: "Total revenue from first transactions of referred members. Measures direct revenue impact of referral program."
    - name: "fraudulent_referral_count"
      expr: COUNT(DISTINCT CASE WHEN fraud_flag = TRUE THEN referral_id END)
      comment: "Count of fraudulent referrals detected. High counts signal referral abuse requiring program rule changes."
    - name: "distinct_referring_members"
      expr: COUNT(DISTINCT primary_referral_referred_member_id)
      comment: "Count of unique members who made referrals. Measures referral program participation breadth."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Points adjustment KPIs tracking manual and systematic corrections to member balances. Used by Loyalty Operations and Finance to monitor adjustment volume, approval compliance, and reversal rates."
  source: "`vibe_restaurants_v1`.`loyalty`.`loyalty_adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (credit, debit, correction, expiration) for adjustment category analysis."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Status of the adjustment (pending, approved, rejected, reversed) for workflow monitoring."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the adjustment for root cause analysis of balance corrections."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the adjustment for governance and compliance monitoring."
    - name: "is_reversal"
      expr: is_reversal
      comment: "Whether the adjustment is a reversal of a prior adjustment. Used to measure correction quality."
    - name: "adjustment_month"
      expr: DATE_TRUNC('MONTH', adjustment_date)
      comment: "Month of the adjustment for trend analysis of correction activity."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source system that triggered the adjustment for data lineage and reconciliation."
  measures:
    - name: "total_adjustments"
      expr: COUNT(1)
      comment: "Total points adjustment events. Baseline volume for operational correction activity monitoring."
    - name: "total_points_adjusted"
      expr: SUM(CAST(points_amount AS DOUBLE))
      comment: "Total points value adjusted across all events. Measures scale of balance corrections and program liability impact."
    - name: "avg_points_adjusted"
      expr: AVG(CAST(points_amount AS DOUBLE))
      comment: "Average points per adjustment event. Benchmarks typical correction size for anomaly detection."
    - name: "approved_adjustment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_approved = TRUE THEN loyalty_adjustment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjustments that were approved. Measures governance compliance in the adjustment workflow."
    - name: "reversal_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_reversal = TRUE THEN loyalty_adjustment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjustments that are reversals. High reversal rates indicate upstream data quality issues."
    - name: "distinct_members_adjusted"
      expr: COUNT(DISTINCT loyalty_member_id)
      comment: "Count of unique members who received a points adjustment. Measures breadth of correction activity."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_enrollment_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member enrollment KPIs measuring acquisition funnel performance, channel effectiveness, and onboarding quality. Used by Growth and Loyalty teams to optimize enrollment strategy."
  source: "`vibe_restaurants_v1`.`loyalty`.`enrollment_event`"
  dimensions:
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the member enrolled (app, web, in-store, kiosk) for acquisition channel analysis."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment (organic, referral, campaign, staff-assisted) for acquisition source analysis."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Status of the enrollment (completed, pending, failed) for funnel conversion analysis."
    - name: "enrollment_country_code"
      expr: enrollment_country_code
      comment: "Country of enrollment for geographic acquisition analysis."
    - name: "enrollment_device_type"
      expr: enrollment_device_type
      comment: "Device type used for enrollment (iOS, Android, desktop) for platform strategy analysis."
    - name: "fraud_check_status"
      expr: fraud_check_status
      comment: "Result of fraud check at enrollment (passed, flagged, blocked) for enrollment quality monitoring."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_timestamp)
      comment: "Month of enrollment for trend and seasonality analysis."
    - name: "enrollment_year"
      expr: YEAR(enrollment_timestamp)
      comment: "Year of enrollment for annual acquisition performance review."
  measures:
    - name: "total_enrollment_events"
      expr: COUNT(1)
      comment: "Total enrollment events. Core acquisition volume KPI for loyalty program growth."
    - name: "completed_enrollments"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'completed' THEN enrollment_event_id END)
      comment: "Count of successfully completed enrollments. Measures net new member acquisition."
    - name: "enrollment_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN enrollment_status = 'completed' THEN enrollment_event_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollment attempts that completed. Measures enrollment funnel conversion quality."
    - name: "welcome_offer_issuance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN welcome_offer_issued_flag = TRUE THEN enrollment_event_id END) / NULLIF(COUNT(DISTINCT CASE WHEN enrollment_status = 'completed' THEN enrollment_event_id END), 0), 2)
      comment: "Percentage of completed enrollments where welcome offer was issued. Measures onboarding execution quality."
    - name: "email_opt_in_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN email_opt_in_flag = TRUE THEN enrollment_event_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments with email opt-in. Determines reachable audience size from new enrollments."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud score at enrollment. Rising scores signal increased fraudulent enrollment attempts."
    - name: "verification_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN verification_completed_flag = TRUE THEN enrollment_event_id END) / NULLIF(COUNT(DISTINCT CASE WHEN verification_required_flag = TRUE THEN enrollment_event_id END), 0), 2)
      comment: "Percentage of required verifications that were completed. Measures identity verification funnel quality."
$$;