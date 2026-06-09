-- Metric views for domain: promotion | Business: Grocery | Version: 1 | Generated on: 2026-05-04 20:38:05

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`promotion_promo_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for promotional campaigns — budget efficiency, vendor funding leverage, incremental sales targets, and campaign portfolio health. Used by marketing and finance leadership to steer promotional investment decisions."
  source: "`grocery_ecm`.`promotion`.`promo_campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of promotional campaign (e.g. TPR, BOGO, loyalty exclusive) — primary segmentation for campaign performance analysis."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current lifecycle status of the campaign (e.g. active, cancelled, completed) — used to filter live vs. historical performance."
    - name: "campaign_objective"
      expr: campaign_objective
      comment: "Stated business objective of the campaign (e.g. traffic driving, margin improvement, new item launch) — aligns KPIs to strategic intent."
    - name: "target_channel"
      expr: target_channel
      comment: "Channel targeted by the campaign (e.g. in-store, digital, omnichannel) — enables channel-mix analysis of promotional spend."
    - name: "is_loyalty_exclusive"
      expr: is_loyalty_exclusive
      comment: "Flag indicating whether the campaign is restricted to loyalty program members — used to measure loyalty-exclusive promotional investment."
    - name: "is_digital_coupon_enabled"
      expr: is_digital_coupon_enabled
      comment: "Flag indicating whether digital coupons are enabled for this campaign — supports digital vs. traditional promotion mix analysis."
    - name: "effective_start_date"
      expr: DATE_TRUNC('week', effective_start_date)
      comment: "Week-truncated campaign start date — enables time-series trending of campaign launches and promotional calendar density."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month-truncated campaign start date — supports monthly promotional spend and campaign volume reporting."
    - name: "approval_workflow_status"
      expr: approval_workflow_status
      comment: "Current approval workflow state of the campaign — used to track pipeline of pending vs. approved promotional spend."
  measures:
    - name: "total_campaign_budget"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total approved promotional budget across campaigns. Core financial KPI for promotional spend governance and budget utilization tracking."
    - name: "total_vendor_funding_committed"
      expr: SUM(CAST(vendor_funding_amount AS DOUBLE))
      comment: "Total vendor co-funding committed to campaigns. Measures the degree to which promotional costs are offset by supplier contributions — a key P&L lever."
    - name: "total_expected_incremental_sales"
      expr: SUM(CAST(expected_incremental_sales AS DOUBLE))
      comment: "Sum of expected incremental sales lift across all campaigns. Used by merchandising leadership to validate promotional ROI projections before execution."
    - name: "avg_campaign_target_gmroi"
      expr: AVG(CAST(target_gmroi AS DOUBLE))
      comment: "Average targeted Gross Margin Return on Investment across campaigns. Benchmarks whether promotional plans meet minimum margin hurdle rates."
    - name: "total_active_campaigns"
      expr: COUNT(CASE WHEN campaign_status = 'active' THEN promo_campaign_id END)
      comment: "Count of currently active promotional campaigns. Operational KPI for managing promotional calendar density and resource load."
    - name: "vendor_funding_coverage_rate"
      expr: SUM(CAST(vendor_funding_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0)
      comment: "Ratio of vendor funding to total campaign budget. Measures what fraction of promotional spend is supplier-funded — directly impacts net promotional cost to the retailer."
    - name: "avg_budget_per_campaign"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget allocated per campaign. Enables benchmarking of campaign investment levels across types, channels, and time periods."
    - name: "cancelled_campaign_count"
      expr: COUNT(CASE WHEN campaign_status = 'cancelled' THEN promo_campaign_id END)
      comment: "Number of cancelled campaigns. Elevated cancellation rates signal planning inefficiency, supplier disputes, or budget constraints requiring leadership attention."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`promotion_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transaction-level promotional redemption KPIs — discount depth, vendor vs. retailer funding split, personalization effectiveness, and loyalty engagement. Primary operational and financial dashboard for promotion execution performance."
  source: "`grocery_ecm`.`promotion`.`promotion_redemption`"
  dimensions:
    - name: "offer_type"
      expr: offer_type
      comment: "Type of promotional offer redeemed (e.g. digital coupon, TPR, BOGO) — primary dimension for offer-mix analysis."
    - name: "channel"
      expr: channel
      comment: "Redemption channel (e.g. in-store, online, pickup) — enables omnichannel promotional performance comparison."
    - name: "redemption_date"
      expr: redemption_date
      comment: "Date of redemption — used for daily and weekly promotional velocity trending."
    - name: "redemption_week"
      expr: DATE_TRUNC('week', redemption_date)
      comment: "Week-truncated redemption date — supports weekly promotional performance reporting aligned to ad circular cycles."
    - name: "redemption_month"
      expr: DATE_TRUNC('month', redemption_date)
      comment: "Month-truncated redemption date — supports monthly promotional cost and discount reporting."
    - name: "personalized_deal_flag"
      expr: personalized_deal_flag
      comment: "Indicates whether the redemption was driven by a personalized deal — used to measure personalization program lift vs. mass promotions."
    - name: "reimbursement_status"
      expr: reimbursement_status
      comment: "Status of vendor reimbursement for the redemption — used to track outstanding vendor funding receivables."
    - name: "ebt_eligible_flag"
      expr: ebt_eligible_flag
      comment: "Indicates whether the redemption was EBT/SNAP eligible — supports compliance and community access reporting."
    - name: "ad_circular_week"
      expr: ad_circular_week
      comment: "Ad circular week associated with the redemption — aligns redemption performance to specific circular events."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation outcome of the redemption (e.g. valid, rejected, pending) — used to monitor fraud and operational quality."
  measures:
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total promotional discount dollars granted to shoppers. Primary measure of promotional cost exposure — directly impacts gross margin."
    - name: "total_vendor_funded_amount"
      expr: SUM(CAST(vendor_funded_amount AS DOUBLE))
      comment: "Total discount amount funded by vendors. Measures supplier co-investment in promotions — key input to net promotional cost calculation."
    - name: "total_retailer_funded_amount"
      expr: SUM(CAST(retailer_funded_amount AS DOUBLE))
      comment: "Total discount amount funded by the retailer. Represents the net promotional cost borne by the business after vendor offsets."
    - name: "total_redemptions"
      expr: COUNT(promotion_redemption_id)
      comment: "Total number of promotional redemption events. Baseline volume KPI for measuring promotional reach and engagement."
    - name: "unique_shoppers_redeemed"
      expr: COUNT(DISTINCT shopper_id)
      comment: "Number of distinct shoppers who redeemed at least one promotion. Measures promotional reach breadth — a key customer engagement KPI."
    - name: "avg_discount_per_redemption"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount value per redemption event. Measures promotional generosity — used to benchmark discount depth across offer types and channels."
    - name: "vendor_funding_share"
      expr: SUM(CAST(vendor_funded_amount AS DOUBLE)) / NULLIF(SUM(CAST(discount_amount AS DOUBLE)), 0)
      comment: "Proportion of total discount funded by vendors. A ratio above target indicates strong supplier co-investment; below target signals retailer over-exposure on promotional costs."
    - name: "avg_final_price"
      expr: AVG(CAST(final_price AS DOUBLE))
      comment: "Average final transaction price after promotional discounts. Used to assess price competitiveness and the effective price point delivered to shoppers."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average percentage discount applied across redemptions. Measures promotional depth — high values may signal margin risk; low values may indicate insufficient shopper incentive."
    - name: "personalized_redemption_count"
      expr: COUNT(CASE WHEN personalized_deal_flag = TRUE THEN promotion_redemption_id END)
      comment: "Count of redemptions driven by personalized deals. Measures the contribution of personalization programs to overall promotional engagement."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`promotion_vendor_funding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor co-funding performance KPIs — committed vs. received funding, accrual gaps, reconciliation status, and funding rate effectiveness. Used by finance and merchandising to manage supplier funding receivables and trade deal compliance."
  source: "`grocery_ecm`.`promotion`.`vendor_funding`"
  dimensions:
    - name: "funding_type"
      expr: funding_type
      comment: "Type of vendor funding arrangement (e.g. off-invoice, bill-back, scan-back) — primary segmentation for funding structure analysis."
    - name: "funding_status"
      expr: funding_status
      comment: "Current status of the vendor funding agreement (e.g. active, pending, closed) — used to filter actionable vs. historical funding records."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of funding reconciliation (e.g. reconciled, disputed, pending) — key operational dimension for accounts receivable management."
    - name: "payment_method"
      expr: payment_method
      comment: "Method by which vendor funding is received (e.g. check, EFT, credit memo) — used for cash flow and payment operations analysis."
    - name: "funding_rate_unit"
      expr: funding_rate_unit
      comment: "Unit basis for the funding rate (e.g. per unit, per case, percentage of sales) — contextualizes funding rate comparisons across agreements."
    - name: "performance_metric_type"
      expr: performance_metric_type
      comment: "Type of performance metric governing the funding agreement (e.g. units sold, revenue, display compliance) — used to segment performance-based vs. fixed funding."
    - name: "agreement_start_month"
      expr: DATE_TRUNC('month', agreement_start_date)
      comment: "Month-truncated agreement start date — supports cohort analysis of vendor funding agreements by vintage."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the vendor funding agreement is currently active — used to isolate live funding exposure."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the funding agreement — required for multi-currency funding portfolio reporting."
  measures:
    - name: "total_committed_funding"
      expr: SUM(CAST(committed_funding_amount AS DOUBLE))
      comment: "Total vendor funding committed under trade agreements. Represents the gross funding pipeline — a key input to promotional P&L planning."
    - name: "total_received_funding"
      expr: SUM(CAST(received_funding_amount AS DOUBLE))
      comment: "Total vendor funding actually received. Compared against committed funding to identify collection gaps and at-risk receivables."
    - name: "total_accrued_funding"
      expr: SUM(CAST(accrued_funding_amount AS DOUBLE))
      comment: "Total funding accrued based on promotional performance. Used by finance to validate accrual accuracy against received amounts."
    - name: "funding_collection_rate"
      expr: SUM(CAST(received_funding_amount AS DOUBLE)) / NULLIF(SUM(CAST(committed_funding_amount AS DOUBLE)), 0)
      comment: "Ratio of received to committed vendor funding. Values below 1.0 indicate uncollected funding — a direct cash flow and margin risk signal for finance leadership."
    - name: "funding_accrual_gap"
      expr: SUM((CAST(accrued_funding_amount AS DOUBLE)) - (CAST(received_funding_amount AS DOUBLE)))
      comment: "Difference between accrued and received vendor funding. Positive values represent outstanding receivables; negative values may indicate over-accrual requiring adjustment."
    - name: "avg_funding_rate"
      expr: AVG(CAST(funding_rate AS DOUBLE))
      comment: "Average vendor funding rate across agreements. Benchmarks negotiated funding rates — used in supplier negotiations and trade deal benchmarking."
    - name: "avg_actual_performance"
      expr: AVG(CAST(actual_performance AS DOUBLE))
      comment: "Average actual performance metric value across vendor funding agreements. Measures whether promotional performance thresholds are being met to trigger funding."
    - name: "performance_threshold_attainment"
      expr: SUM(CAST(actual_performance AS DOUBLE)) / NULLIF(SUM(CAST(performance_threshold AS DOUBLE)), 0)
      comment: "Ratio of actual performance to required performance threshold across funding agreements. Values below 1.0 indicate at-risk funding that may not be earned."
    - name: "active_funding_agreements"
      expr: COUNT(CASE WHEN is_active = TRUE THEN vendor_funding_id END)
      comment: "Count of currently active vendor funding agreements. Measures the breadth of the active trade funding portfolio."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`promotion_funding_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor funding claim KPIs — claim approval rates, dispute resolution, payment recovery, and funding accuracy. Used by finance and trade relations teams to manage the end-to-end vendor deduction and reimbursement process."
  source: "`grocery_ecm`.`promotion`.`funding_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the funding claim (e.g. submitted, approved, disputed, paid) — primary lifecycle dimension for claim pipeline management."
    - name: "dispute_resolution_status"
      expr: dispute_resolution_status
      comment: "Resolution status of disputed claims — used to track outstanding disputes and their financial exposure."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of claim payment (e.g. check, EFT, credit memo) — used for cash flow and payment operations analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the funding claim — required for multi-currency claim portfolio reporting."
    - name: "vendor_acknowledgment_status"
      expr: vendor_acknowledgment_status
      comment: "Whether the vendor has acknowledged the claim — used to identify claims at risk of dispute or non-payment."
    - name: "claim_period_start_month"
      expr: DATE_TRUNC('month', claim_period_start_date)
      comment: "Month-truncated claim period start — enables monthly claim volume and value trending aligned to promotional periods."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center associated with the funding claim — supports departmental allocation of promotional funding recovery."
  measures:
    - name: "total_claimed_funding"
      expr: SUM(CAST(claimed_funding_amount AS DOUBLE))
      comment: "Total vendor funding claimed across all submissions. Represents gross funding recovery pipeline — a key trade finance KPI."
    - name: "total_approved_funding"
      expr: SUM(CAST(approved_funding_amount AS DOUBLE))
      comment: "Total vendor funding approved for payment. Compared against claimed amounts to measure claim approval efficiency."
    - name: "total_claimed_discount"
      expr: SUM(CAST(claimed_discount_amount AS DOUBLE))
      comment: "Total discount amount submitted for vendor reimbursement. Measures the gross promotional cost being recovered from suppliers."
    - name: "claim_approval_rate"
      expr: SUM(CAST(approved_funding_amount AS DOUBLE)) / NULLIF(SUM(CAST(claimed_funding_amount AS DOUBLE)), 0)
      comment: "Ratio of approved to claimed funding. Low approval rates signal documentation quality issues, contract disputes, or supplier non-compliance — a critical trade finance health metric."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to funding claims. Large adjustment volumes indicate systematic pricing or deduction errors requiring process improvement."
    - name: "total_claimed_units_sold"
      expr: SUM(CAST(claimed_units_sold AS DOUBLE))
      comment: "Total units sold submitted as the basis for vendor funding claims. Used to validate claim accuracy against POS data."
    - name: "avg_approved_funding_per_claim"
      expr: AVG(CAST(approved_funding_amount AS DOUBLE))
      comment: "Average approved funding amount per claim. Benchmarks claim size — used to prioritize high-value claim resolution and resource allocation."
    - name: "disputed_claim_count"
      expr: COUNT(CASE WHEN claim_status = 'disputed' THEN funding_claim_id END)
      comment: "Number of claims currently in dispute. Elevated dispute counts signal supplier relationship issues or documentation gaps requiring escalation."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`promotion_tpr_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Temporary Price Reduction (TPR) event KPIs — discount depth, revenue expectations, vendor funding, and GMROI targets. Used by pricing and merchandising teams to evaluate TPR effectiveness and manage promotional price investment."
  source: "`grocery_ecm`.`promotion`.`tpr_event`"
  dimensions:
    - name: "tpr_status"
      expr: tpr_status
      comment: "Current status of the TPR event (e.g. active, pending, cancelled, completed) — primary lifecycle filter for TPR portfolio management."
    - name: "is_ad_circular_featured"
      expr: is_ad_circular_featured
      comment: "Flag indicating whether the TPR is featured in the ad circular — used to measure the incremental impact of circular support on TPR performance."
    - name: "is_endcap_display"
      expr: is_endcap_display
      comment: "Flag indicating whether the TPR has an endcap display — used to quantify the value of display support in driving TPR lift."
    - name: "is_vendor_funded"
      expr: is_vendor_funded
      comment: "Flag indicating whether the TPR is vendor-funded — used to segment retailer-funded vs. supplier-funded price reductions."
    - name: "markdown_reason_code"
      expr: markdown_reason_code
      comment: "Reason code for the markdown (e.g. competitive response, seasonal clearance, new item intro) — enables root-cause analysis of TPR investment."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the TPR event — required for multi-currency promotional reporting."
    - name: "effective_start_week"
      expr: DATE_TRUNC('week', effective_start_date)
      comment: "Week-truncated TPR effective start date — aligns TPR performance to ad circular weeks for promotional calendar analysis."
    - name: "pos_integration_status"
      expr: pos_integration_status
      comment: "Status of POS system integration for the TPR — used to identify execution failures where price reductions were not activated at the register."
  measures:
    - name: "total_expected_revenue"
      expr: SUM(CAST(expected_revenue_amount AS DOUBLE))
      comment: "Total expected revenue from TPR events. Primary forward-looking financial KPI for promotional revenue planning."
    - name: "total_vendor_funding_amount"
      expr: SUM(CAST(vendor_funding_amount AS DOUBLE))
      comment: "Total vendor funding supporting TPR events. Measures supplier co-investment in price reductions — key input to net TPR cost calculation."
    - name: "avg_discount_depth_percentage"
      expr: AVG(CAST(discount_depth_percentage AS DOUBLE))
      comment: "Average percentage discount depth across TPR events. Measures promotional aggressiveness — high values drive volume but compress margin; used to calibrate discount strategy."
    - name: "avg_tpr_price"
      expr: AVG(CAST(tpr_price_amount AS DOUBLE))
      comment: "Average promoted price point across TPR events. Used to benchmark price competitiveness and validate that TPR prices align with market positioning."
    - name: "avg_original_srp"
      expr: AVG(CAST(original_srp_amount AS DOUBLE))
      comment: "Average standard retail price before TPR discount. Provides baseline for calculating effective discount depth and price gap analysis."
    - name: "avg_target_gmroi"
      expr: AVG(CAST(target_gmroi AS DOUBLE))
      comment: "Average targeted GMROI across TPR events. Validates that TPR plans meet minimum margin return thresholds before execution approval."
    - name: "vendor_funding_per_expected_revenue"
      expr: SUM(CAST(vendor_funding_amount AS DOUBLE)) / NULLIF(SUM(CAST(expected_revenue_amount AS DOUBLE)), 0)
      comment: "Ratio of vendor funding to expected TPR revenue. Measures the degree to which supplier contributions offset the revenue impact of price reductions."
    - name: "active_tpr_event_count"
      expr: COUNT(CASE WHEN tpr_status = 'active' THEN tpr_event_id END)
      comment: "Count of currently active TPR events. Operational KPI for managing promotional price reduction density across the assortment."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`promotion_promo_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotional offer portfolio KPIs — offer economics, discount structure, personalization coverage, and GMROI targets. Used by merchandising and marketing to design and govern the promotional offer mix."
  source: "`grocery_ecm`.`promotion`.`promo_offer`"
  dimensions:
    - name: "offer_type"
      expr: offer_type
      comment: "Type of promotional offer (e.g. percent-off, fixed-amount, BOGO, loyalty points) — primary dimension for offer-mix portfolio analysis."
    - name: "offer_subtype"
      expr: offer_subtype
      comment: "Sub-classification of the offer type — enables granular offer structure analysis within each offer type category."
    - name: "offer_status"
      expr: offer_status
      comment: "Current lifecycle status of the offer (e.g. active, expired, draft) — used to filter the live offer portfolio."
    - name: "discount_type"
      expr: discount_type
      comment: "Mechanism of the discount (e.g. percentage, fixed amount, buy-X-get-Y) — used to analyze discount structure preferences and effectiveness."
    - name: "delivery_channel"
      expr: delivery_channel
      comment: "Channel through which the offer is delivered (e.g. app, email, in-store) — enables channel-level offer performance analysis."
    - name: "personalization_type"
      expr: personalization_type
      comment: "Type of personalization applied to the offer (e.g. ML-targeted, segment-based, mass) — used to measure personalization program coverage and effectiveness."
    - name: "stackable_flag"
      expr: stackable_flag
      comment: "Indicates whether the offer can be stacked with other promotions — used to assess discount stacking risk and margin exposure."
    - name: "manufacturer_coupon_flag"
      expr: manufacturer_coupon_flag
      comment: "Indicates whether the offer is a manufacturer coupon — used to segment manufacturer vs. retailer-funded offer economics."
    - name: "valid_from_month"
      expr: DATE_TRUNC('month', valid_from_date)
      comment: "Month-truncated offer validity start — supports monthly offer launch volume and discount value trending."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of funding for the offer (e.g. vendor, retailer, manufacturer) — primary dimension for promotional cost allocation analysis."
  measures:
    - name: "total_active_offers"
      expr: COUNT(CASE WHEN offer_status = 'active' THEN promo_offer_id END)
      comment: "Count of currently active promotional offers. Measures the breadth of the live promotional offer portfolio — used to manage offer density and shopper experience."
    - name: "avg_discount_value"
      expr: AVG(CAST(discount_value AS DOUBLE))
      comment: "Average discount value across offers. Benchmarks promotional generosity — used to calibrate offer attractiveness vs. margin impact."
    - name: "avg_maximum_discount_amount"
      expr: AVG(CAST(maximum_discount_amount AS DOUBLE))
      comment: "Average maximum discount cap across offers. Used to assess worst-case discount exposure per offer and manage margin risk."
    - name: "avg_minimum_purchase_amount"
      expr: AVG(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Average minimum purchase threshold required to trigger offers. Higher thresholds drive basket size; lower thresholds maximize redemption — a key offer design lever."
    - name: "avg_gmroi_target"
      expr: AVG(CAST(gmroi_target AS DOUBLE))
      comment: "Average GMROI target across promotional offers. Validates that the offer portfolio is designed to meet minimum margin return requirements."
    - name: "personalized_offer_share"
      expr: COUNT(CASE WHEN personalization_type IS NOT NULL AND personalization_type != '' THEN promo_offer_id END) / NULLIF(COUNT(promo_offer_id), 0)
      comment: "Proportion of offers with personalization applied. Measures the penetration of personalization across the offer portfolio — a strategic KPI for 1:1 marketing maturity."
    - name: "stackable_offer_count"
      expr: COUNT(CASE WHEN stackable_flag = TRUE THEN promo_offer_id END)
      comment: "Count of offers that can be stacked with other promotions. Used to quantify discount stacking exposure and manage cumulative margin risk."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`promotion_digital_coupon`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital coupon portfolio KPIs — face value, redemption economics, personalization coverage, loyalty integration, and stackability risk. Used by digital marketing and loyalty teams to optimize digital coupon program performance."
  source: "`grocery_ecm`.`promotion`.`digital_coupon`"
  dimensions:
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount offered by the digital coupon (e.g. percent-off, fixed-amount, BOGO) — primary dimension for coupon economics analysis."
    - name: "clip_status"
      expr: clip_status
      comment: "Whether the coupon has been clipped by the shopper (e.g. clipped, unclipped, expired) — key engagement funnel metric for digital coupon programs."
    - name: "issuing_channel"
      expr: issuing_channel
      comment: "Channel through which the coupon was issued (e.g. app, email, web, in-store kiosk) — used to measure channel effectiveness in coupon distribution."
    - name: "store_eligibility_type"
      expr: store_eligibility_type
      comment: "Scope of store eligibility for the coupon (e.g. all stores, banner-specific, cluster-specific) — used to analyze geographic coverage of digital coupon programs."
    - name: "loyalty_points_eligible_flag"
      expr: loyalty_points_eligible_flag
      comment: "Indicates whether the coupon earns loyalty points — used to measure the integration depth between digital coupons and the loyalty program."
    - name: "manufacturer_funded_flag"
      expr: manufacturer_funded_flag
      comment: "Indicates whether the coupon is manufacturer-funded — used to segment retailer vs. manufacturer coupon economics."
    - name: "stackable_flag"
      expr: stackable_flag
      comment: "Indicates whether the coupon can be stacked with other offers — used to assess cumulative discount risk."
    - name: "personalization_source"
      expr: personalization_source
      comment: "Source of personalization for the coupon (e.g. ML model, segment rule, manual) — used to evaluate personalization program sophistication and coverage."
    - name: "expiration_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month-truncated coupon expiration date — used to forecast coupon liability and plan redemption curve management."
  measures:
    - name: "total_face_value"
      expr: SUM(CAST(face_value AS DOUBLE))
      comment: "Total face value of digital coupons issued. Represents gross promotional liability from the digital coupon program — a key financial exposure metric."
    - name: "avg_face_value"
      expr: AVG(CAST(face_value AS DOUBLE))
      comment: "Average face value per digital coupon. Benchmarks coupon generosity — used to calibrate offer attractiveness vs. cost per redemption."
    - name: "total_maximum_discount_exposure"
      expr: SUM(CAST(maximum_discount_amount AS DOUBLE))
      comment: "Total maximum discount exposure across all digital coupons. Represents worst-case financial liability if all coupons are redeemed at maximum value."
    - name: "avg_minimum_purchase_threshold"
      expr: AVG(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Average minimum purchase amount required to redeem digital coupons. Higher thresholds drive basket size; lower thresholds maximize redemption volume."
    - name: "clipped_coupon_count"
      expr: COUNT(CASE WHEN clip_status = 'clipped' THEN digital_coupon_id END)
      comment: "Number of digital coupons that have been clipped by shoppers. Measures top-of-funnel engagement with the digital coupon program."
    - name: "manufacturer_funded_face_value"
      expr: SUM(CASE WHEN manufacturer_funded_flag = TRUE THEN CAST(face_value AS DOUBLE) ELSE 0 END)
      comment: "Total face value of manufacturer-funded digital coupons. Measures the portion of digital coupon liability offset by manufacturer contributions."
    - name: "loyalty_integrated_coupon_share"
      expr: COUNT(CASE WHEN loyalty_points_eligible_flag = TRUE THEN digital_coupon_id END) / NULLIF(COUNT(digital_coupon_id), 0)
      comment: "Proportion of digital coupons that earn loyalty points. Measures the integration depth between the digital coupon and loyalty programs — a strategic KPI for omnichannel engagement."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`promotion_personalized_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Personalized deal KPIs — deal activation, discount economics, redemption performance, and ML-driven targeting effectiveness. Used by digital marketing and data science teams to measure and optimize the personalization program."
  source: "`grocery_ecm`.`promotion`.`personalized_deal`"
  dimensions:
    - name: "deal_type"
      expr: deal_type
      comment: "Type of personalized deal (e.g. loyalty reward, targeted discount, surprise deal) — primary dimension for personalization program mix analysis."
    - name: "deal_status"
      expr: deal_status
      comment: "Current lifecycle status of the personalized deal (e.g. active, redeemed, expired, cancelled) — used to track deal funnel conversion."
    - name: "delivery_channel"
      expr: delivery_channel
      comment: "Channel through which the personalized deal was delivered (e.g. app push, email, in-store) — used to measure channel effectiveness in personalized offer delivery."
    - name: "generation_source"
      expr: generation_source
      comment: "Source that generated the personalized deal (e.g. ML model, rule engine, manual) — used to compare AI-driven vs. rule-based personalization performance."
    - name: "ml_model_code"
      expr: ml_model_code
      comment: "Identifier of the ML model that generated the deal — used to A/B compare model performance and guide model investment decisions."
    - name: "ab_test_variant"
      expr: ab_test_variant
      comment: "A/B test variant assignment for the deal — used to measure incremental lift from personalization experiments."
    - name: "is_stackable"
      expr: is_stackable
      comment: "Indicates whether the personalized deal can be stacked with other offers — used to assess cumulative discount risk in personalization programs."
    - name: "valid_from_month"
      expr: DATE_TRUNC('month', valid_from_date)
      comment: "Month-truncated deal validity start — supports monthly personalized deal volume and value trending."
  measures:
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value offered through personalized deals. Measures the financial investment in the personalization program."
    - name: "total_actual_discount_applied"
      expr: SUM(CAST(actual_discount_applied AS DOUBLE))
      comment: "Total discount actually applied through redeemed personalized deals. Compared against offered discount to measure redemption efficiency and actual cost."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage offered in personalized deals. Measures personalization program generosity — used to calibrate targeting models for margin-safe discount levels."
    - name: "deal_redemption_rate"
      expr: COUNT(CASE WHEN deal_status = 'redeemed' THEN personalized_deal_id END) / NULLIF(COUNT(personalized_deal_id), 0)
      comment: "Proportion of personalized deals that were redeemed. Primary effectiveness KPI for the personalization program — low rates indicate poor targeting or offer relevance."
    - name: "unique_shoppers_targeted"
      expr: COUNT(DISTINCT shopper_id)
      comment: "Number of distinct shoppers who received personalized deals. Measures the reach of the personalization program across the customer base."
    - name: "avg_maximum_discount_cap"
      expr: AVG(CAST(maximum_discount_amount AS DOUBLE))
      comment: "Average maximum discount cap on personalized deals. Used to assess worst-case discount exposure per deal and manage margin risk in personalization programs."
    - name: "discount_utilization_rate"
      expr: SUM(CAST(actual_discount_applied AS DOUBLE)) / NULLIF(SUM(CAST(discount_amount AS DOUBLE)), 0)
      comment: "Ratio of actual discount applied to total discount offered. Measures how efficiently personalized deal value is being captured — low rates indicate over-generous offers or poor targeting."
$$;