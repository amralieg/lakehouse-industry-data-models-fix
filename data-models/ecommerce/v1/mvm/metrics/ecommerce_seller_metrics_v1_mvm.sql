-- Metric views for domain: seller | Business: Ecommerce | Version: 1 | Generated on: 2026-05-05 00:54:17

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`seller_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the seller population — active seller counts, KYC compliance rates, commission economics, and GMV attribution. Used by Seller Growth, Compliance, and Finance teams to steer seller acquisition, health, and monetisation strategy."
  source: "`ecommerce_ecm`.`seller`.`seller_profile`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current lifecycle status of the seller account (e.g. Active, Suspended, Closed). Primary segmentation for seller health dashboards."
    - name: "business_type"
      expr: business_type
      comment: "Legal or operational business type of the seller (e.g. Individual, SMB, Enterprise). Used to segment seller economics by business model."
    - name: "kyc_status"
      expr: kyc_status
      comment: "Know-Your-Customer verification status. Critical for compliance reporting and onboarding funnel analysis."
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current onboarding stage of the seller. Used to track funnel conversion from registration to live selling."
    - name: "primary_category"
      expr: primary_category
      comment: "Primary product category the seller operates in. Enables category-level seller economics analysis."
    - name: "incorporation_country"
      expr: incorporation_country
      comment: "Country of seller incorporation. Supports geographic segmentation for regulatory and market expansion decisions."
    - name: "platform_join_year_month"
      expr: DATE_TRUNC('MONTH', platform_join_date)
      comment: "Month the seller joined the platform. Used for cohort analysis and seller vintage performance tracking."
    - name: "kyc_completed_year_month"
      expr: DATE_TRUNC('MONTH', kyc_completed_date)
      comment: "Month KYC was completed. Used to measure compliance clearance velocity and backlog trends."
  measures:
    - name: "total_sellers"
      expr: COUNT(DISTINCT seller_profile_id)
      comment: "Total number of distinct seller profiles. Baseline headcount metric for seller base sizing and growth tracking."
    - name: "active_sellers"
      expr: COUNT(DISTINCT CASE WHEN account_status = 'Active' THEN seller_profile_id END)
      comment: "Number of sellers with an Active account status. Core operational metric for marketplace supply health."
    - name: "kyc_compliant_sellers"
      expr: COUNT(DISTINCT CASE WHEN kyc_status = 'Approved' THEN seller_profile_id END)
      comment: "Number of sellers who have passed KYC verification. Directly tied to regulatory compliance and risk exposure."
    - name: "total_gmv_attribution"
      expr: SUM(CAST(gmv_attribution AS DOUBLE))
      comment: "Total GMV attributed to sellers at the profile level. Measures the aggregate economic contribution of the seller base."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across seller profiles. Informs pricing strategy and revenue yield per seller."
    - name: "avg_seller_rating"
      expr: AVG(CAST(seller_rating AS DOUBLE))
      comment: "Average seller rating across all profiles. Proxy for overall marketplace quality and buyer trust."
    - name: "avg_gmv_attribution_per_seller"
      expr: AVG(CAST(gmv_attribution AS DOUBLE))
      comment: "Average GMV attributed per seller profile. Measures seller productivity and identifies concentration risk."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`seller_gmv_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial settlement KPIs tracking gross and net GMV flows, commission extraction, payout efficiency, and promotional subsidy costs. Primary source of truth for seller monetisation and payout operations."
  source: "`ecommerce_ecm`.`seller`.`gmv_settlement`"
  dimensions:
    - name: "settlement_status"
      expr: settlement_status
      comment: "Current status of the settlement record (e.g. Pending, Completed, Failed). Used to monitor payout pipeline health."
    - name: "settlement_type"
      expr: settlement_type
      comment: "Type of settlement transaction (e.g. Regular, Adjustment, Reversal). Enables breakdown of settlement economics by transaction class."
    - name: "channel"
      expr: channel
      comment: "Sales channel through which the GMV was generated (e.g. Web, Mobile, API). Supports channel-level revenue attribution."
    - name: "gmv_source"
      expr: gmv_source
      comment: "Origin system or event type that generated the GMV. Used for reconciliation and source-of-truth validation."
    - name: "payout_method"
      expr: payout_method
      comment: "Method used to disburse funds to the seller (e.g. Bank Transfer, Wallet). Informs payout operations and cost analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the settlement is denominated. Required for multi-currency financial reporting."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Boolean flag indicating whether the settlement record has a compliance issue. Used for risk and audit reporting."
    - name: "settlement_month"
      expr: DATE_TRUNC('MONTH', settlement_date)
      comment: "Month of settlement. Primary time dimension for monthly financial close and trend analysis."
    - name: "payout_month"
      expr: DATE_TRUNC('MONTH', payout_date)
      comment: "Month the payout was disbursed. Used to track payout lag and cash flow timing."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Start month of the settlement period. Used for period-over-period GMV trend analysis."
  measures:
    - name: "total_gross_gmv"
      expr: SUM(CAST(gross_gmv_amount AS DOUBLE))
      comment: "Total gross GMV across all settlement records. Top-line marketplace revenue metric used in executive reporting and investor communications."
    - name: "total_net_gmv"
      expr: SUM(CAST(net_gmv_amount AS DOUBLE))
      comment: "Total net GMV after returns and adjustments. Reflects true economic value transacted on the platform."
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission revenue extracted from seller settlements. Core marketplace monetisation metric."
    - name: "total_payout_amount"
      expr: SUM(CAST(payout_amount AS DOUBLE))
      comment: "Total amount disbursed to sellers. Measures cash outflow obligations and payout operations scale."
    - name: "total_returns_amount"
      expr: SUM(CAST(returns_amount AS DOUBLE))
      comment: "Total value of returns deducted from GMV. High returns signal quality or fulfilment issues requiring intervention."
    - name: "total_promotional_subsidy"
      expr: SUM(CAST(promotional_subsidy_amount AS DOUBLE))
      comment: "Total promotional subsidy cost borne by the platform. Measures the financial cost of promotional campaigns against GMV uplift."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across settlements. Required for tax compliance reporting and remittance calculations."
    - name: "settlement_count"
      expr: COUNT(DISTINCT gmv_settlement_id)
      comment: "Number of distinct settlement records processed. Measures operational throughput of the settlement pipeline."
    - name: "avg_gross_gmv_per_settlement"
      expr: AVG(CAST(gross_gmv_amount AS DOUBLE))
      comment: "Average gross GMV per settlement record. Indicates typical transaction size and helps detect anomalies."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied across settlements. Used for multi-currency exposure monitoring."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`seller_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Seller performance scorecard KPIs covering GMV output, defect rates, cancellation rates, return rates, and NPS contribution. Used by Seller Success, Marketplace Quality, and Operations teams to identify at-risk sellers and reward top performers."
  source: "`ecommerce_ecm`.`seller`.`scorecard`"
  dimensions:
    - name: "period_type"
      expr: period_type
      comment: "Granularity of the scorecard period (e.g. Weekly, Monthly, Quarterly). Enables consistent period-over-period comparisons."
    - name: "suspension_flag"
      expr: suspension_flag
      comment: "Boolean indicating whether the seller is currently suspended. Used to segment performance metrics by suspension risk cohort."
    - name: "tier_change_flag"
      expr: tier_change_flag
      comment: "Boolean indicating whether the seller changed tier in this scorecard period. Used to track tier mobility and its performance impact."
    - name: "bsr"
      expr: bsr
      comment: "Best Seller Rank category. Used to segment sellers by marketplace visibility and competitive standing."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Start month of the scorecard period. Primary time dimension for trend analysis."
    - name: "period_end_month"
      expr: DATE_TRUNC('MONTH', period_end_date)
      comment: "End month of the scorecard period. Used for period boundary alignment in reporting."
    - name: "last_tier_change_month"
      expr: DATE_TRUNC('MONTH', last_tier_change_date)
      comment: "Month of the most recent tier change. Used to analyse tier transition patterns and their performance correlation."
  measures:
    - name: "total_gmv"
      expr: SUM(CAST(gmv AS DOUBLE))
      comment: "Total GMV generated by sellers as recorded in scorecards. Measures aggregate seller output for the period."
    - name: "avg_order_value"
      expr: AVG(CAST(aov AS DOUBLE))
      comment: "Average order value across seller scorecards. Indicates basket size trends and upsell effectiveness."
    - name: "avg_order_defect_rate"
      expr: AVG(CAST(order_defect_rate AS DOUBLE))
      comment: "Average order defect rate across sellers. Critical quality metric — high ODR triggers seller warnings and potential suspension."
    - name: "avg_cancellation_rate"
      expr: AVG(CAST(cancellation_rate AS DOUBLE))
      comment: "Average seller-initiated cancellation rate. Elevated rates signal inventory or fulfilment problems requiring intervention."
    - name: "avg_late_shipment_rate"
      expr: AVG(CAST(late_shipment_rate AS DOUBLE))
      comment: "Average late shipment rate across sellers. Directly impacts buyer experience and marketplace SLA compliance."
    - name: "avg_return_rate"
      expr: AVG(CAST(return_rate AS DOUBLE))
      comment: "Average return rate across seller scorecards. High return rates indicate product quality or listing accuracy issues."
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average listing-to-purchase conversion rate. Measures seller catalogue effectiveness and pricing competitiveness."
    - name: "avg_inventory_health_score"
      expr: AVG(CAST(inventory_health_score AS DOUBLE))
      comment: "Average inventory health score. Low scores indicate stockout risk or excess inventory, both of which reduce GMV."
    - name: "avg_nps_contribution_score"
      expr: AVG(CAST(nps_contribution_score AS DOUBLE))
      comment: "Average NPS contribution score per seller. Measures how individual sellers impact overall marketplace buyer satisfaction."
    - name: "avg_dsr"
      expr: AVG(CAST(dsr AS DOUBLE))
      comment: "Average Detailed Seller Rating. Composite quality signal used in tier eligibility and search ranking decisions."
    - name: "suspended_seller_count"
      expr: COUNT(DISTINCT CASE WHEN suspension_flag = TRUE THEN seller_profile_id END)
      comment: "Number of distinct sellers currently suspended. Measures marketplace enforcement activity and supply risk."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`seller_onboarding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Seller onboarding funnel KPIs tracking application volumes, compliance pass rates, estimated GMV pipeline, and time-to-live. Used by Seller Acquisition and Compliance teams to optimise the onboarding funnel and forecast new seller GMV contribution."
  source: "`ecommerce_ecm`.`seller`.`onboarding`"
  dimensions:
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current stage in the onboarding workflow (e.g. Submitted, Under Review, Approved, Rejected). Primary funnel stage dimension."
    - name: "business_model"
      expr: business_model
      comment: "Seller business model (e.g. FBA, FBM, Dropship). Used to segment onboarding economics by fulfilment model."
    - name: "fulfillment_model"
      expr: fulfillment_model
      comment: "Fulfilment model selected during onboarding. Informs operational capacity planning and SLA commitments."
    - name: "category_requested"
      expr: category_requested
      comment: "Product category the seller applied to sell in. Used to track category-level supply pipeline and approval rates."
    - name: "compliance_check_passed"
      expr: compliance_check_passed
      comment: "Boolean indicating whether the seller passed the compliance check. Key gate metric in the onboarding funnel."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Boolean indicating whether the onboarding case was escalated. Used to measure operational complexity and resource demand."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month the onboarding application was submitted. Primary time dimension for funnel volume trend analysis."
    - name: "go_live_month"
      expr: DATE_TRUNC('MONTH', go_live_date)
      comment: "Month the seller went live. Used to measure onboarding throughput and time-to-revenue."
  measures:
    - name: "total_applications"
      expr: COUNT(DISTINCT onboarding_id)
      comment: "Total number of onboarding applications submitted. Measures top-of-funnel seller acquisition volume."
    - name: "compliance_passed_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_check_passed = TRUE THEN onboarding_id END)
      comment: "Number of applications that passed the compliance check. Measures compliance gate throughput and identifies bottlenecks."
    - name: "escalated_application_count"
      expr: COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN onboarding_id END)
      comment: "Number of onboarding applications that required escalation. High escalation rates signal process inefficiency or fraud risk."
    - name: "total_estimated_gmv"
      expr: SUM(CAST(estimated_gmv_amount AS DOUBLE))
      comment: "Total estimated GMV from sellers in the onboarding pipeline. Measures the forward-looking revenue potential of the acquisition funnel."
    - name: "total_net_estimated_gmv"
      expr: SUM(CAST(net_estimated_gmv_amount AS DOUBLE))
      comment: "Total net estimated GMV (after deductions) from the onboarding pipeline. More conservative GMV forecast for financial planning."
    - name: "total_estimated_commission"
      expr: SUM(CAST(estimated_commission_amount AS DOUBLE))
      comment: "Total estimated commission revenue from sellers in the onboarding pipeline. Directly informs revenue forecasting for new seller cohorts."
    - name: "avg_seller_rating_at_onboarding"
      expr: AVG(CAST(seller_rating AS DOUBLE))
      comment: "Average seller rating at the time of onboarding application. Used to assess the quality of incoming seller cohorts."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`seller_commission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commission structure KPIs covering rate economics, fee components, and negotiated vs standard commission distribution. Used by Finance, Seller Relations, and Pricing teams to govern commission policy and model revenue impact of rate changes."
  source: "`ecommerce_ecm`.`seller`.`commission`"
  dimensions:
    - name: "commission_type"
      expr: commission_type
      comment: "Type of commission structure (e.g. Flat Rate, Tiered, Category-Based). Used to segment commission economics by structure type."
    - name: "commission_status"
      expr: commission_status
      comment: "Lifecycle status of the commission record (e.g. Active, Expired, Pending). Used to filter to currently applicable rates."
    - name: "product_category_code"
      expr: product_category_code
      comment: "Product category to which the commission applies. Enables category-level commission rate benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which commission amounts are denominated. Required for multi-currency commission reporting."
    - name: "is_negotiated"
      expr: is_negotiated
      comment: "Boolean indicating whether the commission rate was individually negotiated. Used to track negotiated vs standard rate distribution and margin impact."
    - name: "tax_applicable"
      expr: tax_applicable
      comment: "Boolean indicating whether tax applies to this commission. Required for tax-inclusive vs tax-exclusive revenue reporting."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the commission rate became effective. Used for rate change timeline analysis."
    - name: "effective_until_month"
      expr: DATE_TRUNC('MONTH', effective_until)
      comment: "Month the commission rate expires. Used to identify upcoming rate expirations requiring renewal action."
  measures:
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(rate_percent AS DOUBLE))
      comment: "Average commission rate percentage across active commission structures. Core pricing metric for revenue yield management."
    - name: "avg_referral_fee_pct"
      expr: AVG(CAST(referral_fee_percent AS DOUBLE))
      comment: "Average referral fee percentage. Measures the referral monetisation rate across seller categories."
    - name: "avg_fulfillment_fee_rate_pct"
      expr: AVG(CAST(fulfillment_fee_rate_percent AS DOUBLE))
      comment: "Average fulfilment fee rate. Used to benchmark fulfilment cost recovery against operational costs."
    - name: "total_subscription_fee_revenue"
      expr: SUM(CAST(subscription_fee_amount AS DOUBLE))
      comment: "Total subscription fee revenue across commission records. Measures the recurring fee revenue stream from seller subscriptions."
    - name: "total_minimum_commission"
      expr: SUM(CAST(minimum_commission_amount AS DOUBLE))
      comment: "Total minimum commission floor across all commission structures. Measures the guaranteed revenue floor from the seller base."
    - name: "total_cap_amount"
      expr: SUM(CAST(cap_amount AS DOUBLE))
      comment: "Total commission cap amount across structures. Measures the maximum commission ceiling and its revenue constraint impact."
    - name: "negotiated_commission_count"
      expr: COUNT(DISTINCT CASE WHEN is_negotiated = TRUE THEN commission_id END)
      comment: "Number of individually negotiated commission agreements. High counts indicate margin leakage risk from bespoke deals."
    - name: "avg_promotional_coop_fee_pct"
      expr: AVG(CAST(promotional_coop_fee_percent AS DOUBLE))
      comment: "Average promotional co-op fee percentage. Measures the cost-sharing rate for promotional activities between platform and sellers."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`seller_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Seller policy violation and enforcement KPIs tracking violation volumes, financial penalties, GMV at risk, and enforcement outcomes. Used by Trust & Safety, Legal, and Compliance teams to monitor marketplace integrity and regulatory exposure."
  source: "`ecommerce_ecm`.`seller`.`violation`"
  dimensions:
    - name: "violation_type"
      expr: violation_type
      comment: "Category of policy violation (e.g. Counterfeit, Fraud, SLA Breach). Primary dimension for violation root-cause analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the violation (e.g. Low, Medium, High, Critical). Used to prioritise enforcement resources."
    - name: "enforcement_action"
      expr: enforcement_action
      comment: "Action taken in response to the violation (e.g. Warning, Fine, Suspension, Termination). Measures enforcement intensity distribution."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the violation case (e.g. Open, Under Investigation, Resolved, Appealed). Used to track case resolution pipeline."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the investigation process. Used to monitor investigation throughput and backlog."
    - name: "appeal_eligibility"
      expr: appeal_eligibility
      comment: "Boolean indicating whether the seller is eligible to appeal the violation. Used to segment violations by appeal risk."
    - name: "compliance_region"
      expr: compliance_region
      comment: "Geographic or regulatory region where the violation occurred. Enables regional compliance risk benchmarking."
    - name: "detection_method"
      expr: detection_method
      comment: "Method by which the violation was detected (e.g. Automated, Manual Review, Buyer Report). Informs detection capability investment decisions."
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_timestamp)
      comment: "Month the violation was detected. Primary time dimension for violation trend and seasonality analysis."
    - name: "suspension_effective_month"
      expr: DATE_TRUNC('MONTH', suspension_effective_date)
      comment: "Month a suspension became effective. Used to track enforcement action timing and supply impact."
  measures:
    - name: "total_violations"
      expr: COUNT(DISTINCT violation_id)
      comment: "Total number of distinct policy violations recorded. Baseline metric for marketplace integrity health."
    - name: "total_fine_amount"
      expr: SUM(CAST(fine_amount AS DOUBLE))
      comment: "Total financial penalties levied on sellers for violations. Measures enforcement revenue and deterrence effectiveness."
    - name: "total_gmv_at_violation"
      expr: SUM(CAST(seller_gmv_at_violation AS DOUBLE))
      comment: "Total GMV associated with sellers at the time of their violation. Measures the economic scale of at-risk seller activity."
    - name: "avg_fine_amount"
      expr: AVG(CAST(fine_amount AS DOUBLE))
      comment: "Average fine amount per violation. Used to benchmark penalty severity and assess deterrence calibration."
    - name: "avg_gmv_at_violation"
      expr: AVG(CAST(seller_gmv_at_violation AS DOUBLE))
      comment: "Average seller GMV at the time of violation. Indicates whether high-GMV sellers are disproportionately represented in violations."
    - name: "appeal_eligible_violation_count"
      expr: COUNT(DISTINCT CASE WHEN appeal_eligibility = TRUE THEN violation_id END)
      comment: "Number of violations eligible for appeal. Measures potential enforcement reversal risk and legal exposure."
    - name: "unique_sellers_with_violations"
      expr: COUNT(DISTINCT seller_profile_id)
      comment: "Number of distinct sellers with at least one violation. Measures the breadth of compliance risk across the seller base."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`seller_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Seller agreement and contract KPIs covering agreement status, financial terms, performance scores, and GMV attribution. Used by Legal, Seller Relations, and Finance teams to manage contract compliance, renewal risk, and commercial terms governance."
  source: "`ecommerce_ecm`.`seller`.`agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of seller agreement (e.g. Standard, Enterprise, Marketplace). Used to segment contract economics by agreement class."
    - name: "seller_agreement_status"
      expr: seller_agreement_status
      comment: "Current status of the seller agreement (e.g. Active, Expired, Terminated). Primary dimension for contract lifecycle management."
    - name: "seller_tier"
      expr: seller_tier
      comment: "Seller tier at the time of agreement. Used to analyse commercial terms by seller tier and identify tier-based pricing patterns."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the agreement. Used to identify agreements with outstanding compliance obligations."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction governing the agreement. Required for regulatory reporting and cross-border contract risk analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which agreement financial terms are denominated. Required for multi-currency contract value reporting."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the agreement became effective. Used for contract vintage analysis and cohort-based performance tracking."
    - name: "renewal_month"
      expr: DATE_TRUNC('MONTH', renewal_date)
      comment: "Month the agreement is due for renewal. Used to manage renewal pipeline and prevent unintended lapses."
  measures:
    - name: "total_agreements"
      expr: COUNT(DISTINCT agreement_id)
      comment: "Total number of distinct seller agreements. Measures the scale of the contractual seller base."
    - name: "active_agreements"
      expr: COUNT(DISTINCT CASE WHEN seller_agreement_status = 'Active' THEN agreement_id END)
      comment: "Number of currently active seller agreements. Core metric for contract coverage and seller relationship health."
    - name: "total_gmv_attribution"
      expr: SUM(CAST(gmv_attribution AS DOUBLE))
      comment: "Total GMV attributed under seller agreements. Measures the economic value governed by formal contractual relationships."
    - name: "avg_performance_score"
      expr: AVG(CAST(performance_score AS DOUBLE))
      comment: "Average seller performance score recorded in agreements. Used to assess contractual performance compliance and renewal eligibility."
    - name: "total_early_termination_fee"
      expr: SUM(CAST(early_termination_fee AS DOUBLE))
      comment: "Total early termination fees across agreements. Measures financial exposure from contract terminations and churn cost."
    - name: "avg_gmv_attribution_per_agreement"
      expr: AVG(CAST(gmv_attribution AS DOUBLE))
      comment: "Average GMV attributed per agreement. Indicates the typical economic scale of a seller agreement and identifies outliers."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`seller_verification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Seller document verification and KYC KPIs tracking verification throughput, compliance status, risk classification, and GMV at verification. Used by Compliance, Risk, and Onboarding teams to manage regulatory document obligations and identify verification bottlenecks."
  source: "`ecommerce_ecm`.`seller`.`verification`"
  dimensions:
    - name: "verification_type"
      expr: verification_type
      comment: "Type of verification being performed (e.g. Identity, Business Registration, Tax). Used to segment verification workload by document type."
    - name: "document_verification_status"
      expr: document_verification_status
      comment: "Status of the document verification (e.g. Pending, Approved, Rejected). Primary funnel stage dimension for verification pipeline management."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status resulting from verification. Used for regulatory reporting and seller access control decisions."
    - name: "risk_classification"
      expr: risk_classification
      comment: "Risk tier assigned to the seller based on verification findings (e.g. Low, Medium, High). Drives enhanced due diligence workflows."
    - name: "workflow_status"
      expr: workflow_status
      comment: "Current status in the verification workflow. Used to monitor operational throughput and identify process bottlenecks."
    - name: "document_type"
      expr: document_type
      comment: "Type of document submitted for verification (e.g. Passport, Business Licence, Tax Certificate). Used to track document mix and expiry risk."
    - name: "is_platform_issued"
      expr: is_platform_issued
      comment: "Boolean indicating whether the document was issued by the platform itself. Used to distinguish platform-issued credentials from external documents."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month the verification was submitted. Primary time dimension for verification volume trend analysis."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the verification became effective. Used to track verification clearance velocity."
  measures:
    - name: "total_verifications"
      expr: COUNT(DISTINCT verification_id)
      comment: "Total number of distinct verification records. Measures the scale of the compliance verification workload."
    - name: "approved_verifications"
      expr: COUNT(DISTINCT CASE WHEN document_verification_status = 'Approved' THEN verification_id END)
      comment: "Number of verifications that were approved. Measures compliance clearance throughput."
    - name: "rejected_verifications"
      expr: COUNT(DISTINCT CASE WHEN document_verification_status = 'Rejected' THEN verification_id END)
      comment: "Number of verifications that were rejected. High rejection rates signal document quality issues or fraud patterns."
    - name: "high_risk_seller_count"
      expr: COUNT(DISTINCT CASE WHEN risk_classification = 'High' THEN seller_profile_id END)
      comment: "Number of distinct sellers classified as high risk. Measures the scale of enhanced due diligence obligations."
    - name: "total_gmv_at_verification"
      expr: SUM(CAST(seller_gmv_at_verification AS DOUBLE))
      comment: "Total GMV associated with sellers at the time of their verification. Measures the economic scale of the verified seller population."
    - name: "avg_gmv_at_verification"
      expr: AVG(CAST(seller_gmv_at_verification AS DOUBLE))
      comment: "Average seller GMV at the time of verification. Used to assess whether high-GMV sellers are receiving timely verification."
$$;