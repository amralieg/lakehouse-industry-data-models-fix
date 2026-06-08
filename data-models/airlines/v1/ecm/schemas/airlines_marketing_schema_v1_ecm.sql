-- Schema for Domain: marketing | Business: Airlines | Version: v1_ecm
-- Generated on: 2026-05-07 12:58:07

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `airlines_ecm`.`marketing` COMMENT 'Customer engagement, marketing campaigns, market research, brand management, customer satisfaction surveys, NPS tracking, digital marketing channels, and commercial analytics supporting passenger acquisition and retention strategies';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `airlines_ecm`.`marketing`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Unique identifier for the marketing campaign. Primary key.',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Product-focused campaigns promoting specific aircraft types (new fleet introductions, premium cabin launches, fleet modernization announcements) require linking campaign records to aircraft types for ',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to finance.budget_plan. Business justification: Campaigns are planned within annual marketing budgets. Linking enables budget vs. actual variance analysis, budget control workflows, and financial planning integration—core to airline marketing finan',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Campaign manager is an employee responsible for campaign execution, budget management, and performance reporting. Airlines track campaign ownership for accountability, resource allocation, and perform',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Route-specific marketing campaigns require origin station context for budget allocation, performance measurement, and regional market targeting. Airlines run station-specific campaigns for route launc',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Airlines engage external agencies (creative, media buying, PR, production) for campaigns. Tracking the primary vendor enables spend reconciliation, performance evaluation, contract compliance, and ven',
    `parent_campaign_id` BIGINT COMMENT 'Self-referencing FK on campaign (parent_campaign_id)',
    `actual_end_date` DATE COMMENT 'Actual date when the campaign execution concluded, which may differ from the planned end date due to performance or strategic decisions.',
    `actual_start_date` DATE COMMENT 'Actual date when the campaign execution commenced, which may differ from the planned start date due to operational adjustments.',
    `approval_date` DATE COMMENT 'Date when the campaign received final approval to proceed, marking the transition from planning to execution readiness.',
    `approval_status` STRING COMMENT 'Current state of campaign approval workflow, indicating whether the campaign has received necessary business and compliance approvals.. Valid values are `pending|approved|rejected|revision_required`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who granted final approval for the campaign to proceed to execution.',
    `booking_class_restriction` STRING COMMENT 'Specific fare booking classes (RBD - Revenue Booking Designator) eligible for the campaign offer, controlling inventory availability and revenue management.',
    `booking_window_end` DATE COMMENT 'Latest date when customers can make bookings under this campaign, controlling the purchase period for promotional offers.',
    `booking_window_start` DATE COMMENT 'Earliest date when customers can make bookings under this campaign, controlling the purchase period for promotional offers.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total allocated budget for the campaign, representing the financial resources committed to execution across all channels and activities.',
    `budget_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget amount, ensuring consistent financial reporting across multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `cabin_class_focus` STRING COMMENT 'Target cabin class or service tier that the campaign emphasizes, aligning with airline product segmentation.. Valid values are `economy|premium_economy|business|first|all`',
    `campaign_code` STRING COMMENT 'Externally-known unique business identifier for the campaign, used in tracking URLs, promotional materials, and cross-system references.. Valid values are `^[A-Z0-9]{6,20}$`',
    `campaign_description` STRING COMMENT 'Detailed narrative description of the campaign purpose, strategy, target audience, and expected business outcomes.',
    `campaign_name` STRING COMMENT 'Human-readable name of the marketing campaign as displayed in reporting and campaign management systems.',
    `campaign_status` STRING COMMENT 'Current lifecycle state of the campaign, indicating its operational readiness and execution phase.. Valid values are `draft|approved|active|paused|completed|cancelled`',
    `campaign_type` STRING COMMENT 'Primary channel or medium through which the campaign is executed. [ENUM-REF-CANDIDATE: email|digital|social|sem|seo|display|out_of_home|print|tv|radio|co_branded|partnership|sponsorship — promote to reference product]. Valid values are `email|digital|social|sem|seo|display`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the campaign record was first created in the system, supporting audit trail and lifecycle tracking.',
    `creative_theme` STRING COMMENT 'Overarching creative concept or messaging theme used across campaign assets, ensuring brand consistency and message coherence.',
    `ffp_tier_focus` STRING COMMENT 'Target loyalty program tier for the campaign, enabling differentiated messaging and offers based on customer lifetime value and engagement.. Valid values are `all|base|silver|gold|platinum|elite`',
    `gds_distribution_flag` BOOLEAN COMMENT 'Indicates whether the campaign includes distribution through GDS channels (Amadeus, Sabre, Travelport) for travel agency visibility.',
    `iata_season` STRING COMMENT 'IATA-defined scheduling season (summer or winter) during which the campaign is active, aligning with airline operational planning cycles.. Valid values are `summer|winter`',
    `modified_by` STRING COMMENT 'Identifier of the user or system that last modified the campaign record, supporting accountability and audit requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the campaign record was last updated, supporting change tracking and data quality monitoring.',
    `objective` STRING COMMENT 'Primary business goal of the campaign, defining the intended outcome and success criteria.. Valid values are `acquisition|retention|upsell|reactivation|awareness|engagement`',
    `origin_destination_focus` STRING COMMENT 'Specific route or city-pair that the campaign promotes, using IATA airport codes or route identifiers (e.g., JFK-LHR, LAX-NRT).',
    `owning_team` STRING COMMENT 'Marketing team or business unit responsible for the campaign strategy, execution, and performance management.',
    `partner_airline_code` STRING COMMENT 'IATA two-letter or ICAO three-letter airline code for any partner airline involved in a co-branded or joint marketing campaign.. Valid values are `^[A-Z0-9]{2,3}$`',
    `planned_end_date` DATE COMMENT 'Scheduled date when the campaign is intended to conclude, as defined during campaign planning.',
    `planned_start_date` DATE COMMENT 'Scheduled date when the campaign is intended to begin execution, as defined during campaign planning.',
    `promotional_offer` STRING COMMENT 'Description of the specific offer, discount, or incentive featured in the campaign, such as bonus miles, fare discounts, or upgrade opportunities.',
    `target_audience_segment` STRING COMMENT 'Specific customer segment or persona that the campaign is designed to engage, based on behavioral, demographic, or value-based segmentation.',
    `target_market` STRING COMMENT 'Geographic or demographic market segment that the campaign is designed to reach, such as specific countries, regions, or customer segments.',
    `travel_date_range_end` DATE COMMENT 'Latest travel date for which bookings made under this campaign are valid, defining the travel window for promotional offers.',
    `travel_date_range_start` DATE COMMENT 'Earliest travel date for which bookings made under this campaign are valid, defining the travel window for promotional offers.',
    CONSTRAINT pk_campaign PRIMARY KEY(`campaign_id`)
) COMMENT 'Master record for all marketing campaigns executed by the airline, including acquisition campaigns, retention campaigns, seasonal promotions, route launch campaigns, and brand awareness initiatives. Captures campaign name, type (email, digital, OOH, print, social, SEM/SEO, co-branded), objective (acquisition, retention, upsell, reactivation), target market, origin-destination focus, cabin class focus, planned start and end dates, actual start and end dates, campaign status (draft, active, paused, completed, cancelled), owning marketing team, budget allocation, currency, campaign manager, approval status, and associated IATA season. This is the authoritative master entity for all marketing campaign definitions in the airline.';

CREATE OR REPLACE TABLE `airlines_ecm`.`marketing`.`campaign_execution` (
    `campaign_execution_id` BIGINT COMMENT 'Unique identifier for the campaign execution record. Primary key.',
    `audience_segment_id` BIGINT COMMENT 'Reference to the customer segment targeted by this execution. Defines the population of passengers or prospects who received the campaign.',
    `campaign_id` BIGINT COMMENT 'Reference to the parent marketing campaign that this execution belongs to.',
    `channel_id` BIGINT COMMENT 'Reference to the specific channel configuration used for this execution, including platform credentials and settings.',
    `digital_campaign_creative_id` BIGINT COMMENT 'Foreign key linking to marketing.digital_campaign_creative. Business justification: campaign_execution currently has creative_version_id (BIGINT) which should reference the specific creative used in the execution. Normalizing to digital_campaign_creative_id FK to marketing.digital_ca',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Campaign executions are deployed at specific stations for local market reach (airport advertising, regional media buys, station-based events). Real business process: tracking which executions ran in w',
    `retry_campaign_execution_id` BIGINT COMMENT 'Self-referencing FK on campaign_execution (retry_campaign_execution_id)',
    `ab_test_variant` STRING COMMENT 'The test variant identifier for this execution if part of an A/B or multivariate test (e.g., A, B, C, or control). Null if not part of a test.. Valid values are `^[A-Z]$|control`',
    `actual_end_timestamp` TIMESTAMP COMMENT 'The actual date and time when the campaign execution deployment completed, whether successfully or with errors.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'The actual date and time when the campaign execution deployment began. May differ from scheduled time due to operational factors.',
    `attributed_revenue_amount` DECIMAL(18,2) COMMENT 'The total revenue attributed to conversions from this campaign execution, based on the attribution model defined for the campaign.',
    `attributed_revenue_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for the attributed revenue amount.. Valid values are `^[A-Z]{3}$`',
    `bounce_rate_percent` DECIMAL(18,2) COMMENT 'The percentage of sent messages that bounced, calculated as (bounced_count / send_volume) * 100.',
    `bounced_count` BIGINT COMMENT 'The number of messages that bounced (hard or soft) and were not delivered to the intended recipient.',
    `channel_type` STRING COMMENT 'The marketing channel through which this campaign execution was deployed (email, SMS, push notification, display ad, social media post, paid search).. Valid values are `email|sms|push_notification|display_ad|social_media|paid_search`',
    `click_through_rate_percent` DECIMAL(18,2) COMMENT 'The percentage of delivered messages that received at least one click, calculated as (clicked_count / delivered_count) * 100. Key performance indicator for engagement.',
    `clicked_count` BIGINT COMMENT 'The number of unique recipients who clicked on at least one link or call-to-action within the message.',
    `contacts_reached` BIGINT COMMENT 'The actual number of contacts successfully reached by this execution. May be less than target due to invalid addresses, opt-outs, or delivery failures.',
    `conversion_rate_percent` DECIMAL(18,2) COMMENT 'The percentage of delivered messages that resulted in a conversion, calculated as (converted_count / delivered_count) * 100.',
    `converted_count` BIGINT COMMENT 'The number of recipients who completed the desired conversion action (booking, purchase, enrollment) attributed to this execution.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this campaign execution record was first created in the system.',
    `delivered_count` BIGINT COMMENT 'The number of messages successfully delivered to recipient inboxes or devices without bounce or rejection.',
    `delivery_rate_percent` DECIMAL(18,2) COMMENT 'The percentage of sent messages that were successfully delivered, calculated as (delivered_count / send_volume) * 100.',
    `deployment_platform` STRING COMMENT 'The marketing automation or channel platform used to deploy this execution (e.g., Salesforce Marketing Cloud, Adobe Campaign, Google Ads, Facebook Ads Manager).',
    `error_count` BIGINT COMMENT 'The total number of errors encountered during execution deployment, including system errors, validation failures, and integration issues.',
    `error_message` STRING COMMENT 'Detailed error message or log summary describing any failures or issues encountered during execution. Null if execution completed without errors.',
    `execution_cost_amount` DECIMAL(18,2) COMMENT 'The total cost incurred for this campaign execution, including platform fees, send costs, and creative production costs.',
    `execution_cost_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for the execution cost amount.. Valid values are `^[A-Z]{3}$`',
    `execution_name` STRING COMMENT 'Human-readable name describing this specific execution instance, typically including channel and segment information.',
    `execution_number` STRING COMMENT 'Business identifier for this campaign execution, unique within the campaign context. Used for operational tracking and reporting.. Valid values are `^[A-Z0-9]{8,20}$`',
    `execution_status` STRING COMMENT 'Current lifecycle status of the campaign execution. Tracks progression from draft through deployment to completion or failure.. Valid values are `draft|scheduled|in_progress|completed|failed|cancelled`',
    `external_execution_reference` STRING COMMENT 'The execution identifier from the external deployment platform, used for reconciliation and detailed drill-down in the source system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this campaign execution record was last updated, reflecting status changes or metric updates.',
    `open_rate_percent` DECIMAL(18,2) COMMENT 'The percentage of delivered messages that were opened, calculated as (opened_count / delivered_count) * 100.',
    `opened_count` BIGINT COMMENT 'The number of unique recipients who opened the message. Applicable primarily to email and push notification channels.',
    `scheduled_timestamp` TIMESTAMP COMMENT 'The planned date and time when this campaign execution was scheduled to be deployed to the target audience.',
    `send_volume` BIGINT COMMENT 'The total number of messages sent during this execution. May include retries and multiple sends to the same contact.',
    `target_audience_size` BIGINT COMMENT 'The total number of contacts (passengers or prospects) in the audience segment targeted for this execution.',
    `unsubscribe_rate_percent` DECIMAL(18,2) COMMENT 'The percentage of delivered messages that resulted in an unsubscribe, calculated as (unsubscribed_count / delivered_count) * 100.',
    `unsubscribed_count` BIGINT COMMENT 'The number of recipients who opted out or unsubscribed from future communications as a result of this execution.',
    CONSTRAINT pk_campaign_execution PRIMARY KEY(`campaign_execution_id`)
) COMMENT 'Transactional record capturing the actual execution and deployment of a marketing campaign across a specific channel and audience segment. Tracks execution date, channel used (email, push notification, SMS, display ad, social media post, paid search), audience segment targeted, number of contacts reached, deployment status, send volume, delivery rate, bounce rate, open rate, click-through rate (CTR), conversion rate, unsubscribe rate, and execution errors. Links to the parent campaign and the channel definition. Represents the operational heartbeat of campaign delivery — one campaign may have multiple execution records across channels and time windows.';

CREATE OR REPLACE TABLE `airlines_ecm`.`marketing`.`campaign_response` (
    `campaign_response_id` BIGINT COMMENT 'Unique identifier for the campaign response record. Primary key.',
    `ancillary_order_id` BIGINT COMMENT 'Foreign key linking to ancillary.order. Business justification: Campaign responses that convert to ancillary purchases need direct attribution for campaign ROI measurement. Real business need to link marketing responses to resulting ancillary orders for conversion',
    `campaign_execution_id` BIGINT COMMENT 'Reference to the specific campaign execution that generated this response.',
    `profile_id` BIGINT COMMENT 'Reference to the authenticated passenger profile who responded. Null for anonymous visitors.',
    `pnr_id` BIGINT COMMENT 'Foreign key linking to reservation.pnr. Business justification: Campaign responses that result in bookings must be linked to the PNR for campaign ROI measurement and attribution. This FK enables tracking of marketing campaign effectiveness. Removes redundant booki',
    `pricing_record_id` BIGINT COMMENT 'Foreign key linking to revenue.pricing_record. Business justification: Tracks which campaign interactions led to specific pricing quotes, critical for conversion funnel analysis and measuring campaign effectiveness at quote stage. Airlines analyze quote-to-book conversio',
    `ticket_id` BIGINT COMMENT 'Foreign key linking to revenue.ticket. Business justification: Direct conversion tracking - links campaign engagement events to actual ticket purchases for attribution modeling. Airlines measure which campaign responses result in bookings for ROI calculation and ',
    `prior_campaign_response_id` BIGINT COMMENT 'Self-referencing FK on campaign_response (prior_campaign_response_id)',
    `ab_test_variant` STRING COMMENT 'Identifier for the A/B test variant or creative version that generated this response (e.g., variant_a, variant_b, control).',
    `anonymous_visitor_reference` STRING COMMENT 'Anonymous identifier for non-authenticated interactions, typically a browser cookie or device fingerprint.',
    `attributed_revenue_amount` DECIMAL(18,2) COMMENT 'Revenue amount attributed to this campaign response if a booking conversion occurred. Null for non-conversion responses.',
    `attributed_revenue_currency` STRING COMMENT 'Three-letter ISO currency code for the attributed revenue amount.. Valid values are `^[A-Z]{3}$`',
    `browser` STRING COMMENT 'Web browser used for the response interaction (e.g., Chrome, Safari, Firefox, Edge).',
    `call_to_action` STRING COMMENT 'Specific call-to-action element that was clicked or engaged with (e.g., Book Now, Learn More, View Deals).',
    `channel` STRING COMMENT 'Digital marketing channel through which the response was captured: email, sms, push (push notification), web (website), mobile_app, social_media.. Valid values are `email|sms|push|web|mobile_app|social_media`',
    `city` STRING COMMENT 'City name derived from IP geolocation or user profile indicating the geographic location of the response.',
    `complaint_type` STRING COMMENT 'Type of complaint registered if response_type is complaint: spam, inappropriate_content, frequency (too many emails), other.. Valid values are `spam|inappropriate_content|frequency|other`',
    `conversion_flag` BOOLEAN COMMENT 'Boolean indicator whether this response resulted in a booking conversion (True) or not (False).',
    `country_code` STRING COMMENT 'Three-letter ISO country code derived from IP geolocation or user profile indicating where the response originated.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign response record was first created in the system, in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `device_type` STRING COMMENT 'Type of device used for the response interaction.. Valid values are `desktop|mobile|tablet|unknown`',
    `email_client` STRING COMMENT 'Email client application used to open the email (e.g., Outlook, Gmail, Apple Mail). Applicable for email channel responses.',
    `engagement_score` DECIMAL(18,2) COMMENT 'Calculated engagement score for this response based on interaction depth, time spent, and actions taken. Scale 0-100.',
    `form_data` STRING COMMENT 'JSON or delimited string containing form field data submitted if response_type is form_submission. Null otherwise.',
    `ip_address` STRING COMMENT 'IP address of the device at the time of response, used for geographic attribution and fraud detection.',
    `landing_page_url` STRING COMMENT 'Full URL of the landing page where the user arrived after clicking through from the campaign.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign response record was last modified, in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `operating_system` STRING COMMENT 'Operating system of the device used for the response (e.g., iOS, Android, Windows, macOS).',
    `referrer_url` STRING COMMENT 'URL of the page that referred the user to the landing page, if available.',
    `response_timestamp` TIMESTAMP COMMENT 'Exact date and time when the response action occurred, in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `response_type` STRING COMMENT 'Type of response action taken by the recipient: click (link click), open (email open), conversion (booking completed), unsubscribe (opt-out), complaint (spam report), form_submission (lead capture).. Valid values are `click|open|conversion|unsubscribe|complaint|form_submission`',
    `session_reference` STRING COMMENT 'Web or app session identifier linking multiple interactions within the same user session.',
    `time_to_conversion_seconds` STRING COMMENT 'Number of seconds elapsed between the campaign send time and the conversion event. Null for non-conversion responses.',
    `unsubscribe_reason` STRING COMMENT 'Reason provided by the user for unsubscribing, if response_type is unsubscribe. Null otherwise.',
    `utm_campaign` STRING COMMENT 'UTM campaign parameter identifying the specific campaign name or code.',
    `utm_content` STRING COMMENT 'UTM content parameter used to differentiate similar content or links within the same campaign (e.g., A/B test variants).',
    `utm_medium` STRING COMMENT 'UTM medium parameter identifying the marketing medium (e.g., email, cpc, social).',
    `utm_source` STRING COMMENT 'UTM source parameter identifying the traffic source (e.g., newsletter, facebook, google).',
    CONSTRAINT pk_campaign_response PRIMARY KEY(`campaign_response_id`)
) COMMENT 'Transactional record capturing individual passenger or prospect responses to a marketing campaign, including click events, form submissions, booking conversions, call-to-action completions, and opt-outs. Stores response type (click, open, conversion, unsubscribe, complaint), response timestamp, channel, campaign execution reference, passenger profile reference (where known), anonymous visitor identifier (for non-authenticated interactions), device type, geographic location, and attributed revenue where a booking conversion occurred. Enables attribution modelling and campaign ROI measurement at the individual response level.';

CREATE OR REPLACE TABLE `airlines_ecm`.`marketing`.`audience_segment` (
    `audience_segment_id` BIGINT COMMENT 'Unique identifier for the audience segment. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Segment creator is an employee responsible for segment definition, targeting criteria, and performance validation. Airlines track segment ownership for accountability, methodology validation, and camp',
    `parent_audience_segment_id` BIGINT COMMENT 'Self-referencing FK on audience_segment (parent_audience_segment_id)',
    `activation_date` DATE COMMENT 'Date when this segment was first activated and made available for campaign use.',
    `audience_segment_description` STRING COMMENT 'Extended business description of the segment, its purpose, and intended use cases.',
    `audience_segment_status` STRING COMMENT 'Current lifecycle status of the segment: active (in use), inactive (paused), draft (under development), archived (historical reference), or deprecated (replaced by newer segment).. Valid values are `active|inactive|draft|archived|deprecated`',
    `business_objective` STRING COMMENT 'Strategic business goal this segment supports (e.g., Increase premium cabin bookings, Reduce churn of high-value customers, Drive ancillary revenue).',
    `campaign_count` STRING COMMENT 'Number of marketing campaigns that have used this segment (lifetime count).',
    `consent_required_flag` BOOLEAN COMMENT 'Indicates whether explicit passenger consent is required to include them in this segment for marketing purposes.',
    `data_source` STRING COMMENT 'Primary data source(s) used to build this segment (e.g., Amadeus Altéa PSS, Oracle Loyalty Cloud, SAP S/4HANA, Third-party data provider).',
    `deactivation_date` DATE COMMENT 'Date when this segment was deactivated or archived. Null if currently active.',
    `definition_criteria` STRING COMMENT 'Detailed textual description of the rules or criteria that define membership in this segment (e.g., Passengers who flew business class 3+ times in last 12 months on transatlantic routes).',
    `derivation_method` STRING COMMENT 'Method used to derive segment membership: rule-based (SQL/business rules), ML clustering (unsupervised learning), ML classification (supervised model), manual upload (CSV import), or third-party (external data provider).. Valid values are `rule_based|ml_clustering|ml_classification|manual_upload|third_party`',
    `exclusion_criteria` STRING COMMENT 'Rules defining which passengers should be explicitly excluded from this segment (e.g., Passengers who opted out of marketing, Employees, VIP blacklist).',
    `gdpr_compliant_flag` BOOLEAN COMMENT 'Indicates whether this segment definition and its data processing comply with GDPR requirements for EU passengers.',
    `geographic_scope` STRING COMMENT 'Geographic coverage of the segment (e.g., Global, North America, EMEA, APAC, USA, GBR). Use ISO 3166-1 alpha-3 country codes where applicable.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the segment definition (criteria, name, or configuration) was last modified.',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Timestamp when the segment membership was last recalculated and the segment_size was last updated.',
    `loyalty_tier_filter` STRING COMMENT 'Loyalty tier(s) included in this segment if loyalty-tier-based (e.g., Gold, Platinum, Silver|Gold). Null if not loyalty-based.',
    `max_rfm_score` STRING COMMENT 'Maximum RFM score threshold for inclusion in this segment if RFM-based. Null if not RFM-based.',
    `min_rfm_score` STRING COMMENT 'Minimum RFM score threshold for inclusion in this segment if RFM-based. Null if not RFM-based.',
    `model_code` STRING COMMENT 'Identifier of the ML model used to generate this segment if derivation_method is ML-based. Null for rule-based segments.',
    `model_version` STRING COMMENT 'Version number of the ML model used. Null for rule-based segments.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this segment definition.',
    `next_refresh_date` DATE COMMENT 'Scheduled date for the next segment membership refresh. Null for on-demand or static segments.',
    `owning_team` STRING COMMENT 'Name of the marketing team or business unit responsible for maintaining and using this segment (e.g., Loyalty Marketing, Regional EMEA, Revenue Management).',
    `performance_metric` STRING COMMENT 'Key performance indicator used to measure the effectiveness of campaigns targeting this segment (e.g., Conversion Rate, Revenue per Passenger (RPP), Click-Through Rate (CTR)).',
    `refresh_frequency` STRING COMMENT 'How often the segment membership is recalculated: real-time (streaming), daily, weekly, monthly, quarterly, on-demand (manual trigger), or static (one-time definition). [ENUM-REF-CANDIDATE: real_time|daily|weekly|monthly|quarterly|on_demand|static — 7 candidates stripped; promote to reference product]',
    `route_affinity` STRING COMMENT 'Specific route networks or city pairs this segment has affinity for (e.g., Transatlantic, Domestic US, Asia-Pacific long-haul). Null if not route-specific.',
    `segment_code` STRING COMMENT 'Short alphanumeric code used to reference the segment in campaigns and operational systems.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `segment_name` STRING COMMENT 'Human-readable name of the audience segment (e.g., High-Value Transatlantic Travellers, Lapsed Frequent Flyers, Business Class Prospects).',
    `segment_size` BIGINT COMMENT 'Number of unique passengers currently assigned to this segment (last calculated count).',
    `segment_type` STRING COMMENT 'Classification of the segment methodology: behavioural (based on past actions), demographic (age, gender, income), geographic (region, country, route), psychographic (lifestyle, values), RFM-based (Recency Frequency Monetary analysis), or loyalty tier-based (FFP status).. Valid values are `behavioural|demographic|geographic|psychographic|rfm_based|loyalty_tier_based`',
    `tags` STRING COMMENT 'Comma-separated list of tags or labels for categorization and search (e.g., premium, retention, acquisition, seasonal).',
    `target_channel` STRING COMMENT 'Primary marketing channels where this segment is intended to be used (e.g., email, mobile app push, digital display, direct mail). Pipe-separated if multiple.',
    `creation_date` DATE COMMENT 'Date when this segment definition was first created.',
    CONSTRAINT pk_audience_segment PRIMARY KEY(`audience_segment_id`)
) COMMENT 'Master record defining named passenger audience segments used for targeted marketing. Captures segment name, segment type (behavioural, demographic, geographic, psychographic, RFM-based, loyalty tier-based, route affinity), definition criteria (rule-based or ML-derived), segment size (last calculated), refresh frequency, active status, owning team, creation date, and last refresh timestamp. Segments are reusable across multiple campaigns and channels. Examples include High-Value Transatlantic Travellers, Lapsed Frequent Flyers, Business Class Prospects, and Price-Sensitive Leisure Travellers. Distinct from passenger.traveller_segment which is the passenger-level assignment; this entity defines the segment itself.';

CREATE OR REPLACE TABLE `airlines_ecm`.`marketing`.`segment_membership` (
    `segment_membership_id` BIGINT COMMENT 'Unique identifier for the segment membership record. Primary key for the segment membership association entity.',
    `audience_segment_id` BIGINT COMMENT 'Reference to the marketing audience segment to which the passenger belongs. Links to the segment definition entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user or analyst who manually assigned the passenger to this segment. Null for automated assignments. Supports audit trail and accountability.',
    `profile_id` BIGINT COMMENT 'Reference to the individual passenger profile who is a member of this segment. Links to the passenger master data entity.',
    `superseded_segment_membership_id` BIGINT COMMENT 'Self-referencing FK on segment_membership (superseded_segment_membership_id)',
    `assignment_confidence_score` DECIMAL(18,2) COMMENT 'Confidence score for machine learning-derived segment memberships, ranging from 0.0000 to 1.0000. Higher values indicate greater model confidence in the segment assignment. Null for rule-based or manual assignments.',
    `assignment_reason_code` STRING COMMENT 'Code indicating the specific business rule, model feature, or trigger that caused the passenger to be assigned to this segment. Supports explainability and audit requirements.',
    `assignment_reason_description` STRING COMMENT 'Human-readable explanation of why the passenger was assigned to this segment. Provides business context for the assignment decision.',
    `assignment_source` STRING COMMENT 'The mechanism or system that assigned the passenger to this segment. Rule engine indicates criteria-based assignment, ML model indicates predictive model assignment, manual override indicates analyst intervention, batch import indicates bulk upload, api integration indicates external system assignment, campaign response indicates behavioral trigger.. Valid values are `rule_engine|ml_model|manual_override|batch_import|api_integration|campaign_response`',
    `assignment_timestamp` TIMESTAMP COMMENT 'The precise date and time when the segment membership record was created in the system. Represents the system record creation time, distinct from the business-effective membership start date.',
    `campaign_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this segment membership makes the passenger eligible for targeted marketing campaigns. False may indicate suppression due to opt-out, regulatory restrictions, or business rules.',
    `data_source_system` STRING COMMENT 'The operational system or platform that originated this segment membership record. Examples include Oracle Loyalty Cloud, Amadeus Altéa, Sabre AirVision, internal segmentation engine.',
    `last_campaign_contact_date` DATE COMMENT 'The most recent date when the passenger was contacted as part of a campaign targeting this segment. Used for frequency capping and contact optimization.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The most recent date and time when this segment membership record was modified. Supports change tracking and audit requirements.',
    `membership_end_date` DATE COMMENT 'The date when the passenger exited this segment. Null if the passenger is currently an active member of the segment. Represents the effective-until date for segment membership.',
    `membership_start_date` DATE COMMENT 'The date when the passenger became a member of this segment. Represents the effective-from date for segment membership.',
    `membership_status` STRING COMMENT 'Current lifecycle status of the segment membership. Active indicates the passenger is currently in the segment, inactive indicates membership has ended, expired indicates time-bound membership has lapsed, suspended indicates temporary removal from segment.. Valid values are `active|inactive|expired|suspended`',
    `notes` STRING COMMENT 'Free-text field for additional context, comments, or special instructions related to this segment membership. Used by marketing analysts for documentation and collaboration.',
    `opt_out_flag` BOOLEAN COMMENT 'Indicates whether the passenger has opted out of marketing communications for this specific segment. True indicates opt-out, false indicates consent to receive segment-targeted communications.',
    `priority_rank` STRING COMMENT 'Ranking of this segment membership relative to other segments the passenger belongs to. Lower numbers indicate higher priority. Used for campaign targeting when a passenger qualifies for multiple segments.',
    `segment_entry_channel` STRING COMMENT 'The marketing channel or touchpoint that triggered the passengers entry into this segment. Examples include web, mobile app, email campaign, call center, airport kiosk, social media.',
    `segment_exit_reason` STRING COMMENT 'Reason code or description explaining why the passenger exited this segment. Examples include criteria no longer met, manual removal, segment sunset, passenger churn, data quality issue.',
    `segment_version` STRING COMMENT 'Version identifier of the segment definition at the time of assignment. Enables tracking of segment membership against evolving segment criteria and supports retrospective attribution analysis.',
    `total_campaign_responses` STRING COMMENT 'Cumulative count of campaign responses (clicks, conversions, bookings) attributed to this segment membership. Supports segment performance measurement and ROI analysis.',
    `total_campaigns_received` STRING COMMENT 'Cumulative count of marketing campaigns the passenger has received while being a member of this segment. Supports frequency analysis and campaign fatigue monitoring.',
    CONSTRAINT pk_segment_membership PRIMARY KEY(`segment_membership_id`)
) COMMENT 'Association entity linking individual passenger profiles to audience segments, capturing the dynamic membership of passengers within marketing segments. Stores passenger profile reference, segment reference, membership start date, membership end date (null if currently active), membership source (rule engine, ML model, manual override), confidence score for ML-derived memberships, and the segment version at time of assignment. Enables point-in-time segment membership queries for campaign targeting and retrospective attribution. Complements passenger.traveller_segment by providing the full historical membership log rather than just the current classification.';

