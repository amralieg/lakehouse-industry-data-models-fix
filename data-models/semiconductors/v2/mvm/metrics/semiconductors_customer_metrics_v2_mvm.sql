-- Metric views for domain: customer | Business: Semiconductors | Version: 2 | Generated on: 2026-06-24 02:09:37

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core customer account metrics tracking account base, revenue tiers, credit quality, and compliance status for strategic account management and risk assessment."
  source: "`vibe_semiconductors_v1`.`customer`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current operational status of the customer account (active, inactive, suspended, etc.)"
    - name: "account_type"
      expr: account_type
      comment: "Classification of account type (direct, distributor, OEM, etc.)"
    - name: "revenue_tier"
      expr: revenue_tier
      comment: "Strategic revenue tier classification for account segmentation"
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating assigned to the account for risk management"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the account with regulatory requirements"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region where the account is located for regional analysis"
    - name: "sales_region"
      expr: sales_region
      comment: "Sales territory or region assignment for sales performance tracking"
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry vertical or sector of the customer account"
    - name: "strategic_classification"
      expr: strategic_classification
      comment: "Strategic importance classification (key account, strategic partner, standard, etc.)"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms negotiated with the account"
    - name: "creation_year"
      expr: YEAR(creation_date)
      comment: "Year the account was created for cohort analysis"
    - name: "creation_quarter"
      expr: CONCAT(CAST(YEAR(creation_date) AS STRING), '-Q', CAST(QUARTER(creation_date) AS STRING))
      comment: "Quarter the account was created for cohort analysis"
    - name: "last_order_year"
      expr: YEAR(last_order_date)
      comment: "Year of last order for recency analysis"
  measures:
    - name: "total_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Total number of unique customer accounts"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across accounts for portfolio risk assessment"
    - name: "high_risk_account_count"
      expr: COUNT(DISTINCT CASE WHEN CAST(risk_score AS DOUBLE) > 70.0 THEN account_id END)
      comment: "Count of accounts with risk score above 70, indicating elevated credit or operational risk"
    - name: "tax_exempt_account_count"
      expr: COUNT(DISTINCT CASE WHEN tax_exempt_flag = TRUE THEN account_id END)
      comment: "Count of accounts with tax-exempt status for tax reporting and compliance"
    - name: "active_account_count"
      expr: COUNT(DISTINCT CASE WHEN account_status = 'Active' THEN account_id END)
      comment: "Count of accounts in active status for active customer base tracking"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit and financial risk metrics tracking credit limits, utilization, outstanding balances, and credit holds for financial risk management and credit policy optimization."
  source: "`vibe_semiconductors_v1`.`customer`.`credit_profile`"
  dimensions:
    - name: "credit_profile_status"
      expr: credit_profile_status
      comment: "Current status of the credit profile (active, suspended, under review, etc.)"
    - name: "credit_rating_internal"
      expr: credit_rating_internal
      comment: "Internal credit rating assigned by credit team"
    - name: "credit_rating_external"
      expr: credit_rating_external
      comment: "External credit rating from third-party agencies"
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category classification for credit risk segmentation"
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Indicator whether account is on credit hold"
    - name: "credit_hold_reason"
      expr: credit_hold_reason
      comment: "Reason for credit hold if applicable"
    - name: "is_preferred_customer"
      expr: is_preferred_customer
      comment: "Flag indicating preferred customer status with enhanced credit terms"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms associated with the credit profile"
    - name: "credit_limit_currency"
      expr: credit_limit_currency
      comment: "Currency in which credit limit is denominated"
    - name: "credit_review_year"
      expr: YEAR(credit_review_date)
      comment: "Year of last credit review for review cycle tracking"
  measures:
    - name: "total_credit_profiles"
      expr: COUNT(DISTINCT credit_profile_id)
      comment: "Total number of credit profiles in the system"
    - name: "total_credit_limit_usd"
      expr: SUM(CAST(credit_limit_usd AS DOUBLE))
      comment: "Total credit limit extended across all accounts in USD for credit exposure tracking"
    - name: "total_credit_used_usd"
      expr: SUM(CAST(credit_used_usd AS DOUBLE))
      comment: "Total credit currently utilized across all accounts in USD"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance across all credit profiles for AR management"
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue amount across all accounts for collections prioritization"
    - name: "avg_credit_utilization_pct"
      expr: AVG(CAST(credit_utilization_pct AS DOUBLE))
      comment: "Average credit utilization percentage across all profiles for portfolio health assessment"
    - name: "credit_hold_count"
      expr: COUNT(DISTINCT CASE WHEN credit_hold_flag = TRUE THEN credit_profile_id END)
      comment: "Count of credit profiles currently on hold, indicating credit risk or payment issues"
    - name: "high_utilization_count"
      expr: COUNT(DISTINCT CASE WHEN CAST(credit_utilization_pct AS DOUBLE) > 80.0 THEN credit_profile_id END)
      comment: "Count of profiles with credit utilization above 80%, indicating potential credit limit pressure"
    - name: "preferred_customer_count"
      expr: COUNT(DISTINCT CASE WHEN is_preferred_customer = TRUE THEN credit_profile_id END)
      comment: "Count of preferred customers with enhanced credit terms"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_design_win`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design win pipeline and revenue opportunity metrics tracking design wins, estimated revenue, production ramp dates, and competitive displacements for strategic business development and revenue forecasting."
  source: "`vibe_semiconductors_v1`.`customer`.`design_win`"
  dimensions:
    - name: "win_status"
      expr: win_status
      comment: "Current status of the design win (won, pending, lost, etc.)"
    - name: "stage"
      expr: stage
      comment: "Current stage in the design win lifecycle"
    - name: "target_application"
      expr: target_application
      comment: "Target application or use case for the design win"
    - name: "process_node"
      expr: process_node
      comment: "Process node technology for the design (e.g., 7nm, 5nm)"
    - name: "platform_generation"
      expr: platform_generation
      comment: "Platform or product generation for the design"
    - name: "competitive_displacement_flag"
      expr: competitive_displacement_flag
      comment: "Flag indicating whether this design win displaced a competitor"
    - name: "nre_required_flag"
      expr: nre_required_flag
      comment: "Flag indicating whether non-recurring engineering investment is required"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for revenue estimates"
    - name: "win_year"
      expr: YEAR(win_date)
      comment: "Year the design win was secured for cohort analysis"
    - name: "win_quarter"
      expr: CONCAT(CAST(YEAR(win_date) AS STRING), '-Q', CAST(QUARTER(win_date) AS STRING))
      comment: "Quarter the design win was secured for pipeline tracking"
    - name: "production_ramp_year"
      expr: YEAR(production_ramp_date)
      comment: "Year production is expected to ramp for revenue timing analysis"
  measures:
    - name: "total_design_wins"
      expr: COUNT(DISTINCT design_win_id)
      comment: "Total number of design wins in the pipeline"
    - name: "total_estimated_annual_revenue_usd"
      expr: SUM(CAST(estimated_annual_revenue_usd AS DOUBLE))
      comment: "Total estimated annual revenue from all design wins in USD for revenue forecasting"
    - name: "total_estimated_annual_unit_volume"
      expr: SUM(CAST(estimated_annual_unit_volume AS BIGINT))
      comment: "Total estimated annual unit volume across all design wins for capacity planning"
    - name: "total_nre_amount_usd"
      expr: SUM(CAST(nre_amount_usd AS DOUBLE))
      comment: "Total non-recurring engineering investment required across all design wins"
    - name: "avg_estimated_annual_revenue_usd"
      expr: AVG(CAST(estimated_annual_revenue_usd AS DOUBLE))
      comment: "Average estimated annual revenue per design win for deal size assessment"
    - name: "competitive_displacement_count"
      expr: COUNT(DISTINCT CASE WHEN competitive_displacement_flag = TRUE THEN design_win_id END)
      comment: "Count of design wins that displaced competitors, indicating competitive strength"
    - name: "nre_required_count"
      expr: COUNT(DISTINCT CASE WHEN nre_required_flag = TRUE THEN design_win_id END)
      comment: "Count of design wins requiring NRE investment for resource planning"
    - name: "won_design_count"
      expr: COUNT(DISTINCT CASE WHEN win_status = 'Won' THEN design_win_id END)
      comment: "Count of confirmed won design wins for pipeline conversion tracking"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_design_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design registration and qualification metrics tracking design projects, qualification status, NRE budgets, and production targets for engineering pipeline management and resource allocation."
  source: "`vibe_semiconductors_v1`.`customer`.`design_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current status of the design registration"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the design project"
    - name: "target_application"
      expr: target_application
      comment: "Target application for the design project"
    - name: "process_node_nm"
      expr: process_node_nm
      comment: "Process node in nanometers for the design"
    - name: "platform_generation"
      expr: platform_generation
      comment: "Platform generation for the design"
    - name: "design_complexity"
      expr: design_complexity
      comment: "Complexity classification of the design project"
    - name: "package_type"
      expr: package_type
      comment: "Package type for the design"
    - name: "nre_budget_currency"
      expr: nre_budget_currency
      comment: "Currency for NRE budget"
    - name: "registration_year"
      expr: YEAR(registration_date)
      comment: "Year the design was registered for pipeline tracking"
    - name: "design_start_year"
      expr: YEAR(design_start_date)
      comment: "Year the design project started"
    - name: "production_target_year"
      expr: YEAR(production_target_date)
      comment: "Target year for production ramp"
  measures:
    - name: "total_design_registrations"
      expr: COUNT(DISTINCT design_registration_id)
      comment: "Total number of design registrations in the pipeline"
    - name: "total_nre_budget_amount"
      expr: SUM(CAST(nre_budget_amount AS DOUBLE))
      comment: "Total NRE budget allocated across all design registrations for investment tracking"
    - name: "avg_nre_budget_amount"
      expr: AVG(CAST(nre_budget_amount AS DOUBLE))
      comment: "Average NRE budget per design registration for project sizing"
    - name: "avg_expected_yield_percent"
      expr: AVG(CAST(expected_yield_percent AS DOUBLE))
      comment: "Average expected yield percentage across design projects for quality forecasting"
    - name: "qualified_design_count"
      expr: COUNT(DISTINCT CASE WHEN qualification_status = 'Qualified' THEN design_registration_id END)
      comment: "Count of designs that have achieved qualification status"
    - name: "active_registration_count"
      expr: COUNT(DISTINCT CASE WHEN registration_status = 'Active' THEN design_registration_id END)
      comment: "Count of active design registrations in the pipeline"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_price_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing and discount metrics tracking price agreements, discount levels, volume tiers, and price lock status for pricing strategy optimization and margin management."
  source: "`vibe_semiconductors_v1`.`customer`.`price_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the price agreement"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of price agreement (volume-based, contract, spot, etc.)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the price agreement"
    - name: "pricing_channel"
      expr: pricing_channel
      comment: "Sales channel for the pricing agreement"
    - name: "pricing_region"
      expr: pricing_region
      comment: "Geographic region for the pricing agreement"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the price agreement"
    - name: "volume_tier"
      expr: volume_tier
      comment: "Volume tier classification for tiered pricing"
    - name: "is_price_locked"
      expr: is_price_locked
      comment: "Flag indicating whether price is locked for the agreement period"
    - name: "price_source"
      expr: price_source
      comment: "Source or origin of the pricing (standard, negotiated, promotional, etc.)"
    - name: "effective_year"
      expr: YEAR(effective_from)
      comment: "Year the price agreement became effective"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the price agreement was approved"
  measures:
    - name: "total_price_agreements"
      expr: COUNT(DISTINCT price_agreement_id)
      comment: "Total number of price agreements in the system"
    - name: "avg_unit_price_usd"
      expr: AVG(CAST(unit_price_usd AS DOUBLE))
      comment: "Average unit price in USD across all price agreements for pricing benchmarking"
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage across all price agreements for margin impact assessment"
    - name: "avg_tier_price"
      expr: AVG(CAST(tier_price AS DOUBLE))
      comment: "Average tier price for volume-based pricing analysis"
    - name: "total_minimum_order_quantity"
      expr: SUM(CAST(minimum_order_quantity AS BIGINT))
      comment: "Total minimum order quantity commitments across all agreements for demand forecasting"
    - name: "price_locked_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN is_price_locked = TRUE THEN price_agreement_id END)
      comment: "Count of agreements with locked pricing, indicating price stability commitments"
    - name: "active_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN agreement_status = 'Active' THEN price_agreement_id END)
      comment: "Count of currently active price agreements"
    - name: "high_discount_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN CAST(discount_percent AS DOUBLE) > 20.0 THEN price_agreement_id END)
      comment: "Count of agreements with discount above 20%, indicating significant margin pressure"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_nda_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NDA and confidentiality agreement metrics tracking agreement status, confidentiality levels, mutual agreements, and expiration dates for legal compliance and IP protection management."
  source: "`vibe_semiconductors_v1`.`customer`.`nda_agreement`"
  dimensions:
    - name: "nda_agreement_status"
      expr: nda_agreement_status
      comment: "Current status of the NDA agreement"
    - name: "nda_type"
      expr: nda_type
      comment: "Type of NDA (unilateral, mutual, multilateral, etc.)"
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Level of confidentiality required by the agreement"
    - name: "is_mutual"
      expr: is_mutual
      comment: "Flag indicating whether the NDA is mutual (both parties share confidential information)"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction governing the NDA"
    - name: "execution_year"
      expr: YEAR(execution_date)
      comment: "Year the NDA was executed"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the NDA became effective"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the NDA expires for renewal tracking"
  measures:
    - name: "total_nda_agreements"
      expr: COUNT(DISTINCT nda_agreement_id)
      comment: "Total number of NDA agreements for IP protection coverage tracking"
    - name: "active_nda_count"
      expr: COUNT(DISTINCT CASE WHEN nda_agreement_status = 'Active' THEN nda_agreement_id END)
      comment: "Count of currently active NDA agreements"
    - name: "mutual_nda_count"
      expr: COUNT(DISTINCT CASE WHEN is_mutual = TRUE THEN nda_agreement_id END)
      comment: "Count of mutual NDA agreements indicating collaborative relationships"
    - name: "expired_nda_count"
      expr: COUNT(DISTINCT CASE WHEN expiration_date < CURRENT_DATE THEN nda_agreement_id END)
      comment: "Count of expired NDAs indicating potential compliance gaps"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer contact engagement and compliance metrics tracking contact roles, interaction recency, GDPR consent status, and marketing opt-in for relationship management and regulatory compliance."
  source: "`vibe_semiconductors_v1`.`customer`.`contact`"
  dimensions:
    - name: "contact_status"
      expr: contact_status
      comment: "Current status of the contact record"
    - name: "role_type"
      expr: role_type
      comment: "Role or function of the contact within their organization"
    - name: "department"
      expr: department
      comment: "Department where the contact works"
    - name: "is_key_contact"
      expr: is_key_contact
      comment: "Flag indicating whether this is a key decision-maker or influencer"
    - name: "gdpr_consent_status"
      expr: gdpr_consent_status
      comment: "GDPR consent status for data privacy compliance"
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Flag indicating whether contact has opted in to marketing communications"
    - name: "preferred_communication_channel"
      expr: preferred_communication_channel
      comment: "Preferred channel for communication (email, phone, etc.)"
    - name: "language_preference"
      expr: language_preference
      comment: "Preferred language for communication"
    - name: "is_employee"
      expr: is_employee
      comment: "Flag indicating whether contact is also an employee"
    - name: "last_interaction_year"
      expr: YEAR(last_interaction_date)
      comment: "Year of last interaction for engagement recency analysis"
  measures:
    - name: "total_contacts"
      expr: COUNT(DISTINCT contact_id)
      comment: "Total number of customer contacts in the system"
    - name: "key_contact_count"
      expr: COUNT(DISTINCT CASE WHEN is_key_contact = TRUE THEN contact_id END)
      comment: "Count of key contacts for relationship coverage assessment"
    - name: "marketing_opt_in_count"
      expr: COUNT(DISTINCT CASE WHEN marketing_opt_in = TRUE THEN contact_id END)
      comment: "Count of contacts opted in to marketing for campaign reach estimation"
    - name: "gdpr_compliant_count"
      expr: COUNT(DISTINCT CASE WHEN gdpr_consent_status = 'Compliant' THEN contact_id END)
      comment: "Count of contacts with compliant GDPR consent status for regulatory compliance tracking"
    - name: "active_contact_count"
      expr: COUNT(DISTINCT CASE WHEN contact_status = 'Active' THEN contact_id END)
      comment: "Count of contacts in active status"
$$;