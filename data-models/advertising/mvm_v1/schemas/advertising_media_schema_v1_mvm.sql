-- Schema for Domain: media | Business: Advertising | Version: v1_mvm
-- Generated on: 2026-05-08 03:52:18

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `advertising_ecm`.`media` COMMENT 'Governs all media and channel operations — including channel taxonomy, publisher properties, placements, media planning, buying, trafficking, programmatic deals, rate cards, reconciliation, and delivery scheduling across all paid media channels (digital, broadcast, OOH, CTV/OTT, print).';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`media_insertion_order` (
    `media_insertion_order_id` BIGINT COMMENT 'Unique surrogate identifier for the Insertion Order record in the lakehouse Silver layer. Primary key. Entity role: TRANSACTION_HEADER — this is a discrete contractual business event with a clear lifecycle (draft → executed → cancelled), carrying authorized spend, flight dates, and vendor/advertiser party references.',
    `ad_channel_id` BIGINT COMMENT 'Foreign key linking to media.ad_channel. Business justification: media_insertion_order currently has channel_type as a STRING attribute. IOs are issued to media vendors for specific advertising channels (e.g., IO for Display advertising, IO for CTV). This FK normal',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser (client brand) on whose behalf this IO is issued. Links to the client.advertiser master record. Satisfies TRANSACTION_HEADER PARTY_REFERENCE category.',
    `agency_relationship_id` BIGINT COMMENT 'Foreign key linking to client.agency_relationship. Business justification: IOs are issued under a specific agency-client relationship that determines commission rates, billing terms, and notice periods applied on the IO. IO-level agency relationship tracking is standard in m',
    `agreement_id` BIGINT COMMENT 'Reference to the overarching master service agreement or framework contract under which this IO is issued. Supports contract hierarchy and legal compliance tracking.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: IOs authorize spend for a specific brand. Brand-level IO tracking is required for brand budget reconciliation, brand safety enforcement, and publisher-facing brand identification. Media buyers and fin',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign this IO supports. Enables campaign-level spend aggregation, KPI tracking, and ROAS reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Insertion orders require cost center assignment for budget allocation, financial reporting, and expense tracking - fundamental financial control in advertising operations.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Insertion orders must reference approved budgets for spend authorization, compliance checking, and budget consumption tracking in financial controls.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: IOs are the primary financial commitment document in agency media operations. GL account coding at the IO level is required for accounts payable posting, accrual accounting, and financial statement cl',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Insertion orders execute within strategic initiatives. Linking enables portfolio-level budget management, cross-campaign spend analysis, and strategic alignment reporting required for client business ',
    `plan_id` BIGINT COMMENT 'Reference to the parent media plan from which this IO was generated. Enables traceability from strategic plan through execution to billing.',
    `publisher_id` BIGINT COMMENT 'Reference to the media vendor or publisher receiving this IO. Links to the vendor master record for payment, reconciliation, and compliance checks.',
    `publisher_property_id` BIGINT COMMENT 'Foreign key linking to media.publisher_property. Business justification: media_insertion_order currently has FK to publisher (parent entity). Many IOs are property-specific (e.g., IO for NYTimes.com, IO for WSJ Print Edition). While media_insertion_order → publisher → publ',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: An IO is issued under a specific SOW that authorizes the media spend — more granular than the master agreement already linked. Agencies track IO spend against SOW budgets for client billing and scope ',
    `supplier_id` BIGINT COMMENT 'Reference to the internal agency entity (buying unit) issuing this IO on behalf of the advertiser. Supports multi-agency holding company structures and commission calculations.',
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
    `agency_relationship_id` BIGINT COMMENT 'Foreign key linking to client.agency_relationship. Business justification: A media plan is executed under a specific agency-client AOR relationship, which governs commission rates, scope of services, and approval workflows applied to the plan. Planners must reference the AOR',
    `brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: Media plans are developed at the brand level — brand guidelines, safety requirements, SOV targets, and budget allocations are brand-specific. Brand-level media planning is a core advertising workflow;',
    `campaign_id` BIGINT COMMENT 'Reference to the parent campaign this media plan supports. Links the media plan to its overarching campaign strategy and objectives.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Media plans must be assigned to cost centers for budget planning, approval workflows, and financial accountability in campaign planning processes.',
    `creative_brief_id` BIGINT COMMENT 'Foreign key linking to creative.creative_brief. Business justification: Media plans are built from creative briefs that define messaging, audience, deliverables, and mandatories. Planners reference the brief throughout planning to ensure media strategy aligns with creativ',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Media plans tied to specific budgets for planning, approval workflows, and budget allocation - fundamental financial planning relationship.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Media plans are budget authorization documents requiring GL account coding for revenue recognition and cost allocation reporting. Agency finance teams code plans to GL accounts to support P&L reportin',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Media plans are tracked as projects/initiatives in project management systems. Currently workfront_project_id is stored as an unlinked string. Normalizing to initiative_id FK enables joining to projec',
    `persona_id` BIGINT COMMENT 'Foreign key linking to audience.persona. Business justification: Persona-based media planning: media plans are strategically built around target personas (channel mix, daypart, content preferences). A domain expert expects the plan to reference the persona driving ',
    `segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Media plans define primary target audience segments for campaign planning, budget allocation, and channel mix decisions. Core planning workflow requires linking plan to specific audience segment for t',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Media plans are executed under SOWs that authorize budget and scope. Planners reference the governing SOW for budget authority validation and scope compliance checks. Essential for financial controls ',
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
    `asset_id` BIGINT COMMENT 'Foreign key linking to creative.creative_asset. Business justification: Plan lines specify which creative assets will run in each placement. Essential for trafficking planning, publisher spec validation, and ensuring creative is ready before media flights begin.',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign this media plan line supports. Links the line item to the overarching campaign strategy and objectives for cross-campaign reporting and budget tracking.',
    `contract_rate_card_id` BIGINT COMMENT 'Foreign key linking to contract.contract_rate_card. Business justification: Media planners validate planned CPMs/rates against negotiated contract rate cards during plan line creation. This link enables rate compliance reporting — confirming planned spend aligns with contract',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Plan lines often allocated to specific cost centers for granular budget tracking and cross-functional cost allocation in matrix organizations.',
    `creative_brief_id` BIGINT COMMENT 'Foreign key linking to creative.creative_brief. Business justification: Plan lines are built to fulfill creative brief requirements (channel, format, audience). In multi-brand or multi-brief campaigns, individual plan lines may reference different briefs than the parent p',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Plan lines represent individual media cost commitments by channel/format. GL account coding at the line level enables granular cost classification for financial reporting, supporting channel-level P&L',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: A plan line is executed via a media insertion order — the IO is the contractual instrument that authorizes the buy for that plan line. Adding media_insertion_order_id to plan_line provides direct trac',
    `media_placement_id` BIGINT COMMENT 'Reference to the specific media placement or ad unit associated with this line item. Links to the placement master record defining the ad environment, size, and position. RESOURCE_REFERENCE per TRANSACTION_LINE canonical role.',
    `plan_id` BIGINT COMMENT 'Reference to the parent media plan that contains this line item. Establishes the header/detail relationship between the media plan and its individual line items. HEADER_REFERENCE per TRANSACTION_LINE canonical role.',
    `programmatic_deal_id` BIGINT COMMENT 'Unique deal identifier for programmatic private marketplace (PMP) or programmatic guaranteed (PG) transactions associated with this line item. Used in The Trade Desk and DSP platforms for deal activation and reporting.',
    `publisher_id` BIGINT COMMENT 'FK to vendor.publisher',
    `publisher_property_id` BIGINT COMMENT 'Foreign key linking to media.publisher_property. Business justification: A plan line specifies the exact publisher property (vehicle) where the ad will run — e.g., CNN.com, ESPN App, NBC broadcast. plan_line currently has vehicle_name (STRING) which is a denormalized refer',
    `segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Plan lines specify granular audience targeting for individual media vehicles and tactics. Buyers need explicit segment linkage for rate negotiation, inventory availability checks, and delivery forecas',
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
    CONSTRAINT pk_plan_line PRIMARY KEY(`plan_line_id`)
) COMMENT 'Individual line-item within a media plan representing a specific channel, vehicle, and flight combination. Captures line number, media type (TV, digital, OOH, print, OTT/CTV, DOOH), vehicle name, market, start/end dates, planned units, planned GRPs/TRPs, planned impressions, planned CPM/CPC/CPA, planned spend, and approval status. Enables granular budget allocation and channel-level planning visibility.';

CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`media_placement` (
    `media_placement_id` BIGINT COMMENT 'Unique surrogate identifier for the media placement record. This is the atomic unit of a media buy, representing a specific ad placement purchased from a media vendor. Role: TRANSACTION_LINE.',
    `ad_channel_id` BIGINT COMMENT 'Foreign key linking to media.ad_channel. Business justification: placement defines specific ad placement positions within a publisher property and channel. Currently placement has no FK to ad_channel. This FK establishes that each placement operates within a specif',
    `ad_format_id` BIGINT COMMENT 'Foreign key linking to media.ad_format. Business justification: media_placement currently has ad_format and ad_unit_size as STRING attributes. Each placement is for a specific ad format (e.g., 300x250 Banner, Pre-roll Video). This FK normalizes the placement-to-fo',
    `tech_partner_id` BIGINT COMMENT 'Foreign key linking to vendor.tech_partner. Business justification: Media placements reference ad_server_platform as plain text. Linking to tech_partner normalizes this and enables ad serving vendor management: tracking tech fees per placement, SLA compliance for ad s',
    `asset_id` BIGINT COMMENT 'Foreign key linking to creative.creative_asset. Business justification: Placements are assigned specific creative assets for delivery. Essential for trafficking, ad server setup, and ensuring creative specs match placement requirements. Distinct from ad_server_placement_i',
    `contract_rate_card_id` BIGINT COMMENT 'Foreign key linking to contract.contract_rate_card. Business justification: Media placements carry contracted_rate and contracted_value fields that must be validated against the negotiated rate card. This link enables placement-level rate compliance auditing — verifying that ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Media placements incur contracted costs that require cost center attribution for financial reporting. Placement-level cost center coding supports granular P&L analysis by channel and client, and is re',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Placements are the billing unit for media reconciliation. GL account coding at placement level supports invoice line matching, accrual posting, and billing dispute resolution. Agency billing systems r',
    `placement_id` BIGINT COMMENT 'The placement identifier assigned by Google Campaign Manager 360 (CM360) ad server used for trafficking, creative assignment, and delivery reporting. This is the operational key used by ad operations teams to manage the placement in the ad server.',
    `media_catalog_placement_id` BIGINT COMMENT 'Foreign key linking to media.placement. Business justification: media_placement is the operational purchased placement record, while placement is the catalog/reference definition of a placement position. An operational media_placement should reference the catalog ',
    `media_insertion_order_id` BIGINT COMMENT 'Reference to the parent Insertion Order (IO) under which this placement was purchased. An IO is the binding contract between the advertiser/agency and the media vendor authorizing the placement. Serves as the HEADER_REFERENCE for this transaction line.',
    `original_placement_media_placement_id` BIGINT COMMENT 'For make-good placements (is_makegood = true), the reference to the original media_placement_id that this placement is compensating for. Enables traceability between under-delivered placements and their corresponding make-good replacements.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Placements are bought and trafficked against specific audience segments. Ad ops teams require explicit segment linkage for ad server targeting setup, delivery pacing, and performance reporting by audi',
    `programmatic_deal_id` BIGINT COMMENT 'The unique deal identifier for programmatic private marketplace (PMP) or programmatic guaranteed deals, as assigned by the Supply-Side Platform (SSP) or publisher. Used to activate and track the deal in The Trade Desk Demand-Side Platform (DSP). Null for direct or open auction buys.',
    `publisher_id` BIGINT COMMENT 'Reference to the media vendor or publisher from whom this placement was purchased (e.g., Google, Meta, NBC Universal, Clear Channel). Serves as the PARTY_REFERENCE for this transaction line.',
    `publisher_property_id` BIGINT COMMENT 'Foreign key linking to media.publisher_property. Business justification: placement defines specific ad positions within a publisher property (e.g., homepage leaderboard on NYTimes.com). Each placement belongs to one publisher property. This FK establishes the parent-child ',
    `spec_id` BIGINT COMMENT 'Foreign key linking to creative.spec. Business justification: Ad ops teams must verify that a placements accepted ad unit size, format, and technical requirements match the creative spec before trafficking. Placement-to-spec alignment is a mandatory pre-traffic',
    `above_fold_classification` STRING COMMENT 'Classification indicating whether the placement typically appears above or below the fold on initial page load, critical for viewability.. Valid values are `above_fold|below_fold|mixed|not_applicable`',
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
    `asset_id` BIGINT COMMENT 'Foreign key linking to creative.creative_asset. Business justification: Buyers need to know which creative asset will run in each buy for trafficking instructions, publisher spec validation, and delivery verification. Critical for makegood and reconciliation processes.',
    `contract_rate_card_id` BIGINT COMMENT 'Foreign key linking to contract.contract_rate_card. Business justification: Media buyers must confirm negotiated buy rates conform to the contracted rate card — a core billing audit and reconciliation process. Linking buy to contract_rate_card enables rate variance reporting ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Media buys require cost center for expense tracking, financial reconciliation, and variance reporting - core financial control requirement.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Media buys must reference budgets for spend tracking, variance analysis, and budget compliance monitoring in financial management.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Media buys are the transactional unit generating vendor payables. GL account coding at the buy level is required for accounts payable posting and cost accrual. Agency finance systems require buy-to-GL',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Media buys roll up to initiatives for consolidated financial tracking. Required for initiative-level ROI analysis, strategic performance measurement, and cross-campaign budget reconciliation in agency',
    `media_insertion_order_id` BIGINT COMMENT 'Reference to the authorizing Insertion Order (IO) under which this media buy is executed. Links the buy to its contractual authorization and spend ceiling.',
    `media_placement_id` BIGINT COMMENT 'Reference to the specific media placement or ad unit being purchased (e.g., a specific ad slot, daypart, or digital placement). Links to the placement master in the media domain.',
    `plan_line_id` BIGINT COMMENT 'Reference to the specific media plan line item this buy executes against. Ties the transactional buy back to the approved media plan for reconciliation and pacing.',
    `programmatic_deal_id` BIGINT COMMENT 'Foreign key linking to media.programmatic_deal. Business justification: buy is the transactional record of a media purchase. While buy → plan_line → programmatic_deal path exists, many buys are directly associated with a specific programmatic deal (PMP, programmatic guara',
    `segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Media buys execute against defined audience targets for delivery and measurement. Buyers negotiate rates and inventory based on specific segment reach and composition. Essential for buy reconciliation',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Media buys are authorized under a specific SOW that defines the contractual scope and budget. Linking buy to sow enables SOW budget consumption tracking and ensures each buy is executed within the cor',
    `supplier_id` BIGINT COMMENT 'Reference to the media vendor or publisher from whom the media inventory is purchased (e.g., broadcast network, digital publisher, OOH operator). Maps to the vendor master.',
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
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Programmatic deals (PMPs, preferred deals, guaranteed deals) are negotiated under a master agreement with the publisher. This link enables contract compliance tracking for programmatic inventory commi',
    `brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: Programmatic deals (PMPs, preferred deals) are negotiated at the brand level — brand safety tiers, audience targeting, and floor CPMs are brand-specific. Brand-level deal tracking is essential for com',
    `campaign_id` BIGINT COMMENT 'Reference to the parent advertising campaign under which this programmatic deal is executed. Links the deal to campaign-level objectives, KPIs, and budget in Google Campaign Manager 360 and The Trade Desk.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Programmatic deals are cost-center-specific financial commitments in agency operations. Cost center attribution at the deal level is required for P&L reporting by business unit and client, and for int',
    `tech_partner_id` BIGINT COMMENT 'Foreign key linking to vendor.tech_partner. Business justification: Programmatic deals reference dsp_platform as plain text. Linking to tech_partner via dsp_tech_partner_id normalizes DSP vendor attribution, enabling programmatic tech fee tracking, DSP SLA management,',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: Programmatic deals carry a budget_amount commitment that must be tracked against an approved finance budget for spend control. Deal-level budget authorization is required for programmatic trading desk',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Programmatic deals are financial commitments with budget amounts requiring GL account coding for accrual accounting and cost classification. Deal-level GL coding supports programmatic spend reporting ',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: programmatic_deal currently has io_number (STRING) which is a denormalized reference to the parent insertion order. Programmatic deals are executed under a master IO — the IO provides the contractual ',
    `publisher_id` BIGINT COMMENT 'Unique identifier for the publisher as assigned by the SSP, exchange, or DSP platform. Used for supply path optimization, publisher-level reconciliation, and cross-platform publisher deduplication.',
    `publisher_property_id` BIGINT COMMENT 'Foreign key linking to media.publisher_property. Business justification: programmatic_deal currently has FK to publisher (parent entity). Many programmatic deals are property-specific (e.g., deal for NYTimes.com homepage, deal for WSJ Mobile App). While programmatic_deal →',
    `segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Programmatic deals (PMP/PG) are negotiated for specific audience segments with publishers and SSPs. Deal setup, activation, and performance measurement require explicit segment linkage for targeting c',
    `spec_id` BIGINT COMMENT 'Foreign key linking to creative.spec. Business justification: Programmatic deal setup requires matching the deals accepted creative formats (VAST version, ad unit size, viewability thresholds) to a creative spec. Ad ops teams perform spec-to-deal alignment duri',
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
    `end_date` DATE COMMENT 'The date on which the programmatic deal expires and is no longer eligible for bidding. Nullable for evergreen deals with no fixed end. Used for pacing, reconciliation, and deal renewal workflows.',
    `environment_type` STRING COMMENT 'The technical environment in which the ad inventory is served (web browser, mobile app, CTV device, DOOH screen, audio stream). Determines applicable measurement standards, viewability metrics, and brand safety controls.. Valid values are `web|app|ctv|dooh|audio`',
    `external_deal_ref` STRING COMMENT 'Secondary external reference identifier for this deal as recorded in a partner system (e.g., publisher deal ID, SSP deal reference, Mediaocean Prisma order number). Enables cross-system reconciliation and deduplication.',
    `floor_cpm` DECIMAL(18,2) COMMENT 'The minimum Cost Per Mille (CPM) bid price in USD required to win impressions under this deal. For PMP and Preferred Deals, this is the negotiated floor; for PG deals, this is the fixed CPM. Critical for bid strategy configuration in The Trade Desk and financial forecasting.',
    `frequency_cap` STRING COMMENT 'Maximum number of times a unique user/device may be served an ad under this deal within the frequency cap period. Configured in The Trade Desk to control ad fatigue and optimize audience reach. Null indicates no frequency cap applied.',
    `frequency_cap_period` STRING COMMENT 'The time window over which the frequency cap applies (hourly, daily, weekly, monthly, or lifetime of the deal). Used in conjunction with frequency_cap to configure audience exposure limits in The Trade Desk.. Valid values are `hourly|daily|weekly|monthly|lifetime`',
    `geo_targeting` STRING COMMENT 'Geographic targeting scope for this deal, expressed as country codes, DMA regions, or postal codes (e.g., USA, USA:DMA:501, GBR). Drives geo-based audience segmentation and regulatory compliance (GDPR for EU inventory, CCPA for California).',
    `impression_commitment` BIGINT COMMENT 'The total number of impressions committed under this deal. Mandatory for Programmatic Guaranteed (PG) deals where delivery is contractually obligated. For PMP and Preferred Deals, represents the estimated or target impression volume. Used for pacing, delivery forecasting, and make-good calculations.',
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
    `asset_id` BIGINT COMMENT 'Reference to the primary creative asset assigned to this media schedule slot. For rotation schedules, this represents the default or primary creative. Links to the creative master record.',
    `buy_id` BIGINT COMMENT 'Foreign key linking to media.buy. Business justification: A schedule is the detailed airing/delivery schedule for a purchased media buy. The buy is the transactional commitment (the business event of purchasing media), and the schedule details WHEN and HOW t',
    `campaign_id` BIGINT COMMENT 'Reference to the parent advertising campaign under which this media schedule is executed. Enables campaign-level roll-up of all scheduled media activity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Scheduled media requires cost center for accrual posting and expense recognition timing in financial close processes.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Broadcast schedules represent committed airtime costs requiring GL account coding for accrual accounting. TV/radio schedule entries drive media cost accruals; GL coding at schedule level is standard i',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Schedules execute initiative-level media strategies. Linking enables initiative performance dashboards, strategic flight pattern analysis, and cross-campaign reach/frequency optimization required for ',
    `media_insertion_order_id` BIGINT COMMENT 'Reference to the Insertion Order (IO) that authorises the purchase of this scheduled media. The IO is the contractual document between the advertiser/agency and the media vendor.',
    `media_placement_id` BIGINT COMMENT 'Reference to the media placement this schedule governs — the specific ad unit slot purchased on a publisher property. Links to the placement master record.',
    `plan_line_id` BIGINT COMMENT 'Foreign key linking to media.plan_line. Business justification: A schedule entry represents the detailed airing/delivery execution of a specific plan line. Adding plan_line_id to schedule provides direct traceability from the operational delivery schedule back to ',
    `programmatic_deal_id` BIGINT COMMENT 'Unique deal identifier for programmatic guaranteed or private marketplace (PMP) transactions, as assigned by the Supply-Side Platform (SSP) or publisher. Used to activate and reconcile programmatic deals in The Trade Desk DSP.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Schedules define when and where ads run against specific audience segments for daypart and vehicle optimization. Planners use segment linkage for reach/frequency modeling and flighting strategy by aud',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Schedules represent execution of media buys authorized under a SOW. Linking schedule to sow enables SOW delivery tracking — confirming scheduled impressions/units are within contractually authorized s',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Schedule records represent actual media delivery execution by a specific supplier (TV station, radio network, digital vendor). Linking schedule to supplier enables vendor delivery performance reportin',
    `trafficking_instruction_id` BIGINT COMMENT 'Foreign key linking to media.trafficking_instruction. Business justification: A schedule entry represents a specific airing/delivery slot that is governed by trafficking instructions sent to the ad server. One trafficking instruction can cover multiple schedule entries (e.g., m',
    `vendor_rate_card_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_rate_card. Business justification: Schedule lines carry cpm_rate and net_cost. Rate card compliance audits require tracing each scheduled rate back to the contracted vendor_rate_card. This is a standard media billing reconciliation pro',
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
    `ad_channel_id` BIGINT COMMENT 'Foreign key linking to media.ad_channel. Business justification: A trafficking instruction is channel-specific — different channels use different ad servers, tag formats (VAST vs. display tags), and trafficking protocols. Linking trafficking_instruction to ad_chann',
    `ad_format_id` BIGINT COMMENT 'Foreign key linking to media.ad_format. Business justification: trafficking_instruction currently has ad_format as a STRING attribute. Trafficking instructions specify the ad format for delivery to ad servers (e.g., 300x250 Banner, VAST 4.0 Video). This FK normali',
    `asset_id` BIGINT COMMENT 'Reference to the creative asset (banner, video, rich media, etc.) being dispatched via this trafficking instruction. Identifies the specific creative unit to be served at the designated placement.',
    `buy_id` BIGINT COMMENT 'Foreign key linking to media.buy. Business justification: A trafficking instruction is issued to execute a specific media buy — it carries the creative assets, targeting parameters, and ad server tags needed to activate the purchased inventory. Linking traff',
    `campaign_id` BIGINT COMMENT 'Reference to the parent advertising campaign under which this trafficking instruction is issued. Provides campaign-level context for reporting and performance attribution.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Trafficking instructions drive ad server costs (third-party verification, ad serving fees) that require cost center attribution. Agency operations allocate trafficking costs to cost centers for client',
    `creative_brief_id` BIGINT COMMENT 'Foreign key linking to creative.creative_brief. Business justification: Trafficking teams must reference the creative brief to confirm spec compliance, messaging mandatories, and legal/regulatory requirements before sending ad tags. A trafficker needs to know which brief ',
    `media_insertion_order_id` BIGINT COMMENT 'Reference to the Insertion Order (IO) authorizing the media buy associated with this trafficking instruction. Provides contractual and financial context for the ad delivery.',
    `media_placement_id` BIGINT COMMENT 'Reference to the media placement for which this trafficking instruction is issued. Links the instruction to the specific ad unit, position, and publisher property where the creative will be delivered.',
    `parent_instruction_trafficking_instruction_id` BIGINT COMMENT 'Reference to the original trafficking instruction that this record revises or cancels. Enables lineage tracking across instruction versions and supports audit of changes to creative delivery parameters.',
    `plan_line_id` BIGINT COMMENT 'Foreign key linking to media.plan_line. Business justification: Trafficking instructions are issued to execute specific media placements that originate from plan lines. Adding plan_line_id to trafficking_instruction provides direct traceability from the ad server ',
    `programmatic_deal_id` BIGINT COMMENT 'Foreign key linking to media.programmatic_deal. Business justification: Trafficking instructions for programmatic placements must reference the programmatic deal that governs the inventory access, floor CPM, targeting parameters, and DSP seat configuration. This FK enable',
    `segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Trafficking instructions configure ad server targeting parameters for specific audience segments. Ad ops teams require explicit segment linkage to set up DMP/DSP integrations, frequency caps, and audi',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Trafficking is a deliverable service often specified in SOWs with defined SLAs. Linking instructions to SOWs enables service-level tracking, supports billing for trafficking services, and validates sc',
    `spec_id` BIGINT COMMENT 'Foreign key linking to creative.spec. Business justification: Trafficking instructions specify exact creative spec requirements (ad size, VAST tag, file format) that must be validated before sending tags. The existing creative_size plain attribute is a denormali',
    `suppression_list_id` BIGINT COMMENT 'Foreign key linking to audience.suppression_list. Business justification: Privacy-compliant ad trafficking: trafficking instructions configure ad server delivery and must reference suppression lists (opted-out users, converted customers) to ensure GDPR/CCPA-compliant servin',
    `tech_partner_id` BIGINT COMMENT 'Foreign key linking to vendor.tech_partner. Business justification: Trafficking instructions specify the ad server platform and brand safety/verification provider. Linking to tech_partner normalizes the ad_server plain-text field and enables vendor SLA tracking, tech ',
    `ad_server_placement_code` STRING COMMENT 'The unique placement tag or code assigned by the ad server (e.g., Google Campaign Manager 360 placement ID) that maps this instruction to the correct ad unit within the ad serving platform. Used for trafficking reconciliation.',
    `brand_safety_provider` STRING COMMENT 'Name of the third-party brand safety and suitability verification provider applied to this trafficking instruction. Ensures ad creative is served only in brand-appropriate content environments per TAG and GARM standards.. Valid values are `DoubleVerify|Integral Ad Science|MOAT|Oracle Contextual|TAG|none`',
    `brand_safety_segment` STRING COMMENT 'Specific brand safety content category or segment classification applied to this instruction (e.g., exclude adult content, exclude fake news, GARM Floor). Defines the content adjacency restrictions enforced during ad delivery.',
    `click_through_url` STRING COMMENT 'The destination URL to which users are redirected upon clicking the served ad creative. Must be validated and approved prior to trafficking. Critical for campaign performance tracking and landing page attribution.. Valid values are `^https?://.+`',
    `confirmed_timestamp` TIMESTAMP COMMENT 'Precise date and time when the ad server or media vendor confirmed receipt and acceptance of the trafficking instruction. Used for SLA compliance measurement and operational reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this trafficking instruction record was first created in the system. Provides the audit trail creation marker for data governance and lineage tracking.',
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

CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`ad_channel` (
    `ad_channel_id` BIGINT COMMENT 'Unique identifier for the advertising channel. Primary key for the ad_channel entity.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Each ad channel (TV, digital, OOH, radio) maps to a specific GL account for revenue and cost classification in financial statements. This channel-to-GL mapping is standard chart-of-accounts configurat',
    `taxonomy_id` BIGINT COMMENT 'Foreign key linking to audience.taxonomy. Business justification: Ad channel taxonomy standard selection: media planners must know which audience taxonomy standard (IAB, Nielsen, Comscore) a channel supports to correctly map audience segments for targeting activatio',
    `tech_partner_id` BIGINT COMMENT 'Foreign key linking to vendor.tech_partner. Business justification: Ad channels reference platform_name and dsp_seat_code as plain text. Linking to tech_partner normalizes the platform vendor relationship, enabling channel-level tech fee management, platform SLA track',
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

CREATE OR REPLACE TABLE `advertising_ecm`.`media`.`publisher_property` (
    `publisher_property_id` BIGINT COMMENT 'Unique identifier for the publisher property. Primary key.',
    `ad_channel_id` BIGINT COMMENT 'Foreign key linking to media.ad_channel. Business justification: A publisher property operates within a primary advertising channel (e.g., a website is a display/digital channel property, a TV network is a broadcast channel property, a podcast is an audio channel p',
    `segment_id` BIGINT COMMENT 'Foreign key linking to audience.audience_segment. Business justification: Publisher audience profiling: media planners select inventory based on publisher audience composition. The denormalized `audience_composition` text field should be replaced with a proper FK to the aud',
    `publisher_id` BIGINT COMMENT 'Reference to the publisher or media owner that operates this property.',
    `taxonomy_id` BIGINT COMMENT 'Foreign key linking to audience.taxonomy. Business justification: Inventory taxonomy classification: publisher properties are classified using audience taxonomy standards (IAB content categories) for targeting eligibility and audience-to-inventory matching. The deno',
    `ad_fraud_risk_score` DECIMAL(18,2) COMMENT 'The fraud risk score for this property (0-100 scale, where higher scores indicate higher fraud risk) based on invalid traffic (IVT) detection and TAG certification.',
    `ad_server_platform` STRING COMMENT 'The primary ad serving platform used by this property (e.g., Google Ad Manager, Freewheel, Xandr, Magnite).',
    `app_bundle_code` STRING COMMENT 'The platform-specific bundle identifier for mobile or CTV apps (e.g., com.example.app).',
    `app_store_code` STRING COMMENT 'The unique identifier for the mobile or CTV app in the app store (e.g., Apple App Store ID, Google Play Store ID, Roku Channel Store ID).',
    `average_cpm` DECIMAL(18,2) COMMENT 'The average Cost Per Mille (CPM) rate achieved for ad placements on this property over the past 90 days.',
    `brand_safety_classification` STRING COMMENT 'The brand safety tier or classification for this property based on content quality, adjacency risk, and third-party verification (e.g., TAG Certified, IAS/DV brand safety scores).. Valid values are `high_risk|medium_risk|low_risk|brand_safe|certified_safe`',
    `campaign_manager_site_code` STRING COMMENT 'The unique site identifier for this property in Google Campaign Manager 360 ad serving platform.',
    `content_vertical` STRING COMMENT 'The primary content category or vertical of the property (e.g., News, Sports, Entertainment, Finance, Lifestyle) per IAB Content Taxonomy.',
    `country_code` STRING COMMENT 'The primary country where this property operates, using ISO 3166-1 alpha-3 country code (e.g., USA, GBR, CAN).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this property record was first created in the system.',
    `currency_code` STRING COMMENT 'The currency used for pricing and billing for this property, using ISO 4217 three-letter currency code (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `floor_cpm` DECIMAL(18,2) COMMENT 'The minimum Cost Per Mille (CPM) rate accepted for ad placements on this property.',
    `geographic_coverage` STRING COMMENT 'The primary geographic markets or regions served by this property (e.g., USA National, New York DMA, EMEA, Global).',
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
    `ad_channel_id` BIGINT COMMENT 'Foreign key linking to media.ad_channel. Business justification: A placement position is defined within a specific advertising channel (display, video, social, OOH, etc.). The channel determines the technical specifications, trafficking requirements, and pricing mo',
    `publisher_property_id` BIGINT COMMENT 'Foreign key linking to media.publisher_property. Business justification: A placement position (e.g., homepage leaderboard, pre-roll slot) is physically located within a specific publisher property. This is the fundamental parent-child relationship: placement belongs to pub',
    CONSTRAINT pk_placement PRIMARY KEY(`placement_id`)
) COMMENT 'Defines specific ad placement positions within a publisher property and channel — e.g., homepage leaderboard, in-stream pre-roll, sidebar rectangle, sponsored post slot, or DOOH screen location. Captures placement-level attributes including position type, above/below-fold classification, viewability rate benchmarks, CPM floor pricing, audience reach, and platform-specific trafficking requirements for Google Campaign Manager 360 and The Trade Desk.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_ad_channel_id` FOREIGN KEY (`ad_channel_id`) REFERENCES `advertising_ecm`.`media`.`ad_channel`(`ad_channel_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ADD CONSTRAINT `fk_media_media_insertion_order_publisher_property_id` FOREIGN KEY (`publisher_property_id`) REFERENCES `advertising_ecm`.`media`.`publisher_property`(`publisher_property_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ADD CONSTRAINT `fk_media_plan_line_ad_channel_id` FOREIGN KEY (`ad_channel_id`) REFERENCES `advertising_ecm`.`media`.`ad_channel`(`ad_channel_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ADD CONSTRAINT `fk_media_plan_line_ad_format_id` FOREIGN KEY (`ad_format_id`) REFERENCES `advertising_ecm`.`media`.`ad_format`(`ad_format_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ADD CONSTRAINT `fk_media_plan_line_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ADD CONSTRAINT `fk_media_plan_line_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ADD CONSTRAINT `fk_media_plan_line_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `advertising_ecm`.`media`.`plan`(`plan_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ADD CONSTRAINT `fk_media_plan_line_programmatic_deal_id` FOREIGN KEY (`programmatic_deal_id`) REFERENCES `advertising_ecm`.`media`.`programmatic_deal`(`programmatic_deal_id`);
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ADD CONSTRAINT `fk_media_plan_line_publisher_property_id` FOREIGN KEY (`publisher_property_id`) REFERENCES `advertising_ecm`.`media`.`publisher_property`(`publisher_property_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ADD CONSTRAINT `fk_media_media_placement_ad_channel_id` FOREIGN KEY (`ad_channel_id`) REFERENCES `advertising_ecm`.`media`.`ad_channel`(`ad_channel_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ADD CONSTRAINT `fk_media_media_placement_ad_format_id` FOREIGN KEY (`ad_format_id`) REFERENCES `advertising_ecm`.`media`.`ad_format`(`ad_format_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ADD CONSTRAINT `fk_media_media_placement_placement_id` FOREIGN KEY (`placement_id`) REFERENCES `advertising_ecm`.`media`.`placement`(`placement_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ADD CONSTRAINT `fk_media_media_placement_media_catalog_placement_id` FOREIGN KEY (`media_catalog_placement_id`) REFERENCES `advertising_ecm`.`media`.`placement`(`placement_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ADD CONSTRAINT `fk_media_media_placement_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ADD CONSTRAINT `fk_media_media_placement_original_placement_media_placement_id` FOREIGN KEY (`original_placement_media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ADD CONSTRAINT `fk_media_media_placement_programmatic_deal_id` FOREIGN KEY (`programmatic_deal_id`) REFERENCES `advertising_ecm`.`media`.`programmatic_deal`(`programmatic_deal_id`);
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ADD CONSTRAINT `fk_media_media_placement_publisher_property_id` FOREIGN KEY (`publisher_property_id`) REFERENCES `advertising_ecm`.`media`.`publisher_property`(`publisher_property_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_ad_channel_id` FOREIGN KEY (`ad_channel_id`) REFERENCES `advertising_ecm`.`media`.`ad_channel`(`ad_channel_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_ad_format_id` FOREIGN KEY (`ad_format_id`) REFERENCES `advertising_ecm`.`media`.`ad_format`(`ad_format_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_plan_line_id` FOREIGN KEY (`plan_line_id`) REFERENCES `advertising_ecm`.`media`.`plan_line`(`plan_line_id`);
ALTER TABLE `advertising_ecm`.`media`.`buy` ADD CONSTRAINT `fk_media_buy_programmatic_deal_id` FOREIGN KEY (`programmatic_deal_id`) REFERENCES `advertising_ecm`.`media`.`programmatic_deal`(`programmatic_deal_id`);
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ADD CONSTRAINT `fk_media_programmatic_deal_ad_channel_id` FOREIGN KEY (`ad_channel_id`) REFERENCES `advertising_ecm`.`media`.`ad_channel`(`ad_channel_id`);
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ADD CONSTRAINT `fk_media_programmatic_deal_ad_format_id` FOREIGN KEY (`ad_format_id`) REFERENCES `advertising_ecm`.`media`.`ad_format`(`ad_format_id`);
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ADD CONSTRAINT `fk_media_programmatic_deal_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ADD CONSTRAINT `fk_media_programmatic_deal_publisher_property_id` FOREIGN KEY (`publisher_property_id`) REFERENCES `advertising_ecm`.`media`.`publisher_property`(`publisher_property_id`);
ALTER TABLE `advertising_ecm`.`media`.`schedule` ADD CONSTRAINT `fk_media_schedule_ad_channel_id` FOREIGN KEY (`ad_channel_id`) REFERENCES `advertising_ecm`.`media`.`ad_channel`(`ad_channel_id`);
ALTER TABLE `advertising_ecm`.`media`.`schedule` ADD CONSTRAINT `fk_media_schedule_ad_format_id` FOREIGN KEY (`ad_format_id`) REFERENCES `advertising_ecm`.`media`.`ad_format`(`ad_format_id`);
ALTER TABLE `advertising_ecm`.`media`.`schedule` ADD CONSTRAINT `fk_media_schedule_buy_id` FOREIGN KEY (`buy_id`) REFERENCES `advertising_ecm`.`media`.`buy`(`buy_id`);
ALTER TABLE `advertising_ecm`.`media`.`schedule` ADD CONSTRAINT `fk_media_schedule_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`media`.`schedule` ADD CONSTRAINT `fk_media_schedule_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`media`.`schedule` ADD CONSTRAINT `fk_media_schedule_plan_line_id` FOREIGN KEY (`plan_line_id`) REFERENCES `advertising_ecm`.`media`.`plan_line`(`plan_line_id`);
ALTER TABLE `advertising_ecm`.`media`.`schedule` ADD CONSTRAINT `fk_media_schedule_programmatic_deal_id` FOREIGN KEY (`programmatic_deal_id`) REFERENCES `advertising_ecm`.`media`.`programmatic_deal`(`programmatic_deal_id`);
ALTER TABLE `advertising_ecm`.`media`.`schedule` ADD CONSTRAINT `fk_media_schedule_trafficking_instruction_id` FOREIGN KEY (`trafficking_instruction_id`) REFERENCES `advertising_ecm`.`media`.`trafficking_instruction`(`trafficking_instruction_id`);
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ADD CONSTRAINT `fk_media_trafficking_instruction_ad_channel_id` FOREIGN KEY (`ad_channel_id`) REFERENCES `advertising_ecm`.`media`.`ad_channel`(`ad_channel_id`);
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ADD CONSTRAINT `fk_media_trafficking_instruction_ad_format_id` FOREIGN KEY (`ad_format_id`) REFERENCES `advertising_ecm`.`media`.`ad_format`(`ad_format_id`);
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ADD CONSTRAINT `fk_media_trafficking_instruction_buy_id` FOREIGN KEY (`buy_id`) REFERENCES `advertising_ecm`.`media`.`buy`(`buy_id`);
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ADD CONSTRAINT `fk_media_trafficking_instruction_media_insertion_order_id` FOREIGN KEY (`media_insertion_order_id`) REFERENCES `advertising_ecm`.`media`.`media_insertion_order`(`media_insertion_order_id`);
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ADD CONSTRAINT `fk_media_trafficking_instruction_media_placement_id` FOREIGN KEY (`media_placement_id`) REFERENCES `advertising_ecm`.`media`.`media_placement`(`media_placement_id`);
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ADD CONSTRAINT `fk_media_trafficking_instruction_parent_instruction_trafficking_instruction_id` FOREIGN KEY (`parent_instruction_trafficking_instruction_id`) REFERENCES `advertising_ecm`.`media`.`trafficking_instruction`(`trafficking_instruction_id`);
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ADD CONSTRAINT `fk_media_trafficking_instruction_plan_line_id` FOREIGN KEY (`plan_line_id`) REFERENCES `advertising_ecm`.`media`.`plan_line`(`plan_line_id`);
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ADD CONSTRAINT `fk_media_trafficking_instruction_programmatic_deal_id` FOREIGN KEY (`programmatic_deal_id`) REFERENCES `advertising_ecm`.`media`.`programmatic_deal`(`programmatic_deal_id`);
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ADD CONSTRAINT `fk_media_publisher_property_ad_channel_id` FOREIGN KEY (`ad_channel_id`) REFERENCES `advertising_ecm`.`media`.`ad_channel`(`ad_channel_id`);
ALTER TABLE `advertising_ecm`.`media`.`placement` ADD CONSTRAINT `fk_media_placement_ad_channel_id` FOREIGN KEY (`ad_channel_id`) REFERENCES `advertising_ecm`.`media`.`ad_channel`(`ad_channel_id`);
ALTER TABLE `advertising_ecm`.`media`.`placement` ADD CONSTRAINT `fk_media_placement_publisher_property_id` FOREIGN KEY (`publisher_property_id`) REFERENCES `advertising_ecm`.`media`.`publisher_property`(`publisher_property_id`);

-- ========= TAGS =========
ALTER SCHEMA `advertising_ecm`.`media` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `advertising_ecm`.`media` SET TAGS ('dbx_domain' = 'media');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` SET TAGS ('dbx_subdomain' = 'media_buying');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Media Insertion Order (IO) ID');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Channel Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `agency_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Relationship Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Master Contract ID');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan ID');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `publisher_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor / Publisher ID');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `publisher_property_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher Property Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_insertion_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Agency ID');
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
ALTER TABLE `advertising_ecm`.`media`.`plan` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan ID');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `agency_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Relationship Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `creative_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Brief Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `persona_id` SET TAGS ('dbx_business_glossary_term' = 'Persona Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`media`.`plan_line` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `plan_line_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Line ID');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Channel Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `ad_format_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Format Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `contract_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate Card Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `creative_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Brief Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Media Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan ID');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `programmatic_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Deal ID');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `publisher_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `publisher_property_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher Property Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`plan_line` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`media`.`media_placement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Media Placement ID');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Channel Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `ad_format_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Format Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `tech_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Server Tech Partner Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `contract_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate Card Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `placement_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Server Placement ID');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `media_catalog_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Placement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) ID');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `original_placement_media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Original Placement ID');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `programmatic_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Deal ID');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `publisher_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor / Publisher ID');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `publisher_property_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher Property Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Spec Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `above_fold_classification` SET TAGS ('dbx_business_glossary_term' = 'Above Fold Classification');
ALTER TABLE `advertising_ecm`.`media`.`media_placement` ALTER COLUMN `above_fold_classification` SET TAGS ('dbx_value_regex' = 'above_fold|below_fold|mixed|not_applicable');
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
ALTER TABLE `advertising_ecm`.`media`.`buy` SET TAGS ('dbx_subdomain' = 'media_buying');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `buy_id` SET TAGS ('dbx_business_glossary_term' = 'Media Buy ID');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Channel Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `ad_format_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Format Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `contract_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate Card Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) ID');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `plan_line_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Line ID');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `programmatic_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Deal Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`buy` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
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
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` SET TAGS ('dbx_subdomain' = 'media_buying');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `programmatic_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Media Programmatic Deal ID');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Channel Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `ad_format_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Format Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `tech_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Dsp Tech Partner Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Media Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `publisher_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher ID');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `publisher_property_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher Property Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Spec Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `negotiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deal Negotiated Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Deal Notes');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `rtb_bid_strategy` SET TAGS ('dbx_business_glossary_term' = 'Real-Time Bidding (RTB) Bid Strategy');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `rtb_bid_strategy` SET TAGS ('dbx_value_regex' = 'fixed_cpm|dynamic_cpm|target_cpa|target_roas|max_impressions');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `shopper_data_enabled` SET TAGS ('dbx_business_glossary_term' = 'Shopper Data Enabled Flag');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Deal Start Date');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`programmatic_deal` ALTER COLUMN `viewability_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Viewability Threshold Percentage');
ALTER TABLE `advertising_ecm`.`media`.`schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`media`.`schedule` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Media Schedule ID');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Channel Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `ad_format_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Format Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset ID');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `buy_id` SET TAGS ('dbx_business_glossary_term' = 'Buy Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) ID');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `plan_line_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `programmatic_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Deal ID');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `trafficking_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Instruction Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`schedule` ALTER COLUMN `vendor_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Rate Card Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` SET TAGS ('dbx_subdomain' = 'media_buying');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `trafficking_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Instruction ID');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Channel Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `ad_format_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Format Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset ID');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `buy_id` SET TAGS ('dbx_business_glossary_term' = 'Buy Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `creative_brief_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Brief Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order (IO) ID');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `parent_instruction_trafficking_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Trafficking Instruction ID');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `plan_line_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `programmatic_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Deal Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Spec Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `suppression_list_id` SET TAGS ('dbx_business_glossary_term' = 'Suppression List Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `tech_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Tech Partner Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `ad_server_placement_code` SET TAGS ('dbx_business_glossary_term' = 'Ad Server Placement Code');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `brand_safety_provider` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Provider');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `brand_safety_provider` SET TAGS ('dbx_value_regex' = 'DoubleVerify|Integral Ad Science|MOAT|Oracle Contextual|TAG|none');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `brand_safety_segment` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Segment');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `click_through_url` SET TAGS ('dbx_business_glossary_term' = 'Click-Through URL');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `click_through_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Instruction Confirmed Timestamp');
ALTER TABLE `advertising_ecm`.`media`.`trafficking_instruction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
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
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` SET TAGS ('dbx_subdomain' = 'placement_inventory');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Channel ID');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`ad_channel` ALTER COLUMN `tech_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Tech Partner Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` SET TAGS ('dbx_subdomain' = 'placement_inventory');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `publisher_property_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher Property ID');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Channel Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Audience Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `publisher_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher ID');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `ad_fraud_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Ad Fraud Risk Score');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `ad_server_platform` SET TAGS ('dbx_business_glossary_term' = 'Ad Server Platform');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `app_bundle_code` SET TAGS ('dbx_business_glossary_term' = 'App Bundle ID');
ALTER TABLE `advertising_ecm`.`media`.`publisher_property` ALTER COLUMN `app_store_code` SET TAGS ('dbx_business_glossary_term' = 'App Store ID');
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
ALTER TABLE `advertising_ecm`.`media`.`ad_format` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `advertising_ecm`.`media`.`ad_format` SET TAGS ('dbx_subdomain' = 'placement_inventory');
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
ALTER TABLE `advertising_ecm`.`media`.`placement` SET TAGS ('dbx_subdomain' = 'placement_inventory');
ALTER TABLE `advertising_ecm`.`media`.`placement` ALTER COLUMN `placement_id` SET TAGS ('dbx_business_glossary_term' = 'placement Identifier');
ALTER TABLE `advertising_ecm`.`media`.`placement` ALTER COLUMN `ad_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Channel Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`media`.`placement` ALTER COLUMN `publisher_property_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher Property Id (Foreign Key)');
