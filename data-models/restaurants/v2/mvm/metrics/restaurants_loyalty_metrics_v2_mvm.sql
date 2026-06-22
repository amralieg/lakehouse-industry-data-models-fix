-- Metric views for domain: loyalty | Business: Restaurants | Version: 2 | Generated on: 2026-06-22 17:03:36

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for loyalty program membership health, engagement, and value. Covers active member base, points economics, tier distribution, and churn signals for executive and CRM decision-making."
  source: "`vibe_restaurants_v1`.`loyalty`.`member`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current status of the member's loyalty program enrollment (e.g. Active, Suspended, Churned). Used to segment active vs. inactive member populations."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the member enrolled (e.g. App, In-Store, Web). Drives channel attribution and enrollment campaign analysis."
    - name: "enrollment_date"
      expr: enrollment_date
      comment: "Date the member enrolled in the loyalty program. Used for cohort analysis and tenure-based segmentation."
    - name: "birthday_month"
      expr: birthday_month
      comment: "Month of the member's birthday. Used for birthday reward campaign targeting and seasonal engagement analysis."
    - name: "gamification_level"
      expr: gamification_level
      comment: "Member's current gamification level within the program. Indicates engagement depth and progression through gamified loyalty mechanics."
    - name: "last_activity_date"
      expr: last_activity_date
      comment: "Date of the member's most recent loyalty activity. Used to identify at-risk or dormant members."
    - name: "last_transaction_date"
      expr: last_transaction_date
      comment: "Date of the member's most recent transaction. Key signal for recency in RFM analysis."
    - name: "tier_effective_date"
      expr: tier_effective_date
      comment: "Date the member's current tier became effective. Used to track tier upgrade/downgrade timing."
    - name: "preferred_language"
      expr: preferred_language
      comment: "Member's preferred communication language. Used for localization and targeted communication strategy."
    - name: "email_opt_in"
      expr: email_opt_in
      comment: "Whether the member has opted into email marketing. Used to size addressable email audience."
    - name: "sms_opt_in"
      expr: sms_opt_in
      comment: "Whether the member has opted into SMS marketing. Used to size addressable SMS audience."
    - name: "push_notification_opt_in"
      expr: push_notification_opt_in
      comment: "Whether the member has opted into push notifications. Used to size addressable push audience."
  measures:
    - name: "total_active_members"
      expr: COUNT(CASE WHEN program_status = 'Active' THEN member_id END)
      comment: "Total number of members with Active program status. Core KPI for measuring loyalty program scale and health."
    - name: "total_enrolled_members"
      expr: COUNT(member_id)
      comment: "Total number of enrolled loyalty members across all statuses. Baseline for program reach and penetration."
    - name: "total_lifetime_points_earned"
      expr: SUM(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Sum of all lifetime points earned across members. Indicates total program engagement volume and liability exposure."
    - name: "total_lifetime_points_redeemed"
      expr: SUM(CAST(lifetime_points_redeemed AS DOUBLE))
      comment: "Sum of all lifetime points redeemed across members. Measures program utilization and reward fulfillment."
    - name: "total_current_points_balance"
      expr: SUM(CAST(current_points_balance AS DOUBLE))
      comment: "Total unredeemed points balance across all active members. Represents the outstanding loyalty liability on the balance sheet."
    - name: "avg_current_points_balance"
      expr: AVG(CAST(current_points_balance AS DOUBLE))
      comment: "Average unredeemed points balance per member. Indicates typical member engagement level and reward accumulation pace."
    - name: "avg_lifetime_points_earned"
      expr: AVG(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Average lifetime points earned per member. Benchmarks member engagement depth across cohorts and tiers."
    - name: "total_points_expiring_soon"
      expr: SUM(CAST(points_expiring_soon AS DOUBLE))
      comment: "Total points flagged as expiring soon across all members. Drives urgency-based re-engagement campaigns to prevent liability write-off."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score across loyalty members. Key customer satisfaction and advocacy KPI for executive reporting."
    - name: "avg_total_visits"
      expr: AVG(CAST(total_visits AS DOUBLE))
      comment: "Average number of visits per loyalty member. Measures program-driven visit frequency and customer retention effectiveness."
    - name: "total_visits_all_members"
      expr: SUM(CAST(total_visits AS DOUBLE))
      comment: "Total visits attributed to loyalty members. Quantifies the traffic contribution of the loyalty program to restaurant operations."
    - name: "members_with_email_opt_in"
      expr: COUNT(CASE WHEN email_opt_in = TRUE THEN member_id END)
      comment: "Number of members opted into email marketing. Sizes the addressable email audience for CRM campaigns."
    - name: "members_with_sms_opt_in"
      expr: COUNT(CASE WHEN sms_opt_in = TRUE THEN member_id END)
      comment: "Number of members opted into SMS marketing. Sizes the addressable SMS audience for targeted promotions."
    - name: "dormant_member_count"
      expr: COUNT(CASE WHEN last_activity_date < DATE_ADD(CURRENT_DATE(), -90) THEN member_id END)
      comment: "Members with no loyalty activity in the past 90 days. Critical churn-risk KPI that triggers win-back campaign investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_points_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for points earning, redemption, and adjustment activity. Tracks points economics, transaction volumes, and order value associated with loyalty interactions."
  source: "`vibe_restaurants_v1`.`loyalty`.`points_ledger`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of points ledger transaction (e.g. Earn, Redeem, Adjust, Expire). Used to segment points flow by activity type."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the points transaction originated (e.g. App, POS, Web). Used for channel-level points economics analysis."
    - name: "transaction_timestamp"
      expr: transaction_timestamp
      comment: "Timestamp of the points ledger transaction. Used for time-series trending of points activity."
    - name: "processed_timestamp"
      expr: processed_timestamp
      comment: "Timestamp when the transaction was processed. Used to measure processing latency and batch timing."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the transaction. Enables alignment of points economics with financial reporting cycles."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the transaction. Used for year-over-year points liability and redemption trend analysis."
    - name: "order_currency_code"
      expr: order_currency_code
      comment: "Currency of the associated order. Used for multi-currency points economics reporting."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source system that originated the points transaction. Used for data lineage and system-level reconciliation."
    - name: "adjustment_reason_code"
      expr: adjustment_reason_code
      comment: "Reason code for manual points adjustments. Used to audit and categorize adjustment activity by root cause."
    - name: "is_voided"
      expr: is_voided
      comment: "Whether the points transaction has been voided. Used to exclude invalid transactions from financial reporting."
    - name: "points_expiry_date"
      expr: points_expiry_date
      comment: "Date when the points from this transaction expire. Used for expiry liability forecasting and member re-engagement timing."
  measures:
    - name: "total_points_transactions"
      expr: COUNT(points_ledger_id)
      comment: "Total number of points ledger transactions. Baseline volume KPI for loyalty program activity."
    - name: "total_order_amount"
      expr: SUM(CAST(order_total_amount AS DOUBLE))
      comment: "Total order value associated with loyalty points transactions. Measures the revenue footprint of loyalty-engaged customers."
    - name: "avg_order_amount"
      expr: AVG(CAST(order_total_amount AS DOUBLE))
      comment: "Average order value per loyalty points transaction. Key indicator of loyalty program impact on basket size."
    - name: "total_points_balance_after"
      expr: SUM(CAST(points_balance_after AS DOUBLE))
      comment: "Sum of post-transaction points balances across all ledger entries. Tracks aggregate outstanding points liability over time."
    - name: "avg_points_earn_rate"
      expr: AVG(CAST(points_earn_rate AS DOUBLE))
      comment: "Average points earn rate applied across transactions. Monitors consistency of earn rate application and rule effectiveness."
    - name: "voided_transaction_count"
      expr: COUNT(CASE WHEN is_voided = TRUE THEN points_ledger_id END)
      comment: "Number of voided points transactions. Elevated void rates signal fraud, operational errors, or system issues requiring investigation."
    - name: "earn_transaction_count"
      expr: COUNT(CASE WHEN transaction_type = 'Earn' THEN points_ledger_id END)
      comment: "Number of points-earning transactions. Measures the frequency of qualifying purchase activity within the loyalty program."
    - name: "redeem_transaction_count"
      expr: COUNT(CASE WHEN transaction_type = 'Redeem' THEN points_ledger_id END)
      comment: "Number of points redemption transactions. Measures how actively members are converting earned points into rewards."
    - name: "adjustment_transaction_count"
      expr: COUNT(CASE WHEN transaction_type = 'Adjust' THEN points_ledger_id END)
      comment: "Number of manual points adjustment transactions. High adjustment volumes may indicate operational issues or fraud requiring audit."
    - name: "avg_points_balance_after"
      expr: AVG(CAST(points_balance_after AS DOUBLE))
      comment: "Average post-transaction points balance per ledger entry. Tracks typical member balance trajectory and reward accumulation pace."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_offer_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring offer redemption performance, discount economics, and member engagement with promotional offers. Drives offer strategy, discount budget management, and channel optimization."
  source: "`vibe_restaurants_v1`.`loyalty`.`redemption`"
  dimensions:
    - name: "member_tier"
      expr: member_tier
      comment: "Loyalty tier of the member at time of redemption. Used to evaluate offer performance by tier segment."
    - name: "daypart"
      expr: daypart
      comment: "Daypart during which the offer was redeemed (e.g. Breakfast, Lunch, Dinner). Used for daypart-level offer targeting optimization."
    - name: "redemption_status"
      expr: redemption_status
      comment: "Status of the offer redemption (e.g. Completed, Voided, Pending). Used to filter valid redemptions for financial reporting."
    - name: "redemption_timestamp"
      expr: redemption_timestamp
      comment: "Timestamp of the offer redemption event. Used for time-series trending of redemption activity."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the redemption transaction. Used for multi-currency offer economics reporting."
  measures:
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total monetary discount value granted through offer redemptions. Directly measures promotional spend and budget consumption."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per redemption. Used to benchmark offer generosity and compare discount efficiency across offer types."
    - name: "unique_members_redeeming"
      expr: COUNT(DISTINCT member_id)
      comment: "Number of distinct members who redeemed at least one offer. Measures breadth of offer engagement across the member base."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for reward redemption activity, discount economics, and fraud monitoring. Tracks how members convert loyalty points into tangible rewards and the financial impact of redemptions."
  source: "`vibe_restaurants_v1`.`loyalty`.`redemption`"
  dimensions:
    - name: "redemption_channel"
      expr: channel
      comment: "Channel through which the reward was redeemed (e.g. App, POS, Drive-Thru). Used for channel-level redemption performance analysis."
    - name: "reward_type"
      expr: reward_type
      comment: "Type of reward redeemed (e.g. Free Item, Discount, Combo Meal). Used to analyze reward portfolio performance and member preferences."
    - name: "redemption_status"
      expr: redemption_status
      comment: "Status of the redemption (e.g. Completed, Reversed, Pending). Used to filter valid redemptions for financial and operational reporting."
    - name: "member_tier"
      expr: member_tier
      comment: "Loyalty tier of the member at time of redemption. Used to evaluate redemption behavior and reward value by tier."
    - name: "daypart"
      expr: daypart
      comment: "Daypart during which the redemption occurred. Used for operational scheduling and daypart-level reward demand analysis."
    - name: "redemption_timestamp"
      expr: redemption_timestamp
      comment: "Timestamp of the reward redemption event. Used for time-series trending and peak redemption period analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the redemption transaction. Used for multi-currency financial reporting."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Whether the redemption was flagged as potentially fraudulent. Used to monitor and investigate fraud exposure in the loyalty program."
    - name: "third_party_delivery_partner"
      expr: third_party_delivery_partner
      comment: "Third-party delivery partner associated with the redemption. Used to evaluate loyalty redemption performance across delivery platforms."
    - name: "expiration_date"
      expr: expiration_date
      comment: "Expiration date of the redeemed reward. Used to analyze redemption timing relative to reward expiry."
  measures:
    - name: "total_redemptions"
      expr: COUNT(redemption_id)
      comment: "Total number of reward redemption events. Baseline KPI for loyalty reward utilization and program engagement."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total monetary discount value granted through reward redemptions. Measures the cost of rewards fulfilled and promotional liability realized."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per reward redemption. Benchmarks reward generosity and cost-per-redemption for budget planning."
    - name: "total_order_value_before_discount"
      expr: SUM(CAST(order_total_before_discount AS DOUBLE))
      comment: "Total pre-discount order value for redemption transactions. Measures the revenue base on which loyalty rewards are applied."
    - name: "total_order_value_after_discount"
      expr: SUM(CAST(order_total_after_discount AS DOUBLE))
      comment: "Total post-discount order value for redemption transactions. Measures net revenue realized after loyalty reward discounts."
    - name: "avg_order_value_after_discount"
      expr: AVG(CAST(order_total_after_discount AS DOUBLE))
      comment: "Average post-discount order value per redemption. Indicates the net basket size of reward-redeeming members."
    - name: "avg_points_balance_before_redemption"
      expr: AVG(CAST(points_balance_before AS DOUBLE))
      comment: "Average member points balance before redemption. Indicates the typical accumulation threshold at which members choose to redeem."
    - name: "avg_points_balance_after_redemption"
      expr: AVG(CAST(points_balance_after AS DOUBLE))
      comment: "Average member points balance after redemption. Measures residual balance and likelihood of continued engagement post-redemption."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud score across redemption events. Elevated scores signal systemic fraud risk requiring security intervention."
    - name: "fraudulent_redemption_count"
      expr: COUNT(CASE WHEN fraud_flag = TRUE THEN redemption_id END)
      comment: "Number of redemptions flagged as fraudulent. Direct measure of fraud exposure and program integrity risk."
    - name: "unique_members_redeeming_rewards"
      expr: COUNT(DISTINCT member_id)
      comment: "Number of distinct members who redeemed at least one reward. Measures breadth of reward engagement across the loyalty member base."
    - name: "reversed_redemption_count"
      expr: COUNT(CASE WHEN redemption_status = 'Reversed' THEN redemption_id END)
      comment: "Number of reversed redemptions. High reversal rates indicate operational issues, fraud, or member disputes requiring investigation."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_enrollment_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for loyalty program enrollment performance, channel effectiveness, fraud screening, and opt-in rates. Drives acquisition strategy and onboarding quality decisions."
  source: "`vibe_restaurants_v1`.`loyalty`.`enrollment_event`"
  dimensions:
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the member enrolled (e.g. App, In-Store, Web, Kiosk). Used for channel-level enrollment performance and cost-per-acquisition analysis."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment event (e.g. New, Re-enrollment, Transfer). Used to distinguish organic growth from win-back activity."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Status of the enrollment (e.g. Completed, Pending, Rejected). Used to measure enrollment completion rates and identify drop-off."
    - name: "enrollment_country_code"
      expr: enrollment_country_code
      comment: "Country in which the enrollment occurred. Used for geographic enrollment trend analysis and market expansion tracking."
    - name: "enrollment_device_type"
      expr: enrollment_device_type
      comment: "Device type used during enrollment (e.g. iOS, Android, Desktop). Used for UX optimization and device-level conversion analysis."
    - name: "enrollment_timestamp"
      expr: enrollment_timestamp
      comment: "Timestamp of the enrollment event. Used for time-series trending of enrollment volume and campaign attribution."
    - name: "fraud_check_status"
      expr: fraud_check_status
      comment: "Result of the fraud check performed at enrollment (e.g. Passed, Failed, Review). Used to monitor enrollment fraud rates."
    - name: "referral_source"
      expr: referral_source
      comment: "Source of the member referral. Used to evaluate referral program effectiveness and member acquisition attribution."
    - name: "enrollment_language"
      expr: enrollment_language
      comment: "Language selected during enrollment. Used for localization strategy and multilingual program reach analysis."
    - name: "verification_required_flag"
      expr: verification_required_flag
      comment: "Whether identity verification was required at enrollment. Used to assess friction in the enrollment funnel."
  measures:
    - name: "total_enrollments"
      expr: COUNT(enrollment_event_id)
      comment: "Total number of loyalty enrollment events. Primary KPI for program acquisition volume and growth rate."
    - name: "completed_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'Completed' THEN enrollment_event_id END)
      comment: "Number of successfully completed enrollments. Measures effective acquisition after accounting for incomplete or rejected enrollments."
    - name: "verified_enrollments"
      expr: COUNT(CASE WHEN verification_completed_flag = TRUE THEN enrollment_event_id END)
      comment: "Number of enrollments where identity verification was successfully completed. Measures onboarding quality and fraud prevention effectiveness."
    - name: "welcome_offer_issued_count"
      expr: COUNT(CASE WHEN welcome_offer_issued_flag = TRUE THEN enrollment_event_id END)
      comment: "Number of enrollments where a welcome offer was issued. Measures welcome offer fulfillment rate and new member activation investment."
    - name: "email_opt_in_enrollments"
      expr: COUNT(CASE WHEN email_opt_in_flag = TRUE THEN enrollment_event_id END)
      comment: "Number of enrollments with email marketing opt-in. Measures the size of the email-addressable new member cohort."
    - name: "sms_opt_in_enrollments"
      expr: COUNT(CASE WHEN sms_opt_in_flag = TRUE THEN enrollment_event_id END)
      comment: "Number of enrollments with SMS marketing opt-in. Measures the size of the SMS-addressable new member cohort."
    - name: "push_notification_opt_in_enrollments"
      expr: COUNT(CASE WHEN push_notification_opt_in_flag = TRUE THEN enrollment_event_id END)
      comment: "Number of enrollments with push notification opt-in. Measures the size of the push-addressable new member cohort."
    - name: "fraud_flagged_enrollments"
      expr: COUNT(CASE WHEN fraud_check_status = 'Failed' THEN enrollment_event_id END)
      comment: "Number of enrollments that failed fraud screening. Monitors enrollment fraud exposure and the effectiveness of fraud prevention controls."
    - name: "avg_fraud_score_at_enrollment"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud score at time of enrollment. Tracks overall fraud risk profile of new member acquisitions over time."
    - name: "referral_driven_enrollments"
      expr: COUNT(CASE WHEN referral_code IS NOT NULL THEN enrollment_event_id END)
      comment: "Number of enrollments attributed to a referral code. Measures the effectiveness and reach of the member referral acquisition program."
    - name: "terms_accepted_enrollments"
      expr: COUNT(CASE WHEN terms_accepted_flag = TRUE THEN enrollment_event_id END)
      comment: "Number of enrollments where terms and conditions were accepted. Compliance KPI ensuring regulatory and legal enrollment requirements are met."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_offer_distribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for offer distribution effectiveness, personalization performance, and redemption conversion. Drives offer targeting strategy and distribution channel optimization."
  source: "`vibe_restaurants_v1`.`loyalty`.`offer_distribution`"
  dimensions:
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Channel through which the offer was distributed (e.g. Email, Push, SMS, In-App). Used for channel-level distribution performance analysis."
    - name: "redemption_status"
      expr: redemption_status
      comment: "Redemption status of the distributed offer (e.g. Redeemed, Expired, Pending). Used to measure offer conversion rates by distribution channel."
    - name: "personalized_flag"
      expr: personalized_flag
      comment: "Whether the offer was personalized for the member. Used to compare conversion rates of personalized vs. generic offers."
    - name: "is_viewed"
      expr: is_viewed
      comment: "Whether the distributed offer was viewed by the member. Used to measure offer visibility and open rates."
    - name: "distributed_at"
      expr: distributed_at
      comment: "Timestamp when the offer was distributed. Used for time-series analysis of distribution volume and campaign timing."
    - name: "member_expiry_date"
      expr: member_expiry_date
      comment: "Date the offer expires for the specific member. Used to analyze redemption urgency and expiry-driven conversion patterns."
  measures:
    - name: "total_offers_distributed"
      expr: COUNT(offer_distribution_id)
      comment: "Total number of offer distribution events. Baseline KPI for offer campaign reach and distribution volume."
    - name: "total_offers_viewed"
      expr: COUNT(CASE WHEN is_viewed = TRUE THEN offer_distribution_id END)
      comment: "Number of distributed offers that were viewed by the member. Measures offer visibility and the effectiveness of distribution channel delivery."
    - name: "total_offers_redeemed"
      expr: COUNT(CASE WHEN redemption_status = 'Redeemed' THEN offer_distribution_id END)
      comment: "Number of distributed offers that were redeemed. Measures end-to-end offer conversion from distribution to redemption."
    - name: "personalized_offers_distributed"
      expr: COUNT(CASE WHEN personalized_flag = TRUE THEN offer_distribution_id END)
      comment: "Number of personalized offer distributions. Used to track personalization program scale and compare performance against generic offers."
    - name: "avg_personalization_score"
      expr: AVG(CAST(personalization_score AS DOUBLE))
      comment: "Average personalization score across distributed offers. Measures the quality and relevance of offer targeting algorithms."
    - name: "unique_members_receiving_offers"
      expr: COUNT(DISTINCT member_id)
      comment: "Number of distinct members who received at least one offer distribution. Measures the breadth of offer campaign reach across the member base."
    - name: "unique_offers_distributed"
      expr: COUNT(DISTINCT offer_id)
      comment: "Number of distinct offers distributed. Measures offer portfolio utilization and diversity of promotional activity."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_reward`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for loyalty reward portfolio performance, cost economics, and redemption utilization. Enables reward strategy optimization, cost-per-redemption benchmarking, and portfolio rationalization."
  source: "`vibe_restaurants_v1`.`loyalty`.`reward`"
  dimensions:
    - name: "reward_type"
      expr: reward_type
      comment: "Type of loyalty reward (e.g. Free Item, Discount, Combo Meal, Partner Offer). Used to analyze performance and cost by reward category."
    - name: "reward_status"
      expr: reward_status
      comment: "Current status of the reward (e.g. Active, Inactive, Expired). Used to manage the active reward portfolio."
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount associated with the reward (e.g. Percentage, Fixed Amount). Used to analyze discount structure across the reward portfolio."
    - name: "tier_eligibility"
      expr: tier_eligibility
      comment: "Tier(s) eligible to redeem this reward. Used to evaluate reward accessibility and tier-based reward strategy."
    - name: "availability_start_date"
      expr: availability_start_date
      comment: "Date the reward became available. Used for reward lifecycle and seasonal availability analysis."
    - name: "availability_end_date"
      expr: availability_end_date
      comment: "Date the reward expires. Used for reward portfolio lifecycle management and expiry planning."
    - name: "featured_flag"
      expr: featured_flag
      comment: "Whether the reward is featured in the app or marketing. Used to measure the impact of featured placement on redemption rates."
    - name: "tax_treatment"
      expr: tax_treatment
      comment: "Tax treatment applied to the reward. Used for financial compliance and tax liability reporting."
    - name: "partner_name"
      expr: partner_name
      comment: "Name of the partner associated with the reward (for partner offers). Used to evaluate partner reward program performance."
  measures:
    - name: "total_rewards_in_portfolio"
      expr: COUNT(reward_id)
      comment: "Total number of rewards in the loyalty reward portfolio. Measures portfolio breadth and variety available to members."
    - name: "active_rewards_count"
      expr: COUNT(CASE WHEN reward_status = 'Active' THEN reward_id END)
      comment: "Number of currently active rewards. Measures the live reward portfolio size available for member redemption."
    - name: "total_redemption_count"
      expr: SUM(CAST(redemption_count AS DOUBLE))
      comment: "Total number of times rewards have been redeemed across the portfolio. Measures overall reward utilization and program engagement."
    - name: "avg_points_cost_per_reward"
      expr: AVG(CAST(points_cost AS DOUBLE))
      comment: "Average points cost required to redeem a reward. Benchmarks reward accessibility and points-to-value conversion across the portfolio."
    - name: "avg_monetary_value_per_reward"
      expr: AVG(CAST(monetary_value AS DOUBLE))
      comment: "Average monetary value of rewards in the portfolio. Used to assess reward generosity and perceived value to members."
    - name: "total_cost_of_goods_sold"
      expr: SUM(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Total COGS associated with loyalty rewards. Directly measures the financial cost of the reward portfolio to the business."
    - name: "avg_cost_of_goods_sold"
      expr: AVG(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Average COGS per reward. Used to benchmark reward cost efficiency and identify high-cost rewards for portfolio rationalization."
    - name: "total_discount_value"
      expr: SUM(CAST(discount_value AS DOUBLE))
      comment: "Total discount value across all rewards in the portfolio. Measures the aggregate promotional liability of the reward catalog."
    - name: "avg_minimum_purchase_amount"
      expr: AVG(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Average minimum purchase amount required to redeem a reward. Measures the basket-size threshold built into the reward portfolio."
    - name: "featured_reward_count"
      expr: COUNT(CASE WHEN featured_flag = TRUE THEN reward_id END)
      comment: "Number of rewards currently featured in marketing or the app. Used to manage featured placement strategy and measure its impact on redemption."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for loyalty program portfolio management, economics, and configuration. Enables program-level performance benchmarking and investment decisions across the brand portfolio."
  source: "`vibe_restaurants_v1`.`loyalty`.`program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current status of the loyalty program (e.g. Active, Inactive, Pilot). Used to filter active programs for operational reporting."
    - name: "program_type"
      expr: program_type
      comment: "Type of loyalty program (e.g. Points-Based, Tiered, Subscription). Used to compare program model performance."
    - name: "ownership_model"
      expr: ownership_model
      comment: "Ownership model of the program (e.g. Corporate, Franchise, Joint). Used for P&L attribution and governance reporting."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the program (e.g. National, Regional, Global). Used for market-level program performance analysis."
    - name: "launch_date"
      expr: launch_date
      comment: "Date the program was launched. Used for program maturity analysis and cohort-based performance benchmarking."
    - name: "tier_enabled_flag"
      expr: tier_enabled_flag
      comment: "Whether tiered membership is enabled for this program. Used to compare tiered vs. flat program performance."
    - name: "gamification_enabled_flag"
      expr: gamification_enabled_flag
      comment: "Whether gamification features are enabled. Used to measure the impact of gamification on member engagement."
    - name: "personalization_enabled_flag"
      expr: personalization_enabled_flag
      comment: "Whether personalization is enabled for this program. Used to evaluate personalization ROI across programs."
    - name: "third_party_delivery_enabled_flag"
      expr: third_party_delivery_enabled_flag
      comment: "Whether third-party delivery integration is enabled. Used to assess loyalty program reach across delivery platforms."
  measures:
    - name: "total_programs"
      expr: COUNT(program_id)
      comment: "Total number of loyalty programs in the portfolio. Baseline KPI for program portfolio scale."
    - name: "active_programs_count"
      expr: COUNT(CASE WHEN program_status = 'Active' THEN program_id END)
      comment: "Number of currently active loyalty programs. Measures the live program footprint across the brand portfolio."
    - name: "avg_points_per_dollar"
      expr: AVG(CAST(points_per_dollar AS DOUBLE))
      comment: "Average points awarded per dollar spent across programs. Benchmarks earn rate generosity and competitive positioning of the loyalty portfolio."
    - name: "avg_dollar_per_point"
      expr: AVG(CAST(dollar_per_point AS DOUBLE))
      comment: "Average dollar value per point across programs. Measures the monetary value of loyalty currency and redemption economics."
    - name: "avg_points_expiration_months"
      expr: AVG(CAST(points_expiration_months AS DOUBLE))
      comment: "Average points expiration window in months across programs. Informs liability management and member urgency-to-redeem strategy."
    - name: "total_subscription_fee_revenue"
      expr: SUM(CAST(subscription_fee_amount AS DOUBLE))
      comment: "Total subscription fee amount across paid loyalty programs. Measures direct revenue generated by premium loyalty program subscriptions."
    - name: "avg_subscription_fee_amount"
      expr: AVG(CAST(subscription_fee_amount AS DOUBLE))
      comment: "Average subscription fee per program. Used to benchmark premium loyalty program pricing strategy."
    - name: "programs_with_gamification"
      expr: COUNT(CASE WHEN gamification_enabled_flag = TRUE THEN program_id END)
      comment: "Number of programs with gamification enabled. Measures the scale of gamification investment across the loyalty portfolio."
    - name: "programs_with_personalization"
      expr: COUNT(CASE WHEN personalization_enabled_flag = TRUE THEN program_id END)
      comment: "Number of programs with personalization enabled. Measures the scale of personalization technology investment across programs."
    - name: "programs_with_third_party_delivery"
      expr: COUNT(CASE WHEN third_party_delivery_enabled_flag = TRUE THEN program_id END)
      comment: "Number of programs integrated with third-party delivery platforms. Measures loyalty program reach into the delivery channel."
$$;