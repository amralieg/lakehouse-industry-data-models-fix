-- Schema for Domain: media | Business: Advertising | Version: v1_ecm
-- Generated on: 2026-05-08 02:28:06

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `advertising_ecm`.`media` COMMENT 'Governs all media and channel operations — including channel taxonomy, publisher properties, placements, media planning, buying, trafficking, programmatic deals, rate cards, reconciliation, and delivery scheduling across all paid media channels (digital, broadcast, OOH, CTV/OTT, print).';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`media_insertion_order` (
    `media_insertion_order_id` BIGINT COMMENT 'Unique surrogate identifier for the Insertion Order record in the lakehouse Silver layer. Primary key. Entity role: TRANSACTION_HEADER — this is a discrete contractual business event with a clear lifecycle (draft → executed → cancelled), carrying authorized spend, flight dates, and vendor/advertiser party references.',
    `ad_channel_id` BIGINT COMMENT 'Foreign key linking to media.ad_channel. Business justification: media_insertion_order currently has channel_type as a STRING attribute. IOs are issued to media vendors for specific advertising channels (e.g., IO for Display advertising, IO for CTV). This FK normal',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser (client brand) on whose behalf this IO is issued. Links to the client.advertiser master record. Satisfies TRANSACTION_HEADER PARTY_REFERENCE category.',
    `agreement_id` BIGINT COMMENT 'Reference to the overarching master service agreement or framework contract under which this IO is issued. Supports contract hierarchy and legal compliance tracking.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: IOs execute media buys for specific brands. IO approval workflow validates against brand safety requirements, compliance rules, and creative guidelines from brand profile. Essential for brand safety v',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign this IO supports. Enables campaign-level spend aggregation, KPI tracking, and ROAS reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Insertion orders require cost center assignment for budget allocation, financial reporting, and expense tracking - fundamental financial control in advertising operations.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Insertion orders must reference approved budgets for spend authorization, compliance checking, and budget consumption tracking in financial controls.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Insertion orders execute within strategic initiatives. Linking enables portfolio-level budget management, cross-campaign spend analysis, and strategic alignment reporting required for client business ',
    `plan_id` BIGINT COMMENT 'Reference to the parent media plan from which this IO was generated. Enables traceability from strategic plan through execution to billing.',
    `publisher_id` BIGINT COMMENT 'Reference to the media vendor or publisher receiving this IO. Links to the vendor master record for payment, reconciliation, and compliance checks.',
    `publisher_property_id` BIGINT COMMENT 'Foreign key linking to media.publisher_property. Business justification: media_insertion_order currently has FK to publisher (parent entity). Many IOs are property-specific (e.g., IO for NYTimes.com, IO for WSJ Print Edition). While media_insertion_order → publisher → publ',
    `supplier_id` BIGINT COMMENT 'Reference to the internal agency entity (buying unit) issuing this IO on behalf of the advertiser. Supports multi-agency holding company structures and commission calculations.',
    `worker_id` BIGINT COMMENT 'Foreign key linking to talent.worker. Business justification: Insertion orders require a designated trafficker responsible for ad server setup, creative trafficking, and delivery monitoring. Critical for accountability in campaign execution and operational hando',
    `vendor_rate_card_id` BIGINT COMMENT 'Reference to the vendor rate card governing the pricing of placements under this IO. Links to the media rate card product for CPM, CPC, CPA, and flat-fee rate validation.',
    `agency_commission_amount` DECIMAL(18,2) COMMENT 'Agency commission deducted from the gross authorized spend, typically calculated as a percentage of gross billings (standard 15% of gross or negotiated rate). Satisfies TRANSACTION_HEADER MONETARY_TRIPLET (adjustment) category.',
    `authorized_spend_amount` DECIMAL(18,2) COMMENT 'Total gross media spend authorized under this IO, expressed in the IO currency. Represents the maximum contractual commitment to the vendor before agency commission and fees. Satisfies TRANSACTION_HEADER MONETARY_TRIPLET (gross base amount) category.',
    `billing_cycle` STRING COMMENT 'Frequency at which the vendor invoices against this IO. Drives accounts payable scheduling and cash flow forecasting in SAP S/4HANA FI.. Valid values are `monthly|weekly|flight_end|milestone|prepaid`',
    `brand_safety_requirements` STRING COMMENT 'Free-text or structured description of brand safety and suitability requirements contractually mandated for this IO (e.g., IAB content category exclusions, GARM brand safety floor). Enforced during trafficking and programmatic bid configuration.',
    `buying_method` STRING COMMENT 'The transactional mechanism used to purchase media under this IO. Distinguishes direct buys from Real-Time Bidding (RTB), programmatic guaranteed, and Private Marketplace (PMP) deals. Informs DSP/SSP configuration in The Trade Desk.. Valid values are `direct|programmatic|rtb|programmatic_guaranteed|preferred_deal|pmp`',
    `cancellation_notice_days` STRING COMMENT 'Number of business days advance notice required to cancel this IO without incurring the full cancellation penalty. Operationalizes the cancellation policy for workflow and legal compliance.',
    `cancellation_policy` STRING COMMENT 'Contractual cancellation terms governing the IO. Specifies whether the IO can be cancelled, the required notice period, and any financial penalties. Critical for financial liability management and vendor negotiations.. Valid values are `non_cancellable|cancellable_with_notice|cancellable_with_penalty|cancellable_no_penalty`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this IO record was first created in the source system (Mediaocean Prisma). Used for audit trail and data lineage. Satisfies TRANSACTION_HEADER RECORD_AUDIT_CREATED category.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this IO (e.g., USD, GBP, EUR). Satisfies TRANSACTION_HEADER MONETARY_TRIPLET (currency code) category.. Valid values are `^[A-Z]{3}$`',
    `execution_date` DATE COMMENT 'The date on which the IO was formally executed (signed/authorized) by all parties. Represents the principal real-world business event timestamp at day granularity. Satisfies TRANSACTION_HEADER BUSINESS_EVENT_TIMESTAMP category.',
    `flight_end_date` DATE COMMENT 'The last date on which media placements under this IO are authorized to run. Defines the end of the contracted delivery window. Satisfies TRANSACTION_HEADER EFFECTIVE_UNTIL category.',
    `flight_start_date` DATE COMMENT 'The first date on which media placements under this IO are authorized to run. Defines the beginning of the contracted delivery window. Satisfies TRANSACTION_HEADER EFFECTIVE_FROM category.',
    `guaranteed_impressions` BIGINT COMMENT 'Total number of ad impressions contractually guaranteed by the vendor under this IO. Applicable for CPM and guaranteed programmatic buys. Used for delivery pacing and reconciliation against actuals.',
    `io_name` STRING COMMENT 'Human-readable descriptive name for the IO, typically combining advertiser, campaign, channel, and flight period (e.g., BrandX_Q3_2024_Display_IO). Used in Mediaocean Prisma and trafficking systems for quick identification.',
    `io_number` STRING COMMENT 'Externally-known, human-readable Insertion Order number assigned by Mediaocean Prisma at IO creation. Used on all vendor invoices, trafficking instructions, and reconciliation documents. Satisfies TRANSACTION_HEADER BUSINESS_IDENTIFIER category.. Valid values are `^IO-[0-9]{6,12}$`',
    `io_status` STRING COMMENT 'Current workflow state of the Insertion Order. Drives downstream trafficking, billing, and reconciliation eligibility. Satisfies TRANSACTION_HEADER LIFECYCLE_STATUS category.. Valid values are `draft|pending_approval|executed|cancelled|on_hold`',
    `io_type` STRING COMMENT 'Classification of the IO by buying method. Distinguishes direct buys from programmatic guaranteed, preferred deals, and private marketplace (PMP) deals. Informs DSP/SSP routing and billing treatment. [ENUM-REF-CANDIDATE: standard|programmatic_guaranteed|preferred_deal|private_marketplace|direct_buy|sponsorship|barter — promote to reference product]. Valid values are `standard|programmatic_guaranteed|preferred_deal|private_marketplace|direct_buy`',
    `is_programmatic` BOOLEAN COMMENT 'Indicates whether this IO governs programmatic media buying (True) or a direct/traditional buy (False). Used to route IO data to DSP/SSP systems such as The Trade Desk and to apply appropriate measurement and brand safety standards.',
    `makegood_policy` STRING COMMENT 'Contractual make-good policy specifying how the vendor compensates for under-delivery against guaranteed impressions or GRPs. Options include credit against future buys, re-run of spots, or cash refund.. Valid values are `credit|rerun|cash_refund|none`',
    `net_spend_amount` DECIMAL(18,2) COMMENT 'Net media cost payable to the vendor after deducting agency commission from the gross authorized spend. Used for vendor payment and reconciliation. Satisfies TRANSACTION_HEADER MONETARY_TRIPLET (net total) category.',
    `notes` STRING COMMENT 'Free-text field for additional contractual terms, special instructions, or operational notes associated with this IO that are not captured in structured fields. Sourced from Mediaocean Prisma IO comments.',
    `payment_terms` STRING COMMENT 'Contractual payment terms agreed with the vendor, specifying the number of days after invoice date by which payment is due (e.g., Net 30, Net 45). Drives accounts payable scheduling in SAP S/4HANA FI-AP.. Valid values are `net_30|net_45|net_60|net_90|prepaid`',
    `po_number` STRING COMMENT 'Client-issued Purchase Order number associated with this IO. Required by many advertisers for invoice matching and financial controls in SAP S/4HANA MM. Links the IO to the clients internal procurement system.',
    `pricing_model` STRING COMMENT 'The cost pricing model agreed with the vendor for this IO. Determines how media delivery is measured and billed: Cost Per Mille (CPM), Cost Per Click (CPC), Cost Per Acquisition (CPA), Cost Per Completed View (CPCV), flat fee, or Cost Per View (CPV).. Valid values are `cpm|cpc|cpa|cpcv|flat_fee|cpv`',
    `prisma_io_code` STRING COMMENT 'Native system identifier for this IO in Mediaocean Prisma. Enables direct cross-reference and reconciliation between the lakehouse Silver layer and the source system of record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this IO record was last modified in the source system. Tracks amendments, status changes, and spend revisions. Satisfies TRANSACTION_HEADER RECORD_AUDIT_UPDATED category.',
    `version_number` STRING COMMENT 'Sequential version number incremented each time the IO is formally amended (e.g., spend increase, flight date change). Enables change history tracking and audit compliance.',
    CONSTRAINT pk_media_insertion_order PRIMARY KEY(`media_insertion_order_id`)
) COMMENT 'Authoritative master record for all Insertion Orders (IOs) issued to media vendors and publishers. Captures IO number, advertiser, agency, vendor, flight dates, total authorized spend, payment terms, cancellation policy, IO status (draft, executed, cancelled), and client authorization details (authorizing party, authorization date, authorization method). Sourced from Mediaocean Prisma and serves as the contractual backbone for all media buys. Links to media plans, placements, and vendor records.';

CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`plan` (
    `plan_id` BIGINT COMMENT 'Unique surrogate identifier for the media plan record in the Databricks Silver Layer. Primary key for this entity.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser/client for whom this media plan is developed. Aligns with the Salesforce CRM account record.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Media plans define primary target audience segments for campaign planning, budget allocation, and channel mix decisions. Core planning workflow requires linking plan to specific audience segment for t',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Media plans are developed for specific brands. Planners require brand positioning, target audience definitions, tone requirements, SOV targets, and channel applicability from brand profile. Core to me',
    `campaign_id` BIGINT COMMENT 'Reference to the parent campaign this media plan supports. Links the media plan to its overarching campaign strategy and objectives.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Media plans must be assigned to cost centers for budget planning, approval workflows, and financial accountability in campaign planning processes.',
    `creative_brief_id` BIGINT COMMENT 'Foreign key linking to creative.creative_brief. Business justification: Media plans are built from creative briefs that define messaging, audience, deliverables, and mandatories. Planners reference the brief throughout planning to ensure media strategy aligns with creativ',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Media plans tied to specific budgets for planning, approval workflows, and budget allocation - fundamental financial planning relationship.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Media plans are tracked as projects/initiatives in project management systems. Currently workfront_project_id is stored as an unlinked string. Normalizing to initiative_id FK enables joining to projec',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Media plans are executed under SOWs that authorize budget and scope. Planners reference the governing SOW for budget authority validation and scope compliance checks. Essential for financial controls ',
    `worker_id` BIGINT COMMENT 'Reference to the talent/worker record of the media planner who owns and authored this plan. Sourced from Workday HCM.',
    `agency_commission_pct` DECIMAL(18,2) COMMENT 'The percentage of the gross media budget retained by the agency as commission. Standard industry rate is typically 15%. Used in financial reconciliation and P&L reporting.',
    `approval_date` DATE COMMENT 'The date on which the media plan received formal client or internal approval. Marks the transition from planning to buying execution phase.',
    `approval_status` STRING COMMENT 'The client or internal approval status of the media plan. Tracks whether the plan has been formally approved by the client before buying execution commences. Managed via Workfront approval workflow.. Valid values are `pending|approved|rejected|revision_required`',
    `approved_by` STRING COMMENT 'Name or identifier of the client contact or internal stakeholder who formally approved this media plan. Captured for audit trail and accountability purposes.',
    `buying_approach` STRING COMMENT 'The media buying methodology planned for this plan — direct IO-based buying, programmatic Real-Time Bidding (RTB) via DSP, or a hybrid approach. Determines execution path in Mediaocean Prisma and The Trade Desk.. Valid values are `direct|programmatic|hybrid|guaranteed|non_guaranteed`',
    `channel_mix` STRING COMMENT 'Comma-separated list of media channels included in this plan (e.g., digital_display, paid_social, ctv, ooh, broadcast_tv). Defines the cross-channel strategy. Detailed channel-level budget splits are captured in child media plan line records.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this media plan record was first created in the system. Audit trail field aligned with GDPR data processing records requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the media plan budget and financial targets are denominated (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `daypart_strategy` STRING COMMENT 'The planned daypart scheduling strategy for broadcast and digital media placements. Defines when within the day media will be concentrated to maximize target audience reach.. Valid values are `all_day|prime_time|daytime|late_night|morning_drive|custom`',
    `flight_end_date` DATE COMMENT 'The date on which the planned media activity concludes in-market. Defines the end of the planning period. Nullable for open-ended or evergreen plans.',
    `flight_start_date` DATE COMMENT 'The date on which the planned media activity begins running in-market. Defines the start of the planning period and aligns with insertion order (IO) effective dates in Mediaocean Prisma.',
    `frequency_target` DECIMAL(18,2) COMMENT 'The planned average number of times a member of the target audience is exposed to the advertising during the flight period. Balances reach objectives against budget constraints.',
    `geographic_scope` STRING COMMENT 'The geographic coverage level of the media plan, indicating whether the campaign runs nationally, regionally, locally, or internationally. Drives media buying strategy and publisher selection.. Valid values are `national|regional|local|international|global`',
    `grp_target` DECIMAL(18,2) COMMENT 'The planned Gross Rating Point (GRP) delivery target for this media plan, representing the total weight of advertising exposure across the total population. Tracked via Nielsen Ad Intel.',
    `is_addressable` BOOLEAN COMMENT 'Indicates whether this media plan includes addressable media components (e.g., addressable TV, CTV/OTT targeting at household level). Triggers additional data governance and privacy compliance requirements under GDPR/CCPA.',
    `is_programmatic` BOOLEAN COMMENT 'Indicates whether this media plan includes programmatic buying components executed via a Demand-Side Platform (DSP) such as The Trade Desk. Drives workflow routing and technology fee accounting.',
    `net_budget` DECIMAL(18,2) COMMENT 'The net media budget after deducting agency commission and applicable fees from the gross planned budget. Represents the actual spend allocated to media vendors and publishers.',
    `plan_name` STRING COMMENT 'Human-readable descriptive name of the media plan, typically including client name, campaign flight, and planning period (e.g., Acme Q3 2025 Brand Awareness Plan). Used in Mediaocean Prisma and client presentations.',
    `plan_number` STRING COMMENT 'Externally-known unique business identifier for the media plan as assigned by Mediaocean Prisma. Used in client-facing documents, insertion orders, and cross-system references.. Valid values are `^MP-[0-9]{4}-[0-9]{6}$`',
    `plan_status` STRING COMMENT 'Current lifecycle state of the media plan within the planning and buying workflow. Drives downstream buying execution in Mediaocean Prisma. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|paused|completed|cancelled — promote to reference product]',
    `plan_type` STRING COMMENT 'Classification of the media plan by strategic objective and buying approach. Determines the KPI framework and channel mix strategy applied. [ENUM-REF-CANDIDATE: brand_awareness|direct_response|performance|sponsorship|integrated|programmatic — promote to reference product]. Valid values are `brand_awareness|direct_response|performance|sponsorship|integrated|programmatic`',
    `primary_kpi` STRING COMMENT 'The primary Key Performance Indicator (KPI) against which this media plans success will be measured. Drives optimization strategy and reporting framework. [ENUM-REF-CANDIDATE: cpm|cpc|cpa|ctr|roas|grp|trp|vtr|reach|frequency — promote to reference product]',
    `prisma_plan_code` STRING COMMENT 'The native plan identifier assigned by Mediaocean Prisma, the system of record for media planning and buying. Used for cross-system reconciliation between the lakehouse and Prisma.',
    `reach_target_pct` DECIMAL(18,2) COMMENT 'The planned percentage of the target audience to be reached at least once during the flight period. A core media planning objective used to evaluate channel mix effectiveness.',
    `secondary_kpi` STRING COMMENT 'The secondary Key Performance Indicator (KPI) used to evaluate supplementary performance dimensions of this media plan. Complements the primary KPI in holistic campaign reporting. [ENUM-REF-CANDIDATE: cpm|cpc|cpa|ctr|roas|grp|trp|vtr|reach|frequency — promote to reference product]',
    `sfdc_opportunity_code` STRING COMMENT 'The Salesforce CRM Opportunity ID associated with this media plan. Links the media plan to the sales pipeline record for revenue tracking and account management reporting.',
    `target_age_range` STRING COMMENT 'The primary demographic age range targeted by this media plan (e.g., 25-54, 18-34). Used for GRP/TRP calculation and audience buying parameters in Nielsen Ad Intel and The Trade Desk.. Valid values are `^[0-9]{1,2}-[0-9]{1,2}$`',
    `target_cpm` DECIMAL(18,2) COMMENT 'The planned Cost Per Mille (CPM) — cost per 1,000 impressions — used as the benchmark rate for this media plan. Informs rate card negotiations and programmatic bid strategies in The Trade Desk.',
    `target_gender` STRING COMMENT 'Gender targeting parameter for the media plan audience. Informs GRP/TRP delivery targets and audience buying configurations in Nielsen Ad Intel and The Trade Desk.. Valid values are `male|female|all|skew_male|skew_female`',
    `target_markets` STRING COMMENT 'Comma-separated list of target geographic markets or Designated Market Areas (DMAs) where media will run (e.g., New York DMA, Los Angeles DMA, Chicago DMA). Used for geo-targeting and local market buying.',
    `total_planned_budget` DECIMAL(18,2) COMMENT 'The gross total budget allocated to this media plan across all channels and placements for the full flight period. Expressed in the plan currency. Sourced from Mediaocean Prisma budget module.',
    `trp_target` DECIMAL(18,2) COMMENT 'The planned Target Rating Point (TRP) delivery target for this media plan, representing the total weight of advertising exposure within the defined target audience demographic. Tracked via Nielsen Ad Intel.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this media plan record was most recently modified. Supports change tracking, audit compliance, and incremental ETL processing in the Databricks Silver Layer.',
    `version` STRING COMMENT 'Version identifier of the media plan (e.g., v1.0, v2.3). Tracks iterative revisions submitted for client review or internal approval. Mediaocean Prisma supports versioned plan management.. Valid values are `^v[0-9]+.[0-9]+$`',
    CONSTRAINT pk_plan PRIMARY KEY(`plan_id`)
) COMMENT 'Master record representing a structured media plan developed during the media planning phase. Captures plan name, client, campaign reference, planning period, total planned budget, target audience, channel mix allocation, GRP/TRP delivery targets, reach and frequency objectives, target markets/DMAs, demographic targets, approval status, and planner ownership. Sourced from Mediaocean Prisma. Serves as the SSOT for planned media strategy before buying execution begins.';

CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`plan_line` (
    `plan_line_id` BIGINT COMMENT 'Unique surrogate identifier for each individual line item within a media plan. Primary key for this entity. TRANSACTION_LINE role — each line represents one channel/vehicle/flight combination within a parent media plan.',
    `ad_channel_id` BIGINT COMMENT 'Foreign key linking to media.ad_channel. Business justification: plan_line currently has media_type and media_subtype as STRING attributes. Each plan line represents a specific channel, vehicle, and flight combination. While plan_line → media_placement → ad_channel',
    `ad_format_id` BIGINT COMMENT 'Foreign key linking to media.ad_format. Business justification: plan_line currently has ad_format as a STRING attribute. Each plan line specifies the ad format for the planned media (e.g., 300x250 Banner, Pre-roll Video). This FK normalizes the plan_line-to-format',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Plan lines specify granular audience targeting for individual media vehicles and tactics. Buyers need explicit segment linkage for rate negotiation, inventory availability checks, and delivery forecas',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Plan lines require brand context for channel-specific tactics. Brand profile provides channel applicability, messaging framework, and compliance requirements for line-level brand safety validation and',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign this media plan line supports. Links the line item to the overarching campaign strategy and objectives for cross-campaign reporting and budget tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Plan lines often allocated to specific cost centers for granular budget tracking and cross-functional cost allocation in matrix organizations.',
    `creative_asset_id` BIGINT COMMENT 'Foreign key linking to creative.creative_asset. Business justification: Plan lines specify which creative assets will run in each placement. Essential for trafficking planning, publisher spec validation, and ensuring creative is ready before media flights begin.',
    `media_placement_id` BIGINT COMMENT 'Reference to the specific media placement or ad unit associated with this line item. Links to the placement master record defining the ad environment, size, and position. RESOURCE_REFERENCE per TRANSACTION_LINE canonical role.',
    `plan_id` BIGINT COMMENT 'Reference to the parent media plan that contains this line item. Establishes the header/detail relationship between the media plan and its individual line items. HEADER_REFERENCE per TRANSACTION_LINE canonical role.',
    `programmatic_deal_id` BIGINT COMMENT 'Unique deal identifier for programmatic private marketplace (PMP) or programmatic guaranteed (PG) transactions associated with this line item. Used in The Trade Desk and DSP platforms for deal activation and reporting.',
    `vendor_rate_card_id` BIGINT COMMENT 'Reference to the rate card record that governs the pricing for this line item. Links to negotiated or standard publisher rate cards used to validate planned CPM/CPC/CPA values and support buying negotiations.',
    `agency_commission_pct` DECIMAL(18,2) COMMENT 'Percentage of gross media spend retained by the agency as commission for this line item. Standard advertising industry compensation model (historically 15%). Used for net spend calculation and client billing transparency.',
    `approval_status` STRING COMMENT 'Current workflow approval status of this media plan line item. Governs whether the line is authorized for buying and trafficking. LIFECYCLE_STATUS per TRANSACTION_LINE canonical role. Tracks progression from draft through client and internal approval gates.. Valid values are `draft|pending_approval|approved|rejected|cancelled|on_hold`',
    `buying_status` STRING COMMENT 'Operational buying and trafficking status of this line item, tracking progression from plan through insertion order issuance, confirmation, trafficking, and delivery. Distinct from approval_status which governs internal authorization. [ENUM-REF-CANDIDATE: not_ordered|io_sent|io_confirmed|trafficking|live|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `buying_type` STRING COMMENT 'The pricing and buying model for this line item, determining how media is purchased and measured. CPM (Cost Per Mille), CPC (Cost Per Click), CPA (Cost Per Acquisition), CPV (Cost Per View), flat_rate, GRP (Gross Rating Point), or TRP (Target Rating Point). Drives rate card application and performance benchmarking. [ENUM-REF-CANDIDATE: cpm|cpc|cpa|cpv|flat_rate|grp|trp — 7 candidates stripped; promote to reference product]',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the geographic territory where this media line item will be delivered (e.g., USA, GBR, CAN). Required for international campaign management and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this media plan line item record was first created in the system. Supports audit trail, version history, and compliance with data governance requirements. RECORD_AUDIT_CREATED per TRANSACTION_LINE canonical role.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary values on this line item (e.g., USD, GBP, EUR). Required for multi-currency campaign management and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `daypart` STRING COMMENT 'Broadcast or digital daypart specification for this line item, defining the time-of-day window for ad delivery (e.g., primetime, daytime, late_night). Critical for broadcast TV/radio buying and audience composition planning. [ENUM-REF-CANDIDATE: primetime|daytime|late_night|early_morning|weekend|all_day|access — 7 candidates stripped; promote to reference product]',
    `flight_end_date` DATE COMMENT 'The date on which ad delivery for this media plan line item is scheduled to end. Defines the close of the flight period. Used for pacing, reconciliation, and campaign wrap-up reporting. EFFECTIVE_UNTIL per TRANSACTION_LINE canonical role.',
    `flight_start_date` DATE COMMENT 'The date on which ad delivery for this media plan line item is scheduled to begin. Defines the start of the flight period for trafficking, scheduling, and pacing purposes. EFFECTIVE_FROM per TRANSACTION_LINE canonical role.',
    `io_number` STRING COMMENT 'The Insertion Order (IO) number issued to the publisher or vendor for this line item. Legal binding document reference used for vendor reconciliation, invoice matching, and audit trail. May be assigned after approval.',
    `is_bonus` BOOLEAN COMMENT 'Indicates whether this line item represents bonus or added-value inventory provided by the publisher at no additional cost as part of a negotiated package. Bonus lines are excluded from spend calculations but included in delivery and GRP reporting.',
    `is_makegood` BOOLEAN COMMENT 'Indicates whether this line item is a makegood — compensatory inventory provided by the publisher to replace underdelivered or preempted spots from a prior buy. Makegood lines require special reconciliation treatment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this media plan line item record. Used for change tracking, data synchronization, and audit compliance. RECORD_AUDIT_UPDATED per TRANSACTION_LINE canonical role.',
    `line_name` STRING COMMENT 'Descriptive name for this media plan line item, typically combining the vehicle, placement, and flight period (e.g., CNN Homepage Takeover - Q1 2025). Used for human-readable identification in reports and insertion orders.',
    `line_number` STRING COMMENT 'Sequential line number identifying the position of this line item within the parent media plan. Used for ordering, referencing, and reconciliation against insertion orders and vendor invoices. LINE_SEQUENCE per TRANSACTION_LINE canonical role.',
    `market` STRING COMMENT 'Geographic market or designated market area (DMA) where this media line item will run (e.g., New York DMA, National, Los Angeles DMA). Critical for audience targeting, GRP/TRP calculation, and local vs. national budget allocation.',
    `media_subtype` STRING COMMENT 'Granular classification within the media type (e.g., display, video, paid_search, social, connected_tv, digital_out_of_home, programmatic, direct). Enables detailed channel-level performance analysis and buying strategy differentiation. [ENUM-REF-CANDIDATE: display|video|paid_search|social|connected_tv|digital_out_of_home|programmatic|direct|audio|native — promote to reference product]',
    `media_type` STRING COMMENT 'High-level classification of the media channel for this line item (e.g., digital, television, radio, print, out_of_home, cinema). Drives planning methodology, buying approach, and metric selection. [ENUM-REF-CANDIDATE: digital|television|radio|print|out_of_home|cinema|podcast|streaming — promote to reference product]. Valid values are `digital|television|radio|print|out_of_home|cinema`',
    `planned_cpa` DECIMAL(18,2) COMMENT 'Planned Cost Per Acquisition (CPA) — the negotiated or estimated cost for each conversion or acquisition event generated by this line item. Used for performance-based buying where payment is tied to measurable outcomes.',
    `planned_cpc` DECIMAL(18,2) COMMENT 'Planned Cost Per Click (CPC) — the negotiated or estimated cost for each click generated by this line item. Primary pricing metric for paid search and performance-based digital campaigns. Applicable when buying_type is CPC.',
    `planned_cpm` DECIMAL(18,2) COMMENT 'Planned Cost Per Mille (CPM) — the negotiated or estimated cost per 1,000 impressions for this line item. Core pricing metric for digital and broadcast media buying. Used for rate benchmarking, budget allocation, and vendor negotiation.',
    `planned_frequency` DECIMAL(18,2) COMMENT 'Planned average number of times a member of the target audience will be exposed to the ad during the flight period. Used with reach to calculate GRPs and to optimize against frequency caps and diminishing returns thresholds.',
    `planned_grps` DECIMAL(18,2) COMMENT 'Planned Gross Rating Points (GRPs) for this line item, representing total audience delivery as a percentage of the total target population. Primary planning metric for broadcast TV, radio, and OOH. Calculated as reach × frequency.',
    `planned_impressions` BIGINT COMMENT 'The total number of ad impressions planned for this line item across the flight period. Standardized cross-channel metric used for reach estimation, CPM calculation, and campaign delivery forecasting regardless of buying type.',
    `planned_net_spend` DECIMAL(18,2) COMMENT 'Planned net media spend after agency commission, discounts, and negotiated rebates have been deducted from the gross planned spend. Used for vendor payment reconciliation and agency P&L reporting.',
    `planned_reach_pct` DECIMAL(18,2) COMMENT 'Planned percentage of the target audience expected to be exposed to the ad at least once during the flight period. Key media planning metric used alongside frequency to evaluate campaign effectiveness and GRP decomposition.',
    `planned_spend` DECIMAL(18,2) COMMENT 'Total planned gross media spend allocated to this line item for the full flight period, in the plan currency. Primary budget field used for financial planning, client billing, and P&L management. LINE_VALUE_OR_RESULT per TRANSACTION_LINE canonical role.',
    `planned_trps` DECIMAL(18,2) COMMENT 'Planned Target Rating Points (TRPs) for this line item, representing audience delivery specifically among the defined target demographic as a percentage of that target population. More precise than GRPs for audience-specific campaign planning.',
    `planned_units` DECIMAL(18,2) COMMENT 'The planned quantity of media units to be purchased for this line item. Unit interpretation depends on buying_type: impressions for CPM, clicks for CPC, conversions for CPA, spots for broadcast, panels for OOH. LINE_QUANTITY per TRANSACTION_LINE canonical role.',
    `publisher_name` STRING COMMENT 'Name of the media owner or publisher selling the inventory for this line item (e.g., WarnerMedia, Google, Clear Channel). Used for vendor management, spend reporting, and competitive analysis.',
    `vehicle_name` STRING COMMENT 'Name of the specific media property or publisher vehicle where the ad will run (e.g., CNN.com, NBC Nightly News, Times Square Billboard, Spotify). Core planning field used in insertion orders and vendor negotiations.',
    CONSTRAINT pk_plan_line PRIMARY KEY(`plan_line_id`)
) COMMENT 'Individual line-item within a media plan representing a specific channel, vehicle, and flight combination. Captures line number, media type (TV, digital, OOH, print, OTT/CTV, DOOH), vehicle name, market, start/end dates, planned units, planned GRPs/TRPs, planned impressions, planned CPM/CPC/CPA, planned spend, and approval status. Enables granular budget allocation and channel-level planning visibility.';

CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`media_placement` (
    `media_placement_id` BIGINT COMMENT 'Unique surrogate identifier for the media placement record. This is the atomic unit of a media buy, representing a specific ad placement purchased from a media vendor. Role: TRANSACTION_LINE.',
    `ad_channel_id` BIGINT COMMENT 'Reference to the media channel taxonomy (digital, broadcast, OOH, CTV/OTT, print) for this placement.',
    `ad_format_id` BIGINT COMMENT 'Foreign key linking to media.ad_format. Business justification: media_placement currently has ad_format and ad_unit_size as STRING attributes. Each placement is for a specific ad format (e.g., 300x250 Banner, Pre-roll Video). This FK normalizes the placement-to-fo',
    `placement_id` BIGINT COMMENT 'The placement identifier assigned by Google Campaign Manager 360 (CM360) ad server used for trafficking, creative assignment, and delivery reporting. This is the operational key used by ad operations teams to manage the placement in the ad server.',
    `creative_asset_id` BIGINT COMMENT 'Foreign key linking to creative.creative_asset. Business justification: Placements are assigned specific creative assets for delivery. Essential for trafficking, ad server setup, and ensuring creative specs match placement requirements. Distinct from ad_server_placement_i',
    `media_insertion_order_id` BIGINT COMMENT 'Reference to the parent Insertion Order (IO) under which this placement was purchased. An IO is the binding contract between the advertiser/agency and the media vendor authorizing the placement. Serves as the HEADER_REFERENCE for this transaction line.',
    `original_placement_media_placement_id` BIGINT COMMENT 'For make-good placements (is_makegood = true), the reference to the original media_placement_id that this placement is compensating for. Enables traceability between under-delivered placements and their corresponding make-good replacements.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Placements are bought and trafficked against specific audience segments. Ad ops teams require explicit segment linkage for ad server targeting setup, delivery pacing, and performance reporting by audi',
    `programmatic_deal_id` BIGINT COMMENT 'The unique deal identifier for programmatic private marketplace (PMP) or programmatic guaranteed deals, as assigned by the Supply-Side Platform (SSP) or publisher. Used to activate and track the deal in The Trade Desk Demand-Side Platform (DSP). Null for direct or open auction buys.',
    `publisher_id` BIGINT COMMENT 'Reference to the media vendor or publisher from whom this placement was purchased (e.g., Google, Meta, NBC Universal, Clear Channel). Serves as the PARTY_REFERENCE for this transaction line.',
    `publisher_property_id` BIGINT COMMENT 'Reference to the specific publisher property (website, app, broadcast station, OOH network) where this placement appears.',
    `ssp_platform_id` BIGINT COMMENT 'Foreign key linking to media.ssp_platform. Business justification: media_placement is the operational record for a specific ad placement purchased from a media vendor. For programmatic placements, the placement is served via a specific SSP platform (e.g., Google Ad M',
    `worker_id` BIGINT COMMENT 'Foreign key linking to talent.worker. Business justification: Placements need a designated trafficking contact for coordinating creative delivery, troubleshooting ad serving issues, and managing publisher communications. Critical for operational efficiency and e',
    `above_fold_classification` STRING COMMENT 'Classification indicating whether the placement typically appears above or below the fold on initial page load, critical for viewability.. Valid values are `above_fold|below_fold|mixed|not_applicable`',
    `ad_server_platform` STRING COMMENT 'Primary ad server platform used for trafficking this placement (Google Campaign Manager 360, The Trade Desk, FreeWheel, etc.).. Valid values are `google_campaign_manager|the_trade_desk|freewheel|sizmek|other`',
    `ad_unit_size` STRING COMMENT 'Dimensions of the ad unit in pixels (e.g., 728x90, 300x250, 1920x1080) or duration for video/audio placements.',
    `agency_commission_pct` DECIMAL(18,2) COMMENT 'The agency commission percentage applied to this placements gross contracted value, typically 15% per industry standard (4As convention). Used to calculate net media cost billed to the client versus gross cost paid to the vendor. Part of the MONETARY_TRIPLET adjustment.',
    `approved_date` DATE COMMENT 'The date on which this placement was formally approved by the client or account team, authorizing the media vendor to proceed with trafficking and delivery. Represents the BUSINESS_EVENT_TIMESTAMP for the placement authorization event.',
    `brand_safety_category` STRING COMMENT 'The IAB content category exclusion or inclusion list applied to this placement to ensure brand-safe ad delivery (e.g., Exclude: Adult Content, Violence, Hate Speech). Configured in Google CM360 or The Trade Desk per TAG Brand Safety standards and client brand guidelines.',
    `brand_safety_tier` STRING COMMENT 'Brand safety classification tier for this placement, indicating content adjacency risk level per Trustworthy Accountability Group (TAG) standards.. Valid values are `premium|standard|moderate|unrated`',
    `buying_method` STRING COMMENT 'The method by which this placement was purchased: direct IO with publisher, programmatic guaranteed, private marketplace (PMP) deal, open auction Real-Time Bidding (RTB), or preferred deal. Determines the applicable technology stack (e.g., The Trade Desk for programmatic, Mediaocean Prisma for direct).. Valid values are `direct|programmatic_guaranteed|private_marketplace|open_auction|preferred_deal`',
    `cancellation_notice_days` STRING COMMENT 'Number of days advance notice required to cancel or modify a booked campaign on this placement without penalty.',
    `channel_type` STRING COMMENT 'The media channel category for this placement (e.g., digital display, broadcast TV, Out-of-Home (OOH), Connected TV (CTV)/Over-the-Top (OTT), print). Drives channel-specific reporting, rate card application, and regulatory compliance requirements. [ENUM-REF-CANDIDATE: digital|broadcast_tv|radio|print|ooh|dooh|ctv_ott|cinema|podcast — promote to reference product]',
    `content_category` STRING COMMENT 'IAB Content Taxonomy category for the content surrounding this placement (e.g., News, Sports, Entertainment, Finance).',
    `contracted_impressions` BIGINT COMMENT 'The total number of ad impressions guaranteed or estimated for this placement under the IO. For CPM-based buys this is the primary delivery metric; for GRP/TRP buys this is the estimated impression equivalent. Used for reach/frequency planning and MRC-compliant delivery verification.',
    `contracted_rate` DECIMAL(18,2) COMMENT 'The negotiated unit rate for this placement as agreed in the Insertion Order (IO), expressed in the applicable rate type currency (e.g., CPM rate in USD, CPC rate in USD, flat fee in USD). This is commercially sensitive pricing data. Serves as the LINE_VALUE_OR_RESULT for this transaction line.',
    `contracted_units` BIGINT COMMENT 'The total number of units (impressions, clicks, acquisitions, GRPs, or flat occurrences) contracted for this placement as specified in the Insertion Order. Serves as the LINE_QUANTITY for this transaction line. Used for pacing, delivery tracking, and reconciliation.',
    `contracted_value` DECIMAL(18,2) COMMENT 'The total gross monetary value of this placement as contracted in the Insertion Order (IO), calculated as contracted rate × contracted units. Represents the full financial commitment for this placement before any adjustments, make-goods, or agency commission. Part of the MONETARY_TRIPLET.',
    `cpm_floor_price` DECIMAL(18,2) COMMENT 'Minimum CPM rate for this placement position, used in programmatic bidding and rate card negotiations.',
    `cpm_list_price` DECIMAL(18,2) COMMENT 'Published list CPM rate for this placement on the rate card, before negotiation or discounts.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this media placement record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Serves as the RECORD_AUDIT_CREATED field for this transaction line. Used for data lineage and audit trail.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary values on this placement (e.g., USD, GBP, EUR). Required for multi-currency media buys and financial reconciliation in SAP S/4HANA. Part of the MONETARY_TRIPLET.. Valid values are `^[A-Z]{3}$`',
    `daypart_availability` STRING COMMENT 'Time-of-day availability for this placement (e.g., Prime Time, Daytime, Late Night, Run-of-Schedule), relevant for broadcast and digital video.',
    `device_targeting` STRING COMMENT 'Device type targeting parameters for this placement position.. Valid values are `desktop|mobile|tablet|ctv|all_devices`',
    `effective_end_date` DATE COMMENT 'Date when this placement position will be or was retired from available inventory (nullable for ongoing placements).',
    `effective_start_date` DATE COMMENT 'Date when this placement position became available in inventory for booking and trafficking.',
    `environment_type` STRING COMMENT 'The platform environment where the placement is delivered (web, mobile app, Connected TV (CTV), Over-the-Top (OTT), Digital Out-of-Home (DOOH), etc.). [ENUM-REF-CANDIDATE: web|mobile_web|mobile_app|ctv|ott|dooh|linear_tv|radio|print — 9 candidates stripped; promote to reference product]',
    `estimated_monthly_impressions` BIGINT COMMENT 'Projected monthly impression volume available for this placement position, used in media planning and forecasting.',
    `estimated_reach_pct` DECIMAL(18,2) COMMENT 'Estimated percentage of target audience reached by this placement within a standard campaign flight.',
    `flight_end_date` DATE COMMENT 'The date on which the ad placement is scheduled to stop delivering. Defines the end of the placements active flight period. Used for campaign scheduling, delivery completion tracking, and IO reconciliation.',
    `flight_start_date` DATE COMMENT 'The date on which the ad placement is scheduled to begin delivering impressions or airing. Defines the start of the placements active flight period. Used for campaign scheduling, pacing calculations, and IO compliance verification.',
    `frequency_cap` STRING COMMENT 'The maximum number of times a unique user or household may be served this ad within the defined frequency cap period. Configured in Google CM360 or The Trade Desk to control ad fatigue and optimize reach. Null if no frequency cap is applied.',
    `frequency_cap_impressions` STRING COMMENT 'Maximum number of impressions per user within the frequency cap period, enforced at placement level.',
    `frequency_cap_period` STRING COMMENT 'The time window over which the frequency cap applies (e.g., per day, per week, per month, lifetime of the campaign). Works in conjunction with frequency_cap to define the full frequency capping rule in the ad server.. Valid values are `hour|day|week|month|lifetime`',
    `geo_targeting_scope` STRING COMMENT 'Geographic targeting granularity available for this placement (global, national, Designated Market Area (DMA), postal code, etc.).. Valid values are `global|national|regional|dma|zip_code|custom`',
    `grp_contracted` DECIMAL(18,2) COMMENT 'The total Gross Rating Points (GRP) contracted for this placement, applicable to broadcast TV, radio, and OOH buys. GRP = Reach% × Frequency. Used for broadcast media planning, Nielsen audience measurement reconciliation, and post-buy analysis. Null for digital-only placements.',
    `is_guaranteed_inventory` BOOLEAN COMMENT 'Flag indicating whether this placement is sold as guaranteed inventory (direct buy) versus non-guaranteed (programmatic auction).',
    `is_makegood` BOOLEAN COMMENT 'Indicates whether this placement was created as a make-good (compensatory placement) to replace under-delivered or cancelled inventory from a prior placement. Make-goods are tracked separately for financial reconciliation and vendor performance management.',
    `is_programmatic_eligible` BOOLEAN COMMENT 'Flag indicating whether this placement is available for programmatic buying through Demand-Side Platforms (DSP) and Supply-Side Platforms (SSP).',
    `makegood_policy` STRING COMMENT 'Publisher policy for makegoods (compensatory ad delivery) when this placement underdelivers against contracted impressions or performance benchmarks.',
    `net_contracted_value` DECIMAL(18,2) COMMENT 'The net monetary value of this placement after deducting agency commission from the gross contracted value. Represents the actual cost remitted to the media vendor. Part of the MONETARY_TRIPLET net total.',
    `placement_code` STRING COMMENT 'External business identifier or SKU for the placement position, used in media planning and buying systems.',
    `placement_name` STRING COMMENT 'Human-readable name describing the placement position (e.g., Homepage Leaderboard, In-Stream Pre-Roll, Sidebar Rectangle, Sponsored Post Slot).',
    `placement_status` STRING COMMENT 'Current lifecycle status of the placement position in inventory management.. Valid values are `active|inactive|pending|suspended|archived`',
    `placement_type` STRING COMMENT 'Classification of the placement format type according to IAB standards. [ENUM-REF-CANDIDATE: display|video|native|audio|sponsored_content|interstitial|overlay|banner|rich_media — 9 candidates stripped; promote to reference product]',
    `position` STRING COMMENT 'The specific position or placement location within the site, broadcast, or publication (e.g., above-the-fold, pre-roll, homepage takeover, run-of-site). Directly impacts CPM rate, viewability, and audience engagement. [ENUM-REF-CANDIDATE: above_the_fold|below_the_fold|pre_roll|mid_roll|post_roll|homepage|run_of_site|run_of_network — promote to reference product]',
    `position_type` STRING COMMENT 'Specific position classification within the property page or content stream, critical for viewability and engagement benchmarks. [ENUM-REF-CANDIDATE: above_fold|below_fold|in_stream|pre_roll|mid_roll|post_roll|sidebar|footer|header|interstitial|native_feed|sponsored_tile — 12 candidates stripped; promote to reference product]',
    `rate_type` STRING COMMENT 'The pricing model applied to this placement: Cost Per Mille (CPM), Cost Per Click (CPC), Cost Per Acquisition (CPA), Cost Per View (CPV), flat fee, Gross Rating Point (GRP), or Target Rating Point (TRP). Determines how contracted units are measured and billed. [ENUM-REF-CANDIDATE: cpm|cpc|cpa|cpv|flat|grp|trp — 7 candidates stripped; promote to reference product]',
    `site_name` STRING COMMENT 'The name of the specific website, TV station, radio station, publication, or network where the ad will run (e.g., CNN.com, NBC Nightly News, The New York Times). Represents the RESOURCE_REFERENCE for the media property being purchased.',
    `targeting_parameters` STRING COMMENT 'Descriptive summary of the audience and contextual targeting criteria applied to this placement (e.g., Adults 25-54, HHI $75K+, Interest: Auto, Geo: US-NY). Captures demographic, geographic, behavioral, and contextual targeting as configured in The Trade Desk or Google CM360. Free-text summary for operational reference.',
    `third_party_verification_required` BOOLEAN COMMENT 'Flag indicating whether third-party verification tags (viewability, brand safety, fraud detection) are required for this placement.',
    `trafficking_notes` STRING COMMENT 'Free-text operational notes entered by the ad operations team during trafficking in Google Campaign Manager 360, including special instructions, creative rotation rules, technical requirements, or vendor-specific delivery notes.',
    `trafficking_status` STRING COMMENT 'Current operational status of the placement in the ad trafficking workflow. Tracks the placement lifecycle from initial setup through live delivery to completion. [ENUM-REF-CANDIDATE: draft|pending_trafficking|trafficked|live|paused|completed|cancelled — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this media placement record was last modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Serves as the RECORD_AUDIT_UPDATED field. Tracks changes to placement details, rates, or trafficking status throughout the campaign lifecycle.',
    `vast_tag_required` BOOLEAN COMMENT 'Flag indicating whether this placement requires VAST tag implementation for video ad serving.',
    `viewability_rate_benchmark_pct` DECIMAL(18,2) COMMENT 'Historical or guaranteed viewability rate benchmark for this placement, measured per Media Rating Council (MRC) standards.',
    `viewability_target_pct` DECIMAL(18,2) COMMENT 'The minimum viewability percentage contracted or targeted for this digital placement, per MRC viewability standards (e.g., 70% viewable impressions). Used to set vendor accountability thresholds and trigger make-good provisions in the IO.',
    `vpaid_supported` BOOLEAN COMMENT 'Flag indicating whether this placement supports VPAID interactive video ad units.',
    CONSTRAINT pk_media_placement PRIMARY KEY(`media_placement_id`)
) COMMENT 'Operational record representing a specific ad placement purchased from a media vendor — the atomic unit of a media buy. Captures placement name, ad unit size/format, channel type, vendor/publisher, site/station/network, position, targeting parameters, flight start/end dates, contracted units, contracted impressions, rate type (CPM, CPC, CPA, flat), contracted rate, total contracted value, trafficking status, and ad server placement ID from Google Campaign Manager 360. Links to insertion order and media plan line.';

CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`buy` (
    `buy_id` BIGINT COMMENT 'Unique system-generated identifier for the media buy record. Primary key for this transactional entity. TRANSACTION_HEADER role — represents the discrete business event of committing agency/client spend to a specific media vehicle.',
    `ad_channel_id` BIGINT COMMENT 'Foreign key linking to media.ad_channel. Business justification: buy currently has channel as a STRING attribute. buy is the transactional purchase event, and each buy is for a specific advertising channel (e.g., Display, Video, Search). While buy → media_placement',
    `ad_format_id` BIGINT COMMENT 'Foreign key linking to media.ad_format. Business justification: buy currently has format as a STRING attribute. Each buy is for a specific ad format (e.g., 300x250 Banner, Pre-roll Video). This FK normalizes the buy-to-format relationship, replacing the string att',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Media buys execute against defined audience targets for delivery and measurement. Buyers negotiate rates and inventory based on specific segment reach and composition. Essential for buy reconciliation',
    `worker_id` BIGINT COMMENT 'Foreign key linking to talent.worker. Business justification: Media buys must track the specific buyer who negotiated rates, executed the purchase, and owns vendor relationships. Essential for performance reviews, commission tracking, and vendor relationship man',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Media buys require cost center for expense tracking, financial reconciliation, and variance reporting - core financial control requirement.',
    `creative_asset_id` BIGINT COMMENT 'Foreign key linking to creative.creative_asset. Business justification: Buyers need to know which creative asset will run in each buy for trafficking instructions, publisher spec validation, and delivery verification. Critical for makegood and reconciliation processes.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Media buys must reference budgets for spend tracking, variance analysis, and budget compliance monitoring in financial management.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Media buys roll up to initiatives for consolidated financial tracking. Required for initiative-level ROI analysis, strategic performance measurement, and cross-campaign budget reconciliation in agency',
    `media_insertion_order_id` BIGINT COMMENT 'Reference to the authorizing Insertion Order (IO) under which this media buy is executed. Links the buy to its contractual authorization and spend ceiling.',
    `media_placement_id` BIGINT COMMENT 'Reference to the specific media placement or ad unit being purchased (e.g., a specific ad slot, daypart, or digital placement). Links to the placement master in the media domain.',
    `plan_line_id` BIGINT COMMENT 'Reference to the specific media plan line item this buy executes against. Ties the transactional buy back to the approved media plan for reconciliation and pacing.',
    `programmatic_deal_id` BIGINT COMMENT 'Foreign key linking to media.programmatic_deal. Business justification: buy is the transactional record of a media purchase. While buy → plan_line → programmatic_deal path exists, many buys are directly associated with a specific programmatic deal (PMP, programmatic guara',
    `supplier_id` BIGINT COMMENT 'Reference to the media vendor or publisher from whom the media inventory is purchased (e.g., broadcast network, digital publisher, OOH operator). Maps to the vendor master.',
    `trafficking_instruction_id` BIGINT COMMENT 'Google Campaign Manager 360 (CM360) placement or ad trafficking identifier assigned during ad trafficking. Links the media buy to the ad server delivery record for impression tracking and reporting.',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vendor_contract. Business justification: Media buys execute under vendor contracts establishing pricing, payment terms, and SLAs. Procurement and finance require this link for contract compliance verification, spend tracking against committe',
    `added_value_flag` BOOLEAN COMMENT 'Indicates whether this buy includes added-value inventory (bonus impressions, sponsored content, or value-add placements) negotiated as part of the overall media deal at no incremental cost to the client.',
    `agency_commission_amount` DECIMAL(18,2) COMMENT 'Agency commission deducted from the gross buy amount, typically 15% of gross per industry standard. Represents the agencys compensation component embedded in the media buy.',
    `authorized_spend_ceiling` DECIMAL(18,2) COMMENT 'Maximum spend amount authorized for this media buy as approved on the Insertion Order or client budget authorization. Acts as a financial control limit; actual spend must not exceed this value.',
    `booked_units` DECIMAL(18,2) COMMENT 'Quantity of media delivery units contracted in this buy (e.g., number of impressions, GRPs, TRPs, clicks, or spots). The unit type is defined by the rate_basis field. Used for pacing and delivery reconciliation.',
    `buy_date` DATE COMMENT 'The principal real-world business event date on which the media buy was executed — i.e., the date the agency committed spend to the media vehicle. Distinct from system audit timestamps.',
    `buy_number` STRING COMMENT 'Externally-known alphanumeric identifier for the media buy, used in communications with vendors, on Insertion Orders, and in billing reconciliation. Corresponds to the buy reference number in Mediaocean Prisma.',
    `buy_status` STRING COMMENT 'Current workflow lifecycle state of the media buy. Drives operational actions: pending = awaiting vendor confirmation; confirmed = vendor-accepted and active; cancelled = buy voided; paused = temporarily halted; completed = delivery fulfilled.. Valid values are `pending|confirmed|cancelled|paused|completed`',
    `buy_type` STRING COMMENT 'Classification of the buying modality used to acquire this media inventory. Upfront = advance commitment; scatter = opportunistic spot market; programmatic RTB = real-time bidding via DSP; direct = direct IO with publisher; retail media = retail media network purchase; CTV addressable = addressable CTV/OTT buy.. Valid values are `upfront|scatter|programmatic_rtb|direct|retail_media|ctv_addressable`',
    `cancellation_date` DATE COMMENT 'Date on which this media buy was cancelled, if applicable. Populated only when buy_status = cancelled. Used for cancellation liability calculations and vendor notification tracking.',
    `cancellation_reason` STRING COMMENT 'Reason code for the cancellation of this media buy. Required when buy_status = cancelled to support financial liability assessment and vendor relationship management.. Valid values are `client_request|budget_cut|campaign_change|vendor_default|force_majeure|other`',
    `created_timestamp` TIMESTAMP COMMENT 'System audit timestamp recording when this media buy record was first created in the data platform. Used for data lineage, SLA tracking, and audit compliance.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the buy amounts are denominated (e.g., USD, GBP, EUR). Required for multi-currency campaign management and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `delivery_status` STRING COMMENT 'Current state of media inventory delivery against the booked buy. Tracks whether the vendor has fulfilled the contracted impressions, GRPs, or other delivery units. Underdelivery triggers makegoods; overdelivery may require credit memos.. Valid values are `not_started|in_delivery|underdelivered|fully_delivered|overdelivered`',
    `flight_end_date` DATE COMMENT 'The date on which media delivery for this buy is scheduled to conclude. Defines the end of the active delivery window. Used for pacing, reconciliation, and billing cutoff.',
    `flight_start_date` DATE COMMENT 'The date on which media delivery for this buy is scheduled to begin. Defines the start of the active delivery window (flight period) for trafficking and scheduling purposes.',
    `gross_buy_amount` DECIMAL(18,2) COMMENT 'Total gross value of the media buy before agency commission, discounts, or adjustments. Represents the full billing value to the vendor as stated on the Insertion Order.',
    `makegood_flag` BOOLEAN COMMENT 'Indicates whether this media buy is a makegood — compensatory inventory provided by the vendor to remedy underdelivery or audience guarantee shortfalls on a prior buy. True = this is a makegood buy.',
    `market_type` STRING COMMENT 'Broadcast market commitment classification. Upfront = advance season commitment at negotiated rates; scatter = opportunistic in-season purchase at prevailing market rates; makeweight = inventory added to fulfill audience delivery guarantees (GRP/TRP shortfall).. Valid values are `upfront|scatter|makeweight`',
    `negotiated_rate` DECIMAL(18,2) COMMENT 'The unit rate negotiated with the vendor for this media buy, expressed in the applicable rate basis (e.g., CPM, CPC, CPA, GRP cost). This is the commercially sensitive contracted rate, distinct from rate card pricing.',
    `net_buy_amount` DECIMAL(18,2) COMMENT 'Net cost of the media buy after deducting agency commission from the gross amount. Represents the actual vendor payment obligation. Net = Gross minus Agency Commission.',
    `notes` STRING COMMENT 'Free-text field for buyer annotations, special deal terms, negotiation notes, or operational instructions associated with this media buy. Not used for structured data.',
    `prisma_buy_code` STRING COMMENT 'Source system identifier for this buy record in Mediaocean Prisma, the system of record for media planning, buying, and billing. Used for system-of-record traceability and reconciliation.',
    `rate_basis` STRING COMMENT 'The pricing metric on which the negotiated rate is denominated. CPM = Cost Per Mille (thousand impressions); CPC = Cost Per Click; CPA = Cost Per Acquisition; GRP = Gross Rating Point cost; flat = fixed fee; CPCV = Cost Per Completed View; vCPM = viewable CPM. [ENUM-REF-CANDIDATE: cpm|cpc|cpa|grp|flat|cpcv|vcpm — 7 candidates stripped; promote to reference product]',
    `reconciliation_status` STRING COMMENT 'Current state of the financial reconciliation process for this media buy. Tracks whether vendor invoices have been matched against booked buy amounts. Unreconciled = not yet matched; in_progress = reconciliation underway; reconciled = fully matched; disputed = discrepancy under review; written_off = irreconcilable variance closed.. Valid values are `unreconciled|in_progress|reconciled|disputed|written_off`',
    `updated_timestamp` TIMESTAMP COMMENT 'System audit timestamp recording when this media buy record was last modified. Supports change tracking, reconciliation workflows, and data quality monitoring.',
    `upfront_deal_year` STRING COMMENT 'Broadcast season year reference for upfront market commitments (e.g., 2024-2025). Identifies the upfront buying cycle to which this buy belongs, enabling season-level budget tracking and audience guarantee management.. Valid values are `^[0-9]{4}-[0-9]{4}$`',
    CONSTRAINT pk_buy PRIMARY KEY(`buy_id`)
) COMMENT 'Transactional record capturing the execution of a media purchase — the business event of committing agency/client spend to a specific media vehicle against an authorized IO and plan line. Captures buy date, buyer name, vendor, channel, buy type (upfront, scatter, programmatic RTB, direct, retail media network, CTV/OTT addressable), buy status (pending, confirmed, cancelled), negotiated rate, total buy value, authorized spend ceiling, DSP/SSP reference (The Trade Desk deal ID for programmatic), market type (upfront commitment/scatter opportunistic/makeweight), upfront deal year reference for broadcast, and reconciliation status. Supports all buying modalities including traditional broadcast (linear, addressable), digital direct, programmatic (display, video, CTV, audio), and emerging retail media network purchases.';

CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`programmatic_deal` (
    `programmatic_deal_id` BIGINT COMMENT 'Unique surrogate identifier for the programmatic deal record in the lakehouse Silver layer. Entity role: MASTER_AGREEMENT — governs a binding programmatic inventory commitment between the agency/advertiser and a DSP/SSP/exchange/retailer.',
    `ad_channel_id` BIGINT COMMENT 'Foreign key linking to media.ad_channel. Business justification: programmatic_deal currently has channel as a STRING attribute. Programmatic deals are negotiated for specific advertising channels (e.g., Programmatic Display deal, CTV deal). This FK normalizes the d',
    `ad_format_id` BIGINT COMMENT 'Foreign key linking to media.ad_format. Business justification: programmatic_deal currently has ad_format as a STRING attribute. Programmatic deals specify the ad format for the deal inventory (e.g., 300x250 Banner, Pre-roll Video). This FK normalizes the deal-to-',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser (client brand) on whose behalf this programmatic deal is negotiated and executed. Used for client-level reporting, billing, and competitive conflict checks.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Programmatic deals (PMP/PG) are negotiated for specific audience segments with publishers and SSPs. Deal setup, activation, and performance measurement require explicit segment linkage for targeting c',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Programmatic deals require brand safety tier, content category restrictions, and compliance rules from brand profile. Essential for deal setup, brand safety configuration, and automated bidding strate',
    `campaign_id` BIGINT COMMENT 'Reference to the parent advertising campaign under which this programmatic deal is executed. Links the deal to campaign-level objectives, KPIs, and budget in Google Campaign Manager 360 and The Trade Desk.',
    `publisher_id` BIGINT COMMENT 'Unique identifier for the publisher as assigned by the SSP, exchange, or DSP platform. Used for supply path optimization, publisher-level reconciliation, and cross-platform publisher deduplication.',
    `publisher_property_id` BIGINT COMMENT 'Foreign key linking to media.publisher_property. Business justification: programmatic_deal currently has FK to publisher (parent entity). Many programmatic deals are property-specific (e.g., deal for NYTimes.com homepage, deal for WSJ Mobile App). While programmatic_deal →',
    `ssp_platform_id` BIGINT COMMENT 'Foreign key linking to media.ssp_platform. Business justification: programmatic_deal currently has ssp_exchange as a STRING attribute. Programmatic deals are negotiated with specific SSP platforms (e.g., deal negotiated with Google Ad Manager, Rubicon Project). This ',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vendor_contract. Business justification: Programmatic deals with DSPs/SSPs are governed by master vendor contracts. Legal and procurement need this link to verify deal terms comply with master agreement provisions and for audit trail require',
    `brand_safety_tier` STRING COMMENT 'Brand safety classification applied to this deal, determining content adjacency restrictions and inventory quality controls. Configured per TAG (Trustworthy Accountability Group) Brand Safety standards and enforced via The Trade Desk and Google Campaign Manager 360.. Valid values are `standard|conservative|custom|none`',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total monetary budget allocated to this programmatic deal in the deal currency. For PG deals, calculated as floor_cpm × impression_commitment / 1000. Used for financial planning, budget pacing, and P&L reconciliation in SAP S/4HANA and Mediaocean Prisma.',
    `closed_loop_measurement` BOOLEAN COMMENT 'Indicates whether closed-loop measurement (linking ad exposure to purchase/conversion outcomes) is available for this deal. Particularly relevant for Retail Media Network (RMN) deals (Amazon DSP, Walmart Connect, Instacart Ads) where purchase data enables attribution. True = closed-loop measurement available.',
    `created_timestamp` TIMESTAMP COMMENT 'Audit timestamp when this programmatic deal record was first created in the source system (The Trade Desk, Amazon DSP, or Mediaocean Prisma). Used for data lineage and audit trail.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary values on this deal (floor CPM, budget, etc.). Defaults to USD for most programmatic deals but supports multi-currency for international campaigns.. Valid values are `^[A-Z]{3}$`',
    `deal_code` STRING COMMENT 'Externally-known deal identifier assigned by the DSP or SSP/exchange (e.g., The Trade Desk deal ID, Amazon DSP deal ID). Used for trafficking, bid requests, and reconciliation across platforms. Maps to the deal_id field in The Trade Desk and OpenRTB bid-request objects.',
    `deal_name` STRING COMMENT 'Human-readable name of the programmatic deal as entered in the DSP or Mediaocean Prisma. Used for identification in media plans, trafficking sheets, and reporting dashboards.',
    `deal_source_system` STRING COMMENT 'The operational system of record from which this programmatic deal record was sourced. Used for data lineage, reconciliation, and ETL pipeline routing. Drives system-specific field mapping in the Silver layer ingestion process. [ENUM-REF-CANDIDATE: the_trade_desk|amazon_dsp|google_cm360|mediaocean_prisma|walmart_dsp|instacart_ads|other — 7 candidates stripped; promote to reference product]',
    `deal_status` STRING COMMENT 'Current lifecycle state of the programmatic deal. Draft = in negotiation; Pending Approval = submitted for internal/publisher approval; Active = live and eligible for bidding; Paused = temporarily suspended; Expired = past end date; Cancelled = terminated before end date.. Valid values are `draft|pending_approval|active|paused|expired|cancelled`',
    `deal_type` STRING COMMENT 'Classification of the programmatic deal structure. PMP (Private Marketplace) = curated invite-only auction; Preferred Deal = fixed CPM, non-guaranteed; Programmatic Guaranteed (PG) = fixed CPM with impression commitment; Open Auction = RTB open exchange; Retailer PMP = retailer-specific private marketplace (e.g., Amazon DSP, Walmart Connect). [ENUM-REF-CANDIDATE: pmp|preferred_deal|programmatic_guaranteed|open_auction|retailer_pmp — promote to reference product if additional types emerge]. Valid values are `pmp|preferred_deal|programmatic_guaranteed|open_auction|retailer_pmp`',
    `dsp_platform` STRING COMMENT 'The Demand-Side Platform (DSP) through which this programmatic deal is executed and managed. Identifies the buying platform for trafficking, reporting, and reconciliation. [ENUM-REF-CANDIDATE: the_trade_desk|amazon_dsp|dv360|xandr|mediamath|walmart_dsp|instacart_ads|other — promote to reference product]',
    `end_date` DATE COMMENT 'The date on which the programmatic deal expires and is no longer eligible for bidding. Nullable for evergreen deals with no fixed end. Used for pacing, reconciliation, and deal renewal workflows.',
    `environment_type` STRING COMMENT 'The technical environment in which the ad inventory is served (web browser, mobile app, CTV device, DOOH screen, audio stream). Determines applicable measurement standards, viewability metrics, and brand safety controls.. Valid values are `web|app|ctv|dooh|audio`',
    `external_deal_ref` STRING COMMENT 'Secondary external reference identifier for this deal as recorded in a partner system (e.g., publisher deal ID, SSP deal reference, Mediaocean Prisma order number). Enables cross-system reconciliation and deduplication.',
    `floor_cpm` DECIMAL(18,2) COMMENT 'The minimum Cost Per Mille (CPM) bid price in USD required to win impressions under this deal. For PMP and Preferred Deals, this is the negotiated floor; for PG deals, this is the fixed CPM. Critical for bid strategy configuration in The Trade Desk and financial forecasting.',
    `frequency_cap` STRING COMMENT 'Maximum number of times a unique user/device may be served an ad under this deal within the frequency cap period. Configured in The Trade Desk to control ad fatigue and optimize audience reach. Null indicates no frequency cap applied.',
    `frequency_cap_period` STRING COMMENT 'The time window over which the frequency cap applies (hourly, daily, weekly, monthly, or lifetime of the deal). Used in conjunction with frequency_cap to configure audience exposure limits in The Trade Desk.. Valid values are `hourly|daily|weekly|monthly|lifetime`',
    `geo_targeting` STRING COMMENT 'Geographic targeting scope for this deal, expressed as country codes, DMA regions, or postal codes (e.g., USA, USA:DMA:501, GBR). Drives geo-based audience segmentation and regulatory compliance (GDPR for EU inventory, CCPA for California).',
    `impression_commitment` BIGINT COMMENT 'The total number of impressions committed under this deal. Mandatory for Programmatic Guaranteed (PG) deals where delivery is contractually obligated. For PMP and Preferred Deals, represents the estimated or target impression volume. Used for pacing, delivery forecasting, and make-good calculations.',
    `io_number` STRING COMMENT 'The Insertion Order (IO) number associated with this programmatic deal, linking it to the formal media buy authorization. Used for financial reconciliation in Mediaocean Prisma and SAP S/4HANA, and for audit trail to the client-approved media plan.',
    `negotiated_timestamp` TIMESTAMP COMMENT 'The real-world business event timestamp when the programmatic deal was formally agreed/struck between the buyer and seller. Distinct from the record audit created timestamp. Used for deal velocity reporting and SLA tracking.',
    `notes` STRING COMMENT 'Free-text field for capturing deal-specific negotiation notes, special terms, publisher commitments, or operational instructions not captured in structured fields. Used by media buyers and account managers for deal context.',
    `rtb_bid_strategy` STRING COMMENT 'The Real-Time Bidding (RTB) bid strategy configured in the DSP for this deal. Fixed CPM is standard for PG deals; Dynamic CPM and performance-based strategies (Target CPA, Target ROAS) apply to PMP and open auction deals. Configured in The Trade Desk Bid Management module.. Valid values are `fixed_cpm|dynamic_cpm|target_cpa|target_roas|max_impressions`',
    `shopper_data_enabled` BOOLEAN COMMENT 'Indicates whether retailer shopper/purchase data is used for audience targeting in this deal. Applicable to Retail Media Network (RMN) deals on Amazon DSP, Walmart Connect, and Instacart Ads. True = first-party shopper data targeting is active.',
    `start_date` DATE COMMENT 'The date on which the programmatic deal becomes active and eligible for bidding. Corresponds to the deal flight start in The Trade Desk and Mediaocean Prisma. Used for media plan scheduling and budget pacing.',
    `updated_timestamp` TIMESTAMP COMMENT 'Audit timestamp when this programmatic deal record was last modified in the source system. Used for incremental ETL processing and change tracking.',
    `viewability_threshold_pct` DECIMAL(18,2) COMMENT 'Minimum viewability rate (as a percentage) required for impressions under this deal to be counted as valid. Defined per MRC viewability standards (50% of pixels in view for 1 second for display; 50% for 2 seconds for video). Used for deal quality scoring and billing reconciliation.',
    CONSTRAINT pk_programmatic_deal PRIMARY KEY(`programmatic_deal_id`)
) COMMENT 'Master record for programmatic media deals negotiated with DSPs, SSPs, exchanges, and retail media networks — including Private Marketplace (PMP) deals, Preferred Deals, Programmatic Guaranteed (PG) deals, and retailer-specific programmatic inventory (Amazon DSP, Walmart Connect, Instacart Ads). Captures deal ID (The Trade Desk deal ID, Amazon DSP deal ID), deal name, deal type (PMP, PG, open auction, retailer PMP), DSP platform, SSP/exchange/retailer, publisher, CPM floor price, deal start/end dates, impression commitment, targeting parameters (including shopper/purchase data for RMN), deal status, RTB bid strategy, and closed-loop measurement availability flag. Sourced from The Trade Desk, Amazon DSP, and other programmatic platforms.';

CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`schedule` (
    `schedule_id` BIGINT COMMENT 'Unique surrogate identifier for the media schedule record. Primary key for the media_schedule data product in the Databricks Silver Layer.',
    `ad_channel_id` BIGINT COMMENT 'Foreign key linking to media.ad_channel. Business justification: schedule currently has channel_type as a STRING attribute. schedule is the detailed airing/delivery schedule for purchased media placements. Each schedule is for a specific advertising channel. While ',
    `ad_format_id` BIGINT COMMENT 'Foreign key linking to media.ad_format. Business justification: schedule currently has ad_unit_format as a STRING attribute. Each schedule specifies the ad format for delivery (e.g., 30-second TV spot, 300x250 Banner). This FK normalizes the schedule-to-format rel',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Schedules define when and where ads run against specific audience segments for daypart and vehicle optimization. Planners use segment linkage for reach/frequency modeling and flighting strategy by aud',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Schedules execute creative rotation for specific brands. Brand profile provides creative guidelines, tone requirements, market applicability, and daypart strategy for trafficking and creative rotation',
    `campaign_id` BIGINT COMMENT 'Reference to the parent advertising campaign under which this media schedule is executed. Enables campaign-level roll-up of all scheduled media activity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Scheduled media requires cost center for accrual posting and expense recognition timing in financial close processes.',
    `creative_asset_id` BIGINT COMMENT 'Reference to the primary creative asset assigned to this media schedule slot. For rotation schedules, this represents the default or primary creative. Links to the creative master record.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Schedules execute initiative-level media strategies. Linking enables initiative performance dashboards, strategic flight pattern analysis, and cross-campaign reach/frequency optimization required for ',
    `media_insertion_order_id` BIGINT COMMENT 'Reference to the Insertion Order (IO) that authorises the purchase of this scheduled media. The IO is the contractual document between the advertiser/agency and the media vendor.',
    `media_placement_id` BIGINT COMMENT 'Reference to the media placement this schedule governs — the specific ad unit slot purchased on a publisher property. Links to the placement master record.',
    `programmatic_deal_id` BIGINT COMMENT 'Unique deal identifier for programmatic guaranteed or private marketplace (PMP) transactions, as assigned by the Supply-Side Platform (SSP) or publisher. Used to activate and reconcile programmatic deals in The Trade Desk DSP.',
    `worker_id` BIGINT COMMENT 'Foreign key linking to talent.worker. Business justification: Schedules require a responsible trafficker for ad server configuration, creative assignment, and delivery verification. Critical for workload management, quality control, and resolving trafficking iss',
    `ad_duration_seconds` STRING COMMENT 'Length of the ad creative in seconds, applicable to broadcast TV, radio, CTV/OTT, and digital video formats (e.g., 15, 30, 60). Used for broadcast trafficking, pod position management, and VAST/VPAID configuration.',
    `air_end_time` TIMESTAMP COMMENT 'Precise date-time at which the ad unit is scheduled to stop airing or delivering on a given occurrence. Used alongside air_start_time to define the exact delivery window.',
    `air_start_time` TIMESTAMP COMMENT 'Precise date-time at which the ad unit is scheduled to begin airing or delivering on a given occurrence. Critical for broadcast trafficking and programmatic deal scheduling. Stored in ISO 8601 format with timezone offset.',
    `buying_type` STRING COMMENT 'Method by which the media inventory was purchased — direct IO, programmatic guaranteed, private marketplace (PMP) deal, open exchange, or Real-Time Bidding (RTB). Determines trafficking path and reconciliation process.. Valid values are `direct|programmatic_guaranteed|private_marketplace|open_exchange|rtb`',
    `cpm_rate` DECIMAL(18,2) COMMENT 'Negotiated Cost Per Mille (CPM) — the cost per 1,000 ad impressions for this scheduled placement. Primary pricing metric for digital and programmatic media. Used for rate card benchmarking and reconciliation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this media schedule record was first created in the source system. Provides the audit creation anchor for the record lifecycle and supports data lineage tracking in the Databricks Silver Layer.',
    `creative_rotation_type` STRING COMMENT 'Instruction governing how multiple creative assets are rotated across scheduled impressions — even (equal distribution), weighted (percentage-based), sequential (ordered), or optimised (performance-driven). Trafficked into Google Campaign Manager 360.. Valid values are `even|weighted|sequential|optimised`',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the net and gross cost amounts on this media schedule (e.g., USD, GBP, EUR). Enables multi-currency media buying and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `daypart` STRING COMMENT 'Nielsen standard daypart classification indicating the time-of-day segment in which the ad is scheduled to air. Drives audience composition, CPM pricing, and GRP/TRP calculations. Values follow Nielsen daypart definitions. [ENUM-REF-CANDIDATE: early_morning|daytime|early_fringe|prime_access|prime|late_news|late_night|overnight|weekend — promote to reference product]',
    `dma_code` STRING COMMENT 'Nielsen-assigned three-digit numeric code identifying the Designated Market Area (DMA) for broadcast and local media scheduling. Enables standardised geographic audience measurement and GRP/TRP reporting.. Valid values are `^[0-9]{3}$`',
    `flight_end_date` DATE COMMENT 'The last calendar date on which ads are scheduled to air or deliver under this media schedule. Defines the closing boundary of the campaign flight period.',
    `flight_start_date` DATE COMMENT 'The first calendar date on which ads are scheduled to air or deliver under this media schedule. Defines the opening boundary of the campaign flight period.',
    `frequency_cap` STRING COMMENT 'Maximum number of times a unique user or household may be served this ad within the defined frequency cap period. Controls ad fatigue and audience experience. Trafficked into Google Campaign Manager 360 and The Trade Desk.',
    `frequency_cap_period` STRING COMMENT 'Time window over which the frequency cap applies — hour, day, week, month, or lifetime of the campaign. Works in conjunction with frequency_cap to define the full frequency capping rule.. Valid values are `hour|day|week|month|lifetime`',
    `gross_cost` DECIMAL(18,2) COMMENT 'Gross cost of the scheduled media buy before agency commission deduction, expressed in the billing currency. Represents the full rate card value billed by the media vendor.',
    `is_makegood` BOOLEAN COMMENT 'Flag indicating whether this schedule record represents a make-good — a compensatory placement provided by the media vendor to offset an under-delivery or missed airing from a prior schedule. Critical for reconciliation and vendor performance tracking.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this media schedule record was most recently modified in the source system or the Silver Layer. Used for incremental data loading, change detection, and audit trail. Stored in ISO 8601 format with timezone offset.',
    `market_name` STRING COMMENT 'Geographic market or Designated Market Area (DMA) where the media will air or be delivered — e.g., New York, Los Angeles, National. Used for local vs. national media planning and GRP/TRP calculations.',
    `net_cost` DECIMAL(18,2) COMMENT 'Net cost of the scheduled media buy after agency commission and negotiated discounts, expressed in the billing currency. Used for budget management, P&L reporting, and financial reconciliation in SAP S/4HANA.',
    `pod_position` STRING COMMENT 'Requested or guaranteed position of the ad within a commercial break pod for broadcast TV, radio, and CTV/OTT channels. First and last pod positions command premium pricing. Null for non-broadcast channels.. Valid values are `first|second|third|last|any`',
    `preemptible` BOOLEAN COMMENT 'Flag indicating whether this scheduled placement can be preempted by a higher-paying advertiser. Preemptible spots are typically priced lower than guaranteed placements. Relevant for broadcast and premium digital inventory.',
    `schedule_name` STRING COMMENT 'Human-readable name assigned to this media schedule record, typically reflecting the campaign flight, channel, and market (e.g., Q3_BrandLaunch_PrimeTV_NYC). Used for trafficking and reporting identification.',
    `schedule_number` STRING COMMENT 'Externally-known alphanumeric reference number for this schedule, as assigned by the media planning system (Mediaocean Prisma) or trafficking system (Google Campaign Manager 360). Used for cross-system reconciliation.',
    `scheduled_grp` DECIMAL(18,2) COMMENT 'Total Gross Rating Points (GRP) planned for this media schedule, representing the sum of ratings across all scheduled airings. GRP = Reach % × Frequency. Used for broadcast media planning and audience delivery measurement.',
    `scheduled_impressions` BIGINT COMMENT 'Total number of ad impressions contracted and scheduled for delivery under this media schedule record for the defined flight period. Used for pacing, delivery tracking, and reconciliation against actuals.',
    `scheduled_trp` DECIMAL(18,2) COMMENT 'Total Target Rating Points (TRP) planned for this media schedule, measuring GRP delivery against a specific target audience demographic. TRP is the audience-qualified subset of GRP used for precision media planning.',
    `scheduled_units` STRING COMMENT 'Number of discrete ad units (spots, insertions, or placements) scheduled for the flight period — applicable to broadcast (spots), print (insertions), and OOH (faces/panels). Distinct from impressions which measure audience exposure.',
    `source_system_ref` STRING COMMENT 'Native record identifier from the originating operational system — Google Campaign Manager 360 placement ID or Mediaocean Prisma schedule line number. Enables traceability and reconciliation back to the system of record.',
    `trafficking_notes` STRING COMMENT 'Free-text field for trafficking instructions, special placement requirements, or operational notes associated with this media schedule — e.g., Run adjacent to news content only, Avoid competitor adjacency. Sourced from Google Campaign Manager 360 trafficking comments.',
    `trafficking_status` STRING COMMENT 'Current operational status of this media schedule in the trafficking workflow. Tracks progression from initial planning through creative assignment, trafficking into ad server, live delivery, and completion or cancellation. Sourced from Google Campaign Manager 360. [ENUM-REF-CANDIDATE: draft|pending_creative|trafficked|live|paused|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `vehicle_name` STRING COMMENT 'Name of the specific media vehicle (publisher, network, station, or platform) where the ad will be delivered — e.g., NBC Primetime, New York Times Digital, Spotify, Clear Channel OOH. Sourced from Mediaocean Prisma publisher library.',
    CONSTRAINT pk_schedule PRIMARY KEY(`schedule_id`)
) COMMENT 'Operational master record representing the detailed airing/delivery schedule for purchased media placements — specifying exactly when and where ads will run across all channels. Captures schedule name, channel/vehicle, market/DMA, scheduled air dates and times, daypart classification (early morning, daytime, prime, late night, overnight, weekend), ad unit/format, creative rotation instructions, pod position (for broadcast), scheduled impressions/units per period, frequency cap, trafficking status, and last-updated timestamp. Daypart classification follows Nielsen standard daypart definitions. Sourced from Google Campaign Manager 360 trafficking and Mediaocean Prisma scheduling modules.';

CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`trafficking_instruction` (
    `trafficking_instruction_id` BIGINT COMMENT 'Unique system-generated identifier for each ad trafficking instruction record issued to an ad server or media vendor. Serves as the primary key for this transactional entity. ROLE: TRANSACTION_HEADER.',
    `ad_format_id` BIGINT COMMENT 'Foreign key linking to media.ad_format. Business justification: trafficking_instruction currently has ad_format as a STRING attribute. Trafficking instructions specify the ad format for delivery to ad servers (e.g., 300x250 Banner, VAST 4.0 Video). This FK normali',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Trafficking instructions configure ad server targeting parameters for specific audience segments. Ad ops teams require explicit segment linkage to set up DMP/DSP integrations, frequency caps, and audi',
    `campaign_id` BIGINT COMMENT 'Reference to the parent advertising campaign under which this trafficking instruction is issued. Provides campaign-level context for reporting and performance attribution.',
    `creative_asset_id` BIGINT COMMENT 'Reference to the creative asset (banner, video, rich media, etc.) being dispatched via this trafficking instruction. Identifies the specific creative unit to be served at the designated placement.',
    `media_insertion_order_id` BIGINT COMMENT 'Reference to the Insertion Order (IO) authorizing the media buy associated with this trafficking instruction. Provides contractual and financial context for the ad delivery.',
    `media_placement_id` BIGINT COMMENT 'Reference to the media placement for which this trafficking instruction is issued. Links the instruction to the specific ad unit, position, and publisher property where the creative will be delivered.',
    `parent_instruction_trafficking_instruction_id` BIGINT COMMENT 'Reference to the original trafficking instruction that this record revises or cancels. Enables lineage tracking across instruction versions and supports audit of changes to creative delivery parameters.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Trafficking is a deliverable service often specified in SOWs with defined SLAs. Linking instructions to SOWs enables service-level tracking, supports billing for trafficking services, and validates sc',
    `worker_id` BIGINT COMMENT 'Foreign key linking to talent.worker. Business justification: Trafficking instructions must track who created and sent them for accountability, revision tracking, and issue resolution. Essential for audit trails and operational handoffs. Replaces denormalized tr',
    `ad_server` STRING COMMENT 'Name of the ad serving platform to which this trafficking instruction is dispatched. Identifies the technology stack responsible for delivering the creative asset to the designated placement. Primary system is Google Campaign Manager 360.. Valid values are `Google Campaign Manager 360|The Trade Desk|Sizmek|Flashtalking|Innovid|other`',
    `ad_server_placement_code` STRING COMMENT 'The unique placement tag or code assigned by the ad server (e.g., Google Campaign Manager 360 placement ID) that maps this instruction to the correct ad unit within the ad serving platform. Used for trafficking reconciliation.',
    `brand_safety_provider` STRING COMMENT 'Name of the third-party brand safety and suitability verification provider applied to this trafficking instruction. Ensures ad creative is served only in brand-appropriate content environments per TAG and GARM standards.. Valid values are `DoubleVerify|Integral Ad Science|MOAT|Oracle Contextual|TAG|none`',
    `brand_safety_segment` STRING COMMENT 'Specific brand safety content category or segment classification applied to this instruction (e.g., exclude adult content, exclude fake news, GARM Floor). Defines the content adjacency restrictions enforced during ad delivery.',
    `click_through_url` STRING COMMENT 'The destination URL to which users are redirected upon clicking the served ad creative. Must be validated and approved prior to trafficking. Critical for campaign performance tracking and landing page attribution.. Valid values are `^https?://.+`',
    `confirmed_timestamp` TIMESTAMP COMMENT 'Precise date and time when the ad server or media vendor confirmed receipt and acceptance of the trafficking instruction. Used for SLA compliance measurement and operational reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this trafficking instruction record was first created in the system. Provides the audit trail creation marker for data governance and lineage tracking.',
    `creative_size` STRING COMMENT 'Pixel dimensions of the creative asset being trafficked, expressed as width x height (e.g., 300x250, 728x90, 160x600). Must conform to IAB standard ad unit sizes. Used for placement compatibility validation.. Valid values are `^[0-9]+x[0-9]+$`',
    `daypart_schedule` STRING COMMENT 'Day-of-week and time-of-day scheduling parameters defining when the ad creative should be served (dayparting). Expressed as a structured schedule string (e.g., Mon-Fri 08:00-20:00). Used to optimize delivery timing per media plan.',
    `delivery_end_date` DATE COMMENT 'The scheduled date on which ad creative delivery is to cease per this trafficking instruction. Aligns with the media plan flight end dates and insertion order terms.',
    `delivery_start_date` DATE COMMENT 'The scheduled date on which ad creative delivery is to commence per this trafficking instruction. Aligns with the media plan flight dates and insertion order terms.',
    `device_targeting` STRING COMMENT 'Device type targeting parameters specifying which device categories the ad creative should be served on (e.g., desktop, mobile, tablet, Connected TV (CTV), or all devices). Aligns with media plan targeting specifications.. Valid values are `desktop|mobile|tablet|CTV|all`',
    `frequency_cap_impressions` STRING COMMENT 'Maximum number of times the ad creative may be served to a single unique user within the defined frequency cap period. Controls ad exposure and prevents overexposure to individual users.',
    `frequency_cap_period` STRING COMMENT 'Time window over which the frequency cap impressions limit applies. Defines the reset interval for the per-user impression count (e.g., no more than 3 impressions per day).. Valid values are `hour|day|week|month|lifetime`',
    `geo_targeting` STRING COMMENT 'Geographic targeting parameters applied to this trafficking instruction, specifying the countries, regions, DMAs, or cities where the ad should be served. Expressed as a structured targeting string or comma-separated location codes.',
    `impression_tracking_pixel_url` STRING COMMENT 'URL of the impression tracking pixel fired upon each ad impression to record delivery counts. Used for third-party verification, billing reconciliation, and campaign measurement. May include multiple pixels concatenated or the primary pixel URL.. Valid values are `^https?://.+`',
    `instruction_number` STRING COMMENT 'Externally-known, human-readable reference number for this trafficking instruction, used in communications with ad servers, media vendors, and internal trafficking teams. Typically follows a structured naming convention (e.g., TI-2024-00123).',
    `instruction_status` STRING COMMENT 'Current lifecycle state of the trafficking instruction: pending (created but not yet dispatched), sent (transmitted to ad server or vendor), confirmed (acknowledged by recipient), rejected (refused by recipient), or cancelled (voided before confirmation).. Valid values are `pending|sent|confirmed|rejected|cancelled`',
    `instruction_type` STRING COMMENT 'Classifies the nature of the trafficking instruction: new (initial dispatch of a creative), revision (update to an existing instruction), cancellation (termination of delivery), pause (temporary halt), or resume (restart after pause).. Valid values are `new|revision|cancellation|pause|resume`',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special instructions, or contextual information relevant to this trafficking instruction. Used by ad operations teams to communicate nuances not captured in structured fields.',
    `rejection_reason` STRING COMMENT 'Free-text description of the reason provided by the ad server or media vendor when a trafficking instruction is rejected. Populated only when instruction_status is rejected. Used for troubleshooting and resubmission workflows.',
    `revision_number` STRING COMMENT 'Sequential version number of this trafficking instruction, incremented each time a revision instruction is issued for the same placement and creative combination. Version 1 represents the original instruction.',
    `sent_timestamp` TIMESTAMP COMMENT 'Precise date and time when the trafficking instruction was transmitted to the ad server or media vendor. Used for SLA tracking, audit trails, and delivery timeline analysis.',
    `third_party_verification_required` BOOLEAN COMMENT 'Indicates whether third-party ad verification (e.g., DoubleVerify, Integral Ad Science) is mandated for this trafficking instruction per client or campaign requirements. When true, verification tags must be included in the ad serving setup.',
    `trafficking_date` DATE COMMENT 'The date on which the trafficking instruction was formally issued and dispatched to the ad server or media vendor. Represents the principal real-world business event date for this operational record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this trafficking instruction record was last modified. Tracks revisions to the instruction for audit, compliance, and change management purposes.',
    `vast_tag_url` STRING COMMENT 'The Video Ad Serving Template (VAST) tag URL used for video creative delivery. Provides the ad server with the XML-based instructions for serving video ads, including media file location, tracking events, and companion ads. Applicable for video placements.. Valid values are `^https?://.+`',
    `viewability_tag_url` STRING COMMENT 'URL of the viewability measurement tag embedded in the ad creative to track whether the ad was viewable per MRC and IAB viewability standards (e.g., 50% of pixels in view for 1 continuous second for display). Used for viewability reporting and vendor compliance.. Valid values are `^https?://.+`',
    `vpaid_tag_url` STRING COMMENT 'The Video Player-Ad Interface Definition (VPAID) tag URL enabling interactive video ad execution within the video player environment. Used for rich interactive video creatives requiring player-level communication. Applicable for VPAID-enabled placements.. Valid values are `^https?://.+`',
    CONSTRAINT pk_trafficking_instruction PRIMARY KEY(`trafficking_instruction_id`)
) COMMENT 'Transactional record capturing ad trafficking instructions issued to ad servers and media vendors for creative asset delivery. Captures instruction type (new, revision, cancellation), placement reference, creative asset reference, ad server (Google Campaign Manager 360), VAST/VPAID tag URL, click-through URL, impression tracking pixels, viewability tags, brand safety parameters, trafficking date, trafficker name, and instruction status (pending, sent, confirmed). Represents the operational event of dispatching creative to media.';

CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`sov_benchmark` (
    `sov_benchmark_id` BIGINT COMMENT 'Unique surrogate identifier for each Share of Voice (SOV) benchmark record in the media planning reference master.',
    `ad_channel_id` BIGINT COMMENT 'Foreign key linking to media.ad_channel. Business justification: sov_benchmark currently has channel_type as a STRING attribute. SOV benchmarks capture Share of Voice and competitive media spending intelligence for specific advertising channels (e.g., SOV in Displa',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser or brand whose SOV position is being benchmarked. Links to the advertiser master in the client domain.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Share-of-voice benchmarks are measured and reported against specific audience segments for competitive analysis. Planners use segment-level SOV data to inform budget allocation and channel strategy de',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: SOV benchmarks measure brand performance against competitive set. Brand profile provides SOV tracking configuration, competitive set definition, and target SOV percentages. Core to SOV reporting, comp',
    `benchmark_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this SOV benchmark record, used for cross-system referencing in Nielsen Ad Intel, Comscore, and Mediaocean Prisma.. Valid values are `^SOV-[A-Z0-9]{4,20}$`',
    `benchmark_date` DATE COMMENT 'The date on which this SOV benchmark record was captured or published. Represents the as-of date for the competitive intelligence snapshot, distinct from the measurement period dates.',
    `benchmark_name` STRING COMMENT 'Human-readable label for this benchmark record, typically describing the brand, channel, and measurement period (e.g., Acme Brand — Paid Search — Q1 2024 — National).',
    `benchmark_status` STRING COMMENT 'Current lifecycle status of this SOV benchmark record. Active = current reference used in planning; Superseded = replaced by a newer benchmark; Draft = pending validation; Archived = historical record; Under Review = flagged for data quality review.. Valid values are `active|superseded|draft|archived|under_review`',
    `competitor_names` STRING COMMENT 'Comma-delimited list of individual competitor brand names included in the defined competitor set for this SOV benchmark. Confidential competitive intelligence sourced from Nielsen Ad Intel or Pathmatics.',
    `competitor_set_name` STRING COMMENT 'Label identifying the defined group of competing brands or advertisers included in the SOV calculation (e.g., Tier-1 Auto Competitors — Luxury Segment). Confidential competitive intelligence.',
    `confidence_level` STRING COMMENT 'Qualitative confidence rating for the accuracy of the SOV and spend estimates in this benchmark record. Reflects data source quality, sample size, and methodology robustness. High = MRC-accredited source with full panel; Indicative = modeled or extrapolated estimate.. Valid values are `high|medium|low|indicative`',
    `confidence_score` DECIMAL(18,2) COMMENT 'Numeric confidence score (0.00–100.00) quantifying the statistical reliability of the SOV benchmark estimate. Complements the qualitative confidence_level field with a precise measure for analytics and model inputs.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the country in which the SOV benchmark is measured (e.g., USA, GBR, CAN).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SOV benchmark record was first created in the system. Audit trail field conforming to the yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `data_source` STRING COMMENT 'The primary data source or platform from which the SOV and competitive spend data was obtained. Drives confidence assessment and methodology notes. [ENUM-REF-CANDIDATE: nielsen_ad_intel|comscore|pathmatics|sensor_tower|kantar|mediaocean_prisma|internal_estimate|other — promote to reference product]',
    `dma_code` STRING COMMENT 'Nielsen-assigned three-digit numeric code for the Designated Market Area (DMA) associated with this SOV benchmark. Use 000 for national/non-DMA benchmarks.. Valid values are `^[0-9]{3}$`',
    `estimated_brand_spend` DECIMAL(18,2) COMMENT 'Estimated total media spend (in USD) for the advertisers brand within the defined channel, market, and measurement period. Sourced from Nielsen Ad Intel, Comscore, or Pathmatics/Sensor Tower competitive intelligence.',
    `estimated_competitor_spend` DECIMAL(18,2) COMMENT 'Estimated total media spend (in USD) for all competitors in the defined competitor set within the channel, market, and measurement period. Sourced from competitive intelligence platforms.',
    `grp_benchmark` DECIMAL(18,2) COMMENT 'The Gross Rating Point (GRP) benchmark value for the advertisers brand within the defined channel, market, and measurement period. Used for broadcast and video channel SOV benchmarking alongside spend-based SOV.',
    `impression_share_pct` DECIMAL(18,2) COMMENT 'The advertisers share of total available impressions within the defined channel, market, and measurement period. Particularly relevant for digital channels (paid search, display) as a complement to spend-based SOV.',
    `is_verified` BOOLEAN COMMENT 'Indicates whether this SOV benchmark record has been validated and approved by a media strategist or analytics team member before use in client-facing media planning recommendations.',
    `market_name` STRING COMMENT 'Name of the geographic market or Nielsen Designated Market Area (DMA) for which the SOV benchmark applies (e.g., New York DMA, National, Los Angeles DMA).',
    `measurement_period_type` STRING COMMENT 'Granularity of the measurement period for this SOV benchmark (e.g., weekly, monthly, quarterly, annual, or custom date range).. Valid values are `weekly|monthly|quarterly|annual|custom`',
    `methodology_notes` STRING COMMENT 'Free-text description of the measurement methodology, data collection approach, or estimation technique used to derive the SOV and spend figures. Captures caveats, panel definitions, or extrapolation methods for transparency.',
    `period_end_date` DATE COMMENT 'Last date of the measurement period covered by this SOV benchmark record. Together with period_start_date defines the competitive intelligence window.',
    `period_start_date` DATE COMMENT 'First date of the measurement period covered by this SOV benchmark record. Used to align competitive spend intelligence with media planning cycles.',
    `planning_cycle` STRING COMMENT 'The media planning cycle or fiscal period for which this benchmark is intended to inform investment decisions (e.g., FY2024, Q2 2024, H1 2024). Links the benchmark to the relevant planning horizon.',
    `product_category` STRING COMMENT 'The IAB or Nielsen-defined product or service category within which the SOV benchmark is measured (e.g., Automotive — Luxury Vehicles, Quick Service Restaurants). Defines the competitive universe.',
    `recommended_budget` DECIMAL(18,2) COMMENT 'The media budget (in spend_currency_code) recommended by media strategists to achieve the sov_target_pct for the advertisers brand in the defined channel and market. Derived from competitive intelligence and used in client budget justification.',
    `sov_pct` DECIMAL(18,2) COMMENT 'The measured or estimated Share of Voice (SOV) percentage for the advertisers brand within the defined competitor set, channel, and market for the measurement period. Expressed as a percentage (0.0000–100.0000). Core metric driving media budget allocation recommendations.',
    `sov_target_pct` DECIMAL(18,2) COMMENT 'The planned or recommended SOV percentage target set by media strategists for the advertisers brand during the planning phase. Used to justify budget recommendations and measure gap versus current SOV.',
    `spend_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all spend figures in this benchmark record (estimated_brand_spend, estimated_competitor_spend, total_category_spend). Defaults to USD for US markets.. Valid values are `^[A-Z]{3}$`',
    `total_category_spend` DECIMAL(18,2) COMMENT 'Estimated total media spend (in USD) across all advertisers in the product/service category within the channel, market, and measurement period. Denominator used to calculate SOV percentage.',
    `trp_benchmark` DECIMAL(18,2) COMMENT 'The Target Rating Point (TRP) benchmark value for the advertisers brand, scoped to the defined target audience segment. Complements GRP by focusing on the specific audience rather than the total population.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this SOV benchmark record was last modified. Supports data lineage tracking and audit compliance in the Databricks Silver Layer.',
    `verified_by` STRING COMMENT 'Name or employee identifier of the media strategist or analytics team member who validated and approved this SOV benchmark record for use in planning.',
    `verified_date` DATE COMMENT 'Date on which this SOV benchmark record was verified and approved by the responsible media strategist or analytics team member.',
    CONSTRAINT pk_sov_benchmark PRIMARY KEY(`sov_benchmark_id`)
) COMMENT 'Reference master capturing Share of Voice (SOV) benchmarks and competitive media spending intelligence used during media planning to set investment levels and justify budget recommendations. Captures brand/advertiser, competitor set, channel type, market/DMA, measurement period, SOV percentage, estimated competitor spend, total category spend, data source (Nielsen Ad Intel, Comscore, Pathmatics/Sensor Tower), benchmark date, and confidence level. Owned by media domain because SOV benchmarks directly drive media budget allocation decisions and are consumed primarily by media strategists during the planning phase. Distinct from brand health metrics (brand domain) in that this measures media investment share, not brand perception.';

CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`audience_rating` (
    `audience_rating_id` BIGINT COMMENT 'Unique surrogate identifier for each audience rating record in the media vehicle measurement dataset. Primary key for the audience_rating data product.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Audience ratings measure delivery against specific demographic and behavioral segments for GRP/TRP calculation. Buyers use segment-linked ratings for media planning, buying, and post-campaign delivery',
    `publisher_id` BIGINT COMMENT 'Reference to the publisher or media owner associated with this rated vehicle. Used to aggregate ratings across a publishers portfolio.',
    `publisher_property_id` BIGINT COMMENT 'Reference to the media vehicle (network, station, site, or publication) for which this audience rating applies. Links to the media vehicle master record.',
    `age_range_high` STRING COMMENT 'Upper bound of the age range for the demographic cell (e.g., 49 for the A18-49 cell). A null value indicates an open-ended upper bound (e.g., 65+).',
    `age_range_low` STRING COMMENT 'Lower bound of the age range for the demographic cell (e.g., 18 for the A18-49 cell). Enables precise demographic filtering and TRP validation in media planning.',
    `average_audience` BIGINT COMMENT 'Average number of persons (in thousands) tuned to or engaged with the media vehicle during the average minute of the measured time slot. The primary audience delivery metric used in GRP/TRP calculations and media plan validation.',
    `confidence_interval` DECIMAL(18,2) COMMENT 'Statistical confidence interval (expressed as a decimal, e.g., 0.95 for 95%) associated with the rating estimate, reflecting measurement precision. Used by media planners to assess reliability of ratings for planning and reconciliation decisions.',
    `cumulative_audience` BIGINT COMMENT 'Total unduplicated number of persons (in thousands) who were exposed to the media vehicle at least once during the measurement period. Also known as reach or cume. Used in reach and frequency planning.',
    `currency_type` STRING COMMENT 'The audience measurement currency in which this rating is expressed (e.g., grp for Gross Rating Points, trp for Target Rating Points, impressions for digital impression-based measurement). Aligns with IAB and MRC currency standards for cross-media planning.. Valid values are `grp|trp|impressions|reach|frequency`',
    `data_vintage_date` DATE COMMENT 'The date on which this specific version of the rating data was published or released by the measurement source. Enables tracking of data revisions and ensures media planners are using the most current ratings vintage for planning and reconciliation.',
    `daypart_code` STRING COMMENT 'Standardized code identifying the daypart or time slot for which the rating is measured (e.g., PRIME, EARLY_NEWS, LATE_FRINGE, MORNING_DRIVE). Aligns with Nielsen and MRC daypart definitions used in media planning and GRP/TRP calculations.',
    `daypart_name` STRING COMMENT 'Human-readable label for the daypart or time slot (e.g., Prime Time, Early Morning, Late Night). Used in media planning reports and client-facing deliverables.',
    `gender_segment` STRING COMMENT 'Gender component of the demographic cell for which the rating is reported. persons and all indicate total audience regardless of gender, consistent with Nielsen P2+ and Comscore total audience reporting.. Valid values are `all|male|female|persons`',
    `geography_code` STRING COMMENT 'Standardized code identifying the specific geographic market for this rating (e.g., Nielsen DMA code 501 for New York, MSA FIPS code, or US for national). Used to match ratings to media plan geographic targets.',
    `geography_name` STRING COMMENT 'Human-readable name of the geographic market for this rating (e.g., New York, Los Angeles, National). Used in media planning reports and client-facing deliverables.',
    `geography_type` STRING COMMENT 'The geographic scope of the audience measurement (e.g., national for national ratings, dma for Nielsen Designated Market Area, msa for Metropolitan Statistical Area). Determines the applicable universe estimate and planning geography.. Valid values are `national|dma|msa|county|zip|global`',
    `grp_contribution` DECIMAL(18,2) COMMENT 'The Gross Rating Point (GRP) value contributed by a single exposure on this vehicle in this daypart for the total audience demographic. GRP = Rating × Number of Spots. Stored at the unit level to support media plan GRP accumulation and delivery validation.',
    `ingested_timestamp` TIMESTAMP COMMENT 'Timestamp when this audience rating record was first ingested into the Databricks Silver Layer from the source measurement system (Nielsen Ad Intel or Comscore). Supports data lineage and audit trail for the lakehouse pipeline.',
    `is_low_reliability` BOOLEAN COMMENT 'Flag indicating that this rating record has been identified as statistically unreliable due to insufficient sample size, high margin of error, or measurement source quality flags. Low-reliability ratings should not be used for billing reconciliation without additional validation.',
    `measurement_methodology` STRING COMMENT 'The data collection methodology used by the measurement source to produce this rating (e.g., panel for Nielsen People Meter, census for Comscore digital census tags, hybrid for blended panel+census). Affects data quality and comparability across sources.. Valid values are `panel|census|hybrid|modeled|server_side`',
    `measurement_period_end` DATE COMMENT 'End date of the audience measurement sweep or reporting period during which this rating was collected. Together with measurement_period_start, defines the temporal scope of the rating data.',
    `measurement_period_start` DATE COMMENT 'Start date of the audience measurement sweep or reporting period during which this rating was collected (e.g., Nielsen sweeps period start). Used to align ratings data with campaign flight dates for GRP/TRP delivery validation.',
    `measurement_source` STRING COMMENT 'The third-party audience measurement provider that produced this rating data (e.g., nielsen, comscore). Determines the methodology, panel, and accreditation status applicable to this record. [ENUM-REF-CANDIDATE: nielsen|comscore|arbitron|mri_simmons|kantar|doubleclick — promote to reference product]. Valid values are `nielsen|comscore|arbitron|mri_simmons|kantar|doubleclick`',
    `mrc_accredited` BOOLEAN COMMENT 'Indicates whether the measurement source and methodology for this rating record hold current Media Rating Council (MRC) accreditation. MRC-accredited data is the industry standard for media buying and billing reconciliation.',
    `platform_type` STRING COMMENT 'The delivery platform for which this audience rating applies (e.g., linear_tv, streaming, digital_video, audio). Supports cross-platform audience deduplication and unified reach planning across CTV/OTT, linear, and digital channels. [ENUM-REF-CANDIDATE: linear_tv|streaming|digital_display|digital_video|audio|print|ooh|dooh — promote to reference product]',
    `rating_status` STRING COMMENT 'Lifecycle status of the rating record indicating whether the data is preliminary (initial estimate), final (confirmed), revised (updated after initial release), or superseded (replaced by a newer vintage). Critical for media reconciliation — only final ratings are used for billing reconciliation.. Valid values are `preliminary|final|revised|superseded`',
    `rating_value` DECIMAL(18,2) COMMENT 'The audience rating expressed as a percentage of the total universe that viewed/listened to/visited the media vehicle during the measured time slot and demographic cell. A rating of 5.25 means 5.25% of the universe was exposed. Core metric for GRP and TRP delivery validation.',
    `sample_size` STRING COMMENT 'Number of panel respondents or measurement units contributing to this rating estimate. Smaller sample sizes indicate lower statistical reliability; used to apply confidence intervals and flag low-reliability ratings in media planning.',
    `share_value` DECIMAL(18,2) COMMENT 'Percentage of the Households Using Television (HUT) or Persons Using Television (PUT) that were tuned to this vehicle during the time slot. Share = (Average Audience / HUT or PUT) × 100. Used alongside rating to assess competitive performance.',
    `time_slot_end` STRING COMMENT 'End time of the measured time slot in HH:MM (24-hour) format (e.g., 23:00 for 11 PM). Defines the close of the measurement window.. Valid values are `^([01]d|2[0-3]):[0-5]d$`',
    `time_slot_start` STRING COMMENT 'Start time of the measured time slot in HH:MM (24-hour) format (e.g., 20:00 for 8 PM). Used to precisely define the measurement window within a daypart.. Valid values are `^([01]d|2[0-3]):[0-5]d$`',
    `trp_contribution` DECIMAL(18,2) COMMENT 'The Target Rating Point (TRP) value contributed by a single exposure on this vehicle for the specific demographic cell. TRP = Target Demographic Rating × Number of Spots. Used to validate targeted audience delivery against media plan objectives.',
    `universe_estimate` BIGINT COMMENT 'Total estimated population size (in persons) for the demographic cell and geography against which the rating is calculated. Used as the denominator in rating calculations and for projecting absolute audience size from rating percentages.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this audience rating record, including revisions from the measurement source or corrections applied during reconciliation. Used to track data freshness and identify revised ratings vintages.',
    `vehicle_type` STRING COMMENT 'Classification of the media vehicle by channel type. Determines which measurement methodology and rating currency applies. [ENUM-REF-CANDIDATE: broadcast_tv|cable_tv|radio|digital|print|ooh|ctv_ott|podcast — promote to reference product]',
    CONSTRAINT pk_audience_rating PRIMARY KEY(`audience_rating_id`)
) COMMENT 'Reference data capturing third-party audience measurement ratings for media vehicles — including Nielsen TV ratings, Comscore digital audience data, and radio ratings. Captures vehicle name (network, station, site), daypart/time slot, demographic cell (age/gender), rating value, universe estimate, average audience, cumulative audience, measurement period, measurement source (Nielsen, Comscore, MRC-accredited), and data vintage. Used to validate GRP/TRP delivery and inform media planning decisions.';

CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`ad_channel` (
    `ad_channel_id` BIGINT COMMENT 'Unique identifier for the advertising channel. Primary key for the ad_channel entity.',
    `category_id` BIGINT COMMENT 'Foreign key linking to media.category. Business justification: ad_channel currently has channel_category as a STRING attribute. The category product exists to provide hierarchical classification taxonomy for advertising channels. This FK normalizes the channel-to',
    `agency_commission_pct` DECIMAL(18,2) COMMENT 'Standard agency commission percentage applied to gross media spend on this channel. Typically 15% for traditional media, 10-15% for digital. Null if commission varies by client or IO.',
    `api_endpoint_url` STRING COMMENT 'Base URL for the channels API integration. Used by ETL processes to retrieve campaign performance data, update bids, and sync creative assets. Confidential system configuration.',
    `api_version` STRING COMMENT 'Version of the API specification currently in use for this channel (e.g., v14, 2023-Q4). Critical for maintaining integration compatibility during platform upgrades.',
    `attribution_window_days` STRING COMMENT 'Number of days after an ad interaction (click or view) during which conversions are attributed to this channel. Standard windows are 1, 7, 30, or 90 days depending on channel and business model.',
    `bid_strategy_default` STRING COMMENT 'Default bidding strategy applied to campaigns on this channel unless overridden at campaign level. Determines how the platform optimizes bids to achieve campaign objectives. [ENUM-REF-CANDIDATE: manual_cpc|enhanced_cpc|maximize_clicks|maximize_conversions|target_cpa|target_roas|target_impression_share|viewable_cpm — 8 candidates stripped; promote to reference product]',
    `brand_safety_keywords` STRING COMMENT 'Comma-separated list of keywords or content categories to exclude for brand safety (e.g., violence, adult content, controversial topics). Applied as negative targeting across all campaigns on this channel.',
    `brand_safety_tier` STRING COMMENT 'Default brand safety filtering level applied to inventory on this channel. Standard allows broad reach; strict applies maximum content exclusions to protect brand reputation.. Valid values are `standard|moderate|strict|custom`',
    `ccpa_opt_out_supported` BOOLEAN COMMENT 'Indicates whether this channel supports CCPA Do Not Sell signals for California users. Required for compliance with California privacy regulations.',
    `channel_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the channel across all systems (e.g., SEM_GOOGLE, SOCIAL_FB, DISPLAY_PROG). Used as the business identifier in campaign planning, trafficking, and reporting.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `channel_name` STRING COMMENT 'Human-readable name of the advertising channel (e.g., Google Search, Facebook Social, Programmatic Display).',
    `channel_status` STRING COMMENT 'Current operational status of the channel. Active channels are available for campaign planning and buying; deprecated channels are phased out but may have historical data.. Valid values are `active|inactive|deprecated|pilot|sunset`',
    `channel_type` STRING COMMENT 'Primary classification of the channel by media type. Aligns with IAB taxonomy for cross-platform reporting and planning. [ENUM-REF-CANDIDATE: paid_search|social|display|video|email|seo|ooh|dooh|ctv|ott|programmatic|audio|native|affiliate — 14 candidates stripped; promote to reference product]',
    `click_attribution_window_days` STRING COMMENT 'Number of days after a click during which conversions are attributed to this channel. Typically longer than view attribution window due to higher intent signal.',
    `consent_signal_format` STRING COMMENT 'Format of privacy consent signals passed to this channel. TCF v2 (Transparency and Consent Framework) for GDPR, US Privacy String for CCPA, GPP (Global Privacy Platform) for multi-jurisdiction compliance.. Valid values are `tcf_v2|us_privacy|gpp|custom|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this channel record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Default currency for financial transactions on this channel. Three-letter ISO 4217 code (e.g., USD, EUR, GBP). Used for rate cards, billing, and reconciliation.. Valid values are `^[A-Z]{3}$`',
    `delivery_modality` STRING COMMENT 'Method by which media is bought and delivered through this channel. Determines operational workflow, trafficking requirements, and reconciliation processes.. Valid values are `self_serve|managed_service|programmatic|direct_io|hybrid`',
    `dsp_seat_code` STRING COMMENT 'Unique seat identifier within the DSP platform (e.g., The Trade Desk seat ID). Used for programmatic bid requests, deal configuration, and reconciliation. Confidential operational credential.',
    `effective_date` DATE COMMENT 'Date when this channel configuration became active and available for campaign planning and buying. Used for historical tracking of channel availability.',
    `expiration_date` DATE COMMENT 'Date when this channel configuration expires or was deprecated. Null for active channels. Used to track channel lifecycle and prevent planning on sunset channels.',
    `frequency_cap_default` STRING COMMENT 'Default maximum number of times an ad can be shown to the same user within the frequency cap period. Prevents ad fatigue and optimizes reach. Null indicates no default cap.',
    `frequency_cap_period_default` STRING COMMENT 'Time window over which the default frequency cap is applied (e.g., 3 impressions per day). Works in conjunction with frequency_cap_default.. Valid values are `hour|day|week|month|campaign`',
    `gdpr_consent_required` BOOLEAN COMMENT 'Indicates whether GDPR consent signals must be passed for users in EU/EEA jurisdictions when serving ads on this channel. True for channels operating in or targeting European markets.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special instructions, or configuration details specific to this channel. Used by media planners and buyers for reference.',
    `platform_name` STRING COMMENT 'Name of the technology platform or publisher that operates this channel (e.g., Google Ads, Meta Business Suite, The Trade Desk, Hulu).',
    `platform_type` STRING COMMENT 'Classification of the underlying technology platform. DSP (Demand-Side Platform) for programmatic buying, SSP (Supply-Side Platform) for inventory supply, or direct publisher platforms. [ENUM-REF-CANDIDATE: dsp|ssp|ad_network|publisher_direct|search_engine|social_platform|video_platform|email_platform|ad_server — 9 candidates stripped; promote to reference product]',
    `pricing_model` STRING COMMENT 'Default pricing model for media buys on this channel. CPM (Cost Per Mille) for impressions, CPC (Cost Per Click), CPA (Cost Per Acquisition), CPV (Cost Per View), CPCV (Cost Per Completed View), or flat fee. [ENUM-REF-CANDIDATE: cpm|cpc|cpa|cpv|cpcv|flat_fee|performance — 7 candidates stripped; promote to reference product]',
    `supports_audience_targeting` BOOLEAN COMMENT 'Indicates whether this channel supports audience segment targeting using first-party, third-party, or platform-native audience data. Critical for personalized campaign strategies.',
    `supports_dayparting` BOOLEAN COMMENT 'Indicates whether this channel supports daypart scheduling (time-of-day and day-of-week targeting). Common in broadcast, CTV, and digital channels for optimizing reach and frequency.',
    `supports_geo_targeting` BOOLEAN COMMENT 'Indicates whether this channel supports geographic targeting by country, region, DMA (Designated Market Area), postal code, or radius. Essential for local and regional campaigns.',
    `supports_programmatic` BOOLEAN COMMENT 'Indicates whether this channel supports programmatic buying via DSP platforms and RTB (Real-Time Bidding) protocols. True for most digital channels; false for traditional media.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this channel record was last modified. Used for change tracking, cache invalidation, and audit purposes.',
    `utm_medium_default` STRING COMMENT 'Default value for utm_medium parameter in campaign tracking URLs for this channel (e.g., cpc, social, display). Enables consistent channel attribution in web analytics.',
    `utm_source_default` STRING COMMENT 'Default value for utm_source parameter in campaign tracking URLs for this channel. Standardizes attribution and analytics reporting across Google Analytics and other web analytics platforms.',
    `view_attribution_window_days` STRING COMMENT 'Number of days after an ad view (impression without click) during which conversions are attributed to this channel. Typically 1-7 days for display and video channels.',
    `viewability_standard` STRING COMMENT 'Viewability measurement standard applied to this channel. MRC (Media Rating Council) standard requires 50% of pixels in view for 1 second (display) or 2 seconds (video).. Valid values are `mrc|groupm|custom`',
    `viewability_threshold_pct` DECIMAL(18,2) COMMENT 'Minimum viewability percentage required for impressions on this channel to be considered valid for billing and reporting purposes. Typically 50-70% based on MRC standards.',
    CONSTRAINT pk_ad_channel PRIMARY KEY(`ad_channel_id`)
) COMMENT 'Master reference entity for all media and distribution channels through which advertising is delivered — including paid search (SEM/PPC), social, display, video, email, SEO, OOH/DOOH, CTV/OTT, and programmatic. Owns the authoritative channel taxonomy with IAB-aligned classifications, channel codes, and delivery modalities. Also owns platform-specific operational configuration including DSP seat settings (The Trade Desk), UTM parameter conventions, bid strategy defaults, frequency cap policies, brand safety keyword lists, and GDPR/CCPA consent signal handling. SSOT for channel identity, taxonomy, and operational configuration across the enterprise.';

CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`category` (
    `category_id` BIGINT COMMENT 'Unique identifier for the advertising channel category. Primary key for the category taxonomy.',
    `parent_category_id` BIGINT COMMENT 'Reference to the parent category in the hierarchical taxonomy. Null for top-level channel families.',
    `ad_format_types` STRING COMMENT 'Comma-separated list of ad formats supported by this category (e.g., banner, video, native, audio, interstitial, rich media). Used for creative trafficking and asset management.',
    `audience_targeting_capability` STRING COMMENT 'Level of audience segmentation and targeting available for this category. Advanced = behavioral, contextual, lookalike; basic = demographic + interest; demographic_only = age/gender only; none = broad reach only.. Valid values are `advanced|basic|demographic_only|none`',
    `brand_safety_tier` STRING COMMENT 'Default brand safety classification for inventory within this category. Premium = curated, brand-safe publishers; standard = verified inventory; open_exchange = programmatic open marketplace; unverified = requires additional screening.. Valid values are `premium|standard|open_exchange|unverified`',
    `buying_method` STRING COMMENT 'Primary buying approach associated with this category (e.g., direct IO, programmatic RTB, upfront commitment, scatter market). Guides procurement workflow and system routing.. Valid values are `direct|programmatic|network|exchange|upfront|scatter`',
    `category_code` STRING COMMENT 'Unique business identifier code for the category used in media planning and reporting systems. Follows IAB-aligned naming conventions.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `category_description` STRING COMMENT 'Detailed business definition and usage guidance for this category. Includes scope, examples, and differentiation from related categories. Used for planner training and taxonomy governance.',
    `category_name` STRING COMMENT 'Human-readable name of the advertising channel category (e.g., Digital Display, Programmatic Video, Paid Social, Broadcast TV, Out-of-Home).',
    `category_status` STRING COMMENT 'Current lifecycle status of the category. Active categories are available for media planning and buying; deprecated categories are retained for historical reporting only.. Valid values are `active|inactive|deprecated|pending`',
    `category_type` STRING COMMENT 'Classification level within the taxonomy hierarchy: channel_family (top-level such as Digital, Broadcast, Print, OOH), channel_subcategory (mid-level such as Programmatic Display, Paid Social), or channel_type (leaf-level granular channel).. Valid values are `channel_family|channel_subcategory|channel_type`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this category record was first created in the system. Used for audit trail and taxonomy change tracking.',
    `daypart_applicable` BOOLEAN COMMENT 'Indicates whether daypart scheduling (time-of-day targeting such as prime time, daytime, late night) is relevant for this category. Primarily applicable to broadcast, radio, and linear TV.',
    `default_attribution_window_days` STRING COMMENT 'Standard attribution lookback window (in days) for conversion tracking in this category. Used for ROAS (Return on Ad Spend) and CPA (Cost Per Acquisition) measurement.',
    `default_pricing_model` STRING COMMENT 'Standard pricing model typically used for this category: CPM (Cost Per Mille), CPC (Cost Per Click), CPA (Cost Per Acquisition), CPV (Cost Per View), flat fee, daypart rate, or GRP-based pricing. [ENUM-REF-CANDIDATE: cpm|cpc|cpa|cpv|flat_fee|daypart|grp — 7 candidates stripped; promote to reference product]',
    `effective_end_date` DATE COMMENT 'Date on which this category was deprecated or retired. Null for currently active categories. Supports historical reporting and taxonomy evolution tracking.',
    `effective_start_date` DATE COMMENT 'Date from which this category became active and available for use in media planning and buying. Supports temporal taxonomy versioning.',
    `frequency_cap_support` BOOLEAN COMMENT 'Indicates whether this category supports frequency capping (limiting the number of times a user sees an ad within a time period). Common in digital and CTV/OTT channels.',
    `geographic_scope` STRING COMMENT 'Typical geographic reach classification for this category. DMA = Designated Market Area (Nielsen standard for US broadcast markets).. Valid values are `global|national|regional|local|dma`',
    `hierarchy_level` STRING COMMENT 'Numeric depth of this category in the taxonomy tree. Level 1 = top-level channel family, Level 2 = subcategory, Level 3+ = leaf-level types.',
    `hierarchy_path` STRING COMMENT 'Full hierarchical path from root to this category, represented as a delimited string (e.g., Digital > Programmatic > Display). Used for rollup reporting and navigation.',
    `iab_category_code` STRING COMMENT 'Official IAB Tech Lab category code mapping for this channel category. Ensures interoperability with IAB-compliant ad servers, DSPs, and SSPs.',
    `is_addressable` BOOLEAN COMMENT 'Indicates whether this category supports addressable (audience-targeted, household-level) advertising capabilities, common in CTV (Connected TV), OTT (Over-the-Top), and digital channels.',
    `is_leaf_node` BOOLEAN COMMENT 'Indicates whether this category is a terminal leaf node (true) or a parent node with children (false). Leaf nodes are used for actual media placement assignment.',
    `is_programmatic` BOOLEAN COMMENT 'Indicates whether this category represents programmatic (automated, Real-Time Bidding) media buying channels. Used to route placements to DSP (Demand-Side Platform) and SSP (Supply-Side Platform) systems.',
    `measurement_standard` STRING COMMENT 'Industry measurement standard or methodology applicable to this category (e.g., Nielsen GRP, Comscore vCE, MOAT Viewability, IAS Brand Safety). Used for performance tracking and reconciliation.',
    `media_type` STRING COMMENT 'High-level media classification for this category. Aligns with industry-standard media type groupings used in media planning, buying, and MRC (Media Rating Council) reporting. [ENUM-REF-CANDIDATE: digital|broadcast|print|ooh|audio|ctv_ott|social|search|native|email — 10 candidates stripped; promote to reference product]',
    `mrc_accredited` BOOLEAN COMMENT 'Indicates whether measurement for this category is covered by MRC-accredited methodologies. Critical for advertiser trust and audit compliance.',
    `reconciliation_method` STRING COMMENT 'Standard billing reconciliation approach for this category. Automated = system-to-system delivery log matching; manual = invoice-based reconciliation; hybrid = combination; not_applicable = non-billable category.. Valid values are `automated|manual|hybrid|not_applicable`',
    `requires_trafficking` BOOLEAN COMMENT 'Indicates whether placements in this category require formal ad trafficking instructions (creative asset delivery, tag generation, third-party verification setup) via ad servers such as Google Campaign Manager 360.',
    `sort_order` STRING COMMENT 'Display sequence number for this category within its parent level. Used for consistent ordering in media planning UI, reports, and dashboards.',
    `supports_grp` BOOLEAN COMMENT 'Indicates whether this category supports GRP-based planning and measurement, typically applicable to broadcast and linear TV channels.',
    `supports_trp` BOOLEAN COMMENT 'Indicates whether this category supports TRP-based audience targeting and measurement, used for demographic-specific reach planning.',
    `supports_viewability` BOOLEAN COMMENT 'Indicates whether this category supports MRC-compliant viewability measurement (e.g., 50% of pixels in-view for 1+ seconds for display, 2+ seconds for video).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this category record. Used for change detection and incremental processing in downstream analytics.',
    `usage_notes` STRING COMMENT 'Operational notes and best practices for using this category in media planning, buying, and reporting. May include system-specific routing instructions or billing considerations.',
    `vast_vpaid_support` STRING COMMENT 'Indicates video ad serving standard support for this category. VAST for linear video ads, VPAID for interactive video ads, both for hybrid support, none for non-video categories.. Valid values are `vast_only|vpaid_only|both|none`',
    CONSTRAINT pk_category PRIMARY KEY(`category_id`)
) COMMENT 'Hierarchical classification taxonomy for advertising channels — defining top-level channel families (e.g., Digital, Broadcast, Print, OOH), sub-categories (e.g., Programmatic Display, Paid Social, CTV/OTT), and leaf-level channel types. Supports IAB and MRC-aligned channel categorization used in media planning, reporting, and billing reconciliation.';

CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`publisher_property` (
    `publisher_property_id` BIGINT COMMENT 'Unique identifier for the publisher property. Primary key.',
    `publisher_id` BIGINT COMMENT 'Reference to the publisher or media owner that operates this property.',
    `ad_fraud_risk_score` DECIMAL(18,2) COMMENT 'The fraud risk score for this property (0-100 scale, where higher scores indicate higher fraud risk) based on invalid traffic (IVT) detection and TAG certification.',
    `ad_server_platform` STRING COMMENT 'The primary ad serving platform used by this property (e.g., Google Ad Manager, Freewheel, Xandr, Magnite).',
    `app_bundle_code` STRING COMMENT 'The platform-specific bundle identifier for mobile or CTV apps (e.g., com.example.app).',
    `app_store_code` STRING COMMENT 'The unique identifier for the mobile or CTV app in the app store (e.g., Apple App Store ID, Google Play Store ID, Roku Channel Store ID).',
    `audience_composition` STRING COMMENT 'Description of the primary audience demographics and psychographics for this property (e.g., Adults 25-54, HHI $75K+, Tech Early Adopters).',
    `average_cpm` DECIMAL(18,2) COMMENT 'The average Cost Per Mille (CPM) rate achieved for ad placements on this property over the past 90 days.',
    `brand_safety_classification` STRING COMMENT 'The brand safety tier or classification for this property based on content quality, adjacency risk, and third-party verification (e.g., TAG Certified, IAS/DV brand safety scores).. Valid values are `high_risk|medium_risk|low_risk|brand_safe|certified_safe`',
    `campaign_manager_site_code` STRING COMMENT 'The unique site identifier for this property in Google Campaign Manager 360 ad serving platform.',
    `content_vertical` STRING COMMENT 'The primary content category or vertical of the property (e.g., News, Sports, Entertainment, Finance, Lifestyle) per IAB Content Taxonomy.',
    `country_code` STRING COMMENT 'The primary country where this property operates, using ISO 3166-1 alpha-3 country code (e.g., USA, GBR, CAN).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this property record was first created in the system.',
    `currency_code` STRING COMMENT 'The currency used for pricing and billing for this property, using ISO 4217 three-letter currency code (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `floor_cpm` DECIMAL(18,2) COMMENT 'The minimum Cost Per Mille (CPM) rate accepted for ad placements on this property.',
    `geographic_coverage` STRING COMMENT 'The primary geographic markets or regions served by this property (e.g., USA National, New York DMA, EMEA, Global).',
    `iab_content_category` STRING COMMENT 'The standardized IAB content category code for the property (e.g., IAB1 for Arts & Entertainment, IAB3 for Business).',
    `language_code` STRING COMMENT 'The primary language of content on this property, using ISO 639-1 two-letter language code (e.g., en, es, fr).. Valid values are `^[a-z]{2}$`',
    `monthly_impressions` BIGINT COMMENT 'The average number of ad impressions available per month for this property.',
    `monthly_unique_visitors` BIGINT COMMENT 'The average number of unique visitors or users per month for this property.',
    `mrc_accredited` BOOLEAN COMMENT 'Indicates whether the propertys traffic and audience measurement has been audited and accredited by the Media Rating Council (MRC).',
    `mrc_audit_date` DATE COMMENT 'The date of the most recent MRC audit or certification for this property.',
    `pmp_deals_available` BOOLEAN COMMENT 'Indicates whether this property offers Private Marketplace (PMP) programmatic deals with negotiated terms and pricing.',
    `prisma_property_code` STRING COMMENT 'The unique identifier for this property in the Mediaocean Prisma media planning and buying system.',
    `programmatic_enabled` BOOLEAN COMMENT 'Indicates whether this property is available for programmatic buying through Demand-Side Platforms (DSPs) and Supply-Side Platforms (SSPs).',
    `property_code` STRING COMMENT 'The externally-known unique identifier or code for this property used in media planning and buying systems (e.g., site ID, app ID, network code).',
    `property_name` STRING COMMENT 'The human-readable name of the media property, site, app, network, or placement (e.g., ESPN Mobile App, The New York Times Homepage, Clear Channel Billboard Network).',
    `property_status` STRING COMMENT 'Current lifecycle status of the property in the media inventory system.. Valid values are `active|inactive|pending|suspended|archived`',
    `property_type` STRING COMMENT 'The category of media property: website, mobile app, Connected TV (CTV) app, streaming channel, TV network, radio station, Out-of-Home (OOH) network, or print publication. [ENUM-REF-CANDIDATE: website|mobile_app|ctv_app|streaming_channel|tv_network|radio_station|ooh_network|print_publication — 8 candidates stripped; promote to reference product]',
    `property_url` STRING COMMENT 'The primary URL or web address for the property (for websites and web-based properties).',
    `rtb_enabled` BOOLEAN COMMENT 'Indicates whether this property supports Real-Time Bidding (RTB) for ad inventory.',
    `supported_ad_formats` STRING COMMENT 'Comma-separated list of ad formats supported by this property (e.g., display, video, native, audio, DOOH).',
    `tag_certified` BOOLEAN COMMENT 'Indicates whether the property is certified by the Trustworthy Accountability Group (TAG) for brand safety and anti-fraud measures.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this property record was last modified in the system.',
    `vast_version` STRING COMMENT 'The version of the Video Ad Serving Template (VAST) standard supported by this property (e.g., VAST 2.0, VAST 3.0, VAST 4.0).',
    `video_player_type` STRING COMMENT 'The type of video player used on this property for video ad serving (e.g., JW Player, Brightcove, Video.js, native CTV player).',
    `viewability_benchmark_pct` DECIMAL(18,2) COMMENT 'The average viewability rate for ad placements on this property, measured as percentage of impressions that meet MRC viewability standards (50% of pixels in view for 1+ seconds for display, 2+ seconds for video).',
    `vpaid_supported` BOOLEAN COMMENT 'Indicates whether this property supports the Video Player-Ad Interface Definition (VPAID) standard for interactive video ads.',
    CONSTRAINT pk_publisher_property PRIMARY KEY(`publisher_property_id`)
) COMMENT 'Represents individual media properties, sites, apps, networks, or placements owned or operated by a publisher — e.g., a specific website, mobile app, TV network, OOH billboard network, or streaming channel. Captures property-level attributes including URL/app ID, content vertical, audience composition, MRC-audited traffic certification, viewability benchmarks, and brand safety classification.';

CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`ssp_platform` (
    `ssp_platform_id` BIGINT COMMENT 'Unique identifier for the Supply-Side Platform record. Primary key.',
    `ads_txt_certified` BOOLEAN COMMENT 'Indicates whether the SSP is certified and compliant with the IAB Tech Lab ads.txt standard for authorized digital sellers.',
    `api_endpoint_url` STRING COMMENT 'The primary API endpoint URL used for Real-Time Bidding (RTB) bid requests and responses with this SSP.',
    `api_version` STRING COMMENT 'The version of the SSPs API currently in use (e.g., v2.5, v3.0).',
    `bid_floor_cpm` DECIMAL(18,2) COMMENT 'The minimum CPM bid floor required by this SSP for participating in auctions.',
    `brand_safety_provider` STRING COMMENT 'The third-party brand safety verification provider integrated with this SSP (e.g., IAS, DoubleVerify, MOAT).',
    `ccpa_compliant` BOOLEAN COMMENT 'Indicates whether the SSP is compliant with CCPA requirements for consumer privacy rights.',
    `contract_end_date` DATE COMMENT 'The date when the contractual relationship with this SSP is scheduled to end or renew.',
    `contract_start_date` DATE COMMENT 'The date when the contractual relationship with this SSP became effective.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this SSP platform record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code used for financial transactions with this SSP (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dsp_integration_list` STRING COMMENT 'Comma-separated list of DSP platforms integrated with this SSP (e.g., The Trade Desk, DV360, Amazon DSP).',
    `fraud_detection_enabled` BOOLEAN COMMENT 'Indicates whether fraud detection and invalid traffic (IVT) filtering is enabled for this SSP.',
    `gdpr_compliant` BOOLEAN COMMENT 'Indicates whether the SSP is compliant with GDPR requirements for data privacy and user consent.',
    `health_check_status` STRING COMMENT 'The result of the most recent health check indicating the operational status of the SSP integration.. Valid values are `healthy|degraded|down|unknown`',
    `integration_date` DATE COMMENT 'The date when the technical integration with this SSP was completed and went live.',
    `integration_type` STRING COMMENT 'The technical integration method used to connect the SSP with the agencys Demand-Side Platform (DSP) stack.. Valid values are `api|tag_based|server_to_server|hybrid|direct_integration`',
    `last_health_check_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent health check or connectivity test performed on this SSP integration.',
    `mrc_accredited` BOOLEAN COMMENT 'Indicates whether the SSPs measurement and reporting capabilities are accredited by the Media Rating Council.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special instructions related to this SSP integration.',
    `openrtb_version` STRING COMMENT 'The version of the OpenRTB protocol supported by this SSP (e.g., 2.5, 2.6, 3.0).',
    `platform_code` STRING COMMENT 'Internal short code or abbreviation used to reference the SSP in operational systems and reporting (e.g., GAM, MAG, PUB).',
    `platform_name` STRING COMMENT 'The official business name of the SSP platform (e.g., Google Ad Manager, Magnite, PubMatic, OpenX).',
    `platform_status` STRING COMMENT 'Current operational status of the SSP integration within the agencys programmatic infrastructure.. Valid values are `active|inactive|testing|suspended|deprecated|pending_activation`',
    `pmp_enabled` BOOLEAN COMMENT 'Indicates whether Private Marketplace deals are supported and enabled for this SSP.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact at the SSP.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the SSP for account management and support.',
    `programmatic_guaranteed_enabled` BOOLEAN COMMENT 'Indicates whether Programmatic Guaranteed deals are supported and enabled for this SSP.',
    `qps_limit` STRING COMMENT 'The maximum number of bid requests per second that can be sent to this SSP as per the integration agreement.',
    `revenue_share_pct` DECIMAL(18,2) COMMENT 'The percentage of revenue shared with the SSP as per the contractual agreement.',
    `rtb_enabled` BOOLEAN COMMENT 'Indicates whether Real-Time Bidding is enabled for this SSP integration.',
    `sellers_json_compliant` BOOLEAN COMMENT 'Indicates whether the SSP publishes a sellers.json file in compliance with IAB Tech Lab transparency standards.',
    `supported_ad_formats` STRING COMMENT 'Comma-separated list of ad formats supported by this SSP (e.g., display, video, native, audio, CTV, DOOH).',
    `supported_deal_types` STRING COMMENT 'Comma-separated list of programmatic deal types supported (e.g., PMP - Private Marketplace, PG - Programmatic Guaranteed, Open Auction, Preferred Deal).',
    `tag_certified` BOOLEAN COMMENT 'Indicates whether the SSP holds TAG (Trustworthy Accountability Group) certification for brand safety and fraud prevention.',
    `technical_contact_email` STRING COMMENT 'Email address of the technical support contact at the SSP for integration and troubleshooting.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `timeout_ms` STRING COMMENT 'The maximum time in milliseconds to wait for a bid response from this SSP before timing out.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this SSP platform record was last modified or updated.',
    `viewability_measurement_enabled` BOOLEAN COMMENT 'Indicates whether viewability measurement is enabled for impressions served through this SSP.',
    CONSTRAINT pk_ssp_platform PRIMARY KEY(`ssp_platform_id`)
) COMMENT 'Master record for Supply-Side Platforms (SSPs) integrated with the agencys programmatic buying infrastructure. Captures SSP identity, API endpoint configurations, supported ad formats, RTB protocol versions (OpenRTB), deal type support (PMP, PG, Open Auction), inventory quality certifications (ads.txt, sellers.json), and integration status with the agencys DSP stack (e.g., The Trade Desk).';

CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`ad_format` (
    `ad_format_id` BIGINT COMMENT 'Unique identifier for the advertising format. Primary key for the ad_format product.',
    `accepted_file_formats` STRING COMMENT 'Comma-separated list of accepted file extensions for creative assets (e.g., JPG, PNG, GIF, MP4, MOV, HTML5, ZIP). Used for creative validation and trafficking.',
    `accepted_mime_types` STRING COMMENT 'Comma-separated list of accepted MIME types for creative files (e.g., image/jpeg, image/png, video/mp4, application/javascript). Defines technical compatibility.',
    `ad_server_platform_compatibility` STRING COMMENT 'Comma-separated list of ad server platforms that support this format (e.g., Google Campaign Manager 360, The Trade Desk, Sizmek, Flashtalking). Used for trafficking validation.',
    `aspect_ratio` STRING COMMENT 'Proportional relationship between width and height (e.g., 16:9, 4:3, 1:1). Critical for video and CTV formats.. Valid values are `^d+:d+$`',
    `brand_safety_tier` STRING COMMENT 'Brand safety classification tier for the format, indicating the level of content adjacency control and verification required (standard, enhanced, premium).. Valid values are `standard|enhanced|premium`',
    `channel_applicability` STRING COMMENT 'Comma-separated list of media channels where this format is applicable (e.g., digital, broadcast, OOH, DOOH, CTV, OTT, print, social, programmatic). Defines channel-format trafficking matrix.',
    `click_through_url_required` BOOLEAN COMMENT 'Indicates whether a click-through URL is mandatory for this ad format. True for most digital formats; false for awareness-only formats (e.g., some OOH).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ad format record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `deprecation_date` DATE COMMENT 'Date when the ad format was deprecated and scheduled for retirement. Null for active formats. Format: yyyy-MM-dd.',
    `device_type_compatibility` STRING COMMENT 'Comma-separated list of device types compatible with this format (e.g., desktop, mobile, tablet, CTV, smart_speaker, digital_billboard). Used for targeting and trafficking.',
    `duration_seconds` STRING COMMENT 'Standard duration of the ad creative in seconds. Applicable to video, audio, and CTV/OTT formats. Null for static formats.',
    `effective_date` DATE COMMENT 'Date when the ad format specification became effective and available for use in media planning and trafficking. Format: yyyy-MM-dd.',
    `environment_type` STRING COMMENT 'Primary environment where the ad format is delivered (e.g., web, app, CTV, DOOH, print, broadcast, social). Aligns with media planning and buying strategies. [ENUM-REF-CANDIDATE: web|app|ctv|dooh|print|broadcast|social — 7 candidates stripped; promote to reference product]',
    `format_category` STRING COMMENT 'High-level classification of the ad format by media type. Aligns with channel taxonomy and media planning categories. [ENUM-REF-CANDIDATE: display|video|audio|native|rich_media|ooh|dooh|ctv|ott|print|social|email — 12 candidates stripped; promote to reference product]',
    `format_code` STRING COMMENT 'Standardized alphanumeric code uniquely identifying the ad format across systems (e.g., DISPLAY_300X250, VIDEO_PREROLL_15S). Used for trafficking and system integration.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `format_name` STRING COMMENT 'Human-readable name of the advertising format (e.g., Medium Rectangle, Pre-Roll Video, Native In-Feed).',
    `format_status` STRING COMMENT 'Current lifecycle status of the ad format. Active formats are available for trafficking; deprecated formats are phased out; retired formats are no longer supported.. Valid values are `active|deprecated|pending|retired|draft`',
    `format_subcategory` STRING COMMENT 'Detailed classification within the format category (e.g., banner, interstitial, pre-roll, mid-roll, post-roll, in-stream, out-stream, expandable, takeover).',
    `frequency_cap_recommended` STRING COMMENT 'Recommended frequency cap (number of impressions per user per period) for this format to optimize user experience and campaign performance. Null if no recommendation.',
    `height_pixels` STRING COMMENT 'Standard height dimension of the ad creative in pixels. Null for non-display formats (e.g., audio, print).',
    `iab_format_code` STRING COMMENT 'Official IAB classification code for the ad format, enabling standardized reporting and cross-platform compatibility.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `impression_tracking_pixel_required` BOOLEAN COMMENT 'Indicates whether an impression tracking pixel is required for delivery measurement. True for most digital formats to enable campaign reporting.',
    `is_native_format` BOOLEAN COMMENT 'Indicates whether the ad format is a native advertising format designed to match the form and function of the surrounding content. True for native in-feed, content recommendation, and sponsored content formats.',
    `is_programmatic_eligible` BOOLEAN COMMENT 'Indicates whether the ad format is eligible for programmatic buying via Demand-Side Platforms (DSP) and Real-Time Bidding (RTB). True for formats supported by programmatic infrastructure.',
    `max_file_size_kb` STRING COMMENT 'Maximum allowed file size for the creative asset in kilobytes. Enforced during creative upload and trafficking validation.',
    `placement_position_options` STRING COMMENT 'Comma-separated list of allowed placement positions for this format (e.g., above_the_fold, below_the_fold, in_feed, interstitial, pre_roll, mid_roll, post_roll, sidebar, footer). Used for trafficking and optimization.',
    `retirement_date` DATE COMMENT 'Date when the ad format was fully retired and removed from active use. Null for active and deprecated formats. Format: yyyy-MM-dd.',
    `supports_animation` BOOLEAN COMMENT 'Indicates whether the ad format supports animated creative content (e.g., GIF, HTML5 animation, video). False for static-only formats.',
    `supports_audio` BOOLEAN COMMENT 'Indicates whether the ad format supports audio playback. True for video, audio, and CTV/OTT formats; false for display and print.',
    `supports_interactivity` BOOLEAN COMMENT 'Indicates whether the ad format supports interactive elements (e.g., expandable units, rich media, VPAID). True for formats allowing user engagement beyond click-through.',
    `trafficking_notes` STRING COMMENT 'Free-text field capturing special trafficking instructions, technical requirements, or operational notes for this ad format. Used by trafficking teams during campaign setup.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the ad format record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `vast_version_supported` STRING COMMENT 'Supported VAST specification version for video ad serving (e.g., 2.0, 3.0, 4.0, 4.1, 4.2). Null for non-video formats.',
    `viewability_measurement_supported` BOOLEAN COMMENT 'Indicates whether the ad format supports viewability measurement per Media Rating Council (MRC) standards. True for formats compatible with viewability vendors.',
    `viewability_vendor_compatibility` STRING COMMENT 'Comma-separated list of viewability measurement vendors compatible with this format (e.g., IAS, MOAT, DoubleVerify, Comscore). Used for third-party verification setup.',
    `vpaid_version_supported` STRING COMMENT 'Supported VPAID specification version for interactive video ads (e.g., 1.0, 2.0). Null for non-interactive or non-video formats.',
    `width_pixels` STRING COMMENT 'Standard width dimension of the ad creative in pixels. Null for non-display formats (e.g., audio, print).',
    CONSTRAINT pk_ad_format PRIMARY KEY(`ad_format_id`)
) COMMENT 'Reference catalog of all standardized advertising formats, their creative specifications, and trafficking requirements across channels — including IAB standard display units, video formats (VAST/VPAID), native, audio, OOH/DOOH specs, CTV interstitials, and rich media. Owns format dimensions, file size limits, MIME types, accepted creative file formats, click-through URL structures, impression tracking pixel requirements, viewability measurement vendor compatibility, platform-specific tagging requirements (Google Campaign Manager 360, The Trade Desk), IAB format classification codes, and channel×format trafficking matrices defining which specifications apply per channel context. SSOT for format identity, creative delivery specifications, and trafficking requirements.';

CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`placement` (
    `placement_id` BIGINT COMMENT 'Primary key for placement',
    `ad_channel_id` BIGINT COMMENT 'Foreign key linking to media.ad_channel. Business justification: placement defines specific ad placement positions within a publisher property and channel. Currently placement has no FK to ad_channel. This FK establishes that each placement operates within a specif',
    `ad_format_id` BIGINT COMMENT 'Foreign key linking to media.ad_format. Business justification: placement defines ad positions that support specific ad formats (e.g., 300x250 Banner, Pre-roll Video). Each placement is designed for one primary ad format. This FK links placement to the format spec',
    `publisher_property_id` BIGINT COMMENT 'Foreign key linking to media.publisher_property. Business justification: placement defines specific ad positions within a publisher property (e.g., homepage leaderboard on NYTimes.com). Each placement belongs to one publisher property. This FK establishes the parent-child ',
    CONSTRAINT pk_placement PRIMARY KEY(`placement_id`)
) COMMENT 'Defines specific ad placement positions within a publisher property and channel — e.g., homepage leaderboard, in-stream pre-roll, sidebar rectangle, sponsored post slot, or DOOH screen location. Captures placement-level attributes including position type, above/below-fold classification, viewability rate benchmarks, CPM floor pricing, audience reach, and platform-specific trafficking requirements for Google Campaign Manager 360 and The Trade Desk.';

CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`benchmark` (
    `benchmark_id` BIGINT COMMENT 'Unique identifier for the benchmark record.',
    `ad_channel_id` BIGINT COMMENT 'Foreign key linking to media.ad_channel. Business justification: Benchmark data is channel-specific. Currently channel_type is a STRING; adding channel_id FK to ad_channel provides authoritative channel taxonomy linkage and allows JOIN to retrieve channel_name, cha',
    `ad_format_id` BIGINT COMMENT 'Foreign key linking to media.ad_format. Business justification: Benchmark data is format-specific. Currently ad_format is a STRING; adding ad_format_id FK to ad_format provides authoritative format reference and allows JOIN to retrieve format specifications, IAB c',
    `audience_segment` STRING COMMENT 'The target audience segment or demographic group for which this benchmark is calculated (e.g., adults 18-34, high-income households, in-market auto intenders).',
    `benchmark_code` STRING COMMENT 'Business-assigned unique code identifying this benchmark entry for reference and reporting purposes.. Valid values are `^[A-Z0-9_-]{6,20}$`',
    `benchmark_date` DATE COMMENT 'The date on which this benchmark was published, released, or made available for use in planning and evaluation, in yyyy-MM-dd format.',
    `benchmark_name` STRING COMMENT 'Descriptive name of the benchmark, typically indicating the metric, channel, and segment being measured.',
    `benchmark_status` STRING COMMENT 'Current lifecycle status of the benchmark record indicating whether it is actively used for planning, archived for historical reference, in draft state, under review for validation, or deprecated and no longer applicable.. Valid values are `active|archived|draft|under_review|deprecated`',
    `benchmark_type` STRING COMMENT 'Classification of the benchmark source and methodology: industry standard benchmarks from third-party sources, agency-observed benchmarks from internal campaign data, client-specific benchmarks, competitive benchmarks, historical performance benchmarks, or predictive benchmarks.. Valid values are `industry_standard|agency_observed|client_specific|competitive|historical|predictive`',
    `benchmark_value` DECIMAL(18,2) COMMENT 'The numeric benchmark value for the specified metric, expressed in the unit appropriate to the metric type (percentage for rates, currency for costs, ratio for ROAS).',
    `confidence_level` STRING COMMENT 'Qualitative assessment of the statistical confidence or reliability of this benchmark: high confidence (large sample, rigorous methodology), medium confidence (adequate sample, standard methodology), or low confidence (limited sample, directional only).. Valid values are `high|medium|low`',
    `confidence_score` DECIMAL(18,2) COMMENT 'Numeric confidence score or statistical confidence interval (expressed as a percentage) indicating the reliability and precision of the benchmark value.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the primary country for which this benchmark applies.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this benchmark record was first created in the system, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for monetary benchmark values (CPM, CPC, CPA). Applicable only when benchmark_unit is currency.. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'The origin or provider of the benchmark data: Nielsen Ad Intel, Comscore, IAB industry report, internal historical performance data, The Trade Desk platform data, Google Campaign Manager 360, client-provided benchmarks, or other third-party vendor. [ENUM-REF-CANDIDATE: nielsen_ad_intel|comscore|iab_report|internal_historical|the_trade_desk|google_cm360|client_provided|third_party_vendor — 8 candidates stripped; promote to reference product]',
    `dma_code` STRING COMMENT 'Nielsen Designated Market Area code identifying the specific media market for geographically-scoped benchmarks.. Valid values are `^[0-9]{3}$`',
    `expiration_date` DATE COMMENT 'The date after which this benchmark is considered outdated or no longer applicable for planning purposes, in yyyy-MM-dd format. Nullable for evergreen benchmarks.',
    `geographic_scope` STRING COMMENT 'The geographic scope of the benchmark: national (country-level), regional (multi-state or province), Designated Market Area (DMA), local (city or metro), or global (multi-country).. Valid values are `national|regional|dma|local|global`',
    `is_mrc_accredited` BOOLEAN COMMENT 'Boolean flag indicating whether the data source or measurement methodology for this benchmark is accredited by the Media Rating Council (MRC), ensuring adherence to industry measurement standards.',
    `is_verified` BOOLEAN COMMENT 'Boolean flag indicating whether this benchmark has been reviewed and verified by an internal subject matter expert or data steward for accuracy and applicability.',
    `market_name` STRING COMMENT 'Human-readable name of the geographic market or region to which this benchmark applies.',
    `measurement_period_type` STRING COMMENT 'The time aggregation period over which the benchmark was calculated: daily, weekly, monthly, quarterly, annual, campaign-specific, or custom date range. [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|annual|campaign|custom — 7 candidates stripped; promote to reference product]',
    `methodology_notes` STRING COMMENT 'Detailed notes describing the methodology, calculation approach, data collection process, normalization techniques, and any assumptions or limitations associated with this benchmark.',
    `metric_type` STRING COMMENT 'The specific performance metric being benchmarked: Click-Through Rate (CTR), Cost Per Mille (CPM), Cost Per Click (CPC), Cost Per Acquisition (CPA), View-Through Rate (VTR), viewability rate, Return on Ad Spend (ROAS), completion rate, or engagement rate. [ENUM-REF-CANDIDATE: ctr|cpm|cpc|cpa|vtr|viewability_rate|roas|completion_rate|engagement_rate — 9 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-form text field for additional context, caveats, usage guidance, or special considerations related to this benchmark.',
    `percentile_rank` STRING COMMENT 'The statistical percentile or central tendency measure that this benchmark represents: 10th percentile, 25th percentile (lower quartile), 50th percentile (median), 75th percentile (upper quartile), 90th percentile, mean (average), or median. [ENUM-REF-CANDIDATE: p10|p25|p50|p75|p90|mean|median — 7 candidates stripped; promote to reference product]',
    `period_end_date` DATE COMMENT 'The end date of the measurement period over which this benchmark was calculated, in yyyy-MM-dd format.',
    `period_start_date` DATE COMMENT 'The start date of the measurement period over which this benchmark was calculated, in yyyy-MM-dd format.',
    `planning_cycle` STRING COMMENT 'The planning period or fiscal cycle for which this benchmark is intended to be used (e.g., 2024 Annual Plan, Q1 2024, H2 2024).',
    `sample_size` BIGINT COMMENT 'The number of observations, impressions, campaigns, or data points used to calculate this benchmark, providing context for statistical validity.',
    `unit` STRING COMMENT 'The unit of measure for the benchmark value, indicating whether it represents a percentage, currency amount, ratio, impression count, click count, or conversion count.. Valid values are `percentage|currency|ratio|impressions|clicks|conversions`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this benchmark record was last modified or updated, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `verified_by` STRING COMMENT 'Name or identifier of the individual or team who verified this benchmark record for accuracy and business applicability.',
    `verified_date` DATE COMMENT 'The date on which this benchmark was verified by an internal subject matter expert, in yyyy-MM-dd format.',
    `vertical` STRING COMMENT 'The industry vertical or product category to which this benchmark applies (e.g., automotive, financial services, retail, healthcare, technology, consumer packaged goods).',
    CONSTRAINT pk_benchmark PRIMARY KEY(`benchmark_id`)
) COMMENT 'Stores channel-level performance benchmark data used for media planning, goal-setting, and post-campaign evaluation — including industry-standard and agency-observed benchmarks for CTR, CPM, CPC, CPA, VTR, viewability rate, and ROAS by channel, ad format, vertical, and audience segment. Benchmarks are sourced from Nielsen Ad Intel, Comscore, IAB industry reports, and internal historical performance data.';

CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`channel_rate` (
    `channel_rate_id` BIGINT COMMENT 'Unique identifier for the channel rate record.',
    `ad_channel_id` BIGINT COMMENT 'Foreign key linking to media.ad_channel. Business justification: Rate cards are channel-specific. Currently channel_type is a STRING; adding channel_id FK to ad_channel provides authoritative channel taxonomy linkage and allows JOIN to retrieve channel specificatio',
    `ad_format_id` BIGINT COMMENT 'Foreign key linking to media.ad_format. Business justification: channel_rate currently has ad_format as a STRING attribute. Rate cards specify pricing for specific ad formats (e.g., $25 CPM for 300x250 Banner, $45 CPM for Pre-roll Video). This FK normalizes the ra',
    `programmatic_deal_id` BIGINT COMMENT 'Unique deal identifier for programmatic guaranteed, preferred deal, or private marketplace arrangements.',
    `publisher_id` BIGINT COMMENT 'Identifier for the publisher property or media outlet associated with this rate.',
    `supplier_id` BIGINT COMMENT 'Identifier for the media vendor, publisher, or media owner providing this rate.',
    `agency_commission_pct` DECIMAL(18,2) COMMENT 'Standard agency commission percentage applicable to this rate, typically 15% in traditional media.',
    `audience_segment` STRING COMMENT 'Target audience demographic or behavioral segment associated with this rate (e.g., Adults 18-49, Women 25-54).',
    `cancellation_policy` STRING COMMENT 'Terms and conditions for canceling or modifying buys at this rate, including notice periods and penalties.',
    `country_code` STRING COMMENT 'Three-letter ISO country code indicating the country where this rate applies.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the rate amounts.. Valid values are `^[A-Z]{3}$`',
    `daypart_code` STRING COMMENT 'Code representing the time-of-day segment for broadcast media (e.g., prime, daytime, late-night, early-morning).',
    `discount_pct` DECIMAL(18,2) COMMENT 'Percentage discount applied to the base rate for this tier or negotiated deal.',
    `dma_code` STRING COMMENT 'Nielsen Designated Market Area code for geographic targeting.',
    `dsp_platform` STRING COMMENT 'Name of the Demand-Side Platform if this rate is associated with programmatic buying (e.g., The Trade Desk, DV360).',
    `effective_end_date` DATE COMMENT 'The date on which this rate expires or is no longer valid. Null indicates an open-ended rate.',
    `effective_start_date` DATE COMMENT 'The date from which this rate becomes valid and can be applied to media buys.',
    `floor_cpm` DECIMAL(18,2) COMMENT 'Minimum CPM floor price for programmatic deals or auctions.',
    `gross_rate` DECIMAL(18,2) COMMENT 'The published or negotiated gross rate before any commissions or discounts are applied.',
    `guaranteed_impressions` BIGINT COMMENT 'Minimum number of impressions guaranteed by the vendor at this rate, applicable to guaranteed buys.',
    `makegood_policy` STRING COMMENT 'Description of the makegood or audience deficiency unit (ADU) policy associated with this rate.',
    `market_name` STRING COMMENT 'Geographic market or Designated Market Area (DMA) to which this rate applies.',
    `net_rate` DECIMAL(18,2) COMMENT 'The net rate after agency commission is deducted from the gross rate.',
    `notes` STRING COMMENT 'Additional notes, restrictions, or special conditions associated with this rate.',
    `payment_terms` STRING COMMENT 'Payment terms associated with this rate (e.g., Net 30, Net 60, prepayment required).',
    `pricing_model` STRING COMMENT 'The pricing basis for this rate: Cost Per Mille (CPM), Cost Per Click (CPC), Cost Per Acquisition (CPA), Cost Per View (CPV), Cost Per Completed View (CPCV), flat rate, cost per day, cost per week, or Gross Rating Point (GRP) based. [ENUM-REF-CANDIDATE: cpm|cpc|cpa|cpv|cpcv|flat_rate|cost_per_day|cost_per_week|grp_based — 9 candidates stripped; promote to reference product]',
    `prisma_rate_code` STRING COMMENT 'External reference identifier for this rate in the Mediaocean Prisma media planning and buying system.',
    `rate_card_code` STRING COMMENT 'Unique business identifier for the rate card, typically assigned by the vendor or publisher.',
    `rate_card_name` STRING COMMENT 'Descriptive name of the rate card, often including the publisher, channel, and market context.',
    `rate_source` STRING COMMENT 'Origin or source of this rate information.. Valid values are `vendor_published|direct_negotiation|agency_negotiation|programmatic_platform|rate_card_database`',
    `rate_status` STRING COMMENT 'Current lifecycle status of the rate card entry.. Valid values are `active|inactive|pending|expired|superseded`',
    `rate_type` STRING COMMENT 'Classification of the rate based on how it was established: published standard rate, negotiated custom rate, spot market rate, upfront commitment, programmatic guaranteed, preferred deal, or private auction. [ENUM-REF-CANDIDATE: published|negotiated|spot|upfront|programmatic_guaranteed|preferred_deal|private_auction — 7 candidates stripped; promote to reference product]',
    `ssp_exchange` STRING COMMENT 'Name of the Supply-Side Platform or ad exchange if this rate is associated with programmatic inventory.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate record was last modified.',
    `volume_tier_max` BIGINT COMMENT 'Maximum volume threshold (impressions, spend, or units) for this rate tier. Null indicates no upper limit.',
    `volume_tier_min` BIGINT COMMENT 'Minimum volume threshold (impressions, spend, or units) required to qualify for this rate tier.',
    `volume_tier_name` STRING COMMENT 'Name or label of the volume discount tier (e.g., Bronze, Silver, Gold, Platinum) if this rate is part of a tiered pricing structure.',
    CONSTRAINT pk_channel_rate PRIMARY KEY(`channel_rate_id`)
) COMMENT 'Reference master for published and negotiated media rate card pricing from vendors, publishers, and media owners across all markets, channels, and currencies — including gross/net CPM, CPV, CPC, flat rates, and volume discount tiers.';

CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`compliance_rule` (
    `compliance_rule_id` BIGINT COMMENT 'Unique identifier for the compliance rule record. Primary key.',
    `ad_channel_id` BIGINT COMMENT 'Foreign key linking to media.ad_channel. Business justification: Compliance rules are channel-specific. Currently channel_type is a STRING; adding channel_id FK to ad_channel provides authoritative channel linkage and allows JOIN to retrieve channel taxonomy, platf',
    `ssp_platform_id` BIGINT COMMENT 'Foreign key linking to media.ssp_platform. Business justification: Compliance rules are often SSP-specific (e.g., platform-specific ad policies). Currently platform_name is a STRING; adding ssp_platform_id FK to ssp_platform provides authoritative platform reference ',
    `ad_format_restrictions` STRING COMMENT 'Description of ad format or creative specifications that are restricted or required under this compliance rule (e.g., IAB LEAN ad standards limiting file size and animation, VAST/VPAID requirements for video ads).',
    `applies_to_direct_buy` BOOLEAN COMMENT 'Indicates whether this compliance rule applies to direct media buys negotiated with publishers through insertion orders and managed campaigns.',
    `applies_to_programmatic` BOOLEAN COMMENT 'Indicates whether this compliance rule applies to programmatic advertising buys executed through DSPs (Demand-Side Platforms), SSPs (Supply-Side Platforms), and RTB (Real-Time Bidding) exchanges.',
    `audit_trail_required` BOOLEAN COMMENT 'Indicates whether this compliance rule mandates the creation and retention of an audit trail documenting compliance verification, user consent, or enforcement actions.',
    `brand_safety_tier` STRING COMMENT 'The brand safety classification level required by this compliance rule, determining the acceptable risk level for ad placement adjacency to content (e.g., high-risk content exclusion, moderate filtering, minimal filtering).. Valid values are `high|medium|low|custom`',
    `consent_mechanism` STRING COMMENT 'Description of the technical or procedural mechanism used to capture and validate user consent for this compliance rule (e.g., CMP integration, opt-in checkbox, consent string, IAB TCF framework).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this compliance rule record was first created in the system.',
    `data_retention_days` STRING COMMENT 'The maximum number of days that user data or advertising activity data may be retained under this compliance rule, after which it must be deleted or anonymized per privacy regulations.',
    `disclosure_requirement` STRING COMMENT 'Description of the mandatory disclosure or labeling that must accompany advertising under this compliance rule (e.g., Paid Partnership, Sponsored, Ad, FTC endorsement disclosure).',
    `effective_date` DATE COMMENT 'The date from which this compliance rule becomes enforceable and must be applied to campaign trafficking and creative approval workflows.',
    `enforcement_level` STRING COMMENT 'The severity of enforcement for this compliance rule. Mandatory rules block campaign trafficking if violated, recommended rules generate warnings but allow override, and advisory rules provide guidance without enforcement.. Valid values are `mandatory|recommended|advisory`',
    `expiration_date` DATE COMMENT 'The date on which this compliance rule ceases to be enforceable. Null indicates an open-ended rule with no planned expiration.',
    `frequency_cap_limit` STRING COMMENT 'The maximum number of times an ad may be shown to a single user within the frequency cap period, as mandated by this compliance rule to prevent ad fatigue or harassment.',
    `frequency_cap_period` STRING COMMENT 'The time period over which the frequency cap limit is enforced (e.g., per hour, per day, per week, per month, per campaign lifetime).. Valid values are `hour|day|week|month|campaign`',
    `governing_body` STRING COMMENT 'The regulatory authority, platform, or industry organization that mandates or publishes this compliance rule (e.g., FTC, ASA, EASA, Google, Meta, IAB, TAG).',
    `jurisdiction` STRING COMMENT 'The geographic or legal jurisdiction where this compliance rule applies, using ISO 3166-1 alpha-3 country codes or regional identifiers (e.g., USA, GBR, EUR, global).',
    `last_reviewed_date` DATE COMMENT 'The date on which this compliance rule was last reviewed and validated for accuracy and currency by the compliance team.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic review of this compliance rule to ensure it remains current with regulatory changes and platform policy updates.',
    `penalty_description` STRING COMMENT 'Description of the legal, financial, or operational penalties that may result from violating this compliance rule (e.g., fines, account suspension, legal action, reputational damage).',
    `reference_document_code` STRING COMMENT 'The official document identifier, regulation number, or policy code that formally defines this compliance rule (e.g., GDPR Article 6, FTC Act Section 5, IAB LEAN Ad Standard).',
    `reference_url` STRING COMMENT 'The web URL linking to the official documentation, regulation text, or policy page that defines this compliance rule.. Valid values are `^https?://.*$`',
    `requires_consent` BOOLEAN COMMENT 'Indicates whether this compliance rule mandates explicit user consent before the advertising activity can proceed (e.g., GDPR consent for targeted advertising, CCPA opt-out mechanisms).',
    `restricted_audience_segments` STRING COMMENT 'Comma-separated list of audience segments or demographic groups that cannot be targeted under this compliance rule (e.g., minors under 13, sensitive health conditions, protected classes).',
    `restricted_content_types` STRING COMMENT 'Comma-separated list of content types or product categories that are restricted or prohibited under this compliance rule (e.g., alcohol, tobacco, gambling, pharmaceuticals, political advertising).',
    `rule_category` STRING COMMENT 'The functional category of the compliance requirement. Disclosure rules mandate advertiser identification, consent rules govern user permission for data usage, targeting rules restrict audience segmentation, creative content rules limit ad messaging, data usage rules govern PII handling, and measurement rules define verification standards.. Valid values are `disclosure|consent|targeting|creative_content|data_usage|measurement`',
    `rule_code` STRING COMMENT 'Unique business identifier code for the compliance rule, used for external reference and system integration.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `rule_description` STRING COMMENT 'Detailed narrative description of the compliance rule, including the specific requirement, the business rationale, and the enforcement mechanism.',
    `rule_name` STRING COMMENT 'Human-readable name of the compliance rule for identification and reporting purposes.',
    `rule_status` STRING COMMENT 'Current lifecycle status of the compliance rule. Active rules are enforced in trafficking workflows, inactive rules are not enforced, pending rules are awaiting approval, deprecated rules are phased out, and suspended rules are temporarily disabled.. Valid values are `active|inactive|pending|deprecated|suspended`',
    `rule_type` STRING COMMENT 'Classification of the compliance rule by its governing authority or purpose. Regulatory rules are mandated by law, platform policies are vendor-specific, industry standards are self-regulatory, brand safety rules protect advertiser reputation, privacy rules govern data usage, and content restrictions limit creative content.. Valid values are `regulatory|platform_policy|industry_standard|brand_safety|privacy|content_restriction`',
    `third_party_verification_required` BOOLEAN COMMENT 'Indicates whether this compliance rule requires third-party verification or certification (e.g., TAG certification, MRC accreditation, IAS or DoubleVerify brand safety verification).',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this compliance rule record was last modified in the system.',
    `verification_vendor` STRING COMMENT 'The name of the third-party verification vendor or service provider used to validate compliance with this rule (e.g., Integral Ad Science, DoubleVerify, MOAT, Comscore).',
    `viewability_threshold_pct` DECIMAL(18,2) COMMENT 'The minimum viewability percentage required by this compliance rule for an ad impression to be counted as valid, per MRC (Media Rating Council) standards (e.g., 50% of pixels in view for 1 second for display, 2 seconds for video).',
    `violation_action` STRING COMMENT 'The system action taken when this compliance rule is violated during campaign trafficking or creative approval. Block prevents the action, warn notifies the user but allows override, log records the violation silently, and escalate routes to compliance review.. Valid values are `block|warn|log|escalate`',
    CONSTRAINT pk_compliance_rule PRIMARY KEY(`compliance_rule_id`)
) COMMENT 'Stores regulatory and platform-specific compliance rules governing advertising delivery on each channel — including FTC disclosure requirements, ASA/EASA advertising standards, GDPR/CCPA consent requirements for digital targeting, IAB LEAN ad standards, platform-specific content policies (e.g., Google, Meta, TikTok), and OOH/DOOH regulatory restrictions by geography. Used to enforce compliance during campaign trafficking and creative approval workflows.';

CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`availability` (
    `availability_id` BIGINT COMMENT 'Unique identifier for the inventory availability record.',
    `ad_channel_id` BIGINT COMMENT 'Reference to the media channel for which availability is tracked.',
    `ad_format_id` BIGINT COMMENT 'Foreign key linking to media.ad_format. Business justification: Inventory availability is format-specific. Currently ad_format is a STRING; adding ad_format_id FK to ad_format provides authoritative format reference and allows JOIN to retrieve format specification',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Inventory availability is forecasted by audience segment for media planning and buying. Planners require segment-level availability data to assess feasibility of audience targeting strategies and nego',
    `media_placement_id` BIGINT COMMENT 'Reference to the specific placement or ad unit for which availability is reported.',
    `programmatic_deal_id` BIGINT COMMENT 'The programmatic deal identifier associated with this availability, if applicable (e.g., private marketplace deal ID).',
    `publisher_id` BIGINT COMMENT 'Reference to the publisher property offering the inventory.',
    `availability_code` STRING COMMENT 'Business identifier or code for this availability record, often sourced from SSP or publisher systems.',
    `availability_status` STRING COMMENT 'Current lifecycle status of the inventory: available for purchase, sold out, reserved for a campaign, blacked out, or pending confirmation.. Valid values are `available|sold|reserved|blackout|pending`',
    `availability_type` STRING COMMENT 'Classification of the availability record: real-time snapshot, forecasted projection, reserved inventory, guaranteed deal, or non-guaranteed open market.. Valid values are `real_time|forecasted|reserved|guaranteed|non_guaranteed`',
    `available_impressions` BIGINT COMMENT 'Number of impressions currently available for purchase or reservation.',
    `blackout_end_date` DATE COMMENT 'The end date of a blackout period during which inventory is unavailable for sale.',
    `blackout_reason` STRING COMMENT 'Explanation for why inventory is blacked out (e.g., publisher maintenance, seasonal unavailability, exclusive deal).',
    `blackout_start_date` DATE COMMENT 'The start date of a blackout period during which inventory is unavailable for sale.',
    `channel_type` STRING COMMENT 'The media channel type for this availability: display, video, audio, native, Connected TV (CTV), Over-the-Top (OTT), Digital Out-of-Home (DOOH), Out-of-Home (OOH), search, or social. [ENUM-REF-CANDIDATE: display|video|audio|native|ctv|ott|dooh|ooh|search|social — 10 candidates stripped; promote to reference product]',
    `confidence_score` DECIMAL(18,2) COMMENT 'Statistical confidence score (0-100) indicating the reliability of the forecasted availability, based on historical data quality and model accuracy.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the geographic market.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this availability record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this record.. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'The system or platform from which this availability data was sourced (e.g., The Trade Desk, Google Ad Manager, publisher direct API).',
    `daypart` STRING COMMENT 'The time-of-day segment (e.g., prime time, daytime, late night) for which availability is reported, relevant for broadcast and streaming inventory.',
    `device_type` STRING COMMENT 'The device type on which the inventory is available: desktop, mobile, tablet, Connected TV (CTV), or smart display.. Valid values are `desktop|mobile|tablet|ctv|smart_display`',
    `dma_code` STRING COMMENT 'The Nielsen Designated Market Area code identifying the geographic market.',
    `dsp_platform` STRING COMMENT 'The Demand-Side Platform through which this inventory is accessible for programmatic buying.',
    `effective_end_date` DATE COMMENT 'The end date of the period for which this availability applies.',
    `effective_start_date` DATE COMMENT 'The start date of the period for which this availability applies.',
    `environment_type` STRING COMMENT 'The digital environment where the inventory is served: web, mobile web, mobile app, Connected TV (CTV), or Digital Out-of-Home (DOOH).. Valid values are `web|mobile_web|mobile_app|ctv|dooh`',
    `floor_cpm` DECIMAL(18,2) COMMENT 'The minimum Cost Per Mille (CPM) rate at which the publisher will sell this inventory.',
    `forecast_date` DATE COMMENT 'The date on which the availability forecast was generated or last updated.',
    `forecast_methodology` STRING COMMENT 'Description of the forecasting method or algorithm used to generate availability projections (e.g., time-series model, machine learning, historical average).',
    `market_name` STRING COMMENT 'The geographic market or Designated Market Area (DMA) for which this availability applies.',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context about this availability record, such as special conditions or planner observations.',
    `remaining_capacity_pct` DECIMAL(18,2) COMMENT 'Percentage of total inventory capacity that remains available for sale, calculated as (available_impressions / total_impressions) * 100.',
    `reserved_impressions` BIGINT COMMENT 'Number of impressions reserved but not yet confirmed or trafficked.',
    `seasonal_demand_signal` STRING COMMENT 'Indicator of expected demand intensity for the period: low, medium, high, or peak, used to inform pricing and planning decisions.. Valid values are `low|medium|high|peak`',
    `sold_impressions` BIGINT COMMENT 'Number of impressions already sold or committed to campaigns.',
    `source_system_ref` STRING COMMENT 'External reference identifier or key from the source system (SSP, DSP, or publisher platform) for traceability.',
    `ssp_exchange` STRING COMMENT 'The Supply-Side Platform or ad exchange offering this inventory for sale.',
    `total_impressions` BIGINT COMMENT 'Total impression volume available for the specified channel, placement, and period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this availability record was last updated or refreshed.',
    CONSTRAINT pk_availability PRIMARY KEY(`availability_id`)
) COMMENT 'Tracks real-time and forecasted inventory availability for channel placements — capturing available impression volumes, sold/reserved inventory, remaining capacity, blackout dates, and seasonal demand signals by channel, publisher property, placement, and ad format. Sourced from SSP inventory forecasting APIs (The Trade Desk, Google Ad Manager) and publisher direct avails responses. Used by media planners to validate inventory feasibility during campaign planning and by programmatic traders to identify supply opportunities.';

CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`flowchart` (
    `flowchart_id` BIGINT COMMENT 'Unique identifier for the media flowchart record. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the client (advertiser) for whom this flowchart was prepared.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Flowcharts present media plans for specific brands to clients. Brand profile provides brand guidelines, positioning, tone, and approval requirements essential for client presentation formatting and pl',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign this flowchart supports.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Flowcharts used in budget presentations and approvals require cost center context for financial planning and resource allocation decisions.',
    `creative_brief_id` BIGINT COMMENT 'Foreign key linking to creative.creative_brief. Business justification: Flowcharts visualize media plans built from creative briefs. Planners reference the brief for audience targeting, messaging strategy, and deliverable requirements when presenting flowcharts to clients',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Media flowcharts are project artifacts tracked in project management systems. Currently workfront_project_id is stored as an unlinked string. Normalizing to initiative_id FK enables joining to project',
    `plan_id` BIGINT COMMENT 'Reference to the internal media plan that this flowchart visualizes and summarizes for client presentation.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Flowcharts are client-facing deliverables produced under SOW terms. Linking flowcharts to SOWs enables deliverable tracking, client acceptance workflow, and supports billing for planning services spec',
    `persona_id` BIGINT COMMENT 'Foreign key linking to audience.persona. Business justification: Media flowcharts present campaign strategy against target personas for client presentations and approvals. Account teams use persona linkage to communicate audience targeting rationale and align media',
    `worker_id` BIGINT COMMENT 'Reference to the media planner responsible for creating and maintaining this flowchart.',
    `revised_from_flowchart_id` BIGINT COMMENT 'Self-referencing FK on flowchart (revised_from_flowchart_id)',
    `account_executive_name` STRING COMMENT 'Name of the account executive who presented the flowchart to the client.',
    `approval_date` DATE COMMENT 'Date when the client formally approved the flowchart, authorizing media buying to proceed.',
    `approval_status` STRING COMMENT 'Current approval state of the flowchart in the client review and authorization workflow.. Valid values are `draft|presented|client_approved|revised|rejected|archived`',
    `approved_by_name` STRING COMMENT 'Name of the client representative who authorized the flowchart.',
    `approved_by_title` STRING COMMENT 'Job title of the client representative who authorized the flowchart.',
    `channel_summary_json` STRING COMMENT 'JSON structure containing summary-level spend allocations by channel with percentage splits and key metrics for flowchart visualization.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the flowchart record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in the flowchart.. Valid values are `^[A-Z]{3}$`',
    `export_file_path` STRING COMMENT 'Storage location or URI of the exported flowchart file for client delivery and archival.',
    `export_format` STRING COMMENT 'File format in which the flowchart was exported for client delivery.. Valid values are `pdf|excel|powerpoint|google_slides`',
    `flight_end_date` DATE COMMENT 'End date of the media campaign flight period covered by this flowchart.',
    `flight_start_date` DATE COMMENT 'Start date of the media campaign flight period covered by this flowchart.',
    `flighting_pattern_json` STRING COMMENT 'JSON structure containing time-based spend distribution data for visual flighting pattern representation in the flowchart.',
    `flowchart_name` STRING COMMENT 'Descriptive name of the media flowchart, typically reflecting campaign name and planning period.',
    `flowchart_number` STRING COMMENT 'Business identifier for the flowchart, used in client communications and internal tracking.',
    `frequency_target` DECIMAL(18,2) COMMENT 'Target average number of exposures per reached individual, as specified in the flowchart.',
    `grp_target` DECIMAL(18,2) COMMENT 'Total GRP delivery target shown on the flowchart for broadcast media components.',
    `impression_target` BIGINT COMMENT 'Total planned impression delivery across all digital and programmatic channels shown in the flowchart.',
    `market_breakout` STRING COMMENT 'Geographic segmentation approach used in the flowchart (national, spot markets, DMA-level, etc.).. Valid values are `national|spot|local|dma|regional|custom`',
    `notes` STRING COMMENT 'Additional notes, assumptions, or clarifications included in the flowchart for client understanding.',
    `planner_name` STRING COMMENT 'Name of the media planner who created the flowchart, for client reference and internal accountability.',
    `presentation_date` DATE COMMENT 'Date when the flowchart was presented to the client for review and approval.',
    `primary_kpi` STRING COMMENT 'Primary success metric for the campaign as documented in the flowchart (e.g., reach, conversions, brand lift).',
    `prisma_flowchart_code` STRING COMMENT 'External identifier from Mediaocean Prisma system linking this flowchart to the media planning platform.',
    `reach_target_pct` DECIMAL(18,2) COMMENT 'Target percentage of the audience to be reached at least once, as specified in the flowchart.',
    `time_granularity` STRING COMMENT 'Time period breakdown used in the flowchart for spend allocation visualization (weekly, monthly, quarterly).. Valid values are `weekly|monthly|quarterly|custom`',
    `total_flowchart_budget` DECIMAL(18,2) COMMENT 'Total media spend amount shown on the flowchart across all channels, markets, and flight periods.',
    `trp_target` DECIMAL(18,2) COMMENT 'Total TRP delivery target shown on the flowchart for target audience-specific media components.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the flowchart record was last modified, tracking revisions and updates.',
    `version_number` STRING COMMENT 'Sequential version number tracking revisions to the flowchart as client feedback is incorporated.',
    CONSTRAINT pk_flowchart PRIMARY KEY(`flowchart_id`)
) COMMENT 'Master record representing the client-facing media flowchart — the primary planning deliverable produced by media planners showing the visual/tabular allocation of media spend across channels, vehicles, markets, and flight periods. Captures flowchart name, associated media plan reference (FK to media_plan), client, campaign, version number, presentation date, approval status (draft, presented, client-approved, revised), total flowchart budget, time granularity (weekly, monthly, quarterly), market breakout (national, spot, local), channel summary allocations with percentage splits, flighting pattern visualization data, and export format (PDF, Excel, PowerPoint). Serves as the bridge between internal media plan detail and client-approved spending authorization — the document clients sign off on before buying begins. Distinct from media_plan (internal strategy document) and media_plan_line (granular execution detail) in that it represents the client-approved spending visualization at summary level.';

CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`channel_supplier_agreement` (
    `channel_supplier_agreement_id` BIGINT COMMENT 'Unique identifier for this channel-supplier agreement record. Primary key.',
    `ad_channel_id` BIGINT COMMENT 'Foreign key linking to the advertising channel in this agreement',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to the supplier in this agreement',
    `agreement_status` STRING COMMENT 'Current lifecycle status of this channel-supplier agreement. Values: active, pending, expired, terminated.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this channel-supplier agreement record was created in the system.',
    `effective_date` DATE COMMENT 'Date when this channel-supplier agreement becomes effective and the negotiated terms apply.',
    `expiration_date` DATE COMMENT 'Date when this channel-supplier agreement expires and terms must be renegotiated. Null indicates evergreen agreement.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this channel-supplier agreement record was last modified.',
    `minimum_spend_commitment` DECIMAL(18,2) COMMENT 'Minimum media spend commitment (in agreement currency) that the agency has committed to with this supplier on this channel during the agreement period. Used for volume discount qualification.',
    `negotiated_commission_pct` DECIMAL(18,2) COMMENT 'Agency commission percentage negotiated with this supplier for media bought through this specific channel. Channel-supplier specific rate that may differ from standard supplier terms.',
    `preferred_status` STRING COMMENT 'Indicates the suppliers preferred vendor status for this specific channel. Preferred suppliers receive priority consideration in media planning. Values: preferred, approved, restricted, inactive.',
    `sla_terms` STRING COMMENT 'Free-text description of service level agreement terms specific to this channel-supplier relationship, including response times, reporting frequency, and performance guarantees.',
    CONSTRAINT pk_channel_supplier_agreement PRIMARY KEY(`channel_supplier_agreement_id`)
) COMMENT 'This association product represents the commercial agreement between an advertising channel and a supplier (media publisher or technology platform). It captures channel-specific supplier relationships including preferred vendor status, negotiated commission rates, spend commitments, and service level agreements. Each record links one ad_channel to one supplier with attributes that exist only in the context of this channel-supplier partnership. This is the operational SSOT for media buying teams to understand which suppliers are approved and preferred for each channel, and what commercial terms apply.. Existence Justification: In advertising operations, suppliers (publishers and tech platforms) provide inventory and services across multiple advertising channels (Google Search, Facebook Social, programmatic display, CTV, etc.), and each channel sources from multiple suppliers. Agencies negotiate channel-specific commercial agreements with suppliers that include unique commission rates, spend commitments, preferred vendor status, and SLA terms that vary by channel-supplier combination. Media buying teams actively manage these relationships to determine which suppliers are approved for each channel and what commercial terms apply.';

CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`format_availability` (
    `format_availability_id` BIGINT COMMENT 'Unique identifier for this publisher-format availability record. Primary key.',
    `ad_format_id` BIGINT COMMENT 'Foreign key linking to the ad format specification',
    `programmatic_deal_id` BIGINT COMMENT 'Programmatic deal ID for preferred access to this format from this publisher, if applicable. Links to PMP or programmatic guaranteed deals.',
    `publisher_id` BIGINT COMMENT 'Foreign key linking to the publisher offering this format',
    `availability_status` STRING COMMENT 'Current availability status of this format from this publisher. Drives media planning feasibility decisions.',
    `average_cpm` DECIMAL(18,2) COMMENT 'Historical average CPM achieved for this format from this publisher. Used for budget forecasting and media planning.',
    `brand_safety_tier` STRING COMMENT 'Brand safety classification for this format from this publisher. Publisher-format combination may have different brand safety profiles than publisher alone (e.g., pre-roll video vs. display on same site).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this format availability record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this format was discontinued by this publisher, if applicable. Null for currently available formats.',
    `effective_start_date` DATE COMMENT 'Date from which this format became available from this publisher. Supports historical tracking of format rollout.',
    `floor_cpm` DECIMAL(18,2) COMMENT 'Minimum CPM rate for this format from this publisher. Publisher-format specific pricing floor used in programmatic bidding and direct negotiations.',
    `last_updated_date` DATE COMMENT 'Date when availability, pricing, or performance metrics were last refreshed for this publisher-format combination.',
    `monthly_impressions` BIGINT COMMENT 'Estimated monthly impression volume available for this format from this publisher. Critical for reach and frequency planning.',
    `notes` STRING COMMENT 'Free-text notes capturing special trafficking requirements, seasonal availability patterns, or format-specific constraints for this publisher.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this format availability record.',
    `viewability_rate` DECIMAL(18,2) COMMENT 'MRC-measured viewability rate for this format from this publisher. Publisher-format specific performance metric used in media quality evaluation.',
    CONSTRAINT pk_format_availability PRIMARY KEY(`format_availability_id`)
) COMMENT 'This association product represents the availability and commercial terms of specific ad formats offered by publishers. It captures format-specific inventory availability, pricing, performance metrics, and brand safety attributes that exist only in the context of a publisher-format combination. Each record links one ad_format to one publisher with commercial and operational attributes managed by media planning and buying teams.. Existence Justification: In advertising operations, publishers offer multiple ad formats (display, video, native, audio, DOOH) and each format is available from multiple publishers. Media planners actively manage format availability across publishers, tracking format-specific pricing (floor CPM, average CPM), inventory volume (monthly impressions), and performance metrics (viewability rate, brand safety tier) that exist only at the publisher-format combination level. Rate cards, availability forecasts, and programmatic deals are negotiated and tracked per publisher-format pair.';

CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`io_creative_trafficking` (
    `io_creative_trafficking_id` BIGINT COMMENT 'Unique surrogate identifier for this IO-creative trafficking assignment record',
    `worker_id` BIGINT COMMENT 'Reference to the user who approved this creative asset for this IO. Establishes accountability for creative approval decisions',
    `creative_asset_id` BIGINT COMMENT 'Foreign key linking to the creative asset being trafficked to this IO',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to the media insertion order receiving this creative asset',
    `approval_date` DATE COMMENT 'Date when this creative asset was approved for use in this specific IO by the client or agency stakeholder',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this trafficking assignment record was first created in the source system',
    `creative_status` STRING COMMENT 'Current workflow status of this creative asset within this IO. Tracks progression from trafficking through live execution to completion. Values: pending_trafficking, trafficked, live, paused, completed, rejected',
    `flight_end_date` DATE COMMENT 'Last date this specific creative asset is authorized to run under this IO. May differ from IO-level flight dates for sequential creative rotation strategies',
    `flight_start_date` DATE COMMENT 'First date this specific creative asset is authorized to run under this IO. May differ from IO-level flight dates for sequential creative rotation strategies',
    `rotation_weight` DECIMAL(18,2) COMMENT 'Percentage or weight assigned to this creative asset in the rotation pool for this IO. Used for A/B testing and creative optimization. Sum of weights across all creatives on an IO typically equals 100.',
    `trafficking_date` DATE COMMENT 'Date when this creative asset was trafficked (assigned) to this IO in the ad server or trafficking system',
    `trafficking_notes` STRING COMMENT 'Free-text notes from traffickers regarding special handling, technical requirements, or execution instructions for this creative-IO pairing',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this trafficking assignment record was last modified in the source system',
    CONSTRAINT pk_io_creative_trafficking PRIMARY KEY(`io_creative_trafficking_id`)
) COMMENT 'This association product represents the operational trafficking relationship between media insertion orders and creative assets. It captures the assignment of specific creative assets to specific IOs for execution, including flight dates, rotation weights, trafficking status, and approval workflows. Each record links one IO to one creative asset with attributes that exist only in the context of this trafficking assignment.. Existence Justification: In advertising operations, a single IO routinely executes with multiple creative assets simultaneously (A/B testing, format variations for display/video/mobile, sequential messaging strategies, dayparting rotations). Conversely, a single creative asset is frequently trafficked across multiple IOs when campaigns span multiple publishers, extended flight periods requiring separate IOs, or when the same creative is reused across different advertiser campaigns. The trafficking relationship itself is an operational business process managed by media traffickers.';

CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`allocation` (
    `allocation_id` BIGINT COMMENT 'Unique surrogate identifier for this allocation record linking a work package to a media plan',
    `plan_id` BIGINT COMMENT 'Foreign key linking to the media plan receiving allocated work effort and budget from the work package',
    `work_package_id` BIGINT COMMENT 'Foreign key linking to the work package providing allocated effort and budget to the media plan',
    `actual_effort_hours` DECIMAL(18,2) COMMENT 'Actual labor hours expended from the work package on this media plan. Tracked from time entry systems where workers log hours against both work package and media plan. Used for effort variance analysis and productivity metrics.',
    `actual_spend_from_work_package` DECIMAL(18,2) COMMENT 'Actual cost incurred from the work package allocated to this media plan. Derived from work_package.actual_cost multiplied by allocation_percentage. Used for cost variance analysis and billing attribution.',
    `allocated_effort_hours` DECIMAL(18,2) COMMENT 'Planned labor hours from the work package allocated to this media plan. Derived from work_package.planned_effort_hours multiplied by allocation_percentage. Used for resource capacity planning and utilization tracking.',
    `billing_status` STRING COMMENT 'Current billing lifecycle status of this allocation. Tracks whether the allocated work is billable to the client and the invoicing state. Values: not_billable (internal overhead), billable (ready to invoice), billed (included in draft invoice), invoiced (sent to client), paid (payment received).',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this allocation record was created in the system. Used for audit trail and allocation history tracking.',
    `end_date` DATE COMMENT 'Date when this work package allocation to the media plan concludes. May differ from work_package.planned_end_date if the allocation is time-bounded to a specific phase of the media plan (e.g., planning phase only, not buying phase).',
    `modified_date` TIMESTAMP COMMENT 'Timestamp when this allocation record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-form text field for additional context about this allocation, including rationale for allocation percentage, special billing arrangements, scope clarifications, or cross-charging instructions.',
    `percentage` DECIMAL(18,2) COMMENT 'Percentage of the work package effort and cost allocated to this specific media plan. Enables proportional distribution when one work package supports multiple media plans. Sum of allocation_percentage across all media plans for a given work package should equal 100.',
    `planned_spend_from_work_package` DECIMAL(18,2) COMMENT 'Planned cost amount from the work package budget allocated to this media plan. Derived from work_package.planned_cost multiplied by allocation_percentage. Used for budget planning and cost forecasting at the media plan level.',
    `start_date` DATE COMMENT 'Date when this work package allocation to the media plan becomes active. May differ from work_package.planned_start_date if the work package supports the media plan only during a portion of its lifecycle (e.g., work package spans Q1-Q2 but only allocated to this media plan during Q1).',
    CONSTRAINT pk_allocation PRIMARY KEY(`allocation_id`)
) COMMENT 'This association product represents the allocation relationship between media_plan and work_package. It captures the distribution of project work effort and budget across media execution artifacts. Each record links one media_plan to one work_package with attributes that track how project resources (time, cost, budget) are allocated to specific media planning and buying deliverables, enabling cross-charging, billing attribution, and effort tracking across the project-to-media boundary.. Existence Justification: In advertising agency operations, media plans and work packages represent different organizational views of the same work: media plans organize by client deliverable and media execution artifact, while work packages organize by project structure and resource allocation. A single media plan (e.g., Q1 Digital Campaign for Client X) typically requires effort from multiple work packages (Media Planning, Media Buying, Trafficking, Optimization), and a single work package (e.g., Media Buying Q1) typically supports multiple client media plans simultaneously. The allocation relationship tracks how project resources (effort hours, costs) are distributed across media execution artifacts for billing attribution, cost tracking, and resource utilization analysis.';

CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`plan_asset_assignment` (
    `plan_asset_assignment_id` BIGINT COMMENT 'Unique surrogate identifier for the plan-asset assignment record',
    `worker_id` BIGINT COMMENT 'Reference to the media planner or user who assigned this creative asset to the media plan. Supports accountability and audit trail.',
    `creative_asset_id` BIGINT COMMENT 'Foreign key linking to the creative asset assigned to the media plan',
    `plan_id` BIGINT COMMENT 'Foreign key linking to the media plan to which the creative asset is assigned',
    `assignment_date` TIMESTAMP COMMENT 'Timestamp when this creative asset was assigned to the media plan. Tracks planning workflow history.',
    `assignment_notes` STRING COMMENT 'Free-text notes about this specific plan-asset assignment, including rationale, special instructions, or trafficking notes.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this plan-asset assignment (planned, approved, trafficked, live, paused, completed, cancelled). Tracks progression from planning through execution.',
    `channel_assignment` STRING COMMENT 'Comma-separated list of specific media channels for which this asset is assigned within the plan (e.g., digital_display, social_paid, video_pre_roll). Enables channel-specific creative assignments when a plan spans multiple channels.',
    `market_assignment` STRING COMMENT 'Comma-separated list of specific geographic markets or DMAs for which this asset is assigned within the plan. Enables market-specific creative localization (e.g., NYC gets one asset, LA gets another).',
    `planned_usage_end_date` DATE COMMENT 'The date on which this creative asset is planned to stop running as part of this media plan. Enables phased creative rotation strategies.',
    `planned_usage_start_date` DATE COMMENT 'The date on which this creative asset is planned to begin running as part of this media plan. May differ from the overall plan flight dates if assets are rotated or phased.',
    `rotation_weight` DECIMAL(18,2) COMMENT 'The relative weight or percentage of impressions allocated to this creative asset within the media plan. Used when multiple assets are running simultaneously in a rotation strategy (e.g., 60/40 split between two assets).',
    `trafficking_priority` STRING COMMENT 'Priority level for trafficking this asset to media vendors and platforms (high, medium, low, standard). Indicates urgency and sequencing for the trafficking team during campaign execution.',
    CONSTRAINT pk_plan_asset_assignment PRIMARY KEY(`plan_asset_assignment_id`)
) COMMENT 'This association product represents the planned assignment of creative assets to media plans during the media planning phase. It captures which creative assets are planned for use in which media plans, including planned usage timing, rotation weighting, channel-specific assignments, market-specific assignments, and trafficking priority. Each record links one media plan to one creative asset with attributes that exist only in the context of this planned usage relationship.. Existence Justification: In advertising operations, media plans routinely use multiple creative assets to support different channels, markets, formats, and rotation strategies within a single plan. Conversely, creative assets—especially evergreen brand assets, seasonal campaign assets, and multi-market assets—are reused across multiple media plans over time. The business actively manages these assignments during the media planning phase, tracking planned usage dates, rotation weights, channel/market assignments, and trafficking priorities for each plan-asset pairing.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_ad_channel_id` FOREIGN KEY (`ad_channel_id`) REFERENCES `advertising_ecm`.`media`.`ad_channel`(`ad_channel_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_publisher_property_id` FOREIGN KEY (`publisher_property_id`) REFERENCES `advertising_ecm`.`media`.`publisher_property`(`publisher_property_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ADD CONSTRAINT `fk_media_plan_line_ad_channel_id` FOREIGN KEY (`ad_channel_id`) REFERENCES `advertising_ecm`.`media`.`ad_channel`(`ad_channel_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ADD CONSTRAINT `fk_media_plan_line_ad_format_id` FOREIGN KEY (`ad_format_id`) REFERENCES `advertising_ecm`.`media`.`ad_format`(`ad_format_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ADD CONSTRAINT `fk_media_plan_line_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ADD CONSTRAINT `fk_media_plan_line_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ADD CONSTRAINT `fk_media_plan_line_programmatic_deal_id` FOREIGN KEY (`programmatic_deal_id`) REFERENCES `advertising_ecm`.`media`.`programmatic_deal`(`programmatic_deal_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ADD CONSTRAINT `fk_media_media_placement_ad_channel_id` FOREIGN KEY (`ad_channel_id`) REFERENCES `advertising_ecm`.`media`.`ad_channel`(`ad_channel_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ADD CONSTRAINT `fk_media_media_placement_ad_format_id` FOREIGN KEY (`ad_format_id`) REFERENCES `advertising_ecm`.`media`.`ad_format`(`ad_format_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ADD CONSTRAINT `fk_media_media_placement_placement_id` FOREIGN KEY (`placement_id`) REFERENCES `advertising_ecm`.`media`.`placement`(`placement_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ADD CONSTRAINT `fk_media_media_placement_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ADD CONSTRAINT `fk_media_media_placement_original_placement_media_placement_id` FOREIGN KEY (`original_placement_media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ADD CONSTRAINT `fk_media_media_placement_programmatic_deal_id` FOREIGN KEY (`programmatic_deal_id`) REFERENCES `advertising_ecm`.`media`.`programmatic_deal`(`programmatic_deal_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ADD CONSTRAINT `fk_media_media_placement_publisher_property_id` FOREIGN KEY (`publisher_property_id`) REFERENCES `advertising_ecm`.`media`.`publisher_property`(`publisher_property_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ADD CONSTRAINT `fk_media_media_placement_ssp_platform_id` FOREIGN KEY (`ssp_platform_id`) REFERENCES `advertising_ecm`.`media`.`ssp_platform`(`ssp_platform_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_ad_channel_id` FOREIGN KEY (`ad_channel_id`) REFERENCES `advertising_ecm`.`media`.`ad_channel`(`ad_channel_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_ad_format_id` FOREIGN KEY (`ad_format_id`) REFERENCES `advertising_ecm`.`media`.`ad_format`(`ad_format_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_plan_line_id` FOREIGN KEY (`plan_line_id`) REFERENCES `advertising_ecm`.`media`.`plan_line`(`plan_line_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_programmatic_deal_id` FOREIGN KEY (`programmatic_deal_id`) REFERENCES `advertising_ecm`.`media`.`programmatic_deal`(`programmatic_deal_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_trafficking_instruction_id` FOREIGN KEY (`trafficking_instruction_id`) REFERENCES `advertising_ecm`.`media`.`trafficking_instruction`(`trafficking_instruction_id`);
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ADD CONSTRAINT `fk_media_programmatic_deal_ad_channel_id` FOREIGN KEY (`ad_channel_id`) REFERENCES `advertising_ecm`.`media`.`ad_channel`(`ad_channel_id`);
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ADD CONSTRAINT `fk_media_programmatic_deal_ad_format_id` FOREIGN KEY (`ad_format_id`) REFERENCES `advertising_ecm`.`media`.`ad_format`(`ad_format_id`);
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ADD CONSTRAINT `fk_media_programmatic_deal_publisher_property_id` FOREIGN KEY (`publisher_property_id`) REFERENCES `advertising_ecm`.`media`.`publisher_property`(`publisher_property_id`);
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ADD CONSTRAINT `fk_media_programmatic_deal_ssp_platform_id` FOREIGN KEY (`ssp_platform_id`) REFERENCES `advertising_ecm`.`media`.`ssp_platform`(`ssp_platform_id`);
ALTER TABLE `advertising_ecm`.`media`.`schedule` ADD CONSTRAINT `fk_media_schedule_ad_channel_id` FOREIGN KEY (`ad_channel_id`) REFERENCES `advertising_ecm`.`media`.`ad_channel`(`ad_channel_id`);
ALTER TABLE `advertising_ecm`.`media`.`schedule` ADD CONSTRAINT `fk_media_schedule_ad_format_id` FOREIGN KEY (`ad_format_id`) REFERENCES `advertising_ecm`.`media`.`ad_format`(`ad_format_id`);
ALTER TABLE `advertising_ecm`.`media`.`schedule` ADD CONSTRAINT `fk_media_schedule_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`media`.`schedule` ADD CONSTRAINT `fk_media_schedule_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`media`.`schedule` ADD CONSTRAINT `fk_media_schedule_programmatic_deal_id` FOREIGN KEY (`programmatic_deal_id`) REFERENCES `advertising_ecm`.`media`.`programmatic_deal`(`programmatic_deal_id`);
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ADD CONSTRAINT `fk_media_trafficking_instruction_ad_format_id` FOREIGN KEY (`ad_format_id`) REFERENCES `advertising_ecm`.`media`.`ad_format`(`ad_format_id`);
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ADD CONSTRAINT `fk_media_trafficking_instruction_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ADD CONSTRAINT `fk_media_trafficking_instruction_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ADD CONSTRAINT `fk_media_trafficking_instruction_parent_instruction_trafficking_instruction_id` FOREIGN KEY (`parent_instruction_trafficking_instruction_id`) REFERENCES `advertising_ecm`.`media`.`trafficking_instruction`(`trafficking_instruction_id`);
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ADD CONSTRAINT `fk_media_sov_benchmark_ad_channel_id` FOREIGN KEY (`ad_channel_id`) REFERENCES `advertising_ecm`.`media`.`ad_channel`(`ad_channel_id`);
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ADD CONSTRAINT `fk_media_audience_rating_publisher_property_id` FOREIGN KEY (`publisher_property_id`) REFERENCES `advertising_ecm`.`media`.`publisher_property`(`publisher_property_id`);
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ADD CONSTRAINT `fk_media_ad_channel_category_id` FOREIGN KEY (`category_id`) REFERENCES `advertising_ecm`.`media`.`category`(`category_id`);
ALTER TABLE `advertising_ecm`.`media`.`category` ADD CONSTRAINT `fk_media_category_parent_category_id` FOREIGN KEY (`parent_category_id`) REFERENCES `advertising_ecm`.`media`.`category`(`category_id`);
ALTER TABLE `advertising_ecm`.`media`.`placement` ADD CONSTRAINT `fk_media_placement_ad_channel_id` FOREIGN KEY (`ad_channel_id`) REFERENCES `advertising_ecm`.`media`.`ad_channel`(`ad_channel_id`);
ALTER TABLE `advertising_ecm`.`media`.`placement` ADD CONSTRAINT `fk_media_placement_ad_format_id` FOREIGN KEY (`ad_format_id`) REFERENCES `advertising_ecm`.`media`.`ad_format`(`ad_format_id`);
ALTER TABLE `advertising_ecm`.`media`.`placement` ADD CONSTRAINT `fk_media_placement_publisher_property_id` FOREIGN KEY (`publisher_property_id`) REFERENCES `advertising_ecm`.`media`.`publisher_property`(`publisher_property_id`);
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ADD CONSTRAINT `fk_media_benchmark_ad_channel_id` FOREIGN KEY (`ad_channel_id`) REFERENCES `advertising_ecm`.`media`.`ad_channel`(`ad_channel_id`);
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ADD CONSTRAINT `fk_media_benchmark_ad_format_id` FOREIGN KEY (`ad_format_id`) REFERENCES `advertising_ecm`.`media`.`ad_format`(`ad_format_id`);
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ADD CONSTRAINT `fk_media_channel_rate_ad_channel_id` FOREIGN KEY (`ad_channel_id`) REFERENCES `advertising_ecm`.`media`.`ad_channel`(`ad_channel_id`);
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ADD CONSTRAINT `fk_media_channel_rate_ad_format_id` FOREIGN KEY (`ad_format_id`) REFERENCES `advertising_ecm`.`media`.`ad_format`(`ad_format_id`);
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ADD CONSTRAINT `fk_media_channel_rate_programmatic_deal_id` FOREIGN KEY (`programmatic_deal_id`) REFERENCES `advertising_ecm`.`media`.`programmatic_deal`(`programmatic_deal_id`);
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ADD CONSTRAINT `fk_media_compliance_rule_ad_channel_id` FOREIGN KEY (`ad_channel_id`) REFERENCES `advertising_ecm`.`media`.`ad_channel`(`ad_channel_id`);
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ADD CONSTRAINT `fk_media_compliance_rule_ssp_platform_id` FOREIGN KEY (`ssp_platform_id`) REFERENCES `advertising_ecm`.`media`.`ssp_platform`(`ssp_platform_id`);
ALTER TABLE `advertising_ecm`.`media`.`availability` ADD CONSTRAINT `fk_media_availability_ad_channel_id` FOREIGN KEY (`ad_channel_id`) REFERENCES `advertising_ecm`.`media`.`ad_channel`(`ad_channel_id`);
ALTER TABLE `advertising_ecm`.`media`.`availability` ADD CONSTRAINT `fk_media_availability_ad_format_id` FOREIGN KEY (`ad_format_id`) REFERENCES `advertising_ecm`.`media`.`ad_format`(`ad_format_id`);
ALTER TABLE `advertising_ecm`.`media`.`availability` ADD CONSTRAINT `fk_media_availability_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`media`.`availability` ADD CONSTRAINT `fk_media_availability_programmatic_deal_id` FOREIGN KEY (`programmatic_deal_id`) REFERENCES `advertising_ecm`.`media`.`programmatic_deal`(`programmatic_deal_id`);
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ADD CONSTRAINT `fk_media_flowchart_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ADD CONSTRAINT `fk_media_flowchart_revised_from_flowchart_id` FOREIGN KEY (`revised_from_flowchart_id`) REFERENCES `advertising_ecm`.`media`.`flowchart`(`flowchart_id`);
ALTER TABLE `advertising_ecm`.`media`.`channel_supplier_agreement` ADD CONSTRAINT `fk_media_channel_supplier_agreement_ad_channel_id` FOREIGN KEY (`ad_channel_id`) REFERENCES `advertising_ecm`.`media`.`ad_channel`(`ad_channel_id`);
ALTER TABLE `advertising_ecm`.`media`.`format_availability` ADD CONSTRAINT `fk_media_format_availability_ad_format_id` FOREIGN KEY (`ad_format_id`) REFERENCES `advertising_ecm`.`media`.`ad_format`(`ad_format_id`);
ALTER TABLE `advertising_ecm`.`media`.`format_availability` ADD CONSTRAINT `fk_media_format_availability_programmatic_deal_id` FOREIGN KEY (`programmatic_deal_id`) REFERENCES `advertising_ecm`.`media`.`programmatic_deal`(`programmatic_deal_id`);
ALTER TABLE `advertising_ecm`.`media`.`io_creative_trafficking` ADD CONSTRAINT `fk_media_io_creative_trafficking_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`media`.`allocation` ADD CONSTRAINT `fk_media_allocation_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan_asset_assignment` ADD CONSTRAINT `fk_media_plan_asset_assignment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `advertising_ecm`.`media` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `advertising_ecm`.`media` SET TAGS ('dbx_domain' = 'media');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Media Insertion Order (IO) ID');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Channel Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Master Contract ID');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan ID');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `publisher_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor / Publisher ID');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `publisher_property_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher Property Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Agency ID');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Trafficker Worker Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `vendor_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card ID');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `agency_commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Agency Commission Amount');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `agency_commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `authorized_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'IO Authorized Gross Spend Amount');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `authorized_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_business_glossary_term' = 'IO Billing Cycle');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_value_regex' = 'monthly|weekly|flight_end|milestone|prepaid');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `brand_safety_requirements` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Requirements');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `buying_method` SET TAGS ('dbx_business_glossary_term' = 'Media Buying Method');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `buying_method` SET TAGS ('dbx_value_regex' = 'direct|programmatic|rtb|programmatic_guaranteed|preferred_deal|pmp');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `cancellation_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Notice Period (Days)');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `cancellation_policy` SET TAGS ('dbx_business_glossary_term' = 'IO Cancellation Policy');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `cancellation_policy` SET TAGS ('dbx_value_regex' = 'non_cancellable|cancellable_with_notice|cancellable_with_penalty|cancellable_no_penalty');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'IO Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'IO Currency Code');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'IO Execution Date');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'IO Flight End Date');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'IO Flight Start Date');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `guaranteed_impressions` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Impression Volume');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `io_name` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) Name');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `io_number` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) Number');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `io_number` SET TAGS ('dbx_value_regex' = '^IO-[0-9]{6,12}$');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `io_status` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) Status');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `io_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|executed|cancelled|on_hold');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `io_type` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) Type');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `io_type` SET TAGS ('dbx_value_regex' = 'standard|programmatic_guaranteed|preferred_deal|private_marketplace|direct_buy');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `is_programmatic` SET TAGS ('dbx_business_glossary_term' = 'Is Programmatic IO Flag');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `makegood_policy` SET TAGS ('dbx_business_glossary_term' = 'Make-Good Policy');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `makegood_policy` SET TAGS ('dbx_value_regex' = 'credit|rerun|cash_refund|none');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `net_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'IO Net Spend Amount');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `net_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'IO Notes');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'IO Payment Terms');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_45|net_60|net_90|prepaid');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'IO Pricing Model');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'cpm|cpc|cpa|cpcv|flat_fee|cpv');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `prisma_io_code` SET TAGS ('dbx_business_glossary_term' = 'Mediaocean Prisma IO System ID');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'IO Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'IO Version Number');
ALTER TABLE `advertising_ecm`.`media`.`plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`media`.`plan` SET TAGS ('dbx_subdomain' = 'strategic_planning');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan ID');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `creative_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Brief Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Media Planner ID');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `agency_commission_pct` SET TAGS ('dbx_business_glossary_term' = 'Agency Commission Percentage');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `agency_commission_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revision_required');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `buying_approach` SET TAGS ('dbx_business_glossary_term' = 'Buying Approach');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `buying_approach` SET TAGS ('dbx_value_regex' = 'direct|programmatic|hybrid|guaranteed|non_guaranteed');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `channel_mix` SET TAGS ('dbx_business_glossary_term' = 'Channel Mix');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `daypart_strategy` SET TAGS ('dbx_business_glossary_term' = 'Daypart Strategy');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `daypart_strategy` SET TAGS ('dbx_value_regex' = 'all_day|prime_time|daytime|late_night|morning_drive|custom');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `frequency_target` SET TAGS ('dbx_business_glossary_term' = 'Frequency Target');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'national|regional|local|international|global');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `grp_target` SET TAGS ('dbx_business_glossary_term' = 'Gross Rating Point (GRP) Target');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `is_addressable` SET TAGS ('dbx_business_glossary_term' = 'Is Addressable Media Flag');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `is_programmatic` SET TAGS ('dbx_business_glossary_term' = 'Is Programmatic Flag');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `net_budget` SET TAGS ('dbx_business_glossary_term' = 'Net Budget');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `net_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Name');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Number');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_value_regex' = '^MP-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Status');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Type');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'brand_awareness|direct_response|performance|sponsorship|integrated|programmatic');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `primary_kpi` SET TAGS ('dbx_business_glossary_term' = 'Primary Key Performance Indicator (KPI)');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `prisma_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Mediaocean Prisma Plan ID');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `reach_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Reach Target Percentage');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `secondary_kpi` SET TAGS ('dbx_business_glossary_term' = 'Secondary Key Performance Indicator (KPI)');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `sfdc_opportunity_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce (SFDC) Opportunity ID');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `target_age_range` SET TAGS ('dbx_business_glossary_term' = 'Target Age Range');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `target_age_range` SET TAGS ('dbx_value_regex' = '^[0-9]{1,2}-[0-9]{1,2}$');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `target_cpm` SET TAGS ('dbx_business_glossary_term' = 'Target Cost Per Mille (CPM)');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `target_cpm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `target_gender` SET TAGS ('dbx_business_glossary_term' = 'Target Gender');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `target_gender` SET TAGS ('dbx_value_regex' = 'male|female|all|skew_male|skew_female');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `target_gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `target_gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `target_markets` SET TAGS ('dbx_business_glossary_term' = 'Target Markets / Designated Market Areas (DMAs)');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `total_planned_budget` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Budget');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `total_planned_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `trp_target` SET TAGS ('dbx_business_glossary_term' = 'Target Rating Point (TRP) Target');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Version');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+$');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` SET TAGS ('dbx_subdomain' = 'strategic_planning');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `plan_line_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Line ID');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Channel Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `ad_format_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Format Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan ID');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `programmatic_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Deal ID');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `vendor_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card ID');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `agency_commission_pct` SET TAGS ('dbx_business_glossary_term' = 'Agency Commission Percentage');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `agency_commission_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|cancelled|on_hold');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `buying_status` SET TAGS ('dbx_business_glossary_term' = 'Buying Status');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `buying_type` SET TAGS ('dbx_business_glossary_term' = 'Buying Type');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `io_number` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) Number');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `is_bonus` SET TAGS ('dbx_business_glossary_term' = 'Is Bonus Line');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `is_makegood` SET TAGS ('dbx_business_glossary_term' = 'Is Makegood Line');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `line_name` SET TAGS ('dbx_business_glossary_term' = 'Line Item Name');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `market` SET TAGS ('dbx_business_glossary_term' = 'Market');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `media_subtype` SET TAGS ('dbx_business_glossary_term' = 'Media Subtype');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `media_type` SET TAGS ('dbx_business_glossary_term' = 'Media Type');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `media_type` SET TAGS ('dbx_value_regex' = 'digital|television|radio|print|out_of_home|cinema');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `planned_cpa` SET TAGS ('dbx_business_glossary_term' = 'Planned Cost Per Acquisition (CPA)');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `planned_cpa` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `planned_cpc` SET TAGS ('dbx_business_glossary_term' = 'Planned Cost Per Click (CPC)');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `planned_cpc` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `planned_cpm` SET TAGS ('dbx_business_glossary_term' = 'Planned Cost Per Mille (CPM)');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `planned_cpm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `planned_frequency` SET TAGS ('dbx_business_glossary_term' = 'Planned Frequency');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `planned_grps` SET TAGS ('dbx_business_glossary_term' = 'Planned Gross Rating Points (GRPs)');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `planned_impressions` SET TAGS ('dbx_business_glossary_term' = 'Planned Impressions');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `planned_net_spend` SET TAGS ('dbx_business_glossary_term' = 'Planned Net Spend');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `planned_net_spend` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `planned_reach_pct` SET TAGS ('dbx_business_glossary_term' = 'Planned Reach Percentage');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `planned_spend` SET TAGS ('dbx_business_glossary_term' = 'Planned Spend');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `planned_spend` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `planned_trps` SET TAGS ('dbx_business_glossary_term' = 'Planned Target Rating Points (TRPs)');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `planned_units` SET TAGS ('dbx_business_glossary_term' = 'Planned Units');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `publisher_name` SET TAGS ('dbx_business_glossary_term' = 'Publisher Name');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `vehicle_name` SET TAGS ('dbx_business_glossary_term' = 'Media Vehicle Name');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Media Placement ID');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Identifier (ID)');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `ad_format_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Format Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `placement_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Server Placement ID');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) ID');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `original_placement_media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Original Placement ID');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `programmatic_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Deal ID');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `publisher_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor / Publisher ID');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `publisher_property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Identifier (ID)');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `ssp_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ssp Platform Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Contact Worker Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `above_fold_classification` SET TAGS ('dbx_business_glossary_term' = 'Above Fold Classification');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `above_fold_classification` SET TAGS ('dbx_value_regex' = 'above_fold|below_fold|mixed|not_applicable');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `ad_server_platform` SET TAGS ('dbx_business_glossary_term' = 'Ad Server Platform');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `ad_server_platform` SET TAGS ('dbx_value_regex' = 'google_campaign_manager|the_trade_desk|freewheel|sizmek|other');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `ad_unit_size` SET TAGS ('dbx_business_glossary_term' = 'Ad Unit Size');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `agency_commission_pct` SET TAGS ('dbx_business_glossary_term' = 'Agency Commission Percentage');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `agency_commission_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Placement Approved Date');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `brand_safety_category` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Category');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Tier');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|moderate|unrated');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `buying_method` SET TAGS ('dbx_business_glossary_term' = 'Buying Method');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `buying_method` SET TAGS ('dbx_value_regex' = 'direct|programmatic_guaranteed|private_marketplace|open_auction|preferred_deal');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `cancellation_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Notice Days');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `content_category` SET TAGS ('dbx_business_glossary_term' = 'Content Category');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `contracted_impressions` SET TAGS ('dbx_business_glossary_term' = 'Contracted Impressions');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `contracted_rate` SET TAGS ('dbx_business_glossary_term' = 'Contracted Rate');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `contracted_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `contracted_units` SET TAGS ('dbx_business_glossary_term' = 'Contracted Units');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `contracted_value` SET TAGS ('dbx_business_glossary_term' = 'Contracted Value');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `contracted_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `cpm_floor_price` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM) Floor Price');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `cpm_list_price` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM) List Price');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `daypart_availability` SET TAGS ('dbx_business_glossary_term' = 'Daypart Availability');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `device_targeting` SET TAGS ('dbx_business_glossary_term' = 'Device Targeting');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `device_targeting` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|ctv|all_devices');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `environment_type` SET TAGS ('dbx_business_glossary_term' = 'Environment Type');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `estimated_monthly_impressions` SET TAGS ('dbx_business_glossary_term' = 'Estimated Monthly Impressions');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `estimated_reach_pct` SET TAGS ('dbx_business_glossary_term' = 'Estimated Reach Percentage (Pct)');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `frequency_cap` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `frequency_cap_impressions` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Impressions');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `frequency_cap_period` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Period');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `frequency_cap_period` SET TAGS ('dbx_value_regex' = 'hour|day|week|month|lifetime');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `geo_targeting_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic (Geo) Targeting Scope');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `geo_targeting_scope` SET TAGS ('dbx_value_regex' = 'global|national|regional|dma|zip_code|custom');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `grp_contracted` SET TAGS ('dbx_business_glossary_term' = 'Contracted Gross Rating Points (GRP)');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `is_guaranteed_inventory` SET TAGS ('dbx_business_glossary_term' = 'Is Guaranteed Inventory');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `is_makegood` SET TAGS ('dbx_business_glossary_term' = 'Make-Good Indicator');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `is_programmatic_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Programmatic Eligible');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `makegood_policy` SET TAGS ('dbx_business_glossary_term' = 'Makegood Policy');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `net_contracted_value` SET TAGS ('dbx_business_glossary_term' = 'Net Contracted Value');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `net_contracted_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `placement_code` SET TAGS ('dbx_business_glossary_term' = 'Placement Code');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `placement_name` SET TAGS ('dbx_business_glossary_term' = 'Placement Name');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `placement_status` SET TAGS ('dbx_business_glossary_term' = 'Placement Status');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `placement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|archived');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `placement_type` SET TAGS ('dbx_business_glossary_term' = 'Placement Type');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `position` SET TAGS ('dbx_business_glossary_term' = 'Placement Position');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Site / Station / Network Name');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `targeting_parameters` SET TAGS ('dbx_business_glossary_term' = 'Targeting Parameters');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `third_party_verification_required` SET TAGS ('dbx_business_glossary_term' = 'Third Party Verification Required');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `trafficking_notes` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Notes');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `trafficking_status` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Status');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `vast_tag_required` SET TAGS ('dbx_business_glossary_term' = 'Video Ad Serving Template (VAST) Tag Required');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `viewability_rate_benchmark_pct` SET TAGS ('dbx_business_glossary_term' = 'Viewability Rate Benchmark Percentage (Pct)');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `viewability_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Viewability Target Percentage');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `vpaid_supported` SET TAGS ('dbx_business_glossary_term' = 'Video Player-Ad Interface Definition (VPAID) Supported');
ALTER TABLE `advertising_ecm`.`media`.`buy` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`media`.`buy` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `buy_id` SET TAGS ('dbx_business_glossary_term' = 'Media Buy ID');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Channel Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `ad_format_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Format Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Worker Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) ID');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `plan_line_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Line ID');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `programmatic_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Deal Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `trafficking_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Trafficking ID');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `added_value_flag` SET TAGS ('dbx_business_glossary_term' = 'Added Value Flag');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `agency_commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Agency Commission Amount');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `agency_commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `authorized_spend_ceiling` SET TAGS ('dbx_business_glossary_term' = 'Authorized Spend Ceiling');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `authorized_spend_ceiling` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `booked_units` SET TAGS ('dbx_business_glossary_term' = 'Booked Units');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `buy_date` SET TAGS ('dbx_business_glossary_term' = 'Media Buy Date');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `buy_number` SET TAGS ('dbx_business_glossary_term' = 'Media Buy Number');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `buy_status` SET TAGS ('dbx_business_glossary_term' = 'Media Buy Status');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `buy_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|cancelled|paused|completed');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `buy_type` SET TAGS ('dbx_business_glossary_term' = 'Media Buy Type');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `buy_type` SET TAGS ('dbx_value_regex' = 'upfront|scatter|programmatic_rtb|direct|retail_media|ctv_addressable');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'client_request|budget_cut|campaign_change|vendor_default|force_majeure|other');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'not_started|in_delivery|underdelivered|fully_delivered|overdelivered');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `gross_buy_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Buy Amount');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `gross_buy_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `makegood_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Flag');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `market_type` SET TAGS ('dbx_business_glossary_term' = 'Market Type');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `market_type` SET TAGS ('dbx_value_regex' = 'upfront|scatter|makeweight');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `negotiated_rate` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Rate');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `negotiated_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `net_buy_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Buy Amount');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `net_buy_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Buy Notes');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `prisma_buy_code` SET TAGS ('dbx_business_glossary_term' = 'Mediaocean Prisma Buy ID');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|in_progress|reconciled|disputed|written_off');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `upfront_deal_year` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal Year');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `upfront_deal_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{4}$');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `programmatic_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Media Programmatic Deal ID');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Channel Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `ad_format_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Format Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `publisher_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher ID');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `publisher_property_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher Property Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `ssp_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ssp Platform Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Tier');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_value_regex' = 'standard|conservative|custom|none');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Deal Budget Amount');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `closed_loop_measurement` SET TAGS ('dbx_business_glossary_term' = 'Closed-Loop Measurement Availability Flag');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `deal_code` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Deal ID');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `deal_name` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Deal Name');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `deal_source_system` SET TAGS ('dbx_business_glossary_term' = 'Deal Source System');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `deal_status` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Deal Status');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `deal_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|paused|expired|cancelled');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Deal Type');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_value_regex' = 'pmp|preferred_deal|programmatic_guaranteed|open_auction|retailer_pmp');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `dsp_platform` SET TAGS ('dbx_business_glossary_term' = 'Demand-Side Platform (DSP) Platform');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Deal End Date');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `environment_type` SET TAGS ('dbx_business_glossary_term' = 'Inventory Environment Type');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `environment_type` SET TAGS ('dbx_value_regex' = 'web|app|ctv|dooh|audio');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `external_deal_ref` SET TAGS ('dbx_business_glossary_term' = 'External Deal Reference');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `floor_cpm` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM) Floor Price');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `floor_cpm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `frequency_cap` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `frequency_cap_period` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Period');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `frequency_cap_period` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly|monthly|lifetime');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `geo_targeting` SET TAGS ('dbx_business_glossary_term' = 'Geographic Targeting');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `impression_commitment` SET TAGS ('dbx_business_glossary_term' = 'Impression Commitment');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `io_number` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) Number');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `negotiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deal Negotiated Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Deal Notes');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `rtb_bid_strategy` SET TAGS ('dbx_business_glossary_term' = 'Real-Time Bidding (RTB) Bid Strategy');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `rtb_bid_strategy` SET TAGS ('dbx_value_regex' = 'fixed_cpm|dynamic_cpm|target_cpa|target_roas|max_impressions');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `shopper_data_enabled` SET TAGS ('dbx_business_glossary_term' = 'Shopper Data Enabled Flag');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Deal Start Date');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `viewability_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Viewability Threshold Percentage');
ALTER TABLE `advertising_ecm`.`media`.`schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`media`.`schedule` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Media Schedule ID');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Channel Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `ad_format_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Format Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset ID');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) ID');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `programmatic_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Deal ID');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Trafficker Worker Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `ad_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Ad Duration (Seconds)');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `air_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Air End Time');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `air_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Air Start Time');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `buying_type` SET TAGS ('dbx_business_glossary_term' = 'Media Buying Type');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `buying_type` SET TAGS ('dbx_value_regex' = 'direct|programmatic_guaranteed|private_marketplace|open_exchange|rtb');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `cpm_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM) Rate');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `cpm_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `creative_rotation_type` SET TAGS ('dbx_business_glossary_term' = 'Creative Rotation Type');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `creative_rotation_type` SET TAGS ('dbx_value_regex' = 'even|weighted|sequential|optimised');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart Classification');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `dma_code` SET TAGS ('dbx_business_glossary_term' = 'Designated Market Area (DMA) Code');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `dma_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `frequency_cap` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `frequency_cap_period` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Period');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `frequency_cap_period` SET TAGS ('dbx_value_regex' = 'hour|day|week|month|lifetime');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `gross_cost` SET TAGS ('dbx_business_glossary_term' = 'Gross Media Cost');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `gross_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `is_makegood` SET TAGS ('dbx_business_glossary_term' = 'Make-Good Indicator');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `market_name` SET TAGS ('dbx_business_glossary_term' = 'Market Name');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `net_cost` SET TAGS ('dbx_business_glossary_term' = 'Net Media Cost');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `net_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `pod_position` SET TAGS ('dbx_business_glossary_term' = 'Pod Position');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `pod_position` SET TAGS ('dbx_value_regex' = 'first|second|third|last|any');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `preemptible` SET TAGS ('dbx_business_glossary_term' = 'Preemptible Indicator');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Media Schedule Name');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Media Schedule Number');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `scheduled_grp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Gross Rating Points (GRP)');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `scheduled_impressions` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Impressions');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `scheduled_trp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Target Rating Points (TRP)');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `scheduled_units` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Units');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `source_system_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `trafficking_notes` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Notes');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `trafficking_status` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Status');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `vehicle_name` SET TAGS ('dbx_business_glossary_term' = 'Media Vehicle Name');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `trafficking_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Instruction ID');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `ad_format_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Format Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset ID');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) ID');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `parent_instruction_trafficking_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Trafficking Instruction ID');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Trafficker Worker Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `ad_server` SET TAGS ('dbx_business_glossary_term' = 'Ad Server');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `ad_server` SET TAGS ('dbx_value_regex' = 'Google Campaign Manager 360|The Trade Desk|Sizmek|Flashtalking|Innovid|other');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `ad_server_placement_code` SET TAGS ('dbx_business_glossary_term' = 'Ad Server Placement Code');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `brand_safety_provider` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Provider');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `brand_safety_provider` SET TAGS ('dbx_value_regex' = 'DoubleVerify|Integral Ad Science|MOAT|Oracle Contextual|TAG|none');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `brand_safety_segment` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Segment');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `click_through_url` SET TAGS ('dbx_business_glossary_term' = 'Click-Through URL');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `click_through_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Instruction Confirmed Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `creative_size` SET TAGS ('dbx_business_glossary_term' = 'Creative Size');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `creative_size` SET TAGS ('dbx_value_regex' = '^[0-9]+x[0-9]+$');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `daypart_schedule` SET TAGS ('dbx_business_glossary_term' = 'Daypart Schedule');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `delivery_end_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery End Date');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `delivery_start_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Start Date');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `device_targeting` SET TAGS ('dbx_business_glossary_term' = 'Device Targeting');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `device_targeting` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|CTV|all');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `frequency_cap_impressions` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Impressions');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `frequency_cap_period` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Period');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `frequency_cap_period` SET TAGS ('dbx_value_regex' = 'hour|day|week|month|lifetime');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `geo_targeting` SET TAGS ('dbx_business_glossary_term' = 'Geographic Targeting');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `impression_tracking_pixel_url` SET TAGS ('dbx_business_glossary_term' = 'Impression Tracking Pixel URL');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `impression_tracking_pixel_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `instruction_number` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Instruction Number');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `instruction_status` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Instruction Status');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `instruction_status` SET TAGS ('dbx_value_regex' = 'pending|sent|confirmed|rejected|cancelled');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `instruction_type` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Instruction Type');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `instruction_type` SET TAGS ('dbx_value_regex' = 'new|revision|cancellation|pause|resume');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Instruction Notes');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Instruction Rejection Reason');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Instruction Sent Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `third_party_verification_required` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Verification Required Flag');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `trafficking_date` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Date');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `vast_tag_url` SET TAGS ('dbx_business_glossary_term' = 'Video Ad Serving Template (VAST) Tag URL');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `vast_tag_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `viewability_tag_url` SET TAGS ('dbx_business_glossary_term' = 'Viewability Tag URL');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `viewability_tag_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `vpaid_tag_url` SET TAGS ('dbx_business_glossary_term' = 'Video Player-Ad Interface Definition (VPAID) Tag URL');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `vpaid_tag_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` SET TAGS ('dbx_subdomain' = 'strategic_planning');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `sov_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice (SOV) Benchmark ID');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Channel Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `benchmark_code` SET TAGS ('dbx_business_glossary_term' = 'SOV Benchmark Code');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `benchmark_code` SET TAGS ('dbx_value_regex' = '^SOV-[A-Z0-9]{4,20}$');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `benchmark_date` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Date');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `benchmark_name` SET TAGS ('dbx_business_glossary_term' = 'SOV Benchmark Name');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `benchmark_status` SET TAGS ('dbx_business_glossary_term' = 'SOV Benchmark Status');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `benchmark_status` SET TAGS ('dbx_value_regex' = 'active|superseded|draft|archived|under_review');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `competitor_names` SET TAGS ('dbx_business_glossary_term' = 'Competitor Names');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `competitor_names` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `competitor_set_name` SET TAGS ('dbx_business_glossary_term' = 'Competitor Set Name');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `competitor_set_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Confidence Level');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low|indicative');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Confidence Score');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Competitive Intelligence Data Source');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `dma_code` SET TAGS ('dbx_business_glossary_term' = 'Designated Market Area (DMA) Code');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `dma_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `estimated_brand_spend` SET TAGS ('dbx_business_glossary_term' = 'Estimated Brand Media Spend');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `estimated_brand_spend` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `estimated_competitor_spend` SET TAGS ('dbx_business_glossary_term' = 'Estimated Competitor Media Spend');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `estimated_competitor_spend` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `grp_benchmark` SET TAGS ('dbx_business_glossary_term' = 'Gross Rating Point (GRP) Benchmark');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `impression_share_pct` SET TAGS ('dbx_business_glossary_term' = 'Impression Share Percentage');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `impression_share_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `is_verified` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Verified Flag');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `market_name` SET TAGS ('dbx_business_glossary_term' = 'Market / Designated Market Area (DMA) Name');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `measurement_period_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Type');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `measurement_period_type` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|annual|custom');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `methodology_notes` SET TAGS ('dbx_business_glossary_term' = 'Measurement Methodology Notes');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `planning_cycle` SET TAGS ('dbx_business_glossary_term' = 'Media Planning Cycle');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product / Service Category');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `recommended_budget` SET TAGS ('dbx_business_glossary_term' = 'Recommended Media Budget');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `recommended_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `sov_pct` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice (SOV) Percentage');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `sov_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `sov_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice (SOV) Target Percentage');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `sov_target_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `spend_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Spend Currency Code');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `spend_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `total_category_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Category Media Spend');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `total_category_spend` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `trp_benchmark` SET TAGS ('dbx_business_glossary_term' = 'Target Rating Point (TRP) Benchmark');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `advertising_ecm`.`media`.`sov_benchmark` ALTER COLUMN `verified_date` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Verified Date');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` SET TAGS ('dbx_subdomain' = 'strategic_planning');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `audience_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Rating ID');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Rated Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `publisher_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher ID');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `publisher_property_id` SET TAGS ('dbx_business_glossary_term' = 'Media Vehicle ID');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `age_range_high` SET TAGS ('dbx_business_glossary_term' = 'Demographic Age Range High');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `age_range_low` SET TAGS ('dbx_business_glossary_term' = 'Demographic Age Range Low');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `average_audience` SET TAGS ('dbx_business_glossary_term' = 'Average Audience (AA)');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `confidence_interval` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `cumulative_audience` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Audience (Cume)');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `currency_type` SET TAGS ('dbx_business_glossary_term' = 'Rating Currency Type');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `currency_type` SET TAGS ('dbx_value_regex' = 'grp|trp|impressions|reach|frequency');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `data_vintage_date` SET TAGS ('dbx_business_glossary_term' = 'Data Vintage Date');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `daypart_code` SET TAGS ('dbx_business_glossary_term' = 'Daypart Code');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `daypart_name` SET TAGS ('dbx_business_glossary_term' = 'Daypart Name');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `gender_segment` SET TAGS ('dbx_business_glossary_term' = 'Gender Segment');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `gender_segment` SET TAGS ('dbx_value_regex' = 'all|male|female|persons');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `gender_segment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `gender_segment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `geography_code` SET TAGS ('dbx_business_glossary_term' = 'Geography Code');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `geography_name` SET TAGS ('dbx_business_glossary_term' = 'Geography Name');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `geography_type` SET TAGS ('dbx_business_glossary_term' = 'Geography Type');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `geography_type` SET TAGS ('dbx_value_regex' = 'national|dma|msa|county|zip|global');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `grp_contribution` SET TAGS ('dbx_business_glossary_term' = 'Gross Rating Point (GRP) Contribution');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `ingested_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Ingested Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `is_low_reliability` SET TAGS ('dbx_business_glossary_term' = 'Low Reliability Flag');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_value_regex' = 'panel|census|hybrid|modeled|server_side');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `measurement_period_end` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `measurement_period_start` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `measurement_source` SET TAGS ('dbx_business_glossary_term' = 'Measurement Source');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `measurement_source` SET TAGS ('dbx_value_regex' = 'nielsen|comscore|arbitron|mri_simmons|kantar|doubleclick');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `mrc_accredited` SET TAGS ('dbx_business_glossary_term' = 'Media Rating Council (MRC) Accredited Flag');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `rating_status` SET TAGS ('dbx_business_glossary_term' = 'Rating Status');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `rating_status` SET TAGS ('dbx_value_regex' = 'preliminary|final|revised|superseded');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `rating_value` SET TAGS ('dbx_business_glossary_term' = 'Audience Rating Value');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `share_value` SET TAGS ('dbx_business_glossary_term' = 'Audience Share Value');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `time_slot_end` SET TAGS ('dbx_business_glossary_term' = 'Time Slot End Time');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `time_slot_end` SET TAGS ('dbx_value_regex' = '^([01]d|2[0-3]):[0-5]d$');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `time_slot_start` SET TAGS ('dbx_business_glossary_term' = 'Time Slot Start Time');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `time_slot_start` SET TAGS ('dbx_value_regex' = '^([01]d|2[0-3]):[0-5]d$');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `trp_contribution` SET TAGS ('dbx_business_glossary_term' = 'Target Rating Point (TRP) Contribution');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `universe_estimate` SET TAGS ('dbx_business_glossary_term' = 'Universe Estimate');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`audience_rating` ALTER COLUMN `vehicle_type` SET TAGS ('dbx_business_glossary_term' = 'Media Vehicle Type');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Channel ID');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `agency_commission_pct` SET TAGS ('dbx_business_glossary_term' = 'Agency Commission Percentage');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Endpoint URL');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `api_version` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Version');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `attribution_window_days` SET TAGS ('dbx_business_glossary_term' = 'Attribution Window Days');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `bid_strategy_default` SET TAGS ('dbx_business_glossary_term' = 'Bid Strategy Default');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `brand_safety_keywords` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Keywords');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Tier');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_value_regex' = 'standard|moderate|strict|custom');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `ccpa_opt_out_supported` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Opt-Out Supported');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Code');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Name');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `channel_status` SET TAGS ('dbx_business_glossary_term' = 'Channel Status');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `channel_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pilot|sunset');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `click_attribution_window_days` SET TAGS ('dbx_business_glossary_term' = 'Click Attribution Window Days');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `consent_signal_format` SET TAGS ('dbx_business_glossary_term' = 'Consent Signal Format');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `consent_signal_format` SET TAGS ('dbx_value_regex' = 'tcf_v2|us_privacy|gpp|custom|none');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `delivery_modality` SET TAGS ('dbx_business_glossary_term' = 'Delivery Modality');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `delivery_modality` SET TAGS ('dbx_value_regex' = 'self_serve|managed_service|programmatic|direct_io|hybrid');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `dsp_seat_code` SET TAGS ('dbx_business_glossary_term' = 'Demand-Side Platform (DSP) Seat ID');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `dsp_seat_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `frequency_cap_default` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Default');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `frequency_cap_period_default` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Period Default');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `frequency_cap_period_default` SET TAGS ('dbx_value_regex' = 'hour|day|week|month|campaign');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `gdpr_consent_required` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Required');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `platform_name` SET TAGS ('dbx_business_glossary_term' = 'Platform Name');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `supports_audience_targeting` SET TAGS ('dbx_business_glossary_term' = 'Supports Audience Targeting');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `supports_dayparting` SET TAGS ('dbx_business_glossary_term' = 'Supports Dayparting');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `supports_geo_targeting` SET TAGS ('dbx_business_glossary_term' = 'Supports Geographic Targeting');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `supports_programmatic` SET TAGS ('dbx_business_glossary_term' = 'Supports Programmatic');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `utm_medium_default` SET TAGS ('dbx_business_glossary_term' = 'Urchin Tracking Module (UTM) Medium Default');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `utm_source_default` SET TAGS ('dbx_business_glossary_term' = 'Urchin Tracking Module (UTM) Source Default');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `view_attribution_window_days` SET TAGS ('dbx_business_glossary_term' = 'View Attribution Window Days');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `viewability_standard` SET TAGS ('dbx_business_glossary_term' = 'Viewability Standard');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `viewability_standard` SET TAGS ('dbx_value_regex' = 'mrc|groupm|custom');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `viewability_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Viewability Threshold Percentage');
ALTER TABLE `advertising_ecm`.`media`.`category` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `advertising_ecm`.`media`.`category` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `parent_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Category ID');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `ad_format_types` SET TAGS ('dbx_business_glossary_term' = 'Ad Format Types');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `audience_targeting_capability` SET TAGS ('dbx_business_glossary_term' = 'Audience Targeting Capability');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `audience_targeting_capability` SET TAGS ('dbx_value_regex' = 'advanced|basic|demographic_only|none');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Tier');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|open_exchange|unverified');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `buying_method` SET TAGS ('dbx_business_glossary_term' = 'Buying Method');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `buying_method` SET TAGS ('dbx_value_regex' = 'direct|programmatic|network|exchange|upfront|scatter');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Category Code');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `category_description` SET TAGS ('dbx_business_glossary_term' = 'Category Description');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Category Name');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `category_status` SET TAGS ('dbx_business_glossary_term' = 'Category Status');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `category_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `category_type` SET TAGS ('dbx_business_glossary_term' = 'Category Type');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `category_type` SET TAGS ('dbx_value_regex' = 'channel_family|channel_subcategory|channel_type');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `daypart_applicable` SET TAGS ('dbx_business_glossary_term' = 'Daypart Applicable Flag');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `default_attribution_window_days` SET TAGS ('dbx_business_glossary_term' = 'Default Attribution Window Days');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `default_pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Default Pricing Model');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `frequency_cap_support` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Support Flag');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'global|national|regional|local|dma');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `iab_category_code` SET TAGS ('dbx_business_glossary_term' = 'IAB (Interactive Advertising Bureau) Category Code');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `is_addressable` SET TAGS ('dbx_business_glossary_term' = 'Is Addressable Flag');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `is_leaf_node` SET TAGS ('dbx_business_glossary_term' = 'Is Leaf Node Flag');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `is_programmatic` SET TAGS ('dbx_business_glossary_term' = 'Is Programmatic Flag');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `measurement_standard` SET TAGS ('dbx_business_glossary_term' = 'Measurement Standard');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `media_type` SET TAGS ('dbx_business_glossary_term' = 'Media Type');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `mrc_accredited` SET TAGS ('dbx_business_glossary_term' = 'MRC (Media Rating Council) Accredited Flag');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `reconciliation_method` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Method');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `reconciliation_method` SET TAGS ('dbx_value_regex' = 'automated|manual|hybrid|not_applicable');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `requires_trafficking` SET TAGS ('dbx_business_glossary_term' = 'Requires Trafficking Flag');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `supports_grp` SET TAGS ('dbx_business_glossary_term' = 'Supports GRP (Gross Rating Point) Flag');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `supports_trp` SET TAGS ('dbx_business_glossary_term' = 'Supports TRP (Target Rating Point) Flag');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `supports_viewability` SET TAGS ('dbx_business_glossary_term' = 'Supports Viewability Measurement Flag');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `usage_notes` SET TAGS ('dbx_business_glossary_term' = 'Usage Notes');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `vast_vpaid_support` SET TAGS ('dbx_business_glossary_term' = 'VAST (Video Ad Serving Template) / VPAID (Video Player-Ad Interface Definition) Support');
ALTER TABLE `advertising_ecm`.`media`.`category` ALTER COLUMN `vast_vpaid_support` SET TAGS ('dbx_value_regex' = 'vast_only|vpaid_only|both|none');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `publisher_property_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher Property ID');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `publisher_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher ID');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `ad_fraud_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Ad Fraud Risk Score');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `ad_server_platform` SET TAGS ('dbx_business_glossary_term' = 'Ad Server Platform');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `app_bundle_code` SET TAGS ('dbx_business_glossary_term' = 'App Bundle ID');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `app_store_code` SET TAGS ('dbx_business_glossary_term' = 'App Store ID');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `audience_composition` SET TAGS ('dbx_business_glossary_term' = 'Audience Composition');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `average_cpm` SET TAGS ('dbx_business_glossary_term' = 'Average Cost Per Mille (CPM)');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `brand_safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Classification');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `brand_safety_classification` SET TAGS ('dbx_value_regex' = 'high_risk|medium_risk|low_risk|brand_safe|certified_safe');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `campaign_manager_site_code` SET TAGS ('dbx_business_glossary_term' = 'Google Campaign Manager 360 Site ID');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `content_vertical` SET TAGS ('dbx_business_glossary_term' = 'Content Vertical');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `floor_cpm` SET TAGS ('dbx_business_glossary_term' = 'Floor Cost Per Mille (CPM)');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `iab_content_category` SET TAGS ('dbx_business_glossary_term' = 'Interactive Advertising Bureau (IAB) Content Category');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `monthly_impressions` SET TAGS ('dbx_business_glossary_term' = 'Monthly Impressions');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `monthly_unique_visitors` SET TAGS ('dbx_business_glossary_term' = 'Monthly Unique Visitors');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `mrc_accredited` SET TAGS ('dbx_business_glossary_term' = 'Media Rating Council (MRC) Accredited');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `mrc_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Media Rating Council (MRC) Audit Date');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `pmp_deals_available` SET TAGS ('dbx_business_glossary_term' = 'Private Marketplace (PMP) Deals Available');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `prisma_property_code` SET TAGS ('dbx_business_glossary_term' = 'Mediaocean Prisma Property ID');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `programmatic_enabled` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Enabled');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `property_code` SET TAGS ('dbx_business_glossary_term' = 'Property Code');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `property_name` SET TAGS ('dbx_business_glossary_term' = 'Property Name');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `property_status` SET TAGS ('dbx_business_glossary_term' = 'Property Status');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `property_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|archived');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `property_type` SET TAGS ('dbx_business_glossary_term' = 'Property Type');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `property_url` SET TAGS ('dbx_business_glossary_term' = 'Property Uniform Resource Locator (URL)');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `rtb_enabled` SET TAGS ('dbx_business_glossary_term' = 'Real-Time Bidding (RTB) Enabled');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `supported_ad_formats` SET TAGS ('dbx_business_glossary_term' = 'Supported Ad Formats');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `tag_certified` SET TAGS ('dbx_business_glossary_term' = 'Trustworthy Accountability Group (TAG) Certified');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `vast_version` SET TAGS ('dbx_business_glossary_term' = 'Video Ad Serving Template (VAST) Version');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `video_player_type` SET TAGS ('dbx_business_glossary_term' = 'Video Player Type');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `viewability_benchmark_pct` SET TAGS ('dbx_business_glossary_term' = 'Viewability Benchmark Percentage');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `vpaid_supported` SET TAGS ('dbx_business_glossary_term' = 'Video Player-Ad Interface Definition (VPAID) Supported');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `ssp_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Supply-Side Platform (SSP) Platform ID');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `ads_txt_certified` SET TAGS ('dbx_business_glossary_term' = 'Ads.txt Certified');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Endpoint Uniform Resource Locator (URL)');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `api_version` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Version');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `bid_floor_cpm` SET TAGS ('dbx_business_glossary_term' = 'Bid Floor Cost Per Mille (CPM)');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `brand_safety_provider` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Provider');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `ccpa_compliant` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Compliant');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `dsp_integration_list` SET TAGS ('dbx_business_glossary_term' = 'Demand-Side Platform (DSP) Integration List');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `fraud_detection_enabled` SET TAGS ('dbx_business_glossary_term' = 'Fraud Detection Enabled');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `gdpr_compliant` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `health_check_status` SET TAGS ('dbx_business_glossary_term' = 'Health Check Status');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `health_check_status` SET TAGS ('dbx_value_regex' = 'healthy|degraded|down|unknown');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `health_check_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `health_check_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `integration_date` SET TAGS ('dbx_business_glossary_term' = 'Integration Date');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `integration_type` SET TAGS ('dbx_business_glossary_term' = 'Integration Type');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `integration_type` SET TAGS ('dbx_value_regex' = 'api|tag_based|server_to_server|hybrid|direct_integration');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Health Check Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `mrc_accredited` SET TAGS ('dbx_business_glossary_term' = 'Media Rating Council (MRC) Accredited');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `openrtb_version` SET TAGS ('dbx_business_glossary_term' = 'OpenRTB (Real-Time Bidding) Protocol Version');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Supply-Side Platform (SSP) Platform Code');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `platform_name` SET TAGS ('dbx_business_glossary_term' = 'Supply-Side Platform (SSP) Platform Name');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `platform_status` SET TAGS ('dbx_business_glossary_term' = 'Supply-Side Platform (SSP) Platform Status');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `platform_status` SET TAGS ('dbx_value_regex' = 'active|inactive|testing|suspended|deprecated|pending_activation');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `pmp_enabled` SET TAGS ('dbx_business_glossary_term' = 'Private Marketplace (PMP) Enabled');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `programmatic_guaranteed_enabled` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Guaranteed (PG) Enabled');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `qps_limit` SET TAGS ('dbx_business_glossary_term' = 'Queries Per Second (QPS) Limit');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `revenue_share_pct` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `revenue_share_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `rtb_enabled` SET TAGS ('dbx_business_glossary_term' = 'Real-Time Bidding (RTB) Enabled');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `sellers_json_compliant` SET TAGS ('dbx_business_glossary_term' = 'Sellers.json Compliant');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `supported_ad_formats` SET TAGS ('dbx_business_glossary_term' = 'Supported Ad Formats');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `supported_deal_types` SET TAGS ('dbx_business_glossary_term' = 'Supported Deal Types');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `tag_certified` SET TAGS ('dbx_business_glossary_term' = 'Trustworthy Accountability Group (TAG) Certified');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Technical Contact Email Address');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `timeout_ms` SET TAGS ('dbx_business_glossary_term' = 'Timeout Milliseconds');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`ssp_platform` ALTER COLUMN `viewability_measurement_enabled` SET TAGS ('dbx_business_glossary_term' = 'Viewability Measurement Enabled');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `ad_format_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Format ID');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `accepted_file_formats` SET TAGS ('dbx_business_glossary_term' = 'Accepted File Formats');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `accepted_mime_types` SET TAGS ('dbx_business_glossary_term' = 'Accepted Multipurpose Internet Mail Extensions (MIME) Types');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `ad_server_platform_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Ad Server Platform Compatibility');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_value_regex' = '^d+:d+$');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Tier');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_value_regex' = 'standard|enhanced|premium');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_business_glossary_term' = 'Channel Applicability');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `click_through_url_required` SET TAGS ('dbx_business_glossary_term' = 'Click-Through Uniform Resource Locator (URL) Required');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Date');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `device_type_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Device Type Compatibility');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration in Seconds');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `environment_type` SET TAGS ('dbx_business_glossary_term' = 'Environment Type');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `format_category` SET TAGS ('dbx_business_glossary_term' = 'Format Category');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `format_code` SET TAGS ('dbx_business_glossary_term' = 'Format Code');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `format_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `format_name` SET TAGS ('dbx_business_glossary_term' = 'Format Name');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `format_status` SET TAGS ('dbx_business_glossary_term' = 'Format Status');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `format_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|pending|retired|draft');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `format_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Format Subcategory');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `frequency_cap_recommended` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Recommended');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `height_pixels` SET TAGS ('dbx_business_glossary_term' = 'Height in Pixels');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `iab_format_code` SET TAGS ('dbx_business_glossary_term' = 'Interactive Advertising Bureau (IAB) Format Code');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `iab_format_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `impression_tracking_pixel_required` SET TAGS ('dbx_business_glossary_term' = 'Impression Tracking Pixel Required');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `is_native_format` SET TAGS ('dbx_business_glossary_term' = 'Is Native Format');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `is_programmatic_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Programmatic Eligible');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `max_file_size_kb` SET TAGS ('dbx_business_glossary_term' = 'Maximum File Size in Kilobytes (KB)');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `placement_position_options` SET TAGS ('dbx_business_glossary_term' = 'Placement Position Options');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `supports_animation` SET TAGS ('dbx_business_glossary_term' = 'Supports Animation');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `supports_audio` SET TAGS ('dbx_business_glossary_term' = 'Supports Audio');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `supports_interactivity` SET TAGS ('dbx_business_glossary_term' = 'Supports Interactivity');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `trafficking_notes` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Notes');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `vast_version_supported` SET TAGS ('dbx_business_glossary_term' = 'Video Ad Serving Template (VAST) Version Supported');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `viewability_measurement_supported` SET TAGS ('dbx_business_glossary_term' = 'Viewability Measurement Supported');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `viewability_vendor_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Viewability Vendor Compatibility');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `vpaid_version_supported` SET TAGS ('dbx_business_glossary_term' = 'Video Player-Ad Interface Definition (VPAID) Version Supported');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` ALTER COLUMN `width_pixels` SET TAGS ('dbx_business_glossary_term' = 'Width in Pixels');
ALTER TABLE `advertising_ecm`.`media`.`placement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`media`.`placement` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `advertising_ecm`.`media`.`placement` ALTER COLUMN `placement_id` SET TAGS ('dbx_business_glossary_term' = 'placement Identifier');
ALTER TABLE `advertising_ecm`.`media`.`placement` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Channel Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`placement` ALTER COLUMN `ad_format_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Format Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`placement` ALTER COLUMN `publisher_property_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher Property Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` SET TAGS ('dbx_subdomain' = 'strategic_planning');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Identifier (ID)');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `ad_format_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Format Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `benchmark_code` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Code');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `benchmark_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{6,20}$');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `benchmark_date` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Publication Date');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `benchmark_name` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Name');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `benchmark_status` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Status');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `benchmark_status` SET TAGS ('dbx_value_regex' = 'active|archived|draft|under_review|deprecated');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `benchmark_type` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Type');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `benchmark_type` SET TAGS ('dbx_value_regex' = 'industry_standard|agency_observed|client_specific|competitive|historical|predictive');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `benchmark_value` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Value');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `dma_code` SET TAGS ('dbx_business_glossary_term' = 'Designated Market Area (DMA) Code');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `dma_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'national|regional|dma|local|global');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `is_mrc_accredited` SET TAGS ('dbx_business_glossary_term' = 'Media Rating Council (MRC) Accredited Flag');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `is_verified` SET TAGS ('dbx_business_glossary_term' = 'Verified Flag');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `market_name` SET TAGS ('dbx_business_glossary_term' = 'Market Name');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `measurement_period_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Type');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `methodology_notes` SET TAGS ('dbx_business_glossary_term' = 'Methodology Notes');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `metric_type` SET TAGS ('dbx_business_glossary_term' = 'Metric Type');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `percentile_rank` SET TAGS ('dbx_business_glossary_term' = 'Percentile Rank');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `planning_cycle` SET TAGS ('dbx_business_glossary_term' = 'Planning Cycle');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `unit` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Unit of Measure');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `unit` SET TAGS ('dbx_value_regex' = 'percentage|currency|ratio|impressions|clicks|conversions');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `verified_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `advertising_ecm`.`media`.`benchmark` ALTER COLUMN `vertical` SET TAGS ('dbx_business_glossary_term' = 'Industry Vertical');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `channel_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Rate ID');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `ad_format_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Format Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `programmatic_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Deal ID');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `publisher_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher ID');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `agency_commission_pct` SET TAGS ('dbx_business_glossary_term' = 'Agency Commission Percentage');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `cancellation_policy` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `daypart_code` SET TAGS ('dbx_business_glossary_term' = 'Daypart Code');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `discount_pct` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `dma_code` SET TAGS ('dbx_business_glossary_term' = 'Designated Market Area (DMA) Code');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `dsp_platform` SET TAGS ('dbx_business_glossary_term' = 'Demand-Side Platform (DSP)');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `floor_cpm` SET TAGS ('dbx_business_glossary_term' = 'Floor Cost Per Mille (CPM)');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `gross_rate` SET TAGS ('dbx_business_glossary_term' = 'Gross Rate');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `guaranteed_impressions` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Impressions');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `makegood_policy` SET TAGS ('dbx_business_glossary_term' = 'Makegood Policy');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `market_name` SET TAGS ('dbx_business_glossary_term' = 'Market Name');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `net_rate` SET TAGS ('dbx_business_glossary_term' = 'Net Rate');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Notes');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `prisma_rate_code` SET TAGS ('dbx_business_glossary_term' = 'Mediaocean Prisma Rate ID');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `rate_card_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Code');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `rate_card_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Name');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `rate_source` SET TAGS ('dbx_business_glossary_term' = 'Rate Source');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `rate_source` SET TAGS ('dbx_value_regex' = 'vendor_published|direct_negotiation|agency_negotiation|programmatic_platform|rate_card_database');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Status');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|superseded');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `ssp_exchange` SET TAGS ('dbx_business_glossary_term' = 'Supply-Side Platform (SSP) Exchange');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `volume_tier_max` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier Maximum');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `volume_tier_min` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier Minimum');
ALTER TABLE `advertising_ecm`.`media`.`channel_rate` ALTER COLUMN `volume_tier_name` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier Name');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `compliance_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Rule Identifier (ID)');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `ssp_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ssp Platform Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `ad_format_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Ad Format Restrictions');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `applies_to_direct_buy` SET TAGS ('dbx_business_glossary_term' = 'Applies to Direct Buy');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `applies_to_programmatic` SET TAGS ('dbx_business_glossary_term' = 'Applies to Programmatic');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `audit_trail_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Required');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Tier');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_value_regex' = 'high|medium|low|custom');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `consent_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Consent Mechanism');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `data_retention_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Days');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `disclosure_requirement` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Requirement');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `enforcement_level` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Level');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `enforcement_level` SET TAGS ('dbx_value_regex' = 'mandatory|recommended|advisory');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `frequency_cap_limit` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Limit');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `frequency_cap_period` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Period');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `frequency_cap_period` SET TAGS ('dbx_value_regex' = 'hour|day|week|month|campaign');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `penalty_description` SET TAGS ('dbx_business_glossary_term' = 'Penalty Description');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `reference_document_code` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Identifier (ID)');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `reference_url` SET TAGS ('dbx_business_glossary_term' = 'Reference Uniform Resource Locator (URL)');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `reference_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `requires_consent` SET TAGS ('dbx_business_glossary_term' = 'Requires Consent');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `restricted_audience_segments` SET TAGS ('dbx_business_glossary_term' = 'Restricted Audience Segments');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `restricted_content_types` SET TAGS ('dbx_business_glossary_term' = 'Restricted Content Types');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_business_glossary_term' = 'Rule Category');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_value_regex' = 'disclosure|consent|targeting|creative_content|data_usage|measurement');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Rule Code');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Status');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|deprecated|suspended');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Rule Type');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'regulatory|platform_policy|industry_standard|brand_safety|privacy|content_restriction');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `third_party_verification_required` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Verification Required');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `verification_vendor` SET TAGS ('dbx_business_glossary_term' = 'Verification Vendor');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `viewability_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Viewability Threshold Percentage (Pct)');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `violation_action` SET TAGS ('dbx_business_glossary_term' = 'Violation Action');
ALTER TABLE `advertising_ecm`.`media`.`compliance_rule` ALTER COLUMN `violation_action` SET TAGS ('dbx_value_regex' = 'block|warn|log|escalate');
ALTER TABLE `advertising_ecm`.`media`.`availability` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`media`.`availability` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `availability_id` SET TAGS ('dbx_business_glossary_term' = 'Availability ID');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `ad_format_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Format Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `programmatic_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `publisher_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher ID');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `availability_code` SET TAGS ('dbx_business_glossary_term' = 'Availability Code');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Availability Status');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `availability_status` SET TAGS ('dbx_value_regex' = 'available|sold|reserved|blackout|pending');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `availability_type` SET TAGS ('dbx_business_glossary_term' = 'Availability Type');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `availability_type` SET TAGS ('dbx_value_regex' = 'real_time|forecasted|reserved|guaranteed|non_guaranteed');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `available_impressions` SET TAGS ('dbx_business_glossary_term' = 'Available Impressions');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `blackout_end_date` SET TAGS ('dbx_business_glossary_term' = 'Blackout End Date');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `blackout_reason` SET TAGS ('dbx_business_glossary_term' = 'Blackout Reason');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `blackout_start_date` SET TAGS ('dbx_business_glossary_term' = 'Blackout Start Date');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|ctv|smart_display');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `dma_code` SET TAGS ('dbx_business_glossary_term' = 'Designated Market Area (DMA) Code');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `dsp_platform` SET TAGS ('dbx_business_glossary_term' = 'Demand-Side Platform (DSP) Platform');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `environment_type` SET TAGS ('dbx_business_glossary_term' = 'Environment Type');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `environment_type` SET TAGS ('dbx_value_regex' = 'web|mobile_web|mobile_app|ctv|dooh');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `floor_cpm` SET TAGS ('dbx_business_glossary_term' = 'Floor Cost Per Mille (CPM)');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `forecast_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Date');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `forecast_methodology` SET TAGS ('dbx_business_glossary_term' = 'Forecast Methodology');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `market_name` SET TAGS ('dbx_business_glossary_term' = 'Market Name');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `remaining_capacity_pct` SET TAGS ('dbx_business_glossary_term' = 'Remaining Capacity Percentage');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `reserved_impressions` SET TAGS ('dbx_business_glossary_term' = 'Reserved Impressions');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `seasonal_demand_signal` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Demand Signal');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `seasonal_demand_signal` SET TAGS ('dbx_value_regex' = 'low|medium|high|peak');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `sold_impressions` SET TAGS ('dbx_business_glossary_term' = 'Sold Impressions');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `source_system_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `ssp_exchange` SET TAGS ('dbx_business_glossary_term' = 'Supply-Side Platform (SSP) Exchange');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `total_impressions` SET TAGS ('dbx_business_glossary_term' = 'Total Impressions');
ALTER TABLE `advertising_ecm`.`media`.`availability` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` SET TAGS ('dbx_subdomain' = 'strategic_planning');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `flowchart_id` SET TAGS ('dbx_business_glossary_term' = 'Media Flowchart ID');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `creative_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Brief Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan ID');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `persona_id` SET TAGS ('dbx_business_glossary_term' = 'Target Persona Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Planner ID');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `revised_from_flowchart_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `account_executive_name` SET TAGS ('dbx_business_glossary_term' = 'Account Executive Name');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|presented|client_approved|revised|rejected|archived');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `approved_by_title` SET TAGS ('dbx_business_glossary_term' = 'Approved By Title');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `channel_summary_json` SET TAGS ('dbx_business_glossary_term' = 'Channel Summary JSON');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `export_file_path` SET TAGS ('dbx_business_glossary_term' = 'Export File Path');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `export_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `export_format` SET TAGS ('dbx_business_glossary_term' = 'Export Format');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `export_format` SET TAGS ('dbx_value_regex' = 'pdf|excel|powerpoint|google_slides');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `flighting_pattern_json` SET TAGS ('dbx_business_glossary_term' = 'Flighting Pattern JSON');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `flowchart_name` SET TAGS ('dbx_business_glossary_term' = 'Flowchart Name');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `flowchart_number` SET TAGS ('dbx_business_glossary_term' = 'Flowchart Number');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `frequency_target` SET TAGS ('dbx_business_glossary_term' = 'Frequency Target');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `grp_target` SET TAGS ('dbx_business_glossary_term' = 'Gross Rating Point (GRP) Target');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `impression_target` SET TAGS ('dbx_business_glossary_term' = 'Impression Target');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `market_breakout` SET TAGS ('dbx_business_glossary_term' = 'Market Breakout');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `market_breakout` SET TAGS ('dbx_value_regex' = 'national|spot|local|dma|regional|custom');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `planner_name` SET TAGS ('dbx_business_glossary_term' = 'Planner Name');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `presentation_date` SET TAGS ('dbx_business_glossary_term' = 'Presentation Date');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `primary_kpi` SET TAGS ('dbx_business_glossary_term' = 'Primary Key Performance Indicator (KPI)');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `prisma_flowchart_code` SET TAGS ('dbx_business_glossary_term' = 'Prisma Flowchart ID');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `reach_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Reach Target Percentage');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `time_granularity` SET TAGS ('dbx_business_glossary_term' = 'Time Granularity');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `time_granularity` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|custom');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `total_flowchart_budget` SET TAGS ('dbx_business_glossary_term' = 'Total Flowchart Budget');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `trp_target` SET TAGS ('dbx_business_glossary_term' = 'Target Rating Point (TRP) Target');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`flowchart` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `advertising_ecm`.`media`.`channel_supplier_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`media`.`channel_supplier_agreement` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `advertising_ecm`.`media`.`channel_supplier_agreement` SET TAGS ('dbx_association_edges' = 'media.ad_channel,vendor.supplier');
ALTER TABLE `advertising_ecm`.`media`.`channel_supplier_agreement` ALTER COLUMN `channel_supplier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Supplier Agreement ID');
ALTER TABLE `advertising_ecm`.`media`.`channel_supplier_agreement` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Supplier Agreement - Ad Channel Id');
ALTER TABLE `advertising_ecm`.`media`.`channel_supplier_agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Supplier Agreement - Supplier Id');
ALTER TABLE `advertising_ecm`.`media`.`channel_supplier_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `advertising_ecm`.`media`.`channel_supplier_agreement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date');
ALTER TABLE `advertising_ecm`.`media`.`channel_supplier_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Date');
ALTER TABLE `advertising_ecm`.`media`.`channel_supplier_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Expiration Date');
ALTER TABLE `advertising_ecm`.`media`.`channel_supplier_agreement` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Date');
ALTER TABLE `advertising_ecm`.`media`.`channel_supplier_agreement` ALTER COLUMN `minimum_spend_commitment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Spend Commitment');
ALTER TABLE `advertising_ecm`.`media`.`channel_supplier_agreement` ALTER COLUMN `minimum_spend_commitment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`channel_supplier_agreement` ALTER COLUMN `negotiated_commission_pct` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Commission Percentage');
ALTER TABLE `advertising_ecm`.`media`.`channel_supplier_agreement` ALTER COLUMN `negotiated_commission_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`channel_supplier_agreement` ALTER COLUMN `preferred_status` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Status');
ALTER TABLE `advertising_ecm`.`media`.`channel_supplier_agreement` ALTER COLUMN `sla_terms` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement Terms');
ALTER TABLE `advertising_ecm`.`media`.`format_availability` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`media`.`format_availability` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `advertising_ecm`.`media`.`format_availability` SET TAGS ('dbx_association_edges' = 'media.ad_format,vendor.publisher');
ALTER TABLE `advertising_ecm`.`media`.`format_availability` ALTER COLUMN `format_availability_id` SET TAGS ('dbx_business_glossary_term' = 'Format Availability Identifier');
ALTER TABLE `advertising_ecm`.`media`.`format_availability` ALTER COLUMN `ad_format_id` SET TAGS ('dbx_business_glossary_term' = 'Format Availability - Ad Format Id');
ALTER TABLE `advertising_ecm`.`media`.`format_availability` ALTER COLUMN `programmatic_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Deal Identifier');
ALTER TABLE `advertising_ecm`.`media`.`format_availability` ALTER COLUMN `publisher_id` SET TAGS ('dbx_business_glossary_term' = 'Format Availability - Publisher Id');
ALTER TABLE `advertising_ecm`.`media`.`format_availability` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Availability Status');
ALTER TABLE `advertising_ecm`.`media`.`format_availability` ALTER COLUMN `average_cpm` SET TAGS ('dbx_business_glossary_term' = 'Average CPM Rate');
ALTER TABLE `advertising_ecm`.`media`.`format_availability` ALTER COLUMN `brand_safety_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Tier');
ALTER TABLE `advertising_ecm`.`media`.`format_availability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`format_availability` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`media`.`format_availability` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`media`.`format_availability` ALTER COLUMN `floor_cpm` SET TAGS ('dbx_business_glossary_term' = 'Floor CPM Rate');
ALTER TABLE `advertising_ecm`.`media`.`format_availability` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Update Date');
ALTER TABLE `advertising_ecm`.`media`.`format_availability` ALTER COLUMN `monthly_impressions` SET TAGS ('dbx_business_glossary_term' = 'Monthly Impression Volume');
ALTER TABLE `advertising_ecm`.`media`.`format_availability` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operational Notes');
ALTER TABLE `advertising_ecm`.`media`.`format_availability` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`format_availability` ALTER COLUMN `viewability_rate` SET TAGS ('dbx_business_glossary_term' = 'Viewability Rate');
ALTER TABLE `advertising_ecm`.`media`.`io_creative_trafficking` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`media`.`io_creative_trafficking` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `advertising_ecm`.`media`.`io_creative_trafficking` SET TAGS ('dbx_association_edges' = 'media.media_insertion_order,creative.creative_asset');
ALTER TABLE `advertising_ecm`.`media`.`io_creative_trafficking` ALTER COLUMN `io_creative_trafficking_id` SET TAGS ('dbx_business_glossary_term' = 'IO Creative Trafficking ID');
ALTER TABLE `advertising_ecm`.`media`.`io_creative_trafficking` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `advertising_ecm`.`media`.`io_creative_trafficking` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Io Creative Trafficking - Creative Asset Id');
ALTER TABLE `advertising_ecm`.`media`.`io_creative_trafficking` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Io Creative Trafficking - Media Insertion Order Id');
ALTER TABLE `advertising_ecm`.`media`.`io_creative_trafficking` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Creative Approval Date');
ALTER TABLE `advertising_ecm`.`media`.`io_creative_trafficking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`io_creative_trafficking` ALTER COLUMN `creative_status` SET TAGS ('dbx_business_glossary_term' = 'Creative Trafficking Status');
ALTER TABLE `advertising_ecm`.`media`.`io_creative_trafficking` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Creative Flight End Date');
ALTER TABLE `advertising_ecm`.`media`.`io_creative_trafficking` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Creative Flight Start Date');
ALTER TABLE `advertising_ecm`.`media`.`io_creative_trafficking` ALTER COLUMN `rotation_weight` SET TAGS ('dbx_business_glossary_term' = 'Rotation Weight');
ALTER TABLE `advertising_ecm`.`media`.`io_creative_trafficking` ALTER COLUMN `trafficking_date` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Date');
ALTER TABLE `advertising_ecm`.`media`.`io_creative_trafficking` ALTER COLUMN `trafficking_notes` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Notes');
ALTER TABLE `advertising_ecm`.`media`.`io_creative_trafficking` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`media`.`allocation` SET TAGS ('dbx_subdomain' = 'strategic_planning');
ALTER TABLE `advertising_ecm`.`media`.`allocation` SET TAGS ('dbx_association_edges' = 'media.media_plan,project.work_package');
ALTER TABLE `advertising_ecm`.`media`.`allocation` ALTER COLUMN `allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Identifier');
ALTER TABLE `advertising_ecm`.`media`.`allocation` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation - Media Plan Id');
ALTER TABLE `advertising_ecm`.`media`.`allocation` ALTER COLUMN `work_package_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation - Work Package Id');
ALTER TABLE `advertising_ecm`.`media`.`allocation` ALTER COLUMN `actual_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Effort Hours');
ALTER TABLE `advertising_ecm`.`media`.`allocation` ALTER COLUMN `actual_spend_from_work_package` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Allocation');
ALTER TABLE `advertising_ecm`.`media`.`allocation` ALTER COLUMN `allocated_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Allocated Effort Hours');
ALTER TABLE `advertising_ecm`.`media`.`allocation` ALTER COLUMN `billing_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Status');
ALTER TABLE `advertising_ecm`.`media`.`allocation` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Created Date');
ALTER TABLE `advertising_ecm`.`media`.`allocation` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `advertising_ecm`.`media`.`allocation` ALTER COLUMN `modified_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Modified Date');
ALTER TABLE `advertising_ecm`.`media`.`allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `advertising_ecm`.`media`.`allocation` ALTER COLUMN `percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `advertising_ecm`.`media`.`allocation` ALTER COLUMN `planned_spend_from_work_package` SET TAGS ('dbx_business_glossary_term' = 'Planned Spend Allocation');
ALTER TABLE `advertising_ecm`.`media`.`allocation` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Start Date');
ALTER TABLE `advertising_ecm`.`media`.`plan_asset_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`media`.`plan_asset_assignment` SET TAGS ('dbx_subdomain' = 'strategic_planning');
ALTER TABLE `advertising_ecm`.`media`.`plan_asset_assignment` SET TAGS ('dbx_association_edges' = 'media.media_plan,creative.creative_asset');
ALTER TABLE `advertising_ecm`.`media`.`plan_asset_assignment` ALTER COLUMN `plan_asset_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Asset Assignment Identifier');
ALTER TABLE `advertising_ecm`.`media`.`plan_asset_assignment` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By Worker');
ALTER TABLE `advertising_ecm`.`media`.`plan_asset_assignment` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Asset Assignment - Creative Asset Id');
ALTER TABLE `advertising_ecm`.`media`.`plan_asset_assignment` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Asset Assignment - Media Plan Id');
ALTER TABLE `advertising_ecm`.`media`.`plan_asset_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `advertising_ecm`.`media`.`plan_asset_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `advertising_ecm`.`media`.`plan_asset_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `advertising_ecm`.`media`.`plan_asset_assignment` ALTER COLUMN `channel_assignment` SET TAGS ('dbx_business_glossary_term' = 'Channel Assignment');
ALTER TABLE `advertising_ecm`.`media`.`plan_asset_assignment` ALTER COLUMN `market_assignment` SET TAGS ('dbx_business_glossary_term' = 'Market Assignment');
ALTER TABLE `advertising_ecm`.`media`.`plan_asset_assignment` ALTER COLUMN `planned_usage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Usage End Date');
ALTER TABLE `advertising_ecm`.`media`.`plan_asset_assignment` ALTER COLUMN `planned_usage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Usage Start Date');
ALTER TABLE `advertising_ecm`.`media`.`plan_asset_assignment` ALTER COLUMN `rotation_weight` SET TAGS ('dbx_business_glossary_term' = 'Rotation Weight');
ALTER TABLE `advertising_ecm`.`media`.`plan_asset_assignment` ALTER COLUMN `trafficking_priority` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Priority');
