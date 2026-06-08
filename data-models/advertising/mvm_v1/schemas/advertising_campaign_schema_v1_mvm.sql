-- Schema for Domain: campaign | Business: Advertising | Version: v1_mvm
-- Generated on: 2026-05-08 03:52:17

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `advertising_ecm`.`campaign` COMMENT 'Core operational domain governing the end-to-end advertising campaign lifecycle — from strategy and planning through trafficking, activation, and delivery. Serves as the SSOT for campaign identity, flight dates, objectives, KPIs, targeting parameters, budget allocation, pacing rules, and execution status across all channels and formats.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `advertising_ecm`.`campaign`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Unique identifier for the advertising campaign. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser or client who owns this campaign.',
    `agency_relationship_id` BIGINT COMMENT 'Foreign key linking to client.agency_relationship. Business justification: Campaigns are executed under a specific agency-client relationship governing commission rates, scope of services, and contractual terms. Campaign billing, agency commission calculation, and AOR scope ',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Campaigns execute under a Master Service Agreement. Direct FK enables compliance audits (which MSA governs this campaign?) and contract-level campaign reporting without traversing through insertion ',
    `attribution_model_id` BIGINT COMMENT 'Foreign key linking to performance.attribution_model. Business justification: Campaigns are configured with a specific attribution model that governs how conversions are credited. Campaign setup requires selecting an attribution model (last-touch, data-driven, etc.); the curren',
    `brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: Campaigns are executed for specific client brands—fundamental relationship for brand-level performance reporting, budget tracking, share-of-voice analysis, and brand portfolio management. Domain exper',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Campaigns are assigned to cost centers for internal P&L reporting and budget ownership. Advertising agencies and advertisers routinely map campaigns to cost centers to track departmental spend. Enable',
    `persona_id` BIGINT COMMENT 'Foreign key linking to audience.persona. Business justification: Campaign strategy and creative briefing are built around target personas. Advertising planners select a persona during campaign setup to guide messaging, channel selection, and creative development. A',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: A SOW authorizes campaign scope, media budget, and deliverables. Direct FK enables SOW-level budget utilization reporting and scope compliance checks — is this campaign executing within its authorize',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Campaigns often contract directly with suppliers (data providers, verification vendors, measurement platforms) for campaign-level services. Essential for vendor cost allocation, performance tracking, ',
    `approval_status` STRING COMMENT 'Current approval status of the campaign in the review workflow: pending, approved, rejected, or revision requested.. Valid values are `pending|approved|rejected|revision_requested`',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the campaign for activation.',
    `approved_date` DATE COMMENT 'Date when the campaign was officially approved for execution.',
    `brand_safety_level` STRING COMMENT 'Brand safety filtering level applied to the campaign: standard, moderate, strict, or custom. Determines content exclusions.. Valid values are `standard|moderate|strict|custom`',
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
    `campaign_id` BIGINT COMMENT 'Reference to the parent campaign under which this flight executes. Links this flight to its overarching campaign strategy.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Individual flights within a campaign can be funded by different cost centers (e.g., different business units or regions). Advertising agencies routinely assign flights to cost centers for sub-campaign',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: A flights authorized spend and delivery parameters are governed by a specific Media Insertion Order. Billing reconciliation, pacing oversight, and delivery reporting all require tracing which IO fund',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: Campaign flight launch and completion dates are contractual project milestones (often billing triggers). Linking flight to project_milestone enables integrated timeline management where campaign opera',
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
    `campaign_id` BIGINT COMMENT 'Reference to the parent campaign under which this line item executes. Enables rollup reporting and budget tracking at campaign level.',
    `contract_rate_card_id` BIGINT COMMENT 'Foreign key linking to contract.contract_rate_card. Business justification: Line items are priced per contracted rate cards. Direct FK enables rate compliance reporting — verifying line_item rate_amount matches the contracted rate card — and supports billing audits. Advertisi',
    `creative_brief_id` BIGINT COMMENT 'Foreign key linking to creative.creative_brief. Business justification: Media planners link line items to creative briefs to ensure each placements creative requirements (format, messaging, channel) are fulfilled. This traceability is essential for creative-to-media alig',
    `creative_deliverable_id` BIGINT COMMENT 'Foreign key linking to creative.creative_deliverable. Business justification: Line items require specific creative deliverables (banner sizes, video lengths) to be produced and trafficked. Linking line items to deliverables enables production-to-media readiness tracking — a nam',
    `flight_id` BIGINT COMMENT 'Reference to the parent campaign flight that contains this line item. Establishes the hierarchical relationship between flight and line item.',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: A line items booked spend is authorized by a Media Insertion Order. Finance reconciliation, billing, and delivery reporting require tracing each line item to its governing IO. The existing contract_i',
    `plan_line_id` BIGINT COMMENT 'Foreign key linking to media.plan_line. Business justification: A line item is the execution-layer realization of a media plan line. Plan-vs-actual delivery reporting — a core media accountability process — requires linking each executed line item back to the plan',
    `programmatic_deal_id` BIGINT COMMENT 'The unique identifier for a programmatic deal (PMP, preferred deal, or programmatic guaranteed) associated with this line item. Nullable for open exchange buys.',
    `spec_id` BIGINT COMMENT 'Foreign key linking to creative.spec. Business justification: Line items define placement requirements (ad format, dimensions, IAB unit) that must match a creative spec. Trafficking teams validate assigned creatives against the line items spec before go-live. T',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Line items frequently use suppliers beyond publishers (ad verification, measurement partners, data providers). Critical for line-item-level vendor reconciliation, cost attribution, and compliance trac',
    `trafficking_order_id` BIGINT COMMENT 'Foreign key linking to campaign.trafficking_order. Business justification: Line items are trafficked to ad servers via trafficking orders. Currently no FK exists to track which trafficking order activated a specific line item. This is essential for operational tracking and a',
    `publisher_id` BIGINT COMMENT 'Reference to the media vendor or publisher delivering this line item inventory. Links to vendor master for billing and performance tracking.',
    `work_package_id` BIGINT COMMENT 'Foreign key linking to project.work_package. Business justification: In advertising agencies, each line items production and trafficking execution is managed as a work package. Linking enables project managers to track effort, cost, and status per media buy — essentia',
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
    `asset_id` BIGINT COMMENT 'Reference to the creative asset (image, video, HTML5, audio) used in this ad execution.',
    `campaign_id` BIGINT COMMENT 'Reference to the parent campaign to which this ad belongs.',
    `creative_assignment_id` BIGINT COMMENT 'Foreign key linking to campaign.creative_assignment. Business justification: An ad unit is the trafficked execution of a creative assignment — it represents the specific creative asset assigned to a line item being served. Adding creative_assignment_id to ad creates a direct, ',
    `flight_id` BIGINT COMMENT 'Foreign key linking to campaign.flight. Business justification: An ad is executed within a flights time window and targeting context. While flight can be derived via ad → line_item → flight, a direct flight_id on ad is operationally valuable for ad-server pacing,',
    `line_item_id` BIGINT COMMENT 'Reference to the parent campaign line item under which this ad is trafficked.',
    `media_placement_id` BIGINT COMMENT 'Foreign key linking to media.media_placement. Business justification: An ad runs within a specific contracted media placement (inventory slot on a publisher property). Delivery verification, viewability measurement, and brand safety compliance reporting all require know',
    `spec_id` BIGINT COMMENT 'Foreign key linking to creative.spec. Business justification: Each ad unit must conform to a technical spec (file format, dimensions, duration, VAST requirements) for its placement. Ad servers validate ads against specs before trafficking go-live. This link enab',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Individual ads may use specific suppliers for dynamic creative optimization, ad serving, or verification services. Required for ad-level vendor cost tracking, performance attribution, and troubleshoot',
    `tech_partner_id` BIGINT COMMENT 'Foreign key linking to vendor.tech_partner. Business justification: Ad serving and third-party tracking assignment: each ad is delivered via a specific tech partner (ad server/verification vendor). ad carries vast_tag_url, vpaid_enabled, third_party_tracking_enabled, ',
    `trafficking_instruction_id` BIGINT COMMENT 'Foreign key linking to media.trafficking_instruction. Business justification: Each ad unit is governed by a trafficking instruction specifying ad-server tags, pixels, VAST URLs, and targeting directives. Ad ops teams must link ads to their trafficking instructions for ad-server',
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
    `campaign_id` BIGINT COMMENT 'The identifier of the parent entity (campaign, flight, or line_item) to which this targeting rule applies.',
    `flight_id` BIGINT COMMENT 'Foreign key linking to campaign.flight. Business justification: targeting_rule has parent_entity_type attribute indicating it can apply to campaign, flight, or line_item. Currently only has campaign_id FK. Adding flight_id (nullable) to support flight-level target',
    `line_item_id` BIGINT COMMENT 'Foreign key linking to campaign.line_item. Business justification: targeting_rule has parent_entity_type attribute indicating it can apply to campaign, flight, or line_item. Currently only has campaign_id FK. Adding line_item_id (nullable) to support line_item-level ',
    `segment_id` BIGINT COMMENT 'Reference to the audience segment when targeting dimension is audience_segment, retargeting, or lookalike.',
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
    `campaign_id` BIGINT COMMENT 'Reference to the parent campaign for which budget is being allocated.',
    `contract_insertion_order_id` BIGINT COMMENT 'Foreign key linking to contract.contract_insertion_order. Business justification: Budget allocations must reconcile against IO-authorized spend (total_authorized_spend). Direct FK enables IO-level budget utilization reports — comparing allocated/actual spend against IO commitments ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Campaign budget allocations must be charged to specific cost centers for internal accounting. In advertising agencies, each budget allocation (by channel, flight, or line item) maps to a cost center f',
    `flight_id` BIGINT COMMENT 'Reference to the parent flight within the campaign for which budget is allocated.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Budget allocations in advertising are posted to GL accounts (e.g., media spend, production costs, agency fees) for financial reporting and audit compliance. A gl_account_id FK enables proper GL postin',
    `line_item_id` BIGINT COMMENT 'Reference to the specific line item receiving this budget allocation.',
    `pacing_rule_id` BIGINT COMMENT 'Foreign key linking to campaign.pacing_rule. Business justification: budget_allocation currently has pacing_rule_name (STRING) which is a denormalized reference. Should normalize to FK relationship with pacing_rule.pacing_rule_id. This enables joining to get full pacin',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to project.project_budget. Business justification: Finance reconciliation in advertising agencies requires matching campaign media spend allocations against project budgets (which include labor, production, and media). This link enables the CFO-level ',
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
    `contract_insertion_order_id` BIGINT COMMENT 'Foreign key linking to contract.contract_insertion_order. Business justification: Trafficking orders execute the media buys authorized by insertion orders. Direct FK enables IO-level trafficking status reporting and billing reconciliation — which IO does this trafficking order ful',
    `flight_id` BIGINT COMMENT 'Reference to the parent flight or media schedule within the campaign that this trafficking order activates.',
    `parent_trafficking_order_id` BIGINT COMMENT 'Reference to the original trafficking order if this is a revision or amendment, enabling tracking of the full order history and change lineage.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Trafficking orders involve third-party ad servers or trafficking platforms (suppliers). Essential for tracking which ad server/platform was used, critical for troubleshooting, billing, and vendor perf',
    `task_id` BIGINT COMMENT 'Foreign key linking to project.task. Business justification: Trafficking orders are executed as project tasks with SLA commitments. Linking enables project managers to track trafficking task completion against campaign go-live dates, measure SLA adherence, and ',
    `tech_partner_id` BIGINT COMMENT 'Foreign key linking to vendor.tech_partner. Business justification: Trafficking orders are submitted to a specific ad server platform (tech partner). trafficking_order.ad_server_platform is a denormalized string identifying the tech partner; replacing it with a proper',
    `trafficking_instruction_id` BIGINT COMMENT 'Foreign key linking to media.trafficking_instruction. Business justification: A trafficking order (internal workflow) generates trafficking instructions (ad-server directives). Linking them enables end-to-end trafficking workflow tracking: from internal order creation through a',
    `actual_live_timestamp` TIMESTAMP COMMENT 'Actual date and time when the trafficking order went live and ads began serving, as confirmed by the ad server platform.',
    `ad_server_order_code` STRING COMMENT 'External order or campaign identifier assigned by the ad server platform (e.g., CM360 order ID, Trade Desk campaign ID) for cross-system reconciliation.',
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

CREATE OR REPLACE TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` (
    `campaign_kpi_target_id` BIGINT COMMENT 'Unique identifier for the campaign KPI target record. Primary key for this entity.',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign when parent_entity_type is campaign. Null for flight or line_item parent types.',
    `flight_id` BIGINT COMMENT 'Reference to the flight when parent_entity_type is flight. Null for campaign or line_item parent types.',
    `line_item_id` BIGINT COMMENT 'Reference to the line item when parent_entity_type is line_item. Null for campaign or flight parent types.',
    `sla_id` BIGINT COMMENT 'Foreign key linking to contract.sla. Business justification: Campaign KPI targets must be traceable to contractual SLA commitments (e.g., viewability thresholds, delivery rates). Direct FK enables SLA compliance reporting — did campaign performance meet contra',
    `segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: KPI targets are frequently set for specific audience segments (e.g., achieve 8% conversion rate among in-market auto intenders segment). Performance reporting and optimization decisions require meas',
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

CREATE OR REPLACE TABLE `advertising_ecm`.`campaign`.`creative_assignment` (
    `creative_assignment_id` BIGINT COMMENT 'Unique identifier for this creative assignment record. Primary key.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to the creative asset assigned to this line item',
    `deliverable_tracker_id` BIGINT COMMENT 'Foreign key linking to project.deliverable_tracker. Business justification: A creative assignment (assigning a produced asset to a line item) is the downstream outcome of a creative production deliverable. Linking enables agencies to trace from project deliverable through to ',
    `line_item_id` BIGINT COMMENT 'Foreign key linking to the line item that will serve this creative asset',
    `media_placement_id` BIGINT COMMENT 'Foreign key linking to media.media_placement. Business justification: A creative assignment maps a creative asset to a specific media placement for delivery. Placement-level creative performance reporting and brand safety verification per placement require this direct l',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ADD CONSTRAINT `fk_campaign_flight_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ADD CONSTRAINT `fk_campaign_line_item_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ADD CONSTRAINT `fk_campaign_line_item_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ADD CONSTRAINT `fk_campaign_line_item_trafficking_order_id` FOREIGN KEY (`trafficking_order_id`) REFERENCES `advertising_ecm`.`campaign`.`trafficking_order`(`trafficking_order_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ADD CONSTRAINT `fk_campaign_ad_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ADD CONSTRAINT `fk_campaign_ad_creative_assignment_id` FOREIGN KEY (`creative_assignment_id`) REFERENCES `advertising_ecm`.`campaign`.`creative_assignment`(`creative_assignment_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ADD CONSTRAINT `fk_campaign_ad_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
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
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ADD CONSTRAINT `fk_campaign_trafficking_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ADD CONSTRAINT `fk_campaign_trafficking_order_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ADD CONSTRAINT `fk_campaign_trafficking_order_parent_trafficking_order_id` FOREIGN KEY (`parent_trafficking_order_id`) REFERENCES `advertising_ecm`.`campaign`.`trafficking_order`(`trafficking_order_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ADD CONSTRAINT `fk_campaign_campaign_kpi_target_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `advertising_ecm`.`campaign`.`campaign`(`campaign_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ADD CONSTRAINT `fk_campaign_campaign_kpi_target_flight_id` FOREIGN KEY (`flight_id`) REFERENCES `advertising_ecm`.`campaign`.`flight`(`flight_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ADD CONSTRAINT `fk_campaign_campaign_kpi_target_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` ADD CONSTRAINT `fk_campaign_creative_assignment_line_item_id` FOREIGN KEY (`line_item_id`) REFERENCES `advertising_ecm`.`campaign`.`line_item`(`line_item_id`);

-- ========= TAGS =========
ALTER SCHEMA `advertising_ecm`.`campaign` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `advertising_ecm`.`campaign` SET TAGS ('dbx_domain' = 'campaign');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `agency_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Relationship Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `attribution_model_id` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `persona_id` SET TAGS ('dbx_business_glossary_term' = 'Persona Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revision_requested');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `brand_safety_level` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Level');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign` ALTER COLUMN `brand_safety_level` SET TAGS ('dbx_value_regex' = 'standard|moderate|strict|custom');
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
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Media Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`flight` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `contract_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate Card Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `creative_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Brief Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `creative_deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Deliverable Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `flight_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Media Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `plan_line_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `programmatic_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Deal Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Spec Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `trafficking_order_id` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `publisher_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Publisher Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`line_item` ALTER COLUMN `work_package_id` SET TAGS ('dbx_business_glossary_term' = 'Work Package Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset ID');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `creative_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Assignment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `flight_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item ID');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Media Placement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Spec Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `tech_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Tech Partner Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`ad` ALTER COLUMN `trafficking_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Instruction Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Entity ID');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `flight_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`targeting_rule` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment ID');
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
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `contract_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `flight_id` SET TAGS ('dbx_business_glossary_term' = 'Flight ID');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item ID');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `pacing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Pacing Rule Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`budget_allocation` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `pacing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Pacing Rule Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `flight_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`pacing_rule` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item Identifier (ID)');
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
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `contract_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `flight_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `parent_trafficking_order_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Trafficking Order Identifier (ID)');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `task_id` SET TAGS ('dbx_business_glossary_term' = 'Task Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `tech_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Tech Partner Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `trafficking_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Instruction Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `actual_live_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Live Timestamp');
ALTER TABLE `advertising_ecm`.`campaign`.`trafficking_order` ALTER COLUMN `ad_server_order_code` SET TAGS ('dbx_business_glossary_term' = 'Ad Server Order Identifier (ID)');
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
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `campaign_kpi_target_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Key Performance Indicator (KPI) Target Identifier');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `flight_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Identifier');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item Identifier');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`campaign_kpi_target` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Segment Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` SET TAGS ('dbx_subdomain' = 'media_execution');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` ALTER COLUMN `creative_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Assignment ID');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Assignment - Creative Asset Id');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` ALTER COLUMN `deliverable_tracker_id` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Tracker Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Assignment - Line Item Id');
ALTER TABLE `advertising_ecm`.`campaign`.`creative_assignment` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Media Placement Id (Foreign Key)');
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
