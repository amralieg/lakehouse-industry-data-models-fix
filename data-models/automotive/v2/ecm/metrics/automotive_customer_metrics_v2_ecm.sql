-- Metric views for domain: customer | Business: Automotive | Version: 2 | Generated on: 2026-06-23 04:49:37

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_lifetime_value`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer Lifetime Value (CLTV) metrics tracking projected revenue streams, churn risk, and retention probability by customer segment and calculation cohort. Used by CMO and VP Customer Strategy to prioritize retention investment and segment-level resource allocation."
  source: "`vibe_automotive_v1`.`customer`.`cltv_record`"
  dimensions:
    - name: "segment_at_calculation"
      expr: segment_at_calculation
      comment: "Customer segment at the time CLTV was calculated, enabling segment-level CLTV benchmarking."
    - name: "calculation_status"
      expr: calculation_status
      comment: "Status of the CLTV calculation (e.g., final, draft, expired), used to filter to production-quality scores."
    - name: "model_version"
      expr: model_version
      comment: "Version of the CLTV model used, enabling model performance comparison over time."
    - name: "calculation_month"
      expr: DATE_TRUNC('MONTH', calculation_date)
      comment: "Month of CLTV calculation, enabling trend analysis of portfolio value over time."
    - name: "calculation_year"
      expr: YEAR(calculation_date)
      comment: "Year of CLTV calculation for annual portfolio value trending."
  measures:
    - name: "total_cltv_portfolio_value"
      expr: SUM(CAST(cltv_amount AS DOUBLE))
      comment: "Total projected lifetime value across all customers in scope. Directly informs investment budget for retention and acquisition programs."
    - name: "avg_cltv_per_customer"
      expr: AVG(CAST(cltv_amount AS DOUBLE))
      comment: "Average CLTV per customer record. Benchmark for segment health and acquisition cost justification."
    - name: "avg_churn_probability"
      expr: AVG(CAST(churn_probability AS DOUBLE))
      comment: "Average churn probability across the customer base. A rising score triggers proactive retention campaigns."
    - name: "avg_retention_probability"
      expr: AVG(CAST(retention_probability AS DOUBLE))
      comment: "Average retention probability. Complements churn probability to validate model consistency and guide loyalty investment."
    - name: "total_projected_service_revenue"
      expr: SUM(CAST(projected_service_revenue AS DOUBLE))
      comment: "Total projected aftersales service revenue across all customers. Informs service capacity planning and aftersales revenue forecasting."
    - name: "total_projected_finance_revenue"
      expr: SUM(CAST(projected_finance_revenue AS DOUBLE))
      comment: "Total projected F&I finance revenue. Key input for financial services revenue planning."
    - name: "total_projected_connected_services_revenue"
      expr: SUM(CAST(projected_connected_services_revenue AS DOUBLE))
      comment: "Total projected connected/subscription services revenue. Tracks the digital revenue stream growth trajectory."
    - name: "total_revenue_to_date"
      expr: SUM(CAST(revenue_to_date AS DOUBLE))
      comment: "Cumulative realized revenue from customers to date. Used to validate CLTV model accuracy against actuals."
    - name: "avg_data_completeness_score"
      expr: AVG(CAST(data_completeness_score AS DOUBLE))
      comment: "Average data completeness score for CLTV inputs. Low scores indicate data quality issues that undermine model reliability."
    - name: "high_churn_risk_customer_count"
      expr: COUNT(CASE WHEN churn_probability >= 0.7 THEN cltv_record_id END)
      comment: "Number of customers with churn probability >= 70%. Directly triggers retention intervention programs."
    - name: "total_cltv_records"
      expr: COUNT(1)
      comment: "Total number of CLTV records in scope. Baseline denominator for portfolio coverage analysis."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_loyalty_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty program membership metrics covering points economics, tier distribution, and engagement health. Used by VP Loyalty and CMO to steer program design, tier thresholds, and redemption incentives."
  source: "`vibe_automotive_v1`.`customer`.`loyalty_membership`"
  dimensions:
    - name: "current_tier"
      expr: current_tier
      comment: "Current loyalty tier of the member (e.g., Silver, Gold, Platinum). Primary dimension for tier-level performance analysis."
    - name: "program_status"
      expr: program_status
      comment: "Status of the loyalty membership (e.g., active, suspended, expired). Filters to active base for operational metrics."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the member enrolled (e.g., dealer, online, app). Informs channel effectiveness for loyalty acquisition."
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year of enrollment, enabling cohort-based loyalty analysis."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment for cohort trending."
    - name: "preferred_redemption_category"
      expr: preferred_redemption_category
      comment: "Member's preferred redemption category. Guides reward catalog investment decisions."
    - name: "redemption_eligibility_flag"
      expr: redemption_eligibility_flag
      comment: "Whether the member is currently eligible to redeem points. Tracks redeemable base size."
  measures:
    - name: "total_active_members"
      expr: COUNT(CASE WHEN program_status = 'active' THEN loyalty_membership_id END)
      comment: "Total active loyalty members. Core KPI for program health and growth tracking."
    - name: "total_points_balance"
      expr: SUM(CAST(points_balance AS DOUBLE))
      comment: "Total outstanding points liability across all members. Critical for financial provisioning of redemption costs."
    - name: "total_lifetime_points_earned"
      expr: SUM(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Total lifetime points earned across all members. Measures cumulative program engagement depth."
    - name: "total_points_earned_this_year"
      expr: SUM(CAST(points_earned_this_year AS DOUBLE))
      comment: "Total points earned in the current year. Year-to-date engagement velocity indicator."
    - name: "total_points_redeemed_this_year"
      expr: SUM(CAST(points_redeemed_this_year AS DOUBLE))
      comment: "Total points redeemed in the current year. Measures redemption activity and program value delivery."
    - name: "total_points_redeemed_lifetime"
      expr: SUM(CAST(total_points_redeemed AS DOUBLE))
      comment: "Total lifetime points redeemed. Indicates overall program value utilization."
    - name: "avg_points_balance_per_member"
      expr: AVG(CAST(points_balance AS DOUBLE))
      comment: "Average points balance per member. Indicates average unredeemed value and potential redemption pressure."
    - name: "avg_tier_points_required"
      expr: AVG(CAST(tier_points_required AS DOUBLE))
      comment: "Average points required for tier qualification. Benchmarks tier threshold accessibility across the member base."
    - name: "points_redemption_rate"
      expr: ROUND(100.0 * SUM(CAST(points_redeemed_this_year AS DOUBLE)) / NULLIF(SUM(CAST(points_earned_this_year AS DOUBLE)), 0), 2)
      comment: "Percentage of earned points redeemed this year. Low rates signal disengagement or poor redemption catalog; high rates signal strong program value delivery."
    - name: "avg_points_balance_last_year"
      expr: AVG(CAST(points_balance_last_year AS DOUBLE))
      comment: "Average points balance from the prior year. Year-over-year comparison baseline for balance growth analysis."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_loyalty_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty transaction economics tracking earn/redeem activity, channel distribution, and transaction velocity. Used by Loyalty Operations and Finance to manage points liability and program ROI."
  source: "`vibe_automotive_v1`.`customer`.`loyalty_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of loyalty transaction (earn, redeem, adjust, expire). Primary dimension for points flow analysis."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the transaction (e.g., approved, pending, reversed). Filters to settled transactions for financial reporting."
    - name: "channel"
      expr: channel
      comment: "Channel through which the transaction occurred (e.g., dealer, online, app). Informs channel-level engagement analysis."
    - name: "triggering_event_type"
      expr: triggering_event_type
      comment: "Business event that triggered the loyalty transaction (e.g., vehicle purchase, service visit). Links points activity to business outcomes."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the transaction. Tracks exception rates and manual review workload."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of transaction for trend analysis of earn/redeem velocity."
    - name: "transaction_year"
      expr: YEAR(transaction_timestamp)
      comment: "Year of transaction for annual points economics reporting."
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total number of loyalty transactions. Baseline volume metric for program activity."
    - name: "distinct_active_members_transacting"
      expr: COUNT(DISTINCT loyalty_membership_id)
      comment: "Number of distinct loyalty members with at least one transaction. Measures active engagement breadth."
    - name: "earn_transaction_count"
      expr: COUNT(CASE WHEN transaction_type = 'earn' THEN loyalty_transaction_id END)
      comment: "Number of points-earning transactions. Tracks program engagement through earning activity."
    - name: "redeem_transaction_count"
      expr: COUNT(CASE WHEN transaction_type = 'redeem' THEN loyalty_transaction_id END)
      comment: "Number of redemption transactions. Tracks value delivery and redemption catalog utilization."
    - name: "pending_approval_transaction_count"
      expr: COUNT(CASE WHEN approval_status = 'pending' THEN loyalty_transaction_id END)
      comment: "Number of transactions pending approval. Operational backlog metric for loyalty operations team."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_nps`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Net Promoter Score (NPS) metrics tracking customer satisfaction, promoter/detractor distribution, and follow-up action rates. Used by CX leadership and dealer operations to steer service quality improvements."
  source: "`vibe_automotive_v1`.`customer`.`nps_response`"
  dimensions:
    - name: "survey_type"
      expr: survey_type
      comment: "Type of NPS survey (e.g., post-purchase, post-service, annual). Segments NPS by customer journey stage."
    - name: "survey_channel"
      expr: survey_channel
      comment: "Channel through which the survey was delivered (e.g., email, SMS, in-app). Informs channel response rate analysis."
    - name: "promoter_category"
      expr: promoter_category
      comment: "NPS category of the respondent (Promoter, Passive, Detractor). Core dimension for NPS decomposition."
    - name: "nps_response_status"
      expr: nps_response_status
      comment: "Status of the NPS response record (e.g., complete, partial). Filters to valid responses."
    - name: "follow_up_status"
      expr: follow_up_status
      comment: "Status of follow-up action taken on the response. Tracks closed-loop feedback management."
    - name: "response_month"
      expr: DATE_TRUNC('MONTH', response_date)
      comment: "Month of NPS response for trend analysis."
    - name: "response_year"
      expr: YEAR(response_date)
      comment: "Year of NPS response for annual NPS benchmarking."
    - name: "dealer_code"
      expr: dealer_code
      comment: "Dealer code associated with the NPS response. Enables dealer-level NPS performance ranking."
  measures:
    - name: "total_responses"
      expr: COUNT(1)
      comment: "Total NPS responses received. Baseline for response rate and statistical significance assessment."
    - name: "promoter_count"
      expr: COUNT(CASE WHEN promoter_category = 'Promoter' THEN nps_response_id END)
      comment: "Number of Promoter responses (score 9-10). Numerator for NPS calculation."
    - name: "detractor_count"
      expr: COUNT(CASE WHEN promoter_category = 'Detractor' THEN nps_response_id END)
      comment: "Number of Detractor responses (score 0-6). Subtracted from promoters in NPS formula."
    - name: "passive_count"
      expr: COUNT(CASE WHEN promoter_category = 'Passive' THEN nps_response_id END)
      comment: "Number of Passive responses (score 7-8). Represents conversion opportunity to Promoters."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN nps_response_id END)
      comment: "Number of responses flagged for follow-up. Tracks closed-loop CX management workload."
    - name: "promoter_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN promoter_category = 'Promoter' THEN nps_response_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of respondents who are Promoters. Component of NPS score calculation."
    - name: "detractor_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN promoter_category = 'Detractor' THEN nps_response_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of respondents who are Detractors. Component of NPS score calculation."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_test_drive`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test drive conversion and engagement metrics tracking lead-to-sale conversion, feedback quality, and route engagement. Used by Sales VP and Dealer Operations to optimize test drive programs and conversion funnels."
  source: "`vibe_automotive_v1`.`customer`.`customer_test_drive`"
  dimensions:
    - name: "test_drive_status"
      expr: test_drive_status
      comment: "Status of the test drive (e.g., scheduled, completed, cancelled, no-show). Enables funnel stage analysis."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the test drive (e.g., interested, not interested, purchased). Tracks conversion intent signals."
    - name: "purchase_intent"
      expr: purchase_intent
      comment: "Customer's stated purchase intent after the test drive. Leading indicator for sales conversion."
    - name: "lead_source"
      expr: lead_source
      comment: "Source of the test drive lead (e.g., online, walk-in, referral). Informs marketing channel ROI."
    - name: "route_type"
      expr: route_type
      comment: "Type of test drive route (e.g., urban, highway, mixed). Informs route design for conversion optimization."
    - name: "vehicle_model"
      expr: vehicle_model
      comment: "Vehicle model tested. Enables model-level test drive conversion analysis."
    - name: "dealer_code"
      expr: dealer_code
      comment: "Dealer code where the test drive occurred. Enables dealer-level performance benchmarking."
    - name: "test_drive_month"
      expr: DATE_TRUNC('MONTH', test_drive_date)
      comment: "Month of test drive for trend analysis."
    - name: "converted_to_sale_flag"
      expr: converted_to_sale_flag
      comment: "Whether the test drive resulted in a vehicle sale. Primary conversion outcome flag."
  measures:
    - name: "total_test_drives"
      expr: COUNT(1)
      comment: "Total test drives conducted. Baseline volume metric for test drive program activity."
    - name: "completed_test_drives"
      expr: COUNT(CASE WHEN test_drive_status = 'completed' THEN customer_test_drive_id END)
      comment: "Number of completed test drives. Denominator for conversion rate calculations."
    - name: "converted_to_sale_count"
      expr: COUNT(CASE WHEN converted_to_sale_flag = TRUE THEN customer_test_drive_id END)
      comment: "Number of test drives that converted to a vehicle sale. Primary conversion outcome metric."
    - name: "test_drive_to_sale_conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN converted_to_sale_flag = TRUE THEN customer_test_drive_id END) / NULLIF(COUNT(CASE WHEN test_drive_status = 'completed' THEN customer_test_drive_id END), 0), 2)
      comment: "Percentage of completed test drives that converted to a sale. Core KPI for test drive program ROI and sales funnel efficiency."
    - name: "avg_distance_driven_km"
      expr: AVG(CAST(distance_driven_km AS DOUBLE))
      comment: "Average distance driven per test drive. Proxy for engagement depth; longer drives correlate with higher purchase intent."
    - name: "avg_feedback_score"
      expr: AVG(CAST(feedback_score AS DOUBLE))
      comment: "Average customer feedback score for test drives. Tracks test drive experience quality."
    - name: "avg_route_distance_km"
      expr: AVG(CAST(route_distance_km AS DOUBLE))
      comment: "Average planned route distance. Informs route design optimization for engagement and conversion."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN customer_test_drive_id END)
      comment: "Number of test drives requiring sales follow-up. Tracks pipeline nurturing workload."
    - name: "lead_conversion_count"
      expr: COUNT(CASE WHEN lead_conversion_flag = TRUE THEN customer_test_drive_id END)
      comment: "Number of test drives that converted a lead. Measures test drive effectiveness as a lead conversion tool."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_connected_service_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Connected and telematics service enrollment metrics tracking subscription health, data consumption, and revenue. Used by Digital Services VP and CFO to manage connected vehicle revenue streams and churn."
  source: "`vibe_automotive_v1`.`customer`.`connected_service_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the connected service enrollment (e.g., active, cancelled, trial, suspended)."
    - name: "service_type"
      expr: service_type
      comment: "Type of connected service (e.g., telematics, remote access, OTA, navigation). Enables service-level revenue analysis."
    - name: "service_plan_code"
      expr: service_plan_code
      comment: "Service plan code. Enables plan-level subscription economics analysis."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the customer enrolled (e.g., dealer, app, online). Informs channel acquisition cost analysis."
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing cycle of the subscription (e.g., monthly, annual). Informs revenue recognition and churn risk profiling."
    - name: "auto_renew"
      expr: auto_renew
      comment: "Whether the subscription auto-renews. Auto-renew rate is a leading indicator of retention."
    - name: "telematics_provider"
      expr: telematics_provider
      comment: "Telematics provider for the enrollment. Enables provider-level performance and cost analysis."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment for subscription cohort analysis."
    - name: "price_currency"
      expr: price_currency
      comment: "Currency of the subscription fee. Enables multi-currency revenue normalization."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total connected service enrollments. Baseline for subscription portfolio size."
    - name: "active_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'active' THEN connected_service_enrollment_id END)
      comment: "Number of currently active connected service subscriptions. Core KPI for digital revenue base."
    - name: "total_monthly_recurring_revenue"
      expr: SUM(CAST(monthly_fee AS DOUBLE))
      comment: "Total monthly recurring revenue from connected service subscriptions. Primary digital revenue KPI."
    - name: "avg_monthly_fee"
      expr: AVG(CAST(monthly_fee AS DOUBLE))
      comment: "Average monthly subscription fee. Benchmarks pricing strategy and plan mix."
    - name: "total_data_plan_gb"
      expr: SUM(CAST(data_plan_gb AS DOUBLE))
      comment: "Total data plan capacity provisioned across all enrollments. Informs network capacity planning."
    - name: "total_data_usage_gb"
      expr: SUM(CAST(data_usage_gb AS DOUBLE))
      comment: "Total data consumed across all active enrollments. Tracks data consumption trends for plan design."
    - name: "data_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(data_usage_gb AS DOUBLE)) / NULLIF(SUM(CAST(data_plan_gb AS DOUBLE)), 0), 2)
      comment: "Percentage of provisioned data capacity actually consumed. Low rates indicate over-provisioning; high rates indicate upgrade opportunity."
    - name: "auto_renew_enrollment_count"
      expr: COUNT(CASE WHEN auto_renew = TRUE THEN connected_service_enrollment_id END)
      comment: "Number of enrollments with auto-renewal enabled. Higher auto-renew rates indicate stronger retention and predictable revenue."
    - name: "auto_renew_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_renew = TRUE THEN connected_service_enrollment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments with auto-renewal enabled. Key retention health indicator for subscription business."
    - name: "trial_enrollment_count"
      expr: COUNT(CASE WHEN enrollment_status = 'trial' THEN connected_service_enrollment_id END)
      comment: "Number of enrollments currently in trial. Tracks trial-to-paid conversion pipeline size."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_vehicle_ownership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle ownership portfolio metrics tracking acquisition channels, ownership types, and fleet composition. Used by Sales VP and CX leadership to understand the owned vehicle base and drive retention and upsell strategies."
  source: "`vibe_automotive_v1`.`customer`.`vehicle_ownership`"
  dimensions:
    - name: "ownership_type"
      expr: ownership_type
      comment: "Type of vehicle ownership (e.g., purchased, leased, fleet, CPO). Segments the ownership base by commercial model."
    - name: "vehicle_ownership_status"
      expr: vehicle_ownership_status
      comment: "Current status of the ownership record (e.g., active, disposed, transferred). Filters to active owned vehicles."
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which the vehicle was acquired (e.g., dealer, online, fleet). Informs channel strategy."
    - name: "disposition_type"
      expr: disposition_type
      comment: "How the vehicle was disposed of (e.g., trade-in, sold, returned). Informs CPO and remarketing strategy."
    - name: "registration_country"
      expr: registration_country
      comment: "Country of vehicle registration. Enables geographic ownership base analysis."
    - name: "registration_state"
      expr: registration_state
      comment: "State/province of vehicle registration. Enables regional market penetration analysis."
    - name: "is_primary_vehicle"
      expr: is_primary_vehicle
      comment: "Whether this is the customer's primary vehicle. Distinguishes primary from secondary/fleet vehicles."
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year of vehicle acquisition for cohort-based ownership analysis."
    - name: "acquisition_month"
      expr: DATE_TRUNC('MONTH', acquisition_date)
      comment: "Month of vehicle acquisition for sales volume trending."
  measures:
    - name: "total_owned_vehicles"
      expr: COUNT(1)
      comment: "Total vehicle ownership records. Baseline for owned vehicle base size."
    - name: "active_owned_vehicles"
      expr: COUNT(CASE WHEN vehicle_ownership_status = 'active' THEN vehicle_ownership_id END)
      comment: "Number of currently active vehicle ownerships. Core metric for in-market vehicle base size."
    - name: "total_purchase_value"
      expr: SUM(CAST(purchase_price AS DOUBLE))
      comment: "Total purchase value of all vehicles in the ownership portfolio. Measures total customer investment in the brand."
    - name: "avg_purchase_price"
      expr: AVG(CAST(purchase_price AS DOUBLE))
      comment: "Average vehicle purchase price. Tracks average transaction value and product mix trends."
    - name: "avg_current_odometer_km"
      expr: AVG(CAST(current_odometer AS DOUBLE))
      comment: "Average current odometer reading across the owned fleet. Proxy for vehicle age and service demand forecasting."
    - name: "avg_odometer_at_acquisition_km"
      expr: AVG(CAST(odometer_at_acquisition AS DOUBLE))
      comment: "Average odometer at acquisition. Distinguishes new vs. used vehicle acquisitions and informs CPO program sizing."
    - name: "distinct_customers_with_vehicles"
      expr: COUNT(DISTINCT party_id)
      comment: "Number of distinct customers with at least one vehicle ownership record. Measures brand penetration in the customer base."
    - name: "leased_vehicle_count"
      expr: COUNT(CASE WHEN ownership_type = 'leased' THEN vehicle_ownership_id END)
      comment: "Number of leased vehicles. Tracks lease portfolio size for F&I and remarketing planning."
    - name: "disposed_vehicle_count"
      expr: COUNT(CASE WHEN vehicle_ownership_status = 'disposed' THEN vehicle_ownership_id END)
      comment: "Number of disposed vehicles. Tracks churn from the owned vehicle base and CPO/remarketing pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_fleet_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fleet account metrics tracking fleet portfolio value, credit exposure, and account health. Used by Fleet Sales VP and Finance to manage B2B fleet relationships and revenue concentration risk."
  source: "`vibe_automotive_v1`.`customer`.`customer_fleet_account`"
  dimensions:
    - name: "fleet_account_status"
      expr: fleet_account_status
      comment: "Current status of the fleet account (e.g., active, suspended, closed). Filters to active fleet relationships."
    - name: "fleet_account_type"
      expr: fleet_account_type
      comment: "Type of fleet account (e.g., corporate, government, rental). Segments fleet revenue by customer type."
    - name: "fleet_type"
      expr: fleet_type
      comment: "Fleet type classification (e.g., commercial, passenger, mixed). Informs product and service offering alignment."
    - name: "industry_sector"
      expr: industry_sector
      comment: "Industry sector of the fleet customer. Enables sector-level fleet penetration analysis."
    - name: "discount_tier"
      expr: discount_tier
      comment: "Discount tier assigned to the fleet account. Tracks discount concentration and margin impact."
    - name: "billing_currency"
      expr: billing_currency
      comment: "Billing currency for the fleet account. Enables multi-currency fleet revenue analysis."
    - name: "account_start_year"
      expr: YEAR(account_start_date)
      comment: "Year the fleet account was opened. Enables fleet account cohort analysis."
  measures:
    - name: "total_fleet_accounts"
      expr: COUNT(1)
      comment: "Total fleet accounts. Baseline for fleet customer base size."
    - name: "active_fleet_accounts"
      expr: COUNT(CASE WHEN fleet_account_status = 'active' THEN customer_fleet_account_id END)
      comment: "Number of active fleet accounts. Core KPI for fleet business health."
    - name: "total_annual_fleet_spend"
      expr: SUM(CAST(annual_spend AS DOUBLE))
      comment: "Total annual spend across all fleet accounts. Primary fleet revenue KPI."
    - name: "avg_annual_fleet_spend"
      expr: AVG(CAST(annual_spend AS DOUBLE))
      comment: "Average annual spend per fleet account. Benchmarks fleet account value and informs tiering strategy."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all fleet accounts. Measures total credit exposure to fleet customers."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per fleet account. Informs credit policy calibration."
    - name: "distinct_fleet_customers"
      expr: COUNT(DISTINCT party_id)
      comment: "Number of distinct fleet customers. Measures fleet customer base breadth."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer consent and data privacy compliance metrics tracking consent coverage, opt-in rates, and regulatory compliance posture. Used by DPO, Legal, and CMO to ensure GDPR/CCPA compliance and maximize marketable audience size."
  source: "`vibe_automotive_v1`.`customer`.`customer_consent_record`"
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent (e.g., marketing, data processing, telematics). Segments consent coverage by purpose."
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent record (e.g., granted, withdrawn, expired). Primary filter for marketable audience."
    - name: "consent_channel"
      expr: consent_channel
      comment: "Channel through which consent was obtained (e.g., dealer, online, app). Informs consent acquisition strategy."
    - name: "legal_basis"
      expr: legal_basis
      comment: "Legal basis for data processing (e.g., consent, legitimate interest, contract). Critical for GDPR compliance reporting."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Regulatory jurisdiction governing the consent (e.g., EU, California, Brazil). Enables jurisdiction-level compliance reporting."
    - name: "consent_purpose"
      expr: consent_purpose
      comment: "Purpose for which consent was granted (e.g., email marketing, SMS, profiling). Granular consent purpose analysis."
    - name: "double_opt_in_flag"
      expr: double_opt_in_flag
      comment: "Whether double opt-in was used. Tracks quality of consent collection method."
    - name: "consent_year"
      expr: YEAR(consent_date)
      comment: "Year consent was granted. Enables consent vintage analysis for expiry planning."
  measures:
    - name: "total_consent_records"
      expr: COUNT(1)
      comment: "Total consent records. Baseline for consent portfolio size."
    - name: "active_consent_count"
      expr: COUNT(CASE WHEN consent_status = 'granted' THEN customer_consent_record_id END)
      comment: "Number of currently active/granted consent records. Defines the legally marketable audience size."
    - name: "withdrawn_consent_count"
      expr: COUNT(CASE WHEN consent_status = 'withdrawn' THEN customer_consent_record_id END)
      comment: "Number of withdrawn consent records. Tracks opt-out volume and regulatory risk exposure."
    - name: "opt_in_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_granted_flag = TRUE THEN customer_consent_record_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records with active opt-in. Measures marketable audience coverage rate."
    - name: "double_opt_in_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN double_opt_in_flag = TRUE THEN customer_consent_record_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consents collected via double opt-in. Higher rates indicate stronger consent quality and lower regulatory risk."
    - name: "distinct_consented_customers"
      expr: COUNT(DISTINCT party_id)
      comment: "Number of distinct customers with at least one consent record. Measures consent program reach."
    - name: "expired_consent_count"
      expr: COUNT(CASE WHEN consent_status = 'expired' THEN customer_consent_record_id END)
      comment: "Number of expired consent records. Tracks consent refresh workload and compliance gap."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer service case metrics tracking resolution performance, escalation rates, and SLA compliance. Used by CX VP and Service Operations to manage service quality, agent productivity, and customer satisfaction."
  source: "`vibe_automotive_v1`.`customer`.`case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the case (e.g., open, closed, escalated, pending). Primary funnel stage dimension."
    - name: "case_type"
      expr: case_type
      comment: "Type of customer case (e.g., complaint, inquiry, warranty, recall). Segments case volume by nature."
    - name: "case_category"
      expr: case_category
      comment: "Category of the case. Enables root cause analysis of case drivers."
    - name: "priority"
      expr: priority
      comment: "Case priority level (e.g., high, medium, low). Tracks priority distribution and SLA compliance by tier."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of the case. Tracks escalation frequency and severity distribution."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the case was opened (e.g., phone, email, chat, dealer). Informs channel capacity planning."
    - name: "resolution_code"
      expr: resolution_code
      comment: "Resolution code applied to closed cases. Enables resolution pattern analysis."
    - name: "dealer_code"
      expr: dealer_code
      comment: "Dealer associated with the case. Enables dealer-level case volume and quality analysis."
    - name: "opened_month"
      expr: DATE_TRUNC('MONTH', opened_timestamp)
      comment: "Month the case was opened. Enables case volume trend analysis."
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total cases opened. Baseline volume metric for service demand."
    - name: "open_cases"
      expr: COUNT(CASE WHEN case_status = 'open' THEN case_id END)
      comment: "Number of currently open cases. Tracks active service backlog."
    - name: "closed_cases"
      expr: COUNT(CASE WHEN case_status = 'closed' THEN case_id END)
      comment: "Number of closed cases. Denominator for resolution rate calculations."
    - name: "escalated_cases"
      expr: COUNT(CASE WHEN escalation_level IS NOT NULL AND escalation_level != '' THEN case_id END)
      comment: "Number of escalated cases. Escalation rate is a key CX quality indicator."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_level IS NOT NULL AND escalation_level != '' THEN case_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases that were escalated. High escalation rates signal systemic service quality issues."
    - name: "case_resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN case_status = 'closed' THEN case_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases that have been resolved/closed. Core service efficiency KPI."
    - name: "distinct_customers_with_cases"
      expr: COUNT(DISTINCT party_id)
      comment: "Number of distinct customers who opened cases. Measures service demand breadth across the customer base."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer segmentation portfolio metrics tracking segment size, confidence, and revenue potential. Used by CMO and Customer Analytics to manage segmentation strategy and prioritize marketing investment."
  source: "`vibe_automotive_v1`.`customer`.`customer_segment`"
  dimensions:
    - name: "segment_category"
      expr: segment_category
      comment: "Category of the customer segment (e.g., behavioral, demographic, value-based). Enables segment type analysis."
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment definition (e.g., active, draft, archived). Filters to production segments."
    - name: "revenue_potential_band"
      expr: revenue_potential_band
      comment: "Revenue potential band of the segment (e.g., high, medium, low). Prioritizes marketing investment allocation."
    - name: "target_customer_type"
      expr: target_customer_type
      comment: "Target customer type for the segment (e.g., individual, fleet, SME). Aligns segment strategy with customer type."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the segment. Enables regional segmentation strategy analysis."
    - name: "is_active"
      expr: is_active
      comment: "Whether the segment is currently active. Filters to deployable segments."
    - name: "primary_vehicle_interest"
      expr: primary_vehicle_interest
      comment: "Primary vehicle interest of the segment. Links segmentation to product planning."
  measures:
    - name: "total_segments"
      expr: COUNT(1)
      comment: "Total number of customer segments defined. Baseline for segmentation portfolio size."
    - name: "active_segments"
      expr: COUNT(CASE WHEN is_active = TRUE THEN customer_segment_id END)
      comment: "Number of currently active segments. Tracks deployable segmentation coverage."
    - name: "total_estimated_segment_population"
      expr: SUM(CAST(estimated_segment_size AS DOUBLE))
      comment: "Total estimated customer population across all segments. Measures segmentation coverage of the customer base."
    - name: "avg_segment_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average model confidence score across segments. Tracks segmentation model quality."
    - name: "avg_estimated_segment_size"
      expr: AVG(CAST(estimated_segment_size AS DOUBLE))
      comment: "Average estimated size per segment. Benchmarks segment granularity for targeting effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer promotion economics metrics tracking budget deployment, discount exposure, and promotional ROI signals. Used by Marketing VP and Finance to manage promotional spend efficiency and customer acquisition costs."
  source: "`vibe_automotive_v1`.`customer`.`promotion`"
  dimensions:
    - name: "promotion_type"
      expr: promotion_type
      comment: "Type of promotion (e.g., discount, cashback, loyalty bonus, referral). Segments promotional spend by mechanism."
    - name: "promotion_status"
      expr: promotion_status
      comment: "Current status of the promotion (e.g., active, expired, draft). Filters to live promotions for operational reporting."
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount applied (e.g., percentage, fixed amount). Informs discount structure analysis."
    - name: "channel"
      expr: channel
      comment: "Channel through which the promotion is delivered (e.g., email, dealer, app). Enables channel-level promotion ROI analysis."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Target customer segment for the promotion. Links promotional investment to segment strategy."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Whether the promotion is exclusive (not stackable). Tracks exclusive vs. combinable promotion mix."
    - name: "loyalty_program_flag"
      expr: loyalty_program_flag
      comment: "Whether the promotion is tied to the loyalty program. Tracks loyalty-linked promotional investment."
    - name: "promotion_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the promotion started. Enables promotional calendar analysis."
  measures:
    - name: "total_promotions"
      expr: COUNT(1)
      comment: "Total promotions defined. Baseline for promotional portfolio size."
    - name: "active_promotions"
      expr: COUNT(CASE WHEN promotion_status = 'active' THEN promotion_id END)
      comment: "Number of currently active promotions. Tracks live promotional exposure."
    - name: "total_promotion_budget"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated across all promotions. Measures total promotional investment."
    - name: "total_max_discount_exposure"
      expr: SUM(CAST(max_discount_amount AS DOUBLE))
      comment: "Total maximum discount exposure across all promotions. Measures worst-case margin impact of active promotions."
    - name: "avg_discount_value"
      expr: AVG(CAST(discount_value AS DOUBLE))
      comment: "Average discount value per promotion. Benchmarks discount generosity across the promotional portfolio."
    - name: "total_cltv_impact_estimate"
      expr: SUM(CAST(cltv_impact_estimate AS DOUBLE))
      comment: "Total estimated CLTV impact from promotions. Measures expected long-term value creation from promotional investment."
    - name: "avg_nps_impact_estimate"
      expr: AVG(CAST(nps_impact_estimate AS DOUBLE))
      comment: "Average estimated NPS impact per promotion. Tracks expected satisfaction uplift from promotional programs."
    - name: "avg_min_purchase_amount"
      expr: AVG(CAST(min_purchase_amount AS DOUBLE))
      comment: "Average minimum purchase threshold required to trigger a promotion. Informs promotion accessibility and basket size strategy."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_cltv`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer Lifetime Value (CLTV) metrics."
  source: "`vibe_automotive_v1`.`customer`.`cltv_record`"
  dimensions:
    - name: "calculation_date"
      expr: calculation_date
      comment: "Date of CLTV calculation."
    - name: "segment_at_calculation"
      expr: segment_at_calculation
      comment: "Customer segment at time of CLTV calculation."
    - name: "model_version"
      expr: model_version
      comment: "Version of the CLTV model used."
  measures:
    - name: "total_cltv_amount"
      expr: SUM(CAST(cltv_amount AS DOUBLE))
      comment: "Sum of CLTV amount across customers."
    - name: "avg_cltv_amount"
      expr: AVG(CAST(cltv_amount AS DOUBLE))
      comment: "Average CLTV amount."
    - name: "avg_churn_probability"
      expr: AVG(CAST(churn_probability AS DOUBLE))
      comment: "Average churn probability."
    - name: "avg_retention_probability"
      expr: AVG(CAST(retention_probability AS DOUBLE))
      comment: "Average retention probability."
    - name: "total_revenue_to_date"
      expr: SUM(CAST(revenue_to_date AS DOUBLE))
      comment: "Total revenue to date from CLTV records."
$$;