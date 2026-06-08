-- Metric views for domain: customer | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 23:12:43

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core customer account metrics tracking account counts, revenue bands, key account status, and channel distribution for strategic customer portfolio analysis."
  source: "`food_beverage_ecm`.`customer`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the customer account (active, inactive, suspended, etc.)"
    - name: "account_type"
      expr: account_type
      comment: "Classification of account type (retail, foodservice, distributor, etc.)"
    - name: "channel"
      expr: channel
      comment: "Sales channel through which the account is served (retail, foodservice, direct-to-consumer, etc.)"
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment classification for the account"
    - name: "annual_revenue_band"
      expr: annual_revenue_band
      comment: "Revenue band classification for account size and potential"
    - name: "key_account_flag"
      expr: key_account_flag
      comment: "Indicates whether this is a strategic key account requiring special management"
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Indicates whether the account is tax-exempt"
    - name: "shipping_country"
      expr: shipping_country
      comment: "Country where the account receives shipments"
    - name: "shipping_state"
      expr: shipping_state
      comment: "State or province where the account receives shipments"
    - name: "first_order_year"
      expr: YEAR(first_order_date)
      comment: "Year of first order, used for cohort analysis"
    - name: "first_order_month"
      expr: DATE_TRUNC('MONTH', first_order_date)
      comment: "Month of first order for customer acquisition cohort tracking"
    - name: "nps_score"
      expr: nps_score
      comment: "Net Promoter Score category for the account"
  measures:
    - name: "total_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Total number of unique customer accounts"
    - name: "active_accounts"
      expr: COUNT(DISTINCT CASE WHEN account_status = 'Active' THEN account_id END)
      comment: "Number of accounts with active status, key indicator of current customer base health"
    - name: "key_accounts"
      expr: COUNT(DISTINCT CASE WHEN key_account_flag = TRUE THEN account_id END)
      comment: "Number of strategic key accounts requiring dedicated management resources"
    - name: "key_account_penetration_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN key_account_flag = TRUE THEN account_id END) / NULLIF(COUNT(DISTINCT account_id), 0), 2)
      comment: "Percentage of accounts classified as key accounts, indicates portfolio concentration and strategic focus"
    - name: "tax_exempt_accounts"
      expr: COUNT(DISTINCT CASE WHEN tax_exempt_flag = TRUE THEN account_id END)
      comment: "Number of tax-exempt accounts, impacts revenue recognition and compliance requirements"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`customer_account_hierarchy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Account hierarchy and organizational structure metrics for analyzing customer portfolio rollups, regional performance, and loyalty program participation."
  source: "`food_beverage_ecm`.`customer`.`account_hierarchy`"
  dimensions:
    - name: "hierarchy_type"
      expr: hierarchy_type
      comment: "Type of account hierarchy relationship (corporate, franchise, buying group, etc.)"
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level within the account hierarchy structure"
    - name: "market"
      expr: market
      comment: "Market classification for the account hierarchy node"
    - name: "region_code"
      expr: region_code
      comment: "Regional code for geographic rollup and analysis"
    - name: "segment"
      expr: segment
      comment: "Customer segment classification at hierarchy level"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel for the hierarchy node"
    - name: "loyalty_program_flag"
      expr: loyalty_program_flag
      comment: "Indicates participation in loyalty program"
    - name: "rollup_acv_flag"
      expr: rollup_acv_flag
      comment: "Indicates whether Annual Contract Value should be rolled up at this hierarchy level"
    - name: "account_hierarchy_status"
      expr: account_hierarchy_status
      comment: "Current status of the hierarchy relationship"
  measures:
    - name: "total_hierarchy_nodes"
      expr: COUNT(DISTINCT account_hierarchy_id)
      comment: "Total number of account hierarchy nodes for organizational structure complexity analysis"
    - name: "loyalty_program_nodes"
      expr: COUNT(DISTINCT CASE WHEN loyalty_program_flag = TRUE THEN account_hierarchy_id END)
      comment: "Number of hierarchy nodes participating in loyalty programs, drives retention and wallet share strategies"
    - name: "loyalty_program_participation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN loyalty_program_flag = TRUE THEN account_hierarchy_id END) / NULLIF(COUNT(DISTINCT account_hierarchy_id), 0), 2)
      comment: "Percentage of hierarchy nodes in loyalty programs, key driver of customer lifetime value and retention investment ROI"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score across hierarchy nodes, executive-level customer satisfaction indicator"
    - name: "acv_rollup_nodes"
      expr: COUNT(DISTINCT CASE WHEN rollup_acv_flag = TRUE THEN account_hierarchy_id END)
      comment: "Number of nodes where ACV is rolled up, impacts revenue reporting and forecasting accuracy"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`customer_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer credit and financial risk metrics tracking credit limits, utilization, holds, and risk ratings for working capital and bad debt management."
  source: "`food_beverage_ecm`.`customer`.`credit_profile`"
  dimensions:
    - name: "credit_profile_status"
      expr: credit_profile_status
      comment: "Current status of the credit profile"
    - name: "credit_profile_type"
      expr: credit_profile_type
      comment: "Type or classification of credit profile"
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating assigned to the customer"
    - name: "credit_score"
      expr: credit_score
      comment: "Credit score category for the customer"
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Indicates whether account is on credit hold, blocking new orders"
    - name: "credit_limit_override_flag"
      expr: credit_limit_override_flag
      comment: "Indicates whether credit limit has been manually overridden"
    - name: "credit_limit_currency"
      expr: credit_limit_currency
      comment: "Currency in which credit limit is denominated"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms granted to the customer (Net 30, Net 60, etc.)"
    - name: "credit_score_source"
      expr: credit_score_source
      comment: "Source of the credit score (Dun & Bradstreet, internal, etc.)"
    - name: "insurance_provider"
      expr: insurance_provider
      comment: "Credit insurance provider, if applicable"
  measures:
    - name: "total_credit_profiles"
      expr: COUNT(DISTINCT credit_profile_id)
      comment: "Total number of credit profiles under management"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all customers, represents maximum working capital exposure"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per customer, indicates typical customer credit capacity"
    - name: "avg_credit_utilization_pct"
      expr: AVG(CAST(credit_utilization_percent AS DOUBLE))
      comment: "Average credit utilization percentage, key indicator of customer financial health and collection risk"
    - name: "credit_hold_profiles"
      expr: COUNT(DISTINCT CASE WHEN credit_hold_flag = TRUE THEN credit_profile_id END)
      comment: "Number of profiles on credit hold, directly impacts order fulfillment and revenue recognition"
    - name: "credit_hold_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN credit_hold_flag = TRUE THEN credit_profile_id END) / NULLIF(COUNT(DISTINCT credit_profile_id), 0), 2)
      comment: "Percentage of customers on credit hold, executive KPI for credit risk and collections effectiveness"
    - name: "override_profiles"
      expr: COUNT(DISTINCT CASE WHEN credit_limit_override_flag = TRUE THEN credit_profile_id END)
      comment: "Number of profiles with credit limit overrides, indicates exception management volume and policy compliance"
    - name: "total_insurance_coverage"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total credit insurance coverage amount, reduces net credit risk exposure and bad debt reserve requirements"
    - name: "avg_credit_limit_adjustment"
      expr: AVG(CAST(credit_limit_adjustment_amount AS DOUBLE))
      comment: "Average credit limit adjustment amount, indicates credit policy responsiveness to customer performance"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`customer_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer contact and communication preference metrics for marketing reach, opt-in rates, and contact data quality management."
  source: "`food_beverage_ecm`.`customer`.`contact`"
  dimensions:
    - name: "contact_status"
      expr: contact_status
      comment: "Current status of the contact record"
    - name: "contact_type"
      expr: contact_type
      comment: "Type or role of the contact (decision maker, influencer, user, etc.)"
    - name: "country_code"
      expr: country_code
      comment: "Country code for the contact location"
    - name: "language_preference"
      expr: language_preference
      comment: "Preferred language for communications"
    - name: "preferred_communication_channel"
      expr: preferred_communication_channel
      comment: "Preferred channel for contact (email, phone, SMS, etc.)"
    - name: "opt_in_flag"
      expr: opt_in_flag
      comment: "Indicates contact has opted in to marketing communications"
    - name: "opt_out_flag"
      expr: opt_out_flag
      comment: "Indicates contact has opted out of marketing communications"
    - name: "nps_eligible_flag"
      expr: nps_eligible_flag
      comment: "Indicates whether contact is eligible for NPS surveys"
    - name: "role"
      expr: role
      comment: "Business role or title of the contact"
  measures:
    - name: "total_contacts"
      expr: COUNT(DISTINCT contact_id)
      comment: "Total number of customer contacts in database"
    - name: "opted_in_contacts"
      expr: COUNT(DISTINCT CASE WHEN opt_in_flag = TRUE THEN contact_id END)
      comment: "Number of contacts opted in to marketing, defines addressable audience for campaigns and revenue opportunity"
    - name: "opt_in_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN opt_in_flag = TRUE THEN contact_id END) / NULLIF(COUNT(DISTINCT contact_id), 0), 2)
      comment: "Percentage of contacts opted in to marketing, key driver of marketing reach and campaign ROI potential"
    - name: "opted_out_contacts"
      expr: COUNT(DISTINCT CASE WHEN opt_out_flag = TRUE THEN contact_id END)
      comment: "Number of contacts who have opted out, indicates brand sentiment and compliance risk"
    - name: "nps_eligible_contacts"
      expr: COUNT(DISTINCT CASE WHEN nps_eligible_flag = TRUE THEN contact_id END)
      comment: "Number of contacts eligible for NPS surveys, defines sample size for customer satisfaction measurement"
    - name: "nps_eligible_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN nps_eligible_flag = TRUE THEN contact_id END) / NULLIF(COUNT(DISTINCT contact_id), 0), 2)
      comment: "Percentage of contacts eligible for NPS, impacts statistical validity of customer satisfaction insights"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`customer_consent_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Privacy consent and data processing compliance metrics tracking consent status, legal basis, and jurisdiction coverage for GDPR/CCPA regulatory adherence."
  source: "`food_beverage_ecm`.`customer`.`consent_record`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent (active, withdrawn, expired, etc.)"
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent (marketing, data processing, profiling, etc.)"
    - name: "consent_source"
      expr: consent_source
      comment: "Source or channel through which consent was obtained"
    - name: "legal_basis"
      expr: legal_basis
      comment: "Legal basis for data processing (consent, legitimate interest, contract, etc.)"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction governing the consent (GDPR, CCPA, etc.)"
    - name: "data_processing_purpose"
      expr: data_processing_purpose
      comment: "Purpose for which data processing consent was granted"
    - name: "consent_version"
      expr: consent_version
      comment: "Version of the consent form or privacy policy"
    - name: "privacy_policy_version"
      expr: privacy_policy_version
      comment: "Version of privacy policy under which consent was granted"
  measures:
    - name: "total_consent_records"
      expr: COUNT(DISTINCT consent_record_id)
      comment: "Total number of consent records, indicates scope of privacy compliance tracking"
    - name: "active_consents"
      expr: COUNT(DISTINCT CASE WHEN consent_status = 'Active' THEN consent_record_id END)
      comment: "Number of active consent records, defines legally compliant addressable audience for data processing"
    - name: "withdrawn_consents"
      expr: COUNT(DISTINCT CASE WHEN consent_status = 'Withdrawn' THEN consent_record_id END)
      comment: "Number of withdrawn consents, indicates customer privacy concerns and potential regulatory risk"
    - name: "consent_withdrawal_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN consent_status = 'Withdrawn' THEN consent_record_id END) / NULLIF(COUNT(DISTINCT consent_record_id), 0), 2)
      comment: "Percentage of consents withdrawn, executive KPI for privacy program effectiveness and brand trust"
    - name: "unique_contacts_with_consent"
      expr: COUNT(DISTINCT contact_id)
      comment: "Number of unique contacts with consent records, measures privacy compliance coverage"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`customer_ship_to_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipping location and logistics capability metrics for delivery network optimization, capacity planning, and service level management."
  source: "`food_beverage_ecm`.`customer`.`ship_to_location`"
  dimensions:
    - name: "ship_to_location_status"
      expr: ship_to_location_status
      comment: "Current status of the shipping location"
    - name: "location_type"
      expr: location_type
      comment: "Type of shipping location (warehouse, store, distribution center, etc.)"
    - name: "country_code"
      expr: country_code
      comment: "Country code for the shipping location"
    - name: "state_province"
      expr: state_province
      comment: "State or province of the shipping location"
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature control zone requirement (ambient, refrigerated, frozen)"
    - name: "is_primary"
      expr: is_primary
      comment: "Indicates whether this is the primary shipping location for the account"
  measures:
    - name: "total_ship_to_locations"
      expr: COUNT(DISTINCT ship_to_location_id)
      comment: "Total number of shipping locations, indicates delivery network complexity and logistics cost drivers"
    - name: "active_ship_to_locations"
      expr: COUNT(DISTINCT CASE WHEN ship_to_location_status = 'Active' THEN ship_to_location_id END)
      comment: "Number of active shipping locations, defines current delivery network footprint for capacity planning"
    - name: "total_capacity_cubic_meters"
      expr: SUM(CAST(capacity_cubic_meters AS DOUBLE))
      comment: "Total storage capacity across all shipping locations in cubic meters, key input for inventory positioning and network optimization"
    - name: "avg_capacity_cubic_meters"
      expr: AVG(CAST(capacity_cubic_meters AS DOUBLE))
      comment: "Average storage capacity per location, indicates typical location size for network design"
    - name: "total_max_weight_kg"
      expr: SUM(CAST(max_weight_kg AS DOUBLE))
      comment: "Total maximum weight capacity across locations in kilograms, constrains order fulfillment and routing decisions"
    - name: "primary_locations"
      expr: COUNT(DISTINCT CASE WHEN is_primary = TRUE THEN ship_to_location_id END)
      comment: "Number of primary shipping locations, indicates key delivery points for route optimization"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`customer_segment_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer segmentation assignment metrics tracking segment distribution, assignment currency, and primary segment coverage for targeted marketing and sales strategies."
  source: "`food_beverage_ecm`.`customer`.`segment_assignment`"
  dimensions:
    - name: "segment_assignment_status"
      expr: segment_assignment_status
      comment: "Current status of the segment assignment"
    - name: "is_current"
      expr: is_current
      comment: "Indicates whether this is the current active segment assignment"
    - name: "primary_flag"
      expr: primary_flag
      comment: "Indicates whether this is the primary segment for the account"
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign the segment (rule-based, manual, ML model, etc.)"
    - name: "segment_priority"
      expr: segment_priority
      comment: "Priority level of the segment assignment"
    - name: "assignment_year"
      expr: YEAR(assignment_date)
      comment: "Year of segment assignment for trend analysis"
    - name: "assignment_month"
      expr: DATE_TRUNC('MONTH', assignment_date)
      comment: "Month of segment assignment for cohort tracking"
  measures:
    - name: "total_segment_assignments"
      expr: COUNT(DISTINCT segment_assignment_id)
      comment: "Total number of segment assignments, indicates segmentation complexity"
    - name: "current_assignments"
      expr: COUNT(DISTINCT CASE WHEN is_current = TRUE THEN segment_assignment_id END)
      comment: "Number of current active segment assignments, defines current segmentation coverage for targeting"
    - name: "primary_assignments"
      expr: COUNT(DISTINCT CASE WHEN primary_flag = TRUE THEN segment_assignment_id END)
      comment: "Number of primary segment assignments, indicates accounts with clear primary segment for focused strategy execution"
    - name: "unique_accounts_segmented"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique accounts with segment assignments, measures segmentation coverage of customer base"
    - name: "unique_segments_assigned"
      expr: COUNT(DISTINCT segment_id)
      comment: "Number of unique segments in use, indicates segmentation model granularity and targeting precision"
    - name: "primary_assignment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN primary_flag = TRUE THEN segment_assignment_id END) / NULLIF(COUNT(DISTINCT segment_assignment_id), 0), 2)
      comment: "Percentage of assignments that are primary, indicates segmentation clarity and decision-making confidence"
$$;