CREATE OR REPLACE TABLE `airlines_ecm`.`marketing`.`channel` (
    `channel_id` BIGINT COMMENT 'Unique identifier for the marketing channel. Primary key.',
    `parent_channel_id` BIGINT COMMENT 'Self-referencing FK on channel (parent_channel_id)',
    `activation_date` DATE COMMENT 'Date when this marketing channel was first activated and made available for campaign use.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this marketing channel is currently active and available for campaign execution. Inactive channels are retained for historical reporting.',
    `attribution_window_days` STRING COMMENT 'Number of days after channel interaction during which conversions are attributed to this channel for marketing attribution analysis.',
    `channel_category` STRING COMMENT 'Strategic classification of the channel as owned (airline-controlled), paid (purchased media), or earned (organic/viral).. Valid values are `owned|paid|earned`',
    `channel_code` STRING COMMENT 'Unique business identifier code for the marketing channel used across campaign systems and reporting platforms.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `channel_description` STRING COMMENT 'Detailed description of the marketing channel, including its purpose, target audience characteristics, and typical use cases for campaign delivery.',
    `channel_name` STRING COMMENT 'Human-readable name of the marketing channel used for passenger engagement and campaign delivery.',
    `channel_type` STRING COMMENT 'Classification of the marketing channel by delivery mechanism. [ENUM-REF-CANDIDATE: email|sms|push_notification|in_app_message|social_media|paid_search|display_advertising|ooh|direct_mail|airport_digital_signage|ife_advertising|call_centre|web_banner|retargeting|affiliate|partnership — promote to reference product]. Valid values are `email|sms|push_notification|in_app_message|social_media|paid_search`',
    `consent_framework` STRING COMMENT 'Primary regulatory consent framework governing the use of this channel for marketing purposes. [ENUM-REF-CANDIDATE: gdpr|casl|can_spam|ccpa|lgpd|none|pecr|pipeda|appi — promote to reference product]. Valid values are `gdpr|casl|can_spam|ccpa|lgpd|none`',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for channel costs.. Valid values are `^[A-Z]{3}$`',
    `cost_model` STRING COMMENT 'Pricing model for this channel: CPM (Cost Per Mille/thousand impressions), CPC (Cost Per Click), CPA (Cost Per Acquisition), fixed fee, hybrid, or free (owned channels).. Valid values are `cpm|cpc|cpa|fixed|hybrid|free`',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard cost per unit of the cost model (e.g., cost per thousand impressions for CPM, cost per click for CPC). Null for free or fixed-fee channels.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this marketing channel record was first created in the system.',
    `data_retention_days` STRING COMMENT 'Number of days that campaign interaction data (opens, clicks, conversions) is retained for this channel, per regulatory and internal data governance policies.',
    `deactivation_date` DATE COMMENT 'Date when this marketing channel was deactivated and removed from active campaign use. Null for currently active channels.',
    `deactivation_reason` STRING COMMENT 'Business reason for deactivating this channel (e.g., poor performance, vendor contract termination, regulatory changes, strategic shift). Null for active channels.',
    `double_opt_in_required_flag` BOOLEAN COMMENT 'Indicates whether double opt-in (confirmation of consent) is required for this channel to comply with regulatory or internal policy requirements.',
    `external_agency_name` STRING COMMENT 'Name of the external marketing agency managing this channel, if applicable. Null for internally-managed channels.',
    `ffp_integration_flag` BOOLEAN COMMENT 'Indicates whether this channel is integrated with the airlines Frequent Flyer Program for targeted loyalty member communications.',
    `frequency_cap_enabled_flag` BOOLEAN COMMENT 'Indicates whether frequency capping (limiting the number of messages per customer per time period) is enabled for this channel to prevent over-communication.',
    `geographic_availability` STRING COMMENT 'Geographic markets or regions where this channel is available for campaign delivery (e.g., global, specific country codes, regional groupings).',
    `integration_status` STRING COMMENT 'Current technical integration status of the channel with airline marketing systems and customer data platforms.. Valid values are `active|inactive|testing|deprecated|pending`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this marketing channel record was last updated.',
    `max_frequency_per_day` STRING COMMENT 'Maximum number of messages allowed per customer per day through this channel when frequency capping is enabled. Null if no daily cap applies.',
    `max_frequency_per_week` STRING COMMENT 'Maximum number of messages allowed per customer per week through this channel when frequency capping is enabled. Null if no weekly cap applies.',
    `opt_in_required_flag` BOOLEAN COMMENT 'Indicates whether explicit customer consent (opt-in) is required before using this channel for marketing communications.',
    `owner_team` STRING COMMENT 'Internal business unit or team responsible for managing and operating this marketing channel.',
    `personalization_capability` STRING COMMENT 'Level of message personalization supported by this channel: none (broadcast only), basic (name/segment), advanced (behavioral), or dynamic (real-time).. Valid values are `none|basic|advanced|dynamic`',
    `platform_name` STRING COMMENT 'Name of the technology platform or vendor system used to deliver campaigns through this channel (e.g., Salesforce Marketing Cloud, Braze, Google Ads).',
    `platform_vendor` STRING COMMENT 'Name of the vendor or service provider that operates the platform for this channel.',
    `pnr_integration_flag` BOOLEAN COMMENT 'Indicates whether this channel is integrated with the Passenger Service System to enable booking-triggered and journey-based communications.',
    `reach_potential` STRING COMMENT 'Estimated audience reach potential of this channel: high (millions of passengers), medium (hundreds of thousands), or low (targeted segments).. Valid values are `high|medium|low`',
    `real_time_capability_flag` BOOLEAN COMMENT 'Indicates whether this channel supports real-time or near-real-time message delivery for time-sensitive campaigns (e.g., flight delay notifications, flash sales).',
    `sla_delivery_time_minutes` STRING COMMENT 'Contractual or expected maximum time in minutes from campaign trigger to message delivery for this channel. Used for operational and time-sensitive campaigns.',
    `tracking_capability` STRING COMMENT 'Level of campaign performance tracking available for this channel: full (impressions, clicks, conversions), partial (limited metrics), or none.. Valid values are `full|partial|none`',
    CONSTRAINT pk_channel PRIMARY KEY(`channel_id`)
) COMMENT 'Reference master defining all marketing and communication channels available to the airline for passenger engagement and campaign delivery. Captures channel name, channel type (email, SMS, push notification, in-app message, social media, paid search, display advertising, OOH, direct mail, airport digital signage, IFE advertising, call centre), channel owner (internal team or external agency), platform or vendor name, integration status, opt-in requirement flag, regulatory consent framework applicable (GDPR, CASL, CAN-SPAM), cost model (CPM, CPC, CPA, fixed), and active status. Provides the authoritative taxonomy of channels used across all campaign executions.';

CREATE OR REPLACE TABLE `airlines_ecm`.`marketing`.`communication_preference` (
    `communication_preference_id` BIGINT COMMENT 'Unique identifier for the communication preference record. Primary key.',
    `profile_id` BIGINT COMMENT 'Reference to the passenger (Pax) whose communication preferences are captured in this record. Links to the passenger master entity.',
    `superseded_communication_preference_id` BIGINT COMMENT 'Self-referencing FK on communication_preference (superseded_communication_preference_id)',
    `channel_type` STRING COMMENT 'The communication channel through which marketing messages are delivered to the passenger. Includes digital and traditional channels.. Valid values are `email|sms|push_notification|postal_mail|phone|in_app`',
    `communication_category` STRING COMMENT 'The type of marketing communication content. Distinct from operational notifications which are governed separately. Categories include promotional offers, flight deals, loyalty program updates, travel inspiration content, partner offers, and survey invitations.. Valid values are `promotional_offers|flight_deals|loyalty_updates|travel_inspiration|partner_offers|survey_invitations`',
    `consent_expiry_date` DATE COMMENT 'The date on which the passengers marketing consent expires and must be re-confirmed. Null if consent does not expire. Used in jurisdictions requiring periodic consent renewal.',
    `consent_version` STRING COMMENT 'Version identifier of the consent language and terms presented to the passenger at the time of opt-in. Enables tracking of consent under different privacy policy versions for regulatory compliance.',
    `contact_count` STRING COMMENT 'The cumulative number of marketing messages sent to the passenger via this channel and category combination since opt-in. Used for frequency capping and engagement analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this communication preference record was first created in the system. Part of the audit trail for regulatory compliance.',
    `data_source` STRING COMMENT 'Identifier of the upstream data source or system that provided this communication preference record. Used for data lineage, reconciliation, and troubleshooting.',
    `double_opt_in_confirmed` BOOLEAN COMMENT 'Indicates whether the passenger has confirmed their opt-in through a double opt-in process (e.g., clicking a confirmation link in an email). True indicates confirmed, False indicates pending confirmation or single opt-in only.',
    `frequency_preference` STRING COMMENT 'Passenger-stated preference for how frequently they wish to receive marketing communications in this category and channel. Used to throttle message delivery and respect customer engagement preferences.. Valid values are `daily|weekly|monthly|quarterly|as_available`',
    `global_unsubscribe_flag` BOOLEAN COMMENT 'Indicates whether the passenger has opted out of ALL marketing communications across all channels and categories. True indicates global opt-out, False indicates channel/category-specific preferences apply.',
    `ip_address_at_consent` STRING COMMENT 'The IP address from which the passenger provided their marketing consent. Captured for audit trail and fraud prevention purposes. May be considered PII in some jurisdictions.',
    `jurisdiction` STRING COMMENT 'Three-letter ISO country code representing the legal jurisdiction under which this consent was collected. Determines applicable privacy regulations (GDPR for EU, CCPA for California, etc.).. Valid values are `^[A-Z]{3}$`',
    `language_preference` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the passengers preferred language for receiving marketing communications. Ensures messages are delivered in the passengers language of choice.. Valid values are `^[a-z]{2}$`',
    `last_contact_timestamp` TIMESTAMP COMMENT 'The date and time when the passenger was last contacted via this channel and category combination. Used to enforce frequency preferences and prevent over-communication.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this communication preference record was last updated. Tracks the most recent change to any field in the record for audit and compliance purposes.',
    `opt_in_source` STRING COMMENT 'The touchpoint or channel through which the passenger provided their marketing communication consent. Captures the origin of the opt-in action for audit and compliance purposes. [ENUM-REF-CANDIDATE: web|mobile_app|call_centre|airport_kiosk|booking_flow|loyalty_enrollment|third_party — 7 candidates stripped; promote to reference product]',
    `opt_in_status` BOOLEAN COMMENT 'Indicates whether the passenger has opted in to receive marketing communications for this channel and category combination. True indicates consent granted, False indicates consent not granted or withdrawn.',
    `opt_in_timestamp` TIMESTAMP COMMENT 'The date and time when the passenger granted consent to receive marketing communications for this channel and category. Null if passenger has never opted in.',
    `opt_out_timestamp` TIMESTAMP COMMENT 'The date and time when the passenger withdrew consent or opted out of receiving marketing communications for this channel and category. Null if passenger has not opted out.',
    `preference_source_system` STRING COMMENT 'The operational system of record that captured or last updated this communication preference. Examples include Amadeus Altea PSS, Oracle Loyalty Cloud, airline website, mobile app. Used for data lineage and troubleshooting.',
    `preference_status` STRING COMMENT 'Current lifecycle status of the communication preference record. Active indicates the preference is in effect and should be honored by marketing suppression logic. Inactive indicates the preference is no longer valid. Suspended indicates temporary hold. Expired indicates the consent period has lapsed.. Valid values are `active|inactive|suspended|expired`',
    `suppression_reason` STRING COMMENT 'Free-text field capturing the reason why a passenger opted out or why their preference was suppressed. Used for customer service, analytics, and continuous improvement of marketing programs.',
    `third_party_sharing_consent` BOOLEAN COMMENT 'Indicates whether the passenger has consented to sharing their contact information with third-party partners for marketing purposes. True indicates consent granted, False indicates consent not granted.',
    `user_agent_at_consent` STRING COMMENT 'The browser user agent string captured at the time of consent. Used for audit trail and to understand the device/platform context of the opt-in.',
    CONSTRAINT pk_communication_preference PRIMARY KEY(`communication_preference_id`)
) COMMENT 'Master record capturing a passengers stated marketing communication preferences and opt-in/opt-out status per channel and communication type. Stores passenger profile reference, channel type, communication category (promotional offers, flight deals, loyalty updates, travel inspiration, partner offers, survey invitations, operational notifications), opt-in status, opt-in timestamp, opt-out timestamp, opt-in source (web, app, call centre, airport kiosk), consent version, and jurisdiction. Distinct from passenger.consent which covers broader data privacy consent; this entity specifically governs marketing communication preferences and is the SSOT for marketing suppression logic.';

CREATE OR REPLACE TABLE `airlines_ecm`.`marketing`.`nps_survey` (
    `nps_survey_id` BIGINT COMMENT 'Unique identifier for the NPS survey programme. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key reference to the broader marketing or customer experience campaign that this survey programme supports. Nullable if the survey is standalone.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Survey creator is an employee responsible for survey design, deployment, and data quality. Airlines track survey ownership for accountability, methodology validation, and performance measurement. Deno',
    `superseded_nps_survey_id` BIGINT COMMENT 'Self-referencing FK on nps_survey (superseded_nps_survey_id)',
    `active_status` STRING COMMENT 'Current operational status of the survey programme: active (currently distributing), inactive (ended), paused (temporarily suspended), draft (not yet launched), or archived (historical record).. Valid values are `active|inactive|paused|draft|archived`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this survey programme record was first created in the system.',
    `data_retention_days` STRING COMMENT 'The number of days that individual survey response data is retained before anonymization or deletion, in compliance with data protection regulations and internal data governance policies.',
    `distribution_channel` STRING COMMENT 'The channel through which the survey is delivered to passengers: email, SMS, mobile app push notification, web portal, inflight WiFi portal, airport kiosk, IVR (Interactive Voice Response), or paper form. [ENUM-REF-CANDIDATE: email|sms|mobile_app|web_portal|inflight_wifi|kiosk|ivr|paper — 8 candidates stripped; promote to reference product]',
    `estimated_completion_minutes` STRING COMMENT 'The estimated time in minutes required for a respondent to complete the survey, communicated to passengers to set expectations.',
    `iata_season_code` STRING COMMENT 'The IATA seasonal schedule period associated with this survey programme (e.g., S24 for Summer 2024, W23 for Winter 2023/24), used to align survey timing with route network planning cycles.. Valid values are `^(S|W)[0-9]{2}$`',
    `incentive_description` STRING COMMENT 'Description of the incentive offered to survey respondents (e.g., 500 bonus FFP miles, Entry into monthly prize draw for 2 free tickets). Nullable if no incentive is offered.',
    `incentive_offered` BOOLEAN COMMENT 'Boolean flag indicating whether this survey programme offers an incentive for completion (e.g., FFP miles, prize draw entry, discount voucher).',
    `last_modified_by_user` STRING COMMENT 'The user ID or name of the person who most recently modified this survey programme record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this survey programme record was most recently updated.',
    `owning_team` STRING COMMENT 'The business unit or team responsible for managing this survey programme (e.g., Customer Experience, Marketing Analytics, Product Management).',
    `privacy_notice_version` STRING COMMENT 'Version identifier of the privacy notice and data protection disclosure presented to survey respondents, ensuring GDPR and regulatory compliance.. Valid values are `^v[0-9]+.[0-9]+$`',
    `question_count` STRING COMMENT 'The total number of questions in the survey instrument, used to estimate completion time and response burden.',
    `response_target_count` STRING COMMENT 'The target number of completed survey responses the programme aims to collect for statistical validity and business insight.',
    `response_window_days` STRING COMMENT 'The number of days after the trigger event during which the survey remains open for passenger response (e.g., 7 days post-flight).',
    `sampling_rate_percent` DECIMAL(18,2) COMMENT 'The percentage of eligible passengers who are randomly selected to receive the survey (e.g., 10.00 means 10% of eligible passengers are surveyed). Used to manage survey volume and avoid over-surveying.',
    `survey_close_date` DATE COMMENT 'The date when this survey programme ends and stops distributing new surveys. Nullable for ongoing programmes.',
    `survey_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the survey programme for operational reference and reporting (e.g., NPS_PF_2024Q1, CSAT_LNG).. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `survey_instrument_version` STRING COMMENT 'Version identifier of the survey questionnaire and question set (e.g., v1.0, v2.3) to track changes in survey design over time and ensure comparability of results.. Valid values are `^v[0-9]+.[0-9]+(.[0-9]+)?$`',
    `survey_language_codes` STRING COMMENT 'Comma-separated list of ISO 639-1 two-letter language codes in which this survey is available (e.g., EN,FR,DE,ES,ZH) to support multilingual passenger base.',
    `survey_name` STRING COMMENT 'Business-friendly name of the NPS or customer satisfaction survey programme (e.g., Post-Flight NPS Q1 2024, Lounge Experience CSAT).',
    `survey_open_date` DATE COMMENT 'The date when this survey programme becomes active and begins distributing surveys to eligible passengers.',
    `survey_type` STRING COMMENT 'Classification of the survey methodology: transactional NPS (post-event), relational NPS (periodic brand health), CSAT (Customer Satisfaction Score), CES (Customer Effort Score), or custom survey format.. Valid values are `transactional_nps|relational_nps|csat|ces|custom`',
    `survey_url_template` STRING COMMENT 'The URL template or base link for the online survey instrument, with placeholders for personalization tokens (e.g., passenger ID, flight number). Used for email and digital distribution.',
    `survey_vendor` STRING COMMENT 'Name of the third-party survey platform or vendor used to administer this survey (e.g., Qualtrics, Medallia, SurveyMonkey, In-house Platform).',
    `survey_vendor_programme_code` STRING COMMENT 'The unique identifier assigned by the survey vendor platform to this survey programme, used for integration and data retrieval from the vendor system.',
    `target_audience_criteria` STRING COMMENT 'Business rules defining which passengers or customer segments are eligible to receive this survey (e.g., All passengers on long-haul flights, FFP Gold and Platinum members, Business class passengers on transatlantic routes).',
    `trigger_event` STRING COMMENT 'The customer touchpoint or business event that triggers distribution of this survey (e.g., post-flight, post-check-in, post-lounge-visit, post-contact-centre-interaction, periodic brand survey). [ENUM-REF-CANDIDATE: post_flight|post_checkin|post_lounge_visit|post_contact_centre|post_booking|post_baggage_claim|periodic|custom — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_nps_survey PRIMARY KEY(`nps_survey_id`)
) COMMENT 'Master record defining Net Promoter Score (NPS) and customer satisfaction survey programmes deployed by the airline. Captures survey name, survey type (transactional NPS post-flight, relational NPS, CSAT, CES — Customer Effort Score), trigger event (post-flight, post-check-in, post-lounge-visit, post-contact-centre-interaction), target audience criteria, survey instrument version, distribution channel, survey open and close dates, response target, active status, owning team, and associated IATA season or campaign. Provides the master definition for all passenger satisfaction measurement programmes.';

CREATE OR REPLACE TABLE `airlines_ecm`.`marketing`.`survey_response` (
    `survey_response_id` BIGINT COMMENT 'Unique identifier for the survey response record. Primary key.',
    `ancillary_order_id` BIGINT COMMENT 'Foreign key linking to ancillary.order. Business justification: NPS and satisfaction surveys often reference specific ancillary purchases (seat comfort, baggage handling, lounge experience) for service quality measurement. Real business need to link survey feedbac',
    `flight_leg_id` BIGINT COMMENT 'Reference to the specific flight leg for transactional NPS or post-flight surveys. Null for non-flight-specific surveys.',
    `nps_survey_id` BIGINT COMMENT 'Reference to the survey instrument or campaign that this response belongs to.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: NPS surveys capture origin station-specific feedback for airport experience quality measurement and station performance benchmarking. Airlines analyze satisfaction scores by departure station to ident',
    `profile_id` BIGINT COMMENT 'Reference to the authenticated passenger profile who submitted this response. Null for anonymous responses.',
    `superseded_survey_response_id` BIGINT COMMENT 'Self-referencing FK on survey_response (superseded_survey_response_id)',
    `anonymous_token` STRING COMMENT 'Unique token for unauthenticated survey responses to prevent duplicate submissions while preserving anonymity. MD5 hash format.. Valid values are `^[a-f0-9]{32}$`',
    `cabin_class` STRING COMMENT 'Cabin class flown by the passenger for the associated flight leg. Used for segmented satisfaction analysis.. Valid values are `First|Business|Premium Economy|Economy`',
    `ces_score` STRING COMMENT 'Customer effort score measuring ease of experience, typically on a 1-7 scale. Lower scores indicate less effort required.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this survey response record was first created in the system. Used for data lineage and audit purposes.',
    `csat_score` STRING COMMENT 'Customer satisfaction score, typically on a 1-5 scale. Measures satisfaction with specific service touchpoint.',
    `destination_airport_code` STRING COMMENT 'Three-letter IATA airport code for the destination of the flight leg associated with this response.. Valid values are `^[A-Z]{3}$`',
    `device_type` STRING COMMENT 'Type of device used to complete the survey. Used for channel optimization and user experience analysis.. Valid values are `Desktop|Mobile|Tablet|IFE|Kiosk|Unknown`',
    `ffp_tier` STRING COMMENT 'Loyalty program tier of the passenger at the time of response. Used to analyze satisfaction by customer value segment.. Valid values are `None|Silver|Gold|Platinum|Diamond`',
    `flight_date` DATE COMMENT 'Scheduled departure date of the flight leg for which feedback was provided. Used to link response to operational performance.',
    `incentive_offered` BOOLEAN COMMENT 'Boolean flag indicating whether an incentive (miles, discount, entry to prize draw) was offered for survey completion.',
    `incentive_type` STRING COMMENT 'Type of incentive offered for survey completion: frequent flyer miles, discount voucher, prize draw entry, or none.. Valid values are `Miles|Discount|Prize Draw|None`',
    `ip_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code derived from respondent IP address. Used for geographic analysis of response patterns.. Valid values are `^[A-Z]{3}$`',
    `is_verified_passenger` BOOLEAN COMMENT 'Boolean flag indicating whether the respondent was verified as an actual passenger on the referenced flight through PNR or booking validation.',
    `nps_category` STRING COMMENT 'Classification of the NPS score: Promoter (9-10), Passive (7-8), or Detractor (0-6).. Valid values are `Promoter|Passive|Detractor`',
    `nps_score` STRING COMMENT 'Numeric score from 0 to 10 indicating likelihood to recommend the airline. Core metric for NPS calculation.',
    `origin_airport_code` STRING COMMENT 'Three-letter IATA airport code for the origin of the flight leg associated with this response.. Valid values are `^[A-Z]{3}$`',
    `pnr` STRING COMMENT 'Six-character alphanumeric Passenger Name Record associated with the booking for which feedback was provided. Links response to specific travel transaction.. Valid values are `^[A-Z0-9]{6}$`',
    `response_channel` STRING COMMENT 'Channel through which the survey response was submitted: email link, mobile app, in-flight entertainment system, SMS, web portal, or airport kiosk.. Valid values are `Email|Mobile App|IFE|SMS|Web Portal|Kiosk`',
    `response_language` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the language in which the survey was completed.. Valid values are `^[A-Z]{3}$`',
    `response_time_seconds` STRING COMMENT 'Time elapsed in seconds from survey invitation to submission. Used to identify rushed or thoughtful responses.',
    `response_timestamp` TIMESTAMP COMMENT 'Date and time when the passenger submitted the survey response. Recorded in UTC.',
    `route_type` STRING COMMENT 'Classification of the route as domestic, international, or regional. Used for market segmentation analysis.. Valid values are `Domestic|International|Regional`',
    `sentiment_category` STRING COMMENT 'Categorical classification of sentiment derived from verbatim feedback: Positive, Neutral, Negative, or Mixed.. Valid values are `Positive|Neutral|Negative|Mixed`',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Automated sentiment analysis score derived from verbatim feedback, ranging from -1.0 (very negative) to +1.0 (very positive).',
    `service_recovery_triggered` BOOLEAN COMMENT 'Boolean flag indicating whether this response triggered an automated service recovery workflow due to low satisfaction score or negative sentiment.',
    `survey_completion_rate` DECIMAL(18,2) COMMENT 'Percentage of survey questions completed by the respondent. Used to assess response quality and engagement.',
    `survey_sent_timestamp` TIMESTAMP COMMENT 'Date and time when the survey invitation was sent to the passenger. Used to calculate response time.',
    `survey_version` STRING COMMENT 'Version identifier of the survey instrument used. Tracks survey design changes over time for longitudinal analysis.',
    `topic_tags` STRING COMMENT 'Comma-separated list of topics identified in verbatim feedback through text analytics (e.g., baggage, crew, punctuality, cleanliness).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this survey response record was last updated. Used for change tracking and audit purposes.',
    `verbatim_feedback` STRING COMMENT 'Open-text feedback provided by the passenger in their own words. Used for qualitative analysis and sentiment mining.',
    CONSTRAINT pk_survey_response PRIMARY KEY(`survey_response_id`)
) COMMENT 'Transactional record capturing an individual passengers response to an NPS, CSAT, or CES survey. Stores survey reference, passenger profile reference (where authenticated), anonymous respondent token (for unauthenticated responses), flight leg reference (for transactional NPS), response timestamp, NPS score (0-10), NPS category (Promoter, Passive, Detractor), CSAT score, CES score, verbatim open-text feedback, language of response, response channel (email link, in-app, IFE, SMS), cabin class flown, route, and whether the response triggered a service recovery workflow. The authoritative transactional record for all passenger satisfaction measurement data.';

