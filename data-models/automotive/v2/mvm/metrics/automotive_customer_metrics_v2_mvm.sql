-- Metric views for domain: customer | Business: Automotive | Version: 2 | Generated on: 2026-06-23 05:54:22

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_party`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic customer base metrics derived from the party master. Tracks customer lifecycle health, segmentation distribution, consent posture, and lifetime value — core KPIs for CRM, marketing, and executive steering."
  source: "`vibe_automotive_v1`.`customer`.`party`"
  dimensions:
    - name: "party_type"
      expr: party_type
      comment: "Distinguishes individual consumers from corporate/fleet entities, enabling segment-specific strategy."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Business-defined customer segment (e.g. premium, mass-market) used for targeted investment and marketing decisions."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current stage of the customer lifecycle (e.g. active, churned, prospect) — critical for retention and acquisition analysis."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Customer loyalty tier (e.g. gold, silver, bronze) used to prioritise service and reward investment."
    - name: "onboarding_channel"
      expr: onboarding_channel
      comment: "Channel through which the customer was acquired, enabling channel ROI and attribution analysis."
    - name: "kyc_status"
      expr: kyc_status
      comment: "Know-Your-Customer verification status, relevant for compliance and risk management reporting."
    - name: "country_code"
      expr: country_code
      comment: "Country of the customer, enabling geographic segmentation and regional performance analysis."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Customer credit rating band, used for risk-adjusted portfolio analysis and financing decisions."
    - name: "onboarding_year_month"
      expr: DATE_TRUNC('month', onboarding_date)
      comment: "Month of customer onboarding, used to track acquisition cohorts and growth trends over time."
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Whether the customer has opted into marketing communications — key for reachable audience sizing."
    - name: "gdpr_consent_email"
      expr: gdpr_consent_email
      comment: "GDPR email consent flag, required for compliant email marketing audience measurement."
  measures:
    - name: "total_active_customers"
      expr: COUNT(DISTINCT CASE WHEN lifecycle_status = 'active' THEN party_id END)
      comment: "Count of distinct active customers. Core KPI for measuring the size of the monetisable customer base."
    - name: "total_customers"
      expr: COUNT(DISTINCT party_id)
      comment: "Total distinct customer records across all lifecycle stages. Used as the denominator for rate-based KPIs."
    - name: "total_customer_lifetime_value"
      expr: SUM(CAST(customer_lifetime_value AS DOUBLE))
      comment: "Sum of estimated customer lifetime value across the portfolio. Directly informs investment prioritisation and retention spend."
    - name: "avg_customer_lifetime_value"
      expr: AVG(CAST(customer_lifetime_value AS DOUBLE))
      comment: "Average CLV per customer. Benchmarks portfolio quality and tracks improvement from loyalty and retention programmes."
    - name: "marketing_reachable_customers"
      expr: COUNT(DISTINCT CASE WHEN marketing_opt_in = TRUE THEN party_id END)
      comment: "Count of customers who have opted into marketing. Defines the addressable audience for campaigns."
    - name: "gdpr_email_consent_customers"
      expr: COUNT(DISTINCT CASE WHEN gdpr_consent_email = TRUE THEN party_id END)
      comment: "Count of customers with valid GDPR email consent. Critical for compliance-gated email campaign sizing."
    - name: "kyc_verified_customers"
      expr: COUNT(DISTINCT CASE WHEN kyc_status = 'verified' THEN party_id END)
      comment: "Count of KYC-verified customers. Tracks regulatory compliance posture and risk exposure in the customer base."
    - name: "tax_exempt_customers"
      expr: COUNT(DISTINCT CASE WHEN is_tax_exempt = TRUE THEN party_id END)
      comment: "Count of tax-exempt customers. Relevant for revenue recognition, pricing strategy, and tax reporting."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_individual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer-level metrics for individual customers. Tracks loyalty distribution, marketing opt-in rates, and estimated lifetime value across demographic and behavioural segments — essential for CRM, loyalty programme management, and personalisation strategy."
  source: "`vibe_automotive_v1`.`customer`.`individual`"
  dimensions:
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Loyalty programme tier of the individual customer, used to segment and prioritise retention investment."
    - name: "customer_type"
      expr: customer_type
      comment: "Classification of the individual customer (e.g. retail, fleet driver) for targeted programme design."
    - name: "individual_status"
      expr: individual_status
      comment: "Current status of the individual record (e.g. active, inactive) for lifecycle management."
    - name: "gender"
      expr: gender
      comment: "Gender of the individual, used for demographic segmentation in product and marketing strategy."
    - name: "country_of_residence"
      expr: country_of_residence
      comment: "Country of residence, enabling geographic analysis of the individual customer base."
    - name: "employment_status"
      expr: employment_status
      comment: "Employment status of the individual, relevant for financing eligibility and income-based segmentation."
    - name: "annual_income_band"
      expr: annual_income_band
      comment: "Income band of the individual customer, used for affordability segmentation and product targeting."
    - name: "education_level"
      expr: education_level
      comment: "Highest education level attained, used for demographic profiling and propensity modelling."
    - name: "preferred_contact_method"
      expr: preferred_contact_method
      comment: "Customer's preferred contact channel, used to optimise outreach strategy and reduce opt-out rates."
    - name: "last_purchase_year_month"
      expr: DATE_TRUNC('month', last_purchase_date)
      comment: "Month of the customer's most recent purchase, used for recency analysis and churn detection."
    - name: "marketing_opt_in_email"
      expr: marketing_opt_in_email
      comment: "Email marketing opt-in flag, used to size the email-reachable audience."
    - name: "marketing_opt_in_sms"
      expr: marketing_opt_in_sms
      comment: "SMS marketing opt-in flag, used to size the SMS-reachable audience."
  measures:
    - name: "total_individuals"
      expr: COUNT(DISTINCT individual_id)
      comment: "Total distinct individual customer records. Baseline headcount for the consumer customer base."
    - name: "total_cltv_estimate"
      expr: SUM(CAST(cltv_estimate AS DOUBLE))
      comment: "Sum of estimated customer lifetime value across all individuals. Quantifies the total revenue potential of the consumer portfolio."
    - name: "avg_cltv_estimate"
      expr: AVG(CAST(cltv_estimate AS DOUBLE))
      comment: "Average estimated CLV per individual. Benchmarks portfolio quality and tracks the impact of loyalty and retention initiatives."
    - name: "email_opt_in_individuals"
      expr: COUNT(DISTINCT CASE WHEN marketing_opt_in_email = TRUE THEN individual_id END)
      comment: "Count of individuals opted into email marketing. Defines the reachable email audience for campaign planning."
    - name: "sms_opt_in_individuals"
      expr: COUNT(DISTINCT CASE WHEN marketing_opt_in_sms = TRUE THEN individual_id END)
      comment: "Count of individuals opted into SMS marketing. Defines the reachable SMS audience for campaign planning."
    - name: "phone_opt_in_individuals"
      expr: COUNT(DISTINCT CASE WHEN marketing_opt_in_phone = TRUE THEN individual_id END)
      comment: "Count of individuals opted into phone marketing. Supports outbound call campaign sizing."
    - name: "multi_vehicle_owners"
      expr: COUNT(DISTINCT CASE WHEN CAST(vehicle_ownership_count AS INT) > 1 THEN individual_id END)
      comment: "Count of individuals owning more than one vehicle. Identifies high-value multi-vehicle households for upsell and fleet conversion programmes."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_vehicle_ownership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle ownership portfolio metrics. Tracks acquisition patterns, ownership lifecycle, purchase value, and fleet composition — essential for aftersales revenue planning, recall management, and customer retention strategy."
  source: "`vibe_automotive_v1`.`customer`.`vehicle_ownership`"
  dimensions:
    - name: "vehicle_ownership_status"
      expr: vehicle_ownership_status
      comment: "Current status of the vehicle ownership record (e.g. active, disposed) for portfolio health analysis."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Type of ownership (e.g. purchased, leased, financed) — critical for revenue recognition and product mix analysis."
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which the vehicle was acquired (e.g. dealer, online, fleet), used for channel attribution and sales strategy."
    - name: "disposition_type"
      expr: disposition_type
      comment: "How the vehicle was disposed of (e.g. trade-in, sold, scrapped), used for used-vehicle and trade-in programme analysis."
    - name: "registration_country"
      expr: registration_country
      comment: "Country of vehicle registration, enabling geographic fleet distribution analysis."
    - name: "registration_state"
      expr: registration_state
      comment: "State/province of vehicle registration for regional compliance and market analysis."
    - name: "is_primary_vehicle"
      expr: is_primary_vehicle
      comment: "Indicates whether this is the customer's primary vehicle, used to prioritise service and retention outreach."
    - name: "acquisition_year_month"
      expr: DATE_TRUNC('month', acquisition_date)
      comment: "Month of vehicle acquisition, used to track sales volume trends and cohort-based retention analysis."
    - name: "insurance_carrier"
      expr: insurance_carrier
      comment: "Insurance provider for the vehicle, relevant for partnership and embedded insurance programme analysis."
  measures:
    - name: "total_vehicles_owned"
      expr: COUNT(DISTINCT vehicle_ownership_id)
      comment: "Total distinct vehicle ownership records. Measures the size of the active vehicle portfolio under management."
    - name: "total_purchase_value"
      expr: SUM(CAST(purchase_price AS DOUBLE))
      comment: "Total purchase value across all vehicle ownership records. Quantifies the aggregate revenue generated from vehicle sales."
    - name: "avg_purchase_price"
      expr: AVG(CAST(purchase_price AS DOUBLE))
      comment: "Average vehicle purchase price. Tracks product mix shift and pricing strategy effectiveness over time."
    - name: "avg_odometer_at_acquisition"
      expr: AVG(CAST(odometer_at_acquisition AS DOUBLE))
      comment: "Average odometer reading at acquisition. Indicates whether customers are buying new vs. used vehicles and informs used-vehicle programme design."
    - name: "avg_current_odometer"
      expr: AVG(CAST(current_odometer AS DOUBLE))
      comment: "Average current odometer across the active fleet. Proxy for vehicle age and aftersales service demand forecasting."
    - name: "active_ownership_records"
      expr: COUNT(DISTINCT CASE WHEN vehicle_ownership_status = 'active' THEN vehicle_ownership_id END)
      comment: "Count of currently active vehicle ownership records. Core metric for the live customer vehicle portfolio."
    - name: "trade_in_vehicles"
      expr: COUNT(DISTINCT CASE WHEN trade_in_vin IS NOT NULL THEN vehicle_ownership_id END)
      comment: "Count of ownership records with a trade-in VIN. Measures trade-in programme utilisation and used-vehicle inventory pipeline."
    - name: "insured_vehicles"
      expr: COUNT(DISTINCT CASE WHEN insurance_policy_number IS NOT NULL THEN vehicle_ownership_id END)
      comment: "Count of vehicles with an active insurance policy on record. Relevant for embedded insurance partnership performance tracking."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer service case metrics. Tracks case volume, resolution efficiency, escalation rates, and SLA compliance — essential for customer experience management, service operations, and quality steering."
  source: "`vibe_automotive_v1`.`customer`.`case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the case (e.g. open, closed, escalated) for workload and resolution tracking."
    - name: "case_type"
      expr: case_type
      comment: "Type of customer case (e.g. complaint, inquiry, recall) used to categorise service demand."
    - name: "category"
      expr: category
      comment: "High-level category of the case issue, used for root-cause and trend analysis."
    - name: "sub_category"
      expr: sub_category
      comment: "Detailed sub-category of the case issue, enabling granular defect and complaint analysis."
    - name: "priority"
      expr: priority
      comment: "Case priority level (e.g. high, medium, low) used for SLA management and resource allocation."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Level to which the case has been escalated, used to track escalation patterns and service quality."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the case was raised (e.g. phone, email, web), used for channel capacity planning."
    - name: "resolution_code"
      expr: resolution_code
      comment: "Standardised resolution outcome code, used for quality and first-contact resolution analysis."
    - name: "opened_year_month"
      expr: DATE_TRUNC('month', opened_timestamp)
      comment: "Month the case was opened, used for volume trend and seasonality analysis."
    - name: "customer_satisfaction_score"
      expr: customer_satisfaction_score
      comment: "Customer satisfaction score recorded at case closure, used as a dimension to segment cases by satisfaction outcome."
  measures:
    - name: "total_cases"
      expr: COUNT(DISTINCT case_id)
      comment: "Total number of customer service cases. Baseline volume metric for service operations capacity planning."
    - name: "open_cases"
      expr: COUNT(DISTINCT CASE WHEN case_status = 'open' THEN case_id END)
      comment: "Count of currently open cases. Tracks live service backlog and operational workload."
    - name: "escalated_cases"
      expr: COUNT(DISTINCT CASE WHEN escalation_level IS NOT NULL AND escalation_level != '' THEN case_id END)
      comment: "Count of cases that have been escalated. High escalation rates signal systemic service quality issues requiring executive intervention."
    - name: "resolved_cases"
      expr: COUNT(DISTINCT CASE WHEN case_status = 'closed' THEN case_id END)
      comment: "Count of resolved/closed cases. Used as the denominator for resolution rate and SLA compliance calculations."
    - name: "recall_related_cases"
      expr: COUNT(DISTINCT CASE WHEN recall_campaign_id IS NOT NULL THEN case_id END)
      comment: "Count of cases linked to a recall campaign. Tracks recall-driven service demand and customer impact scope."
    - name: "unique_customers_with_cases"
      expr: COUNT(DISTINCT party_id)
      comment: "Count of distinct customers who have raised at least one case. Measures the breadth of service demand across the customer base."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_consent_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer consent and regulatory compliance metrics. Tracks consent coverage, opt-in rates, double opt-in compliance, and consent expiry — critical for GDPR/regulatory compliance, marketing eligibility, and data governance reporting."
  source: "`vibe_automotive_v1`.`customer`.`consent_record`"
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent (e.g. marketing, data processing, profiling) used to segment compliance posture by purpose."
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent record (e.g. active, withdrawn, expired) for compliance monitoring."
    - name: "consent_purpose"
      expr: consent_purpose
      comment: "Specific purpose for which consent was granted, enabling purpose-level compliance reporting."
    - name: "legal_basis"
      expr: legal_basis
      comment: "Legal basis for data processing (e.g. consent, legitimate interest, contract) — required for GDPR Article 30 records."
    - name: "channel"
      expr: channel
      comment: "Channel through which consent was collected (e.g. web, dealer, app), used for consent quality and channel compliance analysis."
    - name: "consent_source_system"
      expr: consent_source_system
      comment: "Source system that recorded the consent, used for data lineage and audit trail management."
    - name: "consent_year_month"
      expr: DATE_TRUNC('month', consent_granted_at)
      comment: "Month consent was granted, used to track consent collection trends and campaign-driven opt-in spikes."
    - name: "double_opt_in_flag"
      expr: double_opt_in_flag
      comment: "Indicates whether double opt-in was completed — a key compliance quality indicator for email marketing."
  measures:
    - name: "total_consent_records"
      expr: COUNT(DISTINCT consent_record_id)
      comment: "Total consent records on file. Baseline for consent portfolio size and regulatory audit readiness."
    - name: "active_consents"
      expr: COUNT(DISTINCT CASE WHEN consent_status = 'active' THEN consent_record_id END)
      comment: "Count of currently active consent records. Defines the compliant addressable audience for data-driven marketing."
    - name: "withdrawn_consents"
      expr: COUNT(DISTINCT CASE WHEN consent_revoked_timestamp IS NOT NULL THEN consent_record_id END)
      comment: "Count of consents that have been revoked. Tracks opt-out trends and regulatory risk exposure."
    - name: "double_opt_in_consents"
      expr: COUNT(DISTINCT CASE WHEN double_opt_in_flag = TRUE THEN consent_record_id END)
      comment: "Count of consents confirmed via double opt-in. Measures compliance quality for email marketing under GDPR and CAN-SPAM."
    - name: "opted_in_consents"
      expr: COUNT(DISTINCT CASE WHEN opt_in_flag = TRUE THEN consent_record_id END)
      comment: "Count of consent records where the customer has opted in. Core metric for reachable audience sizing across channels."
    - name: "unique_consenting_customers"
      expr: COUNT(DISTINCT party_id)
      comment: "Count of distinct customers with at least one consent record. Measures consent programme coverage across the customer base."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_fleet_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fleet and commercial account metrics. Tracks fleet portfolio value, credit exposure, contract coverage, and account health — essential for B2B sales strategy, fleet programme management, and commercial risk oversight."
  source: "`vibe_automotive_v1`.`customer`.`fleet_account`"
  dimensions:
    - name: "fleet_account_status"
      expr: fleet_account_status
      comment: "Current status of the fleet account (e.g. active, suspended, closed) for portfolio health monitoring."
    - name: "fleet_account_type"
      expr: fleet_account_type
      comment: "Type of fleet account (e.g. corporate, government, rental) used to segment commercial portfolio strategy."
    - name: "fleet_type"
      expr: fleet_type
      comment: "Classification of the fleet (e.g. passenger, commercial, mixed) for product and service targeting."
    - name: "industry_sector"
      expr: industry_sector
      comment: "Industry sector of the fleet customer, used for vertical market analysis and targeted sales strategy."
    - name: "discount_tier"
      expr: discount_tier
      comment: "Discount tier assigned to the fleet account, used for margin analysis and pricing strategy review."
    - name: "billing_currency"
      expr: billing_currency
      comment: "Currency used for billing, relevant for multi-currency revenue reporting and FX risk management."
    - name: "billing_terms"
      expr: billing_terms
      comment: "Payment terms for the fleet account (e.g. net-30, net-60), used for cash flow and credit risk analysis."
    - name: "contract_start_year_month"
      expr: DATE_TRUNC('month', contract_start_date)
      comment: "Month the fleet contract commenced, used for contract cohort and renewal pipeline analysis."
  measures:
    - name: "total_fleet_accounts"
      expr: COUNT(DISTINCT fleet_account_id)
      comment: "Total number of fleet accounts. Baseline metric for the commercial customer portfolio size."
    - name: "active_fleet_accounts"
      expr: COUNT(DISTINCT CASE WHEN fleet_account_status = 'active' THEN fleet_account_id END)
      comment: "Count of currently active fleet accounts. Measures the live commercial revenue base."
    - name: "total_annual_spend"
      expr: SUM(CAST(annual_spend AS DOUBLE))
      comment: "Total annual spend across all fleet accounts. Primary revenue KPI for the commercial fleet business."
    - name: "avg_annual_spend"
      expr: AVG(CAST(annual_spend AS DOUBLE))
      comment: "Average annual spend per fleet account. Benchmarks account value and identifies upsell opportunities."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all fleet accounts. Measures aggregate credit exposure for risk management."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per fleet account. Used to benchmark credit policy and identify outlier risk concentrations."
    - name: "contracted_fleet_accounts"
      expr: COUNT(DISTINCT CASE WHEN contract_reference IS NOT NULL THEN fleet_account_id END)
      comment: "Count of fleet accounts with an active contract reference. Measures contract coverage and revenue predictability."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`customer_organization_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corporate and government organisation account metrics. Tracks B2B account portfolio value, credit exposure, revenue scale, and account health — essential for enterprise sales strategy, key account management, and commercial risk oversight."
  source: "`vibe_automotive_v1`.`customer`.`organization_account`"
  dimensions:
    - name: "organization_account_status"
      expr: organization_account_status
      comment: "Current status of the organisation account (e.g. active, inactive, prospect) for portfolio health monitoring."
    - name: "account_tier"
      expr: account_tier
      comment: "Strategic tier of the account (e.g. strategic, key, standard) used to prioritise sales and service investment."
    - name: "classification"
      expr: classification
      comment: "Account classification (e.g. corporate, government, SME) for segment-level strategy and reporting."
    - name: "naics_code"
      expr: naics_code
      comment: "NAICS industry code of the organisation, used for vertical market analysis and industry-level benchmarking."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for the account, used for cash flow forecasting and credit risk management."
    - name: "government_entity_type"
      expr: government_entity_type
      comment: "Type of government entity (e.g. federal, state, municipal) for public sector fleet programme analysis."
    - name: "effective_from_year"
      expr: YEAR(effective_from)
      comment: "Year the account relationship became effective, used for account tenure and cohort analysis."
  measures:
    - name: "total_organization_accounts"
      expr: COUNT(DISTINCT organization_account_id)
      comment: "Total number of organisation accounts. Baseline metric for the B2B customer portfolio."
    - name: "active_organization_accounts"
      expr: COUNT(DISTINCT CASE WHEN organization_account_status = 'active' THEN organization_account_id END)
      comment: "Count of currently active organisation accounts. Measures the live B2B revenue base."
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Total annual revenue across all organisation accounts. Primary B2B revenue KPI for executive and board reporting."
    - name: "avg_annual_revenue"
      expr: AVG(CAST(annual_revenue AS DOUBLE))
      comment: "Average annual revenue per organisation account. Benchmarks account value and identifies growth opportunities."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all organisation accounts. Measures aggregate B2B credit exposure for risk management."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per organisation account. Used to benchmark credit policy and identify concentration risk."
    - name: "parent_child_accounts"
      expr: COUNT(DISTINCT CASE WHEN parent_organization_account_id IS NOT NULL THEN organization_account_id END)
      comment: "Count of accounts with a parent account relationship. Measures enterprise account hierarchy depth for key account management."
$$;