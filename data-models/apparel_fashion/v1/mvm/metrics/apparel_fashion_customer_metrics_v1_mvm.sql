-- Metric views for domain: customer | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 18:03:30

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`customer_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core customer profile metrics tracking customer acquisition, engagement, and identity quality across channels and regions"
  source: "`apparel_fashion_ecm`.`customer`.`profile`"
  dimensions:
    - name: "customer_type"
      expr: customer_type
      comment: "Type of customer (retail, wholesale, employee, etc.)"
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the customer profile (active, inactive, suspended, merged)"
    - name: "registration_source"
      expr: registration_source
      comment: "Channel or touchpoint where customer registered (web, mobile app, in-store, social)"
    - name: "country_of_residence"
      expr: country_of_residence
      comment: "Customer's country of residence for geographic segmentation"
    - name: "preferred_language"
      expr: preferred_language
      comment: "Customer's preferred language for communications"
    - name: "gender_identity"
      expr: gender_identity
      comment: "Customer's gender identity for product affinity and sizing analysis"
    - name: "is_verified"
      expr: is_verified
      comment: "Whether the customer profile has been verified (email, phone, identity)"
    - name: "email_opt_in"
      expr: email_opt_in
      comment: "Whether customer has opted in to email marketing"
    - name: "sms_opt_in"
      expr: sms_opt_in
      comment: "Whether customer has opted in to SMS marketing"
    - name: "push_notification_opt_in"
      expr: push_notification_opt_in
      comment: "Whether customer has opted in to push notifications"
    - name: "gdpr_consent_flag"
      expr: gdpr_consent_flag
      comment: "GDPR consent status for European customers"
    - name: "ccpa_opt_out_flag"
      expr: ccpa_opt_out_flag
      comment: "CCPA opt-out status for California customers"
    - name: "registration_year"
      expr: YEAR(created_timestamp)
      comment: "Year the customer profile was created"
    - name: "registration_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the customer profile was created for cohort analysis"
    - name: "identity_resolution_method"
      expr: identity_resolution_method
      comment: "Method used to resolve customer identity (deterministic, probabilistic, manual)"
  measures:
    - name: "total_profiles"
      expr: COUNT(1)
      comment: "Total number of customer profiles"
    - name: "unique_customers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of customer profiles"
    - name: "verified_profiles"
      expr: SUM(CASE WHEN is_verified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of verified customer profiles"
    - name: "verification_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_verified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of customer profiles that are verified - key identity quality metric"
    - name: "email_opt_in_count"
      expr: SUM(CASE WHEN email_opt_in = TRUE THEN 1 ELSE 0 END)
      comment: "Count of customers opted in to email marketing"
    - name: "email_opt_in_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN email_opt_in = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Email opt-in rate - critical for marketing reach and campaign planning"
    - name: "sms_opt_in_count"
      expr: SUM(CASE WHEN sms_opt_in = TRUE THEN 1 ELSE 0 END)
      comment: "Count of customers opted in to SMS marketing"
    - name: "sms_opt_in_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sms_opt_in = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "SMS opt-in rate - key metric for mobile marketing strategy"
    - name: "push_opt_in_count"
      expr: SUM(CASE WHEN push_notification_opt_in = TRUE THEN 1 ELSE 0 END)
      comment: "Count of customers opted in to push notifications"
    - name: "multi_channel_opt_in_count"
      expr: SUM(CASE WHEN email_opt_in = TRUE AND sms_opt_in = TRUE AND push_notification_opt_in = TRUE THEN 1 ELSE 0 END)
      comment: "Count of customers opted in to all three marketing channels - highest engagement segment"
    - name: "gdpr_consent_count"
      expr: SUM(CASE WHEN gdpr_consent_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of customers with GDPR consent"
    - name: "ccpa_opt_out_count"
      expr: SUM(CASE WHEN ccpa_opt_out_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of customers who have opted out under CCPA"
    - name: "avg_identity_confidence_score"
      expr: AVG(CAST(identity_confidence_score AS DOUBLE))
      comment: "Average identity confidence score - measures quality of identity resolution"
    - name: "loyalty_enrolled_count"
      expr: SUM(CASE WHEN loyalty_enrollment_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of customers enrolled in loyalty program"
    - name: "loyalty_enrollment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN loyalty_enrollment_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Loyalty program enrollment rate - key driver of customer lifetime value"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`customer_loyalty_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty program enrollment and engagement metrics tracking member acquisition, activity, points economics, and tier progression"
  source: "`apparel_fashion_ecm`.`customer`.`loyalty_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of loyalty enrollment (active, inactive, suspended, terminated)"
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which customer enrolled (in-store, online, mobile app, call center)"
    - name: "member_card_type"
      expr: member_card_type
      comment: "Type of loyalty membership card (physical, digital, premium)"
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year of loyalty enrollment for cohort analysis"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of loyalty enrollment for trend analysis"
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for loyalty program termination (voluntary, fraud, inactivity, policy violation)"
    - name: "opt_in_email"
      expr: opt_in_email
      comment: "Email opt-in status for loyalty members"
    - name: "opt_in_sms"
      expr: opt_in_sms
      comment: "SMS opt-in status for loyalty members"
    - name: "gdpr_consent_flag"
      expr: gdpr_consent_flag
      comment: "GDPR consent status for loyalty members"
    - name: "ccpa_opt_out_flag"
      expr: ccpa_opt_out_flag
      comment: "CCPA opt-out status for loyalty members"
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total number of loyalty enrollments"
    - name: "unique_loyalty_members"
      expr: COUNT(DISTINCT loyalty_enrollment_id)
      comment: "Distinct count of loyalty members"
    - name: "active_members"
      expr: SUM(CASE WHEN enrollment_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active loyalty members"
    - name: "terminated_members"
      expr: SUM(CASE WHEN termination_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of terminated loyalty memberships"
    - name: "retention_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN enrollment_status = 'active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Loyalty member retention rate - critical for program ROI assessment"
    - name: "total_lifetime_points_earned"
      expr: SUM(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Total lifetime points earned across all members"
    - name: "total_lifetime_points_redeemed"
      expr: SUM(CAST(lifetime_points_redeemed AS DOUBLE))
      comment: "Total lifetime points redeemed across all members"
    - name: "total_lifetime_points_expired"
      expr: SUM(CAST(lifetime_points_expired AS DOUBLE))
      comment: "Total lifetime points expired across all members"
    - name: "total_points_balance"
      expr: SUM(CAST(points_balance AS DOUBLE))
      comment: "Total current points balance - represents loyalty liability"
    - name: "total_pending_points"
      expr: SUM(CAST(pending_points AS DOUBLE))
      comment: "Total pending points not yet credited"
    - name: "avg_points_balance"
      expr: AVG(CAST(points_balance AS DOUBLE))
      comment: "Average points balance per member - indicates engagement level"
    - name: "redemption_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(lifetime_points_redeemed AS DOUBLE)) / NULLIF(SUM(CAST(lifetime_points_earned AS DOUBLE)), 0), 2)
      comment: "Points redemption rate - key metric for program engagement and liability management"
    - name: "breakage_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(lifetime_points_expired AS DOUBLE)) / NULLIF(SUM(CAST(lifetime_points_earned AS DOUBLE)), 0), 2)
      comment: "Points breakage rate - unredeemed points that expired, reduces program cost"
    - name: "avg_lifetime_points_earned"
      expr: AVG(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Average lifetime points earned per member - measures program participation"
    - name: "total_tier_qualification_spend"
      expr: SUM(CAST(tier_qualification_spend AS DOUBLE))
      comment: "Total spend qualifying for tier status across all members"
    - name: "avg_tier_qualification_spend"
      expr: AVG(CAST(tier_qualification_spend AS DOUBLE))
      comment: "Average tier qualification spend per member - indicates member value"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`customer_segment_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer segment membership metrics tracking segment population, assignment quality, and membership lifecycle"
  source: "`apparel_fashion_ecm`.`customer`.`segment_membership`"
  dimensions:
    - name: "is_active"
      expr: is_active
      comment: "Whether the segment membership is currently active"
    - name: "assignment_source"
      expr: assignment_source
      comment: "Source system or process that assigned the segment (rule engine, ML model, manual)"
    - name: "assignment_year"
      expr: YEAR(assignment_date)
      comment: "Year the segment membership was assigned"
    - name: "assignment_month"
      expr: DATE_TRUNC('MONTH', assignment_date)
      comment: "Month the segment membership was assigned for trend analysis"
    - name: "has_expiry"
      expr: CASE WHEN expiry_date IS NOT NULL THEN TRUE ELSE FALSE END
      comment: "Whether the segment membership has an expiration date"
  measures:
    - name: "total_memberships"
      expr: COUNT(1)
      comment: "Total number of segment memberships (customers can belong to multiple segments)"
    - name: "unique_customers_in_segments"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of customers with at least one segment membership"
    - name: "unique_segments_assigned"
      expr: COUNT(DISTINCT segment_id)
      comment: "Distinct count of segments with at least one member"
    - name: "active_memberships"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of currently active segment memberships"
    - name: "inactive_memberships"
      expr: SUM(CASE WHEN is_active = FALSE THEN 1 ELSE 0 END)
      comment: "Count of inactive segment memberships"
    - name: "active_membership_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of segment memberships that are active - indicates segment freshness"
    - name: "avg_membership_score"
      expr: AVG(CAST(membership_score AS DOUBLE))
      comment: "Average membership score - measures confidence or fit of segment assignment"
    - name: "memberships_with_expiry"
      expr: SUM(CASE WHEN expiry_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of segment memberships with defined expiration dates"
    - name: "avg_memberships_per_customer"
      expr: ROUND(CAST(COUNT(1) AS DOUBLE) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Average number of segment memberships per customer - indicates segmentation complexity"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`customer_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer consent and privacy preference metrics tracking consent collection, status, regulatory compliance, and opt-in rates across channels and jurisdictions"
  source: "`apparel_fashion_ecm`.`customer`.`consent`"
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent (marketing, data processing, profiling, third-party sharing)"
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of consent (granted, withdrawn, pending, expired)"
    - name: "consent_method"
      expr: consent_method
      comment: "Method by which consent was collected (web form, mobile app, in-store, call center)"
    - name: "collection_channel"
      expr: collection_channel
      comment: "Channel where consent was collected (ecommerce, retail, wholesale, event)"
    - name: "legal_basis"
      expr: legal_basis
      comment: "Legal basis for data processing (consent, contract, legitimate interest, legal obligation)"
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction governing the consent (GDPR, CCPA, LGPD, PIPEDA)"
    - name: "country_code"
      expr: country_code
      comment: "Country where consent was collected"
    - name: "device_type"
      expr: device_type
      comment: "Device type used for consent collection (desktop, mobile, tablet, in-store terminal)"
    - name: "double_opt_in_flag"
      expr: double_opt_in_flag
      comment: "Whether double opt-in was used (email confirmation required)"
    - name: "is_active"
      expr: is_active
      comment: "Whether the consent record is currently active"
    - name: "suppression_flag"
      expr: suppression_flag
      comment: "Whether the customer is suppressed from communications"
    - name: "third_party_sharing_flag"
      expr: third_party_sharing_flag
      comment: "Whether customer consented to third-party data sharing"
    - name: "granted_year"
      expr: YEAR(granted_timestamp)
      comment: "Year consent was granted"
    - name: "granted_month"
      expr: DATE_TRUNC('MONTH', granted_timestamp)
      comment: "Month consent was granted for trend analysis"
  measures:
    - name: "total_consent_records"
      expr: COUNT(1)
      comment: "Total number of consent records"
    - name: "unique_consents"
      expr: COUNT(DISTINCT consent_id)
      comment: "Distinct count of consent records"
    - name: "unique_customers_with_consent"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of customers with at least one consent record"
    - name: "granted_consents"
      expr: SUM(CASE WHEN consent_status = 'granted' THEN 1 ELSE 0 END)
      comment: "Count of granted consents"
    - name: "withdrawn_consents"
      expr: SUM(CASE WHEN consent_status = 'withdrawn' THEN 1 ELSE 0 END)
      comment: "Count of withdrawn consents"
    - name: "consent_grant_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_status = 'granted' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consents that are granted - key metric for marketing reach"
    - name: "consent_withdrawal_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_status = 'withdrawn' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consents that have been withdrawn - indicates customer satisfaction and privacy concerns"
    - name: "active_consents"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of currently active consent records"
    - name: "double_opt_in_count"
      expr: SUM(CASE WHEN double_opt_in_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of consents collected with double opt-in"
    - name: "double_opt_in_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN double_opt_in_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Double opt-in rate - indicates consent quality and reduces spam complaints"
    - name: "suppressed_customers"
      expr: SUM(CASE WHEN suppression_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of customers suppressed from communications"
    - name: "third_party_sharing_consents"
      expr: SUM(CASE WHEN third_party_sharing_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of customers who consented to third-party data sharing"
    - name: "re_consent_required_count"
      expr: SUM(CASE WHEN re_consent_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of consent records requiring re-consent due to policy changes"
    - name: "parental_consent_count"
      expr: SUM(CASE WHEN parental_consent_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of consents requiring parental approval (minors)"
    - name: "nps_eligible_count"
      expr: SUM(CASE WHEN nps_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of customers eligible for NPS surveys based on consent"
    - name: "personalization_eligible_count"
      expr: SUM(CASE WHEN personalization_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of customers eligible for personalization based on consent"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`customer_service_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer service request metrics tracking case volume, resolution efficiency, SLA compliance, customer satisfaction, and service quality"
  source: "`apparel_fashion_ecm`.`customer`.`service_request`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Type of service request (return, exchange, complaint, inquiry, technical support)"
    - name: "case_status"
      expr: case_status
      comment: "Current status of the service request (open, in progress, resolved, closed, escalated)"
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which request was submitted (phone, email, chat, social media, in-store)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the service request (low, medium, high, critical)"
    - name: "assigned_team"
      expr: assigned_team
      comment: "Team assigned to handle the service request"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the case has been escalated"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the case breached SLA targets"
    - name: "resolution_category"
      expr: resolution_category
      comment: "Category of resolution (refund issued, product replaced, issue resolved, no action needed)"
    - name: "country_code"
      expr: country_code
      comment: "Country where the service request originated"
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year the service request was created"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the service request was created for trend analysis"
  measures:
    - name: "total_service_requests"
      expr: COUNT(1)
      comment: "Total number of service requests"
    - name: "unique_service_requests"
      expr: COUNT(DISTINCT service_request_id)
      comment: "Distinct count of service requests"
    - name: "unique_customers_with_requests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of customers who submitted service requests"
    - name: "open_cases"
      expr: SUM(CASE WHEN case_status IN ('open', 'in progress') THEN 1 ELSE 0 END)
      comment: "Count of currently open or in-progress service requests"
    - name: "resolved_cases"
      expr: SUM(CASE WHEN case_status IN ('resolved', 'closed') THEN 1 ELSE 0 END)
      comment: "Count of resolved or closed service requests"
    - name: "resolution_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN case_status IN ('resolved', 'closed') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service requests that have been resolved - key service efficiency metric"
    - name: "escalated_cases"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of escalated service requests"
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases that required escalation - indicates first-contact resolution quality"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of service requests that breached SLA"
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = FALSE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases meeting SLA targets - critical service quality metric"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued through service requests"
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund amount per service request"
    - name: "cases_with_refund"
      expr: SUM(CASE WHEN refund_amount > 0 THEN 1 ELSE 0 END)
      comment: "Count of service requests that resulted in a refund"
    - name: "refund_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN refund_amount > 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service requests resulting in refunds - indicates product quality and service cost"
    - name: "avg_sla_target_response_hours"
      expr: AVG(CAST(sla_target_response_hours AS DOUBLE))
      comment: "Average SLA target for first response in hours"
    - name: "avg_sla_target_resolution_hours"
      expr: AVG(CAST(sla_target_resolution_hours AS DOUBLE))
      comment: "Average SLA target for resolution in hours"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`customer_wholesale_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wholesale account metrics tracking B2B customer portfolio, credit exposure, account health, and relationship quality"
  source: "`apparel_fashion_ecm`.`customer`.`wholesale_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of wholesale account (active, inactive, suspended, closed)"
    - name: "account_type"
      expr: account_type
      comment: "Type of wholesale account (distributor, retailer, franchise, department store)"
    - name: "account_tier"
      expr: account_tier
      comment: "Tier classification of account (platinum, gold, silver, bronze) based on volume or strategic value"
    - name: "relationship_status"
      expr: relationship_status
      comment: "Status of business relationship (new, growing, stable, at-risk, churned)"
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating of the wholesale account"
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms code (Net 30, Net 60, COD, etc.)"
    - name: "country_code"
      expr: country_code
      comment: "Country where the wholesale account is located"
    - name: "industry_segment"
      expr: industry_segment
      comment: "Industry segment of the wholesale customer"
    - name: "edi_capable"
      expr: edi_capable
      comment: "Whether the account is EDI-capable for automated ordering"
    - name: "rfid_enabled"
      expr: rfid_enabled
      comment: "Whether the account uses RFID technology for inventory management"
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in account hierarchy (parent, subsidiary, branch)"
    - name: "onboarding_year"
      expr: YEAR(onboarding_date)
      comment: "Year the account was onboarded"
    - name: "contract_status"
      expr: CASE WHEN contract_end_date < CURRENT_DATE THEN 'expired' WHEN contract_end_date IS NULL THEN 'no_contract' ELSE 'active' END
      comment: "Derived contract status based on end date"
  measures:
    - name: "total_wholesale_accounts"
      expr: COUNT(1)
      comment: "Total number of wholesale accounts"
    - name: "unique_wholesale_accounts"
      expr: COUNT(DISTINCT wholesale_account_id)
      comment: "Distinct count of wholesale accounts"
    - name: "active_accounts"
      expr: SUM(CASE WHEN account_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active wholesale accounts"
    - name: "inactive_accounts"
      expr: SUM(CASE WHEN account_status = 'inactive' THEN 1 ELSE 0 END)
      comment: "Count of inactive wholesale accounts"
    - name: "suspended_accounts"
      expr: SUM(CASE WHEN account_status = 'suspended' THEN 1 ELSE 0 END)
      comment: "Count of suspended wholesale accounts"
    - name: "account_activation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN account_status = 'active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of wholesale accounts that are active - key portfolio health metric"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all wholesale accounts"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per wholesale account - indicates account size and risk exposure"
    - name: "edi_capable_accounts"
      expr: SUM(CASE WHEN edi_capable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of EDI-capable accounts"
    - name: "edi_adoption_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN edi_capable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "EDI adoption rate - indicates operational efficiency and automation level"
    - name: "rfid_enabled_accounts"
      expr: SUM(CASE WHEN rfid_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of RFID-enabled accounts"
    - name: "rfid_adoption_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN rfid_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "RFID adoption rate - indicates supply chain technology sophistication"
    - name: "accounts_with_parent"
      expr: SUM(CASE WHEN parent_account_wholesale_account_id IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of accounts that are part of a larger organization"
    - name: "accounts_with_contract"
      expr: SUM(CASE WHEN contract_start_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of accounts with formal contracts"
    - name: "contract_coverage_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN contract_start_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accounts with formal contracts - indicates relationship formalization"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`customer_payment_method`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment method metrics tracking payment instrument portfolio, verification status, fraud risk, and payment method adoption"
  source: "`apparel_fashion_ecm`.`customer`.`payment_method`"
  dimensions:
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment method (credit card, debit card, digital wallet, BNPL, bank transfer)"
    - name: "payment_method_status"
      expr: payment_method_status
      comment: "Status of payment method (active, expired, suspended, failed verification)"
    - name: "card_brand"
      expr: card_brand
      comment: "Card brand (Visa, Mastercard, Amex, Discover) for card payments"
    - name: "card_funding_type"
      expr: card_funding_type
      comment: "Funding type of card (credit, debit, prepaid)"
    - name: "digital_wallet_type"
      expr: digital_wallet_type
      comment: "Type of digital wallet (Apple Pay, Google Pay, PayPal, etc.)"
    - name: "bnpl_provider"
      expr: bnpl_provider
      comment: "Buy Now Pay Later provider (Klarna, Afterpay, Affirm, etc.)"
    - name: "issuing_country_code"
      expr: issuing_country_code
      comment: "Country where the payment instrument was issued"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of payment method (verified, pending, failed)"
    - name: "is_default"
      expr: is_default
      comment: "Whether this is the customer's default payment method"
    - name: "three_d_secure_enrolled"
      expr: three_d_secure_enrolled
      comment: "Whether the payment method is enrolled in 3D Secure authentication"
    - name: "recurring_billing_enabled"
      expr: recurring_billing_enabled
      comment: "Whether the payment method is enabled for recurring billing"
    - name: "added_channel"
      expr: added_channel
      comment: "Channel where payment method was added (web, mobile app, in-store, call center)"
    - name: "added_year"
      expr: YEAR(added_date)
      comment: "Year the payment method was added"
  measures:
    - name: "total_payment_methods"
      expr: COUNT(1)
      comment: "Total number of payment methods on file"
    - name: "unique_payment_methods"
      expr: COUNT(DISTINCT payment_method_id)
      comment: "Distinct count of payment methods"
    - name: "unique_customers_with_payment_methods"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of customers with at least one payment method on file"
    - name: "active_payment_methods"
      expr: SUM(CASE WHEN payment_method_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active payment methods"
    - name: "expired_payment_methods"
      expr: SUM(CASE WHEN payment_method_status = 'expired' THEN 1 ELSE 0 END)
      comment: "Count of expired payment methods"
    - name: "verified_payment_methods"
      expr: SUM(CASE WHEN verification_status = 'verified' THEN 1 ELSE 0 END)
      comment: "Count of verified payment methods"
    - name: "verification_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN verification_status = 'verified' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payment methods that are verified - reduces fraud risk"
    - name: "default_payment_methods"
      expr: SUM(CASE WHEN is_default = TRUE THEN 1 ELSE 0 END)
      comment: "Count of payment methods marked as default"
    - name: "three_d_secure_enrolled_count"
      expr: SUM(CASE WHEN three_d_secure_enrolled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of payment methods enrolled in 3D Secure"
    - name: "three_d_secure_adoption_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN three_d_secure_enrolled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "3D Secure enrollment rate - indicates fraud prevention coverage"
    - name: "recurring_billing_enabled_count"
      expr: SUM(CASE WHEN recurring_billing_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of payment methods enabled for recurring billing"
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud score across payment methods - lower is better"
    - name: "pci_compliant_count"
      expr: SUM(CASE WHEN pci_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of PCI-compliant payment methods"
    - name: "auto_update_enabled_count"
      expr: SUM(CASE WHEN auto_update_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of payment methods with auto-update enabled (card updater service)"
    - name: "avg_payment_methods_per_customer"
      expr: ROUND(CAST(COUNT(1) AS DOUBLE) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Average number of payment methods per customer - indicates payment flexibility"
$$;