CREATE OR REPLACE TABLE `airlines_ecm`.`marketing`.`market_research_study` (
    `market_research_study_id` BIGINT COMMENT 'Unique identifier for the market research study. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: market_research_study should link to the campaign that commissioned or will use the research findings. Research studies are often conducted to inform specific campaign strategies or measure campaign e',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Commissioning manager is an employee responsible for research scope, budget approval, and strategic alignment. Airlines track research ownership for accountability, budget control, and strategic decis',
    `follow_up_market_research_study_id` BIGINT COMMENT 'Self-referencing FK on market_research_study (follow_up_market_research_study_id)',
    `actual_cost` DECIMAL(18,2) COMMENT 'The actual total cost incurred for conducting the market research study upon completion.',
    `agency_contact_email` STRING COMMENT 'Email address of the primary contact at the external research agency.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `agency_contact_name` STRING COMMENT 'Primary contact person at the external research agency responsible for the study execution.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The total budget allocated or approved for the market research study, including agency fees, incentives, and other costs.',
    `business_objective` STRING COMMENT 'The primary business objective or strategic question that the market research study was designed to address, such as route viability assessment, brand perception improvement, or competitive positioning.',
    `commissioning_department` STRING COMMENT 'The internal department or business unit that commissioned or requested the market research study, such as Marketing, Commercial Strategy, Revenue Management, or Network Planning.',
    `confidentiality_level` STRING COMMENT 'The data classification or confidentiality level assigned to the study findings and report, governing access and distribution.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this market research study record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget and cost amounts.. Valid values are `^[A-Z]{3}$`',
    `data_collection_channel` STRING COMMENT 'The channel or medium through which research data was collected, such as online survey, telephone interview, in-person focus group, mobile app, email, or social media.',
    `external_agency_name` STRING COMMENT 'Name of the external market research agency or consulting firm contracted to conduct the study, if applicable. Null if conducted internally.',
    `fieldwork_end_date` DATE COMMENT 'The date when data collection or fieldwork activities concluded for the study.',
    `fieldwork_start_date` DATE COMMENT 'The date when data collection or fieldwork activities began for the study.',
    `geographic_scope` STRING COMMENT 'The geographic coverage or market scope of the study, such as specific countries, regions, or global. May include multiple IATA country codes or region descriptors.',
    `key_findings_summary` STRING COMMENT 'High-level summary of the key findings, insights, and conclusions from the market research study. Provides strategic intelligence for decision-making.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this market research study record was last updated or modified.',
    `market_research_study_status` STRING COMMENT 'Current lifecycle status of the market research study. Indicates whether the study is planned, in fieldwork phase, under analysis, completed, cancelled, or on hold.. Valid values are `planned|fieldwork|analysis|completed|cancelled|on_hold`',
    `report_document_url` STRING COMMENT 'URL or file path to the final research report document stored in the enterprise document management system.',
    `research_methodology` STRING COMMENT 'The research approach or methodology employed for the study, such as quantitative survey, qualitative focus group, ethnographic research, secondary desk research, mixed methods, or conjoint analysis.. Valid values are `quantitative_survey|qualitative_focus_group|ethnographic|secondary_desk_research|mixed_methods|conjoint_analysis`',
    `response_rate_percent` DECIMAL(18,2) COMMENT 'The percentage of invited participants who completed the survey or participated in the research, calculated as (completed responses / total invitations) * 100.',
    `sample_size` STRING COMMENT 'The planned or actual number of respondents or participants included in the research study.',
    `strategic_priority` STRING COMMENT 'The strategic importance or priority level assigned to this research study by the commissioning team or executive leadership.. Valid values are `high|medium|low`',
    `study_code` STRING COMMENT 'Unique business identifier or reference code assigned to the study for tracking and reporting purposes.. Valid values are `^[A-Z]{2,4}-[0-9]{4}-[A-Z0-9]{2,6}$`',
    `study_end_date` DATE COMMENT 'The date when the market research study was completed, including final analysis and reporting.',
    `study_name` STRING COMMENT 'The official name or title of the market research study as commissioned by the marketing or commercial team.',
    `study_start_date` DATE COMMENT 'The date when the market research study officially commenced, including planning or fieldwork initiation.',
    `study_type` STRING COMMENT 'The category or type of market research study. Examples include brand tracking, competitive benchmarking, route demand study, passenger needs assessment, concept testing, pricing sensitivity analysis, conjoint analysis, and customer satisfaction research.. Valid values are `brand_tracking|competitive_benchmarking|route_demand_study|passenger_needs_assessment|concept_testing|pricing_sensitivity`',
    `target_demographic` STRING COMMENT 'Description of the target population or demographic segment for the research study, such as business travelers, leisure passengers, millennials, frequent flyers, or specific FFP tier members.',
    CONSTRAINT pk_market_research_study PRIMARY KEY(`market_research_study_id`)
) COMMENT 'Master record for formal market research studies commissioned or conducted by the airlines marketing and commercial teams. Captures study name, study type (brand tracking, competitive benchmarking, route demand study, passenger needs assessment, concept testing, pricing sensitivity, conjoint analysis), research methodology (quantitative survey, qualitative focus group, ethnographic, secondary desk research), geographic scope, target demographic, commissioning team, external research agency name, study start and end dates, status (planned, fieldwork, analysis, completed), and key findings summary. Provides the authoritative register of all market intelligence activities.';

CREATE OR REPLACE TABLE `airlines_ecm`.`marketing`.`brand_asset` (
    `brand_asset_id` BIGINT COMMENT 'Unique identifier for the brand asset record. Primary key for the brand asset master data.',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Brand assets (photography, video, 3D renders) of specific aircraft types are catalogued with type metadata for digital asset management, rights tracking, creative reuse, and brand compliance. Standard',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Brand asset approval requires employee authorization for brand compliance, legal clearance, and usage rights. Airlines track approver identity for audit trails, brand governance, and regulatory compli',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: brand_asset currently has campaign_code (STRING) which is a denormalized reference. Normalizing to campaign_id FK to marketing.campaign.campaign_id. Brand assets are often created for specific campaig',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Brand assets (photography, video, design) are produced by external creative agencies and production vendors. Airlines track producing vendor for IP/licensing management, usage rights verification, qua',
    `derived_from_brand_asset_id` BIGINT COMMENT 'Self-referencing FK on brand_asset (derived_from_brand_asset_id)',
    `approval_date` DATE COMMENT 'Date when the brand asset received final approval and became authorized for use. Key milestone in the asset lifecycle.',
    `approval_status` STRING COMMENT 'Current approval state of the brand asset within the creative governance workflow. Determines whether the asset is authorized for production use.. Valid values are `draft|pending_review|approved|rejected|archived|expired`',
    `archive_date` DATE COMMENT 'Date when the brand asset was archived or retired from active use. Supports lifecycle management and historical tracking.',
    `archive_reason` STRING COMMENT 'Explanation for why the brand asset was archived. Examples include campaign completion, brand refresh, regulatory change, or asset obsolescence.',
    `asset_code` STRING COMMENT 'Unique business identifier or catalog code for the brand asset. Used for external reference and cross-system integration.. Valid values are `^[A-Z0-9]{6,20}$`',
    `asset_description` STRING COMMENT 'Detailed textual description of the brand asset content, purpose, and intended use cases. Supports search and discovery within the asset library.',
    `asset_format` STRING COMMENT 'File format or media type of the brand asset. Determines compatibility with production systems and distribution channels. [ENUM-REF-CANDIDATE: pdf|jpg|png|svg|mp4|mov|ai|psd|eps|indd — 10 candidates stripped; promote to reference product]',
    `asset_name` STRING COMMENT 'Human-readable name or title of the brand asset. Used for identification and search within the digital asset management system.',
    `asset_type` STRING COMMENT 'Classification of the brand asset by its creative format and purpose. Determines usage context and approval workflows. Additional types include advertising creative, social media template, IFE (In-Flight Entertainment) branding, and uniform specification.. Valid values are `logo|livery_specification|brand_guideline_document|photography|video|infographic`',
    `brand_programme` STRING COMMENT 'Name of the overarching brand programme or strategic initiative to which this asset belongs. Examples include loyalty programme branding, alliance branding, or sustainability campaigns.',
    `brand_territory` STRING COMMENT 'Geographic or organizational scope of the brand asset. Defines where the asset is authorized for use within the airlines brand architecture.. Valid values are `global|regional|sub_brand|market_specific`',
    `color_profile` STRING COMMENT 'Color space or profile used in the asset. Critical for ensuring color consistency across digital and print production channels.. Valid values are `RGB|CMYK|Pantone|sRGB|Adobe_RGB`',
    `compliance_notes` STRING COMMENT 'Free-text field capturing regulatory compliance considerations, legal review notes, or brand guideline adherence confirmations relevant to the asset.',
    `copyright_holder` STRING COMMENT 'Legal entity or individual holding copyright ownership of the brand asset. Critical for intellectual property management and licensing compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this brand asset record was first created in the system. Audit field for data lineage and governance.',
    `expiry_date` DATE COMMENT 'Date when the brand asset expires or becomes invalid for use. Applicable for time-limited campaigns, seasonal assets, or licensed content with term limits.',
    `file_reference` STRING COMMENT 'Storage location or URI reference to the physical asset file in the digital asset management system or content delivery network.',
    `file_size_mb` DECIMAL(18,2) COMMENT 'Size of the asset file in megabytes. Important for storage planning and distribution bandwidth considerations.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the brand asset is currently active and available for use. Inactive assets are retained for historical reference but not authorized for new deployments.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords or tags for asset categorization and search optimization. Facilitates discovery and retrieval in digital asset management systems.',
    `last_modified_date` DATE COMMENT 'Date when the brand asset file or metadata was last updated. Supports version control and change tracking.',
    `license_type` STRING COMMENT 'Type of license governing the use of the brand asset. Determines legal permissions and restrictions for asset deployment.. Valid values are `proprietary|royalty_free|rights_managed|creative_commons|public_domain`',
    `owning_team` STRING COMMENT 'Name of the marketing team, department, or business unit responsible for the creation, maintenance, and governance of the brand asset.',
    `resolution` STRING COMMENT 'Resolution specification for image or video assets, typically expressed as width x height in pixels or as DPI (dots per inch) for print assets.',
    `territory_code` STRING COMMENT 'Three-letter ISO country code or regional identifier specifying the geographic market for market-specific assets. Empty for global assets.. Valid values are `^[A-Z]{3}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this brand asset record was last modified. Audit field for change tracking and data quality monitoring.',
    `usage_restrictions` STRING COMMENT 'Specific restrictions or prohibitions on asset usage. May include channel restrictions, co-branding limitations, or regulatory constraints.',
    `usage_rights` STRING COMMENT 'Description of authorized usage rights, licensing terms, and distribution permissions for the brand asset. Defines legal boundaries for asset deployment.',
    `version_number` STRING COMMENT 'Version identifier for the brand asset following semantic versioning convention. Tracks iterations and revisions for change control.. Valid values are `^v?[0-9]+.[0-9]+(.[0-9]+)?$`',
    `creation_date` DATE COMMENT 'Date when the brand asset was originally created or produced. Distinct from the date it was registered in the asset management system.',
    CONSTRAINT pk_brand_asset PRIMARY KEY(`brand_asset_id`)
) COMMENT 'Master record for the airlines brand and creative assets managed by the marketing team. Captures asset name, asset type (logo, livery specification, brand guideline document, photography, video, infographic, advertising creative, social media template, IFE branding, uniform specification), format, file reference, version number, brand territory (global, regional, sub-brand), usage rights and restrictions, expiry date, owning team, approval status, and associated campaign or brand programme. Provides the authoritative digital asset register for brand management and creative production governance.';

CREATE OR REPLACE TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` (
    `digital_campaign_creative_id` BIGINT COMMENT 'Unique identifier for the digital campaign creative execution. Primary key for this entity.',
    `ab_test_variant_id` BIGINT COMMENT 'Identifier for the A/B test variant or multivariate test cell this creative belongs to. Enables performance comparison across test groups.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Creative approval requires employee authorization for brand compliance, legal clearance, and campaign readiness. Airlines track approver identity for audit trails, brand governance, and quality contro',
    `brand_asset_id` BIGINT COMMENT 'Foreign key linking to marketing.brand_asset. Business justification: digital_campaign_creative should link to the brand assets used to build the creative. Campaign creatives are constructed from brand-approved assets (logos, images, fonts, color palettes). Adding brand',
    `campaign_id` BIGINT COMMENT 'Reference to the parent marketing campaign to which this creative belongs. Links creative execution to campaign strategy.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Digital creatives (display ads, video, social content) are frequently produced by external creative agencies. Airlines track producing vendor for quality control, revision requests, performance analys',
    `revised_digital_campaign_creative_id` BIGINT COMMENT 'Self-referencing FK on digital_campaign_creative (revised_digital_campaign_creative_id)',
    `accessibility_compliant_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the creative meets accessibility standards (e.g., WCAG 2.1) for users with disabilities.',
    `approval_status` STRING COMMENT 'Current approval workflow status of the creative. Tracks progression through creative review and approval process.. Valid values are `draft|pending_review|approved|rejected|revision_required|archived`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the creative was approved for publication. Captures the moment of final approval in the workflow.',
    `asset_file_path` STRING COMMENT 'File system path or cloud storage location where the creative asset file is stored. Used for asset retrieval and management.',
    `asset_file_size_kb` DECIMAL(18,2) COMMENT 'File size of the creative asset in kilobytes. Important for load time optimization and technical specifications.',
    `body_copy` STRING COMMENT 'Main body text or descriptive content of the creative. Supporting message that elaborates on the headline.',
    `brand_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the creative has been reviewed and confirmed to comply with brand guidelines and standards.',
    `call_to_action_text` STRING COMMENT 'Text displayed on the call-to-action button or link (e.g., Book Now, Learn More, Sign Up). Drives user engagement and conversion.',
    `channel` STRING COMMENT 'Digital marketing channel through which this creative is distributed and displayed to target audiences. [ENUM-REF-CANDIDATE: email|social_media|display_network|search|mobile_app|website|sms|push_notification — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the creative record was first created in the system. Supports audit trail and lifecycle tracking.',
    `creative_code` STRING COMMENT 'Unique business identifier or SKU for the creative asset, used for tracking and cross-system reference.',
    `creative_name` STRING COMMENT 'Human-readable name or title of the creative execution for identification and reporting purposes.',
    `creative_type` STRING COMMENT 'Classification of the creative format or execution type. Defines the medium and technical format of the creative asset. [ENUM-REF-CANDIDATE: banner_ad|rich_media|email_html|landing_page|video_preroll|social_image|social_video|push_notification|display_ad|native_ad — 10 candidates stripped; promote to reference product]',
    `destination_url` STRING COMMENT 'Target landing page or destination URL where users are directed when they click on the creative. Includes tracking parameters.',
    `expiry_date` DATE COMMENT 'Date when the creative is scheduled to expire and stop serving. End of active campaign period. Nullable for evergreen creatives.',
    `format_dimensions` STRING COMMENT 'Technical dimensions or specifications of the creative asset (e.g., 300x250, 728x90, 1920x1080, responsive). Captures size and aspect ratio.',
    `go_live_date` DATE COMMENT 'Date when the creative is scheduled to go live and begin serving to audiences. Start of active campaign period.',
    `headline_copy` STRING COMMENT 'Primary headline or title text displayed in the creative. Main attention-grabbing message for the audience.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the creative is currently active and serving. True if live, false if paused or inactive.',
    `is_high_performer` BOOLEAN COMMENT 'Boolean flag indicating whether this creative has been identified as a high-performing asset based on engagement or conversion metrics.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language of the creative content (e.g., en, es, fr, de).. Valid values are `^[a-z]{2}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the creative record was last modified or updated. Supports change tracking and audit trail.',
    `legal_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the creative has been reviewed and confirmed to comply with legal and regulatory requirements (e.g., advertising standards, consumer protection).',
    `market_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country or market code indicating the target geographic market for this creative (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about the creative. Supports collaboration and documentation.',
    `target_audience_segment` STRING COMMENT 'Description or identifier of the target audience segment this creative is designed for (e.g., business travelers, leisure families, frequent flyers).',
    `created_by` STRING COMMENT 'Name or identifier of the person or team who created the creative asset. Supports asset ownership and accountability.',
    CONSTRAINT pk_digital_campaign_creative PRIMARY KEY(`digital_campaign_creative_id`)
) COMMENT 'Master record for individual digital creative executions (ad units, email templates, landing pages, social posts, push notification copy) associated with marketing campaigns. Captures creative name, creative type (banner ad, rich media, email HTML, landing page, video pre-roll, social image, push copy), associated campaign, channel, format dimensions, headline copy, body copy, call-to-action text, destination URL, A/B test variant identifier, approval status, go-live date, expiry date, and performance flags. Enables creative-level performance attribution and A/B test management distinct from the campaign-level record.';

CREATE OR REPLACE TABLE `airlines_ecm`.`marketing`.`spend` (
    `spend_id` BIGINT COMMENT 'Unique identifier for the marketing spend record. Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Spend approval requires employee authorization for budget commitment, financial controls, and procurement compliance. Airlines track approver identity for audit trails, financial governance, and deleg',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign associated with this spend record.',
    `channel_id` BIGINT COMMENT 'Reference to the marketing channel through which the spend was executed (e.g., digital, social media, print, broadcast).',
    `cost_centre_id` BIGINT COMMENT 'Reference to the cost centre or business unit responsible for this marketing expenditure.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Marketing spend transactions must post to the general ledger for financial consolidation, audit trail, and statutory reporting. Airlines track marketing expenses through GL accounts for IFRS complianc',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Large marketing expenditures (media buys, agency retainers, production) flow through formal POs. Finance requires linking spend records to POs for three-way matching (PO-invoice-receipt), audit trails',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor, agency, or supplier providing the marketing service or media placement.',
    `adjustment_spend_id` BIGINT COMMENT 'Self-referencing FK on spend (adjustment_spend_id)',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'Actual expenditure amount incurred for this marketing activity. Represents the realized cost for ROI calculation and financial reconciliation.',
    `approval_status` STRING COMMENT 'Current approval status of this marketing spend record. Reflects the governance workflow state for spend authorization.. Valid values are `draft|pending_approval|approved|rejected|cancelled`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this marketing spend was approved. Records the moment of authorization for compliance and audit purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this marketing spend record was first created in the system. Provides audit trail for data lineage and record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the spend amounts (e.g., USD, EUR, GBP). Required for multi-currency spend consolidation.. Valid values are `^[A-Z]{3}$`',
    `fiscal_month` STRING COMMENT 'Fiscal month (1-12) to which this marketing spend is attributed. Used for monthly budget tracking and trend analysis.',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter to which this marketing spend is attributed. Used for quarterly budget tracking and seasonal spend analysis.. Valid values are `Q1|Q2|Q3|Q4`',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this marketing spend is attributed. Used for annual budget tracking and year-over-year spend analysis.',
    `invoice_date` DATE COMMENT 'Date the vendor invoice was issued for this marketing spend. Used for accounts payable aging and payment scheduling.',
    `invoice_number` STRING COMMENT 'Vendor invoice number associated with this marketing spend. Used for payment reconciliation and audit trail.',
    `market_region` STRING COMMENT 'Geographic market or region targeted by this marketing spend (e.g., North America, Europe, Asia Pacific). Used for regional spend allocation and market-specific ROI analysis.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this marketing spend record was last modified. Tracks the most recent update for change management and audit purposes.',
    `notes` STRING COMMENT 'Free-text notes or comments about this marketing spend record. Captures additional context, exceptions, or clarifications for audit and review purposes.',
    `passenger_segment` STRING COMMENT 'Target passenger segment for this marketing spend (e.g., business, leisure, premium, economy). Used for segment-specific marketing effectiveness analysis.',
    `payment_due_date` DATE COMMENT 'Date by which payment is due to the vendor for this marketing spend. Used for cash flow planning and vendor relationship management.',
    `payment_status` STRING COMMENT 'Current status of payment processing for this marketing spend. Tracks the spend through the approval and payment lifecycle.. Valid values are `pending|approved|paid|disputed|cancelled`',
    `period_end_date` DATE COMMENT 'End date of the period to which this marketing spend applies. Defines the temporal boundary for spend attribution.',
    `period_start_date` DATE COMMENT 'Start date of the period to which this marketing spend applies. Used for monthly, quarterly, or campaign-specific spend allocation.',
    `planned_spend_amount` DECIMAL(18,2) COMMENT 'Budgeted or planned expenditure amount for this marketing activity. Used for variance analysis against actual spend.',
    `reference_number` STRING COMMENT 'Business identifier or reference code for this marketing spend transaction, used for tracking and reconciliation.',
    `route_group` STRING COMMENT 'Route group or network segment targeted by this marketing spend (e.g., domestic, international, long-haul). Specific to airline marketing spend attribution.',
    `spend_type` STRING COMMENT 'Classification of the marketing expenditure by nature of cost. Determines how the spend is categorized for budget tracking and ROI analysis.. Valid values are `media_buy|agency_fee|production_cost|technology_platform_fee|sponsorship|event_cost`',
    CONSTRAINT pk_spend PRIMARY KEY(`spend_id`)
) COMMENT 'Transactional record capturing actual and planned marketing expenditure at the campaign and channel level. Stores campaign reference, channel reference, spend period (month/quarter), spend type (media buy, agency fee, production cost, technology platform fee, sponsorship, event cost), planned spend amount, actual spend amount, currency, purchase order reference, vendor or agency name, cost centre reference, approval status, and invoice reference. Provides the marketing domains view of spend actuals for campaign ROI calculation and budget tracking. Distinct from finance.general_ledger which holds the accounting entries; this entity provides the marketing-context spend attribution.';

