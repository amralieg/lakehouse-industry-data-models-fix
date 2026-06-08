-- Metric views for domain: loyalty | Business: Airlines | Version: 1 | Generated on: 2026-05-07 15:08:57

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_ffp_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Frequent Flyer Programme member base health metrics — tracks active membership, miles balances, tier distribution, and engagement signals used by the Loyalty VP to steer acquisition, retention, and tier-upgrade investment decisions."
  source: "`airlines_ecm`.`loyalty`.`ffp_member`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current membership status (Active, Suspended, Cancelled, etc.) — primary segmentation for member health analysis."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the member enrolled (Web, Mobile, Airport, Partner, etc.) — used to evaluate acquisition channel ROI."
    - name: "home_airport_code"
      expr: home_airport_code
      comment: "Member's designated home airport — enables geographic segmentation of the loyalty base."
    - name: "country_code"
      expr: country_code
      comment: "Member's country of residence — supports regional loyalty programme performance reporting."
    - name: "preferred_cabin_class"
      expr: preferred_cabin_class
      comment: "Member's stated preferred cabin class — proxy for revenue tier and upsell potential."
    - name: "gender"
      expr: gender
      comment: "Member gender — used for demographic segmentation in loyalty marketing analytics."
    - name: "lifetime_status_flag"
      expr: lifetime_status_flag
      comment: "Indicates whether the member holds lifetime status — distinguishes highest-value permanent members."
    - name: "enrollment_year"
      expr: DATE_TRUNC('YEAR', enrollment_date)
      comment: "Year of enrolment — used to analyse cohort-level retention and lifetime value trends."
    - name: "tier_expiration_month"
      expr: DATE_TRUNC('MONTH', tier_expiration_date)
      comment: "Month in which the member's tier expires — used to identify at-risk tier members requiring re-engagement."
  measures:
    - name: "total_active_members"
      expr: COUNT(CASE WHEN membership_status = 'Active' THEN ffp_member_id END)
      comment: "Count of members with Active status — the primary loyalty base size KPI tracked by the Loyalty VP."
    - name: "total_members"
      expr: COUNT(1)
      comment: "Total enrolled members regardless of status — baseline for programme penetration and growth rate calculations."
    - name: "total_current_miles_balance"
      expr: SUM(CAST(current_miles_balance AS DOUBLE))
      comment: "Sum of all members' current redeemable miles balances — represents the programme's outstanding liability and is a key financial risk metric."
    - name: "avg_current_miles_balance"
      expr: AVG(CAST(current_miles_balance AS DOUBLE))
      comment: "Average current miles balance per member — indicates typical engagement depth and liability concentration."
    - name: "total_lifetime_miles_balance"
      expr: SUM(CAST(lifetime_miles_balance AS DOUBLE))
      comment: "Sum of lifetime miles earned across all members — measures the cumulative scale of the loyalty programme's value delivery."
    - name: "avg_lifetime_miles_balance"
      expr: AVG(CAST(lifetime_miles_balance AS DOUBLE))
      comment: "Average lifetime miles earned per member — a proxy for long-term member engagement and loyalty depth."
    - name: "total_tier_qualifying_miles"
      expr: SUM(CAST(tier_qualifying_miles AS DOUBLE))
      comment: "Sum of tier-qualifying miles across all members — indicates the aggregate qualifying activity driving tier upgrades."
    - name: "avg_tier_qualifying_miles"
      expr: AVG(CAST(tier_qualifying_miles AS DOUBLE))
      comment: "Average tier-qualifying miles per member — used to benchmark member progress toward tier thresholds."
    - name: "lifetime_status_member_count"
      expr: COUNT(CASE WHEN lifetime_status_flag = TRUE THEN ffp_member_id END)
      comment: "Count of members holding lifetime status — tracks the size of the highest-value, permanently retained member cohort."
    - name: "email_consent_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN email_consent_flag = TRUE THEN ffp_member_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of members who have consented to email marketing — directly governs the reachable audience for loyalty campaigns."
    - name: "members_expiring_tier_next_90_days"
      expr: COUNT(CASE WHEN tier_expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN ffp_member_id END)
      comment: "Members whose tier status expires within 90 days — critical retention signal for proactive re-qualification outreach."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_mileage_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mileage accrual transaction metrics — measures miles earned, bonus multipliers, and accrual quality across flight and partner channels. Used by Loyalty Operations and Finance to monitor programme earn economics and partner settlement accuracy."
  source: "`airlines_ecm`.`loyalty`.`mileage_accrual`"
  dimensions:
    - name: "accrual_source_type"
      expr: accrual_source_type
      comment: "Source of the accrual (Flight, Partner, Promotion, Adjustment, etc.) — primary segmentation for earn channel analysis."
    - name: "accrual_status"
      expr: accrual_status
      comment: "Processing status of the accrual record (Posted, Pending, Reversed, etc.) — used to filter to settled transactions."
    - name: "marketing_carrier_code"
      expr: marketing_carrier_code
      comment: "IATA code of the marketing carrier — enables carrier-level earn analysis for interline and codeshare programmes."
    - name: "operating_carrier_code"
      expr: operating_carrier_code
      comment: "IATA code of the operating carrier — used to reconcile earn against actual flight operations."
    - name: "transaction_currency_code"
      expr: transaction_currency_code
      comment: "Currency of the underlying transaction — required for multi-currency earn rate analysis."
    - name: "accrual_month"
      expr: DATE_TRUNC('MONTH', accrual_date)
      comment: "Month of accrual — standard time grain for monthly earn trend reporting."
    - name: "flight_date_month"
      expr: DATE_TRUNC('MONTH', flight_date)
      comment: "Month of the qualifying flight — used to align earn activity with flight operations calendars."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month miles were posted to the member account — used to track posting lag and settlement timeliness."
  measures:
    - name: "total_miles_credited"
      expr: SUM(CAST(total_miles_credited AS DOUBLE))
      comment: "Total miles credited to member accounts — the primary earn volume KPI representing programme liability growth."
    - name: "total_base_miles"
      expr: SUM(CAST(base_miles AS DOUBLE))
      comment: "Sum of base (non-bonus) miles earned — isolates the core earn component for rate benchmarking."
    - name: "total_elite_bonus_miles"
      expr: SUM(CAST(elite_bonus_miles AS DOUBLE))
      comment: "Sum of elite-tier bonus miles awarded — quantifies the incremental cost of tier benefits on the earn side."
    - name: "total_promotional_bonus_miles"
      expr: SUM(CAST(promotional_bonus_miles AS DOUBLE))
      comment: "Sum of promotional bonus miles awarded — measures the miles cost of running earn promotions."
    - name: "avg_elite_bonus_multiplier"
      expr: AVG(CAST(elite_bonus_multiplier AS DOUBLE))
      comment: "Average elite bonus multiplier applied across accrual transactions — indicates the effective tier uplift being granted."
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Sum of transaction amounts underlying accruals — used to compute effective earn rates and partner settlement values."
    - name: "avg_miles_per_transaction"
      expr: AVG(CAST(total_miles_credited AS DOUBLE))
      comment: "Average miles credited per accrual transaction — a key earn-rate health indicator."
    - name: "accrual_transaction_count"
      expr: COUNT(1)
      comment: "Total number of accrual transactions — baseline volume metric for earn activity monitoring."
    - name: "distinct_earning_members"
      expr: COUNT(DISTINCT ffp_member_id)
      comment: "Number of unique members who earned miles in the period — measures active programme engagement breadth."
    - name: "reversal_transaction_count"
      expr: COUNT(CASE WHEN reversal_date IS NOT NULL THEN mileage_accrual_id END)
      comment: "Count of accrual transactions that were subsequently reversed — a quality and fraud signal for the earn process."
    - name: "bonus_miles_share_pct"
      expr: ROUND(100.0 * SUM(CAST(elite_bonus_miles AS DOUBLE) + CAST(promotional_bonus_miles AS DOUBLE)) / NULLIF(SUM(CAST(total_miles_credited AS DOUBLE)), 0), 2)
      comment: "Percentage of total credited miles that are bonus miles — measures the cost premium of tier and promotional earn above base rates."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_mileage_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mileage redemption transaction metrics — tracks miles burned, redemption types, co-pay economics, and refund activity. Used by Loyalty Finance and Revenue Management to monitor programme burn liability, redemption channel mix, and co-pay revenue."
  source: "`airlines_ecm`.`loyalty`.`mileage_redemption`"
  dimensions:
    - name: "redemption_type"
      expr: redemption_type
      comment: "Type of redemption (Award Flight, Upgrade, Partner, Merchandise, etc.) — primary segmentation for burn channel analysis."
    - name: "redemption_status"
      expr: redemption_status
      comment: "Processing status of the redemption (Completed, Cancelled, Pending, Refunded, etc.) — used to filter to settled transactions."
    - name: "redemption_channel"
      expr: redemption_channel
      comment: "Channel through which the redemption was made (Web, Mobile, Call Centre, Airport, etc.) — informs channel investment decisions."
    - name: "co_pay_currency_code"
      expr: co_pay_currency_code
      comment: "Currency of the co-payment collected — required for multi-currency co-pay revenue reporting."
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of miles transfer associated with the redemption — used to distinguish standard redemptions from transfer-funded burns."
    - name: "redemption_month"
      expr: DATE_TRUNC('MONTH', redemption_timestamp)
      comment: "Month of redemption — standard time grain for monthly burn trend and liability release reporting."
  measures:
    - name: "total_miles_redeemed"
      expr: SUM(CAST(miles_redeemed AS DOUBLE))
      comment: "Total miles burned across all redemption transactions — the primary liability release KPI for the loyalty programme."
    - name: "avg_miles_per_redemption"
      expr: AVG(CAST(miles_redeemed AS DOUBLE))
      comment: "Average miles redeemed per transaction — indicates typical redemption size and award cost efficiency."
    - name: "total_co_pay_amount"
      expr: SUM(CAST(co_pay_amount AS DOUBLE))
      comment: "Total co-payment revenue collected alongside mile redemptions — a direct ancillary revenue stream from the loyalty programme."
    - name: "avg_co_pay_amount"
      expr: AVG(CAST(co_pay_amount AS DOUBLE))
      comment: "Average co-pay amount per redemption — used to benchmark co-pay pricing strategy effectiveness."
    - name: "total_processing_fee_amount"
      expr: SUM(CAST(processing_fee_amount AS DOUBLE))
      comment: "Total processing fees collected on redemptions — ancillary fee revenue stream from the redemption process."
    - name: "total_refund_miles"
      expr: SUM(CAST(refund_miles AS DOUBLE))
      comment: "Total miles refunded back to members — measures the scale of redemption cancellations and their liability re-instatement impact."
    - name: "total_miles_discount_applied"
      expr: SUM(CAST(miles_discount_applied AS DOUBLE))
      comment: "Total miles discounts applied across redemptions — quantifies the cost of promotional redemption discount campaigns."
    - name: "redemption_transaction_count"
      expr: COUNT(1)
      comment: "Total number of redemption transactions — baseline volume metric for burn activity monitoring."
    - name: "distinct_redeeming_members"
      expr: COUNT(DISTINCT ffp_member_id)
      comment: "Number of unique members who redeemed miles in the period — measures active redemption engagement and programme utility."
    - name: "refund_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN refund_miles > 0 THEN mileage_redemption_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of redemption transactions that resulted in a miles refund — a quality and customer satisfaction signal for the redemption process."
    - name: "transfer_fee_revenue"
      expr: SUM(CAST(transfer_fee_amount AS DOUBLE))
      comment: "Total transfer fees collected on miles transfers associated with redemptions — ancillary revenue from the miles transfer product."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_award_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Award booking metrics — measures award seat demand, miles redemption volumes, co-pay economics, cancellation rates, and partner award mix. Used by Revenue Management and Loyalty to optimise award inventory allocation and pricing."
  source: "`airlines_ecm`.`loyalty`.`award_booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the award booking (Confirmed, Cancelled, Waitlisted, Ticketed, etc.) — primary filter for active vs. inactive bookings."
    - name: "award_type"
      expr: award_type
      comment: "Type of award booked (Classic, Saver, Partner, Upgrade, etc.) — used to analyse award product mix and inventory utilisation."
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the award was booked (Web, Mobile, Call Centre, etc.) — informs channel cost and self-service adoption metrics."
    - name: "marketing_carrier_code"
      expr: marketing_carrier_code
      comment: "Marketing carrier for the award flight — used to segment award demand by carrier for interline and partner programme analysis."
    - name: "origin_airport_code"
      expr: origin_airport_code
      comment: "Origin airport of the award booking — enables route-level award demand analysis."
    - name: "destination_airport_code"
      expr: destination_airport_code
      comment: "Destination airport of the award booking — paired with origin to identify highest-demand award routes."
    - name: "is_partner_award"
      expr: is_partner_award
      comment: "Flag indicating whether the award is on a partner carrier — used to segment own-metal vs. partner award redemption volumes."
    - name: "is_round_trip"
      expr: is_round_trip
      comment: "Flag indicating whether the award booking is a round trip — used to analyse trip type mix and average miles per booking."
    - name: "ticketing_status"
      expr: ticketing_status
      comment: "Ticketing status of the award booking — used to track conversion from booking to issued ticket."
    - name: "copay_currency_code"
      expr: copay_currency_code
      comment: "Currency of the co-payment on the award booking — required for multi-currency co-pay revenue reporting."
    - name: "departure_month"
      expr: DATE_TRUNC('MONTH', departure_date)
      comment: "Month of departure — used to analyse award booking demand seasonality and advance booking patterns."
    - name: "booking_month"
      expr: DATE_TRUNC('MONTH', booking_timestamp)
      comment: "Month the award booking was made — standard time grain for booking volume trend reporting."
  measures:
    - name: "total_award_bookings"
      expr: COUNT(1)
      comment: "Total number of award bookings — baseline volume KPI for award seat demand."
    - name: "confirmed_award_bookings"
      expr: COUNT(CASE WHEN booking_status = 'Confirmed' THEN award_booking_id END)
      comment: "Count of confirmed award bookings — the active demand signal used by Revenue Management for inventory planning."
    - name: "total_miles_redeemed"
      expr: SUM(CAST(total_miles_redeemed AS DOUBLE))
      comment: "Total miles redeemed across all award bookings — primary liability release metric for award flight redemptions."
    - name: "avg_miles_per_booking"
      expr: AVG(CAST(total_miles_redeemed AS DOUBLE))
      comment: "Average miles redeemed per award booking — used to benchmark award pricing levels and detect pricing anomalies."
    - name: "total_copay_amount"
      expr: SUM(CAST(copay_amount AS DOUBLE))
      comment: "Total co-payment revenue collected on award bookings — direct ancillary revenue stream from the award product."
    - name: "avg_copay_amount"
      expr: AVG(CAST(copay_amount AS DOUBLE))
      comment: "Average co-pay per award booking — used to evaluate co-pay pricing strategy and revenue optimisation."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN booking_status = 'Cancelled' THEN award_booking_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of award bookings that were cancelled — a key demand quality and inventory efficiency metric."
    - name: "partner_award_share_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_partner_award = TRUE THEN award_booking_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of award bookings on partner carriers — measures partner programme utilisation and interline award demand."
    - name: "total_refund_miles"
      expr: SUM(CAST(refund_miles_amount AS DOUBLE))
      comment: "Total miles refunded due to award booking cancellations — measures the liability re-instatement impact of cancellations."
    - name: "total_refund_fee_miles"
      expr: SUM(CAST(refund_fee_miles AS DOUBLE))
      comment: "Total miles charged as cancellation/refund fees — measures the miles revenue retained from cancellation fee policy."
    - name: "distinct_booking_members"
      expr: COUNT(DISTINCT ffp_member_id)
      comment: "Number of unique members making award bookings — measures the breadth of active award redemption engagement."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_miles_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member miles balance snapshot metrics — tracks total programme liability, expiring miles, pending miles, and qualification progress. Used by Loyalty Finance for liability reporting and by CRM for proactive member engagement campaigns."
  source: "`airlines_ecm`.`loyalty`.`miles_balance`"
  dimensions:
    - name: "balance_status"
      expr: balance_status
      comment: "Status of the miles balance account (Active, Frozen, Expired, etc.) — primary filter for valid liability calculations."
    - name: "balance_calculation_method"
      expr: balance_calculation_method
      comment: "Method used to calculate the balance — used to audit consistency of balance computation across member segments."
    - name: "is_lifetime_status_qualified"
      expr: is_lifetime_status_qualified
      comment: "Flag indicating whether the member has qualified for lifetime status — segments highest-value members in balance analysis."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source system that owns the balance record — used for data reconciliation and system migration tracking."
    - name: "qualifying_spend_currency"
      expr: qualifying_spend_currency
      comment: "Currency of the qualifying spend — required for multi-currency qualification threshold analysis."
    - name: "balance_month"
      expr: DATE_TRUNC('MONTH', balance_as_of_timestamp)
      comment: "Month of the balance snapshot — used to track liability trends over time."
    - name: "next_expiration_month"
      expr: DATE_TRUNC('MONTH', next_expiration_date)
      comment: "Month of the next miles expiration — used to identify cohorts of members with imminent expiry for re-engagement campaigns."
  measures:
    - name: "total_redeemable_miles"
      expr: SUM(CAST(redeemable_miles AS DOUBLE))
      comment: "Sum of all redeemable miles balances across members — the primary loyalty programme liability metric reported to Finance."
    - name: "total_miles_balance"
      expr: SUM(CAST(total_miles_balance AS DOUBLE))
      comment: "Sum of total miles balances (including pending and on-hold) — gross liability figure used in financial provisioning."
    - name: "total_pending_miles"
      expr: SUM(CAST(pending_miles AS DOUBLE))
      comment: "Sum of miles pending posting — measures the pipeline of earn activity not yet settled into member accounts."
    - name: "total_on_hold_miles"
      expr: SUM(CAST(on_hold_miles AS DOUBLE))
      comment: "Sum of miles currently on hold (e.g. fraud review, dispute) — a risk and compliance metric for the loyalty programme."
    - name: "total_miles_expiring_90_days"
      expr: SUM(CAST(miles_expiring_90_days AS DOUBLE))
      comment: "Total miles expiring within 90 days — critical input for proactive member re-engagement campaigns to prevent liability write-off."
    - name: "total_miles_expiring_180_days"
      expr: SUM(CAST(miles_expiring_180_days AS DOUBLE))
      comment: "Total miles expiring within 180 days — medium-term expiry liability used for campaign planning and financial forecasting."
    - name: "total_lifetime_miles_earned"
      expr: SUM(CAST(lifetime_miles_earned AS DOUBLE))
      comment: "Sum of lifetime miles earned across all members — measures the cumulative scale of value delivered by the programme."
    - name: "total_lifetime_miles_redeemed"
      expr: SUM(CAST(lifetime_miles_redeemed AS DOUBLE))
      comment: "Sum of lifetime miles redeemed across all members — measures cumulative liability release over the programme's life."
    - name: "total_qualifying_miles_ytd"
      expr: SUM(CAST(qualifying_miles_ytd AS DOUBLE))
      comment: "Sum of year-to-date qualifying miles across all members — indicates aggregate tier qualification progress for the current year."
    - name: "total_qualifying_spend_ytd"
      expr: SUM(CAST(qualifying_spend_ytd AS DOUBLE))
      comment: "Sum of year-to-date qualifying spend across all members — measures the revenue-generating activity driving tier qualification."
    - name: "avg_redeemable_miles_per_member"
      expr: AVG(CAST(redeemable_miles AS DOUBLE))
      comment: "Average redeemable miles balance per member — indicates typical member engagement depth and per-member liability."
    - name: "total_partner_miles_balance"
      expr: SUM(CAST(partner_miles_balance AS DOUBLE))
      comment: "Sum of miles earned through partner programmes — measures the contribution of partner earn channels to total programme liability."
    - name: "total_bonus_miles_balance"
      expr: SUM(CAST(bonus_miles_balance AS DOUBLE))
      comment: "Sum of bonus miles balances — isolates the liability attributable to promotional and tier bonus earn activity."
    - name: "lifetime_status_qualified_members"
      expr: COUNT(CASE WHEN is_lifetime_status_qualified = TRUE THEN miles_balance_id END)
      comment: "Count of members who have qualified for lifetime status — tracks the size of the permanently retained highest-value member cohort."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_tier_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tier qualification metrics — tracks member progress toward elite tier thresholds, tier upgrade rates, challenge completions, and status match outcomes. Used by Loyalty Strategy to manage tier economics and competitive status match programmes."
  source: "`airlines_ecm`.`loyalty`.`tier_qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Status of the tier qualification record (Qualified, In Progress, Failed, Challenged, etc.) — primary segmentation for qualification funnel analysis."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (Standard, Challenge, Status Match, Lifetime, etc.) — used to analyse the mix of qualification pathways."
    - name: "tier_achieved"
      expr: tier_achieved
      comment: "Tier level achieved by the member — used to track tier upgrade distribution and programme tier economics."
    - name: "qualification_year"
      expr: qualification_year
      comment: "Programme year in which the qualification applies — used for year-over-year tier qualification trend analysis."
    - name: "extension_granted_flag"
      expr: extension_granted_flag
      comment: "Flag indicating whether a tier extension was granted — measures the scale of discretionary tier retention interventions."
    - name: "match_outcome"
      expr: match_outcome
      comment: "Outcome of a status match request (Approved, Denied, Pending) — used to evaluate status match programme conversion rates."
    - name: "qualifying_spend_currency"
      expr: qualifying_spend_currency
      comment: "Currency of the qualifying spend — required for multi-currency spend threshold analysis."
    - name: "tier_effective_month"
      expr: DATE_TRUNC('MONTH', tier_effective_date)
      comment: "Month the tier became effective — used to track tier upgrade timing and seasonality."
  measures:
    - name: "total_qualifications"
      expr: COUNT(1)
      comment: "Total tier qualification records — baseline volume metric for qualification activity."
    - name: "successful_qualifications"
      expr: COUNT(CASE WHEN qualification_status = 'Qualified' THEN tier_qualification_id END)
      comment: "Count of members who successfully achieved a tier — the primary tier upgrade volume KPI."
    - name: "qualification_success_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN qualification_status = 'Qualified' THEN tier_qualification_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of qualification attempts that resulted in a successful tier achievement — measures programme tier attainability."
    - name: "total_qualifying_miles_earned"
      expr: SUM(CAST(qualifying_miles_earned AS DOUBLE))
      comment: "Sum of qualifying miles earned across all qualification records — measures the aggregate flying activity driving tier upgrades."
    - name: "avg_qualifying_miles_earned"
      expr: AVG(CAST(qualifying_miles_earned AS DOUBLE))
      comment: "Average qualifying miles earned per qualification record — benchmarks member effort against tier thresholds."
    - name: "total_qualifying_spend_amount"
      expr: SUM(CAST(qualifying_spend_amount AS DOUBLE))
      comment: "Sum of qualifying spend across all qualification records — measures the revenue-generating activity associated with tier upgrades."
    - name: "avg_qualifying_spend_amount"
      expr: AVG(CAST(qualifying_spend_amount AS DOUBLE))
      comment: "Average qualifying spend per qualification record — used to benchmark spend-based tier threshold calibration."
    - name: "total_rollover_miles"
      expr: SUM(CAST(rollover_miles AS DOUBLE))
      comment: "Sum of rollover miles carried forward into the next qualification year — measures the head-start benefit granted to re-qualifying members."
    - name: "extension_granted_count"
      expr: COUNT(CASE WHEN extension_granted_flag = TRUE THEN tier_qualification_id END)
      comment: "Count of tier extensions granted — measures the scale of discretionary retention interventions and their cost to the programme."
    - name: "status_match_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN qualification_type = 'Status Match' AND match_outcome = 'Approved' THEN tier_qualification_id END) / NULLIF(COUNT(CASE WHEN qualification_type = 'Status Match' THEN tier_qualification_id END), 0), 2)
      comment: "Percentage of status match requests that were approved — measures the competitiveness and conversion rate of the status match programme."
    - name: "distinct_qualifying_members"
      expr: COUNT(DISTINCT ffp_member_id)
      comment: "Number of unique members with a tier qualification record — measures the breadth of the active tier-seeking member base."
    - name: "avg_tier_threshold_miles"
      expr: AVG(CAST(tier_threshold_miles AS DOUBLE))
      comment: "Average tier miles threshold across qualification records — used to monitor tier threshold calibration relative to member earning patterns."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_promotion_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion enrolment and completion metrics — tracks opt-in volumes, completion rates, bonus miles earned, and qualification progress across loyalty promotions. Used by Loyalty Marketing to evaluate campaign effectiveness and ROI."
  source: "`airlines_ecm`.`loyalty`.`promotion_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the promotion enrolment (Active, Completed, Cancelled, Expired, etc.) — primary segmentation for campaign funnel analysis."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the member enrolled in the promotion (Email, App, Web, etc.) — used to evaluate campaign channel effectiveness."
    - name: "auto_enrolled_flag"
      expr: auto_enrolled_flag
      comment: "Flag indicating whether the member was auto-enrolled vs. opted in — used to compare engagement quality between enrolment methods."
    - name: "partner_promotion_flag"
      expr: partner_promotion_flag
      comment: "Flag indicating whether the promotion is a partner promotion — used to segment own-programme vs. partner campaign performance."
    - name: "bonus_posting_status"
      expr: bonus_posting_status
      comment: "Status of the bonus miles posting (Posted, Pending, Failed, etc.) — used to track bonus fulfilment quality and delays."
    - name: "qualification_criteria_type"
      expr: qualification_criteria_type
      comment: "Type of qualification criteria for the promotion (Miles, Segments, Spend, etc.) — used to analyse which criteria types drive higher completion rates."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrolment — standard time grain for campaign enrolment trend reporting."
    - name: "promotion_start_month"
      expr: DATE_TRUNC('MONTH', promotion_start_date)
      comment: "Month the promotion started — used to align enrolment and completion metrics with campaign launch timing."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total promotion enrolments — baseline volume KPI for campaign reach measurement."
    - name: "distinct_enrolled_members"
      expr: COUNT(DISTINCT ffp_member_id)
      comment: "Number of unique members enrolled in promotions — measures the breadth of campaign audience engagement."
    - name: "completed_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'Completed' THEN promotion_enrollment_id END)
      comment: "Count of enrolments where the member completed the promotion — the primary campaign conversion KPI."
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN enrollment_status = 'Completed' THEN promotion_enrollment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrolments that resulted in promotion completion — the headline campaign effectiveness metric used in marketing reviews."
    - name: "total_bonus_miles_earned"
      expr: SUM(CAST(bonus_miles_earned AS DOUBLE))
      comment: "Total bonus miles awarded through promotions — measures the miles cost of running the promotion portfolio."
    - name: "avg_bonus_miles_per_enrollment"
      expr: AVG(CAST(bonus_miles_earned AS DOUBLE))
      comment: "Average bonus miles earned per enrolment — used to benchmark promotion generosity and cost per engaged member."
    - name: "avg_qualification_percentage"
      expr: AVG(CAST(qualification_percentage AS DOUBLE))
      comment: "Average qualification progress percentage across active enrolments — measures how close the enrolled member base is to completing promotions."
    - name: "avg_tier_bonus_multiplier"
      expr: AVG(CAST(tier_bonus_multiplier AS DOUBLE))
      comment: "Average tier bonus multiplier applied across enrolments — indicates the effective tier uplift being granted through promotions."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN enrollment_status = 'Cancelled' THEN promotion_enrollment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrolments that were cancelled — a campaign quality and member satisfaction signal."
    - name: "opt_in_consent_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN opt_in_consent_flag = TRUE THEN promotion_enrollment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrolments with explicit opt-in consent — a compliance and data governance metric for marketing programmes."
    - name: "distinct_promotions_active"
      expr: COUNT(DISTINCT promotion_id)
      comment: "Number of distinct promotions with at least one enrolment in the period — measures the breadth of the active promotion portfolio."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_partner_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner earn transaction metrics — tracks miles awarded through partner channels, settlement amounts, dispute rates, and posting quality. Used by Loyalty Partnerships and Finance to manage partner programme economics and settlement accuracy."
  source: "`airlines_ecm`.`loyalty`.`partner_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of partner transaction (Earn, Reversal, Adjustment, etc.) — primary segmentation for partner activity analysis."
    - name: "posting_status"
      expr: posting_status
      comment: "Status of the miles posting (Posted, Pending, Failed, Reversed, etc.) — used to monitor partner posting quality and delays."
    - name: "partner_category"
      expr: partner_category
      comment: "Category of the partner (Hotel, Car Rental, Retail, Financial, etc.) — used to analyse earn contribution by partner vertical."
    - name: "partner_location_country_code"
      expr: partner_location_country_code
      comment: "Country of the partner transaction location — enables geographic analysis of partner earn activity."
    - name: "settlement_currency_code"
      expr: settlement_currency_code
      comment: "Currency of the partner settlement — required for multi-currency settlement reconciliation."
    - name: "transaction_currency_code"
      expr: transaction_currency_code
      comment: "Currency of the underlying partner transaction — used for FX analysis and earn rate validation."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of the settlement reconciliation (Reconciled, Unreconciled, Disputed, etc.) — used to track financial close quality."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of the partner transaction — standard time grain for monthly partner earn trend reporting."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month miles were posted — used to measure posting lag between transaction and credit."
  measures:
    - name: "total_partner_transactions"
      expr: COUNT(1)
      comment: "Total partner earn transactions — baseline volume metric for partner programme activity."
    - name: "distinct_earning_members"
      expr: COUNT(DISTINCT ffp_member_id)
      comment: "Number of unique members earning miles through partner channels — measures partner programme engagement breadth."
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Sum of partner transaction amounts — measures the total spend value flowing through partner earn channels."
    - name: "avg_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average partner transaction amount — used to benchmark partner earn activity value and detect anomalies."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Sum of settlement amounts owed by partners — the primary financial metric for partner programme revenue to the airline."
    - name: "avg_earn_rate_multiplier"
      expr: AVG(CAST(earn_rate_multiplier AS DOUBLE))
      comment: "Average earn rate multiplier applied across partner transactions — used to monitor effective earn rates vs. contracted rates."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN partner_transaction_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partner transactions flagged as disputed — a key partner relationship health and settlement quality metric."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_flag = TRUE THEN partner_transaction_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partner transactions that were reversed — measures data quality and fraud risk in the partner earn channel."
    - name: "unreconciled_transaction_count"
      expr: COUNT(CASE WHEN reconciliation_status != 'Reconciled' THEN partner_transaction_id END)
      comment: "Count of partner transactions not yet reconciled — a financial close risk metric monitored by Loyalty Finance."
    - name: "distinct_active_partners"
      expr: COUNT(DISTINCT partner_program_id)
      comment: "Number of distinct partner programmes with transactions in the period — measures the active breadth of the partner earn network."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_miles_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Miles transfer metrics — tracks transfer volumes, fees, fraud risk, and limit utilisation across member-to-member miles transfers. Used by Loyalty Operations and Fraud teams to manage transfer product economics and risk."
  source: "`airlines_ecm`.`loyalty`.`miles_transfer`"
  dimensions:
    - name: "transfer_status"
      expr: transfer_status
      comment: "Status of the miles transfer (Completed, Pending, Reversed, Rejected, etc.) — primary segmentation for transfer activity analysis."
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of miles transfer (Gift, Purchase, Family Pool, etc.) — used to analyse transfer product mix and economics."
    - name: "transfer_channel"
      expr: transfer_channel
      comment: "Channel through which the transfer was initiated (Web, Mobile, Call Centre, etc.) — informs channel cost and self-service adoption."
    - name: "relationship_type"
      expr: relationship_type
      comment: "Relationship between sender and recipient (Family, Friend, Corporate, etc.) — used to analyse transfer patterns and fraud risk."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for transfer fees (Credit Card, Debit, Miles, etc.) — used to analyse fee collection channel mix."
    - name: "transfer_fee_currency_code"
      expr: transfer_fee_currency_code
      comment: "Currency of the transfer fee — required for multi-currency fee revenue reporting."
    - name: "fraud_review_flag"
      expr: fraud_review_flag
      comment: "Flag indicating whether the transfer was flagged for fraud review — used to segment high-risk transfer activity."
    - name: "transfer_month"
      expr: DATE_TRUNC('MONTH', transfer_timestamp)
      comment: "Month of the transfer — standard time grain for monthly transfer volume and fee revenue trend reporting."
  measures:
    - name: "total_miles_transferred"
      expr: SUM(CAST(miles_transferred AS DOUBLE))
      comment: "Total miles transferred between members — primary volume metric for the miles transfer product."
    - name: "avg_miles_per_transfer"
      expr: AVG(CAST(miles_transferred AS DOUBLE))
      comment: "Average miles transferred per transaction — used to benchmark typical transfer size and detect anomalous large transfers."
    - name: "total_transfer_fee_revenue"
      expr: SUM(CAST(transfer_fee_amount AS DOUBLE))
      comment: "Total transfer fee revenue collected — direct ancillary revenue stream from the miles transfer product."
    - name: "avg_transfer_fee_amount"
      expr: AVG(CAST(transfer_fee_amount AS DOUBLE))
      comment: "Average transfer fee per transaction — used to evaluate transfer fee pricing strategy effectiveness."
    - name: "total_bonus_miles_awarded"
      expr: SUM(CAST(bonus_miles_awarded AS DOUBLE))
      comment: "Total bonus miles awarded on transfers (e.g. promotional transfer bonuses) — measures the miles cost of transfer promotions."
    - name: "total_fee_discount_applied"
      expr: SUM(CAST(fee_discount_applied AS DOUBLE))
      comment: "Total fee discounts applied on transfers — measures the revenue foregone through transfer fee promotions."
    - name: "fraud_flagged_transfer_count"
      expr: COUNT(CASE WHEN fraud_review_flag = TRUE THEN miles_transfer_id END)
      comment: "Count of transfers flagged for fraud review — a key risk metric for the Fraud and Loyalty Operations teams."
    - name: "fraud_flag_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fraud_review_flag = TRUE THEN miles_transfer_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transfers flagged for fraud review — measures the fraud risk concentration in the transfer product."
    - name: "avg_fraud_risk_score"
      expr: AVG(CAST(fraud_risk_score AS DOUBLE))
      comment: "Average fraud risk score across transfer transactions — used to monitor the overall risk profile of the transfer product."
    - name: "transfer_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN transfer_status = 'Completed' THEN miles_transfer_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of initiated transfers that completed successfully — measures transfer product reliability and operational quality."
    - name: "total_transfer_transactions"
      expr: COUNT(1)
      comment: "Total miles transfer transactions — baseline volume metric for transfer product activity monitoring."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`loyalty_upgrade_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Upgrade request metrics — tracks upgrade clearance rates, miles deducted, co-pay economics, waitlist dynamics, and priority scoring. Used by Revenue Management and Loyalty to optimise upgrade inventory allocation and member tier benefit delivery."
  source: "`airlines_ecm`.`loyalty`.`upgrade_request`"
  dimensions:
    - name: "upgrade_status"
      expr: upgrade_status
      comment: "Current status of the upgrade request (Cleared, Waitlisted, Denied, Cancelled, etc.) — primary segmentation for upgrade funnel analysis."
    - name: "request_type"
      expr: request_type
      comment: "Type of upgrade request (Miles, Complimentary, Bid, Operational, etc.) — used to analyse upgrade product mix and economics."
    - name: "request_channel"
      expr: request_channel
      comment: "Channel through which the upgrade was requested (Web, Mobile, Airport, Call Centre, etc.) — informs channel cost and self-service adoption."
    - name: "requested_cabin_class"
      expr: requested_cabin_class
      comment: "Cabin class requested for the upgrade — used to analyse upgrade demand by cabin and inventory allocation effectiveness."
    - name: "origin_airport_code"
      expr: origin_airport_code
      comment: "Origin airport of the upgrade request — enables route-level upgrade demand analysis."
    - name: "destination_airport_code"
      expr: destination_airport_code
      comment: "Destination airport of the upgrade request — paired with origin to identify highest-demand upgrade routes."
    - name: "co_pay_currency_code"
      expr: co_pay_currency_code
      comment: "Currency of the co-payment on the upgrade — required for multi-currency co-pay revenue reporting."
    - name: "companion_upgrade_flag"
      expr: companion_upgrade_flag
      comment: "Flag indicating whether the upgrade includes a companion — used to analyse companion upgrade benefit utilisation."
    - name: "travel_month"
      expr: DATE_TRUNC('MONTH', travel_date)
      comment: "Month of travel — used to analyse upgrade demand seasonality and advance request patterns."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month the upgrade was requested — standard time grain for upgrade request volume trend reporting."
  measures:
    - name: "total_upgrade_requests"
      expr: COUNT(1)
      comment: "Total upgrade requests submitted — baseline volume metric for upgrade demand monitoring."
    - name: "cleared_upgrade_count"
      expr: COUNT(CASE WHEN upgrade_status = 'Cleared' THEN upgrade_request_id END)
      comment: "Count of upgrade requests that were successfully cleared — the primary upgrade fulfilment KPI."
    - name: "upgrade_clearance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN upgrade_status = 'Cleared' THEN upgrade_request_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of upgrade requests that were cleared — the headline upgrade inventory utilisation metric used in Revenue Management reviews."
    - name: "total_miles_deducted"
      expr: SUM(CAST(miles_deducted AS DOUBLE))
      comment: "Total miles deducted for upgrade redemptions — measures the miles liability released through the upgrade product."
    - name: "avg_miles_per_upgrade"
      expr: AVG(CAST(miles_deducted AS DOUBLE))
      comment: "Average miles deducted per upgrade request — used to benchmark upgrade pricing levels and detect pricing anomalies."
    - name: "total_co_pay_amount"
      expr: SUM(CAST(co_pay_amount AS DOUBLE))
      comment: "Total co-payment revenue collected on upgrade requests — direct ancillary revenue stream from the upgrade product."
    - name: "avg_co_pay_amount"
      expr: AVG(CAST(co_pay_amount AS DOUBLE))
      comment: "Average co-pay per upgrade request — used to evaluate upgrade co-pay pricing strategy effectiveness."
    - name: "avg_upgrade_priority_score"
      expr: AVG(CAST(upgrade_priority_score AS DOUBLE))
      comment: "Average upgrade priority score across requests — used to monitor the effectiveness of the priority scoring algorithm in clearing high-value members."
    - name: "waitlisted_upgrade_count"
      expr: COUNT(CASE WHEN upgrade_status = 'Waitlisted' THEN upgrade_request_id END)
      comment: "Count of upgrade requests currently on the waitlist — measures unmet upgrade demand and inventory shortfall."
    - name: "denial_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN upgrade_status = 'Denied' THEN upgrade_request_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of upgrade requests that were denied — a member experience and inventory adequacy metric."
    - name: "distinct_requesting_members"
      expr: COUNT(DISTINCT ffp_member_id)
      comment: "Number of unique members submitting upgrade requests — measures the breadth of upgrade benefit utilisation across the member base."
$$;