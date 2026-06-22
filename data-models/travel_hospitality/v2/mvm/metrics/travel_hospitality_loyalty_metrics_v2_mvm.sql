-- Metric views for domain: loyalty | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-22 19:35:58

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core loyalty member health and value metrics. Tracks membership growth, tier distribution, points economics, lifetime value, and engagement signals to steer program investment and retention strategy."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`member`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current status of the loyalty membership account (e.g. Active, Suspended, Closed). Used to segment active vs. churned members."
    - name: "tier_id"
      expr: tier_id
      comment: "Foreign key to the loyalty tier. Used to segment members by tier level for tier-specific KPI analysis."
    - name: "enrollment_year_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of member enrollment. Used to track cohort growth and enrollment velocity over time."
    - name: "last_stay_year_month"
      expr: DATE_TRUNC('MONTH', last_stay_date)
      comment: "Month of the member's most recent stay. Used to identify recency cohorts and detect disengagement trends."
    - name: "vip_flag"
      expr: vip_flag
      comment: "Indicates whether the member holds VIP status. Used to isolate high-value member segments for targeted analysis."
    - name: "currency_preference"
      expr: currency_preference
      comment: "Member's preferred currency. Used for regional segmentation and localized program performance analysis."
    - name: "communication_opt_in"
      expr: communication_opt_in
      comment: "Whether the member has opted into communications. Used to measure reachable audience size for marketing campaigns."
    - name: "email_opt_in"
      expr: email_opt_in
      comment: "Whether the member has opted into email communications. Used to size the email-reachable member base."
    - name: "tier_expiration_year"
      expr: YEAR(tier_expiration_date)
      comment: "Year in which the member's tier qualification expires. Used to forecast tier downgrade risk cohorts."
  measures:
    - name: "total_active_members"
      expr: COUNT(CASE WHEN membership_status = 'Active' THEN member_id END)
      comment: "Count of members with Active status. Core program size KPI used by executives to track loyalty program reach and growth."
    - name: "total_enrolled_members"
      expr: COUNT(member_id)
      comment: "Total count of all enrolled loyalty members regardless of status. Baseline program enrollment metric for trend and growth reporting."
    - name: "total_lifetime_points_earned"
      expr: SUM(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Sum of all lifetime points earned across members. Indicates total program engagement and points liability exposure."
    - name: "total_points_redeemed"
      expr: SUM(CAST(points_redeemed AS DOUBLE))
      comment: "Sum of all points redeemed by members. Measures program utilization and redemption demand, a key indicator of member engagement."
    - name: "total_points_expired"
      expr: SUM(CAST(points_expired AS DOUBLE))
      comment: "Sum of all points that have expired without redemption. High expiry signals low engagement and potential member dissatisfaction."
    - name: "total_current_points_balance"
      expr: SUM(CAST(current_points_balance AS DOUBLE))
      comment: "Sum of current unredeemed points balances across all members. Represents total outstanding loyalty liability on the program balance sheet."
    - name: "avg_current_points_balance"
      expr: AVG(CAST(current_points_balance AS DOUBLE))
      comment: "Average current points balance per member. Indicates typical member engagement depth and unredeemed value per member."
    - name: "total_lifetime_revenue"
      expr: SUM(CAST(lifetime_revenue AS DOUBLE))
      comment: "Sum of lifetime revenue attributed to loyalty members. Core metric linking program membership to revenue generation for ROI analysis."
    - name: "avg_lifetime_revenue_per_member"
      expr: AVG(CAST(lifetime_revenue AS DOUBLE))
      comment: "Average lifetime revenue per loyalty member. Used to benchmark member value and justify program investment decisions."
    - name: "total_ytd_revenue"
      expr: SUM(CAST(ytd_revenue AS DOUBLE))
      comment: "Sum of year-to-date revenue from loyalty members. Used in quarterly business reviews to track in-year program revenue contribution."
    - name: "avg_salt_score"
      expr: AVG(CAST(salt_score AS DOUBLE))
      comment: "Average SALT (Satisfaction and Loyalty Tracking) score across members. Measures overall member satisfaction and loyalty sentiment."
    - name: "points_redemption_rate"
      expr: ROUND(100.0 * SUM(CAST(points_redeemed AS DOUBLE)) / NULLIF(SUM(CAST(lifetime_points_earned AS DOUBLE)), 0), 2)
      comment: "Percentage of lifetime earned points that have been redeemed. A high rate signals strong program engagement; a low rate may indicate redemption friction or disengagement."
    - name: "points_expiry_rate"
      expr: ROUND(100.0 * SUM(CAST(points_expired AS DOUBLE)) / NULLIF(SUM(CAST(lifetime_points_earned AS DOUBLE)), 0), 2)
      comment: "Percentage of lifetime earned points that expired without redemption. High expiry rates indicate member disengagement and potential program design issues."
    - name: "vip_member_count"
      expr: COUNT(CASE WHEN vip_flag = TRUE THEN member_id END)
      comment: "Count of members with VIP designation. Used to track the size of the highest-value member segment and guide premium service allocation."
    - name: "email_opt_in_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN email_opt_in = TRUE THEN member_id END) / NULLIF(COUNT(member_id), 0), 2)
      comment: "Percentage of members opted into email communications. Determines the reachable audience for email-driven loyalty campaigns."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_points_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transactional points economics metrics. Tracks points accrual, redemption, transfers, and reversals at the transaction level to monitor program liability, earning velocity, and redemption behavior."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`points_ledger`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of points transaction (e.g. Earn, Redeem, Adjust, Transfer, Expire). Primary dimension for segmenting points flow by activity type."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the points transaction (e.g. Posted, Pending, Reversed). Used to filter to confirmed vs. in-flight transactions."
    - name: "source_activity_type"
      expr: source_activity_type
      comment: "The originating activity that generated the points transaction (e.g. Stay, F&B, Partner). Used to attribute points volume to business channels."
    - name: "activity_year_month"
      expr: DATE_TRUNC('MONTH', activity_date)
      comment: "Month of the points activity. Used for time-series trending of points earn and burn velocity."
    - name: "posting_year_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month the transaction was posted to the ledger. Used to align points liability recognition to accounting periods."
    - name: "tier_at_transaction"
      expr: tier_at_transaction
      comment: "Member tier at the time of the transaction. Used to analyze earning and redemption behavior by tier segment."
    - name: "is_qualifying"
      expr: is_qualifying
      comment: "Whether the transaction counts toward tier qualification. Used to separate qualifying activity from bonus or non-qualifying transactions."
    - name: "partner_program_code"
      expr: partner_program_code
      comment: "Partner program associated with the transaction. Used to measure partner channel contribution to points volume."
    - name: "base_currency_code"
      expr: base_currency_code
      comment: "Currency of the base transaction amount. Used for multi-currency points economics analysis."
    - name: "transfer_direction"
      expr: transfer_direction
      comment: "Direction of a points transfer (Inbound/Outbound). Used to track net points flow from partner and member transfer activity."
  measures:
    - name: "total_points_earned"
      expr: SUM(CASE WHEN transaction_type = 'Earn' THEN points_amount ELSE 0 END)
      comment: "Total points earned across all earn transactions. Core measure of program accrual volume and member engagement activity."
    - name: "total_points_redeemed"
      expr: SUM(CASE WHEN transaction_type = 'Redeem' THEN points_amount ELSE 0 END)
      comment: "Total points redeemed across all redemption transactions. Measures redemption demand and program utilization."
    - name: "total_points_adjusted"
      expr: SUM(CASE WHEN transaction_type = 'Adjust' THEN points_amount ELSE 0 END)
      comment: "Total points adjusted via manual or system corrections. High adjustment volumes may signal operational or system issues requiring investigation."
    - name: "total_points_transferred"
      expr: SUM(CASE WHEN transaction_type = 'Transfer' THEN points_amount ELSE 0 END)
      comment: "Total points transferred between members or to/from partner programs. Indicates partner ecosystem engagement and member sharing behavior."
    - name: "total_base_amount"
      expr: SUM(CAST(base_amount AS DOUBLE))
      comment: "Total eligible spend amount underlying points transactions. Used to calculate earn rate efficiency and validate points-to-spend ratios."
    - name: "avg_points_per_transaction"
      expr: AVG(CAST(points_amount AS DOUBLE))
      comment: "Average points amount per ledger transaction. Used to benchmark transaction-level earning and redemption depth."
    - name: "total_transfer_fees"
      expr: SUM(CAST(transfer_fee_amount AS DOUBLE))
      comment: "Total fees collected on points transfer transactions. Measures ancillary revenue from the transfer feature and fee policy effectiveness."
    - name: "avg_balance_after_transaction"
      expr: AVG(CAST(balance_after_transaction AS DOUBLE))
      comment: "Average member points balance immediately after a transaction. Tracks the typical post-transaction balance level as a proxy for member engagement depth."
    - name: "qualifying_transaction_count"
      expr: COUNT(CASE WHEN is_qualifying = TRUE THEN points_ledger_id END)
      comment: "Count of transactions that qualify toward tier status. Used to monitor tier qualification pipeline and forecast tier upgrade volumes."
    - name: "unique_active_members"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of distinct members with at least one points ledger transaction. Measures the active transacting member base within any given period."
    - name: "earn_to_redeem_ratio"
      expr: ROUND(SUM(CASE WHEN transaction_type = 'Earn' THEN points_amount ELSE 0 END) / NULLIF(SUM(CASE WHEN transaction_type = 'Redeem' THEN points_amount ELSE 0 END), 0), 4)
      comment: "Ratio of points earned to points redeemed. A ratio above 1 indicates net liability accumulation; below 1 indicates net liability reduction. Critical for program financial health monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Redemption activity and value metrics. Tracks redemption volume, points consumed, monetary equivalent value, and fulfillment performance to optimize reward catalog design and redemption operations."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`redemption`"
  dimensions:
    - name: "redemption_type"
      expr: redemption_type
      comment: "Type of redemption (e.g. Free Night, Upgrade, F&B, Partner). Used to analyze which reward categories drive the most redemption activity."
    - name: "redemption_status"
      expr: redemption_status
      comment: "Current status of the redemption (e.g. Confirmed, Cancelled, Fulfilled, Pending). Used to track fulfillment pipeline and cancellation rates."
    - name: "tier_at_redemption"
      expr: tier_at_redemption
      comment: "Member tier at the time of redemption. Used to analyze redemption behavior and value by tier segment."
    - name: "fulfillment_channel"
      expr: fulfillment_channel
      comment: "Channel through which the redemption was fulfilled (e.g. Property, Online, Partner). Used to optimize fulfillment operations by channel."
    - name: "request_year_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month the redemption was requested. Used for time-series trending of redemption demand."
    - name: "fulfillment_year_month"
      expr: DATE_TRUNC('MONTH', fulfillment_date)
      comment: "Month the redemption was fulfilled. Used to measure fulfillment lag and operational throughput."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the redemption transaction. Used for multi-currency redemption value analysis."
    - name: "partner_code"
      expr: partner_code
      comment: "Partner associated with the redemption. Used to measure partner redemption channel performance."
    - name: "property_code"
      expr: property_code
      comment: "Property where the redemption was applied. Used to analyze redemption demand by property location."
  measures:
    - name: "total_redemptions"
      expr: COUNT(redemption_id)
      comment: "Total count of redemption transactions. Baseline measure of redemption volume and program utilization."
    - name: "total_points_redeemed"
      expr: SUM(CAST(points_redeemed AS DOUBLE))
      comment: "Total points consumed across all redemptions. Measures the rate at which program liability is being drawn down through member redemptions."
    - name: "total_points_refunded"
      expr: SUM(CAST(points_refunded AS DOUBLE))
      comment: "Total points refunded due to cancellations or reversals. High refund volumes indicate fulfillment issues or member dissatisfaction."
    - name: "total_monetary_equivalent_value"
      expr: SUM(CAST(monetary_equivalent_value AS DOUBLE))
      comment: "Total monetary equivalent value of all redemptions. Quantifies the financial value delivered to members through the rewards program."
    - name: "avg_points_per_redemption"
      expr: AVG(CAST(points_redeemed AS DOUBLE))
      comment: "Average points consumed per redemption transaction. Used to benchmark redemption depth and assess reward catalog pricing."
    - name: "avg_monetary_value_per_redemption"
      expr: AVG(CAST(monetary_equivalent_value AS DOUBLE))
      comment: "Average monetary equivalent value delivered per redemption. Used to evaluate the perceived value of the rewards program to members."
    - name: "total_cash_amount"
      expr: SUM(CAST(cash_amount AS DOUBLE))
      comment: "Total cash co-payment collected alongside points redemptions. Measures hybrid cash+points redemption revenue contribution."
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN redemption_status = 'Cancelled' THEN redemption_id END) / NULLIF(COUNT(redemption_id), 0), 2)
      comment: "Percentage of redemptions that were cancelled. High cancellation rates signal fulfillment friction, inventory issues, or member experience problems."
    - name: "fulfillment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN redemption_status = 'Fulfilled' THEN redemption_id END) / NULLIF(COUNT(redemption_id), 0), 2)
      comment: "Percentage of redemptions successfully fulfilled. Core operational KPI for redemption service quality and member promise delivery."
    - name: "unique_redeeming_members"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of distinct members who have made at least one redemption. Measures the breadth of active redemption participation in the program."
    - name: "net_points_redeemed"
      expr: SUM((CAST(points_redeemed AS DOUBLE)) - (CAST(points_refunded AS DOUBLE)))
      comment: "Net points consumed after accounting for refunds. Represents the true net liability reduction from redemption activity in a given period."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_promotion_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion enrollment and completion metrics. Tracks campaign participation, completion rates, qualifying spend, and points awarded to measure promotion ROI and member engagement with targeted offers."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`promotion_enrollment`"
  dimensions:
    - name: "promotion_enrollment_status"
      expr: promotion_enrollment_status
      comment: "Current status of the promotion enrollment (e.g. Enrolled, Completed, Opted-Out, Expired). Used to segment active vs. completed vs. lapsed enrollments."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the member enrolled in the promotion (e.g. Email, App, Front Desk). Used to measure channel effectiveness for promotion distribution."
    - name: "enrollment_year_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of promotion enrollment. Used to track enrollment velocity and campaign ramp-up over time."
    - name: "completion_year_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month the promotion was completed. Used to track completion timing and campaign fulfillment cadence."
    - name: "award_year_month"
      expr: DATE_TRUNC('MONTH', award_date)
      comment: "Month points were awarded for promotion completion. Used to align promotion liability recognition to award periods."
    - name: "promotion_id"
      expr: promotion_id
      comment: "Foreign key to the promotion. Used to segment all enrollment metrics by individual promotion campaign."
  measures:
    - name: "total_enrollments"
      expr: COUNT(promotion_enrollment_id)
      comment: "Total count of promotion enrollments. Baseline measure of campaign reach and member participation."
    - name: "total_completions"
      expr: COUNT(CASE WHEN promotion_enrollment_status = 'Completed' THEN promotion_enrollment_id END)
      comment: "Count of enrollments that reached completion. Measures how many members fulfilled the promotion qualifying criteria."
    - name: "completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN promotion_enrollment_status = 'Completed' THEN promotion_enrollment_id END) / NULLIF(COUNT(promotion_enrollment_id), 0), 2)
      comment: "Percentage of enrolled members who completed the promotion. Core KPI for promotion effectiveness and offer design quality."
    - name: "opt_out_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN opt_out_date IS NOT NULL THEN promotion_enrollment_id END) / NULLIF(COUNT(promotion_enrollment_id), 0), 2)
      comment: "Percentage of enrolled members who opted out of the promotion. High opt-out rates signal poor offer relevance or communication fatigue."
    - name: "total_points_awarded"
      expr: SUM(CAST(points_awarded AS DOUBLE))
      comment: "Total bonus points awarded through promotion completions. Measures the total points liability generated by the promotion campaign."
    - name: "avg_points_awarded_per_completion"
      expr: AVG(CAST(points_awarded AS DOUBLE))
      comment: "Average bonus points awarded per enrollment record. Used to benchmark promotion generosity and cost per participant."
    - name: "total_qualifying_spend"
      expr: SUM(CAST(qualifying_spend_amount AS DOUBLE))
      comment: "Total qualifying spend generated by members enrolled in promotions. Measures the incremental revenue stimulus attributable to promotion campaigns."
    - name: "avg_qualifying_spend_per_enrollment"
      expr: AVG(CAST(qualifying_spend_amount AS DOUBLE))
      comment: "Average qualifying spend per enrolled member. Used to assess the revenue lift per participant and promotion ROI."
    - name: "unique_participating_members"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of distinct members enrolled in at least one promotion. Measures the breadth of promotion campaign reach across the member base."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion program design and budget metrics. Tracks promotion portfolio health, budget utilization, bonus points economics, and spend thresholds to guide campaign investment decisions."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`promotion`"
  dimensions:
    - name: "promotion_type"
      expr: promotion_type
      comment: "Type of promotion (e.g. Bonus Points, Double Points, Free Night). Used to analyze performance by promotion category."
    - name: "promotion_status"
      expr: promotion_status
      comment: "Current status of the promotion (e.g. Active, Expired, Draft, Cancelled). Used to filter to live vs. historical promotions."
    - name: "start_year_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the promotion became active. Used to track promotion launch cadence and seasonal campaign patterns."
    - name: "end_year_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month the promotion expires. Used to forecast upcoming promotion expirations and budget close-outs."
    - name: "tier_id"
      expr: tier_id
      comment: "Tier targeted by the promotion. Used to analyze promotion investment by member tier segment."
    - name: "stackable_flag"
      expr: stackable_flag
      comment: "Whether the promotion can be combined with other offers. Used to assess combinability risk and liability exposure from stacked promotions."
    - name: "registration_required_flag"
      expr: registration_required_flag
      comment: "Whether members must register to participate. Used to compare opt-in vs. automatic promotion performance."
  measures:
    - name: "total_promotions"
      expr: COUNT(promotion_id)
      comment: "Total count of promotions in the portfolio. Baseline measure of promotion program scale and campaign volume."
    - name: "total_budget_cap"
      expr: SUM(CAST(budget_cap_amount AS DOUBLE))
      comment: "Total budget allocated across all promotions. Used to track total promotion investment commitment and program cost exposure."
    - name: "total_budget_consumed"
      expr: SUM(CAST(budget_consumed_amount AS DOUBLE))
      comment: "Total budget consumed across all promotions. Measures actual promotion spend against allocated budgets."
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(budget_consumed_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_cap_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated promotion budget that has been consumed. High utilization signals strong campaign performance; low utilization may indicate poor uptake or over-budgeting."
    - name: "total_bonus_points_liability"
      expr: SUM(CAST(bonus_points_amount AS DOUBLE))
      comment: "Total bonus points committed across all promotions. Measures the points liability exposure from the active promotion portfolio."
    - name: "avg_bonus_points_multiplier"
      expr: AVG(CAST(bonus_points_multiplier AS DOUBLE))
      comment: "Average bonus points multiplier across promotions. Used to benchmark promotion generosity and assess liability per qualifying transaction."
    - name: "avg_minimum_spend_threshold"
      expr: AVG(CAST(minimum_spend_amount AS DOUBLE))
      comment: "Average minimum spend required to qualify for promotions. Used to calibrate promotion accessibility and revenue stimulus thresholds."
    - name: "active_promotion_count"
      expr: COUNT(CASE WHEN promotion_status = 'Active' THEN promotion_id END)
      comment: "Count of currently active promotions. Used to monitor the live promotion portfolio size and campaign density."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_benefit_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member benefit entitlement utilization and value metrics. Tracks benefit grants, usage, monetary value delivered, and expiry to optimize benefit program design and measure member value delivery."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`benefit_entitlement`"
  dimensions:
    - name: "benefit_type_code"
      expr: benefit_type_code
      comment: "Type of benefit entitlement (e.g. Room Upgrade, Late Checkout, F&B Credit). Used to analyze utilization and value by benefit category."
    - name: "entitlement_status"
      expr: entitlement_status
      comment: "Current status of the benefit entitlement (e.g. Active, Used, Expired, Revoked). Used to track benefit lifecycle and utilization rates."
    - name: "entitlement_source"
      expr: entitlement_source
      comment: "Source that generated the entitlement (e.g. Tier, Promotion, Manual). Used to attribute benefit costs to program components."
    - name: "tier_id"
      expr: tier_id
      comment: "Tier associated with the benefit entitlement. Used to analyze benefit delivery and value by member tier."
    - name: "effective_year_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the benefit became effective. Used to track benefit grant volume over time."
    - name: "expiry_year_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the benefit expires. Used to forecast upcoming benefit expirations and manage member communications."
    - name: "auto_apply_flag"
      expr: auto_apply_flag
      comment: "Whether the benefit is automatically applied without member action. Used to compare auto-apply vs. member-initiated benefit utilization."
    - name: "transferable_flag"
      expr: transferable_flag
      comment: "Whether the benefit can be transferred to another member. Used to analyze transferable benefit usage patterns."
  measures:
    - name: "total_entitlements_granted"
      expr: COUNT(benefit_entitlement_id)
      comment: "Total count of benefit entitlements granted to members. Baseline measure of benefit program scale and delivery volume."
    - name: "total_monetary_value_granted"
      expr: SUM(CAST(monetary_value AS DOUBLE))
      comment: "Total monetary value of all benefit entitlements granted. Quantifies the total financial value committed to members through the benefit program."
    - name: "avg_monetary_value_per_entitlement"
      expr: AVG(CAST(monetary_value AS DOUBLE))
      comment: "Average monetary value per benefit entitlement. Used to benchmark benefit generosity and cost per member interaction."
    - name: "active_entitlement_count"
      expr: COUNT(CASE WHEN entitlement_status = 'Active' THEN benefit_entitlement_id END)
      comment: "Count of currently active (unused, non-expired) benefit entitlements. Measures outstanding benefit liability and pending member value delivery."
    - name: "expired_entitlement_count"
      expr: COUNT(CASE WHEN entitlement_status = 'Expired' THEN benefit_entitlement_id END)
      comment: "Count of benefit entitlements that expired without use. High expiry counts indicate member disengagement or poor benefit awareness."
    - name: "benefit_expiry_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN entitlement_status = 'Expired' THEN benefit_entitlement_id END) / NULLIF(COUNT(benefit_entitlement_id), 0), 2)
      comment: "Percentage of granted benefits that expired unused. A key indicator of benefit program effectiveness and member engagement with offered perks."
    - name: "avg_points_multiplier"
      expr: AVG(CAST(points_multiplier AS DOUBLE))
      comment: "Average points multiplier associated with benefit entitlements. Used to assess the earning acceleration delivered through the benefit program."
    - name: "unique_benefited_members"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of distinct members who have received at least one benefit entitlement. Measures the breadth of benefit program reach across the member base."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`loyalty_tier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty tier program design and qualification threshold metrics. Tracks tier structure, qualification economics, and benefit flags to support tier strategy decisions and program competitiveness benchmarking."
  source: "`vibe_travel_hospitality_v1`.`loyalty`.`tier`"
  dimensions:
    - name: "tier_status"
      expr: tier_status
      comment: "Current status of the tier (e.g. Active, Deprecated). Used to filter to live tiers in the program."
    - name: "tier_level"
      expr: level
      comment: "Hierarchical level of the tier (e.g. Base, Silver, Gold, Platinum). Used to segment tier metrics by program level."
    - name: "tier_code"
      expr: code
      comment: "Short code identifier for the tier. Used as a compact dimension for tier-level reporting."
    - name: "lounge_access_flag"
      expr: lounge_access_flag
      comment: "Whether the tier includes lounge access. Used to differentiate premium tiers with lounge benefits in program design analysis."
    - name: "room_upgrade_eligible_flag"
      expr: room_upgrade_eligible_flag
      comment: "Whether the tier qualifies for room upgrades. Used to assess upgrade benefit distribution across the tier structure."
    - name: "breakfast_benefit_flag"
      expr: breakfast_benefit_flag
      comment: "Whether the tier includes complimentary breakfast. Used to analyze breakfast benefit cost exposure by tier."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the tier became effective. Used to track tier program evolution and version history."
  measures:
    - name: "total_active_tiers"
      expr: COUNT(CASE WHEN tier_status = 'Active' THEN tier_id END)
      comment: "Count of currently active loyalty tiers. Measures the breadth of the tier structure and program complexity."
    - name: "avg_points_earning_multiplier"
      expr: AVG(CAST(points_earning_multiplier AS DOUBLE))
      comment: "Average points earning multiplier across all tiers. Used to benchmark the overall generosity of the earning structure and model liability impact of tier changes."
    - name: "max_points_earning_multiplier"
      expr: MAX(points_earning_multiplier)
      comment: "Maximum points earning multiplier offered at the highest tier. Used to assess the top-tier earning incentive and competitive positioning of the program."
    - name: "avg_qualification_spend_threshold"
      expr: AVG(CAST(qualification_spend_threshold AS DOUBLE))
      comment: "Average spend required to qualify for a tier. Used to evaluate the accessibility of tier qualification and calibrate thresholds against member spending patterns."
    - name: "max_qualification_spend_threshold"
      expr: MAX(qualification_spend_threshold)
      comment: "Maximum spend threshold required for the highest tier qualification. Used to benchmark top-tier exclusivity and competitive positioning."
$$;