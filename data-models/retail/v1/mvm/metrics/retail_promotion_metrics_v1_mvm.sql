-- Metric views for domain: promotion | Business: Retail | Version: 1 | Generated on: 2026-05-04 13:23:00

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`promotion_promo_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for promotional campaigns — budget deployment, vendor funding, revenue targeting, and campaign portfolio composition. Used by marketing and finance leadership to evaluate campaign investment efficiency and pipeline health."
  source: "`retail_ecm`.`promotion`.`promo_campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of promotional campaign (e.g. seasonal, clearance, loyalty) used to segment campaign performance by strategic intent."
    - name: "campaign_status"
      expr: promo_campaign_status
      comment: "Current lifecycle status of the campaign (e.g. active, planned, closed) enabling pipeline and execution analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow state of the campaign, used to track governance compliance and pending approvals."
    - name: "channel_scope"
      expr: channel_scope
      comment: "Distribution channel(s) targeted by the campaign (e.g. in-store, online, omnichannel) for channel-mix analysis."
    - name: "discount_strategy"
      expr: discount_strategy
      comment: "Discount methodology applied (e.g. percentage off, BOGO, fixed amount) to evaluate promotional mechanics effectiveness."
    - name: "event_classification"
      expr: event_classification
      comment: "Business event driving the campaign (e.g. holiday, back-to-school, clearance) for seasonal performance benchmarking."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic coverage of the campaign (e.g. national, regional, store-specific) for regional performance analysis."
    - name: "vendor_funded_flag"
      expr: vendor_funded_flag
      comment: "Indicates whether the campaign is co-funded by a vendor, enabling vendor investment tracking."
    - name: "loyalty_exclusive_flag"
      expr: loyalty_exclusive_flag
      comment: "Indicates whether the campaign is restricted to loyalty program members, supporting loyalty ROI analysis."
    - name: "digital_promotion_flag"
      expr: digital_promotion_flag
      comment: "Indicates whether the campaign is a digital promotion, enabling digital vs. physical channel comparison."
    - name: "campaign_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the campaign starts, used for time-series trending of campaign launches and spend."
    - name: "priority_level"
      expr: priority_level
      comment: "Business priority tier assigned to the campaign, used to assess resource allocation alignment with strategic priorities."
  measures:
    - name: "total_campaigns"
      expr: COUNT(DISTINCT promo_campaign_id)
      comment: "Total number of distinct promotional campaigns. Baseline volume metric for campaign portfolio sizing and trend analysis."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total promotional budget committed across all campaigns. Core investment metric used by finance and marketing leadership to track spend allocation."
    - name: "total_target_revenue"
      expr: SUM(CAST(target_revenue AS DOUBLE))
      comment: "Sum of revenue targets set across all campaigns. Used to assess the aggregate revenue ambition of the promotional portfolio."
    - name: "avg_campaign_budget"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per campaign. Benchmarks investment level per campaign and identifies over- or under-funded campaigns."
    - name: "avg_target_revenue"
      expr: AVG(CAST(target_revenue AS DOUBLE))
      comment: "Average revenue target per campaign. Used alongside average budget to assess expected return per promotional dollar."
    - name: "vendor_funded_campaign_count"
      expr: COUNT(DISTINCT CASE WHEN vendor_funded_flag = TRUE THEN promo_campaign_id END)
      comment: "Number of campaigns co-funded by vendors. Tracks vendor investment participation and co-marketing program scale."
    - name: "vendor_funded_budget_amount"
      expr: SUM(CASE WHEN vendor_funded_flag = TRUE THEN CAST(budget_amount AS DOUBLE) ELSE 0 END)
      comment: "Total budget for vendor-funded campaigns. Quantifies vendor co-investment in promotional activities, a key supplier relationship metric."
    - name: "loyalty_exclusive_campaign_count"
      expr: COUNT(DISTINCT CASE WHEN loyalty_exclusive_flag = TRUE THEN promo_campaign_id END)
      comment: "Number of campaigns exclusive to loyalty members. Measures the scale of loyalty-driven promotional investment."
    - name: "digital_campaign_count"
      expr: COUNT(DISTINCT CASE WHEN digital_promotion_flag = TRUE THEN promo_campaign_id END)
      comment: "Number of digital promotional campaigns. Tracks digital channel promotional investment and mix shift over time."
    - name: "approved_campaign_count"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'APPROVED' THEN promo_campaign_id END)
      comment: "Number of campaigns that have received formal approval. Governance metric tracking promotional pipeline readiness."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`promotion_promo_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for promotional redemption events — discount value delivered, fraud exposure, channel mix, and redemption throughput. Core metrics for promotion effectiveness measurement and financial liability tracking."
  source: "`retail_ecm`.`promotion`.`promo_redemption`"
  dimensions:
    - name: "redemption_channel"
      expr: redemption_channel
      comment: "Channel through which the promotion was redeemed (e.g. in-store, online, mobile) for channel-level effectiveness analysis."
    - name: "redemption_status"
      expr: redemption_status
      comment: "Outcome status of the redemption event (e.g. successful, failed, reversed) for quality and exception tracking."
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount applied at redemption (e.g. percentage, fixed, BOGO) to analyze promotional mechanic performance."
    - name: "redemption_mechanism"
      expr: redemption_mechanism
      comment: "Method used to redeem the promotion (e.g. coupon scan, promo code, automatic) for operational efficiency analysis."
    - name: "vendor_funded_flag"
      expr: vendor_funded_flag
      comment: "Indicates whether the redeemed promotion was vendor-funded, enabling vendor cost recovery tracking."
    - name: "chargeback_status"
      expr: chargeback_status
      comment: "Status of any chargeback associated with the redemption, used for vendor settlement and financial reconciliation."
    - name: "promotion_tier"
      expr: promotion_tier
      comment: "Tier or priority level of the promotion redeemed, used to analyze redemption distribution across promotional tiers."
    - name: "redemption_month"
      expr: DATE_TRUNC('MONTH', redemption_timestamp)
      comment: "Month of redemption event, used for time-series trending of redemption volume and discount liability."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the redemption was processed, required for multi-currency financial reporting."
    - name: "source_system"
      expr: source_system
      comment: "Originating system that recorded the redemption (e.g. POS, e-commerce platform) for data lineage and reconciliation."
  measures:
    - name: "total_redemptions"
      expr: COUNT(DISTINCT promo_redemption_id)
      comment: "Total number of distinct promotional redemption events. Baseline volume metric for promotion uptake and reach measurement."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value delivered to customers across all redemptions. Primary financial liability metric for promotional spend tracking."
    - name: "total_original_price"
      expr: SUM(CAST(original_price AS DOUBLE))
      comment: "Sum of original (pre-discount) prices across all redemption events. Used as the denominator base for discount rate calculations."
    - name: "total_final_price"
      expr: SUM(CAST(final_price AS DOUBLE))
      comment: "Sum of final (post-discount) prices paid by customers. Represents actual revenue realized after promotional discounts."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount value per redemption event. Benchmarks promotional generosity and identifies outlier discount events."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback value associated with redemptions. Tracks vendor recovery amounts and financial settlement exposure."
    - name: "vendor_funded_discount_amount"
      expr: SUM(CASE WHEN vendor_funded_flag = TRUE THEN CAST(discount_amount AS DOUBLE) ELSE 0 END)
      comment: "Total discount amount funded by vendors. Quantifies vendor co-investment in promotional discounts for P&L attribution."
    - name: "successful_redemption_count"
      expr: COUNT(DISTINCT CASE WHEN redemption_status = 'SUCCESS' THEN promo_redemption_id END)
      comment: "Number of successfully processed redemptions. Used to compute redemption success rate and identify processing failures."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across redemption events. Elevated scores signal promotional abuse risk requiring investigation."
    - name: "high_fraud_risk_redemption_count"
      expr: COUNT(DISTINCT CASE WHEN CAST(fraud_score AS DOUBLE) >= 0.7 THEN promo_redemption_id END)
      comment: "Number of redemptions with fraud score at or above 0.7 threshold. Operational risk metric for fraud intervention prioritization."
    - name: "unique_customers_reached"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct customer profiles that redeemed a promotion. Measures promotional reach and customer engagement breadth."
    - name: "unique_campaigns_redeemed"
      expr: COUNT(DISTINCT promo_campaign_id)
      comment: "Number of distinct campaigns that generated at least one redemption. Tracks active campaign utilization rate."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`promotion_promo_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial governance KPIs for promotional budget management — planned vs. actual spend, vendor funding, channel allocation, and budget variance. Used by finance and marketing leadership for promotional P&L oversight and budget reallocation decisions."
  source: "`retail_ecm`.`promotion`.`promo_budget`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Classification of the budget (e.g. campaign, category, vendor) for budget portfolio segmentation."
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget record (e.g. approved, pending, closed) for governance and pipeline tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow state of the budget, used to track financial governance compliance."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year associated with the budget, enabling year-over-year promotional investment comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (e.g. Q1, P4) for sub-annual budget performance tracking."
    - name: "budget_owner_type"
      expr: budget_owner_type
      comment: "Type of organizational owner responsible for the budget (e.g. category, brand, channel) for accountability reporting."
    - name: "budget_currency_code"
      expr: budget_currency_code
      comment: "Currency of the budget record, required for multi-currency financial consolidation."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the budget period begins, used for time-series analysis of promotional investment deployment."
    - name: "otb_integration_flag"
      expr: otb_integration_flag
      comment: "Indicates whether the budget is integrated with Open-to-Buy planning, linking promotional and merchandise financial planning."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total promotional budget allocated. Primary investment metric for promotional financial planning and executive budget reviews."
    - name: "total_planned_spend"
      expr: SUM(CAST(planned_spend_amount AS DOUBLE))
      comment: "Total planned promotional spend. Used alongside actual spend to measure execution fidelity against plan."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual promotional spend incurred. Core financial metric for promotional P&L and budget consumption tracking."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed (obligated but not yet spent) promotional budget. Tracks financial exposure and remaining spend capacity."
    - name: "total_remaining_budget"
      expr: SUM(CAST(remaining_budget_amount AS DOUBLE))
      comment: "Total remaining unspent promotional budget. Used by finance to identify underspend risk and reallocation opportunities."
    - name: "total_vendor_funded_amount"
      expr: SUM(CAST(vendor_funded_amount AS DOUBLE))
      comment: "Total vendor co-investment in promotional budgets. Measures vendor funding contribution to the promotional P&L."
    - name: "total_circular_ad_allocation"
      expr: SUM(CAST(circular_ad_allocation AS DOUBLE))
      comment: "Total budget allocated to circular/print advertising. Tracks traditional media investment within the promotional mix."
    - name: "total_mobile_channel_allocation"
      expr: SUM(CAST(mobile_channel_allocation AS DOUBLE))
      comment: "Total budget allocated to mobile channel promotions. Tracks digital/mobile investment growth within the promotional mix."
    - name: "total_pos_channel_allocation"
      expr: SUM(CAST(pos_channel_allocation AS DOUBLE))
      comment: "Total budget allocated to POS channel promotions. Tracks in-store promotional investment within the channel mix."
    - name: "avg_variance_threshold_percent"
      expr: AVG(CAST(variance_threshold_percent AS DOUBLE))
      comment: "Average variance tolerance percentage set across budgets. Indicates the organization's financial control tightness for promotional spend."
    - name: "budget_count"
      expr: COUNT(DISTINCT promo_budget_id)
      comment: "Total number of distinct promotional budget records. Used to assess budget fragmentation and governance overhead."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`promotion_promo_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Offer portfolio KPIs covering discount value, vendor cost-sharing, personalization, and offer lifecycle management. Used by merchandising and marketing teams to optimize offer design, cost structure, and customer targeting."
  source: "`retail_ecm`.`promotion`.`promo_offer`"
  dimensions:
    - name: "offer_type"
      expr: offer_type
      comment: "Type of promotional offer (e.g. percentage discount, free shipping, BOGO) for offer mechanic performance analysis."
    - name: "offer_status"
      expr: offer_status
      comment: "Current lifecycle status of the offer (e.g. active, expired, draft) for offer portfolio health monitoring."
    - name: "discount_method"
      expr: discount_method
      comment: "Method by which the discount is applied (e.g. automatic, coupon, loyalty) for operational efficiency analysis."
    - name: "channel_eligibility"
      expr: channel_eligibility
      comment: "Channels where the offer is valid (e.g. in-store, online) for channel-specific offer performance analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow state of the offer, used to track governance compliance and pending offer activations."
    - name: "vendor_funded_flag"
      expr: vendor_funded_flag
      comment: "Indicates whether the offer is co-funded by a vendor, enabling vendor investment attribution."
    - name: "personalization_flag"
      expr: personalization_flag
      comment: "Indicates whether the offer is personalized to individual customers, tracking personalization program scale."
    - name: "stackable_flag"
      expr: stackable_flag
      comment: "Indicates whether the offer can be combined with other promotions, used to assess discount stacking risk."
    - name: "digital_delivery_flag"
      expr: digital_delivery_flag
      comment: "Indicates whether the offer is delivered digitally, tracking digital offer adoption and channel shift."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the offer becomes effective, used for time-series analysis of offer launches and discount exposure."
    - name: "offer_priority"
      expr: offer_priority
      comment: "Priority ranking of the offer for conflict resolution and promotional hierarchy management."
  measures:
    - name: "total_offers"
      expr: COUNT(DISTINCT promo_offer_id)
      comment: "Total number of distinct promotional offers in the portfolio. Baseline metric for offer catalog size and complexity management."
    - name: "total_discount_value"
      expr: SUM(CAST(discount_value AS DOUBLE))
      comment: "Sum of discount values across all offers. Represents the total potential discount liability in the offer portfolio."
    - name: "avg_discount_value"
      expr: AVG(CAST(discount_value AS DOUBLE))
      comment: "Average discount value per offer. Benchmarks offer generosity and identifies outlier high-value offers."
    - name: "total_minimum_purchase_amount"
      expr: SUM(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Sum of minimum purchase thresholds across offers. Indicates the aggregate basket-size requirement built into the offer portfolio."
    - name: "avg_minimum_purchase_amount"
      expr: AVG(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Average minimum purchase threshold per offer. Used to assess whether offer entry barriers align with target basket size strategy."
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average vendor cost-share percentage across offers. Measures the degree to which vendors subsidize promotional discounts."
    - name: "vendor_funded_offer_count"
      expr: COUNT(DISTINCT CASE WHEN vendor_funded_flag = TRUE THEN promo_offer_id END)
      comment: "Number of vendor-funded offers. Tracks vendor co-investment participation in the offer portfolio."
    - name: "personalized_offer_count"
      expr: COUNT(DISTINCT CASE WHEN personalization_flag = TRUE THEN promo_offer_id END)
      comment: "Number of personalized offers. Measures the scale of 1:1 marketing investment and personalization program maturity."
    - name: "stackable_offer_count"
      expr: COUNT(DISTINCT CASE WHEN stackable_flag = TRUE THEN promo_offer_id END)
      comment: "Number of offers that can be stacked with other promotions. Quantifies discount stacking exposure and margin risk."
    - name: "active_offer_count"
      expr: COUNT(DISTINCT CASE WHEN offer_status = 'ACTIVE' THEN promo_offer_id END)
      comment: "Number of currently active offers. Tracks live promotional exposure and offer portfolio activation rate."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`promotion_vendor_promo_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor promotional funding KPIs covering agreement value, accrual vs. settlement gaps, chargeback exposure, and funding performance. Used by finance and merchandising leadership to manage vendor trade fund compliance and recover promotional co-investment."
  source: "`retail_ecm`.`promotion`.`vendor_promo_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of vendor promotional agreement (e.g. scan-back, off-invoice, bill-back) for trade fund structure analysis."
    - name: "vendor_promo_agreement_status"
      expr: vendor_promo_agreement_status
      comment: "Current status of the agreement (e.g. active, expired, terminated) for portfolio health and compliance monitoring."
    - name: "accrual_method"
      expr: accrual_method
      comment: "Method used to accrue vendor funding (e.g. scan-based, fixed, percentage) for financial accounting classification."
    - name: "settlement_frequency"
      expr: settlement_frequency
      comment: "How often vendor funding is settled (e.g. monthly, quarterly) for cash flow and receivables management."
    - name: "chargeback_eligible"
      expr: chargeback_eligible
      comment: "Indicates whether the agreement allows chargebacks for non-compliance, used to assess recovery leverage."
    - name: "funding_currency_code"
      expr: funding_currency_code
      comment: "Currency of the vendor funding agreement, required for multi-currency financial consolidation."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the agreement becomes effective, used for time-series analysis of vendor funding commitments."
    - name: "ad_placement_required"
      expr: ad_placement_required
      comment: "Indicates whether the vendor requires ad placement as a performance obligation, tracking compliance requirements."
    - name: "display_compliance_required"
      expr: display_compliance_required
      comment: "Indicates whether display compliance is a condition of vendor funding, used for compliance risk assessment."
  measures:
    - name: "total_agreements"
      expr: COUNT(DISTINCT vendor_promo_agreement_id)
      comment: "Total number of distinct vendor promotional agreements. Baseline metric for vendor trade fund program scale."
    - name: "total_funding_amount"
      expr: SUM(CAST(funding_amount AS DOUBLE))
      comment: "Total vendor funding committed across all agreements. Primary metric for vendor co-investment in promotional activities."
    - name: "total_accrued_amount"
      expr: SUM(CAST(total_accrued_amount AS DOUBLE))
      comment: "Total vendor funding accrued to date. Tracks the financial liability recognized from vendor promotional agreements."
    - name: "total_settled_amount"
      expr: SUM(CAST(total_settled_amount AS DOUBLE))
      comment: "Total vendor funding that has been settled (cash received or credited). Measures actual vendor co-investment recovery."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding (accrued but unsettled) vendor funding balance. Key receivables metric for trade fund cash flow management."
    - name: "total_chargeback_penalty_amount"
      expr: SUM(CAST(chargeback_penalty_amount AS DOUBLE))
      comment: "Total chargeback penalties assessed against vendors for non-compliance. Measures enforcement activity and compliance cost recovery."
    - name: "avg_funding_percentage"
      expr: AVG(CAST(funding_percentage AS DOUBLE))
      comment: "Average vendor funding percentage across agreements. Benchmarks vendor co-investment rate and negotiation outcomes."
    - name: "avg_minimum_purchase_amount"
      expr: AVG(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Average minimum purchase threshold required to trigger vendor funding. Assesses vendor funding accessibility and volume requirements."
    - name: "chargeback_eligible_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN chargeback_eligible = TRUE THEN vendor_promo_agreement_id END)
      comment: "Number of agreements with chargeback provisions. Quantifies the organization's contractual leverage for vendor compliance enforcement."
    - name: "active_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN vendor_promo_agreement_status = 'ACTIVE' THEN vendor_promo_agreement_id END)
      comment: "Number of currently active vendor promotional agreements. Tracks live vendor funding commitments and program scale."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`promotion_rebate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rebate program KPIs covering rebate value, vendor funding, budget utilization, and program portfolio composition. Used by finance and category management to evaluate rebate program ROI, vendor contribution, and customer incentive effectiveness."
  source: "`retail_ecm`.`promotion`.`rebate`"
  dimensions:
    - name: "rebate_type"
      expr: rebate_type
      comment: "Type of rebate (e.g. mail-in, instant, vendor-funded) for program structure and cost analysis."
    - name: "rebate_status"
      expr: rebate_status
      comment: "Current lifecycle status of the rebate (e.g. active, expired, pending) for portfolio health monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow state of the rebate, used to track governance compliance and pending activations."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to pay the rebate to customers (e.g. check, credit, gift card) for operational cost analysis."
    - name: "channel_eligibility"
      expr: channel_eligibility
      comment: "Channels where the rebate is valid (e.g. in-store, online) for channel-specific rebate performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rebate, required for multi-currency financial reporting."
    - name: "stackable_with_other_promotions"
      expr: stackable_with_other_promotions
      comment: "Indicates whether the rebate can be combined with other promotions, used to assess discount stacking risk."
    - name: "requires_proof_of_purchase"
      expr: requires_proof_of_purchase
      comment: "Indicates whether proof of purchase is required for rebate redemption, affecting redemption friction and fraud risk."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the rebate becomes effective, used for time-series analysis of rebate program launches."
    - name: "geographic_eligibility"
      expr: geographic_eligibility
      comment: "Geographic scope of rebate eligibility, used for regional rebate program performance analysis."
  measures:
    - name: "total_rebates"
      expr: COUNT(DISTINCT rebate_id)
      comment: "Total number of distinct rebate programs. Baseline metric for rebate portfolio scale and complexity."
    - name: "total_rebate_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total rebate value across all programs. Primary financial metric for rebate liability and customer incentive investment."
    - name: "avg_rebate_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average rebate value per program. Benchmarks rebate generosity and identifies outlier high-value programs."
    - name: "total_rebate_budget"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total budget allocated to rebate programs. Used to assess rebate investment scale and budget adequacy."
    - name: "total_maximum_rebate_amount"
      expr: SUM(CAST(maximum_rebate_amount AS DOUBLE))
      comment: "Sum of maximum rebate caps across all programs. Represents the ceiling of total rebate liability exposure."
    - name: "avg_vendor_funding_percentage"
      expr: AVG(CAST(vendor_funding_percentage AS DOUBLE))
      comment: "Average percentage of rebate cost funded by vendors. Measures vendor co-investment rate in rebate programs."
    - name: "avg_rebate_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average rebate percentage offered to customers. Benchmarks rebate incentive level and competitive positioning."
    - name: "avg_minimum_purchase_amount"
      expr: AVG(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Average minimum purchase required to qualify for a rebate. Assesses basket-size incentive alignment with category strategy."
    - name: "active_rebate_count"
      expr: COUNT(DISTINCT CASE WHEN rebate_status = 'ACTIVE' THEN rebate_id END)
      comment: "Number of currently active rebate programs. Tracks live rebate exposure and program activation rate."
    - name: "stackable_rebate_count"
      expr: COUNT(DISTINCT CASE WHEN stackable_with_other_promotions = TRUE THEN rebate_id END)
      comment: "Number of rebates that can be stacked with other promotions. Quantifies discount stacking exposure and margin risk."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`promotion_coupon`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coupon program KPIs covering face value, discount structure, distribution reach, and digital adoption. Used by marketing and finance to evaluate coupon investment, redemption economics, and channel distribution effectiveness."
  source: "`retail_ecm`.`promotion`.`coupon`"
  dimensions:
    - name: "coupon_type"
      expr: coupon_type
      comment: "Type of coupon (e.g. manufacturer, store, digital, paper) for coupon portfolio structure analysis."
    - name: "coupon_status"
      expr: coupon_status
      comment: "Current lifecycle status of the coupon (e.g. active, expired, redeemed) for portfolio health monitoring."
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount the coupon provides (e.g. percentage off, fixed amount) for discount mechanic analysis."
    - name: "issue_channel"
      expr: issue_channel
      comment: "Channel through which the coupon was distributed (e.g. email, in-store, app) for distribution effectiveness analysis."
    - name: "eligible_channel"
      expr: eligible_channel
      comment: "Channel(s) where the coupon can be redeemed, used for channel-specific coupon strategy analysis."
    - name: "digital_wallet_enabled_flag"
      expr: digital_wallet_enabled_flag
      comment: "Indicates whether the coupon is enabled for digital wallet storage, tracking digital adoption of coupon programs."
    - name: "single_use_flag"
      expr: single_use_flag
      comment: "Indicates whether the coupon is single-use, used to assess coupon scarcity and fraud risk profile."
    - name: "stackable_flag"
      expr: stackable_flag
      comment: "Indicates whether the coupon can be combined with other promotions, used to assess discount stacking risk."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the coupon was issued, used for time-series analysis of coupon distribution volume and face value."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the coupon face value, required for multi-currency financial reporting."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Entity that issued the coupon (e.g. retailer, manufacturer, third-party) for cost attribution and liability tracking."
  measures:
    - name: "total_coupons_issued"
      expr: COUNT(DISTINCT coupon_id)
      comment: "Total number of distinct coupons issued. Baseline metric for coupon program scale and distribution reach."
    - name: "total_face_value"
      expr: SUM(CAST(face_value AS DOUBLE))
      comment: "Total face value of all issued coupons. Represents the maximum potential discount liability from the coupon portfolio."
    - name: "avg_face_value"
      expr: AVG(CAST(face_value AS DOUBLE))
      comment: "Average face value per coupon. Benchmarks coupon generosity and competitive incentive positioning."
    - name: "total_maximum_discount_amount"
      expr: SUM(CAST(maximum_discount_amount AS DOUBLE))
      comment: "Sum of maximum discount caps across all coupons. Represents the capped discount liability ceiling for the coupon portfolio."
    - name: "avg_minimum_purchase_amount"
      expr: AVG(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Average minimum purchase threshold required to use a coupon. Assesses basket-size incentive alignment with revenue strategy."
    - name: "digital_wallet_enabled_coupon_count"
      expr: COUNT(DISTINCT CASE WHEN digital_wallet_enabled_flag = TRUE THEN coupon_id END)
      comment: "Number of coupons enabled for digital wallet storage. Tracks digital coupon adoption and mobile engagement scale."
    - name: "single_use_coupon_count"
      expr: COUNT(DISTINCT CASE WHEN single_use_flag = TRUE THEN coupon_id END)
      comment: "Number of single-use coupons issued. Used to assess coupon scarcity strategy and fraud exposure from multi-use coupons."
    - name: "stackable_coupon_count"
      expr: COUNT(DISTINCT CASE WHEN stackable_flag = TRUE THEN coupon_id END)
      comment: "Number of coupons that can be stacked with other promotions. Quantifies discount stacking exposure and margin risk."
    - name: "avg_maximum_discount_amount"
      expr: AVG(CAST(maximum_discount_amount AS DOUBLE))
      comment: "Average maximum discount cap per coupon. Used to assess the upper bound of per-transaction discount exposure."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`promotion_promo_calendar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotional calendar planning KPIs covering expected sales lift, traffic lift, budget allocation, and planning pipeline health. Used by marketing and merchandising leadership to evaluate promotional event planning quality and expected business impact."
  source: "`retail_ecm`.`promotion`.`promo_calendar`"
  dimensions:
    - name: "period_type"
      expr: period_type
      comment: "Type of promotional calendar period (e.g. weekly, event, seasonal) for planning cadence analysis."
    - name: "planning_status"
      expr: planning_status
      comment: "Current planning workflow status (e.g. draft, approved, locked) for pipeline readiness tracking."
    - name: "priority_tier"
      expr: priority_tier
      comment: "Strategic priority tier of the promotional period, used to assess resource allocation alignment."
    - name: "channel_applicability"
      expr: channel_applicability
      comment: "Channels covered by the promotional calendar period (e.g. in-store, online) for channel planning analysis."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the promotional calendar period is currently active, used to filter live vs. historical periods."
    - name: "is_blackout_period"
      expr: is_blackout_period
      comment: "Indicates whether the period is a promotional blackout, used to track planning constraints and restricted windows."
    - name: "competitive_response_flag"
      expr: competitive_response_flag
      comment: "Indicates whether the promotional period is a competitive response event, tracking reactive vs. planned promotions."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Indicates whether the period requires formal approval, used for governance compliance tracking."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the promotional period begins, used for time-series analysis of promotional calendar density and investment."
    - name: "banner_applicability"
      expr: banner_applicability
      comment: "Retail banners covered by the promotional period, used for banner-level promotional planning analysis."
  measures:
    - name: "total_calendar_periods"
      expr: COUNT(DISTINCT promo_calendar_id)
      comment: "Total number of distinct promotional calendar periods. Baseline metric for promotional event density and planning volume."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated across all promotional calendar periods. Tracks planned promotional investment by time period."
    - name: "avg_budget_amount"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per promotional calendar period. Benchmarks investment level per event and identifies over- or under-funded periods."
    - name: "avg_expected_sales_lift_pct"
      expr: AVG(CAST(expected_sales_lift_pct AS DOUBLE))
      comment: "Average expected sales lift percentage across promotional periods. Key planning metric for revenue impact forecasting."
    - name: "avg_expected_traffic_lift_pct"
      expr: AVG(CAST(expected_traffic_lift_pct AS DOUBLE))
      comment: "Average expected traffic lift percentage across promotional periods. Used to forecast footfall and digital visit impact of promotions."
    - name: "blackout_period_count"
      expr: COUNT(DISTINCT CASE WHEN is_blackout_period = TRUE THEN promo_calendar_id END)
      comment: "Number of blackout periods in the promotional calendar. Tracks planning constraints and restricted promotional windows."
    - name: "competitive_response_period_count"
      expr: COUNT(DISTINCT CASE WHEN competitive_response_flag = TRUE THEN promo_calendar_id END)
      comment: "Number of promotional periods triggered by competitive response. Measures reactive promotional activity vs. planned strategy."
    - name: "approved_period_count"
      expr: COUNT(DISTINCT CASE WHEN planning_status = 'APPROVED' THEN promo_calendar_id END)
      comment: "Number of promotional calendar periods with approved status. Tracks planning pipeline readiness and governance compliance."
    - name: "total_expected_sales_lift_pct"
      expr: SUM(CAST(expected_sales_lift_pct AS DOUBLE))
      comment: "Sum of expected sales lift percentages across all periods. Used as a portfolio-level indicator of total promotional revenue ambition."
$$;