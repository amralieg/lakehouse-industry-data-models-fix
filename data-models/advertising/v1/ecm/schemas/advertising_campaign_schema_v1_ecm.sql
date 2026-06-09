-- Schema for Domain: campaign | Business: Advertising | Version: v1_ecm
-- Generated on: 2026-05-08 02:28:04

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `advertising_ecm`.`campaign` COMMENT 'Core operational domain governing the end-to-end advertising campaign lifecycle — from strategy and planning through trafficking, activation, and delivery. Serves as the SSOT for campaign identity, flight dates, objectives, KPIs, targeting parameters, budget allocation, pacing rules, and execution status across all channels and formats.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `advertising_ecm`.`campaign`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Unique identifier for the advertising campaign. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser or client who owns this campaign.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Every advertising campaign executes a brand strategy and must comply with brand guidelines, tone, safety requirements, and use approved assets. Campaign planning, creative development, and trafficking',
    `client_brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: Campaigns are executed for specific client brands—fundamental relationship for brand-level performance reporting, budget tracking, share-of-voice analysis, and brand portfolio management. Domain exper',
    `positioning_id` BIGINT COMMENT 'Foreign key linking to brand.brand_positioning. Business justification: Campaigns execute specific brand positioning strategies with defined target audiences, messaging frameworks, and competitive differentiation. Campaign briefs reference positioning statements, and succ',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Campaigns often contract directly with suppliers (data providers, verification vendors, measurement platforms) for campaign-level services. Essential for vendor cost allocation, performance tracking, ',
    `approval_status` STRING COMMENT 'Current approval status of the campaign in the review workflow: pending, approved, rejected, or revision requested.. Valid values are `pending|approved|rejected|revision_requested`',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the campaign for activation.',
    `approved_date` DATE COMMENT 'Date when the campaign was officially approved for execution.',
    `attribution_model` STRING COMMENT 'Attribution model used to credit conversions for the campaign: last click, first click, linear, time decay, position-based, or data-driven.. Valid values are `last_click|first_click|linear|time_decay|position_based|data_driven`',
    `brand_safety_level` STRING COMMENT 'Brand safety filtering level applied to the campaign: standard, moderate, strict, or custom. Determines content exclusions.. Valid values are `standard|moderate|strict|custom`',
    `brief_reference` STRING COMMENT 'Reference identifier or document link to the original campaign brief or statement of work (SOW).',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total budget allocated for the campaign. Overall spending ceiling across all channels and placements.',
    `campaign_code` STRING COMMENT 'External business identifier or code for the campaign, often used in trafficking systems and insertion orders.',
    `campaign_name` STRING COMMENT 'Human-readable name of the advertising campaign used for identification and reporting.',
    `campaign_status` STRING COMMENT 'Current lifecycle status of the campaign: draft (planning), approved (ready), active (running), paused (temporarily stopped), completed (finished), or cancelled (terminated).. Valid values are `draft|approved|active|paused|completed|cancelled`',
    `campaign_tier` STRING COMMENT 'Strategic importance or priority tier of the campaign within the advertisers portfolio.. Valid values are `tier_1|tier_2|tier_3|strategic|tactical`',
    `campaign_type` STRING COMMENT 'Classification of the campaign based on its strategic objective: brand awareness, direct response, performance, retention, seasonal, or always-on.. Valid values are `brand_awareness|direct_response|performance|retention|seasonal|always_on`',
    `conversion_window_days` STRING COMMENT 'Number of days after an ad interaction during which a conversion can be attributed to the campaign.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign record was first created in the system. Audit field.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the campaign budget and financial metrics.. Valid values are `^[A-Z]{3}$`',
    `device_targeting` STRING COMMENT 'Device types targeted by the campaign. Comma-separated list such as desktop, mobile, tablet, CTV, OTT.',
    `end_date` DATE COMMENT 'The date when the campaign is scheduled to end. Flight end date. Nullable for always-on campaigns.',
    `frequency_cap` STRING COMMENT 'Maximum number of times an ad should be shown to the same user within the frequency cap window.',
    `frequency_cap_window` STRING COMMENT 'Time window for the frequency cap: per hour, day, week, month, or entire campaign duration.. Valid values are `hour|day|week|month|campaign`',
    `geo_targeting` STRING COMMENT 'Geographic targeting parameters for the campaign. Comma-separated list of countries, regions, cities, or postal codes.',
    `go_live_date` DATE COMMENT 'Actual date when the campaign went live and started serving ads. May differ from the planned start date.',
    `iab_category` STRING COMMENT 'IAB content taxonomy category for the campaign, used for brand safety and contextual targeting.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign record was last modified. Audit field for tracking changes.',
    `notes` STRING COMMENT 'Free-form notes or comments about the campaign for internal reference and collaboration.',
    `objective` STRING COMMENT 'Primary business objective or goal of the campaign, such as increase brand awareness, drive conversions, generate leads, or boost engagement.',
    `pacing_strategy` STRING COMMENT 'Budget pacing strategy for the campaign: even (spread evenly), ASAP (spend as fast as possible), custom (user-defined), or dayparting (time-of-day based).. Valid values are `even|asap|custom|dayparting`',
    `primary_kpi` STRING COMMENT 'The main metric used to measure campaign success, such as CTR, CPA, ROAS, impressions, conversions, or reach.',
    `secondary_kpis` STRING COMMENT 'Additional metrics tracked for campaign performance evaluation. Comma-separated list of KPIs.',
    `start_date` DATE COMMENT 'The date when the campaign is scheduled to begin running. Flight start date.',
    `target_audience_description` STRING COMMENT 'Textual description of the target audience for the campaign, including demographic, psychographic, and behavioral characteristics.',
    `target_cpa` DECIMAL(18,2) COMMENT 'Target cost per acquisition or conversion for the campaign. Maximum acceptable cost to acquire one customer or conversion.',
    `target_cpm` DECIMAL(18,2) COMMENT 'Target cost per thousand impressions for the campaign. Used for brand awareness and reach campaigns.',
    `target_ctr` DECIMAL(18,2) COMMENT 'Target click-through rate percentage for the campaign. Represents the expected ratio of clicks to impressions.',
    `target_roas` DECIMAL(18,2) COMMENT 'Target return on ad spend ratio for the campaign. Represents revenue generated per dollar spent on advertising.',
    `viewability_standard` STRING COMMENT 'Viewability measurement standard applied to the campaign: MRC (Media Rating Council), GroupM, or custom threshold.. Valid values are `mrc|groupm|custom`',
    `created_by` STRING COMMENT 'User or system identifier of who created the campaign record. Audit field.',
    CONSTRAINT pk_campaign PRIMARY KEY(`campaign_id`)
) COMMENT 'Master record for an advertising campaign — the authoritative SSOT for campaign identity, objectives, KPIs, flight dates, status, and high-level strategy. Captures campaign name, advertiser/client reference, campaign type (brand awareness, direct response, performance, retention, seasonal, always-on), campaign status (draft, approved, active, paused, completed, cancelled), start and end dates, campaign objective, primary KPI, secondary KPIs, target ROAS, target CPA, target CPM, target CTR, overall budget ceiling, currency, campaign tier, IAB category, campaign brief reference, approval status, approved by, approved date, go-live date, and audit timestamps. Serves as the root entity for all downstream campaign execution, trafficking, and performance data.';

CREATE OR REPLACE TABLE `advertising_ecm`.`campaign`.`flight` (
    `flight_id` BIGINT COMMENT 'Unique identifier for the campaign flight. Primary key.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Flights are tactical execution windows within campaigns that deliver brand messaging. Creative rotation, audience targeting, and channel mix decisions require brand guideline compliance and brand safe',
    `campaign_id` BIGINT COMMENT 'Reference to the parent campaign under which this flight executes. Links this flight to its overarching campaign strategy.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Flights may contract flight-specific suppliers for verification, brand safety, or measurement services. Required for flight-level vendor cost allocation, reconciliation, and performance evaluation in ',
    `audience_segments` STRING COMMENT 'Comma-separated list or structured description of audience segments targeted in this flight (e.g., demographic, behavioral, contextual, or custom segments from DMP/CDP).',
    `budget_allocated` DECIMAL(18,2) COMMENT 'The total budget allocated to this flight, representing the financial envelope for all media buys, creative production, and execution costs within this burst period.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the flight budget (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `channel_mix` STRING COMMENT 'Comma-separated list or structured description of the media channels included in this flight (e.g., Display, Video, Social, OOH). Defines the multi-channel execution strategy for this burst.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this flight record was first created in the system. Audit trail for record creation.',
    `creative_rotation` STRING COMMENT 'The strategy for rotating multiple creatives within this flight (even = equal distribution, weighted = custom weights, optimized = algorithm-driven, sequential = fixed order).. Valid values are `even|weighted|optimized|sequential`',
    `daypart_restrictions` STRING COMMENT 'Time-of-day or day-of-week restrictions for ad delivery within this flight (e.g., Weekdays 6AM-10PM, Prime Time Only). Enables dayparting strategies to optimize audience reach.',
    `device_targeting` STRING COMMENT 'Device types targeted for ad delivery in this flight (e.g., Desktop, Mobile, Tablet, CTV). Enables cross-device or device-specific strategies.',
    `end_date` DATE COMMENT 'The date when this flight concludes execution. Marks the end of the time-bounded burst window.',
    `flight_code` STRING COMMENT 'Externally-known unique code or identifier for this flight, used in trafficking systems, insertion orders, and billing reconciliation.',
    `flight_name` STRING COMMENT 'Human-readable name or label for this flight, often indicating the burst period, theme, or seasonal focus (e.g., Holiday Wave 1, Back-to-School Burst).',
    `flight_status` STRING COMMENT 'Current lifecycle status of the flight. Indicates whether the flight is in planning, actively running, paused, or concluded.. Valid values are `draft|scheduled|active|paused|completed|cancelled`',
    `frequency_cap` STRING COMMENT 'Maximum number of times a single user should see an ad from this flight within a defined time window. Prevents ad fatigue and optimizes budget efficiency.',
    `frequency_cap_period` STRING COMMENT 'The time window over which the frequency cap is enforced (e.g., per day, per week, for the entire flight duration).. Valid values are `hour|day|week|month|flight`',
    `geo_targeting` STRING COMMENT 'Geographic targeting parameters for this flight, specifying countries, regions, DMAs, postal codes, or custom geo-fences where ads should be delivered.',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified this flight record. Supports accountability and audit requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this flight record was last modified. Audit trail for record updates.',
    `notes` STRING COMMENT 'Free-text notes or comments about this flight, capturing special instructions, strategic rationale, or operational considerations.',
    `objective` STRING COMMENT 'The primary marketing objective for this flight. May override or refine the parent campaign objective for this specific burst period.. Valid values are `awareness|consideration|conversion|retention|engagement|traffic`',
    `pacing_goal` STRING COMMENT 'The metric by which pacing is measured and controlled (e.g., impressions delivered, clicks generated, conversions achieved, unique reach, or spend amount).. Valid values are `impressions|clicks|conversions|reach|spend`',
    `pacing_type` STRING COMMENT 'The budget pacing strategy for this flight. Determines how spend is distributed across the flight duration (even = uniform daily spend, front_loaded = higher spend at start, back_loaded = higher spend at end, custom = user-defined schedule).. Valid values are `even|front_loaded|back_loaded|custom`',
    `priority` STRING COMMENT 'Numeric priority ranking for this flight relative to other flights in the same campaign or portfolio. Higher values indicate higher priority for budget allocation and inventory access.',
    `start_date` DATE COMMENT 'The date when this flight begins execution. Marks the start of the time-bounded burst window.',
    `target_frequency` DECIMAL(18,2) COMMENT 'The planned average number of times each unique user should be exposed to the ad during this flight. Used to balance reach and repetition.',
    `target_grp` DECIMAL(18,2) COMMENT 'The planned Gross Rating Points for this flight, representing the sum of all rating points delivered. Standard metric for traditional media planning.',
    `target_impressions` BIGINT COMMENT 'The planned number of ad impressions to be delivered during this flight. Used for pacing and performance tracking.',
    `target_reach` BIGINT COMMENT 'The planned number of unique individuals or households to be reached during this flight. Key metric for awareness campaigns.',
    `target_trp` DECIMAL(18,2) COMMENT 'The planned Target Rating Points for this flight, representing GRP adjusted for the specific target audience. Used for audience-specific media planning.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this flight record. Supports accountability and audit requirements.',
    CONSTRAINT pk_flight PRIMARY KEY(`flight_id`)
) COMMENT 'Represents a discrete time-bounded execution window within a campaign — a campaign flight (also called a campaign burst or wave). Captures flight name, parent campaign reference, flight start date, flight end date, flight status, flight budget allocation, flight objective override, pacing type (even, front-loaded, back-loaded, custom), pacing goal, daypart restrictions, flight priority, channel mix for this flight, and notes. Enables multi-flight campaign structures where a single campaign runs in sequential or overlapping bursts with distinct budgets and targeting parameters. Aligns with Mediaocean Prisma flight-level planning constructs.';

CREATE OR REPLACE TABLE `advertising_ecm`.`campaign`.`line_item` (
    `line_item_id` BIGINT COMMENT 'Unique identifier for the line item. Primary key for the line item execution unit within a campaign flight.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Line items are media placements that deliver brand creative. Trafficking teams verify brand safety tier compliance, viewability standards, and creative approval status against brand guidelines before ',
    `campaign_id` BIGINT COMMENT 'Reference to the parent campaign under which this line item executes. Enables rollup reporting and budget tracking at campaign level.',
    `contract_insertion_order_id` BIGINT COMMENT 'Reference to the insertion order that authorizes this line item buy. Links media execution to contractual commitment.',
    `flight_id` BIGINT COMMENT 'Reference to the parent campaign flight that contains this line item. Establishes the hierarchical relationship between flight and line item.',
    `programmatic_deal_id` BIGINT COMMENT 'The unique identifier for a programmatic deal (PMP, preferred deal, or programmatic guaranteed) associated with this line item. Nullable for open exchange buys.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Line items frequently use suppliers beyond publishers (ad verification, measurement partners, data providers). Critical for line-item-level vendor reconciliation, cost attribution, and compliance trac',
    `trafficking_order_id` BIGINT COMMENT 'Foreign key linking to campaign.trafficking_order. Business justification: Line items are trafficked to ad servers via trafficking orders. Currently no FK exists to track which trafficking order activated a specific line item. This is essential for operational tracking and a',
    `publisher_id` BIGINT COMMENT 'Reference to the media vendor or publisher delivering this line item inventory. Links to vendor master for billing and performance tracking.',
    `ad_format` STRING COMMENT 'The creative format specification for this line item (e.g., 300x250 banner, 15-second pre-roll, sponsored post). Defines the deliverable unit.',
    `agency_commission_rate` DECIMAL(18,2) COMMENT 'The commission percentage applied to this line item. Expressed as a percentage (e.g., 15.00 for 15%). Used to calculate net from gross cost.',
    `booked_clicks` BIGINT COMMENT 'The contracted number of clicks to be delivered for this line item. Primary delivery goal for click-based buys.',
    `booked_conversions` BIGINT COMMENT 'The contracted number of conversions or acquisitions to be delivered for this line item. Primary delivery goal for performance-based buys.',
    `booked_impressions` BIGINT COMMENT 'The contracted number of impressions to be delivered for this line item. Primary delivery goal for impression-based buys.',
    `booked_views` BIGINT COMMENT 'The contracted number of video views or viewable impressions to be delivered for this line item. Primary delivery goal for video and viewability-based buys.',
    `brand_safety_tier` STRING COMMENT 'The level of brand safety filtering applied to this line item. Determines which content categories and contexts are excluded.. Valid values are `standard|moderate|strict|custom`',
    `channel_type` STRING COMMENT 'The media channel through which this line item will be executed. Determines platform, format options, and measurement methodology. [ENUM-REF-CANDIDATE: display|video|search|social|ooh|dooh|ctv|ott|audio|native|email|affiliate — 12 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this line item record was first created in the system. Used for audit trail and lifecycle tracking.',
    `creative_assignment_status` STRING COMMENT 'The status of creative asset assignment and approval for this line item. Indicates whether creatives are ready for serving.. Valid values are `not_assigned|partially_assigned|fully_assigned|approved|rejected`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values on this line item. Enables multi-currency campaign management.. Valid values are `^[A-Z]{3}$`',
    `delivery_status` STRING COMMENT 'The current delivery performance status of the line item. Indicates whether the line item is meeting, exceeding, or falling short of delivery goals. [ENUM-REF-CANDIDATE: scheduled|delivering|under_delivering|over_delivering|completed|paused|stopped — 7 candidates stripped; promote to reference product]',
    `end_date` DATE COMMENT 'The date when this line item stops serving. Defines the end of the delivery window. Nullable for evergreen line items.',
    `frequency_cap_impressions` STRING COMMENT 'The maximum number of impressions a unique user can receive for this line item within the frequency cap period. Used to control ad exposure.',
    `frequency_cap_period` STRING COMMENT 'The time period over which the frequency cap is applied. Defines the window for impression counting.. Valid values are `hour|day|week|month|lifetime`',
    `gross_cost` DECIMAL(18,2) COMMENT 'The gross media cost for this line item before agency commission. Represents the total amount billed to the client.',
    `is_programmatic` BOOLEAN COMMENT 'Indicates whether this line item is executed through programmatic buying platforms (DSP) or through direct/manual insertion orders.',
    `line_item_code` STRING COMMENT 'External business identifier or SKU for the line item. Used for trafficking, billing reconciliation, and cross-system reference.',
    `line_item_name` STRING COMMENT 'Human-readable name for the line item. Typically includes targeting, format, and channel descriptors for operational clarity.',
    `line_sequence` STRING COMMENT 'Ordinal position of this line item within the parent flight. Used for display ordering and operational sequencing.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this line item record was last modified. Used for change tracking and audit trail.',
    `net_cost` DECIMAL(18,2) COMMENT 'The net media cost for this line item after agency commission and discounts. Used for internal P&L and margin analysis.',
    `pacing_status` STRING COMMENT 'The current pacing health of the line item relative to its delivery goal and timeline. Used for proactive delivery management.. Valid values are `on_track|ahead|behind|at_risk|completed`',
    `pacing_strategy` STRING COMMENT 'The delivery pacing strategy for this line item. Determines how impressions are distributed across the flight period.. Valid values are `even|asap|frontload|backload|custom`',
    `placement_type` STRING COMMENT 'The buying model or inventory type for this line item. Indicates whether inventory is reserved, auction-based, or programmatic. [ENUM-REF-CANDIDATE: guaranteed|non-guaranteed|programmatic_guaranteed|preferred_deal|private_auction|open_exchange|direct — 7 candidates stripped; promote to reference product]',
    `priority` STRING COMMENT 'The delivery priority of this line item relative to other line items competing for the same inventory. Higher values indicate higher priority.',
    `rate_amount` DECIMAL(18,2) COMMENT 'The unit rate for this line item based on the rate type. For CPM, this is cost per thousand impressions; for CPC, cost per click; for flat, total cost.',
    `rate_type` STRING COMMENT 'The pricing model for this line item. Determines how cost is calculated based on delivery metrics (Cost Per Mille, Cost Per Click, Cost Per Acquisition, Cost Per View, flat fee). [ENUM-REF-CANDIDATE: cpm|cpc|cpa|cpv|cpe|flat|cpcv|vcpm — 8 candidates stripped; promote to reference product]',
    `start_date` DATE COMMENT 'The date when this line item begins serving. Defines the start of the delivery window.',
    `targeting_summary` STRING COMMENT 'High-level summary of audience targeting parameters applied to this line item (demographics, geography, behavior, context). Detailed targeting stored in related tables.',
    `trafficking_status` STRING COMMENT 'The operational status of line item setup and creative trafficking. Indicates readiness for delivery. [ENUM-REF-CANDIDATE: not_started|in_progress|ready_to_serve|live|paused|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `viewability_target_percentage` DECIMAL(18,2) COMMENT 'The target percentage of impressions that must meet viewability standards (MRC definition: 50% of pixels in view for 1 second for display, 2 seconds for video).',
    CONSTRAINT pk_line_item PRIMARY KEY(`line_item_id`)
) COMMENT 'Granular execution unit within a campaign flight representing a single buyable unit of media — the atomic record of what is being bought, at what price, on which channel, for which audience. Captures line item name, parent flight reference, campaign reference, channel type (display, video, search, social, OOH, CTV, audio), ad format, placement type, targeting summary, start date, end date, booked impressions, booked clicks, booked views, rate type (CPM, CPC, CPA, CPV, flat), rate amount, net cost, gross cost, currency, IO reference, vendor/publisher reference, trafficking status, delivery status, pacing status, and creative assignment status. The primary unit of media planning and buying execution. Aligns with Google Campaign Manager 360 placement and The Trade Desk ad group constructs.';

CREATE OR REPLACE TABLE `advertising_ecm`.`campaign`.`ad` (
    `ad_id` BIGINT COMMENT 'Unique identifier for the ad unit. Primary key.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Ads are executable brand creative units. QA teams verify brand guideline compliance (logo usage, color palette, tone), brand safety requirements, and regulatory compliance flags (GDPR, CCPA) against b',
    `campaign_id` BIGINT COMMENT 'Reference to the parent campaign to which this ad belongs.',
    `creative_asset_id` BIGINT COMMENT 'Reference to the creative asset (image, video, HTML5, audio) used in this ad execution.',
    `line_item_id` BIGINT COMMENT 'Reference to the parent campaign line item under which this ad is trafficked.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Individual ads may use specific suppliers for dynamic creative optimization, ad serving, or verification services. Required for ad-level vendor cost tracking, performance attribution, and troubleshoot',
    `trafficking_order_id` BIGINT COMMENT 'Foreign key linking to campaign.trafficking_order. Business justification: Ads are trafficked to ad servers via trafficking orders. Currently no FK exists to track which trafficking order activated a specific ad. This is essential for operational tracking (when was this ad t',
    `ad_name` STRING COMMENT 'Human-readable name assigned to this ad unit for identification and reporting purposes.',
    `ad_status` STRING COMMENT 'Current lifecycle status of the ad unit. Governs whether the ad is eligible for serving. [ENUM-REF-CANDIDATE: draft|pending_review|approved|rejected|live|paused|archived|expired — 8 candidates stripped; promote to reference product]',
    `ad_type` STRING COMMENT 'Classification of the ad unit by format type. Determines rendering and trafficking requirements. [ENUM-REF-CANDIDATE: banner|video|native|rich_media|audio|dooh|ctv|display|interstitial — 9 candidates stripped; promote to reference product]',
    `approval_date` DATE COMMENT 'Date when the ad was approved for trafficking and serving.',
    `approved_by` STRING COMMENT 'Name or identifier of the user who approved the ad for serving.',
    `brand_safety_verified` BOOLEAN COMMENT 'Indicates whether the ad creative has passed brand safety verification checks.',
    `ccpa_opt_out_honored` BOOLEAN COMMENT 'Indicates whether this ad honors CCPA Do Not Sell requests.',
    `click_through_url` STRING COMMENT 'Destination URL where users are directed when they click on the ad. May include tracking macros.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ad record was first created in the system.',
    `end_date` DATE COMMENT 'Date when the ad stops serving. Null indicates no end date.',
    `format` STRING COMMENT 'Dimensions of the ad creative in width x height format (e.g., 300x250, 728x90, 1920x1080). Null for non-display formats.',
    `frequency_cap` STRING COMMENT 'Maximum number of times this ad can be shown to a unique user within the frequency cap period.',
    `frequency_cap_period` STRING COMMENT 'Time window over which the frequency cap is enforced.. Valid values are `hour|day|week|month|campaign`',
    `gdpr_consent_required` BOOLEAN COMMENT 'Indicates whether user consent is required under GDPR before serving this ad.',
    `go_live_date` DATE COMMENT 'Date when the ad becomes eligible to start serving.',
    `impression_tracker_url` STRING COMMENT 'Third-party tracking pixel or beacon URL fired when the ad impression is served.',
    `landing_page_url` STRING COMMENT 'Final destination landing page URL after click-through, excluding tracking parameters.',
    `modified_by` STRING COMMENT 'User or system identifier that last modified the ad record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the ad record was last modified.',
    `notes` STRING COMMENT 'Free-text notes or comments about the ad unit for internal reference and collaboration.',
    `priority` STRING COMMENT 'Serving priority of this ad relative to other ads in the same line item. Higher values indicate higher priority.',
    `rejection_reason` STRING COMMENT 'Explanation for why the ad was rejected during review. Null if not rejected.',
    `server_ad_code` STRING COMMENT 'External identifier assigned by the ad server platform (e.g., Google Campaign Manager 360) for this ad unit.',
    `ssl_compliant` BOOLEAN COMMENT 'Indicates whether the ad creative and all tracking tags are served over HTTPS for secure delivery.',
    `third_party_tracking_enabled` BOOLEAN COMMENT 'Indicates whether third-party tracking pixels and beacons are enabled for this ad.',
    `trafficking_status` STRING COMMENT 'Operational status indicating whether the ad has been trafficked to the ad server and its current serving state.. Valid values are `not_trafficked|trafficked|live|paused|completed`',
    `vast_tag_url` STRING COMMENT 'VAST or VPAID tag URL for video ad serving. Null for non-video ad types.',
    `view_tracker_url` STRING COMMENT 'Third-party tracking URL fired when the ad is viewable according to MRC viewability standards.',
    `vpaid_enabled` BOOLEAN COMMENT 'Indicates whether the ad uses VPAID for interactive video ad execution.',
    `weight` STRING COMMENT 'Relative weight for rotation when multiple ads are eligible to serve. Used for A/B testing and creative rotation.',
    `created_by` STRING COMMENT 'User or system identifier that created the ad record.',
    CONSTRAINT pk_ad PRIMARY KEY(`ad_id`)
) COMMENT 'Individual ad unit record representing a specific creative execution trafficked and served within a campaign line item. Captures ad name, parent line item reference, campaign reference, ad type (banner, video, native, rich media, audio, DOOH), ad format dimensions (width x height), VAST/VPAID tag reference, click-through URL, impression tracker URL, view tracker URL, creative asset reference, ad status (draft, pending review, approved, rejected, live, paused, archived), trafficking status, ad server ad ID (CM360), go-live date, end date, frequency cap, frequency cap period, and audit timestamps. Bridges the campaign execution layer to the creative asset layer. Aligns with Google Campaign Manager 360 ad trafficking entities.';

CREATE OR REPLACE TABLE `advertising_ecm`.`campaign`.`targeting_rule` (
    `targeting_rule_id` BIGINT COMMENT 'Unique identifier for the targeting rule. Primary key.',
    `audience_segment_id` BIGINT COMMENT 'Reference to the audience segment when targeting dimension is audience_segment, retargeting, or lookalike.',
    `campaign_id` BIGINT COMMENT 'The identifier of the parent entity (campaign, flight, or line_item) to which this targeting rule applies.',
    `flight_id` BIGINT COMMENT 'Foreign key linking to campaign.flight. Business justification: targeting_rule has parent_entity_type attribute indicating it can apply to campaign, flight, or line_item. Currently only has campaign_id FK. Adding flight_id (nullable) to support flight-level target',
    `line_item_id` BIGINT COMMENT 'Foreign key linking to campaign.line_item. Business justification: targeting_rule has parent_entity_type attribute indicating it can apply to campaign, flight, or line_item. Currently only has campaign_id FK. Adding line_item_id (nullable) to support line_item-level ',
    `positioning_id` BIGINT COMMENT 'Foreign key linking to brand.brand_positioning. Business justification: Targeting rules implement audience definitions from brand positioning strategy. Target audience segments, geographic scope, and messaging framework from positioning documents drive targeting configura',
    `brand_safety_tier` STRING COMMENT 'The brand safety standard applied: Trustworthy Accountability Group (TAG) certified, Global Alliance for Responsible Media (GARM) standard, or custom.. Valid values are `tag_certified|garm_standard|custom`',
    `browser_type` STRING COMMENT 'The web browser targeted (e.g., Chrome, Safari, Firefox, Edge).',
    `ccpa_opt_out_flag` BOOLEAN COMMENT 'Indicates whether this targeting rule respects CCPA opt-out requests (Do Not Sell My Personal Information).',
    `connection_type` STRING COMMENT 'The type of network connection targeted: WiFi, cellular, ethernet, or unknown.. Valid values are `wifi|cellular|ethernet|unknown`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this targeting rule record was first created in the system.',
    `data_source` STRING COMMENT 'The origin of the targeting data: first-party (owned), second-party (partner), third-party (purchased), Data Management Platform (DMP), or Customer Data Platform (CDP).. Valid values are `first_party|second_party|third_party|dmp|cdp`',
    `daypart_schedule` STRING COMMENT 'The time-of-day or day-of-week schedule for ad delivery, specified in a structured format (e.g., JSON or cron-like expression).',
    `device_type` STRING COMMENT 'The type of device targeted: desktop, mobile, tablet, Connected TV (CTV), Over-the-Top (OTT), or wearable.. Valid values are `desktop|mobile|tablet|ctv|ott|wearable`',
    `effective_end_date` DATE COMMENT 'The date when this targeting rule expires and is no longer applied. Null indicates no expiration.',
    `effective_start_date` DATE COMMENT 'The date when this targeting rule becomes active and begins to be applied.',
    `fraud_prevention_threshold` DECIMAL(18,2) COMMENT 'The minimum fraud detection score (0-100) required for ad delivery, used to filter out suspected invalid traffic.',
    `frequency_cap_limit` STRING COMMENT 'The maximum number of times an ad can be shown to a user within the specified frequency cap window.',
    `frequency_cap_unit` STRING COMMENT 'The time unit for the frequency cap window: hour, day, week, month, or lifetime.. Valid values are `hour|day|week|month|lifetime`',
    `frequency_cap_window` STRING COMMENT 'The time window (in the unit specified by frequency_cap_unit) over which the frequency cap limit applies.',
    `gdpr_consent_required` BOOLEAN COMMENT 'Indicates whether GDPR user consent is required for this targeting rule to be applied.',
    `geo_level` STRING COMMENT 'The granularity of geographic targeting: country, region/state, Designated Market Area (DMA), city, or postal code.. Valid values are `country|region|dma|city|postal_code`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this targeting rule is currently active and being applied to ad delivery.',
    `language` STRING COMMENT 'The language targeted, specified as ISO 639-1 two-letter language code (e.g., en, es, fr).',
    `modified_by` STRING COMMENT 'The user or system identifier that last modified this targeting rule.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this targeting rule record was last modified.',
    `os_type` STRING COMMENT 'The operating system targeted (e.g., iOS, Android, Windows, macOS, tvOS).',
    `parent_entity_type` STRING COMMENT 'The type of entity to which this targeting rule is applied: campaign, flight, or line_item.. Valid values are `campaign|flight|line_item`',
    `priority` STRING COMMENT 'The priority or precedence of this targeting rule when multiple rules apply to the same entity. Lower numbers indicate higher priority.',
    `recency_window` STRING COMMENT 'The time window (in days) for behavioral or retargeting data recency, specifying how recent user activity must be to qualify for targeting.',
    `rule_name` STRING COMMENT 'Business-friendly name for the targeting rule, used for identification and reporting purposes.',
    `targeting_dimension` STRING COMMENT 'The dimension or category of targeting applied by this rule. [ENUM-REF-CANDIDATE: geography|demographic|behavioral|contextual|keyword|device|daypart|audience_segment|retargeting|lookalike|brand_safety_content_exclusion|brand_safety_keyword_block|brand_safety_domain_block|brand_safety_category_exclusion|frequency_cap|viewability|fraud_prevention — promote to reference product]',
    `targeting_operator` STRING COMMENT 'Specifies whether the targeting rule includes or excludes the specified targeting value.. Valid values are `include|exclude`',
    `targeting_value` DECIMAL(18,2) COMMENT 'The specific value or identifier for the targeting dimension (e.g., country code, age range, device type, audience segment ID).',
    `targeting_value_type` STRING COMMENT 'Indicates the format of the targeting value: single value, range, comma-separated list, or pattern/regex.. Valid values are `single|range|list|pattern`',
    `viewability_standard` STRING COMMENT 'The viewability measurement standard applied: Media Rating Council (MRC), Interactive Advertising Bureau (IAB), or custom.. Valid values are `mrc|iab|custom`',
    `created_by` STRING COMMENT 'The user or system identifier that created this targeting rule.',
    CONSTRAINT pk_targeting_rule PRIMARY KEY(`targeting_rule_id`)
) COMMENT 'Defines the audience, contextual, and brand safety targeting parameters applied to a campaign, flight, or line item. Captures targeting rule name, parent entity type (campaign/flight/line_item), parent entity reference, targeting dimension (geography, demographic, behavioral, contextual, keyword, device, daypart, audience segment, retargeting, lookalike, brand_safety_content_exclusion, brand_safety_keyword_block, brand_safety_domain_block, brand_safety_category_exclusion), targeting operator (include/exclude), targeting value, targeting value type, data source (first-party, second-party, third-party, DMP, CDP), audience segment reference, geo level (country, region, DMA, city, postal code), device type, OS type, browser type, connection type, language, daypart schedule, frequency cap limit, frequency cap window, frequency cap unit, brand safety tier (TAG certified, GARM standard), viewability standard, fraud prevention threshold, GDPR consent required flag, CCPA opt-out flag, recency window, and is_active flag. Enables precise audience targeting governance and brand safety enforcement across programmatic and direct channels.';

CREATE OR REPLACE TABLE `advertising_ecm`.`campaign`.`budget_allocation` (
    `budget_allocation_id` BIGINT COMMENT 'Unique identifier for the budget allocation record. Primary key for this entity.',
    `budget_optimization_scenario_id` BIGINT COMMENT 'Foreign key linking to analytics.budget_optimization_scenario. Business justification: Planning-to-execution traceability: budget_allocations implement recommendations from budget_optimization_scenarios (MMM-driven channel mix, attribution-informed spend allocation). Linking allocation ',
    `campaign_id` BIGINT COMMENT 'Reference to the parent campaign for which budget is being allocated.',
    `flight_id` BIGINT COMMENT 'Reference to the parent flight within the campaign for which budget is allocated.',
    `line_item_id` BIGINT COMMENT 'Reference to the specific line item receiving this budget allocation.',
    `pacing_rule_id` BIGINT COMMENT 'Foreign key linking to campaign.pacing_rule. Business justification: budget_allocation currently has pacing_rule_name (STRING) which is a denormalized reference. Should normalize to FK relationship with pacing_rule.pacing_rule_id. This enables joining to get full pacin',
    `actual_spend` DECIMAL(18,2) COMMENT 'The actual amount spent to date against this budget allocation, based on delivered impressions and clicks.',
    `allocation_method` STRING COMMENT 'The method used to distribute budget across periods or channels (e.g., percentage-based, fixed amount, dynamic optimization).. Valid values are `percentage|fixed|dynamic|proportional|weighted`',
    `allocation_reference` STRING COMMENT 'Business-facing reference number or code for this budget allocation, used for tracking and reconciliation.',
    `allocation_status` STRING COMMENT 'The current lifecycle status of this budget allocation (e.g., draft, active, paused, completed, cancelled).. Valid values are `draft|active|paused|completed|cancelled`',
    `auto_optimization_enabled` BOOLEAN COMMENT 'Indicates whether automated optimization algorithms are enabled to adjust bids and budgets dynamically based on performance.',
    `budget_period_type` STRING COMMENT 'The time period granularity for which this budget allocation applies (e.g., monthly, weekly, flight-level).. Valid values are `daily|weekly|monthly|quarterly|flight|campaign`',
    `budget_source` STRING COMMENT 'The origin or authority for this budget allocation (e.g., client-approved, agency-estimated, internal forecast).. Valid values are `client_approved|agency_estimated|internal_forecast|revised_io`',
    `channel_type` STRING COMMENT 'The advertising channel or media type for which this budget is allocated. CTV (Connected TV), OTT (Over-the-Top), DOOH (Digital Out-of-Home), OOH (Out-of-Home). [ENUM-REF-CANDIDATE: display|video|social|search|audio|native|ctv|ott|dooh|ooh|print|radio|tv — 13 candidates stripped; promote to reference product]',
    `committed_spend` DECIMAL(18,2) COMMENT 'The amount of budget that has been committed through insertion orders or programmatic deals but not yet spent.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this budget allocation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this allocation (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `daily_impression_goal` BIGINT COMMENT 'The target number of impressions to be delivered per day under the pacing rule.',
    `daily_spend_cap` DECIMAL(18,2) COMMENT 'The maximum amount that can be spent per day for this allocation, enforced by the pacing rule.',
    `effective_end_date` DATE COMMENT 'The date when this budget allocation expires and delivery must stop. Null for open-ended allocations.',
    `effective_start_date` DATE COMMENT 'The date when this budget allocation becomes active and delivery can begin.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this budget allocation record was last updated or modified.',
    `last_reconciliation_date` DATE COMMENT 'The date when this budget allocation was last reconciled against actual spend and delivery data from ad servers and billing systems.',
    `notes` STRING COMMENT 'Free-text notes or comments about this budget allocation, including rationale for revisions, special instructions, or reconciliation findings.',
    `optimization_algorithm_reference` STRING COMMENT 'Reference to the specific optimization algorithm or strategy applied to this allocation (e.g., CPA optimization, ROAS maximization).',
    `over_delivery_action` STRING COMMENT 'The action to take when delivery exceeds the pacing goal or budget cap (e.g., pause campaign, throttle bids, send alert).. Valid values are `pause|throttle|alert|continue`',
    `over_delivery_tolerance_pct` DECIMAL(18,2) COMMENT 'The acceptable percentage over-delivery before corrective action is taken (e.g., 5.00 means 5% over-delivery is tolerated).',
    `pacing_alert_threshold_pct` DECIMAL(18,2) COMMENT 'The percentage deviation from the pacing goal that triggers an alert to campaign managers (e.g., 10.00 means alert at 10% deviation).',
    `pacing_check_frequency` STRING COMMENT 'How frequently the pacing engine evaluates delivery performance and adjusts bid strategies (e.g., real-time, hourly, daily).. Valid values are `real_time|hourly|every_4_hours|daily|manual`',
    `pacing_type` STRING COMMENT 'The pacing strategy governing how budget and impressions are delivered over time (e.g., even, accelerated, front-loaded, back-loaded, custom curve).. Valid values are `even|accelerated|front_loaded|back_loaded|custom_curve|asap`',
    `planned_budget_amount` DECIMAL(18,2) COMMENT 'The original planned budget amount allocated for this period and channel, as approved in the initial media plan.',
    `reconciliation_status` STRING COMMENT 'The current status of the budget reconciliation process for this allocation (e.g., pending, reconciled, discrepancy found, approved).. Valid values are `pending|in_progress|reconciled|discrepancy|approved`',
    `remaining_budget` DECIMAL(18,2) COMMENT 'The remaining unspent budget available for this allocation, calculated as revised (or planned) budget minus actual spend and committed spend.',
    `revised_budget_amount` DECIMAL(18,2) COMMENT 'The revised budget amount after any adjustments, reallocations, or change orders. Null if no revision has occurred.',
    `under_delivery_action` STRING COMMENT 'The action to take when delivery falls short of the pacing goal (e.g., boost bids, increase budget allocation, send alert).. Valid values are `boost|increase_bids|alert|no_action`',
    `under_delivery_tolerance_pct` DECIMAL(18,2) COMMENT 'The acceptable percentage under-delivery before corrective action is taken (e.g., 5.00 means 5% under-delivery is tolerated).',
    `weekly_impression_goal` BIGINT COMMENT 'The target number of impressions to be delivered per week under the pacing rule.',
    `weekly_spend_cap` DECIMAL(18,2) COMMENT 'The maximum amount that can be spent per week for this allocation, enforced by the pacing rule.',
    CONSTRAINT pk_budget_allocation PRIMARY KEY(`budget_allocation_id`)
) COMMENT 'Unified financial and delivery control record governing how campaign budget is distributed AND how delivery is paced across flights, line items, channels, and time periods. Captures allocation reference, parent campaign reference, parent flight reference, line item reference, channel type, budget period (monthly, weekly, flight), planned budget amount, revised budget amount, committed spend, actual spend to date, remaining budget, currency, budget source (client-approved, agency-estimated), allocation method (percentage, fixed, dynamic), pacing rule name, pacing type (even, accelerated, front-loaded, back-loaded, custom curve), daily impression goal, daily spend cap, weekly impression goal, weekly spend cap, pacing check frequency (hourly, daily), over-delivery action (pause, throttle, alert), under-delivery action (boost, alert), pacing alert threshold percentage, over-delivery tolerance percentage, under-delivery tolerance percentage, auto-optimization enabled flag, optimization algorithm reference, effective date range, last reconciliation date, and reconciliation status. Serves as the single SSOT for budget allocation decisions, delivery pacing strategy, and pacing guardrails — practitioners manage budget and pacing as a unified workflow because pacing cannot be set independently of budget constraints. Subsumes all pacing rule definitions previously modeled separately.';

CREATE OR REPLACE TABLE `advertising_ecm`.`campaign`.`pacing_rule` (
    `pacing_rule_id` BIGINT COMMENT 'Unique identifier for the pacing rule record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Reference to the parent campaign entity to which this pacing rule applies.',
    `flight_id` BIGINT COMMENT 'Reference to the parent flight entity to which this pacing rule applies, if applicable.',
    `line_item_id` BIGINT COMMENT 'Reference to the parent line item entity to which this pacing rule applies, if applicable.',
    `optimization_algorithm_id` BIGINT COMMENT 'Reference to the optimization algorithm or model used for auto-pacing adjustments, if applicable.',
    `worker_id` BIGINT COMMENT 'Reference to the user who created this pacing rule record.',
    `auto_optimization_enabled` BOOLEAN COMMENT 'Indicates whether automated optimization algorithms are enabled to adjust pacing dynamically based on performance data.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this pacing rule record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this pacing rule (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `custom_curve_definition` STRING COMMENT 'JSON or structured definition of a custom pacing curve when pacing_type is set to custom_curve. Defines delivery distribution over time.',
    `daily_impression_goal` BIGINT COMMENT 'Target number of impressions to be delivered per day under this pacing rule.',
    `daily_spend_cap` DECIMAL(18,2) COMMENT 'Maximum spend allowed per day under this pacing rule, expressed in the campaign currency.',
    `dayparting_enabled` BOOLEAN COMMENT 'Indicates whether dayparting (time-of-day targeting) is applied as part of the pacing strategy.',
    `dayparting_schedule` STRING COMMENT 'Structured definition of the dayparting schedule (e.g., JSON or cron-like format) specifying hours and days when delivery is allowed or prioritized.',
    `effective_end_date` DATE COMMENT 'The date on which this pacing rule ceases to be active. Null indicates an open-ended rule.',
    `effective_start_date` DATE COMMENT 'The date from which this pacing rule becomes active and begins governing delivery.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this pacing rule record was last updated.',
    `notes` STRING COMMENT 'Free-text notes or comments about this pacing rule, used for documentation and operational context.',
    `over_delivery_action` STRING COMMENT 'The action to be taken when delivery exceeds the pacing goal or cap (e.g., pause delivery, throttle impressions, send alert).. Valid values are `pause|throttle|alert|continue`',
    `pacing_alert_threshold_pct` DECIMAL(18,2) COMMENT 'The percentage deviation from the pacing goal that triggers an alert to campaign managers (e.g., 10.00 means alert if delivery is 10% off target).',
    `pacing_check_frequency` STRING COMMENT 'The frequency at which the pacing engine evaluates delivery progress against goals and applies throttling or boosting actions.. Valid values are `real_time|hourly|every_4_hours|daily|weekly`',
    `pacing_status` STRING COMMENT 'Current lifecycle status of the pacing rule indicating whether it is actively governing delivery.. Valid values are `active|paused|completed|suspended|draft`',
    `pacing_type` STRING COMMENT 'The delivery pacing strategy applied to the campaign or line item. Defines how impressions or spend are distributed over the flight period.. Valid values are `even|accelerated|front_loaded|back_loaded|custom_curve|asap`',
    `parent_entity_type` STRING COMMENT 'The type of parent entity to which this pacing rule is attached (e.g., campaign, flight, line item, insertion order).. Valid values are `campaign|flight|line_item|insertion_order|creative|placement`',
    `priority_level` STRING COMMENT 'Numeric priority level for this pacing rule when multiple rules apply to the same entity. Higher values indicate higher priority.',
    `rule_name` STRING COMMENT 'Human-readable name or label for the pacing rule, used for identification and reporting purposes.',
    `timezone` STRING COMMENT 'IANA timezone identifier (e.g., America/New_York, Europe/London) used for interpreting pacing schedules and dayparting rules.',
    `under_delivery_action` STRING COMMENT 'The action to be taken when delivery falls short of the pacing goal (e.g., boost bid, send alert, reallocate budget).. Valid values are `boost|alert|continue|reallocate`',
    `weekly_impression_goal` BIGINT COMMENT 'Target number of impressions to be delivered per week under this pacing rule.',
    `weekly_spend_cap` DECIMAL(18,2) COMMENT 'Maximum spend allowed per week under this pacing rule, expressed in the campaign currency.',
    CONSTRAINT pk_pacing_rule PRIMARY KEY(`pacing_rule_id`)
) COMMENT 'Defines the delivery pacing strategy and guardrails for a campaign, flight, or line item. Captures pacing rule name, parent entity type, parent entity reference, pacing type (even, accelerated, front-loaded, back-loaded, custom curve), daily impression goal, daily spend cap, weekly impression goal, weekly spend cap, pacing check frequency (hourly, daily), over-delivery action (pause, throttle, alert), under-delivery action (boost, alert), pacing alert threshold percentage, auto-optimization enabled flag, optimization algorithm reference, and effective date range. Governs how campaign delivery is distributed over time to meet KPIs and avoid over/under-spend.';

CREATE OR REPLACE TABLE `advertising_ecm`.`campaign`.`trafficking_order` (
    `trafficking_order_id` BIGINT COMMENT 'Unique identifier for the trafficking order. Primary key for the trafficking order entity.',
    `campaign_id` BIGINT COMMENT 'Reference to the parent campaign for which this trafficking order is issued.',
    `flight_id` BIGINT COMMENT 'Reference to the parent flight or media schedule within the campaign that this trafficking order activates.',
    `parent_trafficking_order_id` BIGINT COMMENT 'Reference to the original trafficking order if this is a revision or amendment, enabling tracking of the full order history and change lineage.',
    `worker_id` BIGINT COMMENT 'Reference to the user or ad operations specialist who submitted the trafficking order to the ad server platform.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Trafficking orders involve third-party ad servers or trafficking platforms (suppliers). Essential for tracking which ad server/platform was used, critical for troubleshooting, billing, and vendor perf',
    `actual_live_timestamp` TIMESTAMP COMMENT 'Actual date and time when the trafficking order went live and ads began serving, as confirmed by the ad server platform.',
    `ad_server_order_code` STRING COMMENT 'External order or campaign identifier assigned by the ad server platform (e.g., CM360 order ID, Trade Desk campaign ID) for cross-system reconciliation.',
    `ad_server_platform` STRING COMMENT 'The ad serving or demand-side platform (DSP) to which this trafficking order is submitted for campaign activation and delivery. [ENUM-REF-CANDIDATE: Google Campaign Manager 360|The Trade Desk|DV360|Amazon DSP|Xandr|MediaMath|Adobe Advertising Cloud|Sizmek|Other — 9 candidates stripped; promote to reference product]',
    `ads_trafficked_count` STRING COMMENT 'Total number of individual ad creatives that were trafficked and uploaded to the ad server as part of this trafficking order.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the trafficking order was marked as completed, indicating that all line items and ads are live and the operational handoff is finalized.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the trafficking order record was first created in the system, marking the initiation of the trafficking workflow.',
    `go_live_date` DATE COMMENT 'Scheduled date when the trafficked campaign line items and ads are expected to begin serving live impressions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the trafficking order record was most recently updated, tracking the latest change to any field in the order.',
    `line_items_trafficked_count` STRING COMMENT 'Total number of campaign line items that were trafficked and configured in the ad server as part of this trafficking order.',
    `pixel_firing_validation_status` STRING COMMENT 'Validation status of tracking pixels and conversion tags, confirming that impression, click, and conversion pixels are firing correctly in test environments.. Valid values are `not_applicable|pending|passed|failed|warning`',
    `priority_level` STRING COMMENT 'Operational priority assigned to this trafficking order, indicating urgency and sequencing for ad operations team workload management.. Valid values are `low|normal|high|urgent`',
    `qa_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the quality assurance review was completed and the trafficking order was approved or rejected for go-live.',
    `qa_status` STRING COMMENT 'Current status of the quality assurance review process for this trafficking order, indicating whether pre-launch validation checks have been completed and passed.. Valid values are `not_started|in_progress|passed|failed|waived`',
    `rejection_reason` STRING COMMENT 'Detailed explanation provided when a trafficking order is rejected during QA or by the ad server platform, including specific issues that must be resolved before resubmission.',
    `revision_number` STRING COMMENT 'Sequential version number tracking revisions and resubmissions of the trafficking order due to changes, corrections, or rejections.',
    `sla_met_flag` BOOLEAN COMMENT 'Boolean indicator of whether the trafficking order was completed within the defined SLA target hours, used for operational performance tracking.',
    `sla_target_hours` STRING COMMENT 'Target number of hours within which the trafficking order should be completed from submission to go-live, as defined by internal SLA policies.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the trafficking order was submitted to the ad server or DSP for processing and activation.',
    `trafficking_notes` STRING COMMENT 'Free-text operational notes and instructions provided by the trafficking team regarding special setup requirements, targeting parameters, creative specifications, or platform-specific configurations.',
    `trafficking_order_number` STRING COMMENT 'Business-facing unique trafficking order number used for operational reference and communication with ad ops teams and external platforms.. Valid values are `^TO-[0-9]{8,12}$`',
    `trafficking_status` STRING COMMENT 'Current lifecycle status of the trafficking order indicating its progress through the ad operations workflow from submission to go-live. [ENUM-REF-CANDIDATE: pending|submitted|in_progress|live|completed|rejected|cancelled — 7 candidates stripped; promote to reference product]',
    `trafficking_type` STRING COMMENT 'Classification of the trafficking order based on the campaign buying model and activation method (standard direct IO, programmatic guaranteed, sponsorship, etc.).. Valid values are `standard|programmatic|direct|sponsorship|house`',
    `vast_tag_validation_status` STRING COMMENT 'Validation status of VAST tags for video ad creatives, indicating whether the tags conform to IAB VAST specifications and are ready for serving.. Valid values are `not_applicable|pending|passed|failed|warning`',
    CONSTRAINT pk_trafficking_order PRIMARY KEY(`trafficking_order_id`)
) COMMENT 'Represents the formal trafficking instruction set issued to an ad server or DSP to activate campaign line items and ads. Captures trafficking order number, parent campaign reference, parent flight reference, ad server platform (CM360, The Trade Desk, etc.), trafficking status (pending, submitted, in-progress, live, completed, rejected), submitted by, submitted date, go-live date, trafficking notes, QA status, QA completed by, QA completed date, number of line items trafficked, number of ads trafficked, VAST tag validation status, pixel firing validation status, and audit timestamps. Represents the operational handoff from planning to execution — a distinct business workflow from the campaign plan itself.';

