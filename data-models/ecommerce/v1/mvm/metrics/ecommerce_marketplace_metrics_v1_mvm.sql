-- Metric views for domain: marketplace | Business: Ecommerce | Version: 1 | Generated on: 2026-05-05 00:54:17

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`marketplace_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core marketplace transaction KPIs covering GMV, commission revenue, seller payouts, refund rates, fraud exposure, and sponsored-listing monetisation. This is the primary fact table for marketplace financial performance."
  source: "`ecommerce_ecm`.`marketplace`.`marketplace_transaction`"
  filter: transaction_status != 'CANCELLED'
  dimensions:
    - name: "transaction_date"
      expr: DATE_TRUNC('DAY', transaction_timestamp)
      comment: "Calendar day the transaction occurred — primary time grain for daily GMV and revenue trending."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Calendar month of the transaction — used for monthly GMV roll-ups and period-over-period comparisons."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of marketplace transaction (e.g. SALE, REFUND, ADJUSTMENT) — segments revenue streams."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the transaction (e.g. COMPLETED, PENDING, DISPUTED) — used to filter healthy vs. problematic transactions."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfillment method (e.g. FBA, FBM, DROP_SHIP) — key operational dimension for cost and SLA analysis."
    - name: "product_category"
      expr: product_category
      comment: "Product category of the transacted item — enables category-level GMV and commission analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the transaction was denominated — required for multi-currency marketplace reporting."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Payment channel used (e.g. CARD, WALLET, BNPL) — informs payment mix and risk exposure."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Dispute status on the transaction — used to isolate disputed GMV and commission at risk."
    - name: "fraud_review_status"
      expr: fraud_review_status
      comment: "Fraud review outcome for the transaction — critical for risk-adjusted revenue reporting."
    - name: "is_sponsored_listing"
      expr: is_sponsored_listing
      comment: "Flag indicating whether the transaction originated from a sponsored listing — separates organic vs. paid monetisation."
    - name: "buy_box_winner_flag"
      expr: buy_box_winner_flag
      comment: "Whether the winning offer held the buy box — measures buy-box influence on conversion and GMV."
  measures:
    - name: "total_gmv"
      expr: SUM(CAST(gmv_amount AS DOUBLE))
      comment: "Gross Merchandise Value — total value of all goods sold through the marketplace before deductions. Primary top-line health metric."
    - name: "total_marketplace_commission"
      expr: SUM(CAST(marketplace_commission_amount AS DOUBLE))
      comment: "Total commission revenue earned by the marketplace across all transactions. Core marketplace monetisation KPI."
    - name: "total_seller_payout"
      expr: SUM(CAST(seller_payout_amount AS DOUBLE))
      comment: "Total amount disbursed to sellers after commission and fee deductions. Measures marketplace cash-out obligations."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total value of refunds issued. High refund volume signals product quality, fulfilment, or fraud issues."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across transactions — required for tax compliance and remittance reporting."
    - name: "total_shipping_revenue"
      expr: SUM(CAST(shipping_amount AS DOUBLE))
      comment: "Total shipping charges collected — informs logistics cost coverage and shipping P&L."
    - name: "total_item_subtotal"
      expr: SUM(CAST(item_subtotal_amount AS DOUBLE))
      comment: "Sum of item subtotals before tax and shipping — used to compute net merchandise revenue."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_percent AS DOUBLE))
      comment: "Average commission rate applied across transactions. Tracks monetisation yield and rate consistency across categories and sellers."
    - name: "avg_gmv_per_transaction"
      expr: AVG(CAST(gmv_amount AS DOUBLE))
      comment: "Average GMV per transaction — proxy for average order value at the marketplace level. Tracks basket size trends."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across transactions. Rising average signals deteriorating transaction quality and increased chargeback risk."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of marketplace transactions. Baseline volume metric for throughput and growth rate analysis."
    - name: "distinct_seller_count"
      expr: COUNT(DISTINCT seller_profile_id)
      comment: "Number of unique sellers with transactions in the period. Measures seller ecosystem breadth and activity."
    - name: "disputed_transaction_count"
      expr: COUNT(CASE WHEN dispute_status IS NOT NULL AND dispute_status != 'NONE' THEN 1 END)
      comment: "Number of transactions with an active or resolved dispute. Tracks dispute volume as a marketplace trust and quality signal."
    - name: "sponsored_transaction_count"
      expr: COUNT(CASE WHEN is_sponsored_listing = TRUE THEN 1 END)
      comment: "Number of transactions originating from sponsored listings. Measures paid-placement monetisation volume."
    - name: "buy_box_transaction_count"
      expr: COUNT(CASE WHEN buy_box_winner_flag = TRUE THEN 1 END)
      comment: "Number of transactions where the seller held the buy box. Quantifies buy-box influence on sales conversion."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`marketplace_seller_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Seller settlement and disbursement KPIs covering gross sales, net payouts, commission deductions, refund deductions, and promotional credits. Drives seller financial health monitoring and accounts-payable governance."
  source: "`ecommerce_ecm`.`marketplace`.`seller_settlement`"
  dimensions:
    - name: "settlement_month"
      expr: DATE_TRUNC('MONTH', settlement_start_date)
      comment: "Month in which the settlement period begins — primary time grain for monthly payout reporting."
    - name: "settlement_cycle"
      expr: settlement_cycle
      comment: "Frequency of the settlement cycle (e.g. WEEKLY, BIWEEKLY, MONTHLY) — used to analyse payout cadence and cash-flow patterns."
    - name: "settlement_type"
      expr: settlement_type
      comment: "Type of settlement (e.g. STANDARD, ADJUSTMENT, PROMOTIONAL) — segments routine vs. exceptional disbursements."
    - name: "disbursement_status"
      expr: disbursement_status
      comment: "Current disbursement status (e.g. PENDING, COMPLETED, FAILED) — critical for accounts-payable monitoring and seller escalation."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for disbursement (e.g. ACH, WIRE, PAYPAL) — informs payment rail mix and failure risk."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which the settlement payment was made — used for reconciliation and channel cost analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the settlement — required for multi-currency payout reconciliation."
  measures:
    - name: "total_gross_sales"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales amount across all settlements. Top-line seller revenue before any deductions — key marketplace GMV reconciliation metric."
    - name: "total_net_disbursement"
      expr: SUM(CAST(net_disbursement_amount AS DOUBLE))
      comment: "Total net amount actually disbursed to sellers after all deductions. Primary cash-out KPI for accounts-payable and treasury."
    - name: "total_commission_deducted"
      expr: SUM(CAST(total_commission_amount AS DOUBLE))
      comment: "Total commission amounts deducted from seller settlements. Reconciles marketplace commission revenue against transaction-level records."
    - name: "total_refund_deductions"
      expr: SUM(CAST(refund_deductions_amount AS DOUBLE))
      comment: "Total refund amounts clawed back from seller settlements. High values indicate elevated return rates or fraud impacting seller payouts."
    - name: "total_fee_adjustments"
      expr: SUM(CAST(fee_adjustments_amount AS DOUBLE))
      comment: "Total fee adjustments applied to settlements (credits or debits). Tracks billing corrections and dispute resolutions affecting seller payouts."
    - name: "total_promotional_credits"
      expr: SUM(CAST(promotional_credits_amount AS DOUBLE))
      comment: "Total promotional credits applied to seller settlements. Measures the cost of seller-facing promotional programmes."
    - name: "total_tax_withheld"
      expr: SUM(CAST(tax_withheld_amount AS DOUBLE))
      comment: "Total tax withheld from seller settlements. Required for tax compliance reporting and remittance reconciliation."
    - name: "avg_net_disbursement_per_settlement"
      expr: AVG(CAST(net_disbursement_amount AS DOUBLE))
      comment: "Average net disbursement per settlement record. Tracks typical seller payout size and detects anomalous settlement amounts."
    - name: "settlement_count"
      expr: COUNT(1)
      comment: "Total number of settlement records processed. Baseline volume metric for settlement throughput and operational load."
    - name: "distinct_seller_settlement_count"
      expr: COUNT(DISTINCT seller_profile_id)
      comment: "Number of unique sellers receiving settlements in the period. Measures active seller payout breadth."
    - name: "pending_disbursement_count"
      expr: COUNT(CASE WHEN disbursement_status = 'PENDING' THEN 1 END)
      comment: "Number of settlements still in PENDING status. Elevated counts signal processing backlogs or payment failures requiring intervention."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`marketplace_listing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketplace listing health and catalogue quality KPIs covering listing volume, visibility, buy-box eligibility, pricing, ratings, and fulfilment type mix. Drives catalogue management and seller onboarding decisions."
  source: "`ecommerce_ecm`.`marketplace`.`marketplace_listing`"
  dimensions:
    - name: "listing_status"
      expr: marketplace_listing_status
      comment: "Current status of the listing (e.g. ACTIVE, SUPPRESSED, INACTIVE) — primary filter for active catalogue health."
    - name: "listing_type"
      expr: listing_type
      comment: "Type of listing (e.g. STANDARD, BUNDLE, VARIATION) — segments catalogue structure for assortment analysis."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfilment method for the listing (e.g. FBA, FBM) — key dimension for cost, SLA, and Prime eligibility analysis."
    - name: "condition"
      expr: condition
      comment: "Item condition (e.g. NEW, USED, REFURBISHED) — segments catalogue by product quality tier."
    - name: "listing_source"
      expr: listing_source
      comment: "Origin of the listing (e.g. SELLER_UPLOAD, API, BULK_IMPORT) — informs catalogue onboarding channel mix."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the listed price — required for multi-currency catalogue pricing analysis."
    - name: "listing_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month the listing went live — used for new-listing cohort analysis and catalogue growth trending."
    - name: "is_visible"
      expr: is_visible
      comment: "Whether the listing is currently visible to buyers — used to measure suppression rates and catalogue availability."
    - name: "buy_box_eligible"
      expr: buy_box_eligible
      comment: "Whether the listing is eligible to win the buy box — key quality gate for seller competitiveness."
    - name: "featured"
      expr: featured
      comment: "Whether the listing is featured/promoted on the marketplace — measures editorial and paid placement coverage."
  measures:
    - name: "total_listing_count"
      expr: COUNT(1)
      comment: "Total number of marketplace listings. Baseline catalogue size metric — tracks assortment breadth and growth."
    - name: "active_listing_count"
      expr: COUNT(CASE WHEN marketplace_listing_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active listings. Measures live catalogue depth available to buyers."
    - name: "buy_box_eligible_listing_count"
      expr: COUNT(CASE WHEN buy_box_eligible = TRUE THEN 1 END)
      comment: "Number of listings eligible for the buy box. Tracks catalogue quality and seller compliance with buy-box criteria."
    - name: "visible_listing_count"
      expr: COUNT(CASE WHEN is_visible = TRUE THEN 1 END)
      comment: "Number of listings visible to buyers. Suppression rate = 1 - (visible / total) — a key catalogue health KPI."
    - name: "avg_listing_price"
      expr: AVG(CAST(price AS DOUBLE))
      comment: "Average listed price across the catalogue. Tracks price positioning and detects anomalous pricing events."
    - name: "avg_rating"
      expr: AVG(CAST(rating_average AS DOUBLE))
      comment: "Average buyer rating across listings. Directly linked to conversion rate and catalogue trust — a key quality KPI."
    - name: "total_review_count"
      expr: SUM(CAST(review_count AS DOUBLE))
      comment: "Total number of buyer reviews across all listings. Measures social proof depth and catalogue engagement."
    - name: "avg_review_count_per_listing"
      expr: AVG(CAST(review_count AS DOUBLE))
      comment: "Average number of reviews per listing. Low averages indicate thin social proof, which suppresses conversion."
    - name: "distinct_seller_listing_count"
      expr: COUNT(DISTINCT seller_profile_id)
      comment: "Number of unique sellers with active listings. Measures seller ecosystem breadth contributing to catalogue."
    - name: "avg_shipping_weight_kg"
      expr: AVG(CAST(shipping_weight_kg AS DOUBLE))
      comment: "Average shipping weight of listed items. Informs logistics cost modelling and carrier rate negotiations."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`marketplace_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketplace dispute resolution KPIs covering dispute volume, financial exposure, SLA compliance, fraud flags, escalation rates, and resolution outcomes. Drives trust & safety and customer experience governance."
  source: "`ecommerce_ecm`.`marketplace`.`dispute`"
  dimensions:
    - name: "dispute_type"
      expr: dispute_type
      comment: "Category of dispute (e.g. ITEM_NOT_RECEIVED, NOT_AS_DESCRIBED, FRAUD) — segments dispute root causes for targeted remediation."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (e.g. OPEN, RESOLVED, ESCALATED) — primary operational filter for workload management."
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Final outcome of the dispute (e.g. BUYER_WIN, SELLER_WIN, SPLIT) — measures fairness and policy effectiveness."
    - name: "dispute_source"
      expr: dispute_source
      comment: "Channel through which the dispute was filed (e.g. BUYER_PORTAL, CHARGEBACK, PHONE) — informs channel-specific resolution strategies."
    - name: "communication_channel"
      expr: communication_channel
      comment: "Communication channel used during dispute handling — used to optimise agent routing and resolution speed."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the dispute (e.g. HIGH, MEDIUM, LOW) — drives SLA tier assignment and escalation thresholds."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardised reason code for the dispute — enables Pareto analysis of dispute drivers."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the disputed amounts — required for multi-currency financial exposure reporting."
    - name: "dispute_filed_month"
      expr: DATE_TRUNC('MONTH', filed_timestamp)
      comment: "Month the dispute was filed — primary time grain for dispute volume trending and SLA cohort analysis."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the dispute was escalated beyond first-line resolution — measures escalation rate and agent effectiveness."
    - name: "is_fraud_flag"
      expr: is_fraud_flag
      comment: "Whether the dispute was flagged as potentially fraudulent — isolates fraud-driven dispute exposure."
    - name: "sla_compliance"
      expr: sla_compliance
      comment: "Whether the dispute was resolved within the SLA target — primary SLA performance dimension."
  measures:
    - name: "total_dispute_count"
      expr: COUNT(1)
      comment: "Total number of disputes filed. Baseline volume metric — rising dispute counts signal deteriorating marketplace trust or seller quality."
    - name: "total_gross_dispute_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross financial value of all disputes. Measures total GMV at risk from disputes — a key financial exposure KPI."
    - name: "total_refund_amount"
      expr: SUM(CAST(total_refund_amount AS DOUBLE))
      comment: "Total refunds issued as dispute resolutions. Directly impacts marketplace P&L and seller settlement deductions."
    - name: "total_marketplace_fee_at_risk"
      expr: SUM(CAST(marketplace_fee_amount AS DOUBLE))
      comment: "Total marketplace fees associated with disputed transactions. Measures commission revenue at risk from dispute reversals."
    - name: "total_net_dispute_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Net financial exposure after fees across all disputes. Used for reserve provisioning and financial risk management."
    - name: "escalated_dispute_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of disputes that were escalated. High escalation rates indicate first-line resolution failures and increased operational cost."
    - name: "fraud_flagged_dispute_count"
      expr: COUNT(CASE WHEN is_fraud_flag = TRUE THEN 1 END)
      comment: "Number of disputes flagged as potentially fraudulent. Tracks fraud-driven dispute exposure and informs risk policy adjustments."
    - name: "sla_compliant_dispute_count"
      expr: COUNT(CASE WHEN sla_compliance = TRUE THEN 1 END)
      comment: "Number of disputes resolved within SLA. Used to compute SLA compliance rate — a key customer experience and regulatory KPI."
    - name: "open_dispute_count"
      expr: COUNT(CASE WHEN dispute_status = 'OPEN' THEN 1 END)
      comment: "Number of currently open disputes. Measures unresolved backlog and operational workload for dispute resolution teams."
    - name: "avg_gross_dispute_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross value per dispute. Tracks typical dispute size — rising averages indicate higher-value transactions being disputed."
    - name: "distinct_seller_dispute_count"
      expr: COUNT(DISTINCT seller_profile_id)
      comment: "Number of unique sellers involved in disputes. Identifies high-dispute sellers for performance management and potential suspension."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`marketplace_listing_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Listing offer competitiveness and pricing KPIs covering offer pricing, buy-box win rates, seller ratings, shipping costs, and promotional activity. Drives pricing strategy, seller performance management, and buy-box algorithm governance."
  source: "`ecommerce_ecm`.`marketplace`.`listing_offer`"
  filter: listing_offer_status = 'ACTIVE'
  dimensions:
    - name: "listing_offer_status"
      expr: listing_offer_status
      comment: "Current status of the offer (e.g. ACTIVE, SUPPRESSED, EXPIRED) — primary filter for live offer analysis."
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Fulfilment method for the offer (e.g. FBA, FBM, DROP_SHIP) — key dimension for SLA and cost competitiveness analysis."
    - name: "condition"
      expr: condition
      comment: "Item condition (e.g. NEW, USED, REFURBISHED) — segments offer quality tiers for pricing and conversion analysis."
    - name: "price_type"
      expr: price_type
      comment: "Type of price applied (e.g. STANDARD, PROMOTIONAL, CLEARANCE) — distinguishes regular vs. promotional pricing."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the offer price — required for multi-currency pricing analysis."
    - name: "buy_box_winner_flag"
      expr: buy_box_winner_flag
      comment: "Whether this offer currently holds the buy box — primary competitiveness dimension for seller pricing strategy."
    - name: "is_prime_eligible"
      expr: is_prime_eligible
      comment: "Whether the offer qualifies for Prime delivery — Prime eligibility is a major conversion driver."
    - name: "promotional_flag"
      expr: promotional_flag
      comment: "Whether the offer has an active promotion applied — segments promotional vs. organic pricing."
    - name: "offer_source"
      expr: offer_source
      comment: "Origin of the offer (e.g. SELLER_PORTAL, API, REPRICING_ENGINE) — informs offer creation channel mix."
    - name: "is_returnable"
      expr: is_returnable
      comment: "Whether the offer supports returns — return policy is a key buyer trust and conversion factor."
  measures:
    - name: "total_offer_count"
      expr: COUNT(1)
      comment: "Total number of listing offers. Measures offer density and competitive depth across the catalogue."
    - name: "buy_box_winner_count"
      expr: COUNT(CASE WHEN buy_box_winner_flag = TRUE THEN 1 END)
      comment: "Number of offers currently holding the buy box. Tracks buy-box distribution across sellers and fulfilment types."
    - name: "avg_offer_price"
      expr: AVG(CAST(offer_price AS DOUBLE))
      comment: "Average offer price across active listings. Tracks price level trends and detects pricing anomalies."
    - name: "avg_net_price"
      expr: AVG(CAST(net_price AS DOUBLE))
      comment: "Average net price (after discounts) across offers. Measures effective price realisation vs. listed price."
    - name: "avg_shipping_cost"
      expr: AVG(CAST(shipping_cost AS DOUBLE))
      comment: "Average shipping cost across offers. High shipping costs reduce conversion — tracks competitiveness of total landed price."
    - name: "avg_total_price"
      expr: AVG(CAST(total_price AS DOUBLE))
      comment: "Average total price (offer + shipping + tax) presented to buyers. The true competitive price point buyers compare."
    - name: "avg_seller_rating"
      expr: AVG(CAST(seller_rating AS DOUBLE))
      comment: "Average seller rating across offers. Seller rating is a primary buy-box eligibility factor and buyer trust signal."
    - name: "avg_buyer_feedback_score"
      expr: AVG(CAST(buyer_feedback_score AS DOUBLE))
      comment: "Average buyer feedback score across offers. Tracks offer-level quality perception and informs seller performance management."
    - name: "prime_eligible_offer_count"
      expr: COUNT(CASE WHEN is_prime_eligible = TRUE THEN 1 END)
      comment: "Number of Prime-eligible offers. Prime coverage rate is a key catalogue quality and conversion KPI."
    - name: "promotional_offer_count"
      expr: COUNT(CASE WHEN promotional_flag = TRUE THEN 1 END)
      comment: "Number of offers with active promotions. Measures promotional depth and discount programme reach across the catalogue."
    - name: "distinct_seller_offer_count"
      expr: COUNT(DISTINCT seller_profile_id)
      comment: "Number of unique sellers with active offers. Measures competitive seller density contributing to buyer choice."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`marketplace_commission_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commission schedule governance KPIs covering rate levels, caps, promotional periods, and schedule coverage. Drives monetisation strategy, rate card governance, and commission policy compliance."
  source: "`ecommerce_ecm`.`marketplace`.`commission_schedule`"
  filter: schedule_status = 'ACTIVE'
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the commission schedule (e.g. ACTIVE, EXPIRED, DRAFT) — primary filter for live rate governance."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfilment type the schedule applies to — commission rates often differ by fulfilment method."
    - name: "cap_type"
      expr: cap_type
      comment: "Type of commission cap applied (e.g. FLAT, PERCENTAGE, NONE) — governs maximum commission exposure per transaction."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region the schedule applies to — enables regional commission rate benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the commission schedule — required for multi-currency rate governance."
    - name: "promotional_period_flag"
      expr: promotional_period_flag
      comment: "Whether the schedule applies during a promotional period — separates standard vs. promotional commission rates."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Whether the schedule is exclusive to a specific seller or brand — tracks bespoke commission arrangements."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the commission schedule became effective — used for rate change timeline analysis."
  measures:
    - name: "total_schedule_count"
      expr: COUNT(1)
      comment: "Total number of active commission schedules. Measures rate card complexity — too many schedules increase governance risk."
    - name: "avg_base_commission_rate_pct"
      expr: AVG(CAST(base_commission_rate_pct AS DOUBLE))
      comment: "Average base commission rate across active schedules. Primary monetisation yield KPI — tracks rate card competitiveness and revenue optimisation."
    - name: "max_base_commission_rate_pct"
      expr: MAX(CAST(base_commission_rate_pct AS DOUBLE))
      comment: "Maximum base commission rate in the active schedule portfolio. Identifies highest-rate categories for pricing strategy review."
    - name: "min_base_commission_rate_pct"
      expr: MIN(CAST(base_commission_rate_pct AS DOUBLE))
      comment: "Minimum base commission rate in the active schedule portfolio. Identifies lowest-rate categories — potential under-monetisation risk."
    - name: "avg_max_commission_amount"
      expr: AVG(CAST(max_commission_amount AS DOUBLE))
      comment: "Average maximum commission cap amount across schedules. Tracks cap levels relative to GMV — informs whether caps are binding constraints on revenue."
    - name: "avg_min_commission_amount"
      expr: AVG(CAST(min_commission_amount AS DOUBLE))
      comment: "Average minimum commission floor amount across schedules. Ensures minimum revenue per transaction is maintained across all rate tiers."
    - name: "promotional_schedule_count"
      expr: COUNT(CASE WHEN promotional_period_flag = TRUE THEN 1 END)
      comment: "Number of commission schedules in promotional periods. Tracks the scope of reduced-rate promotional programmes and their revenue impact."
    - name: "exclusive_schedule_count"
      expr: COUNT(CASE WHEN is_exclusive = TRUE THEN 1 END)
      comment: "Number of exclusive commission schedules. Measures bespoke rate arrangements — high counts indicate complex governance overhead."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`marketplace_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketplace promotion programme KPIs covering discount depth, budget utilisation, promotion type mix, and seller participation. Drives promotional ROI governance and campaign effectiveness measurement."
  source: "`ecommerce_ecm`.`marketplace`.`marketplace_promotion`"
  filter: marketplace_promotion_status = 'ACTIVE'
  dimensions:
    - name: "promotion_type"
      expr: promotion_type
      comment: "Type of promotion (e.g. PERCENTAGE_OFF, BOGO, FREE_SHIPPING) — primary dimension for promotion mix analysis."
    - name: "marketplace_promotion_status"
      expr: marketplace_promotion_status
      comment: "Current status of the promotion (e.g. ACTIVE, EXPIRED, DRAFT) — primary filter for live promotion monitoring."
    - name: "discount_mechanism"
      expr: discount_mechanism
      comment: "Mechanism by which the discount is applied (e.g. COUPON, AUTO_APPLY, PROMO_CODE) — informs redemption channel analysis."
    - name: "funding_source"
      expr: funding_source
      comment: "Who funds the promotion (e.g. MARKETPLACE, SELLER, CO_FUNDED) — critical for P&L attribution of promotional costs."
    - name: "geographic_scope_type"
      expr: geographic_scope_type
      comment: "Geographic scope of the promotion (e.g. NATIONAL, REGIONAL, LOCAL) — used for geo-targeted promotion performance analysis."
    - name: "is_stackable"
      expr: is_stackable
      comment: "Whether the promotion can be stacked with other promotions — stackable promotions carry higher discount leakage risk."
    - name: "seller_acceptance_required"
      expr: seller_acceptance_required
      comment: "Whether seller opt-in is required — tracks seller participation rates in marketplace-funded promotions."
    - name: "promotion_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the promotion started — used for promotional calendar analysis and seasonal discount trending."
    - name: "ftc_disclosure_required"
      expr: ftc_disclosure_required
      comment: "Whether FTC disclosure is required for the promotion — tracks regulatory compliance exposure in promotional programmes."
  measures:
    - name: "total_promotion_count"
      expr: COUNT(1)
      comment: "Total number of active promotions. Measures promotional programme breadth and complexity."
    - name: "total_budget_cap"
      expr: SUM(CAST(budget_cap_amount AS DOUBLE))
      comment: "Total budget allocated across active promotions. Measures total promotional investment commitment — key for marketing budget governance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value offered across promotions. Measures gross promotional cost before funding source attribution."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount depth across active promotions. Tracks promotional aggressiveness — high averages signal margin pressure."
    - name: "max_discount_percentage"
      expr: MAX(CAST(discount_percentage AS DOUBLE))
      comment: "Maximum discount percentage offered in any active promotion. Identifies outlier promotions that may erode brand or margin."
    - name: "total_promotional_price_value"
      expr: SUM(CAST(promotional_price AS DOUBLE))
      comment: "Sum of promotional prices across all active promotions. Used to estimate total promotional GMV exposure."
    - name: "stackable_promotion_count"
      expr: COUNT(CASE WHEN is_stackable = TRUE THEN 1 END)
      comment: "Number of stackable promotions. Stackable promotions compound discount exposure — high counts require margin impact modelling."
    - name: "ftc_disclosure_required_count"
      expr: COUNT(CASE WHEN ftc_disclosure_required = TRUE THEN 1 END)
      comment: "Number of promotions requiring FTC disclosure. Tracks regulatory compliance obligations in the active promotion portfolio."
    - name: "distinct_seller_promotion_count"
      expr: COUNT(DISTINCT seller_profile_id)
      comment: "Number of unique sellers participating in active promotions. Measures seller engagement with marketplace promotional programmes."
    - name: "avg_budget_cap_per_promotion"
      expr: AVG(CAST(budget_cap_amount AS DOUBLE))
      comment: "Average budget cap per promotion. Tracks typical promotional investment size — informs budget allocation benchmarks."
$$;