CREATE OR REPLACE TABLE `airlines_ecm`.`marketing`.`sponsorship` (
    `sponsorship_id` BIGINT COMMENT 'Unique identifier for the sponsorship agreement record. Primary key.',
    `lease_contract_id` BIGINT COMMENT 'Foreign key linking to finance.lease_contract. Business justification: Sponsorships involving leased assets (branded aircraft livery, lounge spaces, venue rights) require IFRS 16 lease accounting. Airlines must link sponsorship contracts to lease contracts for right-of-u',
    `partner_organization_id` BIGINT COMMENT 'Foreign key linking to marketing.partner_organization. Business justification: Sponsorship agreements are with partner organizations. Currently, sponsorship duplicates partner_organization_name and partner_organization_type as denormalized strings. Adding partner_organization_id',
    `supply_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supply_contract. Business justification: Major sponsorships (sports teams, venues, events) are multi-year commercial agreements managed as supply contracts with payment schedules, rights packages, deliverables, and renewal terms. Procurement',
    `renewed_sponsorship_id` BIGINT COMMENT 'Self-referencing FK on sponsorship (renewed_sponsorship_id)',
    `activation_status` STRING COMMENT 'Current operational state of the sponsorship: active (rights being exercised), inactive (signed but not yet started), pending (under negotiation), suspended (temporarily paused), expired (term ended), or terminated (cancelled before term end).. Valid values are `active|inactive|pending|suspended|expired|terminated`',
    `annual_value` DECIMAL(18,2) COMMENT 'Average annual monetary value of the sponsorship, calculated by dividing contracted value by term in years.',
    `brand_alignment_score` STRING COMMENT 'Internal assessment score (typically 1-10) measuring how well the sponsorship aligns with the airlines brand values, target demographics, and strategic positioning.',
    `contract_signed_date` DATE COMMENT 'The date when the sponsorship agreement was formally executed by both parties, in yyyy-MM-dd format.',
    `contract_term_months` STRING COMMENT 'Duration of the sponsorship agreement expressed in months, calculated from start to end date.',
    `contracted_value` DECIMAL(18,2) COMMENT 'Total monetary value of the sponsorship agreement over its full term, representing the airlines financial commitment.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this sponsorship record was first created in the system, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the contracted value (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `end_date` DATE COMMENT 'The date when the sponsorship agreement expires and rights cease, in yyyy-MM-dd format. Nullable for open-ended or perpetual agreements.',
    `exclusivity_category` STRING COMMENT 'The product or service category in which the airline holds exclusive sponsorship rights (e.g., official airline, exclusive aviation partner), preventing competitor sponsorships in the same category.',
    `geographic_market` STRING COMMENT 'Primary geographic market or country where the sponsorship has brand visibility and activation, using ISO 3166-1 alpha-3 country code (e.g., USA, GBR, AUS).. Valid values are `^[A-Z]{3}$`',
    `hospitality_entitlement` STRING COMMENT 'Description of hospitality benefits included in the sponsorship, such as number of VIP tickets, suite access, meet-and-greet opportunities, and event passes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this sponsorship record was most recently updated, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `logo_placement_rights` STRING COMMENT 'Specific locations and formats where the airline logo may be displayed (e.g., jersey front, stadium signage, broadcast overlays, digital assets).',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, historical background, or operational notes relevant to the sponsorship management.',
    `owning_commercial_team` STRING COMMENT 'The internal marketing or commercial team responsible for managing the sponsorship relationship, activation planning, and performance tracking.',
    `payment_structure` STRING COMMENT 'The schedule and method by which sponsorship fees are paid to the partner organization.. Valid values are `lump_sum|annual_installments|quarterly_installments|monthly_installments|milestone_based|other`',
    `performance_kpi_description` STRING COMMENT 'Description of the key performance indicators used to measure sponsorship effectiveness, such as brand awareness lift, media impressions, social media engagement, or incremental bookings.',
    `regional_scope` STRING COMMENT 'Geographic reach of the sponsorship activation: local (city/metro), national (single country), regional (multi-country area), or global (worldwide visibility).. Valid values are `local|national|regional|global`',
    `renewal_deadline_date` DATE COMMENT 'The date by which the airline must notify the partner of intent to renew, in yyyy-MM-dd format. Nullable if no renewal option exists.',
    `renewal_option_details` STRING COMMENT 'Description of renewal terms, including notice period required, pricing adjustment mechanisms, and any conditions precedent for exercising the renewal option.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the sponsorship agreement includes a contractual option for renewal or extension beyond the initial term.',
    `rights_package_description` STRING COMMENT 'Comprehensive description of the sponsorship benefits and rights granted, including logo placement locations, hospitality ticket allocations, co-branded advertising opportunities, route promotion rights, social media mentions, and other activation entitlements.',
    `sponsorship_category` STRING COMMENT 'High-level classification of the sponsorship by thematic area to support portfolio analysis and strategic alignment. [ENUM-REF-CANDIDATE: sports|entertainment|culture|tourism|community|sustainability|other — 7 candidates stripped; promote to reference product]',
    `sponsorship_code` STRING COMMENT 'Internal alphanumeric code used to uniquely identify and track the sponsorship in financial and marketing systems.. Valid values are `^[A-Z0-9]{6,12}$`',
    `sponsorship_name` STRING COMMENT 'The official name or title of the sponsorship agreement as recognized in marketing materials and contracts.',
    `sponsorship_type` STRING COMMENT 'Classification of the sponsorship level and nature: title sponsor (highest tier, brand in event name), presenting sponsor (secondary tier), official airline partner (category exclusivity), jersey sponsor (logo on team uniform), stadium naming rights (venue branding), or event sponsor (single event support).. Valid values are `title_sponsor|presenting_sponsor|official_airline_partner|jersey_sponsor|stadium_naming_rights|event_sponsor`',
    `start_date` DATE COMMENT 'The date when the sponsorship agreement becomes effective and rights activation begins, in yyyy-MM-dd format.',
    `termination_clause_summary` STRING COMMENT 'Summary of conditions under which either party may terminate the sponsorship agreement early, including notice periods and financial penalties.',
    CONSTRAINT pk_sponsorship PRIMARY KEY(`sponsorship_id`)
) COMMENT 'Master record for airline sponsorship agreements and partnerships with sports teams, events, cultural institutions, and destination tourism boards. Captures sponsorship name, sponsorship type (title sponsor, presenting sponsor, official airline partner, jersey sponsor, stadium naming rights, event sponsor), partner organisation name, geographic market, sponsorship start and end dates, contracted value, currency, rights package description (logo placement, hospitality tickets, co-branded advertising, route promotion), activation status, renewal option details, and owning commercial team. Provides the authoritative register of all sponsorship commitments and brand partnership investments.';

CREATE OR REPLACE TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` (
    `sponsorship_activation_id` BIGINT COMMENT 'Unique identifier for the sponsorship activation event. Primary key for this transactional record capturing a specific deliverable execution under a sponsorship agreement.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Activation manager is an employee responsible for sponsorship execution, deliverable tracking, and partner relationship management. Airlines track activation ownership for accountability, performance ',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: Sponsorship activations on specific aircraft (branded liveries, cabin wraps, in-flight branding) require tracking which tail numbers carry sponsor assets for contractual proof-of-delivery, rights mana',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: sponsorship_activation currently has campaign_name (STRING) which is a denormalized reference. Normalizing to campaign_id FK to marketing.campaign.campaign_id. Sponsorship activations are often execut',
    `contract_deliverable_id` BIGINT COMMENT 'Reference to the specific deliverable line item in the sponsorship contract that this activation fulfills. Enables tracking of contract fulfillment and rights utilization.',
    `sponsorship_id` BIGINT COMMENT 'Reference to the parent sponsorship agreement under which this activation was executed. Links this activation to the master contract defining rights, obligations, and deliverables.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Sponsorship activations occur at specific airport stations (lounge events, gate area branding, terminal displays). Real business process: sponsor deliverable fulfillment tracking at contracted airport',
    `parent_sponsorship_activation_id` BIGINT COMMENT 'Self-referencing FK on sponsorship_activation (parent_sponsorship_activation_id)',
    `activation_date` DATE COMMENT 'The date on which the sponsorship activation event occurred or is scheduled to occur. Primary business event timestamp for this transactional record.',
    `activation_end_timestamp` TIMESTAMP COMMENT 'Precise date and time when the activation event concluded. Enables calculation of activation duration and supports time-based performance analysis.',
    `activation_reference_number` STRING COMMENT 'Business-facing unique reference code or number assigned to this activation event for tracking and reporting purposes. Used in communications with sponsors and internal stakeholders.',
    `activation_start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the activation event began. Used for time-bound activations such as hospitality events, press conferences, or limited-duration digital campaigns.',
    `activation_status` STRING COMMENT 'Current lifecycle state of the activation event. Tracks whether the deliverable has been executed, is pending, or was cancelled. Critical for contract fulfillment tracking and sponsor reporting.. Valid values are `planned|in_progress|completed|cancelled|deferred|under_review`',
    `activation_type` STRING COMMENT 'Category of sponsorship activation deliverable executed. Defines the nature of the marketing touchpoint or brand exposure delivered to the sponsor under the agreement. [ENUM-REF-CANDIDATE: hospitality_event|co_branded_campaign|airport_activation|social_media_post|press_event|in_stadium_branding|lounge_branding|aircraft_livery|digital_display|experiential_activation — 10 candidates stripped; promote to reference product]',
    `actual_audience_reach` BIGINT COMMENT 'Verified number of individuals who were exposed to the sponsorship activation based on post-event measurement. Critical for ROI analysis and sponsor value reporting.',
    `actual_spend_usd` DECIMAL(18,2) COMMENT 'Total actual expenditure incurred to execute this activation event, expressed in US dollars. Includes production costs, venue fees, staffing, and all direct activation expenses.',
    `aircraft_registration` STRING COMMENT 'Tail number or registration identifier of the aircraft used for the activation. Applicable for aircraft livery, in-flight branding, or aircraft-specific sponsorship deliverables.',
    `budgeted_spend_usd` DECIMAL(18,2) COMMENT 'Planned budget allocated for this activation event, expressed in US dollars. Used for budget variance analysis and financial planning of sponsorship programs.',
    `city_name` STRING COMMENT 'Name of the city where the activation event took place. Used for geographic segmentation and market-level performance analysis of sponsorship activities.',
    `content_url` STRING COMMENT 'Web address or link to the digital content created for this activation. Enables direct access to social media posts, landing pages, or digital assets produced.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code identifying the country where the activation occurred. Enables country-level aggregation and regional performance reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this activation record was first created in the system. Audit field for data lineage and record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the original transaction currency if different from USD. Supports multi-currency sponsorship programs and local market activations.. Valid values are `^[A-Z]{3}$`',
    `deliverable_description` STRING COMMENT 'Detailed narrative description of what was delivered during this activation event. Documents the specific sponsorship rights exercised and the execution details for sponsor reporting.',
    `digital_channel` STRING COMMENT 'Specific digital platform or channel used for the activation (e.g., Facebook, Instagram, LinkedIn, airline website, mobile app). Applicable for digital and social media activations.',
    `engagement_count` BIGINT COMMENT 'Number of direct interactions or engagements with the activation (clicks, shares, likes, physical interactions). Measures active audience participation beyond passive exposure.',
    `estimated_audience_reach` BIGINT COMMENT 'Projected number of individuals exposed to the sponsorship activation. Used for pre-event planning and to estimate the marketing value delivered to the sponsor.',
    `flight_number` STRING COMMENT 'Flight number associated with the activation, applicable for in-flight activations, co-branded flights, or aircraft livery deployments. Links activation to specific flight operations.',
    `impressions_count` BIGINT COMMENT 'Total number of times the sponsorship branding or message was displayed or viewed during the activation. Used for digital and physical media performance measurement.',
    `is_contractually_required` BOOLEAN COMMENT 'Boolean flag indicating whether this activation was a mandatory deliverable under the sponsorship contract (true) or a value-added bonus activation (false). Critical for compliance tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this activation record was most recently updated. Audit field for change tracking and data quality monitoring.',
    `location_type` STRING COMMENT 'Classification of the physical or digital location where the activation took place. Supports geographic and channel-based performance analysis of sponsorship activations. [ENUM-REF-CANDIDATE: airport|aircraft|lounge|stadium|digital|event_venue|city|route|hub — 9 candidates stripped; promote to reference product]',
    `media_value_usd` DECIMAL(18,2) COMMENT 'Estimated equivalent advertising value of the exposure delivered through this activation, expressed in US dollars. Calculated based on reach, impressions, and industry media rate benchmarks.',
    `outcome_notes` STRING COMMENT 'Free-text field capturing qualitative outcomes, learnings, sponsor feedback, and operational notes from the activation. Supports continuous improvement and sponsor relationship management.',
    `responsible_team` STRING COMMENT 'Name of the internal marketing team or department responsible for executing this activation. Supports accountability tracking and resource allocation analysis.',
    `sponsor_approval_status` STRING COMMENT 'Indicates whether the sponsor reviewed and approved the activation execution or deliverable. Critical for contract compliance and sponsor satisfaction tracking.. Valid values are `pending|approved|rejected|not_required`',
    `sponsor_feedback` STRING COMMENT 'Direct feedback or comments provided by the sponsor regarding the activation execution and quality. Used for relationship management and service improvement.',
    `venue_name` STRING COMMENT 'Name of the specific venue, facility, or location where the activation event was executed. Examples include stadium names, conference centers, or specific airport terminals.',
    CONSTRAINT pk_sponsorship_activation PRIMARY KEY(`sponsorship_activation_id`)
) COMMENT 'Transactional record capturing specific activation events and deliverables executed under a sponsorship agreement. Stores sponsorship reference, activation type (hospitality event, co-branded campaign flight, airport activation, social media post, press event, in-stadium branding deployment), activation date, location, estimated audience reach, actual spend on activation, activation status, and outcome notes. Enables tracking of whether contracted sponsorship rights are being fully utilised and measures the marketing value delivered per activation.';

CREATE OR REPLACE TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` (
    `passenger_touchpoint_id` BIGINT COMMENT 'Unique identifier for each passenger touchpoint interaction record.',
    `ancillary_order_id` BIGINT COMMENT 'Foreign key linking to ancillary.order. Business justification: Passenger touchpoints (web visits, app interactions) that result in ancillary purchases require direct attribution for customer journey analysis. Real business need to link touchpoints to ancillary re',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that generated or influenced this touchpoint, if applicable.',
    `digital_campaign_creative_id` BIGINT COMMENT 'Foreign key linking to marketing.digital_campaign_creative. Business justification: passenger_touchpoint should link to the specific creative asset viewed or interacted with during the touchpoint. When a passenger interacts with marketing content, tracking which creative they engaged',
    `employee_id` BIGINT COMMENT 'Identifier of the call center agent, airport staff, or chatbot agent who handled the touchpoint, if applicable.',
    `profile_id` BIGINT COMMENT 'Reference to the passenger who generated this touchpoint interaction.',
    `pricing_record_id` BIGINT COMMENT 'Foreign key linking to revenue.pricing_record. Business justification: Journey analytics - connects customer touchpoints to pricing sessions for conversion path analysis. Airlines analyze which touchpoint sequences lead to quotes for customer journey optimization and dig',
    `ticket_id` BIGINT COMMENT 'Foreign key linking to revenue.ticket. Business justification: Links customer journey touchpoints to final ticket purchase for multi-touch attribution modeling. Airlines analyze complete customer journeys from first touchpoint to purchase for marketing mix optimi',
    `previous_passenger_touchpoint_id` BIGINT COMMENT 'Self-referencing FK on passenger_touchpoint (previous_passenger_touchpoint_id)',
    `airport_code` STRING COMMENT 'Three-letter IATA airport code if the touchpoint occurred at an airport location (kiosk, gate, lounge).. Valid values are `^[A-Z]{3}$`',
    `booking_reference` STRING COMMENT 'Booking reference number if this touchpoint resulted in a flight or ancillary booking.',
    `browser` STRING COMMENT 'Web browser used during the touchpoint interaction, if applicable (e.g., Chrome, Safari, Firefox).',
    `channel` STRING COMMENT 'Marketing or commercial channel through which the touchpoint occurred. [ENUM-REF-CANDIDATE: web|mobile_app|email|paid_search|display_advertising|social_media|call_center|airport|inflight|sms|push_notification|chatbot — promote to reference product]',
    `content_viewed` STRING COMMENT 'Description or identifier of the content, page, or screen viewed during the touchpoint (e.g., URL path, page title, IFE content ID).',
    `conversion_flag` BOOLEAN COMMENT 'Boolean indicator whether this touchpoint resulted in a conversion event (booking, purchase, registration).',
    `conversion_type` STRING COMMENT 'Type of conversion that occurred as a result of this touchpoint, if any.. Valid values are `booking|ancillary_purchase|ffp_enrollment|newsletter_signup|account_creation|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this touchpoint record was first created in the system, in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `customer_segment` STRING COMMENT 'Marketing or customer segment classification of the passenger at the time of the touchpoint (e.g., business traveler, leisure, VIP).',
    `destination_airport_code` STRING COMMENT 'Three-letter IATA code of the destination airport if the touchpoint is related to a specific route or booking search.. Valid values are `^[A-Z]{3}$`',
    `device_type` STRING COMMENT 'Type of device used by the passenger during the touchpoint interaction.. Valid values are `desktop|mobile|tablet|kiosk|ife_screen|unknown`',
    `engagement_duration_seconds` STRING COMMENT 'Duration of the touchpoint interaction in seconds (e.g., time spent on page, call duration, IFE session length).',
    `ffp_number` STRING COMMENT 'Frequent Flyer Program membership number of the passenger associated with this touchpoint, if authenticated.',
    `flight_number` STRING COMMENT 'Flight number associated with the touchpoint if the interaction occurred in the context of a specific flight (e.g., IFE engagement, gate interaction).. Valid values are `^[A-Z0-9]{2,3}[0-9]{1,4}$`',
    `geographic_city` STRING COMMENT 'City name where the touchpoint interaction occurred, derived from IP geolocation or device location.',
    `geographic_country_code` STRING COMMENT 'Three-letter ISO country code representing the geographic location of the touchpoint interaction.. Valid values are `^[A-Z]{3}$`',
    `interaction_depth` STRING COMMENT 'Measure of interaction depth such as scroll depth percentage, pages per session, or clicks within the touchpoint.',
    `ip_address` STRING COMMENT 'IP address of the device from which the touchpoint originated, used for geographic and fraud analysis.',
    `operating_system` STRING COMMENT 'Operating system of the device used during the touchpoint (e.g., iOS, Android, Windows, macOS).',
    `origin_airport_code` STRING COMMENT 'Three-letter IATA code of the origin airport if the touchpoint is related to a specific route or booking search.. Valid values are `^[A-Z]{3}$`',
    `page_url` STRING COMMENT 'Full URL of the web page or app screen viewed during the touchpoint, if applicable.',
    `pnr` STRING COMMENT 'Six-character alphanumeric Passenger Name Record identifier associated with this touchpoint, if applicable.. Valid values are `^[A-Z0-9]{6}$`',
    `referrer_url` STRING COMMENT 'URL of the referring page or source that led the passenger to this touchpoint.',
    `revenue_amount` DECIMAL(18,2) COMMENT 'Revenue amount directly attributed to this touchpoint interaction, if a purchase or booking occurred.',
    `revenue_currency` STRING COMMENT 'Three-letter ISO currency code for the revenue amount attributed to this touchpoint.. Valid values are `^[A-Z]{3}$`',
    `session_reference` STRING COMMENT 'Unique session identifier grouping multiple touchpoints within a single user session or visit.',
    `touchpoint_status` STRING COMMENT 'Status of the touchpoint interaction indicating whether it was completed successfully or abandoned.. Valid values are `completed|abandoned|error|timeout`',
    `touchpoint_timestamp` TIMESTAMP COMMENT 'Precise date and time when the passenger touchpoint interaction occurred, in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `touchpoint_type` STRING COMMENT 'Classification of the marketing or commercial touchpoint interaction type. [ENUM-REF-CANDIDATE: website_visit|mobile_app_session|email_open|email_click|ad_impression|ad_click|call_center_contact|airport_kiosk|checkin_counter|gate_interaction|lounge_visit|ife_engagement|chatbot_session|sms_interaction|push_notification|social_media_interaction — promote to reference product]',
    `utm_campaign` STRING COMMENT 'UTM campaign parameter identifying the specific campaign name for attribution tracking.',
    `utm_content` STRING COMMENT 'UTM content parameter used to differentiate similar content or links within the same campaign.',
    `utm_medium` STRING COMMENT 'UTM medium parameter identifying the marketing medium (e.g., cpc, email, social) for campaign attribution.',
    `utm_source` STRING COMMENT 'UTM source parameter identifying the traffic source (e.g., google, newsletter, facebook) for campaign attribution.',
    `utm_term` STRING COMMENT 'UTM term parameter identifying paid search keywords for campaign attribution.',
    CONSTRAINT pk_passenger_touchpoint PRIMARY KEY(`passenger_touchpoint_id`)
) COMMENT 'Transactional record capturing every marketing and commercial touchpoint interaction between the airline and a passenger across digital and physical channels throughout the customer journey. Stores passenger profile reference, touchpoint type (website visit, app session, email open, ad impression, call centre contact, airport interaction, IFE engagement, chatbot session), channel, touchpoint timestamp, session identifier, device type, geographic location, content or page viewed, campaign attribution reference (if applicable), and whether the touchpoint resulted in a booking or ancillary purchase. Provides the raw interaction log for customer journey mapping and attribution modelling.';

CREATE OR REPLACE TABLE `airlines_ecm`.`marketing`.`ab_test` (
    `ab_test_id` BIGINT COMMENT 'Unique identifier for the A/B or multivariate test. Primary key.',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign associated with this test.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Test owner is an employee responsible for test design, hypothesis validation, and results analysis. Airlines track test ownership for accountability, methodology validation, and performance optimizati',
    `iterated_ab_test_id` BIGINT COMMENT 'Self-referencing FK on ab_test (iterated_ab_test_id)',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the test was concluded and data collection stopped.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the test was launched and began collecting data.',
    `approval_status` STRING COMMENT 'Approval status of the test design before launch: pending (awaiting review), approved (cleared to run), or rejected (not approved).. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the test was approved for execution.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved the test for execution.',
    `cabin_class_focus` STRING COMMENT 'Cabin class targeted by the test, if the experiment is specific to a travel class.. Valid values are `economy|premium_economy|business|first`',
    `control_variant_description` STRING COMMENT 'Detailed description of the control (baseline) variant used in the test.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the test record was first created in the system.',
    `digital_channel` STRING COMMENT 'The digital marketing channel where the test is being conducted.. Valid values are `email|website|mobile_app|social_media|display_ads|search_ads`',
    `ffp_tier_focus` STRING COMMENT 'Specific FFP loyalty tier targeted by the test (e.g., Silver, Gold, Platinum), if applicable.',
    `hypothesis` STRING COMMENT 'The business hypothesis being tested, describing the expected outcome and rationale for the experiment.',
    `minimum_detectable_effect` DECIMAL(18,2) COMMENT 'The smallest effect size that the test is designed to detect with statistical confidence, expressed as a decimal (e.g., 0.0200 for 2% lift).',
    `modified_by` STRING COMMENT 'Identifier of the user or system that last modified the test record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the test record was last modified.',
    `notes` STRING COMMENT 'Additional notes, observations, or context about the test design, execution, or results.',
    `owning_team` STRING COMMENT 'Marketing team or business unit responsible for the test (e.g., Digital Marketing, Email Marketing, Revenue Management).',
    `p_value` DECIMAL(18,2) COMMENT 'The probability that the observed difference between variants occurred by chance, used to assess statistical significance.',
    `planned_end_date` DATE COMMENT 'Scheduled date for the test to conclude.',
    `planned_start_date` DATE COMMENT 'Scheduled date for the test to begin.',
    `primary_success_metric` STRING COMMENT 'The primary metric used to determine test success, such as conversion rate, click-through rate (CTR), revenue per visitor (RPV), or booking completion rate.',
    `route_focus` STRING COMMENT 'Specific route or origin-destination pair targeted by the test, if applicable (e.g., JFK-LHR, LAX-NRT).',
    `sample_size_target` STRING COMMENT 'Target number of observations (visitors, impressions, or conversions) required to achieve statistical power.',
    `secondary_metrics` STRING COMMENT 'Additional metrics tracked to understand broader impact, such as engagement rate, bounce rate, average order value, or ancillary attachment rate.',
    `statistical_confidence_threshold` DECIMAL(18,2) COMMENT 'The confidence level required to declare statistical significance, typically 0.950 (95%) or 0.990 (99%).',
    `statistical_significance_achieved` BOOLEAN COMMENT 'Indicates whether the test results achieved the required statistical confidence threshold (True) or not (False).',
    `target_audience_segment` STRING COMMENT 'Customer segment or audience targeted by the test, such as Frequent Flyer Program (FFP) tier, geographic market, or behavioral cohort.',
    `test_code` STRING COMMENT 'Business-readable unique code for the test, used for operational reference and reporting.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `test_name` STRING COMMENT 'Descriptive name of the A/B or multivariate test for business identification.',
    `test_platform` STRING COMMENT 'Technology platform or tool used to execute the test (e.g., Optimizely, Adobe Target, Google Optimize, internal experimentation platform).',
    `test_status` STRING COMMENT 'Current lifecycle status of the test: draft (being designed), approved (ready to launch), running (actively collecting data), paused (temporarily stopped), concluded (completed with results), or cancelled (terminated without conclusion).. Valid values are `draft|approved|running|paused|concluded|cancelled`',
    `test_type` STRING COMMENT 'Type of experiment design: A/B (two variants), multivariate (multiple factors), split URL (different landing pages), sequential (phased rollout), or bandit (adaptive allocation).. Valid values are `A/B|multivariate|split_url|sequential|bandit`',
    `traffic_split_percentage` STRING COMMENT 'Distribution of traffic across variants, expressed as percentages (e.g., 50/50 for A/B, 33/33/34 for three-way split).',
    `treatment_variant_description` STRING COMMENT 'Detailed description of the treatment (experimental) variant(s) being tested against the control.',
    `variant_count` STRING COMMENT 'Total number of variants in the test, including control and all treatment variants.',
    `winning_variant` STRING COMMENT 'Identifier of the variant that achieved the best performance on the primary success metric, determined after test conclusion.',
    CONSTRAINT pk_ab_test PRIMARY KEY(`ab_test_id`)
) COMMENT 'Master record for A/B and multivariate tests conducted within marketing campaigns, email programmes, and digital experiences. Captures test name, test type (A/B, multivariate, split URL), hypothesis, associated campaign or digital channel, test variants (control and treatment descriptions), traffic split percentages, primary success metric (conversion rate, CTR, revenue per visitor), secondary metrics, test start and end dates, minimum detectable effect, statistical confidence threshold, test status (running, paused, concluded), winning variant, and statistical significance achieved. Provides the authoritative register of all controlled marketing experiments.';

CREATE OR REPLACE TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` (
    `competitor_fare_watch_id` BIGINT COMMENT 'Unique identifier for the competitor fare observation record.',
    `previous_competitor_fare_watch_id` BIGINT COMMENT 'Self-referencing FK on competitor_fare_watch (previous_competitor_fare_watch_id)',
    `advance_purchase_days` STRING COMMENT 'Number of days between the observation date and the travel date, representing the booking window or advance purchase period.',
    `alliance_affiliation` STRING COMMENT 'The global airline alliance membership of the competitor carrier, if applicable.. Valid values are `star_alliance|oneworld|skyteam|none`',
    `availability_status` STRING COMMENT 'The seat availability status observed at the time of fare capture, indicating inventory levels for the booking class.. Valid values are `available|limited|sold_out|unavailable|unknown`',
    `booking_class_code` STRING COMMENT 'Single-letter booking class or fare basis code observed for the competitor fare, indicating fare restrictions and inventory bucket.. Valid values are `^[A-Z]{1}$`',
    `cabin_class` STRING COMMENT 'The cabin class or service level for which the fare was observed.. Valid values are `economy|premium_economy|business|first`',
    `codeshare_flag` BOOLEAN COMMENT 'Indicates whether the observed fare is for a codeshare flight operated by a partner carrier (true) or a flight operated by the marketing carrier itself (false).',
    `collection_method` STRING COMMENT 'The technical method or process used to capture the competitor fare observation.. Valid values are `automated_scraping|api_integration|manual_entry|gds_query|partner_feed`',
    `competitor_carrier_code` STRING COMMENT 'Two-character IATA airline code identifying the competitor carrier whose fare was observed.. Valid values are `^[A-Z0-9]{2}$`',
    `competitor_flight_number` STRING COMMENT 'The specific flight number operated by the competitor carrier for which the fare was observed, combining carrier code and numeric flight identifier.. Valid values are `^[A-Z0-9]{2}[0-9]{1,4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this competitor fare watch record was first inserted into the data platform.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'A numeric score (0.00 to 1.00) representing the completeness and reliability of the fare observation data, based on validation rules and source system confidence.',
    `data_source` STRING COMMENT 'The type of source system or channel from which the competitor fare data was collected.. Valid values are `gds|ota|direct_channel|meta_search|api|manual`',
    `destination_airport_code` STRING COMMENT 'Three-letter IATA airport code representing the arrival airport for the fare observation.. Valid values are `^[A-Z]{3}$`',
    `fare_basis_code` STRING COMMENT 'The full fare basis code string observed, providing detailed fare rule and inventory classification information.',
    `fare_conditions_summary` STRING COMMENT 'Textual summary of key fare rules and restrictions observed, including refundability, change fees, minimum stay, and other material conditions.',
    `fare_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the observed fare is denominated.. Valid values are `^[A-Z]{3}$`',
    `fare_type` STRING COMMENT 'Classification of the observed fare indicating whether it is a standard published fare, private negotiated rate, promotional offer, or opaque fare.. Valid values are `published|private|negotiated|promotional|opaque`',
    `gds_system_code` STRING COMMENT 'Two-character code identifying the specific GDS system used for fare collection, if applicable (e.g., 1A for Amadeus, 1B for Abacus, 1G for Galileo, 1P for Worldspan, 1S for Sabre, 1V for Apollo).. Valid values are `^(1A|1B|1G|1P|1S|1V)?$`',
    `market_segment` STRING COMMENT 'The target customer segment or market classification for the observed fare (leisure, business, visiting friends and relatives, group, corporate).. Valid values are `leisure|business|vfr|group|corporate`',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this competitor fare watch record was last updated in the data platform.',
    `number_of_stops` STRING COMMENT 'The number of intermediate stops or connections included in the observed fare itinerary (0 for nonstop, 1+ for connecting flights).',
    `observation_status` STRING COMMENT 'The current status of the fare observation record in the competitive intelligence system.. Valid values are `active|archived|invalidated|duplicate`',
    `observation_timestamp` TIMESTAMP COMMENT 'The exact date and time when the competitor fare was observed and captured from the data source.',
    `observed_fare_amount` DECIMAL(18,2) COMMENT 'The base fare amount observed for the competitor offering, excluding taxes and fees.',
    `operating_carrier_code` STRING COMMENT 'Two-character IATA code of the airline actually operating the flight, if different from the marketing carrier in a codeshare arrangement.. Valid values are `^[A-Z0-9]{2}$`',
    `origin_airport_code` STRING COMMENT 'Three-letter IATA airport code representing the departure airport for the fare observation.. Valid values are `^[A-Z]{3}$`',
    `ota_platform_name` STRING COMMENT 'Name of the online travel agency or metasearch platform from which the fare was observed, if applicable.',
    `point_of_sale_country` STRING COMMENT 'Three-letter ISO country code representing the geographic market or point of sale where the fare was observed.. Valid values are `^[A-Z]{3}$`',
    `return_travel_date` DATE COMMENT 'The return departure date for round-trip fares, null for one-way observations.',
    `round_trip_flag` BOOLEAN COMMENT 'Indicates whether the observed fare is for a round-trip journey (true) or one-way travel (false).',
    `scraping_session_reference` STRING COMMENT 'Identifier for the automated data collection session or batch run during which this fare observation was captured, enabling traceability and quality audits.',
    `seats_available_count` STRING COMMENT 'The number of seats available in the observed booking class at the time of observation, if disclosed by the source system.',
    `taxes_fees_amount` DECIMAL(18,2) COMMENT 'The total amount of taxes, government fees, and carrier-imposed surcharges included in the total fare.',
    `total_fare_amount` DECIMAL(18,2) COMMENT 'The all-in fare amount including base fare, taxes, fees, and surcharges as displayed to the customer.',
    `travel_date` DATE COMMENT 'The departure date for which the competitor fare was quoted.',
    CONSTRAINT pk_competitor_fare_watch PRIMARY KEY(`competitor_fare_watch_id`)
) COMMENT 'Transactional record capturing competitive fare monitoring data collected from GDS, OTA, and direct channel scraping for key origin-destination markets. Stores observation timestamp, origin airport, destination airport, competitor carrier IATA code, observed fare amount, currency, cabin class, travel date, booking class, advance purchase days, fare conditions summary, data source, and collection method. Provides the commercial intelligence dataset used by revenue management and marketing teams to benchmark pricing competitiveness and inform promotional fare decisions. Distinct from route.market_assessment which is a higher-level strategic assessment; this entity captures granular point-in-time fare observations.';

CREATE OR REPLACE TABLE `airlines_ecm`.`marketing`.`promotional_fare` (
    `promotional_fare_id` BIGINT COMMENT 'Unique identifier for the promotional fare offer. Primary key for this entity.',
    `campaign_id` BIGINT COMMENT 'Reference to the parent marketing campaign under which this promotional fare is published.',
    `fare_id` BIGINT COMMENT 'Foreign key linking to revenue.fare. Business justification: Links promotional fare campaigns to actual fare records in revenue system for pricing execution, inventory control, and yield management. Airlines must connect marketing promotions to operational fare',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Promotional fare revenue impacts must be tracked in GL for revenue recognition under IFRS 15, fare discount accounting, and financial reporting. Airlines need to reconcile promotional revenue to GL ac',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Promotional fares originate from specific stations for route-based pricing campaigns and load factor optimization. Real business process: origin-station fare promotions for demand stimulation, competi',
    `employee_id` BIGINT COMMENT 'User identifier of the marketing or revenue management staff member who created this promotional fare record.',
    `superseded_promotional_fare_id` BIGINT COMMENT 'Self-referencing FK on promotional_fare (superseded_promotional_fare_id)',
    `advance_purchase_days` STRING COMMENT 'Minimum number of days before departure that the booking must be made to qualify for this promotional fare. Null if no advance purchase requirement.',
    `amount` DECIMAL(18,2) COMMENT 'Base promotional fare price offered to passengers, excluding taxes and fees.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this promotional fare was approved for publication. Null if not yet approved.',
    `blackout_dates` STRING COMMENT 'Comma-separated list of dates or date ranges within the travel window when the promotional fare is NOT valid (e.g., peak holiday periods).',
    `booking_class` STRING COMMENT 'Single-letter Revenue Management System (RMS) booking class code associated with this promotional fare (e.g., Q, T, L).. Valid values are `^[A-Z]{1}$`',
    `booking_window_end_date` DATE COMMENT 'Last date on which passengers can book this promotional fare.',
    `booking_window_start_date` DATE COMMENT 'First date on which passengers can book this promotional fare.',
    `cabin_class` STRING COMMENT 'Cabin class to which this promotional fare applies. all indicates the promotion is valid across all cabin classes.. Valid values are `economy|premium_economy|business|first|all`',
    `change_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged for making changes to tickets purchased under this promotional fare. Null if changes are not permitted or are free.',
    `changeable_flag` BOOLEAN COMMENT 'Indicates whether tickets purchased under this promotional fare allow date or flight changes. True = changeable, False = non-changeable.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this promotional fare record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the promotional fare amount.. Valid values are `^[A-Z]{3}$`',
    `destination_airport_code` STRING COMMENT 'Three-letter IATA airport code for the destination. May be null if promotion applies to a region or globally.. Valid values are `^[A-Z]{3}$`',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount off the standard published fare, if applicable. Null if promotional fare is an absolute amount.',
    `distribution_channels` STRING COMMENT 'Comma-separated list of channels through which this promotional fare is available (e.g., website, mobile_app, GDS, call_center, travel_agent).',
    `ffp_tier_eligibility` STRING COMMENT 'Comma-separated list of FFP tier codes eligible for this promotional fare (e.g., gold, platinum, all). Null if no tier restriction.',
    `gds_distribution_flag` BOOLEAN COMMENT 'Indicates whether this promotional fare is distributed through Global Distribution Systems (Amadeus, Sabre, Travelport). True = available via GDS, False = direct channels only.',
    `maximum_stay_days` STRING COMMENT 'Maximum number of days the passenger may stay at the destination under this promotional fare. Null if no maximum stay restriction.',
    `mileage_accrual_percentage` DECIMAL(18,2) COMMENT 'Percentage of flown miles that passengers earn toward their FFP account when booking this promotional fare. 100 = full mileage, 0 = no mileage.',
    `minimum_stay_days` STRING COMMENT 'Minimum number of days the passenger must stay at the destination to qualify for this promotional fare. Null if no minimum stay required.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this promotional fare record was last modified.',
    `origin_airport_code` STRING COMMENT 'Three-letter IATA airport code for the origin. May be null if promotion applies to a region or globally.. Valid values are `^[A-Z]{3}$`',
    `owning_team` STRING COMMENT 'Name of the commercial or marketing team responsible for managing this promotional fare offer.',
    `promotion_code` STRING COMMENT 'Unique alphanumeric code passengers must enter at booking to access this promotional fare. May be null for automatic promotions.. Valid values are `^[A-Z0-9]{4,12}$`',
    `promotion_name` STRING COMMENT 'Marketing name of the promotional fare offer (e.g., Summer Flash Sale, Route Launch Special, Black Friday Fare).',
    `promotion_type` STRING COMMENT 'Classification of the promotional fare offer by marketing strategy type. [ENUM-REF-CANDIDATE: seat_sale|flash_sale|route_launch|seasonal|error_fare_managed|loyalty_exclusive|partner_promotion — 7 candidates stripped; promote to reference product]',
    `promotional_fare_status` STRING COMMENT 'Current lifecycle status of the promotional fare offer.. Valid values are `draft|active|paused|expired|sold_out|cancelled`',
    `refundable_flag` BOOLEAN COMMENT 'Indicates whether tickets purchased under this promotional fare are refundable. True = refundable, False = non-refundable.',
    `region_code` STRING COMMENT 'Internal region code when route_scope is regional (e.g., APAC, EMEA, AMER). Null for specific routes.',
    `route_scope` STRING COMMENT 'Geographic scope of the promotional fare: specific origin-destination pair, regional coverage, country-level, or global network.. Valid values are `specific_route|region|country|global`',
    `seat_allocation_total` STRING COMMENT 'Total number of seats allocated across all flights for this promotional fare offer. Null if unlimited.',
    `seat_cap_per_flight` STRING COMMENT 'Maximum number of promotional fare seats available on any single flight. Null if no per-flight cap.',
    `seats_sold` STRING COMMENT 'Current count of seats sold under this promotional fare offer across all flights.',
    `travel_window_end_date` DATE COMMENT 'Last date of travel for which this promotional fare is valid.',
    `travel_window_start_date` DATE COMMENT 'First date of travel for which this promotional fare is valid.',
    CONSTRAINT pk_promotional_fare PRIMARY KEY(`promotional_fare_id`)
) COMMENT 'Master record for airline promotional fare offers published through marketing channels, including seat sales, flash sales, error fares (managed), route launch fares, and seasonal promotional pricing. Captures promotion name, associated campaign reference, origin-destination scope (specific route, region, or global), cabin class, promotional fare amount, currency, booking window (start and end dates), travel window (start and end dates), fare conditions (refundable, changeable, minimum stay), distribution channels, promo code (if applicable), seat cap per flight, total seat allocation, status (draft, active, expired, sold out), and owning commercial team. Distinct from revenue.fare which is the full fare basis master; this entity specifically tracks marketing-driven promotional offers.';

CREATE OR REPLACE TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` (
    `co_marketing_agreement_id` BIGINT COMMENT 'Unique identifier for the co-marketing agreement record. Primary key.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Co-marketing agreements with partners generate shared cost invoices and partner contribution settlements that flow through AP. Airlines track these for intercompany reconciliation and financial report',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Agreement approval requires employee authorization for legal commitment, budget allocation, and strategic alignment. Airlines track approver identity for audit trails, contract governance, and delegat',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: co_marketing_agreement should link to a primary campaign that represents the agreements main marketing initiative. While agreements may spawn multiple campaigns over time, linking to a primary/flagsh',
    `partner_organization_id` BIGINT COMMENT 'Reference to the commercial partner organization (tourism board, hotel chain, car rental company, credit card issuer, destination marketing organization, or OTA).',
    `renewed_co_marketing_agreement_id` BIGINT COMMENT 'Self-referencing FK on co_marketing_agreement (renewed_co_marketing_agreement_id)',
    `agreement_manager` STRING COMMENT 'Name or identifier of the airline employee serving as the primary point of contact and manager for this co-marketing agreement.',
    `agreement_reference_number` STRING COMMENT 'External business identifier for the co-marketing agreement, used in contracts and partner communications.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the co-marketing agreement indicating its operational state and validity. [ENUM-REF-CANDIDATE: draft|pending approval|active|suspended|expired|terminated|renewed — 7 candidates stripped; promote to reference product]',
    `agreement_type` STRING COMMENT 'Classification of the co-marketing agreement defining the nature of the partnership and marketing collaboration model.. Valid values are `co-branded campaign|joint advertising|destination marketing|credit card co-brand|OTA partnership|loyalty program partnership`',
    `airline_contribution_amount` DECIMAL(18,2) COMMENT 'Financial contribution committed by the airline to the co-marketing agreement budget.',
    `approval_date` DATE COMMENT 'Date when the co-marketing agreement received final internal approval from the airline.',
    `approval_status` STRING COMMENT 'Internal approval workflow status indicating whether the agreement has been reviewed and authorized by the airlines commercial leadership.. Valid values are `pending|approved|rejected|revision required`',
    `campaign_deliverables` STRING COMMENT 'Detailed description of the marketing deliverables, activities, and outputs committed under the co-marketing agreement (e.g., digital campaigns, print advertising, event sponsorships, content creation).',
    `contract_document_reference` STRING COMMENT 'Reference identifier or file path to the signed legal contract document for the co-marketing agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the co-marketing agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in the agreement.. Valid values are `^[A-Z]{3}$`',
    `end_date` DATE COMMENT 'Scheduled expiration date of the co-marketing agreement. Nullable for evergreen agreements subject to termination notice.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the agreement grants exclusive co-marketing rights within a specific category or geography, preventing similar agreements with competing partners.',
    `geographic_scope` STRING COMMENT 'Geographic markets or regions covered by the co-marketing agreement, defining where joint marketing activities will be executed. May include multiple countries or regions.',
    `joint_budget_amount` DECIMAL(18,2) COMMENT 'Total combined marketing budget committed by both the airline and partner for the duration of the agreement.',
    `legal_entity` STRING COMMENT 'Name of the airline legal entity that is the contracting party for this co-marketing agreement.',
    `modified_by` STRING COMMENT 'Identifier of the user or system that last modified the co-marketing agreement record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the co-marketing agreement record was last modified or updated.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or special conditions related to the co-marketing agreement.',
    `owning_commercial_team` STRING COMMENT 'Name of the airline commercial or marketing team responsible for managing the co-marketing agreement and partner relationship.',
    `partner_contact_email` STRING COMMENT 'Email address of the primary partner contact for agreement coordination and communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `partner_contact_name` STRING COMMENT 'Name of the primary contact person at the partner organization responsible for the co-marketing agreement.',
    `partner_contact_phone` STRING COMMENT 'Phone number of the primary partner contact for agreement coordination.',
    `partner_contribution_amount` DECIMAL(18,2) COMMENT 'Financial contribution committed by the partner organization to the co-marketing agreement budget.',
    `performance_metrics` STRING COMMENT 'Key performance indicators and success metrics defined to measure the effectiveness of the co-marketing agreement (e.g., incremental bookings, brand awareness lift, revenue targets).',
    `renewal_terms` STRING COMMENT 'Contractual terms and conditions governing the renewal or extension of the co-marketing agreement beyond the initial term.',
    `route_focus` STRING COMMENT 'Specific routes, origin-destination pairs, or route networks that are the focus of the co-marketing activities.',
    `start_date` DATE COMMENT 'Effective start date when the co-marketing agreement becomes active and joint marketing activities may commence.',
    `target_passenger_segment` STRING COMMENT 'Description of the passenger segments or customer profiles targeted by the co-marketing agreement (e.g., leisure travelers, business travelers, FFP elite members).',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the co-marketing agreement.',
    CONSTRAINT pk_co_marketing_agreement PRIMARY KEY(`co_marketing_agreement_id`)
) COMMENT 'Master record for co-marketing and joint marketing agreements between the airline and commercial partners including tourism boards, hotel chains, car rental companies, credit card issuers, and destination marketing organisations. Captures partner organisation name, agreement type (co-branded campaign, joint advertising, destination marketing, credit card co-brand, OTA partnership), geographic scope, agreement start and end dates, joint budget contribution, airline contribution amount, partner contribution amount, currency, campaign deliverables, approval status, and owning commercial team. Provides the authoritative register of all co-marketing commitments and partner marketing investments.';

CREATE OR REPLACE TABLE `airlines_ecm`.`marketing`.`social_media_post` (
    `social_media_post_id` BIGINT COMMENT 'Unique identifier for the social media post record.',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: Social media posts featuring specific aircraft (delivery announcements, special liveries, milestone flights, behind-the-scenes content) reference tail numbers for content planning, asset tracking, and',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign this post is associated with, if applicable.',
    `digital_campaign_creative_id` BIGINT COMMENT 'Foreign key linking to marketing.digital_campaign_creative. Business justification: social_media_post should link to the creative asset used in the post. Social posts use designed creative assets (images, videos, copy). Adding digital_campaign_creative_id FK to marketing.digital_camp',
    `employee_id` BIGINT COMMENT 'The internal user identifier of the marketing team member who created or authored the post.',
    `reply_to_social_media_post_id` BIGINT COMMENT 'Self-referencing FK on social_media_post (reply_to_social_media_post_id)',
    `account_handle` STRING COMMENT 'The airlines social media account handle or username on the platform (e.g., @AirlineName).',
    `actual_publish_timestamp` TIMESTAMP COMMENT 'The actual date and time when the post was successfully published to the platform.',
    `approval_status` STRING COMMENT 'The approval workflow status for the post: pending (awaiting review), approved (cleared for publishing), rejected (not approved), not_required (no approval needed).. Valid values are `pending|approved|rejected|not_required`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the post was approved for publishing.',
    `approved_by` STRING COMMENT 'The user identifier or name of the person who approved the post for publishing.',
    `boosted_spend_amount` DECIMAL(18,2) COMMENT 'The amount spent to boost or promote this post, if applicable.',
    `boosted_spend_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for the boosted spend amount.. Valid values are `^[A-Z]{3}$`',
    `comments` BIGINT COMMENT 'Total number of comments posted by users on this post.',
    `content_text` STRING COMMENT 'The text content or caption of the social media post, including hashtags and mentions.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this social media post record was first created in the system.',
    `engagement_rate` DECIMAL(18,2) COMMENT 'Calculated engagement rate as a percentage, representing total engagements (likes, comments, shares, saves) divided by reach or impressions.',
    `hashtags` STRING COMMENT 'Comma-separated list of hashtags used in the post for discoverability and campaign tracking.',
    `impressions` BIGINT COMMENT 'Total number of times the post was displayed to users, regardless of whether it was clicked or engaged with.',
    `language_code` STRING COMMENT 'The two-letter ISO 639-1 language code representing the language of the post content.. Valid values are `^[a-z]{2}$`',
    `likes` BIGINT COMMENT 'Total number of likes or reactions the post received.',
    `link_clicks` BIGINT COMMENT 'Total number of clicks on links embedded in the post content.',
    `market_region` STRING COMMENT 'The geographic market or region this post is targeted toward (e.g., North America, Europe, Asia-Pacific).',
    `media_attachment_reference` STRING COMMENT 'Reference identifier or URI to the media assets (images, videos, graphics) attached to the post, stored in the brand asset management system.',
    `mentions` STRING COMMENT 'Comma-separated list of user handles or accounts mentioned in the post.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this social media post record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text notes or comments from the marketing team regarding the post, including context, learnings, or special instructions.',
    `platform` STRING COMMENT 'The social media platform where the post is published (Instagram, Facebook, X/Twitter, LinkedIn, TikTok, YouTube). [ENUM-REF-CANDIDATE: Instagram|Facebook|X|LinkedIn|TikTok|YouTube|WeChat|LINE — promote to reference product]. Valid values are `Instagram|Facebook|X|LinkedIn|TikTok|YouTube`',
    `post_reference_number` STRING COMMENT 'Business-facing unique reference code for the social media post, used for tracking and governance.',
    `post_status` STRING COMMENT 'Current lifecycle status of the post: draft (being created), scheduled (queued for publishing), published (live), deleted (removed), failed (publishing error).. Valid values are `draft|scheduled|published|deleted|failed`',
    `post_type` STRING COMMENT 'Classification of the post type: organic (unpaid), boosted (promoted organic), paid dark post (paid without organic presence), story, reel, carousel.. Valid values are `organic|boosted|paid_dark_post|story|reel|carousel`',
    `post_url` STRING COMMENT 'The direct URL link to the published post on the social media platform.',
    `reach` BIGINT COMMENT 'Total number of unique users who saw the post at least once.',
    `saves` BIGINT COMMENT 'Total number of times users saved or bookmarked the post for later viewing.',
    `scheduled_publish_timestamp` TIMESTAMP COMMENT 'The planned date and time when the post is scheduled to be published to the platform.',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Aggregated sentiment score derived from user comments and reactions, typically ranging from -1.0 (negative) to +1.0 (positive).',
    `shares` BIGINT COMMENT 'Total number of times the post was shared or reposted by users.',
    `target_audience_segment` STRING COMMENT 'The audience segment or demographic targeting criteria applied to the post for paid or boosted distribution.',
    `video_views` BIGINT COMMENT 'Total number of video views if the post contains video content, measured according to platform-specific view thresholds.',
    CONSTRAINT pk_social_media_post PRIMARY KEY(`social_media_post_id`)
) COMMENT 'Transactional record capturing published and scheduled social media posts across the airlines owned social media accounts. Stores platform (Instagram, Facebook, X/Twitter, LinkedIn, TikTok, YouTube, WeChat, LINE), account handle, post type (organic, boosted, paid dark post), post content text, media attachments reference, associated campaign reference, scheduled publish timestamp, actual publish timestamp, post status (draft, scheduled, published, deleted), impressions, reach, engagements (likes, comments, shares, saves), link clicks, video views, and boosted spend. Provides the operational record of all social media publishing activity for performance tracking and content governance.';

CREATE OR REPLACE TABLE `airlines_ecm`.`marketing`.`email_send` (
    `email_send_id` BIGINT COMMENT 'Unique identifier for the email send event. Primary key.',
    `ancillary_order_id` BIGINT COMMENT 'Foreign key linking to ancillary.order. Business justification: Email campaigns promoting ancillary services (seat selection reminders, baggage pre-purchase offers) need conversion tracking to ancillary orders. Real business need for email campaign ROI measurement',
    `campaign_execution_id` BIGINT COMMENT 'Reference to the campaign execution batch that triggered this email send.',
    `digital_campaign_creative_id` BIGINT COMMENT 'Reference to the email template used for this send event.',
    `profile_id` BIGINT COMMENT 'Reference to the passenger profile record for known customers. Null for anonymous recipients.',
    `resend_email_send_id` BIGINT COMMENT 'Self-referencing FK on email_send (resend_email_send_id)',
    `ab_test_variant` STRING COMMENT 'Identifier for the A/B test variant or split test group assigned to this email send. Null if not part of a test.',
    `bounce_reason` STRING COMMENT 'Detailed reason or SMTP error message explaining why the email bounced. Null if delivered successfully.',
    `bounce_type` STRING COMMENT 'Classification of bounce reason when delivery_status indicates a bounce. Null if delivered successfully.. Valid values are `hard|soft|block|technical|policy|content`',
    `click_flag` BOOLEAN COMMENT 'Indicates whether the recipient clicked any link within the email. True if clicked, False otherwise.',
    `clicked_url` STRING COMMENT 'The first URL clicked by the recipient within the email. Null if no clicks recorded.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this email send record was created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX',
    `delivery_status` STRING COMMENT 'Final delivery status of the email as reported by the email service provider or receiving mail server.. Valid values are `delivered|bounced_hard|bounced_soft|filtered|deferred|failed`',
    `delivery_timestamp` TIMESTAMP COMMENT 'Date and time when the email was successfully delivered to the recipient mail server. Null if not delivered. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX',
    `device_type` STRING COMMENT 'Type of device used by the recipient to open or interact with the email.. Valid values are `desktop|mobile|tablet|webmail|unknown`',
    `email_client` STRING COMMENT 'Email client or application used by the recipient to open the email (e.g., Outlook, Gmail, Apple Mail). Derived from user agent string.',
    `esp_provider` STRING COMMENT 'Name of the email service provider used to send this email (e.g., SendGrid, Mailchimp, Adobe Campaign).',
    `first_click_timestamp` TIMESTAMP COMMENT 'Date and time of the first recorded click event for any link in this email. Null if never clicked. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX',
    `first_open_timestamp` TIMESTAMP COMMENT 'Date and time of the first recorded open event for this email. Null if never opened. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX',
    `from_address` STRING COMMENT 'Email address used in the From field of the email header.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `ip_address` STRING COMMENT 'IP address from which the email was opened or clicked. Used for geographic and device tracking. May be considered PII in some jurisdictions.',
    `message_reference` STRING COMMENT 'Unique message identifier assigned by the email service provider or SMTP server for tracking and troubleshooting.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this email send record was last updated (e.g., delivery status change, engagement event). Format: yyyy-MM-ddTHH:mm:ss.SSSXXX',
    `open_city` STRING COMMENT 'City name where the email was opened, derived from IP geolocation. Null if not opened or location unavailable.',
    `open_country_code` STRING COMMENT 'Three-letter ISO country code representing the geographic location where the email was opened, derived from IP address. Null if not opened.. Valid values are `^[A-Z]{3}$`',
    `open_flag` BOOLEAN COMMENT 'Indicates whether the recipient opened the email (tracked via pixel or image load). True if opened, False otherwise.',
    `operating_system` STRING COMMENT 'Operating system of the device used to open the email (e.g., iOS, Android, Windows, macOS). Derived from user agent string.',
    `personalization_flag` BOOLEAN COMMENT 'Indicates whether the email content was personalized for the recipient (e.g., name, FFP tier, route preferences). True if personalized, False otherwise.',
    `recipient_email_address` STRING COMMENT 'Email address to which the message was sent. May be anonymous or linked to passenger profile.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `reply_to_address` STRING COMMENT 'Email address specified in the Reply-To field for recipient responses.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `send_priority` STRING COMMENT 'Priority level assigned to this email send for queue processing and delivery scheduling.. Valid values are `high|normal|low`',
    `send_timestamp` TIMESTAMP COMMENT 'Date and time when the email was dispatched from the email service provider. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX',
    `spam_complaint_flag` BOOLEAN COMMENT 'Indicates whether the recipient marked this email as spam or junk. True if complaint filed, False otherwise.',
    `spam_complaint_timestamp` TIMESTAMP COMMENT 'Date and time when the spam complaint was registered. Null if no complaint. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX',
    `subject_line` STRING COMMENT 'Subject line text of the email as sent to the recipient. May be personalized or A/B tested.',
    `suppression_list_flag` BOOLEAN COMMENT 'Indicates whether this email address is on a suppression list (bounce, unsubscribe, complaint) at the time of send. True if suppressed, False otherwise.',
    `total_click_count` STRING COMMENT 'Total number of link clicks recorded for this email (includes multiple clicks by same user).',
    `total_open_count` STRING COMMENT 'Total number of times the email was opened by the recipient (includes multiple opens by same user).',
    `unsubscribe_flag` BOOLEAN COMMENT 'Indicates whether the recipient unsubscribed from the mailing list as a result of this email. True if unsubscribed, False otherwise.',
    `unsubscribe_timestamp` TIMESTAMP COMMENT 'Date and time when the recipient unsubscribed. Null if no unsubscribe event. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX',
    CONSTRAINT pk_email_send PRIMARY KEY(`email_send_id`)
) COMMENT 'Transactional record capturing individual email send events within a campaign execution, representing the dispatch of a marketing or transactional email to a specific passenger or prospect. Stores campaign execution reference, recipient passenger profile reference or anonymous email address, email template reference, send timestamp, delivery status (delivered, bounced hard, bounced soft, filtered), open timestamp, click timestamp, clicked URL, unsubscribe event flag, spam complaint flag, email client, device type, and geographic location of open. Provides the granular email delivery and engagement log used for deliverability management, suppression list maintenance, and individual-level attribution.';

CREATE OR REPLACE TABLE `airlines_ecm`.`marketing`.`destination_content` (
    `destination_content_id` BIGINT COMMENT 'Unique identifier for the destination content asset. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Content approval requires employee authorization for brand compliance, legal clearance, and publication readiness. Airlines track approver identity for audit trails, content governance, and quality co',
    `brand_asset_id` BIGINT COMMENT 'Foreign key linking to marketing.brand_asset. Business justification: destination_content should link to the brand assets used in the content (images, videos, logos). Destination content is built using brand-approved assets. Adding brand_asset_id FK to marketing.brand_a',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: destination_content currently has no direct link to campaign, but destination content is often created as part of marketing campaigns to promote specific routes and destinations. Adding campaign_id FK',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Destination content promotes travel to specific stations/cities for route development and destination awareness. Real business process: content marketing effectiveness measurement by destination stati',
    `parent_destination_content_id` BIGINT COMMENT 'Self-referencing FK on destination_content (parent_destination_content_id)',
    `approval_status` STRING COMMENT 'Current approval state of the content in the governance workflow before publication.. Valid values are `pending|approved|rejected|not_required`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the content was approved for publication.',
    `associated_routes` STRING COMMENT 'Comma-separated list of route codes or origin-destination pairs that this content supports, enabling route-specific marketing.',
    `author_name` STRING COMMENT 'Name of the content creator or author responsible for producing this destination content.',
    `average_time_on_page_seconds` STRING COMMENT 'Average duration in seconds that users spend viewing this content, indicating engagement level.',
    `content_code` STRING COMMENT 'Unique business identifier code for the content asset, used for external reference and content management system integration.. Valid values are `^[A-Z0-9]{8,12}$`',
    `content_status` STRING COMMENT 'Current lifecycle status of the destination content asset in the content management workflow.. Valid values are `draft|published|archived|under_review|scheduled`',
    `content_type` STRING COMMENT 'Classification of the content format and purpose for destination marketing.. Valid values are `destination_guide|travel_blog_article|video|photo_gallery|route_spotlight|seasonal_inspiration`',
    `copyright_holder` STRING COMMENT 'Legal entity or individual holding copyright ownership of this content asset.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this content record was first created in the system.',
    `creative_theme` STRING COMMENT 'Overarching creative or brand theme applied to this content, such as adventure, luxury, family, or cultural exploration.',
    `destination_content_description` STRING COMMENT 'Detailed narrative description of the destination content, including key highlights and intended messaging.',
    `destination_iata_code` STRING COMMENT 'Three-letter IATA airport or city code representing the destination featured in this content.. Valid values are `^[A-Z]{3}$`',
    `expiry_date` DATE COMMENT 'Date when the content is scheduled to expire and be removed from active channels. Null indicates no expiration.',
    `ffp_tier_focus` STRING COMMENT 'Frequent flyer program tier or membership level this content is targeted toward, such as Gold, Platinum, or general members.',
    `file_format` STRING COMMENT 'Technical file format of the content asset, such as HTML, PDF, MP4, JPG, or PNG.. Valid values are `html|pdf|mp4|jpg|png`',
    `file_reference` STRING COMMENT 'Storage path, URL, or digital asset management system reference to the primary content file (video, image, document).',
    `file_size_mb` DECIMAL(18,2) COMMENT 'Size of the content file in megabytes, used for storage and bandwidth planning.',
    `gds_distribution_flag` BOOLEAN COMMENT 'Indicates whether this content is distributed through Global Distribution Systems for travel agent access.',
    `iata_season` STRING COMMENT 'IATA-defined travel season (summer or winter schedule period) that this content is aligned with for seasonal marketing campaigns.. Valid values are `summer|winter|shoulder`',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the language of the content.. Valid values are `^[a-z]{2}$`',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this content record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this content record was last modified or updated.',
    `owning_team` STRING COMMENT 'Marketing team or department responsible for managing and maintaining this content asset.',
    `page_views` BIGINT COMMENT 'Total number of times this content has been viewed across all digital channels.',
    `partner_airline_code` STRING COMMENT 'IATA two-letter or three-letter airline code of a partner carrier featured or co-promoted in this content.. Valid values are `^[A-Z0-9]{2,3}$`',
    `promotional_offer_reference` STRING COMMENT 'Reference code or identifier linking this content to a specific promotional offer or campaign incentive.',
    `publication_date` DATE COMMENT 'Date when the content was first published and made available to customers.',
    `seo_keywords` STRING COMMENT 'Comma-separated list of search engine optimization keywords and phrases to improve content discoverability.',
    `social_shares` STRING COMMENT 'Total count of times this content has been shared on social media platforms.',
    `target_audience_segment` STRING COMMENT 'Primary customer segment this content is designed to engage, such as business travelers, leisure families, or premium customers. [ENUM-REF-CANDIDATE: business_travelers|leisure_families|premium_customers|millennials|adventure_seekers|luxury_travelers|budget_conscious — promote to reference product]',
    `title` STRING COMMENT 'The display title of the destination content asset as shown to customers across digital channels.',
    `usage_restrictions` STRING COMMENT 'Any restrictions or limitations on how and where this content may be used, such as geographic or channel restrictions.',
    `usage_rights` STRING COMMENT 'Description of the permitted usage rights and licensing terms for this content asset.',
    CONSTRAINT pk_destination_content PRIMARY KEY(`destination_content_id`)
) COMMENT 'Master record for destination and travel inspiration content assets managed by the airlines marketing team for use across digital channels, in-flight entertainment, and printed collateral. Captures destination IATA airport or city code, content title, content type (destination guide, travel blog article, video, photo gallery, route spotlight, seasonal travel inspiration), language, author, publication date, expiry date, associated routes served, target audience segment, SEO keywords, content status (draft, published, archived), and performance metrics (page views, time on page, social shares). Provides the content management register for destination marketing and travel inspiration programmes.';

CREATE OR REPLACE TABLE `airlines_ecm`.`marketing`.`event` (
    `event_id` BIGINT COMMENT 'Unique identifier for the marketing event record. Primary key.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Marketing events generate vendor invoices (venue, catering, logistics) that create AP entries. Airlines need to reconcile event spend commitments to AP for payment processing and financial close.',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Marketing events showcasing aircraft types (delivery ceremonies, trade shows, media tours, customer experience events) link event records to aircraft types for logistics planning, stakeholder coordina',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Event approval requires employee authorization for budget commitment, resource allocation, and strategic alignment. Airlines track approver identity for audit trails, financial controls, and governanc',
    `campaign_id` BIGINT COMMENT 'Foreign key reference to the parent marketing campaign under which this event is organized.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Marketing events (trade shows, roadshows, customer appreciation events) are hosted at or target specific station markets for lead generation and brand awareness. Real business process: event-based mar',
    `parent_event_id` BIGINT COMMENT 'Self-referencing FK on event (parent_event_id)',
    `actual_attendance` STRING COMMENT 'Confirmed number of attendees who actually participated in the marketing event, recorded post-event for performance measurement.',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'Total actual expenditure incurred for the marketing event, recorded post-event for financial reconciliation and ROI analysis.',
    `approval_date` DATE COMMENT 'Date when the marketing event received official approval to proceed with planning and execution.',
    `approval_status` STRING COMMENT 'Current approval state of the marketing event within the internal governance and budget approval workflow.. Valid values are `pending|approved|rejected|conditional`',
    `booth_number` STRING COMMENT 'Assigned booth, stand, or exhibition space number at the event venue where the airline is represented.',
    `booth_size_sqm` DECIMAL(18,2) COMMENT 'Total floor area in square meters of the airlines exhibition booth or display space at the event.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total planned budget allocated for the marketing event covering all anticipated costs including venue, materials, staffing, and promotional activities.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the marketing event record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the budget and spend amounts associated with the marketing event.. Valid values are `^[A-Z]{3}$`',
    `end_date` DATE COMMENT 'The date when the marketing event officially concludes, marking the last day of event activities.',
    `estimated_attendance` STRING COMMENT 'Projected number of attendees expected to participate in the marketing event, used for planning and resource allocation.',
    `event_code` STRING COMMENT 'Unique business identifier code for the marketing event, used for external reference and reporting.. Valid values are `^[A-Z0-9]{6,12}$`',
    `event_name` STRING COMMENT 'Full name of the marketing event as it appears in promotional materials and internal documentation.',
    `event_status` STRING COMMENT 'Current lifecycle status of the marketing event indicating its stage from planning through completion.. Valid values are `planned|confirmed|in_progress|completed|cancelled|postponed`',
    `event_type` STRING COMMENT 'Classification of the marketing event by its primary purpose and format. [ENUM-REF-CANDIDATE: trade_show|consumer_travel_fair|press_launch|route_launch_event|corporate_roadshow|travel_agent_fam_trip|sponsorship_activation|airline_awards_ceremony|industry_conference|customer_appreciation_event — promote to reference product]. Valid values are `trade_show|consumer_travel_fair|press_launch|route_launch_event|corporate_roadshow|travel_agent_fam_trip`',
    `host_city` STRING COMMENT 'Name of the city where the marketing event is taking place.',
    `host_country_code` STRING COMMENT 'Three-letter ISO country code for the country hosting the marketing event.. Valid values are `^[A-Z]{3}$`',
    `lead_generation_target` STRING COMMENT 'Target number of qualified leads or prospect contacts the airline aims to capture during the marketing event.',
    `leads_captured` STRING COMMENT 'Actual number of qualified leads or prospect contacts captured during the marketing event, recorded post-event.',
    `manager_email` STRING COMMENT 'Email address of the event manager for coordination and communication purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `manager_name` STRING COMMENT 'Full name of the individual responsible for managing and coordinating all aspects of the marketing event.',
    `market_region` STRING COMMENT 'Geographic market or region that the event is targeting for passenger acquisition or brand presence.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the marketing event record was last updated or modified.',
    `owning_team` STRING COMMENT 'Name of the marketing team, department, or business unit responsible for organizing and executing the event.',
    `participation_type` STRING COMMENT 'The airlines role and level of involvement in the marketing event.. Valid values are `exhibitor|sponsor|attendee|host|speaker|partner`',
    `partner_organizations` STRING COMMENT 'Names of external organizations, tourism boards, or partner airlines collaborating on the marketing event.',
    `post_event_outcome_notes` STRING COMMENT 'Free-text summary of key outcomes, learnings, successes, and areas for improvement captured after the marketing event concludes.',
    `roi_score` DECIMAL(18,2) COMMENT 'Calculated return on investment score for the marketing event, expressed as a ratio or percentage, measuring financial effectiveness.',
    `route_focus` STRING COMMENT 'Specific route, origin-destination pair, or route network that is the primary focus of the marketing event promotion.',
    `start_date` DATE COMMENT 'The date when the marketing event officially begins, marking the first day of event activities.',
    `strategic_objective` STRING COMMENT 'High-level business goal or strategic priority that the marketing event is designed to support, such as brand awareness, route launch, or customer acquisition.',
    `target_audience` STRING COMMENT 'Primary audience segment that the marketing event is designed to reach and engage.. Valid values are `trade|consumer|media|corporate|travel_agent|ffp_member`',
    `venue_address` STRING COMMENT 'Full street address of the event venue including building number, street name, and any suite or floor information.',
    `venue_name` STRING COMMENT 'Name of the specific venue, convention center, hotel, or facility where the event is held.',
    CONSTRAINT pk_event PRIMARY KEY(`event_id`)
) COMMENT 'Master record for marketing events, trade shows, roadshows, press launches, and consumer travel fairs organised or attended by the airline. Captures event name, event type (trade show, consumer travel fair, press launch, route launch event, corporate roadshow, travel agent familiarisation trip, sponsorship activation event, airline awards ceremony), host city, venue, event start and end dates, target audience (trade, consumer, media, corporate), airline participation type (exhibitor, sponsor, attendee, host), estimated attendance, actual attendance, budget, actual spend, owning team, and post-event outcome notes. Provides the authoritative register of all marketing event commitments and activations.';

CREATE OR REPLACE TABLE `airlines_ecm`.`marketing`.`campaign_exposure` (
    `campaign_exposure_id` BIGINT COMMENT 'Unique identifier for this campaign exposure record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to the marketing campaign to which the member was exposed',
    `ffp_member_id` BIGINT COMMENT 'Foreign key linking to the FFP member who was exposed to the campaign',
    `attributed_revenue` DECIMAL(18,2) COMMENT 'Revenue amount attributed to this specific campaign exposure, used for ROI calculation and campaign performance measurement. Explicitly identified in detection phase as relationship data.',
    `attributed_revenue_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the attributed revenue amount.',
    `attribution_model` STRING COMMENT 'Attribution model used to calculate attributed revenue for this exposure (first-touch, last-touch, linear, time-decay, position-based).',
    `conversion_flag` BOOLEAN COMMENT 'Indicates whether the member converted (completed desired action such as booking, purchase, enrollment) as a result of this campaign exposure. Explicitly identified in detection phase as relationship data.',
    `conversion_timestamp` TIMESTAMP COMMENT 'Date and time when the member converted as a result of the campaign, if conversion_flag is true.',
    `creative_variant` STRING COMMENT 'Specific creative variant or A/B test version shown to this member during this exposure.',
    `exposure_channel` STRING COMMENT 'Channel through which the member was exposed to the campaign (email, SMS, digital ad, social media, etc.). Explicitly identified in detection phase as relationship data.',
    `exposure_timestamp` TIMESTAMP COMMENT 'Date and time when the member was exposed to the campaign. Explicitly identified in detection phase as relationship data.',
    `impression_count` STRING COMMENT 'Number of times this member was exposed to this campaign (for frequency capping and saturation analysis).',
    `member_segment_at_exposure` STRING COMMENT 'Member segment classification at the time of exposure, captured for campaign effectiveness analysis by segment.',
    `response_flag` BOOLEAN COMMENT 'Indicates whether the member responded to the campaign exposure (clicked, opened, engaged). Explicitly identified in detection phase as relationship data.',
    `response_timestamp` TIMESTAMP COMMENT 'Date and time when the member responded to the campaign, if response_flag is true.',
    `tier_level_at_exposure` STRING COMMENT 'FFP tier level of the member at the time of exposure, captured for tier-specific campaign performance analysis.',
    CONSTRAINT pk_campaign_exposure PRIMARY KEY(`campaign_exposure_id`)
) COMMENT 'This association product represents the exposure event between FFP members and marketing campaigns. It captures when and how a member was exposed to a campaign, their response behavior, and any attributed business value. Each record links one FFP member to one campaign with attributes that exist only in the context of this specific exposure interaction. This is the foundation for campaign attribution, member journey analysis, and marketing ROI measurement.. Existence Justification: In airline marketing operations, FFP members are exposed to multiple campaigns over time (email promotions, route launches, seasonal offers, tier upgrade campaigns), and each campaign reaches thousands or millions of members across multiple channels. The business actively manages and measures these exposures as discrete events with specific timestamps, channels, response behaviors, and attributed revenue. Marketing teams query show me all exposures for campaign X and show me all campaigns member Y was exposed to as core attribution and journey analysis workflows.';

CREATE OR REPLACE TABLE `airlines_ecm`.`marketing`.`partner_organization` (
    `partner_organization_id` BIGINT COMMENT 'Primary key for partner_organization',
    `parent_partner_organization_id` BIGINT COMMENT 'Self-referencing FK on partner_organization (parent_partner_organization_id)',
    `alliance_membership` STRING COMMENT 'Global airline alliance to which the partner organization belongs, if applicable.',
    `annual_passenger_volume` BIGINT COMMENT 'Estimated or actual annual passenger volume attributed to this partnership relationship.',
    `annual_revenue_contribution` DECIMAL(18,2) COMMENT 'Estimated or actual annual revenue contribution from this partnership in the airlines reporting currency.',
    `brand_visibility_level` STRING COMMENT 'Level of brand visibility and co-branding prominence granted to the partner in marketing materials.',
    `codeshare_enabled` BOOLEAN COMMENT 'Indicates whether codeshare flight arrangements are enabled with this airline partner.',
    `commission_rate_percentage` DECIMAL(18,2) COMMENT 'Standard commission rate percentage paid to or received from the partner organization.',
    `contract_renewal_date` DATE COMMENT 'Next scheduled date for partnership contract renewal or review.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this partner organization record was first created in the system.',
    `data_sharing_agreement` BOOLEAN COMMENT 'Indicates whether a formal data sharing agreement exists with the partner organization.',
    `gdpr_compliant` BOOLEAN COMMENT 'Indicates whether the partner organization has been verified as GDPR compliant for data processing activities.',
    `headquarters_city` STRING COMMENT 'City where the partner organizations headquarters is located.',
    `headquarters_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the partner organizations headquarters location.',
    `iata_code` STRING COMMENT 'Two or three-character IATA airline designator code for airline partners.',
    `icao_code` STRING COMMENT 'Three-letter ICAO airline designator code for airline partners.',
    `interline_agreement` BOOLEAN COMMENT 'Indicates whether an interline ticketing agreement exists with this airline partner.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this partner organization record was last modified.',
    `legal_entity_identifier` STRING COMMENT 'ISO 17442 compliant Legal Entity Identifier for the partner organization.',
    `loyalty_program_integration` BOOLEAN COMMENT 'Indicates whether the partner organization is integrated with the airlines loyalty program for points earning and redemption.',
    `marketing_campaign_participation` BOOLEAN COMMENT 'Indicates whether the partner organization actively participates in co-branded marketing campaigns.',
    `net_promoter_score` STRING COMMENT 'Net Promoter Score measuring the partner organizations likelihood to recommend the airline to other potential partners, ranging from -100 to +100.',
    `notes` STRING COMMENT 'Free-text notes and comments regarding the partnership relationship, special arrangements, or historical context.',
    `organization_code` STRING COMMENT 'Short alphanumeric code used to identify the partner organization in operational systems and marketing materials.',
    `organization_name` STRING COMMENT 'Official legal or trading name of the partner organization.',
    `partner_satisfaction_score` DECIMAL(18,2) COMMENT 'Satisfaction score from partner relationship surveys, typically on a scale of 0 to 10.',
    `partner_type` STRING COMMENT 'Classification of the partner organization by industry or service category.',
    `partnership_end_date` DATE COMMENT 'Date when the partnership relationship ended or is scheduled to end. Null for active ongoing partnerships.',
    `partnership_start_date` DATE COMMENT 'Date when the partnership relationship officially commenced.',
    `partnership_status` STRING COMMENT 'Current lifecycle status of the partnership relationship.',
    `partnership_tier` STRING COMMENT 'Strategic classification indicating the level of partnership engagement and benefits.',
    `preferred_communication_language` STRING COMMENT 'ISO 639-1 two-letter language code for the partner organizations preferred communication language.',
    `primary_contact_email` STRING COMMENT 'Primary email address for partnership communications and coordination.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for partnership communications.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of revenue shared with the partner organization under the partnership agreement.',
    `tax_identification_number` STRING COMMENT 'Tax identification number or equivalent for the partner organization in their primary jurisdiction.',
    `website_url` STRING COMMENT 'Official website URL of the partner organization.',
    CONSTRAINT pk_partner_organization PRIMARY KEY(`partner_organization_id`)
) COMMENT 'Master reference table for partner_organization. Referenced by partner_organization_id.';

CREATE OR REPLACE TABLE `airlines_ecm`.`marketing`.`ab_test_variant` (
    `ab_test_variant_id` BIGINT COMMENT 'Primary key for ab_test_variant',
    `ab_test_id` BIGINT COMMENT 'Reference to the parent A/B test experiment to which this variant belongs.',
    `control_ab_test_variant_id` BIGINT COMMENT 'Self-referencing FK on ab_test_variant (control_ab_test_variant_id)',
    `call_to_action_text` STRING COMMENT 'Text displayed on the primary call-to-action button or link in this variant (e.g., Book Now, Learn More, Claim Offer).',
    `call_to_action_url` STRING COMMENT 'Destination URL for the call-to-action link, including tracking parameters for attribution.',
    `channel` STRING COMMENT 'Digital or physical channel through which this variant is delivered to customers.',
    `conversion_count` BIGINT COMMENT 'Total number of conversions (desired actions) achieved by this variant during the test.',
    `cost` DECIMAL(18,2) COMMENT 'Total cost incurred to execute this variant, including creative production, offer fulfillment, and channel costs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this variant record was first created in the system.',
    `creative_asset_url` STRING COMMENT 'URL or file path to the creative asset (image, video, HTML template) used in this variant.',
    `ab_test_variant_description` STRING COMMENT 'Detailed description of the variant configuration, including creative elements, messaging, offers, and user experience changes being tested.',
    `effective_end_date` DATE COMMENT 'Date when this variant was deactivated or the test concluded. Null for ongoing variants.',
    `effective_start_date` DATE COMMENT 'Date when this variant became active and began receiving traffic in the A/B test.',
    `expected_lift_percentage` DECIMAL(18,2) COMMENT 'Anticipated percentage improvement in the primary success metric compared to control variant.',
    `hypothesis` STRING COMMENT 'The business hypothesis being tested with this variant (e.g., Offering 20% discount will increase conversion by 15%).',
    `is_winner` BOOLEAN COMMENT 'Boolean flag indicating whether this variant was declared the winner of the A/B test based on statistical significance and business criteria.',
    `messaging_content` STRING COMMENT 'Text content or copy used in the variant, including headlines, body text, and call-to-action messaging.',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified this variant configuration.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this variant record was last updated.',
    `notes` STRING COMMENT 'Free-text notes or comments about this variant, including learnings, observations, or special considerations.',
    `offer_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for monetary offers (e.g., USD, EUR, GBP).',
    `offer_type` STRING COMMENT 'Type of promotional offer included in the variant: discount (price reduction), upgrade (cabin/service upgrade), bonus_miles (loyalty points), free_service (complimentary amenity), none (no offer).',
    `offer_value` DECIMAL(18,2) COMMENT 'Monetary value or quantity of the offer (e.g., discount amount in currency, number of bonus miles, upgrade value).',
    `personalization_rules` STRING COMMENT 'JSON or text description of dynamic personalization rules applied to this variant based on customer attributes or behavior.',
    `priority_rank` STRING COMMENT 'Numeric ranking indicating the priority or sequence of this variant within the test (1 = highest priority).',
    `revenue_generated` DECIMAL(18,2) COMMENT 'Total revenue attributed to this variant during the test period, measured in the tests base currency.',
    `sample_size` BIGINT COMMENT 'Total number of customers or impressions exposed to this variant during the test period.',
    `statistical_significance_level` DECIMAL(18,2) COMMENT 'P-value or confidence level achieved by this variant in the test results (e.g., 0.9500 for 95% confidence).',
    `ab_test_variant_status` STRING COMMENT 'Current lifecycle status of the variant: draft (being configured), active (live in test), paused (temporarily stopped), completed (test finished), archived (historical record).',
    `target_segment` STRING COMMENT 'Customer segment or audience criteria targeted by this variant (e.g., frequent flyers, leisure travelers, business class passengers).',
    `traffic_allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of total test traffic allocated to this variant (0.00 to 100.00). Sum across all variants in a test should equal 100.',
    `variant_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the variant within the test (e.g., CONTROL, VAR_A, VAR_B).',
    `variant_name` STRING COMMENT 'Human-readable name describing the variant (e.g., Control Group, Discount Offer 20%, Premium Messaging).',
    `variant_type` STRING COMMENT 'Classification of the variant role in the experiment: control (baseline), treatment (experimental), or holdout (excluded from test).',
    `created_by` STRING COMMENT 'Username or identifier of the marketing user who created this variant configuration.',
    CONSTRAINT pk_ab_test_variant PRIMARY KEY(`ab_test_variant_id`)
) COMMENT 'Master reference table for ab_test_variant. Referenced by ab_test_variant_id.';

CREATE OR REPLACE TABLE `airlines_ecm`.`marketing`.`contract_deliverable` (
    `contract_deliverable_id` BIGINT COMMENT 'Primary key for contract_deliverable',
    `co_marketing_agreement_id` BIGINT COMMENT 'Reference to the parent marketing contract or agreement under which this deliverable is defined.',
    `employee_id` BIGINT COMMENT 'Reference to the internal team, department, or employee responsible for executing this deliverable.',
    `vendor_id` BIGINT COMMENT 'Reference to the external vendor or agency contracted to deliver this item, if applicable.',
    `parent_contract_deliverable_id` BIGINT COMMENT 'Self-referencing FK on contract_deliverable (parent_contract_deliverable_id)',
    `acceptance_criteria` STRING COMMENT 'Defined criteria or conditions that must be met for this deliverable to be considered complete and accepted.',
    `acceptance_date` DATE COMMENT 'Date when the deliverable was formally accepted by the stakeholder or client.',
    `accepted_by` STRING COMMENT 'Name or identifier of the individual who formally accepted the deliverable.',
    `actual_end_date` DATE COMMENT 'Actual date when this deliverable was completed or closed.',
    `actual_metric_value` DECIMAL(18,2) COMMENT 'Actual achieved value for the performance metric after deliverable execution.',
    `actual_start_date` DATE COMMENT 'Actual date when work on this deliverable commenced.',
    `channel` STRING COMMENT 'Primary marketing channel or medium through which this deliverable will be distributed or executed.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of work completed for this deliverable, ranging from 0.00 to 100.00.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract deliverable record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the deliverable value amount.',
    `deliverable_category` STRING COMMENT 'Broader classification or grouping of the deliverable for organizational and reporting purposes.',
    `deliverable_code` STRING COMMENT 'Unique business identifier or code assigned to this contract deliverable for external reference and tracking.',
    `deliverable_name` STRING COMMENT 'Human-readable name or title of the contract deliverable.',
    `deliverable_status` STRING COMMENT 'Current lifecycle status of the contract deliverable indicating its progress and state.',
    `deliverable_type` STRING COMMENT 'Classification of the deliverable by its nature or category within the marketing contract.',
    `deliverable_value_amount` DECIMAL(18,2) COMMENT 'Monetary value or contract price allocated to this specific deliverable.',
    `dependencies` STRING COMMENT 'Description of other deliverables or tasks that this deliverable depends on or is blocked by.',
    `contract_deliverable_description` STRING COMMENT 'Detailed textual description of the contract deliverable, including scope, objectives, and key requirements.',
    `geographic_scope` STRING COMMENT 'Geographic region or market where this deliverable will be deployed or is applicable.',
    `is_milestone` BOOLEAN COMMENT 'Flag indicating whether this deliverable represents a major milestone within the contract.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract deliverable record was last updated or modified.',
    `notes` STRING COMMENT 'Additional notes, comments, or observations related to this contract deliverable.',
    `performance_metric` STRING COMMENT 'Key performance indicator or metric used to measure the success of this deliverable.',
    `priority_level` STRING COMMENT 'Business priority assigned to this deliverable indicating its relative importance within the contract.',
    `risk_level` STRING COMMENT 'Assessment of the risk level associated with successful completion of this deliverable.',
    `scheduled_end_date` DATE COMMENT 'Planned date by which this deliverable is scheduled to be completed.',
    `scheduled_start_date` DATE COMMENT 'Planned date when work on this deliverable is scheduled to begin.',
    `target_audience` STRING COMMENT 'Intended audience or customer segment that this marketing deliverable is designed to reach.',
    `target_metric_value` DECIMAL(18,2) COMMENT 'Target or goal value for the performance metric associated with this deliverable.',
    CONSTRAINT pk_contract_deliverable PRIMARY KEY(`contract_deliverable_id`)
) COMMENT 'Master reference table for contract_deliverable. Referenced by contract_deliverable_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_parent_campaign_id` FOREIGN KEY (`parent_campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `airlines_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `airlines_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_digital_campaign_creative_id` FOREIGN KEY (`digital_campaign_creative_id`) REFERENCES `airlines_ecm`.`marketing`.`digital_campaign_creative`(`digital_campaign_creative_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_retry_campaign_execution_id` FOREIGN KEY (`retry_campaign_execution_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign_execution`(`campaign_execution_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ADD CONSTRAINT `fk_marketing_campaign_response_campaign_execution_id` FOREIGN KEY (`campaign_execution_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign_execution`(`campaign_execution_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ADD CONSTRAINT `fk_marketing_campaign_response_prior_campaign_response_id` FOREIGN KEY (`prior_campaign_response_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign_response`(`campaign_response_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ADD CONSTRAINT `fk_marketing_audience_segment_parent_audience_segment_id` FOREIGN KEY (`parent_audience_segment_id`) REFERENCES `airlines_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ADD CONSTRAINT `fk_marketing_segment_membership_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `airlines_ecm`.`marketing`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ADD CONSTRAINT `fk_marketing_segment_membership_superseded_segment_membership_id` FOREIGN KEY (`superseded_segment_membership_id`) REFERENCES `airlines_ecm`.`marketing`.`segment_membership`(`segment_membership_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ADD CONSTRAINT `fk_marketing_channel_parent_channel_id` FOREIGN KEY (`parent_channel_id`) REFERENCES `airlines_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ADD CONSTRAINT `fk_marketing_communication_preference_superseded_communication_preference_id` FOREIGN KEY (`superseded_communication_preference_id`) REFERENCES `airlines_ecm`.`marketing`.`communication_preference`(`communication_preference_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ADD CONSTRAINT `fk_marketing_nps_survey_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ADD CONSTRAINT `fk_marketing_nps_survey_superseded_nps_survey_id` FOREIGN KEY (`superseded_nps_survey_id`) REFERENCES `airlines_ecm`.`marketing`.`nps_survey`(`nps_survey_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ADD CONSTRAINT `fk_marketing_survey_response_nps_survey_id` FOREIGN KEY (`nps_survey_id`) REFERENCES `airlines_ecm`.`marketing`.`nps_survey`(`nps_survey_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ADD CONSTRAINT `fk_marketing_survey_response_superseded_survey_response_id` FOREIGN KEY (`superseded_survey_response_id`) REFERENCES `airlines_ecm`.`marketing`.`survey_response`(`survey_response_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ADD CONSTRAINT `fk_marketing_market_research_study_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ADD CONSTRAINT `fk_marketing_market_research_study_follow_up_market_research_study_id` FOREIGN KEY (`follow_up_market_research_study_id`) REFERENCES `airlines_ecm`.`marketing`.`market_research_study`(`market_research_study_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ADD CONSTRAINT `fk_marketing_brand_asset_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ADD CONSTRAINT `fk_marketing_brand_asset_derived_from_brand_asset_id` FOREIGN KEY (`derived_from_brand_asset_id`) REFERENCES `airlines_ecm`.`marketing`.`brand_asset`(`brand_asset_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ADD CONSTRAINT `fk_marketing_digital_campaign_creative_ab_test_variant_id` FOREIGN KEY (`ab_test_variant_id`) REFERENCES `airlines_ecm`.`marketing`.`ab_test_variant`(`ab_test_variant_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ADD CONSTRAINT `fk_marketing_digital_campaign_creative_brand_asset_id` FOREIGN KEY (`brand_asset_id`) REFERENCES `airlines_ecm`.`marketing`.`brand_asset`(`brand_asset_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ADD CONSTRAINT `fk_marketing_digital_campaign_creative_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ADD CONSTRAINT `fk_marketing_digital_campaign_creative_revised_digital_campaign_creative_id` FOREIGN KEY (`revised_digital_campaign_creative_id`) REFERENCES `airlines_ecm`.`marketing`.`digital_campaign_creative`(`digital_campaign_creative_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ADD CONSTRAINT `fk_marketing_spend_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ADD CONSTRAINT `fk_marketing_spend_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `airlines_ecm`.`marketing`.`channel`(`channel_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ADD CONSTRAINT `fk_marketing_spend_adjustment_spend_id` FOREIGN KEY (`adjustment_spend_id`) REFERENCES `airlines_ecm`.`marketing`.`spend`(`spend_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ADD CONSTRAINT `fk_marketing_sponsorship_partner_organization_id` FOREIGN KEY (`partner_organization_id`) REFERENCES `airlines_ecm`.`marketing`.`partner_organization`(`partner_organization_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ADD CONSTRAINT `fk_marketing_sponsorship_renewed_sponsorship_id` FOREIGN KEY (`renewed_sponsorship_id`) REFERENCES `airlines_ecm`.`marketing`.`sponsorship`(`sponsorship_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ADD CONSTRAINT `fk_marketing_sponsorship_activation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ADD CONSTRAINT `fk_marketing_sponsorship_activation_contract_deliverable_id` FOREIGN KEY (`contract_deliverable_id`) REFERENCES `airlines_ecm`.`marketing`.`contract_deliverable`(`contract_deliverable_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ADD CONSTRAINT `fk_marketing_sponsorship_activation_sponsorship_id` FOREIGN KEY (`sponsorship_id`) REFERENCES `airlines_ecm`.`marketing`.`sponsorship`(`sponsorship_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ADD CONSTRAINT `fk_marketing_sponsorship_activation_parent_sponsorship_activation_id` FOREIGN KEY (`parent_sponsorship_activation_id`) REFERENCES `airlines_ecm`.`marketing`.`sponsorship_activation`(`sponsorship_activation_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ADD CONSTRAINT `fk_marketing_passenger_touchpoint_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ADD CONSTRAINT `fk_marketing_passenger_touchpoint_digital_campaign_creative_id` FOREIGN KEY (`digital_campaign_creative_id`) REFERENCES `airlines_ecm`.`marketing`.`digital_campaign_creative`(`digital_campaign_creative_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ADD CONSTRAINT `fk_marketing_passenger_touchpoint_previous_passenger_touchpoint_id` FOREIGN KEY (`previous_passenger_touchpoint_id`) REFERENCES `airlines_ecm`.`marketing`.`passenger_touchpoint`(`passenger_touchpoint_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ADD CONSTRAINT `fk_marketing_ab_test_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ADD CONSTRAINT `fk_marketing_ab_test_iterated_ab_test_id` FOREIGN KEY (`iterated_ab_test_id`) REFERENCES `airlines_ecm`.`marketing`.`ab_test`(`ab_test_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ADD CONSTRAINT `fk_marketing_competitor_fare_watch_previous_competitor_fare_watch_id` FOREIGN KEY (`previous_competitor_fare_watch_id`) REFERENCES `airlines_ecm`.`marketing`.`competitor_fare_watch`(`competitor_fare_watch_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ADD CONSTRAINT `fk_marketing_promotional_fare_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ADD CONSTRAINT `fk_marketing_promotional_fare_superseded_promotional_fare_id` FOREIGN KEY (`superseded_promotional_fare_id`) REFERENCES `airlines_ecm`.`marketing`.`promotional_fare`(`promotional_fare_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ADD CONSTRAINT `fk_marketing_co_marketing_agreement_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ADD CONSTRAINT `fk_marketing_co_marketing_agreement_partner_organization_id` FOREIGN KEY (`partner_organization_id`) REFERENCES `airlines_ecm`.`marketing`.`partner_organization`(`partner_organization_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ADD CONSTRAINT `fk_marketing_co_marketing_agreement_renewed_co_marketing_agreement_id` FOREIGN KEY (`renewed_co_marketing_agreement_id`) REFERENCES `airlines_ecm`.`marketing`.`co_marketing_agreement`(`co_marketing_agreement_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ADD CONSTRAINT `fk_marketing_social_media_post_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ADD CONSTRAINT `fk_marketing_social_media_post_digital_campaign_creative_id` FOREIGN KEY (`digital_campaign_creative_id`) REFERENCES `airlines_ecm`.`marketing`.`digital_campaign_creative`(`digital_campaign_creative_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ADD CONSTRAINT `fk_marketing_social_media_post_reply_to_social_media_post_id` FOREIGN KEY (`reply_to_social_media_post_id`) REFERENCES `airlines_ecm`.`marketing`.`social_media_post`(`social_media_post_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ADD CONSTRAINT `fk_marketing_email_send_campaign_execution_id` FOREIGN KEY (`campaign_execution_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign_execution`(`campaign_execution_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ADD CONSTRAINT `fk_marketing_email_send_digital_campaign_creative_id` FOREIGN KEY (`digital_campaign_creative_id`) REFERENCES `airlines_ecm`.`marketing`.`digital_campaign_creative`(`digital_campaign_creative_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ADD CONSTRAINT `fk_marketing_email_send_resend_email_send_id` FOREIGN KEY (`resend_email_send_id`) REFERENCES `airlines_ecm`.`marketing`.`email_send`(`email_send_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ADD CONSTRAINT `fk_marketing_destination_content_brand_asset_id` FOREIGN KEY (`brand_asset_id`) REFERENCES `airlines_ecm`.`marketing`.`brand_asset`(`brand_asset_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ADD CONSTRAINT `fk_marketing_destination_content_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ADD CONSTRAINT `fk_marketing_destination_content_parent_destination_content_id` FOREIGN KEY (`parent_destination_content_id`) REFERENCES `airlines_ecm`.`marketing`.`destination_content`(`destination_content_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`event` ADD CONSTRAINT `fk_marketing_event_parent_event_id` FOREIGN KEY (`parent_event_id`) REFERENCES `airlines_ecm`.`marketing`.`event`(`event_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_exposure` ADD CONSTRAINT `fk_marketing_campaign_exposure_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `airlines_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`partner_organization` ADD CONSTRAINT `fk_marketing_partner_organization_parent_partner_organization_id` FOREIGN KEY (`parent_partner_organization_id`) REFERENCES `airlines_ecm`.`marketing`.`partner_organization`(`partner_organization_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test_variant` ADD CONSTRAINT `fk_marketing_ab_test_variant_ab_test_id` FOREIGN KEY (`ab_test_id`) REFERENCES `airlines_ecm`.`marketing`.`ab_test`(`ab_test_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test_variant` ADD CONSTRAINT `fk_marketing_ab_test_variant_control_ab_test_variant_id` FOREIGN KEY (`control_ab_test_variant_id`) REFERENCES `airlines_ecm`.`marketing`.`ab_test_variant`(`ab_test_variant_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`contract_deliverable` ADD CONSTRAINT `fk_marketing_contract_deliverable_co_marketing_agreement_id` FOREIGN KEY (`co_marketing_agreement_id`) REFERENCES `airlines_ecm`.`marketing`.`co_marketing_agreement`(`co_marketing_agreement_id`);
ALTER TABLE `airlines_ecm`.`marketing`.`contract_deliverable` ADD CONSTRAINT `fk_marketing_contract_deliverable_parent_contract_deliverable_id` FOREIGN KEY (`parent_contract_deliverable_id`) REFERENCES `airlines_ecm`.`marketing`.`contract_deliverable`(`contract_deliverable_id`);

-- ========= TAGS =========
ALTER SCHEMA `airlines_ecm`.`marketing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `airlines_ecm`.`marketing` SET TAGS ('dbx_domain' = 'marketing');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Manager Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `parent_campaign_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revision_required');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `booking_class_restriction` SET TAGS ('dbx_business_glossary_term' = 'Booking Class Restriction');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `booking_window_end` SET TAGS ('dbx_business_glossary_term' = 'Booking Window End');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `booking_window_start` SET TAGS ('dbx_business_glossary_term' = 'Booking Window Start');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `budget_currency` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `budget_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `cabin_class_focus` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class Focus');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `cabin_class_focus` SET TAGS ('dbx_value_regex' = 'economy|premium_economy|business|first|all');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Code');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_description` SET TAGS ('dbx_business_glossary_term' = 'Campaign Description');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|paused|completed|cancelled');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_value_regex' = 'email|digital|social|sem|seo|display');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `creative_theme` SET TAGS ('dbx_business_glossary_term' = 'Creative Theme');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `ffp_tier_focus` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Tier Focus');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `ffp_tier_focus` SET TAGS ('dbx_value_regex' = 'all|base|silver|gold|platinum|elite');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `gds_distribution_flag` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Distribution Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `iata_season` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Season');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `iata_season` SET TAGS ('dbx_value_regex' = 'summer|winter');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Campaign Objective');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `objective` SET TAGS ('dbx_value_regex' = 'acquisition|retention|upsell|reactivation|awareness|engagement');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `origin_destination_focus` SET TAGS ('dbx_business_glossary_term' = 'Origin-Destination (O-D) Focus');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Team');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `partner_airline_code` SET TAGS ('dbx_business_glossary_term' = 'Partner Airline Code');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `partner_airline_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `promotional_offer` SET TAGS ('dbx_business_glossary_term' = 'Promotional Offer');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `target_audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Segment');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `target_market` SET TAGS ('dbx_business_glossary_term' = 'Target Market');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `travel_date_range_end` SET TAGS ('dbx_business_glossary_term' = 'Travel Date Range End');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign` ALTER COLUMN `travel_date_range_start` SET TAGS ('dbx_business_glossary_term' = 'Travel Date Range Start');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `campaign_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Execution ID');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment ID');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `digital_campaign_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Campaign Creative Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `retry_campaign_execution_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_value_regex' = '^[A-Z]$|control');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `attributed_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Attributed Revenue Amount');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `attributed_revenue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `attributed_revenue_currency` SET TAGS ('dbx_business_glossary_term' = 'Attributed Revenue Currency');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `attributed_revenue_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `bounce_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Bounce Rate Percent');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `bounced_count` SET TAGS ('dbx_business_glossary_term' = 'Bounced Count');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'email|sms|push_notification|display_ad|social_media|paid_search');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `click_through_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Click-Through Rate (CTR) Percent');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `clicked_count` SET TAGS ('dbx_business_glossary_term' = 'Clicked Count');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `contacts_reached` SET TAGS ('dbx_business_glossary_term' = 'Contacts Reached');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `conversion_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Conversion Rate Percent');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `converted_count` SET TAGS ('dbx_business_glossary_term' = 'Converted Count');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `delivered_count` SET TAGS ('dbx_business_glossary_term' = 'Delivered Count');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `delivery_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Delivery Rate Percent');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `deployment_platform` SET TAGS ('dbx_business_glossary_term' = 'Deployment Platform');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `error_count` SET TAGS ('dbx_business_glossary_term' = 'Error Count');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `execution_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Execution Cost Amount');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `execution_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `execution_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Execution Cost Currency');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `execution_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `execution_name` SET TAGS ('dbx_business_glossary_term' = 'Execution Name');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `execution_number` SET TAGS ('dbx_business_glossary_term' = 'Execution Number');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `execution_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Execution Status');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `execution_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|in_progress|completed|failed|cancelled');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `external_execution_reference` SET TAGS ('dbx_business_glossary_term' = 'External Execution ID');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `open_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Open Rate Percent');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `opened_count` SET TAGS ('dbx_business_glossary_term' = 'Opened Count');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `scheduled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `send_volume` SET TAGS ('dbx_business_glossary_term' = 'Send Volume');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `target_audience_size` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Size');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `unsubscribe_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Unsubscribe Rate Percent');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_execution` ALTER COLUMN `unsubscribed_count` SET TAGS ('dbx_business_glossary_term' = 'Unsubscribed Count');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `campaign_response_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Response Identifier (ID)');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `ancillary_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `campaign_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Execution Identifier (ID)');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Profile Identifier (ID)');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `pnr_id` SET TAGS ('dbx_business_glossary_term' = 'Pnr Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `pricing_record_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Record Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Ticket Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `prior_campaign_response_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `anonymous_visitor_reference` SET TAGS ('dbx_business_glossary_term' = 'Anonymous Visitor Identifier (ID)');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `attributed_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Attributed Revenue Amount');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `attributed_revenue_currency` SET TAGS ('dbx_business_glossary_term' = 'Attributed Revenue Currency Code');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `attributed_revenue_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `browser` SET TAGS ('dbx_business_glossary_term' = 'Web Browser');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `call_to_action` SET TAGS ('dbx_business_glossary_term' = 'Call to Action (CTA)');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Marketing Channel');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'email|sms|push|web|mobile_app|social_media');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City Name');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `complaint_type` SET TAGS ('dbx_business_glossary_term' = 'Complaint Type');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `complaint_type` SET TAGS ('dbx_value_regex' = 'spam|inappropriate_content|frequency|other');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `conversion_flag` SET TAGS ('dbx_business_glossary_term' = 'Conversion Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|unknown');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `email_client` SET TAGS ('dbx_business_glossary_term' = 'Email Client');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `email_client` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `email_client` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `engagement_score` SET TAGS ('dbx_business_glossary_term' = 'Engagement Score');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `form_data` SET TAGS ('dbx_business_glossary_term' = 'Form Submission Data');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `landing_page_url` SET TAGS ('dbx_business_glossary_term' = 'Landing Page Uniform Resource Locator (URL)');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `referrer_url` SET TAGS ('dbx_business_glossary_term' = 'Referrer Uniform Resource Locator (URL)');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `response_type` SET TAGS ('dbx_business_glossary_term' = 'Response Type');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `response_type` SET TAGS ('dbx_value_regex' = 'click|open|conversion|unsubscribe|complaint|form_submission');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `session_reference` SET TAGS ('dbx_business_glossary_term' = 'Session Identifier (ID)');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `time_to_conversion_seconds` SET TAGS ('dbx_business_glossary_term' = 'Time to Conversion in Seconds');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `unsubscribe_reason` SET TAGS ('dbx_business_glossary_term' = 'Unsubscribe Reason');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `utm_campaign` SET TAGS ('dbx_business_glossary_term' = 'Urchin Tracking Module (UTM) Campaign');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `utm_content` SET TAGS ('dbx_business_glossary_term' = 'Urchin Tracking Module (UTM) Content');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `utm_medium` SET TAGS ('dbx_business_glossary_term' = 'Urchin Tracking Module (UTM) Medium');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_response` ALTER COLUMN `utm_source` SET TAGS ('dbx_business_glossary_term' = 'Urchin Tracking Module (UTM) Source');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment Identifier (ID)');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `parent_audience_segment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_segment_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Description');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `audience_segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived|deprecated');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `business_objective` SET TAGS ('dbx_business_glossary_term' = 'Business Objective');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `campaign_count` SET TAGS ('dbx_business_glossary_term' = 'Campaign Count');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `consent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Required Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `definition_criteria` SET TAGS ('dbx_business_glossary_term' = 'Definition Criteria');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `derivation_method` SET TAGS ('dbx_business_glossary_term' = 'Derivation Method');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `derivation_method` SET TAGS ('dbx_value_regex' = 'rule_based|ml_clustering|ml_classification|manual_upload|third_party');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `exclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Criteria');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `gdpr_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `last_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Refresh Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `loyalty_tier_filter` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Loyalty Tier Filter');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `max_rfm_score` SET TAGS ('dbx_business_glossary_term' = 'Maximum Recency Frequency Monetary (RFM) Score');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `min_rfm_score` SET TAGS ('dbx_business_glossary_term' = 'Minimum Recency Frequency Monetary (RFM) Score');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `model_code` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning (ML) Model Identifier (ID)');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning (ML) Model Version');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `next_refresh_date` SET TAGS ('dbx_business_glossary_term' = 'Next Refresh Date');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Team');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `performance_metric` SET TAGS ('dbx_business_glossary_term' = 'Performance Metric');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_business_glossary_term' = 'Refresh Frequency');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `route_affinity` SET TAGS ('dbx_business_glossary_term' = 'Route Affinity');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `segment_size` SET TAGS ('dbx_business_glossary_term' = 'Segment Size');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Segment Type');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_value_regex' = 'behavioural|demographic|geographic|psychographic|rfm_based|loyalty_tier_based');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Segment Tags');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `target_channel` SET TAGS ('dbx_business_glossary_term' = 'Target Channel');
ALTER TABLE `airlines_ecm`.`marketing`.`audience_segment` ALTER COLUMN `creation_date` SET TAGS ('dbx_business_glossary_term' = 'Creation Date');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ALTER COLUMN `segment_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership Identifier (ID)');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Segment Identifier (ID)');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By User Identifier (ID)');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Profile Identifier (ID)');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ALTER COLUMN `superseded_segment_membership_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ALTER COLUMN `assignment_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Assignment Confidence Score');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ALTER COLUMN `assignment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason Code');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ALTER COLUMN `assignment_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason Description');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ALTER COLUMN `assignment_source` SET TAGS ('dbx_business_glossary_term' = 'Assignment Source');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ALTER COLUMN `assignment_source` SET TAGS ('dbx_value_regex' = 'rule_engine|ml_model|manual_override|batch_import|api_integration|campaign_response');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ALTER COLUMN `campaign_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Campaign Eligibility Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ALTER COLUMN `last_campaign_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Campaign Contact Date');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ALTER COLUMN `membership_end_date` SET TAGS ('dbx_business_glossary_term' = 'Membership End Date');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ALTER COLUMN `membership_start_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Start Date');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|suspended');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Membership Notes');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ALTER COLUMN `opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ALTER COLUMN `segment_entry_channel` SET TAGS ('dbx_business_glossary_term' = 'Segment Entry Channel');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ALTER COLUMN `segment_exit_reason` SET TAGS ('dbx_business_glossary_term' = 'Segment Exit Reason');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ALTER COLUMN `segment_version` SET TAGS ('dbx_business_glossary_term' = 'Segment Version');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ALTER COLUMN `total_campaign_responses` SET TAGS ('dbx_business_glossary_term' = 'Total Campaign Responses');
ALTER TABLE `airlines_ecm`.`marketing`.`segment_membership` ALTER COLUMN `total_campaigns_received` SET TAGS ('dbx_business_glossary_term' = 'Total Campaigns Received');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Channel ID');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `parent_channel_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `attribution_window_days` SET TAGS ('dbx_business_glossary_term' = 'Attribution Window Days');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `channel_category` SET TAGS ('dbx_business_glossary_term' = 'Channel Category');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `channel_category` SET TAGS ('dbx_value_regex' = 'owned|paid|earned');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Code');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `channel_description` SET TAGS ('dbx_business_glossary_term' = 'Channel Description');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Name');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'email|sms|push_notification|in_app_message|social_media|paid_search');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `consent_framework` SET TAGS ('dbx_business_glossary_term' = 'Consent Framework');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `consent_framework` SET TAGS ('dbx_value_regex' = 'gdpr|casl|can_spam|ccpa|lgpd|none');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `cost_model` SET TAGS ('dbx_business_glossary_term' = 'Cost Model');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `cost_model` SET TAGS ('dbx_value_regex' = 'cpm|cpc|cpa|fixed|hybrid|free');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `data_retention_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Days');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `deactivation_reason` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Reason');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `double_opt_in_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Double Opt-In Required Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `external_agency_name` SET TAGS ('dbx_business_glossary_term' = 'External Agency Name');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `ffp_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Integration Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `frequency_cap_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Enabled Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `geographic_availability` SET TAGS ('dbx_business_glossary_term' = 'Geographic Availability');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `integration_status` SET TAGS ('dbx_business_glossary_term' = 'Integration Status');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `integration_status` SET TAGS ('dbx_value_regex' = 'active|inactive|testing|deprecated|pending');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `max_frequency_per_day` SET TAGS ('dbx_business_glossary_term' = 'Maximum Frequency Per Day');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `max_frequency_per_week` SET TAGS ('dbx_business_glossary_term' = 'Maximum Frequency Per Week');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `opt_in_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Required Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `owner_team` SET TAGS ('dbx_business_glossary_term' = 'Channel Owner Team');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `personalization_capability` SET TAGS ('dbx_business_glossary_term' = 'Personalization Capability');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `personalization_capability` SET TAGS ('dbx_value_regex' = 'none|basic|advanced|dynamic');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `platform_name` SET TAGS ('dbx_business_glossary_term' = 'Platform Name');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `platform_vendor` SET TAGS ('dbx_business_glossary_term' = 'Platform Vendor');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `pnr_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) Integration Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `reach_potential` SET TAGS ('dbx_business_glossary_term' = 'Reach Potential');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `reach_potential` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `real_time_capability_flag` SET TAGS ('dbx_business_glossary_term' = 'Real-Time Capability Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `sla_delivery_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Delivery Time Minutes');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `tracking_capability` SET TAGS ('dbx_business_glossary_term' = 'Tracking Capability');
ALTER TABLE `airlines_ecm`.`marketing`.`channel` ALTER COLUMN `tracking_capability` SET TAGS ('dbx_value_regex' = 'full|partial|none');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `communication_preference_id` SET TAGS ('dbx_business_glossary_term' = 'Communication Preference ID');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger ID');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `superseded_communication_preference_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel Type');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'email|sms|push_notification|postal_mail|phone|in_app');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `communication_category` SET TAGS ('dbx_business_glossary_term' = 'Communication Category');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `communication_category` SET TAGS ('dbx_value_regex' = 'promotional_offers|flight_deals|loyalty_updates|travel_inspiration|partner_offers|survey_invitations');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `consent_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiry Date');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `contact_count` SET TAGS ('dbx_business_glossary_term' = 'Contact Count');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `double_opt_in_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Double Opt-In Confirmed');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `frequency_preference` SET TAGS ('dbx_business_glossary_term' = 'Frequency Preference');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `frequency_preference` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|as_available');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `global_unsubscribe_flag` SET TAGS ('dbx_business_glossary_term' = 'Global Unsubscribe Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `ip_address_at_consent` SET TAGS ('dbx_business_glossary_term' = 'IP Address at Consent');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `ip_address_at_consent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `ip_address_at_consent` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `last_contact_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `opt_in_source` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Source');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `opt_in_status` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Status');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `opt_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `opt_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `preference_source_system` SET TAGS ('dbx_business_glossary_term' = 'Preference Source System');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_business_glossary_term' = 'Preference Status');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|expired');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_business_glossary_term' = 'Suppression Reason');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `third_party_sharing_consent` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Sharing Consent');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `user_agent_at_consent` SET TAGS ('dbx_business_glossary_term' = 'User Agent at Consent');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `user_agent_at_consent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`communication_preference` ALTER COLUMN `user_agent_at_consent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` SET TAGS ('dbx_subdomain' = 'customer_insights');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `nps_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Survey ID');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `superseded_nps_survey_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Active Status');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `active_status` SET TAGS ('dbx_value_regex' = 'active|inactive|paused|draft|archived');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `data_retention_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Days');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `estimated_completion_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Completion Minutes');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `iata_season_code` SET TAGS ('dbx_business_glossary_term' = 'IATA Season Code');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `iata_season_code` SET TAGS ('dbx_value_regex' = '^(S|W)[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `incentive_description` SET TAGS ('dbx_business_glossary_term' = 'Incentive Description');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `incentive_offered` SET TAGS ('dbx_business_glossary_term' = 'Incentive Offered');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Team');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `privacy_notice_version` SET TAGS ('dbx_business_glossary_term' = 'Privacy Notice Version');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `privacy_notice_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+$');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `question_count` SET TAGS ('dbx_business_glossary_term' = 'Question Count');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `response_target_count` SET TAGS ('dbx_business_glossary_term' = 'Response Target Count');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `response_window_days` SET TAGS ('dbx_business_glossary_term' = 'Response Window Days');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `sampling_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Sampling Rate Percent');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `survey_close_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Close Date');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `survey_code` SET TAGS ('dbx_business_glossary_term' = 'Survey Code');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `survey_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `survey_instrument_version` SET TAGS ('dbx_business_glossary_term' = 'Survey Instrument Version');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `survey_instrument_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `survey_language_codes` SET TAGS ('dbx_business_glossary_term' = 'Survey Language Codes');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `survey_name` SET TAGS ('dbx_business_glossary_term' = 'Survey Name');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `survey_open_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Open Date');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'transactional_nps|relational_nps|csat|ces|custom');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `survey_url_template` SET TAGS ('dbx_business_glossary_term' = 'Survey URL Template');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `survey_vendor` SET TAGS ('dbx_business_glossary_term' = 'Survey Vendor');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `survey_vendor_programme_code` SET TAGS ('dbx_business_glossary_term' = 'Survey Vendor Programme ID');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `target_audience_criteria` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Criteria');
ALTER TABLE `airlines_ecm`.`marketing`.`nps_survey` ALTER COLUMN `trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Trigger Event');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` SET TAGS ('dbx_subdomain' = 'customer_insights');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `survey_response_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Response ID');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `ancillary_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg ID');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `nps_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Survey ID');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger ID');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `superseded_survey_response_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `anonymous_token` SET TAGS ('dbx_business_glossary_term' = 'Anonymous Respondent Token');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `anonymous_token` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{32}$');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `cabin_class` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `cabin_class` SET TAGS ('dbx_value_regex' = 'First|Business|Premium Economy|Economy');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `ces_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Effort Score (CES)');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `csat_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'Desktop|Mobile|Tablet|IFE|Kiosk|Unknown');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `ffp_tier` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Tier');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `ffp_tier` SET TAGS ('dbx_value_regex' = 'None|Silver|Gold|Platinum|Diamond');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `flight_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Date');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `incentive_offered` SET TAGS ('dbx_business_glossary_term' = 'Incentive Offered Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `incentive_type` SET TAGS ('dbx_business_glossary_term' = 'Incentive Type');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `incentive_type` SET TAGS ('dbx_value_regex' = 'Miles|Discount|Prize Draw|None');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `ip_country_code` SET TAGS ('dbx_business_glossary_term' = 'IP Country Code');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `ip_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `is_verified_passenger` SET TAGS ('dbx_business_glossary_term' = 'Verified Passenger Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `nps_category` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Category');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `nps_category` SET TAGS ('dbx_value_regex' = 'Promoter|Passive|Detractor');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Score');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport Code');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `pnr` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR)');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `pnr` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `pnr` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `pnr` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `response_channel` SET TAGS ('dbx_business_glossary_term' = 'Response Channel');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `response_channel` SET TAGS ('dbx_value_regex' = 'Email|Mobile App|IFE|SMS|Web Portal|Kiosk');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `response_language` SET TAGS ('dbx_business_glossary_term' = 'Response Language');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `response_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `response_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Response Time in Seconds');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `route_type` SET TAGS ('dbx_business_glossary_term' = 'Route Type');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `route_type` SET TAGS ('dbx_value_regex' = 'Domestic|International|Regional');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `sentiment_category` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Category');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `sentiment_category` SET TAGS ('dbx_value_regex' = 'Positive|Neutral|Negative|Mixed');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `service_recovery_triggered` SET TAGS ('dbx_business_glossary_term' = 'Service Recovery Triggered Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `survey_completion_rate` SET TAGS ('dbx_business_glossary_term' = 'Survey Completion Rate');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `survey_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Survey Sent Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `survey_version` SET TAGS ('dbx_business_glossary_term' = 'Survey Version');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `topic_tags` SET TAGS ('dbx_business_glossary_term' = 'Topic Tags');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `verbatim_feedback` SET TAGS ('dbx_business_glossary_term' = 'Verbatim Feedback');
ALTER TABLE `airlines_ecm`.`marketing`.`survey_response` ALTER COLUMN `verbatim_feedback` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` SET TAGS ('dbx_subdomain' = 'customer_insights');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `market_research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Market Research Study Identifier (ID)');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Manager Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `follow_up_market_research_study_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Agency Contact Email Address');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `agency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Contact Name');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `agency_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `business_objective` SET TAGS ('dbx_business_glossary_term' = 'Business Objective');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `commissioning_department` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Department');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `data_collection_channel` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Channel');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `external_agency_name` SET TAGS ('dbx_business_glossary_term' = 'External Research Agency Name');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `fieldwork_end_date` SET TAGS ('dbx_business_glossary_term' = 'Fieldwork End Date');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `fieldwork_start_date` SET TAGS ('dbx_business_glossary_term' = 'Fieldwork Start Date');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `key_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Key Findings Summary');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `key_findings_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `market_research_study_status` SET TAGS ('dbx_business_glossary_term' = 'Study Status');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `market_research_study_status` SET TAGS ('dbx_value_regex' = 'planned|fieldwork|analysis|completed|cancelled|on_hold');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `report_document_url` SET TAGS ('dbx_business_glossary_term' = 'Report Document Uniform Resource Locator (URL)');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `report_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `research_methodology` SET TAGS ('dbx_business_glossary_term' = 'Research Methodology');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `research_methodology` SET TAGS ('dbx_value_regex' = 'quantitative_survey|qualitative_focus_group|ethnographic|secondary_desk_research|mixed_methods|conjoint_analysis');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `response_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Response Rate Percentage');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `strategic_priority` SET TAGS ('dbx_business_glossary_term' = 'Strategic Priority');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `strategic_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `study_code` SET TAGS ('dbx_business_glossary_term' = 'Study Code');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `study_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4}-[A-Z0-9]{2,6}$');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `study_end_date` SET TAGS ('dbx_business_glossary_term' = 'Study End Date');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `study_name` SET TAGS ('dbx_business_glossary_term' = 'Study Name');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `study_start_date` SET TAGS ('dbx_business_glossary_term' = 'Study Start Date');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Study Type');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `study_type` SET TAGS ('dbx_value_regex' = 'brand_tracking|competitive_benchmarking|route_demand_study|passenger_needs_assessment|concept_testing|pricing_sensitivity');
ALTER TABLE `airlines_ecm`.`marketing`.`market_research_study` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` SET TAGS ('dbx_subdomain' = 'content_production');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `brand_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Asset Identifier (ID)');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `derived_from_brand_asset_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|archived|expired');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `archive_date` SET TAGS ('dbx_business_glossary_term' = 'Archive Date');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `archive_reason` SET TAGS ('dbx_business_glossary_term' = 'Archive Reason');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `asset_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Code');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `asset_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `asset_format` SET TAGS ('dbx_business_glossary_term' = 'Asset Format');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_value_regex' = 'logo|livery_specification|brand_guideline_document|photography|video|infographic');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `brand_programme` SET TAGS ('dbx_business_glossary_term' = 'Brand Programme');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `brand_territory` SET TAGS ('dbx_business_glossary_term' = 'Brand Territory');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `brand_territory` SET TAGS ('dbx_value_regex' = 'global|regional|sub_brand|market_specific');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `color_profile` SET TAGS ('dbx_business_glossary_term' = 'Color Profile');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `color_profile` SET TAGS ('dbx_value_regex' = 'RGB|CMYK|Pantone|sRGB|Adobe_RGB');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `copyright_holder` SET TAGS ('dbx_business_glossary_term' = 'Copyright Holder');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `file_reference` SET TAGS ('dbx_business_glossary_term' = 'File Reference');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'File Size (Megabytes)');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'proprietary|royalty_free|rights_managed|creative_commons|public_domain');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Team');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Resolution');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `usage_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Usage Restrictions');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `usage_rights` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^v?[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `airlines_ecm`.`marketing`.`brand_asset` ALTER COLUMN `creation_date` SET TAGS ('dbx_business_glossary_term' = 'Creation Date');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `digital_campaign_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Campaign Creative Identifier (ID)');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `ab_test_variant_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant Identifier (ID)');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `brand_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Asset Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `revised_digital_campaign_creative_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `accessibility_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Compliant Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|revision_required|archived');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `asset_file_path` SET TAGS ('dbx_business_glossary_term' = 'Asset File Path');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `asset_file_size_kb` SET TAGS ('dbx_business_glossary_term' = 'Asset File Size in Kilobytes (KB)');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `body_copy` SET TAGS ('dbx_business_glossary_term' = 'Body Copy');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `brand_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Brand Compliance Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `call_to_action_text` SET TAGS ('dbx_business_glossary_term' = 'Call to Action (CTA) Text');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Marketing Channel');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `creative_code` SET TAGS ('dbx_business_glossary_term' = 'Creative Code');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `creative_name` SET TAGS ('dbx_business_glossary_term' = 'Creative Name');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `creative_type` SET TAGS ('dbx_business_glossary_term' = 'Creative Type');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `destination_url` SET TAGS ('dbx_business_glossary_term' = 'Destination Uniform Resource Locator (URL)');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `format_dimensions` SET TAGS ('dbx_business_glossary_term' = 'Format Dimensions');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Go Live Date');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `headline_copy` SET TAGS ('dbx_business_glossary_term' = 'Headline Copy');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `is_high_performer` SET TAGS ('dbx_business_glossary_term' = 'Is High Performer Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `legal_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Compliance Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `market_code` SET TAGS ('dbx_business_glossary_term' = 'Market Code');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `market_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `target_audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Segment');
ALTER TABLE `airlines_ecm`.`marketing`.`digital_campaign_creative` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `spend_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Spend ID');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre ID');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `adjustment_spend_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|cancelled');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `fiscal_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Month');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `market_region` SET TAGS ('dbx_business_glossary_term' = 'Market Region');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `passenger_segment` SET TAGS ('dbx_business_glossary_term' = 'Passenger Segment');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|paid|disputed|cancelled');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Spend Period End Date');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Spend Period Start Date');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `planned_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Spend Amount');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Spend Reference Number');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `route_group` SET TAGS ('dbx_business_glossary_term' = 'Route Group');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `spend_type` SET TAGS ('dbx_business_glossary_term' = 'Spend Type');
ALTER TABLE `airlines_ecm`.`marketing`.`spend` ALTER COLUMN `spend_type` SET TAGS ('dbx_value_regex' = 'media_buy|agency_fee|production_cost|technology_platform_fee|sponsorship|event_cost');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` SET TAGS ('dbx_subdomain' = 'partnership_relations');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `sponsorship_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Identifier (ID)');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `lease_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `partner_organization_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Organization Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `supply_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `renewed_sponsorship_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `activation_status` SET TAGS ('dbx_business_glossary_term' = 'Activation Status');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `activation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|expired|terminated');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `annual_value` SET TAGS ('dbx_business_glossary_term' = 'Annual Value');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `annual_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `brand_alignment_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Alignment Score');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `contract_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed Date');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term in Months');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `contracted_value` SET TAGS ('dbx_business_glossary_term' = 'Contracted Value');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `contracted_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship End Date');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `exclusivity_category` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Category');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `geographic_market` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `hospitality_entitlement` SET TAGS ('dbx_business_glossary_term' = 'Hospitality Entitlement');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `logo_placement_rights` SET TAGS ('dbx_business_glossary_term' = 'Logo Placement Rights');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Notes');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `owning_commercial_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Commercial Team');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `payment_structure` SET TAGS ('dbx_business_glossary_term' = 'Payment Structure');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `payment_structure` SET TAGS ('dbx_value_regex' = 'lump_sum|annual_installments|quarterly_installments|monthly_installments|milestone_based|other');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `performance_kpi_description` SET TAGS ('dbx_business_glossary_term' = 'Performance Key Performance Indicator (KPI) Description');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `regional_scope` SET TAGS ('dbx_business_glossary_term' = 'Regional Scope');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `regional_scope` SET TAGS ('dbx_value_regex' = 'local|national|regional|global');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `renewal_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Deadline Date');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `renewal_option_details` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Details');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `rights_package_description` SET TAGS ('dbx_business_glossary_term' = 'Rights Package Description');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `sponsorship_category` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Category');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `sponsorship_code` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Code');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `sponsorship_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `sponsorship_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Name');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `sponsorship_type` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Type');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `sponsorship_type` SET TAGS ('dbx_value_regex' = 'title_sponsor|presenting_sponsor|official_airline_partner|jersey_sponsor|stadium_naming_rights|event_sponsor');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Start Date');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship` ALTER COLUMN `termination_clause_summary` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause Summary');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` SET TAGS ('dbx_subdomain' = 'partnership_relations');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `sponsorship_activation_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Activation Identifier (ID)');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Activation Manager Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `contract_deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Deliverable Identifier (ID)');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `sponsorship_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Agreement Identifier (ID)');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `parent_sponsorship_activation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `activation_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activation End Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `activation_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Activation Reference Number');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `activation_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activation Start Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `activation_status` SET TAGS ('dbx_business_glossary_term' = 'Activation Status');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `activation_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|deferred|under_review');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `activation_type` SET TAGS ('dbx_business_glossary_term' = 'Activation Type');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `actual_audience_reach` SET TAGS ('dbx_business_glossary_term' = 'Actual Audience Reach');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend in United States Dollars (USD)');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration Number');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `budgeted_spend_usd` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Spend in United States Dollars (USD)');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `budgeted_spend_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `city_name` SET TAGS ('dbx_business_glossary_term' = 'City Name');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `content_url` SET TAGS ('dbx_business_glossary_term' = 'Content Uniform Resource Locator (URL)');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'International Organization for Standardization (ISO) Country Code');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'International Organization for Standardization (ISO) Currency Code');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `deliverable_description` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Description');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `digital_channel` SET TAGS ('dbx_business_glossary_term' = 'Digital Channel');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `engagement_count` SET TAGS ('dbx_business_glossary_term' = 'Engagement Count');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `estimated_audience_reach` SET TAGS ('dbx_business_glossary_term' = 'Estimated Audience Reach');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `impressions_count` SET TAGS ('dbx_business_glossary_term' = 'Impressions Count');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `is_contractually_required` SET TAGS ('dbx_business_glossary_term' = 'Is Contractually Required Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `media_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Media Value in United States Dollars (USD)');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `outcome_notes` SET TAGS ('dbx_business_glossary_term' = 'Outcome Notes');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `responsible_team` SET TAGS ('dbx_business_glossary_term' = 'Responsible Team');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `sponsor_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Approval Status');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `sponsor_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `sponsor_feedback` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Feedback');
ALTER TABLE `airlines_ecm`.`marketing`.`sponsorship_activation` ALTER COLUMN `venue_name` SET TAGS ('dbx_business_glossary_term' = 'Venue Name');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` SET TAGS ('dbx_subdomain' = 'customer_insights');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `passenger_touchpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Touchpoint ID');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `ancillary_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `digital_campaign_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Campaign Creative Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Identifier');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger (Pax) ID');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `pricing_record_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Record Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Ticket Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `previous_passenger_touchpoint_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `airport_code` SET TAGS ('dbx_business_glossary_term' = 'Airport Code (IATA)');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `booking_reference` SET TAGS ('dbx_business_glossary_term' = 'Booking Reference');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `browser` SET TAGS ('dbx_business_glossary_term' = 'Web Browser');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Marketing Channel');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `content_viewed` SET TAGS ('dbx_business_glossary_term' = 'Content Viewed');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `conversion_flag` SET TAGS ('dbx_business_glossary_term' = 'Conversion Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `conversion_type` SET TAGS ('dbx_business_glossary_term' = 'Conversion Type');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `conversion_type` SET TAGS ('dbx_value_regex' = 'booking|ancillary_purchase|ffp_enrollment|newsletter_signup|account_creation|none');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code (IATA)');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|kiosk|ife_screen|unknown');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `engagement_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Engagement Duration (Seconds)');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `ffp_number` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Number');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `ffp_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `ffp_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}[0-9]{1,4}$');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `geographic_city` SET TAGS ('dbx_business_glossary_term' = 'Geographic City');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `geographic_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country Code');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `geographic_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `interaction_depth` SET TAGS ('dbx_business_glossary_term' = 'Interaction Depth');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport Code (IATA)');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `page_url` SET TAGS ('dbx_business_glossary_term' = 'Page Uniform Resource Locator (URL)');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `pnr` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR)');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `pnr` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `referrer_url` SET TAGS ('dbx_business_glossary_term' = 'Referrer Uniform Resource Locator (URL)');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Amount');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `revenue_currency` SET TAGS ('dbx_business_glossary_term' = 'Revenue Currency Code');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `revenue_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `session_reference` SET TAGS ('dbx_business_glossary_term' = 'Session Identifier');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `touchpoint_status` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Status');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `touchpoint_status` SET TAGS ('dbx_value_regex' = 'completed|abandoned|error|timeout');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `touchpoint_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `touchpoint_type` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Type');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `utm_campaign` SET TAGS ('dbx_business_glossary_term' = 'Urchin Tracking Module (UTM) Campaign');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `utm_content` SET TAGS ('dbx_business_glossary_term' = 'Urchin Tracking Module (UTM) Content');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `utm_medium` SET TAGS ('dbx_business_glossary_term' = 'Urchin Tracking Module (UTM) Medium');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `utm_source` SET TAGS ('dbx_business_glossary_term' = 'Urchin Tracking Module (UTM) Source');
ALTER TABLE `airlines_ecm`.`marketing`.`passenger_touchpoint` ALTER COLUMN `utm_term` SET TAGS ('dbx_business_glossary_term' = 'Urchin Tracking Module (UTM) Term');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `ab_test_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Identifier (ID)');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Test Owner Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `iterated_ab_test_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `cabin_class_focus` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class Focus');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `cabin_class_focus` SET TAGS ('dbx_value_regex' = 'economy|premium_economy|business|first');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `control_variant_description` SET TAGS ('dbx_business_glossary_term' = 'Control Variant Description');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `digital_channel` SET TAGS ('dbx_business_glossary_term' = 'Digital Channel');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `digital_channel` SET TAGS ('dbx_value_regex' = 'email|website|mobile_app|social_media|display_ads|search_ads');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `ffp_tier_focus` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Tier Focus');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `hypothesis` SET TAGS ('dbx_business_glossary_term' = 'Test Hypothesis');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `minimum_detectable_effect` SET TAGS ('dbx_business_glossary_term' = 'Minimum Detectable Effect (MDE)');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Test Notes');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Team');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `p_value` SET TAGS ('dbx_business_glossary_term' = 'P-Value');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `primary_success_metric` SET TAGS ('dbx_business_glossary_term' = 'Primary Success Metric');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `route_focus` SET TAGS ('dbx_business_glossary_term' = 'Route Focus');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `sample_size_target` SET TAGS ('dbx_business_glossary_term' = 'Sample Size Target');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `secondary_metrics` SET TAGS ('dbx_business_glossary_term' = 'Secondary Metrics');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `statistical_confidence_threshold` SET TAGS ('dbx_business_glossary_term' = 'Statistical Confidence Threshold');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `statistical_significance_achieved` SET TAGS ('dbx_business_glossary_term' = 'Statistical Significance Achieved Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `target_audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Segment');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `test_code` SET TAGS ('dbx_business_glossary_term' = 'Test Code');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `test_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `test_name` SET TAGS ('dbx_business_glossary_term' = 'Test Name');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `test_platform` SET TAGS ('dbx_business_glossary_term' = 'Test Platform');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'draft|approved|running|paused|concluded|cancelled');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'A/B|multivariate|split_url|sequential|bandit');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `traffic_split_percentage` SET TAGS ('dbx_business_glossary_term' = 'Traffic Split Percentage');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `treatment_variant_description` SET TAGS ('dbx_business_glossary_term' = 'Treatment Variant Description');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `treatment_variant_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `treatment_variant_description` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `variant_count` SET TAGS ('dbx_business_glossary_term' = 'Variant Count');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test` ALTER COLUMN `winning_variant` SET TAGS ('dbx_business_glossary_term' = 'Winning Variant');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` SET TAGS ('dbx_subdomain' = 'customer_insights');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `competitor_fare_watch_id` SET TAGS ('dbx_business_glossary_term' = 'Competitor Fare Watch ID');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `previous_competitor_fare_watch_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `advance_purchase_days` SET TAGS ('dbx_business_glossary_term' = 'Advance Purchase Days');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `alliance_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Alliance Affiliation');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `alliance_affiliation` SET TAGS ('dbx_value_regex' = 'star_alliance|oneworld|skyteam|none');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Availability Status');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `availability_status` SET TAGS ('dbx_value_regex' = 'available|limited|sold_out|unavailable|unknown');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `booking_class_code` SET TAGS ('dbx_business_glossary_term' = 'Booking Class Code');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `booking_class_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `cabin_class` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `cabin_class` SET TAGS ('dbx_value_regex' = 'economy|premium_economy|business|first');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `codeshare_flag` SET TAGS ('dbx_business_glossary_term' = 'Codeshare Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `collection_method` SET TAGS ('dbx_value_regex' = 'automated_scraping|api_integration|manual_entry|gds_query|partner_feed');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `competitor_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Competitor Carrier Code');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `competitor_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `competitor_flight_number` SET TAGS ('dbx_business_glossary_term' = 'Competitor Flight Number');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `competitor_flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}[0-9]{1,4}$');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'gds|ota|direct_channel|meta_search|api|manual');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `fare_basis_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Basis Code');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `fare_conditions_summary` SET TAGS ('dbx_business_glossary_term' = 'Fare Conditions Summary');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `fare_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Currency Code');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `fare_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `fare_type` SET TAGS ('dbx_business_glossary_term' = 'Fare Type');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `fare_type` SET TAGS ('dbx_value_regex' = 'published|private|negotiated|promotional|opaque');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `gds_system_code` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) System Code');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `gds_system_code` SET TAGS ('dbx_value_regex' = '^(1A|1B|1G|1P|1S|1V)?$');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'leisure|business|vfr|group|corporate');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `number_of_stops` SET TAGS ('dbx_business_glossary_term' = 'Number of Stops');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `observation_status` SET TAGS ('dbx_business_glossary_term' = 'Observation Status');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `observation_status` SET TAGS ('dbx_value_regex' = 'active|archived|invalidated|duplicate');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `observation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Observation Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `observed_fare_amount` SET TAGS ('dbx_business_glossary_term' = 'Observed Fare Amount');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `operating_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Carrier Code');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `operating_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport Code');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `ota_platform_name` SET TAGS ('dbx_business_glossary_term' = 'Online Travel Agency (OTA) Platform Name');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `point_of_sale_country` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Country');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `point_of_sale_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `return_travel_date` SET TAGS ('dbx_business_glossary_term' = 'Return Travel Date');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `round_trip_flag` SET TAGS ('dbx_business_glossary_term' = 'Round Trip Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `scraping_session_reference` SET TAGS ('dbx_business_glossary_term' = 'Scraping Session ID');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `seats_available_count` SET TAGS ('dbx_business_glossary_term' = 'Seats Available Count');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `taxes_fees_amount` SET TAGS ('dbx_business_glossary_term' = 'Taxes and Fees Amount');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `total_fare_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Fare Amount');
ALTER TABLE `airlines_ecm`.`marketing`.`competitor_fare_watch` ALTER COLUMN `travel_date` SET TAGS ('dbx_business_glossary_term' = 'Travel Date');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` SET TAGS ('dbx_subdomain' = 'partnership_relations');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `promotional_fare_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Fare Identifier (ID)');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `fare_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `superseded_promotional_fare_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `advance_purchase_days` SET TAGS ('dbx_business_glossary_term' = 'Advance Purchase Days');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Promotional Fare Amount');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `blackout_dates` SET TAGS ('dbx_business_glossary_term' = 'Blackout Dates');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `booking_class` SET TAGS ('dbx_business_glossary_term' = 'Booking Class');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `booking_class` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `booking_window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Window End Date');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `booking_window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Window Start Date');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `cabin_class` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `cabin_class` SET TAGS ('dbx_value_regex' = 'economy|premium_economy|business|first|all');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `change_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Change Fee Amount');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `changeable_flag` SET TAGS ('dbx_business_glossary_term' = 'Changeable Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code (IATA)');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `distribution_channels` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channels');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `ffp_tier_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Tier Eligibility');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `gds_distribution_flag` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Distribution Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `maximum_stay_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stay Days');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `mileage_accrual_percentage` SET TAGS ('dbx_business_glossary_term' = 'Mileage Accrual Percentage');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `minimum_stay_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stay Days');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport Code (IATA)');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Team');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `promotion_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Code');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `promotion_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `promotion_name` SET TAGS ('dbx_business_glossary_term' = 'Promotion Name');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `promotion_type` SET TAGS ('dbx_business_glossary_term' = 'Promotion Type');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `promotional_fare_status` SET TAGS ('dbx_business_glossary_term' = 'Promotional Fare Status');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `promotional_fare_status` SET TAGS ('dbx_value_regex' = 'draft|active|paused|expired|sold_out|cancelled');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `refundable_flag` SET TAGS ('dbx_business_glossary_term' = 'Refundable Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `route_scope` SET TAGS ('dbx_business_glossary_term' = 'Route Scope');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `route_scope` SET TAGS ('dbx_value_regex' = 'specific_route|region|country|global');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `seat_allocation_total` SET TAGS ('dbx_business_glossary_term' = 'Seat Allocation Total');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `seat_cap_per_flight` SET TAGS ('dbx_business_glossary_term' = 'Seat Cap Per Flight');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `seats_sold` SET TAGS ('dbx_business_glossary_term' = 'Seats Sold');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `travel_window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Travel Window End Date');
ALTER TABLE `airlines_ecm`.`marketing`.`promotional_fare` ALTER COLUMN `travel_window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Travel Window Start Date');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` SET TAGS ('dbx_subdomain' = 'partnership_relations');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `co_marketing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Co-Marketing Agreement ID');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `partner_organization_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Organization ID');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `renewed_co_marketing_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `agreement_manager` SET TAGS ('dbx_business_glossary_term' = 'Agreement Manager');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `agreement_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Reference Number');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'co-branded campaign|joint advertising|destination marketing|credit card co-brand|OTA partnership|loyalty program partnership');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `airline_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Airline Contribution Amount');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revision required');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `campaign_deliverables` SET TAGS ('dbx_business_glossary_term' = 'Campaign Deliverables');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement End Date');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `joint_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Joint Budget Amount');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `legal_entity` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `owning_commercial_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Commercial Team');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `partner_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Partner Contact Email');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `partner_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `partner_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `partner_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Contact Name');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `partner_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `partner_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `partner_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Partner Contact Phone');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `partner_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `partner_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Partner Contribution Amount');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `performance_metrics` SET TAGS ('dbx_business_glossary_term' = 'Performance Metrics');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `route_focus` SET TAGS ('dbx_business_glossary_term' = 'Route Focus');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Start Date');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `target_passenger_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Passenger Segment');
ALTER TABLE `airlines_ecm`.`marketing`.`co_marketing_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` SET TAGS ('dbx_subdomain' = 'content_production');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `social_media_post_id` SET TAGS ('dbx_business_glossary_term' = 'Social Media Post ID');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `digital_campaign_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Campaign Creative Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Author User ID');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `reply_to_social_media_post_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `account_handle` SET TAGS ('dbx_business_glossary_term' = 'Account Handle');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `actual_publish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Publish Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `boosted_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Boosted Spend Amount');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `boosted_spend_currency` SET TAGS ('dbx_business_glossary_term' = 'Boosted Spend Currency');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `boosted_spend_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `content_text` SET TAGS ('dbx_business_glossary_term' = 'Post Content Text');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `engagement_rate` SET TAGS ('dbx_business_glossary_term' = 'Engagement Rate');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `hashtags` SET TAGS ('dbx_business_glossary_term' = 'Hashtags');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `impressions` SET TAGS ('dbx_business_glossary_term' = 'Impressions');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `likes` SET TAGS ('dbx_business_glossary_term' = 'Likes');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `link_clicks` SET TAGS ('dbx_business_glossary_term' = 'Link Clicks');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `market_region` SET TAGS ('dbx_business_glossary_term' = 'Market Region');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `media_attachment_reference` SET TAGS ('dbx_business_glossary_term' = 'Media Attachment Reference');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `mentions` SET TAGS ('dbx_business_glossary_term' = 'Mentions');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Social Media Platform');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `platform` SET TAGS ('dbx_value_regex' = 'Instagram|Facebook|X|LinkedIn|TikTok|YouTube');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `post_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Post Reference Number');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `post_status` SET TAGS ('dbx_business_glossary_term' = 'Post Status');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `post_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|published|deleted|failed');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `post_type` SET TAGS ('dbx_business_glossary_term' = 'Post Type');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `post_type` SET TAGS ('dbx_value_regex' = 'organic|boosted|paid_dark_post|story|reel|carousel');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `post_url` SET TAGS ('dbx_business_glossary_term' = 'Post URL');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `reach` SET TAGS ('dbx_business_glossary_term' = 'Reach');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `saves` SET TAGS ('dbx_business_glossary_term' = 'Saves');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `scheduled_publish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Publish Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `shares` SET TAGS ('dbx_business_glossary_term' = 'Shares');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `target_audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Segment');
ALTER TABLE `airlines_ecm`.`marketing`.`social_media_post` ALTER COLUMN `video_views` SET TAGS ('dbx_business_glossary_term' = 'Video Views');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` SET TAGS ('dbx_subdomain' = 'content_production');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `email_send_id` SET TAGS ('dbx_business_glossary_term' = 'Email Send ID');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `email_send_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `email_send_id` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `ancillary_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `campaign_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Execution ID');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `digital_campaign_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Email Template ID');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Profile ID');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `resend_email_send_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `bounce_reason` SET TAGS ('dbx_business_glossary_term' = 'Bounce Reason');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `bounce_type` SET TAGS ('dbx_business_glossary_term' = 'Bounce Type');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `bounce_type` SET TAGS ('dbx_value_regex' = 'hard|soft|block|technical|policy|content');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `click_flag` SET TAGS ('dbx_business_glossary_term' = 'Click Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `clicked_url` SET TAGS ('dbx_business_glossary_term' = 'Clicked URL');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'delivered|bounced_hard|bounced_soft|filtered|deferred|failed');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|webmail|unknown');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `email_client` SET TAGS ('dbx_business_glossary_term' = 'Email Client');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `email_client` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `email_client` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `esp_provider` SET TAGS ('dbx_business_glossary_term' = 'Email Service Provider (ESP) Provider');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `first_click_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Click Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `first_open_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Open Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `from_address` SET TAGS ('dbx_business_glossary_term' = 'From Address');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `from_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `from_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `from_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `message_reference` SET TAGS ('dbx_business_glossary_term' = 'Message ID');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `open_city` SET TAGS ('dbx_business_glossary_term' = 'Open City');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `open_country_code` SET TAGS ('dbx_business_glossary_term' = 'Open Country Code');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `open_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `open_flag` SET TAGS ('dbx_business_glossary_term' = 'Open Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `personalization_flag` SET TAGS ('dbx_business_glossary_term' = 'Personalization Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `recipient_email_address` SET TAGS ('dbx_business_glossary_term' = 'Recipient Email Address');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `recipient_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `recipient_email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `recipient_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `reply_to_address` SET TAGS ('dbx_business_glossary_term' = 'Reply-To Address');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `reply_to_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `reply_to_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `reply_to_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `send_priority` SET TAGS ('dbx_business_glossary_term' = 'Send Priority');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `send_priority` SET TAGS ('dbx_value_regex' = 'high|normal|low');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `send_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Send Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `spam_complaint_flag` SET TAGS ('dbx_business_glossary_term' = 'Spam Complaint Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `spam_complaint_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Spam Complaint Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `subject_line` SET TAGS ('dbx_business_glossary_term' = 'Subject Line');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `suppression_list_flag` SET TAGS ('dbx_business_glossary_term' = 'Suppression List Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `total_click_count` SET TAGS ('dbx_business_glossary_term' = 'Total Click Count');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `total_open_count` SET TAGS ('dbx_business_glossary_term' = 'Total Open Count');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `unsubscribe_flag` SET TAGS ('dbx_business_glossary_term' = 'Unsubscribe Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`email_send` ALTER COLUMN `unsubscribe_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Unsubscribe Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` SET TAGS ('dbx_subdomain' = 'content_production');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `destination_content_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Content ID');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `brand_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Asset Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `parent_destination_content_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `associated_routes` SET TAGS ('dbx_business_glossary_term' = 'Associated Routes');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Author Name');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `average_time_on_page_seconds` SET TAGS ('dbx_business_glossary_term' = 'Average Time on Page (Seconds)');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `content_code` SET TAGS ('dbx_business_glossary_term' = 'Content Code');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `content_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `content_status` SET TAGS ('dbx_business_glossary_term' = 'Content Status');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `content_status` SET TAGS ('dbx_value_regex' = 'draft|published|archived|under_review|scheduled');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `content_type` SET TAGS ('dbx_value_regex' = 'destination_guide|travel_blog_article|video|photo_gallery|route_spotlight|seasonal_inspiration');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `copyright_holder` SET TAGS ('dbx_business_glossary_term' = 'Copyright Holder');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `creative_theme` SET TAGS ('dbx_business_glossary_term' = 'Creative Theme');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `destination_content_description` SET TAGS ('dbx_business_glossary_term' = 'Content Description');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `destination_iata_code` SET TAGS ('dbx_business_glossary_term' = 'Destination IATA (International Air Transport Association) Code');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `destination_iata_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `ffp_tier_focus` SET TAGS ('dbx_business_glossary_term' = 'FFP (Frequent Flyer Program) Tier Focus');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'html|pdf|mp4|jpg|png');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `file_reference` SET TAGS ('dbx_business_glossary_term' = 'File Reference');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'File Size (Megabytes)');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `gds_distribution_flag` SET TAGS ('dbx_business_glossary_term' = 'GDS (Global Distribution System) Distribution Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `iata_season` SET TAGS ('dbx_business_glossary_term' = 'IATA (International Air Transport Association) Season');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `iata_season` SET TAGS ('dbx_value_regex' = 'summer|winter|shoulder');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Team');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `page_views` SET TAGS ('dbx_business_glossary_term' = 'Page Views');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `partner_airline_code` SET TAGS ('dbx_business_glossary_term' = 'Partner Airline Code');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `partner_airline_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `promotional_offer_reference` SET TAGS ('dbx_business_glossary_term' = 'Promotional Offer Reference');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `seo_keywords` SET TAGS ('dbx_business_glossary_term' = 'SEO (Search Engine Optimization) Keywords');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `social_shares` SET TAGS ('dbx_business_glossary_term' = 'Social Shares');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `target_audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Segment');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Content Title');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `usage_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Usage Restrictions');
ALTER TABLE `airlines_ecm`.`marketing`.`destination_content` ALTER COLUMN `usage_rights` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights');
ALTER TABLE `airlines_ecm`.`marketing`.`event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`marketing`.`event` SET TAGS ('dbx_subdomain' = 'partnership_relations');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Event ID');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `parent_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `actual_attendance` SET TAGS ('dbx_business_glossary_term' = 'Actual Attendance');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `booth_number` SET TAGS ('dbx_business_glossary_term' = 'Booth Number');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `booth_size_sqm` SET TAGS ('dbx_business_glossary_term' = 'Booth Size Square Meters');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Event End Date');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `estimated_attendance` SET TAGS ('dbx_business_glossary_term' = 'Estimated Attendance');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `event_code` SET TAGS ('dbx_business_glossary_term' = 'Event Code');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `event_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `event_name` SET TAGS ('dbx_business_glossary_term' = 'Event Name');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'planned|confirmed|in_progress|completed|cancelled|postponed');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'trade_show|consumer_travel_fair|press_launch|route_launch_event|corporate_roadshow|travel_agent_fam_trip');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `host_city` SET TAGS ('dbx_business_glossary_term' = 'Host City');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `host_country_code` SET TAGS ('dbx_business_glossary_term' = 'Host Country Code');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `host_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `lead_generation_target` SET TAGS ('dbx_business_glossary_term' = 'Lead Generation Target');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `leads_captured` SET TAGS ('dbx_business_glossary_term' = 'Leads Captured');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `manager_email` SET TAGS ('dbx_business_glossary_term' = 'Event Manager Email');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `manager_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `manager_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Event Manager Name');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `market_region` SET TAGS ('dbx_business_glossary_term' = 'Market Region');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Team');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `participation_type` SET TAGS ('dbx_business_glossary_term' = 'Participation Type');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `participation_type` SET TAGS ('dbx_value_regex' = 'exhibitor|sponsor|attendee|host|speaker|partner');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `partner_organizations` SET TAGS ('dbx_business_glossary_term' = 'Partner Organizations');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `post_event_outcome_notes` SET TAGS ('dbx_business_glossary_term' = 'Post-Event Outcome Notes');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `roi_score` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Score');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `roi_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `route_focus` SET TAGS ('dbx_business_glossary_term' = 'Route Focus');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Event Start Date');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `strategic_objective` SET TAGS ('dbx_business_glossary_term' = 'Strategic Objective');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `target_audience` SET TAGS ('dbx_value_regex' = 'trade|consumer|media|corporate|travel_agent|ffp_member');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `venue_address` SET TAGS ('dbx_business_glossary_term' = 'Venue Address');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `venue_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `venue_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`event` ALTER COLUMN `venue_name` SET TAGS ('dbx_business_glossary_term' = 'Venue Name');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_exposure` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_exposure` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_exposure` SET TAGS ('dbx_association_edges' = 'loyalty.ffp_member,marketing.campaign');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `campaign_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Exposure ID');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Exposure - Campaign Id');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Exposure - Ffp Member Id');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `attributed_revenue` SET TAGS ('dbx_business_glossary_term' = 'Attributed Revenue');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `attributed_revenue_currency` SET TAGS ('dbx_business_glossary_term' = 'Attributed Revenue Currency');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `attribution_model` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `conversion_flag` SET TAGS ('dbx_business_glossary_term' = 'Conversion Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `conversion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Conversion Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `creative_variant` SET TAGS ('dbx_business_glossary_term' = 'Creative Variant');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `exposure_channel` SET TAGS ('dbx_business_glossary_term' = 'Exposure Channel');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `exposure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exposure Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `impression_count` SET TAGS ('dbx_business_glossary_term' = 'Impression Count');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `member_segment_at_exposure` SET TAGS ('dbx_business_glossary_term' = 'Member Segment at Exposure');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `response_flag` SET TAGS ('dbx_business_glossary_term' = 'Response Flag');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `airlines_ecm`.`marketing`.`campaign_exposure` ALTER COLUMN `tier_level_at_exposure` SET TAGS ('dbx_business_glossary_term' = 'Tier Level at Exposure');
ALTER TABLE `airlines_ecm`.`marketing`.`partner_organization` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`marketing`.`partner_organization` SET TAGS ('dbx_subdomain' = 'partnership_relations');
ALTER TABLE `airlines_ecm`.`marketing`.`partner_organization` ALTER COLUMN `partner_organization_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Organization Identifier');
ALTER TABLE `airlines_ecm`.`marketing`.`partner_organization` ALTER COLUMN `parent_partner_organization_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`partner_organization` ALTER COLUMN `annual_passenger_volume` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`partner_organization` ALTER COLUMN `annual_revenue_contribution` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`partner_organization` ALTER COLUMN `commission_rate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`partner_organization` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`partner_organization` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`partner_organization` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`partner_organization` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test_variant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test_variant` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test_variant` ALTER COLUMN `ab_test_variant_id` SET TAGS ('dbx_business_glossary_term' = 'Ab Test Variant Identifier');
ALTER TABLE `airlines_ecm`.`marketing`.`ab_test_variant` ALTER COLUMN `control_ab_test_variant_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`marketing`.`contract_deliverable` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`marketing`.`contract_deliverable` SET TAGS ('dbx_subdomain' = 'partnership_relations');
ALTER TABLE `airlines_ecm`.`marketing`.`contract_deliverable` ALTER COLUMN `contract_deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Deliverable Identifier');
ALTER TABLE `airlines_ecm`.`marketing`.`contract_deliverable` ALTER COLUMN `parent_contract_deliverable_id` SET TAGS ('dbx_self_ref_fk' = 'true');