CREATE OR REPLACE TABLE `advertising_ecm`.`campaign`.`status_history` (
    `status_history_id` BIGINT COMMENT 'Unique identifier for each campaign status transition record. Primary key for the campaign status history event log.',
    `approval_id` BIGINT COMMENT 'Reference to the approval record if this status change required formal approval. Links to approval workflow for governance tracking.',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign that experienced this status transition. Links this history record to the campaign master entity.',
    `flight_id` BIGINT COMMENT 'Foreign key linking to campaign.flight. Business justification: Flights have flight_status attribute with transitions throughout their lifecycle. status_history is described as tracking status transitions for campaigns, but should also track flight status changes.',
    `line_item_id` BIGINT COMMENT 'Foreign key linking to campaign.line_item. Business justification: Line items have multiple status attributes (trafficking_status, delivery_status, pacing_status) with transitions throughout their lifecycle. status_history should track line_item status changes. Addin',
    `trafficking_order_id` BIGINT COMMENT 'Foreign key linking to campaign.trafficking_order. Business justification: Trafficking orders have multiple status attributes (trafficking_status, qa_status) with transitions throughout their lifecycle. status_history should track trafficking order status changes. Adding tra',
    `worker_id` BIGINT COMMENT 'Reference to the user who initiated the status change. Null for system-initiated transitions. Critical for accountability and audit trails.',
    `workflow_step_id` BIGINT COMMENT 'Identifier of the workflow step or stage that triggered this transition. Used for process mining and workflow optimization.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this status transition required formal approval according to campaign governance rules.',
    `changed_by_system` STRING COMMENT 'Name or identifier of the system that triggered the status change. Populated for automated and system-initiated transitions.',
    `changed_by_user_name` STRING COMMENT 'Full name of the user who initiated the status change. Denormalized for reporting convenience and historical preservation.',
    `client_visible_flag` BOOLEAN COMMENT 'Indicates whether this status transition should be visible to the client in external reporting and dashboards.',
    `compliance_review_completed_flag` BOOLEAN COMMENT 'Indicates whether required compliance review has been completed for this status transition.',
    `compliance_review_required_flag` BOOLEAN COMMENT 'Indicates whether this status transition requires compliance or legal review according to regulatory requirements.',
    `duration_in_previous_status_hours` DECIMAL(18,2) COMMENT 'The number of hours the campaign spent in the previous status before this transition. Calculated field for lifecycle analytics.',
    `effective_date` DATE COMMENT 'The business date when the new status became effective. May differ from transition timestamp for scheduled or backdated changes.',
    `ip_address` STRING COMMENT 'The IP address from which the status change was initiated. Captured for security audit and fraud detection purposes.',
    `new_status` STRING COMMENT 'The status of the campaign after this transition. Captures the to-state in the status lifecycle. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|scheduled|active|paused|completed|cancelled|archived — 9 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Additional free-text notes or comments about the status transition. Captures contextual information for future reference.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether automated notifications were sent to stakeholders about this status change.',
    `notification_timestamp` TIMESTAMP COMMENT 'The date and time when stakeholder notifications were sent for this status transition. Null if no notifications were sent.',
    `previous_status` STRING COMMENT 'The status of the campaign immediately before this transition occurred. Captures the from-state in the status lifecycle. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|scheduled|active|paused|completed|cancelled|archived — 9 candidates stripped; promote to reference product]',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this history record was created in the data warehouse. Used for data lineage and audit purposes.',
    `rollback_flag` BOOLEAN COMMENT 'Indicates whether this status transition was later rolled back or reversed. Used for tracking corrections and error recovery.',
    `rollback_reason` STRING COMMENT 'Explanation of why this status transition was rolled back. Provides context for error analysis and process improvement.',
    `rollback_timestamp` TIMESTAMP COMMENT 'The date and time when this status transition was rolled back. Null if the transition was not rolled back.',
    `session_code` STRING COMMENT 'The user session identifier during which the status change occurred. Links to session logs for detailed audit trails.',
    `source_system` STRING COMMENT 'The operational system that recorded this status transition. Critical for data lineage and multi-system reconciliation.',
    `source_system_record_code` STRING COMMENT 'The unique identifier of this status transition record in the source operational system. Enables traceability back to source.',
    `transition_reason_code` STRING COMMENT 'Standardized code indicating the business reason for the status change. Used for categorization and reporting of transition patterns.',
    `transition_reason_description` STRING COMMENT 'Detailed free-text explanation of why the status transition occurred. Provides context for audit and client reporting purposes.',
    `transition_timestamp` TIMESTAMP COMMENT 'The precise date and time when the campaign status transition occurred. Primary event timestamp for this history record.',
    `transition_type` STRING COMMENT 'The mechanism that triggered the status change. Distinguishes between user-initiated, system-triggered, and automated workflow transitions.. Valid values are `manual|automated|system|scheduled|api`',
    `user_agent` STRING COMMENT 'The browser or application user agent string for the session that initiated the status change. Used for security and audit purposes.',
    CONSTRAINT pk_status_history PRIMARY KEY(`status_history_id`)
) COMMENT 'Immutable audit log of all status transitions for a campaign throughout its lifecycle. Captures history record ID, campaign reference, previous status, new status, transition reason, transition type (manual, automated, system), changed by user, changed by system, change timestamp, effective date, approval reference (if status change required approval), notes, and source system. Enables full lifecycle traceability for campaign governance, client reporting, and regulatory compliance. Distinct from the campaign master record — this is the event-sourced history of state changes.';

