-- Metric views for domain: promotion | Business: Retail | Version: 2 | Generated on: 2026-06-24 00:42:49

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_promo_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core promotion performance metrics tracking redemption activity, discount economics, fraud exposure, and vendor funding across all channels and campaigns. Primary KPI surface for promotion effectiveness steering."
  source: "`vibe_retail_v1`.`promotion`.`promo_redemption`"
  dimensions:
    - name: "redemption_channel"
      expr: redemption_channel
      comment: "Channel through which the promotion was redeemed (e.g. in-store, online, mobile) — enables channel-level promotion ROI analysis."
    - name: "redemption_status"
      expr: redemption_status
      comment: "Status of the redemption event (e.g. approved, rejected, pending) — used to filter valid vs. failed redemptions."
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount applied (e.g. percentage, fixed amount, BOGO) — supports discount strategy performance comparison."
    - name: "promotion_tier"
      expr: promotion_tier
      comment: "Tier classification of the promotion (e.g. gold, silver, standard) — enables tiered promotion effectiveness benchmarking."
    - name: "vendor_funded_flag"
      expr: vendor_funded_flag
      comment: "Indicates whether the redemption was funded by a vendor — critical for cost-sharing and vendor accountability reporting."
    - name: "redemption_mechanism"
      expr: redemption_mechanism
      comment: "Mechanism used to redeem the promotion (e.g. coupon scan, loyalty app, promo code) — informs channel investment decisions."
    - name: "chargeback_status"
      expr: chargeback_status
      comment: "Status of any chargeback associated with the redemption — used to track vendor recovery and dispute resolution."
    - name: "redemption_date"
      expr: CAST(redemption_timestamp AS DATE)
      comment: "Date of redemption derived from the redemption timestamp — enables daily and weekly trend analysis."
    - name: "redemption_month"
      expr: DATE_TRUNC('MONTH', redemption_timestamp)
      comment: "Month of redemption — supports monthly promotion performance reporting and seasonal trend analysis."
  measures:
    - name: "total_redemptions"
      expr: COUNT(1)
      comment: "Total number of promotion redemption events — baseline volume KPI for promotion reach and uptake."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total monetary value of discounts granted across all redemptions — directly measures promotional cost to the business."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount value per redemption event — indicates discount depth and generosity of promotion design."
    - name: "total_final_price"
      expr: SUM(CAST(final_price AS DOUBLE))
      comment: "Total post-discount revenue captured across all redemptions — measures net revenue contribution after promotion cost."
    - name: "total_original_price"
      expr: SUM(CAST(original_price AS DOUBLE))
      comment: "Total pre-discount revenue value across all redemptions — baseline for calculating promotion discount rate."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback value recovered or pending from vendors — critical for vendor funding reconciliation and P&L accuracy."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across redemptions — elevated values signal systemic abuse requiring intervention."
    - name: "max_fraud_score"
      expr: MAX(CAST(fraud_score AS DOUBLE))
      comment: "Maximum fraud score observed — identifies worst-case fraud exposure events for investigation prioritization."
    - name: "distinct_campaigns_redeemed"
      expr: COUNT(DISTINCT promo_campaign_id)
      comment: "Number of distinct promotion campaigns with at least one redemption — measures campaign activation breadth."
    - name: "distinct_offers_redeemed"
      expr: COUNT(DISTINCT promo_offer_id)
      comment: "Number of distinct promotion offers redeemed — indicates offer portfolio utilization and customer engagement spread."
    - name: "distinct_customers_redeeming"
      expr: COUNT(DISTINCT primary_promo_customer_profile_id)
      comment: "Number of unique customers who redeemed a promotion — measures promotion reach and customer engagement breadth."
    - name: "vendor_funded_redemptions"
      expr: SUM(CASE WHEN vendor_funded_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of redemptions where vendor funding applies — used to quantify vendor cost-share volume for financial reporting."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_promo_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion budget governance metrics covering planned vs. actual spend, vendor funding contribution, channel allocation efficiency, and budget variance. Enables CFO and CMO-level financial stewardship of promotional investment."
  source: "`vibe_retail_v1`.`promotion`.`promo_budget`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Classification of the budget (e.g. trade, marketing, co-op) — enables spend analysis by funding category."
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget (e.g. active, closed, pending approval) — used to filter actionable vs. historical budgets."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the budget — tracks governance compliance and pending approvals requiring action."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget — enables year-over-year promotional spend comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (e.g. month, quarter) of the budget — supports periodic budget performance reviews."
    - name: "budget_owner_type"
      expr: budget_owner_type
      comment: "Type of owner responsible for the budget (e.g. category manager, brand team) — enables accountability reporting."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date of the budget's effective period — used for time-bounded budget performance analysis."
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "End date of the budget's effective period — used to identify expired or expiring budgets."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total approved promotional budget across all budget records — top-line promotional investment commitment."
    - name: "total_planned_spend"
      expr: SUM(CAST(planned_spend_amount AS DOUBLE))
      comment: "Total planned promotional spend — measures how fully budgets are allocated to planned activities."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual promotional spend incurred — the realized cost of promotional activity against plan."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed (obligated but not yet spent) promotional funds — critical for cash flow and liability forecasting."
    - name: "total_remaining_budget"
      expr: SUM(CAST(remaining_budget_amount AS DOUBLE))
      comment: "Total unspent remaining budget — indicates available promotional investment capacity for the period."
    - name: "total_vendor_funded_amount"
      expr: SUM(CAST(vendor_funded_amount AS DOUBLE))
      comment: "Total vendor co-funding contribution to promotional budgets — measures vendor investment and cost offset to the retailer."
    - name: "total_circular_ad_allocation"
      expr: SUM(CAST(circular_ad_allocation AS DOUBLE))
      comment: "Total budget allocated to circular advertising — informs print/digital circular investment decisions."
    - name: "total_ecommerce_channel_allocation"
      expr: SUM(CAST(ecommerce_channel_allocation AS DOUBLE))
      comment: "Total budget allocated to e-commerce channel promotions — tracks digital promotional investment."
    - name: "total_mobile_channel_allocation"
      expr: SUM(CAST(mobile_channel_allocation AS DOUBLE))
      comment: "Total budget allocated to mobile channel promotions — measures mobile-first promotional investment."
    - name: "total_pos_channel_allocation"
      expr: SUM(CAST(pos_channel_allocation AS DOUBLE))
      comment: "Total budget allocated to POS channel promotions — tracks in-store promotional investment."
    - name: "avg_variance_threshold_percent"
      expr: AVG(CAST(variance_threshold_percent AS DOUBLE))
      comment: "Average variance tolerance percentage across budgets — indicates how tightly budgets are governed on average."
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Total number of promotion budget records — baseline count for budget portfolio size and governance coverage."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_promo_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion campaign portfolio metrics covering campaign investment, target revenue, digital and loyalty reach, and vendor funding. Enables marketing leadership to evaluate campaign strategy, prioritization, and ROI potential."
  source: "`vibe_retail_v1`.`promotion`.`promo_campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of promotion campaign (e.g. seasonal, clearance, loyalty event) — enables performance comparison across campaign strategies."
    - name: "promo_campaign_status"
      expr: promo_campaign_status
      comment: "Current lifecycle status of the campaign (e.g. planned, active, completed) — used to filter pipeline vs. live vs. closed campaigns."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status — tracks governance compliance and identifies campaigns pending executive sign-off."
    - name: "channel_scope"
      expr: channel_scope
      comment: "Channel(s) targeted by the campaign (e.g. in-store, online, omnichannel) — enables channel strategy analysis."
    - name: "discount_strategy"
      expr: discount_strategy
      comment: "Discount approach used in the campaign (e.g. percentage off, BOGO, bundle) — supports discount strategy effectiveness comparison."
    - name: "event_classification"
      expr: event_classification
      comment: "Business event driving the campaign (e.g. holiday, back-to-school, clearance) — enables event-based campaign benchmarking."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority tier of the campaign — used to assess resource allocation alignment with strategic priorities."
    - name: "digital_promotion_flag"
      expr: digital_promotion_flag
      comment: "Indicates whether the campaign includes a digital promotion component — enables digital vs. traditional campaign comparison."
    - name: "loyalty_exclusive_flag"
      expr: loyalty_exclusive_flag
      comment: "Indicates whether the campaign is exclusive to loyalty program members — measures loyalty program investment."
    - name: "vendor_funded_flag"
      expr: vendor_funded_flag
      comment: "Indicates whether the campaign is vendor-funded — critical for cost-sharing and vendor ROI accountability."
    - name: "campaign_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the campaign starts — enables monthly campaign launch cadence and seasonal planning analysis."
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of promotion campaigns — baseline portfolio size metric for campaign planning capacity."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total promotional investment committed across all campaigns — top-line campaign spend commitment for financial planning."
    - name: "avg_budget_per_campaign"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget allocated per campaign — benchmarks investment intensity and identifies under- or over-funded campaigns."
    - name: "total_target_revenue"
      expr: SUM(CAST(target_revenue AS DOUBLE))
      comment: "Total targeted revenue across all campaigns — measures the aggregate revenue ambition of the promotional portfolio."
    - name: "avg_target_revenue_per_campaign"
      expr: AVG(CAST(target_revenue AS DOUBLE))
      comment: "Average revenue target per campaign — used to benchmark campaign ambition and identify outliers."
    - name: "digital_campaign_count"
      expr: SUM(CASE WHEN digital_promotion_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of campaigns with a digital promotion component — tracks digital transformation of the promotional mix."
    - name: "loyalty_exclusive_campaign_count"
      expr: SUM(CASE WHEN loyalty_exclusive_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of campaigns exclusive to loyalty members — measures loyalty program investment and exclusivity strategy."
    - name: "vendor_funded_campaign_count"
      expr: SUM(CASE WHEN vendor_funded_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of vendor-funded campaigns — quantifies vendor co-investment in the promotional calendar."
    - name: "distinct_vendors_in_campaigns"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors participating in campaigns — measures vendor engagement breadth in promotional activity."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_promo_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion offer economics metrics covering discount value, redemption limits, vendor funding, and offer portfolio composition. Enables category managers and promotion planners to optimize offer design and financial exposure."
  source: "`vibe_retail_v1`.`promotion`.`promo_offer`"
  dimensions:
    - name: "offer_type"
      expr: offer_type
      comment: "Type of promotion offer (e.g. percentage discount, fixed amount, free gift) — enables offer type performance comparison."
    - name: "offer_status"
      expr: offer_status
      comment: "Current status of the offer (e.g. active, expired, draft) — used to filter live vs. historical offer analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the offer — tracks governance compliance and pending approvals."
    - name: "discount_method"
      expr: discount_method
      comment: "Method by which the discount is applied (e.g. at checkout, post-purchase, auto-apply) — informs checkout experience design."
    - name: "channel_eligibility"
      expr: channel_eligibility
      comment: "Channels where the offer is valid (e.g. in-store, online, all) — enables channel-specific offer strategy analysis."
    - name: "vendor_funded_flag"
      expr: vendor_funded_flag
      comment: "Indicates whether the offer is vendor-funded — critical for cost-sharing accountability and margin protection."
    - name: "personalization_flag"
      expr: personalization_flag
      comment: "Indicates whether the offer is personalized to a customer segment — measures personalization investment in promotions."
    - name: "stackable_flag"
      expr: stackable_flag
      comment: "Indicates whether the offer can be stacked with other promotions — used to assess margin risk from offer stacking."
    - name: "offer_effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the offer becomes effective — enables monthly offer launch cadence and seasonal planning analysis."
  measures:
    - name: "total_offers"
      expr: COUNT(1)
      comment: "Total number of promotion offers — baseline portfolio size metric for offer management and governance."
    - name: "total_discount_value"
      expr: SUM(CAST(discount_value AS DOUBLE))
      comment: "Total face value of discounts across all offers — measures aggregate promotional liability and cost exposure."
    - name: "avg_discount_value"
      expr: AVG(CAST(discount_value AS DOUBLE))
      comment: "Average discount value per offer — benchmarks discount depth and identifies outlier offers with excessive discounting."
    - name: "total_minimum_purchase_amount"
      expr: SUM(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Sum of minimum purchase thresholds across offers — indicates aggregate basket-building intent in offer design."
    - name: "avg_minimum_purchase_amount"
      expr: AVG(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Average minimum purchase threshold per offer — measures how aggressively offers drive basket size uplift."
    - name: "total_maximum_redemption_total"
      expr: SUM(CAST(maximum_redemption_total AS DOUBLE))
      comment: "Total maximum redemption cap across all offers — measures the ceiling on promotional liability exposure."
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average vendor cost-share percentage across offers — measures how much of the promotional cost is offset by vendors."
    - name: "vendor_funded_offer_count"
      expr: SUM(CASE WHEN vendor_funded_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of vendor-funded offers — quantifies vendor co-investment in the offer portfolio."
    - name: "personalized_offer_count"
      expr: SUM(CASE WHEN personalization_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of personalized offers — tracks investment in targeted promotion strategies."
    - name: "stackable_offer_count"
      expr: SUM(CASE WHEN stackable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of stackable offers — quantifies margin risk exposure from combinable promotions."
    - name: "distinct_skus_in_offers"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs covered by promotion offers — measures product breadth of the promotional portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_vendor_promo_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor promotional agreement financial metrics covering funding commitments, accruals, settlements, outstanding balances, and chargeback exposure. Enables finance and merchandising teams to manage vendor co-op accountability and cash recovery."
  source: "`vibe_retail_v1`.`promotion`.`vendor_promo_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of vendor promotional agreement (e.g. co-op, MDF, scan-down) — enables agreement type performance and compliance comparison."
    - name: "vendor_promo_agreement_status"
      expr: vendor_promo_agreement_status
      comment: "Current status of the agreement (e.g. active, expired, terminated) — used to filter live vs. closed agreements."
    - name: "accrual_method"
      expr: accrual_method
      comment: "Method used to accrue vendor funding (e.g. scan-based, fixed, percentage) — informs accounting treatment and reconciliation."
    - name: "settlement_frequency"
      expr: settlement_frequency
      comment: "How often vendor funding is settled (e.g. monthly, quarterly) — used to forecast cash recovery timing."
    - name: "chargeback_eligible"
      expr: chargeback_eligible
      comment: "Indicates whether the agreement allows chargebacks — used to identify agreements with recovery mechanisms."
    - name: "ad_placement_required"
      expr: ad_placement_required
      comment: "Indicates whether the agreement requires ad placement compliance — tracks performance obligation fulfillment risk."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date of the agreement's effective period — used for time-bounded vendor funding analysis."
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "End date of the agreement — used to identify expiring agreements requiring renewal action."
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total number of vendor promotional agreements — baseline portfolio size for vendor relationship management."
    - name: "total_funding_amount"
      expr: SUM(CAST(funding_amount AS DOUBLE))
      comment: "Total vendor funding committed across all agreements — top-line vendor co-investment in promotional activity."
    - name: "avg_funding_percentage"
      expr: AVG(CAST(funding_percentage AS DOUBLE))
      comment: "Average vendor funding percentage across agreements — benchmarks vendor cost-share generosity and negotiation outcomes."
    - name: "total_accrued_amount"
      expr: SUM(CAST(total_accrued_amount AS DOUBLE))
      comment: "Total vendor funding accrued to date — measures earned but not yet settled vendor co-op receivables."
    - name: "total_settled_amount"
      expr: SUM(CAST(total_settled_amount AS DOUBLE))
      comment: "Total vendor funding already settled — measures cash actually recovered from vendor promotional agreements."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding vendor funding balance — measures uncollected vendor co-op receivables requiring follow-up."
    - name: "total_chargeback_penalty_amount"
      expr: SUM(CAST(chargeback_penalty_amount AS DOUBLE))
      comment: "Total chargeback penalties across agreements — measures financial exposure from vendor non-compliance."
    - name: "total_minimum_purchase_amount"
      expr: SUM(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Total minimum purchase commitments across vendor agreements — measures aggregate purchase obligation to vendors."
    - name: "distinct_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with promotional agreements — measures vendor partnership breadth in the promotional program."
    - name: "chargeback_eligible_agreement_count"
      expr: SUM(CASE WHEN chargeback_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Number of agreements with chargeback eligibility — quantifies the scope of vendor accountability mechanisms in place."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_coupon`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coupon portfolio metrics covering face value, discount economics, digital enablement, and issuance scope. Enables promotion planners and finance teams to manage coupon liability, channel strategy, and redemption design."
  source: "`vibe_retail_v1`.`promotion`.`coupon`"
  dimensions:
    - name: "coupon_type"
      expr: coupon_type
      comment: "Type of coupon (e.g. manufacturer, store, digital, paper) — enables coupon type performance and cost comparison."
    - name: "coupon_status"
      expr: coupon_status
      comment: "Current status of the coupon (e.g. active, expired, redeemed) — used to filter live vs. historical coupon analysis."
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount the coupon provides (e.g. percentage, fixed amount) — supports discount strategy analysis."
    - name: "issue_channel"
      expr: issue_channel
      comment: "Channel through which the coupon was issued (e.g. email, in-store, app) — enables issuance channel effectiveness analysis."
    - name: "eligible_channel"
      expr: eligible_channel
      comment: "Channel(s) where the coupon can be redeemed — informs omnichannel promotion strategy."
    - name: "digital_wallet_enabled_flag"
      expr: digital_wallet_enabled_flag
      comment: "Indicates whether the coupon is enabled for digital wallet redemption — tracks digital coupon adoption."
    - name: "stackable_flag"
      expr: stackable_flag
      comment: "Indicates whether the coupon can be stacked with other promotions — used to assess margin risk from coupon stacking."
    - name: "single_use_flag"
      expr: single_use_flag
      comment: "Indicates whether the coupon is single-use — used to assess redemption control and fraud risk."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the coupon was issued — enables monthly coupon issuance trend and seasonal planning analysis."
    - name: "expiration_date"
      expr: expiration_date
      comment: "Coupon expiration date — used to identify expiring coupons and manage redemption urgency campaigns."
  measures:
    - name: "total_coupons"
      expr: COUNT(1)
      comment: "Total number of coupons in the portfolio — baseline issuance volume for coupon program management."
    - name: "total_face_value"
      expr: SUM(CAST(face_value AS DOUBLE))
      comment: "Total face value of all coupons issued — measures aggregate coupon liability and promotional cost exposure."
    - name: "avg_face_value"
      expr: AVG(CAST(face_value AS DOUBLE))
      comment: "Average coupon face value — benchmarks discount depth and identifies outlier high-value coupons."
    - name: "total_maximum_discount_amount"
      expr: SUM(CAST(maximum_discount_amount AS DOUBLE))
      comment: "Total maximum discount cap across all coupons — measures the ceiling on coupon-driven promotional liability."
    - name: "total_minimum_purchase_amount"
      expr: SUM(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Total minimum purchase thresholds across coupons — measures aggregate basket-building intent in coupon design."
    - name: "avg_minimum_purchase_amount"
      expr: AVG(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Average minimum purchase threshold per coupon — measures how aggressively coupons drive basket size uplift."
    - name: "digital_wallet_enabled_coupon_count"
      expr: SUM(CASE WHEN digital_wallet_enabled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of coupons enabled for digital wallet redemption — tracks digital coupon adoption and modernization."
    - name: "stackable_coupon_count"
      expr: SUM(CASE WHEN stackable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of stackable coupons — quantifies margin risk exposure from combinable coupon promotions."
    - name: "distinct_skus_covered"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs covered by coupons — measures product breadth of the coupon program."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_rebate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rebate program financial metrics covering rebate amounts, vendor funding, minimum purchase thresholds, and program scope. Enables finance and merchandising teams to manage rebate liability, vendor accountability, and program ROI."
  source: "`vibe_retail_v1`.`promotion`.`rebate`"
  dimensions:
    - name: "rebate_type"
      expr: rebate_type
      comment: "Type of rebate (e.g. mail-in, instant, scan-down) — enables rebate type performance and cost comparison."
    - name: "rebate_status"
      expr: rebate_status
      comment: "Current status of the rebate (e.g. active, expired, pending) — used to filter live vs. historical rebate analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the rebate — tracks governance compliance and pending approvals."
    - name: "channel_eligibility"
      expr: channel_eligibility
      comment: "Channels where the rebate is valid — enables channel-specific rebate strategy analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of rebate payment to the customer (e.g. check, gift card, account credit) — informs customer experience design."
    - name: "stackable_with_other_promotions"
      expr: stackable_with_other_promotions
      comment: "Indicates whether the rebate can be combined with other promotions — used to assess margin risk from stacking."
    - name: "requires_proof_of_purchase"
      expr: requires_proof_of_purchase
      comment: "Indicates whether proof of purchase is required for rebate submission — measures redemption friction and fraud control."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the rebate becomes effective — enables monthly rebate launch cadence and seasonal planning analysis."
  measures:
    - name: "total_rebates"
      expr: COUNT(1)
      comment: "Total number of rebate programs — baseline portfolio size for rebate program management."
    - name: "total_rebate_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total rebate value across all programs — measures aggregate rebate liability and promotional cost exposure."
    - name: "avg_rebate_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average rebate value per program — benchmarks rebate generosity and identifies outlier high-value programs."
    - name: "total_maximum_rebate_amount"
      expr: SUM(CAST(maximum_rebate_amount AS DOUBLE))
      comment: "Total maximum rebate cap across all programs — measures the ceiling on rebate-driven promotional liability."
    - name: "avg_rebate_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average rebate percentage across programs — benchmarks rebate depth and vendor funding generosity."
    - name: "total_minimum_purchase_amount"
      expr: SUM(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Total minimum purchase thresholds across rebate programs — measures aggregate basket-building intent in rebate design."
    - name: "avg_vendor_funding_percentage"
      expr: AVG(CAST(vendor_funding_percentage AS DOUBLE))
      comment: "Average vendor funding percentage across rebate programs — measures how much of rebate cost is offset by vendors."
    - name: "distinct_vendors_in_rebates"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors participating in rebate programs — measures vendor engagement breadth in rebate activity."
    - name: "distinct_skus_in_rebates"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs covered by rebate programs — measures product breadth of the rebate portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_promo_calendar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotional calendar planning metrics covering expected sales and traffic lift, budget allocation, and planning governance. Enables marketing and planning teams to evaluate promotional period ambition, coverage, and execution readiness."
  source: "`vibe_retail_v1`.`promotion`.`promo_calendar`"
  dimensions:
    - name: "period_type"
      expr: period_type
      comment: "Type of promotional period (e.g. weekly, event, seasonal) — enables period type performance benchmarking."
    - name: "planning_status"
      expr: planning_status
      comment: "Current planning status of the calendar period (e.g. draft, locked, approved) — tracks planning governance and readiness."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the promotional period — enables year-over-year promotional calendar comparison."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the promotional period — supports quarterly promotional planning reviews."
    - name: "priority_tier"
      expr: priority_tier
      comment: "Priority tier of the promotional period — used to assess resource allocation alignment with strategic priorities."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the promotional period is currently active — used to filter live vs. historical periods."
    - name: "is_blackout_period"
      expr: is_blackout_period
      comment: "Indicates whether the period is a promotional blackout — used to identify restricted promotion windows."
    - name: "competitive_response_flag"
      expr: competitive_response_flag
      comment: "Indicates whether the period was triggered by a competitive response — measures reactive vs. planned promotional activity."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the promotional period starts — enables monthly promotional calendar density and planning analysis."
  measures:
    - name: "total_calendar_periods"
      expr: COUNT(1)
      comment: "Total number of promotional calendar periods — baseline count for promotional calendar density and coverage."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated across all promotional calendar periods — measures aggregate promotional investment by period."
    - name: "avg_budget_per_period"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per promotional period — benchmarks investment intensity and identifies under-funded periods."
    - name: "avg_expected_sales_lift_pct"
      expr: AVG(CAST(expected_sales_lift_pct AS DOUBLE))
      comment: "Average expected sales lift percentage across promotional periods — measures the aggregate ambition of the promotional plan."
    - name: "avg_expected_traffic_lift_pct"
      expr: AVG(CAST(expected_traffic_lift_pct AS DOUBLE))
      comment: "Average expected traffic lift percentage across promotional periods — measures anticipated footfall/visit impact of promotions."
    - name: "competitive_response_period_count"
      expr: SUM(CASE WHEN competitive_response_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of promotional periods triggered by competitive response — measures reactive promotional activity volume."
    - name: "blackout_period_count"
      expr: SUM(CASE WHEN is_blackout_period = TRUE THEN 1 ELSE 0 END)
      comment: "Number of blackout periods in the promotional calendar — measures promotional restriction coverage."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_circular_ad`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Circular advertising production and investment metrics covering production costs, vendor funding, and publication scope. Enables marketing and finance teams to manage circular production economics, vendor co-investment, and publication efficiency."
  source: "`vibe_retail_v1`.`promotion`.`circular_ad`"
  dimensions:
    - name: "circular_type"
      expr: circular_type
      comment: "Type of circular (e.g. weekly, seasonal, digital-only) — enables circular type cost and reach comparison."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Channel through which the circular is distributed (e.g. print, email, app) — informs channel investment decisions."
    - name: "production_status"
      expr: production_status
      comment: "Current production status of the circular (e.g. in-design, approved, published) — tracks production pipeline health."
    - name: "is_vendor_funded"
      expr: is_vendor_funded
      comment: "Indicates whether the circular is vendor-funded — critical for cost-sharing and vendor accountability reporting."
    - name: "compliance_review_flag"
      expr: compliance_review_flag
      comment: "Indicates whether the circular has undergone compliance review — tracks regulatory and brand compliance governance."
    - name: "publication_month"
      expr: DATE_TRUNC('MONTH', publication_date)
      comment: "Month of circular publication — enables monthly circular cadence and seasonal planning analysis."
    - name: "target_audience"
      expr: target_audience
      comment: "Target audience segment for the circular — enables audience-based circular effectiveness analysis."
  measures:
    - name: "total_circulars"
      expr: COUNT(1)
      comment: "Total number of circular ads — baseline count for circular production volume and cadence management."
    - name: "total_production_cost"
      expr: SUM(CAST(production_cost_amount AS DOUBLE))
      comment: "Total production cost across all circulars — measures aggregate circular production investment for budget management."
    - name: "avg_production_cost"
      expr: AVG(CAST(production_cost_amount AS DOUBLE))
      comment: "Average production cost per circular — benchmarks production efficiency and identifies cost outliers."
    - name: "total_vendor_funding_amount"
      expr: SUM(CAST(vendor_funding_amount AS DOUBLE))
      comment: "Total vendor funding received for circular production — measures vendor co-investment in circular advertising."
    - name: "avg_vendor_funding_amount"
      expr: AVG(CAST(vendor_funding_amount AS DOUBLE))
      comment: "Average vendor funding per circular — benchmarks vendor co-investment generosity and negotiation outcomes."
    - name: "vendor_funded_circular_count"
      expr: SUM(CASE WHEN is_vendor_funded = TRUE THEN 1 ELSE 0 END)
      comment: "Number of vendor-funded circulars — quantifies vendor co-investment in the circular advertising program."
    - name: "distinct_vendors_in_circulars"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors featured in circulars — measures vendor participation breadth in circular advertising."
$$;