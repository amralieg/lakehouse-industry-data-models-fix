-- Metric views for domain: customer | Business: Grocery | Version: 1 | Generated on: 2026-05-04 20:38:05

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`customer_shopper`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core shopper-level KPIs tracking acquisition, loyalty enrollment, digital engagement, and communication opt-in health across the active customer base. Used by CRM, Marketing, and Customer Strategy teams to steer acquisition investment, loyalty program growth, and channel mix decisions."
  source: "`grocery_ecm`.`customer`.`shopper`"
  dimensions:
    - name: "acquisition_source"
      expr: acquisition_source
      comment: "Channel or campaign through which the shopper was acquired (e.g., digital, in-store, referral). Used to evaluate acquisition channel ROI."
    - name: "registration_channel"
      expr: registration_channel
      comment: "Channel through which the shopper completed registration (e.g., app, web, in-store kiosk). Supports channel-mix analysis."
    - name: "account_status"
      expr: account_status
      comment: "Current lifecycle status of the shopper account (e.g., active, suspended, closed). Used to filter active base and monitor churn signals."
    - name: "cltv_tier"
      expr: cltv_tier
      comment: "Customer lifetime value tier assigned to the shopper. Enables segmentation of high-value vs. low-value customers for targeted investment."
    - name: "segment"
      expr: segment
      comment: "Behavioral or demographic segment label on the shopper record. Used for cohort-level performance analysis."
    - name: "gender"
      expr: gender
      comment: "Self-reported gender of the shopper. Used for demographic segmentation in marketing analytics."
    - name: "primary_language"
      expr: primary_language
      comment: "Preferred language of the shopper. Supports localization and multilingual communication strategy."
    - name: "state_code"
      expr: state_code
      comment: "US state of the shopper's primary address. Enables geographic performance analysis."
    - name: "snap_eligible"
      expr: snap_eligible
      comment: "Indicates whether the shopper is SNAP-eligible. Used for benefit program targeting and regulatory reporting."
    - name: "wic_eligible"
      expr: wic_eligible
      comment: "Indicates whether the shopper is WIC-eligible. Used for benefit program targeting and regulatory reporting."
    - name: "pharmacy_patient"
      expr: pharmacy_patient
      comment: "Indicates whether the shopper is also a pharmacy patient. Used to measure pharmacy cross-sell penetration."
    - name: "loyalty_enrolled"
      expr: loyalty_enrolled
      comment: "Indicates whether the shopper is enrolled in the loyalty program. Core dimension for loyalty program health dashboards."
    - name: "registration_year_month"
      expr: DATE_TRUNC('month', registration_date)
      comment: "Month of shopper registration. Used to track acquisition cohorts and registration velocity over time."
    - name: "loyalty_enrollment_year_month"
      expr: DATE_TRUNC('month', loyalty_enrollment_date)
      comment: "Month of loyalty enrollment. Used to track loyalty program growth cohorts."
  measures:
    - name: "total_active_shoppers"
      expr: COUNT(DISTINCT CASE WHEN account_status = 'active' THEN shopper_id END)
      comment: "Count of distinct shoppers with an active account status. The primary measure of the addressable active customer base — used in board-level customer count reporting."
    - name: "total_loyalty_enrolled_shoppers"
      expr: COUNT(DISTINCT CASE WHEN loyalty_enrolled = TRUE THEN shopper_id END)
      comment: "Count of distinct shoppers enrolled in the loyalty program. Tracks loyalty program reach and is a leading indicator of repeat purchase behavior."
    - name: "loyalty_enrollment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN loyalty_enrolled = TRUE THEN shopper_id END) / NULLIF(COUNT(DISTINCT shopper_id), 0), 2)
      comment: "Percentage of all shoppers enrolled in the loyalty program. A strategic KPI for loyalty program penetration — executives use this to set enrollment targets and evaluate loyalty investment."
    - name: "total_pharmacy_patients"
      expr: COUNT(DISTINCT CASE WHEN pharmacy_patient = TRUE THEN shopper_id END)
      comment: "Count of shoppers who are also pharmacy patients. Measures pharmacy cross-sell penetration within the grocery customer base — key for pharmacy growth strategy."
    - name: "pharmacy_cross_sell_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN pharmacy_patient = TRUE THEN shopper_id END) / NULLIF(COUNT(DISTINCT CASE WHEN account_status = 'active' THEN shopper_id END), 0), 2)
      comment: "Percentage of active shoppers who are also pharmacy patients. Directly informs pharmacy expansion and cross-sell investment decisions."
    - name: "email_opt_in_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN email_opt_in = TRUE THEN shopper_id END) / NULLIF(COUNT(DISTINCT CASE WHEN account_status = 'active' THEN shopper_id END), 0), 2)
      comment: "Percentage of active shoppers opted into email communications. Determines the reachable email audience size — critical for digital marketing campaign planning and ROI forecasting."
    - name: "sms_opt_in_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN sms_opt_in = TRUE THEN shopper_id END) / NULLIF(COUNT(DISTINCT CASE WHEN account_status = 'active' THEN shopper_id END), 0), 2)
      comment: "Percentage of active shoppers opted into SMS communications. Measures SMS channel reach — used to evaluate mobile engagement strategy and compliance with opt-in regulations."
    - name: "push_notification_opt_in_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN push_notification_opt_in = TRUE THEN shopper_id END) / NULLIF(COUNT(DISTINCT CASE WHEN account_status = 'active' THEN shopper_id END), 0), 2)
      comment: "Percentage of active shoppers opted into push notifications. Measures app engagement channel reach — used to steer mobile app investment and notification strategy."
    - name: "snap_eligible_shopper_count"
      expr: COUNT(DISTINCT CASE WHEN snap_eligible = TRUE THEN shopper_id END)
      comment: "Count of shoppers flagged as SNAP-eligible. Used for benefit program sizing, regulatory compliance reporting, and targeted SNAP promotion planning."
    - name: "identity_verified_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN identity_verified = TRUE THEN shopper_id END) / NULLIF(COUNT(DISTINCT CASE WHEN account_status = 'active' THEN shopper_id END), 0), 2)
      comment: "Percentage of active shoppers with verified identity. A data quality and fraud-risk KPI — low rates signal gaps in KYC processes that increase fraud exposure."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`customer_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level KPIs measuring economic value, loyalty penetration, digital adoption, and benefit program participation. Households are the primary unit of grocery spend — these metrics drive category management, loyalty investment, and omnichannel strategy decisions."
  source: "`grocery_ecm`.`customer`.`household`"
  filter: household_status = 'active' AND is_test_household = FALSE
  dimensions:
    - name: "household_status"
      expr: household_status
      comment: "Current status of the household record (e.g., active, merged, closed). Used to filter the active household base."
    - name: "household_type"
      expr: household_type
      comment: "Classification of the household (e.g., single, family, senior). Enables demographic segmentation for targeted marketing."
    - name: "cltv_tier"
      expr: cltv_tier
      comment: "Customer lifetime value tier of the household. The primary segmentation dimension for value-based marketing investment decisions."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Current lifecycle stage of the household (e.g., new, growing, at-risk, lapsed). Used to trigger lifecycle-based retention and win-back campaigns."
    - name: "income_band"
      expr: income_band
      comment: "Estimated household income band. Used for price sensitivity analysis and private-label affinity targeting."
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which the household was acquired. Used to evaluate acquisition channel efficiency and ROI."
    - name: "preferred_fulfillment_channel"
      expr: preferred_fulfillment_channel
      comment: "Household's preferred order fulfillment method (e.g., delivery, pickup, in-store). Key dimension for omnichannel capacity planning."
    - name: "private_label_affinity"
      expr: private_label_affinity
      comment: "Household's affinity level for private-label products. Used to target private-label promotions and measure own-brand penetration."
    - name: "snap_eligible"
      expr: snap_eligible
      comment: "Indicates whether the household is SNAP-eligible. Used for benefit program sizing and regulatory reporting."
    - name: "wic_eligible"
      expr: wic_eligible
      comment: "Indicates whether the household is WIC-eligible. Used for WIC program targeting and compliance reporting."
    - name: "digital_account_linked"
      expr: digital_account_linked
      comment: "Indicates whether the household has a linked digital account. Measures digital adoption — a leading indicator of omnichannel engagement."
    - name: "pharmacy_household"
      expr: pharmacy_household
      comment: "Indicates whether the household has pharmacy engagement. Used to measure pharmacy cross-sell penetration at the household level."
    - name: "loyalty_enrollment_year_month"
      expr: DATE_TRUNC('month', loyalty_enrollment_date)
      comment: "Month of loyalty program enrollment. Used to track loyalty cohort growth and enrollment velocity."
    - name: "last_transaction_year_month"
      expr: DATE_TRUNC('month', last_transaction_date)
      comment: "Month of the household's most recent transaction. Used to identify recency cohorts and lapsed-customer segments."
  measures:
    - name: "total_households"
      expr: COUNT(DISTINCT household_id)
      comment: "Total count of active, non-test households. The foundational measure of the addressable household base — used in all household-level KPI denominators and board reporting."
    - name: "total_estimated_annual_grocery_spend"
      expr: SUM(CAST(estimated_annual_grocery_spend AS DOUBLE))
      comment: "Sum of estimated annual grocery spend across all households. Proxy for total addressable wallet share — used by category management and finance to size revenue opportunity."
    - name: "avg_estimated_annual_grocery_spend"
      expr: AVG(CAST(estimated_annual_grocery_spend AS DOUBLE))
      comment: "Average estimated annual grocery spend per household. Tracks household value trends over time and across segments — a core input to CLTV modeling."
    - name: "digital_adoption_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN digital_account_linked = TRUE THEN household_id END) / NULLIF(COUNT(DISTINCT household_id), 0), 2)
      comment: "Percentage of active households with a linked digital account. Measures omnichannel adoption — a strategic KPI for digital transformation investment decisions."
    - name: "loyalty_enrolled_household_count"
      expr: COUNT(DISTINCT CASE WHEN loyalty_account_number IS NOT NULL THEN household_id END)
      comment: "Count of households with an active loyalty account number. Measures loyalty program reach at the household level — used to set loyalty enrollment targets."
    - name: "pharmacy_household_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN pharmacy_household = TRUE THEN household_id END) / NULLIF(COUNT(DISTINCT household_id), 0), 2)
      comment: "Percentage of active households with pharmacy engagement. Measures pharmacy cross-sell penetration — used to steer pharmacy growth and co-marketing investment."
    - name: "snap_eligible_household_count"
      expr: COUNT(DISTINCT CASE WHEN snap_eligible = TRUE THEN household_id END)
      comment: "Count of SNAP-eligible households. Used for benefit program sizing, SNAP tender acceptance strategy, and regulatory compliance reporting."
    - name: "fuel_rewards_enrolled_household_count"
      expr: COUNT(DISTINCT CASE WHEN fuel_rewards_enrolled = TRUE THEN household_id END)
      comment: "Count of households enrolled in the fuel rewards program. Measures fuel rewards penetration — used to evaluate the fuel rewards program's contribution to basket size and visit frequency."
    - name: "ebt_card_on_file_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN ebt_card_on_file = TRUE THEN household_id END) / NULLIF(COUNT(DISTINCT household_id), 0), 2)
      comment: "Percentage of households with an EBT card on file. Measures EBT payment readiness — used to evaluate digital EBT adoption and SNAP online ordering eligibility."
    - name: "email_opt_in_household_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN communication_opt_in_email = TRUE THEN household_id END) / NULLIF(COUNT(DISTINCT household_id), 0), 2)
      comment: "Percentage of active households opted into email communications. Determines the reachable email audience at the household level — critical for campaign reach planning."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`customer_benefit_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit enrollment KPIs tracking SNAP, WIC, and other government benefit program participation, benefit balance utilization, and enrollment health. Used by Compliance, Government Relations, and Store Operations to monitor benefit program reach, balance utilization, and regulatory obligations."
  source: "`grocery_ecm`.`customer`.`benefit_enrollment`"
  dimensions:
    - name: "program_type"
      expr: program_type
      comment: "Type of benefit program (e.g., SNAP, WIC, TANF). The primary segmentation dimension for benefit program analysis."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the benefit enrollment (e.g., active, pending, denied, expired). Used to monitor enrollment pipeline health."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the enrollment was initiated (e.g., in-store, online, phone). Used to evaluate enrollment channel efficiency."
    - name: "issuing_state_code"
      expr: issuing_state_code
      comment: "US state that issued the benefit. Enables geographic analysis of benefit program participation for regulatory reporting."
    - name: "income_eligibility_level"
      expr: income_eligibility_level
      comment: "Income eligibility tier for the benefit enrollment. Used for benefit program eligibility analysis and policy compliance."
    - name: "wic_participant_category"
      expr: wic_participant_category
      comment: "WIC participant category (e.g., infant, child, pregnant woman). Used for WIC program composition analysis and food package planning."
    - name: "auto_renewal_enabled"
      expr: auto_renewal_enabled
      comment: "Indicates whether auto-renewal is enabled for the enrollment. Used to forecast renewal rates and identify at-risk enrollments."
    - name: "pos_tender_eligible"
      expr: pos_tender_eligible
      comment: "Indicates whether the benefit is eligible for POS tender. Used to measure benefit tender readiness across store locations."
    - name: "enrollment_year_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of benefit enrollment. Used to track enrollment volume trends and seasonal patterns."
    - name: "expiry_year_month"
      expr: DATE_TRUNC('month', expiry_date)
      comment: "Month of benefit expiry. Used to forecast benefit expirations and plan proactive re-enrollment outreach."
  measures:
    - name: "total_active_enrollments"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'active' THEN benefit_enrollment_id END)
      comment: "Count of active benefit enrollments. The primary measure of benefit program reach — used in regulatory reporting and program health dashboards."
    - name: "total_benefit_balance"
      expr: SUM(CAST(benefit_balance AS DOUBLE))
      comment: "Total outstanding benefit balance across all enrollments. Measures total benefit liability and utilization opportunity — used by Finance and Compliance for benefit liability reporting."
    - name: "avg_benefit_balance"
      expr: AVG(CAST(benefit_balance AS DOUBLE))
      comment: "Average benefit balance per enrollment. Tracks benefit utilization health — declining averages may indicate strong redemption or expiry risk."
    - name: "total_monthly_benefit_amount"
      expr: SUM(CAST(monthly_benefit_amount AS DOUBLE))
      comment: "Total monthly benefit amount across all active enrollments. Measures the monthly benefit flow into the store — a key input for SNAP/WIC revenue forecasting."
    - name: "avg_monthly_benefit_amount"
      expr: AVG(CAST(monthly_benefit_amount AS DOUBLE))
      comment: "Average monthly benefit amount per enrollment. Used to benchmark benefit program generosity and identify outlier enrollments for audit."
    - name: "denial_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN enrollment_status = 'denied' THEN benefit_enrollment_id END) / NULLIF(COUNT(DISTINCT benefit_enrollment_id), 0), 2)
      comment: "Percentage of benefit enrollments that were denied. A compliance and process quality KPI — high denial rates may indicate eligibility verification issues or process failures."
    - name: "auto_renewal_enrollment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN auto_renewal_enabled = TRUE THEN benefit_enrollment_id END) / NULLIF(COUNT(DISTINCT CASE WHEN enrollment_status = 'active' THEN benefit_enrollment_id END), 0), 2)
      comment: "Percentage of active enrollments with auto-renewal enabled. Measures benefit continuity risk — low rates indicate high manual renewal burden and potential benefit lapse exposure."
    - name: "pos_tender_eligible_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN pos_tender_eligible = TRUE THEN benefit_enrollment_id END) / NULLIF(COUNT(DISTINCT CASE WHEN enrollment_status = 'active' THEN benefit_enrollment_id END), 0), 2)
      comment: "Percentage of active enrollments eligible for POS tender. Measures benefit payment readiness at the point of sale — used to evaluate EBT/WIC tender infrastructure coverage."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`customer_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer segment catalog KPIs measuring segment portfolio health, coverage, and strategic composition. Used by Marketing, CRM, and Analytics teams to govern the segment library, monitor active segment counts, and ensure segment quality for campaign targeting."
  source: "`grocery_ecm`.`customer`.`segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Classification of the segment (e.g., behavioral, demographic, lifecycle, regulatory). Used to analyze segment portfolio composition."
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment (e.g., active, draft, archived). Used to filter the active segment library."
    - name: "cltv_tier"
      expr: cltv_tier
      comment: "CLTV tier associated with the segment definition. Used to analyze value-tier coverage in the segment portfolio."
    - name: "applicable_channel"
      expr: applicable_channel
      comment: "Channel scope for which the segment is applicable (e.g., digital, in-store, omnichannel). Used to evaluate channel-specific segment coverage."
    - name: "preferred_fulfillment_method"
      expr: preferred_fulfillment_method
      comment: "Fulfillment method preference associated with the segment. Used to align segment targeting with fulfillment capacity planning."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the segment (e.g., national, regional, local). Used to evaluate geographic coverage of the segment portfolio."
    - name: "is_regulatory_program"
      expr: is_regulatory_program
      comment: "Indicates whether the segment is tied to a regulatory program (e.g., SNAP, WIC). Used to track regulatory segment compliance obligations."
    - name: "loyalty_program_linked"
      expr: loyalty_program_linked
      comment: "Indicates whether the segment is linked to a loyalty program. Used to measure loyalty-integrated segment coverage."
    - name: "owner_team"
      expr: owner_team
      comment: "Team responsible for the segment. Used for segment governance and ownership accountability reporting."
    - name: "effective_start_year_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the segment became effective. Used to track segment creation velocity and portfolio growth over time."
  measures:
    - name: "total_active_segments"
      expr: COUNT(DISTINCT CASE WHEN segment_status = 'active' THEN segment_id END)
      comment: "Count of active segments in the segment catalog. Measures the breadth of the targeting library — used by Marketing to ensure sufficient segment coverage for campaign planning."
    - name: "regulatory_segment_count"
      expr: COUNT(DISTINCT CASE WHEN is_regulatory_program = TRUE THEN segment_id END)
      comment: "Count of segments tied to regulatory programs (SNAP, WIC, etc.). Used by Compliance to ensure all regulatory targeting obligations are covered by defined segments."
    - name: "loyalty_linked_segment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN loyalty_program_linked = TRUE THEN segment_id END) / NULLIF(COUNT(DISTINCT CASE WHEN segment_status = 'active' THEN segment_id END), 0), 2)
      comment: "Percentage of active segments linked to the loyalty program. Measures loyalty integration depth in the segment portfolio — used to evaluate loyalty-driven personalization coverage."
    - name: "suppression_segment_count"
      expr: COUNT(DISTINCT CASE WHEN is_suppression_segment = TRUE THEN segment_id END)
      comment: "Count of suppression segments in the catalog. Used by Compliance and Legal to ensure adequate suppression coverage for do-not-contact and regulatory opt-out obligations."
    - name: "pharmacy_segment_count"
      expr: COUNT(DISTINCT CASE WHEN is_pharmacy_segment = TRUE THEN segment_id END)
      comment: "Count of segments designated for pharmacy targeting. Used by the Pharmacy business unit to evaluate pharmacy-specific segment coverage for Rx marketing campaigns."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`customer_segment_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Segment assignment KPIs measuring the health, coverage, and quality of customer-to-segment assignments. Used by Marketing Operations, CRM, and Analytics to monitor segmentation model performance, assignment freshness, personalization eligibility, and promotion targeting reach."
  source: "`grocery_ecm`.`customer`.`segment_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the segment assignment (e.g., active, expired, revoked). Used to filter the active assignment base."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign the segment (e.g., rule-based, ML model, manual override). Used to evaluate model vs. rule-based assignment mix."
    - name: "cltv_tier"
      expr: cltv_tier
      comment: "CLTV tier at the time of segment assignment. Used to analyze segment assignment distribution across value tiers."
    - name: "channel_scope"
      expr: channel_scope
      comment: "Channel scope of the segment assignment (e.g., digital, in-store, omnichannel). Used to evaluate channel-specific assignment coverage."
    - name: "segment_category"
      expr: segment_category
      comment: "Category of the assigned segment. Used to analyze assignment distribution across segment categories."
    - name: "ab_test_group"
      expr: ab_test_group
      comment: "A/B test group for the assignment. Used to evaluate segment assignment experiments and model lift."
    - name: "is_primary_segment"
      expr: is_primary_segment
      comment: "Indicates whether this is the primary segment assignment for the shopper. Used to distinguish primary from secondary segment assignments."
    - name: "personalization_eligible_flag"
      expr: personalization_eligible_flag
      comment: "Indicates whether the assigned shopper is eligible for personalization. Used to measure the personalization-eligible audience size."
    - name: "snap_wic_eligible"
      expr: snap_wic_eligible
      comment: "Indicates whether the assignment is for a SNAP/WIC eligible shopper. Used for benefit program targeting compliance."
    - name: "assignment_year_month"
      expr: DATE_TRUNC('month', assignment_date)
      comment: "Month of segment assignment. Used to track assignment volume trends and model refresh cadence."
  measures:
    - name: "total_active_assignments"
      expr: COUNT(DISTINCT CASE WHEN assignment_status = 'active' THEN segment_assignment_id END)
      comment: "Count of active segment assignments. Measures the total volume of active customer-segment relationships — used to monitor segmentation model coverage and assignment pipeline health."
    - name: "unique_assigned_shoppers"
      expr: COUNT(DISTINCT CASE WHEN assignment_status = 'active' THEN shopper_id END)
      comment: "Count of distinct shoppers with at least one active segment assignment. Measures segmentation reach — the proportion of the customer base covered by the segmentation model."
    - name: "unique_assigned_households"
      expr: COUNT(DISTINCT CASE WHEN assignment_status = 'active' THEN household_id END)
      comment: "Count of distinct households with at least one active segment assignment. Measures household-level segmentation coverage — used for household-targeted campaign planning."
    - name: "personalization_eligible_shopper_count"
      expr: COUNT(DISTINCT CASE WHEN personalization_eligible_flag = TRUE AND assignment_status = 'active' THEN shopper_id END)
      comment: "Count of distinct shoppers eligible for personalization based on active segment assignments. Measures the personalization-addressable audience — a key input for personalization ROI calculations."
    - name: "personalization_eligibility_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN personalization_eligible_flag = TRUE AND assignment_status = 'active' THEN shopper_id END) / NULLIF(COUNT(DISTINCT CASE WHEN assignment_status = 'active' THEN shopper_id END), 0), 2)
      comment: "Percentage of actively assigned shoppers eligible for personalization. Measures personalization program reach — executives use this to evaluate personalization infrastructure investment."
    - name: "promotion_eligible_shopper_count"
      expr: COUNT(DISTINCT CASE WHEN promotion_eligibility_flag = TRUE AND assignment_status = 'active' THEN shopper_id END)
      comment: "Count of distinct shoppers eligible for promotions based on active segment assignments. Measures the promotable audience size — used by Promotions and Trade Marketing to size campaign reach."
    - name: "avg_assignment_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average model confidence score across all segment assignments. Measures segmentation model quality — declining scores signal model drift and trigger model retraining decisions."
    - name: "opt_out_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN opt_out_flag = TRUE THEN segment_assignment_id END) / NULLIF(COUNT(DISTINCT segment_assignment_id), 0), 2)
      comment: "Percentage of segment assignments where the shopper has opted out. Measures consent-driven audience erosion — high opt-out rates signal communication fatigue or consent management issues."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`customer_consent_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent management KPIs tracking opt-in rates, suppression coverage, double opt-in compliance, and consent health across the customer base. Used by Legal, Compliance, Privacy, and Marketing Operations to ensure regulatory compliance (GDPR, CCPA, CAN-SPAM) and manage the consented marketing audience."
  source: "`grocery_ecm`.`customer`.`consent_record`"
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent captured (e.g., marketing, data sharing, loyalty). The primary dimension for consent portfolio analysis."
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent record (e.g., active, withdrawn, expired). Used to filter the active consented audience."
    - name: "consent_source"
      expr: consent_source
      comment: "Channel or system through which consent was captured (e.g., app, web, in-store). Used to evaluate consent capture channel effectiveness."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the consent (e.g., GDPR, CCPA, CAN-SPAM). Used for jurisdiction-specific compliance reporting."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the consent record. Used for geographic compliance analysis and regulatory reporting."
    - name: "consent_language_code"
      expr: consent_language_code
      comment: "Language in which consent was presented. Used to ensure multilingual consent compliance."
    - name: "suppression_type"
      expr: suppression_type
      comment: "Type of suppression applied (e.g., do-not-contact, regulatory, fraud). Used to analyze suppression portfolio composition."
    - name: "re_consent_required"
      expr: re_consent_required
      comment: "Indicates whether re-consent is required for this record. Used to identify and prioritize re-consent outreach campaigns."
    - name: "double_opt_in_confirmed"
      expr: double_opt_in_confirmed
      comment: "Indicates whether double opt-in was confirmed. Used to measure double opt-in compliance rate for email marketing."
    - name: "consent_year_month"
      expr: DATE_TRUNC('month', consent_date)
      comment: "Month consent was captured. Used to track consent acquisition velocity and identify consent decay trends."
  measures:
    - name: "total_active_consents"
      expr: COUNT(DISTINCT CASE WHEN consent_status = 'active' THEN consent_record_id END)
      comment: "Count of active consent records. The foundational measure of the consented audience — used by Legal and Marketing to size the legally reachable customer base."
    - name: "consent_withdrawal_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN consent_status = 'withdrawn' THEN consent_record_id END) / NULLIF(COUNT(DISTINCT consent_record_id), 0), 2)
      comment: "Percentage of consent records that have been withdrawn. A critical compliance and customer trust KPI — rising withdrawal rates signal communication fatigue or trust erosion and trigger immediate marketing strategy review."
    - name: "double_opt_in_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN double_opt_in_confirmed = TRUE THEN consent_record_id END) / NULLIF(COUNT(DISTINCT CASE WHEN consent_status = 'active' THEN consent_record_id END), 0), 2)
      comment: "Percentage of active consents with confirmed double opt-in. Measures email marketing compliance quality — required for GDPR and CAN-SPAM compliance in applicable jurisdictions."
    - name: "suppressed_record_count"
      expr: COUNT(DISTINCT CASE WHEN is_suppressed = TRUE THEN consent_record_id END)
      comment: "Count of suppressed consent records. Measures the suppressed audience size — used by Compliance to ensure suppression lists are applied correctly across all marketing channels."
    - name: "suppression_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_suppressed = TRUE THEN consent_record_id END) / NULLIF(COUNT(DISTINCT consent_record_id), 0), 2)
      comment: "Percentage of consent records that are suppressed. Measures the proportion of the customer base excluded from marketing — high rates indicate compliance risk or data quality issues."
    - name: "re_consent_required_count"
      expr: COUNT(DISTINCT CASE WHEN re_consent_required = TRUE THEN consent_record_id END)
      comment: "Count of consent records requiring re-consent. Measures the re-consent backlog — used by Legal and Marketing to prioritize re-consent campaigns and avoid regulatory violations from using stale consent."
    - name: "loyalty_program_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN loyalty_program_consent = TRUE THEN consent_record_id END) / NULLIF(COUNT(DISTINCT CASE WHEN consent_status = 'active' THEN consent_record_id END), 0), 2)
      comment: "Percentage of active consent records with loyalty program consent granted. Measures the consented loyalty audience — used to ensure loyalty communications are sent only to consented members."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`customer_pharmacy_patient`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy patient KPIs measuring patient enrollment health, HIPAA compliance, medication synchronization adoption, auto-refill penetration, and benefit eligibility. Used by Pharmacy Operations, Compliance, and Healthcare Strategy to steer pharmacy growth, patient safety, and regulatory adherence."
  source: "`grocery_ecm`.`customer`.`pharmacy_patient`"
  dimensions:
    - name: "patient_status"
      expr: patient_status
      comment: "Current status of the pharmacy patient record (e.g., active, inactive, transferred). Used to filter the active patient base."
    - name: "patient_type"
      expr: patient_type
      comment: "Classification of the pharmacy patient (e.g., retail, mail-order, specialty). Used to analyze patient mix and service model."
    - name: "counseling_preference"
      expr: counseling_preference
      comment: "Patient's preferred counseling method (e.g., in-person, phone, waived). Used to plan pharmacist counseling capacity."
    - name: "rx_notification_channel"
      expr: rx_notification_channel
      comment: "Preferred channel for Rx ready notifications (e.g., SMS, email, app). Used to optimize notification channel mix for pickup conversion."
    - name: "language_preference"
      expr: language_preference
      comment: "Patient's preferred language for pharmacy communications. Used to ensure multilingual pharmacy service compliance."
    - name: "hipaa_acknowledgment_channel"
      expr: hipaa_acknowledgment_channel
      comment: "Channel through which HIPAA notice was acknowledged. Used for HIPAA compliance audit and channel analysis."
    - name: "snap_benefit_eligible"
      expr: snap_benefit_eligible
      comment: "Indicates whether the pharmacy patient is SNAP benefit eligible. Used for benefit program cross-referencing."
    - name: "wic_benefit_eligible"
      expr: wic_benefit_eligible
      comment: "Indicates whether the pharmacy patient is WIC benefit eligible. Used for WIC pharmacy benefit targeting."
    - name: "n340b_eligible"
      expr: n340b_eligible
      comment: "Indicates whether the patient is eligible for the 340B drug pricing program. Used for 340B compliance reporting and cost management."
    - name: "enrollment_year_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of pharmacy patient enrollment. Used to track patient acquisition velocity and cohort analysis."
  measures:
    - name: "total_active_pharmacy_patients"
      expr: COUNT(DISTINCT CASE WHEN patient_status = 'active' THEN pharmacy_patient_id END)
      comment: "Count of active pharmacy patients. The primary measure of pharmacy patient base size — used by Pharmacy Operations and Healthcare Strategy to track pharmacy growth and set patient acquisition targets."
    - name: "hipaa_acknowledgment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN hipaa_notice_acknowledged = TRUE THEN pharmacy_patient_id END) / NULLIF(COUNT(DISTINCT CASE WHEN patient_status = 'active' THEN pharmacy_patient_id END), 0), 2)
      comment: "Percentage of active pharmacy patients with HIPAA notice acknowledged. A mandatory compliance KPI — any rate below 100% represents a regulatory violation risk requiring immediate remediation."
    - name: "auto_refill_adoption_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN auto_refill_opt_in = TRUE THEN pharmacy_patient_id END) / NULLIF(COUNT(DISTINCT CASE WHEN patient_status = 'active' THEN pharmacy_patient_id END), 0), 2)
      comment: "Percentage of active pharmacy patients enrolled in auto-refill. Measures medication adherence program penetration — higher rates correlate with improved patient outcomes and predictable Rx revenue."
    - name: "medsync_adoption_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN medsync_enrolled = TRUE THEN pharmacy_patient_id END) / NULLIF(COUNT(DISTINCT CASE WHEN patient_status = 'active' THEN pharmacy_patient_id END), 0), 2)
      comment: "Percentage of active pharmacy patients enrolled in medication synchronization (MedSync). Measures MedSync program penetration — a strategic KPI for pharmacy efficiency and patient retention."
    - name: "loyalty_rx_points_eligible_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN loyalty_rx_points_eligible = TRUE THEN pharmacy_patient_id END) / NULLIF(COUNT(DISTINCT CASE WHEN patient_status = 'active' THEN pharmacy_patient_id END), 0), 2)
      comment: "Percentage of active pharmacy patients eligible for loyalty Rx points. Measures the overlap between pharmacy and loyalty programs — used to evaluate pharmacy-loyalty cross-sell effectiveness."
    - name: "n340b_eligible_patient_count"
      expr: COUNT(DISTINCT CASE WHEN n340b_eligible = TRUE THEN pharmacy_patient_id END)
      comment: "Count of patients eligible for the 340B drug pricing program. Used by Pharmacy Finance and Compliance to size 340B program participation and ensure cost savings are captured."
    - name: "allergy_disclosure_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN allergy_flag = TRUE THEN pharmacy_patient_id END) / NULLIF(COUNT(DISTINCT CASE WHEN patient_status = 'active' THEN pharmacy_patient_id END), 0), 2)
      comment: "Percentage of active pharmacy patients with an allergy flag on file. Measures patient safety data completeness — a clinical quality KPI used by Pharmacy Operations to ensure allergy screening coverage."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`customer_wholesale_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wholesale account KPIs measuring B2B customer portfolio health, credit risk, revenue potential, and contract coverage. Used by Wholesale Sales, Finance, and Credit Management to steer B2B account growth, manage credit exposure, and evaluate wholesale channel performance."
  source: "`grocery_ecm`.`customer`.`wholesale_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the wholesale account (e.g., active, suspended, closed). Used to filter the active B2B account base."
    - name: "account_type"
      expr: account_type
      comment: "Classification of the wholesale account (e.g., distributor, retailer, foodservice). Used to analyze B2B customer mix."
    - name: "account_tier"
      expr: account_tier
      comment: "Tier classification of the wholesale account (e.g., platinum, gold, silver). Used to prioritize account management resources."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating of the wholesale account. Used for credit risk segmentation and exposure management."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for the wholesale account (e.g., Net 30, Net 60). Used to analyze working capital exposure by payment terms."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Preferred delivery method for the wholesale account. Used for logistics capacity planning."
    - name: "sales_territory_code"
      expr: sales_territory_code
      comment: "Sales territory assigned to the wholesale account. Used for territory-level performance analysis and sales rep accountability."
    - name: "snap_wic_eligible_flag"
      expr: snap_wic_eligible_flag
      comment: "Indicates whether the wholesale account is eligible for SNAP/WIC transactions. Used for benefit program compliance in B2B channel."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Indicates whether the wholesale account is tax-exempt. Used for tax compliance and revenue reporting."
    - name: "contract_start_year_month"
      expr: DATE_TRUNC('month', contract_start_date)
      comment: "Month the wholesale contract started. Used to track contract cohort performance and renewal cycles."
  measures:
    - name: "total_active_wholesale_accounts"
      expr: COUNT(DISTINCT CASE WHEN account_status = 'active' THEN wholesale_account_id END)
      comment: "Count of active wholesale accounts. The primary measure of B2B customer base size — used by Wholesale Sales leadership to track account portfolio growth and set acquisition targets."
    - name: "total_annual_revenue_estimate"
      expr: SUM(CAST(annual_revenue_estimate AS DOUBLE))
      comment: "Total estimated annual revenue across all wholesale accounts. Measures the total B2B revenue opportunity — used by Finance and Sales leadership for wholesale channel revenue forecasting."
    - name: "avg_annual_revenue_estimate"
      expr: AVG(CAST(annual_revenue_estimate AS DOUBLE))
      comment: "Average estimated annual revenue per wholesale account. Tracks account value trends — used to benchmark account productivity and identify underperforming accounts."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all wholesale accounts. Measures total B2B credit exposure — used by Finance and Credit Management for credit risk monitoring and capital allocation."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per wholesale account. Used to benchmark credit policy consistency and identify outlier accounts for credit review."
    - name: "credit_hold_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN credit_hold_flag = TRUE THEN wholesale_account_id END) / NULLIF(COUNT(DISTINCT CASE WHEN account_status = 'active' THEN wholesale_account_id END), 0), 2)
      comment: "Percentage of active wholesale accounts currently on credit hold. A financial risk KPI — rising credit hold rates signal deteriorating B2B customer credit health and potential revenue at risk."
    - name: "total_minimum_order_amount"
      expr: SUM(CAST(minimum_order_amount AS DOUBLE))
      comment: "Sum of minimum order amounts across all active wholesale accounts. Used to calculate the guaranteed minimum order floor for wholesale revenue planning."
    - name: "edi_capable_account_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN edi_capable_flag = TRUE THEN wholesale_account_id END) / NULLIF(COUNT(DISTINCT CASE WHEN account_status = 'active' THEN wholesale_account_id END), 0), 2)
      comment: "Percentage of active wholesale accounts with EDI capability. Measures B2B digital integration maturity — used to evaluate order automation potential and operational efficiency in the wholesale channel."
$$;