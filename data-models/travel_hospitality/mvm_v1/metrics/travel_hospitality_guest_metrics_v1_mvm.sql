-- Metric views for domain: guest | Business: Travel Hospitality | Version: 1 | Generated on: 2026-05-08 05:56:59

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`guest_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core guest profile metrics tracking the active guest base, loyalty enrollment health, marketing reachability, and data privacy compliance. Used by CRM, Loyalty, and Marketing leadership to steer guest acquisition, retention, and consent governance."
  source: "`travel_hospitality_ecm`.`guest`.`profile`"
  filter: profile_status = 'ACTIVE'
  dimensions:
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Loyalty tier of the guest (e.g. Silver, Gold, Platinum) — primary segmentation axis for loyalty program performance analysis."
    - name: "guest_type"
      expr: guest_type
      comment: "Classification of the guest (e.g. Leisure, Corporate, Group) — used to segment profile base by business mix."
    - name: "country_of_residence"
      expr: country_of_residence_code
      comment: "ISO country code of the guest's country of residence — used for geographic segmentation and regulatory compliance reporting."
    - name: "gender"
      expr: gender
      comment: "Self-reported gender of the guest — used for demographic analysis and personalisation strategy."
    - name: "preferred_language"
      expr: preferred_language_code
      comment: "Guest's preferred communication language — used to assess localisation coverage and communication effectiveness."
    - name: "vip_status"
      expr: vip_status
      comment: "VIP designation level of the guest — used to track high-value guest concentration and service prioritisation."
    - name: "source_system"
      expr: source_system
      comment: "Originating system that created the profile (e.g. Opera, CRM, Web) — used for data quality and integration health monitoring."
    - name: "loyalty_enrollment_year"
      expr: YEAR(loyalty_enrollment_date)
      comment: "Year the guest enrolled in the loyalty program — used for cohort analysis of loyalty program growth."
    - name: "profile_created_year"
      expr: YEAR(created_timestamp)
      comment: "Year the guest profile was created — used for new guest acquisition trend analysis."
  measures:
    - name: "total_active_guest_profiles"
      expr: COUNT(1)
      comment: "Total number of active guest profiles. Baseline KPI for the size of the known guest base — used by CRM and Marketing to size addressable audience."
    - name: "loyalty_enrolled_guests"
      expr: COUNT(CASE WHEN loyalty_member_number IS NOT NULL THEN profile_id END)
      comment: "Number of active guests enrolled in the loyalty program. Tracks loyalty program penetration of the guest base — a key retention and lifetime value driver."
    - name: "marketing_opt_in_guests"
      expr: COUNT(CASE WHEN marketing_opt_in = TRUE THEN profile_id END)
      comment: "Number of active guests who have opted in to marketing communications. Defines the reachable marketing audience — directly impacts campaign reach and revenue from direct marketing."
    - name: "email_opt_in_guests"
      expr: COUNT(CASE WHEN email_opt_in = TRUE THEN profile_id END)
      comment: "Number of active guests opted in to email communications. Email is the highest-ROI direct channel — this metric drives email programme investment decisions."
    - name: "sms_opt_in_guests"
      expr: COUNT(CASE WHEN sms_opt_in = TRUE THEN profile_id END)
      comment: "Number of active guests opted in to SMS communications. Tracks SMS channel reachability for time-sensitive offers and operational notifications."
    - name: "gdpr_erasure_requested_guests"
      expr: COUNT(CASE WHEN gdpr_erasure_requested = TRUE THEN profile_id END)
      comment: "Number of active guests who have submitted a GDPR erasure (right-to-be-forgotten) request. Critical compliance KPI — elevated counts trigger legal and data governance escalation."
    - name: "merged_profile_count"
      expr: COUNT(CASE WHEN is_merge_survivor = FALSE AND merged_into_profile_id IS NOT NULL THEN profile_id END)
      comment: "Number of profiles that have been merged into a survivor profile. Tracks duplicate guest record volume — high counts indicate data quality issues requiring MDM intervention."
    - name: "distinct_nationalities"
      expr: COUNT(DISTINCT nationality_country_code)
      comment: "Number of distinct nationalities represented in the active guest base. Measures geographic diversity of the guest portfolio — informs multilingual service and localisation investment."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`guest_stay_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and stay performance metrics derived from completed and in-house guest stays. The primary financial and operational KPI layer for the guest domain — used by Revenue Management, Finance, and Operations leadership to steer pricing, channel mix, and guest experience investment."
  source: "`travel_hospitality_ecm`.`guest`.`stay_history`"
  filter: stay_status IN ('CHECKED_OUT', 'CHECKED_IN')
  dimensions:
    - name: "stay_status"
      expr: stay_status
      comment: "Current status of the stay record (e.g. CHECKED_IN, CHECKED_OUT) — used to filter and segment stay performance by lifecycle stage."
    - name: "guest_type"
      expr: guest_type
      comment: "Type of guest for the stay (e.g. Leisure, Corporate, Group) — primary business mix dimension for revenue analysis."
    - name: "loyalty_tier_at_stay"
      expr: loyalty_tier_at_stay
      comment: "Loyalty tier of the guest at the time of the stay — used to analyse revenue contribution and ADR by loyalty segment."
    - name: "rate_plan_code"
      expr: rate_plan_code
      comment: "Rate plan under which the stay was booked — used to evaluate rate plan performance and pricing strategy effectiveness."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the stay folio — used for payment channel analysis and direct billing programme monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the stay was billed — used for multi-currency revenue reporting and FX exposure analysis."
    - name: "arrival_month"
      expr: DATE_TRUNC('MONTH', arrival_date)
      comment: "Month of guest arrival — primary time dimension for stay volume and revenue trend analysis."
    - name: "arrival_year"
      expr: YEAR(arrival_date)
      comment: "Year of guest arrival — used for year-over-year revenue and stay performance comparisons."
    - name: "booking_month"
      expr: DATE_TRUNC('MONTH', booking_date)
      comment: "Month the stay was booked — used to analyse booking lead time patterns and advance purchase behaviour."
    - name: "complimentary_flag"
      expr: complimentary_flag
      comment: "Indicates whether the stay was complimentary — used to track comp room cost and loyalty programme benefit utilisation."
    - name: "service_recovery_flag"
      expr: service_recovery_flag
      comment: "Indicates whether a service recovery action was applied during the stay — used to track service failure rates and associated cost."
  measures:
    - name: "total_stays"
      expr: COUNT(1)
      comment: "Total number of stay records. Baseline volume KPI for occupancy and throughput analysis — used by Operations and Revenue Management."
    - name: "total_room_revenue"
      expr: SUM(CAST(room_revenue AS DOUBLE))
      comment: "Total room revenue across all stays. Primary top-line revenue KPI for the property portfolio — directly steers pricing and yield management decisions."
    - name: "total_ancillary_revenue"
      expr: SUM(CAST(ancillary_revenue AS DOUBLE))
      comment: "Total ancillary revenue (spa, parking, activities, etc.) across all stays. Tracks non-room revenue contribution — used to evaluate upsell programme effectiveness."
    - name: "total_fb_revenue"
      expr: SUM(CAST(fb_revenue AS DOUBLE))
      comment: "Total food and beverage revenue across all stays. Tracks F&B attachment performance — used by F&B leadership to assess outlet revenue contribution per stay."
    - name: "total_folio_amount"
      expr: SUM(CAST(total_folio_amount AS DOUBLE))
      comment: "Total billed folio amount across all stays (room + ancillary + F&B + tax). Represents total guest spend — the most comprehensive revenue KPI for the stay portfolio."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected across all stays. Required for tax compliance reporting and financial reconciliation."
    - name: "avg_daily_rate"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average Daily Rate across all stays. Core RevPAR component and pricing effectiveness KPI — used by Revenue Management to benchmark rate performance."
    - name: "avg_total_folio_per_stay"
      expr: AVG(CAST(total_folio_amount AS DOUBLE))
      comment: "Average total folio amount per stay. Measures average guest spend per visit — used to track revenue per guest and upsell programme impact."
    - name: "avg_ancillary_revenue_per_stay"
      expr: AVG(CAST(ancillary_revenue AS DOUBLE))
      comment: "Average ancillary revenue per stay. Tracks the average non-room spend per guest visit — used to evaluate ancillary revenue programme performance."
    - name: "avg_gss_score"
      expr: AVG(CAST(gss_score AS DOUBLE))
      comment: "Average Guest Satisfaction Score (GSS) across stays. Primary guest experience quality KPI — used by Operations and GM leadership to track service delivery performance."
    - name: "service_recovery_stays"
      expr: COUNT(CASE WHEN service_recovery_flag = TRUE THEN stay_history_id END)
      comment: "Number of stays where a service recovery action was applied. Tracks service failure volume — elevated counts trigger operational investigation and training interventions."
    - name: "complimentary_stays"
      expr: COUNT(CASE WHEN complimentary_flag = TRUE THEN stay_history_id END)
      comment: "Number of complimentary stays. Tracks comp room utilisation — used by Finance and Loyalty to monitor the cost of complimentary benefit programmes."
    - name: "unique_guests_with_stays"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct guest profiles with at least one stay. Measures active guest base size — used to track guest retention and repeat visitation."
    - name: "repeat_guest_stays"
      expr: COUNT(CASE WHEN loyalty_tier_at_stay IS NOT NULL THEN stay_history_id END)
      comment: "Number of stays by loyalty programme members. Proxy for repeat/loyal guest volume — used to assess loyalty programme contribution to total stay volume."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`guest_communication_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent management and regulatory compliance metrics for guest communication preferences. Used by Legal, Compliance, CRM, and Marketing leadership to govern data privacy obligations (GDPR, CCPA) and ensure marketing communications are lawfully executed."
  source: "`travel_hospitality_ecm`.`guest`.`communication_consent`"
  filter: record_active_flag = TRUE
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent captured (e.g. Marketing, Transactional, Profiling) — primary segmentation axis for consent portfolio analysis."
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent record (e.g. GRANTED, WITHDRAWN, EXPIRED) — used to monitor active consent coverage."
    - name: "consent_method"
      expr: consent_method
      comment: "Method by which consent was captured (e.g. Web Form, In-Person, Email) — used to evaluate consent capture channel effectiveness."
    - name: "consent_purpose"
      expr: consent_purpose
      comment: "Business purpose for which consent was obtained — used to ensure purpose-limitation compliance under GDPR."
    - name: "legal_basis"
      expr: legal_basis
      comment: "Legal basis for processing (e.g. Consent, Legitimate Interest, Contract) — critical for GDPR Article 6 compliance reporting."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction governing the consent record (e.g. EU, UK, US-CA) — used for jurisdiction-specific compliance reporting."
    - name: "guest_country_code"
      expr: guest_country_code
      comment: "Country of the guest at time of consent capture — used for geographic consent coverage analysis."
    - name: "consent_granted_month"
      expr: DATE_TRUNC('MONTH', consent_granted_date)
      comment: "Month consent was granted — used for consent acquisition trend analysis."
    - name: "double_opt_in_flag"
      expr: double_opt_in_flag
      comment: "Indicates whether double opt-in confirmation was completed — used to assess quality and enforceability of consent records."
  measures:
    - name: "total_active_consent_records"
      expr: COUNT(1)
      comment: "Total number of active consent records. Baseline KPI for consent portfolio size — used by Compliance to monitor the scale of consent obligations."
    - name: "granted_consent_records"
      expr: COUNT(CASE WHEN consent_status = 'GRANTED' THEN communication_consent_id END)
      comment: "Number of consent records with GRANTED status. Defines the lawfully reachable audience for each consent purpose — directly governs marketing campaign eligibility."
    - name: "withdrawn_consent_records"
      expr: COUNT(CASE WHEN consent_status = 'WITHDRAWN' THEN communication_consent_id END)
      comment: "Number of consent records that have been withdrawn. Tracks opt-out volume — elevated withdrawal rates trigger CRM and marketing strategy review."
    - name: "expired_consent_records"
      expr: COUNT(CASE WHEN consent_status = 'EXPIRED' THEN communication_consent_id END)
      comment: "Number of consent records that have expired. Tracks consent decay — used to prioritise consent renewal campaigns and avoid unlawful processing."
    - name: "double_opt_in_confirmed_records"
      expr: COUNT(CASE WHEN double_opt_in_flag = TRUE THEN communication_consent_id END)
      comment: "Number of consent records confirmed via double opt-in. Measures the highest-quality, most legally defensible consent tier — used by Legal to assess consent enforceability."
    - name: "profiling_consent_granted_records"
      expr: COUNT(CASE WHEN profiling_consent_flag = TRUE THEN communication_consent_id END)
      comment: "Number of records where profiling consent has been granted. Governs eligibility for AI/ML personalisation and guest profiling — a critical input to personalisation programme scope."
    - name: "third_party_sharing_consent_records"
      expr: COUNT(CASE WHEN third_party_sharing_consent_flag = TRUE THEN communication_consent_id END)
      comment: "Number of records where third-party data sharing consent has been granted. Governs partner data sharing eligibility — used by Legal and Partnerships to manage data sharing agreements."
    - name: "suppression_list_records"
      expr: COUNT(CASE WHEN suppression_list_flag = TRUE THEN communication_consent_id END)
      comment: "Number of guest records on the suppression list. Tracks do-not-contact volume — used by Marketing Operations to ensure suppressed guests are excluded from all outbound campaigns."
    - name: "distinct_guests_with_consent"
      expr: COUNT(DISTINCT guest_profile_id)
      comment: "Number of distinct guest profiles with at least one active consent record. Measures consent programme coverage of the guest base — used to identify consent gaps."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`guest_vip_designation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "VIP guest programme metrics tracking the size, composition, and service requirements of the VIP guest portfolio. Used by Guest Relations, Revenue Management, and Hotel GM leadership to manage high-value guest experiences and associated service cost."
  source: "`travel_hospitality_ecm`.`guest`.`vip_designation`"
  filter: designation_status = 'ACTIVE'
  dimensions:
    - name: "vip_level"
      expr: vip_level
      comment: "VIP tier level of the designation (e.g. VIP1, VIP2, Celebrity) — primary segmentation axis for VIP portfolio analysis."
    - name: "designation_scope"
      expr: designation_scope
      comment: "Scope of the VIP designation (e.g. Property, Brand, Global) — used to understand the geographic reach of VIP service obligations."
    - name: "designation_reason"
      expr: designation_reason
      comment: "Reason for the VIP designation (e.g. Revenue, Loyalty, Celebrity) — used to classify VIP guests by the basis of their designation."
    - name: "amenity_tier_code"
      expr: amenity_tier_code
      comment: "Amenity tier assigned to the VIP guest — used to track amenity cost and service level distribution across the VIP portfolio."
    - name: "upgrade_eligible"
      expr: upgrade_eligible
      comment: "Indicates whether the VIP guest is eligible for a complimentary room upgrade — used to manage upgrade inventory allocation."
    - name: "gm_greeting_required"
      expr: gm_greeting_required
      comment: "Indicates whether a General Manager greeting is required for this VIP — used to schedule GM time and track high-touch service obligations."
    - name: "media_blackout"
      expr: media_blackout
      comment: "Indicates whether a media blackout policy applies to this VIP guest — used to enforce privacy and security protocols."
    - name: "effective_from_year"
      expr: YEAR(effective_from)
      comment: "Year the VIP designation became effective — used for cohort analysis of VIP programme growth."
  measures:
    - name: "total_active_vip_designations"
      expr: COUNT(1)
      comment: "Total number of active VIP designations. Baseline KPI for VIP programme scale — used by Guest Relations to size service resource requirements."
    - name: "distinct_vip_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct guest profiles with an active VIP designation. Measures the true size of the VIP guest base — used for resource planning and service cost budgeting."
    - name: "upgrade_eligible_vip_guests"
      expr: COUNT(CASE WHEN upgrade_eligible = TRUE THEN vip_designation_id END)
      comment: "Number of active VIP designations eligible for complimentary room upgrades. Quantifies upgrade inventory demand from VIP programme — used by Revenue Management to balance upgrade cost against loyalty benefit."
    - name: "gm_greeting_required_count"
      expr: COUNT(CASE WHEN gm_greeting_required = TRUE THEN vip_designation_id END)
      comment: "Number of active VIP designations requiring a GM greeting. Quantifies GM time obligations from the VIP programme — used for GM scheduling and workload management."
    - name: "security_escort_required_count"
      expr: COUNT(CASE WHEN security_escort_required = TRUE THEN vip_designation_id END)
      comment: "Number of active VIP designations requiring a security escort. Tracks security resource demand from the VIP portfolio — used by Security Operations for staffing and cost planning."
    - name: "avg_revenue_threshold"
      expr: AVG(CAST(revenue_threshold_amount AS DOUBLE))
      comment: "Average revenue threshold amount set for VIP designations. Indicates the average revenue bar for VIP qualification — used to calibrate VIP programme entry criteria and ROI."
    - name: "total_revenue_threshold"
      expr: SUM(CAST(revenue_threshold_amount AS DOUBLE))
      comment: "Total revenue threshold amount across all active VIP designations. Represents the aggregate revenue commitment associated with the VIP portfolio — used by Finance for programme ROI analysis."
    - name: "incognito_checkin_count"
      expr: COUNT(CASE WHEN incognito_checkin = TRUE THEN vip_designation_id END)
      comment: "Number of active VIP designations requiring incognito check-in. Tracks privacy-sensitive VIP handling volume — used by Front Office to ensure discreet arrival protocols are in place."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`guest_group_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group business metrics tracking contracted room block performance, pickup rates, and financial commitments. Used by Sales, Revenue Management, and Events leadership to manage group business pipeline, attrition risk, and contracted revenue delivery."
  source: "`travel_hospitality_ecm`.`guest`.`guest_group_block`"
  filter: block_status NOT IN ('CANCELLED', 'REJECTED')
  dimensions:
    - name: "block_status"
      expr: block_status
      comment: "Current status of the group block (e.g. TENTATIVE, DEFINITE, PICKED_UP) — primary lifecycle dimension for group business pipeline management."
    - name: "group_type"
      expr: group_type
      comment: "Type of group (e.g. Corporate, Wedding, Conference, Tour) — used to segment group business by market type."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contracted group rate — used for multi-currency group revenue reporting."
    - name: "rooming_list_status"
      expr: rooming_list_status
      comment: "Status of the rooming list submission (e.g. PENDING, RECEIVED, COMPLETE) — used to track group operational readiness."
    - name: "repeat_group_flag"
      expr: repeat_group_flag
      comment: "Indicates whether this is a repeat group booking — used to track group loyalty and repeat business rate."
    - name: "vip_flag"
      expr: vip_flag
      comment: "Indicates whether the group has VIP status — used to prioritise service resources for high-value group blocks."
    - name: "arrival_month"
      expr: DATE_TRUNC('MONTH', arrival_date)
      comment: "Month of group arrival — primary time dimension for group business pacing and revenue forecasting."
    - name: "arrival_year"
      expr: YEAR(arrival_date)
      comment: "Year of group arrival — used for year-over-year group business performance comparisons."
  measures:
    - name: "total_group_blocks"
      expr: COUNT(1)
      comment: "Total number of active group blocks. Baseline KPI for group business pipeline volume — used by Sales to track group booking activity."
    - name: "total_contracted_revenue"
      expr: SUM(CAST(contracted_rate_amount AS DOUBLE))
      comment: "Total contracted rate amount across all active group blocks. Represents the committed group revenue pipeline — used by Revenue Management and Finance for group revenue forecasting."
    - name: "total_deposit_required"
      expr: SUM(CAST(deposit_required_amount AS DOUBLE))
      comment: "Total deposit amount required across all active group blocks. Tracks financial commitment obligations — used by Finance to manage group deposit collection and cash flow."
    - name: "total_deposit_received"
      expr: SUM(CAST(deposit_received_amount AS DOUBLE))
      comment: "Total deposit amount received across all active group blocks. Tracks actual deposit collection against requirements — used by Finance to identify at-risk group blocks with outstanding deposits."
    - name: "avg_attrition_pct"
      expr: AVG(CAST(attrition_pct AS DOUBLE))
      comment: "Average attrition percentage across active group blocks. Measures the average contractual attrition allowance — used by Revenue Management to assess group pickup risk and displacement cost."
    - name: "avg_wash_pct"
      expr: AVG(CAST(wash_pct AS DOUBLE))
      comment: "Average wash percentage across active group blocks. Tracks the average expected room block reduction — used by Revenue Management to refine group revenue forecasts."
    - name: "repeat_group_blocks"
      expr: COUNT(CASE WHEN repeat_group_flag = TRUE THEN guest_group_block_id END)
      comment: "Number of group blocks from repeat group customers. Measures group loyalty and repeat business rate — used by Sales to evaluate group account retention performance."
    - name: "vip_group_blocks"
      expr: COUNT(CASE WHEN vip_flag = TRUE THEN guest_group_block_id END)
      comment: "Number of group blocks with VIP designation. Tracks high-priority group volume requiring elevated service — used by Guest Relations and Operations for VIP group resource planning."
    - name: "distinct_group_leaders"
      expr: COUNT(DISTINCT group_leader_profile_id)
      comment: "Number of distinct group leader profiles across active blocks. Measures the breadth of the group customer base — used by Sales to identify key group accounts for relationship management."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`guest_preference`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest preference capture and fulfilment metrics used to measure personalisation programme depth, preference data quality, and service delivery against stated guest needs. Used by Guest Experience, CRM, and Operations leadership to drive personalisation strategy and ADA compliance."
  source: "`travel_hospitality_ecm`.`guest`.`preference`"
  filter: preference_status = 'ACTIVE'
  dimensions:
    - name: "preference_category"
      expr: preference_category
      comment: "High-level category of the preference (e.g. Room, Dining, Amenity, Communication) — primary segmentation axis for preference portfolio analysis."
    - name: "preference_type"
      expr: preference_type
      comment: "Specific type of preference within the category — used for granular preference distribution analysis."
    - name: "preference_source"
      expr: preference_source
      comment: "Source through which the preference was captured (e.g. Reservation, Stay, CRM, Loyalty) — used to evaluate preference capture channel effectiveness."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Status of preference fulfilment (e.g. FULFILLED, PENDING, FAILED) — used to track operational delivery against guest preferences."
    - name: "is_ada_requirement"
      expr: is_ada_requirement
      comment: "Indicates whether the preference is an ADA (Americans with Disabilities Act) accessibility requirement — used to ensure mandatory accommodation compliance."
    - name: "is_allergy"
      expr: is_allergy
      comment: "Indicates whether the preference is an allergy — used to track allergy-related preferences requiring mandatory fulfilment for guest safety."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Indicates whether the preference is mandatory (must be fulfilled) — used to prioritise operational fulfilment queues."
    - name: "loyalty_tier_at_capture"
      expr: loyalty_tier_at_capture
      comment: "Loyalty tier of the guest when the preference was captured — used to analyse preference depth by loyalty segment."
    - name: "preference_status"
      expr: preference_status
      comment: "Current status of the preference record — used to filter and monitor active vs. expired preference data."
  measures:
    - name: "total_active_preferences"
      expr: COUNT(1)
      comment: "Total number of active guest preference records. Baseline KPI for personalisation data depth — used by CRM to measure the richness of the guest preference database."
    - name: "distinct_guests_with_preferences"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct guest profiles with at least one active preference. Measures personalisation programme coverage of the guest base — used to identify guests with no preference data for targeted capture campaigns."
    - name: "fulfilled_preferences"
      expr: COUNT(CASE WHEN fulfillment_status = 'FULFILLED' THEN preference_id END)
      comment: "Number of preferences that have been successfully fulfilled. Tracks operational delivery against guest expectations — a key driver of guest satisfaction and loyalty."
    - name: "unfulfilled_mandatory_preferences"
      expr: COUNT(CASE WHEN is_mandatory = TRUE AND fulfillment_status != 'FULFILLED' THEN preference_id END)
      comment: "Number of mandatory preferences that have not been fulfilled. Critical operational risk KPI — unfulfilled mandatory preferences (especially ADA and allergies) represent service failures and potential liability."
    - name: "ada_requirement_preferences"
      expr: COUNT(CASE WHEN is_ada_requirement = TRUE THEN preference_id END)
      comment: "Number of active ADA accessibility requirement preferences. Tracks the volume of legally mandated accommodation needs — used by Operations and Compliance to ensure ADA obligations are met."
    - name: "allergy_preferences"
      expr: COUNT(CASE WHEN is_allergy = TRUE THEN preference_id END)
      comment: "Number of active allergy-related preferences. Tracks guest allergy data volume — used by F&B and Housekeeping to ensure safety-critical preferences are captured and communicated."
    - name: "consent_given_preferences"
      expr: COUNT(CASE WHEN consent_given = TRUE THEN preference_id END)
      comment: "Number of preference records where explicit consent was given for data use. Measures the lawfully processable preference dataset — used by Legal and CRM to govern personalisation data usage."
    - name: "avg_preference_value"
      expr: AVG(CAST(preference_value AS DOUBLE))
      comment: "Average numeric preference value (e.g. room temperature, floor level) across applicable preferences. Used to understand central tendency of quantitative guest preferences for property configuration decisions."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`guest_corporate_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corporate account portfolio metrics tracking contracted revenue targets, credit exposure, and programme eligibility across the corporate client base. Used by Sales, Finance, and Revenue Management leadership to manage corporate account performance and risk."
  source: "`travel_hospitality_ecm`.`guest`.`corporate_account`"
  filter: account_status = 'ACTIVE'
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Type of corporate account (e.g. Negotiated, Preferred, Government) — primary segmentation axis for corporate portfolio analysis."
    - name: "account_status"
      expr: account_status
      comment: "Current status of the corporate account — used to filter active vs. inactive accounts in pipeline analysis."
    - name: "vip_tier"
      expr: vip_tier
      comment: "VIP tier assigned to the corporate account — used to segment accounts by service level and revenue importance."
    - name: "rate_program_type"
      expr: rate_program_type
      comment: "Type of rate programme associated with the account (e.g. LNR, GDS, Direct) — used to analyse rate programme mix and channel strategy."
    - name: "credit_currency_code"
      expr: credit_currency_code
      comment: "Currency of the credit limit — used for multi-currency credit exposure reporting."
    - name: "loyalty_program_eligible"
      expr: loyalty_program_eligible
      comment: "Indicates whether the corporate account is eligible for the loyalty programme — used to track loyalty programme penetration of the corporate base."
    - name: "mice_eligible"
      expr: mice_eligible
      comment: "Indicates whether the account is eligible for MICE (Meetings, Incentives, Conferences, Exhibitions) business — used to segment the corporate base for group and events sales targeting."
    - name: "direct_billing_enabled"
      expr: direct_billing_enabled
      comment: "Indicates whether direct billing is enabled for the account — used to track direct billing programme adoption and associated credit risk."
    - name: "contract_start_year"
      expr: YEAR(contract_start_date)
      comment: "Year the corporate contract started — used for contract vintage analysis and renewal pipeline management."
  measures:
    - name: "total_active_corporate_accounts"
      expr: COUNT(1)
      comment: "Total number of active corporate accounts. Baseline KPI for the corporate client portfolio size — used by Sales leadership to track account base growth."
    - name: "total_annual_revenue_target"
      expr: SUM(CAST(annual_revenue_target AS DOUBLE))
      comment: "Total annual revenue target across all active corporate accounts. Represents the contracted corporate revenue commitment — used by Sales and Finance for corporate revenue forecasting and quota management."
    - name: "avg_annual_revenue_target"
      expr: AVG(CAST(annual_revenue_target AS DOUBLE))
      comment: "Average annual revenue target per corporate account. Measures the average account value — used to segment accounts by size and prioritise sales resource allocation."
    - name: "total_credit_limit_exposure"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all active corporate accounts. Measures aggregate credit exposure — used by Finance to monitor and manage corporate credit risk."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage across active corporate accounts. Tracks the average rate concession given to corporate clients — used by Revenue Management to assess corporate rate dilution impact."
    - name: "loyalty_eligible_accounts"
      expr: COUNT(CASE WHEN loyalty_program_eligible = TRUE THEN corporate_account_id END)
      comment: "Number of active corporate accounts eligible for the loyalty programme. Tracks loyalty programme penetration of the corporate base — used by Loyalty to identify unenrolled eligible accounts."
    - name: "mice_eligible_accounts"
      expr: COUNT(CASE WHEN mice_eligible = TRUE THEN corporate_account_id END)
      comment: "Number of active corporate accounts eligible for MICE business. Quantifies the MICE-addressable corporate base — used by Events Sales to size the group business opportunity within the corporate portfolio."
    - name: "direct_billing_accounts"
      expr: COUNT(CASE WHEN direct_billing_enabled = TRUE THEN corporate_account_id END)
      comment: "Number of active corporate accounts with direct billing enabled. Tracks direct billing programme adoption — used by Finance to manage billing operations and credit exposure."
    - name: "contracts_expiring_within_90_days"
      expr: COUNT(CASE WHEN contract_end_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN corporate_account_id END)
      comment: "Number of active corporate accounts with contracts expiring within the next 90 days. Critical pipeline management KPI — used by Sales to prioritise contract renewal activity and prevent revenue leakage."
$$;