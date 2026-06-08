-- Metric views for domain: customer | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 20:30:11

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core customer account metrics tracking account base, risk exposure, and strategic segmentation for semiconductor customer portfolio management"
  source: "`semiconductors_ecm`.`customer`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current operational status of the customer account"
    - name: "account_type"
      expr: account_type
      comment: "Classification of account type (e.g., direct, distributor, OEM)"
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Target industry vertical for the account (e.g., automotive, mobile, IoT, AI)"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the account for regional performance analysis"
    - name: "sales_region"
      expr: sales_region
      comment: "Sales territory region assignment"
    - name: "revenue_tier"
      expr: revenue_tier
      comment: "Revenue tier classification for account segmentation"
    - name: "strategic_classification"
      expr: strategic_classification
      comment: "Strategic importance classification of the account"
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating assigned to the account for risk assessment"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the account for regulatory tracking"
    - name: "creation_year"
      expr: YEAR(creation_date)
      comment: "Year the account was created for cohort analysis"
    - name: "creation_quarter"
      expr: CONCAT(CAST(YEAR(creation_date) AS STRING), '-Q', CAST(QUARTER(creation_date) AS STRING))
      comment: "Quarter the account was created for cohort tracking"
    - name: "last_order_year"
      expr: YEAR(last_order_date)
      comment: "Year of last order for recency analysis"
  measures:
    - name: "total_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Total number of unique customer accounts in the semiconductor portfolio"
    - name: "active_accounts"
      expr: COUNT(DISTINCT CASE WHEN account_status = 'Active' THEN account_id END)
      comment: "Number of active customer accounts currently transacting"
    - name: "total_risk_exposure"
      expr: SUM(CAST(risk_score AS DOUBLE))
      comment: "Total risk exposure across all accounts for portfolio risk management"
    - name: "avg_account_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score per account for risk profile assessment"
    - name: "high_risk_accounts"
      expr: COUNT(DISTINCT CASE WHEN CAST(risk_score AS DOUBLE) > 70 THEN account_id END)
      comment: "Number of accounts with high risk scores requiring attention"
    - name: "strategic_accounts"
      expr: COUNT(DISTINCT CASE WHEN strategic_classification IN ('Tier 1', 'Strategic', 'Key Account') THEN account_id END)
      comment: "Number of strategically important accounts driving business growth"
    - name: "tax_exempt_accounts"
      expr: COUNT(DISTINCT CASE WHEN tax_exempt_flag = TRUE THEN account_id END)
      comment: "Number of tax-exempt accounts for tax planning and compliance"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`customer_design_win`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design win pipeline and revenue opportunity metrics critical for semiconductor business forecasting and competitive positioning"
  source: "`semiconductors_ecm`.`customer`.`customer_design_win`"
  dimensions:
    - name: "stage"
      expr: stage
      comment: "Current stage of the design win in the sales pipeline"
    - name: "target_application"
      expr: target_application
      comment: "Target application for the design win (e.g., AI accelerator, automotive ADAS, 5G modem)"
    - name: "platform_generation"
      expr: platform_generation
      comment: "Platform or technology generation of the design"
    - name: "package_type"
      expr: package_type
      comment: "Package type for the semiconductor product"
    - name: "competitive_displacement"
      expr: CASE WHEN competitive_displacement_flag = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether this design win displaces a competitor"
    - name: "nre_required"
      expr: CASE WHEN nre_required_flag = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether non-recurring engineering investment is required"
    - name: "design_win_source"
      expr: design_win_source
      comment: "Source or channel of the design win"
    - name: "registration_year"
      expr: YEAR(registration_timestamp)
      comment: "Year the design win was registered for pipeline tracking"
    - name: "registration_quarter"
      expr: CONCAT(CAST(YEAR(registration_timestamp) AS STRING), '-Q', CAST(QUARTER(registration_timestamp) AS STRING))
      comment: "Quarter the design win was registered"
    - name: "production_ramp_year"
      expr: YEAR(production_ramp_date)
      comment: "Year of planned production ramp for revenue forecasting"
  measures:
    - name: "total_design_wins"
      expr: COUNT(DISTINCT customer_design_win_id)
      comment: "Total number of design wins in the pipeline driving future revenue"
    - name: "total_pipeline_revenue_usd"
      expr: SUM(CAST(estimated_annual_revenue_usd AS DOUBLE))
      comment: "Total estimated annual revenue from all design wins for pipeline valuation"
    - name: "avg_design_win_revenue_usd"
      expr: AVG(CAST(estimated_annual_revenue_usd AS DOUBLE))
      comment: "Average estimated annual revenue per design win for deal sizing"
    - name: "total_unit_volume"
      expr: SUM(CAST(estimated_annual_unit_volume AS DOUBLE))
      comment: "Total estimated annual unit volume across all design wins for capacity planning"
    - name: "total_nre_investment_usd"
      expr: SUM(CAST(nre_amount_usd AS DOUBLE))
      comment: "Total non-recurring engineering investment required across design wins"
    - name: "competitive_displacement_wins"
      expr: COUNT(DISTINCT CASE WHEN competitive_displacement_flag = TRUE THEN customer_design_win_id END)
      comment: "Number of design wins that displace competitors for market share tracking"
    - name: "nre_required_wins"
      expr: COUNT(DISTINCT CASE WHEN nre_required_flag = TRUE THEN customer_design_win_id END)
      comment: "Number of design wins requiring NRE investment for resource allocation"
    - name: "avg_unit_volume_per_win"
      expr: AVG(CAST(estimated_annual_unit_volume AS DOUBLE))
      comment: "Average estimated annual unit volume per design win for volume forecasting"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`customer_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer credit risk and financial health metrics for semiconductor accounts receivable and credit management"
  source: "`semiconductors_ecm`.`customer`.`credit_profile`"
  dimensions:
    - name: "credit_profile_status"
      expr: credit_profile_status
      comment: "Current status of the credit profile"
    - name: "credit_rating_internal"
      expr: credit_rating_internal
      comment: "Internal credit rating assigned by credit team"
    - name: "credit_rating_external"
      expr: credit_rating_external
      comment: "External credit rating from rating agency"
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category classification for credit exposure management"
    - name: "credit_hold_status"
      expr: CASE WHEN credit_hold = TRUE THEN 'On Hold' ELSE 'Active' END
      comment: "Whether the account is on credit hold"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms extended to the customer"
    - name: "preferred_customer"
      expr: CASE WHEN is_preferred_customer = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether the customer has preferred status"
    - name: "credit_review_year"
      expr: YEAR(credit_review_date)
      comment: "Year of last credit review for review cycle tracking"
  measures:
    - name: "total_credit_profiles"
      expr: COUNT(DISTINCT credit_profile_id)
      comment: "Total number of customer credit profiles under management"
    - name: "total_credit_limit_usd"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended across all customers for exposure tracking"
    - name: "avg_credit_limit_usd"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per customer for credit policy benchmarking"
    - name: "total_outstanding_balance_usd"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding accounts receivable balance for cash flow management"
    - name: "total_overdue_amount_usd"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue receivables requiring collection action"
    - name: "avg_credit_utilization_pct"
      expr: AVG(CAST(credit_utilization_pct AS DOUBLE))
      comment: "Average credit utilization percentage across customers for capacity assessment"
    - name: "accounts_on_credit_hold"
      expr: COUNT(DISTINCT CASE WHEN credit_hold = TRUE THEN credit_profile_id END)
      comment: "Number of accounts on credit hold requiring resolution"
    - name: "preferred_customers"
      expr: COUNT(DISTINCT CASE WHEN is_preferred_customer = TRUE THEN credit_profile_id END)
      comment: "Number of preferred customers with enhanced credit terms"
    - name: "high_risk_credit_profiles"
      expr: COUNT(DISTINCT CASE WHEN risk_category IN ('High', 'Critical') THEN credit_profile_id END)
      comment: "Number of high-risk credit profiles requiring enhanced monitoring"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`customer_sample_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sample request fulfillment and design engagement metrics tracking early-stage customer qualification and product evaluation"
  source: "`semiconductors_ecm`.`customer`.`sample_request`"
  dimensions:
    - name: "customer_sample_request_status"
      expr: customer_sample_request_status
      comment: "Current status of the sample request"
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment status of the sample request"
    - name: "sample_purpose"
      expr: sample_purpose
      comment: "Purpose of the sample request (e.g., evaluation, qualification, production trial)"
    - name: "application_description"
      expr: application_description
      comment: "Description of the target application for the sample"
    - name: "request_year"
      expr: YEAR(request_timestamp)
      comment: "Year the sample was requested for trend analysis"
    - name: "request_quarter"
      expr: CONCAT(CAST(YEAR(request_timestamp) AS STRING), '-Q', CAST(QUARTER(request_timestamp) AS STRING))
      comment: "Quarter the sample was requested"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month the sample was requested for monthly tracking"
  measures:
    - name: "total_sample_requests"
      expr: COUNT(DISTINCT sample_request_id)
      comment: "Total number of sample requests indicating customer engagement and design activity"
    - name: "fulfilled_sample_requests"
      expr: COUNT(DISTINCT CASE WHEN fulfillment_status = 'Fulfilled' THEN sample_request_id END)
      comment: "Number of fulfilled sample requests for fulfillment performance tracking"
    - name: "total_sample_cost_usd"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of sample requests for sample program budget management"
    - name: "avg_sample_cost_usd"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per sample request for cost benchmarking"
    - name: "total_cost_adjustments_usd"
      expr: SUM(CAST(cost_adjustment AS DOUBLE))
      comment: "Total cost adjustments applied to sample requests"
    - name: "total_net_sample_cost_usd"
      expr: SUM(CAST(cost_net AS DOUBLE))
      comment: "Total net cost of samples after adjustments for actual program expense"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`customer_price_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer pricing agreement and discount metrics for semiconductor pricing strategy and margin management"
  source: "`semiconductors_ecm`.`customer`.`price_agreement`"
  dimensions:
    - name: "price_agreement_status"
      expr: price_agreement_status
      comment: "Current status of the price agreement"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of pricing agreement (e.g., volume, strategic, spot)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the price agreement"
    - name: "pricing_channel"
      expr: pricing_channel
      comment: "Sales channel for the pricing agreement"
    - name: "pricing_region"
      expr: pricing_region
      comment: "Geographic region for the pricing agreement"
    - name: "volume_tier"
      expr: volume_tier
      comment: "Volume tier for tiered pricing structure"
    - name: "price_locked"
      expr: CASE WHEN is_price_locked = TRUE THEN 'Locked' ELSE 'Flexible' END
      comment: "Whether the price is locked or subject to change"
    - name: "effective_year"
      expr: YEAR(effective_from)
      comment: "Year the price agreement became effective"
    - name: "effective_quarter"
      expr: CONCAT(CAST(YEAR(effective_from) AS STRING), '-Q', CAST(QUARTER(effective_from) AS STRING))
      comment: "Quarter the price agreement became effective"
  measures:
    - name: "total_price_agreements"
      expr: COUNT(DISTINCT price_agreement_id)
      comment: "Total number of active price agreements for pricing complexity tracking"
    - name: "avg_unit_price_usd"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across all price agreements for pricing benchmarking"
    - name: "avg_discount_pct"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage across agreements for margin impact assessment"
    - name: "avg_tier_price_usd"
      expr: AVG(CAST(tier_price AS DOUBLE))
      comment: "Average tier price for volume-based pricing analysis"
    - name: "total_minimum_order_quantity"
      expr: SUM(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Total minimum order quantity commitments for demand planning"
    - name: "locked_price_agreements"
      expr: COUNT(DISTINCT CASE WHEN is_price_locked = TRUE THEN price_agreement_id END)
      comment: "Number of price-locked agreements limiting pricing flexibility"
    - name: "approved_price_agreements"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'Approved' THEN price_agreement_id END)
      comment: "Number of approved price agreements ready for execution"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`customer_qualification_status`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer and product qualification metrics for automotive and high-reliability semiconductor applications"
  source: "`semiconductors_ecm`.`customer`.`qualification_status`"
  dimensions:
    - name: "overall_qualification_status"
      expr: overall_qualification_status
      comment: "Overall qualification status of the customer or product"
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (e.g., product, process, customer)"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the qualification"
    - name: "aec_q_status"
      expr: aec_q_status
      comment: "AEC-Q qualification status for automotive applications"
    - name: "iatf_16949_status"
      expr: iatf_16949_status
      comment: "IATF 16949 quality management system status for automotive"
    - name: "ppap_status"
      expr: ppap_status
      comment: "Production Part Approval Process status for automotive"
    - name: "qualification_year"
      expr: YEAR(qualification_start_date)
      comment: "Year qualification started for cycle time analysis"
    - name: "completion_year"
      expr: YEAR(qualification_completion_date)
      comment: "Year qualification was completed"
  measures:
    - name: "total_qualifications"
      expr: COUNT(DISTINCT qualification_status_id)
      comment: "Total number of qualification records for qualification workload tracking"
    - name: "completed_qualifications"
      expr: COUNT(DISTINCT CASE WHEN overall_qualification_status = 'Completed' THEN qualification_status_id END)
      comment: "Number of completed qualifications enabling production readiness"
    - name: "avg_qualification_score"
      expr: AVG(CAST(qualification_score AS DOUBLE))
      comment: "Average qualification score for quality performance assessment"
    - name: "aec_q_qualified"
      expr: COUNT(DISTINCT CASE WHEN aec_q_status = 'Qualified' THEN qualification_status_id END)
      comment: "Number of AEC-Q qualified products for automotive market readiness"
    - name: "iatf_certified"
      expr: COUNT(DISTINCT CASE WHEN iatf_16949_status = 'Certified' THEN qualification_status_id END)
      comment: "Number of IATF 16949 certified qualifications for automotive compliance"
    - name: "ppap_approved"
      expr: COUNT(DISTINCT CASE WHEN ppap_status = 'Approved' THEN qualification_status_id END)
      comment: "Number of PPAP-approved qualifications for automotive production launch"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`customer_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer segment strategy and performance metrics for semiconductor market targeting and revenue planning"
  source: "`semiconductors_ecm`.`customer`.`segment`"
  dimensions:
    - name: "segment_name"
      expr: segment_name
      comment: "Name of the customer segment"
    - name: "segment_code"
      expr: segment_code
      comment: "Code identifier for the segment"
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment"
    - name: "vertical_market"
      expr: vertical_market
      comment: "Vertical market for the segment (e.g., automotive, mobile, data center, IoT)"
    - name: "sub_vertical"
      expr: sub_vertical
      comment: "Sub-vertical within the vertical market"
    - name: "region"
      expr: region
      comment: "Geographic region for the segment"
    - name: "strategic_priority_tier"
      expr: strategic_priority_tier
      comment: "Strategic priority tier for resource allocation"
    - name: "target_customer_type"
      expr: target_customer_type
      comment: "Target customer type for the segment"
    - name: "sales_motion"
      expr: sales_motion
      comment: "Sales motion or go-to-market approach for the segment"
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy for the segment"
    - name: "tam_band"
      expr: tam_band
      comment: "Total addressable market size band for the segment"
  measures:
    - name: "total_segments"
      expr: COUNT(DISTINCT segment_id)
      comment: "Total number of customer segments in the portfolio for segmentation complexity"
    - name: "total_revenue_target_usd"
      expr: SUM(CAST(revenue_target_usd AS DOUBLE))
      comment: "Total revenue target across all segments for corporate revenue planning"
    - name: "avg_revenue_target_usd"
      expr: AVG(CAST(revenue_target_usd AS DOUBLE))
      comment: "Average revenue target per segment for segment sizing"
    - name: "avg_market_share_target_pct"
      expr: AVG(CAST(market_share_target_percent AS DOUBLE))
      comment: "Average market share target across segments for competitive positioning"
    - name: "avg_discount_rate_pct"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate by segment for margin planning"
    - name: "active_segments"
      expr: COUNT(DISTINCT CASE WHEN segment_status = 'Active' THEN segment_id END)
      comment: "Number of active segments currently being pursued"
$$;