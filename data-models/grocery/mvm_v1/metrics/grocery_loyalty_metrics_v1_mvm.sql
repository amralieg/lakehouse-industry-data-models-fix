-- Metric views for domain: loyalty | Business: Grocery | Version: 1 | Generated on: 2026-05-04 20:38:05

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`loyalty_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core loyalty membership KPIs tracking enrollment health, engagement, tier distribution, points economics, and lifetime value. Primary steering view for the loyalty program P&L and member lifecycle management."
  source: "`grocery_ecm`.`loyalty`.`membership`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current status of the loyalty membership (e.g., Active, Suspended, Cancelled). Used to segment active vs. churned member populations."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the member enrolled (e.g., In-Store, Online, Mobile App). Drives channel attribution for acquisition cost analysis."
    - name: "tier_name"
      expr: cltv_classification
      comment: "Customer lifetime value classification assigned to the membership (e.g., High, Medium, Low). Used to segment members by predicted long-term value."
    - name: "gamification_level"
      expr: gamification_level
      comment: "Current gamification level of the member. Indicates engagement depth with loyalty program game mechanics."
    - name: "digital_wallet_linked"
      expr: digital_wallet_linked_flag
      comment: "Whether the member has linked a digital wallet. Proxy for digital engagement and omnichannel adoption."
    - name: "email_opt_in"
      expr: email_opt_in_flag
      comment: "Whether the member has opted into email communications. Key dimension for marketing reachability analysis."
    - name: "sms_opt_in"
      expr: sms_opt_in_flag
      comment: "Whether the member has opted into SMS communications. Supports channel preference segmentation."
    - name: "primary_household_member"
      expr: primary_household_member_flag
      comment: "Indicates if this membership belongs to the primary household member. Used to distinguish primary vs. secondary member economics."
    - name: "referral_source"
      expr: referral_source
      comment: "Source that referred the member to the loyalty program. Enables referral channel ROI analysis."
    - name: "enrollment_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of enrollment, truncated for cohort analysis. Enables monthly enrollment trend and cohort retention reporting."
    - name: "last_activity_month"
      expr: DATE_TRUNC('month', last_activity_date)
      comment: "Month of last recorded activity. Used to identify recency cohorts and flag at-risk members."
    - name: "push_notification_opt_in"
      expr: push_notification_opt_in_flag
      comment: "Whether the member has opted into push notifications. Supports mobile engagement channel analysis."
  measures:
    - name: "total_active_memberships"
      expr: COUNT(CASE WHEN membership_status = 'Active' THEN membership_id END)
      comment: "Count of currently active loyalty memberships. Primary KPI for program scale and health; a decline signals churn risk requiring immediate intervention."
    - name: "total_memberships"
      expr: COUNT(membership_id)
      comment: "Total count of all loyalty memberships regardless of status. Baseline for calculating activation and churn rates."
    - name: "total_lifetime_points_earned"
      expr: SUM(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Sum of all lifetime points earned across memberships. Reflects total program engagement volume and liability accrual."
    - name: "total_lifetime_points_redeemed"
      expr: SUM(CAST(lifetime_points_redeemed AS DOUBLE))
      comment: "Sum of all lifetime points redeemed across memberships. Measures program utilization and redemption liability drawdown."
    - name: "total_points_balance"
      expr: SUM(CAST(points_balance AS DOUBLE))
      comment: "Total outstanding points balance across all memberships. Represents the unredeemed loyalty liability on the balance sheet."
    - name: "total_points_expiring_soon"
      expr: SUM(CAST(points_expiring_soon AS DOUBLE))
      comment: "Total points at risk of expiring in the near term. Drives urgency-based re-engagement campaigns to prevent breakage and member dissatisfaction."
    - name: "total_annual_spend_amount"
      expr: SUM(CAST(annual_spend_amount AS DOUBLE))
      comment: "Total annual spend across all loyalty members. Core revenue attribution metric for the loyalty program; directly tied to program ROI."
    - name: "avg_annual_spend_per_member"
      expr: AVG(CAST(annual_spend_amount AS DOUBLE))
      comment: "Average annual spend per loyalty member. Benchmark for member value; used to identify tier thresholds and reward investment levels."
    - name: "avg_points_balance_per_member"
      expr: AVG(CAST(points_balance AS DOUBLE))
      comment: "Average outstanding points balance per membership. Indicates typical member engagement depth and unredeemed value per account."
    - name: "points_redemption_rate"
      expr: ROUND(100.0 * SUM(CAST(lifetime_points_redeemed AS DOUBLE)) / NULLIF(SUM(CAST(lifetime_points_earned AS DOUBLE)), 0), 2)
      comment: "Percentage of lifetime earned points that have been redeemed. Key program health ratio — too low signals disengagement; too high signals over-redemption risk."
    - name: "digital_wallet_adoption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN digital_wallet_linked_flag = TRUE THEN membership_id END) / NULLIF(COUNT(CASE WHEN membership_status = 'Active' THEN membership_id END), 0), 2)
      comment: "Percentage of active members with a linked digital wallet. Measures omnichannel adoption; higher rates correlate with increased visit frequency and spend."
    - name: "email_opt_in_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN email_opt_in_flag = TRUE THEN membership_id END) / NULLIF(COUNT(CASE WHEN membership_status = 'Active' THEN membership_id END), 0), 2)
      comment: "Percentage of active members opted into email. Determines the reachable audience for email-driven loyalty campaigns and promotions."
    - name: "nps_eligible_member_count"
      expr: COUNT(CASE WHEN nps_survey_date IS NOT NULL THEN membership_id END)
      comment: "Count of members who have received an NPS survey. Baseline for calculating response rates and ensuring survey coverage targets are met."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`loyalty_points_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular points economy KPIs tracking earn and redemption activity, fuel discount utilization, reversal rates, and channel-level engagement. Used by loyalty finance and operations to manage points liability and program economics."
  source: "`grocery_ecm`.`loyalty`.`points_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of points transaction (e.g., Earn, Redeem, Adjust, Expire). Primary dimension for segmenting points economy flows."
    - name: "redemption_type"
      expr: redemption_type
      comment: "Type of redemption applied (e.g., Fuel, Grocery, Gift Card). Enables redemption mix analysis to optimize reward catalog."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the points transaction originated (e.g., In-Store, Online, Mobile). Supports omnichannel points economy analysis."
    - name: "redemption_method"
      expr: redemption_method
      comment: "Method used to redeem points (e.g., Card Swipe, App, Coupon). Informs UX investment priorities for redemption friction reduction."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code associated with the points transaction. Used to audit adjustments, reversals, and exception handling."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether this transaction is a reversal of a prior transaction. Used to calculate net points economy and identify reversal hotspots."
    - name: "breakage_eligible"
      expr: breakage_eligible_flag
      comment: "Whether the points in this transaction are eligible for breakage accounting. Critical for financial liability estimation."
    - name: "transaction_month"
      expr: DATE_TRUNC('month', transaction_timestamp)
      comment: "Month of the points transaction, truncated for trend analysis. Enables monthly earn/redeem volume reporting."
    - name: "expiration_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month in which the points are set to expire. Used to forecast upcoming breakage and plan re-engagement campaigns."
    - name: "source_system"
      expr: source_system
      comment: "Source system that originated the transaction. Supports data lineage auditing and reconciliation across POS, e-commerce, and pharmacy systems."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment status of the points transaction. Used to identify pending or failed points postings that require operational resolution."
  measures:
    - name: "total_points_earned"
      expr: SUM(CASE WHEN transaction_type = 'Earn' AND (reversal_flag = FALSE OR reversal_flag IS NULL) THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total points earned (net of reversals) across all transactions. Core measure of program engagement volume and liability accrual rate."
    - name: "total_points_redeemed"
      expr: SUM(CASE WHEN transaction_type = 'Redeem' AND (reversal_flag = FALSE OR reversal_flag IS NULL) THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total points redeemed (net of reversals). Measures liability drawdown and program utilization; directly tied to redemption cost."
    - name: "total_points_adjusted"
      expr: SUM(CASE WHEN transaction_type = 'Adjust' THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total points adjusted via manual or system corrections. High adjustment volumes signal operational issues or fraud risk requiring investigation."
    - name: "total_fuel_discount_amount"
      expr: SUM(CAST(fuel_discount_amount AS DOUBLE))
      comment: "Total fuel discount value dispensed through loyalty points redemptions. Measures the fuel reward program's financial impact and member utilization."
    - name: "total_gallons_dispensed"
      expr: SUM(CAST(gallons_dispensed AS DOUBLE))
      comment: "Total fuel gallons dispensed via loyalty redemptions. Operational KPI for fuel center capacity planning and vendor negotiations."
    - name: "avg_fuel_discount_per_gallon"
      expr: ROUND(SUM(CAST(fuel_discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gallons_dispensed AS DOUBLE)), 0), 4)
      comment: "Average fuel discount per gallon dispensed through loyalty. Benchmarks against program configuration caps to detect over-redemption or configuration drift."
    - name: "total_tax_impact_amount"
      expr: SUM(CAST(tax_impact_amount AS DOUBLE))
      comment: "Total tax impact associated with points transactions. Required for financial reporting and regulatory compliance on loyalty liability."
    - name: "reversal_transaction_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN points_transaction_id END)
      comment: "Count of reversed points transactions. Elevated reversal rates indicate POS integration issues, fraud, or member dispute volumes."
    - name: "reversal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_flag = TRUE THEN points_transaction_id END) / NULLIF(COUNT(points_transaction_id), 0), 2)
      comment: "Percentage of all points transactions that are reversals. Key quality metric; high rates trigger operational and fraud investigations."
    - name: "avg_points_per_transaction"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average points amount per transaction record. Tracks earn/redeem intensity per event; declining averages may signal reduced basket sizes or offer degradation."
    - name: "distinct_active_members"
      expr: COUNT(DISTINCT membership_id)
      comment: "Count of distinct members with at least one points transaction in the period. Measures active program participation breadth."
    - name: "breakage_eligible_points"
      expr: SUM(CASE WHEN breakage_eligible_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total points eligible for breakage accounting. Directly informs the loyalty liability reserve on the balance sheet; critical for finance close."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`loyalty_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Redemption event KPIs measuring value delivered to members, channel mix, fuel utilization, and redemption quality. Used by loyalty marketing and finance to optimize reward catalog ROI and member satisfaction."
  source: "`grocery_ecm`.`loyalty`.`loyalty_redemption`"
  dimensions:
    - name: "redemption_type"
      expr: redemption_type
      comment: "Type of reward redeemed (e.g., Fuel Discount, Gift Card, Grocery Discount). Primary dimension for reward catalog mix analysis."
    - name: "channel"
      expr: channel
      comment: "Channel through which the redemption occurred (e.g., In-Store, Online, Mobile). Enables omnichannel redemption experience analysis."
    - name: "redemption_source"
      expr: redemption_source
      comment: "Source system or touchpoint that initiated the redemption. Used for attribution and integration quality monitoring."
    - name: "tier_at_redemption"
      expr: tier_at_redemption
      comment: "Loyalty tier of the member at the time of redemption. Enables tier-level redemption value and behavior analysis."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Status of the redemption fulfillment (e.g., Fulfilled, Pending, Failed). Operational quality dimension for redemption success rate monitoring."
    - name: "device_type"
      expr: device_type
      comment: "Device type used for the redemption (e.g., Mobile, Desktop, POS Terminal). Informs digital experience investment priorities."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the redemption value was denominated. Required for multi-currency financial reporting."
    - name: "gamification_event"
      expr: gamification_event_flag
      comment: "Whether this redemption triggered a gamification event. Measures gamification mechanic engagement and its correlation with redemption behavior."
    - name: "redemption_month"
      expr: DATE_TRUNC('month', redemption_timestamp)
      comment: "Month of the redemption event, truncated for trend analysis. Enables monthly redemption volume and value trend reporting."
    - name: "expiration_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month the redeemed offer or points were set to expire. Used to analyze urgency-driven redemption patterns near expiry."
  measures:
    - name: "total_redemption_events"
      expr: COUNT(loyalty_redemption_id)
      comment: "Total count of redemption events. Baseline volume KPI for program utilization; declining counts signal disengagement or offer relevance issues."
    - name: "distinct_redeeming_members"
      expr: COUNT(DISTINCT membership_id)
      comment: "Count of distinct members who redeemed in the period. Measures redemption breadth; low penetration relative to active members signals offer awareness gaps."
    - name: "total_points_redeemed"
      expr: SUM(CAST(points_redeemed AS DOUBLE))
      comment: "Total points redeemed across all redemption events. Measures liability drawdown velocity and program engagement intensity."
    - name: "total_redemption_value"
      expr: SUM(CAST(value_amount AS DOUBLE))
      comment: "Total monetary value delivered to members through redemptions. Core program cost metric; directly tied to loyalty P&L and ROI calculations."
    - name: "avg_redemption_value"
      expr: AVG(CAST(value_amount AS DOUBLE))
      comment: "Average monetary value per redemption event. Benchmarks reward generosity; used to calibrate offer value against member satisfaction scores."
    - name: "total_basket_savings"
      expr: SUM(CAST(basket_total_amount AS DOUBLE) - CAST(basket_total_after_redemption AS DOUBLE))
      comment: "Total basket savings delivered to members (pre- minus post-redemption basket value). Measures the tangible financial benefit members receive, driving program perceived value."
    - name: "avg_basket_savings_per_redemption"
      expr: AVG(CAST(basket_total_amount AS DOUBLE) - CAST(basket_total_after_redemption AS DOUBLE))
      comment: "Average basket savings per redemption event. Key member value perception metric; used in member satisfaction and NPS correlation analysis."
    - name: "total_fuel_discount_per_gallon"
      expr: SUM(CAST(fuel_discount_per_gallon AS DOUBLE))
      comment: "Sum of fuel discount rates applied across all fuel redemption events. Used with gallons purchased to calculate total fuel reward cost."
    - name: "total_fuel_gallons_purchased"
      expr: SUM(CAST(fuel_gallons_purchased AS DOUBLE))
      comment: "Total fuel gallons purchased using loyalty fuel rewards. Measures fuel center traffic driven by the loyalty program."
    - name: "avg_points_balance_before_redemption"
      expr: AVG(CAST(points_balance_before AS DOUBLE))
      comment: "Average points balance members held before redeeming. Indicates the typical accumulation threshold before redemption behavior triggers."
    - name: "fulfilled_redemption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fulfillment_status = 'Fulfilled' THEN loyalty_redemption_id END) / NULLIF(COUNT(loyalty_redemption_id), 0), 2)
      comment: "Percentage of redemption events successfully fulfilled. Operational quality KPI; low rates indicate system failures or fraud blocks degrading member experience."
    - name: "gamification_redemption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gamification_event_flag = TRUE THEN loyalty_redemption_id END) / NULLIF(COUNT(loyalty_redemption_id), 0), 2)
      comment: "Percentage of redemptions that triggered a gamification event. Measures gamification mechanic penetration within the redemption journey."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`loyalty_member_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Personalized offer performance KPIs measuring assignment, activation, redemption, and personalization effectiveness. Used by loyalty marketing to optimize offer targeting, activation rates, and incremental revenue from personalized promotions."
  source: "`grocery_ecm`.`loyalty`.`member_offer`"
  dimensions:
    - name: "member_offer_status"
      expr: member_offer_status
      comment: "Current status of the member offer (e.g., Assigned, Activated, Redeemed, Expired, Revoked). Primary lifecycle dimension for offer funnel analysis."
    - name: "activation_channel"
      expr: activation_channel
      comment: "Channel through which the offer was activated (e.g., App, Web, In-Store). Drives channel investment decisions for offer activation UX."
    - name: "assignment_channel"
      expr: assignment_channel
      comment: "Channel through which the offer was assigned to the member. Enables attribution of offer assignment to marketing touchpoints."
    - name: "assignment_source"
      expr: assignment_source
      comment: "Source system or campaign that assigned the offer. Used to evaluate which assignment engines (personalization, batch, manual) drive the best outcomes."
    - name: "targeting_segment"
      expr: targeting_segment
      comment: "Customer segment targeted by this offer. Enables segment-level offer performance comparison to optimize targeting strategy."
    - name: "notification_channel"
      expr: notification_channel
      comment: "Channel used to notify the member of the offer (e.g., Email, SMS, Push). Measures notification channel effectiveness on activation rates."
    - name: "auto_apply"
      expr: auto_apply_flag
      comment: "Whether the offer is automatically applied without member activation. Used to compare auto-apply vs. clip-and-redeem offer performance."
    - name: "stackable"
      expr: stackable_flag
      comment: "Whether the offer can be stacked with other offers. Enables analysis of stacking behavior and its impact on basket economics."
    - name: "notification_sent"
      expr: notification_sent_flag
      comment: "Whether a notification was sent to the member for this offer. Used to measure notification impact on activation and redemption rates."
    - name: "assignment_month"
      expr: DATE_TRUNC('month', assignment_date)
      comment: "Month the offer was assigned, truncated for cohort analysis. Enables monthly offer assignment volume and funnel trend reporting."
    - name: "expiration_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month the offer expires. Used to analyze urgency-driven activation patterns and optimize offer validity windows."
  measures:
    - name: "total_offers_assigned"
      expr: COUNT(member_offer_id)
      comment: "Total count of offers assigned to members. Baseline volume metric for offer distribution scale and personalization engine throughput."
    - name: "distinct_members_with_offers"
      expr: COUNT(DISTINCT membership_id)
      comment: "Count of distinct members who received at least one offer. Measures offer program reach; low penetration relative to active members signals targeting gaps."
    - name: "total_offers_activated"
      expr: COUNT(CASE WHEN activation_date IS NOT NULL THEN member_offer_id END)
      comment: "Count of offers that were activated by members. Numerator for offer activation rate; directly measures member engagement with personalized offers."
    - name: "offer_activation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN activation_date IS NOT NULL THEN member_offer_id END) / NULLIF(COUNT(member_offer_id), 0), 2)
      comment: "Percentage of assigned offers that were activated. Primary offer engagement KPI; low rates indicate poor offer relevance, notification failures, or UX friction."
    - name: "total_offers_redeemed"
      expr: COUNT(CASE WHEN redemption_date IS NOT NULL THEN member_offer_id END)
      comment: "Count of offers that were redeemed. Measures offer conversion to actual purchase behavior; the ultimate measure of offer program effectiveness."
    - name: "offer_redemption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN redemption_date IS NOT NULL THEN member_offer_id END) / NULLIF(COUNT(member_offer_id), 0), 2)
      comment: "Percentage of assigned offers that were redeemed. End-to-end offer funnel conversion rate; directly tied to incremental revenue and promotion ROI."
    - name: "offer_activation_to_redemption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN redemption_date IS NOT NULL THEN member_offer_id END) / NULLIF(COUNT(CASE WHEN activation_date IS NOT NULL THEN member_offer_id END), 0), 2)
      comment: "Percentage of activated offers that were subsequently redeemed. Measures post-activation conversion; low rates indicate offer mechanics or timing issues after clip."
    - name: "total_discount_value_delivered"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value delivered to members through redeemed offers. Core promotion cost metric for loyalty offer P&L and ROI measurement."
    - name: "avg_discount_per_offer"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per offer. Used to calibrate offer generosity against activation and redemption rate targets."
    - name: "total_points_awarded"
      expr: SUM(CAST(points_awarded AS DOUBLE))
      comment: "Total points awarded through member offers. Measures points liability generated by the offer program; feeds into overall points economy forecasting."
    - name: "avg_personalization_score"
      expr: AVG(CAST(personalization_score AS DOUBLE))
      comment: "Average personalization relevance score across assigned offers. Measures personalization engine quality; higher scores should correlate with better activation and redemption rates."
    - name: "notification_sent_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN notification_sent_flag = TRUE THEN member_offer_id END) / NULLIF(COUNT(member_offer_id), 0), 2)
      comment: "Percentage of assigned offers for which a notification was sent. Measures notification coverage; gaps indicate delivery failures that suppress activation rates."
    - name: "offer_revocation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN revocation_date IS NOT NULL THEN member_offer_id END) / NULLIF(COUNT(member_offer_id), 0), 2)
      comment: "Percentage of assigned offers that were revoked before redemption. Elevated revocation rates signal fraud controls, eligibility errors, or campaign management issues."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`loyalty_points_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Points account balance sheet KPIs tracking available balances, lifetime economics, expiration risk, and fraud holds. Used by loyalty finance to manage points liability, breakage forecasting, and account health."
  source: "`grocery_ecm`.`loyalty`.`points_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the points account (e.g., Active, Closed, Suspended). Primary dimension for account health segmentation."
    - name: "account_type"
      expr: account_type
      comment: "Type of points account (e.g., Standard, Premium, Fuel). Enables account-type-level economics analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of the points account. Required for multi-currency financial reporting and liability consolidation."
    - name: "expiration_policy_code"
      expr: expiration_policy_code
      comment: "Expiration policy applied to the account. Used to segment accounts by expiry risk profile for breakage forecasting."
    - name: "fraud_hold"
      expr: fraud_hold_flag
      comment: "Whether the account is currently under a fraud hold. Enables fraud-impacted account monitoring and operational triage."
    - name: "is_combinable"
      expr: is_combinable
      comment: "Whether the account can be combined with other accounts. Used to analyze household pooling behavior and multi-account economics."
    - name: "is_transferable"
      expr: is_transferable
      comment: "Whether points in this account can be transferred. Relevant for gift and transfer program analysis."
    - name: "source_system"
      expr: source_system
      comment: "Source system managing the points account. Supports data reconciliation across legacy and modern loyalty platforms."
    - name: "last_activity_month"
      expr: DATE_TRUNC('month', last_activity_date)
      comment: "Month of last account activity, truncated for recency analysis. Used to identify dormant accounts for re-engagement targeting."
    - name: "next_expiration_month"
      expr: DATE_TRUNC('month', next_expiration_date)
      comment: "Month of next scheduled points expiration. Used to forecast near-term breakage and plan expiry-driven re-engagement campaigns."
  measures:
    - name: "total_available_balance"
      expr: SUM(CAST(available_balance AS DOUBLE))
      comment: "Total available points balance across all accounts. Represents the redeemable loyalty liability; critical for balance sheet provisioning."
    - name: "total_pending_balance"
      expr: SUM(CAST(pending_balance AS DOUBLE))
      comment: "Total pending points not yet available for redemption. Measures in-flight earn activity and near-term liability growth."
    - name: "total_lifetime_earned"
      expr: SUM(CAST(lifetime_earned AS DOUBLE))
      comment: "Total lifetime points earned across all accounts. Measures cumulative program engagement and gross liability generated since inception."
    - name: "total_lifetime_redeemed"
      expr: SUM(CAST(lifetime_redeemed AS DOUBLE))
      comment: "Total lifetime points redeemed across all accounts. Measures cumulative liability drawdown; used with lifetime earned to calculate net liability."
    - name: "total_lifetime_expired"
      expr: SUM(CAST(lifetime_expired AS DOUBLE))
      comment: "Total lifetime points expired across all accounts. Measures breakage realization; directly impacts loyalty program revenue recognition."
    - name: "total_lifetime_adjusted"
      expr: SUM(CAST(lifetime_adjusted AS DOUBLE))
      comment: "Total lifetime points adjusted (manual corrections, goodwill, fraud reversals). High adjustment volumes signal operational or fraud issues requiring investigation."
    - name: "total_next_expiration_amount"
      expr: SUM(CAST(next_expiration_amount AS DOUBLE))
      comment: "Total points scheduled to expire in the next expiration cycle. Forward-looking liability reduction forecast; drives urgency-based re-engagement campaign sizing."
    - name: "total_ytd_earned"
      expr: SUM(CAST(year_to_date_earned AS DOUBLE))
      comment: "Total year-to-date points earned across all accounts. In-year liability accrual metric for financial planning and budget tracking."
    - name: "total_ytd_redeemed"
      expr: SUM(CAST(year_to_date_redeemed AS DOUBLE))
      comment: "Total year-to-date points redeemed across all accounts. In-year liability drawdown metric; compared against YTD earned to track net liability trajectory."
    - name: "lifetime_breakage_rate"
      expr: ROUND(100.0 * SUM(CAST(lifetime_expired AS DOUBLE)) / NULLIF(SUM(CAST(lifetime_earned AS DOUBLE)), 0), 2)
      comment: "Percentage of lifetime earned points that have expired unredeemed (breakage rate). Key financial metric for loyalty revenue recognition and liability reserve calibration."
    - name: "lifetime_redemption_rate"
      expr: ROUND(100.0 * SUM(CAST(lifetime_redeemed AS DOUBLE)) / NULLIF(SUM(CAST(lifetime_earned AS DOUBLE)), 0), 2)
      comment: "Percentage of lifetime earned points that have been redeemed. Measures program value delivery efficiency; used alongside breakage rate for full liability lifecycle view."
    - name: "avg_available_balance_per_account"
      expr: AVG(CAST(available_balance AS DOUBLE))
      comment: "Average available points balance per account. Benchmarks typical member accumulation; used to set redemption threshold recommendations."
    - name: "fraud_hold_account_count"
      expr: COUNT(CASE WHEN fraud_hold_flag = TRUE THEN points_account_id END)
      comment: "Count of accounts currently under a fraud hold. Operational risk KPI; elevated counts trigger fraud team escalation and member communication protocols."
    - name: "avg_earn_multiplier"
      expr: AVG(CAST(earn_multiplier AS DOUBLE))
      comment: "Average earn multiplier across active accounts. Measures the effective earn rate being applied; deviations from program config signal misconfiguration or promotional overrides."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`loyalty_tier_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tier movement KPIs tracking upgrade, downgrade, and retention rates across the loyalty tier hierarchy. Used by loyalty strategy to evaluate tier program effectiveness, member progression health, and tier benefit ROI."
  source: "`grocery_ecm`.`loyalty`.`tier_history`"
  dimensions:
    - name: "tier_change_type"
      expr: tier_change_type
      comment: "Type of tier change event (e.g., Upgrade, Downgrade, Renewal, Initial). Primary dimension for tier movement flow analysis."
    - name: "tier_change_reason_code"
      expr: tier_change_reason_code
      comment: "Reason code for the tier change. Used to distinguish earned progressions from manual adjustments, expirations, and goodwill upgrades."
    - name: "tier_change_status"
      expr: tier_change_status
      comment: "Processing status of the tier change event (e.g., Completed, Pending, Failed). Operational quality dimension for tier processing reliability."
    - name: "previous_tier_name"
      expr: previous_tier_name
      comment: "Name of the tier the member held before this change. Enables from-tier analysis in tier transition flow matrices."
    - name: "is_manual_adjustment"
      expr: is_manual_adjustment
      comment: "Whether the tier change was a manual override. High manual adjustment rates signal program rule gaps or customer service escalation volumes."
    - name: "notification_channel"
      expr: notification_channel
      comment: "Channel used to notify the member of their tier change. Measures notification delivery coverage for tier change communications."
    - name: "notification_sent"
      expr: notification_sent_flag
      comment: "Whether a tier change notification was sent to the member. Notification gaps on tier upgrades degrade member experience and perceived program value."
    - name: "tier_benefits_activated"
      expr: tier_benefits_activated_flag
      comment: "Whether tier benefits were activated following the tier change. Unactivated benefits after upgrades indicate fulfillment failures."
    - name: "program_year"
      expr: program_year
      comment: "Loyalty program year in which the tier change occurred. Enables year-over-year tier movement comparison."
    - name: "tier_change_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the tier change became effective, truncated for trend analysis. Enables monthly tier movement volume and mix reporting."
    - name: "source_system"
      expr: source_system
      comment: "Source system that recorded the tier change. Supports data lineage and reconciliation across loyalty platforms."
  measures:
    - name: "total_tier_changes"
      expr: COUNT(tier_history_id)
      comment: "Total count of tier change events. Baseline volume metric for tier program activity; high volatility signals program rule instability."
    - name: "total_upgrades"
      expr: COUNT(CASE WHEN tier_change_type = 'Upgrade' THEN tier_history_id END)
      comment: "Count of tier upgrade events. Measures upward member progression; a key indicator of program engagement and spend growth."
    - name: "total_downgrades"
      expr: COUNT(CASE WHEN tier_change_type = 'Downgrade' THEN tier_history_id END)
      comment: "Count of tier downgrade events. Elevated downgrade counts signal member spend decline or churn risk requiring retention intervention."
    - name: "upgrade_to_downgrade_ratio"
      expr: ROUND(CAST(COUNT(CASE WHEN tier_change_type = 'Upgrade' THEN tier_history_id END) AS DOUBLE) / NULLIF(COUNT(CASE WHEN tier_change_type = 'Downgrade' THEN tier_history_id END), 0), 2)
      comment: "Ratio of upgrades to downgrades. Program health ratio; values above 1.0 indicate net positive tier progression; below 1.0 signals member value erosion."
    - name: "manual_adjustment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_manual_adjustment = TRUE THEN tier_history_id END) / NULLIF(COUNT(tier_history_id), 0), 2)
      comment: "Percentage of tier changes that were manual overrides. High rates indicate program rule gaps, customer service escalation burden, or data quality issues."
    - name: "notification_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN notification_sent_flag = TRUE THEN tier_history_id END) / NULLIF(COUNT(tier_history_id), 0), 2)
      comment: "Percentage of tier changes for which a notification was sent to the member. Notification gaps on upgrades degrade member experience and reduce perceived program value."
    - name: "benefits_activation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN tier_benefits_activated_flag = TRUE THEN tier_history_id END) / NULLIF(COUNT(tier_history_id), 0), 2)
      comment: "Percentage of tier changes where benefits were successfully activated. Low rates indicate fulfillment failures that undermine the value proposition of tier upgrades."
    - name: "avg_qualifying_spend_at_change"
      expr: AVG(CAST(qualifying_spend_amount AS DOUBLE))
      comment: "Average qualifying spend amount at the time of tier change. Benchmarks the spend level driving tier transitions; used to calibrate tier thresholds."
    - name: "total_qualifying_spend_at_change"
      expr: SUM(CAST(qualifying_spend_amount AS DOUBLE))
      comment: "Total qualifying spend across all tier change events. Measures the aggregate spend activity that drove tier movements in the period."
    - name: "avg_points_balance_at_change"
      expr: AVG(CAST(points_balance_at_change AS DOUBLE))
      comment: "Average points balance members held at the time of their tier change. Indicates the points accumulation level associated with tier transitions."
    - name: "distinct_members_with_tier_changes"
      expr: COUNT(DISTINCT membership_id)
      comment: "Count of distinct members who experienced a tier change in the period. Measures tier program dynamism and the breadth of members actively progressing through the tier hierarchy."
    - name: "total_welcome_bonus_points_awarded"
      expr: SUM(CAST(welcome_bonus_points AS DOUBLE))
      comment: "Total welcome bonus points awarded upon tier upgrades. Measures the points liability generated by tier upgrade incentives; feeds into points economy forecasting."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`loyalty_reward_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reward offer catalog KPIs measuring offer economics, redemption performance, and ROI targets. Used by loyalty marketing and finance to manage the reward catalog, optimize offer investment, and track program cost efficiency."
  source: "`grocery_ecm`.`loyalty`.`reward_offer`"
  dimensions:
    - name: "offer_type"
      expr: offer_type
      comment: "Type of reward offer (e.g., Points Multiplier, Fuel Discount, Sweepstakes, Discount). Primary dimension for reward catalog mix analysis."
    - name: "offer_status"
      expr: offer_status
      comment: "Current status of the reward offer (e.g., Active, Expired, Draft, Paused). Used to filter active catalog and analyze offer lifecycle."
    - name: "mechanics_type"
      expr: mechanics_type
      comment: "Mechanics type of the offer (e.g., Spend Threshold, Buy X Get Y, Bonus Points). Enables mechanics-level performance comparison."
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount applied (e.g., Percentage, Fixed Amount, Points). Used to analyze discount structure mix and cost implications."
    - name: "personalization_flag"
      expr: personalization_flag
      comment: "Whether the offer is personalized to specific members. Enables comparison of personalized vs. mass offer performance and ROI."
    - name: "auto_apply_flag"
      expr: auto_apply_flag
      comment: "Whether the offer is automatically applied without member action. Used to compare auto-apply vs. clip-and-redeem offer economics."
    - name: "stackable_flag"
      expr: stackable_flag
      comment: "Whether the offer can be stacked with other promotions. Enables analysis of stacking risk and its impact on margin."
    - name: "eligible_channel_list"
      expr: eligible_channel_list
      comment: "Channels eligible for this offer. Used to analyze channel-specific offer availability and redemption patterns."
    - name: "offer_start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the offer became active, truncated for trend analysis. Enables monthly new offer launch volume reporting."
    - name: "offer_end_month"
      expr: DATE_TRUNC('month', end_date)
      comment: "Month the offer expired or is scheduled to expire. Used to analyze offer duration distribution and catalog refresh cadence."
  measures:
    - name: "total_active_offers"
      expr: COUNT(CASE WHEN offer_status = 'Active' THEN reward_offer_id END)
      comment: "Count of currently active reward offers in the catalog. Measures catalog breadth; too few offers signal member choice limitations."
    - name: "total_offers"
      expr: COUNT(reward_offer_id)
      comment: "Total count of reward offers across all statuses. Baseline for catalog size and offer lifecycle analysis."
    - name: "total_discount_value"
      expr: SUM(CAST(discount_value AS DOUBLE))
      comment: "Total discount value across all offers in the catalog. Measures the aggregate promotional investment represented by the reward catalog."
    - name: "avg_discount_value"
      expr: AVG(CAST(discount_value AS DOUBLE))
      comment: "Average discount value per offer. Benchmarks offer generosity; used to calibrate catalog value against member satisfaction and redemption rate targets."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost_per_redemption AS DOUBLE))
      comment: "Total estimated cost across all offers (sum of per-redemption cost estimates). Provides a catalog-level cost exposure view for budget planning."
    - name: "avg_estimated_cost_per_redemption"
      expr: AVG(CAST(estimated_cost_per_redemption AS DOUBLE))
      comment: "Average estimated cost per redemption across offers. Used to benchmark offer cost efficiency and identify high-cost offers requiring ROI review."
    - name: "avg_points_multiplier"
      expr: AVG(CAST(points_multiplier AS DOUBLE))
      comment: "Average points multiplier across offers. Measures the average earn acceleration offered; higher values increase liability accrual rate."
    - name: "total_minimum_spend_requirement"
      expr: SUM(CAST(minimum_spend_amount AS DOUBLE))
      comment: "Sum of minimum spend thresholds across all offers. Aggregate measure of spend hurdle requirements; used to assess basket size lift potential of the offer catalog."
    - name: "avg_minimum_spend_requirement"
      expr: AVG(CAST(minimum_spend_amount AS DOUBLE))
      comment: "Average minimum spend threshold per offer. Benchmarks offer accessibility; high thresholds may suppress activation rates among lower-spend members."
    - name: "avg_target_roi_percentage"
      expr: AVG(CAST(target_roi_percentage AS DOUBLE))
      comment: "Average target ROI percentage across offers. Measures the expected return on promotional investment; used to prioritize high-ROI offers in catalog planning."
    - name: "total_fuel_reward_cents_per_gallon"
      expr: SUM(CAST(fuel_reward_cents_per_gallon AS DOUBLE))
      comment: "Total fuel reward value (cents per gallon) across all fuel reward offers. Measures aggregate fuel discount exposure in the catalog."
    - name: "personalized_offer_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN personalization_flag = TRUE THEN reward_offer_id END) / NULLIF(COUNT(CASE WHEN offer_status = 'Active' THEN reward_offer_id END), 0), 2)
      comment: "Percentage of active offers that are personalized. Measures personalization depth of the reward catalog; higher rates indicate more targeted, relevant offer strategies."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`loyalty_household_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household loyalty membership KPIs tracking member roles, benefit sharing, points pooling economics, and household-level spend. Used by loyalty strategy to optimize household program design, pooling rules, and multi-member engagement."
  source: "`grocery_ecm`.`loyalty`.`household_member`"
  dimensions:
    - name: "household_member_status"
      expr: household_member_status
      comment: "Current status of the household member (e.g., Active, Inactive, Pending). Primary dimension for household member health segmentation."
    - name: "member_role"
      expr: member_role
      comment: "Role of the member within the household (e.g., Primary, Secondary, Dependent). Enables role-level economics and benefit sharing analysis."
    - name: "relationship_type"
      expr: relationship_type
      comment: "Relationship type of the household member to the primary member (e.g., Spouse, Child, Parent). Used for household composition analysis."
    - name: "benefit_sharing_tier"
      expr: benefit_sharing_tier
      comment: "Benefit sharing tier assigned to the household member. Determines which benefits are shared across the household unit."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the household member invitation (e.g., Approved, Pending, Rejected). Used to track household onboarding funnel conversion."
    - name: "points_pooling_flag"
      expr: points_pooling_flag
      comment: "Whether the member participates in household points pooling. Enables pooling vs. non-pooling member economics comparison."
    - name: "fuel_rewards_sharing_flag"
      expr: fuel_rewards_sharing_flag
      comment: "Whether the member shares fuel rewards with the household. Measures fuel reward sharing adoption within households."
    - name: "pharmacy_benefits_sharing_flag"
      expr: pharmacy_benefits_sharing_flag
      comment: "Whether the member shares pharmacy benefits with the household. Measures pharmacy benefit sharing adoption."
    - name: "digital_wallet_linked_flag"
      expr: digital_wallet_linked_flag
      comment: "Whether the household member has linked a digital wallet. Measures digital adoption within household member accounts."
    - name: "join_month"
      expr: DATE_TRUNC('month', join_date)
      comment: "Month the member joined the household loyalty account, truncated for cohort analysis. Enables household member acquisition trend reporting."
    - name: "spending_authority_level"
      expr: spending_authority_level
      comment: "Spending authority level assigned to the household member. Used to analyze spending limit distribution and household financial governance."
  measures:
    - name: "total_active_household_members"
      expr: COUNT(CASE WHEN household_member_status = 'Active' THEN household_member_id END)
      comment: "Count of active household loyalty members. Measures household program scale; growth indicates successful multi-member acquisition strategy."
    - name: "total_household_members"
      expr: COUNT(household_member_id)
      comment: "Total count of household members across all statuses. Baseline for household program size and activation rate calculations."
    - name: "total_annual_spend"
      expr: SUM(CAST(annual_spend_amount AS DOUBLE))
      comment: "Total annual spend across all household members. Measures the aggregate revenue contribution of the household loyalty program."
    - name: "avg_annual_spend_per_member"
      expr: AVG(CAST(annual_spend_amount AS DOUBLE))
      comment: "Average annual spend per household member. Benchmarks household member value; used to evaluate the incremental spend lift from household program participation."
    - name: "total_lifetime_points_contributed"
      expr: SUM(CAST(lifetime_points_contributed AS BIGINT))
      comment: "Total lifetime points contributed by household members to the shared pool. Measures household pooling program engagement and collective earn behavior."
    - name: "total_lifetime_points_redeemed"
      expr: SUM(CAST(lifetime_points_redeemed AS BIGINT))
      comment: "Total lifetime points redeemed by household members. Measures household-level redemption activity and program value utilization."
    - name: "household_points_redemption_rate"
      expr: ROUND(100.0 * SUM(CAST(lifetime_points_redeemed AS DOUBLE)) / NULLIF(SUM(CAST(lifetime_points_contributed AS DOUBLE)), 0), 2)
      comment: "Percentage of household-contributed points that have been redeemed. Measures household pooling program utilization efficiency."
    - name: "avg_pooling_contribution_percentage"
      expr: AVG(CAST(pooling_contribution_percentage AS DOUBLE))
      comment: "Average percentage of points each member contributes to the household pool. Measures pooling generosity and household sharing behavior."
    - name: "avg_spending_limit"
      expr: AVG(CAST(spending_limit_amount AS DOUBLE))
      comment: "Average spending limit assigned to household members. Used to assess household financial governance configuration and its impact on spend behavior."
    - name: "points_pooling_adoption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN points_pooling_flag = TRUE THEN household_member_id END) / NULLIF(COUNT(CASE WHEN household_member_status = 'Active' THEN household_member_id END), 0), 2)
      comment: "Percentage of active household members participating in points pooling. Measures household pooling feature adoption; low rates indicate awareness or UX barriers."
    - name: "distinct_households"
      expr: COUNT(DISTINCT household_id)
      comment: "Count of distinct households with at least one loyalty member. Measures household program reach and penetration across the customer base."
    - name: "invitation_acceptance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN invitation_accepted_date IS NOT NULL THEN household_member_id END) / NULLIF(COUNT(CASE WHEN invitation_sent_date IS NOT NULL THEN household_member_id END), 0), 2)
      comment: "Percentage of household member invitations that were accepted. Measures household onboarding funnel conversion; low rates indicate friction in the invitation experience."
$$;