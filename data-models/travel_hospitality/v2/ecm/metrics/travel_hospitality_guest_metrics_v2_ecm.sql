-- Metric views for domain: guest | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-22 18:44:46

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core guest profile metrics tracking active guest population, loyalty enrollment penetration, VIP composition, opt-in rates, and data quality signals. Used by CRM, loyalty, and marketing leadership to steer guest acquisition and retention strategy."
  source: "`vibe_travel_hospitality_v1`.`guest`.`profile`"
  dimensions:
    - name: "guest_type"
      expr: guest_type
      comment: "Classification of guest (e.g. leisure, corporate, group) for segmented analysis."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Current loyalty tier of the guest profile for tier-based performance analysis."
    - name: "profile_status"
      expr: profile_status
      comment: "Active/inactive/merged status of the profile for data quality and active-base reporting."
    - name: "country_of_residence"
      expr: country_of_residence_code
      comment: "Guest country of residence for geographic segmentation."
    - name: "gender"
      expr: gender
      comment: "Gender dimension for demographic analysis."
    - name: "preferred_language"
      expr: preferred_language_code
      comment: "Preferred language for localization and communication strategy."
    - name: "vip_status"
      expr: vip_status
      comment: "VIP designation level for high-value guest segmentation."
    - name: "is_merge_survivor"
      expr: is_merge_survivor
      comment: "Flag indicating whether this profile survived a merge, used for deduplication quality tracking."
    - name: "loyalty_enrollment_year"
      expr: YEAR(loyalty_enrollment_date)
      comment: "Year of loyalty enrollment for cohort analysis."
    - name: "profile_creation_year"
      expr: YEAR(created_timestamp)
      comment: "Year the profile was created for new-guest acquisition trend analysis."
  measures:
    - name: "total_active_profiles"
      expr: COUNT(CASE WHEN profile_status = 'ACTIVE' THEN profile_id END)
      comment: "Total number of active guest profiles. Core KPI for CRM database health and active guest base sizing."
    - name: "total_profiles"
      expr: COUNT(1)
      comment: "Total guest profiles including all statuses. Used as denominator for penetration rate calculations."
    - name: "loyalty_enrolled_profiles"
      expr: COUNT(CASE WHEN loyalty_member_number IS NOT NULL THEN profile_id END)
      comment: "Number of profiles with a loyalty membership. Drives loyalty enrollment penetration KPI."
    - name: "loyalty_enrollment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN loyalty_member_number IS NOT NULL THEN profile_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of guest profiles enrolled in the loyalty program. Strategic KPI for loyalty program growth."
    - name: "email_opt_in_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN email_opt_in = TRUE THEN profile_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of profiles opted in to email marketing. Drives email channel reach and campaign planning."
    - name: "sms_opt_in_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sms_opt_in = TRUE THEN profile_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of profiles opted in to SMS marketing. Informs mobile channel investment decisions."
    - name: "vip_profile_count"
      expr: COUNT(CASE WHEN vip_status IS NOT NULL AND vip_status != '' THEN profile_id END)
      comment: "Number of profiles with an active VIP designation. Used to size VIP service resource requirements."
    - name: "vip_penetration_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN vip_status IS NOT NULL AND vip_status != '' THEN profile_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of guest profiles holding VIP status. Tracks exclusivity and VIP program scale."
    - name: "gdpr_erasure_requested_count"
      expr: COUNT(CASE WHEN gdpr_erasure_requested = TRUE THEN profile_id END)
      comment: "Number of profiles with a pending GDPR erasure request. Critical compliance and risk KPI for privacy officers."
    - name: "marketing_opt_in_count"
      expr: COUNT(CASE WHEN marketing_opt_in = TRUE THEN profile_id END)
      comment: "Number of profiles opted in to marketing communications. Determines addressable marketing audience size."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_stay_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest stay performance metrics including revenue per stay, ADR, ancillary attachment, and satisfaction scores. Per VREQ-020, RevPAR is NOT included here (it belongs to the revenue domain). Used by revenue management, guest experience, and loyalty teams."
  source: "`vibe_travel_hospitality_v1`.`guest`.`stay_history`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the stay occurred for property-level performance analysis."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment of the stay for segment-level revenue and satisfaction analysis."
    - name: "booking_channel_code"
      expr: booking_channel_code
      comment: "Channel through which the booking was made for channel contribution analysis."
    - name: "rate_plan_code"
      expr: rate_plan_code
      comment: "Rate plan applied during the stay for rate strategy evaluation."
    - name: "room_type_code"
      expr: room_type_code
      comment: "Room type occupied during the stay for room-type revenue analysis."
    - name: "stay_status"
      expr: stay_status
      comment: "Status of the stay (checked-in, checked-out, no-show) for operational reporting."
    - name: "loyalty_tier_at_stay"
      expr: loyalty_tier_at_stay
      comment: "Loyalty tier of the guest at time of stay for tier-based revenue analysis."
    - name: "guest_type"
      expr: guest_type
      comment: "Type of guest (leisure, corporate, group) for segment performance comparison."
    - name: "arrival_month"
      expr: DATE_TRUNC('MONTH', arrival_date)
      comment: "Month of arrival for trend and seasonality analysis."
    - name: "arrival_year"
      expr: YEAR(arrival_date)
      comment: "Year of arrival for year-over-year performance comparison."
    - name: "complimentary_flag"
      expr: complimentary_flag
      comment: "Whether the stay was complimentary, used to separate revenue-generating stays from comp stays."
    - name: "service_recovery_flag"
      expr: service_recovery_flag
      comment: "Whether a service recovery action was taken during the stay, for quality and satisfaction analysis."
  measures:
    - name: "total_stays"
      expr: COUNT(1)
      comment: "Total number of guest stays. Baseline volume KPI for occupancy and demand analysis."
    - name: "total_room_revenue"
      expr: SUM(CAST(room_revenue AS DOUBLE))
      comment: "Total room revenue generated across all stays. Primary revenue KPI for property and segment performance."
    - name: "total_ancillary_revenue"
      expr: SUM(CAST(ancillary_revenue AS DOUBLE))
      comment: "Total ancillary (non-room) revenue per stay. Measures success of upsell and ancillary programs."
    - name: "total_fb_revenue"
      expr: SUM(CAST(fb_revenue AS DOUBLE))
      comment: "Total food and beverage revenue attributed to guest stays. Tracks F&B attachment performance."
    - name: "total_folio_revenue"
      expr: SUM(CAST(total_folio_amount AS DOUBLE))
      comment: "Total folio amount across all stays including room, F&B, and ancillary. Comprehensive revenue KPI."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across stays. Required for financial reporting and compliance."
    - name: "average_daily_rate"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average daily rate across stays. Core revenue management KPI — NOT RevPAR (per VREQ-020)."
    - name: "average_total_folio_per_stay"
      expr: AVG(CAST(total_folio_amount AS DOUBLE))
      comment: "Average total spend per stay including all charges. Measures overall guest value per visit."
    - name: "average_room_revenue_per_stay"
      expr: AVG(CAST(room_revenue AS DOUBLE))
      comment: "Average room revenue per stay. Used to benchmark room revenue performance across segments and channels."
    - name: "average_ancillary_revenue_per_stay"
      expr: AVG(CAST(ancillary_revenue AS DOUBLE))
      comment: "Average ancillary revenue per stay. Tracks upsell effectiveness and ancillary program ROI."
    - name: "average_gss_score"
      expr: AVG(CAST(gss_score AS DOUBLE))
      comment: "Average Guest Satisfaction Score across stays. Key quality and experience KPI for operations leadership."
    - name: "average_feedback_sentiment"
      expr: AVG(CAST(feedback_topics_extracted AS DOUBLE))
      comment: "Average feedback sentiment/topic extraction score across stays. Tracks guest sentiment trends."
    - name: "service_recovery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN service_recovery_flag = TRUE THEN stay_history_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stays requiring service recovery. Operational quality KPI — high rates signal systemic issues."
    - name: "ancillary_attachment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ancillary_revenue > 0 THEN stay_history_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stays with ancillary revenue attached. Measures upsell program penetration."
    - name: "fb_attachment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fb_revenue > 0 THEN stay_history_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stays with F&B revenue. Tracks F&B outlet utilization by in-house guests."
    - name: "complimentary_stay_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN complimentary_flag = TRUE THEN stay_history_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stays that were complimentary. Tracks comp room cost and loyalty/VIP program expense."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_lifetime_value`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest lifetime value and predictive scoring metrics. Tracks LTV distribution, churn risk, upsell propensity, and projected revenue. Used by CRM, loyalty, and revenue leadership for guest investment prioritization and retention strategy."
  source: "`vibe_travel_hospitality_v1`.`guest`.`lifetime_value`"
  dimensions:
    - name: "ltv_tier"
      expr: ltv_tier
      comment: "LTV tier classification (e.g. platinum, gold, silver) for value-based segmentation."
    - name: "loyalty_tier_code"
      expr: loyalty_tier_code
      comment: "Current loyalty tier for cross-referencing LTV with loyalty status."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment for LTV analysis by guest type."
    - name: "churn_risk_flag"
      expr: churn_risk_flag
      comment: "Boolean flag indicating guests at risk of churning. Used to prioritize retention campaigns."
    - name: "preferred_brand_code"
      expr: preferred_brand_code
      comment: "Preferred brand for brand-level LTV analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which LTV is denominated for multi-currency portfolio analysis."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate LTV (e.g. historical, predictive) for model governance."
    - name: "calculation_year"
      expr: YEAR(calculation_date)
      comment: "Year of LTV calculation for trend analysis."
  measures:
    - name: "total_guests_scored"
      expr: COUNT(1)
      comment: "Total number of guest profiles with an LTV score. Measures model coverage."
    - name: "total_lifetime_revenue"
      expr: SUM(CAST(total_revenue AS DOUBLE))
      comment: "Sum of total lifetime revenue across all scored guests. Portfolio-level revenue KPI."
    - name: "total_room_revenue_lifetime"
      expr: SUM(CAST(total_room_revenue AS DOUBLE))
      comment: "Total lifetime room revenue across all guests. Core revenue contribution KPI."
    - name: "total_ancillary_revenue_lifetime"
      expr: SUM(CAST(total_ancillary_revenue AS DOUBLE))
      comment: "Total lifetime ancillary revenue. Measures long-term ancillary program value."
    - name: "total_projected_12m_revenue"
      expr: SUM(CAST(projected_12m_revenue AS DOUBLE))
      comment: "Total projected 12-month revenue across all guests. Forward-looking revenue pipeline KPI."
    - name: "average_ltv_score"
      expr: AVG(CAST(ltv_score AS DOUBLE))
      comment: "Average LTV score across the guest portfolio. Tracks overall portfolio value health."
    - name: "average_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score. Elevated scores trigger retention investment decisions."
    - name: "average_upsell_propensity_score"
      expr: AVG(CAST(upsell_propensity_score AS DOUBLE))
      comment: "Average upsell propensity score. Guides targeting for upgrade and ancillary offers."
    - name: "average_next_stay_propensity_score"
      expr: AVG(CAST(next_stay_propensity_score AS DOUBLE))
      comment: "Average next-stay propensity score. Predicts near-term demand from existing guests."
    - name: "churn_risk_guest_count"
      expr: COUNT(CASE WHEN churn_risk_flag = TRUE THEN lifetime_value_id END)
      comment: "Number of guests flagged as churn risk. Sizes the at-risk population for retention campaign planning."
    - name: "churn_risk_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN churn_risk_flag = TRUE THEN lifetime_value_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of scored guests at churn risk. Strategic KPI for loyalty and CRM leadership."
    - name: "average_revenue_per_stay"
      expr: AVG(CAST(average_revenue_per_stay AS DOUBLE))
      comment: "Average revenue per stay across the guest portfolio. Benchmarks guest spending intensity."
    - name: "average_adr"
      expr: AVG(CAST(average_daily_rate AS DOUBLE))
      comment: "Average ADR across the guest portfolio. Tracks rate quality of the guest base."
    - name: "average_length_of_stay"
      expr: AVG(CAST(average_length_of_stay AS DOUBLE))
      comment: "Average length of stay across the guest portfolio. Informs inventory and revenue strategy."
    - name: "average_nps_score"
      expr: AVG(CAST(average_nps_score AS DOUBLE))
      comment: "Average NPS score across the guest portfolio. Tracks overall guest satisfaction at portfolio level."
    - name: "average_gss_score"
      expr: AVG(CAST(average_gss_score AS DOUBLE))
      comment: "Average GSS score across the guest portfolio. Operational quality KPI for experience leadership."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_corporate_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corporate account performance metrics tracking revenue targets, credit utilization, discount levels, and account health. Used by sales, account management, and revenue leadership to manage corporate business."
  source: "`vibe_travel_hospitality_v1`.`guest`.`corporate_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Status of the corporate account (active, inactive, prospect) for portfolio health analysis."
    - name: "account_type"
      expr: account_type
      comment: "Type of corporate account (e.g. transient, MICE, group) for segment analysis."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment assigned to the account for revenue contribution analysis."
    - name: "rate_program_type"
      expr: rate_program_type
      comment: "Rate program type (e.g. LRA, negotiated) for pricing strategy analysis."
    - name: "loyalty_program_eligible"
      expr: loyalty_program_eligible
      comment: "Whether the account is eligible for loyalty program benefits."
    - name: "mice_eligible"
      expr: mice_eligible
      comment: "Whether the account is eligible for MICE (meetings, incentives, conferences, exhibitions) business."
    - name: "direct_billing_enabled"
      expr: direct_billing_enabled
      comment: "Whether direct billing is enabled for the account, affecting cash flow and AR management."
    - name: "vip_tier"
      expr: vip_tier
      comment: "VIP tier of the corporate account for high-value account segmentation."
    - name: "contract_start_year"
      expr: YEAR(contract_start_date)
      comment: "Year the contract started for contract vintage analysis."
  measures:
    - name: "total_corporate_accounts"
      expr: COUNT(1)
      comment: "Total number of corporate accounts. Baseline KPI for corporate portfolio size."
    - name: "active_corporate_accounts"
      expr: COUNT(CASE WHEN account_status = 'ACTIVE' THEN corporate_account_id END)
      comment: "Number of active corporate accounts. Tracks productive corporate portfolio size."
    - name: "total_annual_revenue_target"
      expr: SUM(CAST(annual_revenue_target AS DOUBLE))
      comment: "Sum of annual revenue targets across all corporate accounts. Total corporate revenue pipeline."
    - name: "average_annual_revenue_target"
      expr: AVG(CAST(annual_revenue_target AS DOUBLE))
      comment: "Average annual revenue target per corporate account. Benchmarks account value expectations."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit extended to corporate accounts. Tracks AR credit risk exposure."
    - name: "average_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage across corporate accounts. Tracks rate integrity and negotiation outcomes."
    - name: "direct_billing_account_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN direct_billing_enabled = TRUE THEN corporate_account_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corporate accounts with direct billing enabled. Tracks AR complexity and cash flow risk."
    - name: "loyalty_eligible_account_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN loyalty_program_eligible = TRUE THEN corporate_account_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corporate accounts eligible for loyalty benefits. Measures loyalty program corporate penetration."
    - name: "mice_eligible_account_count"
      expr: COUNT(CASE WHEN mice_eligible = TRUE THEN corporate_account_id END)
      comment: "Number of MICE-eligible corporate accounts. Sizes the MICE business development pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_communication_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent management metrics tracking opt-in rates, consent health, GDPR compliance posture, and suppression list size. Critical for marketing compliance, privacy officers, and campaign planning."
  source: "`vibe_travel_hospitality_v1`.`guest`.`communication_consent`"
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent (e.g. marketing, transactional, profiling) for consent category analysis."
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent record (granted, withdrawn, expired) for compliance reporting."
    - name: "consent_method"
      expr: consent_method
      comment: "Method by which consent was captured (e.g. web form, in-person) for channel quality analysis."
    - name: "consent_purpose"
      expr: consent_purpose
      comment: "Purpose for which consent was granted for GDPR lawful basis tracking."
    - name: "legal_basis"
      expr: legal_basis
      comment: "Legal basis for processing (e.g. consent, legitimate interest) for regulatory compliance."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Regulatory jurisdiction (e.g. GDPR, CCPA) for jurisdiction-specific compliance reporting."
    - name: "consent_source"
      expr: consent_source
      comment: "Source system or channel where consent was captured."
    - name: "consent_granted_year"
      expr: YEAR(consent_granted_date)
      comment: "Year consent was granted for consent vintage and renewal analysis."
    - name: "double_opt_in_flag"
      expr: double_opt_in_flag
      comment: "Whether double opt-in was confirmed, indicating higher-quality consent."
  measures:
    - name: "total_consent_records"
      expr: COUNT(1)
      comment: "Total consent records. Baseline for consent database coverage analysis."
    - name: "active_consents"
      expr: COUNT(CASE WHEN consent_status = 'GRANTED' THEN communication_consent_id END)
      comment: "Number of currently active (granted) consents. Determines addressable marketing audience."
    - name: "withdrawn_consents"
      expr: COUNT(CASE WHEN consent_status = 'WITHDRAWN' THEN communication_consent_id END)
      comment: "Number of withdrawn consents. Tracks opt-out volume and compliance risk."
    - name: "consent_grant_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_status = 'GRANTED' THEN communication_consent_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records in granted status. Key compliance and marketing reach KPI."
    - name: "double_opt_in_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN double_opt_in_flag = TRUE THEN communication_consent_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consents confirmed via double opt-in. Higher rates indicate stronger consent quality."
    - name: "suppression_list_count"
      expr: COUNT(CASE WHEN suppression_list_flag = TRUE THEN communication_consent_id END)
      comment: "Number of guests on suppression lists. Tracks do-not-contact compliance and deliverability risk."
    - name: "profiling_consent_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN profiling_consent_flag = TRUE THEN communication_consent_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of guests consenting to profiling. Determines eligibility for AI/ML personalization."
    - name: "third_party_sharing_consent_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN third_party_sharing_consent_flag = TRUE THEN communication_consent_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of guests consenting to third-party data sharing. Governs partner data sharing eligibility."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_privacy_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Privacy request compliance metrics tracking request volumes, response timeliness, completion rates, and legal hold exposure. Used by privacy officers, legal, and compliance leadership for GDPR/CCPA regulatory reporting."
  source: "`vibe_travel_hospitality_v1`.`guest`.`privacy_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of privacy request (e.g. erasure, access, rectification) for regulatory category analysis."
    - name: "request_status"
      expr: request_status
      comment: "Current status of the request (open, completed, rejected) for SLA monitoring."
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction (GDPR, CCPA, etc.) for jurisdiction-specific compliance reporting."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the request was submitted for intake process analysis."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the request (fulfilled, rejected, partially fulfilled) for compliance quality analysis."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Whether the request is under legal hold, indicating elevated legal risk."
    - name: "extension_granted_flag"
      expr: extension_granted_flag
      comment: "Whether a response deadline extension was granted, indicating processing complexity."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year of submission for trend and regulatory reporting."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of submission for monthly compliance volume reporting."
  measures:
    - name: "total_privacy_requests"
      expr: COUNT(1)
      comment: "Total privacy requests received. Baseline compliance volume KPI for regulatory reporting."
    - name: "open_privacy_requests"
      expr: COUNT(CASE WHEN request_status = 'OPEN' THEN privacy_request_id END)
      comment: "Number of open (unresolved) privacy requests. Tracks compliance backlog and SLA risk."
    - name: "completed_privacy_requests"
      expr: COUNT(CASE WHEN request_status = 'COMPLETED' THEN privacy_request_id END)
      comment: "Number of completed privacy requests. Measures compliance team throughput."
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN request_status = 'COMPLETED' THEN privacy_request_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of privacy requests completed. Core regulatory compliance KPI."
    - name: "legal_hold_request_count"
      expr: COUNT(CASE WHEN legal_hold_flag = TRUE THEN privacy_request_id END)
      comment: "Number of requests under legal hold. Tracks legal risk exposure from privacy litigation."
    - name: "extension_granted_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN extension_granted_flag = TRUE THEN privacy_request_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requests requiring a deadline extension. High rates signal processing capacity issues."
    - name: "third_party_notification_required_count"
      expr: COUNT(CASE WHEN third_party_notification_required = TRUE THEN privacy_request_id END)
      comment: "Number of requests requiring third-party notification. Tracks downstream data processor compliance obligations."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_vip_designation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "VIP guest designation metrics tracking active VIP population, designation scope, revenue thresholds, and special service requirements. Used by guest relations, operations, and revenue leadership to manage high-value guest programs."
  source: "`vibe_travel_hospitality_v1`.`guest`.`vip_designation`"
  dimensions:
    - name: "vip_level"
      expr: vip_level
      comment: "VIP level classification for tiered high-value guest analysis."
    - name: "designation_status"
      expr: designation_status
      comment: "Current status of the VIP designation (active, expired, revoked) for active VIP population tracking."
    - name: "designation_scope"
      expr: designation_scope
      comment: "Scope of the designation (property-level, brand-wide, global) for service planning."
    - name: "designation_reason"
      expr: designation_reason
      comment: "Reason for VIP designation (loyalty, revenue, celebrity, etc.) for program composition analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property where the VIP designation is active for property-level VIP management."
    - name: "amenity_tier_code"
      expr: amenity_tier_code
      comment: "Amenity tier assigned to the VIP for service cost and fulfillment planning."
    - name: "upgrade_eligible"
      expr: upgrade_eligible
      comment: "Whether the VIP guest is eligible for room upgrades."
    - name: "effective_from_year"
      expr: YEAR(effective_from)
      comment: "Year the VIP designation became effective for cohort analysis."
  measures:
    - name: "total_vip_designations"
      expr: COUNT(1)
      comment: "Total VIP designations across all statuses. Baseline for VIP program scale."
    - name: "active_vip_designations"
      expr: COUNT(CASE WHEN designation_status = 'ACTIVE' THEN vip_designation_id END)
      comment: "Number of currently active VIP designations. Sizes active VIP service obligations."
    - name: "total_revenue_threshold"
      expr: SUM(CAST(revenue_threshold_amount AS DOUBLE))
      comment: "Sum of revenue thresholds across VIP designations. Tracks minimum revenue commitment from VIP program."
    - name: "average_revenue_threshold"
      expr: AVG(CAST(revenue_threshold_amount AS DOUBLE))
      comment: "Average revenue threshold for VIP designation. Benchmarks the revenue bar for VIP qualification."
    - name: "gm_greeting_required_count"
      expr: COUNT(CASE WHEN gm_greeting_required = TRUE THEN vip_designation_id END)
      comment: "Number of active VIPs requiring GM greeting. Quantifies GM time commitment for VIP service."
    - name: "security_escort_required_count"
      expr: COUNT(CASE WHEN security_escort_required = TRUE THEN vip_designation_id END)
      comment: "Number of VIPs requiring security escort. Drives security staffing and resource planning."
    - name: "upgrade_eligible_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN upgrade_eligible = TRUE THEN vip_designation_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of VIP designations eligible for room upgrades. Informs inventory upgrade allocation strategy."
    - name: "media_blackout_count"
      expr: COUNT(CASE WHEN media_blackout = TRUE THEN vip_designation_id END)
      comment: "Number of VIPs with media blackout requirements. Tracks privacy-sensitive guest handling obligations."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest segmentation metrics tracking segment composition, revenue contribution, loyalty eligibility, and yield management flags. Used by revenue management, marketing, and CRM leadership for segment strategy and targeting."
  source: "`vibe_travel_hospitality_v1`.`guest`.`segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Type of segment (behavioral, demographic, value-based) for segmentation strategy analysis."
    - name: "segment_category"
      expr: segment_category
      comment: "Category of the segment for hierarchical segment reporting."
    - name: "segment_status"
      expr: segment_status
      comment: "Active/inactive status of the segment assignment."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign the guest to the segment (rules-based, ML, manual) for model governance."
    - name: "rate_strategy_type"
      expr: rate_strategy_type
      comment: "Rate strategy associated with the segment for revenue management alignment."
    - name: "yield_management_flag"
      expr: yield_management_flag
      comment: "Whether the segment is subject to yield management controls."
    - name: "loyalty_points_eligible"
      expr: loyalty_points_eligible
      comment: "Whether guests in this segment earn loyalty points."
    - name: "commission_eligible"
      expr: commission_eligible
      comment: "Whether the segment is eligible for commission payments to travel agents."
    - name: "assignment_year"
      expr: YEAR(assignment_date)
      comment: "Year of segment assignment for cohort and trend analysis."
  measures:
    - name: "total_segment_assignments"
      expr: COUNT(1)
      comment: "Total guest-segment assignments. Baseline for segment population sizing."
    - name: "active_segment_assignments"
      expr: COUNT(CASE WHEN segment_status = 'ACTIVE' THEN segment_id END)
      comment: "Number of active segment assignments. Tracks current segment population for targeting."
    - name: "average_assignment_confidence_score"
      expr: AVG(CAST(assignment_confidence_score AS DOUBLE))
      comment: "Average confidence score of segment assignments. Tracks ML model quality for segment classification."
    - name: "average_revpar_contribution_pct"
      expr: AVG(CAST(revpar_contribution_pct AS DOUBLE))
      comment: "Average RevPAR contribution percentage by segment. Identifies highest-value segments for revenue strategy."
    - name: "average_ancillary_revenue_per_stay"
      expr: AVG(CAST(ancillary_revenue_per_stay AS DOUBLE))
      comment: "Average ancillary revenue per stay for the segment. Measures segment-level ancillary value."
    - name: "average_los_days"
      expr: AVG(CAST(average_los_days AS DOUBLE))
      comment: "Average length of stay for the segment. Informs inventory and rate strategy by segment."
    - name: "average_adr_index_vs_property"
      expr: AVG(CAST(adr_index_vs_property AS DOUBLE))
      comment: "Average ADR index versus property average for the segment. Measures segment rate premium or discount."
    - name: "average_loyalty_points_multiplier"
      expr: AVG(CAST(loyalty_points_multiplier AS DOUBLE))
      comment: "Average loyalty points multiplier for the segment. Tracks loyalty cost per segment."
    - name: "average_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate for commission-eligible segments. Tracks distribution cost by segment."
    - name: "average_fb_attachment_rate_pct"
      expr: AVG(CAST(fb_attachment_rate_pct AS DOUBLE))
      comment: "Average F&B attachment rate for the segment. Identifies segments with high F&B revenue potential."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_profile_merge_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Profile deduplication and merge quality metrics tracking merge volumes, confidence scores, data migration completeness, and rollback eligibility. Used by CRM data quality teams and privacy officers to govern guest master data."
  source: "`vibe_travel_hospitality_v1`.`guest`.`profile_merge_history`"
  dimensions:
    - name: "merge_status"
      expr: merge_status
      comment: "Status of the merge operation (completed, failed, rolled back) for data quality monitoring."
    - name: "merge_method"
      expr: merge_method
      comment: "Method used for the merge (automated, manual, rule-based) for process quality analysis."
    - name: "merge_reason"
      expr: merge_reason
      comment: "Reason for the merge (duplicate detection, guest request, etc.) for root cause analysis."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation outcome of the merge for data quality governance."
    - name: "rollback_eligible_flag"
      expr: rollback_eligible_flag
      comment: "Whether the merge can be rolled back, indicating reversibility risk."
    - name: "gdpr_consent_retained"
      expr: gdpr_consent_retained
      comment: "Whether GDPR consent was retained through the merge, critical for compliance."
    - name: "merge_year"
      expr: YEAR(merge_timestamp)
      comment: "Year of the merge for trend and volume analysis."
    - name: "merge_month"
      expr: DATE_TRUNC('MONTH', merge_timestamp)
      comment: "Month of the merge for operational throughput reporting."
  measures:
    - name: "total_merges"
      expr: COUNT(1)
      comment: "Total profile merges performed. Baseline for deduplication program volume."
    - name: "successful_merges"
      expr: COUNT(CASE WHEN merge_status = 'COMPLETED' THEN profile_merge_history_id END)
      comment: "Number of successfully completed merges. Tracks deduplication program effectiveness."
    - name: "merge_success_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN merge_status = 'COMPLETED' THEN profile_merge_history_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of merges completed successfully. Key data quality KPI for CRM governance."
    - name: "average_matching_confidence_score"
      expr: AVG(CAST(matching_confidence_score AS DOUBLE))
      comment: "Average confidence score of merge matching. Tracks algorithmic accuracy of deduplication."
    - name: "total_loyalty_points_transferred"
      expr: SUM(CAST(loyalty_points_transferred AS DOUBLE))
      comment: "Total loyalty points transferred through merges. Tracks loyalty liability impact of deduplication."
    - name: "gdpr_consent_retention_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gdpr_consent_retained = TRUE THEN profile_merge_history_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of merges where GDPR consent was retained. Critical compliance KPI for privacy officers."
    - name: "rollback_eligible_merge_count"
      expr: COUNT(CASE WHEN rollback_eligible_flag = TRUE THEN profile_merge_history_id END)
      comment: "Number of merges still eligible for rollback. Tracks reversibility window for data correction."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_group_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group block performance metrics tracking contracted vs. picked-up rooms, attrition risk, deposit compliance, and group revenue. Used by group sales, revenue management, and operations leadership."
  source: "`vibe_travel_hospitality_v1`.`guest`.`guest_group_block`"
  dimensions:
    - name: "block_status"
      expr: block_status
      comment: "Current status of the group block (tentative, definite, cancelled) for pipeline analysis."
    - name: "group_type"
      expr: group_type
      comment: "Type of group (corporate, association, leisure, SMERF) for segment analysis."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment of the group for revenue contribution analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property hosting the group block for property-level group performance."
    - name: "source_of_business_code"
      expr: source_of_business_code
      comment: "Source of business for the group (direct, travel agent, OTA) for channel analysis."
    - name: "rooming_list_status"
      expr: rooming_list_status
      comment: "Status of the rooming list submission for operational readiness tracking."
    - name: "vip_flag"
      expr: vip_flag
      comment: "Whether the group has VIP designation requiring elevated service."
    - name: "arrival_month"
      expr: DATE_TRUNC('MONTH', arrival_date)
      comment: "Month of group arrival for demand forecasting and capacity planning."
    - name: "repeat_group_flag"
      expr: repeat_group_flag
      comment: "Whether this is a repeat group, indicating loyalty and retention value."
  measures:
    - name: "total_group_blocks"
      expr: COUNT(1)
      comment: "Total group blocks. Baseline for group business pipeline volume."
    - name: "total_contracted_rate_revenue"
      expr: SUM(CAST(contracted_rate_amount AS DOUBLE))
      comment: "Total contracted rate revenue across all group blocks. Group revenue pipeline KPI."
    - name: "average_contracted_rate"
      expr: AVG(CAST(contracted_rate_amount AS DOUBLE))
      comment: "Average contracted rate per group block. Benchmarks group rate negotiation outcomes."
    - name: "total_deposit_required"
      expr: SUM(CAST(deposit_required_amount AS DOUBLE))
      comment: "Total deposit required across group blocks. Tracks cash flow obligations from group business."
    - name: "total_deposit_received"
      expr: SUM(CAST(deposit_received_amount AS DOUBLE))
      comment: "Total deposit received from group blocks. Tracks deposit collection compliance."
    - name: "deposit_collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(deposit_received_amount AS DOUBLE)) / NULLIF(SUM(CAST(deposit_required_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of required deposits collected. Tracks group deposit compliance and cash flow risk."
    - name: "average_attrition_pct"
      expr: AVG(CAST(attrition_pct AS DOUBLE))
      comment: "Average attrition percentage across group blocks. Measures group pickup risk and revenue exposure."
    - name: "average_wash_pct"
      expr: AVG(CAST(wash_pct AS DOUBLE))
      comment: "Average wash percentage applied to group blocks. Tracks inventory release efficiency."
    - name: "repeat_group_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN repeat_group_flag = TRUE THEN guest_group_block_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of group blocks from repeat groups. Measures group loyalty and retention."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`guest_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level guest metrics tracking lifetime revenue, loyalty tier distribution, and household composition. Used by CRM and loyalty leadership for household-based targeting and relationship management."
  source: "`vibe_travel_hospitality_v1`.`guest`.`household`"
  dimensions:
    - name: "household_status"
      expr: household_status
      comment: "Status of the household record (active, merged, inactive) for data quality analysis."
    - name: "household_type"
      expr: household_type
      comment: "Type of household (family, couple, individual) for demographic segmentation."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Loyalty tier of the household for value-based segmentation."
    - name: "country_code"
      expr: country_code
      comment: "Country of the household for geographic analysis."
    - name: "preferred_currency"
      expr: preferred_currency
      comment: "Preferred currency of the household for financial reporting."
    - name: "vip_flag"
      expr: vip_flag
      comment: "Whether the household has VIP status for high-value household tracking."
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Whether the household is opted in to marketing for addressable audience sizing."
  measures:
    - name: "total_households"
      expr: COUNT(1)
      comment: "Total household records. Baseline for household-level CRM database size."
    - name: "total_lifetime_revenue"
      expr: SUM(CAST(lifetime_revenue AS DOUBLE))
      comment: "Total lifetime revenue across all households. Portfolio-level household value KPI."
    - name: "average_lifetime_revenue"
      expr: AVG(CAST(lifetime_revenue AS DOUBLE))
      comment: "Average lifetime revenue per household. Benchmarks household value for investment prioritization."
    - name: "average_adr"
      expr: AVG(CAST(average_daily_rate AS DOUBLE))
      comment: "Average daily rate across households. Tracks rate quality of the household portfolio."
    - name: "vip_household_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN vip_flag = TRUE THEN household_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of households with VIP status. Tracks VIP program household penetration."
    - name: "marketing_opt_in_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN marketing_opt_in = TRUE THEN household_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of households opted in to marketing. Determines household-level addressable marketing audience."
$$;