CREATE OR REPLACE TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` (
    `campaign_kpi_target_id` BIGINT COMMENT 'Unique identifier for the campaign KPI target record. Primary key for this entity.',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign when parent_entity_type is campaign. Null for flight or line_item parent types.',
    `flight_id` BIGINT COMMENT 'Reference to the flight when parent_entity_type is flight. Null for campaign or line_item parent types.',
    `line_item_id` BIGINT COMMENT 'Reference to the line item when parent_entity_type is line_item. Null for campaign or flight parent types.',
    `positioning_id` BIGINT COMMENT 'Foreign key linking to brand.brand_positioning. Business justification: Campaign KPI targets measure performance against brand positioning objectives. Awareness lift, sentiment improvement, and NPS targets derive from brand positioning baselines. Campaign success is evalu',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: KPI targets are frequently set for specific audience segments (e.g., achieve 8% conversion rate among in-market auto intenders segment). Performance reporting and optimization decisions require meas',
    `alert_threshold_percentage` DECIMAL(18,2) COMMENT 'The percentage deviation from target that triggers a performance alert. Used for automated monitoring and optimization workflows.',
    `baseline_value` DECIMAL(18,2) COMMENT 'The baseline or minimum acceptable value for this KPI. Used to establish performance thresholds below which the campaign is considered underperforming.',
    `benchmark_source` STRING COMMENT 'The source of industry benchmark data used to establish this target (e.g., Nielsen norms, IAB benchmarks, historical campaign data).',
    `benchmark_value` DECIMAL(18,2) COMMENT 'The industry or historical benchmark value for this KPI type. Used for comparative performance analysis.',
    `channel_scope` STRING COMMENT 'The media channel or platform for which this KPI target applies (e.g., display, video, social, search). Allows for channel-specific targets within multi-channel campaigns.',
    `confidence_level` STRING COMMENT 'The level of confidence in achieving this target based on historical performance, market conditions, and campaign parameters.. Valid values are `high|medium|low`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this KPI target record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for monetary KPI targets (CPA, CPM, CPC, ROAS). Required when target_unit is currency.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'The date through which this KPI target remains active. Null indicates the target is active through the end of the parent entitys duration.',
    `effective_start_date` DATE COMMENT 'The date from which this KPI target becomes active and should be measured. Allows for phased KPI introduction or mid-campaign target changes.',
    `geographic_scope` STRING COMMENT 'The geographic region or market for which this KPI target applies. Enables market-specific performance targets.',
    `is_primary_kpi` BOOLEAN COMMENT 'Indicates whether this is the primary KPI for the parent entity. True if this is the main success metric; false for secondary or supporting KPIs.',
    `kpi_type` STRING COMMENT 'The specific KPI metric being targeted. [ENUM-REF-CANDIDATE: impressions|clicks|ctr|conversions|cpa|cpm|cpc|roas|vtr|grp|trp|sov|reach|frequency|nps|viewability|completion_rate|engagement_rate — promote to reference product]. Valid values are `impressions|clicks|ctr|conversions|cpa|cpm`',
    `measurement_methodology` STRING COMMENT 'Description of the methodology used to measure and calculate this KPI. Includes attribution model, measurement window, deduplication rules, and any custom calculation logic.',
    `measurement_source` STRING COMMENT 'The system or platform that will provide the actual measurement data for this KPI. Determines the source of truth for performance reporting.. Valid values are `nielsen|comscore|cm360|ga|trade_desk|custom`',
    `modified_by` STRING COMMENT 'The user or system that last modified this KPI target record. Supports change tracking and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this KPI target record was last modified in the system.',
    `notes` STRING COMMENT 'Additional notes, context, or special instructions related to this KPI target. Captures nuances not covered by structured fields.',
    `optimization_priority` STRING COMMENT 'The priority level for optimization efforts when this KPI is underperforming. Guides resource allocation for campaign management.. Valid values are `critical|high|medium|low`',
    `parent_entity_type` STRING COMMENT 'The type of parent entity to which this KPI target is attached. Determines the scope of the KPI measurement (campaign-level, flight-level, or line-item-level).. Valid values are `campaign|flight|line_item`',
    `reporting_cadence` STRING COMMENT 'The frequency at which this KPI should be measured and reported. Determines the monitoring and optimization cycle for this metric.. Valid values are `real_time|hourly|daily|weekly|monthly|end_of_campaign`',
    `revision_reason` STRING COMMENT 'Business justification for the most recent revision to this KPI target. Captures why the target was changed mid-campaign.',
    `stretch_target_value` DECIMAL(18,2) COMMENT 'The aspirational or stretch goal value for this KPI. Represents exceptional performance beyond the standard target.',
    `target_audience_segment` STRING COMMENT 'The specific audience segment for which this KPI target applies. Allows for segment-specific performance targets within a single campaign.',
    `target_period` STRING COMMENT 'The time period over which the target should be achieved. Total indicates the target is for the entire campaign/flight/line_item duration.. Valid values are `total|daily|weekly|monthly|quarterly`',
    `target_revision_number` STRING COMMENT 'Version number tracking revisions to this KPI target. Increments each time the target is modified during campaign execution.',
    `target_status` STRING COMMENT 'Current lifecycle status of the KPI target. Tracks whether the target is in planning, actively being measured, or has been completed or cancelled.. Valid values are `draft|active|paused|completed|cancelled|revised`',
    `target_unit` STRING COMMENT 'The unit of measure for the target_value. Defines how the target should be interpreted (absolute count, percentage, currency amount, or rating point).. Valid values are `count|percentage|currency|rating_point`',
    `target_value` DECIMAL(18,2) COMMENT 'The numeric target value for the KPI. Interpretation depends on kpi_type and target_unit (e.g., 1000000 impressions, 2.5% CTR, $50 CPA).',
    `created_by` STRING COMMENT 'The user or system that created this KPI target record. Supports audit trail and accountability.',
    CONSTRAINT pk_campaign_kpi_target PRIMARY KEY(`campaign_kpi_target_id`)
) COMMENT 'Defines the specific, measurable KPI targets set for a campaign, flight, or line item at the time of planning and as revised during execution. Captures KPI target ID, parent entity type (campaign/flight/line_item), parent entity reference, KPI type (impressions, clicks, CTR, conversions, CPA, CPM, CPC, ROAS, VTR, GRP, TRP, SOV, reach, frequency, NPS), target value, target unit, target period (total, daily, weekly, monthly), baseline value, stretch target value, measurement methodology, measurement source (Nielsen, Comscore, CM360, GA, custom), reporting cadence, is_primary_kpi flag, and effective date range. Enables structured KPI governance and performance benchmarking across all campaign types.';

CREATE OR REPLACE TABLE `advertising_ecm`.`campaign`.`campaign_brief` (
    `campaign_brief_id` BIGINT COMMENT 'Unique identifier for the campaign brief record. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client (advertiser) who commissioned this campaign brief.',
    `worker_id` BIGINT COMMENT 'Foreign key linking to talent.worker. Business justification: Campaign briefs are authored documents requiring clear ownership for version control, approval routing, and accountability in agency workflows. Agency_lead_name exists but is denormalized text; proper',
    `brand_profile_id` BIGINT COMMENT 'Reference to the specific brand that this campaign brief is promoting.',
    `campaign_id` BIGINT COMMENT 'Reference to the parent campaign that this brief initiates and governs.',
    `client_brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: Campaign briefs specify which client brand the campaign serves—critical for brand guidelines compliance, brand-level budget allocation, creative approval workflows, and ensuring brand strategy alignme',
    `competitive_intelligence_id` BIGINT COMMENT 'Foreign key linking to analytics.competitive_intelligence. Business justification: Strategic planning dependency: campaign briefs are informed by competitive intelligence studies (market positioning, competitor SOV, creative strategies). Linking brief to the specific competitive_int',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Campaign briefs are created under the scope of a Statement of Work (SOW). Currently sow_reference_number is stored as a string. Normalizing to sow_id FK enables joining to SOW budget, deliverables, mi',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Campaign briefs often specify client-mandated or preferred suppliers (measurement vendors, brand safety tools, verification partners). Required for ensuring compliance with client vendor requirements ',
    `agency_lead_email` STRING COMMENT 'Email address of the agency lead responsible for this campaign brief.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `agency_lead_name` STRING COMMENT 'Full name of the agency account lead or strategist responsible for this campaign brief.',
    `approved_by_client_flag` BOOLEAN COMMENT 'Indicates whether the client has formally approved this brief version (True) or not (False).',
    `brief_number` STRING COMMENT 'Externally-visible unique business identifier for the campaign brief, used in client communications and internal tracking.. Valid values are `^BRF-[0-9]{6,10}$`',
    `brief_status` STRING COMMENT 'Current lifecycle status of the campaign brief indicating its approval and usage state.. Valid values are `draft|in_review|approved|superseded|cancelled|archived`',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget envelope amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `budget_envelope_amount` DECIMAL(18,2) COMMENT 'Total budget allocation or spending cap approved for the campaign as specified in the brief.',
    `channel_preferences` STRING COMMENT 'Preferred or mandated media channels and platforms for campaign execution (e.g., digital, TV, OOH, social, CTV).',
    `client_approval_date` DATE COMMENT 'Date on which the client formally approved this campaign brief version.',
    `client_approver_name` STRING COMMENT 'Full name of the client representative who provided formal approval for this brief.',
    `competitive_context` STRING COMMENT 'Analysis of the competitive landscape, including key competitors, their messaging, and market positioning relevant to this campaign.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign brief record was first created in the system.',
    `creative_format_requirements` STRING COMMENT 'Specification of required creative formats and deliverables (e.g., video lengths, display ad sizes, social media formats).',
    `geographic_scope` STRING COMMENT 'Geographic markets or regions where the campaign will be executed (e.g., USA, EMEA, APAC, specific countries or cities).',
    `issued_date` DATE COMMENT 'Date on which the campaign brief was formally issued to the agency team for execution.',
    `key_message` STRING COMMENT 'Primary message or value proposition that the campaign must communicate to the target audience.',
    `language_requirements` STRING COMMENT 'Languages in which campaign creative and messaging must be produced and delivered.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign brief record was last updated or modified.',
    `mandatory_exclusions` STRING COMMENT 'List of prohibited elements, themes, imagery, or messaging that must not appear in campaign creative due to brand, legal, or ethical constraints.',
    `mandatory_inclusions` STRING COMMENT 'List of required elements, messages, disclaimers, logos, or legal copy that must appear in all campaign creative.',
    `regulatory_compliance_notes` STRING COMMENT 'Special regulatory, legal, or compliance considerations that must be observed in campaign execution (e.g., GDPR, CCPA, industry-specific advertising restrictions).',
    `revision_history_reference` STRING COMMENT 'Reference identifier or pointer to the detailed revision history log for this brief, tracking all changes across versions.',
    `success_criteria` STRING COMMENT 'Narrative description of the qualitative and quantitative metrics that will define campaign success (e.g., brand lift, engagement rate, conversion targets).',
    `target_audience_description` STRING COMMENT 'Comprehensive description of the intended audience for the campaign, including demographic, psychographic, and behavioral characteristics.',
    `timeline_end_date` DATE COMMENT 'Target date by which the campaign must be fully executed and delivered as specified in the brief.',
    `timeline_start_date` DATE COMMENT 'Earliest date by which campaign planning and creative development must commence as specified in the brief.',
    `title` STRING COMMENT 'Concise, descriptive title of the campaign brief that summarizes the campaign intent.',
    `tone_of_voice` STRING COMMENT 'Prescribed communication style and personality that creative assets must embody (e.g., professional, playful, authoritative, empathetic).',
    `version` STRING COMMENT 'Version number of the brief document, incremented with each revision (e.g., 1.0, 1.1, 2.0).. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_campaign_brief PRIMARY KEY(`campaign_brief_id`)
) COMMENT 'Structured creative and strategic brief document that initiates a campaign — the formal client-approved mandate that drives all downstream planning, creative development, and media buying. Captures brief ID, campaign reference, client reference, brand reference, brief title, brief version, brief status (draft, in-review, approved, superseded), campaign objective narrative, target audience description, key message, tone of voice, mandatory inclusions, mandatory exclusions, competitive context, budget envelope, timeline requirements, channel preferences, success criteria narrative, approved by client, client approval date, agency lead, brief issued date, and revision history reference. The SSOT for campaign intent — distinct from the campaign master record which captures execution parameters.';

