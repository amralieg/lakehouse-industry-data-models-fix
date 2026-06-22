-- Metric views for domain: guest | Business: Restaurants | Version: 2 | Generated on: 2026-06-22 17:03:36

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core guest profile KPIs measuring guest base size, lifetime value, engagement depth, and loyalty penetration. Used by CRM, Marketing, and Guest Experience leadership to steer acquisition, retention, and loyalty investment decisions."
  source: "`vibe_restaurants_v1`.`guest`.`profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the guest profile (e.g. active, inactive, merged) — used to segment active vs. churned guest base."
    - name: "guest_type"
      expr: guest_type
      comment: "Classification of the guest (e.g. loyalty member, anonymous, corporate) — drives segmentation for targeted campaigns."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Loyalty program tier of the guest — key dimension for tier-based value analysis and upgrade targeting."
    - name: "gender"
      expr: gender
      comment: "Guest gender identity — used for demographic segmentation in marketing and product decisions."
    - name: "country_code"
      expr: country_code
      comment: "Country of the guest — enables geographic segmentation for regional performance analysis."
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Whether the guest has opted into marketing communications — critical for reachable audience sizing."
    - name: "preferred_language"
      expr: preferred_language
      comment: "Guest preferred language — used for localization and communication strategy decisions."
    - name: "data_source"
      expr: data_source
      comment: "Origin system of the guest profile record — used for data quality and channel attribution analysis."
    - name: "profile_created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the guest profile was created — enables cohort-based acquisition trend analysis."
    - name: "last_visit_month"
      expr: DATE_TRUNC('month', last_visit_timestamp)
      comment: "Month of the guest's most recent visit — used to identify recency cohorts and at-risk guests."
  measures:
    - name: "total_active_guests"
      expr: COUNT(CASE WHEN profile_status = 'active' THEN profile_id END)
      comment: "Count of active guest profiles. Baseline KPI for total addressable guest base size — used in executive dashboards and market penetration analysis."
    - name: "total_lifetime_spend"
      expr: SUM(CAST(total_spent AS DOUBLE))
      comment: "Sum of total lifetime spend across all guest profiles. Primary revenue-linkage KPI for understanding cumulative guest value and prioritizing high-value segments."
    - name: "avg_lifetime_spend_per_guest"
      expr: AVG(CAST(total_spent AS DOUBLE))
      comment: "Average lifetime spend per guest profile. Measures guest monetization depth — a key input for LTV modeling and loyalty investment ROI decisions."
    - name: "avg_check_value"
      expr: AVG(CAST(average_check_value AS DOUBLE))
      comment: "Average check value across guest profiles. Indicates typical transaction size per guest — used to benchmark upsell and menu engineering effectiveness."
    - name: "total_lifetime_visits"
      expr: SUM(CAST(total_lifetime_visits AS DOUBLE))
      comment: "Sum of total lifetime visits across all guest profiles. Measures overall guest engagement volume — a leading indicator of brand loyalty and frequency."
    - name: "avg_lifetime_visits_per_guest"
      expr: AVG(CAST(total_lifetime_visits AS DOUBLE))
      comment: "Average number of lifetime visits per guest. Measures visit frequency depth — used to identify high-frequency loyalists vs. one-time visitors for retention strategy."
    - name: "marketing_reachable_guests"
      expr: COUNT(CASE WHEN marketing_opt_in = TRUE AND profile_status = 'active' THEN profile_id END)
      comment: "Count of active guests who have opted into marketing. Defines the reachable audience for campaigns — directly drives marketing spend efficiency decisions."
    - name: "loyalty_enrolled_guests"
      expr: COUNT(CASE WHEN loyalty_tier IS NOT NULL AND profile_status = 'active' THEN profile_id END)
      comment: "Count of active guests enrolled in a loyalty tier. Measures loyalty program penetration — a strategic KPI for loyalty investment and program growth decisions."
    - name: "email_consent_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_email = TRUE THEN profile_id END) / NULLIF(COUNT(profile_id), 0), 2)
      comment: "Percentage of guest profiles with email consent. Measures CRM reachability via email — a compliance and campaign effectiveness KPI."
    - name: "sms_consent_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_sms = TRUE THEN profile_id END) / NULLIF(COUNT(profile_id), 0), 2)
      comment: "Percentage of guest profiles with SMS consent. Measures mobile marketing reachability — used to size SMS campaign audiences and assess consent health."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest visit transaction KPIs measuring visit volume, spend, frequency, and satisfaction. The primary operational and revenue fact for guest experience and restaurant performance management."
  source: "`vibe_restaurants_v1`.`guest`.`visit`"
  dimensions:
    - name: "visit_date"
      expr: visit_date
      comment: "Date of the guest visit — primary time dimension for daily and weekly operational reporting."
    - name: "visit_month"
      expr: DATE_TRUNC('month', visit_timestamp)
      comment: "Month of the guest visit — used for monthly trend analysis and period-over-period comparisons."
    - name: "visit_type"
      expr: visit_type
      comment: "Type of visit (e.g. dine-in, takeout, delivery) — key dimension for channel mix and operational capacity analysis."
    - name: "channel"
      expr: channel
      comment: "Order channel associated with the visit (e.g. in-store, app, web) — used for channel performance and digital adoption tracking."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the visit (e.g. breakfast, lunch, dinner) — critical for labor scheduling, menu performance, and promotional timing decisions."
    - name: "is_first_visit"
      expr: is_first_visit
      comment: "Flag indicating whether this was the guest's first visit — used to separate new guest acquisition from repeat visit metrics."
    - name: "is_repeat_visit"
      expr: is_repeat_visit
      comment: "Flag indicating whether this was a repeat visit — used to measure retention and loyalty program effectiveness."
  measures:
    - name: "total_visits"
      expr: COUNT(1)
      comment: "Total number of guest visits. Baseline traffic KPI — used by operations and finance to track footfall trends and capacity utilization."
    - name: "unique_guests_visited"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of distinct guests who visited. Measures unique guest reach — differentiates traffic volume from guest breadth for retention analysis."
    - name: "total_visit_spend"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total spend amount across all visits. Primary revenue KPI for guest visit transactions — used in P&L and revenue forecasting."
    - name: "avg_spend_per_visit"
      expr: AVG(CAST(spend_amount AS DOUBLE))
      comment: "Average spend per visit. Measures check average — a key metric for menu engineering, upsell effectiveness, and pricing strategy."
    - name: "total_check_amount"
      expr: SUM(CAST(check_amount AS DOUBLE))
      comment: "Total check amount across all visits. Complements spend_amount for reconciliation and revenue integrity reporting."
    - name: "avg_check_amount"
      expr: AVG(CAST(check_amount AS DOUBLE))
      comment: "Average check amount per visit. Used alongside avg_spend_per_visit to validate revenue per cover and benchmark against targets."
    - name: "avg_satisfaction_score"
      expr: AVG(CAST(satisfaction_score AS DOUBLE))
      comment: "Average guest satisfaction score per visit. Directly measures guest experience quality — a leading indicator of retention and NPS outcomes."
    - name: "new_guest_visits"
      expr: COUNT(CASE WHEN is_first_visit = TRUE THEN visit_id END)
      comment: "Count of first-time guest visits. Measures new guest acquisition through the door — a strategic KPI for marketing and growth investment decisions."
    - name: "repeat_visit_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_repeat_visit = TRUE THEN visit_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visits that are repeat visits. Measures guest retention and loyalty — a core KPI for loyalty program ROI and retention strategy."
    - name: "total_ticket_amount"
      expr: SUM(CAST(ticket_amount AS DOUBLE))
      comment: "Total ticket amount across all visits. Used for revenue reconciliation against POS ticket data — supports financial close and audit processes."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest complaint and resolution KPIs measuring complaint volume, severity, resolution effectiveness, and guest satisfaction impact. Used by Operations, Quality, and Guest Experience leadership to manage brand risk and service recovery."
  source: "`vibe_restaurants_v1`.`guest`.`complaint`"
  dimensions:
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current status of the complaint (e.g. open, resolved, escalated) — used to track resolution pipeline and backlog."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the complaint — used to prioritize response resources and escalation decisions."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution outcome status — used to measure service recovery effectiveness and identify unresolved complaint patterns."
    - name: "resolution_type"
      expr: resolution_type
      comment: "Type of resolution applied (e.g. refund, replacement, apology) — used to analyze resolution cost and effectiveness by type."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the complaint was escalated — used to measure escalation rate and identify systemic service failures."
    - name: "complaint_month"
      expr: DATE_TRUNC('month', complaint_timestamp)
      comment: "Month the complaint was filed — used for trend analysis and seasonal complaint pattern identification."
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total number of guest complaints filed. Baseline quality KPI — used to track complaint volume trends and benchmark against service standards."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN complaint_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of complaints that were escalated. Measures severity of service failures — a leading indicator of brand risk and operational breakdown."
    - name: "resolution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN resolution_status = 'resolved' THEN complaint_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of complaints that have been resolved. Measures service recovery effectiveness — a key KPI for guest experience and operations leadership."
    - name: "avg_csat_score"
      expr: AVG(CAST(csat_score AS DOUBLE))
      comment: "Average customer satisfaction score from complaint records. Measures post-complaint satisfaction — used to evaluate service recovery quality and its impact on guest retention."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score from complaint records. Measures likelihood to recommend after a complaint — a strategic KPI for brand health and loyalty impact assessment."
    - name: "total_resolution_amount"
      expr: SUM(CAST(resolution_amount AS DOUBLE))
      comment: "Total monetary value of complaint resolutions (refunds, vouchers, etc.). Measures the financial cost of service recovery — used in P&L and quality cost analysis."
    - name: "avg_resolution_amount"
      expr: AVG(CAST(resolution_amount AS DOUBLE))
      comment: "Average resolution amount per complaint. Benchmarks service recovery cost per incident — used to optimize resolution policies and control recovery spend."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_satisfaction_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest satisfaction survey KPIs measuring NPS, CSAT, and survey response patterns. Used by Guest Experience, Marketing, and Operations leadership to track brand perception and drive service improvement investments."
  source: "`vibe_restaurants_v1`.`guest`.`satisfaction_survey`"
  dimensions:
    - name: "survey_type"
      expr: survey_type
      comment: "Type of satisfaction survey (e.g. post-visit, delivery, app) — used to segment satisfaction scores by survey context."
    - name: "satisfaction_survey_status"
      expr: satisfaction_survey_status
      comment: "Current status of the survey record — used to filter for completed vs. pending surveys in reporting."
    - name: "completion_status"
      expr: completion_status
      comment: "Whether the survey was fully completed — used to measure response quality and completion rate."
    - name: "daypart"
      expr: daypart
      comment: "Daypart during which the surveyed visit occurred — used to identify satisfaction patterns by time of day."
    - name: "language"
      expr: language
      comment: "Language in which the survey was completed — used for localization quality analysis and multilingual guest experience tracking."
    - name: "survey_month"
      expr: DATE_TRUNC('month', response_timestamp)
      comment: "Month the survey response was submitted — primary time dimension for satisfaction trend analysis."
    - name: "consent_given"
      expr: consent_given
      comment: "Whether the guest gave consent for survey data use — used for compliance filtering in marketing and analytics use cases."
  measures:
    - name: "total_survey_responses"
      expr: COUNT(1)
      comment: "Total number of survey responses received. Baseline KPI for survey program reach — used to assess feedback volume and statistical significance of satisfaction scores."
    - name: "survey_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN completion_status = 'completed' THEN satisfaction_survey_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of surveys that were fully completed. Measures survey program effectiveness — low completion rates signal survey design or delivery issues."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score across all survey responses. The primary brand loyalty and advocacy KPI — used in executive dashboards and quarterly business reviews."
    - name: "avg_csat_score"
      expr: AVG(CAST(csat_score AS DOUBLE))
      comment: "Average Customer Satisfaction Score across all survey responses. Measures overall guest experience quality — a direct input to service improvement prioritization."
    - name: "promoter_count"
      expr: COUNT(CASE WHEN nps_score >= 9 THEN satisfaction_survey_id END)
      comment: "Count of survey responses with NPS score of 9 or 10 (promoters). Used to size the brand advocate base and track promoter growth over time."
    - name: "detractor_count"
      expr: COUNT(CASE WHEN nps_score <= 6 THEN satisfaction_survey_id END)
      comment: "Count of survey responses with NPS score of 6 or below (detractors). Used to identify at-risk guests and prioritize service recovery interventions."
    - name: "net_promoter_score"
      expr: ROUND(100.0 * (COUNT(CASE WHEN nps_score >= 9 THEN satisfaction_survey_id END) - COUNT(CASE WHEN nps_score <= 6 THEN satisfaction_survey_id END)) / NULLIF(COUNT(1), 0), 2)
      comment: "Calculated Net Promoter Score as (promoters - detractors) / total responses * 100. The gold-standard brand health KPI used in board decks and investor reporting."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_loyalty_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level loyalty and spend KPIs measuring household value, loyalty enrollment, and transaction behavior. Used by Loyalty, CRM, and Marketing leadership to drive household-level targeting and loyalty program investment decisions."
  source: "`vibe_restaurants_v1`.`guest`.`household`"
  dimensions:
    - name: "household_status"
      expr: household_status
      comment: "Current status of the household record (e.g. active, dissolved) — used to filter active households for targeting and value analysis."
    - name: "household_type"
      expr: household_type
      comment: "Classification of the household (e.g. family, individual, corporate) — used for segment-level value and behavior analysis."
    - name: "segment"
      expr: segment
      comment: "Marketing or value segment assigned to the household — primary dimension for targeted campaign planning and loyalty tier management."
    - name: "loyalty_enrolled"
      expr: loyalty_enrolled
      comment: "Whether the household is enrolled in a loyalty program — used to compare value and behavior between loyalty and non-loyalty households."
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Whether the household has opted into marketing — used to size reachable household audience for campaigns."
    - name: "preferred_channel"
      expr: preferred_channel
      comment: "Household preferred ordering or communication channel — used for channel mix optimization and personalization strategy."
    - name: "household_formation_month"
      expr: DATE_TRUNC('month', formation_date)
      comment: "Month the household was formed — used for cohort-based household acquisition and value trend analysis."
  measures:
    - name: "total_households"
      expr: COUNT(1)
      comment: "Total number of household records. Baseline KPI for household universe size — used in CRM and loyalty program scale assessments."
    - name: "total_household_spend"
      expr: SUM(CAST(total_spend AS DOUBLE))
      comment: "Total lifetime spend across all households. Primary household revenue KPI — used to measure the aggregate value of the household guest base."
    - name: "avg_household_spend"
      expr: AVG(CAST(total_spend AS DOUBLE))
      comment: "Average lifetime spend per household. Measures household monetization depth — a key input for household LTV modeling and loyalty investment ROI."
    - name: "avg_check_value"
      expr: AVG(CAST(average_check_value AS DOUBLE))
      comment: "Average check value across households. Benchmarks typical transaction size at the household level — used for upsell and menu strategy decisions."
    - name: "total_household_transactions"
      expr: SUM(CAST(total_transactions AS DOUBLE))
      comment: "Total transaction count across all households. Measures aggregate visit frequency — used to track household engagement volume and loyalty program activity."
    - name: "loyalty_enrollment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN loyalty_enrolled = TRUE THEN household_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of households enrolled in the loyalty program. Measures loyalty program penetration at the household level — a strategic KPI for loyalty growth and investment decisions."
    - name: "marketing_reachable_households"
      expr: COUNT(CASE WHEN marketing_opt_in = TRUE AND household_status = 'active' THEN household_id END)
      comment: "Count of active households opted into marketing. Defines the reachable household audience for campaigns — directly drives marketing spend efficiency."
    - name: "avg_estimated_income_band"
      expr: AVG(CAST(estimated_income_band AS DOUBLE))
      comment: "Average estimated income band across households. Used for affluence-based segmentation and premium product targeting decisions."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest consent and data privacy KPIs measuring consent coverage, opt-in rates, and consent health across channels. Used by Legal, Compliance, and Marketing leadership to manage regulatory risk and reachable audience sizing."
  source: "`vibe_restaurants_v1`.`guest`.`consent_record`"
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent captured (e.g. marketing, data processing, third-party sharing) — primary dimension for consent coverage analysis by purpose."
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent record (e.g. active, revoked, expired) — used to track consent health and compliance posture."
    - name: "consent_method"
      expr: consent_method
      comment: "Method by which consent was captured (e.g. web form, in-store, app) — used to assess consent quality and channel-specific compliance."
    - name: "consent_source_channel"
      expr: consent_source_channel
      comment: "Channel through which consent was obtained — used for channel-level consent coverage and compliance reporting."
    - name: "consent_purpose"
      expr: consent_purpose
      comment: "Business purpose for which consent was granted — used for purpose-specific consent coverage and regulatory reporting."
    - name: "consent_month"
      expr: DATE_TRUNC('month', consent_timestamp)
      comment: "Month consent was captured — used for consent acquisition trend analysis and regulatory audit timelines."
    - name: "data_processing_scope"
      expr: data_processing_scope
      comment: "Scope of data processing covered by the consent — used for GDPR/CCPA compliance segmentation and data governance reporting."
  measures:
    - name: "total_consent_records"
      expr: COUNT(1)
      comment: "Total number of consent records. Baseline KPI for consent program scale — used in compliance audits and data governance reporting."
    - name: "active_consent_count"
      expr: COUNT(CASE WHEN consent_status = 'active' THEN consent_record_id END)
      comment: "Count of currently active consent records. Measures the live consented audience — a compliance and marketing reachability KPI."
    - name: "consent_revocation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_status = 'revoked' THEN consent_record_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records that have been revoked. Measures consent churn and brand trust erosion — a leading indicator of regulatory risk and marketing audience shrinkage."
    - name: "email_consent_coverage"
      expr: ROUND(100.0 * COUNT(CASE WHEN email_consent = TRUE THEN consent_record_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records with email consent granted. Measures email marketing reachability — a direct input to campaign audience sizing and compliance posture."
    - name: "sms_consent_coverage"
      expr: ROUND(100.0 * COUNT(CASE WHEN sms_consent = TRUE THEN consent_record_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records with SMS consent granted. Measures SMS marketing reachability — used to size mobile campaign audiences and track consent health."
    - name: "marketing_consent_coverage"
      expr: ROUND(100.0 * COUNT(CASE WHEN marketing_consent = TRUE THEN consent_record_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records with marketing consent granted. Measures overall marketing reachability — a strategic KPI for campaign planning and regulatory compliance."
    - name: "third_party_consent_coverage"
      expr: ROUND(100.0 * COUNT(CASE WHEN third_party_consent = TRUE THEN consent_record_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records with third-party data sharing consent. Measures data monetization eligibility and partner data sharing compliance — a key legal and commercial KPI."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_digital_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital account KPIs measuring digital channel adoption, account health, and security posture. Used by Digital, Technology, and Marketing leadership to track app engagement, account security risk, and digital loyalty penetration."
  source: "`vibe_restaurants_v1`.`guest`.`digital_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the digital account (e.g. active, suspended, locked) — used to track account health and identify at-risk digital guests."
    - name: "account_tier"
      expr: account_tier
      comment: "Tier of the digital account — used for tier-based digital engagement and loyalty analysis."
    - name: "digital_account_status"
      expr: digital_account_status
      comment: "Operational status of the digital account — used alongside account_status for detailed account lifecycle analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device type used for the digital account (e.g. iOS, Android, web) — used for platform-specific digital experience and investment decisions."
    - name: "consent_marketing"
      expr: consent_marketing
      comment: "Whether the digital account holder has consented to marketing — used to size the digital marketing reachable audience."
    - name: "privacy_opt_out"
      expr: privacy_opt_out
      comment: "Whether the account holder has opted out of data privacy sharing — used for compliance and data governance reporting."
    - name: "account_created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the digital account was created — used for digital acquisition cohort analysis and growth trend reporting."
  measures:
    - name: "total_digital_accounts"
      expr: COUNT(1)
      comment: "Total number of digital accounts. Baseline KPI for digital channel scale — used to track digital adoption and app registration growth."
    - name: "active_digital_accounts"
      expr: COUNT(CASE WHEN account_status = 'active' THEN digital_account_id END)
      comment: "Count of active digital accounts. Measures the live digital guest base — a key KPI for digital channel health and engagement capacity."
    - name: "account_lockout_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN lockout_timestamp IS NOT NULL THEN digital_account_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of digital accounts that have experienced a lockout. Measures account security incidents and friction — a digital experience and security risk KPI."
    - name: "two_factor_adoption_rate"
      expr: ROUND(100.0 * SUM(CAST(two_factor_enabled AS DOUBLE)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of digital accounts with two-factor authentication enabled. Measures security posture of the digital guest base — a cybersecurity and trust KPI for technology leadership."
    - name: "marketing_consent_digital_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_marketing = TRUE THEN digital_account_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of digital accounts with marketing consent. Measures digital marketing reachability — used to size digital campaign audiences and track consent health in the app channel."
    - name: "privacy_opt_out_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN privacy_opt_out = TRUE THEN digital_account_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of digital accounts that have opted out of privacy data sharing. Measures data governance risk and digital trust erosion — a compliance and brand health KPI."
    - name: "unique_guests_with_digital_account"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of distinct guest profiles with at least one digital account. Measures digital channel penetration across the guest base — a strategic KPI for digital transformation investment decisions."
$$;