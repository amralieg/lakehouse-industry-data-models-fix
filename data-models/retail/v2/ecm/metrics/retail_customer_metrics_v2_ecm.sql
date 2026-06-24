-- Metric views for domain: customer | Business: Retail | Version: 2 | Generated on: 2026-06-23 23:42:36

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core customer identity and lifecycle metrics. Tracks active customer base composition, acquisition trends, lifecycle stage distribution, and MDM data quality — essential for CRM investment decisions and customer base health monitoring."
  source: "`vibe_retail_v1`.`customer`.`profile`"
  dimensions:
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Customer lifecycle stage (e.g. prospect, active, lapsed, churned) for cohort analysis and lifecycle-driven marketing investment."
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which the customer was acquired (e.g. organic, paid, referral, in-store) to evaluate channel ROI."
    - name: "entity_type"
      expr: entity_type
      comment: "Legal entity type (individual vs organisation) to separate B2C and B2B customer base analysis."
    - name: "customer_role"
      expr: customer_role
      comment: "Role the customer plays (consumer, employee, wholesale_buyer) for role-based segmentation."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Customer loyalty tier (e.g. bronze, silver, gold, platinum) for tier-based investment and retention analysis."
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the profile record (active, inactive, merged, suppressed) for data quality governance."
    - name: "preferred_language"
      expr: preferred_language
      comment: "Customer preferred language for localisation and communication strategy decisions."
    - name: "acquisition_month"
      expr: DATE_TRUNC('MONTH', acquisition_date)
      comment: "Month of customer acquisition for cohort and trend analysis."
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year of customer acquisition for annual cohort sizing."
    - name: "mdm_source_system"
      expr: mdm_source_system
      comment: "Source system that contributed the master record, used to assess data lineage and MDM coverage."
  measures:
    - name: "active_customer_count"
      expr: COUNT(DISTINCT CASE WHEN profile_status = 'active' THEN profile_id END)
      comment: "Number of distinct active customer profiles. Core KPI for total addressable customer base sizing and YoY growth tracking."
    - name: "total_customer_count"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total distinct customer profiles across all statuses. Used as denominator for activation rate and data quality ratios."
    - name: "new_customer_count"
      expr: COUNT(DISTINCT CASE WHEN acquisition_date >= DATE_TRUNC('MONTH', CURRENT_DATE) THEN profile_id END)
      comment: "Customers acquired in the current calendar month. Tracks new customer acquisition velocity for growth targets."
    - name: "mdm_high_confidence_count"
      expr: COUNT(DISTINCT CASE WHEN mdm_confidence_score >= 0.8 THEN profile_id END)
      comment: "Profiles with MDM confidence score at or above 0.8, indicating high-quality identity resolution. Drives data quality investment decisions."
    - name: "avg_mdm_confidence_score"
      expr: AVG(CAST(mdm_confidence_score AS DOUBLE))
      comment: "Average MDM identity resolution confidence score across all profiles. Measures overall customer data quality health."
    - name: "current_record_count"
      expr: COUNT(DISTINCT CASE WHEN is_current_flag = TRUE THEN profile_id END)
      comment: "Number of profiles flagged as the current SCD version. Used to validate SCD2 integrity and detect stale records."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer engagement and interaction quality metrics. Tracks channel mix, digital engagement rates, and sentiment trends — used by CX and marketing leadership to optimise communication strategy and service quality."
  source: "`vibe_retail_v1`.`customer`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of interaction (e.g. email, call, chat, in-store visit) for channel-level engagement analysis."
    - name: "channel"
      expr: channel
      comment: "Communication channel through which the interaction occurred, used to measure channel effectiveness."
    - name: "direction"
      expr: direction
      comment: "Whether the interaction was inbound (customer-initiated) or outbound (brand-initiated), for contact strategy analysis."
    - name: "outcome"
      expr: outcome
      comment: "Result of the interaction (resolved, escalated, no-response) to measure first-contact resolution rates."
    - name: "device_type"
      expr: device_type
      comment: "Device used during digital interactions (mobile, desktop, tablet) for UX investment prioritisation."
    - name: "interaction_month"
      expr: DATE_TRUNC('MONTH', interaction_timestamp)
      comment: "Month of interaction for trend and seasonality analysis."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the communication (delivered, bounced, failed) for channel deliverability monitoring."
  measures:
    - name: "total_interaction_count"
      expr: COUNT(1)
      comment: "Total number of customer interactions. Baseline volume KPI for contact centre capacity planning and engagement benchmarking."
    - name: "unique_customers_interacted"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct customers who had at least one interaction. Measures reach of engagement programmes."
    - name: "email_open_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN email_opened_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN interaction_type = 'email' THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of email interactions where the email was opened. Key email marketing effectiveness KPI."
    - name: "email_click_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN email_clicked_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN interaction_type = 'email' THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of email interactions resulting in a click. Measures email content relevance and CTA effectiveness."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across all interactions with sentiment data. Tracks overall customer satisfaction trend and flags deterioration requiring CX intervention."
    - name: "sms_delivery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sms_delivered_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN interaction_type = 'sms' THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of SMS interactions successfully delivered. Monitors SMS channel health and carrier deliverability."
    - name: "unsubscribe_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN unsubscribed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of interactions resulting in an unsubscribe. Elevated rates signal over-communication or irrelevant content, triggering frequency and targeting review."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer segment portfolio metrics. Tracks segment size, value, and health — used by marketing and analytics leadership to prioritise segment investment, validate segmentation quality, and monitor churn risk concentration."
  source: "`vibe_retail_v1`.`customer`.`segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Type of segment (behavioural, demographic, value-based, predictive) for portfolio composition analysis."
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment (active, archived, draft) for active segment portfolio management."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the segment (national, regional, local) for territory-level marketing planning."
    - name: "owning_business_unit"
      expr: owning_business_unit
      comment: "Business unit that owns the segment, for accountability and budget allocation."
    - name: "priority_tier"
      expr: priority_tier
      comment: "Priority tier of the segment (tier1, tier2, tier3) for resource allocation decisions."
    - name: "b2b_b2c_indicator"
      expr: b2b_b2c_indicator
      comment: "Whether the segment targets B2B or B2C customers, for channel and offer strategy differentiation."
    - name: "target_marketing_channel"
      expr: target_marketing_channel
      comment: "Primary marketing channel targeted for this segment, for channel budget allocation."
  measures:
    - name: "total_segment_membership"
      expr: SUM(CAST(membership_count AS DOUBLE))
      comment: "Total customer memberships across all active segments. Measures overall segmentation coverage of the customer base."
    - name: "avg_segment_membership"
      expr: AVG(CAST(membership_count AS DOUBLE))
      comment: "Average number of members per segment. Identifies over-concentrated or under-populated segments requiring rebalancing."
    - name: "avg_segment_cltv"
      expr: AVG(CAST(average_cltv AS DOUBLE))
      comment: "Average customer lifetime value across segments. Used to rank segments by financial attractiveness for investment prioritisation."
    - name: "avg_transaction_value"
      expr: AVG(CAST(avg_transaction_value AS DOUBLE))
      comment: "Average transaction value across segments. Informs offer sizing and promotional investment thresholds."
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score across segments. Elevated scores trigger retention investment and intervention programme reviews."
    - name: "avg_purchase_frequency"
      expr: AVG(CAST(average_purchase_frequency AS DOUBLE))
      comment: "Average purchase frequency across segments. Drives frequency-based loyalty and replenishment programme design."
    - name: "high_churn_risk_segment_count"
      expr: COUNT(DISTINCT CASE WHEN churn_risk_score >= 0.7 THEN segment_id END)
      comment: "Number of segments with high churn risk (score >= 0.7). Flags portfolio-level retention risk requiring executive attention."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_service_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer service operational performance metrics. Tracks case volume, resolution quality, SLA compliance, and financial impact of service — used by CX leadership to manage service cost, quality, and customer satisfaction."
  source: "`vibe_retail_v1`.`customer`.`service_case`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Type of service case (return, complaint, inquiry, escalation) for issue category analysis."
    - name: "case_status"
      expr: case_status
      comment: "Current case status (open, in_progress, resolved, closed) for workload and backlog management."
    - name: "channel"
      expr: channel
      comment: "Channel through which the case was raised (phone, email, chat, in-store) for channel cost and quality analysis."
    - name: "assigned_team"
      expr: assigned_team
      comment: "Team responsible for the case, for team-level performance benchmarking."
    - name: "priority"
      expr: priority
      comment: "Case priority (low, medium, high, critical) for SLA tier management."
    - name: "resolution_code"
      expr: resolution_code
      comment: "Resolution outcome code for root cause analysis and deflection opportunity identification."
    - name: "case_created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the case was created for volume trend and seasonality analysis."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the case was escalated, for escalation rate monitoring and process improvement."
  measures:
    - name: "total_case_count"
      expr: COUNT(1)
      comment: "Total number of service cases. Baseline volume KPI for contact centre capacity planning and service demand forecasting."
    - name: "open_case_count"
      expr: COUNT(DISTINCT CASE WHEN is_closed = FALSE THEN service_case_id END)
      comment: "Number of currently open cases. Measures service backlog and drives staffing decisions."
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of cases that breached SLA targets. Directly impacts customer satisfaction and contractual penalties."
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases breaching SLA. Key CX quality KPI — elevated rates trigger staffing and process reviews."
    - name: "escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases escalated. High escalation rates indicate first-line resolution failures requiring training or process investment."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total monetary value of refunds issued through service cases. Measures financial cost of service failures and return fraud exposure."
    - name: "avg_sla_target_hours"
      expr: AVG(CAST(sla_target_hours AS DOUBLE))
      comment: "Average SLA target hours across cases. Used to benchmark service tier commitments and identify SLA policy inconsistencies."
    - name: "unique_customers_with_cases"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct customers who raised service cases. High overlap with high-value segments triggers proactive service investment."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_wishlist`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wishlist and gift registry engagement metrics. Tracks conversion rates, registry value, and sharing behaviour — used by merchandising and marketing to identify demand signals and optimise registry-driven revenue."
  source: "`vibe_retail_v1`.`customer`.`wishlist`"
  dimensions:
    - name: "wishlist_type"
      expr: wishlist_type
      comment: "Type of wishlist (personal, gift_registry, wedding, baby) for registry programme performance analysis."
    - name: "wishlist_status"
      expr: wishlist_status
      comment: "Current status of the wishlist (active, archived, converted) for active registry portfolio management."
    - name: "channel"
      expr: channel
      comment: "Channel through which the wishlist was created (web, app, in-store) for channel attribution."
    - name: "visibility"
      expr: visibility
      comment: "Visibility setting (public, private, shared) for social commerce and sharing strategy analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device used to create the wishlist (mobile, desktop, tablet) for UX optimisation."
    - name: "conversion_status"
      expr: conversion_status
      comment: "Whether the wishlist has been converted to a purchase (converted, partial, not_converted) for funnel analysis."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the wishlist was created for seasonal demand signal analysis."
  measures:
    - name: "active_wishlist_count"
      expr: COUNT(DISTINCT CASE WHEN wishlist_status = 'active' THEN wishlist_id END)
      comment: "Number of active wishlists. Measures latent demand pipeline and registry programme engagement."
    - name: "total_wishlist_value"
      expr: SUM(CAST(total_value_amount AS DOUBLE))
      comment: "Total monetary value of items across all active wishlists. Quantifies the demand pipeline available for targeted conversion campaigns."
    - name: "avg_wishlist_value"
      expr: AVG(CAST(total_value_amount AS DOUBLE))
      comment: "Average value per wishlist. Benchmarks registry programme quality and informs minimum-value promotional thresholds."
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate_percentage AS DOUBLE))
      comment: "Average wishlist-to-purchase conversion rate. Core registry programme effectiveness KPI used to justify registry marketing investment."
    - name: "converted_wishlist_count"
      expr: COUNT(DISTINCT CASE WHEN conversion_status = 'converted' THEN wishlist_id END)
      comment: "Number of wishlists fully converted to purchases. Measures registry programme revenue contribution."
    - name: "notification_enabled_count"
      expr: COUNT(DISTINCT CASE WHEN notification_enabled_flag = TRUE THEN wishlist_id END)
      comment: "Number of wishlists with notifications enabled. Measures engagement depth and re-marketing audience size for wishlist-based campaigns."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_b2b_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "B2B contract portfolio and financial commitment metrics. Tracks contract value, credit exposure, renewal risk, and discount levels — used by sales and finance leadership to manage B2B revenue commitments and contract risk."
  source: "`vibe_retail_v1`.`customer`.`b2b_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of B2B contract (master, amendment, renewal) for portfolio composition analysis."
    - name: "contract_status"
      expr: contract_status
      comment: "Current contract status (active, expired, terminated, pending) for active portfolio management."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency (monthly, quarterly, annual) for cash flow forecasting."
    - name: "pricing_tier"
      expr: pricing_tier
      comment: "Pricing tier assigned to the contract for margin analysis by tier."
    - name: "renewal_type"
      expr: renewal_type
      comment: "Renewal type (auto, manual, negotiated) for renewal risk management."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for multi-currency revenue reporting."
    - name: "contract_signed_year"
      expr: YEAR(signed_date)
      comment: "Year the contract was signed for vintage cohort analysis."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total committed contract value across all active B2B contracts. Core B2B revenue pipeline KPI for sales and finance planning."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average contract value. Benchmarks deal size and informs sales team quota setting."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit extended across all B2B contracts. Measures aggregate credit risk exposure for finance risk management."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across contracts. Monitors margin erosion from B2B discounting and informs pricing policy reviews."
    - name: "total_volume_commitment"
      expr: SUM(CAST(volume_commitment AS DOUBLE))
      comment: "Total volume committed across all B2B contracts. Used for demand planning and supply chain capacity allocation."
    - name: "auto_renewal_contract_count"
      expr: COUNT(DISTINCT CASE WHEN auto_renewal_flag = TRUE THEN b2b_contract_id END)
      comment: "Number of contracts set to auto-renew. Measures revenue retention risk and informs proactive renewal outreach strategy."
    - name: "active_contract_count"
      expr: COUNT(DISTINCT CASE WHEN contract_status = 'active' THEN b2b_contract_id END)
      comment: "Number of currently active B2B contracts. Core B2B portfolio size KPI for sales leadership."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_privacy_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Privacy rights request processing metrics. Tracks GDPR/CCPA request volumes, processing compliance, and appeal rates — mandatory for regulatory reporting and privacy programme governance."
  source: "`vibe_retail_v1`.`customer`.`privacy_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of privacy request (erasure, access, portability, rectification, opt_out) for regulatory category reporting."
    - name: "request_status"
      expr: request_status
      comment: "Current processing status (pending, in_progress, completed, denied) for SLA compliance monitoring."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the request (GDPR, CCPA, LGPD) for jurisdiction-specific compliance reporting."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the request was submitted (web_portal, email, in-store) for process efficiency analysis."
    - name: "verification_status"
      expr: verification_status
      comment: "Identity verification status of the requestor (verified, pending, failed) for fraud and compliance risk management."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month the request was submitted for volume trend and regulatory deadline tracking."
  measures:
    - name: "total_request_count"
      expr: COUNT(1)
      comment: "Total privacy requests received. Baseline compliance volume KPI required for regulatory reporting and DPO oversight."
    - name: "pending_request_count"
      expr: COUNT(DISTINCT CASE WHEN request_status = 'pending' THEN privacy_request_id END)
      comment: "Number of unprocessed privacy requests. Elevated counts risk regulatory deadline breaches requiring immediate resource allocation."
    - name: "overdue_request_count"
      expr: COUNT(DISTINCT CASE WHEN request_status NOT IN ('completed', 'denied') AND processing_deadline < CURRENT_DATE THEN privacy_request_id END)
      comment: "Number of requests past their regulatory processing deadline. Direct compliance risk indicator — any non-zero value requires executive escalation."
    - name: "appeal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN appeal_submitted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requests where the customer submitted an appeal. High rates indicate denial policy issues requiring legal review."
    - name: "extension_granted_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN extension_granted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requests where a processing extension was granted. Monitors operational capacity to meet regulatory deadlines."
    - name: "customer_notification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN customer_notification_sent_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of completed requests where the customer was notified. Regulatory requirement — must remain at or near 100%."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_issuance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coupon, gift card, and promotional issuance metrics. Tracks issued value, redemption rates, breakage, and fraud risk — used by marketing and finance to measure promotional ROI and manage liability."
  source: "`vibe_retail_v1`.`customer`.`issuance`"
  dimensions:
    - name: "issuance_type"
      expr: issuance_type
      comment: "Type of issuance (coupon, gift_card, store_credit, reward_voucher) for programme-level financial analysis."
    - name: "issuance_status"
      expr: issuance_status
      comment: "Current status of the issuance (active, redeemed, expired, voided) for liability and breakage analysis."
    - name: "issuance_category"
      expr: issuance_category
      comment: "Business category of the issuance (loyalty_reward, promotional, compensation) for cost attribution."
    - name: "channel"
      expr: channel
      comment: "Channel through which the issuance was distributed (email, in-store, app) for channel effectiveness analysis."
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount encoded in the issuance (percentage, fixed_amount, free_item) for offer mix analysis."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month of issuance for promotional calendar and liability accrual analysis."
    - name: "fraud_check_status"
      expr: fraud_check_status
      comment: "Fraud screening outcome (passed, flagged, blocked) for promotional fraud risk monitoring."
  measures:
    - name: "total_issued_amount"
      expr: SUM(CAST(issued_amount AS DOUBLE))
      comment: "Total monetary value of all issuances. Measures promotional liability and marketing spend commitment."
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Total unredeemed balance across all active issuances. Represents outstanding promotional liability on the balance sheet."
    - name: "total_face_value"
      expr: SUM(CAST(face_value_amount AS DOUBLE))
      comment: "Total face value of all issued instruments. Used for promotional budget reconciliation and accrual accounting."
    - name: "redemption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN redeemed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of issued instruments that have been redeemed. Core promotional effectiveness KPI — low rates indicate poor offer relevance or distribution."
    - name: "void_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN voided_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of issuances that were voided. Elevated rates may indicate fraud, operational errors, or policy abuse."
    - name: "fraud_flagged_count"
      expr: COUNT(DISTINCT CASE WHEN fraud_check_status = 'flagged' THEN issuance_id END)
      comment: "Number of issuances flagged by fraud screening. Monitors promotional fraud exposure and triggers investigation workflows."
    - name: "avg_issued_amount"
      expr: AVG(CAST(issued_amount AS DOUBLE))
      comment: "Average value per issuance. Benchmarks offer generosity and informs promotional value calibration."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level spend, loyalty, and engagement metrics. Tracks household value, loyalty penetration, and communication preferences — used by marketing to design household-level targeting and measure multi-member household economics."
  source: "`vibe_retail_v1`.`customer`.`household`"
  dimensions:
    - name: "household_type"
      expr: household_type
      comment: "Type of household (single, family, multi-generational) for demographic segmentation."
    - name: "household_status"
      expr: household_status
      comment: "Current status of the household record (active, inactive, merged) for data quality governance."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Household loyalty tier derived from combined member activity, for tier-based household targeting."
    - name: "estimated_income_band"
      expr: estimated_income_band
      comment: "Estimated household income band for value-based segmentation and offer calibration."
    - name: "preferred_channel"
      expr: preferred_channel
      comment: "Household preferred communication channel for channel strategy and budget allocation."
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Whether the household has opted in to marketing communications, defining the contactable household universe."
    - name: "country_code"
      expr: country_code
      comment: "Country of the household for geographic market analysis."
  measures:
    - name: "total_household_spend"
      expr: SUM(CAST(total_spend_amount AS DOUBLE))
      comment: "Total spend across all households. Measures aggregate household revenue contribution and informs household-level investment decisions."
    - name: "avg_household_spend"
      expr: AVG(CAST(total_spend_amount AS DOUBLE))
      comment: "Average spend per household. Benchmarks household value and informs household-level offer thresholds."
    - name: "avg_basket_value"
      expr: AVG(CAST(average_basket_value AS DOUBLE))
      comment: "Average basket value across households. Tracks basket size trends and informs upsell and cross-sell programme design."
    - name: "total_combined_cltv"
      expr: SUM(CAST(combined_cltv AS DOUBLE))
      comment: "Total combined customer lifetime value across all households. Quantifies the long-term revenue potential of the household base."
    - name: "marketing_opted_in_household_count"
      expr: COUNT(DISTINCT CASE WHEN marketing_opt_in = TRUE THEN household_id END)
      comment: "Number of households opted in to marketing. Defines the addressable household marketing universe."
    - name: "active_household_count"
      expr: COUNT(DISTINCT CASE WHEN household_status = 'active' THEN household_id END)
      comment: "Number of active household records. Core household base size KPI for household-level programme planning."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_targeting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Segment targeting campaign performance metrics. Tracks reach, conversion, response rates, and budget efficiency — used by marketing leadership to evaluate targeting programme ROI and optimise audience investment."
  source: "`vibe_retail_v1`.`customer`.`targeting`"
  dimensions:
    - name: "targeting_status"
      expr: targeting_status
      comment: "Current status of the targeting activation (active, paused, completed) for active campaign portfolio management."
    - name: "priority"
      expr: priority
      comment: "Priority level of the targeting activation for budget and resource allocation decisions."
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', activation_timestamp)
      comment: "Month the targeting was activated for campaign calendar and spend trend analysis."
  measures:
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocation_amount AS DOUBLE))
      comment: "Total budget allocated across all targeting activations. Measures total marketing investment in segment targeting."
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate_percent AS DOUBLE))
      comment: "Average conversion rate across targeting activations. Core targeting effectiveness KPI — drives audience selection and offer optimisation decisions."
    - name: "avg_response_rate"
      expr: AVG(CAST(response_rate_percent AS DOUBLE))
      comment: "Average response rate across targeting activations. Measures audience engagement quality and informs targeting model refinement."
    - name: "total_estimated_reach"
      expr: SUM(CAST(estimated_reach AS DOUBLE))
      comment: "Total estimated reach across all targeting activations. Measures planned audience coverage for campaign planning."
    - name: "total_actual_reached"
      expr: SUM(CAST(actual_reached_count AS DOUBLE))
      comment: "Total customers actually reached across all targeting activations. Compared against estimated reach to measure targeting execution accuracy."
    - name: "reach_fulfilment_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_reached_count AS DOUBLE)) / NULLIF(SUM(CAST(estimated_reach AS DOUBLE)), 0), 2)
      comment: "Percentage of estimated reach actually achieved. Measures targeting execution quality and audience availability accuracy."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_segment_banner_targeting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Banner advertising performance metrics by customer segment. Tracks impressions, clicks, conversions, and attributed revenue — used by digital marketing leadership to optimise banner spend allocation across segments."
  source: "`vibe_retail_v1`.`customer`.`targeting`"
  dimensions:
    - name: "targeting_status"
      expr: targeting_status
      comment: "Current status of the banner targeting (active, paused, ended) for active campaign management."
  measures:
    - name: "Row Count"
      expr: COUNT(1)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_client_relationship`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High-value client relationship health and revenue metrics. Tracks relationship value, engagement quality, churn risk, and NPS — used by clienteling and key account management teams to prioritise relationship investment."
  source: "`vibe_retail_v1`.`customer`.`client_relationship`"
  dimensions:
    - name: "relationship_type"
      expr: relationship_type
      comment: "Type of client relationship (vip, wholesale, corporate, personal_shopping) for programme-level analysis."
    - name: "relationship_status"
      expr: relationship_status
      comment: "Current relationship status (active, at_risk, churned, dormant) for portfolio health monitoring."
    - name: "relationship_tier"
      expr: relationship_tier
      comment: "Tier of the relationship (platinum, gold, silver) for tiered service investment decisions."
    - name: "assigned_team"
      expr: assigned_team
      comment: "Team responsible for managing the relationship, for team-level performance benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for financial metrics, for multi-currency revenue reporting."
    - name: "channel_preference"
      expr: channel_preference
      comment: "Client preferred communication channel for personalised outreach strategy."
  measures:
    - name: "total_lifetime_revenue"
      expr: SUM(CAST(lifetime_revenue_amount AS DOUBLE))
      comment: "Total lifetime revenue across all managed client relationships. Measures the financial value of the clienteling programme."
    - name: "avg_lifetime_value"
      expr: AVG(CAST(lifetime_value_amount AS DOUBLE))
      comment: "Average lifetime value per client relationship. Benchmarks relationship quality and informs investment thresholds per client."
    - name: "avg_annual_spend"
      expr: AVG(CAST(actual_annual_spend AS DOUBLE))
      comment: "Average actual annual spend per client. Tracks year-on-year spend trends and informs annual target setting."
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score across managed relationships. Elevated scores trigger proactive retention outreach by relationship managers."
    - name: "avg_engagement_score"
      expr: AVG(CAST(engagement_score AS DOUBLE))
      comment: "Average engagement score across client relationships. Measures relationship health and predicts future spend trajectory."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score across client relationships. Tracks advocacy and satisfaction trends for the clienteling programme."
    - name: "spend_vs_target_ratio"
      expr: ROUND(SUM(CAST(actual_annual_spend AS DOUBLE)) / NULLIF(SUM(CAST(annual_spend_target AS DOUBLE)), 0), 4)
      comment: "Ratio of actual annual spend to target spend across all relationships. Measures clienteling programme revenue attainment against plan."
$$;