CREATE OR REPLACE TABLE `advertising_ecm`.`campaign`.`approval` (
    `approval_id` BIGINT COMMENT 'Unique identifier for the campaign approval record. Primary key.',
    `worker_id` BIGINT COMMENT 'Identifier of the user assigned to review and decide on the approval request.',
    `approval_created_by_user_worker_id` BIGINT COMMENT 'Identifier of the system user who created this approval record.',
    `approval_escalated_to_user_worker_id` BIGINT COMMENT 'Identifier of the higher-authority user to whom the approval was escalated. Populated only when escalation_flag is True.',
    `approval_modified_by_user_worker_id` BIGINT COMMENT 'Identifier of the system user who last modified this approval record.',
    `approval_worker_id` BIGINT COMMENT 'Identifier of the user who initiated the approval request.',
    `campaign_brief_id` BIGINT COMMENT 'Foreign key linking to campaign.campaign_brief. Business justification: Campaign briefs require client approval before campaign execution (campaign_brief has approved_by_client_flag, client_approval_date, client_approver_name). approval.parent_entity_type can include camp',
    `campaign_id` BIGINT COMMENT 'The unique identifier of the parent entity (campaign, media plan, IO, etc.) that requires approval.',
    `flight_id` BIGINT COMMENT 'Foreign key linking to campaign.flight. Business justification: approval has parent_entity_type attribute indicating it can apply to various entities including flights. Currently only has campaign_id FK. Flights have flight_status and require approval workflows be',
    `line_item_id` BIGINT COMMENT 'Foreign key linking to campaign.line_item. Business justification: approval has parent_entity_type attribute indicating it can apply to various entities including line items. Line items have trafficking_status and delivery_status requiring approval workflows. Adding ',
    `trafficking_order_id` BIGINT COMMENT 'Foreign key linking to campaign.trafficking_order. Business justification: Trafficking orders require QA and approval workflows before going live (trafficking_order has qa_status, qa_completed_timestamp). approval.parent_entity_type can include trafficking orders. Adding tra',
    `amount_threshold` DECIMAL(18,2) COMMENT 'The monetary threshold (in campaign currency) that triggered this approval requirement. Used for budget change and IO execution approvals.',
    `approval_status` STRING COMMENT 'Current status of the approval request: pending (awaiting decision), approved (authorized to proceed), rejected (denied), escalated (sent to higher authority), or withdrawn (request cancelled).. Valid values are `pending|approved|rejected|escalated|withdrawn`',
    `approval_type` STRING COMMENT 'The category of approval being requested: campaign launch, budget change, creative approval, IO (Insertion Order) execution, media plan sign-off, or compliance review.. Valid values are `campaign_launch|budget_change|creative_approval|io_execution|media_plan_signoff|compliance_review`',
    `assigned_reviewer_name` STRING COMMENT 'Full name of the user assigned to review the approval request.',
    `authority_level` STRING COMMENT 'The organizational authority tier required for this approval (e.g., Manager, Director, VP, C-Level, Board).',
    `compliance_framework` STRING COMMENT 'The regulatory or industry compliance framework governing this approval (e.g., GDPR, CCPA, IAB Standards, FTC Guidelines, Brand Safety Standards). Populated primarily for compliance_review approval types.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this approval record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the approval amount threshold (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `decision_date` TIMESTAMP COMMENT 'The date and time when the reviewer made their approval or rejection decision.',
    `decision_notes` STRING COMMENT 'Free-text comments or rationale provided by the reviewer explaining their approval or rejection decision.',
    `document_reference` STRING COMMENT 'Reference identifier or URI to supporting documentation attached to the approval request (e.g., revised media plan, updated creative brief, budget justification memo).',
    `escalated_to_name` STRING COMMENT 'Full name of the higher-authority user to whom the approval was escalated.',
    `escalation_date` TIMESTAMP COMMENT 'The date and time when the approval request was escalated to a higher authority.',
    `escalation_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this approval request has been escalated to a higher authority for resolution.',
    `escalation_reason` STRING COMMENT 'Free-text explanation of why the approval was escalated (e.g., exceeds reviewer authority threshold, conflicting stakeholder input, regulatory concern).',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this approval record was last updated.',
    `notification_sent_date` TIMESTAMP COMMENT 'The date and time when the approval decision notification was sent.',
    `notification_sent_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether notification of the approval decision has been sent to relevant stakeholders.',
    `parent_entity_type` STRING COMMENT 'The type of entity that this approval is associated with (e.g., campaign, media plan, insertion order, creative asset, budget revision, compliance check).. Valid values are `campaign|media_plan|insertion_order|creative_asset|budget_revision|compliance_check`',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating the primary reason for rejection (e.g., budget_exceeded, creative_noncompliant, missing_documentation, brand_safety_concern). Populated only when approval_status is rejected.',
    `requested_by_name` STRING COMMENT 'Full name of the user who initiated the approval request.',
    `requested_date` TIMESTAMP COMMENT 'The date and time when the approval request was submitted.',
    `reviewer_role` STRING COMMENT 'The organizational role or title of the assigned reviewer (e.g., Account Director, Finance Manager, Compliance Officer, Creative Director).',
    `sequence_number` STRING COMMENT 'The sequential order of this approval step within a multi-stage approval workflow (e.g., 1 for first approval, 2 for second approval).',
    `sla_due_date` TIMESTAMP COMMENT 'The target date and time by which the approval decision must be completed per organizational SLA (Service Level Agreement) policies.',
    `sla_met_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether the approval decision was completed within the SLA (Service Level Agreement) timeframe.',
    `total_approval_stages` STRING COMMENT 'The total number of approval stages required for this parent entity to be fully authorized.',
    `withdrawal_date` TIMESTAMP COMMENT 'The date and time when the approval request was withdrawn.',
    `withdrawal_reason` STRING COMMENT 'Free-text explanation of why the approval request was withdrawn by the requester. Populated only when approval_status is withdrawn.',
    CONSTRAINT pk_approval PRIMARY KEY(`approval_id`)
) COMMENT 'Tracks the formal approval workflow events for campaigns, media plans, and IOs — capturing each approval request, reviewer assignment, decision, and timestamp. Captures approval ID, approval type (campaign launch, budget change, creative approval, IO execution, media plan sign-off, compliance review), parent entity type, parent entity reference, approval status (pending, approved, rejected, escalated, withdrawn), requested by, requested date, assigned reviewer, reviewer role, decision date, decision notes, rejection reason code, escalation flag, escalation reason, SLA due date, SLA met flag, and audit timestamps. Enables governance and accountability for campaign authorization workflows.';

CREATE OR REPLACE TABLE `advertising_ecm`.`campaign`.`optimization_event` (
    `optimization_event_id` BIGINT COMMENT 'Unique identifier for the optimization event. Primary key for the optimization event entity.',
    `ad_id` BIGINT COMMENT 'Foreign key linking to campaign.ad. Business justification: optimization_event currently tracks optimizations at campaign/flight/line_item level but not at ad level. Optimizations frequently target specific ads (pause underperforming creative, adjust ad weight',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Automated optimization events (bid adjustments, creative rotation, budget reallocation) must respect brand safety tier, viewability standards, and approved placement lists from brand profile. Prevents',
    `budget_allocation_id` BIGINT COMMENT 'Foreign key linking to campaign.budget_allocation. Business justification: Optimizations frequently adjust budget allocations (reallocate budget between flights, adjust spend caps, modify pacing). Adding budget_allocation_id enables tracking when optimizations specifically t',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign that was optimized. Links this optimization event to the parent campaign entity.',
    `flight_id` BIGINT COMMENT 'Reference to the specific flight within the campaign that was optimized. Links to the flight entity.',
    `incrementality_test_id` BIGINT COMMENT 'Reference to the experiment or A/B test that this optimization is part of, if applicable. Null for non-experimental optimizations. Links to the experiment entity.',
    `insight_finding_id` BIGINT COMMENT 'Foreign key linking to analytics.insight_finding. Business justification: Closed-loop optimization workflow: optimization_events are often triggered by specific analytical insights (e.g., audience segment X underperforming). Tracking which insight_finding prompted each op',
    `line_item_id` BIGINT COMMENT 'Reference to the specific line item that was optimized. Links to the line item entity if optimization was performed at line item granularity.',
    `optimization_rule_id` BIGINT COMMENT 'Reference to the predefined optimization rule that triggered this event, if applicable. Null for manual or ad-hoc automated optimizations. Links to the optimization rule entity.',
    `pacing_rule_id` BIGINT COMMENT 'Foreign key linking to campaign.pacing_rule. Business justification: Optimizations frequently adjust pacing rules (change daily spend cap, modify impression goals, enable/disable auto-optimization). Currently optimization_event has optimization_rule_id (BIGINT) which a',
    `worker_id` BIGINT COMMENT 'Reference to the user who performed the optimization action. Null if the optimization was performed by an automated system. Links to the user or employee entity.',
    `targeting_rule_id` BIGINT COMMENT 'Foreign key linking to campaign.targeting_rule. Business justification: Optimizations frequently adjust targeting rules (add/remove audience segments, change geo targeting, adjust device targeting). Adding targeting_rule_id enables tracking when optimizations specifically',
    `actual_impact` STRING COMMENT 'The measured impact of the optimization on campaign performance after sufficient time has passed for evaluation. Captures actual changes in KPIs (Key Performance Indicators) to enable optimization effectiveness analysis.',
    `affected_entity_count` STRING COMMENT 'The number of entities (placements, creatives, audience segments, etc.) affected by this optimization. Provides scale context for the optimization impact.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this optimization required approval before execution. True if approval workflow was required, False if the optimization could be executed without approval. Supports governance and compliance requirements.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the optimization was approved, if approval was required. Null if no approval was needed or if approval is still pending. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `client_visible_flag` BOOLEAN COMMENT 'Indicates whether this optimization event should be visible to the client in reporting and dashboards. True if the optimization is client-facing, False if it is internal-only for operational purposes.',
    `confidence_score` DECIMAL(18,2) COMMENT 'A numeric score (0.00 to 100.00) representing the confidence level in the optimization decision, typically generated by machine learning algorithms or statistical models. Higher scores indicate greater confidence in the expected positive impact.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this optimization event record was first created in the system. Represents the data capture time, which may differ from the optimization execution time. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `expected_impact` STRING COMMENT 'The anticipated impact of the optimization on campaign performance at the time the change was made. Describes expected improvements in KPIs (Key Performance Indicators) such as CTR (Click-Through Rate), CPA (Cost Per Acquisition), or ROAS (Return on Ad Spend).',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this optimization event record was last modified in the system. Updated whenever any attribute of the record changes. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `new_value` DECIMAL(18,2) COMMENT 'The value of the parameter after the optimization was applied. Stored as string to accommodate various data types (numeric, categorical, JSON).',
    `notes` STRING COMMENT 'Free-form text field for additional context, observations, or instructions related to the optimization event. Used by media traders and campaign managers to document rationale and insights.',
    `optimization_scope` STRING COMMENT 'The granularity level at which the optimization was applied. Indicates whether the change affected the entire campaign, a specific flight, a line item, a placement, or a creative asset.. Valid values are `campaign|flight|line_item|placement|creative`',
    `optimization_status` STRING COMMENT 'Current lifecycle status of the optimization event. Tracks whether the optimization is pending execution, successfully applied, failed to apply, rolled back, or expired due to time constraints.. Valid values are `pending|applied|failed|rolled_back|expired`',
    `optimization_timestamp` TIMESTAMP COMMENT 'The exact date and time when the optimization action was executed. Represents the business event time when the change took effect in the campaign execution system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `optimization_type` STRING COMMENT 'The type of optimization action performed. Categorizes the nature of the change made to the campaign execution. [ENUM-REF-CANDIDATE: bid_adjustment|budget_reallocation|audience_expansion|audience_exclusion|creative_rotation_change|pacing_adjustment|frequency_cap_change|placement_exclusion|channel_shift|daypart_shift — promote to reference product]. Valid values are `bid_adjustment|budget_reallocation|audience_expansion|audience_exclusion|creative_rotation_change|pacing_adjustment`',
    `performed_by_system` STRING COMMENT 'Name or identifier of the automated system that performed the optimization. Examples include DSP (Demand-Side Platform) names like The Trade Desk, Google Campaign Manager 360, or internal optimization engine identifiers. Null if performed manually by a user.',
    `previous_value` DECIMAL(18,2) COMMENT 'The value of the parameter before the optimization was applied. Stored as string to accommodate various data types (numeric, categorical, JSON).',
    `priority_level` STRING COMMENT 'The priority level assigned to this optimization event. Determines the urgency and order of execution when multiple optimizations are queued. Critical optimizations are executed immediately.. Valid values are `critical|high|medium|low`',
    `rollback_flag` BOOLEAN COMMENT 'Indicates whether this optimization was subsequently rolled back or reversed. True if the optimization was undone, False if it remains in effect. Enables tracking of optimization reversals for governance and learning.',
    `rollback_reason` STRING COMMENT 'Explanation of why the optimization was rolled back. Captures the business rationale for reversing the change, such as negative performance impact, client request, or strategic pivot.',
    `rollback_timestamp` TIMESTAMP COMMENT 'The date and time when the optimization was rolled back, if applicable. Null if the optimization has not been reversed. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `source_system` STRING COMMENT 'The name or identifier of the source system from which this optimization event was captured. Examples include The Trade Desk, Google Campaign Manager 360, Mediaocean Prisma, or internal optimization platforms.',
    `test_control_flag` BOOLEAN COMMENT 'Indicates whether this optimization is part of a controlled experiment or A/B test. True if the optimization is being tested against a control group, False for standard optimizations.',
    `trigger_reason` STRING COMMENT 'Detailed explanation of why the optimization was triggered. Captures the business rationale, performance threshold breach, or strategic decision that prompted the change.',
    `trigger_type` STRING COMMENT 'Indicates whether the optimization was triggered manually by a user, automatically by a system algorithm, or by a predefined rule-based condition.. Valid values are `manual|automated|rule_based`',
    `value_unit` STRING COMMENT 'The unit of measurement for the previous and new values. Examples include currency code (USD, EUR), percentage (%), CPM (Cost Per Mille), CPC (Cost Per Click), impressions, or dimensionless for categorical changes.',
    CONSTRAINT pk_optimization_event PRIMARY KEY(`optimization_event_id`)
) COMMENT 'Records discrete campaign optimization actions taken during active execution — whether manual (by a media trader or campaign manager) or automated (by DSP bid algorithms or rule-based systems). Captures optimization event ID, campaign reference, flight reference, line item reference, optimization type (bid adjustment, budget reallocation, audience expansion, audience exclusion, creative rotation change, pacing adjustment, frequency cap change, placement exclusion, channel shift, daypart shift), trigger type (manual, automated, rule-based), trigger reason, previous value, new value, value unit, expected impact, actual impact (post-optimization), performed by user, performed by system, optimization timestamp, and rollback flag. Provides a full audit trail of in-flight campaign changes for governance, client reporting, and performance attribution.';

CREATE OR REPLACE TABLE `advertising_ecm`.`campaign`.`creative_usage` (
    `creative_usage_id` BIGINT COMMENT 'Unique identifier for this creative usage record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to the campaign in which this creative asset is being used',
    `creative_asset_id` BIGINT COMMENT 'Foreign key linking to the creative asset being used in this campaign',
    `trafficking_order_id` BIGINT COMMENT 'External identifier from the ad server or trafficking system for this specific asset placement (e.g., DCM placement ID, Sizmek ad ID)',
    `channel` STRING COMMENT 'Media channel where this asset is deployed for this campaign: display, video, social, search, native, email, out-of-home',
    `click_count` BIGINT COMMENT 'Total number of clicks generated by this specific asset within this campaign. Performance metric specific to this campaign-asset pairing.',
    `conversion_count` BIGINT COMMENT 'Total number of conversions attributed to this asset within this campaign. Performance metric specific to this campaign-asset pairing.',
    `created_at` TIMESTAMP COMMENT 'Timestamp when this usage record was created in the system',
    `ctr` DECIMAL(18,2) COMMENT 'Click-through rate percentage for this asset in this campaign. Calculated as (clicks / impressions) * 100.',
    `impression_count` BIGINT COMMENT 'Total number of impressions delivered for this specific asset within this campaign. Performance metric specific to this campaign-asset pairing.',
    `platform` STRING COMMENT 'Specific platform or publisher where the asset is running (e.g., Facebook, Google Display Network, YouTube, Instagram, TikTok, Programmatic DSP)',
    `spend_amount` DECIMAL(18,2) COMMENT 'Total media spend allocated to this specific asset within this campaign. Enables asset-level budget tracking and ROI analysis.',
    `updated_at` TIMESTAMP COMMENT 'Timestamp when this usage record was last updated',
    `usage_end_date` DATE COMMENT 'Date when this creative asset stopped being used in this campaign. Nullable for ongoing usage. May differ from campaign end if assets are rotated out early.',
    `usage_start_date` DATE COMMENT 'Date when this creative asset began being used in this campaign. May differ from campaign start if assets are rotated or phased in.',
    `usage_status` STRING COMMENT 'Current status of this asset usage within the campaign: active (currently running), paused (temporarily stopped), completed (flight ended), removed (pulled from campaign)',
    `usage_type` STRING COMMENT 'Classification of how this asset is being used in the campaign context: primary (main creative), secondary (supporting), test (A/B testing variant), backup (fallback), seasonal (time-bound theme)',
    CONSTRAINT pk_creative_usage PRIMARY KEY(`creative_usage_id`)
) COMMENT 'This association product represents the usage event between campaign and creative_asset. It captures the deployment and performance of a specific creative asset within a specific campaign context. Each record links one campaign to one creative_asset with attributes that track how, when, and where the asset was used, along with performance metrics specific to that campaign-asset pairing.. Existence Justification: In advertising operations, campaigns routinely deploy multiple creative assets across different channels, platforms, and flight periods (e.g., a holiday campaign uses 15 video assets, 30 display banners, and 10 social creatives). Simultaneously, high-performing assets are reused across multiple campaigns - evergreen brand assets, seasonal creative libraries, and compliance-approved templates are deployed in dozens of campaigns over time. The business actively manages creative usage as an operational entity, tracking which assets run where, when they start/end, and their performance metrics per campaign-asset pairing.';

CREATE OR REPLACE TABLE `advertising_ecm`.`campaign`.`booking` (
    `booking_id` BIGINT COMMENT 'Unique identifier for this placement booking record. Primary key.',
    `line_item_id` BIGINT COMMENT 'Foreign key linking to the line item that is booking this placement inventory.',
    `media_placement_id` BIGINT COMMENT 'Foreign key linking to the placement position being reserved for this line item.',
    `worker_id` BIGINT COMMENT 'Reference to the user who created this placement booking.',
    `booked_clicks` BIGINT COMMENT 'The contracted number of clicks to be delivered for this specific line_item-placement combination.',
    `booked_impressions` BIGINT COMMENT 'The contracted number of impressions to be delivered for this specific line_item-placement combination. This is booking-specific because a line item may book different impression volumes across multiple placements.',
    `booking_code` STRING COMMENT 'External business identifier for this placement booking, used in ad server trafficking and billing reconciliation.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this placement booking record was created in the system.',
    `delivery_status` STRING COMMENT 'The current delivery performance status for this specific placement booking. Indicates whether this booking is meeting its delivery goals.',
    `end_date` DATE COMMENT 'The date when this placement booking stops serving. May differ from line item flight dates if placements are staggered.',
    `rate_amount` DECIMAL(18,2) COMMENT 'The negotiated unit rate for this specific placement booking. Rate can vary by placement even within the same line item based on placement quality, position, and negotiation.',
    `start_date` DATE COMMENT 'The date when this placement booking begins serving. May differ from line item flight dates if placements are staggered.',
    `trafficking_status` STRING COMMENT 'The operational status of creative trafficking and ad server setup for this specific placement booking. Tracks readiness at the booking level.',
    CONSTRAINT pk_booking PRIMARY KEY(`booking_id`)
) COMMENT 'This association product represents the inventory reservation contract between a line item and a placement. It captures the specific booking terms, delivery commitments, and performance tracking for each line_item-placement pair. Each record links one line item to one placement with attributes that exist only in the context of this specific inventory reservation — including booked volumes, negotiated rates, flight dates, and trafficking/delivery status.. Existence Justification: In advertising operations, line items routinely book inventory across multiple placements to achieve reach and frequency goals (e.g., a video line item books pre-roll on YouTube, in-stream on Hulu, and CTV inventory on Roku). Simultaneously, high-value placements serve multiple line items from different campaigns, managed through inventory allocation and yield optimization. Media buyers actively create, manage, and monitor these placement bookings as discrete operational units with booking-specific volumes, rates, dates, and delivery tracking.';

CREATE OR REPLACE TABLE `advertising_ecm`.`campaign`.`creative_assignment` (
    `creative_assignment_id` BIGINT COMMENT 'Unique identifier for this creative assignment record. Primary key.',
    `worker_id` BIGINT COMMENT 'Reference to the user who created this creative assignment. Establishes accountability for trafficking decisions.',
    `creative_asset_id` BIGINT COMMENT 'Foreign key linking to the creative asset assigned to this line item',
    `line_item_id` BIGINT COMMENT 'Foreign key linking to the line item that will serve this creative asset',
    `assignment_created_date` TIMESTAMP COMMENT 'Timestamp when this creative assignment was created in the system. Audit trail for trafficking workflow.',
    `click_count` BIGINT COMMENT 'The number of clicks generated by this specific creative asset on this specific line item. Performance metric tracked at the assignment level.',
    `conversion_count` BIGINT COMMENT 'The number of conversions attributed to this specific creative asset on this specific line item. Performance metric for conversion-based campaigns.',
    `ctr` DECIMAL(18,2) COMMENT 'Click-through rate for this creative-line item pairing, calculated as (clicks / impressions). Performance metric for creative effectiveness.',
    `end_date` DATE COMMENT 'The date when this creative asset stops serving on this line item. Supports flight-based creative strategies and seasonal messaging.',
    `impression_count` BIGINT COMMENT 'The number of impressions delivered for this specific creative asset on this specific line item. Performance metric tracked at the assignment level.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this assignment record. Supports change tracking and audit.',
    `priority_rank` STRING COMMENT 'The priority or sequence order of this creative within the line items rotation. Used when rotation is not purely weight-based but follows a priority waterfall.',
    `rotation_weight` DECIMAL(18,2) COMMENT 'The percentage or weight assigned to this creative asset within the line items creative rotation. Used for A/B testing and dynamic creative optimization. Sum of weights across all assignments for a line item typically equals 100.',
    `start_date` DATE COMMENT 'The date when this creative asset begins serving on this line item. Enables sequential messaging and time-based creative rotation strategies.',
    `trafficking_status` STRING COMMENT 'The operational status of this specific creative-to-line-item assignment in the ad serving platform. Indicates whether the creative has been successfully trafficked and is ready to serve.',
    `view_count` BIGINT COMMENT 'The number of video views or viewable impressions for this specific creative asset on this specific line item. Applicable to video and viewability-measured formats.',
    CONSTRAINT pk_creative_assignment PRIMARY KEY(`creative_assignment_id`)
) COMMENT 'This association product represents the assignment of creative assets to line items for media execution. It captures the operational relationship between what is being bought (line item) and what creative content is served (creative asset). Each record links one line item to one creative asset with attributes that govern rotation, scheduling, trafficking, and performance tracking for that specific pairing.. Existence Justification: In advertising operations, line items routinely serve multiple creative assets simultaneously through rotation strategies (A/B testing, dynamic creative optimization, sequential messaging). Each creative asset is reused across multiple line items spanning different campaigns, flights, and targeting strategies. The business actively manages creative assignments as operational records with rotation weights, scheduling windows, trafficking status, and performance metrics tracked per line-item-asset pairing.';

CREATE OR REPLACE TABLE `advertising_ecm`.`campaign`.`ad_placement_rotation` (
    `ad_placement_rotation_id` BIGINT COMMENT 'Unique identifier for this ad-placement rotation assignment. Primary key.',
    `ad_id` BIGINT COMMENT 'Foreign key linking to the ad unit being trafficked in this rotation assignment',
    `media_placement_id` BIGINT COMMENT 'Foreign key linking to the placement position where the ad is served',
    `click_count` BIGINT COMMENT 'Total number of clicks recorded for this ad in this specific placement. Performance metric tracked at the rotation level.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this ad-placement rotation assignment was created in the trafficking system.',
    `end_date` DATE COMMENT 'Date when this ad stops serving in this specific placement. Null indicates no end date for this rotation assignment.',
    `impression_count` BIGINT COMMENT 'Total number of impressions delivered for this ad in this specific placement. Performance metric tracked at the rotation level.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent update to this rotation assignment configuration.',
    `rotation_weight` STRING COMMENT 'Relative weight for ad rotation when multiple ads are eligible to serve in this placement. Used for A/B testing and creative optimization. Higher weight = higher probability of serving.',
    `start_date` DATE COMMENT 'Date when this ad becomes eligible to serve in this specific placement. Allows for daypart-specific or sequential creative strategies.',
    `trafficking_status` STRING COMMENT 'Operational status of this specific ad-placement rotation assignment. Indicates whether the rotation has been trafficked to the ad server and is actively serving.',
    `created_by` STRING COMMENT 'User identifier of the trafficking specialist who created this rotation assignment.',
    CONSTRAINT pk_ad_placement_rotation PRIMARY KEY(`ad_placement_rotation_id`)
) COMMENT 'This association product represents the operational assignment between an ad creative and a specific placement position where it is trafficked to serve. It captures the rotation configuration, delivery schedule, and performance metrics for each ad-placement pairing. Each record links one ad to one placement with attributes that exist only in the context of this trafficking relationship, including rotation weight, delivery window, and impression/click metrics.. Existence Justification: In advertising operations, a single ad creative is routinely trafficked to serve across multiple placement positions (e.g., homepage leaderboard, sidebar, mobile banner) to maximize reach and test performance across inventory. Conversely, a single placement position serves multiple different ads through rotation for A/B testing, sequential messaging campaigns, and daypart-specific creative strategies. Ad trafficking teams actively manage these rotation assignments, configuring weights, schedules, and tracking delivery metrics for each ad-placement pairing.';

CREATE OR REPLACE TABLE `advertising_ecm`.`campaign`.`campaign_spokesperson` (
    `campaign_spokesperson_id` BIGINT COMMENT 'Primary key for campaign_spokesperson',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to the campaign that this spokesperson is assigned to.',
    `brand_spokesperson_id` BIGINT COMMENT 'Unique identifier for this campaign-spokesperson assignment record. Primary key.',
    `appearance_count` STRING COMMENT 'Number of times this spokesperson appears or is featured in creative assets for this campaign. Identified in detection phase relationship data.',
    `approval_status` STRING COMMENT 'Current approval status of this specific spokesperson assignment to this campaign: pending (awaiting approval), approved (cleared for use), rejected (not approved), expired (approval period ended). Identified in detection phase relationship data.',
    `assignment_end_date` DATE COMMENT 'Date when this spokespersons engagement with this campaign ends.',
    `assignment_start_date` DATE COMMENT 'Date when this spokespersons engagement with this campaign begins.',
    `compensation_amount` DECIMAL(18,2) COMMENT 'Compensation amount paid to this spokesperson specifically for this campaign engagement. Identified in detection phase relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign-spokesperson assignment record was first created.',
    `media_formats` STRING COMMENT 'Comma-separated list of media formats where this spokesperson appears in this campaign (TV, digital, print, radio, social, OOH). Identified in detection phase relationship data.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign-spokesperson assignment record was last modified.',
    `role_in_campaign` STRING COMMENT 'The role this spokesperson plays in this specific campaign: primary (lead spokesperson), supporting (secondary role), featured (guest appearance), testimonial (customer testimonial role). Identified in detection phase relationship data.',
    `usage_rights_period` STRING COMMENT 'Time period for which the advertiser has rights to use this spokespersons likeness and content from this campaign (e.g., 12 months, perpetual, campaign duration only). Identified in detection phase relationship data.',
    CONSTRAINT pk_campaign_spokesperson PRIMARY KEY(`campaign_spokesperson_id`)
) COMMENT 'This association product represents the Assignment between campaign and spokesperson. It captures the operational assignment of brand spokespersons to specific advertising campaigns, including their role, media formats, appearance count, compensation, and usage rights. Each record links one campaign to one spokesperson with attributes that exist only in the context of this specific campaign-spokesperson engagement.. Existence Justification: In advertising operations, campaigns routinely engage multiple spokespersons across different channels, markets, and creative executions (e.g., a campaign may have a celebrity primary spokesperson for TV, an influencer for social media, and an executive for corporate messaging). Conversely, spokespersons—especially brand ambassadors and executives—participate in multiple campaigns over their contract period. Talent management and legal teams actively manage these assignments as operational records, tracking role, compensation, usage rights, and approval status for each campaign-spokesperson pairing.';

CREATE OR REPLACE TABLE `advertising_ecm`.`campaign`.`competitive_targeting` (
    `competitive_targeting_id` BIGINT COMMENT 'Unique identifier for this campaign-competitive brand targeting relationship. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to the campaign that is executing the competitive targeting strategy',
    `competitive_brand_id` BIGINT COMMENT 'Foreign key linking to the competitor brand being targeted by this campaign',
    `budget_allocated_vs_competitor` DECIMAL(18,2) COMMENT 'Portion of campaign budget specifically allocated to competitive tactics against this competitor brand',
    `competitive_response_type` STRING COMMENT 'The type of competitive strategy employed against this specific competitor brand in this campaign (e.g., conquest, defensive, comparative advertising, share steal, awareness parity)',
    `competitive_threat_level` STRING COMMENT 'Assessment of the competitive threat level this specific competitor brand poses in the context of this particular campaign (may differ from the general threat level in the competitive_brand master record)',
    `counter_strategy_notes` STRING COMMENT 'Free-text notes documenting the specific counter-strategy, tactics, messaging, and creative approach used to target this competitor brand within this campaign',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this competitive targeting relationship was first created in the system',
    `monitoring_start_date` DATE COMMENT 'The date when competitive monitoring and targeting for this specific competitor began within this campaign',
    `share_of_voice_target_vs_competitor` DECIMAL(18,2) COMMENT 'Target share of voice percentage relative to this specific competitor brand. Represents the desired ratio of campaign impressions to competitor impressions in the target market.',
    `targeting_status` STRING COMMENT 'Current status of the competitive targeting for this campaign-competitor pair',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this competitive targeting relationship was last modified',
    CONSTRAINT pk_competitive_targeting PRIMARY KEY(`competitive_targeting_id`)
) COMMENT 'This association product represents the competitive conquest strategy between a campaign and a competitive brand. It captures the specific tactics, share-of-voice targets, and monitoring parameters defined by media planners when a campaign explicitly targets a competitor brand. Each record links one campaign to one competitive brand with attributes that exist only in the context of this competitive targeting relationship.. Existence Justification: In advertising operations, campaigns routinely target multiple competitor brands simultaneously through conquest strategies, with each competitor requiring distinct tactics, SOV targets, and budget allocations. Conversely, each competitor brand is targeted by multiple campaigns over time as part of ongoing competitive intelligence and market positioning efforts. Media planners actively manage these competitive targeting relationships as operational entities with specific strategic parameters per campaign-competitor pair.';

CREATE OR REPLACE TABLE `advertising_ecm`.`campaign`.`optimization_rule` (
    `optimization_rule_id` BIGINT COMMENT 'Primary key for optimization_rule',
    `parent_optimization_rule_id` BIGINT COMMENT 'Self-referencing FK on optimization_rule (parent_optimization_rule_id)',
    `action_type` STRING COMMENT 'The type of action the rule will execute when its conditions are met (e.g., increase bid, decrease bid, pause campaign, resume campaign, adjust budget, rotate creative, exclude placement). [ENUM-REF-CANDIDATE: increase_bid|decrease_bid|pause_campaign|resume_campaign|adjust_budget|rotate_creative|exclude_placement|send_alert|change_targeting — promote to reference product]',
    `action_unit` STRING COMMENT 'The unit of measure for the action value (e.g., percentage, absolute currency amount, multiplier, count, impressions, clicks).',
    `action_value` DECIMAL(18,2) COMMENT 'The numeric value associated with the action (e.g., bid adjustment percentage, budget increase amount, frequency cap limit).',
    `applies_to_scope` STRING COMMENT 'The level of the campaign hierarchy to which this rule applies (e.g., campaign, ad group, ad, keyword, placement, creative).',
    `auto_apply` BOOLEAN COMMENT 'Indicates whether the rule automatically applies changes when triggered (true) or requires manual approval (false).',
    `channel_filter` STRING COMMENT 'Comma-separated list of advertising channels to which this rule applies (e.g., search, display, social, video, native). Empty means applies to all channels.',
    `condition_logic` STRING COMMENT 'The logical expression or criteria that must be met for the rule to trigger. May include thresholds, comparisons, and boolean operators.',
    `cooldown_period_hours` STRING COMMENT 'The minimum number of hours that must elapse between consecutive executions of the rule, preventing rapid successive changes.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the optimization rule record was first created in the system.',
    `days_of_week` STRING COMMENT 'Comma-separated list of days of the week when the rule is active (e.g., Monday, Tuesday, Wednesday). Empty means applies to all days.',
    `optimization_rule_description` STRING COMMENT 'Detailed business description of the optimization rule, including its purpose, logic, and intended impact on campaign performance.',
    `device_filter` STRING COMMENT 'Comma-separated list of device types to which this rule applies (e.g., desktop, mobile, tablet). Empty means applies to all devices.',
    `effective_end_date` DATE COMMENT 'The date when the optimization rule ceases to be active. Nullable for rules with no defined end date.',
    `effective_start_date` DATE COMMENT 'The date when the optimization rule becomes active and begins evaluating conditions.',
    `evaluation_window_hours` STRING COMMENT 'The time window in hours over which the rule evaluates performance data before triggering an action.',
    `execution_count` STRING COMMENT 'The total number of times the optimization rule has been executed since creation.',
    `execution_frequency` STRING COMMENT 'How often the rule is evaluated and potentially executed (e.g., real-time, hourly, daily, weekly, on-demand).',
    `geo_filter` STRING COMMENT 'Comma-separated list of geographic locations (countries, regions, cities) to which this rule applies. Empty means applies to all locations.',
    `last_executed_timestamp` TIMESTAMP COMMENT 'The date and time when the optimization rule was last executed and triggered an action. Nullable if never executed.',
    `max_executions_per_day` STRING COMMENT 'The maximum number of times the rule can be executed within a single day, used to prevent over-optimization or excessive changes.',
    `modified_by` STRING COMMENT 'The username or identifier of the user who last modified the optimization rule.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the optimization rule record was last modified.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or context about the optimization rule.',
    `notification_enabled` BOOLEAN COMMENT 'Indicates whether notifications should be sent when the rule is triggered and executed.',
    `notification_recipients` STRING COMMENT 'Comma-separated list of email addresses or user identifiers who should receive notifications when the rule executes.',
    `priority_level` STRING COMMENT 'Numeric priority level of the rule, used to determine execution order when multiple rules apply to the same campaign or ad group. Lower numbers indicate higher priority.',
    `rule_code` STRING COMMENT 'Externally-known unique code for the optimization rule, used for reference across systems and reporting.',
    `rule_name` STRING COMMENT 'Human-readable name of the optimization rule, describing its purpose or function.',
    `rule_status` STRING COMMENT 'Current lifecycle status of the optimization rule, indicating whether it is active, inactive, draft, archived, suspended, or pending approval.',
    `rule_type` STRING COMMENT 'Classification of the optimization rule by its functional category (e.g., budget pacing, bid adjustment, frequency capping, dayparting, geo-targeting, creative rotation).',
    `threshold_metric` STRING COMMENT 'The performance metric or key performance indicator (KPI) that the rule monitors (e.g., cost per acquisition, click-through rate, return on ad spend, impressions, conversions).',
    `threshold_operator` STRING COMMENT 'The comparison operator used to evaluate the threshold condition (e.g., greater than, less than, equal to, greater or equal, less or equal, not equal).',
    `threshold_value` DECIMAL(18,2) COMMENT 'The numeric threshold value that triggers the rule when the monitored metric crosses this boundary.',
    `time_of_day_end` STRING COMMENT 'The end time of day (HH:MM format, 24-hour) when the rule is active for dayparting rules. Nullable if not applicable.',
    `time_of_day_start` STRING COMMENT 'The start time of day (HH:MM format, 24-hour) when the rule is active for dayparting rules. Nullable if not applicable.',
    `version_number` STRING COMMENT 'The version number of the optimization rule, incremented with each modification to track rule evolution.',
    `created_by` STRING COMMENT 'The username or identifier of the user who created the optimization rule.',
    CONSTRAINT pk_optimization_rule PRIMARY KEY(`optimization_rule_id`)
) COMMENT 'Master reference table for optimization_rule. Referenced by optimization_rule_id.';

CREATE OR REPLACE TABLE `advertising_ecm`.`campaign`.`optimization_algorithm` (
    `optimization_algorithm_id` BIGINT COMMENT 'Primary key for optimization_algorithm',
    `replacement_algorithm_id` BIGINT COMMENT 'Reference to the successor algorithm that replaces this one, if deprecated.',
    `evolved_from_optimization_algorithm_id` BIGINT COMMENT 'Self-referencing FK on optimization_algorithm (evolved_from_optimization_algorithm_id)',
    `algorithm_category` STRING COMMENT 'Technical category describing the underlying approach of the algorithm (machine learning, rule-based, heuristic, or hybrid).',
    `algorithm_code` STRING COMMENT 'Unique business identifier code for the algorithm, used in system integrations and reporting.',
    `algorithm_name` STRING COMMENT 'Human-readable name of the optimization algorithm (e.g., Budget Pacing, Bid Optimization, Creative Rotation).',
    `algorithm_type` STRING COMMENT 'Classification of the optimization algorithm by its primary function within campaign execution.',
    `applicable_channels` STRING COMMENT 'Comma-separated list of advertising channels where this algorithm can be applied (e.g., display,video,social,search,audio).',
    `applicable_formats` STRING COMMENT 'Comma-separated list of creative formats supported by this algorithm (e.g., banner,video,native,rich_media).',
    `average_performance_lift_percent` DECIMAL(18,2) COMMENT 'Historical average performance improvement percentage achieved by this algorithm compared to baseline or control campaigns.',
    `confidence_threshold` DECIMAL(18,2) COMMENT 'Minimum confidence level required for the algorithm to make optimization decisions, expressed as a decimal (0.0 to 1.0).',
    `cost_per_use` DECIMAL(18,2) COMMENT 'Cost incurred per execution or application of the algorithm, if usage-based pricing applies.',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created the algorithm record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the algorithm record was first created in the system.',
    `deprecation_reason` STRING COMMENT 'Business justification for deprecating or retiring the algorithm, if status is deprecated or inactive.',
    `optimization_algorithm_description` STRING COMMENT 'Detailed business description of the algorithms purpose, methodology, and use cases within campaign optimization.',
    `documentation_url` STRING COMMENT 'Web address linking to detailed technical and business documentation for the algorithm.',
    `effective_end_date` DATE COMMENT 'Date when the algorithm was or will be retired from active use, null if currently active with no planned retirement.',
    `effective_start_date` DATE COMMENT 'Date when the algorithm became available for use in campaign optimization.',
    `is_proprietary` BOOLEAN COMMENT 'Indicates whether the algorithm is proprietary intellectual property developed in-house (true) or licensed from external vendor (false).',
    `learning_rate` DECIMAL(18,2) COMMENT 'Rate at which the algorithm adapts to new data and performance signals, typically between 0.0001 and 1.0.',
    `license_type` STRING COMMENT 'Type of licensing arrangement for the algorithm (perpetual, subscription, usage-based, open source, or proprietary).',
    `lookback_window_hours` STRING COMMENT 'Time window in hours that the algorithm considers when analyzing historical performance data for optimization decisions.',
    `minimum_budget_amount` DECIMAL(18,2) COMMENT 'Minimum campaign budget amount required for the algorithm to be applied, if applicable.',
    `minimum_data_points` STRING COMMENT 'Minimum number of data observations required before the algorithm begins making optimization decisions.',
    `model_version` STRING COMMENT 'Version identifier for the algorithm model, following semantic versioning (e.g., v1.0, v2.3.1).',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified the algorithm record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the algorithm record was last modified or updated.',
    `optimization_objective` STRING COMMENT 'Primary business goal the algorithm is designed to achieve (e.g., maximize clicks, minimize CPA, maximize ROAS).',
    `performance_benchmark_metric` STRING COMMENT 'Primary key performance indicator (KPI) used to measure and benchmark the algorithms effectiveness (e.g., CTR improvement %, CPA reduction %).',
    `requires_minimum_budget` BOOLEAN COMMENT 'Indicates whether the algorithm requires a minimum campaign budget threshold to function effectively.',
    `optimization_algorithm_status` STRING COMMENT 'Current lifecycle status of the optimization algorithm indicating its availability for campaign use.',
    `supports_cross_channel` BOOLEAN COMMENT 'Indicates whether the algorithm can optimize across multiple advertising channels (display, video, social, search).',
    `supports_programmatic_guaranteed` BOOLEAN COMMENT 'Indicates whether the algorithm is compatible with programmatic guaranteed deal types.',
    `supports_real_time_bidding` BOOLEAN COMMENT 'Indicates whether the algorithm can operate in real-time bidding environments with sub-second decision requirements.',
    `update_frequency_minutes` STRING COMMENT 'Frequency in minutes at which the algorithm recalculates and applies optimization adjustments.',
    `vendor_name` STRING COMMENT 'Name of the technology vendor or provider of the algorithm, if sourced externally.',
    CONSTRAINT pk_optimization_algorithm PRIMARY KEY(`optimization_algorithm_id`)
) COMMENT 'Master reference table for optimization_algorithm. Referenced by optimization_algorithm_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ADD CONSTRAINT `fk_campaign_flight_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ADD CONSTRAINT `fk_campaign_line_item_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ADD CONSTRAINT `fk_campaign_line_item_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ADD CONSTRAINT `fk_campaign_line_item_trafficking_order_id` FOREIGN KEY (`trafficking_order_id`) REFERENCES `advertising_ecm`.`campaign`.`trafficking_order`(`trafficking_order_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ADD CONSTRAINT `fk_campaign_ad_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ADD CONSTRAINT `fk_campaign_ad_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ADD CONSTRAINT `fk_campaign_ad_trafficking_order_id` FOREIGN KEY (`trafficking_order_id`) REFERENCES `advertising_ecm`.`campaign`.`trafficking_order`(`trafficking_order_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ADD CONSTRAINT `fk_campaign_targeting_rule_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ADD CONSTRAINT `fk_campaign_targeting_rule_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ADD CONSTRAINT `fk_campaign_targeting_rule_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ADD CONSTRAINT `fk_campaign_budget_allocation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ADD CONSTRAINT `fk_campaign_budget_allocation_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ADD CONSTRAINT `fk_campaign_budget_allocation_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ADD CONSTRAINT `fk_campaign_budget_allocation_pacing_rule_id` FOREIGN KEY (`pacing_rule_id`) REFERENCES `advertising_ecm`.`campaign`.`pacing_rule`(`pacing_rule_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ADD CONSTRAINT `fk_campaign_pacing_rule_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ADD CONSTRAINT `fk_campaign_pacing_rule_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ADD CONSTRAINT `fk_campaign_pacing_rule_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ADD CONSTRAINT `fk_campaign_pacing_rule_optimization_algorithm_id` FOREIGN KEY (`optimization_algorithm_id`) REFERENCES `advertising_ecm`.`campaign`.`optimization_algorithm`(`optimization_algorithm_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ADD CONSTRAINT `fk_campaign_trafficking_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ADD CONSTRAINT `fk_campaign_trafficking_order_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ADD CONSTRAINT `fk_campaign_trafficking_order_parent_trafficking_order_id` FOREIGN KEY (`parent_trafficking_order_id`) REFERENCES `advertising_ecm`.`campaign`.`trafficking_order`(`trafficking_order_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ADD CONSTRAINT `fk_campaign_status_history_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `advertising_ecm`.`campaign`.`approval`(`approval_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ADD CONSTRAINT `fk_campaign_status_history_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ADD CONSTRAINT `fk_campaign_status_history_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ADD CONSTRAINT `fk_campaign_status_history_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ADD CONSTRAINT `fk_campaign_status_history_trafficking_order_id` FOREIGN KEY (`trafficking_order_id`) REFERENCES `advertising_ecm`.`campaign`.`trafficking_order`(`trafficking_order_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ADD CONSTRAINT `fk_campaign_campaign_kpi_target_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ADD CONSTRAINT `fk_campaign_campaign_kpi_target_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ADD CONSTRAINT `fk_campaign_campaign_kpi_target_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ADD CONSTRAINT `fk_campaign_campaign_brief_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ADD CONSTRAINT `fk_campaign_approval_campaign_brief_id` FOREIGN KEY (`campaign_brief_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign_brief`(`campaign_brief_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ADD CONSTRAINT `fk_campaign_approval_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ADD CONSTRAINT `fk_campaign_approval_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ADD CONSTRAINT `fk_campaign_approval_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ADD CONSTRAINT `fk_campaign_approval_trafficking_order_id` FOREIGN KEY (`trafficking_order_id`) REFERENCES `advertising_ecm`.`campaign`.`trafficking_order`(`trafficking_order_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ADD CONSTRAINT `fk_campaign_optimization_event_ad_id` FOREIGN KEY (`ad_id`) REFERENCES `advertising_ecm`.`campaign`.`ad`(`ad_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ADD CONSTRAINT `fk_campaign_optimization_event_budget_allocation_id` FOREIGN KEY (`budget_allocation_id`) REFERENCES `advertising_ecm`.`campaign`.`budget_allocation`(`budget_allocation_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ADD CONSTRAINT `fk_campaign_optimization_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ADD CONSTRAINT `fk_campaign_optimization_event_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ADD CONSTRAINT `fk_campaign_optimization_event_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ADD CONSTRAINT `fk_campaign_optimization_event_optimization_rule_id` FOREIGN KEY (`optimization_rule_id`) REFERENCES `advertising_ecm`.`campaign`.`optimization_rule`(`optimization_rule_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ADD CONSTRAINT `fk_campaign_optimization_event_pacing_rule_id` FOREIGN KEY (`pacing_rule_id`) REFERENCES `advertising_ecm`.`campaign`.`pacing_rule`(`pacing_rule_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ADD CONSTRAINT `fk_campaign_optimization_event_targeting_rule_id` FOREIGN KEY (`targeting_rule_id`) REFERENCES `advertising_ecm`.`campaign`.`targeting_rule`(`targeting_rule_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`creative_usage` ADD CONSTRAINT `fk_campaign_creative_usage_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`creative_usage` ADD CONSTRAINT `fk_campaign_creative_usage_trafficking_order_id` FOREIGN KEY (`trafficking_order_id`) REFERENCES `advertising_ecm`.`campaign`.`trafficking_order`(`trafficking_order_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`booking` ADD CONSTRAINT `fk_campaign_booking_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` ADD CONSTRAINT `fk_campaign_creative_assignment_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`ad_placement_rotation` ADD CONSTRAINT `fk_campaign_ad_placement_rotation_ad_id` FOREIGN KEY (`ad_id`) REFERENCES `advertising_ecm`.`campaign`.`ad`(`ad_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_spokesperson` ADD CONSTRAINT `fk_campaign_campaign_spokesperson_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`competitive_targeting` ADD CONSTRAINT `fk_campaign_competitive_targeting_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_rule` ADD CONSTRAINT `fk_campaign_optimization_rule_parent_optimization_rule_id` FOREIGN KEY (`parent_optimization_rule_id`) REFERENCES `advertising_ecm`.`campaign`.`optimization_rule`(`optimization_rule_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_algorithm` ADD CONSTRAINT `fk_campaign_optimization_algorithm_replacement_algorithm_id` FOREIGN KEY (`replacement_algorithm_id`) REFERENCES `advertising_ecm`.`campaign`.`optimization_algorithm`(`optimization_algorithm_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_algorithm` ADD CONSTRAINT `fk_campaign_optimization_algorithm_evolved_from_optimization_algorithm_id` FOREIGN KEY (`evolved_from_optimization_algorithm_id`) REFERENCES `advertising_ecm`.`campaign`.`optimization_algorithm`(`optimization_algorithm_id`);

-- ========= TAGS =========
ALTER SCHEMA `advertising_ecm`.`campaign` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `advertising_ecm`.`campaign` SET TAGS ('dbx_domain' = 'campaign');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `client_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `positioning_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Positioning Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revision_requested');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `attribution_model` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `attribution_model` SET TAGS ('dbx_value_regex' = 'last_click|first_click|linear|time_decay|position_based|data_driven');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `brand_safety_level` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Level');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `brand_safety_level` SET TAGS ('dbx_value_regex' = 'standard|moderate|strict|custom');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `brief_reference` SET TAGS ('dbx_business_glossary_term' = 'Campaign Brief Reference');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Campaign Budget Amount');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Code');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|paused|completed|cancelled');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `campaign_tier` SET TAGS ('dbx_business_glossary_term' = 'Campaign Tier');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `campaign_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|strategic|tactical');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_value_regex' = 'brand_awareness|direct_response|performance|retention|seasonal|always_on');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `conversion_window_days` SET TAGS ('dbx_business_glossary_term' = 'Conversion Window Days');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `device_targeting` SET TAGS ('dbx_business_glossary_term' = 'Device Targeting');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign End Date');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `frequency_cap` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `frequency_cap_window` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Window');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `frequency_cap_window` SET TAGS ('dbx_value_regex' = 'hour|day|week|month|campaign');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `geo_targeting` SET TAGS ('dbx_business_glossary_term' = 'Geographic Targeting');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Go-Live Date');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `iab_category` SET TAGS ('dbx_business_glossary_term' = 'Interactive Advertising Bureau (IAB) Category');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Campaign Notes');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Campaign Objective');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `pacing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Pacing Strategy');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `pacing_strategy` SET TAGS ('dbx_value_regex' = 'even|asap|custom|dayparting');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `primary_kpi` SET TAGS ('dbx_business_glossary_term' = 'Primary Key Performance Indicator (KPI)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `secondary_kpis` SET TAGS ('dbx_business_glossary_term' = 'Secondary Key Performance Indicators (KPIs)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Start Date');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `target_audience_description` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Description');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `target_cpa` SET TAGS ('dbx_business_glossary_term' = 'Target Cost Per Acquisition (CPA)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `target_cpm` SET TAGS ('dbx_business_glossary_term' = 'Target Cost Per Mille (CPM)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `target_ctr` SET TAGS ('dbx_business_glossary_term' = 'Target Click-Through Rate (CTR)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `target_roas` SET TAGS ('dbx_business_glossary_term' = 'Target Return on Ad Spend (ROAS)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `viewability_standard` SET TAGS ('dbx_business_glossary_term' = 'Viewability Standard');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `viewability_standard` SET TAGS ('dbx_value_regex' = 'mrc|groupm|custom');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `flight_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `audience_segments` SET TAGS ('dbx_business_glossary_term' = 'Audience Segments');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `budget_allocated` SET TAGS ('dbx_business_glossary_term' = 'Flight Budget Allocated');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `channel_mix` SET TAGS ('dbx_business_glossary_term' = 'Channel Mix');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Flight Created Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `creative_rotation` SET TAGS ('dbx_business_glossary_term' = 'Creative Rotation Strategy');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `creative_rotation` SET TAGS ('dbx_value_regex' = 'even|weighted|optimized|sequential');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `daypart_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Daypart Restrictions');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `device_targeting` SET TAGS ('dbx_business_glossary_term' = 'Device Targeting');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `flight_code` SET TAGS ('dbx_business_glossary_term' = 'Flight Code');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `flight_name` SET TAGS ('dbx_business_glossary_term' = 'Flight Name');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `flight_status` SET TAGS ('dbx_business_glossary_term' = 'Flight Status');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `flight_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|active|paused|completed|cancelled');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `frequency_cap` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `frequency_cap_period` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Period');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `frequency_cap_period` SET TAGS ('dbx_value_regex' = 'hour|day|week|month|flight');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `geo_targeting` SET TAGS ('dbx_business_glossary_term' = 'Geographic Targeting');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Flight Modified By User');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Flight Modified Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Flight Notes');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Flight Objective');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `objective` SET TAGS ('dbx_value_regex' = 'awareness|consideration|conversion|retention|engagement|traffic');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `pacing_goal` SET TAGS ('dbx_business_glossary_term' = 'Pacing Goal');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `pacing_goal` SET TAGS ('dbx_value_regex' = 'impressions|clicks|conversions|reach|spend');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `pacing_type` SET TAGS ('dbx_business_glossary_term' = 'Pacing Type');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `pacing_type` SET TAGS ('dbx_value_regex' = 'even|front_loaded|back_loaded|custom');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Flight Priority');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `target_frequency` SET TAGS ('dbx_business_glossary_term' = 'Target Frequency');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `target_grp` SET TAGS ('dbx_business_glossary_term' = 'Target Gross Rating Points (GRP)');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `target_impressions` SET TAGS ('dbx_business_glossary_term' = 'Target Impressions');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `target_reach` SET TAGS ('dbx_business_glossary_term' = 'Target Reach');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `target_trp` SET TAGS ('dbx_business_glossary_term' = 'Target Rating Points (TRP)');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Flight Created By User');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` SET TAGS ('dbx_subdomain' = 'media_execution');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `contract_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `flight_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `programmatic_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Deal Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `trafficking_order_id` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `publisher_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Publisher Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `ad_format` SET TAGS ('dbx_business_glossary_term' = 'Ad Format');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `agency_commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Agency Commission Rate');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `agency_commission_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `booked_clicks` SET TAGS ('dbx_business_glossary_term' = 'Booked Clicks');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `booked_conversions` SET TAGS ('dbx_business_glossary_term' = 'Booked Conversions');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `booked_impressions` SET TAGS ('dbx_business_glossary_term' = 'Booked Impressions');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `booked_views` SET TAGS ('dbx_business_glossary_term' = 'Booked Views');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Tier');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_value_regex' = 'standard|moderate|strict|custom');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `creative_assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Creative Assignment Status');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `creative_assignment_status` SET TAGS ('dbx_value_regex' = 'not_assigned|partially_assigned|fully_assigned|approved|rejected');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Line Item End Date');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `frequency_cap_impressions` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Impressions');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `frequency_cap_period` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Period');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `frequency_cap_period` SET TAGS ('dbx_value_regex' = 'hour|day|week|month|lifetime');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `gross_cost` SET TAGS ('dbx_business_glossary_term' = 'Gross Cost');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `is_programmatic` SET TAGS ('dbx_business_glossary_term' = 'Is Programmatic Flag');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `line_item_code` SET TAGS ('dbx_business_glossary_term' = 'Line Item Code');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `line_item_name` SET TAGS ('dbx_business_glossary_term' = 'Line Item Name');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `net_cost` SET TAGS ('dbx_business_glossary_term' = 'Net Cost');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `net_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `pacing_status` SET TAGS ('dbx_business_glossary_term' = 'Pacing Status');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `pacing_status` SET TAGS ('dbx_value_regex' = 'on_track|ahead|behind|at_risk|completed');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `pacing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Pacing Strategy');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `pacing_strategy` SET TAGS ('dbx_value_regex' = 'even|asap|frontload|backload|custom');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `placement_type` SET TAGS ('dbx_business_glossary_term' = 'Placement Type');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Line Item Priority');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Amount');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Line Item Start Date');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `targeting_summary` SET TAGS ('dbx_business_glossary_term' = 'Targeting Summary');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `trafficking_status` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Status');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `viewability_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Viewability Target Percentage');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` SET TAGS ('dbx_subdomain' = 'media_execution');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `ad_id` SET TAGS ('dbx_business_glossary_term' = 'Ad ID');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset ID');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item ID');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `trafficking_order_id` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `ad_name` SET TAGS ('dbx_business_glossary_term' = 'Ad Name');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `ad_status` SET TAGS ('dbx_business_glossary_term' = 'Ad Status');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `ad_type` SET TAGS ('dbx_business_glossary_term' = 'Ad Type');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `brand_safety_verified` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Verified');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `ccpa_opt_out_honored` SET TAGS ('dbx_business_glossary_term' = 'CCPA (California Consumer Privacy Act) Opt-Out Honored');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `click_through_url` SET TAGS ('dbx_business_glossary_term' = 'Click-Through URL (CTR)');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Ad Format Dimensions');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `frequency_cap` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `frequency_cap_period` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Period');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `frequency_cap_period` SET TAGS ('dbx_value_regex' = 'hour|day|week|month|campaign');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `gdpr_consent_required` SET TAGS ('dbx_business_glossary_term' = 'GDPR (General Data Protection Regulation) Consent Required');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Go-Live Date');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `impression_tracker_url` SET TAGS ('dbx_business_glossary_term' = 'Impression Tracker URL');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `landing_page_url` SET TAGS ('dbx_business_glossary_term' = 'Landing Page URL');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Ad Notes');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Ad Priority');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `server_ad_code` SET TAGS ('dbx_business_glossary_term' = 'Ad Server Ad ID');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `ssl_compliant` SET TAGS ('dbx_business_glossary_term' = 'SSL (Secure Sockets Layer) Compliant');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `third_party_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Tracking Enabled');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `trafficking_status` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Status');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `trafficking_status` SET TAGS ('dbx_value_regex' = 'not_trafficked|trafficked|live|paused|completed');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `vast_tag_url` SET TAGS ('dbx_business_glossary_term' = 'VAST (Video Ad Serving Template) Tag URL');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `view_tracker_url` SET TAGS ('dbx_business_glossary_term' = 'View Tracker URL');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `vpaid_enabled` SET TAGS ('dbx_business_glossary_term' = 'VPAID (Video Player-Ad Interface Definition) Enabled');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `weight` SET TAGS ('dbx_business_glossary_term' = 'Ad Weight');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `targeting_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Targeting Rule ID');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment ID');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Entity ID');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `flight_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `positioning_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Positioning Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Tier');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_value_regex' = 'tag_certified|garm_standard|custom');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `browser_type` SET TAGS ('dbx_business_glossary_term' = 'Browser Type');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `ccpa_opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Opt-Out Flag');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `connection_type` SET TAGS ('dbx_business_glossary_term' = 'Connection Type');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `connection_type` SET TAGS ('dbx_value_regex' = 'wifi|cellular|ethernet|unknown');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'first_party|second_party|third_party|dmp|cdp');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `daypart_schedule` SET TAGS ('dbx_business_glossary_term' = 'Daypart Schedule');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|ctv|ott|wearable');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `fraud_prevention_threshold` SET TAGS ('dbx_business_glossary_term' = 'Fraud Prevention Threshold');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `frequency_cap_limit` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Limit');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `frequency_cap_unit` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Unit');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `frequency_cap_unit` SET TAGS ('dbx_value_regex' = 'hour|day|week|month|lifetime');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `frequency_cap_window` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Window');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `gdpr_consent_required` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Required');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `geo_level` SET TAGS ('dbx_business_glossary_term' = 'Geographic Level');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `geo_level` SET TAGS ('dbx_value_regex' = 'country|region|dma|city|postal_code');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `os_type` SET TAGS ('dbx_business_glossary_term' = 'Operating System (OS) Type');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `parent_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Parent Entity Type');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `parent_entity_type` SET TAGS ('dbx_value_regex' = 'campaign|flight|line_item');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Targeting Rule Priority');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `recency_window` SET TAGS ('dbx_business_glossary_term' = 'Recency Window');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Targeting Rule Name');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `targeting_dimension` SET TAGS ('dbx_business_glossary_term' = 'Targeting Dimension');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `targeting_operator` SET TAGS ('dbx_business_glossary_term' = 'Targeting Operator');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `targeting_operator` SET TAGS ('dbx_value_regex' = 'include|exclude');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `targeting_value` SET TAGS ('dbx_business_glossary_term' = 'Targeting Value');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `targeting_value_type` SET TAGS ('dbx_business_glossary_term' = 'Targeting Value Type');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `targeting_value_type` SET TAGS ('dbx_value_regex' = 'single|range|list|pattern');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `viewability_standard` SET TAGS ('dbx_business_glossary_term' = 'Viewability Standard');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `viewability_standard` SET TAGS ('dbx_value_regex' = 'mrc|iab|custom');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `budget_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation ID');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `budget_optimization_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Optimization Scenario Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `flight_id` SET TAGS ('dbx_business_glossary_term' = 'Flight ID');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item ID');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `pacing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Pacing Rule Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `actual_spend` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'percentage|fixed|dynamic|proportional|weighted');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `allocation_reference` SET TAGS ('dbx_business_glossary_term' = 'Allocation Reference Number');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'draft|active|paused|completed|cancelled');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `auto_optimization_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto-Optimization Enabled Flag');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `budget_period_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Type');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `budget_period_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|flight|campaign');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `budget_source` SET TAGS ('dbx_business_glossary_term' = 'Budget Source');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `budget_source` SET TAGS ('dbx_value_regex' = 'client_approved|agency_estimated|internal_forecast|revised_io');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `committed_spend` SET TAGS ('dbx_business_glossary_term' = 'Committed Spend Amount');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `daily_impression_goal` SET TAGS ('dbx_business_glossary_term' = 'Daily Impression Goal');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `daily_spend_cap` SET TAGS ('dbx_business_glossary_term' = 'Daily Spend Cap');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `optimization_algorithm_reference` SET TAGS ('dbx_business_glossary_term' = 'Optimization Algorithm Reference');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `over_delivery_action` SET TAGS ('dbx_business_glossary_term' = 'Over-Delivery Action');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `over_delivery_action` SET TAGS ('dbx_value_regex' = 'pause|throttle|alert|continue');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `over_delivery_tolerance_pct` SET TAGS ('dbx_business_glossary_term' = 'Over-Delivery Tolerance Percentage');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `pacing_alert_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Pacing Alert Threshold Percentage');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `pacing_check_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pacing Check Frequency');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `pacing_check_frequency` SET TAGS ('dbx_value_regex' = 'real_time|hourly|every_4_hours|daily|manual');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `pacing_type` SET TAGS ('dbx_business_glossary_term' = 'Pacing Type');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `pacing_type` SET TAGS ('dbx_value_regex' = 'even|accelerated|front_loaded|back_loaded|custom_curve|asap');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `planned_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Budget Amount');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|reconciled|discrepancy|approved');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `remaining_budget` SET TAGS ('dbx_business_glossary_term' = 'Remaining Budget Amount');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `revised_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Budget Amount');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `under_delivery_action` SET TAGS ('dbx_business_glossary_term' = 'Under-Delivery Action');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `under_delivery_action` SET TAGS ('dbx_value_regex' = 'boost|increase_bids|alert|no_action');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `under_delivery_tolerance_pct` SET TAGS ('dbx_business_glossary_term' = 'Under-Delivery Tolerance Percentage');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `weekly_impression_goal` SET TAGS ('dbx_business_glossary_term' = 'Weekly Impression Goal');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `weekly_spend_cap` SET TAGS ('dbx_business_glossary_term' = 'Weekly Spend Cap');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` SET TAGS ('dbx_subdomain' = 'media_execution');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `pacing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Pacing Rule Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `flight_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `optimization_algorithm_id` SET TAGS ('dbx_business_glossary_term' = 'Optimization Algorithm Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `auto_optimization_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto-Optimization Enabled Flag');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `custom_curve_definition` SET TAGS ('dbx_business_glossary_term' = 'Custom Curve Definition');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `daily_impression_goal` SET TAGS ('dbx_business_glossary_term' = 'Daily Impression Goal');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `daily_spend_cap` SET TAGS ('dbx_business_glossary_term' = 'Daily Spend Cap');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `dayparting_enabled` SET TAGS ('dbx_business_glossary_term' = 'Dayparting Enabled Flag');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `dayparting_schedule` SET TAGS ('dbx_business_glossary_term' = 'Dayparting Schedule');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Pacing Rule Notes');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `over_delivery_action` SET TAGS ('dbx_business_glossary_term' = 'Over-Delivery Action');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `over_delivery_action` SET TAGS ('dbx_value_regex' = 'pause|throttle|alert|continue');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `pacing_alert_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Pacing Alert Threshold Percentage (PCT)');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `pacing_check_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pacing Check Frequency');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `pacing_check_frequency` SET TAGS ('dbx_value_regex' = 'real_time|hourly|every_4_hours|daily|weekly');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `pacing_status` SET TAGS ('dbx_business_glossary_term' = 'Pacing Rule Status');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `pacing_status` SET TAGS ('dbx_value_regex' = 'active|paused|completed|suspended|draft');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `pacing_type` SET TAGS ('dbx_business_glossary_term' = 'Pacing Type');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `pacing_type` SET TAGS ('dbx_value_regex' = 'even|accelerated|front_loaded|back_loaded|custom_curve|asap');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `parent_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Parent Entity Type');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `parent_entity_type` SET TAGS ('dbx_value_regex' = 'campaign|flight|line_item|insertion_order|creative|placement');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Pacing Rule Name');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `under_delivery_action` SET TAGS ('dbx_business_glossary_term' = 'Under-Delivery Action');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `under_delivery_action` SET TAGS ('dbx_value_regex' = 'boost|alert|continue|reallocate');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `weekly_impression_goal` SET TAGS ('dbx_business_glossary_term' = 'Weekly Impression Goal');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `weekly_spend_cap` SET TAGS ('dbx_business_glossary_term' = 'Weekly Spend Cap');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` SET TAGS ('dbx_subdomain' = 'media_execution');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `trafficking_order_id` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Order Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `flight_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `parent_trafficking_order_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Trafficking Order Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By User Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `actual_live_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Live Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `ad_server_order_code` SET TAGS ('dbx_business_glossary_term' = 'Ad Server Order Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `ad_server_platform` SET TAGS ('dbx_business_glossary_term' = 'Ad Server Platform');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `ads_trafficked_count` SET TAGS ('dbx_business_glossary_term' = 'Ads Trafficked Count');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Go-Live Date');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `line_items_trafficked_count` SET TAGS ('dbx_business_glossary_term' = 'Line Items Trafficked Count');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `pixel_firing_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Pixel Firing Validation Status');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `pixel_firing_validation_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|passed|failed|warning');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `qa_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Completed Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `qa_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Status');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `qa_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|passed|failed|waived');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met Flag');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `trafficking_notes` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Notes');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `trafficking_order_number` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Order Number');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `trafficking_order_number` SET TAGS ('dbx_value_regex' = '^TO-[0-9]{8,12}$');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `trafficking_status` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Status');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `trafficking_type` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Type');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `trafficking_type` SET TAGS ('dbx_value_regex' = 'standard|programmatic|direct|sponsorship|house');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `vast_tag_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Video Ad Serving Template (VAST) Tag Validation Status');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `vast_tag_validation_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|passed|failed|warning');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status History ID');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Approval ID');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `flight_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `trafficking_order_id` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Changed By User ID');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `workflow_step_id` SET TAGS ('dbx_business_glossary_term' = 'Workflow Step ID');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `changed_by_system` SET TAGS ('dbx_business_glossary_term' = 'Changed By System');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `changed_by_user_name` SET TAGS ('dbx_business_glossary_term' = 'Changed By User Name');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `changed_by_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `changed_by_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `client_visible_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Visible Flag');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `compliance_review_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Completed Flag');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `compliance_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Required Flag');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `duration_in_previous_status_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration in Previous Status (Hours)');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Status Effective Date');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Campaign Status');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transition Notes');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Campaign Status');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `rollback_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollback Flag');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `rollback_reason` SET TAGS ('dbx_business_glossary_term' = 'Rollback Reason');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `rollback_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rollback Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `session_code` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `transition_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Transition Reason Code');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `transition_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Transition Reason Description');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `transition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `transition_type` SET TAGS ('dbx_business_glossary_term' = 'Transition Type');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `transition_type` SET TAGS ('dbx_value_regex' = 'manual|automated|system|scheduled|api');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `advertising_ecm`.`campaign`.`status_history` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `campaign_kpi_target_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Key Performance Indicator (KPI) Target Identifier');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `flight_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Identifier');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item Identifier');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `positioning_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Positioning Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `alert_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold Percentage');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `benchmark_source` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Source');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `benchmark_value` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Value');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `channel_scope` SET TAGS ('dbx_business_glossary_term' = 'Channel Scope');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `is_primary_kpi` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Key Performance Indicator (KPI) Flag');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `kpi_type` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Type');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `kpi_type` SET TAGS ('dbx_value_regex' = 'impressions|clicks|ctr|conversions|cpa|cpm');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `measurement_source` SET TAGS ('dbx_business_glossary_term' = 'Measurement Source System');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `measurement_source` SET TAGS ('dbx_value_regex' = 'nielsen|comscore|cm360|ga|trade_desk|custom');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `optimization_priority` SET TAGS ('dbx_business_glossary_term' = 'Optimization Priority');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `optimization_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `parent_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Parent Entity Type');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `parent_entity_type` SET TAGS ('dbx_value_regex' = 'campaign|flight|line_item');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `reporting_cadence` SET TAGS ('dbx_business_glossary_term' = 'Reporting Cadence');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `reporting_cadence` SET TAGS ('dbx_value_regex' = 'real_time|hourly|daily|weekly|monthly|end_of_campaign');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `stretch_target_value` SET TAGS ('dbx_business_glossary_term' = 'Stretch Target Value');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `target_audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Segment');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `target_period` SET TAGS ('dbx_business_glossary_term' = 'Target Period');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `target_period` SET TAGS ('dbx_value_regex' = 'total|daily|weekly|monthly|quarterly');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `target_revision_number` SET TAGS ('dbx_business_glossary_term' = 'Target Revision Number');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `target_status` SET TAGS ('dbx_business_glossary_term' = 'Target Status');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `target_status` SET TAGS ('dbx_value_regex' = 'draft|active|paused|completed|cancelled|revised');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `target_unit` SET TAGS ('dbx_business_glossary_term' = 'Target Unit of Measure');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `target_unit` SET TAGS ('dbx_value_regex' = 'count|percentage|currency|rating_point');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `campaign_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Brief ID');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Brief Author Worker Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `client_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `competitive_intelligence_id` SET TAGS ('dbx_business_glossary_term' = 'Competitive Intelligence Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `agency_lead_email` SET TAGS ('dbx_business_glossary_term' = 'Agency Lead Email');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `agency_lead_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `agency_lead_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `agency_lead_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `agency_lead_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Lead Name');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `agency_lead_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `agency_lead_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `approved_by_client_flag` SET TAGS ('dbx_business_glossary_term' = 'Approved by Client Flag');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `brief_number` SET TAGS ('dbx_business_glossary_term' = 'Brief Number');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `brief_number` SET TAGS ('dbx_value_regex' = '^BRF-[0-9]{6,10}$');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `brief_status` SET TAGS ('dbx_business_glossary_term' = 'Brief Status');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `brief_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|superseded|cancelled|archived');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `budget_envelope_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Envelope Amount');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `channel_preferences` SET TAGS ('dbx_business_glossary_term' = 'Channel Preferences');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `client_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Date');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `client_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Client Approver Name');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `client_approver_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `client_approver_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `competitive_context` SET TAGS ('dbx_business_glossary_term' = 'Competitive Context');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `creative_format_requirements` SET TAGS ('dbx_business_glossary_term' = 'Creative Format Requirements');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `issued_date` SET TAGS ('dbx_business_glossary_term' = 'Brief Issued Date');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `key_message` SET TAGS ('dbx_business_glossary_term' = 'Key Message');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `language_requirements` SET TAGS ('dbx_business_glossary_term' = 'Language Requirements');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `mandatory_exclusions` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Exclusions');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `mandatory_inclusions` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Inclusions');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Notes');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `revision_history_reference` SET TAGS ('dbx_business_glossary_term' = 'Revision History Reference');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `success_criteria` SET TAGS ('dbx_business_glossary_term' = 'Success Criteria');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `target_audience_description` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Description');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `timeline_end_date` SET TAGS ('dbx_business_glossary_term' = 'Timeline End Date');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `timeline_start_date` SET TAGS ('dbx_business_glossary_term' = 'Timeline Start Date');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Brief Title');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `tone_of_voice` SET TAGS ('dbx_business_glossary_term' = 'Tone of Voice');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Brief Version');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_brief` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Approval ID');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Reviewer User ID');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `approval_created_by_user_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `approval_escalated_to_user_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Escalated To User ID');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `approval_modified_by_user_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `approval_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By User ID');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `campaign_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Brief Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Entity ID');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `flight_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `trafficking_order_id` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `amount_threshold` SET TAGS ('dbx_business_glossary_term' = 'Approval Amount Threshold');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated|withdrawn');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `approval_type` SET TAGS ('dbx_business_glossary_term' = 'Approval Type');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `approval_type` SET TAGS ('dbx_value_regex' = 'campaign_launch|budget_change|creative_approval|io_execution|media_plan_signoff|compliance_review');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `assigned_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Reviewer Name');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `decision_notes` SET TAGS ('dbx_business_glossary_term' = 'Decision Notes');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Approval Document Reference');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `escalated_to_name` SET TAGS ('dbx_business_glossary_term' = 'Escalated To Name');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `parent_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Parent Entity Type');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `parent_entity_type` SET TAGS ('dbx_value_regex' = 'campaign|media_plan|insertion_order|creative_asset|budget_revision|compliance_check');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `requested_by_name` SET TAGS ('dbx_business_glossary_term' = 'Requested By Name');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `requested_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Date');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `reviewer_role` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Role');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Sequence Number');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `sla_due_date` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Due Date');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Met Flag');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `total_approval_stages` SET TAGS ('dbx_business_glossary_term' = 'Total Approval Stages');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `advertising_ecm`.`campaign`.`approval` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` SET TAGS ('dbx_subdomain' = 'performance_optimization');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `optimization_event_id` SET TAGS ('dbx_business_glossary_term' = 'Optimization Event ID');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `ad_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `budget_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `flight_id` SET TAGS ('dbx_business_glossary_term' = 'Flight ID');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `incrementality_test_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment ID');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `insight_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Insight Finding Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item ID');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `optimization_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Optimization Rule ID');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `pacing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Pacing Rule Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Performed By User ID');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `targeting_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Targeting Rule Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `actual_impact` SET TAGS ('dbx_business_glossary_term' = 'Actual Impact');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `affected_entity_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Entity Count');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `client_visible_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Visible Flag');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `expected_impact` SET TAGS ('dbx_business_glossary_term' = 'Expected Impact');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `new_value` SET TAGS ('dbx_business_glossary_term' = 'New Value');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Optimization Notes');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `optimization_scope` SET TAGS ('dbx_business_glossary_term' = 'Optimization Scope');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `optimization_scope` SET TAGS ('dbx_value_regex' = 'campaign|flight|line_item|placement|creative');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `optimization_status` SET TAGS ('dbx_business_glossary_term' = 'Optimization Status');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `optimization_status` SET TAGS ('dbx_value_regex' = 'pending|applied|failed|rolled_back|expired');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `optimization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Optimization Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `optimization_type` SET TAGS ('dbx_business_glossary_term' = 'Optimization Type');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `optimization_type` SET TAGS ('dbx_value_regex' = 'bid_adjustment|budget_reallocation|audience_expansion|audience_exclusion|creative_rotation_change|pacing_adjustment');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `performed_by_system` SET TAGS ('dbx_business_glossary_term' = 'Performed By System');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `previous_value` SET TAGS ('dbx_business_glossary_term' = 'Previous Value');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `rollback_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollback Flag');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `rollback_reason` SET TAGS ('dbx_business_glossary_term' = 'Rollback Reason');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `rollback_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rollback Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `test_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Test Control Flag');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `trigger_reason` SET TAGS ('dbx_business_glossary_term' = 'Trigger Reason');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `trigger_type` SET TAGS ('dbx_business_glossary_term' = 'Trigger Type');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `trigger_type` SET TAGS ('dbx_value_regex' = 'manual|automated|rule_based');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_event` ALTER COLUMN `value_unit` SET TAGS ('dbx_business_glossary_term' = 'Value Unit');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_usage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_usage` SET TAGS ('dbx_subdomain' = 'media_execution');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_usage` SET TAGS ('dbx_association_edges' = 'campaign.campaign,creative.creative_asset');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_usage` ALTER COLUMN `creative_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Usage ID');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_usage` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Usage - Campaign Id');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_usage` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Usage - Creative Asset Id');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_usage` ALTER COLUMN `trafficking_order_id` SET TAGS ('dbx_business_glossary_term' = 'Trafficking ID');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_usage` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_usage` ALTER COLUMN `click_count` SET TAGS ('dbx_business_glossary_term' = 'Click Count');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_usage` ALTER COLUMN `conversion_count` SET TAGS ('dbx_business_glossary_term' = 'Conversion Count');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_usage` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Created At');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_usage` ALTER COLUMN `ctr` SET TAGS ('dbx_business_glossary_term' = 'Click-Through Rate');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_usage` ALTER COLUMN `impression_count` SET TAGS ('dbx_business_glossary_term' = 'Impression Count');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_usage` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_usage` ALTER COLUMN `spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Spend Amount');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_usage` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Updated At');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_usage` ALTER COLUMN `usage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Usage End Date');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_usage` ALTER COLUMN `usage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Usage Start Date');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_usage` ALTER COLUMN `usage_status` SET TAGS ('dbx_business_glossary_term' = 'Usage Status');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_usage` ALTER COLUMN `usage_type` SET TAGS ('dbx_business_glossary_term' = 'Usage Type');
ALTER TABLE `advertising_ecm`.`campaign`.`booking` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`campaign`.`booking` SET TAGS ('dbx_subdomain' = 'media_execution');
ALTER TABLE `advertising_ecm`.`campaign`.`booking` SET TAGS ('dbx_association_edges' = 'campaign.line_item,media.placement');
ALTER TABLE `advertising_ecm`.`campaign`.`booking` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Identifier');
ALTER TABLE `advertising_ecm`.`campaign`.`booking` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Booking - Line Item Id');
ALTER TABLE `advertising_ecm`.`campaign`.`booking` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Booking - Placement Id');
ALTER TABLE `advertising_ecm`.`campaign`.`booking` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Creator');
ALTER TABLE `advertising_ecm`.`campaign`.`booking` ALTER COLUMN `worker_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`campaign`.`booking` ALTER COLUMN `worker_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`campaign`.`booking` ALTER COLUMN `booked_clicks` SET TAGS ('dbx_business_glossary_term' = 'Booked Clicks');
ALTER TABLE `advertising_ecm`.`campaign`.`booking` ALTER COLUMN `booked_impressions` SET TAGS ('dbx_business_glossary_term' = 'Booked Impressions');
ALTER TABLE `advertising_ecm`.`campaign`.`booking` ALTER COLUMN `booking_code` SET TAGS ('dbx_business_glossary_term' = 'Booking Code');
ALTER TABLE `advertising_ecm`.`campaign`.`booking` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Created Date');
ALTER TABLE `advertising_ecm`.`campaign`.`booking` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Delivery Status');
ALTER TABLE `advertising_ecm`.`campaign`.`booking` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Booking End Date');
ALTER TABLE `advertising_ecm`.`campaign`.`booking` ALTER COLUMN `rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Booking Rate');
ALTER TABLE `advertising_ecm`.`campaign`.`booking` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Start Date');
ALTER TABLE `advertising_ecm`.`campaign`.`booking` ALTER COLUMN `trafficking_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Trafficking Status');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` SET TAGS ('dbx_subdomain' = 'media_execution');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` SET TAGS ('dbx_association_edges' = 'campaign.line_item,creative.creative_asset');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` ALTER COLUMN `creative_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Assignment ID');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Created By');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Assignment - Creative Asset Id');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Assignment - Line Item Id');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` ALTER COLUMN `assignment_created_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Created Date');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` ALTER COLUMN `click_count` SET TAGS ('dbx_business_glossary_term' = 'Click Count');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` ALTER COLUMN `conversion_count` SET TAGS ('dbx_business_glossary_term' = 'Conversion Count');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` ALTER COLUMN `ctr` SET TAGS ('dbx_business_glossary_term' = 'Click-Through Rate');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` ALTER COLUMN `impression_count` SET TAGS ('dbx_business_glossary_term' = 'Impression Count');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` ALTER COLUMN `rotation_weight` SET TAGS ('dbx_business_glossary_term' = 'Rotation Weight');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` ALTER COLUMN `trafficking_status` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Status');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` ALTER COLUMN `view_count` SET TAGS ('dbx_business_glossary_term' = 'View Count');
ALTER TABLE `advertising_ecm`.`campaign`.`ad_placement_rotation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`campaign`.`ad_placement_rotation` SET TAGS ('dbx_subdomain' = 'media_execution');
ALTER TABLE `advertising_ecm`.`campaign`.`ad_placement_rotation` SET TAGS ('dbx_association_edges' = 'campaign.ad,media.placement');
ALTER TABLE `advertising_ecm`.`campaign`.`ad_placement_rotation` ALTER COLUMN `ad_placement_rotation_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Placement Rotation ID');
ALTER TABLE `advertising_ecm`.`campaign`.`ad_placement_rotation` ALTER COLUMN `ad_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Placement Rotation - Ad Id');
ALTER TABLE `advertising_ecm`.`campaign`.`ad_placement_rotation` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Placement Rotation - Placement Id');
ALTER TABLE `advertising_ecm`.`campaign`.`ad_placement_rotation` ALTER COLUMN `click_count` SET TAGS ('dbx_business_glossary_term' = 'Click Count');
ALTER TABLE `advertising_ecm`.`campaign`.`ad_placement_rotation` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `advertising_ecm`.`campaign`.`ad_placement_rotation` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Rotation End Date');
ALTER TABLE `advertising_ecm`.`campaign`.`ad_placement_rotation` ALTER COLUMN `impression_count` SET TAGS ('dbx_business_glossary_term' = 'Impression Count');
ALTER TABLE `advertising_ecm`.`campaign`.`ad_placement_rotation` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `advertising_ecm`.`campaign`.`ad_placement_rotation` ALTER COLUMN `rotation_weight` SET TAGS ('dbx_business_glossary_term' = 'Rotation Weight');
ALTER TABLE `advertising_ecm`.`campaign`.`ad_placement_rotation` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Rotation Start Date');
ALTER TABLE `advertising_ecm`.`campaign`.`ad_placement_rotation` ALTER COLUMN `trafficking_status` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Status');
ALTER TABLE `advertising_ecm`.`campaign`.`ad_placement_rotation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_spokesperson` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_spokesperson` SET TAGS ('dbx_subdomain' = 'media_execution');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_spokesperson` SET TAGS ('dbx_association_edges' = 'campaign.campaign,brand.spokesperson');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_spokesperson` ALTER COLUMN `campaign_spokesperson_id` SET TAGS ('dbx_business_glossary_term' = 'campaign_spokesperson Identifier');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_spokesperson` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Spokesperson - Campaign Id');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_spokesperson` ALTER COLUMN `brand_spokesperson_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Spokesperson Assignment ID');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_spokesperson` ALTER COLUMN `appearance_count` SET TAGS ('dbx_business_glossary_term' = 'Appearance Count');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_spokesperson` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Approval Status');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_spokesperson` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_spokesperson` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_spokesperson` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_spokesperson` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_spokesperson` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_spokesperson` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_spokesperson` ALTER COLUMN `media_formats` SET TAGS ('dbx_business_glossary_term' = 'Media Formats');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_spokesperson` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_spokesperson` ALTER COLUMN `role_in_campaign` SET TAGS ('dbx_business_glossary_term' = 'Spokesperson Role');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_spokesperson` ALTER COLUMN `usage_rights_period` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Period');
ALTER TABLE `advertising_ecm`.`campaign`.`competitive_targeting` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`campaign`.`competitive_targeting` SET TAGS ('dbx_subdomain' = 'media_execution');
ALTER TABLE `advertising_ecm`.`campaign`.`competitive_targeting` SET TAGS ('dbx_association_edges' = 'campaign.campaign,brand.competitive_brand');
ALTER TABLE `advertising_ecm`.`campaign`.`competitive_targeting` ALTER COLUMN `competitive_targeting_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Competitive Targeting ID');
ALTER TABLE `advertising_ecm`.`campaign`.`competitive_targeting` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Competitive Targeting - Campaign Id');
ALTER TABLE `advertising_ecm`.`campaign`.`competitive_targeting` ALTER COLUMN `competitive_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Competitive Targeting - Competitive Brand Id');
ALTER TABLE `advertising_ecm`.`campaign`.`competitive_targeting` ALTER COLUMN `budget_allocated_vs_competitor` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated vs Competitor');
ALTER TABLE `advertising_ecm`.`campaign`.`competitive_targeting` ALTER COLUMN `competitive_response_type` SET TAGS ('dbx_business_glossary_term' = 'Competitive Response Type');
ALTER TABLE `advertising_ecm`.`campaign`.`competitive_targeting` ALTER COLUMN `competitive_threat_level` SET TAGS ('dbx_business_glossary_term' = 'Competitive Threat Level');
ALTER TABLE `advertising_ecm`.`campaign`.`competitive_targeting` ALTER COLUMN `counter_strategy_notes` SET TAGS ('dbx_business_glossary_term' = 'Counter Strategy Notes');
ALTER TABLE `advertising_ecm`.`campaign`.`competitive_targeting` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`competitive_targeting` ALTER COLUMN `monitoring_start_date` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Start Date');
ALTER TABLE `advertising_ecm`.`campaign`.`competitive_targeting` ALTER COLUMN `share_of_voice_target_vs_competitor` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice Target vs Competitor');
ALTER TABLE `advertising_ecm`.`campaign`.`competitive_targeting` ALTER COLUMN `targeting_status` SET TAGS ('dbx_business_glossary_term' = 'Targeting Status');
ALTER TABLE `advertising_ecm`.`campaign`.`competitive_targeting` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_rule` SET TAGS ('dbx_subdomain' = 'performance_optimization');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_rule` ALTER COLUMN `optimization_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Optimization Rule Identifier');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_rule` ALTER COLUMN `parent_optimization_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_rule` ALTER COLUMN `notification_recipients` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_rule` ALTER COLUMN `notification_recipients` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_algorithm` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_algorithm` SET TAGS ('dbx_subdomain' = 'performance_optimization');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_algorithm` ALTER COLUMN `optimization_algorithm_id` SET TAGS ('dbx_business_glossary_term' = 'Optimization Algorithm Identifier');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_algorithm` ALTER COLUMN `evolved_from_optimization_algorithm_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`campaign`.`optimization_algorithm` ALTER COLUMN `cost_per_use` SET TAGS ('dbx_confidential' = 'true');
